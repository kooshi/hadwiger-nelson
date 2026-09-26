#!/usr/bin/env python3
"""For every unmatched text file in sweep.tsv: the fraction of its substantive lines (>= 25 chars stripped) found verbatim
in some tracked repository file (HEAD working tree), and the repo file holding the most of them."""
import os, subprocess, collections, sys
S = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad"
R = "/home/kooshi/source/lean-dir"
BIN = {"png","pdf","cnf","gz","npz","npy","pyc","pkl","pack","idx","rev","bz2","drat","lrat","drup","or"}
line2files = collections.defaultdict(set)
for path in subprocess.run(["git","ls-files"],capture_output=True,text=True,cwd=R).stdout.split("\n"):
    if not path or path.startswith("chats-bak/"): continue
    p = os.path.join(R, path)
    try:
        if os.path.getsize(p) > 8*2**20: continue
        with open(p, encoding="utf-8") as fh: txt = fh.read()
    except Exception: continue
    for ln in txt.splitlines():
        s = ln.strip()
        if len(s) >= 25: line2files[s].add(path)
out = []
for row in open(os.path.join(S,"j30","sweep.tsv")):
    f, size, cls, where = row.rstrip("\n").split("\t")
    if cls not in ("unmatched","name-match"): continue
    ext = f.rsplit(".",1)[-1] if "." in os.path.basename(f) else "-"
    if ext in BIN or int(size) > 20*2**20 or "/git/" in f: out.append((f,size,cls,"binary/skip","","")); continue
    try:
        with open(os.path.join(S,f), encoding="utf-8") as fh: lines=[l.strip() for l in fh.read().splitlines()]
    except Exception: out.append((f,size,cls,"nontext","","")); continue
    sub=[l for l in lines if len(l)>=25]
    if not sub: out.append((f,size,cls,"nolines","","")); continue
    hit=[l for l in sub if l in line2files]
    cnt=collections.Counter(p for l in hit for p in line2files[l])
    best=cnt.most_common(1)[0] if cnt else ("",0)
    out.append((f,size,cls,f"{len(hit)}/{len(sub)}",best[0],str(best[1])))
with open(os.path.join(S,"j30","overlap.tsv"),"w") as fh:
    for r in out: fh.write("\t".join(r)+"\n")
print(len(out))
