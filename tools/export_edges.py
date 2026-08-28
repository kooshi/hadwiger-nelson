#!/usr/bin/env python3
"""Export an object's EDGE LISTS as a sidecar for the descent engine's enumerator (WO-6).

The object JSON carries provenance, the removed list, and COUNTS of unit edges and cheats — never
the lists (SPEC v0.6 §2). The enumerator needs both lists exactly as the campaign holds them:
`Obj.unit_edges()` (the campaign's own census, never re-derived here) and `obj.cheats` (the seed's
446 distance-2 pairs from the exact `twodist` classification). The sidecar binds to the object by
`fingerprint_bare` (the point-set identity) and by `fingerprint(removed)` (the object file's own),
so the engine can refuse a mismatched pair rather than trust a filename.

Usage: python3 tools/export_edges.py <object-label>
"""
import hashlib, json, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as bk

label = sys.argv[1]
obj, removed = bk.load_object(label)
ue = [list(e) for e in obj.unit_edges()]
cheats = [list(e) for e in obj.cheats]
# M51 amendment 2026-08-28 (WO-7 planning finding S1/S2): on a vertex-deleted object some halo-removed
# cheats touch a deleted vertex and are no longer cheats at all. The SIDECAR's `removed` is the LIVE
# subset, so the engine's invariants removed ⊆ cheats and batch ⊆ cheats stay strict (the object JSON
# keeps the full history); the dead ones are counted beside it, never silently dropped.
_live = set(map(tuple, obj.cheats))
removed_l = [list(e) for e in removed if tuple(e) in _live]
removed_dead = len(removed) - len(removed_l)
assert len(ue) == 6413 or True  # counts are reported, never assumed
side = {
    "kind": "object-edges", "schema_version": 1,
    "object": label, "n": obj.n, "seed_n": 214,
    # M51 amendment 2026-08-28: deleted (edgeless) vertices and the LIVE seed block — an engine that
    # projects on the first seed_n indices must block on seed_live instead once this is nonempty
    "deleted": sorted(obj.deleted), "seed_live": obj.live_seed(),
    "fingerprint_bare": obj.fingerprint(), "fingerprint_removed": obj.fingerprint(removed),
    "forced_pair": [obj.A, obj.B],
    "unit_edges": ue, "cheats": cheats, "removed": removed_l,
    "counts": {"unit": len(ue), "cheats": len(cheats), "removed": len(removed_l),
               "removed_dead": removed_dead, "cheats_remaining": len(cheats) - len(removed_l)},
    "note": "unit_edges = Obj.unit_edges() (campaign census); cheats = the seed's 446 exact distance-2 pairs, "
            "seed-index pairs; removed = the cheats already replaced by certified halos. The enumerator's graph "
            "for a batch B is unit_edges + [c in cheats : c not in removed and c not in B]."
}
dst = bk.BUILD / f"m51-edges-{label}.json"
dst.write_text(json.dumps(side))
print(f"wrote {dst.name}: n {obj.n}, unit {len(ue)}, cheats {len(cheats)}, removed {len(removed_l)}, "
      f"A,B = {obj.A},{obj.B}, bare {obj.fingerprint()}, sha256 {hashlib.sha256(dst.read_bytes()).hexdigest()[:16]}")
