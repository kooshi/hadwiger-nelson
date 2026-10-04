#!/usr/bin/env python3
"""FS129-SA1 exact controls for the merged Falconer-fan / slack-plane family (plans/FS129-SA1-audit.md, stage 2).

Two checks, each exact over a set the derivation fixes; neither searches for a witness.

  noaff4      FS129-SA1-NOAFF-K at k = 4, on H = the Moser spindle without its tip edge (two unit rhombi a, b, c, t and a, b', c', t'
              sharing the apex; FS129-OA1-NOLIN5's and FS129-MA1-NOAFF5's model), which is three-colourable, so it maps into the
              triangle of Gamma_3 (the line F_3 x 0), a target slack at four colours (the fourth colour is absent everywhere).
              NOAFF-K says no affine identity holds on the simplex embedding across the proper 4-colourings of H: the indicator
              vectors' affine hull has the full dimension |V| (k - 1) = 21 (at three colours the tips are forced, FS129-MA1-NOAFF5-DIM's
              fault).  The rank is computed modulo the prime 1000003; a full rank modulo p is a full rank over Q (a minor that does
              not vanish mod p does not vanish over Z), so "21 of 21" is exact.  The run also re-checks that Gamma_7 is slack at four
              (circ7Table proper and gapped; a Cayley graph), the instance FS129-MA2-G7GAP holds.
              --fault-k4  replaces H by K_4, which receives no target slack at four (all four colours meet the closed neighbourhood
              of every vertex of a K_4's image) and satisfies the identity sum_v f(C(v)) = 0: the dimension falls to 9 of 12.

  fan4        FS129-SA1-FALC-FAN and FS129-SA1-FALC-DICHO-K at k = 4 on their model, the unit rhombus a, b, c, t (a Falconer fan at
              four colours): the fan property; clause (A) for T = H and for every labelled graph T on five vertices receiving H,
              every homomorphism rho, every proper 4-colouring C of T and every colour gamma absent from N_T[rho(a)]; clause (B) for
              the same T and every proper 3-colouring; DICHO-K (chi(H) = 3 and every proper 3-colouring gives a, t one colour).
              Prints the number of violations (expected 0).
              --fault-cycle  removes the edge b-c (the 4-cycle a, b, t, c is no fan at four): the fan property and clause (A) fail.

Usage:  python3 tools/fs129_sa1_family.py noaff4 [--fault-k4]
        python3 tools/fs129_sa1_family.py fan4 [--fault-cycle]
"""
import itertools
import sys

P = 1000003


def proper_colourings(n, edges, k):
    for c in itertools.product(range(k), repeat=n):
        if all(c[u] != c[v] for (u, v) in edges):
            yield c


def affine_dim_mod_p(n, edges, k):
    """Rank (mod P) of the indicator differences x_C - x_C0 over all proper k-colourings C; early exit at full rank."""
    full = n * (k - 1)
    basis = {}  # pivot column -> row (mod P), rows reduced
    base = None
    for c in proper_colourings(n, edges, k):
        x = [0] * (n * k)
        for v in range(n):
            x[v * k + c[v]] = 1
        if base is None:
            base = x
            continue
        d = [(a - b) % P for a, b in zip(x, base)]
        for col in sorted(basis):
            if d[col]:
                f = d[col]
                row = basis[col]
                d = [(a - f * b) % P for a, b in zip(d, row)]
        piv = next((i for i, a in enumerate(d) if a), None)
        if piv is not None:
            inv = pow(d[piv], P - 2, P)
            d = [(a * inv) % P for a in d]
            for col in list(basis):
                r = basis[col]
                if r[piv]:
                    f = r[piv]
                    basis[col] = [(a - f * b) % P for a, b in zip(r, d)]
            basis[piv] = d
            if len(basis) == full:
                break
    return len(basis), full


def gamma7_slack():
    p = 7
    circle = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    table = [0, 1, 2, 0, 1, 2, 3]  # circ7Table, Instances/PlaneFreedom.lean line 54
    col = {(x, y): table[(y - 2 * x) % p] for x in range(p) for y in range(p)}
    improper = sum(1 for v in col for (dx, dy) in circle if col[v] == col[((v[0] + dx) % p, (v[1] + dy) % p)])
    gapped = sum(1 for v in col if len({col[v]} | {col[((v[0] + dx) % p, (v[1] + dy) % p)] for (dx, dy) in circle}) < 4)
    return circle, improper == 0 and gapped > 0


def noaff4(fault):
    circle, slack = gamma7_slack()
    if fault:
        n, edges, label = 4, list(itertools.combinations(range(4), 2)), "K_4"
    else:
        # a=0, b=1, c=2, t=3, b'=4, c'=5, t'=6
        n = 7
        edges = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (0, 4), (0, 5), (4, 5), (4, 6), (5, 6)]
        label = "the spindle without its tip edge"
        tri = [(0, 0), (1, 0), (2, 0)]
        assert all(((u[0] - v[0]) ** 2 + (u[1] - v[1]) ** 2) % 3 == 1 for u, v in itertools.combinations(tri, 2))
        assert next(proper_colourings(n, edges, 3), None) is not None  # three-colourable, so it maps into that triangle of Gamma_3
    d, full = affine_dim_mod_p(n, edges, 4)
    print(f"Gamma_7 slack at four (circ7Table proper and gapped, Cayley): {slack}; H = {label}, {n} vertices, {len(edges)} edges")
    print(f"k=4: dim {d} of {full}")


def fan4(fault):
    a, b, c, t = 0, 1, 2, 3
    H_edges = [(a, b), (a, c), (b, t), (c, t)] + ([] if fault else [(b, c)])
    n = 4
    adjH = [set() for _ in range(n)]
    for u, v in H_edges:
        adjH[u].add(v); adjH[v].add(u)
    K = 4
    viol = 0
    # the fan property at four colours
    rest = [b, c, t]
    fan = True
    for col in itertools.product(range(K), repeat=3):
        cc = dict(zip(rest, col))
        if any(cc[u] == cc[v] for (u, v) in H_edges if a not in (u, v)):
            continue
        for c1, c2 in itertools.combinations(range(K), 2):
            if all(cc[v] not in (c1, c2) for v in adjH[a]) and cc[t] not in (c1, c2):
                fan = False
    viol += 0 if fan else 1
    # clauses (A) and (B) over T = H and every labelled graph on five vertices receiving H
    targets = [(n, H_edges)]
    N = 5
    pairs = list(itertools.combinations(range(N), 2))
    for mask in range(1 << len(pairs)):
        targets.append((N, [pairs[i] for i in range(len(pairs)) if mask >> i & 1]))
    graphs = 0
    for (m, Tedges) in targets:
        adj = [set() for _ in range(m)]
        for u, v in Tedges:
            adj[u].add(v); adj[v].add(u)
        homs = [img for img in itertools.product(range(m), repeat=n)
                if all(img[v] in adj[img[u]] for (u, v) in H_edges)]
        if not homs:
            continue
        graphs += 1
        ends = {(img[a], img[t]) for img in homs}
        for C in proper_colourings(m, Tedges, K):
            for (ra, rt) in ends:
                closed_a = {C[ra]} | {C[x] for x in adj[ra]}
                closed_t = {C[rt]} | {C[x] for x in adj[rt]}
                for g in range(K):
                    if g in closed_a:
                        continue
                    if C[rt] not in (C[ra], g):
                        viol += 1
                    viol += sum(1 for g2 in range(K) if g2 not in closed_t and g2 not in (C[ra], g))
        for C in proper_colourings(m, Tedges, K - 1):
            for (ra, rt) in ends:
                if C[ra] != C[rt]:
                    viol += 1
                if len({C[rt]} | {C[x] for x in adj[rt]}) < K - 1:
                    viol += 1
    # DICHO-K at k = 4 on H itself
    chi = next(k for k in range(1, n + 1) if any(True for _ in proper_colourings(n, H_edges, k)))
    dicho = int(chi < K - 1) + (sum(1 for C in proper_colourings(n, H_edges, K - 1) if C[a] != C[t]) if chi == K - 1 else 0)
    viol += dicho
    print(f"fan at four: {fan}; targets receiving H: {graphs}; chi(H) = {chi}; DICHO-K violations {dicho}")
    print(f"k=4 violations={viol}")


if __name__ == "__main__":
    args = [x for x in sys.argv[1:] if not x.startswith("--")]
    if args == ["noaff4"]:
        noaff4("--fault-k4" in sys.argv)
    elif args == ["fan4"]:
        fan4("--fault-cycle" in sys.argv)
    else:
        sys.exit("usage: fs129_sa1_family.py noaff4 [--fault-k4] | fan4 [--fault-cycle]")
