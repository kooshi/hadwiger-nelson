#!/usr/bin/env python3
"""FS124-L2: the landing's records in the gate's saved axioms log — every declaration the eight modules of FS-124's
second module bring is in a block, once, under CLEAN, on a subset of the standard three; and over the whole log the
records under IMPORTED are exactly the twenty-three filed before this landing (it files none).

After `tools/fs124_l1_records.py` (FS124-L1's; not edited), from which the earlier filing of imported records
(`FILED`, 8 + 6 + 9) and the reader of the audit's log are imported.  This landing's claim is the first kind again:
no record of the landing on a declared outside theorem.

Two lists are read:
  DECLS       the output of `data/fs124/l2/decls.lean` — every constant of the eight modules as the kernel holds it
              (`L2DECL <kind> <written|aux> <GEN|-> <module> <name>`); a declaration the landing brings is a `written`,
              non-`GEN` line of kind THM, DEF or IND: what a person typed, not what the elaborator made.
  AXIOMS_LOG  the full output of `scripts/axioms.sh` (its saved receipt), every record with the banner it is under.

The checks:
  MISSING / DOUBLED   every declaration the landing brings has exactly one record
  NOT-CLEAN-SECTION   … printed under CLEAN
  FOREIGN             … on a subset of the standard three (`sorryAx`, a native auxiliary, an outside theorem: refused)
  HEAD                each of the theorems the landing is for — the nine claims' theorems, the clause in the claim
                      list's words, the bridge and the three-arcs lemma, the four existence theorems — is a theorem
                      the landing brings, under CLEAN, on exactly the standard three
  MODULES             the modules the dump lists are exactly the landing's eight
  IMPORTED-SET        over the WHOLE log, the records under IMPORTED are exactly the twenty-three filed (8 + 6 + 9)
  IMPORT-LEAK         over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS         over the whole log, no record carries two declared imports
  SORRY               over the whole log, no record carries `sorryAx`

Usage: fs124_l2_records.py DECLS AXIOMS_LOG
       fs124_l2_records.py DECLS AXIOMS_LOG --plant
           in memory, twelve faults, one at a time, each required to be refused by the check it was written for; the
           unplanted lists must pass first (the partner).  Exit 0 from --plant means every plant fired; 1 otherwise.
       fs124_l2_records.py DECLS --unfiled AXIOMS_LEAN
           before the audit runs: the declarations the landing brings that `scripts/Axioms.lean` holds no
           `#print axioms` line for (one name per line), and those it holds more than one line for.  Exit 1 if any.
       fs124_l2_records.py DECLS --block
           print the landing's block for `scripts/Axioms.lean`: one `#print axioms` line per declaration it brings,
           by module, in the dump's order.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import re
import sys
from pathlib import Path

P = "HadwigerNelson.Plane."
MODS = ("CircleCrossing", "OnePiece", "ThreePiece", "ClosePair", "ClosePairWitness", "ClosePairModel", "ThreeArcs",
        "SectorPoint")
MODULES = frozenset("Proofs.HadwigerNelson.Plane." + m for m in MODS)
KINDS = ("THM", "DEF", "IND")
# the theorems the landing is for
HEAD = [P + n for n in (
    "shadow_open piece_type centre_half tight_centre tight_straddle "
    "closePair_forced_pieces closePair_lone closePair_both_separate closePair_both_saved closePair_four "
    "closePair_both_saved_of_isSector ThreePiece.IsSector.hasArcEdges ThreePiece.IsSector.isFull "
    "IsTriodCut.exists_opposite IsTriodCut.exists_arc "
    "exists_closePair_not_separatesAt exists_closePair_full exists_closePair_sector "
    "exists_closePair_seven_not_separatesAt sectorPoint_isSector").split()]


def earlier():
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import fs124_l1_records as e  # noqa: E402  (FILED, ALL_FILED, IMPORTS, STD, and through l1: SHORT, KB, H, T, l10b)
    return e


def decls(path):
    """{name: (kind, module)} for the declarations the landing brings, the modules the dump lists, the constants."""
    out, mods, total = {}, set(), 0
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("L2MODULE ") and len(p) >= 2:
            mods.add(p[1])
        if ln.startswith("L2DECL ") and len(p) >= 6:
            total += 1
            kind, written, gen, mod, name = p[1], p[2], p[3], p[4], p[5]
            if written == "written" and gen == "-" and kind in KINDS:
                out[name] = (kind, mod)
    return out, mods, total


def check(e, wave, mods, recs):
    STD, l1 = e.STD, e.l1
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
        if sec != "CLEAN":
            bad.append(f"NOT-CLEAN-SECTION {n}: printed under {sec or 'no banner'}")
        if ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        tally["exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")] += 1
    for n in HEAD:
        got = by.get(n, [])
        if n not in wave or wave[n][0] != "THM":
            bad.append(f"HEAD {n}: not a theorem the landing brings")
        elif len(got) != 1 or got[0][0] != STD or got[0][1] != "CLEAN":
            bad.append(f"HEAD {n}: " + ("no single record" if len(got) != 1 else
                                        f"under {got[0][1]}, axioms {sorted(got[0][0])} — not exactly the three under CLEAN"))
    if mods != MODULES:
        bad.append(f"MODULES: the dump lists {len(mods)} module(s); extra {sorted(mods - MODULES)}, missing {sorted(MODULES - mods)}")
    under = sorted(n for n, ax, sec in recs if sec == "IMPORTED")
    if under != sorted(e.ALL_FILED):
        bad.append(f"IMPORTED-SET: {len(under)} record(s) under IMPORTED; extra {sorted(set(under) - e.ALL_FILED)}, "
                   f"missing {sorted(e.ALL_FILED - set(under))}")
    for n, ax, sec in recs:
        carried = ax & e.IMPORTS
        if len(carried) > 1:
            bad.append(f"TWO-IMPORTS {n}: carries {sorted(l1.SHORT[a] for a in carried)}, under {sec}")
        for imp in carried:
            if n not in e.FILED[imp]:
                bad.append(f"IMPORT-LEAK {n}: carries {l1.SHORT[imp]} and is not filed on it, under {sec}")
        if "sorryAx" in ax:
            bad.append(f"SORRY {n}: carries sorryAx, under {sec}")
    return bad, tally


def plants(e, wave, mods, recs):
    """[(label, the failure line's prefix, planted wave, planted mods, planted records)] — one alteration each."""
    l1 = e.l1
    clean = [n for n in sorted(wave) if n not in HEAD]
    c_drop, c_dbl, c_sorry, c_t, c_imp, c_pur, c_nat = clean[:7]
    leaf = P + "ThreePiece.IsSector.hasArcEdges"
    four = P + "closePair_four"
    arc = P + "IsTriodCut.exists_arc"
    ghost = P + "zz_l2_planted_theorem_with_no_record"

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    w2 = dict(wave)
    w2[ghost] = ("THM", "Proofs.HadwigerNelson.Plane.ClosePair")
    return [
        (f"a record dropped ({c_drop})", "MISSING " + c_drop, wave, mods, alter(c_drop, lambda n, ax, sec: [])),
        (f"a record doubled ({c_dbl})", "DOUBLED " + c_dbl, wave, mods, alter(c_dbl, lambda n, ax, sec: [(n, ax, sec)] * 2)),
        (f"sorryAx under a landing record ({c_sorry})", "SORRY " + c_sorry, wave, mods,
         alter(c_sorry, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"THE LEAF STILL OPEN: sorryAx under the bridge ({leaf})", "FOREIGN " + leaf, wave, mods,
         alter(leaf, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"a landing record resting on the Borel transfer ({c_t})", "IMPORT-LEAK " + c_t, wave, mods,
         alter(c_t, lambda n, ax, sec: [(n, ax | {l1.T}, sec)])),
        (f"a landing record FILED under IMPORTED, on the three and the transfer ({c_imp})",
         "NOT-CLEAN-SECTION " + c_imp, wave, mods, alter(c_imp, lambda n, ax, sec: [(n, ax | {l1.T}, "IMPORTED")])),
        (f"a landing record printed under PURCHASED ({c_pur})", "NOT-CLEAN-SECTION " + c_pur, wave, mods,
         alter(c_pur, lambda n, ax, sec: [(n, ax, "PURCHASED")])),
        (f"a native auxiliary under a landing record ({c_nat})", "FOREIGN " + c_nat, wave, mods,
         alter(c_nat, lambda n, ax, sec: [(n, ax | {n + "._native.native_decide.ax_1_1"}, sec)])),
        (f"a claim's theorem resting on the five-colour theorem ({four})", "HEAD " + four, wave, mods,
         alter(four, lambda n, ax, sec: [(n, ax | {l1.H}, sec)])),
        (f"the three-arcs lemma printed under IMPORTED ({arc})", "HEAD " + arc, wave, mods,
         alter(arc, lambda n, ax, sec: [(n, ax, "IMPORTED")])),
        (f"a theorem of the landing with no record ({ghost})", "MISSING " + ghost, w2, mods, recs),
        ("a module of the landing absent from the dump (Plane.ThreeArcs)", "MODULES", wave,
         mods - {"Proofs.HadwigerNelson.Plane.ThreeArcs"}, recs),
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
    kinds = collections.Counter(k for k, _ in wave.values())
    print(f"-- FS124-L2 block: FS-124's second module, the eight modules of the landing — {len(wave)} records "
          f"({kinds['THM']} theorems, {kinds['DEF']} definitions, {kinds['IND']} structures and inductive types), every")
    print("-- declaration a person typed, one line each (the kernel's list: data/fs124/l2/decls.lean; this block is")
    print("-- `tools/fs124_l2_records.py DECLS --block`).  Statements FS124-K2's and FS124-K3's; proofs FS124-I2's")
    print("-- (CircleCrossing, OnePiece), FS124-I3's (ThreePiece, ClosePair), FS124-I4's (ClosePairWitness,")
    print("-- ClosePairModel, SectorPoint) and FS124-I5's (ThreeArcs); the bridge's two lines FS124-K3's.  Every record")
    print("-- CLEAN: no declared outside theorem is read by any of the eight modules.")
    for m in MODS:
        full = "Proofs.HadwigerNelson.Plane." + m
        names = sorted(n for n, (_, mod) in wave.items() if mod == full)
        print(f"-- FS124-L2: Plane/{m} ({len(names)})")
        for n in names:
            print(f"#print axioms {n}")
    print("-- FS124-L2 block end")
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
    e = earlier()
    wave, mods, total = decls(a[0])
    recs = e.l1.l10b.records(open(a[1], encoding="utf-8").read())
    if not wave or not recs:
        print(f"UNREADABLE: landing declarations {len(wave)}, records {len(recs)}")
        return 2
    bad, tally = check(e, wave, mods, recs)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted lists already fail ({len(bad)}); the partner must pass first")
            for b in bad:
                print("FAIL", b)
            return 1
        ok, ps = True, plants(e, wave, mods, recs)
        for label, prefix, w, m, r in ps:
            pbad, _ = check(e, w, m, r)
            fired = [b for b in pbad if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else pbad[:2]}")
            ok = ok and bool(fired)
        print(f"plants: {f'every one of {len(ps)} fired; the unplanted lists pass' if ok else 'FAILED'}")
        return 0 if ok else 1
    kinds = collections.Counter(k for k, _ in wave.values())
    print(f"landing: {total} constants in {len(mods)} modules; declarations it brings: {len(wave)} "
          f"({', '.join(f'{kinds[k]} {k}' for k in KINDS)}); records in the log: {len(recs)}")
    bymod = collections.Counter(m.replace("Proofs.HadwigerNelson.", "") for _, m in wave.values())
    for m, c in sorted(bymod.items()):
        print(f"  declarations the landing brings, module {m}: {c}")
    for k, c in sorted(tally.items()):
        print(f"  landing records on {k}: {c}")
    by = {n: (ax, sec) for n, ax, sec in recs}
    for n in HEAD:
        if n in by:
            print(f"  record {n.replace(P, '')}: under {by[n][1]}: [{', '.join(sorted(x.replace(e.l1.NS, '') for x in by[n][0]))}]")
    for imp in (e.l1.KB, e.l1.H, e.l1.T):
        carrying = sorted(n for n, ax, sec in recs if imp in ax)
        print(f"  whole log: records carrying {e.l1.SHORT[imp]}: {len(carrying)} (filed: {len(e.FILED[imp])}); "
              f"of the landing's: {sum(1 for n in carrying if n in wave)}")
    print(f"  whole log: records under IMPORTED {sum(1 for r in recs if r[2] == 'IMPORTED')}; carrying two imports "
          f"{sum(1 for r in recs if len(r[1] & e.IMPORTS) > 1)}; carrying sorryAx {sum(1 for r in recs if 'sorryAx' in r[1])}")
    for b in bad:
        print("FAIL", b)
    print("records: PASS" if not bad else f"records: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
