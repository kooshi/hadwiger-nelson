#!/usr/bin/env python3
"""fs61_recount -- recount one tier's ball records STRAIGHT OFF THE BYTES of data/fs61/fields/*/balls.jsonl.

UNTRUSTED, and deliberately standalone: it imports nothing from the census driver, shares no code with it, does not
deduplicate by key and never writes.  Its job is to be the second opinion on a phase's counts -- the product owner
recounts every phase this way, and an implementer who cannot reproduce his numbers from the raw records has not
finished.  Usage:  python3 tools/fs61_recount.py 1c [1b ...]
"""
import sys, json, collections
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FIELDS = ROOT / 'data' / 'fs61' / 'fields'


def main(tiers):
    for tid in tiers:
        recs, bad = [], 0
        for p in sorted(FIELDS.glob('*/balls.jsonl')):
            for ln in p.read_bytes().split(b'\n'):
                if not ln.strip():
                    continue
                try:
                    r = json.loads(ln)
                except json.JSONDecodeError:
                    bad += 1
                    continue
                if str(r.get('tier')) == tid:
                    r['_field'] = int(p.parent.name)
                    recs.append(r)
        v = collections.Counter(r['verdict'] for r in recs)
        arms = collections.Counter(r.get('degree_arm', '-') for r in recs)
        asked = [r for r in recs if r['verdict'] != 'Over cap (not asked)']
        ref = [r for r in recs if r['verdict'].startswith('Refused')]
        unk = [r for r in recs if r['verdict'] == 'Unknown (budget)']
        print(f'=== tier {tid}: {len(recs)} records over {len({r["_field"] for r in recs})} fields '
              f'({bad} unparseable lines skipped) ===')
        for k, n in sorted(v.items()):
            print(f'    {k:<34} {n}')
        print(f'    asked (not over cap): {len(asked)}')
        print(f'    by rule arm: ' + ', '.join(f'{k}={n}' for k, n in sorted(arms.items())))
        own = collections.Counter(r.get('owner_arm') for r in recs if 'owner_arm' in r)
        if own:
            print(f'    scope arm: owner {own.get(True, 0)}, widened {own.get(False, 0)}')
        rat = [r['points'] / r['predicted_points'] for r in asked
               if isinstance(r.get('points'), int) and isinstance(r.get('predicted_points'), int)
               and r['predicted_points']]
        if rat:
            rat.sort()
            print(f'    actual/predicted POINTS over {len(rat)} asked balls: '
                  f'{rat[0]:.4f}-{rat[-1]:.4f}, median {rat[len(rat) // 2]:.4f}')
        dr = sorted(r['degree_over_predicted'] for r in asked if r.get('degree_over_predicted'))
        if dr:
            print(f'    actual/predicted DEGREE over {len(dr)} asked balls: '
                  f'{dr[0]:.4f}-{dr[-1]:.4f}, median {dr[len(dr) // 2]:.4f}')
        pk = [r['rss_peak_kb'] / 1048576 for r in asked if r.get('rss_peak_kb')]
        if pk:
            print(f'    worker peak RSS over {len(pk)} asked balls: max {max(pk):.2f} GB, median '
                  f'{sorted(pk)[len(pk) // 2]:.2f} GB')
        if ref:
            print(f'    REFUSALS ({len(ref)}):')
            for r in sorted(ref, key=lambda r: r['_field']):
                print(f'      d={r["_field"]:>3} {r["id"]} R={r["R"]} {r["points"]:,} points {r["edges"]:,} edges '
                      f'degree {r.get("actual_degree")} arm {r.get("degree_arm")} [{r["solve_seconds"]} s]')
        if unk:
            print(f'    UNDECIDED AT THE WALL ({len(unk)}):')
            for r in sorted(unk, key=lambda r: r['_field']):
                print(f'      d={r["_field"]:>3} {r["id"]} R={r["R"]} {r["points"]:,} points degree '
                      f'{r.get("actual_degree")} arm {r.get("degree_arm")} wall {r.get("wall")} s')
        # P-deg1, scored straight off the records: does any ball at predicted degree >= 14 fail to decide?
        hi = [r for r in asked if (r.get('predicted_degree') or 0) >= 14]
        if hi:
            u = [r for r in hi if r['verdict'] == 'Unknown (budget)']
            print(f'    P-deg1 (every ball at predicted degree >= 14 decides within the wall): '
                  f'{len(hi)} such balls, {len(u)} undecided -> {"WON so far" if not u else "LOST"}')


if __name__ == '__main__':
    main(sys.argv[1:] or ['1c'])
