#!/usr/bin/env python3
"""Splice the M31 closure measurements into `tools/closure-viz.html` — the ONLY sanctioned way
to update its data block (the viz_refresh pattern; hand-editing violates never-hand-copied).

Geometry is REGENERATED exactly from `closure.py`'s committed builders (deterministic), so the
probe JSONs stay lean; the chi rows and cross-chord certificates come from the probe artifacts:
  build/m31-mitosis-B*.json, build/m31-pair.json (chi + certificates)
  build/m31-closure-gen1.pts.json, build/m31-closure-gen1.json (the gen-1 object)
  build/m31-frontier.json (the k=4 frontier, if measured)
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import closure as CL  # noqa: E402

REPO = Path(__file__).resolve().parent.parent
PAGE = REPO / "tools" / "closure-viz.html"
BUILD = REPO / "build"

LAW = {"seam": "seam rotation — the M24-M26 chord families, no pin",
       "even15": "full spindle: couples only along lines through the anchor",
       "odd15": "half spindle: couples only along perpendiculars through the anchor",
       "even63": "full sqrt63 spindle: lines through the anchor (needs radius-4 material)",
       "odd63": "half sqrt63 spindle: perpendiculars through the anchor",
       "mixed": "both families at once: couples NOWHERE (sterile by law)"}


def detunes():
    return [CL.make_detune(a=2, name="rho15"), CL.make_detune(b=2, name="rho63"),
            CL.make_detune(a=1, name="half15"), CL.make_detune(b=1, name="half63"),
            CL.make_detune(a=1, b=1, name="mixed15x63"),
            CL.make_detune(s=CL.Z12, a=2, name="zeta12*rho15")]


def variant_geometry(base_pts, anchor, det, rec):
    """Rebuild one mitotic union's geometry and classify its edges for display."""
    m = CL.mitosis(base_pts, anchor, det)
    cen = CL.census(m, "viz")
    tags = [{t for (t, _) in pr} for pr in m["prov"]]
    cross_pairs = {(c["i"], c["j"]) for c in cen["cross"]}
    intra, anchor_edges = [], []
    a_key = CL.key(anchor)
    for (i, j) in cen["edges"]:
        if (i, j) in cross_pairs:
            continue
        if CL.key(m["pts"][i]) == a_key or CL.key(m["pts"][j]) == a_key or \
           (1 in tags[i]) != (1 in tags[j]):
            anchor_edges.append([i, j])
        else:
            intra.append([i, j])
    cross = []
    for c in rec["cross_chords"]:
        cross.append({"i": c["i"], "j": c["j"], "pin": c["pin"],
                      "t2": c.get("t2", 0), "r2": c.get("r2", 0), "tr": c.get("tr", 0),
                      "t2x": json.dumps(c.get("t2_exact", {})),
                      "r2x": json.dumps(c.get("r2_exact", {}))})
    return {"xy": [list(CL.approx(p)) for p in m["pts"]],
            "base_ids": [i for i, t in enumerate(tags) if 0 in t],
            "copy_ids": [i for i, t in enumerate(tags) if 1 in t and 0 not in t],
            "fused_ids": m["fused"],
            "anchor": list(CL.approx(anchor)),
            "intra": intra, "anchor_edges": anchor_edges, "cross": cross,
            "detune": rec["detune"]["name"], "cls": rec["detune"]["class"],
            "law": LAW[rec["detune"]["class"]], "chi": rec["chi"]}


def main():
    variants = {}
    for B in (1, 2):
        path = BUILD / f"m31-mitosis-B{B}.json"
        if not path.exists():
            continue
        data = json.load(open(path))
        pts, mpiv, hexpiv = CL.hexagram_points(B)
        anchors = {"m": mpiv, "p0": hexpiv[0]}
        for tag, rec in data.items():
            aname = tag.split("/")[1]
            det = next(d for d in detunes() if d["name"] == rec["detune"]["name"])
            variants[tag] = variant_geometry(pts, anchors[aname], det, rec)
    pair_path = BUILD / "m31-pair.json"
    if pair_path.exists():
        data = json.load(open(pair_path))
        pts, c0, _c1 = CL.pair_points(2)
        for tag, rec in data.items():
            if tag == "plain":
                continue
            det = next(d for d in [CL.make_detune(a=2, name="rho15"),
                                   CL.make_detune(a=1, name="half15")]
                       if d["name"] == rec["detune"]["name"])
            variants[tag] = variant_geometry(pts, c0, det, rec)

    gen1 = None
    g_path = BUILD / "m31-closure-gen1.pts.json"
    if g_path.exists():
        g = json.load(open(g_path))
        meta = json.load(open(BUILD / "m31-closure-gen1.json"))
        chi5 = meta["chi"][0]["outcome"] if meta.get("chi") else "unmeasured"
        gen1 = {"xy": [[round(x, 5), round(y, 5)] for (x, y) in g["xy"]],
                "edges": g["edges"],
                "g0": [i for i, t in enumerate(g["gen"]) if t == 0],
                "g1": [i for i, t in enumerate(g["gen"]) if t == 1],
                "fusions": meta["fusions"], "rings": meta["rings_origin"], "chi5": chi5}

    frontier = None
    f_path = BUILD / "m31-frontier.json"
    if f_path.exists():
        frontier = json.load(open(f_path))

    blob = json.dumps({"variants": variants, "gen1": gen1, "frontier": frontier},
                      separators=(",", ":"))
    page = PAGE.read_text()
    marker = '<script id="data" type="application/json">'
    a = page.index(marker) + len(marker)
    b = page.index("</script>", a)
    PAGE.write_text(page[:a] + blob + page[b:])
    print(f"spliced {len(variants)} variants, gen1={'yes' if gen1 else 'no'}, "
          f"frontier={'yes' if frontier else 'no'} → {PAGE} ({PAGE.stat().st_size//1024} KB)")


if __name__ == "__main__":
    main()
