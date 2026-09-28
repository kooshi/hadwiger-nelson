#!/usr/bin/env python3
"""X1: find positions for the drafted atlas nodes (their `at=` are placeholders) with no lint overlap, nearest the placeholder.
Reads tools/viz_proof_atlas_facts.py without building; prints a proposal per node. Moves only MOVABLE."""
import math, pathlib, sys
ROOT = pathlib.Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
src = (ROOT / "tools/viz_proof_atlas_facts.py").read_text().replace("\nif __name__ == \"__main__\":\n    build()", "")
g = {"__file__": str(ROOT / "tools/viz_proof_atlas_facts.py"), "__name__": "x1"}
exec(compile(src, "facts", "exec"), g)
NODES, label_box = g["NODES"], g["label_box"]
MOVABLE = ["CVEXISTS", "LOCALF", "BOWSQ3", "PINW", "ROUTET", "CAPSTRIP", "FS111", "MEET", "FS121", "FS120", "FS122"]


def count(nodes, focus=None):
    """The lint's overlap count (tools/viz_proof_atlas_facts.py lint()), restricted to pairs involving `focus` when given."""
    bad = 0
    for tiers, fs in (((0, 1), 16), ((0, 1, 2), 11.7)):
        shown = [n for n in nodes if n["tier"] in tiers and n["role"] != "answer"]
        boxes = [(n["id"],) + label_box(n, fs) for n in shown]
        alln = [(n["id"],) + label_box(n, fs)[1] for n in nodes]
        for i in range(len(boxes)):
            a = boxes[i][1]
            for j in range(i + 1, len(boxes)):
                if focus is not None and focus not in (boxes[i][0], boxes[j][0]): continue
                b = boxes[j][1]
                if a[0] < b[2] and b[0] < a[2] and a[1] < b[3] and b[1] < a[3]: bad += 1
            for (nid, x, y, rad) in alln:
                if focus is not None and focus not in (nid, boxes[i][0]): continue
                if nid != boxes[i][0] and a[0] < x + rad and x - rad < a[2] and a[1] < y + rad and y - rad < a[3]: bad += 1
    for i in range(len(nodes)):
        for j in range(i + 1, len(nodes)):
            if focus is not None and focus not in (nodes[i]["id"], nodes[j]["id"]): continue
            (_, (x1, y1, r1)), (_, (x2, y2, r2)) = label_box(nodes[i], 12), label_box(nodes[j], 12)
            if math.hypot(x1 - x2, y1 - y2) < r1 + r2 + 8: bad += 1
    return bad


by = {n["id"]: n for n in NODES}
orig = {k: (by[k]["theta"], by[k]["r"]) for k in MOVABLE}
print("total overlaps before:", count(NODES))
# sector theta ranges from the fixed nodes
rng = {}
for n in NODES:
    if n["id"] in MOVABLE or n["role"] == "answer": continue
    lo, hi = rng.get(n["sector"], (999, -999)); rng[n["sector"]] = (min(lo, n["theta"]), max(hi, n["theta"]))
# park the movable nodes far away, then place one at a time
for k in MOVABLE:
    by[k]["theta"], by[k]["r"] = 180, 5000 + 100 * MOVABLE.index(k)
for k in MOVABLE:
    t0, r0 = orig[k]; lo, hi = rng[by[k]["sector"]]
    cands = sorted(((math.hypot(dt * r0 * math.pi / 180, dr), t0 + dt, r0 + dr) for dt in range(-30, 31) for dr in range(-160, 161, 5)
                    if lo - 2 <= t0 + dt <= hi + 2 and 120 <= r0 + dr <= 610))
    best = None
    for d, t, r in cands:                      # nearest first; stop at the first position with no overlap
        by[k]["theta"], by[k]["r"] = t, r
        c = count(NODES, focus=k)
        if best is None or (c, d) < best[0]: best = ((c, d), t, r)
        if c == 0: break
    by[k]["theta"], by[k]["r"] = best[1], best[2]
    print(f"{k}: {orig[k]} -> ({best[1]}, {best[2]})  overlaps involving it: {best[0][0]}")
print("total overlaps after:", count(NODES))
