"""FS131-PAS2: one zbMATH Open API query, logged.  usage: zb.py TAG "search string" [N] [textlen] [page]
Prints hits (Zbl, year, authors, title, source, and the first textlen chars of the review/summary); appends the query, its
total hit count and every returned hit (full text) to queries.jsonl beside this script."""
import json, sys, subprocess, pathlib, datetime, re
tag, q = sys.argv[1], sys.argv[2]
n = int(sys.argv[3]) if len(sys.argv) > 3 else 60
tl = int(sys.argv[4]) if len(sys.argv) > 4 else 0
pg = int(sys.argv[5]) if len(sys.argv) > 5 else 0
out = subprocess.run(['curl', '-s', '-G', 'https://api.zbmath.org/v1/document/_search', '--data-urlencode',
                      f'search_string={q}', '--data-urlencode', f'results_per_page={n}', '--data-urlencode', f'page={pg}'], capture_output=True, text=True, timeout=120)
if out.returncode != 0:
    print('CURL FAILED', out.returncode); sys.exit(2)
try:
    d = json.loads(out.stdout)
except Exception:
    print('NOT JSON:', out.stdout[:300]); sys.exit(2)
st = d.get('status', {})
tot = st.get('nr_total_results')
hits = []
for r in d.get('result') or []:
    txt = ' '.join(c.get('text', '') for c in r.get('editorial_contributions') or [])
    kind = ','.join(c.get('contribution_type', '') for c in r.get('editorial_contributions') or [])
    src = '; '.join(s.get('source', '') for s in r.get('source', {}).get('series', []) or []) if isinstance(r.get('source'), dict) else ''
    src = (r.get('source') or {}).get('source', src) if isinstance(r.get('source'), dict) else src
    hits.append(dict(zbl=r.get('identifier'), id=r.get('id'), year=r.get('year'),
                     authors=[a['name'] for a in r['contributors']['authors']],
                     title=(r.get('title') or {}).get('title'), source=src, kind=kind, text=txt,
                     links=[l.get('identifier') for l in r.get('links') or []]))
log = pathlib.Path(__file__).with_name('queries.jsonl')
with log.open('a') as f:
    f.write(json.dumps(dict(db='zbMATH', tag=tag, q=q, page=pg, total=tot, when=datetime.datetime.now(datetime.UTC).isoformat(timespec='seconds'),
                            hits=hits), ensure_ascii=False) + '\n')
print(f'[{tag}] zb {q!r}: {tot} hits')
for h in hits:
    t = re.sub(r'\s+', ' ', h['title'] or '')[:110]
    print(f"  {h['zbl']} {h['year']} {'; '.join(a.split(',')[0] for a in h['authors'])[:40]} | {t} | {(h['source'] or '')[:50]}")
    if tl and h['text']:
        print('     ', h['kind'], re.sub(r'\s+', ' ', h['text'])[:tl])
