#!/usr/bin/env python3
"""SEARCH-2026-10-03: a proof-free solver race on one CNF, bounded, every finish recorded as it happens.

Runs each configuration (kissat and cadical, several seeds and modes) as its own process group, WITHOUT proof output (a 20-minute
ASCII LRAT is tens of GB); the first SAT or UNSAT verdict stops the rest. The verdict is a measurement until certified: on UNSAT, the
winning cadical configuration is re-run with --lrat (cadical's search is deterministic for fixed options, seed and input); on SAT, the
model is written for the encoder's decoder. Each finished run appends one JSON line to OUT/race.jsonl at once, so a killed race
loses only the runs in flight (resume: re-run the command; finished configurations listed in race.jsonl are skipped).

Usage: python3 tools/search_20261003_portfolio.py CNF OUT --wall SECONDS [--configs N]
"""
import argparse
import json
import os
import signal
import subprocess
import sys
import time

CADICAL = os.path.expanduser("~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")
KISSAT = "/usr/bin/kissat"


def configs():
    out = []
    for seed in range(4):
        out.append((f"kissat-default-s{seed}", [KISSAT, f"--seed={seed}"]))
    for mode in ("sat", "unsat"):
        for seed in range(2):
            out.append((f"kissat-{mode}-s{seed}", [KISSAT, f"--{mode}", f"--seed={seed}"]))
    for seed in range(3):
        out.append((f"cadical-default-s{seed}", [CADICAL, f"--seed={seed}"]))
    for mode in ("sat", "unsat"):
        out.append((f"cadical-{mode}-s0", [CADICAL, f"--{mode}", "--seed=0"]))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("cnf")
    ap.add_argument("out")
    ap.add_argument("--wall", type=int, required=True)
    ap.add_argument("--configs", type=int, default=0)
    a = ap.parse_args()
    os.makedirs(a.out, exist_ok=True)
    rec = os.path.join(a.out, "race.jsonl")
    done = set()
    if os.path.exists(rec):
        for line in open(rec):
            done.add(json.loads(line)["name"])
    todo = [c for c in configs() if c[0] not in done]
    if a.configs:
        todo = todo[: a.configs]
    procs = {}
    t0 = time.time()
    for name, cmd in todo:
        log = open(os.path.join(a.out, name + ".log"), "w")
        p = subprocess.Popen(cmd + [a.cnf], stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        procs[name] = (p, log, cmd)
    with open(os.path.join(a.out, "race.pgids"), "w") as f:
        f.write("\n".join(f"{n} {p.pid}" for n, (p, _, _) in procs.items()) + "\n")
    print(f"race: {len(procs)} configurations on {a.cnf}, wall {a.wall} s, pgids in {a.out}/race.pgids", flush=True)
    winner = None
    while procs and time.time() - t0 < a.wall:
        for name in list(procs):
            p, log, cmd = procs[name]
            rc = p.poll()
            if rc is None:
                continue
            log.close()
            status = {10: "SATISFIABLE", 20: "UNSATISFIABLE"}.get(rc, f"rc={rc}")
            entry = {"name": name, "cmd": cmd + [a.cnf], "rc": rc, "status": status, "wall": round(time.time() - t0, 2)}
            with open(rec, "a") as f:
                f.write(json.dumps(entry) + "\n")
            print(f"finished: {entry}", flush=True)
            del procs[name]
            if rc in (10, 20):
                winner = entry
                break
            # an exit other than 10/20 before the wall is a crash of a solver: halt the race, report it
            print(f"HALT: {name} exited rc={rc} before the wall with no verdict (see {name}.log)", flush=True)
            winner = entry
            break
        if winner:
            break
        time.sleep(1)
    for name, (p, log, cmd) in procs.items():
        try:
            os.killpg(p.pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
    for name, (p, log, cmd) in procs.items():
        p.wait()
        log.close()
        entry = {"name": name, "cmd": cmd + [a.cnf], "rc": None, "status": "STOPPED", "wall": round(time.time() - t0, 2)}
        with open(rec, "a") as f:
            f.write(json.dumps(entry) + "\n")
    alive = [n for n, (p, _, _) in procs.items() if p.poll() is None]
    print(f"RACE END: winner={winner and winner['name']} status={winner and winner['status']} "
          f"wall={time.time() - t0:.1f}s stopped={len(procs)} still-alive-after-kill={alive}", flush=True)
    sys.exit(0 if winner and winner["rc"] in (10, 20) else (4 if winner else 3))


if __name__ == "__main__":
    main()
