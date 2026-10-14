#!/usr/bin/env python3
"""FS131-LJ1: the landing's records in the gate's saved axioms log — every declaration a person typed in the six modules
of the three-and-four-colours line (`Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`, `Arith/ThreeColourCriterion`,
`Arith/DyadicQuadratic`, `Arith/ThreeFourColours`, `Instances/UpperHalfCorollaries`) has exactly one record: the twelve
this file lists (`LANDING_WEIL`) under IMPORTED, on the standard three and exactly Weil's bound
(`StandingFive.kloosterman_bound`); every other under CLEAN, on a subset of the standard three.  Over the whole log the
records under IMPORTED are the twenty-six the last landings left and these twelve: thirty-eight (20 + 6 + 12).

After `data/fs131/lu1/lu1_records.py` (FS131-LU1's; not edited).  Like it, this loads `data/fs131/lc1/records.py`
(FS131-LC1's) BY PATH under the name `lc1_records` — the loaded module's path is asserted — and takes from it the filing
of the twenty-six earlier imported records (`FILED`), the set of declared imports (`IMPORTS`), the standard three (`STD`)
and the reader of the audit's log (`l1.l10b.records`).  It lives under `data/fs131/lj1/` because the job's brief names
that directory and not `tools/`.

Two lists are read:
  DECLS       the output of `data/fs131/lj1/decls.lean` — every constant of the six modules as the kernel holds it
              (`LJ1DECL <kind> <written|aux> <GEN|-> <module> <name>`); a declaration the landing brings is a
              `written`, non-`GEN` line of kind THM, DEF or IND.  (Private helpers have internal names and are not
              listed: `data/fs131/kj1/logs/axioms-final.txt` has theirs.)
  AXIOMS_LOG  the full output of `scripts/axioms.sh` (its saved receipt), every record with the banner it is under.

What the landing CLAIMS is written here, once: COUNTS (11 + 20 + 17 + 13 + 31 + 4 = 96 declarations, 94 theorems and 2
definitions), LANDING_WEIL (the twelve on the import) and HEADLINES (the theorems the front page and the ledger will
name, each with what it must rest on).  What the library SHIPS is the log.  The checks:

  MISSING / DOUBLED      every declaration the landing brings has exactly one record
  WRONG-SECTION          … printed under IMPORTED if it is one of the twelve, under CLEAN otherwise
  FOREIGN                a CLEAN one is on a subset of the standard three (`sorryAx`, a native auxiliary: refused)
  HEADLINE               each headline is a theorem the landing brings, under its banner, on what the record says:
                         a "std3" headline under CLEAN on a subset of the standard three; a "weil" headline under
                         IMPORTED on the standard three and exactly Weil's bound
  MODULES / COUNTS       the dump lists exactly the six modules, with 11, 20, 17, 13, 31 and 4 declarations
  IMPORTED-SET           over the WHOLE log, the records under IMPORTED are exactly the thirty-eight
  IMPORT-RECORD          … each on the standard three and exactly its one import
  IMPORT-LEAK            over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS            over the whole log, no record carries two declared imports
  SORRY                  over the whole log, no record carries `sorryAx`

Usage: lj1_records.py DECLS AXIOMS_LOG
       lj1_records.py DECLS AXIOMS_LOG --plant
           in memory, sixteen faults, one at a time, each required to be refused by the check it was written for; the
           unplanted lists must pass first (the partner).  Exit 0 from --plant means every plant fired; 1 otherwise.
       lj1_records.py DECLS --unfiled AXIOMS_LEAN
           before the audit runs: the declarations the landing brings that `scripts/Axioms.lean` holds no
           `#print axioms` line for (one name per line), and those it holds more than one line for.  Exit 1 if any.
       lj1_records.py DECLS AXIOMS_LOG --lines
           the record's "Theorems this phase proved, final" lines: every declaration with its banner and its axioms.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
_p = ROOT / "data" / "fs131" / "lc1" / "records.py"
_spec = importlib.util.spec_from_file_location("lc1_records", _p)
c = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(c)
assert Path(c.__file__).resolve() == _p.resolve(), c.__file__

l1 = c.l1
STD = c.STD
IMPORTS = c.IMPORTS
assert sum(len(v) for v in c.FILED.values()) == 26 and len(c.ALL_FILED) == 26, "the last landings left twenty-six"
HN = "HadwigerNelson."
TC, TE, CR, DQ, TF, UH = (HN + x for x in ("ThreeColourCharacter.", "TorsionExtraction.", "ThreeColourCriterion.",
                                             "DyadicQuadratic.", "ThreeFourColours.", "UpperHalf."))
M = "Proofs.HadwigerNelson."
COUNTS = {M + "Arith.ThreeColourCharacter": 11, M + "Arith.TorsionExtraction": 20, M + "Arith.ThreeColourCriterion": 17,
          M + "Arith.DyadicQuadratic": 13, M + "Arith.ThreeFourColours": 31, M + "Instances.UpperHalfCorollaries": 4}
KINDS = ("THM", "DEF", "IND")
KIND_COUNTS = {"THM": 94, "DEF": 2, "IND": 0}
# the twelve records of the landing that rest on Weil's bound (the joining job's reading; the audit's log decides)
LANDING_WEIL = [CR + n for n in ("targetFloor_four_weil exists_normOne_zero_of_card_ne_nine exists_maximal_card_nine "
                                 "exists_maximal_of_torsion exists_maximal_card_nine_of_colorable_three").split()] + \
               [TF + n for n in ("colorable_three_planeOver_iff chromaticNumber_planeOver_eq_three_iff "
                                 "localBound_le_chromaticNumber_or_four_le localBound_le_chromaticNumber_of_le_four "
                                 "chromaticNumber_planeOver_eq_localBound_of_le_four chromaticNumber_planeOver_le_three_iff "
                                 "exists_maximal_card_nine_sqrt_three").split()]
FILED = {k: set(v) for k, v in c.FILED.items()}   # {import: the records filed on it}
FILED[l1.KB] |= set(LANDING_WEIL)
ALL_FILED = set().union(*FILED.values())
assert len(LANDING_WEIL) == 12 and len(FILED[l1.KB]) == 20 and len(ALL_FILED) == 38
# the theorems the front page and the ledger rows will name, with what each must rest on
STD_HEADLINES = [TF + n for n in (
    "chromaticNumber_planeOver_sqrt_table chromaticNumber_planeOver_sqrt_eq_two chromaticNumber_planeOver_sqrt_eq_three "
    "chromaticNumber_planeOver_sqrt_eq_four chromaticNumber_planeOver_sqrt_eq_four_of_dyadic "
    "chromaticNumber_planeOver_sqrt_eq_four_of_seven colorable_three_of_card_three exists_stablePrime_of_maximal "
    "exists_unitSet_residue_eq exists_stablePrime_conj_trivial exists_stablePrime_card_nine "
    "exists_maximal_card_three_of_card_nine levelTarget_colorable_two_of_ramified "
    "levelTarget_colorable_three_of_card_nine exists_stablePrime_ramified_sqrt exists_stablePrime_card_four_sqrt "
    "chromaticNumber_planeOver_sqrt_three").split()] + [TE + n for n in (
        "four_le_chromaticNumber_planeOver_of_inv_three_mem chromaticNumber_planeOver_ne_three_of_inv_three_mem "
        "four_le_chromaticNumber_planeOver_of_sqrt_mem four_le_chromaticNumber_planeOver_fieldOfRadicands "
        "fieldBandSet_three_eq_empty_of_sqrt_mem exists_torsion_mem_fieldBandSet "
        "colorable_two_iff_fieldBandSet_two_nonempty not_colorable_two_of_sqrt_mem "
        "three_le_chromaticNumber_planeOver_of_sqrt_mem").split()] + [TC + n for n in (
            "fieldBandSet_three_nonempty_of_colorable fieldBandSet_three_nonempty_of_colorable_unitRing "
            "bandSet_three_nonempty_of_proper").split()] + [CR + n for n in (
                "exists_maximal_conj_trivial_of_colorable_two fieldBandSet_two_nonempty_of_conj_trivial").split()] + [
    DQ + n for n in ("colorable_two_planeOver_sqrt colorable_four_planeOver_sqrt colorable_two_planeOver_sqrt_of_mod_four "
                     "colorable_planeOver_of_addMonoidHom").split()] + [UH + n for n in (
                         "chromaticNumber_planeOver_eq_two_of_localBound_le_two chromaticNumber_planeOver_sqrt_five_le_five "
                         "chromaticNumber_planeOver_sqrt_247_le_five two_notMem_stablePrime_seven").split()]
HEADLINES = [(n, "std3") for n in STD_HEADLINES] + [(n, "weil") for n in LANDING_WEIL]


def decls(path):
    """{name: (kind, module)} for the declarations the landing brings, the modules the dump lists, the constants."""
    out, mods, total = {}, set(), 0
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("LJ1MODULE ") and len(p) >= 2:
            mods.add(p[1])
        if ln.startswith("LJ1DECL ") and len(p) >= 6:
            total += 1
            kind, written, gen, mod, name = p[1], p[2], p[3], p[4], p[5]
            if written == "written" and gen == "-" and kind in KINDS:
                out[name] = (kind, mod)
    return out, mods, total


def check(wave, mods, recs):
    by = collections.defaultdict(list)
    for n, ax, sec in recs:
        by[n].append((ax, sec))
    bad, tally = [], collections.Counter()
    weil = set(LANDING_WEIL)
    for n in sorted(wave):
        got = by.get(n, [])
        if len(got) != 1:
            bad.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records; {wave[n][0]}, module {wave[n][1]})")
            continue
        ax, sec = got[0]
        want = "IMPORTED" if n in weil else "CLEAN"
        if sec != want:
            bad.append(f"WRONG-SECTION {n}: printed under {sec or 'no banner'}, the record says {want}")
        if n not in weil and ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        if n in weil:
            tally["the three and Weil's bound" if ax == STD | {l1.KB} else "OTHER: [" + ", ".join(sorted(ax)) + "]"] += 1
        else:
            tally["exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")] += 1
    for n, kind in HEADLINES:
        got = by.get(n, [])
        if n not in wave or wave[n][0] != "THM":
            bad.append(f"HEADLINE {n}: not a theorem the landing brings")
        elif len(got) != 1:
            bad.append(f"HEADLINE {n}: no single record")
        elif kind == "std3" and (got[0][1] != "CLEAN" or got[0][0] - STD):
            bad.append(f"HEADLINE {n}: under {got[0][1]}, axioms {sorted(got[0][0])} — not on the standard three under CLEAN")
        elif kind == "weil" and (got[0][1] != "IMPORTED" or got[0][0] != STD | {l1.KB}):
            bad.append(f"HEADLINE {n}: under {got[0][1]}, axioms {sorted(got[0][0])} — not the three and Weil's bound under IMPORTED")
    if mods != set(COUNTS):
        bad.append(f"MODULES: the dump lists {len(mods)} module(s); extra {sorted(mods - set(COUNTS))}, missing {sorted(set(COUNTS) - mods)}")
    per = collections.Counter(m for _, m in wave.values())
    kinds = collections.Counter(k for k, _ in wave.values())
    for m, k in COUNTS.items():
        if per[m] != k:
            bad.append(f"COUNTS {m}: {per[m]} declarations, the record says {k}")
    for k, v in KIND_COUNTS.items():
        if kinds[k] != v:
            bad.append(f"COUNTS kind {k}: {kinds[k]}, the record says {v}")
    # the whole log
    under = sorted(n for n, ax, sec in recs if sec == "IMPORTED")
    if under != sorted(ALL_FILED):
        bad.append(f"IMPORTED-SET: {len(under)} record(s) under IMPORTED; extra {sorted(set(under) - ALL_FILED)}, "
                   f"missing {sorted(ALL_FILED - set(under))}")
    for n, ax, sec in recs:
        carried = ax & IMPORTS
        if len(carried) > 1:
            bad.append(f"TWO-IMPORTS {n}: carries {sorted(l1.SHORT[a] for a in carried)}, under {sec}")
        for imp in carried:
            if n not in FILED[imp]:
                bad.append(f"IMPORT-LEAK {n}: carries {l1.SHORT[imp]} and is not filed on it, under {sec}")
        if "sorryAx" in ax:
            bad.append(f"SORRY {n}: carries sorryAx, under {sec}")
    for imp in sorted(IMPORTS):
        for n in sorted(FILED[imp]):
            got = by.get(n, [])
            if len(got) != 1 or got[0][1] != "IMPORTED" or got[0][0] != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {l1.SHORT[imp]}; "
                           f"{'no single record' if len(got) != 1 else f'under {got[0][1]}, axioms {sorted(got[0][0])}'}")
    return bad, tally


def plants(wave, mods, recs):
    """[(label, the failure line's prefix, planted wave, planted mods, planted records)] — one alteration each."""
    heads = {n for n, _ in HEADLINES}
    plain = [n for n in sorted(wave) if n not in heads]
    c_drop, c_dbl, c_sorry, c_kb, c_imp, c_pur, c_nat = plain[:7]
    table = TF + "chromaticNumber_planeOver_sqrt_table"
    clause_c = TE + "four_le_chromaticNumber_planeOver_of_inv_three_mem"
    clause_b = TF + "chromaticNumber_planeOver_eq_three_iff"
    row99 = TF + "localBound_le_chromaticNumber_of_le_four"
    floor = CR + "targetFloor_four_weil"
    old = sorted(c.FILED[l1.T])[0]
    ghost = TF + "zz_lj1_planted_theorem_with_no_record"

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    w2 = dict(wave)
    w2[ghost] = ("THM", M + "Arith.ThreeFourColours")
    w3 = {n: v for n, v in wave.items() if n != c_drop}
    return [
        (f"a record dropped ({c_drop})", "MISSING " + c_drop, wave, mods, alter(c_drop, lambda n, ax, sec: [])),
        (f"a record doubled ({c_dbl})", "DOUBLED " + c_dbl, wave, mods, alter(c_dbl, lambda n, ax, sec: [(n, ax, sec)] * 2)),
        (f"sorryAx under a landing record ({c_sorry})", "SORRY " + c_sorry, wave, mods,
         alter(c_sorry, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"a CLEAN landing record resting on Weil's bound ({c_kb})", "IMPORT-LEAK " + c_kb, wave, mods,
         alter(c_kb, lambda n, ax, sec: [(n, ax | {l1.KB}, sec)])),
        (f"a CLEAN landing record FILED under IMPORTED, on the three and the transfer ({c_imp})",
         "WRONG-SECTION " + c_imp, wave, mods, alter(c_imp, lambda n, ax, sec: [(n, ax | {l1.T}, "IMPORTED")])),
        (f"a landing record printed under PURCHASED ({c_pur})", "WRONG-SECTION " + c_pur, wave, mods,
         alter(c_pur, lambda n, ax, sec: [(n, ax, "PURCHASED")])),
        (f"a native auxiliary under a landing record ({c_nat})", "FOREIGN " + c_nat, wave, mods,
         alter(c_nat, lambda n, ax, sec: [(n, ax | {n + "._native.native_decide.ax_1_1"}, sec)])),
        (f"THE TABLE, WHICH NEEDS NO IMPORT, resting on Weil's bound ({table})", "HEADLINE " + table, wave, mods,
         alter(table, lambda n, ax, sec: [(n, ax | {l1.KB}, sec)])),
        (f"clause (c) printed under IMPORTED ({clause_c})", "HEADLINE " + clause_c, wave, mods,
         alter(clause_c, lambda n, ax, sec: [(n, ax, "IMPORTED")])),
        (f"CLAUSE (b) READ AS IF IT NEEDED NO IMPORT: under CLEAN on the three ({clause_b})", "HEADLINE " + clause_b,
         wave, mods, alter(clause_b, lambda n, ax, sec: [(n, ax - {l1.KB}, "CLEAN")])),
        (f"the theorem that discharges hRow99 with its import stripped, left under IMPORTED ({row99})",
         "IMPORT-RECORD " + row99, wave, mods, alter(row99, lambda n, ax, sec: [(n, ax - {l1.KB}, sec)])),
        (f"an imported landing record carrying a second import ({floor})", "TWO-IMPORTS " + floor, wave, mods,
         alter(floor, lambda n, ax, sec: [(n, ax | {l1.T}, sec)])),
        (f"a theorem of the landing with no record ({ghost})", "MISSING " + ghost, w2, mods, recs),
        (f"an earlier record on the transfer stripped of it ({old})", "IMPORT-RECORD " + old, wave, mods,
         alter(old, lambda n, ax, sec: [(n, ax - {l1.T}, sec)])),
        ("a module absent from the dump (Arith.DyadicQuadratic)", "MODULES", wave, mods - {M + "Arith.DyadicQuadratic"}, recs),
        (f"a declaration absent from the kernel's list ({c_drop})", "COUNTS", w3, mods, recs),
    ]


def unfiled(decl_path, axioms_lean):
    wave, mods, total = decls(decl_path)
    if not wave:
        print(f"UNREADABLE: {decl_path} lists no declaration")
        return 2
    lines = collections.Counter(m.group(1) for m in re.finditer(r"^#print axioms (\S+)\s*$", open(axioms_lean, encoding="utf-8").read(), re.M))
    missing = [n for n in sorted(wave) if lines[n] == 0]
    doubled = [n for n in sorted(wave) if lines[n] > 1]
    for n in missing:
        print(f"UNFILED {wave[n][0]} {wave[n][1].replace(M, '')} {n}")
    for n in doubled:
        print(f"DOUBLED {lines[n]} {n}")
    print(f"declarations the landing brings: {len(wave)} (of {total} constants in {len(mods)} modules); "
          f"with one line: {len(wave) - len(missing) - len(doubled)}; unfiled: {len(missing)}; doubled: {len(doubled)}; "
          f"`#print axioms` lines in the script: {sum(lines.values())}, names twice: {sum(1 for v in lines.values() if v > 1)}")
    return 1 if missing or doubled else 0


def lines_out(wave, mods, total, recs):
    by = {n: (ax, sec) for n, ax, sec in recs}
    order = ["propext", "Classical.choice", "Quot.sound"]
    kind = {"THM": "theorem", "DEF": "definition", "IND": "structure"}
    for m in COUNTS:
        print(f"*`{m.replace(M, '').replace('.', '/')}`*")
        for n in sorted(x for x in wave if wave[x][1] == m):
            ax, sec = by[n]
            names = [a for a in order if a in ax] + sorted(a.replace(HN, "") for a in ax if a not in order)
            print(f"- `{n.replace(HN, '')}` — {kind[wave[n][0]]}; [kernel]; under {sec}; axioms: "
                  f"{'[' + ', '.join(names) + ']' if names else 'none'}")
    print(f"({len(wave)} declarations of {total} constants in {len(mods)} modules)")
    return 0


def main(argv):
    a = [x for x in argv if not x.startswith("--")]
    if "--unfiled" in argv:
        return unfiled(a[0], a[1]) if len(a) == 2 else 2
    if len(a) != 2:
        print(__doc__)
        return 2
    wave, mods, total = decls(a[0])
    recs = l1.l10b.records(open(a[1], encoding="utf-8").read())
    if not wave or not recs:
        print(f"UNREADABLE: landing declarations {len(wave)}, records {len(recs)}")
        return 2
    if "--lines" in argv:
        return lines_out(wave, mods, total, recs)
    bad, tally = check(wave, mods, recs)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted lists already fail ({len(bad)}); the partner must pass first")
            for b in bad:
                print("FAIL", b)
            return 1
        ok, ps = True, plants(wave, mods, recs)
        for label, prefix, w, m, r in ps:
            pbad, _ = check(w, m, r)
            fired = [b for b in pbad if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else pbad[:2]}")
            ok = ok and bool(fired)
        print(f"plants: {f'every one of {len(ps)} fired; the unplanted lists pass' if ok else 'FAILED'}")
        return 0 if ok else 1
    kinds = collections.Counter(k for k, _ in wave.values())
    per = collections.Counter(m for _, m in wave.values())
    permod = ", ".join(m.replace(M, "") + " " + str(per[m]) for m in COUNTS)
    print(f"landing: {total} constants in {len(mods)} modules; declarations it brings: {len(wave)} "
          f"({', '.join(f'{kinds[k]} {k}' for k in KINDS)}; {permod}); records in the log: {len(recs)}")
    for k, v in sorted(tally.items()):
        print(f"  landing records on {k}: {v}")
    for kind, words in (("std3", "under CLEAN on the standard three"), ("weil", "under IMPORTED on the three and Weil's bound")):
        hs = [n for n, k in HEADLINES if k == kind]
        print(f"  headlines {words}: {sum(1 for n in hs if not any(b.startswith('HEADLINE ' + n) for b in bad))} of {len(hs)}")
    for imp in (l1.KB, l1.H, l1.T):
        carrying = sorted(n for n, ax, sec in recs if imp in ax)
        print(f"  whole log: records carrying {l1.SHORT[imp]}: {len(carrying)} (filed: {len(FILED[imp])}); "
              f"of the landing's: {sum(1 for n in carrying if n in wave)}")
    print(f"  whole log: records under IMPORTED {sum(1 for r in recs if r[2] == 'IMPORTED')}; carrying two imports "
          f"{sum(1 for r in recs if len(r[1] & IMPORTS) > 1)}; carrying sorryAx {sum(1 for r in recs if 'sorryAx' in r[1])}")
    for b in bad:
        print("FAIL", b)
    print("records: PASS" if not bad else f"records: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
