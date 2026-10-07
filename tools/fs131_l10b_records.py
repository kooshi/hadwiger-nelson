#!/usr/bin/env python3
"""FS131-L10B: the landing's records in the gate's saved axioms log (after `tools/fs131_l5_records.py`, which knows no import).

Three lists are read, as there: the theorems of the landing library that `main`'s library does not hold as theorems (`DECL THM`
lines of `data/fs131/l5/count-modules.lean`'s two outputs — the kernel's own list), the theorems of `main` the landing no longer
holds, and the records of `scripts/axioms.sh`'s full output, each with the banner it was printed under.

Checks. Every hand-written theorem of the landing has exactly one record (MISSING / DOUBLED). **The eight on the import**
(IMPORT below) are printed under IMPORTED, each on exactly `[propext, Classical.choice, Quot.sound]` and
`HadwigerNelson.StandingFive.kloosterman_bound` and nothing else (IMPORT-RECORD otherwise). Every other one is printed under
CLEAN (NOT-CLEAN-SECTION) on a subset of the standard three (FOREIGN: `sorryAx`, a native auxiliary, any other axiom). Over the
WHOLE log, not only the landing's records: the records under IMPORTED are exactly the eight (IMPORTED-SET); no record outside the
eight carries `kloosterman_bound` (IMPORT-LEAK); no record anywhere carries an axiom named `falconer_lemma2_nonempty`
(FALCONER-AXIOM: it is a theorem now, and a record that still lists it would be reading a stale copy). No theorem gone from
`main` has a record (STALE-RECORD). Each `--heads` name rests on EXACTLY the three (HEAD); each `--import-heads` name is one of
the eight.

Usage: fs131_l10b_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG [--heads N1,N2,…] [--import-heads M1,…] [--list-missing]
       fs131_l10b_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG [--heads …] --plant
           in memory, eight faults: `sorryAx` on the first head; a record dropped; one doubled; one moved under PURCHASED; a head
           on `Quot.sound` alone; one of the eight stripped of the import; a CLEAN record given the import; a record given
           Falconer's lemma as an axiom. Must exit 1 naming all eight.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import re
import sys

STD = frozenset({"propext", "Classical.choice", "Quot.sound"})
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
IMPORT = frozenset("HadwigerNelson.StandingFive." + n for n in (
    "kloostermanBound_of_ringChar_ne_two targetFloor_seven_weil targetFloor_six_weil circle_sum_le_weil standingFloor_seven_weil "
    "standingFloor_five_weil seven_le_localBound_weil five_le_chromaticNumber_weil").split())
REC = re.compile(r"'(\S+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", re.S)
BANNER = re.compile(r"^=== ([A-Z]+) ===$", re.M)
GENERATED = re.compile(r"\.(eq_\d+|eq_def|congr_simp|brecOn|binductionOn)$|\.mk\.(inj|injEq|sizeOf_spec)$")


def theorems(path):
    out = {}
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("DECL THM ") and len(p) >= 4:
            out[p[3]] = p[2]
    return out


def records(text):
    """[(name, axioms, section)] in the order printed; the section is the last banner before the record."""
    banners = [(m.start(), m.group(1)) for m in BANNER.finditer(text)]
    out = []
    for m in REC.finditer(text):
        sec = ""
        for pos, b in banners:
            if pos < m.start():
                sec = b
        ax = frozenset(a.strip() for a in (m.group(2) or "").split(",") if a.strip())
        out.append((m.group(1), ax, sec))
    return out


def check(wave, gone, recs, heads, import_heads=(), list_missing=False):
    by = collections.defaultdict(list)
    for n, ax, sec in recs:
        by[n].append((ax, sec))
    bad, tally, bymod = [], collections.Counter(), collections.Counter()
    generated = []
    for n in sorted(wave):
        got = by.get(n, [])
        if GENERATED.search(n) and not got:
            generated.append(n)
            continue
        if len(got) != 1:
            bad.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records; module {wave[n]})")
            continue
        ax, sec = got[0]
        if n in IMPORT:
            if sec != "IMPORTED" or ax != STD | {KB}:
                bad.append(f"IMPORT-RECORD {n}: under {sec or 'no banner'}, axioms {sorted(ax)}")
            else:
                tally["the three and the import"] += 1
                bymod[wave[n].replace("Proofs.HadwigerNelson.", "")] += 1
            continue
        if sec != "CLEAN":
            bad.append(f"NOT-CLEAN-SECTION {n}: printed under {sec or 'no banner'}")
        if ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        key = "exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")
        tally[key] += 1
        bymod[wave[n].replace("Proofs.HadwigerNelson.", "")] += 1
    for n in sorted(gone):
        if n in by:
            bad.append(f"STALE-RECORD {n}: gone from the library, still {len(by[n])} record(s)")
    for h in heads:
        got = by.get(h, [])
        if len(got) != 1 or got[0][0] != STD:
            bad.append(f"HEAD {h}: {'no single record' if len(got) != 1 else 'axioms ' + str(sorted(got[0][0]))}")
    for h in import_heads:
        if h not in IMPORT or h not in wave:
            bad.append(f"HEAD {h}: not one of the eight on the import, or not a theorem of the landing")
    # the whole log
    imp = sorted(n for n, ax, sec in recs if sec == "IMPORTED")
    if imp != sorted(IMPORT):
        bad.append(f"IMPORTED-SET: {len(imp)} record(s) under IMPORTED; extra {sorted(set(imp) - IMPORT)}, missing {sorted(IMPORT - set(imp))}")
    for n, ax, sec in recs:
        if KB in ax and n not in IMPORT:
            bad.append(f"IMPORT-LEAK {n}: carries the import, under {sec}")
        if any(a.endswith("falconer_lemma2_nonempty") for a in ax):
            bad.append(f"FALCONER-AXIOM {n}: lists {sorted(a for a in ax if a.endswith('falconer_lemma2_nonempty'))}")
    return bad, tally, bymod, generated


def main(argv):
    plant = "--plant" in argv
    heads = argv[argv.index("--heads") + 1].split(",") if "--heads" in argv else []
    import_heads = argv[argv.index("--import-heads") + 1].split(",") if "--import-heads" in argv else []
    a = [x for i, x in enumerate(argv) if not x.startswith("--") and (i == 0 or argv[i - 1] not in ("--heads", "--import-heads"))]
    if len(a) != 3:
        print(__doc__)
        return 2
    mthm, lthm = theorems(a[0]), theorems(a[1])
    text = open(a[2], encoding="utf-8").read()
    recs = records(text)
    if not mthm or not lthm or not recs:
        print(f"UNREADABLE: main theorems {len(mthm)}, landing theorems {len(lthm)}, records {len(recs)}")
        return 2
    wave = {n: m for n, m in lthm.items() if n not in mthm}
    gone = {n: m for n, m in mthm.items() if n not in lthm}
    if plant:
        names = [n for n in sorted(wave) if any(r[0] == n for r in recs) and n not in IMPORT]
        h0 = heads[0]
        v_drop, v_dbl, v_move, v_leak, v_falc = [n for n in names if n not in heads][:5]
        v_strip = sorted(IMPORT)[0]
        planted, done = [], set()
        for n, ax, sec in recs:
            if n == h0 and "sorry" not in done:
                planted.append((n, ax | {"sorryAx"}, sec)); done.add("sorry")
            elif n == v_drop:
                done.add("drop")
            elif n == v_dbl:
                planted += [(n, ax, sec), (n, ax, sec)]; done.add("dbl")
            elif n == v_move:
                planted.append((n, ax, "PURCHASED")); done.add("move")
            elif len(heads) > 1 and n == heads[1]:
                planted.append((n, frozenset({"Quot.sound"}), sec)); done.add("exact")
            elif n == v_strip:
                planted.append((n, ax - {KB}, sec)); done.add("strip")
            elif n == v_leak:
                planted.append((n, ax | {KB}, sec)); done.add("leak")
            elif n == v_falc:
                planted.append((n, ax | {"HadwigerNelson.Plane.falconer_lemma2_nonempty"}, sec)); done.add("falc")
            else:
                planted.append((n, ax, sec))
        recs = planted
        print(f"planted: sorryAx on {h0}; {v_drop} dropped; {v_dbl} doubled; {v_move} under PURCHASED; "
              f"{heads[1] if len(heads) > 1 else '-'} on Quot.sound alone; {v_strip} stripped of the import; {v_leak} given the "
              f"import; {v_falc} given Falconer's lemma as an axiom  ({sorted(done)})")
    bad, tally, bymod, generated = check(wave, gone, recs, heads, import_heads)
    if plant:
        words = ["FOREIGN " + h0, "MISSING " + v_drop, "DOUBLED " + v_dbl, "NOT-CLEAN-SECTION " + v_move, "HEAD ",
                 "IMPORT-RECORD " + v_strip, "IMPORT-LEAK " + v_leak, "FALCONER-AXIOM " + v_falc]
        fired = [w for w in words if any(b.startswith(w) for b in bad)]
        print(f"plants fired: {len(fired)} of {len(words)}" + ("" if len(fired) == len(words) else f"  NOT FIRED: {[w for w in words if w not in fired]}"))
    print(f"main: {len(mthm)} theorems; landing: {len(lthm)}; wave (landing only): {len(wave)} = {len(wave) - len(generated)} "
          f"hand-written + {len(generated)} generated with no record asked; gone (main only): {len(gone)}; "
          f"records in the log: {len(recs)}")
    kinds = collections.Counter(re.sub(r"^.*\.(mk\.)?", "", g) for g in generated)
    print("  generated, by suffix: " + ", ".join(f"{k} {v}" for k, v in sorted(kinds.items())))
    for g in sorted(gone):
        print(f"  gone: {g}  ({gone[g].replace('Proofs.HadwigerNelson.', '')})")
    for k, c in sorted(tally.items()):
        print(f"  wave records on {k}: {c}")
    for m, c in sorted(bymod.items()):
        print(f"  {m}: {c}")
    for h in heads:
        ok = not any(b.startswith(f"HEAD {h}:") or b.startswith(f"FOREIGN {h}:") for b in bad)
        print(f"  head {h}: {'exactly the standard three' if ok else 'FAILS'}")
    for h in import_heads:
        ok = not any(b.startswith(f"HEAD {h}:") or b.startswith(f"IMPORT-RECORD {h}:") for b in bad)
        print(f"  head {h}: {'exactly the standard three and StandingFive.kloosterman_bound' if ok else 'FAILS'}")
    print(f"  whole log: records under IMPORTED {sum(1 for r in recs if r[2] == 'IMPORTED')}; records carrying the import "
          f"{sum(1 for r in recs if KB in r[1])}; records listing Falconer's lemma as an axiom "
          f"{sum(1 for r in recs if any(a.endswith('falconer_lemma2_nonempty') for a in r[1]))}")
    miss = [b for b in bad if b.startswith("MISSING")]
    for b in bad:
        if b.startswith("MISSING") and not ("--list-missing" in argv or plant or len(miss) <= 12):
            continue
        print("FAIL", b)
    if miss and not ("--list-missing" in argv or plant or len(miss) <= 12):
        print(f"FAIL MISSING: {len(miss)} wave theorem(s) have no record (--list-missing prints them)")
    print("records:", "PASS" if not bad else f"FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
