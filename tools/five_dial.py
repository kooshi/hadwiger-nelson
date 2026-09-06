#!/usr/bin/env python3
"""five_dial — the five-colour dial (M54, 2026-09-05; `plans/M54-five-colour-dial.md` §4, §Bʹ–§Bʹʹʹ).

THE THEOREM IT LEANS ON (`Proofs/HadwigerNelson/CriticalSet.lean`). With C(G) = {v : G − v is
k-colourable} the critical set of G at k colours, a pair forced EQUAL at k + 1 colours has
C ⊆ N(p) ∩ N(q), and a non-adjacent pair forced DISTINCT (a virtual edge) has C ⊆ N(p) ∪ N(q).
In a unit-distance graph two points have at most two common unit neighbours, so a forced-equal pair
needs |C| ≤ 2 (none beyond distance 2) and a virtual edge |C| ≤ 2Δ. Hence the CENSUS prunes the
SWEEP: only the theorem-admitted candidates are ever asked. Every SAT verdict's colouring is verified
in Python (a critical vertex is certified by an explicit colouring); an UNSAT is solver-trusted and
only ENLARGES the candidate sets — the safe direction. A hit on a candidate is the jackpot protocol:
banner, second encoding, jackpot file, exit code 3.

Subcommands (each headline names its population and, where it prunes, the theorem):

    python3 tools/five_dial.py self-test
    python3 tools/five_dial.py critical  --seed --k 4                                   # P-M54-1: C(H) = ∅
    python3 tools/five_dial.py critical  --witness data/m53/forced-spindle-core-8over3.json --k 4 --workers 28
    python3 tools/five_dial.py ask       --critical data/m54/critical-<stage>.json --k 5
    python3 tools/five_dial.py nu        --witness ... --k 5 --wall 600
    python3 tools/five_dial.py exact-witness --witness data/m53/forced-spindle-core-8over3.json
    python3 tools/five_dial.py cross-lattice --exact data/m54/witness-exact-8over3.json --workers 28
    python3 tools/five_dial.py planted-sweep --witness data/m53/forced-spindle-core-8over3.json
    python3 tools/five_dial.py sweep     --witness ... --k 5 --wall 600

Stages: `--seed` (the Exoo–Ismailescu {1, 2}-graph), `--object <label>` (a descent object's {1, 2}-
graph with its standing cheats), `--witness <json>` (a forced-spindle record rebuilt at 60 digits),
`--graph <json>` ({n, edges}), `--planted <name>` (the controls). UNTRUSTED like all of tools/.
"""
from __future__ import annotations
import argparse, hashlib, json, os, random, sys, threading, time
from fractions import Fraction as Fr
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
sys.path.insert(0, str(Path(__file__).resolve().parent))

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "m54"
BUILD = ROOT / "build" / "m54"
JACKPOT_EXIT = 3


# ----------------------------------------------------------------------------- stages

class Stage:
    """A finite graph with a name and a fingerprint of its edge list (G21: every headline names it)."""

    def __init__(self, name: str, n: int, edges, source: str, meta: dict | None = None, pts=None):
        self.name, self.n, self.source = name, n, source
        self.edges = sorted({(min(u, v), max(u, v)) for u, v in edges if u != v})
        self.meta = dict(meta or {})
        self.pts = pts                                   # optional mpmath complex coordinates
        self.adj = [set() for _ in range(n)]
        for u, v in self.edges:
            self.adj[u].add(v); self.adj[v].add(u)

    def fingerprint(self) -> str:
        h = hashlib.sha256(); h.update(f"{self.n}\n".encode())
        for u, v in self.edges:
            h.update(f"{u} {v}\n".encode())
        return h.hexdigest()[:16]

    def header(self) -> dict:
        return dict(name=self.name, n=self.n, edges=len(self.edges), fingerprint=self.fingerprint(),
                    source=self.source, **self.meta)

    def delta(self) -> int:
        return max((len(a) for a in self.adj), default=0)

    def label(self) -> str:
        return f"{self.name} (n={self.n}, edges={len(self.edges)}, fp={self.fingerprint()})"


def rebuild_witness(path: str, dps: int = 60):
    """W = core ∪ R(core) from a forced-spindle record, at `dps` digits (the T21 recipe); returns
    (Stage, pts, core_labels, record). The unit edges are the pairs at |d − 1| < 10^-(dps-15)."""
    import mpmath as mp
    import batchkill as BK
    mp.mp.dps = dps
    W = json.loads(Path(path).read_text())
    obj, _ = BK.load_object(W["object"])
    ex = obj.mp_values(dps)
    core = W["core_vertices"]; x0 = W["pair"][0]
    q = Fr(W["distance_sq"]) if "distance_sq" in W else Fr(W["distance"]) ** 2
    qm = mp.mpf(q.numerator) / q.denominator
    R = mp.mpc(1 - 1 / (2 * qm), mp.sqrt(4 * qm - 1) / (2 * qm))
    zx = ex[x0]
    pts = [ex[v] for v in core] + [zx + R * (ex[v] - zx) for v in core if v != x0]
    n = len(pts); tol = mp.mpf(10) ** -(dps - 15)
    unit = []
    for i in range(n):
        pi = pts[i]
        for j in range(i + 1, n):
            if abs(abs(pi - pts[j]) - 1) < tol:
                unit.append((i, j))
    assert n == W["union_points"] and len(unit) == W["union_edges"], \
        ("the rebuilt witness differs from the record", n, len(unit), W["union_points"], W["union_edges"])
    name = Path(path).stem.replace("forced-spindle-", "W-")
    st = Stage(name, n, unit, f"witness {path} at {dps} digits",
               meta=dict(object=W["object"], pair=W["pair"], distance_sq=str(q), centre_index=core.index(x0)), pts=pts)
    return st, pts, core, W


def load_stage(a) -> Stage:
    if getattr(a, "seed", False):
        import batchkill as BK
        obj = BK.Obj()
        ue, ch = obj.unit_edges(), obj.cheats
        return Stage("EI-seed-12graph", obj.n, ue + ch, "tools/batchkill.Obj() unit ∪ cheats",
                     meta=dict(unit_edges=len(ue), cheats=len(ch), forced_pair=[obj.A, obj.B]))
    if getattr(a, "object", None):
        import batchkill as BK
        obj, removed = BK.load_object(a.object)
        rem = set(tuple(e) for e in removed)
        ue = obj.unit_edges(); ch = [tuple(e) for e in obj.cheats if tuple(e) not in rem]
        live = sorted(v for v in range(obj.n) if v not in obj.deleted)
        idx = {v: i for i, v in enumerate(live)}
        edges = [(idx[u], idx[v]) for u, v in ue + ch]
        return Stage(f"object-{a.object[-24:]}", len(live), edges, f"descent object {a.object} (unit ∪ standing cheats)",
                     meta=dict(unit_edges=len(ue), cheats=len(ch), forced_pair=[idx[obj.A], idx[obj.B]]))
    if getattr(a, "witness", None):
        st, _, _, _ = rebuild_witness(a.witness, getattr(a, "dps", 60))
        return st
    if getattr(a, "graph", None):
        d = json.loads(Path(a.graph).read_text())
        return Stage(d.get("name", Path(a.graph).stem), d["n"], [tuple(e) for e in d["edges"]], f"graph {a.graph}", meta=d.get("meta"))
    if getattr(a, "planted", None):
        return planted_stage(a.planted)
    raise SystemExit("no stage given (--seed | --object | --witness | --graph | --planted)")


def planted_stage(name: str) -> Stage:
    if name == "k5e":                                    # K₅ minus {0,1}: forces (0,1) at 4; C at 3 = {2,3,4}
        E = [(i, j) for i in range(5) for j in range(i + 1, 5) if (i, j) != (0, 1)]
        return Stage("planted-K5-minus-edge", 5, E, "planted")
    if name == "k4e":                                    # K₄ minus {0,1}: forces (0,1) at 3; C at 2 = {2,3}
        E = [(i, j) for i in range(4) for j in range(i + 1, 4) if (i, j) != (0, 1)]
        return Stage("planted-K4-minus-edge", 4, E, "planted")
    if name == "k5":
        return Stage("planted-K5", 5, [(i, j) for i in range(5) for j in range(i + 1, 5)], "planted")
    if name == "two-k5":
        E = [(i, j) for i in range(5) for j in range(i + 1, 5)] + [(i, j) for i in range(5, 10) for j in range(i + 1, 10)]
        return Stage("planted-two-K5", 10, E, "planted")
    raise SystemExit(f"unknown planted stage {name}")


# ----------------------------------------------------------------------------- SAT

def var(v: int, c: int, k: int) -> int:
    return v * k + c + 1


def colour_clauses(n: int, edges, k: int) -> list[list[int]]:
    cl = [[var(v, c, k) for c in range(k)] for v in range(n)]
    for u, v in edges:
        for c in range(k):
            cl.append([-var(u, c, k), -var(v, c, k)])
    return cl


def sat(clauses, nv_hint: int = 0, wall: float | None = None):
    """('sat', model) | ('unsat', None) | ('unknown', None); `wall` in seconds via interrupt."""
    from pysat.solvers import Solver
    with Solver(name="cadical153", bootstrap_with=clauses) as s:
        if wall:
            t = threading.Timer(wall, s.interrupt); t.start()
            try:
                r = s.solve_limited(expect_interrupt=True)
            finally:
                t.cancel()
        else:
            r = s.solve()
        if r is None:
            return "unknown", None
        if r:
            return "sat", s.get_model()
        return "unsat", None


def decode(model, n: int, k: int) -> list[int]:
    """A colouring from a model of the at-least-one encoding: the smallest true colour per vertex."""
    true = set(l for l in model if l > 0)
    out = []
    for v in range(n):
        cs = [c for c in range(k) if var(v, c, k) in true]
        assert cs, ("a vertex with no colour in a model", v)
        out.append(cs[0])
    return out


def verify_proper(colours, edges, skip: int | None = None):
    """Every edge not touching `skip` is bichromatic; returns the first offending edge or None."""
    for u, v in edges:
        if u == skip or v == skip:
            continue
        if colours[u] == colours[v]:
            return (u, v)
    return None


# ----------------------------------------------------------------------------- the criticality census

_W: dict = {}


def _init_worker(n, edges, k, wall):
    _W.update(n=n, edges=edges, k=k, wall=wall)


def _deletion_ask(v: int):
    """Is G − v k-colourable? SAT ⟹ v is critical (certified by the verified colouring)."""
    n, edges, k, wall = _W["n"], _W["edges"], _W["k"], _W["wall"]
    E = [e for e in edges if v not in e]
    cl = colour_clauses(n, E, k)
    pin = 0 if v != 0 else 1                             # never pin the deleted vertex
    if n > 1:
        cl.append([var(pin, 0, k)])
    t0 = time.time()
    st, model = sat(cl, wall=wall)
    dt = time.time() - t0
    if st == "sat":
        col = decode(model, n, k)
        bad = verify_proper(col, E)
        if bad is not None:
            return v, "FAIL", dict(edge=bad, seconds=dt)
        return v, "critical", dict(colouring="".join(str(c) for c in col), seconds=dt)
    return v, ("noncritical" if st == "unsat" else "unknown"), dict(seconds=dt)


def critical_census(st: Stage, k: int, workers: int, wall: float | None, out: Path, log=print) -> dict:
    """C(G) at k colours, in parallel, checkpointed to `<out>.partial.jsonl`, resumable."""
    part = out.with_suffix(out.suffix + ".partial.jsonl")
    done: dict[int, tuple[str, dict]] = {}
    if part.exists():
        for line in part.read_text().splitlines():
            if line.strip():
                r = json.loads(line); done[r["v"]] = (r["verdict"], r["info"])
        log(f"[critical] resumed {len(done)} verdicts from {part}")
    todo = [v for v in range(st.n) if v not in done]
    t0 = time.time()
    with part.open("a") as fh, ProcessPoolExecutor(max_workers=workers, initializer=_init_worker,
                                                 initargs=(st.n, st.edges, k, wall)) as ex:
        futs = {ex.submit(_deletion_ask, v): v for v in todo}
        for i, f in enumerate(as_completed(futs), 1):
            v, verdict, info = f.result()
            if verdict == "FAIL":
                raise SystemExit(f"[critical] FAIL: the solver's colouring for G − {v} is improper on edge {info['edge']} — halting")
            done[v] = (verdict, info)
            fh.write(json.dumps(dict(v=v, verdict=verdict, info=info)) + "\n"); fh.flush()
            if i % 100 == 0 or i == len(todo):
                nc = sum(1 for x in done.values() if x[0] == "critical")
                log(f"[critical] {len(done)}/{st.n} verdicts, {nc} critical so far [{time.time()-t0:.0f}s]")
    C = sorted(v for v, (vd, _) in done.items() if vd == "critical")
    U = sorted(v for v, (vd, _) in done.items() if vd == "unknown")
    NC = sorted(v for v, (vd, _) in done.items() if vd == "noncritical")
    return dict(critical=C, unknown=U, noncritical=NC,
                colourings={v: done[v][1]["colouring"] for v in C},
                seconds=round(time.time() - t0, 1))


def candidate_sets(st: Stage, C, unknown=()) -> dict:
    """The pairs the theorem admits. Unknown vertices are treated as NOT critical (the safe direction:
    fewer critical vertices ⟹ more candidates). 𝒫_eq = pairs inside ⋂_{c∈C} N(c); 𝒫_ne = non-adjacent
    (p, q) with C ⊆ N(p) ∪ N(q)."""
    n = st.n
    nb = [0] * n
    for v in range(n):
        m = 0
        for w in st.adj[v]:
            m |= 1 << w
        nb[v] = m
    Cs = [c for c in C if c not in set(unknown)]
    full = (1 << n) - 1
    T = full
    for c in Cs:
        T &= nb[c]
    Teq = [v for v in range(n) if T >> v & 1]
    P_eq = [(p, q) for i, p in enumerate(Teq) for q in Teq[i + 1:]]
    Cmask = 0
    for c in Cs:
        Cmask |= 1 << c
    P_ne = []
    for p in range(n):
        U = Cmask & ~nb[p]
        if U == 0:
            T2 = full
        else:
            T2 = full
            u = U
            while u:
                lsb = u & -u; c = lsb.bit_length() - 1; u ^= lsb
                T2 &= nb[c]
                if T2 == 0:
                    break
        T2 &= ~nb[p] & ~(1 << p)
        q = T2 >> (p + 1)
        j = p + 1
        while q:
            if q & 1:
                P_ne.append((p, j))
            q >>= 1; j += 1
    return dict(common_neighbourhood=Teq, candidates_eq=P_eq, candidates_ne=P_ne)


def cmd_critical(a):
    st = load_stage(a)
    DATA.mkdir(parents=True, exist_ok=True)
    out = Path(a.out) if a.out else DATA / f"critical-{st.name}.json"
    log = print
    log(f"[critical] {st.label()}: k = {a.k}, {a.workers} workers, wall {a.wall}s per ask", flush=True)
    res = critical_census(st, a.k, a.workers, a.wall, out, log)
    C, U = res["critical"], res["unknown"]
    cands = candidate_sets(st, C, U)
    delta = st.delta()
    n_eq, n_ne = len(cands["candidates_eq"]), len(cands["candidates_ne"])
    log(f"[critical] {st.label()} k={a.k}: |C| = {len(C)} of {st.n} ({len(C)} verified colourings, {len(U)} unknown at wall, "
        f"{len(res['noncritical'])} non-critical), Δ = {delta}, |C|/n = {len(C)/st.n:.3f}; "
        f"forced-equal candidates {n_eq} (theorem: C ⊆ N(p) ∩ N(q)), virtual-edge candidates {n_ne} (C ⊆ N(p) ∪ N(q))"
        + ("" if not U else f" — {len(U)} unknowns treated as non-critical (conservative)"), flush=True)
    rec = dict(kind="critical-census", stage=st.header(), k=a.k, wall=a.wall,
               critical=C, unknown=U, noncritical_count=len(res["noncritical"]), delta=delta,
               ratio=len(C) / st.n, common_neighbourhood=cands["common_neighbourhood"],
               candidates_eq_count=n_eq, candidates_ne_count=n_ne,
               candidates_eq=cands["candidates_eq"][:10000], candidates_ne=cands["candidates_ne"][:10000],
               colourings=res["colourings"], seconds=res["seconds"],
               claim_scope=f"every vertex of the stage asked once at {a.k} colours with a {a.wall}-s wall; a critical vertex is certified by its "
                           f"verified colouring; an UNSAT is solver-trusted and only enlarges the candidate sets; candidates are the pairs "
                           f"admitted by CriticalSet.lean's localization theorems (unknown vertices counted as non-critical)")
    out.write_text(json.dumps(rec, indent=1)); log(f"[critical] wrote {out}")
    return rec


# ----------------------------------------------------------------------------- the targeted asks

def pair_ask(n, edges, k, p, q, polarity: str, wall=None, shuffle_seed=None):
    """polarity 'eq': is there a proper k-colouring with c(p) ≠ c(q)? UNSAT ⟹ forced equal.
    polarity 'ne': with c(p) = c(q)? UNSAT ⟹ forced distinct (a virtual edge).
    `shuffle_seed` relabels the vertices (an independent formula for the second encoding)."""
    perm = list(range(n))
    if shuffle_seed is not None:
        random.Random(shuffle_seed).shuffle(perm)
    E = [(perm[u], perm[v]) for u, v in edges]
    P, Q = perm[p], perm[q]
    cl = colour_clauses(n, E, k)
    if polarity == "eq":
        for c in range(k):
            cl.append([-var(P, c, k), -var(Q, c, k)])
    else:
        for c in range(k):
            cl.append([-var(P, c, k), var(Q, c, k)]); cl.append([var(P, c, k), -var(Q, c, k)])
    pin = next(v for v in range(n) if v not in (P, Q)) if n > 2 else P
    cl.append([var(pin, 0, k)])
    st, model = sat(cl, wall=wall)
    if st == "sat":
        col = decode(model, n, k)
        inv = [0] * n
        for i, pi in enumerate(perm):
            inv[pi] = i
        col0 = [col[perm[v]] for v in range(n)]
        bad = verify_proper(col0, edges)
        assert bad is None, ("improper witness colouring", bad)
        ok = (col0[p] != col0[q]) if polarity == "eq" else (col0[p] == col0[q])
        assert ok, "the witness colouring does not violate the candidate"
        return "refuted", col0
    return ("HIT" if st == "unsat" else "unknown"), None


def cmd_ask(a):
    rec = json.loads(Path(a.critical).read_text())
    st = load_stage_from_header(rec["stage"], a)
    k = a.k
    eq, ne = [tuple(e) for e in rec["candidates_eq"]], [tuple(e) for e in rec["candidates_ne"]]
    if rec["candidates_eq_count"] > len(eq) or rec["candidates_ne_count"] > len(ne):
        print(f"[ask] the census file truncates its candidate lists ({rec['candidates_eq_count']}/{rec['candidates_ne_count']}); recomputing", flush=True)
        c = candidate_sets(st, rec["critical"], rec["unknown"]); eq, ne = c["candidates_eq"], c["candidates_ne"]
    print(f"[ask] {st.label()} k={k}: {len(eq)} forced-equal candidates, {len(ne)} virtual-edge candidates; wall {a.wall}s", flush=True)
    if a.max and (len(eq) + len(ne)) > a.max:
        print(f"[ask] more than --max {a.max} candidates: run `sweep` instead (the pruning bought nothing here)"); return
    hits, results = [], []
    t0 = time.time()
    for pol, cands in (("eq", eq), ("ne", ne)):
        for (p, q) in cands:
            v, col = pair_ask(st.n, st.edges, k, p, q, pol, wall=a.wall)
            r = dict(pair=[p, q], polarity=pol, verdict=v)
            if v == "HIT":
                v2, _ = pair_ask(st.n, st.edges, k, p, q, pol, wall=a.wall, shuffle_seed=12345)
                r["second_encoding"] = v2
                if st.pts is not None:
                    import mpmath as mp
                    r["distance"] = mp.nstr(abs(st.pts[p] - st.pts[q]), 30)
                hits.append(r)
                print(f"\n***** JACKPOT CANDIDATE — HALT AND VERIFY: pair {p},{q} {'forced EQUAL' if pol == 'eq' else 'forced DISTINCT'} "
                      f"at {k} colours on {st.label()}; second encoding: {v2}; distance {r.get('distance', '?')} *****\n", flush=True)
            results.append(r)
    summ = {pol: {vd: sum(1 for r in results if r["polarity"] == pol and r["verdict"] == vd) for vd in ("HIT", "refuted", "unknown")} for pol in ("eq", "ne")}
    print(f"[ask] {st.label()} k={k}: forced-equal {summ['eq']}, virtual-edge {summ['ne']} over {len(eq)}+{len(ne)} candidates [{time.time()-t0:.0f}s]", flush=True)
    out = Path(a.out) if a.out else DATA / f"ask-{st.name}.json"
    Path(out).write_text(json.dumps(dict(kind="targeted-asks", stage=st.header(), k=k, wall=a.wall, summary=summ, results=results,
                                          seconds=round(time.time() - t0, 1),
                                          claim_scope="one SAT ask per theorem-admitted candidate per polarity; HIT = UNSAT (solver-trusted, second encoding by vertex relabelling); "
                                                      "refuted = a verified separating/uniting colouring"), indent=1))
    print(f"[ask] wrote {out}")
    if hits:
        jp = DATA / f"jackpot-{st.name}.json"
        jp.write_text(json.dumps(dict(kind="jackpot-candidate", stage=st.header(), k=k, hits=hits), indent=1))
        print(f"[ask] JACKPOT file {jp}; exit {JACKPOT_EXIT}")
        sys.exit(JACKPOT_EXIT)


def load_stage_from_header(h: dict, a) -> Stage:
    """Rebuild the stage a census was taken on, and check the fingerprint."""
    src = h["source"]
    if src.startswith("witness "):
        path = src.split()[1]
        st, _, _, _ = rebuild_witness(path, int(src.split()[3]))
    elif src.startswith("planted"):
        st = planted_stage({"planted-K5-minus-edge": "k5e", "planted-K4-minus-edge": "k4e", "planted-K5": "k5", "planted-two-K5": "two-k5"}[h["name"]])
    elif src.startswith("tools/batchkill.Obj()"):
        class A: seed = True
        st = load_stage(A())
    elif src.startswith("graph "):
        class A: graph = src.split()[1]
        st = load_stage(A())
    elif src.startswith("descent object"):
        class A: object = src.split()[2]
        st = load_stage(A())
    else:
        raise SystemExit(f"cannot rebuild stage from source {src!r}")
    assert st.fingerprint() == h["fingerprint"], ("the rebuilt stage's fingerprint differs from the census's", st.fingerprint(), h["fingerprint"])
    return st


# ----------------------------------------------------------------------------- ν

def _nu_worker(n, edges, k, q):
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    w = WCNF()
    for cl in colour_clauses(n, edges, k):
        w.append(cl)
    w.append([var(0, 0, k)])
    for v in range(n):
        w.append([-var(v, k - 1, k)], weight=1)
    with RC2(w) as rc2:
        model = rc2.compute()
        q.put((rc2.cost, model))


def nu_of(n, edges, k, wall) -> dict:
    """ν = the fewest vertices wearing the spare colour k−1 in a proper k-colouring (RC2), or an
    upper bound from a plain colouring when the wall hits."""
    import multiprocessing as mpc
    q = mpc.Queue()
    pr = mpc.Process(target=_nu_worker, args=(n, edges, k, q)); pr.start(); pr.join(wall)
    if pr.is_alive():
        pr.terminate(); pr.join()
        st, model = sat(colour_clauses(n, edges, k) + [[var(0, 0, k)]])
        if st != "sat":
            return dict(nu=None, status="base-" + st)
        col = decode(model, n, k)
        ub = min(col.count(c) for c in range(k))
        return dict(nu=None, status="unknown", upper_bound=ub)
    cost, model = q.get()
    col = decode(model, n, k)
    assert verify_proper(col, edges) is None, "RC2's optimum is improper"
    spare = [v for v in range(n) if col[v] == k - 1]
    assert len(spare) == cost, (len(spare), cost)
    return dict(nu=cost, status="optimal", spare_class=spare)


def cmd_nu(a):
    st = load_stage(a)
    t0 = time.time()
    r = nu_of(st.n, st.edges, a.k, a.wall)
    print(f"[nu] {st.label()} k={a.k}: ν = {r.get('nu')} ({r['status']}"
          + (f", upper bound {r['upper_bound']}" if 'upper_bound' in r else "") + f") [{time.time()-t0:.0f}s]", flush=True)
    out = Path(a.out) if a.out else DATA / f"nu-{st.name}.json"
    DATA.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(dict(kind="nu", stage=st.header(), k=a.k, wall=a.wall, **r, seconds=round(time.time() - t0, 1),
                                   claim_scope="RC2 (pysat) minimum of the spare class over proper k-colourings; 'optimal' only when RC2 finished within the wall; "
                                               "the optimum's colouring verified proper"), indent=1))
    print(f"[nu] wrote {out}")


# ----------------------------------------------------------------------------- exact arithmetic: K(√m)

from copy_exact_field import K  # noqa: E402
from pool_field_restrict import sqrt_K, exact_points  # noqa: E402
from pool_field_census import k_inv  # noqa: E402


class KExt:
    """A + √m·B with A, B ∈ K = ℚ(√3, √11); m a class attribute (247 for the T20 witness)."""
    m = 247
    __slots__ = ("A", "B")

    def __init__(self, A: K, B: K | None = None):
        self.A = A; self.B = B if B is not None else K()

    def __add__(self, o): return type(self)(self.A + o.A, self.B + o.B)
    def __sub__(self, o): return type(self)(self.A - o.A, self.B - o.B)
    def __neg__(self): return type(self)(-self.A, -self.B)
    def __mul__(self, o):
        return type(self)(self.A * o.A + (self.B * o.B).scale(self.m), self.A * o.B + self.B * o.A)
    def scale(self, q): return type(self)(self.A.scale(q), self.B.scale(q))
    def is_zero(self): return self.A.is_zero() and self.B.is_zero()
    def __eq__(self, o): return self.A == o.A and self.B == o.B
    def __hash__(self): return hash((tuple(self.A.c), tuple(self.B.c), self.m))
    def inv(self):
        D = self.A * self.A - (self.B * self.B).scale(self.m)
        Di = k_inv(D)
        return type(self)(self.A * Di, -(self.B * Di))
    def mp(self):
        import mpmath as mp
        return self.A.mp() + mp.sqrt(self.m) * self.B.mp()
    def json(self): return [self.A.json(), self.B.json()]
    @classmethod
    def of_json(cls, j):
        return cls(K(*(Fr(n, d) for n, d in j[0])), K(*(Fr(n, d) for n, d in j[1])))
    @classmethod
    def of_K(cls, a: K): return cls(a, K())
    @classmethod
    def zero(cls): return cls(K(), K())
    @classmethod
    def one(cls): return cls(K(1), K())


def sqrt_KExt(x: KExt):
    """A root of x = a + b√m in K(√m), VERIFIED by squaring, or None. Tower criterion over K:
    b = 0: √a ∈ K, or a = m·s² (root s√m); b ≠ 0: a² − m b² = n² in K and (a ± n)/2 = u² ≠ 0 in K,
    root u + (b/2u)√m."""
    cls = type(x); m = x.m
    a, b = x.A, x.B
    if b.is_zero():
        s = sqrt_K(a)
        if s is not None:
            r = cls(s, K())
        else:
            s = sqrt_K(a.scale(Fr(1, m)))
            if s is None:
                return None
            r = cls(K(), s)
        assert r * r == x
        return r
    N = a * a - (b * b).scale(m)
    n = sqrt_K(N)
    if n is None:
        return None
    for nn in (n, -n):
        t = (a + nn).scale(Fr(1, 2))
        u = sqrt_K(t)
        if u is None or u.is_zero():
            continue
        w = b * k_inv(u.scale(2))
        r = cls(u, w)
        if r * r == x:
            return r
    return None


def split_radicand(rad: Fr):
    """√rad = kcoef·√m with m squarefree and coprime to 3·11 (whose roots live in K): returns (m, kcoef ∈ K)."""
    assert rad > 0
    num, den = rad.numerator, rad.denominator
    # √(num/den) = √(num·den)/den
    t = num * den
    m, sq = 1, 1
    p = 2
    while p * p <= t:
        e = 0
        while t % p == 0:
            t //= p; e += 1
        if e % 2 == 1:
            m *= p
        sq *= p ** (e // 2)
        p += 1
    if t > 1:
        m *= t
    kco = K(Fr(sq, den))
    for pr, idx in ((3, 1), (11, 2)):
        if m % pr == 0:
            m //= pr
            kco = kco * K(*([0] * idx + [1] + [0] * (3 - idx)))          # multiply by √pr
    return m, kco


def exact_witness(path: str, dps: int = 60, log=print) -> dict:
    """W's points exactly in K(√m), every unit edge and cross chord an exact identity; the near-miss
    list exactly non-unit."""
    import mpmath as mp
    st, pts, core, W = rebuild_witness(path, dps)
    obj_pts = exact_points(W["object"])
    q = Fr(W["distance_sq"]) if "distance_sq" in W else Fr(W["distance"]) ** 2
    rad = 4 * q - 1
    m, kco = split_radicand(rad)
    F = type(f"K{m}", (KExt,), {"m": m, "__slots__": ()})
    cosv = F.of_K(K(1 - Fr(1, 2) / q))
    sinv = F(K(), kco.scale(1 / (2 * q)))                # √rad/(2q) = kco√m/(2q)
    assert (cosv * cosv + sinv * sinv) == F.one(), "cos² + sin² ≠ 1 exactly"
    x0 = W["pair"][0]
    cx, cy = (F.of_K(obj_pts[x0][0]), F.of_K(obj_pts[x0][1]))
    X, Y = [], []
    for v in core:
        X.append(F.of_K(obj_pts[v][0])); Y.append(F.of_K(obj_pts[v][1]))
    for v in core:
        if v == x0:
            continue
        dx, dy = F.of_K(obj_pts[v][0]) - cx, F.of_K(obj_pts[v][1]) - cy
        X.append(cx + cosv * dx - sinv * dy); Y.append(cy + sinv * dx + cosv * dy)
    n = len(X); assert n == st.n
    # float agreement (a coarse check that the exact points ARE the rebuilt points)
    for i in range(n):
        z = mp.mpc(X[i].mp(), Y[i].mp())
        assert abs(z - pts[i]) < mp.mpf(10) ** -(dps - 12), ("exact/float mismatch", i)
    one = F.one()
    def d2(i, j):
        dx, dy = X[i] - X[j], Y[i] - Y[j]
        return dx * dx + dy * dy
    bad = [(i, j) for i, j in st.edges if d2(i, j) != one]
    m_core = len(core)
    cross = [(i, j) for i, j in st.edges if (i < m_core) != (j < m_core)]
    # near misses at 60 digits (|d − 1| < 1e-6, not unit): must be exactly non-unit
    near = []
    for i in range(n):
        for j in range(i + 1, n):
            d = abs(pts[i] - pts[j])
            if abs(d - 1) < mp.mpf(10) ** -6 and (i, j) not in st.adj_set():
                near.append((i, j))
    near_bad = [(i, j) for i, j in near if d2(i, j) == one]
    log(f"[exact] {st.label()}: {n} points in K(√{m}) ({m_core} core in K, {n - m_core} rotated); unit edges exact {len(st.edges) - len(bad)}/{len(st.edges)}"
        f"{' — FAILED ' + str(bad[:5]) if bad else ''}; cross chords {len(cross)} (all among the verified edges); near-misses exactly non-unit {len(near) - len(near_bad)}/{len(near)}")
    assert not bad and not near_bad, "an exact identity FAILED — refused"
    rec = dict(kind="exact-witness", witness=path, object=W["object"], stage=st.header(), field=f"Q(sqrt3, sqrt11, sqrt{m})", m=m,
               basis=f"A + sqrt({m})*B with A, B in K = Q(sqrt3, sqrt11) in the basis (1, sqrt3, sqrt11, sqrt33)",
               rotation=dict(cos=str(1 - Fr(1, 2) / q), sin_B_coeffs=kco.scale(1 / (2 * q)).json()),
               core_size=m_core, core_vertices=core, centre=x0, centre_index=core.index(x0),
               points=[[X[i].json(), Y[i].json()] for i in range(n)], edges=st.edges, cross_chords=cross,
               near_misses=near, unit_edges_exact=len(st.edges), dps=dps,
               claim_scope="every listed edge is (Δx)² + (Δy)² = 1 as an exact identity in K(√m); the near-miss pairs are exactly non-unit; "
                           "the edge list is the 60-digit census of the record")
    return rec


def _adj_set(self):
    return set(self.edges)
Stage.adj_set = _adj_set


def cmd_exact_witness(a):
    rec = exact_witness(a.witness, a.dps)
    DATA.mkdir(parents=True, exist_ok=True)
    out = Path(a.out) if a.out else DATA / f"witness-exact-{Path(a.witness).stem.replace('forced-spindle-', '')}.json"
    out.write_text(json.dumps(rec)); print(f"[exact] wrote {out}")


# ----------------------------------------------------------------------------- the cross lattice

_X: dict = {}


def _init_cross(points_json, m):
    F = type(f"K{m}", (KExt,), {"m": m, "__slots__": ()})
    _X["F"] = F
    _X["X"] = [F.of_json(p[0]) for p in points_json]
    _X["Y"] = [F.of_json(p[1]) for p in points_json]


def _glue_of_pairs(pairs):
    """For each pair (i, j) at distance < 2: r = 4/d² − 1 in F; if a square, the two glue points
    (exact), each verified at unit distance from both parents. Returns a list of records."""
    F, X, Y = _X["F"], _X["X"], _X["Y"]
    one, four = F.one(), F.of_K(K(4))
    half = Fr(1, 2)
    out = []
    for i, j in pairs:
        dx, dy = X[j] - X[i], Y[j] - Y[i]
        d2 = dx * dx + dy * dy
        r = four * d2.inv() - one
        s = sqrt_KExt(r)
        if s is None:
            out.append((i, j, None)); continue
        mx, my = (X[i] + X[j]).scale(half), (Y[i] + Y[j]).scale(half)
        # i·(q − p)/2 = (−Δy/2, Δx/2)
        px, py = (-dy).scale(half), dx.scale(half)
        pts = []
        for sg in (1, -1):
            gx = mx + (px * s).scale(sg); gy = my + (py * s).scale(sg)
            for k_ in (i, j):
                ex, ey = gx - X[k_], gy - Y[k_]
                assert ex * ex + ey * ey == one, ("glue point not at unit distance from its parent", i, j)
            pts.append((gx.json(), gy.json()))
        out.append((i, j, pts))
    return out


def cmd_cross_lattice(a):
    import mpmath as mp
    rec = json.loads(Path(a.exact).read_text())
    m = rec["m"]; mp.mp.dps = 40
    F = type(f"K{m}", (KExt,), {"m": m, "__slots__": ()})
    X = [F.of_json(p[0]) for p in rec["points"]]; Y = [F.of_json(p[1]) for p in rec["points"]]
    n = len(X); mc = rec["core_size"]
    Z = [mp.mpc(X[i].mp(), Y[i].mp()) for i in range(n)]
    t0 = time.time()
    cross_all = [(i, j) for i in range(mc) for j in range(mc, n)]
    cross = [(i, j) for i, j in cross_all if abs(Z[i] - Z[j]) < 2]
    same = [(i, j) for i in range(mc) for j in range(i + 1, mc) if abs(Z[i] - Z[j]) < 2 and (i, j) not in set(rec["edges"])]
    print(f"[cross] {rec['stage']['name']}: {len(cross)} cross pairs at d < 2 of {len(cross_all)}; {len(same)} same-side (core) pairs at d < 2 [{time.time()-t0:.0f}s]", flush=True)
    chunks = [cross[i::a.workers] for i in range(a.workers)]
    results = []
    with ProcessPoolExecutor(max_workers=a.workers, initializer=_init_cross, initargs=(rec["points"], m)) as ex:
        for res in ex.map(_glue_of_pairs, chunks):
            results.extend(res)
    infield = [(i, j, pts) for i, j, pts in results if pts is not None]
    print(f"[cross] in-F{m} glue points: {len(infield)} pairs of {len(cross)} ({100*len(infield)/max(1,len(cross)):.2f} %) [{time.time()-t0:.0f}s]", flush=True)
    # distinct points, parents, fusions
    pool: dict[tuple, dict] = {}
    for i, j, pts in infield:
        for gx, gy in pts:
            key = (json.dumps(gx), json.dumps(gy))
            e = pool.setdefault(key, dict(x=gx, y=gy, parents=set()))
            e["parents"].update((i, j))
    pool_list = list(pool.values())
    for e in pool_list:
        e["parents"] = sorted(e["parents"])
    wdeg = [len(e["parents"]) for e in pool_list]
    fus = sum(1 for d in wdeg if d >= 3)
    # pool–pool unit edges: 40-digit screen, exact confirm
    P = [mp.mpc(F.of_json(e["x"]).mp(), F.of_json(e["y"]).mp()) for e in pool_list]
    PX = [F.of_json(e["x"]) for e in pool_list]; PY = [F.of_json(e["y"]) for e in pool_list]
    one = F.one()
    pp_edges = []; pp_near = 0
    import numpy as np
    if pool_list:
        arr = np.array([[float(z.real), float(z.imag)] for z in P])
        from scipy.spatial import cKDTree
        tr = cKDTree(arr)
        for i, j in tr.query_pairs(1 + 1e-6):
            if abs(arr[i] - arr[j]).sum() == 0:
                continue
            d = abs(P[i] - P[j])
            if abs(d - 1) < mp.mpf(10) ** -25:
                dx, dy = PX[i] - PX[j], PY[i] - PY[j]
                if dx * dx + dy * dy == one:
                    pp_edges.append((min(i, j), max(i, j)))
                else:
                    pp_near += 1
            elif abs(d - 1) < 1e-6:
                pp_near += 1
    pdeg = [0] * len(pool_list)
    for i, j in pp_edges:
        pdeg[i] += 1; pdeg[j] += 1
    # same-side pairs: in-K, m-class, other (the core's own radicands)
    _init_cross(rec["points"], m)
    same_res = _glue_of_pairs(same) if a.same_side else []
    same_inK = same_m = 0
    for i, j, pts in same_res:
        if pts is None:
            continue
        if all(all(nn == 0 for nn, dd in p[0][1]) and all(nn == 0 for nn, dd in p[1][1]) for p in pts):
            same_inK += 1
        else:
            same_m += 1
    print(f"[cross] pool: {len(pool_list)} distinct points, W-degree histogram {sorted(set(wdeg))[:6]}… fusions (≥ 3 W-neighbours) {fus}, "
          f"pool–pool unit edges {len(pp_edges)} (near-misses rejected {pp_near}), max pool degree {max(pdeg) if pdeg else 0}; "
          f"same-side core pairs at d < 2: {len(same)} — in-K glue {same_inK}, √{m}-class glue {same_m}, other {len(same) - same_inK - same_m}"
          + ("" if a.same_side else " (same-side classification skipped)") + f" [{time.time()-t0:.0f}s]", flush=True)
    out = Path(a.out) if a.out else DATA / f"cross-lattice-{rec['stage']['name']}.json"
    DATA.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(dict(kind="cross-lattice", exact=a.exact, stage=rec["stage"], m=m,
                                   cross_pairs_total=len(cross_all), cross_pairs_lt2=len(cross), infield_pairs=len(infield),
                                   pool_points=len(pool_list), fusions=fus, w_degree_histogram={str(d): wdeg.count(d) for d in sorted(set(wdeg))},
                                   pool_edges=len(pp_edges), pool_near_rejected=pp_near, max_pool_degree=max(pdeg) if pdeg else 0,
                                   same_side_pairs=len(same), same_inK=same_inK, same_mclass=same_m,
                                   pool=[dict(x=e["x"], y=e["y"], parents=e["parents"]) for e in pool_list],
                                   pool_edge_list=pp_edges, seconds=round(time.time() - t0, 1),
                                   claim_scope=f"every cross pair (core, copy) at distance < 2 (40-digit screen) tested exactly for r = 4/d² − 1 square in K(√{m}); "
                                               f"glue points exact and re-verified at unit distance from both parents; pool–pool edges screened at 40 digits and confirmed exactly")))
    print(f"[cross] wrote {out}")


# ----------------------------------------------------------------------------- sweeps and the planted control

def find_hex_shell(st: Stage):
    """A vertex h with six neighbours forming a 6-cycle (a closed hexagonal shell); returns (h, ring)."""
    for h in range(st.n):
        N = sorted(st.adj[h])
        if len(N) < 6:
            continue
        # search a 6-cycle inside N
        Nset = set(N)
        def dfs(path):
            if len(path) == 6:
                return path if path[0] in st.adj[path[-1]] else None
            for w in st.adj[path[-1]]:
                if w in Nset and w not in path and (len(path) < 5 or True):
                    r = dfs(path + [w])
                    if r:
                        return r
            return None
        for s in N:
            ring = dfs([s])
            if ring:
                return h, ring
    return None


def cmd_planted_sweep(a):
    import rigidity, mpmath as mp
    st = load_stage(a)
    hs = find_hex_shell(st)
    assert hs, "no closed hexagonal shell in the stage"
    h, ring = hs
    d = lambda i, j: abs(st.pts[i] - st.pts[j])
    sq3 = [(ring[i], ring[(i + 2) % 6]) for i in range(6)]
    dia = [(ring[i], ring[i + 3]) for i in range(3)]
    for u, v in sq3:
        assert abs(d(u, v) - mp.sqrt(3)) < 1e-30, "ring pair not at √3"
    for u, v in dia:
        assert abs(d(u, v) - 2) < 1e-30, "ring pair not at 2"
    leave = [sq3[0], dia[1]]                              # (r0,r2) and (r1,r4): disjoint
    cheats = [e for e in sq3 + dia if e not in leave]
    E = st.edges + [(min(u, v), max(u, v)) for u, v in cheats]
    print(f"[sweep-control] {st.label()}: shell at {h}, ring {ring}; 7 cheats added, the two disjoint pairs {leave} left out — expect exactly them forced equal at 5", flush=True)
    t0 = time.time()
    # red first: all nine ⟹ K₇ ⟹ vacuous at 5
    R0 = rigidity.Rigidity(st.n, st.edges + [(min(u, v), max(u, v)) for u, v in sq3 + dia], 5, timeout=a.wall); R0.run()
    print(f"[sweep-control] with all nine pairs: status {R0.status} (must be vacuous)", flush=True)
    R = rigidity.Rigidity(st.n, E, 5, timeout=a.wall); R.run()
    rep = rigidity.report(R, st.label() + " + 7 shell cheats")
    want = sorted((min(u, v), max(u, v)) for u, v in leave)
    got = sorted(tuple(e) for e in R.eq_confirmed)
    ok = all(w in got for w in want) and R0.status == "vacuous" and R.status == "done"
    print(f"[sweep-control] planted {want} found: {all(w in got for w in want)}; other forced-equal {len(got) - sum(1 for w in want if w in got)}, "
          f"virtual edges {len(R.ne_confirmed)}; status {R.status}; {'ok' if ok else 'FAIL'} [{time.time()-t0:.0f}s]", flush=True)
    out = Path(a.out) if a.out else DATA / f"sweep-control-{st.name}.json"
    DATA.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(dict(kind="sweep-control", stage=st.header(), shell=dict(centre=h, ring=ring), cheats=cheats, planted=want, red_all_nine=R0.status,
                                   report=rep, ok=ok, seconds=round(time.time() - t0, 1)), indent=1))
    print(f"[sweep-control] wrote {out}")
    if not ok:
        sys.exit(1)


def cmd_sweep(a):
    import rigidity
    st = load_stage(a)
    t0 = time.time()
    print(f"[sweep] {st.label()} k={a.k}: the exhaustive Rigidity sweep, wall {a.wall}s per call", flush=True)
    R = rigidity.Rigidity(st.n, st.edges, a.k, timeout=a.wall); R.run()
    rep = rigidity.report(R, st.label())
    out = Path(a.out) if a.out else DATA / f"sweep-{st.name}.json"
    DATA.mkdir(parents=True, exist_ok=True)
    rep.update(kind="sweep", stage=st.header(), seconds=round(time.time() - t0, 1))
    out.write_text(json.dumps(rep, indent=1)); print(f"[sweep] wrote {out}")


# ----------------------------------------------------------------------------- self-test

def self_test():
    fails = []
    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        if not ok:
            fails.append(what)
    # K₅ − e at three colours: C = {2,3,4}; candidates exactly (0,1) both polarities; (0,1) forced equal at 4
    st = planted_stage("k5e")
    _init_worker(st.n, st.edges, 3, None)
    C = sorted(v for v in range(st.n) if _deletion_ask(v)[1] == "critical")
    expect(C, [2, 3, 4], "K5−e critical set at 3")
    c = candidate_sets(st, C)
    expect((c["candidates_eq"], c["candidates_ne"]), ([(0, 1)], [(0, 1)]), "K5−e candidates")
    expect(pair_ask(st.n, st.edges, 4, 0, 1, "eq")[0], "HIT", "K5−e (0,1) forced equal at 4")
    expect(pair_ask(st.n, st.edges, 4, 0, 1, "ne")[0], "refuted", "K5−e (0,1) not separated at 4")
    expect(pair_ask(st.n, st.edges, 4, 0, 1, "eq", shuffle_seed=7)[0], "HIT", "K5−e second encoding")
    # K₄ − e at two colours
    st = planted_stage("k4e"); _init_worker(st.n, st.edges, 2, None)
    C = sorted(v for v in range(st.n) if _deletion_ask(v)[1] == "critical")
    expect(C, [2, 3], "K4−e critical set at 2")
    expect(candidate_sets(st, C)["candidates_eq"], [(0, 1)], "K4−e forced-equal candidates")
    # brute-force agreement of candidate_sets on a random graph
    rnd = random.Random(3); n = 14
    E = [(i, j) for i in range(n) for j in range(i + 1, n) if rnd.random() < 0.35]
    st = Stage("rand", n, E, "planted"); Cr = rnd.sample(range(n), 4)
    c = candidate_sets(st, Cr)
    bf_eq = [(p, q) for p in range(n) for q in range(p + 1, n) if all(cc in st.adj[p] and cc in st.adj[q] for cc in Cr)]
    bf_ne = [(p, q) for p in range(n) for q in range(p + 1, n) if q not in st.adj[p] and all(cc in st.adj[p] or cc in st.adj[q] for cc in Cr)]
    expect((c["candidates_eq"], c["candidates_ne"]), (bf_eq, bf_ne), "candidate sets = brute force (random graph)")
    expect(candidate_sets(st, [])["candidates_eq"], [(p, q) for p in range(n) for q in range(p + 1, n)], "empty critical set admits every pair")
    # verify_proper catches a corrupted colouring
    expect(verify_proper([0, 0, 1], [(0, 1), (1, 2)]), (0, 1), "verify_proper red")
    # ν controls
    expect(nu_of(5, planted_stage("k5").edges, 5, 60)["nu"], 1, "ν(K5) at 5")
    expect(nu_of(10, planted_stage("two-k5").edges, 5, 60)["nu"], 2, "ν(K5 ⊔ K5) at 5")
    expect(nu_of(4, planted_stage("k4e").edges, 3, 60)["nu"], 1, "ν(K4−e) at 3")
    # KExt arithmetic against mpmath, inverse, and the square test
    import mpmath as mp
    mp.mp.dps = 40
    rnd = random.Random(5)
    def rk(): return K(*(Fr(rnd.randint(-9, 9), rnd.randint(1, 5)) for _ in range(4)))
    F = type("K247", (KExt,), {"m": 247, "__slots__": ()})
    ok_mul = ok_inv = ok_sq = ok_nsq = True
    for _ in range(20):
        x, y = F(rk(), rk()), F(rk(), rk())
        ok_mul &= abs((x * y).mp() - x.mp() * y.mp()) < mp.mpf(10) ** -30
        if not x.is_zero():
            ok_inv &= (x * x.inv()) == F.one()
        s = sqrt_KExt(x * x)
        ok_sq &= s is not None and (s == x or s == -x)
    expect(ok_mul, True, "KExt product agrees with mpmath"); expect(ok_inv, True, "KExt inverse")
    expect(ok_sq, True, "sqrt_KExt finds planted squares")
    expect(sqrt_KExt(F(K(2), K())) is None, True, "sqrt_KExt refuses 2 (not a square in K(√247))")
    expect(sqrt_KExt(F(K(0, 0, 0, 0), K(1))) is None, True, "sqrt_KExt refuses √247 itself")
    expect(sqrt_KExt(F(K(Fr(247)), K())) == F(K(), K(1)) or sqrt_KExt(F(K(Fr(247)), K())) == -F(K(), K(1)), True, "sqrt_KExt(247) = ±√247")
    expect(sqrt_KExt(F(K(3), K())) == F(K(0, 1), K()) or sqrt_KExt(F(K(3), K())) == -F(K(0, 1), K()), True, "sqrt_KExt(3) = ±√3 (in K)")
    expect(split_radicand(Fr(247, 9)), (247, K(Fr(1, 3))), "split_radicand 247/9")
    expect(split_radicand(Fr(253, 3)) == (23, K(0, 0, 0, Fr(1, 3))), True, "split_radicand 253/3 = (√33/3)·√23")
    # a moved point fails an exact identity (the parse-don't-validate red): unit vector (√3/2, 1/2) vs (√3/2, 1/2 + ε)
    a1, b1 = F.of_K(K(0, Fr(1, 2))), F.of_K(K(Fr(1, 2)))
    expect((a1 * a1 + b1 * b1) == F.one(), True, "exact unit identity (√3/2, 1/2)")
    b2 = F.of_K(K(Fr(1, 2) + Fr(1, 10 ** 12)))
    expect((a1 * a1 + b2 * b2) == F.one(), False, "moved point refused")
    print(f"self-test: {len(fails)} failure(s)" + (f" — {fails}" if fails else ""))
    sys.exit(1 if fails else 0)


# ----------------------------------------------------------------------------- CLI

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    def stage_args(p):
        p.add_argument("--seed", action="store_true"); p.add_argument("--object"); p.add_argument("--witness")
        p.add_argument("--graph"); p.add_argument("--planted"); p.add_argument("--dps", type=int, default=60)
    sub.add_parser("self-test")
    p = sub.add_parser("critical"); stage_args(p); p.add_argument("--k", type=int, default=4); p.add_argument("--workers", type=int, default=8)
    p.add_argument("--wall", type=float, default=600.0); p.add_argument("--out")
    p = sub.add_parser("ask"); p.add_argument("--critical", required=True); p.add_argument("--k", type=int, default=5)
    p.add_argument("--wall", type=float, default=600.0); p.add_argument("--max", type=int, default=20000); p.add_argument("--out")
    p = sub.add_parser("nu"); stage_args(p); p.add_argument("--k", type=int, default=5); p.add_argument("--wall", type=float, default=600.0); p.add_argument("--out")
    p = sub.add_parser("exact-witness"); p.add_argument("--witness", required=True); p.add_argument("--dps", type=int, default=60); p.add_argument("--out")
    p = sub.add_parser("cross-lattice"); p.add_argument("--exact", required=True); p.add_argument("--workers", type=int, default=8)
    p.add_argument("--same-side", action="store_true"); p.add_argument("--out")
    p = sub.add_parser("planted-sweep"); stage_args(p); p.add_argument("--wall", type=float, default=600.0); p.add_argument("--out")
    p = sub.add_parser("sweep"); stage_args(p); p.add_argument("--k", type=int, default=5); p.add_argument("--wall", type=float, default=600.0); p.add_argument("--out")
    a = ap.parse_args()
    if a.cmd == "self-test":
        self_test()
    elif a.cmd == "critical":
        cmd_critical(a)
    elif a.cmd == "ask":
        cmd_ask(a)
    elif a.cmd == "nu":
        cmd_nu(a)
    elif a.cmd == "exact-witness":
        cmd_exact_witness(a)
    elif a.cmd == "cross-lattice":
        cmd_cross_lattice(a)
    elif a.cmd == "planted-sweep":
        cmd_planted_sweep(a)
    elif a.cmd == "sweep":
        cmd_sweep(a)


if __name__ == "__main__":
    main()
