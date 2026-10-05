#!/usr/bin/env python3
"""FS131-G4: reconcile the merged tree's vacuity scan with its two parents' scans, row for row.

A merge of two branches that share a base should scan as the union of its parents: every SITE row (and every EVIDENCE row)
of the merged run is a row of `main`'s run or of the branch's pre-merge run, and every row of either parent is in the merged
run — except rows a change of tracked carriers or of evidence explains, which are printed for the record to explain by name.
The counts are reconciled the same way: for each count, merged = main + branch − base, where `base` is the count recorded at
the merge base (read from the branch's pre-merge `CLAUDE.md`, given on the command line).

Usage: fs131_g4_vacdiff.py <main log> <branch pre-merge log> <merged log> <base counts as key=value ...>
       fs131_g4_vacdiff.py --plant <main log> <branch log> <merged log> <base counts>   drop one merged SITE row; must exit 1
Exit 0 when the rows are exactly the union and every count adds up; 1 otherwise (each discrepancy printed).
"""
import re
import sys
from collections import Counter

KEYS = ["declarations", "refutations-skipped", "sites", "vacuous", "stale", "declared", "witnessed", "generic", "unknown"]


def read(path):
    rows, ev, counts = Counter(), Counter(), {}
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("SITE "):
            rows[ln] += 1
        elif ln.startswith("EVIDENCE "):
            ev[ln] += 1
        for k in KEYS:
            m = re.search(rf"(?:^|\s){re.escape(k)}=(\d+)", ln) if ("=== SCANNED" in ln or "=== TOTALS" in ln) else None
            if m:
                counts[k] = int(m.group(1))
    return rows, ev, counts


def union(a, b):
    return Counter({r: max(a[r], b[r]) for r in set(a) | set(b)})


def main(argv):
    plant = "--plant" in argv
    argv = [a for a in argv if a != "--plant"]
    mlog, plog, xlog, *base = argv
    base = {k: int(v) for k, v in (b.split("=") for b in base)}
    (mr, me, mc), (pr, pe, pc), (xr, xe, xc) = read(mlog), read(plog), read(xlog)
    if plant:
        victim = sorted(xr)[len(xr) // 2]
        xr[victim] -= 1
        print(f"planted: dropped {victim[:120]}")
    bad = 0
    for name, (m, p, x) in {"SITE": (mr, pr, xr), "EVIDENCE": (me, pe, xe)}.items():
        want = union(m, p)
        extra, missing = x - want, want - x
        print(f"{name}: main {sum(m.values())}, branch {sum(p.values())}, union {sum(want.values())}, merged {sum(x.values())}; "
              f"{sum(extra.values())} not in either parent, {sum(missing.values())} of a parent missing")
        for r in sorted(extra):
            print(f"  + {r}")
        for r in sorted(missing):
            print(f"  - {r}")
        bad += sum(extra.values()) + sum(missing.values())
    for k in KEYS:
        if k not in base or k not in mc or k not in pc or k not in xc:
            print(f"COUNT {k}: not read in every input (main {mc.get(k)}, branch {pc.get(k)}, merged {xc.get(k)}, base {base.get(k)})")
            bad += 1
            continue
        want = mc[k] + pc[k] - base[k]
        flag = "ok" if want == xc[k] else "MISMATCH"
        print(f"COUNT {k}: main {mc[k]} + branch {pc[k]} - base {base[k]} = {want}; merged {xc[k]}  {flag}")
        bad += want != xc[k]
    print("PASS" if not bad else f"FAIL ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
