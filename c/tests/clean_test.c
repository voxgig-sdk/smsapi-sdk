// Generated canary sweep (see TestClean_c): no credential leaves the SDK
// in any form, and the sweep can see one when clean is switched off.

#include "ctest.h"

#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

// Generated: the credential's wire placement is fixed when the SDK is built.
static const bool AUTH_SUPPRESSED = false;
static const char* AUTH_WHERE = "header";
static const char* AUTH_NAME = "authorization";

// The diagnostic features this SDK ships.
static const char* FEATURES[] = { "audit", "clienttrack", "cost", "debug", "log", "metrics", "telemetry", NULL };

static const char* CANARY_APIKEY = "CANARY-APIKEY-k9x2m7q4p1";
static const char* CANARY_SECRET = "CANARY-SECRET-w3e8r5t2y6";
static const char* CANARY_HEADER = "CANARY-HEADER-z1x4c7v0b3";
static const char* CANARY_VALUE = "CANARY-VALUE-n5m8b2v9c4";

static const char* MASK = "[redacted]";

// The sweep's own encoders: a leak of an encoded form must not hide behind
// the SDK's encoder.
static char* b64(const char* in) {
  static const char ALPHABET[] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  size_t n = strlen(in);
  char* out = (char*)malloc((n + 2) / 3 * 4 + 1);
  size_t o = 0;
  for (size_t i = 0; i < n; i += 3) {
    unsigned int v = (unsigned char)in[i] << 16;
    if (i + 1 < n) v |= (unsigned int)(unsigned char)in[i + 1] << 8;
    if (i + 2 < n) v |= (unsigned int)(unsigned char)in[i + 2];
    out[o++] = ALPHABET[(v >> 18) & 0x3f];
    out[o++] = ALPHABET[(v >> 12) & 0x3f];
    out[o++] = (i + 1 < n) ? ALPHABET[(v >> 6) & 0x3f] : '=';
    out[o++] = (i + 2 < n) ? ALPHABET[v & 0x3f] : '=';
  }
  out[o] = '\0';
  return out;
}

static char* pct(const char* in) {
  size_t n = strlen(in);
  char* out = (char*)malloc(n * 3 + 1);
  size_t o = 0;
  for (size_t i = 0; i < n; i++) {
    unsigned char c = (unsigned char)in[i];
    if (isalnum(c) || strchr("-_.!~*'()", c)) {
      out[o++] = (char)c;
    } else {
      o += (size_t)sprintf(out + o, "%%%02X", c);
    }
  }
  out[o] = '\0';
  return out;
}

// Every form a canary can travel in.
static const char* FORMS[16];
static size_t NFORMS = 0;

static void build_forms(void) {
  const char* canaries[4] = { CANARY_APIKEY, CANARY_SECRET, CANARY_HEADER, CANARY_VALUE };
  for (int i = 0; i < 4; i++) {
    FORMS[NFORMS++] = canaries[i];
    FORMS[NFORMS++] = b64(canaries[i]);
    FORMS[NFORMS++] = pct(canaries[i]);
  }
  char pair[256];
  snprintf(pair, sizeof(pair), "%s:%s", CANARY_APIKEY, CANARY_SECRET);
  FORMS[NFORMS++] = b64(pair);
}

typedef struct {
  const char* name;
  char* text;
} Sink;

static Sink* SINKS = NULL;
static size_t NSINKS = 0;
static size_t CAPSINKS = 0;

static void push(const char* name, char* text) {
  if (NSINKS == CAPSINKS) {
    CAPSINKS = CAPSINKS ? CAPSINKS * 2 : 64;
    SINKS = (Sink*)realloc(SINKS, CAPSINKS * sizeof(Sink));
  }
  SINKS[NSINKS].name = name;
  SINKS[NSINKS].text = text ? text : strdup("");
  NSINKS++;
}

static void push_value(const char* name, voxgig_value* val) {
  push(name, voxgig_jsonify(val, NULL));
  push(name, voxgig_stringify(val, -1));
}

static void push_error(const char* name, PNError* err) {
  push(name, strdup(err->msg ? err->msg : ""));
  push(name, pn_error_str(err));
  push(name, voxgig_jsonify(err->spec, NULL));
  push(name, voxgig_jsonify(err->result, NULL));
}

static voxgig_value* capture_fn(void* ud, voxgig_value* arg) {
  push_value((const char*)ud, arg);
  return v_undef();
}

// Captures the serialised context from inside the pipeline: what a hook
// author would hand to a logger.
typedef struct {
  Feature base;
} CaptureFeature;

static const char* capture_name(Feature* f) { (void)f; return "capture"; }
static bool capture_active(Feature* f) { (void)f; return true; }
static voxgig_value* capture_add_options(Feature* f) { (void)f; return NULL; }
static void capture_init(Feature* f, Context* ctx, voxgig_value* options) {
  (void)f; (void)ctx; (void)options;
}
static void capture_hook(Feature* f, const char* name, Context* ctx) {
  (void)f;
  if (0 == strcmp(name, "PreRequest") || 0 == strcmp(name, "PreResponse") ||
      0 == strcmp(name, "PreUnexpected")) {
    push("ctx", context_str(ctx));
    push_value("ctx", context_to_value(ctx));
  }
}

static const FeatureVT CAPTURE_VT = {
  capture_name, capture_active, capture_add_options, capture_init, capture_hook, NULL,
};

// A feature that fails the operation from inside the pipeline, quoting the
// request it saw. A C hook has no error return, so it fails the result: an
// error make_error receives from a hook, not from the pipeline. For the same
// reason there is no variant failing in PreUnexpected: make_error has built
// and cleaned the error it returns before that hook runs.
static const char* throw_name(Feature* f) { (void)f; return "throwhook"; }
static void throw_hook(Feature* f, const char* name, Context* ctx) {
  (void)f;
  if (0 != strcmp(name, "PreResponse") || !ctx->result) return;
  char* spec = voxgig_jsonify(ctx->spec ? spec_to_value(ctx->spec) : v_undef(), NULL);
  char msg[4096];
  snprintf(msg, sizeof(msg), "hook saw %s", spec ? spec : "");
  ctx->result->err = context_make_error(ctx, "hook", msg);
}

static const FeatureVT THROW_VT = {
  throw_name, capture_active, capture_add_options, capture_init, throw_hook, NULL,
};

// A feature that refuses the operation with the SDK's own error, as rbac
// does, whose code quotes a registered value; it records the error
// PreUnexpected hands a hook.
static const char* deny_name(Feature* f) { (void)f; return "denyhook"; }
static void deny_hook(Feature* f, const char* name, Context* ctx) {
  (void)f;
  if (0 == strcmp(name, "PrePoint")) {
    char code[128];
    snprintf(code, sizeof(code), "denied:%s", CANARY_VALUE);
    ctx_out_set_point_err(ctx, context_make_error(ctx, code, "denied"));
  } else if (0 == strcmp(name, "PreUnexpected") && ctx->ctrl && ctx->ctrl->err) {
    push_error("error", ctx->ctrl->err);
  }
}

static const FeatureVT DENY_VT = {
  deny_name, capture_active, capture_add_options, capture_init, deny_hook, NULL,
};

// A stream that succeeds, so the pipeline's terminal step never runs. A C
// stream producer has no error channel, so no stream fails.
static voxgig_value* streamok_items(void* ud) {
  voxgig_value* data = (voxgig_value*)ud;
  voxgig_value* out = v_list();
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

static const char* streamok_name(Feature* f) { (void)f; return "streamok"; }
static void streamok_hook(Feature* f, const char* name, Context* ctx) {
  (void)f;
  if (0 != strcmp(name, "PreDone") || !ctx->result) return;
  ctx->result->stream = streamok_items;
  ctx->result->stream_ud = v_share(ctx->result->resdata);
}

static const FeatureVT STREAMOK_VT = {
  streamok_name, capture_active, capture_add_options, capture_init, streamok_hook, NULL,
};

enum { SC_OK = 0, SC_NOTFOUND, SC_SERVER, SC_TRANSPORT, SC_NOTJSON, SC_COUNT };
static const char* SC_NAMES[] = { "ok", "notfound", "server", "transport", "notjson" };

static voxgig_value* response(int status, voxgig_value* data, const char* hk, const char* hv) {
  voxgig_value* headers = cmap(1, "content-type", v_str("application/json"));
  if (hk) setp(headers, hk, v_str(hv));
  return cmap(5,
    "status", v_num((double)status),
    "statusText", v_str(status < 400 ? "OK" : "ERR"),
    "headers", headers,
    "body", v_str(voxgig_jsonify(data, NULL)),
    "json", json_thunk(data));
}

static voxgig_value* respond(int sc, const char* url) {
  switch (sc) {
    case SC_OK:
      return response(200, cmap(2, "id", v_str("i1"), "name", v_str("n1")),
                      "x-session-token", "RESP-TOKEN-a1b2c3d4e5");
    case SC_NOTFOUND:
      return response(404, cmap(1, "error", v_str("no such record")), NULL, NULL);
    case SC_SERVER:
      return response(500, cmap(1, "error", v_str("boom")), NULL, NULL);
    case SC_TRANSPORT: {
      char msg[2048];
      snprintf(msg, sizeof(msg), "socket hang up (URL was: \"%s\")", url);
      return cmap(1, "__err__", v_str(msg));
    }
    default:
      return cmap(5,
        "status", v_num(200),
        "statusText", v_str("OK"),
        "headers", v_map(),
        "body", v_str("<html>"),
        "json", json_thunk(v_undef()));
  }
}

// The transport seam: system.fetch is called with [url, fetchdef].
static voxgig_value* transport_fn(void* ud, voxgig_value* args) {
  int sc = (int)(intptr_t)ud;
  const char* url = "";
  if (voxgig_is_list(args) && 0 < voxgig_as_list(args)->len) {
    voxgig_value* u = voxgig_as_list(args)->items[0];
    if (voxgig_is_string(u)) url = voxgig_as_string(u);
  }
  return respond(sc, url);
}

static SmsapiSDK* make_sdk(int sc, voxgig_value* cleanopts, Feature* extra) {
  voxgig_value* feature = v_map();
  for (size_t i = 0; FEATURES[i]; i++) {
    const char* name = FEATURES[i];
    voxgig_value* fopts = cmap(1, "active", v_bool(true));
    if (0 == strcmp(name, "log")) setp(fopts, "logger", vfn(capture_fn, (void*)"log"));
    else if (0 == strcmp(name, "debug")) setp(fopts, "onEntry", vfn(capture_fn, (void*)"debug"));
    else if (0 == strcmp(name, "audit")) setp(fopts, "sink", vfn(capture_fn, (void*)"audit"));
    else if (0 == strcmp(name, "telemetry")) setp(fopts, "exporter", vfn(capture_fn, (void*)"telemetry"));
    else if (0 == strcmp(name, "cost")) setp(fopts, "sink", vfn(capture_fn, (void*)"cost"));
    setp(feature, name, fopts);
  }

  voxgig_value* clean = cmap(1, "values", v_str(CANARY_VALUE));
  if (voxgig_is_map(cleanopts)) {
    voxgig_map* m = voxgig_as_map(cleanopts);
    for (size_t i = 0; i < m->len; i++) {
      setp(clean, m->entries[i].key, voxgig_retain(m->entries[i].value));
    }
  }

  SmsapiSDK* sdk = smsapi_sdk_new(cmap(6,
    "apikey", v_str(CANARY_APIKEY),
    "secret", v_str(CANARY_SECRET),
    "headers", cmap(1, "X-Custom-Token", v_str(CANARY_HEADER)),
    "clean", clean,
    "feature", feature,
    "system", cmap(1, "fetch", vfn(transport_fn, (void*)(intptr_t)sc))));

  // C options are pure data, so the extension feature is added after
  // construction (the `extend` option of the ts client).
  CaptureFeature* cf = (CaptureFeature*)calloc(1, sizeof(CaptureFeature));
  cf->base.vt = &CAPTURE_VT;
  sdk_features_push(sdk, (Feature*)cf);
  if (extra) sdk_features_push(sdk, extra);

  return sdk;
}

typedef PNError* (*Drive)(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out);
typedef voxgig_value* (*Streamer)(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err);

static PNError* drive_available_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_available(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_blacklist_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_blacklist(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_blacklist_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_blacklist(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_blacklist_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_blacklist(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_callback_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_callback(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_callback_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_callback(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_callback_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_callback(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_callback_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_callback(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_callback_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_callback(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contact_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contact(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_contact_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contact(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contact_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contact(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contact_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contact(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contact_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contact(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contacts_field_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contacts_field(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_contacts_field_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contacts_field(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contacts_field_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contacts_field(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contacts_field_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contacts_field(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contacts_field_option_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contacts_field_option(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_contactsgroup_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactsgroup(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_contactsgroup_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactsgroup(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contactsgroup_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactsgroup(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contactsgroup_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactsgroup(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contactstrash_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactstrash(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_contactstrash_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_contactstrash(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_field_available_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_field_available(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_group_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_group(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_group_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_group(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_mfa_code_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_mfa_code(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_opt_out_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_opt_out(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_opt_out_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_opt_out(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_opt_out_setting_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_opt_out_setting(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_opt_out_setting_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_opt_out_setting(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_permission_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_permission(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_permission_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_permission(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_ping_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_ping(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_profile_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_profile(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_profile_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_profile(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_rcs_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_rcs(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_sendername_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_sendername(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_sendername_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_sendername(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_sendername_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_sendername(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_sendername_statement_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_sendername_statement(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_sent_rcs_message_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_sent_rcs_message(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_shipment_country_volume_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_shipment_country_volume(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_short_url_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_short_url(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_short_url_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_short_url(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_short_url_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_short_url(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_short_url_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_short_url(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_short_url_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_short_url(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_smsdo_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_smsdo(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_smssendername_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_smssendername(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_smssendername_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_smssendername(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_smstemplate_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_smstemplate(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_subuser_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_subuser(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_subuser_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_subuser(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_subuser_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_subuser(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_subuser_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_subuser(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_subuser_remove(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_subuser(sdk, NULL);
  Entity* r = e->vt->remove(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_template_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_template(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static PNError* drive_template_load(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_template(sdk, NULL);
  Entity* r = e->vt->load(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_template_create(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_template(sdk, NULL);
  Entity* r = e->vt->create(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_template_update(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_template(sdk, NULL);
  Entity* r = e->vt->update(e, mtch, ctrl, &err);
  if (err) return err;
  *out = r ? r->vt->data(r, NULL) : v_undef();
  return NULL;
}

static PNError* drive_user_rcs_sender_collection_list(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* ctrl, voxgig_value** out) {
  PNError* err = NULL;
  Entity* e = smsapi_user_rcs_sender_collection(sdk, NULL);
  Entity** items = e->vt->list(e, mtch, ctrl, &err);
  if (err) return err;
  voxgig_value* list = v_list();
  for (size_t i = 0; items && items[i]; i++) {
    voxgig_list_push(voxgig_as_list(list), items[i]->vt->data(items[i], NULL));
  }
  *out = list;
  return NULL;
}

static voxgig_value* drive_available_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return available_stream(smsapi_available(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_blacklist_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return blacklist_stream(smsapi_blacklist(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_blacklist_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return blacklist_stream(smsapi_blacklist(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_blacklist_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return blacklist_stream(smsapi_blacklist(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_callback_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return callback_stream(smsapi_callback(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_callback_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return callback_stream(smsapi_callback(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_callback_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return callback_stream(smsapi_callback(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_callback_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return callback_stream(smsapi_callback(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_callback_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return callback_stream(smsapi_callback(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_contact_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contact_stream(smsapi_contact(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_contact_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contact_stream(smsapi_contact(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_contact_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contact_stream(smsapi_contact(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_contact_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contact_stream(smsapi_contact(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_contact_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contact_stream(smsapi_contact(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_contacts_field_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contacts_field_stream(smsapi_contacts_field(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_contacts_field_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contacts_field_stream(smsapi_contacts_field(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_contacts_field_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contacts_field_stream(smsapi_contacts_field(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_contacts_field_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contacts_field_stream(smsapi_contacts_field(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_contacts_field_option_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contacts_field_option_stream(smsapi_contacts_field_option(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_contactsgroup_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactsgroup_stream(smsapi_contactsgroup(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_contactsgroup_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactsgroup_stream(smsapi_contactsgroup(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_contactsgroup_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactsgroup_stream(smsapi_contactsgroup(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_contactsgroup_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactsgroup_stream(smsapi_contactsgroup(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_contactstrash_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactstrash_stream(smsapi_contactstrash(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_contactstrash_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return contactstrash_stream(smsapi_contactstrash(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_field_available_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return field_available_stream(smsapi_field_available(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_group_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return group_stream(smsapi_group(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_group_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return group_stream(smsapi_group(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_mfa_code_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return mfa_code_stream(smsapi_mfa_code(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_opt_out_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return opt_out_stream(smsapi_opt_out(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_opt_out_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return opt_out_stream(smsapi_opt_out(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_opt_out_setting_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return opt_out_setting_stream(smsapi_opt_out_setting(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_opt_out_setting_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return opt_out_setting_stream(smsapi_opt_out_setting(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_permission_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return permission_stream(smsapi_permission(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_permission_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return permission_stream(smsapi_permission(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_ping_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return ping_stream(smsapi_ping(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_profile_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return profile_stream(smsapi_profile(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_profile_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return profile_stream(smsapi_profile(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_rcs_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return rcs_stream(smsapi_rcs(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_sendername_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return sendername_stream(smsapi_sendername(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_sendername_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return sendername_stream(smsapi_sendername(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_sendername_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return sendername_stream(smsapi_sendername(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_sendername_statement_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return sendername_statement_stream(smsapi_sendername_statement(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_sent_rcs_message_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return sent_rcs_message_stream(smsapi_sent_rcs_message(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_shipment_country_volume_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return shipment_country_volume_stream(smsapi_shipment_country_volume(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_short_url_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return short_url_stream(smsapi_short_url(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_short_url_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return short_url_stream(smsapi_short_url(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_short_url_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return short_url_stream(smsapi_short_url(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_short_url_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return short_url_stream(smsapi_short_url(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_short_url_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return short_url_stream(smsapi_short_url(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_smsdo_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return smsdo_stream(smsapi_smsdo(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_smssendername_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return smssendername_stream(smsapi_smssendername(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_smssendername_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return smssendername_stream(smsapi_smssendername(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_smstemplate_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return smstemplate_stream(smsapi_smstemplate(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_subuser_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return subuser_stream(smsapi_subuser(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_subuser_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return subuser_stream(smsapi_subuser(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_subuser_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return subuser_stream(smsapi_subuser(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_subuser_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return subuser_stream(smsapi_subuser(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_subuser_remove_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return subuser_stream(smsapi_subuser(sdk, NULL), "remove", mtch, callopts, err);
}

static voxgig_value* drive_template_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return template_stream(smsapi_template(sdk, NULL), "list", mtch, callopts, err);
}

static voxgig_value* drive_template_load_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return template_stream(smsapi_template(sdk, NULL), "load", mtch, callopts, err);
}

static voxgig_value* drive_template_create_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return template_stream(smsapi_template(sdk, NULL), "create", mtch, callopts, err);
}

static voxgig_value* drive_template_update_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return template_stream(smsapi_template(sdk, NULL), "update", mtch, callopts, err);
}

static voxgig_value* drive_user_rcs_sender_collection_list_stream(SmsapiSDK* sdk, voxgig_value* mtch, voxgig_value* callopts, PNError** err) {
  return user_rcs_sender_collection_stream(smsapi_user_rcs_sender_collection(sdk, NULL), "list", mtch, callopts, err);
}

// Generated: every CRUD operation of every active entity, list and load
// first (they need no body), with the path parameters its points declare.
static const struct { const char* name; Drive fn; Streamer stream; const char* params[16]; } CANDIDATES[] = {
  { "available.list", drive_available_list, drive_available_list_stream, { NULL } },
  { "blacklist.load", drive_blacklist_load, drive_blacklist_load_stream, { NULL } },
  { "blacklist.create", drive_blacklist_create, drive_blacklist_create_stream, { NULL } },
  { "blacklist.remove", drive_blacklist_remove, drive_blacklist_remove_stream, { "id", NULL } },
  { "callback.list", drive_callback_list, drive_callback_list_stream, { NULL } },
  { "callback.load", drive_callback_load, drive_callback_load_stream, { "id", NULL } },
  { "callback.create", drive_callback_create, drive_callback_create_stream, { NULL } },
  { "callback.update", drive_callback_update, drive_callback_update_stream, { "id", NULL } },
  { "callback.remove", drive_callback_remove, drive_callback_remove_stream, { "id", NULL } },
  { "contact.list", drive_contact_list, drive_contact_list_stream, { "id", NULL } },
  { "contact.load", drive_contact_load, drive_contact_load_stream, { "contact_id", "group_id", "id", NULL } },
  { "contact.create", drive_contact_create, drive_contact_create_stream, { "id", NULL } },
  { "contact.update", drive_contact_update, drive_contact_update_stream, { "contact_id", "group_id", "id", NULL } },
  { "contact.remove", drive_contact_remove, drive_contact_remove_stream, { "group_id", "id", NULL } },
  { "contacts_field.list", drive_contacts_field_list, drive_contacts_field_list_stream, { NULL } },
  { "contacts_field.create", drive_contacts_field_create, drive_contacts_field_create_stream, { NULL } },
  { "contacts_field.update", drive_contacts_field_update, drive_contacts_field_update_stream, { "id", NULL } },
  { "contacts_field.remove", drive_contacts_field_remove, drive_contacts_field_remove_stream, { "id", NULL } },
  { "contacts_field_option.list", drive_contacts_field_option_list, drive_contacts_field_option_list_stream, { "field_id", NULL } },
  { "contactsgroup.list", drive_contactsgroup_list, drive_contactsgroup_list_stream, { "group_id", NULL } },
  { "contactsgroup.create", drive_contactsgroup_create, drive_contactsgroup_create_stream, { "group_id", NULL } },
  { "contactsgroup.update", drive_contactsgroup_update, drive_contactsgroup_update_stream, { "group_id", "username", NULL } },
  { "contactsgroup.remove", drive_contactsgroup_remove, drive_contactsgroup_remove_stream, { "contact_id", "group_id", "username", NULL } },
  { "contactstrash.update", drive_contactstrash_update, drive_contactstrash_update_stream, { NULL } },
  { "contactstrash.remove", drive_contactstrash_remove, drive_contactstrash_remove_stream, { NULL } },
  { "field_available.list", drive_field_available_list, drive_field_available_list_stream, { NULL } },
  { "group.load", drive_group_load, drive_group_load_stream, { "id", NULL } },
  { "group.update", drive_group_update, drive_group_update_stream, { "id", NULL } },
  { "mfa_code.create", drive_mfa_code_create, drive_mfa_code_create_stream, { NULL } },
  { "opt_out.list", drive_opt_out_list, drive_opt_out_list_stream, { NULL } },
  { "opt_out.remove", drive_opt_out_remove, drive_opt_out_remove_stream, { "id", NULL } },
  { "opt_out_setting.load", drive_opt_out_setting_load, drive_opt_out_setting_load_stream, { NULL } },
  { "opt_out_setting.update", drive_opt_out_setting_update, drive_opt_out_setting_update_stream, { NULL } },
  { "permission.load", drive_permission_load, drive_permission_load_stream, { "group_id", "id", NULL } },
  { "permission.create", drive_permission_create, drive_permission_create_stream, { "group_id", NULL } },
  { "ping.list", drive_ping_list, drive_ping_list_stream, { NULL } },
  { "profile.list", drive_profile_list, drive_profile_list_stream, { NULL } },
  { "profile.load", drive_profile_load, drive_profile_load_stream, { NULL } },
  { "rcs.list", drive_rcs_list, drive_rcs_list_stream, { NULL } },
  { "sendername.list", drive_sendername_list, drive_sendername_list_stream, { NULL } },
  { "sendername.load", drive_sendername_load, drive_sendername_load_stream, { "id", NULL } },
  { "sendername.create", drive_sendername_create, drive_sendername_create_stream, { NULL } },
  { "sendername_statement.list", drive_sendername_statement_list, drive_sendername_statement_list_stream, { NULL } },
  { "sent_rcs_message.create", drive_sent_rcs_message_create, drive_sent_rcs_message_create_stream, { NULL } },
  { "shipment_country_volume.list", drive_shipment_country_volume_list, drive_shipment_country_volume_list_stream, { NULL } },
  { "short_url.list", drive_short_url_list, drive_short_url_list_stream, { NULL } },
  { "short_url.load", drive_short_url_load, drive_short_url_load_stream, { "id", NULL } },
  { "short_url.create", drive_short_url_create, drive_short_url_create_stream, { NULL } },
  { "short_url.update", drive_short_url_update, drive_short_url_update_stream, { "id", NULL } },
  { "short_url.remove", drive_short_url_remove, drive_short_url_remove_stream, { "id", NULL } },
  { "smsdo.create", drive_smsdo_create, drive_smsdo_create_stream, { NULL } },
  { "smssendername.create", drive_smssendername_create, drive_smssendername_create_stream, { "sendername_id", NULL } },
  { "smssendername.remove", drive_smssendername_remove, drive_smssendername_remove_stream, { "sender", NULL } },
  { "smstemplate.remove", drive_smstemplate_remove, drive_smstemplate_remove_stream, { "id", NULL } },
  { "subuser.list", drive_subuser_list, drive_subuser_list_stream, { "id", NULL } },
  { "subuser.load", drive_subuser_load, drive_subuser_load_stream, { "id", NULL } },
  { "subuser.create", drive_subuser_create, drive_subuser_create_stream, { NULL } },
  { "subuser.update", drive_subuser_update, drive_subuser_update_stream, { "id", NULL } },
  { "subuser.remove", drive_subuser_remove, drive_subuser_remove_stream, { "id", NULL } },
  { "template.list", drive_template_list, drive_template_list_stream, { NULL } },
  { "template.load", drive_template_load, drive_template_load_stream, { "id", NULL } },
  { "template.create", drive_template_create, drive_template_create_stream, { NULL } },
  { "template.update", drive_template_update, drive_template_update_stream, { "id", NULL } },
  { "user_rcs_sender_collection.list", drive_user_rcs_sender_collection_list, drive_user_rcs_sender_collection_list_stream, { NULL } },
  { NULL, NULL, NULL, { NULL } },
};

typedef struct {
  Drive fn;
  Streamer stream;
  voxgig_value* mtch;
} Target;

// The first operation that completes against a plain 200: with no
// arguments, else with every path parameter its points declare filled in.
static bool usable_op(Target* target) {
  SmsapiSDK* plain = smsapi_sdk_new(cmap(2,
    "apikey", v_str(CANARY_APIKEY),
    "system", cmap(1, "fetch", vfn(transport_fn, (void*)(intptr_t)SC_OK))));
  for (size_t i = 0; CANDIDATES[i].name; i++) {
    voxgig_value* filled = v_map();
    for (size_t p = 0; CANDIDATES[i].params[p]; p++) {
      setp(filled, CANDIDATES[i].params[p], v_str("p1"));
    }
    voxgig_value* tries[2] = { v_map(), filled };
    for (int t = 0; t < 2; t++) {
      voxgig_value* out = NULL;
      PNError* err = CANDIDATES[i].fn(plain, voxgig_clone(tries[t]), NULL, &out);
      if (!err) {
        target->fn = CANDIDATES[i].fn;
        target->stream = CANDIDATES[i].stream;
        target->mtch = tries[t];
        return true;
      }
    }
  }
  return false;
}

static PNError* drive(SmsapiSDK* sdk, Target* target, voxgig_value* ctrl) {
  // A caller may keep the record it passed rather than read ctrl.explain.
  voxgig_value* held = ctrl ? getp(ctrl, "explain") : NULL;
  voxgig_value* out = NULL;
  PNError* err = target->fn(sdk, voxgig_clone(target->mtch), ctrl, &out);
  if (err) {
    push_error("error", err);
  } else {
    push_value("result", out ? out : v_undef());
  }
  voxgig_value* explain = ctrl ? getp(ctrl, "explain") : NULL;
  if (v_is_map(explain)) push_value("explain", explain);
  if (v_is_map(held) && held != explain) push_value("explain:held", held);
  return err;
}

// Header maps keep the caller's spelling; the assertion should not care.
static const char* header(voxgig_value* map, const char* name) {
  if (!voxgig_is_map(map)) return NULL;
  voxgig_map* m = voxgig_as_map(map);
  for (size_t i = 0; i < m->len; i++) {
    if (0 == strcasecmp(m->entries[i].key, name)) {
      voxgig_value* v = m->entries[i].value;
      return voxgig_is_string(v) ? voxgig_as_string(v) : voxgig_stringify(v, -1);
    }
  }
  return NULL;
}

static size_t leaks(const char* text, char* found, size_t cap) {
  size_t n = 0;
  found[0] = '\0';
  for (size_t i = 0; i < NFORMS; i++) {
    if (strstr(text, FORMS[i])) {
      if (n) strncat(found, ", ", cap - strlen(found) - 1);
      strncat(found, FORMS[i], cap - strlen(found) - 1);
      n++;
    }
  }
  return n;
}

static bool ends_with(const char* s, const char* suffix) {
  size_t sl = strlen(s);
  size_t xl = strlen(suffix);
  return sl >= xl && 0 == strcmp(s + sl - xl, suffix);
}

int main(void) {
  build_forms();

  Target target;
  if (!usable_op(&target)) {
    printf("SKIP: no operation of this SDK completes against a plain 200; nothing to sweep\n");
    return 0;
  }
  Target* op = &target;

  PNError* notfound = NULL;
  voxgig_value* explained = NULL;

  for (int sc = 0; sc < SC_COUNT; sc++) {
    for (int variant = 0; variant < 3; variant++) {
      SmsapiSDK* sdk = make_sdk(sc, NULL, NULL);
      voxgig_value* explain = v_map();
      voxgig_value* ctrl = NULL;
      if (1 == variant) ctrl = cmap(1, "explain", explain);
      if (2 == variant) ctrl = cmap(2, "throw", v_bool(false), "explain", explain);
      PNError* err = drive(sdk, op, ctrl);
      if (SC_NOTFOUND == sc && 0 == variant) notfound = err;
      if (SC_OK == sc && 1 == variant) explained = explain;
      (void)SC_NAMES;
    }
  }

  // A credential mistyped as a map. The C validator defaults rather than
  // rejects, so what the constructor produced is swept instead: a string
  // quoting the value, cleaned the way a validation message is.
  SmsapiSDK* mistyped = smsapi_sdk_new(cmap(2,
    "apikey", cmap(1, "value", v_str(CANARY_APIKEY)),
    "clean", cmap(1, "values", v_str(CANARY_VALUE))));
  {
    char quoted[256];
    snprintf(quoted, sizeof(quoted), "apikey: expected string, got {\"value\":\"%s\"}",
             CANARY_APIKEY);
    push("mistyped:quoted", clean_str(sdk_get_root_ctx(mistyped), quoted));
  }

  // An error a feature hook raises, quoting the request, with explain on.
  Feature* thrower = (Feature*)calloc(1, sizeof(CaptureFeature));
  thrower->vt = &THROW_VT;
  PNError* hookerr = drive(make_sdk(SC_OK, NULL, thrower), op, cmap(1, "explain", v_map()));
  CHECK(hookerr != NULL, "the throwing hook should fail the operation");

  // The explain record a stream call is passed is cleaned however the stream
  // ends: from a feature's producer, or materialised by done.
  for (int s = 0; s < 2; s++) {
    const char* name = 0 == s ? "stream-ok" : "stream-plain";
    Feature* extra = NULL;
    if (0 == s) {
      extra = (Feature*)calloc(1, sizeof(CaptureFeature));
      extra->vt = &STREAMOK_VT;
    }
    voxgig_value* explain = v_map();
    PNError* serr = NULL;
    op->stream(make_sdk(SC_OK, NULL, extra), voxgig_clone(op->mtch),
               cmap(1, "ctrl", cmap(1, "explain", explain)), &serr);
    char label[64];
    snprintf(label, sizeof(label), "%s: only a failing stream raises", name);
    CHECK(NULL == serr, label);
    snprintf(label, sizeof(label), "%s: the explain record was not filled", name);
    CHECK(0 < voxgig_as_map(explain)->len, label);
    push_value(0 == s ? "stream-ok:explain" : "stream-plain:explain", explain);
  }

  // A feature's own error keeps its code, which is cleaned like the message:
  // returned, handed to a hook, and cleaned where a step's error skips
  // make_error.
  Feature* denier = (Feature*)calloc(1, sizeof(CaptureFeature));
  denier->vt = &DENY_VT;
  PNError* denied = drive(make_sdk(SC_OK, NULL, denier), op, NULL);
  CHECK(denied != NULL, "the refusing hook should fail the operation");
  char steppedcode[128];
  snprintf(steppedcode, sizeof(steppedcode), "stepped:%s", CANARY_VALUE);
  PNError* stepped = pn_error_new(steppedcode, "stepped");
  clean_error_util(sdk_get_root_ctx(mistyped), stepped);
  push("stepped", pn_error_str(stepped));

  // A client given no clean block at all masks by the schema defaults.
  SmsapiSDK* bare = smsapi_sdk_new(cmap(4,
    "apikey", v_str(CANARY_APIKEY),
    "secret", v_str(CANARY_SECRET),
    "headers", cmap(1, "X-Custom-Token", v_str(CANARY_HEADER)),
    "system", cmap(1, "fetch", vfn(transport_fn, (void*)(intptr_t)SC_NOTFOUND))));
  PNError* barerr = drive(bare, op, NULL);
  CHECK(barerr != NULL, "the 404 scenario must throw without a clean block");

  // The raw path returns its failure rather than an error.
  PNError* directerr = NULL;
  voxgig_value* direct = sdk_direct(make_sdk(SC_TRANSPORT, NULL, NULL),
                                    cmap(1, "path", v_str("raw")), &directerr);
  bool directok = true;
  CHECK(NULL == directerr && get_bool(direct, "ok", &directok) && !directok,
        "a transport failure should fail direct()");
  push_value("direct", direct);

  size_t nleaks = 0;
  char found[4096];
  for (size_t i = 0; i < NSINKS; i++) {
    if (leaks(SINKS[i].text, found, sizeof(found))) {
      fprintf(stderr, "credential leaked through: %s [%s]\n", SINKS[i].name, found);
      nleaks++;
    }
  }

  printf("clean: swept %zu surface(s), %zu leak(s)\n", NSINKS, nleaks);
  CHECK(0 == nleaks, "a credential leaked (see above)");

  // The positive half: the slot the credential travelled in is masked, and
  // an unregistered token in a response header is masked by name.
  CHECK(notfound != NULL, "the 404 scenario must throw");
  if (notfound) {
    CHECK_INT_EQ(to_int(getp(notfound->result, "status")), 404, "the 404 error carries its status");
    voxgig_value* headers = getp(notfound->spec, "headers");
    if (!AUTH_SUPPRESSED) {
      if (0 == strcmp(AUTH_WHERE, "query")) {
        CHECK_STR_EQ(header(getp(notfound->spec, "query"), AUTH_NAME), MASK, "the query credential is masked");
      } else if (0 == strcmp(AUTH_WHERE, "cookie")) {
        const char* cookie = header(headers, "cookie");
        CHECK(cookie && strstr(cookie, MASK), "the cookie credential is masked");
      } else {
        const char* cred = header(headers, AUTH_NAME);
        CHECK(cred && ends_with(cred, MASK), "the header credential is masked");
      }
    }
    CHECK_STR_EQ(header(headers, "x-custom-token"), MASK, "a custom token header is masked by name");
  }

  {
    char want[64];
    snprintf(want, sizeof(want), "denied:%s", MASK);
    CHECK_STR_EQ(denied ? denied->code : NULL, want, "a feature's own error code is masked");
    snprintf(want, sizeof(want), "stepped:%s", MASK);
    CHECK_STR_EQ(stepped->code, want, "clean_error masks the code");
  }
  CHECK_STR_EQ(barerr ? header(getp(barerr->spec, "headers"), "x-custom-token") : NULL, MASK,
               "a client with no clean block masks by the schema defaults");

  CHECK(explained != NULL && voxgig_is_map(getp(explained, "result")),
        "the explain record should carry the result");
  if (explained) {
    CHECK_STR_EQ(header(getp(getp(explained, "result"), "headers"), "x-session-token"), MASK,
                 "a response token header is masked by name");
  }

  // The negative control: with clean switched off the canary MUST show, or
  // the sweep is blind.
  size_t before = NSINKS;
  SmsapiSDK* raw = make_sdk(SC_NOTFOUND, cmap(1, "active", v_bool(false)), NULL);
  PNError* rawerr = drive(raw, op, NULL);
  CHECK(rawerr != NULL, "the 404 scenario must throw with clean off");
  size_t shown = 0;
  for (size_t i = before; i < NSINKS; i++) {
    if (leaks(SINKS[i].text, found, sizeof(found))) shown++;
  }
  CHECK(0 < shown, "with clean off, nothing showed the canary: the sweep is blind");
  if (rawerr && !AUTH_SUPPRESSED) {
    char* text = voxgig_jsonify(rawerr->spec, NULL);
    char pair[256];
    snprintf(pair, sizeof(pair), "%s:%s", CANARY_APIKEY, CANARY_SECRET);
    char* pairb64 = b64(pair);
    CHECK(strstr(text, CANARY_APIKEY) || strstr(text, pairb64),
          "the raw spec should carry the credential when clean is off");
  }

  // Explaining a failure must not cost it its error.
  {
    voxgig_value* out = NULL;
    PNError* explained = op->fn(make_sdk(SC_NOTFOUND, cmap(1, "active", v_bool(false)), NULL),
                                voxgig_clone(op->mtch), cmap(1, "explain", v_map()), &out);
    CHECK_STR_EQ(explained ? explained->msg : NULL, rawerr ? rawerr->msg : NULL,
                 "with clean off, explain lost the error");
  }

  // A registered value used as a property name is masked; names that mask
  // alike are all kept.
  SmsapiSDK* named = smsapi_sdk_new(cmap(1,
    "clean", cmap(1, "values", v_str("ZZVAL-abc123,ZZVAL-xyz789"))));
  voxgig_value* renamed = clean_util(sdk_get_root_ctx(named), cmap(3,
    "ZZVAL-abc123", v_num(1), "ZZVAL-xyz789", v_num(2), "plain", v_num(3)));
  voxgig_map* rm = voxgig_as_map(renamed);
  CHECK(3 == rm->len, "every masked name is kept");
  if (3 == rm->len) {
    char alt[64];
    snprintf(alt, sizeof(alt), "%s#1", MASK);
    CHECK_STR_EQ(rm->entries[0].key, MASK, "a registered value used as a name is masked");
    CHECK_STR_EQ(rm->entries[1].key, alt, "a colliding masked name takes a counter");
    CHECK_STR_EQ(rm->entries[2].key, "plain", "an ordinary name is kept");
  }

  // The generated config's own clean block is honoured, and left unchanged.
  {
    voxgig_value* config = cmap(1, "options", cmap(1, "clean", cmap(2,
      "keys", v_str("zzsens"), "values", v_str("CONFIG-SEEDED-1"))));
    CtxSpec cs;
    memset(&cs, 0, sizeof(cs));
    cs.options = cmap(1, "clean", cmap(1, "values", v_str("CALLER-SEEDED-2")));
    cs.config = config;
    Context* cctx = make_context_util(cs, NULL);
    cctx->options = make_options_util(cctx);
    char want[128];
    snprintf(want, sizeof(want), "a %s b %s", MASK, MASK);
    CHECK_STR_EQ(clean_str(cctx, "a CONFIG-SEEDED-1 b CALLER-SEEDED-2"), want,
                 "the config's and the caller's values are both masked");
    voxgig_value* out = clean_util(cctx, cmap(2, "my_zzsens", v_str("x"), "other", v_str("y")));
    CHECK_STR_EQ(get_str(out, "my_zzsens"), MASK, "the config's key name is sensitive");
    CHECK_STR_EQ(get_str(out, "other"), "y", "an ordinary name is kept");
    voxgig_value* cfgclean = getpath2(config, "options", "clean");
    CHECK_STR_EQ(get_str(cfgclean, "keys"), "zzsens", "the config's keys are left alone");
    CHECK_STR_EQ(get_str(cfgclean, "values"), "CONFIG-SEEDED-1",
                 "the config's values are left alone");
  }

  // A feature's name is not a field name: a feature called secrets does not
  // make its settings secret, though a sensitive field inside it still is. An
  // entity block, of per-entity settings or seeded records keyed by entity
  // name and id, is not read at all.
  {
    SmsapiSDK* featured = smsapi_sdk_new(cmap(3,
      "apikey", v_str(CANARY_APIKEY),
      "feature", cmap(2,
        "secrets", cmap(3,
          "active", v_bool(false),
          "name", v_str("ZZNAME-feat123"),
          "token", v_str("ZZTOKEN-feat456")),
        "test", cmap(2,
          "active", v_bool(false),
          "entity", cmap(1, "zztoken", cmap(1, "ZZTOKEN01",
            cmap(1, "note", v_str("PLAINRECORD-t5r3e1w9")))))),
      "entity", cmap(1, "zztoken", cmap(1, "alias",
        cmap(1, "zzkey", v_str("PLAINALIAS-m2n4b6v8"))))));
    Context* fctx = sdk_get_root_ctx(featured);
    char want[128];
    snprintf(want, sizeof(want), "ZZNAME-feat123 %s", MASK);
    CHECK_STR_EQ(clean_str(fctx, "ZZNAME-feat123 ZZTOKEN-feat456"), want,
                 "only the sensitive field of a feature is registered");
    CHECK_STR_EQ(clean_str(fctx, "record PLAINRECORD-t5r3e1w9"), "record PLAINRECORD-t5r3e1w9",
                 "a record seeded under an entity block is not registered");
    CHECK_STR_EQ(clean_str(fctx, "alias PLAINALIAS-m2n4b6v8"), "alias PLAINALIAS-m2n4b6v8",
                 "an entity's own settings are not registered");
  }

  TEST_SUMMARY("clean");
}
