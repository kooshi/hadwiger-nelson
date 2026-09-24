"""V4 (spreading): c = Phi o red_q on M = T0 + eta^2 T0  ==>  c = Phi o red_q on Lambda.
Closure computation on Lambda/M (a finite group): a coset Y is forced once the residues red_q(u) of the unit vectors u
with Y - u already forced cover all three nonzero residues.  Exact; standard library only.
"""
import sys
from field import *
from lattice import *
z, eta = ZETA, ETA
U = [mul(power(z,a), power(eta,b)) for a in range(6) for b in range(-4,5)]
M = [ONE, z, power(eta,2), mul(power(eta,2), z)]
SUB = M
if len(sys.argv) > 1 and sys.argv[1] == 'plant':
    SUB = [ONE, z, mul(power(eta,2),E(2)), mul(power(eta,2), mul(z,E(2)))]   # planted: start from T0 + 2 eta^2 T0 only
H = hnf([list(lam_coords(g)) for g in SUB])
idx = det_of_hnf(H)
# reduce Lambda-coordinates modulo the HNF rows (upper triangular) to a canonical coset key
def key(v):
    v = list(v)
    for row in H:
        c = next(i for i, x in enumerate(row) if x)
        q = v[c] // row[c]
        v = [a - q*b for a, b in zip(v, row)]
    return tuple(v)
Uc = [(key(lam_coords(u)), u) for u in U]
def addk(k1, k2): return key([a+b for a, b in zip(k1, k2)])
def subk(k1, k2): return key([a-b for a, b in zip(k1, k2)])
# enumerate all cosets by BFS over unit steps (U generates Lambda)
zero = key((0,0,0,0))
allc = {zero}; frontier = [zero]
while frontier:
    nf = []
    for k in frontier:
        for ku, _ in Uc:
            k2 = addk(k, ku)
            if k2 not in allc: allc.add(k2); nf.append(k2)
    frontier = nf
print("index of the starting sublattice:", idx, "; cosets reached:", len(allc))
for q in ('p', "p'"):
    known = {zero}; rounds = 0
    while True:
        new = set()
        for Y in allc - known:
            R = {red(u, q) for ku, u in Uc if subk(Y, ku) in known}
            if len(R) == 3: new.add(Y)
        if not new: break
        known |= new; rounds += 1
    print(f"prime {q}: forced cosets {len(known)} of {len(allc)} after {rounds} rounds")
