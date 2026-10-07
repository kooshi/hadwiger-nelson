#!/usr/bin/env python3
"""The shifted-sequence family (see offsets_search.py), decided exactly by one SAT instance per case.

    c(t*v + u*w) = W[(t + g(u)) mod q]

Variables: G[u][p] (line u starts at offset p), U[e] (shift e occurs between two lines joined by a unit step),
W[tau][c] (clock position tau has colour c) or, for the class question, M[tau] (position tau is in the class).
Usage: offsets_sat.py q kind k [family]     kind = col (k colours) | cls (one class at k clock positions)
The solver is kissat; a SAT answer is decoded and re-checked cell by cell; an UNSAT answer is the solver's word.
"""
import subprocess, sys, tempfile, os
from pysat.card import CardEnc, EncType

sys.path.insert(0, os.path.dirname(__file__))
from offsets_search import steps, coords, is_qr


def build(q, v, w, kind, k):
    S = steps(q)
    AB = coords(q, v, w, S)
    nv = 0

    def new():
        nonlocal nv
        nv += 1
        return nv

    G = [[new() for _ in range(q)] for _ in range(q)]
    Uh = {e: new() for e in range(1, (q + 1) // 2)}
    U = lambda e: Uh[min(e % q, (-e) % q)]
    cl = []
    for u in range(q):
        cl.append(G[u][:])
        for p in range(q):
            for r in range(p + 1, q):
                cl.append([-G[u][p], -G[u][r]])
    cl.append([G[0][0]])
    for a, b in AB:
        if b == 0:
            cl.append([U(a)])
            continue
        if b > q - b:                      # the opposite step gives the same clauses
            continue
        for u in range(q):
            for p in range(q):
                for r in range(q):
                    e = (a + r - p) % q
                    c = [-G[u][p], -G[(u + b) % q][r]]
                    if e:
                        c.append(U(e))
                    cl.append(c)
    if kind == "col":
        W = [[new() for _ in range(k)] for _ in range(q)]
        for t in range(q):
            cl.append(W[t][:])
        cl.append([W[0][0]])
        for e in Uh:
            for t in range(q):
                for c in range(k):
                    cl.append([-Uh[e], -W[t][c], -W[(t + e) % q][c]])
        aux = W
    else:
        M = [new() for _ in range(q)]
        cl.append([M[0]])
        for e in Uh:
            for t in range(q):
                cl.append([-Uh[e], -M[t], -M[(t + e) % q]])
        card = CardEnc.atleast(lits=M, bound=k, top_id=nv, encoding=EncType.seqcounter)
        nv = max(nv, card.nv)
        cl += card.clauses
        aux = M
    return S, G, aux, nv, cl


def run(q, v, w, kind, k, tmo=3000):
    S, G, aux, nv, cl = build(q, v, w, kind, k)
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False, dir=os.environ.get("SCRATCH", None)) as f:
        f.write(f"p cnf {nv} {len(cl)}\n")
        for c in cl:
            f.write(" ".join(map(str, c)) + " 0\n")
        path = f.name
    try:
        out = subprocess.run(["kissat", "-q", path], capture_output=True, text=True, timeout=tmo).stdout
    except subprocess.TimeoutExpired:
        os.unlink(path)
        return "TIMEOUT", None
    os.unlink(path)
    if "s UNSATISFIABLE" in out:
        return "UNSAT", None
    if "s SATISFIABLE" not in out:
        return "UNKNOWN", out[-300:]
    true = set()
    for line in out.splitlines():
        if line.startswith("v "):
            true.update(int(x) for x in line[2:].split() if int(x) > 0)
    g = [next(p for p in range(q) if G[u][p] in true) for u in range(q)]
    cell = lambda t, u: ((t * v[0] + u * w[0]) % q, (t * v[1] + u * w[1]) % q)
    if kind == "col":
        W = [next(c for c in range(k) if aux[t][c] in true) for t in range(q)]
        c = {cell(t, u): W[(t + g[u]) % q] for t in range(q) for u in range(q)}
        assert len(c) == q * q
        bad = sum(1 for (x, y), col in c.items() for a, b in S if c[((x + a) % q, (y + b) % q)] == col)
        return ("SAT" if bad == 0 else "BUG"), dict(g=g, W=W, clashes=bad, colours=len(set(W)))
    I = [t for t in range(q) if aux[t] in true]
    cs = {cell(t, u) for u in range(q) for t in range(q) if (t + g[u]) % q in I}
    bad = sum(1 for (x, y) in cs for a, b in S if ((x + a) % q, (y + b) % q) in cs)
    return ("SAT" if bad == 0 else "BUG"), dict(I=I, g=g, cells=len(cs), clashes=bad)


if __name__ == "__main__":
    q, kind, k = int(sys.argv[1]), sys.argv[2], int(sys.argv[3])
    v2 = next((1, m) for m in range(1, q) if not is_qr(1 + m * m, q))
    fams = [("clash-step", (1, 0)), ("no-clash", v2)]
    if len(sys.argv) > 4:
        fams = [f for f in fams if f[0] == sys.argv[4]]
    for name, v in fams:
        res, det = run(q, v, (0, 1), kind, k)
        print(f"q={q} {kind} k={k} [{name}, v={v}]: {res} {det if det else ''}", flush=True)
