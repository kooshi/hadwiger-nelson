import Proofs.HadwigerNelson.Plane.DensityBound.Theorem
/-!
FS131-LDB1 — the two stored types the ruled import moved, checked by the kernel.

`Plane/OneAvoidingDensity` now imports `Plane/OneClass/Defs` (the coordinator's ruling, the brief's Amendment), which brings
the port's `CommCStarAlgebra ℂ` into `Plane/DensityBound/Window`'s closure; there the stored types of
`DualCert.window_le` and `DualCert.limsup_le` take `NormedCommRing ℂ` through `CommCStarAlgebra.toNormedCommRing ℂ
instCommCStarAlgebraComplex` where they took `NormedField.toNormedCommRing ℂ Complex.instNormedField` (three times each).

For each of the two: the old stored type is rebuilt from the new by replacing exactly that instance term by the old one
(`Expr.replace`), its hash printed against the dump made before the merge (`OLD-HASH`: must equal the dump's), and the
kernel is asked to accept `Eq.refl new : old = new` as a theorem (`Environment.addDeclCore`, the kernel's check on): `KERNEL-OK`
or `KERNEL-REFUSED`. The control asks the same with the other theorem's type on the right, which the kernel must refuse;
and the two instance terms themselves are compared the same way (`INSTANCES`).
-/
open Lean Elab Command Meta

namespace FS131LDB1InstanceCheck

def newInst : Expr := mkApp2 (mkConst ``CommCStarAlgebra.toNormedCommRing [0]) (mkConst ``Complex)
  (mkConst ``instCommCStarAlgebraComplex)
def oldInst : Expr := mkApp2 (mkConst ``NormedField.toNormedCommRing [0]) (mkConst ``Complex)
  (mkConst ``Complex.instNormedField)

/-- The number of occurrences of `p` in `e`, structurally. -/
partial def countOcc (e p : Expr) : Nat :=
  if e == p then 1 else
  match e with
  | .app f a => countOcc f p + countOcc a p
  | .lam _ t b _ => countOcc t p + countOcc b p
  | .forallE _ t b _ => countOcc t p + countOcc b p
  | .letE _ t v b _ => countOcc t p + countOcc v p + countOcc b p
  | .mdata _ b => countOcc b p
  | .proj _ _ b => countOcc b p
  | _ => 0

/-- Ask the kernel to accept `Eq.refl rhs : lhs = rhs` (both `Prop`s) as a theorem named `nm`. -/
def kernelEq (nm : Name) (lhs rhs : Expr) (ty : Expr := mkSort 0) (lvl : Level := 1) : CommandElabM Bool := do
  let env ← getEnv
  let decl := Declaration.thmDecl {
    name := nm, levelParams := [],
    type := mkApp3 (mkConst ``Eq [lvl]) ty lhs rhs,
    value := mkApp2 (mkConst ``Eq.refl [lvl]) ty rhs }
  match Environment.addDeclCore env 0 decl none with
  | .ok _ => return true
  | .error _ => return false

def run : CommandElabM Unit := do
  let env ← getEnv
  let olds : List (Name × UInt64) :=
    [(`HadwigerNelson.DensityBound.DualCert.window_le, 3481863677),
     (`HadwigerNelson.DensityBound.DualCert.limsup_le, 2608129148)]
  let mut types : Array Expr := #[]
  for (n, oldHash) in olds do
    let some ci := env.find? n | throwError "missing {n}"
    let t := ci.type
    let tOld := t.replace fun e => if e == newInst then some oldInst else none
    IO.println s!"{n}: new-instance occurrences {countOcc t newInst}, after the replacement {countOcc tOld newInst}; old-instance occurrences after {countOcc tOld oldInst}"
    IO.println s!"OLD-HASH {n} rebuilt={tOld.hash} dump-before={oldHash} {if tOld.hash == oldHash then "MATCH" else "DIFFERS"}"
    let ok ← kernelEq (n ++ `_ldb1_old_eq_new) tOld t
    IO.println s!"{if ok then "KERNEL-OK" else "KERNEL-REFUSED"} {n}: Eq.refl new : old = new"
    types := types.push tOld |>.push t
  -- the control: window_le's old type against limsup_le's new type
  let ok ← kernelEq `FS131LDB1InstanceCheck.plant types[0]! types[3]!
  IO.println s!"CONTROL {if ok then "ACCEPTED (the check is blind)" else "REFUSED (as it must be)"}: window_le's old type = limsup_le's new type"
  -- the two instance terms
  let ty := mkApp (mkConst ``NormedCommRing [0]) (mkConst ``Complex)
  let ok ← kernelEq `FS131LDB1InstanceCheck.inst oldInst newInst ty 1
  IO.println s!"INSTANCES {if ok then "KERNEL-OK" else "KERNEL-REFUSED"}: NormedField.toNormedCommRing ℂ = CommCStarAlgebra.toNormedCommRing ℂ"

#eval run

end FS131LDB1InstanceCheck
