#!/usr/bin/env python3
"""X2 stage 3: CLAUDE.md. Every replacement's old text must occur exactly once."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    assert '‹' not in s; return s
Z=open(R+'plans/FS116-Z2-close.md').read()
D2=Z[Z.index('### D2. `CLAUDE.md`'):Z.index('### D3. Grokkings')]
blocks=re.findall(r'\*Replaces \((\d+) bytes\):\*\n\n```\n(.*?)\n```\n\n\*With \((\d+) bytes\):\*\n\n```\n(.*?)\n```',D2,re.S)
assert len(blocks)==7,len(blocks)
C=open(R+'CLAUDE.md').read()
pairs=[]
for ob,old,nb,new in blocks:
    assert abs(len(old.encode())-int(ob))<=3,(ob,len(old.encode()))  # drafts' counts include a trailing newline
    pairs.append((old,new))
def sub(C,old,new):
    assert C.count(old)==1,(C.count(old),old[:60]); return C.replace(old,new)
for old,new in pairs:
    new=num(new).replace("(the cover route parked behind FS-116)","(the cover route parked behind FS-125's NO-SAT)")
    C=sub(C,old,new)
# FS-121's D2 programme-line replacement, on top of FS-116's unit 3 (coordinator's ruling)
C=sub(C,"**FS-121, the map step**, **FS-122","**FS-121, the map step — closed** (rows 142–144); its successors **FS-126, curved pencils**, **FS-127, lateral extent**, **FS-128, the six-colour rungs**, **FS-122")
# Poros: Next clause
P=open(R+'plans/POROS-2026-10-03-close-reread.md').read()
i=P.index('Replace that clause with:')
nxt=[l for l in P[i:].split('\n') if l.startswith('**Next**, in Kooshi')][0]
C=sub(C,"**Next:** Poros's re-rank (`plans/FRONTIER-STUBS.md`);",num(nxt))
# Poros: table rows
j=P.index('## Draft for CLAUDE.md § Paths forward')
seg=P[j:].split('\n')
hi=[k for k,l in enumerate(seg) if l.startswith('| rank | stub')][0]
rows=[]
for l in seg[hi+2:]:
    if not l.startswith('| '): break
    rows.append(l)
assert len(rows)==11 and rows[-1].startswith('| 11–73 |')
lines=C.split('\n')
a=[k for k,l in enumerate(lines) if l.startswith('| 1 | **FS-116 the local exclusion**')]
b=[k for k,l in enumerate(lines) if l.startswith('| 11–69 |')]
assert len(a)==1 and len(b)==1 and b[0]==a[0]+10
lines[a[0]:b[0]+1]=[num(r) for r in rows]
C='\n'.join(lines)
C=sub(C,'**Rows 1–141 live in `LEDGER.md`**','**Rows 1–148 live in `LEDGER.md`**')
open(R+'CLAUDE.md','w').write(C)
print('ok')
