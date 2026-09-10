"""Drive several large-neighbourhood searches from a starting object, in parallel, and report the
best REFUTING selection found -- never a "minimal" one, which only a census may certify."""
import sys, os, json, time, pickle, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
HERE = os.path.dirname(os.path.abspath(__file__))
ap = argparse.ArgumentParser()
ap.add_argument("--state", required=True)
ap.add_argument("--start", required=True, help="json list of group indices, or 'all'")
ap.add_argument("--dir", required=True)
ap.add_argument("--seeds", type=int, default=12)
ap.add_argument("--iters", type=int, default=400)
ap.add_argument("--destroy", default="4", help="comma list; walks cycle over it")
ap.add_argument("--width", type=int, default=6)
ap.add_argument("--worker", default="lns_worker.py")
ap.add_argument("--budget", type=int, default=0)
a = ap.parse_args()
os.makedirs(a.dir, exist_ok=True)
d = pickle.load(open(a.state, "rb")); weights = d["weights"]
start = sorted(range(len(weights))) if a.start == "all" else json.load(open(a.start))
d = dict(d); d["start"] = sorted(start)
sp = f"{a.dir}/state.pkl"; pickle.dump(d, open(sp, "wb"), protocol=5)
t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
log(f"LNS from {sum(weights[g] for g in start)} vertices, pool {len(weights)} groups, "
    f"{a.seeds} walks x {a.iters} iterations, destroy sizes {a.destroy} (width {a.width}), "
    f"fingerprint {d.get('fingerprint','UNSET')}")
DS = [int(x) for x in str(a.destroy).split(",")]
procs = []
for s in range(a.seeds):
    e = open(f"{a.dir}/s{s}.err", "a")
    procs.append((subprocess.Popen([sys.executable, os.path.join(HERE, a.worker), sp,
                                    str(s), str(a.iters), str(DS[s % len(DS)]), str(a.budget),
                                    f"{a.dir}/s{s}.json", str(a.width)],
                                   stdout=subprocess.PIPE, stderr=e, text=True), e))
last = None
while any(p.poll() is None for p, _ in procs):
    time.sleep(30)
    cur = []
    for s in range(a.seeds):
        p = f"{a.dir}/s{s}.json"
        if os.path.exists(p):
            try: cur.append(json.load(open(p))["best_weight"])
            except Exception: pass
    m = f"best per walk: {sorted(cur)}" if cur else "no walk has reported yet"
    if m != last: last = m; log(f"  {m} [{time.time()-t0:.0f}s]")
for p, e in procs: p.wait(); e.close()
rows = []
for s in range(a.seeds):
    p = f"{a.dir}/s{s}.json"
    if os.path.exists(p):
        try: rows.append(json.load(open(p)))
        except Exception: pass
if rows:
    b = min(rows, key=lambda r: r["best_weight"])
    log(f"BEST {b['best_weight']} vertices (walk {b['seed']}); spread "
        f"{sorted(r['best_weight'] for r in rows)}")
    json.dump(dict(kind="lns", best_weight=b["best_weight"], best_keep=b["best_keep"],
                   spread=sorted(r["best_weight"] for r in rows),
                   scope="every reported weight is a REFUTING selection -- an upper bound; "
                         "minimality is not claimed and needs an independent census"),
              open(f"{a.dir}/final.json", "w"), indent=1)
