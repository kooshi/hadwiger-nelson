import Proofs
/-! FS131-IC1 probe: the compiled data of `Arith/ThreeColourCharacter` holds two theorems Lean generated on demand for
definitions of the upstream module `ThreeColour` (`relMap.eq_1`, `minRise.eq_1`). Which modules of the built library
hold a constant of each name?  (`scripts/dupnames.sh` counts and lists that class without failing; this says whether
this module adds a second copy of either.)  Read-only. -/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let names : List Name := [`HadwigerNelson.ThreeColour.relMap.eq_1, `HadwigerNelson.ThreeColour.minRise.eq_1]
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  IO.println s!"modules imported: {mods.size}"
  for n in names do
    let mut holders : Array Name := #[]
    for i in [0:mods.size] do
      if data[i]!.constants.any (·.name == n) then holders := holders.push mods[i]!
    IO.println s!"HOLDERS {n} : {holders.size} : {holders.toList}"
  -- control: a name every reader knows is declared once, and one that is declared nowhere
  for n in [`HadwigerNelson.ThreeColour.nonempty_winding, `HadwigerNelson.ThreeColour.no_such_name] do
    let mut k := 0
    for i in [0:mods.size] do
      if data[i]!.constants.any (·.name == n) then k := k + 1
    IO.println s!"CONTROL {n} : {k}"
