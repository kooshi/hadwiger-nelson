#!/usr/bin/env python3
"""The forcing-critical set F of the it-4 unit part U for the pair (35, 1859) at four colours: the
vertices whose deletion makes U stop forcing the pair. Derivation (M54 §R3): for the single-centre
union W⁺ = U ∪ R(U), C(W⁺) ⊆ F ∪ R(F) — a vertex outside F leaves U − v forcing x = y and R(U)
forcing x = R(y), and the spindle chord refuses four colours. Parallel; checkpointed."""
import json, sys, time
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
sys.path.insert(0, 'tools')
_G = {}
def init(n, edges, x, y):
    _G.update(n=n, edges=edges, x=x, y=y)
def ask(v):
    from forced_spindle import forces
    n, edges, x, y = _G['n'], _G['edges'], _G['x'], _G['y']
    t = time.time()
    sub = [(u, w) for u, w in edges if v not in (u, w)]
    return v, forces(n, sub, x, y), time.time() - t
def main():
    import batchkill as BK
    W = json.load(open('data/m53/forced-spindle-full.json'))
    label = W['object']; x0, y0 = W['pair']
    if len(sys.argv) > 1:
        x0, y0 = (int(t) for t in sys.argv[1].split(','))
    obj, _ = BK.load_object(label)
    live = sorted(i for i in range(obj.n) if i not in obj.deleted); idx = {v: i for i, v in enumerate(live)}
    edges = [(idx[u], idx[v]) for u, v in obj.unit_edges()]
    n = len(live); x, y = idx[x0], idx[y0]
    out = Path(f'build/m54/forcing-census-U-{x0}-{y0}.jsonl'); done = {}
    if out.exists():
        for l in out.read_text().splitlines():
            r = json.loads(l); done[r['v']] = r['forces']
    todo = [v for v in range(n) if v not in done and v not in (x, y)]
    print(f"[F] U: {n} points, {len(edges)} edges; pair {x0},{y0} -> {x},{y}; {len(todo)} asks", flush=True)
    t0 = time.time()
    with out.open('a') as fh, ProcessPoolExecutor(max_workers=24, initializer=init, initargs=(n, edges, x, y)) as ex:
        futs = [ex.submit(ask, v) for v in todo]
        for i, f in enumerate(as_completed(futs), 1):
            v, forced, dt = f.result(); done[v] = forced
            fh.write(json.dumps(dict(v=v, forces=forced, seconds=round(dt, 2))) + "\n"); fh.flush()
            if i % 200 == 0:
                print(f"[F] {i}/{len(todo)} asked, F so far {sum(1 for f_ in done.values() if not f_)} [{time.time()-t0:.0f}s]", flush=True)
    F = sorted(v for v, f_ in done.items() if not f_) + [x, y]
    core = set(idx[v] for v in json.load(open('data/m53/forced-spindle-core-8over3.json'))['core_vertices'])
    print(f"[F] forcing-critical set F: {len(F)} of {n} (incl. the pair); F ⊆ 588-core: {all(v in core for v in F)}; |F ∩ core| = {len(set(F) & core)} [{time.time()-t0:.0f}s]", flush=True)
    json.dump(dict(kind='forcing-critical-set', object=label, pair=[x0, y0], n=n, F_live_index=F, F_labels=[live[v] for v in F],
                   claim_scope='one forcing ask (U − v forces the pair at four colours?) per vertex; F = the refusals; the pair itself included'),
              open(f'data/m54/forcing-critical-U-{x0}-{y0}.json', 'w'), indent=1)
    print(f"[F] wrote data/m54/forcing-critical-U-{x0}-{y0}.json")
if __name__ == "__main__":
    main()
