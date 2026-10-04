import re
root='/home/kooshi/source/lean-dir-fs129-close/'
rd=lambda p: open(root+p,encoding='utf-8').read()
z=rd('plans/FS129-Z2-record.md').split('\n')
def quote_after(start_pat, lines):
    """collect blockquote lines (stripping '> ') following the first line matching start_pat"""
    i=[k for k,l in enumerate(lines) if re.search(start_pat,l)]
    assert len(i)==1,(start_pat,i)
    k=i[0]+1
    while not lines[k].startswith('>'): k+=1
    out=[]
    while k<len(lines) and lines[k].startswith('>'):
        out.append(lines[k][2:] if lines[k].startswith('> ') else lines[k][1:]); k+=1
    return '\n'.join(out)
u1=quote_after(r'^\*\*1\. The "Last updated" line',z)
u2=quote_after(r'^\*\*2\. The open-milestones line',z)
u3=quote_after(r'^\*\*3\. Item 31',z)
C=rd('CLAUDE.md')
def rep(old,new):
    global C
    assert C.count(old)==1,(old[:60],C.count(old))
    C=C.replace(old,new)
# unit 1
a=C.index('Last filed: **FS-116,'); b=C.index("and git.*",a)+len("and git.*")
C=C[:a]+u1+C[b:]
# unit 2 (+ ruled merge)
u2=re.sub(r"then the top of FS129-P1's\s+ranking\.",lambda m:"then the top of the ranking, FS-124, the (Q) ring (its question posed in `plans/STUB-q-ring.md`).",u2)
assert 'FS-124, the (Q) ring (its question' in u2
a=C.index('is Opened (`plans/FS129-cross'); b=C.index('then the top of the ranking.',a)+len('then the top of the ranking.')
C=C[:a]+u2+C[b:]
# unit 3
a=C.index('31. **The regularity wall, verified;'); end='now a case list (FS-123–FS-125).'; b=C.index(end,a)+len(end)
C=C[:a]+u3+C[b:]
# theory sentence
rep("two minds).\n",'two minds).\n') if False else None
old="(row 148, G91; [hand], two minds)."
new="(row 148, G91; [hand], two minds), and one whose ring carries\nno (Q) arc in the non-Siamese class, simple or not (row 149; [hand], one mind)."
rep(old,new)
# programme paragraph, ruled merges
rep("**FS-123,\nthe (Q)-free ring**","**FS-123, the Siamese class**")
rep("**FS-128, the six-colour rungs**","**FS-128, the top colour, at five and six**")
rep("**FS-120, the pinch at a junction**","**FS-120, the pinch at a junction, and the cover route at five**")
rep("**Rows 1–148 live in `LEDGER.md`**","**Rows 1–154 live in `LEDGER.md`**")
# top three table
p=rd('plans/POROS-2026-10-03-fs129-rerank.md').split('\n')
i=[k for k,l in enumerate(p) if l.startswith('**The top three, as `CLAUDE.md`')]; assert len(i)==1
k=i[0]+1
while not p[k].startswith('| 1 |'): k+=1
rows=[]
while p[k].startswith('|'): rows.append(p[k]); k+=1
assert len(rows)==3
CL=C.split('\n')
idx=[k for k,l in enumerate(CL) if re.match(r'\| [123] \| \*\*FS-(123|124|104)',l)]
assert len(idx)==3 and idx==[idx[0],idx[0]+1,idx[0]+2],idx
CL[idx[0]:idx[0]+3]=rows
C='\n'.join(CL)
open(root+'CLAUDE.md','w',encoding='utf-8').write(C)
