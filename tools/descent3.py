"""Descend first, census last -- the order the measurement forced.

`descent2` ran the criticality census before the joint-drop search, on the argument that a
permanent witness is never re-derived. Measured on the 757-vertex object (2026-09-10), the first
191 asks of that census came back **177 droppable-alone and 14 critical**: at the TOP of a descent
almost nothing is critical, so the census discriminates almost nothing and costs one expensive
UNSAT ask per vertex (median 7.9 s, mean 8.8 s) to say so.

At the BOTTOM the same census is exactly the right instrument -- there almost everything is
critical, its asks are the cheap SAT ones, and it is what certifies 1-minimality and produces the
only rigorous LOWER bound this project has for the object. So the two phases swap:

  A  several gallop-prefix descent orders in parallel, from the current selection. Cheap while big
     drops are available, which is the regime at the top; each order ends with a witness for every
     group it kept, so its answer is already 1-minimal FOR ITS OWN ORDER.
  B  a parallel census over the best order's survivors -- an antichain, and now discriminating.
     Empty candidate set means 1-minimal and certified; anything left feeds round A again.

Upper bound from A, lower bound from B, reported as a sandwich and never as one number.
"""
from __future__ import annotations
import sys, os, json, time, pickle, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from census import summarise

HERE = os.path.dirname(os.path.abspath(__file__))


def _spawn(script, args, errpath):
    e = open(errpath, "a")
    return subprocess.Popen([sys.executable, os.path.join(HERE, script)] + [str(x) for x in args],
                            stdout=subprocess.PIPE, stderr=e, text=True), e


def _wait(procs, tick, log, label):
    t0 = time.time(); last = None
    while any(p.poll() is None for p, _ in procs):
        time.sleep(15)
        m = tick()
        if m != last: last = m; log(f"    {label} {m} [{time.time()-t0:.0f}s]")
    for p, e in procs: p.wait(); e.close()
    return time.time() - t0


def phaseA(base, keep, cand, wd, seeds, budget, log, weights):
    os.makedirs(wd, exist_ok=True)
    st = dict(base); st["keep"] = sorted(keep); st["cand"] = sorted(cand)
    pickle.dump(st, open(f"{wd}/state.pkl", "wb"), protocol=5)
    procs = [_spawn("descent2_worker.py", [f"{wd}/state.pkl", s, budget, f"{wd}/s{s}.json"],
                    f"{wd}/s{s}.err") for s in range(seeds)]
    def tick():
        """Report INSIDE the phase, not only at its end. A long phase whose only progress line is
        `0/N done` is blind, and this project has paid for that four times."""
        cur = []
        for s in range(seeds):
            w, e = None, f"{wd}/s{s}.err"
            if os.path.exists(e):
                for ln in open(e):
                    if "-> keep " in ln:
                        try: w = int(ln.split("-> keep ")[1].split("/")[1].split()[0])
                        except Exception: pass
            cur.append(w if w is not None else sum(weights[g] for g in keep))
        done = sum(os.path.exists(f"{wd}/s{s}.json") for s in range(seeds))
        return f"{done}/{seeds} orders done; weights now {sorted(cur)}"
    _wait(procs, tick, log, "descent")
    out = []
    for s in range(seeds):
        p = f"{wd}/s{s}.json"
        if os.path.exists(p):
            try: out.append(json.load(open(p)))
            except Exception: pass
    return out


def phaseB(base, keep, ask, wd, workers, budget, log, weights):
    os.makedirs(wd, exist_ok=True)
    st = dict(base); st["keep"] = sorted(keep); st["ask"] = sorted(ask)
    pickle.dump(st, open(f"{wd}/state.pkl", "wb"), protocol=5)
    outs = [f"{wd}/w{w}.jsonl" for w in range(workers)]
    procs = [_spawn("census_worker.py", [f"{wd}/state.pkl", w, workers, budget, outs[w]],
                    f"{wd}/w{w}.err") for w in range(workers)]

    def rows():
        r, seen = [], set()
        for p in outs:
            if not os.path.exists(p): continue
            for ln in open(p):
                try: x = json.loads(ln)
                except Exception: continue
                if x["group"] not in seen: seen.add(x["group"]); r.append(x)
        return r
    _wait(procs, lambda: (lambda s: f"{s['asked']}/{len(ask)} -- {s['critical']} critical, "
                                    f"{s['droppable_alone']} droppable-alone, {s['undecided']} undecided")
          (summarise(rows(), weights)), log, "census")
    return rows()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--state", required=True)
    ap.add_argument("--dir", required=True)
    ap.add_argument("--workers", type=int, default=16)
    ap.add_argument("--seeds", type=int, default=8)
    ap.add_argument("--budget", type=int, default=0)
    ap.add_argument("--rounds", type=int, default=8)
    a = ap.parse_args()
    os.makedirs(a.dir, exist_ok=True)
    base = pickle.load(open(a.state, "rb")); weights = base["weights"]
    t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
    ck = f"{a.dir}/progress.json"
    S = json.load(open(ck)) if os.path.exists(ck) else dict(
        round=0, keep=sorted(range(len(weights))), cand=sorted(range(len(weights))),
        critical=[], history=[])
    log(f"descend-then-census: {len(weights)} groups / {sum(weights)} vertices, "
        f"{a.seeds} orders, {a.workers} census workers, "
        f"fingerprint {base.get('fingerprint','UNSET')}")
    while S["round"] < a.rounds:
        r = S["round"]; keep = set(S["keep"]); cand = [g for g in S["cand"] if g in keep]
        log(f"  ROUND {r}: keep {len(keep)} groups / {sum(weights[g] for g in keep)} vertices; "
            f"{len(cand)} candidates; {len(S['critical'])} permanent witnesses")
        if not cand:
            log("  no candidate left -- every kept group carries a witness: 1-MINIMAL"); break
        res = phaseA(base, keep, cand, f"{a.dir}/r{r}A", a.seeds, a.budget, log, weights)
        if not res: log("  no order returned; stopping"); break
        best = min(res, key=lambda x: x["weight_keep"])
        spread = sorted(x["weight_keep"] for x in res)
        log(f"    A: order {best['seed']} kept {best['weight_keep']} vertices "
            f"(spread over {len(res)} orders: {spread}); asks {[x['asks'] for x in res]}")
        und = sum(x.get("undecided_asks", 0) for x in res)
        if und: log(f"    A: {und} asks ran out of budget -- those orders are fixed points of the "
                    f"BUDGET, not of the mathematics")
        keep = set(best["keep"])
        crit = sorted((set(S["critical"]) | set(best.get("witnessed", []))) & keep)
        rows = phaseB(base, keep, sorted(keep), f"{a.dir}/r{r}B", a.workers, a.budget, log, weights)
        s = summarise(rows, weights)
        D = sorted(x["group"] for x in rows if x["verdict"] == "droppable-alone")
        log(f"    B: {s['critical']} critical / {s['droppable_alone']} droppable-alone / "
            f"{s['undecided']} undecided;  LOWER BOUND {s['lower_bound_weight']} vertices"
            + ("  (a bound on the bound -- undecideds counted as droppable)"
               if s['budget_fixed_point'] else ""))
        S["history"].append(dict(round=r, kept=best["weight_keep"], spread=spread,
                                 lower_bound=s["lower_bound_weight"], census=s["asked"],
                                 droppable_alone=s["droppable_alone"]))
        S["keep"] = sorted(keep)
        S["critical"] = sorted(x["group"] for x in rows if x["verdict"] == "critical")
        S["cand"] = D
        S["round"] = r + 1
        S["lower_bound"] = s["lower_bound_weight"]
        json.dump(S, open(ck, "w"))
        if not D:
            log(f"  1-MINIMAL and CERTIFIED: every kept vertex has an exhibited four-colouring of "
                f"the selection without it"); break
    kw = sum(weights[g] for g in S["keep"])
    log(f"FINAL sandwich: lower bound {S.get('lower_bound','?')} <= minimum <= {kw} vertices "
        f"(+1 hard centre = {kw+1} in the object)")
    json.dump(S, open(f"{a.dir}/final.json", "w"), indent=1)


if __name__ == "__main__":
    main()
