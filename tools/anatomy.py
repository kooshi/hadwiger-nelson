#!/usr/bin/env python3
"""The de Grey anatomy: addresses, directions, and chord classes of the 5-chromatic witnesses.

UNTRUSTED, like everything in `tools/`. Every claim that matters later is re-derived in Lean at
M32; a bug here can cost a theorem and never buy one.

## What it computes (M30 §1, items 2–3)

* **Addresses.** The 1581 is derived data: `spindle(delete₂(spindle(orbit(S, hex₁₂), (0,0),
  (2,0))), (−2,0), (2,0))` from 39 seeds (M13, `construct.py`, regen-checked). This tool applies
  every candidate word (e₂, e₁, h, s) ∈ {1, ρ₆₃@(−2,0)} × {1, ρ₁₅@(0,0)} × hex₁₂ × S exactly and
  looks the result up in the table — the address map is a relation recovered post hoc, never
  threaded state. A vertex no word reaches aborts the run by name (the four-move model would be
  wrong). The multiplicity histogram is the fusion record.
* **Directions.** A unit edge difference is a rotation; the inventory is taken up to sign and up
  to the one unknown global frame by RATIOS against a reference edge (registered R1). Distinct
  count is R2's verdict.
* **Exponent factorization.** Rotations about one centre commute, so ⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩ is
  abelian and factorization is exponent-solving: the box {ζ₆^a σ^b ρ₁₅^c ρ₆₃^d, |b|,|c|,|d| ≤ B}
  is enumerated exactly and matched against the inventory (E1's verdict; R3's histogram). A miss
  is reported as "unreached at the box", never as absence.
* **Classes.** Coarse (REGISTERED R5): (copy-pair tag, unordered exact r²-about-centre pair),
  fused vertices contributing their lexicographically-least tag. E3's verdict is the top-6 share.
  Fine: (tag pair, seed pair, direction) — a derived projection carried per edge for the reading.
* **The load-bearing probe (R7).** Delete one coarse class' edges; SAT the rest at k = 4. A class
  whose deletion yields a colouring is load-bearing for the 5th colour.

Frames: group data is computed in the construction frame (generators are rotations about its
origin); the emitted JSON carries the committed (kernel-certified) frame's coordinates and
indices, with the exact frame rotation and the centre's image recorded in the output — never
assumed. Heule 510/553 have no construction provenance: they get the direction/membership runs
only, which makes them independent cross-checks of E1.

    python3 tools/anatomy.py --self-test
    python3 tools/anatomy.py                 # full pipeline → build/m30-anatomy.json
    python3 tools/anatomy.py --probe         # + the R7 per-class deletion SAT probes
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import degrey as D  # noqa: E402  (S, field ops, rot helpers — the one copy of each)
from coloring import base_clauses, var  # noqa: E402
from forcer import _solve  # noqa: E402

TOOLS = Path(__file__).resolve().parent
ORIGIN = (D.rat(0), D.rat(0))
CENTRE2 = (D.rat(-2), D.rat(0))          # the second spindle's pivot


# ------------------------------------------------------------------ complex ops over point pairs

def cmul(p, q):
    (a, b), (c, d) = p, q
    return (D.sub(D.mul(a, c), D.mul(b, d)), D.add(D.mul(a, d), D.mul(b, c)))


def cconj(p):
    return (p[0], D.neg(p[1]))


def cneg(p):
    return (D.neg(p[0]), D.neg(p[1]))


def key(p) -> tuple:
    return (tuple(p[0]), tuple(p[1]))


def canon_sign(p):
    """The exact-lex-larger of ±p — a pure function, no numerics."""
    q = cneg(p)
    return p if key(p) >= key(q) else q


def approx(p) -> tuple[float, float]:
    return (D.num(p[0]), D.num(p[1]))


# ------------------------------------------------------------------ the generators, exactly

ZETA6 = (D.rat(F(1, 2)), D.smul(F(1, 2), D.R3))
SIGMA = (D.smul(F(1, 6), D.R3), D.smul(F(1, 6), D.R33))
RHO15 = (D.rat(F(7, 8)), D.smul(F(1, 8), D.R15))
RHO63 = (D.rat(F(31, 32)), D.smul(F(3, 32), D.R7))       # √63 = 3√7
GEN_NAMES = ["zeta6", "sigma", "rho15", "rho63"]

# The half-spindle generators (found by the E1 run, 2026-08-09): every 1581 direction that missed
# the registered four-generator group SQUARES into it, and the squares are exactly the σ-exponent
# ±2 words — so the direction group is the half-word extension below. ζ₁₂² = ζ₆, and the half
# spindles are the half-angle rotations of the two spindle moves (de Grey's own paper works at
# the half-angles: his π/2 ± arcsin(1/8) frame). √ρ₁₅ = (√15+i)/4, √ρ₆₃ = (3√7+i)/8.
ZETA12 = (D.smul(F(1, 2), D.R3), D.rat(F(1, 2)))
HALF15 = (D.smul(F(1, 4), D.R15), D.rat(F(1, 4)))
HALF63 = (D.smul(F(3, 8), D.R7), D.rat(F(1, 8)))

# the spindle rotations as (cos, sin) field elements for rot_about
ROT15 = (D.rat(F(7, 8)), D.smul(F(1, 8), D.R15))
ROT63 = (D.rat(F(31, 32)), D.smul(F(3, 32), D.R7))
# the global frame rotation: committed = R(construction), about (−2, 0)
FRAME = (D.rat(F(1, 8)), D.smul(F(3, 8), D.R7))


def check_unit(p, what: str) -> None:
    if D.normsq(p) != D.ONE:
        raise SystemExit(f"NOT UNIT: {what} has |·|² ≠ 1 — refusing to classify a non-unit chord")


# ------------------------------------------------------------------ words and addresses

def hex_apply(j: int, refl: bool, p):
    """The hex₁₂ element: reflect in the x-axis (maybe), then rotate by ζ₆^j."""
    q = cconj(p) if refl else p
    for _ in range(j):
        q = cmul(ZETA6, q)
    return q


def word_point(e2: int, e1: int, j: int, refl: bool, s: int):
    """Apply the construction word to seed `s`; `None` if the pre-spindle₂ point was deleted."""
    p = hex_apply(j, refl, D.S[s])
    if e1:
        p = D.rot_about(p, ORIGIN, *ROT15)
    if key(p) in DELETED:
        return None
    if e2:
        p = D.rot_about(p, CENTRE2, *ROT63)
    return p


DELETED = {key((D.rat(F(1, 3)), D.rat(0))), key((D.rat(F(-1, 3)), D.rat(0)))}
TAG_NAMES = {(0, 0): "base", (0, 1): "spindle15", (1, 0): "spindle63", (1, 1): "both"}


def build_addresses():
    """(construction table, address map, fusion histogram) — and the totality assertion."""
    table: dict[tuple, int] = {}
    pts = []
    addr: list[list[tuple]] = []
    for e2 in (0, 1):
        for e1 in (0, 1):
            for refl in (False, True):
                for j in range(6):
                    for s in range(len(D.S)):
                        p = word_point(e2, e1, j, refl, s)
                        if p is None:
                            continue
                        k = key(p)
                        if k not in table:
                            table[k] = len(pts)
                            pts.append(p)
                            addr.append([])
                        addr[table[k]].append((e2, e1, j, refl, s))
    if len(pts) != 1581:
        raise SystemExit(f"ADDRESS MODEL WRONG: words produce {len(pts)} distinct points, not 1581")
    gaps = [i for i, a in enumerate(addr) if not a]
    if gaps:
        p = approx(pts[gaps[0]])
        raise SystemExit(f"ADDRESS GAP: vertex {gaps[0]} at ({p[0]:.4f}, {p[1]:.4f}) matches no "
                         f"construction word — the four-move model does not cover this point; "
                         f"halting. If the committed table changed, re-run construct.py regen-check.")
    return pts, table, addr


def committed_bijection(pts):
    """construction index → committed index, through the exact global frame rotation."""
    cert = json.load(open(TOOLS / "degrey_cert.json"))
    den = cert["denom"]
    cidx = {}
    for i, (xv, yv) in enumerate(cert["coords"]):
        p = (tuple(F(v, den) for v in xv), tuple(F(v, den) for v in yv))
        cidx[p] = i
    bij = []
    for p in pts:
        q = D.rot_about(p, CENTRE2, *FRAME)
        k = key(q)
        if k not in cidx:
            a = approx(p)
            raise SystemExit(f"FRAME MISMATCH: construction point ({a[0]:.4f}, {a[1]:.4f}) has no "
                             f"committed partner under the recorded global rotation — halting.")
        bij.append(cidx[k])
    if len(set(bij)) != len(bij):
        raise SystemExit("FRAME MISMATCH: the construction→committed map is not injective")
    return bij, cert


# ------------------------------------------------------------------ the exponent box

def powers(g, B: int):
    """g^b for b in −B..B, exactly."""
    out = {0: (D.ONE, D.ZERO)}
    gi = cconj(g)                      # unit rotation: inverse = conjugate
    p = (D.ONE, D.ZERO)
    q = (D.ONE, D.ZERO)
    for b in range(1, B + 1):
        p = cmul(p, g)
        q = cmul(q, gi)
        out[b] = p
        out[-b] = q
    return out


def _box(zeta, zorder: int, g1, g2, g3, B: int) -> dict[tuple, tuple]:
    """key(ζ^a g₁^b g₂^c g₃^d) → (a,b,c,d), least |b|+|c|+|d| first (the enumeration order)."""
    z = powers(zeta, zorder - 1)
    p1, p2, p3 = powers(g1, B), powers(g2, B), powers(g3, B)
    box: dict[tuple, tuple] = {}
    order = sorted(range(-B, B + 1), key=abs)
    for b in order:
        sb = p1[b]
        for c in order:
            sc = cmul(sb, p2[c])
            for d in order:
                sd = cmul(sc, p3[d])
                for a in range(zorder):
                    el = cmul(z[a], sd) if a else sd
                    box.setdefault(key(el), (a, b, c, d))
    return box


def exponent_box(B: int) -> dict[tuple, tuple]:
    """The REGISTERED four-generator group ⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩ (E1/R3)."""
    return _box(ZETA6, 6, SIGMA, RHO15, RHO63, B)


def half_box(B: int) -> dict[tuple, tuple]:
    """The refined half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ — a ∈ ℤ/12."""
    return _box(ZETA12, 12, SIGMA, HALF15, HALF63, B)


def box_lookup(box: dict, r, zorder: int):
    """The exponents of r in the box, absorbing sign through the half-order ζ-shift."""
    g = box.get(key(r))
    if g is None:
        g = box.get(key(cneg(r)))
        if g is not None:
            g = ((g[0] + zorder // 2) % zorder, g[1], g[2], g[3])
    return g


# ------------------------------------------------------------------ the anatomy pipeline

def directions_of(coords, edges, label: str):
    """Per-edge direction data in one pass: the exact difference, its ratio to edge 0's direction,
    and the sign-canonical id. Also the unit sanity check (the shuffled-coordinate control)."""
    diffs = []
    for (i, j) in edges:
        d = D.psub(coords[i], coords[j])
        check_unit(d, f"{label} edge ({i},{j})")
        diffs.append(d)
    ref = cconj(diffs[0])
    ratios = [cmul(d, ref) for d in diffs]
    ids: dict[tuple, int] = {}
    dir_id = []
    for r in ratios:
        k = key(canon_sign(r))
        if k not in ids:
            ids[k] = len(ids)
        dir_id.append(ids[k])
    return diffs, ratios, ids, dir_id


def run_witness_membership(name: str, box4, boxH):
    """Direction inventory + membership in both groups, for a witness with no construction
    provenance. The out-of-group residue is reported per direction, with edge counts and angles —
    a residue is a finding, not a rounding error."""
    import math
    w = json.load(open(TOOLS / name))
    den = w["denom"]
    coords = [(tuple(F(v, den) for v in xv), tuple(F(v, den) for v in yv))
              for xv, yv in w["coords"]]
    edges = [tuple(e) for e in w["edges"]]
    _, ratios, ids, dir_id = directions_of(coords, edges, name)
    rep: dict[int, tuple] = {}
    cnt: dict[int, int] = {}
    for e_i, r in enumerate(ratios):
        rep.setdefault(dir_id[e_i], r)
        cnt[dir_id[e_i]] = cnt.get(dir_id[e_i], 0) + 1
    miss4 = [i for i, r in rep.items() if box_lookup(box4, r, 6) is None]
    missH = [i for i, r in rep.items() if box_lookup(boxH, r, 12) is None]
    residue = []
    for i in missH:
        x, y = approx(rep[i])
        residue.append({"dir": i, "edges": cnt[i],
                        "angle_deg": round(math.degrees(math.atan2(y, x)), 3)})
    return {"witness": name, "n": len(coords), "edges": len(edges),
            "distinct_directions": len(ids),
            "unreached_registered_group": len(miss4),
            "unreached_half_spindle_group": len(missH),
            "residue_edges": sum(r["edges"] for r in residue),
            "residue": residue}


def main_run(B: int, probe: bool, out_path: Path) -> dict:
    t0 = time.time()
    print("· addressing the 1581 from construction words …")
    pts, _table, addr = build_addresses()
    bij, cert = committed_bijection(pts)
    inv = [0] * 1581                       # committed index → construction index
    for ci, mi in enumerate(bij):
        inv[mi] = ci
    mult = {}
    for a in addr:
        mult[len(a)] = mult.get(len(a), 0) + 1
    print(f"  1581 vertices addressed; fusion histogram (words per vertex): "
          f"{dict(sorted(mult.items()))}")

    edges = [tuple(e) for e in cert["edges"]]
    con_coords = [pts[inv[i]] for i in range(1581)]        # construction frame, committed order

    print("· direction inventory …")
    _diffs, ratios, ids, dir_id = directions_of(con_coords, edges, "degrey1581")
    print(f"  {len(ids)} distinct directions up to sign and frame (R2 registered ≤ 200)")

    print(f"· registered four-generator box |b|,|c|,|d| ≤ {B} …")
    box4 = exponent_box(B)
    print(f"  {len(box4)} exact group elements")
    expo4, unreached4 = [], set()
    for e_i, r in enumerate(ratios):
        got = box_lookup(box4, r, 6)
        if got is None:
            unreached4.add(dir_id[e_i])
        expo4.append(got)
    hist4: dict[int, int] = {}
    for g in expo4:
        if g:
            k4 = abs(g[1]) + abs(g[2]) + abs(g[3])
            hist4[k4] = hist4.get(k4, 0) + 1
    print(f"  whole-word histogram |b|+|c|+|d|: {dict(sorted(hist4.items()))}; "
          f"unreached directions: {len(unreached4)}")
    if unreached4:
        print(f"  UNREACHED at |b|+|c|+|d| ≤ {B}: E1 refuted at this box OR the box is small — "
              f"raise --box to distinguish. Testing the half-spindle refinement …")

    print("· refined half-spindle box ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ …")
    boxH = half_box(max(6, B - 2))
    expo, unreachedH = [], set()
    for e_i, r in enumerate(ratios):
        got = box_lookup(boxH, r, 12)
        if got is None:
            unreachedH.add(dir_id[e_i])
        expo.append(got)
    histH: dict[int, int] = {}
    for g in expo:
        if g:
            kH = abs(g[1]) + abs(g[2]) + abs(g[3])
            histH[kH] = histH.get(kH, 0) + 1
    print(f"  half-word histogram |b|+|c|+|d|: {dict(sorted(histH.items()))}; "
          f"unreached: {len(unreachedH)}")

    print("· classes …")
    tags = [min(TAG_NAMES[(w[0], w[1])] for w in addr[inv[i]]) for i in range(1581)]
    tag_of = [sorted({(w[0], w[1]) for w in addr[inv[i]]}) for i in range(1581)]
    r2key = {}
    r2_of = []
    for i in range(1581):
        k = tuple(D.normsq(con_coords[i]))
        if k not in r2key:
            r2key[k] = len(r2key)
        r2_of.append(r2key[k])
    print(f"  {len(r2key)} distinct circles about the construction centre")
    coarse: dict[tuple, list[int]] = {}
    fine: dict[tuple, int] = {}
    edge_coarse, edge_fine = [], []
    for e_i, (i, j) in enumerate(edges):
        ck = (tuple(sorted((min(TAG_NAMES[t] for t in tag_of[i]),
                            min(TAG_NAMES[t] for t in tag_of[j])))),
              tuple(sorted((r2_of[i], r2_of[j]))))
        coarse.setdefault(ck, []).append(e_i)
        fk = (ck[0], min(min(w[4] for w in addr[inv[i]]), min(w[4] for w in addr[inv[j]])),
              dir_id[e_i])
        fine.setdefault(fk, 0)
        fine[fk] += 1
        edge_coarse.append(ck)
        edge_fine.append(fk)
    ranked = sorted(coarse.items(), key=lambda kv: -len(kv[1]))
    top6 = sum(len(v) for _, v in ranked[:6])
    share = top6 / len(edges)
    print(f"  {len(coarse)} coarse classes; top-6 carry {top6}/{len(edges)} = {share:.1%} "
          f"(E3 registered ≥ 70%); {len(fine)} fine classes")

    print("· E2: the seam algebra one field up …")
    e2facts = []
    for nm, root, want in (("(1+i*sqrt15)/2", D.R15, 4), ("(1+i*sqrt63)/2",
                                                          D.mul(D.rat(3), D.R7), 16)):
        mu = (D.rat(F(1, 2)), D.smul(F(1, 2), root))
        lhs = D.psub(cmul(mu, mu), D.psub(mu, (D.rat(want), D.rat(0))))
        ok = lhs == (D.ZERO, D.ZERO) and cmul(mu, cconj(mu)) == (D.rat(want), D.ZERO)
        e2facts.append({"integer": nm, "minpoly": f"x^2 - x + {want}", "norm": want, "checked": ok})
        print(f"  {nm}: x² = x − {want}, norm {want} — {'checked exactly' if ok else 'FAILED'}")
        if not ok:
            raise SystemExit("E2 identity failed in exact arithmetic — the field code is wrong")

    print("· Heule witnesses (membership only — no construction provenance) …")
    heule = [run_witness_membership("heule510.json", box4, boxH),
             run_witness_membership("heule553.json", box4, boxH)]
    for h in heule:
        print(f"  {h['witness']}: {h['distinct_directions']} directions; unreached "
              f"{h['unreached_registered_group']} (registered group), "
              f"{h['unreached_half_spindle_group']} (half-spindle group, "
              f"{h['residue_edges']} edges of {h['edges']})")

    probes = None
    if probe:
        print("· R7 load-bearing probes, REGISTERED currency (top-6 coarse classes) …")
        probes = {"registered_coarse": [], "post_hoc_direction": []}
        for ck, eids in ranked[:6]:
            keep = [e for e_i, e in enumerate(edges) if e_i not in set(eids)]
            t1 = time.time()
            st, _ = _solve(base_clauses(1581, keep, 4), 4 * 1581, 3600)
            probes["registered_coarse"].append(
                {"class": [list(ck[0]), list(ck[1])], "edges_removed": len(eids),
                 "sat_at_4": st, "seconds": round(time.time() - t1, 1)})
            print(f"  minus {ck} ({len(eids)} edges): {st} "
                  f"({probes['registered_coarse'][-1]['seconds']}s)"
                  + ("  ← LOAD-BEARING" if st == "sat" else ""))
        print("· load-bearing probes, POST-HOC direction currency (unregistered — exploration "
              "for M31 to re-register; top-6 direction classes) …")
        from collections import Counter
        dcnt = Counter(dir_id)
        for d, cnt_d in dcnt.most_common(6):
            keep = [e for e_i, e in enumerate(edges) if dir_id[e_i] != d]
            t1 = time.time()
            st, _ = _solve(base_clauses(1581, keep, 4), 4 * 1581, 3600)
            probes["post_hoc_direction"].append(
                {"dir": d, "exp_half": expo[dir_id.index(d)], "edges_removed": cnt_d,
                 "sat_at_4": st, "seconds": round(time.time() - t1, 1)})
            print(f"  minus direction {d} ({cnt_d} edges): {st} "
                  f"({probes['post_hoc_direction'][-1]['seconds']}s)"
                  + ("  ← LOAD-BEARING" if st == "sat" else ""))

    centre_img = D.rot_about(ORIGIN, CENTRE2, *FRAME)
    out = {
        "schema": "m30-anatomy v1 — coords/indices are the committed (kernel-certified) frame; "
                  "group data computed in the construction frame; committed = R(construction)",
        "frame": {"R": {"about": [-2, 0], "cos": "1/8", "sin": "3*sqrt7/8"},
                  "centre": {"approx": approx(centre_img),
                             "note": "image of the construction centre — R5 radii are about this"}},
        "box_bound": B,
        "verdicts": {
            "R2_distinct_directions": {"value": len(ids), "registered": "<= 200",
                                       "verdict": "confirmed" if len(ids) <= 200 else "refuted"},
            "E1_R3_registered": {
                "group": "zeta6, sigma, rho15, rho63 (whole words, as registered)",
                "unreached_directions": len(unreached4),
                "word_length_histogram": {str(k): v for k, v in sorted(hist4.items())},
                "verdict": ("confirmed" if not unreached4 else
                            f"refuted as registered: {len(unreached4)} of {len(ids)} directions "
                            f"are not whole words at |b|+|c|+|d| <= {B}")},
            "E1_refined_half_spindle": {
                "group": "zeta12, sigma, sqrt(rho15) = (sqrt15+i)/4, sqrt(rho63) = (3*sqrt7+i)/8",
                "unreached_directions": len(unreachedH),
                "word_length_histogram": {str(k): v for k, v in sorted(histH.items())},
                "note": "every direction that misses the registered group SQUARES into it; the "
                        "half-spindle group closes the 1581 completely",
                "verdict": ("confirmed: the half-spindle group closes all directions"
                            if not unreachedH else
                            f"{len(unreachedH)} directions outside even the half-spindle group")},
            "E3": {"top6_share": round(share, 4), "registered": ">= 0.70",
                   "coarse_class_count": len(coarse),
                   "circles_about_centre": len(r2key),
                   "verdict": "confirmed" if share >= 0.70 else
                              "refuted at the registered currency: the second spindle's copies "
                              "scatter the one-centre radius spectrum"},
            "E2": e2facts,
        },
        "fusions": {"words_per_vertex_histogram": {str(k): v for k, v in sorted(mult.items())}},
        "circles": {"count": len(r2key)},
        "vertices": [{"i": i, "xy": [round(c, 6) for c in approx(
                          D.rot_about(con_coords[i], CENTRE2, *FRAME))],
                      "tags": [TAG_NAMES[t] for t in tag_of[i]],
                      "r2": r2_of[i], "words": len(addr[inv[i]])} for i in range(1581)],
        "edges": [{"i": e[0], "j": e[1], "dir": dir_id[e_i],
                   "coarse": list(edge_coarse[e_i][0]) + list(edge_coarse[e_i][1]),
                   "exp": list(expo[e_i]) if expo[e_i] else None}
                  for e_i, e in enumerate(edges)],
        "coarse_classes": [{"tags": list(ck[0]), "r2pair": list(ck[1]), "count": len(v),
                            "share": round(len(v) / len(edges), 4)} for ck, v in ranked],
        "heule": heule,
        "probes": probes,
        "seconds": round(time.time() - t0, 1),
    }
    out_path.parent.mkdir(parents=True, exist_ok=True)
    json.dump(out, open(out_path, "w"))
    print(f"wrote {out_path} ({out['seconds']}s total)")
    return out


# ------------------------------------------------------------------ the controls

def self_test() -> None:
    failures = []

    def expect(cond: bool, what: str):
        print(f"  {'ok  ' if cond else 'FAIL'} {what}")
        if not cond:
            failures.append(what)

    # generators are unit rotations, exactly
    for g, nm in zip((ZETA6, SIGMA, RHO15, RHO63, FRAME), GEN_NAMES + ["frame"]):
        expect(D.normsq(g) == D.ONE, f"{nm} is exactly unit")

    # the known relation: the Moser twist rho = zeta6^3 * sigma^-2 (the field-wall identity)
    rho = (D.rat(F(5, 6)), D.smul(F(1, 6), D.R11))
    z3 = cmul(ZETA6, cmul(ZETA6, ZETA6))
    si = cconj(SIGMA)
    expect(cmul(z3, cmul(si, si)) == rho, "rho = zeta6^3 * sigma^-2, exactly")

    # a small box round-trips its own elements and misses a planted outsider
    box = exponent_box(2)
    probe = cmul(ZETA6, cmul(SIGMA, cconj(RHO15)))
    expect(box.get(key(probe)) == (1, 1, -1, 0), "box finds zeta6*sigma/rho15 at (1,1,-1,0)")
    planted = (D.rat(F(3, 5)), D.rat(F(4, 5)))     # a rational rotation outside the group
    expect(key(planted) not in box and key(cneg(planted)) not in box,
           "planted cos-3/5 rotation is UNREACHED (the miss path fires)")

    # the shuffled-coordinate control: a non-unit "edge" must abort by name
    try:
        check_unit(D.psub((D.rat(0), D.rat(0)), (D.rat(2), D.rat(0))), "planted")
        expect(False, "non-unit chord refused")
    except SystemExit:
        expect(True, "non-unit chord refused (abort names the edge)")

    # the address-gap control: withholding the second-spindle words must abort loudly
    global DELETED
    real_word_point = word_point

    def crippled(e2, e1, j, refl, s):
        return None if e2 else real_word_point(e2, e1, j, refl, s)
    globals()["word_point"] = crippled
    try:
        build_addresses()
        expect(False, "crippled word set aborts")
    except SystemExit as e:
        expect("ADDRESS" in str(e), "crippled word set aborts naming the address model")
    finally:
        globals()["word_point"] = real_word_point

    print("SELF-TEST:", "ok" if not failures else f"{len(failures)} FAILURES: {failures}")
    if failures:
        sys.exit(1)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--box", type=int, default=8, help="exponent bound |b|,|c|,|d| (R3+2 default)")
    ap.add_argument("--probe", action="store_true", help="run the R7 per-class deletion SAT probes")
    ap.add_argument("--out", type=Path, default=Path("build/m30-anatomy.json"))
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    args = ap.parse_args()
    if args.selftest:
        self_test()
        return
    main_run(args.box, args.probe, args.out)


if __name__ == "__main__":
    main()
