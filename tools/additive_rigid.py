#!/usr/bin/env python3
"""additive_rigid — M57's subcommands on additive.py's stage vocabulary (plans/M57-additive-rigidity.md §M1–§M3).

The additive family A of a chunk (its admissible homs, `additive.py homs`) sits inside the chunk's proper
k-colourings, which carry moves: single-vertex recolourings and Kempe swaps. A is ADDITIVELY RIGID when it is
the whole space; a necessary, solver-free condition is that A is CLOSED under every move, measured by

    γ(X, k) := Σ over (additive colouring, colour pair {a, b}) of (components of the {a, b}-subgraph − 1)

whose isolated-vertex part is the loose-incidence count (a vertex missing some colour among its neighbours)
and whose remainder is the Kempe part. γ = 0 ⟺ every {a, b}-subgraph of every additive colouring is connected.

    python3 tools/additive.py closure --seed --k 5                 # γ, per hom, with verified swaps
    python3 tools/additive.py rigid   --planted moser --k 4         # enumerate colourings, test additivity
    python3 tools/additive.py free    --seed --k 5                  # forced / free / mixed classes and pairs
    python3 tools/additive.py extend  --witness … --k 5 --pool FILE --colourings FILE   # the family delta per point
    python3 tools/additive.py closure --hexball 2 --k 4 | --ball 4 --centre 0 | --core122 | --core588 | --depth2

VERDICTS (§M3.1; M56's pair words untouched). Stage (`rigid`): `additively-rigid` (the enumeration ended UNSAT and
every colouring is additive — the UNTRUSTED enumeration's claim, never a certificate), `not-rigid: n of N` (a verified
proper non-additive colouring is in the record — a CERTIFICATE), `capped: 0 non-additive of N sampled` (nothing),
`vacuous` (the solver found no colouring). Family (`closure`): `family-kempe-closed` (γ = 0) / `family-kempe-open`;
per hom `kempe-closed` / `kempe-open`; per (hom, colour pair) `connected` / `disconnected`; per (hom, vertex) `loose`.
Pair split (`free`): `forced-additively` (∈ kΛ) / `free` (every additive colouring separates) / `mixed`.
The gauge from a SAMPLED family prints as `γ ≥ N`, never as a number. UNTRUSTED like everything in tools/: every
emitted colouring is re-verified on the stage's edge list before it is written; an improper swap is an assertion."""
from __future__ import annotations
import argparse, itertools, json, math, random, sys, time
from collections import Counter, defaultdict
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
import additive as AD

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "m57"
RIGID_LICENCE = ("additively-rigid is the untrusted enumeration's claim (a SAT blocking loop that ended UNSAT); it licenses "
                 "nothing by itself and AdditiveRigid.lean consumes it only as a hypothesis. not-rigid carries a verified "
                 "proper non-additive colouring: a certificate that the stage is not rigid. capped licenses nothing.")
CLOSURE_LICENCE = ("γ is exact when the family is complete and a LOWER bound when it is a sample; every kempe-open row carries a "
                   "swapped colouring verified proper on the stage's full edge list, and one tested non-additive is a certificate "
                   "of non-rigidity; γ = 0 proves nothing about rigidity (other reconfiguration components may exist).")


# ====================================================================== stages: restrictions and loaders
def hexball(R: int) -> AD.Chunk:
    pts = [(Fr(a), Fr(b)) for a in range(-R, R + 1) for b in range(-R, R + 1) if abs(a + b) <= R]
    idx = {p: i for i, p in enumerate(pts)}
    units = [(1, 0), (0, 1), (-1, 1)]
    E = [(idx[p], idx[(p[0] + u, p[1] + v)]) for p in pts for u, v in units if (p[0] + u, p[1] + v) in idx]
    return AD.Chunk(f"hexball-{R}", pts, E, AD.FrameHex(), f"the hexagonal lattice ball of radius {R} (hex coordinates)", "by construction",
                    meta=dict(origin=idx[(Fr(0), Fr(0))], radius=R))


def restrict_ball(ch: AD.Chunk, R2: Fr, centre: int, rederive: bool = True) -> AD.Chunk:
    """The sub-stage of the points within distance √R2 of `centre` (float threshold with a 1e-9 margin; a point within
    the margin of the boundary is logged), with the stage's edges among them; the unit pairs re-derived exactly and
    asserted equal when the sub-stage has ≤ 6,000 points."""
    xy = ch.floats(); c = xy[centre]
    d2 = ((xy - c) ** 2).sum(axis=1); r2 = float(R2)
    keep = [i for i in range(ch.n) if d2[i] <= r2 + 1e-9]
    near = [i for i in keep if abs(d2[i] - r2) < 1e-9]
    idx = {v: i for i, v in enumerate(keep)}
    E = [(idx[u], idx[v]) for u, v in ch.edges if u in idx and v in idx]
    sub = AD.Chunk(f"{ch.name}-ball{R2}-c{centre}", [ch.points[v] for v in keep], E, ch.frame,
                   f"{ch.source}; restricted to the ball of squared radius {R2} about vertex {centre} (parent fp {ch.fingerprint()})",
                   ch.unit_verified, meta=dict(ball=str(R2), centre=centre, parent_fingerprint=ch.fingerprint(), parent_index=keep,
                                                boundary_coincidences=len(near)))
    if rederive and sub.n <= 6000:
        ue = set(sub.pairs_at(Fr(1)))
        assert ue == set(sub.edges), ("the restricted edge list disagrees with the exact re-derivation", len(ue), len(sub.edges))
        sub.unit_verified = f"{ch.unit_verified}; sub-stage unit pairs re-derived exactly ({len(ue)})"
    return sub


def load_core122() -> AD.Chunk:
    import twodist as T
    import field as Fld
    pts, ue, tp = T.load_core122()          # couple currency: two 16-lists of Fractions over √{3,5,7,11}-products
    primes = [3, 5, 7, 11]
    denom = 1
    for p in pts:
        for part in p:
            for x in part:
                denom = denom * Fr(x).denominator // math.gcd(denom, Fr(x).denominator)
    fr = AD.FrameField16(primes, denom)
    P = [tuple(Fr(x) for x in p[0]) + tuple(Fr(x) for x in p[1]) for p in pts]
    ch = AD.Chunk("core122", P, ue, fr, "the M33/M34 122-vertex distance-2 pigeonhole core (twodist.load_core122: hexagram seam lattice at B = 2)",
                  "421 unit edges re-derived exactly by twodist.load_core122 (asserted equal to the stored list)", meta=dict(distance2_pairs=len(tp)))
    for u, v in ch.edges:
        assert fr.rational_of_key(fr.dist2_key(ch.points[u], ch.points[v])) == 1, ("core122 edge not unit in FrameField16", u, v)
    return ch


def load_core588() -> AD.Chunk:
    path = ROOT / "data" / "m54" / "witness-exact-core-8over3.json"
    d = json.loads(path.read_text())
    core = [i for i, pt in enumerate(d["points"]) if all(n == 0 for n, _ in pt[0][1]) and all(n == 0 for n, _ in pt[1][1])]
    idx = {v: i for i, v in enumerate(core)}
    P = []
    for v in core:
        (xA, _), (yA, _) = d["points"][v]
        P.append(tuple(Fr(n, dd) for n, dd in xA) + tuple(Fr(n, dd) for n, dd in yA))
    E = [(idx[u], idx[v]) for u, v in d["edges"] if u in idx and v in idx]
    ch = AD.Chunk("core588", P, E, AD.FrameK8(), f"the 588-point K-forcer core of the T20 witness ({path.name}: the points with zero √247-part; W's edges among them)",
                  "every edge verified unit in K8 at load", meta=dict(witness_index=core, pair=d["stage"].get("pair")))
    for u, v in ch.edges:
        assert ch.frame.rational_of_key(ch.frame.dist2_key(ch.points[u], ch.points[v])) == 1, ("core588 edge not unit", u, v)
    return ch


def kext_points(entries) -> list:
    out = []
    for e in entries:
        (xA, xB), (yA, yB) = e["x"], e["y"]
        out.append(tuple(Fr(n, dd) for n, dd in xA) + tuple(Fr(n, dd) for n, dd in xB) + tuple(Fr(n, dd) for n, dd in yA) + tuple(Fr(n, dd) for n, dd in yB))
    return out


def load_depth2() -> AD.Chunk:
    """The M55 full-pool thickened stage (10,541 points, F₂₄₇): the stage file holds 60-digit decimals and the exact edge
    list; the exact points are recovered by matching each decimal to W's exact points and the two pools' exact KExt
    points (unique match at 40 digits asserted), and every listed edge is re-verified exactly."""
    import mpmath as mp
    from five_dial import KExt
    from copy_exact_field import K
    mp.mp.dps = 70
    st = json.loads((ROOT / "data" / "m55" / "W-plus-cross-depth2.json").read_text())
    W = json.loads((ROOT / "data" / "m54" / "witness-exact-core-8over3.json").read_text())
    c1 = json.loads((ROOT / "data" / "m54" / "cross-lattice-W-core-8over3.json").read_text())
    c2 = json.loads((ROOT / "data" / "m55" / "cross-lattice-depth2-W-core-8over3.json").read_text())
    KExt.m = 247
    cands = []
    for pt in W["points"]:
        (xA, xB), (yA, yB) = pt
        cands.append(tuple(Fr(n, dd) for n, dd in xA) + tuple(Fr(n, dd) for n, dd in xB) + tuple(Fr(n, dd) for n, dd in yA) + tuple(Fr(n, dd) for n, dd in yB))
    cands += kext_points(c1["pool"]) + kext_points(c2["pool"])
    def dec(v16):
        x = KExt(K(*v16[0:4]), K(*v16[4:8])).mp(); y = KExt(K(*v16[8:12]), K(*v16[12:16])).mp()
        return (mp.nstr(x, 40, strip_zeros=False), mp.nstr(y, 40, strip_zeros=False))
    table = {}
    for i, v in enumerate(cands):
        table.setdefault(dec(v), []).append(i)
    P = []; multi = 0
    for sx, sy in st["points"]:
        key = (mp.nstr(mp.mpf(sx), 40, strip_zeros=False), mp.nstr(mp.mpf(sy), 40, strip_zeros=False))
        hits = table.get(key)
        assert hits, ("a depth-2 stage point matches no exact candidate at 40 digits", sx[:20], sy[:20])
        if len({cands[h] for h in hits}) > 1:
            multi += 1
        P.append(cands[hits[0]])
    assert multi == 0, ("ambiguous decimal matches", multi)
    fr = AD.FrameKExt16(247)
    ch = AD.Chunk("W-plus-cross-depth2", P, [tuple(e) for e in st["edges"]], fr,
                  "data/m55/W-plus-cross-depth2.json (M55's full-pool thickened stage), exact points recovered from the witness and pool files by 40-digit decimal matching",
                  "every listed edge re-verified unit in K(√247) at load", meta=st.get("meta", {}))
    bad = [(u, v) for u, v in ch.edges if fr.rational_of_key(fr.dist2_key(ch.points[u], ch.points[v])) != 1]
    assert not bad, ("depth-2 stage edges not unit after exact recovery", bad[:3])
    return ch


def load_stage(a) -> AD.Chunk:
    if getattr(a, "hexball", None) is not None:
        ch = hexball(a.hexball)
    elif getattr(a, "core122", False):
        ch = load_core122()
    elif getattr(a, "core588", False):
        ch = load_core588()
    elif getattr(a, "depth2", False):
        ch = load_depth2()
    else:
        ch = AD.load_chunk(a)
    if getattr(a, "ball", None) is not None:
        ch = restrict_ball(ch, Fr(a.ball), a.centre if a.centre is not None else int(ch.meta.get("origin", ch.meta.get("centre_index", 0)) or 0))
    return ch


def stage_args(p):
    p.add_argument("--seed", action="store_true"); p.add_argument("--object"); p.add_argument("--witness"); p.add_argument("--heule510", action="store_true")
    p.add_argument("--degrey", action="store_true"); p.add_argument("--field16"); p.add_argument("--graph"); p.add_argument("--planted"); p.add_argument("--out")
    p.add_argument("--hexball", type=int); p.add_argument("--core122", action="store_true"); p.add_argument("--core588", action="store_true")
    p.add_argument("--depth2", action="store_true"); p.add_argument("--ball", help="restrict to the ball of this squared radius (a rational) about --centre")
    p.add_argument("--centre", type=int); p.add_argument("--with-cheats", help="'auto' (the seed's 446 distance-2 pairs) or a JSON file of extra edges [[u, v], …]")


def out_path(a, sub: str, ch: AD.Chunk, k=None) -> Path:
    if getattr(a, "out", None):
        return Path(a.out)
    DATA.mkdir(parents=True, exist_ok=True)
    nm = ch.name.replace("/", "_")
    return DATA / (f"{sub}-{nm}-k{k}.json" if k is not None else f"{sub}-{nm}.json")


def write(path: Path, rec: dict, log=print):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(rec, indent=1, default=str))
    log(f"  wrote {path}")


# ====================================================================== cheats and the family
def load_cheats(a, ch: AD.Chunk):
    """Extra (non-unit) edges the colourings must respect; the seed's are computed exactly."""
    spec = getattr(a, "with_cheats", None)
    if not spec:
        return [], None
    if spec == "auto":
        assert ch.name == "EI-seed-unit", "--with-cheats auto is the seed's 446 distance-2 pairs; give a file for other stages"
        import twodist as T
        H = T.ei_H(); c = T.classify(H, radii=(1, 4))
        return sorted((min(u, v), max(u, v)) for u, v in c[4]), "twodist.classify(ei_H, radii=(1,4))[4] (exact)"
    d = json.loads(Path(spec).read_text())
    E = d["edges"] if isinstance(d, dict) else d
    fp = d.get("stage_fingerprint") if isinstance(d, dict) else None
    if fp not in (None, ch.fingerprint()):
        raise SystemExit(f"--with-cheats refused: recorded for fingerprint {fp}, the stage is {ch.fingerprint()}")
    return sorted((min(u, v), max(u, v)) for u, v in E), spec


class Family:
    """The additive family of a chunk at k: every admissible hom (enumeration below rank 9, SAT above), each with its
    verified colouring; the distinct partitions; filtered by properness on the cheats when there are any."""
    def __init__(self, ch: AD.Chunk, k: int, cheats=(), max_models: int = 200000, log=print):
        self.ch, self.k = ch, k
        self.L, self.vecs, self.scale = AD.build_lattice(ch)
        self.groups = AD.all_homs(ch, self.L, self.vecs, self.scale, k, max_models=max_models, log=log)
        self.exact = all(g["exact"] for g in self.groups)
        self.members = []      # (group tuple, hom, colouring)
        for g in self.groups:
            for h, c in zip(g["homs"], g["colourings"]):
                if cheats and AD.verify_proper(c, cheats):
                    continue
                self.members.append((tuple(g["divisors"]), h, c))
        self.parts = {}
        for i, (g, h, c) in enumerate(self.members):
            self.parts.setdefault(AD.canon(c), i)
        self.reps = [self.members[i] for i in sorted(self.parts.values())]
        self.cheats = list(cheats)

    def summary(self):
        return dict(homs=len(self.members), partitions=len(self.parts), exact=self.exact, rank=self.L.rank,
                    groups=[dict(group=g["group"], count=g["count"], partitions=g["partitions"], method=g["method"], exact=g["exact"]) for g in self.groups],
                    filtered_by_cheats=bool(self.cheats))

    def is_additive(self, col) -> str:
        """'additive' | 'not-additive' | 'undecided' — partition equality against the complete family; with a sample,
        a hit is 'additive' and a miss 'undecided'."""
        if AD.canon(col) in self.parts:
            return "additive"
        return "not-additive" if self.exact else "undecided"

    def defect(self, col):
        """least Hamming distance to a family colouring under the best palette bijection, and that colouring's index."""
        k = self.k; c = np.array(col); best = None
        perms = list(itertools.permutations(range(k)))
        for i, (g, h, f) in enumerate(self.reps):
            f = np.array(f); M = np.zeros((k, k), dtype=np.int64); np.add.at(M, (c, f), 1)
            agree = max(sum(M[x, pi[x]] for x in range(k)) for pi in perms)
            d = self.ch.n - int(agree)
            if best is None or d < best[0]:
                best = (d, i)
        return best


# ====================================================================== the Kempe-closure census
def components(edges_adj, verts: set):
    seen = set(); comps = []
    for s in verts:
        if s in seen:
            continue
        seen.add(s); stack = [s]; comp = [s]
        while stack:
            x = stack.pop()
            for y in edges_adj[x]:
                if y in verts and y not in seen:
                    seen.add(y); stack.append(y); comp.append(y)
        comps.append(sorted(comp))
    return comps


def closure_census(ch: AD.Chunk, fam: Family, edges, log=print, store_swaps: int = 50, store_homs: int = 100, hom_cap: int | None = None):
    """γ over the family's partition reps × colour pairs on the graph `edges` (unit edges, plus cheats when given).
    Per unstable pair one swap on the smallest component: built, verified proper (assertion), tested for additivity."""
    n, k = ch.n, fam.k
    adj = [set() for _ in range(n)]
    for u, v in edges:
        adj[u].add(v); adj[v].add(u)
    reps = fam.reps if hom_cap is None else fam.reps[:hom_cap]
    gamma = 0; loose_part = 0; kempe_part = 0
    loose = Counter(); pair_hist = Counter()
    swaps = dict(built=0, proper=0, non_additive=0, additive=0, undecided=0)
    hom_rows = []; swap_records = []
    t0 = time.time()
    for hi, (g, h, f) in enumerate(reps):
        by_col = defaultdict(set)
        for v in range(n):
            by_col[f[v]].add(v)
        row_pairs = []; hom_gamma = 0; hom_loose = []
        for a, b in itertools.combinations(range(k), 2):
            verts = by_col[a] | by_col[b]
            comps = components(adj, verts)
            c = len(comps); pair_hist[c] += 1; hom_gamma += c - 1
            iso = [K[0] for K in comps if len(K) == 1]
            for v in iso:
                hom_loose.append((v, b if f[v] == a else a))
            prow = dict(pair=[a, b], components=c, sizes=sorted(len(K) for K in comps), isolated=iso)
            if c > 1:
                loose_part += len(iso); kempe_part += (c - 1) - len(iso)
                K = min(comps, key=len)
                c2 = list(f)
                for v in K:
                    c2[v] = b if f[v] == a else a
                bad = AD.verify_proper(c2, edges)
                assert not bad, ("INSTRUMENT CATASTROPHE: a Kempe swap is not proper", hi, a, b, bad[:3])
                swaps["built"] += 1; swaps["proper"] += 1
                vd = fam.is_additive(c2)
                swaps["non_additive" if vd == "not-additive" else vd] += 1
                prow["swap"] = dict(component=K, verdict=vd)
                if len(swap_records) < store_swaps:
                    swap_records.append(dict(hom=hi, pair=[a, b], component=K, verdict=vd, colouring=c2))
            row_pairs.append(prow)
        gamma += hom_gamma
        for v, _ in hom_loose:
            loose[v] += 1
        if hi < store_homs:
            hom_rows.append(dict(hom=hi, group=list(g), hom_vector=[list(x) for x in h], gamma=hom_gamma,
                                 verdict="kempe-closed" if hom_gamma == 0 else "kempe-open",
                                 loose=[[v, m] for v, m in hom_loose], pairs=row_pairs))
        if (hi + 1) % 50 == 0:
            log(f"  [closure] {hi + 1}/{len(reps)} colourings, γ so far {gamma} [{time.time() - t0:.0f}s]")
    N = len(reps) * (k * (k - 1) // 2)
    return dict(gamma=gamma, gamma_bar=(gamma / len(reps)) if reps else None, loose_part=loose_part, kempe_part=kempe_part,
                loose_incidences=loose_part, loose_vertices=len(loose), loose_by_vertex=dict(sorted(loose.items())),
                pairs_total=N, disconnected=sum(v for c, v in pair_hist.items() if c > 1), connected=pair_hist.get(1, 0),
                component_histogram=dict(sorted(pair_hist.items())), swaps=swaps, hom_rows=hom_rows, swap_records=swap_records,
                colourings_used=len(reps), seconds=round(time.time() - t0, 1))


def cmd_closure(a):
    ch = load_stage(a); k = a.k
    cheats, cheat_src = load_cheats(a, ch)
    fam = Family(ch, k, cheats, max_models=a.max)
    edges = ch.edges + cheats
    if not fam.reps:
        print(f"[closure] {ch.label()} k={k}: vacuous — no admissible hom{' proper on the cheats' if cheats else ''}; γ undefined")
        rec = dict(kind="additive-closure", stage=ch.header(), k=k, family=fam.summary(), verdict="vacuous", cheats=len(cheats), claim_scope=CLOSURE_LICENCE)
        write(out_path(a, "closure", ch, k), rec); return rec
    res = closure_census(ch, fam, edges, store_swaps=a.store_swaps, hom_cap=a.hom_cap)
    exact = fam.exact and a.hom_cap is None
    gsym = f"γ = {res['gamma']}" if exact else f"γ ≥ {res['gamma']}"
    print(f"[closure] {ch.label()} k={k}{' + ' + str(len(cheats)) + ' cheats' if cheats else ''}: {gsym} over {res['colourings_used']} additive colourings × {k*(k-1)//2} colour pairs "
          f"(family {'complete' if fam.exact else 'INCOMPLETE — a SAT sample'}: {fam.summary()['homs']} homs = {fam.summary()['partitions']} partitions"
          f"{'; census capped to ' + str(a.hom_cap) + ' colourings' if a.hom_cap else ''}); "
          f"{res['disconnected']} of {res['pairs_total']} subgraphs disconnected (components {min(res['component_histogram'])}–{max(res['component_histogram'])}), {res['connected']} connected; "
          f"loose incidences {res['loose_incidences']} on {res['loose_vertices']} of {ch.n} vertices (Kempe part {res['kempe_part']}); "
          f"swaps built {res['swaps']['built']}, proper {res['swaps']['proper']}, non-additive {res['swaps']['non_additive']}, additive {res['swaps']['additive']}, undecided {res['swaps']['undecided']} "
          f"→ {'family-kempe-closed' if res['gamma'] == 0 and exact else 'family-kempe-open'} [{res['seconds']}s]")
    rec = dict(kind="additive-closure", stage=ch.header(), k=k, cheats=len(cheats), cheats_source=cheat_src, edges_used=f"unit ({len(ch.edges)})" + (f" + cheats ({len(cheats)})" if cheats else ""),
               family=fam.summary(), gamma_exact=exact, verdict="family-kempe-closed" if res["gamma"] == 0 and exact else "family-kempe-open", **res,
               claim_scope=CLOSURE_LICENCE + (" The family was filtered by properness on the cheats." if cheats else ""))
    write(out_path(a, "closure", ch, k), rec)
    return rec


# ====================================================================== the colouring enumeration
def enumerate_colourings(n, edges, k, cap: int, pin: int = 0, seed: int | None = None, wall: float | None = None, log=print):
    """Proper k-colourings up to palette by SAT blocking (the exactly-one encoding, vertex `pin` on colour 0; every found
    colouring's whole palette orbit blocked). Returns (colourings, complete: bool, models, status)."""
    from five_dial import colour_clauses, var, decode, verify_proper
    from rigidity import amo_clauses
    from pysat.solvers import Solver
    cl = colour_clauses(n, edges, k) + amo_clauses(n, k) + [[var(pin, 0, k)]]
    if seed is not None:
        random.Random(seed).shuffle(cl)
    seen = {}; models = 0; t0 = time.time(); complete = False; status = "capped"
    perms = list(itertools.permutations(range(k)))
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        while True:
            if cap and len(seen) >= cap:
                status = "capped"; break
            if wall and time.time() - t0 > wall:
                status = "wall"; break
            if not s.solve():
                complete = True; status = "complete"; break
            col = decode(s.get_model(), n, k); assert verify_proper(col, edges) is None; models += 1
            key = AD.canon(col)
            if key not in seen:
                seen[key] = list(key)
            for pi in perms:
                s.add_clause([-var(v, pi[col[v]], k) for v in range(n)])
            if len(seen) % 200 == 0:
                log(f"  [rigid] {len(seen)} colourings up to palette ({models} models) [{time.time() - t0:.0f}s]")
    return list(seen.values()), complete, models, status


def cmd_rigid(a):
    ch = load_stage(a); k = a.k
    cheats, cheat_src = load_cheats(a, ch)
    edges = ch.edges + cheats
    fam = Family(ch, k, cheats, max_models=a.max)
    cap = a.cap if a.cap is not None else (0 if ch.n <= 300 else 2000)
    if cap:
        print(f"  [rigid] cap {cap} colourings up to palette ({'given' if a.cap is not None else 'default above 300 points'}); a capped verdict is never additively-rigid")
    cols, complete, models, status = enumerate_colourings(ch.n, edges, k, cap, pin=a.pin, seed=getattr(a, 'seed_', None), wall=a.wall)
    rows = []; n_add = n_non = n_und = 0; defects = Counter()
    for c in cols:
        assert not AD.verify_proper(c, edges)
        vd = fam.is_additive(c)
        row = dict(verdict=vd)
        if vd == "additive":
            n_add += 1; row["hom"] = fam.parts[AD.canon(c)]
        else:
            d, i = fam.defect(c) if fam.reps else (None, None)
            row["defect"] = d; row["nearest"] = i
            if d is not None and d <= 2:
                f = fam.reps[i][2]; best = None
                for pi in itertools.permutations(range(k)):
                    D = [v for v in range(ch.n) if c[v] != pi[f[v]]]
                    if best is None or len(D) < len(best):
                        best = D
                row["differing"] = best
            if vd == "not-additive":
                n_non += 1; defects[d] += 1
            else:
                n_und += 1
        row["colouring"] = c
        rows.append(row)
    if not cols:
        verdict = "vacuous" if complete else "capped"
    elif n_non > 0:
        verdict = f"not-rigid: {n_non} of {len(cols)}"
    elif complete and n_und == 0:
        verdict = "additively-rigid"
    else:
        verdict = f"capped: 0 non-additive of {len(cols)} sampled" if not complete else f"undecided: {n_und} of {len(cols)} undecided (family incomplete)"
    print(f"[rigid] {ch.label()} k={k}{' + ' + str(len(cheats)) + ' cheats' if cheats else ''}: {verdict} — {len(cols)} colourings up to palette "
          f"(enumeration {'complete' if complete else status}; {models} models; family {'complete' if fam.exact else 'INCOMPLETE'}: {fam.summary()['partitions']} partitions of {fam.summary()['homs']} homs); "
          f"additive {n_add}, non-additive {n_non}, undecided {n_und}; non-additive defects {dict(sorted(defects.items()))}")
    jackpot = verdict == "additively-rigid" and k == 5 and not cheats
    rec = dict(kind="additive-rigid", stage=ch.header(), k=k, cheats=len(cheats), cheats_source=cheat_src, edges_used=f"unit ({len(ch.edges)})" + (f" + cheats ({len(cheats)})" if cheats else ""),
               family=fam.summary(), cap=cap, pin=a.pin, shuffle_seed=getattr(a, 'seed_', None), enumeration=status, complete=complete, models=models, colourings=len(cols),
               additive=n_add, non_additive=n_non, undecided=n_und, defects=dict(sorted(defects.items())), verdict=verdict, jackpot_candidate=jackpot, rows=rows,
               claim_scope=RIGID_LICENCE + " Enumeration: SAT blocking under the exactly-one encoding with one vertex pinned and every found colouring's palette orbit blocked; complete iff the solver returned UNSAT.")
    if jackpot:
        stage_flag = " ".join(f"--{kk}" + ("" if v is True else f" {v}") for kk, v in vars(a).items() if kk in ("seed", "object", "witness", "heule510", "degrey", "field16", "graph", "planted", "hexball", "core122", "core588", "depth2", "ball", "centre") and v not in (None, False))
        print("[rigid] HALT — additively-rigid at five colours on a unit-distance stage. NOT a certificate. Before any claim:")
        print(f"  (1) python3 tools/additive.py rigid {stage_flag} --k 5 --pin {(a.pin + 1) % ch.n} --shuffle 1 --cap 0")
        print(f"  (2) python3 tools/additive.py free  {stage_flag} --k 5   # the forced-additively (5Λ) pairs and their distances (need ≥ 1/2)")
        print(f"  (3) python3 tools/m56_ask_pairs.py <the free record> {stage_flag} --wall 900   # the jackpot protocol: second encoding, JACKPOT file, exit 3")
    write(out_path(a, "rigid", ch, k), rec)
    return rec


# ====================================================================== the class split
def cmd_free(a):
    ch = load_stage(a); k = a.k
    fam = Family(ch, k, max_models=a.max)
    L, vecs, scale = fam.L, fam.vecs, fam.scale
    r = L.rank
    homs = [(g, h) for g, h, c in fam.members]
    if not homs:
        print(f"[free] {ch.label()} k={k}: vacuous — no admissible hom"); return
    M = AD.point_coords(ch, L, scale)
    def split_of(coords):
        z = sum(1 for g, h in homs if all(x == 0 for x in AD.hom_apply(h, g, coords)))
        return "forced-additively" if z == len(homs) else ("free" if z == 0 else "mixed")
    classes = None
    if k ** r <= 2_000_000:
        classes = Counter()
        for co in itertools.product(range(k), repeat=r):
            if any(co):
                classes[split_of(co)] += 1
        S = set(AD.unit_classes(L, vecs, k))
        if all(len(g) == 1 for g, h in homs):      # cyclic: every m·u with m ≢ 0 is free (a theorem)
            mult = {tuple((m * np.array(s)) % k) for s in S for m in range(1, k)}
            bad = [d for d in mult if split_of(d) != "free"]
            assert not bad, ("free: a scalar multiple of a unit class is not free — the hom family is not admissible?!", bad[:3])
    pairs = Counter(); by_d2 = defaultdict(Counter); rows = []
    adj = set(ch.edges)
    for u in range(ch.n):
        for v in range(u + 1, ch.n):
            if (u, v) in adj or ch.comp[u] != ch.comp[v]:
                continue
            d = tuple(int(x) % k for x in (M[u] - M[v]))
            s = split_of(d); pairs[s] += 1
            key = ch.frame.rational_of_key(ch.frame.dist2_key(ch.points[u], ch.points[v]))
            if key is not None:
                by_d2[str(key)][s] += 1
            if s == "forced-additively":
                rows.append([u, v, str(key)])
    print(f"[free] {ch.label()} k={k}: " + (f"{k**r - 1} nonzero classes → forced-additively {classes['forced-additively']} / free {classes['free']} / mixed {classes['mixed']}"
          if classes else f"classes not enumerated (k^r = {k**r})") + f" (family {'complete' if fam.exact else 'INCOMPLETE'}: {len(homs)} homs); "
          f"non-adjacent same-component pairs {sum(pairs.values())} → forced-additively {pairs['forced-additively']} / free {pairs['free']} / mixed {pairs['mixed']}")
    rec = dict(kind="additive-free", stage=ch.header(), k=k, family=fam.summary(), classes=dict(classes) if classes else None, pairs=dict(pairs),
               pairs_by_d2={d: dict(c) for d, c in sorted(by_d2.items())}, forced_pairs=rows,
               claim_scope="forced-additively = the difference lies in every admissible kernel (L1: in kΛ, or by cover); free = in no kernel (every additive colouring "
                           "separates the pair; free ∪ mixed is M56's separated-additively); exact iff the family is complete — a sample over-approximates both free and forced.")
    write(out_path(a, "free", ch, k), rec)
    return rec


# ====================================================================== the family delta (extend / kill-census)
def load_pool(a, ch: AD.Chunk):
    d = json.loads(Path(a.pool).read_text())
    key = a.pool_key
    entries = d[key]
    if entries and isinstance(entries[0], dict) and "x" in entries[0]:
        assert ch.frame.name == "K247-16", f"pool file is in KExt (K(√247)) currency; the stage's frame is {ch.frame.name}"
        return kext_points(entries), f"{a.pool}[{key}] (KExt)"
    return [tuple(Fr(x) for x in p) for p in entries], f"{a.pool}[{key}]"


def extend_hom(fam: Family, h, g, u1_coords, nbr_coords_diff):
    """The extensions of a cyclic-group hom to Λ + ℤu₁: a list of values φ(u₁) (each a tuple like hom_apply's output),
    or None when the case is not handled (non-cyclic group with a non-integral u₁)."""
    k = g[0]
    if u1_coords is not None and all(x.denominator == 1 for x in u1_coords):          # in-lattice: the value is forced
        return [AD.hom_apply(h, g, [int(x) for x in u1_coords])]
    if len(g) != 1:
        return None
    if u1_coords is None:                                                             # new direction: free value
        return [(v,) for v in range(k)]
    m = 1
    for x in u1_coords:
        m = m * x.denominator // math.gcd(m, x.denominator)
    mu = [int(x * m) for x in u1_coords]
    val = AD.hom_apply(h, g, mu)[0]
    if math.gcd(m, k) == 1:
        return [((pow(m, -1, k) * val) % k,)]
    return [(v,) for v in range(k)] if val == 0 else []


def cmd_extend(a):
    ch = load_stage(a); k = a.k
    fam = Family(ch, k, max_models=a.max)
    if not fam.members:
        print(f"[extend] {ch.label()} k={k}: vacuous — no admissible hom"); return
    L, scale = fam.L, fam.scale
    pool, pool_src = load_pool(a, ch)
    cols, improper = [], []
    if a.colourings:
        cols, improper, _ = AD.load_colourings(a, ch, k)
    adj = [set() for _ in range(ch.n)]
    for u, v in ch.edges:
        adj[u].add(v); adj[v].add(u)
    base = closure_census(ch, fam, ch.edges, log=lambda *x: None)
    gamma0, reps0 = base["gamma"], len(fam.reps)
    print(f"  [extend] base γ = {gamma0} over {reps0} colourings (γ̄ {gamma0 / reps0:.3f}); pool {len(pool)} points; sampled colourings {len(cols)}")
    from scipy.spatial import cKDTree
    tree = cKDTree(ch.floats())
    pf = np.array([AD.float_of(ch.frame, p) for p in pool])
    rows = []; t0 = time.time()
    M = AD.point_coords(ch, L, scale)
    for pi_, p in enumerate(pool):
        if a.max_points and pi_ >= a.max_points:
            break
        cand = tree.query_ball_point(pf[pi_], 1 + 1e-6)
        N = [x for x in cand if ch.frame.rational_of_key(ch.frame.dist2_key(p, ch.points[x])) == 1]
        if not N:
            rows.append(dict(point=pi_, neighbours=0, verdict="no-unit-neighbour")); continue
        comps = {ch.comp[x] for x in N}
        if len(comps) > 1:
            rows.append(dict(point=pi_, neighbours=len(N), verdict="not-comparable: neighbours in several components")); continue
        x1 = N[0]
        u1 = tuple((p[i] - ch.points[x1][i]) * scale for i in range(ch.frame.dim))
        co = L.coords(u1)
        case = "new-direction" if co is None else ("in-lattice" if all(x.denominator == 1 for x in co) else f"index-{math.lcm(*[x.denominator for x in co])}")
        # the family delta, hom by hom; the new colourings on X ∪ p (p's colour = φ(x1) + φ(u1))
        new_members = []; unhandled = 0
        for g, h, f in fam.members:
            ext = extend_hom(fam, h, g, co, None)
            if ext is None:
                unhandled += 1; continue
            for val in ext:
                # p's colour: f[x1] + φ(u1) in the mixed-radix int encoding — recompute via hom_apply on coords
                pc_tuple = tuple((AD.hom_apply(h, g, [int(x) for x in M[x1]])[i] + val[i]) % g[i] for i in range(len(g)))
                pc = AD.tuple_to_int(pc_tuple, g)
                if all(pc != f[x] for x in N):
                    new_members.append((g, h, f + [pc]))
        parts = {}
        for i, (g, h, c) in enumerate(new_members):
            parts.setdefault(AD.canon(c), i)
        new_reps = [new_members[i] for i in sorted(parts.values())]
        # γ after: only the pairs containing p's colour change; recompute those per new rep, reuse the base for the others
        gamma1 = 0
        adj2 = [set(s) for s in adj] + [set(N)]
        for x in N:
            adj2[x].add(ch.n)
        for g, h, c in new_reps:
            base_f = c[:ch.n]; pc = c[ch.n]
            by_col = defaultdict(set)
            for v in range(ch.n + 1):
                by_col[c[v]].add(v)
            for x, y in itertools.combinations(range(k), 2):
                verts = by_col[x] | by_col[y]
                gamma1 += len(components(adj2, verts)) - 1
        killed = sum(1 for c in cols if len({c[x] for x in N}) == k)
        row = dict(point=pi_, neighbours=len(N), case=case, family_before=len(fam.members), family_after=len(new_members), reps_after=len(new_reps),
                   unhandled_homs=unhandled, gamma_after=gamma1, gamma_bar_after=(gamma1 / len(new_reps)) if new_reps else None,
                   delta_gamma_bar=((gamma1 / len(new_reps)) - gamma0 / reps0) if new_reps else None,
                   sampled_killed=killed, sampled_total=len(cols), verdict="vacuous" if not new_reps else "extended")
        rows.append(row)
        if (pi_ + 1) % 20 == 0:
            print(f"  [extend] {pi_ + 1}/{len(pool)} points [{time.time() - t0:.0f}s]")
    done = [r for r in rows if r.get("verdict") == "extended"]
    dgb = sorted(r["delta_gamma_bar"] for r in done)
    kills = sorted(r["sampled_killed"] for r in done)
    cases = Counter(r.get("case") for r in done)
    top = sorted(done, key=lambda r: r["delta_gamma_bar"])[:a.top]
    print(f"[extend] {ch.label()} k={k}: {len(done)} of {len(rows)} pool points extend (cases {dict(cases)}; {sum(1 for r in rows if r.get('verdict','').startswith('no-unit'))} without a unit neighbour); "
          f"γ̄ before {gamma0 / reps0:.3f} → after [{dgb[0] + gamma0 / reps0:.3f}, {dgb[-1] + gamma0 / reps0:.3f}] (Δγ̄ min {dgb[0]:+.3f} at point {top[0]['point']}, median {dgb[len(dgb)//2]:+.3f}); "
          f"sampled kills max {kills[-1] if kills else 0} of {len(cols)} (median {kills[len(kills)//2] if kills else 0}); family {fam.summary()['homs']} → [{min(r['family_after'] for r in done)}, {max(r['family_after'] for r in done)}] homs"
          if done else f"[extend] {ch.label()} k={k}: no pool point extends")
    rec = dict(kind="additive-extend", stage=ch.header(), k=k, family=fam.summary(), pool=pool_src, pool_points=len(pool), colourings_file=a.colourings, colourings=len(cols), improper=improper,
               gamma_before=gamma0, reps_before=reps0, gamma_bar_before=gamma0 / reps0, rows=rows, top=top,
               claim_scope="per pool point: its exact unit neighbours in the stage, the case [Λ′ : Λ] of its first unit vector, the family after (each hom's admissible extensions — "
                           "in-lattice: the forced value; new direction: the values avoiding the neighbours' colours; index m coprime to k: the unique extension), γ after on X ∪ p over the "
                           "new partition reps, and the sampled colourings killed (rainbow neighbourhood). An in-lattice point never kills an additive colouring by coverage (D5).")
    write(out_path(a, "extend", ch, k), rec)
    return rec


# ====================================================================== self-test
def self_test():
    class A:
        def __init__(self, **kw):
            d = dict(seed=False, object=None, witness=None, heule510=False, degrey=False, field16=None, graph=None, planted=None, out=None,
                     hexball=None, core122=False, core588=False, depth2=False, ball=None, centre=None, with_cheats=None, max=200000,
                     cap=0, pin=0, seed_=None, wall=None, store_swaps=50, hom_cap=None, colourings=None, pool=None, pool_key="pool", max_points=0, top=10)
            d.update(kw); self.__dict__.update(d)
    fails = []
    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}")
        if not cond:
            fails.append(name)
    quiet = lambda *x, **k: None
    print("[self-test] additive_rigid: planted controls (red seen where the control is a red)")
    # closure: hex ball R=1 at 3 is kempe-closed (one colouring, connected subgraphs); R=2 at 4 open with the line swap non-additive
    ch = hexball(1); fam = Family(ch, 3, log=quiet); res = closure_census(ch, fam, ch.edges, log=quiet)
    check("hexball 1 at 3: one additive colouring, γ = 0 (kempe-closed)", len(fam.reps) == 1 and res["gamma"] == 0)
    ch = hexball(2); fam = Family(ch, 4, log=quiet); res = closure_census(ch, fam, ch.edges, log=quiet)
    line = [r for r in res["hom_rows"] if r["group"] == [2, 2]]
    check("hexball 2 at 4: family 4 partitions (2 residue-type + 2 Z/4-type)", len(fam.reps) == 4)
    check("hexball 2 at 4: the residue colouring's {0,1}-subgraph has 3 components of sizes (3,3,5)", any(any(p["pair"] == [0, 1] and p["sizes"] == [3, 3, 5] for p in r["pairs"]) for r in line))
    check("hexball 2 at 4: every colour pair of every hom disconnected; every swap proper and NON-additive", res["disconnected"] == res["pairs_total"] and res["swaps"]["proper"] == res["swaps"]["built"] and res["swaps"]["non_additive"] == res["swaps"]["built"])
    # the planted disconnected chunk: components of the chunk itself; the census runs per component through the base colouring
    # rigid: K4-e rigid at 3 and 4; the spindle not-rigid 4 of 16 at 4; hex 1 rigid at 3, not-rigid 7 of 11 at 4
    def rigid(ch, k, cheats=()):
        fam = Family(ch, k, cheats, log=quiet); cols, complete, models, status = enumerate_colourings(ch.n, ch.edges + list(cheats), k, 0, log=quiet)
        vds = [fam.is_additive(c) for c in cols]
        return len(cols), vds.count("additive"), vds.count("not-additive"), complete, fam
    n_, add, non, comp, fam = rigid(AD.planted("k4e"), 3); check("K4-e at 3: additively-rigid (1 colouring, additive, complete)", (n_, add, non, comp) == (1, 1, 0, True))
    n_, add, non, comp, fam = rigid(AD.planted("k4e"), 4); check("K4-e at 4: additively-rigid (2 colourings)", (n_, add, non, comp) == (2, 2, 0, True))
    n_, add, non, comp, fam = rigid(AD.planted("moser"), 4); check("Moser spindle at 4: not-rigid 4 of 16 (S6)", (n_, add, non, comp) == (16, 12, 4, True))
    n_, add, non, comp, fam = rigid(hexball(1), 3); check("hexball 1 at 3: rigid (1)", (n_, add, non, comp) == (1, 1, 0, True))
    n_, add, non, comp, fam = rigid(hexball(1), 4); check("hexball 1 at 4: not-rigid 7 of 11 (S6)", (n_, add, non, comp) == (11, 4, 7, True))
    # the kernel's spec objects: the path at 2 rigid, at 3 not; the hexagon at 3 not, with 0 1 0 1 0 2 non-additive
    path = AD.Chunk("planted-path3", [(Fr(0), Fr(0)), (Fr(1), Fr(0)), (Fr(2), Fr(0))], [(0, 1), (1, 2)], AD.FrameQ(2, "Z^2"), "planted", "by construction")
    n_, add, non, comp, fam = rigid(path, 2); check("pathGraph 3 at 2: additively-rigid (the kernel's spec)", (n_, add, non, comp) == (1, 1, 0, True))
    n_, add, non, comp, fam = rigid(path, 3); check("pathGraph 3 at 3: not-rigid (the kernel's second red: 0 1 0)", non >= 1 and comp)
    # cheats: the seed with its 446 cheats at 5 must reproduce M56's 35 / 18
    seed = AD.load_seed(); import twodist as T
    Hh = T.ei_H(); c = T.classify(Hh, radii=(1, 4)); cheats = sorted((min(u, v), max(u, v)) for u, v in c[4])
    fam = Family(seed, 5, cheats, log=quiet)
    check("seed with cheats at 5: family 72 homs = 18 partitions after the cheat filter (automatic at 5)", (len(fam.members), len(fam.parts)) == (72, 18))
    res = closure_census(seed, fam, seed.edges + cheats, log=quiet)
    check("seed {1,2}-graph at 5: loose incidences 12 on 6 vertices (S6)", (res["loose_incidences"], res["loose_vertices"]) == (12, 6))
    res_u = closure_census(seed, fam, seed.edges, log=quiet)
    check("seed unit part at 5: γ = 1,197 with 10 of 180 subgraphs connected (S6)", (res_u["gamma"], res_u["connected"], res_u["pairs_total"]) == (1197, 10, 180))
    # free on the seed: 36 / 0 / 588 classes; pairs 1 / 780 / 21,006
    a = A(seed=True, k=5, out="/dev/null")
    import io, contextlib
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rec = cmd_free(a)
    check("seed at 5: free classes 36 / forced 0 / mixed 588; pairs forced-additively 1 / free 780 / mixed 21,006 (S6)",
          rec["classes"] == {"free": 36, "mixed": 588} and rec["pairs"] == {"forced-additively": 1, "free": 780, "mixed": 21006})
    # extend: hexball 2 at 4 plus an in-lattice point (a lattice point outside the ball, adjacent to boundary points) kills no additive colouring;
    # plus a new-direction point (the Moser twist of a unit) leaves k−1 extensions per hom at one neighbour
    ch = hexball(2); fam = Family(ch, 4, log=quiet); L, scale = fam.L, fam.scale
    p_in = (Fr(3), Fr(0))                        # neighbours (2,0) and (2,1)? (3,0)-(2,0) = (1,0) unit; (3,0)-(2,1)... (1,-1) is a unit? units are (1,0),(0,1),(-1,1): (3,0)-(2,1) = (1,-1) = -(−1,1) yes
    co = L.coords(tuple(int(x * scale) for x in p_in))
    ext_in = [extend_hom(fam, h, g, co, None) for g, h, f in fam.members]
    check("extend: an in-lattice point has a forced value under every hom (no coverage kill)", all(e is not None and len(e) == 1 for e in ext_in))
    ext_new = [extend_hom(fam, h, g, None, None) for g, h, f in fam.members if len(g) == 1]
    check("extend: a new-direction point has k free values per cyclic hom before admissibility", all(len(e) == 4 for e in ext_new))
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


# ====================================================================== registration
def register(sub, _stage_args_unused=None):
    p = sub.add_parser("closure", help="the Kempe-closure gauge γ of the additive family"); stage_args(p)
    p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000); p.add_argument("--store-swaps", type=int, default=50)
    p.add_argument("--hom-cap", type=int, help="census only the first N partition reps (γ is then a lower bound)"); p.set_defaults(f=cmd_closure)
    p = sub.add_parser("rigid", help="enumerate the k-colourings up to palette and test each for additivity"); stage_args(p)
    p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000); p.add_argument("--cap", type=int, help="colourings up to palette; 0 = unlimited (default 0 up to 300 points, 2000 above)")
    p.add_argument("--pin", type=int, default=0); p.add_argument("--shuffle", dest="seed_", type=int, help="clause-order shuffle seed (a second run)"); p.add_argument("--wall", type=float); p.set_defaults(f=cmd_rigid)
    p = sub.add_parser("free", help="the forced / free / mixed split of the difference classes and the stage's pairs"); stage_args(p)
    p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000); p.set_defaults(f=cmd_free)
    p = sub.add_parser("extend", help="the family delta per pool point (D5 / §M1.5): case, family after, γ after, sampled kills"); stage_args(p)
    p.add_argument("--k", type=int, required=True); p.add_argument("--max", type=int, default=200000); p.add_argument("--pool", required=True); p.add_argument("--pool-key", default="pool")
    p.add_argument("--colourings"); p.add_argument("--max-points", type=int, default=0); p.add_argument("--top", type=int, default=10); p.set_defaults(f=cmd_extend)
    p = sub.add_parser("self-test-rigid", help="additive_rigid's planted controls"); p.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    register(sub)
    a = ap.parse_args()
    if hasattr(a, "seed_"):
        a.seed_val = a.seed_
    a.f(a)


if __name__ == "__main__":
    main()
