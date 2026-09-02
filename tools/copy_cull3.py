"""copy_cull3 — the cull as GROUP-MUS EXTRACTION on long-lived incremental solvers (the 2026-09-02
domain + execution modeling passes; supersedes copy_cull's ddmin for speed, same claim and controls).

Shape: every cheat e is a constraint GROUP guarded by an assumption literal a_e; an ask on a kept
set = one incremental solve under assumptions. UNSAT returns a CORE (drop everything outside it in
one step, confirmed by a second ask under exactly the core); SAT returns a validated WITNESS whose
signature (the set of cheats it is proper on) answers future probes by mask test AND is the
necessity witness for the probed cheat. Verdicts propagate monotonically: SAT(kept−{e}) at any
superset ⟹ e necessary forever (removing more cheats only helps the separating side); the floor
censuses' verdicts pre-mark necessities the same way. Budgets are CONFLICT budgets, not wall caps.
Parallel: worker processes each hold a persistent solver (built once), probing candidate deletions;
the parent serializes acceptances and confirms stale UNSATs. Checkpoint per acceptance; resumes
from copy_cull's own state lines (same file). Final controls, decorrelated: the kept set re-refuted
by the OLD one-shot cadical path, and every necessity witness re-validated in numpy.

Soundness ledger: pool hits and pre-marks are sound by the monotone lemma; core jumps are confirmed
by a fresh UNSAT under the core; the final kept set is re-certified on an independent code path.
An unknown is never folded (recorded, re-probed at 10× budget, then reported)."""
from __future__ import annotations
import json, sys, time, os
from pathlib import Path
from multiprocessing import get_context
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from batchkill import BUILD, load_object
import coloring, forcer, rigidity
import twodist as T
import copy_probe as CP
K = 5

_W = {}

def _stage(label, tname):
    obj, removed = load_object(label)
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    n2, e2, info = (obj.n, ue, dict(cross=0)) if tname == "none" else CP.resolve(tname, obj.pts, live)(ue)
    cheats = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    return obj, n2, e2, info, cheats

def _mkclauses(n2, e2, cheats, A, B):
    base = coloring.base_clauses(n2, e2, K) + rigidity.amo_clauses(n2, K)
    base += T._brk_full(n2, K, T._degree_order(n2, e2))
    base += [[-coloring.var(A, c, K), -coloring.var(B, c, K)] for c in range(K)]
    nv = n2 * K
    sel = {}   # cheat -> assumption literal
    guarded = []
    for i, (u, v) in enumerate(cheats):
        a = nv + 1 + i
        sel[(u, v)] = a
        for c in range(K):
            guarded.append([-a, -coloring.var(u, c, K), -coloring.var(v, c, K)])
    return base + guarded, sel, nv

def _init(label, tname):
    from pysat.solvers import Cadical195
    obj, n2, e2, info, cheats = _stage(label, tname)
    cls, sel, nv = _mkclauses(n2, e2, cheats, obj.A, obj.B)
    s = Cadical195(bootstrap_with=cls)
    _W.update(s=s, sel=sel, nv=nv, n2=n2)

def _probe(args):
    """(kept_tuple, drop, budget) -> (drop, st, core_or_model_colours, secs)"""
    kept, drop, budget = args
    s, sel, nv, n2 = _W["s"], _W["sel"], _W["nv"], _W["n2"]
    assum = [sel[e] for e in kept if e != drop]
    t0 = time.time()
    s.conf_budget(budget)
    r = s.solve_limited(assumptions=assum)
    dt = time.time() - t0
    if r is True:
        m = s.get_model()
        pos = {l for l in m if 0 < l <= nv}
        cols = [next(c for c in range(K) if coloring.var(v, c, K) in pos) for v in range(n2)]
        return (drop, "sat", cols, dt)
    if r is False:
        core = s.get_core() or []
        inv = {a: e for e, a in sel.items()}
        return (drop, "unsat", sorted(inv[a] for a in core if a in inv), dt)
    return (drop, "unknown", None, dt)

def main():
    label, tname = sys.argv[1], sys.argv[2]
    budget = int(sys.argv[3]) if len(sys.argv) > 3 else 300_000
    workers = int(sys.argv[4]) if len(sys.argv) > 4 else 4
    obj, n2, e2, info, cheats = _stage(label, tname)
    A, B = obj.A, obj.B
    edges_np = np.array(e2)
    ckp = BUILD / f"m51-copycull-{tname}.jsonl"
    kept = list(cheats); necessary = {}; unknowns = set()
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line)
            if r.get("kind") == "state":
                kept = [tuple(e) for e in r["kept"]]; unknowns = set(tuple(e) for e in r["unknown"])
    log = ckp.open("a")
    def save(note):
        log.write(json.dumps({"kind": "state", "kept": [list(e) for e in kept],
                              "unknown": [list(e) for e in sorted(unknowns)], "asks": -1, "note": note, "t": time.time()}) + "\n"); log.flush()
    # pre-marked necessities from the floor censuses (monotone: sat at the full set ⟹ sat below)
    pre = 0
    for f, key in [(BUILD / "m51-floor-it4-list.json", None),
                   (BUILD / f"m51-copyfloor-{tname}.json", "essential")]:
        try:
            d = json.load(open(f)); lst = d if key is None else d[key]
            if key is None and tname != "none":
                continue   # the plain floor list applies to the plain object; the copy has its own census
            for e in lst:
                e = tuple(e)
                if e in kept and e not in necessary:
                    necessary[e] = "floor-census"; pre += 1
        except FileNotFoundError:
            pass
    print(f"[cull3] {tname}: n={n2} edges={len(e2)} cheats={len(cheats)} resume kept={len(kept)} premarked-necessary={pre}", flush=True)
    pool = get_context("fork").Pool(workers, initializer=_init, initargs=(label, tname))
    t0 = time.time(); nsolve = 0
    # witness pool: (mask over cheat indices proper on, colours)
    cidx = {e: i for i, e in enumerate(cheats)}
    wit = []
    def sig(cols):
        c = np.array(cols); m = 0
        for e, i in cidx.items():
            if c[e[0]] != c[e[1]]: m |= (1 << i)
        return m
    def pool_hit(drop):
        want = 0
        for e in kept:
            if e != drop: want |= (1 << cidx[e])
        for m, cols in wit:
            if m & want == want: return cols
        return None
    def validate(cols, drop):
        c = np.array(cols)
        assert (c[edges_np[:, 0]] != c[edges_np[:, 1]]).all(), "witness improper on a unit edge"
        assert c[A] != c[B], "witness not separating"
        for e in kept:
            if e != drop: assert c[e[0]] != c[e[1]], "witness improper on a kept cheat"
    # 0) control + first core jump
    (_, st, core, dt) = pool.apply(_probe, ((tuple(kept), None, budget * 10),))
    nsolve += 1
    print(f"[cull3] control full kept: {st.upper()} ({dt:.0f}s)", flush=True)
    if st == "unknown":
        ne0 = [[-coloring.var(A, c, K), -coloring.var(B, c, K)] for c in range(K)]
        edg0 = e2 + list(kept)
        cls0 = coloring.base_clauses(n2, edg0, K) + rigidity.amo_clauses(n2, K) + T._brk_full(n2, K, T._degree_order(n2, edg0)) + ne0
        t1 = time.time(); st1, _ = forcer._solve(cls0, n2 * K, 3600)
        print(f"[cull3] control one-shot fallback: {st1.upper()} ({time.time()-t1:.0f}s)", flush=True)
        st, core = st1, None
    assert st == "unsat", f"control failed: {st}"
    if core is not None and len(core) < len(kept):
        (_, st2, _, dt2) = pool.apply(_probe, ((tuple(core), None, budget * 10),)); nsolve += 1
        if st2 == "unsat":
            kept = [e for e in kept if e in set(core)]
            save("core jump (confirmed)")
            print(f"[cull3] CORE JUMP -> kept {len(kept)} ({dt2:.0f}s confirm)", flush=True)
    # 1) probe rounds
    for budget_pass in (budget, budget * 10):
        if budget_pass == budget:
            cand = [e for e in kept if e not in necessary and e not in unknowns]
        else:
            cand = [e for e in kept if e in unknowns]   # exactly the accumulated unknowns, re-probed
            unknowns = set()
        print(f"[cull3] pass @{budget_pass}: probing {len(cand)} candidates", flush=True)
        while cand:
            cand = [e for e in cand if e in kept and e not in necessary]
            batch, cand = cand[:workers], cand[workers:]
            if not batch: continue
            hits = []
            for e in list(batch):
                w = pool_hit(e)
                if w is not None:
                    necessary[e] = "pool"; batch.remove(e)
            if not batch: continue
            snap = tuple(kept)
            res = pool.map(_probe, [(snap, e, budget_pass) for e in batch])
            for (e, st, payload, dt) in res:
                nsolve += 1
                log.write(json.dumps({"kind": "ask", "kept": len(snap) - 1, "st": st, "seconds": round(dt, 1)}) + "\n")
                if st == "sat":
                    validate(payload, e)
                    wit.append((sig(payload), payload)); necessary[e] = payload
                elif st == "unknown":
                    unknowns.add(e)
                else:
                    core = payload
                    if tuple(kept) != snap:   # stale: confirm against the current kept
                        (_, st2, core2, _) = pool.apply(_probe, ((tuple(kept), e, budget_pass),)); nsolve += 1
                        if st2 != "unsat":
                            (unknowns.add(e) if st2 == "unknown" else None); continue
                        core = core2
                    newkept = [x for x in kept if x in set(core)]
                    (_, st3, _, _) = pool.apply(_probe, ((tuple(newkept), None, budget_pass),)); nsolve += 1
                    if st3 == "unsat":
                        kept = newkept; save(f"drop {e} + core")
                        print(f"[cull3] drop -> kept {len(kept)} (solves {nsolve}, {time.time()-t0:.0f}s)", flush=True)
                    else:
                        kept = [x for x in kept if x != e]; save(f"drop {e} (core unconfirmed)")
                        print(f"[cull3] drop(no-core) -> kept {len(kept)}", flush=True)
            log.flush()
        print(f"[cull3] pass @{budget_pass}: kept {len(kept)}, necessary {len(necessary)}, unknown {len(unknowns)}", flush=True)
    # 2) decorrelated final control: one-shot cadical on the kept set (the OLD code path)
    ne = [[-coloring.var(A, c, K), -coloring.var(B, c, K)] for c in range(K)]
    edges = e2 + list(kept)
    cls = coloring.base_clauses(n2, edges, K) + rigidity.amo_clauses(n2, K) + T._brk_full(n2, K, T._degree_order(n2, edges)) + ne
    st, _ = forcer._solve(cls, n2 * K, 3600)
    row = dict(kind="copy-cull", engine="cull3-groupmus", object=label, transform=tname,
               cheats_start=len(cheats), kept=[list(e) for e in kept], kept_n=len(kept),
               floor_kept=sum(1 for e in kept if necessary.get(e) == "floor-census"),
               necessity_witnessed=sum(1 for v in necessary.values() if isinstance(v, list)),
               unknown=[list(e) for e in sorted(unknowns)], solves=nsolve,
               control_forced=st, seconds=round(time.time() - t0, 1), budget=budget,
               note="group-MUS on incremental solvers; kept re-refuted on the one-shot path; witnesses validated in numpy")
    json.dump(row, open(BUILD / f"m51-copycull-{tname}.json", "w"), indent=1)
    print(f"[cull3] FINAL {tname}: kept {len(kept)} of {len(cheats)}, unknown {len(unknowns)}, one-shot control {st.upper()}, solves {nsolve}, {time.time()-t0:.0f}s", flush=True)
    pool.terminate()

def self_test():
    """Planted: A,B both adjacent to a shared K3; u,v likewise; cheats (A,u),(u,B),(A,v),(v,B).
    A,B,u,v are each confined to two colours; {(A,u),(u,B)} alone forces A=B — the MUS is one of
    the two pairs, size exactly 2."""
    import tempfile
    global _stage
    def fake_stage(label, tname):
        class O: pass
        o = O(); o.A, o.B = 0, 1
        pts = None
        p, q, r, u, v = 2, 3, 4, 5, 6
        e = [(0, p), (0, q), (0, r), (1, p), (1, q), (1, r), (p, q), (p, r), (q, r),
             (u, p), (u, q), (u, r), (v, p), (v, q), (v, r)]
        cheats = [(0, 5), (5, 1), (0, 6), (6, 1)]
        return o, 7, e, dict(cross=0), cheats
    _stage = fake_stage
    sys.argv = ["", "selftest", "selftest", "300000", "2"]
    main()
    r = json.load(open(BUILD / "m51-copycull-selftest.json"))
    assert r["kept_n"] == 2 and r["control_forced"] == "unsat", r
    ks = set(map(tuple, r["kept"]))
    assert ks in ({(0, 5), (5, 1)}, {(0, 6), (6, 1)}), ks
    print("[cull3] SELF-TEST OK: found a size-2 MUS from 4 cheats, control UNSAT")

if __name__ == "__main__":
    if sys.argv[1:2] == ["--self-test"]:
        self_test()
    else:
        main()
