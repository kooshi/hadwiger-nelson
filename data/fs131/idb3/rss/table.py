#!/usr/bin/env python3
"""FS131-IDB3: each DensityBound module's compile time (from the build's full log, Lake's `Built … (Ns)` lines) and its
peak resident set (from data/fs131/idb3/rss/samples.txt, sampled every 2 s by sample.sh). Usage: table.py BUILD_LOG"""
import re, sys
from collections import defaultdict
log = open(sys.argv[1]).read()
times = {}
for m in re.finditer(r'Built (Proofs\.HadwigerNelson\.Plane\.DensityBound\.\S+) \((\d+(?:\.\d+)?)(m?s)\)', log):
    v = float(m.group(2)) * (60 if m.group(3) == 'ms' and False else 1)
    times[m.group(1)] = (m.group(2) + m.group(3))
peak = defaultdict(int)
for ln in open('data/fs131/idb3/rss/samples.txt'):
    p = ln.split()
    path = next((x for x in p if x.endswith('.lean') and '/fs131-w10g/Proofs/' in x), None)  # Lake's compiles only
    if path:
        mod = path.split('/Proofs/', 1)[1][:-5].replace('/', '.')
        peak['Proofs.' + mod] = max(peak['Proofs.' + mod], int(p[2]))
mods = sorted(set(times) | set(peak))
print('| module | compile time | peak RSS |')
print('|---|---|---|')
for m in mods:
    print(f"| `{m.replace('Proofs.HadwigerNelson.', '')}` | {times.get(m, '—')} | {peak[m] / 1048576:.2f} GB |" if m in peak else f"| `{m.replace('Proofs.HadwigerNelson.', '')}` | {times.get(m, '—')} | (under 2 s, not sampled) |")
