#!/usr/bin/env python3
"""FS124-L1: the landing's records in the gate's saved axioms log — every declaration the three modules of the radius
clause bring is in a block, once, each filed on exactly what it rests on: the standard three, or the three and the ONE
declared outside theorem it uses.

After `tools/fs132_l2_records.py` (FS132-L2's; not edited), whose claim was "no record of the landing on an import".
This landing's claim is the other kind: five of its theorems rest on an import, each on exactly one, and the rest on
none.  Imported for its readers and its filing of the eighteen earlier imported records: `tools/fs132_l1_records.py`
(FS132-L1's; not edited), and through it `tools/fs131_l10b_records.py`'s reader of the audit's log.

Two lists are read:
  DECLS       the output of `data/fs124/l1/decls.lean` — every constant of the three modules as the kernel holds it
              (`L1DECL <kind> <written|aux> <GEN|-> <module> <name>`); a declaration the landing brings is a `written`,
              non-`GEN` line of kind THM, DEF or IND: what a person typed, not what the elaborator made.
  AXIOMS_LOG  the full output of `scripts/axioms.sh` (its saved receipt), every record with the banner it is under.

What the landing CLAIMS is written here, once (FILED_HERE below): `radius_five` on the five-colour theorem; the four
theorems of (down) and the join on the Borel transfer; every other declaration under CLEAN on a subset of the standard
three.  What the library SHIPS is the log.  The checks:

  MISSING / DOUBLED   every declaration the landing brings has exactly one record
  IMPORT-RECORD       a record filed on an import is printed under IMPORTED on exactly the standard three and that one
                      import — not the other, not both, not none (over the whole log: the eighteen earlier ones too)
  NOT-CLEAN-SECTION   every other declaration of the landing is printed under CLEAN
  FOREIGN             … on a subset of the standard three (`sorryAx`, a native auxiliary, an outside theorem: refused)
  HALF                the two halves of the criterion that need no import — `radius_up` and
                      `exists_radius_of_not_colorable` — and the form at any centres are theorems the landing brings,
                      under CLEAN, on exactly the three
  NOT-A-LANDING-THEOREM  each of the five records this landing files on an import is a theorem it brings
  MODULES             the modules the dump lists are exactly the landing's three
  IMPORTED-SET        over the WHOLE log, the records under IMPORTED are exactly the twenty-three filed (8 + 6 + 9)
  IMPORT-LEAK         over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS         over the whole log, no record carries two declared imports
  SORRY               over the whole log, no record carries `sorryAx`

Usage: fs124_l1_records.py DECLS AXIOMS_LOG
       fs124_l1_records.py DECLS AXIOMS_LOG --plant
           in memory, fifteen faults, one at a time, each required to be refused by the check it was written for; the
           unplanted lists must pass first (the partner).  Exit 0 from --plant means every plant fired; 1 otherwise.
       fs124_l1_records.py DECLS --unfiled AXIOMS_LEAN
           before the audit runs: the declarations the landing brings that `scripts/Axioms.lean` holds no
           `#print axioms` line for (one name per line), and those it holds more than one line for.  Exit 1 if any.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs132_l1_records as l1  # noqa: E402  (STD, FILED, SHORT, IMPORTS, KB, H, T and l10b's `records` reader)

STD = l1.STD
P = "HadwigerNelson.Plane."
# what THIS landing files on an import: one theorem on the five-colour theorem, four on the Borel transfer
FILED_HERE = {
    l1.H: frozenset({P + "radius_five"}),
    l1.T: frozenset(P + n for n in (
        "exists_isWeakColouringOn_of_colorable radius_down colorable_iff_forall_ball "
        "seven_le_chromaticNumber_plane_iff_exists_ball").split()),
}
FILED = {imp: l1.FILED[imp] | FILED_HERE.get(imp, frozenset()) for imp in l1.FILED}
ALL_FILED = frozenset().union(*FILED.values())
IMPORTS = l1.IMPORTS
# the halves of the criterion that the front page says need no import, and the form of (up) at any centres
HALF = [P + n for n in ("radius_up", "exists_radius_of_not_colorable", "colorable_plane_of_forall_aeProperOn_ball",
                        "radius_graph", "radius_countable")]
MODULES = frozenset("Proofs.HadwigerNelson.Plane." + m for m in ("WeakColouringOn", "Radius", "RadiusOutside"))
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
        if ln.startswith("L1MODULE ") and len(p) >= 2:
            mods.add(p[1])
        if ln.startswith("L1DECL ") and len(p) >= 6:
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
    for n in HALF:
        got = by.get(n, [])
        if n not in wave or wave[n][0] != "THM":
            bad.append(f"HALF {n}: not a theorem the landing brings")
        elif len(got) != 1 or got[0][0] != STD or got[0][1] != "CLEAN":
            bad.append(f"HALF {n}: " + ("no single record" if len(got) != 1 else
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
        for n in sorted(l1.FILED[imp]):
            got = by.get(n, [])
            if len(got) != 1 or got[0][1] != "IMPORTED" or got[0][0] != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {l1.SHORT[imp]}; "
                           f"{'no single record' if len(got) != 1 else f'under {got[0][1]}, axioms {sorted(got[0][0])}'}")
    return bad, tally


def plants(wave, mods, recs):
    """[(label, the failure line's prefix, planted wave, planted mods, planted records)] — one alteration each."""
    clean = [n for n in sorted(wave) if filed_on(n) is None and n not in HALF]
    c_drop, c_dbl, c_sorry, c_t, c_h, c_imp, c_pur, c_nat = clean[:8]
    five = P + "radius_five"
    down = P + "radius_down"
    join = P + "seven_le_chromaticNumber_plane_iff_exists_ball"
    up = P + "radius_up"
    k0 = sorted(l1.FILED[l1.KB])[0]
    ghost = P + "zz_l1_planted_theorem_with_no_record"

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    w2 = dict(wave)
    w2[ghost] = ("THM", "Proofs.HadwigerNelson.Plane.Radius")
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
        (f"THE WRONG FILING: radius_five on the transfer for the five-colour theorem ({five})", "IMPORT-RECORD " + five,
         wave, mods, alter(five, lambda n, ax, sec: [(n, (ax - {l1.H}) | {l1.T}, sec)])),
        (f"THE WRONG FILING: radius_down printed under CLEAN ({down})", "IMPORT-RECORD " + down, wave, mods,
         alter(down, lambda n, ax, sec: [(n, ax, "CLEAN")])),
        (f"the criterion carrying both imports ({join})", "TWO-IMPORTS " + join, wave, mods,
         alter(join, lambda n, ax, sec: [(n, ax | {l1.H}, sec)])),
        (f"the half that needs no import resting on the transfer ({up})", "HALF " + up, wave, mods,
         alter(up, lambda n, ax, sec: [(n, ax | {l1.T}, sec)])),
        (f"a theorem of the landing with no record ({ghost})", "MISSING " + ghost, w2, mods, recs),
        (f"a record of main's on Weil's bound stripped of it ({k0})", "IMPORT-RECORD " + k0, wave, mods,
         alter(k0, lambda n, ax, sec: [(n, ax - {l1.KB}, sec)])),
        ("a module of the landing absent from the dump (Plane.RadiusOutside)", "MODULES", wave,
         mods - {"Proofs.HadwigerNelson.Plane.RadiusOutside"}, recs),
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


def main(argv):
    if "--unfiled" in argv:
        a = [x for x in argv if not x.startswith("--")]
        return unfiled(a[0], a[1]) if len(a) == 2 else 2
    a = [x for x in argv if not x.startswith("--")]
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
    bymod = collections.Counter(m.replace("Proofs.HadwigerNelson.", "") for _, m in wave.values())
    for m, c in sorted(bymod.items()):
        print(f"  declarations the landing brings, module {m}: {c}")
    for k, c in sorted(tally.items()):
        print(f"  landing records on {k}: {c}")
    by = {n: (ax, sec) for n, ax, sec in recs}
    for n in sorted(ALL_FILED - l1.ALL_FILED) + HALF:
        if n in by:
            print(f"  record {n.replace(P, '')}: under {by[n][1]}: [{', '.join(sorted(x.replace(l1.NS, '') for x in by[n][0]))}]")
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
