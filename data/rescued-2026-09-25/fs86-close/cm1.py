import re
p='CLAUDE.md'
s=open(p,encoding='utf-8').read()
def R(old,new):
    global s
    assert s.count(old)==1,(s.count(old),old[:80])
    s=s.replace(old,new)
lines=s.split('\n')
# locate table
i0=[k for k,l in enumerate(lines) if l.startswith('| rank | stub |')][0]
k=i0+2
out=[]
while lines[k].startswith('|'):
    l=lines[k]
    m=re.match(r'^\| (\d+)(–(\d+))? \|',l)
    a=int(m.group(1)); b=m.group(3)
    if a==2 and 'FS-86' in l:
        k+=1; continue
    if a>=3:
        if b: l=l.replace(f'| {a}–{b} |',f'| {a+1}–{int(b)+1} |',1)
        else: l=l.replace(f'| {a} |',f'| {a+1} |',1)
    out.append((a,l)); k+=1
new2=("| 2 | **FS-89 the missing theorem: measure rigidity with isometric archimedean directions** — `plans/STUB-isometric-measure-rigidity.md` (minted at FS-86's close) | "
"every construction of a non-periodic four-colouring of a type-(B) plane that reads finitely much structure is dead (rows 91–92); what is left reads infinitely many split places, and HD1 (no non-torsion band character) needs an `S`-adic, Berend-type rigidity theorem for the unit-vector action on `R̂` whose archimedean directions are isometries — not in print (Berend 1984 and Einsiedler–Lindenstrauss need expansion; both unread); with it Lemma X (Theorem C unrestricted), the three-phase case, C14 at infinitely many places; solver-free | "
"none directly; HD1 false gives `F(R) = 0` over ℚ(√59) (a restricted negative), HD1 true excludes every character colouring — a yes over ℚ(√59) is still Soifer 55.1 (row 86); reading-room research, low confidence |")
new3=("| 3 | **FS-90 two hours of sanctioned search** — `plans/STUB-sanctioned-search-fs86.md` (minted at FS-86's close; Kooshi's grant) | "
"FS-86's finite-witness questions priced side by side: HD1-cert's certificate on `Λ₅₁₀` and a saturation (semi-decidable, no size bound: two hours can confirm HD1, never refute it); \"is `√3` a four-colour virtual edge in ℚ(√2,√3)'s plane?\" (a refusal of one finite forcer; a whole-plane no needs every finite subgraph); a triangle-free forcer of `(0, 4)` in a number field inside `ℚ₂(√3)` (`4 ∈ F_tf`, row 90); `Λ₅₁₀`'s route 4 and 29's certificate | "
"none directly; each a finite witness toward row 88's question or its triangle control; a yes on the third is Soifer 55.1 |")
# insert after rank 1
rows=[l for a,l in out]
lines[i0+2:k]=[rows[0],new2,new3]+rows[1:]
s='\n'.join(lines)
open(p,'w',encoding='utf-8').write(s)
print(len(rows))
