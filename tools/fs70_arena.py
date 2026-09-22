#!/usr/bin/env python3
"""fs70_arena -- the type-M arena over F = Q(sqrt3, sqrt5): a base point set B plus its rotated copy R.B sharing
the centre, and G53's counting screen on it.  UNTRUSTED (tools/).

WHAT A TYPE-M ARENA IS (CLAUDE.md G7, G52, G53; M63 phases H2 and H3).  A rotation `R` with
`cos theta = (2n-1)/(2n)` has `|1 - R| = 1/sqrt(n)`, so a base point `v` and its image `Rv` are at distance 1
exactly when `|v| = sqrt(n)`: the arena `A = B union R.B` carries, besides each half's own edges, a family of
CROSS edges, and the DIAGONAL ones join `v` to `Rv` on the circle `|v| = sqrt(n)`.  Here `R = rho15 = (7 + i
sqrt15)/8`, which is `n = 4`: the diagonal circle is `|v| = 2`.

G53's COUNTING SCREEN, which needs no arena solve at all.  Any proper k-colouring `C` of the arena gives two
proper k-colourings of the base, `f(v) = C(v)` and `g(v) = C(Rv)`.  The shared centre forces `f(0) = g(0)`, and
each diagonal cross edge forces `f(v) != g(v)` on the circle.  So with `Bh = {circle v : h(v) = h(0)}` the sets
`B(f)` and `B(g)` are DISJOINT, and with `L = min_h |Bh|` over proper k-colourings `h` of the base alone,

      2 L > (circle count)   ==>   the arena is not k-colourable.

That is a property of the BASE, and `L` is an exact finite quantity: a minimisation over the base's proper
colourings, asked here as a SAT question with a cardinality constraint ("at most t circle points carry the
centre's colour") and a binary search.  An UNSAT at `t = floor(count/2)` is a refutation of the arena with no
arena instance ever built; a SAT exhibits a colouring and reports the ratio `L/count`, which is the number G53
asks for either way.  The criterion is SUFFICIENT, never necessary.

WHAT THE RATIO DOES NOT MEASURE (G52).  Where the circle is `t` times the unit shell for an EVEN integer `t` the
residue certificate's defeat is automatic and carries no information about the object.  Here the circle is
exactly `2 x (the base's unit vectors)` -- `t = 2` -- which is the record's own situation, so nothing about this
arena's four-colourability may be read off the circle's existence.

Commands
  python3 tools/fs70_arena.py circle SPEC k [--rot rho15]            # the base ball and its diagonal circle
  python3 tools/fs70_arena.py count  SPEC k [--rot rho15] [--tmax T] # G53's L by binary search, with its colouring
  python3 tools/fs70_arena.py build  SPEC k [--rot rho15] --out DIR  # the arena as a fabric graph.json
  python3 tools/fs70_arena.py --selftest [--plants]
options: --rot NAME (a family seed of fs70_fabric: rho15, u3, v4, ...), --colours K (default 4), --solver NAME
         (a PySAT solver, default cadical195), --budget S

Planted faults (--plant): circle_wrong (the circle is read at |v| = 1 instead of |v| = sqrt n, so the diagonal
cross edges it names are not edges), rot_not_unit (the rotation is scaled off the unit circle), cross_dropped
(the arena's cross edges are dropped, which makes the arena two disjoint halves and trivially colourable),
card_ignored (the cardinality bound is built and never added, so the binary search reads L = 0 on everything --
the plant for exactly the reading this tool returns on the real fabric).
"""
from fractions import Fraction as Fr
import hashlib
import json
import math
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_fabric as FB                                                         # noqa: E402
import fs70_field as FF                                                          # noqa: E402

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]

PLANTS = ('circle_wrong', 'rot_not_unit', 'cross_dropped', 'card_ignored')


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- the rotation and its circle

def rotation(name):
    """the rotation element, and the exact `n` with |1 - R|^2 = 1/n (so the diagonal circle is |v|^2 = n)"""
    if name not in FB.FAMILY_SEED:
        raise SystemExit(f'unknown rotation {name!r}; known: {", ".join(sorted(FB.FAMILY_SEED))}')
    R = FB.FAMILY_SEED[name]
    if planted('rot_not_unit'):
        R = (tuple(Fr(3, 2) * q for q in R[0]), tuple(Fr(3, 2) * q for q in R[1]))   # PLANT: off the unit circle
    if not FF.e_is_unit_vector(R):
        raise SystemExit(f'the rotation {name} is not a unit vector: {FF.e_str(R)}')
    d = FF.e_sub(FF.E_ONE, R)
    q = FF.e_normF(d)                                # |1 - R|^2, a field element
    if any(x != 0 for x in q[1:]):
        raise SystemExit(f'|1 - {name}|^2 = {q} is not rational: this rotation is not of type M')
    inv = Fr(1) / q[0]
    if inv.denominator != 1:
        raise SystemExit(f'|1 - {name}|^-2 = {inv} is not an integer: this rotation is not of type M')
    return R, int(inv)


def circle_points(keys, M, n):
    """the points of the base at |v|^2 = n -- the ones a diagonal cross edge joins to their own rotated image"""
    want = (Fr(1 if planted('circle_wrong') else n), Fr(0), Fr(0), Fr(0))   # PLANT: the wrong radius
    out = []
    for i, p in enumerate(keys):
        z = FF.e_from_ints(FF.ints_reduce(list(p), M))
        if FF.e_normF(z) == want:
            out.append(i)
    return out


# ---------------------------------------------------------------- the base

def base_ball(spec, k):
    lat = FB.Lattice(FB.generators(spec), spec)
    lat.saturate('b')
    pts = FB.word_ball(lat, k)
    keys, edges = FB.unit_graph(pts, lat)
    return lat, keys, edges


# ---------------------------------------------------------------- G53's counting screen

def min_share(n, edges, zero, circ, colours=4, solver='cadical195', tmax=None, verbose=True, label=''):
    """L = min over proper `colours`-colourings of |{v in circ : c(v) = c(zero)}|, by binary search on a
    cardinality constraint.  Graph-only, so the self-test can call it on a hand graph whose L is known both ways
    -- the instrument's UNSAT branch has to be SEEN to fire, and on the real fabric it never has."""
    from pysat.card import CardEnc, EncType
    from pysat.formula import IDPool
    from pysat.solvers import Solver
    cnt = len(circ)
    base_cl = FB.coloring_cnf(n, edges, colours, [(zero, 0)], precedence=True)
    nv = FB.cnf_nvars(n, colours, [(zero, 0)])
    lits = [FB.var(v, 0, colours) for v in circ]     # "this circle point carries the centre's colour"
    lo, hi = 0, cnt if tmax is None else min(cnt, tmax)
    best, trail = None, []
    while lo < hi:
        t = (lo + hi) // 2
        pool = IDPool(start_from=nv + 1)
        card = CardEnc.atmost(lits=lits, bound=t, vpool=pool, encoding=EncType.seqcounter)
        s = Solver(name=solver, bootstrap_with=base_cl)
        if not planted('card_ignored'):            # PLANT: the bound is never imposed, so L always reads 0
            for c in card.clauses:
                s.add_clause(c)
        t0 = time.time()
        sat = s.solve()
        el = time.time() - t0
        trail.append({'t': t, 'verdict': 'SAT' if sat else 'UNSAT', 'seconds': round(el, 2)})
        if verbose:
            print(f'   {label}at most {t:3d} of {cnt} circle points on the centre\'s colour: '
                  f'{"SAT" if sat else "UNSAT"}  ({el:.1f}s)')
        if sat:
            pos = {abs(x) for x in s.get_model() if x > 0}
            col = [next(c for c in range(colours) if FB.var(v, c, colours) in pos) for v in range(n)]
            share = [v for v in circ if col[v] == col[zero]]
            assert len(share) <= t, (f'the model puts {len(share)} circle points on the centre\'s colour while '
                                     f'the bound asked for at most {t}: the cardinality constraint is not '
                                     f'reaching the solver')
            bad = [(a, b) for a, b in edges if col[a] == col[b]]   # believed only after it is verified proper
            assert not bad, f'the model is not a proper colouring: {len(bad)} monochromatic edges'
            best = {'t': t, 'achieved': len(share), 'colouring': col}
            hi = len(share)
        else:
            lo = t + 1
        s.delete()
    return lo, best, trail


def count_screen(spec, k, rot='rho15', colours=4, solver='cadical195', tmax=None, verbose=True):
    """G53's counting screen on a real base: L against the diagonal circle count."""
    R, n = rotation(rot)
    lat, keys, edges = base_ball(spec, k)
    index = {p: i for i, p in enumerate(keys)}
    zero = index[tuple([0] * 8)]
    circ = circle_points(keys, lat.M, n)
    cnt = len(circ)
    if verbose:
        print(f'base {spec} at sums of <= {k}: {len(keys)} points, {len(edges)} edges, '
              f'avg degree {2*len(edges)/len(keys):.2f}')
        print(f'rotation {rot} = {FF.e_str(R)}: |1 - R|^2 = 1/{n}, so the diagonal circle is |v|^2 = {n}')
        print(f'diagonal circle: {cnt} points; G53 refutes the arena iff L > {cnt / 2}')
    if cnt == 0:
        raise SystemExit('the diagonal circle is EMPTY in this base: the arena has no diagonal cross edge and '
                         'G53 says nothing (grow the base, or the radius is wrong)')
    L, best, trail = min_share(len(keys), edges, zero, circ, colours, solver, tmax, verbose)
    return {'spec': spec, 'k': k, 'rot': rot, 'n': n, 'colours': colours,
            'points': len(keys), 'edges': len(edges), 'avg_degree': 2 * len(edges) / len(keys),
            'circle': cnt, 'L': L, 'ratio': L / cnt, 'refutes': 2 * L > cnt,
            'trail': trail, 'best': best, 'lattice_sha': lat.sha()}


# ---------------------------------------------------------------- the arena

def build_arena(spec, k, rot='rho15', out=None, geometric_check=True):
    """A = B union R.B, with the COMPLETE unit-distance graph on it: the arena lattice (the base lattice plus its
    R-image) is saturated, and every unit vector of it is stepped from every point.  The geometric derivation is
    run beside it as the independent control -- it can only MISS an edge, so agreement is evidence that the
    saturation is complete, and a disagreement is a defect in one of the two."""
    R, n = rotation(rot)
    lat, keys, edges = base_ball(spec, k)
    gens = list(lat.S) + [FF.e_mul(R, z) for z in lat.S]
    A = FB.Lattice(gens, f'arena({spec},{rot})')
    if A.sat_b_cost() > A.SAT_B_BOX_CAP:
        raise SystemExit(f'the arena lattice has denominator {A.M} and box cost {A.sat_b_cost():.3g}, above the '
                         f'cap {A.SAT_B_BOX_CAP:.3g}: its saturation is not affordable, so the complete '
                         f'unit-distance graph cannot be derived (a partial graph would make a COLOURING '
                         f'meaningless; only a refusal would stand)')
    t0 = time.time()
    A.saturate('b')
    # the two halves, as points of the arena lattice
    half0 = [FF.e_from_ints(FF.ints_reduce(list(p), lat.M)) for p in keys]
    half1 = [FF.e_mul(R, z) for z in half0]
    v0 = [A.vec8(z) for z in half0]
    v1 = [A.vec8(z) for z in half1]
    s0, s1 = set(v0), set(v1)
    akeys = list(dict.fromkeys(v0 + v1))
    akeys, aedges = FB.unit_graph(akeys, A)
    print(f'arena {spec} at sums of <= {k} with {rot}: {len(akeys)} points ({len(half0)} per half, '
          f'{len(s0 & s1)} shared), {len(aedges)} edges, avg degree '
          f'{2*len(aedges)/len(akeys):.2f}  ({time.time()-t0:.1f}s, arena lattice M = {A.M}, rank {A.rank}, '
          f'g = {len(A.units)})')
    # the CROSS edges -- the arena's whole compulsion budget (G31): an edge inside one half is an edge of that
    # half's own base graph and says nothing the base did not.  Of the cross edges the DIAGONAL ones (v -- Rv)
    # are the ones G53's counting argument uses; the rest are off-diagonal.
    inside = [akeys[i] in s0 and akeys[j] in s0 or akeys[i] in s1 and akeys[j] in s1 for i, j in aedges]
    cross = [e for e, ins in zip(aedges, inside) if not ins]
    idx = {p: i for i, p in enumerate(akeys)}
    eset = set(aedges)
    diag = sum(1 for a, b in zip(v0, v1)
               if a in idx and b in idx and tuple(sorted((idx[a], idx[b]))) in eset)
    anat = {'within_half0': sum(1 for i, j in aedges if akeys[i] in s0 and akeys[j] in s0),
            'within_half1': sum(1 for i, j in aedges if akeys[i] in s1 and akeys[j] in s1),
            'cross': len(cross), 'diagonal': diag, 'off_diagonal': len(cross) - diag,
            'shared_points': len(s0 & s1)}
    print(f'   cross edges: {anat["cross"]} of {len(aedges)} ({anat["diagonal"]} diagonal v--Rv, '
          f'{anat["off_diagonal"]} off-diagonal); within half 0: {anat["within_half0"]}, '
          f'within half 1: {anat["within_half1"]}')
    if planted('cross_dropped'):
        aedges = [e for e, ins in zip(aedges, inside) if ins]     # PLANT: the two halves left disjoint
        print(f'   [PLANT cross_dropped] {len(aedges)} edges left')
    if geometric_check:
        _, gedges, _ = FB.unit_graph_geometric(akeys, A)
        same = set(aedges) == set(gedges)
        print(f'   geometric control: {len(gedges)} edges, identical to the lattice derivation: {same}')
        if not same and not planted('cross_dropped'):
            raise SystemExit(f'the two edge derivations disagree: lattice {len(aedges)}, geometric '
                             f'{len(gedges)}, symmetric difference {len(set(aedges) ^ set(gedges))}')
    if out:
        FB.write_shape(out, A, akeys, aedges, {'shape': 'arena', 'k': k, 'rot': rot, 'n': n},
                       {'base_spec': spec, 'base_points': len(half0), 'cross_edges': anat}, cnfs_too=False)
    return A, akeys, aedges, anat


# ---------------------------------------------------------------- self-test

def selftest():
    # the rotation arithmetic, by hand: rho15 = (7 + i sqrt15)/8, 1 - rho15 = (1 - i sqrt15)/8, |.|^2 = 1/4
    R, n = rotation('rho15')
    assert n == 4, f'rho15 gives n = {n}, not the 4 of cos theta = 7/8 = (2n-1)/(2n)'
    # the spindle identity of G7: |1 - R| = 1/sqrt(n) and the circle is |v| = sqrt(n)
    d = FF.e_sub(FF.E_ONE, R)
    assert FF.e_normF(d) == (Fr(1, 4), Fr(0), Fr(0), Fr(0)), FF.e_normF(d)
    # a point on the circle really is at distance 1 from its own rotated image (the diagonal cross edge)
    two = FF.real_scalar(2)
    diff = FF.e_sub(two, FF.e_mul(R, two))
    assert FF.e_normF(diff) == (Fr(1), Fr(0), Fr(0), Fr(0)), \
        f'the point 2 is not at distance 1 from rho15 * 2: {FF.e_normF(diff)}'
    # a point OFF the circle is not
    diff1 = FF.e_sub(FF.E_ONE, FF.e_mul(R, FF.E_ONE))
    assert FF.e_normF(diff1) != (Fr(1), Fr(0), Fr(0), Fr(0))
    # the circle of the CM base is exactly 2 x its unit vectors (t = 2 in G52's sense), at every radius >= 2
    lat, keys, edges = base_ball('group6:u3:2', 2)
    circ = circle_points(keys, lat.M, 4)
    assert len(circ) == 30, f'the circle of group6:u3:2 holds {len(circ)} points, not 30'
    doubled = {lat.vec8(FF.e_scale(Fr(2), z)) for z in lat.units}
    assert {keys[i] for i in circ} == doubled, 'the circle is not exactly twice the unit-vector set'
    # G53's criterion is applied the right way round: with the circle count 30, a refutation needs L >= 16
    assert (2 * 15 > 30) is False and (2 * 16 > 30) is True

    # --- the counting instrument, on two hand graphs whose L is known BOTH WAYS.  On the real fabric the
    # search has only ever returned SAT, and a binary search that can never report UNSAT would read L = 0 on
    # every input; these two make each branch fire for its own reason.
    #   (a) centre 0 non-adjacent to a K4 on the circle {1,2,3,4}: the four take four distinct colours, so
    #       EXACTLY one carries the centre's -- L = 1, so "at most 0" must be UNSAT and "at most 1" SAT.
    k4 = [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]
    La, besta, traila = min_share(5, k4, 0, [1, 2, 3, 4], 4, 'cadical195', verbose=False)
    assert La == 1, f'the K4 control reads L = {La}, not 1'
    assert any(r['verdict'] == 'UNSAT' for r in traila), 'the K4 control never exercised the UNSAT branch'
    assert besta['achieved'] == 1
    #   (b) the same circle with no edges at all: every point can dodge the centre's colour -- L = 0, and the
    #       search must NOT report 1.  The pair (a), (b) is what makes an L = 0 on the fabric evidence.
    Lb, _, _ = min_share(5, [], 0, [1, 2, 3, 4], 4, 'cadical195', verbose=False)
    assert Lb == 0, f'the edgeless control reads L = {Lb}, not 0'

    # --- the arena's anatomy, on the smallest arena: the two halves meet only at the centre, and the
    # diagonal cross edges are exactly the circle points that the ball holds.
    _, ak, ae, anat = build_arena('group6:u3:2', 2, 'rho15', None, geometric_check=True)
    assert anat['shared_points'] == 1, f'the two halves share {anat["shared_points"]} points, not just the centre'
    assert anat['diagonal'] == len(circ), \
        f'{anat["diagonal"]} diagonal cross edges against {len(circ)} circle points: they must be in bijection'
    assert anat['within_half0'] == anat['within_half1'] == len(edges), \
        'a half\'s induced graph is not the base graph: the rotation is not an isometry of the point set'

    print('fs70_arena selftest OK')
    print(f'  arena at k = 2: {len(ak)} points, {len(ae)} edges, {anat["cross"]} cross '
          f'({anat["diagonal"]} diagonal, {anat["off_diagonal"]} off-diagonal)')
    print(f'  counting instrument: K4 circle L = {La} (UNSAT branch fired), edgeless circle L = {Lb}')
    print(f'  rho15: n = 4, diagonal circle |v| = 2, the CM base holds {len(circ)} of them '
          f'(= 2 x its {len(lat.units)} unit vectors)')


def run_plants():
    import subprocess as sp
    print('--- faithful twin')
    selftest()
    ok = True
    for name in PLANTS:
        print(f'--- plant {name}: a check must refuse it')
        if name == 'cross_dropped':
            r = sp.run([sys.executable, __file__, 'build', 'group6:u3:2', '2', '--plant', name],
                       capture_output=True, text=True)
            fired = r.returncode != 0 or 'identical to the lattice derivation: False' in r.stdout
            why = ([l for l in r.stdout.split('\n') if 'identical' in l] or
                   [(r.stderr.strip().split('\n') or [''])[-1]])[0]
        else:
            r = sp.run([sys.executable, __file__, '--selftest', '--plant', name], capture_output=True, text=True)
            fired = r.returncode != 0
            why = (r.stderr.strip().split('\n') or [''])[-1]
        if fired:
            print(f'    refused: {why[:170]}')
        else:
            print(f'    NOT REFUSED -- plant {name} left the check green: it is blind')
            ok = False
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print(f'all {len(PLANTS)} plants fired; faithful twin green')


# ---------------------------------------------------------------- main

def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


if __name__ == '__main__':
    argv = sys.argv[1:]
    if PLANT is not None and PLANT not in PLANTS:
        raise SystemExit(f'unknown plant {PLANT}; known: {", ".join(PLANTS)}')
    rot = _opt(argv, '--rot', 'rho15')
    out = _opt(argv, '--out')
    colours = _opt(argv, '--colours', 4, int)
    if not argv:
        print(__doc__)
    elif '--plants' in argv:
        run_plants()
    elif '--selftest' in argv:
        selftest()
    elif argv[0] == 'circle':
        lat, keys, edges = base_ball(argv[1], int(argv[2]))
        R, n = rotation(rot)
        circ = circle_points(keys, lat.M, n)
        print(f'base {argv[1]} at sums of <= {argv[2]}: {len(keys)} points, {len(edges)} edges, '
              f'avg degree {2*len(edges)/len(keys):.2f}')
        print(f'rotation {rot}: n = {n}; diagonal circle |v|^2 = {n}: {len(circ)} points; '
              f'G53 refutes iff L > {len(circ)/2}')
    elif argv[0] == 'count':
        res = count_screen(argv[1], int(argv[2]), rot, colours, _opt(argv, '--solver', 'cadical195'),
                           _opt(argv, '--tmax', None, int))
        print(f'L = {res["L"]}, circle {res["circle"]}, ratio {res["ratio"]:.4f}; '
              f'G53 {"REFUTES the arena -- HALT AND VERIFY" if res["refutes"] else "says nothing"}')
        if out:
            with open(out, 'w') as fh:
                json.dump({k: v for k, v in res.items() if k != 'best'} |
                          ({'best_achieved': res['best']['achieved']} if res['best'] else {}), fh, indent=1)
            print('wrote', out)
    elif argv[0] == 'build':
        build_arena(argv[1], int(argv[2]), rot, out)
    else:
        raise SystemExit(f'unknown command {argv[0]!r}; see --help / no arguments for the grammar')
