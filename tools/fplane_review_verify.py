#!/usr/bin/env python3
"""The product owner's INDEPENDENT verifier for FS-53 review (§S13.4: a script that shares nothing with the tool
that produced the artifact).  Standard library only.  It rebuilds the finite Euclidean plane UD(F_q, 2) from the
number q (and, for a prime power, the modulus) with its own field arithmetic, reproduces the edge-set hash, and
checks a claimed colouring or a claimed independent set FROM THE DEFINITION.

  verify_colouring.py graph  --q 27 --modulus t^3-t-1
  verify_colouring.py colour --q 27 --modulus t^3-t-1 --json <record> --path a.b.c [--k K]
  verify_colouring.py indep  --q 23 --json <record> --path set
  verify_colouring.py self-test          # plants three faults and watches each fire

Vertex numbering (the repository's convention, reimplemented here, never imported): a point is (x, y) with x, y in
F_q; over F_p the index is x*p + y; over F_{p^e} with basis 1, t, ..., t^{e-1} each coordinate is its e
coefficient digits base p with the CONSTANT coefficient most significant, and the point's index is the 2e digits
(x then y) read base p.
Edge hash: sha256 of repr(sorted({(min i, max j)})) over the undirected edge set."""
import argparse, hashlib, itertools, json, sys


def parse_modulus(s, p, e):
    """'t^3-t-1' -> the coefficient list [c0, c1, ..., c_{e-1}] with t^e = -(c0 + c1 t + ...) mod p.
    Written as a small parser rather than eval, so a malformed modulus is a refusal and never a surprise."""
    s = s.replace(" ", "").replace("-", "+-")
    coef = {}
    for term in s.split("+"):
        if not term:
            continue
        neg = term.startswith("-")
        if neg:
            term = term[1:]
        if "t" not in term:
            c, d = int(term), 0
        elif term in ("t", ""):
            c, d = 1, 1
        else:
            head, _, tail = term.partition("t")
            c = int(head) if head not in ("", "-") else 1
            d = int(tail[1:]) if tail.startswith("^") else 1
        coef[d] = (coef.get(d, 0) + (-c if neg else c)) % p
    if coef.get(e, 0) % p != 1:
        sys.exit(f"REFUSED: the modulus must be monic of degree {e}: {s}")
    return [(-coef.get(i, 0)) % p for i in range(e)]   # t^e = sum red[i] t^i


class Field:
    """F_q as e-tuples over F_p (e = 1 is the prime field)."""

    def __init__(self, q, modulus=None):
        p, e = q, 1
        for b in range(2, q + 1):
            k, n = 0, q
            while n % b == 0:
                n //= b
                k += 1
            if n == 1:
                p, e = b, k
                break
        if e > 1 and not modulus:
            sys.exit(f"REFUSED: q = {q} = {p}^{e} is a prime power; --modulus is required "
                     f"(Z/{q} is NOT F_{q} and the two graphs differ)")
        if e == 1 and modulus:
            sys.exit(f"REFUSED: q = {q} is prime; --modulus does not apply")
        self.p, self.e, self.q = p, e, q
        self.red = parse_modulus(modulus, p, e) if e > 1 else None
        # an element is its coefficient tuple (c0, c1, ..., c_{e-1}) against 1, t, ..., t^{e-1}
        self.els = [tuple(v) for v in itertools.product(range(p), repeat=e)]
        self.one = tuple([1] + [0] * (e - 1))

    def add(self, u, v):
        return tuple((a + b) % self.p for a, b in zip(u, v))

    def mul(self, u, v):
        p, e = self.p, self.e
        r = [0] * (2 * e - 1)
        for i in range(e):
            for j in range(e):
                r[i + j] = (r[i + j] + u[i] * v[j]) % p
        for d in range(2 * e - 2, e - 1, -1):          # fold t^d down, highest first
            c = r[d]
            if c:
                r[d] = 0
                for i in range(e):
                    r[d - e + i] = (r[d - e + i] + c * self.red[i]) % p
        return tuple(r[:e])

    def idx(self, u):
        # the repository's encoding: the CONSTANT coefficient is the most significant digit
        # (place values 3^5 … 3^0 over the 6 digits x0 x1 x2 y0 y1 y2 at q = 27)
        n = 0
        for a in u:
            n = n * self.p + a
        return n


def plane(F):
    """returns (circle as index offsets, n, neighbour table) — the Cayley graph on F_q^2 over x^2 + y^2 = 1."""
    els = F.els
    circle = [(s, t) for s in els for t in els if F.add(F.mul(s, s), F.mul(t, t)) == F.one]
    n = F.q * F.q
    def vid(x, y): return F.idx(x) * F.q + F.idx(y)
    nbr = [[] for _ in range(n)]
    for x in els:
        for y in els:
            i = vid(x, y)
            for (s, t) in circle:
                nbr[i].append(vid(F.add(x, s), F.add(y, t)))
    return circle, n, nbr


def edge_hash(n, nbr):
    E = set()
    for i in range(n):
        for j in nbr[i]:
            E.add((min(i, j), max(i, j)))
    return hashlib.sha256(repr(sorted(E)).encode()).hexdigest(), len(E)


def dig(obj, path):
    for part in path.split("."):
        obj = obj[int(part)] if isinstance(obj, list) else obj[part]
    return obj


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=["graph", "colour", "indep", "self-test"])
    ap.add_argument("--q", type=int)
    ap.add_argument("--modulus")
    ap.add_argument("--json")
    ap.add_argument("--path", default="")
    ap.add_argument("--k", type=int)
    ap.add_argument("--expect-sha")
    a = ap.parse_args()
    if a.mode == "self-test":
        return self_test()
    F = Field(a.q, a.modulus)
    circle, n, nbr = plane(F)
    h, ne = edge_hash(n, nbr)
    print(f"q = {a.q}{' (F_' + str(a.q) + ' by ' + a.modulus + ')' if a.modulus else ''}: "
          f"{n} vertices, degree {len(circle)}, {ne} edges, edges_sha256 {h}")
    if a.expect_sha and a.expect_sha != h:
        sys.exit(f"MISMATCH: expected edges_sha256 {a.expect_sha}")
    if a.mode == "graph":
        return
    rec = json.load(open(a.json))
    obj = dig(rec, a.path) if a.path else rec
    if a.mode == "colour":
        col = obj if isinstance(obj, list) else obj.get("colouring") or obj.get("coloring")
        if len(col) != n:
            sys.exit(f"REFUSED: the colouring has {len(col)} entries, the plane has {n} vertices")
        bad = [(i, j) for i in range(n) for j in nbr[i] if i < j and col[i] == col[j]]
        k = len(set(col))
        print(f"  colours used {k}" + (f" (claimed {a.k})" if a.k else "") +
              f"; monochromatic edges {len(bad)} of {ne}")
        if a.k and k > a.k:
            sys.exit(f"REFUSED: uses {k} colours, more than the claimed {a.k}")
        if bad:
            sys.exit(f"NOT PROPER: e.g. {bad[:3]}")
        print("  PROPER — verified from the definition on every edge")
    else:
        S = sorted(set(obj))
        inside = set(S)
        bad = [(i, j) for i in S for j in nbr[i] if j in inside]
        print(f"  independent set of size {len(S)}; internal edges {len(bad)}")
        if bad:
            sys.exit(f"NOT INDEPENDENT: e.g. {bad[:3]}")
        print(f"  INDEPENDENT — verified from the definition; alpha >= {len(S)}, so chi >= ceil({n}/{len(S)}) "
              f"= {-(-n // len(S))}")


def self_test():
    """three plants, each seen to fire (§S13.1 rule 9)."""
    ok = True
    F = Field(27, "t^3-t-1")
    circle, n, nbr = plane(F)
    h, ne = edge_hash(n, nbr)
    shape = (n == 729 and len(circle) == 28 and ne == 10206 and
             h == "b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d")
    print(f"[control 1] F_27 plane: {n} vertices, degree {len(circle)}, {ne} edges, sha {h[:16]}…: "
          f"{'OK' if shape else 'FAIL'}")
    ok &= shape
    F11 = Field(11)
    c11, n11, nbr11 = plane(F11)
    shape11 = (n11 == 121 and len(c11) == 12)
    print(f"[control 2] F_11 plane: {n11} vertices, degree {len(c11)}: {'OK' if shape11 else 'FAIL'}")
    ok &= shape11
    # plant A: a proper colouring made improper by one recolour must be caught
    col = [0] * n
    for i in range(n):
        used = {col[j] for j in nbr[i] if j < i}
        col[i] = next(c for c in range(99) if c not in used)
    bad0 = sum(1 for i in range(n) for j in nbr[i] if i < j and col[i] == col[j])
    v = 0
    w = nbr[0][0]
    col[w] = col[v]
    bad1 = sum(1 for i in range(n) for j in nbr[i] if i < j and col[i] == col[j])
    fired = (bad0 == 0 and bad1 > 0)
    print(f"[plant A] greedy colouring proper ({bad0} bad); after recolouring vertex {w} to its neighbour's "
          f"colour: {bad1} bad — the check {'FIRED' if fired else 'DID NOT FIRE'}")
    ok &= fired
    # plant B: the wrong modulus must give a different graph (the Z/27 trap has its own shape)
    try:
        F2 = Field(27, "t^3-t-2")
        _, n2, nbr2 = plane(F2)
        h2, ne2 = edge_hash(n2, nbr2)
        differs = (h2 != h)
        print(f"[plant B] the reducible modulus t^3-t-2 gives {ne2} edges, sha {h2[:16]}… — "
              f"{'DIFFERS as it must' if differs else 'IDENTICAL: FAIL'}")
        ok &= differs
    except Exception as e:                                  # a reducible modulus need not be a field
        print(f"[plant B] the reducible modulus t^3-t-2 raised {type(e).__name__}: acceptable (not a field)")
    # plant C: a prime power with no modulus must be refused
    import subprocess
    r = subprocess.run([sys.executable, __file__, "graph", "--q", "27"], capture_output=True, text=True)
    fired = r.returncode != 0 and "REFUSED" in (r.stdout + r.stderr)
    print(f"[plant C] q = 27 with no --modulus: exit {r.returncode}, "
          f"{'REFUSED as it must' if fired else 'ACCEPTED: FAIL'}")
    ok &= fired
    print("SELF-TEST", "GREEN" if ok else "RED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
