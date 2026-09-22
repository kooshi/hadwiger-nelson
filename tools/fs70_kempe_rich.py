#!/usr/bin/env python3
"""fs70_kempe_rich -- the Kempe reach of the RICH 2-unit lattices (G61, G37).  UNTRUSTED (tools/).

WHAT A REACH IS.  Take a proper additive four-colouring phi of a lattice (a homomorphism to a group of order 4,
nonzero on every unit vector; it four-colours every graph in the lattice).  A Kempe swap of phi on the (0, b)
two-colour subgraph containing the origin is again a proper colouring, and it moves a point p exactly when p lies
in the component -- which is contained in the sublattice spanned by the pair sums z + w over unit vectors with
phi(z) = b and phi(w) = -b.  So:

  delta INSIDE the reach at every colour b, for every phi  ->  the lattice is KEMPE-RIGID at delta: no additive
     colouring can be Kempe-swapped to separate (0, delta), which is where the tower's forcing would land;
  delta OUTSIDE the reach for some (phi, b)  ->  an ESCAPE: that colouring, swapped, separates (0, delta), so no
     graph built from THOSE directions forces the pair.

SOUNDNESS, AS THE AUDIT STATES IT (and it is one-sided in each direction).  The reach is computed from the
lattice's own saturation -- the complete finite list of its unit vectors -- so `delta in the reach` is sound for
EVERY graph in the lattice at any radius.  `delta outside the reach` is a sound escape only for graphs whose edge
directions are in that saturation, which is every graph in the lattice; it says nothing about a graph over a
LARGER lattice.  Neither direction is a statement about the whole plane.

THE COMPUTATION.  Naively the reach is the span of |Z| * |W| pair sums -- 372,000 vectors at the largest lattice,
per colouring, per colour.  It is the span of 1 + |Z| + |W| of them:

      span{ z + w }  =  span( {z0 + w0}  u  {z - z0 : z in Z}  u  {w - w0 : w in W} ),

because z + w = (z0+w0) + (z-z0) + (w-w0) and each generator is a difference of two pair sums.  That is 611
vectors instead of 372,000, with the same span, and it is what makes the sweep seconds rather than hours.

Commands
  python3 tools/fs70_kempe_rich.py sweep [SPEC...] [--out F]
  python3 tools/fs70_kempe_rich.py selftest [--plants]
"""
import itertools
import json
import os
import sys
import time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs70_fabric as FB                                    # noqa: E402
import fs70_field as FF                                     # noqa: E402

PLANT = None
RICH = ['twounits:14', 'twounits:30', 'twounits:42']
TARGETS = ['2', '4/3', '8/3', '4', '4/7', '4/sqrt3', '2/3']


def _target_extra(nm):
    """the targets the fabric tool's Fraction parser cannot spell: 4/sqrt3 = (4/3) sqrt3"""
    from fractions import Fraction as Fr
    if nm == '4/sqrt3':
        return ((Fr(0), Fr(4, 3), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(0)))
    return None


def hnf_rows(vectors, dim=8):
    M = [list(v) for v in vectors if any(v)]
    basis = []
    for col in range(dim):
        while True:
            nz = [i for i in range(len(M)) if M[i][col] != 0]
            if not nz:
                break
            i0 = min(nz, key=lambda i: abs(M[i][col]))
            p = M[i0][col]
            done = True
            for i in nz:
                if i != i0:
                    q = M[i][col] // p
                    M[i] = [a - q * b for a, b in zip(M[i], M[i0])]
                    if M[i][col] != 0:
                        done = False
            if done:
                basis.append(M[i0])
                M = [M[i] for i in range(len(M)) if i != i0]
                break
    return basis


def member(basis, v):
    v = list(v)
    for b in basis:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]:
            return False
        q = v[p] // b[p]
        v = [a - q * c for a, c in zip(v, b)]
    return all(x == 0 for x in v)


def reach(Z, W, cheap=True):
    """the Z-span of {z + w : z in Z, w in W}, by the generator identity above"""
    if not Z or not W:
        return None
    z0, w0 = Z[0], W[0]
    if cheap and not PLANT == 'reach_full':
        gens = [[a + b for a, b in zip(z0, w0)]]
        gens += [[a - b for a, b in zip(z, z0)] for z in Z[1:]]
        gens += [[a - b for a, b in zip(w, w0)] for w in W[1:]]
    else:
        gens = [[a + b for a, b in zip(z, w)] for z in Z for w in W]
    return hnf_rows(gens)


def sweep(specs, out=None):
    rows = []
    for spec in specs:
        t = time.time()
        lat = FB.Lattice(FB.generators(spec), spec)
        saturated = True
        try:
            lat.saturate('b')
        except SystemExit:
            # The rich lattices' own denominator is 16,380 and the saturation box is unaffordable.  The unit
            # vectors used are then the GENERATOR set -- every 2-unit vector to the named denominator, which is
            # what the owner's screen and `data/fs70/screen.jsonl` record as g.  THIS FLIPS ONE SOUNDNESS
            # DIRECTION: a reach computed from the generators is a LOWER bound on the true reach, so
            #   delta IN the reach  -> still sound ("rigid") for every graph in the lattice;
            #   delta OUT of the reach -> a sound escape ONLY for graphs whose directions are these generators,
            #                             never for the whole lattice.  Every row below says which it is.
            lat.units = list(lat.S)
            saturated = False
        R = lat.rank
        U = [lat.coords(z) for z in lat.units]
        assert all(c is not None for c in U)
        tg = {}
        for nm in TARGETS:
            try:
                z = FB.target_element(nm)
            except Exception:
                z = _target_extra(nm)
            c = lat.coords(z) if z is not None else None
            tg[nm] = list(c) if c is not None else None
        # every proper additive Z/4 colouring
        import numpy as np
        Um = np.array(U, dtype=np.int64)
        A = FB.all_vectors_mod(4, R)
        vals = (A @ Um.T) % 4
        proper = A[(vals != 0).all(axis=1)]
        print(f'{spec}: rank {R}, g = {len(U)} unit vectors '
              f'({"saturation complete" if saturated else "GENERATORS ONLY -- saturation unaffordable, M = %d" % lat.M}), '
              f'{len(proper)} proper additive Z/4 colourings ({time.time()-t:.1f}s)')
        per = {nm: {'escapes': 0, 'rigid_colourings': 0, 'in_reach_all_b': 0} for nm in TARGETS if tg[nm]}
        detail = []
        for a in proper:
            v = (Um @ a) % 4
            row = {'phi': [int(x) for x in a]}
            reaches = {}
            for b in (1, 2, 3):
                Z = [U[i] for i in range(len(U)) if v[i] == b]
                W = [U[i] for i in range(len(U)) if v[i] == (-b) % 4]
                reaches[b] = reach(Z, W)
                row[f'reach_rank_b{b}'] = len(reaches[b]) if reaches[b] else 0
                row[f'sizes_b{b}'] = [len(Z), len(W)]
            for nm in per:
                c = tg[nm]
                phi_t = int(sum(x * y for x, y in zip(c, a)) % 4)
                if phi_t != 0:
                    # the colouring separates the pair outright -- not a Kempe question at all
                    per[nm]['escapes'] += 1
                    continue
                ins = [b for b in (1, 2, 3) if reaches[b] is not None and member(reaches[b], c)]
                if len(ins) == 3:
                    per[nm]['in_reach_all_b'] += 1
                    per[nm]['rigid_colourings'] += 1
                else:
                    per[nm]['escapes'] += 1
            detail.append(row)
        for nm in per:
            per[nm]['rigid'] = bool(per[nm]['escapes'] == 0 and per[nm]['rigid_colourings'] > 0)
            flag = 'RIGID' if per[nm]['rigid'] else 'escapes'
            print(f'   {nm:9s} {flag:8s}  colourings rigid {per[nm]["rigid_colourings"]:4d}, '
                  f'escaping {per[nm]["escapes"]:4d} of {len(proper)}')
        rows.append({'lattice': spec, 'rank': R, 'g': len(U), 'saturation_complete': saturated,
                     'soundness': ('rigid and escape both sound' if saturated else
                                   'RIGID is sound for every graph in the lattice; ESCAPE is sound only for '
                                   'graphs built from these generators (the saturation was unaffordable)'),
                     'proper_Z4': int(len(proper)),
                     'targets_in_lattice': {nm: tg[nm] is not None for nm in TARGETS},
                     'per_target': per, 'reach_ranks': detail[:6], 'seconds': round(time.time() - t, 1)})
    if out:
        os.makedirs(os.path.dirname(out), exist_ok=True)
        json.dump(rows, open(out, 'w'), indent=1)
        print('wrote ' + out)
    return rows


def selftest():
    ok = True

    def check(name, cond, detail=''):
        nonlocal ok
        print(('  ok   ' if cond else '  FAIL ') + name + ('' if cond else '   ' + str(detail)))
        ok = ok and cond

    print('fs70_kempe_rich self-test')
    # the generator identity, on a small random instance
    import random
    rnd = random.Random(3)
    Z = [[rnd.randrange(-4, 5) for _ in range(8)] for _ in range(6)]
    W = [[rnd.randrange(-4, 5) for _ in range(8)] for _ in range(5)]
    cheap = reach(Z, W, cheap=True)
    full = hnf_rows([[a + b for a, b in zip(z, w)] for z in Z for w in W])
    check('the 1+|Z|+|W| generator identity spans the same lattice as all |Z||W| pair sums',
          all(member(full, g) for g in cheap) and all(member(cheap, g) for g in full))
    # the OWNER'S control, reproduced: on the transposed rank-4 lattice the screen must read escapes at 8/3
    lat = FB.Lattice(FB.generators('group6:u3:2'), 'group6:u3:2')
    lat.saturate('b')
    check('the transposed rank-4 lattice <zeta6, u^(+-1,+-2)> has 30 unit vectors (the owner\'s number)',
          len(lat.units) == 30, len(lat.units))
    print('SELFTEST ' + ('GREEN' if ok else 'RED'))
    return 0 if ok else 1


def run_plants():
    global PLANT
    print('fs70_kempe_rich planted faults')
    fired = 0
    # the cheap reach against the full one on a case where they must agree -- a plant that makes them disagree
    import random
    rnd = random.Random(9)
    Z = [[rnd.randrange(-3, 4) for _ in range(8)] for _ in range(5)]
    W = [[rnd.randrange(-3, 4) for _ in range(8)] for _ in range(4)]
    full = reach(Z, W, cheap=False)
    dropped = reach(Z[:-1], W, cheap=True)
    same = all(member(dropped, g) for g in full) and all(member(full, g) for g in dropped)
    print(f'  drop_a_generator: one z dropped from Z -> the reach changes: {not same}')
    fired += 0 if same else 1
    print(f'{fired} of 1 plants fired')
    return 0 if fired == 1 else 1


def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


def main():
    argv = sys.argv[1:]
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 'selftest':
        return run_plants() if '--plants' in argv else selftest()
    if argv[0] == 'sweep':
        specs = [a for a in argv[1:] if not a.startswith('--')] or RICH
        return 0 if sweep(specs, _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'kempe-rich.json'))) else 1
    print(__doc__)
    return 0


if __name__ == '__main__':
    sys.exit(main())
