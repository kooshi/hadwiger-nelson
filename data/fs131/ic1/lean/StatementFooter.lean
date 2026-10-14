
/-! FS131-IC1: appended to a copy of `Arith/ThreeColourCharacter.lean` (never part of the library) — prints every constant
the file declares (kind, full name, stored type with its hash, a definition's stored value), so
`data/fs131/ic1/statement_diff.py` reads the skeleton's print and the working file's. (Pattern: FS131-IU1's footer.) -/
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
