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
    ue = obj.unit_edges(); live = set(map(tuple, obj.cheats)) - set(map(tuple, removed))   # live = present as edges
    udeg = collections.Counter(); cdeg = collections.Counter()
    for u, v in ue: udeg[u] += 1; udeg[v] += 1
    for u, v in live: cdeg[u] += 1; cdeg[v] += 1
    pts = []
    for i in range(n):
        rec = obj.prov[i]
        pts.append({'i': i, 'x': obj.pts[i][0], 'y': obj.pts[i][1],
                    'kind': 'seed-deleted' if i in obj.deleted else ('seed' if i < 214 else 'halo'),
                    'depth': depth[i], 'parents': list(rec[1:3]) if rec[0] == 'glue' else None,
                    'sign': rec[3] if rec[0] == 'glue' else None, 'udeg': udeg[i], 'cdeg': cdeg[i]})
    data = {'label': a.object, 'fingerprint': obj.fingerprint(), 'n': n, 'seed_n': 214, 'deleted': sorted(obj.deleted),
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
    print(f'spliced {a.object}: {n} points ({len(obj.deleted)} deleted, max depth {max(depth)}), {len(ue)} unit edges, {len(live)} cheats, floor {len(floor)}, put-back {len(put)} → {page}')

if __name__ == '__main__':
    main()
