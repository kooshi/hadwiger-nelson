# The filing of FS124-P1's re-rank (plans/POROS-2026-10-07-fs124-question.md Stage 4): the stub list's first sixteen rows, the
# front page's top three and open-milestones sentence, the banners, one dated correction in FS-124's stub, one held search request.
import re
R="/home/kooshi/source/lean-dir/"
def rd(p): return open(R+p).read()
def wr(p,s): open(R+p,"w").write(s)
P=rd("plans/POROS-2026-10-07-fs124-question.md"); N=rd("plans/POROS-2026-10-07-fs132-night.md").split("\n")
def sect(a,b): i=P.index(a); j=P.index(b,i+5); return P[i:j]
S42=sect("### 4.2 The rows that change, in full","### 4.3"); S43=sect("### 4.3 The top three","### 4.4")
def row(sec,prefix):
    c=[l for l in sec.split("\n") if l.startswith(prefix)]; assert len(c)==1,(prefix,len(c)); return c[0]
def rerank(l,n): m=re.match(r"\| \d+ \| ",l); assert m,l[:40]; return f"| {n} | "+l[m.end():]
def addq(l,sentence):
    parts=l.split(" | "); assert len(parts)==7,(len(parts),l[:60]); parts[2]=parts[2]+" "+sentence; return " | ".join(parts)
n130,n128,n123=N[397],N[399],N[400]
assert n130.startswith("| 5 | **FS-130 the bicycle's windings**") and n128.startswith("| 7 | **FS-128 the top colour, at six**") and n123.startswith("| 8 | **FS-123 the Siamese class**")
F=rd("plans/FRONTIER-STUBS.md"); ls=F.split("\n")
k=[i for i,l in enumerate(ls) if re.match(r"\| \d+ \| \*\*",l)]; assert len(k)==72 and k==list(range(k[0],k[0]+72)),len(k)
filed={}
for i in k[:16]:
    m=re.match(r"\| (\d+) \| \*\*(FS-\d+) ",ls[i]); filed[m.group(2)]=ls[i]
assert list(filed)==["FS-132","FS-124","FS-123","FS-125","FS-122","FS-127","FS-128","FS-117","FS-109","FS-104","FS-120","FS-126","FS-62","FS-39","FS-130","FS-115"],list(filed)
new=[row(S42,"| 1 | **FS-124 "),row(S42,"| 2 | **FS-135 "),row(S42,"| 3 | **FS-127 "),row(S42,"| 4 | **FS-122 "),
     rerank(n128,5),
     addq(rerank(n130,6),"The winding lemma asks that no two changes be 60° apart (C132-INDEX's *not claimed* line), and on every six-coloured object held the changes are exactly 60° apart — the tight pairs' lattice — so this row bears on colourings with no tight pair only."),
     row(S42,"| 7 | **FS-125 "),
     addq(rerank(n123,8),"The composition, and the one fact it needs (a map's palette is its ring read two-sidedly), are FS-134's (`plans/STUB-exclusion-back-to-maps.md`), a short job."),
     rerank(filed["FS-117"],9),rerank(filed["FS-109"],10),rerank(filed["FS-104"],11),rerank(filed["FS-120"],12),rerank(filed["FS-126"],13),
     rerank(filed["FS-62"],14),rerank(filed["FS-39"],15),rerank(filed["FS-115"],16)]
for q in ("the tight pairs' lattice","are FS-134's"):  # the two added sentences are the drafter's: check them against its record
    assert q in re.sub(r"\s+"," ",P)
ls[k[0]:k[0]+16]=new; F="\n".join(ls)
ranks=[int(re.match(r"\| (\d+) \|",l).group(1)) for l in F.split("\n") if re.match(r"\| \d+ \| \*\*",l)]; assert ranks==list(range(1,73)),ranks[:20]
NEXT="**Next, chosen by Kooshi (2026-10-07): FS-124, the (Q) ring** (`plans/STUB-q-ring.md`) — the boundary that is a unit arc about a ring point, where every exclusion of FS-132 stops."
OPENED="**Opened 2026-10-07: FS-124, the unit arc** (`plans/STUB-q-ring.md`; Kooshi's choice), re-posed for every measurable colouring proper at almost every unit pair: what a tight unit pair passes on (`plans/POROS-2026-10-07-fs124-question.md`)."
MINT=" **Minted by FS-132's record job (2026-10-07), unranked until the asking lane's next re-rank: FS-134, the exclusion back to maps** (`plans/STUB-exclusion-back-to-maps.md`) **and FS-135, the seed's remainder** (`plans/STUB-seed-remainder.md`)."
for q in ("FS-134, the exclusion back to maps: a short job, unranked; run when a derive slot is free; closes FS-123's first case in the map class.","FS-134, the exclusion back to maps, is a short job, unranked."): assert q in re.sub(r"\s+"," ",P),q
assert F.count(NEXT+MINT)==1
F=F.replace(NEXT+MINT,OPENED+" FS-134, the exclusion back to maps (`plans/STUB-exclusion-back-to-maps.md`): a short job, unranked; run when a derive slot is free; closes FS-123's first case in the map class. FS-135, the seed remainder (`plans/STUB-seed-remainder.md`), is ranked 2.")
old116="a four-colour vertex whose ring carries no boundary arc dies at `1 + ε` (non-Siamese, simple)"; assert F.count(old116)==1
F=F.replace(old116,old116+"; for measurable colourings with no Siamese clause, C132-M-EXCL, one mind, kernel pending")
wr("plans/FRONTIER-STUBS.md",F)
# CLAUDE.md
C=rd("CLAUDE.md"); cl=C.split("\n")
idx=[i for i,l in enumerate(cl) if l.startswith("| 1 | **FS-132 six by the nerve**")]; assert len(idx)==1; i=idx[0]
assert cl[i+1].startswith("| 2 | **FS-124 the (Q) ring**") and cl[i+2].startswith("| 3 | **FS-123 the Siamese class**") and cl[i+3].startswith("| 4–72 | 69 more open stubs")
cl[i:i+3]=[row(S43,"| 1 | **FS-124 "),row(S43,"| 2 | **FS-135 "),row(S43,"| 3 | **FS-127 ")]; C="\n".join(cl)
assert C.count(NEXT)==1; C=C.replace(NEXT,OPENED+" FS-134, the exclusion back to maps, is a short job, unranked.")
old="its Lean phase begun); before it **the landing of FS-132's import**"; assert C.count(old)==1
C=C.replace(old,"its Lean phase begun), with FS124-P1's re-rank (FS-124 Opened); before it **the landing of FS-132's import**")
wr("CLAUDE.md",C); print("CLAUDE.md bytes",len(C.encode()))
# banners: newest first, under the H1
def banner(path,text):
    s=rd(path); ls=s.split("\n"); assert ls[0].startswith("# ") and ls[1]=="",path; assert text[:50] not in s,path
    ls[2:2]=["> "+text,""]; wr(path,"\n".join(ls))
nb=[l for l in N if l.startswith("- `plans/STUB-qfree-ring.md` (FS-123): \"")]; assert len(nb)==1
b123=nb[0].split(': "',1)[1].rstrip('"'); first="(C132-M-EXCL, [hand], one mind, kernel pending). "; assert b123.count(first)==1
banner("plans/STUB-qfree-ring.md","**"+b123.replace(first,first+"FS-134 carries the composition. ")+"**")
S44=sect("### 4.4 Banners for Keryx to file","### 4.5")
def pb(path):
    t=re.sub(r"\s*\n\s*"," ",S44); m=re.search(r"- `"+re.escape(path)+r"` \(FS-\d+\): \"(.*?)\"(?= - `|$)",t); assert m,path; return m.group(1).strip()
for path in ("plans/STUB-forced-pair.md","plans/STUB-lateral-extent.md","plans/STUB-saturated-local.md"):
    banner(path,"**"+pb(path)+"**")
nd=[l for l in N if l.startswith("- `plans/STUB-saturated-local.md` (FS-125), `plans/STUB-curved-pencils.md` (FS-126), `plans/STUB-pinch-at-junction.md` (FS-120): \"")]; assert len(nd)==1
bdem=nd[0].split(': "',1)[1].rstrip('"')
for path in ("plans/STUB-curved-pencils.md","plans/STUB-pinch-at-junction.md"): banner(path,"**"+bdem+"**")
banner("plans/STUB-q-ring.md","**Opened 2026-10-07 (Kooshi's choice).** In the ranking this stub is *the unit arc: what a tight unit pair passes on*; its question for every measurable colouring is the section dated 2026-10-07 below (FS124-P1), its claim list `data/fs124/claims.md`, its inventory `plans/FS124-close-inventory.md`. The card of 2026-10-03 and the eight cases stand for maps.")
banner("plans/STUB-seed-remainder.md","**Ranked 2, 2026-10-07 (FS124-P1).** Its question 4, the one-edge form of C132-TURN's stall, is not asked: its content returns as C124-CENTRE and C124-COMPLETION at the placed point (`plans/POROS-2026-10-07-fs124-question.md` § 3.4).")
banner("plans/STUB-exclusion-back-to-maps.md","**Unranked, 2026-10-07 (FS124-P1): a short job, run when a derive slot is free.** It closes FS-123's first case in the map class, moves nothing on six against seven, and is not on FS-124's path: FS-124's claims are posed over open one-label pieces, so a held map is a control with no dictionary.")
# the dated correction under the record job's bullet in FS-124's stub
s=rd("plans/STUB-q-ring.md"); ls=s.split("\n")
k=[i for i,l in enumerate(ls) if l.startswith("- **What transfers from the map class**")]; assert len(k)==1; e=k[0]+1
while ls[e].startswith("  "): e+=1
ls[e:e]=["  *Dated correction (2026-10-07; FS124-P1's finding, `plans/POROS-2026-10-07-fs124-question.md`, filed by Keryx):* the dictionary fact of","  FS-134 serves the other direction — reading a palette-stated entry (C132-M-ORBIT, C132-M-EXCL) at a map vertex. What transfers from the","  map class to measure is carried by re-reading each argument over open one-label pieces, and needs no dictionary (this stub's question","  section of 2026-10-07, \"What to carry over from the map class first, and how\")."]
wr("plans/STUB-q-ring.md","\n".join(ls))
# the search queue: the asking lane's request, held on two claims
q=rd("plans/SEARCH-QUEUE.md"); ls=q.split("\n"); k=[i for i,l in enumerate(ls) if l.startswith("| 11 |")]; assert len(k)==1 and not any(l.startswith("| 12 |") for l in ls)
ls[k[0]+1:k[0]+1]=["| 12 | 2026-10-07, FS124-P1 | would decide whether a skeleton that saves every complementary pair twice exists at first order, in the class of colourings whose tight pairs lie on one lattice | the first-order label skeleton: on the points of the unit triangular lattice within radius 2, then 3, then 4 of a three-label point (19, 37, 61 points), label sets and tight pairs obeying C124-CENTRE, C124-COMPLETION, the 60° rule and C124-SIX; a constraint problem, exhaustive | `plans/POROS-2026-10-07-fs124-question.md` § 3.2 | **held until C124-COMPLETION and C124-SIX are derived** (FS-124 inventory item 4); the asking lane: line 11 stays held — \"as queued its yes is a shape already held, below every held radius, and its no measures a design family\" |"]
wr("plans/SEARCH-QUEUE.md","\n".join(ls))
print("filed")
