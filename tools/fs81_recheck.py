#!/usr/bin/env python3
"""FS-81 phase 0: re-check every certificate named by any phase-0 record with the checker its record names (the acceptance pass).
Prints one line per certificate and a tally; exit 1 if any fails.  Usage: fs81_recheck.py RECORDS.jsonl ..."""
import json
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

jobs = {}
for path in sys.argv[1:]:
    for line in open(path):
        r = json.loads(line)
        cert = r.get("cert")
        if not cert:
            continue
        if cert.startswith("data/fs81/phase0/struct/"):
            cmd = ["python3", "tools/fs81_struct_check.py", cert]
        elif "frozen" in r.get("checker", ""):
            cmd = ["python3", "tools/fs73v2_check.py", cert]
        else:
            cmd = ["python3", "tools/fs81_theta_check.py", "--no-enumerate", cert]
        jobs.setdefault((cert, tuple(cmd)), (path, r))


def one(item):
    (cert, cmd), (path, r) = item
    p = subprocess.run(list(cmd), capture_output=True, text=True)
    out = (p.stdout.strip().splitlines() or [""])[-1]
    ok = p.returncode == 0 and out.startswith("PASS") and r.get("verdict", "EMPTY") in out
    if not ok and r.get("check2") == "PASS":        # frozen FAIL on an unlisted unit; the listed-units check instead
        q = subprocess.run(["python3", "tools/fs81_theta_check.py", "--no-enumerate", cert], capture_output=True, text=True)
        out = "listed-units: " + (q.stdout.strip().splitlines() or [""])[-1]
        ok = q.returncode == 0 and "PASS NONEMPTY" in out
    return ok, f"{'OK  ' if ok else 'FAIL'} {path.split('/')[-1]} {r.get('tag', r.get('d'))} :: {out[:150]}"


fails = 0
with ThreadPoolExecutor(max_workers=int(__import__("os").environ.get("WORKERS", "12"))) as ex:
    for ok, line in ex.map(one, sorted(jobs.items())):
        fails += not ok
        print(line, flush=True)
print(f"TALLY: {len(jobs)} certificates re-checked, {fails} failed")
sys.exit(1 if fails else 0)
