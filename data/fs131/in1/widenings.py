#!/usr/bin/env python3
"""FS131-IN1 — the three statements widened by the coordinator's rulings (the brief's Amendments 1 and 2) are widenings.

Prints Lean text to append to a copy of the working module: for each of the three leaves, the SKELETON's statement —
its binders and conclusion copied by this script from `git show 34d9113b2:<file>`, never retyped — as an `example`
proved by one application of the working module's theorem of that name.  If both elaborate, each new statement gives
the old one with nothing added: a hypothesis was dropped and nothing else moved.
--plant: the first example's proof is given one argument too few, so it must NOT elaborate (the control).
"""
import re, subprocess, sys, pathlib
FILE = "Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean"
BASE = "34d9113b2"
ROOT = pathlib.Path(__file__).resolve().parents[3]
# name -> the application that proves the skeleton's form from the working module's (the dropped binder not passed)
PROOF = {
    "exists_mul_conj_inv_eq_of_mul_conj_eq_one": "exists_mul_conj_inv_eq_of_mul_conj_eq_one σ hσσ hσ ht",
    "eq_zero_of_forall_normOne_eq": "eq_zero_of_forall_normOne_eq σ hσ lam h",
    "exists_maximal_conj_trivial": "exists_maximal_conj_trivial c hmax l hl",
}
PLANT = {"exists_mul_conj_inv_eq_of_mul_conj_eq_one": "exists_mul_conj_inv_eq_of_mul_conj_eq_one σ hσσ ht"}
old = subprocess.run(["git", "show", f"{BASE}:{FILE}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
out = ["", "/-! FS131-IN1 (data/fs131/in1/widenings.py): the skeleton's form of each widened leaf, from the working module's. -/",
       "namespace HadwigerNelson.ThreeColourCriterion"]
for name, proof in PROOF.items():
    m = re.search(rf"^theorem {name} (.*?) := by\n  sorry\n", old, flags=re.M | re.S)
    if not m:
        sys.exit(f"NOT FOUND in the skeleton: {name}")
    if "--plant" in sys.argv:
        proof = PLANT.get(name, proof)
    out.append(f"example {m.group(1)} :=\n  {proof}")
out.append("end HadwigerNelson.ThreeColourCriterion")
print("\n".join(out))
