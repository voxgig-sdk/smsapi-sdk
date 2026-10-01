// The canary sweep: every credential slot holds a distinctive value, every
// diagnostic feature this SDK ships is switched on with a capturing sink, a
// real operation runs through every outcome, and every string that leaves
// the SDK is searched for the canaries and their encoded forms. It also
// proves its own sensitivity: with clean switched off the canary MUST show.

const std = @import("std");
const sdk = @import("sdk");
const fh = @import("fh.zig");
const h = sdk.h;
const Value = sdk.Value;
const testing = std.testing;

fn vnull() Value {
    return Value{ .null = {} };
}

fn fmt(comptime f: []const u8, args: anytype) []const u8 {
    return std.fmt.allocPrint(h.A(), f, args) catch "";
}

// Generated: the credential's wire placement is fixed when the SDK is built.
const AUTH = .{
    .suppressed = false,
    .where = "header",
    .name = "authorization",
    .basic = false,
};

const CANARY_APIKEY = "CANARY-APIKEY-k9x2m7q4p1";
const CANARY_SECRET = "CANARY-SECRET-w3e8r5t2y6";
const CANARY_HEADER = "CANARY-HEADER-z1x4c7v0b3";
const CANARY_VALUE = "CANARY-VALUE-n5m8b2v9c4";

const MASK = "[redacted]";

fn base64_std(text: []const u8) []const u8 {
    const enc = std.base64.standard.Encoder;
    const buf = h.A().alloc(u8, enc.calcSize(text.len)) catch return "";
    return enc.encode(buf, text);
}

// Every form a canary can travel in.
fn forms() [][]const u8 {
    var out: std.ArrayList([]const u8) = .empty;
    for ([_][]const u8{ CANARY_APIKEY, CANARY_SECRET, CANARY_HEADER, CANARY_VALUE }) |v| {
        out.append(h.A(), v) catch {};
        out.append(h.A(), base64_std(v)) catch {};
        out.append(h.A(), h.esc_url(v)) catch {};
    }
    out.append(h.A(), base64_std(fmt("{s}:{s}", .{ CANARY_APIKEY, CANARY_SECRET }))) catch {};
    return out.toOwnedSlice(h.A()) catch &.{};
}

const Surface = struct { name: []const u8, text: []const u8 };

const Sinks = struct {
    items: std.ArrayList(Surface) = .empty,

    fn push(self: *Sinks, name: []const u8, text: []const u8) void {
        self.items.append(h.A(), .{ .name = name, .text = text }) catch {};
    }

    // A record's JSON, and its stringified form.
    fn value(self: *Sinks, name: []const u8, v: Value) void {
        self.push(fmt("{s}:json", .{name}), h.jsonify_compact(v));
        self.push(fmt("{s}:string", .{name}), h.stringify(v));
    }

    fn err(self: *Sinks, name: []const u8, e: *sdk.h.SdkError) void {
        self.push(fmt("{s}:msg", .{name}), e.msg);
        self.push(fmt("{s}:format", .{name}), fmt("{f}", .{e.*}));
        self.push(fmt("{s}:json", .{name}), e.to_json());
        self.push(fmt("{s}:spec", .{name}), h.jsonify_compact(e.spec));
        self.push(fmt("{s}:result", .{name}), h.jsonify_compact(e.result));
    }

    fn ctx(self: *Sinks, name: []const u8, c: *sdk.Context) void {
        self.push(fmt("{s}:json", .{name}), c.to_json());
        self.push(fmt("{s}:format", .{name}), fmt("{f}", .{c.*}));
    }
};

// A sink callback (audit sink, telemetry exporter, debug onEntry, cost sink)
// that records each record's forms under its name.
const Capture = struct {
    sinks: *Sinks,
    name: []const u8,

    fn call(p: *anyopaque, _: std.mem.Allocator, arg: Value) anyerror!Value {
        const self: *Capture = @ptrCast(@alignCast(p));
        self.sinks.value(self.name, arg);
        return vnull();
    }

    fn make(sinks: *Sinks, name: []const u8) Value {
        const s = h.A().create(Capture) catch unreachable;
        s.* = .{ .sinks = sinks, .name = name };
        return h.callable(@ptrCast(s), call);
    }
};

// Captures the serialised context from inside the pipeline: what a hook
// author would hand to a logger.
const CaptureFeature = struct {
    name: []const u8 = "capture",
    sinks: *Sinks,

    fn make(sinks: *Sinks) sdk.Feature {
        const self = h.A().create(CaptureFeature) catch unreachable;
        self.* = .{ .sinks = sinks };
        return .{ .ptr = @ptrCast(self), .vtable = &vtable };
    }
    fn self_of(p: *anyopaque) *CaptureFeature {
        return @ptrCast(@alignCast(p));
    }
    fn vname(p: *anyopaque) []const u8 {
        return self_of(p).name;
    }
    fn vactive(_: *anyopaque) bool {
        return true;
    }
    fn vaddopts(_: *anyopaque) Value {
        return vnull();
    }
    fn vinit(_: *anyopaque, _: *sdk.Context, _: Value) void {}
    fn vdispatch(p: *anyopaque, hook: []const u8, c: *sdk.Context) void {
        const self = self_of(p);
        if (std.mem.eql(u8, hook, "PreRequest") or
            std.mem.eql(u8, hook, "PreResponse") or
            std.mem.eql(u8, hook, "PreUnexpected"))
        {
            self.sinks.ctx(fmt("ctx@{s}", .{hook}), c);
        }
    }
    const vtable = sdk.Feature.VTable{
        .name = vname,
        .active = vactive,
        .add_options = vaddopts,
        .init = vinit,
        .dispatch = vdispatch,
    };
};

// A feature that fails the operation from inside the pipeline, quoting the
// request it saw. A zig hook has no error return, so it fails the result:
// an error make_error receives from a hook, not from the pipeline. For the
// same reason there is no variant failing in PreUnexpected: make_error has
// built and cleaned the error it returns before that hook runs.
const ThrowFeature = struct {
    var instance: u8 = 0;

    fn make() sdk.Feature {
        return .{ .ptr = @ptrCast(&instance), .vtable = &vtable };
    }
    fn vname(_: *anyopaque) []const u8 {
        return "throwhook";
    }
    fn vactive(_: *anyopaque) bool {
        return true;
    }
    fn vaddopts(_: *anyopaque) Value {
        return vnull();
    }
    fn vinit(_: *anyopaque, _: *sdk.Context, _: Value) void {}
    fn vdispatch(_: *anyopaque, hook: []const u8, c: *sdk.Context) void {
        if (!std.mem.eql(u8, hook, "PreResponse")) return;
        const res = c.result orelse return;
        const spec: Value = if (c.spec) |sp| sp.to_value() else vnull();
        res.err = c.make_error("hook", fmt("hook saw {s}", .{h.jsonify_compact(spec)}));
    }
    const vtable = sdk.Feature.VTable{
        .name = vname,
        .active = vactive,
        .add_options = vaddopts,
        .init = vinit,
        .dispatch = vdispatch,
    };
};

// A stream that succeeds, so the pipeline's terminal step never runs. A zig
// stream producer has no error channel, so no stream fails.
const StreamOkFeature = struct {
    var instance: u8 = 0;

    fn make() sdk.Feature {
        return .{ .ptr = @ptrCast(&instance), .vtable = &vtable };
    }
    fn vname(_: *anyopaque) []const u8 {
        return "streamok";
    }
    fn vactive(_: *anyopaque) bool {
        return true;
    }
    fn vaddopts(_: *anyopaque) Value {
        return vnull();
    }
    fn vinit(_: *anyopaque, _: *sdk.Context, _: Value) void {}
    fn items(p: *anyopaque) []Value {
        const res: *sdk.SdkResult = @ptrCast(@alignCast(p));
        return switch (res.resdata) {
            .array => |l| l.data.items,
            .null => &.{},
            else => blk: {
                const one = h.A().alloc(Value, 1) catch break :blk &.{};
                one[0] = res.resdata;
                break :blk one;
            },
        };
    }
    fn vdispatch(_: *anyopaque, hook: []const u8, c: *sdk.Context) void {
        if (!std.mem.eql(u8, hook, "PreDone")) return;
        const res = c.result orelse return;
        res.stream = .{ .ctx = @ptrCast(res), .call = items };
    }
    const vtable = sdk.Feature.VTable{
        .name = vname,
        .active = vactive,
        .add_options = vaddopts,
        .init = vinit,
        .dispatch = vdispatch,
    };
};

// A feature that refuses the operation with the SDK's own error, as rbac
// does, whose code quotes a registered value; it records the error
// PreUnexpected hands a hook.
const DenyFeature = struct {
    sinks: *Sinks,

    fn make(sinks: *Sinks) sdk.Feature {
        const self = h.A().create(DenyFeature) catch unreachable;
        self.* = .{ .sinks = sinks };
        return .{ .ptr = @ptrCast(self), .vtable = &vtable };
    }
    fn self_of(p: *anyopaque) *DenyFeature {
        return @ptrCast(@alignCast(p));
    }
    fn vname(_: *anyopaque) []const u8 {
        return "denyhook";
    }
    fn vactive(_: *anyopaque) bool {
        return true;
    }
    fn vaddopts(_: *anyopaque) Value {
        return vnull();
    }
    fn vinit(_: *anyopaque, _: *sdk.Context, _: Value) void {}
    fn vdispatch(p: *anyopaque, hook: []const u8, c: *sdk.Context) void {
        if (std.mem.eql(u8, hook, "PrePoint")) {
            const e = c.make_error(fmt("denied:{s}", .{CANARY_VALUE}), "denied");
            c.out_set("point", sdk.OutVal{ .err = e });
        } else if (std.mem.eql(u8, hook, "PreUnexpected")) {
            if (c.ctrl.err) |e| self_of(p).sinks.err("error", e);
        }
    }
    const vtable = sdk.Feature.VTable{
        .name = vname,
        .active = vactive,
        .add_options = vaddopts,
        .init = vinit,
        .dispatch = vdispatch,
    };
};

// ---- scenarios: what the transport answers ------------------------------

const Scenario = enum { ok, notfound, server, transport, notjson };

fn response(status: i64, data: Value, headers: Value) Value {
    const hh = h.omap();
    h.setp(hh, "content-type", h.vstr("application/json"));
    if (headers == .object) {
        var it = headers.object.iterator();
        while (it.next()) |kv| h.setp(hh, kv.key_ptr.*, kv.value_ptr.*);
    }
    return h.jo(&.{
        .{ "status", h.vnum(status) },
        .{ "statusText", h.vstr(if (status < 400) "OK" else "ERR") },
        .{ "headers", hh },
        .{ "json", h.json_thunk(data) },
        .{ "body", h.vstr(h.jsonify_compact(data)) },
    });
}

fn notJsonThunk(_: *anyopaque, _: std.mem.Allocator, _: Value) anyerror!Value {
    return error.NotJson;
}
var notjson_dummy: u8 = 0;

// The system.fetch seam: (url, fetchdef) -> transport-shaped response, or a
// map carrying __err__ for a transport failure.
const Transport = struct {
    scenario: Scenario,

    fn call(p: *anyopaque, _: std.mem.Allocator, arg: Value) anyerror!Value {
        const self: *Transport = @ptrCast(@alignCast(p));
        const url = h.scalar_str(h.get_elem(arg, h.vnum(0), vnull()));
        return switch (self.scenario) {
            .ok => response(200, h.jo(&.{ .{ "id", h.vstr("i1") }, .{ "name", h.vstr("n1") } }),
                h.jo(&.{.{ "x-session-token", h.vstr("RESP-TOKEN-a1b2c3d4e5") }})),
            .notfound => response(404, h.jo(&.{.{ "error", h.vstr("no such record") }}), vnull()),
            .server => response(500, h.jo(&.{.{ "error", h.vstr("boom") }}), vnull()),
            .transport => h.jo(&.{.{ "__err__", h.vstr(fmt("socket hang up (URL was: \"{s}\")", .{url})) }}),
            .notjson => h.jo(&.{
                .{ "status", h.vnum(200) },
                .{ "statusText", h.vstr("OK") },
                .{ "headers", h.omap() },
                .{ "json", h.callable(@ptrCast(&notjson_dummy), notJsonThunk) },
                .{ "body", h.vstr("<html>") },
            }),
        };
    }

    fn make(scenario: Scenario) Value {
        const s = h.A().create(Transport) catch unreachable;
        s.* = .{ .scenario = scenario };
        return h.callable(@ptrCast(s), call);
    }
};

fn makeSdk(scenario: Scenario, sinks: *Sinks, clean_active: bool, extra: ?sdk.Feature) *sdk.SDK {
    const feature = h.omap();
    if (fh.fh_has_feature("log")) h.setp(feature, "log", h.jo(&.{.{ "active", h.vbool(true) }}));
    if (fh.fh_has_feature("debug")) h.setp(feature, "debug", h.jo(&.{
        .{ "active", h.vbool(true) },
        .{ "onEntry", Capture.make(sinks, "debug") },
    }));
    if (fh.fh_has_feature("audit")) h.setp(feature, "audit", h.jo(&.{
        .{ "active", h.vbool(true) },
        .{ "sink", Capture.make(sinks, "audit") },
    }));
    if (fh.fh_has_feature("telemetry")) h.setp(feature, "telemetry", h.jo(&.{
        .{ "active", h.vbool(true) },
        .{ "exporter", Capture.make(sinks, "telemetry") },
    }));
    if (fh.fh_has_feature("cost")) h.setp(feature, "cost", h.jo(&.{
        .{ "active", h.vbool(true) },
        .{ "sink", Capture.make(sinks, "cost") },
    }));
    if (fh.fh_has_feature("metrics")) h.setp(feature, "metrics", h.jo(&.{.{ "active", h.vbool(true) }}));
    if (fh.fh_has_feature("clienttrack")) h.setp(feature, "clienttrack", h.jo(&.{.{ "active", h.vbool(true) }}));

    const clean = h.jo(&.{.{ "values", h.vstr(CANARY_VALUE) }});
    if (!clean_active) h.setp(clean, "active", h.vbool(false));

    const options = h.jo(&.{
        .{ "apikey", h.vstr(CANARY_APIKEY) },
        .{ "secret", h.vstr(CANARY_SECRET) },
        .{ "headers", h.jo(&.{.{ "X-Custom-Token", h.vstr(CANARY_HEADER) }}) },
        .{ "clean", clean },
        .{ "feature", feature },
        .{ "system", h.jo(&.{.{ "fetch", Transport.make(scenario) }}) },
    });

    if (extra) |f| return sdk.SDK.new_with(options, &.{ CaptureFeature.make(sinks), f });
    return sdk.SDK.new_with(options, &.{CaptureFeature.make(sinks)});
}

// ---- the candidate operations, from the model ---------------------------

const Outcome = struct {
    ok: bool,
    err: ?*sdk.h.SdkError,
    result: Value,
};

const Candidate = *const fn (client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome;
const Streamer = *const fn (client: *sdk.SDK, mtch: Value, callopts: Value) []Value;

fn try_available_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.available(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_blacklist_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.blacklist(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_blacklist_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.blacklist(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_blacklist_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.blacklist(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_callback_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.callback(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_callback_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.callback(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_callback_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.callback(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_callback_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.callback(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_callback_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.callback(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contact_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contact(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contact_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contact(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contact_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contact(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contact_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contact(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contact_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contact(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contacts_field_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contacts_field(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contacts_field_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contacts_field(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contacts_field_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contacts_field(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contacts_field_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contacts_field(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contacts_field_option_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contacts_field_option(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactsgroup_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactsgroup(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactsgroup_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactsgroup(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactsgroup_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactsgroup(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactsgroup_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactsgroup(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactstrash_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactstrash(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_contactstrash_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.contactstrash(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_field_available_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.field_available(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_group_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.group(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_group_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.group(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_mfa_code_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.mfa_code(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_opt_out_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.opt_out(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_opt_out_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.opt_out(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_opt_out_setting_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.opt_out_setting(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_opt_out_setting_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.opt_out_setting(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_permission_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.permission(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_permission_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.permission(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_ping_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.ping(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_profile_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.profile(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_profile_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.profile(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_rcs_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.rcs(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_sendername_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.sendername(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_sendername_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.sendername(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_sendername_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.sendername(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_sendername_statement_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.sendername_statement(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_sent_rcs_message_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.sent_rcs_message(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_shipment_country_volume_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.shipment_country_volume(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_short_url_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.short_url(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_short_url_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.short_url(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_short_url_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.short_url(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_short_url_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.short_url(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_short_url_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.short_url(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_smsdo_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.smsdo(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_smssendername_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.smssendername(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_smssendername_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.smssendername(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_smstemplate_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.smstemplate(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_subuser_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.subuser(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_subuser_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.subuser(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_subuser_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.subuser(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_subuser_remove(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.subuser(vnull()).remove(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_subuser_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.subuser(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_template_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.template(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_template_load(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.template(vnull()).load(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_template_create(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.template(vnull()).create(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_template_update(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.template(vnull()).update(mtch, ctrl)) {
        .ok => |ent| return .{ .ok = true, .err = null, .result = ent.asEntity().data(null) },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn try_user_rcs_sender_collection_list(client: *sdk.SDK, mtch: Value, ctrl: Value) Outcome {
    switch (client.user_rcs_sender_collection(vnull()).list(mtch, ctrl)) {
        .ok => |ents| {
            const records = h.olist();
            for (ents) |e| records.array.append(e.asEntity().data(null)) catch {};
            return .{ .ok = true, .err = null, .result = records };
        },
        .err => |e| return .{ .ok = false, .err = e, .result = vnull() },
    }
}

fn stream_available_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.available(vnull()).stream("list", mtch, callopts);
}

fn stream_blacklist_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.blacklist(vnull()).stream("load", mtch, callopts);
}

fn stream_blacklist_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.blacklist(vnull()).stream("create", mtch, callopts);
}

fn stream_blacklist_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.blacklist(vnull()).stream("remove", mtch, callopts);
}

fn stream_callback_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.callback(vnull()).stream("list", mtch, callopts);
}

fn stream_callback_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.callback(vnull()).stream("load", mtch, callopts);
}

fn stream_callback_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.callback(vnull()).stream("create", mtch, callopts);
}

fn stream_callback_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.callback(vnull()).stream("remove", mtch, callopts);
}

fn stream_callback_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.callback(vnull()).stream("update", mtch, callopts);
}

fn stream_contact_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contact(vnull()).stream("list", mtch, callopts);
}

fn stream_contact_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contact(vnull()).stream("load", mtch, callopts);
}

fn stream_contact_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contact(vnull()).stream("create", mtch, callopts);
}

fn stream_contact_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contact(vnull()).stream("remove", mtch, callopts);
}

fn stream_contact_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contact(vnull()).stream("update", mtch, callopts);
}

fn stream_contacts_field_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contacts_field(vnull()).stream("list", mtch, callopts);
}

fn stream_contacts_field_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contacts_field(vnull()).stream("create", mtch, callopts);
}

fn stream_contacts_field_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contacts_field(vnull()).stream("remove", mtch, callopts);
}

fn stream_contacts_field_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contacts_field(vnull()).stream("update", mtch, callopts);
}

fn stream_contacts_field_option_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contacts_field_option(vnull()).stream("list", mtch, callopts);
}

fn stream_contactsgroup_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactsgroup(vnull()).stream("list", mtch, callopts);
}

fn stream_contactsgroup_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactsgroup(vnull()).stream("create", mtch, callopts);
}

fn stream_contactsgroup_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactsgroup(vnull()).stream("remove", mtch, callopts);
}

fn stream_contactsgroup_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactsgroup(vnull()).stream("update", mtch, callopts);
}

fn stream_contactstrash_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactstrash(vnull()).stream("remove", mtch, callopts);
}

fn stream_contactstrash_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.contactstrash(vnull()).stream("update", mtch, callopts);
}

fn stream_field_available_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.field_available(vnull()).stream("list", mtch, callopts);
}

fn stream_group_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.group(vnull()).stream("load", mtch, callopts);
}

fn stream_group_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.group(vnull()).stream("update", mtch, callopts);
}

fn stream_mfa_code_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.mfa_code(vnull()).stream("create", mtch, callopts);
}

fn stream_opt_out_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.opt_out(vnull()).stream("list", mtch, callopts);
}

fn stream_opt_out_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.opt_out(vnull()).stream("remove", mtch, callopts);
}

fn stream_opt_out_setting_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.opt_out_setting(vnull()).stream("load", mtch, callopts);
}

fn stream_opt_out_setting_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.opt_out_setting(vnull()).stream("update", mtch, callopts);
}

fn stream_permission_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.permission(vnull()).stream("load", mtch, callopts);
}

fn stream_permission_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.permission(vnull()).stream("create", mtch, callopts);
}

fn stream_ping_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.ping(vnull()).stream("list", mtch, callopts);
}

fn stream_profile_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.profile(vnull()).stream("list", mtch, callopts);
}

fn stream_profile_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.profile(vnull()).stream("load", mtch, callopts);
}

fn stream_rcs_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.rcs(vnull()).stream("list", mtch, callopts);
}

fn stream_sendername_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.sendername(vnull()).stream("list", mtch, callopts);
}

fn stream_sendername_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.sendername(vnull()).stream("load", mtch, callopts);
}

fn stream_sendername_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.sendername(vnull()).stream("create", mtch, callopts);
}

fn stream_sendername_statement_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.sendername_statement(vnull()).stream("list", mtch, callopts);
}

fn stream_sent_rcs_message_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.sent_rcs_message(vnull()).stream("create", mtch, callopts);
}

fn stream_shipment_country_volume_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.shipment_country_volume(vnull()).stream("list", mtch, callopts);
}

fn stream_short_url_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.short_url(vnull()).stream("list", mtch, callopts);
}

fn stream_short_url_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.short_url(vnull()).stream("load", mtch, callopts);
}

fn stream_short_url_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.short_url(vnull()).stream("create", mtch, callopts);
}

fn stream_short_url_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.short_url(vnull()).stream("remove", mtch, callopts);
}

fn stream_short_url_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.short_url(vnull()).stream("update", mtch, callopts);
}

fn stream_smsdo_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.smsdo(vnull()).stream("create", mtch, callopts);
}

fn stream_smssendername_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.smssendername(vnull()).stream("create", mtch, callopts);
}

fn stream_smssendername_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.smssendername(vnull()).stream("remove", mtch, callopts);
}

fn stream_smstemplate_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.smstemplate(vnull()).stream("remove", mtch, callopts);
}

fn stream_subuser_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.subuser(vnull()).stream("list", mtch, callopts);
}

fn stream_subuser_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.subuser(vnull()).stream("load", mtch, callopts);
}

fn stream_subuser_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.subuser(vnull()).stream("create", mtch, callopts);
}

fn stream_subuser_remove(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.subuser(vnull()).stream("remove", mtch, callopts);
}

fn stream_subuser_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.subuser(vnull()).stream("update", mtch, callopts);
}

fn stream_template_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.template(vnull()).stream("list", mtch, callopts);
}

fn stream_template_load(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.template(vnull()).stream("load", mtch, callopts);
}

fn stream_template_create(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.template(vnull()).stream("create", mtch, callopts);
}

fn stream_template_update(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.template(vnull()).stream("update", mtch, callopts);
}

fn stream_user_rcs_sender_collection_list(client: *sdk.SDK, mtch: Value, callopts: Value) []Value {
    return client.user_rcs_sender_collection(vnull()).stream("list", mtch, callopts);
}

const CandidateDef = struct { run: Candidate, stream: Streamer, params: []const []const u8 };

// Generated: every CRUD operation of every active entity, with the path
// parameters its points declare.
const CANDIDATES = [_]CandidateDef{
    .{ .run = try_available_list, .stream = stream_available_list, .params = &.{} },
    .{ .run = try_blacklist_load, .stream = stream_blacklist_load, .params = &.{} },
    .{ .run = try_blacklist_create, .stream = stream_blacklist_create, .params = &.{} },
    .{ .run = try_blacklist_remove, .stream = stream_blacklist_remove, .params = &.{"id"} },
    .{ .run = try_callback_list, .stream = stream_callback_list, .params = &.{} },
    .{ .run = try_callback_load, .stream = stream_callback_load, .params = &.{"id"} },
    .{ .run = try_callback_create, .stream = stream_callback_create, .params = &.{} },
    .{ .run = try_callback_remove, .stream = stream_callback_remove, .params = &.{"id"} },
    .{ .run = try_callback_update, .stream = stream_callback_update, .params = &.{"id"} },
    .{ .run = try_contact_list, .stream = stream_contact_list, .params = &.{"id"} },
    .{ .run = try_contact_load, .stream = stream_contact_load, .params = &.{"contact_id", "group_id", "id"} },
    .{ .run = try_contact_create, .stream = stream_contact_create, .params = &.{"id"} },
    .{ .run = try_contact_remove, .stream = stream_contact_remove, .params = &.{"group_id", "id"} },
    .{ .run = try_contact_update, .stream = stream_contact_update, .params = &.{"contact_id", "group_id", "id"} },
    .{ .run = try_contacts_field_list, .stream = stream_contacts_field_list, .params = &.{} },
    .{ .run = try_contacts_field_create, .stream = stream_contacts_field_create, .params = &.{} },
    .{ .run = try_contacts_field_remove, .stream = stream_contacts_field_remove, .params = &.{"id"} },
    .{ .run = try_contacts_field_update, .stream = stream_contacts_field_update, .params = &.{"id"} },
    .{ .run = try_contacts_field_option_list, .stream = stream_contacts_field_option_list, .params = &.{"field_id"} },
    .{ .run = try_contactsgroup_list, .stream = stream_contactsgroup_list, .params = &.{"group_id"} },
    .{ .run = try_contactsgroup_create, .stream = stream_contactsgroup_create, .params = &.{"group_id"} },
    .{ .run = try_contactsgroup_remove, .stream = stream_contactsgroup_remove, .params = &.{"contact_id", "group_id", "username"} },
    .{ .run = try_contactsgroup_update, .stream = stream_contactsgroup_update, .params = &.{"group_id", "username"} },
    .{ .run = try_contactstrash_remove, .stream = stream_contactstrash_remove, .params = &.{} },
    .{ .run = try_contactstrash_update, .stream = stream_contactstrash_update, .params = &.{} },
    .{ .run = try_field_available_list, .stream = stream_field_available_list, .params = &.{} },
    .{ .run = try_group_load, .stream = stream_group_load, .params = &.{"id"} },
    .{ .run = try_group_update, .stream = stream_group_update, .params = &.{"id"} },
    .{ .run = try_mfa_code_create, .stream = stream_mfa_code_create, .params = &.{} },
    .{ .run = try_opt_out_list, .stream = stream_opt_out_list, .params = &.{} },
    .{ .run = try_opt_out_remove, .stream = stream_opt_out_remove, .params = &.{"id"} },
    .{ .run = try_opt_out_setting_load, .stream = stream_opt_out_setting_load, .params = &.{} },
    .{ .run = try_opt_out_setting_update, .stream = stream_opt_out_setting_update, .params = &.{} },
    .{ .run = try_permission_load, .stream = stream_permission_load, .params = &.{"group_id", "id"} },
    .{ .run = try_permission_create, .stream = stream_permission_create, .params = &.{"group_id"} },
    .{ .run = try_ping_list, .stream = stream_ping_list, .params = &.{} },
    .{ .run = try_profile_list, .stream = stream_profile_list, .params = &.{} },
    .{ .run = try_profile_load, .stream = stream_profile_load, .params = &.{} },
    .{ .run = try_rcs_list, .stream = stream_rcs_list, .params = &.{} },
    .{ .run = try_sendername_list, .stream = stream_sendername_list, .params = &.{} },
    .{ .run = try_sendername_load, .stream = stream_sendername_load, .params = &.{"id"} },
    .{ .run = try_sendername_create, .stream = stream_sendername_create, .params = &.{} },
    .{ .run = try_sendername_statement_list, .stream = stream_sendername_statement_list, .params = &.{} },
    .{ .run = try_sent_rcs_message_create, .stream = stream_sent_rcs_message_create, .params = &.{} },
    .{ .run = try_shipment_country_volume_list, .stream = stream_shipment_country_volume_list, .params = &.{} },
    .{ .run = try_short_url_list, .stream = stream_short_url_list, .params = &.{} },
    .{ .run = try_short_url_load, .stream = stream_short_url_load, .params = &.{"id"} },
    .{ .run = try_short_url_create, .stream = stream_short_url_create, .params = &.{} },
    .{ .run = try_short_url_remove, .stream = stream_short_url_remove, .params = &.{"id"} },
    .{ .run = try_short_url_update, .stream = stream_short_url_update, .params = &.{"id"} },
    .{ .run = try_smsdo_create, .stream = stream_smsdo_create, .params = &.{} },
    .{ .run = try_smssendername_create, .stream = stream_smssendername_create, .params = &.{"sendername_id"} },
    .{ .run = try_smssendername_remove, .stream = stream_smssendername_remove, .params = &.{"sender"} },
    .{ .run = try_smstemplate_remove, .stream = stream_smstemplate_remove, .params = &.{"id"} },
    .{ .run = try_subuser_list, .stream = stream_subuser_list, .params = &.{"id"} },
    .{ .run = try_subuser_load, .stream = stream_subuser_load, .params = &.{"id"} },
    .{ .run = try_subuser_create, .stream = stream_subuser_create, .params = &.{} },
    .{ .run = try_subuser_remove, .stream = stream_subuser_remove, .params = &.{"id"} },
    .{ .run = try_subuser_update, .stream = stream_subuser_update, .params = &.{"id"} },
    .{ .run = try_template_list, .stream = stream_template_list, .params = &.{} },
    .{ .run = try_template_load, .stream = stream_template_load, .params = &.{"id"} },
    .{ .run = try_template_create, .stream = stream_template_create, .params = &.{} },
    .{ .run = try_template_update, .stream = stream_template_update, .params = &.{"id"} },
    .{ .run = try_user_rcs_sender_collection_list, .stream = stream_user_rcs_sender_collection_list, .params = &.{} },
};

const Target = struct { run: Candidate, stream: Streamer, mtch: Value };

// The first operation that completes against a plain 200: with no
// arguments, else with every path parameter its points declare filled in.
fn usableOp() ?Target {
    for (CANDIDATES) |cand| {
        const filled = h.omap();
        for (cand.params) |p| h.setp(filled, p, h.vstr("p1"));
        for ([_]Value{ h.omap(), filled }) |mtch| {
            const plain = sdk.SDK.new(h.jo(&.{
                .{ "apikey", h.vstr(CANARY_APIKEY) },
                .{ "system", h.jo(&.{.{ "fetch", Transport.make(.ok) }}) },
            }));
            if (cand.run(plain, h.clone(mtch), h.omap()).ok) {
                return .{ .run = cand.run, .stream = cand.stream, .mtch = mtch };
            }
        }
    }
    return null;
}

const NOTHING_TO_SWEEP = "SKIP: no operation of this SDK completes against a plain 200; nothing to sweep\n";

fn drive(client: *sdk.SDK, target: Target, ctrl: Value, sinks: *Sinks) ?*sdk.h.SdkError {
    // A caller may keep the record it passed rather than read ctrl.explain.
    const held = h.getp(ctrl, "explain");
    const out = target.run(client, h.clone(target.mtch), ctrl);
    if (out.err) |e| sinks.err("error", e);
    if (out.ok) sinks.value("result", out.result);
    const explain = h.getp(ctrl, "explain");
    if (explain == .object) sinks.value("explain", explain);
    if (held == .object and (explain != .object or held.object != explain.object)) {
        sinks.value("explain:held", held);
    }
    return out.err;
}

fn leaks(text: []const u8) [][]const u8 {
    var found: std.ArrayList([]const u8) = .empty;
    for (forms()) |f| {
        if (std.mem.indexOf(u8, text, f) != null) found.append(h.A(), f) catch {};
    }
    return found.toOwnedSlice(h.A()) catch &.{};
}

// Header maps keep the caller's spelling; the assertion should not care.
fn header(map: Value, name: []const u8) ?[]const u8 {
    if (map != .object) return null;
    var it = map.object.iterator();
    while (it.next()) |kv| {
        if (std.ascii.eqlIgnoreCase(kv.key_ptr.*, name)) {
            return switch (kv.value_ptr.*) {
                .string => |s| s,
                else => null,
            };
        }
    }
    return null;
}

const Variant = enum { throw, explain, nothrow };

fn ctrlFor(v: Variant) Value {
    return switch (v) {
        .throw => h.omap(),
        .explain => h.jo(&.{.{ "explain", h.omap() }}),
        .nothrow => h.jo(&.{ .{ "throw", h.vbool(false) }, .{ "explain", h.omap() } }),
    };
}

test "clean: no credential leaves the SDK in any form" {
    const target = usableOp() orelse {
        std.debug.print(NOTHING_TO_SWEEP, .{});
        return error.SkipZigTest;
    };

    var sinks = Sinks{};
    var notfound: ?*sdk.h.SdkError = null;
    var explained: Value = vnull();

    for ([_]Scenario{ .ok, .notfound, .server, .transport, .notjson }) |scenario| {
        for ([_]Variant{ .throw, .explain, .nothrow }) |variant| {
            const client = makeSdk(scenario, &sinks, true, null);
            const ctrl = ctrlFor(variant);
            const err = drive(client, target, ctrl, &sinks);
            if (scenario == .notfound and variant == .throw) notfound = err;
            if (scenario == .ok and variant == .explain) explained = h.getp(ctrl, "explain");
        }
    }

    // A credential mistyped as a map. The zig validator's failure is not
    // raised (make_options keeps its input), so what the constructor produced
    // is swept instead: a string quoting the value, cleaned the way a
    // validation message is.
    const mistyped = sdk.SDK.new(h.jo(&.{
        .{ "apikey", h.jo(&.{.{ "value", h.vstr(CANARY_APIKEY) }}) },
        .{ "clean", h.jo(&.{.{ "values", h.vstr(CANARY_VALUE) }}) },
    }));
    sinks.push("mistyped:quoted", sdk.utilmod.clean_str_util(
        mistyped.get_root_ctx(),
        fmt("apikey: expected string, got {{\"value\":\"{s}\"}}", .{CANARY_APIKEY}),
    ));

    // An error a feature hook raises, quoting the request, with explain on.
    const hooked = makeSdk(.ok, &sinks, true, ThrowFeature.make());
    const hookerr = drive(hooked, target, h.jo(&.{.{ "explain", h.omap() }}), &sinks);
    try testing.expect(hookerr != null);

    // The explain record a stream call is passed is cleaned however the
    // stream ends: from a feature's producer, or materialised by done. A zig
    // stream hands no error back, so the record is what is asserted on.
    for ([_]?sdk.Feature{ StreamOkFeature.make(), null }, [_][]const u8{ "stream-ok", "stream-plain" }) |extra, name| {
        const explain = h.omap();
        const callopts = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "explain", explain }}) }});
        _ = target.stream(makeSdk(.ok, &sinks, true, extra), h.clone(target.mtch), callopts);
        try testing.expect(0 < explain.object.count());
        sinks.value(fmt("{s}:explain", .{name}), explain);
    }

    // A feature's own error keeps its code, which is cleaned like the
    // message: returned, and handed to a hook.
    const denied = drive(makeSdk(.ok, &sinks, true, DenyFeature.make(&sinks)), target, h.omap(), &sinks);
    try testing.expect(denied != null);

    // A client given no clean block at all masks by the schema defaults.
    const bare = sdk.SDK.new(h.jo(&.{
        .{ "apikey", h.vstr(CANARY_APIKEY) },
        .{ "secret", h.vstr(CANARY_SECRET) },
        .{ "headers", h.jo(&.{.{ "X-Custom-Token", h.vstr(CANARY_HEADER) }}) },
        .{ "system", h.jo(&.{.{ "fetch", Transport.make(.notfound) }}) },
    }));
    const barerr = drive(bare, target, h.omap(), &sinks);
    try testing.expect(barerr != null);

    // The raw path returns its failure rather than an error.
    const direct = makeSdk(.transport, &sinks, true, null).direct(h.jo(&.{.{ "path", h.vstr("raw") }}));
    try testing.expect(h.getp(direct, "ok") == .bool and !h.getp(direct, "ok").bool);
    sinks.value("direct", direct);

    var leaked: usize = 0;
    for (sinks.items.items) |s| {
        const found = leaks(s.text);
        if (0 < found.len) {
            leaked += 1;
            std.debug.print("clean: credential leaked through {s}: {s}\n", .{ s.name, found[0] });
        }
    }

    std.debug.print("clean: swept {d} surface(s), {d} leak(s)\n", .{ sinks.items.items.len, leaked });

    try testing.expect(0 < sinks.items.items.len);
    try testing.expect(leaked == 0);

    // The positive half: the slot the credential travelled in is masked, and
    // an unregistered token in a response header is masked by name.
    const nf = notfound orelse {
        std.debug.print("clean: the 404 scenario must fail\n", .{});
        try testing.expect(false);
        return;
    };
    try testing.expect(h.to_int(h.getp(nf.result, "status")) == 404);
    const spec = nf.spec;
    if (!AUTH.suppressed) {
        if (std.mem.eql(u8, AUTH.where, "query")) {
            try testing.expect(std.mem.eql(u8, header(h.getp(spec, "query"), AUTH.name) orelse "", MASK));
        } else if (std.mem.eql(u8, AUTH.where, "cookie")) {
            const cookie = header(h.getp(spec, "headers"), "cookie") orelse "";
            try testing.expect(std.mem.indexOf(u8, cookie, MASK) != null);
        } else {
            const cred = header(h.getp(spec, "headers"), AUTH.name) orelse "";
            try testing.expect(std.mem.endsWith(u8, cred, MASK));
        }
    }
    try testing.expect(std.mem.eql(u8, header(h.getp(spec, "headers"), "x-custom-token") orelse "", MASK));
    try testing.expectEqualStrings("denied:" ++ MASK, denied.?.code);
    try testing.expectEqualStrings(MASK, header(h.getp(barerr.?.spec, "headers"), "x-custom-token") orelse "");

    try testing.expect(h.getp(explained, "result") == .object);
    try testing.expect(std.mem.eql(u8, header(h.getp(h.getp(explained, "result"), "headers"), "x-session-token") orelse "", MASK));
}

test "clean: the sweep can see a leak: clean switched off shows the credential" {
    const target = usableOp() orelse {
        std.debug.print(NOTHING_TO_SWEEP, .{});
        return error.SkipZigTest;
    };

    var sinks = Sinks{};
    const client = makeSdk(.notfound, &sinks, false, null);
    const err = drive(client, target, h.omap(), &sinks);
    try testing.expect(err != null);

    var seen: usize = 0;
    for (sinks.items.items) |s| {
        if (0 < leaks(s.text).len) seen += 1;
    }
    try testing.expect(0 < seen);

    if (!AUTH.suppressed) {
        const text = h.jsonify_compact(err.?.spec);
        const basic = base64_std(fmt("{s}:{s}", .{ CANARY_APIKEY, CANARY_SECRET }));
        try testing.expect(std.mem.indexOf(u8, text, CANARY_APIKEY) != null or
            std.mem.indexOf(u8, text, basic) != null);
    }

    // Explaining a failure must not cost it its error.
    var quiet = Sinks{};
    const explained = drive(makeSdk(.notfound, &quiet, false, null), target,
        h.jo(&.{.{ "explain", h.omap() }}), &quiet);
    try testing.expect(explained != null);
    try testing.expectEqualStrings(err.?.msg, explained.?.msg);
}

test "clean: a registered value used as a property name is masked, collisions kept" {
    const client = sdk.SDK.new(h.jo(&.{
        .{ "clean", h.jo(&.{.{ "values", h.vstr("ZZVAL-abc123,ZZVAL-xyz789") }}) },
    }));
    const out = sdk.utilmod.clean_util(client.get_root_ctx(), h.jo(&.{
        .{ "ZZVAL-abc123", h.vnum(1) },
        .{ "ZZVAL-xyz789", h.vnum(2) },
        .{ "plain", h.vnum(3) },
    }));
    try testing.expect(out == .object);
    var keys: std.ArrayList([]const u8) = .empty;
    var it = out.object.iterator();
    while (it.next()) |kv| keys.append(h.A(), kv.key_ptr.*) catch {};
    try testing.expectEqual(@as(usize, 3), keys.items.len);
    try testing.expectEqualStrings(MASK, keys.items[0]);
    try testing.expectEqualStrings(MASK ++ "#1", keys.items[1]);
    try testing.expectEqualStrings("plain", keys.items[2]);
}

test "clean: the generated config's own clean block is honoured" {
    const utility = sdk.test_sdk(vnull(), vnull()).get_utility();
    const config = h.jo(&.{.{ "options", h.jo(&.{.{ "clean", h.jo(&.{
        .{ "keys", h.vstr("zzsens") },
        .{ "values", h.vstr("CONFIG-SEEDED-1") },
    }) }}) }});
    const ctx = utility.make_context(sdk.CtxSpec{
        .utility = utility,
        .options = h.jo(&.{.{ "clean", h.jo(&.{.{ "values", h.vstr("CALLER-SEEDED-2") }}) }}),
        .config = config,
    }, null);
    ctx.options = utility.make_options(ctx);
    try testing.expectEqualStrings("a " ++ MASK ++ " b " ++ MASK,
        sdk.utilmod.clean_str_util(ctx, "a CONFIG-SEEDED-1 b CALLER-SEEDED-2"));
    const out = sdk.utilmod.clean_util(ctx, h.jo(&.{ .{ "my_zzsens", h.vstr("x") }, .{ "other", h.vstr("y") } }));
    try testing.expectEqualStrings(MASK, h.get_str(out, "my_zzsens") orelse "");
    try testing.expectEqualStrings("y", h.get_str(out, "other") orelse "");
    const cfgclean = h.getp(h.getp(config, "options"), "clean");
    try testing.expectEqualStrings("zzsens", h.get_str(cfgclean, "keys") orelse "");
    try testing.expectEqualStrings("CONFIG-SEEDED-1", h.get_str(cfgclean, "values") orelse "");
}

// A feature's name is not a field name: a feature called secrets does not
// make its settings secret, though a sensitive field inside it still is. An
// entity block, of per-entity settings or seeded records keyed by entity name
// and id, is not read at all.
test "clean: a feature's name is read as a name" {
    const client = sdk.SDK.new(h.jo(&.{
        .{ "apikey", h.vstr(CANARY_APIKEY) },
        .{ "feature", h.jo(&.{
            .{ "secrets", h.jo(&.{
                .{ "active", h.vbool(false) },
                .{ "name", h.vstr("ZZNAME-feat123") },
                .{ "token", h.vstr("ZZTOKEN-feat456") },
            }) },
            .{ "test", h.jo(&.{
                .{ "active", h.vbool(false) },
                .{ "entity", h.jo(&.{.{ "zztoken", h.jo(&.{.{ "ZZTOKEN01", h.jo(&.{
                    .{ "note", h.vstr("PLAINRECORD-t5r3e1w9") },
                }) }}) }}) },
            }) },
        }) },
        .{ "entity", h.jo(&.{.{ "zztoken", h.jo(&.{.{ "alias", h.jo(&.{
            .{ "zzkey", h.vstr("PLAINALIAS-m2n4b6v8") },
        }) }}) }}) },
    }));
    const ctx = client.get_root_ctx();
    try testing.expectEqualStrings("ZZNAME-feat123 " ++ MASK,
        sdk.utilmod.clean_str_util(ctx, "ZZNAME-feat123 ZZTOKEN-feat456"));
    try testing.expectEqualStrings("record PLAINRECORD-t5r3e1w9",
        sdk.utilmod.clean_str_util(ctx, "record PLAINRECORD-t5r3e1w9"));
    try testing.expectEqualStrings("alias PLAINALIAS-m2n4b6v8",
        sdk.utilmod.clean_str_util(ctx, "alias PLAINALIAS-m2n4b6v8"));
}
