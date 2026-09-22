#!/usr/bin/env python3
"""fs70_rot_asks -- build the arena of each rotation in a `fs70_rotations` list and ASK it at four colours.
UNTRUSTED (tools/).

WHICH ROTATIONS ARE ASKED, AND WHY THE OTHERS ARE NOT.
  * `two_unit` rotations are DEAD BY THEOREM and are never asked: the base lattice is 2-integral, so for a
    2-unit psi the whole arena is, every unit vector of the arena lattice is a unit at both primes above 2, and
    the residue map to the residue field of size 4 four-colours it (Theorem A, CLAUDE.md row 57).
    `fs70_rotations.py screen` exhibits that colouring and verifies it edge by edge where the arena lattice's
    saturation is affordable.
  * `trivial` rotations (psi a sixth root of unity) map the zeta6-invariant base ONTO itself, so the "arena" is
    the base and the ask is the base's own control, already SAT in phase 1b.
  * everything else is asked, in descending order of off-diagonal cross edges -- [Voronov2021] section 5's own
    ranking ("arrange the found values of psi in descending order by the number of new edges").

A REFUSAL IS THE MILESTONE.  `control` UNSAT on an arena means a five-chromatic unit-distance graph over
Q(sqrt3, sqrt5).  This driver HALTS on one rather than continuing down the list.

Each ask appends its row to `data/fs70/asks.jsonl` at its verdict and writes its colouring beside it, so a kill
costs the arena currently being built (seconds) and nothing already decided.  Re-running skips what is done.

  python3 tools/fs70_rot_asks.py LIST.jsonl [--top N] [--k K] [--budget S] [--out-root DIR]
                                  [--min-cross N] [--single-flags '--sat']
"""
import json
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_field as FF                                                          # noqa: E402
import fs70_rotations as RT                                                      # noqa: E402

ASKS = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data', 'fs70', 'asks.jsonl')


def done_shas():
    out = set()
    if os.path.exists(ASKS):
        for line in open(ASKS):
            try:
                out.add(json.loads(line).get('sha'))
            except Exception:
                pass
    return out


def main(argv):
    path = argv[0]
    def opt(n, d=None, c=str):
        return c(argv[argv.index(n) + 1]) if n in argv else d
    top = opt('--top', 20, int)
    k = opt('--k', 4, int)
    budget = opt('--budget', 600, int)
    root = opt('--out-root', 'build/fs70/rot/asks')
    mincross = opt('--min-cross', 1, int)
    # kissat's default configuration is tuned for refutation; these arenas are two four-colourable halves
    # joined by ~80 edges and are certainly satisfiable, so `--sat` (= --target=2 --restartint=50) is the
    # right aim.  Phase 1b measured the same on its k=5 ball (its record, section 10a).
    sflags = opt('--single-flags')

    rows = [json.loads(l) for l in open(path)]
    header = rows[0]['header'] if 'header' in rows[0] else {}
    rows = [r for r in rows if 'psi' in r]
    spec = header.get('base_spec', 'group6:u3:2')
    live = [r for r in rows if not r['two_unit'] and not r['trivial'] and r['cross'] >= mincross]
    live.sort(key=lambda r: (-r['off_diagonal'], -r['cross']))
    print(f'{len(rows)} classes in {path}; {len(live)} are wall-breaking, non-trivial and carry a cross edge; '
          f'asking the top {min(top, len(live))} on the base {spec} at sums of <= {k}')
    os.makedirs(root, exist_ok=True)

    for idx, r in enumerate(live[:top]):
        tag = 'psi-' + '_'.join(str(v) for v in r['psi'])
        d = os.path.join(root, f'k{k}-{tag}')
        psi = FF.e_from_ints(tuple(r['psi']))
        t0 = time.time()
        vpath = os.path.join(d, 'verdict.json')
        if os.path.exists(vpath):
            v = json.load(open(vpath))
            print(f'--- [{idx+1}] {r["psi_str"][:60]}: already asked, verdict {v["verdict"]} '
                  f'(ledger row in {ASKS})', flush=True)
            if v['verdict'] == 'UNSAT':
                return 2
            continue
        if not os.path.exists(os.path.join(d, 'graph.json')):
            lat, apts, edges, anat, _ = RT.arena_exact(spec, k, psi, verbose=True)
            RT.write_arena(d, spec, k, psi, apts, edges, anat, lat)
        meta = json.load(open(os.path.join(d, 'graph.json')))['meta']
        note = (f'the arena B + psi.B at psi = {r["psi_str"]} (denominator {r["den"]}, 2-adic depth '
                f'{r["depth2"]}, {"commensurate" if r["commensurate"] else "incommensurate"}, type-M n = '
                f'{r["type_m_n"]}), base {spec} at sums of <= {k}: {meta["arena"]["cross"]} cross edges '
                f'({meta["arena"]["diagonal"]} diagonal, {meta["arena"]["off_diagonal"]} off-diagonal) of '
                f'{meta["edges"]}, {meta["arena"]["shared_points"]} shared points.  Rank '
                f'{idx+1} of the rotation list by off-diagonal cross edges.')
        cmd = [sys.executable, '-u', os.path.join('tools', 'fs70_ask.py'), 'run', d, 'control',
               '--single-budget', str(budget), '--no-cube', '--out', os.path.join(d, 'ask'), '--note', note]
        if sflags:
            cmd += ['--single-flags', sflags]
        print(f'--- [{idx+1}/{min(top,len(live))}] {r["psi_str"]}: {meta["points"]} points, {meta["edges"]} '
              f'edges, degree {meta["avg_degree"]:.2f}, cross {meta["arena"]["cross"]}', flush=True)
        before = sum(1 for _ in open(ASKS)) if os.path.exists(ASKS) else 0
        res = subprocess.run(cmd, capture_output=True, text=True)
        tail = [l for l in res.stdout.split('\n') if l.strip()][-4:]
        print('\n'.join('    ' + l for l in tail), flush=True)
        if res.returncode != 0:
            print(f'    the ask exited {res.returncode}:\n' + res.stderr[-800:], flush=True)
        # THE VERDICT IS READ FROM THE LEDGER ROW THE ASK WROTE, NEVER FROM ITS LOG.  The first version of
        # this driver matched the string "UNSAT" in the subprocess's stdout -- which `fs70_ask.py` prints in
        # its own explanatory line "UNSAT would mean: ..." before every single ask -- and so declared a
        # refusal on an ask that had just come back SAT in 0.15 s.  A detector that fires for the wrong
        # reason (CLAUDE.md, the gate section), caught because the line above it said SAT.
        rows_after = [json.loads(l) for l in open(ASKS)][before:] if os.path.exists(ASKS) else []
        mine = [x for x in rows_after if x.get('points') == meta['points']
                and x.get('edges') == meta['edges']]
        if not mine:
            print(f'    NO LEDGER ROW for this ask: it wrote nothing to {ASKS}, so there is no verdict to '
                  f'read.  Treated as a failure of the ask, not as a null about the graph.', flush=True)
            continue
        verdict = mine[-1].get('verdict')
        json.dump({'verdict': verdict, 'psi': r['psi'], 'psi_str': r['psi_str'], 'k': k,
                   'points': meta['points'], 'edges': meta['edges'], 'arena': meta['arena'],
                   'seconds': mine[-1].get('seconds')}, open(vpath, 'w'), indent=1)
        print(f'    ledger verdict: {verdict}   ({time.time()-t0:.1f}s total)', flush=True)
        if verdict == 'UNSAT':
            print(f'!!! A REFUSAL AT {r["psi_str"]} -- HALTING.  Verify before anything else: rebuild the '
                  f'arena, re-derive its edges both ways, re-ask under a second solver, read the pin from '
                  f'the file.', flush=True)
            return 2
    print('ALL ASKS DONE')
    return 0


if __name__ == '__main__':
    if not sys.argv[1:]:
        print(__doc__)
    else:
        sys.exit(main(sys.argv[1:]))
