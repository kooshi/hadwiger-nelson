#!/usr/bin/env python3
"""FS103-V2: stable places and level-one spectra for Q(sqrt635087) and F_dG = Q(sqrt3,sqrt5,sqrt7,sqrt11).

A finite place v of F is STABLE iff i is not in F_v.  For odd p that is: the residue field F_q of F_v has q = 3 (mod 4)
(Hensel; ramification of F_v/Q_p is irrelevant because Q_p(i)/Q_p is unramified).  Two independent code paths:
  path A: PARI idealprimedec on the field (residue degree f, ramification e), then q = p^f;
  path B: Legendre symbols / Frobenius order by hand (unramified p only).
Dyadic places are classified by PARI: v stable iff the prime of F above 2 does not split in L = F(i).
Level one: the compact piece's eigenvalues lambda(xi) = sum_{t in mu_{q+1}} psi(Tr(xi t)), q prime, computed in
float64 over F_{q^2} = F_q[x]/(x^2+1) (q = 3 mod 4); max|lambda|/(q+1) reported beside Weil's 2 sqrt(q)/(q+1).
Float error: each of q+1 cosines is accurate to ~1e-15, so |error| < 1e-12, far below every margin tested.

Plants (--plant NAME) must make the run FAIL, each for its own reason:
  legendre-flip : path B uses (d/p) -> (p/d) reversed reciprocity sign; A and B must disagree.
  wrong-torus   : spectrum over mu_{q-1} (the split torus, inside F_q) instead of mu_{q+1}; ratio jumps to 1-ish.
  stable-mod    : call p = 1 (mod 4) stable; the "no stable place below 103" assertion must fail.
"""
import math, subprocess, sys

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None


def gp(script):
    r = subprocess.run(["gp", "-q", "-f"], input=script, capture_output=True, text=True, timeout=600)
    if r.returncode != 0 or "***" in r.stdout or "***" in r.stderr:
        raise SystemExit("GP FAILED:\n" + r.stdout + r.stderr)
    return r.stdout


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


# ---------- path A: PARI ----------
def pari_places(pol, bound):
    """For each prime p < bound: list of (p, e, f) for primes of F above p, plus dyadic stability in L=F(i)."""
    out = gp(f"""
K = nfinit({pol});
forprime(p = 2, {bound}, D = idealprimedec(K, p); for(j = 1, #D, print(p, " ", D[j].e, " ", D[j].f)));
L = nfinit(polcompositum({pol}, x^2 + 1)[1]);
\\\\ dyadic: number of primes of L above 2 vs of K above 2 with degrees
DK = idealprimedec(K, 2); DL = idealprimedec(L, 2);
print("DYADIC K ", #DK, " ", vector(#DK, j, [DK[j].e, DK[j].f]));
print("DYADIC L ", #DL, " ", vector(#DL, j, [DL[j].e, DL[j].f]));
""")
    rows, dy = [], []
    for line in out.splitlines():
        if line.startswith("DYADIC"):
            dy.append(line)
        elif line.strip():
            p, e, f = map(int, line.split())
            rows.append((p, e, f))
    return rows, dy


def stable_A(rows):
    st = []
    for p, e, f in rows:
        if p == 2:
            continue
        q = p ** f
        is_stable = (q % 4 == 3) if PLANT != "stable-mod" else (q % 4 in (1, 3))
        if is_stable:
            st.append((p, e, f, q))
    return st


# ---------- path B: Frobenius by hand (unramified odd p) ----------
def frob_degree(p, radicands):
    syms = []
    for d in radicands:
        s = legendre(d, p)
        if PLANT == "legendre-flip" and s != 0 and d % 4 == 3 and p % 4 == 3:
            s = -s  # the classic reciprocity slip
        syms.append(s)
    return 1 if all(s == 1 for s in syms) else 2


def check_field(name, pol, radicands, bound, ramified, first_expected):
    rows, dy = pari_places(pol, bound)
    stA = stable_A(rows)
    # path B over unramified odd primes
    stB = []
    for p in sorted({r[0] for r in rows}):
        if p == 2 or p in ramified:
            continue
        f = frob_degree(p, radicands)
        if (p ** f) % 4 == 3:
            stB.append(p)
    primesA_unram = sorted({s[0] for s in stA if s[0] not in ramified})
    assert primesA_unram == stB, f"{name}: path A {primesA_unram[:10]} != path B {stB[:10]}"
    stable_primes = sorted({s[0] for s in stA})
    assert stable_primes[: len(first_expected)] == first_expected, f"{name}: first stable primes {stable_primes[:8]}"
    print(f"{name}: stable places below {bound} (p, e, f, q): {len(stA)} places over {len(stable_primes)} primes")
    print(f"  first stable primes: {stable_primes[:12]}")
    for p in ramified:
        print(f"  above ramified p={p}: {[(e, f, p**f % 4) for (pp, e, f) in rows if pp == p]}  (stable iff q=p^f = 3 mod 4)")
    print("  " + "\n  ".join(dy))
    return stA


def level_one_ratio(q, torus="norm"):
    """max |sum_{t in T} psi(Tr xi t)| / |T| over xi != 0, F_{q^2} = F_q[i], q prime = 3 mod 4."""
    # elements a + b i; norm a^2 + b^2
    if torus == "norm":
        T = [(a, b) for a in range(q) for b in range(q) if (a * a + b * b) % q == 1]
        assert len(T) == q + 1
    else:  # the split torus inside F_q (the wrong one)
        T = [(a, 0) for a in range(1, q)]
    # Tr(xi t) for xi = x + y i, t = a + b i: xi t = (xa - yb) + (xb + ya) i, Tr = 2(xa - yb)
    best = 0.0
    tw = 2 * math.pi / q
    for x in range(q):
        for y in range(q):
            if x == 0 and y == 0:
                continue
            s = sum(math.cos(tw * ((2 * (x * a - y * b)) % q)) for a, b in T)
            best = max(best, abs(s))
    return best / len(T)


def main():
    fails = 0
    try:
        # --- Q(sqrt 635087) ---
        d = 635087
        out = gp(f"print(isprime({d}), \" \", {d} % 8, \" \", {d} % 4)")
        pr, m8, m4 = map(int, out.split())
        assert pr == 1 and m8 == 7, "635087 not a prime = 7 mod 8"
        small = [p for p in range(3, 103) if all(p % r for r in range(2, int(p**0.5) + 1)) and p % 4 == 3]
        inert = [p for p in small if legendre(d, p) == -1]
        print(f"635087 prime={pr}, mod 8 = {m8}; primes p=3 mod 4 below 103: {len(small)}, inert in F: {len(inert)}")
        assert inert == small, "some p = 3 mod 4 below 103 is not inert"
        st635 = check_field("Q(sqrt635087)", "x^2 - 635087", [d], 1000, [d] if d < 1000 else [],
                            [103, 107, 127, 163, 191])
        # the ramified prime itself (beyond the bound): residue F_635087, 635087 = 3 mod 4 -> stable
        print(f"  ramified 635087: residue F_p, p mod 4 = {m4} -> stable (odd, q = 3 mod 4)")
        # --- F_dG ---
        pol = gp("print(polcompositum(polcompositum(x^2-3, x^2-5)[1], polcompositum(x^2-7, x^2-11)[1])[1])").strip()
        stdG = check_field("F_dG", pol, [3, 5, 7, 11], 600, [3, 5, 7, 11], [131, 479])
        # --- level-one spectra ---
        for q in (103, 131):
            r = level_one_ratio(q, "norm" if PLANT != "wrong-torus" else "split")
            w = 2 * math.sqrt(q) / (q + 1)
            print(f"q={q}: max|lambda|/(q+1) = {r:.6f}; Weil 2sqrt(q)/(q+1) = {w:.6f}; new levels <= 2/(q+1) = {2/(q+1):.6f}")
            assert r <= w + 1e-9, f"q={q}: exceeds Weil"
            assert r < 0.2, f"q={q}: not below 1/5"
    except AssertionError as e:
        print("FAIL:", e)
        fails += 1
    if fails:
        print("RESULT: FAIL" + (f" (plant {PLANT})" if PLANT else ""))
        sys.exit(1)
    print("RESULT: PASS")


if __name__ == "__main__":
    main()
