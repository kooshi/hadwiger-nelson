#!/usr/bin/env python3
"""Coupled circle systems: the M21 instrument suite, promoted (subplan §4).

UNTRUSTED, like everything in `tools/`. Every reading here is triage; a killed pattern
pair becomes a claim only through the kernel route (each ambient kill is a pin-cube
UNSAT — exactly `Fan.of_unsat`'s cube form). A bug here can cost a theorem, never buy one.

## What each subcommand measures

* `--census` — for every pivot pair of the closure: cross-chord count between cover
  sets, exact d² (16-vector field arithmetic, no floats in any verdict), far/near split
  (far = disjoint cover sets). The M21 §0-A finding: coupling is generic (4,615 of 4,678
  vertices are pivots, ~1.1M coupled pairs), the far spectrum is the ℚ(√33) seam family,
  and the strongest far coupling sits at d² = 1.
* `--phase` — exact multiplicative-relation search `u^{2m}·σ^l·ζ₆^k = 1` (u the coupling
  phase `(q−p)/d`, σ the M19 seam, |m|,|l| ≤ 6, k ∈ 0..5), via the u² trick: only even
  powers of u, so the search never needs `d` itself, only `d²`. §0-C finding: NO relation
  at any probed pair — the coupled automaton is not finite-state on the naive quotient.
* `--joint A B` — the 2-pivot extension profile at a far pair: sampled pattern pairs
  (π_a pinned concretely — spending the colour symmetry — π_b as a partition with free
  palette), one SAT verdict each. Verification is BUILT IN, never separable: every
  ambient kill is re-tested through the independent pin-only injection encoding (M20's
  validated path) before it is reported. §0-B finding at (695,2044), k=5: 785/1500
  killed by the 40 cross chords alone, 229/715 of the locally-feasible killed by the
  ambient graph; the null pair is flat.
* `--pair` — the d = 1 two-pivot system generated exactly in the seam field ℚ(√3,√11):
  six moves (ζ₆, σ, σ⁻¹ about each pivot), membership on the four circles re-derived at
  insertion, every exact unit pair (float prefilter, exact confirm), SAT at k = 4 with
  the k = 3 control (must be UNSAT — each half contains the cap's 9-point witness).
* `--mesh` — sector-colouring meshability at d = 1 (triage, stdout): pairs of 60°-sector
  colourings under reflection × palette injection × continuous relative rotation ψ,
  tested against sampled cross-chord curves (families oo/oi/io/ii) and the 8 glue
  points, layered so the killing constraint family is named. §0-D finding: nothing
  survives; the outer–outer family alone kills nearly everything.
* `--floor A B` — the coupled coverage floor: forbid-last-t on S_a ∪ S_b. §0 finding:
  floor 3 at the coupled AND the null pair — coupling is pattern-selective, never
  floor-raising.

## Honesty notes

* The joint sampler is a seeded greedy walk, NOT uniform: verdicts are facts about the
  sampled pattern pairs; coverage claims are bounded to the sampled frame.
* The §0 artifacts in `build/m21-*.json` were produced by this suite's session-mortal
  ancestors. The deterministic instruments (census, phase, pair) reproduce those
  artifacts' numbers and are validated against them; the sampled instruments (joint,
  mesh) reproduce the phenomenon, not the sample frame — their controls, not artifact
  identity, are what make them trustworthy.
* Enumeration caps are MANDATORY everywhere (the M20 OOM lesson); every refusal is by
  name: enumeration cap hit, foreign artifact digest, non-far pair, sampler dead-end.

## Controls (`--self-test`, each watched failing where it should)

* Hall-violation control: a pattern pair whose π_b classes cannot injectively take
  colours must die in the LOCAL checker, before any SAT call.
* σ/ζ₆ phantom-relation control, both directions: a planted true relation (u = ζ₆) must
  be found; the seam's non-relation (`seam_pow_ne_one`'s tool-side shadow) must not be.
* The §0.4 regressions, on tiny fixtures: distsq returns a LIST (the census's
  list-vs-tuple zero-pivot bug), and the joint checker consumes GLOBAL indices (the
  double-reindex crash).
* Sampler properness + canonicity + the dead-end refusal.
* Mesh-curve residual sanity: every sampled (α,β) satisfies its chord equation to 1e-9;
  single-system sector properness (the sector family really is proper on one system,
  so a mesh failure is about the PAIR).
* The enumeration cap and the foreign-artifact digest, refused by name.
* The pin-only k=3 SAT-layer path: a fully-pinned monochrome triangle is unsat through
  the solver (the closure-scale pin-only control stays a documented invocation:
  `--joint A B --k 3 --force-sat` on the closure, M20 precedent).

    python3 tools/couple.py --self-test
    python3 tools/couple.py --census
    python3 tools/couple.py --phase
    python3 tools/couple.py --joint 695 2044 --samples 1500 --null 1611 408
    python3 tools/couple.py --pair --depth 20
    python3 tools/couple.py --mesh
    python3 tools/couple.py --floor 695 2044
"""
from __future__ import annotations

import argparse
import json
import math
import random
import time
from collections import Counter
from fractions import Fraction
from itertools import permutations
from pathlib import Path

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))

from field import (DIM, PRIMES, TAB, add, sub, neg, mul, const, root, distsq,
                   is_square, squarefree)  # noqa: E402
from forcer import _solve  # noqa: E402
from coloring import base_clauses, var  # noqa: E402
from extend import (load_closure, pivot_S, induced, canon,
                    enum_canonical)  # noqa: E402

REPO = Path(__file__).resolve().parent.parent
BUILD = REPO / "build"
R13 = Fraction(1, 3)
DEFAULT_K = 5
DEFAULT_BUDGET = 60.0

# basis-index shorthands: bit k of the index means √PRIMES[k] is carried
B1, B3, B11, B33 = 0, 1, 8, 9   # 1, √3, √11, √33  (PRIMES = [3, 5, 7, 11])


def fvec(**comp) -> list[int]:
    """A field vector from named basis components, e.g. fvec(b0=1, b3=1)."""
    v = [0] * DIM
    for name, c in comp.items():
        v[int(name[1:])] = c
    return v


# ------------------------------------------------------------------ complex over the field
# a "cnum" is a pair (x, y) of field vectors; exact complex arithmetic, no floats

def cmul(a, b):
    (ax, ay), (bx, by) = a, b
    return (sub(mul(ax, bx), mul(ay, by)), add(mul(ax, by), mul(ay, bx)))


def cconj(a):
    return (a[0], neg(a[1]))


def cscale(v, a):
    """Real field-vector `v` times cnum `a`."""
    return (mul(v, a[0]), mul(v, a[1]))


def cpow(a, n: int):
    out = (const(1), const(0))
    for _ in range(n):
        out = cmul(out, a)
    return out


CZETA6 = (fvec(b0=1), fvec(b1=1))       # 2·ζ₆  = 1 + i√3
CSEAM = (fvec(b1=1), fvec(b9=1))        # 6·σ   = √3 + i√33   (the M19 seam)
CSEAMRATIO = (fvec(b0=1), fvec(b8=1))   # 6·σ/√3 = 1 + i√11   (M20's seamRatio, ×6)


def to_float(v) -> float:
    return sum(c * math.sqrt(squarefree_prod(i)) for i, c in enumerate(v) if c)


def squarefree_prod(i: int) -> int:
    out = 1
    for k, p in enumerate(PRIMES):
        if (i >> k) & 1:
            out *= p
    return out


def d2_fraction(vec, denom2: int):
    """The rational value of an exact d² vector, or None if it has irrational part."""
    if any(vec[i] for i in range(1, DIM)):
        return None
    return Fraction(vec[0], denom2)


def d2_pretty(vec, denom2: int) -> str:
    fr = d2_fraction(vec, denom2)
    if fr is not None:
        return str(fr)
    terms = []
    for i, c in enumerate(vec):
        if c:
            q = Fraction(c, denom2)
            terms.append(f"{q}" if i == 0 else f"{q}·√{squarefree_prod(i)}")
    return " + ".join(terms)


# ------------------------------------------------------------------ closure plumbing

_CLOSURE = None


def closure():
    global _CLOSURE
    if _CLOSURE is None:
        cfg, coords, E = load_closure()
        _CLOSURE = (cfg, coords, E)
    return _CLOSURE


def find_pivots(coords, denom):
    """Vertices carrying an r² = 1/3 class, with their class members.

    Float prefilter, exact confirm — the verdict is the exact integer identity
    `distsq == denom²/3` (distsq returns a LIST; the target is built as a list too:
    the §0.4 list-vs-tuple bug compared against a tuple and found zero pivots)."""
    target = d2_target(denom, R13)
    fx = [to_float(p[0]) for p in coords]
    fy = [to_float(p[1]) for p in coords]
    fd2 = float(denom) ** 2 / 3.0
    n = len(coords)
    members: dict[int, list[int]] = {}
    for a in range(n):
        for b in range(a + 1, n):
            approx = (fx[a] - fx[b]) ** 2 + (fy[a] - fy[b]) ** 2
            if abs(approx - fd2) < 1e-3 * fd2:
                if distsq(coords[a], coords[b]) == target:
                    members.setdefault(a, []).append(b)
                    members.setdefault(b, []).append(a)
    return members


def d2_target(denom: int, r2: Fraction) -> list[int]:
    num = denom * denom * r2
    assert num.denominator == 1, f"denominator {denom} does not clear r² = {r2}"
    return const(int(num))


# ------------------------------------------------------------------ census

def run_census(args):
    cfg, coords, E = closure()
    from coverage import edges_digest
    n, denom = len(coords), cfg.denom
    t0 = time.time()
    classes = find_pivots(coords, denom)
    pivots = sorted(classes)
    print(f"pivots (1/3-class carriers): {len(pivots)}/{n} "
          f"({time.time() - t0:.0f}s)", flush=True)

    nbr = [set() for _ in range(n)]
    for a, b in E:
        nbr[a].add(b)
        nbr[b].add(a)
    S = {p: sorted(nbr[p] | set(classes[p])) for p in pivots}
    Sset = {p: set(S[p]) for p in pivots}
    owners: list[list[int]] = [[] for _ in range(n)]
    for p in pivots:
        for v in S[p]:
            owners[v].append(p)

    t0 = time.time()
    chords: Counter = Counter()
    weight: Counter = Counter()
    for u, v in E:
        local: Counter = Counter()
        for p in owners[u]:
            for q in owners[v]:
                if p != q:
                    local[(p, q) if p < q else (q, p)] += 1
        for pair, w in local.items():
            weight[pair] += w
            chords[pair] += 1
    print(f"coupled pivot pairs: {len(chords)} ({time.time() - t0:.0f}s)", flush=True)

    t0 = time.time()
    spectrum: dict = {}
    far_pairs_seen = 0
    top_far: list = []
    denom2 = denom * denom
    for (a, b), ch in chords.items():
        key = tuple(distsq(coords[a], coords[b]))
        far = not (Sset[a] & Sset[b])
        far_pairs_seen += far
        row = spectrum.setdefault(key, {
            "pairs": 0, "far_pairs": 0, "weight": 0, "far_weight": 0,
            "chords": 0, "far_chords": 0, "max_chords": 0, "max_pair": None,
            "far_max_chords": 0, "far_max_pair": None})
        w = weight[(a, b)]
        row["pairs"] += 1
        row["weight"] += w
        row["chords"] += ch
        if ch > row["max_chords"]:
            row["max_chords"], row["max_pair"] = ch, [a, b]
        if far:
            row["far_pairs"] += 1
            row["far_weight"] += w
            row["far_chords"] += ch
            if ch > row["far_max_chords"]:
                row["far_max_chords"], row["far_max_pair"] = ch, [a, b]
            top_far.append((ch, w, a, b, key))
    top_far.sort(key=lambda t: (-t[0], t[2], t[3]))
    print(f"d² classes: {len(spectrum)}, far pairs: {far_pairs_seen} "
          f"({time.time() - t0:.0f}s)", flush=True)

    rows = [{"d2": d2_pretty(list(k), denom2), "d2_key": list(k), **v}
            for k, v in spectrum.items()]
    rows.sort(key=lambda r: -r["weight"])
    total_w = sum(r["weight"] for r in rows)
    top10 = sum(r["weight"] for r in rows[:10])
    print(f"top-10 d² classes carry {100 * top10 / total_w:.1f}% of the weight "
          f"(A1 threshold was 60%)", flush=True)
    for r in rows[:3]:
        print(f"  d²={r['d2']}: pairs {r['pairs']} weight {r['weight']} "
              f"far_max {r['far_max_chords']} at {r['far_max_pair']}", flush=True)
    tf = [{"pair": [a, b], "chords": ch, "weight": w,
           "d2": d2_pretty(list(k), denom2), "S_sizes": [len(S[a]), len(S[b])]}
          for ch, w, a, b, k in top_far[:100]]
    print(f"strongest far pair: {tf[0]}", flush=True)
    out = {"graph": {"name": "Z3-closure-dg630x1/3", "n": n, "n_edges": len(E),
                     "edges_sha": edges_digest(n, E)},
           "pivots": len(pivots),
           "conventions": "chords = closure edges with endpoints in S_a, S_b resp., "
                          "once per edge; weight = orientation incidences; far = "
                          "disjoint cover sets",
           "spectrum": rows, "top_far_pairs": tf}
    path = args.out or str(BUILD / "m21-census.json")
    Path(path).write_text(json.dumps(out))
    print(f"census written to {path}", flush=True)


# ------------------------------------------------------------------ phase probe

def relations(w2, d2vec, mbound=6, lbound=6):
    """All (m, l, k) ≠ 0 with `u^{2m}·σ^l·ζ₆^k = 1`, exactly.

    `w2` is the UNSCALED (q−p)² as a cnum, `d2vec` the matching |q−p|² (both at the
    same clearing); u² = w2/d2. σ and ζ₆ have norm 1, so negative exponents are
    conjugates, and the whole check is numerator arithmetic:
    `w2^{|m|±}·(6σ)^{|l|±}·(2ζ₆)^k == d2^{|m|}·6^{|l|}·2^k` — no division anywhere."""
    found = []
    for m in range(-mbound, mbound + 1):
        um = cpow(w2 if m >= 0 else cconj(w2), abs(m))
        dm = const(1)
        for _ in range(abs(m)):
            dm = mul(dm, d2vec)
        for l in range(-lbound, lbound + 1):
            sl = cpow(CSEAM if l >= 0 else cconj(CSEAM), abs(l))
            ml = cmul(um, sl)
            for k in range(6):
                if m == 0 and l == 0 and k == 0:
                    continue
                lhs = cmul(ml, cpow(CZETA6, k))
                rhs = mul(dm, const(6 ** abs(l) * 2 ** k))
                if lhs[0] == rhs and not any(lhs[1]):
                    found.append((m, l, k))
    return found


def annulus_verdict(d: float, ra: float, rb: float) -> str:
    lo, hi = abs(d - ra - rb), d + ra + rb
    lo = max(abs(d - ra) - rb, rb - d - ra, 0.0)
    if lo < 1.0 < hi:
        return "chords"
    if math.isclose(lo, 1.0) or math.isclose(hi, 1.0):
        return "tangent"
    return "none"


DEFAULT_PROBES = [(695, 2044, "far:1"), (30, 426, "far:1/3"),
                  (678, 3554, "far:+√33"), (414, 715, "far:-√33"),
                  (0, 402, "unit"), (402, 403, "unit"), (402, 408, "unit")]


def run_phase(args):
    cfg, coords, E = closure()
    from coverage import edges_digest
    denom = cfg.denom
    denom2 = denom * denom
    s = 1 / math.sqrt(3)
    probes = []
    for a, b, tag in DEFAULT_PROBES:
        t0 = time.time()
        w = (sub(coords[b][0], coords[a][0]), sub(coords[b][1], coords[a][1]))
        w2 = cmul(w, w)
        d2 = distsq(coords[a], coords[b])
        rel = relations(w2, d2, args.mbound, args.lbound)
        fr = d2_fraction(d2, denom2)
        d_in_field = is_square(fr) if fr is not None else None
        d = math.sqrt(to_float(d2)) / denom
        ann = {"11": annulus_verdict(d, 1, 1), "1s": annulus_verdict(d, 1, s),
               "s1": annulus_verdict(d, s, 1), "ss": annulus_verdict(d, s, s)}
        probes.append({"pair": [a, b], "tag": tag, "d2": d2_pretty(d2, denom2),
                       "d2_rational": fr is not None, "d_in_field": d_in_field,
                       "relations": rel, "n_relations": len(rel),
                       "annulus": ann, "secs": round(time.time() - t0, 1)})
        print(f"[{tag}] ({a},{b}) d²={probes[-1]['d2']} relations={len(rel)} "
              f"d_in_field={d_in_field} annulus={ann}", flush=True)
    out = {"graph": {"name": "Z3-closure-dg630x1/3", "n": len(coords),
                     "n_edges": len(E), "edges_sha": edges_digest(len(coords), E)},
           "bound": {"m": args.mbound, "l": args.lbound}, "probes": probes}
    path = args.out or str(BUILD / "m21-phase.json")
    Path(path).write_text(json.dumps(out))
    print(f"phase probe written to {path}", flush=True)


# ------------------------------------------------------------------ the joint profile

def sample_pattern(sub_edges, m, rng, tries=200):
    """One random proper ≤3-pattern of an m-vertex graph, canonical form. Seeded greedy
    walk — NOT uniform; verdicts are facts, coverage claims stay inside the sample."""
    adjacency = [[] for _ in range(m)]
    for a, b in sub_edges:
        adjacency[a].append(b)
        adjacency[b].append(a)
    for _ in range(tries):
        col = [-1] * m
        ok = True
        for v in rng.sample(range(m), m) if False else range(m):
            opts = [c for c in rng.sample(range(3), 3)
                    if all(col[u] != c for u in adjacency[v])]
            if not opts:
                ok = False
                break
            col[v] = opts[0]
        if ok:
            return canon(tuple(col))
    return None


def draw_pairs(sub_a, sub_b, na, nb, count, rng):
    """`count` distinct pattern pairs; refuses by name on a sampler dead-end."""
    seen, out, misses = set(), [], 0
    while len(out) < count:
        pa = sample_pattern(sub_a, na, rng)
        pb = sample_pattern(sub_b, nb, rng)
        if pa is None or pb is None or (pa, pb) in seen:
            misses += 1
            if misses > 50 * count + 200:
                raise SystemExit(
                    f"sampler dead-end: {len(out)}/{count} distinct pattern pairs "
                    f"after {misses} rejected draws — the pattern space is smaller "
                    f"than the request; lower --samples")
            continue
        seen.add((pa, pb))
        out.append((pa, pb))
    return out


def local_check(pins_a, classes_b, cross, k):
    """The local (cross-chords-only) checker: can π_b's classes injectively take
    colours, avoiding every pinned neighbour across a chord? Bipartite matching by
    brute-force injection (≤ 3 classes); `None` = locally consistent, else the named
    Hall/conflict witness.

    ALL indices here are GLOBAL vertex ids — `pins_a` maps vertex→colour, `classes_b`
    is a list of global-vertex lists, `cross` is global edges. (The §0.4 double-reindex
    crash came from re-localizing already-local indices; this function has exactly one
    index space.)"""
    colour_a = dict(pins_a)
    cls_of = {v: i for i, cls in enumerate(classes_b) for v in cls}
    allowed = [set(range(k)) for _ in classes_b]
    for u, v in cross:
        if u in cls_of and v in colour_a:
            u, v = v, u
        if u in colour_a and v in cls_of:
            allowed[cls_of[v]].discard(colour_a[u])
    for inj in permutations(range(k), len(classes_b)):
        if all(c in allowed[i] for i, c in enumerate(inj)):
            return None
    return {"allowed": [sorted(s) for s in allowed]}


def valid_injections(classes_b, allowed, k):
    return [inj for inj in permutations(range(k), len(classes_b))
            if all(c in allowed[i] for i, c in enumerate(inj))]


def partition_clauses(classes_b, k):
    """π_b as a partition, palette-free: same class ⟹ identical colour vars, distinct
    classes ⟹ no shared colour (the same clause shape properness uses)."""
    out = []
    for cls in classes_b:
        rep = cls[0]
        for v in cls[1:]:
            for c in range(k):
                out.append([-var(rep, c, k), var(v, c, k)])
                out.append([-var(v, c, k), var(rep, c, k)])
    for i in range(len(classes_b)):
        for j in range(i + 1, len(classes_b)):
            for c in range(k):
                out.append([-var(classes_b[i][0], c, k),
                            -var(classes_b[j][0], c, k)])
    return out


def joint_instance(n, E, base, pins_a, classes_b, cross, k, budget,
                   force_sat=False):
    """One pattern pair -> verdict. Ambient kills are VERIFIED in place through the
    independent pin-only injection encoding before being reported (never separable —
    the subplan's §4 rule)."""
    if not force_sat:
        witness = local_check(pins_a, classes_b, cross, k)
        if witness is not None:
            return "local-conflict", witness
    clauses = base + [[var(v, c, k)] for v, c in pins_a] \
        + partition_clauses(classes_b, k)
    st, model = _solve(clauses, k * n, budget)
    if st == "sat":
        pos = {x for x in model if x > 0}
        colour = {}
        for x in sorted(pos):
            v, c = divmod(x - 1, k)
            colour.setdefault(v, c)
        assert all(colour[a] != colour[b] for a, b in E if a != b), \
            "joint model improper — encoding bug"
        assert all(var(v, c, k) in pos for v, c in pins_a), \
            "a π_a pin is false in the model — encoding bug"
        for cls in classes_b:
            assert len({colour[v] for v in cls}) == 1, \
                "π_b class split in the model — partition encoding bug"
        assert len({colour[cls[0]] for cls in classes_b}) == len(classes_b), \
            "π_b classes merged in the model — partition encoding bug"
        return "sat", None
    if st == "unsat":
        allowed = [set(range(k)) for _ in classes_b]
        colour_a = dict(pins_a)
        cls_of = {v: i for i, cls in enumerate(classes_b) for v in cls}
        for u, v in cross:
            if u in cls_of and v in colour_a:
                u, v = v, u
            if u in colour_a and v in cls_of:
                allowed[cls_of[v]].discard(colour_a[u])
        injs = valid_injections(classes_b, allowed, k)
        assert injs or force_sat, \
            "ambient unsat but no locally-valid injection — should have been local"
        for inj in injs:
            pins = list(pins_a) + [(v, inj[i]) for i, cls in enumerate(classes_b)
                                   for v in cls]
            st2, _ = _solve(base + [[var(v, c, k)] for v, c in pins], k * n, budget)
            assert st2 == "unsat", \
                f"FALSE KILL: injection {inj} is ambient-satisfiable through the " \
                f"pin-only encoding — the partition encoding is buggy"
        return "unsat", {"injections_refuted": len(injs)}
    return "unknown", None


def run_joint(args):
    cfg, coords, E = closure()
    from coverage import edges_digest
    n, denom = len(coords), cfg.denom
    rng = random.Random(args.seed)
    k = args.k
    runs = []

    def one_pair(a, b, tag, count, force_sat=False):
        S_a, _, _ = pivot_S(coords, denom, E, a)
        S_b, _, _ = pivot_S(coords, denom, E, b)
        if set(S_a) & set(S_b):
            raise SystemExit(f"non-far pair ({a},{b}): cover sets share "
                             f"{sorted(set(S_a) & set(S_b))} — the joint profile "
                             f"is defined for far pairs only")
        sub_a, sub_b = induced(E, S_a), induced(E, S_b)
        cross = [(u, v) for u, v in E
                 if (u in set(S_a) and v in set(S_b))
                 or (u in set(S_b) and v in set(S_a))]
        print(f"[{tag}] |S_a|={len(S_a)} |S_b|={len(S_b)} cross chords={len(cross)}",
              flush=True)
        base = base_clauses(n, E, k)
        pairs = draw_pairs(sub_a, sub_b, len(S_a), len(S_b), count, rng)
        verdicts: Counter = Counter()
        kills, call_secs = [], Counter()
        t0 = time.time()
        for i, (pa, pb) in enumerate(pairs):
            pins_a = [(S_a[t], pa[t]) for t in range(len(S_a))]
            classes_b = [[S_b[t] for t in range(len(S_b)) if pb[t] == c]
                         for c in range(max(pb) + 1)]
            t1 = time.time()
            st, info = joint_instance(n, E, base, pins_a, classes_b, cross, k,
                                      args.budget, force_sat)
            call_secs[st] += time.time() - t1
            verdicts[st] += 1
            if st == "unsat":
                kills.append({"pa": list(pa), "pb": list(pb), **(info or {})})
            if (i + 1) % 100 == 0:
                print(f"[{tag}]   {i + 1}/{count} {dict(verdicts)} "
                      f"({time.time() - t0:.0f}s)", flush=True)
        print(f"[{tag}] {dict(verdicts)} in {time.time() - t0:.0f}s", flush=True)
        runs.append({"tag": f"{tag}@{a},{b}", "k": k, "sampled": count,
                     "verdicts": dict(verdicts), "kills": kills,
                     "call_secs": {s: round(v, 1) for s, v in call_secs.items()},
                     "secs": int(time.time() - t0), "budget": int(args.budget)})
        return len(cross)

    ncross = one_pair(args.joint[0], args.joint[1],
                      "coupled" if not args.force_sat else "pinonly",
                      args.samples, args.force_sat)
    if args.null:
        one_pair(args.null[0], args.null[1], "null", args.samples)
    out = {"graph": {"name": "Z3-closure-dg630x1/3", "n": n, "n_edges": len(E),
                     "edges_sha": edges_digest(n, E)},
           "coupled": list(args.joint), "null": list(args.null or []),
           "cross_chords": ncross, "seed": args.seed, "runs": runs}
    path = args.out or str(BUILD / f"m21-joint-{args.joint[0]}-{args.joint[1]}.json")
    Path(path).write_text(json.dumps(out))
    print(f"joint profile written to {path}", flush=True)


# ------------------------------------------------------------------ the d = 1 pair system

def frac_c(x_terms=None, y_terms=None):
    """A cnum over Fraction components: {basis: Fraction} dicts -> full vectors."""
    x = [Fraction(0)] * DIM
    y = [Fraction(0)] * DIM
    for i, q in (x_terms or {}).items():
        x[i] = Fraction(q)
    for i, q in (y_terms or {}).items():
        y[i] = Fraction(q)
    return (x, y)


# The pair lattice's generators, membership-directed (predictions §0-D: "ζ₆ steps on
# outers, ω steps on inners, seam maps"): a point on a pivot's OUTER circle takes the
# 60° rotation, the norm-1 seam rotation and its inverse (infinite order — the strip's
# ℤ direction, M19), and the seamImage map (norm 1/√3, outer→inner — M20); a point on
# an INNER circle takes the 120° rotation ω (the inner circle's unit-chord step).
# Membership on the four circles is re-derived exactly at every insertion; it is the
# filter, and it is what keeps the growth linear (~48 points/step).
#
# Seeds: the two pivots and the EIGHT gluing points — the complete cast of
# `Coupled.lean`'s four intersection classifications. Honesty note: the session-mortal
# §0-D original grew a lattice a constant 20 points smaller at every depth (its exact
# seed list died with its session); the growth rate, the glue-point count (8), and
# every SAT verdict (k=3 unsat, k=4 sat at all depths) reproduce exactly. The original
# read 964 points / 2,881 edges / 973 cross chords at depth 20.
OUTER_MOVES = {
    "z6": frac_c({B1: Fraction(1, 2)}, {B3: Fraction(1, 2)}),
    "seam": frac_c({B3: Fraction(1, 6)}, {B33: Fraction(1, 6)}),
    "seaminv": frac_c({B3: Fraction(1, 6)}, {B33: Fraction(-1, 6)}),
    "simg": frac_c({B1: Fraction(1, 6)}, {B11: Fraction(1, 6)}),
}
INNER_MOVES = {
    "om": frac_c({B1: Fraction(-1, 2)}, {B3: Fraction(1, 2)}),
}


def glue_seeds():
    """The eight circle-pair intersection points of the d = 1 pair at (0, 1) — the
    right-hand sides of `Coupled.lean`'s gluing classification, exact."""
    out = []
    for xb, x, yb, y in [(B1, Fraction(1, 2), B3, Fraction(1, 2)),
                         (B1, Fraction(5, 6), B11, Fraction(1, 6)),
                         (B1, Fraction(1, 6), B11, Fraction(1, 6)),
                         (B1, Fraction(1, 2), B3, Fraction(1, 6))]:
        for s in (1, -1):
            out.append(frac_c({xb: x}, {yb: s * y}))
    return out


def ckey(z):
    return (tuple(z[0]), tuple(z[1]))


def on_circles(z, pivots):
    """Which of the four circles carries `z`: exact d² ∈ {1, 1/3} to each pivot."""
    out = []
    for name, c in pivots:
        d2 = distsq((z[0], z[1]), (c[0], c[1]))
        if d2 == const(1):
            out.append(name + "o")
        elif to_frac_const(d2) == R13:
            out.append(name + "i")
    return out


def to_frac_const(vec):
    if any(vec[i] for i in range(1, DIM)):
        return None
    return Fraction(vec[0])


def run_pair(args):
    t0 = time.time()
    P = frac_c({}, {})
    Q = frac_c({B1: Fraction(1)}, {})
    pivots = [("p", P), ("q", Q)]
    pts: dict = {}
    frontier = []
    for s in [P, Q] + glue_seeds():
        key = ckey(s)
        if key not in pts:
            pts[key] = (s, on_circles(s, pivots))
            frontier.append(s)
    cap_cut = False
    for depth in range(args.depth):
        nxt = []
        for z in frontier:
            labels = pts[ckey(z)][1]
            for name, c in pivots:
                dz = (sub(z[0], c[0]), sub(z[1], c[1]))
                moves = (list(OUTER_MOVES.values()) if name + "o" in labels else []) \
                    + (list(INNER_MOVES.values()) if name + "i" in labels else [])
                for rho in moves:
                    w = cmul(rho, dz)
                    cand = (add(c[0], w[0]), add(c[1], w[1]))
                    key = ckey(cand)
                    if key in pts:
                        continue
                    lab = on_circles(cand, pivots)
                    if not lab:
                        continue
                    if len(pts) >= args.cap:
                        cap_cut = True
                        break
                    pts[key] = (cand, lab)
                    nxt.append(cand)
                if cap_cut:
                    break
            if cap_cut:
                break
        frontier = nxt
        if cap_cut or not frontier:
            break
    order = [v[0] for v in pts.values()]
    n = len(order)
    print(f"pair lattice: {n} points at depth {args.depth} "
          f"(cap_cut={cap_cut}, {time.time() - t0:.0f}s)", flush=True)

    t0 = time.time()
    fx = [to_float(z[0]) for z in order]
    fy = [to_float(z[1]) for z in order]
    E = []
    for a in range(n):
        for b in range(a + 1, n):
            if abs((fx[a] - fx[b]) ** 2 + (fy[a] - fy[b]) ** 2 - 1.0) < 1e-9:
                if distsq((order[a][0], order[a][1]),
                          (order[b][0], order[b][1])) == const(1):
                    E.append((a, b))
    memb = [set(on_circles(z, pivots)) for z in order]
    sysm = [{"p", "q"} & {m[0] for m in mm} for mm in memb]
    cross = sum(1 for a, b in E
                if (sysm[a] == {"p"} and sysm[b] == {"q"})
                or (sysm[a] == {"q"} and sysm[b] == {"p"}))
    multi = sum(1 for mm in memb if len({m[0] for m in mm}) == 2)
    print(f"edges: {len(E)}, cross chords: {cross}, multi-circle points: {multi} "
          f"({time.time() - t0:.0f}s)", flush=True)

    st3, _ = _solve(base_clauses(n, E, 3), 3 * n, args.budget)
    assert st3 == "unsat", \
        f"k=3 control FAILED ({st3}): each half holds the cap's witness — tool bug " \
        f"or depth too small"
    t0 = time.time()
    st4, model = _solve(base_clauses(n, E, 4), 4 * n, args.budget)
    k4secs = time.time() - t0
    sizes = []
    if st4 == "sat":
        pos = {x for x in model if x > 0}
        colour = {}
        for x in sorted(pos):
            v, c = divmod(x - 1, 4)
            colour.setdefault(v, c)
        assert all(colour[a] != colour[b] for a, b in E), \
            "k=4 model improper — encoding bug"
        sizes = sorted(Counter(colour.values()).values(), reverse=True)
    print(f"k=3 {st3} (control ok), k=4 {st4} ({k4secs:.1f}s), classes {sizes}",
          flush=True)
    out = {"pivots": "0 and 1 (d=1)", "points": n, "depth": args.depth,
           "cap_cut": cap_cut, "edges": len(E), "cross_chords": cross,
           "multi_circle": multi, "k3": st3, "k4": st4,
           "k4_secs": round(k4secs, 1), "k4_class_sizes": sizes}
    path = args.out or str(BUILD / "m21-pair-d1.json")
    Path(path).write_text(json.dumps(out))
    print(f"pair probe written to {path}", flush=True)


# ------------------------------------------------------------------ the mesh scan

SQ3 = math.sqrt(3.0)
INNER_R = 1 / SQ3


def sector_colour(theta: float, phase: float, reflect: bool, palette) -> int:
    """The 60°-sector colouring: sector index mod 3, both circles (the assignment the
    seam angle arctan(√11) ≈ 73.2° forces — the inner table equals the outer's)."""
    if reflect:
        theta = -theta
    j = int(math.floor((theta - phase) / (math.pi / 3))) % 6
    return palette[j % 3]


def chord_partners(alpha: float, ra: float, rb: float):
    """β solutions of |ra·e^{iα} − (1 + rb·e^{iβ})| = 1 (system b at +1)."""
    wx, wy = ra * math.cos(alpha) - 1.0, ra * math.sin(alpha)
    d = math.hypot(wx, wy)
    if d < 1e-12:
        return [2 * math.pi * t / 8 for t in range(8)]
    c = (d * d + rb * rb - 1.0) / (2 * d * rb)
    if abs(c) > 1.0:
        return []
    off = math.acos(c)
    base = math.atan2(wy, wx)
    return [base + off, base - off]


GLUE = [(0.5, SQ3 / 2, "oo"), (0.5, -SQ3 / 2, "oo"),
        (5 / 6, math.sqrt(11) / 6, "oi"), (5 / 6, -math.sqrt(11) / 6, "oi"),
        (1 / 6, math.sqrt(11) / 6, "io"), (1 / 6, -math.sqrt(11) / 6, "io"),
        (0.5, SQ3 / 6, "ii"), (0.5, -SQ3 / 6, "ii")]


def mesh_combo(psi: float, reflect_a: bool, reflect_b: bool, palette_b,
               n_alpha: int):
    """First violated family for one (combo, ψ), or None if the pair meshes there.
    System a: phase 0, identity palette (WLOG — only relative frames matter)."""
    fams = [("oo", 1.0, 1.0), ("oi", 1.0, INNER_R),
            ("io", INNER_R, 1.0), ("ii", INNER_R, INNER_R)]
    pal_a = (0, 1, 2)
    for fam, ra, rb in fams:
        for i in range(n_alpha):
            alpha = 2 * math.pi * i / n_alpha
            for beta in chord_partners(alpha, ra, rb):
                ca = sector_colour(alpha, 0.0, reflect_a, pal_a)
                cb = sector_colour(beta, psi, reflect_b, palette_b)
                if ca == cb:
                    return fam
    for gx, gy, fam in GLUE:
        ta = math.atan2(gy, gx)
        tb = math.atan2(gy, gx - 1.0)
        if sector_colour(ta, 0.0, reflect_a, pal_a) \
                != sector_colour(tb, psi, reflect_b, palette_b):
            return "glue"
    return None


def run_mesh(args):
    combos = [(ra, rb, pal) for ra in (False, True) for rb in (False, True)
              for pal in permutations(range(3))]
    print(f"mesh scan: {len(combos)} combos × {args.psi_steps} ψ samples, "
          f"{args.alpha_steps} α samples per curve family", flush=True)
    survivors, first_viol = 0, Counter()
    t0 = time.time()
    for ci, (ra, rb, pal) in enumerate(combos):
        combo_surv = 0
        for s in range(args.psi_steps):
            psi = 2 * math.pi * s / args.psi_steps
            fam = mesh_combo(psi, ra, rb, pal, args.alpha_steps)
            if fam is None:
                combo_surv += 1
            else:
                first_viol[fam] += 1
        survivors += combo_surv
        if combo_surv:
            print(f"  combo {ci} (reflA={ra} reflB={rb} pal={pal}): "
                  f"{combo_surv} SURVIVING ψ — a meshing sector pair!", flush=True)
    total = len(combos) * args.psi_steps
    print(f"mesh scan: {survivors}/{total} (combo, ψ) samples survive; "
          f"first violations {dict(first_viol)} ({time.time() - t0:.0f}s)", flush=True)
    if survivors == 0:
        print("no pair of sector colourings meshes at d = 1 in the sampled sweep "
              "(triage — the §0-D finding)", flush=True)


# ------------------------------------------------------------------ the union floor

def run_floor(args):
    cfg, coords, E = closure()
    n, denom = len(coords), cfg.denom
    a, b = args.floor
    S_a, _, _ = pivot_S(coords, denom, E, a)
    S_b, _, _ = pivot_S(coords, denom, E, b)
    Su = sorted(set(S_a) | set(S_b))
    k = args.k
    print(f"floor at ({a},{b}): |S_a ∪ S_b| = {len(Su)}, k = {k}", flush=True)
    floor, tstar = k, None
    for t in range(1, k):
        clauses = base_clauses(n, E, k) + \
            [[-var(v, c, k)] for v in Su for c in range(k - t, k)]
        st, model = _solve(clauses, k * n, args.budget)
        print(f"  forbid-last-{t}: {st}", flush=True)
        if st == "sat":
            pos = {x for x in model if x > 0}
            colour = {}
            for x in sorted(pos):
                v, c = divmod(x - 1, k)
                colour.setdefault(v, c)
            assert all(colour[u] != colour[v] for u, v in E), "improper — bug"
            assert all(colour[v] < k - t for v in Su), "forbidden colour used — bug"
            floor, tstar = k - t, t
        elif st == "unsat":
            break
        else:
            print("  (unknown — floor bounded only)", flush=True)
            break
    print(f"coverage floor of the union: {floor} (t* = {tstar})", flush=True)


# ------------------------------------------------------------------ self-test

def self_test():
    failures = []

    def check(name, fn):
        try:
            fn()
            print(f"  ok  {name}", flush=True)
        except AssertionError as e:
            failures.append((name, str(e)))
            print(f"  FAIL {name}: {e}", flush=True)

    # 1. Hall-violation control: 3 classes, all cross-chorded to colour 0, k=3
    def hall():
        pins_a = [(0, 0)]
        classes_b = [[1], [2], [3]]
        cross = [(0, 1), (0, 2), (0, 3)]
        w = local_check(pins_a, classes_b, cross, 3)
        assert w is not None, "Hall violation NOT caught by the local checker"
        ok = local_check(pins_a, classes_b, cross, 4)
        assert ok is None, "k=4 relaxation wrongly refused"
    check("hall-violation control (local checker)", hall)

    # 2. phantom-relation control, both directions
    def phantom():
        w2 = cmul(CZETA6, CZETA6)
        found = relations(w2, const(4), 6, 6)
        assert (1, 0, 4) in found, f"planted relation u=ζ₆ missed: {found}"
        one = (const(1), const(0))
        found2 = relations(one, const(1), 6, 6)
        assert all(l == 0 for _, l, _ in found2), \
            f"phantom seam relation reported: {found2} — seam_pow_ne_one violated"
        assert (0, 0, 0) not in found2, "trivial relation reported"
    check("σ/ζ₆ phantom-relation control (exact)", phantom)

    # 3. the list-vs-tuple census regression (distsq returns a list)
    def listtuple():
        coords = [(([0] * DIM), ([0] * DIM)),
                  ((fvec(b0=1)), ([0] * DIM))]
        coords = [((list(x)), (list(y))) for x, y in coords]
        d = distsq(coords[0], coords[1])
        assert isinstance(d, list), "distsq no longer returns a list — retest census"
        assert d == d2_target(1, Fraction(1)), \
            "exact d² comparison failed on the unit fixture — the census's " \
            "pivot detection would find zero pivots"
    check("list-vs-tuple regression (census §0.4)", listtuple)

    # 4. the double-reindex regression: local_check consumes GLOBAL ids
    def reindex():
        pins_a = [(5, 0)]
        classes_b = [[9], [11]]
        cross = [(5, 9)]
        w = local_check(pins_a, classes_b, cross, 3)
        assert w is None, "global-index fixture wrongly refused"
        w2 = local_check(pins_a, classes_b, cross + [(5, 11)], 2)
        assert w2 is not None and w2["allowed"] == [[1], [1]], \
            f"allowed sets not tracked in global ids: {w2}"
    check("double-reindex regression (joint §0.4)", reindex)

    # 5. sampler properness + canonicity + dead-end refusal
    def sampler():
        rng = random.Random(7)
        sub = [(0, 1), (1, 2), (2, 3)]
        for _ in range(20):
            pat = sample_pattern(sub, 4, rng)
            assert pat is not None
            assert all(pat[a] != pat[b] for a, b in sub), "improper sample"
            assert pat == canon(pat), "non-canonical sample"
        tri = [(0, 1), (1, 2), (0, 2)]
        try:
            draw_pairs(tri, tri, 3, 3, 5, rng)
            raise AssertionError("dead-end sampler did NOT refuse (triangle has "
                                 "one canonical pattern, 5 pairs requested)")
        except SystemExit as e:
            assert "dead-end" in str(e), f"refusal not by name: {e}"
    check("sampler properness/canonicity/dead-end", sampler)

    # 6. mesh-curve residual sanity + single-system sector properness
    def mesh_sanity():
        for ra, rb in [(1.0, 1.0), (1.0, INNER_R), (INNER_R, 1.0),
                       (INNER_R, INNER_R)]:
            for i in range(100):
                alpha = 2 * math.pi * i / 100 + 0.001
                for beta in chord_partners(alpha, ra, rb):
                    x = (ra * math.cos(alpha), ra * math.sin(alpha))
                    y = (1 + rb * math.cos(beta), rb * math.sin(beta))
                    r = (x[0] - y[0]) ** 2 + (x[1] - y[1]) ** 2
                    assert abs(r - 1.0) < 1e-9, f"chord residual {r - 1.0}"
        pal = (0, 1, 2)
        seam_angle = math.atan2(math.sqrt(11), 1.0)
        for i in range(600):
            th = 2 * math.pi * i / 600 + 1e-4
            assert sector_colour(th, 0, False, pal) \
                != sector_colour(th + math.pi / 3, 0, False, pal), "60° outer chord"
            assert sector_colour(th, 0, False, pal) \
                != sector_colour(th + 2 * math.pi / 3, 0, False, pal), \
                "120° inner chord"
            for sgn in (1, -1):
                assert sector_colour(th, 0, False, pal) \
                    != sector_colour(th + sgn * seam_angle, 0, False, pal), \
                    "seam cross chord monochromatic — sector family is not proper"
    check("mesh residual sanity + single-system properness", mesh_sanity)

    # 7. the enumeration cap refuses by name
    def cap():
        try:
            enum_canonical(4, [], cap=0)
            raise AssertionError("cap=0 not refused")
        except ValueError as e:
            assert "cap" in str(e)
    check("enumeration cap refusal", cap)

    # 8. foreign-artifact digest refusal
    def foreign():
        doc = {"graph": {"edges_sha": "not-this-graph"}}
        try:
            require_artifact_graph(doc, "deadbeef", "fixture")
            raise AssertionError("foreign digest not refused")
        except SystemExit as e:
            assert "foreign" in str(e), f"refusal not by name: {e}"
    check("foreign-artifact digest refusal", foreign)

    # 9. pin-only k=3 SAT-layer control: monochrome triangle unsat through cadical
    def pinonly():
        E = [(0, 1), (1, 2), (0, 2)]
        clauses = base_clauses(3, E, 3) + [[var(v, 0, 3)] for v in range(3)]
        st, _ = _solve(clauses, 9, 30)
        assert st == "unsat", f"monochrome triangle reported {st}"
        clauses2 = base_clauses(3, E, 3) + [[var(v, v, 3)] for v in range(3)]
        st2, _ = _solve(clauses2, 9, 30)
        assert st2 == "sat", f"rainbow triangle reported {st2}"
    check("pin-only SAT-layer control (unsat + sat)", pinonly)

    # 10. partition encoding vs injection encoding agree on a small fixture
    def partition():
        E = [(0, 1), (1, 2), (2, 3), (3, 0)]
        base = base_clauses(4, E, 3)
        st, info = joint_instance(4, E, base, [(0, 0)], [[1], [3]],
                                  [(0, 1), (3, 0)], 3, 30)
        assert st in ("sat", "unsat"), st
        st2, _ = joint_instance(4, E, base, [(0, 0)], [[2]], [], 3, 30)
        assert st2 == "sat", f"free single-class instance reported {st2}"
    check("partition/injection cross-check fixture", partition)

    if failures:
        raise SystemExit(f"SELF-TEST FAILED: {len(failures)} control(s) red: "
                         f"{[n for n, _ in failures]}")
    print("self-test: all controls green", flush=True)


def require_artifact_graph(doc, edges_sha, path):
    if doc.get("graph", {}).get("edges_sha") != edges_sha:
        raise SystemExit(f"artifact {path} is foreign to this graph "
                         f"(edges digest mismatch) — refusing to reuse it")


# ------------------------------------------------------------------ CLI

def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--census", action="store_true")
    ap.add_argument("--phase", action="store_true")
    ap.add_argument("--joint", nargs=2, type=int, metavar=("A", "B"))
    ap.add_argument("--null", nargs=2, type=int, metavar=("A", "B"))
    ap.add_argument("--pair", action="store_true")
    ap.add_argument("--mesh", action="store_true")
    ap.add_argument("--floor", nargs=2, type=int, metavar=("A", "B"))
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    ap.add_argument("--samples", type=int, default=1500)
    ap.add_argument("--seed", type=int, default=21)
    ap.add_argument("--k", type=int, default=DEFAULT_K)
    ap.add_argument("--budget", type=float, default=DEFAULT_BUDGET)
    ap.add_argument("--depth", type=int, default=20)
    ap.add_argument("--cap", type=int, default=200_000)
    ap.add_argument("--mbound", type=int, default=6)
    ap.add_argument("--lbound", type=int, default=6)
    ap.add_argument("--psi-steps", type=int, default=1440)
    ap.add_argument("--alpha-steps", type=int, default=4000)
    ap.add_argument("--force-sat", action="store_true",
                    help="skip the local checker (the pin-only SAT-layer control)")
    ap.add_argument("--out", type=str, default=None)
    args = ap.parse_args()
    ran = False
    if args.selftest:
        self_test()
        ran = True
    if args.census:
        run_census(args)
        ran = True
    if args.phase:
        run_phase(args)
        ran = True
    if args.joint:
        run_joint(args)
        ran = True
    if args.pair:
        run_pair(args)
        ran = True
    if args.mesh:
        run_mesh(args)
        ran = True
    if args.floor:
        run_floor(args)
        ran = True
    if not ran:
        ap.error("nothing to do — try --self-test, --census, --phase, --joint, "
                 "--pair, --mesh, or --floor")


if __name__ == "__main__":
    main()
