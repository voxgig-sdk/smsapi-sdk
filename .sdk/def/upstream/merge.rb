#!/usr/bin/env ruby
# Merge SMSAPI's two published OpenAPI documents into the one definition this
# SDK is generated from. Run from .sdk/def:   ruby upstream/merge.rb
#
# SMSAPI's reference (https://www.smsapi.com/rest/) loads services.json, which
# lists two documents for the same host, https://api.smsapi.com:
#   Panel     specifications/panel_com.yml
#   Contacts  specifications/contacts_com.yml
# apidef takes one definition, and an SDK covers its whole API, so both are
# merged. The rules, all mechanical:
#   - openapi, info, servers and security are Panel's, as published (Contacts
#     declares the same server and the same security requirement).
#   - paths are unioned; the two documents share none (checked below).
#   - components are unioned. A name both documents define IDENTICALLY is kept
#     once. A name they define DIFFERENTLY is kept as Panel's, and Contacts'
#     definition is renamed with the prefix "Contacts" and every $ref inside
#     the Contacts document rewritten to match. No other name changes.
#   - Contacts' top-level `host` and `schemes` are Swagger 2.0 keys with no
#     meaning in OpenAPI 3; they are dropped (servers carries the same URL).
# Nothing else is altered. The upstream files beside this script are byte for
# byte what SMSAPI served; do not edit them, re-download them.
require 'yaml'
require 'json'

here = File.dirname(__FILE__)
panel    = YAML.load_file(File.join(here, 'panel_com.yml'), aliases: true)
contacts = YAML.load_file(File.join(here, 'contacts_com.yml'), aliases: true)

clash = panel['paths'].keys & contacts['paths'].keys
abort "path clash: #{clash}" unless clash.empty?
abort 'server mismatch'   unless contacts['servers'].all? { |s| panel['servers'].include?(s) }
abort 'security mismatch' unless contacts['security'] == panel['security']

PREFIX = 'Contacts'
rename = {}
(contacts['components'] || {}).each do |kind, bag|
  next if kind == 'securitySchemes'
  pbag = (panel['components'] || {})[kind] || {}
  bag.each do |name, defn|
    next unless pbag.key?(name) && pbag[name] != defn
    rename["#/components/#{kind}/#{name}"] = "#/components/#{kind}/#{PREFIX}#{name}"
  end
end

rewrite = lambda do |node|
  case node
  when Hash
    node.each_with_object({}) do |(k, v), out|
      out[k] = (k == '$ref' && v.is_a?(String) && rename[v]) ? rename[v] : rewrite.(v)
    end
  when Array then node.map { |v| rewrite.(v) }
  else node
  end
end
contacts = rewrite.(contacts)

merged = {
  'openapi'  => panel['openapi'],
  'info'     => panel['info'],
  'servers'  => panel['servers'],
  'security' => panel['security'],
  'paths'    => panel['paths'].merge(contacts['paths']),
  'components' => {},
}
kinds = ((panel['components'] || {}).keys + (contacts['components'] || {}).keys).uniq
kinds.each do |kind|
  out = ((panel['components'] || {})[kind] || {}).dup
  ((contacts['components'] || {})[kind] || {}).each do |name, defn|
    key = rename["#/components/#{kind}/#{name}"] ? "#{PREFIX}#{name}" : name
    next if out.key?(key) && out[key] == defn
    abort "unexpected component clash #{kind}/#{key}" if out.key?(key)
    out[key] = defn
  end
  merged['components'][kind] = out
end

File.write(File.join(here, '..', 'smsapi-openapi.json'), JSON.pretty_generate(merged) + "\n")
ops = merged['paths'].values.sum { |v| v.keys.count { |k| %w[get put post delete patch head options].include?(k) } }
puts "smsapi-openapi.json: #{merged['paths'].size} paths, #{ops} operations, " \
     "#{merged['components']['schemas'].size} schemas; renamed: #{rename.keys.map { |r| r.split('/').last }.join(', ')}"
