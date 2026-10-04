#!/usr/bin/env python3
"""FS131-W3: the theorems of Woodall's chain (Woodall/Basic, Collar, NoFourFive, Merge, Steps) against scripts/Axioms.lean, both ways.

Like tools/fs131_w2_decls.py (FS131-W2's, frozen to four modules), with the module `Woodall/Merge` added and its records read from the
section "FS-131 Woodall's merge" as well as the "FS-131 Woodall's chain" sections.

`--check`: every theorem of the five modules has a `#print axioms` record (missing), and every record in those sections names a theorem of
the five modules (stale). Exit 1 on either.
`--plant`: drops `exists_merge_at` from the declared names and adds the removed leaf `exists_sectorsAt` back as a record, in memory, and shows
both directions firing (exit 0 only if both fire).
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
MODS = [f"Proofs/HadwigerNelson/Plane/Woodall/{m}.lean" for m in ("Basic", "Collar", "NoFourFive", "Merge", "Steps")]
SECTION = re.compile(r"^/-! ## FS-131 Woodall's (chain|merge)")


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
        drop = "HadwigerNelson.Plane.ArcMap.exists_merge_at"
        back = "HadwigerNelson.Plane.ArcMap.exists_sectorsAt"
        miss, stale = compare([n for n in ns if n != drop] + ["HadwigerNelson.Plane.ArcMap.planted_missing"], recs + [back])
        fired = ("HadwigerNelson.Plane.ArcMap.planted_missing" in miss) and (back in stale) and (drop in stale)
        print("plant:", "FIRED" if fired else "MISSED", f"(missing {miss}, stale {stale})")
        sys.exit(0 if fired else 1)
    miss, stale = compare(ns, recs)
    print(f"check: {len(ns)} theorems, {len(recs)} records; {len(miss)} missing, {len(stale)} stale")
    for n in miss:
        print("MISSING", n)
    for r in stale:
        print("STALE", r)
    sys.exit(1 if miss or stale else 0)
