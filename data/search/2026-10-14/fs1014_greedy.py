#!/usr/bin/env python3
"""fs1014_greedy -- SEARCH-2026-10-14: grow the solve basis J of FS-66's relaxation one distance class at a time,
keeping at each step the class whose addition gives the smallest float reading, until the reading is below the target.

Untrusted: every number it reports is a float reading of fs1014_cert_make.py --no-round. Each solve's result is
appended to RESULTS (one JSON line, keyed by p and the variant); a relaunch with the same arguments re-reads it and
re-runs nothing already there, so if this process dies the relaunch redoes at most the solves in flight.

usage: fs1014_greedy.py P TARGET START EXTRA_ARGS... [--par N]
   e.g. fs1014_greedy.py 11 30.20 phi0,sq --par 4
"""
import json, os, re, subprocess, sys, time
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
PY = os.path.expanduser('~/venvs/fs66/bin/python')
args = sys.argv[1:]
par = 4
if '--par' in args:
    i = args.index('--par'); par = int(args[i + 1]); del args[i:i + 2]
p, target, start = int(args[0]), float(args[1]), args[2].split(',')
extra = args[3:]
SUF = ''.join(e.replace('-', '') for e in extra if '/' not in e)
RESULTS = os.path.join(HERE, 'runs', f'greedy-p{p}{SUF}.jsonl')
classes = [str(d) for d in range(1, p)]
done = {}
if os.path.exists(RESULTS):
    for line in open(RESULTS):
        r = json.loads(line); done[r['keep']] = r
    print(f'RESUMED: {len(done)} solves already in {RESULTS}', flush=True)


def keystr(J):
    order = {'phi0': -2, 'sq': -1}
    return ','.join(sorted(J, key=lambda c: order.get(c, int(c) if c.isdigit() else 0)))


def solve(J):
    k = keystr(J)
    if k in done:
        return done[k]
    tag = k.replace(',', '-')
    log = os.path.join(HERE, 'runs', f'p{p}-{tag}{SUF}.log')
    t0 = time.monotonic()
    with open(log, 'w') as f:
        rc = subprocess.run([PY, os.path.join(HERE, 'fs1014_cert_make.py'), str(p), '--fast', '--build-jobs', '1',
                             '--threads', '1', '--keep', k, '--no-round'] + extra, stdout=f, stderr=subprocess.STDOUT).returncode
    txt = open(log).read()
    m = re.search(r'FLOAT READING .*?value ([0-9.]+) \(dual ([0-9.]+)\), status (.*?), (\d+) iterations', txt)
    if rc != 0 or not m:
        raise SystemExit(f'solve {k} exited {rc} with no reading; log {log} -- halting (an unexplained failure is not retried)')
    r = dict(p=p, keep=k, nJ=None, value=float(m.group(1)), dual=float(m.group(2)), status=m.group(3),
             iterations=int(m.group(4)), wall_s=round(time.monotonic() - t0, 1), extra=extra, log=os.path.relpath(log, HERE))
    mm = re.search(r'solve basis \|J\| = (\d+)', txt)
    r['nJ'] = int(mm.group(1)) if mm else None
    with open(RESULTS, 'a') as f:
        f.write(json.dumps(r) + '\n')
    done[k] = r
    return r


J = list(start)
cur = solve(J)
print(f'start {keystr(J)}: {cur["value"]:.6f} (|J| = {cur["nJ"]})', flush=True)
while cur['value'] >= target:
    rest = [c for c in classes if c not in J]
    if not rest:
        print('every class added; target not reached', flush=True)
        break
    with ThreadPoolExecutor(par) as ex:
        res = list(ex.map(lambda c: (c, solve(J + [c])), rest))
    for c, r in sorted(res, key=lambda cr: cr[1]['value']):
        print(f'   + {c:>3}: {r["value"]:.6f}  ({r["iterations"]} it, {r["wall_s"]} s)', flush=True)
    c, cur = min(res, key=lambda cr: cr[1]['value'])
    J.append(c)
    print(f'step: {keystr(J)} -> {cur["value"]:.6f} (|J| = {cur["nJ"]})', flush=True)
print(f'FINAL {keystr(J)}: {cur["value"]:.6f} against target {target}', flush=True)
