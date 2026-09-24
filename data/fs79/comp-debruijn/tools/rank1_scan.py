#!/usr/bin/env python3
"""Exhaustive rank-1 scan, k = 4: every D with max D = m (m in the given range), 3 <= |D| <= 5, gcd 1.  For each: states, cyclic SCCs,
rigid ones, walls.  A row with cyclic > 0, rigid == cyclic and walls > 0 is a counterexample to C3-inherit (P != F).  Checkpoint: one
JSON line per D in the output file; a relaunch skips the D's already there.  Resume: rerun the same command."""
import sys, json, itertools, math, os, time
from rank1_phases import analyse
lo, hi, out = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
done = set()
if os.path.exists(out):
    for line in open(out):
        done.add(tuple(json.loads(line)['D']))
f = open(out, 'a')
for m in range(lo, hi + 1):
    for r in (2, 3, 4):
        for rest in itertools.combinations(range(1, m), r):
            D = tuple(sorted(rest + (m,)))
            if math.gcd(*D) != 1 or D in done:
                continue
            t = time.time()
            a = analyse(list(D))
            row = dict(D=D, states=a['states'], cyclic=a['cyclic'], rigid=a['rigid'], walls=a['walls'],
                       counterexample=bool(a['cyclic'] > 0 and a['rigid'] == a['cyclic'] and a['walls'] > 0),
                       sec=round(time.time() - t, 2))
            f.write(json.dumps(row) + '\n'); f.flush()
print('scan complete', lo, hi)
