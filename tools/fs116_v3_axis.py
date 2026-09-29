#!/usr/bin/env python3
"""FS116-V3: FS116-N1-AXIS's four clauses read on two objects given by formula (no search).

  strip — [AxenovichEtAl2014] Thm 4.2's strip as rebuilt in plans/FS112-Y-construction.md § 1.3 (arches A_j, B_j of width 1/2 on the
          midline, top-row C_j, bottom-row D_j; colours A 1,2,3 / B 4,5,6 / C 5,6,4 / D 2,3,1 by j mod 3), valid on B(P_1, 1.834)
          about its midline vertex P_1 = (1/2, 0), a degree-4 vertex of four colours {1, 2, 4, 5} whose edges are the four half-axes;
          tight, NOT saturated on its midline (FS111-VM2-STRIP-MID) — AXIS's hypotheses less saturation.
  sq9   — the square nine-colouring of side 1/2 (the square [i/2, (i+1)/2] x [j/2, (j+1)/2] coloured (i mod 3, j mod 3)), about the
          grid vertex p = (0, 0); k = 9, saturated (the claim list's § 4 and § 9).
At q_N = p + (0, 1) the tool reads, by evaluating the object's colour function at points at distance 1e-5 from the named point:
  (a) the colours along directions 181..359 deg (every degree) against p's colours;
  (b) the colours along 0.5 deg and 179.5 deg against c_IV, c_III (and whether those tiles lie above y = 1 there);
  (c) whether the germs just ccw of r(30) and just cw of r(150) lie in a tile interior (so on no arc of Gamma at all);
  (d) the germs just cw of r(30), just ccw of r(150); the number of colours along 181..359; the ring colours just either side of q_N.
The printed clause verdicts are those of the object, not of the statement: the strip lacks saturation; sq9 has k = 9.
--plant: the strip's top-row colours C are read as the B row's (a planted fault in the object); its summary line must change.
"""
import math
import sys

R3 = math.sqrt(3)
H2 = R3 / 2 + math.sqrt(15) / 4
EPS = 1e-5


def strip_colour(x, y, plant=False):
    A = [1, 2, 3]
    B = [4, 5, 6]
    C = [4, 5, 6] if plant else [5, 6, 4]
    D = [2, 3, 1]
    up = y > 0
    yy = abs(y)
    j = math.floor(x / 0.5)
    xj, xj1 = j * 0.5, (j + 1) * 0.5
    in_arch = yy > 0 and math.hypot(x - xj, yy) < 1 and math.hypot(x - xj1, yy) < 1
    if in_arch:
        return (A if up else B)[j % 3]
    if yy >= H2:
        return None
    jc = round(x / 0.5)
    return (C if up else D)[jc % 3]


def sq9_colour(x, y, plant=False):
    i, j = math.floor(x / 0.5), math.floor(y / 0.5)
    return (i % 3, j % 3)


def read(obj, plant):
    f = strip_colour if obj == "strip" else sq9_colour
    p = (0.5, 0.0) if obj == "strip" else (0.0, 0.0)
    col = lambda pt: f(pt[0], pt[1], plant)
    at = lambda base, deg, r=EPS: (base[0] + r * math.cos(math.radians(deg)), base[1] + r * math.sin(math.radians(deg)))
    quad = {q: col(at(p, d)) for q, d in (("I", 45), ("II", 135), ("III", 225), ("IV", 315))}
    pcols = set(quad.values())
    qN = (p[0], p[1] + 1)
    below = {col(at(qN, d)) for d in range(181, 360)}
    a_ok = not (below & pcols)
    b_right, b_left = col(at(qN, 0.5)), col(at(qN, 179.5))
    b_ok = b_right == quad["IV"] and b_left == quad["III"]
    ring = lambda deg: (p[0] + math.cos(math.radians(deg)), p[1] + math.sin(math.radians(deg)))
    t = 1e-4
    def interior(pt):   # the colour is constant on a small circle about pt: pt is off Gamma
        c0 = col(pt)
        return all(col(at(pt, d, 1e-7)) == c0 for d in range(0, 360, 15))
    germ = {"ccw 30": ring(30 + t), "cw 150": ring(150 - t), "cw 30": ring(30 - t), "ccw 150": ring(150 + t)}
    germ_int = {g: interior(pt) for g, pt in germ.items()}
    c_ok = germ_int["ccw 30"] and germ_int["cw 150"]
    d_hyp = germ_int["cw 30"] and germ_int["ccw 150"]
    ringL, ringR = col(ring(90 + t)), col(ring(90 - t))
    d_ok = len(below) == 1 and ringL == ringR
    print(f"{obj}: p's colours {sorted(map(str, pcols))}; below q_N {sorted(map(str, below))}; along 0.5 deg {b_right}, along 179.5 deg {b_left}; "
          f"ring either side of q_N {ringL}, {ringR}")
    print(f"{obj}: germs off Gamma: ccw 30 {germ_int['ccw 30']}, cw 150 {germ_int['cw 150']}, cw 30 {germ_int['cw 30']}, ccw 150 {germ_int['ccw 150']}; "
          f"germ colours cw 30 {col(germ['cw 30'])}, ccw 150 {col(germ['ccw 150'])}")
    return f"{obj}: (a) {'holds' if a_ok else 'fails'}, (b) {'holds' if b_ok else 'fails'}, (c) {'holds' if c_ok else 'not read'}, " \
           f"(d) {'hypothesis fails' if not d_hyp else ('holds' if d_ok else 'fails')}"


def main(plant):
    lines = [read("strip", plant), read("sq9", plant)]
    for ln in lines:
        print(ln)
    print("summary: " + " | ".join(ln.split(": ", 1)[1] for ln in lines))


if __name__ == "__main__":
    main("--plant" in sys.argv)
