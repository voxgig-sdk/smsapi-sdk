// OptOut entity client (generated). Shared entity runtime (data/match
// state, entity context, the runOp pipeline + feature hooks) lives in
// EntityBase (core/types.hpp); this class binds the entity name and its
// supported CRUD operations.

#pragma once

#include <memory>

#include "../core/types.hpp"

namespace sdk {

class OptOutEntity : public EntityBase {
public:
  OptOutEntity(SdkClient* client, Value entopts = Value::undef())
      : EntityBase("opt_out", client, entopts) {}

  EntityPtr make() override {
    Value opts = vmap();
    if (this->entopts.is_map()) {
      for (const auto& kv : *this->entopts.as_map()) {
        map_put(opts, kv.first, kv.second);
      }
    }
    return std::make_shared<OptOutEntity>(this->client, opts);
  }

  SdkEntityPtr load(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("load", this->name_);
    }


    std::vector<SdkEntityPtr> list(const Value& reqmatch, const Value& ctrl) override {
      CtxSpec cs;
      cs.setOpname("list");
      cs.ctrlMap = ctrl.is_map() ? ctrl : vmap();
      cs.match = this->match_;
      cs.data = this->data_;
      cs.reqmatch = reqmatch.is_map() ? reqmatch : vmap();
      CtxPtr ctx = this->utility->makeContext(cs, this->entctx);
  
      Value out = runOp(ctx, [this, ctx]() {
        if (ctx->result) {
          if (ctx->result->resmatch.is_map()) {
            this->match_ = ctx->result->resmatch;
          }
        }
      });
  
      // `list` resolves to one ENTITY per record. makeResult cannot build them
      // here - it works in Value, which has no slot for an entity - so the op
      // does, mirroring what the dynamic targets get from makeResult.
      std::vector<SdkEntityPtr> items;
      if (out.is_list()) {
        for (const auto& entry : *out.as_list()) {
          SdkEntityPtr ent = std::static_pointer_cast<SdkEntity>(this->make());
          if (entry.is_map()) {
            ent->data(entry);
          }
          items.push_back(ent);
        }
      }
  
      return items;
    }
  

  SdkEntityPtr create(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("create", this->name_);
    }

  SdkEntityPtr update(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("update", this->name_);
    }

  SdkEntityPtr patch(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("patch", this->name_);
    }


    SdkEntityPtr remove(const Value& reqmatch, const Value& ctrl) override {
      CtxSpec cs;
      cs.setOpname("remove");
      cs.ctrlMap = ctrl.is_map() ? ctrl : vmap();
      cs.match = this->match_;
      cs.data = this->data_;
      cs.reqmatch = reqmatch.is_map() ? reqmatch : vmap();
      CtxPtr ctx = this->utility->makeContext(cs, this->entctx);
  
      runOp(ctx, [this, ctx]() {
        if (ctx->result) {
          if (ctx->result->resmatch.is_map()) {
            this->match_ = ctx->result->resmatch;
          }
        }
      });
  
      // The operation resolves to THIS entity: runOp has just absorbed the
      // result into it, and the caller reaches the record through data().
      // See AGENTS.md "Entity operations return ENTITIES".
  
      // A removed entity keeps its data but is no longer a live record.
      this->markDeleted();
  
      return this->self();
    }
  
};

} // namespace sdk
