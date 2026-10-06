#!/usr/bin/env python3
"""FS131-L10A: the five ruled statements changed in exactly the ruled way (rulings 494 (a), 507 (a)).

  tools/fs131_l10a_tidyshape.py <before-ref>            (run from the worktree root)

Reads the two files at <before-ref> and in the working tree and checks, on the statements (a
theorem's text from its keyword to its first ` :=`):

  * each of X25B-P, X25B-PZ, X25B-L1 now carries, under the row's name, exactly the statement its
    `_of_symm` / `_of_shrink` twin carried before, with the name alone substituted; the twin is gone;
  * `sp_if` is its old statement with ` [Countable (unitRing F)]` cut and nothing else;
  * `spectral_carried_iff` is its old statement with ` [IsProbabilityMeasure μ]` cut and nothing else;
  * the arguments ruled out are in none of the three rows' statements: `MeasurableAdd₂`, `T2Space`,
    `SigmaFinite νX`, `Antitone`, `IsFiniteMeasure νY`, and the index `ℕ →` of `K`.

--self-test runs the check, then on planted copies of the working text: a hypothesis put back
(`[T2Space Y]`), and a conclusion changed in a row — each must fail.
"""
import importlib.util
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("stm", os.path.join(HERE, "fs131_l10a_statements.py"))
stm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stm)

SR = "Proofs/HadwigerNelson/Arith/StationaryRatio.lean"
SI = "Proofs/HadwigerNelson/Arith/SpectralInputs.lean"
P = "HadwigerNelson.StationaryRatio."
Q = "HadwigerNelson.SpectralInputs."
ROWS = [("StationarySet.prob_le_ratio_mul", "StationarySet.prob_le_ratio_mul_of_symm"),
        ("ratio_prod_le", "ratio_prod_le_of_symm"),
        ("ratio_prod_le_iSup_levels", "ratio_prod_le_iSup_levels_of_shrink")]
CUTS = [("sp_if", " [Countable (unitRing F)]"), ("spectral_carried_iff", " [IsProbabilityMeasure μ]")]
GONE = ["MeasurableAdd₂", "T2Space", "SigmaFinite νX", "Antitone", "IsFiniteMeasure νY", "ℕ → OpenAddSubgroup"]


def stmts(text):
    return {c[0]: c[3] for c in stm.chunks(text)}


def check(before_sr, after_sr, before_si, after_si, label):
    faults = []
    b, a = stmts(before_sr), stmts(after_sr)
    for row, twin in ROWS:
        if P + twin in a:
            faults.append(f"TWIN-KEPT {twin}")
        want = b[P + twin].replace(f"theorem {twin} ", f"theorem {row} ", 1)
        if a.get(P + row) != want:
            faults.append(f"ROW-SHAPE {row}: not its twin's statement under the row's name")
        for g in GONE:
            if g in a.get(P + row, ""):
                faults.append(f"ARG-KEPT {row}: {g}")
    b, a = stmts(before_si), stmts(after_si)
    for name, cut in CUTS:
        if b[Q + name].count(cut) != 1:
            faults.append(f"CUT-ABSENT {name}: the old statement does not hold {cut!r} once")
        elif a.get(Q + name) != b[Q + name].replace(cut, "", 1):
            faults.append(f"CUT-SHAPE {name}: not its old statement with {cut!r} cut")
    print(f"{label}: 3 rows on their twins' statements, 2 instance arguments cut; faults {len(faults)}")
    for f in faults:
        print("  " + f)
    return faults


def main(argv):
    self_test = "--self-test" in argv
    args = [x for x in argv if x != "--self-test"]
    if len(args) != 1:
        print(__doc__)
        return 2
    show = lambda p: subprocess.run(["git", "show", f"{args[0]}:{p}"], check=True, capture_output=True,
                                    text=True).stdout
    bsr, bsi = show(SR), show(SI)
    asr, asi = open(SR, encoding="utf-8").read(), open(SI, encoding="utf-8").read()
    faults = check(bsr, asr, bsi, asi, "tidy-shape")
    if not self_test:
        print("tidy-shape: PASS" if not faults else "tidy-shape: FAIL")
        return 1 if faults else 0
    ok = not faults
    p1 = asr.replace("[SecondCountableTopology Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) (νY : Measure Y) [SFinite νY]\n    (K : ι →",
                     "[SecondCountableTopology Y] [T2Space Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) (νY : Measure Y) [SFinite νY]\n    (K : ι →", 1)
    p2 = asr.replace("(hH : νH.map Neg.neg = νH) : ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH) :=",
                     "(hH : νH.map Neg.neg = νH) : ratio (νG.prod νH) ≤ max (ratio νG) 1 :=", 1)
    p3 = asi.replace("theorem sp_if (I : Interface F) (hBH", "theorem sp_if (I : Interface F) [Finite (unitRing F)] (hBH", 1)
    for what, s_r, s_i, word in (("a dropped argument put back", p1, asi, "ARG-KEPT"),
                                 ("a row's conclusion changed", p2, asi, "ROW-SHAPE"),
                                 ("another instance argument put in sp_if", asr, p3, "CUT-SHAPE")):
        if s_r == asr and s_i == asi:
            print(f"plant ({what}): COULD NOT BE PLANTED")
            ok = False
            continue
        f = check(bsr, s_r, bsi, s_i, f"plant ({what})")
        fired = any(x.startswith(word) for x in f)
        print(f"  -> {'fired' if fired else 'DID NOT FIRE'} ({word})")
        ok = ok and fired
    print("self-test: PASS" if ok else "self-test: FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
