#!/usr/bin/env python3
"""arm 2's control: the symmetry break must not turn a SATISFIABLE instance UNSATISFIABLE.

Bed: the k = 3 ball of `group:u3:2+w4` (95,389 points), which is SAT in 14.6 s and carries the SAME order-96
group and the SAME order-8 residual symmetry as the k = 4 ball.  Three checks and one plant:

  (A) orbit check, no solver: take a model of the UNBROKEN instance, build its 8-element orbit under the
      residual group, assert every member is a proper colouring carrying the pin, and assert that EXACTLY the
      members that are lex-least survive the break's condition.  Soundness is "at least one survives";
      effectiveness is "not all of them do".
  (B) the real run: kissat on base + break must return SAT, and the model must be proper, carry the pin, and
      satisfy the lex condition for all seven group elements -- which tests the ENCODING, not just the theory.
  (P) the plant `strict`: the same clauses with `a >= b` forbidden instead of `a > b`, so a colouring equal to
      its own image on the prefix is rejected too.  The lex-least member of an orbit fixed pointwise by some
      gamma is then rejected as well, and the instance must lose solutions.  A plant that does not fire has
      not been tested by passing.
"""
import json, os, subprocess, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f-w3'
PREFIX = 4096
PINS = [(0, 0), (25, 1), (27, 2)]
t0 = time.time()
pts, ind, ptr, meta = FP.load_cache(OUT, fast=False)
n = meta['n']
perms = FP.permutations_of(pts)
G = FP.close_group(perms, [g for g in ('zeta12', 'conj', 'gal3', 'gal5') if g in perms], n)
gamma = FP.residual_symmetry(G, PINS)
print(f'|G| = {len(G)}, residual = {len(gamma)} ({time.time()-t0:.0f}s)')

bmeta = json.load(open(f'{OUT}/base-meta.json'))
body, nv0, ncl = bmeta['body_path'], bmeta['variables'], bmeta['body_clauses']


def run(extra_path, extra_cl, extra_nv, budget=600):
    hdr = f'p cnf {nv0 + extra_nv} {ncl + extra_cl}'
    files = body if extra_path is None else f'{body} {extra_path}'
    sh = f"{{ printf '%s\\n' '{hdr}'; cat {files}; }} | kissat -q --time={budget}"
    p = subprocess.run(['bash', '-c', sh], capture_output=True, text=True)
    if p.returncode == 20:
        return 'UNSAT', None
    if p.returncode != 10:
        return f'UNKNOWN({p.returncode})', None
    lits = []
    for line in p.stdout.splitlines():
        if line.startswith('v '):
            lits += [int(x) for x in line[2:].split()]
    val = {abs(x): x > 0 for x in lits if x}
    C = np.full(n, -1, dtype=np.int8)
    for v in range(n):
        for c in range(4):
            if val.get(FP.var(v, c), False):
                C[v] = c
    return 'SAT', C


def proper(C):
    bad = 0
    for a in range(n):
        for j in range(ptr[a], ptr[a + 1]):
            b = int(ind[j])
            if b > a and C[a] == C[b]:
                bad += 1
    return bad


def lex_ok(C, q, pi):
    D = np.array([pi[int(C[int(q[i])])] for i in range(PREFIX)], dtype=np.int8)
    A = C[:PREFIX]
    for i in range(PREFIX):
        if A[i] != D[i]:
            return bool(A[i] < D[i])
    return True


# ---------------- (A) the orbit check
v, C0 = run(None, 0, 0)
assert v == 'SAT', f'the unbroken k=3 instance is {v}: the bed is wrong'
print(f'unbroken: SAT, {proper(C0)} monochromatic edges, pin = {[int(C0[x]) for x, _ in PINS]}')
survivors = 0
for q, pi in gamma:
    D = np.array([pi[int(C0[int(q[i])])] for i in range(n)], dtype=np.int8)
    assert proper(D) == 0, 'an orbit member is not a proper colouring'
    assert [int(D[x]) for x, _ in PINS] == [c for _, c in PINS], 'an orbit member breaks the pin'
    if all(lex_ok(D, q2, pi2) for q2, pi2 in gamma):
        survivors += 1
print(f'(A) orbit of size {len(gamma)}: every member proper and pinned; '
      f'{survivors} survive the break  -> sound={survivors >= 1}, effective={survivors < len(gamma)}')

# ---------------- (B) the real run
nontriv = [(q, pi) for q, pi in gamma
           if not (np.array_equal(q, np.arange(n)) and all(pi[c] == c for c in range(4)))]
cl, aux = FP.lex_leader_clauses(nontriv, PREFIX, 4 * n)
open(f'{OUT}/break.cnf', 'wb').write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cl).encode())
v, C1 = run(f'{OUT}/break.cnf', len(cl), aux)
ok = v == 'SAT' and proper(C1) == 0 and all(lex_ok(C1, q, pi) for q, pi in nontriv)
print(f'(B) broken: {v}; proper={None if C1 is None else proper(C1)}; '
      f'lex holds for all 7 = {None if C1 is None else all(lex_ok(C1, q, pi) for q, pi in nontriv)}  -> {"PASS" if ok else "FAIL"}')

# ---------------- (P) the plant
plant = []
nxt = 4 * n
for q, pi in nontriv:
    inv = {b: a for a, b in pi.items()}
    eq = None
    for i in range(PREFIX):
        si = int(q[i])
        if si == i and all(pi[c] == c for c in range(4)):
            continue
        pre = [] if eq is None else [-eq]
        for a in range(4):
            for b in range(a + 1):                      # PLANT: a >= b, not a > b
                plant.append(pre + [-FP.var(i, a), -FP.var(si, inv[b])])
        nxt += 1
        nq = nxt
        for c in range(4):
            plant.append(pre + [-FP.var(i, c), -FP.var(si, inv[c]), nq])
        if eq is not None:
            plant.append([-nq, eq])
        eq = nq
open(f'{OUT}/break-plant.cnf', 'wb').write(''.join(' '.join(map(str, c)) + ' 0\n' for c in plant).encode())
vp, _ = run(f'{OUT}/break-plant.cnf', len(plant), nxt - 4 * n)
print(f'(P) plant `strict`: {vp}  -> {"FIRED" if vp != "SAT" else "DID NOT FIRE"}')
json.dump({'group_order': len(G), 'residual': len(gamma), 'orbit_survivors': survivors,
           'unbroken': 'SAT', 'broken': v, 'plant_strict': vp,
           'break_clauses': len(cl), 'plant_clauses': len(plant),
           'seconds': round(time.time() - t0, 1)}, open(f'{OUT}/control.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
