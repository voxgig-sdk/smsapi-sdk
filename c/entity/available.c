// Available entity client (generated — mirrors the rust Entity fragment).

#include "api.h"

#include <stdlib.h>
#include <string.h>

typedef struct available_entity {
  Entity base;            // vtable pointer (first member)
  char* name;
  SmsapiSDK* client;
  Utility* utility;
  voxgig_value* entopts;
  voxgig_value* data;     // Map
  voxgig_value* mtch;     // Map
  Context* entctx;
  // Set once a successful `remove` resolves on this instance.
  bool deleted;
} available_entity;

typedef void (*available_postdone_fn)(available_entity* self, Context* ctx);

// Forward declarations.
static const EntityVT available_VT;
static const char* available_get_name(Entity* e);
static Entity* available_make(Entity* e);
static voxgig_value* available_data(Entity* e, voxgig_value* args);
static voxgig_value* available_matchv(Entity* e, voxgig_value* args);
// Ops resolve to the ENTITY (`list` to a NULL-terminated array of them).
static Entity* available_load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err);
static Entity** available_list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err);
static Entity* available_create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err);
static Entity* available_update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err);
static Entity* available_remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err);
static void available_mark_deleted(Entity* e);
static bool available_deleted(Entity* e);

static Context* available_ent_ctx(available_entity* self) {
  return self->entctx;
}

Entity* available_entity_new(SmsapiSDK* client, voxgig_value* entopts) {
  entopts = voxgig_is_map(entopts) ? entopts : voxgig_new_map();

  bool act;
  if (!get_bool(entopts, "active", &act)) {
    setp(entopts, "active", v_bool(true));
  } else if (act != false) {
    setp(entopts, "active", v_bool(true));
  }

  available_entity* self = (available_entity*)calloc(1, sizeof(available_entity));
  self->base.vt = &available_VT;
  self->name = strdup("available");
  self->client = client;
  self->utility = sdk_get_utility(client);
  self->entopts = entopts;
  self->data = voxgig_new_map();
  self->mtch = voxgig_new_map();
  self->entctx = NULL;

  CtxSpec cs;
  memset(&cs, 0, sizeof(cs));
  cs.entity = (Entity*)self;
  cs.entopts = entopts;
  Context* entctx = make_context_util(cs, sdk_get_root_ctx(client));

  feature_hook_util(entctx, "PostConstructEntity");

  self->entctx = entctx;
  return (Entity*)self;
}

// Pipeline: make_point -> make_spec -> make_request -> make_response ->
// make_result -> post_done -> done. Feature hooks fire between stages.
static voxgig_value* available_run_op(available_entity* self, Context* ctx,
                                    available_postdone_fn post_done, PNError** err) {
  Utility* utility = self->utility;
  (void)utility;
  PNError* e = NULL;

  feature_hook_util(ctx, "PrePoint");
  voxgig_value* point = make_point_util(ctx, &e);
  if (e) return make_error_util(ctx, e, err);
  ctx_out_set_point_val(ctx, point);

  feature_hook_util(ctx, "PreSpec");
  Spec* spec = make_spec_util(ctx, &e);
  if (e) return make_error_util(ctx, e, err);
  ctx->out_spec = spec;

  feature_hook_util(ctx, "PreRequest");
  Response* resp = make_request_util(ctx, &e);
  if (e) return make_error_util(ctx, e, err);
  ctx->out_request = resp;

  feature_hook_util(ctx, "PreResponse");
  Response* resp2 = make_response_util(ctx, &e);
  if (e) return make_error_util(ctx, e, err);
  ctx->out_response = resp2;

  feature_hook_util(ctx, "PreResult");
  SdkResult* result = make_result_util(ctx, &e);
  if (e) return make_error_util(ctx, e, err);
  ctx->out_result = result;

  feature_hook_util(ctx, "PreDone");
  post_done(self, ctx);

  return done_util(ctx, err);
}

// A step's error does not pass through make_error in stream, so it and the
// explain record are cleaned on the way out.
static voxgig_value* available_stream_fail(Context* ctx, PNError* pe, PNError** err) {
  clean_explain_util(ctx);
  clean_error_util(ctx, pe);
  *err = pe;
  return NULL;
}

// Streaming operation. Runs `action` through the full pipeline and returns a
// List of the result items, so the `streaming` feature's incremental output
// is reachable from a generated entity (a normal op call materialises the
// whole result). This runtime is synchronous and C has no lazy iterators, so
// the returned value is a List cursor the caller walks (voxgig_as_list).
// `callopts` parameterises the call:
//   - inbound (download): the items/chunks the streaming feature produces when
//     active, else the materialised items;
//   - outbound (upload): a `body` in `callopts` is attached to the request
//     (reqdata `body$`) so the transport can stream a payload;
//   - `ctrl` (pipeline control) threads pipeline options.
voxgig_value* available_stream(Entity* e, const char* action, voxgig_value* args,
                             voxgig_value* callopts, PNError** err) {
  available_entity* self = (available_entity*)e;
  *err = NULL;

  voxgig_value* stream_opts = voxgig_is_map(callopts) ? callopts : voxgig_new_map();

  voxgig_value* ctrl = to_map(getp(stream_opts, "ctrl"));
  if (!voxgig_is_map(ctrl)) ctrl = voxgig_new_map();
  setp(ctrl, "stream", v_share(stream_opts));

  voxgig_value* reqmatch = to_map(args);
  if (!voxgig_is_map(reqmatch)) reqmatch = voxgig_new_map();

  CtxSpec cs;
  memset(&cs, 0, sizeof(cs));
  cs.opname = action;
  cs.ctrl = ctrl;
  cs.mtch = self->mtch;
  cs.data = self->data;
  cs.reqmatch = reqmatch;
  Context* ctx = make_context_util(cs, available_ent_ctx(self));

  // Outbound: attach a caller `body` so the transport can stream a payload.
  voxgig_value* body = getp(stream_opts, "body");
  if (!v_is_noval(body) && !v_is_null(body)) {
    voxgig_value* reqdata = voxgig_is_map(ctx->reqdata) ? ctx->reqdata : voxgig_new_map();
    setp(reqdata, "body$", v_share(body));
    ctx->reqdata = reqdata;
  }

  PNError* pe = NULL;

  feature_hook_util(ctx, "PrePoint");
  voxgig_value* point = make_point_util(ctx, &pe);
  if (pe) return available_stream_fail(ctx, pe, err);
  ctx_out_set_point_val(ctx, point);

  feature_hook_util(ctx, "PreSpec");
  Spec* spec = make_spec_util(ctx, &pe);
  if (pe) return available_stream_fail(ctx, pe, err);
  ctx->out_spec = spec;

  feature_hook_util(ctx, "PreRequest");
  Response* resp = make_request_util(ctx, &pe);
  if (pe) return available_stream_fail(ctx, pe, err);
  ctx->out_request = resp;

  feature_hook_util(ctx, "PreResponse");
  Response* resp2 = make_response_util(ctx, &pe);
  if (pe) return available_stream_fail(ctx, pe, err);
  ctx->out_response = resp2;

  feature_hook_util(ctx, "PreResult");
  SdkResult* result = make_result_util(ctx, &pe);
  if (pe) return available_stream_fail(ctx, pe, err);
  ctx->out_result = result;

  feature_hook_util(ctx, "PreDone");

  // Inbound: prefer the streaming feature's incremental producer; else fall
  // back to the materialised items so `stream` always yields.
  SdkResult* res = ctx->result;
  if (res && res->stream) {
    // done() does not run on this path, so its record is cleaned here.
    clean_explain_util(ctx);
    return res->stream(res->stream_ud);
  }

  voxgig_value* data = done_util(ctx, err);
  if (*err) return NULL;

  voxgig_value* out = voxgig_new_list();
  if (voxgig_is_list(data)) {
    voxgig_list* l = voxgig_as_list(data);
    for (size_t i = 0; i < l->len; i++) {
      voxgig_list_push(voxgig_as_list(out), voxgig_retain(l->items[i]));
    }
  } else if (!v_is_noval(data) && !v_is_null(data)) {
    voxgig_list_push(voxgig_as_list(out), voxgig_retain(data));
  }
  return out;
}

static const char* available_get_name(Entity* e) {
  return ((available_entity*)e)->name;
}

static Entity* available_make(Entity* e) {
  available_entity* self = (available_entity*)e;
  voxgig_value* opts = voxgig_new_map();
  if (voxgig_is_map(self->entopts)) {
    voxgig_map* m = voxgig_as_map(self->entopts);
    for (size_t i = 0; i < m->len; i++) {
      setp(opts, m->entries[i].key, voxgig_retain(m->entries[i].value));
    }
  }
  return available_entity_new(self->client, opts);
}

static voxgig_value* available_data(Entity* e, voxgig_value* args) {
  available_entity* self = (available_entity*)e;
  if (args && !v_is_noval(args) && !v_is_null(args)) {
    voxgig_value* cloned = to_map(voxgig_clone(args));
    self->data = voxgig_is_map(cloned) ? cloned : voxgig_new_map();
    feature_hook_util(available_ent_ctx(self), "SetData");
  }
  feature_hook_util(available_ent_ctx(self), "GetData");
  return voxgig_clone(self->data);
}

static voxgig_value* available_matchv(Entity* e, voxgig_value* args) {
  available_entity* self = (available_entity*)e;
  if (args && !v_is_noval(args) && !v_is_null(args)) {
    voxgig_value* cloned = to_map(voxgig_clone(args));
    self->mtch = voxgig_is_map(cloned) ? cloned : voxgig_new_map();
    feature_hook_util(available_ent_ctx(self), "SetMatch");
  }
  feature_hook_util(available_ent_ctx(self), "GetMatch");
  return voxgig_clone(self->mtch);
}

static Entity* available_load(Entity* e, voxgig_value* reqarg, voxgig_value* ctrl, PNError** err) {
  (void)e; (void)reqarg; (void)ctrl;
  *err = unsupported_op("load", "available");
  return NULL;
}


static void available_list_postdone(available_entity* self, Context* ctx) {
  SdkResult* result = ctx->result;
  if (result) {
    voxgig_value* resmatch = result->resmatch;
    if (voxgig_is_map(resmatch)) self->mtch = resmatch;
  }
}

static Entity** available_list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err) {
  available_entity* self = (available_entity*)e;
  CtxSpec cs;
  memset(&cs, 0, sizeof(cs));
  cs.opname = "list";
  cs.ctrl = ctrl;
  cs.mtch = self->mtch;
  cs.data = self->data;
  cs.reqmatch = reqmatch;
  Context* ctx = make_context_util(cs, available_ent_ctx(self));
  voxgig_value* out = available_run_op(self, ctx, available_list_postdone, err);
  if (*err) return NULL;

  // `list` resolves to one ENTITY per record. make_result cannot build them
  // here - it works in voxgig_value, which has no slot for an entity - so the
  // op does, mirroring what the dynamic targets get from make_result. The
  // array is NULL-terminated.
  size_t n = voxgig_is_list(out) ? voxgig_as_list(out)->len : 0;
  Entity** items = (Entity**)calloc(n + 1, sizeof(Entity*));
  for (size_t i = 0; i < n; i++) {
    voxgig_value* entry = voxgig_as_list(out)->items[i];
    Entity* ent = e->vt->make(e);
    if (voxgig_is_map(entry)) ent->vt->data(ent, entry);
    items[i] = ent;
  }
  items[n] = NULL;

  return items;
}


static Entity* available_create(Entity* e, voxgig_value* reqarg, voxgig_value* ctrl, PNError** err) {
  (void)e; (void)reqarg; (void)ctrl;
  *err = unsupported_op("create", "available");
  return NULL;
}

static Entity* available_update(Entity* e, voxgig_value* reqarg, voxgig_value* ctrl, PNError** err) {
  (void)e; (void)reqarg; (void)ctrl;
  *err = unsupported_op("update", "available");
  return NULL;
}

static Entity* available_remove(Entity* e, voxgig_value* reqarg, voxgig_value* ctrl, PNError** err) {
  (void)e; (void)reqarg; (void)ctrl;
  *err = unsupported_op("remove", "available");
  return NULL;
}

// `remove` resolves to the entity, marked. The instance KEEPS the data it
// held - a caller can still read what was deleted - but it is no longer a
// live record.
static void available_mark_deleted(Entity* e) {
  ((available_entity*)e)->deleted = true;
}

static bool available_deleted(Entity* e) {
  return ((available_entity*)e)->deleted;
}

static const EntityVT available_VT = {
  available_get_name,
  available_make,
  available_data,
  available_matchv,
  available_mark_deleted,
  available_deleted,
  available_load,
  available_list,
  available_create,
  available_update,
  available_remove,
};
