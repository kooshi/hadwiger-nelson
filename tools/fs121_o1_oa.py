#!/usr/bin/env python3
"""FS121-O1 §PA items 5-7: OpenAlex citing works of given arXiv papers (by DOI 10.48550/arXiv.<id>, and by title search).
Positive control: KMOR2016 (arXiv:1501.00168) must have >= 5 citing works, else exit 2. Saves data/fs121/o1/oa/<tag>.json."""
import json, sys, subprocess, urllib.parse, pathlib, time
ROOT = pathlib.Path(__file__).resolve().parent.parent; OUT = ROOT / 'data/fs121/o1/oa'; OUT.mkdir(parents=True, exist_ok=True)
def get(url):
    for a in range(4):
        r = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, text=True)
        try: return json.loads(r.stdout)
        except Exception: time.sleep(4 * (a + 1))
    raise SystemExit(f'FAILED: {url}')
def work_by_title(t):
    d = get('https://api.openalex.org/works?' + urllib.parse.urlencode({'search': t, 'per-page': 5}))
    return [(w['id'], w.get('display_name'), w.get('cited_by_count'), (w.get('ids') or {}).get('doi')) for w in d.get('results', [])]
def citing(wid):
    d = get('https://api.openalex.org/works?' + urllib.parse.urlencode({'filter': f'cites:{wid.split("/")[-1]}', 'per-page': 50}))
    return d.get('meta', {}).get('count'), [(w.get('publication_year'), w.get('display_name'), (w.get('ids') or {}).get('doi')) for w in d.get('results', [])]
papers = [a.split('=', 1) for a in sys.argv[1:] if '=' in a]
ctl = work_by_title('Better bounds for planar sets avoiding unit distances')
n, _ = citing(ctl[0][0]); print(f'control KMOR2016 {ctl[0][0]} citing={n} (want >=5)')
if '--plant' in sys.argv: n = 0
if not n or n < 5: print('CONTROL FAILED'); sys.exit(2)
for tag, title in papers:
    hits = work_by_title(title); print(f'\n[{tag}] search "{title}": ' + ' | '.join(f'{h[0].split("/")[-1]} "{(h[1] or "")[:60]}" cb={h[2]}' for h in hits[:3]))
    allc = {}
    for h in hits[:3]:
        if h[1] and title.lower()[:30] in h[1].lower():
            c, lst = citing(h[0]); allc[h[0]] = lst; print(f'  {h[0].split("/")[-1]} citing={c}')
            for y, t, doi in lst: print(f'    {y} {(t or "")[:120]} {doi or ""}')
    (OUT / f'{tag}.json').write_text(json.dumps({'hits': hits, 'citing': allc}, ensure_ascii=False))
