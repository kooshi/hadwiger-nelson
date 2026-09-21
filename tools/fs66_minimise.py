#!/usr/bin/env python3
"""fs66_minimise -- shrink a refusing subgraph of UD(Z/n, 2) by deleting vertices, one accepted deletion per
wave, with a checkpoint after every acceptance (FS-66, instrument I1).

UNTRUSTED, like everything in tools/. Nothing it outputs is believed until `tools/fs66_check_witness.py`
re-derives it: this tool only *proposes* smaller graphs, and every proposal it accepts carries a fresh LRAT
refutation of its own, so a bug here can only cost work, never buy a theorem.

HOW IT WORKS. The state is a vertex list, an edge list, and a pinned triangle. A *probe* deletes one vertex
(and the edges at it) and asks CaDiCaL for a k-colouring under a conflict budget:
  UNSAT    -> the deletion is admissible; the probe's own LRAT gives a core, usually smaller than the graph
              it was taken from, so one acceptance often removes many vertices at once;
  SAT      -> the vertex is needed, at this state;
  UNKNOWN  -> the budget ran out. The vertex is KEPT and the probe is counted as undecided. An UNKNOWN is
              never read as "needed" (CLAUDE.md G21: a verdict at a budget measures the enumeration).
Sixteen probes run at a time, on sixteen distinct untested candidates; when any refuse, the one whose core is
smallest is accepted and the state is rewritten. A SWEEP is one pass over every candidate; only a sweep that
accepts nothing certifies 1-minimality, because items probed earlier in a sweep were probed against a larger
graph. `--mode edges` deletes EDGES instead (the kernel pays per clause, and the certificate's cost is
vertices + k*edges); `--mode both` alternates and stops when a vertex sweep and an edge sweep in a row both
accept nothing. The pin's three edges are never candidates.

THE PIN. The pinned triangle's three vertices are never candidates, and its three edges are put back after
every core extraction: fixing a clique's colours is a sound symmetry reduction only while that clique is in
the graph being refuted (plan T1 -- a shrinker that dropped them produced a "core" that was 4-colourable).

IF THIS PROCESS DIES AT ANY INSTANT, the relaunch redoes at most one wave: `--ckpt DIR/x.jsonl` gains one
line per acceptance and `DIR/x.current.json` is rewritten atomically (write a temp file, fsync, rename) after
each one, so the worst loss is the sixteen probes in flight.
  resume:  python3 tools/fs66_minimise.py --resume data/fs66/ckpt/minimise-p11-l2.current.json

STOP RULE (G65: certification cost is predicted by nothing, so stop on the measured rate): 1-minimality, or
`--stall N` consecutive probes with no acceptance once the acceptance rate has fallen below one per
`--stall-minutes`, or `--budget` seconds -- whichever comes first. The graph that stands then is the answer.

USAGE
  fs66_minimise.py CORE.json --n N --k K --ckpt CKPT.jsonl [--out FINAL.json] [--workers 16]
                   [--conflicts 300000] [--budget 7200] [--stall 200] [--stall-minutes 5] [--seed 0]
  fs66_minimise.py --resume CKPT.current.json [--budget …]       (every other setting is read back)
"""
from __future__ import annotations

import argparse
import collections
import glob
import json
import multiprocessing as mp
import os
import re
import subprocess
import sys
import tempfile
import time

CADICAL = sorted(glob.glob(os.path.expanduser('~/.elan/toolchains/*/bin/cadical')))[-1]


# ---------------------------------------------------------------- one probe (runs in a forked worker)

def probe(job):
    """delete one vertex (`('v', u)`) or one edge (`('e', (i, j))`) and ask. Returns
    (removal, verdict, conflicts, wall, new_verts, new_edges)."""
    V, E, pin, k, rem, workdir, seed, conflicts = job
    if rem[0] == 'v':
        keep = [u for u in V if u != rem[1]]
        left = [e for e in E if rem[1] not in e]
    elif rem[0] == 'e':
        keep = list(V)
        gone = tuple(rem[1])
        left = [e for e in E if e != gone]
    else:                                  # ('none', None): ask the graph itself, deleting nothing
        keep, left = list(V), list(E)
    pos = {u: i for i, u in enumerate(keep)}
    sub = [(pos[a], pos[b]) for a, b in left]
    x = lambda i, c: k * i + c + 1
    cl = [[x(i, c) for c in range(k)] for i in range(len(keep))]
    for i, j in sub:
        for c in range(k):
            cl.append([-x(i, c), -x(j, c)])
    for c, u in enumerate(pin):
        cl.append([x(pos[u], c)])
    tag = 'probe-' + ('v%d' % rem[1] if rem[0] == 'v' else
                      'e%d_%d' % tuple(rem[1]) if rem[0] == 'e' else 'whole')
    cnf = os.path.join(workdir, tag + '.cnf')
    lrat = os.path.join(workdir, tag + '.lrat')
    with open(cnf, 'w') as f:
        f.write(f'p cnf {k * len(keep)} {len(cl)}\n')
        f.write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cl))
    t0 = time.time()
    r = subprocess.run([CADICAL, '-n', f'--seed={seed}', '-c', str(conflicts), '--lrat', '--no-binary',
                        cnf, lrat], capture_output=True, text=True)
    wall = time.time() - t0
    verdict = {10: 'SAT', 20: 'UNSAT'}.get(r.returncode, 'UNKNOWN')
    conf = None
    for line in r.stdout.splitlines():
        m = re.match(r'^c conflicts:\s+(\d+)', line)
        if m:
            conf = int(m.group(1))
    nV = nE = None
    if verdict == 'UNSAT':
        nV, nE = core_from(lrat, cl, len(cl), k, keep, pin)
    for p in (cnf, lrat):
        try:
            os.remove(p)
        except OSError:
            pass
    return (rem, verdict, conf, round(wall, 2), nV, nE)


def core_from(lrat, cl, nc, k, ids, pin):
    """backward reachability from the empty clause -> the vertices and edges the refutation used, with the
    pin's triangle restored and isolated vertices dropped."""
    hints, empty = {}, None
    with open(lrat) as f:
        for line in f:
            t = line.split()
            if not t or (len(t) > 1 and t[1] == 'd'):
                continue
            cid = int(t[0])
            z = t.index('0', 1)
            hints[cid] = [abs(int(h)) for h in t[z + 1:-1]]
            if z == 1:
                empty = cid
    if empty is None:
        return None, None
    used, stack, seen = set(), [empty], set()
    while stack:
        c = stack.pop()
        if c in seen:
            continue
        seen.add(c)
        if c <= nc:
            used.add(c)
        else:
            stack.extend(hints[c])
    E = set()
    for c in used:
        vs = sorted({ids[(abs(l) - 1) // k] for l in cl[c - 1]})
        if len(vs) == 2:
            E.add((vs[0], vs[1]))
    for a, b in ((pin[0], pin[1]), (pin[0], pin[2]), (pin[1], pin[2])):   # T1: the pin's clique stays
        E.add((min(a, b), max(a, b)))
    V = sorted({u for e in E for u in e})                                 # isolated vertices carry nothing
    return V, sorted(E)


# ---------------------------------------------------------------- the checkpoint

def save_state(path, state):
    """atomic: a temp file in the same directory, fsynced, then renamed over the old one."""
    d = os.path.dirname(os.path.abspath(path))
    fd, tmp = tempfile.mkstemp(dir=d, prefix='.tmp-', suffix='.json')
    with os.fdopen(fd, 'w') as f:
        json.dump(state, f)
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, path)


def append_line(path, obj):
    with open(path, 'a') as f:
        f.write(json.dumps(obj) + '\n')
        f.flush()
        os.fsync(f.fileno())


# ---------------------------------------------------------------- the run

def run(state, budget):
    V, E = list(state['verts']), [tuple(e) for e in state['edges']]
    pin, k, n = tuple(state['pin']), state['k'], state['n']
    pin_edges = {(min(a, b), max(a, b)) for a, b in
                 ((pin[0], pin[1]), (pin[0], pin[2]), (pin[1], pin[2]))}
    ckpt, cur = state['ckpt'], state['current']
    mode = state.get('mode', 'vertices')
    workdir = tempfile.mkdtemp(prefix='fs66-minimise-')
    print(f'start: {len(V)} vertices, {len(E)} edges, pin {list(pin)}, n={n}, k={k}, mode={mode}, '
          f'{state["workers"]} probes at a time, conflict budget {state["conflicts"]}, '
          f'{len(state["accepted"])} deletions already on the checkpoint', flush=True)
    print(f'  if this dies now the relaunch redoes at most one wave of {state["workers"]} probes; '
          f'resume: python3 tools/fs66_minimise.py --resume {cur}', flush=True)
    t_start = time.time()
    def _norm(t):
        t = tuple(t)
        return ('e', tuple(t[1])) if t[0] == 'e' else ('v', t[1])
    tested = {_norm(t) for t in state.get('tested', [])}
    probes = probes_since_accept = waves = 0
    sweep = state.get('sweep', 0)
    accepted_this_sweep = state.get('accepted_this_sweep', 0)
    phase = state.get('phase', 'edges' if mode == 'edges' else 'vertices')
    clean_phases = state.get('clean_phases', 0)
    accept_times = []
    need_clean = 2 if mode == 'both' else 1

    def candidates():
        """what may still be probed against THIS graph, cheapest-looking first."""
        if phase == 'vertices':
            deg = collections.Counter()
            for a, b in E:
                deg[a] += 1
                deg[b] += 1
            return sorted((('v', u) for u in V if u not in pin and ('v', u) not in tested),
                          key=lambda r: (deg[r[1]], r[1]))
        return sorted((('e', e) for e in E if e not in pin_edges and ('e', e) not in tested),
                      key=lambda r: r[1])

    ctx = mp.get_context('fork')        # Python 3.14 defaults to forkserver, which empties module globals
    with ctx.Pool(state['workers']) as pool:
        while True:
            if time.time() - t_start > budget:
                print(f'stop: the {budget} s budget is spent', flush=True)
                state['stop'] = 'budget'
                break
            cands = candidates()
            total = (len(V) - 3) if phase == 'vertices' else (len(E) - 3)
            if not cands:
                # a sweep is one pass over every deletable item. Items probed earlier in a sweep were probed
                # against a LARGER graph, so only a sweep that accepts NOTHING certifies 1-minimality.
                if accepted_this_sweep:
                    sweep += 1
                    clean_phases = 0
                    print(f'sweep {sweep} ({phase}) ended with {accepted_this_sweep} acceptances: '
                          f'another pass over all {total} of them', flush=True)
                else:
                    clean_phases += 1
                    sweep += 1
                    print(f'sweep {sweep} ({phase}) accepted nothing: the graph is 1-minimal in {phase} '
                          f'({total} probed against this graph)', flush=True)
                    if clean_phases >= need_clean:
                        state['stop'] = '1-minimal'
                        print(f'stop: 1-minimal in {"vertices and edges" if mode == "both" else phase}',
                              flush=True)
                        break
                    phase = 'edges' if phase == 'vertices' else 'vertices'
                    print(f'  switching to {phase}', flush=True)
                tested, accepted_this_sweep = set(), 0
                state.update(sweep=sweep, accepted_this_sweep=0, tested=[], phase=phase,
                             clean_phases=clean_phases)
                save_state(cur, state)
                continue
            wave = cands[:state['workers']]
            jobs = [(V, E, pin, k, r, workdir, state['seed'], state['conflicts']) for r in wave]
            t0 = time.time()
            results = list(pool.imap_unordered(probe, jobs, chunksize=1))
            waves += 1
            probes += len(results)
            verdicts = collections.Counter(r[1] for r in results)
            good = [r for r in results if r[1] == 'UNSAT' and r[4]]
            if not good:
                tested.update(wave)
                probes_since_accept += len(results)
                state['tested'] = [list(t) if t[0] == 'v' else ['e', list(t[1])] for t in tested]
                save_state(cur, state)           # so a death here redoes at most this one wave of probes
                print(f'wave {waves} (sweep {sweep + 1}, {phase}): {len(V)}v/{len(E)}e  no deletion '
                      f'({dict(verdicts)}), {len(tested)}/{total} probed, {time.time() - t0:.1f}s',
                      flush=True)
                if probes_since_accept >= state['stall']:
                    # the RECENT rate, not the lifetime one: a run that accepted fast for an hour and has
                    # accepted nothing for ten minutes has stalled, and a lifetime average hides that.
                    window = state['stall_minutes'] * 60
                    recent = [t for t in accept_times if t > time.time() - window]
                    if not recent and time.time() - t_start > window:
                        print(f'stop: {probes_since_accept} probes with no acceptance, and none at all in '
                              f'the last {state["stall_minutes"]} minutes', flush=True)
                        state['stop'] = 'stalled'
                        break
                continue
            best = min(good, key=lambda r: (len(r[4]) + len(r[5]), len(r[4])))
            rem, _, conf, wall, nV, nE = best
            append_line(ckpt, {'removed_kind': rem[0], 'removed': rem[1], 'vertices_left': len(nV),
                               'edges_left': len(nE), 'probe_conflicts': conf, 'probe_wall_s': wall,
                               'wave': waves, 'phase': phase, 'refusing_in_wave': len(good),
                               'utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())})
            print(f'wave {waves} ({phase}): {len(V)}v/{len(E)}e -> {len(nV)}v/{len(nE)}e  '
                  f'(deleted {rem[0]} {rem[1]}; {len(good)} of {len(results)} probes refused; '
                  f'{conf} conflicts; {time.time() - t0:.1f}s)', flush=True)
            V, E = nV, [tuple(e) for e in nE]
            alive_v, alive_e = set(V), set(E)
            tested = {t for t in tested if (t[1] in alive_v if t[0] == 'v' else tuple(t[1]) in alive_e)}
            state['verts'], state['edges'] = V, [list(e) for e in E]
            state['accepted'].append([rem[0], rem[1]])
            state['sweep'], state['phase'], state['clean_phases'] = sweep, phase, 0
            state['accepted_this_sweep'] = accepted_this_sweep + 1
            state['tested'] = [list(t) if t[0] == 'v' else ['e', list(t[1])] for t in tested]
            save_state(cur, state)
            probes_since_accept = 0
            accepted_this_sweep += 1
            clean_phases = 0
            accept_times.append(time.time())
    state['verts'], state['edges'] = V, [list(e) for e in E]
    state['elapsed_s'] = round(time.time() - t_start, 1)
    state['probes'] = state.get('probes', 0) + probes
    save_state(cur, state)
    print(f'final: {len(V)} vertices, {len(E)} edges after {probes} probes in {state["elapsed_s"]} s '
          f'({len(state["accepted"])} accepted deletions)', flush=True)
    # every acceptance was a subgraph of something that refused, but the STATE ITSELF is never solved in the
    # loop -- only its one-vertex-lighter children are. If it were colourable every probe would say SAT and
    # the run would report "1-minimal" about a graph that refuses nothing. So solve it once, here.
    ver = probe((V, E, pin, k, ('none', None), workdir, state['seed'], state['conflicts']))
    print(f'the final graph itself, asked directly: {ver[1]} ({ver[2]} conflicts)', flush=True)
    state['final_verdict'] = ver[1]
    save_state(cur, state)
    if ver[1] != 'UNSAT':
        raise SystemExit(f'the final graph is {ver[1]}: it does not refuse {k} colours, so nothing here is a '
                         f'witness. Nothing was written to --out.')
    return state


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('core', nargs='?')
    ap.add_argument('--resume')
    ap.add_argument('--n', type=int)
    ap.add_argument('--k', type=int)
    ap.add_argument('--ckpt')
    ap.add_argument('--out')
    ap.add_argument('--workers', type=int, default=16)
    ap.add_argument('--conflicts', type=int, default=300000)
    ap.add_argument('--budget', type=float, default=7200)
    ap.add_argument('--stall', type=int, default=200)
    ap.add_argument('--stall-minutes', type=float, default=5)
    ap.add_argument('--seed', type=int, default=0)
    ap.add_argument('--mode', choices=('vertices', 'edges', 'both'), default='vertices')
    a = ap.parse_args()

    if a.resume:
        state = json.load(open(a.resume))
        print(f'resuming from {a.resume}: {len(state["verts"])} vertices, {len(state["edges"])} edges, '
              f'{len(state["accepted"])} deletions already accepted', flush=True)
    else:
        if not (a.core and a.n and a.k and a.ckpt):
            ap.error('a fresh run needs CORE.json --n N --k K --ckpt CKPT.jsonl')
        d = json.load(open(a.core))
        V = sorted(d['verts'])
        E = sorted({(min(u, v), max(u, v)) for u, v in d['edges']})
        adj = collections.defaultdict(set)
        for u, v in E:
            adj[u].add(v)
            adj[v].add(u)
        pin = None
        for u, v in E:
            common = adj[u] & adj[v]
            if common:
                pin = (u, v, min(common))
                break
        if pin is None:
            raise SystemExit('no triangle in the core: nothing to pin')
        os.makedirs(os.path.dirname(os.path.abspath(a.ckpt)), exist_ok=True)
        state = {'kind': 'fs66-minimise-state', 'n': a.n, 'k': a.k, 'verts': V, 'edges': [list(e) for e in E],
                 'pin': list(pin), 'accepted': [], 'ckpt': a.ckpt,
                 'current': a.ckpt.replace('.jsonl', '') + '.current.json',
                 'workers': a.workers, 'conflicts': a.conflicts, 'seed': a.seed, 'stall': a.stall,
                 'stall_minutes': a.stall_minutes, 'source': a.core, 'out': a.out, 'mode': a.mode,
                 'started_utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())}
        append_line(a.ckpt, {'event': 'start', 'source': a.core, 'vertices': len(V), 'edges': len(E),
                             'pin': list(pin), 'utc': state['started_utc']})
        save_state(state['current'], state)

    state = run(state, a.budget)
    out = a.out or state.get('out')
    if out:
        json.dump({'verts': state['verts'], 'edges': state['edges']}, open(out, 'w'))
        print(f'written to {out}')


if __name__ == '__main__':
    main()
