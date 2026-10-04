#!/usr/bin/env python3
"""SEARCH-2026-10-03 checker: certificates for the day's colouring questions, independent of the encoder.

The CHECK side of plans/SEARCH-2026-10-03.md. It imports nothing from tools/search_20261003_encode.py and rebuilds every graph from
its definition by a different route:
  gamma q / zmod n   all ordered pairs (u, v) of (Z/n)^2 tested directly: adjacent iff (u - v) has a^2 + b^2 = 1 (mod n)
                     (the encoder enumerates the unit circle once and translates it);
  uq m               F_{Q^2} = F_2[x]/(p) by shift-and-add multiplication, p's irreducibility checked by trial division; the
                     (Q+1)-st roots of unity found by exponentiating every element (the encoder uses a log table from a primitive
                     element); adjacent iff u XOR v is a root.

Subcommands:
  colouring CERT.json     ACCEPTED iff every vertex has a colour in range(k), every edge is bichromatic, and some vertex has at
                          least `gaps_claimed` colours absent from its closed neighbourhood (printed with the vertices that do).
                          Exit 0 accepted, 1 rejected, 2 refused (malformed).
  unsat META.json LRAT[.gz] [CNF]
                          regenerates the CNF from META's parameters by this file's own construction of the documented encoding
                          (the clause order is part of the documentation, so LRAT clause ids carry over), runs cake_lpr (the
                          CakeML-verified LRAT checker) on the REGENERATED CNF and the proof, and, if the encoder's CNF is given,
                          requires it byte-identical. ACCEPTED iff cake_lpr prints "s VERIFIED UNSAT" (and the bytes agree).
  cubes META.json CUBEDIR a cube-and-conquer refutation (tools/search_20261003_cubes.py): base CNF regenerated here, the cover
                          recomputed as all 2^s sign patterns on the manifest's variables, every cube proof checked by cake_lpr.
  plant CERT.json         the certificate's own negative controls: accepted at its claim, rejected one gap above it, and rejected
                          with vertex 0's colour copied onto a neighbour. Exit 0 iff all three fire as expected.
  controls                the held kernel tables accepted, and every planted fault watched failing (see controls()).
"""
import gzip
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAKE = os.path.expanduser("~/source/cake_lpr/cake_lpr")


# ---------------------------------------------------------------- graphs, rebuilt

def grid_adjacency(n):
    """Boolean N x N matrix of UD(Z/n, 2), every pair tested."""
    xs = np.repeat(np.arange(n), n)
    ys = np.tile(np.arange(n), n)
    a = (xs[:, None] - xs[None, :]) % n
    b = (ys[:, None] - ys[None, :]) % n
    return (a * a + b * b) % n == 1


def gf2_mul(a, b, p, deg):
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> deg & 1:
            a ^= p
    return r


def gf2_polymod(a, b):
    db = b.bit_length() - 1
    while a and a.bit_length() - 1 >= db:
        a ^= b << (a.bit_length() - 1 - db)
    return a


def irreducible(p):
    deg = p.bit_length() - 1
    for d in range(1, deg // 2 + 1):
        for f in range(1 << d, 1 << (d + 1)):
            if gf2_polymod(p, f) == 0:
                return False
    return True


def uq_adjacency(m, p):
    deg = 2 * m
    if p.bit_length() - 1 != deg or not irreducible(p):
        raise ValueError(f"REFUSED: poly {p:#x} is not an irreducible polynomial of degree {deg}")
    size = 1 << deg
    Q = 1 << m

    def power(z, e):
        r = 1
        for _ in range(e):
            r = gf2_mul(r, z, p, deg)
        return r

    roots = [z for z in range(1, size) if power(z, Q + 1) == 1]
    if len(roots) != Q + 1:
        raise ValueError(f"REFUSED: {len(roots)} roots of unity of order dividing {Q + 1}, expected {Q + 1}")
    isroot = np.zeros(size, dtype=bool)
    isroot[roots] = True
    idx = np.arange(size)
    return isroot[idx[:, None] ^ idx[None, :]]


def adjacency_for(cert):
    g = cert["graph"]
    if g in ("gamma", "zmod"):
        return grid_adjacency(int(cert["n"]))
    if g == "uq":
        return uq_adjacency(int(cert["m"]), int(cert["poly"]))
    raise ValueError(f"REFUSED: unknown graph {g!r}")


# ---------------------------------------------------------------- the colouring check

def check_colouring(A, col, k, gaps_claimed):
    """Returns (verdict, message). A is the adjacency matrix."""
    N = A.shape[0]
    if len(col) != N:
        return "REFUSED", f"colouring has {len(col)} entries for {N} vertices"
    c = np.asarray(col)
    if c.min() < 0 or c.max() >= k:
        return "REJECTED", f"a colour outside range({k})"
    if np.any(np.diag(A)):
        return "REFUSED", "a loop in the rebuilt graph"
    bad = np.argwhere(A & (c[:, None] == c[None, :]))
    if len(bad):
        u, v = bad[0]
        return "REJECTED", f"improper: vertices {u} and {v} adjacent, both colour {c[u]} ({len(bad) // 2} monochromatic edges)"
    closed = A | np.eye(N, dtype=bool)
    present = np.zeros((N, k), dtype=bool)
    for colour in range(k):
        present[:, colour] = (closed & (c[None, :] == colour)).any(axis=1)
    absent = k - present.sum(axis=1)
    best = int(absent.max())
    where = [int(v) for v in np.nonzero(absent >= gaps_claimed)[0]]
    stats = f"proper; degree {int(A[0].sum())}; colours used {len(set(col))}; max colours absent from a closed neighbourhood {best}; " \
            f"vertices with >= {gaps_claimed} absent: {len(where)} of {N}"
    if gaps_claimed == 0 or where:
        gapset = sorted(set(range(k)) - set(c[np.nonzero(closed[where[0]])[0]].tolist())) if where else []
        return "ACCEPTED", stats + (f"; e.g. vertex {where[0]}, absent colours {gapset}" if where else "")
    return "REJECTED", stats


def cmd_colouring(path):
    with open(path) as f:
        cert = json.load(f)
    try:
        A = adjacency_for(cert)
    except ValueError as e:
        print(str(e))
        return 2
    verdict, msg = check_colouring(A, cert["colouring"], int(cert["k"]), int(cert["gaps_claimed"]))
    print(f"{verdict}: {os.path.basename(path)}: {msg}")
    return {"ACCEPTED": 0, "REJECTED": 1}.get(verdict, 2)


# ---------------------------------------------------------------- the UNSAT check

def regenerate_cnf(meta):
    """The documented encoding (tools/search_20261003_encode.py's docstring), built from this file's adjacency."""
    A = adjacency_for(meta)
    N = A.shape[0]
    k, gaps, enc = int(meta["k"]), int(meta["gaps"]), meta["enc"]
    X = lambda v, c: v * k + c + 1
    cls = []
    for v in range(N):
        cls.append(tuple(X(v, c) for c in range(k)))
        cls += [(-X(v, c), -X(v, d)) for c in range(k) for d in range(c + 1, k)]
    for u, v in np.argwhere(np.triu(A, 1)):
        cls += [(-X(int(u), c), -X(int(v), c)) for c in range(k)]
    closed0 = [0] + [int(v) for v in np.nonzero(A[0])[0]]
    nv = N * k
    if enc == "plain" and gaps == 0:
        pass
    elif enc == "plain":
        Y = [nv + 1 + c for c in range(k)]
        nv += k
        cls += [(-Y[c], -X(u, c)) for c in range(k) for u in closed0]
        if gaps == 1:
            cls.append(tuple(Y))
        else:
            cls += [tuple(Y[d] for d in range(k) if d != c) for c in range(k)]
    elif enc == "sb":
        u0 = int(meta["u0"])
        if not A[0, u0]:
            raise ValueError("REFUSED: the pinned u0 is not a neighbour of 0")
        cls.append((X(0, 0),))
        cls.append((X(u0, 1),))
        top = list(range(k - gaps, k))
        cls += [(-X(u, c),) for c in top for u in closed0]
        for c in top[1:]:
            cls += [tuple([-X(v, c)] + [X(u, c - 1) for u in range(v)]) for v in range(N)]
    else:
        raise ValueError(f"REFUSED: unknown encoding {enc!r}")
    return nv, cls


def cnf_text(nv, cls):
    return f"p cnf {nv} {len(cls)}\n" + "".join(" ".join(map(str, cl)) + " 0\n" for cl in cls)


def cake(cnf, lrat):
    r = subprocess.run([CAKE, cnf, lrat], capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip().splitlines()
    return r.returncode, (out[-1] if out else "")


def cmd_unsat(meta_path, lrat, cnf=None):
    """Regenerate the documented CNF; if the encoder's CNF is given it must be byte-identical; cake_lpr runs on OUR CNF."""
    with open(meta_path) as f:
        meta = json.load(f)
    try:
        nv, cls = regenerate_cnf(meta)
    except ValueError as e:
        print(str(e))
        return 2
    text = cnf_text(nv, cls)
    work = tempfile.mkdtemp(prefix="unsat-", dir=os.path.dirname(os.path.abspath(lrat)))
    try:
        mine = os.path.join(work, "regenerated.cnf")
        with open(mine, "w") as f:
            f.write(text)
        if cnf is not None:
            with open(cnf) as f:
                theirs = f.read()
            if theirs != text:
                print(f"REJECTED: {os.path.basename(cnf)} is not byte-identical to the documented formula as regenerated here "
                      f"({len(theirs.splitlines()) - 1} clauses there, {len(cls)} here)")
                return 1
        proof = lrat
        if lrat.endswith(".gz"):
            proof = os.path.join(work, "proof.lrat")
            with gzip.open(lrat, "rb") as g, open(proof, "wb") as h:
                shutil.copyfileobj(g, h)
        rc, line = cake(mine, proof)
    finally:
        shutil.rmtree(work)
    if line != "s VERIFIED UNSAT":
        print(f"REJECTED: cake_lpr did not verify (rc {rc}): {line!r}")
        return 1
    same = "; the encoder's CNF is byte-identical" if cnf is not None else ""
    print(f"ACCEPTED: the documented formula for {os.path.basename(meta_path)} ({len(cls)} clauses, {nv} vars), regenerated here{same}; "
          f"cake_lpr says {line!r} on {os.path.basename(lrat)}")
    return 0


# ---------------------------------------------------------------- controls

def lean_table(relpath, name):
    src = open(os.path.join(ROOT, relpath)).read()
    i = src.index(f"def {name}")
    body = src[src.index(":=", i) + 2:]
    depth, j = 0, 0
    for j, ch in enumerate(body):
        if ch == "[":
            depth += 1
        elif ch == "]":
            depth -= 1
            if depth == 0:
                break
    lit = body[:j + 1].replace("!", "")
    return json.loads(lit)


def held_tables():
    t11 = lean_table("Proofs/HadwigerNelson/Instances/FinitePlane11.lean", "finitePlane11Table")
    t11d = lean_table("Proofs/HadwigerNelson/Instances/FanGap11.lean", "finitePlane11DoubleGapTable")
    c19 = lean_table("Proofs/HadwigerNelson/Instances/LocalGlobal19.lean", "circ19Table")
    c7 = lean_table("Proofs/HadwigerNelson/Instances/PlaneFreedom.lean", "circ7Table")
    flat = lambda T: [T[x][y] for x in range(len(T)) for y in range(len(T))]
    # projAlong (a, b) (x, y) = a*y - b*x  (Proofs/HadwigerNelson/LocalGlobal.lean)
    g19 = [c19[(y - x) % 19] for x in range(19) for y in range(19)]
    g7 = [c7[(y - 2 * x) % 7] for x in range(7) for y in range(7)]
    return {"finitePlane11Table": (11, 5, flat(t11)), "finitePlane11DoubleGapTable": (11, 5, flat(t11d)),
            "finitePlane19QuotColouring": (19, 5, g19), "circ7Table along projAlong (1, 2)": (7, 4, g7)}


def controls():
    fails = 0

    def expect(ok, what):
        nonlocal fails
        print(f"  [{'PASS' if ok else 'FAIL'}] {what}")
        fails += 0 if ok else 1

    print("controls: the held kernel tables against the rebuilt graphs")
    held = held_tables()
    for name, (q, k, col) in held.items():
        A = grid_adjacency(q)
        expect(int(A[0].sum()) == q + 1, f"Gamma_{q} rebuilt with degree q + 1 = {q + 1} (got {int(A[0].sum())})")
        v1, m1 = check_colouring(A, col, k, 1)
        expect(v1 == "ACCEPTED", f"{name}: proper with a single gap somewhere: {v1}: {m1}")
        v2, m2 = check_colouring(A, col, k, 2)
        expect(v2 == "REJECTED", f"{name}: no vertex with two gaps (the requests' premise): {v2}")
    q, k, col = held["circ7Table along projAlong (1, 2)"]
    A7 = grid_adjacency(7)
    c7 = np.asarray(col)
    absent = [k - len(set(c7[np.nonzero(A7[v] | (np.arange(49) == v))[0]].tolist())) for v in range(49)]
    expect(sum(1 for a in absent if a >= 1) == 14, f"circ7Table gapped at 14 of 49 vertices (brief; FS129-MA2-G7GAP): {sum(1 for a in absent if a >= 1)}")

    print("plants: each must fail")
    q, k, col = held["finitePlane11Table"]
    A11 = grid_adjacency(q)
    bad = list(col)
    nb = int(np.nonzero(A11[0])[0][0])
    bad[nb] = bad[0]
    v, m = check_colouring(A11, bad, k, 1)
    expect(v == "REJECTED" and "improper" in m, f"one entry of finitePlane11Table copied onto a neighbour: {v}: {m}")
    A11w = grid_adjacency(q).copy()
    xs = np.repeat(np.arange(q), q)
    ys = np.tile(np.arange(q), q)
    A11w = (((xs[:, None] - xs[None, :]) % q) ** 2 + ((ys[:, None] - ys[None, :]) % q) ** 2) % q == 2
    v, m = check_colouring(A11w, col, k, 1)
    expect(v == "REJECTED", f"the graph built at quadrance 2 instead of 1 (the held table must fail there): {v}")
    v, m = check_colouring(A11, col, 4, 1)
    expect(v == "REJECTED", f"the held five-colouring claimed as a four-colouring: {v}: {m}")
    try:
        uq_adjacency(2, 0b10101)   # x^4 + x^2 + 1 = (x^2 + x + 1)^2, reducible
        expect(False, "a reducible polynomial for F_16 refused")
    except ValueError as e:
        expect("REFUSED" in str(e), f"a reducible polynomial for F_16 refused: {e}")
    A4 = uq_adjacency(2, 0b10011)
    expect(int(A4[0].sum()) == 5 and int(A4.sum()) == 16 * 5, f"U_4 rebuilt: 16 vertices of degree 5 ({int(A4[0].sum())})")
    tri = int(np.trace(np.linalg.matrix_power(A4.astype(np.int64), 3)))
    expect(tri == 0, f"U_4 triangle-free (the Clebsch graph): trace(A^3) = {tri}")

    print("plants on the UNSAT path")
    import tempfile
    tmp = tempfile.mkdtemp(prefix="search20261003-", dir=os.environ.get("SEARCH_TMP", None))
    enc = os.path.join(ROOT, "tools", "search_20261003_encode.py")
    r = subprocess.run([sys.executable, enc, "gamma", "11", "--k", "4", "--gaps", "1", "--enc", "plain", "--out", tmp, "--timeout", "60"],
                       capture_output=True, text=True)
    expect("UNSATISFIABLE" in r.stdout, f"control instance Gamma_11 at four colours refused by the encoder's solve: {r.stdout.strip()}")
    meta = os.path.join(tmp, "gamma11-k4-g1-plain.meta.json")
    cnf = os.path.join(tmp, "gamma11-k4-g1-plain.cnf")
    lrat = os.path.join(tmp, "gamma11-k4-g1-plain.lrat")
    expect(cmd_unsat(meta, lrat, cnf) == 0, "the faithful pair: Gamma_11 at four colours, its CNF and LRAT accepted")
    lines = open(cnf).read().splitlines()
    drop = os.path.join(tmp, "drop.cnf")
    hdr = lines[0].split()
    edge_line = next(i for i, l in enumerate(lines) if i > 0 and len(l.split()) == 3 and l.split()[0].startswith("-"))
    with open(drop, "w") as f:
        f.write(f"p cnf {hdr[2]} {int(hdr[3]) - 1}\n" + "\n".join(l for i, l in enumerate(lines[1:], 1) if i != edge_line) + "\n")
    expect(cmd_unsat(meta, lrat, drop) == 1, "a CNF with one clause dropped: refused as not the documented formula")
    half = os.path.join(tmp, "half.lrat")
    pl = open(lrat).read().splitlines()
    with open(half, "w") as f:
        f.write("\n".join(pl[: len(pl) // 2]) + "\n")
    rc, line = cake(cnf, half)
    expect(line != "s VERIFIED UNSAT", f"the LRAT proof truncated to half: cake_lpr says {line!r}")
    r = subprocess.run([sys.executable, enc, "gamma", "7", "--k", "3", "--gaps", "1", "--enc", "plain", "--out", tmp, "--timeout", "60"],
                       capture_output=True, text=True)
    rc, line = cake(cnf, os.path.join(tmp, "gamma7-k3-g1-plain.lrat"))
    expect(line != "s VERIFIED UNSAT", f"another formula's proof (Gamma_7 at three colours) on Gamma_11's CNF: cake_lpr says {line!r}")
    gz = os.path.join(tmp, "proof.lrat.gz")
    with open(lrat, "rb") as f, gzip.open(gz, "wb") as g:
        g.write(f.read())
    expect(cmd_unsat(meta, gz) == 0, "the same proof gzipped, checked against the regenerated CNF alone")
    sbmeta = dict(json.load(open(meta)), enc="sb", u0=11)
    sbm = os.path.join(tmp, "sb.meta.json")
    json.dump(sbmeta, open(sbm, "w"))
    expect(cmd_unsat(sbm, lrat) == 1, "the plain encoding's proof against the sb meta (another formula): refused")
    print(f"CONTROLS: {'ALL PASS' if fails == 0 else f'{fails} FAILED'}")
    return 0 if fails == 0 else 1


def cmd_cubes(meta_path, cubedir):
    """A cube-and-conquer refutation: the documented base CNF regenerated here; the cover is every one of the 2^s sign patterns on the
    manifest's variables (recomputed here from the cube index, never read from the run's records); each cube's CNF (base + units,
    appended) rebuilt here and its proof checked by cake_lpr."""
    with open(meta_path) as f:
        meta = json.load(f)
    nv, cls = regenerate_cnf(meta)
    man = json.load(open(os.path.join(cubedir, "manifest.json")))
    vars_ = [int(v) for v in man["vars"]]
    if len(set(abs(v) for v in vars_)) != len(vars_) or not all(0 < v <= nv for v in vars_):
        print("REFUSED: cube variables repeated or out of range")
        return 2
    base_text = cnf_text(nv, cls)
    if os.path.exists(man["base"]) and open(man["base"]).read() != base_text:
        print("REJECTED: the run's base CNF is not byte-identical to the documented formula regenerated here")
        return 1
    n = 1 << len(vars_)
    have = {}
    for line in open(os.path.join(cubedir, "cubes.jsonl")):
        e = json.loads(line)
        if e.get("status") == "UNSAT-VERIFIED" and e.get("proof_gz"):
            have[int(e["cube"])] = e["proof_gz"]
    missing = [i for i in range(n) if i not in have]
    if missing:
        print(f"REJECTED: {len(missing)} of {n} cubes have no proof (first: {missing[:5]})")
        return 1
    body = "".join(" ".join(map(str, cl)) + " 0\n" for cl in cls)
    work = tempfile.mkdtemp(prefix="cubes-", dir=cubedir)
    bad = []
    try:
        for i in range(n):
            u = [v if (i >> j) & 1 else -v for j, v in enumerate(vars_)]
            cnf = os.path.join(work, "cube.cnf")
            with open(cnf, "w") as f:
                f.write(f"p cnf {nv} {len(cls) + len(u)}\n" + body + "".join(f"{l} 0\n" for l in u))
            proof = os.path.join(work, "cube.lrat")
            with gzip.open(os.path.join(cubedir, have[i]), "rb") as g, open(proof, "wb") as h:
                shutil.copyfileobj(g, h)
            rc, line = cake(cnf, proof)
            if line != "s VERIFIED UNSAT":
                bad.append((i, line))
    finally:
        shutil.rmtree(work)
    if bad:
        print(f"REJECTED: {len(bad)} cube proofs not verified, first {bad[0]}")
        return 1
    print(f"ACCEPTED: the documented formula for {os.path.basename(meta_path)} ({len(cls)} clauses, {nv} vars) regenerated here; "
          f"all {n} cubes over {len(vars_)} variables (every sign pattern) refuted, each proof 's VERIFIED UNSAT' by cake_lpr")
    return 0


def cmd_plant(path):
    """Per-certificate negative controls: the certificate as filed must be ACCEPTED at its claim and REJECTED one gap above it,
    and with the gapped vertex's colour copied onto one of its neighbours."""
    with open(path) as f:
        cert = json.load(f)
    A = adjacency_for(cert)
    k, g, col = int(cert["k"]), int(cert["gaps_claimed"]), list(cert["colouring"])
    v0, m0 = check_colouring(A, col, k, g)
    v1, m1 = check_colouring(A, col, k, g + 1)
    nb = int(np.nonzero(A[0])[0][0])
    bad = list(col)
    bad[nb] = bad[0]
    v2, m2 = check_colouring(A, bad, k, g)
    ok = v0 == "ACCEPTED" and v1 == "REJECTED" and v2 == "REJECTED" and "improper" in m2
    print(f"{'PLANTS FIRE' if ok else 'PLANTS DID NOT FIRE'}: {os.path.basename(path)}: as filed at {g} gap(s): {v0}; "
          f"claimed at {g + 1}: {v1}; vertex 0's colour copied onto neighbour {nb}: {v2} ({m2.split(';')[0]})")
    return 0 if ok else 1


if __name__ == "__main__":
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        sys.exit(2)
    if a[0] == "colouring" and len(a) == 2:
        sys.exit(cmd_colouring(a[1]))
    if a[0] == "unsat" and len(a) in (3, 4):
        sys.exit(cmd_unsat(a[1], a[2], a[3] if len(a) == 4 else None))
    if a[0] == "cubes" and len(a) == 3:
        sys.exit(cmd_cubes(a[1], a[2]))
    if a[0] == "plant" and len(a) == 2:
        sys.exit(cmd_plant(a[1]))
    if a[0] == "controls":
        sys.exit(controls())
    print(__doc__)
    sys.exit(2)
