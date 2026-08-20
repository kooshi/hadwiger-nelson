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
            tree = cKDTree(np.array(self.pts))
            pairs = tree.query_pairs(1 + TOL)
            self._unit = sorted((min(i, j), max(i, j)) for i, j in pairs
                                if abs(_d2(self.pts[i], self.pts[j]) - 1) < TOL)
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
        if pts:
            tree = cKDTree(np.array(pts))
            self.adj = [[] for _ in pts]
            for i, j in tree.query_pairs(1 + TOL):
                if abs(_d2(pts[i], pts[j]) - 1) < TOL:
                    self.adj[i].append(j)
                    self.adj[j].append(i)
        else:
            self.adj = []
        self.fp = hashlib.sha256(repr((obj.fingerprint(), name, sorted(params.items()),
                                       [tuple(round(v, 6) for v in p) for p in pts])).encode()).hexdigest()[:16]

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
    out = []
    for N in pool.nbrs:
        used = 0
        for v in N:
            used |= 1 << col[v]
        out.append(FULL & ~used)
    return out


def feasible(pool: Pool, idxs, avail, cap=1800) -> bool:
    """List-colouring SAT of the pool subset `idxs` under precomputed avail masks."""
    loc = {p: i for i, p in enumerate(idxs)}
    cls = []
    for p in idxs:
        av = avail[p]
        if av == 0:
            return False
        cls.append([loc[p] * K + c + 1 for c in range(K) if av >> c & 1])
    for a in idxs:
        for b in pool.adj[a]:
            if b in loc and b > a:
                for c in range(K):
                    cls.append([-(loc[a] * K + c + 1), -(loc[b] * K + c + 1)])
    st, _ = forcer._solve(cls, len(idxs) * K, cap)
    assert st in ("sat", "unsat"), st
    return st == "sat"


def kills(pool: Pool, idxs, cols_avail) -> bool:
    """Does the subset kill EVERY colouring (avail-mask list per colouring)?"""
    return all(not feasible(pool, idxs, av) for av in cols_avail)


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
              "batch": [list(e) for e in B], "k": K, "order_fingerprint":
              hashlib.sha256(repr(order).encode()).hexdigest()[:16]}
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


def enumerate_cubes(obj: Obj, B, path: Path, cube_depth: int = 3, cap_wall: float = 12 * 3600,
                    log=print) -> dict:
    """The parallel form of `enumerate_seps`: pin the colours of the `cube_depth` vertices after
    the breaking anchor (the cubes PARTITION the solution set, and the breaking clauses are global,
    so the union over cubes is exactly the sequential run's set — one representative per palette
    orbit); each cube enumerates independently with ONLY ITS OWN blocking clauses (small CNFs), all
    cubes in parallel. Existing lines of `path` (a sequential run's output) are seeded into their
    cubes once; per-cube files live in `path.with_suffix('')`+"-cubes/"; on full completion the
    merged, deduplicated list is rewritten to `path` with the same header contract."""
    import itertools, shutil
    B = [tuple(e) for e in B]
    edges = obj.unit_edges() + [e for e in obj.cheats if tuple(e) not in set(B)]
    order = T._degree_order(obj.n, edges)
    header = {"kind": "enumeration-header", "stage_fingerprint": obj.fingerprint(B),
              "batch": [list(e) for e in B], "k": K, "order_fingerprint":
              hashlib.sha256(repr(order).encode()).hexdigest()[:16]}
    pins = order[1:1 + cube_depth]
    cdir = path.parent / (path.stem + "-cubes")
    cdir.mkdir(exist_ok=True)
    base = coloring.base_clauses(obj.n, edges, K) + rigidity.amo_clauses(obj.n, K)
    base += T._brk_full(obj.n, K, order)
    base += [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    cubes = list(itertools.product(range(K), repeat=cube_depth))
    # one-time seeding from a sequential run's file
    if path.exists():
        lines = path.read_text().splitlines()
        old = json.loads(lines[0])
        assert old["order_fingerprint"] == header["order_fingerprint"], "seed: order drifted"
        assert old["stage_fingerprint"] == header["stage_fingerprint"], "seed: stage drifted"
        buckets: dict[tuple, list[str]] = {}
        for line in lines[1:]:
            cs = json.loads(line)
            key = tuple(int(cs[p]) for p in pins)
            buckets.setdefault(key, []).append(line)
        for cube, ls in buckets.items():
            f = cdir / ("cube-" + "".join(map(str, cube)) + ".jsonl")
            assert not f.exists(), "seeding would clobber an existing cube file — already seeded?"
            f.write_text("\n".join(ls) + "\n")
        shutil.move(str(path), str(path) + ".seed.bak")
        log(f"[enumerate-cubes] seeded {sum(len(v) for v in buckets.values())} colourings "
            f"into {len(buckets)} cubes from the sequential run")
    t0 = time.time()

    def work(cube):
        f = cdir / ("cube-" + "".join(map(str, cube)) + ".jsonl")
        done = cdir / ("cube-" + "".join(map(str, cube)) + ".done")
        found = 0
        cls = list(base) + [[coloring.var(p, c, K)] for p, c in zip(pins, cube)]
        if f.exists():
            for line in f.read_text().splitlines():
                col = [int(ch) for ch in json.loads(line)]
                cls.append([-coloring.var(v, col[v], K) for v in range(obj.n)])
                found += 1
        if done.exists():
            return cube, found, "exact"
        status = "exact"
        with f.open("a") as fh:
            while True:
                if time.time() - t0 > cap_wall:
                    status = "capped-wall"
                    break
                st, model = forcer._solve(cls, obj.n * K, 1800)
                if st == "unsat":
                    done.write_text("unsat")
                    break
                if st != "sat":
                    status = "capped-solver"
                    break
                col = rigidity.decode(model, obj.n, K)
                for a, b in edges:
                    assert col[a] != col[b]
                assert col[obj.A] != col[obj.B]
                assert tuple(col[p] for p in pins) == cube, "cube pin violated — encoding bug"
                fh.write(json.dumps("".join(map(str, col))) + "\n")
                fh.flush()
                cls.append([-coloring.var(v, col[v], K) for v in range(obj.n)])
                found += 1
        return cube, found, status

    results = mechanism.pmap(work, cubes)
    total = sum(r[1] for r in results)
    open_cubes = [r for r in results if r[2] != "exact"]
    status = "exact" if not open_cubes else open_cubes[0][2]
    if not open_cubes:
        # merge back into the single-file contract, deduplicated
        seen = set()
        with path.open("w") as fh:
            fh.write(json.dumps(header) + "\n")
            for cube in cubes:
                f = cdir / ("cube-" + "".join(map(str, cube)) + ".jsonl")
                if f.exists():
                    for line in f.read_text().splitlines():
                        assert line not in seen, "duplicate representative across cubes"
                        seen.add(line)
                        fh.write(line + "\n")
        assert len(seen) == total
    gate = "proceed" if status == "exact" and total <= 30_000 else "blocked"
    row = {"kind": "enumeration", **header, "count": total, "status": status, "gate": gate,
           "cubes": {"depth": cube_depth, "open": len(open_cubes)},
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the separating colourings of the object minus the batch, one "
           "representative per palette orbit under the pinned breaking order, enumerated by "
           "parallel disjoint colour cubes on the pinned vertices (the cubes partition the "
           "solution set, so the union equals the sequential enumeration); EXACT only if "
           "status = exact (every cube closed by UNSAT)"}
    T.record(BUILD / "m50-batch.json", row)
    log(f"[enumerate-cubes] total {total} ({status}, gate {gate}, {len(open_cubes)} cubes open), "
        f"{time.time()-t0:.0f}s")
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
    AV = mechanism.pmap(lambda c: avail_masks(obj, pool, c), cols)
    outs = mechanism.pmap(lambda av: not feasible(pool, allidx, av), AV)
    row = {"kind": "profile", "label": label, **pool.cite(), "n_colourings": len(cols),
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
    """Greedy set-cover of the colouring list by a growing halo (§B2 + §Bʹ stage 0): the
    empty-avail sweep first (single points that kill a colouring outright), then per-colouring
    ddmin kills for the residue; coverage recheck after each addition (monotone: only grows).
    Checkpointed at every acceptance; resume by re-loading the halo and recomputing coverage."""
    AV = mechanism.pmap(lambda c: avail_masks(obj, pool, c), cols)
    halo: list[int] = []
    stall: list[int] = []
    if state_path.exists():
        st_ = json.loads(state_path.read_text())
        assert st_["pool_fingerprint"] == pool.fp, "resume: pool drifted"
        halo, stall = st_["halo"], st_["stall"]
        log(f"[cover] resumed: halo {len(halo)}, stall {len(stall)}")

    def covered_by(halo_idxs):
        return mechanism.pmap(lambda av: not feasible(pool, halo_idxs, av) if halo_idxs else False, AV)

    cov = covered_by(halo)
    t0 = time.time()
    queue = [t for t in range(len(cols)) if not cov[t] and t not in set(stall)]
    log(f"[cover] start: {sum(cov)} covered, {len(queue)} queued, {len(stall)} stalled")
    while queue:
        t = min(queue, key=lambda t: sum(1 for a in AV[t] if a == 0))  # fewest free kills last
        # stage 0: an empty-avail single point kills cols[t] outright
        empt = [p for p in range(len(pool.pts)) if AV[t][p] == 0 and p not in set(halo)]
        added = None
        if empt:
            added = [empt[0]]
        else:
            allidx = list(range(len(pool.pts)))
            if feasible(pool, allidx, AV[t]):
                stall.append(t)
                queue = [q for q in queue if q != t]
                log(f"[cover] colouring {t}: survives the whole pool — stalled ({len(stall)})")
                _save(state_path, pool, halo, stall)
                continue
            # ddmin the pool against this single colouring
            core = _ddmin_single(pool, AV[t], log=log)
            added = [p for p in core if p not in set(halo)]
        halo += added
        cov = covered_by(halo)
        queue = [q for q in range(len(cols)) if not cov[q] and q not in set(stall)]
        log(f"[cover] +{len(added)} pts (halo {len(halo)}): covered {int(sum(cov))}/{len(cols)}, "
            f"queue {len(queue)}, stall {len(stall)} [{time.time()-t0:.0f}s]", flush=True)
        _save(state_path, pool, halo, stall)
    # global shrink: drop halo points that no colouring needs (cheap necessity pass)
    halo2 = _shrink_halo(pool, halo, [AV[t] for t in range(len(cols)) if t not in set(stall)], log)
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


def _ddmin_single(pool: Pool, av, log=print):
    """Shrink the whole pool to a 1-minimal kill of ONE colouring (its avail masks `av`)."""
    core = [p for p in range(len(pool.pts))]
    chunk = max(1, len(core) // 2)
    while core and chunk >= 1:
        pieces = [core[i:i + chunk] for i in range(0, len(core), chunk)]
        base = list(core)
        res = mechanism.pmap(lambda pc: not feasible(pool, [v for v in base if v not in set(pc)], av),
                             pieces)
        passing = [pc for pc, ok in zip(pieces, res) if ok]
        accepted = []
        if passing:
            union = set().union(*map(set, passing))
            if not feasible(pool, [v for v in core if v not in union], av):
                core = [v for v in core if v not in union]
                accepted = sorted(union)
            else:
                for pc in passing:
                    if not feasible(pool, [v for v in core if v not in set(pc)], av):
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
           **pool.cite(), "halo_size": len(new_ids), "edge_verification": kinds,
           "outcome": st, "reencode": re, "verdict": verdict,
           "object_after": {"n": obj.n, "unit": len(ue), "cheats": len(tp)},
           "halo_prov": [pool.prov[p] for p in ordered],
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "the whole batch removed at once with the designed halo added: "
           "committed = UNSAT in both encodings on the true object (geometry exact or labelled "
           "numeric-200 per edge); candidate = one-hot only; refused = a separating colouring "
           "exists (the design missed — investigate before anything else)"}
    T.record(BUILD / "m50-batch.json", row)
    log(f"[certify {label}] {verdict} (one-hot {st}, 3-bit {re}); object n={obj.n}, "
        f"cheats {len(tp)} [{time.time()-t0:.0f}s]")
    return row


def _pool_parent(pool, idx, n0):
    """A depth-2 prov parent >= n0 refers to a depth-1 POOL point by pool index n0+k... in
    pool_depth2_restricted the remap already made parents pool indices offset by obj.n; here the
    pool index is `idx - n0` only when depth-1 points are first in the pool — which they are."""
    return idx - n0


def _topo_halo(pool: Pool, halo):
    """Order halo pool-indices so every glue parent that is itself a pool point comes first."""
    n0 = pool.obj.n
    chosen = set(halo)
    out, done = [], set()

    def visit(p):
        if p in done:
            return
        _, a, b, _s = pool.prov[p]
        for parent in (a, b):
            if parent >= n0:
                q = parent - n0
                assert q in chosen, "halo cites a pool parent outside the halo — add it"
                visit(q)
        done.add(p)
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
    AV = [avail_masks(obj, p1, c) for c in cols]
    single = [p for p in range(len(p1.pts)) if all(av[p] == 0 for av in AV)]
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


def _gated_seps(ack: bool):
    header, cols = load_seps(BUILD / "m50-S29.jsonl")
    rows = json.loads((BUILD / "m50-batch.json").read_text())["rows"]
    enum_rows = [r for r in rows if r["kind"] == "enumeration"
                 and r["stage_fingerprint"] == header["stage_fingerprint"]]
    assert enum_rows, "no enumeration row for this stage — run --enumerate to completion first"
    gate = enum_rows[-1]["gate"]
    if gate != "proceed" and not ack:
        raise SystemExit(f"gate = {gate}: the list is capped or oversized — a design against it is "
                         "a POOL-CHOICE; re-run with --pool-choice-ack to state that explicitly")
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
    header, cols, gate = _gated_seps(ack=False)
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


def run_profile(pool_name: str, ack: bool):
    header, cols, gate = _gated_seps(ack)
    obj = Obj()
    pool = _build_pool(obj, pool_name)
    print(f"[profile] pool {pool.name}: {len(pool.pts)} points (fp {pool.fp}); |S| = {len(cols)}")
    profile(obj, pool, cols, label=f"S29-{pool.name}")


def run_design(pool_name: str, ack: bool):
    header, cols, gate = _gated_seps(ack)
    obj = Obj()
    pool = _build_pool(obj, pool_name)
    print(f"[design] pool {pool.name}: {len(pool.pts)} points (fp {pool.fp}); |S| = {len(cols)}")
    cover(obj, pool, cols, BUILD / f"m50-cover-{pool.name}.json")


def run_commit(pool_name: str):
    header, cols, gate = _gated_seps(ack=False)
    obj = Obj()
    pool = _build_pool(obj, pool_name)
    st_ = json.loads((BUILD / f"m50-cover-{pool.name}.json").read_text())
    assert st_["pool_fingerprint"] == pool.fp, "cover state is for a different pool"
    halo, stall = st_["halo"], st_["stall"]
    B29 = [tuple(e) for e in header["batch"]]
    if stall:
        # commit the largest sub-batch the cover fully kills: drop the cheats the stalled
        # colourings force to stay (a stalled colouring separates A,B while proper on B29∖{its
        # mono cheats} — keep every cheat some stalled colouring is mono on)
        mono = set()
        for t in stall:
            c = cols[t]
            for e in B29:
                if c[e[0]] == c[e[1]]:
                    mono.add(e)
        B = [e for e in B29 if e not in mono]
        keepcols = [c for c in filter_sub(obj, cols, mono)]
        print(f"[commit] {len(stall)} stalled → keeping {len(mono)} cheats; batch = {len(B)} edges; "
              f"re-checking the cover kills the {len(keepcols)}-colouring sub-list")
        AVs = [avail_masks(obj, pool, c) for c in keepcols]
        assert kills(pool, halo, AVs), "the halo does not kill the sub-batch list — investigate"
    else:
        B = B29
    certify(obj, B, pool, halo, label=f"S29-{pool.name}")


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
        obj = Obj()
        enumerate_cubes(obj, floor_batch(), BUILD / "m50-S29.jsonl")
    elif "--filter-check" in args:
        filter_check()
    elif "--profile" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth1")
        run_profile(pool_name, ack="--pool-choice-ack" in args)
    elif "--design" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth2r")
        run_design(pool_name, ack="--pool-choice-ack" in args)
    elif "--commit" in args:
        pool_name = next((args[i + 1] for i, a in enumerate(args) if a == "--pool"), "depth2r")
        run_commit(pool_name)
    else:
        print(__doc__)
