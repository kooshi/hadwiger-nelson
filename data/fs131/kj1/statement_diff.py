#!/usr/bin/env python3
"""FS131-KJ1: compare two prints of data/fs131/kj1/lean/StatementDump.lean.

usage: statement_diff.py <before> <after> [--allow <file>] [--plant]
PASS iff every STMT line of <before> is a line of <after>, except constants named in --allow (one full name a line, '#'
comments): those may differ or be gone, and each is reported. New lines of <after> are listed as ADDED (they are the
statements this job adds). --plant changes the type hash of the first THM line of <before> in memory and must end in FAIL
naming it: exit 0 only then."""
import sys
args = [a for a in sys.argv[1:] if not a.startswith("--")]
allow = set()
if "--allow" in sys.argv:
    allow = {l.strip() for l in open(sys.argv[sys.argv.index("--allow") + 1]) if l.strip() and not l.startswith("#")}
    args = [a for a in args if a != sys.argv[sys.argv.index("--allow") + 1]]
before = [l.rstrip("\n") for l in open(args[0]) if l.startswith("STMT ")]
after = [l.rstrip("\n") for l in open(args[1]) if l.startswith("STMT ")]
plant = "--plant" in sys.argv
if plant:
    i = next(k for k, l in enumerate(before) if " THM " in l)
    name = before[i].split()[3]
    before[i] = before[i].replace("type=", "type=9", 1)
aset = set(after)
name_of = lambda l: l.split()[3]
after_names = {name_of(l) for l in after}
before_names = {name_of(l) for l in before}
bad = []
for l in before:
    if l in aset: continue
    n = name_of(l)
    if n in allow:
        print(f"ALLOWED {'CHANGED' if n in after_names else 'GONE'} {n}"); continue
    bad.append(n)
    print(f"{'CHANGED' if n in after_names else 'GONE'} {n}")
added = [l for l in after if name_of(l) not in before_names]
for l in added:
    print(f"ADDED {l.split()[1]} {l.split()[2]} {name_of(l)}")
print(f"before={len(before)} after={len(after)} unchanged={len(before) - len(bad)} changed-or-gone={len(bad)} added={len(added)}")
if plant:
    ok = bad == [name]
    print("CONTROL: the planted change is reported, and only it" if ok else f"CONTROL FAILED: reported {bad}")
    sys.exit(0 if ok else 1)
print("PASS: no existing statement changed" if not bad else "FAIL")
sys.exit(1 if bad else 0)
