#!/usr/bin/env python3
"""FS131-IRU1 — the `example` heads of the five modules (not stored by the kernel, so outside the statement dump) compared as
text with the skeleton at `e27c45182`, block comments and docstrings blanked first (FS124-I3: a docstring line beginning with
the word `example` was once counted as one). A planted control changes one character of the first head in memory and must
read DIFFER. Usage: fs131_iru1_examples.py   (run from the worktree's root; exit 0 iff SAME everywhere and the plant fired)
"""
import re
import subprocess
import sys

BASE = "e27c45182"
FILES = ["Proofs/HadwigerNelson/Rigidity/NormOneGen.lean", "Proofs/HadwigerNelson/Rigidity/UnitRingEq.lean",
         "Proofs/HadwigerNelson/Rigidity/UsablePrime.lean", "Proofs/HadwigerNelson/Rigidity/PlaneComponents.lean",
         "Proofs/HadwigerNelson/Instances/UnitRingModels.lean"]


def heads(text):
    t = re.sub(r"/-.*?-/", "", text, flags=re.S)
    out = []
    for m in re.finditer(r"(?m)^example\b", t):
        seg = t[m.start():]
        out.append(re.sub(r"\s+", " ", seg[:seg.index(":=")]).strip())
    return out


def main():
    ok = True
    for f in FILES:
        old = subprocess.run(["git", "show", f"{BASE}:{f}"], capture_output=True, text=True, check=True).stdout
        a, b = heads(old), heads(open(f).read())
        ok &= a == b
        print(f"{f}: {len(a)} example(s) at the skeleton, {len(b)} now: {'SAME' if a == b else 'DIFFER'}")
        for h in b:
            print("   ", h)
    f = FILES[1]
    old = subprocess.run(["git", "show", f"{BASE}:{f}"], capture_output=True, text=True, check=True).stdout
    planted = heads(open(f).read().replace("resPi Φ m r P = P.1.residue", "resPi Φ m r P = P.1.residuE", 1))
    fired = planted != heads(old)
    print("PLANT", "FIRED" if fired else "NOT FIRED")
    print("VERDICT", "CLEAN" if ok and fired else "FAIL")
    return 0 if ok and fired else 1


if __name__ == "__main__":
    sys.exit(main())
