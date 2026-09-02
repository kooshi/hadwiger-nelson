"""copy_cull — Kooshi (2026-09-01): "even if the floor cheats survive… any could have been culled by
this". The joint question: the smallest set of cheats that still forces 205 = 206 at five colours,
found by delta debugging over ALL standing cheats with NO halo — on X (the it-4 object) and on
X' = X ∪ T(U) (the object plus the transformed copy of its unit part). The size difference is the
dial reading the copy buys for free. Property tested = the pair is still forced (the separating ask
is UNSAT). Unknown at cap counts as NOT removable (conservative) and is recorded. Checkpointed per
accepted removal; resumable."""
from __future__ import annotations
import json, sys, time, threading
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from batchkill import BUILD, load_object
import coloring, forcer, rigidity
import twodist as T
import copy_probe as CP
K = 5

def main():
    label, tname, cap = sys.argv[1], sys.argv[2], float(sys.argv[3])
    obj, removed = load_object(label)
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    if tname == "none":
        n2, e2, info = obj.n, ue, dict(cross=0)
    else:
        n2, e2, info = CP.resolve(tname, obj.pts, live)(ue)
    cheats = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    floor = set(tuple(e) for e in json.load(open(BUILD / "m51-floor-it4-list.json")))
    ne = [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    ckp = BUILD / f"m51-copycull-{tname}.jsonl"
    log = []
    state = None
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line); log.append(r)
            if r.get("kind") == "state": state = r
    kept = [tuple(e) for e in state["kept"]] if state else list(cheats)
    unknowns = set(tuple(e) for e in state["unknown"]) if state else set()
    asks = state["asks"] if state else 0
    print(f"[cull] {tname}: n={n2} unit {len(e2)} (cross {info['cross']}) cheats {len(cheats)} floor {len(floor)}; resume kept={len(kept)} asks={asks}", flush=True)

    _lk = threading.Lock(); _asks = [asks]
    def forced(kept_set, cap2=None):
        edges = e2 + list(kept_set)
        cls = coloring.base_clauses(n2, edges, K) + rigidity.amo_clauses(n2, K)
        cls += T._brk_full(n2, K, T._degree_order(n2, edges)) + ne
        t1 = time.time(); st = forcer._solve(cls, n2 * K, cap2 if cap2 else cap)[0]
        with _lk:
            _asks[0] += 1
            with ckp.open("a") as f:
                f.write(json.dumps({"kind": "ask", "kept": len(kept_set), "st": st, "seconds": round(time.time() - t1, 1)}) + "\n")
        return st

    def save(note):
        with ckp.open("a") as f:
            f.write(json.dumps({"kind": "state", "kept": [list(e) for e in kept], "unknown": [list(e) for e in unknowns], "asks": _asks[0], "note": note, "t": time.time()}) + "\n")

    # candidates: non-floor first (floor cheats cannot go alone unless the copy changed that)
    cand = [e for e in kept if e not in floor] + [e for e in kept if e in floor]
    t0 = time.time()

    def ddmin(chunk):
        """Try to drop the whole chunk; else halve; singletons decided individually."""
        nonlocal kept
        chunk = [e for e in chunk if e in kept]
        if not chunk:
            return
        trial = [e for e in kept if e not in set(chunk)]
        st = forced(trial)
        if st == "unsat":
            kept = trial
            save(f"dropped {len(chunk)} together")
            print(f"[cull] {tname}: dropped {len(chunk):3d} together -> kept {len(kept)} (asks {asks}, {time.time()-t0:.0f}s)", flush=True)
            return
        if len(chunk) <= 8:
            return   # small chunks go to the parallel-singles phase
        h = len(chunk) // 2
        ddmin(chunk[:h]); ddmin(chunk[h:])

    ddmin(cand)
    # parallel singles: probe W at a time; sat is PERMANENT (monotone: removing more cheats only
    # helps the separating side); unsat probes are confirmed sequentially against the current kept;
    # unknowns deferred to a long-cap second pass.
    import mechanism
    sat_marked = set(); W = mechanism.WORKERS
    print(f"[cull] {tname}: parallel singles over {len(kept)} kept, W={W}, caps {cap}/{4*cap}", flush=True)
    for cap_pass in (None, 4 * cap):
        pending = [e for e in kept if e not in sat_marked and e not in unknowns]
        if cap_pass:
            pending = [e for e in pending if e in unknowns_pass]
        unknowns_pass = set()
        while pending:
            batch, pending = pending[:W], pending[W:]
            batch = [e for e in batch if e in kept]
            if not batch: continue
            base = list(kept)
            res = mechanism.pmap(lambda e: forced([x for x in base if x != e], cap_pass), batch)
            changed = False
            for e, st in zip(batch, res):
                if st == "sat":
                    sat_marked.add(e)
                elif st == "unknown":
                    unknowns_pass.add(e)
                elif st == "unsat":
                    if changed:  # kept moved since the probe: confirm
                        st = forced([x for x in kept if x != e], cap_pass)
                    if st == "unsat":
                        kept = [x for x in kept if x != e]; changed = True; save("parallel single")
                        print(f"[cull] {tname}: single drop -> kept {len(kept)} (asks {_asks[0]})", flush=True)
                    elif st == "unknown":
                        unknowns_pass.add(e)
                    else:
                        sat_marked.add(e)
        print(f"[cull] {tname}: pass done — kept {len(kept)}, unknown this pass {len(unknowns_pass)}", flush=True)
    unknowns |= unknowns_pass
    asks = _asks[0]
    # final control: kept still forces; kept is 1-minimal modulo unknowns
    st = forced(kept)
    asks = _asks[0]
    row = dict(kind="copy-cull", object=label, transform=tname, cheats_start=len(cheats), kept=[list(e) for e in kept],
               kept_n=len(kept), floor_kept=len([e for e in kept if e in floor]), unknown=[list(e) for e in unknowns],
               asks=asks, control_forced=st, seconds=round(time.time() - t0, 1), cap=cap,
               note="a 1-minimal forcing cheat subset (modulo unknowns) with NO halo; float chords for the copy")
    json.dump(row, open(BUILD / f"m51-copycull-{tname}.json", "w"), indent=1)
    print(f"[cull] {tname}: FINAL kept {len(kept)} of {len(cheats)} (floor cheats kept {row['floor_kept']}/{len(floor)}), unknown {len(unknowns)}, control {st.upper()}, asks {asks}, {time.time()-t0:.0f}s", flush=True)

if __name__ == "__main__":
    main()
