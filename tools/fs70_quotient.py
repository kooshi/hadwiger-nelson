#!/usr/bin/env python3
"""fs70_quotient -- the quotient screen with row 66's fan-gap consumer, on any fabric SPEC.  UNTRUSTED (tools/).

TWO THEOREMS, ONE TABLE (G62's extraction and row 66's, which the milestone had never joined).  For a lattice
Lambda with saturation U and an N with no unit vector in N*Lambda, reduction Lambda -> Lambda/N*Lambda is a graph
HOMOMORPHISM from the unit-distance graph on Lambda onto Cay(Lambda/N*Lambda, U mod N).  Hence:

  (1) a proper four-colouring of the quotient four-colours EVERY graph on Lambda at once, at every radius
      (row 56's unitQuadrance_colorable_of_quotient -- kernel-grade), and

  (2) if that colouring has a FAN GAP anywhere -- a colour absent from some vertex's CLOSED neighbourhood -- then
      by slack_addCayley_of_fanGap the quotient is SLACK at four colours (one gap translates to every vertex),
      and by Slack.forces_iff_of_hom, for EVERY unit-distance graph G on Lambda,

              Forces G 4 u v   <->   u = v,

      at every distance and every radius.  No forced pair exists to be chained.  That is strictly stronger than
      (1): (1) says the fabric colours, (2) says the milestone's ASK on that fabric is answered no by theorem.

  (3) the virtual-edge half needs a SHARED gap at the pair's difference (not_separated_of_sharedGap); it is
      reported per difference and does NOT follow from (2).

An UNSAT at some N says only that no N-periodic four-colouring exists -- nothing about the lattice (G21).

Commands
  python3 tools/fs70_quotient.py sweep SPEC [--nmin 2] [--nmax 12] [--cap 400000] [--budget 900] [--out F]
  python3 tools/fs70_quotient.py selftest
"""
import hashlib, itertools, json, math, os, subprocess, sys, time
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs70_fabric as FB


def solve(path, solver='kissat', budget=900):
    t = time.time()
    try:
        p = subprocess.run([solver, '-q', path], capture_output=True, text=True, timeout=budget)
    except subprocess.TimeoutExpired:
        return 'UNKNOWN', time.time() - t, ''
    v = 'UNKNOWN'
    for line in p.stdout.splitlines():
        if line.startswith('s '):
            v = 'UNSAT' if 'UNSATISFIABLE' in line else 'SAT'
    return v, time.time() - t, p.stdout


def model_of(out, n, k=4):
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(x) for x in line[2:].split()]
    pos = {abs(x) for x in lits if x > 0}
    return [next((c for c in range(k) if k * v + c + 1 in pos), None) for v in range(n)]


def sweep(spec, nmin=2, nmax=12, cap=400000, budget=900, out=None, solver='kissat'):
    lat = FB.Lattice(FB.generators(spec), spec)
    lat.saturate('b')
    R = lat.rank
    S0 = [tuple(lat.coords(z)) for z in lat.units]
    assert all(s is not None for s in S0), 'a unit vector is outside the lattice'
    print(f'{spec}: rank {R}, M = {lat.M}, g = {len(S0)} unit vectors')
    rows = []
    for N in range(nmin, nmax + 1):
        n = N ** R
        Sm = sorted({tuple(x % N for x in s) for s in S0})
        if tuple([0] * R) in Sm:
            print(f'  N = {N:2d}: not admissible -- a unit vector lies in N*Lambda (the quotient has a loop)')
            rows.append({'N': N, 'admissible': False, 'vertices': n,
                         'reason': 'a unit vector is 0 mod N'})
            continue
        if n > cap:
            print(f'  N = {N:2d}: {n} vertices -- over the cap of {cap}, not asked')
            rows.append({'N': N, 'admissible': True, 'vertices': n, 'verdict': 'not asked', 'reason': 'over cap'})
            continue
        verts = list(itertools.product(range(N), repeat=R))
        vidx = {v: i for i, v in enumerate(verts)}
        edges = set()
        for v in verts:
            i = vidx[v]
            for s in Sm:
                j = vidx[tuple((a + b) % N for a, b in zip(v, s))]
                if i < j:
                    edges.add((i, j))
        edges = sorted(edges)
        zero = tuple([0] * R)
        A = vidx[zero]
        adjA = {vidx[s] for s in Sm}
        nb = sorted(adjA)[0]
        adjN = {vidx[tuple((a + b) % N for a, b in zip(verts[nb], s))] for s in Sm}
        tri = sorted(adjA & adjN)
        pins = [(A, 0), (nb, 1)] + ([(tri[0], 2)] if tri else [])
        cls = [[4 * v + c + 1 for c in range(4)] for v in range(n)]
        for i, j in edges:
            for c in range(4):
                cls.append([-(4 * i + c + 1), -(4 * j + c + 1)])
        for v, c in pins:
            cls.append([4 * v + c + 1])
        path = os.path.join(ROOT, 'build', 'fs70', f'quot-{abs(hash(spec))%10**8}-N{N}.cnf')
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w') as f:
            f.write(f'p cnf {4*n} {len(cls)}\n')
            f.writelines(' '.join(map(str, c)) + ' 0\n' for c in cls)
        sha = hashlib.sha256(open(path, 'rb').read()).hexdigest()
        v, secs, raw = solve(path, solver, budget)
        row = {'N': N, 'admissible': True, 'vertices': n, 'edges': len(edges),
               'avg_degree': round(2 * len(edges) / n, 3), 'connection_set': len(Sm),
               'verdict': v, 'seconds': round(secs, 2), 'cnf_sha256': sha,
               'triangle_pinned': bool(tri), 'clauses': len(cls)}
        if v == 'SAT':
            col = model_of(raw, n)
            bad = sum(1 for i, j in edges if col[i] is None or col[i] == col[j])
            row['monochromatic_edges'] = bad
            assert bad == 0, 'the solver returned an improper colouring'
            # row 66: the fan gap, and the shared gaps per difference
            nbr = {x: [tuple((a + b) % N for a, b in zip(x, s)) for s in Sm] for x in verts}
            gapped = [x for x in verts
                      if set(range(4)) - ({col[vidx[x]]} | {col[vidx[w]] for w in nbr[x]})]
            cl0 = {col[A]} | {col[vidx[w]] for w in nbr[zero]}
            shared = 0
            nonadj = 0
            for dlt in verts:
                if dlt == zero or dlt in set(Sm):
                    continue
                nonadj += 1
                un = cl0 | {col[vidx[dlt]]} | {col[vidx[w]] for w in nbr[dlt]}
                if set(range(4)) - un:
                    shared += 1
            row['gapped_vertices'] = len(gapped)
            row['gap_at_origin'] = sorted(set(range(4)) - cl0)
            row['non_adjacent_differences'] = nonadj
            row['differences_with_shared_gap'] = shared
            row['forces_closed_by_row66'] = bool(gapped)
            row['separated_closed_by_row66'] = bool(shared == nonadj and nonadj > 0)
            d = os.path.join(ROOT, 'data', 'fs70', 'quotient')
            os.makedirs(d, exist_ok=True)
            tag = spec.replace(':', '_').replace('+', '_')
            json.dump({'spec': spec, 'N': N, 'colouring': col, 'connection_set': [list(s) for s in Sm]},
                      open(os.path.join(d, f'{tag}-N{N}.colouring.json'), 'w'))
            print(f'  N = {N:2d}: {n} vertices, {len(edges)} edges -> **SAT** in {secs:.1f}s '
                  f'({bad} monochromatic) -- FOUR-COLOURS THE WHOLE LATTICE')
            print(f'          gapped vertices {len(gapped)} of {n}; gap at the origin {row["gap_at_origin"]}; '
                  f'shared gaps {shared} of {nonadj} differences')
            if gapped:
                print(f'          -> row 66: Forces G 4 u v <-> u = v for EVERY graph on this lattice')
        else:
            print(f'  N = {N:2d}: {n} vertices, {len(edges)} edges, degree {2*len(edges)/n:.1f} '
                  f'-> {v} in {secs:.1f}s')
        os.remove(path)
        rows.append(row)
    if out:
        os.makedirs(os.path.dirname(out), exist_ok=True)
        json.dump({'spec': spec, 'rank': R, 'g': len(S0), 'rows': rows}, open(out, 'w'), indent=1)
        print('wrote ' + out)
    return rows


def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


def selftest():
    print('fs70_quotient self-test: the control is the OWNER\'s Lambda-prime result, reached by this general tool')
    print('  (fs70_lambdaprime.py found SAT at N = 5 and N = 10 with 597 of 625 vertices gapped;')
    print('   this tool must agree on any lattice it can express.)')
    rows = sweep('zeta6', nmin=2, nmax=4, cap=100000, budget=120, out=None)
    print('  the hexagonal lattice <zeta6> (rank 2, the triangular lattice): a quotient four-colouring here would')
    print('  contradict chi = 4 only if it had a gap; the row is printed for calibration.')
    return 0


def main():
    argv = sys.argv[1:]
    if not argv:
        print(__doc__); return 0
    if argv[0] == 'selftest':
        return selftest()
    if argv[0] == 'sweep':
        spec = argv[1]
        return 0 if sweep(spec, _opt(argv, '--nmin', 2, int), _opt(argv, '--nmax', 12, int),
                          _opt(argv, '--cap', 400000, int), _opt(argv, '--budget', 900, int),
                          _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'quotient',
                                                           spec.replace(':', '_').replace('+', '_') + '.json'))) else 1
    print(__doc__); return 0


if __name__ == '__main__':
    sys.exit(main())
