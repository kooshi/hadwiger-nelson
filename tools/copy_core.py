"""copy_core — the 1-minimal vertex core of a copy_probe 5-chromatic union at k = 4 (delta debugging
over vertices; a vertex is necessary iff deleting it makes the rest 4-colourable). The certification
prerequisite (fewer points = fewer radicands in the field inventory) and the mechanism's name.
Checkpointed per accepted deletion; resumable. Unknown at cap = kept (conservative), recorded."""
from __future__ import annotations
import json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from batchkill import BUILD
import coloring, forcer, rigidity
import twodist as T
K = 4

def main():
    name, cap = sys.argv[1], float(sys.argv[2])
    U = json.load(open(BUILD / f"m51-copyunion-{name}.json"))
    n, E = U["n"], [tuple(e) for e in U["edges"]]
    ckp = BUILD / f"m51-copycore-{name}.jsonl"
    alive = set(range(n)); unknown = set(); asks = 0
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line)
            if r["kind"] == "state": alive, unknown, asks = set(r["alive"]), set(r["unknown"]), r["asks"]
    deg = {}
    for u, v in E: deg[u] = deg.get(u, 0) + 1; deg[v] = deg.get(v, 0) + 1
    alive = {v for v in alive if deg.get(v, 0) > 0}   # isolated vertices are free
    print(f"[core] {name}: n={n} edges={len(E)} alive={len(alive)} asks={asks}", flush=True)

    def colorable(S):
        nonlocal asks
        idx = {v: i for i, v in enumerate(sorted(S))}
        es = [(idx[u], idx[v]) for u, v in E if u in idx and v in idx]
        m = len(idx)
        if m == 0 or not es:
            return "sat"   # the empty graph is colourable: never delete everything
        cls = coloring.base_clauses(m, es, K) + rigidity.amo_clauses(m, K) + T._brk_full(m, K, T._degree_order(m, es))
        asks += 1
        return forcer._solve(cls, m * K, cap)[0]   # sat = colourable = the deletion is NOT allowed

    def save(note):
        with ckp.open("a") as f:
            f.write(json.dumps({"kind": "state", "alive": sorted(alive), "unknown": sorted(unknown), "asks": asks, "note": note}) + "\n")

    t0 = time.time()
    def ddmin(chunk):
        nonlocal alive
        chunk = [v for v in chunk if v in alive]
        if not chunk: return
        st = colorable(alive - set(chunk))
        if st == "unsat":
            alive -= set(chunk); save(f"deleted {len(chunk)}")
            print(f"[core] deleted {len(chunk):4d} -> alive {len(alive)} (asks {asks}, {time.time()-t0:.0f}s)", flush=True)
            return
        if len(chunk) == 1:
            if st == "unknown": unknown.add(chunk[0]); save("unknown")
            return
        h = len(chunk) // 2
        ddmin(chunk[:h]); ddmin(chunk[h:])
    # order: low degree first (likeliest deletable), so big chunks succeed early
    order = sorted(alive, key=lambda v: deg.get(v, 0))
    ddmin(order)
    for v in sorted(alive, key=lambda v: deg.get(v, 0)):
        if v in unknown or v not in alive: continue
        st = colorable(alive - {v})
        if st == "unsat": alive.discard(v); save("single")
        elif st == "unknown": unknown.add(v); save("unknown single")
    st = colorable(alive)
    core = sorted(alive)
    row = dict(kind="copy-core", union=name, core=core, core_n=len(core), original=sum(1 for v in core if v < 1862),
               copy=sum(1 for v in core if v >= 1862), unknown=sorted(unknown), asks=asks, control_refuses=(st == "unsat"),
               seconds=round(time.time() - t0, 1), cap=cap)
    json.dump(row, open(BUILD / f"m51-copycore-{name}.json", "w"), indent=1)
    print(f"[core] FINAL {name}: core {len(core)} points ({row['original']} original + {row['copy']} copy), unknown {len(unknown)}, control {'UNSAT' if st=='unsat' else st.upper()}, asks {asks}, {time.time()-t0:.0f}s", flush=True)

if __name__ == "__main__":
    main()
