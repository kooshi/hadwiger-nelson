#!/usr/bin/env python3
"""Shrink a non-4-colourable unit-distance graph, using the refutation itself as the guide.

UNTRUSTED. Nothing here is believed: every graph this tool proposes is re-certified in Lean from
scratch -- the geometry against exact field arithmetic, the non-colourability against a fresh
certificate. A bug here can only cost a theorem, never buy a false one.

Two instruments, cheapest first:

  core   -- read a refutation and report which clauses it actually cited. Every clause the
            trimmed proof never touches is a clause the formula did not need, so the vertices
            whose clauses are all untouched can be deleted with no new solving at all. Free.

  strip  -- delta-debugging deletion passes: propose a vertex subset, ask CaDiCaL whether the
            induced subgraph is still unrefutable-free, keep the deletion if it is. Costs one
            solver call per proposal, and the proposals are independent, so it parallelises.

The property preserved is *not* "still 5-chromatic" but whatever UNSAT claim is handed in: for
M06's halves that is the pinned forcing claim (`vertex 14 -> colour 0`, `vertex 11 -> colour 1`
is impossible), which is what the final proof consumes.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parent.parent
CADICAL = os.environ.get("CADICAL") or str(
    Path(subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True,
                        check=True).stdout.strip()) / "bin" / "cadical")

from coloring import K, var, unvar, write_cnf, read_cnf as read_graph_cnf  # noqa: F401

# The clause order lives in `tools/coloring.py` and nowhere else: this tool, the emitter and the
# witness driver all address clauses by position, so a second copy of that convention is a bug
# waiting for someone to edit one of them.


# ------------------------------------------------------------------ the core instrument

def cited_originals(base_path: Path, lrat_path: Path) -> set[int]:
    """The 1-based ids of the *original* clauses the backward-trimmed refutation cites."""
    sys.path.insert(0, str(REPO / "tools"))
    from emit_mask import read_base, read_lrat, backward_trim  # noqa: E402

    nbase = len(read_base(base_path))
    cl, hn, ids = read_lrat(lrat_path)
    order = backward_trim(cl, hn, ids)
    used = set()
    for i in order:
        for h in hn[i]:
            a = abs(h)
            if a <= nbase:
                used.add(a)
    return used


def core_vertices(n: int, edges: list[tuple[int, int]], used: set[int]) -> set[int]:
    """The vertices a cited clause mentions. Everything else is deletable for free."""
    keep = set()
    for cid in used:
        if cid <= n:
            keep.add(cid - 1)
        elif cid <= n + K * len(edges):
            a, b = edges[(cid - n - 1) // K]
            keep.add(a)
            keep.add(b)
        # pin clauses: their vertices are named on the command line and always kept
    return keep


# ------------------------------------------------------------------ the solver

def refutes(n: int, edges: list[tuple[int, int]], pins: list[tuple[int, int]],
            timeout: float | None = None, conflicts: int | None = None) -> bool | None:
    """True if UNSAT, False if SAT, None if the solver gave up. None is never treated as UNSAT."""
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False) as t:
        cnf = Path(t.name)
    try:
        write_cnf(cnf, n, edges, pins)
        cmd = [CADICAL, "-q", str(cnf)]
        if conflicts is not None:
            cmd += [f"--conflicts={conflicts}"]
        try:
            rc = subprocess.run(cmd, capture_output=True, timeout=timeout).returncode
        except subprocess.TimeoutExpired:
            return None
        return {20: True, 10: False}.get(rc)
    finally:
        cnf.unlink(missing_ok=True)


def a_triangle(edges: list[tuple[int, int]]) -> tuple[int, int, int] | None:
    """Any three mutually adjacent vertices.

    Pinning one to colours 0,1,2 is free: colour names are arbitrary, so a graph has a proper
    4-colouring iff it has one giving a fixed triangle those three. It is *only* sound for the
    search -- the certified proof re-derives its own symmetry argument (`Sat/Forcing.lean`).
    """
    adj: dict[int, set[int]] = {}
    for a, b in edges:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    for a, b in edges:
        common = adj[a] & adj[b]
        if common:
            return a, b, min(common)
    return None


def cube_vertices(edges, pinned: set[int], depth: int) -> list[int]:
    """Cube coordinates: the highest-degree vertices outside the pinned set."""
    deg: dict[int, int] = {}
    for a, b in edges:
        deg[a] = deg.get(a, 0) + 1
        deg[b] = deg.get(b, 0) + 1
    return [v for v, _ in sorted(deg.items(), key=lambda kv: -kv[1]) if v not in pinned][:depth]


def _cube(job):
    m, e, p, timeout = job
    return refutes(m, e, p, timeout=timeout)


def refutes_cc(keep: set[int], edges, pins, jobs: int, depth: int,
               timeout: float | None) -> bool | None:
    """UNSAT by cube-and-conquer: pin a triangle, split on `depth` further vertices' colours.

    The monolithic instance does not terminate at de Grey's scale -- measured at M06 and again
    here -- so this is the only oracle that answers "is this graph still 5-chromatic" for a graph
    of that size. It aborts on the first satisfiable cube, which is what makes a *failed* deletion
    cheap and a successful one expensive.
    """
    from multiprocessing import Pool
    import itertools

    m, e, p, _ = compact(keep, edges, pins)
    # The triangle is free only if no colour has been named yet; an already-pinned instance has
    # spent its colour symmetry, and pinning again would refute a graph that is 4-colourable.
    tri = a_triangle(e) if not p else None
    base = list(p) + ([(tri[0], 0), (tri[1], 1), (tri[2], 2)] if tri else [])
    cv = cube_vertices(e, {v for v, _ in base}, depth)
    jobs_list = [(m, e, base + list(zip(cv, cs)), timeout)
                 for cs in itertools.product(range(K), repeat=len(cv))]
    gave_up = False
    with Pool(jobs) as pool:
        it = pool.imap_unordered(_cube, jobs_list, chunksize=1)
        for r in it:
            if r is False:
                pool.terminate()
                return False
            if r is None:
                gave_up = True
    return None if gave_up else True


def induced(edges: list[tuple[int, int]], keep: set[int]) -> list[tuple[int, int]]:
    return [(a, b) for (a, b) in edges if a in keep and b in keep]


def compact(keep: set[int], edges: list[tuple[int, int]], pins: list[tuple[int, int]]):
    """Renumber a vertex subset to 0..m-1. The solver pays for every variable it is handed."""
    order = sorted(keep)
    ix = {v: i for i, v in enumerate(order)}
    return (len(order), [(ix[a], ix[b]) for (a, b) in induced(edges, keep)],
            [(ix[v], c) for (v, c) in pins], order)


def still_forced(keep: set[int], edges, pins, timeout: float | None,
                 wlog_triangle: bool = False) -> bool:
    """Does the induced subgraph still refute? A solver that gives up counts as *not* refuting.

    `wlog_triangle` names a triangle's three colours, which is free on an instance that has not
    already spent its colour symmetry -- and is worth a measured 10x on a monolithic refutation,
    so it is the difference between a deletion sweep costing minutes and costing a day.
    """
    m, e, p, _ = compact(keep, edges, pins)
    if wlog_triangle and not p:
        tri = a_triangle(e)
        if tri:
            p = [(tri[0], 0), (tri[1], 1), (tri[2], 2)]
    return refutes(m, e, p, timeout=timeout) is True


# ------------------------------------------------------------------ commands

def cmd_core(args) -> None:
    n, edges, pins = read_graph_cnf(Path(args.cnf))
    used = cited_originals(Path(args.cnf), Path(args.lrat))
    keep = core_vertices(n, edges, used) | {v for v, _ in pins}
    live = {v for e in edges for v in e} | {v for v, _ in pins}
    ekeep = induced(edges, keep)
    print(f"formula        {n} vertices ({len(live)} in the half), {len(edges)} edges, "
          f"{len(pins)} pins")
    print(f"cited clauses  {len(used)} of {n + K * len(edges)}")
    print(f"core vertices  {len(keep)}   ({len(live) - len(keep)} deletable for free)")
    print(f"induced edges  {len(ekeep)}  (was {len(edges)})")
    if args.out:
        json.dump({"n": n, "keep": sorted(keep), "edges": ekeep,
                   "pins": [list(p) for p in pins]}, open(args.out, "w"))
        print(f"wrote          {args.out}")


_JOB = {}


def _init(keep, edges, pins, timeout, tri) -> None:
    # Python 3.14 no longer forks by default, so the workers get their state explicitly.
    _JOB.update(keep=keep, edges=edges, pins=pins, timeout=timeout, tri=tri)


def _probe(v: int) -> tuple[int, bool]:
    j = _JOB
    return v, still_forced(j["keep"] - {v}, j["edges"], j["pins"], j["timeout"], j["tri"])


def cmd_probe(args) -> None:
    """One full single-deletion sweep: for every vertex, does the refutation survive without it?

    Every probe is independent, so this is the embarrassingly-parallel half of shrinking, and it
    answers the milestone's opening question -- whether the witness is already minimal -- in one
    pass rather than by a greedy walk whose length nobody can predict.
    """
    from multiprocessing import Pool

    n, edges, pins = read_graph_cnf(Path(args.cnf))
    live = sorted({v for e in edges for v in e} | {v for v, _ in pins})
    pinned = {v for v, _ in pins}
    keep = set(live)
    base = still_forced(keep, edges, pins, args.timeout, args.triangle)
    print(f"baseline       {len(live)} vertices, {len(induced(edges, keep))} edges, "
          f"refutes={base}", flush=True)
    if not base:
        sys.exit("the handed-in formula does not refute; nothing to shrink")

    cands = [v for v in live if v not in pinned]
    got = []
    with Pool(args.jobs, initializer=_init,
              initargs=(keep, edges, pins, args.timeout, args.triangle)) as pool:
        for i, (v, ok) in enumerate(pool.imap_unordered(_probe, cands, chunksize=1), 1):
            if ok:
                got.append(v)
            if i % 50 == 0 or i == len(cands):
                print(f"  probed {i}/{len(cands)}  deletable so far {len(got)}", flush=True)
    print(f"deletable      {len(got)} of {len(cands)} singly-deletable vertices")
    if args.out:
        json.dump({"live": live, "pins": [list(p) for p in pins], "deletable": sorted(got)},
                  open(args.out, "w"))
        print(f"wrote          {args.out}")


def cmd_strip(args) -> None:
    """Greedy vertex-deletion search: sweep, apply what survives, repeat until a sweep is empty.

    The sweep is parallel and the application is sequential, because deletions interact -- two
    vertices each individually removable need not be removable together. Applying one at a time
    with a re-check after each is the only composition that stays sound, and it is cheap precisely
    because a sweep rarely returns many.
    """
    from multiprocessing import Pool

    n, edges, pins = read_graph_cnf(Path(args.cnf))
    pinned = {v for v, _ in pins}
    keep = {v for e in edges for v in e} | pinned
    if not still_forced(keep, edges, pins, args.timeout, args.triangle):
        sys.exit("the handed-in formula does not refute; nothing to shrink")
    print(f"start          {len(keep)} vertices, {len(induced(edges, keep))} edges", flush=True)

    for rnd in range(1, args.rounds + 1):
        cands = sorted(keep - pinned)
        got = []
        with Pool(args.jobs, initializer=_init,
                  initargs=(set(keep), edges, pins, args.timeout, args.triangle)) as pool:
            for v, ok in pool.imap_unordered(_probe, cands, chunksize=1):
                if ok:
                    got.append(v)
        applied = 0
        for v in got:
            if still_forced(keep - {v}, edges, pins, args.timeout, args.triangle):
                keep.discard(v)
                applied += 1
        print(f"round {rnd:>3}      swept {len(cands)}, deletable {len(got)}, applied {applied}"
              f"  ->  {len(keep)} vertices, {len(induced(edges, keep))} edges", flush=True)
        if args.out:
            json.dump({"keep": sorted(keep), "edges": induced(edges, keep),
                       "pins": [list(p) for p in pins]}, open(args.out, "w"))
        if applied == 0:
            print("fixed point     no single vertex can be removed")
            break


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    sub = ap.add_subparsers(dest="cmd", required=True)
    c = sub.add_parser("core", help="which vertices the existing refutation actually used")
    c.add_argument("cnf")
    c.add_argument("lrat")
    c.add_argument("--out")
    c.set_defaults(fn=cmd_core)
    p = sub.add_parser("probe", help="single-deletion sweep: which vertices are individually free")
    p.add_argument("cnf")
    p.add_argument("--jobs", type=int, default=28)
    p.add_argument("--timeout", type=float, default=600.0)
    p.add_argument("--out")
    p.add_argument("--triangle", action="store_true",
                   help="name a triangle's colours (free unless the instance is already pinned)")
    p.set_defaults(fn=cmd_probe)
    s = sub.add_parser("strip", help="iterate the sweep to a fixed point")
    s.add_argument("cnf")
    s.add_argument("--jobs", type=int, default=20)
    s.add_argument("--timeout", type=float, default=600.0)
    s.add_argument("--rounds", type=int, default=100)
    s.add_argument("--out")
    s.add_argument("--triangle", action="store_true",
                   help="name a triangle's colours (free unless the instance is already pinned)")
    s.set_defaults(fn=cmd_strip)
    args = ap.parse_args()
    args.fn(args)


if __name__ == "__main__":
    main()
