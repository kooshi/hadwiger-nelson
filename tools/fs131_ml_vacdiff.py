#!/usr/bin/env python3
"""FS131-ML1: the merged tree's vacuity scan against `main`'s, row for row, with the new rows read as MERGE's.

Every SITE and EVIDENCE row of `main`'s scan must be in the merged scan (the landing adds `MergeMove` and restores two theorems;
it removes nothing of `main`'s), and every row the merged scan adds must belong to a declaration of `Plane/ValidMap/MergeMove`
(its names read by QA1's `qualified_decls`, imported, never copied) or to one of the two restored theorems. Prints the added
rows' verdict and carrier tally.

Usage: fs131_ml_vacdiff.py <main log> <merged log>
       fs131_ml_vacdiff.py --plant <main log> <merged log>   drop one main row from the merged view and add a non-MERGE row;
                                                              must exit 1 naming both
Exit 0 when both hold; 1 otherwise (each discrepancy printed).
"""
import collections
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_qa1_dupes import qualified_decls  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[1]
MERGEMOVE = ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean"
RESTORED = {"HadwigerNelson.Plane.ArcMap.exists_merge_aux", "HadwigerNelson.Plane.ArcMap.exists_merge"}


def read(path):
    rows = collections.Counter()
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("SITE ") or ln.startswith("EVIDENCE "):
            rows[ln] += 1
    return rows


def name_of(row):
    return row.split(" :: ")[0].split()[2]


def main(argv):
    plant = "--plant" in argv
    a = [x for x in argv if x != "--plant"]
    mainrows, merged = read(a[0]), read(a[1])
    ours = {q for q, _ in qualified_decls(MERGEMOVE.read_text())} | RESTORED
    if plant:
        victim = sorted(mainrows)[0]
        merged = merged.copy()
        merged[victim] -= 1
        merged["SITE GENERIC HadwigerNelson.Plane.ArcMap.exists_shave_aux :: F.Valid"] += 1
    bad = 0
    lost = mainrows - merged
    for r in sorted(lost):
        print("LOST", r)
        bad += 1
    added = merged - mainrows
    tally = collections.Counter()
    for r in sorted(added):
        n = name_of(r)
        if n not in ours:
            print("NOT MERGE'S", r)
            bad += 1
        else:
            tally[(r.split()[0], r.split()[1], r.split(" :: ")[1].split()[0] if " :: " in r else "")] += added[r]
    print(f"main rows {sum(mainrows.values())}, merged rows {sum(merged.values())}, lost {sum(lost.values())}, "
          f"added {sum(added.values())} ({len(ours)} MERGE names)")
    for (kind, verdict, carrier), c in sorted(tally.items()):
        print(f"  added {kind} {verdict} on {carrier}: {c}")
    print("vacdiff:", "PASS" if not bad else f"FAIL ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
