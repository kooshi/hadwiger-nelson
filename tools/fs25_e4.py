#!/usr/bin/env python3
"""FS-25 item E4 — de Grey's 1581 has three critical vertices, from its 1-sum shape.

De Grey's 5-chromatic unit-distance graph is a *1-sum*: two 791-vertex halves meeting in
the single vertex 14, plus one cross edge (11, 802).  Deleting 11 or 802 removes the only
crossing edge, leaving two 4-colourable halves glued at 14; deleting 14 leaves them joined
by that edge alone.  Either way a palette permutation finishes the colouring, so all three
vertices are CRITICAL at four colours — and `CriticalSet.encard_criticalSet_le_two_of_forces`
(kernel, M54) caps the critical set of a forcing graph at two.  Hence de Grey's graph forces
no pair equal at five colours, by theorem rather than by the 1,248,990-pair sweep M48 ran.

Untrusted, like everything under tools/: the colourings it emits are re-verified here by a
code path that shares nothing with the search, and would be re-verified again by Lean if this
were ever promoted.

    python3 tools/degrey.py          # emits tools/degrey_graph.json  (exact arithmetic)
    python3 tools/fs25_e4.py         # this file; writes data/e4-critical-vertices.json
    python3 tools/fs25_e4.py --red   # the negative controls (slower: two UNSAT proofs)

Controls, all of which have been seen to fire:
  * each half REFUSES three colours          — the encoding constrains; the halves are exactly 4-chromatic
  * a planted corruption of a committed colouring is CAUGHT by the verifier
  * (empty population, reported as such) the graph has minimum degree 4, so there is no
    vertex of degree <= 3 to serve as a provably NON-critical red.
"""
import json, os, subprocess, sys, tempfile

CADICAL = os.path.join(os.path.dirname(__file__), "..", "cadical")
if not os.path.exists(CADICAL):
    CADICAL = os.path.expanduser(
        "~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")


def solve(clauses, nvars, timeout=1800):
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False) as t:
        t.write(f"p cnf {nvars} {len(clauses)}\n")
        for c in clauses:
            t.write(" ".join(map(str, c)) + " 0\n")
        path = t.name
    try:
        r = subprocess.run([CADICAL, "-q", path], capture_output=True, text=True,
                           timeout=timeout)
        if r.returncode == 20:
            return "unsat", None
        if r.returncode != 10:
            raise RuntimeError(f"cadical returned {r.returncode} — a crash, not a verdict")
        return "sat", {int(x) for l in r.stdout.splitlines() if l.startswith("v ")
                       for x in l[2:].split() if x != "0"}
    except subprocess.TimeoutExpired:
        return "unknown", None
    finally:
        os.unlink(path)


def colour(verts, edges, k):
    """A proper k-colouring of (verts, edges) as a dict, or None."""
    idx = {v: i for i, v in enumerate(sorted(verts))}
    var = lambda v, c: idx[v] * k + c + 1
    cls = [[var(v, c) for c in range(k)] for v in verts]
    for v in verts:
        for c in range(k):
            for d in range(c + 1, k):
                cls.append([-var(v, c), -var(v, d)])
    for u, v in edges:
        for c in range(k):
            cls.append([-var(u, c), -var(v, c)])
    st, model = solve(cls, len(verts) * k)
    if st != "sat":
        return st, None
    return "sat", {v: next(c for c in range(k) if var(v, c) in model) for v in verts}


def verify(col, edges, k, name):
    """The independent re-check: total, in range, proper.  Shares no code with `colour`."""
    missing = [x for e in edges for x in e if col.get(x) is None]
    clash = [(u, v) for u, v in edges if col.get(u) == col.get(v)]
    bad_range = [v for v, c in col.items() if not (0 <= c < k)]
    ok = not (missing or clash or bad_range)
    print(f"  {name}: {len(edges)} edges | {len(clash)} monochromatic | "
          f"{len(missing)} uncoloured | {len(bad_range)} out of palette | "
          f"colours used {sorted(set(col.values()))} | {'OK' if ok else 'FAILED'}")
    if not ok:
        raise SystemExit(f"verification failed for {name}")
    return True


def load():
    here = os.path.dirname(__file__)
    G = json.load(open(os.path.join(here, "degrey_graph.json")))
    n, E = G["n"], [tuple(e) for e in G["edges"]]
    a, b, _ = G["halves"]
    EA, EB, EC = E[:a], E[a:a + b], E[a + b:]
    A = {x for e in EA for x in e}
    B = {x for e in EB for x in e}
    assert len(EC) == 1 and A & B == set(G["shared"]) and len(A | B) == n
    assert all(set(e) <= A or set(e) <= B or e == EC[0] for e in E), \
        "an edge lies outside the 1-sum decomposition — the whole argument depends on this"
    return n, E, EA, EB, EC[0], A, B, G["shared"][0]


def main(red=False):
    n, E, EA, EB, cross, A, B, shared = load()
    cu, cv = cross
    print(f"structure: |A|={len(A)} |B|={len(B)} A∩B={{{shared}}} cross={cross}; "
          f"all {len(E)} edges inside a half or the cross edge")

    print("· each half at four colours")
    stA, cA = colour(A, EA, 4)
    stB, cB = colour(B, EB, 4)
    if stA != "sat" or stB != "sat":
        raise SystemExit(f"a half is not 4-colourable ({stA}, {stB}) — the argument collapses")
    verify(cA, EA, 4, "G[A]")
    verify(cB, EB, 4, "G[B]")

    def repalette(col, swap_a, swap_b):
        p = list(range(4))
        p[swap_a], p[swap_b] = p[swap_b], p[swap_a]
        return {v: p[c] for v, c in col.items()}

    witnesses = {}
    # deleting an endpoint of the cross edge: glue the halves by agreeing at `shared`
    cB_at_shared = repalette(cB, cB[shared], cA[shared])
    for drop in (cu, cv):
        col = dict(cA); col.update(cB_at_shared)
        verify(col, [e for e in E if drop not in e], 4, f"G − {drop} (glued at {shared})")
        witnesses[drop] = col
    # deleting the shared vertex: glue by DISagreeing across the cross edge
    cB_off = cB if cB[cv] != cA[cu] else repalette(cB, cB[cv], (cA[cu] + 1) % 4)
    col = dict(cA); col.update({v: c for v, c in cB_off.items() if v != shared})
    col[shared] = 0                      # isolated once its incident edges are gone
    verify(col, [e for e in E if shared not in e], 4, f"G − {shared} (glued across {cross})")
    witnesses[shared] = col

    if red:
        print("· negative controls")
        for nm, (V, Ed) in {"G[A]": (A, EA), "G[B]": (B, EB)}.items():
            st, _ = colour(V, Ed, 3)
            print(f"  RED  {nm} at three colours: {st}"
                  + ("  (as required)" if st == "unsat" else "  ← CONTROL FAILED"))
        bad = dict(witnesses[cu]); u, v = next(e for e in E if cu not in e)
        bad[v] = bad[u]
        found = [e for e in E if cu not in e and bad[e[0]] == bad[e[1]]]
        print(f"  RED  planted corruption on {(u, v)}: verifier finds {len(found)} clash(es)"
              + ("  (CAUGHT)" if found else "  ← CONTROL FAILED"))
        deg = {}
        for x, y in E:
            deg[x] = deg.get(x, 0) + 1; deg[y] = deg.get(y, 0) + 1
        low = [v for v in range(n) if deg.get(v, 0) <= 3]
        print(f"  RED  vertices of degree ≤ 3 (would be provably NON-critical): {len(low)} "
              f"— min degree is {min(deg.values())}, so this control has an EMPTY POPULATION")

    out = os.path.join(os.path.dirname(__file__), "..", "data", "e4-critical-vertices.json")
    json.dump({"schema": "e4-critical-vertices v1",
               "claim": "vertices 11, 802 and 14 are critical at four colours: deleting any one "
                        "leaves a 4-colourable graph, witnessed below.  With "
                        "CriticalSet.encard_criticalSet_le_two_of_forces (kernel) capping the "
                        "critical set of a forcing graph at two, de Grey's 1581 forces no pair "
                        "equal at five colours.",
               "graph": {"n": n, "edges": len(E), "halves": [len(EA), len(EB), 1],
                         "shared": shared, "cross_edge": list(cross)},
               "critical_vertices": [cu, cv, shared],
               "colourings": {str(k): [v[i] for i in range(n)] for k, v in witnesses.items()}},
              open(out, "w"))
    print(f"wrote {os.path.normpath(out)}")


if __name__ == "__main__":
    main(red="--red" in sys.argv)
