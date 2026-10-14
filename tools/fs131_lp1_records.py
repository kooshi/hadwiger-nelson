#!/usr/bin/env python3
"""FS131-LP1: the records check of the port's landing, read from the axiom audit's own receipt (`scripts/axioms.sh`'s
normalized log, `build/gate/axioms/latest`, kept as `data/fs131/lp1/gate/receipt-axioms-<tag>.log`).

What the landing claims of the audit, each a check:
  1. the transfer `HadwigerNelson.Outside.OAI158.proper_to_borel_weak` is a record under CLEAN, on exactly
     `[propext, Classical.choice, Quot.sound]`;
  2. each of the twelve records that rested on it while it was an axiom (FS131-IPD1's `step5-records.txt`) is under
     CLEAN, on exactly the three;
  3. no record of any section lists `proper_to_borel_weak` among its axioms, and no `DECLARED IMPORT` line names it;
  4. the declared imports are exactly `StandingFive.kloosterman_bound` and `Outside.OAI158.no_proper_five_coloring`;
     IMPORTED holds exactly 26 records, 20 on the first and 6 on the second (each the three and that one), none on both;
  5. the totals: every record once, CLEAN + PURCHASED + IMPORTED = the count the brief predicts (9,024), and no name
     printed twice.

  fs131_lp1_records.py RECEIPT            check, exit 0 iff every check passes
  fs131_lp1_records.py RECEIPT --plant    five plants in memory (an axiom added to the transfer's list; a moved record
                                          put under IMPORTED; a DECLARED IMPORT of the transfer; an IMPORTED record
                                          removed; a record printed twice): each must fail, the unplanted receipt pass
"""
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STD = ["propext", "Classical.choice", "Quot.sound"]
T = "HadwigerNelson.Outside.OAI158.proper_to_borel_weak"
MOVED = [ln.split("'")[1] for ln in (ROOT / "data/fs131/ipd1/switch/step5-records.txt").read_text().splitlines()
         if ln.startswith("'") and ln.split("'")[1] != T]
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
H5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
TOTAL = 9024


def read(path):
    p = Path(path)
    return (lzma.open(p, "rt").read() if p.suffix == ".xz" else p.read_text()).splitlines()


def parse(lines):
    """-> (records [(section, name, axioms)], declared imports)"""
    recs, decl, sec, cur = [], [], None, None
    for ln in lines:
        m = re.match(r"^=== (\w+) ===$", ln)
        if m:
            sec = m.group(1)
            continue
        if ln.startswith("DECLARED IMPORT "):
            decl.append(ln.split()[2])
            continue
        m = re.match(r"^'(.+)' (?:depends on axioms: \[(.*)|does not depend on any axioms)$", ln)
        if m:
            cur = [sec, m.group(1), m.group(2) or ""]
            if m.group(2) is None or cur[2].endswith("]"):
                recs.append((cur[0], cur[1], [a.strip() for a in cur[2].rstrip("]").split(",") if a.strip()]))
                cur = None
            continue
        if cur is not None:
            cur[2] += ln
            if ln.endswith("]"):
                recs.append((cur[0], cur[1], [a.strip() for a in cur[2].rstrip("]").split(",") if a.strip()]))
                cur = None
    return recs, decl


def check(lines, quiet=False):
    recs, decl = parse(lines)
    fails = []

    def need(ok, what):
        if not quiet:
            print(f"  {'ok  ' if ok else 'FAIL'}  {what}")
        if not ok:
            fails.append(what)

    by = {}
    for s, n, a in recs:
        by.setdefault(n, []).append((s, a))
    need(T in by and by[T] == [("CLEAN", STD)], f"the transfer: {by.get(T)}")
    bad = [n for n in MOVED if by.get(n) != [("CLEAN", STD)]]
    need(len(MOVED) == 12 and not bad, f"the twelve records that rested on it, each under CLEAN on exactly the three "
         f"({12 - len(bad)} of {len(MOVED)}){': ' + ', '.join(bad) if bad else ''}")
    on_t = [n for s, n, a in recs if T in a]
    need(not on_t and T not in decl, f"no record rests on the transfer ({len(on_t)}) and no DECLARED IMPORT names it")
    imp = [(n, a) for s, n, a in recs if s == "IMPORTED"]
    kb = [n for n, a in imp if a == STD + [KB]]
    h5 = [n for n, a in imp if a == STD + [H5]]
    need(sorted(decl) == sorted([KB, H5]), f"declared imports: {decl}")
    need(len(imp) == 26 and len(kb) == 20 and len(h5) == 6,
         f"IMPORTED: {len(imp)} records, {len(kb)} on Weil's bound alone, {len(h5)} on the five-colour theorem alone")
    dup = sorted(n for n, v in by.items() if len(v) > 1)
    secs = {}
    for s, n, a in recs:
        secs[s] = secs.get(s, 0) + 1
    need(len(recs) == TOTAL and not dup, f"records: {len(recs)} ({secs}), {TOTAL} predicted; printed twice: {dup[:5]}")
    return fails


def main():
    lines = read(sys.argv[1])
    if "--plant" not in sys.argv:
        fails = check(lines)
        print("records: " + ("PASS" if not fails else f"FAIL ({len(fails)})"))
        return 1 if fails else 0
    ok = not check(lines, quiet=True)
    print(f"unplanted: {'PASS' if ok else 'FAILED'}")
    i = next(k for k, ln in enumerate(lines) if ln.startswith(f"'{T}' depends on axioms"))
    j = next(k for k, ln in enumerate(lines) if ln.startswith(f"'{MOVED[0]}' depends on axioms"))
    imp_end = next(k for k, ln in enumerate(lines) if ln == "=== CLEAN ===")
    first_imp = next(k for k, ln in enumerate(lines) if k < imp_end and ln.startswith("'"))
    k2 = first_imp
    while not lines[k2].endswith("]"):
        k2 += 1
    plants = {
        "an axiom added to the transfer's list": lines[:i] + [lines[i].replace("Quot.sound]", "Quot.sound, sorryAx]")]
        + lines[i + 1:],
        "a moved record put under IMPORTED": lines[:imp_end] + [lines[j]] + lines[imp_end:j] + lines[j + 1:],
        "a DECLARED IMPORT of the transfer": [lines[0], f"DECLARED IMPORT {T}"] + lines[1:],
        "an IMPORTED record removed": lines[:first_imp] + lines[k2 + 1:],
        "a record printed twice": lines[:i + 1] + [lines[i]] + lines[i + 1:],
    }
    for what, pl in plants.items():
        f = check(pl, quiet=True)
        print(f"plant '{what}': {'FAILED (as it must)' if f else 'PASSED'}" + (f" — {f[0][:120]}" if f else ""))
        ok = ok and bool(f)
    print("plants: " + ("every one fired; the unplanted receipt passes" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
