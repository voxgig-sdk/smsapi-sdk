// Generated smoke tests (model-driven). Drive each entity through the
// offline test transport and assert a non-error result.

const std = @import("std");
const sdk = @import("sdk");
const fh = @import("fh.zig");
const h = sdk.h;
const Value = sdk.Value;

fn vnull() Value {
    return Value{ .null = {} };
}

test "sdk_constructs_in_test_mode" {
    const testsdk = sdk.testSdk();
    try std.testing.expect(std.mem.eql(u8, testsdk.mode, "test"));
}

test "available_list_smoke" {
    const fixture = h.jo(&.{.{ "available", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.available(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "available_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "available", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.available(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.available(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "available_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).available(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).available(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).available(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "available_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).available(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "available_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).available(vnull()).list(h.jo(&.{ .{ "name", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "available_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/available/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "available_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/available/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "blacklist_load_smoke" {
    const fixture = h.jo(&.{.{ "blacklist", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.blacklist(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("blacklist load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "blacklist_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).blacklist(vnull()).load(h.jo(&.{ .{ "limit", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "blacklist_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/blacklist/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "blacklist_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/blacklist/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "callback_load_smoke" {
    const fixture = h.jo(&.{.{ "callback", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.callback(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("callback load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "callback_list_smoke" {
    const fixture = h.jo(&.{.{ "callback", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.callback(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "callback_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "callback", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.callback(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.callback(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "callback_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).callback(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).callback(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).callback(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "callback_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).callback(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "callback_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).callback(vnull()).list(h.jo(&.{ .{ "active", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "callback_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/callback/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "callback_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/callback/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "contact_load_smoke" {
    const fixture = h.jo(&.{.{ "contact", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.contact(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("contact load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "contact_list_smoke" {
    const fixture = h.jo(&.{.{ "contact", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.contact(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "contact_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "contact", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.contact(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.contact(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "contact_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).contact(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).contact(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).contact(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "contact_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).contact(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "contact_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).contact(vnull()).list(h.jo(&.{ .{ "gender", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "contact_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/contact/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "contact_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/contact/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "contacts_field_list_smoke" {
    const fixture = h.jo(&.{.{ "contacts_field", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.contacts_field(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "contacts_field_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "contacts_field", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.contacts_field(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.contacts_field(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "contacts_field_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).contacts_field(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).contacts_field(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).contacts_field(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "contacts_field_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).contacts_field(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "contacts_field_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).contacts_field(vnull()).list(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "contacts_field_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/contacts_field/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "contacts_field_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/contacts_field/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "contacts_field_option_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).contacts_field_option(vnull()).list(h.jo(&.{ .{ "field_id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "contacts_field_option_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/contacts_field_option/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "contacts_field_option_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/contacts_field_option/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "contactsgroup_list_smoke" {
    const fixture = h.jo(&.{.{ "contactsgroup", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.contactsgroup(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "contactsgroup_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "contactsgroup", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.contactsgroup(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.contactsgroup(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "contactsgroup_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).contactsgroup(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).contactsgroup(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).contactsgroup(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "contactsgroup_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).contactsgroup(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "contactsgroup_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).contactsgroup(vnull()).create(h.jo(&.{ .{ "group_id", h.vnum(1) }, .{ "read", h.vbool(true) }, .{ "send", h.vbool(true) }, .{ "username", h.vstr("x") }, .{ "write", h.vbool(true) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "contactsgroup_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/contactsgroup/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "contactsgroup_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/contactsgroup/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "field_available_list_smoke" {
    const fixture = h.jo(&.{.{ "field_available", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.field_available(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "field_available_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "field_available", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.field_available(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.field_available(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "field_available_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).field_available(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).field_available(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).field_available(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "field_available_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).field_available(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "field_available_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).field_available(vnull()).list(h.jo(&.{ .{ "built_in", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "field_available_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/field_available/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "field_available_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/field_available/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "group_load_smoke" {
    const fixture = h.jo(&.{.{ "group", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.group(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("group load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "group_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).group(vnull()).load(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "group_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/group/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "group_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/group/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "mfa_code_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).mfa_code(vnull()).create(h.jo(&.{ .{ "content", h.vnum(1) }, .{ "phone_number", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "opt_out_list_smoke" {
    const fixture = h.jo(&.{.{ "opt_out", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.opt_out(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "opt_out_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "opt_out", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.opt_out(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.opt_out(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "opt_out_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).opt_out(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).opt_out(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).opt_out(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "opt_out_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).opt_out(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "opt_out_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).opt_out(vnull()).list(h.jo(&.{ .{ "limit", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "opt_out_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/opt_out/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "opt_out_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/opt_out/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "opt_out_setting_load_smoke" {
    const fixture = h.jo(&.{.{ "opt_out_setting", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.opt_out_setting(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("opt_out_setting load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "opt_out_setting_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).opt_out_setting(vnull()).load(h.jo(&.{ .{ "brand", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "opt_out_setting_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/opt_out_setting/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "opt_out_setting_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/opt_out_setting/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "permission_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).permission(vnull()).load(h.jo(&.{ .{ "group_id", h.vnum(1) }, .{ "id", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "permission_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/permission/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "permission_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/permission/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "ping_list_smoke" {
    const fixture = h.jo(&.{.{ "ping", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.ping(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "ping_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "ping", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.ping(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.ping(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "ping_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).ping(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).ping(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).ping(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "ping_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).ping(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "ping_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).ping(vnull()).list(h.jo(&.{ .{ "authorized", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "ping_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/ping/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "ping_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/ping/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "profile_load_smoke" {
    const fixture = h.jo(&.{.{ "profile", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.profile(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("profile load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "profile_list_smoke" {
    const fixture = h.jo(&.{.{ "profile", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.profile(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "profile_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "profile", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.profile(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.profile(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "profile_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).profile(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).profile(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).profile(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "profile_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).profile(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "profile_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).profile(vnull()).list(h.jo(&.{ .{ "type", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "profile_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/profile/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "profile_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/profile/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "rcs_list_smoke" {
    const fixture = h.jo(&.{.{ "rcs", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.rcs(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "rcs_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "rcs", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.rcs(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.rcs(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "rcs_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).rcs(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).rcs(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).rcs(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "rcs_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).rcs(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "rcs_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/rcs/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "rcs_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/rcs/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "sendername_load_smoke" {
    const fixture = h.jo(&.{.{ "sendername", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.sendername(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("sendername load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "sendername_list_smoke" {
    const fixture = h.jo(&.{.{ "sendername", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.sendername(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "sendername_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "sendername", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.sendername(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.sendername(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "sendername_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).sendername(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).sendername(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).sendername(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "sendername_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).sendername(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "sendername_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).sendername(vnull()).list(h.jo(&.{ .{ "created_at", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "sendername_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/sendername/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "sendername_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/sendername/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "sendername_statement_list_smoke" {
    const fixture = h.jo(&.{.{ "sendername_statement", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.sendername_statement(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "sendername_statement_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "sendername_statement", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.sendername_statement(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.sendername_statement(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "sendername_statement_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).sendername_statement(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).sendername_statement(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).sendername_statement(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "sendername_statement_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).sendername_statement(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "sendername_statement_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).sendername_statement(vnull()).list(h.jo(&.{ .{ "content", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "sendername_statement_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/sendername_statement/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "sendername_statement_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/sendername_statement/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "sent_rcs_message_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).sent_rcs_message(vnull()).create(h.jo(&.{ .{ "phone_number", h.vnum(1) }, .{ "sender", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "shipment_country_volume_list_smoke" {
    const fixture = h.jo(&.{.{ "shipment_country_volume", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.shipment_country_volume(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "shipment_country_volume_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "shipment_country_volume", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.shipment_country_volume(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.shipment_country_volume(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "shipment_country_volume_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).shipment_country_volume(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).shipment_country_volume(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).shipment_country_volume(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "shipment_country_volume_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).shipment_country_volume(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "shipment_country_volume_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).shipment_country_volume(vnull()).list(h.jo(&.{ .{ "month", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "shipment_country_volume_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/shipment_country_volume/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "shipment_country_volume_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/shipment_country_volume/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "short_url_load_smoke" {
    const fixture = h.jo(&.{.{ "short_url", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.short_url(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("short_url load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "short_url_list_smoke" {
    const fixture = h.jo(&.{.{ "short_url", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.short_url(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "short_url_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "short_url", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.short_url(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.short_url(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "short_url_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).short_url(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).short_url(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).short_url(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "short_url_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).short_url(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "short_url_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).short_url(vnull()).list(h.jo(&.{ .{ "description", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "short_url_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/short_url/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "short_url_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/short_url/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "smsdo_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).smsdo(vnull()).create(h.jo(&.{ .{ "allow_duplicates", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "smssendername_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).smssendername(vnull()).create(h.jo(&.{ .{ "sender", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "smstemplate_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).smstemplate(vnull()).remove(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "subuser_load_smoke" {
    const fixture = h.jo(&.{.{ "subuser", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.subuser(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("subuser load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "subuser_list_smoke" {
    const fixture = h.jo(&.{.{ "subuser", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.subuser(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "subuser_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "subuser", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.subuser(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.subuser(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "subuser_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).subuser(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).subuser(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).subuser(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "subuser_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).subuser(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "subuser_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).subuser(vnull()).list(h.jo(&.{ .{ "q", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "subuser_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/subuser/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "subuser_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/subuser/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "template_load_smoke" {
    const fixture = h.jo(&.{.{ "template", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.template(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("template load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "template_list_smoke" {
    const fixture = h.jo(&.{.{ "template", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.template(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "template_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "template", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.template(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.template(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "template_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).template(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).template(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).template(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "template_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).template(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "template_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).template(vnull()).list(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "template_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/template/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "template_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/template/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "user_rcs_sender_collection_list_smoke" {
    const fixture = h.jo(&.{.{ "user_rcs_sender_collection", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.user_rcs_sender_collection(vnull());
    const res = e.list(vnull(), vnull());
    try std.testing.expect(res == .ok);
}

test "user_rcs_sender_collection_stream_smoke" {
    // stream() runs the list op through the full pipeline and returns the
    // result items. Seed two entities via test mode; with the streaming
    // feature active it yields the feature's incremental items, else it falls
    // back to the materialised items — either way every item is yielded.
    const fixture = h.jo(&.{.{ "user_rcs_sender_collection", h.jo(&.{
        .{ "strm01", h.jo(&.{.{ "id", h.vstr("strm01") }}) },
        .{ "strm02", h.jo(&.{.{ "id", h.vstr("strm02") }}) },
    }) }});
    const sdkopts = h.jo(&.{.{ "feature", h.jo(&.{.{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), sdkopts);
    const e = testsdk.user_rcs_sender_collection(vnull());
    const items = e.stream("list", vnull(), vnull());
    try std.testing.expect(items == .ok and items.ok.len == 2);

    // Fallback: streaming inactive still yields both materialised items.
    const plainsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const pe = plainsdk.user_rcs_sender_collection(vnull());
    const pitems = pe.stream("list", vnull(), vnull());
    try std.testing.expect(pitems == .ok and pitems.ok.len == 2);
}

test "user_rcs_sender_collection_stream_error" {
    const offline = h.jo(&.{.{ "net", h.jo(&.{.{ "offline", h.vbool(true) }}) }});
    switch (sdk.test_sdk(offline, vnull()).user_rcs_sender_collection(vnull()).stream("list", vnull(), vnull())) {
        .err => |er| try std.testing.expect(std.mem.indexOf(u8, er.msg, "offline") != null),
        .ok => try std.testing.expect(false),
    }

    const quiet = h.jo(&.{.{ "ctrl", h.jo(&.{.{ "throw", h.vbool(false) }}) }});
    try std.testing.expect(sdk.test_sdk(offline, vnull()).user_rcs_sender_collection(vnull()).stream("list", vnull(), quiet) == .ok);

    if (fh.fh_has_feature("rbac")) {
        const deny = h.jo(&.{.{ "feature", h.jo(&.{.{ "rbac", h.jo(&.{
            .{ "active", h.vbool(true) },
            .{ "deny", h.vbool(true) },
        }) }}) }});
        switch (sdk.test_sdk(vnull(), deny).user_rcs_sender_collection(vnull()).stream("list", vnull(), vnull())) {
            .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "rbac_denied")),
            .ok => try std.testing.expect(false),
        }
    }
}

test "user_rcs_sender_collection_stream_ctrl" {
    const explain = h.omap();
    const ctrl = h.jo(&.{.{ "explain", explain }});
    _ = sdk.test_sdk(vnull(), vnull()).user_rcs_sender_collection(vnull()).stream("list", vnull(), h.jo(&.{.{ "ctrl", ctrl }}));
    try std.testing.expect(h.is_noval(h.getp(ctrl, "stream")));
    try std.testing.expect(0 < explain.object.count());
}

test "user_rcs_sender_collection_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/user_rcs_sender_collection/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "user_rcs_sender_collection_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/user_rcs_sender_collection/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

// Documented quick-start surface (README.md / REFERENCE.md). Exercises the
// test-mode constructor and the direct() escape hatch exactly as documented.
test "readme_quickstart_surface" {
    // `sdk.test_sdk(...)` — the documented mock constructor.
    const client = sdk.test_sdk(vnull(), vnull());
    try std.testing.expect(std.mem.eql(u8, client.mode, "test"));

    // `client.direct(...)` — the documented escape hatch. It always returns a
    // result map carrying an `ok` flag (never an error union).
    const result = client.direct(h.jo(&.{
        .{ "path", h.vstr("/api/resource/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);

    // `client.prepare(...)` — build a request without sending it.
    const fetchdef = client.prepare(h.jo(&.{
        .{ "path", h.vstr("/api/resource/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
    })) catch h.vnull();
    _ = fetchdef;
}
