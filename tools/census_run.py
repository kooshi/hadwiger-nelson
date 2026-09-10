"""Drive the single-deletion criticality census across plain subprocesses.

No pool, no queue, no epoll: this project owns a 96-minute multiprocessing wedge, and the census
needs none of it -- the asks are an antichain, so a static round-robin slice per worker is the
whole scheduler. Workers are stopped by PID (never by a command-line pattern; `pkill -f` matches
its own wrapper here and has taken a shell down).
"""
import sys, os, json, time, pickle, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from census import fingerprint, summarise

ap = argparse.ArgumentParser()
ap.add_argument("--state", default="/tmp/pf_state.pkl")
ap.add_argument("--workers", type=int, default=8)
ap.add_argument("--budget", type=int, default=0)
ap.add_argument("--dir", default="data/m62/census")
ap.add_argument("--fp", default="")
a = ap.parse_args()
os.makedirs(a.dir, exist_ok=True)
d = pickle.load(open(a.state, 'rb')); weights = d['weights']
t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
log(f"census: {len(weights)} groups, {a.workers} workers, budget {a.budget or 'none'}, "
    f"fingerprint {a.fp or 'UNSET -- pass --fp so a later reader can compare rather than remember'}")
procs, errs = [], []
for w in range(a.workers):
    e = open(f"{a.dir}/w{w}.err", "a"); errs.append(e)
    procs.append(subprocess.Popen(
        [sys.executable, os.path.join(os.path.dirname(os.path.abspath(__file__)), "census_worker.py"),
         a.state, str(w), str(a.workers), str(a.budget), f"{a.dir}/w{w}.jsonl"],
        stdout=subprocess.PIPE, stderr=e, text=True))
last = -1
while any(p.poll() is None for p in procs):
    time.sleep(20)
    rows = []
    for w in range(a.workers):
        p = f"{a.dir}/w{w}.jsonl"
        if os.path.exists(p):
            for ln in open(p):
                try: rows.append(json.loads(ln))
                except Exception: pass
    if len(rows) != last:
        last = len(rows); s = summarise(rows, weights)
        log(f"  {s['asked']}/{s['of']} asked -- {s['critical']} critical, "
            f"{s['droppable_alone']} droppable-alone, {s['undecided']} undecided; "
            f"LB so far {s['lower_bound_weight']} vertices, drop capacity so far "
            f"{s['drop_capacity_weight']}")
for p in procs: p.wait()
for e in errs: e.close()
rows, seen = [], set()
for w in range(a.workers):
    for ln in open(f"{a.dir}/w{w}.jsonl"):
        r = json.loads(ln)
        if r["group"] not in seen: seen.add(r["group"]); rows.append(r)
s = summarise(rows, weights)
s.update(kind="single-deletion-criticality-census", fingerprint=a.fp,
         seconds=round(time.time() - t0, 1), workers=a.workers, budget=a.budget,
         claim_scope=("`critical` = a four-colouring of keep-minus-this-group was EXHIBITED, so the "
                      "group lies in every working selection -- permanent, and a LOWER bound. "
                      "`droppable-alone` = it can be removed BY ITSELF; joint droppability is a "
                      "different question and this census does not answer it."))
json.dump(s, open(f"{a.dir}/census.json", "w"), indent=1)
log(f"DONE {s['asked']}/{s['of']}: {s['critical']} critical / {s['droppable_alone']} droppable-alone"
    f" / {s['undecided']} undecided")
log(f"  LOWER BOUND {s['lower_bound_weight']} vertices (+1 hard centre); "
    f"drop capacity at most {s['drop_capacity_weight']} vertices"
    + ("  -- BUDGET FIXED POINT: undecideds are counted as droppable, so the bound is a bound on "
       "the bound" if s['budget_fixed_point'] else ""))
