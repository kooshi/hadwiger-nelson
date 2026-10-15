#!/usr/bin/env python3
"""FS131-LCH1 — files whose edits are prose only: with every block comment (`/- … -/`, `/-- … -/`, `/-! … -/`, nested)
and every line comment removed, each file is the same at two revisions.
Usage: fs131_lch1_code_only.py <base-rev> <rev> <file>... [--plant]   (--plant adds one code character to the second
text of every file and requires each reported).  Exit 0 iff every file is the same (or, with --plant, every file differs)."""
import subprocess, sys

def strip(t):
    out, i, depth, n = [], 0, 0, len(t)
    while i < n:
        if t.startswith('/-', i):
            depth += 1; i += 2; continue
        if depth and t.startswith('-/', i):
            depth -= 1; i += 2; continue
        if depth: i += 1; continue
        if t.startswith('--', i):
            j = t.find('\n', i); i = n if j < 0 else j; continue
        out.append(t[i]); i += 1
    return '\n'.join(l.rstrip() for l in ''.join(out).split('\n') if l.strip())

def show(rev, f):
    return subprocess.run(['git', 'show', f'{rev}:{f}'], check=True, capture_output=True, text=True).stdout

args = [a for a in sys.argv[1:] if a != '--plant']; plant = '--plant' in sys.argv
base, rev, files = args[0], args[1], args[2:]
bad = 0
for f in files:
    a, b = strip(show(base, f)), strip(show(rev, f))
    if plant: b = b + '\nX'
    same = a == b
    print(f'{"SAME" if same else "DIFFERS"} {f}')
    bad += not same
print(f'{len(files) - bad}/{len(files)} the same with comments removed')
sys.exit((0 if bad == len(files) else 1) if plant else (0 if bad == 0 else 1))
