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


def assemble_scs(P, Tb, blocks, nonneg=True):
    """SCS standard form  min c.x  s.t.  A x + s = b,  s in K  (K = nonneg^nvar x PSD blocks, scaled lower-triangle
    column-major vectorisation).  A block's s = const + sum vals x[cols], so A = -vals and b = const."""
    import scipy.sparse as sp
    nv = Tb.nvar
    rows, cols, vals, b = [], [], [], []
    off = 0
    if nonneg:
        rows.append(np.arange(nv)); cols.append(np.arange(nv)); vals.append(-np.ones(nv)); b.append(np.zeros(nv))
        off = nv
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
    cone = dict(z=0, l=(nv if nonneg else 0) + len(lin), s=dims)
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
def fingerprint(P, Tb, family, dreps, data, cone, border, s0):
    return dict(q=P.q, modulus=P.F.modulus, family=family, dclasses=[int(d) for d in dreps], border=bool(border),
                s0=s0, nvar=int(Tb.nvar), rows=int(data["A"].shape[0]), nnz=int(data["A"].nnz), psd=len(cone["s"]),
                psd_max=int(max(cone["s"])))


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

    def __init__(self, V, nb, tol=1e-9, log=print):
        import scipy.sparse as sp
        t0 = time.time()
        G = (V.T @ V).tocsr()
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
    a = ap.parse_args()
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
    if a.cmd == "count":
        rec["census"] = census(P, Tb)
    if a.cmd in ("count", "solve"):
        data, cone, oc = assemble_scs(P, Tb, blocks, nonneg=not getattr(a, "no_nonneg", False))
        rec["scs_rows"], rec["scs_nnz"] = int(data["A"].shape[0]), int(data["A"].nnz)
        rec["scs_A_bytes"] = int(data["A"].data.nbytes + data["A"].indices.nbytes + data["A"].indptr.nbytes)
        print(f"[{a.cmd}] SCS: {data['A'].shape[0]} rows x {data['A'].shape[1]} columns, nnz {data['A'].nnz}, "
              f"A {rec['scs_A_bytes']/2**20:.1f} MiB", flush=True)
    if a.cmd == "solve":
        fp = fingerprint(P, Tb, a.family, chosen, data, cone, a.border, a.s0)
        fp["method"] = a.method
        if a.method == "admm":
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
