import Proofs.HadwigerNelson.Arith.ThreeFourColours
/-! FS131-KJ1 — every named constant of the line's compiled modules as the kernel holds it, one line each:

  STMT <module> <THM|DEF|…> <full name> type=<hash of the stored type> [value=<hash of a definition's stored value>]

Private names and names Lean generates inside a declaration are skipped (they move with a proof and are not statements).
The hash is `Expr.hash` (structural; bound-variable names do not enter it). Made once after the first build of the joined
tree, when each module is byte-identical to its branch's head, and once after the last build; the reader
(`data/fs131/kj1/statement_diff.py`) requires every line of the first in the second. Pattern: `data/fs131/in1/lean/StatementDump.lean`. -/
open Lean Elab Command
namespace FS131KJ1Dump
def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"
def run (mods : List Name) : CommandElabM Unit := do
  let env ← getEnv
  for m in mods do
    let some i := env.header.moduleNames.findIdx? (· == m) | throwError "module {m} is not imported: nothing to dump"
    let d := env.header.moduleData[i]!
    let mut rows : Array String := #[]
    for ci in d.constants do
      let n := ci.name
      if n.isInternalDetail || (privateToUserName? n).isSome then continue
      let v := match ci with | .defnInfo v => s!" value={v.value.hash}" | _ => ""
      rows := rows.push s!"STMT {m.components.getLast!} {kindOf ci} {n} type={ci.type.hash}{v}"
    for r in rows.qsort (· < ·) do IO.println r
    IO.println s!"COUNT {m.components.getLast!} {rows.size}"
#eval run [`Proofs.HadwigerNelson.Arith.ThreeColourCharacter, `Proofs.HadwigerNelson.Arith.TorsionExtraction,
  `Proofs.HadwigerNelson.Arith.ThreeColourCriterion, `Proofs.HadwigerNelson.Arith.DyadicQuadratic,
  `Proofs.HadwigerNelson.Arith.UpperHalf, `Proofs.HadwigerNelson.Arith.QuadraticPrime,
  `Proofs.HadwigerNelson.Instances.UpperHalfValues, `Proofs.HadwigerNelson.Arith.ThreeFourColours]
end FS131KJ1Dump
