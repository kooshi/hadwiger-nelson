#!/usr/bin/env python3
"""FS132-L1: the landing's records in the gate's saved axioms log — a library with THREE declared imports.

After `tools/fs131_l10b_records.py` (FS131-L10B's, imported for its two readers and its list of the eight records on
Weil's bound; not edited), which knows one import and refuses any other record under IMPORTED.

Three lists are read: the theorems of the landing library that `main`'s gated library does not hold (`DECL THM` lines of
`data/fs131/l5/count-modules.lean`'s two outputs — the kernel's own list), the theorems of `main` the landing no longer
holds, and every record of `scripts/axioms.sh`'s full output with the banner it was printed under.

What the landing CLAIMS is written here, once (FILED below): which records rest on which declared import. What the
library SHIPS is the log. The checks:

  MISSING / DOUBLED     every hand-written theorem of the landing has exactly one record
  IMPORT-RECORD         a record filed on an import is printed under IMPORTED on exactly the standard three and that
                        one import — not the other, not both, not none
  NOT-CLEAN-SECTION     every other theorem of the landing is printed under CLEAN
  FOREIGN               … on a subset of the standard three (`sorryAx`, a native auxiliary, an import: refused)
  IMPORTED-SET          over the WHOLE log, the records under IMPORTED are exactly the eighteen filed (8 + 5 + 5)
  IMPORT-LEAK           over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS           over the whole log, no record carries two declared imports
  SORRY                 over the whole log, no record carries `sorryAx`
  STALE-RECORD          no theorem gone from `main` still has a record
  NOT-A-LANDING-THEOREM every record filed on the two new imports is a theorem the landing brings (the kernel's list)
  FOREIGN-MODULE        every theorem the landing brings is of the one module it lands, `Outside/OAI158`

Usage: fs132_l1_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG
       fs132_l1_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG --plant
           in memory, ten faults, one at a time, each required to be refused by the check it was written for; the
           unplanted log must pass first (the partner). Exit 0 from --plant means every plant fired; 1 otherwise.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs131_l10b_records as l10b  # noqa: E402  (its `theorems`, `records`, STD, KB, IMPORT, GENERATED are read, not copied)

STD = l10b.STD
NS = "HadwigerNelson.Outside.OAI158."
KB = l10b.KB
H = NS + "no_proper_five_coloring"
T = NS + "proper_to_borel_weak"
FILED = {
    KB: frozenset(l10b.IMPORT),
    H: frozenset(NS + n for n in (
        "not_colorable_five six_le_chromaticNumber_plane chromaticNumber_plane_six_or_seven six_le_chiM0 "
        "chiM0_six_or_seven").split()),
    T: frozenset(NS + n for n in (
        "nonempty_aeColouring_of_colorable colorable_iff_nonempty_aeColouring chiM0_le_chromaticNumber_plane "
        "chromaticNumber_plane_eq_chiM0 seven_le_chromaticNumber_plane_iff").split()),
}
LANDING_MODULE = "Proofs.HadwigerNelson.Outside.OAI158"
SHORT = {KB: "kloosterman_bound", H: "no_proper_five_coloring", T: "proper_to_borel_weak"}
ALL_FILED = frozenset().union(*FILED.values())
IMPORTS = frozenset(FILED)


def filed_on(name):
    for imp, names in FILED.items():
        if name in names:
            return imp
    return None


def check(wave, gone, recs):
    by = collections.defaultdict(list)
    for n, ax, sec in recs:
        by[n].append((ax, sec))
    bad, tally, generated = [], collections.Counter(), []
    for n in sorted(wave):
        got = by.get(n, [])
        if l10b.GENERATED.search(n) and not got:
            generated.append(n)
            continue
        if len(got) != 1:
            bad.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records; module {wave[n]})")
            continue
        ax, sec = got[0]
        imp = filed_on(n)
        if imp is not None:
            if sec != "IMPORTED" or ax != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {SHORT[imp]}; printed under {sec or 'no banner'}, axioms {sorted(ax)}")
            else:
                tally[f"the three and {SHORT[imp]}"] += 1
            continue
        if sec != "CLEAN":
            bad.append(f"NOT-CLEAN-SECTION {n}: printed under {sec or 'no banner'}")
        if ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        tally["exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")] += 1
    for n in sorted(gone):
        if n in by:
            bad.append(f"STALE-RECORD {n}: gone from the library, still {len(by[n])} record(s)")
    for n in sorted(wave):
        if wave[n] != LANDING_MODULE:
            bad.append(f"FOREIGN-MODULE {n}: a theorem main does not hold, in module {wave[n]}")
    for imp in (H, T):
        for n in sorted(FILED[imp]):
            if n not in wave:
                bad.append(f"NOT-A-LANDING-THEOREM {n}: filed on {SHORT[imp]} and not a theorem the landing brings")
    # the whole log
    under = sorted(n for n, ax, sec in recs if sec == "IMPORTED")
    if under != sorted(ALL_FILED):
        bad.append(f"IMPORTED-SET: {len(under)} record(s) under IMPORTED; extra {sorted(set(under) - ALL_FILED)}, "
                   f"missing {sorted(ALL_FILED - set(under))}")
    for n, ax, sec in recs:
        carried = ax & IMPORTS
        if len(carried) > 1:
            bad.append(f"TWO-IMPORTS {n}: carries {sorted(SHORT[a] for a in carried)}, under {sec}")
        for imp in carried:
            if n not in FILED[imp]:
                bad.append(f"IMPORT-LEAK {n}: carries {SHORT[imp]} and is not filed on it, under {sec}")
        if "sorryAx" in ax:
            bad.append(f"SORRY {n}: carries sorryAx, under {sec}")
    for imp in sorted(IMPORTS):  # the whole-log form of IMPORT-RECORD, for the records the landing did not bring
        for n in sorted(FILED[imp]):
            got = by.get(n, [])
            if n not in wave and (len(got) != 1 or got[0][1] != "IMPORTED" or got[0][0] != STD | {imp}):
                bad.append(f"IMPORT-RECORD {n}: filed on {SHORT[imp]}; "
                           f"{'no single record' if len(got) != 1 else f'under {got[0][1]}, axioms {sorted(got[0][0])}'}")
    return bad, tally, generated


def plants(recs, wave):
    """[(label, the failure line's prefix, planted records)] — each plant alters one record in memory."""
    clean = [n for n in sorted(wave) if any(r[0] == n and r[2] == "CLEAN" for r in recs)]
    c_drop, c_dbl, c_sorry, c_leak, c_move = clean[:5]
    h0, h1 = sorted(FILED[H])[:2]
    t_new = NS + "seven_le_chromaticNumber_plane_iff"
    t0 = NS + "chromaticNumber_plane_eq_chiM0"
    k0 = sorted(FILED[KB])[0]

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    return [
        (f"a record dropped ({c_drop})", "MISSING " + c_drop, alter(c_drop, lambda n, ax, sec: [])),
        (f"a record doubled ({c_dbl})", "DOUBLED " + c_dbl, alter(c_dbl, lambda n, ax, sec: [(n, ax, sec)] * 2)),
        (f"sorryAx on a clean record ({c_sorry})", "SORRY " + c_sorry, alter(c_sorry, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"a clean record given the transfer ({c_leak})", "IMPORT-LEAK " + c_leak, alter(c_leak, lambda n, ax, sec: [(n, ax | {T}, sec)])),
        (f"a clean record printed under PURCHASED ({c_move})", "NOT-CLEAN-SECTION " + c_move, alter(c_move, lambda n, ax, sec: [(n, ax, "PURCHASED")])),
        (f"a record on H printed under CLEAN ({h0})", "IMPORT-RECORD " + h0, alter(h0, lambda n, ax, sec: [(n, ax, "CLEAN")])),
        (f"a record on H stripped of its import ({h1})", "IMPORT-RECORD " + h1, alter(h1, lambda n, ax, sec: [(n, ax - {H}, sec)])),
        (f"the new theorem filed on the WRONG import — H for T ({t_new})", "IMPORT-RECORD " + t_new, alter(t_new, lambda n, ax, sec: [(n, (ax - {T}) | {H}, sec)])),
        (f"a record on T carrying both imports ({t0})", "TWO-IMPORTS " + t0, alter(t0, lambda n, ax, sec: [(n, ax | {H}, sec)])),
        (f"a record of main's on Weil's bound stripped of it ({k0})", "IMPORT-RECORD " + k0, alter(k0, lambda n, ax, sec: [(n, ax - {KB}, sec)])),
    ]


def main(argv):
    a = [x for x in argv if not x.startswith("--")]
    if len(a) != 3:
        print(__doc__)
        return 2
    mthm, lthm = l10b.theorems(a[0]), l10b.theorems(a[1])
    recs = l10b.records(open(a[2], encoding="utf-8").read())
    if not mthm or not lthm or not recs:
        print(f"UNREADABLE: main theorems {len(mthm)}, landing theorems {len(lthm)}, records {len(recs)}")
        return 2
    wave = {n: m for n, m in lthm.items() if n not in mthm}
    gone = {n: m for n, m in mthm.items() if n not in lthm}
    bad, tally, generated = check(wave, gone, recs)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted log already fails ({len(bad)}); the partner must pass first")
            for b in bad:
                print("FAIL", b)
            return 1
        ok = True
        for label, prefix, planted in plants(recs, wave):
            pbad, _, _ = check(wave, gone, planted)
            fired = [b for b in pbad if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else pbad[:2]}")
            ok = ok and bool(fired)
        print(f"plants: {'every one of 10 fired; the unplanted log passes' if ok else 'FAILED'}")
        return 0 if ok else 1
    print(f"main: {len(mthm)} theorems; landing: {len(lthm)}; landing only: {len(wave)} = {len(wave) - len(generated)} "
          f"hand-written + {len(generated)} generated with no record asked; gone (main only): {len(gone)}; "
          f"records in the log: {len(recs)}")
    bymod = collections.Counter(m.replace("Proofs.HadwigerNelson.", "") for m in wave.values())
    for m, c in sorted(bymod.items()):
        print(f"  theorems the landing brings, module {m}: {c}")
    for k, c in sorted(tally.items()):
        print(f"  landing records on {k}: {c}")
    for n in sorted(wave):
        got = [r for r in recs if r[0] == n]
        if got:
            print(f"  record {n.replace(NS, '')}: under {got[0][2]}: [{', '.join(sorted(x.replace(NS, '') for x in got[0][1]))}]")
    for imp in (KB, H, T):
        carrying = sorted(n for n, ax, sec in recs if imp in ax)
        print(f"  whole log: records carrying {SHORT[imp]}: {len(carrying)} (filed: {len(FILED[imp])})")
    print(f"  whole log: records under IMPORTED {sum(1 for r in recs if r[2] == 'IMPORTED')}; carrying two imports "
          f"{sum(1 for r in recs if len(r[1] & IMPORTS) > 1)}; carrying sorryAx {sum(1 for r in recs if 'sorryAx' in r[1])}")
    for b in bad:
        print("FAIL", b)
    print("records:", "PASS" if not bad else f"FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
