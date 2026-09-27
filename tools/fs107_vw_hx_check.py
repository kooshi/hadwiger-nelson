"""FS107-VW: exact check of family HX members (hexagonal seven-colouring, colour 0 blank, each colour-0 hexagon's six
centre-to-edge triangles given to the neighbour across the edge, a void disc of radius rho at its centre), built from
HX-STALL's statement alone (job FS107-VW, 2026-09-27).  Independent of FS107-W's tools.

Every same-colour pair of pieces (hexagon H_m, triangle-minus-disc Q_m, and their translates by the colour lattice L7)
must have exact distance range [min, max] with max <= 1 - eps or min >= 1 + eps (the null band condition).  Arithmetic
is exact in Q(sqrt 3) for rational R, rho, eps.

Usage: python3 tools/fs107_vw_hx_check.py            # members, planted faults and faithful stubs; exit 0 iff all as expected
"""
import math
import sys
from fractions import Fraction as F

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs107_vw_q3geom import (Q3, S3, u30, add, scale, n2, cross, Poly, TriDisc, piece_min_cands,  # noqa: E402
                             piece_max_cands)

NB = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]  # lattice coords of the six neighbours, m = 0..5


def colour(x, y):
    return (x - 2 * y) % 7


def build(R, rho, variant="hx"):
    R = F(R)
    a = (S3 * R, Q3(0))
    b = (S3 * R * F(1, 2), Q3(F(3, 2) * R))
    O = (Q3(0), Q3(0))
    comps = {k: [] for k in range(7)}
    for m, (x, y) in enumerate(NB):
        c = add(scale(Q3(x), a), scale(Q3(y), b))
        H = Poly([add(c, scale(Q3(R), u30(1 + 2 * i))) for i in range(6)], f"H{m}")
        comps[colour(x, y)].append(H)
        if variant == "hex7blank":
            continue
        B1, B2 = scale(Q3(R), u30(2 * m - 1)), scale(Q3(R), u30(2 * m + 1))
        if variant == "plant-novoid":
            T = Poly([O, B1, B2], f"T{m}")
        else:
            T = TriDisc(O, B1, B2, rho, R, f"Q{m}")
        target = colour(*NB[(m + 1) % 6]) if variant == "plant-swap" else colour(x, y)
        comps[target].append(T)
    w1 = add(scale(Q3(2), a), b)
    w2 = add(scale(Q3(-1), a), scale(Q3(3), b))
    return comps, w1, w2, a, b


def check(R, rho, eps, variant="hx", colours=range(1, 7), verbose=False):
    R, rho, eps = F(R), F(rho), F(eps)
    comps, w1, w2, a, b = build(R, rho, variant)
    lo_t, hi_t = Q3(1 - eps), Q3(1 + eps)
    reach = 2 * math.sqrt(7) * float(R) + 1 + float(eps) + 0.05
    shifts = []
    for p in range(-5, 6):
        for q in range(-5, 6):
            w = add(scale(Q3(p), w1), scale(Q3(q), w2))
            if math.sqrt(float(n2(w))) <= reach:
                shifts.append(((p, q), w))
    viol, undecided, margins = [], [], []
    for k in colours:
        C = comps[k]
        for (pq, w) in shifts:
            for i, X in enumerate(C):
                for j, Y in enumerate(C):
                    if pq == (0, 0) and j < i:
                        continue
                    Yw = Y.shift(w)
                    mx = piece_max_cands(X, Yw)
                    mn, exact = piece_min_cands(X, Yw)
                    ok_max = all(c.le(lo_t) for c in mx)
                    ok_min = all(c.ge(hi_t) for c in mn)
                    fmax, fmin = max(float(c) for c in mx), min(float(c) for c in mn)
                    lab = (k, X.name, Y.name, pq)
                    if ok_max:
                        margins.append(((1 - float(eps)) - fmax, "max", lab, fmax))
                    elif ok_min:
                        margins.append((fmin - (1 + float(eps)), "min", lab, fmin))
                    elif not exact and fmax > float(lo_t):
                        undecided.append((lab, fmin, fmax))
                    else:
                        viol.append((lab, fmin, fmax))
    det = cross(w1, w2)
    hexarea = Q3(0, F(3, 2)) * R * R
    assert det == 7 * hexarea, "period area must be 7 hexagons"
    void = 0 if variant in ("plant-novoid",) else (math.pi * float(rho) ** 2 if variant != "hex7blank" else None)
    delta = (1 / 7) if variant == "hex7blank" else void / float(det)
    margins.sort(key=lambda t: t[0])
    return {"viol": viol, "undecided": undecided, "tight": margins[:4], "delta": delta}


def thresholds(R, eps):
    R, e = float(R), float(eps)
    r1 = 2 * R - math.sqrt((1 - e) ** 2 - 3 * R * R)
    r2 = math.sqrt((1 + e) ** 2 - 3 * R * R) - R
    return r1, r2


def main():
    ok = True
    print("== known positive: hexagonal 7-colouring, colour 0 blank ==")
    for (R, eps, expect) in ((F(11, 25), F(1, 50), True), (F(51, 100), F(1, 50), False), (F(37, 100), F(1, 50), False)):
        r = check(R, 0, eps, "hex7blank")
        good = (not r["viol"]) == expect and not r["undecided"]
        ok &= good
        print(f"  R={R} eps={eps}: viol={len(r['viol'])} expect_pass={expect} -> {'as expected' if good else 'UNEXPECTED'};"
              f" delta={r['delta']:.6f}; tightest={[(round(t[0], 6), t[1], t[2]) for t in r['tight'][:2]]}")
    print("== HX members (faithful: rho just above max(r1, r2)) and planted (rho just below) ==")
    members = [(F(4365, 10000), F(1, 100)), (F(45, 100), F(1, 100)), (F(42, 100), F(1, 100)), (F(4364, 10000), F(1, 1000))]
    for (R, eps) in members:
        r1, r2 = thresholds(R, eps)
        th = max(r1, r2)
        named = "pair1 (diameter)" if r1 >= r2 else "pair2 (norm-3 hexagon)"
        rho_ok = F(math.ceil(th * 10000) + 1, 10000)
        rho_bad = F(math.floor(th * 10000) - 1, 10000)
        rf = check(R, rho_ok, eps)
        rb = check(R, rho_bad, eps)
        good_f = not rf["viol"] and not rf["undecided"]
        # the planted member must fail, and at the named pair: for pair1 the violation is a self-pair (0,0) max,
        # for pair2 a Q vs translated H at min
        if r1 >= r2:
            fired = any(v[0][3] == (0, 0) for v in rb["viol"])
        else:
            fired = any(v[0][1].startswith("Q") and v[0][2].startswith("H") and v[0][3] != (0, 0) for v in rb["viol"])
        good_b = bool(rb["viol"]) and fired
        ok &= good_f and good_b
        print(f"  R={R} eps={eps} r1={r1:.6f} r2={r2:.6f} binding={named}")
        print(f"    faithful rho={rho_ok}: viol={len(rf['viol'])} undecided={len(rf['undecided'])} delta={rf['delta']:.6f}"
              f" tightest={[(round(t[0], 7), t[1], t[2]) for t in rf['tight'][:3]]} -> {'PASS' if good_f else 'UNEXPECTED'}")
        print(f"    planted rho={rho_bad}: viol={len(rb['viol'])} first={rb['viol'][:2]} fired-at-named-pair={fired}"
              f" -> {'FIRES' if good_b else 'UNEXPECTED'}")
    print("== planted geometry faults on a faithful member ==")
    R, eps = F(4365, 10000), F(1, 100)
    r1, r2 = thresholds(R, eps)
    rho = F(math.ceil(max(r1, r2) * 10000) + 1, 10000)
    for variant in ("plant-swap", "plant-novoid"):
        r = check(R, rho, eps, variant)
        good = bool(r["viol"])
        ok &= good
        print(f"  {variant}: viol={len(r['viol'])} first={r['viol'][:1]} -> {'FIRES' if good else 'UNEXPECTED'}")
    print("ALL AS EXPECTED" if ok else "SOME CHECK UNEXPECTED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
