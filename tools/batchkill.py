"""M50 — the batch descent's instrument (plans/M50-batch-descent.md §2, §Bʹ–§Bʹʹʹ).

Design ONE unit halo against the WHOLE batch's separating-colouring list, so removals compose by
construction. Nothing here is trusted; every claim reaches a row with a `claim_scope` sentence, and
every certification ask is RUN (the palette bridge of §Bʺ is explanation, never a substitute).

The invariants this module leans on (§Bʺ):
* **Killing is monotone in the point set** — a solution of a superset's list-colouring CSP restricts
  to one of the subset's (lists depend only on the fixed colouring), so infeasibility survives
  adding points: the union of per-colouring kills covers everything it covered, and coverage
  rechecks are an optimization, never a correctness need. (`--self-test` probes this.)
* **The cover loop terminates**: per depth the work queue strictly shrinks — a found kill covers
  its colouring; a colouring the WHOLE depth pool cannot kill is stalled at that depth permanently
  (no subset can do what the whole pool cannot) and re-enters only at a deeper pool.
* **Sub-batch filters are one-representative-per-orbit** (argument in §Bʺ; tested end-to-end by
  reproducing M49's 684 and 1,010).
* **Avail masks range over ALL current object vertices** — halo points adjacent to A, B, or earlier
  halos included (the §Bʺ trap; the bridge spot-check control watches it).

Verdict vocabulary (§Bʹʹʹ): per colouring `killed(pool)` / `survives-pool(pool)` /
`stalled-at-depth(d)`; per commit `committed` / `candidate` / `refused`. No word means "clean";
every pool is a CHOICE named with its fingerprint; "survives-pool" on a WHOLE depth pool is
complete at that depth for constructible halos only (M49 §R10's caveat).

Resume is the default: every phase command loads its checkpoint, prints what it loaded and what
remains, and continues. `--status` prints the campaign state — a cold session's first command.
"""
from __future__ import annotations
import json, math, os, random, sys, time, hashlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import coloring, rigidity, forcer, mechanism  # noqa: E402
import twodist as T  # noqa: E402
from killengine import csp_feasible, seed_exact, intersect, is_unit  # noqa: E402
import numpy as np  # noqa: E402
from scipy.spatial import cKDTree  # noqa: E402

K = 5
FULL = (1 << K) - 1
BUILD = Path(__file__).resolve().parent.parent / "build"
TOL = 1e-7


# ---------------------------------------------------------------- the object

class Obj:
    """The descent's object: points with construction provenance, derived unit edges, the seed's
    cheat pairs (invariant across the recursion), and the forced pair. Points are ONLY added via
    `add_glue` (coordinates computed FROM the parents — §Bʹ), and `check()` re-derives every glue
    point at 30-digit mpmath from provenance, the parse-don't-validate control."""

    def __init__(self):
        H = T.ei_H()
        c = T.classify(H)
        self.seed_exact_pts = H                      # 4-basis exact seed coordinates
        self.pts = [T.approx(p) for p in H]          # floats, index-aligned with prov
        self.prov = [("seed", i) for i in range(len(H))]
        self.cheats = list(c[4])                     # seed-index pairs, never re-derived
        self.A, self.B = H.index(T.EI_A), H.index(T.EI_B)
        self._unit = None
        assert len(c[1]) == 1004 and len(self.cheats) == 446, "seed census drifted"

    @property
    def n(self) -> int:
        return len(self.pts)

    def unit_edges(self) -> list[tuple[int, int]]:
        """cKDTree unit census over the current points, cached until the next add."""
        if self._unit is None:
            self._unit = unit_pairs_np(self.pts)
        return self._unit

    def fingerprint(self, B=()) -> str:
        return T.fingerprint(self.n, self.unit_edges() + [e for e in self.cheats if e not in set(B)])

    def add_glue(self, a: int, b: int, sign: int) -> int:
        """Append the glue point of unit circles about points `a`, `b` (strictly earlier indices).
        Coordinates are computed from the parents; returns the new index."""
        assert 0 <= a < self.n and 0 <= b < self.n and sign in (1, -1)
        xy = _glue_xy(self.pts[a], self.pts[b], sign)
        assert xy is not None, ("parents too far or coincident", a, b)
        self.pts.append(xy)
        self.prov.append(("glue", a, b, sign))
        self._unit = None
        self._halo_struct = None
        return self.n - 1

    def add_halo(self, prov_list) -> list[int]:
        """Append a halo given as provenance records whose parent indices refer to THIS object's
        current indexing extended by the halo's own earlier entries (§Bʹ: append-only DAG)."""
        out = []
        for rec in prov_list:
            kind, a, b, s = rec
            assert kind == "glue"
            out.append(self.add_glue(a, b, s))
        return out

    def halo_structure(self):
        """(halo_seed_nbrs, halo_adj): for each old-halo point (index ≥ 214), its SEED unit
        neighbours and the halo–halo unit adjacency — the CSP variables' scaffolding. Cached."""
        if getattr(self, "_halo_struct", None) is not None:
            return self._halo_struct
        ue = self.unit_edges()
        m = self.n - 214
        hs = [[] for _ in range(m)]
        ha = [[] for _ in range(m)]
        for a, b in ue:
            if a >= 214 and b >= 214:
                ha[a - 214].append(b - 214)
                ha[b - 214].append(a - 214)
            elif b >= 214:
                hs[b - 214].append(a)
            elif a >= 214:
                hs[a - 214].append(b)
        self._halo_struct = (hs, ha)
        return hs, ha

    def check(self, dps: int = 30) -> bool:
        """Re-derive every glue point from provenance at `dps`-digit mpmath and compare — the
        planted per-iteration control. Raises on drift."""
        import mpmath as mp
        mp.mp.dps = dps
        exact = {}
        for i, rec in enumerate(self.prov):
            if rec[0] == "seed":
                a, b, c_, d_ = self.seed_exact_pts[rec[1]]
                exact[i] = mp.mpc((mp.mpf(a.numerator) / a.denominator * mp.sqrt(3)
                                   + mp.mpf(b.numerator) / b.denominator * mp.sqrt(11)) / 12,
                                  (mp.mpf(c_.numerator) / c_.denominator
                                   + mp.mpf(d_.numerator) / d_.denominator * mp.sqrt(33)) / 12)
            else:
                _, a, b, s = rec
                u, v = exact[a], exact[b]
                D = v - u
                d2 = (D * mp.conj(D)).real
                h = mp.sqrt(1 - d2 / 4)
                mid = (u + v) / 2
                perp = mp.mpc(-D.imag, D.real) / mp.sqrt(d2)
                exact[i] = mid + s * h * perp
            got = self.pts[i]
            err = abs(exact[i].real - got[0]) + abs(exact[i].imag - got[1])
            assert err < 1e-6, (i, rec, float(err))
        return True


def _d2(p, q):
    return (p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2


def _glue_xy(p, q, sign):
    d2 = _d2(p, q)
    if d2 >= 4 - 1e-9 or d2 < 1e-12:
        return None
    h = math.sqrt(1 - d2 / 4)
    d = math.sqrt(d2)
    return ((p[0] + q[0]) / 2 - sign * h * (q[1] - p[1]) / d,
            (p[1] + q[1]) / 2 + sign * h * (q[0] - p[0]) / d)


def unit_pairs_np(pts, tol: float = TOL, h: float = 0.25):
    """All pairs at distance in [1−tol, 1+tol], by cell-pair blocks (annulus only — a disc query
    at this density is billions of pairs; the annulus is millions)."""
    P = np.asarray(pts)
    keys = np.floor(P / h).astype(np.int64)
    from collections import defaultdict as dd
    cells = dd(list)
    for i, (kx, ky) in enumerate(keys):
        cells[(int(kx), int(ky))].append(i)
    cells = {k: np.array(v) for k, v in cells.items()}
    lo2, hi2 = (1 - tol) ** 2, (1 + tol) ** 2
    reach = int(math.ceil((1 + tol) / h)) + 1
    out = []
    ck = sorted(cells.keys())
    for (kx, ky) in ck:
        A = cells[(kx, ky)]
        PA = P[A]
        for dx in range(-reach, reach + 1):
            for dy in range(-reach, reach + 1):
                # cell-centre distance window: skip cells that cannot contain annulus pairs
                cd2 = (dx * dx + dy * dy) * h * h
                if cd2 > (1 + tol + 2.83 * h) ** 2 or cd2 < max(0.0, 1 - tol - 2.83 * h) ** 2:
                    continue
                key2 = (kx + dx, ky + dy)
                if key2 not in cells or key2 < (kx, ky):
                    continue
                B = cells[key2]
                D = PA[:, None, :] - P[B][None, :, :]
                d2 = (D * D).sum(axis=2)
                ii, jj = np.nonzero((d2 >= lo2) & (d2 <= hi2))
                for a, b in zip(A[ii], B[jj]):
                    if key2 != (kx, ky) or a < b:
                        out.append((int(min(a, b)), int(max(a, b))))
    return sorted(set(out))


# ---------------------------------------------------------------- pools (each a CHOICE)

class Pool:
    """A candidate pool: points with provenance over `obj`, their obj-neighbour lists, and the
    unit adjacency among pool points. `name`/`params`/`fingerprint` go in every row."""

    def __init__(self, obj: Obj, name: str, params: dict, prov, pts):
        self.obj, self.name, self.params = obj, name, params
        self.prov = prov                              # ("glue", a, b, s) with obj/pool indexing:
        self.pts = pts                                # parents < obj.n are obj points; >= obj.n are pool
        tree_obj = cKDTree(np.array(obj.pts))
        self.nbrs = [sorted(j for j in tree_obj.query_ball_point(p, 1 + TOL)
                            if abs(_d2(p, obj.pts[j]) - 1) < TOL) for p in pts]
        # seed-projection design (§R5): masks come from SEED neighbours; old-halo neighbours are
        # CSP variables (their colours are existential, not fixed by the enumerated seed class)
        self.nbrs_seed = [[v for v in N if v < 214] for N in self.nbrs]
        self.nbrs_halo = [[v - 214 for v in N if v >= 214] for N in self.nbrs]
        self.adj = [[] for _ in pts]
        if pts:
            for i, j in unit_pairs_np(pts):
                self.adj[i].append(j)
                self.adj[j].append(i)
        self._csr = None
        self.fp = hashlib.sha256(repr((obj.fingerprint(), name, sorted(params.items()),
                                       [tuple(round(v, 6) for v in p) for p in pts])).encode()).hexdigest()[:16]

    def csr(self):
        """CSR views for the vectorized per-colouring path: seed-neighbour lists, pool adjacency,
        halo-neighbour lists (built once)."""
        if self._csr is None:
            def build(lists):
                indptr = np.zeros(len(lists) + 1, dtype=np.int64)
                for i, L in enumerate(lists):
                    indptr[i + 1] = indptr[i] + len(L)
                idx = np.fromiter((v for L in lists for v in L), dtype=np.int64,
                                  count=int(indptr[-1]))
                return indptr, idx
            self._csr = (build(self.nbrs_seed), build(self.adj), build(self.nbrs_halo))
        return self._csr

    def cite(self) -> dict:
        return {"pool": self.name, "pool_params": self.params, "pool_size": len(self.pts),
                "pool_fingerprint": self.fp}


def _dedupe(cands):
    """cands: list of (xy, prov). Keep first provenance per rounded position."""
    seen, prov, pts = set(), [], []
    for xy, pv in cands:
        g = (round(xy[0], 6), round(xy[1], 6))
        if g in seen:
            continue
        seen.add(g)
        prov.append(pv)
        pts.append(xy)
    return prov, pts


def _partners_about(pts_np, base_pts, base_offset, exclude):
    """Glue points of unit circles about every pair of `base_pts` at distance < 2; parents are
    indexed with `base_offset` + local index mapped by the caller. Returns [(xy, ("glue",a,b,s))]."""
    tree = cKDTree(pts_np)
    out = []
    for i, j in tree.query_pairs(2 - 1e-9):
        a, b = base_offset[i], base_offset[j]
        for s in (1, -1):
            xy = _glue_xy(base_pts[i], base_pts[j], s)
            if xy is None:
                continue
            g = (round(xy[0], 6), round(xy[1], 6))
            if g in exclude:
                continue
            out.append((xy, ("glue", a, b, s)))
    return out


def pool_depth1(obj: Obj) -> Pool:
    """Every glue point of unit circles about pairs of object points — complete for single-point
    kills in any field (`Glue.eq_gluePoint_of_unit_pair`)."""
    excl = {(round(p[0], 6), round(p[1], 6)) for p in obj.pts}
    cands = _partners_about(np.array(obj.pts), obj.pts, list(range(obj.n)), excl)
    prov, pts = _dedupe(cands)
    return Pool(obj, "depth1", {}, prov, pts)


def pool_depth2_restricted(obj: Obj, p1: Pool, min_nbrs: int = 3) -> Pool:
    """depth1 ∪ glue points about (object ∪ the depth-1 points with >= `min_nbrs` object
    neighbours) — M49 §R9's restricted depth two, a CHOICE."""
    strong = [i for i in range(len(p1.pts)) if len(p1.nbrs[i]) >= min_nbrs]
    base_pts = obj.pts + [p1.pts[i] for i in strong]
    offset = list(range(obj.n)) + [obj.n + i for i in range(len(strong))]
    excl = {(round(p[0], 6), round(p[1], 6)) for p in obj.pts} | \
           {(round(p[0], 6), round(p[1], 6)) for p in p1.pts}
    cands = _partners_about(np.array(base_pts), base_pts, offset, excl)
    prov2, pts2 = _dedupe(cands)
    # pool indexing: depth1 points first (parents of depth2 recs with index >= obj.n refer to
    # strong depth1 points — remap to pool indices obj.n + strong_pos -> obj.n + p1 index)
    remap = {obj.n + k: obj.n + strong[k] for k in range(len(strong))}
    prov2 = [("glue", remap.get(a, a), remap.get(b, b), s) for _, a, b, s in prov2]
    return Pool(obj, "depth2r", {"min_nbrs": min_nbrs}, p1.prov + prov2, p1.pts + pts2)


# ---------------------------------------------------------------- colourings and lookups

def avail_masks(obj: Obj, pool: Pool, col) -> list[int]:
    """per pool point, colours not used on its SEED neighbours (old-halo neighbours are CSP
    variables — §R5's seed-projection semantics; for the plain seed object the two coincide)"""
    out = []
    for N in pool.nbrs_seed:
        used = 0
        for v in N:
            used |= 1 << col[v]
        out.append(FULL & ~used)
    return out


def halo_masks(obj: Obj, col) -> list[int]:
    """per old-halo point, colours not used on its seed neighbours"""
    hs, _ = obj.halo_structure()
    out = []
    for N in hs:
        used = 0
        for v in N:
            used |= 1 << col[v]
        out.append(FULL & ~used)
    return out


_POP = np.array([bin(x).count("1") for x in range(32)], dtype=np.int8)


def _or_reduceat(vals, indptr):
    """bitwise_or segments of `vals` by CSR indptr; empty segments → 0 (reduceat's quirk fixed)."""
    n = len(indptr) - 1
    out = np.zeros(n, dtype=np.uint8)
    lens = np.diff(indptr)
    nz = np.flatnonzero(lens > 0)
    if len(nz):
        red = np.bitwise_or.reduceat(vals, indptr[nz])
        out[nz] = red
    return out


def avail_np(obj: Obj, pool: Pool, col) -> np.ndarray:
    """Vectorized `avail_masks`: per pool point, FULL minus colours on its SEED neighbours."""
    (sp, si), _, _ = pool.csr()
    bits = (np.uint8(1) << np.asarray(col, dtype=np.uint8)[si]).astype(np.uint8)
    return (FULL & ~_or_reduceat(bits, sp)).astype(np.uint8)


def peel_np(pool: Pool, av: np.ndarray, hav) -> tuple[np.ndarray, np.ndarray]:
    """Vectorized exact list-colouring kernelization over the WHOLE pool + halo: returns the alive
    masks (pool bool array, halo bool array). Peels any variable with freecount > remaining degree
    (colourable last; feasibility unchanged)."""
    _, (ap, ai), (hp, hi) = pool.csr()
    m = len(hav)
    alive = av != 0
    free = _POP[av]
    if m:
        hs, ha = pool.obj.halo_structure()
        halive = np.array([h != 0 for h in hav])
        hfree = _POP[np.asarray(hav, dtype=np.uint8)]
        hadj_ptr = np.zeros(m + 1, dtype=np.int64)
        for j, L in enumerate(ha):
            hadj_ptr[j + 1] = hadj_ptr[j] + len(L)
        hadj_idx = np.fromiter((v for L in ha for v in L), dtype=np.int64, count=int(hadj_ptr[-1]))
        # halo→pool reverse degree recomputed per pass (small m)
    else:
        halive = np.zeros(0, dtype=bool)
        hfree = np.zeros(0, dtype=np.int8)
    while True:
        # degrees among alive
        deg = np.zeros(len(av), dtype=np.int64)
        contrib = alive[ai].astype(np.int64)
        np.add.at(deg, np.repeat(np.arange(len(av)), np.diff(ap)), contrib)
        if m:
            hcontrib = halive[hi].astype(np.int64)
            np.add.at(deg, np.repeat(np.arange(len(av)), np.diff(hp)), hcontrib)
            hdeg = np.zeros(m, dtype=np.int64)
            np.add.at(hdeg, np.repeat(np.arange(m), np.diff(hadj_ptr)), halive[hadj_idx].astype(np.int64))
            rev = np.zeros(m, dtype=np.int64)
            np.add.at(rev, hi, alive[np.repeat(np.arange(len(av)), np.diff(hp))].astype(np.int64))
            hdeg += rev
        drop = alive & (free > deg)
        hdrop = (halive & (hfree > hdeg)) if m else np.zeros(0, dtype=bool)
        if not drop.any() and not (m and hdrop.any()):
            return alive, halive
        alive &= ~drop
        if m:
            halive &= ~hdrop


def feasible(pool: Pool, idxs, avail, hav=None, cap=1800) -> bool:
    """List-colouring SAT of the pool subset `idxs` PLUS every old-halo point of the object (the
    old halo's colours are existential under the seed class — §R5). Exact list-colouring
    KERNELIZATION first: a variable (of either kind) whose free-colour count exceeds its degree
    among the remaining variables can always be coloured last — peeled iteratively; feasibility is
    unchanged in both directions."""
    hav = list(hav) if hav is not None else []
    m = len(hav)
    for p in idxs:
        if avail[p] == 0:
            return False
    for j in range(m):
        if hav[j] == 0:
            return False
    hs, ha = pool.obj.halo_structure() if m else ([], [])
    # kernelization lives in the NUMPY path (peel_np / whole_feasible) — a Python peel here cost
    # 0.18 s per call and dominated everything (measured); the direct CNF is milliseconds.
    idxs2 = sorted(idxs)
    hids = list(range(m))

    loc = {p: i for i, p in enumerate(idxs2)}
    hloc = {j: len(idxs2) + i for i, j in enumerate(hids)}
    cls = []
    for p in idxs2:
        cls.append([loc[p] * K + c + 1 for c in range(K) if avail[p] >> c & 1])
    for j in hids:
        cls.append([hloc[j] * K + c + 1 for c in range(K) if hav[j] >> c & 1])
    for a in idxs2:
        for b in pool.adj[a]:
            if b in loc and b > a:
                for c in range(K):
                    cls.append([-(loc[a] * K + c + 1), -(loc[b] * K + c + 1)])
        for j in pool.nbrs_halo[a]:
            if j in hloc:
                for c in range(K):
                    cls.append([-(loc[a] * K + c + 1), -(hloc[j] * K + c + 1)])
    for j in hids:
        for jj in ha[j]:
            if jj in hloc and jj > j:
                for c in range(K):
                    cls.append([-(hloc[j] * K + c + 1), -(hloc[jj] * K + c + 1)])
    st, _ = forcer._solve(cls, (len(idxs2) + len(hids)) * K, cap)
    assert st in ("sat", "unsat"), st
    return st == "sat"


def whole_feasible(pool: Pool, av: np.ndarray, hav) -> tuple[bool, np.ndarray]:
    """(feasible?, peeled pool core) for the WHOLE pool under one colouring — the vectorized path:
    peel first (usually to empty = feasible); a nonempty core goes to the SAT on the core alone
    (peeling preserves feasibility exactly, §Bʺ). An EMPTY-list point anywhere = infeasible
    outright (the point is uncolourable — the stage-0 kill; the peel must never discard it)."""
    if bool((av == 0).any()) or any(h == 0 for h in hav):
        return False, np.zeros(len(av), dtype=bool)
    alive, halive = peel_np(pool, av, hav)
    if not alive.any() and not halive.any():
        return True, alive
    core = [int(x) for x in np.flatnonzero(alive)]
    return feasible(pool, core, av, hav), alive


def kills(pool: Pool, idxs, cols_avail) -> bool:
    """Does the subset kill EVERY colouring? cols_avail: list of (pool_masks, halo_masks)."""
    return all(not feasible(pool, idxs, av, hv) for av, hv in cols_avail)


# ---------------------------------------------------------------- enumeration (phase 2)

def enumerate_seps(obj: Obj, B, path: Path, cap_wall: float = 12 * 3600,
                   cap_n: int = 200_000, log=print) -> dict:
    """Exact blocking-clause enumeration of the separating colourings of `obj` minus the cheat
    batch `B`, up to palette (fixed first-occurrence breaking on the PINNED degree order). Appends
    one colouring per line to `path` (jsonl); resume is the default (existing lines are replayed
    into blocking clauses). Header line 0 pins the order and the stage fingerprint."""
    B = [tuple(e) for e in B]
    edges = obj.unit_edges() + [e for e in obj.cheats if tuple(e) not in set(B)]
    order = T._degree_order(obj.n, edges)
    header = {"kind": "enumeration-header", "stage_fingerprint": obj.fingerprint(B),
              "batch": [list(e) for e in B], "k": K, "block_on": len(blk), "order_fingerprint":
              hashlib.sha256(repr((order, blk)).encode()).hexdigest()[:16]}
    cls = coloring.base_clauses(obj.n, edges, K) + rigidity.amo_clauses(obj.n, K)
    cls += T._brk_full(obj.n, K, order)
    cls += [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    found = 0
    if path.exists():
        lines = path.read_text().splitlines()
        old = json.loads(lines[0])
        assert old["order_fingerprint"] == header["order_fingerprint"], "resume: order drifted"
        assert old["stage_fingerprint"] == header["stage_fingerprint"], "resume: stage drifted"
        for line in lines[1:]:
            col = [int(ch) for ch in json.loads(line)]
            cls.append([-coloring.var(v, col[v], K) for v in range(obj.n)])
            found += 1
        log(f"[enumerate] resumed: {found} colourings loaded from {path.name}")
    else:
        path.write_text(json.dumps(header) + "\n")
    t0 = time.time()
    status = "exact"
    with path.open("a") as fh:
        while found < cap_n:
            if time.time() - t0 > cap_wall:
                status = "capped-wall"
                break
            st, model = forcer._solve(cls, obj.n * K, 1800)
            if st == "unsat":
                break
            if st != "sat":
                status = "capped-solver"
                break
            col = rigidity.decode(model, obj.n, K)
            for a, b in edges:
                assert col[a] != col[b]
            assert col[obj.A] != col[obj.B]
            fh.write(json.dumps("".join(map(str, col))) + "\n")
            fh.flush()
            cls.append([-coloring.var(v, col[v], K) for v in range(obj.n)])
            found += 1
            if found % 500 == 0:
                log(f"[enumerate] {found} colourings, {time.time()-t0:.0f}s", flush=True)
        else:
            status = "capped-n"
    gate = "proceed" if status == "exact" and found <= 30_000 else "blocked"
    row = {"kind": "enumeration", **header, "count": found, "status": status, "gate": gate,
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the separating colourings of the object minus the batch, one "
           "representative per palette orbit under the pinned breaking order; EXACT only if "
           "status = exact; the design phase refuses gate = blocked without --pool-choice-ack"}
    T.record(BUILD / "m50-batch.json", row)
    log(f"[enumerate] {found} colourings ({status}, gate {gate}), {time.time()-t0:.0f}s")
    return row


def enumerate_cubes(obj: Obj, B, path: Path, cap_wall: float = 500 * 3600,
                    stretch: float = 300.0, split_target: int = 28, block_on=None, log=print) -> dict:
    """The parallel form of `enumerate_seps`, with ENTROPY-GUIDED cube splitting. A cube is a list
    of (vertex, colour) pins; cubes partition the solution set (children pin one more vertex, one
    child per colour), and the breaking clauses are global, so the union over leaf cubes equals the
    sequential enumeration — one representative per palette orbit. Between rounds, while fewer than
    `split_target` leaves are open, every open cube splits ON THE VERTEX WHOSE COLOUR DISTRIBUTION
    OVER ITS OWN FOUND COLOURINGS IS MOST BALANCED (a global-order pin is nearly constant inside a
    heavy cube and splits nothing). Work is round-based (`stretch` seconds per cube per round),
    file-checkpointed, resume-by-default; the manifest is written only by the round driver."""
    import shutil
    from collections import Counter
    B = [tuple(e) for e in B]
    edges = obj.unit_edges() + [e for e in obj.cheats if tuple(e) not in set(B)]
    order = T._degree_order(obj.n, edges)
    if block_on is not None:
        blk = sorted(block_on)
        order = [v for v in order if v in set(blk)]      # split vertices stay inside the projection
    else:
        blk = list(range(obj.n))
    header = {"kind": "enumeration-header", "stage_fingerprint": obj.fingerprint(B),
              "batch": [list(e) for e in B], "k": K, "block_on": len(blk), "order_fingerprint":
              hashlib.sha256(repr((order, blk)).encode()).hexdigest()[:16]}
    cdir = path.parent / (path.stem + "-cubes")
    cdir.mkdir(exist_ok=True)
    lock = cdir / "LOCK"
    if lock.exists():
        pid = lock.read_text().strip()
        if pid and Path(f"/proc/{pid}").exists():
            raise SystemExit(f"another enumerator (pid {pid}) holds {lock} — refusing to race it")
    lock.write_text(str(os.getpid()))
    man_path = cdir / "manifest.json"
    base = coloring.base_clauses(obj.n, edges, K) + rigidity.amo_clauses(obj.n, K)
    base += T._brk_full(len(order), K, order)     # breaking over the PROJECTED order only
    base += [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]

    def cid(pins) -> str:
        return "c" + hashlib.sha256(repr(list(map(tuple, pins))).encode()).hexdigest()[:12]

    def f_of(i: str) -> Path:
        return cdir / f"{i}.jsonl"

    def done_of(i: str) -> Path:
        return cdir / f"{i}.done"

    if man_path.exists():
        man = json.loads(man_path.read_text())
        assert man["order_fingerprint"] == header["order_fingerprint"], "resume: order drifted"
        assert man["stage_fingerprint"] == header["stage_fingerprint"], "resume: stage drifted"
    else:
        man = {"order_fingerprint": header["order_fingerprint"],
               "stage_fingerprint": header["stage_fingerprint"], "cubes": {}}
        # migrate digit-string cubes from the fixed-order run, preserving their done markers
        legacy = sorted(cdir.glob("cube-*.jsonl"))
        if legacy or list(cdir.glob("cube-*.done")):
            for f in sorted(cdir.glob("cube-*.done")):
                digits = f.stem.split("-")[1]
                pins = [[order[1 + k], int(d)] for k, d in enumerate(digits)]
                i = cid(pins)
                man["cubes"][i] = {"pins": pins, "split": False}
                done_of(i).write_text("unsat")
                lf = cdir / f"cube-{digits}.jsonl"
                if lf.exists():
                    shutil.move(str(lf), str(f_of(i)))
                f.unlink()
            for f in sorted(cdir.glob("cube-*.jsonl")):
                digits = f.stem.split("-")[1]
                pins = [[order[1 + k], int(d)] for k, d in enumerate(digits)]
                i = cid(pins)
                man["cubes"][i] = {"pins": pins, "split": False}
                shutil.move(str(f), str(f_of(i)))
            log(f"[enumerate-cubes] migrated {len(man['cubes'])} legacy cubes")
        elif path.exists():
            lines = path.read_text().splitlines()
            old = json.loads(lines[0])
            assert old["order_fingerprint"] == header["order_fingerprint"], "seed: order drifted"
            i = cid([])
            man["cubes"][i] = {"pins": [], "split": False}
            f_of(i).write_text("\n".join(lines[1:]) + "\n" if len(lines) > 1 else "")
            shutil.move(str(path), str(path) + ".seed.bak")
        else:
            i = cid([])
            man["cubes"][i] = {"pins": [], "split": False}
        man_path.write_text(json.dumps(man))

    def leaves() -> list[str]:
        return [i for i, c in man["cubes"].items() if not c["split"]]

    def lines_of(i: str) -> list[str]:
        return f_of(i).read_text().splitlines() if f_of(i).exists() else []

    def split(i: str):
        """entropy-guided: split on the unpinned vertex with the most balanced colour histogram
        over this cube's found colourings (falls back to the first unpinned in the order)."""
        pins = man["cubes"][i]["pins"]
        pinned = {v for v, _ in pins}
        ls = lines_of(i)
        best_v, best_score = None, -1.0
        if ls:
            cols = [json.loads(x) for x in ls]
            for v in order:
                if v in pinned:
                    continue
                hist = Counter(c[v] for c in cols)
                score = 1.0 - max(hist.values()) / len(cols)
                if score > best_score:
                    best_v, best_score = v, score
                if best_score > 0.75:
                    break
        if best_v is None:
            best_v = next(v for v in order if v not in pinned)
        kids = {}
        for d in range(K):
            kp = pins + [[best_v, d]]
            ki = cid(kp)
            man["cubes"][ki] = {"pins": kp, "split": False}
            kids[d] = ki
        buckets: dict[int, list[str]] = {d: [] for d in range(K)}
        for x in ls:
            buckets[int(json.loads(x)[best_v])].append(x)
        for d, ki in kids.items():
            assert not f_of(ki).exists(), ("split clobber", ki)
            if buckets[d]:
                f_of(ki).write_text("\n".join(buckets[d]) + "\n")
        if f_of(i).exists():
            shutil.move(str(f_of(i)), str(f_of(i)) + ".split.bak")
        man["cubes"][i]["split"] = True

    t0 = time.time()

    def work(i: str):
        if done_of(i).exists():
            return
        pins = man["cubes"][i]["pins"]
        cls = list(base) + [[coloring.var(v, c, K)] for v, c in pins]
        for line in lines_of(i):
            col = [int(ch) for ch in json.loads(line)]
            cls.append([-coloring.var(v, col[v], K) for v in range(obj.n)])
        ts = time.time()
        with f_of(i).open("a") as fh:
            while time.time() - ts <= stretch and time.time() - t0 <= cap_wall:
                st, model = forcer._solve(cls, obj.n * K, 1800)
                if st == "unsat":
                    done_of(i).write_text("unsat")
                    return
                if st != "sat":
                    return
                col = rigidity.decode(model, obj.n, K)
                for a, b in edges:
                    assert col[a] != col[b]
                assert col[obj.A] != col[obj.B]
                assert all(col[v] == c for v, c in pins), "cube pin violated"
                fh.write(json.dumps("".join(map(str, col))) + "\n")
                fh.flush()
                cls.append([-coloring.var(v, col[v], K) for v in blk])

    rnd = 0
    while True:
        rnd += 1
        open_cubes = [i for i in leaves() if not done_of(i).exists()]
        total = sum(len(lines_of(i)) for i in leaves())
        log(f"[enumerate-cubes] round {rnd}: {len(man['cubes'])} cubes, {len(open_cubes)} open, "
            f"{total} colourings, {time.time()-t0:.0f}s", flush=True)
        if not open_cubes or time.time() - t0 > cap_wall:
            break
        while 0 < len(open_cubes) < split_target:
            for i in list(open_cubes):
                split(i)
            open_cubes = [i for i in leaves() if not done_of(i).exists()]
            log(f"[enumerate-cubes]   split → {len(open_cubes)} open leaves", flush=True)
        man_path.write_text(json.dumps(man))
        mechanism.pmap(work, open_cubes)
    man_path.write_text(json.dumps(man))
    open_cubes = [i for i in leaves() if not done_of(i).exists()]
    status = "exact" if not open_cubes else "capped-wall"
    seen: set[str] = set()
    if not open_cubes:
        with path.open("w") as fh:
            fh.write(json.dumps(header) + "\n")
            for i in sorted(leaves()):
                for line in lines_of(i):
                    assert line not in seen, "duplicate representative across cubes"
                    seen.add(line)
                    fh.write(line + "\n")
    total = len(seen) if not open_cubes else sum(len(lines_of(i)) for i in leaves())
    gate = "proceed" if status == "exact" and total <= 30_000 else "blocked"
    row = {**header, "kind": "enumeration", "count": total, "status": status, "gate": gate,
           "cubes": {"n": len(man["cubes"]), "open": len(open_cubes)},
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the separating colourings of the object minus the batch, one "
           "representative per palette orbit under the pinned breaking order, enumerated by "
           "entropy-split disjoint colour cubes (leaves partition the solution set, so the union "
           "equals the sequential enumeration); EXACT only if status = exact (every leaf closed "
           "by UNSAT)"}
    T.record(BUILD / "m50-batch.json", row)
    lock.unlink(missing_ok=True)
    log(f"[enumerate-cubes] total {total} ({status}, gate {gate}), {time.time()-t0:.0f}s")
    return row


def load_seps(path: Path):
    lines = path.read_text().splitlines()
    header = json.loads(lines[0])
    cols = [[int(ch) for ch in json.loads(x)] for x in lines[1:]]
    return header, cols


def filter_sub(obj: Obj, cols, keep_edges):
    """Colourings proper on `keep_edges` — the sub-batch filter (§Bʺ: one rep per orbit)."""
    keep = [tuple(e) for e in keep_edges]
    return [c for c in cols if all(c[a] != c[b] for a, b in keep)]


# ---------------------------------------------------------------- the profile (phase 3)

def profile(obj: Obj, pool: Pool, cols, label: str, log=print) -> list[bool]:
    """Per-colouring whole-set verdict: does the ENTIRE pool kill it? Complete at this pool for
    constructible halos (M49 §R10 caveat cited in the row). Returns the per-colouring kill flags."""
    allidx = list(range(len(pool.pts)))
    t0 = time.time()
    done = [0]

    def one(c):
        f, _ = whole_feasible(pool, avail_np(obj, pool, c), halo_masks(obj, c))
        r = not f
        done[0] += 1
        if done[0] % 2000 == 0:
            log(f"[profile {label}] {done[0]}/{len(cols)} [{time.time()-t0:.0f}s]", flush=True)
        return r

    outs = mechanism.pmap(one, cols)
    (BUILD / f"m50-survivors-{label}.json").write_text(
        json.dumps([i for i, k in enumerate(outs) if not k]))
    row = {"kind": "profile", "label": label, **pool.cite(), "n_colourings": len(cols),
           "survivor_file": f"m50-survivors-{label}.json",
           "killed": int(sum(outs)), "survive": int(len(outs) - sum(outs)),
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "per-colouring whole-set verdict on the named pool: killed = no "
           "extension of the colouring to the whole pool exists (so none to any subset — "
           "monotonicity), survive = the whole pool is list-colourable under it, so NO "
           "constructible halo from this pool kills it (M49 §R10 caveat: constructible halos "
           "only)"}
    T.record(BUILD / "m50-batch.json", row)
    log(f"[profile {label}] {pool.name}: {sum(outs)} killed / {len(outs)-sum(outs)} survive "
        f"of {len(cols)} [{time.time()-t0:.0f}s]")
    return list(outs)


# ---------------------------------------------------------------- the cover (phase 4)

def cover(obj: Obj, pool: Pool, cols, state_path: Path, log=print) -> dict:
    """Greedy set-cover of the colouring list by a growing halo (§B2 + §Bʹ stage 0). Avail masks
    live in ONE uint8 numpy matrix (built once, in parallel); coverage rechecks touch only
    UNCOVERED colourings (monotonicity: covered stays covered). Checkpointed per acceptance."""
    t0 = time.time()
    AVn = np.zeros((len(cols), len(pool.pts)), dtype=np.uint8)
    rows = mechanism.pmap(lambda c: avail_np(obj, pool, c).tobytes(), cols)
    for i, r in enumerate(rows):
        AVn[i] = np.frombuffer(r, dtype=np.uint8)
    nh = obj.n - 214
    HVn = np.zeros((len(cols), nh), dtype=np.uint8)
    if nh:
        hrows = mechanism.pmap(lambda c: bytes(halo_masks(obj, c)), cols)
        for i, r in enumerate(hrows):
            HVn[i] = np.frombuffer(r, dtype=np.uint8)
    log(f"[cover] avail matrices {AVn.shape} + halo {HVn.shape} built [{time.time()-t0:.0f}s]", flush=True)
    halo: list[int] = []
    stall: list[int] = []
    if state_path.exists():
        st_ = json.loads(state_path.read_text())
        assert st_["pool_fingerprint"] == pool.fp, "resume: pool drifted"
        halo, stall = st_["halo"], st_["stall"]
        log(f"[cover] resumed: halo {len(halo)}, stall {len(stall)}")
    covered = np.zeros(len(cols), dtype=bool)

    def recheck(idxs):
        """re-test coverage for the given colouring indices against the current halo"""
        if not halo:
            return
        outs = mechanism.pmap(lambda t: not feasible(pool, halo, AVn[t], HVn[t]), list(idxs))
        for t, k in zip(idxs, outs):
            covered[t] = k

    recheck([t for t in range(len(cols)) if not covered[t]])
    queue = [t for t in range(len(cols)) if not covered[t] and t not in set(stall)]
    log(f"[cover] start: {int(covered.sum())} covered, {len(queue)} queued, {len(stall)} stalled")
    while queue:
        # most-constrained first: fewest empty-avail (free-kill) points
        nfree = (AVn[queue] == 0).sum(axis=1)
        t = queue[int(np.argmin(nfree))]
        empt = np.flatnonzero(AVn[t] == 0)
        empt = [int(p) for p in empt if p not in set(halo)]
        if empt:
            added = [empt[0]]
        else:
            f, _core = whole_feasible(pool, AVn[t], HVn[t])
            if f:
                stall.append(t)
                queue = [q for q in queue if q != t]
                log(f"[cover] colouring {t}: survives the whole pool — stalled ({len(stall)})")
                _save(state_path, pool, halo, stall)
                continue
            added = [p for p in _ddmin_single(pool, AVn[t], HVn[t], log=log) if p not in set(halo)]
        halo += added
        recheck([q for q in queue])
        queue = [q for q in queue if not covered[q]]
        log(f"[cover] +{len(added)} pts (halo {len(halo)}): covered {int(covered.sum())}/{len(cols)}, "
            f"queue {len(queue)}, stall {len(stall)} [{time.time()-t0:.0f}s]", flush=True)
        _save(state_path, pool, halo, stall)
    live = [(AVn[t], HVn[t]) for t in range(len(cols)) if t not in set(stall)]
    halo2 = _shrink_halo(pool, halo, live, log)
    _save(state_path, pool, halo2, stall)
    row = {"kind": "cover", **pool.cite(), "n_colourings": len(cols), "halo_size": len(halo2),
           "covered": len(cols) - len(stall), "stalled": len(stall),
           "stall_indices": stall, "seconds": round(time.time() - t0, 1),
           "claim_scope": "a halo from the named pool whose list-colouring problem is infeasible "
           "under every covered colouring (lookup; the certification ask is separate); stalled "
           "colourings survive the WHOLE pool (no constructible subset kills them)"}
    T.record(BUILD / "m50-batch.json", row)
    return {"halo": halo2, "stall": stall, "row": row}


def _save(state_path, pool, halo, stall):
    state_path.write_text(json.dumps({"pool_fingerprint": pool.fp, "halo": halo, "stall": stall}))


def _ddmin_single(pool: Pool, av, hv, log=print):
    """Shrink to a 1-minimal kill of ONE colouring, starting from the PEELED core (every minimal
    kill lives inside it: a globally peelable point is peelable in any subset — §Bʺ)."""
    alive, _halive = peel_np(pool, np.asarray(av, dtype=np.uint8), hv)
    core = [int(x) for x in np.flatnonzero(alive)]
    assert core or (len(_halive) and _halive.any()), "peel emptied a colouring ddmin was called on — it was feasible"
    chunk = max(1, len(core) // 2)
    while core and chunk >= 1:
        pieces = [core[i:i + chunk] for i in range(0, len(core), chunk)]
        base = list(core)
        res = mechanism.pmap(lambda pc: not feasible(pool, [v for v in base if v not in set(pc)], av, hv),
                             pieces)
        passing = [pc for pc, ok in zip(pieces, res) if ok]
        accepted = []
        if passing:
            union = set().union(*map(set, passing))
            if not feasible(pool, [v for v in core if v not in union], av, hv):
                core = [v for v in core if v not in union]
                accepted = sorted(union)
            else:
                for pc in passing:
                    if not feasible(pool, [v for v in core if v not in set(pc)], av, hv):
                        core = [v for v in core if v not in set(pc)]
                        accepted += pc
        if not accepted:
            if chunk == 1:
                break
            chunk = max(1, chunk // 2)
    return core


def _shrink_halo(pool: Pool, halo, avs, log=print):
    """Drop halo points whose removal keeps every covered colouring killed (parallel ddmin)."""
    core = list(halo)
    chunk = max(1, len(core) // 2)
    while core and chunk >= 1:
        pieces = [core[i:i + chunk] for i in range(0, len(core), chunk)]
        base = list(core)
        res = mechanism.pmap(lambda pc: kills(pool, [v for v in base if v not in set(pc)], avs), pieces)
        passing = [pc for pc, ok in zip(pieces, res) if ok]
        accepted = []
        if passing:
            union = set().union(*map(set, passing))
            if kills(pool, [v for v in core if v not in union], avs):
                core = [v for v in core if v not in union]
                accepted = sorted(union)
            else:
                for pc in passing:
                    if kills(pool, [v for v in core if v not in set(pc)], avs):
                        core = [v for v in core if v not in set(pc)]
                        accepted += pc
        if not accepted:
            if chunk == 1:
                break
            chunk = max(1, chunk // 2)
        log(f"[shrink] chunk {chunk}: |halo| = {len(core)}")
    return core


# ---------------------------------------------------------------- certification (phase 4)

def certify(obj: Obj, B, pool: Pool, halo, label: str, log=print) -> dict:
    """The commit: exact sympy coordinates for every halo point FROM ITS PROVENANCE, every unit
    edge verified (exact within a 10-s budget, else 200-digit numeric, LABELLED), then the one-hot
    ask and the 3-bit re-encode on the true object. The ask is always run (§Bʺ)."""
    import sympy as sp
    t0 = time.time()
    exact: dict[int, object] = {}

    def resolve(idx):
        if idx in exact:
            return exact[idx]
        if idx < obj.n:
            rec = obj.prov[idx]
            if rec[0] == "seed":
                e = seed_exact(obj.seed_exact_pts[rec[1]])
            else:
                _, a, b, s = rec
                e = intersect(resolve(a), resolve(b), s)
            exact[idx] = e
            return e
        raise KeyError(idx)

    # halo points: pool indices -> object indices as we append
    idx_of_pool: dict[int, int] = {}
    n0 = obj.n
    ordered = _topo_halo(pool, halo)
    aux = len(ordered) - len(halo)
    if aux:
        log(f"[certify {label}] +{aux} construction auxiliaries (parents of kept depth-2 points)", flush=True)
    for p in ordered:
        kind, a, b, s = pool.prov[p]
        pa = a if a < n0 else idx_of_pool[a - n0] if False else a  # parents: obj index or pool index
        # pool prov parents: < obj.n are object points; >= obj.n are POOL indices (depth-2 recs)
        A_ = a if a < n0 else idx_of_pool[_pool_parent(pool, a, n0)]
        B_ = b if b < n0 else idx_of_pool[_pool_parent(pool, b, n0)]
        new = obj.add_glue(A_, B_, s)
        idx_of_pool[p] = new
        exact[new] = intersect(resolve(A_), resolve(B_), s)
    obj.check()
    # exact verification of every unit edge touching the halo
    ue = obj.unit_edges()
    new_ids = set(idx_of_pool.values())
    kinds = {"exact": 0, "numeric-200": 0}
    for a, b in ue:
        if a in new_ids or b in new_ids:
            ok, how = is_unit(resolve(a), resolve(b))
            assert ok, ("edge not unit", a, b)
            kinds[how] += 1
    log(f"[certify {label}] {len(new_ids)} points exact, "
        f"{sum(kinds.values())} halo edges verified {kinds} [{time.time()-t0:.0f}s]", flush=True)
    # the ask
    tp = [e for e in obj.cheats if tuple(e) not in set(map(tuple, B))]
    st = T.forces_outcome(obj.n, ue, tp, obj.A, obj.B, 3600)
    re = (rigidity.reencode_confirm(obj.n, ue, K, tp + [(obj.A, obj.B)], cap=7200)["outcome"]
          if st == "unsat" else "not-run")
    verdict = "committed" if st == "unsat" and re == "unsat" else \
              ("candidate" if st == "unsat" else "refused")
    row = {"kind": "batch-commit", "label": label, "batch": [list(e) for e in B],
           **pool.cite(), "halo_size": len(new_ids), "construction_auxiliaries": aux,
           "edge_verification": kinds,
           "outcome": st, "reencode": re, "verdict": verdict,
           "object_after": {"n": obj.n, "unit": len(ue), "cheats": len(tp)},
           "halo_prov": [pool.prov[p] for p in ordered],
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the whole batch removed at once with the designed halo added: "
           "committed = UNSAT in both encodings on the true object (geometry exact or labelled "
           "numeric-200 per edge); candidate = one-hot only; refused = a separating colouring "
           "exists (the design missed — investigate before anything else)"}
    T.record(BUILD / "m50-batch.json", row)
    if verdict == "committed":
        (BUILD / f"m50-object-{label}.json").write_text(json.dumps(
            {"prov": obj.prov[214:], "removed": [list(e) for e in B],
             "fingerprint": obj.fingerprint([tuple(e) for e in B]),
             "n": obj.n, "unit": len(ue), "cheats": len(tp)}))
    log(f"[certify {label}] {verdict} (one-hot {st}, 3-bit {re}); object n={obj.n}, "
        f"cheats {len(tp)} [{time.time()-t0:.0f}s]")
    return row


def _pool_parent(pool, idx, n0):
    """A depth-2 prov parent >= n0 refers to a depth-1 POOL point by pool index n0+k... in
    pool_depth2_restricted the remap already made parents pool indices offset by obj.n; here the
    pool index is `idx - n0` only when depth-1 points are first in the pool — which they are."""
    return idx - n0


def _topo_halo(pool: Pool, halo):
    """Order halo pool-indices so every glue parent that is itself a pool point comes first.
    A cited parent OUTSIDE the halo is INCLUDED as a construction auxiliary: the shrink may drop a
    depth-1 point a kept depth-2 point was built from — the kill survives (killing is monotone in
    the point set) and the certification runs on the object actually built."""
    n0 = pool.obj.n
    out, done = [], set()

    def visit(p):
        if p in done:
            return
        done.add(p)
        _, a, b, _s = pool.prov[p]
        for parent in (a, b):
            if parent >= n0:
                visit(parent - n0)
        out.append(p)

    for p in halo:
        visit(p)
    return out


# ---------------------------------------------------------------- self-test (phase 1 controls)

def self_test():
    random.seed(0)
    obj = Obj()
    assert len(obj.unit_edges()) == 1004, "cKDTree census disagrees with the exact seed census"
    # provenance smart constructor + check, and a planted corruption (a unit pair's glue point;
    # (76,78) itself is a CHEAT pair at distance 2 — no unit-circle intersection about it)
    u0, v0 = obj.unit_edges()[0]
    i = obj.add_glue(u0, v0, 1)
    obj.check()
    obj.pts[i] = (obj.pts[i][0] + 1e-4, obj.pts[i][1])
    try:
        obj.check()
        raise SystemExit("planted provenance corruption NOT caught")
    except AssertionError:
        pass
    obj = Obj()
    # depth-1 pool reproduces the M49 census numbers
    p1 = pool_depth1(obj)
    hist = {}
    for N in p1.nbrs:
        hist[len(N)] = hist.get(len(N), 0) + 1
    assert len(p1.pts) == 9271 and hist.get(5, 0) == 25 and hist.get(8, 0) == 22, (len(p1.pts), hist)
    # the known kill of (76,78): its 2 separating colourings die on the pool point at (…) — via
    # the M49 artifact; monotonicity probe: still dead after adding 20 random points
    sep = json.loads((BUILD / "m49-sep-76-78.json").read_text())
    cols = sep["colourings"]
    assert sep["exact"] and len(cols) == 2
    AV = [(avail_masks(obj, p1, c), halo_masks(obj, c)) for c in cols]
    single = [p for p in range(len(p1.pts)) if all(av[p] == 0 for av, _ in AV)]
    assert single, "the certified single-point kill of (76,78) not found by the mask sweep"
    probe = [single[0]] + random.sample(range(len(p1.pts)), 20)
    assert kills(p1, probe, AV), "monotonicity probe failed: adding points un-killed a kill"
    # a fake kill refused: a random far point does not kill
    far = max(range(len(p1.pts)), key=lambda p: len(p1.nbrs[p]) == 2 and p)
    assert not kills(p1, [far], AV), "a 2-neighbour point cannot kill 2 colourings"
    print("batchkill self-test: PASS")


# ---------------------------------------------------------------- phase drivers

def floor_batch():
    """The 29 lower-bound cheats (M49's single-deletion census)."""
    cen = json.loads((BUILD / "m49-seed-edges.json").read_text())
    return [tuple(e) for e in [r for r in cen["rows"]
                               if r["kind"] == "single-deletion-census"][-1]["essential_alone"]]


def _ctx(args):
    """(obj, removed, seps_path, tag): iteration 1 by default; --object LABEL for a committed
    object's iteration (its floor's list at m50-S-LABEL-it2.jsonl)."""
    lab = next((args[i + 1] for i, a in enumerate(args) if a == "--object"), None)
    if lab:
        obj, removed = load_object(lab)
        return obj, removed, BUILD / f"m50-S-{lab}-it2.jsonl", f"{lab}-it2"
    return Obj(), [], BUILD / "m50-S29.jsonl", "S29"


def _gated_seps(seps_path: Path, ack: bool):
    header, cols = load_seps(seps_path)
    rows = json.loads((BUILD / "m50-batch.json").read_text())["rows"]
    enum_rows = [r for r in rows if r["kind"] == "enumeration"
                 and r["stage_fingerprint"] == header["stage_fingerprint"]]
    assert enum_rows, "no enumeration row for this stage — run --enumerate to completion first"
    status = enum_rows[-1]["status"]
    gate = enum_rows[-1]["gate"]
    if status != "exact" and not ack:
        raise SystemExit(f"status = {status}: the list is INCOMPLETE — a design against it is a "
                         "POOL-CHOICE; re-run with --pool-choice-ack to state that explicitly")
    if status == "exact" and gate == "blocked":
        print(f"[gate] list is EXACT but large ({len(cols)}): sound, cost scales with |S| "
              "(the registered 30k bound was a cost heuristic — P1's miss, recorded)")
    return header, cols, gate


def _build_pool(obj: Obj, name: str) -> Pool:
    p1 = pool_depth1(obj)
    if name == "depth1":
        return p1
    if name == "depth2r":
        return pool_depth2_restricted(obj, p1)
    raise SystemExit(f"unknown pool {name!r} (depth1 | depth2r)")


def filter_check():
    """Phase 2's control: the sub-batch filters must reproduce M49's exact counts (684 for the 12
    depth-one-removed edges, 1,010 for the composed 14) — the §Bʺ one-per-orbit argument, end to
    end. Runnable only on the COMPLETE list."""
    header, cols, gate = _gated_seps(BUILD / "m50-S29.jsonl", ack=False)
    B29 = set(map(tuple, header["batch"]))
    desc = json.loads((BUILD / "m49-descent5.json").read_text())
    r12 = [tuple(r["target"]) for r in desc["rows"]
           if r.get("label") == "seed-k5-lb" and r.get("verdict") == "removed"]
    r14 = r12 + [(56, 168), (56, 78)]
    for name, B, want in (("12", r12, 684), ("14", r14, 1010)):
        keep = [e for e in B29 if e not in set(B)]
        got = len(filter_sub(Obj(), cols, keep))
        print(f"filter {name}-edge batch: {got} colourings (M49 exact: {want}) "
              f"{'OK' if got == want else 'MISMATCH'}")
        assert got == want, "the one-per-orbit filter argument FAILED its end-to-end control"
    row = {"kind": "filter-check", "stage_fingerprint": header["stage_fingerprint"],
           "checks": {"12": 684, "14": 1010}, "outcome": "ok",
           "claim_scope": "the sub-batch palette-orbit filters reproduce M49's independently "
           "enumerated exact counts — the §Bʺ argument tested end to end"}
    T.record(BUILD / "m50-batch.json", row)


def run_profile(args, pool_name: str, ack: bool, survivors_of: str | None = None):
    obj, removed, seps_path, tag = _ctx(args)
    header, cols, gate = _gated_seps(seps_path, ack)
    pool = _build_pool(obj, pool_name)
    label = f"{tag}-{pool.name}"
    if survivors_of:
        idx = json.loads((BUILD / f"m50-survivors-{survivors_of}.json").read_text())
        cols = [cols[i] for i in idx]
        label += f"-of-{survivors_of}"
        print(f"[profile] restricted to the {len(cols)} survivors of {survivors_of}")
    print(f"[profile] pool {pool.name}: {len(pool.pts)} points (fp {pool.fp}); |S| = {len(cols)}")
    profile(obj, pool, cols, label=label)


def run_hitting(args, deepest_label: str):
    """Exact minimum hitting set over the deepest profile's survivors: keep the fewest cheats such
    that every surviving colouring is mono on a kept cheat; commit the rest."""
    from scipy.optimize import milp, LinearConstraint, Bounds
    obj, removed, seps_path, tag = _ctx(args)
    header, cols, gate = _gated_seps(seps_path, ack=False)
    B = [tuple(e) for e in header["batch"]]
    surv_idx = json.loads((BUILD / f"m50-survivors-{deepest_label}.json").read_text())
    # survivors are indices into the PREVIOUS restriction chain; resolve through chained files
    chain = deepest_label
    idx = surv_idx
    while "-of-" in chain:
        chain = chain.split("-of-", 1)[1]
        outer = json.loads((BUILD / f"m50-survivors-{chain}.json").read_text())
        idx = [outer[i] for i in idx]
    hard = [cols[i] for i in idx]
    elems = sorted({e for c in hard for e in B if c[e[0]] == c[e[1]]})
    ei = {e: k for k, e in enumerate(elems)}
    A = np.zeros((len(hard), len(elems)))
    for r, c in enumerate(hard):
        for e in elems:
            if c[e[0]] == c[e[1]]:
                A[r, ei[e]] = 1
    res = milp(c=np.ones(len(elems)), constraints=LinearConstraint(A, lb=np.ones(len(hard)), ub=np.inf),
               integrality=np.ones(len(elems)), bounds=Bounds(0, 1))
    assert res.success
    keep = [elems[k] for k in range(len(elems)) if res.x[k] > 0.5]
    commit = [e for e in B if e not in set(keep)]
    (BUILD / f"m50-hitting-{tag}.json").write_text(json.dumps(
        {"keep": [list(e) for e in keep], "commit": [list(e) for e in commit]}))
    print(f"[hitting {tag}] {len(hard)} survivors over {len(elems)} cheats → keep {len(keep)}, "
          f"COMMIT {len(commit)} of {len(B)}")


def run_design(args, pool_name: str, ack: bool):
    """Cover design for the COMMITTABLE batch (the tag's hitting-set file names the kept cheats)."""
    obj, removed, seps_path, tag = _ctx(args)
    header, cols, gate = _gated_seps(seps_path, ack)
    pool = _build_pool(obj, pool_name)
    hit = json.loads((BUILD / f"m50-hitting-{tag}.json").read_text())
    keep = [tuple(e) for e in hit["keep"]]
    sub = filter_sub(obj, cols, keep)
    print(f"[design {tag}] pool {pool.name}: {len(pool.pts)} pts (fp {pool.fp}); commit batch "
          f"{len(hit['commit'])} edges, |S_commit| = {len(sub)}")
    cover(obj, pool, sub, BUILD / f"m50-cover-{tag}-{pool.name}.json")


def run_commit(args, pool_name: str):
    obj, removed, seps_path, tag = _ctx(args)
    header, cols, gate = _gated_seps(seps_path, ack=False)
    pool = _build_pool(obj, pool_name)
    cov_path = BUILD / f"m50-cover-{tag}-{pool.name}.json"
    if not cov_path.exists() and tag == "S29":
        cov_path = BUILD / "m50-cover-depth2r.json"      # iteration 1's original name
    st_ = json.loads(cov_path.read_text())
    assert st_["pool_fingerprint"] == pool.fp, "cover state is for a different pool"
    halo, stall = st_["halo"], st_["stall"]
    assert not stall, "the cover stalled on the committable list — the hitting set must be redone"
    hp = BUILD / f"m50-hitting-{tag}.json"
    if not hp.exists() and tag == "S29":
        hp = BUILD / "m50-hitting.json"
    hit = json.loads(hp.read_text())
    keep = [tuple(e) for e in hit["keep"]]
    B = [tuple(e) for e in hit["commit"]]
    sub = filter_sub(obj, cols, keep)
    print(f"[commit {tag}] batch {len(B)} edges, halo {len(halo)} pts; lookup re-check on "
          f"{len(sub)} colourings")
    AVs = [(avail_masks(obj, pool, c), halo_masks(obj, c)) for c in sub]
    assert kills(pool, halo, AVs), "the halo does not kill the committable list — investigate"
    certify(obj, list(removed) + B, pool, halo, label=f"{tag}-{pool.name}")


def load_object(label: str) -> tuple[Obj, list]:
    """Rebuild a committed object from its persisted object-relative provenance; verify the
    fingerprint and the mpmath check."""
    d = json.loads((BUILD / f"m50-object-{label}.json").read_text())
    obj = Obj()
    for rec in d["prov"]:
        kind, a, b, sgn = rec
        assert kind == "glue"
        obj.add_glue(a, b, sgn)
    removed = [tuple(e) for e in d["removed"]]
    assert obj.n == d["n"]
    assert obj.fingerprint(removed) == d["fingerprint"], "object rebuild fingerprint mismatch"
    obj.check()
    return obj, removed


def run_recurse(label: str, cap: float = 240.0):
    """Iteration k+1's census: on the committed object, every remaining cheat's single deletion —
    sat = essential alone (the new floor), unsat = deletable alone, unknown counted."""
    obj, removed = load_object(label)
    tp = [e for e in obj.cheats if tuple(e) not in set(removed)]
    ue = obj.unit_edges()
    print(f"[recurse] object n={obj.n} (check OK), unit {len(ue)}, cheats {len(tp)}")
    ne = [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]

    def ask(i):
        edges = ue + [e for j, e in enumerate(tp) if j != i]
        cls = coloring.base_clauses(obj.n, edges, K) + rigidity.amo_clauses(obj.n, K)
        cls += T._brk_full(obj.n, K, T._degree_order(obj.n, edges)) + ne
        st, _ = forcer._solve(cls, obj.n * K, cap)
        return st

    t0 = time.time()
    outs = mechanism.pmap(ask, list(range(len(tp))))
    ess = [tp[i] for i, st in enumerate(outs) if st == "sat"]
    unk = sum(1 for st in outs if st == "unknown")
    row = {"kind": "recurse-census", "label": label, "object_fingerprint":
           obj.fingerprint(removed), "cheats": len(tp), "floor": len(ess), "unknown": unk,
           "essential_alone": [list(e) for e in ess], "cap": cap,
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "single-deletion census on the committed object: sat = a validated "
           "separating colouring exists without that cheat alone (it lies in every forcing "
           "subset of THIS object — the new floor), unknown = undecided at cap"}
    T.record(BUILD / "m50-batch.json", row)
    print(f"[recurse] floor {len(ess)} of {len(tp)} cheats ({unk} unknown) [{time.time()-t0:.0f}s]")


# ---------------------------------------------------------------- status / CLI

def status():
    art = BUILD / "m50-batch.json"
    if not art.exists():
        print("no m50-batch.json yet — nothing has run; start with --enumerate")
        return
    rows = json.loads(art.read_text())["rows"]
    for r in rows[-12:]:
        keys = [k for k in ("kind", "label", "count", "status", "gate", "killed", "survive",
                            "halo_size", "covered", "stalled", "verdict", "outcome") if k in r]
        print(" · ".join(f"{k}={r[k]}" for k in keys))
    sp = BUILD / "m50-S29.jsonl"
    if sp.exists():
        print(f"S29 file: {len(sp.read_text().splitlines()) - 1} colourings on disk")


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--self-test" in args:
        self_test()
    elif "--status" in args:
        status()
    elif "--enumerate" in args:
        lab = next((args[i + 1] for i, a in enumerate(args) if a == "--object"), None)
        if lab:
            obj, removed = load_object(lab)
            rows = json.loads((BUILD / "m50-batch.json").read_text())["rows"]
            rc = [r for r in rows if r["kind"] == "recurse-census" and r["label"] == lab][-1]
            B = [tuple(e) for e in rc["essential_alone"]]
            out = next((args[i + 1] for i, a in enumerate(args) if a == "--out"), f"m50-S-{lab}-it2.jsonl")
            enumerate_cubes(obj, B, BUILD / out, block_on=range(214))
        else:
            enumerate_cubes(Obj(), floor_batch(), BUILD / "m50-S29.jsonl")
    elif "--filter-check" in args:
        filter_check()
    elif "--profile" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth1")
        so = next((args[i + 1] for i, a in enumerate(args) if a == "--survivors-of"), None)
        run_profile(args, pool_name, ack="--pool-choice-ack" in args, survivors_of=so)
    elif "--hitting" in args:
        run_hitting(args, next(args[i + 1] for i, a in enumerate(args) if a == "--deepest"))
    elif "--design" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth2r")
        run_design(args, pool_name, ack="--pool-choice-ack" in args)
    elif "--commit" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth2r")
        run_commit(args, pool_name)
    elif "--recurse" in args:
        run_recurse(next((args[i + 1] for i, a in enumerate(args) if a == "--label"), "S29-depth2r"))
    else:
        print(__doc__)
