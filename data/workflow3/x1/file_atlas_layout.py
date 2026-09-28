#!/usr/bin/env python3
"""X1 stage 5, item 10 (layout): move the drafted atlas nodes to the positions atlas_layout_search.py found (lint overlaps 27 -> 0)."""
from common import read, write
from file_atlas import node_span

MOVES = {"CVEXISTS": ((20, 560), (14, 570)), "LOCALF": ((22, 525), (26, 465)), "BOWSQ3": ((34, 575), (34, 575)),
         "PINW": ((48, 575), (49, 555)), "ROUTET": ((62, 560), (61, 525)), "CAPSTRIP": ((119, 440), (123, 465)),
         "FS111": ((64, 262), (65, 262)), "MEET": ((38, 240), (41, 230)), "FS121": ((52, 250), (57, 270)),
         "FS120": ((70, 280), (65, 330)), "FS122": ((28, 250), (29, 275))}
P = "tools/viz_proof_atlas_facts.py"
s = read(P)
for nid, (o, n) in MOVES.items():
    a, b = node_span(s, nid); g = s[a:b]
    old = f"at=({o[0]}, {o[1]})"
    assert g.count(old) == 1, nid
    s = s[:a] + g.replace(old, f"at=({n[0]}, {n[1]})") + s[b:]
write(P, s)
print("moved", sum(o != n for o, n in MOVES.values()), "nodes")
