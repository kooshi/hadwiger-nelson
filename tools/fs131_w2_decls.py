#!/usr/bin/env python3
"""FS131-W2: the theorems of Woodall's chain (Woodall/Basic, Collar, NoFourFive, Steps) against scripts/Axioms.lean, both ways.

`--check`: every theorem of the four modules has a `#print axioms` record (missing), and every record in the Woodall sections of
scripts/Axioms.lean names a theorem of the four modules (stale — a record left behind by a removed leaf). Exit 1 on either.
`--plant`: removes `step6` from the declared names and adds the removed leaf `step7` back as a record, in memory, and shows both
directions firing (exit 0 only if both fire).
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
MODS = ["Proofs/HadwigerNelson/Plane/Woodall/Basic.lean", "Proofs/HadwigerNelson/Plane/Woodall/Collar.lean",
        "Proofs/HadwigerNelson/Plane/Woodall/NoFourFive.lean", "Proofs/HadwigerNelson/Plane/Woodall/Steps.lean"]
SECTION = re.compile(r"^/-! ## FS-131 Woodall's chain")


def names():
    out = []
    for m in MODS:
        ns = []
        for line in (ROOT / m).read_text().split("\n"):
            mo = re.match(r"namespace (\S+)", line)
            if mo:
                ns.append(mo.group(1)); continue
            mo = re.match(r"end (\S+)", line)
            if mo and ns and ns[-1] == mo.group(1):
                ns.pop(); continue
            mo = re.match(r"theorem (\S+)", line)
            if mo:
                out.append(".".join(ns + [mo.group(1)]))
    return out


def records():
    recs, inside = [], False
    for line in (ROOT / "scripts" / "Axioms.lean").read_text().split("\n"):
        if line.startswith("/-! ## "):
            inside = bool(SECTION.match(line)); continue
        mo = re.match(r"#print axioms (\S+)", line)
        if inside and mo:
            recs.append(mo.group(1))
    return recs


def compare(ns, recs):
    return [n for n in ns if n not in recs], [r for r in recs if r not in ns]


if __name__ == "__main__":
    ns, recs = names(), records()
    if "--plant" in sys.argv:
        ns2 = [n for n in ns if n != "HadwigerNelson.Plane.ArcMap.step6"]
        recs2 = recs + ["HadwigerNelson.Plane.ArcMap.step7"]
        miss, stale = compare(ns2 + ["HadwigerNelson.Plane.ArcMap.planted_missing"], recs2)
        fired = ("HadwigerNelson.Plane.ArcMap.planted_missing" in miss) and ("HadwigerNelson.Plane.ArcMap.step7" in stale) \
            and ("HadwigerNelson.Plane.ArcMap.step6" in stale)
        print("plant:", "FIRED" if fired else "MISSED", f"(missing {miss}, stale {stale})")
        sys.exit(0 if fired else 1)
    miss, stale = compare(ns, recs)
    print(f"check: {len(ns)} theorems, {len(recs)} records; {len(miss)} missing, {len(stale)} stale")
    for n in miss:
        print("  missing", n)
    for r in stale:
        print("  stale", r)
    sys.exit(1 if (miss or stale) else 0)
