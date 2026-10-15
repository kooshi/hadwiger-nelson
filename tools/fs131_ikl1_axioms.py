#!/usr/bin/env python3
"""FS131-IKL1: read the axioms printed by `data/fs131/ikl1/lean/Axioms.lean` and class each record as the audit would.

  CLEAN     a subset of the standard three (propext, Classical.choice, Quot.sound)
  IMPORTED  the standard three and the declared import `HadwigerNelson.StandingFive.kloosterman_bound`, at least it
  FAIL      anything else (`sorryAx`, a native axiom, an undeclared axiom)

Exits 1 on any FAIL, on zero records, or when the printed `AXIOMS-COUNT` does not match the records read.
`--expect-fail NAME` turns the control around: the run must FAIL exactly on NAME (the planted record) and nowhere else.

Usage: fs131_ikl1_axioms.py <axioms output> [--expect-fail NAME]
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}
IMPORT = {"HadwigerNelson.StandingFive.kloosterman_bound"}


def main(argv):
    path = argv[0]
    expect = argv[argv.index("--expect-fail") + 1] if "--expect-fail" in argv else None
    recs, count = [], None
    for line in open(path, encoding="utf-8"):
        m = re.match(r"AXIOMS (public|private) (\S+) (\S+) : \[(.*)\]$", line.strip())
        if m:
            axs = {a.strip() for a in m.group(4).split(",") if a.strip()}
            recs.append((m.group(1), m.group(2), m.group(3), axs))
        m2 = re.match(r"AXIOMS-COUNT (\d+)", line.strip())
        if m2:
            count = int(m2.group(1))
    if not recs:
        print("FAIL: no record read")
        return 1
    if count != len(recs):
        print(f"FAIL: AXIOMS-COUNT {count} but {len(recs)} records read")
        return 1
    tally = {"CLEAN": 0, "IMPORTED": 0, "FAIL": 0}
    failed = []
    for kind, mod, name, axs in recs:
        if axs <= STD:
            v = "CLEAN"
        elif axs <= STD | IMPORT and axs & IMPORT:
            v = "IMPORTED"
        else:
            v = "FAIL"
            failed.append(name)
        tally[v] += 1
        print(f"{v:8} {kind:7} {name} : {sorted(axs)}")
    print("COUNTS", " ".join(f"{k}={v}" for k, v in tally.items()), f"records={len(recs)}")
    if expect is not None:
        ok = failed == [expect]
        print("CONTROL", "FIRED" if ok else "SILENT", f"(failed: {failed})")
        return 0 if ok else 1
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
