import json, sys
t = sys.argv[1]
best = None
for l in open('/home/kooshi/source/lean-dir/data/fs73/census/K-rows.jsonl'):
    d = json.loads(l)
    if d['key'].startswith(f'force:{t}:R') and str(d.get('verdict', '')).startswith('refused'):
        if best is None or d['R'] < best[0]:
            best = (d['R'], d['key'])
print(best[1] if best else '')
