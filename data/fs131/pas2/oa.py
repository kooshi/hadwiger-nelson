"""FS131-PAS2: OpenAlex lookups, logged.  usage: oa.py TAG cites W123 | oa.py TAG doi 10.x/y | oa.py TAG search 'words'
cites: every work citing W (all pages); doi: the work's record; search: title/abstract search (first 50)."""
import json, sys, subprocess, pathlib, datetime
tag, mode, arg = sys.argv[1], sys.argv[2], sys.argv[3]
def get(url):
    out = subprocess.run(['curl', '-s', '-m', '90', url], capture_output=True, text=True)
    return json.loads(out.stdout)
hits, tot = [], None
if mode == 'doi':
    d = get(f'https://api.openalex.org/works/doi:{arg}')
    hits = [d]; tot = 1
elif mode == 'cites':
    cur = '*'
    while cur:
        d = get(f'https://api.openalex.org/works?filter=cites:{arg}&per-page=200&cursor={cur}')
        tot = d['meta']['count']; hits += d['results']; cur = d['meta'].get('next_cursor')
        if not d['results']: break
elif mode == 'search':
    import urllib.parse
    d = get('https://api.openalex.org/works?per-page=50&search=' + urllib.parse.quote(arg))
    tot = d['meta']['count']; hits = d['results']
slim = [dict(id=h.get('id'), doi=h.get('doi'), year=h.get('publication_year'), title=h.get('title'),
             authors=[a['author']['display_name'] for a in h.get('authorships', [])],
             venue=((h.get('primary_location') or {}).get('source') or {}).get('display_name'),
             cited_by=h.get('cited_by_count'), oa=(h.get('open_access') or {}).get('oa_url')) for h in hits]
with pathlib.Path(__file__).with_name('queries.jsonl').open('a') as f:
    f.write(json.dumps(dict(db='OpenAlex', tag=tag, mode=mode, q=arg, total=tot,
                            when=datetime.datetime.now(datetime.UTC).isoformat(timespec='seconds'), hits=slim), ensure_ascii=False) + '\n')
print(f'[{tag}] OpenAlex {mode} {arg!r}: {tot}')
for h in slim:
    print(f"  {h['year']} {'; '.join(a.split()[-1] for a in h['authors'])[:40]} | {(h['title'] or '')[:100]} | {(h['venue'] or '')[:40]} | {h['id'].rsplit('/',1)[-1]}")
