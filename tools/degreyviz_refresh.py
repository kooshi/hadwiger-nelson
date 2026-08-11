#!/usr/bin/env python3
"""Splice the M30 anatomy data into `tools/degrey-viz.html` — the ONLY sanctioned way to update
its data block (the M23 `viz_refresh.py` pattern; hand-editing violates the never-hand-copied
rule).

Joins three measurement artifacts into one view-model:
  * `build/m30-anatomy.json`         — the classification (run `tools/anatomy.py` first);
  * `build/m30-rigidity-forcer791.json` — forced pairs / virtual edges of the 791-point forcer at
    k = 4, mapped here into committed 1581 indices (the 791 is the pre-final-spindle subset, so
    every vertex persists);
  * `build/m30-rigidity-1581-k5.json` — the same questions on the full graph at k = 5 (optional;
    the overlay ships with whichever regimes exist, each labeled — an unlabeled overlay lies).
"""

from __future__ import annotations

import json
import re
import sys
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parent.parent
PAGE = REPO / "tools" / "degrey-viz.html"
BUILD = REPO / "build"


def forcer_to_committed() -> list[int]:
    """791-forcer index → committed 1581 index, exactly (recompute y, key-match)."""
    import construct as C
    from fractions import Fraction
    from anatomy import build_addresses, committed_bijection, key
    sa = C.orbit(C.degrey_seed(), C.hex12())
    sasb = C.spindle(sa, C.index_of(sa, 0, 0), C.index_of(sa, 2, 0))
    y = C.delete(sasb, [C.index_of(sasb, Fraction(1, 3), 0),
                        C.index_of(sasb, Fraction(-1, 3), 0)])
    pts, table, _ = build_addresses()
    bij, _ = committed_bijection(pts)
    out = []
    for (xv, yv) in y.pts:
        k = (tuple(F(v, y.denom) for v in xv), tuple(F(v, y.denom) for v in yv))
        if k not in table:
            raise SystemExit("a forcer vertex is missing from the 1581 — the constructions "
                             "disagree; re-run construct.py regen-check")
        out.append(bij[table[k]])
    return out


def main() -> None:
    an = json.load(open(BUILD / "m30-anatomy.json"))

    copy_pairs: dict[str, int] = {}
    tags = ["base", "spindle15", "spindle63", "both"]
    for a in tags:
        for b in tags:
            if a <= b:
                copy_pairs[f"{a} ↔ {b}"] = 0
    for e in an["edges"]:
        t = sorted(e["coarse"][:2])
        copy_pairs[f"{t[0]} ↔ {t[1]}"] += 1

    lb = set()
    if an.get("probes"):
        for p in an["probes"].get("post_hoc_direction", []):
            if p["sat_at_4"] == "sat":
                lb.add(p["dir"])

    degrey = {
        "vertices": [v["xy"] for v in an["vertices"]],
        "meta": [{"tags": v["tags"], "r2": v["r2"], "words": v["words"]}
                 for v in an["vertices"]],
        "edges": [{"i": e["i"], "j": e["j"], "dir": e["dir"], "exp": e["exp"]}
                  for e in an["edges"]],
        "copyPairs": copy_pairs,
        "five": an.get("five_colouring"),
        "loadBearing": sorted(lb),
        "overlays": {},
    }

    regimes = []
    f791 = BUILD / "m30-rigidity-forcer791.json"
    if f791.exists():
        r = json.load(open(f791))
        if r.get("status") != "vacuous":
            m = forcer_to_committed()
            degrey["overlays"]["forced"] = [[m[i], m[j]]
                                           for i, j in r["forced_equal"]["confirmed"]]
            degrey["overlays"]["virtual"] = [[m[i], m[j]]
                                            for i, j in r["virtual_edges"]["confirmed"]]
            regimes.append(f"forced structure measured on the 791-point forcer at 4 colours "
                           f"({len(degrey['overlays']['forced'])} pairs confirmed"
                           + (f", {len(r['forced_equal']['unsettled'])} unsettled"
                              if r["forced_equal"]["unsettled"] else "") + ")")
    k5 = BUILD / "m30-rigidity-1581-k5.json"
    if k5.exists():
        r = json.load(open(k5))
        if r.get("status") != "vacuous":
            degrey["overlays"].setdefault("forced", []).extend(
                [list(p) for p in r["forced_equal"]["confirmed"]])
            regimes.append("plus the full 1581 at 5 colours")
    degrey["overlays"]["regime"] = "; ".join(regimes) if regimes else \
        "no rigidity artifacts found — overlays empty"

    witnesses = {"degrey": degrey}
    for nm, keyname in (("heule510", "heule510.json"), ("heule553", "heule553.json")):
        h = next(x for x in an["heule"] if x["witness"] == keyname)
        witnesses[nm] = {"vertices": h["viz"]["vertices"], "edges": h["viz"]["edges"],
                         "meta": None, "copyPairs": None, "five": None,
                         "loadBearing": [],
                         "overlays": {"regime": f"{h['residue_edges']} residue edges outside "
                                                f"the half-spindle group"}}

    data = json.dumps({"witnesses": witnesses, "verdicts": an["verdicts"]},
                      separators=(",", ":"))
    html = PAGE.read_text()
    new, count = re.subn(
        r'(<script id="m30data" type="application/json">).*?(</script>)',
        lambda m: m.group(1) + data + m.group(2), html, flags=re.S)
    if count != 1:
        raise SystemExit(f"expected exactly one m30data block, found {count} — page structure "
                         f"drifted; refusing to write")
    PAGE.write_text(new)
    print(f"spliced {len(data) // 1024} KB into {PAGE.name} "
          f"(overlays: {degrey['overlays']['regime']})")


def m33_block() -> None:
    """Splice ONLY the m33data block (the mechanism-hunt onset curves, class spectra, chunk
    ladder, and cores) from build/m33-*.json — fast, no anatomy rebuild. Artifacts are taken
    as found; a missing artifact simply leaves its section out (the page labels absence)."""
    curves = []
    for obj, centre, label in [("heule510", "v0", "Heule-510 about v0 (36-pt circle)"),
                               ("degrey1581", "origin", "de Grey 1581 about the origin (60-pt)"),
                               ("degrey1581", "centre2", "de Grey 1581 about (−2,0) (12-pt)"),
                               ("fabric", "origin", "the bare fabric orbit(S, hex₁₂) (30-pt)")]:
        p = BUILD / f"m33-spectrum-{obj}-{centre}.json"
        if not p.exists():
            continue
        d = json.loads(p.read_text())
        curves.append({
            "object": obj, "centre": centre, "label": label,
            "marks": [{"r2": r["r2"], "n": r["n"], "nT": r["n_target"],
                       "lo": r["cover"]["lo"], "hi": r["cover"]["hi"],
                       "verdict": r["cover"]["verdict"]} for r in d.get("marks", [])],
            "coverOnsets": d.get("onsets", {}).get("cover", {}),
            "classes": {cn: {"onset": c.get("onset_r2"), "top": c.get("top_verdict"),
                             "promotion": c.get("promotion")}
                        for cn, c in d.get("onsets", {}).get("classes", {}).items()},
        })
    cores = []
    for p in sorted(BUILD.glob("m33-core-*.json")) + sorted(BUILD.glob("m33-covercore-*.json")):
        d = json.loads(p.read_text())
        kind = (f"coverage ≥ {d['query']['level']}" if "query" in d and
                d.get("query", {}).get("type") == "coverage"
                else f"class {d['class']['name']}")
        cores.append({"object": d["object"], "centre": d["centre"], "kind": kind,
                      "n": d["n"], "nT": d.get("n_target"),
                      "vertices": d["vertices"], "rings": d["anatomy"]["rings"],
                      "necessity": d["necessity"]["complete"],
                      "reencode": d.get("reencode", {}).get("outcome"),
                      "status": d["status"]})
    ladder = None
    lp = BUILD / "m33-chunk-ladder.json"
    if lp.exists():
        ladder = json.loads(lp.read_text())["rows"]
    shells = {"heule510-eq-pair-2": "r² = 5/3 — the glue shell |1+σ/√3|²",
              "fabric-eq-pair-2": "r² = 2 − √33/9 (pure ℚ(√33))",
              "degrey1581-eq-pair-2": "r² = 2 − √33/9 — IDENTICAL to the bare fabric's",
              "degrey1581-eq-pair-sqrt3": "r² = (33 − 3√21)/8 — √21 = √3·√7: cross-system "
                                          "material entering"}
    data = json.dumps({"curves": curves, "cores": cores, "ladder": ladder, "shells": shells},
                      separators=(",", ":"))
    html = PAGE.read_text()
    new, count = re.subn(
        r'(<script id="m33data" type="application/json">).*?(</script>)',
        lambda m: m.group(1) + data + m.group(2), html, flags=re.S)
    if count != 1:
        raise SystemExit(f"expected exactly one m33data block, found {count} — page structure "
                         f"drifted; refusing to write")
    PAGE.write_text(new)
    print(f"spliced {len(data) // 1024} KB of m33data into {PAGE.name} "
          f"({len(curves)} curves, {len(cores)} cores)")


if __name__ == "__main__":
    if "--m33" in sys.argv:
        m33_block()
    else:
        main()
