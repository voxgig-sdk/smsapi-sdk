package voxgig.smsapisdk.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.smsapisdk.core.Context;
import voxgig.smsapisdk.core.Entity;
import voxgig.smsapisdk.core.Helpers;
import voxgig.smsapisdk.core.SdkClient;
import voxgig.smsapisdk.utility.struct.Struct;

/** ContactsFieldOption entity client for the Smsapi SDK. */
@SuppressWarnings({"unchecked", "unused"})
public class ContactsFieldOptionEntity extends EntityBase {

  public ContactsFieldOptionEntity(SdkClient client, Map<String, Object> entopts) {
    super("contacts_field_option", client, entopts);
  }

  @Override
  public Entity make() {
    Map<String, Object> opts = new LinkedHashMap<>(this.entopts);
    return new ContactsFieldOptionEntity(this.client, opts);
  }

  @Override
  public Object load(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("load", this.name);
  }



  @Override
  public Object list(Map<String, Object> reqmatch, Map<String, Object> ctrl) {
    Map<String, Object> ctxmap = new LinkedHashMap<>();
    ctxmap.put("opname", "list");
    ctxmap.put("ctrl", ctrl);
    ctxmap.put("match", this.match);
    ctxmap.put("data", this.data);
    ctxmap.put("reqmatch", reqmatch);
    Context ctx = this.utility.makeContext.apply(ctxmap, this.entctx);

    return runOp(ctx, () -> {
      if (ctx.result != null) {
        if (ctx.result.resmatch != null) {
          this.match = ctx.result.resmatch;
        }
      }
    });
  }



  @Override
  public Object create(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("create", this.name);
  }


  @Override
  public Object update(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("update", this.name);
  }


  @Override
  public Object patch(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("patch", this.name);
  }


  @Override
  public Object remove(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("remove", this.name);
  }

}
