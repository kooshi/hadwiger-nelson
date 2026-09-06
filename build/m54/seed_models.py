"""Pre-seed the Rigidity sweep's checkpoint with diverse proper 5-colourings (random pins), so the first
batch violation query is over hundreds of candidates rather than millions (M54 §R4, the 5,857-point union)."""
import sys, json, time, random
sys.path.insert(0, 'tools')
from five_dial import colour_clauses, var, decode, verify_proper
from rigidity import amo_clauses
from pysat.solvers import Solver
from pathlib import Path
path, k, N = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
g = json.loads(Path(path).read_text()); n = g['n']; E = [tuple(e) for e in g['edges']]
ck = Path(f"build/m54/sweep-models-{g['name']}-k{k}.txt")
base = colour_clauses(n, E, k) + amo_clauses(n, k)
rnd = random.Random(2026); t0 = time.time(); got = 0; tries = 0; pins = 60
with ck.open('a') as fh:
    while got < N:
        tries += 1
        P = rnd.sample(range(n), pins)
        assum = [var(v, rnd.randrange(k), k) for v in P]
        with Solver(name='cadical153', bootstrap_with=base) as s:
            if s.solve(assumptions=assum):
                col = decode(s.get_model(), n, k); assert verify_proper(col, E) is None
                fh.write(''.join(str(c) for c in col) + '\n'); fh.flush(); got += 1
            else:
                pins = max(5, pins - 5)
        if tries % 10 == 0:
            print(f"[seed] {got} models in {tries} tries (pins {pins}) [{time.time()-t0:.0f}s]", flush=True)
print(f"[seed] wrote {got} models to {ck} in {tries} tries [{time.time()-t0:.0f}s]", flush=True)
