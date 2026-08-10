#!/usr/bin/env python3
"""The closure instrument: mitotic unions, the quadrature law, graded closures, chunk χ probes.

UNTRUSTED, like everything in `tools/`. Anything that matters later is re-derived in Lean (M32);
a bug here can cost a theorem and never buy one.

## What it does (M31 §1)

* **Mitosis**: base points ∪ one detuned copy (rotation R = s·W about an anchor, s a seam-field
  rotation, W = √ρ₁₅^a·√ρ₆₃^b), exact dedup with provenance tags and a fusion record.
* **The quadrature law (§0a), enforced at find time**: every cross chord of a mitotic census is
  checked against its pin — even words (full spindles) demand Im(s·u·v̄) = 0 (anchor-collinear),
  odd words (half spindles) demand Re(s·u·v̄) = 0 (anchor-perpendicular), mixed words demand
  u·v̄ = 0 (sterile away from the anchor). A violation FALSIFIES registered prediction P1 and
  aborts loudly by name. Zero cross chords is a RESULT (a sterile/thin class), not a failure.
* **Graded closure**: one word-length generation at a time about a centre set — never "the whole
  orbit" — with growth and fusion (collision) reporting.
* **χ probes**: one SAT call per (chunk, k), three-outcome honest: sat / unsat / unknown-at-cap.
  `unknown` is NEVER a chromatic-number bound and is never reported as one.

Currency: `couple.py` complex pairs (two 16-vectors of Fractions over √{3,5,7,11}-products —
the basis every tool in this repository shares). `degrey.py` tables (the committed 1581) convert
at the boundary, in exactly two functions, round-trip self-tested.

    python3 tools/closure.py --self-test
    python3 tools/closure.py --probe-a          # mitotic hexagram sweep  → build/m31-mitosis-*.json
    python3 tools/closure.py --probe-b          # the de Grey pair        → build/m31-pair.json
    python3 tools/closure.py --gen1             # 1581 closure growth     → build/m31-closure-gen1.json
    python3 tools/closure.py --frontier         # chunk χ frontier curve  → build/m31-frontier.json
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import couple as C          # noqa: E402  seam-field complex arithmetic (the shared 16-basis)
import field as FLD         # noqa: E402  the scalar 16-vector ops couple re-exports partially
import degrey as D          # noqa: E402  the committed 1581's construction (boundary only)
from coloring import base_clauses, var  # noqa: E402
from forcer import _solve   # noqa: E402

try:
    import numpy as np
except ImportError:         # the float triage needs numpy; exact fallback exists but is slow
    np = None

DIM = C.DIM
B1, B3, B11, B33 = C.B1, C.B3, C.B11, C.B33
# The four radical blocks partitioning the 16-basis (K = ℚ(√3,√11)):
KIDX = (0, 1, 8, 9)          # 1, √3, √11, √33
K15 = (2, 3, 10, 11)         # √5, √15, √55, √165   = √15·K
K7 = (4, 5, 12, 13)          # √7, √21, √77, √231   = √7·K
K105 = (6, 7, 14, 15)        # √35, √105, √385, √1155 = √105·K

ONE_C = C.frac_c({B1: F(1)})
ZERO_C = C.frac_c()
Z6 = C.frac_c({B1: F(1, 2)}, {B3: F(1, 2)})
Z12 = C.frac_c({B3: F(1, 2)}, {B1: F(1, 2)})
SEAM = C.frac_c({B3: F(1, 6)}, {B33: F(1, 6)})
RHO15 = C.frac_c({B1: F(7, 8)}, {3: F(1, 8)})       # (7 + i√15)/8   — the distance-2 spindle
RHO63 = C.frac_c({B1: F(31, 32)}, {4: F(3, 32)})    # (31 + 3i√7)/32 — the distance-4 spindle
HALF15 = C.frac_c({3: F(1, 4)}, {B1: F(1, 4)})      # (√15 + i)/4    — √ρ₁₅
HALF63 = C.frac_c({4: F(3, 8)}, {B1: F(1, 8)})      # (3√7 + i)/8    — √ρ₆₃

BVAL = D.BVAL  # numeric shadow of the shared basis


def cadd(p, q): return (C.add(p[0], q[0]), C.add(p[1], q[1]))
def csub(p, q): return (C.sub(p[0], q[0]), C.sub(p[1], q[1]))
def key(p): return (tuple(p[0]), tuple(p[1]))
def fnum(v): return sum(float(x) * BVAL[i] for i, x in enumerate(v) if x)
def approx(p): return (fnum(p[0]), fnum(p[1]))


def nsq(p):
    """|p|² as a 16-vector (real)."""
    return C.add(C.mul(p[0], p[0]), C.mul(p[1], p[1]))


def wpow(g, n: int):
    """g^n for |g| = 1, negative n via the conjugate."""
    base = g if n >= 0 else C.cconj(g)
    out = ONE_C
    for _ in range(abs(n)):
        out = C.cmul(out, base)
    return out


def is_unit_rot(g) -> bool:
    return C.cmul(g, C.cconj(g)) == ONE_C


for _name, _g in [("zeta6", Z6), ("zeta12", Z12), ("seam", SEAM), ("rho15", RHO15),
                  ("rho63", RHO63), ("half15", HALF15), ("half63", HALF63)]:
    if not is_unit_rot(_g):
        raise SystemExit(f"GENERATOR {_name} IS NOT A UNIT ROTATION — the constant is mistyped")


def support(v) -> set:
    return {i for i, x in enumerate(v) if x}


def in_K(v) -> bool:
    return support(v) <= set(KIDX)


def exact_str(v) -> dict:
    """Sparse exact rendering for JSON: {basis index: "p/q"}."""
    return {str(i): f"{x.numerator}/{x.denominator}" for i, x in enumerate(v) if x}


# ------------------------------------------------------------------ boundary: degrey ⇄ couple

def from_degrey(p):
    """A degrey point (two Fraction 16-tuples) as a couple point (two Fraction 16-lists)."""
    return ([F(x) for x in p[0]], [F(x) for x in p[1]])


def to_degrey(p):
    return (tuple(p[0]), tuple(p[1]))


# ------------------------------------------------------------------ detunes

CLASSES = {"seam": "no pin (seam chords: the M24–M26 families)",
           "even15": "anchor-collinear pin, conic t²+r²−2·Re(W)·(±tr) = 1",
           "odd15": "anchor-perpendicular pin, conic t²+r²+2·Im(W)·(±tr) = 1",
           "even63": "anchor-collinear pin (√7 family)",
           "odd63": "anchor-perpendicular pin (√7 family)",
           "mixed": "sterile by law (no cross chords away from the anchor)"}


def make_detune(s=None, a: int = 0, b: int = 0, name: str = "") -> dict:
    """A detune R = s·√ρ₁₅^a·√ρ₆₃^b, entering FACTORED (the class is not recoverable from R)."""
    s = ONE_C if s is None else s
    if not is_unit_rot(s):
        raise SystemExit("DETUNE REJECTED: the seam decoration s is not a unit rotation")
    if not (in_K(s[0]) and in_K(s[1])):
        raise SystemExit("DETUNE REJECTED: the seam decoration s has new-field content — "
                         "fold it into the (a, b) exponents instead")
    if a and b:
        cls = "mixed"
    elif a:
        cls = "even15" if a % 2 == 0 else "odd15"
    elif b:
        cls = "even63" if b % 2 == 0 else "odd63"
    else:
        cls = "seam"
    W = C.cmul(wpow(HALF15, a), wpow(HALF63, b))
    return {"s": s, "a": a, "b": b, "cls": cls, "W": W, "R": C.cmul(s, W),
            "name": name or f"s·√ρ₁₅^{a}·√ρ₆₃^{b}", }


# ------------------------------------------------------------------ the quadrature law

def law_check(det: dict, u, v, where: str) -> dict:
    """Verify the §0a pin for one cross chord with copy-side preimage offset u and base-side
    offset v (both from the anchor). Returns the chord's certificate; aborts on violation.

    Premise: u and v are seam-field (all components in K). Callers outside that premise must
    not call this — the law says nothing there."""
    for w, nm in ((u, "u"), (v, "v")):
        if not (in_K(w[0]) and in_K(w[1])):
            raise SystemExit(f"LAW CHECK MISAPPLIED at {where}: offset {nm} is not seam-field — "
                             f"the premise fails; classify this chord as out-of-scope instead")
    z = C.cmul(C.cmul(det["s"], u), C.cconj(v))    # s·u·v̄, both components in K
    cls = det["cls"]
    if cls == "seam":
        return {"pin": "seam"}
    violation = None
    if cls in ("even15", "even63"):
        if any(z[1]):
            violation = f"Im(s·u·v̄) = {exact_str(z[1])} ≠ 0 (collinear pin expected)"
        pin = "collinear"
        tr = z[0]
    elif cls in ("odd15", "odd63"):
        if any(z[0]):
            violation = f"Re(s·u·v̄) = {exact_str(z[0])} ≠ 0 (perpendicular pin expected)"
        pin = "perpendicular"
        tr = z[1]
    else:  # mixed
        if any(z[0]) or any(z[1]):
            violation = f"s·u·v̄ = ({exact_str(z[0])}, {exact_str(z[1])}) ≠ 0 (sterility expected)"
        pin = "sterile"
        tr = z[0]
    if violation is not None:
        raise SystemExit(
            f"LAW VIOLATION at {where} — registered prediction P1 is FALSIFIED.\n"
            f"  detune {det['name']} (class {cls}): {violation}\n"
            f"  §0a's block-independence argument is wrong. Halting; report at face value.")
    t2, r2 = nsq(u), nsq(v)
    # The conic identity: |u|² + |v|² − 2·Re(W·z) = 1 — recomputed independently of the sweep.
    lhs = C.sub(C.sub(C.add(t2, r2),
                      FLD.scal(2, C.sub(C.mul(det["W"][0], z[0]), C.mul(det["W"][1], z[1])))),
                C.const(1))
    if any(lhs):
        raise SystemExit(f"CONIC IDENTITY FAILED at {where}: the chord equation does not "
                         f"re-derive — the census and the law checker disagree; instrument bug")
    return {"pin": pin, "t2": fnum(t2), "r2": fnum(r2), "tr": fnum(tr),
            "t2_exact": exact_str(t2), "r2_exact": exact_str(r2), "tr_exact": exact_str(tr)}


# ------------------------------------------------------------------ mitosis

def mitosis(base_pts, anchor, det: dict) -> dict:
    """base ∪ (anchor + R·(p − anchor)) with exact dedup. Provenance: (0, i) base, (1, i) copy."""
    table: dict[tuple, int] = {}
    pts, prov = [], []

    def put(p, tag, src):
        k = key(p)
        if k not in table:
            table[k] = len(pts)
            pts.append(p)
            prov.append([])
        prov[table[k]].append((tag, src))

    for i, p in enumerate(base_pts):
        put(p, 0, i)
    R = det["R"]
    for i, p in enumerate(base_pts):
        put(cadd(anchor, C.cmul(R, csub(p, anchor))), 1, i)
    fixed = sum(1 for p in base_pts if key(cadd(anchor, C.cmul(R, csub(p, anchor)))) == key(p))
    fused = [i for i, pr in enumerate(prov) if len(pr) > 1]
    return {"pts": pts, "table": table, "prov": prov, "anchor": anchor, "det": det,
            "base_pts": base_pts, "fused": fused, "fixed_points": fixed}


# ------------------------------------------------------------------ unit edges (triage + exact)

def unit_edges(pts, window: float = 1e-6) -> list[tuple[int, int]]:
    """All unit-distance pairs: numpy float triage, then exact confirmation of every candidate.
    Soundness margin: real chords err ~1e-13 in float64; the nearest KNOWN near-miss is
    |d²−1| ≈ 0.035 (M22's near-relation) — five orders above the window, both directions."""
    n = len(pts)
    if np is None or n < 64:
        out = []
        for i in range(n):
            for j in range(i + 1, n):
                d = csub(pts[i], pts[j])
                if nsq(d) == C.const(1):
                    out.append((i, j))
        return out
    xy = np.array([approx(p) for p in pts])
    out = []
    block = max(1, 2_000_000 // max(n, 1))
    for lo in range(0, n, block):
        hi = min(n, lo + block)
        dx = xy[lo:hi, None, 0] - xy[None, :, 0]
        dy = xy[lo:hi, None, 1] - xy[None, :, 1]
        d2 = dx * dx + dy * dy
        cand = np.argwhere(np.abs(d2 - 1.0) < window)
        for a, j in cand:
            i = lo + int(a)
            j = int(j)
            if i < j:
                d = csub(pts[i], pts[j])
                if nsq(d) == C.const(1):
                    out.append((i, j))
    return out


# ------------------------------------------------------------------ census of a mitotic union

def census(m: dict, label: str) -> dict:
    """Edge classes, the isometry control, and the law check on every cross reading."""
    pts, prov, det, anchor = m["pts"], m["prov"], m["det"], m["anchor"]
    edges = unit_edges(pts)
    tags = [{t for (t, _) in pr} for pr in prov]
    srcs = [{t: s for (t, s) in pr} for pr in prov]
    n_base = n_copy = anchor_incident = 0
    cross = []
    for (i, j) in edges:
        if 0 in tags[i] and 0 in tags[j]:
            n_base += 1
        if 1 in tags[i] and 1 in tags[j]:
            n_copy += 1
        for (ci, bj) in ((i, j), (j, i)):
            if 1 in tags[ci] and 0 in tags[bj]:
                u = csub(m["base_pts"][srcs[ci][1]], anchor)   # preimage offset of the copy side
                v = csub(pts[bj], anchor)
                if (not any(u[0]) and not any(u[1])) or (not any(v[0]) and not any(v[1])):
                    # a chord THROUGH the anchor point itself — shared-vertex triviality,
                    # not coupling; the law is vacuous there (z = 0) by design
                    anchor_incident += 1
                    break
                cert = law_check(det, u, v, f"{label} edge ({i},{j})")
                cross.append({"i": i, "j": j, **cert})
                break   # one cross reading certifies the chord; a second is its mirror
    if n_base != n_copy:
        raise SystemExit(f"ISOMETRY CONTROL FAILED at {label}: {n_base} intra-base vs "
                         f"{n_copy} intra-copy edges — the sweep or the dedup is wrong")
    return {"edges": edges, "n_base": n_base, "n_copy": n_copy, "cross": cross,
            "anchor_incident": anchor_incident}


# ------------------------------------------------------------------ stacks (M32)
#
# A stack is a LIST of copies — copy = (anchor, detune spec) — with the base as copy 0 under
# the identity spec. Detune specs form a group, so a copy-pair's coupling class is a total
# function of the SPEC QUOTIENT (§0d): `same_anchor` routes to the M31 single-word law at the
# relative spec; `translation` (identical R, different anchors) routes to the §0a case-2
# difference-pin law; `general` is RECORDED-ONLY — for an exactly-confirmed unit chord,
# per-block vanishing of the 16-basis decomposition is trivially true, so no structured claim
# exists there and the census must not wear a law badge it did not earn.

def stack(base_pts, copies: list[tuple[object, dict]]) -> dict:
    """base ∪ (aᵢ + Rᵢ·(p − aᵢ)) for each copy i ≥ 1, exact dedup, provenance (tag, src)."""
    table: dict[tuple, int] = {}
    pts, prov = [], []

    def put(p, tag, src):
        kk = key(p)
        if kk not in table:
            table[kk] = len(pts)
            pts.append(p)
            prov.append([])
        prov[table[kk]].append((tag, src))

    for i, p in enumerate(base_pts):
        put(p, 0, i)
    for ci, (anchor, det) in enumerate(copies, start=1):
        R = det["R"]
        for i, p in enumerate(base_pts):
            put(cadd(anchor, C.cmul(R, csub(p, anchor))), ci, i)
    fused = [i for i, pr in enumerate(prov) if len({t for (t, _) in pr}) > 1]
    return {"pts": pts, "table": table, "prov": prov, "copies": copies,
            "base_pts": base_pts, "fused": fused}


def pair_relative(copies, ta: int, tb: int) -> dict:
    """The coupling route of tag pair (ta < tb). Tag 0 = base = the identity about every
    anchor, so base↔copy is the same-anchor case at the copy's own anchor."""
    assert ta < tb
    ab, db = copies[tb - 1]
    if ta == 0:
        aa, da = ab, make_detune()          # identity, about the copy's anchor
    else:
        aa, da = copies[ta - 1]
    same_anchor = (ta == 0) or (key(aa) == key(ab))
    if same_anchor:
        rel = make_detune(s=C.cmul(C.cconj(da["s"]), db["s"]),
                          a=db["a"] - da["a"], b=db["b"] - da["b"],
                          name=f"rel({ta},{tb})")
        return {"route": "same_anchor", "rel": rel, "anchor": ab}
    if da["a"] == db["a"] and da["b"] == db["b"] and key(da["s"]) == key(db["s"]):
        return {"route": "translation", "det": db, "A": csub(ab, aa),
                "anchors": (aa, ab)}
    return {"route": "general",
            "rel": {"ds": exact_str(C.cmul(C.cconj(da["s"]), db["s"])[0]),
                    "da": db["a"] - da["a"], "db": db["b"] - da["b"]},
            "anchors": (aa, ab)}


def translation_check(det: dict, A, w, where: str) -> dict:
    """§0a case 2: a chord between two copies of the SAME detune R = s·W about anchors at
    separation A ≠ 0 satisfies |A + R·w|² = 1 with w = u_b − u_a the preimage-offset
    difference. The block split pins: even word → Im(s·w·Ā) = 0 (w collinear with the
    twisted anchor axis); odd word → Re(s·w·Ā) = 0; mixed word → both (only w = 0
    survives); w = 0 is the TRANSLATION MATCHING, legal exactly when |A|² = 1."""
    cls = det["cls"]
    if not any(w[0]) and not any(w[1]):
        if nsq(A) != C.const(1):
            raise SystemExit(
                f"STACKING-LAW VIOLATION at {where} — §0a case 2 is FALSIFIED.\n"
                f"  a w = 0 matching chord at anchor separation |A|² ≠ 1\n"
                f"  Halting; report at face value.")
        return {"pin": "matching", "w2_exact": {}}
    zeta = C.cmul(C.cmul(det["s"], w), C.cconj(A))     # s·w·Ā, both components in K
    violation = None
    if cls in ("even15", "even63"):
        if any(zeta[1]):
            violation = f"Im(s·w·Ā) = {exact_str(zeta[1])} ≠ 0 (difference-collinear pin)"
        pin = "diff-collinear"
    elif cls in ("odd15", "odd63"):
        if any(zeta[0]):
            violation = f"Re(s·w·Ā) = {exact_str(zeta[0])} ≠ 0 (difference-perpendicular pin)"
        pin = "diff-perpendicular"
    elif cls == "mixed":
        if any(zeta[0]) or any(zeta[1]):
            violation = f"s·w·Ā ≠ 0 (mixed word: only the w = 0 matching survives)"
        pin = "sterile"
    else:                                   # pure seam relative word: no quadrature pin
        pin = "seam"
    if violation is not None:
        raise SystemExit(
            f"STACKING-LAW VIOLATION at {where} — registered §0a case 2 (prediction Q4 family) "
            f"is FALSIFIED.\n  shared detune {det['name']} (class {cls}): {violation}\n"
            f"  Halting; report at face value.")
    # the K-block identity, recomputed independently of the sweep:
    g = C.cmul(C.cmul(det["R"], w), C.cconj(A))        # R·w·Ā  (R = s·W whole)
    lhs = C.sub(C.add(C.add(nsq(A), nsq(w)), FLD.scal(2, g[0])), C.const(1))
    if any(lhs):
        raise SystemExit(f"STACK IDENTITY FAILED at {where}: |A|² + |w|² + 2·Re(R·w·Ā) ≠ 1 — "
                         f"the census and the checker disagree; instrument bug")
    w2 = nsq(w)
    return {"pin": pin, "w2": fnum(w2), "w2_exact": exact_str(w2)}


def stack_census(st: dict, label: str) -> dict:
    """Edge classes over all provenance pairs, isometry control per copy, class-routed
    certificates: same-anchor → the M31 law; translation → the difference pin; general →
    recorded-only (the relative spec, no badge)."""
    pts, prov, copies, base_pts = st["pts"], st["prov"], st["copies"], st["base_pts"]
    ncop = len(copies)
    edges = unit_edges(pts)
    tags = [{t for (t, _) in pr} for pr in prov]
    srcs = [{t: s for (t, s) in pr} for pr in prov]
    routes = {(ta, tb): pair_relative(copies, ta, tb)
              for ta in range(ncop + 1) for tb in range(ta + 1, ncop + 1)}
    intra = {t: 0 for t in range(ncop + 1)}
    pairs = {(ta, tb): {"chords": [], "anchor_incident": 0, "matching": 0}
             for (ta, tb) in routes}

    def offset(tag, idx, anchor):
        """Preimage offset from `anchor`: base points are their own preimages."""
        src = srcs[idx][tag]
        return csub(base_pts[src], anchor) if tag > 0 else csub(pts[idx], anchor)

    for (i, j) in edges:
        for t in tags[i] & tags[j]:
            intra[t] += 1
        for ta in sorted(tags[i] | tags[j]):
            for tb in sorted(tags[i] | tags[j]):
                if not (ta < tb):
                    continue
                # orient: pa carries ta, pb carries tb (skip if this edge lacks the pair)
                if ta in tags[i] and tb in tags[j]:
                    pa, pb = i, j
                elif ta in tags[j] and tb in tags[i]:
                    pa, pb = j, i
                else:
                    continue
                rt = routes[(ta, tb)]
                rec = pairs[(ta, tb)]
                where = f"{label} pair({ta},{tb}) edge ({i},{j})"
                if rt["route"] == "same_anchor":
                    anchor = rt["anchor"]
                    u = offset(tb, pb, anchor)          # moving side (higher tag)
                    v = offset(ta, pa, anchor)
                    if (not any(u[0]) and not any(u[1])) or (not any(v[0]) and not any(v[1])):
                        rec["anchor_incident"] += 1
                        continue
                    cert = law_check(rt["rel"], u, v, where)
                    rec["chords"].append({"i": i, "j": j, "kind": "relative-law", **cert})
                elif rt["route"] == "translation":
                    aa, ab = rt["anchors"]
                    w = csub(offset(tb, pb, ab), offset(ta, pa, aa))
                    cert = translation_check(rt["det"], rt["A"], w, where)
                    if cert["pin"] == "matching":
                        rec["matching"] += 1
                    rec["chords"].append({"i": i, "j": j, "kind": "difference-pin", **cert})
                else:
                    rec["chords"].append({"i": i, "j": j, "kind": "recorded",
                                          "rel": rt["rel"]})
    for t in range(1, ncop + 1):
        if intra[t] != intra[0]:
            raise SystemExit(f"ISOMETRY CONTROL FAILED at {label}: intra-base {intra[0]} vs "
                             f"intra-copy{t} {intra[t]} — the sweep or the dedup is wrong")
    return {"edges": edges, "intra": intra, "pairs": pairs, "routes": routes,
            "n_fused": len(st["fused"])}


# ------------------------------------------------------------------ χ probe

def chi_probe(n: int, edges, k: int, cap: float) -> dict:
    t0 = time.time()
    status, model = _solve(base_clauses(n, edges, k), n * k, cap)
    row = {"k": k, "outcome": status, "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = [next(c for c in range(k) if var(v, c, k) in model) for v in range(n)]
        for (a, b) in edges:
            if colours[a] == colours[b]:
                raise SystemExit(f"SAT MODEL INVALID: edge ({a},{b}) monochromatic — solver or "
                                 f"decode is wrong")
        row["colours"] = colours
    return row


# ------------------------------------------------------------------ graded closure

def close_gen(pts, centres, gens: list[tuple[str, object]]) -> dict:
    """ONE word-length generation: every ± generator about every centre applied to every point.
    Returns the union with per-point (generation, move, parent) provenance."""
    table = {key(p): i for i, p in enumerate(pts)}
    out = list(pts)
    prov = [None] * len(pts)       # generation-0 points carry no move
    fusions = 0
    for ci, ctr in enumerate(centres):
        for gname, g in gens:
            for sign, gg in ((1, g), (-1, C.cconj(g))):
                for pi in range(len(pts)):
                    q = cadd(ctr, C.cmul(gg, csub(pts[pi], ctr)))
                    kq = key(q)
                    if kq in table:
                        if table[kq] != pi:
                            fusions += 1
                        continue
                    table[kq] = len(out)
                    out.append(q)
                    prov.append((1, ci, gname, sign, pi))
    return {"pts": out, "prov": prov, "new": len(out) - len(pts), "fusions": fusions}


def rings(pts, centre) -> dict:
    """Exact squared radii about a centre, with counts."""
    inv: dict[tuple, int] = {}
    for p in pts:
        r2 = tuple(nsq(csub(p, centre)))
        inv[r2] = inv.get(r2, 0) + 1
    return inv


# ------------------------------------------------------------------ objects

def hexagram_points(B: int):
    import hexchunk as HX
    pts, _table, _labels = HX.gen_points(B)
    return pts, HX.MPIV, HX.HEXPIV


def pair_points(B: int, dist: int = 2):
    """The de Grey pair: ⟨ζ₆,σ⟩-ladders (outer + inner) at centres 0 and `dist`, plus both
    centre points as vertices (the spindle chord is centre-level)."""
    inner = [F(0)] * DIM
    inner[B3] = F(1, 3)                       # 1/√3
    c0 = ZERO_C
    c1 = C.frac_c({B1: F(dist)})
    pts = [c0, c1]
    for ctr in (c0, c1):
        for x in range(6):
            for b in range(-B, B + 1):
                w = C.cmul(wpow(Z6, x), wpow(SEAM, b))
                pts.append(cadd(ctr, w))
                pts.append(cadd(ctr, C.cscale(inner, w)))
    dedup: dict[tuple, int] = {}
    out = []
    for p in pts:
        if key(p) not in dedup:
            dedup[key(p)] = len(out)
            out.append(p)
    return out, c0, c1


def degrey_points():
    """The committed 1581, construction frame, converted at the boundary."""
    import anatomy as A
    pts, _table, _addr = A.build_addresses()
    return [from_degrey(p) for p in pts], from_degrey(A.ORIGIN), from_degrey(A.CENTRE2)


# ------------------------------------------------------------------ probes

def report_variant(tag: str, m: dict, cen: dict, chi_rows, out: dict):
    det = m["det"]
    entry = {
        "object": tag,
        "detune": {"s": [exact_str(det["s"][0]), exact_str(det["s"][1])],
                   "a": det["a"], "b": det["b"], "class": det["cls"], "name": det["name"]},
        "anchor": [exact_str(m["anchor"][0]), exact_str(m["anchor"][1])],
        "counts": {"base": len(m["base_pts"]), "union": len(m["pts"]),
                   "fused": len(m["fused"]), "fixed_points": m["fixed_points"]},
        "edges": {"intra_base": cen["n_base"], "intra_copy": cen["n_copy"],
                  "cross": len(cen["cross"]), "anchor_incident": cen["anchor_incident"],
                  "total": len(cen["edges"])},
        "cross_chords": cen["cross"],
        "chi": chi_rows,
        "controls": {"isometry_edge_match": True, "law_violations": 0},
    }
    out[tag] = entry
    cr = len(cen["cross"])
    ai = cen["anchor_incident"]
    verdict = (f"{cr} cross chords (+{ai} through the anchor)" if cr else
               f"0 cross chords (+{ai} through the anchor) — a RESULT: class '{det['cls']}' is "
               + ("sterile by law" if det["cls"] == "mixed" else "thin here"))
    chis = ", ".join(f"k={r['k']}:{r['outcome']}" for r in chi_rows)
    print(f"  {tag:34s} {verdict:44s} [{chis}]")


def probe_a(B: int, cap: float, out_path: Path):
    print(f"probe A — mitotic hexagram sweep at B={B}")
    pts, mpiv, hexpiv = hexagram_points(B)
    anchors = [("m", mpiv), ("p0", hexpiv[0])]
    detunes = [make_detune(a=2, name="rho15"), make_detune(b=2, name="rho63"),
               make_detune(a=1, name="half15"), make_detune(b=1, name="half63"),
               make_detune(a=1, b=1, name="mixed15x63"),
               make_detune(s=Z12, a=2, name="zeta12*rho15")]
    out: dict = {}
    for aname, anchor in anchors:
        for det in detunes:
            m = mitosis(pts, anchor, det)
            cen = census(m, f"hexagram-B{B}/{aname}/{det['name']}")
            chi_rows = [chi_probe(len(m["pts"]), cen["edges"], k, cap) for k in (3, 4, 5)]
            report_variant(f"hexB{B}/{aname}/{det['name']}", m, cen, chi_rows, out)
    json.dump(out, open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")


def probe_b(B: int, cap: float, out_path: Path):
    print(f"probe B — the de Grey pair (centres at distance 2) at B={B}")
    pts, c0, c1 = pair_points(B)
    base_edges = unit_edges(pts)
    print(f"  plain pair: {len(pts)} points, {len(base_edges)} unit chords "
          f"(intra-ladder + the distance-2 cross families)")
    out: dict = {"plain": {"object": f"pair-B{B}", "n": len(pts),
                           "edges_total": len(base_edges),
                           "chi": [chi_probe(len(pts), base_edges, k, cap) for k in (3, 4, 5)]}}
    for det in [make_detune(a=2, name="rho15"), make_detune(a=1, name="half15")]:
        m = mitosis(pts, c0, det)
        cen = census(m, f"pair-B{B}/c0/{det['name']}")
        chi_rows = [chi_probe(len(m["pts"]), cen["edges"], k, cap) for k in (3, 4, 5)]
        report_variant(f"pairB{B}/c0/{det['name']}", m, cen, chi_rows, out)
    json.dump(out, open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")


GEN1_GENS = [("zeta12", Z12), ("sigma", SEAM), ("half15", HALF15), ("half63", HALF63)]


def gen1(out_path: Path, cap: float):
    print("gen-1 half-spindle closure of the 1581 about both spindle centres")
    pts, origin, centre2 = degrey_points()
    t0 = time.time()
    g = close_gen(pts, [origin, centre2], GEN1_GENS)
    print(f"  growth: 1581 → {len(g['pts'])} points (+{g['new']}, {g['fusions']} collisions) "
          f"in {time.time()-t0:.0f}s")
    t0 = time.time()
    edges = unit_edges(g["pts"])
    print(f"  unit chords: {len(edges)} in {time.time()-t0:.0f}s")
    ring0 = rings(g["pts"], origin)
    print(f"  rings about the origin centre: {len(ring0)} (was 819 at the witness alone)")
    base_edges = [e for e in edges if e[0] < 1581 and e[1] < 1581]
    if len(base_edges) != 7877:
        raise SystemExit(f"CONTROL FAILED: the sweep finds {len(base_edges)} edges inside the "
                         f"1581 — the committed count is 7877; triage or arithmetic is wrong")
    print("  control: the 1581's own 7877 edges reproduced exactly inside the sweep")
    row = chi_probe(len(g["pts"]), edges, 5, cap)
    print(f"  k=5 on the whole gen-1 object: {row['outcome']} ({row['seconds']}s)")
    json.dump({"object": "degrey-gen1", "n": len(g["pts"]), "new": g["new"],
               "fusions": g["fusions"], "edges": len(edges),
               "rings_origin": len(ring0),
               "chi": [dict(row, colours=None)],   # the model is large; keep the record light
               "generators": [n for n, _ in GEN1_GENS], "centres": 2},
              open(out_path, "w"), indent=1)
    # persist the geometry for the frontier probe and the visualizer
    np_path = out_path.with_suffix(".pts.json")
    json.dump({"xy": [approx(p) for p in g["pts"]], "edges": edges,
               "gen": [0 if p is None else 1 for p in g["prov"]]}, open(np_path, "w"))
    print(f"wrote {out_path} and {np_path}")


def frontier(gen1_path: Path, cap: float, out_path: Path):
    """The k=4 SAT-findability frontier over growing balls about the axis midpoint,
    plain (committed 1581 vertices only) vs enriched (+ gen-1 points in the ball)."""
    data = json.load(open(gen1_path))
    xy = data["xy"]
    edges = [tuple(e) for e in data["edges"]]
    gen = data["gen"]
    mid = (-1.0, 0.0)
    d2 = [((x - mid[0]) ** 2 + (y - mid[1]) ** 2) for (x, y) in xy]
    base_ids = [i for i, g in enumerate(gen) if g == 0]
    base_sorted = sorted(base_ids, key=lambda i: d2[i])
    targets = [300, 600, 900, 1200, 1581]
    adj: dict[int, list[int]] = {}
    for (a, b) in edges:
        adj.setdefault(a, []).append(b)
        adj.setdefault(b, []).append(a)
    rows = []
    for t in targets:
        chosen = base_sorted[:t]
        r2max = d2[chosen[-1]]
        for variant in ("plain", "enriched"):
            keep = set(chosen)
            if variant == "enriched":
                keep |= {i for i, g in enumerate(gen) if g == 1 and d2[i] <= r2max}
            idx = {v: i for i, v in enumerate(sorted(keep))}
            sub = [(idx[a], idx[b]) for (a, b) in edges if a in keep and b in keep]
            row = chi_probe(len(keep), sub, 4, cap)
            row.pop("colours", None)
            rows.append({"target_base": t, "r2max": round(r2max, 4), "variant": variant,
                         "n": len(keep), "edges": len(sub), **row})
            print(f"  base≤{t:5d} r²≤{r2max:7.2f} {variant:9s} n={len(keep):6d} "
                  f"e={len(sub):7d} k=4:{row['outcome']} ({row['seconds']}s)")
    json.dump({"object": "degrey-gen1-frontier", "midpoint": mid, "rows": rows},
              open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")


# ------------------------------------------------------------------ self-test

def self_test():
    """Every control seen red on cue before it is believed green."""
    ok = lambda what: print(f"  ok  {what}")

    # 1. boundary round-trip
    p = D.S[3]
    if to_degrey(from_degrey(p)) != p:
        raise SystemExit("SELF-TEST FAILED: degrey ⇄ couple round-trip is not the identity")
    ok("boundary conversion round-trips a construction seed")

    # 2. planted spindle chords: base {2, 3/2} on the real axis, ρ₁₅ about 0 —
    #    the conic's rational solutions (2,2), (2,3/2), (3/2,2) and nothing else
    base = [C.frac_c({B1: F(2)}), C.frac_c({B1: F(3, 2)})]
    det = make_detune(a=2, name="rho15")
    m = mitosis(base, ZERO_C, det)
    cen = census(m, "self-test/planted")
    got = {(round(c["t2"], 6), round(c["r2"], 6)) for c in cen["cross"]}
    if got != {(4.0, 4.0), (4.0, 2.25), (2.25, 4.0)}:
        raise SystemExit(f"SELF-TEST FAILED: planted spindle census found {got}, wanted the "
                         f"three conic solutions (2,2), (2,3/2), (3/2,2)")
    if any(c["pin"] != "collinear" for c in cen["cross"]):
        raise SystemExit("SELF-TEST FAILED: planted chords not certified collinear")
    ok("planted ρ₁₅ chords: exactly the three conic solutions, each pinned collinear")

    # 3. the law checker goes red on cue: a perpendicular pair handed to an even detune
    try:
        law_check(det, C.frac_c(None, {B1: F(2)}), C.frac_c({B1: F(2)}), "self-test/violation")
        raise SystemExit("SELF-TEST FAILED: the law checker accepted a planted violation")
    except SystemExit as e:
        if "P1 is FALSIFIED" not in str(e):
            raise
    ok("planted pin violation caught, named as a P1 falsification")

    # 4. dedup + fusion: a seam rotation that is an automorphism fuses EVERYTHING
    pts, mpiv, _ = hexagram_points(0)
    m = mitosis(pts, mpiv, make_detune(s=Z6, name="zeta6"))
    if len(m["pts"]) != len(pts) or len(m["fused"]) != len(pts):
        raise SystemExit("SELF-TEST FAILED: ζ₆ about the metapivot should fuse the whole chunk")
    ok("ζ₆ mitosis of the hexagram chunk fuses pointwise (dedup + provenance)")

    # 5. SAT wrapper red/green
    k5 = [(i, j) for i in range(5) for j in range(i + 1, 5)]
    if chi_probe(5, k5, 4, 60)["outcome"] != "unsat":
        raise SystemExit("SELF-TEST FAILED: K5 at k=4 must refuse")
    if chi_probe(4, [(i, j) for i in range(4) for j in range(i + 1, 4)], 4, 60)["outcome"] != "sat":
        raise SystemExit("SELF-TEST FAILED: K4 at k=4 must colour")
    ok("SAT wrapper: K5 refuses at 4, K4 colours at 4")

    # 6. mixed detunes are sterile on the planted base (the sterility control)
    m = mitosis(base, ZERO_C, make_detune(a=1, b=1, name="mixed"))
    cen = census(m, "self-test/mixed")
    if cen["cross"]:
        raise SystemExit("SELF-TEST FAILED: a mixed detune produced cross chords — "
                         "either the law is wrong (P1!) or the census mislabels")
    ok("mixed detune sterile on the planted base")

    # ---- M32: the stack machinery ----

    # 7. pair-class routing is the spec quotient
    a1, a2 = ZERO_C, ONE_C
    d_full = make_detune(a=2, name="rho15")
    d_anti = make_detune(a=-2, name="rho15inv")
    d_half = make_detune(a=1, name="half15")
    cps = [(a1, d_full), (a1, d_anti), (a2, d_full), (a2, d_half)]
    r01 = pair_relative(cps, 0, 1)
    r12 = pair_relative(cps, 1, 2)
    r13 = pair_relative(cps, 1, 3)
    r14 = pair_relative(cps, 1, 4)
    if not (r01["route"] == "same_anchor" and r01["rel"]["cls"] == "even15"
            and r12["route"] == "same_anchor" and r12["rel"]["a"] == -4
            and r13["route"] == "translation"
            and r14["route"] == "general"):
        raise SystemExit(f"SELF-TEST FAILED: pair-class routing wrong — got "
                         f"{[r01['route'], r12['route'], r13['route'], r14['route']]}")
    ok("pair-class routing: base↔copy same-anchor, chirality relative a=−4, "
       "same-word cross-anchor translation, mixed-spec general")

    # 8. planted translation matching: base holds x and x+(a2−a1), so the two ρ₁₅ copies
    #    about a1 and a2 carry the w = 0 matching chord — found and pinned as `matching`
    x = Z6
    tb = [x, cadd(x, csub(a2, a1))]
    st = stack(tb, [(a1, d_full), (a2, d_full)])
    cen = stack_census(st, "self-test/matching")
    m12 = cen["pairs"][(1, 2)]
    if m12["matching"] < 1 or not any(c["kind"] == "difference-pin" and c["pin"] == "matching"
                                      for c in m12["chords"]):
        raise SystemExit("SELF-TEST FAILED: the planted translation matching was not found")
    ok("planted translation matching found at |A| = 1, pinned `matching`")

    # 9. the difference-pin checker goes red on cue (a perpendicular w handed to an even word)
    try:
        translation_check(d_full, ONE_C, C.frac_c(None, {B1: F(1)}), "self-test/stack-violation")
        raise SystemExit("SELF-TEST FAILED: the difference-pin checker accepted a violation")
    except SystemExit as e:
        if "§0a case 2" not in str(e):
            raise
    ok("planted difference-pin violation caught, named as a §0a case-2 falsification")

    # 10. the stack identity check goes red on a pinned-but-non-unit chord
    try:
        translation_check(d_full, ONE_C, C.frac_c({B1: F(2)}), "self-test/stack-identity")
        raise SystemExit("SELF-TEST FAILED: the identity check accepted a non-unit chord")
    except SystemExit as e:
        if "IDENTITY FAILED" not in str(e):
            raise
    ok("stack identity check refuses a pinned but non-unit chord")

    # 11. w = 0 at |A| ≠ 1 is a violation, not a matching
    try:
        translation_check(d_full, C.frac_c({B1: F(2)}), ZERO_C, "self-test/badA")
        raise SystemExit("SELF-TEST FAILED: a w = 0 chord at |A| ≠ 1 was accepted")
    except SystemExit as e:
        if "matching chord at anchor separation" not in str(e):
            raise
    ok("w = 0 matching rejected at anchor separation ≠ 1")

    print("self-test: OK")


# ------------------------------------------------------------------ M32 probes

Z3 = C.cpow(Z6, 2)


def circle_target(pts, centre):
    """Indices at exact radius² = 1 about the centre — where a fresh centre vertex would attach."""
    one = C.const(1)
    return [i for i, p in enumerate(pts) if nsq(csub(p, centre)) == one]


def present_triples(pts, centre, limit: int = 21):
    """Outer 120°-triples about a centre: x on its unit circle whose ζ₃-orbit is present.
    Deterministic stride sampling when more than `limit` exist (no randomness — resumable)."""
    table = {key(p): i for i, p in enumerate(pts)}
    seen, triples = set(), []
    for i in circle_target(pts, centre):
        u = csub(pts[i], centre)
        j = table.get(key(cadd(centre, C.cmul(Z3, u))))
        l = table.get(key(cadd(centre, C.cmul(C.cpow(Z3, 2), u))))
        if j is None or l is None:
            continue
        tri = tuple(sorted((i, j, l)))
        if tri not in seen:
            seen.add(tri)
            triples.append(tri)
    if len(triples) > limit:
        stride = len(triples) // limit
        triples = triples[::stride][:limit]
    return triples


def run_meters(n, edges, pts, targets_named, k, cap, base_cov=None):
    """Coverage ladders + triple queries. `base_cov` (target name → min_cover result) is the
    bare-fabric baseline reported BESIDE each stack reading, so the delta is the product term."""
    import rigidity as RG
    coverage, triples = [], []
    for name, c in targets_named:
        S = circle_target(pts, c)
        if not S:
            coverage.append({"target": name, "note": "empty target — no circle points present"})
            continue
        mc = RG.min_cover(n, edges, k, S, cap)
        row = {"target": name, "n_target": len(S), **{kk: vv for kk, vv in mc.items()}}
        if base_cov and name in base_cov:
            row["base_verdict"] = base_cov[name].get("verdict")
            row["base_lo_hi"] = [base_cov[name].get("lo"), base_cov[name].get("hi")]
        coverage.append(row)
        print(f"    coverage {name}: {mc['verdict']}"
              + (f" [{mc.get('lo')},{mc.get('hi')}]" if "lo" in mc else ""))
        for tri in present_triples(pts, c):
            for mode in ("mono", "rainbow"):
                tq = RG.triple_query(n, edges, k, tri, mode, cap)
                tq["about"] = name
                triples.append(tq)
                if tq["outcome"] == "unsat":
                    print(f"    COMPELLED non-{mode} triple {tri} about {name} — the M20 genre "
                          f"one field up; a Q5 meter positive")
    return coverage, triples


def pair_summary(cen):
    out = {}
    for (ta, tb), rec in cen["pairs"].items():
        out[f"{ta}-{tb}"] = {"cross": len(rec["chords"]),
                             "anchor_incident": rec["anchor_incident"],
                             "matching": rec["matching"],
                             "route": cen["routes"][(ta, tb)]["route"]}
    return out


def probe_base(B, cap, out_path: Path):
    """M32 probe A: the bare fabric's compulsion floor (Q2)."""
    pts, mpiv, hexpiv = hexagram_points(B)
    n = len(pts)
    edges = unit_edges(pts)
    print(f"probe-base: hexagram B={B}: {n} points, {len(edges)} unit edges")
    chi = [chi_probe(n, edges, k, cap) for k in (3, 4)]
    for r in chi:
        print(f"  chi k={r['k']}: {r['outcome']} ({r['seconds']}s)")
    out = {"object": f"hexagram-B{B}", "n": n, "n_edges": len(edges), "chi":
           [{k: v for k, v in r.items() if k != "colours"} for r in chi]}
    if not any(r["k"] == 4 and r["outcome"] == "sat" for r in chi):
        out["note"] = "k=4 not sat — meters withheld (vacuity guard at the driver level)"
    else:
        targets = [("meta", mpiv)] + [(f"hexpiv{a}", hexpiv[a]) for a in range(6)]
        coverage, triples = run_meters(n, edges, pts, targets, 4, cap)
        out["coverage"], out["triples"] = coverage, triples
        n_comp = sum(1 for t in triples if t["outcome"] == "unsat")
        out["compelled_triples"] = n_comp
        print(f"  base rates: {n_comp} compelled triple readings "
              f"/ {len(triples)} queries (Q2c registers ~0 expected)")
    json.dump(out, open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")
    return out


def _stack_variant(tag, pts, copies, cap, meters_targets=None, base_cov=None,
                   chi_ks=(3, 4, 5)):
    st = stack(pts, copies)
    n = len(st["pts"])
    cen = stack_census(st, tag)
    edges = cen["edges"]
    psum = pair_summary(cen)
    print(f"  {tag}: {n} pts, {len(edges)} edges; pairs: "
          + "; ".join(f"{k} {v['route']}: {v['cross']} cross"
                      + (f" ({v['matching']} matching)" if v["matching"] else "")
                      for k, v in sorted(psum.items())))
    chi = [chi_probe(n, edges, k, cap) for k in chi_ks]
    for r in chi:
        print(f"    chi k={r['k']}: {r['outcome']} ({r['seconds']}s)")
    entry = {"object": tag,
             "stack": [{"anchor": exact_str(a[0]) | {"im": exact_str(a[1])},
                        "detune": {"s": exact_str(d["s"][0]) | {"im": exact_str(d["s"][1])},
                                   "a": d["a"], "b": d["b"], "class": d["cls"],
                                   "name": d["name"]}}
                       for (a, d) in copies],
             "n": n, "n_edges": len(edges), "n_fused": cen["n_fused"],
             "pairwise": [{"pair": k, **v,
                           "chords": [c for c in cen["pairs"][tuple(map(int, k.split('-')))]
                                      ["chords"]][:200]}
                          for k, v in sorted(psum.items())],
             "chi": [{k: v for k, v in r.items() if k != "colours"} for r in chi]}
    refusal = next((r for r in chi if r["k"] == 4 and r["outcome"] == "unsat"), None)
    if refusal is not None:
        print(f"  !!! {tag} REFUSES k=4 — the JACKPOT branch: nothing is claimed; the "
              f"registered escalation protocol (independent re-encode, cube split) fires now")
        entry["jackpot_candidate"] = True
    elif meters_targets and any(r["k"] == 4 and r["outcome"] == "sat" for r in chi):
        coverage, triples = run_meters(n, edges, st["pts"], meters_targets, 4, cap, base_cov)
        entry["coverage"], entry["triples"] = coverage, triples
        entry["compelled_triples"] = sum(1 for t in triples if t["outcome"] == "unsat")
    return entry


def probe_same(B, cap, out_path: Path):
    """M32 probe B: same-anchor stacks — thin by §0a case 1 (Q3)."""
    pts, mpiv, hexpiv = hexagram_points(B)
    d_full = make_detune(a=2, name="rho15")
    d_anti = make_detune(a=-2, name="rho15inv")
    d_half = make_detune(a=1, name="half15")
    d_twist = make_detune(s=Z12, a=2, name="z12·rho15")
    print(f"probe-same: hexagram B={B}, {len(pts)} base points")
    entries = []
    for aname, anchor in (("meta", mpiv), ("hexpiv3", hexpiv[3])):
        for sname, copies in (
                ("chirality", [(anchor, d_full), (anchor, d_anti)]),
                ("full+half", [(anchor, d_full), (anchor, d_half)]),
                ("full+twisted", [(anchor, d_full), (anchor, d_twist)])):
            entries.append(_stack_variant(f"same/{aname}/{sname}", pts, copies, cap))
    json.dump({"object": f"same-anchor-stacks-B{B}", "variants": entries},
              open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")
    return entries


def probe_wide(B, cap, out_path: Path, base_out: Path):
    """M32 probe C: different-anchor stacks — the wide channel (Q4) with all meters (Q5)."""
    pts, mpiv, hexpiv = hexagram_points(B)
    d_full = make_detune(a=2, name="rho15")
    d_half = make_detune(a=1, name="half15")
    targets = [("meta", mpiv)] + [(f"hexpiv{a}", hexpiv[a]) for a in range(6)]
    base_cov = {}
    if base_out.exists():
        for row in json.load(open(base_out)).get("coverage", []):
            base_cov[row["target"]] = row
    print(f"probe-wide: hexagram B={B}, {len(pts)} base points")
    entries = []
    for tag, copies in (
            ("wide-unit", [(hexpiv[3], d_full), (hexpiv[5], d_full)]),
            ("sterile-third", [(hexpiv[3], d_full), (mpiv, d_full)]),
            ("conjugate-opp", [(hexpiv[3], d_full), (hexpiv[0], d_full)]),
            ("half-unit", [(hexpiv[3], d_half), (hexpiv[5], d_half)])):
        entries.append(_stack_variant(f"wide/{tag}", pts, copies, cap,
                                      meters_targets=targets, base_cov=base_cov))
    json.dump({"object": f"different-anchor-stacks-B{B}", "variants": entries},
              open(out_path, "w"), indent=1)
    print(f"wrote {out_path}")
    return entries


# ------------------------------------------------------------------ CLI

def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    ap.add_argument("--probe-a", action="store_true")
    ap.add_argument("--probe-b", action="store_true")
    ap.add_argument("--gen1", action="store_true")
    ap.add_argument("--frontier", action="store_true")
    ap.add_argument("--probe-base", action="store_true", dest="probebase",
                    help="M32 probe A: bare-fabric compulsion floor (Q2)")
    ap.add_argument("--probe-same", action="store_true", dest="probesame",
                    help="M32 probe B: same-anchor stacks (Q3)")
    ap.add_argument("--probe-wide", action="store_true", dest="probewide",
                    help="M32 probe C: different-anchor stacks + meters (Q4, Q5)")
    ap.add_argument("--B", type=int, default=1)
    ap.add_argument("--cap", type=float, default=300.0, help="per-SAT-call timeout, seconds")
    args = ap.parse_args()
    Path("build").mkdir(exist_ok=True)
    if args.selftest:
        self_test()
    if args.probe_a:
        probe_a(args.B, args.cap, Path(f"build/m31-mitosis-B{args.B}.json"))
    if args.probe_b:
        probe_b(max(args.B, 2), args.cap, Path("build/m31-pair.json"))
    if args.gen1:
        gen1(Path("build/m31-closure-gen1.json"), args.cap)
    if args.frontier:
        frontier(Path("build/m31-closure-gen1.pts.json"), args.cap,
                 Path("build/m31-frontier.json"))
    if args.probebase:
        probe_base(args.B, args.cap, Path(f"build/m32-base-B{args.B}.json"))
    if args.probesame:
        probe_same(args.B, args.cap, Path(f"build/m32-same-B{args.B}.json"))
    if args.probewide:
        probe_wide(args.B, args.cap, Path(f"build/m32-wide-B{args.B}.json"),
                   Path(f"build/m32-base-B{args.B}.json"))


if __name__ == "__main__":
    main()
