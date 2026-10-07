namespace FS132I1
open Lean
/-- Level one: one constant the statements name, as the kernel holds it at this pin — kind, universe parameters,
type, and what fixes its meaning one step down (a definition's value; an inductive type's constructors with their
types; nothing for a theorem, whose proof no statement reads). One line, so two pins compare line by line. -/
def level1 (n : Name) : CoreM Unit := do
  let env ← getEnv
  match env.find? n with
  | none => IO.println s!"L1 {n} | ABSENT"
  | some ci =>
    let m := match env.getModuleIdxFor? n with
      | some i => toString env.header.moduleNames[i.toNat]!
      | none => "(this file)"
    let body ← match ci with
      | .defnInfo d => pure s!"def | value = {dump d.value}"
      | .thmInfo _ => pure "theorem |"
      | .axiomInfo _ => pure "axiom |"
      | .opaqueInfo _ => pure "opaque |"
      | .inductInfo v => do
          let mut s := s!"inductive params={v.numParams} indices={v.numIndices} |"
          for c in v.ctors do
            let some cc := env.find? c | pure ()
            s := s ++ s!" ctor {c} : {dump cc.type} ;"
          pure s
      | .ctorInfo _ => pure "ctor |"
      | .recInfo _ => pure "rec |"
      | .quotInfo _ => pure "quot |"
    IO.println s!"L1 {n} | levels={ci.levelParams} | type = {dump ci.type} | {body}"
    IO.println s!"L1MOD {n} @ {m}"
end FS132I1
