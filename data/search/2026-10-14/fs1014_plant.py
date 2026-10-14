#!/usr/bin/env python3
"""fs1014_plant -- SEARCH-2026-10-14: write a planted copy of a certificate (the overclaim U_num - 1, or one R entry of a
padded coordinate moved by +1 on both triangles) and a faithful copy (re-serialised, nothing changed), so that the frozen
checker's refusal is seen to come from the plant and its acceptance of the twin from the file.
usage: fs1014_plant.py CERT OUT_PLANT OUT_TWIN {U|Rpad}"""
import json, sys
C = json.load(open(sys.argv[1]))
json.dump(C, open(sys.argv[3], 'w'), separators=(',', ':'))
if sys.argv[4] == 'U':
    C['U_num'] -= 1
elif sys.argv[4] == 'Rpad':
    b = next(b for b in C['blocks'] if b['times'] == '1' and len(b['R']) > 2)
    d = len(b['R']); i, j = d - 2, d - 1       # the last two reps: outside every basis tried here
    b['R'][i][j] += 1; b['R'][j][i] += 1
else:
    raise SystemExit('unknown plant')
json.dump(C, open(sys.argv[2], 'w'), separators=(',', ':'))
print('planted', sys.argv[4], 'into', sys.argv[2])
