#!/usr/bin/env python3
"""fplane — the finite Euclidean plane UD(F_p, 2) as an upper bound on χ of number-field planes (2026-09-06, the
web-session analysis in reference/Chat-analysis/, VERIFIED here).

THE THEOREM (checked by hand, §VERIFICATION.md). F ⊂ ℝ a number field, p ≡ 3 (mod 4), 𝔭 a prime of F above p with
residue field F_p (or F_{p^f}, f odd). Then 𝔭 is inert in F(i) (−1 is not a square in F_p), complex conjugation reduces
to Frobenius, a unit vector z (z z̄ = 1) is 𝔓-integral, and reducing a finite unit-distance graph in F² (translated so a
vertex is 0) sends adjacent vertices to points of F_p² whose difference lies on the circle a² + b² = 1. So the reduction
is a graph homomorphism into UD(F_p, 2) := Cay(F_p², {a² + b² = 1}) and χ(F²) ≤ χ(UD(F_p, 2)). The residue colouring of
Theorem B / Fischer coloured F_p² LINEARLY (a line missing the circle: p colours); the plane's own chromatic number is
smaller — χ(UD(F_11, 2)) = 5 — and that is the step past the additive method.

    python3 tools/fplane.py chi --p 11 [--k 5]                 # χ(UD(F_p,2)) by SAT: k−1 UNSAT, k SAT (verified)
    python3 tools/fplane.py usable --rads 3,5,11 [--bound 600] # the usable primes of Q(√3,√5,√11): p ≡ 3 mod 4, every radicand a square or 0 mod p
    python3 tools/fplane.py reduce --heule510 --p 11           # reduce a stage mod a degree-one prime above p, check every unit edge lands on the circle,
                                                               # pull a colouring of UD(F_p,2) back and verify it proper on the stage
    python3 tools/fplane.py spectral --p 131 | --all-below 600         # D6: λ_min, the Kloosterman identity, Hoffman's floor χ ≥ 1 + (p+1)/(−λ_min)
    python3 tools/fplane.py shadow --degrey --p 131 [--k 5]           # D7: the stage's direction residues; χ(Cay(F_p², D)) by spectral floor and SAT
    python3 tools/fplane.py map [--fields NAME:d1,d2;…]                # the field table: wall, usable primes, sealing prime, verdict
    python3 tools/fplane.py self-test

What a record licenses: `chi` = the solver's UNSAT (untrusted) plus a VERIFIED colouring; `reduce` = an exact check that
the stage's edges land on the circle (a certificate of the homomorphism for that stage) and a VERIFIED pulled-back
colouring (a certificate that χ(stage) ≤ k). UNTRUSTED like everything in tools/."""
from __future__ import annotations
import argparse, hashlib, json, math, sys, time
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "fplane"


# ---------------------------------------------------------------------- the finite plane
def circle(p: int):
    return [(a, b) for a in range(p) for b in range(p) if (a * a + b * b) % p == 1]


def ud_edges(p: int):
    circ = circle(p); E = set()
    for x in range(p):
        for y in range(p):
            for a, b in circ:
                u, v = x * p + y, ((x + a) % p) * p + (y + b) % p
                E.add((min(u, v), max(u, v)))
    return sorted(E), len(circ)


def colourable(n: int, E, k: int, wall: float | None = None, pins=None):
    """(status, colouring): SAT with a verified colouring, UNSAT, or unknown (wall). One-hot; `pins` is a list of
    (vertex, colour) fixed by symmetry (default: vertex 0 → 0 and its first neighbour → 1, sound on any
    vertex-transitive graph; a clique's colours, `clique_pins`, break the whole palette symmetry)."""
    from pysat.solvers import Solver
    var = lambda v, c: v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(n)]
    cl += [[-var(v, c1), -var(v, c2)] for v in range(n) for c1 in range(k) for c2 in range(c1 + 1, k)]
    cl += [[-var(u, c), -var(v, c)] for u, v in E for c in range(k)]
    if pins is None:
        pins = [(0, 0)]
        nb = next((v for u, v in E if u == 0), None)
        if nb is not None and k > 1:
            pins.append((nb, 1))
    for v, c in pins:
        if c < k:
            cl.append([var(v, c)])
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        if wall:
            import threading
            timer = threading.Timer(wall, lambda: s.interrupt()); timer.start()
            r = s.solve_limited(expect_interrupt=True); timer.cancel()
        else:
            r = s.solve()
        m = s.get_model() if r else None
    if r is None:
        return "unknown", None
    if not r:
        return "unsat", None
    col = [next(c for c in range(k) if m[var(v, c) - 1] > 0) for v in range(n)]
    bad = [(u, v) for u, v in E if col[u] == col[v]]
    assert not bad, ("INSTRUMENT CATASTROPHE: the solver's colouring is not proper", bad[:3])
    return "sat", col


def clique_pins(p: int):
    """A maximal clique of UD(F_p,2) through the origin (ω ≤ 3 on every plane probed) as (vertex, colour) pins."""
    circ = circle(p); adjc = {c: {d for d in circ if d != c and ((c[0] - d[0]) ** 2 + (c[1] - d[1]) ** 2) % p == 1} for c in circ}
    best = []
    def ext(cl, cands):
        nonlocal best
        if len(cl) > len(best):
            best = list(cl)
        for i, v in enumerate(cands):
            ext(cl + [v], [w for w in cands[i + 1:] if w in adjc[v]])
    ext([], sorted(circ))
    verts = [0] + [a * p + b for a, b in best]
    return [(v, i) for i, v in enumerate(verts)], len(verts)


def carry_prior_rows(out, path):
    """Rows for k values THIS run did not ask are carried from the record already at `path`, loudly and with
    their provenance.  Why: a null at a conflict budget is expensive (the k = 5 row at q = 27 cost 2,327.6 s of
    one core) and re-running it is not free, but dropping it would delete the measurement the window table
    cites.  Three guards, so a carry can never flatter a verdict: the prior record must be the SAME GRAPH (same
    q and the same edges_sha256, a mismatch carries nothing and says so); a `sat` row is never carried (a
    colouring claim must arrive with the colouring that was verified, not as a row); and `chi` / `exact` are
    NOT recomputed over the union -- they describe this run's own rows, so a carried refusal cannot turn an
    inexact verdict exact."""
    if not path.exists():
        return out
    try:
        prev = json.loads(path.read_text())
    except (json.JSONDecodeError, OSError) as e:
        print(f"  [carry] {path.name} is unreadable ({e}); nothing carried")
        return out
    same_hash = prev.get("q") == out.get("q") and prev.get("edges_sha256") == out.get("edges_sha256")
    # Records written before the hash was carried have no edges_sha256.  For a COLOURABILITY row an isomorphic
    # graph is enough (k-colourability is isomorphism-invariant), so the legacy test is the structural one --
    # same q, modulus, vertex count, edge count and degree -- and it says out loud that it is the weaker test.
    legacy = (not same_hash and prev.get("edges_sha256") is None
              and all(prev.get(f) == out.get(f) for f in ("q", "modulus", "n", "edges", "degree")))
    if not (same_hash or legacy):
        print(f"  [carry] {path.name} is a different graph (q, edges_sha256 or shape differ): nothing carried, the record holds only this run's rows")
        return out
    if legacy:
        print(f"  [carry] {path.name} predates edges_sha256; matched structurally instead (q, modulus, n, edges, degree all agree), which is enough for colourability rows")
    asked = {r["k"] for r in out["rows"]}
    note = ("a row of the PREVIOUS VERSION OF THIS RECORD (the tool reads the file it is about to rewrite), not re-run here; "
            "its conflict budget is whatever that run used and is not recorded per row"
            + ("; that record predates edges_sha256, so the graphs were matched structurally (q, modulus, n, edges, degree), not by hash" if legacy else ""))
    carried = [dict(r, carried_from=f"{path.name} (the previous version of this record)", carried_note=note)
               for r in prev.get("rows", []) if r["k"] not in asked and r["status"] != "sat"]
    for r in carried:
        print(f"  [carry] k={r['k']} {r['status'].upper()} at {r['seconds']}s carried from {path.name} (not re-run)")
    if carried:
        out["rows"] = sorted(out["rows"] + carried, key=lambda r: r["k"])
        out["carried_rows"] = len(carried)
    return out


def cmd_chi(a):
    if getattr(a, "q", None):
        out = chi_q(a.q, a.k, a.conf)
        DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"chi-q{a.q}.json"
        out = carry_prior_rows(out, path)
        path.write_text(json.dumps(out, indent=1)); print(f"  wrote {path}")
        return out
    p = a.p; E, deg = ud_edges(p); n = p * p
    ks = [a.k] if a.k else list(range(2, p + 2))
    pins, omega = (clique_pins(p) if a.pin_clique else (None, None))
    out = dict(kind="fplane-chi", p=p, n=n, edges=len(E), degree=deg, omega=omega, pins=pins, rows=[])
    t0 = time.time(); chi = None
    for k in ks:
        st, col = colourable(n, E, k, wall=a.wall, pins=pins)
        out["rows"].append(dict(k=k, status=st, seconds=round(time.time() - t0, 1)))
        print(f"[fplane] UD(F_{p},2): n={n} deg={deg} k={k}: {st} [{time.time() - t0:.1f}s]", flush=True)
        if st == "sat":
            chi = k; out["colouring"] = col
            out["colouring_rows"] = ["".join(str(col[x * p + y]) for y in range(p)) for x in range(p)]
            break
        if st == "unknown":
            break
    prev = [r for r in out["rows"] if r["status"] == "unsat"]
    exact = chi is not None and any(r["k"] == chi - 1 for r in prev)
    out["chi"] = chi; out["exact"] = exact
    out["claim_scope"] = ("chi = k when k−1 is the solver's UNSAT (untrusted) and k carries a colouring verified proper here (a certificate of ≤ k); "
                          "with --k only the given k is asked")
    last = out["rows"][-1]
    if chi:
        print(f"[fplane] χ(UD(F_{p},2)) {'=' if exact else '≤'} {chi}: {n} vertices, degree {deg}; the {chi}-colouring verified proper" + (f"; {chi - 1} refused by the solver (its claim)" if exact else ""))
    elif last["status"] == "unsat":
        print(f"[fplane] UD(F_{p},2): {n} vertices, degree {deg}: k = {last['k']} REFUSED by the solver after {last['seconds']} s (its claim, untrusted) — χ ≥ {last['k'] + 1}")
    else:
        print(f"[fplane] UD(F_{p},2): {n} vertices, degree {deg}: k = {last['k']} UNDECIDED at the wall ({last['seconds']} s)")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"chi-p{p}.json"
    path.write_text(json.dumps(out, indent=1)); print(f"  wrote {path}")
    return out


# ---------------------------------------------------------------------- the sieve
def legendre(x: int, p: int) -> int:
    x %= p
    return 0 if x == 0 else (1 if pow(x, (p - 1) // 2, p) == 1 else -1)


def is_prime(n: int) -> bool:
    return n > 1 and all(n % d for d in range(2, int(n ** 0.5) + 1))


def usable(rads, bound: int = 600):
    """p ≡ 3 (mod 4) with every radicand a square or 0 mod p: a degree-one prime above p exists in the multiquadratic
    field (each √d reduces to a residue), and F_p has no √−1, so the theorem applies."""
    return [p for p in range(3, bound) if is_prime(p) and p % 4 == 3 and all(legendre(d, p) >= 0 for d in rads)]


def cmd_usable(a):
    rads = [int(x) for x in a.rads.split(",")]
    u = usable(rads, a.bound)
    print(f"[fplane] Q(√{', √'.join(map(str, rads))}): usable primes below {a.bound}: {u}")
    return u


# ---------------------------------------------------------------------- the reduction of a stage
def sqrt_mod(d: int, p: int):
    d %= p
    if d == 0:
        return 0
    for r in range(1, p):
        if r * r % p == d:
            return r
    return None


def reduce_stage(ch, p: int, roots: dict):
    """Residues (x̄, ȳ) ∈ F_p² of every point of a stage in one of additive.py's exact frames, given the residue of each
    radical (√d ↦ roots[d], with 0 for a ramified radical); a coordinate carrying a radical with no residue is refused."""
    inv = lambda d: pow(d % p, -1, p)
    fr = ch.frame.name
    out = []
    if fr.startswith("field16"):
        primes, denom = ch.frame.primes, ch.frame.denom
        basis = []
        for mask in range(16):
            r = 1
            for i, q in enumerate(primes):
                if mask >> i & 1:
                    r = None if (r is None or roots.get(q) is None) else r * roots[q] % p
            basis.append(r)
        for pt in ch.points:
            xs = [int(c * denom) for c in pt[:16]]; ys = [int(c * denom) for c in pt[16:]]
            for m in range(16):
                if basis[m] is None:
                    assert xs[m] == 0 and ys[m] == 0, f"a coordinate carries a radical with no residue mod {p} (basis element {m})"
            x = sum(xs[m] * basis[m] for m in range(16) if basis[m] is not None) * inv(denom) % p
            y = sum(ys[m] * basis[m] for m in range(16) if basis[m] is not None) * inv(denom) % p
            out.append((x, y))
    elif fr == "EI4":
        r3, r11 = roots[3], roots[11]
        for (aa, bb, cc, dd) in ch.points:      # ((a√3 + b√11)/12, (c + d√33)/12)
            x = (int(aa) * r3 + int(bb) * r11) * inv(12) % p; y = (int(cc) + int(dd) * r3 * r11) * inv(12) % p
            out.append((x, y))
    elif fr in ("K8",) or fr.startswith("K") and fr.endswith("-16"):
        r3, r11 = roots[3], roots[11]; basisK = [1, r3, r11, r3 * r11 % p]
        m = int(fr[1:-3]) if fr.endswith("-16") else None
        rm = roots.get(m) if m else None
        if m is not None:
            assert rm is not None, f"√{m} has no residue mod {p}"
        def Kres(c):
            d = 1
            for x in c:
                d = d * x.denominator // math.gcd(d, x.denominator)
            return sum(int(x * d) * b for x, b in zip(c, basisK)) * inv(d) % p
        for pt in ch.points:
            if m is None:
                out.append((Kres(pt[0:4]), Kres(pt[4:8])))
            else:
                out.append(((Kres(pt[0:4]) + rm * Kres(pt[4:8])) % p, (Kres(pt[8:12]) + rm * Kres(pt[12:16])) % p))
    else:
        raise SystemExit(f"reduce: frame {fr} not handled")
    return out


def cmd_reduce(a):
    import additive as AD
    ch = AD.load_chunk(a); p = a.p
    roots = {}
    if a.roots:
        for item in a.roots.split(","):
            d, r = item.split(":"); roots[int(d)] = int(r)
    else:
        rads = ch.frame.primes if hasattr(ch.frame, "primes") else ([3, 11] + ([int(ch.frame.name[1:-3])] if ch.frame.name.endswith("-16") and ch.frame.name != "K8" else []))
        for d in rads:
            roots[d] = sqrt_mod(d, p)
    red = reduce_stage(ch, p, roots)
    onc = [(u, v) for u, v in ch.edges if ((red[u][0] - red[v][0]) ** 2 + (red[u][1] - red[v][1]) ** 2) % p == 1]
    hom = len(onc) == len(ch.edges)
    rec = dict(kind="fplane-reduce", stage=ch.header(), p=p, roots=roots, residues=red, distinct_residues=len(set(red)),
               edges_on_circle=len(onc), edges=len(ch.edges), homomorphism=hom)
    line = f"[fplane] {ch.label()} mod a degree-one prime above {p} (roots {roots}): {len(set(red))} distinct residues of {p*p}; edges on the circle {len(onc)}/{len(ch.edges)} → {'a homomorphism into UD(F_%d,2)' % p if hom else 'NOT a homomorphism'}"
    if a.colouring:
        d = json.loads(Path(a.colouring).read_text()); rowsc = d["colouring_rows"]; k = d["chi"]
        col = {(x, y): int(rowsc[x][y]) for x in range(p) for y in range(p)}
        pull = [col[r] for r in red]
        mono = [(u, v) for u, v in ch.edges if pull[u] == pull[v]]
        rec.update(colouring_file=a.colouring, k=k, pullback=pull, pullback_proper=not mono, monochromatic=mono[:10])
        line += f"; the pulled-back {k}-colouring is {'PROPER (χ(stage) ≤ %d certified)' % k if not mono else 'IMPROPER (%d monochromatic edges)' % len(mono)}"
    print(line)
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"reduce-{ch.name}-p{p}.json"
    path.write_text(json.dumps(rec, indent=1, default=str)); print(f"  wrote {path}")
    return rec



# ---------------------------------------------------------------------- the spectrum (D6)
def spectrum(p: int):
    """The eigenvalues of UD(F_p,2), one per nonzero norm class c = Q(m) (the orthogonal group acts transitively on
    each sphere and preserves the circle, so λ depends on Q(m) only): λ(c) = Σ_{s on the circle} e(⟨m, s⟩/p).
    Returns {c: λ(c)} and the trivial eigenvalue p + 1 separately."""
    import cmath
    circ = circle(p); reps = {}
    for m1 in range(p):
        for m2 in range(p):
            c = (m1 * m1 + m2 * m2) % p
            if c and c not in reps:
                reps[c] = (m1, m2)
    lam = {c: sum(cmath.exp(2j * math.pi * ((m1 * a + m2 * b) % p) / p) for a, b in circ).real for c, (m1, m2) in reps.items()}
    return lam, len(circ)


def kloosterman(p: int, u: int, v: int) -> float:
    import cmath
    return sum(cmath.exp(2j * math.pi * ((u * t + v * pow(t, -1, p)) % p) / p) for t in range(1, p)).real


def hoffman_of(deg: int, lmin: float):
    """Hoffman's bound χ ≥ 1 + λ_max/(−λ_min) for a regular graph (λ_max = the degree), and its integer consequence."""
    h = 1 + deg / (-lmin)
    return h, math.ceil(h - 1e-9)


def spectral_of_dirs(p: int, S):
    """λ_min of Cay(F_p², S) by the full 2-D DFT of S's indicator (S symmetric), with the trivial eigenvalue removed."""
    import numpy as np
    ind = np.zeros((p, p))
    for a, b in S:
        ind[a, b] = 1
    lam = np.fft.fft2(ind).real
    lam[0, 0] = float("inf")
    return float(lam.min())


def spectral_record(p: int, err: float = 1e-9):
    lam, deg = spectrum(p)
    lmin = min(lam.values()); cmin = min(lam, key=lam.get)
    inv4 = pow(4, -1, p)
    resid = max(abs(lam[c] + kloosterman(p, 1, c * inv4 % p)) for c in lam)
    circ = circle(p); S = set(circ)
    lmin_fft = spectral_of_dirs(p, S)
    h, floor = hoffman_of(deg, lmin)
    # the float error: p+1 unit complex numbers summed in double precision — far below 1e-9; the Hoffman margin is
    # reported so a reader can see the bound is not decided by rounding
    h_err = deg / (-lmin) ** 2 * err
    return dict(kind="fplane-spectral", p=p, n=p * p, degree=deg, lambda_min=lmin, class_of_min=cmin,
                weil=-2 * math.sqrt(p), kloosterman_residual=resid, fft_lambda_min=lmin_fft,
                hoffman=h, hoffman_error=h_err, chi_floor=floor,
                derivation="eigenvalues of the Cayley graph = character sums over the circle; λ(c) = −K(1, c/4) (Kloosterman); "
                           "Weil |K| ≤ 2√p; Hoffman χ ≥ 1 + (p+1)/(−λ_min). Floats to 1e-12; the margin above is what rounding could move.")


def cmd_spectral(a):
    ps = [a.p] if a.p else [p for p in range(3, a.all_below) if is_prime(p) and p % 4 == 3]
    rows = []
    for p in ps:
        r = spectral_record(p); rows.append(r)
        print(f"[fplane] UD(F_{p},2): degree {r['degree']}, λ_min = {r['lambda_min']:.4f} (Weil {r['weil']:.3f}; Kloosterman residual {r['kloosterman_residual']:.1e}; FFT agrees to {abs(r['lambda_min'] - r['fft_lambda_min']):.1e}), Hoffman χ ≥ {r['hoffman']:.3f} ± {r['hoffman_error']:.0e} → χ ≥ {r['chi_floor']}", flush=True)
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else (DATA / f"spectral-p{a.p}.json" if a.p else DATA / f"spectral-below-{a.all_below}.json")
    path.write_text(json.dumps(rows if not a.p else rows[0], indent=1)); print(f"  wrote {path}")
    return rows


# ---------------------------------------------------------------------- the shadow sieve (D7)
def shadow_dirs(residues, edges, p: int):
    """The residues of a stage's unit directions up to sign: r(u) − r(v) over the edge list, each on the circle."""
    D = set()
    for u, v in edges:
        a, b = (residues[u][0] - residues[v][0]) % p, (residues[u][1] - residues[v][1]) % p
        assert (a * a + b * b) % p == 1, ("INSTRUMENT CATASTROPHE: an edge direction off the circle", u, v)
        D.add(min((a, b), ((-a) % p, (-b) % p)))
    return sorted(D)


def cay_edges(p: int, D):
    S = set()
    for a, b in D:
        S.add((a, b)); S.add(((-a) % p, (-b) % p))
    E = set()
    for x in range(p):
        for y in range(p):
            for a, b in S:
                u, v = x * p + y, ((x + a) % p) * p + (y + b) % p
                E.add((min(u, v), max(u, v)))
    return sorted(E), S


def load_gen1_residues(p: int):
    """The de Grey gen-1 half-spindle closure (24,065 points; M31) and its stored edges, reduced at p (all four
    radicands must be residues); returns (residues, edges, n_points)."""
    import closure as CL
    pts, origin, centre2 = CL.degrey_points()
    g = CL.close_gen(pts, [origin, centre2], CL.GEN1_GENS)
    E = json.loads((ROOT / "build" / "m31-closure-gen1.pts.json").read_text())["edges"]
    roots = {q: sqrt_mod(q, p) for q in (3, 5, 7, 11)}
    assert all(r is not None for r in roots.values()), ("p not usable for the closure's field", roots)
    basis = []
    for mask in range(16):
        b = 1
        for i, q in enumerate((3, 5, 7, 11)):
            if mask >> i & 1:
                b = b * roots[q] % p
        basis.append(b)
    def res(coord16):
        d = 1
        for x in coord16:
            d = d * Fr(x).denominator // math.gcd(d, Fr(x).denominator)
        assert d % p, "denominator divisible by p"
        return sum(int(Fr(x) * d) * basis[m] for m, x in enumerate(coord16)) * pow(d, -1, p) % p
    residues = [(res(pt[0]), res(pt[1])) for pt in g["pts"]]
    return residues, E, len(g["pts"])


def cmd_shadow(a):
    p = a.p
    if a.gen1:
        residues, edges, n_pts = load_gen1_residues(p); label = f"degrey-gen1 (n={n_pts}, edges={len(edges)})"; name = "degrey-gen1"
    else:
        import additive as AD
        ch = AD.load_chunk(a)
        rads = ch.frame.primes if hasattr(ch.frame, "primes") else ([3, 11] + ([int(ch.frame.name[1:-3])] if ch.frame.name.endswith("-16") and ch.frame.name != "K8" else []))
        roots = {d: sqrt_mod(d, p) for d in rads}
        residues = reduce_stage(ch, p, roots); edges = ch.edges; label = ch.label(); name = ch.name
    D = shadow_dirs(residues, edges, p)
    E, S = cay_edges(p, D); n = p * p
    lmin = spectral_of_dirs(p, S); h, floor = hoffman_of(len(S), lmin)
    rec = dict(kind="fplane-shadow", stage=label, p=p, circle_pairs=(p + 1) // 2, dirs=D, dir_count=len(D), degree=len(S),
               n=n, edges=len(E), lambda_min=lmin, hoffman=h, chi_floor=floor)
    line = f"[fplane] shadow of {label} at p = {p}: {len(D)} of {(p + 1) // 2} circle residues up to sign; Cay(F_{p}², D) has {n} vertices, degree {len(S)}; spectral floor χ ≥ {h:.3f} → ≥ {floor}"
    if a.k:
        t0 = time.time(); st, col = colourable(n, E, a.k, wall=a.wall)
        rec.update(k=a.k, status=st, seconds=round(time.time() - t0, 1), colouring=col)
        line += f"; k = {a.k}: {'SAT — a verified %d-colouring (χ(shadow) ≤ %d)' % (a.k, a.k) if st == 'sat' else ('REFUSED by the solver after %.0f s (its claim) — χ(shadow) ≥ %d' % (rec['seconds'], a.k + 1) if st == 'unsat' else 'UNDECIDED at the wall (%.0f s)' % rec['seconds'])}"
    print(line)
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"shadow-{name}-p{p}.json"
    path.write_text(json.dumps(rec, indent=1, default=str)); print(f"  wrote {path}")
    return rec


# ---------------------------------------------------------------------- the field table (phase B)
FIELDS = {
    "Q": [], "Q(√2)": [2], "Q(√3)": [3], "Q(√5)": [5], "Q(√7)": [7], "Q(√11)": [11],
    "K = Q(√3,√11)": [3, 11], "K(√5)": [3, 5, 11], "K(√7)": [3, 7, 11], "K(√13)": [3, 11, 13], "K(√23) [T20b]": [3, 11, 23],
    "K(√35)": [3, 11, 35], "K(√79)": [3, 11, 79], "K(√127)": [3, 11, 127], "K(√247) [T20, W]": [3, 11, 247],
    "K(√5,√247)": [3, 5, 11, 247], "Heule Q(√3,√5,√11)": [3, 5, 11], "de Grey Q(√3,√5,√7,√11)": [3, 5, 7, 11],
    "K(√5,√7,√247)": [3, 5, 7, 11, 247],
}


def squarefree_part(m: int) -> int:
    k = 2
    while k * k <= m:
        while m % (k * k) == 0:
            m //= k * k
        k += 1
    return m


def wall_broken(rads) -> bool:
    """Theorem B's criterion (G35): the 2-adic wall of a multiquadratic field is broken iff some square class of the
    field — a product of a subset of the radicands, reduced to its squarefree part — is ODD and ≡ 7 (mod 8), i.e. is
    the class of −1 in Q₂. (An even class never is: the classes of Q₂ are ⟨−1, 2, 5⟩.)"""
    for r in range(1, 1 << len(rads)):
        m = 1
        for i, d in enumerate(rads):
            if r >> i & 1:
                m *= d
        c = squarefree_part(m)
        if c % 2 == 1 and c % 8 == 7:
            return True
    return False


def plane_verdicts(bound: int):
    """What is known about χ(UD(F_p,2)) for each p ≡ 3 mod 4 below the bound, from the records on disk and the
    spectral bound: {p: (kind, chi_or_floor, source)} — kind 'exact' (a verified colouring at chi, chi−1 refused by
    the solver), 'upper' (a verified colouring, the lower half unknown), 'floor' (refused below / spectral)."""
    out = {}
    for p in [q for q in range(3, bound) if is_prime(q) and q % 4 == 3]:
        upper = None; lower = 1
        for f in sorted(DATA.glob(f"chi-p{p}*.json")):
            d = json.loads(f.read_text())
            if d.get("chi"):
                upper = d["chi"] if upper is None else min(upper, d["chi"])
            for r in d.get("rows", []):
                if r["status"] == "unsat":
                    lower = max(lower, r["k"] + 1)
        h, floor = hoffman_of(p + 1, min(spectrum(p)[0].values()))
        lower = max(lower, floor)
        if upper is not None and lower == upper:
            out[p] = ("exact", upper, f"chi-p{p}")
        elif upper is not None:
            out[p] = ("upper", upper, f"chi-p{p} (≤); floor {lower}")
        else:
            out[p] = ("floor", lower, f"floor {lower} ({'spectral' if floor == lower else 'refused by the solver'})")
    return out


def cmd_map(a):
    fields = dict(FIELDS)
    if a.fields:
        for item in a.fields.split(";"):
            name, rads = item.split(":"); fields[name.strip()] = [int(x) for x in rads.split(",") if x.strip()]
    verdicts = plane_verdicts(a.bound)
    rows = []
    for name, rads in fields.items():
        wall = wall_broken(rads) if rads else False
        us = usable(rads, a.bound)
        sealing = None
        for p in us:
            kind, val, src = verdicts.get(p, ("floor", 1, "?"))
            if kind in ("exact", "upper") and val <= 5:
                sealing = (p, val, src); break
        pending = [p for p in us if p < 67 and verdicts.get(p, ("floor", 1, ""))[0] == "floor" and verdicts[p][1] <= 5]
        # the best upper bound the two mechanisms give: Theorem B's 4 when the 2-adic wall stands (Fischer gives 2 or 3
        # on some of those fields; not computed here), and the smallest plane value among the usable primes with a record
        best = min((verdicts[p][1], p, verdicts[p][2]) for p in us if verdicts.get(p, ("floor",))[0] in ("exact", "upper")) if any(verdicts.get(p, ("floor",))[0] in ("exact", "upper") for p in us) else None
        if not wall and (best is None or best[0] >= 4):
            verdict = "sealed-at-4 (Theorem B: the 2-adic wall stands)" + (f"; the sieve agrees at p = {best[1]}" if best and best[0] == 4 else "")
        elif best is not None and best[0] <= 5:
            verdict = f"sealed-at-{best[0]} (p = {best[1]}, {best[2]})" + ("" if wall else "; Theorem B: ≤ 4 as well")
        elif pending:
            verdict = f"open-pending (p = {pending[0]}: its plane is undecided)"
        else:
            verdict = "6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below)"
        rows.append(dict(field=name, radicands=rads, wall_broken=wall, usable=us[:12], sealing=sealing, verdict=verdict))
        print(f"{name:26s} wall {'broken' if wall else 'stands'}  usable {us[:8]}  → {verdict}")
    rec = dict(kind="fplane-map", bound=a.bound, planes={p: v for p, v in verdicts.items()}, rows=rows,
               vocabulary="sealed-at-k: χ(F²) ≤ k by a verified colouring of the plane at the named prime (or Theorem B); "
                          "6-open: no usable prime seals (spectral floor ≥ 6 at p ≥ 67; the planes below by their records); open-pending: a usable plane below 67 is undecided")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / "map.json"
    path.write_text(json.dumps(rec, indent=1, default=str)); print(f"  wrote {path}")
    md = ["| field | radicands | 2-adic wall | usable primes | verdict |", "|---|---|---|---|---|"]
    for r in rows:
        md.append(f"| {r['field']} | {r['radicands']} | {'broken' if r['wall_broken'] else 'stands'} | {r['usable'][:8]} | {r['verdict']} |")
    (DATA / "map.md").write_text("\n".join(md) + "\n"); print(f"  wrote {DATA / 'map.md'}")
    return rec


# ---------------------------------------------------------------------- self-test
def self_test():
    fails = []
    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}")
        if not cond:
            fails.append(name)
    print("[self-test] fplane: planted controls")
    for p, expect in ((3, 3), (7, 4), (11, 5)):
        E, deg = ud_edges(p); n = p * p
        s1, _ = colourable(n, E, expect - 1); s2, c = colourable(n, E, expect)
        check(f"χ(UD(F_{p},2)) = {expect} ({'Vinh 2005 by computer' if p == 7 else 'the web session'}): k−1 unsat, k sat verified", s1 == "unsat" and s2 == "sat")
        check(f"  circle has p+1 = {p+1} points (p ≡ 3 mod 4)", deg == p + 1)
    check("sieve: Heule's field Q(√3,√5,√11) has 11 usable; de Grey's Q(√3,√5,√7,√11) has none below 131", usable([3, 5, 11], 20)[:1] == [11] and usable([3, 5, 7, 11], 131) == [])
    check("sieve: K(√247) has 11 usable (247 ≡ 5, a square mod 11); K(√35) does not (35 ≡ 2)", usable([3, 11, 247], 20)[:1] == [11] and 11 not in usable([3, 11, 35], 20))
    import additive as AD
    class A: pass
    a = A()
    for k_ in ("seed", "object", "witness", "heule510", "degrey", "field16", "graph", "planted"): setattr(a, k_, None)
    a.heule510 = True; H = AD.load_chunk(a)
    red = reduce_stage(H, 11, {3: 5, 5: 4, 7: None, 11: 0})
    onc = sum(1 for u, v in H.edges if ((red[u][0] - red[v][0]) ** 2 + (red[u][1] - red[v][1]) ** 2) % 11 == 1)
    check("Heule-510 mod the prime above 11 (√3↦5, √5↦4, √11↦0): all 2,504 edges on the circle", onc == len(H.edges) == 2504)
    E11, _ = ud_edges(11); _, c11 = colourable(121, E11, 5)
    pull = [c11[x * 11 + y] for x, y in red]
    check("the pulled-back 5-colouring of Heule-510 is proper (χ(Heule-510) ≤ 5 certified by pullback)", all(pull[u] != pull[v] for u, v in H.edges))
    # planted red: a wrong root (4 is not a square root of 3 mod 11: 16 = 5) must break the circle check
    red_bad = reduce_stage(H, 11, {3: 4, 5: 4, 7: None, 11: 0})
    onc_bad = sum(1 for u, v in H.edges if ((red_bad[u][0] - red_bad[v][0]) ** 2 + (red_bad[u][1] - red_bad[v][1]) ** 2) % 11 == 1)
    check(f"planted red: a wrong residue for √3 breaks the homomorphism ({onc_bad} of 2504 on the circle)", onc_bad < len(H.edges))
    # planted red: p = 13 ≡ 1 mod 4 — F_13 has √−1, the theorem's hypothesis fails; the circle then has p−1 points
    check("planted red: p = 13 ≡ 1 (mod 4) is not usable (circle has p−1 = 12 points; the argument's inertness fails)", len(circle(13)) == 12)
    # D6: the spectrum
    for p in (11, 23):
        r = spectral_record(p)
        check(f"spectral: λ(c) = −K(1, c/4) at p = {p} (Kloosterman residual {r['kloosterman_residual']:.1e}) and the FFT agrees ({abs(r['lambda_min'] - r['fft_lambda_min']):.1e})",
              r["kloosterman_residual"] < 1e-6 and abs(r["lambda_min"] - r["fft_lambda_min"]) < 1e-6)
    check("spectral: Hoffman at 59 exceeds 5 (χ ≥ 6) and at 47 does not", spectral_record(59)["hoffman"] > 5 and spectral_record(47)["hoffman"] < 5)
    check("spectral: Weil holds at 131 (|λ_min| < 2√131) and Hoffman gives ≥ 8", -spectral_record(131)["lambda_min"] < 2 * math.sqrt(131) and spectral_record(131)["chi_floor"] == 8)
    # planted red: a sign-flipped λ_min would give a Hoffman number below 1 — the cross-check catches it
    r = spectral_record(59)
    check("planted red: a sign-flipped λ_min is caught (Hoffman < 1 is impossible for a nonempty graph)", hoffman_of(r["degree"], -r["lambda_min"])[0] < 1)
    # G35's eight classes: exactly 5 and 7 break the wall over K
    breaks = [d for d in (1, 2, 5, 7, 10, 14, 35, 70) if wall_broken([3, 11, d])]
    check(f"the 2-adic wall over K: of the classes {{1,2,5,7,10,14,35,70}} exactly 5 and 7 break it (got {breaks})", breaks == [5, 7])
    check("the 2-adic wall: K stands, K(√13) breaks (3·13 ≡ 7 mod 8), K(√35) stands", (not wall_broken([3, 11])) and wall_broken([3, 11, 13]) and (not wall_broken([3, 11, 35])))
    # D7: a planted single-pair direction set is 2-chromatic; Heule-510's shadow at 11 is the whole circle (≥ 5 by the theorem)
    E1, S1 = cay_edges(11, [(0, 1)]); s2, _ = colourable(121, E1, 2); s3, _ = colourable(121, E1, 3)
    check("shadow: the single direction (0,1) at p = 11 gives 11 disjoint 11-cycles — odd, so 2 refused and 3 found", s2 == "unsat" and s3 == "sat" and len(E1) == 121)
    D510 = shadow_dirs(red, H.edges, 11)
    check(f"shadow: Heule-510's directions cover all 6 circle residues up to sign at p = 11 (got {len(D510)})", len(D510) == 6)
    # M61: the periodic quotient, the Lovász number, the symmetry face
    r19 = periodic_row(19); r11 = periodic_row(11)
    check(f"periodic: χ(C_19) = 5 with the lifted colouring verified on the plane; α(C_19) = 4 lifts to 76 verified (got {r19['chi_circ']}, {r19['alpha_plane_ge']})",
          r19["chi_circ"] == 5 == r19["chi_circ_lo"] and r19.get("lift_verified") and r19["alpha_plane_ge"] == 76 and r19.get("indep_lift_verified"))
    check(f"periodic: χ(C_11) = 6 — five refused (the solver's), six lifted and verified: no periodic 5-colouring at 11 (got [{r11['chi_circ_lo']}, {r11['chi_circ']}])",
          r11["chi_circ"] == 6 == r11["chi_circ_lo"] and r11.get("lift_verified"))
    # planted red: a NON-null direction at 7 — (1,1) has norm 2 = 3², its line meets the circle, so the projected set contains 0
    check("planted red: the non-null direction (1,1) at 7 projects a circle point to 0 (no periodic colouring along it)", 0 in {proj_along((1, 1), s_, 7) for s_ in circle(7)})
    th = theta_row(11)
    check(f"theta: ϑ = ϑ′ = Hoffman at 11 to 1e-6 (arc-transitivity; got {th['theta']:.4f} vs {th['hoffman_alpha']:.4f})", abs(th["theta_minus_hoffman"]) < 1e-6 and abs(th["theta_prime"] - th["hoffman_alpha"]) < 1e-6)
    g2 = next(g for g, o in rotations(11) if o == 2)
    st_e, _ = equivariant_colouring(11, 5, g2, (1, 0, 3, 2, 4), 5_000_000)
    check("equivariant: the half-turn with τ = (01)(23) admits a 5-colouring at 11, verified proper and equivariant", st_e == "sat")
    g3 = next(g for g, o in rotations(11) if o == 3)
    st_3, _ = equivariant_colouring(11, 5, g3, (1, 2, 0, 3, 4), 5_000_000)
    check(f"equivariant: the order-3 rotation with τ a 3-cycle at 11 returns a verdict under at-most-one (got {st_3}; without AMO the model was proper but not equivariant)", st_3 in ("sat", "unsat"))
    st_i, _ = equivariant_colouring(11, 5, g2, (0, 1, 2, 3, 4), 5_000_000)
    check("planted red: a rotation-INVARIANT (τ = id) proper colouring is impossible (z ~ −z on the circle of norm 1/4)", st_i == "unsat")
    # A0.1 (FS-53): the q = 27 plane's producer, restored.  The graph's identity is FIXED -- 729 vertices, a
    # 28-point circle, 10,206 edges and one edge hash -- and the hash is a fact about the LABELLING as well as
    # the shape, which the two plants below separate.
    Q27_SHA = "b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d"
    V27, E27, circ27, h27 = graph_q27()
    check(f"q=27: UD(F_27,2) is 729 vertices, degree 28, 10,206 edges, edges_sha256 {Q27_SHA[:16]}… (got {len(V27)}, {len(circ27)}, {len(E27)}, {h27[:16]}…)",
          len(V27) == 729 and len(circ27) == 28 and len(E27) == 10206 and h27 == Q27_SHA)
    st27, _ = sat_colour_budget(len(V27), E27, 3, conf=2_000_000)
    check(f"q=27: k = 3 is refused by the solver on that edge list (χ ≥ 4; the k = 4 refusal is the record's, at 6.9 s) (got {st27})", st27 == "unsat")
    # planted red 1: Z/27 is NOT F_27.  Same number, different graph -- the circle x² + y² = 1 over the RING has
    # a different size, so the degree check fires before any hash is compared.  This is the trap A0.4 refuses by name.
    circ_ring = [(a, b) for a in range(27) for b in range(27) if (a * a + b * b) % 27 == 1]
    check(f"planted red: Z/27 is not F_27 — the ring's circle has {len(circ_ring)} points, not 28, so the ring graph fails the degree check", len(circ_ring) != 28)
    # planted red 2: the OTHER irreducible cubic t³ − t + 1 gives an isomorphic field with a different labelling:
    # the shape survives and the hash does not.  The mutation is applied to the shipped field_q27 and then
    # RESTORED, and the restore is re-verified (a mutation harness that does not re-check its restore has
    # certified nothing -- CLAUDE.md § Make the gate fail).
    _true_field = field_q27
    def _field_q27_other():
        els = [(a, b, c) for a in range(3) for b in range(3) for c in range(3)]
        def add(u, v): return tuple((x + y) % 3 for x, y in zip(u, v))
        def mul(u, v):                                   # t³ = t − 1 instead of t³ = t + 1
            r = [0] * 5
            for i in range(3):
                for j in range(3):
                    r[i + j] = (r[i + j] + u[i] * v[j]) % 3
            r[2] = (r[2] + r[4]) % 3; r[1] = (r[1] - r[4]) % 3
            r[1] = (r[1] + r[3]) % 3; r[0] = (r[0] - r[3]) % 3
            return tuple(r[:3])
        return els, add, mul, (1, 0, 0)
    globals()["field_q27"] = _field_q27_other
    try:
        Vb, Eb, cb, hb = graph_q27()
    finally:
        globals()["field_q27"] = _true_field
    check(f"planted red: the modulus t³ − t + 1 keeps the shape ({len(Vb)}, {len(cb)}, {len(Eb)}) and changes the hash to {hb[:16]}… — the hash names the field, not only the graph's size",
          (len(Vb), len(cb), len(Eb)) == (729, 28, 10206) and hb != h27)  # against the SHIPPED hash, never the constant
    check("the mutation harness restored the shipped field: graph_q27() is back to the committed hash", graph_q27()[3] == Q27_SHA)
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


# ---------------------------------------------------------------------- M61: the plane's own invariants
# The periodic quotient, the fractional face, the Lovász number, the symmetry face, the odd-degree planes
# (`plans/M61-local-global-tightness.md` §S1–§S4). Every verdict line names its population and its trust word.

def is_square_mod(x: int, p: int) -> bool:
    x %= p
    return x == 0 or pow(x, (p - 1) // 2, p) == 1

def null_direction(p: int):
    """a direction (a, b) of non-square norm: the line F_p·(a,b) misses the unit circle"""
    for a in range(p):
        for b in range(p):
            if (a, b) != (0, 0) and not is_square_mod(a * a + b * b, p):
                return (a, b)
    raise ValueError(f"no null direction at {p} (p ≡ 1 mod 4?)")

def proj_along(v, w, p: int) -> int:
    """the projection along v: the 2-D determinant v.1·w.2 − v.2·w.1 (kernel = the line through v) — `projAlong` in the kernel"""
    return (v[0] * w[1] - v[1] * w[0]) % p

def quotient_set(p: int, v):
    """D = the projections of the unit circle along v (never 0 when v is null; symmetric; (p+1)/2 elements)"""
    D = sorted({proj_along(v, s, p) for s in circle(p)})
    return D

def circulant_edges(p: int, D):
    return [(i, j) for i in range(p) for j in range(i + 1, p) if (j - i) % p in D]

def sat_colour_budget(n: int, E, k: int, pins=None, conf: int = 2_000_000, extra=None):
    """k-colouring under a conflict budget: ('sat', col) with col verified proper, ('unsat', None) the solver's, ('unknown', None)"""
    from pysat.solvers import Cadical195
    var = lambda v, c: v * k + c + 1
    s = Cadical195()
    for v in range(n):
        s.add_clause([var(v, c) for c in range(k)])
    for (u, v) in E:
        for c in range(k):
            s.add_clause([-var(u, c), -var(v, c)])
    for (v, c) in (pins or [(0, 0)]):
        s.add_clause([var(v, c)])
    for cl in (extra or []):
        s.add_clause(cl)
    s.conf_budget(conf)
    ok = s.solve_limited()
    if ok is None:
        return "unknown", None
    if not ok:
        return "unsat", None
    m = set(x for x in s.get_model() if x > 0)
    col = [next(c for c in range(k) if var(v, c) in m) for v in range(n)]
    assert all(col[u] != col[v] for (u, v) in E), "INSTRUMENT CATASTROPHE: the model is not a proper colouring"
    return "sat", col

def sat_indep_atleast(n: int, E, N: int, conf: int = 2_000_000):
    """an independent set of size ≥ N under a conflict budget: ('sat', S) verified, ('unsat', None) the solver's, ('unknown', None)"""
    from pysat.solvers import Cadical195
    from pysat.card import CardEnc, EncType
    s = Cadical195()
    for (u, v) in E:
        s.add_clause([-(u + 1), -(v + 1)])
    s.add_clause([1])
    for cl in CardEnc.atleast(lits=list(range(1, n + 1)), bound=N, top_id=n, encoding=EncType.seqcounter).clauses:
        s.add_clause(cl)
    s.conf_budget(conf)
    ok = s.solve_limited()
    if ok is None:
        return "unknown", None
    if not ok:
        return "unsat", None
    m = set(x for x in s.get_model() if x > 0)
    S = [v for v in range(n) if (v + 1) in m]
    Es = set(E)
    assert all((min(u, v), max(u, v)) not in Es for u in S for v in S if u != v), "INSTRUMENT CATASTROPHE: not independent"
    return "sat", S

def periodic_row(p: int, conf: int = 2_000_000, verify_lift: bool = True):
    """the circulant C_p of a null direction: χ(C_p) as [lo, hi] (hi a colouring VERIFIED as a lifted colouring of the plane),
    α(C_p) as [lo, hi] (lo a set whose lift is VERIFIED independent in the plane)"""
    v = null_direction(p)
    D = quotient_set(p, v)
    assert 0 not in D and len(D) == (p + 1) // 2 and all((-d) % p in D for d in D)
    E = circulant_edges(p, D)
    lo, hi, col = 1, None, None
    for k in range(1, p + 1):
        st, c = sat_colour_budget(p, E, k, conf=conf)
        if st == "unsat":
            lo = k + 1
        elif st == "sat":
            hi, col = k, c
            break
    alo, ahi, S = 0, None, None
    N = 1
    while True:
        st, S1 = sat_indep_atleast(p, E, N, conf=conf)
        if st == "unsat":
            ahi = alo; break
        if st == "unknown":
            break
        S, alo = S1, len(S1); N = alo + 1
    row = dict(p=p, direction=v, D=D, circulant_edges=len(E), chi_circ_lo=lo, chi_circ=hi, alpha_circ=alo, alpha_circ_hi=ahi,
               colouring=col, indep=S, alpha_plane_ge=p * alo)
    if verify_lift and p <= 100:
        circ = set(circle(p))
        if col is not None:
            lifted = {(x, y): col[proj_along(v, (x, y), p)] for x in range(p) for y in range(p)}
            assert all(lifted[(a, b)] != lifted[((a + s) % p, (b + t) % p)] for (a, b) in lifted for (s, t) in circ), \
                "INSTRUMENT CATASTROPHE: the lifted colouring is not proper on the plane"
            row["lift_verified"] = True
        if S is not None:
            pts = [(x, y) for x in range(p) for y in range(p) if proj_along(v, (x, y), p) in set(S)]
            assert len(pts) == p * alo
            assert all(((a - c) % p, (b - d) % p) not in circ for (a, b) in pts for (c, d) in pts), \
                "INSTRUMENT CATASTROPHE: the lifted independent set is not independent"
            row["indep_lift_verified"] = True
    return row

def cmd_periodic(a):
    rows = []
    t0 = time.time()
    for p in range(3, a.below + 1):
        if not is_prime(p) or p % 4 != 3:
            continue
        t1 = time.time()
        r = periodic_row(p, conf=a.conf)
        r["seconds"] = round(time.time() - t1, 1)
        rows.append(r)
        chis = f"{r['chi_circ']}" if r["chi_circ"] == r["chi_circ_lo"] else f"[{r['chi_circ_lo']}, {r['chi_circ']}]"
        als = f"{r['alpha_circ']}" if r["alpha_circ_hi"] == r["alpha_circ"] else f"≥ {r['alpha_circ']}"
        print(f"[periodic] p={p:3d}: C_p has {len(r['D'])} generators; χ(C_p) = {chis:>8s} (hi: a lifted colouring verified on the plane; lo: the solver's refusal), "
              f"α(C_p) = {als:>4s} (a lifted independent set of {r['alpha_plane_ge']} plane points verified) → χ(UD) ≤ {r['chi_circ']}, α(UD) ≥ {r['alpha_plane_ge']}  [{r['seconds']}s]", flush=True)
    out = dict(kind="fplane-periodic", below=a.below, conflict_budget=a.conf, rows=rows, seconds=round(time.time() - t0, 1),
               claim_scope="per prime, the circulant C_p = Cay(F_p, π(S)) of one null direction (all null directions are one rotation orbit): "
                           "chi_circ carries a colouring of C_p whose lift (constant on the null line's cosets) is VERIFIED proper on the plane — χ(UD(F_p,2)) ≤ chi_circ; "
                           "chi_circ_lo − 1 is the solver's refusal (untrusted): no PERIODIC colouring below it; alpha_circ·p is a verified independent set of the plane; "
                           "alpha_circ_hi = alpha_circ means alpha_circ + 1 was refused by the solver; unknown budgets leave hi = null")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"periodic-below-{a.below}.json"
    path.write_text(json.dumps(out, indent=1)); print(f"  wrote {path}")
    return out

def scheme_eigen(p: int):
    """λ_c(c') = Σ_{s ∈ N_c} cos(2π⟨m, s⟩/p) with N(m) = c' — the eigenmatrix of the norm-class translation scheme"""
    classes = {}
    for x in range(p):
        for y in range(p):
            if (x, y) != (0, 0):
                classes.setdefault((x * x + y * y) % p, []).append((x, y))
    reps = {c: classes[c][0] for c in classes}
    L = {}
    for c in range(1, p):
        for cp in range(0, p):
            m = (0, 0) if cp == 0 else reps[cp]
            L[(c, cp)] = sum(math.cos(2 * math.pi * (m[0] * s[0] + m[1] * s[1]) / p) for s in classes[c])
    return L

def theta_row(p: int):
    """ϑ and Schrijver's ϑ′ of UD(F_p,2) by the LP over the norm classes (translation + O(2) symmetry); Hoffman as the control"""
    import numpy as np
    from scipy.optimize import linprog
    L = scheme_eigen(p)
    cs = list(range(2, p)); n = p * p
    cobj = -np.array([(p + 1)] * len(cs), dtype=float)
    A = [[-L[(c, cp)] for c in cs] for cp in range(0, p)]; b = [1.0] * p
    res = {}
    for name, bounds in (("theta", (None, None)), ("theta_prime", (0, None))):
        r = linprog(cobj, A_ub=np.array(A), b_ub=np.array(b), bounds=[bounds] * len(cs), method="highs")
        assert r.status == 0, r.message
        res[name] = float(1 - r.fun)
    lmin = min(L[(1, cp)] for cp in range(1, p))
    hoff_alpha = n * (-lmin) / ((p + 1) - lmin)
    return dict(p=p, n=n, theta=res["theta"], theta_prime=res["theta_prime"], hoffman_alpha=hoff_alpha,
                theta_minus_hoffman=res["theta"] - hoff_alpha,
                chi_floor=math.ceil(n / res["theta_prime"] - 1e-9), alpha_needed_for_5=math.ceil(n / 5))

def cmd_theta(a):
    rows = []
    for p in range(3, a.below + 1):
        if not is_prime(p) or p % 4 != 3:
            continue
        r = theta_row(p); rows.append(r)
        print(f"[theta] p={p:3d} n={r['n']:5d}: ϑ = {r['theta']:9.3f}, ϑ′ = {r['theta_prime']:9.3f}, Hoffman α ≤ {r['hoffman_alpha']:9.3f} "
              f"(ϑ − Hoffman = {r['theta_minus_hoffman']:.1e}) → χ ≥ {r['chi_floor']} (a float LP; α ≥ {r['alpha_needed_for_5']} needed for five colours)", flush=True)
    out = dict(kind="fplane-theta", below=a.below, rows=rows,
               claim_scope="ϑ(UD(F_p,2)) and Schrijver's ϑ′ by the LP over the p−1 norm classes of the translation scheme (its eigenmatrix the "
                           "Kloosterman table), solved by HiGHS in floats; α ≤ ϑ′ ≤ ϑ, χ ≥ ⌈n/ϑ′⌉ — a derivation (Lovász 1979) plus a float LP; "
                           "the Hoffman column is the control: for an arc-transitive graph ϑ equals the Hoffman ratio bound (Lovász, Thm 9), so "
                           "theta_minus_hoffman must be ~0; no kernel content")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"theta-below-{a.below}.json"
    path.write_text(json.dumps(out, indent=1)); print(f"  wrote {path}")
    return out

def cmd_alpha(a):
    """the independence number's ladder under the EXTERNAL cadical (pysat's wall is inert on big instances)"""
    import subprocess, os
    from pysat.formula import CNF
    from pysat.card import CardEnc, EncType
    p = a.p; E, deg = ud_edges(p); n = p * p
    cad = os.path.join(subprocess.check_output(["lean", "--print-prefix"]).decode().strip(), "bin", "cadical")
    Ns = [a.N] if a.N else list(range(math.ceil(n / 5) - 2, n))
    rows = []; best = None; scratch = ROOT / "build" / "m61"; scratch.mkdir(parents=True, exist_ok=True)
    for N in Ns:
        cnf = CNF()
        for u, v in E: cnf.append([-(u + 1), -(v + 1)])
        cnf.append([1])
        cnf.extend(CardEnc.atleast(lits=list(range(1, n + 1)), bound=N, top_id=n, encoding=EncType.seqcounter).clauses)
        path = scratch / f"alpha-p{p}-N{N}.cnf"; cnf.to_file(str(path))
        t0 = time.time()
        r = subprocess.run(["timeout", str(int(a.wall)), cad, "-q", str(path)], capture_output=True, text=True)
        secs = round(time.time() - t0, 1); out = r.stdout
        st = "sat" if "s SATISFIABLE" in out else "unsat" if "s UNSATISFIABLE" in out else "unknown"
        row = dict(N=N, status=st, seconds=secs)
        if st == "sat":
            lits = [int(x) for l in out.splitlines() if l.startswith("v ") for x in l[2:].split()]
            S = [x - 1 for x in lits if 0 < x <= n]; Es = set(E)
            assert all((min(u, v), max(u, v)) not in Es for u in S for v in S if u != v), "INSTRUMENT CATASTROPHE: not independent"
            row["size"] = len(S); row["independent_set"] = S; best = S
        rows.append(row)
        word = {"sat": f"a verified independent set of size {row.get('size')}", "unsat": "the solver's refusal (untrusted)", "unknown": f"unknown at the {int(a.wall)}-s wall"}[st]
        print(f"[alpha] UD(F_{p},2) ({n} vertices): size ≥ {N}? {st.upper()} — {word} [{secs}s]  (p²/5 = {n/5:.1f})", flush=True)
        if st != "sat":
            break
    lo = max((r["size"] for r in rows if r["status"] == "sat"), default=0)
    hi = next((r["N"] - 1 for r in rows if r["status"] == "unsat"), None)
    out = dict(kind="fplane-alpha", p=p, n=n, degree=deg, wall=a.wall, rows=rows, alpha_ge=lo, alpha_le=hi, independent_set=best,
               claim_scope="alpha_ge: a verified independent set; alpha_le: the external cadical's refusal of size alpha_le + 1 (untrusted); "
                           "a 5-colouring needs α ≥ ⌈p²/5⌉ (card_le_mul_of_colorable in the kernel), so alpha_le < ⌈p²/5⌉ would give χ ≥ 6 on the solver's word")
    DATA.mkdir(parents=True, exist_ok=True); path = Path(a.out) if a.out else DATA / f"alpha-p{p}.json"
    path.write_text(json.dumps(out, indent=1)); print(f"  wrote {path}")
    return out

def rotations(p: int):
    """the rotation group as matrices ((a, −b), (b, a)), a² + b² = 1, with orders"""
    I = ((1, 0), (0, 1))
    def mul(g, h):
        return ((g[0][0] * h[0][0] + g[0][1] * h[1][0]) % p, (g[0][0] * h[0][1] + g[0][1] * h[1][1]) % p), \
               ((g[1][0] * h[0][0] + g[1][1] * h[1][0]) % p, (g[1][0] * h[0][1] + g[1][1] * h[1][1]) % p)
    out = []
    for (a, b) in circle(p):
        g = ((a, (-b) % p), (b, a)); h = g; o = 1
        while h != I:
            h = mul(h, g); o += 1
        out.append((g, o))
    return out

def perm_class_reps(k: int):
    """one representative per conjugacy class of S_k, with its order"""
    import itertools
    seen = {}
    for perm in itertools.permutations(range(k)):
        vis = [False] * k; ct = []
        for i in range(k):
            if not vis[i]:
                j = i; l = 0
                while not vis[j]:
                    vis[j] = True; j = perm[j]; l += 1
                ct.append(l)
        ct = tuple(sorted(ct, reverse=True))
        if ct not in seen:
            o = 1
            for l in ct: o = o * l // math.gcd(o, l)
            seen[ct] = (perm, o)
    return seen

def equivariant_colouring(p: int, k: int, g, tau, conf: int):
    """col(g z) = tau(col z) for all z, as extra clauses; the model is verified proper AND equivariant.
    At-most-one colour per vertex is ENFORCED here (the plain colouring instance does without it, since any true colour of a
    vertex is a proper choice; the equivariance clauses relate the colours of z and g z, so a vertex with two true colours could
    satisfy them while the chosen colouring is not equivariant — the self-check caught exactly that on 2026-09-07).
    A τ without a fixed colour refuses trivially: the origin is fixed by every rotation, so col 0 = τ (col 0)."""
    E, _ = ud_edges(p); n = p * p
    var = lambda v, c: v * k + c + 1
    if not any(tau[c] == c for c in range(k)):
        return "unsat", None
    extra = [[-var(v, c), -var(v, d)] for v in range(n) for c in range(k) for d in range(c + 1, k)]
    gz_of = {}
    for x in range(p):
        for y in range(p):
            z = x * p + y
            gz = ((g[0][0] * x + g[0][1] * y) % p) * p + (g[1][0] * x + g[1][1] * y) % p
            gz_of[z] = gz
            for c in range(k):
                extra.append([-var(z, c), var(gz, tau[c])])
    fixed = next(c for c in range(k) if tau[c] == c)
    st, col = sat_colour_budget(n, E, k, pins=[(0, fixed)], conf=conf, extra=extra)
    if st == "sat":
        assert all(col[gz_of[z]] == tau[col[z]] for z in range(n)), "INSTRUMENT CATASTROPHE: the model is not equivariant"
    return st, col

def rotation_orbits(p: int, g, o: int):
    """Orbits of the rotation ⟨g⟩ on F_p²: rep[z] (the orbit's representative, the smallest index) and exp[z] with
    z = g^exp[z] rep[z]. Every orbit except the origin's has exactly o points (a rotation about the origin fixes only the
    origin), which the walk asserts."""
    n = p * p
    def act(z):
        x, y = divmod(z, p)
        return ((g[0][0] * x + g[0][1] * y) % p) * p + (g[1][0] * x + g[1][1] * y) % p
    rep = [-1] * n; exp = [0] * n
    for z in range(n):
        if rep[z] >= 0:
            continue
        w, jj = z, 0
        while rep[w] < 0:
            rep[w] = z; exp[w] = jj; w = act(w); jj += 1
        assert w == z and (jj == o or z == 0 and jj == 1), f"INSTRUMENT CATASTROPHE: orbit of {z} has size {jj}, order {o}"
    return rep, exp, act


def equivariant_quotient(p: int, k: int, g, o: int, tau, conf: int, E=None):
    """The quotient form of `equivariant_colouring`: one variable set per ⟨g⟩-orbit instead of per point, so the instance
    is o times smaller (order 84 at p = 83 leaves 83 representatives against 6,889 points). A colouring with
    col(g z) = τ(col z) is determined by its values on representatives — col(g^j z₀) = τ^j(col z₀) — so an edge
    (g^a z₀, g^b w₀) is monochromatic iff τ^a(col z₀) = τ^b(col w₀), i.e. iff col z₀ = τ^(b−a)(col w₀): one clause
    ¬(z₀ has τ^t c ∧ w₀ has c) per colour c, t = b − a mod o. An edge inside one orbit with τ^t c = c forbids c on that
    representative outright. The origin is its own orbit and is pinned to a τ-fixed colour (none ⟹ trivially unsat).
    The model is EXPANDED to the whole plane and verified proper on every edge AND equivariant before it is returned,
    so the quotient is an instrument for finding and the verdict is the full plane's. Any single true colour per
    representative expands to a proper colouring (the clauses forbid every monochromatic pair of choices), so
    at-most-one is not needed for soundness; it is added because it is cheap on the quotient."""
    from pysat.solvers import Cadical195
    if not any(tau[c] == c for c in range(k)):
        return "unsat", None
    if E is None:
        E, _ = ud_edges(p)
    n = p * p
    rep, exp, act = rotation_orbits(p, g, o)
    reps = sorted(set(rep)); ridx = {r: i for i, r in enumerate(reps)}; R = len(reps)
    taupow = [list(range(k))]
    for _ in range(1, o):
        taupow.append([tau[c] for c in taupow[-1]])
    var = lambda r, c: r * k + c + 1
    clauses = set()
    for (u, v) in E:
        ru, rv = ridx[rep[u]], ridx[rep[v]]; t = (exp[v] - exp[u]) % o
        for c in range(k):
            cl = (-var(ru, taupow[t][c]), -var(rv, c))
            clauses.add(cl if cl[0] != cl[1] else (cl[0],))
    s = Cadical195()
    for r in range(R):
        s.add_clause([var(r, c) for c in range(k)])
        for c in range(k):
            for d in range(c + 1, k):
                s.add_clause([-var(r, c), -var(r, d)])
    for cl in clauses:
        s.add_clause(list(cl))
    fixed = next(c for c in range(k) if tau[c] == c)
    s.add_clause([var(ridx[0], fixed)])
    s.conf_budget(conf)
    ok = s.solve_limited()
    if ok is None:
        return "unknown", None
    if not ok:
        return "unsat", None
    m = set(x for x in s.get_model() if x > 0)
    colr = [next(c for c in range(k) if var(r, c) in m) for r in range(R)]
    col = [taupow[exp[z]][colr[ridx[rep[z]]]] for z in range(n)]
    assert all(col[u] != col[v] for (u, v) in E), "INSTRUMENT CATASTROPHE: the expanded model is not a proper colouring"
    assert all(col[act(z)] == tau[col[z]] for z in range(n)), "INSTRUMENT CATASTROPHE: the expanded model is not equivariant"
    return "sat", col


def _equivariant_row(args):
    p, k, o, g, ct, tau, conf, fat = args
    t0 = time.time()
    if fat:
        st, col = equivariant_colouring(p, k, g, tau, conf)
    else:
        st, col = equivariant_quotient(p, k, g, o, tau, conf, E=_EQ_EDGES.get(p))
    return dict(rotation_order=o, rotation=g, tau=list(tau), tau_cycle_type=list(ct), status=st,
                seconds=round(time.time() - t0, 1), colouring=col)


_EQ_EDGES = {}


def cmd_equivariant(a):
    """Rows are independent SAT asks and run --jobs at a time (a fork pool: the edge list is built once in the parent
    and inherited; Python 3.14's default start method would re-import and rebuild it per worker). Each row is logged
    the moment it completes; the record lists rows in (order, cycle type) order regardless."""
    import multiprocessing as mp
    p, k = a.p, a.k
    by_order = {}
    for g, o in rotations(p):
        by_order.setdefault(o, g)
    reps = perm_class_reps(k)
    specs = []
    for o in sorted(by_order):
        if o == 1 or (a.orders and o not in a.orders):
            continue
        g = by_order[o]
        for ct, (tau, to) in reps.items():
            if o % to != 0:
                continue
            specs.append((p, k, o, g, ct, tau, a.conf, a.fat))
    if not a.fat:
        _EQ_EDGES[p] = ud_edges(p)[0]
    rows = []
    def log(r):
        st = r["status"]; tau = r["tau"]
        word = {"sat": "a colouring verified proper and equivariant", "unsat": ("no τ-fixed colour for the origin (trivial)" if not any(tau[c] == c for c in range(k)) else "the solver's refusal"), "unknown": f"unknown at {a.conf} conflicts"}[st]
        print(f"[equivariant] p={p} k={k}: rotation of order {r['rotation_order']:2d}, τ of cycle type {tuple(r['tau_cycle_type'])}: {st.upper():7s} — {word} [{r['seconds']}s]", flush=True)
    t0 = time.time()
    if a.jobs > 1:
        with mp.get_context("fork").Pool(a.jobs) as pool:
            for r in pool.imap_unordered(_equivariant_row, specs):
                rows.append(r); log(r)
    else:
        for sp in specs:
            r = _equivariant_row(sp); rows.append(r); log(r)
    rows.sort(key=lambda r: (r["rotation_order"], [-x for x in r["tau_cycle_type"]]))
    out = dict(kind="fplane-equivariant", p=p, k=k, conflict_budget=a.conf, formulation=("fat" if a.fat else "quotient"), jobs=a.jobs,
               seconds=round(time.time() - t0, 1), rows=rows,
               claim_scope="colourings of UD(F_p,2) with col(r z) = τ(col z) for one rotation r of each order about the origin and one τ per "
                           "conjugacy class of S_k of compatible order (conjugate τ and the rotation's other generators give equivalent instances); "
                           "sat: a colouring verified proper and equivariant ON THE FULL PLANE (the quotient is only the instrument); unsat: the solver's refusal at the conflict budget (untrusted); "
                           "unknown: the budget ran out — a refusal of every class says a k-colouring has no rotational symmetry, not that none exists")
    print(f"[equivariant] p={p} k={k}: {len(rows)} rows, {sum(r['status']=='sat' for r in rows)} sat / {sum(r['status']=='unsat' for r in rows)} unsat / {sum(r['status']=='unknown' for r in rows)} unknown, {out['seconds']}s wall, {a.jobs} jobs, {out['formulation']}", flush=True)
    if a.out:
        json.dump(out, open(a.out, "w"), indent=1); print(f"  wrote {a.out}")
    return out


def field_q27():
    """F_27 = F_3[t]/(t³ − t − 1): elements as coefficient triples; returns (elements, add, mul, one)"""
    els = [(a, b, c) for a in range(3) for b in range(3) for c in range(3)]
    def add(u, v): return tuple((x + y) % 3 for x, y in zip(u, v))
    def mul(u, v):
        r = [0] * 5
        for i in range(3):
            for j in range(3):
                r[i + j] = (r[i + j] + u[i] * v[j]) % 3
        r[2] = (r[2] + r[4]) % 3; r[1] = (r[1] + r[4]) % 3
        r[1] = (r[1] + r[3]) % 3; r[0] = (r[0] + r[3]) % 3
        return tuple(r[:3])
    return els, add, mul, (1, 0, 0)


def graph_q27():
    """The plane UD(F_27, 2) as (vertices, edges, circle, edges_sha256).  Vertex (x, y) is indexed by the
    base-3 digits of x followed by those of y, so this index is `enc` of tools/fplane_periodic_subgroups.py
    with place values [243, 81, 27, 9, 3, 1] and the two tools' edge hashes are comparable.  The hash is over
    `repr` of the sorted edge list of index pairs (min, max).  chi_q AND the self-test both call this, so the
    self-test asserts on the graph the tool ships rather than on a second copy of the edge rule."""
    els, add, mul, one = field_q27()
    circ = [(s, t) for s in els for t in els if add(mul(s, s), mul(t, t)) == one]
    assert len(circ) == 28, "the circle over F_27 must have q + 1 = 28 points (q ≡ 3 mod 4)"
    V = [(x, y) for x in els for y in els]; idx = {v: i for i, v in enumerate(V)}
    E = sorted({(min(idx[(x, y)], idx[(add(x, s), add(y, t))]), max(idx[(x, y)], idx[(add(x, s), add(y, t))])) for (x, y) in V for (s, t) in circ})
    return V, E, circ, hashlib.sha256(repr(E).encode()).hexdigest()


def chi_q(q: int, k, conf: int):
    """the unit-quadrance graph over F_q for q = p^f, f odd (only 27 is built): χ by budgeted SAT"""
    assert q == 27, "only F_27 = F_3[t]/(t^3 - t - 1) is implemented (the next odd-degree planes, 343 and 1331, are spectral: ≥ 6)"
    V, E, circ, ehash = graph_q27()
    rows = []; chi = None; col = None
    for kk in ([k] if k else range(2, 12)):
        t0 = time.time(); st, c = sat_colour_budget(len(V), E, kk, conf=conf)
        rows.append(dict(k=kk, status=st, seconds=round(time.time() - t0, 1)))
        word = {"sat": "a verified colouring", "unsat": "the solver's refusal", "unknown": f"unknown at {conf} conflicts"}[st]
        print(f"[chi] UD(F_{q},2): {len(V)} vertices, degree {len(circ)}, k={kk}: {st.upper()} — {word} [{rows[-1]['seconds']}s]", flush=True)
        if st == "sat":
            chi, col = kk, c; break
        if st == "unknown":
            break
    exact = chi is not None and any(r["k"] == chi - 1 and r["status"] == "unsat" for r in rows)
    return dict(kind="fplane-chi-oddegree", q=q, p=3, f=3, modulus="t^3 - t - 1", n=len(V), edges=len(E), degree=len(circ), edges_sha256=ehash,
                conflict_budget=conf, rows=rows, chi=chi, exact=exact, colouring=col, claim_scope="the plane over the residue field F_27 (a cubic field's inert prime above 3 sees it): chi carries a verified colouring; "
                                            "chi − 1 refused is the solver's claim (untrusted); unknown at the conflict budget is silence")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("chi"); p.add_argument("--p", type=int); p.add_argument("--q", type=int, help="the odd-degree plane over F_q (q = 27 only)"); p.add_argument("--k", type=int); p.add_argument("--wall", type=float); p.add_argument("--out")
    p.add_argument("--conf", type=int, default=20_000_000, help="conflict budget for --q")
    p.add_argument("--pin-clique", action="store_true", help="pin a maximal clique through the origin (breaks the palette symmetry)"); p.set_defaults(f=cmd_chi)
    p = sub.add_parser("spectral"); p.add_argument("--p", type=int); p.add_argument("--all-below", type=int, default=600); p.add_argument("--out"); p.set_defaults(f=cmd_spectral)
    p = sub.add_parser("shadow")
    p.add_argument("--seed", action="store_true"); p.add_argument("--object"); p.add_argument("--witness"); p.add_argument("--heule510", action="store_true")
    p.add_argument("--degrey", action="store_true"); p.add_argument("--field16"); p.add_argument("--graph"); p.add_argument("--planted"); p.add_argument("--gen1", action="store_true", help="the de Grey gen-1 half-spindle closure (24,065 points)")
    p.add_argument("--p", type=int, required=True); p.add_argument("--k", type=int); p.add_argument("--wall", type=float); p.add_argument("--out"); p.set_defaults(f=cmd_shadow)
    p = sub.add_parser("map"); p.add_argument("--fields", help="extra fields as NAME:d1,d2;NAME2:…"); p.add_argument("--bound", type=int, default=600); p.add_argument("--out"); p.set_defaults(f=cmd_map)
    p = sub.add_parser("usable"); p.add_argument("--rads", required=True); p.add_argument("--bound", type=int, default=600); p.set_defaults(f=cmd_usable)
    p = sub.add_parser("reduce")
    p.add_argument("--seed", action="store_true"); p.add_argument("--object"); p.add_argument("--witness"); p.add_argument("--heule510", action="store_true")
    p.add_argument("--degrey", action="store_true"); p.add_argument("--field16"); p.add_argument("--graph"); p.add_argument("--planted")
    p.add_argument("--p", type=int, required=True); p.add_argument("--roots", help="d:r,... the residue of each √d (default: the least square root mod p, 0 if ramified)")
    p.add_argument("--colouring", help="a chi-p<P>.json record whose colouring is pulled back"); p.add_argument("--out"); p.set_defaults(f=cmd_reduce)
    p = sub.add_parser("periodic"); p.add_argument("--below", type=int, default=100); p.add_argument("--conf", type=int, default=2_000_000); p.add_argument("--out"); p.set_defaults(f=cmd_periodic)
    p = sub.add_parser("theta"); p.add_argument("--below", type=int, default=100); p.add_argument("--out"); p.set_defaults(f=cmd_theta)
    p = sub.add_parser("alpha"); p.add_argument("--p", type=int, required=True); p.add_argument("--N", type=int); p.add_argument("--wall", type=float, default=3600); p.add_argument("--out"); p.set_defaults(f=cmd_alpha)
    p = sub.add_parser("equivariant"); p.add_argument("--p", type=int, required=True); p.add_argument("--k", type=int, required=True); p.add_argument("--conf", type=int, default=5_000_000); p.add_argument("--out"); p.add_argument("--jobs", type=int, default=1, help="rows in parallel (a fork pool)"); p.add_argument("--fat", action="store_true", help="the pre-2026-09-14 full-plane formulation (the control for the quotient)"); p.add_argument("--orders", type=lambda x: [int(t) for t in x.split(",")], default=None, help="only these rotation orders"); p.set_defaults(f=cmd_equivariant)
    p = sub.add_parser("self-test"); p.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))
    a = ap.parse_args(); a.f(a)


if __name__ == "__main__":
    main()
