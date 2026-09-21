#!/usr/bin/env python3
"""FS-66, the product owner's decorrelated verifier for claims about UD(Z/n, 2).

The graph: vertices (x, y) in (Z/n)^2, adjacent exactly when (x-x')^2 + (y-y')^2 = 1 (mod n).
This script shares no code with any finder or with tools/fs38_tower.py.  It never builds the circle
(the connection set): every verdict comes from a sweep over ALL unordered vertex pairs, straight from
the definition above, so a finder that searched a wrong connection set cannot pass here.

  colouring FILE   JSON {"n": 121, "k": 4, "colours": ...}   colours: a flat list of length n^2 with
                   vertex (x, y) at index x*n + y, OR a list of [x, y, colour] triples covering every vertex
  indep FILE       JSON {"n": 121, "members": ...}           members: [x, y] pairs or flat ids x*n + y
  selftest         positive controls and planted faults; every plant must be seen to fire

Exit status 0 only when the claim is verified (or, for selftest, when every control behaved).
"""
import json
import sys

import numpy as np

BLOCK = 256


def edge_sweep(n, label=None, member=None):
    """Sweep every unordered pair.  Returns (edge_count, first_bad_edge or None).
    label: int array of length n*n -> an edge is bad when both ends carry the same label.
    member: bool array of length n*n -> an edge is bad when both ends are members."""
    N = n * n
    xs = np.repeat(np.arange(n, dtype=np.int64), n)
    ys = np.tile(np.arange(n, dtype=np.int64), n)
    edges = 0
    bad = None
    for a in range(0, N, BLOCK):
        b = min(a + BLOCK, N)
        dx = (xs[a:b, None] - xs[None, :]) % n
        dy = (ys[a:b, None] - ys[None, :]) % n
        adj = (dx * dx + dy * dy) % n == 1
        # count each unordered pair once: keep columns strictly greater than the row's own index
        rows = np.arange(a, b)[:, None]
        cols = np.arange(N)[None, :]
        adj &= cols > rows
        edges += int(adj.sum())
        if bad is None:
            if label is not None:
                clash = adj & (label[a:b, None] == label[None, :])
            else:
                clash = adj & member[a:b, None] & member[None, :]
            if clash.any():
                i, j = np.argwhere(clash)[0]
                u, v = a + int(i), int(j)
                bad = ((u // n, u % n), (v // n, v % n))
    return edges, bad


def expected_edges(n):
    """Undirected edge count from a direct count of the solutions of a^2 + b^2 = 1 (mod n) —
    computed here by brute force over (a, b), independently of the sweep."""
    a = np.arange(n, dtype=np.int64)
    circle = int((((a[:, None] ** 2 + a[None, :] ** 2) % n) == 1).sum())
    return circle, n * n * circle // 2


def load_colours(doc):
    n, k = int(doc["n"]), int(doc["k"])
    raw = doc["colours"]
    N = n * n
    col = np.full(N, -1, dtype=np.int64)
    if raw and isinstance(raw[0], (list, tuple)):
        for x, y, c in raw:
            if not (0 <= x < n and 0 <= y < n):
                raise SystemExit(f"REFUSED: vertex ({x},{y}) outside (Z/{n})^2")
            if col[x * n + y] != -1:
                raise SystemExit(f"REFUSED: vertex ({x},{y}) listed twice")
            col[x * n + y] = c
    else:
        if len(raw) != N:
            raise SystemExit(f"REFUSED: {len(raw)} colours for {N} vertices (n = {n})")
        col[:] = raw
    if (col < 0).any() or (col >= k).any():
        v = int(np.argwhere((col < 0) | (col >= k))[0][0])
        raise SystemExit(f"REFUSED: vertex ({v // n},{v % n}) has colour {int(col[v])}, outside 0..{k - 1} (or missing)")
    return n, k, col


def load_members(doc):
    n = int(doc["n"])
    N = n * n
    mem = np.zeros(N, dtype=bool)
    for m in doc["members"]:
        v = m[0] * n + m[1] if isinstance(m, (list, tuple)) else int(m)
        if isinstance(m, (list, tuple)) and not (0 <= m[0] < n and 0 <= m[1] < n):
            raise SystemExit(f"REFUSED: member {m} outside (Z/{n})^2")
        if not 0 <= v < N:
            raise SystemExit(f"REFUSED: member id {v} outside 0..{N - 1}")
        if mem[v]:
            raise SystemExit(f"REFUSED: member {m} listed twice")
        mem[v] = True
    return n, mem


def verify_colouring(doc, quiet=False):
    n, k, col = load_colours(doc)
    circle, want = expected_edges(n)
    edges, bad = edge_sweep(n, label=col)
    sizes = np.bincount(col, minlength=k).tolist()
    ok = bad is None and edges == want
    if not quiet:
        print(f"UD(Z/{n},2): {n * n} vertices, circle {circle}, edges swept {edges} (expected {want})")
        print(f"colours k = {k}, class sizes {sizes}")
        if edges != want:
            print("FAIL: the pair sweep and the circle count disagree on the edge count")
        if bad is not None:
            print(f"FAIL: monochromatic edge {bad[0]} -- {bad[1]}")
        if ok:
            print(f"VERIFIED: a proper {k}-colouring of UD(Z/{n},2), every one of {edges} edges checked from the definition")
    return ok


def verify_indep(doc, quiet=False):
    n, mem = load_members(doc)
    circle, want = expected_edges(n)
    edges, bad = edge_sweep(n, member=mem)
    size = int(mem.sum())
    ok = bad is None and edges == want
    if not quiet:
        print(f"UD(Z/{n},2): {n * n} vertices, circle {circle}, edges swept {edges} (expected {want})")
        print(f"set size {size}, ratio {size / (n * n):.6f}")
        if n == 121:
            print(f"  level one pulled back: 3388 (28/121 = {28 / 121:.6f}); four colours need >= 3661 (1/4)")
        if bad is not None:
            print(f"FAIL: edge inside the set {bad[0]} -- {bad[1]}")
        if ok:
            print(f"VERIFIED: an independent set of size {size} in UD(Z/{n},2)")
    return ok


def level_one_colouring(p, k):
    """A proper k-colouring of UD(F_p,2) from a SAT solver — used ONLY to manufacture selftest inputs."""
    from pysat.solvers import Cadical153
    pts = [(x, y) for x in range(p) for y in range(p)]
    var = lambda v, c: v * k + c + 1
    s = Cadical153()
    for v in range(p * p):
        s.add_clause([var(v, c) for c in range(k)])
    for u, (x, y) in enumerate(pts):
        for v in range(u + 1, p * p):
            X, Y = pts[v]
            if ((x - X) ** 2 + (y - Y) ** 2) % p == 1:
                for c in range(k):
                    s.add_clause([-var(u, c), -var(v, c)])
    if not s.solve():
        return None
    model = set(l for l in s.get_model() if l > 0)
    return [next(c for c in range(k) if var(v, c) in model) for v in range(p * p)]


def pull_back(p, base):
    n = p * p
    return [base[(x % p) * p + (y % p)] for x in range(n) for y in range(n)]


def first_neighbour(n, v):
    x, y = v // n, v % n
    for X in range(n):
        for Y in range(n):
            if ((x - X) ** 2 + (y - Y) ** 2) % n == 1:
                return X * n + Y
    raise AssertionError("no neighbour")


def expect_refusal(fn, doc, what):
    try:
        fn(doc, quiet=True)
    except SystemExit as e:
        print(f"  plant fired (refused): {what}: {e}")
        return True
    print(f"  PLANT DID NOT FIRE: {what}")
    return False


def selftest():
    good = True
    for p, k in ((7, 4), (11, 5)):
        n = p * p
        base = level_one_colouring(p, k)
        assert base is not None, (p, k)
        col = pull_back(p, base)
        doc = {"n": n, "k": k, "colours": col}
        ok = verify_colouring(doc, quiet=True)
        print(f"positive control: level-one {k}-colouring of UD(F_{p},2) pulled back to Z/{n}: {'VERIFIED' if ok else 'FAILED'}")
        good &= ok
        # plant 1: one vertex recoloured to a neighbour's colour -> must fail (not refuse)
        v = 5 * n + 3
        w = first_neighbour(n, v)
        bad = list(col)
        bad[v] = bad[w]
        fired = not verify_colouring({"n": n, "k": k, "colours": bad}, quiet=True)
        print(f"  plant {'fired' if fired else 'DID NOT FIRE'}: vertex {(v // n, v % n)} given its neighbour {(w // n, w % n)}'s colour")
        good &= fired
        # the restore: the unmodified colouring must verify again
        good &= verify_colouring(doc, quiet=True)
        # plant 2: a colour out of range; plant 3: wrong length; plant 4: one colour fewer claimed
        oor = list(col); oor[0] = k
        good &= expect_refusal(verify_colouring, {"n": n, "k": k, "colours": oor}, "colour out of range")
        good &= expect_refusal(verify_colouring, {"n": n, "k": k, "colours": col[:-1]}, "one vertex missing")
        good &= expect_refusal(verify_colouring, {"n": n, "k": k - 1, "colours": col}, f"a {k}-colouring filed as k = {k - 1}")
        # independent set: the largest colour class, pulled back
        cls = max(range(k), key=lambda c: col.count(c))
        members = [v for v in range(n * n) if col[v] == cls]
        ok = verify_indep({"n": n, "members": members}, quiet=True)
        print(f"positive control: colour class of size {len(members)} as an independent set: {'VERIFIED' if ok else 'FAILED'}")
        good &= ok
        outsider = next(v for v in range(n * n) if col[v] != cls and col[first_neighbour(n, v)] == cls)
        fired = not verify_indep({"n": n, "members": members + [outsider]}, quiet=True)
        print(f"  plant {'fired' if fired else 'DID NOT FIRE'}: a neighbour of the set added to it")
        good &= fired
        good &= expect_refusal(verify_indep, {"n": n, "members": members + [members[0]]}, "a member listed twice")
    # the wrong-ring plant: a colouring proper for F_121-as-a-field numbering is not asked; instead check the
    # modulus is load-bearing: the Z/49 colouring filed against n = 121 must be refused on length
    base = level_one_colouring(7, 4)
    good &= expect_refusal(verify_colouring, {"n": 121, "k": 4, "colours": pull_back(7, base)}, "a Z/49 colouring filed as n = 121")
    # edge-count cross-check against the closed form p(p+1) * p^4 / 2
    for p in (7, 11):
        n = p * p
        circle, want = expected_edges(n)
        closed = p * (p + 1)
        print(f"circle of Z/{n}: {circle} (closed form p(p+1) = {closed}); undirected edges {want}")
        good &= circle == closed
    print("SELFTEST", "PASS" if good else "FAIL")
    return good


def main():
    if len(sys.argv) == 2 and sys.argv[1] == "selftest":
        sys.exit(0 if selftest() else 1)
    if len(sys.argv) == 3 and sys.argv[1] in ("colouring", "indep"):
        doc = json.load(open(sys.argv[2]))
        fn = verify_colouring if sys.argv[1] == "colouring" else verify_indep
        sys.exit(0 if fn(doc) else 1)
    print(__doc__)
    sys.exit(2)


if __name__ == "__main__":
    main()
