"""FS131-PAS2: one arXiv API query, logged.  usage: ax.py TAG 'search_query' [N] [abslen]"""
import sys, subprocess, pathlib, json, datetime, re, xml.etree.ElementTree as ET
tag, q = sys.argv[1], sys.argv[2]
n = int(sys.argv[3]) if len(sys.argv) > 3 else 50
al = int(sys.argv[4]) if len(sys.argv) > 4 else 0
out = subprocess.run(['curl', '-s', '-G', 'https://export.arxiv.org/api/query', '--data-urlencode', f'search_query={q}',
                      '--data-urlencode', f'max_results={n}'], capture_output=True, text=True, timeout=120)
ns = {'a': 'http://www.w3.org/2005/Atom', 'o': 'http://a9.com/-/spec/opensearch/1.1/'}
root = ET.fromstring(out.stdout)
tot = root.find('o:totalResults', ns).text
hits = []
for e in root.findall('a:entry', ns):
    hits.append(dict(id=e.find('a:id', ns).text.rsplit('/abs/', 1)[-1], date=e.find('a:published', ns).text[:10],
                     title=re.sub(r'\s+', ' ', e.find('a:title', ns).text), authors=[a.find('a:name', ns).text for a in e.findall('a:author', ns)],
                     abstract=re.sub(r'\s+', ' ', e.find('a:summary', ns).text)))
with pathlib.Path(__file__).with_name('queries.jsonl').open('a') as f:
    f.write(json.dumps(dict(db='arXiv', tag=tag, q=q, total=tot, when=datetime.datetime.now(datetime.UTC).isoformat(timespec='seconds'), hits=hits), ensure_ascii=False) + '\n')
print(f'[{tag}] ax {q!r}: {tot} hits')
for h in hits:
    print(f"  {h['id']} {h['date']} {'; '.join(a.split()[-1] for a in h['authors'])[:40]} | {h['title'][:110]}")
    if al: print('     ', h['abstract'][:al])
