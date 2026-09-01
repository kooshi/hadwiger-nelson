"""copy_floor — Kooshi's question (2026-09-01): which cheats does the 5-chromatic union make
redundant? On the object X = U ∪ C plus a transformed copy T(U) of the unit part (no cheats in the
copy), re-run the single-deletion census over the current FLOOR (the cheats essential alone on X):
sat = still essential with the copy present; UNSAT = the copy makes that cheat redundant (its lone
deletion no longer admits a separating 5-colouring). Plus two anchors: the all-cheats control (must
be UNSAT — still forced) and the JACKPOT ask (zero cheats: is 205=206 forced by unit material
alone? UNSAT would be χ(ℝ²) ≥ 6 — HALT AND VERIFY). Float geometry as in the probe; checkpointed
per verdict; parallel."""
from __future__ import annotations
import json, sys, time, threading
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from batchkill import BUILD, load_object
import coloring, forcer, rigidity, mechanism
import twodist as T
import copy_probe as CP
K = 5

def main():
    label, tname, cap, workers = sys.argv[1], sys.argv[2], float(sys.argv[3]), int(sys.argv[4])
    obj, removed = load_object(label)
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    n2, e2, info = CP.resolve(tname, obj.pts, live)(ue)
    cheats = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    floor = [tuple(e) for e in json.load(open(BUILD / "m51-floor-it4-list.json"))]
    assert set(floor) <= set(cheats)
    ne = [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    print(f"[floor] {tname}: union n={n2} unit edges {len(e2)} (cross {info['cross']}), cheats {len(cheats)}, floor {len(floor)}, pair ({obj.A},{obj.B})", flush=True)
    ckp = BUILD / f"m51-copyfloor-{tname}.jsonl"
    done = {}
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line)
            if r["st"] in ("sat", "unsat"): done[r["key"]] = r["st"]
    lock = threading.Lock()

    def ask(key, drop):
        if key in done: return done[key]
        edges = e2 + [e for e in cheats if e not in drop]
        cls = coloring.base_clauses(n2, edges, K) + rigidity.amo_clauses(n2, K)
        cls += T._brk_full(n2, K, T._degree_order(n2, edges)) + ne
        t1 = time.time(); st, _ = forcer._solve(cls, n2 * K, cap)
        with lock, ckp.open("a") as f:
            f.write(json.dumps({"key": key, "drop": [list(d) for d in drop], "st": st, "seconds": round(time.time() - t1, 1)}) + "\n")
        return st

    st_all = ask("all-cheats", set()); print(f"[floor] control all cheats (must be UNSAT): {st_all.upper()}", flush=True)
    st_none = ask("zero-cheats", set(cheats)); print(f"[floor] JACKPOT ask (zero cheats, unit material only): {st_none.upper()}" + ("   <<< χ(ℝ²) ≥ 6 CANDIDATE — HALT AND VERIFY" if st_none == "unsat" else ""), flush=True)
    outs = mechanism.pmap(lambda e: ask(f"drop-{e[0]}-{e[1]}", {e}), floor, workers=workers) if 'workers' in mechanism.pmap.__code__.co_varnames else mechanism.pmap(lambda e: ask(f"drop-{e[0]}-{e[1]}", {e}), floor)
    red = [e for e, st in zip(floor, outs) if st == "unsat"]
    ess = [e for e, st in zip(floor, outs) if st == "sat"]
    unk = [e for e, st in zip(floor, outs) if st == "unknown"]
    print(f"[floor] {tname}: of {len(floor)} floor cheats, REDUNDANT with the copy {len(red)}, still essential {len(ess)}, unknown {len(unk)}", flush=True)
    print(f"[floor]   redundant: {red}", flush=True)
    print(f"[floor]   heavy pair: 206-210 {'REDUNDANT' if (206,210) in red else 'essential' if (206,210) in ess else 'unknown'}, 206-211 {'REDUNDANT' if (206,211) in red else 'essential' if (206,211) in ess else 'unknown'}", flush=True)
    json.dump(dict(kind="copy-floor", object=label, transform=tname, union_n=n2, cross=info["cross"], all_cheats=st_all, zero_cheats=st_none,
                   redundant=[list(e) for e in red], essential=[list(e) for e in ess], unknown=[list(e) for e in unk], cap=cap,
                   note="float chords 1e-7; verdicts on the augmented object; a commit re-derives exactly"),
              open(BUILD / f"m51-copyfloor-{tname}.json", "w"), indent=1)

if __name__ == "__main__":
    main()
