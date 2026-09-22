#!/usr/bin/env python3
"""fs70_price_cubes -- FS-70 phase 1f: PRICE the decision of `group:u3:2+w4`'s k = 4 ball.  UNTRUSTED (tools/).

This tool does not decide anything.  It measures what deciding would cost, in three arms:

  arm 1  the branching set and the cube count.  `fs70_ask.enumerate_cubes` prunes a cube only by the edges
         INSIDE the branching set, which on a lattice ball whose top-degree vertices are mutually non-adjacent
         prunes nothing (phase 1b: 4^8 = 65,536 cubes, every one surviving).  Here a cube is enumerated by DFS
         with UNIT PROPAGATION through the WHOLE formula after every assignment -- exactly the propagation the
         standard colouring encoding admits: a vertex whose neighbours already carry three colours is forced,
         and the forcing cascades.  A cube is a leaf of that search, so the count is what a real cube pass
         would face.
  arm 2  the symmetry break.  Not a decision -- one run, to see whether the break moves the instance at all.
  arm 3  the k = 5 ball, priced from the k = 4 ball's boundary without building it.

Commands
  prep GRAPH.json --out DIR                         cache points + CSR adjacency as .npy (once, ~10 s)
  branch --out DIR [--nbranch 4,10,16,22] [--cap N] arm 1a: branching sets and their cube counts under
                                                    propagation through the WHOLE formula
  base GRAPH.json --out DIR [--want SHA|none]       the CNF BODY, written once with no header, in graph.json's
                                                    own clause order; refuses a body whose sha (with the right
                                                    header) is not --want
  sample --out DIR [--depths 10,16,22] [--per-depth 16] [--budget 600] [--jobs 6] [--seed N]
                                                    arm 1b: a random sample of cubes, one piped subprocess
                                                    kissat each, appended to sample.jsonl AS EACH LANDS
  symbreak --out DIR [--prefix 4096] [--pins ...]   arm 2: the ball's automorphism group, the residual symmetry
                                                    the pin leaves, and lex-leader clauses for it
  shell --out DIR [--chunk N] [--frac 0.1]          arm 3: the word-distance shells, the k = 5 ball exactly,
                                                    and the brief's sampling estimator scored against it

`sample` is resumable by tag (it skips every cube already in sample.jsonl); the others write their JSON at the
end and are simply re-run.  The phase's remaining arms are scratch scripts kept beside the record in
`data/fs70/records/phase-1f/`: arm1c (the hardness ladder), arm1d (the cube-count estimator), arm1e (where a
deep cube is refuted), arm1f + arm1f_control (the first-shell survival rate), arm1g (enumerating the
survivors), arm2_control, arm3 / arm3b / arm3c.
"""
import hashlib
import json
import os
import random
import subprocess
import sys
import time

import numpy as np

K = 4


def var(v, c):
    return K * v + c + 1


# ---------------------------------------------------------------- prep

def prep(graph_path, out):
    os.makedirs(out, exist_ok=True)
    pts_p, ind_p, ptr_p, meta_p = (os.path.join(out, x) for x in
                                   ('points.npy', 'adj_indices.npy', 'adj_indptr.npy', 'meta.json'))
    if all(os.path.exists(p) for p in (pts_p, ind_p, ptr_p, meta_p)):
        print(f'prep: cache already at {out}')
        return
    t0 = time.time()
    g = json.load(open(graph_path))
    print(f'  loaded {graph_path} in {time.time()-t0:.0f}s', flush=True)
    meta = g['meta']
    pts = np.array(g['points'], dtype=np.int64)
    n = len(pts)
    E = np.array(g['edges'], dtype=np.int64)
    del g
    assert n == meta['points'] and len(E) == meta['edges'], 'graph.json disagrees with its own meta'
    # CSR over both directions
    deg = (np.bincount(E[:, 0], minlength=n) + np.bincount(E[:, 1], minlength=n)).astype(np.int64)
    ptr = np.concatenate([[0], np.cumsum(deg)])
    order = np.argsort(np.concatenate([E[:, 0], E[:, 1]]), kind='stable')
    ind = np.concatenate([E[:, 1], E[:, 0]])[order].astype(np.int32)
    np.save(pts_p, pts)
    np.save(ind_p, ind)
    np.save(ptr_p, ptr.astype(np.int64))
    json.dump({'meta': meta, 'n': int(n), 'm': int(len(E)),
               'points_sha256': meta['points_sha256']}, open(meta_p, 'w'), indent=1)
    print(f'prep: {n} points, {len(E)} edges, CSR built in {time.time()-t0:.0f}s')


def load_cache(out, fast=True):
    """`fast` converts the CSR to `array.array`, whose element access returns a Python int an order of
    magnitude faster than numpy's scalar indexing -- the DFS below does tens of millions of them."""
    pts = np.load(os.path.join(out, 'points.npy'))
    ind = np.load(os.path.join(out, 'adj_indices.npy'))
    ptr = np.load(os.path.join(out, 'adj_indptr.npy'))
    meta = json.load(open(os.path.join(out, 'meta.json')))
    if fast:
        import array
        ind = array.array('i', ind.tobytes())
        ptr = array.array('q', ptr.tobytes())
    return pts, ind, ptr, meta


# ---------------------------------------------------------------- arm 1: cubes under unit propagation

FULL = (1 << K) - 1


def propagate(dom, trail, ind, ptr, v, c):
    """assign colour c to v and propagate.  dom[v] is a 4-bit mask of allowed colours.  Returns False on a
    conflict.  Every change is pushed onto `trail` as (vertex, old_mask) so the caller can undo exactly."""
    if not (dom[v] >> c) & 1:
        return False
    if dom[v] != (1 << c):
        trail.append((v, dom[v]))
        dom[v] = 1 << c
    queue = [v]
    qi = 0
    while qi < len(queue):
        u = queue[qi]
        qi += 1
        mu = dom[u]
        cu = mu.bit_length() - 1                      # mu is a single bit here
        for j in range(ptr[u], ptr[u + 1]):
            w = ind[j]
            mw = dom[w]
            if not (mw >> cu) & 1:
                continue
            trail.append((w, mw))
            mw &= ~(1 << cu)
            dom[w] = mw
            if mw == 0:
                return False
            if mw & (mw - 1) == 0:                    # became a single colour: it is now forced
                queue.append(w)
    return True


def undo(dom, trail, mark):
    while len(trail) > mark:
        w, m = trail.pop()
        dom[w] = m


def enumerate_cubes_prop(cand, pins, ind, ptr, n, cap=None, report=None):
    """DFS over `cand` in order, with unit propagation through the whole formula after every assignment.
    Returns (cubes, nodes, pruned_by_prop) where a cube is a tuple of (vertex, colour).

    SOUNDNESS of the decomposition: unit propagation derives only implied literals, so a pruned branch is a
    partial assignment the formula itself refutes, and a level whose vertex propagation has already forced
    carries no other colour.  The leaves therefore cover every proper colouring, and the instance is UNSAT
    iff every leaf's cube is."""
    dom = bytearray([FULL]) * n
    trail = []
    for v, c in pins:
        if not propagate(dom, trail, ind, ptr, v, c):
            raise SystemExit('the pins themselves conflict')
    cubes = []
    stats = {'nodes': 0, 'pruned': 0, 'forced': 0}
    t0 = time.time()

    def rec(i):
        if cap and len(cubes) >= cap:
            return
        if i == len(cand):
            cubes.append(tuple((v, int(dom[v]).bit_length() - 1) for v in cand))
            if report and len(cubes) % report == 0:
                print(f'    {len(cubes)} cubes, {stats["nodes"]} nodes, {time.time()-t0:.0f}s', flush=True)
            return
        v = cand[i]
        mask = int(dom[v])
        if mask & (mask - 1) == 0:                    # already forced by propagation: no branch here
            stats['forced'] += 1
            rec(i + 1)
            return
        for c in range(K):
            if not (mask >> c) & 1:
                continue
            stats['nodes'] += 1
            mark = len(trail)
            if propagate(dom, trail, ind, ptr, v, c):
                rec(i + 1)
            else:
                stats['pruned'] += 1
            undo(dom, trail, mark)

    rec(0)
    stats['seconds'] = round(time.time() - t0, 1)
    return cubes, stats


def hexagons(ind, ptr):
    """the origin's neighbourhood in this ball is a disjoint union of 6-cycles (measured, not assumed: the
    function asserts it).  Each 6-cycle plus the origin is a hexagonal wheel, which is the densest structure a
    unit-distance graph admits -- `N(v)` is triangle-free, since a triangle there would be a `K4` and four
    points of the plane are never pairwise at distance 1 (row 58)."""
    N0 = sorted(int(x) for x in ind[ptr[0]:ptr[1]])
    S = set(N0)
    sub = {v: sorted(set(int(x) for x in ind[ptr[v]:ptr[v + 1]]) & S) for v in N0}
    assert all(len(s) == 2 for s in sub.values()), 'N(0) is not 2-regular: it is not a union of cycles'
    seen, cycles = set(), []
    for v in N0:
        if v in seen:
            continue
        cyc, cur, prev = [v], v, None
        seen.add(v)
        while True:
            nxt = [w for w in sub[cur] if w != prev]
            nxt = [w for w in nxt if w not in seen]
            if not nxt:
                break
            prev, cur = cur, nxt[0]
            cyc.append(cur)
            seen.add(cur)
        assert len(cyc) == 6, f'a component of N(0) has {len(cyc)} vertices, not 6'
        cycles.append(cyc)
    return cycles


def branching_sets(ind, ptr, pins, depths):
    """hexagon by hexagon: the pinned hexagon's free vertices first (two of its six already carry a pin), then
    whole hexagons in index order."""
    cyc = hexagons(ind, ptr)
    pinned = {v for v, _ in pins}
    first = [c for c in cyc if pinned & set(c)]
    rest = [c for c in cyc if not (pinned & set(c))]
    order = (first + rest) if first else rest
    flat = []
    for c in order:
        flat += [v for v in c if v not in pinned]
    return {d: flat[:d] for d in depths}, order


def cmd_branch(out, depths, cap):
    pts, ind, ptr, meta = load_cache(out)
    n = meta['n']
    pins = [(0, 0), (25, 1), (27, 2)]
    sets, cyc = branching_sets(ind, ptr, pins, depths)
    print(f'N(0) = {int(ptr[1]-ptr[0])} vertices in {len(cyc)} disjoint 6-cycles '
          f'(hexagonal wheels about the origin)')
    rows = []
    for d in depths:
        cand = sets[d]
        t0 = time.time()
        cubes, st = enumerate_cubes_prop(cand, pins, ind, ptr, n, cap=cap, report=500000)
        row = {'set': 'hexagons', 'nbranch': d, 'cand': [int(v) for v in cand],
               'cubes': len(cubes), 'capped': bool(cap and len(cubes) >= cap), 'naive': K ** d,
               'nodes': st['nodes'], 'pruned_by_propagation': st['pruned'],
               'levels_forced_by_propagation': st['forced'], 'seconds': round(time.time() - t0, 1)}
        print(f'  depth {d}: {row["cubes"]}{" (capped)" if row["capped"] else ""} cubes of 4^{d} = '
              f'{row["naive"]:,}; {st["nodes"]} DFS nodes, {st["pruned"]} pruned, '
              f'{st["forced"]} levels forced by propagation; {row["seconds"]}s', flush=True)
        rows.append(row)
        if row['capped']:
            break
    json.dump({'hexagons': [[int(v) for v in c] for c in cyc], 'rows': rows},
              open(os.path.join(out, 'branch.json'), 'w'), indent=1)
    return rows


# ---------------------------------------------------------------- the base CNF

WANT_CNF_SHA = '89eadac453b93924617724fa2ceec48646048ad26cc1947b7a3635f48299e9b8'


# ---------------------------------------------------------------- arm 2: the symmetry group and the break

def _blk(a, b, c, d):
    return np.block([[a, b], [c, d]]).astype(np.int64)


def point_group():
    """the candidate isometries and field automorphisms, as integer 8x8 matrices over a denominator.  A point
    is `(x, y)` with `x = (p0 + p1 r3 + p2 r5 + p3 r15)/M` and `z = x + i y`; multiplication by `sqrt3` is the
    matrix `M3`.  The Galois flips are not isometries of the plane, but `x^2 + y^2 = 1` has rational
    coefficients, so they carry unit vectors to unit vectors and differences to differences: they are
    automorphisms of the unit-distance graph over the field (G27)."""
    I4 = np.eye(4, dtype=np.int64)
    Z4 = np.zeros((4, 4), dtype=np.int64)
    M3 = np.array([[0, 3, 0, 0], [1, 0, 0, 0], [0, 0, 0, 3], [0, 0, 1, 0]], dtype=np.int64)
    D = lambda v: np.diag(np.array(v, dtype=np.int64))
    return {'zeta12': (_blk(M3, -I4, I4, M3), 2),          # (sqrt3 + i)/2
            'zeta6':  (_blk(I4, -M3, M3, I4), 2),          # (1 + i sqrt3)/2
            'i':      (_blk(Z4, -I4, I4, Z4), 1),
            'conj':   (_blk(I4, Z4, Z4, -I4), 1),
            'neg':    (_blk(-I4, Z4, Z4, -I4), 1),
            'gal3':   (_blk(D([1, -1, 1, -1]), Z4, Z4, D([1, -1, 1, -1])), 1),
            'gal5':   (_blk(D([1, 1, -1, -1]), Z4, Z4, D([1, 1, -1, -1])), 1),
            'gal15':  (_blk(D([1, -1, -1, 1]), Z4, Z4, D([1, -1, -1, 1])), 1)}


def permutations_of(P):
    key = {P[i].tobytes(): i for i in range(len(P))}
    perms = {}
    for nm, (A, d) in point_group().items():
        Q = P @ A.T
        if d != 1:
            if np.any(Q % d):
                continue
            Q //= d
        perm = np.empty(len(P), dtype=np.int64)
        ok = True
        for i in range(len(P)):
            j = key.get(Q[i].tobytes())
            if j is None:
                ok = False
                break
            perm[i] = j
        if ok and len(np.unique(perm)) == len(P):
            perms[nm] = perm
    return perms


def close_group(perms, gens, n):
    import hashlib as _h
    idp = np.arange(n)
    hh = lambda p: _h.sha256(p.astype(np.int64).tobytes()).hexdigest()[:16]
    G = {hh(idp): idp}
    frontier = [idp]
    while frontier:
        nf = []
        for p in frontier:
            for g in gens:
                q = perms[g][p]
                k = hh(q)
                if k not in G:
                    G[k] = q
                    nf.append(q)
        frontier = nf
    return list(G.values())


def residual_symmetry(G, pins):
    """the symmetries an already-pinned instance still carries.  An element `(sigma, pi)` maps the pinned
    solution set into itself only if `sigma` permutes the pinned vertices among themselves -- otherwise it
    would have to fix the colour of an unpinned vertex across every solution.  With a pinned triangle
    `{0, a, b}` and `sigma(0) = 0` for every candidate here, that is the setwise stabiliser of `{a, b}`, and
    `pi` is then determined.  The size of this group is a CEILING on what any symmetry break can buy."""
    (v0, c0), (va, ca), (vb, cb) = pins
    out = []
    for q in G:
        if int(q[v0]) != v0:
            continue
        s = {int(q[va]), int(q[vb])}
        if s != {va, vb}:
            continue
        if int(q[va]) == va:
            pi = {0: 0, 1: 1, 2: 2, 3: 3}
        else:
            pi = {0: 0, ca: cb, cb: ca, 3: 3}
        out.append((q, pi))
    return out


def lex_leader_clauses(gamma, prefix, nvars0):
    """`C <=_lex pi . C . sigma` over the first `prefix` vertices, for each non-identity `(sigma, pi)`.

    Sound: the lex-least member of each orbit satisfies the FULL constraint for every group element, and a
    prefix constraint is implied by the full one, so at least one member of every orbit survives.  `eq[i]`
    means "the two vectors agree on positions `0..i-1`"; `eq[0]` is true and is not a variable."""
    cl = []
    nxt = nvars0
    aux = 0
    for q, pi in gamma:
        inv = {b: a for a, b in pi.items()}
        eq = None                                      # None == the constant TRUE
        for i in range(prefix):
            si = int(q[i])
            if si == i and all(pi[c] == c for c in range(K)):
                continue                               # this position is an identity: eq is unchanged
            pre = [] if eq is None else [-eq]
            for a in range(K):                         # forbid A_i = a > b = B_i
                for b in range(a):
                    cl.append(pre + [-var(i, a), -var(si, inv[b])])
            nxt += 1
            aux += 1
            nq = nxt
            for c in range(K):                         # eq_i and A_i = B_i  ->  eq_{i+1}
                cl.append(pre + [-var(i, c), -var(si, inv[c]), nq])
            if eq is not None:
                cl.append([-nq, eq])
            eq = nq
    return cl, aux


def cmd_symbreak(out, prefix, pins):
    pts, ind, ptr, meta = load_cache(out, fast=False)
    n = meta['n']
    perms = permutations_of(pts)
    G = close_group(perms, [g for g in ('zeta12', 'conj', 'gal3', 'gal5') if g in perms], n)
    gamma = residual_symmetry(G, pins)
    nontriv = [(q, pi) for q, pi in gamma
               if not (np.array_equal(q, np.arange(n)) and all(pi[c] == c for c in range(K)))]
    cl, aux = lex_leader_clauses(nontriv, prefix, K * n)
    path = os.path.join(out, 'break.cnf')
    with open(path, 'wb') as fh:
        fh.write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cl).encode())
    res = {'maps_that_permute_the_ball': sorted(perms), 'group_order': len(G),
           'residual_after_the_pin': len(gamma), 'nontrivial_used': len(nontriv),
           'prefix': prefix, 'break_clauses': len(cl), 'break_aux_vars': aux,
           'variables_total': K * n + aux, 'path': path,
           'max_image_index_in_prefix': int(max(int(q[i]) for q, _ in nontriv for i in range(prefix)))
           if nontriv else None}
    json.dump(res, open(os.path.join(out, 'break-meta.json'), 'w'), indent=1)
    print(json.dumps(res, indent=1))
    return res


def cmd_base(out, graph_path, want=WANT_CNF_SHA):
    """The formula's BODY, written once, with no header, in EXACTLY `fs70_ask.write_cnf_streaming`'s clause
    order -- the edges in `graph.json`'s own order, not the CSR's.  Clause order changes a CDCL solver's
    behaviour, so writing them in a different order would silently make every cube here incomparable with the
    four prior single-solver attempts.  The control is the sha: `correct header + body` must reproduce the
    `cnf_sha256` those four rows carry.  A cube is then run as

        { printf 'p cnf NV NCLb+u\\n'; cat base_body.cnf; cat units; } | kissat

    which never writes a second copy of the gigabyte."""
    meta = json.load(open(os.path.join(out, 'meta.json')))
    n, m = meta['n'], meta['m']
    pins = [(0, 0), (25, 1), (27, 2)]
    t0 = time.time()
    g = json.load(open(graph_path))
    E = g['edges']
    assert len(E) == m and len(g['points']) == n
    del g
    ncl_body = n + n * (K * (K - 1) // 2) + m * K + len(pins)
    nv = K * n
    path = os.path.join(out, 'base_body.cnf')
    h = hashlib.sha256()
    head = f'p cnf {nv} {ncl_body}\n'.encode()
    h.update(head)
    with open(path, 'wb') as fh:
        buf = []
        def emit(c):
            buf.append(' '.join(map(str, c)) + ' 0\n')
            if len(buf) >= 200000:
                b = ''.join(buf).encode()
                fh.write(b); h.update(b); buf.clear()
        for v in range(n):
            emit([var(v, c) for c in range(K)])
            for c1 in range(K):
                for c2 in range(c1 + 1, K):
                    emit([-var(v, c1), -var(v, c2)])
        for a, b_ in E:
            for c in range(K):
                emit([-var(a, c), -var(b_, c)])
        for v, c in pins:
            emit([var(v, c)])
        if buf:
            b = ''.join(buf).encode(); fh.write(b); h.update(b)
    sha = h.hexdigest()
    meta_out = {'body_path': path, 'body_clauses': ncl_body, 'variables': nv,
                'sha256_of_header_plus_body': sha, 'reproduces_prior_attempts_cnf': sha == want,
                'want': want, 'bytes': os.path.getsize(path), 'seconds': round(time.time() - t0, 1)}
    json.dump(meta_out, open(os.path.join(out, 'base-meta.json'), 'w'), indent=1)
    print(json.dumps(meta_out, indent=1))
    if want and sha != want:
        raise SystemExit('the base body does NOT reproduce the expected formula -- stop')
    return meta_out


# ---------------------------------------------------------------- arm 1b: the sample

def hexagon_colourings(hexcyc, pins, ind, ptr, n):
    """every proper 4-colouring of one hexagon of `N(0)` consistent with the pins, by the same propagation the
    enumerator uses -- so the sampler's cubes are exactly the enumerator's leaves, restricted to one hexagon."""
    import itertools
    dom = bytearray([FULL]) * n
    trail = []
    for v, c in pins:
        assert propagate(dom, trail, ind, ptr, v, c)
    pinned = {v for v, _ in pins}
    free = [v for v in hexcyc if v not in pinned]
    outs = []
    for cols in itertools.product(range(K), repeat=len(free)):
        mark = len(trail)
        ok = True
        for v, c in zip(free, cols):
            if not propagate(dom, trail, ind, ptr, v, c):
                ok = False
                break
        if ok:
            outs.append(tuple((v, c) for v, c in zip(free, cols)))
        undo(dom, trail, mark)
    return free, outs


def solve_cube(job):
    """one cube = the base body (never copied) plus this cube's unit clauses, piped into a fresh kissat."""
    cube, base, nv, ncl_body, budget, tag, workdir = job
    upath = os.path.join(workdir, f'u-{tag}.cnf')
    with open(upath, 'w') as fh:
        fh.write(''.join(f'{var(v, c)} 0\n' for v, c in cube))
    hdr = f'p cnf {nv} {ncl_body + len(cube)}'
    sh = (f"{{ printf '%s\\n' '{hdr}'; cat {base} {upath}; }} | "
          f"/usr/bin/time -f 'TIMEV %e %M %x' kissat -q -n --time={int(budget)}")
    t0 = time.time()
    rss, ktime, rc = 0, None, None
    try:
        p = subprocess.run(['bash', '-c', sh], capture_output=True, text=True, timeout=budget + 600)
        o = p.stdout + p.stderr
        v = 'UNKNOWN'
        for line in o.splitlines():
            if line.startswith('s SATISFIABLE'):
                v = 'SAT'
            elif line.startswith('s UNSATISFIABLE'):
                v = 'UNSAT'
            elif line.startswith('TIMEV '):
                _, e, m, x = line.split()
                ktime, rss, rc = float(e), int(m), int(x)
    except subprocess.TimeoutExpired:
        v = 'UNKNOWN'
    finally:
        if os.path.exists(upath):
            os.remove(upath)
    return {'cube': [[int(a), int(b)] for a, b in cube], 'verdict': v, 'tag': tag,
            'wall_seconds': round(time.time() - t0, 2), 'kissat_seconds': ktime,
            'max_rss_kb': rss, 'kissat_exit': rc}


def cmd_sample(out, depths, per_depth, budget, jobs, seed):
    import multiprocessing as mp
    pts, ind, ptr, meta = load_cache(out)
    n = meta['n']
    pins = [(0, 0), (25, 1), (27, 2)]
    bmeta = json.load(open(os.path.join(out, 'base-meta.json')))
    assert bmeta['reproduces_prior_attempts_cnf'], 'the base body is not the prior attempts\' formula'
    base, nv, ncl_body = bmeta['body_path'], bmeta['variables'], bmeta['body_clauses']
    _, cyc = branching_sets(ind, ptr, pins, depths)
    pinned = {v for v, _ in pins}
    per_hex = []
    for c in cyc:
        free, outs = hexagon_colourings(c, pins, ind, ptr, n)
        per_hex.append((free, outs))
    print('per-hexagon colouring counts: ' + ', '.join(str(len(o)) for _, o in per_hex), flush=True)
    rng = random.Random(seed)
    ledger = os.path.join(out, 'sample.jsonl')
    done = set()
    if os.path.exists(ledger):
        for line in open(ledger):
            done.add(json.loads(line)['tag'])
    jobs_list = []
    for d in depths:
        # a cube at depth d = one choice per hexagon, hexagon by hexagon, until d free vertices are covered
        need, use = d, []
        for free, outs in per_hex:
            if need <= 0:
                break
            assert len(free) <= need, 'depth must fall on a hexagon boundary'
            need -= len(free)
            use.append((free, outs))
        assert need == 0, f'depth {d} is not a whole number of hexagons'
        seen = set()
        for i in range(per_depth):
            while True:
                pick = tuple(rng.randrange(len(o)) for _, o in use)
                if pick not in seen:
                    seen.add(pick)
                    break
            cube = tuple(x for (free, outs), j in zip(use, pick) for x in outs[j])
            assert len(cube) == d
            tag = f'd{d}-{i:02d}'
            if tag in done:
                continue
            jobs_list.append((cube, base, nv, ncl_body, budget, tag, out))
    print(f'{len(jobs_list)} cubes to solve ({per_depth} at each of depths {depths}), '
          f'{jobs} at a time, {budget}s each', flush=True)
    t0 = time.time()
    with mp.get_context('fork').Pool(processes=min(jobs, max(1, len(jobs_list)))) as pool, \
            open(ledger, 'a') as fh:
        for i, r in enumerate(pool.imap_unordered(solve_cube, jobs_list, chunksize=1)):
            fh.write(json.dumps(r) + '\n')
            fh.flush()
            print(f'  [{i+1}/{len(jobs_list)}] {r["tag"]}: {r["verdict"]} in {r["wall_seconds"]}s '
                  f'(kissat {r["kissat_seconds"]}s, {r["max_rss_kb"]/1048576:.2f} GB); '
                  f'{time.time()-t0:.0f}s elapsed', flush=True)


# ---------------------------------------------------------------- arm 3: the k = 5 ball, priced

def _void(Q):
    """an (n, 8) integer array as one bytes-key per row, so membership is a sort plus a searchsorted.  The
    coordinates of this ball run to +-288 and one generator step adds at most 72, so int16 is exact and the
    function asserts it rather than trusting the range."""
    A = np.ascontiguousarray(Q.astype(np.int16))
    assert (A.astype(np.int64) == Q).all(), 'a coordinate does not fit in int16'
    return A.view(np.dtype((np.void, A.shape[1] * 2))).ravel()


def cmd_shell(out, chunk, frac):
    pts, ind, ptr, meta = load_cache(out, fast=False)
    n, M = meta['n'], meta['meta']['M']
    P = pts
    G = P[np.sort(ind[ptr[0]:ptr[1]])]
    assert len(G) == 84, f'the origin has {len(G)} neighbours, not the 84 generators'
    B = np.array([1.0, np.sqrt(3.0), np.sqrt(5.0), np.sqrt(15.0)])

    def norm2(Q):
        x = Q[:, :4] @ B
        y = Q[:, 4:] @ B
        return (x * x + y * y) / (M * M)
    assert np.abs(norm2(G) - 1).max() < 1e-9, 'a generator is not a unit vector'

    keys = _void(P)
    order = np.argsort(keys, kind='stable')
    skeys = keys[order]
    t0 = time.time()

    def lookup(Q):
        """vertex indices of the rows of Q that lie in the ball; -1 for the rest"""
        k = _void(Q)
        pos = np.searchsorted(skeys, k)
        pos = np.clip(pos, 0, len(skeys) - 1)
        hit = skeys[pos] == k
        r = np.full(len(k), -1, dtype=np.int64)
        r[hit] = order[pos[hit]]
        return r

    dist = np.full(n, -1, dtype=np.int8)
    dist[0] = 0
    frontier = np.array([0], dtype=np.int64)
    shells = [1]
    for d in range(1, 5):
        found = []
        for s in range(0, len(frontier), chunk):
            blk = P[frontier[s:s + chunk]]
            cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
            idx = lookup(cand)
            idx = idx[idx >= 0]
            idx = np.unique(idx)
            found.append(idx[dist[idx] < 0])
        nf = np.unique(np.concatenate(found)) if found else np.array([], dtype=np.int64)
        nf = nf[dist[nf] < 0]
        dist[nf] = d
        frontier = nf
        shells.append(int(len(nf)))
        print(f'  shell {d}: {len(nf):,} points ({time.time()-t0:.0f}s)', flush=True)
    unlabelled = int((dist < 0).sum())
    print(f'  shells {shells}, sum {sum(shells):,}, unreachable in <=4 generator steps: {unlabelled}')

    # ---- shell 5, exactly: every generator translate of shell 4 that is not already in the ball
    sh4 = np.nonzero(dist == 4)[0]
    print(f'  expanding shell 4 ({len(sh4):,} points) by {len(G)} generators = {len(sh4)*len(G):,} sums',
          flush=True)
    acc, total_new_incidences = [], 0
    for s in range(0, len(sh4), chunk):
        blk = P[sh4[s:s + chunk]]
        cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
        idx = lookup(cand)
        out_rows = cand[idx < 0]
        total_new_incidences += len(out_rows)
        acc.append(np.unique(_void(out_rows)))
        if len(acc) >= 24:
            acc = [np.unique(np.concatenate(acc))]
        if (s // chunk) % 4 == 0:
            print(f'    {s + len(blk):,}/{len(sh4):,} parents, {sum(len(a) for a in acc):,} keys held, '
                  f'{time.time()-t0:.0f}s', flush=True)
    sh5keys = np.unique(np.concatenate(acc)) if acc else np.array([], dtype=skeys.dtype)
    sh5 = np.frombuffer(sh5keys.tobytes(), dtype=np.int16).reshape(-1, 8).astype(np.int64)
    nrm = norm2(sh5)
    units5 = int((np.abs(nrm - 1) < 1e-9).sum())
    res = {'shells_0_to_4': shells, 'k4_ball': int(sum(shells)), 'unlabelled': unlabelled,
           'shell5_exact': int(len(sh5)), 'k5_ball': int(sum(shells) + len(sh5)),
           'shell4_generator_incidences_leaving_the_ball': int(total_new_incidences),
           'mean_parents_per_new_point': round(total_new_incidences / max(1, len(sh5)), 3),
           'unit_vectors_in_shell5': units5,
           'origin_degree_k4': int(len(G)), 'origin_degree_k5': int(len(G) + units5),
           'unit_vectors_of_the_lattice': meta['meta']['g'],
           'k5_max_norm': round(float(np.sqrt(nrm.max())), 4),
           'seconds': round(time.time() - t0, 1)}
    # ---- the sampling estimator the brief asked for, scored against the exact number
    rng = np.random.default_rng(20260922)
    sel = rng.choice(len(sh4), size=max(1, int(frac * len(sh4))), replace=False)
    acc2 = []
    for s in range(0, len(sel), chunk):
        blk = P[sh4[sel[s:s + chunk]]]
        cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
        idx = lookup(cand)
        acc2.append(np.unique(_void(cand[idx < 0])))
    est_distinct = len(np.unique(np.concatenate(acc2)))
    res['sample_fraction'] = frac
    res['sample_distinct_new'] = int(est_distinct)
    res['sample_naive_estimate'] = int(round(est_distinct / frac))
    res['sample_naive_over_exact'] = round(est_distinct / frac / max(1, len(sh5)), 4)
    json.dump(res, open(os.path.join(out, 'shell.json'), 'w'), indent=1)
    print(json.dumps(res, indent=1))
    return res


def main():
    argv = sys.argv[1:]
    cmd = argv[0]
    out = argv[argv.index('--out') + 1] if '--out' in argv else 'build/fs70/1f'
    def opt(name, default, cast=int):
        return cast(argv[argv.index(name) + 1]) if name in argv else default
    if cmd == 'prep':
        prep(argv[1], out)
    elif cmd == 'branch':
        nl = [int(x) for x in opt('--nbranch', '4,10,16,22', str).split(',')]
        cmd_branch(out, nl, opt('--cap', 2_000_000))
    elif cmd == 'base':
        cmd_base(out, argv[1], opt('--want', WANT_CNF_SHA, str))
    elif cmd == 'symbreak':
        pn = [int(x) for x in opt('--pins', '0,0,25,1,27,2', str).split(',')]
        cmd_symbreak(out, opt('--prefix', 4096), [(pn[0], pn[1]), (pn[2], pn[3]), (pn[4], pn[5])])
    elif cmd == 'shell':
        cmd_shell(out, opt('--chunk', 40000), opt('--frac', 0.1, float))
    elif cmd == 'sample':
        cmd_sample(out, [int(x) for x in opt('--depths', '10,16,22', str).split(',')],
                   opt('--per-depth', 16), opt('--budget', 600), opt('--jobs', 1), opt('--seed', 20260922))
    else:
        raise SystemExit(f'unknown command {cmd}')


if __name__ == '__main__':
    main()
