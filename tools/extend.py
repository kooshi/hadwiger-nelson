#!/usr/bin/env python3
"""The extension profile: which locally-legal 3-patterns of a pivot's cover set extend.

UNTRUSTED, like everything in `tools/`. A killed pattern here is *triage*; it becomes a
claim only through the kernel route (one LRAT certificate per pattern — the profile is
exactly the cube split `Fan.of_unsat` wants). A bug here can cost a theorem, never buy one.

## The statement this measures

At a 120°-pivot `p` with cover set `S = N(p) ∪ C`, the two-circle theorem
(`Proofs/HadwigerNelson/TwoCircle.lean`) makes `G[S]` 3-colourable always, and the
one-pivot cap (`Compulsion.lean`) proves no single pivot's system can force a 5th colour.
So `minCov(p) = 4` can only be an **extension obstruction** — every locally-legal
3-pattern on `G[S]` killed by ambient structure. The profile watches that at the finest
grain: enumerate the proper ≤3-colour patterns of `G[S]` (canonical up to colour
permutation, first-occurrence numbering), then one SAT call per pattern (base clauses
plus one unit per S-member; colour symmetry makes the single pinned representative
exact). Every reading is a SAT verdict — bias-free by construction, unlike pool
statistics (the M19 §0(b) lesson).

## The cap is mandatory

The pattern space of a sparse `G[S]` is 3^|S|-scale, and an uncapped enumeration
materialized ~79 GB and took down the desktop (M20 §0, 2026-08-04). Every enumeration
here demands a cap; hitting it refuses by name rather than profiling a partial space
that would read as a total one.

## Controls (`--self-test`, all watched failing where they should)

* the K2-clamp discriminating pair at k=3: two pinned vertices + an ambient edge whose
  ends see both — pattern [0,1] is killed, [0,0] survives (also exercises the k
  plumbing through the worker pool: Python 3.14's forkserver re-imports modules, so a
  mutated global k would silently misalign every pin);
* an empty-ambient graph: the profile is full;
* an improper pattern: refused unsat through the whole harness;
* canonical enumeration counts on a triangle (1) and an edgeless pair (2);
* the cap: a deliberately tiny cap refuses by name.

The strongest control needs a real build and stays a documented invocation, not a
self-test: the certified-confined pivot (de Grey's 397-point configuration, r²=4 class
at the origin, k=4) shows an empty profile — 1,000/1,000 sampled patterns killed.

    python3 tools/extend.py --self-test
    python3 tools/extend.py --profile --pivot 630
    python3 tools/extend.py --profile --pivot 630 --battery --reuse
    python3 tools/extend.py --clamps
    python3 tools/extend.py --tables        # the Strip.lean literals (kernel re-checks)
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
from collections import Counter
from concurrent.futures import ProcessPoolExecutor
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parent.parent
CADICAL = os.environ.get("CADICAL") or str(
    Path(subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True,
                        check=True, cwd=REPO).stdout.strip()) / "bin" / "cadical")
WORKDIR = REPO / "build"
R13 = Fraction(1, 3)
DEFAULT_K = 5
DEFAULT_CAP = 200_000

from coloring import base_clauses, var  # noqa: E402


# ------------------------------------------------------------------ pattern space

def induced(E, S):
    """`G[S]` in local indices `0..|S|-1` (S sorted)."""
    idx = {v: i for i, v in enumerate(S)}
    return sorted({(min(idx[a], idx[b]), max(idx[a], idx[b]))
                   for a, b in E if a in idx and b in idx})


def components(m, subedges):
    adj = [[] for _ in range(m)]
    for a, b in subedges:
        adj[a].append(b)
        adj[b].append(a)
    seen, comps = [False] * m, []
    for s in range(m):
        if seen[s]:
            continue
        stack, comp = [s], []
        seen[s] = True
        while stack:
            v = stack.pop()
            comp.append(v)
            for u in adj[v]:
                if not seen[u]:
                    seen[u] = True
                    stack.append(u)
        comps.append(sorted(comp))
    return comps


def enum_canonical(m, subedges, cap, count_only=False):
    """Proper <=3-colourings of the m-vertex graph, canonical (vertex v reuses a colour
    already used or mints the next fresh one — one representative per partition).

    `cap` is MANDATORY: the space is 3^m-scale on sparse graphs and an uncapped walk is
    the OOM that took down the desktop. Returns `(list_or_count, complete)`."""
    if cap is None or cap <= 0:
        raise ValueError("enum_canonical requires a positive cap — an uncapped "
                         "enumeration is 3^|S|-scale and has killed a machine")
    adj = [[] for _ in range(m)]
    for a, b in subedges:
        adj[a].append(b)
        adj[b].append(a)
    col = [-1] * m
    out: list = []
    n_found = 0
    complete = True

    def bt(v, used):
        nonlocal n_found, complete
        if v == m:
            n_found += 1
            if not count_only:
                out.append(tuple(col))
            if n_found >= cap:
                complete = False
                return False
            return True
        for c in range(min(used + 1, 3)):
            if all(col[u] != c for u in adj[v] if col[u] >= 0):
                col[v] = c
                ok = bt(v + 1, max(used, c + 1))
                col[v] = -1
                if not ok:
                    return False
        return True

    bt(0, 0)
    return (n_found if count_only else out), complete


def canon(tup):
    """First-occurrence canonical form of a colour tuple."""
    ren, nxt, out = {}, 0, []
    for c in tup:
        if c not in ren:
            ren[c] = nxt
            nxt += 1
        out.append(ren[c])
    return tuple(out)


# ------------------------------------------------------------------ SAT harness

_G = {}


def _init(base_str, nvars, nclauses, edges_check, k, workdir):
    _G["base"], _G["nv"], _G["ncl"] = base_str, nvars, nclauses
    _G["edges"], _G["k"] = edges_check, k
    _G["path"] = Path(workdir) / f"extend-w{os.getpid()}.cnf"


def _test(job):
    """One pattern -> ('sat'|'unsat'|'unknown'). A sat model is re-verified proper and
    on-pattern before it is believed. `k` arrives via `_init` — module globals do NOT
    reach pool workers (forkserver re-imports)."""
    i, pins, budget = job
    k = _G["k"]
    units = "".join(f"{var(v, c, k)} 0\n" for v, c in pins)
    with open(_G["path"], "w") as f:
        f.write(f"p cnf {_G['nv']} {_G['ncl'] + len(pins)}\n")
        f.write(_G["base"])
        f.write(units)
    try:
        r = subprocess.run([CADICAL, "-q", str(_G["path"])], capture_output=True,
                           text=True, timeout=budget)
    except subprocess.TimeoutExpired:
        return i, "unknown"
    if r.returncode == 20:
        return i, "unsat"
    if r.returncode != 10:
        return i, "unknown"
    pos = {int(x) for line in r.stdout.splitlines() if line.startswith("v ")
           for x in line[2:].split() if x != "0" and not x.startswith("-")}
    # a model may set several colour vars true per vertex (no at-most-one clause);
    # the deterministic min-colour reading is proper under ANY selection of true vars
    # (the edge clauses forbid shared colours per colour), and the pin check asserts
    # the pinned LITERAL, not the reading — the M19 balance.py multi-colour lesson
    colour = {}
    for x in sorted(pos):
        v, c = divmod(x - 1, k)
        colour.setdefault(v, c)
    assert all(colour[a] != colour[b] for a, b in _G["edges"]), \
        f"pattern {i}: model improper — encoding bug"
    assert all(var(v, c, k) in pos for v, c in pins), \
        f"pattern {i}: a pinned literal is false in the model — encoding bug"
    return i, "sat"


def profile(n, E, S, patterns, premarked, budget, jobs, tag, k=DEFAULT_K):
    """SAT-test every pattern not premarked realized. Returns the verdict list."""
    base = base_clauses(n, E, k)
    base_str = "".join(" ".join(map(str, c)) + " 0\n" for c in base)
    verdicts = ["sat(pool)" if i in premarked else None for i in range(len(patterns))]
    todo = [i for i in range(len(patterns)) if verdicts[i] is None]
    print(f"[{tag}] {len(patterns)} patterns, {len(premarked)} premarked, "
          f"{len(todo)} SAT calls", flush=True)
    t0 = time.time()
    jobs_iter = [(i, [(S[t], patterns[i][t]) for t in range(len(S))], budget)
                 for i in todo]
    done = 0
    with ProcessPoolExecutor(max_workers=jobs, initializer=_init,
                             initargs=(base_str, k * n, len(base), E, k,
                                       WORKDIR)) as ex:
        for i, st in ex.map(_test, jobs_iter, chunksize=4):
            verdicts[i] = st
            done += 1
            if done % 200 == 0:
                print(f"[{tag}]   {done}/{len(todo)} ({time.time() - t0:.0f}s)",
                      flush=True)
    print(f"[{tag}] done in {time.time() - t0:.0f}s: "
          f"{Counter(verdicts).most_common()}", flush=True)
    return verdicts


# ------------------------------------------------------------------ graph plumbing

def load_closure(name="Z3-closure-dg630x1/3"):
    from coverage import by_ledger_name, edges_digest
    t0 = time.time()
    rec, cfg = by_ledger_name(name)
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    E = cfg.edges()
    print(f"{name}: n={len(cfg)} edges={len(E)} sha={edges_digest(len(cfg), E)} "
          f"({time.time() - t0:.0f}s)", flush=True)
    return cfg, coords, E


def pivot_S(coords, denom, E, p):
    from coverage import class_of, cover_set
    Cls = class_of(coords, denom, p, R13)
    S = cover_set(E, p, Cls)
    nbr = sorted({b if a == p else a for a, b in E if p in (a, b)})
    return S, nbr, Cls


def premark_from_pool(pool_path, n, E, S, pat_index):
    """Free 'realized' marks from an existing colouring pool — the pool is re-verified
    against this graph's identity and every colouring re-checked proper first."""
    from coverage import edges_digest
    if not Path(pool_path).exists():
        return set()
    d = json.load(open(pool_path))
    if d["graph"]["edges_sha"] != edges_digest(n, E):
        print(f"pool {pool_path} is for a different graph — ignored", flush=True)
        return set()
    marked = set()
    for m in d["pool"]:
        assert all(m[a] != m[b] for a, b in E), "pool colouring improper — refuse"
        rest = tuple(m[v] for v in S)
        if len(set(rest)) <= 3:
            i = pat_index.get(canon(rest))
            if i is not None:
                marked.add(i)
    return marked


def rational_key(pt, denom):
    return tuple(Fraction(x, denom) for x in pt[0]) + \
        tuple(Fraction(y, denom) for y in pt[1])


def bulk_relocate(cfg_from, idxs, cfg_to):
    """Indices of cfg_from's points inside cfg_to, via one coordinate dictionary."""
    table = {rational_key(cfg_to.pts[i], cfg_to.denom): i for i in range(len(cfg_to))}
    return {i: table[rational_key(cfg_from.pts[i], cfg_from.denom)] for i in idxs}


# ------------------------------------------------------------------ the strip tables

def digit(n, i):
    return n // 3 ** i % 3


def strip_tables():
    """The 66 proper hexagon columns and 36 rainbow columns of the strip automaton —
    the literals `Proofs/HadwigerNelson/Strip.lean` carries. The kernel re-derives their
    completeness (the filter bridges), so drift fails the build, not this tool."""
    hexes = [n for n in range(729)
             if all(digit(n, (i + 1) % 6) != digit(n, i) for i in range(6))]
    rains = [n for n in range(729)
             if all(digit(n, (i + 2) % 6) != digit(n, i) for i in range(6))]
    return hexes, rains


# ------------------------------------------------------------------ modes

def run_profile(args):
    cfg, coords, E = load_closure()
    from coverage import edges_digest
    n, denom = len(coords), cfg.denom
    p = args.pivot
    S, nbr, Cls = pivot_S(coords, denom, E, p)
    sub = induced(E, S)
    print(f"pivot {p}: |N(p)|={len(nbr)} |C|={len(Cls)} |S|={len(S)}, "
          f"G[S] {len(sub)} edges, components "
          f"{[len(c) for c in components(len(S), sub)]}", flush=True)

    cnt, complete = enum_canonical(len(S), sub, cap=args.cap, count_only=True)
    if not complete:
        raise SystemExit(
            f"pattern space at pivot {p} is >= {cnt} (cap hit during the count); a "
            f"partial profile would read as a total one — refusing. Raise --cap or "
            f"choose a smaller-|S| pivot.")
    print(f"locally-legal <=3-patterns: {cnt}", flush=True)
    assert cnt > 0, "two-circle theorem violated by the enumerator — tool bug"

    patterns, _ = enum_canonical(len(S), sub, cap=args.cap)
    pat_index = {pat: i for i, pat in enumerate(patterns)}
    path = args.out or str(REPO / "build" / f"m20-profile-{p}.json")

    if args.reuse and Path(path).exists():
        d = json.load(open(path))
        assert d["graph"]["edges_sha"] == edges_digest(n, E) and d["pivot"] == p, \
            "artifact is for a different graph or pivot — refuse to reuse"
        assert [tuple(t) for t in d["patterns"]] == patterns, \
            "artifact pattern list differs from a fresh enumeration — refuse to reuse"
        verdicts, out = d["verdicts"], d
        print(f"baseline verdicts reused from {path}", flush=True)
    else:
        # negative control on the live graph: an improper pattern must refuse
        if sub:
            a, b = sub[0]
            bad = list(patterns[0])
            bad[b] = bad[a]
            basecl = base_clauses(n, E, DEFAULT_K)
            base_str = "".join(" ".join(map(str, c)) + " 0\n" for c in basecl)
            _init(base_str, DEFAULT_K * n, len(basecl), E, DEFAULT_K, WORKDIR)
            _, st = _test((0, [(S[t], bad[t]) for t in range(len(S))], args.budget))
            assert st == "unsat", f"improper pattern reported {st} — harness broken"
            print("negative control: improper pattern refused (unsat) OK", flush=True)
        marks = premark_from_pool(REPO / "build" / "m19-pool-z3closure.json",
                                  n, E, S, pat_index)
        verdicts = profile(n, E, S, patterns, marks, args.budget, args.jobs,
                           f"E0@{p}")
        out = {"graph": {"name": "Z3-closure-dg630x1/3", "n": n, "n_edges": len(E),
                         "edges_sha": edges_digest(n, E), "k": DEFAULT_K},
               "pivot": p, "S": S, "sub_edges": sub,
               "patterns": [list(t) for t in patterns], "verdicts": verdicts}
        Path(path).write_text(json.dumps(out))
        print(f"baseline profile written to {path}", flush=True)

    killed = sum(1 for v in verdicts if v == "unsat")
    unknown = sum(1 for v in verdicts if v == "unknown")
    print(f"profile: {len(patterns) - killed - unknown}/{len(patterns)} extend, "
          f"{killed} killed, {unknown} unknown", flush=True)

    if args.battery:
        run_battery(args, cfg, coords, E, p, S, nbr, Cls, sub, patterns, verdicts,
                    out, path)


def double_z3(cfg, q):
    """The ℤ/3 closure move at `q`: spindle twice at r²=1/3, first class member each
    time — exactly `rescan.interpret`'s 'double' (the M19 E-battery's E1/E1′)."""
    import construct as C
    from coverage import class_of, locate_key
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    t = class_of(coords, cfg.denom, q, R13)[0]
    cfg1 = C.spindle(cfg, q, t)
    q1 = locate_key(cfg1, cfg.pts[q], cfg.denom)
    coords1 = [(tuple(a), tuple(b)) for a, b in cfg1.pts]
    t1 = class_of(coords1, cfg1.denom, q1, R13)[0]
    return C.spindle(cfg1, q1, t1), q1


def run_battery(args, cfg, coords, E, p, S, nbr, Cls, sub, patterns, verdicts, out,
                path):
    import construct as C
    from coverage import class_of
    n, denom = len(coords), cfg.denom
    q_n = max(nbr, key=lambda q: len(class_of(coords, denom, q, R13)))
    q_c = Cls[0]
    extendable = [i for i, v in enumerate(verdicts) if v.startswith("sat")]
    gadgets = {}
    gadgets["E1"], _ = double_z3(cfg, q_n)
    gadgets["E1p"], _ = double_z3(cfg, q_c)
    t_unit = class_of(coords, denom, p, Fraction(1))[0]
    gadgets["E2"] = C.spindle(cfg, p, t_unit)
    out["battery"] = {}
    for tag, gcfg in gadgets.items():
        t0 = time.time()
        gE = gcfg.edges()
        print(f"[{tag}] n={len(gcfg)} edges={len(gE)} ({time.time() - t0:.0f}s)",
              flush=True)
        reloc = bulk_relocate(cfg, list(range(n)), gcfg)
        gS = sorted(reloc[v] for v in S)
        gsub = induced(gE, gS)
        back = {reloc[v]: v for v in S}
        gsub_orig = sorted(tuple(sorted((S.index(back[gS[a]]), S.index(back[gS[b]]))))
                           for a, b in gsub)
        assert gsub_orig == [tuple(x) for x in sub], \
            f"{tag}: G[S] changed under the gadget — relocation bug"
        gdump = {"tag": tag, "n": len(gcfg), "edges": gE, "gS": gS, "gp": reloc[p],
                 "old_image": sorted(reloc.values())}
        (REPO / "build" / f"m20-gadget-{tag}.json").write_text(json.dumps(gdump))
        perm = [gS.index(reloc[v]) for v in S]
        gpats = []
        for i in extendable:
            row = [0] * len(S)
            for t in range(len(S)):
                row[perm[t]] = patterns[i][t]
            gpats.append(tuple(row))
        gverd = profile(len(gcfg), gE, gS, gpats, set(), args.budget, args.jobs,
                        f"{tag}@{p}")
        killed_by = [extendable[r] for r, v in enumerate(gverd) if v == "unsat"]
        unk = [extendable[r] for r, v in enumerate(gverd) if v == "unknown"]
        print(f"[{tag}] kills {len(killed_by)}/{len(extendable)} "
              f"({len(unk)} unknown)", flush=True)
        out["battery"][tag] = {"n": len(gcfg), "edges": len(gE),
                               "tested": extendable, "killed": killed_by,
                               "unknown": unk}
        Path(path).write_text(json.dumps(out))
    print(f"profile (with battery) rewritten to {path}", flush=True)


def run_clamps(args):
    """The clamp census: which ambient vertices constrain many S-members at once —
    the only channel extension pressure can use. Reads the battery's gadget dumps."""
    cfg, coords, E = load_closure()
    n, denom = len(coords), cfg.denom
    p = args.pivot
    S, nbr, Cls = pivot_S(coords, denom, E, p)

    def comps_of(SS, EE):
        Sset = set(SS)
        adj = {v: [] for v in SS}
        for a, b in EE:
            if a in Sset and b in Sset:
                adj[a].append(b)
                adj[b].append(a)
        seen, comps = set(), []
        for s in SS:
            if s in seen:
                continue
            stack, comp = [s], []
            seen.add(s)
            while stack:
                v = stack.pop()
                comp.append(v)
                for u in adj[v]:
                    if u not in seen:
                        seen.add(u)
                        stack.append(u)
            comps.append(sorted(comp))
        return comps

    def census(tag, EE, SS, pp, comps, only=None):
        Sset = set(SS)
        comp_of = {}
        for ci, comp in enumerate(comps):
            for v in comp:
                comp_of[v] = ci
        hits = {}
        for a, b in EE:
            if a in Sset and b not in Sset and b != pp:
                hits.setdefault(b, []).append(a)
            elif b in Sset and a not in Sset and a != pp:
                hits.setdefault(a, []).append(b)
        pool = hits if only is None else {v: h for v, h in hits.items() if v in only}
        dist = Counter(len(h) for h in pool.values())
        multi = sum(1 for h in pool.values() if len({comp_of[u] for u in h}) >= 2)
        print(f"[{tag}] clamp |N(v) ∩ S| distribution: {dict(sorted(dist.items()))}")
        top = sorted(pool.items(), key=lambda kv: -len(kv[1]))[:8]
        print(f"[{tag}] top clamps: "
              f"{[(v, len(h), sorted({comp_of[u] for u in h})) for v, h in top]}")
        print(f"[{tag}] clamps coupling >=2 components: {multi} of {len(pool)}")

    comps = comps_of(S, E)
    print(f"pivot {p}: |S|={len(S)}, components {[len(c) for c in comps]}")
    census("E0", E, S, p, comps)

    sizes = []
    from coverage import class_of, cover_set
    for q in range(n):
        try:
            Sq = cover_set(E, q, class_of(coords, denom, q, R13))
            sizes.append((len(Sq), q))
        except ValueError:
            continue
    sizes.sort()
    print(f"\n{len(sizes)} pivots carry a 1/3 class; |S| range "
          f"{sizes[0][0]}..{sizes[-1][0]}, median {sizes[len(sizes) // 2][0]}; "
          f"representatives: min {sizes[0]}, median {sizes[len(sizes) // 2]}, "
          f"max {sizes[-1]}")
    print(f"|S| histogram: {dict(sorted(Counter(s for s, _ in sizes).items()))}")

    for tag in ("E1", "E1p", "E2"):
        pth = REPO / "build" / f"m20-gadget-{tag}.json"
        if not pth.exists():
            print(f"[{tag}] no dump at {pth} — run the battery first; skipped")
            continue
        d = json.load(open(pth))
        gE = [tuple(e) for e in d["edges"]]
        gS, gp = d["gS"], d["gp"]
        added = set(range(d["n"])) - set(d["old_image"])
        gcomps = comps_of(gS, gE)
        print(f"\n[{tag}] n={d['n']} (+{len(added)} added), components "
              f"{[len(c) for c in gcomps]}")
        census(f"{tag}/added-only", gE, gS, gp, gcomps, only=added)


# ------------------------------------------------------------------ self-test

def self_test():
    """Every reading driven to its trigger; every refusal watched refusing."""
    # canonical enumeration: a triangle has one <=3-pattern, an edgeless pair two
    pats, complete = enum_canonical(3, [(0, 1), (0, 2), (1, 2)], cap=100)
    assert complete and pats == [(0, 1, 2)], pats
    pats, complete = enum_canonical(2, [], cap=100)
    assert complete and sorted(pats) == [(0, 0), (0, 1)], pats

    # the cap refuses by name
    cnt, complete = enum_canonical(8, [], cap=5, count_only=True)
    assert not complete and cnt == 5
    try:
        enum_canonical(3, [], cap=None)
        raise SystemExit("SELF-TEST FAILED — a capless enumeration must be refused")
    except ValueError as ex:
        assert "cap" in str(ex)

    # the K2-clamp discriminating pair at k=3: S = {0,1} (no edge), ambient edge (2,3),
    # both ambient ends adjacent to both S members. Pattern [0,1] starves the ambient
    # edge (both ends forced to the single remaining colour): killed. [0,0] survives.
    n, E, S = 4, [(2, 3), (2, 0), (2, 1), (3, 0), (3, 1)], [0, 1]
    v_kill = profile(n, E, S, [(0, 1)], set(), 30.0, 2, "selftest-kill", k=3)
    assert v_kill == ["unsat"], f"kill control broken: {v_kill}"
    v_live = profile(n, E, S, [(0, 0)], set(), 30.0, 2, "selftest-live", k=3)
    assert v_live == ["sat"], f"live control broken: {v_live}"

    # empty ambient: the profile is full
    v_full = profile(2, [], [0, 1], [(0, 0), (0, 1)], set(), 30.0, 2,
                     "selftest-full", k=3)
    assert v_full == ["sat", "sat"], v_full

    # improper pattern refused through the harness
    basecl = base_clauses(3, [(0, 1)], 3)
    base_str = "".join(" ".join(map(str, c)) + " 0\n" for c in basecl)
    _init(base_str, 9, len(basecl), [(0, 1)], 3, WORKDIR)
    _, st = _test((0, [(0, 0), (1, 0)], 30.0))
    assert st == "unsat", f"improper pattern reported {st}"

    # the strip tables match Strip.lean's counts (the kernel re-checks the literals)
    hexes, rains = strip_tables()
    assert len(hexes) == 66 and len(rains) == 36
    assert hexes[0] == 91 and rains[-1] == 684

    print("extend.py self-test OK")


def print_tables():
    hexes, rains = strip_tables()
    print(f"-- hexTable ({len(hexes)}):")
    print(hexes)
    print(f"-- rainTable ({len(rains)}):")
    print(rains)


# ------------------------------------------------------------------ main

def main():
    ap = argparse.ArgumentParser(
        description=__doc__.splitlines()[0],
        epilog="The confined-pivot control (needs a real build, ~10 s): sample the "
               "known CONFINED pivot — de Grey's 397-point configuration, r²=4 at "
               "the origin, k=4 — and every tested pattern must be killed. See the "
               "M20 subplan §2.1 for the recorded run (1,000/1,000 killed).")
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--profile", action="store_true")
    ap.add_argument("--battery", action="store_true")
    ap.add_argument("--clamps", action="store_true")
    ap.add_argument("--tables", action="store_true")
    ap.add_argument("--pivot", type=int, default=630)
    ap.add_argument("--reuse", action="store_true")
    ap.add_argument("--budget", type=float, default=60.0)
    ap.add_argument("--jobs", type=int, default=28)
    ap.add_argument("--cap", type=int, default=DEFAULT_CAP)
    ap.add_argument("--out", default=None)
    args = ap.parse_args()

    if args.self_test:
        self_test()
    elif args.tables:
        print_tables()
    elif args.clamps:
        run_clamps(args)
    elif args.profile or args.battery:
        run_profile(args)
    else:
        ap.error("nothing to do — try --self-test, --profile, --clamps, or --tables")


if __name__ == "__main__":
    main()
