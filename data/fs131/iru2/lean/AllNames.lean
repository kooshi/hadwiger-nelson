import Proofs
/-! FS131-IRU2 — every constant of the compiled library `Proofs` (the root's whole import closure), by module and name, written
to the file `$OUT` (after FS131-LDB1's `MainNames.lean`, which printed to stdout). Run once against this branch's build before
the copy and once against `main`'s gated build, then intersect by name the constants the two lines declare in different modules. -/
open Lean Elab Command
#eval show CommandElabM Unit from do
  let env ← getEnv
  let some out ← IO.getEnv "OUT" | throwError "set OUT"
  let h ← IO.FS.Handle.mk out .write
  let mods := env.header.moduleNames
  let mut n : Nat := 0
  for i in [0:mods.size] do
    let m := mods[i]!
    unless (`Proofs).isPrefixOf m do continue
    for ci in env.header.moduleData[i]!.constants do
      n := n + 1
      h.putStrLn s!"{m} {ci.name}"
  h.flush
  logInfo m!"TOTAL {n}"
