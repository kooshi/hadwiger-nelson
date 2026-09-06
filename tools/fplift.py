#!/usr/bin/env python3
"""fplift — the finite-plane lift (M59, plans/M59-finite-plane-lift.md): does a subgraph H of UD(F_p, 2) lift to a
unit-distance configuration — one point per residue class, every listed edge of quadrance one?

THE DERIVATION (§S1). Write a candidate lift as x = x₀ + p·y with x₀ the integer reference positions of H's residues. The
lift exists modulo p² iff R(H)·ȳ = b over F_p, where R(H) is the RIGIDITY MATRIX of the framework (rows = edges, row uv
carries u − v at u's block and −(u − v) at v's block) and b_e = (1 − |D_e|²)/(2p) is the DEFECT — solvable iff the defect
pairs to zero with every SELF-STRESS λ ∈ ker R(H)ᵀ. A 6-critical H (|E| ≥ 5|V|/2) has ≥ |V|/2 + 3 such conditions. If
H is infinitesimally rigid at its residues (rank R = 2|V| − 3), a Laman basis of edges Hensel-lifts UNIQUELY up to p-adic
isometry, the remaining edges either fail at a finite level or all pass, and a lift that passes is ALGEBRAIC — its field
F_H has a degree-one prime above p, and H is a real unit-distance graph iff F_H has a real place. The kernel holds the
level-p² theorem (Proofs/HadwigerNelson/Lift.lean: a stress with a nonzero pairing refutes every lift mod p²; a stress
supported on a sub-framework refutes every lift of the whole); this instrument computes the stresses, the pairing, a
minimal-support witness, and the Newton tower above level 2.

    python3 tools/fplift.py local --core FILE [--prec N] [--out F]        # the local lift test on a core record
    python3 tools/fplift.py local --heule510|--degrey|--seed … --p P [--merge] [--prec N]
                                                                          # …on the reduction of a real stage (injective
                                                                          # sub-reduction by default; --merge identifies
                                                                          # colliding vertices)
    python3 tools/fplift.py cores --p P --k K [--method plane|spheres] [--wall S] [--out F]
                                                                          # a (K+1)-critical subgraph of UD(F_p,2): the
                                                                          # whole-plane refusal (external cadical), the
                                                                          # sphere shrink, the vertex shrink, certified
    python3 tools/fplift.py hubs --degrey|--heule510 … --p P [--min-degree 3] [--prec N] [--out F]
                                                                          # phase B: every residue point with ≥ d
                                                                          # neighbours in the stage's injective reduction,
                                                                          # its local hub test against the stage's own
                                                                          # p-adic embedding, the passers recognized
    python3 tools/fplift.py self-test

VERDICTS (no word means "clean"): obstructed-at-level-k (count / of), passes-to-precision-N, flexible (f), undecided.
What a record licenses: `lift-*`: obstructed-at-level-2 with a witness is a certificate the kernel instance re-checks
(Lift.lean's decide); obstructed-at-level-k > 2 is re-checkable by exact integer arithmetic from the stored level-(k−1)
solution; passes-to-precision-N stores the coordinates mod p^N with every edge unit mod p^N — anyone re-checks with
integers, no solver. `core-*`: the solver's refusal (UNTRUSTED) plus per-vertex necessity witnesses (verified colourings).
UNTRUSTED like everything in tools/."""
from __future__ import annotations
import argparse, hashlib, json, math, os, random, subprocess, sys, time
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "fplane"
BUILD = ROOT / "build" / "m59"


# ---------------------------------------------------------------------- frameworks
def circle(p):
    return [(a, b) for a in range(p) for b in range(p) if (a * a + b * b) % p == 1]


def is_unit(p, u, v):
    return ((u[0] - v[0]) ** 2 + (u[1] - v[1]) ** 2) % p == 1


class Framework:
    """A subgraph H of UD(F_p,2): residue positions in [0,p)² and an oriented edge list of index pairs."""
    def __init__(self, p, verts, edges, name="framework"):
        self.p, self.verts, self.edges, self.name = p, [tuple(v) for v in verts], [tuple(e) for e in edges], name
        for i, (u, v) in enumerate(self.edges):
            assert is_unit(p, self.verts[u], self.verts[v]), \
                f"INSTRUMENT CATASTROPHE: edge #{i} ({u}, {v}) = {self.verts[u]}–{self.verts[v]} is not unit mod {p}"
        assert len(set(self.verts)) == len(self.verts), "INSTRUMENT CATASTROPHE: two vertices share a residue (use --merge)"
    @property
    def n(self): return len(self.verts)
    @property
    def m(self): return len(self.edges)
    def fingerprint(self):
        h = hashlib.sha256(json.dumps([self.p, self.verts, self.edges]).encode()).hexdigest()[:16]
        return h
    def induced(self, keep):
        keep = sorted(keep); idx = {v: i for i, v in enumerate(keep)}
        E = [(idx[u], idx[v]) for u, v in self.edges if u in idx and v in idx]
        return Framework(self.p, [self.verts[v] for v in keep], E, self.name + "-sub")


def load_core(path):
    d = json.loads(Path(path).read_text())
    return Framework(d["p"], d["vertices"], d["edges"], Path(path).stem), d


def plane_framework(p, verts=None):
    """The whole plane (or its induced subgraph on `verts`) as a framework."""
    if verts is None:
        verts = [(x, y) for x in range(p) for y in range(p)]
    idx = {v: i for i, v in enumerate(verts)}; C = circle(p); E = []
    for v in verts:
        for a, b in C:
            w = ((v[0] + a) % p, (v[1] + b) % p)
            if w in idx and idx[w] > idx[v]:
                E.append((idx[v], idx[w]))
    return Framework(p, verts, E, f"plane-p{p}")


def stage_framework(a, p, merge=False):
    """The reduction of a real stage at p (fplane.reduce_stage): the injective sub-reduction (one vertex per residue
    class, the first in the stage's order; edges among kept vertices) or, with merge, the identification of colliding
    vertices with the union of their edges."""
    import additive as AD, fplane as FP
    ch = AD.load_chunk(a)
    rads = ch.frame.primes if hasattr(ch.frame, "primes") else ([3, 11] + ([int(ch.frame.name[1:-3])] if ch.frame.name.endswith("-16") and ch.frame.name != "K8" else []))
    roots = {d: FP.sqrt_mod(d, p) for d in rads}      # None for a radical with no residue: reduce_stage refuses a
    red = FP.reduce_stage(ch, p, roots)                # coordinate that carries it, naming the basis element
    classes = {}
    for i, r in enumerate(red):
        classes.setdefault(r, []).append(i)
    verts = list(classes.keys()); idx = {r: i for i, r in enumerate(verts)}
    if merge:
        E = sorted({(min(idx[red[u]], idx[red[v]]), max(idx[red[u]], idx[red[v]])) for u, v in ch.edges if red[u] != red[v]})
        name = f"{ch.name}-p{p}-merged"
    else:
        rep = {r: js[0] for r, js in classes.items()}; keep = set(rep.values())
        E = sorted({(min(idx[red[u]], idx[red[v]]), max(idx[red[u]], idx[red[v]])) for u, v in ch.edges if u in keep and v in keep})
        name = f"{ch.name}-p{p}"
    fw = Framework(p, verts, E, name)
    fw.meta = dict(stage=ch.label(), roots=roots, points=len(red), distinct=len(verts), collisions=len(red) - len(verts),
                   stage_edges=len(ch.edges), kept_edges=len(E), merge=merge, chunk=ch)
    return fw


# ---------------------------------------------------------------------- linear algebra mod p
def rref_mod(M, p):
    """Reduced row-echelon form of an int64 array mod p (in place on a copy); returns (R, pivot columns)."""
    M = np.array(M, dtype=np.int64) % p; rows, cols = M.shape; r = 0; piv = []
    for c in range(cols):
        if r >= rows:
            break
        nz = np.nonzero(M[r:, c])[0]
        if nz.size == 0:
            continue
        i = r + int(nz[0])
        if i != r:
            M[[r, i]] = M[[i, r]]
        M[r] = (M[r] * pow(int(M[r, c]), -1, p)) % p
        others = np.nonzero(M[:, c])[0]; others = others[others != r]
        if others.size:
            M[others] = (M[others] - np.outer(M[others, c], M[r])) % p
        piv.append(c); r += 1
    return M, piv


def inverse_mod(A, p):
    n = A.shape[0]
    R, piv = rref_mod(np.hstack([A % p, np.eye(n, dtype=np.int64)]), p)
    assert piv[:n] == list(range(n)), "singular"
    return R[:, n:]


def rigidity_matrix(fw):
    p = fw.p; R = np.zeros((fw.m, 2 * fw.n), dtype=np.int64)
    for r, (u, v) in enumerate(fw.edges):
        dx = (fw.verts[u][0] - fw.verts[v][0]) % p; dy = (fw.verts[u][1] - fw.verts[v][1]) % p
        R[r, 2 * u] = dx; R[r, 2 * u + 1] = dy; R[r, 2 * v] = (-dx) % p; R[r, 2 * v + 1] = (-dy) % p
    return R


def stresses(fw):
    """rank R(H) mod p, a Laman basis (pivot edges of Rᵀ), and a basis of the stress space ker Rᵀ (as rows over edges)."""
    p = fw.p; R = rigidity_matrix(fw)
    RT, piv = rref_mod(R.T.copy(), p)            # 2n × m
    rank = len(piv); free = [c for c in range(fw.m) if c not in set(piv)]
    basis = np.zeros((len(free), fw.m), dtype=np.int64)
    for k, f in enumerate(free):
        basis[k, f] = 1
        for i, c in enumerate(piv):
            basis[k, c] = (-RT[i, f]) % p
    return rank, piv, basis


def defects(fw):
    """m_e = (|D_e|² − 1)/p with D_e the integer difference of the [0,p) lifts (the kernel's pairing is Σ λ_e · p·m_e)."""
    p = fw.p; out = []
    for u, v in fw.edges:
        q = (fw.verts[u][0] - fw.verts[v][0]) ** 2 + (fw.verts[u][1] - fw.verts[v][1]) ** 2
        assert (q - 1) % p == 0
        out.append((q - 1) // p)
    return out


def pairing_mod_p(lam, m, p):
    return int(sum(int(l) * mm for l, mm in zip(lam, m))) % p


# ---------------------------------------------------------------------- the local test
def level2(fw, basis, m):
    """The level-p² obstruction: which stress-basis vectors pair nonzero with the defect."""
    p = fw.p
    fails = [k for k in range(basis.shape[0]) if pairing_mod_p(basis[k], m, p) != 0]
    return fails


def min_support_witness(fw, basis, m, fails):
    """A stress with a nonzero pairing of smallest support among the failing basis vectors, then among the stresses of
    the closed neighbourhoods (small over-braced sub-frameworks) — the kernel instance's literal."""
    p = fw.p; best = None
    for k in fails:
        supp = [e for e in range(fw.m) if basis[k, e]]
        if best is None or len(supp) < len(best[1]):
            best = (basis[k], supp)
    # closed neighbourhoods
    adj = {v: set() for v in range(fw.n)}
    for u, v in fw.edges:
        adj[u].add(v); adj[v].add(u)
    for v in range(fw.n):
        keep = sorted(adj[v] | {v})
        if len(keep) > 40:
            continue
        sub = fw.induced(keep)
        if sub.m <= 2 * sub.n - 3:
            continue
        _, _, sb = stresses(sub); sm = defects(sub)
        for k in range(sb.shape[0]):
            if pairing_mod_p(sb[k], sm, p) != 0:
                supp_sub = [e for e in range(sub.m) if sb[k, e]]
                if best is None or len(supp_sub) < len(best[1]):
                    # lift back to the whole framework's edge indices
                    idxmap = {i: keep[i] for i in range(sub.n)}
                    eidx = {(min(a, b), max(a, b)): i for i, (a, b) in enumerate(fw.edges)}
                    lam = np.zeros(fw.m, dtype=np.int64); supp = []
                    for e in supp_sub:
                        a, b = sub.edges[e]; A, B = idxmap[a], idxmap[b]
                        i = eidx[(min(A, B), max(A, B))]
                        sign = 1 if (fw.edges[i] == (A, B)) else -1
                        lam[i] = (sign * int(sb[k, e])) % p; supp.append(i)
                    best = (lam, sorted(supp))
    if best is None:
        return None
    lam, supp = best
    vs = sorted({fw.edges[e][0] for e in supp} | {fw.edges[e][1] for e in supp}); vidx = {v: i for i, v in enumerate(vs)}
    P2 = p * p
    x0 = [fw.verts[v] for v in vs]
    wedges = [[vidx[fw.edges[e][0]], vidx[fw.edges[e][1]], int(lam[e])] for e in supp]
    pairing = sum(int(lam[e]) * ((fw.verts[fw.edges[e][0]][0] - fw.verts[fw.edges[e][1]][0]) ** 2 + (fw.verts[fw.edges[e][0]][1] - fw.verts[fw.edges[e][1]][1]) ** 2 - 1) for e in supp) % P2
    assert pairing % p == 0 and pairing != 0, "INSTRUMENT CATASTROPHE: the witness pairing is not a nonzero multiple of p"
    # the stress condition on the sub-framework, checked directly (what the kernel's IsStress decides)
    net = {v: [0, 0] for v in range(len(vs))}
    for a, b, l in wedges:
        d = (x0[a][0] - x0[b][0], x0[a][1] - x0[b][1])
        net[a][0] += l * d[0]; net[a][1] += l * d[1]; net[b][0] -= l * d[0]; net[b][1] -= l * d[1]
    assert all(net[v][0] % p == 0 and net[v][1] % p == 0 for v in net), "INSTRUMENT CATASTROPHE: the witness is not a stress"
    return dict(vertices=len(vs), edges=len(supp), x0=[list(v) for v in x0], weighted_edges=wedges, pairing_mod_p2=pairing,
                original_vertices=vs, original_edges=supp)


def newton_lift(fw, piv, prec):
    """The gauge-fixed digit-by-digit Hensel lift of a Laman basis (the pivot edges) to precision p^prec, then every
    edge's first failing level (None = unit mod p^prec). Returns (x mod p^prec, per-edge level, gauge)."""
    p = fw.p; n = fw.n; R = rigidity_matrix(fw)
    # gauge: pin vertex 0 and one coordinate of a neighbour w where the edge (0, w) is transverse
    adj0 = [v for u, v in fw.edges if u == 0] + [u for u, v in fw.edges if v == 0]
    assert adj0, "vertex 0 has no edge"
    for w in adj0:
        D = ((fw.verts[w][0] - fw.verts[0][0]) % p, (fw.verts[w][1] - fw.verts[0][1]) % p)
        j = 0 if D[1] != 0 else 1                       # pin coordinate j of w; needs the OTHER component of D nonzero
        pinned = {0, 1, 2 * w + j}
        free = [c for c in range(2 * n) if c not in pinned]
        J = R[piv][:, free]
        if J.shape[0] != J.shape[1]:
            return None, None, dict(reason="not rigid (rank ≠ 2n − 3)")
        try:
            Jinv = inverse_mod(J, p)
        except AssertionError:
            continue
        break
    else:
        return None, None, dict(reason="no transverse gauge found")
    x = [list(v) for v in fw.verts]                    # Python ints, exact
    inv2 = pow(2, -1, p)
    for k in range(1, prec):
        pk = p ** k; mod = p ** (k + 1)
        res = np.array([(((x[u][0] - x[v][0]) ** 2 + (x[u][1] - x[v][1]) ** 2 - 1) // pk) % p for u, v in [fw.edges[e] for e in piv]], dtype=np.int64)
        delta = (-(Jinv @ res) * inv2) % p            # Jacobian = 2R
        for c, d in zip(free, delta):
            x[c // 2][c % 2] = (x[c // 2][c % 2] + pk * int(d)) % mod
    mod = p ** prec
    levels = []
    for u, v in fw.edges:
        q = ((x[u][0] - x[v][0]) ** 2 + (x[u][1] - x[v][1]) ** 2 - 1) % mod
        if q == 0:
            levels.append(None)
        else:
            k = 0
            while q % p == 0:
                q //= p; k += 1
            levels.append(k + 1)
    return x, levels, dict(pinned_vertex=0, pinned_neighbour=w, pinned_coordinate=j)


def local_test(fw, prec=20, want_witness=True):
    t0 = time.time(); p = fw.p
    rank, piv, basis = stresses(fw); m = defects(fw)
    sdim = basis.shape[0]; rigid = (rank == 2 * fw.n - 3); flex = (2 * fw.n - 3) - rank
    fails = level2(fw, basis, m)
    rec = dict(kind="fplane-lift", framework=fw.name, fingerprint=fw.fingerprint(), p=p, n=fw.n, m=fw.m, rank=rank,
               laman_expected=2 * fw.n - 3, rigid=rigid, flex_dim=flex, stress_dim=sdim,
               level2=dict(failing=len(fails), of=sdim))
    if fails:
        rec["verdict"] = "obstructed-at-level-2"
        if want_witness:
            rec["witness"] = min_support_witness(fw, basis, m, fails)
    elif not rigid:
        rec["verdict"] = f"flexible ({flex})"
    else:
        x, levels, gauge = newton_lift(fw, piv, prec)
        if x is None:
            rec["verdict"] = "undecided"; rec["newton"] = gauge
        else:
            failing = [(i, l) for i, l in enumerate(levels) if l is not None]
            rec["newton"] = dict(prec=prec, gauge=gauge, laman_edges=len(piv), remaining=fw.m - len(piv),
                                 first_fail_levels={str(i): l for i, l in failing})
            if failing:
                lvl = min(l for _, l in failing)
                rec["verdict"] = f"obstructed-at-level-{lvl}"; rec["level_k"] = dict(level=lvl, failing=sum(1 for _, l in failing if l == lvl), of=fw.m - len(piv))
            else:
                rec["verdict"] = f"passes-to-precision-{prec}"; rec["coordinates_mod_p_prec"] = x
    rec["seconds"] = round(time.time() - t0, 1)
    rec["claim_scope"] = ("obstructed-at-level-2: the witness stress pairs nonzero with the defect — no lift mod p² (the kernel's "
                          "not_exists_lift_of_stressPairing_ne_zero on the witness sub-framework); obstructed-at-level-k: the Laman-basis "
                          "Hensel lift (unique up to isometry, rigid case) violates an edge at level k — no lift in Z_p²; "
                          "passes-to-precision-N: coordinates mod p^N with every edge unit mod p^N; flexible: not decided here.")
    return rec


def headline(rec):
    s = f"[fplift] {rec['framework']} (n={rec['n']:,}, m={rec['m']:,}, p={rec['p']}): {'rigid' if rec['rigid'] else 'FLEXIBLE'} (rank {rec['rank']:,}{' = 2n − 3' if rec['rigid'] else ' < 2n − 3 = %d' % rec['laman_expected']}), stress dim {rec['stress_dim']:,}; "
    v = rec["verdict"]
    if v == "obstructed-at-level-2":
        s += f"OBSTRUCTED at level 2 — {rec['level2']['failing']:,} of {rec['level2']['of']:,} stress-basis conditions fail"
        w = rec.get("witness")
        if w:
            s += f"; minimal-support witness: {w['edges']} edges on {w['vertices']} vertices, pairing {w['pairing_mod_p2']} ≠ 0 (mod {rec['p']}²)"
    elif v.startswith("obstructed-at-level-"):
        s += f"level 2 passes ({rec['level2']['of']:,} conditions); {v.upper()} — {rec['level_k']['failing']} of {rec['level_k']['of']} remaining edges fail there"
    elif v.startswith("passes"):
        s += f"level 2 passes ({rec['level2']['of']:,} conditions); {v.upper()} — every edge unit mod {rec['p']}^{rec['newton']['prec']}"
    else:
        s += v.upper()
    return s + f"   [{rec['seconds']}s]"


def cmd_local(a):
    if a.core:
        fw, _ = load_core(a.core)
    else:
        fw = stage_framework(a, a.p, merge=a.merge)
        print(f"[fplift] {fw.meta['stage']} at p = {a.p}: {fw.meta['points']:,} points on {fw.meta['distinct']:,} residues ({fw.meta['collisions']} collisions); {'merged image' if a.merge else 'injective sub-reduction'} keeps {fw.meta['kept_edges']:,} of {fw.meta['stage_edges']:,} edges")
    rec = local_test(fw, prec=a.prec)
    print(headline(rec))
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"lift-{fw.name}.json"
    path.write_text(json.dumps(rec, indent=1, default=str)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- cores (phase A): external cadical + shrinks
def cadical_path():
    pre = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()
    return str(Path(pre) / "bin" / "cadical")


def solve_subgraph(p, verts, k, wall, pins=None, tag="ask"):
    """k-colourability of the induced subgraph of UD(F_p,2) on `verts` by the external cadical under `timeout`.
    Returns ('sat', colouring) with the colouring VERIFIED here, ('unsat', None), or ('unknown', None)."""
    idx = {v: i for i, v in enumerate(verts)}; C = circle(p); n = len(verts)
    var = lambda v, c: v * k + c + 1
    cl = []
    for v in range(n):
        cl.append([var(v, c) for c in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                cl.append([-var(v, c1), -var(v, c2)])
    E = []
    for v in verts:
        for a, b in C:
            w = ((v[0] + a) % p, (v[1] + b) % p)
            if w in idx and idx[w] > idx[v]:
                E.append((idx[v], idx[w]))
    for u, v in E:
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    if pins is None:
        pins = [(0, 0)]
        nb = next((v for u, v in E if u == 0), None)
        if nb is not None and k > 1:
            pins.append((nb, 1))
    for v, c in pins:
        if v < n and c < k:
            cl.append([var(v, c)])
    BUILD.mkdir(parents=True, exist_ok=True)
    f = BUILD / f"{tag}-{os.getpid()}.cnf"
    with open(f, "w") as fh:
        fh.write(f"p cnf {n * k} {len(cl)}\n")
        for c in cl:
            fh.write(" ".join(map(str, c)) + " 0\n")
    try:
        r = subprocess.run(["timeout", str(int(wall)), cadical_path(), "-q", str(f)], capture_output=True, text=True)
    finally:
        f.unlink(missing_ok=True)
    out = r.stdout
    if "s UNSATISFIABLE" in out:
        return "unsat", None
    if "s SATISFIABLE" in out:
        lits = set()
        for line in out.splitlines():
            if line.startswith("v "):
                lits.update(int(t) for t in line[2:].split() if t != "0")
        col = [next(c for c in range(k) if var(v, c) in lits) for v in range(n)]
        bad = [(u, v) for u, v in E if col[u] == col[v]]
        assert not bad, ("INSTRUMENT CATASTROPHE: cadical's colouring is not proper", bad[:3])
        return "sat", col
    return "unknown", None


def sphere_of(p, c):
    return [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == c % p]


def shrink_spheres(p, k, wall, spheres, log):
    """Delete whole spheres about the origin while the induced subgraph (origin + remaining spheres) still refuses k
    colours; an unknown keeps the sphere (sound: the surviving set still refuses). Batched destructive pass."""
    cur = list(spheres)
    def ask(S):
        verts = [(0, 0)] + [q for c in S for q in sphere_of(p, c)]
        return solve_subgraph(p, verts, k, wall, tag="sph")[0]
    batch = max(1, len(cur) // 8)
    while batch >= 1:
        progress = True
        while progress:
            progress = False; i = 0
            order = list(cur)
            while i < len(order):
                chunk = [c for c in order[i:i + batch] if c in cur]
                if chunk and len(cur) - len(chunk) >= 1:
                    trial = [c for c in cur if c not in set(chunk)]
                    st = ask(trial)
                    log(f"  spheres {len(cur)} → try {len(trial)}: {st}")
                    if st == "unsat":
                        cur = trial; progress = progress or batch > 1
                i += batch
        batch //= 2
    return cur


def shrink_vertices(p, k, wall, verts, log, protected=frozenset()):
    """1-minimal vertex core by batched destructive deletion (outside-in in the given order), then per-vertex necessity
    witnesses (a verified colouring of core − v for every v) — the M42/M43 discipline."""
    cur = list(verts)
    ask = lambda V: solve_subgraph(p, V, k, wall, tag="vtx")
    assert ask(cur)[0] == "unsat", "the starting set does not refuse"
    batch = max(1, len(cur) // 8)
    while batch >= 1:
        progress = True
        while progress:
            progress = False; i = 0
            order = [v for v in cur if v not in protected]
            while i < len(order):
                chunk = [v for v in order[i:i + batch] if v in cur]
                if chunk and len(cur) - len(chunk) >= 1:
                    trial = [v for v in cur if v not in set(chunk)]
                    st, _ = ask(trial)
                    if st == "unsat":
                        cur = trial; progress = progress or batch > 1
                        log(f"  vertices {len(cur) + len(chunk)} → {len(cur)} (batch {batch})")
                i += batch
        batch //= 2
    witnesses = {}; undecided = []
    for v in list(cur):
        st, col = ask([w for w in cur if w != v])
        if st == "sat":
            witnesses[str(v)] = col
        elif st == "unsat":
            raise AssertionError(f"INSTRUMENT CATASTROPHE: {v} deletable after the shrink claimed 1-minimality")
        else:
            undecided.append(v)
    return cur, witnesses, undecided


def cmd_cores(a):
    p, k = a.p, a.k; t0 = time.time()
    BUILD.mkdir(parents=True, exist_ok=True)
    logf = open(BUILD / f"cores-p{p}-k{k}-{a.method}.log", "a")
    def log(s):
        print(s, flush=True); logf.write(s + "\n"); logf.flush()
    log(f"[fplift cores] UD(F_{p},2) at k = {k}, method {a.method}, wall {a.wall}s per ask")
    if a.method == "plane":
        verts = [(x, y) for x in range(p) for y in range(p)]
        st, _ = solve_subgraph(p, verts, k, a.wall, tag="plane")
        log(f"  whole plane ({len(verts)} vertices): {st} [{time.time() - t0:.0f}s]")
        if st != "unsat":
            rec = dict(kind="fplane-core", p=p, k=k, method="plane", outcome=f"whole-plane-{st}", seconds=round(time.time() - t0))
            path = Path(a.out) if a.out else DATA / f"core-p{p}-k{k}-{a.method}.json"; path.write_text(json.dumps(rec, indent=1)); return rec
        start = verts
    else:
        spheres = list(range(1, p))
        verts = [(0, 0)] + [q for c in spheres for q in sphere_of(p, c)]
        st, _ = solve_subgraph(p, verts, k, a.wall, tag="sph")
        log(f"  origin + all {len(spheres)} spheres ({len(verts)} vertices): {st} [{time.time() - t0:.0f}s]")
        if st != "unsat":
            rec = dict(kind="fplane-core", p=p, k=k, method="spheres", outcome=f"all-spheres-{st}", seconds=round(time.time() - t0))
            path = Path(a.out) if a.out else DATA / f"core-p{p}-k{k}-{a.method}.json"; path.write_text(json.dumps(rec, indent=1)); return rec
        spheres = shrink_spheres(p, k, a.wall, spheres, log)
        log(f"  sphere-minimal: {len(spheres)} spheres {spheres} [{time.time() - t0:.0f}s]")
        start = [(0, 0)] + [q for c in spheres for q in sphere_of(p, c)]
    core, wit, und = shrink_vertices(p, k, a.wall, start, log, protected=frozenset([(0, 0)]) if a.method == "spheres" else frozenset())
    fw = plane_framework(p, core)
    rec = dict(kind="fplane-core", p=p, k=k, method=a.method, n=fw.n, m=fw.m, vertices=[list(v) for v in fw.verts], edges=[list(e) for e in fw.edges],
               fingerprint=fw.fingerprint(), certification=dict(core_unsat="cadical (untrusted)", one_minimal=not und, necessity_witnesses=len(wit), undecided=[list(v) for v in und]),
               quadrances=sorted({(x * x + y * y) % p for x, y in fw.verts}), seconds=round(time.time() - t0),
               claim_scope="the core's refusal is the solver's claim; every vertex's necessity is a VERIFIED colouring of core − v; 1-minimal iff no deletion was undecided")
    log(f"  core: {fw.n} vertices, {fw.m} edges, {len(rec['quadrances'])} quadrances about the origin; 1-minimal {rec['certification']['one_minimal']} ({len(wit)} witnesses, {len(und)} undecided) [{time.time() - t0:.0f}s]")
    path = Path(a.out) if a.out else DATA / f"core-p{p}-k{k}-{a.method}.json"
    path.write_text(json.dumps(rec, indent=1)); log(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- hubs (phase B): the local hub test against a real lift
def hensel_sqrt(d, p, prec):
    """A root of x² = d in Z_p to precision p^prec from its residue (d a nonzero square mod p)."""
    import fplane as FP
    r = FP.sqrt_mod(d, p); assert r not in (None, 0), f"√{d} has no simple residue mod {p}"
    mod = p
    for _ in range(prec):
        mod = mod * mod
        r = (r - (r * r - d) * pow(2 * r, -1, mod)) % mod
    return r % (p ** prec)


def embed_stage(ch, p, prec):
    """The stage's coordinates in Z_p² to precision p^prec through the Hensel-lifted roots of its radicands."""
    assert ch.frame.name.startswith("field16"), "embed_stage: field16 frames only"
    mod = p ** prec; primes, denom = ch.frame.primes, ch.frame.denom
    import fplane as FP
    roots = {q: (hensel_sqrt(q, p, prec) if FP.sqrt_mod(q, p) not in (None, 0) else None) for q in primes}
    basis = []
    for mask in range(16):
        r = 1
        for i, q in enumerate(primes):
            if mask >> i & 1:
                r = None if (r is None or roots[q] is None) else r * roots[q] % mod
        basis.append(r)
    invd = pow(denom, -1, mod); out = []
    for pt in ch.points:
        xs = [int(c * denom) for c in pt[:16]]; ys = [int(c * denom) for c in pt[16:]]
        for m in range(16):
            if basis[m] is None:
                assert xs[m] == 0 and ys[m] == 0, f"a coordinate carries a radical with no residue mod {p} (basis element {m})"
        out.append((sum(xs[m] * basis[m] for m in range(16) if basis[m] is not None) * invd % mod,
                    sum(ys[m] * basis[m] for m in range(16) if basis[m] is not None) * invd % mod))
    return out, roots


def hub_test(p, w, nbrs, prec):
    """Digit-by-digit: y ∈ Z_p² with |ŵ + p·y − x*_v|² = 1 for every neighbour x*_v (known to precision p^prec).
    Returns (first failing level or None, the point mod p^prec, the rank of the direction system)."""
    x = [w[0], w[1]]
    Ds = [((w[0] - v[0]) % p, (w[1] - v[1]) % p) for v in nbrs]
    A = np.array(Ds, dtype=np.int64); Ar, piv = rref_mod(A.copy(), p); rk = len(piv)
    inv2 = pow(2, -1, p)
    for k in range(1, prec):
        pk = p ** k; mod = p ** (k + 1)
        rhs = np.array([(((x[0] - v[0]) ** 2 + (x[1] - v[1]) ** 2 - 1) // pk) % p for v in nbrs], dtype=np.int64)
        # solve 2⟨D_v, δ⟩ ≡ −rhs_v (mod p) for δ ∈ F_p²
        M = np.hstack([A % p, ((-rhs * inv2) % p).reshape(-1, 1)])
        Mr, pv = rref_mod(M, p)
        if 2 in pv:                                   # inconsistent
            return k + 1, None, rk
        delta = [0, 0]
        for i, c in enumerate(pv):
            delta[c] = int(Mr[i, 2])
        x[0] = (x[0] + pk * delta[0]) % mod; x[1] = (x[1] + pk * delta[1]) % mod
    return None, x, rk


def cmd_hubs(a):
    import additive as AD
    p, prec = a.p, a.prec; t0 = time.time()
    fw = stage_framework(a, p, merge=False); ch = fw.meta["chunk"]
    emb, roots = embed_stage(ch, p, prec)
    # the kept representative per residue class (the injective sub-reduction) and its p-adic coordinates
    classes = {}
    import fplane as FP
    red = FP.reduce_stage(ch, p, fw.meta["roots"])
    for i, r in enumerate(red):
        classes.setdefault(r, i)
    # control: the embedding reduces to the residues, and every stage edge is unit to precision
    mod = p ** prec
    assert all((emb[i][0] % p, emb[i][1] % p) == red[i] for i in range(len(red))), "INSTRUMENT CATASTROPHE: the embedding does not reduce to the residues"
    bad = [(u, v) for u, v in ch.edges if ((emb[u][0] - emb[v][0]) ** 2 + (emb[u][1] - emb[v][1]) ** 2 - 1) % mod]
    assert not bad, ("INSTRUMENT CATASTROPHE: a stage edge is not unit in the p-adic embedding", bad[:3])
    C = circle(p); have = set(classes)
    pts_by_res = {r: emb[i] for r, i in classes.items()}
    rows = []; counts = {}
    for x in range(p):
        for y in range(p):
            w = (x, y)
            if w in have:
                continue
            nb = [((w[0] - c[0]) % p, (w[1] - c[1]) % p) for c in C]
            nb = [r for r in nb if r in have]
            d = len(nb)
            if d < a.min_degree:
                continue
            lvl, pt, rk = hub_test(p, w, [pts_by_res[r] for r in nb], prec)
            counts[d] = counts.get(d, 0) + 1
            rows.append(dict(residue=list(w), degree=d, direction_rank=rk, verdict=(f"passes-to-precision-{prec}" if lvl is None else f"obstructed-at-level-{lvl}"), point=pt))
    passers = [r for r in rows if r["verdict"].startswith("passes")]
    lvl2 = sum(1 for r in rows if r["verdict"] == "obstructed-at-level-2")
    rec = dict(kind="fplane-hubs", stage=fw.meta["stage"], p=p, prec=prec, min_degree=a.min_degree, injective_vertices=len(have),
               candidates=len(rows), by_degree=counts, obstructed_at_2=lvl2, passers=len(passers), rows=rows, seconds=round(time.time() - t0),
               claim_scope="candidates = residue points outside the injective sub-reduction with ≥ min_degree neighbours in it; the hub test is against the stage's own p-adic embedding (its actual coordinates, so no Newton is involved); a passer is a residue class carrying a p-adic point at unit distance from all its neighbours to the stated precision — a real hub of the stage over some field with a degree-one prime above p iff it is algebraic (recognize)")
    print(f"[fplift hubs] {fw.meta['stage']} at p = {p} (prec {prec}): {len(have):,} injective residues; {len(rows):,} candidate residue points with ≥ {a.min_degree} neighbours (by degree {dict(sorted(counts.items()))}); obstructed at level 2: {lvl2:,}; PASS to precision {prec}: {len(passers):,}   [{rec['seconds']}s]")
    for r in passers[:20]:
        print(f"    passer {r['residue']} degree {r['degree']}: point mod p^{prec} = {r['point']}")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"hubs-{ch.name}-p{p}.json"
    path.write_text(json.dumps(rec, indent=1, default=str)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- self-test
def spindle_framework(p):
    """The Moser spindle's residues at a usable prime of K (from the certified coordinates: the seed's frame), via the
    spindle inside tools/… — here built directly from the finite-plane geometry of §S2: rhombi at 60° and the rotation
    with trace 5/3; the framework the real spindle reduces to (up to isometry)."""
    C = circle(p); S = set(C)
    def mul(u, v): return ((u[0] * v[0] - u[1] * v[1]) % p, (u[0] * v[1] + u[1] * v[0]) % p)
    w = next(c for c in C if (2 * c[0]) % p == 1)                    # primitive 6th root: trace 1
    a = (1, 0); b = mul(a, w); t1 = ((a[0] + b[0]) % p, (a[1] + b[1]) % p)
    inv3 = pow(3, -1, p); tr = 5 * inv3 % p
    rho = next((c for c in C if (2 * c[0]) % p == tr), None)
    assert rho is not None, f"no spindle rotation at p = {p}"
    a2, b2, t2 = mul(a, rho), mul(b, rho), mul(t1, rho)
    verts = [(0, 0), a, b, t1, a2, b2, t2]
    E = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (0, 4), (0, 5), (4, 5), (4, 6), (5, 6), (3, 6)]
    return Framework(p, verts, E, f"spindle-p{p}")


def self_test():
    fails = []
    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}")
        if not cond:
            fails.append(name)
    print("[self-test] fplift: planted controls")
    # 1. the collinear triangle at 3: the kernel's numbers (Lift.lean spec): obstructed at level 2, pairing 6 mod 9
    tri = Framework(3, [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 2), (0, 2)], "tri3")
    r = local_test(tri, prec=5)
    check(f"collinear triangle of UD(F_3,2): obstructed at level 2 with witness pairing {r.get('witness', {}).get('pairing_mod_p2')} (the kernel decides 6 in ZMod 9)",
          r["verdict"] == "obstructed-at-level-2" and r["witness"]["pairing_mod_p2"] in (3, 6))
    # 2. the hex shell at 11: passes level 2 with the kernel's residues; rigid? (7 vertices, 12 edges: one stress) — and Newton
    hexx = [(0, 0), (1, 0), (6, 3), (5, 3), (10, 0), (5, 8), (6, 8)]
    hexE = [(0, 1), (1, 2), (0, 2), (2, 3), (0, 3), (3, 4), (0, 4), (4, 5), (0, 5), (5, 6), (0, 6), (6, 1)]
    hx = Framework(11, hexx, hexE, "hex11"); r = local_test(hx, prec=12)
    check(f"the closed hex shell at 11 (the kernel's spec data): level 2 passes (stress dim {r['stress_dim']}), rigid, Newton passes to precision 12 — verdict {r['verdict']}",
          r["stress_dim"] == 1 and r["level2"]["failing"] == 0 and r["verdict"] == "passes-to-precision-12")
    # 3. the Moser spindle at 83 and 131 (11 a residue: unramified degree-one primes of K) lifts — rigid, no stress,
    #    Newton to precision 12; at 11 (RAMIFIED in Q(√11): the spindle's coordinates live in Z_11[√11], not Z_11) its
    #    residue framework is degenerate (the antipodal copy) and OBSTRUCTED — the instrument sees ramification; at 23
    #    (11 a non-residue) the spindle does not reduce at all
    for p in (83, 131):
        sp = spindle_framework(p); r = local_test(sp, prec=12)
        check(f"the Moser spindle at {p} (unramified): rigid, no stress, Newton to precision 12 — {r['verdict']}", r["rigid"] and r["stress_dim"] == 0 and r["verdict"] == "passes-to-precision-12")
    sp = spindle_framework(11); r = local_test(sp, prec=5)
    check(f"planted: the Moser spindle at 11 (RAMIFIED in Q(√11)) is obstructed — it is the shadow of a Z_11[√11]-configuration, not a Z_11 one (stress dim {r['stress_dim']}, {r['verdict']})", r["verdict"] == "obstructed-at-level-2")
    try:
        spindle_framework(23); check("planted: no spindle at 23 (11 is a non-residue) — it should be absent", False)
    except AssertionError:
        check("planted: no spindle at 23 (11 is a non-residue mod 23)", True)
    # 4. a 4-cycle (a rhombus without its diagonal) is flexible (1)
    sp = spindle_framework(11)
    rh = Framework(11, [sp.verts[i] for i in (0, 1, 3, 2)], [(0, 1), (1, 2), (2, 3), (3, 0)], "rhombus-open")
    r = local_test(rh, prec=5); check(f"planted: an open rhombus at 11 is flexible — {r['verdict']}", r["verdict"] == "flexible (1)")
    # 5. the hub test on the hex shell's Newton lift at 11: no residue point has ≥ 3 shell neighbours there, so the
    #    control is the degree-2 face (a glue point exists p-adically iff its discriminant is a nonzero square mod p,
    #    which a residue solution with transverse directions already says): every degree-2 candidate with direction
    #    rank 2 passes to precision 12 — and a planted corruption of one neighbour's coordinate at level 2 makes the
    #    same candidates fail at a finite level
    hx = Framework(11, hexx, hexE, "hex11"); r = local_test(hx, prec=12); X = r["coordinates_mod_p_prec"]
    have = {v: i for i, v in enumerate(hexx)}; C11 = circle(11); cands = []
    for x in range(11):
        for y in range(11):
            w = (x, y)
            if w in have:
                continue
            nb = [((w[0] - c[0]) % 11, (w[1] - c[1]) % 11) for c in C11]; nb = [have[q] for q in nb if q in have]
            if len(nb) >= 2:
                cands.append((w, nb))
    res = [hub_test(11, w, [tuple(X[i]) for i in nb], 12) for w, nb in cands]
    n2 = sum(1 for (w, nb), (lvl, pt, rk) in zip(cands, res) if len(nb) == 2 and rk == 2)
    ok2 = sum(1 for (w, nb), (lvl, pt, rk) in zip(cands, res) if len(nb) == 2 and rk == 2 and lvl is None)
    n3 = sum(1 for w, nb in cands if len(nb) >= 3)
    check(f"the hub test on the hex shell at 11: {len(cands)} candidates with ≥ 2 shell neighbours ({n3} with ≥ 3); the {n2} transverse degree-2 candidates all pass to precision 12 ({ok2} pass)", n2 > 0 and ok2 == n2)
    #    the degree-3 face: a rim vertex of the shell has three shell neighbours (the origin and its two rim neighbours);
    #    as a candidate hub against their Newton coordinates it passes (it is real); with the origin's coordinate
    #    corrupted at level 2 the 3 × 2 system is inconsistent at a finite level — the planted red of the hub test
    lvl, pt, rk = hub_test(11, hexx[1], [tuple(X[0]), tuple(X[2]), tuple(X[6])], 12)
    check(f"the hub test, degree 3: rim vertex 1 of the hex shell against its three neighbours' Newton coordinates passes to precision 12 (rank {rk}, {lvl})", lvl is None and rk == 2)
    Xbad = [list(v) for v in X]; Xbad[0][0] = (Xbad[0][0] + 11) % 11 ** 12
    lvlb, _, _ = hub_test(11, hexx[1], [tuple(Xbad[0]), tuple(X[2]), tuple(X[6])], 12)
    check(f"planted: with the origin's coordinate corrupted at level 2 the same degree-3 candidate fails at level {lvlb}", lvlb is not None)
    # 5b. a planted false edge on the spindle, at the first usable prime where one exists
    for pp in (11, 83, 107, 131):
        sp = spindle_framework(pp); S = set(circle(pp))
        false = next(((i, j) for i in range(7) for j in range(i + 1, 7) if (i, j) not in set(sp.edges) and (j, i) not in set(sp.edges) and ((sp.verts[i][0] - sp.verts[j][0]) % pp, (sp.verts[i][1] - sp.verts[j][1]) % pp) in S), None)
        if false is not None:
            fe = Framework(pp, sp.verts, sp.edges + [false], "spindle-false"); r = local_test(fe, prec=5)
            check(f"planted: the spindle at {pp} plus the false edge {false} is obstructed at level 2 (stress dim {r['stress_dim']}, pairing {r.get('witness', {}).get('pairing_mod_p2')})", r["verdict"] == "obstructed-at-level-2")
            break
    else:
        check("planted false edge on the spindle: no plane edge among non-adjacent spindle residues at 11, 83, 107, 131 (control not applicable)", True)
    # 6. Heule-510's injective sub-reduction: at 131 (unramified in its field Q(√3,√5,√11)) it is a real configuration and
    #    passes level 2 and Newton; at 11 (ramified) it is obstructed — the same ramification reading as the spindle
    class A: pass
    a = A()
    for k_ in ("seed", "object", "witness", "heule510", "degrey", "field16", "graph", "planted"): setattr(a, k_, None)
    a.heule510 = True
    fw = stage_framework(a, 131); r = local_test(fw, prec=6, want_witness=False)
    check(f"Heule-510's injective sub-reduction at 131 ({fw.n} residues of 510, {fw.m} edges): level 2 passes ({r['level2']['of']} conditions), {r['verdict']}",
          r["level2"]["failing"] == 0 and r["verdict"].startswith("passes"))
    fw11 = stage_framework(a, 11); r11 = local_test(fw11, prec=4, want_witness=False)
    check(f"planted: Heule-510's injective sub-reduction at 11 (ramified: {fw11.n} residues, {fw11.m} edges) is obstructed — {r11['verdict']}", r11["verdict"] == "obstructed-at-level-2")
    # 7. planted corruption: a moved vertex on the hex shell breaks the unit check loudly
    try:
        Framework(11, [(0, 0), (1, 0), (6, 3), (5, 3), (10, 0), (5, 8), (6, 9)], hexE, "hex11-bad"); check("planted: a moved vertex is refused by the framework loader", False)
    except AssertionError as e:
        check(f"planted: a moved vertex is refused loudly ({str(e)[:60]}…)", "CATASTROPHE" in str(e))
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


# ---------------------------------------------------------------------- cli
def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    def stage_args(q):
        q.add_argument("--seed", action="store_true"); q.add_argument("--object"); q.add_argument("--witness"); q.add_argument("--heule510", action="store_true")
        q.add_argument("--degrey", action="store_true"); q.add_argument("--field16"); q.add_argument("--graph"); q.add_argument("--planted")
    q = sub.add_parser("local"); q.add_argument("--core"); stage_args(q); q.add_argument("--p", type=int); q.add_argument("--merge", action="store_true")
    q.add_argument("--prec", type=int, default=20); q.add_argument("--out"); q.set_defaults(f=cmd_local)
    q = sub.add_parser("cores"); q.add_argument("--p", type=int, required=True); q.add_argument("--k", type=int, required=True)
    q.add_argument("--method", choices=["plane", "spheres"], default="spheres"); q.add_argument("--wall", type=float, default=600); q.add_argument("--out"); q.set_defaults(f=cmd_cores)
    q = sub.add_parser("hubs"); stage_args(q); q.add_argument("--p", type=int, required=True); q.add_argument("--min-degree", type=int, default=3)
    q.add_argument("--prec", type=int, default=20); q.add_argument("--out"); q.set_defaults(f=cmd_hubs)
    q = sub.add_parser("self-test"); q.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))
    a = ap.parse_args(); a.f(a)


if __name__ == "__main__":
    main()
