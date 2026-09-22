#!/usr/bin/env python3
"""fs70_haugland -- FS-70 phase 0.3: the POSITIVE CONTROL.  Haugland's graph G_1 rebuilt exactly in Q(zeta_84)
from [Haugland2026] sections 2-3 and Appendix A, and asked the question the milestone will ask over Q(sqrt3,sqrt5):
are A = (0,0) and B = (0,sqrt3) forced to DIFFERENT colours in every four-colouring?  He reports 740 vertices,
3,985 edges and a CaDiCaL refusal of "A = B".  If our instrument cannot see his refusal, it cannot be trusted to
see ours.  UNTRUSTED (tools/).

THE FIELD.  zeta = zeta_84 = exp(2 pi i / 84); Q(zeta) has degree phi(84) = 24 over Q and we represent its
elements as rational polynomials in zeta reduced modulo the 84th cyclotomic polynomial.  Complex conjugation is
zeta -> zeta^{-1} = zeta^{83}.  The identities his section 2 needs:
    i = zeta^21,   sqrt3 = 2 cos(pi/6) = zeta^7 + zeta^{-7},
    cos(pi/7) = (zeta^6 + zeta^{-6})/2,   sin(2 pi / 7) = (zeta^12 - zeta^{-12}) / (2 zeta^21).

THE 84 UNIT VECTORS (his section 2, after Table 1).  u_{2j} = (cos(pi j/21), sin(pi j/21)) = zeta^{2j} and
u_{2j+1} = (cos(pi (j+theta)/21), sin(pi (j+theta)/21)) = epsilon * zeta^{2j} for 0 <= j < 42, where theta is fixed
by the direction of Q_0 P_0: multiplying that vector by 4 sin(2 pi/7) gives (-sqrt3, 4 cos(pi/7) - 1), whose angle
is phi = pi (14 + theta)/21.  So u_29 = u_{2*14+1} is the UNIT vector in that direction,
    u_29 = (-sqrt3 + i (4 cos(pi/7) - 1)) / (4 sin(2 pi/7)),
and epsilon = u_29 * zeta^{-28}.  `|u_29|^2 = 1` is verified exactly, which is the test of the whole derivation.

POINTS.  Every u is an integer 24-vector over one denominator D (epsilon's), so a point reached by a path of unit
vectors is an integer 24-vector over D: addition is tuple addition and a hash is a tuple.  No floats decide
anything; floats only propose candidate edges, and the exact product z * conj(z) = 1 decides.

Commands
  python3 tools/fs70_haugland.py check          # the field identities, epsilon, and Appendix A parsed and verified
  python3 tools/fs70_haugland.py build [--out DIR]   # T_5, T_6, G_0, G_1, the CNFs; then run a solver on them
  python3 tools/fs70_haugland.py selftest       # check + two planted faults that must fire
"""
from collections import defaultdict, deque
from fractions import Fraction as Fr
import hashlib
import json
import math
import os
import re
import subprocess
import sys
import time

PLANT = None

# the 84th cyclotomic polynomial, x^24 + x^22 - x^18 - x^16 + x^12 - x^8 - x^6 + x^2 + 1 (sympy, degree 24)
PHI84 = [1, 0, 1, 0, 0, 0, -1, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1, 0, -1, 0, 0, 0, 1, 0, 1]   # high degree first
N = 24
# reduction rule: zeta^24 = -(PHI84[1..24] . zeta^{23..0}) = -sum_{k<24} PHI84[24-k] zeta^k
RED = [-PHI84[N - k] for k in range(N)]        # zeta^24 == sum RED[k] zeta^k


def q_zero():
    return (0,) * N


def q_one():
    return (1,) + (0,) * (N - 1)


def q_add(a, b):
    return tuple(x + y for x, y in zip(a, b))


def q_sub(a, b):
    return tuple(x - y for x, y in zip(a, b))


def q_neg(a):
    return tuple(-x for x in a)


def q_scale(k, a):
    return tuple(k * x for x in a)


def q_reduce(c):
    """reduce a coefficient list of any length modulo PHI84 to EXACTLY length 24 (padded)"""
    c = list(c)
    if len(c) < N:
        c = c + [0] * (N - len(c))
    for d in range(len(c) - 1, N - 1, -1):
        v = c[d]
        if v:
            c[d] = 0
            for k in range(N):
                c[d - N + k] += v * RED[k]
    return tuple(c[:N])


def q_mul(a, b):
    prod = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        if x:
            for j, y in enumerate(b):
                if y:
                    prod[i + j] += x * y
    return q_reduce(prod)


def q_zeta(k):
    """zeta^k for any integer k (zeta^84 = 1)"""
    k %= 84
    c = [0] * (k + 1)
    c[k] = 1
    return q_reduce(c)


def q_conj(a):
    """complex conjugation: zeta -> zeta^{-1}"""
    out = q_zero()
    for k, x in enumerate(a):
        if x:
            out = q_add(out, q_scale(x, q_zeta(-k)))
    return out


def q_float(a):
    """the standard embedding zeta -> exp(2 pi i / 84); floats PROPOSE, never decide"""
    z = complex(math.cos(2 * math.pi / 84), math.sin(2 * math.pi / 84))
    return sum(float(x) * z ** k for k, x in enumerate(a))


def q_inv_rational(a):
    """1/a when a is rational (a multiple of 1): used only for epsilon's denominator"""
    raise NotImplementedError


# ---------------------------------------------------------------- epsilon and the 84 unit vectors

def build_vectors():
    """the 84 unit vectors as integer 24-tuples over one denominator D, plus D and the named quantities."""
    one = q_one()
    i_ = q_zeta(21)
    sqrt3 = q_add(q_zeta(7), q_zeta(-7))
    two_cos_pi7 = q_add(q_zeta(6), q_zeta(-6))                    # 2 cos(pi/7)
    # 4 sin(2 pi/7) = 4 (zeta^12 - zeta^-12) / (2 zeta^21) = 2 (zeta^12 - zeta^-12) zeta^{-21}
    four_sin = q_mul(q_scale(2, q_sub(q_zeta(12), q_zeta(-12))), q_zeta(-21))
    # numerator: -sqrt3 + i (4 cos(pi/7) - 1) = -sqrt3 + i (2*two_cos_pi7 - 1)
    num = q_add(q_neg(sqrt3), q_mul(i_, q_sub(q_scale(2, two_cos_pi7), one)))
    if PLANT == 'eps_sign':
        num = q_add(sqrt3, q_mul(i_, q_sub(q_scale(2, two_cos_pi7), one)))    # PLANT: +sqrt3
    if PLANT == 'eps_cos':
        num = q_add(q_neg(sqrt3), q_mul(i_, q_sub(q_scale(3, two_cos_pi7), one)))  # PLANT: 6 cos(pi/7) - 1
    # u_29 = num / four_sin.  Invert four_sin in Q(zeta) by solving the linear system (rationals).
    u29 = q_div(num, four_sin)
    eps = q_mul(u29, q_zeta(-28))
    # clear denominators of eps
    D = 1
    for x in eps:
        D = D * x.denominator // math.gcd(D, x.denominator)
    us = []
    for j in range(42):
        us.append(tuple(int(x * D) for x in q_mul(q_zeta(2 * j), one)))                      # u_{2j}
        us.append(None)
    for j in range(42):
        v = q_mul(eps, q_zeta(2 * j))
        us[2 * j + 1] = tuple(int(x * D) for x in v)
    for k, v in enumerate(us):
        assert v is not None and all(isinstance(x, int) for x in v), k
    return us, D, {'i': i_, 'sqrt3': sqrt3, 'u29': u29, 'eps': eps, 'four_sin': four_sin}


def q_div(a, b):
    """a / b in Q(zeta_84), by solving the 24 x 24 rational linear system (multiplication by b)"""
    cols = []
    for k in range(N):
        e = [0] * N
        e[k] = 1
        cols.append(list(q_mul(b, tuple(e))))
    # solve  M x = a  where M[r][k] = cols[k][r]
    M = [[Fr(cols[k][r]) for k in range(N)] + [Fr(a[r])] for r in range(N)]
    # Gaussian elimination
    row = 0
    where = [-1] * N
    for col in range(N):
        piv = next((r for r in range(row, N) if M[r][col] != 0), None)
        if piv is None:
            continue
        M[row], M[piv] = M[piv], M[row]
        pv = M[row][col]
        M[row] = [v / pv for v in M[row]]
        for r in range(N):
            if r != row and M[r][col] != 0:
                f = M[r][col]
                M[r] = [v - f * w for v, w in zip(M[r], M[row])]
        where[col] = row
        row += 1
    assert row == N, 'multiplication by b is singular'
    return tuple(M[where[c]][N] for c in range(N))


def is_unit(v8, D):
    """|z|^2 = 1 exactly, for an integer 24-tuple over D"""
    z = tuple(Fr(x, D) for x in v8)
    p = q_mul(z, q_conj(z))
    return p == tuple([Fr(1)] + [Fr(0)] * (N - 1))


# ---------------------------------------------------------------- Appendix A

APPENDIX_A = """
      2   23   28   69   33      0    21   83   33   28   52      14   17   7    54   53   26
      7   19   28   69   38      2    14   47   30   83   37      14   22   69   42   3    34
     10   31   68   37   14      2    33   14   12   58   39      14   59   82   28   40   17
     33   28   20   66   3       2    47   30   37   14   83      14   79   18   37   28   60
     37   28   25   74   3       3    20   37   33   60    7      16   69   47   14   37   13
     40   17   53   7    14      3    25   4    28   60   37      17   19   36   53   14   72
     42   23   14   65   14      3    34   14   31   47   80      18   69   28   33   71   20
     44    7   28   78   25      3    36   8    69   34   28      19   52   21   14   47   83
     46    7   14   44   13      3    37   13   69   39   22      20   14   47   19   51   82
     47   83   37   14   16      3    39   28   66   29    8      20   71   33   28   69   18
     48   28    0    6   28      4    14   49   28   46    7      21   14   38   51   14   74
     50   19   17   77   28      4    17   25   28   69   48      22   69   14   13   53   32
     50   28   17   77   19      4    25   51   14   53   17      23   60   32   33   83   7
     53   32   83   14   22      4    39   28   32   69    8      24    7   28   52   19   69
     53   40    7   14   17      6    14   37   68   42   19      25   23   76   48   83   28
     54   17   28   80   23      6    19   28    7   57   44      25   83   47   19   82   37
     62   83   28   25   23      6    28   57   44    7   19      26   14   39   72   33   82
     64    7   33   31   14      7    14   78   50   33   31      28    9   28   66    3   40
     66    3   20   33   28      7    17   44    5   54   28      28   16   83   0    47   37
     69   19   28   38   7       7    28   64    8   44   25      28   17   40   7    53   0
     69   33   28   2    23      7    31   69    3   34   33      28   18   71   69   33   20
     69   34   17   7    33      7    33   14   78   31   50      28   24   75   14   66   33
     69   38   19   7    28      8    14   53   25   58   21      28   25   12   77   64   33
     72   39   14   33   12      8    21   0    58   39   28      28   63   18   16   69   28
     77   10   17   39   37      8    28   73   39   37    6      28   73   63   12   28   25
     77   28   17   50   19      8    29   66   28   39    3      30   77   28   17   43   80
     77   46   28   10   23      10   17   23   77   51   39      31    0   33   28    7   64
     78    7   44   28   25      10   23   14   51   68   31      31   14   48   24   69   7
     80   28   17   54   23      10   28   37   68    0   31      32    1   54   83   28   23
     82   19   58   28   25      10   37   60    7   14   38      32   14   13   69   22   53
     83   23   28   62   25      13    0   39   37   28   76      33   12   83   32   77   39
     83   36   48   14   17      13   14   51   30   61   14      33   14   66   38   83   21
33   20    7   67   46   14   46   77   14   10   23   42   66   28   29   17   68   19
33   21   14   31   64   77   46   83   77   21   33   23   66   33   83   18   39   17
33   23   21   77   46   83   47    0   80   28   34   17   68   14   51   23   10   31
33   23   80   17   72   39   47   14   21   45   78   14   68   15   78   28   37   25
33   28   82   11   69   34   47   34   3    31   80   14   68   19   17   37   83   36
33   31   50   14   7    78   47   37   14   13   69   16   68   31    0   37   10   28
33   37   83   68   25   12   47   80   31   3    14   34   69    7   24   52   28   19
34   17   15   51   14   68   48   17   69   13   14   36   69    8   34    3   36   28
34   28   17   80   47   0    48   83   28   76   25   23   69   23   16   28   72   33
34   33    3    6   28   66   50   14   31   13   14   62   69   28   48   22   3    20
36   17   28    0   83   48   50   17   14   48   83   22   69   42    8   14   39   18
37    6   33   68    5   28   50   31   78   7    33   14   69   48   31   24   7    14
37   13   14   60   3    36   51    0   17   28   39    4   72   19   44   17   39   7
37   14   74   3    42   25   51   14   39   12   77   24   72   28   33   16   69   23
37   17   54   9    80   28   51   17   0    39    4   28   72   39   19   76   28   23
37   24   39   80   77   17   51   20   0    33   82   28   74   14   21   54   37   17
37   25   68   15   78   28   51   39   77   23   10   17   74   37   14   25   42   3
37   28   60   4     3   25   51   82   19   47   14   20   74   51   18   17   39   14
37   83   14   30   47   2    52   33   28   83   0    21   76   23   39   19   72   28
38    7   14   60   37   10   53    0   32   83   28   22   76   37   28   0    39   13
38   21   66   14   83   33   53    7   26   14   17   54   77    3   42   39   14   26
39    7   78    6   37   33   53   14   72   36   17   19   77   17   80   39   37   24
39   12   28   54   81   14   53   17   14   51   25   4    77   19   64   28   36   17
39   13   14   51   76   23   53   17   19   25   58   7    77   24   51   14   39   12
39   14   18   74   17   51   53   22   69   32   13   14   77   28   24   69   37   16
39   17   14   18   74   51   53   26   25   28   77   3    77   32   42   14   83   30
39   18   14    8   69   42   54   14   17   26   53   7    77   39   12   40   3    28
39   22   69   13   3    37   54   14   81   12   39   28   78   25   28   37   15   68
39   37   14   6    62   13   54   23   28   83   1    32   80   14   31   3    34   47
40    3   53   14   31    7   54   28   1    32   83   23   80   17   39   63   28   18
40    7    3   31   53   14   58    7   25   78   28   30   80   23   46   13   47   14
40   28    3   82   45   14   58   14   25   53   8    21   80   43   17   28   77   30
42    3   34   14   69   22   58   14   41   28   83   16   82   14   19   47   51   20
42   19   82   14   58   25   58   21   25   53   14   8    82   28   25   44   72   19
42   23   25   14   62   83   58   25   42   14   82   19   82   33   72   14   39   26
42   25    3   14   74   37   58   28   39   5     3   22   82   37   19   47   83   25
42   77   46   23   10   14   58   39   12   14   2    33   83    7   33   32   23   60
44   13   21   14   77   46   60    7   44   13   32   14   83   16   28   44   77   32
44   14   21   77   13   46   60   28   23   32   10   77   83   21   14   47   52   19
44   25   83    7   48   17   62   13    6   39   37   14   83   22   48   14   50   17
44   28    5   54    7   17   62   13   39   37    6   14   83   28   22   41   64   14
44   57    7   28   19    6   62   14   83   20   41   28   83   30   14   32   77   42
46   13   77   21   14   44   64   77   31   14   21   33   83   33   14   66   38   21
46   28    7   44    0   13   66   14   49   28    7   24   83   39   18   66   33   17
"""


def parse_appendix(us, D, B):
    """Split each line's integers into consecutive PATHS, each of which must sum EXACTLY to B.  The partition is
    found by dynamic programming over prefixes, so the column layout is never assumed: a line parses only if it
    really is a concatenation of valid paths, which makes this an independent check of the epsilon derivation."""
    paths = []
    bad = []
    for line in APPENDIX_A.strip().split('\n'):
        nums = [int(t) for t in re.findall(r'-?\d+', line)]
        if not nums:
            continue
        n = len(nums)
        # prefix sums of the vectors
        pre = [tuple([0] * N)]
        for t in nums:
            assert 0 <= t < 84, t
            pre.append(tuple(a + b for a, b in zip(pre[-1], us[t])))
        # dp[j] = True if nums[:j] splits into valid paths
        dp = [False] * (n + 1)
        dp[0] = True
        back = [None] * (n + 1)
        for j in range(1, n + 1):
            for k in range(max(0, j - 8), j):
                if dp[k] and tuple(a - b for a, b in zip(pre[j], pre[k])) == B:
                    dp[j] = True
                    back[j] = k
                    break
        if not dp[n]:
            bad.append(line.strip())
            continue
        j = n
        cuts = [n]
        while j:
            j = back[j]
            cuts.append(j)
        cuts.reverse()
        for a, b in zip(cuts, cuts[1:]):
            paths.append(nums[a:b])
    return paths, bad


# ---------------------------------------------------------------- the graph

def word_dist(us, radius):
    """BFS from 0 over the 84 unit vectors: {point -> graph distance}, to `radius`"""
    zero = tuple([0] * N)
    dist = {zero: 0}
    frontier = [zero]
    for d in range(1, radius + 1):
        nxt = []
        for p in frontier:
            for s in us:
                q = tuple(a + b for a, b in zip(p, s))
                if q not in dist:
                    dist[q] = d
                    nxt.append(q)
        frontier = nxt
    return dist


def dist_upto(x, W, shells, cap):
    """min(d(0,x), cap+1) using the ball W (a dict point -> distance, radius r) and its shells.  For d > r the
    test is d(0,x) <= r + m  <=>  some q with d(0,q) <= m has x - q in W."""
    d = W.get(x)
    if d is not None:
        return d
    r = max(W.values())
    assert cap <= 2 * r, f'the ball of radius {r} cannot decide distance {cap}'
    for m in range(1, cap - r + 1):
        for q in shells[m]:
            if tuple(a - b for a, b in zip(x, q)) in W:
                return r + m
    return cap + 1


def build_lens(us, B, n):
    """T_n: every point p with d(0,p) + d(p,B) <= n.  Since the minimum of the two is at most n//2, every such p
    lies in the ball of radius n//2 about 0 or about B, and the generator set is symmetric so the ball about B is
    B + (ball about 0)."""
    # the ball radius must both (a) cover min(dA, dB) <= n//2 so the candidate set is complete, and (b) satisfy
    # 2r >= n so `dist_upto` can decide every distance up to n.  r = ceil(n/2) does both.
    half = (n + 1) // 2
    W = word_dist(us, half)
    shells = defaultdict(list)
    for p, d in W.items():
        shells[d].append(p)
    cands = set(W)
    for p in W:
        cands.add(tuple(a + b for a, b in zip(B, p)))
    out = {}
    for p in cands:
        dA = dist_upto(p, W, shells, n)
        if dA > n:
            continue
        dB = dist_upto(tuple(a - b for a, b in zip(B, p)), W, shells, n - dA)
        if dA + dB <= n:
            out[p] = (dA, dB)
    return out, W


def unit_edges(points, D, keys=None):
    """the COMPLETE unit-distance graph on a point set: a float grid of cell 1 proposes, the exact identity
    z * conj(z) = 1 decides."""
    keys = list(points) if keys is None else keys
    index = {k: i for i, k in enumerate(keys)}
    fl = [q_float(tuple(Fr(x, D) for x in k)) for k in keys]
    grid = defaultdict(list)
    for i, z in enumerate(fl):
        grid[(math.floor(z.real), math.floor(z.imag))].append(i)
    edges = set()
    for (gx, gy), idxs in grid.items():
        near = []
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                near.extend(grid.get((gx + dx, gy + dy), ()))
        for i in idxs:
            zi = fl[i]
            for j in near:
                if j <= i:
                    continue
                if abs(abs(fl[j] - zi) - 1.0) > 1e-7:
                    continue
                dv = tuple(a - b for a, b in zip(keys[j], keys[i]))
                if is_unit(dv, D):
                    edges.add((i, j))
    return keys, sorted(edges)


def m_core(n, edges, m):
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    alive = set(range(n))
    changed = True
    while changed:
        changed = False
        for v in list(alive):
            if len(adj[v] & alive) < m:
                alive.discard(v)
                changed = True
    keep = sorted(alive)
    pos = {v: i for i, v in enumerate(keep)}
    return keep, [(pos[a], pos[b]) for a, b in edges if a in alive and b in alive]


# ---------------------------------------------------------------- CNF

def cnf_four_colour(nv, edges, pins, precedence=True):
    def var(v, c):
        return 4 * v + c + 1
    cl = []
    for v in range(nv):
        cl.append([var(v, c) for c in range(4)])
        for c1 in range(4):
            for c2 in range(c1 + 1, 4):
                cl.append([-var(v, c1), -var(v, c2)])
    for a, b in edges:
        for c in range(4):
            cl.append([-var(a, c), -var(b, c)])
    for v, c in pins:
        cl.append([var(v, c)])
    if precedence:
        pinned = {c for _, c in pins}
        free = [c for c in range(4) if c not in pinned]
        for j in range(1, len(free)):
            c, cp = free[j], free[j - 1]
            for v in range(nv):
                cl.append([-var(v, c)] + [var(u, cp) for u in range(v)])
    return cl


def write_cnf(path, nv, cl):
    with open(path, 'w') as f:
        f.write(f'p cnf {nv} {len(cl)}\n')
        for c in cl:
            f.write(' '.join(map(str, c)) + ' 0\n')
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()


# ---------------------------------------------------------------- commands

def cmd_check(verbose=True):
    t0 = time.time()
    us, D, named = build_vectors()
    one = tuple([Fr(1)] + [Fr(0)] * (N - 1))
    # --- the field identities
    assert q_mul(named['i'], named['i']) == tuple([Fr(-1)] + [Fr(0)] * (N - 1)) or \
        q_mul(q_zeta(21), q_zeta(21)) == q_zeta(42), 'i^2 = -1'
    assert q_mul(q_zeta(21), q_zeta(21)) == q_reduce([0] * 42 + [1]), 'zeta^21 squared is zeta^42'
    s3 = named['sqrt3']
    assert q_mul(s3, s3) == tuple([3] + [0] * (N - 1)), f'sqrt3^2 = {q_mul(s3, s3)[:4]}'
    # --- |u_29|^2 = 1, the test of the whole derivation
    u29 = named['u29']
    n29 = q_mul(u29, q_conj(u29))
    assert n29 == one, f'|u_29|^2 = {n29[:4]} -- the epsilon derivation is wrong'
    # --- every one of the 84 vectors is a unit vector
    for k, v in enumerate(us):
        assert is_unit(v, D), f'u_{k} is not a unit vector'
    # --- u_29 = eps * zeta^28, and the two families are the 42nd roots of unity and their detune
    assert us[29] == tuple(int(x * D) for x in u29)
    # --- B = (0, sqrt3) = i sqrt3
    B = tuple(int(x * D) for x in q_mul(q_zeta(21), s3))
    # --- Appendix A: every line must split into paths whose vector sums are EXACTLY B
    paths, bad = parse_appendix(us, D, B)
    assert not bad, f'{len(bad)} Appendix A lines do not split into valid paths; first: {bad[0][:80]}'
    lens_hist = defaultdict(int)
    verts = {tuple([0] * N)}
    for p in paths:
        lens_hist[len(p)] += 1
        cur = tuple([0] * N)
        for t in p:
            cur = tuple(a + b for a, b in zip(cur, us[t]))
            verts.add(cur)
    if verbose:
        print(f'field: Q(zeta_84), degree {N}; epsilon denominator D = {D}')
        print(f'|u_29|^2 = 1 exactly; all 84 vectors are unit vectors')
        print(f'Appendix A: {len(paths)} paths parsed, lengths {dict(sorted(lens_hist.items()))}, '
              f'every vector sum exactly B = (0, sqrt3); they visit {len(verts)} distinct points '
              f'({time.time()-t0:.1f}s)')
    return us, D, B, paths, verts


def cmd_build(out=None, solver='kissat', budget=600):
    us, D, B, paths, appendix_verts = cmd_check()
    rec = {'field': 'Q(zeta_84)', 'D': D, 'appendix_paths': len(paths), 'appendix_vertices': len(appendix_verts)}
    for n in (5, 6):
        t0 = time.time()
        T, W = build_lens(us, B, n)
        rec[f'T{n}'] = len(T)
        print(f'|V(T_{n})| = {len(T)}   (Haugland: {"1042" if n == 5 else "12856"})   '
              f'ball radius {n//2} = {len(W)} points, {time.time()-t0:.1f}s', flush=True)
        if n == 5:
            T5 = set(T)
        else:
            T6 = T
    # G_0: v in T6 with v in T5, or v adjacent to at least 7 vertices of T5
    t0 = time.time()
    keys6 = list(T6)
    keys6, edges6 = unit_edges(T6, D, keys6)
    print(f'T_6 complete unit-distance graph: {len(keys6)} points, {len(edges6)} edges ({time.time()-t0:.1f}s)',
          flush=True)
    idx6 = {k: i for i, k in enumerate(keys6)}
    inT5 = [k in T5 for k in keys6]
    nbrT5 = [0] * len(keys6)
    for a, b in edges6:
        if inT5[b]:
            nbrT5[a] += 1
        if inT5[a]:
            nbrT5[b] += 1
    g0 = [i for i in range(len(keys6)) if inT5[i] or nbrT5[i] >= 7]
    pos = {v: i for i, v in enumerate(g0)}
    e0 = [(pos[a], pos[b]) for a, b in edges6 if a in pos and b in pos]
    print(f'G_0: {len(g0)} points, {len(e0)} edges')
    keep, e1 = m_core(len(g0), e0, 7)
    keys1 = [keys6[g0[i]] for i in keep]
    rec['G0'] = [len(g0), len(e0)]
    rec['G1'] = [len(keys1), len(e1)]
    print(f'G_1 (the 7-core of G_0): {len(keys1)} points, {len(e1)} edges   '
          f'(Haugland: 740 vertices, 3985 edges)   '
          f'{"MATCH" if (len(keys1), len(e1)) == (740, 3985) else "*** MISMATCH ***"}')
    # the Appendix A vertex set must be exactly V(G_1)
    same = set(keys1) == appendix_verts
    print(f'V(G_1) equals Appendix A\'s vertex set: {same}'
          + ('' if same else f'  (|G_1 \\ A| = {len(set(keys1) - appendix_verts)}, '
                             f'|A \\ G_1| = {len(appendix_verts - set(keys1))})'))
    rec['appendix_matches_G1'] = same
    # the ask: A = B pinned at four colours
    zero = tuple([0] * N)
    ia, ib = keys1.index(zero), keys1.index(B)
    assert (ia, ib) != (-1, -1)
    out = out or 'build/fs70/haugland'
    os.makedirs(out, exist_ok=True)
    with open(os.path.join(out, 'G1.json'), 'w') as f:
        json.dump({'meta': rec, 'D': D, 'A': ia, 'B': ib,
                   'points': [list(k) for k in keys1], 'edges': [list(e) for e in e1]}, f)
    # The symmetry break (CLAUDE.md's checklist).  Pinning A = B = 0 is free by colour permutation; the three
    # remaining colours are then still freely permutable, so we may additionally pin a unit TRIANGLE at A --
    # a neighbour v1 of A takes colour 1 and a common neighbour v2 of A and v1 takes colour 2 -- which is a far
    # stronger break than precedence over three colours (|Aut of the colour set| falls from 3! to 1).
    adj = defaultdict(set)
    for a, b in e1:
        adj[a].add(b)
        adj[b].add(a)
    tri = None
    for v1 in sorted(adj[ia]):
        common = adj[ia] & adj[v1]
        if common:
            tri = (v1, min(common))
            break
    pins_eq = [(ia, 0), (ib, 0)] + ([(tri[0], 1), (tri[1], 2)] if tri else [])
    cls_eq = cnf_four_colour(len(keys1), e1, pins_eq)
    sha_eq = write_cnf(os.path.join(out, 'eq_AB.cnf'), 4 * len(keys1), cls_eq)
    cls_ctl = cnf_four_colour(len(keys1), e1, [(ia, 0), (ib, 1)])
    sha_ctl = write_cnf(os.path.join(out, 'neq_AB.cnf'), 4 * len(keys1), cls_ctl)
    rec['pins_eq'] = pins_eq
    print(f'  eq pins (A = B = 0 plus the unit triangle {tri} at A): {pins_eq}')
    rec['cnf_eq_sha256'] = sha_eq
    rec['cnf_neq_sha256'] = sha_ctl
    print(f'wrote {out}/G1.json, eq_AB.cnf (A = B pinned; {len(cls_eq)} clauses, sha {sha_eq[:16]}), '
          f'neq_AB.cnf (the control; sha {sha_ctl[:16]})')
    for tag, path in (('eq (A = B: must be UNSAT)', 'eq_AB.cnf'), ('neq (the control: must be SAT)', 'neq_AB.cnf')):
        t0 = time.time()
        r = subprocess.run([solver, '-q', os.path.join(out, path)], capture_output=True, text=True,
                           timeout=budget)
        verdict = ('UNSAT' if r.returncode == 20 else 'SAT' if r.returncode == 10 else f'UNKNOWN({r.returncode})')
        print(f'  {solver} {tag}: {verdict}, {time.time()-t0:.2f}s')
        rec[path] = {'verdict': verdict, 'seconds': round(time.time() - t0, 2)}
    with open(os.path.join(out, 'record.json'), 'w') as f:
        json.dump(rec, f, indent=1)
    print('record:', json.dumps(rec))
    return rec


PLANTS = ('eps_sign', 'eps_cos')


def cmd_selftest():
    global PLANT
    print('--- faithful twin')
    cmd_check()
    ok = True
    for name in PLANTS:
        print(f'--- plant {name}: the check must fail')
        r = subprocess.run([sys.executable, __file__, 'check', '--plant', name], capture_output=True, text=True)
        if r.returncode == 0:
            print(f'    NOT REFUSED -- plant {name} left the check green')
            ok = False
        else:
            print(f'    refused (exit {r.returncode}): {(r.stderr.strip().split(chr(10)) or [""])[-1][:150]}')
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print('both plants fired; faithful twin green')


if __name__ == '__main__':
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = argv[argv.index('--plant') + 1]
    out = argv[argv.index('--out') + 1] if '--out' in argv else None
    if not argv or argv[0] == 'check':
        cmd_check()
    elif argv[0] == 'build':
        cmd_build(out)
    elif argv[0] == 'selftest':
        cmd_selftest()
    else:
        print(__doc__)
