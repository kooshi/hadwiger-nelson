import Proofs.HadwigerNelson.Rigidity.CountResidue
import Proofs.HadwigerNelson.Rigidity.TateModel
/-! FS131-IJ1, item (2): `Counting.toL` and lane T's `ofUnitRing` are one map — from the kernel's side. -/
open Lean Meta Elab Command

-- (a) the elaborator and the kernel accept the equation by `rfl`, for every subfield
theorem FS131IJ1_toL_eq_ofUnitRing (F : Subfield ℝ) : HadwigerNelson.Rigidity.Counting.toL F = HadwigerNelson.Rigidity.ofUnitRing F := rfl
#print axioms FS131IJ1_toL_eq_ofUnitRing

-- (b) the two stored types are the same expression, and the two stored values are the same expression once every proof
-- subterm is erased (they differ only in the names of their auxiliary proofs `toL._proof_1`, `ofUnitRing._proof_1`)
def eraseProofs (v : Expr) : MetaM Expr :=
  Meta.transform v (pre := fun e => do
    if e.isSort || e.isConst then return .continue
    if ← (try isProof e catch _ => pure false) then return .done (mkConst ``True.intro) else return .continue)

#eval show CommandElabM Unit from do
  let env ← getEnv
  let some a := env.find? ``HadwigerNelson.Rigidity.Counting.toL | throwError "toL not found"
  let some b := env.find? ``HadwigerNelson.Rigidity.ofUnitRing | throwError "ofUnitRing not found"
  IO.println s!"toL        TYPE {a.type.hash}"
  IO.println s!"ofUnitRing TYPE {b.type.hash}"
  IO.println s!"types equal: {a.type == b.type}"
  let (some va, some vb) := (a.value?, b.value?) | throwError "no value"
  IO.println s!"values equal as stored: {va == vb}"
  let ea ← liftTermElabM <| eraseProofs va
  let eb ← liftTermElabM <| eraseProofs vb
  IO.println s!"values equal, proofs erased: {ea == eb}  (hashes {ea.hash} {eb.hash})"
  IO.println s!"toL        VALUE {va}"
  IO.println s!"ofUnitRing VALUE {vb}"
