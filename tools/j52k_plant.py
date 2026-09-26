#!/usr/bin/env python3
"""J52K (FS-75): planted faults on the REAL ℚ(√167) certificate, watched red in the kernel, beside a faithful copy
watched green.

It never edits the committed literal (`Proofs/HadwigerNelson/Instances/SqrtOneSixSeven/Cert.lean`): each variant is
written to `data/fs75/j52k/plant/<name>.lean` as a copy of the literal with exactly one textual change, followed by
`example : cert.check = true := by decide +kernel`, and elaborated with `lake env lean`. The pair is the control:

  faithful  — no change;                                      must ELABORATE (exit 0)
  relation  — relation 0's entry 7 changed from 1 to 2;       must FAIL, with `decide` refusing
  leaf      — the first leaf's multiplier (0, 1) set to (0, 0); must FAIL, with `decide` refusing

A variant whose change did not apply exactly once aborts the run (a plant that cannot fire tests nothing). The committed
literal's sha256 is compared before and after (restore verified). Run it under a slot:

  scripts/slot.py --mem 12 --cpus 2 -- python3 tools/j52k_plant.py
"""
from __future__ import annotations

import hashlib
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
LIT = REPO / "Proofs/HadwigerNelson/Instances/SqrtOneSixSeven/Cert.lean"
OUT = REPO / "data/fs75/j52k/plant"

REL0 = "rels := [[0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, -2, -2, 0, 0, 0],"
REL0_BAD = "rels := [[0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, -2, -2, 0, 0, 0],"
LEAF0 = "tree := .branch 0 (-2) 0 [.leaf [(0, 1)],"
LEAF0_BAD = "tree := .branch 0 (-2) 0 [.leaf [(0, 0)],"

VARIANTS = {
    "faithful": (None, None, True),
    "relation": (REL0, REL0_BAD, False),
    "leaf": (LEAF0, LEAF0_BAD, False),
}


def sha(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main() -> int:
    before = sha(LIT)
    text = LIT.read_text()
    OUT.mkdir(parents=True, exist_ok=True)
    failures = []
    for name, (old, new, must_pass) in VARIANTS.items():
        body = text
        if old is not None:
            n = body.count(old)
            if n != 1:
                print(f"ABORT {name}: the plant's anchor occurs {n} times, not once")
                return 2
            body = body.replace(old, new)
            if body == text:
                print(f"ABORT {name}: the plant changed nothing")
                return 2
        body = body.replace("end Sqrt167", "example : cert.check = true := by decide +kernel\n\nend Sqrt167")
        f = OUT / f"{name}.lean"
        f.write_text(body)
        r = subprocess.run(["lake", "env", "lean", str(f)], cwd=REPO, capture_output=True, text=True)
        out = r.stdout + r.stderr
        refused_by_decide = r.returncode != 0 and "decide" in out and "error" in out
        ok = (r.returncode == 0) if must_pass else refused_by_decide
        verdict = "PASS" if ok else "FAIL"
        expect = "elaborates" if must_pass else "refused by decide"
        print(f"{verdict} {name}: expected {expect}; exit {r.returncode}")
        if not must_pass:
            first = next((ln for ln in out.splitlines() if "error" in ln), "")
            print(f"    {first[:200]}")
        if not ok:
            failures.append(name)
            print(out[:2000])
    after = sha(LIT)
    if after != before:
        print("RESTORE FAILED: the committed literal changed")
        return 3
    print(f"restore: committed literal unchanged ({after[:16]})")
    if failures:
        print(f"PLANT CHECK FAILED: {failures}")
        return 1
    print("PLANT CHECK PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
