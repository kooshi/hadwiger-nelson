"""Drive the degree-2 hyperedge search, with the rotation's symmetry collapsing the pair list.

Pairs are enumerated only among the groups the degree-1 search left DROPPABLE -- a pair containing
a critical vertex is already covered by a degree-1 hyperedge, and `[Parts2020a]` §5.5 requires that
a hyperedge of some degree contain no hyperedge of lower degree entirely.
"""
import sys, os, json, time, pickle, subprocess, argparse, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
from fractions import Fraction as Fr
from symstate import zeta6_perm
HERE = os.path.dirname(os.path.abspath(__file__))
ap = argparse.ArgumentParser()
ap.add_argument("--state", required=True)
ap.add_argument("--arena", default="/tmp/arena244.pkl")
ap.add_argument("--census", required=True, help="census.json with droppable_groups")
ap.add_argument("--dir", required=True)
ap.add_argument("--workers", type=int, default=16)
ap.add_argument("--budget", type=int, default=0)
a = ap.parse_args()
os.makedirs(a.dir, exist_ok=True)
d = pickle.load(open(a.state, "rb")); weights = d["weights"]
cen = json.load(open(a.census))
drop = sorted(cen["droppable_groups"]) if "droppable_groups" in cen else sorted(cen)
# the rotation, as a permutation of this state's group indices (vertex granularity: one per group)
D = pickle.load(open(a.arena, "rb")); p6 = zeta6_perm(D["pts"]); n = D["n"]
live = d["live"]; pos = {v: i for i, v in enumerate(live)}
gof = {m[0]: g for g, m in enumerate(d["members"])}
def rot(g):
    v = live[d["members"][g][0]]
    b = p6[v] if v < n else n + p6[v - n]
    i = pos.get(b)
    return gof.get(i)
orbit_rep, seen = [], set()
for u, v in itertools.combinations(drop, 2):
    if (u, v) in seen: continue
    x, y = u, v; cyc = []
    for _ in range(6):
        if x is None or y is None: break
        cyc.append((min(x, y), max(x, y))); x, y = rot(x), rot(y)
    for p in cyc: seen.add(p)
    orbit_rep.append((u, v))
t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
log(f"degree-2 search: {len(drop)} droppable groups -> {len(list(itertools.combinations(drop,2)))} "
    f"pairs, collapsed by the order-6 rotation to {len(orbit_rep)} representatives "
    f"({len(list(itertools.combinations(drop,2)))/max(len(orbit_rep),1):.1f}x)")
st = dict(d); st["keep"] = sorted(cen.get("keep", range(len(weights)))) if "keep" in cen else sorted(range(len(weights)))
st["pairs"] = [list(p) for p in orbit_rep]
sp = f"{a.dir}/state.pkl"; pickle.dump(st, open(sp, "wb"), protocol=5)
outs = [f"{a.dir}/w{w}.jsonl" for w in range(a.workers)]
procs = []
for w in range(a.workers):
    e = open(f"{a.dir}/w{w}.err", "a")
    procs.append((subprocess.Popen([sys.executable, os.path.join(HERE, "hyperedges.py"), sp,
                                    str(w), str(a.workers), str(a.budget), outs[w]],
                                   stdout=subprocess.PIPE, stderr=e, text=True), e))
last = None
while any(p.poll() is None for p, _ in procs):
    time.sleep(30)
    rows, he, fp, un = 0, 0, 0, 0
    for p in outs:
        if not os.path.exists(p): continue
        for ln in open(p):
            try: x = json.loads(ln)
            except Exception: continue
            rows += 1
            he += x["verdict"] == "hyperedge"; fp += x["verdict"] == "free-pair"
            un += x["verdict"] == "undecided"
    m = f"{rows}/{len(orbit_rep)} -- {he} hyperedges, {fp} free pairs, {un} undecided"
    if m != last: last = m; log("  " + m)
for p, e in procs: p.wait(); e.close()
H = []
for p in outs:
    if os.path.exists(p):
        for ln in open(p):
            x = json.loads(ln)
            if x["verdict"] == "hyperedge": H.append(x["pair"])
full = []
for (u, v) in H:
    x, y = u, v
    for _ in range(6):
        if x is None or y is None: break
        full.append(sorted((x, y))); x, y = rot(x), rot(y)
uniq = sorted({tuple(p) for p in full})
json.dump(dict(kind="degree-2-hyperedges", representatives=len(orbit_rep),
               hyperedge_reps=len(H), hyperedges=len(uniq),
               pairs=[list(p) for p in uniq], fingerprint=d.get("fingerprint"),
               scope="a pair whose JOINT deletion was witnessed to lose refusal, neither member "
                     "being droppable-alone-critical; the degree-2 layer of Parts's hypergraph Y"),
          open(f"{a.dir}/hyperedges.json", "w"))
log(f"DONE: {len(H)} hyperedge representatives -> {len(uniq)} pairs under the rotation")
