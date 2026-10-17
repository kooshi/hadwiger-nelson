"""FS131-PAS2: Semantic Scholar lookups, logged.  usage: s2.py TAG search 'words' | s2.py TAG cites <paperId or DOI:x>"""
import json, sys, subprocess, pathlib, datetime, urllib.parse, time
tag, mode, arg = sys.argv[1], sys.argv[2], sys.argv[3]
def get(url):
    for _ in range(4):
        out = subprocess.run(['curl', '-s', '-m', '90', url], capture_output=True, text=True)
        try:
            d = json.loads(out.stdout)
        except Exception:
            d = {}
        if d.get('code') == '429' or 'message' in d and 'Too Many' in str(d.get('message')):
            time.sleep(5); continue
        return d
    return d
if mode == 'search':
    d = get('https://api.semanticscholar.org/graph/v1/paper/search?limit=40&fields=title,year,authors,venue,externalIds&query=' + urllib.parse.quote(arg))
    tot, hits = d.get('total'), d.get('data') or []
else:
    d = get(f'https://api.semanticscholar.org/graph/v1/paper/{arg}/citations?limit=500&fields=title,year,authors,venue,externalIds')
    hits = [c['citingPaper'] for c in d.get('data') or []]; tot = len(hits)
slim = [dict(year=h.get('year'), title=h.get('title'), authors=[a['name'] for a in h.get('authors') or []], venue=h.get('venue'), ids=h.get('externalIds')) for h in hits]
with pathlib.Path(__file__).with_name('queries.jsonl').open('a') as f:
    f.write(json.dumps(dict(db='SemanticScholar', tag=tag, mode=mode, q=arg, total=tot, raw_error=None if hits or tot == 0 else str(d)[:300],
                            when=datetime.datetime.now(datetime.UTC).isoformat(timespec='seconds'), hits=slim), ensure_ascii=False) + '\n')
print(f'[{tag}] S2 {mode} {arg!r}: {tot}', '' if hits or tot == 0 else str(d)[:200])
for h in slim:
    print(f"  {h['year']} {'; '.join(a.split()[-1] for a in h['authors'])[:40]} | {(h['title'] or '')[:100]} | {(h['venue'] or '')[:30]}")
