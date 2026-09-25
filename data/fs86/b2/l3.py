"""B2: the lattice analogue of FS38-L3.  M_Lambda = Z-span{t - 1 : t in U, t = 1 (mod P)}; its 2-adic elementary divisors, and the
least j with P^j (x) = Lambda cap P^j (up to odd index) inside M_Lambda (x) Z2.

Two code paths.  (a) Lambda coordinates (lattice.py's basis; 1 in Lambda, so t - 1 has integer coordinates): Smith normal form over Z,
2-parts of the invariant factors; Lambda cap P^(2k) = 2^k Lambda.  (b) O coordinates (embed.py's 2-adic images, mod 2^E): the Z-lattice
spanned by the images and 2^E Z^4 in Hermite normal form; membership of pi^j * (basis of O) tested exactly, for every j (odd included).
Run: python3 l3.py   (seconds; writes l3.out)
"""
import sys, numpy as np
from sympy import Matrix, factorint
from sympy.matrices.normalforms import smith_normal_form, hermite_normal_form
from sympy import ZZ
sys.path.insert(0, '../stageA')
from units_fast import units_fast
from tower import canon, mul, ONE

out = open('l3.out', 'w')
def say(*a):
    print(*a); print(*a, file=out, flush=True)

Z = np.load('U510_O.npy')                 # O-coordinates mod 2^23
C = np.load('lattice_coords.npy')         # Lambda-coordinates (same order as units_fast(510, 59))
U = units_fast(510, 59)
one = U.index((510, 0, 0, 0))
res1 = canon(Z, 1)
U1 = [j for j in range(len(U)) if np.array_equal(res1[j], canon(ONE, 1))]
say(f"|U| = {len(U)}; t = 1 (mod P): {len(U1)} unit vectors")

# (a) Lambda coordinates
A = Matrix([list(C[j] - C[one]) for j in U1 if j != one])
S = smith_normal_form(A, domain=ZZ)
inv = [abs(S[i, i]) for i in range(min(S.shape)) if S[i, i] != 0]
two = [2 ** factorint(x).get(2, 0) for x in inv]
say(f"(a) rank {len(inv)}; invariant factors {inv}; 2-adic elementary divisors {two}")
say(f"    so 2^k Lambda = Lambda cap P^(2k) lies in M_Lambda (x) Z2 exactly for k >= {max(two).bit_length() - 1} "
    f"(i.e. P^{2 * (max(two).bit_length() - 1)} contained); the full tower's FS38-L3 has 1, 2, 4, 4")

# (b) O coordinates, exact membership mod 2^E
E = 12
MODE = 1 << E
V = [list((Z[j] - ONE) % MODE) for j in U1]
L = Matrix(V + [[MODE if i == k else 0 for i in range(4)] for k in range(4)])
H = hermite_normal_form(L.T).T
H = Matrix([r for r in H.tolist() if any(r)]); assert H.shape == (4, 4)
Hinv = H.inv()
def member(v):
    c = Matrix([list(v)]) * Hinv
    return all(x.q == 1 for x in c)
say(f"(b) index of the span (with 2^{E} O) in O: 2^{int(abs(H.det())).bit_length() - 1 - 4 * 0} / 2^0  (det {abs(H.det())})")
basis = [np.eye(4, dtype=np.int64)[i] for i in range(4)]
for j in range(0, 9):
    pj = ONE
    for _ in range(j): pj = mul(pj, [1, 0, 1, 0])
    gens = [mul(pj, b) for b in basis]
    mem = [member(g) for g in gens]
    say(f"    P^{j} = pi^{j} O inside span: {all(mem)}   (per basis direction 1, w, sqrt3, w sqrt3: {mem})")
