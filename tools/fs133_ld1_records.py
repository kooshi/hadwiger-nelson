#!/usr/bin/env python3
"""FS133-LD1: the records check of the density equality's landing, read from the axiom audit's own receipt
(`scripts/axioms.sh`'s normalized log, `build/gate/axioms/latest`, kept as `data/fs133/ld1/gate/receipt-axioms-<tag>.log`).
FS131-LP1's records check (`tools/fs131_lp1_records.py`; its `read` and `parse` copied) with this landing's claims:
  1. the port's `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` is a record under CLEAN, on exactly
     `[propext, Classical.choice, Quot.sound]`;
  2. each of the module's 77 records (`data/fs133/ld1/records.txt`) is printed once, under CLEAN, on a non-empty subset
     of the three; the fourteen that rested on the declared `residual_fourier` before the join
     (`data/fs133/ld1/records-rf.txt`, the plan's § 5.5 IMPORTED list) on exactly the three;
  3. no record of any section lists `residual_fourier` among its axioms, and no `DECLARED IMPORT` line names it;
  4. the declared imports are exactly `StandingFive.kloosterman_bound` and `Outside.OAI158.no_proper_five_coloring`;
     IMPORTED holds exactly 26 records, 20 on the first and 6 on the second (each the three and that one);
  5. the totals: every record once, and the count the landing predicts — `main`'s 9,024 and the module's 77: 9,101.

  fs133_ld1_records.py RECEIPT            check, exit 0 iff every check passes
  fs133_ld1_records.py RECEIPT --plant    five plants in memory (an axiom added to a record that rested on the declared
                                          theorem; a module record put under IMPORTED; a DECLARED IMPORT of
                                          `residual_fourier`; a module record removed; a record printed twice): each
                                          must fail, the unplanted receipt pass
"""
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STD = ["propext", "Classical.choice", "Quot.sound"]
RF = "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"
MINE = [ln.strip() for ln in (ROOT / "data/fs133/ld1/records.txt").read_text().splitlines() if ln.strip()]
WAS_RF = [ln.strip() for ln in (ROOT / "data/fs133/ld1/records-rf.txt").read_text().splitlines() if ln.strip()]
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
H5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
TOTAL = 9024 + 77


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
    need(by.get(RF) == [("CLEAN", STD)], f"the port's residual_fourier: {by.get(RF)}")
    need(len(MINE) == 77 and len(set(MINE)) == 77 and len(WAS_RF) == 14 and set(WAS_RF) <= set(MINE),
         f"the lists: {len(MINE)} records, {len(WAS_RF)} that rested on the declared theorem, all among them")
    bad = [n for n in MINE if not (len(by.get(n, [])) == 1 and by[n][0][0] == "CLEAN" and by[n][0][1]
                                   and set(by[n][0][1]) <= set(STD))]
    need(not bad, f"the module's records, each once under CLEAN on a non-empty subset of the three "
         f"({len(MINE) - len(bad)} of {len(MINE)}){': ' + ', '.join(bad[:5]) if bad else ''}")
    bad_rf = [n for n in WAS_RF if by.get(n) != [("CLEAN", STD)]]
    need(not bad_rf, f"the fourteen that rested on the declared theorem, each on exactly the three "
         f"({len(WAS_RF) - len(bad_rf)} of {len(WAS_RF)}){': ' + ', '.join(bad_rf) if bad_rf else ''}")
    on_rf = [n for s, n, a in recs if RF in a]
    need(not on_rf and RF not in decl, f"no record rests on residual_fourier ({len(on_rf)}) and no DECLARED IMPORT names it")
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

    def at(name):
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"'{name}' "))
        j = i
        while not (lines[j].endswith("]") or lines[j].endswith("does not depend on any axioms")):
            j += 1
        return i, j

    i, j = at(WAS_RF[0])
    p, q = at(MINE[-1])
    imp_end = next(k for k, ln in enumerate(lines) if ln == "=== CLEAN ===")
    plants = {
        "an axiom added to a record that rested on the declared theorem":
            lines[:j] + [lines[j].replace("Quot.sound]", f"Quot.sound, {RF}]")] + lines[j + 1:],
        "a module record put under IMPORTED": lines[:imp_end] + lines[p:q + 1] + lines[imp_end:p] + lines[q + 1:],
        "a DECLARED IMPORT of residual_fourier": [lines[0], f"DECLARED IMPORT {RF}"] + lines[1:],
        "a module record removed": lines[:p] + lines[q + 1:],
        "a record printed twice": lines[:q + 1] + lines[p:q + 1] + lines[q + 1:],
    }
    for what, pl in plants.items():
        f = check(pl, quiet=True)
        print(f"plant '{what}': {'FAILED (as it must)' if f else 'PASSED'}" + (f" — {f[0][:120]}" if f else ""))
        ok = ok and bool(f)
    print("plants: " + ("every one fired; the unplanted receipt passes" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
