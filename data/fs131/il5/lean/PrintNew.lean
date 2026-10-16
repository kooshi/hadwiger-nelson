import Proofs.HadwigerNelson.Rigidity.MainClauseFive

/-! FS131-IL5: the new module's records as the kernel stores them — each stored type with every name in full, and each
record's axioms. Run with `lake env lean` under a slot after the build (`data/fs131/il5/print-new.log`). -/

set_option pp.fullNames true

#check @HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five
#check @HadwigerNelson.Rigidity.min_chromaticNumber_five_eq_min_localBound_five
#check @HadwigerNelson.Rigidity.localBound_bot_le_two

#print axioms HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five
#print axioms HadwigerNelson.Rigidity.min_chromaticNumber_five_eq_min_localBound_five
#print axioms HadwigerNelson.Rigidity.localBound_bot_le_two

-- the two theorems it composes, for the read-aloud: their stored types beside the new ones
#check @HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_localBound

-- every constant the compiled module declares, so nothing generated goes unseen (`LEAN.md`: `eq_1`, `congr_simp`)
open Lean in
#eval show CoreM Unit from do
  let env ← getEnv
  let some idx := env.getModuleIdx? `Proofs.HadwigerNelson.Rigidity.MainClauseFive
    | throwError "module not loaded"
  let names := (env.header.moduleData[idx.toNat]!).constNames
  IO.println s!"constants declared by the module: {names.size}"
  for n in names do IO.println s!"  {n}"
