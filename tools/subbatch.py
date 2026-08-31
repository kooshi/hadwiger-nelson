#!/usr/bin/env python3
"""The sub-batch curve: how many classes survive putting floor edges BACK.

A class list for batch B (the object minus B) contains, for any sub-batch B' ⊆ B, exactly the
classes of B' as the lines proper on the put-back edges B ∖ B' (the WO-8 filter — no solving).
Only FLOOR edges may be put back: the batch's `removed` part is already replaced by halos.

Reads either an assembled list (header JSON + one digit string per line; Python or Rust) or a
Rust journal (`enumerate.jsonl`, `{"class": "<digits>"}` records — PARTIAL until the run says
exact, and this tool says so). Per class it keeps one bit per floor edge ("proper on it"), so a
million classes cost 8 MB, and the greedy curve is numpy popcounts.

  python3 tools/subbatch.py --list <file> --floor build/m51-floor-it4.txt [--putback u-v,...]
"""
import argparse, json, sys, time
import numpy as np

def parse_floor(s):
    return [tuple(int(x) for x in e.split('-')) for e in s.strip().split(',') if e]

def load_masks(path, floor):
    """One uint64 per class: bit i set iff the class is proper on floor edge i."""
    us = np.array([u for u, _ in floor]); vs = np.array([v for _, v in floor])
    masks = []; header = None; n = 0; t0 = time.time()
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if line[0] == '{':
                r = json.loads(line)
                if 'class' in r: col = r['class']
                elif r.get('kind') == 'enumeration-header': header = r; continue
                else: continue
            else:
                col = json.loads(line)
            b = np.frombuffer(col.encode(), dtype=np.uint8)
            bits = (b[us] != b[vs])
            packed = np.packbits(bits, bitorder='little').astype(np.uint64)
            masks.append(int(packed @ (np.uint64(1) << (np.uint64(8) * np.arange(len(packed), dtype=np.uint64)))))
            n += 1
            if n % 200000 == 0: print(f'  read {n} classes, {time.time()-t0:.0f}s', file=sys.stderr)
    return header, np.array(masks, dtype=np.uint64)

def survivors(masks, putback_bits):
    """Classes proper on every put-back edge."""
    pb = np.uint64(putback_bits)
    return int(np.count_nonzero((masks & pb) == pb))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--list', required=True); ap.add_argument('--floor', required=True)
    ap.add_argument('--putback', default='', help='evaluate this put-back set instead of the greedy curve')
    ap.add_argument('--target', type=int, default=0, help='stop the greedy curve at this many survivors')
    a = ap.parse_args()
    floor = parse_floor(open(a.floor).read())
    header, masks = load_masks(a.list, floor)
    N = len(masks)
    print(f'list {a.list}: {N} classes; floor {len(floor)} edges; '
          f'{"header " + header.get("stage_fingerprint", "?") if header else "JOURNAL (partial unless the run reported exact)"}')
    if a.putback:
        pb = sum(1 << floor.index(e) for e in parse_floor(a.putback))
        print(f'put back {a.putback}: {survivors(masks, pb)} classes survive')
        return
    # per-edge: classes proper on it alone (what putting it back keeps)
    single = [(survivors(masks, 1 << i), floor[i]) for i in range(len(floor))]
    print('per floor edge, classes kept if it alone is put back (fewest first):')
    for c, e in sorted(single)[:10]: print(f'  {e[0]}-{e[1]}: {c} ({100*c/N:.1f}%)')
    # greedy: put back the edge that leaves the fewest survivors
    pb = 0; chosen = []
    print('greedy put-back curve (k, edge, survivors, cheats still removed this iteration):')
    print(f'  0  -            {N}  {len(floor)}')
    for k in range(1, len(floor) + 1):
        best = min((survivors(masks, pb | (1 << i)), i) for i in range(len(floor)) if not pb >> i & 1)
        pb |= 1 << best[1]; chosen.append(floor[best[1]])
        print(f'  {k}  {floor[best[1]][0]}-{floor[best[1]][1]}  {best[0]}  {len(floor)-k}')
        if a.target and best[0] <= a.target:
            print('put-back set:', ','.join(f'{u}-{v}' for u, v in chosen)); break

if __name__ == '__main__':
    main()
