import re
root='/home/kooshi/source/lean-dir-fs129-close/'
rd=lambda p: open(root+p,encoding='utf-8').read()
def wr(p,s): open(root+p,'w',encoding='utf-8').write(s)
def ws(s): return re.sub(r'\s+',' ',s)
z=rd('plans/FS129-Z2-record.md').split('\n')
def block(start_pat):
    """blockquote lines after the first line matching start_pat; joined with newline, '> ' stripped"""
    i=[k for k,l in enumerate(z) if re.search(start_pat,l)]
    assert len(i)==1,(start_pat,i); k=i[0]+1
    while not z[k].startswith('>'): k+=1
    out=[]
    while k<len(z) and z[k].startswith('>'):
        out.append(z[k][2:] if z[k].startswith('> ') else z[k][1:]); k+=1
    return '\n'.join(out)
log=[]
# ---- item 3: G92
g92=block(r'^### Proposed grokking G92')
assert g92.startswith('* **G92')
f='.claude/skills/grokkings/SKILL.md'; L=rd(f).split('\n')
i=[k for k,l in enumerate(L) if l.startswith('* **G51 — ')]; assert len(i)==1
assert L[i[0]-1].startswith('  ') or True
L[i[0]:i[0]]=g92.split('\n')
s='\n'.join(L); old='entries G1 to G91'; assert s.count(old)==1; s=s.replace(old,'entries G1 to G92'); wr(f,s)
# ---- item 4: instances
f='plans/GROKKING-INSTANCES.md'; L=rd(f).split('\n')
def slot(L,nextheading,text):
    i=[k for k,l in enumerate(L) if l==nextheading]; assert len(i)==1,nextheading
    k=i[0]
    while L[k-1].strip()=='' : k-=1
    L[k:k]=['']+text.split('\n')
# do from the bottom up so indexes stay valid
slot(L,'## `CLAUDE.md` § Counter-priors',block(r'^\*\*Slot 3\*\*'))
slot(L,'## G84 — Contact is the regularity mechanism',block(r'^\*\*Slot 2\*\*'))
slot(L,'## G50 — Read what the search found',block(r'^\*\*Slot 1\*\*'))
wr(f,'\n'.join(L))
# ---- item 5: bibliography
f='BIBLIOGRAPHY.md'; s=rd(f)
old="FS-103 (row 130), FS-104 | `library/papers/falconer-1981"
assert s.count(old)==1
add="FS129-SA1-FALC-RED and the fan family (FS129-SA1-FALC-FAN, -FALC-DICHO-K, -FALC-RES); Lemmas 1–4 and Theorems 1–2 checked against pp. 185–187 by FS129-MA1 (§ 2.1)"
s=s.replace(old,"FS-103 (row 130), FS-104; "+add+" | `library/papers/falconer-1981"); wr(f,s)
# ---- item 6: FRONTIER-STUBS
f='plans/FRONTIER-STUBS.md'; L=rd(f).split('\n')
dr=[l for l in rd('data/fs129/p1/frontier-table-draft.md').split('\n') if l.startswith('|')]
i=[k for k,l in enumerate(L) if l.startswith('| rank | stub')]; assert len(i)==1
j=i[0]
while L[j].startswith('|'): j+=1
L[i[0]:j]=dr
s='\n'.join(L)
p=rd('plans/POROS-2026-10-03-fs129-rerank.md')
m=re.search(r'replace "(then the top of the ranking, \*\*FS-123.*?alternative\.)" with "(then the top of the ranking, \*\*FS-124.*?alternative\.)"',p,re.S)
assert m
oldp,newp=m.group(1),m.group(2)
rx=re.compile(re.escape(oldp).replace(r'\ ',r'\s+').replace(r'\n',r'\s+'))
# whitespace-flexible
rx=re.compile(r'\s+'.join(re.escape(w) for w in oldp.split()))
assert len(rx.findall(s))==1,len(rx.findall(s))
s=rx.sub(lambda _:newp,s)
wr(f,s)
# ---- item 7: stubs
banners={
 'qfree-ring':('FS-123, 1 → 2'),'saturated-local':'FS-125, 4 → 5','forced-pair':'FS-122, 5 → 6','curved-pencils':'FS-126, 7 → 9','stuck-ray':'FS-115, 18 → 19'}
p=p.split('\n')
for slug,tag in banners.items():
    i=[k for k,l in enumerate(p) if l.startswith('- `plans/STUB-%s.md` (%s)'%(slug,tag))]
    assert len(i)==1,(slug,tag)
    k=i[0]; txt=[p[k].split('): ',1)[1]]; k+=1
    while p[k].startswith('  '): txt.append(p[k].strip()); k+=1
    ban='\n'.join('> '+t for t in txt)
    f='plans/STUB-%s.md'%slug; L=rd(f).split('\n')
    assert L[0].startswith('# ') and L[1]==''
    L[2:2]=ban.split('\n')+['']
    wr(f,'\n'.join(L)); log.append(slug)
titles={'qfree-ring':('the (Q)-free ring','the Siamese class'),'top-colour':('the six-colour rungs of the map step','the top colour, at five and six'),'pinch-at-junction':('the pinch at a junction','the pinch at a junction, and the cover route at five')}
for slug,(o,n) in titles.items():
    f='plans/STUB-%s.md'%slug; L=rd(f).split('\n')
    assert L[0].count('— '+o+':')==1,(slug,L[0][:80])
    L[0]=L[0].replace('— '+o+':','— '+n+':'); wr(f,'\n'.join(L))
# ---- item 8: dated notes
srch=rd('plans/SEARCH-2026-10-03.md').split('\n')
def bullet(idn):
    i=[k for k,l in enumerate(srch) if l.startswith('- **%s**'%idn)]; assert len(i)==1,idn
    k=i[0]; t=[srch[k][2:]]; k+=1
    while srch[k].startswith('  '): t.append(srch[k].strip()); k+=1
    return ' '.join(t),i[0]+1
q=[l for l in rd('plans/SEARCH-QUEUE.md').split('\n') if l.startswith('| 1 | 2026-10-03, FS129-OA1')]; assert len(q)==1
qq="A yes empties FALC-11's exception (t ≡ a)"; assert qq in q[0]
g11,l11=bullet('SEARCH-1003-G11-DG')
note1=("*Dated note, 2026-10-03 (FS129-F1, from inventory item 153).* `plans/SEARCH-QUEUE.md` row 1 asked, of this entry's one exception: \"does Γ₁₁ have a proper 5-colouring with a vertex whose closed neighbourhood shows at most three colours (two gap colours)? "+qq+"\". "
 "It was answered yes. `plans/SEARCH-2026-10-03.md` § 2.3 (summary list, l. %d), verbatim: \"%s\""%(l11,g11))
parts=[]; ls=[]
for idn in ('SEARCH-1003-U4-GAP','SEARCH-1003-U8-NOGAP','SEARCH-1003-U16-NOGAP'):
    t,l=bullet(idn); parts.append('"%s"'%t); ls.append(l)
sp=[k for k,l in enumerate(srch) if l.startswith('**The spectrum**')]; assert len(sp)==1
k=sp[0]; t=[srch[k]]; k+=1
while srch[k].strip()!='' : t.append(srch[k]); k+=1
spec=' '.join(x.strip() for x in t)
cut=spec.index('What it means is the deriver\'s.')+len('What it means is the deriver\'s.')
spec=spec[:cut]
note2=("*Dated note, 2026-10-03 (FS129-F1, from inventory item 153).* The Searcher's results on the dyadic targets this entry's non-claim leaves open (\"the fields whose only four-colourable residue targets are dyadic inert U_Q with Q ∈ {4, 8, 16} — whether those targets have a gapped four-colouring is not decided (a search request)\"), "
 "`plans/SEARCH-2026-10-03.md` (summary list, l. %s; § 2.4), verbatim: "%'–'.join([str(ls[0]),str(ls[2]+0)]) + ' '.join(parts)+" And § 2.4's reading of the spectra, verbatim: \"%s\""%spec)
f='plans/FS129-derivation.md'; L=rd(f).split('\n')
def after_block(L,derivid,text):
    i=[k for k,l in enumerate(L) if l=='derivation: '+derivid]; assert len(i)==1
    k=i[0]+1
    while not (L[k].startswith('derivation: ') or L[k].startswith('## ')): k+=1
    # back over blank lines
    while L[k-1].strip()=='' : k-=1
    L[k:k]=['',text]
after_block(L,'FS129-MA2-FALC-HOSTS',note2)
after_block(L,'FS129-OA1-FALC-11',note1)
wr(f,'\n'.join(L))
print('ok',log)
