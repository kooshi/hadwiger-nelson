#!/usr/bin/env python3
"""X23D: exact least eigenvalue of U_Q = Cay(F_{Q^2}, mu_{Q+1}) for Q a power of 2 or 3.

Why: CLS needs the all-levels four-colour ratio at a stable place with residue field F_27 (the one usable non-prime q below
Weil's 1/4 threshold q > 33.97).  For Q = p^f with p in {2, 3} the eigenvalues
    lambda_xi = sum_{u in mu_{Q+1}} psi(Tr_{F_{Q^2}/F_p}(xi u)),  psi(a) = exp(2 pi i a / p)
are integers (the connection set is symmetric, -1 in mu_{Q+1} for odd Q; for p = 2 psi is +-1), so the computation is exact
integer arithmetic.  For p = 3 a real value N0 + N1 w + N2 w^2 forces N1 = N2 and equals N0 - N1.

Controls (known from held results):
  Q = 3  : lambda_min = -2  (Gamma_3 = Cay(F_9, mu_4), Hoffman-tight at three colours, G54)
  Q = 2  : lambda_min = -1  (U_2 = K_4)
  Q = 32 : lambda_min = -11 (U_32 Hoffman-tight at four colours, -d/3 = -33/3; G54)
  Q = 64 : lambda_min = -15 (G56: "at Q = 64 its Hoffman floor is 6 (lambda_min = -15)")
Plants (--plant NAME): 'mu-minus'  uses mu_{Q-1} in place of mu_{Q+1};
                       'drop-pair' removes one inverse pair {u, u^-1}, u != +-1, from mu_{Q+1} (symmetric, so reality holds);
                       'trace-coord' uses the first coordinate in place of the trace -- KEPT AND LABELLED: IT CANNOT FIRE, since
                       every non-zero F_p-linear functional is x -> Tr(cx) for some c != 0, which only permutes the spectrum.
'mu-minus' and 'drop-pair' must turn a control red (exit 1); 'trace-coord' must stay green (the unreachable-plant control).
"""
import sys
from fractions import Fraction


def irreducible(p, k):
    """Least monic irreducible polynomial of degree k over F_p (coefficient list, low degree first), by trial division."""
    from itertools import product

    def polymod(a, m):
        a = a[:]
        while len(a) >= len(m):
            if a[-1] % p:
                c = a[-1] * pow(m[-1], -1, p) % p
                sh = len(a) - len(m)
                for i, mi in enumerate(m):
                    a[sh + i] = (a[sh + i] - c * mi) % p
            a.pop()
        return a

    def has_factor(f):
        for d in range(1, k // 2 + 1):
            for coeffs in product(range(p), repeat=d):
                g = list(coeffs) + [1]
                r = polymod(f, g)
                if all(x % p == 0 for x in r):
                    return True
        return False

    for coeffs in product(range(p), repeat=k):
        f = list(coeffs) + [1]
        if f[0] == 0:
            continue
        if not has_factor(f):
            return f
    raise ValueError


class GF:
    def __init__(self, p, k):
        self.p, self.k, self.n = p, k, p ** k
        self.mod = irreducible(p, k)
        # elements as integers in base p (digit i = coefficient of x^i)
        self.exp, self.log = None, None
        self._tables()

    def digits(self, a):
        d = []
        for _ in range(self.k):
            d.append(a % self.p)
            a //= self.p
        return d

    def num(self, d):
        a = 0
        for c in reversed(d):
            a = a * self.p + c
        return a

    def mulx(self, a):
        d = [0] + self.digits(a)
        top = d.pop()  # coefficient of x^k
        if top:
            for i in range(self.k):
                d[i] = (d[i] - top * self.mod[i]) % self.p
        return self.num(d)

    def mul_poly(self, a, b):
        res = 0
        da = self.digits(a)
        cur = b
        acc = [0] * self.k
        for c in da:
            if c:
                cd = self.digits(cur)
                acc = [(x + c * y) % self.p for x, y in zip(acc, cd)]
            cur = self.mulx(cur)
        return self.num(acc)

    def _tables(self):
        n = self.n
        for g in range(2, n):
            exp = [1]
            x = 1
            seen = {1}
            ok = True
            for _ in range(n - 2):
                x = self.mul_poly(x, g)
                if x in seen:
                    ok = False
                    break
                seen.add(x)
                exp.append(x)
            if ok and len(exp) == n - 1:
                self.exp = exp
                self.log = {v: i for i, v in enumerate(exp)}
                return
        raise ValueError("no generator")

    def mul(self, a, b):
        if a == 0 or b == 0:
            return 0
        return self.exp[(self.log[a] + self.log[b]) % (self.n - 1)]

    def frob(self, a):
        # a^p
        if a == 0:
            return 0
        return self.exp[(self.log[a] * self.p) % (self.n - 1)]

    def trace_table(self):
        # Tr to F_p is F_p-linear: compute on the basis x^i, extend by digits
        basis_tr = []
        for i in range(self.k):
            b = self.p ** i
            s = b
            t = [0] * self.k
            y = b
            acc = self.digits(y)
            for _ in range(self.k - 1):
                y = self.frob(y)
                acc = [(u + v) % self.p for u, v in zip(acc, self.digits(y))]
            # the trace lies in F_p: all digits but the constant must vanish
            assert all(c == 0 for c in acc[1:]), "trace not in F_p"
            basis_tr.append(acc[0])
        return [sum(c * t for c, t in zip(self.digits(a), basis_tr)) % self.p for a in range(self.n)]


def least_eigenvalue(p, f, plant=None):
    Q = p ** f
    K = GF(p, 2 * f)
    n = K.n
    if plant == "mu-minus":
        order = Q - 1
    else:
        order = Q + 1
    step = (n - 1) // order
    mu = [K.exp[(j * step) % (n - 1)] for j in range(order)]
    assert len(set(mu)) == order
    if plant == "drop-pair":
        u = mu[1]
        uinv = K.exp[(-step) % (n - 1)]
        mu = [x for x in mu if x not in (u, uinv)]
    if plant == "trace-coord":
        tr = [a % p for a in range(n)]
    else:
        tr = K.trace_table()
    lam = {}
    for xi in range(1, n):
        cnt = [0] * p
        for u in mu:
            cnt[tr[K.mul(xi, u)]] += 1
        if p == 2:
            val = cnt[0] - cnt[1]
        else:
            if cnt[1] != cnt[2]:
                raise AssertionError(f"non-real eigenvalue at xi={xi}: {cnt}")
            val = cnt[0] - cnt[1]
        lam[val] = lam.get(val, 0) + 1
    return Q, order, lam


def main():
    plant = None
    if "--plant" in sys.argv:
        plant = sys.argv[sys.argv.index("--plant") + 1]
    controls = {(3, 1): -2, (2, 1): -1, (2, 5): -11, (2, 6): -15}
    ok = True
    for (p, f), want in controls.items():
        try:
            Q, d, lam = least_eigenvalue(p, f, plant)
            got = min(lam)
        except AssertionError as e:
            print(f"CONTROL Q={p**f}: assertion {e}")
            ok = False
            continue
        status = "PASS" if got == want else "FAIL"
        if got != want:
            ok = False
        print(f"CONTROL Q={Q}: degree {d}, lambda_min {got} (expected {want}) {status}")
    # the target
    try:
        Q, d, lam = least_eigenvalue(3, 3, plant)
        lmin = min(lam)
        h = Fraction(-lmin, d - lmin)
        print(f"TARGET Q=27: degree {d}, spectrum (non-trivial chars) {dict(sorted(lam.items()))}")
        print(f"TARGET Q=27: lambda_min = {lmin}; Hoffman ratio |l|/(d+|l|) = {h} = {float(h):.6f}; < 1/4: {h < Fraction(1, 4)}")
        print(f"TARGET Q=27: Hoffman chromatic floor 1 + d/|l| = {1 + Fraction(d, -lmin)} = {float(1 + Fraction(d, -lmin)):.4f}")
        print(f"TARGET Q=27: all-levels primitive bound 2/(q+1) = {Fraction(2, 28)}; all-levels Hoffman = max(level one, primitive)")
    except AssertionError as e:
        print(f"TARGET: assertion {e}")
        ok = False
    print("ALL CONTROLS PASS" if ok else "A CONTROL FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
