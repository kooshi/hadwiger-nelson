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
import argparse, itertools, json, os, random, sys, tempfile, time, hashlib

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


def plane_edges(cv, allv, pow3):
    """the plane's edge set as sorted (min, max) index pairs -- the object a pulled-back colouring is
    verified against, and the object the hash below names."""
    E = set()
    for v in allv:
        i = enc(v, pow3)
        for s in cv:
            j = enc(tuple((a + b) % 3 for a, b in zip(v, s)), pow3)
            E.add((min(i, j), max(i, j)))
    return sorted(E)


def edges_sha256(cv, allv, pow3):
    """the plane's edge set, hashed -- the wo18 habit: a graph a later record can be compared against."""
    E = plane_edges(cv, allv, pow3)
    return hashlib.sha256(repr(E).encode()).hexdigest(), len(E)


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
    return m, adj, len(S), ridx


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


def pullback(ridx, qcol):
    """the quotient colouring lifted to the plane: vertex v takes the colour of its coset.  The lift is a
    graph homomorphism, so this is the colouring the pullback theorem (colorable_of_addCayleyMap, kernel)
    licenses -- and it is verified below on the plane's own 10,206 edges rather than argued."""
    return [qcol[ridx[v]] for v in range(len(ridx))]


def verify_plane(E, col, k, n):
    """the plane sweep: a pulled-back colouring checked edge by edge on UD(F_27,2) itself.  Shares nothing
    with the quotient search -- it never looks at a subgroup -- so it is an independent check of the lift,
    and it returns the number of edges it verified so a caller can assert the population, never just 'ok'."""
    assert len(col) == n, f"a colouring of {len(col)} points for a plane of {n}"
    assert all(0 <= c < k for c in col), "a colour outside the palette"
    for (u, v) in E:
        if col[u] == col[v]:
            raise AssertionError(f"monochromatic plane edge ({u}, {v}) at colour {col[u]}")
    return len(E)


def verify(adj, n, col, k):
    """the independent sweep: proper, and inside the palette. Shares nothing with the search."""
    assert all(0 <= c < k for c in col), "a colour outside the palette"
    for v in range(n):
        for u in adj[v]:
            assert col[u] != col[v], f"monochromatic edge ({v}, {u})"
    return True


def emit(out, rec):
    """THE record writer -- the only one in this file.  It is the checkpointing one: `sweep` calls it after
    every dimension with partial=True and once at the end with partial=False, and nothing else writes a
    record, so there is exactly one code path a reader has to trust and no way for a final write to disagree
    with the checkpoint it replaces.  The write is atomic (a temporary file in the same directory, then
    os.replace), so a kill during the write leaves the previous checkpoint intact rather than a truncated
    file -- a checkpoint that can be caught half-written is not a checkpoint."""
    d = os.path.dirname(os.path.abspath(out)) or "."
    fd, tmp = tempfile.mkstemp(dir=d, prefix=".periodic-", suffix=".json.tmp")
    try:
        with os.fdopen(fd, "w") as f:
            json.dump(rec, f, indent=1)
        os.chmod(tmp, 0o644)        # mkstemp is 0600; a committed record is read by strangers
        os.replace(tmp, out)
    except BaseException:
        if os.path.exists(tmp):
            os.unlink(tmp)
        raise
    return out


def sweep(q, k, dims, tries, log=print, out=None, head=None, limit=None):
    """`limit` stops each dimension after that many USABLE subspaces.  It exists for the self-test, and it
    forces `exact` off and stamps the row and the record `truncated`: an exhaustive word over a truncated
    enumeration is the defect G21 is about, so a truncated run may never say EXACT."""
    cv, allv, pow3 = build(q)
    E = plane_edges(cv, allv, pow3)
    h, ne = hashlib.sha256(repr(E).encode()).hexdigest(), len(E)
    T = add_table(allv, pow3)
    cve = [enc(c, pow3) for c in cv]
    rows = []
    for j in dims:
        t0 = time.time(); rng = random.Random(7)
        n_sub = usable = hits = 0; best_k = None; best = None; witness = None
        exact = j >= 3 and limit is None
        for M in rrefs(6, j):
            n_sub += 1
            qg = quotient(M, cve, T, len(allv))
            if qg is None:
                continue
            usable += 1
            m, adj, ds, ridx = qg
            got = exact_k_colourable(adj, m, k) if exact else (dsatur(adj, m, k, tries, rng) is not None)
            if got:
                hits += 1
                if witness is None:
                    c = dsatur(adj, m, k, max(tries, 200), rng)
                    if c is None:
                        c = [0] * m
                        assert exact_k_colourable(adj, m, k)
                    verify(adj, m, c, k)
                    witness = colour_witness(M, m, ds, k, c, ridx, E, len(allv))
                    log(f"  HIT dim {j}: a proper {k}-colouring of a {m}-vertex quotient (|S| = {ds}), "
                        f"pulled back and verified on all {witness['plane_edges_verified']} plane edges")
            kk = k + 1
            while best_k is None or kk < best_k:
                cbest = dsatur(adj, m, kk, max(8, tries // 4), rng)
                if cbest is not None:
                    if best_k is None or kk < best_k:
                        verify(adj, m, cbest, kk)
                        best_k = kk
                        # `best_k_found` without a colouring is a ceiling nobody can check from the file:
                        # the witness carries the quotient colouring AND its pullback to the plane, verified
                        # on every plane edge, so the record's own ceiling is re-checkable by a stranger.
                        best = colour_witness(M, m, ds, kk, cbest, ridx, E, len(allv))
                        log(f"  dim {j}: a proper {kk}-colouring found (m = {m}, |S| = {ds}), "
                            f"pulled back and verified on all {best['plane_edges_verified']} plane edges")
                    break
                kk += 1
                if kk > 12:
                    break
            if limit is not None and usable >= limit:
                break
        rows.append(dict(dim=j, index=3 ** (6 - j), quotient_size=3 ** (6 - j), subspaces=n_sub, usable=usable,
                         k=k, hits=hits, exact=exact, truncated=(None if limit is None else limit),
                         restarts=None if exact else tries,
                         best_k_found=best_k if hits == 0 else k, witness=witness,
                         best=(None if best is None else {f: best[f] for f in ("basis", "quotient_size", "connection_size")}),
                         best_witness=best, seconds=round(time.time() - t0, 1)))
        word = "EXACT" if exact else (f"a null at {tries} DSATUR restarts" + ("" if limit is None else f", TRUNCATED at {limit} usable subspaces"))
        log(f"dim {j} (index {3**(6-j)}): {n_sub} subspaces, {usable} usable, {hits} are {k}-colourable "
            f"[{word}]; best k found {rows[-1]['best_k_found']}  [{rows[-1]['seconds']}s]")
        # The record is rewritten after EVERY dimension, not once at the end: a sweep of the whole
        # family is tens of minutes, and a run whose state lives only in a process is a bug, not a
        # style choice (CLAUDE.md's checkpointing rule). A killed run leaves the dimensions it
        # finished; the relaunch redoes only the one in flight, and `--dims` names which.
        if out:
            emit(out, record(q, k, ne, h, rows, partial=True, limit=limit))
    rec = record(q, k, ne, h, rows, partial=False, limit=limit)
    if out:
        emit(out, rec)
    return rec


def colour_witness(M, m, ds, k, qcol, ridx, E, n):
    """a colouring the record carries: the subgroup, the quotient colouring, and its pullback to the plane,
    the pullback verified here on every plane edge before it is written."""
    plane = pullback(ridx, qcol)
    checked = verify_plane(E, plane, k, n)
    return dict(basis=M, quotient_size=m, connection_size=ds, k=k, quotient_colouring=qcol,
                plane_colouring=plane, plane_edges_verified=checked,
                vertex="(x0,x1,x2,y0,y1,y2) with vertex id = 243 x0 + 81 x1 + 27 x2 + 9 y0 + 3 y1 + y2, "
                       "x = x0 + x1 t + x2 t^2 over F_3[t]/(t^3 - t - 1) -- the index of data/fplane/chi-q27.json and of tools/fplane.py graph_q27()")


def record(q, k, ne, h, rows, partial=False, limit=None):
    return dict(kind="fplane-periodic-subgroups", q=q, k=k, n=q * q, degree=q + 1, edges=ne,
                edges_sha256=h, rows=rows, partial=partial, dims_done=[r["dim"] for r in rows],
                truncated=limit,
                claim_scope=("a hit is a VERIFIED proper colouring of a quotient, pulled back and re-verified on every edge of the "
                             "plane itself, so chi(UD(F_q,2)) <= k follows; the same for best_witness at best_k_found; "
                             "a miss at dim >= 3 is exact over that family; a miss at dim <= 2 is a null at the DSATUR budget; "
                             "no result here ever refuses a colouring of the plane, which need not be periodic"
                             + ("" if limit is None else f"; TRUNCATED: each dimension stopped after {limit} usable subspaces, so no count here is a census and no miss is exact")))


REPO_RECORD = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "data", "fs53", "periodic-q27.json")


def self_test():
    """seven controls, each watched to fire.  Nothing here writes anywhere but a scratch directory, and
    control 7 is the positive signal for that: the committed record is hashed at entry and at exit and the
    two must agree (a self-test that quietly rewrote the survey it is testing is the defect this pass was
    opened for, and 'it did not happen' has to be asserted, never assumed)."""
    repo_before = (open(REPO_RECORD, "rb").read() if os.path.exists(REPO_RECORD) else None)
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
        m, adj, ds, ridx = qg
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
    # 4 the writer: one record, written by `emit` from inside `sweep`, under a SCRATCH path only
    with tempfile.TemporaryDirectory(prefix="fs53-a02-") as scratch:
        outp = os.path.join(scratch, "periodic-selftest.json")
        rec = sweep(27, 9, [4], 8, log=lambda *_: None, out=outp, limit=3)
        onfile = json.load(open(outp))
        shaped = (onfile == rec and onfile["partial"] is False and onfile["dims_done"] == [4]
                  and onfile["truncated"] == 3 and os.path.dirname(os.path.abspath(outp)) == os.path.abspath(scratch))
        print(f"[control 4] the sweep writes one record, through emit, under the scratch path only; "
              f"final partial={onfile['partial']}, dims_done={onfile['dims_done']}, and the file equals the returned record: {shaped}")
        ok &= shaped
        # 5 a truncated run may never say EXACT, and says truncated in the row, the record and the scope
        row = onfile["rows"][0]
        honest = (row["exact"] is False and row["truncated"] == 3 and "TRUNCATED" in onfile["claim_scope"])
        print(f"[control 5] a truncated enumeration never claims exactness: exact={row['exact']}, truncated={row['truncated']}, scope says so: {honest}")
        ok &= honest
        # 6 best_witness carries a colouring, and it is re-verified HERE against the plane's own edge list
        E = plane_edges(cv, allv, pow3)
        w = row["best_witness"] or row["witness"]
        checked = verify_plane(E, w["plane_colouring"], w["k"], len(allv))
        carried = (w is not None and len(w["plane_colouring"]) == 729 and checked == 10206 and w["plane_edges_verified"] == 10206)
        print(f"[control 6] the record's own witness at k = {w['k']} is a {len(w['plane_colouring'])}-point colouring of the plane, "
              f"re-verified here on all {checked} edges: {carried}")
        ok &= carried
        # 6b PLANT: one repainted vertex must be caught, and the message must name the edge
        bad = list(w["plane_colouring"]); u, v = E[0]; bad[u] = bad[v]
        try:
            verify_plane(E, bad, w["k"], len(allv)); fired = False; msg = "(no refusal)"
        except AssertionError as e:
            fired = True; msg = str(e)
        print(f"[control 6b] planted red: repainting vertex {u} to its neighbour's colour is refused -- {msg}: {fired}")
        ok &= fired
    # 7 the committed record is untouched by everything above (the point of the pass)
    repo_after = (open(REPO_RECORD, "rb").read() if os.path.exists(REPO_RECORD) else None)
    untouched = repo_before == repo_after
    print(f"[control 7] the committed record {os.path.relpath(REPO_RECORD)} is byte-identical before and after this self-test "
          f"({'it is not on disk, so nothing to touch' if repo_before is None else str(len(repo_before)) + ' bytes'}): {untouched}")
    ok &= untouched
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
    if a.out:                      # `sweep` has already written it, through emit -- the file's ONE writer
        print(f"  wrote {a.out}")
    else:
        print(json.dumps(rec, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
