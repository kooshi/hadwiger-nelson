#!/usr/bin/env python3
"""The product owner's INDEPENDENT verifier for FS-53 review (§S13.4: a script that shares nothing with the tool
that produced the artifact).  Standard library only.  It rebuilds the finite Euclidean plane UD(F_q, 2) from the
number q (and, for a prime power, the modulus) with its own field arithmetic, reproduces the edge-set hash, and
checks a claimed colouring or a claimed independent set FROM THE DEFINITION.

  verify_colouring.py graph  --q 27 --modulus t^3-t-1
  verify_colouring.py window                    # recompute data/fs53/window.md's exact columns from q alone
  verify_colouring.py colour --q 27 --modulus t^3-t-1 --json <record> --path a.b.c [--k K]
  verify_colouring.py indep  --q 23 --json <record> --path set
  verify_colouring.py self-test          # plants five faults and watches each fire

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
    high = sorted(d for d, c in coef.items() if d > e and c % p)
    if high:   # a term above the degree used to be dropped in silence (found by the WO-21 engineer, 2026-09-16)
        sys.exit(f"REFUSED: the modulus has a term of degree {high[-1]} above the field degree {e}: {s}")
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
        if e > 1:   # a reducible modulus gives a ring with zero divisors, not a field: refuse it, naming the pair
            zero = tuple([0] * e)
            for u in self.els[1:]:
                for v in self.els[1:]:
                    if self.mul(u, v) == zero:
                        sys.exit(f"REFUSED: the modulus {modulus} is reducible over F_{p}: the coefficient tuples "
                                 f"{u} * {v} = 0, so F_{p}[t]/({modulus}) is not a field")

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
    """Both conventions in use in this project, over the same sorted undirected edge list.

    `py`   — sha256 of repr(sorted list of (min, max) pairs); what tools/fplane.py and
             tools/fplane_periodic_subgroups.py write as `edges_sha256`.
    `rust` — sha256 of each endpoint as a little-endian u32, in the same sorted order; what
             ~/source/descent-engine's plane-colour and plane-independent write under the SAME
             field name.  Reproduced here (2026-09-15) and confirmed against plane-colour's own
             digest at q = 23, so a record from either toolchain can be checked against the other:
             the two numbers differ only in serialisation, never in the graph."""
    E = sorted({(min(i, j), max(i, j)) for i in range(n) for j in nbr[i]})
    py = hashlib.sha256(repr(E).encode()).hexdigest()
    h = hashlib.sha256()
    for u, v in E:
        h.update(u.to_bytes(4, "little"))
        h.update(v.to_bytes(4, "little"))
    return py, h.hexdigest(), len(E)


def dig(obj, path):
    for part in path.split("."):
        obj = obj[int(part)] if isinstance(obj, list) else obj[part]
    return obj


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=["graph", "colour", "indep", "window", "self-test"])
    ap.add_argument("--q", type=int)
    ap.add_argument("--modulus")
    ap.add_argument("--json")
    ap.add_argument("--path", default="")
    ap.add_argument("--k", type=int)
    ap.add_argument("--expect-sha")
    a = ap.parse_args()
    if a.mode == "self-test":
        return self_test()
    if a.mode == "window":
        return window()
    F = Field(a.q, a.modulus)
    circle, n, nbr = plane(F)
    h, hr, ne = edge_hash(n, nbr)
    print(f"q = {a.q}{' (F_' + str(a.q) + ' by ' + a.modulus + ')' if a.modulus else ''}: "
          f"{n} vertices, degree {len(circle)}, {ne} edges\n  edges_sha256 (python tools) {h}"
          f"\n  edges_sha256 (descent-engine) {hr}")
    if a.expect_sha and a.expect_sha not in (h, hr):
        sys.exit(f"MISMATCH: expected edges_sha256 {a.expect_sha}, got {h} (python) / {hr} (rust)")
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
        # A LOWER bound on alpha gives NO lower bound on chi: chi >= n/alpha needs an UPPER bound on alpha.
        # What a verified set says about colouring is the threshold direction: a k-colouring partitions the
        # n vertices into k independent sets, so it needs alpha >= ceil(n/k) — necessary, never sufficient.
        print(f"  INDEPENDENT — verified from the definition; alpha({n} vertices) >= {len(S)}")
        for k in (5, 6, 7):
            need = -(-n // k)
            verdict = ("this set is at or above that size" if len(S) >= need
                       else f"short by {need - len(S)}: SOME class of a {k}-colouring must be that big, and no "
                            f"set that big is known here — nothing is refuted, the search is simply not there yet")
            print(f"    a {k}-colouring needs alpha >= ceil({n}/{k}) = {need} — {verdict}")
        print("    (the threshold is necessary and never sufficient: the classes must still partition; and a lower\n"
              "     bound on alpha bounds chi from BELOW nowhere — that needs a certified upper bound on alpha)")


# the committed table, data/fs53/window.md: q -> (lambda_min, ratio bound, six needs, frac6, five needs, frac5)
WINDOW = {23: (-7.9607, 131.76, 89, 0.6755, 106, 0.8045),
          27: (-8.0, 162.00, 122, 0.7531, 146, 0.9012),
          31: (-10.6665, 240.25, 161, 0.6701, 193, 0.8033),
          43: (-11.9622, 395.23, 309, 0.7818, 370, 0.9362),
          47: (-12.8465, 466.39, 369, 0.7912, 442, 0.9477),
          59: (-14.9176, 693.14, 581, 0.8382, None, 1.0056),
          67: (-15.0567, 813.78, 749, 0.9204, None, 1.1035),
          79: (-17.1019, 1099.19, 1041, 0.9471, None, 1.1363)}
MODULI = {27: "t^3-t-1"}


def spectrum(F):
    """the adjacency spectrum of UD(F_q,2) as additive character sums over the unit circle.
    The eigenvalue at (a, b) is sum over circle points (x, y) of e_p(Tr(ax + by)), Tr the absolute trace
    F_q -> F_p (x + x^p + ... + x^{p^(e-1)}).  Returns (min, max, degree)."""
    import cmath, math
    els = F.els
    circle = [(s, t) for s in els for t in els if F.add(F.mul(s, s), F.mul(t, t)) == F.one]

    def power(u, e):
        r = F.one
        for _ in range(e):
            r = F.mul(r, u)
        return r

    def trace(u):
        acc = u
        for i in range(1, F.e):
            acc = F.add(acc, power(u, F.p ** i))
        assert all(c == 0 for c in acc[1:]), f"the absolute trace must land in F_{F.p}: {acc}"
        return acc[0]

    z = [cmath.exp(2j * math.pi * k / F.p) for k in range(F.p)]
    lo, hi = None, None
    for a in els:
        for b in els:
            v = sum(z[trace(F.add(F.mul(a, x), F.mul(b, y)))] for (x, y) in circle).real
            lo = v if lo is None or v < lo else lo
            hi = v if hi is None or v > hi else hi
    return lo, hi, len(circle)


def window():
    """recompute every [exact] column of data/fs53/window.md from the number q, and compare."""
    print(f"{'q':>3} {'lam_min here':>13} {'table':>9} {'ratio here':>11} {'table':>8} "
          f"{'six':>5} {'frac6':>7} {'five':>5} {'frac5':>7}  verdict")
    allok = True
    for q, (tl, tr, t6, tf6, t5, tf5) in WINDOW.items():
        F = Field(q, MODULI.get(q))
        lm, lmax, deg = spectrum(F)
        n, d = q * q, q + 1
        ratio = n * (-lm) / (d - lm)                      # Hoffman: alpha <= n|lam_min| / (d + |lam_min|)
        six, five = -(-n // 6), -(-n // 5)                # a k-colouring needs alpha >= ceil(n/k)
        f6, f5 = six / ratio, five / ratio
        refused = five > ratio
        ok = (deg == d and abs(lmax - d) < 1e-6 and abs(lm - tl) < 5e-4 and abs(ratio - tr) < 0.02
              and six == t6 and abs(f6 - tf6) < 1e-4 and abs(f5 - tf5) < 1e-4
              and (t5 is None) == refused and (t5 is None or t5 == five))
        allok &= ok
        print(f"{q:>3} {lm:>13.4f} {tl:>9.4f} {ratio:>11.2f} {tr:>8.2f} {six:>5} {f6:>7.4f} "
              f"{five:>5} {f5:>7.4f}  {'OK' if ok else 'MISMATCH'}"
              + ("  (five refused by the ratio bound)" if refused else ""))
    print("WINDOW TABLE", "REPRODUCED" if allok else "DISAGREES")
    sys.exit(0 if allok else 1)


def self_test():
    """three plants, each seen to fire (§S13.1 rule 9)."""
    ok = True
    F = Field(27, "t^3-t-1")
    circle, n, nbr = plane(F)
    h, hr, ne = edge_hash(n, nbr)
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
    # plant B: a DIFFERENT irreducible modulus is the same field with the vertices renumbered, so the digest must differ.
    # (t^3-t-2 is t^3-t+1 over F_3 and has no root, so it is irreducible; this plant was once mislabelled "reducible".)
    F2 = Field(27, "t^3-t-2")
    _, n2, nbr2 = plane(F2)
    h2, _hr2, ne2 = edge_hash(n2, nbr2)
    differs = (h2 != h and ne2 == ne)
    print(f"[plant B] the other irreducible modulus t^3-t-2: {ne2} edges (the same graph up to renumbering), sha "
          f"{h2[:16]}… — {'DIFFERS as it must' if differs else 'FAIL'}")
    ok &= differs
    # control: the descent-engine's own digest at q = 23, reproduced from its convention
    F23 = Field(23)
    _c23, n23, nbr23 = plane(F23)
    _py23, rust23, _ne23 = edge_hash(n23, nbr23)
    want = "4321f5f1880fff97295b9d763dec1d8c73a4d4cc8bd58921c5b659349aa25bb3"
    agree = rust23 == want
    print(f"[control 3] the descent-engine's edges_sha256 at q = 23 (little-endian u32 over the sorted "
          f"undirected edge list): {rust23[:16]}… against plane-colour's own {want[:16]}…: "
          f"{'AGREE — the two toolchains build the same graph' if agree else 'DISAGREE: FAIL'}")
    ok &= agree
    # plant C: a prime power with no modulus must be refused
    import subprocess
    r = subprocess.run([sys.executable, __file__, "graph", "--q", "27"], capture_output=True, text=True)
    fired = r.returncode != 0 and "REFUSED" in (r.stdout + r.stderr)
    print(f"[plant C] q = 27 with no --modulus: exit {r.returncode}, "
          f"{'REFUSED as it must' if fired else 'ACCEPTED: FAIL'}")
    ok &= fired
    # plant D: a reducible modulus (t^3-t = t(t-1)(t+1)) must be refused; plant E: a term above the degree must be refused
    for tag, mod in (("D", "t^3-t"), ("E", "t^4+t^3-t-1")):
        r = subprocess.run([sys.executable, __file__, "graph", "--q", "27", "--modulus", mod], capture_output=True, text=True)
        fired = r.returncode != 0 and "REFUSED" in (r.stdout + r.stderr)
        print(f"[plant {tag}] --modulus {mod}: exit {r.returncode}, {'REFUSED as it must' if fired else 'ACCEPTED: FAIL'}")
        ok &= fired
    print("SELF-TEST", "GREEN" if ok else "RED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
