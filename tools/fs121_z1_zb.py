#!/usr/bin/env python3
"""FS121-Z1 (the close): zbMATH Open API searches for the prior-art debt of inventory item 68 (FS121-D4's lemmas).
Usage: fs121_z1_zb.py <queries.tsv> [--plant]. queries.tsv: tag<TAB>search_string; each result is saved to
data/fs121/fs121-z1/zb/<tag>.json and summarised (count; up to 8 titles with year, Zbl id, review or author summary).
Positive control first: an:0933.52003 (Walther 1999) must return exactly 1 hit and a nonsense string 0, else exit 2,
so that a zero below can never be an API that answered nothing. --plant swaps the control's id for a nonexistent one
and must exit 2."""
import json, pathlib, subprocess, sys, time, urllib.parse
ROOT = pathlib.Path(__file__).resolve().parent.parent
OUT = ROOT / 'data/fs121/fs121-z1/zb'
def q(s, n=100):
    url = 'https://api.zbmath.org/v1/document/_search?' + urllib.parse.urlencode({'search_string': s, 'results_per_page': n})
    for attempt in range(4):
        r = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, text=True)
        if r.returncode == 0 and r.stdout.strip():
            try: return json.loads(r.stdout)
            except json.JSONDecodeError: pass
        time.sleep(5 * (attempt + 1))
    raise SystemExit(f'FAILED RESPONSE on {s!r}')
def count(d):
    v = (d.get('status') or {}).get('nr_total_results')
    return v if v is not None else len(d.get('result') or [])
def main():
    plant = '--plant' in sys.argv
    ctl = q('an:0000.00000' if plant else 'an:0933.52003'); nil = q('ti:"qqzxv blorptangle frumious"')
    if count(ctl) != 1 or count(nil) != 0:
        print(f'CONTROL FAILED: id -> {count(ctl)} (want 1), nonsense -> {count(nil)} (want 0)'); sys.exit(2)
    print('control: an:0933.52003 -> 1, nonsense -> 0')
    OUT.mkdir(parents=True, exist_ok=True)
    for line in pathlib.Path(sys.argv[1]).read_text().splitlines():
        if not line.strip() or line.startswith('#'): continue
        tag, s = line.split('\t', 1); d = q(s); (OUT / f'{tag}.json').write_text(json.dumps(d))
        print(f'{tag}\t{count(d)}\t{s}')
        for x in (d.get('result') or [])[:8]:
            t = ((x.get('title') or {}).get('title') or '')[:110]; y = (x.get('year') or '')
            zbl = (x.get('identifier') or ''); kind = 'review' if (x.get('editorial_contributions') or [{}])[0].get('contribution_type') == 'review' else 'summary/other'
            print(f'   {y} {zbl} [{kind}] {t}')
main()
