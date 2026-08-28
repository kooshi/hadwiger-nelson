#!/usr/bin/env python3
"""Field census of a committed object's glue points (M50's P5 column, re-run per commit): each glue
point is the intersection of unit circles about its two parents at squared distance d², adjoining
√(4/d² − 1) — its RADICAND — to the parents' field. The catalogue is the radicand set over all SEED
pairs with 0 < d² < 4 (M49's "59 extensions" / M50's re-derived 60 values), exact in the seed's field
ℚ(√3, √11). A committed point is 'by construction' when both parents are seed points, 'numerically'
in the catalogue when its radicand matches a catalogue value at 40 digits or differs from one by a
rational square with denominator ≤ 10⁴ (the same field), else it ADJOINS A NEW ROOT. Numeric matching
is a census, not a proof: a square-factor collapse the 10⁴ bound misses reads as 'new' (M50's caveat).
UNTRUSTED like everything in tools/."""
import sys, json, time, collections
from pathlib import Path
from fractions import Fraction
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B
import mpmath as mp

def main(label: str, dps: int = 60):
    t0 = time.time()
    obj, removed = B.load_object(label)
    mp.mp.dps = dps
    pts = obj.mp_values(dps=dps)
    def radicand(a, b):
        D = pts[a] - pts[b]; d2 = (D * mp.conj(D)).real
        return 4 / d2 - 1
    # catalogue over seed pairs (deduplicated at 1e-40)
    cat = []
    for a in range(214):
        for b in range(a + 1, 214):
            D = pts[a] - pts[b]; d2 = (D * mp.conj(D)).real
            if 0 < d2 < 4:
                r = 4 / d2 - 1
                if not any(abs(r - c) < mp.mpf(10) ** -40 for c in cat):
                    cat.append(r)
    cat.sort()
    print(f"[field] object {label} n={obj.n}; seed-pair radicand catalogue: {len(cat)} values ({time.time()-t0:.0f}s)", flush=True)
    depth = {}
    for i, rec in enumerate(obj.prov):
        depth[i] = 0 if rec[0] == "seed" else 1 + max(depth[rec[1]], depth[rec[2]])
    def in_cat_numerically(r):
        for c in cat:
            if abs(r - c) < mp.mpf(10) ** -40:
                return "value"
            q = mp.sqrt(r / c)                     # r = c·q², q rational?
            fr = Fraction(str(mp.nstr(q, 30))).limit_denominator(10 ** 4)
            if fr > 0 and abs(q - mp.mpf(fr.numerator) / fr.denominator) < mp.mpf(10) ** -25:
                return "square-multiple"
        return None
    kinds = collections.Counter(); by_depth = collections.defaultdict(collections.Counter)
    new_vals = []
    for i in range(214, obj.n):
        _, a, b, _ = obj.prov[i]
        r = radicand(a, b)
        if a < 214 and b < 214:
            k = "by-construction"
        else:
            m = in_cat_numerically(r)
            k = f"numeric-{m}" if m else "new-root"
            if not m:
                if not any(abs(r - v) < mp.mpf(10) ** -30 for v in new_vals):
                    new_vals.append(r)
        kinds[k] += 1; by_depth[depth[i]][k] += 1
    total = obj.n - 214
    print(f"[field] {total} committed points: {dict(kinds)}", flush=True)
    for d in sorted(by_depth):
        print(f"[field]   depth {d}: {dict(by_depth[d])}", flush=True)
    print(f"[field] distinct new-root radicand values (30-digit clusters): {len(new_vals)}", flush=True)
    row = {"kind": "field-census", "label": label, "object_fingerprint": obj.fingerprint(removed),
           "committed_points": total, "catalogue_values": len(cat), "kinds": dict(kinds),
           "by_depth": {str(d): dict(c) for d, c in by_depth.items()},
           "distinct_new_root_values": len(new_vals), "dps": dps, "square_denominator_bound": 10 ** 4,
           "seconds": round(time.time() - t0, 1),
           "claim_scope": "numeric census at 60 digits: 'new-root' means no catalogue value equals the "
           "radicand or differs from it by a rational square of denominator <= 1e4; a square-factor "
           "collapse beyond that bound reads as new (M50's unresolved caveat)"}
    B.T.record(B.BUILD / "m50-batch.json", row)
    print(f"[field] recorded ({time.time()-t0:.0f}s)")

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "S29-depth2r-it2v2-depth1-it2v2-depth1")
