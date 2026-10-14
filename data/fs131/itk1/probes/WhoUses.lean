import Proofs.HadwigerNelson.Rigidity.WanderingShells
open Lean Elab Command
/-! FS131-ITK1 probe: which declarations' stored proofs name the generated `congr_simp` constants. -/
def targets : List Name := [`HadwigerNelson.Rigidity.SAdeleRing.congr_simp, `HadwigerNelson.Rigidity.TateModel.congr_simp,
  `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp, `HadwigerNelson.Rigidity.multiplier.congr_simp,
  `HadwigerNelson.Rigidity.splitHeight.congr_simp]
#eval show CommandElabM Unit from do
  let env ← getEnv
  for d in env.header.moduleData do
    for ci in d.constants do
      let n := ci.name
      let val : Option Expr := match ci with | .thmInfo v => some v.value | .defnInfo v => some v.value | _ => none
      if let some v := val then
        for t in targets do
          if v.getUsedConstants.contains t then IO.println s!"{n} USES {t}"
example : True := by
  open HadwigerNelson.Rigidity in
  trivial
