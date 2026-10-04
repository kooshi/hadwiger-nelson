#!/usr/bin/env python3
"""FS131-K4: list the theorems of wave 4's skeleton modules with their full names, and check scripts/Axioms.lean records each.

`--check` fails if any theorem lacks a `#print axioms` record; `--plant` drops the namespace tracking (so names come out
unqualified) and shows the check firing.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
MODS = ["Proofs/HadwigerNelson/Plane/StuckChain.lean", "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean",
        "Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean", "Proofs/HadwigerNelson/Plane/SVMap.lean",
        "Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean"]
# Definitions built from `sorry` leaves (FS131-K4b): recorded like theorems, so their axioms are audited when the leaves land.
DEFS = {"toAeProperRegions", "sevenBrickMap", "sevenBrickRegions", "bowtie"}


def names(track=True):
    out = []
    for m in MODS:
        ns = []
        for line in (ROOT / m).read_text().split("\n"):
            mo = re.match(r"namespace (\S+)", line)
            if mo and track:
                ns.append(mo.group(1)); continue
            mo = re.match(r"end (\S+)", line)
            if mo and track and ns and ns[-1] == mo.group(1):
                ns.pop(); continue
            mo = re.match(r"theorem (\S+)", line)
            if mo:
                out.append(".".join(ns + [mo.group(1)]))
            mo = re.match(r"(?:noncomputable )?def (\S+)", line)
            if mo and mo.group(1) in DEFS:
                out.append(".".join(ns + [mo.group(1)]))
    return out


def check(ns):
    ax = (ROOT / "scripts" / "Axioms.lean").read_text()
    missing = [n for n in ns if f"#print axioms {n}\n" not in ax]
    return missing


if __name__ == "__main__":
    if "--plant" in sys.argv:
        miss = check(names(track=False))
        print("plant (namespaces dropped):", "FIRED" if miss else "MISSED", f"({len(miss)} missing)")
        sys.exit(0 if miss else 1)
    ns = names()
    if "--check" in sys.argv:
        miss = check(ns)
        print(f"check: {len(ns)} names, {len(miss)} missing", *miss, sep="\n  ")
        sys.exit(1 if miss else 0)
    print("\n".join(f"#print axioms {n}" for n in ns))
