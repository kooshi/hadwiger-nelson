"""copy_exact — 250-digit check of a copy_probe union's cross chords. Rotation by the d=2 spindle
angle: cos = 7/8, sin = sqrt(15)/8 (exact); centre = an object point re-derived from provenance."""
from __future__ import annotations
import json, sys, math
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import mpmath as mp
import numpy as np
from batchkill import BUILD, load_object
import copy_probe as CP

def main():
    label, centre, sign = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    obj, _ = load_object(label)
    live = sorted(set(range(obj.n)) - set(obj.deleted))
    ex = obj.mp_values(250); mp.mp.dps = 250
    c, s = mp.mpf(7) / 8, sign * mp.sqrt(15) / 8
    R = mp.mpc(c, s)
    C = ex[centre]
    # replicate the probe's fusion bookkeeping (float) to map copy indices
    P = np.array(obj.pts); th = sign * 2 * math.asin(0.25)
    M = np.array([[math.cos(th), -math.sin(th)], [math.sin(th), math.cos(th)]])
    Q = P[centre] + (P[live] - P[centre]) @ M.T
    from scipy.spatial import cKDTree
    d, _ = cKDTree(P[live]).query(Q, k=1)
    newidx = {}
    for ci, li in enumerate(live):
        if d[ci] >= CP.TOL:
            newidx[obj.n + len(newidx)] = li
    name = f"rot-d2-about{'v0' if centre == 0 else centre}-{'+' if sign > 0 else '-'}28.9550"
    U = json.load(open(BUILD / f"m51-copyunion-{name}.json"))
    worst = mp.mpf(0); rows = []
    for u, w in U["cross"]:
        li = newidx[w]
        q = C + (ex[li] - C) * R
        dev = abs(abs(ex[u] - q) - 1)
        worst = max(worst, dev); rows.append((u, li, mp.nstr(dev, 5)))
    print(f"[exact] {name}: {len(rows)} cross chords, worst |dist-1| = {mp.nstr(worst, 5)} at 250 digits")
    fused = [li for ci, li in enumerate(live) if d[ci] < CP.TOL]
    for li in fused:
        q = C + (ex[li] - C) * R
        best = min((abs(ex[m] - q), m) for m in live)
        print(f"[exact]   fused copy of {li} -> {best[1]} at |diff| = {mp.nstr(best[0], 5)}")
    json.dump(dict(name=name, worst=mp.nstr(worst, 10), chords=rows), open(BUILD / f"m51-copyexact-{name}.json", "w"))

if __name__ == "__main__":
    main()
