import sys; sys.path.insert(0, 'tools')
import fs73_screen as S, numpy as np
lat, r, T = S.degrey_setup(); U = lat.U
pts = S.word_ball(U, 3); idx, E = S.ball_graph(pts, U); n = len(pts)
o, dl = idx[(0,)*r], idx[tuple(T['8/3'])]
res = {}
for name, prec in (('fs70-style: two pins, no precedence', False), ('fs73: two pins + precedence over colours 2,3', True)):
    parts, nv = S.graph_cnf(n, E, [(o, 0), (dl, 1)])
    if not prec:
        cls, E_, extra = parts; parts = (cls, E_, [c for c in extra if len(c) == 1 and abs(c[0]) <= 4 * n]); nv = 4 * n
    cpus = []
    for _ in range(3):
        rec, _c = S.run_cnf(parts, n, nv, 600, 'kissat', False, 'ht')
        cpus.append(rec['cpu_s'])
    print(f'{name}: {rec["verdict"]}; CPU seconds over three runs {cpus}; min {min(cpus)}')
