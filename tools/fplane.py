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


def colourable(n: int, E, k: int, wall: float | None = None):
    """(status, colouring): SAT with a verified colouring, UNSAT, or unknown (wall). One-hot with two pins."""
    from pysat.solvers import Solver
    var = lambda v, c: v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(n)]
    cl += [[-var(v, c1), -var(v, c2)] for v in range(n) for c1 in range(k) for c2 in range(c1 + 1, k)]
    cl += [[-var(u, c), -var(v, c)] for u, v in E for c in range(k)]
    cl.append([var(0, 0)])
    nb = next((v for u, v in E if u == 0), None)
    if nb is not None and k > 1:
        cl.append([var(nb, 1)])
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


def cmd_chi(a):
    p = a.p; E, deg = ud_edges(p); n = p * p
    ks = [a.k] if a.k else list(range(2, p + 2))
    out = dict(kind="fplane-chi", p=p, n=n, edges=len(E), degree=deg, rows=[])
    t0 = time.time(); chi = None
    for k in ks:
        st, col = colourable(n, E, k, wall=a.wall)
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
    print(f"[fplane] χ(UD(F_{p},2)) {'=' if exact else '≤'} {chi}" if chi else f"[fplane] UD(F_{p},2): no colouring found up to the wall")
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
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + ', '.join(fails)}")
    return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("chi"); p.add_argument("--p", type=int, required=True); p.add_argument("--k", type=int); p.add_argument("--wall", type=float); p.add_argument("--out"); p.set_defaults(f=cmd_chi)
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
