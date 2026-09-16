#!/usr/bin/env python3
"""Export the finite Euclidean plane UD(F_q, 2) as a METIS graph file, for external independent-set finders
(KaMIS's redumis / online_mis), and turn such a finder's output back into a checkable record.  Standard library only.

  fplane_export_metis.py export --q 27 --modulus t^3-t-1 --out G.graph [--expect-sha SHA]
  fplane_export_metis.py record --q 27 --modulus t^3-t-1 --kamis-output SET.txt --out REC.json \
                                --tool "..." --seconds S --seed N [--expect-sha SHA]
  fplane_export_metis.py self-test

The graph: vertices are the points (x, y) of F_q^2; (x, y) ~ (x', y') when (x'-x)^2 + (y'-y)^2 = 1 in F_q.

Vertex numbering (the repository's convention, as documented in tools/fplane_review_verify.py; reimplemented here
and never imported, so that script stays an independent check of what this one writes): over F_p the index is
x*p + y; over F_{p^e} = F_p[t]/(m(t)) each coordinate is its e coefficient digits against 1, t, ..., t^{e-1}, read
base p with the CONSTANT coefficient MOST significant, and the point's index is x's digits then y's (2e digits).

Edge hash: sha256 of repr(sorted({(min i, max j)})) over the undirected edge list, 0-indexed — the Python tools'
`edges_sha256`.  `export` prints it and, given --expect-sha, refuses to write anything on a mismatch.

METIS output: a header line `n m` (m = number of undirected edges), then line i lists vertex i's neighbours,
1-INDEXED and sorted ascending (KaMIS rejects unsorted adjacency).  So METIS vertex k is repository vertex k - 1.

KaMIS output (redumis/online_mis --output): one line per vertex, `1` if it is in the set, else `0`, in METIS order;
`record` converts it to 0-indexed repository numbering and refuses a set that is not independent in the graph it
rebuilds — a refusal here is a bug report about the pipeline, never a finding about the plane.  The record's claim
is a LOWER bound on alpha from one heuristic run; the independent verification is tools/fplane_review_verify.py."""
import argparse, hashlib, json, os, sys, tempfile


def prime_power(q):
    """q -> (p, e) with q = p^e and p prime; refuses anything else."""
    for p in range(2, q + 1):
        if q % p == 0:
            e, n = 0, q
            while n % p == 0:
                n //= p
                e += 1
            if n != 1:
                sys.exit(f"REFUSED: q = {q} is not a prime power")
            return p, e
    sys.exit(f"REFUSED: q = {q} is not a prime power")


def modulus_coefficients(s, p, e):
    """'t^3-t-1' -> [m0, m1, ..., m_e] (ascending, reduced mod p), refusing a non-monic or wrong-degree modulus.
    Parsed term by term rather than eval'd, so malformed input is a refusal."""
    coef = [0] * (e + 1)
    text = s.replace(" ", "")
    if not text:
        sys.exit("REFUSED: empty modulus")
    if text[0] not in "+-":
        text = "+" + text
    i = 0
    while i < len(text):
        sign = -1 if text[i] == "-" else 1
        j = i + 1
        while j < len(text) and text[j] not in "+-":
            j += 1
        term = text[i + 1:j]
        i = j
        if "t" in term:
            head, _, tail = term.partition("t")
            c = int(head.rstrip("*")) if head.rstrip("*") else 1
            d = int(tail[1:]) if tail.startswith("^") else (1 if tail == "" else None)
            if d is None:
                sys.exit(f"REFUSED: cannot parse the term {term!r} of the modulus {s!r}")
        else:
            c, d = int(term), 0
        if d > e:
            sys.exit(f"REFUSED: the modulus {s!r} has degree above {e}")
        coef[d] = (coef[d] + sign * c) % p
    if coef[e] != 1:
        sys.exit(f"REFUSED: the modulus {s!r} must be monic of degree {e} over F_{p}")
    return coef


class FiniteField:
    """F_q with elements numbered 0..q-1 in the repository's digit order, and full addition and multiplication
    tables.  Built by reducing polynomial products modulo m(t); the field axiom that matters here (no zero
    divisors, i.e. m irreducible) is CHECKED, because a reducible modulus builds a ring whose 'plane' is a
    different graph with the same vertex count."""

    def __init__(self, q, modulus):
        p, e = prime_power(q)
        if e > 1 and not modulus:
            sys.exit(f"REFUSED: q = {q} = {p}^{e} needs --modulus (Z/{q} is not F_{q}; the graphs differ)")
        if e == 1 and modulus:
            sys.exit(f"REFUSED: q = {q} is prime; --modulus does not apply")
        self.p, self.e, self.q = p, e, q
        m = modulus_coefficients(modulus, p, e) if e > 1 else [0, 1]
        # element number <-> coefficient vector (c0, ..., c_{e-1}); c0 is the most significant base-p digit
        self.vec = []
        for n in range(q):
            digits = []
            for _ in range(e):
                digits.append(n % p)
                n //= p
            self.vec.append(tuple(reversed(digits)))       # reversed: most significant digit first = c0
        self.num = {v: n for n, v in enumerate(self.vec)}
        self.add = [[self.num[tuple((a + b) % p for a, b in zip(self.vec[u], self.vec[v]))] for v in range(q)]
                    for u in range(q)]
        self.mul = [[self.num[self._polymul(self.vec[u], self.vec[v], m)] for v in range(q)] for u in range(q)]
        self.zero, self.one = self.num[tuple([0] * e)], self.num[tuple([1] + [0] * (e - 1))]
        for u in range(q):
            if u != self.zero and any(self.mul[u][v] == self.zero for v in range(q) if v != self.zero):
                sys.exit(f"REFUSED: the modulus {modulus!r} is reducible over F_{p}: the quotient ring has zero "
                         f"divisors and is not F_{q}")

    def _polymul(self, a, b, m):
        p, e = self.p, self.e
        prod = [0] * (2 * e - 1)
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                prod[i + j] = (prod[i + j] + x * y) % p
        for d in range(2 * e - 2, e - 1, -1):              # t^d = t^(d-e) * t^e and t^e = -(m0 + ... + m_{e-1} t^{e-1})
            c = prod[d]
            if c:
                prod[d] = 0
                for i in range(e):
                    prod[d - e + i] = (prod[d - e + i] - c * m[i]) % p
        return tuple(prod[:e])


def build_plane(F):
    """(n, circle, neighbour lists) for UD(F_q, 2); vertex (x, y) has index x*q + y in element numbers."""
    q = F.q
    sq = [F.mul[a][a] for a in range(q)]
    circle = [(s, t) for s in range(q) for t in range(q) if F.add[sq[s]][sq[t]] == F.one]
    n = q * q
    nbr = [sorted(F.add[x][s] * q + F.add[y][t] for (s, t) in circle) for x in range(q) for y in range(q)]
    return n, circle, nbr


def undirected_edges(n, nbr):
    E = sorted({(min(i, j), max(i, j)) for i in range(n) for j in nbr[i]})
    return E, hashlib.sha256(repr(E).encode()).hexdigest()


def check_shape(n, circle, nbr, E):
    """The facts a METIS writer relies on, asserted rather than assumed: no loops, no repeated neighbour,
    symmetric adjacency, regular of degree |circle|, and the handshake count."""
    d = len(circle)
    for i in range(n):
        if i in nbr[i]:
            sys.exit(f"REFUSED: vertex {i} is its own neighbour (a loop)")
        if len(set(nbr[i])) != d or len(nbr[i]) != d:
            sys.exit(f"REFUSED: vertex {i} has {len(set(nbr[i]))} distinct of {len(nbr[i])} neighbours, expected {d}")
    sets = [set(x) for x in nbr]
    if any(i not in sets[j] for i in range(n) for j in nbr[i]):
        sys.exit("REFUSED: adjacency is not symmetric")
    if 2 * len(E) != n * d:
        sys.exit(f"REFUSED: {len(E)} edges but n*d/2 = {n * d // 2}")


def load(args):
    F = FiniteField(args.q, args.modulus)
    n, circle, nbr = build_plane(F)
    E, sha = undirected_edges(n, nbr)
    check_shape(n, circle, nbr, E)
    print(f"UD(F_{args.q},2){' with F_' + str(args.q) + ' = F_' + str(F.p) + '[t]/(' + args.modulus + ')' if args.modulus else ''}: "
          f"{n} vertices, degree {len(circle)}, {len(E)} edges\n  edges_sha256 {sha}")
    if args.expect_sha and args.expect_sha != sha:
        sys.exit(f"MISMATCH: expected edges_sha256 {args.expect_sha}\n                   got {sha}\n"
                 f"nothing written — a wrong graph makes every later number meaningless")
    if args.expect_sha:
        print("  edges_sha256 MATCHES the expected value")
    return F, n, circle, nbr, E, sha


def write_atomic(path, text):
    d = os.path.dirname(os.path.abspath(path))
    os.makedirs(d, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=d, prefix=".tmp-")
    with os.fdopen(fd, "w") as f:
        f.write(text)
    umask = os.umask(0)
    os.umask(umask)
    os.chmod(tmp, 0o666 & ~umask)                          # mkstemp creates 0600; give the file ordinary permissions
    os.replace(tmp, path)


def cmd_export(args):
    _F, n, _circle, nbr, E, _sha = load(args)
    lines = [f"{n} {len(E)}"] + [" ".join(str(j + 1) for j in nbr[i]) for i in range(n)]
    write_atomic(args.out, "\n".join(lines) + "\n")
    print(f"  wrote METIS graph to {args.out} (1-indexed neighbours, sorted)")


def cmd_record(args):
    _F, n, _circle, nbr, _E, sha = load(args)
    with open(args.kamis_output) as f:
        rows = [line.strip() for line in f if line.strip()]
    if len(rows) != n or any(r not in ("0", "1") for r in rows):
        sys.exit(f"REFUSED: {args.kamis_output} has {len(rows)} rows (expected {n}, each 0 or 1)")
    S = [i for i, r in enumerate(rows) if r == "1"]
    inside = set(S)
    bad = [(i, j) for i in S for j in nbr[i] if j in inside and i < j]
    if bad:
        sys.exit(f"REFUSED: the finder's set is NOT independent in the rebuilt graph, e.g. {bad[:3]} — "
                 f"a pipeline bug (numbering, indexing, or the wrong graph), not a finding")
    rec = {
        "q": args.q,
        "modulus": args.modulus,
        "edges_sha256": sha,
        "size": len(S),
        "set": S,
        "tool": args.tool,
        "seconds": args.seconds,
        "seed": args.seed,
        "claim_scope": "one heuristic run at the stated budget; a lower bound on alpha only, never evidence about the "
                       "upper side",
    }
    for extra in args.extra or []:
        k, _, v = extra.partition("=")
        rec[k] = json.loads(v) if v and v[0] in "[{\"0123456789-" else v
    write_atomic(args.out, json.dumps(rec, indent=1) + "\n")
    print(f"  independent set of size {len(S)} (checked on every edge of the rebuilt graph); wrote {args.out}")


def self_test():
    """each refusal this tool promises, provoked, plus one positive control per shape."""
    import subprocess
    me = [sys.executable, os.path.abspath(__file__)]
    ok = True

    def run(argv):
        r = subprocess.run(me + argv, capture_output=True, text=True)
        return r.returncode, r.stdout + r.stderr

    tmp = tempfile.mkdtemp(prefix="fplane-export-selftest-")
    want27 = "b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d"
    g = os.path.join(tmp, "q27.graph")
    code, out = run(["export", "--q", "27", "--modulus", "t^3-t-1", "--out", g, "--expect-sha", want27])
    good = code == 0 and "729 vertices, degree 28, 10206 edges" in out and os.path.exists(g)
    print(f"[control] q = 27, t^3-t-1, expected hash: exit {code}, file written {os.path.exists(g)}: "
          f"{'OK' if good else 'FAIL'}")
    ok &= good
    if good:
        with open(g) as f:
            head = f.readline().split()
            first = [int(x) for x in f.readline().split()]
        good = head == ["729", "10206"] and len(first) == 28 and first == sorted(first) and min(first) >= 1
        print(f"[control] METIS header {head}, vertex 1 has {len(first)} sorted 1-indexed neighbours: "
              f"{'OK' if good else 'FAIL'}")
        ok &= good
    g11 = os.path.join(tmp, "q11.graph")
    code, out = run(["export", "--q", "11", "--out", g11])
    good = code == 0 and "121 vertices, degree 12, 726 edges" in out
    print(f"[control] q = 11 (prime field): exit {code}: {'OK' if good else 'FAIL'}")
    ok &= good
    g_bad = os.path.join(tmp, "wrong-sha.graph")
    code, out = run(["export", "--q", "27", "--modulus", "t^3-t-1", "--out", g_bad, "--expect-sha", "0" * 64])
    fired = code != 0 and "MISMATCH" in out and not os.path.exists(g_bad)
    print(f"[plant] a wrong expected hash: exit {code}, file written {os.path.exists(g_bad)}: "
          f"{'REFUSED, nothing written' if fired else 'DID NOT FIRE'}")
    ok &= fired
    # the pair: a reducible modulus must be refused, and an IRREDUCIBLE non-default one accepted — so the refusal
    # is seen to come from reducibility and not from "any modulus other than t^3-t-1".  (t^3-t-2 = t^3-t+1 mod 3 is
    # Artin-Schreier with a != 0, hence irreducible: it builds F_27 again, renumbered, so the hash differs.)
    code, out = run(["export", "--q", "27", "--modulus", "t^3-t", "--out", os.path.join(tmp, "red.graph")])
    fired = code != 0 and "reducible" in out
    print(f"[plant] the reducible modulus t^3-t = t(t-1)(t+1): exit {code}: "
          f"{'REFUSED' if fired else 'DID NOT FIRE'}")
    ok &= fired
    code, out = run(["export", "--q", "27", "--modulus", "t^3-t-2", "--out", os.path.join(tmp, "alt.graph")])
    good = code == 0 and "729 vertices, degree 28, 10206 edges" in out and want27 not in out
    print(f"[control] the irreducible modulus t^3-t-2 (= t^3-t+1): exit {code}, same shape, different numbering "
          f"hence different hash: {'OK' if good else 'FAIL'}")
    ok &= good
    code, out = run(["export", "--q", "27", "--out", os.path.join(tmp, "z27.graph")])
    fired = code != 0 and "needs --modulus" in out
    print(f"[plant] q = 27 with no modulus: exit {code}: {'REFUSED' if fired else 'DID NOT FIRE'}")
    ok &= fired
    # record: an independent set must pass, and the same set plus one neighbour must be refused
    F = FiniteField(27, "t^3-t-1")
    n, _c, nbr = build_plane(F)
    greedy, blocked = [], set()
    for v in range(n):
        if v not in blocked:
            greedy.append(v)
            blocked.update(nbr[v])
    for name, S in (("greedy", greedy), ("greedy+neighbour", greedy + [nbr[greedy[0]][0]])):
        path = os.path.join(tmp, name + ".txt")
        member = set(S)
        write_atomic(path, "\n".join("1" if i in member else "0" for i in range(n)) + "\n")
        code, out = run(["record", "--q", "27", "--modulus", "t^3-t-1", "--kamis-output", path,
                         "--out", os.path.join(tmp, name + ".json"), "--tool", "self-test", "--seconds", "0",
                         "--seed", "0"])
        if name == "greedy":
            good = code == 0 and f"size {len(greedy)}" in out
            print(f"[control] record on a greedy independent set of size {len(greedy)}: exit {code}: "
                  f"{'OK' if good else 'FAIL'}")
        else:
            good = code != 0 and "NOT independent" in out
            print(f"[plant] record on that set plus one neighbour of its first vertex: exit {code}: "
                  f"{'REFUSED' if good else 'DID NOT FIRE'}")
        ok &= good
    print("SELF-TEST", "GREEN" if ok else "RED")
    sys.exit(0 if ok else 1)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("mode", choices=["export", "record", "self-test"])
    ap.add_argument("--q", type=int)
    ap.add_argument("--modulus")
    ap.add_argument("--out")
    ap.add_argument("--expect-sha")
    ap.add_argument("--kamis-output", help="record: the finder's 0/1-per-line output file")
    ap.add_argument("--tool", help="record: the finder's version and exact command line")
    ap.add_argument("--seconds", type=float, help="record: wall-clock seconds of the run")
    ap.add_argument("--seed", type=int, help="record: the finder's seed")
    ap.add_argument("--extra", action="append", help="record: extra KEY=VALUE field (VALUE parsed as JSON if it looks like it)")
    a = ap.parse_args()
    if a.mode == "self-test":
        return self_test()
    if a.q is None or not a.out:
        ap.error("--q and --out are required")
    if a.mode == "export":
        return cmd_export(a)
    if not (a.kamis_output and a.tool is not None and a.seconds is not None and a.seed is not None):
        ap.error("record needs --kamis-output, --tool, --seconds and --seed")
    return cmd_record(a)


if __name__ == "__main__":
    main()
