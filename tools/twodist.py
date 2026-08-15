#!/usr/bin/env python3
"""M49 — the two-distance descent. UNTRUSTED (like everything in tools/): every claim that matters
reaches the kernel through `emit_cert.py` / `emit_mask.py`, or is reported as tools-side with its
controls; nothing here is believed on its own say-so.

The objects: finite graphs in the plane whose edges are pairs at distance 1 OR at distance 2 (a
{1,2}-graph). Points live in the seam field ℚ(√3,√11) and are held EXACTLY, on the 4-coefficient
basis the Exoo–Ismailescu paper uses —

    [a, b, c, d]  :=  ( (a√3 + b√11)/12 ,  (c + d√33)/12 ),   a,b,c,d ∈ ℚ

— so that dist² between two points is (3α²+11β²+γ²+33δ² + 2(αβ+γδ)√33)/144 and
    dist² = r   ⟺   3α²+11β²+γ²+33δ² = 144·r  ∧  αβ + γδ = 0,
an integer identity, no float anywhere near a verdict (floats only PROPOSE, in `classify`'s grid).
Export to the kernel is through `field.py`'s 16-int vectors at a common denominator (mask order:
1 ↦ 0, √3 ↦ 1, √11 ↦ 8, √33 ↦ 9), which `emit_cert.py` turns into a `PtTable`.

The dial: μ(d) := the fewest d-edges any non-5-colourable {1,d}-graph needs. μ = 0 is χ(ℝ²) ≥ 6;
μ = 1 already implies it (`OneDefect.add_one_le_chromaticNumber_unitDistance_of_one_defect`). Every
number this tool reports about μ is an UPPER bound within the probed pools and is named `mu_upper`
— there is no field named `mu`. A `mu_upper ≤ 1` at k = 5 does not write a row: it raises the
halt-and-verify banner (`Jackpot`).

Row contract (plans/M49-two-distance-descent.md §Cʹʹʹ.5): every row carries `kind`,
`stage_fingerprint`, `pool_fingerprint`, `cap`, `outcome ∈ {sat, unsat, unknown}` and a
`claim_scope` sentence; a removal is `removed` only with `unsat` + `reencode == unsat` + a 1-minimal
halo with necessity witnesses — `record()` refuses anything less.

Usage:
    tools/twodist.py --self-test
    tools/twodist.py --seed            # rebuild E–I's G, H, K from the paper's data; check every count
    tools/twodist.py --ports           # the palette port set for the Forces gadget on H, and the cubes
    tools/twodist.py --emit            # build/onetwo_cert.json + Aug/Ports Lean text + the pins
    tools/twodist.py --count           # exact colouring counts of G and H up to palette
    tools/twodist.py --edge-critical [--orders N]   # phase 2: 1-minimal distance-2 edge subsets
"""
from __future__ import annotations

import hashlib
import json
import os
import random
import sys
import time
from fractions import Fraction as F
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO / "tools"))
import coloring  # noqa: E402
import forcer  # noqa: E402
import rigidity  # noqa: E402
from arity import _brk  # noqa: E402

BUILD = REPO / "build"
K = 5


class Jackpot(SystemExit):
    """μ ≤ 1 at five colours is χ(ℝ²) ≥ 6. Never recorded as a row; halt and verify."""


# ---------------------------------------------------------------- exact points on the 4-basis

Pt = tuple  # (a, b, c, d) of Fractions


def pt(a, b, c, d) -> Pt:
    return (F(a), F(b), F(c), F(d))


def refl_x(p: Pt) -> Pt:
    a, b, c, d = p
    return (a, b, -c, -d)


def refl_y(p: Pt) -> Pt:
    a, b, c, d = p
    return (-a, -b, c, d)


def rot60(p: Pt) -> Pt:
    """Rotation by π/3 about the origin: (x,y) ↦ (x/2 − y√3/2, x√3/2 + y/2), read on the basis."""
    a, b, c, d = p
    return ((a - c) / 2, (b - 3 * d) / 2, (3 * a + c) / 2, (b + d) / 2)


def rot_about(p: Pt, centre: Pt, cos_: F, sin_coef: F) -> Pt:
    """Rotation about `centre` by an angle with cos = cos_ and sin = sin_coef·√11 (the seam field's
    rotations of this shape: arccos 49/50 has sin = 3√11/50). Derived once on the basis:
      x' = cos·x − sin·y,  y' = sin·x + cos·y  with  sin·y = sin_coef·(c√11 + 11d√3)/12,
      sin·x = sin_coef·(3a·√33/... ) — see the coefficient lines below."""
    a, b, c, d = (p[i] - centre[i] for i in range(4))
    s = sin_coef
    # sin·y: s√11·(c + d√33)/12 = (11 s d √3 + s c √11)/12  →  a: -11 s d, b: -s c
    # sin·x: s√11·(a√3 + b√11)/12 = (11 s b + s a √33)/12  →  c: 11 s b, d: s a
    na = cos_ * a - 11 * s * d
    nb = cos_ * b - s * c
    nc = cos_ * c + 11 * s * b
    nd = cos_ * d + s * a
    return (na + centre[0], nb + centre[1], nc + centre[2], nd + centre[3])


def dist2_key(p: Pt, q: Pt) -> tuple[F, F]:
    """(rational part × 144, √33 part × 72) of dist²: dist² = r ⟺ key == (144 r, 0)."""
    al, be, ga, de = (p[i] - q[i] for i in range(4))
    return (3 * al * al + 11 * be * be + ga * ga + 33 * de * de, al * be + ga * de)


def dist2_is(p: Pt, q: Pt, r: int) -> bool:
    return dist2_key(p, q) == (F(144 * r), F(0))


def dedup(pts: list[Pt]) -> list[Pt]:
    seen, out = set(), []
    for p in pts:
        if p not in seen:
            seen.add(p)
            out.append(p)
    return out


def approx(p: Pt) -> tuple[float, float]:
    a, b, c, d = (float(x) for x in p)
    return ((a * 3 ** 0.5 + b * 11 ** 0.5) / 12, (c + d * 33 ** 0.5) / 12)


# ---------------------------------------------------------------- the seeds (Exoo–Ismailescu 2020)

EI_S = [(0, 0, 0, 0), (0, 0, 0, -4), (0, 0, -6, -2), (0, 0, -6, 2), (-6, 0, 0, -2), (-4, 0, 0, 0),
        (-4, 0, -6, -2), (-4, 0, -6, 2), (-2, 0, 0, -2), (-2, 0, -6, -4), (-2, 0, -6, 4),
        (0, -6, -6, 0), (-5, -3, 3, 3), (-5, 3, -3, 3), (-2, -6, 0, 0), (-2, -6, 0, -4),
        (-2, 6, 0, 0), (-2, 6, 0, -4), (-6, -6, 0, 0), (-6, 6, 0, 0), (-4, 0, 0, -4),
        (0, 0, -12, 0), (-8, 0, 0, 0)]
EI_EXTRA = [(-2, 0, 0, -6), (8, 0, 0, 4), (-4, -6, -6, -4), (-4, 6, 6, -4), (-3, -3, -3, -5),
            (-4, 0, -12, 4), (-4, 0, 12, 4), (7, -3, 3, 3), (7, 3, -3, 3)]
EI_A = pt(-2, 0, 0, -6)
EI_B = pt(8, 0, 0, 4)
# The paper's counts, planted as controls: a rebuild that disagrees halts.
EI_COUNTS = {"T": 57, "V": 205, "G": (966, 423), "H": 214, "Hedges": (1004, 446),
             "K": 426, "Kedges": (2009, 892), "AB2": 25}


def ei_G() -> list[Pt]:
    S = [pt(*p) for p in EI_S]
    T = dedup(S + [refl_x(p) for p in S] + [refl_y(p) for p in S])
    assert len(T) == EI_COUNTS["T"], ("T", len(T))
    V, cur = [], T
    for _ in range(6):
        V += cur
        cur = [rot60(p) for p in cur]
    V = dedup(V)
    assert len(V) == EI_COUNTS["V"], ("V", len(V))
    return V


def ei_H() -> list[Pt]:
    H = dedup(ei_G() + [pt(*p) for p in EI_EXTRA])
    assert len(H) == EI_COUNTS["H"], ("H", len(H))
    assert dist2_is(EI_A, EI_B, EI_COUNTS["AB2"]), "|AB|² ≠ 25"
    return H


def ei_K() -> list[Pt]:
    H = ei_H()
    Hrot = [rot_about(p, EI_A, F(49, 50), F(3, 50)) for p in H]
    Kp = dedup(H + Hrot)
    assert len(Kp) == EI_COUNTS["K"], ("K", len(Kp))
    Bp = rot_about(EI_B, EI_A, F(49, 50), F(3, 50))
    assert dist2_is(EI_B, Bp, 1), "|BB'| ≠ 1"
    return Kp


# ---------------------------------------------------------------- classification (float proposes, exact disposes)

def classify(pts: list[Pt], radii=(1, 4), window: float = 1e-6) -> dict[int, list[tuple[int, int]]]:
    """Every pair at exact squared distance r for r in `radii`. A grid over float positions proposes
    candidates within `window` of √r; the exact key disposes. Planted assertion (the M48 lesson):
    the exact test on a known unit pair must return True, or the whole classification is void."""
    xy = [approx(p) for p in pts]
    cell = 1.0
    grid: dict[tuple[int, int], list[int]] = {}
    for i, (x, y) in enumerate(xy):
        grid.setdefault((int(x // cell), int(y // cell)), []).append(i)
    out = {r: [] for r in radii}
    rmax = max(r ** 0.5 for r in radii) + 1e-3
    reach = int(rmax // cell) + 1
    for (gx, gy), members in grid.items():
        for dx in range(-reach, reach + 1):
            for dy in range(-reach, reach + 1):
                other = grid.get((gx + dx, gy + dy))
                if not other:
                    continue
                for i in members:
                    for j in other:
                        if j <= i:
                            continue
                        dd = ((xy[i][0] - xy[j][0]) ** 2 + (xy[i][1] - xy[j][1]) ** 2) ** 0.5
                        for r in radii:
                            if abs(dd - r ** 0.5) < window and dist2_is(pts[i], pts[j], r):
                                out[r].append((i, j))
    for r in radii:
        out[r].sort()
    return out


def fingerprint(n: int, edges) -> str:
    """The stage fingerprint of tools/arity.py, so rows here can be matched against M48's."""
    return hashlib.sha256(repr((n, tuple(sorted(tuple(sorted(e)) for e in edges)))).encode()).hexdigest()[:16]


# ---------------------------------------------------------------- SAT

def _brk_full(n: int, k: int, order) -> list[list[int]]:
    """`arity._brk` plus the clause it omits at t = 0 (the first vertex wears colour 0), so that
    the canonical form is unique: exactly ONE representative per palette orbit — needed for
    counting, harmless for refuting."""
    return _brk(n, k, order) + [[-coloring.var(order[0], c, k)] for c in range(1, k)]


def _degree_order(n: int, edges) -> list[int]:
    deg = [0] * n
    for i, j in edges:
        deg[i] += 1
        deg[j] += 1
    return sorted(range(n), key=lambda v: -deg[v])


def refute(n: int, edges, k: int = K, pins=None, breaking: bool = True, cap: float | None = None):
    """(outcome, model-colours-or-None, seconds). Base + at-most-one, plus EITHER first-occurrence
    palette breaking over the degree order (sound for palette-invariant questions) OR explicit pins
    (never both: pins name colours, breaking assumes they are unnamed). A model is decoded and
    re-validated in-process before it is returned."""
    assert not (pins and breaking), "pins name colours; breaking assumes they are unnamed"
    cls = coloring.base_clauses(n, list(edges), k) + rigidity.amo_clauses(n, k)
    if breaking:
        cls += _brk_full(n, k, _degree_order(n, edges))
    if pins:
        cls += coloring.pin_clauses(list(pins), k)
    t = time.time()
    st, model = forcer._solve(cls, n * k, cap)
    dt = time.time() - t
    if st == "sat":
        col = rigidity.decode(model, n, k)
        for i, j in edges:
            if col[i] == col[j]:
                raise SystemExit(f"model violates edge {(i, j)} — solver or decoder is broken")
        return "sat", col, dt
    return st, None, dt


def count_colourings(n: int, edges, k: int = K, cap_count: int = 10000, cap: float | None = None):
    """Exact number of proper k-colourings up to palette: first-occurrence breaking gives one
    representative per orbit; blocking clauses enumerate. Returns (count, exact: bool, colourings)."""
    cls = coloring.base_clauses(n, list(edges), k) + rigidity.amo_clauses(n, k)
    cls += _brk_full(n, k, _degree_order(n, edges))
    found = []
    while len(found) < cap_count:
        st, model = forcer._solve(cls, n * k, cap)
        if st == "unsat":
            return len(found), True, found
        if st != "sat":
            return len(found), False, found
        col = rigidity.decode(model, n, k)
        found.append(col)
        cls.append([-coloring.var(v, col[v], k) for v in range(n)])
    return len(found), False, found


# ---------------------------------------------------------------- the seed's ports and cubes

def neighbours(n: int, edges) -> list[set[int]]:
    adj = [set() for _ in range(n)]
    for i, j in edges:
        adj[i].add(j)
        adj[j].add(i)
    return adj


def triangle_at(v: int, adj: list[set[int]], avoid=()) -> tuple[int, int] | None:
    """Two neighbours of v that are adjacent to each other (v lies on a triangle), preferring the
    pair with the largest degree sum; None if v is on no triangle."""
    best, bestscore = None, -1
    for a in adj[v]:
        if a in avoid:
            continue
        for b in adj[v] & adj[a]:
            if b <= a or b in avoid:
                continue
            score = len(adj[a]) + len(adj[b])
            if score > bestscore:
                best, bestscore = (a, b), score
    return best


def canon_patterns_with(m: int, k: int, fixed_distinct: list[int]):
    """Canonical patterns (first-occurrence numbering) on m ports in which the ports listed in
    `fixed_distinct` are pairwise distinct — the ones a clique's edge gadgets do not already kill."""
    out = []
    for pat in coloring.canon_patterns(k, m):
        if len({pat[i] for i in fixed_distinct}) == len(fixed_distinct):
            out.append(pat)
    return out


def design_ports(pts: list[Pt], iA: int, iB: int, cls) -> dict:
    """The port tuple for the Forces gadget on H: (A, a1, a2, B) if A lies on a triangle (3 cubes to
    refute: B ∈ {a1's colour, a2's colour, fresh}), else (A, B, t1, t2, t3) with a palette triangle
    (13 cubes). Returns the ports, the patterns to refute (those with A ≠ B and the clique rainbow),
    and the survivors expected (those with A = B)."""
    n = len(pts)
    edges = cls[1] + cls[4]
    adj = neighbours(n, edges)
    tri = triangle_at(iA, adj, avoid=(iB,))
    if tri is not None:
        ports = [iA, tri[0], tri[1], iB]
        clique = [0, 1, 2]
        pa, pb = 0, 3
    else:
        t = None
        best = -1
        for v in range(n):
            tv = triangle_at(v, adj, avoid=(iA, iB))
            if tv is not None:
                s = len(adj[v]) + len(adj[tv[0]]) + len(adj[tv[1]])
                if s > best and v not in (iA, iB):
                    best, t = s, (v, tv[0], tv[1])
        ports = [iA, iB, t[0], t[1], t[2]]
        clique = [2, 3, 4]
        pa, pb = 0, 1
    pats = canon_patterns_with(len(ports), K, clique)
    refute_pats = [p for p in pats if p[pa] != p[pb]]
    survive_pats = [p for p in pats if p[pa] == p[pb]]
    return {"ports": ports, "clique_ports": clique, "pa": pa, "pb": pb,
            "refute": refute_pats, "survive": survive_pats}


# ---------------------------------------------------------------- the forced-pair core (vertex shrink)

def forces_pair(n: int, edges, design: dict, cap: float) -> tuple[bool, dict]:
    """A = B forced on the graph: every A ≠ B cube UNSAT. `unknown` reads as NOT forced (conservative
    for a shrink: an unknown deletion is rejected, never accepted)."""
    for pat in design["refute"]:
        pins = [(design["ports"][t], pat[t]) for t in range(len(design["ports"]))]
        st, _, _ = refute(n, edges, K, pins=pins, breaking=False, cap=cap)
        if st != "unsat":
            return False, {"pattern": pat, "outcome": st}
    return True, {}


def induced(edges, keep) -> list[tuple[int, int]]:
    ks = set(keep)
    return [(i, j) for i, j in edges if i in ks and j in ks]


def shrink_core(pts: list[Pt], cls, design: dict, cap: float = 120.0, seed: int = 0,
                log=print) -> dict:
    """1-minimal VERTEX core of H that still forces A = B (ports protected), by
    `mechanism.greedy_1min` over a seeded random order, followed by the necessity census: every
    survivor's deletion must un-force (a colouring separating A and B is stored as its witness).
    Returns the core in ORIGINAL indices plus the census."""
    import mechanism
    n = len(pts)
    E = cls[1] + cls[4]
    protect = set(design["ports"])
    ok, why = forces_pair(n, E, design, cap)
    if not ok:
        raise SystemExit(f"the seed does not force A = B under cap {cap}: {why}")
    order = [v for v in range(n) if v not in protect]
    random.Random(seed).shuffle(order)
    t = time.time()
    core, dels, passes = mechanism.greedy_1min(list(range(n)), order,
                                               lambda keep: forces_pair(n, induced(E, keep), design, cap))
    log(f"core {len(core)} vertices after {passes} passes ({time.time() - t:.0f}s)")
    # necessity census, in parallel
    def necessary(v):
        if v in protect:
            return v, "port", None
        keep = [w for w in core if w != v]
        Es = induced(E, keep)
        for pat in design["refute"]:
            pins = [(design["ports"][t], pat[t]) for t in range(len(design["ports"]))]
            st, col, _ = refute(n, Es, K, pins=pins, breaking=False, cap=cap * 4)
            if st == "sat":
                return v, "necessary", col
            if st == "unknown":
                return v, "unknown", None
        return v, "REDUNDANT", None
    rows = mechanism.pmap(necessary, list(core))
    census = {str(v): st for v, st, _ in rows}
    witnesses = {str(v): col for v, st, col in rows if st == "necessary"}
    bad = [v for v, st, _ in rows if st == "REDUNDANT"]
    unknown = [v for v, st, _ in rows if st == "unknown"]
    if bad:
        raise SystemExit(f"shrink invariant violated: survivors {bad} are deletable — the engine is broken")
    return {"core": sorted(core), "deletions": dels, "passes": passes, "seed": seed, "cap": cap,
            "necessity": {"complete": not unknown, "unknown": unknown, "witnesses": len(witnesses)},
            "necessity_witnesses": witnesses}


def densify(pts: list[Pt], cls, keep: list[int]) -> tuple[list[Pt], dict, dict]:
    """Restrict to `keep` (sorted original ids), re-index densely; classification re-derived on the
    restricted points and checked against the induced lists (a planted equality)."""
    keep = sorted(keep)
    dense = {u: i for i, u in enumerate(keep)}
    sub = [pts[u] for u in keep]
    csub = classify(sub)
    for r in (1, 4):
        want = sorted((dense[i], dense[j]) for i, j in cls[r] if i in dense and j in dense)
        assert csub[r] == want, f"re-classification of the core disagrees with the induced list at r={r}"
    return sub, csub, dense


# ---------------------------------------------------------------- export to the kernel

def to_field16(p: Pt, denom: int) -> list[list[int]]:
    """[x16, y16] integer coefficient vectors at `denom` in field.py mask order."""
    a, b, c, d = p
    x = [0] * 16
    y = [0] * 16
    for coef, idx, vec in ((a, 1, x), (b, 8, x), (c, 0, y), (d, 9, y)):
        v = coef * denom / 12
        assert v.denominator == 1, ("denominator", p, denom)
        vec[idx] = int(v)
    return [x, y]


def common_denom(pts: list[Pt]) -> int:
    """The least D such that every coefficient a/12 of every point satisfies a·D/12 ∈ ℤ:
    D = 12 · lcm of the coefficients' denominators (the coefficients are the `a` in `a/12`)."""
    from math import lcm
    D = 1
    for p in pts:
        for coef in p:
            D = lcm(D, coef.denominator)
    return 12 * D


def emit_seed_lean(pts: list[Pt], cls, iA: int, iB: int, design: dict, denom: int, out: Path,
                   name: str = "oneTwo") -> None:
    """Write the certificate JSON (emit_cert.py format), the Aug/Ports Lean text, and the pins."""
    n = len(pts)
    coords = [to_field16(p, denom) for p in pts]
    unit = [list(e) for e in cls[1]]
    two = [list(e) for e in cls[4]]
    cert = {"names": [f"ei:{i}" for i in range(n)], "denom": denom, "coords": coords,
            "edges": unit, "primes": [3, 5, 7, 11]}
    (out / f"{name}_cert.json").write_text(json.dumps(cert))
    (out / f"{name}_aug.json").write_text(json.dumps({"n": n, "edges": unit + two}))
    ports = design["ports"]
    lines = []
    lines.append(f"/-- The {len(two)} distance-2 pairs of the seed (every such pair among its points; "
                 f"`{name}_pairs_complete` pins that). -/")
    lines.append(f"def {name}Pairs : List (Fin {n} × Fin {n}) :=\n  [" +
                 ", ".join(f"({i},{j})" for i, j in two) + "]\n")
    lines.append(f"/-- The forced pair: `A = ei:{iA}`, `B = ei:{iB}`, at distance 5. -/")
    lines.append(f"def {name}A : Fin {n} := {iA}\ndef {name}B : Fin {n} := {iB}\n")
    lines.append(f"/-- The gadget's ports: {ports} — A, a palette triangle, B. -/")
    lines.append(f"def {name}Ports : Fin {len(ports)} → Fin {n} := ![" + ", ".join(map(str, ports)) + "]\n")
    (out / f"{name}_aug.lean.txt").write_text("\n".join(lines))
    pins = {"ports": ports, "refute": design["refute"], "survive": design["survive"],
            "cubes": [[[ports[t], pat[t]] for t in range(len(ports))] for pat in design["refute"]]}
    (out / f"{name}_pins.json").write_text(json.dumps(pins, indent=1))
    print(f"emitted {name}: cert ({len(unit)} unit edges, denom {denom}), aug ({len(unit)+len(two)}), "
          f"{len(design['refute'])} cubes on ports {ports}")


# ---------------------------------------------------------------- the descent (phases 3–4)
#
# Runs in the CLOSURE currency (tools/closure.py: a point is (x16, y16) of Fractions on the shared
# 16-basis, complex arithmetic in tools/couple.py), so the 122-core calibration object and the E–I
# seed go through ONE code path. `to_closure` converts the E–I 4-basis; nothing is lost.

def to_closure(p: Pt):
    import couple as C
    a, b, c, d = p
    return C.frac_c({1: a / 12, 8: b / 12}, {0: c / 12, 9: d / 12})


def closure_two_pairs(pts) -> list[tuple[int, int]]:
    """Exact distance-2 pairs in closure currency (float proposes, exact `nsq == 4` disposes)."""
    import closure as CL
    xy = [CL.approx(p) for p in pts]
    out = []
    n = len(pts)
    grid: dict[tuple[int, int], list[int]] = {}
    for i, (x, y) in enumerate(xy):
        grid.setdefault((int(x // 1), int(y // 1)), []).append(i)
    target = [F(0)] * CL.DIM
    target[0] = F(4)
    for (gx, gy), mem in grid.items():
        for dx in range(-3, 4):
            for dy in range(-3, 4):
                oth = grid.get((gx + dx, gy + dy))
                if not oth:
                    continue
                for i in mem:
                    for j in oth:
                        if j <= i:
                            continue
                        dd = ((xy[i][0] - xy[j][0]) ** 2 + (xy[i][1] - xy[j][1]) ** 2) ** 0.5
                        if abs(dd - 2.0) < 1e-6 and CL.nsq(CL.csub(pts[i], pts[j])) == target:
                            out.append((i, j))
    return sorted(out)


def closure_unit_edges(pts) -> list[tuple[int, int]]:
    import closure as CL
    return CL.unit_edges(pts)


def pool_seam(base_pts, centres, gens_named=None):
    """One generation of the seam group (ζ₆, σ, and the Moser twist ρ = ζ₆³σ⁻²) about the given
    centres, applied to every base point — the seam-field halo. Returns the NEW points only."""
    import closure as CL
    gens = gens_named or [("zeta6", CL.Z6), ("sigma", CL.SEAM)]
    g = CL.close_gen(base_pts, centres, gens)
    return g["pts"][len(base_pts):], g["fusions"]


def pool_up(base_pts, centres):
    """One generation of the half-spindle generators √ρ₁₅, √ρ₆₃ (and ρ₁₅) about the centres — the
    one-field-up halo, where the k = 4 kills of distance-2 monos lived."""
    import closure as CL
    g = CL.close_gen(base_pts, centres, [("rho15", CL.RHO15), ("half15", CL.HALF15),
                                          ("half63", CL.HALF63)])
    return g["pts"][len(base_pts):], g["fusions"]


def descend_step(base_pts, unit_e, two_e, target: tuple[int, int], pool_pts, k: int, cap: float,
                 shrink_halo: bool = True) -> dict:
    """ONE descent question: with the halo `pool_pts` added (unit edges only — a halo point's
    distance-2 pairs are NOT edges), is the object with the target distance-2 edge REMOVED still
    not k-colourable? Returns the row (verdict per the contract). On UNSAT the halo is shrunk
    1-minimal (vertices) with a necessity witness per survivor, and the 3-bit re-encode is run at
    k = 5 (skipped, and said so, at other k)."""
    import mechanism
    nb = len(base_pts)
    allpts = list(base_pts) + list(pool_pts)
    n = len(allpts)
    ue = closure_unit_edges(allpts)
    # planted assertion: the base's own unit edges must reappear exactly
    base_ue = set(e for e in ue if e[0] < nb and e[1] < nb)
    assert base_ue == set(unit_e), "halo classification lost or invented a base unit edge"
    tp = [e for e in two_e if e != target]
    assert len(tp) == len(two_e) - 1, "target is not a distance-2 edge of the base"
    E = ue + tp
    fp_stage = fingerprint(nb, list(unit_e) + list(two_e))
    fp_pool = fingerprint(n, ue)
    st, _, dt = refute(n, E, k, cap=cap)
    row = {"kind": "removal", "k": k, "target": list(target), "stage_fingerprint": fp_stage,
           "pool_fingerprint": fp_pool, "pool_size": len(pool_pts), "cap": cap, "outcome": st,
           "seconds": round(dt, 1), "claim_scope": "one distance-2 edge removed, unit halo added; "
           "unsat = the halo does that edge's job in context (a removal); sat = it does not, for THIS "
           "pool; unknown = undecided at cap"}
    if st != "unsat":
        row["verdict"] = "refused" if st == "sat" else "unknown"
        return row
    row["verdict"] = "candidate-removal"
    if k == 5:
        r = rigidity.class_avoid_binary3(n, ue, tp, cap=cap * 4)
        row["reencode"] = r["outcome"]
    else:
        row["reencode"] = "not-run-at-k!=5"
    if shrink_halo:
        halo_ids = list(range(nb, n))
        def fired(keep):
            ks = set(keep) | set(range(nb))
            Es = [e for e in ue if e[0] in ks and e[1] in ks] + tp
            s2, _, _ = refute(n, Es, k, cap=cap)
            return s2 == "unsat", {}
        core, dels, passes = mechanism.greedy_1min(halo_ids, list(reversed(halo_ids)), fired)
        wit = 0
        unknown = 0
        for v in core:
            keep = set(core) - {v} | set(range(nb))
            Es = [e for e in ue if e[0] in keep and e[1] in keep] + tp
            s3, col, _ = refute(n, Es, k, cap=cap * 4)
            if s3 == "sat":
                wit += 1
            elif s3 == "unknown":
                unknown += 1
            else:
                raise SystemExit("halo shrink invariant violated: a survivor is deletable")
        row["halo"] = {"one_minimal": unknown == 0, "size": len(core), "witnesses": wit,
                       "unknown": unknown, "passes": passes}
        if unknown == 0 and (k != 5 or row["reencode"] == "unsat"):
            row["verdict"] = "removed"
    return row


def load_core122():
    """The M33/M34 122-core as a {1,2}-graph in closure currency: 122 points of
    `closure.hexagram_points(2)`, 421 unit edges, 40 distance-2 pairs (build/core122_*.json,
    dense ids). Both lists are RE-DERIVED here from the points and compared to the stored ones."""
    import closure as CL
    core = json.loads((BUILD / "m33-core-hexchunkB2-eq-pair-2.json").read_text())
    ids = core["vertices"]
    hp, _, _ = CL.hexagram_points(2)
    pts = [hp[u] for u in ids]
    aug = json.loads((BUILD / "core122_aug.json").read_text())
    ue = closure_unit_edges(pts)
    tp = closure_two_pairs(pts)
    stored = [tuple(e) for e in aug["edges"]]
    assert len(ue) == 421 and set(ue) == set(stored[:421]), "122-core unit edges do not re-derive"
    assert len(tp) == 40 and set(tp) == set(stored[421:]), "122-core distance-2 pairs do not re-derive"
    return pts, ue, tp


def edge_critical(n: int, unit_e, two_e, k: int, cap: float, seed: int = 0, log=print) -> dict:
    """1-minimal subset of the distance-2 edges keeping the graph not k-colourable (greedy over a
    seeded order), with the necessity census. mu_upper := its size."""
    import mechanism
    E1 = list(unit_e)
    E2 = list(two_e)
    def fired(sub):
        s_, _, _ = refute(n, E1 + [E2[i] for i in sub], k, cap=cap)
        return s_ == "unsat", {}
    ok, _ = fired(list(range(len(E2))))
    if not ok:
        raise SystemExit("the object is not refuted with ALL its distance-2 edges under cap")
    order = list(range(len(E2)))
    random.Random(seed).shuffle(order)
    core, dels, passes = mechanism.greedy_1min(list(range(len(E2))), order, fired)
    wit, unk = 0, 0
    for i in core:
        s2, col, _ = refute(n, E1 + [E2[j] for j in core if j != i], k, cap=cap * 4)
        if s2 == "sat":
            wit += 1
        elif s2 == "unknown":
            unk += 1
        else:
            raise SystemExit("edge-critical invariant violated: a survivor is deletable")
    return {"essential": [list(E2[i]) for i in sorted(core)], "mu_upper": len(core), "passes": passes,
            "necessity": {"complete": unk == 0, "witnesses": wit, "unknown": unk}, "seed": seed}


def phase_calib122(cap: float = 60.0, orders: int = 2) -> None:
    """Phase 3: the k = 4 calibration on the 122-core — essential distance-2 edges (P4a), then the
    seam halo (P4b: predicted to remove NONE) and the one-field-up halo (P4c) on each essential
    edge's orbit representative."""
    import closure as CL
    pts, ue, tp = load_core122()
    n = len(pts)
    path = BUILD / "m49-calib122.json"
    fp = fingerprint(n, ue + tp)
    st, _, dt = refute(n, ue + tp, 4, cap=cap)
    print(f"122-core as {{1,2}}-graph at k=4: {st} ({dt:.1f}s) [expected unsat]", flush=True)
    st1, _, _ = refute(n, ue, 4, cap=cap)
    print(f"  unit part alone at k=4: {st1} [control: expected sat]", flush=True)
    best = None
    for sd in range(orders):
        r = edge_critical(n, ue, tp, 4, cap, seed=sd)
        print(f"  order {sd}: mu_upper {r['mu_upper']} of 40, necessity {r['necessity']}", flush=True)
        record(path, {"kind": "edge-critical", "k": 4, "stage_fingerprint": fp, "pool_fingerprint": None,
                      "cap": cap, "outcome": "unsat", "mu_upper": r["mu_upper"], "seed": sd,
                      "essential": r["essential"], "necessity": r["necessity"],
                      "claim_scope": "a 1-minimal distance-2 edge subset of the 122-core keeping it "
                      "not 4-colourable; mu_upper is an upper bound on the minimum, from one greedy order"})
        if best is None or r["mu_upper"] < best["mu_upper"]:
            best = r
    ess = [tuple(e) for e in best["essential"]]
    two_e = ess
    # halos about each essential edge's endpoints
    for e in ess:
        centres = [pts[e[0]], pts[e[1]]]
        for label, mk in (("seam", pool_seam), ("up", pool_up)):
            halo, fus = mk(pts, centres)
            row = descend_step(pts, ue, two_e, e, halo, 4, cap)
            row.update({"pool": label, "fusions": fus, "mu_upper": len(two_e) - (1 if row["verdict"] == "removed" else 0)})
            record(path, row)
            print(f"  edge {e} pool {label} ({len(halo)} pts): {row['verdict']} "
                  f"({row['outcome']}, {row['seconds']}s)", flush=True)
            if row["verdict"] == "removed":
                break


# ---------------------------------------------------------------- rows

def record(path: Path, row: dict) -> None:
    """Append a row under the contract. Refuses: a `removed` verdict without its triple; a `mu` field
    (only `mu_upper` exists); a summary without a headline; any row lacking `claim_scope`."""
    if "mu" in row:
        raise SystemExit("rows carry `mu_upper`, never `mu`")
    if row.get("kind") == "summary" and "headline" not in row:
        raise SystemExit("a summary row must carry a headline")
    if "claim_scope" not in row:
        raise SystemExit("every row carries a claim_scope sentence")
    if row.get("verdict") == "removed":
        need = row.get("outcome") == "unsat" and row.get("reencode") == "unsat" and \
            isinstance(row.get("halo"), dict) and row["halo"].get("one_minimal") is True and \
            isinstance(row["halo"].get("witnesses"), int)
        if not need:
            raise SystemExit("a `removed` row needs outcome unsat + reencode unsat + a 1-minimal halo "
                             "with necessity witnesses; downgrade the verdict instead")
    if row.get("kind") in ("stall", "removal") and row.get("mu_upper") is not None and \
            row.get("k", K) == 5 and row["mu_upper"] <= 1:
        raise Jackpot("μ_upper ≤ 1 at five colours: χ(ℝ²) ≥ 6 — HALT AND VERIFY: re-derive the graph "
                      "independently, re-refute in a second encoding, report before interpreting")
    art = json.loads(path.read_text()) if path.exists() else {"schema": "m49 v1", "rows": []}
    art["rows"].append(row)
    path.write_text(json.dumps(art, indent=1))


# ---------------------------------------------------------------- phases

def phase_seed(cap: float = 900.0) -> dict:
    """Rebuild G, H, K from the paper's data, check the counts, and time the refutations."""
    G = ei_G()
    cG = classify(G)
    assert (len(cG[1]), len(cG[4])) == EI_COUNTS["G"], (len(cG[1]), len(cG[4]))
    H = ei_H()
    cH = classify(H)
    assert (len(cH[1]), len(cH[4])) == EI_COUNTS["Hedges"], (len(cH[1]), len(cH[4]))
    Kp = ei_K()
    cK = classify(Kp)
    assert (len(cK[1]), len(cK[4])) == EI_COUNTS["Kedges"], (len(cK[1]), len(cK[4]))
    print("seed counts: all reproduce the paper (T 57, V 205, G 966+423, H 214/1004+446, K 426/2009+892)")
    iA, iB = H.index(EI_A), H.index(EI_B)
    rows = {}
    for nm, pts, c in (("G", G, cG), ("H", H, cH)):
        st, _, dt = refute(len(pts), c[1] + c[4], K, cap=cap)
        print(f"  {nm} at k=5 with breaking: {st} ({dt:.1f}s)  [expected sat]")
        rows[nm] = st
    st, _, dt = refute(len(Kp), cK[1], K, cap=cap)
    print(f"  K unit-only at k=5: {st} ({dt:.1f}s)  [control: expected sat]")
    st6, _, dt = refute(len(Kp), cK[1] + cK[4], 6, cap=cap)
    print(f"  K at k=6: {st6} ({dt:.1f}s)  [control: expected sat]")
    return {"H": H, "cH": cH, "iA": iA, "iB": iB, "K": Kp, "cK": cK}


def phase_ports(cap: float = 900.0) -> dict:
    s = phase_seed(cap)
    H, cH, iA, iB = s["H"], s["cH"], s["iA"], s["iB"]
    n = len(H)
    d = design_ports(H, iA, iB, cH)
    print(f"ports {d['ports']} (A at index {d['pa']}, B at {d['pb']}, clique ports {d['clique_ports']}); "
          f"{len(d['refute'])} cubes to refute, {len(d['survive'])} expected survivors {d['survive']}")
    edges = cH[1] + cH[4]
    tot = 0.0
    for pat in d["refute"]:
        pins = [(d["ports"][t], pat[t]) for t in range(len(d["ports"]))]
        st, _, dt = refute(n, edges, K, pins=pins, breaking=False, cap=cap)
        tot += dt
        print(f"  cube {pat}: {st} ({dt:.1f}s)")
        if st != "unsat":
            print("  !! a cube did not refute — the port design must change (or the seed is wrong)")
    for pat in d["survive"]:
        pins = [(d["ports"][t], pat[t]) for t in range(len(d["ports"]))]
        st, _, dt = refute(n, edges, K, pins=pins, breaking=False, cap=cap)
        print(f"  survivor {pat}: {st} ({dt:.1f}s)  [expected sat: A = B is realized]")
    print(f"total refutation time {tot:.1f}s")
    return {"seed": s, "design": d}


def phase_emit(cap: float = 900.0) -> None:
    r = phase_ports(cap)
    H, cH, iA, iB = r["seed"]["H"], r["seed"]["cH"], r["seed"]["iA"], r["seed"]["iB"]
    denom = common_denom(H)
    BUILD.mkdir(exist_ok=True)
    emit_seed_lean(H, cH, iA, iB, r["design"], denom, BUILD)


def phase_count(cap: float = 300.0) -> None:
    G = ei_G()
    cG = classify(G)
    c, exact, _ = count_colourings(len(G), cG[1] + cG[4], K, cap=cap)
    print(f"G: {c} colourings up to palette (exact={exact})  [paper: 18]")
    H = ei_H()
    cH = classify(H)
    c, exact, cols = count_colourings(len(H), cH[1] + cH[4], K, cap=cap)
    iA, iB = H.index(EI_A), H.index(EI_B)
    print(f"H: {c} colourings up to palette (exact={exact})  [paper: 35]; A=B in all: "
          f"{all(x[iA] == x[iB] for x in cols)}")


# ---------------------------------------------------------------- self-test

def self_test() -> None:
    # 1. exact arithmetic: a unit pair, a distance-2 pair, and a moved point failing both
    o = pt(0, 0, 0, 0)
    one = pt(0, 0, 12, 0)     # (0, 1)
    twoo = pt(0, 0, 24, 0)    # (0, 2)
    assert dist2_is(o, one, 1) and dist2_is(o, twoo, 4) and not dist2_is(o, one, 4)
    moved = pt(1, 0, 12, 0)   # (√3/12, 1): unit? no
    assert not dist2_is(o, moved, 1)
    z6 = rot60(one)           # ζ₆ scaled: (√3/2, 1/2)?? rot60 of (0,1) = (-√3/2, 1/2)
    assert dist2_is(o, z6, 1) and dist2_is(one, z6, 1), "rotation by π/3 is not a unit rotation"
    # 2. classification proposes and disposes; a shuffled edge list keeps its fingerprint
    pts = [o, one, twoo, z6]
    c = classify(pts)
    assert c[1] == [(0, 1), (0, 3), (1, 2), (1, 3)] and c[4] == [(0, 2)], c
    assert fingerprint(4, c[1]) == fingerprint(4, list(reversed(c[1])))
    # 3. the rhombus at k=3 reads forced-equal (pins A=0,B=1 refute; A=B realizable)
    rh = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3)]
    st, _, _ = refute(4, rh, 3, pins=[(0, 0), (3, 1)], breaking=False)
    assert st == "unsat", "rhombus tips not forced equal at k=3?!"
    st, _, _ = refute(4, rh, 3, pins=[(0, 0), (3, 0)], breaking=False)
    assert st == "sat"
    cnt, exact, _ = count_colourings(4, rh, 3)
    assert (cnt, exact) == (1, True), (cnt, exact)   # one colouring up to palette
    # 4. the record contract: a fake removal without its triple is refused; `mu` is refused;
    #    the jackpot raises
    tmp = BUILD / "m49-selftest.json"
    if tmp.exists():
        tmp.unlink()
    BUILD.mkdir(exist_ok=True)
    try:
        record(tmp, {"kind": "removal", "verdict": "removed", "outcome": "unsat", "claim_scope": "x",
                     "stage_fingerprint": "f", "pool_fingerprint": None, "cap": 1})
        raise AssertionError("an uncertified removal was recorded")
    except SystemExit as e:
        assert not isinstance(e, Jackpot) and "removed" in str(e)
    try:
        record(tmp, {"kind": "stall", "mu": 3, "claim_scope": "x"})
        raise AssertionError("`mu` was accepted")
    except SystemExit as e:
        assert "mu_upper" in str(e)
    try:
        record(tmp, {"kind": "stall", "mu_upper": 1, "k": 5, "claim_scope": "x",
                     "stage_fingerprint": "f", "pool_fingerprint": None, "cap": 1, "outcome": "unsat"})
        raise AssertionError("μ_upper = 1 was recorded instead of halting")
    except Jackpot:
        pass
    record(tmp, {"kind": "stall", "mu_upper": 7, "k": 5, "claim_scope": "an upper bound on μ within the "
                 "probed pools; not a bound on μ", "stage_fingerprint": "f", "pool_fingerprint": None,
                 "cap": 1, "outcome": "unsat"})
    tmp.unlink()
    print("twodist self-test: PASS")


if __name__ == "__main__":
    args = sys.argv[1:]
    cap = float(next((args[i + 1] for i, a in enumerate(args) if a == "--cap"), 900))
    if "--self-test" in args:
        self_test()
    elif "--seed" in args:
        phase_seed(cap)
    elif "--ports" in args:
        phase_ports(cap)
    elif "--emit" in args:
        phase_emit(cap)
    elif "--count" in args:
        phase_count(cap)
    elif "--calib122" in args:
        phase_calib122(cap, int(next((args[i + 1] for i, a in enumerate(args) if a == "--orders"), 2)))
    elif "--core" in args:
        seed = int(next((args[i + 1] for i, a in enumerate(args) if a == "--seed"), 0))
        s_ = phase_seed(cap)
        d = design_ports(s_["H"], s_["iA"], s_["iB"], s_["cH"])
        res = shrink_core(s_["H"], s_["cH"], d, cap=cap, seed=seed)
        BUILD.mkdir(exist_ok=True)
        (BUILD / f"onetwo-core-seed{seed}.json").write_text(json.dumps(res))
        print(f"core: {len(res['core'])} vertices, necessity {res['necessity']}")
    else:
        print(__doc__)
