#!/usr/bin/env python3
"""FS129-SR2: the edges inside the lane-R dependency cycles of the Lean order, sorted by reading, and what the Lean order loses.

Each edge (from, to) means, in data/fs129/index/edges.csv, "to uses from". Classes as in tools/fs129_sr1_edges.py:
  real / route / false / reversed. SR1_SORTED copies FS129-SR1's 26 sorted edges (plans/FS129-SR1-audit.md § 4.1) so that both sorts
  are applied together; SR2_SORTED is this pass's (plans/FS129-SR2-audit.md § 2.3).
Checks every classified edge is in edges.csv; drops false and reversed edges; reports the lane-R cycles left; then recomputes the Lean
order's closure (seeds: handoff matching /de ?bruijn/i, as tools/fs129_index.py) with false and reversed edges dropped, and again with route
edges dropped too, and prints the rows of data/fs129/index/lean-order.md that leave it.
Fault: --fault keeps the FS111-M3-FIXCONV -> FS111-M2-FIX edge — the cycle count and the summary line change.
"""
import csv, json, re, sys
from collections import defaultdict

EDGES = 'data/fs129/index/edges.csv'
SR1_SORTED = [
    ('FS111-C-HULL-SO', 'FS111-C-HULL', 'false'), ('FS111-M2-DISCK7-AS-PLACED', 'FS111-M2-DISCK7', 'false'),
    ('FS112-Y3-R1', 'FS112-N3-CHAINS', 'false'), ('FS114-K1', 'FS114-N7-HUB', 'false'), ('FS114-ROUTE-T', 'FS114-N2-LEMMAS', 'reversed'),
    ('FS116-O1-YESLIM', 'FS116-C114-LOCAL-F', 'real'), ('FS116-RING-Q', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-RING-TRANSFER-QC', 'FS116-C114-LOCAL-F', 'real'), ('FS116-S1-QF', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-S1-QF', 'FS116-SAT-STRIP', 'real'), ('FS116-SEMI-PAR3', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-V4-MEET', 'FS116-S1-KAPPA', 'route'), ('FS116-V4-OUTER', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V4-PARTNER', 'FS116-S1-KAPPA', 'route'), ('FS116-V4-TWIST', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V5-DICHO', 'FS116-N3-SEMI', 'route'), ('FS116-V5-LENS', 'FS116-Y3-SIX', 'route'),
    ('FS121-C1-GMAP', 'FS121-D3-GRUNDY', 'false'), ('FS121-D1-PENCILWIN', 'FS121-O1-OUT', 'false'),
    ('FS121-D2-PERFIN', 'FS121-D2-SYM', 'reversed'), ('FS121-D4-HOLE', 'FS111-M-PINCH', 'false'),
    ('FS121-DB1-L6', 'FS111-M2-INTRAD', 'false'), ('FS121-DB1-L7', 'FS121-O1-OUT', 'false'),
    ('FS121-V2-EROSION-DIAM', 'FS121-D1-EROSION', 'false'), ('FS121-V2-VT-W', 'FS121-D1-VT', 'false'),
    ('FS121-V3-CPI', 'FS121-V2-SECTOR', 'false'),
]
SR2_SORTED = [
    ('FS111-C1-PW', 'FS111-C1-UNIF', 'false'), ('FS111-C1-UNIF', 'FS111-C1-PW', 'false'),
    ('FS106-EQ', 'FS106-SUP', 'false'),
    ('FS121-D1-R2CORNER', 'FS121-D1-R2SMOOTH', 'reversed'), ('FS121-D1-R2CORNER', 'FS121-D1-RUNG2', 'reversed'),
    ('FS121-DB1-L4', 'FS121-DB1-L1', 'reversed'), ('FS121-V5-RAY', 'FS121-V5-LOC', 'reversed'),
    ('FS111-M3-FIXCONV', 'FS111-M2-FIX', 'false'),
    ('FS114-CV-EXISTS', 'FS112-L60', 'false'), ('FS114-CV-EXISTS', 'FS112-N3-DENSE3', 'reversed'),
    ('FS114-CV-EXISTS', 'FS114-L60-WALK', 'reversed'),
    ('FS114-N6-NOQ', 'FS114-Y5-PINALL', 'false'), ('FS114-Y5-PINALL', 'FS114-N6-NOQ', 'false'),
    ('FS114-N5-GRING', 'FS114-Y4-RSTOPALL', 'route'), ('FS114-Y3-RSTOP', 'FS114-N4-D', 'false'),
    ('FS114-Y3-RSTOP', 'FS114-Y4-RSTOPALL', 'real'), ('FS114-Y4-RSTOPALL', 'FS114-N4-D', 'false'),
    ('FS114-Y4-RSTOPALL', 'FS114-Y3-RSTOP', 'false'),
    ('FS111-M2-DISC7', 'FS111-M2-HULLC', 'false'), ('FS111-M-COVER-SC', 'FS111-M2-HULLC', 'false'),
    ('FS112-BUDGET2', 'FS112-NB4P', 'false'),
    ('FS112-C-ENDS', 'FS114-CV-EXISTS', 'route'), ('FS114-CV-HD', 'FS114-CV-EXISTS', 'route'),
]
LANE_R = ('FS106', 'FS107', 'FS108', 'FS110', 'FS111', 'FS112', 'FS114', 'FS116', 'FS121', 'FS129')


def sccs(nodes, succ):
    sys.setrecursionlimit(100000)
    index, low, on, st, out, c = {}, {}, set(), [], [], [0]

    def go(v):
        index[v] = low[v] = c[0]; c[0] += 1; st.append(v); on.add(v)
        for w in succ[v]:
            if w not in index:
                go(w); low[v] = min(low[v], low[w])
            elif w in on:
                low[v] = min(low[v], index[w])
        if low[v] == index[v]:
            comp = []
            while True:
                w = st.pop(); on.discard(w); comp.append(w)
                if w == v: break
            out.append(comp)
    for v in nodes:
        if v not in index: go(v)
    return [x for x in out if len(x) > 1]


def closure(seeds, edges):
    pred = defaultdict(set)
    for a, b in edges: pred[b].add(a)
    seen, todo = set(seeds), list(seeds)
    while todo:
        v = todo.pop()
        for u in pred[v]:
            if u not in seen: seen.add(u); todo.append(u)
    return seen


def main():
    fault = '--fault' in sys.argv
    rows = [r for r in csv.reader(l for l in open(EDGES) if not l.startswith('#'))][1:]
    present = {(a, b) for a, b, _ in rows}
    sorted_all = SR1_SORTED + SR2_SORTED
    missing = [(a, b) for a, b, _ in sorted_all if (a, b) not in present]
    assert not missing, f'not in edges.csv: {missing}'
    drop = {(a, b) for a, b, k in sorted_all if k in ('false', 'reversed')}
    if fault: drop.discard(('FS111-M3-FIXCONV', 'FS111-M2-FIX'))
    route = {(a, b) for a, b, k in sorted_all if k == 'route'}
    nodes = sorted({x for a, b in present for x in (a, b)})
    def lane_r_cycles(es):
        succ = defaultdict(list)
        for a, b in es: succ[a].append(b)
        return [c for c in sccs(nodes, succ) if any(x.startswith(LANE_R) for x in c)]
    before, after = lane_r_cycles(present - {(a, b) for a, b, k in SR1_SORTED if k in ('false', 'reversed')}), lane_r_cycles(present - drop)
    th = {}
    with open('data/fs129/index/theorems.jsonl') as f:
        f.readline()
        for l in f:
            d = json.loads(l); th[d['id']] = d
    seeds = {i for i, d in th.items() if re.search(r'de ?bruijn', d.get('handoff') or '', re.I)}
    order = {}
    for l in open('data/fs129/index/lean-order.md'):
        m = re.match(r'\| (\d+) \| (\S+) \|', l)
        if m: order[m.group(2)] = int(m.group(1))
    c1 = closure(seeds, present - drop)
    c2 = closure(seeds, present - drop - route)
    gone1 = sorted((order[i], i) for i in order if i not in c1)
    gone2 = sorted((order[i], i) for i in order if i not in c2 and i in c1)
    n = len(SR2_SORTED); kinds = {k: sum(1 for *_, kk in SR2_SORTED if kk == k) for k in ('real', 'route', 'false', 'reversed')}
    print(f"SR2 edges sorted: {n} (real {kinds['real']}, route {kinds['route']}, false {kinds['false']}, reversed {kinds['reversed']}); "
          f"lane-R cycles {len(before)} -> {len(after)}; Lean order {len(order)} -> {len(c1 & set(order))} (false, reversed dropped) -> "
          f"{len(c2 & set(order))} (route dropped too)")
    if '-v' in sys.argv:
        for c in after: print('  cycle left:', ' '.join(sorted(c)))
        for r, i in gone1: print(f'  leaves (false/reversed): row {r} {i}')
        for r, i in gone2: print(f'  leaves (first routes only): row {r} {i}')


main()
