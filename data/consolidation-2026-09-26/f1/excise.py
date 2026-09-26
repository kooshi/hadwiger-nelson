#!/usr/bin/env python3
"""F1 helper: print an old block of CLAUDE.md (between two line markers in <ref>:CLAUDE.md), line-wraps joined, with every sentence
that today's CLAUDE.md already holds (>= 0.8 of its 5-word shingles) replaced by "[…]" — the incidental remainder, verbatim."""
import sys, re, subprocess
sys.argv, args = sys.argv[:1], sys.argv[1:]
exec(open('/home/kooshi/source/lean-dir/data/consolidation-2026-09-26/f1/lost.py').read().split('def main')[0])
ref, start, end = args[0], args[1], args[2]
old = show(ref).split('\n')
i = next(k for k, l in enumerate(old) if l.startswith(start))
j = next(k for k in range(i + 1, len(old)) if old[k].startswith(end))
block = '\n'.join(old[i:j])
cur = open('/home/kooshi/source/lean-dir/CLAUDE.md').read()
cursh = set().union(*[shingles(norm_words(p)) for _, p in blocks(cur)])
out = []
for lab, para in blocks(block):
    parts = re.split(r'(?<=[.!?])\s+(?=[A-Z*(“"])|(?<=\.\*\*)\s+|(?<=\.\*)\s+', para)
    res = []
    for q in parts:
        sh = shingles(norm_words(q))
        if sh and len(sh & cursh) / len(sh) >= 0.8:
            if not res or res[-1] != '[…]': res.append('[…]')
        else:
            res.append(q)
    out.append(' '.join(res))
print('\n\n'.join(out))
