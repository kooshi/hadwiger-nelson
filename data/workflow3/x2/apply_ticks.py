#!/usr/bin/env python3
"""X2 stage 5a: item 11, tick the close inventories. Only rows whose status cell starts with 'open' are changed."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    return s
def parse_ticks(path):
    out={}
    for l in open(R+path).read().split('\n'):
        m=re.match(r'\| (\d+)(?:–(\d+))? \| (.*?) \| (.*) \|$',l)
        if not m: continue
        a=int(m.group(1)); b=int(m.group(2) or a)
        for n in range(a,b+1): out[n]=(m.group(3),m.group(4))
    return out
Z2='`plans/FS116-Z2-close.md`'
P2={13:'the re-rank handed to Poros: R2 (item 150); %s D9'%Z2,
 19:'%s § 3.3: the dated note in `plans/STUB-local-exclusion.md` § Prior-art debts'%Z2,
 20:'row 137\'s prior-art clause (`LEDGER.md` row 137) and a dated note under FS114-CV-EXISTS (%s § 1.3 F-2, D1)'%Z2,
 29:'the FS114-N7-3T erratum in `plans/FS114-derivation.md` (%s § 1.6, D7)'%Z2,
 32:'the FS114-N7-3T erratum in `plans/FS114-derivation.md` (%s § 1.6, D7)'%Z2,
 39:'the FS114-N7-3T erratum in `plans/FS114-derivation.md` (%s § 1.6, D7)'%Z2,
 71:'the FS114-N7-3T erratum and the entry FS114-N7-HUB in `plans/FS114-derivation.md` (%s § 1.6, D7)'%Z2,
 110:'the FS114-N7-3T erratum in `plans/FS114-derivation.md` (%s § 1.6, D7)'%Z2,
 53:'FS-124, § Definitions and tools owed (%s § 3.2)'%Z2,
 63:'FS-124, § Prior-art debts (%s § 3.2)'%Z2, 99:'FS-124, § Prior-art debts (%s § 3.2)'%Z2,
 67:'FS-124, § Definitions and tools owed (%s § 3.2)'%Z2,
 69:'FS-124\'s owed list for STAR, RECIP, ANTI, RING-TRANSFER-C; declined for HEX6, HEX3, true vacuously (%s § 3.2)'%Z2,
 83:'FS-125, questions 1 and 4 (%s § 3.2)'%Z2,
 96:'FS-124, cases 1 and 2 (%s § 3.2)'%Z2, 97:'FS-124, cases 1 and 2 (%s § 3.2)'%Z2,
 98:'FS-124, § Definitions and tools owed (%s § 3.2)'%Z2,
 116:'FS-121\'s D8 bearing lines placed verbatim in the stubs (%s § 3.3); the D2 clauses filed at the closing commit of X2'%Z2,
 126:'FS-123, question 2 (%s § 3.2)'%Z2,
 127:'the G83 instance filed in `plans/GROKKING-INSTANCES.md` § G83 at the closing commit of X2',
 128:'FS-123, § Prior-art debts (%s § 3.2)'%Z2,
 130:'FS116-V6\'s verdict folded in (%s § 1.4)'%Z2,
 25:'%s § 2.5 scored them'%Z2,
 40:'FS-124, case 2 (%s § 3.2)'%Z2, 56:'FS-125, questions 1 and 4 (%s § 3.2)'%Z2, 61:'FS-124, case 4 (%s § 3.2)'%Z2,
 118:'CROSS\'s last clause on FS-124\'s owed list; NBTIP declined, true vacuously (%s § 3.2)'%Z2,
}
def apply(inv,ticks,extra,p2=None):
    lines=open(R+inv).read().split('\n'); log=[]
    for k,l in enumerate(lines):
        m=re.match(r'\| (\d+) \|',l)
        if not m: continue
        n=int(m.group(1)); cells=l.split(' | ')
        if not cells[-1].startswith('open') and not cells[-1].rstrip(' |').startswith('open'): continue
        st=cells[-1].rstrip(' |')
        if not st.startswith('open'): continue
        new=None
        if n in extra: new=extra[n]
        elif n in ticks:
            t,w=ticks[n]
            if p2 is not None and n in p2:
                z1w=w if 'part 2' not in w and t.startswith('done') and w not in ('(already)',) else ''
                new='done: '+(p2[n] if not z1w else z1w+'; '+p2[n])
            elif t.startswith('done') and 'part 2' not in t:
                new='done: '+num(w)
        if new is None: log.append((n,'UNCHANGED',st)); continue
        cells[-1]=new+' |'; lines[k]=' | '.join(cells); log.append((n,'ticked',st,'->',new[:70]))
    open(R+inv,'w').write('\n'.join(lines)); return log
t121=parse_ticks('data/fs121/fs121-z1/ticks.md')
e121={88:'done: filed at the closing commit of X2 (`plans/WORKFLOW3-X2-front-page.md`)',
      89:'done: carried by R2 (`plans/FS116-close-inventory.md` items 149–150)'}
t116=parse_ticks('data/fs116/fs116-z1/ticks.md')
e116={131:'done: the close ran as two jobs, FS116-Z1 (item 132) and FS116-Z2 (item 143)',
      135:'done: the vacuity notes, %s D1 and the derivation file (%s § 1.4)'%(Z2,Z2),
      136:'done: placed in FS-123, question 1, both sides verbatim (%s § 3.2); R2 card 1 (item 150)'%Z2,
      140:'done: V6\'s lemmas filed as § B lines (%s D1)'%Z2,
      142:'done: R2 card 2 (item 150), filed in `plans/STUB-q-ring.md` at the closing commit of X2',
      154:'done: filed at the closing commit of X2 (`plans/WORKFLOW3-X2-front-page.md`)'}
for inv,t,e,p in [('plans/FS121-close-inventory.md',t121,e121,None),('plans/FS116-close-inventory.md',t116,e116,P2)]:
    log=apply(inv,t,e,p)
    print(inv,len([x for x in log if x[1]=='ticked']),'ticked;','unchanged:',[(x[0],x[2][:30]) for x in log if x[1]=='UNCHANGED'])
