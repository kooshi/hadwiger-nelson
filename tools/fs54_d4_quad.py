#!/usr/bin/env python3
"""fs54_d4_quad — FS-54 D4: the next level of the semidefinite hierarchy for alpha(UD(F_q,2)), sized, controlled and
priced before anything big runs.  Derivation: plans/FS54-D4-pricing.md (sections 1-3).  Floats are READINGS, never
bounds; a bound needs an exact rational certificate and a stranger's checker, which this tool does not produce.

THE PROGRAMME (Gvozdenovic-Laurent-Vallentin's L_3, [GLV2009], in Schrijver's normalisation).  For a nonempty
independent set S of size s and T a set of points, N(T) = #{z in V : z + T is inside S} and y(T) = N(T)/s, averaged
over the point stabiliser G0 of Aut = V x| G0 (so y depends only on the Aut-orbit of T; y(point) = 1).  For z in V let
xi^z in R^V be xi^z[u] = [z + u in S].  For d in V and a sign pattern, the matrix
    A^{sigma}_d = (1/s) sum_z w_sigma(z) xi^z (xi^z)^T,   w_{++} = [z in S][z+d in S], w_{+-} = [z in S][z+d not in S],
                                                           w_{--} = [z not in S][z+d not in S]
is a sum of positive semidefinite rank-one matrices, and its entries are linear in y:
    ++ : y{0,d,u,v}      +- : y{0,u,v} - y{0,d,u,v}      -- : y{u,v} - y{0,u,v} - y{d,u,v} + y{0,d,u,v}.
Level 2 (Schrijver's triple bound, the FS-50 certificate's programme) is the one-point version: Y = A^{+} with entries
y{0,u,v} and M - Y = A^{-} with entries y{u,v} - y{0,u,v}; objective trace Y = sum_u y{0,u} = s (exactly).

SYMMETRY.  y is Aut-invariant, so A^{++}_d and A^{--}_d are invariant under H_d = {id, s_d, tau_d, s_d tau_d} (s_d the
orthogonal reflection fixing d, tau_d(z) = d - z), and A^{+-}_d under {id, s_d}; Y and M - Y under {+-I, +-refl}.  Each
matrix is congruent (orthogonally) to the direct sum of its character blocks
    B_chi[O, O'] = sum_{h in H} chi(h) A[o, h o'] / sqrt(|St o| |St o'|)
over the H-orbits whose stabiliser chi kills; A is PSD iff every block is.  One d per G0-orbit suffices (A_{gd} is a
relabelling of A_d).  The variables are the Aut-orbits of independent sets of size 2, 3, 4 (a canonical form under Aut
is computed for every set the matrices touch).

SUBCOMMANDS
  count      exact sizes: orbits of Aut on independent k-sets (and of G0 on those containing 0), with a Burnside
             cross-check; d-classes; block sizes; nonzeros of the SCS data per family.  Writes JSON.
  checkset   the soundness control: y computed from a REAL independent set (from its subsets, exactly), every block
             of the chosen families assembled from those y and its least eigenvalue printed; must be >= -tol, and
             the objective must equal |S|.  A planted wrong sign must make some block indefinite.
  solve      assemble the SCS data directly (no cvxpy) and solve in warm-started CHUNKS, checkpointing the iterate
             (x, y, s, iterations) after every chunk; a relaunch with the same --ckpt resumes.  --new starts a new
             checkpoint and refuses to overwrite; without --new a missing checkpoint is REFUSED (a path that does not
             exist must never silently mean "start from zero").
  evaluate   on a checkpoint (ADMM's X, or SCS's dual y): the CERTIFICATE-SHAPED float value N of the derivation's (*)
             with the rows 0 <= y <= 1 (a reading of what an exact rounding would prove); --rank adds the numerical ranks
             of the projected blocks (prices a Gram-factor certificate); --set checks the identity (*) term by term at a
             real independent set, with a plant that drops mu and must break it.
  randsets   the soundness control on RANDOM maximal independent sets (random-order greedy): objective = |S| and every
             block PSD, for sets that are not maxima.
  selftest   the vectorisation convention of SCS's PSD cone checked against a dense eigenvalue computation.

  --method admm (solve): the arrowhead ADMM.  A^T A is diagonal on the 4-set variables (each entry of each pattern
             matrix holds exactly one) plus a border on the pair and triple variables, so the Wen-Goldfarb-Yang
             alternating-direction method on the dual factors one Schur complement and solves exactly; the PSD blocks
             are projected in a thread pool (--proj-threads, with OPENBLAS_NUM_THREADS=1).  CPU only; measured 0.17 s per
             iteration at q = 27 against 9.7 s for SCS gpu_indirect.

THE LEAN PATH (q = 47; plans/FS54-twenty-seven.md "§D4 at 47 -- measured price").  The same programme from the same
functions, built in forked workers (tables as int32 triangles, each block compressed to CSR in its worker) and cached:
  lean-build     build and cache the instance (V = -A in CSR with int32 indices, C, bs, the orbit keys); --census adds
                 the orbit-completeness check.  q = 47: 4,121,921 variables, 462 blocks (orders 529-1,128), 701 M nonzeros.
  lean-compare   the lean data against assemble_scs at a small q (identical numbering, rows, cone, C, bs, objective
                 constant; entries equal to 2.2e-16 -- summation order differs, so a few exact-zero sums differ).
  lean-checkset  y from a real independent set (subsets split by least member over forked workers), objective and every
                 block's least eigenvalue from the ASSEMBLED data, with two plants that must make a block indefinite.
  lean-solve     admm_solve's iteration on the cached instance, vector work in numba-parallel kernels, the projection in a
                 CPU thread pool (--projector cpu) or on one GPU via cusolverDnXsyevBatched (--projector gpu, checked
                 against the CPU projection on the first iteration); checkpoint and resume exactly as `solve`.
  lean-evaluate  the certificate-shaped float value N on a lean checkpoint.
Run the lean path with .venv (numba) and OMP_NUM_THREADS=OPENBLAS_NUM_THREADS=1; pin a GPU by UUID.

Run with the GPU venv for solves (build/venv-sdp-gpu/bin/python; pin the card by UUID), or .venv for counts."""
import argparse, json, math, sys, time
from pathlib import Path
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_cert_check as CC  # noqa: E402  (the Field: F_q named by its modulus, the repository's vertex convention)

KILLED, CONST = -1, -2


# ------------------------------------------------------------------------------------------------ the plane and G0
class Plane:
    """UD(F_q, 2) with vertex index x*q + y (field elements named as in fplane_cert_check.Field), its difference table,
    its unit set, and G0 = O(2, F_q) x| Gal(F_q/F_p) as a permutation array, every element verified an automorphism."""

    def __init__(self, q, modulus=None):
        F = CC.Field(q, modulus) if modulus is not None else CC.Field(q)
        self.F, self.q, self.n = F, q, q * q
        r = range(q)
        ADD = np.array([[F.add(a, b) for b in r] for a in r], dtype=np.int32)
        SUBf = np.array([[F.sub(a, b) for b in r] for a in r], dtype=np.int32)
        MUL = np.array([[F.mul(a, b) for b in r] for a in r], dtype=np.int32)
        NEGf = np.array([F.neg(a) for a in r], dtype=np.int32)
        n = self.n
        X, Yc = np.arange(n) // q, np.arange(n) % q
        self.X, self.Y = X, Yc
        self.SUB = (SUBf[X[:, None], X[None, :]] * q + SUBf[Yc[:, None], Yc[None, :]]).astype(np.int16)   # SUB[a,b] = a-b
        self.ADDp = (ADD[X[:, None], X[None, :]] * q + ADD[Yc[:, None], Yc[None, :]]).astype(np.int16)
        self.NEG = (NEGf[X] * q + NEGf[Yc]).astype(np.int16)
        Qv = ADD[MUL[X, X], MUL[Yc, Yc]]
        self.Qv = Qv
        self.unit = Qv == F.one
        self.unit[0] = False
        self.deg = int(self.unit.sum())
        assert self.deg == q + 1, (q, self.deg)
        # O(2): rotations by circle points (a, b): (x, y) -> (ax - by, bx + ay), then with the reflection (x, y) -> (x, -y)
        circ = np.nonzero(self.unit)[0]
        perms = []
        for c in circ:
            a, b = X[c], Yc[c]
            nx = ADD[MUL[a, X], NEGf[MUL[b, Yc]]]
            ny = ADD[MUL[b, X], MUL[a, Yc]]
            rot = nx * q + ny
            perms.append(rot)
            perms.append(rot[X * q + NEGf[Yc]])          # rot o refl
        O2 = np.array(perms, dtype=np.int16)
        # Frobenius (x, y) -> (x^p, y^p), and its powers
        fr = np.arange(q)
        for _ in range(F.p - 1):
            fr = MUL[fr, np.arange(q)]
        frob = (fr[X] * q + fr[Yc]).astype(np.int16)
        gal = [np.arange(n, dtype=np.int16)]
        while True:
            nxt = frob[gal[-1]]
            if np.array_equal(nxt, gal[0]):
                break
            gal.append(nxt)
        assert len(gal) == F.f, (len(gal), F.f)
        self.O2 = O2
        G0 = np.array([g[o] for g in gal for o in O2], dtype=np.int16)     # z -> gal(o(z))
        G0u = np.unique(G0, axis=0)
        assert len(G0u) == 2 * (q + 1) * F.f, (len(G0u), q)
        self.G0 = G0u
        # every element: fixes 0, additive, preserves the unit set
        for g in self.G0:
            assert g[0] == 0
            assert np.array_equal(self.unit[g], self.unit)
            assert np.array_equal(g[self.SUB], self.SUB[g[:, None], g[None, :]])
        self.aut_order = n * len(self.G0)

    def reflection_fixing(self, d):
        """the unique non-identity element of O(2) fixing d (d non-isotropic, which every nonzero d is for q = 3 mod 4)"""
        cand = [g for g in self.O2 if g[d] == d and not np.array_equal(g, np.arange(self.n))]
        assert len(cand) == 1, (d, len(cand))
        return cand[0]

    # ----------------------------------------------------------------------------------- canonical forms under Aut
    def canon(self, T, gchunk=24, want_mult=False):
        """T: (m, k) int array of points, k <= 4, repeats allowed (they denote the underlying SET).  Returns int64 keys
        (the lexicographically least image of the set under Aut, as the three nonzero elements after translating one
        member to 0, sentinel n for absent) and, if asked, the number of (member, g) pairs attaining it, which for a set
        of DISTINCT members is |Stab_Aut(T)|."""
        n = self.n
        T = np.asarray(T)
        m, k = T.shape
        if k < 4:
            T = np.concatenate([T, np.repeat(T[:, :1], 4 - k, axis=1)], axis=1)
        S = np.int32(n)
        best = np.full(m, np.iinfo(np.int64).max, dtype=np.int64)
        mult = np.zeros(m, dtype=np.int64)
        for j in range(k):          # the ORIGINAL columns only: a padded copy would count each (member, g) twice
            D = self.SUB[T, T[:, j:j + 1]]                      # (m, 4), one entry is 0
            for g0 in range(0, len(self.G0), gchunk):
                I = self.G0[g0:g0 + gchunk][:, D].astype(np.int32)   # (g, m, 4)
                a, b, c, e = I[..., 0], I[..., 1], I[..., 2], I[..., 3]
                a, b = np.minimum(a, b), np.maximum(a, b)
                c, e = np.minimum(c, e), np.maximum(c, e)
                a, c = np.minimum(a, c), np.maximum(a, c)
                b, e = np.minimum(b, e), np.maximum(b, e)
                b, c = np.minimum(b, c), np.maximum(b, c)
                # a == 0 always; mark duplicates, then re-sort the last three
                b2 = np.where(b == a, S, b)
                c2 = np.where(c == b, S, c)
                e2 = np.where(e == c, S, e)
                b2, c2 = np.minimum(b2, c2), np.maximum(b2, c2)
                c2, e2 = np.minimum(c2, e2), np.maximum(c2, e2)
                b2, c2 = np.minimum(b2, c2), np.maximum(b2, c2)
                key = (b2.astype(np.int64) * (n + 1) + c2) * (n + 1) + e2     # (g, m)
                kmin = key.min(axis=0)
                if want_mult:
                    cnt = (key == kmin[None, :]).sum(axis=0)
                    better = kmin < best
                    same = kmin == best
                    mult = np.where(better, cnt, np.where(same, mult + cnt, mult))
                best = np.minimum(best, kmin)
        return (best, mult) if want_mult else best

    def decode(self, keys):
        """keys -> (m, 4) arrays [0, b, c, e] with sentinel n for absent members"""
        n1 = self.n + 1
        keys = np.asarray(keys, dtype=np.int64)
        e = keys % n1
        c = (keys // n1) % n1
        b = keys // (n1 * n1)
        return np.stack([np.zeros_like(b), b, c, e], axis=1)

    def key_size_and_indep(self, keys):
        P = self.decode(keys)
        present = P < self.n
        size = present.sum(axis=1)
        indep = np.ones(len(keys), dtype=bool)
        for i in range(4):
            for j in range(i + 1, 4):
                both = present[:, i] & present[:, j]
                a = np.where(both, P[:, i], 0)
                b = np.where(both, P[:, j], 0)
                indep &= ~(both & self.unit[self.SUB[a, b]])
        return size, indep


# ------------------------------------------------------------------------------------------- the variable tables
def d_classes(P):
    """one representative per G0-orbit of nonzero points (the least index), with the orbit size"""
    orb = P.G0[:, np.arange(P.n)].min(axis=0)
    reps, counts = np.unique(orb[1:], return_counts=True)
    return [int(r) for r in reps], [int(c) for c in counts], orb


class Tables:
    """keys of {0,u,v} for all u,v (T3) and of {0,d,u,v} for each d-class representative (T4[d]), and the variable
    numbering: every Aut-orbit of an independent set of size 2..4 that some table touches gets an id; KILLED for a
    non-independent set; CONST for a single point (y = 1)."""

    def __init__(self, P, dreps, log=print, chunk=40000):
        n = P.n
        iu, iv = np.triu_indices(n)                              # u <= v
        t0 = time.time()

        def table(first):
            keys = np.empty(len(iu), dtype=np.int64)
            for s in range(0, len(iu), chunk):
                u, v = iu[s:s + chunk], iv[s:s + chunk]
                cols = [np.zeros_like(u)] + ([np.full_like(u, first)] if first is not None else []) + [u, v]
                keys[s:s + chunk] = P.canon(np.stack(cols, axis=1))
            full = np.empty((n, n), dtype=np.int64)
            full[iu, iv] = keys
            full[iv, iu] = keys
            return full

        K3 = table(None)
        log(f"[tables] q={P.q}: T3 keys for {n}x{n} in {time.time()-t0:.1f} s")
        K4 = {}
        for d in dreps:
            t1 = time.time()
            K4[d] = table(d)
            log(f"[tables] q={P.q}: T4 keys for d={d} in {time.time()-t1:.1f} s")
        allkeys = np.unique(np.concatenate([K3.ravel()] + [K4[d].ravel() for d in dreps]))
        size, indep = P.key_size_and_indep(allkeys)
        var = np.full(len(allkeys), KILLED, dtype=np.int64)
        var[size == 1] = CONST
        live = (size >= 2) & indep
        order = np.nonzero(live)[0]
        # number the live variables by size then key (deterministic)
        order = order[np.lexsort((allkeys[order], size[order]))]
        var[order] = np.arange(len(order))
        self.keys, self.size, self.indep, self.var = allkeys, size, indep, var
        self.nvar = len(order)
        self.var_size = size[order]
        self.var_key = allkeys[order]

        def ids(K):
            return var[np.searchsorted(allkeys, K)]

        self.V3 = ids(K3)
        self.V4 = {d: ids(K4[d]) for d in dreps}
        self.K3, self.K4 = K3, K4
        log(f"[tables] q={P.q}: {self.nvar} live variables "
            f"(size 2: {int((self.var_size==2).sum())}, 3: {int((self.var_size==3).sum())}, 4: {int((self.var_size==4).sum())}); "
            f"{time.time()-t0:.1f} s total")


# ------------------------------------------------------------------------------------------------- the patterns
def _v3(Tb, a, b):
    return Tb.V3[a, b]


def pattern_terms(P, Tb, pat, d, u, v):
    """entries A[u, v] (u, v arrays of points) as a list of (coef, var-id array); ids may be KILLED or CONST"""
    S = P.SUB
    if pat == "Y":                                   # Y[u,v] = y{0,u,v}
        return [(1.0, Tb.V3[u, v])]
    if pat == "MY":                                  # (M - Y)[u,v] = y{u,v} - y{0,u,v}
        return [(1.0, Tb.V3[0, S[v, u]]), (-1.0, Tb.V3[u, v])]
    if pat == "++":
        return [(1.0, Tb.V4[d][u, v])]
    if pat == "+-":
        return [(1.0, Tb.V3[u, v]), (-1.0, Tb.V4[d][u, v])]
    if pat == "--":
        return [(1.0, Tb.V3[0, S[v, u]]), (-1.0, Tb.V3[u, v]), (-1.0, Tb.V3[S[u, d], S[v, d]]), (1.0, Tb.V4[d][u, v])]
    raise ValueError(pat)


def pattern_border(P, Tb, pat, d, v, s0):
    """the border row (star, v) and corner (star, star) of the '--' and 'MY' patterns: the all-ones coordinate xi^z[star] = 1.
    The corner carries |V|/s, replaced by |V|/s0, which is valid for every set with s >= s0 (a larger corner keeps PSD)."""
    S = P.SUB
    n = P.n
    if pat == "MY":        # (1/s) sum_{z not in S} : corner |V|/s - 1, border 1 - y{0,v}
        return [(1.0, np.full_like(v, CONST)), (-1.0, Tb.V3[0, v])], n / s0 - 1.0, []
    if pat == "--":        # corner |V|/s - 2 + y{0,d}; border 1 - y{0,v} - y{d,v} + y{0,d,v}
        return ([(1.0, np.full_like(v, CONST)), (-1.0, Tb.V3[0, v]), (-1.0, Tb.V3[0, S[v, d]]), (1.0, Tb.V4[d][v, v])],
                n / s0 - 2.0, [(1.0, np.array([Tb.V3[0, d]]))])
    raise ValueError(pat)


def pattern_group(P, pat, d):
    """generators (involutions, commuting) of the symmetry group used to block the pattern's matrix"""
    n = P.n
    ident = np.arange(n)
    if pat in ("Y", "MY"):
        refl = P.X * P.q + (P.NEG.astype(np.int64) % P.q)
        gens = [P.NEG.astype(np.int64), refl]
    else:
        sd = P.reflection_fixing(d).astype(np.int64)
        gens = [sd] if pat == "+-" else [sd, P.SUB[d, ident].astype(np.int64)]
    for g in gens:
        assert np.array_equal(g[g], ident)
    if len(gens) == 2:
        assert np.array_equal(gens[0][gens[1]], gens[1][gens[0]])
    return gens


def blocks_for(P, Tb, pat, d, border=False, s0=None):
    """yield (label, dim, rows, cols, vals, const) for every character block of one pattern matrix: the block's scaled
    lower-triangle vector is  const - A x  with A given by (rows, cols, -vals) ... i.e. s = const + sum vals * x[cols]."""
    n = P.n
    gens = pattern_group(P, pat, d)
    k = len(gens)
    elems, signs_of = [], []
    for bits in range(1 << k):
        g = np.arange(n)
        for i in range(k):
            if bits >> i & 1:
                g = gens[i][g]
        elems.append(g)
        signs_of.append(bits)
    H = np.array(elems)                                         # (|H|, n)
    rep = H.min(axis=0)
    reps = np.nonzero(rep == np.arange(n))[0]
    st_all = (H == np.arange(n)[None, :]).sum(axis=0)
    for chi in range(1 << k):
        chis = np.array([(-1) ** bin(b & chi).count("1") for b in signs_of], dtype=np.float64)
        fixed = H[:, reps] == reps[None, :]                     # (|H|, m)
        valid = np.all((chis[:, None] == 1) | ~fixed, axis=0)
        R = reps[valid]
        st = st_all[R].astype(np.float64)
        use_border = border and chi == 0
        m = len(R) + (1 if use_border else 0)
        if m == 0:
            continue
        I, J = np.triu_indices(len(R))                          # i <= j within the point part
        rows_l, cols_l, vals_l = [], [], []
        const = np.zeros(m * (m + 1) // 2)

        def vidx(a, b):                                         # lower-triangle column-major index of (max, min)
            i, j = np.maximum(a, b), np.minimum(a, b)
            return j * (2 * m - j + 1) // 2 + (i - j)

        vi = vidx(I, J)
        scale = np.where(I != J, math.sqrt(2.0), 1.0) / np.sqrt(st[I] * st[J])
        for h in range(len(H)):
            u, v = R[I], H[h, R[J]]
            for coef, ids in pattern_terms(P, Tb, pat, d, u, v):
                w = chis[h] * coef * scale
                live = ids >= 0
                rows_l.append(vi[live]); cols_l.append(ids[live]); vals_l.append(w[live])
                cm = ids == CONST
                np.add.at(const, vi[cm], w[cm])
        if use_border:
            o = len(R)
            # (star, point j): sum_h chi(h) A[star, h o_j] / sqrt(|H| st_j), chi trivial
            J2 = np.arange(len(R))
            vi2 = vidx(np.full_like(J2, o), J2)
            sc2 = math.sqrt(2.0) / np.sqrt(len(H) * st[J2])
            for h in range(len(H)):
                terms, corner, corner_terms = pattern_border(P, Tb, pat, d, H[h, R[J2]], s0)
                for coef, ids in terms:
                    w = coef * sc2 * np.ones(len(J2))
                    live = ids >= 0
                    rows_l.append(vi2[live]); cols_l.append(ids[live]); vals_l.append(w[live])
                    cm = ids == CONST
                    np.add.at(const, vi2[cm], w[cm])
            # (star, star): |H| * A[star,star] / |H|
            vcc = vidx(np.array([o]), np.array([o]))[0]
            terms, corner, corner_terms = pattern_border(P, Tb, pat, d, np.array([0]), s0)
            const[vcc] += corner
            for coef, ids in corner_terms:
                if ids[0] >= 0:
                    rows_l.append(np.array([vcc])); cols_l.append(ids); vals_l.append(np.array([coef]))
                elif ids[0] == CONST:
                    const[vcc] += coef
        rows = np.concatenate(rows_l) if rows_l else np.zeros(0, dtype=np.int64)
        cols = np.concatenate(cols_l) if cols_l else np.zeros(0, dtype=np.int64)
        vals = np.concatenate(vals_l) if vals_l else np.zeros(0)
        yield (f"{pat}@{d}/chi{chi}{'+border' if use_border else ''}", m, rows, cols, vals, const)


def le_diag_rows(P, Tb):
    """FS-50's P6 rows, y{0,u,v} <= y{0,u} (Y[u,v] <= Y[u,u]), one per distinct (variable, variable) pair, as 1x1 blocks.
    Implied in l3 by the diagonals of the +- matrices; needed for a like-for-like triple-level control (they bind at q = 7)."""
    n = P.n
    U, W = np.meshgrid(np.arange(n), np.arange(n), indexing="ij")
    a = Tb.V3[0, U].ravel()           # y{0,u}
    b = Tb.V3[U, W].ravel()           # y{0,u,v}
    keep = (b >= 0) & (a != b)
    pairs = np.unique(np.stack([a[keep], b[keep]], axis=1), axis=0)
    out = []
    for ai, bi in pairs:
        rows, cols, vals, const = [], [], [], np.zeros(1)
        if ai >= 0:
            rows.append(0); cols.append(ai); vals.append(1.0)
        elif ai == CONST:
            const[0] += 1.0
        rows.append(0); cols.append(bi); vals.append(-1.0)
        out.append(("ld", 1, np.array(rows), np.array(cols), np.array(vals), const))
    return out


FAMILIES = {
    # name: list of patterns; d-dependent patterns run over the chosen d-classes
    "triple": ["Y", "MY", "LD"],
    "triple-nold": ["Y", "MY"],
    "l3": ["Y", "MY", "++", "+-", "--"],
    "l3-noY": ["++", "+-", "--"],
    "l3-pp": ["Y", "MY", "++"],
}


def build(P, Tb, family, dreps, border=False, s0=None, log=print):
    """all blocks of a family: returns list of (label, dim, rows, cols, vals, const) with rows local to the block"""
    out = []
    for pat in FAMILIES[family]:
        if pat == "LD":
            out += le_diag_rows(P, Tb)
            continue
        if pat in ("Y", "MY"):
            out += list(blocks_for(P, Tb, pat, 0, border=border and pat == "MY", s0=s0))
            continue
        for d in dreps:
            if P.unit[d] and pat in ("++", "+-"):
                continue          # ++ is identically zero and +- equals Y when d is a unit vector
            out += list(blocks_for(P, Tb, pat, d, border=border and pat == "--", s0=s0))
    return out


def objective(P, Tb):
    """trace Y = 1 + sum_{u != 0} y{0,u}: returns (constant, coefficient vector over the variables)"""
    c = np.zeros(Tb.nvar)
    ids = Tb.V3[0, 1:]
    live = ids >= 0
    np.add.at(c, ids[live], 1.0)
    const = 1.0 + float((ids == CONST).sum())
    return const, c


def fixed_k_rows(P, Tb, k, origin_eq=False, log=print):
    """the FIXED-CARDINALITY moment equations at |S| = k (the external review of 2026-09-18).

    For an independent set S of size s, N(T) = #{z : T + z inside S} and y(T) = N(T)/s.  Summing over
    every v in V,

        sum_v N(T u {v}) = sum_z [T + z inside S] * #{v : v + z in S} = s * N(T),

    and a v outside T that is adjacent to some member of T contributes 0 because S is independent, so
    for every independent T

        sum_{v not in T u N(T)} y(T u {v})  =  (|S| - |T|) * y(T).

    One equation per Aut-orbit of an independent T, and the orbits of size 1, 2, 3 give 1 + 17 + 555 =
    573 of them at q = 19 -- using variables of size 2, 3 and 4, ALL OF WHICH THIS RELAXATION ALREADY
    CARRIES (35,472 of size 4 at q = 19).  That is what the review meant by "no new moment variables".
    |T| = 0 is vacuous in this normalisation (y(point) = 1 by definition), and |T| = 4 would need a
    5-set variable.

    THE ORIGIN EQUATION IS LEFT OUT BY DEFAULT.  |T| = 1 reads sum_{v} y{0,v} = k - 1, which is
    exactly "trace Y = k" -- it would pin the objective and throw the quantity away.  Keeping it out
    leaves f(k) = max trace Y as a NUMBER, and the test is f(k) < k: a real independent set of size
    exactly k satisfies every equation here and has trace Y = k, so f(k) < k proves there is none,
    hence alpha < k (any larger independent set has an independent k-subset).  --origin-eq puts it
    back and turns the programme into a feasibility question instead.

    Returns (rows, counts) with rows a list of (cols, vals, rhs): sum vals[i] * y[cols[i]] = rhs."""
    n = P.n
    t0 = time.time()
    reps = [(1, np.array([0], dtype=np.int64), None)] if origin_eq else []
    for sz in (2, 3):
        idx = np.nonzero(Tb.var_size == sz)[0]
        D = P.decode(Tb.var_key[idx])
        for i, row in zip(idx, D):
            reps.append((sz, row[row < n].astype(np.int64), int(i)))
    all_v = np.arange(n)
    rows = []
    for sz, T, vid in reps:
        ok = np.ones(n, dtype=bool)
        for t in T:
            ok &= ~P.unit[P.SUB[all_v, int(t)]]
            ok[int(t)] = False
        vs = np.nonzero(ok)[0]
        cols4 = np.concatenate([np.tile(T, (len(vs), 1)), vs[:, None]], axis=1)
        keys = P.canon(cols4)
        pos = np.searchsorted(Tb.keys, keys)
        assert np.all(Tb.keys[np.minimum(pos, len(Tb.keys) - 1)] == keys), "a T+v orbit no table touches"
        ids = Tb.var[pos]
        assert np.all(ids >= 0), "a T+v set is killed, but v was chosen non-adjacent to T"
        coef = np.bincount(ids, minlength=Tb.nvar).astype(np.float64)
        rhs = 0.0
        if vid is None:                       # |T| = 1: y(T) = 1, so it is a constant
            rhs = float(k - sz)
        else:
            coef[vid] -= float(k - sz)
        nz = np.nonzero(coef)[0]
        rows.append((nz, coef[nz], rhs))
    counts = {}
    for sz, _, _ in reps:
        counts[sz] = counts.get(sz, 0) + 1
    log(f"[fixedk] q={P.q} k={k}: {len(rows)} equations "
        f"({', '.join(f'|T|={a}: {b}' for a, b in sorted(counts.items()))}) in {time.time()-t0:.1f} s")
    return rows, counts


def fixed_k_residuals(rows, y):
    """the equations evaluated at a y: the control's whole content."""
    return np.array([float(v @ y[c] - rhs) for c, v, rhs in rows])


def assemble_scs(P, Tb, blocks, nonneg=True, eq_rows=None):
    """SCS standard form  min c.x  s.t.  A x + s = b,  s in K  (K = nonneg^nvar x PSD blocks, scaled lower-triangle
    column-major vectorisation).  A block's s = const + sum vals x[cols], so A = -vals and b = const."""
    import scipy.sparse as sp
    nv = Tb.nvar
    rows, cols, vals, b = [], [], [], []
    off = 0
    nz_rows = 0
    if eq_rows:                                          # the zero cone comes FIRST in SCS's ordering
        for (c_, v_, rhs) in eq_rows:
            rows.append(np.full(len(c_), off)); cols.append(np.asarray(c_))
            vals.append(-np.asarray(v_)); b.append(np.array([-float(rhs)]))
            off += 1
        nz_rows = len(eq_rows)
    if nonneg:
        rows.append(np.arange(nv) + off); cols.append(np.arange(nv)); vals.append(-np.ones(nv)); b.append(np.zeros(nv))
        off += nv                                        # += , never = : the equality rows sit before it
    dims = []
    lin = [bl for bl in blocks if bl[1] == 1]            # 1x1 blocks are linear rows: they go in the nonneg cone
    for (label, m, r, cidx, v, const) in lin + [bl for bl in blocks if bl[1] > 1]:
        rows.append(r + off); cols.append(cidx); vals.append(-v); b.append(const)
        off += m * (m + 1) // 2
        if m > 1:
            dims.append(m)
    A = sp.csc_matrix((np.concatenate(vals), (np.concatenate(rows), np.concatenate(cols))), shape=(off, nv))
    A.sum_duplicates()
    A.eliminate_zeros()
    bb = np.concatenate(b)
    oc, cvec = objective(P, Tb)
    cone = dict(z=nz_rows, l=(nv if nonneg else 0) + len(lin), s=dims)
    return dict(A=A, b=bb, c=-cvec), cone, oc


# ---------------------------------------------------------------------------------------- y from a real set
def y_from_set(P, Tb, S, log=print, chunk=200000):
    """y(O) = #{T subset of S : T in O} * |Stab_Aut(T)| / (s |G0|), exactly the Aut-average of N(T)/s (derivation §2)"""
    import itertools
    S = np.array(sorted(set(int(x) for x in S)))
    s = len(S)
    y = np.zeros(Tb.nvar)
    for k in (2, 3, 4):
        combos = itertools.combinations(range(s), k)
        while True:
            blk = np.array(list(itertools.islice(combos, chunk)), dtype=np.int64)
            if len(blk) == 0:
                break
            keys, mult = P.canon(S[blk], want_mult=True)
            pos = np.searchsorted(Tb.keys, keys)
            assert np.all(Tb.keys[np.minimum(pos, len(Tb.keys) - 1)] == keys), "a subset of S has an orbit no table touches"
            ids = Tb.var[pos]
            assert np.all(ids >= 0), "a subset of S is killed: S is not independent"
            np.add.at(y, ids, mult / (s * len(P.G0)))
    return y


def block_matrix(m, rows, cols, vals, const, x):
    vec = const.copy()
    np.add.at(vec, rows, vals * x[cols])
    M = np.zeros((m, m))
    j_idx = np.repeat(np.arange(m), np.arange(m, 0, -1))
    i_idx = np.concatenate([np.arange(j, m) for j in range(m)])
    sc = np.where(i_idx != j_idx, 1 / math.sqrt(2.0), 1.0)
    M[i_idx, j_idx] = vec * sc
    M[j_idx, i_idx] = vec * sc
    return M


# ----------------------------------------------------------------------------------------------- the census
def census(P, Tb, log=print):
    """exact orbit counts with a completeness check.  (i) Aut-orbits of independent k-sets = the live variables of size
    k; (ii) sum over them of |Aut|/|Stab| must equal the number of independent k-sets counted directly (via the
    non-neighbourhood W of 0: k * #indep k-sets = n * #indep (k-1)-subsets of W); a missing orbit or a non-canonical
    key breaks the equality.  (iii) G0-orbits of independent k-sets CONTAINING 0 (the plan's measure): the distinct
    G0-canonical forms of T - t over orbit representatives T and members t."""
    n = P.n
    W = np.nonzero(~P.unit[P.SUB[np.arange(n), 0]] & (np.arange(n) != 0))[0]
    NA = (~P.unit[P.SUB[W[:, None], W[None, :]]]).astype(np.float64)
    np.fill_diagonal(NA, 0.0)
    indep_pairs_W = NA.sum() / 2
    indep_triples_W = float(np.sum(NA * (NA @ NA))) / 6
    direct = {2: n * len(W) / 2, 3: n * indep_pairs_W / 3, 4: n * indep_triples_W / 4}
    out = {}
    for k in (2, 3, 4):
        keys = Tb.var_key[Tb.var_size == k]
        reps = P.decode(keys)[:, :k]
        _, mult = P.canon(reps, want_mult=True)
        orbit_sum = float(np.sum(P.aut_order / mult))
        # G0-orbits of sets containing 0: canonical form with the translation FIXED (0 stays at 0)
        g0keys = []
        for t in range(k):
            Tt = P.SUB[reps, reps[:, t:t + 1]].astype(np.int64)
            g0keys.append(canon_fixed0(P, Tt))
        n_g0 = len(np.unique(np.concatenate(g0keys)))
        out[k] = dict(aut_orbits=int(len(keys)), sum_aut_over_stab=orbit_sum, direct_count=direct[k],
                      complete=bool(abs(orbit_sum - direct[k]) < 0.5), g0_orbits_containing_0=int(n_g0),
                      stabiliser_hist={int(a): int(b) for a, b in zip(*np.unique(mult, return_counts=True))})
        log(f"[census] q={P.q} k={k}: {len(keys)} Aut-orbits of independent {k}-sets; sum |Aut|/|Stab| = {orbit_sum:.0f} "
            f"vs direct count {direct[k]:.0f} -> {'COMPLETE' if out[k]['complete'] else 'MISMATCH'}; "
            f"{n_g0} G0-orbits of independent {k}-sets containing 0")
    return out


def canon_fixed0(P, T):
    """least image under G0 alone (no translation) of sets T whose first column is the point 0"""
    n = P.n
    m, k = T.shape
    if k < 4:
        T = np.concatenate([T, np.repeat(T[:, :1], 4 - k, axis=1)], axis=1)
    best = np.full(m, np.iinfo(np.int64).max, dtype=np.int64)
    Sn = np.int32(n)
    for g0 in range(0, len(P.G0), 24):
        I = P.G0[g0:g0 + 24][:, T].astype(np.int32)
        a, b, c, e = I[..., 0], I[..., 1], I[..., 2], I[..., 3]
        a, b = np.minimum(a, b), np.maximum(a, b)
        c, e = np.minimum(c, e), np.maximum(c, e)
        a, c = np.minimum(a, c), np.maximum(a, c)
        b, e = np.minimum(b, e), np.maximum(b, e)
        b, c = np.minimum(b, c), np.maximum(b, c)
        b2 = np.where(b == a, Sn, b); c2 = np.where(c == b, Sn, c); e2 = np.where(e == c, Sn, e)
        b2, c2 = np.minimum(b2, c2), np.maximum(b2, c2)
        c2, e2 = np.minimum(c2, e2), np.maximum(c2, e2)
        b2, c2 = np.minimum(b2, c2), np.maximum(b2, c2)
        key = (b2.astype(np.int64) * (n + 1) + c2) * (n + 1) + e2
        best = np.minimum(best, key.min(axis=0))
    return best


# ----------------------------------------------------------------------------------------------- the driver
def fingerprint(P, Tb, family, dreps, data, cone, border, s0, fixed_k=None, origin_eq=False):
    return dict(q=P.q, modulus=P.F.modulus, family=family, dclasses=[int(d) for d in dreps], border=bool(border),
                s0=s0, nvar=int(Tb.nvar), rows=int(data["A"].shape[0]), nnz=int(data["A"].nnz), psd=len(cone["s"]),
                psd_max=int(max(cone["s"])), fixed_k=fixed_k, origin_eq=bool(origin_eq),
                zero_cone=int(cone.get("z", 0)))


def run_chunks(data, cone, oc, fp, ckpt, new, eps, chunk, max_iters, linear_solver, log=print, stop_after=0, verbose=False):
    import scs
    ck = Path(ckpt)
    x0 = y0 = s0v = None
    done = 0
    if ck.exists():
        if new:
            raise SystemExit(f"--new given but {ck} exists: refusing to overwrite a checkpoint (remove it by hand if you mean it)")
        z = np.load(ck, allow_pickle=False)
        old = json.loads(str(z["fingerprint"]))
        if old != fp:
            raise SystemExit(f"checkpoint {ck} belongs to a different problem:\n  {old}\n  {fp}")
        x0, y0, s0v, done = z["x"], z["y"], z["s"], int(z["iters"])
        log(f"[solve] RESUMED from {ck}: {done} iterations already done")
    elif not new:
        raise SystemExit(f"checkpoint {ck} does not exist and --new was not given: refusing to start from zero silently")
    else:
        ck.parent.mkdir(parents=True, exist_ok=True)
        log(f"[solve] NEW checkpoint {ck}")
    solver = scs.SCS(data, cone, eps_abs=eps, eps_rel=eps, max_iters=chunk, verbose=verbose, normalize=True,
                     linear_solver=linear_solver)
    chunks = 0
    info = None
    while done < max_iters:
        t1 = time.time()
        res = solver.solve(warm_start=True, x=x0, y=y0, s=s0v) if x0 is not None else solver.solve()
        info = res["info"]
        x0, y0, s0v = res["x"], res["y"], res["s"]
        it = int(info["iter"])
        done += it
        chunks += 1
        tmp = ck.with_name(ck.name + ".tmp.npz")
        np.savez(tmp, x=x0, y=y0, s=s0v, iters=done, fingerprint=json.dumps(fp))
        tmp.replace(ck)
        dt = time.time() - t1
        log(f"[solve] chunk {chunks}: +{it} it ({done} total) {dt:.1f} s ({dt/max(1,it):.4f} s/it, {linear_solver}); "
            f"primal value {oc - info['pobj']:.6f} dual value {oc - info['dobj']:.6f} res_pri {info['res_pri']:.2e} "
            f"res_dual {info['res_dual']:.2e} gap {info['gap']:.2e} status {info['status']}")
        st = info["status"].lower()
        if st.startswith("solved") and "inaccurate" not in st:
            break
        if "reached max_iters" not in st and not st.startswith("solved"):
            log(f"[solve] status {info['status']}: stopping without a value")
            return None
        if stop_after and chunks >= stop_after:
            log("[solve] stopped after the requested number of chunks (a pricing or control run): NOT converged")
            return dict(converged=False, iterations=done, primal=oc - info["pobj"], dual=oc - info["dobj"], status=info["status"])
    conv = info["status"].lower() == "solved"
    return dict(converged=conv, iterations=done, primal=oc - info["pobj"], dual=oc - info["dobj"], status=info["status"],
                res_pri=info["res_pri"], res_dual=info["res_dual"], gap=info["gap"])


# ------------------------------------------------------------- the arrowhead ADMM (Wen-Goldfarb-Yang 2010 on the dual)
class Arrowhead:
    """G = V^T V for the assembled data.  Every entry of every pattern matrix holds exactly ONE 4-set variable, and the
    character blocks of one matrix are an orthonormal change of basis, so the 4-set x 4-set part of G is DIAGONAL (checked
    here: the off-diagonal mass there must be below `tol`, else refused) with a border on the pair and triple variables
    (they must be numbered first, as Tables does).  G y = r is solved exactly through the Schur complement on the border."""

    def __init__(self, V, nb, tol=1e-9, log=print, VT=None):
        import scipy.sparse as sp
        t0 = time.time()
        G = ((V.T if VT is None else VT) @ V).tocsr()          # VT: a precomputed CSR transpose (the lean path holds one)
        n = G.shape[0]
        G44 = G[nb:, nb:].tocoo()
        off = G44.row != G44.col
        offmax = float(np.abs(G44.data[off]).max()) if off.any() else 0.0
        if offmax > tol:
            raise SystemExit(f"G is not an arrowhead: off-diagonal 4-set coupling {offmax:.3e} > {tol}")
        self.d4 = G.diagonal()[nb:].copy()
        if np.any(self.d4 <= 0):
            raise SystemExit("a 4-set variable appears in no row: G is singular")
        self.B = G[:nb, nb:].tocsr()
        K = G[:nb, :nb].toarray()
        BD = self.B.multiply(1.0 / self.d4[None, :]).tocsr()
        Sc = K - (BD @ self.B.T).toarray()
        self.L = np.linalg.cholesky(Sc)
        self.nb, self.n = nb, n
        self.G = G
        log(f"[admm] G = V^T V: {G.nnz} nonzeros, border {nb}, 4-set diagonal {n-nb} (off-diagonal noise {offmax:.1e}); "
            f"Schur complement factored in {time.time()-t0:.2f} s")

    def solve(self, r):
        import scipy.linalg as sl
        nb = self.nb
        rb, r4 = r[:nb], r[nb:]
        t = sl.solve_triangular(self.L, rb - self.B @ (r4 / self.d4), lower=True)
        yb = sl.solve_triangular(self.L.T, t, lower=False)
        y4 = (r4 - self.B.T @ yb) / self.d4
        return np.concatenate([yb, y4])


class ConeProjector:
    """projection onto nonneg^l x PSD blocks in SCS's scaled vectorisation, batched by block size"""

    def __init__(self, cone, threads=0):
        self.pool = None
        if threads and threads > 0:
            from concurrent.futures import ThreadPoolExecutor
            self.pool = ThreadPoolExecutor(threads)      # numpy releases the GIL inside LAPACK: run with BLAS single-threaded
        self.l = cone["l"]
        self.groups = {}
        off = self.l
        for m in cone["s"]:
            self.groups.setdefault(m, []).append(off)
            off += m * (m + 1) // 2
        self.total = off
        self.idx = {}
        for m in self.groups:
            j = np.repeat(np.arange(m), np.arange(m, 0, -1))
            i = np.concatenate([np.arange(jj, m) for jj in range(m)])
            sc = np.where(i != j, 1 / math.sqrt(2.0), 1.0)
            self.idx[m] = (i, j, sc)

    def _one(self, args):
        w, out, o, m = args
        i, j, sc = self.idx[m]
        L = m * (m + 1) // 2
        M = np.zeros((m, m))
        M[i, j] = w[o:o + L] * sc
        M[j, i] = M[i, j]
        ev, U = np.linalg.eigh(M)
        out[o:o + L] = ((U * np.maximum(ev, 0.0)) @ U.T)[i, j] / sc
        return float(ev[0])

    def project(self, w, want_min=False):
        out = np.empty_like(w)
        out[:self.l] = np.maximum(w[:self.l], 0.0)
        if self.pool is not None:
            jobs = [(w, out, o, m) for m, offs in self.groups.items() for o in offs]
            mins = list(self.pool.map(self._one, jobs))
            return (out, min(mins)) if want_min else out
        lam_min = np.inf
        for m, offs in self.groups.items():
            i, j, sc = self.idx[m]
            L = m * (m + 1) // 2
            rows = np.stack([w[o:o + L] for o in offs])            # (k, L)
            M = np.zeros((len(offs), m, m))
            M[:, i, j] = rows * sc
            M[:, j, i] = rows * sc
            ev, U = np.linalg.eigh(M)
            lam_min = min(lam_min, float(ev[:, 0].min()))
            P = (U * np.maximum(ev, 0.0)[:, None, :]) @ U.transpose(0, 2, 1)
            vec = P[:, i, j] / sc
            for k, o in enumerate(offs):
                out[o:o + L] = vec[k]
        return (out, lam_min) if want_min else out


def admm_solve(data, cone, oc, nb, fp, ckpt, new, tol, max_iters, chunk_seconds, log=print, stop_after_iters=0,
               mu0=1.0, gamma=1.6, adapt_every=20, eta=3.0, proj_threads=0):
    """max c.x s.t. s = b0 + V x in K (V = -A).  Its conic dual  min b0.z  s.t. V^T z = -c, z in K  is solved as the standard
    form  min <C,X> s.t. A(X) = bs, X in K  with C = b0, A = V^T, bs = -c (which is SCS's c), by the Wen-Goldfarb-Yang alternating direction
    augmented Lagrangian method on ITS dual (y = -x, S = C - V y):
        y  = G^{-1} [ mu (bs - V^T X) + V^T (C - S) ],   W = C - V y - mu X,   S = Pi_K(W),   X <- (1-gamma) X + gamma (S - W)/mu.
    Readings: upper side oc + C.X (X in K by construction when gamma = 1; projected when reported), lower side oc + bs.y."""
    V = (-data["A"]).tocsr()
    VT = V.T.tocsr()
    C = data["b"]
    bs = data["c"]           # SCS's c is already -(objective); the dual's right-hand side is -(objective) = SCS's c
    AH = Arrowhead(V, nb, log=log)
    K = ConeProjector(cone, threads=proj_threads)
    ck = Path(ckpt)
    it0 = 0
    if ck.exists():
        if new:
            raise SystemExit(f"--new given but {ck} exists: refusing to overwrite")
        z = np.load(ck, allow_pickle=False)
        if json.loads(str(z["fingerprint"])) != fp:
            raise SystemExit(f"checkpoint {ck} belongs to a different problem")
        X, S, y, mu, it0 = z["X"], z["S"], z["y"], float(z["mu"]), int(z["iters"])
        log(f"[admm] RESUMED from {ck}: {it0} iterations, mu {mu:.3e}")
    elif not new:
        raise SystemExit(f"checkpoint {ck} does not exist and --new was not given: refusing to start from zero silently")
    else:
        ck.parent.mkdir(parents=True, exist_ok=True)
        X = np.zeros(V.shape[0]); S = np.zeros(V.shape[0]); y = np.zeros(V.shape[1]); mu = mu0
        log(f"[admm] NEW checkpoint {ck}")
    nbs, nC = 1 + np.linalg.norm(bs), 1 + np.linalg.norm(C)
    it = it0
    t_last = time.time(); t_start = time.time(); it_last = it
    tim = dict(lin=0.0, spmv=0.0, cone=0.0)
    ratio_hist = []
    res = None
    while it < max_iters:
        ta = time.time()
        rhs = mu * (bs - VT @ X) + VT @ (C - S)
        tb = time.time()
        y = AH.solve(rhs)
        tc = time.time()
        Vy = V @ y
        W = C - Vy - mu * X
        td = time.time()
        S = K.project(W)
        te = time.time()
        X = (1 - gamma) * X + gamma * (S - W) / mu
        it += 1
        tim["spmv"] += (tb - ta) + (td - tc); tim["lin"] += tc - tb; tim["cone"] += te - td
        if it % adapt_every == 0 or it >= max_iters:
            pinf = np.linalg.norm(VT @ X - bs) / nbs
            dinf = np.linalg.norm(C - V @ y - S) / nC
            ratio_hist.append(pinf / max(dinf, 1e-300))
            if pinf > eta * dinf:
                mu *= 1.3
            elif dinf > eta * pinf:
                mu /= 1.3
        now = time.time()
        if now - t_last >= chunk_seconds or it >= max_iters or (stop_after_iters and it - it0 >= stop_after_iters):
            Xp = K.project(X)
            up = oc + C @ Xp
            lo = oc + bs @ y
            pinf = np.linalg.norm(VT @ Xp - bs) / nbs
            dinf = np.linalg.norm(C - V @ y - S) / nC
            gap = abs(up - lo) / (1 + abs(up) + abs(lo))
            tmp = ck.with_name(ck.name + ".tmp.npz")
            np.savez(tmp, X=X, S=S, y=y, mu=mu, iters=it, fingerprint=json.dumps(fp))
            tmp.replace(ck)
            dt = (now - t_last) / max(1, it - it_last)
            log(f"[admm] it {it}: {dt:.4f} s/it (lin {tim['lin']/max(1,it-it_last):.4f}, spmv {tim['spmv']/max(1,it-it_last):.4f}, "
                f"cone {tim['cone']/max(1,it-it_last):.4f}); upper reading {up:.6f} lower reading {lo:.6f} pinf {pinf:.2e} "
                f"dinf {dinf:.2e} gap {gap:.2e} mu {mu:.2e}")
            tim = dict(lin=0.0, spmv=0.0, cone=0.0)
            t_last, it_last = now, it
            res = dict(iterations=it, upper=up, lower=lo, pinf=pinf, dinf=dinf, gap=gap, mu=mu,
                       seconds=now - t_start, converged=bool(max(pinf, dinf, gap) < tol))
            if res["converged"]:
                log(f"[admm] converged at tolerance {tol}")
                break
            if stop_after_iters and it - it0 >= stop_after_iters:
                log("[admm] stopped after the requested iterations (a pricing or control run): NOT converged")
                break
    return res


def certificate_shaped_value(data, cone, oc, Z, scales=(1.0,)):
    """For ANY Z whose PSD blocks are PSD, with the valid rows y_O <= 1 (N(T) <= N({t}) = s) added to the programme, the
    identity (*) of the derivation holds with  lambda_O = max(0, -(V_psd^T Z_psd + c)_O)  on y_O >= 0 and
    mu_O = max(0, (V_psd^T Z_psd + c)_O) on 1 - y_O >= 0, and gives  N = oc + C_psd.Z_psd + sum_O mu_O  (c = the objective).
    Evaluated here in FLOATS on a projected iterate, over a few scalings t Z: what an exact rounding of this Z would
    roughly prove.  A reading, never a bound."""
    V = (-data["A"]).tocsr()
    C = data["b"]
    cvec = -data["c"]
    l = cone["l"]
    Zp = Z.copy()
    Zp[:l] = 0.0                                       # the y >= 0 multipliers are recomputed, not read
    VZ = V.T @ Zp
    CZ = C @ Zp
    best = None
    for t in scales:
        mu = np.maximum(0.0, t * VZ + cvec)
        N = oc + t * CZ + mu.sum()
        if best is None or N < best[0]:
            best = (N, t, float(mu.sum()), int((mu > 0).sum()))
    return dict(N=best[0], scale=best[1], mu_sum=best[2], mu_support=best[3])


def evaluate_checkpoint(q, modulus, ckpt, family="l3", set_file=None, set_path="set", rank=False, log=print):
    import shutil
    snap = str(ckpt) + ".eval-copy.npz"
    shutil.copy(ckpt, snap)                       # a live run rewrites its checkpoint: read a copy
    try:
        z = np.load(snap)
        P = Plane(q, modulus)
        dreps, _, _ = d_classes(P)
        Tb = Tables(P, dreps, log=lambda *a: None)
        data, cone, oc = assemble_scs(P, Tb, build(P, Tb, family, dreps))
        K = ConeProjector(cone)
        raw = z["X"] if "X" in z.files else z["y"]    # ADMM stores X; SCS's dual iterate is y
        Z = K.project(raw)
        rec = dict(q=q, family=family, checkpoint=str(ckpt), iterations=int(z["iters"]))
        rec.update(certificate_shaped_value(data, cone, oc, Z, scales=np.linspace(0.97, 1.01, 41)))
        log(f"[evaluate] q={q} at {rec['iterations']} iterations: certificate-shaped N = {rec['N']:.6f} "
            f"(scale {rec['scale']:.3f}, residual absorbed sum mu = {rec['mu_sum']:.6f} on {rec['mu_support']} orbits)")
        if rank:
            off, s_m3, s_rm2 = cone["l"], 0, 0
            for m in cone["s"]:
                L = m * (m + 1) // 2
                i, j, sc = K.idx[m]
                M = np.zeros((m, m)); M[i, j] = Z[off:off + L] * sc; M[j, i] = M[i, j]
                ev = np.linalg.eigvalsh(M)
                r = int((ev > 1e-9 * max(1.0, ev.max())).sum())
                s_m3 += m ** 3; s_rm2 += r * m * m; off += L
            rec.update(sum_m3=s_m3, sum_rank_m2=s_rm2, rank_fraction=s_rm2 / s_m3)
            log(f"[evaluate] ranks: sum rank*m^2 = {s_rm2:.3e} = {s_rm2/s_m3:.3f} of sum m^3")
        if set_file:
            S = json.load(open(set_file))
            for k in set_path.split("."):
                S = S[int(k)] if isinstance(S, list) else S[k]
            yS = y_from_set(P, Tb, S)
            l = cone["l"]
            Zp = Z.copy(); Zp[:l] = 0.0
            V = (-data["A"]).tocsr(); C = data["b"]; cvec = -data["c"]
            a = V.T @ Zp + cvec
            mu, lam = np.maximum(0.0, a), np.maximum(0.0, -a)
            N = oc + C @ Zp + mu.sum()
            sval = oc + cvec @ yS
            slack = C + V @ yS
            t1, t2, t3 = float(Zp[l:] @ slack[l:]), float(lam @ yS), float(mu @ (1 - yS))
            diff = abs((N - sval) - (t1 + t2 + t3))
            plant = abs((oc + C @ Zp - sval) - (t1 + t2))
            rec.update(set_size=len(set(S)), identity_difference=diff, terms=[t1, t2, t3], plant_mu_dropped_difference=plant,
                       plant_fired=bool(plant > 1e-6), identity_holds=bool(diff < 1e-8 and min(t1, t2, t3) >= -1e-9))
            log(f"[evaluate] identity at |S| = {len(set(S))}: N - s = {N - sval:.9f} vs terms {t1:.6f} + {t2:.6f} + {t3:.6f}; "
                f"difference {diff:.2e}; PLANT (mu dropped) difference {plant:.2e} -> {'FIRED' if plant > 1e-6 else 'DID NOT FIRE'}")
        return rec
    finally:
        Path(snap).unlink(missing_ok=True)


def random_sets_control(q, modulus, count, seed, family="l3", log=print):
    P = Plane(q, modulus)
    dreps, _, _ = d_classes(P)
    Tb = Tables(P, dreps, log=lambda *a: None)
    blocks = build(P, Tb, family, dreps)
    oc, c = objective(P, Tb)
    rng = np.random.default_rng(seed)
    out = []
    for t in range(count):
        order = rng.permutation(P.n)
        S, blocked = [], np.zeros(P.n, bool)
        for v in order:
            if not blocked[v]:
                S.append(int(v)); blocked[v] = True; blocked |= P.unit[P.SUB[:, v]]
        y = y_from_set(P, Tb, S)
        worst = min(np.linalg.eigvalsh(block_matrix(m, r, cc, v, const, y))[0] for (lab, m, r, cc, v, const) in blocks)
        obj = oc + c @ y
        ok = bool(abs(obj - len(S)) < 1e-9 and worst > -1e-9)
        out.append(dict(size=len(S), objective=float(obj), least_eigenvalue=float(worst), ok=ok))
        log(f"[randsets] q={q} set {t}: |S| = {len(S)}, objective {obj:.9f}, least block eigenvalue {worst:.2e} -> {'PASS' if ok else 'FAIL'}")
    return dict(q=q, seed=seed, sets=len(out), all_pass=all(o["ok"] for o in out), results=out)


def selftest(log=print):
    """SCS's PSD vectorisation, as this tool writes it (lower triangle, column-major, off-diagonal x sqrt 2), against a
    problem with a known answer that a wrong convention changes: max x s.t. [[1,x,0],[x,4,0.5],[0,0.5,1]] PSD."""
    import scs, scipy.sparse as sp
    m = 3
    # s = const + vals * x ; entries: (0,0)=1, (1,0)=x, (1,1)=4, (2,1)=0.5, (2,2)=1
    def vi(i, j):
        return j * (2 * m - j + 1) // 2 + (i - j)
    const = np.zeros(6)
    const[vi(0, 0)] = 1; const[vi(1, 1)] = 4; const[vi(2, 1)] = 0.5 * math.sqrt(2); const[vi(2, 2)] = 1
    A = sp.csc_matrix((np.array([-math.sqrt(2)]), (np.array([vi(1, 0)]), np.array([0]))), shape=(6, 1))
    sol = scs.SCS(dict(A=A, b=const, c=np.array([-1.0])), dict(s=[3]), eps_abs=1e-9, eps_rel=1e-9, verbose=False).solve()
    x = sol["x"][0]
    # the truth: det of [[1,x],[x,4]] with the 0.5 coupling: max x with [[1,x,0],[x,4,.5],[0,.5,1]] PSD -> 1*(4 - .25) - x^2 = 0
    truth = math.sqrt(3.75)
    M = block_matrix(3, np.array([vi(1, 0)]), np.array([0]), np.array([math.sqrt(2)]), const, np.array([truth]))
    ok = abs(x - truth) < 1e-5 and abs(np.linalg.eigvalsh(M)[0]) < 1e-9
    log(f"[selftest] SCS returned x = {x:.7f}, truth sqrt(3.75) = {truth:.7f}; block_matrix at the truth has least eigenvalue "
        f"{np.linalg.eigvalsh(M)[0]:.2e} -> {'PASS' if ok else 'FAIL'}")
    return ok


# ======================================================================================================================
# THE LEAN PATH (FS-54 D4 at q = 47).  The same programme, built by the same functions (canon, blocks_for, le_diag_rows,
# pattern_terms), but: the canonical-form tables in forked worker processes and stored as int32 upper triangles; every
# block compressed to CSR in its worker (duplicates summed, exact zeros dropped); the constraint matrix held as V = -A
# (int32 indices) with no COO stage; the instance cached on disk; the ADMM's vector work in numba-parallel kernels with
# the SAME iteration as admm_solve (rhs combined as mu*bs + V^T(C - S - mu X), which is the same vector); the PSD
# projection either in a CPU thread pool (numba unpack/pack without the GIL, LAPACK eigh) or on a GPU through cuSOLVER's
# batched symmetric eigensolver.  `lean-compare` checks the lean V, C, bs, cone and objective constant against
# assemble_scs at small q, so the lean path is shown to be the same derivation's data, not re-derived.
# ======================================================================================================================
_FORK = {}          # state inherited by forked workers (Python 3.14 defaults to forkserver; the fork context is explicit)


def _fork_pool(workers):
    import multiprocessing as mp
    return mp.get_context("fork").Pool(workers)      # Pool forks every worker in __init__, before its handler threads


def _tri_index(n, u, v):
    """position of the unordered pair {u, v} in np.triu_indices(n) order (u <= v)"""
    a, b = np.minimum(u, v).astype(np.int64), np.maximum(u, v).astype(np.int64)
    return a * n - a * (a - 1) // 2 + (b - a)


def _lean_keys_worker(j):
    P, iu, iv, first, chunk = _FORK["P"], _FORK["iu"], _FORK["iv"], _FORK["firsts"][j], _FORK["chunk"]
    keys = np.empty(len(iu), dtype=np.int64)
    t = time.time()
    for s in range(0, len(iu), chunk):
        u, v = iu[s:s + chunk], iv[s:s + chunk]
        cols = [np.zeros_like(u)] + ([np.full_like(u, first)] if first is not None else []) + [u, v]
        keys[s:s + chunk] = P.canon(np.stack(cols, axis=1))
    return j, keys, time.time() - t


class _FullFromTri:
    """Tb.V4 on the lean path: d -> the full n x n int32 id table, expanded on demand from its upper triangle (one cached)"""

    def __init__(self, n, iu, iv, tri):
        self.n, self.iu, self.iv, self.tri = n, iu, iv, tri
        self._d, self._full = None, None

    def __getitem__(self, d):
        if self._d != d:
            full = np.empty((self.n, self.n), dtype=np.int32)
            full[self.iu, self.iv] = self.tri[d]
            full[self.iv, self.iu] = self.tri[d]
            self._d, self._full = d, full
        return self._full

    def __contains__(self, d):
        return d in self.tri


class LeanTables:
    """Tables' variable numbering (identical: the same key set, ordered by size then key), built in `workers` forked
    processes; V3 a full int32 table, V4 upper triangles expanded on demand."""

    def __init__(self, P, dreps, workers=14, log=print, chunk=1000):
        # chunk: sets per canon call.  Measured at q = 47 (2026-09-16): 40,000 gives 152k sets/s over 14 workers (memory-
        # bandwidth bound, no parallel gain); 1,000 gives 2.33M/s.  The first q = 47 build used 40,000 (722 s of tables).
        n = P.n
        t0 = time.time()
        iu, iv = np.triu_indices(n)
        firsts = [None] + [int(d) for d in dreps]
        _FORK.update(P=P, iu=iu, iv=iv, firsts=firsts, chunk=chunk)
        keys = [None] * len(firsts)
        with _fork_pool(workers) as pool:
            for j, k, dt in pool.imap_unordered(_lean_keys_worker, range(len(firsts))):
                keys[j] = k
                log(f"[lean-tables] q={P.q}: table {'T3' if firsts[j] is None else 'T4 d=' + str(firsts[j])} in {dt:.1f} s "
                    f"({sum(x is not None for x in keys)}/{len(firsts)}, {time.time()-t0:.0f} s elapsed)")
        t1 = time.time()
        allkeys = np.unique(np.concatenate([np.unique(k) for k in keys]))
        size, indep = P.key_size_and_indep(allkeys)
        var = np.full(len(allkeys), KILLED, dtype=np.int64)
        var[size == 1] = CONST
        live = (size >= 2) & indep
        order = np.nonzero(live)[0]
        order = order[np.lexsort((allkeys[order], size[order]))]
        var[order] = np.arange(len(order))
        self.keys, self.size, self.indep, self.var = allkeys, size, indep, var
        self.nvar = len(order)
        self.var_size = size[order]
        self.var_key = allkeys[order]
        assert self.nvar < 2 ** 31
        tri = {}
        for j, f in enumerate(firsts):
            ids = var[np.searchsorted(allkeys, keys[j])].astype(np.int32)
            keys[j] = None
            if f is None:
                V3 = np.empty((n, n), dtype=np.int32)
                V3[iu, iv] = ids
                V3[iv, iu] = ids
                self.V3 = V3
            else:
                tri[f] = ids
        self.V4 = _FullFromTri(n, iu, iv, tri)
        self.iu, self.iv = iu, iv
        log(f"[lean-tables] q={P.q}: {self.nvar} live variables (size 2: {int((self.var_size==2).sum())}, "
            f"3: {int((self.var_size==3).sum())}, 4: {int((self.var_size==4).sum())}); numbering {time.time()-t1:.1f} s; "
            f"{time.time()-t0:.1f} s total")


def _compress_block(nvar, label, m, rows, cols, vals, const):
    """one block's (rows, cols, vals) -> CSR (local rows 0..L-1): duplicates summed, exact zeros dropped, columns sorted"""
    L = m * (m + 1) // 2
    key = rows.astype(np.int64) * nvar + cols.astype(np.int64)
    uk, inv = np.unique(key, return_inverse=True)
    sv = np.bincount(inv.ravel(), weights=vals, minlength=len(uk))
    keep = sv != 0.0
    uk, sv = uk[keep], sv[keep]
    r = uk // nvar
    indptr = np.zeros(L + 1, dtype=np.int64)
    np.cumsum(np.bincount(r, minlength=L), out=indptr[1:])
    return (label, m, indptr, (uk % nvar).astype(np.int32), sv, const)


def _lean_units(P, family, dreps):
    """the (pattern, d) units in build()'s order"""
    units = []
    for pat in FAMILIES[family]:
        if pat in ("LD", "Y", "MY"):
            units.append((pat, 0))
            continue
        for d in dreps:
            if P.unit[d] and pat in ("++", "+-"):
                continue
            units.append((pat, int(d)))
    return units


def _lean_block_worker(unit):
    P, Tb, border, s0 = _FORK["P"], _FORK["Tb"], _FORK["border"], _FORK["s0"]
    pat, d = unit
    t = time.time()
    if pat == "LD":
        raw = le_diag_rows(P, Tb)
    elif pat in ("Y", "MY"):
        raw = list(blocks_for(P, Tb, pat, 0, border=border and pat == "MY", s0=s0))
    else:
        raw = list(blocks_for(P, Tb, pat, d, border=border and pat == "--", s0=s0))
    out = [_compress_block(Tb.nvar, *bl) for bl in raw]
    return unit, out, time.time() - t


def lean_build_blocks(P, Tb, family, dreps, border=False, s0=None, workers=14, log=print):
    units = _lean_units(P, family, dreps)
    _FORK.update(P=P, Tb=Tb, border=border, s0=s0)
    res = {}
    t0 = time.time()
    with _fork_pool(workers) as pool:
        for unit, out, dt in pool.imap_unordered(_lean_block_worker, units):
            res[unit] = out
            if len(res) % 10 == 0 or len(res) == len(units):
                log(f"[lean-blocks] {len(res)}/{len(units)} matrices ({time.time()-t0:.0f} s elapsed; last {unit} {dt:.1f} s)")
    blocks = []
    for u in units:
        blocks += res.pop(u)
    return blocks


def lean_assemble(P, Tb, blocks, nonneg=True, log=print):
    """V = -A, C = b, bs = SCS's c, in assemble_scs's row order (y >= 0 rows, then 1x1 blocks, then the PSD blocks)."""
    import scipy.sparse as sp
    nv = Tb.nvar
    lin = [bl for bl in blocks if bl[1] == 1]
    psd = [bl for bl in blocks if bl[1] > 1]
    blocks.clear()
    ordered = lin + psd
    lin.clear(); psd.clear()
    n0 = nv if nonneg else 0
    nrows = n0 + sum(bl[1] * (bl[1] + 1) // 2 for bl in ordered)
    nnz = n0 + sum(len(bl[3]) for bl in ordered)
    idt = np.int32 if nnz < 2 ** 31 - 1 else np.int64
    indptr = np.empty(nrows + 1, dtype=idt)
    indices = np.empty(nnz, dtype=idt)
    data = np.empty(nnz)
    C = np.zeros(nrows)
    indptr[:n0 + 1] = np.arange(n0 + 1)
    indices[:n0] = np.arange(n0)
    data[:n0] = 1.0
    ro, no = n0, n0
    labels, offsets, dims = [], [], []
    for k in range(len(ordered)):
        label, m, ip, ind, val, const = ordered[k]
        ordered[k] = None
        L = m * (m + 1) // 2
        indptr[ro + 1:ro + L + 1] = ip[1:] + no
        indices[no:no + len(ind)] = ind
        data[no:no + len(ind)] = val
        C[ro:ro + L] = const
        if m > 1:
            labels.append(label); offsets.append(ro); dims.append(m)
        ro += L
        no += len(ind)
    assert ro == nrows and no == nnz
    V = sp.csr_matrix((data, indices, indptr), shape=(nrows, nv), copy=False)
    oc, cvec = objective(P, Tb)
    cone = dict(z=0, l=nrows - sum(m * (m + 1) // 2 for m in dims), s=dims)     # the y >= 0 rows and the 1x1 blocks
    return dict(V=V, C=C, bs=-cvec, oc=oc, cone=cone, labels=labels, offsets=offsets, nb=int((Tb.var_size < 4).sum()))


# --------------------------------------------------------------------------------------------------- numba kernels
_NB = {}


def numba_kernels():
    if _NB:
        return _NB
    here = str(Path(__file__).resolve().parent)       # tools/coverage.py would shadow the coverage package numba probes for
    saved = list(sys.path)
    sys.path[:] = [p for p in sys.path if Path(p or ".").resolve() != Path(here)]
    try:
        import numba as nb
    finally:
        sys.path[:] = saved

    @nb.njit(parallel=True, cache=False)
    def matvec(indptr, indices, data, x, out, bounds):
        for c in nb.prange(len(bounds) - 1):
            for r in range(bounds[c], bounds[c + 1]):
                acc = 0.0
                for k in range(indptr[r], indptr[r + 1]):
                    acc += data[k] * x[indices[k]]
                out[r] = acc

    @nb.njit(parallel=True)
    def c_minus_s_minus_mux(C, S, X, mu, out):          # out = C - S - mu X
        for i in nb.prange(len(C)):
            out[i] = C[i] - S[i] - mu * X[i]

    @nb.njit(parallel=True)
    def w_update(C, Vy, X, mu, W):                      # W = C - Vy - mu X
        for i in nb.prange(len(C)):
            W[i] = C[i] - Vy[i] - mu * X[i]

    @nb.njit(parallel=True)
    def x_update(X, S, W, mu, gamma):                   # X = (1-gamma) X + gamma (S - W)/mu
        a, b = 1.0 - gamma, gamma / mu
        for i in nb.prange(len(X)):
            X[i] = a * X[i] + b * (S[i] - W[i])

    @nb.njit(parallel=True)
    def resid_norm2(C, Vy, S):                          # ||C - Vy - S||^2
        acc = 0.0
        for i in nb.prange(len(C)):
            t = C[i] - Vy[i] - S[i]
            acc += t * t
        return acc

    @nb.njit(parallel=True)
    def pdot(a, b):
        acc = 0.0
        for i in nb.prange(len(a)):
            acc += a[i] * b[i]
        return acc

    @nb.njit(nogil=True)
    def unpack(w, o, m, M):                             # SCS scaled lower triangle, column-major -> dense symmetric
        r2 = 1.0 / math.sqrt(2.0)
        idx = o
        for j in range(m):
            M[j, j] = w[idx]; idx += 1
            for i in range(j + 1, m):
                v = w[idx] * r2; idx += 1
                M[i, j] = v; M[j, i] = v

    @nb.njit(nogil=True)
    def pack(M, o, m, out):
        s2 = math.sqrt(2.0)
        idx = o
        for j in range(m):
            out[idx] = M[j, j]; idx += 1
            for i in range(j + 1, m):
                out[idx] = M[i, j] * s2; idx += 1

    @nb.njit(parallel=True)
    def unpack_batch(w, offs, m, H):                    # H: (b, m*m) column-major per matrix
        r2 = 1.0 / math.sqrt(2.0)
        for k in nb.prange(len(offs)):
            idx = offs[k]
            for j in range(m):
                H[k, j * m + j] = w[idx]; idx += 1
                for i in range(j + 1, m):
                    v = w[idx] * r2; idx += 1
                    H[k, j * m + i] = v; H[k, i * m + j] = v

    @nb.njit(parallel=True)
    def pack_batch(H, offs, m, out):
        s2 = math.sqrt(2.0)
        for k in nb.prange(len(offs)):
            idx = offs[k]
            for j in range(m):
                out[idx] = H[k, j * m + j]; idx += 1
                for i in range(j + 1, m):
                    out[idx] = H[k, j * m + i] * s2; idx += 1

    @nb.njit(parallel=True)
    def clip0(w, out, l):
        for i in nb.prange(l):
            out[i] = w[i] if w[i] > 0.0 else 0.0

    _NB.update(matvec=matvec, c_minus_s_minus_mux=c_minus_s_minus_mux, w_update=w_update, x_update=x_update,
               resid_norm2=resid_norm2, pdot=pdot, unpack=unpack, pack=pack, unpack_batch=unpack_batch,
               pack_batch=pack_batch, clip0=clip0)
    return _NB


def _balanced_bounds(indptr, parts):
    nnz = int(indptr[-1])
    cuts = np.searchsorted(indptr, np.linspace(0, nnz, parts + 1).astype(np.int64))
    cuts[0], cuts[-1] = 0, len(indptr) - 1
    return np.unique(cuts).astype(np.int64)


class ParSparse:
    """a CSR matrix with a numba-parallel matvec (rows split into nnz-balanced chunks)"""

    def __init__(self, M, parts=64):
        self.M = M
        self.indptr, self.indices, self.data = M.indptr, M.indices, M.data
        self.bounds = _balanced_bounds(M.indptr, parts)
        self.shape = M.shape

    def dot(self, x, out=None):
        if out is None:
            out = np.empty(self.shape[0])
        numba_kernels()["matvec"](self.indptr, self.indices, self.data, x, out, self.bounds)
        return out


class LeanCpuProjector:
    """nonneg^l x PSD blocks; blocks in a thread pool: numba unpack/pack (GIL released) and LAPACK eigh; the projection is
    rebuilt from the smaller side of the spectrum (U+ U+^T or M + U- U-^T, the same matrix).  Run with BLAS single-threaded."""

    def __init__(self, cone, threads=14):
        from concurrent.futures import ThreadPoolExecutor
        self.pool = ThreadPoolExecutor(threads)
        self.l = cone["l"]
        self.jobs = []
        off = self.l
        for m in cone["s"]:
            self.jobs.append((off, m))
            off += m * (m + 1) // 2
        self.total = off
        order = sorted(range(len(self.jobs)), key=lambda k: -self.jobs[k][1])      # big blocks first
        self.jobs = [self.jobs[k] for k in order]
        self.tim = dict(cone=0.0)
        numba_kernels()

    def _one(self, args):
        w, out, o, m = args
        K = _NB
        M = np.empty((m, m))
        K["unpack"](w, o, m, M)
        ev, U = np.linalg.eigh(M)
        npos = int((ev > 0).sum())
        if npos <= m - npos:
            Up = U[:, ev > 0] * np.sqrt(ev[ev > 0])
            P = Up @ Up.T
        else:
            Un = U[:, ev < 0] * np.sqrt(-ev[ev < 0])
            P = M + Un @ Un.T
        K["pack"](P, o, m, out)
        return float(ev[0])

    def project(self, w, want_min=False, out=None):
        t = time.time()
        if out is None:
            out = np.empty_like(w)
        _NB["clip0"](w, out, self.l)
        mins = list(self.pool.map(self._one, [(w, out, o, m) for (o, m) in self.jobs]))
        self.tim["cone"] += time.time() - t
        return (out, min(mins)) if want_min else out


class GpuProjector:
    """the PSD blocks on one CUDA device (pin it with CUDA_VISIBLE_DEVICES=<UUID>): blocks grouped by order, each group
    unpacked into pinned host memory (numba), copied up, cusolverDnXsyevBatched (all eigenpairs), eigenvalues brought back
    and clipped, U diag(sqrt(max(ev,0))) by cublasDdgmm, its Gram matrix by cublasDgemmStridedBatched, copied down and
    packed.  Every call's status and every batch's info array are checked."""

    def __init__(self, cone, libdir="/opt/cuda/lib64", log=print):
        import ctypes
        from collections import OrderedDict
        c = ctypes
        self.c = c
        self.cudart = c.CDLL(f"{libdir}/libcudart.so")
        self.cus = c.CDLL(f"{libdir}/libcusolver.so")
        self.cub = c.CDLL(f"{libdir}/libcublas.so")
        V, I64, SZ = c.c_void_p, c.c_int64, c.c_size_t
        self.cudart.cudaMalloc.argtypes = [c.POINTER(V), SZ]
        self.cudart.cudaHostAlloc.argtypes = [c.POINTER(V), SZ, c.c_uint]
        self.cudart.cudaMemcpy.argtypes = [V, V, SZ, c.c_int]
        self.cus.cusolverDnXsyevBatched_bufferSize.argtypes = [V, V, c.c_int, c.c_int, I64, c.c_int, V, I64, c.c_int, V,
                                                                 c.c_int, c.POINTER(SZ), c.POINTER(SZ), I64]
        self.cus.cusolverDnXsyevBatched.argtypes = [V, V, c.c_int, c.c_int, I64, c.c_int, V, I64, c.c_int, V, c.c_int,
                                                      V, SZ, V, SZ, V, I64]
        self.cub.cublasDdgmm.argtypes = [V, c.c_int, c.c_int, c.c_int, V, c.c_int, V, c.c_int, V, c.c_int]
        self.cub.cublasDgemmStridedBatched.argtypes = [V, c.c_int, c.c_int, c.c_int, c.c_int, c.c_int, c.POINTER(c.c_double),
                                                       V, c.c_int, c.c_longlong, V, c.c_int, c.c_longlong,
                                                       c.POINTER(c.c_double), V, c.c_int, c.c_longlong, c.c_int]
        dev = V()
        self.sh = V(); self._chk(self.cus.cusolverDnCreate(c.byref(self.sh)), "cusolverDnCreate")
        self.bh = V(); self._chk(self.cub.cublasCreate_v2(c.byref(self.bh)), "cublasCreate")
        self.params = V(); self._chk(self.cus.cusolverDnCreateParams(c.byref(self.params)), "CreateParams")
        self.l = cone["l"]
        groups = OrderedDict()
        off = self.l
        for m in cone["s"]:
            groups.setdefault(m, []).append(off)
            off += m * (m + 1) // 2
        self.total = off
        self.groups = [(m, np.array(offs, dtype=np.int64)) for m, offs in sorted(groups.items())]
        maxel = max(m * m * len(offs) for m, offs in self.groups)
        maxev = max(m * len(offs) for m, offs in self.groups)
        maxb = max(len(offs) for m, offs in self.groups)
        self.dA = self._malloc(8 * maxel); self.dU = self._malloc(8 * maxel); self.dP = self._malloc(8 * maxel)
        self.dW = self._malloc(8 * maxev); self.dinfo = self._malloc(4 * maxb)
        self.hIn = self._host(maxel); self.hOut = self._host(maxel); self.hW = self._host(maxev)
        wsd, wsh = 0, 0
        for m, offs in self.groups:
            a, b = SZ(), SZ()
            self._chk(self.cus.cusolverDnXsyevBatched_bufferSize(self.sh, self.params, 1, 0, m, 1, self.dA, m, 1, self.dW, 1,
                                                                 c.byref(a), c.byref(b), len(offs)), "XsyevBatched_bufferSize")
            wsd, wsh = max(wsd, a.value), max(wsh, b.value)
        self.wsd, self.wsh = wsd, wsh
        self.dWork = self._malloc(max(1, wsd))
        self.hWork = (c.c_char * max(1, wsh))()
        self.tim = dict(unpack=0.0, h2d=0.0, eig=0.0, recon=0.0, d2h=0.0, pack=0.0)
        numba_kernels()
        log(f"[gpu] {len(self.groups)} block orders {[(m, len(o)) for m, o in self.groups]}; device buffers "
            f"{3*8*maxel/2**30:.2f} GiB + eig workspace {wsd/2**30:.2f} GiB; pinned host {2*8*maxel/2**30:.2f} GiB")

    def _chk(self, r, what):
        if r != 0:
            raise RuntimeError(f"CUDA call {what} returned status {r}")

    def _malloc(self, nbytes):
        p = self.c.c_void_p(); self._chk(self.cudart.cudaMalloc(self.c.byref(p), nbytes), "cudaMalloc"); return p

    def _host(self, count):
        p = self.c.c_void_p(); self._chk(self.cudart.cudaHostAlloc(self.c.byref(p), 8 * count, 0), "cudaHostAlloc")
        return np.ctypeslib.as_array((self.c.c_double * count).from_address(p.value))

    def _h2d(self, dst, arr):
        self._chk(self.cudart.cudaMemcpy(dst, arr.ctypes.data, arr.nbytes, 1), "memcpy h2d")

    def _d2h(self, arr, src):
        self._chk(self.cudart.cudaMemcpy(arr.ctypes.data, src, arr.nbytes, 2), "memcpy d2h")

    def _sync(self):
        self._chk(self.cudart.cudaDeviceSynchronize(), "synchronize")

    def project(self, w, want_min=False, out=None):
        c, K, T = self.c, numba_kernels(), self.tim
        if out is None:
            out = np.empty_like(w)
        K["clip0"](w, out, self.l)
        lam_min = np.inf
        one, zero = c.c_double(1.0), c.c_double(0.0)
        for m, offs in self.groups:
            b, mm = len(offs), m * m
            t0 = time.time()
            H = self.hIn[:b * mm].reshape(b, mm)
            K["unpack_batch"](w, offs, m, H)
            t1 = time.time(); T["unpack"] += t1 - t0
            self._h2d(self.dA, H)
            t2 = time.time(); T["h2d"] += t2 - t1
            self._chk(self.cus.cusolverDnXsyevBatched(self.sh, self.params, 1, 0, m, 1, self.dA, m, 1, self.dW, 1,
                                                      self.dWork, self.wsd, self.hWork, self.wsh, self.dinfo, b),
                      "XsyevBatched")
            ev = self.hW[:b * m].reshape(b, m)
            self._d2h(ev, self.dW)
            info = np.empty(b, dtype=np.int32)
            self._d2h(info, self.dinfo)
            if np.any(info != 0):
                raise RuntimeError(f"XsyevBatched info nonzero at order {m}: {info[info != 0][:5]}")
            t3 = time.time(); T["eig"] += t3 - t2
            lam_min = min(lam_min, float(ev.min()))
            np.sqrt(np.maximum(ev, 0.0), out=ev)
            self._h2d(self.dW, ev)
            for k in range(b):
                self._chk(self.cub.cublasDdgmm(self.bh, 1, m, m, self.dA.value + 8 * k * mm, m, self.dW.value + 8 * k * m, 1,
                                               self.dU.value + 8 * k * mm, m), "Ddgmm")
            self._chk(self.cub.cublasDgemmStridedBatched(self.bh, 0, 1, m, m, m, c.byref(one), self.dU, m, mm, self.dU, m, mm,
                                                         c.byref(zero), self.dP, m, mm, b), "DgemmStridedBatched")
            self._sync()
            t4 = time.time(); T["recon"] += t4 - t3
            Ho = self.hOut[:b * mm].reshape(b, mm)
            self._d2h(Ho, self.dP)
            t5 = time.time(); T["d2h"] += t5 - t4
            K["pack_batch"](Ho, offs, m, out)
            T["pack"] += time.time() - t5
        return (out, lam_min) if want_min else out


# --------------------------------------------------------------------------------------------------- instance cache
def _sha256_arrays(arrs):
    import hashlib
    h = hashlib.sha256()
    for a in arrs:
        h.update(memoryview(np.ascontiguousarray(a)).cast("B"))
    return h.hexdigest()


def lean_fingerprint(q, modulus, family, dreps, border, s0, inst):
    V, cone = inst["V"], inst["cone"]
    return dict(q=q, modulus=modulus, family=family, dclasses=[int(d) for d in dreps], border=bool(border), s0=s0,
                nvar=int(V.shape[1]), rows=int(V.shape[0]), nnz=int(V.nnz), psd=len(cone["s"]),
                psd_max=int(max(cone["s"])), method="admm-lean")


def save_instance(dirpath, inst, Tb, fp, meta, log=print):
    d = Path(dirpath)
    d.mkdir(parents=True, exist_ok=False)
    t = time.time()
    arrs = dict(V_indptr=inst["V"].indptr, V_indices=inst["V"].indices, V_data=inst["V"].data, C=inst["C"], bs=inst["bs"],
                keys=Tb.keys, var=Tb.var, var_size=Tb.var_size)
    for k, a in arrs.items():
        np.save(d / f"{k}.npy", a)
    man = dict(fingerprint=fp, oc=inst["oc"], cone=inst["cone"], labels=inst["labels"], offsets=[int(o) for o in inst["offsets"]],
               nb=int((Tb.var_size < 4).sum()), sha256_V=_sha256_arrays([arrs["V_indptr"], arrs["V_indices"], arrs["V_data"]]),
               sha256_C_bs=_sha256_arrays([arrs["C"], arrs["bs"]]), meta=meta)
    (d / "manifest.json").write_text(json.dumps(man, indent=1, default=float))
    log(f"[instance] saved {d} in {time.time()-t:.1f} s")


def load_instance(dirpath, verify=True, log=print):
    import scipy.sparse as sp
    d = Path(dirpath)
    t = time.time()
    man = json.loads((d / "manifest.json").read_text())
    ld = {k: np.load(d / f"{k}.npy") for k in ("V_indptr", "V_indices", "V_data", "C", "bs", "keys", "var", "var_size")}
    if verify:
        hv = _sha256_arrays([ld["V_indptr"], ld["V_indices"], ld["V_data"]])
        hc = _sha256_arrays([ld["C"], ld["bs"]])
        if hv != man["sha256_V"] or hc != man["sha256_C_bs"]:
            raise SystemExit(f"instance {d} does not match its manifest digests: refusing it")
    fp = man["fingerprint"]
    V = sp.csr_matrix((ld["V_data"], ld["V_indices"], ld["V_indptr"]), shape=(fp["rows"], fp["nvar"]), copy=False)
    inst = dict(V=V, C=ld["C"], bs=ld["bs"], oc=man["oc"], cone=man["cone"], labels=man["labels"], offsets=man["offsets"],
                nb=int(man["nb"]))
    log(f"[instance] loaded {d} ({'digests verified' if verify else 'digests NOT verified'}) in {time.time()-t:.1f} s")
    return inst, man, ld


def lean_build(q, modulus, family, dclass_arg, border, s0, workers, log=print):
    t0 = time.time()
    P = Plane(q, modulus)
    dreps, dcnt, _ = d_classes(P)
    one_point = all(pat in ("Y", "MY", "LD") for pat in FAMILIES[family])
    # a one-point family (the triple level) touches no 4-set: its tables are T3 alone, and its variables the pairs and triples
    Tb = LeanTables(P, [] if one_point else dreps, workers=workers, log=log)
    t1 = time.time()
    chosen = dreps if dclass_arg in (None, "all") else [int(x) for x in dclass_arg.split(",")]
    blocks = lean_build_blocks(P, Tb, family, chosen, border=border, s0=s0, workers=workers, log=log)
    t2 = time.time()
    sizes = [bl[1] for bl in blocks]
    inst = lean_assemble(P, Tb, blocks, log=log)
    t3 = time.time()
    V = inst["V"]
    meta = dict(G0=len(P.G0), aut=P.aut_order, d_class_reps=[int(x) for x in dreps], d_class_sizes=dcnt,
                d_class_unit=[int(d) for d in dreps if P.unit[d]], nvar=int(Tb.nvar),
                nvar_by_size={k: int((Tb.var_size == k).sum()) for k in (2, 3, 4)},
                blocks=len([m for m in sizes if m > 1]), linear_1x1_blocks=len([m for m in sizes if m == 1]),
                block_sizes_hist={int(k): int(v) for k, v in zip(*np.unique(sizes, return_counts=True))},
                psd_rows=int(sum(m * (m + 1) // 2 for m in sizes if m > 1)), sum_cubes=float(sum(float(m) ** 3 for m in sizes if m > 1)),
                rows=int(V.shape[0]), nnz=int(V.nnz), V_bytes=int(V.data.nbytes + V.indices.nbytes + V.indptr.nbytes),
                index_dtype=str(V.indices.dtype), seconds_tables=t1 - t0, seconds_blocks=t2 - t1, seconds_assemble=t3 - t2,
                workers=workers)
    log(f"[lean-build] q={q} {family}: {meta['nvar']} variables {meta['nvar_by_size']}; {meta['blocks']} PSD blocks "
        f"{meta['block_sizes_hist']}; rows {meta['rows']}; nnz {meta['nnz']} ({meta['V_bytes']/2**30:.2f} GiB, {meta['index_dtype']}); "
        f"tables {t1-t0:.0f} s, blocks {t2-t1:.0f} s, assemble {t3-t2:.0f} s")
    return P, Tb, chosen, inst, meta


# -------------------------------------------------------------------------------------------- controls on the lean path
def _yset_worker(firsts):
    import itertools
    P, keys, var, nvar, S, g0, chunk = (_FORK[k] for k in ("P", "keys", "var", "nvar", "S", "g0", "chunk"))
    s = len(S)
    parts_i, parts_w = [], []            # one bincount at the end: a per-chunk bincount over nvar entries is memory-bound
    for i in firsts:
        for k in (2, 3, 4):
            combos = itertools.combinations(range(i + 1, s), k - 1)
            while True:
                blk = np.array(list(itertools.islice(combos, chunk)), dtype=np.int64)
                if len(blk) == 0:
                    break
                T = np.concatenate([np.full((len(blk), 1), i, dtype=np.int64), blk], axis=1)
                kk, mult = P.canon(S[T], want_mult=True)
                pos = np.searchsorted(keys, kk)
                assert np.all(keys[np.minimum(pos, len(keys) - 1)] == kk), "a subset of S has an orbit no table touches"
                ids = var[pos]
                assert np.all(ids >= 0), "a subset of S is killed: S is not independent"
                parts_i.append(ids.astype(np.int32)); parts_w.append(mult / (s * g0))
    if not parts_i:
        return np.zeros(nvar)
    return np.bincount(np.concatenate(parts_i), weights=np.concatenate(parts_w), minlength=nvar)


def lean_y_from_set(P, keys, var, nvar, S, workers=14, log=print, chunk=1000):
    """y_from_set, the same formula, with the subsets split by their least member across forked workers"""
    from math import comb
    S = np.array(sorted(set(int(x) for x in S)), dtype=np.int64)
    s = len(S)
    work = [(comb(s - 1 - i, 3) + comb(s - 1 - i, 2) + comb(s - 1 - i, 1), i) for i in range(s)]
    nbins = max(1, 3 * workers)
    bins = [[0, []] for _ in range(nbins)]
    for w, i in sorted(work, reverse=True):
        b = min(bins, key=lambda x: x[0]); b[0] += w; b[1].append(i)
    _FORK.update(P=P, keys=keys, var=var, nvar=nvar, S=S, g0=len(P.G0), chunk=chunk)
    t = time.time()
    y = np.zeros(nvar)
    with _fork_pool(workers) as pool:
        for part in pool.imap_unordered(_yset_worker, [b[1] for b in bins if b[1]]):
            y += part
    log(f"[lean-yset] y from a {s}-set ({comb(s,4)} 4-subsets) in {time.time()-t:.0f} s")
    return y


def lean_checkset(inst, y, workers=14, log=print, plants=True):
    """objective at y(S) and the least eigenvalue of every PSD block of s = C + V y(S), from the ASSEMBLED data (the
    solver's own).  Plants: (a) the '--' blocks with their 4-set term removed; (b) y's 4-set part permuted."""
    from concurrent.futures import ThreadPoolExecutor
    K = numba_kernels()
    V, C, bs, oc, cone = inst["V"], inst["C"], inst["bs"], inst["oc"], inst["cone"]
    PV = ParSparse(V)
    l = cone["l"]
    labels, offsets, dims = inst["labels"], inst["offsets"], cone["s"]

    def least_eigs(svec, which):
        def one(k):
            m, o = dims[k], offsets[k]
            M = np.empty((m, m)); K["unpack"](svec, o, m, M)
            return float(np.linalg.eigvalsh(M)[0]), labels[k]
        with ThreadPoolExecutor(workers) as ex:
            return list(ex.map(one, which))

    t = time.time()
    svec = C + PV.dot(y)
    obj = oc - float(bs @ y)
    lin_min = float(svec[:l].min())
    eigs = least_eigs(svec, range(len(dims)))
    worst = min(eigs)
    rec = dict(objective_at_set=obj, least_linear_slack=lin_min, least_eigenvalue=worst[0], at=worst[1],
               blocks_checked=len(eigs), seconds=time.time() - t)
    log(f"[lean-checkset] objective {obj:.9f}; least linear slack {lin_min:.2e}; least eigenvalue over {len(eigs)} blocks "
        f"{worst[0]:.3e} ({worst[1]}); {time.time()-t:.0f} s")
    if plants:
        nb = int(inst["nb"])
        mm = [k for k in range(len(dims)) if labels[k].startswith("--@")]
        # (a) remove the 4-set term from every '--' row: s' = s - V[--rows][:, 4-set cols] y
        y4 = y.copy(); y4[:nb] = 0.0
        s4 = PV.dot(y4)
        sa = svec.copy()
        for k in mm:
            o, L = offsets[k], dims[k] * (dims[k] + 1) // 2
            sa[o:o + L] -= s4[o:o + L]
        ea = min(least_eigs(sa, mm))
        # (b) permute y's 4-set part
        rng = np.random.default_rng(7)
        yb = y.copy(); yb[nb:] = rng.permutation(y[nb:])
        sb = C + PV.dot(yb)
        eb = min(least_eigs(sb, range(len(dims))))
        rec.update(plant_minus_minus_without_4set=dict(least_eigenvalue=ea[0], at=ea[1], fired=bool(ea[0] < -1e-6)),
                   plant_4set_permuted=dict(least_eigenvalue=eb[0], at=eb[1], fired=bool(eb[0] < -1e-6)))
        log(f"[lean-checkset] PLANT '--' without its 4-set term: least eigenvalue {ea[0]:.3e} ({ea[1]}) -> "
            f"{'FIRED' if ea[0] < -1e-6 else 'DID NOT FIRE'}")
        log(f"[lean-checkset] PLANT 4-set values permuted: least eigenvalue {eb[0]:.3e} ({eb[1]}) -> "
            f"{'FIRED' if eb[0] < -1e-6 else 'DID NOT FIRE'}")
    return rec


def _census_worker(args):
    lo, hi = args
    P, reps = _FORK["P"], _FORK["reps"]
    mult = np.concatenate([P.canon(reps[a:min(a + 1000, hi)], want_mult=True)[1] for a in range(lo, hi, 1000)])
    return float(np.sum(P.aut_order / mult)), mult


def lean_census(P, var_key, var_size, workers=14, log=print, chunk=50000):
    """census()'s completeness check (sum over orbit representatives of |Aut|/|Stab| against the direct count of
    independent k-sets), in parallel chunks; the G0-orbits-containing-0 measure is not computed."""
    n = P.n
    W = np.nonzero(~P.unit[P.SUB[np.arange(n), 0]] & (np.arange(n) != 0))[0]
    NA = (~P.unit[P.SUB[W[:, None], W[None, :]]]).astype(np.float64)
    np.fill_diagonal(NA, 0.0)
    direct = {2: n * len(W) / 2, 3: n * (NA.sum() / 2) / 3, 4: n * (float(np.sum(NA * (NA @ NA))) / 6) / 4}
    out = {}
    for k in (2, 3, 4):
        reps = P.decode(var_key[var_size == k])[:, :k]
        _FORK.update(P=P, reps=reps, k=k)
        t = time.time()
        total, hist = 0.0, {}
        with _fork_pool(workers) as pool:
            for s, mult in pool.imap_unordered(_census_worker, [(a, min(a + chunk, len(reps))) for a in range(0, len(reps), chunk)]):
                total += s
                for a, b in zip(*np.unique(mult, return_counts=True)):
                    hist[int(a)] = hist.get(int(a), 0) + int(b)
        out[k] = dict(aut_orbits=int(len(reps)), sum_aut_over_stab=total, direct_count=direct[k],
                      complete=bool(abs(total - direct[k]) < 0.5), stabiliser_hist=dict(sorted(hist.items())))
        log(f"[lean-census] q={P.q} k={k}: {len(reps)} Aut-orbits; sum |Aut|/|Stab| = {total:.0f} vs direct {direct[k]:.0f} -> "
            f"{'COMPLETE' if out[k]['complete'] else 'MISMATCH'} ({time.time()-t:.0f} s)")
    return out


def lean_compare(q, modulus, family, workers=4, log=print):
    """the lean path's data against assemble_scs (the path every earlier control ran on): V = -A entrywise, C = b, bs = c,
    cone and objective constant.  Summation order differs, so values are compared to a tolerance and the nnz difference
    (exact zeros one order produces and the other does not) is reported."""
    P = Plane(q, modulus)
    dreps, _, _ = d_classes(P)
    TbR = Tables(P, dreps, log=lambda *a: None)
    ref, cone_r, oc_r = assemble_scs(P, TbR, build(P, TbR, family, dreps))
    TbL = LeanTables(P, dreps, workers=workers, log=lambda *a: None)
    same_numbering = bool(np.array_equal(TbR.var_key, TbL.var_key) and np.array_equal(TbR.var_size, TbL.var_size))
    inst = lean_assemble(P, TbL, lean_build_blocks(P, TbL, family, dreps, workers=workers, log=lambda *a: None))
    Ar = ref["A"].tocsr(); Ar.sort_indices()
    Vl = inst["V"].copy(); Vl.sort_indices()
    D = (Vl + Ar)                                  # V = -A
    D.eliminate_zeros()
    maxdiff = float(np.abs(D.data).max()) if D.nnz else 0.0
    rec = dict(q=q, family=family, same_numbering=same_numbering, rows_ref=int(Ar.shape[0]), rows_lean=int(Vl.shape[0]),
               nnz_ref=int(Ar.nnz), nnz_lean=int(Vl.nnz), max_abs_entry_difference=maxdiff,
               max_abs_C_difference=float(np.abs(inst["C"] - ref["b"]).max()), bs_equal=bool(np.array_equal(inst["bs"], ref["c"])),
               cone_equal=bool(inst["cone"]["l"] == cone_r["l"] and list(inst["cone"]["s"]) == list(cone_r["s"])),
               oc_equal=bool(inst["oc"] == oc_r))
    rec["same"] = bool(same_numbering and rec["rows_ref"] == rec["rows_lean"] and maxdiff < 1e-12 and rec["max_abs_C_difference"] < 1e-12
                       and rec["bs_equal"] and rec["cone_equal"] and rec["oc_equal"])
    log(f"[lean-compare] q={q} {family}: {rec}")
    return rec


def lean_certificate_shaped(inst, Z, VT, scales=np.linspace(0.97, 1.01, 41)):
    """certificate_shaped_value on the lean instance (V = -A held directly)"""
    l = inst["cone"]["l"]
    Zp = Z.copy(); Zp[:l] = 0.0
    VZ = VT.dot(Zp)
    CZ = float(numba_kernels()["pdot"](inst["C"], Zp))
    cvec = -inst["bs"]
    best = None
    for t in scales:
        mu = np.maximum(0.0, t * VZ + cvec)
        N = inst["oc"] + t * CZ + mu.sum()
        if best is None or N < best[0]:
            best = (float(N), float(t), float(mu.sum()), int((mu > 0).sum()))
    return dict(N=best[0], scale=best[1], mu_sum=best[2], mu_support=best[3])


def admm_solve_lean(inst, nb, fp, ckpt, new, tol, max_iters, chunk_seconds, projector="cpu", proj_threads=14, log=print,
                    stop_after_iters=0, mu0=1.0, gamma=1.6, adapt_every=20, eta=3.0, first_report=0, gpu_check=True):
    """admm_solve's iteration, unchanged, on the lean instance.  Timers: lin (the exact arrowhead solve), spmv (the two
    sparse products), vec (the fused vector updates), cone (the projection; the GPU projector splits it further)."""
    K = numba_kernels()
    t_setup = time.time()
    V = inst["V"]
    t = time.time()
    VTm = V.T.tocsr()
    log(f"[lean-admm] V^T as CSR in {time.time()-t:.1f} s")
    PV, PVT = ParSparse(V), ParSparse(VTm)
    C, bs, oc = inst["C"], inst["bs"], inst["oc"]
    AH = Arrowhead(V, nb, log=log, VT=VTm)
    del AH.G
    rr = np.random.default_rng(11).standard_normal(V.shape[1])
    yy = AH.solve(rr)
    rel = float(np.linalg.norm(PVT.dot(PV.dot(yy)) - rr) / np.linalg.norm(rr))
    log(f"[lean-admm] exact linear solve G y = r on a random r: relative residual {rel:.2e}")
    if not rel < 1e-8:
        raise SystemExit("the arrowhead solve does not solve G y = r: refusing to iterate")
    del rr, yy
    cone = inst["cone"]
    if projector == "gpu":
        Kp = GpuProjector(cone, log=log)
    else:
        Kp = LeanCpuProjector(cone, threads=proj_threads)
    ck = Path(ckpt)
    it0 = 0
    if ck.exists():
        if new:
            raise SystemExit(f"--new given but {ck} exists: refusing to overwrite")
        z = np.load(ck, allow_pickle=False)
        if json.loads(str(z["fingerprint"])) != fp:
            raise SystemExit(f"checkpoint {ck} belongs to a different problem")
        X, S, y, mu, it0 = z["X"], z["S"], z["y"], float(z["mu"]), int(z["iters"])
        log(f"[lean-admm] RESUMED from {ck}: {it0} iterations, mu {mu:.3e}")
    elif not new:
        raise SystemExit(f"checkpoint {ck} does not exist and --new was not given: refusing to start from zero silently")
    else:
        ck.parent.mkdir(parents=True, exist_ok=True)
        X = np.zeros(V.shape[0]); S = np.zeros(V.shape[0]); y = np.zeros(V.shape[1]); mu = mu0
        log(f"[lean-admm] NEW checkpoint {ck}")
    W = np.empty(V.shape[0]); Vy = np.empty(V.shape[0]); T = np.empty(V.shape[0])
    nbs, nC = 1 + np.linalg.norm(bs), 1 + math.sqrt(K["pdot"](C, C))
    log(f"[lean-admm] setup {time.time()-t_setup:.1f} s ({projector} projector)")
    it = it0
    t_last = time.time(); t_start = time.time(); it_last = it
    tim = dict(lin=0.0, spmv=0.0, vec=0.0, cone=0.0)
    res = None
    checked = not (projector == "gpu" and gpu_check)
    while it < max_iters:
        ta = time.time()
        K["c_minus_s_minus_mux"](C, S, X, mu, T)
        tb = time.time()
        rhs = mu * bs + PVT.dot(T)
        tc = time.time()
        y = AH.solve(rhs)
        td = time.time()
        PV.dot(y, out=Vy)
        te = time.time()
        K["w_update"](C, Vy, X, mu, W)
        tf = time.time()
        if not checked:
            cpu = LeanCpuProjector(cone, threads=proj_threads)
            Sc = cpu.project(W)
            Sg = Kp.project(W)
            diff = float(np.abs(Sc - Sg).max()); scale = float(np.abs(Sc).max())
            log(f"[lean-admm] GPU projector against CPU on this iteration's W: max |difference| {diff:.3e} (max |entry| {scale:.3e})")
            if not diff <= 1e-8 * max(1.0, scale):
                raise SystemExit("the GPU projection disagrees with the CPU projection: refusing to continue")
            S = Sg
            del Sc, cpu
            checked = True
            tf = time.time()
        else:
            S = Kp.project(W, out=S)
        tg = time.time()
        K["x_update"](X, S, W, mu, gamma)
        th = time.time()
        it += 1
        tim["vec"] += (tb - ta) + (tf - te) + (th - tg); tim["spmv"] += (tc - tb) + (te - td); tim["lin"] += td - tc
        tim["cone"] += tg - tf
        if it % adapt_every == 0 or it >= max_iters:
            pinf = np.linalg.norm(PVT.dot(X) - bs) / nbs
            dinf = math.sqrt(K["resid_norm2"](C, Vy, S)) / nC
            if pinf > eta * dinf:
                mu *= 1.3
            elif dinf > eta * pinf:
                mu /= 1.3
        now = time.time()
        if (now - t_last >= chunk_seconds or it >= max_iters or (stop_after_iters and it - it0 >= stop_after_iters)
                or (first_report and it - it0 == first_report)):
            tr = time.time()
            k = max(1, it - it_last)
            extra = ""
            if projector == "gpu":
                extra = " [gpu " + ", ".join(f"{a} {b/k:.3f}" for a, b in Kp.tim.items()) + "]"
                Kp.tim = {a: 0.0 for a in Kp.tim}
            Xp = Kp.project(X)
            up = oc + float(K["pdot"](C, Xp))
            lo = oc + float(bs @ y)
            pinf = np.linalg.norm(PVT.dot(Xp) - bs) / nbs
            dinf = math.sqrt(K["resid_norm2"](C, Vy, S)) / nC
            gap = abs(up - lo) / (1 + abs(up) + abs(lo))
            del Xp
            t_rep = time.time() - tr
            tw = time.time()
            tmp = ck.with_name(ck.name + ".tmp.npz")
            np.savez(tmp, X=X, S=S, y=y, mu=mu, iters=it, fingerprint=json.dumps(fp))
            tmp.replace(ck)
            t_ck = time.time() - tw
            dt = (tr - t_last) / k
            log(f"[lean-admm] it {it}: {dt:.3f} s/it (lin {tim['lin']/k:.3f}, spmv {tim['spmv']/k:.3f}, vec {tim['vec']/k:.3f}, "
                f"cone {tim['cone']/k:.3f}){extra}; upper reading {up:.6f} lower reading {lo:.6f} pinf {pinf:.2e} "
                f"dinf {dinf:.2e} gap {gap:.2e} mu {mu:.2e}; report {t_rep:.1f} s, checkpoint write {t_ck:.1f} s", flush=True)
            tim = dict(lin=0.0, spmv=0.0, vec=0.0, cone=0.0)
            t_last, it_last = time.time(), it
            res = dict(iterations=it, upper=up, lower=lo, pinf=pinf, dinf=dinf, gap=gap, mu=mu, seconds_per_iteration=dt,
                       seconds=now - t_start, converged=bool(max(pinf, dinf, gap) < tol))
            if res["converged"]:
                log(f"[lean-admm] converged at tolerance {tol}")
                break
            if stop_after_iters and it - it0 >= stop_after_iters:
                log("[lean-admm] stopped after the requested iterations (a pricing or control run): NOT converged")
                break
    return res


def setup(q, modulus, dclass_arg, log=print):
    P = Plane(q, modulus)
    dreps, dcnt, _ = d_classes(P)
    Tb = Tables(P, dreps, log=log)
    if dclass_arg in (None, "all"):
        chosen = dreps
    else:
        chosen = [int(x) for x in dclass_arg.split(",")]
        assert all(c in dreps for c in chosen), f"--dclasses must be representatives among {dreps}"
    return P, Tb, dreps, dcnt, chosen


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    for name in ("count", "checkset", "solve"):
        a = sub.add_parser(name)
        a.add_argument("--q", type=int, required=True)
        a.add_argument("--modulus")
        a.add_argument("--family", default="l3", choices=sorted(FAMILIES))
        a.add_argument("--dclasses", default="all", help="comma-separated d-class representatives, or all")
        a.add_argument("--border", action="store_true", help="the all-ones border on MY and -- (needs --s0)")
        a.add_argument("--s0", type=float, help="the size threshold the border's corner |V|/s0 is valid for")
        a.add_argument("--fixed-k", type=int, default=None,
                       help="impose the fixed-cardinality moment equations at |S| = k; the test is then "
                            "f(k) = max trace Y < k, which proves alpha < k")
        a.add_argument("--origin-eq", action="store_true",
                       help="also impose the |T| = 1 equation (trace Y = k), which makes it a feasibility "
                            "question and throws away f(k)")
        a.add_argument("--out")
        if name == "checkset":
            a.add_argument("--set", required=True, help="JSON file; the set is read from --path")
            a.add_argument("--path", default="set")
        if name == "solve":
            a.add_argument("--ckpt", required=True)
            a.add_argument("--new", action="store_true")
            a.add_argument("--eps", type=float, default=1e-6)
            a.add_argument("--chunk", type=int, default=500)
            a.add_argument("--max-iters", type=int, default=400000)
            a.add_argument("--stop-after-chunks", type=int, default=0)
            a.add_argument("--linear-solver", default="auto")
            a.add_argument("--no-nonneg", action="store_true")
            a.add_argument("--verbose", action="store_true", help="SCS's own per-solve summary (time split: lin-sys, cones, accel)")
            a.add_argument("--method", default="scs", choices=["scs", "admm"],
                           help="scs: SCS through its API; admm: the arrowhead ADMM (exact linear solve), CPU")
            a.add_argument("--report-seconds", type=float, default=60.0, help="admm: checkpoint and report interval")
            a.add_argument("--mu0", type=float, default=1.0)
            a.add_argument("--proj-threads", type=int, default=0,
                           help="admm: project the PSD blocks in a thread pool (set OPENBLAS_NUM_THREADS=1); 0 = batched")
    sub.add_parser("selftest")
    e = sub.add_parser("evaluate")
    e.add_argument("--q", type=int, required=True); e.add_argument("--modulus"); e.add_argument("--ckpt", required=True)
    e.add_argument("--family", default="l3", choices=sorted(FAMILIES)); e.add_argument("--rank", action="store_true")
    e.add_argument("--set"); e.add_argument("--path", default="set"); e.add_argument("--out")
    r = sub.add_parser("randsets")
    r.add_argument("--q", type=int, required=True); r.add_argument("--modulus"); r.add_argument("--count", type=int, default=5)
    r.add_argument("--seed", type=int, default=1); r.add_argument("--family", default="l3", choices=sorted(FAMILIES)); r.add_argument("--out")
    lb = sub.add_parser("lean-build", help="the lean path: build the instance in parallel and cache it (q = 47)")
    lb.add_argument("--q", type=int, required=True); lb.add_argument("--modulus"); lb.add_argument("--family", default="l3", choices=sorted(FAMILIES))
    lb.add_argument("--dclasses", default="all"); lb.add_argument("--border", action="store_true"); lb.add_argument("--s0", type=float)
    lb.add_argument("--workers", type=int, default=14); lb.add_argument("--instance", required=True, help="directory (must not exist)")
    lb.add_argument("--census", action="store_true", help="also the orbit-completeness check"); lb.add_argument("--out")
    lc = sub.add_parser("lean-checkset", help="objective and every block's least eigenvalue at y(S), from a cached instance, with two plants")
    lc.add_argument("--instance", required=True); lc.add_argument("--set", required=True); lc.add_argument("--path", default="set")
    lc.add_argument("--workers", type=int, default=14); lc.add_argument("--out")
    ls = sub.add_parser("lean-solve", help="the arrowhead ADMM on a cached instance, checkpointed")
    ls.add_argument("--instance", required=True); ls.add_argument("--ckpt", required=True); ls.add_argument("--new", action="store_true")
    ls.add_argument("--eps", type=float, default=1e-6); ls.add_argument("--max-iters", type=int, default=400000)
    ls.add_argument("--report-seconds", type=float, default=600.0); ls.add_argument("--report-first", type=int, default=0,
                                                                                   help="also report and checkpoint after this many iterations")
    ls.add_argument("--stop-after-iters", type=int, default=0); ls.add_argument("--projector", default="cpu", choices=["cpu", "gpu"])
    ls.add_argument("--proj-threads", type=int, default=14); ls.add_argument("--mu0", type=float, default=1.0)
    ls.add_argument("--no-gpu-check", action="store_true"); ls.add_argument("--no-verify", action="store_true"); ls.add_argument("--out")
    le = sub.add_parser("lean-evaluate", help="certificate-shaped float value N on a lean checkpoint")
    le.add_argument("--instance", required=True); le.add_argument("--ckpt", required=True); le.add_argument("--proj-threads", type=int, default=14)
    le.add_argument("--out")
    lk = sub.add_parser("lean-compare", help="lean data against assemble_scs at a small q")
    lk.add_argument("--q", type=int, required=True); lk.add_argument("--modulus"); lk.add_argument("--family", default="l3", choices=sorted(FAMILIES))
    lk.add_argument("--workers", type=int, default=4); lk.add_argument("--out")
    a = ap.parse_args()
    if a.cmd.startswith("lean-"):
        import resource
        t0 = time.time()
        rec = dict(kind="fs54-d4-lean", cmd=a.cmd, argv=sys.argv[1:])
        ok = True
        if a.cmd == "lean-build":
            P, Tb, chosen, inst, meta = lean_build(a.q, a.modulus, a.family, a.dclasses, a.border, a.s0, a.workers)
            fp = lean_fingerprint(a.q, a.modulus, a.family, chosen, a.border, a.s0, inst)
            rec.update(fingerprint=fp, meta=meta)
            if a.census:
                rec["census"] = lean_census(P, Tb.var_key, Tb.var_size, workers=a.workers)
                ok = all(v["complete"] for v in rec["census"].values())
            save_instance(a.instance, inst, Tb, fp, meta)
        elif a.cmd == "lean-compare":
            rec.update(lean_compare(a.q, a.modulus, a.family, workers=a.workers))
            ok = rec["same"]
        elif a.cmd == "lean-checkset":
            inst, man, ld = load_instance(a.instance)
            fp = man["fingerprint"]
            P = Plane(fp["q"], fp["modulus"])
            S = json.load(open(a.set))
            for k in a.path.split("."):
                S = S[int(k)] if isinstance(S, list) else S[k]
            y = lean_y_from_set(P, ld["keys"], ld["var"], int(fp["nvar"]), S, workers=a.workers)
            rec.update(fingerprint=fp, set_file=a.set, set_size=len(set(S)))
            rec.update(lean_checkset(inst, y, workers=a.workers))
            ok = (abs(rec["objective_at_set"] - len(set(S))) < 1e-7 and rec["least_eigenvalue"] > -1e-9 and rec["least_linear_slack"] > -1e-12
                  and rec["plant_minus_minus_without_4set"]["fired"] and rec["plant_4set_permuted"]["fired"])
        elif a.cmd == "lean-solve":
            inst, man, ld = load_instance(a.instance, verify=not a.no_verify)
            fp = dict(man["fingerprint"])
            res = admm_solve_lean(inst, int(man["nb"]), fp, a.ckpt, a.new, a.eps, a.max_iters, a.report_seconds, projector=a.projector,
                                  proj_threads=a.proj_threads, stop_after_iters=a.stop_after_iters, mu0=a.mu0,
                                  first_report=a.report_first, gpu_check=not a.no_gpu_check)
            rec.update(fingerprint=fp, result=res, projector=a.projector, ckpt=a.ckpt)
        elif a.cmd == "lean-evaluate":
            import shutil
            inst, man, ld = load_instance(a.instance)
            snap = str(a.ckpt) + ".eval-copy.npz"
            shutil.copy(a.ckpt, snap)
            try:
                z = np.load(snap)
                if json.loads(str(z["fingerprint"])) != man["fingerprint"]:
                    raise SystemExit("checkpoint and instance disagree")
                Kp = LeanCpuProjector(inst["cone"], threads=a.proj_threads)
                Zv = Kp.project(z["X"])
                VT = ParSparse(inst["V"].T.tocsr())
                rec.update(fingerprint=man["fingerprint"], checkpoint=a.ckpt, iterations=int(z["iters"]))
                rec.update(lean_certificate_shaped(inst, Zv, VT))
                print(f"[lean-evaluate] at {rec['iterations']} iterations: certificate-shaped N = {rec['N']:.6f} (scale {rec['scale']:.3f}, "
                      f"sum mu {rec['mu_sum']:.6f} on {rec['mu_support']} orbits)")
            finally:
                Path(snap).unlink(missing_ok=True)
        rec["seconds"] = time.time() - t0
        rec["maxrss_self_GiB"] = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 2 ** 20
        rec["maxrss_largest_child_GiB"] = resource.getrusage(resource.RUSAGE_CHILDREN).ru_maxrss / 2 ** 20
        rec["claim_scope"] = "float readings, sizes and controls of the lean path; never a bound"
        if a.out:
            Path(a.out).parent.mkdir(parents=True, exist_ok=True)
            Path(a.out).write_text(json.dumps(rec, indent=1, default=float)); print(f"  wrote {a.out}")
        sys.exit(0 if ok else 1)
    if a.cmd == "selftest":
        sys.exit(0 if selftest() else 1)
    if a.cmd in ("evaluate", "randsets"):
        if a.cmd == "evaluate":
            rec = evaluate_checkpoint(a.q, a.modulus, a.ckpt, a.family, a.set, a.path, a.rank)
        else:
            rec = random_sets_control(a.q, a.modulus, a.count, a.seed, a.family)
        rec["claim_scope"] = "float readings and controls; never a bound"
        if a.out:
            Path(a.out).write_text(json.dumps(rec, indent=1, default=float)); print(f"  wrote {a.out}")
        ok = rec.get("all_pass", True) and rec.get("identity_holds", True) and rec.get("plant_fired", True)
        sys.exit(0 if ok else 1)
    if a.border and a.s0 is None:
        ap.error("--border needs --s0")
    t0 = time.time()
    P, Tb, dreps, dcnt, chosen = setup(a.q, a.modulus, a.dclasses)
    rec = dict(kind="fs54-d4", cmd=a.cmd, q=a.q, modulus=a.modulus, family=a.family, dclasses=chosen, border=a.border, s0=a.s0,
               G0=len(P.G0), aut=P.aut_order, d_class_reps=dreps, d_class_sizes=dcnt,
               d_class_unit=[int(d) for d in dreps if P.unit[d]], nvar=int(Tb.nvar),
               nvar_by_size={k: int((Tb.var_size == k).sum()) for k in (2, 3, 4)})
    t1 = time.time()
    blocks = build(P, Tb, a.family, chosen, border=a.border, s0=a.s0)
    rec["build_seconds"] = time.time() - t1
    sizes = [b[1] for b in blocks]
    rec["blocks"] = len(blocks)
    rec["block_sizes_hist"] = {int(k): int(v) for k, v in zip(*np.unique(sizes, return_counts=True))}
    rec["psd_rows"] = int(sum(m * (m + 1) // 2 for m in sizes))
    rec["sum_cubes"] = float(sum(float(m) ** 3 for m in sizes))
    print(f"[{a.cmd}] q={a.q} family={a.family} d-classes={chosen}: {len(blocks)} blocks, max {max(sizes)}, "
          f"PSD rows {rec['psd_rows']}, sum m^3 {rec['sum_cubes']:.3e}; build {rec['build_seconds']:.1f} s", flush=True)
    if a.cmd == "checkset":
        S = json.load(open(a.set))
        for k in a.path.split("."):
            S = S[int(k)] if isinstance(S, list) else S[k]
        y = y_from_set(P, Tb, S)
        oc, c = objective(P, Tb)
        worst = min((np.linalg.eigvalsh(block_matrix(m, r, cc, v, const, y))[0], lab) for (lab, m, r, cc, v, const) in blocks)
        rec.update(set_size=len(set(S)), objective_at_set=oc + c @ y, least_eigenvalue=worst[0], at=worst[1])
        print(f"[checkset] |S| = {len(set(S))}, objective at y(S) = {oc + c @ y:.9f}, least block eigenvalue {worst[0]:.3e} ({worst[1]})")
        # the fixed-cardinality control: the equations must hold EXACTLY at k = |S| and must BITE at k +- 1
        sz = len(set(S))
        rws, counts = fixed_k_rows(P, Tb, sz, origin_eq=True)
        res = fixed_k_residuals(rws, y)
        worst_eq = float(np.max(np.abs(res)))
        bite = {}
        for kk in (sz - 1, sz + 1):
            bite[kk] = float(np.max(np.abs(fixed_k_residuals(fixed_k_rows(P, Tb, kk, origin_eq=True, log=lambda *_: None)[0], y))))
        rec.update(fixedk_equations=len(rws), fixedk_counts={str(a_): b_ for a_, b_ in counts.items()},
                   fixedk_worst_residual_at_k=worst_eq, fixedk_worst_residual_off_k=bite)
        print(f"[checkset] the {len(rws)} fixed-cardinality equations at k = {sz}: worst residual {worst_eq:.3e} "
              f"{'PASS' if worst_eq < 1e-9 else 'FAIL'};  at k-1 {bite[sz-1]:.3e}, at k+1 {bite[sz+1]:.3e} "
              f"{'PASS (they bite)' if min(bite.values()) > 1e-6 else 'FAIL (vacuous)'}")
    if a.cmd == "count":
        rec["census"] = census(P, Tb)
    if a.cmd in ("count", "solve"):
        eq_rows = None
        if getattr(a, "fixed_k", None) is not None:
            eq_rows, eq_counts = fixed_k_rows(P, Tb, a.fixed_k, origin_eq=a.origin_eq)
            rec["fixed_k"] = a.fixed_k
            rec["fixed_k_equations"] = len(eq_rows)
            rec["fixed_k_counts"] = {str(k_): v_ for k_, v_ in eq_counts.items()}
            rec["origin_eq"] = bool(a.origin_eq)
        data, cone, oc = assemble_scs(P, Tb, blocks, nonneg=not getattr(a, "no_nonneg", False), eq_rows=eq_rows)
        rec["scs_rows"], rec["scs_nnz"] = int(data["A"].shape[0]), int(data["A"].nnz)
        rec["scs_A_bytes"] = int(data["A"].data.nbytes + data["A"].indices.nbytes + data["A"].indptr.nbytes)
        print(f"[{a.cmd}] SCS: {data['A'].shape[0]} rows x {data['A'].shape[1]} columns, nnz {data['A'].nnz}, "
              f"A {rec['scs_A_bytes']/2**20:.1f} MiB", flush=True)
    if a.cmd == "solve":
        fp = fingerprint(P, Tb, a.family, chosen, data, cone, a.border, a.s0,
                         fixed_k=getattr(a, "fixed_k", None), origin_eq=getattr(a, "origin_eq", False))
        fp["method"] = a.method
        if a.method == "admm":
            if getattr(a, "fixed_k", None) is not None:
                raise SystemExit("--fixed-k is not implemented for --method admm: the arrowhead solver assumes "
                                 "A^T A is diagonal on the 4-set variables, and the cardinality rows are dense "
                                 "across them. Use --method scs.")
            nb = int((Tb.var_size < 4).sum())
            res = admm_solve(data, cone, oc, nb, fp, a.ckpt, a.new, a.eps, a.max_iters, a.report_seconds,
                             stop_after_iters=a.stop_after_chunks, mu0=a.mu0, proj_threads=a.proj_threads)
            rec.update(result=res, eps=a.eps, method="admm", ckpt=a.ckpt)
            rec["seconds"] = time.time() - t0
            rec["claim_scope"] = "float readings (arrowhead ADMM); never a bound"
            if a.out:
                Path(a.out).write_text(json.dumps(rec, indent=1, default=float)); print(f"  wrote {a.out}")
            return
        res = run_chunks(data, cone, oc, fp, a.ckpt, a.new, a.eps, a.chunk, a.max_iters, a.linear_solver,
                         stop_after=a.stop_after_chunks, verbose=a.verbose)
        rec.update(result=res, eps=a.eps, chunk=a.chunk, linear_solver=a.linear_solver, ckpt=a.ckpt)
    rec["seconds"] = time.time() - t0
    rec["claim_scope"] = ("float readings of a semidefinite relaxation of alpha (GLV L_3 in Schrijver normalisation; "
                          "derivation plans/FS54-D4-pricing.md); never a bound until an exact rational certificate is checked")
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        Path(a.out).write_text(json.dumps(rec, indent=1, default=float))
        print(f"  wrote {a.out}")


if __name__ == "__main__":
    main()
