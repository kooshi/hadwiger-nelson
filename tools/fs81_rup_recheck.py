#!/usr/bin/env python3
"""fs81_rup_recheck -- the second, independently written RUP check for a stage-D refusal (plan S.D, K2's row: "a D refusal's proof is
also checked by a second, independently written RUP checker").  K2 (tools/fs81_check_witness_k.py) has no positive control at k = 4 in
its class, so its LRAT routine (a copy of fs58's) is not trusted alone for a D refusal.

What it does, for WITNESS.json and PROOF.lrat[.gz]:
  1. asks K2 to write the CNF it builds from the witness (--write-cnf); K2 must CERTIFY, and its CNF sha256 is recorded;
  2. runs cake_lpr -- the CakeML-verified LRAT/LPR checker (Tan, Heule, Myreen; built from github.com/tanyongkiam/cake_lpr at commit
     a36874a, cake_lpr.S sha256 2f3af32d...; the binary at ~/source/cake_lpr/cake_lpr) -- on that CNF and the uncompressed proof, and
     requires its line 's VERIFIED UNSAT';
  3. runs kissat (a second solver, a different code base from the CaDiCaL that wrote the proof) on the same CNF and requires
     's UNSATISFIABLE'.
It shares the CNF with K2 on purpose (the formula is K2's statement); what it adds is an independently written and formally verified
proof check and an independent refutation.

Usage:
  fs81_rup_recheck.py WITNESS.json [PROOF] [--kissat-wall S]  -> RECHECKED (exit 0) or NOT RECHECKED <why> (exit 1)
  fs81_rup_recheck.py --selftest                              -> the faithful fixture and two plants (a proof for another formula; a
                                                                 truncated proof) must each be told apart
"""
import gzip
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
CAKE = os.path.expanduser('~/source/cake_lpr/cake_lpr')
K2 = os.path.join(HERE, 'fs81_check_witness_k.py')


def recheck(wpath, ppath, kissat_wall=3600):
    tmp = tempfile.mkdtemp(prefix='fs81-rup-')
    try:
        cnf = os.path.join(tmp, 'k2.cnf')
        r = subprocess.run([sys.executable, K2, wpath, ppath, '--write-cnf', cnf], capture_output=True, text=True)
        k2line = (r.stdout.strip().splitlines() or [''])[0]
        if r.returncode != 0 or not k2line.startswith('CERTIFIED'):
            return False, f'K2 did not certify: {k2line[:200]}', {}
        with open(cnf, 'rb') as f:
            csha = hashlib.sha256(f.read()).hexdigest()
        proof = os.path.join(tmp, 'proof.lrat')
        with open(ppath, 'rb') as f:
            gz = f.read(2) == b'\x1f\x8b'
        with (gzip.open(ppath, 'rb') if gz else open(ppath, 'rb')) as f, open(proof, 'wb') as g:
            shutil.copyfileobj(f, g)
        t0 = time.time()
        c = subprocess.run([CAKE, cnf, proof], capture_output=True, text=True)
        cake_s = round(time.time() - t0, 2)
        cake_line = next((ln.strip() for ln in c.stdout.splitlines() if ln.startswith('s ')), (c.stdout + c.stderr).strip()[-200:])
        info = {'cnf_sha256': csha, 'cake_lpr': cake_line, 'cake_lpr_s': cake_s}
        if cake_line != 's VERIFIED UNSAT':
            return False, f'cake_lpr did not verify: {cake_line!r}', info
        t0, ru0 = time.time(), os.times()
        try:
            kz = subprocess.run(['kissat', '-q', cnf], capture_output=True, text=True, timeout=kissat_wall)
            ks = next((ln.strip() for ln in kz.stdout.splitlines() if ln.startswith('s ')), '(no status line)')
        except subprocess.TimeoutExpired:
            ks = f'(the wall fired at {kissat_wall} s)'
        ru1 = os.times()
        info.update({'kissat': ks, 'kissat_cpu_s': round(ru1.children_user - ru0.children_user + ru1.children_system - ru0.children_system, 2)})
        if ks != 's UNSATISFIABLE':
            return False, f'kissat did not refuse: {ks!r}', info
        return True, 'ok', info
    finally:
        shutil.rmtree(tmp)


def selftest():
    fails = []
    fx = os.path.join(ROOT, 'data', 'fs81', 'phaseD', 'k2-fixtures', 'xa-core-edge-prec')
    ok, why, info = recheck(os.path.join(fx, 'witness.json'), os.path.join(fx, 'witness.lrat.gz'))
    print(f'  [{"PASS" if ok else "FAIL"}] faithful: X_A core, unit-edge pin + chain [2, 3]: {why} {info}', flush=True)
    fails += [] if ok else ['faithful']
    # plant 1: a proof for another formula -- cake_lpr run directly on fixture (b)'s CNF with FS-58's Q(sqrt11) k = 3 proof
    tmp = tempfile.mkdtemp(prefix='fs81-rup-st-')
    cnf = os.path.join(tmp, 'b.cnf')
    subprocess.run([sys.executable, K2, os.path.join(fx, 'witness.json'), '--write-cnf', cnf], capture_output=True, text=True)
    other = os.path.join(tmp, 'other.lrat')
    with gzip.open(os.path.join(ROOT, 'data', 'fs58', 'witness-11', 'witness.lrat.gz'), 'rb') as f, open(other, 'wb') as g:
        shutil.copyfileobj(f, g)
    c = subprocess.run([CAKE, cnf, other], capture_output=True, text=True)
    line = next((ln.strip() for ln in c.stdout.splitlines() if ln.startswith('s ')), (c.stdout + c.stderr).strip()[-160:])
    ok = line != 's VERIFIED UNSAT'
    print(f'  [{"PASS" if ok else "FAIL"}] plant: another formula\'s proof: cake_lpr says {line!r} (must not verify)', flush=True)
    fails += [] if ok else ['other proof']
    # plant 2: the faithful proof truncated to its first half
    with gzip.open(os.path.join(fx, 'witness.lrat.gz'), 'rb') as f:
        body = f.read().split(b'\n')
    half = os.path.join(tmp, 'half.lrat')
    with open(half, 'wb') as g:
        g.write(b'\n'.join(body[:len(body) // 2]) + b'\n')
    c = subprocess.run([CAKE, cnf, half], capture_output=True, text=True)
    line = next((ln.strip() for ln in c.stdout.splitlines() if ln.startswith('s ')), (c.stdout + c.stderr).strip()[-160:])
    ok = line != 's VERIFIED UNSAT'
    print(f'  [{"PASS" if ok else "FAIL"}] plant: the proof truncated to half: cake_lpr says {line!r} (must not verify)', flush=True)
    fails += [] if ok else ['truncated']
    shutil.rmtree(tmp)
    print(f'SELFTEST {"ALL PASS" if not fails else "FAILED: " + ", ".join(fails)}')
    return 1 if fails else 0


def main():
    a = sys.argv[1:]
    if a == ['--selftest']:
        return selftest()
    wall = 3600
    if '--kissat-wall' in a:
        i = a.index('--kissat-wall')
        wall = float(a[i + 1])
        del a[i:i + 2]
    if not a:
        print(__doc__)
        return 2
    w = a[0]
    p = a[1] if len(a) > 1 else os.path.join(os.path.dirname(os.path.abspath(w)), 'witness.lrat.gz')
    ok, why, info = recheck(w, p, wall)
    print(('RECHECKED: K2 certified; cake_lpr (verified) says s VERIFIED UNSAT; kissat refuses the same CNF. ' if ok else f'NOT RECHECKED: {why}. ')
          + json.dumps(info))
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
