"""FS131-IDB2 prototype (untrusted, lane X planning): the identification X23.phi w0 t = w1N/WS + jsum Ws d t / WS that
X23_phi needs from BesselCert.Cells.phiApprox_ge (item 866's question). For each g23 w_2 pair, its exact squared distance;
the pairs grouped by distance; each group's weight sum times 10^20 against P23.Ws (Cells/Data.lean), and each distance
against P23.Ds / 2^64. Run from the worktree root."""
import re, sys
from fractions import Fraction as Fr
from pathlib import Path
import mpmath
sys.path.insert(0, 'tools')
import j26_ambrus_check as J
mpmath.mp.dps = 50
pts = J.read_points(Path('data/pa-ambrus2023/verification23.nb'))
w0, wT, w1, w2, wc = J.read_coeffs(Path('data/pa-ambrus2023/g23.csv'))
src = Path('Proofs/HadwigerNelson/Plane/DensityBound/Cells/Data.lean').read_text()
lists = re.findall(r'\[([-0-9, ]+)\]', src[src.index('def P23'):])
Ws = [int(x) for x in lists[0].split(',')]; Ds = [int(x) for x in lists[1].split(',')]
w1N = int(re.search(r'⟨(\d+), (\d+)', src[src.index('def P23'):]).group(2))
WS = 10**20
groups = {}
for v, i, j in w2:
    d2 = J.sqdist(pts[i - 1], pts[j - 1])
    groups.setdefault(d2, []).append((v, i, j))
print("w2 pairs", len(w2), "distinct distances", len(groups))
print("w0 scaled matches Ws[0]:", w0 * WS == Ws[0], " w1 scaled matches w1N:", w1 * WS == w1N, " Ds[0] = 2^64:", Ds[0] == 2**64)
matched = [False] * len(Ws); matched[0] = True
allok = True
for d2, es in groups.items():
    d = mpmath.sqrt(J.ffloat(d2))
    ks = [k for k in range(1, len(Ds)) if abs(d - mpmath.mpf(Ds[k]) / 2**64) <= mpmath.mpf(1) / 2**64]
    wsum = sum(v for v, _, _ in es) * WS
    ok = len(ks) == 1 and wsum == Ws[ks[0]]
    if ks: matched[ks[0]] = True
    allok &= ok
    if not ok: print("MISMATCH", d2, ks, wsum, [Ws[k] for k in ks])
print("every group matched exactly:", allok, " every Ws entry used:", all(matched))
