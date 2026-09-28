#!/usr/bin/env python3
"""FS112-YB3: an exact check of Y3-R3 and of Y3-T2-BUDGET's strip clause on the two held positives (FS112-YB2's exact rebuilds of the
strip and the disk, imported, never edited).  For every close complementary pair of vertices (types disjoint, union all six, distance < 2):
  * its two common unit points w (the circles about u and v meet in two points);
  * at each w: is w a vertex, how many colours it carries, and does each of u, v EMIT a unit arc of omega(w) (a boundary arc of radius 1
    centred at w with u, resp. v, as an endpoint) -- "saved there by half of T2";
  * is the pair a RHOMBUS COMPLETION: v = w_i + w_j - u for two distinct centres w_i, w_j of unit arcs u emits (or u from v's).
Run: python3 tools/fs112_yb3_r3.py [strip|disk]
"""
from __future__ import annotations
import itertools
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K        # noqa: E402
import fs112_yb2_objects as O      # noqa: E402

vadd, vsub, vmul, n2, dot, veq = K.vadd, K.vsub, K.vmul, K.n2, K.dot, K.veq


def fp(p):
    return f"({float(p[0]):+.5f}, {float(p[1]):+.5f})"


def vertices(tiles):
    pts = []
    for nm, (c, ps) in tiles.items():
        for pc in ps:
            for X in pc.ends():
                if not any(veq(X, Y) for Y in pts):
                    pts.append(X)
    out = []
    for X in pts:
        cols = sorted({c for nm, (c, ps) in tiles.items() if any(pc.contains(X) for pc in ps)})
        out.append((X, cols))
    return out


def unit_arcs(tiles):
    arcs = []
    for nm, (c, ps) in tiles.items():
        for pc in ps:
            if pc.kind == "A" and pc.rho == pc.rho.T(1):
                arcs.append(pc)
    return arcs


def emitted_centres(u, arcs):
    cs = []
    for a in arcs:
        if veq(a.S, u) or veq(a.E, u):
            if not any(veq(a.C, c) for c in cs):
                cs.append(a.C)
    return cs


def analyse(tiles, allc, label, u_filter, rim_r2=None):
    vt = vertices(tiles)
    arcs = unit_arcs(tiles)
    inner = [(X, set(c)) for X, c in vt if (rim_r2 is None or n2(X) != rim_r2)]
    print(f"== {label}: {len(vt)} vertices, {len(arcs)} unit-arc pieces")
    n = 0
    for (u, cu), (v, cv) in itertools.combinations(inner, 2):
        if cu & cv or (cu | cv) != allc:
            continue
        if not (n2(vsub(u, v)) < 4):
            continue
        if not (u_filter(u) or u_filter(v)):
            continue
        n += 1
        # the common unit points: w = m +- h * perp(d)/|d|, with h^2 = 1 - |d|^2/4; found among vertices first
        ws = [X for X, c in vt if n2(vsub(X, u)) == 1 and n2(vsub(X, v)) == 1]
        if ws:
            w0 = ws[0]
            d = vsub(v, u)
            t = dot(vsub(w0, u), d) / n2(d)
            foot = vadd(u, vmul(t, d))
            w1 = vsub(vmul(2, foot), w0)
            wl = [w0, w1]
        else:
            wl = []
        cu_c, cv_c = emitted_centres(u, arcs), emitted_centres(v, arcs)
        comp = any(veq(vsub(vadd(a, b), u), v) for a, b in itertools.combinations(cu_c, 2)) or \
            any(veq(vsub(vadd(a, b), v), u) for a, b in itertools.combinations(cv_c, 2))
        print(f"-- {fp(u)} {sorted(cu)} | {fp(v)} {sorted(cv)}  |uv| ~ {math.sqrt(float(n2(vsub(u, v)))):.6f};"
              f" rhombus completion: {comp}")
        if not wl:
            print("     no common unit point at a vertex (not analysed further)")
            continue
        for w in wl:
            vc = [c for X, c in vt if veq(X, w)]
            eu = any(veq(c, w) for c in cu_c)
            ev = any(veq(c, w) for c in cv_c)
            where = ("vertex " + str(vc[0]) + f" ({len(vc[0])} colours)") if vc else "not a vertex"
            if rim_r2 is not None:
                where += "; " + ("ON THE RIM" if n2(w) == rim_r2 else ("inside" if n2(w) < rim_r2 else "OUTSIDE the disk"))
            saved = eu and ev and vc and len(vc[0]) == 4
            print(f"     w {fp(w)}: {where}; u emits an arc of omega(w): {eu}; v emits one: {ev}"
                  f" -> {'SAVED by half of T2' if saved else 'not saved by T2 here'}")
    print(f"   {n} close complementary pairs listed")


def run_strip():
    S = O.Strip()
    tiles = S.tiles(-6, 8)
    allc = {"P", "G", "B", "M", "R", "O"}
    Y = float(S.Y)
    # one period in x: [0, 3/2)
    analyse(tiles, allc, "the strip (YB2's rebuild; pairs with a member in one period x in [0, 3/2), edge vertices included)",
            lambda p: 0 <= float(p[0]) < 1.5 - 1e-9)


def run_disk():
    Dk = O.Disk()
    tiles = Dk.tiles()
    allc = {"red", "blue", "green", "yellow", "orange", "violet"}
    analyse(tiles, allc, "the disk (YB2's rebuild; interior vertices)", lambda p: True, rim_r2=Dk.r2)


if __name__ == "__main__":
    w = sys.argv[1:] or ["strip", "disk"]
    if "strip" in w:
        run_strip()
    if "disk" in w:
        run_disk()
