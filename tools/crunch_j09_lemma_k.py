#!/usr/bin/env python3
"""Crunch job J09 (FS-91 stage 0, blind): exact check of Lemma K1 and of its character-sum count.

Lemma K1 (plans/FS91-S0FV-three-colours-blind.md, stage 2): for q = 3^f with f odd and q >= 27, and every a in F_{q^2}^*,
some t in mu_{q+1} has M_a(t) := Tr_{F_{q^2}/F_9}(a t) in mu_4 = {1, -1, i, -i}.  At q = 3 it FAILS exactly for N(a) = -1
(the four order-3 band characters of Z[i]/3).

The derivation gives the count N_mu4(a) = #{t in mu_{q+1} : M_a(t) in mu_4} = (4/9) [ (q+1) - K(n) + 2 K(-n) ],
n = N_{F_{q^2}/F_q}(a), K(n) = sum_{x in F_q^*} psi(Tr_{F_q/F_3}(x + n/x)), via S(b) = -K(N(b)); Weil then settles q >= 243.
This tool checks, in exact integer arithmetic (the K are integers; psi-sums are reduced symbolically):
  (1) the identity S(b) = -K(N(b)) for every b (q = 3, 27);
  (2) the count formula against brute force for every a (q = 3, 27) and every class of a (q = 243);
  (3) Lemma K1 by brute force.  FINDING (first run, 2026-09-25): K1 is FALSE at q = 27, exactly for the 28 a with N(a) = 1
      (the bracket (q+1) - K(1) + 2K(-1) = 28 - 8 - 20 = 0); it holds at q = 243; it fails at q = 3 exactly on N(a) = -1.
      The tool now ASSERTS these outcomes (the record's route was repaired; K1 is not used);
  (4) the zero count used instead: Z(a) = #{t in mu_{q+1} : Tr_{F_{q^2}/F_3}(a t) = 0} = (q + 1 - 2K(N(a)))/3 against brute
      force, and min_a Z(a) > 0 at q = 27, 243 (so no additive 3-colouring of Gamma_q through a trace), = 0 at q = 3;
  (5) three planted faults, each of which must be caught.
The finite set checked (F_{q^2}^* x mu_{q+1} at q = 27; the norm classes at q = 243) is fixed by the derivation (Weil leaves q = 27;
q = 243 is a control on the Weil margin).  This is the ban's edge ("a complete exact enumeration of a finite set whose extent a
derivation fixed first") and is logged in the record.
"""
import sys
from itertools import product

P = 3


def poly_mulmod(a, b, mod, m):
    """Multiply two polynomials over F_3 given as digit lists (length m) modulo monic `mod` (length m+1)."""
    res = [0] * (2 * m - 1)
    for i, ai in enumerate(a):
        if ai:
            for j, bj in enumerate(b):
                if bj:
                    res[i + j] = (res[i + j] + ai * bj) % P
    for d in range(2 * m - 2, m - 1, -1):
        c = res[d]
        if c:
            for k in range(m + 1):
                res[d - m + k] = (res[d - m + k] - c * mod[k]) % P
    return res[:m]


def to_int(digits):
    v = 0
    for d in reversed(digits):
        v = v * P + d
    return v


def to_digits(v, m):
    out = []
    for _ in range(m):
        out.append(v % P)
        v //= P
    return out


class GF:
    """GF(3^m) by log/antilog tables over a primitive polynomial found deterministically (smallest in lexicographic order)."""

    def __init__(self, m):
        self.m = m
        self.size = P ** m
        self.order = self.size - 1
        for tail in product(range(P), repeat=m):
            mod = list(tail) + [1]
            if mod[0] == 0:
                continue
            exp = self._try(mod)
            if exp is not None:
                self.mod = mod
                self.exp = exp
                break
        self.log = [None] * self.size
        for k, e in enumerate(self.exp):
            self.log[e] = k
        self.digits = [to_digits(v, m) for v in range(self.size)]

    def _try(self, mod):
        """Powers of x modulo `mod`; primitive iff x first returns to 1 after exactly `order` steps."""
        m = self.m
        if m == 1:
            return None
        cur = [1] + [0] * (m - 1)
        exp = []
        for step in range(self.order):
            v = to_int(cur)
            if step > 0 and v == 1:
                return None
            exp.append(v)
            top = cur[-1]                                              # multiply by x, reduce x^m = -sum mod[k] x^k
            cur = [0] + cur[:-1]
            if top:
                cur = [(c - top * mod[k]) % P for k, c in enumerate(cur)]
        return exp if to_int(cur) == 1 else None

    def mul(self, a, b):
        if a == 0 or b == 0:
            return 0
        return self.exp[(self.log[a] + self.log[b]) % self.order]

    def pw(self, a, k):
        if a == 0:
            return 0 if k > 0 else 1
        return self.exp[(self.log[a] * k) % self.order]

    def add(self, a, b):
        da, db = self.digits[a], self.digits[b]
        return to_int([(x + y) % P for x, y in zip(da, db)])

    def neg(self, a):
        return to_int([(-x) % P for x in self.digits[a]])

    def inv(self, a):
        return self.exp[(-self.log[a]) % self.order]


def setup(f, mutate=None):
    q = P ** f
    F = GF(2 * f)
    g = F.exp[1]
    Q2 = q * q
    assert F.size == Q2
    mu = [F.pw(g, k * (q - 1)) for k in range(q + 1)]                  # mu_{q+1}
    assert len(set(mu)) == q + 1
    Fq = [0] + [F.pw(g, k * (q + 1)) for k in range(q - 1)]             # F_q
    F9 = set([0] + [F.pw(g, k * (Q2 - 1) // 8) for k in range(8)])     # F_9
    i = F.pw(g, (Q2 - 1) // 4)
    one = 1
    mone = F.neg(1)
    mu4 = {one, mone, i, F.neg(i)}
    target = mu4
    if mutate == "target-D":                                           # plant: aim at (1+i)mu_4 instead of mu_4
        onepi = F.add(1, i)
        target = {F.mul(onepi, z) for z in mu4}
    assert F.mul(i, i) == mone and 1 + 0 == 1

    def tr_to_F9(y):                                                   # sum_{j<f} y^(9^j)
        s = 0
        for j in range(f):
            s = F.add(s, F.pw(y, 9 ** j))
        return s

    def tr_q_to_F3(y):                                                 # Tr_{F_q/F_3}, y in F_q
        s = 0
        for j in range(f):
            s = F.add(s, F.pw(y, 3 ** j))
        assert s in (0, 1, 2), "trace left F_3"
        return s

    def norm(a):                                                       # N_{F_{q^2}/F_q}(a) = a^(q+1)
        return F.pw(a, q + 1)

    return dict(q=q, F=F, mu=mu, Fq=Fq, F9=F9, i=i, target=target, tr9=tr_to_F9, trq=tr_q_to_F3, norm=norm)


def psi_sum(counts):
    """sum of psi(k) over a multiset of F_3 values, psi(k) = omega^k; returned as an integer when real, else None."""
    c0, c1, c2 = counts[0], counts[1], counts[2]
    # c0 + c1 w + c2 w^2 with w^2 = -1 - w: real iff c1 == c2, value c0 - c1
    if c1 != c2:
        return None
    return c0 - c1


def kloosterman_table(S):
    F, Fq, trq = S["F"], S["Fq"], S["trq"]
    trtab = {y: trq(y) for y in Fq}
    K = {}
    for n in Fq[1:]:
        counts = [0, 0, 0]
        for x in Fq[1:]:
            v = (trtab[x] + trtab[F.mul(n, F.inv(x))]) % 3
            counts[v] += 1
        val = psi_sum(counts)
        assert val is not None, "Kloosterman sum not real"
        K[n] = val
    return K


def S_sum(S, b):
    """S(b) = sum_{t in mu} psi(Tr_{F_{q^2}/F_3}(b t)); Tr_{F_{q^2}/F_3} = Tr_{F_9/F_3} o Tr_{F_{q^2}/F_9}."""
    F = S["F"]
    counts = [0, 0, 0]
    for t in S["mu"]:
        m9 = S["tr9"](F.mul(b, t))
        v = F.add(m9, F.pw(m9, 3))                                     # Tr_{F_9/F_3}
        assert v in (0, 1, 2)
        counts[v] += 1
    return psi_sum(counts)


def count_zeros(S, a):
    F = S["F"]
    c = 0
    for t in S["mu"]:
        m9 = S["tr9"](F.mul(a, t))
        if F.add(m9, F.pw(m9, 3)) == 0:
            c += 1
    return c


def count_target(S, a):
    F = S["F"]
    c = 0
    for t in S["mu"]:
        m9 = S["tr9"](F.mul(a, t))
        assert m9 in S["F9"], "M(t) left F_9"
        if m9 in S["target"]:
            c += 1
    return c


def run(f, full_a=True, mutate=None, formula_sign=+1):
    S = setup(f, mutate=mutate)
    F, q = S["F"], S["q"]
    K = kloosterman_table(S)
    report = {"q": q, "min_count": None, "fail_norms": set(), "formula_mismatch": 0, "identity_mismatch": 0, "checked": 0,
              "min_zeros": None, "zero_mismatch": 0}
    # representatives of a: all of F^* (full) or one per norm class (a -> a*zeta, zeta in mu_{q+1}, preserves the count)
    if full_a:
        As = list(range(1, F.size))
    else:
        g = F.exp[1]
        As = [F.pw(g, k) for k in range(q - 1)]                         # norms g^{k(q+1)} run over F_q^*
    for a in As:
        n = S["norm"](a)
        cnt = count_target(S, a)
        report["checked"] += 1
        pred9 = 4 * ((q + 1) - K[n] + formula_sign * 2 * K[F.neg(n)])
        if 9 * cnt != pred9:
            report["formula_mismatch"] += 1
        if full_a:
            if S_sum(S, a) != -K[n]:
                report["identity_mismatch"] += 1
        z = count_zeros(S, a)
        if 3 * z != (q + 1) - 2 * K[n]:
            report["zero_mismatch"] += 1
        if report["min_zeros"] is None or z < report["min_zeros"]:
            report["min_zeros"] = z
        if report["min_count"] is None or cnt < report["min_count"]:
            report["min_count"] = cnt
        if cnt == 0:
            report["fail_norms"].add(n)
    report["K_values"] = sorted(set(K.values()))
    report["bracket_min"] = min((q + 1) - K[n] + 2 * K[F.neg(n)] for n in K)
    report["minus_one"] = F.neg(1)
    return report


def main():
    ok = True
    out = []
    # q = 3: the lemma fails exactly on N(a) = -1 (positive control: the checker can see avoidance)
    r3 = run(1)
    out.append(f"q=3: checked {r3['checked']} a; min count {r3['min_count']}; failing norms {sorted(r3['fail_norms'])} "
               f"(-1 = {r3['minus_one']}); formula mismatches {r3['formula_mismatch']}; S=-K mismatches {r3['identity_mismatch']}")
    out.append(f"q=3: zero counts of Tr(a t) on mu_4: min {r3['min_zeros']} (expected 0: the four order-3 characters); "
               f"zero-formula mismatches {r3['zero_mismatch']}")
    ok &= r3["fail_norms"] == {r3["minus_one"]} and r3["formula_mismatch"] == 0 and r3["identity_mismatch"] == 0
    ok &= r3["min_zeros"] == 0 and r3["zero_mismatch"] == 0
    # q = 27: the case Weil leaves open
    r27 = run(3)
    out.append(f"q=27: checked {r27['checked']} a; min count {r27['min_count']}; failing norms {sorted(r27['fail_norms'])}; "
               f"formula mismatches {r27['formula_mismatch']}; S=-K mismatches {r27['identity_mismatch']}; "
               f"K values {r27['K_values']}; min bracket (q+1)-K(n)+2K(-n) = {r27['bracket_min']}")
    out.append(f"q=27: K1 FALSE exactly on N(a) = 1 (expected, the finding): {r27['fail_norms'] == {1}}; zero counts: min "
               f"{r27['min_zeros']} (> 0 needed); zero-formula mismatches {r27['zero_mismatch']}")
    ok &= r27["fail_norms"] == {1} and r27["formula_mismatch"] == 0 and r27["identity_mismatch"] == 0
    ok &= r27["min_zeros"] > 0 and r27["zero_mismatch"] == 0
    # q = 243: control on the Weil margin (one a per norm class)
    r243 = run(5, full_a=False)
    out.append(f"q=243: checked {r243['checked']} norm classes; min count {r243['min_count']}; formula mismatches "
               f"{r243['formula_mismatch']}; K range [{min(r243['K_values'])}, {max(r243['K_values'])}] vs 2*sqrt(243) = 31.18; "
               f"min bracket {r243['bracket_min']} vs Weil floor 244 - 6*sqrt(243) = 150.47")
    out.append(f"q=243: zero counts min {r243['min_zeros']}; zero-formula mismatches {r243['zero_mismatch']}")
    ok &= r243["min_count"] > 0 and r243["formula_mismatch"] == 0 and r243["bracket_min"] >= 244 - 6 * 243 ** 0.5
    ok &= r243["min_zeros"] > 0 and r243["zero_mismatch"] == 0
    # plants: each must be caught
    p1 = run(3, mutate="target-D")
    fired1 = p1["formula_mismatch"] > 0
    out.append(f"PLANT target-D at q=27 (count (1+i)mu_4 against the mu_4 formula): formula mismatches {p1['formula_mismatch']} "
               f"-> {'FIRED' if fired1 else 'SILENT'}")
    p2 = run(3, formula_sign=-1)
    fired2 = p2["formula_mismatch"] > 0
    out.append(f"PLANT sign flip +2K(-n) -> -2K(-n) at q=27: formula mismatches {p2['formula_mismatch']} -> "
               f"{'FIRED' if fired2 else 'SILENT'}")
    p3 = run(1, mutate="target-D")
    fired3 = p3["fail_norms"] != {p3["minus_one"]}
    out.append(f"PLANT target-D at q=3 (the failing class must move): failing norms {sorted(p3['fail_norms'])} -> "
               f"{'FIRED' if fired3 else 'SILENT'}")
    ok &= fired1 and fired2 and fired3
    for line in out:
        print(line)
    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
