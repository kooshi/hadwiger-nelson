#!/usr/bin/env python3
"""fs131_ikc4_gen -- FS131-IKC4's copy of tools/fs131_ikc1_gen.py (FS131-IKC1's tool, itself a copy of FS131-KC13's;
neither is edited). Three changes, none to what the kernel checks: `--scale-bits` (the PSD witness's scale, 120 in the
original: `psdCheck` reads `sb`, `wm`, `wB` from the block, so the scale is the converter's choice); `--split DIR
--prefix MOD` (the data cut into modules: one per PSD block, `<MOD>B<k>` / `<MOD>Q<k>`, and the rest in `<MOD>`, so that
no module's text is near GitHub's limit and the blocks elaborate in parallel); `--kt-maps K` (the K table
`FibreCert.ktable` as literals, `K` maps per module `<MOD>K<r>`, for a proof that rewrites `ktable C` by them after the
kernel has compared them with its own computation, piece by piece). The original's docstring follows.

fs131_ikc1_gen -- (FS131-IKC1's copy of tools/fs131_kc13_gen.py; FS131-KC13's tool is not edited) converts an FS-66 fibre-density certificate (data/fs66/b1/cert-p*.json, format fs66-b1-cert-v2)
into the literals the kernel checker `Proofs/HadwigerNelson/Arith/FibreCert.lean` reads, and runs a Python MODEL of that
checker on them first (the model mirrors the Lean functions op for op; the Lean kernel is the only trusted check).

UNTRUSTED. Everything this program computes -- canonical forms and their witnesses, the slot of every op, the orbit of
every pair and its transporter, the Cholesky factor M of every block, the slot width -- is data the kernel re-checks.
A bug here can only make the kernel refuse.

The checker's identity is FS-66's (*) (data/fs66/b1/SOUNDNESS.md section 4), reorganised for the kernel:
  * every op is (monomial, value); the op's stream entry gives a slot j and a witness (c,d,e,o): the image
    g(x - o) of the monomial, g = (z |-> s z) or (z |-> s conj z) with s = c + d i a unit, must have the bag key of
    slot j (bag key of a multiset = sum of 8^x);
  * the times-1 quadratic part is reduced by the orbits of unordered rep pairs under G = <rotations, reflections>:
    phase 1 adds, for every pair {i <= j}, mult * sum_b R_b[i][j] * K_b(g t) into its orbit's row (t in V);
    phase 2 scatters every orbit row over t;
  * the q-part groups t by the norm class of {0, t}.
USAGE  fs131_kc13_gen.py CERT.json OUT.lean [--name NAME] [--leaf 64]
"""
import json, sys, time, hashlib, argparse
from fractions import Fraction

def bagkey(pts):
    """the bag key sum 8^x (FibreCert.bag): for at most seven points its base-8 digits are the multiplicities"""
    return sum(1 << (3 * x) for x in pts)

class Plane:
    def __init__(s, p):
        s.p = p; s.n = n = p * p
        s.S = [a * p + b for a in range(p) for b in range(p) if (a * a + b * b) % p == 1]
        s.maps = []                                  # (c, d, e): z |-> s z (e=0) or s conj z (e=1)
        for u in s.S:
            c, d = divmod(u, p)
            s.maps.append((c, d, 0)); s.maps.append((c, d, 1))
    def gmap(s, c, d, e, x):
        p = s.p; a, b = divmod(x, p)
        if e == 0:
            return ((a * c + b * (p - d)) % p) * p + ((a * d + b * c) % p)
        return ((a * c + b * d) % p) * p + ((a * d + b * (p - c)) % p)
    def sub(s, x, o):
        p = s.p; a, b = divmod(x, p); a0, b0 = divmod(o, p)
        return ((a + p - a0) % p) * p + ((b + p - b0) % p)
    def add(s, x, y):
        p = s.p; a, b = divmod(x, p); a0, b0 = divmod(y, p)
        return ((a + a0) % p) * p + ((b + b0) % p)
    def neg(s, x):
        return s.sub(0, x)
    def image(s, wit, m):
        c, d, e, o = wit
        return sorted(s.gmap(c, d, e, s.sub(x, o)) for x in m)
    def norm(s, x):
        a, b = divmod(x, s.p); return (a * a + b * b) % s.p

class Canon:
    def __init__(s, pl):
        s.pl = pl; s.memo = {}
    def canon(s, m):
        m = tuple(sorted(m))
        r = s.memo.get(m)
        if r is None:
            if not m:
                r = ((), (1, 0, 0, 0))
            else:
                best = None
                for o in sorted(set(m)):
                    for (c, d, e) in s.pl.maps:
                        im = tuple(s.pl.image((c, d, e, o), m))
                        if best is None or im < best[0]:
                            best = (im, (c, d, e, o))
                r = best
            s.memo[m] = r
        return r

def plane_wave(P, w):
    """(u, f) with w_x = f(<u,x> mod p) for x in V, or None."""
    n = P * P
    for u in range(n):
        u1, u2 = divmod(u, P); f = {}; ok = True
        for x in range(n):
            a, b = divmod(x, P); r = (u1 * a + u2 * b) % P
            if f.setdefault(r, w[x]) != w[x]:
                ok = False; break
        if ok:
            if u == 0:
                return 0, [f[0]] * P
            return u, [f[r] for r in range(P)]
    return None

def kappa_pw(P, u, f, t):
    n = P * P
    if u == 0:
        return n * f[0] * f[0]
    u1, u2 = divmod(u, P); a, b = divmod(t, P); r = (u1 * a + u2 * b) % P
    return P * sum(f[j] * f[(j + r) % P] for j in range(P))

def sigma_pw(P, u, f):
    return P * P * f[0] if u == 0 else P * sum(f)

def mp_cholesky_int(R, scale_bits):
    """M integer with s*R - M M^T diagonally dominant, s = 2^(2*scale_bits): M = round(2^scale_bits * chol(R - d I)),
    d a quarter of the float smallest eigenvalue. Untrusted: the kernel checks the dominance."""
    import mpmath, numpy as np
    m = len(R)
    lmin = float(np.linalg.eigvalsh(np.array(R, dtype=float))[0])
    if lmin <= 0:
        raise ValueError('not positive definite (float)')
    mpmath.mp.dps = 70
    A = mpmath.matrix(R)
    B = A - mpmath.eye(m) * mpmath.mpf(lmin / 4)
    Lc = mpmath.cholesky(B)
    sq = mpmath.mpf(2) ** scale_bits
    M = [[int(mpmath.nint(Lc[i, k] * sq)) if k <= i else 0 for k in range(m)] for i in range(m)]
    return M, 2 * scale_bits

def check_dd(R, M, sbits):
    m = len(R); s = (1 << sbits) + 1
    rows = [0] * m
    for i in range(m):
        Eii = s * R[i][i] - sum(M[i][k] * M[i][k] for k in range(m))
        tot = 0
        for j in range(m):
            if j != i:
                tot += abs(s * R[i][j] - sum(M[i][k] * M[j][k] for k in range(m)))
        if Eii < tot:
            return False, i
    return True, None

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('cert'); ap.add_argument('out'); ap.add_argument('--name', default=None)
    ap.add_argument('--leaf', type=int, default=64); ap.add_argument('--chunkbits', type=int, default=8192)
    ap.add_argument('--model-only', action='store_true'); ap.add_argument('--module', default=None)
    ap.add_argument('--doc', default=None, help='a file whose text goes after the import (a module docstring)')
    ap.add_argument('--tail', default=None, help='a file whose text goes before the closing `end` (theorems)')
    ap.add_argument('--no-psd', action='store_true'); ap.add_argument('--psd-only', type=int, default=None); ap.add_argument('--no-dd', action='store_true'); ap.add_argument('--nseg', type=int, default=1)
    ap.add_argument('--corrupt', default=None, help='plant a fault: rowlam | stream | U | Rentry | M | dropclass | Mdigit | ktab')
    ap.add_argument('--scale-bits', type=int, default=120, help='the PSD witness scale 2^k (s = 2^(2k) + 1)')
    ap.add_argument('--split', default=None, help='a directory: write the data as modules there (needs --prefix)')
    ap.add_argument('--prefix', default=None, help='the main data module, e.g. Proofs.HadwigerNelson.Arith.FibreCert19')
    ap.add_argument('--kt-maps', type=int, default=0, help='emit the K table as literals, this many maps per module')
    ap.add_argument('--p1-chunks', type=int, default=0, help='emit phase 1\'s state after each of this many chunks of pairs')
    a = ap.parse_args()
    t0 = time.time()
    raw = open(a.cert, 'rb').read(); C = json.loads(raw); sha = hashlib.sha256(raw).hexdigest()
    P = C['p']; n = P * P; pl = Plane(P); cn = Canon(pl)
    L = C['scale']; Unum = C['U_num']
    if a.corrupt == 'U':
        Unum -= 1
    if a.corrupt == 'dropclass':
        Unum = 0      # claim sum(phi) <= 0; the ops of the constant class are routed out of every segment below
    print(f'p={P} n={n} |S|={len(pl.S)} maps={len(pl.maps)} sha={sha[:12]}', flush=True)
    # reps, exactly the FS-66 checker's list ("1"): (0,), then (min(h,-h), max) per class {h,-h}
    reps = [(0,)]; seen = set()
    for h in range(n):
        if h in seen: continue
        mh = pl.neg(h); seen.add(h); seen.add(mh); reps.append(tuple(sorted((mh, h))))
    nr = len(reps)
    # weights in plane-wave form
    W = []
    for wi, w in enumerate(C['weights']):
        pw = plane_wave(P, w[1:])
        if pw is None:
            raise SystemExit(f'weight {wi} is not a plane wave')
        W.append((w[0], pw[0], pw[1]))
    blocks = C['blocks']
    if a.corrupt == 'Rentry':
        blocks[1]['R'][3][5] += 1; blocks[1]['R'][5][3] += 1
    # K_b(t)
    def Kb(b, t):
        return sum(kappa_pw(P, W[wi][1], W[wi][2], t) for wi in b['weights'])
    # ---------------------------------------------------------------- ops, in the Lean checker's order
    ops = []        # (kind, monomial tuple, value (int) or (pos,neg))
    stream = []     # per op with nonzero value: (slot key canonical, witness)
    def op(m, v):
        if v != 0:
            ops.append((tuple(m), v))
    # (O1) LHS, moved to the right: -U_num at [], +L*n at [0]
    op((), -Unum); op((0,), L * n)
    # (O2) times-1 constant and linear terms
    for b in blocks:
        if b['times'] != '1': continue
        R = b['R']
        for wi in b['weights']:
            c0, u, f = W[wi]; sg = sigma_pw(P, u, f)
            op((), R[0][0] * c0 * c0)
            for k in range(nr):
                op(reps[k], 2 * R[0][1 + k] * c0 * sg)
    # (O3) phase 1: pair orbits under G (acting on rep indices) with swap
    rep_index = {r: k for k, r in enumerate(reps)}
    def gact(g, k):
        c, d, e = g
        return rep_index[tuple(sorted(pl.gmap(c, d, e, x) for x in reps[k]))]
    orbit_of = {}; orbits = []      # orbit rep (i0, j0); per pair: (rho, g, swap)
    trans = {}
    for i in range(nr):
        for j in range(i, nr):
            if (i, j) in trans: continue
            rho = len(orbits); orbits.append((i, j))
            for g in pl.maps:
                gi, gj = gact(g, i), gact(g, j)
                key = (min(gi, gj), max(gi, gj))
                if key not in trans:
                    trans[key] = (rho, g, 0 if (gi, gj) == key else 1)
    print(f'reps {nr}; pairs {nr*(nr+1)//2}; orbits {len(orbits)}', flush=True)
    t1blocks = [b for b in blocks if b['times'] == '1']
    Kg = {}
    def Ktab(bidx, g):
        key = (bidx, g)
        if key not in Kg:
            b = t1blocks[bidx]; c, d, e = g
            Kg[key] = [Kb(b, pl.gmap(c, d, e, t)) for t in range(n)]
        return Kg[key]
    accP = [[0] * n for _ in orbits]; accN = [[0] * n for _ in orbits]
    p1stream = []
    npairs = nr * (nr + 1) // 2
    bounds = [r * npairs // a.p1_chunks for r in range(a.p1_chunks + 1)] if a.p1_chunks else []
    snaps = {}      # pair index -> {rho: (P list, N list)} for the rows not zero, after the first that many pairs
    def snap(m):
        snaps[m] = {r: (list(accP[r]), list(accN[r])) for r in range(len(orbits)) if any(accP[r]) or any(accN[r])}
    pidx = 0
    for i in range(nr):
        for j in range(i, nr):
            if pidx in bounds:
                snap(pidx)
            pidx += 1
            rho, g, sw = trans[(i, j)]
            p1stream.append((rho, g, sw))
            mult = 1 if i == j else 2
            for bidx, b in enumerate(t1blocks):
                r = mult * b['R'][1 + i][1 + j]
                if r == 0: continue
                K = Ktab(bidx, g)
                for t in range(n):
                    v = r * K[t]
                    if v > 0: accP[rho][t] += v
                    elif v < 0: accN[rho][t] -= v
    if a.p1_chunks:
        snap(pidx)
    a._p1 = (bounds, snaps)
    # phase 2
    for rho, (i0, j0) in enumerate(orbits):
        a0, a1 = reps[i0], reps[j0]
        for t in range(n):
            m = tuple(sorted(a0 + tuple(pl.add(x, t) for x in a1)))
            if accP[rho][t] or accN[rho][t]:
                ops.append((m, ('pn', accP[rho][t], accN[rho][t])))
    # (O4) q-part
    tnu = [0] + [next(x for x in range(n) if pl.norm(x) == nu) for nu in range(1, P)]
    alpha0 = 0; alpha1 = 0; beta = [0] * P
    qtrans = []
    for t in range(n):
        nu = pl.norm(t)
        if t == 0:
            qtrans.append((0, (1, 0, 0)))
        else:
            # rotation s with s * tnu = t: s = t / tnu
            g = next(g for g in pl.maps if g[2] == 0 and pl.gmap(g[0], g[1], 0, tnu[nu]) == t)
            qtrans.append((nu, g))
    for b in blocks:
        if b['times'] != 'q': continue
        R = b['R']
        for wi in b['weights']:
            c0, u, f = W[wi]; sg = sigma_pw(P, u, f)
            alpha0 += R[0][0] * c0 * c0
            alpha1 += 2 * R[0][1] * c0 * sg
            for t in range(n):
                beta[qtrans[t][0]] += R[1][1] * kappa_pw(P, u, f, t)
    qmonos = [((), alpha0), ((0,), alpha1)] + [((0, tnu[nu]), beta[nu]) for nu in range(P)]
    # note: nu = 0 gives (0, 0)
    for m, coef in qmonos:
        if coef == 0: continue
        for x in range(n):
            op(m + (x,), 2 * coef)
            op(m + (x, x), -2 * coef)
            for s in pl.S:
                op(m + (x, pl.add(x, s)), -coef)
    # (O5) rows, in FibreCert.boxOps's order: expand B from the front, the term without b first
    rows = C['rows']
    if a.corrupt == 'rowlam':
        rows[7][2] += 1
    def box(A, B, neg, lam):
        if not B:
            op(tuple(A), -lam if neg else lam)
        else:
            box(A, B[1:], neg, lam); box(list(A) + [B[0]], B[1:], not neg, lam)
    for (A, B, lam) in rows:
        box(list(A), list(B), False, lam)
    print(f'ops {len(ops)} [{time.time()-t0:.1f}s]', flush=True)
    # ---------------------------------------------------------------- canonical slots and the model check
    keys = {}; slotlist = []; total = 0
    pos = {}; neg = {}
    opstream = []
    for (m, v) in ops:
        cm, wit = cn.canon(m)
        assert tuple(pl.image(wit, m)) == cm
        bk = bagkey(cm)
        if bk not in keys:
            keys[bk] = len(slotlist); slotlist.append(bk)
        j = keys[bk]
        opstream.append((j, wit))
        if isinstance(v, tuple):
            _, vp, vn = v
            pos[j] = pos.get(j, 0) + vp; neg[j] = neg.get(j, 0) + vn; total += vp + vn
        elif v > 0:
            pos[j] = pos.get(j, 0) + v; total += v
        else:
            neg[j] = neg.get(j, 0) - v; total += -v
    if a.corrupt == 'stream':
        j0, (c, d, e, o) = opstream[len(opstream) // 2]
        opstream[len(opstream) // 2] = (j0, (c, d, e, (o + 1) % n))
        print('planted: op %d witness origin moved' % (len(opstream) // 2))
    if a.corrupt == 'dropclass':
        j0 = keys[bagkey(())]
        out_slot = a.nseg << (6 + max(0, (((len(slotlist) + 63) // 64 + a.nseg - 1) // a.nseg - 1).bit_length()))
        nmoved = 0
        for k, (j, wit) in enumerate(opstream):
            if j == j0:
                opstream[k] = (out_slot, wit); nmoved += 1
        pos[j0] = 0; neg[j0] = 0
        print(f'planted: U_num = 0; the {nmoved} ops of the constant class routed to slot {out_slot}, in no segment')
    bad = [j for j in range(len(slotlist)) if pos.get(j, 0) != neg.get(j, 0)]
    print(f'slots {len(slotlist)}; identity model: {"HOLDS" if not bad else "FAILS at %d slots" % len(bad)}; '
          f'total magnitude bits {total.bit_length()} [{time.time()-t0:.1f}s]', flush=True)
    if a.model_only:
        sys.exit(0 if not bad else 1)
    # PSD witnesses
    psd = []
    for bi, b in (enumerate(blocks) if not a.no_psd else []):
        R = b['R']
        if a.psd_only is not None and bi != a.psd_only:
            psd.append(([[0] * len(R) for _ in R], 240)); continue
        M, sbits = mp_cholesky_int(R, a.scale_bits)
        if not a.no_dd:
            ok, row = check_dd(R, M, sbits)
            if not ok:
                raise SystemExit(f'block {bi}: diagonal dominance fails at row {row}')
        psd.append((M, sbits))
    print(f'PSD witnesses: {len(psd)} blocks diagonally dominant [{time.time()-t0:.1f}s]', flush=True)
    if a.corrupt == 'M':
        big = [i for i, b in enumerate(blocks) if len(b['R']) > 2]
        i1, i2 = big[0], big[1]
        psd[i1], psd[i2] = psd[i2], psd[i1]
        print(f'planted: PSD witnesses of blocks {i1} and {i2} swapped')
    if a.corrupt == 'Mdigit':
        big = [i for i, b in enumerate(blocks) if len(b['R']) > 2]
        psd[big[0]][0][0][0] *= 2
        print(f'planted: M[0][0] of block {big[0]} doubled')
    json.dump({'p': P, 'n': n, 'nr': nr, 'orbits': orbits, 'slots': len(slotlist), 'ops': len(ops),
               'total_bits': total.bit_length(), 'identity_holds': not bad, 'sha256': sha},
              open(a.out + '.summary.json', 'w'), indent=1)
    emit(a, P, n, pl, reps, W, blocks, orbits, p1stream, qtrans, tnu, rows, opstream, slotlist, total, psd, L, Unum, sha, accP, accN)

def chunks(fields, k, chunkbits):
    per = max(1, chunkbits // k)
    out = []
    for i in range(0, len(fields), per):
        v = 0
        for j, f in enumerate(fields[i:i + per]):
            assert 0 <= f < (1 << k), (f, k)
            v |= f << (k * j)
        out.append(v)
    return per, out

def lean_list(xs, ind='    '):
    return '[' + (',\n' + ind).join(xs) + ']'

def hexl(v):
    return hex(v)

def emit(a, P, n, pl, reps, W, blocks, orbits, p1stream, qtrans, tnu, rows, opstream, slotlist, total, psd, L, Unum, sha, accP, accN):
    name = a.name or f'cert{P}'
    CB = a.chunkbits
    lb = 6; LS = 1 << lb
    nleaves = (len(slotlist) + LS - 1) // LS
    nseg = a.nseg
    ds = max(0, ((nleaves + nseg - 1) // nseg - 1).bit_length())
    kb = 3 * n + 1
    keys = []
    for lf in range(nseg << ds):
        v = 0
        for s_ in range(LS):
            j = lf * LS + s_
            if j < len(slotlist):
                v |= slotlist[j] << (kb * s_)
        keys.append(v)
    w = max(total.bit_length(), 1) + 2
    # phase-1 bound: sum over pairs and blocks of |coef| * max|K|
    t1 = [b for b in blocks if b['times'] == '1']; tq = [b for b in blocks if b['times'] == 'q']
    def Kb(b, t):
        return sum(kappa_pw(P, W[wi][1], W[wi][2], t) for wi in b['weights'])
    km = [max(abs(Kb(b, x)) for x in range(n)) for b in t1]
    nr = len(reps); bnd = 0
    p1bounds, p1snaps = getattr(a, '_p1', ([], {}))
    p1bnd = {}; pidx = 0
    for i in range(nr):
        for j in range(i, nr):
            if pidx in p1bounds:
                p1bnd[pidx] = bnd
            pidx += 1
            mult = 1 if i == j else 2
            for bi, b in enumerate(t1):
                bnd += abs(mult * b['R'][1 + i][1 + j]) * km[bi]
    if p1bounds:
        p1bnd[pidx] = bnd
    w = max(w, bnd.bit_length() + 2)
    wc = 8; wf = max(abs(v) for (c0, u, f) in W for v in f).bit_length() + 2
    weights = [(c0 + (1 << (wc - 1)), u, sum((v + (1 << (wf - 1))) << (wf * r) for r, v in enumerate(f))) for (c0, u, f) in W]
    psdmap = {id(b): psd[i] for i, b in enumerate(blocks)} if psd else {}
    def blk(b):
        R = b['R']; m = len(R)
        wr = max(abs(v) for row in R for v in row).bit_length() + 2
        off = 1 << (wr - 1)
        per0, row0 = chunks([R[0][j] + off for j in range(m)], wr, CB)
        fl = [R[i][j] + off for i in range(1, m) for j in range(i, m)]
        per, rest = chunks(fl, wr, CB)
        assert per == per0
        if id(b) in psdmap:
            M, sbits = psdmap[id(b)]
            wm = max(61, max(1, max(abs(v) for row in M for v in row).bit_length()) + 2)   # tags < 2^60 < 2^wm
            Cm = (1 << (wm - 1)) + 1
            wB = (m * (2 * Cm) ** 2).bit_length() + 1
            import random as _r
            rg = _r.Random(1000 * m + len(fl))
            fwd = [(rg.getrandbits(60) | (1 << 59)) + sum((M[i][k] + Cm) << (wB * (k + 1)) for k in range(m)) for i in range(m)]
            psdd = (sbits, wm, wB, fwd)
        else:
            psdd = (0, 0, 0, [])
        return (b['weights'], m, wr, per, row0, rest, psdd)
    B1 = [blk(b) for b in t1]; BQ = [blk(b) for b in tq]
    ng = 2 * (P + 1)
    gidx = {g: i for i, g in enumerate(pl.maps)}
    f1 = [((rho * ng + gidx[g]) * 2 + sw) for (rho, g, sw) in p1stream]
    k1 = max(f1).bit_length(); per1, p1 = chunks(f1, k1, CB)
    fq = [nu * ng + gidx[g] for (nu, g) in qtrans]
    kq = max(fq).bit_length(); perq, qt = chunks(fq, kq, CB)
    kp = (n - 1).bit_length()
    wl = max(r[2] for r in rows).bit_length()
    fr = []
    for (A, Bv, lam) in rows:
        xs = list(A) + list(Bv) + [0] * (4 - len(A) - len(Bv))
        pts = lam
        for x in reversed(xs):
            pts = (pts << kp) | x
        fr.append((pts << 6) | (len(A) << 3) | len(Bv))
    kr = 6 + 4 * kp + wl; perr, rws = chunks(fr, kr, CB)
    fo_w = []
    for (j, (c, d, e, o)) in opstream:
        fo_w.append((j, ((c * P + d) * 2 + e) * n + o))
    kw = max(x[1] for x in fo_w).bit_length(); ko = max(1, max(x[0] for x in fo_w).bit_length())
    fo = [(j << kw) | wt for (j, wt) in fo_w]
    pero, ops = chunks(fo, kw + ko, CB)
    def nlist(xs): return '[' + ', '.join(str(x) for x in xs) + ']'
    def blkL(t):
        wts, m, wr, per, row0, rest, (sbits, wm, wB, fwd) = t
        return ('{ wts := ' + nlist(wts) + ', m := ' + str(m) + ', wr := ' + str(wr) + ', per := ' + str(per) +
                ', sb := ' + str(sbits) + ', wm := ' + str(wm) + ', wB := ' + str(wB) +
                ', mrows := ' + lean_list([hexl(x) for x in fwd], '        ') +
                ', row0 := ' + lean_list([hexl(x) for x in row0], '        ') +
                ', rest := ' + lean_list([hexl(x) for x in rest], '        ') + ' }')
    hdr = f'-- GENERATED by tools/fs131_ikc4_gen.py from {a.cert} (sha256 {sha}); do not edit.'
    fields = []
    fields.append(f'  p := {P}\n  scale := {L}\n  unum := {Unum}\n  w := {w}\n  lb := {lb}\n  ds := {ds}\n  nseg := {nseg}\n  kb := {kb}')
    fields.append('  keys := ' + lean_list([hexl(x) for x in keys]))
    fields.append('  reps := [' + ', '.join(nlist(r) for r in reps) + ']')
    fields.append(f'  wc := {wc}\n  wf := {wf}')
    fields.append('  weights := [' + ', '.join(f'({c}, {u}, {hexl(fp)})' for (c, u, fp) in weights) + ']')
    BLK1 = 'BLOCKS1'; BLKQ = 'BLOCKSQ'
    fields.append('  blocks1 := ' + BLK1)
    fields.append('  blocksq := ' + BLKQ)
    fields.append('  orbits := [' + ', '.join(f'({nlist(reps[i])}, {nlist(reps[j])})' for (i, j) in orbits) + ']')
    fields.append('  orows := ' + lean_list([f'({hexl(sum(v << (w * t) for t, v in enumerate(accP[r])))}, {hexl(sum(v << (w * t) for t, v in enumerate(accN[r])))})' for r in range(len(orbits))]))
    fields.append(f'  k1 := {k1}\n  per1 := {per1}')
    fields.append('  p1 := ' + lean_list([hexl(x) for x in p1]))
    fields.append('  tnu := ' + nlist(tnu))
    fields.append(f'  kq := {kq}\n  perq := {perq}')
    fields.append('  qt := ' + lean_list([hexl(x) for x in qt]))
    fields.append(f'  kp := {kp}\n  kr := {kr}\n  perr := {perr}\n  nrows := {len(rows)}')
    fields.append('  rows := ' + lean_list([hexl(x) for x in rws]))
    fields.append(f'  kw := {kw}\n  ko := {ko}\n  pero := {pero}')
    fields.append('  ops := ' + lean_list([hexl(x) for x in ops]))
    certbody = '\n'.join(fields)
    # the K table, exactly FibreCert.ktable: per map of gList p (pl.maps, the same order), per times-1 block, the packed
    # rows t |-> max(+-K_b(g t), 0) at width w (FibreCert.krow)
    kt = []
    if a.kt_maps:
        for (c, d, e) in pl.maps:
            krs = []
            for b in t1:
                vs = [Kb(b, pl.gmap(c, d, e, t)) for t in range(n)]
                assert all(abs(v) < (1 << w) for v in vs)
                krs.append((sum(max(v, 0) << (w * t) for t, v in enumerate(vs)),
                            sum(max(-v, 0) << (w * t) for t, v in enumerate(vs))))
            kt.append(((c, d, e), krs))
        if a.corrupt == 'ktab':
            (g, krs) = kt[0]; krs = list(krs); krs[0] = (krs[0][0] + (1 << (w * 5)), krs[0][1]); kt[0] = (g, krs)
            print('planted: slot 5 of map 0, block 0, moved by one in the K-table literal')
    def ktL(ent):
        (g, krs) = ent
        return '((%d, %d, %d), [%s])' % (g + (', '.join('(%s, %s)' % (hex(x), hex(y)) for (x, y) in krs),))
    if not a.split:
        out = [hdr, f'-- {len(opstream)} ops, {len(slotlist)} slots, {len(orbits)} orbits, slot width {w} bits.']
        out.append('import FibreCheck' if not a.module else f'import {a.module}')
        if a.doc:
            out.append(open(a.doc).read().rstrip('\n'))
        out.append('namespace HadwigerNelson.FibreCert')
        out.append(f'/-- FS-66\'s certificate at p = {P}, re-encoded for the kernel. -/')
        out.append(f'def {name} : Cert where')
        out.append(certbody.replace(BLK1, '[' + ',\n    '.join(blkL(t) for t in B1) + ']').replace(BLKQ, '[' + ',\n    '.join(blkL(t) for t in BQ) + ']'))
        if a.tail:
            out.append(open(a.tail).read().rstrip('\n'))
        out.append('end HadwigerNelson.FibreCert')
        open(a.out, 'w').write('\n'.join(out) + '\n')
    else:
        import os
        assert a.prefix, '--split needs --prefix'
        base = a.prefix.rsplit('.', 1)[1]
        os.makedirs(a.split, exist_ok=True)
        written = []
        def module(mod, defs_text, doc):
            path = os.path.join(a.split, mod.rsplit('.', 1)[1] + '.lean')
            txt = (hdr + '\n' + 'import Proofs.HadwigerNelson.Arith.FibreCert\n' + doc + '\n' +
                   'namespace HadwigerNelson.FibreCert\n' + defs_text + '\nend HadwigerNelson.FibreCert\n')
            open(path, 'w').write(txt); written.append((path, len(txt)))
        bnames1 = []; bnamesq = []; ktnames = []; mods = []
        for k, t in enumerate(B1):
            nm = f'{name}_b{k}'; bnames1.append(nm); mod = f'{a.prefix}B{k}'; mods.append(mod)
            module(mod, f'/-- Times-1 block {k} of the certificate at p = {P} (data). -/\ndef {nm} : Blk :=\n  ' + blkL(t),
                   f'-- Data only: times-1 block {k} of `{name}`, its PSD witness at scale 2^{a.scale_bits}.')
        for k, t in enumerate(BQ):
            nm = f'{name}_q{k}'; bnamesq.append(nm); mod = f'{a.prefix}Q{k}'; mods.append(mod)
            module(mod, f'/-- Times-q block {k} of the certificate at p = {P} (data). -/\ndef {nm} : Blk :=\n  ' + blkL(t),
                   f'-- Data only: times-q block {k} of `{name}`.')
        if a.kt_maps:
            km_ = a.kt_maps
            for r in range((len(kt) + km_ - 1) // km_):
                nm = f'{name}_kt{r}'; ktnames.append(nm); mod = f'{a.prefix}K{r}'; mods.append(mod)
                module(mod, f'/-- Maps {r * km_} to {min(len(kt), (r + 1) * km_) - 1} of the K table of the certificate at p = {P} '
                       f'(data: the kernel compares it with `ktable`). -/\ndef {nm} : List ((Nat × Nat × Nat) × List (Nat × Nat)) :=\n  ' +
                       lean_list([ktL(e) for e in kt[r * km_:(r + 1) * km_]], '    '),
                       f'-- Data only: the K table of `{name}`, maps {r * km_}..{min(len(kt), (r + 1) * km_) - 1}.')
        if p1bounds:
            def bucketsL(m):
                sn = p1snaps[m]
                rowsL = []
                for r, (i0, j0) in enumerate(orbits):
                    Pp, Nn = sn.get(r, ([0] * n, [0] * n))
                    rowsL.append(f'({nlist(reps[i0])}, {nlist(reps[j0])}, {hexl(sum(v << (w * t) for t, v in enumerate(Pp)))}, '
                                 f'{hexl(sum(v << (w * t) for t, v in enumerate(Nn)))})')
                return '[' + ',\n    '.join('[' + ', '.join(rowsL[k:k + 16]) + ']' for k in range(0, len(rowsL), 16)) + ']'
            for r in range(1, len(p1bounds)):
                m = p1bounds[r]; nm = f'{name}_p1s{r}'; mod = f'{a.prefix}P{r}'
                module(mod, f'/-- Phase 1\'s orbit rows after its first {m} pairs (data: the kernel compares it with its own fold). -/\n'
                       f'def {nm} : List (List ORow) :=\n  ' + bucketsL(m) +
                       f'\n\n/-- Phase 1\'s bound after its first {m} pairs (data). -/\ndef {name}_p1b{r} : Nat := {p1bnd[m]}',
                       f'-- Data only: phase 1 of `{name}` after {m} of its {p1bounds[-1]} pairs.')
                mods.append(mod)
            json.dump({'bounds': p1bounds, 'bnd': [p1bnd[m] for m in p1bounds]}, open(a.out + '.p1.json', 'w'))
        path = os.path.join(a.split, base + '.lean')
        txt = [hdr, f'-- {len(opstream)} ops, {len(slotlist)} slots, {len(orbits)} orbits, slot width {w} bits.']
        txt += [f'import {m}' for m in mods]
        if a.doc:
            txt.append(open(a.doc).read().rstrip('\n'))
        txt.append('namespace HadwigerNelson.FibreCert')
        txt.append(f'/-- The certificate at p = {P}, re-encoded for the kernel; its blocks are `{name}_b0` … in their own modules. -/')
        txt.append(f'def {name} : Cert where')
        txt.append(certbody.replace(BLK1, '[' + ', '.join(bnames1) + ']').replace(BLKQ, '[' + ', '.join(bnamesq) + ']'))
        if a.kt_maps:
            txt.append(f'/-- The K table of `{name}` as literals (data: the kernel compares each piece with `ktable {name}`). -/')
            txt.append(f'def {name}_kt : List ((Nat × Nat × Nat) × List (Nat × Nat)) :=\n  List.flatten [' + ', '.join(ktnames) + ']')
        if a.tail:
            txt.append(open(a.tail).read().rstrip('\n'))
        txt.append('end HadwigerNelson.FibreCert')
        t = '\n'.join(txt) + '\n'
        open(path, 'w').write(t); written.append((path, len(t)))
        for (pth, sz) in written:
            print(f'wrote {pth}: {sz} bytes')
        print(f'modules {len(written)}; largest {max(sz for _, sz in written)} bytes; total {sum(sz for _, sz in written)} bytes')
    print(f'w={w} ds={ds} k1={k1} kq={kq} kr={kr} kw={kw} ko={ko}; '
          f'chunks ops={len(ops)} rows={len(rws)} keys={len(keys)}', flush=True)

if __name__ == '__main__':
    main()
