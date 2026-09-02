#!/usr/bin/env python3
"""Splice a descent object into `tools/descent-viz.html`'s data block — the only sanctioned way to
update it (the M23/M30 viz_refresh pattern; never hand-copied).

  python3 tools/descentviz_refresh.py --object <label> [--putback build/m51-putback-it4-sub28.txt]

Emits: every point with its kind (seed-live / seed-deleted / halo with its provenance depth and
parents), the unit edges, the cheats (live, removed-by-halo, the current floor from the latest
recurse-census row, and the put-back = deferred sub-batch edges if given), the forced pair, and
per-vertex unit/cheat degrees. Coordinates are the object's floats (display only; the exact
geometry lives in the certificate, not here).
"""
import argparse, collections, json, re, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402

def main():
    ap = argparse.ArgumentParser(); ap.add_argument('--object', required=True); ap.add_argument('--putback', default=None)
    ap.add_argument('--core', default=None, help='JSON file with a list of vertex indices to highlight (e.g. a 1-minimal core)')
    ap.add_argument('--load-bearing', default=None, help='JSON file with a list of [u,v] cross chords to draw bold')
    a = ap.parse_args()
    obj, removed = BK.load_object(a.object)
    rows = json.loads((BK.BUILD / 'm50-batch.json').read_text())['rows']
    rc = [r for r in rows if r['kind'] == 'recurse-census' and r['label'] == a.object]
    floor = [tuple(e) for e in rc[-1]['essential_alone']] if rc else []
    put = [tuple(int(x) for x in e.split('-')) for e in Path(a.putback).read_text().strip().split(',')] if a.putback else []
    n = obj.n; depth = [0] * n
    for i, rec in enumerate(obj.prov):
        if rec[0] == 'glue':
            depth[i] = 1 + max(depth[rec[1]], depth[rec[2]])
        elif rec[0] == 'rot':
            depth[i] = depth[rec[2]]          # a copy carries its source's depth
    ue = obj.unit_edges(); live = set(map(tuple, obj.cheats)) - set(map(tuple, removed))   # live = present as edges
    udeg = collections.Counter(); cdeg = collections.Counter()
    for u, v in ue: udeg[u] += 1; udeg[v] += 1
    for u, v in live: cdeg[u] += 1; cdeg[v] += 1
    pts = []
    for i in range(n):
        rec = obj.prov[i]
        kind = 'seed-deleted' if i in obj.deleted else ('seed' if i < 214 else ('copy' if rec[0] == 'rot' else 'halo'))
        pts.append({'i': i, 'x': obj.pts[i][0], 'y': obj.pts[i][1], 'kind': kind,
                    'depth': depth[i], 'parents': list(rec[1:3]) if rec[0] in ('glue', 'rot') else None,
                    'sign': rec[3] if rec[0] in ('glue', 'rot') else None, 'udeg': udeg[i], 'cdeg': cdeg[i],
                    **({'copy': f"{rec[1]}{'p' if rec[3] > 0 else 'm'}", 'src': rec[2]} if rec[0] == 'rot' else {})})
    # edge classes (0 original, 1 within one copy, 2 cross) and the direction ladder index per unit edge:
    # θ ≡ 30·a + m·(t/2) + j·θ₁₅ (mod 360), t = arccos(5/6) the Moser twist (its half is the seam's
    # complement), θ₁₅ = 2·arcsin(1/4) the ρ₁₅ angle; (m, j) with the least |m|+|j| within 1e-3°, else null
    import math
    cid = {i: rec[1:2] + rec[3:4] for i, rec in enumerate(obj.prov) if rec[0] == 'rot'}
    half = math.degrees(math.acos(5 / 6)) / 2; th15 = math.degrees(2 * math.asin(0.25))
    def ladder(theta):
        best = None
        for j in range(-2, 3):
            for m in range(-6, 7):
                for a_ in range(12):
                    d = (theta - (30 * a_ + m * half + j * th15) + 180) % 360 - 180
                    if abs(d) < 1e-3 and (best is None or abs(m) + abs(j) < abs(best[0]) + abs(best[1])):
                        best = (m, j)
        return list(best) if best else [None, None]
    ucls = []; ulad = []
    for u, v in ue:
        cu, cv = cid.get(u), cid.get(v)
        ucls.append(0 if cu is None and cv is None else (1 if cu == cv else 2))
        dx, dy = obj.pts[v][0] - obj.pts[u][0], obj.pts[v][1] - obj.pts[u][1]
        ulad.append(ladder(math.degrees(math.atan2(dy, dx))))
    core = json.loads(Path(a.core).read_text()) if a.core else []
    lb = json.loads(Path(a.load_bearing).read_text()) if a.load_bearing else []
    data = {'label': a.object, 'fingerprint': obj.fingerprint(), 'n': n, 'seed_n': 214, 'deleted': sorted(obj.deleted),
            'unit_class': ucls, 'unit_ladder': ulad, 'copy_centres': sorted({rec[1] for rec in obj.prov if rec[0] == 'rot'}),
            'core': core, 'load_bearing': lb,
            'forced': [obj.A, obj.B], 'points': pts, 'unit': [list(e) for e in ue],
            'cheats': [list(e) for e in sorted(live)], 'removed': [list(e) for e in removed],
            'floor': [list(e) for e in floor], 'putback': [list(e) for e in put],
            'counts': {'unit': len(ue), 'cheats': len(live), 'removed': len(removed), 'floor': len(floor), 'putback': len(put),
                       'max_depth': max(depth)}}
    page = Path(__file__).resolve().parent / 'descent-viz.html'
    html = page.read_text()
    blob = json.dumps(data, separators=(',', ':'))
    new = re.sub(r'(<script type="application/json" id="descentdata">)(.*?)(</script>)', lambda m: m.group(1) + blob + m.group(3), html, count=1, flags=re.S)
    assert new != html or 'descentdata' in html, 'data block not found'
    page.write_text(new)
    off = sum(1 for L in ulad if L[0] is None)
    print(f'spliced {a.object}: {n} points ({len(obj.deleted)} deleted, {sum(1 for c in ucls if c)} copy-touching edges, max depth {max(depth)}), {len(ue)} unit edges ({off} off the direction ladder), {len(live)} cheats, floor {len(floor)}, put-back {len(put)} → {page}')

if __name__ == '__main__':
    main()
