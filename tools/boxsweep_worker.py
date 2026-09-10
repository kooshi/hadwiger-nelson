"""One chunk of a box sweep. Plain subprocess -- no pool, no queue, no epoll: it cannot wedge.

Reads the CNF and the box list from disk, sweeps [lo, hi), prints either
    SURVIVOR <index>     (some box's assumptions are satisfiable -- the drop is rejected)
    BLOCKED <n>          (every box in the chunk is refuted)
Exit code is 0 either way; a nonzero exit or missing line is a worker failure, never a verdict.
"""
import sys, pickle
from pysat.solvers import Solver
cnf_path, box_path, lo, hi = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
cnf = pickle.load(open(cnf_path,'rb'))
boxes = pickle.load(open(box_path,'rb'))
with Solver(name="cadical153", bootstrap_with=cnf) as s:
    for i in range(lo, min(hi, len(boxes))):
        if s.solve(assumptions=boxes[i]):
            print(f"SURVIVOR {i}", flush=True); sys.exit(0)
print(f"BLOCKED {min(hi,len(boxes))-lo}", flush=True)
