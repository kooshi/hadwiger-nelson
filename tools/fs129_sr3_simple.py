#!/usr/bin/env python3
"""FS129-SR3-EMPTY-NS: FS116-V6's route to FS116-Y4-EMPTY reads no simplicity once V6-COUNT's last step is read on sectors.

Checks (exact, finite):
  1. count — V6-COUNT's combinatorial core: four double tiles on four distinct edges of the hexagon y_0..y_5 covering every hub, no
     component a single edge (V6-HUG: a tile is not the only tip at both its hubs). Survivors: exactly the three patterns made of two
     two-edge paths, whose centres are antipodal hubs; in each, the tippers of the two centres are disjoint and cover the four tiles.
  2. sectors — the last step without simplicity: every cyclic sequence of sectors at p, of length 4..8, over the four tiles
     {A1, A2, B1, B2} (A: tippers of y_k, B: tippers of y_{k+3}), each tile owning at least one sector (a tile of p owns a sector at p),
     has two cyclically consecutive sectors of different groups — which share the edge between them, against FS116-V6-ANTI.
Faults: --fault-hug (single-edge components allowed: more than three patterns survive);
        --fault-sector (a tile of p allowed to own no sector at p: sequences with no A-B adjacency appear).
Prints 'simple: count ok; sectors ok' on success, else the failing counts.
"""
import sys
from itertools import combinations, product

EDGES = [(i, (i + 1) % 6) for i in range(6)]


def components(edges):
    adj = {v: set() for v in range(6)}
    for a, b in edges:
        adj[a].add(b); adj[b].add(a)
    seen, comps = set(), []
    for v in range(6):
        if v in seen or not adj[v]:
            continue
        stack, comp = [v], set()
        while stack:
            u = stack.pop()
            if u in comp:
                continue
            comp.add(u); stack.extend(adj[u] - comp)
        seen |= comp
        comps.append(comp)
    return comps


def count_check(fault_hug):
    survivors = []
    for es in combinations(EDGES, 4):
        deg = [sum(v in e for e in es) for v in range(6)]
        if min(deg) == 0:
            continue
        comps = components(es)
        single = any(sum(1 for e in es if e[0] in c and e[1] in c) == 1 for c in comps)
        if single and not fault_hug:
            continue
        survivors.append(es)
    ok = len(survivors) == 3
    for es in survivors:
        deg = [sum(v in e for e in es) for v in range(6)]
        centres = [v for v in range(6) if deg[v] == 2]
        if len(centres) != 2 or (centres[1] - centres[0]) % 6 != 3:
            ok = False
            continue
        ta = {i for i, e in enumerate(es) if centres[0] in e}
        tb = {i for i, e in enumerate(es) if centres[1] in e}
        if ta & tb or len(ta | tb) != 4:
            ok = False
    return ok, len(survivors)


def sector_check(fault_sector):
    tiles = ['A1', 'A2', 'B1', 'B2']
    bad = 0
    for n in range(4, 9):
        for seq in product(tiles, repeat=n):
            if not fault_sector and set(seq) != set(tiles):
                continue
            if fault_sector and not set(seq) <= set(tiles):
                continue
            if not any(seq[i][0] != seq[(i + 1) % n][0] for i in range(n)):
                bad += 1
    return bad


def main():
    cok, ns = count_check('--fault-hug' in sys.argv)
    bad = sector_check('--fault-sector' in sys.argv)
    if cok and bad == 0:
        print('simple: count ok; sectors ok')
    else:
        print(f'simple: count patterns {ns} (ok={cok}); sequences with no A-B adjacency {bad}')


main()
