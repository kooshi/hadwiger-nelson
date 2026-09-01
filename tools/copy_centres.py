"""copy_centres — Q8 follow-ups (Kooshi + his autocomplete, 2026-09-01): the d = 2 spindle rotation
(cos 7/8, sin √15/8) about OTHER centres — the four load-bearing halo points, every live seed vertex,
(later every halo point) — both signs; k = 4 on U ∪ R(U). Which centres lock? Parallel, checkpointed."""
from __future__ import annotations
import json, math, sys, time, threading
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from batchkill import BUILD, load_object
import mechanism
import copy_probe as CP

def main():
    label, which, cap = sys.argv[1], sys.argv[2], float(sys.argv[3])
    obj, _ = load_object(label)
    ue = obj.unit_edges(); live = sorted(set(range(obj.n)) - set(obj.deleted))
    if which == "seed+four":
        centres = [225, 243, 423, 424] + [v for v in live if v < 214]
    elif which == "halo":
        centres = [v for v in live if v >= 214]
    else:
        centres = [int(x) for x in which.split(",")]
    th = 2 * math.asin(0.25)
    ckp = BUILD / f"m51-copycentres-{which}.jsonl"
    done = {}
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line); done[(r["centre"], r["sign"])] = r
    lock = threading.Lock()
    P = np.array(obj.pts)

    def one(job):
        c, sgn = job
        if (c, sgn) in done: return done[(c, sgn)]
        C = P[c]
        def rot(Q, C=C, t=sgn * th):
            R = np.array([[math.cos(t), -math.sin(t)], [math.sin(t), math.cos(t)]])
            return C + (Q - C) @ R.T
        n2, e2, info = CP.union_graph(obj.pts, set(live), ue, rot)
        st, t = CP.ask_k(n2, e2, 4, cap)
        r = dict(centre=c, sign=sgn, kind=("seed" if c < 214 else "halo"), n=n2, cross=info["cross"], fused=info["fused"], k4=st, secs=round(t, 1))
        with lock, ckp.open("a") as f: f.write(json.dumps(r) + "\n")
        if st == "unsat":
            print(f"[centres] LOCK: centre {c} ({r['kind']}) sign {sgn:+d}: cross {info['cross']} fused {info['fused']} UNSAT {t:.1f}s", flush=True)
        return r

    jobs = [(c, s) for c in centres for s in (+1, -1)]
    t0 = time.time()
    rows = mechanism.pmap(one, jobs)
    locks = [r for r in rows if r["k4"] == "unsat"]; unk = [r for r in rows if r["k4"] == "unknown"]
    print(f"[centres] {which}: {len(jobs)} asks, LOCKS {len(locks)}, unknown {len(unk)}, {time.time()-t0:.0f}s", flush=True)
    print(f"[centres]   locking centres: {sorted(set((r['centre'], r['sign']) for r in locks))}", flush=True)
    json.dump(dict(kind="copy-centres", object=label, which=which, angle_deg=math.degrees(th), rows=rows, locks=locks, unknown=unk),
              open(BUILD / f"m51-copycentres-{which}.json", "w"), indent=1)

if __name__ == "__main__":
    main()
