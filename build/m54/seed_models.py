"""Pre-seed the Rigidity sweep's checkpoint with diverse proper 5-colourings. Diversity by a random vertex
RELABELLING of the formula per model (always SAT; the solver's decision order changes), never by random
pins (a pin set on a 5-chromatic graph is often inconsistent and its refutation is the expensive ask)."""
import sys, json, time, random
sys.path.insert(0, 'tools')
from five_dial import colour_clauses, var, decode, verify_proper
from rigidity import amo_clauses
from pysat.solvers import Solver
from pathlib import Path
path, k, N = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
g = json.loads(Path(path).read_text()); n = g['n']; E = [tuple(e) for e in g['edges']]
ck = Path(f"build/m54/sweep-models-{g['name']}-k{k}.txt")
rnd = random.Random(2026); t0 = time.time()
with ck.open('a') as fh:
    for got in range(1, N + 1):
        perm = list(range(n)); rnd.shuffle(perm)
        Ep = [(perm[u], perm[v]) for u, v in E]; rnd.shuffle(Ep)
        cl = colour_clauses(n, Ep, k); rnd.shuffle(cl)          # no exactly-one clauses: 4× faster, still proper (see five_dial --no-amo)
        pin = rnd.randrange(n); cl.append([var(pin, rnd.randrange(k), k)])
        with Solver(name='cadical153', bootstrap_with=cl) as s:
            assert s.solve(), "the union must be 5-colourable"
            colp = decode(s.get_model(), n, k)
        col = [colp[perm[v]] for v in range(n)]
        assert verify_proper(col, E) is None
        fh.write(''.join(str(c) for c in col) + '\n'); fh.flush()
        if got % 10 == 0:
            print(f"[seed] {got} models [{time.time()-t0:.0f}s]", flush=True)
print(f"[seed] wrote {N} models to {ck} [{time.time()-t0:.0f}s]", flush=True)
