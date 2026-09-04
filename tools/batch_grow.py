#!/usr/bin/env python3
"""batch_grow — grow the iteration's batch from the cheapest cheats, one fresh enumeration per step,
with the put-back identity as the control (M53 §B D4, §Bʺ.6, phase E1 / the phase-D batch B₀).

    python3 tools/batch_grow.py --edges build/m51-edges-<label>.json --spectrum data/m53/spectrum-<label>.json \
        --out build/m53-batch/<label> --target 20000 [--max-batch 12] [--start u-v,…] [--exclude u-v,…] \
        [--threads 8 --conflicts 40000000 --wall 30m] [--result data/m53/batch-<label>.json]
    python3 tools/batch_grow.py --self-test

The single-cheat spectrum (`tools/cheat_spectrum.py`) ranks the standing cheats by their own class
count; the joint count of a batch is NOT a function of the singles (a colouring may violate several
batch cheats at once), so the batch is grown incrementally — add the next-cheapest cheat, enumerate
the joint stage FRESH, stop before the count passes the target — and each step is checked against the
singles by the put-back identity: for every batch cheat e whose single run is exact, the lines of the
joint list proper on batch∖{e} are exactly S_e as orbits (properness is palette-invariant; the WO-8
filter iteration 4 verified at 37,316 = 37,316), so their count must EQUAL the spectrum's count for e.
Two independent runs, one identity, no solving; a mismatch is an enumerator fault and halts the growth.
Only cheats the spectrum found NECESSARY are candidates by default (droppable-alone ones are the cull's
candidates first; unknown ones are spendable but are offered only with --include-unknown). Re-running
resumes: a step whose directory already claims exact is read, not re-run. UNTRUSTED like all of
tools/; the batch's list is adopted separately by `tools/adopt_rust_list.py`."""
from __future__ import annotations
import argparse, json, subprocess, sys, tempfile, time
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
ENGINE = Path.home() / "source/descent-engine/target/release/descent"


def digits(s: str) -> np.ndarray:
    return np.frombuffer(s.encode(), dtype=np.uint8) - 48


def putback_counts(lines: list[str], batch: list[tuple[int, int]]) -> dict[tuple[int, int], int]:
    """For each e ∈ batch: the number of lines proper on every batch cheat except e (= |S_e| when the
    list is exact). One boolean per (line, cheat); a line violating exactly {e} counts for e."""
    if not lines:
        return {e: 0 for e in batch}
    us = np.array([u for u, _ in batch]); vs = np.array([v for _, v in batch])
    out = {e: 0 for e in batch}
    for lo in range(0, len(lines), 8192):
        C = np.stack([digits(x) for x in lines[lo:lo + 8192]])
        viol = (C[:, us] == C[:, vs])                       # True where the line is mono on the cheat
        nviol = viol.sum(axis=1)
        for j, e in enumerate(batch):
            out[e] += int(((nviol == 1) & viol[:, j]).sum())
    return out


def enumerate_stage(engine: Path, edges: Path, out: Path, batch, threads: int, conflicts: int, wall: str, max_classes: int):
    out.mkdir(parents=True, exist_ok=True)
    summ_p = out / "enumerate.json"
    if summ_p.exists():
        s = json.loads(summ_p.read_text())
        if s.get("claim") == "exact" and not s.get("open"):
            return s, True
    cmd = [str(engine), "enumerate", "--edges", str(edges), "--out", str(out), "--floor", ",".join(f"{u}-{v}" for u, v in batch),
           "--threads", str(threads), "--max-classes", str(max_classes), "--conflicts", str(conflicts), "--wall", wall, "--no-color"]
    with (out / "run.log").open("a") as log:
        log.write(f"# {time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())} {' '.join(cmd)}\n"); log.flush()
        subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT)
    if not summ_p.exists():
        raise SystemExit(f"[batch] the engine wrote no summary for {out} — see {out / 'run.log'}")
    return json.loads(summ_p.read_text()), False


def read_lines(out: Path) -> list[str]:
    lines = (out / "classes.jsonl").read_text().splitlines()
    return [x for x in (json.loads(l) for l in lines[1:] if l.strip()) if isinstance(x, str)]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--edges"); ap.add_argument("--spectrum"); ap.add_argument("--out")
    ap.add_argument("--target", type=int, default=20000); ap.add_argument("--max-batch", type=int, default=12)
    ap.add_argument("--start", default=None); ap.add_argument("--exclude", default=None); ap.add_argument("--include-unknown", action="store_true")
    ap.add_argument("--threads", type=int, default=8); ap.add_argument("--conflicts", type=int, default=40_000_000)
    ap.add_argument("--wall", default="30m"); ap.add_argument("--engine", default=str(ENGINE)); ap.add_argument("--result", default=None)
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    t0 = time.time()
    sp = json.loads(Path(a.spectrum).read_text())
    side = json.loads(Path(a.edges).read_text())
    assert sp["conditioning"]["fingerprint_removed"] == side["fingerprint_removed"], "the spectrum is over another stage than this sidecar"
    parse = lambda s: [tuple(int(x) for x in e.split("-")) for e in s.split(",") if e]
    excl = set(parse(a.exclude)) if a.exclude else set()
    recs = {tuple(r["cheat"]): r for r in sp["cheats"]}
    # cheapest first: EXACT singles by count, then the open/capped ones by their (lower-bound) count —
    # a witnessed cheat whose run found no class within the wall is hard, not cheap, and sorts last
    nec = [r for r in sp["cheats"] if r["verdict"] == "necessary"]
    order = [tuple(r["cheat"]) for r in sorted((r for r in nec if r["claim"] == "exact"), key=lambda r: (r["count"], r["cheat"]))]
    order += [tuple(r["cheat"]) for r in sorted((r for r in nec if r["claim"] != "exact"), key=lambda r: (r["count"] == 0, r["count"], r["cheat"]))]
    if a.include_unknown:
        order += [tuple(r["cheat"]) for r in sp["cheats"] if r["verdict"] == "unknown"]
    order = [e for e in order if e not in excl]
    batch = parse(a.start) if a.start else []
    for e in batch:
        assert e in recs, f"--start names {e}, which the spectrum did not examine"
    order = [e for e in order if e not in set(batch)]
    steps = []; chosen = None; chosen_dir = None
    print(f"[batch] {side['object']}: {len(order)} candidates (cheapest first: "
          f"{', '.join(f'{u}-{v}:{recs[(u, v)]['count']}' for u, v in order[:8])}…); target {a.target:,} classes, max batch {a.max_batch}", flush=True)
    while len(batch) < a.max_batch and order:
        nxt = order.pop(0); trial = batch + [nxt]
        d = Path(a.out) / f"step{len(steps):02d}-b{len(trial)}"
        ts = time.time()
        s, resumed = enumerate_stage(Path(a.engine), Path(a.edges), d, trial, a.threads, a.conflicts, a.wall, max_classes=max(4 * a.target, 20000))
        exact = s.get("claim") == "exact" and not s.get("open")
        count = int(s.get("classes", 0))
        step = {"batch": [list(e) for e in trial], "added": list(nxt), "single_count": recs[nxt]["count"], "single_claim": recs[nxt]["claim"],
                "classes": count, "claim": "exact" if exact else s.get("claim"), "seconds": round(time.time() - ts, 1), "resumed": resumed, "dir": str(d)}
        if exact:
            lines = read_lines(d)
            pb = putback_counts(lines, trial)
            checks = {}
            for e in trial:
                r = recs[e]
                if r["claim"] == "exact":
                    checks[f"{e[0]}-{e[1]}"] = {"putback": pb[e], "spectrum": r["count"], "ok": pb[e] == r["count"]}
                    if pb[e] != r["count"]:
                        step["identity"] = checks; steps.append(step); write(a, side, sp, steps, None, None, t0)
                        raise SystemExit(f"[batch] ENUMERATOR FAULT: put-back count for {e} is {pb[e]} but the spectrum says {r['count']} "
                                         f"(both exact) — the put-back identity failed at step {len(steps) - 1}; halting")
                else:
                    checks[f"{e[0]}-{e[1]}"] = {"putback": pb[e], "spectrum": f"≥ {r['count']} ({r['claim']})", "ok": pb[e] >= r["count"]}
            step["identity"] = checks
        steps.append(step)
        print(f"[batch] step {len(steps) - 1}: +{nxt[0]}-{nxt[1]} (single {recs[nxt]['count']} {recs[nxt]['claim']}) → batch {len(trial)}: "
              f"{count:,} classes {step['claim']} in {step['seconds']} s"
              f"{'; put-back identity ' + ('OK' if all(c['ok'] for c in step.get('identity', {}).values()) else 'FAILED') + f' on {len(step.get('identity', {}))} cheats' if exact else ''}", flush=True)
        if not exact or count > a.target:
            print(f"[batch] stop: {'not exact' if not exact else f'{count:,} > target {a.target:,}'}; the batch is the previous step's ({len(batch)} cheats)", flush=True)
            break
        batch, chosen, chosen_dir = trial, trial, d
    write(a, side, sp, steps, chosen, chosen_dir, t0)


def write(a, side, sp, steps, chosen, chosen_dir, t0):
    last = next((s for s in reversed(steps) if s["claim"] == "exact" and s["batch"] == [list(e) for e in (chosen or [])]), None)
    res = {"kind": "batch-grow", "label": side["object"], "fingerprint_removed": side["fingerprint_removed"], "target": a.target,
           "batch": [list(e) for e in (chosen or [])], "classes": last["classes"] if last else None, "list": str(chosen_dir / "classes.jsonl") if chosen_dir else None,
           "steps": steps, "spectrum": a.spectrum, "seconds": round(time.time() - t0, 1),
           "headline": (f"{side['object']}: batch of {len(chosen)} cheats {','.join(f'{u}-{v}' for u, v in chosen)} at {last['classes']:,} classes (exact), "
                        f"grown in {len(steps)} steps against target {a.target:,}; put-back identity held on every exact single" if chosen else
                        f"{side['object']}: NO batch under the target {a.target:,} — the cheapest cheat alone overshoots or is not exact"),
           "claim_scope": "each step's list is exact by the enumerator's V1–V3; the put-back identity compares orbit counts across two "
                          "independent runs; the batch is an OFFER — the profile and hitting set decide what is committed"}
    rp = Path(a.result) if a.result else ROOT / "data" / "m53" / f"batch-{side['object']}.json"
    rp.parent.mkdir(parents=True, exist_ok=True); rp.write_text(json.dumps(res, indent=1))
    print(f"[batch] {res['headline']}\n[batch] wrote {rp}", flush=True)


def self_test():
    # a synthetic list over 4 vertices and a batch of 2 cheats: lines violating exactly {e} count for e
    batch = [(0, 1), (2, 3)]
    lines = ["0011", "0101", "0110", "0011", "1100", "0123", "0120"]
    #  0011: v(0,1)? 0==0 yes; v(2,3)? 1==1 yes → both → counts for neither
    #  0101: (0,1) 0≠1 no; (2,3) 0≠1 no → neither
    #  0110: (0,1) no; (2,3) 1≠0 no → neither
    #  1100: both → neither; 0123: neither; 0120: (2,3) 2≠0 no; (0,1) 0≠1 no
    pb = putback_counts(lines, batch)
    assert pb == {(0, 1): 0, (2, 3): 0}, pb
    lines2 = lines + ["0012", "0022", "1234"]   # 0012: (0,1) yes, (2,3) 1≠2 no → e=(0,1); 0022: both; 1234: neither
    pb = putback_counts(lines2, batch)
    assert pb == {(0, 1): 1, (2, 3): 0}, pb
    lines3 = lines2 + ["0233", "1233"]           # 0233: (0,1) 0≠2 no, (2,3) yes → e=(2,3); 1233: same
    pb = putback_counts(lines3, batch)
    assert pb == {(0, 1): 1, (2, 3): 2}, pb
    print("[batch self-test] put-back counts: lines violating exactly one batch cheat are counted for it and only it; all green")


if __name__ == "__main__":
    main()
