#!/usr/bin/env python3
"""J30 stage 4: reverse index — older items (stubs FS-NN, ledger rows, grokkings, FS89 entries, earlier derivation ids) -> crunch files and lines.
Re-grokking walks (the three plans' §G.1/§G.2 sections) are excluded from row/grokking mentions, since they name every entry by design."""
import re, os, glob, collections, json, sys
R="/home/kooshi/source/lean-dir"; os.chdir(R)
files=sorted(set(glob.glob("plans/FS91-*.md")+glob.glob("plans/M2-*.md")+glob.glob("plans/M3-*.md")+glob.glob("data/crunch-2026-09-25/reports/J*.md")))
files=[f for f in files if "close-inventory" not in f and not f.endswith("J30.md")]
PLANS={"plans/FS91-character-local-global.md","plans/M2-kernel-lane.md","plans/M3-exotic-colourings.md"}
def walk_ranges(f,lines):
    # a re-grokking walk section: a heading naming G.1, G.2 or G.3 (the grokkings, rows, method rules), up to the next heading
    rng=[];start=None
    for i,l in enumerate(lines,1):
        if re.match(r"^#{2,4} ",l):
            if start: rng.append((start,i)); start=None
            if re.search(r"(^#{2,4} *§?G\.[123]\b)|(§G\.[123]\b)",l): start=i
    if start: rng.append((start,len(lines)+1))
    return rng
idx=collections.defaultdict(lambda: collections.defaultdict(list))
pat={"stub":re.compile(r"\bFS-(\d+)\b"),"row":re.compile(r"\brows? (\d+)(?:\s*[–-]\s*(\d+))?"),
     "grok":re.compile(r"\bG(\d{1,2})\b"),"fs89":re.compile(r"\b(FS89-[A-Za-z0-9]+(?:-[A-Za-z0-9]+)?)\b"),
     "deriv":re.compile(r"\b(FS(?:[1-8]\d)-(?:[A-Za-z]+\d*[A-Za-z]*(?:-[A-Za-z0-9]+)?))\b")}
for f in files:
    lines=open(f,encoding="utf-8").read().split("\n")
    rng=walk_ranges(f,lines) if f in PLANS else []
    isreport=f.startswith("data/")
    for i,l in enumerate(lines,1):
        inwalk=any(a<=i<b for a,b in rng)
        if isreport and re.match(r"^bears — ",l): inwalk=True
        for m in pat["stub"].finditer(l):
            idx["FS-"+m.group(1)][f].append(i)
        if not inwalk:
            for m in pat["row"].finditer(l):
                a=int(m.group(1)); b=int(m.group(2)) if m.group(2) else a
                pre=l[max(0,m.start()-12):m.start()]
                if "§" in pre or "item" in pre or re.search(r"\bQ\d",pre): continue
                if 11<=a<=97 and b<=97 and b-a<=6:
                    for r in range(a,b+1): idx[f"row {r}"][f].append(i)
            for m in re.finditer(r"\bR([1-9]\d)\b",l):
                r=int(m.group(1))
                if 11<=r<=97: idx[f"row {r}"][f].append(i)
            if re.search(r"S0A|gluing|G0|G1–G3|G0–G3",l): continue
            for m in pat["grok"].finditer(l):
                g=int(m.group(1))
                if 1<=g<=76: idx[f"G{g}"][f].append(i)
        for m in pat["fs89"].finditer(l): idx[m.group(1)][f].append(i)
        for m in pat["deriv"].finditer(l):
            if not m.group(1).startswith("FS89-") and not m.group(1).startswith("FS91-"): idx[m.group(1)][f].append(i)
out={k:{f:sorted(set(v)) for f,v in d.items()} for k,d in idx.items()}
json.dump(out,open("/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/j30/reverse.json","w"),ensure_ascii=False,indent=0)
kinds=collections.Counter(("stub" if k.startswith("FS-") else "row" if k.startswith("row") else "grok" if re.match(r"G\d",k) else "fs89" if k.startswith("FS89") else "deriv") for k in out)
print(len(files), kinds)
