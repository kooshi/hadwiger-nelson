#!/usr/bin/env python3
"""FS131-LGT1: the records check of the five-colour chain's landing, read from the axiom audit's own receipt
(`scripts/axioms.sh`'s normalized log, `build/gate/axioms/latest`, kept as `data/fs131/lgt1/gate/receipt-axioms-<tag>.log`),
from the kernel's print of every record of the 148 landed modules (`data/fs131/lgt1/axioms-all.txt`, by
`data/fs131/lgt1/lean/AxiomsAll.lean`) and from the coverage print (`data/fs131/lgt1/lean/Coverage.lean`).
FS131-LDB1's records check (`tools/fs131_ldb1_records.py`; its `read` and `parse` copied), with this landing's claims:
  1. every public record of the 148 modules is printed once by the audit, on exactly the axioms the printer printed for
     it, and under the section its axioms require (CLEAN: a subset of the three; IMPORTED: the three and declared
     imports, at least one);
  2. the headline `Rigidity.min_localBound_five_le_chromaticNumber` and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`
     are records under IMPORTED on exactly the three, `Rigidity.positive_entropy_rigidity` and
     `StandingFive.kloosterman_bound`;
  3. the declared imports are exactly Weil's bound, `Outside.OAI158.no_proper_five_coloring` and
     `Rigidity.positive_entropy_rigidity`; IMPORTED holds 60 records: main's 26 (20 on Weil's bound alone, 6 on the
     five-colour theorem alone; 13 and 6 of them outside the 148 modules) and the 148 modules' 41 (`ThreeFourColours`'
     7, the chain's 34), by import as the printer printed them;
  4. the totals: every record once; 11,284 records = the 9,845 at the start and the 1,439 placed; PURCHASED 5;
  5. with --coverage FILE: the 148 modules read, no record of the LGT1 block absent from them, the records read equal to
     the printer's public records, every public constant a record or reached (PUBLIC = RECORDS + REACHED, none
     UNREACHED), and the control blind to nothing — with the two leaf modules' records removed, exactly their public
     constants are reported.

  fs131_lgt1_records.py RECEIPT --coverage FILE           check, exit 0 iff every check passes
  fs131_lgt1_records.py RECEIPT --coverage FILE --plant   seven plants in memory (a record removed; a CLEAN record put
                                          under IMPORTED; `sorryAx` added to the headline; a record printed twice; a public
                                          constant UNREACHED; a record ABSENT; the control's lines dropped): each must
                                          fail, the unplanted inputs pass
"""
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STD = ["propext", "Classical.choice", "Quot.sound"]
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
H5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
PE = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
HEADS = ["HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber",
         "HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five"]
LEAVES = ("Proofs.HadwigerNelson.Rigidity.CertLinkModels", "Proofs.HadwigerNelson.Instances.SqrtClassValues")
START, PLACED = 9845, 1439


def printer():
    """-> {name: (module, sorted axioms)} for the public records of the 148 modules."""
    out = {}
    for ln in (ROOT / "data/fs131/lgt1/axioms-all.txt").read_text().splitlines():
        m = re.match(r"AXIOMS (\S+) public (\S+) : \[(.*)\]$", ln)
        if m and m.group(1) != "PLANT":
            out[m.group(2)] = (m.group(1), sorted(a.strip() for a in m.group(3).split(",") if a.strip()))
    return out


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


def check(lines, cov, quiet=False):
    recs, decl = parse(lines)
    pr = printer()
    fails = []

    def need(ok, what):
        if not quiet:
            print(f"  {'ok  ' if ok else 'FAIL'}  {what}")
        if not ok:
            fails.append(what)

    by = {}
    for s, n, a in recs:
        by.setdefault(n, []).append((s, sorted(a)))
    need(len(pr) == 1545, f"the printer: {len(pr)} public records of the 148 modules (1545 at the block's generation)")
    bad = []
    for n, (mod, ax) in pr.items():
        want = "CLEAN" if set(ax) <= set(STD) else "IMPORTED"
        if by.get(n) != [(want, ax)]:
            bad.append(f"{n}: audit {by.get(n)}, printer {want} {ax}")
    need(not bad, f"each printed once by the audit, its axioms the printer's, in its section "
         f"({len(pr) - len(bad)} of {len(pr)}){': ' + bad[0] if bad else ''}")
    for h in HEADS:
        need(by.get(h) == [("IMPORTED", sorted(STD + [PE, KB]))], f"{h}: {by.get(h)}")
    imp = [(n, sorted(a)) for s, n, a in recs if s == "IMPORTED"]
    combo = {}
    for n, a in imp:
        k = "+".join(sorted(x.split(".")[-1] for x in set(a) - set(STD)))
        combo[k] = combo.get(k, 0) + 1
    need(sorted(decl) == sorted([KB, H5, PE]), f"declared imports: {decl}")
    chain_pe = {}
    for n, (mod, ax) in pr.items():
        k = "+".join(sorted(x.split(".")[-1] for x in set(ax) - set(STD)))
        if k:
            chain_pe[k] = chain_pe.get(k, 0) + 1
    # main's 26 imported records outside the 148 modules: Weil's bound 13 (`StandingFive` 8, `ThreeColourCriterion` 5;
    # `ThreeFourColours`' 7 are in a changed module, so the printer counts them) and the five-colour theorem's 6
    want = {"kloosterman_bound": 13, "no_proper_five_coloring": 6}
    for k, v in chain_pe.items():
        want[k] = want.get(k, 0) + v
    need(len(imp) == 60 and combo == want, f"IMPORTED: {len(imp)} records (60 predicted), by import {combo}; "
         f"predicted main's 13 + 6 outside the 148 modules and the 148 modules' {chain_pe}")
    dup = sorted(n for n, v in by.items() if len(v) > 1)
    secs = {}
    for s, n, a in recs:
        secs[s] = secs.get(s, 0) + 1
    tot = START + PLACED
    need(len(recs) == tot and not dup and secs.get("CLEAN") == tot - 65 and secs.get("PURCHASED") == 5,
         f"records: {len(recs)} ({secs}), {tot} predicted (CLEAN {tot - 65}, IMPORTED 60, PURCHASED 5); "
         f"printed twice: {dup[:5]}")
    kv = {}
    for ln in cov:
        p = ln.split()
        if p and p[0] in ("MODULES", "REACHED", "CONTROL-REMOVED"):
            kv[p[0]] = int(p[1])
        elif p and p[0] == "CONSTANTS":
            kv["CONSTANTS"], kv["PUBLIC"] = int(p[1]), int(p[3])
        elif p and p[0] == "RECORDS":
            kv["RECORDS"], kv["ABSENT"], kv["BLOCK"] = int(p[1]), int(p[3]), int(p[5])
    unreached = [ln for ln in cov if ln.startswith("UNREACHED ")]
    absent = [ln for ln in cov if ln.startswith("ABSENT ")]
    pu = {ln.split()[2] for ln in cov if ln.startswith("PLANT-UNREACHED ")}
    leaves = {n for n, (mod, ax) in pr.items() if mod in LEAVES}
    need(kv.get("MODULES") == 148 and "END" in cov, f"coverage: modules {kv.get('MODULES')} (148), the print complete")
    need(kv.get("RECORDS") == len(pr) and kv.get("ABSENT") == 0 and not absent,
         f"coverage: {kv.get('RECORDS')} records among the 148 modules' constants (the printer's {len(pr)}), "
         f"{kv.get('ABSENT')} of the block's {kv.get('BLOCK')} absent")
    need(not unreached and kv.get("PUBLIC") is not None and kv.get("REACHED") is not None
         and kv["PUBLIC"] == kv["RECORDS"] + kv["REACHED"],
         f"coverage: public {kv.get('PUBLIC')} = records {kv.get('RECORDS')} + reached {kv.get('REACHED')}; "
         f"unreached {len(unreached)}{': ' + unreached[0] if unreached else ''}")
    need(kv.get("CONTROL-REMOVED") == len(leaves) and pu == leaves and leaves,
         f"coverage control: {kv.get('CONTROL-REMOVED')} removed, {len(pu)} reported, the two leaf modules' "
         f"{len(leaves)} public records exactly")
    return fails


def main():
    lines = read(sys.argv[1])
    if "--coverage" not in sys.argv:
        print("--coverage FILE is required")
        return 2
    cov = read(sys.argv[sys.argv.index("--coverage") + 1])
    if "--plant" not in sys.argv:
        fails = check(lines, cov)
        print("records: " + ("PASS" if not fails else f"FAIL ({len(fails)})"))
        return 1 if fails else 0
    ok = not check(lines, cov, quiet=True)
    print(f"unplanted: {'PASS' if ok else 'FAILED'}")

    def at(name):
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"'{name}' "))
        j = i
        while not (lines[j].endswith("]") or lines[j].endswith("does not depend on any axioms")):
            j += 1
        return i, j

    i, j = at(HEADS[1])
    clean_rec = next(n for n, (m, a) in printer().items() if a == sorted(STD) and m.endswith("FibreCertSound"))
    p, q = at(clean_rec)
    imp_end = next(k for k, ln in enumerate(lines) if ln == "=== CLEAN ===")
    plants = {
        "a record removed": (lines[:p] + lines[q + 1:], cov),
        "a CLEAN record put under IMPORTED": (lines[:imp_end] + lines[p:q + 1] + lines[imp_end:p] + lines[q + 1:], cov),
        "sorryAx added to the headline": (lines[:j] + [lines[j].replace("]", ", sorryAx]")] + lines[j + 1:], cov),
        "a record printed twice": (lines[:q + 1] + lines[p:q + 1] + lines[q + 1:], cov),
        "a public constant UNREACHED": (lines, cov[:-1] + ["UNREACHED THM HadwigerNelson.Rigidity.planted", "END"]),
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
