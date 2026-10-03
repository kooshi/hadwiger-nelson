#!/usr/bin/env python3
"""X2 stage 4a: grokkings (item 4) and GROKKING-INSTANCES (item 5)."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    return s
def sub(C,old,new):
    assert C.count(old)==1,(C.count(old),old[:60]); return C.replace(old,new)
Z1=open(R+'plans/FS121-Z1-close.md').read(); Z2=open(R+'plans/FS116-Z2-close.md').read()
D4=Z1[Z1.index('### D4. Grokkings'):Z1.index('### D5. `BIBLIOGRAPHY.md`')]
D3=Z2[Z2.index('### D3. Grokkings'):Z2.index('### D4. `BIBLIOGRAPHY.md`')]
def entry(txt,g):
    m=re.search(r'^\* \*\*'+g+r' —.*?(?=\n\n|\n\* \*\*G|\n\*\*A rewrite|\n\*\*Instances)',txt,re.S|re.M)
    assert m,g; return num(m.group(0))
ents=[entry(D4,'G88'),entry(D4,'G89'),entry(D4,'G90'),entry(D3,'G91')]
# the end of G90's bullet must include its 'it refutes ...' closing
for e in ents: assert e.rstrip().endswith('*') or e.rstrip().endswith('.'),e[-80:]
rew=re.search(r'\*\*A rewrite of G85\'s last sentence\*\* \("(.*?)"\): "(.*?)"\n',D4,re.S)
old_s,new_s=rew.group(1),rew.group(2).replace('\n',' ')
S=R+'.claude/skills/grokkings/SKILL.md'
C=open(S).read()
C=sub(C,old_s,new_s)
lines=C.split('\n')
k=[i for i,l in enumerate(lines) if l.startswith('* **G51 — A competitor')]
assert len(k)==1
lines[k[0]:k[0]]=sum([e.split('\n') for e in ents],[])
open(S,'w').write('\n'.join(lines))
# ---- instances
F=R+'plans/GROKKING-INSTANCES.md'
T=open(F).read()
def inst(txt,start):
    m=re.search(r'^- '+re.escape(start)+r'.*?(?=\n- \*|\n- \*\*|\n\n|\Z)',txt,re.S|re.M); assert m,start
    return num(m.group(0)[2:])
i67=inst(D4,'*§G67'); i21a=inst(D4,'*§G21')
i21b=inst(D3,'**§ G21**'); i83=inst(D3,'**§ G83**'); i84=inst(D3,'**§ G84**'); i82=inst(D3,'**§ G82**'); i87=inst(D3,'**§ G87**'); icp=inst(D3,'**§ `CLAUDE.md` § Counter-priors**')
def flat(t): return re.sub(r'\s*\n\s*',' ',t.strip())
def block(label,i):
    m=re.match(r'(\*\*§ [^*]*\*\*|\*§G\d+ \(([^)]*)\):\*)\s*(.*)',i,re.S)
    tag,desc,b=m.group(1),m.group(2),m.group(3)
    b=flat(b)
    if desc is None:
        mm=re.match(r'\((.*?)\):\s*(.*)',b,re.S); assert mm,b[:80]
        src=mm.group(1); src=re.sub(r'^a new section; ','',src); rest=mm.group(2)
        return '*%s, %s:*\n\n%s\n'%(label,src,rest)
    return '*%s (%s):*\n\n%s\n'%(label,desc,b)
def sec_end(T,head):
    s=T.index(head); m=re.search(r'\n## ',T[s+len(head):]); return s+len(head)+(m.start() if m else len(T)-s-len(head))
def append(T,head,txt):
    e=sec_end(T,head); return T[:e].rstrip('\n')+'\n\n'+txt+'\n'+T[e:]
T=append(T,'## G21 — A negative measures its enumeration',block('FS121-Z1, FS-121\'s close; `plans/FS121-Z1-close.md` D4',i21a)+'\n'+block('FS116-Z2, FS-116\'s close; `plans/FS116-Z2-close.md` D3',i21b))
T=append(T,'## G67 — A grokking is grokked by its form',block('FS121-Z1, FS-121\'s close; `plans/FS121-Z1-close.md` D4',i67))
new=''
for g,title,i in [('G82','The measurable question is a stability question',i82),('G83','With unit arcs, the tight question lives at one four-colour vertex',i83),('G84','Contact is the regularity mechanism',i84),('G87','The invention signal',i87)]:
    new+='## %s — %s\n\n%s\n'%(g,title,block('FS116-Z2, FS-116\'s close; `plans/FS116-Z2-close.md` D3',i))
new+='## `CLAUDE.md` § Counter-priors\n\n%s\n'%block('FS116-Z2, FS-116\'s close; `plans/FS116-Z2-close.md` D3',icp)
h='## `CLAUDE.md` § Delegation — one level deep'
assert T.count(h)==1
T=T.replace(h,new+h)
open(F,'w').write(T)
print('ok',[len(e) for e in ents])
