#!/usr/bin/env python3
"""m62_run — the parallel pattern-preserving descent (M62 §R8).

The engine this project owns, rather than the record-holder's. Theorem B says both halves are
4-colourable, so the fifth colour is bought entirely by the cross edges; those touch a few dozen
vertices per side; so each half is characterised ONCE by the colour patterns it can impose there,
and the two halves become INDEPENDENTLY optimisable. The inner loop never colours the union.

Acceptance test, one solver call per proposal on a half-size graph: dropping vertices can only
relax a half's colouring problem, so its pattern set can only GROW -- a drop is safe exactly when
it admits no pattern outside the set we started with, which is the CNF the pattern enumeration
already built.

Parallel over PROPOSALS (the antichain; §M5.1). Checkpointed every accepted drop, so a crash redoes
at most one round. UNTRUSTED: every verdict here is REFUSED-4 at best, never a find (§M3.1).
"""
from __future__ import annotations
import json, os, pickle, random, sys, time
from multiprocessing import Pool
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import typem as T

A = None; EP = None; PAT = None; WALL = 300.0

def _init(arena, ep, pat, wall):
    global A, EP, PAT, WALL
    A, EP, PAT, WALL = arena, ep, pat, wall

def _try(side):
    from five_dial import sat
    cl = T.side_cnf(A, side) + T._blocks(A, EP, PAT)
    st, _ = sat(cl, A.N * 4, wall=WALL)
    return side, {"unsat": "safe", "sat": "grew", "unknown": "unknown"}[st]

def run(tag, arena_pkl, out_dir, workers=30, wall=300.0, rounds=10**9, budget_s=None):
    d = pickle.load(open(arena_pkl, "rb"))
    Ar = T.Arena(d["pts"], d["Ei"], d["Ec"])
    nm = [T.norm2(p) for p in d["pts"]]
    Ec = [(i, j) for i, j in d["Ec"] if i != Ar.centre and j != Ar.centre]
    ref = [(i, j) for i, j in Ec if 3.99 < T.kfloat(nm[i]) < 4.01]
    Lep, Sep = T.cross_endpoints(Ar, ref)
    masks, _ = T.arena_orbits(Ar, d["pts"])
    out = Path(out_dir); out.mkdir(parents=True, exist_ok=True)
    t0 = time.time()
    log = lambda s: print(f"[{time.time()-t0:7.0f}s] {s}", flush=True)
    log(f"{tag}: arena {Ar.N} vertices, {len(masks)} orbits, {len(ref)} reference cross edges, "
        f"{len(Lep)} endpoints/side")

    sides = {"L": (Ar.full & ((1 << Ar.n) - 1), Lep),
             "S": (Ar.full & ~((1 << Ar.n) - 1), Sep)}
    pats = {}
    for k, (s, ep) in sides.items():
        t = time.time(); P, ex = T.patterns(Ar, s, ep, cap=4000, wall=600.0)
        pats[k] = P
        log(f"  P_{k} = {len(P)} patterns{'' if ex else ' (CAPPED -- no refusal may be claimed)'} "
            f"[{time.time()-t:.0f}s]")
        if not ex:
            log("  ABORT: a capped pattern set cannot license anything."); return

    rng = random.Random(20260910)
    cur = {k: sides[k][0] for k in sides}
    for rnd in range(rounds):
        if budget_s and time.time() - t0 > budget_s:
            log("budget reached"); break
        moved = False
        for k in ("L", "S"):
            side, ep = cur[k], sides[k][1]
            live = [m for m in masks if (m & side) == m and not (m & (1 << Ar.centre))
                    and not (m & (1 << (Ar.n + Ar.centre)))]
            live = [m for m in live if (m & side)]
            if not live: continue
            for chunk in (max(1, len(live)//4), max(1, len(live)//16), max(1, len(live)//64), 4, 1):
                props = []
                pool_orbits = live[:]; rng.shuffle(pool_orbits)
                for i in range(0, min(len(pool_orbits), workers*chunk), chunk):
                    batch = pool_orbits[i:i+chunk]
                    trial = side
                    for m in batch: trial &= ~m
                    if trial != side: props.append(trial)
                if not props: continue
                with Pool(workers, initializer=_init, initargs=(Ar, ep, pats[k], wall)) as pool:
                    res = pool.map(_try, props)
                safe = [s for s, v in res if v == "safe"]
                if safe:
                    best = min(safe, key=lambda s: s.bit_count())
                    log(f"  {k}: {side.bit_count()} -> {best.bit_count()} vertices "
                        f"(chunk {chunk}, {len(safe)}/{len(props)} proposals safe)")
                    cur[k] = best; moved = True
                    json.dump({"tag": tag, "L": hex(cur['L']), "S": hex(cur['S']),
                               "vertices": cur['L'].bit_count()+cur['S'].bit_count(),
                               "round": rnd, "seconds": round(time.time()-t0, 1)},
                              open(out/f"ckpt-{tag}.json", "w"))
                    break
        total = cur['L'].bit_count() + cur['S'].bit_count()
        log(f"round {rnd}: L {cur['L'].bit_count()} + S {cur['S'].bit_count()} = {total}")
        if not moved:
            log("no proposal accepted at any chunk size -- converged for this order"); break
    # final verification against the DIRECT solver: the pattern test is sufficient, not necessary,
    # so the union must be confirmed by the thing the pattern test stands in for.
    union = cur['L'] | cur['S']
    st = T.refuses_four(Ar, union, wall=3600.0)
    log(f"FINAL: {union.bit_count()} vertices; direct solver on the union: {st.upper()}")
    json.dump({"tag": tag, "L": hex(cur['L']), "S": hex(cur['S']), "vertices": union.bit_count(),
               "direct_verdict": st, "seconds": round(time.time()-t0, 1),
               "claim_scope": "REFUSED-4 at best. NOT a find and NOT a record until the exact "
               "geometry decides and an LRAT replay is kernel-checked (M62 §M3.1)."},
              open(out/f"result-{tag}.json", "w"))

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--tag", default="sym")
    ap.add_argument("--arena", default="/tmp/sym_arena.pkl")
    ap.add_argument("--out", default="data/m62")
    ap.add_argument("--workers", type=int, default=30)
    ap.add_argument("--wall", type=float, default=300.0)
    ap.add_argument("--budget", type=float, default=None)
    a = ap.parse_args()
    run(a.tag, a.arena, a.out, a.workers, a.wall, budget_s=a.budget)
