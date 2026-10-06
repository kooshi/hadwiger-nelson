#!/usr/bin/env python3
"""FS131-I6A: negative controls on the module itself — is `Plane/Saturated/Pinch` elaborated, and do its models bite?

Each plant alters an in-memory copy of Pinch.lean, writes it to data/fs131/i6a/PlantScratch.lean (outside the library),
elaborates it with `lake env lean` (autoImplicit off) and requires AT LEAST ONE ERROR; the unplanted copy must elaborate
with NO error first (otherwise a red plant proves nothing). The tree's file is never written.

  false      appends `example : (1 : ℕ) = 2 := by decide`                (the file is elaborated, not skipped)
  contact    the pinch model's first contact moved to `sqEdgePt + 2`     (the model's distance clause is checked)
  half       the HALF model's bound sharpened from `1 / 2` to `1 / 3`    (the theorem gives 1/2 and no better)
  split      the split model's centre moved from `0` to `1`              (IsSplitAt reads its centre)
  hdisj      `hasTwoDiscsAt_of_out_out` used without almost-disjointness: its `hdisj` replaced by `True`
  cover      `pinch_not_in_in`'s `hcover` replaced by `True`             (the cover is read)

Exit 0: the clean copy is green and every plant is red. Exit 1 otherwise; exit 2 if a plant's target text is missing."""
import re, subprocess, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = (ROOT / "Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean").read_text()
SCR = ROOT / "data/fs131/i6a/PlantScratch.lean"
PLANTS = {
    "false": ("\nend HadwigerNelson.Plane", "\nexample : (1 : ℕ) = 2 := by decide\n\nend HadwigerNelson.Plane"),
    "contact": ("(ball sqEdgePt (1 / 8)) sqEdgePt (sqEdgePt + 1) ∨\n", "(ball sqEdgePt (1 / 8)) sqEdgePt (sqEdgePt + 2) ∨\n"),
    "half": ("example : ∃ P : Set ℂ, P.Nonempty ∧ upperDensityAt P sqEdgePt ≤ 1 / 2 := by", "example : ∃ P : Set ℂ, P.Nonempty ∧ upperDensityAt P sqEdgePt ≤ 1 / 3 := by"),
    "split": ("    IsSplitAt (ball (0 : ℂ) 1) (closedBall (0 : ℂ) 1)ᶜ univ 1 0 := by", "    IsSplitAt (ball (0 : ℂ) 1) (closedBall (0 : ℂ) 1)ᶜ univ 1 1 := by"),
    "hdisj": ("    (hdisj : volume (A ∩ B ∩ N) = 0) {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)\n    (ha : (A ∩ N : Set ℂ) ≤ᵐ[volume] (ball ya 1)ᶜ)", "    (hdisj : True) {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)\n    (ha : (A ∩ N : Set ℂ) ≤ᵐ[volume] (ball ya 1)ᶜ)"),
    "cover": ("theorem pinch_not_in_in {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))", "theorem pinch_not_in_in {A B N : Set ℂ} (hN : IsOpen N) (hcover : True)"),
}


def run(text):
    SCR.write_text(text)
    r = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(SCR)],
                       cwd=ROOT, capture_output=True, text=True)
    out = r.stdout + r.stderr
    return [l for l in out.splitlines() if re.search(r": error", l)]


bad = 0
errs = run(SRC)
if errs:
    print(f"CLEAN COPY IS RED ({len(errs)} errors) — no plant can be read:\n  " + "\n  ".join(e[-160:] for e in errs[:3]))
    sys.exit(1)
print("green | the unplanted copy elaborates with no error")
for name, (old, new) in PLANTS.items():
    if SRC.count(old) != 1:
        print(f"PLANT {name}: target text found {SRC.count(old)} times")
        sys.exit(2)
    errs = run(SRC.replace(old, new))
    if errs:
        print(f"red   | {name}: {len(errs)} error(s); first: " + re.sub(r"^.*PlantScratch\.lean:", "line ", errs[0])[:150])
    else:
        print(f"GREEN | {name}: the plant did not fire")
        bad += 1
SCR.write_text("-- scratch of tools/fs131_i6a_plants.py; rewritten at every run\n")
print(f"plants: {len(PLANTS)}  red: {len(PLANTS) - bad}  green (failures): {bad}")
sys.exit(1 if bad else 0)
