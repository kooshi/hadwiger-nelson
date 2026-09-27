# FS106-V stage 3: float sanity check [measured, not exact] of the three-arc configuration of [SokolovVoronov2025] Lemma 3 (Fig. 5).
# Positive control: the printed triangle is consistent at d = 1.5 (the figure's range). Finding: consistent for d <= sqrt(3), bipartite (no odd cycle) above.
# Run: python3 data/fs106/fs106-v/sv_lemma3_triangle.py   (seconds; no solver)
# Track the partner branch continuously on the FULL circles (Euclidean), for the three pairings of S-V Lemma 3,
# with arcs of 60 degrees from p0: P1 on w(u1) (+60), P3 on w(u1) (-60), P2 on w(u2) (sigma*60).
# Pairing (i,j): x runs along Pi from its far end q_i back to p0; the partner starts at p0 (in P_j's circle) and must end at q_j.
import cmath, math
def rot(c, z, a): return c + (z - c) * cmath.exp(1j * a)
def inter(c1, c2):
    d = abs(c2 - c1)
    if d > 2: return []
    m = (c1 + c2) / 2; h = math.sqrt(max(0.0, 1 - d * d / 4)); e = (c2 - c1) / d * 1j
    return [m + h * e, m - h * e]
def track(ci, si, cj, p0, n=20000):
    y = p0; mind = 9; maxang = -9; minang = 9
    for k in range(n, -1, -1):
        x = rot(ci, p0, si * math.pi / 3 * k / n)
        pts = inter(x, cj)
        if not pts: return None, None, None
        y = min(pts, key=lambda z: abs(z - y))
        a = cmath.phase((y - cj) / (p0 - cj))
        maxang = max(maxang, a); minang = min(minang, a)
    return y, minang * 180 / math.pi, maxang * 180 / math.pi
import itertools
# Four 60-degree arcs from p0: A=(u1,+), B=(u1,-), C=(u2,-), D=(u2,+). Relation X~Y when the partner branch of X-reversed ends at Y's far end.
# Each relation forces sign(I_X) != sign(I_Y). An odd cycle of relations is the contradiction.
def odd_cycle(edges, nodes):
    col = {}
    for s in nodes:
        if s in col: continue
        col[s] = 0; st = [s]
        while st:
            a = st.pop()
            for (x, y) in edges:
                for (p, q) in ((x, y), (y, x)):
                    if p == a:
                        if q not in col: col[q] = 1 - col[a]; st.append(q)
                        elif col[q] == col[a]: return True
    return False
for d in (1.05, 1.3, 1.5, 1.7, 1.75, 1.8, 1.9, 1.99):
    u1, u2 = 0j, complex(d, 0); p0 = inter(u1, u2)[0]
    C = {'A': (u1, 1), 'B': (u1, -1), 'C': (u2, -1), 'D': (u2, 1)}
    E = []
    for i, j in itertools.permutations('ABCD', 2):
        ci, si = C[i]; cj, sj = C[j]
        y, lo, hi = track(ci, si, cj, p0)
        if y is not None and abs(y - rot(cj, p0, sj * math.pi / 3)) < 1e-6: E.append((i, j))
    print(f"d={d}: relations {E}  odd cycle: {odd_cycle(E, 'ABCD')}")
