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


M32_GRID = {
    "same/meta/chirality": ("ρ₁₅ + ρ₁₅⁻¹ about the metapivot — the chirality pair "
                            "(copy↔copy predicted EMPTY: the 17/16-conic needs a 289/256 "
                            "ring)", "meta", [("m", 2), ("m", -2)]),
    "same/hexpiv3/full+twisted": ("ρ₁₅ + ζ₁₂ρ₁₅ about pivot 0 — pure-seam relative word: "
                                  "the M24–M26 families, hundreds of chords, no pin",
                                  "hexpiv3", [("p3", 2), ("p3z", 2)]),
    "wide/wide-unit": ("ρ₁₅ about pivot 0 + ρ₁₅ about pivot 1 — UNIT anchors: the wide "
                       "channel, the exact translation matching", "wide",
                       [("p3", 2), ("p5", 2)]),
    "wide/sterile-third": ("ρ₁₅ about pivot 0 + ρ₁₅ about the metapivot — 1/√3 anchors: "
                           "sterile by §0a (admissible lengths would need √59)", "wide",
                           [("p3", 2), ("m", 2)]),
    "tri/rho15": ("ρ₁₅ at all three triangle pivots — three pairwise matchings composing "
                  "into 26 forced-rainbow unit triangles spanning the copies", "tri",
                  [("p3", 2), ("p5", 2), ("p1", 2)]),
}

COPY_COLORS = 3  # palette lives in the page

MATCH_CAP = 60   # matching chords rendered; the badge carries the true count


def stack_geometry(B, spec, rec):
    """Rebuild one stack's geometry from the committed builders; meters/chi from `rec`."""
    pts, mpiv, hexpiv = CL.hexagram_points(B)
    anchors = {"m": mpiv, "p3": hexpiv[3], "p5": hexpiv[5], "p1": hexpiv[1],
               "p3z": hexpiv[3]}
    copies = []
    for (aname, aexp) in spec:
        det = (CL.make_detune(s=CL.Z12, a=aexp, name="z12*rho15") if aname.endswith("z")
               else CL.make_detune(a=aexp, name=f"w{aexp}"))
        copies.append((anchors[aname], det))
    st = CL.stack(pts, copies)
    cen = CL.stack_census(st, "viz-m32")
    tags = [{t for (t, _) in pr} for pr in st["prov"]]
    pair_out = []
    for (ta, tb), prec in sorted(cen["pairs"].items()):
        route = cen["routes"][(ta, tb)]["route"]
        chords = prec["chords"]
        shown = [{"i": c["i"], "j": c["j"], "kind": c["kind"],
                  "pin": c.get("pin", ""), "t2": c.get("t2", 0), "r2": c.get("r2", 0),
                  "w2": c.get("w2", 0)} for c in chords[:MATCH_CAP]]
        pair_out.append({"pair": f"{ta}-{tb}", "route": route, "n": len(chords),
                         "matching": prec["matching"],
                         "anchor_incident": prec["anchor_incident"], "shown": shown})
    return {"xy": [list(CL.approx(p)) for p in st["pts"]],
            "copy_ids": [[i for i, t in enumerate(tags) if c in t]
                         for c in range(len(copies) + 1)],
            "anchors": [list(CL.approx(a)) for (a, _) in copies],
            "intra": [[i, j] for (i, j) in cen["edges"]
                      if len(tags[i] & tags[j]) > 0],
            "pairs": pair_out,
            "chi": rec.get("chi", []), "coverage": rec.get("coverage", []),
            "compelled": rec.get("compelled_triples", 0),
            "sweep": rec.get("sweep")}


def m32_block():
    """The M32 stack tab's data: five representative stacks + the checkpoint verdict."""
    recs = {}
    for name in ("m32-same-B2.json", "m32-wide-B2.json", "m32-tristack.json"):
        p = BUILD / name
        if p.exists():
            for v in json.load(open(p)).get("variants", []):
                recs[v["object"]] = v
    stacks = {}
    for tag, (desc, _grp, spec) in M32_GRID.items():
        if tag in recs:
            g = stack_geometry(2, spec, recs[tag])
            g["desc"] = desc
            stacks[tag] = g
    base = None
    bp = BUILD / "m32-base-B2.json"
    if bp.exists():
        b = json.load(open(bp))
        base = {"coverage": b.get("coverage", []), "chi": b.get("chi", []),
                "compelled": b.get("compelled_triples", 0)}
    checkpoint = {
        "verdict": "FLAT",
        "text": "The registered grid and the §0g triangle-stack addendum both read flat: "
                "the translation matching is wide (132 chords) but 1-regular — width "
                "without degree carries no colour pressure. Zero forced pairs, zero "
                "virtual edges, zero coverage movement, zero compelled triples; every "
                "stack χ = 4. The 5-mechanism stays irreducibly global for designed "
                "one-family objects at this scale; M33 = Route A (the 1581-witness "
                "closure), with the 2-adic kill engine now kernel-checked."}
    return {"stacks": stacks, "base": base, "checkpoint": checkpoint}


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

    m32 = m32_block()

    blob = json.dumps({"variants": variants, "gen1": gen1, "frontier": frontier,
                       "m32": m32}, separators=(",", ":"))
    page = PAGE.read_text()
    marker = '<script id="data" type="application/json">'
    a = page.index(marker) + len(marker)
    b = page.index("</script>", a)
    PAGE.write_text(page[:a] + blob + page[b:])
    print(f"spliced {len(variants)} variants, gen1={'yes' if gen1 else 'no'}, "
          f"frontier={'yes' if frontier else 'no'}, m32 stacks={len(m32['stacks'])} "
          f"→ {PAGE} ({PAGE.stat().st_size//1024} KB)")


if __name__ == "__main__":
    main()
