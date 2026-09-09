#!/usr/bin/env python3
"""FS-25 item E3 — the periodic quotient of a finite Euclidean plane, identified.

For p = 3 (mod 4) the finite Euclidean plane UD(F_p, 2) is the Cayley graph on F_p x F_p
with connection set the unit circle a^2 + b^2 = 1.  A PERIODIC proper colouring is constant
on the cosets of a line that misses the circle, so it is a colouring of a circulant on p
vertices (M61 §S3).  That circulant is

    C_p = Cay(Z/p, D),   D = { t : t^2 - 4*nu is a non-square },   nu any fixed non-square,

equivalently the traces of the elements of F_{p^2} of norm nu.  This script checks the
closed form against the DIRECT construction — build the circle, find every circle-missing
line, project along each — and reports |D|, symmetry, 0 not in D, alpha, chi and the
Hoffman bound, so the identification can be audited rather than believed.

    python3 tools/fs25_e3.py            # the eight primes checked against M61's table
    python3 tools/fs25_e3.py --hoffman  # the exact Hoffman bound out to p = 131
"""
import itertools, math, os, subprocess, sys, tempfile

CADICAL = os.path.expanduser(
    "~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")

leg = lambda x, p: 0 if x % p == 0 else (1 if pow(x % p, (p - 1) // 2, p) == 1 else -1)
nonsquare = lambda p: next(v for v in range(2, p) if leg(v, p) == -1)
circle = lambda p: [(a, b) for a in range(p) for b in range(p) if (a * a + b * b) % p == 1]
closed_form = lambda p, nu: sorted(t for t in range(p) if leg(t * t - 4 * nu, p) == -1)


def direct(p):
    """Every circle-missing line, with the connection set obtained by projecting along it."""
    S = set(circle(p))
    out = []
    for (dx, dy) in [(1, m) for m in range(p)] + [(0, 1)]:
        line = {((t * dx) % p, (t * dy) % p) for t in range(p)}
        if line & S:
            continue
        out.append(((dx, dy), tuple(sorted({(-dy * a + dx * b) % p for a, b in S}))))
    return out


def sat(clauses, nvars, timeout=300):
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False) as f:
        f.write(f"p cnf {nvars} {len(clauses)}\n")
        for c in clauses:
            f.write(" ".join(map(str, c)) + " 0\n")
        path = f.name
    try:
        r = subprocess.run([CADICAL, "-q", path], capture_output=True, text=True, timeout=timeout)
        return {20: "unsat", 10: "sat"}.get(r.returncode, f"rc{r.returncode}")
    except subprocess.TimeoutExpired:
        return "unknown"
    finally:
        os.unlink(path)


def chi(n, D, cap=13):
    E = sorted({tuple(sorted((v, (v + d) % n))) for v in range(n) for d in D if (v + d) % n != v})
    for k in range(2, cap + 1):
        var = lambda v, c: v * k + c + 1
        cl = [[var(v, c) for c in range(k)] for v in range(n)]
        for v in range(n):
            for c in range(k):
                for d in range(c + 1, k):
                    cl.append([-var(v, c), -var(v, d)])
        for u, w in E:
            for c in range(k):
                cl.append([-var(u, c), -var(w, c)])
        for c in range(1, k):
            cl.append([-var(0, c)])            # pin vertex 0: the graph is vertex-transitive
        st = sat(cl, n * k)
        if st == "sat":
            return str(k)
        if st != "unsat":
            return f">={k} (cap)"
    return f">{cap}"


def alpha(n, D):
    """Exact: vertex-transitive, so some maximum independent set contains 0."""
    adj = {v: {(v + d) % n for d in D} for v in range(n)}
    cand = [v for v in range(1, n) if v not in adj[0]]
    best = 1
    for s in range(2, 10):
        if any(all(b not in adj[a] for a, b in itertools.combinations(comb, 2))
               for comb in itertools.combinations(cand, s - 1)):
            best = s
        else:
            return best
    return best


M61 = {3: (3, 1), 7: (4, 2), 11: (6, 2), 19: (5, 4), 23: (8, 3), 31: (8, 4), 43: (8, 6),
       47: ("[9,10]", 5)}   # plans/M61-local-global-tightness.md §S3


def hoffman(p):
    nu = nonsquare(p); D = closed_form(p, nu)
    lam = [sum(math.cos(2 * math.pi * a * t / p) for t in D) for a in range(1, p)]
    return len(D), min(lam), 1 + len(D) / (-min(lam)), 1 + (p + 1) / (2 * math.sqrt(p))


def main():
    if "--hoffman" in sys.argv:
        print(f"{'p':>5} {'|D|':>5} {'lam_min':>9} {'exact Hoffman':>14} {'so chi >=':>10} {'Weil bound':>11}")
        for p in [23, 31, 43, 47, 59, 67, 71, 79, 83, 103, 107, 127, 131]:
            if p % 4 != 3: continue
            d, lm, h, w = hoffman(p)
            print(f"{p:>5} {d:>5} {lm:>9.4f} {h:>14.4f} {math.ceil(h - 1e-9):>10} {w:>11.4f}")
        return
    print(f"{'p':>4} {'nu':>3} {'|D|':>4} {'(p+1)/2':>8} {'lines':>6} {'closed=direct':>14} "
          f"{'0 not in D':>11} {'D=-D':>6} {'alpha':>6} {'chi':>10} {'M61 (chi,alpha)':>16}")
    for p in [3, 7, 11, 19, 23, 31, 43, 47]:
        nu = nonsquare(p); D = closed_form(p, nu); dq = direct(p)
        ok = all(any(tuple(sorted({(c * t) % p for t in D})) == Dd for c in range(1, p))
                 for _, Dd in dq)
        print(f"{p:>4} {nu:>3} {len(D):>4} {(p+1)//2:>8} {len(dq):>6} {str(ok):>14} "
              f"{str(0 not in D):>11} {str(sorted(D) == sorted((-t) % p for t in D)):>6} "
              f"{alpha(p, D):>6} {chi(p, D):>10} {str(M61.get(p)):>16}")
    print("\n'closed=direct' is: for EVERY circle-missing line, the projected connection set is a")
    print("dilation of the closed form — the predicted equivalence, checked line by line.")
    for p in [3, 7, 11, 19]:
        print(f"  p={p:>3}  D = {closed_form(p, nonsquare(p))}")


if __name__ == "__main__":
    main()
