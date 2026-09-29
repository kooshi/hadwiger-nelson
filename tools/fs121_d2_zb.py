#!/usr/bin/env python3
"""FS121-D2 prior-art queries: zbMATH Open API. Usage: fs121_d2_zb.py <queries.tsv> [--plant]
queries.tsv: tag<TAB>search_string. Each result is saved to data/fs121/d2/zb/<tag>.json and summarised (count; first 12 titles).
Positive control first, always: an:0933.52003 (Walther 1999) must return exactly 1 hit and a nonsense title 0, else exit 2,
so that a zero below can never be an API that answered nothing. --plant replaces the control's id by a nonexistent one and must exit 2."""
import json, sys, subprocess, pathlib, urllib.parse, time
ROOT = pathlib.Path(__file__).resolve().parent.parent
OUT = ROOT / 'data/fs121/d2/zb'; OUT.mkdir(parents=True, exist_ok=True)
def q(s, n=100):
    url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': s, 'results_per_page': n})
    for attempt in range(4):
        r = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, text=True)
        if r.returncode == 0 and r.stdout.strip():
            try: return json.loads(r.stdout)
            except json.JSONDecodeError: pass
        time.sleep(5 * (attempt + 1))
    raise SystemExit(f'EMPTY, NON-JSON OR FAILED RESPONSE after 4 tries on {s!r}')
def count(d):
    v = (d.get('status') or {}).get('nr_total_results')
    return v if v is not None else len(d.get('result') or [])
def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    ctl = 'an:0000.00000' if '--plant' in sys.argv else 'an:0933.52003'
    c1, c0 = count(q(ctl)), count(q('ti:"zzqxw qqzzv unitdistance"'))
    print(f'control: {ctl} -> {c1} (want 1); nonsense -> {c0} (want 0)')
    if c1 != 1 or c0 != 0: print('CONTROL FAILED'); sys.exit(2)
    if not args: print('NO QUERIES'); sys.exit(2)
    for line in open(args[0], encoding='utf-8'):
        if not line.strip() or line.startswith('#'): continue
        tag, s = line.rstrip('\n').split('\t', 1)
        d = q(s); (OUT / f'{tag}.json').write_text(json.dumps(d, ensure_ascii=False))
        print(f'\n[{tag}] {s}  => {count(d)}')
        for it in (d.get('result') or [])[:12]:
            ti = (it.get('title') or {}).get('title', '?'); yr = it.get('year', '?'); an = it.get('identifier', '?')
            au = '; '.join(a.get('name', '?') for a in (it.get('contributors') or {}).get('authors', [])[:3])
            print(f'  {yr} {an} {au}: {ti[:110]}')
main()
