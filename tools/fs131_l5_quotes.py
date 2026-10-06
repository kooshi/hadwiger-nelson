#!/usr/bin/env python3
"""FS131-L5: check every quotation of the brief against its source (standing rule 3).

Every `> ` line of the brief followed by a `> — source: <path>[ § ...]` line is searched as an exact substring of one line of
its source file.  A relative source path is read under --root (the tree the brief was written in: `main`'s checkout).

Usage: fs131_l5_quotes.py <brief> --root <tree>          the check
       fs131_l5_quotes.py <brief> --root <tree> --self-test   three plants, each of which must be refused, and the unplanted
                                                              run, which must pass
Exit 0 iff every quotation is found; 1 on a mismatch or a missing source; 2 if the brief holds no quotation.
"""
import os
import re
import sys


def check(lines, root, out):
    i = n = bad = 0
    while i < len(lines) - 1:
        if lines[i].startswith('> ') and lines[i + 1].startswith('> — source: '):
            q = lines[i][2:]
            path = re.match(r'> — source: (\S+)', lines[i + 1]).group(1)
            n += 1
            if not os.path.isabs(path):
                path = os.path.join(root, path)
            try:
                with open(path) as f:
                    t = f.read().split('\n')
            except OSError as e:
                out.append(f'MISSING   {path}: {e}')
                bad += 1
                i += 2
                continue
            hits = [k + 1 for k, line in enumerate(t) if q and q in line]
            if hits:
                out.append(f'verbatim  l. {hits[0]:5}  {path}  |  {q[:90]}')
            else:
                out.append(f'MISMATCH             {path}  |  {q[:90]}')
                bad += 1
            i += 2
        else:
            i += 1
    out.append(f'quotations={n} mismatches={bad}')
    return 2 if n == 0 else (1 if bad else 0)


def main():
    brief = sys.argv[1]
    root = sys.argv[sys.argv.index('--root') + 1]
    with open(brief) as f:
        lines = f.read().split('\n')
    if '--self-test' not in sys.argv:
        out = []
        rc = check(lines, root, out)
        print('\n'.join(out))
        return rc
    qidx = [i for i in range(len(lines) - 1) if lines[i].startswith('> ') and lines[i + 1].startswith('> — source: ')]
    ok = True
    # the unplanted run must pass
    out = []
    rc = check(lines, root, out)
    print(f'unplanted: exit {rc}  ({out[-1]})')
    ok &= rc == 0
    # plant 1: one character of the first quotation changed
    p = list(lines)
    p[qidx[0]] = p[qidx[0]][:12] + ('X' if p[qidx[0]][12] != 'X' else 'Y') + p[qidx[0]][13:]
    out = []
    rc = check(p, root, out)
    fired = rc == 1 and sum(1 for l in out if l.startswith('MISMATCH')) == 1
    print(f'plant 1 (a changed character in quotation 1): exit {rc}, {out[-1]} -> {"refused" if fired else "NOT REFUSED"}')
    ok &= fired
    # plant 2: the last quotation's source replaced by a file that does not hold it (this script)
    p = list(lines)
    p[qidx[-1] + 1] = '> — source: ' + os.path.abspath(__file__)
    out = []
    rc = check(p, root, out)
    fired = rc == 1 and sum(1 for l in out if l.startswith('MISMATCH')) == 1
    print(f'plant 2 (a wrong source for the last quotation): exit {rc}, {out[-1]} -> {"refused" if fired else "NOT REFUSED"}')
    ok &= fired
    # plant 3: an empty quotation must not match every line
    p = list(lines)
    p[qidx[1]] = '> '
    out = []
    rc = check(p, root, out)
    fired = rc == 1 and sum(1 for l in out if l.startswith('MISMATCH')) == 1
    print(f'plant 3 (an empty quotation): exit {rc}, {out[-1]} -> {"refused" if fired else "NOT REFUSED"}')
    ok &= fired
    # plant 4: a brief with no quotation must exit 2, never 0
    out = []
    rc = check(['no quotation here', ''], root, out)
    print(f'plant 4 (no quotation at all): exit {rc} -> {"refused" if rc == 2 else "NOT REFUSED"}')
    ok &= rc == 2
    print('SELF-TEST ' + ('OK: every plant refused' if ok else 'FAILED'))
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
