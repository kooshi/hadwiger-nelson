#!/usr/bin/env python3
"""SEARCH-2026-10-06 — the controls: the checker and the CNF against the kernel's objects, and a planted fault per field.

Exit 0 iff every expectation holds. Each plant is paired: the faithful object passes, the planted one fails, and for a PURE
plant the failing set is exactly the planted field — read twice, by the checker (`violations`) and by the CNF (`clauses`, the
generator the runs solve: a field fails iff one of its clauses is falsified by the colouring).
"""
import os
import random
import subprocess
import sys
import tempfile
from itertools import combinations

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from search_20261006_check import CMap, FIELDS, violations, tac, torus_grid, grid_dart  # noqa: E402
from search_20261006_encode import clauses, build, run, window, CAKE  # noqa: E402

FAILS = []


def expect(cond, what):
    print(("ok    " if cond else "FAIL  ") + what)
    if not cond:
        FAILS.append(what)


def chk(M, col, k):
    return {x for x, b in violations(M, col, k).items() if b}


def cnf(M, col, k):
    """The fields whose clauses the colouring falsifies; `onehot` must never be falsified by a colouring."""
    out = set()
    for field, cl in clauses(M, k):
        if all((col[(abs(x) - 1) // k] == (abs(x) - 1) % k) != (x > 0) for x in cl):
            out.add(field)
    assert "onehot" not in out
    return out


def both(M, col, k, want, what, exact=True):
    a, b = chk(M, col, k), cnf(M, col, k)
    colour_fields = a - {"three_le_deg", "mu_zero"}
    expect(colour_fields == b, f"{what}: checker and CNF agree on the colour fields ({sorted(colour_fields)} / {sorted(b)})")
    expect(a == want if exact else want <= a, f"{what}: failing fields {sorted(a)}, planted {sorted(want)}")
    return a


def main():
    # --- the kernel's maps
    M3, cell3 = torus_grid(3, 3)
    g = lambda a, b, j: grid_dart(3, 3, a, b, j)  # noqa: E731
    expect(M3.sigma[g(0, 0, 3)] == g(0, 0, 0) and M3.alpha[g(0, 0, 0)] == g(1, 0, 2) and cell3[M3.face[g(1, 1, 2)]] == (0, 0),
           "torusGrid 3 3: Lean's example (sigma, alpha, face) reproduced")
    for n, m in [(1, 1), (2, 3), (3, 3), (4, 4), (5, 7)]:
        M, _ = torus_grid(n, m)
        expect(set(M.deg) == {4} and set(M.len) == {4} and M.chi2 == 0, f"torusGrid {n} {m}: deg 4, len 4, chi2 0")
    one = CMap([1, 2, 3, 0], [2, 3, 0, 1])
    expect(one.mu == [8] and one.deg == [4] and one.chi2 == 0, "oneFaceTorus: mu = 8, degree 4, chi2 = 0 (Basic.lean's docstring)")
    dig = CMap([1, 0, 3, 2], [2, 3, 0, 1])
    expect(dig.mu[dig.face[0]] == -1 and dig.face[0] == dig.face[3] and dig.chi2 == 4, "digon: mu true = -1 (digon_mu), chi2 = 4")
    # --- the kernel's two inhabitants
    c9 = [a + 3 * b for (a, b) in cell3]
    expect(chk(M3, c9, 9) == set() and cnf(M3, c9, 9) == set() and tac(M3, c9) == [], "grid9: every field holds; no tactic dart (grid9_tac)")
    M4, cell4 = torus_grid(4, 4)
    f15 = lambda a, b: 0 if (a, b) == (2, 1) else 6 if (a, b) == (3, 3) else (a + 4 * b) % 15  # noqa: E731
    c15 = [f15(a, b) for (a, b) in cell4]
    t15 = tac(M4, c15)
    expect(chk(M4, c15, 15) == set() and cnf(M4, c15, 15) == set() and len(t15) == 4, "grid15: every field holds; four tactic darts (grid15_card_tac)")
    expect(sorted(cell4[M4.face[d]] for d in t15) == [(1, 0), (1, 1), (3, 0), (3, 1)], "grid15: the tactic darts are corners of (1,0), (1,1), (3,0), (3,1)")
    expect(all(len(M4.adj[f]) == 8 for f in range(16)) and all(len(M3.adj[f]) == 8 for f in range(9)), "grid9_nbr, grid15_nbr: eight neighbours")
    # --- plants on the kernel's objects (not pure: reported)
    p = list(c15)
    p[cell4.index((3, 1))] = f15(1, 0)
    both(M4, p, 15, {"repeat_one_side"}, "grid15 with (3,1) recoloured as (1,0)", exact=False)
    p = list(c9)
    p[cell3.index((1, 1))] = c9[cell3.index((0, 0))]
    both(M3, p, 9, {"proper"}, "grid9 with (1,1) recoloured as (0,0)", exact=False)
    # --- three_le_deg, pure: torusGrid 3 3 with one edge subdivided by a vertex of degree 2 (the faces are unchanged)
    d, n = 0, M3.n
    sg, al = M3.sigma + [n + 1, n], list(M3.alpha) + [d, M3.alpha[d]]
    al[d], al[M3.alpha[d]] = n, n + 1
    Ms = CMap(sg, al)
    cs = [None] * Ms.F
    for x in range(n):
        cs[Ms.face[x]] = c9[M3.face[x]]
    expect(Ms.F == 9 and Ms.chi2 == 0 and sorted(Ms.deg)[0] == 2, "the subdivided grid: nine faces, chi2 0, a vertex of degree 2")
    both(Ms, cs, 9, {"three_le_deg"}, "three_le_deg planted (an edge of torusGrid 3 3 subdivided)")
    # --- mu_zero, pure: torusGrid 2 3, six cells in six colours (east and west neighbours coincide)
    M23, _ = torus_grid(2, 3)
    both(M23, list(range(6)), 6, {"mu_zero"}, "mu_zero planted (torusGrid 2 3, injective colouring)")
    both(one, [0], 1, {"mu_zero"}, "mu_zero planted (oneFaceTorus)")
    # --- proper, edge_rainbow, repeat_one_side, pure: torusGrid 8 8 under (a mod 4) + 4 (b mod 4), sixteen colours
    M8, cell8 = torus_grid(8, 8)
    at = {c: f for f, c in enumerate(cell8)}
    base = [(a % 4) + 4 * (b % 4) for (a, b) in cell8]
    both(M8, base, 16, set(), "torusGrid 8 8 under (a mod 4) + 4 (b mod 4): faithful")
    p = list(base); p[at[(2, 2)]] = base[at[(3, 2)]]
    both(M8, p, 16, {"proper"}, "proper planted ((2,2) as its east neighbour)")
    p = list(base); p[at[(2, 2)]] = base[at[(4, 2)]]
    both(M8, p, 16, {"edge_rainbow"}, "edge_rainbow planted ((2,2) as (4,2))")
    p = list(base); p[at[(1, 3)]] = base[at[(3, 2)]]
    both(M8, p, 16, set(), "one knight's-move repeat alone: faithful (the partner of the next plant)")
    # (1,3) is a knight's move from (3,2) and, round the torus, from (7,2), which has the same colour: two darts each
    expect(len(tac(M8, p)) == 4, f"one recoloured cell, a knight's move from two cells of its new colour: four tactic darts ({len(tac(M8, p))})")
    p[at[(4, 3)]] = base[at[(2, 2)]]
    both(M8, p, 16, {"repeat_one_side"}, "repeat_one_side planted (repeats on both sides of the edge (2,2) | (3,2))")
    # --- partner_unique, absent_cap, pure: the snub square tiling on a torus, every face its own colour, then one plant
    Msn, _ = build("snub", 3, 0, 3)
    k = Msn.F
    inj = list(range(k))
    expect(Msn.chi2 == 0 and set(Msn.deg) == {5} and sorted(set(Msn.len)) == [3, 4], "snub 3x3: chi2 0, degree 5, triangles and squares")
    expect(chk(Msn, inj, k) == set(), "snub 3x3, injective colouring: every field holds")
    found = {"partner_unique": None, "absent_cap": None}
    for f in range(Msn.F):
        for z, z2 in combinations(sorted(Msn.vn[f]), 2):
            for gg in sorted(Msn.eadj[f]):
                if found["partner_unique"] is None:
                    p = list(inj); p[z] = p[z2] = inj[gg]
                    if chk(Msn, p, k) == {"partner_unique"}:
                        found["partner_unique"] = p
        for S in combinations(sorted(Msn.vn[f]), 4):
            if found["absent_cap"] is None:
                p = list(inj)
                for z in S:
                    p[z] = inj[S[0]]
                if chk(Msn, p, k) == {"absent_cap"}:
                    found["absent_cap"] = p
    for x, p in found.items():
        expect(p is not None, f"{x}: a pure plant exists on snub 3x3")
        if p is not None:
            a = chk(Msn, p, k)
            b = {fl for fl, cl in clauses(Msn, k, skip=("repeat_one_side",))
                 if all((p[(abs(v) - 1) // k] == (abs(v) - 1) % k) != (v > 0) for v in cl)}
            expect(a == {x} and b == {x}, f"{x} planted on snub 3x3: checker {sorted(a)}, CNF (repeat_one_side's clauses not generated at k = {k}) {sorted(b)}")
    # --- the checker and the CNF on random colourings (the differential test)
    rng = random.Random(20261006)
    seen = set()
    maps = [("torusGrid 4 5", torus_grid(4, 5)[0]), ("snub 2x2", build("snub", 2, 0, 2)[0]), ("deltoidal 2x2", build("deltoidal", 2, 0, 2)[0]),
            ("cairo 2x2", build("cairo", 2, 0, 2)[0]), ("elongated 3x2", build("elongated", 3, 0, 2)[0]), ("triangular 4x4", build("triangular", 4, 0, 4)[0])]
    agree = True
    for name, M in maps:
        for k in (6, 12, 20):
            for _ in range(15):
                col = [rng.randrange(k) for _ in range(M.F)]
                a, b = chk(M, col, k) - {"three_le_deg", "mu_zero"}, cnf(M, col, k)
                seen.add(frozenset(a))
                agree = agree and a == b
    expect(agree, f"checker and CNF agree on 270 random colourings of six maps ({len(seen)} distinct failing sets seen)")
    expect(len(seen) >= 6, "the random colourings reach at least six distinct failing sets")
    # --- the solve path: it finds a model where one exists and refuses where the count forbids one
    tmp = tempfile.mkdtemp(prefix="search-20261006-controls-")
    v, col, _, _ = run(M3, 9, os.path.join(tmp, "g9"))
    expect(v == "SAT" and chk(M3, col, 9) == set(), "torusGrid 3 3 at nine colours: SAT, and the checker accepts the solver's model")
    v, _, _, _ = run(M3, 5, os.path.join(tmp, "g5"))
    expect(v == "UNSAT", "torusGrid 3 3 at five colours: UNSAT, cake_lpr verified (five_count)")
    Mt, dc = build("triangular", 4, 0, 4)
    expect(set(Mt.deg) == {6} and not any(Mt.mu) and Mt.chi2 == 0, "triangular 4x4: degree 6, mu = 0, chi2 = 0")
    v, _, _, _ = run(Mt, 6, os.path.join(tmp, "t6"))
    expect(v == "UNSAT", "triangular 4x4 at six colours: UNSAT, cake_lpr verified (room: 3 V6 <= V4)")
    q = subprocess.run([CAKE, os.path.join(tmp, "g9.cnf"), os.path.join(tmp, "g5.lrat")], capture_output=True, text=True)
    expect("s VERIFIED UNSAT" not in q.stdout, "cake_lpr refuses a satisfiable formula with another formula's proof")
    M10, dc10 = build("square", 10, 0, 10)
    cen, m, f0 = window(M10, dc10, 10)
    v, col, _, _ = run(M10, 9, os.path.join(tmp, "w9"), cen, f0)
    expect(v == "SAT" and m is not None, f"a free-boundary window of the square grid at nine colours: SAT ({len(cen)} centres, margin {m})")
    print(f"\n{len(FAILS)} failure(s)" if FAILS else "\nALL CONTROLS PASS")
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
