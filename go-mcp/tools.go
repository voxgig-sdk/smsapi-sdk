package main

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/modelcontextprotocol/go-sdk/mcp"
	sdk "github.com/voxgig-sdk/smsapi-sdk/go"
)

// Args is the common argument shape for both tools. `entity` selects
// the SDK entity to operate on; `query` is the optional reqmatch /
// reqdata map passed through to the SDK. For load, `query` should be
// `{"id": <value>}`. For list, omit `query` or pass an empty map.
type Args struct {
	Entity string         `json:"entity" jsonschema:"available | blacklist | callback | contact | contacts_field | contacts_field_option | contactsgroup | contactstrash | field_available | group | mfa_code | opt_out | opt_out_setting | permission | ping | profile | rcs | sendername | sendername_statement | sent_rcs_message | shipment_country_volume | short_url | smsdo | smssendername | smstemplate | subuser | template | user_rcs_sender_collection"`
	Query  map[string]any `json:"query,omitempty" jsonschema:"optional match map e.g. {\"id\":1} for load, omit for list"`
}

func registerTools(server *mcp.Server, client *sdk.SmsapiSDK) {
	mcp.AddTool(server, &mcp.Tool{
		Name: "smsapi_list",
		Description: "List records from Smsapi. " +
			"Args: entity (one of the supported SDK entities), query (optional filter map). " +
			"Returns the first page of records as JSON.",
	}, func(ctx context.Context, req *mcp.CallToolRequest, args Args) (*mcp.CallToolResult, any, error) {
		return runOp(client, "list", args)
	})

	mcp.AddTool(server, &mcp.Tool{
		Name: "smsapi_load",
		Description: "Load a single record from Smsapi. " +
			"Args: entity, query ({\"id\":N} required). Returns the record as JSON.",
	}, func(ctx context.Context, req *mcp.CallToolRequest, args Args) (*mcp.CallToolResult, any, error) {
		return runOp(client, "load", args)
	})
}

func runOp(client *sdk.SmsapiSDK, op string, args Args) (*mcp.CallToolResult, any, error) {
	ent, err := entityFor(client, args.Entity)
	if err != nil {
		return toolError(err.Error())
	}

	var result any
	switch op {
	case "list":
		result, err = ent.List(args.Query, nil)
	case "load":
		result, err = ent.Load(args.Query, nil)
	default:
		return toolError(fmt.Sprintf("unknown op %q", op))
	}
	if err != nil {
		return toolError(err.Error())
	}

	// SDK returns *Entity wrappers; unwrap each via .Data() to get a
	// plain map[string]any (or []any of maps for list) suitable for
	// JSON marshalling.
	data := extractData(result)
	body, err := json.MarshalIndent(data, "", "  ")
	if err != nil {
		return toolError(fmt.Sprintf("marshal: %v", err))
	}
	return &mcp.CallToolResult{
		Content: []mcp.Content{
			&mcp.TextContent{Text: string(body)},
		},
	}, data, nil
}

// entityFor dispatches on the lowercase entity name. The generator
// emits one `case "<name>":` per entity defined in the SDK model.
func entityFor(client *sdk.SmsapiSDK, name string) (sdk.SmsapiEntity, error) {
	switch strings.ToLower(name) {
	case "available":
		return client.Available(nil), nil
	case "blacklist":
		return client.Blacklist(nil), nil
	case "callback":
		return client.Callback(nil), nil
	case "contact":
		return client.Contact(nil), nil
	case "contacts_field":
		return client.ContactsField(nil), nil
	case "contacts_field_option":
		return client.ContactsFieldOption(nil), nil
	case "contactsgroup":
		return client.Contactsgroup(nil), nil
	case "contactstrash":
		return client.Contactstrash(nil), nil
	case "field_available":
		return client.FieldAvailable(nil), nil
	case "group":
		return client.Group(nil), nil
	case "mfa_code":
		return client.MfaCode(nil), nil
	case "opt_out":
		return client.OptOut(nil), nil
	case "opt_out_setting":
		return client.OptOutSetting(nil), nil
	case "permission":
		return client.Permission(nil), nil
	case "ping":
		return client.Ping(nil), nil
	case "profile":
		return client.Profile(nil), nil
	case "rcs":
		return client.Rcs(nil), nil
	case "sendername":
		return client.Sendername(nil), nil
	case "sendername_statement":
		return client.SendernameStatement(nil), nil
	case "sent_rcs_message":
		return client.SentRcsMessage(nil), nil
	case "shipment_country_volume":
		return client.ShipmentCountryVolume(nil), nil
	case "short_url":
		return client.ShortUrl(nil), nil
	case "smsdo":
		return client.Smsdo(nil), nil
	case "smssendername":
		return client.Smssendername(nil), nil
	case "smstemplate":
		return client.Smstemplate(nil), nil
	case "subuser":
		return client.Subuser(nil), nil
	case "template":
		return client.Template(nil), nil
	case "user_rcs_sender_collection":
		return client.UserRcsSenderCollection(nil), nil

	}
	return nil, fmt.Errorf("unknown entity %q", name)
}

func extractData(x any) any {
	switch v := x.(type) {
	case sdk.Entity:
		return extractData(v.Data())
	case []any:
		out := make([]any, len(v))
		for i, e := range v {
			out[i] = extractData(e)
		}
		return out
	case map[string]any:
		out := make(map[string]any, len(v))
		for k, vv := range v {
			out[k] = extractData(vv)
		}
		return out
	}
	return x
}

func toolError(msg string) (*mcp.CallToolResult, any, error) {
	return &mcp.CallToolResult{
		IsError: true,
		Content: []mcp.Content{
			&mcp.TextContent{Text: msg},
		},
	}, nil, nil
}
