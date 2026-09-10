"""The two-phase descent: a permanent criticality census, then a joint-drop search over what is left.

**Why two phases, derived rather than tuned.** Colourability is downward closed, so if `keep` minus `g`
is four-colourable then so is `S` minus `g` for every `S <= keep`: **a criticality witness taken at one
selection holds at every smaller one, permanently.** Three things follow and together they are the
algorithm.

*It is an antichain.* Every phase-1 ask is `keep` minus `g` from the SAME `keep`, so no ask waits on
another's answer. That is the one place in a descent where the dependency partial order has no
edges at all -- and in the sequential chunked descent it was the expensive part.

*It is never redone.* A group witnessed critical is never asked again, in this round, in a later
round, or by any other seed. The eight-seed portfolio of 2026-09-10 spent 4.4 CPU-hours
re-discovering the same witnesses eight times over inside eight descents that could not share them.

*It is complete.* A jointly droppable set is droppable one at a time (dropping fewer can only make
refusal easier), so `droppable-alone` is a SUPERSET of every droppable set. Phase 2 therefore
searches inside `D` and misses nothing -- and `D` is small where the group list is not.

**What each phase may claim.** Phase 1's `critical` verdicts are a rigorous LOWER bound (every one
of those groups is in every working selection). Phase 2's answer is an UPPER bound and 1-minimal
for its own order only -- different orders reach different 1-minimal sets, which is the whole
finding of `plans/DESCENT-ALGORITHM.md` (WO-9) and the reason phase 2 runs several orders at once.
The pair is reported as a sandwich, never as a number.
"""
from __future__ import annotations
import sys, os, json, time, pickle, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from census import summarise

HERE = os.path.dirname(os.path.abspath(__file__))


def _launch(script, args, errpath):
    e = open(errpath, "a")
    return subprocess.Popen([sys.executable, os.path.join(HERE, script)] + [str(a) for a in args],
                            stdout=subprocess.PIPE, stderr=e, text=True), e


def _read_rows(paths):
    rows, seen = [], set()
    for p in paths:
        if not os.path.exists(p): continue
        for ln in open(p):
            try: r = json.loads(ln)
            except Exception: continue
            if r["group"] not in seen: seen.add(r["group"]); rows.append(r)
    return rows


def phase1(base_state, keep, ask, workdir, workers, budget, log, weights):
    """The parallel criticality census over `ask`, taken from `keep`. Resumes exactly."""
    os.makedirs(workdir, exist_ok=True)
    st = dict(base_state); st["keep"] = sorted(keep); st["ask"] = sorted(ask)
    sp = f"{workdir}/state.pkl"; pickle.dump(st, open(sp, "wb"), protocol=5)
    outs = [f"{workdir}/w{w}.jsonl" for w in range(workers)]
    procs = [_launch("census_worker.py", [sp, w, workers, budget, outs[w]], f"{workdir}/w{w}.err")
             for w in range(workers)]
    last, t0 = -1, time.time()
    while any(p.poll() is None for p, _ in procs):
        time.sleep(15)
        rows = _read_rows(outs)
        if len(rows) != last:
            last = len(rows); s = summarise(rows, weights)
            log(f"    phase1 {len(rows)}/{len(ask)} -- {s['critical']} critical, "
                f"{s['droppable_alone']} droppable-alone, {s['undecided']} undecided "
                f"[{time.time()-t0:.0f}s]")
    for p, e in procs: p.wait(); e.close()
    return _read_rows(outs)


def phase2(base_state, keep, cand, workdir, seeds, budget, log, weights):
    """Several joint-drop orders over `cand`, in parallel; the heaviest drop wins.

    Only the ORDER differs between seeds -- which is the one lever WO-9 identified, now spent on a
    candidate set of tens rather than the full group list."""
    os.makedirs(workdir, exist_ok=True)
    st = dict(base_state); st["keep"] = sorted(keep); st["cand"] = sorted(cand)
    sp = f"{workdir}/state.pkl"; pickle.dump(st, open(sp, "wb"), protocol=5)
    procs = [_launch("descent2_worker.py", [sp, s, budget, f"{workdir}/s{s}.json"],
                     f"{workdir}/s{s}.err") for s in range(seeds)]
    t0 = time.time(); last = -1
    while any(p.poll() is None for p, _ in procs):
        time.sleep(15)
        n = sum(os.path.exists(f"{workdir}/s{s}.json") for s in range(seeds))
        if n != last: last = n; log(f"    phase2 {n}/{seeds} orders finished [{time.time()-t0:.0f}s]")
    for p, e in procs: p.wait(); e.close()
    out = []
    for s in range(seeds):
        p = f"{workdir}/s{s}.json"
        if os.path.exists(p):
            try: out.append(json.load(open(p)))
            except Exception: pass
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--state", default="/tmp/pf_state.pkl")
    ap.add_argument("--dir", default="data/m62/descent2")
    ap.add_argument("--workers", type=int, default=8)
    ap.add_argument("--seeds", type=int, default=8)
    ap.add_argument("--budget", type=int, default=0)
    ap.add_argument("--rounds", type=int, default=12)
    ap.add_argument("--fp", default="")
    a = ap.parse_args()
    os.makedirs(a.dir, exist_ok=True)
    base = pickle.load(open(a.state, "rb")); weights = base["weights"]
    t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:6.0f}s] {m}", flush=True)
    ck = f"{a.dir}/progress.json"
    if os.path.exists(ck):
        S = json.load(open(ck)); log(f"RESUMING from round {S['round']}: keep {len(S['keep'])} groups, "
                                     f"weight {sum(weights[g] for g in S['keep'])}")
    else:
        S = dict(round=0, keep=sorted(range(len(weights))), critical=[], ask=sorted(range(len(weights))),
                 history=[], fingerprint=a.fp)
    log(f"two-phase descent: {len(weights)} groups, weight {sum(weights)}, {a.workers} census "
        f"workers, {a.seeds} joint-drop orders, budget {a.budget or 'none'}, "
        f"fingerprint {a.fp or 'UNSET'}")
    while S["round"] < a.rounds:
        r = S["round"]; keep = set(S["keep"]); ask = [g for g in S["ask"] if g in keep]
        w = sum(weights[g] for g in keep)
        log(f"  ROUND {r}: keep {len(keep)} groups / {w} vertices; "
            f"{len(S['critical'])} permanently critical; {len(ask)} to ask")
        if not ask:
            log("  no group left unasked: every kept group carries a permanent witness -- 1-MINIMAL"); break
        rows = phase1(base, keep, ask, f"{a.dir}/r{r}p1", a.workers, a.budget, log, weights)
        s1 = summarise(rows, weights)
        crit = sorted(set(S["critical"]) | {x["group"] for x in rows if x["verdict"] == "critical"})
        D = sorted(x["group"] for x in rows if x["verdict"] == "droppable-alone")
        und = sorted(x["group"] for x in rows if x["verdict"] == "undecided")
        log(f"    phase1 done: {len(crit)} critical total (LB {sum(weights[g] for g in crit)} vertices), "
            f"{len(D)} droppable-alone ({sum(weights[g] for g in D)} vertices), {len(und)} undecided")
        if not D:
            log("  nothing is droppable even alone -- 1-MINIMAL"
                + (f" (with {len(und)} groups UNDECIDED at budget: a fixed point of the budget, "
                   "not of the mathematics)" if und else ""))
            S["critical"] = crit; S["ask"] = und; json.dump(S, open(ck, "w")); break
        res = phase2(base, keep, D, f"{a.dir}/r{r}p2", a.seeds, a.budget, log, weights)
        ok = [x for x in res if x.get("dropped")]
        if not ok:
            log("  phase2 dropped nothing, though phase1 says something is droppable alone -- "
                "this cannot happen unless a budget intervened; stopping and reporting it")
            S["critical"] = crit; S["ask"] = D + und; json.dump(S, open(ck, "w")); break
        best = max(ok, key=lambda x: sum(weights[g] for g in x["dropped"]))
        keep = set(best.get("keep", sorted(keep - set(best["dropped"]))))
        spread = sorted(x.get("weight_keep", sum(weights[g] for g in keep)) for x in ok)
        log(f"    phase2 best: order {best['seed']} dropped {len(best['dropped'])} groups / "
            f"{sum(weights[g] for g in best['dropped'])} vertices; "
            f"final weights across {len(ok)} orders: {spread}")
        und_asks = sum(x.get("undecided_asks", 0) for x in ok)
        if und_asks:
            log(f"    {und_asks} asks ran out of budget across the orders -- those runs are fixed "
                f"points of the BUDGET, not of the mathematics")
        S["history"].append(dict(round=r, phase1=s1, dropped=best["dropped"],
                                 spread=spread, weight_after=sum(weights[g] for g in keep)))
        S["keep"] = sorted(keep)
        S["critical"] = sorted((set(crit) | set(best.get("witnessed", []))) & keep)
        S["ask"] = sorted((set(und) & keep) - set(S["critical"]))
        S["round"] = r + 1
        json.dump(S, open(ck, "w"))
        log(f"  ROUND {r} end: keep {len(keep)} groups / {sum(weights[g] for g in keep)} vertices")
    kw = sum(weights[g] for g in S["keep"])
    log(f"FINAL: {len(S['keep'])} groups / {kw} vertices (+1 hard centre = {kw+1})")
    log(f"  LOWER BOUND from permanent witnesses: {sum(weights[g] for g in S['critical'])} vertices "
        f"over {len(S['critical'])} groups")
    json.dump(S, open(f"{a.dir}/final.json", "w"), indent=1)


if __name__ == "__main__":
    main()
