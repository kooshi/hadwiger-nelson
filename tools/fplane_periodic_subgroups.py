#!/usr/bin/env python3
"""fplane_periodic_subgroups — every colouring of UD(F_q, 2) that is constant on the cosets of a subgroup.

A proper colouring of a Cayley graph Cay(A, S) that is constant on the cosets of a subgroup H with
H n S = {} is exactly a proper colouring of the quotient Cayley graph Cay(A/H, image of S); the
pullback is a graph homomorphism, so a colouring found here is a SOUND upper bound on chi of the
plane, and a failure to find one is a null over that family and nothing more.

Over a PRIME field F_p the additive group F_p^2 is a 2-dimensional F_p-vector space, so its only
proper non-zero subgroups are the p + 1 lines: that family is `tools/fplane.py periodic` and is
already exhausted (data/fplane/periodic-below-71.json). Over F_27 the additive group is (Z/3)^6 and
its subgroups are ALL F_3-subspaces -- 364 of dimension 1, 11011 of dimension 2, 33880 of dimension
3, 11011 of dimension 4 -- a family tens of thousands of times larger, which the prime-field tools
cannot express and nobody had searched. FS-53 section S3.

VERDICTS. A hit is a verified proper colouring of a quotient: sound, and chi(plane) <= k follows. A
miss at dimensions 3 and 4 is EXACT (backtracking, complete); at dimensions 1 and 2 it is a null at
the DSATUR restart budget and says so in the record. Nothing here ever refuses a colouring of the
plane: a plane colouring need not be periodic.

    python3 tools/fplane_periodic_subgroups.py --q 27 --k 6 --out data/fs53/periodic-q27.json
    python3 tools/fplane_periodic_subgroups.py --self-test
"""
import argparse, itertools, json, random, sys, time, hashlib

POW = None  # base-3 place values, set by build()


def field_q27():
    """F_27 = F_3[t]/(t^3 - t - 1): elements as coefficient triples; (elements, add, mul, one)."""
    els = [(a, b, c) for a in range(3) for b in range(3) for c in range(3)]
    def add(u, v): return tuple((x + y) % 3 for x, y in zip(u, v))
    def mul(u, v):
        r = [0] * 5
        for i in range(3):
            for j in range(3):
                r[i + j] = (r[i + j] + u[i] * v[j]) % 3
        r[2] = (r[2] + r[4]) % 3; r[1] = (r[1] + r[4]) % 3
        r[1] = (r[1] + r[3]) % 3; r[0] = (r[0] + r[3]) % 3
        return tuple(r[:3])
    return els, add, mul, (1, 0, 0)


def build(q=27):
    """the plane over F_q as vectors of F_3^6: returns (circle vectors, all vectors, place values)."""
    assert q == 27, "only F_27 is implemented (the next odd-degree planes, 343 and 1331, are spectrally >= 6)"
    els, add, mul, one = field_q27()
    t = (0, 1, 0)
    assert mul(mul(t, t), t) == (1, 1, 0), "t^3 must be t + 1"
    circ = [(s, u) for s in els for u in els if add(mul(s, s), mul(u, u)) == one]
    assert len(circ) == q + 1, f"the circle must have q + 1 = {q+1} points, got {len(circ)}"
    pow3 = [243, 81, 27, 9, 3, 1]
    cv = [tuple(c[0] + c[1]) for c in circ]
    allv = [tuple(v) for v in itertools.product(range(3), repeat=6)]
    return cv, allv, pow3


def enc(v, pow3): return sum(a * b for a, b in zip(v, pow3))


def edges_sha256(cv, allv, pow3):
    """the plane's edge set, hashed -- the wo18 habit: a graph a later record can be compared against."""
    E = set()
    for v in allv:
        i = enc(v, pow3)
        for s in cv:
            j = enc(tuple((a + b) % 3 for a, b in zip(v, s)), pow3)
            E.add((min(i, j), max(i, j)))
    return hashlib.sha256(repr(sorted(E)).encode()).hexdigest(), len(E)


def rrefs(n, j):
    """every j x n reduced-row-echelon matrix of rank j over F_3 -- i.e. every dimension-j subspace, once."""
    for piv in itertools.combinations(range(n), j):
        free = [(r, c) for r in range(j) for c in range(piv[r] + 1, n) if c not in piv]
        for vals in itertools.product(range(3), repeat=len(free)):
            M = [[0] * n for _ in range(j)]
            for r in range(j):
                M[r][piv[r]] = 1
            for (rc, v) in zip(free, vals):
                M[rc[0]][rc[1]] = v
            yield M


def span(M):
    j = len(M)
    out = []
    for coef in itertools.product(range(3), repeat=j):
        out.append(tuple(sum(c * M[r][i] for r, c in enumerate(coef)) % 3 for i in range(len(M[0]))))
    return out


def add_table(allv, pow3):
    """the 729 x 729 addition table of (Z/3)^6 on encoded vectors -- built once, so every quotient
    below is integer lookups rather than tuple arithmetic (measured: about 8x the whole sweep)."""
    n = len(allv)
    T = [None] * n
    for v in allv:
        i = enc(v, pow3)
        T[i] = [enc(tuple((a + b) % 3 for a, b in zip(v, w)), pow3) for w in allv]
    return T


def quotient(M, cve, T, n):
    """the quotient Cayley graph on encoded vectors, or None when a circle point lies in the
    subgroup (which would make the quotient carry a loop and no colouring pull back)."""
    He = [enc(h, [243, 81, 27, 9, 3, 1]) for h in span(M)]
    if set(He) & set(cve):
        return None
    rep = [min(T[v][h] for h in He) for v in range(n)]
    ids = sorted(set(rep))
    idx = {r: i for i, r in enumerate(ids)}
    ridx = [idx[r] for r in rep]
    S = sorted({ridx[c] for c in cve})
    if ridx[0] in S:
        return None
    m = len(ids)
    adj = [set() for _ in range(m)]
    for i in range(m):
        for s in S:
            j = ridx[T[ids[i]][ids[s]]]
            if j != i:
                adj[i].add(j); adj[j].add(i)
    return m, adj, len(S)


def exact_k_colourable(adj, n, k):
    """complete backtracking with the standard first-free-colour symmetry break."""
    col = [-1] * n
    order = sorted(range(n), key=lambda v: -len(adj[v]))
    def bt(i, used):
        if i == n:
            return True
        v = order[i]
        forb = {col[u] for u in adj[v] if col[u] >= 0}
        for c in range(min(used + 1, k)):
            if c in forb:
                continue
            col[v] = c
            if bt(i + 1, max(used, c + 1)):
                return True
            col[v] = -1
        return False
    return bt(0, 0)


def dsatur(adj, n, k, tries, rng):
    """sound on success, a null at the budget on failure."""
    base = sorted(range(n), key=lambda v: -len(adj[v]))
    for _ in range(tries):
        col = [-1] * n
        order = base[:]; rng.shuffle(order)
        order.sort(key=lambda v: -len(adj[v]))
        ok = True
        for v in order:
            forb = {col[u] for u in adj[v] if col[u] >= 0}
            c = next((c for c in range(k) if c not in forb), None)
            if c is None:
                ok = False; break
            col[v] = c
        if ok:
            return col
    return None


def verify(adj, n, col, k):
    """the independent sweep: proper, and inside the palette. Shares nothing with the search."""
    assert all(0 <= c < k for c in col), "a colour outside the palette"
    for v in range(n):
        for u in adj[v]:
            assert col[u] != col[v], f"monochromatic edge ({v}, {u})"
    return True


def sweep(q, k, dims, tries, log=print, out=None, head=None):
    cv, allv, pow3 = build(q)
    h, ne = edges_sha256(cv, allv, pow3)
    T = add_table(allv, pow3)
    cve = [enc(c, pow3) for c in cv]
    rows = []
    for j in dims:
        t0 = time.time(); rng = random.Random(7)
        n_sub = usable = hits = 0; best_k = None; best = None; witness = None
        exact = j >= 3
        for M in rrefs(6, j):
            n_sub += 1
            qg = quotient(M, cve, T, len(allv))
            if qg is None:
                continue
            usable += 1
            m, adj, ds = qg
            got = exact_k_colourable(adj, m, k) if exact else (dsatur(adj, m, k, tries, rng) is not None)
            if got:
                hits += 1
                if witness is None:
                    c = dsatur(adj, m, k, max(tries, 200), rng)
                    if c is None:
                        c = [0] * m
                        assert exact_k_colourable(adj, m, k)
                    verify(adj, m, c, k)
                    witness = dict(basis=M, quotient_size=m, connection_size=ds, colouring=c)
                    log(f"  HIT dim {j}: a proper {k}-colouring of a {m}-vertex quotient (|S| = {ds})")
            kk = k + 1
            while best_k is None or kk < best_k:
                if dsatur(adj, m, kk, max(8, tries // 4), rng) is not None:
                    if best_k is None or kk < best_k:
                        best_k = kk
                        best = dict(basis=M, quotient_size=m, connection_size=ds)
                        log(f"  dim {j}: a proper {kk}-colouring found (m = {m}, |S| = {ds})")
                    break
                kk += 1
                if kk > 12:
                    break
        rows.append(dict(dim=j, index=3 ** (6 - j), quotient_size=3 ** (6 - j), subspaces=n_sub, usable=usable,
                         k=k, hits=hits, exact=exact, restarts=None if exact else tries,
                         best_k_found=best_k if hits == 0 else k, witness=witness, best=best,
                         seconds=round(time.time() - t0, 1)))
        word = "EXACT" if exact else f"a null at {tries} DSATUR restarts"
        log(f"dim {j} (index {3**(6-j)}): {n_sub} subspaces, {usable} usable, {hits} are {k}-colourable "
            f"[{word}]; best k found {rows[-1]['best_k_found']}  [{rows[-1]['seconds']}s]")
        # The record is rewritten after EVERY dimension, not once at the end: a sweep of the whole
        # family is tens of minutes, and a run whose state lives only in a process is a bug, not a
        # style choice (CLAUDE.md's checkpointing rule). A killed run leaves the dimensions it
        # finished; the relaunch redoes only the one in flight, and `--dims` names which.
        if out:
            json.dump(record(q, k, ne, h, rows, partial=True), open(out, "w"), indent=1)
    return record(q, k, ne, h, rows)


def record(q, k, ne, h, rows, partial=False):
    return dict(kind="fplane-periodic-subgroups", q=q, k=k, n=q * q, degree=q + 1, edges=ne,
                edges_sha256=h, rows=rows, partial=partial, dims_done=[r["dim"] for r in rows],
                claim_scope=("a hit is a VERIFIED proper colouring of a quotient, so chi(UD(F_q,2)) <= k follows by pullback; "
                             "a miss at dim >= 3 is exact over that family; a miss at dim <= 2 is a null at the DSATUR budget; "
                             "no result here ever refuses a colouring of the plane, which need not be periodic"))


def self_test():
    """three controls, each watched to fire."""
    cv, allv, pow3 = build(27)
    T = add_table(allv, pow3)
    cve = [enc(c, pow3) for c in cv]
    ok = True
    # 1 positive: the family must contain a colouring at k = 9 at dimension 4 (every such quotient is K_9)
    rng = random.Random(1); found = False
    for M in rrefs(6, 4):
        qg = quotient(M, cve, T, len(allv))
        if qg is None:
            continue
        m, adj, ds = qg
        c = dsatur(adj, m, 9, 20, rng)
        if c is not None:
            verify(adj, m, c, 9); found = True; break
    print(f"[control 1] a 9-colouring of a dimension-4 quotient is found and verified: {found}")
    ok &= found
    # 2 a subspace containing a circle point must be REFUSED as unusable, never coloured
    s = cv[0]
    M = [[0] * 6 for _ in range(1)]
    # the line through s, in rref: scale s so its leading entry is 1
    lead = next(i for i, a in enumerate(s) if a)
    inv = 1 if s[lead] == 1 else 2
    M[0] = [(a * inv) % 3 for a in s]
    refused = quotient(M, cve, T, len(allv)) is None
    print(f"[control 2] the line through a circle point is refused as unusable: {refused}")
    ok &= refused
    # 3 the graph's hash and shape, asserted against the field's own definition
    h, ne = edges_sha256(cv, allv, pow3)
    shape = (len(cv) == 28 and len(allv) == 729 and ne == 729 * 28 // 2)
    print(f"[control 3] 729 vertices, 28-regular, {ne} edges, edges_sha256 {h[:16]}...: {shape}")
    ok &= shape
    print("SELF-TEST", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--q", type=int, default=27)
    ap.add_argument("--k", type=int, default=6)
    ap.add_argument("--dims", default="4,3,2,1")
    ap.add_argument("--restarts", type=int, default=40, help="DSATUR restarts at the dimensions decided heuristically")
    ap.add_argument("--out")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    rec = sweep(a.q, a.k, [int(d) for d in a.dims.split(",")], a.restarts, out=a.out)
    if a.out:
        json.dump(rec, open(a.out, "w"), indent=1)
        print(f"  wrote {a.out}")
    else:
        print(json.dumps(rec, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
