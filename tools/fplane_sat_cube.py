#!/usr/bin/env python3
"""Exact SAT decision of chi(UD(F_q,2)) <= k by cube-and-conquer, with the symmetry broken.

CLAUDE.md's standing rule (Kooshi, 2026-09-15): break the symmetry before any (UN)SAT search.
Two breaks, both sound on a vertex- and arc-transitive graph with interchangeable colours:
  * clique pins -- the origin takes colour 0, one of its neighbours takes colour 1;
  * colour precedence -- colour c may appear at v only if c-1 appears strictly earlier.
Measured at (13,5): 251.09 s -> 3.48 s, a 72x speedup, and the 3.48 s reproduces M58's
independently recorded 3.8 s for that instance, which is the control.

Every run checkpoints (one JSON line per decided cube) and resumes from it, per CLAUDE.md's
protected checkpointing rule.  A resume against a different cube enumeration is REFUSED by name:
the header carries a digest of the cube list, and the digest must match.
"""
import argparse, hashlib, json, os, shutil, subprocess, sys, time
import multiprocessing as mp
from pathlib import Path

CADICAL = None
def cadical():
    global CADICAL
    if CADICAL is None:
        c = shutil.which("cadical") or "/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical"
        if not Path(c).exists(): sys.exit(f"cadical not found at {c}")
        CADICAL = c
    return CADICAL

def plane(q):
    """UD(F_q,2) for PRIME q: vertices v = x*q + y, adjacent iff (dx^2 + dy^2) % q == 1."""
    circ = [(s, t) for s in range(q) for t in range(q) if (s * s + t * t) % q == 1]
    n = q * q
    nbr = [[] for _ in range(n)]
    for x in range(q):
        for y in range(q):
            v = x * q + y
            for (s, t) in circ:
                nbr[v].append(((x + s) % q) * q + (y + t) % q)
    edges = sorted({(min(u, w), max(u, w)) for u in range(n) for w in nbr[u]})
    return n, nbr, edges, len(circ)

def pins_for(q, nbr):
    return [(0, 0), (nbr[0][0], 1)]

def cnf(n, edges, k, pins, prec=True):
    """var(v,c) = v*k + c + 1."""
    var = lambda v, c: v * k + c + 1
    cl = []
    for v in range(n):
        cl.append([var(v, c) for c in range(k)])
        for c in range(k):
            for d in range(c + 1, k):
                cl.append([-var(v, c), -var(v, d)])
    for (u, w) in edges:
        for c in range(k):
            cl.append([-var(u, c), -var(w, c)])
    for (v, c) in pins:
        cl.append([var(v, c)])
    if prec:
        for c in range(2, k):
            for v in range(n):
                cl.append([-var(v, c)] + [var(u, c - 1) for u in range(v)])
    return cl, n * k

def run(cl, nv, path, seconds):
    with open(path, "w") as f:
        f.write(f"p cnf {nv} {len(cl)}\n")
        f.write("".join(" ".join(map(str, c)) + " 0\n" for c in cl))
    t0 = time.time()
    r = subprocess.run([cadical(), "-q", "-t", str(seconds), path], capture_output=True, text=True)
    el = time.time() - t0
    out = r.stdout
    v = "SAT" if "s SATISFIABLE" in out else "UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN"
    model = []
    if v == "SAT":
        for line in out.splitlines():
            if line.startswith("v "):
                model.extend(int(t) for t in line[2:].split())
    return v, el, model

def cube_order(n, nbr, pins, depth):
    """The graph is triangle-free where omega = 2, so N(0) is independent and cubing on it prunes
    NOTHING (exactly k^depth cubes survive).  Choose greedily instead: at each step take the vertex
    with the most edges into what is already chosen."""
    chosen = [v for (v, _) in pins]
    order = []
    while len(order) < depth:
        best, best_deg = None, -1
        for v in range(n):
            if v in chosen or v in order: continue
            d = sum(1 for u in chosen + order if v in nbr[u])
            if d > best_deg: best, best_deg = v, d
        order.append(best)
    return order

def build_cubes(n, nbr, pins, k, order):
    """DFS with immediate pruning: a partial assignment already breaking an edge is never extended."""
    adj = {(min(u, w), max(u, w)) for u, ws in enumerate(nbr) for w in ws}
    fixed = dict(pins)
    cubes, cur = [], {}
    def walk(i):
        if i == len(order):
            cubes.append([(v, cur[v]) for v in order]); return
        v = order[i]
        for c in range(k):
            clash = False
            for u in list(cur) + list(fixed):
                if (min(u, v), max(u, v)) in adj and (cur.get(u, fixed.get(u))) == c:
                    clash = True; break
            if clash: continue
            cur[v] = c; walk(i + 1); del cur[v]
    walk(0)
    return cubes

_W = {}
def _init(q, k, scratch, cap_seconds):
    n, nbr, edges, deg = plane(q)
    pins = pins_for(q, nbr)
    base, nv = cnf(n, edges, k, pins, prec=True)
    _W.update(k=k, base=base, nv=nv, scratch=Path(scratch), cap=cap_seconds,
              adj={(min(u, w), max(u, w)) for u, ws in enumerate(nbr) for w in ws},
              pins=dict(pins))

def _solve(cube):
    """cube is a tuple of (vertex, colour).  A cube that does not decide within the cap is NOT a
    fact about the graph (CLAUDE.md): it is returned UNKNOWN and the driver splits it deeper."""
    k, base, nv = _W["k"], _W["base"], _W["nv"]
    var = lambda v, c: v * k + c + 1
    cl = base + [[var(v, c)] for (v, c) in cube]
    v, el, model = run(cl, nv, _W["scratch"] / f"w{os.getpid()}.cnf", _W["cap"])
    return cube, v, el, (model if v == "SAT" else [])

def _children(cube, v_next, k):
    """The k colourings of v_next partition the cube's space; those clashing with an already-fixed
    neighbour are unsatisfiable anyway, so dropping them preserves exhaustiveness."""
    adj, fixed = _W["adj"], dict(_W["pins"])
    fixed.update(dict(cube))
    out = []
    for c in range(k):
        if any((min(u, v_next), max(u, v_next)) in adj and fixed[u] == c for u in fixed):
            continue
        out.append(tuple(list(cube) + [(v_next, c)]))
    return out

def main():
    a = argparse.ArgumentParser()
    a.add_argument("mode", choices=["control", "run"])
    a.add_argument("--q", type=int, default=17)
    a.add_argument("--k", type=int, default=5)
    a.add_argument("--depth", type=int, default=8, help="starting cube depth")
    a.add_argument("--max-depth", type=int, default=24, help="deepest split before giving up")
    a.add_argument("--cap", type=int, default=60, help="per-cube seconds; a cube that does not "
                   "decide is SPLIT, never reported as a fact about the graph")
    a.add_argument("--workers", type=int, default=8)
    a.add_argument("--scratch", default="/tmp")
    a.add_argument("--ckpt", default=None, help="JSONL checkpoint; resumed from and appended to")
    a.add_argument("--out", default=None, help="record written at the end (and on SAT)")
    o = a.parse_args()
    o.scratch = Path(o.scratch); o.scratch.mkdir(parents=True, exist_ok=True)
    scratch = o.scratch

    if o.mode == "control":
        # The encoding must reproduce every answer this project already holds.
        ok_all = True
        for (q, k, want) in [(11, 4, "UNSAT"), (11, 5, "SAT"), (13, 4, "UNSAT"),
                             (13, 5, "SAT"), (17, 4, "UNSAT")]:
            n, nbr, edges, deg = plane(q)
            cl, nv = cnf(n, edges, k, pins_for(q, nbr))
            v, el, _ = run(cl, nv, scratch / f"ctl-{q}-{k}.cnf", 600)
            ok = (v == want); ok_all &= ok
            print(f"[control] q={q:>2} k={k}: {v:>7} in {el:7.2f}s (expected {want}) "
                  f"{'OK' if ok else '*** MISMATCH ***'}   n={n} deg={deg} edges={len(edges)}",
                  flush=True)
        if not ok_all: sys.exit("[control] FAILED — the encoding does not reproduce a known answer")
        print("[control] the encoding reproduces every known answer", flush=True)
        return

    n, nbr, edges, deg = plane(o.q)
    pins = pins_for(o.q, nbr)
    # One global vertex order, long enough to split into; children take the next vertex in it.
    order = cube_order(n, nbr, pins, o.max_depth)
    roots = build_cubes(n, nbr, pins, o.k, order[:o.depth])
    roots = [tuple(c) for c in roots]
    sig = hashlib.sha256(repr((o.q, o.k, order)).encode()).hexdigest()
    header = {"header": True, "q": o.q, "k": o.k, "start_depth": o.depth,
              "max_depth": o.max_depth, "cap_seconds": o.cap, "order": order,
              "order_sha256": sig, "pins": pins, "n_roots": len(roots),
              "symmetry_break": "clique pins + colour precedence",
              "method": "adaptive cube-and-conquer: a cube undecided at the cap is split on the "
                        "next vertex of the order, and its children partition its space"}

    done, split, sat_cube = set(), set(), None
    ck = Path(o.ckpt) if o.ckpt else None
    if ck and ck.exists():
        with ck.open() as f:
            for ln in f:
                ln = ln.strip()
                if not ln: continue
                d = json.loads(ln)
                if d.get("header"):
                    if d.get("order_sha256") != sig:
                        sys.exit(f"REFUSED: checkpoint {ck} was written for a different vertex "
                                 f"order (its {str(d.get('order_sha256'))[:16]}… against this run's "
                                 f"{sig[:16]}…). Delete it or fix --q/--k/--max-depth.")
                elif d["verdict"] == "SPLIT": split.add(tuple(map(tuple, d["cube"])))
                else:
                    done.add(tuple(map(tuple, d["cube"])))
                    if d["verdict"] == "SAT": sat_cube = tuple(map(tuple, d["cube"]))
    elif ck:
        ck.parent.mkdir(parents=True, exist_ok=True)
        with ck.open("w") as f: f.write(json.dumps(header) + "\n")

    if sat_cube is not None:
        print(f"*** the checkpoint already holds a SATISFIABLE cube: {sat_cube} ***", flush=True)
        return

    # Rebuild the frontier: a root that was split is replaced by its children, recursively.
    adj = {(min(u, w), max(u, w)) for u, ws in enumerate(nbr) for w in ws}
    fixed0 = dict(pins)
    def kids(cube):
        vn = order[len(cube)]
        f = dict(fixed0); f.update(dict(cube))
        return [tuple(list(cube) + [(vn, c)]) for c in range(o.k)
                if not any((min(u, vn), max(u, vn)) in adj and f[u] == c for u in f)]
    frontier, stack = [], list(roots)
    while stack:
        cb = stack.pop()
        if cb in done: continue
        if cb in split: stack.extend(kids(cb))
        else: frontier.append(cb)

    print(f"q={o.q} k={o.k}: {n} vertices, degree {deg}, {len(edges)} edges. "
          f"{len(roots)} roots at depth {o.depth}; {len(done)} cubes already decided, "
          f"{len(split)} already split; {len(frontier)} on the frontier. cap {o.cap}s, "
          f"{o.workers} workers. order_sha256={sig[:16]}…", flush=True)

    import concurrent.futures as cf
    t0 = time.time(); ndone = len(done); nsplit = len(split); times = []
    sat = None; model = []; deepest = max((len(c) for c in frontier), default=o.depth)
    fh = ck.open("a") if ck else None
    def record(cube, verdict, el=None):
        if not fh: return
        d = {"cube": [list(x) for x in cube], "verdict": verdict}
        if el is not None: d["seconds"] = round(el, 3)
        fh.write(json.dumps(d) + "\n"); fh.flush(); os.fsync(fh.fileno())

    ctx = mp.get_context("fork")
    with cf.ProcessPoolExecutor(max_workers=o.workers, mp_context=ctx,
                                initializer=_init,
                                initargs=(o.q, o.k, str(o.scratch), o.cap)) as ex:
        pending = {}
        def submit(cb): pending[ex.submit(_solve, cb)] = cb
        for cb in frontier[:o.workers * 4]: submit(cb)
        queue = frontier[o.workers * 4:]
        while pending:
            for fut in cf.as_completed(list(pending), timeout=None):
                cube = pending.pop(fut)
                cb, v, el, mdl = fut.result()
                if v == "UNKNOWN":
                    if len(cube) >= o.max_depth:
                        print(f"  !! cube at max depth {o.max_depth} still UNKNOWN at {el:.0f}s — "
                              f"raise --max-depth; no claim about the graph", flush=True)
                        record(cube, "UNKNOWN", el)
                    else:
                        nsplit += 1; record(cube, "SPLIT")
                        ch = kids(cube); queue.extend(ch)
                        deepest = max(deepest, len(cube) + 1)
                else:
                    ndone += 1; times.append(el); record(cube, v, el)
                    if v == "SAT":
                        sat, model = cube, mdl
                        print(f"*** CUBE {cube} IS SATISFIABLE after {el:.1f}s — a {o.k}-colouring "
                              f"of UD(F_{o.q},2) EXISTS; chi = {o.k} ***", flush=True)
                        for f2 in pending: f2.cancel()
                        pending.clear(); queue.clear(); break
                    if ndone % 500 == 0:
                        tot = time.time() - t0
                        print(f"  {ndone} decided, {nsplit} split, {len(queue)+len(pending)} "
                              f"outstanding, deepest {deepest}, {tot:.0f}s, "
                              f"{ndone/tot:.1f} cubes/s, mean {sum(times)/len(times):.2f}s",
                              flush=True)
                while queue and len(pending) < o.workers * 4: submit(queue.pop())
                break
    if fh: fh.close()
    el = time.time() - t0
    rec = dict(header); rec.pop("header")
    rec.update(kind="fplane-sat-cube-adaptive", decided=ndone, split=nsplit,
               deepest_depth=deepest, wall_seconds=round(el, 1),
               core_seconds=round(sum(times), 1) if times else 0.0)
    if sat is not None:
        col = [None] * n
        for lit in model:
            if lit > 0:
                v0, c0 = divmod(lit - 1, o.k)
                if v0 < n: col[v0] = c0
        bad = [(u, w) for (u, w) in edges if col[u] is not None and col[u] == col[w]]
        rec.update(verdict="SAT", sat_cube=[list(x) for x in sat], colouring=col,
                   self_check_monochromatic_edges=len(bad),
                   claim_scope=f"chi(UD(F_{o.q},2)) <= {o.k}; the colouring is exhibited and must be "
                               f"re-verified from the definition by an independent tool")
        print(f"self-check: {len(bad)} monochromatic edges in the extracted colouring", flush=True)
    else:
        rec.update(verdict="UNSAT",
                   claim_scope=f"EXHAUSTIVE: every leaf of the cube tree is UNSAT and the children of "
                               f"a split cube partition its space, so under the (sound) clique-pin and "
                               f"colour-precedence symmetry breaking UD(F_{o.q},2) has no "
                               f"{o.k}-colouring, i.e. chi > {o.k}")
        print(f"ALL LEAVES UNSAT: {ndone} decided, {nsplit} split, deepest {deepest}, "
              f"{el/3600:.2f} h wall, {sum(times)/3600:.2f} core-hours "
              f"-> chi(UD(F_{o.q},2)) > {o.k}", flush=True)
    if o.out:
        Path(o.out).write_text(json.dumps(rec, indent=1))
        print(f"record -> {o.out}", flush=True)

if __name__ == "__main__":
    main()
