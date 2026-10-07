#!/usr/bin/env python3
"""SEARCH-2026-10-07 — cold exact check of one seven-flower model.

Reads MODEL-*.json (ring: 6 x 6 labels; x: 12 labels; K: 6 ray types), rebuilds every tile from the formulas of
turning_ring.py at the radius asked (--ta, default 1/8), and decides every same-colour pair of tiles — generated from the
colour map, every tile against itself included — with tools/fs110_y_check.pair_verdict.  It reads no table and no CNF.
It also reads the family's conditions off the model: the ring's labels on the wedges that touch the ring, the three labels
at x, the number of labels at each ring point, the number of sectors at x.

  --plant-label K W L   put label L on wedge W of ring point K before checking (a planted fault)
  --yplant NAME         FS110-Y's own checker plants (closed_interval: every tight contact turns REJECT)
exit 0 iff ACCEPT and the family's conditions hold.
"""
import sys, os, json, itertools
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import turning_ring as R   # noqa: E402
C = R.C
NAMES = "abn345"
RINGS = {"turning": [0, 1, 2, 0, 1, 2], "alternating": [0, 1, 0, 1, 0, 1]}


def main():
    a = sys.argv[1:]
    M = json.load(open(a[0]))
    ta = Fr(a[a.index("--ta") + 1]) if "--ta" in a else Fr(1, 8)
    if "--yplant" in a: C.PLANT = a[a.index("--yplant") + 1]
    ring = [row[:] for row in M["ring"]]
    if "--plant-label" in a:
        i = a.index("--plant-label"); k, w, l = int(a[i + 1]), int(a[i + 2]), int(a[i + 3])
        print(f"PLANT: wedge {R.WNAME[w]} of y_{k}: {NAMES[ring[k][w]]} -> {NAMES[l]}")
        ring[k][w] = l
    tiles, col = {}, {}
    for k in range(6):
        fl = R.ring_flower(k, ta)
        for w in range(6):
            nm = f"y{k}.{R.WNAME[w]}"; tiles[nm] = fl[w]; col[nm] = ring[k][w]
    for j in range(12):
        nm = f"x.E{j}"; tiles[nm] = R.x_subtile(j, M["K"][R.crit_of(j)[1]], ta); col[nm] = M["x"][j]
    names = sorted(tiles)
    pairs = [(p, q) for p, q in itertools.combinations_with_replacement(names, 2) if col[p] == col[q]]
    bad = [(p, q) for (p, q) in pairs if C.pair_verdict(tiles[p], tiles[q], self_pair=(p == q)) == "REJECT"]
    # the family's conditions, read off the model
    L = RINGS[M["ring_pattern"]]
    cond = []
    for k in range(6):
        for (ws, lab) in (((0, 5), L[k]), ((2, 3), L[(k + 1) % 6])):
            got = [ring[k][w] for w in ws]
            if lab not in got or any(g < 3 and g != lab for g in got):
                cond.append(f"ring label {NAMES[lab]} at y_{k} wedges {ws}: got {[NAMES[g] for g in got]}")
    if set(M["x"]) != {3, 4, 5}: cond.append("x does not carry the three labels 3, 4, 5")
    nlab = [len(set(ring[k])) for k in range(6)]
    sectors = sum(1 for j in range(12) if M["x"][j] != M["x"][j - 1])
    curved = [(30 * (2 * m + 1), M["K"][m]) for m in range(6)
              if M["x"][(2 * m + 1) % 12] != M["x"][2 * m] and M["K"][m] != "S"]
    n, gbad = R.geom(ta)
    print(f"model={os.path.basename(a[0])} ta={ta} yplant={C.PLANT} tiles={len(tiles)} same-colour pairs (self included)={len(pairs)} "
          f"REJECTED={len(bad)}")
    for p, q in bad[:12]:
        print(f"   REJECT colour {NAMES[col[p]]}: {p} x {q}")
    print(f"   labels at y_0..y_5: {nlab}  sectors at x: {sectors}  curved interfaces at x (direction, type): {curved}")
    print(f"   family conditions violated: {cond if cond else 'none'}   geometry guard (float): samples={n} wrong={gbad}")
    ok = not bad and not cond and gbad == 0
    print("VERDICT", "ACCEPT" if ok else "REJECT")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
