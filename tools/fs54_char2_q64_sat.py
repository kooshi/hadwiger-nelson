import numpy as np, sys, time
from pysat.solvers import Solver
k = int(sys.argv[1]); budget = int(sys.argv[2])
n = 4096; mu = [int(x) for x in np.load("data/fs54/char2/mu64.npy")]
v = lambda i, c: i * k + c + 1
cnf = [[v(i, c) for c in range(k)] for i in range(n)]
for i in range(n):
    for u in mu:
        j = i ^ u
        if i < j:
            cnf += [[-v(i, c), -v(j, c)] for c in range(k)]
# pins: a clique {0, u1, ...} of maximum size among small ones; at least an edge
cnf += [[v(0, 0)], [v(mu[0], 1)]]
for i in range(n):
    for c in range(2, k):
        cnf.append([-v(i, c)] + [v(j, c - 1) for j in range(i)])
t0 = time.time()
with Solver(name="cadical153", bootstrap_with=cnf) as s:
    s.conf_budget(budget); r = s.solve_limited()
    if r:
        m = s.get_model(); col = [next(c for c in range(k) if m[v(i, c) - 1] > 0) for i in range(n)]
        assert all(col[i] != col[i ^ u] for i in range(n) for u in mu)
        np.save(f"data/fs54/char2/g64-col-k{k}.npy", np.array(col))
print(f"G_64 k={k}: {dict([(True,'COLOURABLE (verified)'),(False,'NOT colourable'),(None,'undecided at budget')])[r]} after {time.time()-t0:.0f}s, budget {budget} conflicts", flush=True)
