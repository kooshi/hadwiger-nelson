
/-! FS131-ID1: appended to a copy of `Arith/DyadicQuadratic.lean` (never part of the library) — prints every constant the
file declares (kind, full name, stored type with its hash, a definition's stored value), so `statement_diff.py` reads
the skeleton's print and the working file's.  (Pattern: `data/fs131/iu1/lean/StatementFooter.lean`, branch fs131-wnf.) -/
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
