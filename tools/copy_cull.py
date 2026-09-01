"""copy_cull — Kooshi (2026-09-01): "even if the floor cheats survive… any could have been culled by
this". The joint question: the smallest set of cheats that still forces 205 = 206 at five colours,
found by delta debugging over ALL standing cheats with NO halo — on X (the it-4 object) and on
X' = X ∪ T(U) (the object plus the transformed copy of its unit part). The size difference is the
dial reading the copy buys for free. Property tested = the pair is still forced (the separating ask
is UNSAT). Unknown at cap counts as NOT removable (conservative) and is recorded. Checkpointed per
accepted removal; resumable."""
from __future__ import annotations
import json, sys, time
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

    def forced(kept_set):
        nonlocal asks
        edges = e2 + list(kept_set)
        cls = coloring.base_clauses(n2, edges, K) + rigidity.amo_clauses(n2, K)
        cls += T._brk_full(n2, K, T._degree_order(n2, edges)) + ne
        asks += 1
        return forcer._solve(cls, n2 * K, cap)[0]

    def save(note):
        with ckp.open("a") as f:
            f.write(json.dumps({"kind": "state", "kept": [list(e) for e in kept], "unknown": [list(e) for e in unknowns], "asks": asks, "note": note, "t": time.time()}) + "\n")

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
        if len(chunk) == 1:
            if st == "unknown":
                unknowns.add(chunk[0]); save("unknown singleton")
            return
        h = len(chunk) // 2
        ddmin(chunk[:h]); ddmin(chunk[h:])

    ddmin(cand)
    # one more greedy singleton sweep over what remains (ddmin's halving can miss late singles)
    for e in list(kept):
        if e in unknowns: continue
        trial = [x for x in kept if x != e]
        st = forced(trial)
        if st == "unsat":
            kept = trial; save("greedy single")
            print(f"[cull] {tname}: single drop -> kept {len(kept)} (asks {asks})", flush=True)
        elif st == "unknown":
            unknowns.add(e); save("unknown single")
    # final control: kept still forces; kept is 1-minimal modulo unknowns
    st = forced(kept)
    row = dict(kind="copy-cull", object=label, transform=tname, cheats_start=len(cheats), kept=[list(e) for e in kept],
               kept_n=len(kept), floor_kept=len([e for e in kept if e in floor]), unknown=[list(e) for e in unknowns],
               asks=asks, control_forced=st, seconds=round(time.time() - t0, 1), cap=cap,
               note="a 1-minimal forcing cheat subset (modulo unknowns) with NO halo; float chords for the copy")
    json.dump(row, open(BUILD / f"m51-copycull-{tname}.json", "w"), indent=1)
    print(f"[cull] {tname}: FINAL kept {len(kept)} of {len(cheats)} (floor cheats kept {row['floor_kept']}/{len(floor)}), unknown {len(unknowns)}, control {st.upper()}, asks {asks}, {time.time()-t0:.0f}s", flush=True)

if __name__ == "__main__":
    main()
