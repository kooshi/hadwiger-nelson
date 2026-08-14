#!/usr/bin/env python3
"""M44 — the epsilon-dial campaign driver (plans/M44-epsilon-dial.md).

Three jobs, on two separate axes that must never share a plot:

  --defects    the SPINE. For every certified non-6-colourable core we hold, an upper bound on
               its unit-distance DEFECT (tools/embed.py), giving one point (defect_upper, |V|).
               The lower envelope of those points is the nu curve of the plan's section 0b.
  --minradius  PHASE 1, the comparability fix. The recorded cores came from balls whose radius
               the experimenter CHOSE; a physical size that looks scale-invariant across
               hand-chosen boxes is an artifact of taste. Bisect for the least radius that
               refutes six colours, per band, one procedure and one cap.
  --delta      the SEPARATE interval axis: the exact avoided-interval half-width per band, and
               the scale inside each band that maximizes it. Written to its own artifact.

Edges are re-derived from addresses two independent ways (the exact interval criterion and the
band's norm filter) and the two must agree, exactly as M43 did for its 160-core.
"""

import argparse
import json
import math
import os
import sys
import time
from fractions import Fraction as F

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import celllat as C
import embed as E

INTERVAL_ART = "build/m44-interval.json"

INTERVAL_SCHEMA = (
    "m44-interval v1 (plans/M44-epsilon-dial.md section F). Unit of claim: one BAND. `delta` is "
    "the half-width of the interval of distances around 1 that EVERY proper colouring of G(p) "
    "avoids. THIS IS NOT THE DEFECT AXIS: delta belongs to the conditional bridge to the "
    "interval literature (a lower bound on chi(G(p)) flows FROM an interval theorem TO this "
    "family, never back), while the defect/nu rows in build/m44-dial.json are about our own "
    "witnesses. A row here never licenses a statement about chi(G(p)), and the two files are "
    "separate precisely so they cannot be plotted on one axis by accident.")


# ---------------------------------------------------------------- cores on disk

def load_cores():
    """Every recorded k = 6 core, de-duplicated, newest file wins."""
    out = {}
    for fn in ("build/m40-chiomega.json", "build/m43-finetail.json"):
        if not os.path.exists(fn):
            continue
        for c in json.load(open(fn)).get("cores", []):
            if c.get("k") != 6 or not c.get("core"):
                continue
            out[str(F(c["T"]))] = c
    return [out[k] for k in sorted(out, key=lambda t: -float(F(t)))]


def core_edges(T, pts):
    """Edges of the core at scale 1/T, derived TWO ways; they must agree."""
    T = F(T)
    offs = set(C.edge_set40(T))
    norms = sorted({C.Q(d) for d in offs})
    idx = {tuple(p): i for i, p in enumerate(pts)}
    by_offset, by_norm = set(), set()
    for a in range(len(pts)):
        for b in range(a + 1, len(pts)):
            d = (pts[a][0] - pts[b][0], pts[a][1] - pts[b][1])
            if tuple(d) in offs:
                by_offset.add((a, b))
            if C.Q(d) in norms:
                by_norm.add((a, b))
    if by_offset != by_norm:
        # the norm filter is only sound when every offset of an edge norm is an edge; say so
        # rather than silently preferring one
        return sorted(by_offset), {"agree": False, "n_offset": len(by_offset),
                                   "n_norm": len(by_norm), "norms": norms}
    return sorted(by_offset), {"agree": True, "n_offset": len(by_offset), "norms": norms}


def phys(T, pts):
    """Physical diameter and radius of a core at scale p = 1/T, in unit distances."""
    p = 1.0 / float(F(T))
    d2 = max(C.Q((u[0] - v[0], u[1] - v[1])) for u in pts for v in pts)
    r2 = min(max(C.Q((u[0] - v[0], u[1] - v[1])) for v in pts) for u in pts)
    return p * math.sqrt(float(d2)), p * math.sqrt(float(r2))


# ---------------------------------------------------------------- the spine

def defects(restarts, workers):
    rows = []
    for c in load_cores():
        T = F(c["T"])
        pts = [tuple(v) for v in c["core"]]
        edges, agree = core_edges(T, pts)
        dia, rad = phys(T, pts)
        eta = 2.0 / math.sqrt(3.0) / float(T)          # the free a-priori bound (plan 0a)
        print(f"  {str(T):>10}  n={len(pts):4d}  m={len(edges):5d}  eta={eta:.4f} ...",
              flush=True)
        # the cell centres: the drawing D1 hands us for free, error at most eta
        pp = 1.0 / float(T)
        seed = [[pp * (a + b / 2.0), pp * (b * math.sqrt(3.0) / 2.0)] for (a, b) in pts]
        row = E.measure(f"cell-core T={T}", len(pts), edges, restarts, workers,
                        note=c.get("note", ""), seed_drawing=seed)
        row.update({"T": str(T), "p": 1.0 / float(T), "eta_free_bound": eta,
                    "phys_diameter": dia, "phys_radius": rad,
                    "edge_derivation": agree, "n_orbits": c.get("n_orbits"),
                    "ball_radius_as_recorded": c.get("radius")})
        E.record(row)
        rows.append(row)
        print(f"      defect_upper = {row['defect_upper_float']:.6f}   "
              f"(free bound {eta:.4f}, improvement x{eta / max(row['defect_upper_float'], 1e-12):.2f})",
              flush=True)
    return rows


# ---------------------------------------------------------------- the interval axis

def _gap_at(T, offs):
    T = F(T)
    T2 = T * T
    best = None
    for (mn, mx) in offs:
        if mn <= T2 <= mx:
            continue
        g = 1 - math.sqrt(float(mx)) / float(T) if T2 > mx else math.sqrt(float(mn)) / float(T) - 1
        if best is None or g < best:
            best = g
    return best


def delta_rows(t2max=F(50)):
    art = {"schema": INTERVAL_SCHEMA, "rows": []}
    if os.path.exists(INTERVAL_ART):
        art = json.load(open(INTERVAL_ART))
    art["schema"] = INTERVAL_SCHEMA
    rows = []
    for b in C.bands(T2max=t2max):
        lo, hi = F(b["t2_lo"]), F(b["t2_hi"])
        if hi < F(3):
            continue
        reach = int(1.16 * (math.sqrt(float(hi)) + 2)) + 3
        offs = []
        for a in range(-reach, reach + 1):
            for bb in range(-reach, reach + 1):
                mn, mx = C.interval((F(a), F(bb)))
                if mn <= float(hi) * 1.6 + 8:
                    offs.append((mn, mx))
        Tcan = C.canonical_T(b)
        gcan = _gap_at(Tcan, offs)
        a_, b_ = math.sqrt(float(lo)), math.sqrt(float(hi))
        for _ in range(80):
            m1, m2 = a_ + (b_ - a_) / 3, b_ - (b_ - a_) / 3
            g1 = _gap_at(F(m1).limit_denominator(10 ** 7), offs)
            g2 = _gap_at(F(m2).limit_denominator(10 ** 7), offs)
            if g1 is None or g2 is None:
                break
            if g1 < g2:
                a_ = m1
            else:
                b_ = m2
        Tbest = F((a_ + b_) / 2).limit_denominator(10 ** 6)
        # keep the optimum strictly inside the band; the ternary search can land on a boundary
        if not (lo < Tbest * Tbest < hi):
            Tbest, gbest = Tcan, gcan
        else:
            gbest = _gap_at(Tbest, offs)
        rows.append({"kind": "interval", "t2_lo": str(lo), "t2_hi": str(hi),
                     "T_canonical": str(Tcan), "delta_at_canonical": gcan,
                     "T_best": str(Tbest), "delta_best": gbest,
                     "improvement": (gbest / gcan) if (gcan and gcan > 0) else None,
                     "n_classes": len(b["classes"])})
    art["rows"] = rows
    os.makedirs("build", exist_ok=True)
    json.dump(art, open(INTERVAL_ART, "w"), indent=1, default=str)
    return rows


# ---------------------------------------------------------------- phase 1: the minimal ball

def _probe(args):
    T, k, R, cap = args
    row = C.ball43(F(T), k, R, cap=cap, pin=True, enc="direct")
    return R, row["outcome"], row["n_vertices"], row["seconds"]


def min_radius(Ts, k=6, rlo=2, rhi=12, cap=900.0, workers=28):
    """Least ball radius that refutes k colours, per band.

    A FULL PARALLEL SCAN rather than a bisection. Bisection is sound here (a bigger ball has
    every constraint the smaller one had, so refutation is monotone in R) but it is inherently
    sequential — five bands x four probes on ONE core, when the box has thirty-two. Scanning
    every (band, R) pair at once uses them all, and it reports the whole profile instead of only
    the crossing point, so a non-monotone surprise would be visible rather than assumed away.

    `unknown at cap` is NEVER read as either verdict. A band's minimum is reported as `minimal`
    only when every smaller radius returned a DECIDED sat; otherwise the value is labelled
    `upper-bound-only` and the count of undecided probes travels with it."""
    from concurrent.futures import ProcessPoolExecutor
    jobs = [(str(T), k, R, cap) for T in Ts for R in range(rlo, rhi + 1)]
    results = {}
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for job, res in zip(jobs, ex.map(_probe, jobs)):
            R, st, nv, sec = res
            results.setdefault(job[0], []).append({"R": R, "outcome": st, "n": nv,
                                                   "seconds": sec})
            print(f"    T={job[0]} R={R} -> {st} ({nv} vtx, {sec}s)", flush=True)
    out = []
    for T in Ts:
        probes = sorted(results[str(T)], key=lambda p: p["R"])
        unsats = [p for p in probes if p["outcome"] == "unsat"]
        unknown = [p for p in probes if p["outcome"] not in ("sat", "unsat")]
        if not unsats:
            out.append({"kind": "min-radius", "T": str(T), "k": k, "outcome": "no-refutation",
                        "n_unknown": len(unknown), "probes": probes, "cap": cap})
            continue
        best = min(p["R"] for p in unsats)
        decided_below = all(any(p["R"] == R and p["outcome"] == "sat" for p in probes)
                            for R in range(rlo, best))
        out.append({"kind": "min-radius", "T": str(T), "k": k,
                    "outcome": "minimal" if decided_below else "upper-bound-only",
                    "R_star": best,
                    "n_at_R_star": next(p["n"] for p in unsats if p["R"] == best),
                    "phys_radius_at_R_star": best / float(F(T)),
                    "n_unknown": len(unknown), "probes": probes, "cap": cap})
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--defects", action="store_true")
    ap.add_argument("--delta", action="store_true")
    ap.add_argument("--minradius", action="store_true")
    ap.add_argument("--cap", type=float, default=900.0)
    ap.add_argument("--restarts", type=int, default=96)
    ap.add_argument("--workers", type=int, default=30)
    a = ap.parse_args()
    if a.defects:
        t0 = time.time()
        rows = defects(a.restarts, a.workers)
        print(f"\n==> {len(rows)} cores, {time.time() - t0:.0f}s")
        print(f"{'T':>10} {'p':>7} {'N':>5} {'defect_upper':>13} {'eta (free)':>11} {'phys diam':>10}")
        for r in rows:
            print(f"{r['T']:>10} {r['p']:7.4f} {r['n']:5d} {r['defect_upper_float']:13.6f} "
                  f"{r['eta_free_bound']:11.4f} {r['phys_diameter']:10.3f}")
    if a.minradius:
        Ts = [F(c["T"]) for c in load_cores()]
        rows = min_radius(Ts, cap=a.cap, workers=a.workers)
        E_art = "build/m44-dial.json"
        art = json.load(open(E_art)) if os.path.exists(E_art) else {"schema": E.SCHEMA, "rows": []}
        art["rows"] = [r for r in art["rows"] if r.get("kind") != "min-radius"] + rows
        json.dump(art, open(E_art, "w"), indent=1, default=str)
        for r in rows:
            print(r["T"], r["outcome"], r.get("R_star"), r.get("n_at_R_star"),
                  r.get("phys_radius_at_R_star"))
    if a.delta:
        rows = delta_rows()
        print(f"{'band T^2':>22} {'T_canon':>12} {'d_canon':>9} {'T_best':>12} {'d_best':>9} {'x':>6}")
        for r in rows:
            imp = r["improvement"]
            print(f"({r['t2_lo']:>9},{r['t2_hi']:>9}) {r['T_canonical']:>12} "
                  f"{r['delta_at_canonical']:9.5f} {r['T_best']:>12} {r['delta_best']:9.5f} "
                  f"{(f'{imp:.1f}' if imp else '-'):>6}")


if __name__ == "__main__":
    main()
