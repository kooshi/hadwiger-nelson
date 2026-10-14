#!/usr/bin/env python3
"""FS131-LDB1: the landing's edits to the density bound's Lean files, in text — every character outside block comments
(docstrings `/-- … -/` and module docs `/-! … -/` are block comments) is the same at the branch's head before the merge
(`9fe574044`, FS131-IDB3's last commit) and now, in every one of the 83 modules (`Plane/DensityBound/*`, `Cells/*`,
`Plane/OneAvoidingDensity`); the six files this landing reworded (`data/fs131/ldb1/docstring-edits.py`) are required to
differ from the base in their block comments, so an edit that did not happen fails too.  FS133-LD1's
`tools/fs133_ld1_code_only.py` (its `strip`, copied) with this landing's files.

  EDITS  OneAvoidingDensity  the coordinator's ruling (the brief's Amendment, 2026-10-14 19:56 UTC: option (a) with a
                             bridge): the import of `Plane/OneClass/Defs` added; this line's `def mOne` deleted and, in
                             its place, the bridge `mOne_eq_iSup_bandFree`, whose right-hand side is the deleted
                             definition's text; `mOne_le_of_oneAvoidingDensityBound`'s proof routed through the bridge.
                             Each listed edit is applied to the old code once (it must occur exactly once) before the
                             comparison, and its result must occur once in the new code.

Usage: fs131_ldb1_code_only.py BASE_COMMIT [--plant]
--plant alters one code character of each file in memory (the first `:=` after the imports becomes `:≡`): every file
must then read DIFFERS.  Exit 0: every file as expected (with --plant: every file DIFFERS); 1 otherwise.
"""
import re
import subprocess
import sys

D = "Proofs/HadwigerNelson/Plane/"
EDITED = [D + "OneAvoidingDensity.lean"] + [D + "DensityBound/" + f + ".lean"
                                             for f in ("Autocorr", "Window", "BesselDefect", "Bessel", "Pattern")]


OAD = D + "OneAvoidingDensity.lean"
BRIDGE = """theorem mOne_eq_iSup_bandFree :
    mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A := by
  rw [mOne_eq_iSup_nullMeasurableSet]
  refine iSup_congr fun A => ?_
  rw [iSup_and]
  refine iSup_congr fun _ => ?_
  have h : (unitDistance ℂ).IsIndepSet A ↔ BandFree A 0 := by
    rw [isIndepSet_unitDistance_iff]
    simp only [BandFree, sub_zero, add_zero]
    exact forall₂_congr fun x _ => forall₂_congr fun y _ => ne_iff_lt_or_gt
  exact iSup_congr_Prop h fun _ => rfl"""
EDITS = {OAD: [
    ("import Proofs.HadwigerNelson.Plane.Suprema import Mathlib.Analysis.InnerProductSpace.PiL2",
     "import Proofs.HadwigerNelson.Plane.Suprema import Proofs.HadwigerNelson.Plane.OneClass.Defs "
     "import Mathlib.Analysis.InnerProductSpace.PiL2"),
    ("noncomputable def mOne : ENNReal := ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A",
     BRIDGE),
    ("mOne ≤ ENNReal.ofReal 0.2470 := iSup₂_le fun _ hA =>",
     "mOne ≤ ENNReal.ofReal 0.2470 := mOne_eq_iSup_bandFree ▸ iSup₂_le fun _ hA =>"),
]}


def strip(src):
    out, i, depth, n = [], 0, 0, len(src)
    while i < n:
        two = src[i:i + 2]
        if two == "/-":
            depth += 1
            i += 2
        elif two == "-/" and depth:
            depth -= 1
            i += 2
        else:
            if not depth:
                out.append(src[i])
            i += 1
    if depth:
        raise SystemExit("unbalanced block comment")
    return re.sub(r"\s+", " ", "".join(out)).strip()


args = [a for a in sys.argv[1:] if not a.startswith("--")]
plant = "--plant" in sys.argv
base = args[0]
files = sorted(subprocess.run(["git", "ls-tree", "-r", "--name-only", base, "--", D + "DensityBound",
                               D + "OneAvoidingDensity.lean"], capture_output=True, text=True, check=True)
               .stdout.split())
now = sorted(subprocess.run(["git", "ls-files", "--", D + "DensityBound", D + "OneAvoidingDensity.lean"],
                            capture_output=True, text=True, check=True).stdout.split())
bad = 0
if len(files) != 83 or files != now:
    print(f"FILES: {len(files)} at the base, {len(now)} now; the lists differ: {sorted(set(files) ^ set(now))[:5]}")
    bad += 1
same_n = 0
for f in files:
    old_src = subprocess.run(["git", "show", f"{base}:{f}"], capture_output=True, text=True, check=True).stdout
    new_src = open(f, encoding="utf-8").read()
    a, b = strip(old_src), strip(new_src)
    note = ""
    for x, y in EDITS.get(f, []):
        x, y = re.sub(r"\s+", " ", x).strip(), re.sub(r"\s+", " ", y).strip()
        if a.count(x) != 1:
            note += f" [listed edit found {a.count(x)} times in the old code: {x[:50]}]"
        a = a.replace(x, y)
        if b.count(y) != 1:
            note += f" [listed edit's result found {b.count(y)} times in the new code: {y[:50]}]"
    if plant:
        k = b.find(":=", b.rfind("import ") if "import " in b else 0)
        b = b[:k] + ":≡" + b[k + 2:]
    same = a == b
    edited = old_src != new_src
    want_edited = f in EDITED
    ok = same and (edited == want_edited) and not note
    if f in EDITED or not ok or plant:
        print(f"{'AS-LISTED' if ok else 'DIFFERS  '} {f}: code {'the same' if same else 'CHANGED'}; "
              f"text {'reworded' if edited else 'untouched'} ({'listed' if want_edited else 'not listed'}); "
              f"{len(EDITS.get(f, []))} listed code edit(s){note}")
    same_n += ok
    bad += ok if plant else not ok
print(f"files read: {len(files)}; as listed: {same_n}")
print(("plant: " if plant else "") + ("OK" if not bad else f"FAIL ({bad})"))
sys.exit(1 if bad else 0)
