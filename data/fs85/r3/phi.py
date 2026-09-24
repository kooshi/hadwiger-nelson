"""FS-85 R3: the order-10 part of Theta_{-2..2}, computed exactly from its definition (no colouring is enumerated).
A character pi/2 + theta5 (pi in F2^4, t in F5^4, acting on coords9) lies in Z_k iff some j in {0,1,2} has
pi(u_jk) = 1 and t.u_jk = 0 mod 5."""
import itertools, collections
from lat import UNITS

def dot(a, b, m): return sum(x*y for x, y in zip(a, b)) % m

def r_p(v):      # reduction at p  (w -> z in F4 = F2[z]/(z^2+z+1)); returns (x0, x1) for x0 + x1 z
    a, b, c, d = [x % 2 for x in v]
    return ((a + d) % 2, (b + c + d) % 2)
def r_pp(v):     # reduction at p' (w -> z^2)
    a, b, c, d = [x % 2 for x in v]
    return ((a + c + d) % 2, (b + c) % 2)

FAM = {k: [UNITS[(j, k)] for j in range(3)] for k in range(-4, 5)}
F2 = list(itertools.product(range(2), repeat=4))
F5 = list(itertools.product(range(5), repeat=4))

def admissible(pi):
    return all(sum(1 for u in FAM[k] if dot(pi, u, 2) == 0) == 1 for k in range(-4, 5))
ADM = [pi for pi in F2 if any(pi) and admissible(pi)]

def phi(pi, K=range(-2, 3)):
    return [t for t in F5 if any(t) and all(any(dot(pi, u, 2) == 1 and dot(t, u, 5) == 0 for u in FAM[k]) for k in K)]

def prime_of(pi):
    """pi = lambda o r_q: find q and lambda (lambda a functional on F4 = F2^2)."""
    out = []
    for name, r in (("p", r_p), ("p'", r_pp)):
        for lam in [(1, 0), (0, 1), (1, 1)]:
            if all(dot(pi, v, 2) == (lam[0]*r(v)[0] + lam[1]*r(v)[1]) % 2 for v in itertools.product(range(2), repeat=4)):
                out.append((name, lam))
    return out

if __name__ == "__main__":
    print("admissible pair indices:", len(ADM))
    tot = 0
    for pi in ADM:
        P = phi(pi); tot += len(P)
        # linear span over F5 and the 'lines' structure
        lines = collections.Counter(min(tuple((c*x) % 5 for x in t) for c in range(1, 5)) for t in P)
        print(pi, prime_of(pi), "|Phi| =", len(P), "lines:", len(lines), "sizes", sorted(lines.values()))
        for L in lines: print("     line rep", L)
    print("total order-10 characters:", tot)
    # the outer families: does any order-10 character survive families +-3, +-4 ?
    for pi in ADM:
        print(pi, "Phi over -3..3:", len(phi(pi, range(-3, 4))), " over -4..4:", len(phi(pi, range(-4, 5))))
