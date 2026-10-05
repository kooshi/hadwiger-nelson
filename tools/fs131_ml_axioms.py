#!/usr/bin/env python3
"""FS131-ML1: MERGE's records in the gate's saved axioms log — every one within the standard three.

MERGE's records are the names `#print axioms`'d in `scripts/Axioms.lean`'s block "FS-131 wave 4, `MergeMove` (job FS131-IMM1)" (up to
the next blank line) and the two restored theorems `ArcMap.exists_merge_aux`, `ArcMap.exists_merge`. Each must appear exactly once in
the log (`scripts/axioms.sh`'s full output under `build/gate/axioms/`), on a subset of `[propext, Classical.choice, Quot.sound]`: no
`sorryAx`, no native auxiliary, no other axiom. The log is parsed by FS131-IMM4's `records` (wrapped lines re-joined; imported, never
copied). Prints the count on exactly the three, on fewer, and on none.

Usage: fs131_ml_axioms.py <axioms log>
       fs131_ml_axioms.py --plant <axioms log>   adds sorryAx to `exists_merge`'s record and drops `merge_allowedCone`'s, in memory;
                                                  must exit 1 naming both
Exit 1 on any failure.
"""
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_imm_axioms import STANDARD, records  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[1]
RESTORED = ["HadwigerNelson.Plane.ArcMap.exists_merge_aux", "HadwigerNelson.Plane.ArcMap.exists_merge"]


def merge_names():
    t = (ROOT / "scripts/Axioms.lean").read_text()
    i = t.index("/-! ## FS-131 wave 4, `MergeMove` (job FS131-IMM1)")
    block = t[i:t.index("\n\n", i)]
    return re.findall(r"^#print axioms (\S+)$", block, re.M) + RESTORED


def main(argv):
    plant = "--plant" in argv
    path = [a for a in argv if a != "--plant"][0]
    recs = {}
    dup = []
    for name, ax in records(pathlib.Path(path).read_text()):
        if name in recs:
            dup.append(name)
        recs[name] = ax
    if plant:
        recs["HadwigerNelson.Plane.ArcMap.exists_merge"] = recs["HadwigerNelson.Plane.ArcMap.exists_merge"] | {"sorryAx"}
        recs.pop("HadwigerNelson.Plane.ArcMap.Near.merge_allowedCone", None)
    names = merge_names()
    bad, exact, fewer, none = [], 0, 0, 0
    for n in names:
        if n in dup:
            bad.append(f"recorded twice: {n}")
        if n not in recs:
            bad.append(f"no record in the log: {n}")
            continue
        ax = recs[n]
        if not ax <= STANDARD:
            bad.append(f"outside the standard three: {n} {sorted(ax)}")
        elif ax == STANDARD:
            exact += 1
        elif ax:
            fewer += 1
        else:
            none += 1
    for b in bad:
        print("FAIL", b)
    print(f"MERGE records: {len(names)} named ({len(set(names))} distinct) — {exact} on exactly the standard three, {fewer} on fewer, "
          f"{none} on none; the restored: " + ", ".join(f"{n.split('.')[-1]} {sorted(recs.get(n, {'(missing)'}))}" for n in RESTORED))
    print("merge axioms:", "PASS" if not bad else f"FAIL ({len(bad)})")
    return 1 if bad or len(set(names)) != len(names) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
