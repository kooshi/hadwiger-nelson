# The filing that makes FS-136 Derived: FS136-Z1's drafts 1-13 (plans/FS136-Z1-record.md), each applied at its slot, each slot
# asserted to occur once; texts read from the record's block quotes and table rows, never retyped. Nothing is written until
# every slot has been found. Run by the coordinator (Keryx).
import re
R="/home/kooshi/source/lean-dir/"
def rd(p): return open(R+p).read()
OUT={}
rec=rd("plans/FS136-Z1-record.md"); i=rec.index("## Drafts for the front page"); j=rec.index("\n## Stage 7",i); D=rec[i:j]; S7=rec[j:]
def block(n):
    a=D.index(f"\n**Draft {n} — "); m=re.search(r"\n\*\*Draft %d — "%(n+1),D); b=m.start() if m else len(D); return D[a:b]
def quotes(txt):
    out=[]; cur=None
    for l in txt.split("\n"):
        if l.startswith("> "): cur=(cur or [])+[l[2:]]
        elif l.strip()==">" and cur is not None: cur.append("")
        else:
            if cur: out.append(cur); cur=None
    if cur: out.append(cur)
    return [" ".join(x).strip() if "" not in x else "\n".join(x) for x in out]
def swap(s,old,new,name):
    assert s.count(old)==1,(name,s.count(old)); return s.replace(old,new)
# ---- LEDGER.md: rows 165-167 after row 164
rows=[l for l in block(1).split("\n") if re.match(r"\| 16[567] \|",l)]; assert len(rows)==3
L=rd("LEDGER.md").split("\n"); k=[n for n,l in enumerate(L) if l.startswith("| 164 |")]; assert len(k)==1 and not any(l.startswith("| 165 |") for l in L)
L[k[0]+1:k[0]+1]=rows; OUT["LEDGER.md"]="\n".join(L)
# ---- CLAUDE.md: drafts 2-8
C=rd("CLAUDE.md")
for n in range(2,9):
    q=quotes(block(n)); assert len(q)==2,(n,len(q)); C=swap(C,q[0],q[1],f"D{n}")
OUT["CLAUDE.md"]=C
# ---- FRONTIER-STUBS.md: row 1 and the unranked line
q9=quotes(block(9)); assert len(q9)==2 and q9[0].startswith("| 1 | **FS-136") and q9[1].startswith("**Unranked, minted")
F=rd("plans/FRONTIER-STUBS.md").split("\n"); k=[n for n,l in enumerate(F) if l.startswith("| 1 | **FS-136 the point across")]; assert len(k)==1
F[k[0]]=q9[0]; e=k[0]
while e+1<len(F) and F[e+1].startswith("| "): e+=1
assert not any("Unranked, minted 2026-10-07 (FS136-Z1)" in l for l in F)
F[e+1:e+1]=["",q9[1]]; OUT["plans/FRONTIER-STUBS.md"]="\n".join(F)
# ---- the grokkings file: G100 after G99; G98's two insertions
G=rd(".claude/skills/grokkings/SKILL.md").split("\n")
g100=quotes(block(10)); assert len(g100)==1 and g100[0].startswith("* **G100 — ")
k=[n for n,l in enumerate(G) if l.startswith("* **G99 — ")]; assert len(k)==1 and not any(l.startswith("* **G100") for l in G)
G[k[0]+1:k[0]+1]=[g100[0]]
m1=re.search(r'\*After\* "(.*?)" \*insert\*: "(.*?)"\n',S7); m2=re.search(r'\*In its Do, after\* "(.*?)" \*insert\*: "(.*?)"\n',S7); assert m1 and m2
k=[n for n,l in enumerate(G) if l.startswith("* **G98 — ")]; assert len(k)==1
g=G[k[0]]; g=swap(g,m1.group(1),m1.group(1)+m1.group(2),"G98a"); g=swap(g,m2.group(1),m2.group(1)+m2.group(2),"G98b"); G[k[0]]=g
OUT[".claude/skills/grokkings/SKILL.md"]="\n".join(G)
# ---- the instances file
I=rd("plans/GROKKING-INSTANCES.md")
b11=block(11); bul=[re.sub(r"\s*\n\s*"," ",x).strip() for x in re.split(r"\n- \*\*§ ",b11)[1:]]
def body(prefix):
    c=[x for x in bul if x.startswith(prefix)]; assert len(c)==1,(prefix,len(c)); return c[0].split(" — ",1)[1]
m98=re.search(r'under a\s+new heading § G98: "(.*?)" \*\*The rewrite',re.sub(r"\s*\n\s*"," ",S7)); assert m98
def title(n):
    l=[x for x in G if x.startswith(f"* **G{n} — ")]; assert len(l)==1; return re.match(r"\* \*\*(G%d — .*?)\. \["%n,l[0]).group(1)
def under(I,head,para):
    assert I.count("\n"+head+"\n")==1,head; a=I.index("\n"+head+"\n")+len(head)+2; m=re.search(r"\n## ",I[a:]); e=a+m.start() if m else len(I)
    return I[:e].rstrip("\n")+"\n\n"+para+"\n"+I[e:]
I=under(I,"## G21 — A negative measures its enumeration","FS-136 (2026-10-07; FS136-Z1's draft 11): "+body("G21**"))
I=under(I,"## G54 — Tight or slack","FS-136 (2026-10-07; FS136-Z1's draft 11): "+body("G54**"))
I=under(I,"## G92 — A held result reaches as far as its argument, not as far as its statement","FS-136 (2026-10-07; FS136-Z1's draft 11): "+body("G92**"))
cp="## `CLAUDE.md` § Counter-priors"; assert I.count("\n"+cp+"\n")==1 and "## G96 — " not in I and "## G98 — " not in I and "## G99 — " not in I
new=f"## {title(96)}\n\nFS-136 (2026-10-07; FS136-Z1's draft 11): {body('G96**')}\n\n## {title(98)}\n\n{m98.group(1)}\n\n## {title(99)}\n\nFS-136 (2026-10-07; FS136-Z1's draft 11): {body('G99**')}\n\n"
I=I.replace("\n"+cp+"\n","\n"+new+cp+"\n")
I=under(I,cp,"*FS136-Z1, FS-136's record job; `plans/FS136-Z1-record.md` Stage 5:* "+body("`CLAUDE.md` § Counter-priors**"))
OUT["plans/GROKKING-INSTANCES.md"]=I
# ---- the atlas facts: four nodes, seven edges, the job line (positions are placed by a search afterwards)
A=rd("tools/viz_proof_atlas_facts.py"); code=re.search(r"```python\n(.*?)\n```",block(12),flags=re.S).group(1).split("\n")
ns=[l for l in code if l.startswith("N(")]; es=[l for l in code if l.startswith("E(")]; assert len(ns)==4 and len(es)==7 and 'N("TABLEAT"' not in A
AL=A.split("\n"); k=[n for n,l in enumerate(AL) if l.startswith('N("STRIPEDGE"')]; assert len(k)==1; AL[k[0]+1:k[0]+1]=ns
k=[n for n,l in enumerate(AL) if l.startswith('E("DISCS", "STRIPEDGE"')]; assert len(k)==1; AL[k[0]+1:k[0]+1]=es
A="\n".join(AL)
A=swap(A,'job="FS124-L1", as_of="FS-124\'s disc criterion through the gate (row 161); FS-124, the unit arc, Derived (rows 161–164)"','job="FS136-Z1", as_of="FS-136, the point across, Derived (rows 165–167); FS-124\'s disc criterion through the gate (row 161)"',"atlas-job")
OUT["tools/viz_proof_atlas_facts.py"]=A
# ---- the claim list: the twenty-first entry
d=rd("plans/FS136-derivation.md"); a=d.index("derivation: C136-STOP-BOWTIE-SIX\n"); b=d.index("\n\n",a); f={}
for l in d[a:b].split("\n")[1:]:
    m=re.match(r"  ([a-z ]+): (.*)$",l)
    if m: f[m.group(1)]=m.group(2)
cl=rd("data/fs136/claims.md").rstrip("\n"); assert "**C136-STOP-BOWTIE-SIX** — verdict" not in cl
cl+=f'''

- **2026-10-07 (at the filing that makes this milestone Derived; FS-136 inventory item 17): a twenty-first entry, entered by the record job
  from the first deriver's dated note and this list's line of 17:13 UTC, copied by script from the theorem record
  (`plans/FS136-derivation.md` § 4).** It stands beside C136-STOP-BOWTIE (eight tiles) and the germ form; by the record,
  neither of the first two contains the other.

  **C136-STOP-BOWTIE-SIX** — verdict: {f['verdict']}; grade: {f['grade']}; minds: {f['minds']}. *Statement, as its verdict is about it:* {f['statement']} *Not claimed:* {f['not claimed']}
'''
OUT["data/fs136/claims.md"]=cl
for p,t in OUT.items(): open(R+p,"w").write(t)
print("filed:",", ".join(sorted(OUT))); print("CLAUDE.md bytes",len(OUT["CLAUDE.md"].encode()),"grokkings bytes",len(OUT[".claude/skills/grokkings/SKILL.md"].encode()))
