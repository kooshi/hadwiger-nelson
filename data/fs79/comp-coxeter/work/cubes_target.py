"""On L21cc6506 (and the minimal survivors): triangle-freeness, induced squares, and which generator triples span induced 3-cubes vs cubes with a chord."""
import sys, itertools
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be
def add(*vs): return tuple(sum(x) for x in zip(*vs))
def neg(v): return tuple(-x for x in v)
for M in [420, 2448, 2328, 2400]:
    U = units_be(M, 167); Us = set(U)
    reps = sorted({min(u, neg(u)) for u in U})
    tri = sum(1 for s in U for t in U if add(s, t) in Us)
    par = lambda s, t: all(s[i]*t[j] == s[j]*t[i] for i in range(4) for j in range(4))
    nonpar_pairs = [(s, t) for s, t in itertools.combinations(reps, 2) if not par(s, t)]
    induced_sq = sum(1 for s, t in nonpar_pairs if add(s,t) not in Us and add(s,neg(t)) not in Us)
    triples = list(itertools.combinations(reps, 3))
    chord = 0; induced = 0; degenerate = 0
    for s, t, u in triples:
        diags = [add(s,t,u), add(neg(s),t,u), add(s,neg(t),u), add(s,t,neg(u))]
        if any(all(x == 0 for x in dg) for dg in diags): degenerate += 1; continue
        if any(dg in Us or neg(dg) in Us for dg in diags): chord += 1
        else: induced += 1
    # does every non-parallel pair lie in some induced cube?
    pair_ok = 0
    for s, t in nonpar_pairs:
        ok = False
        for u in reps:
            if u in (s, t) or par(u, s) or par(u, t): continue
            diags = [add(s,t,u), add(neg(s),t,u), add(s,neg(t),u), add(s,t,neg(u))]
            if all(any(x) for x in diags) and not any(dg in Us or neg(dg) in Us for dg in diags): ok = True; break
        pair_ok += ok
    print(f'M={M}: |U|={len(U)}, triangles={tri}, non-parallel pairs={len(nonpar_pairs)}, induced squares={induced_sq}; '
          f'triples={len(triples)}: induced cubes={induced}, cubes with a body-diagonal chord={chord}, degenerate={degenerate}; '
          f'pairs lying in an induced cube: {pair_ok}/{len(nonpar_pairs)}')
