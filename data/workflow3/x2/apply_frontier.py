#!/usr/bin/env python3
"""X2 stage 4c: item 10, plans/FRONTIER-STUBS.md from Poros's Draft re-rank items 1-4."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    assert '‹' not in s; return s
P=open(R+'plans/POROS-2026-10-03-close-reread.md').read()
d=P[P.index('## Draft re-rank'):P.index('**5. The banner for the demoted stub**')]
# 1 paragraph
m=re.search(r'\*\*1\. The re-rank paragraph\*\*[^\n]*\n\n(\*At FS-116.*?\*)\n\n\*\*2\.',d,re.S); para=m.group(1)
# 2 open milestones paragraph
m=re.search(r'\*\*2\. The open-milestones paragraph\*\*.*?\n\n(\*\*None is open\.\*\*.*?)\n\n\*\*3\.',d,re.S); open_p=num(m.group(1))
# 3 table
tab=d[d.index('**3. The ranked table**'):d.index('**4. The closed list**')]
rows=[l for l in tab.split('\n') if l.startswith('|')]
hdr=rows[0]; assert hdr.startswith('| rank | stub'); assert rows[1].startswith('|---'); rows=rows[2:]
assert len(rows)==73,len(rows)
rt=[l for l in open(R+'data/workflow3/r2/ranked-table.md').read().split('\n') if l.startswith('| ')]
assert rt==rows,'table differs from ranked-table.md'
rows=[num(r) for r in rows]
# 4 closed list
cl=[num(l) for l in d.split('\n') if l.startswith('* **FS-116 the local exclusion**') or l.startswith('* **FS-121 the map step**')]
assert len(cl)==2
cl=[c.replace("the cover route parked behind FS-116)","the cover route parked behind FS-125's NO-SAT)") for c in cl]
assert any("FS-125's NO-SAT" in c for c in cl)
F=R+'plans/FRONTIER-STUBS.md'
lines=open(F).read().split('\n')
# open paragraph
i=[k for k,l in enumerate(lines) if l.startswith('**None is open.** FS-114, the unit-arc question')]; assert len(i)==1
assert lines[i[0]].endswith("Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.")
lines[i[0]]=open_p
# table
h=[k for k,l in enumerate(lines) if l.startswith('| rank | stub | the question | bearing on the answer | cost')]; assert len(h)==1
assert lines[h[0]]==hdr, 'header differs'
a=h[0]+2; b=a
while lines[b].startswith('| '): b+=1
assert b-a==69,(b-a)
lines[a:b]=rows
# paragraph under Ranked stubs
r=[k for k,l in enumerate(lines) if l=='## Ranked stubs']; assert len(r)==1 and lines[r[0]+1]==''
lines[r[0]+2:r[0]+2]=[para,'']
# closed list
c=[k for k,l in enumerate(lines) if l=='## Closed, absorbed and demoted']; assert len(c)==1
assert lines[c[0]+1].startswith('* **FS-114 the unit-arc question**')
lines[c[0]+1:c[0]+1]=cl
open(F,'w').write('\n'.join(lines))
print('ok')
