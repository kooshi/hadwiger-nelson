#!/usr/bin/env python3
"""FS131-L5: wave 5's records in the gate's saved axioms log — every theorem the landing adds to `main`'s library audited, each
under CLEAN and within the standard three.

Three lists are read:

  wave     the theorems of the landing library that `main`'s library does not hold — `DECL THM <module> <name>` lines of
           `data/fs131/l5/count-modules.lean`'s two outputs (the kernel's own list of theorems, machine-written API excluded;
           a `Prop`-valued instance is a theorem to the kernel and is listed);
  gone     the theorems of `main`'s library the landing no longer holds (the ruled removals);
  log      the records of `scripts/axioms.sh`'s full output (`build/gate/axioms/…`), each with the banner it was printed under.

A wave theorem whose name Lean generates (an equation lemma `f.eq_1`, a `congr_simp`, a structure's `mk.inj`, `mk.injEq`,
`mk.sizeOf_spec`, an inductive predicate's `brecOn`: reserved names no author writes, which the audit has never listed) is counted
and named as `generated`, and no record is asked of it; a record it does have is read like any other.

Checks: every hand-written wave theorem has exactly one record (MISSING / DOUBLED otherwise), printed between the CLEAN banner and the next
one (NOT-CLEAN-SECTION), on a subset of `[propext, Classical.choice, Quot.sound]` (FOREIGN: `sorryAx`, a native auxiliary, any
other axiom); no gone theorem has a record (STALE-RECORD); each name given by `--heads` rests on EXACTLY the three (HEAD).
Prints how many rest on exactly the three, on fewer (by set) and on none, by module.

Usage: fs131_l5_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG [--heads N1,N2,…] [--list-missing]
       fs131_l5_records.py MAIN_COUNT LANDING_COUNT AXIOMS_LOG [--heads …] --plant
           in memory: `sorryAx` added to the first head's record; a wave record dropped; a wave record doubled; a wave record
           moved under PURCHASED; a record given `Quot.sound` alone where a head is asked exact. Must exit 1 naming all five.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import re
import sys

STD = frozenset({"propext", "Classical.choice", "Quot.sound"})
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


def check(wave, gone, recs, heads, list_missing=False):
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
    return bad, tally, bymod, generated


def main(argv):
    plant = "--plant" in argv
    heads = argv[argv.index("--heads") + 1].split(",") if "--heads" in argv else []
    a = [x for i, x in enumerate(argv) if not x.startswith("--") and (i == 0 or argv[i - 1] != "--heads")]
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
        names = [n for n in sorted(wave) if any(r[0] == n for r in recs)]
        h0 = heads[0]
        v_drop, v_dbl, v_move = [n for n in names if n not in heads][:3]
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
            else:
                planted.append((n, ax, sec))
        recs = planted
        print(f"planted: sorryAx on {h0}; {v_drop} dropped; {v_dbl} doubled; {v_move} under PURCHASED; "
              f"{heads[1] if len(heads) > 1 else '-'} on Quot.sound alone  ({sorted(done)})")
    bad, tally, bymod, generated = check(wave, gone, recs, heads)
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
