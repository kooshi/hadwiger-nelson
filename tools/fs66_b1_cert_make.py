#!/usr/bin/env python3
"""FS-66 phase 2B -- the PRODUCER of the all-levels certificate.  UNTRUSTED, by design.

What it makes.  For a prime p = 3 (mod 4) it builds the minimal second-level moment (sum-of-squares)
relaxation of the single-class fibre-density problem

    B1(p) = max sum_x phi_x     over phi in [0,1]^(p^2)
            subject to  q(phi) := c*sum_x phi_x(1 - phi_x) - sum_x sum_{s in S} phi_x phi_{x+s} >= 0,

with c = 2 (the hand-proved constant of plans/FS66-phase2-certificate.md §S.2), solves it in ordinary
double precision, and ROUNDS the solver's dual to an exact integer certificate in the format
`fs66-b1-cert-v2` of that plan's §C.  By §S, an upper bound U on B1(p) bounds the independence number
of EVERY level of the tower of unit-distance graphs over Z/p^k, so m*U < p^2 refuses m colours at
every level at once.

What is trusted here: nothing.  The certificate is a claim until tools/fs66_b1_cert_check.py --
written independently, standard library only, sharing no code with this file -- says CERTIFIED.  A
wrong weight vector, a wrong block structure or a wrong product table IN THIS PROGRAM can only weaken
the bound U that comes out (§C.3); none of them can make a false certificate pass, because the
checker rebuilds the group, the canonical forms and q from p alone and verifies the identity in exact
integers.

U is an OUTPUT, never a target.  After the blocks and the solver's own row multipliers are rounded,
the cascade (§C.4) absorbs whatever linear form is still owed into box rows, by decreasing degree,
and U is what is left at the constant monomial.  So ANY rational positive-definite blocks yield a
valid certificate for SOME U, and a rounding attempt is scored by the bound it proves, never by a
residual -- FS-50's rule (plans/FS50-certificate-soundness.md §5), transplanted.

  usage: fs66_b1_cert_make.py P [options]

  the production run (what made the committed certificates):
      python3 tools/fs66_b1_cert_make.py 11 --scan --out data/fs66/b1/cert-p11.json \\
              --record data/fs66/b1/records.jsonl

  the two float controls at 7 (no rounding; they read the relaxation, not a certificate):
      python3 tools/fs66_b1_cert_make.py 7 --drop-q --edge-row --no-round     ->  24.5 = n/2
      python3 tools/fs66_b1_cert_make.py 7 --pure --no-round                  ->  14.0 = alpha(G_1)

  the two producer-dependent controls of the checker (plan §K.3 plants 9 and 12):
      python3 tools/fs66_b1_cert_make.py 7 --c 1   --out /tmp/plant9.json      (the WRONG problem)
      python3 tools/fs66_b1_cert_make.py 7 --arbitrary-weights 20260921 --out /tmp/plant12.json

Needs numpy, scipy, scs (and optionally clarabel): venv ~/venvs/fs66.
"""

import argparse
import os
import sys

# ------------------------------------------------------------------ arguments, before numpy is imported
# BLAS/OpenMP thread counts must be set before numpy loads, or --threads is a lie.

def parse_args(argv):
    ap = argparse.ArgumentParser(
        prog='fs66_b1_cert_make.py',
        description='produce an FS-66 all-levels certificate (format fs66-b1-cert-v2). UNTRUSTED: '
                    'the verdict is tools/fs66_b1_cert_check.py\'s.')
    ap.add_argument('p', type=int, help='the prime; must be = 3 (mod 4)')
    ap.add_argument('--out', default=None, help='write the certificate here (JSON)')
    ap.add_argument('--record', default=None, help='append one JSON record per attempt here')
    ap.add_argument('--solver', default='scs', choices=('scs', 'clarabel'))
    ap.add_argument('--eps', type=float, default=1e-7, help='solver tolerance (SCS: eps_abs = eps_rel)')
    ap.add_argument('--max-iters', type=int, default=200000)
    ap.add_argument('--threads', type=int, default=4)
    ap.add_argument('--digits', type=int, default=12, help='D: the blocks and row multipliers are rounded over 10^D')
    ap.add_argument('--weight-digits', type=int, default=9, help='W: the cosine/sine weights are rounded over 10^W')
    ap.add_argument('--shift', type=float, default=1e-6,
                    help='relative diagonal shift added to each dual block IN THE SOLVER BASIS before rounding')
    ap.add_argument('--scan', action='store_true',
                    help='round at every (shift, D) of plan §R\'.4 in parallel and keep the smallest U '
                         'whose blocks are all positive definite')
    ap.add_argument('--scan-shifts', default='1e-7,1e-6,1e-5')
    ap.add_argument('--scan-digits', default='10,12')
    ap.add_argument('--jobs', type=int, default=6, help='parallel rounding attempts (fork context)')
    ap.add_argument('--escalate', type=int, default=3,
                    help='if no attempt has all blocks positive definite, multiply the shift by 10 this many times')
    ap.add_argument('--c', type=float, default=2.0,
                    help='the constant of q. ONLY 2 is the hand-proved problem; any other value produces a file '
                         'for a DIFFERENT problem -- a control (plan §K.3 plant 9), never a certificate.')
    ap.add_argument('--drop-q', action='store_true', help='control: drop the quadratic constraint entirely')
    ap.add_argument('--edge-row', action='store_true',
                    help='control: add the symmetrised edge cut y([]) - 2 y([0]) >= 0 (i.e. sum phi <= n/2)')
    ap.add_argument('--pure', action='store_true',
                    help='control: add phi^2 = phi, turning the relaxation into Lasserre-2 for alpha(G_1)')
    ap.add_argument('--no-round', action='store_true', help='stop after the float reading')
    ap.add_argument('--arbitrary-weights', type=int, default=None, metavar='SEED',
                    help='control (plan §K.3 plant 12): replace every weight vector by arbitrary integers of the '
                         'same magnitude and recompute U and the rows. The file must still check.')
    ap.add_argument('--quiet', action='store_true')
    # ---- phase 2C (p = 19): the fast path.  Every flag below defaults OFF, so the code the committed
    # certificates at 7 and 11 came from is reached by exactly the commands that made them (--regression).
    ap.add_argument('--fast', action='store_true',
                    help='p = 19 path: build the product table across forked workers using the two symmetries '
                         'F[ib][ia][t] = F[ia][ib][t] = F[ia][ib][-t], memoise the q forms on canon(m), and '
                         'assemble the constraint matrix in numpy. Mathematically the same relaxation; verified '
                         'against the reference build by --twin-build.')
    ap.add_argument('--build-jobs', type=int, default=16, help='--fast: forked workers for the product table')
    ap.add_argument('--cache-dir', default=None,
                    help='--fast: directory holding the build cache (orbits, product table, q forms). Written '
                         'after the build and reloaded on a later run; NEVER under build/.')
    ap.add_argument('--linear-solver', default=None,
                    help="SCS linear-system backend, passed through: e.g. indirect, gpu_indirect. Default: SCS's own")
    ap.add_argument('--chunk-iters', type=int, default=0,
                    help='drive SCS in warm-started chunks of this many iterations, saving (x, y, s) to '
                         '--solve-ckpt after each and printing one residual line per chunk. 0 = one call.')
    ap.add_argument('--solve-ckpt', default=None, help='the chunked solve\'s checkpoint (.npz); resumed if present')
    ap.add_argument('--stop-after-chunks', type=int, default=0,
                    help='control: exit after this many chunks, leaving the checkpoint, so that resuming can be '
                         'exercised on purpose')
    ap.add_argument('--twin-build', action='store_true',
                    help='control: build BOTH the reference and the fast way and compare the product table, the '
                         'q forms, the block entries and the box rows as canonical monomials. Exits nonzero on '
                         'any disagreement.')
    ap.add_argument('--regression', action='store_true',
                    help='control: reproduce the committed certificate at this p and compare every key except '
                         'producer.utc and producer.tool_sha256 (the two that any edit to this file must change)')
    return ap.parse_args(argv)


ARGS = parse_args(sys.argv[1:])
for _v in ('OMP_NUM_THREADS', 'OPENBLAS_NUM_THREADS', 'MKL_NUM_THREADS', 'NUMEXPR_NUM_THREADS'):
    os.environ.setdefault(_v, str(max(1, ARGS.threads)))

import datetime          # noqa: E402
import hashlib           # noqa: E402
import json              # noqa: E402
import math              # noqa: E402
import multiprocessing   # noqa: E402
import platform          # noqa: E402
import resource          # noqa: E402
import time              # noqa: E402
from fractions import Fraction   # noqa: E402

import numpy as np       # noqa: E402
import scipy.sparse as sp        # noqa: E402

FORMAT = 'fs66-b1-cert-v2'
SPEC = ('plans/FS66-phase2-certificate.md §C (the format) and §S (why it proves the statement); '
        'data/fs66/b1/SOUNDNESS.md')
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
T0 = time.monotonic()


def say(*a):
    if not ARGS.quiet:
        print(*a, flush=True)


def sha256_of(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def utc_now():
    return datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')


def rss_mb():
    return round(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024.0, 1)


def dec_str(num, den, places=6):
    """num/den truncated toward zero, with an ellipsis when truncation lost something.

    Truncation, never rounding: a printed U is then never smaller than the exact one, so the printed
    claim is never stronger than the proved one (the checker prints the same way)."""
    neg = (num < 0) != (den < 0)
    a, b = abs(num), abs(den)
    whole, rem = divmod(a, b)
    frac, rem2 = divmod(rem * 10 ** places, b)
    return f'{"-" if neg else ""}{whole}.{frac:0{places}d}' + ('' if rem2 == 0 else '…')


# ----------------------------------------------------------- monomial encoding and the parallel product table
# A monomial of degree <= 4 over n points is packed into one int64 so that millions of them cross a
# process boundary as a numpy array rather than as Python tuples: [len | m0 | m1 | m2 | m3] base n+1,
# absent entries written as the sentinel n.  At p = 19 the largest value is 4*362^4 < 2^63.

def enc_mono(m, n):
    v = len(m)
    for i in range(4):
        v = v * (n + 1) + (m[i] if i < len(m) else n)
    return v


def dec_mono(v, n):
    d = []
    for _ in range(4):
        v, r = divmod(v, n + 1)
        d.append(r)
    ln = v
    d.reverse()
    return tuple(d[:ln])


_FST = {}        # set in the parent before forking; the workers inherit it (fork context only)


def _product_chunk(ias):
    """canon(a * tau_t(a')) for a = reps[ia], every a' = reps[ib] with ib >= ia, and every t in the
    HALF range (one representative per class {t, -t}), encoded.  One (ia, array) pair per ia."""
    B = _FST['B']
    n, R, half = B.n, B.R, B.half
    out = []
    for ia in ias:
        a = B.reps[ia]
        arr = np.empty((R - ia, len(half)), dtype=np.int64)
        for k in range(R - ia):
            b = B.reps[ia + k]
            for j, t in enumerate(half):
                row = B.ADD[t]
                arr[k, j] = enc_mono(B.canon(a + tuple(row[y] for y in b)), n)
        out.append((ia, arr))
    return out


class Build:
    """everything derived from p: the plane, the canonical forms, the representatives, the product
    table F(a, a', t) = canon(a * tau_t(a')), the forms Q, the PSD blocks and the scalar rows.

    The conventions here are the checker's, and the checker is the specification (plan §R.8):
      * a point (a, b) is the index a*p + b;
      * reps("1") = phi_0, then phi_{-h} phi_h one per class {h, -h} by ascending smaller index;
      * a block with times "1" is (1 + #reps) x (1 + #reps), index 0 being the constant row, so a
        character block whose weights have c = 0 is PADDED with the row [1, 0, ..., 0];
      * kappa(t) = sum_x w_x w_{x+t}.
    """

    def __init__(self, p, c=2.0, with_q=True, edge_row=False, pure=False,
                 fast=False, jobs=1, cache_dir=None):
        self.fast = fast
        self._qmemo = {} if fast else None
        if p % 4 != 3:
            raise SystemExit(f'p = {p} is not 3 mod 4; the unit circle of F_p^2 has p + 1 points only in '
                             f'the anisotropic case, and nothing in this plan was examined otherwise.')
        self.p, self.c = p, c
        n = self.n = p * p
        self.ADD = [[((x // p + y // p) % p) * p + ((x % p + y % p) % p) for y in range(n)] for x in range(n)]
        self.SUB = [[((y // p - x // p) % p) * p + ((y % p - x % p) % p) for y in range(n)] for x in range(n)]
        self.S = tuple(a * p + b for a in range(p) for b in range(p) if (a * a + b * b) % p == 1)
        assert len(self.S) == p + 1
        maps = []
        for s in self.S:
            cc, dd = divmod(s, p)
            rot, ref = [], []
            for z in range(n):
                a, b = divmod(z, p)
                rot.append(((a * cc - b * dd) % p) * p + ((a * dd + b * cc) % p))
                ref.append(((a * cc + b * dd) % p) * p + ((a * dd - b * cc) % p))
            maps.append(tuple(rot))
            maps.append(tuple(ref))
        self.maps = tuple(maps)

        # ---- canonical forms, memoised in two stages: translation-normal form, then the full minimisation.
        # a * tau_t(a') and a' * tau_{-t}(a) are translates of one another, so the expensive half runs once
        # for the two of them (the checker's trick; plan §R.8 item 2).
        self._tmemo, self._cmemo = {}, {}
        self.index, self.list = {}, []
        assert self.idx(()) == 0, 'the constant monomial must be orbit 0 (the assembly reads it as the offset)'

        # ---- representatives (the order IS the specification)
        reps = [(0,)]
        seen = set()
        for h in range(n):
            if h in seen:
                continue
            mh = self.SUB[h][0]
            seen.add(h)
            seen.add(mh)
            reps.append(tuple(sorted((mh, h))))
        self.reps = reps
        R = self.R = len(reps)
        say(f'p={p} n={n} |S|={len(self.S)} |maps|={len(self.maps)} reps={R}')

        # ---- the half range of shifts: one t per class {t, -t}.  z -> -z is in Gamma (it is the
        # rotation by the circle point -1) and every representative is negation-stable, so
        # F(a, a', -t) = F(a, a', t); and a' * tau_{-t}(a) is the translate tau_{-t}(a * tau_t(a')),
        # so F[ib][ia][t] = F[ia][ib][t].  The two together make the table a quarter of its naive size.
        self.half = [t for t in range(n) if t <= self.SUB[t][0]]
        self.hidx = [0] * n
        for j, t in enumerate(self.half):
            self.hidx[t] = j
            self.hidx[self.SUB[t][0]] = j

        # ---- the product table
        t0 = time.monotonic()
        if fast:
            self._fast_products(jobs, cache_dir)
            say(f'products a*tau_t(a\'): {R*(R+1)//2*len(self.half)} canonical forms (a quarter of '
                f'{R*R*n} by the two symmetries), {len(self.list)} orbits [{time.monotonic()-t0:.1f} s]')
        else:
            self.F = [[[self.idx(a + tuple(self.ADD[t][y] for y in b)) for t in range(n)] for b in reps]
                      for a in reps]
            say(f'products a*tau_t(a\'): {R*R*n} canonical forms, {len(self.list)} orbits '
                f'[{time.monotonic()-t0:.1f} s]')

        # ---- the forms Q(m) = moment of q*m  (needed for the q localiser and for the exact accumulation)
        self.Q_empty = self.q_form(())
        self.Q_0 = self.q_form((0,))
        self.Q_t = [self.q_form((0, t)) for t in range(n)]
        say(f'q forms built: {len(self.list)} orbits [{time.monotonic()-t0:.1f} s]')

        # ---- characters: u = 0 and one u per nonzero norm class
        ureps = {}
        for z in range(1, n):
            a, b = divmod(z, p)
            ureps.setdefault((a * a + b * b) % p, z)
        self.ureps = [ureps[k] for k in sorted(ureps)]
        assert len(self.ureps) == p - 1
        self.cosv = {}
        for u in self.ureps:
            ua, ub = divmod(u, p)
            self.cosv[u] = np.cos(2 * np.pi * np.array(
                [(ua * (z // p) + ub * (z % p)) % p for z in range(n)]) / p)

        # ---- the PSD blocks and the scalar rows of the relaxation
        self.blocks = []          # (name, dim, [(i, j, orbit, coef)])  upper triangle i <= j
        self.rows = []            # (kind, payload, {orbit: coef})   meaning  expr >= 0
        self.eq_rows = []         # {orbit: coef} meaning expr == 0
        if fast:
            self._moment_blocks_fast()
            if with_q:
                self._q_blocks_fast()
        else:
            self._moment_blocks()
            if with_q:
                self._q_blocks()
        if edge_row:
            self.rows.append(('edge', None, {self.idx(()): 1.0, self.idx((0,)): -2.0}))
        self._box_rows()
        if pure:
            for m in list(self.list):
                if len(set(m)) < len(m):
                    self.eq_rows.append({self.idx(m): 1.0, self.idx(tuple(sorted(set(m)))): -1.0})
        self.K = len(self.list)
        say(f'orbits K={self.K}; PSD blocks {[(nm, d) for nm, d, _ in self.blocks]}; '
            f'scalar rows {len(self.rows)}; equality rows {len(self.eq_rows)} [{time.monotonic()-t0:.1f} s]')

    # -- canonical forms ---------------------------------------------------------------------------
    def canon(self, m):
        m = tuple(sorted(m))
        t = self._tmemo.get(m)
        if t is None:
            if m:
                best = None
                for x in set(m):
                    row = self.SUB[x]
                    cand = sorted(row[y] for y in m)
                    if best is None or cand < best:
                        best = cand
                t = tuple(best)
            else:
                t = m
            self._tmemo[m] = t
        c = self._cmemo.get(t)
        if c is None:
            if t:
                best = None
                for x in set(t):
                    row = self.SUB[x]
                    tr = [row[y] for y in t]
                    for h in self.maps:
                        cand = sorted(map(h.__getitem__, tr))
                        if best is None or cand < best:
                            best = cand
                c = tuple(best)
            else:
                c = t
            self._cmemo[t] = c
        return c

    def idx(self, m):
        c = self.canon(m)
        i = self.index.get(c)
        if i is None:
            i = len(self.list)
            self.index[c] = i
            self.list.append(c)
        return i

    def q_form(self, m):
        """Q(m): the moment of q*m, as {orbit: coefficient}.

        Exact integers whenever c is (it is: c = 2), so the certificate's accumulation needs no
        rounding here -- the checker builds the same form with 2 hard-coded."""
        cc = int(self.c) if float(self.c).is_integer() else self.c
        base = self.canon(m)
        if self._qmemo is not None:
            # Q(m) depends on m only through canon(m) (it is built from `base`), so at p = 19 the 363
            # forms the relaxation asks for are ~12 distinct ones.  Memoised only on the fast path: the
            # memo changes the ORDER in which new orbits are discovered, hence the orbit numbering, hence
            # the bytes of the file -- which must not move at 7 and 11.
            got = self._qmemo.get(base)
            if got is not None:
                return got
        d = {}
        for x in range(self.n):
            i = self.idx(base + (x,))
            d[i] = d.get(i, 0) + cc
            i = self.idx(base + (x, x))
            d[i] = d.get(i, 0) - cc
            row = self.ADD[x]
            for s in self.S:
                i = self.idx(base + (x, row[s]))
                d[i] = d.get(i, 0) - 1
        out = {k: v for k, v in d.items() if v}
        if self._qmemo is not None:
            self._qmemo[base] = out
        return out

    # -- the fast build (plan §19; p = 19) ----------------------------------------------------------
    def _fast_products(self, jobs, cache_dir):
        """the product table, across forked workers, with a disk cache of the whole build.

        If this process dies at any instant the relaunch redoes: everything, unless --cache-dir was
        given and the cache was written, in which case it redoes only the reload (seconds).
        Resume command: the same command line; the cache is keyed on (p, c) and reloaded silently."""
        n, R, half = self.n, self.R, self.half
        cache = os.path.join(cache_dir, f'build-p{self.p}-c{int(self.c)}.npz') if cache_dir else None
        if cache and os.path.exists(cache):
            z = np.load(cache)
            if int(z['p']) != self.p or int(z['nhalf']) != len(half):
                raise SystemExit(f'{cache}: built for p = {int(z["p"])}, not {self.p}. Remove it or use '
                                 f'another --cache-dir.')
            self.list = [dec_mono(int(v), n) for v in z['orbits']]
            self.index = {m: i for i, m in enumerate(self.list)}
            assert self.list[0] == (), 'the cached orbit 0 is not the constant monomial'
            Fh = z['Fh']
            self._qmemo = {dec_mono(int(b), n): dict(zip(z['qk'][z['qp'][i]:z['qp'][i + 1]].tolist(),
                                                         z['qv'][z['qp'][i]:z['qp'][i + 1]].tolist()))
                           for i, b in enumerate(z['qb'])}
            say(f'build cache reloaded from {cache}: {len(self.list)} orbits, '
                f'{Fh.shape[0]}x{Fh.shape[1]} product table, {len(self._qmemo)} q forms')
        else:
            # a sample check of the two symmetries the table's shape rests on, BEFORE using them
            self._check_symmetries()
            _FST['B'] = self
            ctx = multiprocessing.get_context('fork')
            chunks = [list(range(i, R, jobs)) for i in range(min(jobs, R))]
            t0 = time.monotonic()
            with ctx.Pool(processes=len(chunks)) as pool:
                pieces = pool.map(_product_chunk, chunks)
            _FST.clear()
            enc = np.empty((R * (R + 1) // 2, len(half)), dtype=np.int64)
            for part in pieces:
                for ia, arr in part:
                    enc[self.pairidx(ia, ia):self.pairidx(ia, R - 1) + 1] = arr
            say(f'  {len(chunks)} forked workers built {enc.size} canonical forms '
                f'[{time.monotonic()-t0:.1f} s]')
            # orbit numbering: 0 is the constant, then every canonical form the table holds, sorted by
            # (degree, tuple).  Deterministic and independent of the order the workers finished in.
            uniq = np.unique(enc)
            self.list = [()] + sorted((dec_mono(int(v), n) for v in uniq), key=lambda m: (len(m), m))
            self.index = {m: i for i, m in enumerate(self.list)}
            orb = np.array([self.index[dec_mono(int(v), n)] for v in uniq], dtype=np.int32)
            Fh = orb[np.searchsorted(uniq, enc)]           # uniq is sorted, every entry of enc is in it
        self._Fh = Fh
        # F[i][j] as the plain sequence the exact accumulation indexes, sharing ONE array per pair
        import array as _array
        rowarr = [_array.array('i', Fh[pi][self.hidx].tolist()) for pi in range(Fh.shape[0])]
        self.F = [[rowarr[self.pairidx(min(i, j), max(i, j))] for j in range(self.R)]
                  for i in range(self.R)]
        if cache and not os.path.exists(cache):
            self._save_cache(cache)

    def pairidx(self, ia, ib):
        """the row of the half-range table holding the pair (ia, ib) with ia <= ib."""
        R = self.R
        return ia * R - ia * (ia - 1) // 2 + (ib - ia)

    def _check_symmetries(self, trials=300):
        """the two identities the quarter-size table rests on, on random (ia, ib, t).  A wrong table
        could only WEAKEN U (plan §C.3) -- this guards the bound's quality, not its validity."""
        import random
        rng = random.Random(20260921)
        for _ in range(trials):
            ia, ib, t = rng.randrange(self.R), rng.randrange(self.R), rng.randrange(self.n)
            a, b, mt = self.reps[ia], self.reps[ib], self.SUB[t][0]
            f1 = self.canon(a + tuple(self.ADD[t][y] for y in b))
            if f1 != self.canon(b + tuple(self.ADD[t][y] for y in a)):
                raise SystemExit('F[ib][ia][t] != F[ia][ib][t]: the product table\'s swap symmetry fails')
            if f1 != self.canon(a + tuple(self.ADD[mt][y] for y in b)):
                raise SystemExit('F[ia][ib][-t] != F[ia][ib][t]: the table\'s shift symmetry fails')
        say(f'  the two product-table symmetries hold on {trials} random (ia, ib, t)')

    def _save_cache(self, cache):
        os.makedirs(os.path.dirname(cache), exist_ok=True)
        qb, qk, qv, qp = [], [], [], [0]
        for base, d in self._qmemo.items():
            qb.append(enc_mono(base, self.n))
            qk.extend(d.keys())
            qv.extend(d.values())
            qp.append(len(qk))
        tmp = cache + '.part'
        np.savez(tmp, p=self.p, nhalf=len(self.half), Fh=self._Fh,
                 orbits=np.array([enc_mono(m, self.n) for m in self.list], dtype=np.int64),
                 qb=np.array(qb, dtype=np.int64), qk=np.array(qk, dtype=np.int32),
                 qv=np.array(qv, dtype=np.int64), qp=np.array(qp, dtype=np.int64))
        os.replace(tmp + '.npz', cache)
        say(f'build cache written: {cache} ({os.path.getsize(cache)/1e6:.0f} MB)')

    def _moment_blocks_fast(self):
        """the moment blocks' NAMES and sizes only: their entries are never materialised as tuples
        (52 million of them at p = 19).  assemble_fast reads self._Fh instead."""
        self.blocks.append(('M2[u=0]', self.R + 1, None))
        for u in self.ureps:
            self.blocks.append((f'M2[u={u}]', self.R, None))

    def _q_blocks_fast(self):
        """the q localiser, grouped by canon((0, t)): Q((0,t)) depends on t only through it, and at
        p = 19 the 361 shifts fall into a dozen classes."""
        n = self.n
        cls = {}
        for t in range(n):
            cls.setdefault(self.canon((0, t)), []).append(t)
        acc = {}
        for base, ts in cls.items():
            w = len(ts) / n
            for k, v in self.q_form(base).items():
                acc[k] = acc.get(k, 0.0) + w * v
        ent = ([(0, 0, k, w) for k, w in self.Q_empty.items()]
               + [(0, 1, k, w) for k, w in self.Q_0.items()]
               + [(1, 1, k, w) for k, w in acc.items()])
        self.blocks.append(('locq[u=0]', 2, ent))
        for u in self.ureps:
            cosv = self.cosv[u]
            acc = {}
            for base, ts in cls.items():
                w = float(cosv[ts].sum())
                if w == 0.0:
                    continue
                for k, v in self.q_form(base).items():
                    acc[k] = acc.get(k, 0.0) + w * v
            self.rows.append(('locq', u, {k: v for k, v in acc.items() if abs(v) > 1e-13}))

    # -- the relaxation ----------------------------------------------------------------------------
    def _moment_blocks(self):
        n, R, F = self.n, self.R, self.F
        ent = [(0, 0, self.idx(()), 1.0)]
        for ia, a in enumerate(self.reps):
            ent.append((0, 1 + ia, self.idx(a), 1.0))
        for ia in range(R):
            for ib in range(ia, R):
                acc = {}
                for k in F[ia][ib]:
                    acc[k] = acc.get(k, 0.0) + 1.0 / n
                ent += [(1 + ia, 1 + ib, k, w) for k, w in acc.items()]
        self.blocks.append(('M2[u=0]', R + 1, ent))
        for u in self.ureps:
            cosv = self.cosv[u]
            ent = []
            for ia in range(R):
                for ib in range(ia, R):
                    acc = {}
                    for k, w in zip(F[ia][ib], cosv.tolist()):
                        acc[k] = acc.get(k, 0.0) + w
                    ent += [(ia, ib, k, w) for k, w in acc.items() if abs(w) > 1e-13]
            self.blocks.append((f'M2[u={u}]', R, ent))

    def _q_blocks(self):
        n = self.n
        acc = {}
        for t in range(n):
            for k, w in self.Q_t[t].items():
                acc[k] = acc.get(k, 0.0) + w / n
        ent = ([(0, 0, k, w) for k, w in self.Q_empty.items()]
               + [(0, 1, k, w) for k, w in self.Q_0.items()]
               + [(1, 1, k, w) for k, w in acc.items()])
        self.blocks.append(('locq[u=0]', 2, ent))
        for u in self.ureps:
            cosv = self.cosv[u]
            acc = {}
            for t in range(n):
                cw = cosv[t]
                for k, w in self.Q_t[t].items():
                    acc[k] = acc.get(k, 0.0) + w * cw
            self.rows.append(('locq', u, acc))

    def _box_rows(self):
        """y(m) >= 0 for every orbit, and y(m minus x) - y(m) >= 0 for every orbit and every point of it.

        Built by decreasing degree so that a sub-monomial discovered on the way gets its own rows: the
        row set is then closed downward, which is what lets the solver's multipliers and the cascade
        work on the same family."""
        for deg in (4, 3, 2, 1):
            for m in [m for m in list(self.list) if len(m) == deg]:
                k = self.idx(m)
                self.rows.append(('nonneg', (list(m), []), {k: 1.0}))
                for x in sorted(set(m)):
                    mm = list(m)
                    mm.remove(x)
                    k2 = self.idx(tuple(mm))
                    if k2 != k:
                        self.rows.append(('le', (mm, [x]), {k2: 1.0, k: -1.0}))


# ----------------------------------------------------------------------------- solve

def assemble_reference(B, args):
    """the constraint matrix, one Python tuple per nonzero.  The path the certificates at 7 and 11
    came from; `assemble_fast` is the same matrix built in numpy, and --twin-build compares them."""
    rows, cols, vals, bvec, cones = [], [], [], [], []
    r = 0
    if B.eq_rows:
        for e in B.eq_rows:
            b0 = 0.0
            for k, w in e.items():
                if k == 0:
                    b0 -= w
                else:
                    rows.append(r); cols.append(k - 1); vals.append(w)
            bvec.append(b0); r += 1
    row_off = r
    for _, _, e in B.rows:                       # expr >= 0  <=>  s = expr = b - A x
        b0 = 0.0
        for k, w in e.items():
            if k == 0:
                b0 += w
            else:
                rows.append(r); cols.append(k - 1); vals.append(-w)
        bvec.append(b0); r += 1
    SQ2 = math.sqrt(2.0)
    block_off = []
    for name, d, ent in B.blocks:
        block_off.append(r)
        if args.solver == 'clarabel':
            def pos(i, j, d=d):
                return j * (j + 1) // 2 + i               # upper triangle, column major
        else:
            def pos(i, j, d=d):
                return i * d - i * (i - 1) // 2 + (j - i)  # SCS: lower triangle, column major
        bb = np.zeros(d * (d + 1) // 2)
        for i, j, k, w in ent:
            if i > j:
                i, j = j, i
            sc = 1.0 if i == j else SQ2
            if k == 0:
                bb[pos(i, j)] += sc * w
            else:
                rows.append(r + pos(i, j)); cols.append(k - 1); vals.append(-sc * w)
        bvec.extend(bb.tolist()); r += d * (d + 1) // 2
    A = sp.csc_matrix((vals, (rows, cols)), shape=(r, B.K - 1))
    A.sum_duplicates()
    b = np.array(bvec)
    qobj = np.zeros(B.K - 1)
    qobj[B.idx((0,)) - 1] = -float(B.n)
    say(f'assembled: {A.shape}, nnz {A.nnz} [{time.monotonic()-T0:.1f} s]')
    return A, b, qobj, block_off, row_off


def assemble_and_solve(B, args):
    A, b, qobj, block_off, row_off = assemble_reference(B, args)
    t1 = time.monotonic()
    if args.solver == 'clarabel':
        import clarabel
        cn = []
        if B.eq_rows:
            cn.append(clarabel.ZeroConeT(len(B.eq_rows)))
        if B.rows:
            cn.append(clarabel.NonnegativeConeT(len(B.rows)))
        for _, d, _ in B.blocks:
            cn.append(clarabel.PSDTriangleConeT(d))
        st = clarabel.DefaultSettings()
        st.verbose = not args.quiet
        st.max_iter = 400
        st.max_threads = args.threads
        sol = clarabel.DefaultSolver(sp.csc_matrix((B.K - 1, B.K - 1)), qobj, A, b, cn, st).solve()
        out = dict(value=-sol.obj_val, dual_value=-sol.obj_val_dual, status=str(sol.status),
                   iterations=sol.iterations, solver=f'clarabel {clarabel.__version__}')
        zdual = np.array(sol.z)
    else:
        import scs
        cone = dict(z=len(B.eq_rows), l=len(B.rows), s=[d for _, d, _ in B.blocks])
        sv = scs.SCS(dict(A=A, b=b, c=qobj), cone, eps_abs=args.eps, eps_rel=args.eps,
                     max_iters=args.max_iters, verbose=not args.quiet)
        res = sv.solve()
        out = dict(value=-res['info']['pobj'], dual_value=-res['info']['dobj'],
                   status=res['info']['status'], iterations=res['info']['iter'],
                   solver=f'scs {scs.__version__}')
        zdual = np.array(res['y'])
    out['solve_s'] = round(time.monotonic() - t1, 1)
    out['threads'] = args.threads
    out['solver_eps'] = args.eps
    return out, zdual, block_off, row_off


# ----------------------------------------------------------------------- the fast assembly and the chunked solve

def assemble_fast(B, args):
    """the constraint matrix built straight from the half-range product table, in numpy.

    The reference path materialises one Python tuple per nonzero -- 52 million of them at p = 19, about
    4 GB of tuples before scipy sees a number.  This one never leaves numpy.  It is the SAME matrix:
    --twin-build compares the two at p = 7 and p = 11, entry by entry.

    Both symmetries are used here: the table holds only t <= -t, and a shift t != 0 is counted twice
    because F(a,a',-t) = F(a,a',t) and cos(2*pi*<u,-t>/p) = cos(2*pi*<u,t>/p)."""
    n, R, nh = B.n, B.R, len(B.half)
    SQ2 = math.sqrt(2.0)
    npair = R * (R + 1) // 2
    t0 = time.monotonic()
    mult = np.array([1.0 if t == 0 else 2.0 for t in B.half])
    halfarr = np.array(B.half)
    NB = 1 + len(B.ureps)
    Wm = np.empty((NB, nh))
    Wm[0] = mult / n
    for bi, u in enumerate(B.ureps):
        Wm[bi + 1] = mult * B.cosv[u][halfarr]

    IA = np.empty(npair, dtype=np.int64)
    IB = np.empty(npair, dtype=np.int64)
    for ia in range(R):
        s = B.pairidx(ia, ia)
        IA[s:s + R - ia] = ia
        IB[s:s + R - ia] = np.arange(ia, R)

    UK = np.empty(npair * nh, dtype=np.int32)
    CO = np.empty((NB, npair * nh))
    cnt = np.empty(npair, dtype=np.int64)
    Fh, m = B._Fh, 0
    for pi in range(npair):
        f = Fh[pi]
        order = np.argsort(f, kind='stable')
        sf = f[order]
        starts = np.concatenate(([0], np.flatnonzero(sf[1:] != sf[:-1]) + 1))
        g = starts.size
        UK[m:m + g] = sf[starts]
        CO[:, m:m + g] = np.add.reduceat(Wm[:, order], starts, axis=1)
        cnt[pi] = g
        m += g
    UK, CO = UK[:m], CO[:, :m]
    say(f'  grouped {npair} representative pairs into {m} (pair, orbit) cells '
        f'[{time.monotonic()-t0:.1f} s]')

    Rw, Cw, Vw, bparts = [], [], [], []
    r = len(B.rows)                     # the scalar rows come first (no equality rows on this path)
    row_off, block_off = 0, []
    # -- the scalar rows
    rr, rc, rv, rb = [], [], [], np.zeros(len(B.rows))
    for i, (_, _, e) in enumerate(B.rows):
        for k, w in e.items():
            if k == 0:
                rb[i] += w
            else:
                rr.append(i); rc.append(k - 1); rv.append(-w)
    Rw.append(np.array(rr, dtype=np.int64)); Cw.append(np.array(rc, dtype=np.int64))
    Vw.append(np.array(rv)); bparts.append(rb)
    repcol = np.array([B.idx(a) for a in B.reps], dtype=np.int64)

    for b in range(NB):
        d = R + 1 if b == 0 else R
        ioff = 1 if b == 0 else 0
        block_off.append(r)
        i, j = IA + ioff, IB + ioff
        posv = i * d - i * (i - 1) // 2 + (j - i)
        scv = np.where(IA == IB, 1.0, SQ2)
        rowv = np.repeat(posv, cnt)
        valv = np.repeat(scv, cnt) * CO[b]
        isconst = UK == 0                       # (never fires: a product of two representatives has
        keep = ~isconst                         #  degree >= 2, so it is never the constant monomial)
        if b:
            keep &= np.abs(CO[b]) > 1e-13       # the reference drops these from the character blocks
        bb = np.zeros(d * (d + 1) // 2)
        if isconst.any():
            np.add.at(bb, rowv[isconst], valv[isconst])
        Rw.append(rowv[keep] + r); Cw.append((UK[keep] - 1).astype(np.int64)); Vw.append(-valv[keep])
        if b == 0:                              # the constant row of the trivial-character block
            bb[0] += 1.0
            p0 = np.arange(1, R + 1)            # pos(0, 1 + ia) = 1 + ia
            Rw.append(p0 + r); Cw.append(repcol - 1); Vw.append(np.full(R, -SQ2))
        bparts.append(bb)
        r += d * (d + 1) // 2
    # -- the small q block, entry by entry
    for name, d, ent in B.blocks[NB:]:
        block_off.append(r)
        bb = np.zeros(d * (d + 1) // 2)
        er, ec, ev = [], [], []
        for i, j, k, w in ent:
            if i > j:
                i, j = j, i
            sc = 1.0 if i == j else SQ2
            pos = i * d - i * (i - 1) // 2 + (j - i)
            if k == 0:
                bb[pos] += sc * w
            else:
                er.append(r + pos); ec.append(k - 1); ev.append(-sc * w)
        Rw.append(np.array(er, dtype=np.int64)); Cw.append(np.array(ec, dtype=np.int64))
        Vw.append(np.array(ev)); bparts.append(bb)
        r += d * (d + 1) // 2

    A = sp.csc_matrix((np.concatenate(Vw), (np.concatenate(Rw), np.concatenate(Cw))),
                      shape=(r, B.K - 1))
    A.sum_duplicates()
    bv = np.concatenate(bparts)
    qobj = np.zeros(B.K - 1)
    qobj[B.idx((0,)) - 1] = -float(B.n)
    say(f'assembled: {A.shape}, nnz {A.nnz} [{time.monotonic()-T0:.1f} s, {rss_mb()} MB]')
    return A, bv, qobj, block_off, row_off


def solve_scs(B, A, bv, qobj, args):
    """SCS, optionally in warm-started chunks with the iterate saved after every one.

    If this process dies at any instant the relaunch redoes: the build (seconds, from --cache-dir),
    the assembly, and the iterations since the last checkpoint (at most --chunk-iters).
    Resume command: the same command line -- --solve-ckpt is reloaded when it exists."""
    import scs
    cone = dict(z=0, l=len(B.rows), s=[d for _, d, _ in B.blocks])
    kw = dict(eps_abs=args.eps, eps_rel=args.eps, verbose=False)
    if args.linear_solver:
        kw['linear_solver'] = args.linear_solver
    t1 = time.monotonic()
    if not args.chunk_iters:
        sv = scs.SCS(dict(A=A, b=bv, c=qobj), cone, max_iters=args.max_iters, **kw)
        res = sv.solve()
        done, info = int(res['info']['iter']), res['info']
    else:
        x0 = y0 = s0 = None
        done = 0
        if args.solve_ckpt and os.path.exists(args.solve_ckpt):
            z = np.load(args.solve_ckpt)
            x0, y0, s0, done = z['x'], z['y'], z['s'], int(z['iters'])
            print(f'[scs] RESUMED from {args.solve_ckpt}: {done} iterations already done', flush=True)
        sv = scs.SCS(dict(A=A, b=bv, c=qobj), cone, max_iters=args.chunk_iters, **kw)
        chunks, res = 0, None
        while done < args.max_iters:
            t2 = time.monotonic()
            res = (sv.solve(warm_start=True, x=x0, y=y0, s=s0) if x0 is not None else sv.solve())
            info = res['info']
            x0, y0, s0 = res['x'], res['y'], res['s']
            done += int(info['iter']); chunks += 1
            if args.solve_ckpt:
                os.makedirs(os.path.dirname(os.path.abspath(args.solve_ckpt)), exist_ok=True)
                np.savez(args.solve_ckpt + '.part', x=x0, y=y0, s=s0, iters=done)
                os.replace(args.solve_ckpt + '.part.npz', args.solve_ckpt)
            dt = time.monotonic() - t2
            print(f'[scs] chunk {chunks}: +{info["iter"]} it ({done} total), {dt:.0f} s '
                  f'({dt/max(1,int(info["iter"])):.3f} s/it, {args.linear_solver or "default"}), '
                  f'pobj {-info["pobj"]:.6f} dobj {-info["dobj"]:.6f} res_pri {info["res_pri"]:.2e} '
                  f'res_dual {info["res_dual"]:.2e} gap {info["gap"]:.2e} status {info["status"]}',
                  flush=True)
            st = info['status'].lower()
            # SCS calls every chunk that reaches its cap "solved (inaccurate - reached max_iters)" --
            # the cap IS the chunk size -- so only a clean "solved" ends the loop.
            if st.startswith('solved') and 'inaccurate' not in st:
                break
            if 'reached max_iters' not in st and not st.startswith('solved'):
                raise SystemExit(f'[scs] status {info["status"]} -- stopping without a value')
            if args.stop_after_chunks and chunks >= args.stop_after_chunks:
                raise SystemExit(f'[scs] stopping after {chunks} chunks (control); the checkpoint '
                                 f'{args.solve_ckpt} holds {done} iterations. Resume: the same command.')
    out = dict(value=-info['pobj'], dual_value=-info['dobj'], status=info['status'],
               iterations=done, solver=f'scs {scs.__version__}',
               solve_s=round(time.monotonic() - t1, 1), threads=args.threads, solver_eps=args.eps)
    return out, np.array(res['y'])


# ----------------------------------------------------------------------------- round to an exact certificate

def dual_block(B, zdual, block_off, bi, solver):
    name, d, _ = B.blocks[bi]
    r0 = block_off[bi]
    Z = np.zeros((d, d))
    SQ2 = math.sqrt(2.0)
    for j in range(d):
        for i in range(j + 1):
            if solver == 'clarabel':
                v = zdual[r0 + j * (j + 1) // 2 + i]
            else:
                v = zdual[r0 + i * d - i * (i - 1) // 2 + (j - i)]
            Z[i, j] = Z[j, i] = v if i == j else v / SQ2
    return Z


def positive_definite(M):
    """Bareiss fraction-free elimination: the k-th pivot IS the k-th leading principal minor, so by
    Sylvester every pivot positive is exactly positive definiteness.  The checker re-does this."""
    A = [row[:] for row in M]
    prev = 1
    d = len(A)
    for k in range(d):
        piv = A[k][k]
        if piv <= 0:
            return False
        for i in range(k + 1, d):
            Ai, Ak = A[i], A[k]
            a = Ai[k]
            for j in range(k + 1, d):
                Ai[j] = (Ai[j] * piv - a * Ak[j]) // prev
        prev = piv
    return True


def round_block(Z, Dg, shift, DEN):
    """float dual block -> integer matrix over DEN:  round(DEN * Dg (Z + sh I) Dg).

    The shift is applied in the SOLVER's (well-scaled) basis and only then rescaled by the congruence
    Dg that turns the solver's normalisation into §C.2's -- the other order cost 0.9 in U at p = 7
    (plan §T.2)."""
    d = len(Z)
    sh = shift * max(float(np.max(np.diag(Z))), 0.0)
    Zs = Dg @ (Z + sh * np.eye(d)) @ Dg
    return [[int(round(Zs[i, j] * DEN)) for j in range(d)] for i in range(d)]


def make_certificate(B, zdual, block_off, row_off, digits, wdigits, shift, solver,
                     arbitrary_weights=None):
    """the whole rounding: blocks, weights, the solver's row multipliers, the cascade, U.

    Returns (cert, info).  `cert` is None when a block came out not positive definite.
    """
    t0 = time.monotonic()
    n, R, K = B.n, B.R, B.K
    DEN, DW = 10 ** digits, 10 ** wdigits
    LAM = DEN * DW * DW                      # the one scale of the file: U = U_num / LAM
    names = [nm for nm, _, _ in B.blocks]
    pd_failures = []

    # ---- the blocks, rounded ----------------------------------------------------------------------
    R0 = round_block(dual_block(B, zdual, block_off, names.index('M2[u=0]'), solver),
                     np.diag([1.0] + [1.0 / n] * R), shift, DEN)
    if any(any(row) for row in R0) and not positive_definite(R0):
        pd_failures.append('M2[u=0]')
    char = []                                # (u, Rb, mu)
    mu_of = {}
    for ri, (kind, payload, _) in enumerate(B.rows):
        if kind == 'locq':
            mu_of[payload] = max(0.0, float(zdual[row_off + ri]))
    for u in B.ureps:
        Rb = round_block(dual_block(B, zdual, block_off, names.index(f'M2[u={u}]'), solver),
                         np.eye(R) / math.sqrt(n), shift, DEN)
        if any(any(row) for row in Rb) and not positive_definite(Rb):
            pd_failures.append(f'M2[u={u}]')
        char.append((u, Rb, int(round(mu_of.get(u, 0.0) / n * DEN))))
    q0 = [[0, 0], [0, 0]]
    if 'locq[u=0]' in names:
        q0 = round_block(dual_block(B, zdual, block_off, names.index('locq[u=0]'), solver),
                         np.diag([1.0, 1.0 / n]), shift, DEN)
        if any(any(row) for row in q0) and not positive_definite(q0):
            pd_failures.append('locq[u=0]')
    if pd_failures:
        return None, dict(pd_failures=pd_failures, exact_s=round(time.monotonic() - t0, 2))

    # ---- the weight vectors ------------------------------------------------------------------------
    # [c, w_0, ..., w_{n-1}].  The producer takes rounded cosines and sines because that makes U small;
    # soundness never reads them (plan §C.3), which the --arbitrary-weights control demonstrates.
    weights = [[1] + [1] * n]
    wpair = {}
    for u in B.ureps:
        ua, ub = divmod(u, B.p)
        th = 2 * np.pi * np.array([(ua * (z // B.p) + ub * (z % B.p)) % B.p for z in range(n)]) / B.p
        wpair[u] = len(weights)
        weights.append([0] + [int(round(v * DW)) for v in np.cos(th)])
        weights.append([0] + [int(round(v * DW)) for v in np.sin(th)])
    if arbitrary_weights is not None:
        rng = np.random.default_rng(arbitrary_weights)
        weights = [[int(v) for v in rng.integers(-DW, DW + 1, size=n + 1)] for _ in weights]

    _kap = {}

    def kappa(wi):
        """kappa(t) = sum_x w_x w_{x+t}, the checker's convention (plan §R.8 item 1)."""
        got = _kap.get(wi)
        if got is None:
            w = weights[wi][1:]
            got = [0] * n
            for x in range(n):
                wx = w[x]
                if wx:
                    row = B.ADD[x]
                    for t in range(n):
                        got[t] += wx * w[row[t]]
            _kap[wi] = got
        return got

    # ---- the blocks exactly as they will be written -------------------------------------------------
    sc = DW * DW                             # lifts the all-ones blocks onto the common scale DEN*DW^2
    out_blocks = []
    if any(any(row) for row in R0):
        out_blocks.append({'times': '1', 'weights': [0], 'R': [[v * sc for v in row] for row in R0]})
    for u, Rb, mu in char:
        i0, d = wpair[u], len(Rb)
        if any(any(r) for r in Rb):
            out_blocks.append({'times': '1', 'weights': [i0, i0 + 1], 'u': list(divmod(u, B.p)),
                               'R': [[1] + [0] * d] + [[0] + Rb[i] for i in range(d)]})
        if mu > 0:
            out_blocks.append({'times': 'q', 'weights': [i0, i0 + 1], 'u': list(divmod(u, B.p)),
                               'R': [[1, 0], [0, mu]]})
    if any(any(r) for r in q0):
        out_blocks.append({'times': 'q', 'weights': [0], 'R': [[v * sc for v in row] for row in q0]})

    # ---- the exact linear form of the blocks: ONE formula, the identity (*) of §C.2, per block and
    # weight vector.  Writing it three ways (trivial / character / q) is what hid a missing term --
    # the padded constant row R[0][0]*c^2, invisible while the real weights have c = 0 and caught by
    # the arbitrary-weights control (plant 12).
    def Yval(times, m):
        return {B.idx(m): 1} if times == '1' else B.q_form(m)

    acc = [0] * K
    for blk in out_blocks:
        times, Rm = blk['times'], blk['R']
        reps = B.reps if times == '1' else [(0,)]
        assert len(Rm) == 1 + len(reps)
        for wi in blk['weights']:
            c0, sig, kap = weights[wi][0], sum(weights[wi][1:]), kappa(wi)
            if c0:
                for k, v in Yval(times, ()).items():
                    acc[k] += Rm[0][0] * c0 * c0 * v
                for j, a in enumerate(reps):
                    z = 2 * Rm[0][1 + j] * c0 * sig
                    if z:
                        for k, v in Yval(times, a).items():
                            acc[k] += z * v
            for i in range(len(reps)):
                Ri = Rm[1 + i]
                for j in range(len(reps)):
                    z = Ri[1 + j]
                    if not z:
                        continue
                    if times == '1':
                        Fi = B.F[i][j]
                        for t in range(n):
                            kt = kap[t]
                            if kt:
                                acc[Fi[t]] += z * kt
                    else:                     # reps = [phi_0], so the product is (0, t)
                        for t in range(n):
                            kt = kap[t] * z
                            if kt:
                                for k, v in B.Q_t[t].items():
                                    acc[k] += kt * v

    # ---- the rows: the solver's own multipliers, clipped at zero ------------------------------------
    lam = {}                                  # (tuple(A), tuple(B)) -> integer multiplier over LAM
    for ri, (kind, payload, _) in enumerate(B.rows):
        if kind in ('nonneg', 'le'):
            li = int(round(float(zdual[row_off + ri]) * DEN))
            if li > 0:
                key = (tuple(payload[0]), tuple(payload[1]))
                lam[key] = lam.get(key, 0) + li * DW * DW

    # ---- what is still owed, and the cascade (§C.4) --------------------------------------------------
    # need = the coefficient vector of  (-scale*n*y([0]) - blocks - rows); U_num is minus its constant.
    need = {}
    for k in range(K):
        if acc[k]:
            need[k] = need.get(k, 0) - acc[k]
    need[B.idx((0,))] = need.get(B.idx((0,)), 0) - LAM * n
    for (A, Bb), li in lam.items():
        for m, sign in box_terms(A, Bb):
            k = B.idx(m)
            need[k] = need.get(k, 0) - sign * li
    cascaded = 0
    for deg in (4, 3, 2, 1):
        for k in [k for k, v in list(need.items()) if v and len(B.list[k]) == deg]:
            v = need[k]
            m = B.list[k]
            if v > 0:
                key = (tuple(m), ())
                lam[key] = lam.get(key, 0) + v
            else:
                x = m[-1]
                key = (tuple(m[:-1]), (x,))
                lam[key] = lam.get(key, 0) - v
                par = B.idx(m[:-1])
                need[par] = need.get(par, 0) + v
                cascaded += 1
            need[k] = 0
    U_num = -need.get(B.idx(()), 0)
    leftover = {k: v for k, v in need.items() if v and k != B.idx(())}
    assert not leftover, f'the cascade left {len(leftover)} coefficients unpaid'

    cert = {
        'format': FORMAT, 'p': B.p, 'scale': LAM, 'U_num': U_num, 'spec': SPEC,
        'producer': {
            'tool': 'tools/fs66_b1_cert_make.py', 'tool_sha256': sha256_of(os.path.abspath(__file__)),
            'utc': utc_now(), 'digits': digits, 'weight_digits': wdigits, 'shift': shift,
            'c': B.c, 'relaxation': 'minimal (moment blocks + q localiser + box rows)',
            'note': 'provenance only; nothing here is checked, and nothing here is on the trust surface',
        },
        'weights': weights,
        'blocks': out_blocks,
        'rows': [[list(A), list(Bb), li] for (A, Bb), li in sorted(lam.items()) if li],
    }
    info = dict(pd_failures=[], U_num=U_num, scale=LAM, U_float=float(Fraction(U_num, LAM)),
                U_dec=dec_str(U_num, LAM), rows=len(cert['rows']), cascaded=cascaded,
                blocks=len(cert['blocks']), exact_s=round(time.monotonic() - t0, 2))
    return cert, info


def box_terms(A, Bb):
    out = []
    k = len(Bb)
    A = tuple(A)
    for mask in range(1 << k):
        sub = tuple(Bb[i] for i in range(k) if (mask >> i) & 1)
        out.append((A + sub, -1 if bin(mask).count('1') & 1 else 1))
    return out


# ----------------------------------------------------------------------------- the scan

_STATE = {}


def _attempt(job):
    digits, shift = job
    B, zdual, block_off, row_off, solver, wdigits, arb = (
        _STATE['B'], _STATE['z'], _STATE['bo'], _STATE['ro'], _STATE['solver'],
        _STATE['wdigits'], _STATE['arb'])
    cert, info = make_certificate(B, zdual, block_off, row_off, digits, wdigits, shift, solver, arb)
    info.update(digits=digits, shift=shift)
    return cert, info


def run_scan(B, zdual, block_off, row_off, args, shifts, digitlist):
    """the independent rounding attempts of plan §R'.4, one per (shift, D), across the cores.

    multiprocessing's `fork` context on purpose: Python 3.14's default is `forkserver`, which
    re-imports this module in the worker and leaves _STATE empty (CLAUDE.md § Toolchain)."""
    _STATE.update(B=B, z=zdual, bo=block_off, ro=row_off, solver=args.solver,
                  wdigits=args.weight_digits, arb=args.arbitrary_weights)
    jobs = [(d, s) for s in shifts for d in digitlist]
    ctx = multiprocessing.get_context('fork')
    t0 = time.monotonic()
    with ctx.Pool(processes=min(args.jobs, len(jobs))) as pool:
        out = pool.map(_attempt, jobs)
    say(f'scan: {len(jobs)} rounding attempts on {min(args.jobs, len(jobs))} workers '
        f'[{time.monotonic()-t0:.1f} s wall]')
    return out


# ----------------------------------------------------------------------------- records

def record(args, solve_info, info, cert_path, cert_sha, kept=None):
    rec = {
        'kind': 'fs66-b1', 'record_version': 1, 'utc': utc_now(),
        'command': 'python3 ' + ' '.join([os.path.relpath(os.path.abspath(sys.argv[0]), REPO)] + sys.argv[1:]),
        'tool_sha256': sha256_of(os.path.abspath(__file__)),
        'p': args.p, 'c': args.c,
        'relaxation': ('minimal' if not (args.drop_q or args.pure or args.edge_row) else
                       'control: ' + ' '.join(k for k, v in (('drop-q', args.drop_q),
                                                             ('edge-row', args.edge_row),
                                                             ('pure', args.pure)) if v)),
        'solver': solve_info['solver'], 'solver_eps': solve_info['solver_eps'],
        'threads': solve_info['threads'], 'float_value': solve_info['value'],
        'float_dual': solve_info['dual_value'], 'status': solve_info['status'],
        'iterations': solve_info['iterations'], 'solve_s': solve_info['solve_s'], 'rss_mb': rss_mb(),
        'digits': (info or {}).get('digits'), 'weight_digits': args.weight_digits if info else None,
        'shift': (info or {}).get('shift'),
        'pd_failures': (info or {}).get('pd_failures'),
        'U_num': (info or {}).get('U_num'), 'scale': (info or {}).get('scale'),
        'U_float': (info or {}).get('U_float'), 'rows': (info or {}).get('rows'),
        'blocks': (info or {}).get('blocks'), 'cascaded': (info or {}).get('cascaded'),
        'exact_s': (info or {}).get('exact_s'),
        'arbitrary_weights_seed': args.arbitrary_weights,
        'scan_kept': kept,
        'cert': cert_path, 'cert_sha256': cert_sha,
        'machine': f'{platform.node()} {platform.machine()}', 'python': platform.python_version(),
        'trust': ('float reading (untrusted)' if info is None
                  else 'prototype bound (producer\'s own arithmetic, untrusted)'),
    }
    if args.record:
        with open(args.record, 'a') as f:
            f.write(json.dumps(rec) + '\n')
    return rec


# ----------------------------------------------------------------------------- the two controls

def _linear_forms(B, A, bv, vals):
    """every row of the relaxation evaluated at one moment functional, in the row order the SOLVER
    sees.  `vals` maps a canonical monomial to a number, so the same functional can be fed to two
    builds that number their orbits differently."""
    y = np.array([vals[m] for m in B.list[1:]])
    return bv - A @ y


def twin_build(args):
    """control: the fast build against the reference build of the SAME relaxation.

    Orbit numbering differs between the two on purpose -- the fast path numbers deterministically by
    (degree, tuple), the reference by order of discovery -- so nothing is compared by index.  Compared
    instead: the orbit sets, the product table and the q forms as canonical monomials, the scalar rows
    as (kind, payload) -> {canonical monomial: coefficient}, and every row of the assembled matrix
    evaluated at one pseudo-random moment functional."""
    import random
    p = args.p
    print(f'--- twin-build at p = {p}: reference against fast ---', flush=True)
    t0 = time.monotonic()
    ref = Build(p, c=args.c)
    fast = Build(p, c=args.c, fast=True, jobs=args.build_jobs, cache_dir=None)
    bad = []
    if set(ref.list) != set(fast.list):
        bad.append(f'orbit sets differ: reference {len(ref.list)}, fast {len(fast.list)}, '
                   f'{len(set(ref.list) ^ set(fast.list))} symmetric difference')
    if ref.list[0] != () or fast.list[0] != ():
        bad.append('orbit 0 is not the constant monomial in one of the builds')
    nbad = sum(1 for ia in range(ref.R) for ib in range(ref.R) for t in range(ref.n)
               if ref.list[ref.F[ia][ib][t]] != fast.list[fast.F[ia][ib][t]])
    if nbad:
        bad.append(f'product table: {nbad} of {ref.R*ref.R*ref.n} entries differ')
    for nm, a, b in (('Q_empty', ref.Q_empty, fast.Q_empty), ('Q_0', ref.Q_0, fast.Q_0)):
        if {ref.list[k]: v for k, v in a.items()} != {fast.list[k]: v for k, v in b.items()}:
            bad.append(f'{nm} differs')
    nq = sum(1 for t in range(ref.n)
             if {ref.list[k]: v for k, v in ref.Q_t[t].items()}
             != {fast.list[k]: v for k, v in fast.Q_t[t].items()})
    if nq:
        bad.append(f'q forms: {nq} of {ref.n} shifts differ')

    def rowkey(B, row):
        kind, payload, e = row
        key = (kind, (tuple(payload[0]), tuple(payload[1])) if kind in ('nonneg', 'le') else payload)
        return key, {B.list[k]: v for k, v in e.items()}
    rk = dict(rowkey(ref, r) for r in ref.rows)
    fk = dict(rowkey(fast, r) for r in fast.rows)
    if set(rk) != set(fk):
        bad.append(f'scalar row sets differ: reference {len(rk)}, fast {len(fk)}')
    else:
        off = sum(1 for k in rk if any(abs(rk[k].get(m, 0.0) - fk[k].get(m, 0.0)) > 1e-12
                                       for m in set(rk[k]) | set(fk[k])))
        if off:
            bad.append(f'{off} scalar rows differ in their coefficients')
    if [(nm, d) for nm, d, _ in ref.blocks] != [(nm, d) for nm, d, _ in fast.blocks]:
        bad.append('block names/sizes differ')

    A1, b1, c1, off1, _ = assemble_reference(ref, args)
    A2, b2, c2, off2, _ = assemble_fast(fast, args)
    rng = random.Random(20260921)
    vals = {m: 1.0 if m == () else rng.uniform(-1.0, 1.0) for m in ref.list}
    v1, v2 = _linear_forms(ref, A1, b1, vals), _linear_forms(fast, A2, b2, vals)
    if A1.shape != A2.shape:
        bad.append(f'matrix shapes differ: {A1.shape} against {A2.shape}')
    else:
        sr = len(ref.rows)
        d1 = float(np.max(np.abs(np.sort(v1[:sr]) - np.sort(v2[:sr]))))
        d2 = float(np.max(np.abs(v1[sr:] - v2[sr:])))
        print(f'  linear forms at a random moment functional: scalar rows agree to {d1:.2e}, '
              f'block rows to {d2:.2e}', flush=True)
        if d1 > 1e-9 or d2 > 1e-9:
            bad.append(f'assembled rows differ: scalar {d1:.2e}, blocks {d2:.2e}')
        if abs(float(c1 @ np.array([vals[m] for m in ref.list[1:]]))
               - float(c2 @ np.array([vals[m] for m in fast.list[1:]]))) > 1e-9:
            bad.append('objective vectors differ')
    print(f'  orbits {len(ref.list)}; product table {ref.R*ref.R*ref.n} entries; '
          f'scalar rows {len(ref.rows)}; matrix {A1.shape} nnz {A1.nnz}/{A2.nnz} '
          f'[{time.monotonic()-t0:.1f} s]', flush=True)
    if bad:
        print('TWIN FAILED:')
        for s in bad:
            print('  ' + s)
        return 1
    print(f'TWIN PASSED at p = {p}: the fast build is the reference build, in every row.')
    return 0


def regression(args):
    """control: reproduce the committed certificate at this p by the documented default command and
    compare every key except the two an edit to this file must move (producer.utc, which changes on
    every run, and producer.tool_sha256, which is this file's own digest)."""
    path = os.path.join(REPO, 'data', 'fs66', 'b1', f'cert-p{args.p}.json')
    if not os.path.exists(path):
        print(f'ERROR: {path} does not exist; there is nothing to regress against.')
        return 2
    want = json.load(open(path))
    B = Build(args.p, c=2.0)
    solve_info, zdual, block_off, row_off = assemble_and_solve(B, args)
    print(f'float reading {solve_info["value"]:.9f} ({solve_info["iterations"]} iterations)', flush=True)
    results = run_scan(B, zdual, block_off, row_off, args,
                       [float(s) for s in args.scan_shifts.split(',')],
                       [int(d) for d in args.scan_digits.split(',')])
    ok = [(c, i) for c, i in results if c is not None]
    got = min(ok, key=lambda ci: Fraction(ci[1]['U_num'], ci[1]['scale']))[0]
    diff = []
    for k in sorted(set(want) | set(got)):
        if k == 'producer':
            for kk in sorted(set(want[k]) | set(got[k])):
                if kk in ('utc', 'tool_sha256'):
                    continue
                if want[k].get(kk) != got[k].get(kk):
                    diff.append(f'producer.{kk}: committed {want[k].get(kk)!r}, rebuilt {got[k].get(kk)!r}')
        elif want.get(k) != got.get(k):
            diff.append(f'{k}: differs' + ('' if k in ('weights', 'blocks', 'rows')
                                           else f' (committed {want.get(k)!r}, rebuilt {got.get(k)!r})'))
    print(f'committed U_num {want["U_num"]} / {want["scale"]}')
    print(f'rebuilt   U_num {got["U_num"]} / {got["scale"]}')
    if diff:
        print(f'REGRESSION FAILED at p = {args.p}: {len(diff)} keys differ')
        for s in diff:
            print('  ' + s)
        return 1
    print(f'REGRESSION PASSED at p = {args.p}: every key of {os.path.relpath(path, REPO)} is '
          f'reproduced except producer.utc and producer.tool_sha256.')
    return 0


# ----------------------------------------------------------------------------- main

def main():
    args = ARGS
    if args.twin_build:
        return twin_build(args)
    if args.regression:
        return regression(args)
    # A warning must be louder than the claim it qualifies, and must survive --quiet: these two flags
    # make the run a CONTROL, and the bound printed at the end is then about a different object.
    control = []
    if args.c != 2.0:
        control.append(f'c = {args.c}, not the hand-proved 2: this file is for a DIFFERENT problem '
                       f'(plan §K.3 plant 9). The checker rebuilds q with 2 and must REFUSE it.')
    if args.arbitrary_weights is not None:
        control.append(f'every weight vector replaced by arbitrary integers (seed '
                       f'{args.arbitrary_weights}) (plan §K.3 plant 12). The file must still check, '
                       f'with a larger and useless U: the weights are off the trust surface.')
    for c in control:
        print(f'*** CONTROL RUN, NOT A CERTIFICATE: {c} ***', flush=True)

    B = Build(args.p, c=args.c, with_q=not args.drop_q, edge_row=args.edge_row, pure=args.pure,
              fast=args.fast, jobs=args.build_jobs, cache_dir=args.cache_dir)
    if args.fast:
        if B.eq_rows:
            raise SystemExit('--fast does not carry equality rows; --pure is a reference-path control')
        A, bv, qobj, block_off, row_off = assemble_fast(B, args)
        solve_info, zdual = solve_scs(B, A, bv, qobj, args)
        del A, bv, qobj
    else:
        solve_info, zdual, block_off, row_off = assemble_and_solve(B, args)
    # the reading is a RESULT, not narration: it survives --quiet, or a control prints nothing and
    # its silence reads like a run that never happened.
    print(f'FLOAT READING (untrusted, double precision): value {solve_info["value"]:.6f} '
          f'(dual {solve_info["dual_value"]:.6f}), status {solve_info["status"]}, '
          f'{solve_info["iterations"]} iterations, {solve_info["solve_s"]} s, {rss_mb()} MB', flush=True)
    print(f'  p^2/m for m = 3, 4, 5: {B.n/3:.4f}, {B.n/4:.4f}, {B.n/5:.4f}', flush=True)

    if args.no_round:
        rec = record(args, solve_info, None, None, None)
        print(json.dumps(rec))
        return 0

    if args.scan:
        shifts = [float(s) for s in args.scan_shifts.split(',')]
        digitlist = [int(d) for d in args.scan_digits.split(',')]
    else:
        shifts, digitlist = [args.shift], [args.digits]

    results, escalations = [], 0
    while True:
        results += run_scan(B, zdual, block_off, row_off, args, shifts, digitlist)
        ok = [(c, i) for c, i in results if c is not None]
        if ok or escalations >= args.escalate:
            break
        escalations += 1
        shifts = [s * 10 for s in shifts]
        say(f'no attempt had all blocks positive definite; raising the shift x10 (escalation '
            f'{escalations}/{args.escalate})')

    print('\n=== the rounding scan (plan §R\'.4) ===')
    print(f'{"shift":>10} {"D":>4} {"U":>18} {"rows":>7} {"cascaded":>9} {"exact s":>8}  blocks')
    for cert, info in sorted(results, key=lambda ci: (ci[1]['shift'], ci[1]['digits'])):
        if cert is None:
            print(f'{info["shift"]:>10.0e} {info["digits"]:>4} {"-- not positive definite":>18} '
                  f'{"":>7} {"":>9} {info["exact_s"]:>8}  {", ".join(info["pd_failures"][:3])}'
                  f'{" …" if len(info["pd_failures"]) > 3 else ""} ({len(info["pd_failures"])} blocks)')
        else:
            print(f'{info["shift"]:>10.0e} {info["digits"]:>4} {info["U_dec"]:>18} {info["rows"]:>7} '
                  f'{info["cascaded"]:>9} {info["exact_s"]:>8}  {info["blocks"]}')

    ok = [(c, i) for c, i in results if c is not None]
    if not ok:
        print('NO CERTIFICATE: every rounding attempt left a block not positive definite. '
              'Next: raise --shift (x10) or --digits.')
        for _, info in results:
            record(args, solve_info, info, None, None, kept=False)
        return 1
    best = min(ok, key=lambda ci: Fraction(ci[1]['U_num'], ci[1]['scale']))
    cert, info = best

    cert_path, cert_sha = None, None
    if args.out:
        # key order: the claim first (format, p, scale, U_num), then where to read what it means,
        # then how it was made, then the data.  §C.1.
        with open(args.out, 'w') as f:
            json.dump(cert, f, separators=(',', ':'))
        cert_path = os.path.relpath(os.path.abspath(args.out), REPO)
        cert_sha = sha256_of(args.out)
        say(f'wrote {cert_path} ({os.path.getsize(args.out)} bytes, sha256 {cert_sha[:12]}…)')

    for c, i in results:
        record(args, solve_info, i, cert_path if c is cert else None,
               cert_sha if c is cert else None, kept=(c is cert))

    if control:
        print('\n*** the bound below is a CONTROL\'s, about a different object: '
              + ' '.join(control) + ' ***')
    print(f'\nBOUND (the producer\'s own arithmetic -- UNTRUSTED until the checker says CERTIFIED):')
    print(f'  U = {info["U_num"]} / {info["scale"]} = {info["U_dec"]}')
    # the LARGEST m the bound refuses: m*U < n fails from some m on, and that m - 1 is the claim.
    mmax = max([m for m in range(2, 12) if m * info['U_num'] < B.n * info['scale']], default=None)
    if mmax is None:
        print(f'  2*U >= {B.n}: this bound refuses no colour count.')
    else:
        print(f'  {mmax}*U = {dec_str(mmax * info["U_num"], info["scale"])} < {B.n} '
              f'-- refuses {mmax} colours (and fewer) at every level, by the hand links L1, L2, L6; '
              f'{mmax + 1}*U = {dec_str((mmax + 1) * info["U_num"], info["scale"])} >= {B.n}, so it says '
              f'nothing about {mmax + 1}')
    print(f'  loss against the float reading: {info["U_float"] - solve_info["value"]:.6f}')
    if args.out:
        print(f'\nNext: python3 tools/fs66_b1_cert_check.py {cert_path} '
              f'--m {4 if B.p == 11 else 3 if B.p == 7 else 2} --record data/fs66/b1/records.jsonl')
    return 0


if __name__ == '__main__':
    sys.exit(main())
