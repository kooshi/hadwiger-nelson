#!/usr/bin/env python3
"""FS131-IE1 — read a log of `#print axioms` records and require each record's axioms to be a subset of the standard
three (`propext`, `Classical.choice`, `Quot.sound`), or absent; and the records to be exactly the expected names.

Usage: fs131_ie1_axioms.py <log> <expected-names-file> [--control]
  <expected-names-file>: one full declaration name per line (the records the log must hold, no more, no fewer).
  --control: plant, in memory, a `sorryAx` in one record, a declared import's axiom in another, and remove a third;
             each must be reported (exit 0 iff all three are).
Exit 0 only when every expected record is present once and clean.
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}


def parse(text):
    recs = {}
    # Lean prints  'X' depends on axioms: [a, b, c]   or   'X' does not depend on any axioms
    joined = re.sub(r"\n\s+", " ", text)
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", joined):
        recs.setdefault(m.group(1), []).append({a.strip() for a in m.group(2).split(",") if a.strip()})
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", joined):
        recs.setdefault(m.group(1), []).append(set())
    return recs


def judge(recs, names):
    bad = []
    for n in names:
        got = recs.get(n)
        if not got:
            bad.append(f"MISSING  {n}: no record in the log")
        elif len(got) > 1:
            bad.append(f"TWICE    {n}: {len(got)} records")
        elif not got[0] <= STD:
            bad.append(f"AXIOMS   {n}: {sorted(got[0] - STD)} beyond the standard three")
    for n in recs:
        if n not in names:
            bad.append(f"EXTRA    {n}: a record the expected list does not hold")
    return bad


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    text = open(args[0]).read()
    names = [l.strip() for l in open(args[1]) if l.strip()]
    recs = parse(text)
    if "--control" in sys.argv:
        a, b, c = names[0], names[len(names) // 2], names[-1]
        recs[a] = [recs[a][0] | {"sorryAx"}]
        recs[b] = [recs[b][0] | {"HadwigerNelson.Rigidity.positive_entropy_rigidity"}]
        del recs[c]
        bad = judge(recs, names)
        for x in bad:
            print(x)
        ok = len(bad) == 3
        print(f"CONTROL: {len(bad)} of 3 planted faults reported — {'the check can fail' if ok else 'DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    bad = judge(recs, names)
    clean = sum(1 for n in names if recs.get(n) and len(recs[n]) == 1 and recs[n][0] <= STD)
    axfree = sum(1 for n in names if recs.get(n) and len(recs[n]) == 1 and not recs[n][0])
    print(f"records expected: {len(names)}; clean (a subset of the standard three): {clean}, of which axiom-free: {axfree}")
    for x in bad:
        print(x)
    print("AXIOMS OK" if not bad else f"AXIOMS FAILED: {len(bad)}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
