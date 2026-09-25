# greedy minimisation of an EMPTY sub-configuration: drop a ± pair whenever Θ stays empty (my finder decides; my checker re-checks the end)
import json, subprocess, sys
S, start, out = sys.argv[1], sys.argv[2], sys.argv[3]
cur = json.load(open(start))
KEY = "420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2"
def verdict(units, tag):
    f = f'{S}/greedy-{tag}.json'
    json.dump(units, open(f, 'w'))
    try:
        r = subprocess.run(['python3', 'tools/fs73v2_xbb.py', '167', KEY, f'{S}/greedy-{tag}-cert.json', '--units-file', f,
                            '--log-every', '10000000'], capture_output=True, text=True, timeout=120)
    except subprocess.TimeoutExpired:
        return 'TIMEOUT'
    last = r.stdout.strip().split('\n')[-1]
    return 'EMPTY' if last.startswith('EMPTY') else ('NONEMPTY' if last.startswith('NONEMPTY') else 'ERR:' + last + r.stderr[-300:])
assert verdict(cur, 'start') == 'EMPTY'
i = 0
while i < len(cur):
    trial = cur[:i] + cur[i+1:]
    v = verdict(trial, 'trial')
    print(len(cur), 'drop', cur[i], '->', v, flush=True)
    if v == 'EMPTY':
        cur = trial
    else:
        i += 1
json.dump(cur, open(out, 'w'))
print('MINIMAL (greedy):', len(cur), 'pairs:', cur, flush=True)
print(verdict(cur, 'final'))
