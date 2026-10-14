#!/usr/bin/env python3
"""FS131-KN9: the coordinator's ruling of 2026-10-14 read from the kernel's side — `haar_or_zero_entropy` lost exactly its
binder `[PolishSpace X]` and nothing else of the module's old constants moved.

usage: fs131_kn9_binder.py <before dump log> <after dump log> [--plant]

Both logs are prints of data/fs131/kn9/lean/ModuleDump.lean (KN8's dumper: kind, name, stored type with every argument
shown). Checks, each printed with its verdict:
  1. every constant of the before log other than haar_or_zero_entropy is in the after log with the same text (SAME);
  2. the before text of haar_or_zero_entropy holds BINDER exactly once, and removing it gives the after text exactly;
  3. the after log adds constants only (ADDED, listed) — none of the before log is removed.
--plant removes one character fewer than BINDER in check 2, which must then FAIL (the control: a comparison that cannot
tell the binder from a near miss would pass it). Exit 0 iff every check passes (or, under --plant, iff check 2 fails and
the others pass)."""
import re
import sys

BINDER = " [@PolishSpace.{u_1} X inst_1]"
NAME = "HadwigerNelson.Rigidity.haar_or_zero_entropy"


def read(path):
    out = {}
    for line in open(path):
        m = re.search(r"DUMP (axiom|theorem|def|opaque|inductive|ctor|rec|quot) (\S+) : (.*)$", line.rstrip("\n"))
        if m:
            out[m.group(2)] = (m.group(1), m.group(3))
    return out


def main():
    a, b = read(sys.argv[1]), read(sys.argv[2])
    plant = "--plant" in sys.argv
    if not a or NAME not in a or NAME not in b:
        print("FAIL: a log is empty or lacks", NAME)
        return 1
    ok1 = True
    for n in sorted(a):
        if n == NAME:
            continue
        same = n in b and a[n] == b[n]
        print(f"{'SAME   ' if same else 'MOVED  '} {a[n][0]} {n}")
        ok1 &= same
    before, after = a[NAME][1], b[NAME][1]
    sub = BINDER[:-1] if plant else BINDER
    count = before.count(sub)
    ok2 = count == 1 and before.replace(sub, "", 1) == after
    print(f"{'PASS' if ok2 else 'FAIL'} check 2: binder occurrences in before = {count}; before minus binder == after: "
          f"{before.replace(sub, '', 1) == after}")
    added = sorted(set(b) - set(a))
    removed = sorted(set(a) - set(b))
    for n in added:
        print(f"ADDED   {b[n][0]} {n}")
    ok3 = not removed
    print(f"{'PASS' if ok3 else 'FAIL'} check 3: removed = {removed}; added = {len(added)}")
    print(f"check 1: {'PASS' if ok1 else 'FAIL'}")
    if plant:
        return 0 if (ok1 and ok3 and not ok2) else 1
    return 0 if (ok1 and ok2 and ok3) else 1


if __name__ == "__main__":
    sys.exit(main())
