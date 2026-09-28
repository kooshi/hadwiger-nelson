#!/usr/bin/env python3
"""FS112-Y3 stage 3: card R's R2 -- a finite segment of a stuck chain whose end carries a horn bound of exactly 1, by formula, checked exactly.

The chain (C-CHAIN-8's structure at P_k = (0, k), normal n = (0, 1), a = (1, 0)); the end E = P_2, the end's unit-arc centre N = P_3 = (0, 3).
C-CHAIN-9's recursion taken with equality from the end: upper horn curvatures u_k = 1/(3 - k) (arcs of the circles centred N, radius 3 - k:
radius 1 at E -- the unit arc on omega(N)); lower curvatures l_k = f(l_{k+1}) = 0 (the lines y = k).  Colours a_k = (k mod 4) + 1:
at P_k the horns are a_k, the side above is a_{k-1}, the side below a_{k+1}.  The chain lives in the downward cone from N bounded by the rays
N + s(+-32/257, -255/257) (half-angle delta = 2 atan(1/16), about 7.1 degrees); every horn ends on the ray, so every point is rational: the
whole object lies in Q and the checker runs over the rational field.  The unit arcs' far ends V_2, V_2' are closed by colour-5 triangles
outside the cone (arc-closed, C-ARC-END); the ends of the radius-2 and radius-3 arcs are left open (not unit arcs).

Two completions of N's neighbourhood (sections `a` and `b`):
  a  -- the least one: colour 1 below N (a box), colour 3 on top in the directions [45, 135] (inside the pinch [delta, 180 - delta] E's unit
        arcs impose), colour 4 in the two wedges [0, 45], [135, 180] (tangent to a at N, so E's horns are shadowed from above).  P_cl(N) =
        {1, 3, 4}, colour 4 in two sectors.
  b  -- colour 4 made a double horn at N (lower boundary y = 3, upper the circle centred (0, 6) radius 3, curvature 1/3), with the upper flanks
        5 (right) and 6 (left) between the horns and colour 3's cone, colour 1 below; and a colour-4 tile at N + n = (0, 4) above the circle
        centred (0, 6) radius 2 (concentric: the recursion's equality again), an out-type contact that makes D_4(N) the line.  P_cl(N) =
        {1, 3, 4, 5, 6}.
Each: the exact check of every same-colour pair (tile with itself included), pairs examined printed against pairs present; exact contact facts;
free colours at named points (the MERGE and SHAVE readings); a float partition guard.
Plants (--plant): 'wide3' (a: colour 3's cone widened to [5, 175] degrees, below the pinch: registered REJECT at (H2+, T3) and (H2-, T3));
'top4low' (b: the colour-4 tile at N + n lowered onto the line y = 4 instead of the concentric arc: registered REJECT at the pairs (Top4, HN+),
(Top4, HN-)); 'fatG1' (a: the tile above P_1 swallows its horns down to the line y = 1, leaving B(N, 2): registered REJECT at (G1, H0+), (G1, H0-)).
In (b) the unit arcs' far ends are left open: every colour but 2 is at N there, so the tile that crosses omega(N) beyond an arc's end must be
colour 2, whose room is set by H1's concentric arc (record §3).
Run: python3 tools/fs112_y3_chainend.py [a] [b] [--plant NAME]
"""
from __future__ import annotations
import sys, os, math
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402  (FS112-Y's checker: run, never edited)
import fs112_y2_disk as DK         # noqa: E402  (point straddle test: run, never edited)

OK = True
PLANT = None
F = Y.Field([])                    # the rational field
COLS = [1, 2, 3, 4, 5, 6]


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


def P(x, y):
    return (F(Fr(x)), F(Fr(y)))


def mx(p):
    return (-p[0], p[1])


def mprim(p):
    if isinstance(p, Y.Seg):
        return Y.Seg(mx(p.Q), mx(p.P))
    return Y.Arc(mx(p.C), p.r, mx(p.E), mx(p.S))


def circ(C, R, t, up=False):
    """the rational point of the circle centred C, radius R, at angle 270 + 2 atan(t) (up=False) or 90 - 2 atan(t) (up=True)."""
    t = Fr(t)
    c, s = (1 - t * t) / (1 + t * t), 2 * t / (1 + t * t)
    return (C[0] + F(R * s), C[1] + F(-R * c if not up else R * c))


N = P(0, 3)
E = P(0, 2)
U = (Fr(32, 257), Fr(-255, 257))            # the cone's right ray direction from N (unit: 32^2 + 255^2 = 257^2)
DELTA_T = Fr(1, 16)
COL = {k: (k % 4) + 1 for k in range(-2, 6)}


def ray_at(y):
    """the point of the right ray at height y."""
    s = (3 - Fr(y)) * Fr(257, 255)
    return P(s * U[0], y)


def chain(plant=None, closure=True):
    T = {}
    for k in (0, 1, 2):
        R = 3 - k
        Pk = P(0, k)
        Vk = circ(N, R, DELTA_T)
        Ak = ray_at(k)
        Bk = ray_at(Fr(2 * k + 1, 2))
        assert Y.n2(Y.sub(Vk, N)) == R * R and Y.cross((F(U[0]), F(U[1])), Y.sub(Vk, N)) == 0
        horn = [Y.Seg(Pk, Ak), Y.Seg(Ak, Vk), Y.Arc(N, F(R), Pk, Vk)]
        T[f"H{k}+"] = (COL[k], horn)
        T[f"H{k}-"] = (COL[k], [mprim(p) for p in horn])
        top = Bk
        G = [Y.Arc(N, F(R), Pk, Vk), Y.Seg(Vk, top), Y.Seg(top, mx(top)), Y.Seg(mx(top), mx(Vk)), Y.Arc(N, F(R), mx(Vk), Pk)]
        if plant == "fatG1" and k == 1:      # the tile above P_1 swallows its horns down to the line y = 1 (leaves B(N, 2))
            G = [Y.Seg(mx(Ak), Ak), Y.Seg(Ak, top), Y.Seg(top, mx(top)), Y.Seg(mx(top), mx(Ak))]
        T[f"G{k}"] = (COL[k - 1], G)
    for k in (-1, 0, 1):
        Bk = ray_at(Fr(2 * k + 1, 2))
        A1 = ray_at(k + 1)
        T[f"U{k}"] = (COL[k + 2], [Y.Seg(mx(Bk), Bk), Y.Seg(Bk, A1), Y.Seg(A1, mx(A1)), Y.Seg(mx(A1), mx(Bk))])
    # colour 1 below N: a box [-1/4, 1/4] x [5/2, 3]
    a, b, c, d = P(Fr(-1, 4), Fr(5, 2)), P(Fr(1, 4), Fr(5, 2)), P(Fr(1, 4), 3), P(Fr(-1, 4), 3)
    T["U2"] = (COL[4], [Y.Seg(a, b), Y.Seg(b, c), Y.Seg(c, N), Y.Seg(N, d), Y.Seg(d, a)])
    # the unit arcs' far ends closed outside the cone by colour 5
    V2 = circ(N, 1, DELTA_T)
    up_, dn_ = Y.add(N, (F(U[0] * Fr(9, 10)), F(U[1] * Fr(9, 10)))), Y.add(N, (F(U[0] * Fr(11, 10)), F(U[1] * Fr(11, 10))))
    rt = Y.add(V2, P(Fr(1, 10), 0))
    S = [Y.Seg(dn_, rt), Y.Seg(rt, up_), Y.Seg(up_, dn_)]
    if closure:
        T["S_R"] = (5, S)
        T["S_L"] = (5, [mprim(p) for p in S])
    return T, V2


def top_a(T, plant=None):
    q1, q2, q3 = P(Fr(1, 4), 3), P(Fr(1, 4), Fr(13, 4)), P(Fr(-1, 4), Fr(13, 4))
    if plant == "wide3":
        # colour 3 from direction ~5.7 degrees (slope 1/10) to ~174.3: below the pinch delta ~ 7.1
        q2, q3 = P(Fr(1, 4), 3 + Fr(1, 40)), P(Fr(-1, 4), 3 + Fr(1, 40))
        T["T3"] = (3, [Y.Seg(N, q2), Y.Seg(q2, P(Fr(1, 4), Fr(13, 4))), Y.Seg(P(Fr(1, 4), Fr(13, 4)), P(Fr(-1, 4), Fr(13, 4))),
                       Y.Seg(P(Fr(-1, 4), Fr(13, 4)), q3), Y.Seg(q3, N)])
        T["W4R"] = (4, [Y.Seg(N, q1), Y.Seg(q1, q2), Y.Seg(q2, N)])
        T["W4L"] = (4, [mprim(p) for p in T["W4R"][1]])
        return T
    T["W4R"] = (4, [Y.Seg(N, q1), Y.Seg(q1, q2), Y.Seg(q2, N)])
    T["W4L"] = (4, [mprim(p) for p in T["W4R"][1]])
    T["T3"] = (3, [Y.Seg(N, q2), Y.Seg(q2, q3), Y.Seg(q3, N)])
    return T


def top_b(T, plant=None):
    C6 = P(0, 6)
    Vn = circ(C6, 3, Fr(1, 24))                          # the upper arc of the 4-horn at N: circle centred (0, 6), radius 3
    xv = Vn[0]
    foot = (xv, F(3))
    horn = [Y.Seg(N, foot), Y.Seg(foot, Vn), Y.Arc(C6, F(3), N, Vn)]
    T["HN+"] = (4, horn)
    T["HN-"] = (4, [mprim(p) for p in horn])
    q1, q2 = P(Fr(1, 4), 3), P(Fr(1, 4), Fr(13, 4))
    F5 = [Y.Arc(C6, F(3), N, Vn), Y.Seg(Vn, foot), Y.Seg(foot, q1), Y.Seg(q1, q2), Y.Seg(q2, N)]
    T["F5"] = (5, F5)
    T["F6"] = (6, [mprim(p) for p in F5])
    T["T3"] = (3, [Y.Seg(N, q2), Y.Seg(q2, mx(q2)), Y.Seg(mx(q2), N)])
    # the colour-4 tile at N + n = (0, 4): above the circle centred (0, 6) radius 2 (concentric with the horn's upper arc)
    top = P(0, 4)
    if plant == "top4low":
        w1, w2 = P(Fr(1, 10), 4), P(Fr(1, 10), Fr(41, 10))
        T["Top4"] = (4, [Y.Seg(mx(w1), w1), Y.Seg(w1, w2), Y.Seg(w2, mx(w2)), Y.Seg(mx(w2), mx(w1))])
    else:
        Wt = circ(C6, 2, Fr(1, 40))
        cap = Fr(41, 10)
        assert Wt[1] < cap
        T["Top4"] = (4, [Y.Arc(C6, F(2), top, Wt), Y.Seg(Wt, (Wt[0], F(cap))), Y.Seg((Wt[0], F(cap)), (-Wt[0], F(cap))),
                         Y.Seg((-Wt[0], F(cap)), mx(Wt)), Y.Arc(C6, F(2), mx(Wt), top)])
    return T


def free_at(T, z, skip=()):
    out = []
    for c in COLS:
        if not any(DK.straddles(z, prims) for nm, (cc, prims) in T.items() if cc == c and nm not in skip):
            out.append(c)
    return out


def run_check(T, lab):
    pairs = Y.all_pairs(T)
    counts = {}
    for nm, (c, _) in T.items():
        counts[c] = counts.get(c, 0) + 1
    present = sum(n * (n + 1) // 2 for n in counts.values())
    v, bad, n = Y.check_pairs(T, pairs)
    print(f"   [{lab}] tiles {len(T)}; same-colour pairs examined {n} of {present} present; VERDICT {v}; REJECT {bad}", flush=True)
    return v, bad, n, present, pairs


def guard(T, box):
    used, over, hole = Y.partition(T, box, n=60, margin=2e-3)
    return used, over, hole


def section_a():
    print(f"== (a) the chain's end, N completed by colours 1 (below), 3 (top), 4 (two wedges){'  [PLANT ' + PLANT + ']' if PLANT else ''}")
    T, V2 = chain(PLANT)
    T = top_a(T, PLANT)
    v, bad, n, present, pairs = run_check(T, "a")
    if PLANT == "wide3":
        say(set(bad) == {("H2+", "T3"), ("H2-", "T3")}, "plant wide3: REJECT exactly at (H2+, T3), (H2-, T3) -- colour 3 inside the pinch")
        return
    if PLANT == "fatG1":
        say(set(bad) == {("G1", "H0+"), ("G1", "H0-")}, "plant fatG1: REJECT exactly at (G1, H0+), (G1, H0-)")
        return
    say(v == "ACCEPT" and n == present, f"(a) ACCEPT on {n}/{present} pairs")
    Y.PLANT = "closed_interval"
    v2, bad2, _ = Y.check_pairs(T, pairs)
    Y.PLANT = None
    print(f"   closed_interval: exact contacts at 1: {[p for p in bad2 if p[0] != p[1]]}; self pairs of diameter exactly 1: {[p for p in bad2 if p[0] == p[1]]}")
    facts(T, V2, "a")
    # MERGE at N (colour 4): points of T3 near N, T3 ignored -- is 4 free there?
    z = [P(Fr(1, 100), 3 + Fr(3, 100)), P(0, 3 + Fr(1, 50)), P(Fr(-1, 100), 3 + Fr(3, 100))]
    fr = [free_at(T, q, skip=("T3",)) for q in z]
    print(f"   free colours at points of T3 near N (T3 ignored): {fr}")
    say(all(4 in f for f in fr), "(a) colour 4 is free across colour 3's sector at N: the two 4-sectors can be joined (MERGE at N: D_4(N) has interior)")
    used, over, hole = guard(T, (-0.3, 0.3, -0.45, 3.2))
    print(f"   float partition guard on [-0.3, 0.3] x [-0.45, 3.2] (outside the cone and the box counts as a hole): {used} samples, {over} overlaps")
    say(over == 0, "(a) no overlaps (float guard)")


def facts(T, V2, lab):
    d2 = lambda p, q: Y.n2(Y.sub(p, q))
    pN = Y.closure_type(T, N)
    pE = Y.closure_type(T, E)
    print(f"   P_cl(E) = {sorted(pE)}; P_cl(N) = {sorted(pN)}; P_cl(P_1) = {sorted(Y.closure_type(T, P(0, 1)))}; P_cl(V_2) = {sorted(Y.closure_type(T, V2))}")
    say(pE == {2, 3, 4}, f"({lab}) E carries the chain's three colours {{2, 3, 4}}: a_1 above, a_2 in the horns, a_3 below")
    if lab == "a":
        say(d2(V2, N) == 1 and 5 in Y.closure_type(T, V2), f"({lab}) the unit arcs of omega(N) end at V_2 = {tuple(round(c.f(), 6) for c in V2)} "
                                                            "in a fully coloured neighbourhood (colours 2, 3, 5 meet there): arc-closed")
    # E's horns: shadowed from above by colour 4 at N and from below by colour 2 (H1): at points of H2+, colours 2 and 4 straddle
    pts = [P(Fr(1, 20), 2 + Fr(1, 1000)), P(Fr(1, 10), 2 + Fr(1, 400))]
    for q in pts:
        inside = Y.n2(Y.sub(q, N)) > 1
        fr = free_at(T, q, skip=("H2+",))
        print(f"   point {tuple(round(c.f(), 5) for c in q)} of the horn H2+ (outside B(N,1): {inside}): free colours with H2+ ignored: {fr}")
        say(inside and 2 not in fr and 4 not in fr, f"({lab}) the horn tip at E is shadowed by both flank colours (2 from H1 below, 4 from N above): "
                                                    "no SHAVE at E")
    # D_3(E): colour 3 touches omega(E) at N (T3) and at P_1 (U0), both from outside
    t3 = [c for (c, prims) in [T["T3"]]]
    mnT3 = min(abs(math.sqrt(max(A.f(), 0)) + B.f()) for (A, B) in DK.point_range(E, T["T3"][1]))
    mnU0 = min(abs(math.sqrt(max(A.f(), 0)) + B.f()) for (A, B) in DK.point_range(E, T["U0"][1]))
    say(abs(mnT3 - 1) < 1e-12 and abs(mnU0 - 1) < 1e-12 and not DK.straddles(E, T["T3"][1]) and not DK.straddles(E, T["U0"][1]),
        f"({lab}) colour 3 touches omega(E) from outside at N (T3) and at P_1 (U0) and nowhere enters B(E,1): D_3(E) is the line, no MERGE at E")


def section_b():
    print(f"== (b) the chain's end, N completed as a five-colour vertex{'  [PLANT ' + PLANT + ']' if PLANT else ''}")
    T, V2 = chain(closure=False)
    T = top_b(T, PLANT)
    v, bad, n, present, pairs = run_check(T, "b")
    if PLANT == "top4low":
        say(set(bad) == {("HN+", "Top4"), ("HN-", "Top4")}, "plant top4low: REJECT exactly at (HN+, Top4), (HN-, Top4)")
        return
    say(v == "ACCEPT" and n == present, f"(b) ACCEPT on {n}/{present} pairs")
    Y.PLANT = "closed_interval"
    v2, bad2, _ = Y.check_pairs(T, pairs)
    Y.PLANT = None
    print(f"   closed_interval: exact contacts at 1: {[p for p in bad2 if p[0] != p[1]]}")
    pN = Y.closure_type(T, N)
    say(pN == {1, 3, 4, 5, 6}, f"(b) P_cl(N) = {sorted(pN)}: five colours")
    # facts at E (as in a) with the 4-horns at N playing the wedges' part
    T["T3"] = T["T3"]
    facts(T, V2, "b")
    # D_4(N): out-type contacts at E (U1 below E) and at (0, 4) (Top4): both touch omega(N), neither enters B(N, 1)
    ok = True
    for nm, w in (("U1", E), ("Top4", P(0, 4))):
        mn = min(abs(math.sqrt(max(A.f(), 0)) + B.f()) for (A, B) in DK.point_range(N, T[nm][1]))
        ok &= abs(mn - 1) < 1e-12 and not DK.straddles(N, T[nm][1]) and 4 in Y.closure_type({nm: T[nm]}, w)
    say(ok, "(b) colour 4 touches omega(N) from outside at E (U1) and at (0, 4) (Top4): D_4(N) is the line +-a, no MERGE of the 4-horns at N")
    # SHAVE at N: points of the horn HN+ near N, HN+ ignored -- the lower flank colour 1 is free there (the upper flank 5 casts no shadow)
    pts = [P(Fr(1, 20), 3 + Fr(1, 10000)), P(Fr(1, 10), 3 + Fr(1, 2000))]
    for q in pts:
        fr = free_at(T, q, skip=("HN+",))
        print(f"   point {tuple(round(c.f(), 5) for c in q)} of the 4-horn at N: free colours with HN+ ignored: {fr}")
        say(1 in fr and 5 in fr, "(b) the 4-horn's tip at N is free for its lower flank 1 (and its upper flank 5): SHAVE at N is available")
    used, over, hole = guard(T, (-0.3, 0.3, 2.4, 3.26))
    say(over == 0, f"(b) float partition guard near N: {used} samples, {over} overlaps")


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
        args = [a for a in args if a != PLANT]
    for s in (args or ["a", "b"]):
        {"a": section_a, "b": section_b}[s]()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
