#!/usr/bin/env python3
"""FS131-LDB1: the records check of the density bound's landing, read from the axiom audit's own receipt
(`scripts/axioms.sh`'s normalized log, `build/gate/axioms/latest`, kept as `data/fs131/ldb1/gate/receipt-axioms-<tag>.log`)
and from the coverage print of the 83 modules (`data/fs131/ldb1/lean/Coverage.lean`).
FS133-LD1's records check (`tools/fs133_ld1_records.py`; its `read` and `parse` copied) with this landing's claims:
  1. each of the 723 records of the block (`data/fs131/ldb1/axioms-block.txt`: FS131-IDB1's 264, FS131-IDB2's 41,
     FS131-IDB3's 418) is printed once, under CLEAN, on a subset of `[propext, Classical.choice, Quot.sound]`; 400 of
     them on a non-empty subset and 323 on none, as the three implementers printed them (the prediction,
     `data/fs131/ldb1/prediction-axioms.txt`);
  2. the headline `HadwigerNelson.Plane.oneAvoidingDensityBound` is a record under CLEAN on exactly the three;
  3. the declared imports are exactly `StandingFive.kloosterman_bound` and `Outside.OAI158.no_proper_five_coloring`;
     IMPORTED holds exactly 26 records, 20 on the first and 6 on the second (each the three and that one): `main`'s;
  4. the totals: every record once; 9,824 records = `main`'s 9,101 and the block's 723; CLEAN 9,793, PURCHASED 5;
  5. with --coverage FILE: the 83 modules read, no record absent from them, every public constant of them a record or
     reached from one (none UNREACHED; PUBLIC = RECORDS + REACHED), and the coverage's control blind to nothing — with
     FS131-IDB3's 418 records removed, each of them is reported, and nothing outside lane X's 427 public constants.

  fs131_ldb1_records.py RECEIPT [--coverage FILE]           check, exit 0 iff every check passes
  fs131_ldb1_records.py RECEIPT --coverage FILE --plant     seven plants in memory (a record removed; a record put under
                                          IMPORTED; `sorryAx` added to the headline; a record printed twice; a public
                                          constant UNREACHED; a record ABSENT; the control's lines dropped): each must
                                          fail, the unplanted inputs pass
"""
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STD = ["propext", "Classical.choice", "Quot.sound"]
HEAD = "HadwigerNelson.Plane.oneAvoidingDensityBound"
MINE = [ln.split()[2] for ln in (ROOT / "data/fs131/ldb1/axioms-block.txt").read_text().splitlines()
        if ln.startswith("#print axioms ")]
LANE_X = [ln.strip() for ln in (ROOT / "data/fs131/idb3/audit-block.txt").read_text().splitlines() if ln.strip()]
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
H5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
N_MINE, N_FREE, N_SOME = 723, 323, 400
TOTAL = 9101 + 723


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


def check(lines, cov=None, quiet=False):
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
    need(len(MINE) == N_MINE and len(set(MINE)) == N_MINE and HEAD in MINE and set(LANE_X) <= set(MINE),
         f"the block: {len(MINE)} records, distinct, the headline and lane X's 418 among them")
    bad = [n for n in MINE if not (len(by.get(n, [])) == 1 and by[n][0][0] == "CLEAN" and set(by[n][0][1]) <= set(STD))]
    need(not bad, f"the block's records, each once under CLEAN on a subset of the three "
         f"({len(MINE) - len(bad)} of {len(MINE)}){': ' + ', '.join(bad[:5]) if bad else ''}")
    free = sum(1 for n in MINE if len(by.get(n, [])) == 1 and not by[n][0][1])
    some = sum(1 for n in MINE if len(by.get(n, [])) == 1 and by[n][0][1])
    need(free == N_FREE and some == N_SOME, f"axiom-free {free} (predicted {N_FREE}), on a non-empty subset {some} "
         f"(predicted {N_SOME})")
    need(by.get(HEAD) == [("CLEAN", STD)], f"the headline {HEAD}: {by.get(HEAD)}")
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
    need(len(recs) == TOTAL and not dup and secs.get("CLEAN") == TOTAL - 31 and secs.get("PURCHASED") == 5,
         f"records: {len(recs)} ({secs}), {TOTAL} predicted (CLEAN {TOTAL - 31}, IMPORTED 26, PURCHASED 5); "
         f"printed twice: {dup[:5]}")
    if cov is not None:
        kv = {}
        for ln in cov:
            p = ln.split()
            if p and p[0] in ("MODULES", "REACHED", "CONTROL-REMOVED"):
                kv[p[0]] = int(p[1])
            elif p and p[0] in ("CONSTANTS", "RECORDS"):
                kv[p[0]], kv[p[2]] = int(p[1]), int(p[3])
        unreached = [ln for ln in cov if ln.startswith("UNREACHED ")]
        absent = [ln for ln in cov if ln.startswith("ABSENT ")]
        pu = {ln.split()[2] for ln in cov if ln.startswith("PLANT-UNREACHED ")}
        need(kv.get("MODULES") == 83 and "END" in cov, f"coverage: modules {kv.get('MODULES')} (83), the print complete")
        need(kv.get("RECORDS") == N_MINE and kv.get("ABSENT") == 0 and not absent,
             f"coverage: {kv.get('RECORDS')} records read, {kv.get('ABSENT')} absent from the 83 modules")
        need(not unreached and kv.get("PUBLIC") is not None and kv.get("REACHED") is not None
             and kv["PUBLIC"] == kv["RECORDS"] + kv["REACHED"],
             f"coverage: public {kv.get('PUBLIC')} = records {kv.get('RECORDS')} + reached {kv.get('REACHED')}; "
             f"unreached {len(unreached)}{': ' + unreached[0] if unreached else ''}")
        need(kv.get("CONTROL-REMOVED") == 418 and set(LANE_X) <= pu and len(pu) <= 427,
             f"coverage control: {kv.get('CONTROL-REMOVED')} removed; {len(set(LANE_X) & pu)} of 418 reported, "
             f"{len(pu)} in all (at most lane X's 427 public constants)")
    return fails


def main():
    lines = read(sys.argv[1])
    cov = None
    if "--coverage" in sys.argv:
        cov = read(sys.argv[sys.argv.index("--coverage") + 1])
    if "--plant" not in sys.argv:
        fails = check(lines, cov)
        print("records: " + ("PASS" if not fails else f"FAIL ({len(fails)})"))
        return 1 if fails else 0
    if cov is None:
        print("--plant needs --coverage")
        return 2
    ok = not check(lines, cov, quiet=True)
    print(f"unplanted: {'PASS' if ok else 'FAILED'}")

    def at(name):
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"'{name}' "))
        j = i
        while not (lines[j].endswith("]") or lines[j].endswith("does not depend on any axioms")):
            j += 1
        return i, j

    i, j = at(HEAD)
    p, q = at(MINE[0])
    imp_end = next(k for k, ln in enumerate(lines) if ln == "=== CLEAN ===")
    plants = {
        "a record of the block removed": (lines[:p] + lines[q + 1:], cov),
        "a record of the block put under IMPORTED":
            (lines[:imp_end] + lines[p:q + 1] + lines[imp_end:p] + lines[q + 1:], cov),
        "sorryAx added to the headline": (lines[:j] + [lines[j].replace("Quot.sound]", "Quot.sound, sorryAx]")]
                                          + lines[j + 1:], cov),
        "a record printed twice": (lines[:q + 1] + lines[p:q + 1] + lines[q + 1:], cov),
        "a public constant UNREACHED": (lines, cov[:-1] + ["UNREACHED THM HadwigerNelson.DensityBound.planted", "END"]),
        "a record ABSENT": (lines, [ln.replace("ABSENT 0", "ABSENT 1") for ln in cov]),
        "the control's lines dropped": (lines, [ln for ln in cov if not ln.startswith("PLANT-UNREACHED ")]),
    }
    for what, (pl, pc) in plants.items():
        f = check(pl, pc, quiet=True)
        print(f"plant '{what}': {'FAILED (as it must)' if f else 'PASSED'}" + (f" — {f[0][:120]}" if f else ""))
        ok = ok and bool(f)
    print("plants: " + ("every one fired; the unplanted inputs pass" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
