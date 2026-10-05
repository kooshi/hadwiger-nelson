#!/usr/bin/env python3
"""FS131-IP2: read a `#print axioms` output (pp.fullNames) and check each record against its expectation.

Usage: fs131_ip_axioms.py OUTPUT CLEAN_NAMES... -- SORRY_NAMES...
A CLEAN name must print axioms that are a subset of the standard three (or no axioms); a SORRY name must print `sorryAx`.
Every named declaration must have a record; any failure prints FAIL lines and exits 1. A record for a name in neither list is a FAIL too
(nothing passes unread).
"""
import re, sys

STD = {'propext', 'Classical.choice', 'Quot.sound'}

def parse(text):
    recs = {}
    for m in re.finditer(r"'([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text, re.S):
        name, ax = m.group(1), m.group(2)
        recs[name] = set() if ax is None else {a.strip() for a in ax.replace('\n', ' ').split(',') if a.strip()}
    return recs

def main():
    args = sys.argv[1:]
    out = open(args[0]).read()
    rest = args[1:]
    if '--' in rest:
        i = rest.index('--'); clean, sorry = rest[:i], rest[i + 1:]
    else:
        clean, sorry = rest, []
    recs = parse(out)
    fails = []
    for n in clean:
        if n not in recs: fails.append(f'{n}: NO RECORD')
        elif not recs[n] <= STD: fails.append(f'{n}: NOT CLEAN {sorted(recs[n])}')
    for n in sorry:
        if n not in recs: fails.append(f'{n}: NO RECORD')
        elif 'sorryAx' not in recs[n]: fails.append(f'{n}: CONTROL SHOWS NO sorryAx {sorted(recs[n])}')
    for n in recs:
        if n not in clean and n not in sorry: fails.append(f'{n}: RECORD NOT EXPECTED')
    if fails:
        print('FAIL:\n  ' + '\n  '.join(fails)); sys.exit(1)
    print(f'OK: {len(clean)} clean on the standard three, {len(sorry)} controls on sorryAx')

main()
