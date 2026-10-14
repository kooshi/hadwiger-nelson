#!/usr/bin/env python3
"""FS131-KPD1: compare two dumps of one module's stored constants (data/fs131/kpd1/dump/PiecesDump.lean's format).

Prints SAME or every constant whose stored type or value differs, or that is present in one dump only, and exits 1 on any
difference or on a dump with no constants (a dump that read nothing is a failure, never a pass).
Control: --plant changes one TYPE line of the second dump in memory; the comparison must then report it.
"""
import sys

def load(path):
    out, cur = {}, None
    for line in open(path, encoding='utf-8'):
        line = line.rstrip('\n')
        if line.startswith('@@ '):
            cur = line[3:]
            out[cur] = []
        elif cur is not None and (line.startswith('TYPE ') or line.startswith('VALUE ')):
            out[cur].append(line)
    return out

def main():
    args = [a for a in sys.argv[1:] if a != '--plant']
    a, b = load(args[0]), load(args[1])
    if '--plant' in sys.argv:
        k = sorted(b)[0]
        b[k] = [b[k][0] + ' PLANTED'] + b[k][1:]
    if not a or not b:
        print('FAIL: an empty dump'); sys.exit(1)
    diffs = [k for k in sorted(set(a) | set(b)) if a.get(k) != b.get(k)]
    for k in diffs:
        print('DIFF', k, 'only-before' if k not in b else 'only-after' if k not in a else 'changed')
    if diffs:
        sys.exit(1)
    print(f'SAME: {len(a)} constants, every stored type and value identical')

main()
