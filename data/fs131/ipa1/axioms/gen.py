#!/usr/bin/env python3
"""FS131-IPA1: write Axioms<label>.lean — every constant declared by the named farm modules, with its axioms
(`Lean.collectAxioms`), one AX line each; SUMMARY counts constants, clean ones (a subset of the standard three) and
the others.  argv: label MOD,MOD,…  [--plant MOD]: also import a scratch module PlantSorry whose one theorem is
proved by `sorry` (the negative control), counted under its own module name."""
import sys
label, mods = sys.argv[1], sys.argv[2].split(",")
plant = "--plant" in sys.argv
imp = "".join(f"import Proofs.HadwigerNelson.Outside.{m}\n" for m in mods) + ("import PlantSorry\n" if plant else "")
names = ", ".join(f"`Proofs.HadwigerNelson.Outside.{m}" for m in mods) + (", `PlantSorry" if plant else "")
open(f"Axioms{label}.lean", "w").write(imp + f"""
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods : Array Name := #[{names}]
  let std : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]
  let mut n := 0
  let mut clean := 0
  let mut bad := 0
  for (c, _) in env.constants.map₁.toList do
    let some idx := env.getModuleIdxFor? c | continue
    let m := env.header.moduleNames[idx.toNat]!
    unless mods.contains m do continue
    let axs ← liftCoreM (collectAxioms c)
    n := n + 1
    if axs.all (std.contains ·) then clean := clean + 1
    else
      bad := bad + 1
      IO.println s!"NOTCLEAN {{m}} {{c}} {{axs}}"
  IO.println s!"SUMMARY constants={{n}} clean={{clean}} other={{bad}}"
""")
