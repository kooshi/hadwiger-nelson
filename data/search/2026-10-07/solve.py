#!/usr/bin/env python3
"""SEARCH-2026-10-07 — the encoding of the seven-flower ring family over the exact pair tables, the solve, the decode.

Reads tables-ta8.json (and asserts tables-ta20.json equal), builds one CNF per variant, decides it with the toolchain's
cadical (LRAT proof, checked by cake_lpr) and, for a refusal, names a minimal set of constraint groups that refuses
(deletion over group selectors, pysat glucose4).  A model is decoded to MODEL-<variant>.json for cold_check.py.

Variables:  c[k][w] in labels 0..5 (ring wedge w at y_k);  X[j] in {3,4,5} (x sub-sector E_j);  K[m] in {S,A,B}
(type of the critical ray at direction 30(2m+1));  U[k][l] (label l occurs at y_k).
Groups:  ring (the wedges on the ring carry the ring's label or a label of x, and the ring's label at least once per
side); xtri (each of 3, 4, 5 occurs at x); simple (each of them on one contiguous arc at x); straight (every K = S);
maxlab (at most M labels at each ring point); rr:A,B (two same-label wedges A at y_k, B at y_{k+1} the table rejects);
xr:w (a label of x on wedge w of a ring point against a sub-sector of that label the table rejects).

usage: solve.py RING MAXLAB XFAM [--drop GROUP ...] [--tag TAG]     RING = turning | alternating
       XFAM = simple-straight | simple-curved | any-straight | any-curved
"""
import sys, os, json, itertools, subprocess, time
from pysat.solvers import Solver

HERE = os.path.dirname(os.path.abspath(__file__))
CADICAL = os.path.expanduser("~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")
CAKE = os.path.expanduser("~/source/cake_lpr/cake_lpr")
RINGS = {"turning": [0, 1, 2, 0, 1, 2], "alternating": [0, 1, 0, 1, 0, 1]}
NAMES = "abn345"
TYPES = "SAB"
WN = ["O_cw", "O_far", "O_ccw", "I_ccw", "I_lens", "I_cw"]


def load_tables():
    a = json.load(open(os.path.join(HERE, "tables-ta8.json")))
    b = json.load(open(os.path.join(HERE, "tables-ta20.json")))
    assert a["plant"] is None and a["gplant"] is None and b["plant"] is None and b["gplant"] is None
    assert a["rr_reject"] == b["rr_reject"] and a["xr_reject"] == b["xr_reject"], "tables differ between radii"
    assert a["rr_pairs"] == 666 and a["xr_pairs"] == 1296
    return [tuple(r) for r in a["rr_reject"]], [tuple(r) for r in a["xr_reject"]]


class Enc:
    def __init__(s):
        s.n = 0; s.groups = {}; s.names = {}

    def var(s, name):
        if name not in s.names:
            s.n += 1; s.names[name] = s.n
        return s.names[name]

    def add(s, group, clause):
        s.groups.setdefault(group, []).append(list(clause))

    def exactly_one(s, group, lits):
        s.add(group, lits)
        for p, q in itertools.combinations(lits, 2):
            s.add(group, [-p, -q])


def encode(ring, maxlab, xfam, tables):
    rr, xr = tables
    L = RINGS[ring]
    E = Enc()
    c = lambda k, w, l: E.var(("c", k % 6, w, l))
    X = lambda j, t: E.var(("X", j % 12, t))
    K = lambda m, ty: E.var(("K", m, ty))
    U = lambda k, l: E.var(("U", k, l))
    for k in range(6):
        for w in range(6):
            E.exactly_one("struct", [c(k, w, l) for l in range(6)])
    for j in range(12):
        E.exactly_one("struct", [X(j, t) for t in (3, 4, 5)])
    for m in range(6):
        E.exactly_one("struct", [K(m, ty) for ty in TYPES])
    # ring: at y_k the cw side (wedges 0, 5) carries L[k], the ccw side (wedges 2, 3) carries L[k+1]
    for k in range(6):
        for (ws, lab) in (((0, 5), L[k]), ((2, 3), L[(k + 1) % 6])):
            for w in ws:
                for l in range(3):
                    if l != lab:
                        E.add("ring", [-c(k, w, l)])
            E.add("ring", [c(k, w, lab) for w in ws])
    for t in (3, 4, 5):
        E.add("xtri", [X(j, t) for j in range(12)])
    if xfam.startswith("simple"):
        for t in (3, 4, 5):
            starts = []
            for j in range(12):
                st = E.var(("start", j, t))      # st <-> X[j] = t and X[j-1] != t
                E.add("simple", [-st, X(j, t)]); E.add("simple", [-st, -X(j - 1, t)])
                E.add("simple", [st, -X(j, t), X(j - 1, t)])
                starts.append(st)
            for p, q in itertools.combinations(starts, 2):
                E.add("simple", [-p, -q])
    if xfam.endswith("straight"):
        for m in range(6):
            E.add("straight", [K(m, "S")])
    for k in range(6):
        for l in range(6):
            for w in range(6):
                E.add("struct", [-c(k, w, l), U(k, l)])
            E.add("struct", [-U(k, l)] + [c(k, w, l) for w in range(6)])
        for S in itertools.combinations(range(6), maxlab + 1):
            E.add("maxlab", [-U(k, l) for l in S])
    for (k, a, k2, b) in rr:
        if (k2 - k) % 6 == 1: kk, A, B = k, a, b
        elif (k - k2) % 6 == 1: kk, A, B = k2, b, a
        else: raise AssertionError(("a rejected pair of ring wedges that are not at adjacent ring points", k, a, k2, b))
        for l in range(6):
            E.add(f"rr:{A},{B}", [-c(kk, A, l), -c(kk + 1, B, l)])
    for (j, ty, k, w) in xr:
        m = ((j if j % 2 == 1 else j + 1) % 12 - 1) // 2
        for t in (3, 4, 5):
            E.add(f"xr:{w}", [-X(j, t), -K(m, ty), -c(k, w, t)])
    return E


def write_cnf(E, path, drop=()):
    cl = [cls for g, cs in E.groups.items() if g not in drop for cls in cs]
    with open(path, "w") as fh:
        fh.write(f"p cnf {E.n} {len(cl)}\n")
        for cls in cl:
            fh.write(" ".join(map(str, cls)) + " 0\n")
    return len(cl)


def decode(E, model):
    pos = set(v for v in model if v > 0)
    inv = {v: n for n, v in E.names.items()}
    ring = [[None] * 6 for _ in range(6)]; xs = [None] * 12; ks = [None] * 6
    for v in pos:
        n = inv.get(v)
        if n is None: continue
        if n[0] == "c": ring[n[1]][n[2]] = n[3]
        elif n[0] == "X": xs[n[1]] = n[2]
        elif n[0] == "K": ks[n[1]] = n[2]
    return {"ring": ring, "x": xs, "K": ks}


def show(M):
    out = []
    for k in range(6):
        out.append(f"  y_{k}: " + " ".join(f"{WN[w]}={NAMES[M['ring'][k][w]]}" for w in range(6)))
    out.append("  x:   " + " ".join(NAMES[t] for t in M["x"]) + "   K=" + "".join(M["K"]))
    return "\n".join(out)


def group_core(E, drop=()):
    """a minimal set of groups (struct always kept) whose clauses are unsatisfiable together."""
    groups = [g for g in E.groups if g != "struct" and g not in drop]
    sel = {g: E.n + 1 + i for i, g in enumerate(groups)}
    with Solver(name="glucose4") as S:
        for cls in E.groups["struct"]:
            S.add_clause(cls)
        for g in groups:
            for cls in E.groups[g]:
                S.add_clause(cls + [-sel[g]])
        keep = list(groups)
        assert not S.solve(assumptions=[sel[g] for g in keep]), "core asked of a satisfiable formula"
        core = set(abs(x) for x in S.get_core())
        keep = [g for g in keep if sel[g] in core]
        for g in list(keep):
            trial = [h for h in keep if h != g]
            if not S.solve(assumptions=[sel[h] for h in trial]):
                keep = trial
        # confirm minimality: every group of the core is needed
        for g in keep:
            assert S.solve(assumptions=[sel[h] for h in keep if h != g])
        assert not S.solve(assumptions=[sel[h] for h in keep])
    return keep


def count_models(E, drop=(), cap=20000):
    """the number of models projected to (ring labels, x labels); stops at cap."""
    proj = [v for n, v in E.names.items() if n[0] in ("c", "X")]
    n = 0; first = None
    with Solver(name="glucose4") as S:
        for g, cs in E.groups.items():
            if g in drop: continue
            for cls in cs: S.add_clause(cls)
        while n < cap and S.solve():
            m = S.get_model(); ms = set(v for v in m if v > 0)
            if first is None: first = m
            n += 1
            S.add_clause([-v if v in ms else v for v in proj])
    return n, first


def main():
    a = sys.argv[1:]
    ring, maxlab, xfam = a[0], int(a[1]), a[2]
    drop = tuple(a[i + 1] for i, x in enumerate(a) if x == "--drop")
    tag = a[a.index("--tag") + 1] if "--tag" in a else f"{ring}-max{maxlab}-{xfam}" + ("".join("-drop_" + d.replace(":", "").replace(",", "_") for d in drop))
    tables = load_tables()
    E = encode(ring, maxlab, xfam, tables)
    cnf = os.path.join(HERE, "cnf", tag + ".cnf"); lrat = os.path.join(HERE, "cnf", tag + ".lrat")
    os.makedirs(os.path.dirname(cnf), exist_ok=True)
    ncl = write_cnf(E, cnf, drop)
    if os.path.exists(lrat): os.remove(lrat)
    r = subprocess.run([CADICAL, "--lrat", "--no-binary", "-q", cnf, lrat], capture_output=True, text=True)
    if r.returncode == 20:
        ck = subprocess.run([CAKE, cnf, lrat], capture_output=True, text=True)
        verified = ck.returncode == 0 and "s VERIFIED UNSAT" in ck.stdout
        if not verified:
            print(f"VARIANT {tag}: cadical UNSAT but cake_lpr did not verify: rc={ck.returncode} out={ck.stdout[-300:]!r} err={ck.stderr[-300:]!r}")
            sys.exit(3)
        core = group_core(E, drop)
        print(f"VARIANT {tag}: vars={E.n} clauses={ncl}  UNSAT  cake_lpr=VERIFIED  proof={os.path.relpath(lrat, HERE)}  minimal-refusing-groups={sorted(core)}")
    elif r.returncode == 10:
        n, first = count_models(E, drop)
        M = decode(E, first)
        M.update({"ring_pattern": ring, "maxlab": maxlab, "xfam": xfam, "dropped": list(drop)})
        mp = os.path.join(HERE, "MODEL-" + tag + ".json")
        json.dump(M, open(mp, "w"))
        print(f"VARIANT {tag}: vars={E.n} clauses={ncl}  SAT  models(projected, cap 20000)={n}  first -> {os.path.relpath(mp, HERE)}")
        print(show(M))
    else:
        print(f"VARIANT {tag}: cadical returned {r.returncode}: {r.stdout[-300:]!r} {r.stderr[-300:]!r}")
        sys.exit(2)


if __name__ == "__main__":
    main()
