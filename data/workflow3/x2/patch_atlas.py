#!/usr/bin/env python3
"""X2 stage 5b: item 12, tools/viz_proof_atlas_facts.py. Each old text must occur exactly once (or the stated count)."""
import re
R='/home/kooshi/source/lean-dir-close/'
MAP={'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s=s.replace(k,v)
    assert '‹' not in s; return s
F=R+'tools/viz_proof_atlas_facts.py'; T=open(F).read()
def sub(old,new,count=1):
    global T
    assert T.count(old)==count,(T.count(old),old[:70]); T=T.replace(old,new)
# --- drafts, extracted from the close records
Z1=open(R+'plans/FS121-Z1-close.md').read(); Z2=open(R+'plans/FS116-Z2-close.md').read()
d9=re.search(r'### D9\. The Proof Atlas.*?```\n(.*?)```',Z1,re.S).group(1)
d8=re.search(r'### D8\. The Proof Atlas.*?```\n(.*?)```',Z2,re.S).group(1)
d9=num(d9); d8=num(d8)
# FS-121: replace node FS121's text (plain string only)
m=re.search(r'N\("FS121", "the map step", "step", ("Route M.*?")\)\n',d9,re.S)
newplain=re.sub(r'"\s*\n\s*"','',m.group(1))   # the draft's adjacent string literals, joined
old=re.search(r'(?<=N\("FS121", "the map step", "step", )"Route M.*?"(?=, STUB\("STUB-map-step.md"\),\n  "the map step:)',T,re.S)
assert old
T=T[:old.start()]+newplain+T[old.end():]
# new nodes FS126-128: the draft gives (id, label, role, plain) only; src, quote, grade, position are completed here from the stubs' own words
def nn(id_,label,plain,stubf,quote,grade,at):
    return ('N("%s", "%s", "step", %s,\n  STUB("%s"),\n  "%s", (STUB("%s"), "%s"), at=%s, sector="seven")\n')%(id_,label,plain,stubf,quote,stubf,grade,at)
def plain_of(i):
    mm=re.search(r'N\("%s", "[^"]*", "step", ("(?:.|\n)*?")\)\n'%i,d9); return re.sub(r'"\s*\n\s*"','',mm.group(1))
new_nodes=(nn('FS126','curved pencils',plain_of('FS126'),'STUB-curved-pencils.md',"can an honest saturated colouring of the plane, with any number of colours, have a curved tangent-type interface?","None alone; a colour-generic rung of route M's honest branch, smaller than the answer.","(49, 290)")
 +nn('FS127','lateral extent',plain_of('FS127'),'STUB-lateral-extent.md',"is the singular set of every honest saturated colouring of the plane locally finite?","None alone; a colour-generic rung.","(65, 285)")
 +nn('FS128','the six-colour rungs',plain_of('FS128'),'STUB-top-colour.md',"can the top colour of a Grundy six-colouring be bound, and does NO-PAR hold under Condition 5?","At six, and next to the answer.","(57, 250)"))
# anchor: after the FS122 node block
i=T.index('N("FS122", "the forced pair"'); j=T.index('\n\n',i)
T=T[:j+1]+new_nodes+T[j+1:]
# edges from the drafts (verbatim lines starting with E()
def edges(d): return [l for l in d.split('\n') if l.startswith('E(')]
e9=edges(d9); e8=edges(d8)
assert len(e9)==4 and len(e8)==6
k=T.index('E("TSMNO", "FS121", "rests"'); k=T.index('\n',k)+1
T=T[:k]+'\n'.join(e9)+'\n'+T[k:]
# FS-116: replace LOCALF node, add nodes and edges
m=re.search(r'N\("LOCALF".*?tier=1\)\n',d8,re.S); newlocal=m.group(0)
a=T.index('N("LOCALF"'); b=T.index('tier=1)\n',a)+len('tier=1)\n')
T=T[:a]+newlocal+T[b:]
newn=d8[d8.index('N("GFREE"'):d8.index('# edges')]
c=T.index('N("BOWSQ3"'); T=T[:c]+newn+T[c:]
k=T.index('E("CVEXISTS", "LOCALF"'); k=T.index('\n',k)+1
T=T[:k]+'\n'.join(e8)+'\n'+T[k:]
# route wall7 links
sub('"FS111", "FS121", "FS120", "FS122", "SEVEN", "UB7"]','"FS111", "FS121", "FS126", "FS127", "FS128", "FS120", "FS122", "SEVEN", "UB7"]')
sub('"COMPOSE", "GSTEP",','"COMPOSE", "GSTEP", "GFREE", "FS123", "FS124", "FS125",')
# --- repairs for the re-rank (addresses and quotes that moved)
sub('with BASE-V beside them (row 134\'s base re-derived but for Lemma 4 at cusps)','BASE-V stands beside them (row 134\'s base re-derived but for Lemma 4 at cusps)')
T=T.replace('FSR(11)','FSR(14)').replace('FSR(16)','FSR(20)')
T=T.replace('PF(10)','FSR(13)')
sub('"the shape of a CP five-colouring of the plane, row 131 at k = 5 (lim µ₅(ε) = 1)"','"the shape of a CP five-colouring of the plane — FS-104\'s mirror"')
sub('"soft as to truth (the bold form predicts no)"','"the conjecture\'s bold form predicts no (G48)"')
sub('"decisive if it lands: χ(ℝ²) = 5 with no MR (link 2)"','"a CP five-colouring of the plane gives χ(ℝ²) = 5 with no MR (link 2; row 130)"')
sub('{"file": "plans/FRONTIER-STUBS.md", "row": "6"}, "its fragments (the pencil, BOWTIE) are local positives a YES could use"','{"file": "plans/FRONTIER-STUBS.md", "row": "18"}, "its fragments (the pencil, BOWTIE) stay local positives a YES could use"')
sub('built="2026-09-28", job="X1", as_of="FS-114\'s and FS-111\'s closes"','built="2026-10-03", job="X2", as_of="FS-116\'s and FS-121\'s closes"')
open(F,'w').write(T); print('ok')
