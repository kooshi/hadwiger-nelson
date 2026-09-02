#!/usr/bin/env python3
"""copy_anatomy — the exact atlas of a descent object (plain or composed), M52 phase 1.

    python3 tools/copy_anatomy.py --object <label> [--centres 206,0,205] [--dps 50] [--md]
    python3 tools/copy_anatomy.py --self-test

Everything is computed on the object's EXACT points (`Obj.mp_values(dps)`, the provenance
recursion at `dps` digits); the float unit census is VERIFIED edge by edge and checked for
misses at a wider tolerance, so the edge set reported here is the exact one. Sections, each a
number and never a reading:

* **directions** — every unit edge's direction decomposed on the half-twist ladder
  θ ≡ 30·a + m·h + j·θ₁₅ (mod 360) with h = arctan(1/√11) = arccos(5/6)/2 (the half Moser twist:
  the seed's two crystal families are m = ±1 and its axis family m = 0) and θ₁₅ = atan2(√15, 7)
  the ρ₁₅ angle; the (m, j) histogram, and every OFF-ladder edge listed with its endpoint kinds
  (T13/P1: on the it-4 halo all six classes were on the ladder — this is the replication).
* **rings** — squared distances of every live point from each named centre, clustered at
  10⁻³⁰, the top spikes with counts and, where PSLQ finds one, the exact value in ℚ(√33) or in the
  seed basis {1, √3, √11, √33} (Q7's shell vocabulary).
* **cross chords** (composed objects) — each original–copy or copy–copy unit edge with: whether it
  is a SELF-chord (a point and its own image — P3: exactly the radius-2 shell), the two radii from
  the centre, collinearity with the centre at 10⁻³⁰ (P2's quadrature pin), and whether each
  endpoint's coordinates lie in the seed field ℚ(√3, √11) (PSLQ on both coordinates).
* **symmetry** — plane isometries mapping the live point set to itself: rotations about each
  centre by multiples of 60°, ±θ₁₅, ±2h, and reflections through the centre at ladder angles;
  a float hit is confirmed at `dps` digits.

Outputs `data/m52/atlas/<label>.json` and, with `--md`, the eight-line human card
`data/m52/atlas/<label>.md` (numbers only; readings live in the report). UNTRUSTED like all of
tools/; the planted self-test rotates the bare seed and must find the ladder, the self-chord shell
and the fused centre exactly."""
from __future__ import annotations
import argparse, collections, json, math, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from scipy.spatial import cKDTree
import mpmath as mp
import batchkill as B

ATLAS = Path(__file__).resolve().parent.parent / "data" / "m52" / "atlas"


def exact_census(obj, ex, tol_wide=1e-6):
    """The float unit census verified at mp precision, plus a wide-tolerance sweep for misses.
    Returns (edges_exact, verified, rejected, recovered)."""
    ue = obj.unit_edges()
    eps = mp.mpf(10) ** (-(mp.mp.dps - 10))
    def is_unit(u, v):
        D = ex[u] - ex[v]
        return abs(mp.sqrt((D * mp.conj(D)).real) - 1) < eps
    good = [e for e in ue if is_unit(*e)]
    rejected = len(ue) - len(good)
    wide = B.unit_pairs_np(obj.pts, tol=tol_wide)
    have = set(map(tuple, ue))
    live = set(range(obj.n)) - set(obj.deleted)
    recovered = [e for e in wide if tuple(e) not in have and e[0] in live and e[1] in live and is_unit(*e)]
    return sorted(set(map(tuple, good)) | set(map(tuple, recovered))), len(good), rejected, len(recovered)


def ladder_decompose(theta, h, th15, eps, mmax=8, jmax=3):
    """(m, j) with θ ≡ 30a + m·h + j·θ₁₅ (mod 360) at tolerance eps, least |m|+|j|; else None."""
    best = None
    for j in range(-jmax, jmax + 1):
        for m in range(-mmax, mmax + 1):
            r = (theta - m * h - j * th15) / 30
            k = mp.nint(r)
            if abs(r - k) * 30 < eps and (best is None or abs(m) + abs(j) < abs(best[0]) + abs(best[1])):
                best = (m, j, int(k) % 12)
    return best


def identify(x, dps):
    """x as (p + q√33)/m or in the seed basis, by PSLQ; None if no small relation."""
    if abs(x) < mp.mpf(10) ** (-(dps - 10)):
        return "0"
    for basis, names in (([1, mp.sqrt(33)], ["1", "√33"]),
                         ([1, mp.sqrt(3), mp.sqrt(11), mp.sqrt(33)], ["1", "√3", "√11", "√33"])):
        rel = mp.pslq([x] + basis, maxcoeff=10 ** 6, maxsteps=2000)
        if rel and rel[0] != 0:
            m_ = -rel[0]
            terms = [f"{c}{n if n != '1' else ''}" for c, n in zip(rel[1:], names) if c]
            s = " + ".join(terms).replace("+ -", "− ")
            return f"({s})/{m_}" if m_ != 1 else s
    return None


def in_seed_field(z, dps):
    for coord in (z.real, z.imag):
        if abs(coord) < mp.mpf(10) ** (-(dps - 10)):
            continue                                   # an exact zero is in every field
        rel = mp.pslq([coord, 1, mp.sqrt(3), mp.sqrt(11), mp.sqrt(33)], maxcoeff=10 ** 8, maxsteps=4000)
        if not rel or rel[0] == 0:
            return False
    return True


def symmetry_search(obj, ex, centres, h, th15, dps):
    live = [i for i in range(obj.n) if i not in obj.deleted]
    P = np.array([obj.pts[i] for i in live]); tree = cKDTree(P)
    found = []
    angles = {"60k": [math.radians(60 * k) for k in range(1, 6)],
              "±θ15": [float(th15) * math.pi / 180, -float(th15) * math.pi / 180],
              "±2h": [2 * float(h) * math.pi / 180, -2 * float(h) * math.pi / 180]}
    for c in centres:
        C = np.array(obj.pts[c])
        for name, lst in angles.items():
            for a in lst:
                R = np.array([[math.cos(a), -math.sin(a)], [math.sin(a), math.cos(a)]])
                Q = C + (P - C) @ R.T
                d, _ = tree.query(Q, k=1)
                if d.max() < 1e-7:
                    found.append(dict(kind="rotation", centre=c, family=name, angle_deg=round(math.degrees(a), 4)))
        for m in range(-3, 4):
            for a0 in range(0, 180, 30):
                a = math.radians(a0 + m * float(h))
                u = np.array([math.cos(a), math.sin(a)])
                rel = P - C; along = rel @ u
                Q = C + np.outer(along, u) - (rel - np.outer(along, u))
                d, _ = tree.query(Q, k=1)
                if d.max() < 1e-7:
                    found.append(dict(kind="reflection", centre=c, axis_deg=round(math.degrees(a), 4), m=m))
    return found


def run(label, centres, dps, md):
    t0 = time.time()
    mp.mp.dps = dps
    obj, removed = B.load_object(label)
    ex = obj.mp_values(dps)
    live = [i for i in range(obj.n) if i not in obj.deleted]
    cid = {i: (rec[1], rec[3]) for i, rec in enumerate(obj.prov) if rec[0] == "rot"}
    src = {i: rec[2] for i, rec in enumerate(obj.prov) if rec[0] == "rot"}
    copy_centres = sorted({c for c, _ in cid.values()})
    centres = centres or (copy_centres + [c for c in (206, 0, 205) if c not in copy_centres])
    edges, verified, rejected, recovered = exact_census(obj, ex)
    print(f"[atlas] {label}: n={obj.n} live={len(live)} unit edges EXACT {len(edges)} "
          f"(float census {verified} verified, {rejected} rejected, {recovered} recovered at tol 1e-6) [{time.time()-t0:.0f}s]", flush=True)
    eps = mp.mpf(10) ** (-(dps - 15))
    h = mp.degrees(mp.atan(1 / mp.sqrt(11))); th15 = mp.degrees(mp.atan2(mp.sqrt(15), 7))
    # --- directions
    hist = collections.Counter(); off = []
    kind = lambda i: "seed" if i < 214 else ("copy" if i in cid else "halo")
    for u, v in edges:
        D = ex[v] - ex[u]
        th = mp.degrees(mp.atan2(D.imag, D.real))
        dec = ladder_decompose(th, h, th15, eps)
        if dec is None:
            off.append(dict(edge=[u, v], kinds=[kind(u), kind(v)], angle=float(th)))
        else:
            hist[(dec[0], dec[1])] += 1
    print(f"[atlas] directions: {len(edges) - len(off)} on the half-twist ladder, {len(off)} off; (m, j) histogram "
          f"{sorted(hist.items())}", flush=True)
    # --- rings
    rings = {}
    for c in centres:
        buckets = collections.defaultdict(list)
        for i in live:
            if i == c: continue
            D = ex[i] - ex[c]; r2 = (D * mp.conj(D)).real
            key = mp.nstr(r2, dps - 12)
            buckets[key].append(i)
        top = sorted(buckets.items(), key=lambda kv: -len(kv[1]))[:12]
        rows = []
        for key, mem in top:
            r2 = mp.mpf(key)
            rows.append(dict(r2=float(r2), r=float(mp.sqrt(r2)), count=len(mem), exact=identify(r2, dps),
                             kinds=dict(collections.Counter(kind(i) for i in mem))))
        rings[str(c)] = dict(distinct_r2=len(buckets), top=rows)
        print(f"[atlas] rings about {c}: {len(buckets)} distinct r², top: " +
              "; ".join(f"r={row['r']:.4f}×{row['count']}" + (f" [{row['exact']}]" if row['exact'] else "") for row in rows[:6]), flush=True)
    # --- cross chords
    chords = []
    if cid:
        field_cache = {}
        def fld(i):
            if i not in field_cache: field_cache[i] = in_seed_field(ex[i], dps)
            return field_cache[i]
        for u, v in edges:
            cu, cv = cid.get(u), cid.get(v)
            if cu == cv: continue                       # both original, or same copy
            if cu is not None and cv is not None:
                chords.append(dict(edge=[u, v], kind="copy-copy", copies=[f"{cu[0]}{'p' if cu[1] > 0 else 'm'}", f"{cv[0]}{'p' if cv[1] > 0 else 'm'}"]))
                continue
            p, q = (u, v) if cu is None else (v, u)          # p original, q copy
            c, s = cid[q]; qs = src[q]
            Dp = ex[p] - ex[c]; Dq = ex[qs] - ex[c]
            im = (Dp * mp.conj(Dq)).imag
            chords.append(dict(edge=[p, q], kind="self" if qs == p else "cross", copy=f"{c}{'p' if s > 0 else 'm'}",
                               source=qs, r_p=float(mp.sqrt((Dp * mp.conj(Dp)).real)), r_q=float(mp.sqrt((Dq * mp.conj(Dq)).real)),
                               collinear=bool(abs(im) < eps), p_seed_field=fld(p), q_seed_field=fld(qs),
                               p_kind=kind(p), q_kind=kind(qs), centre_neighbour=bool(p == c)))
        n_self = sum(1 for ch in chords if ch["kind"] == "self")
        n_coll = sum(1 for ch in chords if ch.get("collinear"))
        n_sf = sum(1 for ch in chords if ch.get("p_seed_field") and ch.get("q_seed_field"))
        n_sf_coll = sum(1 for ch in chords if ch.get("p_seed_field") and ch.get("q_seed_field") and ch.get("collinear"))
        n_cn = sum(1 for ch in chords if ch.get("centre_neighbour"))
        print(f"[atlas] cross chords {len(chords)}: {n_self} self-chords (radius-2 shell), {n_cn} centre–copy(neighbour), "
              f"{n_coll} collinear with the centre; {n_sf} with both endpoints in the seed field, of which {n_sf_coll} collinear", flush=True)
    # --- symmetry
    sym = symmetry_search(obj, ex, centres, h, th15, dps)
    print(f"[atlas] symmetries found: {len(sym)} {sym[:4]}", flush=True)
    out = dict(kind="atlas", label=label, fingerprint=obj.fingerprint(removed), n=obj.n, live=len(live),
               unit_exact=len(edges), census=dict(verified=verified, rejected=rejected, recovered=recovered),
               cheats_standing=len([e for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]),
               ladder=dict(half_twist_deg=float(h), theta15_deg=float(th15), on=len(edges) - len(off), off=len(off),
                           histogram={f"{m},{j}": n for (m, j), n in sorted(hist.items())}, off_edges=off[:200]),
               rings=rings, chords=chords, symmetries=sym, dps=dps, seconds=round(time.time() - t0, 1),
               claim_scope="exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; "
                           "PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof")
    ATLAS.mkdir(parents=True, exist_ok=True)
    (ATLAS / f"{label}.json").write_text(json.dumps(out, indent=1))
    if md:
        card = card_md(out)
        (ATLAS / f"{label}.md").write_text(card)
        print(card)
    print(f"[atlas] wrote {ATLAS / (label + '.json')} [{time.time()-t0:.0f}s]")
    return out


def card_md(a):
    L = a["ladder"]; lines = [f"### atlas · `{a['label']}` (fp {a['fingerprint']})", ""]
    lines.append(f"- **size**: {a['n']} points ({a['live']} live), {a['unit_exact']} unit edges exact "
                 f"(float census {a['census']['verified']} verified / {a['census']['rejected']} rejected / {a['census']['recovered']} recovered), {a['cheats_standing']} cheats standing")
    lines.append(f"- **directions**: {L['on']} of {a['unit_exact']} on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, "
                 f"{L['off']} off; (m,j) classes: " + ", ".join(f"({k}):{v}" for k, v in L['histogram'].items()))
    for c, r in a["rings"].items():
        lines.append(f"- **rings about {c}**: {r['distinct_r2']} distinct r²; top " +
                     "; ".join(f"r={row['r']:.4f}×{row['count']}" + (f" = √[{row['exact']}]" if row['exact'] else "") for row in r['top'][:5]))
    if a["chords"]:
        ch = a["chords"]
        lines.append(f"- **cross chords**: {len(ch)} — {sum(1 for c in ch if c['kind']=='self')} self (radius-2 shell), "
                     f"{sum(1 for c in ch if c.get('centre_neighbour'))} centre–neighbour, {sum(1 for c in ch if c.get('collinear'))} collinear with the centre, "
                     f"{sum(1 for c in ch if c.get('p_seed_field') and c.get('q_seed_field'))} with both endpoints in ℚ(√3,√11)")
    lines.append(f"- **symmetries** (rotations about the centres, reflections at ladder angles): {len(a['symmetries'])}")
    lines.append(f"- computed at {a['dps']} digits in {a['seconds']} s; `{a['claim_scope']}`")
    return "\n".join(lines) + "\n"


def self_test():
    """The bare seed plus its ρ₁₅ copy about 206: the ladder must hold every seed edge at j = 0 and
    every copy edge at j = 1; the self-chords must be exactly the seed points at distance 2 from 206;
    the rings about 206 must show the seed's own shells."""
    import compose as C
    mp.mp.dps = 40
    obj = B.Obj(); C.compose(obj, [(2, 206, +1)], log=lambda *_: None)
    label = "selftest-anatomy"; C.write_object(obj, label, [])
    a = run(label, [206], 40, md=False)
    (B.BUILD / f"m50-object-{label}.json").unlink()
    ex = obj.mp_values(40)
    shell2 = [i for i in range(214) if i != 206 and abs(abs(ex[i] - ex[206]) - 2) < mp.mpf(10) ** -30]
    n_self = sum(1 for ch in a["chords"] if ch["kind"] == "self")
    assert n_self == len(shell2), ("self-chords must equal the radius-2 shell", n_self, len(shell2))
    assert a["ladder"]["off"] <= len(a["chords"]), "every off-ladder edge must be a cross chord"
    assert all(int(k.split(",")[1]) in (0, 1) for k in a["ladder"]["histogram"]), "j must be 0 (original) or 1 (copy)"
    print(f"[self-test] PASS: radius-2 shell {len(shell2)} = self-chords {n_self}; off-ladder {a['ladder']['off']} ≤ chords {len(a['chords'])}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object"); ap.add_argument("--centres", default=None)
    ap.add_argument("--dps", type=int, default=50); ap.add_argument("--md", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    centres = [0 if c == "v0" else int(c) for c in a.centres.split(",")] if a.centres else None
    run(a.object, centres, a.dps, a.md)


if __name__ == "__main__":
    main()
