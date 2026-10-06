#!/usr/bin/env python3
"""Which earlier waves does each wave's formalize rows rest on? Read from plans/LEAN-BACKLOG.md's
<!--row ID--> / <!--needs ...--> tags and data/fs131/k1/dispositions.csv (extra_upstream, merges, replacements).
Usage: python3 data/fs131/briefs/scripts/wave-deps.py [wave ...]   (default 6 7 8 9 10)"""
import csv,re,collections,sys
ROOT="/home/kooshi/source/lean-dir/"
text=open(ROOT+"plans/LEAN-BACKLOG.md").read()
needs={}; cur=None
for m in re.finditer(r"<!--(row|needs) ([^>]*?)-->",text):
    kind,body=m.group(1),m.group(2).strip()
    if kind=="row": cur=body.split()[0]; needs.setdefault(cur,[])
    elif cur: needs[cur]+=[t for t in re.split(r"[;,\s]+",body) if t]
rows={r['id']:r for r in csv.DictReader(open(ROOT+"data/fs131/k1/dispositions.csv"))}
def wave(u,seen=()):
    r=rows.get(u)
    if not r or u in seen: return None
    d=r['disposition']
    if d=="formalize": return int(r['wave'])
    if d=="merged into": return max((wave(t,seen+(u,)) or 0) for t in r['merged_into'].split(";"))
    if d=="excluded" and r['replacement'].strip(): return max((wave(t.strip(),seen+(u,)) or 0) for t in r['replacement'].split(";"))
    return 0
for N in [int(a) for a in sys.argv[1:]] or [6,7,8,9,10]:
    c=collections.Counter(); ex=collections.defaultdict(set)
    for i,r in rows.items():
        if r['disposition']=="formalize" and int(r['wave'])==N:
            for u in needs.get(i,[])+[t for t in re.split(r"[;,\s]+",r['extra_upstream']) if t]:
                wv=wave(u)
                if wv is not None and wv!=N: c[wv]+=1; ex[wv].add(i+" <- "+u)
    print("wave",N,"upstream edges by wave:",dict(sorted(c.items())))
    for wv in sorted(ex):
        if wv>=6: print("   from wave",wv,":",sorted(ex[wv]))
