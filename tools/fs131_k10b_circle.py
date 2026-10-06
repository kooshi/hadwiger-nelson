#!/usr/bin/env python3
"""FS131-K10b: [MMST1996] Theorem 3 at n = 2, checked on small fields before it is imported.

Claim checked (the Lean axiom's statement): F a finite field of odd characteristic p, q = |F|, e(u) = exp(2 pi i Tr(u)/p),
a != 0 in F, b != 0 in F^2:  | sum over s in F^2 with s1^2 + s2^2 = a of e(b1 s1 + b2 s2) | <= 2 sqrt(q).
Floating point (cmath), so [measured]: the script reports the least margin 2 sqrt(q) - |lambda| over all (a, b).

--fault : drop the hypothesis a != 0 (the paper's statement as printed, p. 231). Expected: a violation at q = 13
          (a = 0, b isotropic: lambda = q - 1).  Exit 1 when a violation is found, 0 otherwise.
Fields: F_p for p in PRIMES; F_9, F_25, F_27, F_49 as F_p[t]/(f), f irreducible (checked by brute force: no root for
degree 2 and 3).
"""
import cmath, itertools, math, sys

PRIMES = [3, 5, 7, 11, 13, 17, 19, 23]
EXT = [(3, (1, 0, 1)), (5, (2, 0, 1)), (3, (1, 2, 0, 1)), (7, (1, 0, 1))]  # t^2+1 /F3, t^2+2 /F5, t^3+2t+1 /F3, t^2+1 /F7


class Field:
    def __init__(self, p, f=None):
        self.p = p
        self.f = f
        self.k = 1 if f is None else len(f) - 1
        self.q = p ** self.k
        if f is not None:
            assert all(sum(c * pow(x, i, p) for i, c in enumerate(f)) % p for x in range(p)), "f has a root"
        self.elems = list(itertools.product(range(p), repeat=self.k))
        self.zero = (0,) * self.k
        self.one = (1,) + (0,) * (self.k - 1)

    def add(self, x, y):
        return tuple((a + b) % self.p for a, b in zip(x, y))

    def mul(self, x, y):
        r = [0] * (2 * self.k - 1)
        for i, a in enumerate(x):
            for j, b in enumerate(y):
                r[i + j] += a * b
        if self.f is not None:
            for d in range(2 * self.k - 2, self.k - 1, -1):
                c = r[d]
                for i in range(self.k + 1):
                    r[d - self.k + i] -= c * self.f[i]
        return tuple(c % self.p for c in r[: self.k])

    def trace(self, x):
        t, y = self.zero, x
        for _ in range(self.k):
            t = self.add(t, y)
            z = self.one
            for _ in range(self.p):
                z = self.mul(z, y)
            y = z
        assert all(c == 0 for c in t[1:]), "trace not in the prime field"
        return t[0]


def check(F, fault):
    w = cmath.exp(2j * cmath.pi / F.p)
    e = {x: w ** F.trace(x) for x in F.elems}
    sq = {x: F.mul(x, x) for x in F.elems}
    circ = {}
    for s1 in F.elems:
        for s2 in F.elems:
            circ.setdefault(F.add(sq[s1], sq[s2]), []).append((s1, s2))
    worst, bad = math.inf, None
    for a, pts in circ.items():
        if a == F.zero and not fault:
            continue
        for b1 in F.elems:
            for b2 in F.elems:
                if b1 == F.zero and b2 == F.zero:
                    continue
                lam = sum(e[F.add(F.mul(b1, s1), F.mul(b2, s2))] for s1, s2 in pts)
                m = 2 * math.sqrt(F.q) - abs(lam)
                if m < worst:
                    worst, bad = m, (a, (b1, b2), abs(lam))
    return worst, bad


def main():
    fault = "--fault" in sys.argv
    fields = [Field(p) for p in PRIMES] + [Field(p, f) for p, f in EXT]
    viol = 0
    for F in fields:
        worst, bad = check(F, fault)
        flag = "VIOLATION" if worst < -1e-9 else "ok"
        viol += worst < -1e-9
        print(f"q={F.q:3d} (p={F.p}) least margin 2sqrt(q)-|lambda| = {worst:+.6f} at a={bad[0]} b={bad[1]} |lambda|={bad[2]:.6f}  {flag}")
    print("violations:", viol)
    sys.exit(1 if viol else 0)


if __name__ == "__main__":
    main()
