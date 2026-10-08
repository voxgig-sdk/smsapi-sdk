# Smsapi SDK Contactstrash entity
#
# Per-entity module. Generic construction/data/match operations delegate to
# EntityBase; each active op (load/list/create/update/patch/remove) builds a ctx
# and drives it through Smsapi.Pipeline.run_op.

defmodule Smsapi.Entity.Contactstrash do
  alias Voxgig.Struct, as: S
  alias Smsapi.Helpers, as: H
  alias Smsapi.{EntityBase, Context, Pipeline}

  def new(client, entopts \\ nil) do
    EntityBase.construct(__MODULE__, client, "contactstrash", entopts)
  end

  def get_name(ent), do: EntityBase.get_name(ent)
  def make(ent), do: EntityBase.make(ent)
  def data_set(ent, args \\ nil), do: EntityBase.data_set(ent, args)
  def data_get(ent), do: EntityBase.data_get(ent)
  def match_set(ent, args \\ nil), do: EntityBase.match_set(ent, args)
  def match_get(ent), do: EntityBase.match_get(ent)

  # Streaming operation (see EntityBase.stream): runs `action` through the
  # pipeline and returns a lazy Stream over result items.
  def stream(ent, action, args \\ nil, callopts \\ nil),
    do: EntityBase.stream(ent, action, args, callopts)

  

  

  

  
  # Returns the updated contactstrash entity, whose data_get/1 reads its record
  # (Smsapi.Types.contactstrash/0), on success; pipeline errors surface as
  # the error value built by Utility.make_error (shape is
  # utility-configurable), hence term().
  @spec update(map(), Smsapi.Types.contactstrash_update_data() | nil, map() | nil) :: term()
  def update(ent, reqdata, ctrl \\ nil) do
    ctx =
      Context.new(
        S.jm([
          "opname", "update",
          "ctrl", ctrl,
          "match", S.getprop(ent, "_match"),
          "data", S.getprop(ent, "_data"),
          "reqdata", reqdata
        ]),
        S.getprop(ent, "_entctx")
      )

    post_done = fn ->
      result = S.getprop(ctx, "result")

      if result != nil do
        rm = S.getprop(result, "resmatch")
        if rm != nil, do: S.setprop(ent, "_match", rm)
        rd = S.getprop(result, "resdata")
        if rd != nil, do: S.setprop(ent, "_data", H.or_(H.to_map(S.clone(rd)), S.jm([])))
      end
    end

    out = Pipeline.run_op(ctx, post_done)
    EntityBase.op_return(ent, ctx, out)
  end



  

  
  # Returns the removed contactstrash entity, marked as deleted, whose data_get/1
  # reads the record it held (Smsapi.Types.contactstrash/0), on success;
  # pipeline errors surface as the error value built by Utility.make_error
  # (shape is utility-configurable), hence term().
  @spec remove(map(), Smsapi.Types.contactstrash_remove_match() | nil, map() | nil) :: term()
  def remove(ent, reqmatch \\ nil, ctrl \\ nil) do
    reqmatch = if reqmatch == nil, do: S.jm([]), else: reqmatch

    ctx =
      Context.new(
        S.jm([
          "opname", "remove",
          "ctrl", ctrl,
          "match", S.getprop(ent, "_match"),
          "data", S.getprop(ent, "_data"),
          "reqmatch", reqmatch
        ]),
        S.getprop(ent, "_entctx")
      )

    post_done = fn ->
      result = S.getprop(ctx, "result")

      if result != nil do
        rm = S.getprop(result, "resmatch")
        if rm != nil, do: S.setprop(ent, "_match", rm)
        rd = S.getprop(result, "resdata")
        if rd != nil, do: S.setprop(ent, "_data", H.or_(H.to_map(S.clone(rd)), S.jm([])))
      end
    end

    out = Pipeline.run_op(ctx, post_done)
    ent = EntityBase.op_return(ent, ctx, out)
    # A removed entity keeps its data but is no longer a live record.
    if ent == out, do: out, else: EntityBase.mark_deleted(ent)
  end


end
