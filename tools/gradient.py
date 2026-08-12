#!/usr/bin/env python3
"""M41 — the k = 5 gradient hunt: overlap census, tiled unions, menus, the autopsy.

UNTRUSTED, like everything in `tools/`. Any verdict that matters is double-encoded or
re-derived; a k = 5 UNSAT on a union is a chi(R^2) >= 6 CANDIDATE and triggers the
halt-and-verify protocol of plans/M41-k5-gradient.md P5 — never a claim on its own.

Phase-2 entry (D3): the exact overlap census. For crystal transforms T of the committed
1581 (translations by hex-lattice vectors, exact zeta6 rotations about the two spindle
pivots, the mirror), compute |V ∩ T(V)| by exact key match — zero floats. A transform
with full overlap is a SYMMETRY (reported as such, useless for tiling); a transform
sharing < 5% is recorded and never SAT-probed (near-disjoint unions teach nothing).
Union edges, when a union is built, are RE-DERIVED on the full vertex set (§0f A4):
a union of edge lists misses every cross chord.

    python3 tools/gradient.py --self-test
    python3 tools/gradient.py --overlap      # the census -> build/m41-gradient.json
"""

from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction as F
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

import degrey as D  # noqa: E402
from anatomy import (ZETA6, ORIGIN, CENTRE2, build_addresses, cmul, cconj, key,  # noqa: E402
                     approx)

ART = BUILD / "m41-gradient.json"
SCHEMA = ("m41-gradient v1 (plans/M41-k5-gradient.md §0). Overlap census rows are exact "
          "(field-key identification, zero floats). full-overlap = symmetry of the "
          "committed 1581, not a tiling candidate. machine recorded per row; laptop and "
          "desktop timings are never compared.")


def load_art():
    if ART.exists():
        return json.loads(ART.read_text())
    return {"schema": SCHEMA, "overlap": [], "unions": [], "autopsy": [], "galois": [],
            "equivariance": [], "status": "partial"}


def save_art(art):
    ART.write_text(json.dumps(art, indent=1, default=str))


# ------------------------------------------------------------------ transforms

def translate(p, t):
    return (D.add(p[0], t[0]), D.add(p[1], t[1]))


def rot_about(p, c, r):
    """r a unit rotation as a point pair (cos, sin) in field currency."""
    d = (D.sub(p[0], c[0]), D.sub(p[1], c[1]))
    rd = cmul(d, r)
    return (D.add(rd[0], c[0]), D.add(rd[1], c[1]))


def mirror_x(p):
    return (p[0], D.neg(p[1]))


def hex_translations():
    """The candidate lattice vectors: units zeta6^k, the sqrt3 family (1+zeta6)zeta6^k,
    the distance-2 family 2*zeta6^k (= the spindle-centre separation), and 3*zeta6^k."""
    out = {}
    one = (D.ONE, D.ZERO)
    u = one
    for k in range(6):
        out[f"t1.z{k}"] = u
        u = cmul(u, ZETA6)
    w = (D.add(D.ONE, ZETA6[0]), ZETA6[1])          # 1 + zeta6, |.| = sqrt3
    for k in range(6):
        out[f"ts3.z{k}"] = w
        w = cmul(w, ZETA6)
    two = (D.add(D.ONE, D.ONE), D.ZERO)
    for k in range(6):
        out[f"t2.z{k}"] = two
        two = cmul(two, ZETA6)
    three = (D.rat(3), D.ZERO)
    for k in range(6):
        out[f"t3.z{k}"] = three
        three = cmul(three, ZETA6)
    return out


def census(pts):
    keys = {key(p) for p in pts}
    n = len(pts)
    rows = []

    def probe(name, image_pts):
        shared = sum(1 for q in image_pts if key(q) in keys)
        kind = ("symmetry" if shared == n else
                "candidate" if shared >= n * 0.05 else "near-disjoint")
        rows.append({"transform": name, "shared": shared, "of": n,
                     "frac": round(shared / n, 4), "kind": kind})
        return shared

    for name, t in hex_translations().items():
        probe(name, [translate(p, t) for p in pts])
    # exact zeta6^k rotations about each spindle pivot, k = 1..5
    for cname, c in (("origin", ORIGIN), ("centre2", CENTRE2)):
        r = ZETA6
        for k in range(1, 6):
            probe(f"rot6^{k}@{cname}", [rot_about(p, c, r) for p in pts])
            r = cmul(r, ZETA6)
    probe("mirror-x", [mirror_x(p) for p in pts])
    return rows


# ------------------------------------------------------------------ self-test

def self_test():
    fails = []

    def expect(name, got, want):
        ok = got == want
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got!r}" +
              ("" if ok else f"  (want {want!r})"))
        if not ok:
            fails.append(name)

    print("m41 gradient self-test:")
    pts, _, _ = build_addresses()
    expect("committed 1581 loads", len(pts), 1581)
    keys = {key(p) for p in pts}
    ident = sum(1 for p in pts if key(p) in keys)
    expect("identity transform overlaps fully (planted green)", ident, 1581)
    far = (D.rat(100), D.ZERO)
    gone = sum(1 for p in pts if key(translate(p, far)) in keys)
    expect("far translation overlaps zero (planted red)", gone, 0)
    # rotation exactness: rot6^6 about origin is the identity
    r = ZETA6
    for _ in range(5):
        r = cmul(r, ZETA6)
    p0 = pts[7]
    expect("zeta6^6 is the exact identity on a sample point",
           key(rot_about(p0, ORIGIN, r)), key(p0))
    print("SELF-TEST:", "ok" if not fails else f"{len(fails)} FAILURES: {fails}")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--overlap", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    elif args.overlap:
        pts, _, _ = build_addresses()
        rows = census(pts)
        art = load_art()
        art["overlap"] = rows
        save_art(art)
        for r in sorted(rows, key=lambda x: -x["shared"]):
            print(f"  {r['transform']:>16}: {r['shared']:>5}/{r['of']}  ({r['frac']:.1%})"
                  f"  {r['kind']}", flush=True)
    else:
        art = load_art()
        print(f"{ART.name}: {len(art.get('overlap', []))} overlap rows; see --help")


if __name__ == "__main__":
    main()
