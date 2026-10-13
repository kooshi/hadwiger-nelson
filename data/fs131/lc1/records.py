#!/usr/bin/env python3
"""FS131-LC1: the landing's records in the gate's saved axioms log — every declaration the measurable-number module
(`Plane/LebesgueNumber`) brings is in a block, once, each filed on exactly what it rests on: the standard three (or
fewer), or the three and the ONE declared outside theorem it uses, `Outside.OAI158.proper_to_borel_weak`.

After `tools/fs124_l1_records.py` (FS124-L1's; not edited: the last landing that filed records under IMPORTED), from
which the filing of the twenty-three earlier imported records (`FILED`, 8 + 6 + 9) and the reader of the audit's log
are imported.  This landing files three more on the Borel transfer: twenty-six (8 + 6 + 12).  It lives under
`data/fs131/lc1/` because the job's brief names that directory and not `tools/`.

Two lists are read:
  DECLS       the output of `data/fs131/lc1/decls.lean` — every constant of the module as the kernel holds it
              (`LC1DECL <kind> <written|aux> <GEN|-> <module> <name>`); a declaration the landing brings is a
              `written`, non-`GEN` line of kind THM, DEF or IND: what a person typed, not what the elaborator made.
  AXIOMS_LOG  the full output of `scripts/axioms.sh` (its saved receipt), every record with the banner it is under.

What the landing CLAIMS is written here, once: FILED_HERE (three theorems on the transfer) and NO_IMPORT (the
theorems the front page will say need no outside theorem).  What the library SHIPS is the log.  The checks:

  MISSING / DOUBLED      every declaration the landing brings has exactly one record
  IMPORT-RECORD          a record filed on an import is printed under IMPORTED on exactly the standard three and that
                         one import — not another, not both, not none (over the whole log: the earlier twenty-three too)
  NOT-CLEAN-SECTION      every other declaration of the landing is printed under CLEAN
  FOREIGN                … on a subset of the standard three (`sorryAx`, a native auxiliary, an outside theorem: refused)
  NO-IMPORT              each theorem named as needing no outside theorem — the lemma in its four forms, the
                         weak-to-proper step in both, the converse, `chiM0_eq_chiLebesgue` and the two inequalities —
                         is a theorem the landing brings, under CLEAN, on exactly the three
  NOT-A-LANDING-THEOREM  each of the three records this landing files on the import is a theorem it brings
  MODULES                the modules the dump lists are exactly the landing's one
  IMPORTED-SET           over the WHOLE log, the records under IMPORTED are exactly the twenty-six filed (8 + 6 + 12)
  IMPORT-LEAK            over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS            over the whole log, no record carries two declared imports
  SORRY                  over the whole log, no record carries `sorryAx`

Usage: records.py DECLS AXIOMS_LOG
       records.py DECLS AXIOMS_LOG --plant
           in memory, sixteen faults, one at a time, each required to be refused by the check it was written for; the
           unplanted lists must pass first (the partner).  Exit 0 from --plant means every plant fired; 1 otherwise.
       records.py DECLS --unfiled AXIOMS_LEAN
           before the audit runs: the declarations the landing brings that `scripts/Axioms.lean` holds no
           `#print axioms` line for (one name per line), and those it holds more than one line for.  Exit 1 if any.
       records.py DECLS --block
           print the landing's two blocks for `scripts/Axioms.lean`: the three lines for the IMPORTED section, and one
           `#print axioms` line per other declaration for the CLEAN section, in the dump's order.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3] / "tools"))
import fs124_l1_records as e  # noqa: E402  (FILED 8 + 6 + 9, IMPORTS, STD; through it l1: SHORT, KB, H, T, NS, l10b)

l1 = e.l1
STD = e.STD
HN = "HadwigerNelson."
P = HN + "Plane."
# what THIS landing files on an import: three theorems on the Borel transfer
FILED_HERE = {
    l1.T: frozenset(P + n for n in (
        "colorable_iff_exists_nullMeasurable_proper chromaticNumber_plane_eq_chiLebesgue "
        "chromaticNumber_euclidean_plane_eq_chiLebesgue").split()),
}
FILED = {imp: e.FILED[imp] | FILED_HERE.get(imp, frozenset()) for imp in e.FILED}
ALL_FILED = frozenset().union(*FILED.values())
IMPORTS = e.IMPORTS
# the theorems the front page will say rest on no outside theorem
NO_IMPORT = [HN + n for n in (
    "exists_proper_ae_eq_of_proper_on_conull exists_proper_nullMeasurable_of_avoiding_cover "
    "davies_lemma_B1_euclidean").split()] + [P + n for n in (
        "davies_lemma_B1 exists_proper_of_aeColouring exists_proper_of_nullMeasurable_weak "
        "exists_aeColouring_of_nullMeasurable_proper nonempty_aeColouring_iff_exists_nullMeasurable_proper "
        "chiM0_eq_chiLebesgue chiLebesgue_le_chiM chromaticNumber_plane_le_chiLebesgue").split()]
MODULES = frozenset({"Proofs.HadwigerNelson.Plane.LebesgueNumber"})
KINDS = ("THM", "DEF", "IND")


def filed_on(name):
    for imp, names in FILED.items():
        if name in names:
            return imp
    return None


def decls(path):
    """{name: (kind, module)} for the declarations the landing brings, the modules the dump lists, the constants."""
    out, mods, total = {}, set(), 0
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("LC1MODULE ") and len(p) >= 2:
            mods.add(p[1])
        if ln.startswith("LC1DECL ") and len(p) >= 6:
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
    for n in sorted(wave):
        got = by.get(n, [])
        if len(got) != 1:
            bad.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records; {wave[n][0]}, module {wave[n][1]})")
            continue
        ax, sec = got[0]
        imp = filed_on(n)
        if imp is not None:
            if sec != "IMPORTED" or ax != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {l1.SHORT[imp]}; printed under {sec or 'no banner'}, axioms {sorted(ax)}")
            else:
                tally[f"the three and {l1.SHORT[imp]}"] += 1
            continue
        if sec != "CLEAN":
            bad.append(f"NOT-CLEAN-SECTION {n}: printed under {sec or 'no banner'}")
        if ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        tally["exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")] += 1
    for n in NO_IMPORT:
        got = by.get(n, [])
        if n not in wave or wave[n][0] != "THM":
            bad.append(f"NO-IMPORT {n}: not a theorem the landing brings")
        elif len(got) != 1 or got[0][0] != STD or got[0][1] != "CLEAN":
            bad.append(f"NO-IMPORT {n}: " + ("no single record" if len(got) != 1 else
                                             f"under {got[0][1]}, axioms {sorted(got[0][0])} — not exactly the three under CLEAN"))
    for imp, names in FILED_HERE.items():
        for n in sorted(names):
            if n not in wave or wave[n][0] != "THM":
                bad.append(f"NOT-A-LANDING-THEOREM {n}: filed on {l1.SHORT[imp]} and not a theorem the landing brings")
    if mods != MODULES:
        bad.append(f"MODULES: the dump lists {len(mods)} module(s); extra {sorted(mods - MODULES)}, missing {sorted(MODULES - mods)}")
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
    for imp in sorted(IMPORTS):  # the whole-log form of IMPORT-RECORD, for the records earlier landings filed
        for n in sorted(e.FILED[imp]):
            got = by.get(n, [])
            if len(got) != 1 or got[0][1] != "IMPORTED" or got[0][0] != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {l1.SHORT[imp]}; "
                           f"{'no single record' if len(got) != 1 else f'under {got[0][1]}, axioms {sorted(got[0][0])}'}")
    return bad, tally


def plants(wave, mods, recs):
    """[(label, the failure line's prefix, planted wave, planted mods, planted records)] — one alteration each."""
    clean = [n for n in sorted(wave) if filed_on(n) is None and n not in NO_IMPORT]
    c_drop, c_dbl, c_sorry, c_t, c_h, c_imp, c_pur, c_nat = clean[:8]
    head = P + "chromaticNumber_plane_eq_chiLebesgue"
    col = P + "colorable_iff_exists_nullMeasurable_proper"
    euc = P + "chromaticNumber_euclidean_plane_eq_chiLebesgue"
    eq = P + "chiM0_eq_chiLebesgue"
    lemma = HN + "exists_proper_ae_eq_of_proper_on_conull"
    old = sorted(e.FILED[l1.T])[0]
    ghost = P + "zz_lc1_planted_theorem_with_no_record"

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    w2 = dict(wave)
    w2[ghost] = ("THM", "Proofs.HadwigerNelson.Plane.LebesgueNumber")
    return [
        (f"a record dropped ({c_drop})", "MISSING " + c_drop, wave, mods, alter(c_drop, lambda n, ax, sec: [])),
        (f"a record doubled ({c_dbl})", "DOUBLED " + c_dbl, wave, mods, alter(c_dbl, lambda n, ax, sec: [(n, ax, sec)] * 2)),
        (f"sorryAx under a landing record ({c_sorry})", "SORRY " + c_sorry, wave, mods,
         alter(c_sorry, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"a clean landing record resting on the transfer ({c_t})", "IMPORT-LEAK " + c_t, wave, mods,
         alter(c_t, lambda n, ax, sec: [(n, ax | {l1.T}, sec)])),
        (f"a clean landing record resting on the five-colour theorem ({c_h})", "FOREIGN " + c_h, wave, mods,
         alter(c_h, lambda n, ax, sec: [(n, ax | {l1.H}, sec)])),
        (f"a clean landing record FILED under IMPORTED, on the three and the transfer ({c_imp})",
         "NOT-CLEAN-SECTION " + c_imp, wave, mods, alter(c_imp, lambda n, ax, sec: [(n, ax | {l1.T}, "IMPORTED")])),
        (f"a clean landing record printed under PURCHASED ({c_pur})", "NOT-CLEAN-SECTION " + c_pur, wave, mods,
         alter(c_pur, lambda n, ax, sec: [(n, ax, "PURCHASED")])),
        (f"a native auxiliary under a landing record ({c_nat})", "FOREIGN " + c_nat, wave, mods,
         alter(c_nat, lambda n, ax, sec: [(n, ax | {n + "._native.native_decide.ax_1_1"}, sec)])),
        (f"THE WRONG FILING: the headline on the five-colour theorem for the transfer ({head})", "IMPORT-RECORD " + head,
         wave, mods, alter(head, lambda n, ax, sec: [(n, (ax - {l1.T}) | {l1.H}, sec)])),
        (f"THE WRONG FILING: the colour-by-colour form printed under CLEAN ({col})", "IMPORT-RECORD " + col, wave, mods,
         alter(col, lambda n, ax, sec: [(n, ax, "CLEAN")])),
        (f"the Euclidean form carrying both imports ({euc})", "TWO-IMPORTS " + euc, wave, mods,
         alter(euc, lambda n, ax, sec: [(n, ax | {l1.H}, sec)])),
        (f"THE CLAIM THAT NEEDS NO IMPORT resting on the transfer: chiM0 = chiLebesgue ({eq})", "NO-IMPORT " + eq, wave, mods,
         alter(eq, lambda n, ax, sec: [(n, ax | {l1.T}, sec)])),
        (f"the formalized lemma printed under IMPORTED ({lemma})", "NO-IMPORT " + lemma, wave, mods,
         alter(lemma, lambda n, ax, sec: [(n, ax, "IMPORTED")])),
        (f"a theorem of the landing with no record ({ghost})", "MISSING " + ghost, w2, mods, recs),
        (f"an earlier record on the transfer stripped of it ({old})", "IMPORT-RECORD " + old, wave, mods,
         alter(old, lambda n, ax, sec: [(n, ax - {l1.T}, sec)])),
        ("the module absent from the dump (Plane.LebesgueNumber)", "MODULES", wave,
         mods - {"Proofs.HadwigerNelson.Plane.LebesgueNumber"}, recs),
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
        print(f"UNFILED {wave[n][0]} {wave[n][1].replace('Proofs.HadwigerNelson.', '')} {n}")
    for n in doubled:
        print(f"DOUBLED {lines[n]} {n}")
    print(f"declarations the landing brings: {len(wave)} (of {total} constants in {len(mods)} modules); "
          f"with one line: {len(wave) - len(missing) - len(doubled)}; unfiled: {len(missing)}; doubled: {len(doubled)}")
    return 1 if missing or doubled else 0


def block(decl_path):
    wave, mods, total = decls(decl_path)
    if not wave:
        print(f"UNREADABLE: {decl_path} lists no declaration")
        return 2
    imp = sorted(n for n in wave if filed_on(n) is not None)
    clean = sorted(n for n in wave if filed_on(n) is None)
    kinds = collections.Counter(wave[n][0] for n in clean)
    print("=== for the IMPORTED section, after FS124-I1's lines ===")
    print("-- FS131-KC1: the measurable number's records resting on `proper_to_borel_weak` (claim NF3-PLANE, `Plane/LebesgueNumber`; landed by FS131-LC1)")
    for n in (P + "colorable_iff_exists_nullMeasurable_proper", P + "chromaticNumber_plane_eq_chiLebesgue",
              P + "chromaticNumber_euclidean_plane_eq_chiLebesgue"):
        assert n in imp
        print(f"#print axioms {n}")
    print("=== for the CLEAN section, above the PURCHASED banner ===")
    print(f"-- FS131-LC1 block: `Plane/LebesgueNumber` — {len(clean)} records ({kinds['THM']} theorems, {kinds['DEF']} definitions), every")
    print("-- declaration a person typed that rests on no declared outside theorem, one line each (the kernel's list:")
    print("-- data/fs131/lc1/decls.lean; this block is `data/fs131/lc1/records.py DECLS --block`).  Statements and proofs")
    print("-- FS131-KC1's.  The module's other three declarations are under IMPORTED, on `proper_to_borel_weak`.")
    for n in clean:
        print(f"#print axioms {n}")
    print("-- FS131-LC1 block end")
    return 0


def main(argv):
    a = [x for x in argv if not x.startswith("--")]
    if "--unfiled" in argv:
        return unfiled(a[0], a[1]) if len(a) == 2 else 2
    if "--block" in argv:
        return block(a[0]) if len(a) == 1 else 2
    if len(a) != 2:
        print(__doc__)
        return 2
    wave, mods, total = decls(a[0])
    recs = l1.l10b.records(open(a[1], encoding="utf-8").read())
    if not wave or not recs:
        print(f"UNREADABLE: landing declarations {len(wave)}, records {len(recs)}")
        return 2
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
    print(f"landing: {total} constants in {len(mods)} modules; declarations it brings: {len(wave)} "
          f"({', '.join(f'{kinds[k]} {k}' for k in KINDS)}); records in the log: {len(recs)}")
    for k, c in sorted(tally.items()):
        print(f"  landing records on {k}: {c}")
    by = {n: (ax, sec) for n, ax, sec in recs}
    for n in sorted(ALL_FILED - e.ALL_FILED) + NO_IMPORT:
        if n in by:
            print(f"  record {n.replace(HN, '')}: under {by[n][1]}: [{', '.join(sorted(x.replace(l1.NS, '') for x in by[n][0]))}]")
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
