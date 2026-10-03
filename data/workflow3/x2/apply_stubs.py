#!/usr/bin/env python3
"""X2 stage 4b: items 7, 8, 9 (claims notes, stub banners/bearings/cards, FS111 erratum)."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    assert '‹' not in s; return s
def rd(p): return open(R+p).read()
def wr(p,t): open(R+p,'w').write(t)
def flat(t): return re.sub(r'\s*\n\s*',' ',t.strip())
Z1=rd('plans/FS121-Z1-close.md'); Z2=rd('plans/FS116-Z2-close.md'); P=rd('plans/POROS-2026-10-03-close-reread.md')
def between(t,a,b): i=t.index(a); return t[i:t.index(b,i)]
# ---- item 7: claims
d6=between(Z1,'### D6.','### D7.').split('\n',1)[1].strip()
d5=between(Z2,'### D5.','### D6.').split('\n',1)[1].strip()
for p,body,src in [('data/fs121/claims.md',d6,'`plans/FS121-Z1-close.md` D6'),('data/fs116/claims.md',d5,'`plans/FS116-Z2-close.md` D5')]:
    t=rd(p).rstrip('\n')
    wr(p,t+'\n\n## Notes at the close (2026-10-03; filed by X2 from %s; no statement above is edited)\n\n%s\n'%(src,num(body)))
# ---- item 8: banners
def banner(Z,start,end):
    seg=between(Z,start,end)
    m=re.search(r'\*Banner\* \(at the top of `([^`]+)`\): "(> \*\*Closed.*?)"\n\n',seg,re.S); assert m
    return m.group(1),flat(num(m.group(2)))
def put_banner(p,b):
    t=rd(p); i=t.index('\n'); assert t[i+1]=='\n'
    wr(p,t[:i+1]+'\n'+b+'\n'+t[i+1:])
p,b=banner(Z1,'### D7.','### D8.'); assert p=='plans/STUB-map-step.md'
b=b.replace("the cover route is parked behind FS-116 (Kooshi's to overturn)","the cover route is parked behind FS-125's NO-SAT (Kooshi's to overturn)"); assert "FS-125's NO-SAT" in b
put_banner(p,b)
p,b=banner(Z2,'### D6.','### D7.'); assert p=='plans/STUB-local-exclusion.md'
put_banner(p,b)
# R2 banner on stuck ray
m=re.search(r'\*\*5\. The banner for the demoted stub\*\*[^\n]*\n\n((?:> .*\n)+)',P); assert m
put_banner('plans/STUB-stuck-ray.md',m.group(1).rstrip('\n'))
# bearing lines
seg=between(P,'**6. Bearing lines**','**7. The solver column')
for stub,tag in [('plans/STUB-qfree-ring.md','FS-123'),('plans/STUB-saturated-local.md','FS-125'),('plans/STUB-curved-pencils.md','FS-126')]:
    m=re.search(r'- \*`'+re.escape(stub)+r'` \('+tag+r'\):\* "(.*?)"\n(?=- \*|\n)',seg,re.S); assert m,stub
    txt=flat(m.group(1))
    t=rd(stub); i=t.index('\n## Bearing on the answer'); j=t.index('\n## ',i+5)
    t=t[:j].rstrip('\n')+'\n\n'+txt+'\n'+t[j:]
    wr(stub,t)
# cards
cards=[('plans/STUB-qfree-ring.md','question: does-a-fragment-bend-keep-the-class','question: where-else-the-identity'),
       ('plans/STUB-q-ring.md','question: where-else-the-identity','question: is-the-curved-tangent-class-inhabited'),
       ('plans/STUB-curved-pencils.md','question: is-the-curved-tangent-class-inhabited','question: is-top-six-a-coverage-question'),
       ('plans/STUB-top-colour.md','question: is-top-six-a-coverage-question','*Four cards for four openings')]
H="## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)"
for stub,a,b in cards:
    s=P[P.index('### 2.5 The cards'):P.index('### 2.6')]
    card=s[s.index(a):s.index(b)].rstrip('\n')
    t=rd(stub).rstrip('\n')
    wr(stub,t+'\n\n'+H+'\n\n'+card+'\n')
# ---- item 9
m=re.search(r'under the entry FS111-W-NOREP \(l\. 485\), a dated paragraph:\*\* "(.*?)"\n',Z1,re.S); assert m
para=flat(m.group(1))
t=rd('plans/FS111-derivation.md')
anchor="Rests on it: FS111-W-HULLREG-MAPS; the exclusion of M's stub (d) among maps without cusps.\n"
assert t.count(anchor)==1
wr('plans/FS111-derivation.md',t.replace(anchor,anchor+'\n'+para+'\n'))
print('ok')
