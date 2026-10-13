
/-! FS131-IV1: appended to a copy of `Instances/UpperHalfValues.lean` (never part of the library) — prints every constant the file
declares, in the format of `data/fs131/iv1/lean/StatementDump.lean`, so `statement_diff.py` reads both. -/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let kindOf : ConstantInfo → String := fun
    | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
    | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"
  let cs := env.constants.map₂.toList
  IO.println s!"## FILE constants={cs.length}"
  for (n, ci) in cs do
    let flag := if n.isInternalDetail then " INTERNAL" else ""
    IO.println s!"@@ {kindOf ci} {n}{flag}"
    IO.println s!"TYPE {ci.type.hash} {ci.type}"
    match ci with
    | .defnInfo v => IO.println s!"VALUE {v.value.hash} {v.value}"
    | _ => pure ()
