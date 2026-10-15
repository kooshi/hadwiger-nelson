import Proofs.HadwigerNelson.Rigidity.CountResidue
/-!
FS131-IJN1 — for a ruled drop of an anonymous instance binder (whose stored name is hygienic): the stored type of
`Counting.ratio_unramified_of_tca` (the cascade of the drop in `noRamifiedStableDyadic_of_tca`) with its first instance-implicit `∀`-binder whose type's head is `NumberField` removed,
refused if the body depends on it; computed on the build before any such drop is compiled, printed in the dump's format.
  lake env lean data/fs131/ijn1/lean/DropExpect3.lean > data/fs131/ijn1/drop-expect-3.txt
-/
open Lean Elab Command Meta

namespace FS131IJN1Drop3

partial def dropInst (head : Name) : Expr → Option Expr
  | .forallE n t b bi =>
    if bi == .instImplicit && t.getAppFn.constName? == some head then
      if b.hasLooseBVar 0 then none else some (b.lowerLooseBVars 1 1)
    else (dropInst head b).map fun b' => .forallE n t b' bi
  | _ => none

def run : CommandElabM Unit := do
  let c := `HadwigerNelson.Rigidity.Counting.ratio_unramified_of_tca
  let some ci := (← getEnv).find? c | throwError "{c}: not in the environment"
  let some t := dropInst `NumberField ci.type | throwError "{c}: no independent `NumberField` instance binder"
  IO.println s!"@@ {c} DROP [NumberField instance]"
  IO.println s!"BEFORE {ci.type.hash} {ci.type}"
  IO.println s!"EXPECT {t.hash} {t}"

#eval run

end FS131IJN1Drop3
