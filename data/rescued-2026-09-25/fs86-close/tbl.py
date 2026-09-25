import re
p='CLAUDE.md'
s=open(p,encoding='utf-8').read()
lines=s.split('\n')
i0=[k for k,l in enumerate(lines) if l.startswith('| rank | stub |')][0]
def cut(t, n):
    t=t.strip()
    if len(t)<=n: return t
    # cut at a sentence/clause boundary before n
    best=-1
    for m in re.finditer(r'(\. |; | — |\? )',t):
        if m.start()<=n and m.start()>40: best=m.start()+ (1 if m.group(1).startswith('?') else 0)
    if best<0: return t
    out=t[:best].rstrip(' ;—.')
    # balance backticks and bold
    if out.count('`')%2: out+='`'
    if out.count('**')%2: out+='**'
    return out+(' …' )
k=i0+2; saved=0
while lines[k].startswith('|'):
    l=lines[k]
    m=re.match(r'^\| (\d+)(?:–\d+)? \|',l)
    r=int(m.group(1))
    if r==1:
        cells=l.split(' | ')
        # cells[0]='| r', cells[1]=stub, cells[2]=question, cells[3]=bearing ending with ' |'
        if len(cells)==4:
            q=cut(cells[2],560); b=cut(cells[3].rstrip(" |"),330)
            nl=' | '.join([cells[0],cells[1],q,b])+' |'
            saved+=len(l.encode())-len(nl.encode()); lines[k]=nl
        else:
            print('skip',r,len(cells))
    k+=1
open(p,'w',encoding='utf-8').write('\n'.join(lines))
print('saved',saved)
