#!/usr/bin/env python3
"""fpcompel — the compulsion structure of a finite Euclidean plane, and what it forbids upstream (M60, 2026-09-07).

THE THEOREM (kernel: Proofs/HadwigerNelson/ResidueObstruction.lean, Instances/ResidueObstruction11.lean). A graph G with a
homomorphism f into UD(F_p, 2) inherits every k-colouring of the plane by pullback, so a pair FORCED equal at k colours in G is
forced at its images, and a pair SEPARATED (a virtual edge) is separated at its images. Translations are automorphisms of the
plane, so one colouring table stands for all its translates: a forced pair's residue difference d is a PERIOD of the table, a
virtual edge's a NEVER-COINCIDENT difference. The plane's own compulsions at arity 2 are unions of norm classes (the rotation
group is transitive on every nonzero-norm circle when p ≡ 3 mod 4):
    F_p(k) = {d : every k-colouring identifies 0 and d}    S_p(k) = {d : every k-colouring separates 0 and d} ⊇ N₁ (the circle).
A class is NOT in F as soon as one colouring is not periodic at it (one aperiodic table refutes all), NOT in S as soon as one
colouring coincides at it (a verified colouring is the certificate); a class IS in S only on a solver UNSAT (untrusted).
Consequences upstream, for a certificate reduced at p with a pair at squared distance r: forced ⟹ r ≡ 0, separated ⟹ r ≡ 1
(mod p) when F = {0}, S = N₁. The hex-shell distances √3 and 2 (r = 3, 4) satisfy neither at any p ≥ 5.

    python3 tools/fpcompel.py sets --p 11 --k 5 [--table data/fplane/chi-p11.json]     # F_p(k), S_p(k) by norm class, with evidence per class
    python3 tools/fpcompel.py filter --asks data/m55/ask-W-plus-cross-depth2-k5.json --p 11 --k 5   # re-read every ask by residue
    python3 tools/fpcompel.py filter --heule510 --p 11 --k 5 --pairs "0,1;0,7"          # named pairs of a stage
    python3 tools/fpcompel.py augment --seed --p 11 --k 5                               # the seed's cheats' residue pairs on the plane
    python3 tools/fpcompel.py augment --object LABEL --sidecar build/m51-edges-LABEL+cull149.json --p 11 --k 5
    python3 tools/fpcompel.py self-test

What a record licenses. `sets`: `in_F: false` / `in_S: false` carry a VERIFIED colouring (or the table's own coincidence); `in_S: true`
is the solver's UNSAT and is marked untrusted; the kernel holds p = 11 only. `filter`: every `separated-impossible` /
`forces-impossible` verdict carries the translate t of the table whose pullback v ↦ table(res(v) + t) is VERIFIED proper on the
whole stage and identifies / separates the pair — re-derivable from the record's residues and the table file with no tool.
`augment`: a colouring is verified; an UNSAT is the solver's. UNTRUSTED like everything in tools/."""
from __future__ import annotations
import argparse, itertools, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane as FP

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "fplane"
BUILD = ROOT / "build"


# ---------------------------------------------------------------------- the plane's norm classes
def norm(p: int, v) -> int:
    return (v[0] * v[0] + v[1] * v[1]) % p


def class_reps(p: int) -> dict:
    """One representative per nonzero norm class (each is one rotation orbit when p ≡ 3 mod 4)."""
    reps = {}
    for x in range(p):
        for y in range(p):
            if (x, y) != (0, 0):
                reps.setdefault(norm(p, (x, y)), (x, y))
    return reps


def class_members(p: int, c: int):
    return [(x, y) for x in range(p) for y in range(p) if (x, y) != (0, 0) and norm(p, (x, y)) == c]


def load_table(path: Path, p: int):
    d = json.loads(path.read_text())
    assert d["p"] == p, ("table is for another prime", d["p"], p)
    rows = d["colouring_rows"]
    col = {(x, y): int(rows[x][y]) for x in range(p) for y in range(p)}
    return col, d.get("chi") or d["rows"][-1]["k"]


def is_proper(p: int, col) -> bool:
    circ = FP.circle(p)
    return all(col[(x, y)] != col[((x + a) % p, (y + b) % p)] for x in range(p) for y in range(p) for a, b in circ)


def periodic(p: int, col, d) -> bool:
    return all(col[(x, y)] == col[((x + d[0]) % p, (y + d[1]) % p)] for x in range(p) for y in range(p))


def coincidence(p: int, col, d):
    """A translate t with col(t + d) = col(t), or None."""
    for x in range(p):
        for y in range(p):
            if col[(x, y)] == col[((x + d[0]) % p, (y + d[1]) % p)]:
                return (x, y)
    return None


def difference_witness(p: int, col, d):
    """A translate t with col(t + d) ≠ col(t), or None."""
    for x in range(p):
        for y in range(p):
            if col[(x, y)] != col[((x + d[0]) % p, (y + d[1]) % p)]:
                return (x, y)
    return None


def rows_of(p: int, colouring) -> list:
    return ["".join(str(colouring[x * p + y]) for y in range(p)) for x in range(p)]


# ---------------------------------------------------------------------- sets: F_p(k), S_p(k)
def compulsion_sets(p: int, k: int, table_path: Path | None = None, wall: float | None = None, enumerate_small: bool = True):
    t0 = time.time()
    table_path = table_path or DATA / (f"chi-p{p}.json" if (DATA / f"chi-p{p}.json").exists() else f"chi-p{p}-k{k}.json")
    col, ktab = load_table(table_path, p)
    assert ktab == k, ("the table's colour count is not k", ktab, k)
    assert is_proper(p, col), "INSTRUMENT CATASTROPHE: the stored table is not a proper colouring"
    E, deg = FP.ud_edges(p); n = p * p
    reps = class_reps(p)
    periods = [(x, y) for x in range(p) for y in range(p) if (x, y) != (0, 0) and periodic(p, col, (x, y))]
    classes = {}
    exact_all = None
    if enumerate_small and n <= 16:
        # every proper k-colouring, exhaustively — the exact sets, no solver
        exact_all = [c for c in itertools.product(range(k), repeat=n) if all(c[u] != c[v] for u, v in E)]
    for c, rep in sorted(reps.items()):
        rec = {"rep": list(rep), "size": len(class_members(p, c))}
        vd = rep[0] * p + rep[1]
        # F: the class is identified by every colouring?
        if not periodic(p, col, rep):
            rec.update(in_F=False, evidence_F="table", witness_F=list(difference_witness(p, col, rep)))
        elif exact_all is not None:
            sep = next((cc for cc in exact_all if cc[0] != cc[vd]), None)
            rec.update(in_F=sep is None, evidence_F="enumeration", colouring_F=rows_of(p, sep) if sep else None)
        else:
            st, cc = FP.colourable(n, E, k, wall=wall, pins=[(0, 0), (vd, 1)])
            rec.update(in_F=(st == "unsat"), evidence_F={"sat": "colouring", "unsat": "solver-unsat (untrusted)", "unknown": "unknown"}[st],
                       colouring_F=rows_of(p, cc) if cc else None)
        # S: the class is separated by every colouring?
        if c == 1:
            rec.update(in_S=True, evidence_S="properness (the circle is the edge set)")
        else:
            hit = None
            for m in class_members(p, c):
                t = coincidence(p, col, m)
                if t is not None:
                    hit = (m, t); break
            if hit is not None:
                rec.update(in_S=False, evidence_S="table", witness_S={"member": list(hit[0]), "translate": list(hit[1])})
            elif exact_all is not None:
                idn = next((cc for cc in exact_all if cc[0] == cc[vd]), None)
                rec.update(in_S=idn is None, evidence_S="enumeration", colouring_S=rows_of(p, idn) if idn else None)
            else:
                st, cc = FP.colourable(n, E, k, wall=wall, pins=[(0, 0), (vd, 0)])
                if st == "sat":
                    assert cc[0] == cc[vd], "INSTRUMENT CATASTROPHE: the pinned model does not identify the pair"
                rec.update(in_S=(st == "unsat"), evidence_S={"sat": "colouring", "unsat": "solver-unsat (untrusted)", "unknown": "unknown"}[st],
                           colouring_S=rows_of(p, cc) if cc else None)
        classes[c] = rec
    F = [c for c, r in classes.items() if r["in_F"]]; S = [c for c, r in classes.items() if r["in_S"]]
    unk = [c for c, r in classes.items() if r.get("evidence_F") == "unknown" or r.get("evidence_S") == "unknown"]
    nS_tab = sum(1 for r in classes.values() if r.get("evidence_S") == "table")
    nS_col = sum(1 for r in classes.values() if r.get("evidence_S") in ("colouring", "enumeration") and not r["in_S"])
    nS_uns = sum(1 for c, r in classes.items() if r["in_S"] and c != 1)
    rec = dict(kind="fplane-compulsions", p=p, k=k, table_file=str(table_path.relative_to(ROOT)) if table_path.is_relative_to(ROOT) else str(table_path),
               n=n, degree=deg, norm_classes=len(reps), table_proper=True, table_periods=[list(d) for d in periods],
               table_aperiodic=not periods, classes={str(c): r for c, r in classes.items()}, F_classes=F, S_classes=S, unknown_classes=unk,
               exact_by_enumeration=exact_all is not None, proper_colourings_enumerated=len(exact_all) if exact_all is not None else None,
               seconds=round(time.time() - t0, 1),
               claim_scope="F: a class is OUT on one verified colouring not periodic at it (the table, or a solver model), IN only on the solver's UNSAT "
                           "(untrusted) or, at p*p ≤ 16, by exhaustive enumeration; S: OUT on a verified coincidence (table member or solver model), "
                           "IN on UNSAT (untrusted) or enumeration; the circle (norm 1) is IN by properness. The kernel holds p = 11 only.")
    line = (f"[fpcompel] p={p} k={k}: F = {{0}}{' ∪ ' + str(F) if F else ''}, S = N₁{' ∪ ' + str([c for c in S if c != 1]) if len(S) > 1 else ''} of {len(reps)} norm classes; "
            f"F by {'the table (aperiodic)' if not periods else 'per-class evidence (the table has ' + str(len(periods)) + ' periods)'}; "
            f"S: {nS_tab + nS_col} classes identified by verified colourings (table {nS_tab}, {'enumeration' if exact_all is not None else 'solver'} {nS_col}), "
            f"{nS_uns} {'by enumeration' if exact_all is not None else 'solver-UNSAT (untrusted)'}{'; UNKNOWN ' + str(unk) if unk else ''}; {rec['seconds']}s")
    return rec, line


def cmd_sets(a):
    rec, line = compulsion_sets(a.p, a.k, Path(a.table) if a.table else None, a.wall)
    print(line)
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"compulsions-p{a.p}-k{a.k}.json"
    path.write_text(json.dumps(rec, indent=1)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- stages, reduced
def roots_for(rads, p: int) -> dict:
    return {d: FP.sqrt_mod(d, p) for d in rads}


def reduce_chunk(ch, p: int):
    """Residues of a chunk at a degree-one prime above p; every unit edge must land on the circle (the homomorphism check)."""
    fr = ch.frame.name
    if fr.startswith("field16"):
        rads = ch.frame.primes
    elif fr == "EI4" or fr == "K8":
        rads = [3, 11]
    elif fr.startswith("K") and fr.endswith("-16"):
        rads = [3, 11, int(fr[1:-3])]
    else:
        raise SystemExit(f"fpcompel: frame {fr} not handled")
    roots = {}
    for d in rads:
        r = FP.sqrt_mod(d, p)
        if r is None:
            raise SystemExit(f"fpcompel: the stage carries √{d}, which has no residue modulo {p} ({d} is a non-residue): {p} is not usable for this stage")
        roots[d] = r
    red = FP.reduce_stage(ch, p, roots)
    onc = sum(1 for u, v in ch.edges if norm(p, ((red[u][0] - red[v][0]) % p, (red[u][1] - red[v][1]) % p)) == 1)
    assert onc == len(ch.edges), f"INSTRUMENT CATASTROPHE: {len(ch.edges) - onc} of {len(ch.edges)} unit edges are NOT on the circle mod {p}"
    return red, roots


def q4_to_mp(A, B, m: int, dps: int):
    """A + √m·B with A, B over (1, √3, √11, √33) as (num, den) pairs → mpf."""
    import mpmath as mp
    mp.mp.dps = dps
    s3, s11 = mp.sqrt(3), mp.sqrt(11); s33 = s3 * s11
    basis = [mp.mpf(1), s3, s11, s33]
    a = sum(mp.mpf(n_) / d_ * b for (n_, d_), b in zip(A, basis)); b = sum(mp.mpf(n_) / d_ * bb for (n_, d_), bb in zip(B, basis))
    return a + mp.sqrt(m) * b


def assemble_ask_stage(ask_path: Path):
    """The M55 ask stage (W ∪ P₁ ∪ P₂ in K(√247)) as an exact chunk in graph order: each graph point (a 60-digit decimal)
    matched to an exact candidate from the three records. Refuses if any point is unmatched."""
    import additive as AD
    import mpmath as mp
    d = json.loads(ask_path.read_text()); st = d["stage"]
    gpath = ROOT / st["source"].split("graph ", 1)[1] if st["source"].startswith("graph ") else ROOT / st["source"]
    g = json.loads(gpath.read_text())
    n = g["n"]; pts = g["points"]; edges = [tuple(e) for e in g["edges"]]
    ex = json.loads((ROOT / st["exact"]).read_text()); cross = json.loads(Path(st["cross"] if st["cross"].startswith("/") else ROOT / st["cross"]).read_text())
    cross2 = json.loads(Path(st["cross2"] if st["cross2"].startswith("/") else ROOT / st["cross2"]).read_text())
    m = ex["m"]; dps = 60
    cands = []
    for P in ex["points"]:
        (xA, xB), (yA, yB) = P; cands.append((tuple(map(tuple, xA)) + tuple(map(tuple, xB)) + tuple(map(tuple, yA)) + tuple(map(tuple, yB))))
    for pool in (cross["pool"], cross2["pool"]):
        for P in pool:
            xA, xB = P["x"]; yA, yB = P["y"]
            cands.append(tuple(map(tuple, xA)) + tuple(map(tuple, xB)) + tuple(map(tuple, yA)) + tuple(map(tuple, yB)))
    mp.mp.dps = dps
    key = {}
    for c in cands:
        x = q4_to_mp(c[0:4], c[4:8], m, dps); y = q4_to_mp(c[8:12], c[12:16], m, dps)
        key[(mp.nstr(x, 40), mp.nstr(y, 40))] = c
    exact_pts = []; missing = []
    for i, (xs, ys) in enumerate(pts):
        kk = (mp.nstr(mp.mpf(xs), 40), mp.nstr(mp.mpf(ys), 40))
        if kk in key:
            exact_pts.append(tuple(Fr(n_, d_) for n_, d_ in key[kk]))
        else:
            missing.append(i)
    if missing:
        raise SystemExit(f"fpcompel: {len(missing)} of {n} stage points have no exact candidate in {st['exact']}, {st['cross']}, {st['cross2']} (first {missing[:5]})")
    ch = AD.Chunk(st["name"], exact_pts, edges, AD.FrameKExt16(m), f"assembled exactly from {st['exact']} + the two cross-lattice pools, matched to the graph's 60-digit points at 40 digits", "exact records")
    return ch, d


def load_stage(a):
    import additive as AD
    if getattr(a, "asks", None):
        ch, ask = assemble_ask_stage(Path(a.asks)); return ch, ask
    for k_ in ("seed", "object", "witness", "heule510", "degrey", "field16", "graph", "planted"):
        if not hasattr(a, k_): setattr(a, k_, None)
    return AD.load_chunk(a), None


# ---------------------------------------------------------------------- filter: the residue verdict per pair
def pullback(p: int, col, red, shift):
    return [col[((r[0] + shift[0]) % p, (r[1] + shift[1]) % p)] for r in red]


def verify_colouring(edges, c) -> bool:
    return all(c[u] != c[v] for u, v in edges)


def residue_filter(ch, p: int, k: int, pairs, table_path: Path | None = None, sets_rec=None):
    t0 = time.time()
    table_path = table_path or DATA / (f"chi-p{p}.json" if (DATA / f"chi-p{p}.json").exists() else f"chi-p{p}-k{k}.json")
    col, ktab = load_table(table_path, p); assert ktab == k
    red, roots = reduce_chunk(ch, p)
    S = set(sets_rec["S_classes"]) if sets_rec else {1}
    F = set(sets_rec["F_classes"]) if sets_rec else set()
    out = []
    for item in pairs:
        u, v = item["pair"]; ru, rv = red[u], red[v]
        dd = ((rv[0] - ru[0]) % p, (rv[1] - ru[1]) % p); c = norm(p, dd)
        r = dict(pair=[u, v], residues=[list(ru), list(rv)], difference=list(dd), norm=c)
        if "polarity" in item: r["polarity"] = item["polarity"]
        if "verdict" in item: r["prior_verdict"] = item["verdict"]
        verdicts = []
        if dd == (0, 0):
            verdicts.append("same-residue (every pullback identifies the pair; a virtual edge is impossible)")
            t = (0, 0); cc = pullback(p, col, red, ((t[0] - ru[0]) % p, (t[1] - ru[1]) % p))
            r.update(separated_impossible=True, forces_allowed=True, translate=[(t[0] - ru[0]) % p, (t[1] - ru[1]) % p],
                     pullback_proper=verify_colouring(ch.edges, cc), pullback_identifies=(cc[u] == cc[v]))
        else:
            if c not in F:
                t = difference_witness(p, col, dd)
                sh = ((t[0] - ru[0]) % p, (t[1] - ru[1]) % p); cc = pullback(p, col, red, sh)
                r.update(forces_impossible=True, translate_separating=list(sh), pullback_sep_proper=verify_colouring(ch.edges, cc), pullback_separates=(cc[u] != cc[v]))
                verdicts.append("forces-impossible")
            if c not in S:
                t = coincidence(p, col, dd)
                if t is None:
                    r.update(separated_impossible=None, note=f"norm {c} is not in S by the sets record but this table has no coincidence at the difference; a per-class colouring would be needed")
                else:
                    sh = ((t[0] - ru[0]) % p, (t[1] - ru[1]) % p); cc = pullback(p, col, red, sh)
                    r.update(separated_impossible=True, translate=list(sh), pullback_proper=verify_colouring(ch.edges, cc), pullback_identifies=(cc[u] == cc[v]))
                    assert r["pullback_proper"] and r["pullback_identifies"], "INSTRUMENT CATASTROPHE: the pullback is not a proper identifying colouring"
                    verdicts.append("separated-impossible")
            else:
                verdicts.append(f"separated-allowed (norm {c} ∈ S)")
        r["verdict"] = verdicts
        # against an ask's polarity
        pol = item.get("polarity")
        if pol == "ne":
            r["ask_reading"] = "refuted by residue (a verified uniting colouring)" if r.get("separated_impossible") else "residue-allowed"
        elif pol == "eq":
            r["ask_reading"] = "refuted by residue (a verified separating colouring)" if r.get("forces_impossible") else "residue-allowed"
        out.append(r)
    rec = dict(kind="fplane-residue-filter", stage=ch.header(), p=p, k=k, table_file=str(table_path.relative_to(ROOT)), roots=roots,
               residues=[list(x) for x in red], distinct_residues=len(set(red)), S_classes=sorted(S), F_classes=sorted(F), pairs=out,
               seconds=round(time.time() - t0, 1),
               claim_scope="per pair: the residue difference's norm; separated-impossible / forces-impossible carry the translate of the table whose pullback "
                           "v ↦ table(res(v) + translate) is VERIFIED proper on every edge of the stage and identifies / separates the pair — re-derivable from "
                           "`residues` and `table_file` with no tool; residue-allowed means the theorem is silent (it never says a compulsion EXISTS)")
    return rec


def cmd_filter(a):
    ch, ask = load_stage(a)
    sets_rec = None
    sp = DATA / f"compulsions-p{a.p}-k{a.k}.json"
    if sp.exists():
        sets_rec = json.loads(sp.read_text())
    if ask:
        pairs = [dict(pair=r["pair"], polarity=r["polarity"], verdict=r["verdict"]) for r in ask["results"]]
    else:
        pairs = [dict(pair=[int(x) for x in s.split(",")]) for s in a.pairs.split(";") if s.strip()]
    rec = residue_filter(ch, a.p, a.k, pairs, Path(a.table) if a.table else None, sets_rec)
    if ask:
        rec["ask_file"] = a.asks
        unk = [r for r in rec["pairs"] if r.get("prior_verdict") == "unknown"]
        settled = [r for r in unk if r.get("ask_reading", "").startswith("refuted")]
        ref = [r for r in rec["pairs"] if r.get("prior_verdict") == "refuted"]
        ref_res = [r for r in ref if r.get("ask_reading", "").startswith("refuted")]
        rec["summary"] = dict(asks=len(rec["pairs"]), unknown=len(unk), unknown_settled_by_residue=len(settled),
                              unknown_residue_allowed=len(unk) - len(settled), refuted=len(ref), refuted_also_by_residue=len(ref_res),
                              norms_of_unknown={str(c): sum(1 for r in unk if r["norm"] == c) for c in sorted(set(r["norm"] for r in unk))})
        print(f"[fpcompel] {ch.label()} at p={a.p}, k={a.k}: {len(rec['pairs'])} asks; of the {len(unk)} UNDECIDED, {len(settled)} are settled by residue "
              f"(each with a verified colouring), {len(unk) - len(settled)} residue-allowed (norm 1); of the {len(ref)} solver-refuted, {len(ref_res)} are also refuted by residue; {rec['seconds']}s")
    else:
        for r in rec["pairs"]:
            print(f"  pair {r['pair']}: residues {r['residues']}, norm {r['norm']}: {r['verdict']}")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"residue-filter-{ch.name}-p{a.p}.json"
    path.write_text(json.dumps(rec, indent=1)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- augment: the cheats' residue pairs on the plane
def seed_with_cheats():
    import twodist as T, additive as AD
    H = T.ei_H(); cls = T.classify(H, radii=(1, 4))
    A, B = H.index(T.EI_A), H.index(T.EI_B)
    ch = AD.load_seed()
    return ch, [tuple(e) for e in cls[4]], A, B, "EI-seed"


def object_with_cheats(label: str, sidecar: Path):
    import additive as AD
    ch = AD.load_object(label)
    live_ids = ch.meta["live_index_of_object"]; idx = {v: i for i, v in enumerate(live_ids)}
    sc = json.loads(sidecar.read_text())
    removed = set(map(tuple, sc["removed"])); cheats_live = [tuple(e) for e in sc["cheats"]]
    standing = [e for e in cheats_live if e not in removed]
    A, B = ch.meta["forced_pair"]
    return ch, [(idx[u], idx[v]) for u, v in standing], A, B, f"object-{label[-24:]}-standing{len(standing)}", [(idx[u], idx[v]) for u, v in cheats_live]


def augment(ch, cheats, A, B, p: int, k: int, wall: float | None, table_path: Path | None = None):
    t0 = time.time()
    red, roots = reduce_chunk(ch, p)
    E, deg = FP.ud_edges(p); n = p * p
    idx = lambda r: r[0] * p + r[1]
    same = [(u, v) for u, v in cheats if red[u] == red[v]]
    extra = sorted({(min(idx(red[u]), idx(red[v])), max(idx(red[u]), idx(red[v]))) for u, v in cheats if red[u] != red[v]})
    extra_new = [e for e in extra if e not in set(E)]
    norms = {}
    for u, v in cheats:
        c = norm(p, ((red[v][0] - red[u][0]) % p, (red[v][1] - red[u][1]) % p)); norms[c] = norms.get(c, 0) + 1
    rec = dict(kind="fplane-augment", stage=ch.header(), p=p, k=k, roots=roots, cheats=len(cheats), forced_pair=[A, B],
               forced_pair_residues=[list(red[A]), list(red[B])], forced_pair_norm=norm(p, ((red[B][0] - red[A][0]) % p, (red[B][1] - red[A][1]) % p)),
               cheat_residue_norms={str(c): v for c, v in sorted(norms.items())}, cheats_same_residue=len(same), distinct_cheat_residue_pairs=len(extra),
               new_augmenting_pairs=len(extra_new))
    if same:
        rec.update(colourable=False, reason="a cheat's endpoints share a residue: no pullback is proper on the cheats", seconds=round(time.time() - t0, 1))
        line = f"[fpcompel] augment {ch.label()} at p={p}: {len(same)} of {len(cheats)} cheats have EQUAL residues — no pullback colouring is proper on the {{1,2}}-graph"
        return rec, line
    EA = sorted(set(E) | set(extra_new))
    st, cc = FP.colourable(n, EA, k, wall=wall, pins=[(0, 0)])
    rec.update(augmented_edges=len(EA), colourable={"sat": True, "unsat": False, "unknown": None}[st], colourable_evidence={"sat": "verified colouring", "unsat": "solver-unsat (untrusted)", "unknown": "unknown"}[st])
    if st == "sat":
        rec["colouring_rows"] = rows_of(p, cc)
        # does every proper pullback identify r(A), r(B)?  pin them apart
        rA, rB = idx(red[A]), idx(red[B])
        if rA == rB:
            rec.update(identifies_forced_pair=True, identifies_evidence="equal residues")
        else:
            st2, cc2 = FP.colourable(n, EA, k, wall=wall, pins=[(rA, 0), (rB, 1)])
            rec.update(identifies_forced_pair={"unsat": True, "sat": False, "unknown": None}[st2],
                       identifies_evidence={"unsat": "solver-unsat (untrusted)", "sat": "a separating colouring EXISTS", "unknown": "unknown"}[st2])
            if st2 == "sat":
                pull = [cc2[idx(r)] for r in red]
                proper_unit = verify_colouring(ch.edges, pull); proper_cheats = all(pull[u] != pull[v] for u, v in cheats)
                rec.update(separating_colouring_rows=rows_of(p, cc2), pullback_proper_on_unit=proper_unit, pullback_proper_on_cheats=proper_cheats,
                           pullback_separates=pull[A] != pull[B])
                assert not (proper_unit and proper_cheats and pull[A] != pull[B]), \
                    "INSTRUMENT CATASTROPHE: a proper pullback of the {1,2}-graph separates the certified forced pair"
    rec["seconds"] = round(time.time() - t0, 1)
    rec["claim_scope"] = ("the plane at p augmented by the cheats' residue pairs (each cheat's two residues joined); colourable on a verified colouring or the "
                          "solver's UNSAT (untrusted); identifies_forced_pair on the solver's UNSAT of the pinned-apart instance (untrusted) — a SAT there "
                          "would be a proper pullback separating the forced pair, which the certified forcing forbids (asserted)")
    line = (f"[fpcompel] augment {ch.label()} at p={p}, k={k}: {len(cheats)} cheats → {len(extra)} distinct residue pairs "
            f"(norms {rec['cheat_residue_norms']}), {len(extra_new)} new on the plane; forced pair residues norm {rec['forced_pair_norm']}; "
            f"augmented plane {k}-colourable: {rec['colourable']} ({rec['colourable_evidence']})"
            + (f"; every {k}-colouring identifies r(A), r(B): {rec['identifies_forced_pair']} ({rec['identifies_evidence']})" if st == "sat" else "")
            + f"; {rec['seconds']}s")
    return rec, line


def cmd_augment(a):
    if a.seed:
        ch, cheats, A, B, name = seed_with_cheats(); allc = None
    else:
        ch, cheats, A, B, name, allc = object_with_cheats(a.object, Path(a.sidecar))
    rec, line = augment(ch, cheats, A, B, a.p, a.k, a.wall); print(line)
    if allc is not None and a.all_live:
        rec2, line2 = augment(ch, allc, A, B, a.p, a.k, a.wall); print(line2); rec["all_live_cheats"] = rec2
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"augment-{name}-p{a.p}.json"
    path.write_text(json.dumps(rec, indent=1)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- self-test
def self_test():
    fails = []
    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}")
        if not cond:
            fails.append(name)
    print("[self-test] fpcompel: planted controls")
    col11, _ = load_table(DATA / "chi-p11.json", 11)
    per = [(x, y) for x in range(11) for y in range(11) if (x, y) != (0, 0) and periodic(11, col11, (x, y))]
    nev = [(x, y) for x in range(11) for y in range(11) if (x, y) != (0, 0) and coincidence(11, col11, (x, y)) is None]
    check("the kernel's table at 11: no period; never-coincident differences = the 12 circle points", not per and len(nev) == 12 and all(norm(11, d) == 1 for d in nev))
    # a planted periodic proper colouring: the coset colouring of the 3-plane's table has period (1,1)
    col3, _ = load_table(DATA / "chi-p3.json", 3)
    check("planted: the 3-plane's table (x + y mod 3) is proper AND periodic at (1,2) (Aperiodic is a real property)", is_proper(3, col3) and periodic(3, col3, (1, 2)) and not periodic(3, col3, (1, 1)))
    # a corrupted table is refused
    bad = dict(col11); bad[(0, 0)] = bad[(0, 1)]
    check("planted red: a corrupted table (origin recoloured like its neighbour) is not proper", not is_proper(11, bad))
    # the exact sets at 3 by enumeration agree with the pinned-SAT path
    r3, _ = compulsion_sets(3, 3, enumerate_small=True); r3s, _ = compulsion_sets(3, 3, enumerate_small=False)
    check("p = 3: enumeration and the pinned-SAT path agree class by class (F = {}, S = {1})",
          r3["F_classes"] == r3s["F_classes"] == [] and r3["S_classes"] == r3s["S_classes"] == [1])
    # the seed: a cheat (norm 4) is separated-impossible with a verified uniting colouring; a unit edge is residue-allowed
    ch, cheats, A, B, _ = seed_with_cheats()
    rec = residue_filter(ch, 11, 5, [dict(pair=list(cheats[0])), dict(pair=list(ch.edges[0])), dict(pair=[A, B])])
    c0, e0, ab = rec["pairs"]
    check(f"seed cheat {cheats[0]}: norm 4, separated-impossible, pullback verified proper on 1,004 edges and identifying",
          c0["norm"] == 4 and c0.get("separated_impossible") is True and c0["pullback_proper"] and c0["pullback_identifies"])
    check(f"seed unit edge {ch.edges[0]}: norm 1, separated-allowed, forces-impossible", e0["norm"] == 1 and "forces-impossible" in e0["verdict"] and any(v.startswith("separated-allowed") for v in e0["verdict"]))
    check("seed forced pair (A, B) at distance 5: norm 25 ≡ 3 — forces-impossible AND separated-impossible on the unit part", ab["norm"] == 3 and ab.get("forces_impossible") and ab.get("separated_impossible"))
    # planted red: a wrong residue for √3 breaks the homomorphism check
    import additive as AD
    try:
        FP.reduce_stage(ch, 11, {3: 4, 11: 0}); red_bad = FP.reduce_stage(ch, 11, {3: 4, 11: 0})
        onc = sum(1 for u, v in ch.edges if norm(11, ((red_bad[u][0] - red_bad[v][0]) % 11, (red_bad[u][1] - red_bad[v][1]) % 11)) == 1)
        check(f"planted red: a wrong root for √3 leaves only {onc} of {len(ch.edges)} seed edges on the circle", onc < len(ch.edges))
    except AssertionError as e:
        check("planted red: a wrong root is refused", True)
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("sets"); s.add_argument("--p", type=int, required=True); s.add_argument("--k", type=int, required=True); s.add_argument("--table"); s.add_argument("--wall", type=float); s.add_argument("--out"); s.set_defaults(f=cmd_sets)
    s = sub.add_parser("filter")
    for k_ in ("seed", "heule510", "degrey"): s.add_argument(f"--{k_}", action="store_true")
    for k_ in ("object", "witness", "field16", "graph", "planted", "asks", "pairs", "table", "out"): s.add_argument(f"--{k_}")
    s.add_argument("--p", type=int, required=True); s.add_argument("--k", type=int, required=True); s.set_defaults(f=cmd_filter)
    s = sub.add_parser("augment"); s.add_argument("--seed", action="store_true"); s.add_argument("--object"); s.add_argument("--sidecar"); s.add_argument("--all-live", action="store_true")
    s.add_argument("--p", type=int, required=True); s.add_argument("--k", type=int, required=True); s.add_argument("--wall", type=float); s.add_argument("--out"); s.set_defaults(f=cmd_augment)
    s = sub.add_parser("self-test"); s.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))
    a = ap.parse_args(); a.f(a)


if __name__ == "__main__":
    main()
