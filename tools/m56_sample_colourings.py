#!/usr/bin/env python3
"""M56: sample proper k-colourings of a stage by SAT (random vertex-order shuffles and phase seeds, each model
blocked), writing a colourings file additive.py's `defect`/`additive-test` consume (stage fingerprint included).

    python3 tools/m56_sample_colourings.py --witness data/m54/witness-exact-core-8over3.json --k 5 --n 200
"""
import sys, json, time, argparse, random
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import additive as AD
from five_dial import colour_clauses, var, decode, verify_proper
from pysat.solvers import Solver

ap = argparse.ArgumentParser(); ap.add_argument("--k", type=int, required=True); ap.add_argument("--n", type=int, default=200); ap.add_argument("--out")
ap.add_argument("--seed", action="store_true"); ap.add_argument("--object"); ap.add_argument("--witness"); ap.add_argument("--heule510", action="store_true")
ap.add_argument("--degrey", action="store_true"); ap.add_argument("--field16"); ap.add_argument("--graph"); ap.add_argument("--planted")
a = ap.parse_args(); ch = AD.load_chunk(a); k = a.k
cols = []; seen = set(); t0 = time.time(); rng = random.Random(56)
while len(cols) < a.n:
    perm = list(range(ch.n)); rng.shuffle(perm)
    E = [(perm[u], perm[v]) for u, v in ch.edges]
    cl = colour_clauses(ch.n, E, k) + [[var(perm[0], rng.randrange(k), k)]]
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        for _ in range(max(1, a.n // 20)):
            if not s.solve():
                break
            c = decode(s.get_model(), ch.n, k); c0 = [c[perm[v]] for v in range(ch.n)]
            assert verify_proper(c0, ch.edges) is None
            key = AD.canon(c0)
            if key not in seen:
                seen.add(key); cols.append(c0)
            s.add_clause([-var(perm[v], c0[v], k) for v in range(ch.n)])
            if len(cols) >= a.n:
                break
    print(f"[sample] {len(cols)} distinct colourings up to palette [{time.time() - t0:.0f}s]", flush=True)
path = Path(a.out) if a.out else AD.DATA / f"colourings-sample-{ch.name}-k{k}.json"
json.dump(dict(kind="colourings", stage=ch.header(), stage_fingerprint=ch.fingerprint(), k=k, colourings=cols, sampler="SAT with random vertex shuffles and a random pinned colour, models blocked; NOT uniform",
               claim_scope="proper k-colourings of the stage, distinct up to palette; a SAT sample, not a uniform one"), open(path, "w"))
print(f"[sample] wrote {path}")
