import re,sys
sys.path.insert(0,'/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-close')
from wsr import wsr
p='plans/FRONTIER-STUBS.md'
s=open(p,encoding='utf-8').read()
lines=s.split('\n')
i0=[k for k,l in enumerate(lines) if l.startswith('| rank | stub |')][0]
k=i0+2; rows=[]; fs86=None
while lines[k].startswith('|'):
    l=lines[k]; m=re.match(r'^\| (\d+)(–(\d+))? \|',l); a=int(m.group(1)); b=m.group(3)
    if a==2 and 'FS-86' in l: fs86=l; k+=1; continue
    if a>=3:
        l=l.replace(f'| {a}–{b} |',f'| {a+1}–{int(b)+1} |',1) if b else l.replace(f'| {a} |',f'| {a+1} |',1)
    rows.append(l); k+=1
notes={'**FS-59':" **At FS-86's close:** no measurable window four-colouring over finitely many places exists over ℚ(√167) (row 92, FS86-CL1, one mind); at five colours the window count fails at the real place (Croft's `m₁ ≥ 0.22936 > 1/5`), so this question is untouched.",
 '**FS-83':" **Re-aimed at FS-86's close:** at `k = 4` dead on type-(B) planes — finite-type characters (row 91, HD1-fin = C10) and every measurable window (row 92, C14) — and for measurable windows over ℚ(√47) (FS86-CL1); live at `k = 5` over ℚ(√167) and for band characters of infinite type (FS-89). The plan's §S.5 fallback was dead before it ran.",
 '**FS-84':" **At FS-86's close:** a four-colouring falsifying the conjecture's five-clause here cannot be a measurable window colouring over finitely many places with odd split places (row 92, FS86-CL1, one mind).",
 '**FS-64':" **At FS-86's close:** with any finite set of places and measurable windows it cannot four-colour a type-(B) plane non-periodically (row 92); over type (A) no such four-colouring exists (FS86-CL1); its five-colour aim at ℚ(√167) is untouched.",
 'FS-67 ':" **Re-aimed at FS-86's close:** `[Zhang2012]` Thm 1.8(i) answers the main case (vertex-transitive factors, strict ratio inequality, `H` connected: every colouring pulled back from the larger-ratio factor; row 88); left are the equal-ratio case (tightness decides it at K, row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)`.",
 '**FS-76':" **At FS-86's close:** over type-(B) fields Kempe swaps (HD4), two-pullback and pullback-plus-alternative patchworks (D, D′) and half-space defects (H) cannot break inheritance (row 91); `P(R) ≠ F(R)` there would be a four-colour inheritance failure on a non-finitely-generated abelian Cayley graph.",
 '**FS-87':" **FS-86's kernel candidates:** `ℤ[T] = O` (FS86-W1) and Theorem A by W's route (row 90), the K classification (row 89), C12.1 (row 93); Lemma R with FS-47."}
out=[]
for l in rows:
    for key,n in notes.items():
        if l.split(' | ')[1].startswith(key) or (key=='FS-67 ' and l.split(' | ')[1].startswith('FS-67')):
            c=l.split(' | '); c[2]=c[2]+n; l=' | '.join(c)
    out.append(l)
new2=("| 2 | **FS-89 the missing theorem: measure rigidity with isometric archimedean directions** — `plans/STUB-isometric-measure-rigidity.md` (minted 2026-09-25 at FS-86's close) | "
"Every construction of a non-periodic four-colouring of a type-(B) plane that reads finitely much is dead (rows 91–92). HD1 (`Θ₄(R) ⊆ T`) needs an `S`-adic, Berend-type rigidity theorem for the unit-vector action on `R̂` whose archimedean directions are isometries — not in print (Berend 1984 and Einsiedler–Lindenstrauss need expansion; unread). Sub-questions: Lemma X (Theorem C unrestricted), the three-phase case, windows over infinitely many places; the reading that the real place is the obstruction (G76) | "
"none directly: HD1 false gives `F(R) = 0` over ℚ(√59) (a restricted negative); HD1 true excludes every character colouring and leaves `F(R)` open; a yes over ℚ(√59) is Soifer 55.1 (row 86) | weeks to open-ended (research) | minted | solver-free |")
new3=("| 3 | **FS-90 two hours of sanctioned search** — `plans/STUB-sanctioned-search-fs86.md` (minted 2026-09-25 at FS-86's close; Kooshi's grant) | "
"FS-86's finite-witness questions priced side by side for a two-hour exception to the ban: (a) HD1-cert's certificate on `Λ₅₁₀` and a saturation — semi-decidable, so two hours can confirm HD1 and never refute it; (b) \"is `√3` a four-colour virtual edge in ℚ(√2,√3)'s plane?\" — a refusal of one finite forcer; (c) a triangle-free forcer of `(0, 4)` in a number field inside `ℚ₂(√3)` (`4 ∈ F_tf`, row 90); (d) `Λ₅₁₀`'s route 4 (composite quotients) and 29's certificate for (R4) | "
"none directly; (a)–(b) bear on row 88's question and its triangle control; a yes on (c) is Soifer 55.1 | two hours of solver time, priced per candidate in the stub | minted | **needs search** (after the ban, or by Kooshi's exception) |")
lines[i0+2:k]=[out[0],new2,new3]+out[1:]
s='\n'.join(lines)
s=wsr(s,"**No FS milestone is open. FS-85 closed 2026-09-24** (`LEDGER.md` rows 85–87; G75; the closed list). **Next, Kooshi's choice (2026-09-25): FS-86** (four-colour rigidity over ℚ(√59) and ℚ(√83); `plans/STUB-dyadic-rigidity-triangle-free.md`).",
"**No FS milestone is open. FS-86 closed 2026-09-25** (`LEDGER.md` rows 88–94; G76; the closed list). **Next: a fresh advisor chooses and Kooshi decides** — the missing theorem (FS-89), two hours of sanctioned search (FS-90), or something else.")
a=s.index("*Re-ranked 2026-09-24 at FS-85's close, one rank per row.")
s=s[:a]+("*Re-ranked 2026-09-25 at FS-86's close, one rank per row. **FS-86 closed** (`LEDGER.md` rows 88–94; G76; the closed list), verdict Paid (no-go) by ruling. **Minted:** FS-89 (the missing theorem, rank 2), FS-90 (two hours of sanctioned search, rank 3, Kooshi's grant). **Re-aimed:** FS-59, FS-83, FS-84, FS-64 (row 92 and FS86-CL1), FS-67 (Zhang answers its main case), FS-76 (row 91), FS-87 (FS-86's kernel candidates). Every rank from 3 on moved down one. The earlier re-rank's paragraph follows.*\n\n")+s[a:]
closed=("* **FS-86 four-colour rigidity over ℚ(√59) and ℚ(√83)** — `plans/STUB-dyadic-rigidity-triangle-free.md`. **Closed 2026-09-25** (record `plans/FS86-dyadic-rigidity.md`, §R-close first; `plans/FS86-derivation.md`, 67 entries; stage B, competition, verifier and advisor records `plans/FS86-*.md`, `plans/POROS-2026-09-25-fs86-*.md`; `LEDGER.md` rows 88–94; G76). Over the type-(B) fields four-colour rigidity is one pair, `(0, 4)`, **undecided**; the local plane over `ℚ₂(√3)` is rigid; every four-colouring of `K²` is classified; every natural construction of a non-periodic colouring is impossible. Verdict **Paid (no-go)** by ruling (§R-close.5). Its row as ranked: " + fs86.split(' | ',1)[1] + "\n")
s=s.replace("## Closed, absorbed and demoted\n","## Closed, absorbed and demoted\n"+closed,1)
open(p,'w',encoding='utf-8').write(s)
print('ok', len(out))
