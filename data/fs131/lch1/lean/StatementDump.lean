import Proofs
/-!
FS131-LCH1 — every constant of every `Proofs.*` module of the tree it is run in, as the kernel holds it: read-only.
FS131-IJN1's dumper (`data/fs131/ijn1/lean/StatementDump.lean`), its module list replaced by the whole root and its
output written to a file (LEAN.md: `#eval` holds what it prints). Two modes per module:

  FULL (a module whose name starts with one of the comma-separated prefixes in `$LCH1_FULL`):
    @@ <KIND> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
    TYPE <hash> <the stored type, raw>
    VALUE <hash> <the stored value, raw>                                   (definitions only)
    DATA <hash> <the stored value, every proof subterm erased to `True.intro`>  (definitions of a non-proposition)
  HASH (every other module): the same `@@` and `TYPE` lines; `VALUE <hash>` with no text, no `DATA`.

Run from inside a worktree against its compiled library:
  LCH1_OUT=<file> LCH1_FULL=<prefixes> lake env lean data/fs131/lch1/lean/StatementDump.lean
-/
open Lean Elab Command Meta

namespace FS131LCH1Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def eraseProofArgs (v : Expr) : MetaM Expr :=
  Meta.transform v (pre := fun e => do
    if e.isSort || e.isConst then return .continue
    if ← (try isProof e catch _ => pure false) then return .done (mkConst ``True.intro) else return .continue)

def run : CommandElabM Unit := do
  let env ← getEnv
  let some out ← IO.getEnv "LCH1_OUT" | throwError "LCH1_OUT is not set: nothing written"
  let full := ((← IO.getEnv "LCH1_FULL").getD "").splitOn "," |>.filter (· ≠ "")
  let h ← IO.FS.Handle.mk out .write
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut nMods := 0
  let mut nConsts := 0
  for i in [0:mods.size] do
    let m := mods[i]!
    unless (`Proofs).isPrefixOf m do continue
    nMods := nMods + 1
    let isFull := full.any fun p => m.toString.startsWith p
    let d := data[i]!
    h.putStrLn s!"## MODULE {m} constants={d.constants.size} mode={if isFull then "FULL" else "HASH"}"
    for ci in d.constants do
      nConsts := nConsts + 1
      let n := ci.name
      let flag := match privateToUserName? n with
        | some u => if u.isInternalDetail then " INTERNAL" else s!" PRIVATE {u}"
        | none => if n.isInternalDetail then " INTERNAL" else ""
      let isP ← liftTermElabM <| isProp ci.type
      let pflag := if isP then " PROPTYPE" else ""
      h.putStrLn s!"@@ {kindOf ci} {n}{flag}{pflag}"
      h.putStrLn s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v =>
        if isFull then
          h.putStrLn s!"VALUE {v.value.hash} {v.value}"
          unless isP do
            let e ← liftTermElabM <| eraseProofArgs v.value
            h.putStrLn s!"DATA {e.hash} {e}"
        else
          h.putStrLn s!"VALUE {v.value.hash}"
      | _ => pure ()
  h.putStrLn s!"## END modules={nMods} constants={nConsts}"
  h.flush
  IO.println s!"wrote {out}: modules={nMods} constants={nConsts}"

#eval run

end FS131LCH1Dump
