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
import argparse, json, math, sys, time
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


def cmd_chi(a):
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
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("chi"); p.add_argument("--p", type=int, required=True); p.add_argument("--k", type=int); p.add_argument("--wall", type=float); p.add_argument("--out")
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
    p = sub.add_parser("self-test"); p.set_defaults(f=lambda a: sys.exit(0 if self_test() else 1))
    a = ap.parse_args(); a.f(a)


if __name__ == "__main__":
    main()
