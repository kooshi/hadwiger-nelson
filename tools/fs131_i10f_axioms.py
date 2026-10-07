#!/usr/bin/env python3
"""FS131-I10F — the axioms print for this job's declarations, with a control that fires.

Writes a scratch Lean file importing the three (built) modules, prints `#print axioms` for every name listed in
`data/fs131/i10f/axioms-names.txt` (one fully qualified name per line; `#` comments), and for a planted control
declaration proved by `sorry`. Runs it with `lake env lean` (iteration-grade: the trust receipt is `scripts/axioms.sh`
at the landing; this is the per-leaf print the brief asks for).

Passes (exit 0) iff
  * every listed declaration prints, and its axioms are a subset of the standard three;
  * the control prints `sorryAx` (the check can see a `sorry`).
`--fault` appends the control's name to the listed declarations, so the run must exit 1 naming it.
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
NAMES = ROOT / "data/fs131/i10f/axioms-names.txt"
STANDARD = {"propext", "Classical.choice", "Quot.sound"}
CONTROL = "FS131I10F.control"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--fault", action="store_true")
    ap.add_argument("--out", default=str(ROOT / "data/fs131/i10f/logs/axioms.txt"))
    args = ap.parse_args()
    names = [ln.strip() for ln in NAMES.read_text().splitlines() if ln.strip() and not ln.startswith("#")]
    if not names:
        print("NO NAMES LISTED")
        return 1
    checked = list(names) + ([CONTROL] if args.fault else [])
    modules = ["Proofs.HadwigerNelson.Arith.MajorityVote", "Proofs.HadwigerNelson.Arith.ProductFactor",
               "Proofs.HadwigerNelson.Arith.NegCircleModel"]
    src = "".join(f"import {m}\n" for m in modules)
    src += f"theorem {CONTROL} : (1 : Nat) = 1 + 0 := by sorry\n"
    src += "set_option pp.fullNames true\n"
    for n in names + [CONTROL]:
        src += f"#print axioms {n}\n"
    scratch = ROOT / "data/fs131/i10f/AxiomsScratch.lean"
    scratch.write_text(src)
    r = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(scratch)],
                       cwd=ROOT, capture_output=True, text=True)
    out = r.stdout + r.stderr
    Path(args.out).write_text(out)
    # parse: "'name' depends on axioms: [a, b]" (possibly wrapped) or "'name' does not depend on any axioms"
    flat = re.sub(r"\s+", " ", out)
    found = {}
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", flat):
        found[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", flat):
        found[m.group(1)] = set()
    bad = 0
    for n in checked:
        if n not in found:
            print(f"NOT PRINTED   {n}")
            bad += 1
        elif not found[n] <= STANDARD:
            print(f"NOT CLEAN     {n}: {sorted(found[n])}")
            bad += 1
        else:
            print(f"clean         {n}: {sorted(found[n])}")
    if "sorryAx" not in found.get(CONTROL, set()):
        print(f"CONTROL DID NOT FIRE: {CONTROL} printed {found.get(CONTROL)}")
        bad += 1
    else:
        print(f"control fires {CONTROL}: {sorted(found[CONTROL])}")
    if "error" in out:
        print("LEAN REPORTED AN ERROR — see", args.out)
        bad += 1
    print(f"checked {len(checked)} declarations; failures: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
