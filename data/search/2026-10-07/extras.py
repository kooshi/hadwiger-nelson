#!/usr/bin/env python3
"""SEARCH-2026-10-07 — controls on the tables, and what the satisfiable variants look like.

  plants     recompute the tables under three planted faults and count the entries that change (each must change some)
  handtable  the 22 rejected (A at y_k, B at y_{k+1}) pairs against the rule written by hand in the record (Stage 1, 1.5)
  threeway   for each x family: which sets of ring points can carry at most three labels at once (all 64 subsets)
  census     every model of turning-max4-simple-curved: its x flower and its label counts
"""
import sys, os, json, itertools
from fractions import Fraction as Fr
from pysat.solvers import Solver

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve as S          # noqa: E402


def plants():
    import turning_ring as R
    base = json.load(open(os.path.join(HERE, "tables-ta8.json")))
    b_rr, b_xr = set(map(tuple, base["rr_reject"])), set(map(tuple, base["xr_reject"]))
    ok = True
    for (plant, gplant) in ((None, None), ("cw_arcs", None), ("endpoints_only", None), ("closed_interval", None), (None, "far_chord")):
        T = R.tables(Fr(1, 8), plant, gplant)
        rr, xr = set(map(tuple, T["rr_reject"])), set(map(tuple, T["xr_reject"]))
        d_rr, d_xr = len(rr ^ b_rr), len(xr ^ b_xr)
        want_change = (plant, gplant) != (None, None)
        good = ((d_rr + d_xr) > 0) == want_change
        ok &= good
        print(f"plant={plant} gplant={gplant}: ring-ring entries changed={d_rr} of 666, x-ring entries changed={d_xr} of 1296  "
              f"{'as expected' if good else 'NOT AS EXPECTED'}")
    sys.exit(0 if ok else 1)


def handtable():
    rr, _ = S.load_tables()
    tab = {}
    for (k, a, k2, b) in rr:
        if (k2 - k) % 6 == 1: tab.setdefault(k, set()).add((a, b))
        elif (k - k2) % 6 == 1: tab.setdefault(k2, set()).add((b, a))
        else: raise AssertionError("non-adjacent reject")
    toward = {(A, B) for A in (2, 3, 4) for B in (0, 5, 4)} - {(2, 4), (4, 0)}
    away = {(A, B) for A in (5, 0, 1) for B in (3, 2, 1)} - {(1, 1), (5, 3)}
    hand = {(A, B) for A in range(6) for B in range(6)} - toward - away
    if "--fault" in sys.argv: hand = hand - {(1, 1)}
    same = all(tab[k] == hand for k in range(6))
    print(f"rejected pairs per adjacent pair of ring points: {[len(tab[k]) for k in range(6)]}  equal to the hand rule at every k: {same}")
    sys.exit(0 if same else 1)


def threeway():
    tables = S.load_tables()
    for ring in ("turning", "alternating"):
        for xfam in ("simple-straight", "simple-curved", "any-straight", "any-curved"):
            E = S.encode(ring, 6, xfam, tables)
            sel = [E.n + 1 + k for k in range(6)]
            with Solver(name="glucose4") as sv:
                for g, cs in E.groups.items():
                    for cls in cs: sv.add_clause(cls)
                for k in range(6):
                    for four in itertools.combinations(range(6), 4):
                        sv.add_clause([-sel[k]] + [-E.names[("U", k, l)] for l in four])
                sat = [set(sub) for r in range(7) for sub in itertools.combinations(range(6), r)
                       if sv.solve(assumptions=[sel[k] for k in sub])]
            mx = [s for s in sat if not any(s < t for t in sat)]
            print(f"{ring:11s} {xfam:15s}: satisfiable with no bound on labels: {set() in sat};  maximal sets of ring points "
                  f"with at most three labels: {sorted(sorted(s) for s in mx)}")


def census():
    tables = S.load_tables()
    E = S.encode("turning", 4, "simple-curved", tables)
    proj = [v for n, v in E.names.items() if n[0] in ("c", "X")]
    kv = {n: v for n, v in E.names.items() if n[0] == "K"}
    seen = {}
    with Solver(name="glucose4") as sv:
        for g, cs in E.groups.items():
            for cls in cs: sv.add_clause(cls)
        n = 0
        while sv.solve():
            m = sv.get_model(); ms = set(v for v in m if v > 0)
            M = S.decode(E, m)
            n += 1
            xs = M["x"]
            cuts = tuple(30 * j for j in range(12) if xs[j] != xs[j - 1])
            # the ray types this projected model admits at its interfaces: all K consistent with it
            nlab = tuple(len(set(M["ring"][k])) for k in range(6))
            tout = tuple("".join(S.NAMES[M["ring"][k][w]] if M["ring"][k][w] >= 3 else "." for w in range(6)) for k in range(6))
            seen.setdefault((cuts, nlab), []).append((M, tout))
            sv.add_clause([-v if v in ms else v for v in proj])
    print(f"turning-max4-simple-curved: {n} models (projected to ring and x labels)")
    for (cuts, nlab), lst in sorted(seen.items()):
        # which ray types at the three interfaces occur among completions of the first model of the class
        types = set()
        with Solver(name="glucose4") as sv:
            for g, cs in E.groups.items():
                for cls in cs: sv.add_clause(cls)
            for (M0, _) in lst:                       # every model of the class, not only the first
                fix = [E.names[("c", k, w, M0["ring"][k][w])] for k in range(6) for w in range(6)] + [E.names[("X", j, M0["x"][j])] for j in range(12)]
                for combo in itertools.product("SAB", repeat=3):
                    if any((c // 30) % 2 == 0 and t != "S" for c, t in zip(cuts, combo)): continue
                    ass = fix + [kv[("K", (c // 30 - 1) // 2, t)] for c, t in zip(cuts, combo) if (c // 30) % 2 == 1]
                    if sv.solve(assumptions=ass): types.add("".join(combo))
        print(f"  interfaces at x at {cuts} deg; labels per ring point {nlab}: {len(lst)} models; ray types at the three interfaces "
              f"admitted by any model of the class: {sorted(types)}")
        print("     first: wedges carrying a label of x, per ring point (O_cw O_far O_ccw I_ccw I_lens I_cw):", " ".join(lst[0][1]))


if __name__ == "__main__":
    {"plants": plants, "handtable": handtable, "threeway": threeway, "census": census}[sys.argv[1]]()
