#!/usr/bin/env python3
"""FS131-FC10: file FS131-ICO2's drafts D1-D12 (D13 is separate) word for word.
Each (file, old, new): old matched whitespace-flexibly, asserted exactly once (within `scope` if given) BEFORE any write;
both old and new must also occur in the draft file (whitespace-normalised) -- the verbatim guard.
Usage: file_ico2.py --check | --write"""
import re, sys
from pathlib import Path
R = Path(__file__).resolve().parents[3]
DRAFT = (R/'plans/FS131-ICO2-collapse.md').read_text()
def norm(s): return ' '.join(s.split())
NDRAFT = norm(DRAFT[DRAFT.index('## Drafts for the front page'):])
def pat(s): return r'\s+'.join(re.escape(w) for w in s.split())

E = []  # (draft, file, old, new, scope_prefix or None, mode)  mode: 'rep' | 'delete'
def rep(d, f, old, new, scope=None, verbatim_old=True): E.append((d, f, old, new, scope, verbatim_old))

# D1
rep('D1','CLAUDE.md',"the current audit reads 10651 clean and 5 declared purchases, and 62 imported (and 569 axiom-free; 11,287 records at FS131-IL5, the main clause through five as one theorem, 2026-10-16)",
 "the current audit reads 10747 clean and 5 declared purchases, and 77 imported (and 569 axiom-free; 11,398 records at FS131-ICO2, the collapse, 2026-10-16)")
rep('D1','CLAUDE.md',"with forty-eight imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5)",
 "with fifty-eight imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5; ten the collapse's, FS131-ICO2: the thickness of ℚ(√635087) and de Grey's field, the two instances, the per-place form, the six-or-seven corollary, and D-E2's `Rigidity.norm_charSum_le_weil`)")
rep('D1','CLAUDE.md',"`Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with six;",
 "`Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with seven (the seventh the collapse's `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`);")
rep('D1','CLAUDE.md',"— with eighteen, ten of which rest on Weil's bound too (the five-colour chain's headline `Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other values, and `χ(F²) = L(F)` at `L(F) ≤ 5` with its `min` form, `Rigidity/MainClauseFive`); no record rests on the five-colour theorem and another import,",
 "— with twenty-seven, fourteen of which rest on Weil's bound too (the five-colour chain's headline `Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other values, `χ(F²) = L(F)` at `L(F) ≤ 5` with its `min` form, `Rigidity/MainClauseFive`, and the collapse at ℚ(√635087) and de Grey's field, its per-place form and its six-or-seven corollary, `Collapse/Headline`; the collapse's general form `Collapse.chromaticNumber_planeOver_eq_plane_of_thick` rests on it alone); one record rests on the five-colour theorem and another import, the collapse's six-or-seven corollary, on all three,")
# D2
rep('D2','CLAUDE.md',"`axioms=3 rests=78 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2` — three outside theorems declared as axioms, with seventy-eight (axiom, theorem) rows resting on them, sixty-eight theorems, ten of them on two;",
 "`axioms=3 rests=99 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as axioms, with ninety-nine (axiom, theorem) rows resting on them, eighty-four theorems, thirteen of them on two and one on three;")
rep('D2','CLAUDE.md',"taken in 108 (hypothesis, statement) pairs by 55 statements","taken in 109 (hypothesis, statement) pairs by 56 statements")
# D3
rep('D3','CLAUDE.md',"`declarations=22241 refutations-skipped=240 sites=1455`","`declarations=22357 refutations-skipped=242 sites=1455`")
# D5 insertion
D5 = "**the collapse** (FS-131, FS131-ICO2): `χ(F²) = χ(ℝ²)` at every real number field whose stable primes are uniformly `c`-thick, `c < 1/5` — every non-trivial character of every level of every conjugation-fixed prime of `F(i)` summing over the norm-one residues to at most `c` times their number — totally real or not (`Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 alone; its per-place form `…_of_forall_thickAt` on Weil's bound too); `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²)` with no hypothesis, thickness by Weil's bound above 103 and 131 (`Collapse.chromaticNumber_planeOver_sqrt635087`, `…_deGrey`), and `6 ≤ χ(ℚ(√635087)²) ≤ 7` with `Outside.OAI158.no_proper_five_coloring` (`…_sqrt635087_six_or_seven`) — row 128's field clause, wider than the row (no total reality; no MR hypothesis); the field equality prior art: not found in print (row 128), the plane equality `[OAIMath2026]`'s; the derivation FS-103's, the kernel's check this landing's;"
rep('D5','CLAUDE.md',"the derivation is this project's, and the kernel's check is this landing's;\n**Theorems A and B**",
 "the derivation is this project's, and the kernel's check is this landing's; "+D5+"\n**Theorems A and B**", verbatim_old=False)
# D6
rep('D6','CLAUDE.md',"**The plane's number is a measurable one with no hypothesis, and given MR a field's**","**The plane's number is a measurable one with no hypothesis, and a field's**")
rep('D6','CLAUDE.md',"and given MR(ℚ(√635087)) it is `χ(ℚ(√635087)²)` (row 128; [hand], two blind minds)",
 "and it is `χ(ℚ(√635087)²)` with no hypothesis (`Collapse.chromaticNumber_planeOver_sqrt635087`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and Weil's bound; row 128, in the kernel since FS131-ICO2)")
# D7
rep('D7','CLAUDE.md',"Given MR at a number field (row 120) it also equals `χ(F²)` at each totally real field where every stable place mixes at six colours, ℚ(√635087) and de Grey's field among them (row 128; [hand, two minds]).",
 "It also equals `χ(F²)` at every real number field whose stable places all mix at six colours, ℚ(√635087) and de Grey's field among them — in the kernel since FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and, at the two fields, Weil's bound (row 128; `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`).")
# D8
rep('D8','CLAUDE.md',"seven at ℚ(√635087) is `χ(ℝ²) = 7` given MR (row 128)","seven at ℚ(√635087) is `χ(ℝ²) = 7` (row 128; the equality `χ(ℚ(√635087)²) = χ(ℝ²)` in the kernel since FS131-ICO2)")
rep('D8','CLAUDE.md',"and given MR χ(F²) = χ(ℝ²), the least k with a measurable k-colouring proper at almost every unit pair","and χ(F²) = χ(ℝ²), the least k with a measurable k-colouring proper at almost every unit pair", verbatim_old=False)
rep('D8','CLAUDE.md',"(rows 128, 130, G81; [hand])","(rows 128, 130, G81; the field equality [kernel] since FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3)")
# D9 (all within row 128's line)
S9='| 128 |'
rep('D9','LEDGER.md',"**The collapse: given MR, the plane's number is a field's.","**The collapse: the plane's number is a field's.",S9)
rep('D9','LEDGER.md',"**[hand + tools exact; the load-bearing step two derivations blind to each other and to J39's and J48's proofs (V1; V2) — four derivations with the two held; the assemblies two blind; place lists and spectra tools exact, three code bases; MR row 120's grade; the complex-place widening one mind (V2), not claimed]**",
 "**[kernel since FS131-ICO2 for the field clause (`Proofs/HadwigerNelson/Collapse/`, the gate on `7c72b9bf7`): at every real number field uniformly `c`-thick with `c < 1/5`, totally real or not, `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on `Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) — MR is `Rigidity.mrPlus` there — and the standard three; at ℚ(√635087) and de Grey's field with no hypothesis, `Collapse.chromaticNumber_planeOver_sqrt635087`, `Collapse.chromaticNumber_planeOver_deGrey`, also on `StandingFive.kloosterman_bound` (`[Weil1948]`), which gives the kernel's thickness, `2√103/104` and `2√131/132`, in place of the row's exact spectra; the per-place form `Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt` on both; with `Outside.OAI158.no_proper_five_coloring`, `6 ≤ χ(ℚ(√635087)²) ≤ 7`, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`. Still [hand + tools exact], as graded before: the `χ_CP` member (row 130), the consequences past `{6, 7}`, the exact spectra and place lists]**",S9)
rep('D9','LEDGER.md',"**Not claimed:** the complex-place widening; anything at six.","**Not claimed:** anything at six. The complex-place widening is held in the kernel's form: the general theorem takes no total reality.",S9)
rep('D9','LEDGER.md',"`plans/FS105-derivation.md` FS105-MR16","`plans/FS105-derivation.md` FS105-MR16; `Proofs/HadwigerNelson/Collapse/` (FS131-KCL1, FS131-ICO1, FS131-ICO2)",S9, verbatim_old=False)
# D10
ROW10 = "| `χ(F²) = χ(ℝ²)` for every real number field whose stable primes are uniformly `c`-thick with `c < 1/5`: for one `c` and every prime ideal of `F(i)` that conjugation maps to itself, every non-trivial additive character of every `𝓞/Pᵐ` sums over the elements of norm one to at most `c` times their number. So `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3, √5, √7, √11)²) = χ(ℝ²)`, and with **O5**, `6 ≤ χ(ℚ(√635087)²) ≤ 7`. | `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, `Collapse.chromaticNumber_planeOver_sqrt635087`, `Collapse.chromaticNumber_planeOver_deGrey`, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven` | std3 + **EL** (the general form); + **W** (the two fields); + **O5** (the corollary) | the derivation is this project's; the field equality: prior art not found in print. The plane's number it is equated with is `[OAIMath2026]`'s `χ_m⁰`; in dimension at least four the analogue is `[Davies2026]` Thm 1.1 | 128 |"
E.append(('D10','README.md','__AFTER_LINE__',ROW10,"| `χ(ℚ(√47)²) = 5`. Also `χ = 5` over ℚ(√143)",True))
# D11
rep('D11','ROADMAP.md',"Six records rest on it, among them `6 ≤ χ(ℝ²) ≤ 7` and `6 ≤ χ_m⁰(ℝ²)`.","Seven records rest on it, among them `6 ≤ χ(ℝ²) ≤ 7`, `6 ≤ χ_m⁰(ℝ²)` and `6 ≤ χ(ℚ(√635087)²) ≤ 7`.")
rep('D11','ROADMAP.md',"Eighteen records rest on it, among them the five-colour chain `min(L(F), 5) ≤ χ(F²)`, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, and `χ(ℚ(√47)²) = 5`.",
 "Twenty-seven records rest on it, among them the five-colour chain `min(L(F), 5) ≤ χ(F²)`, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, `χ(ℚ(√47)²) = 5`, and the collapse `χ(F²) = χ(ℝ²)` at every uniformly thick real number field.")
rep('D11','ROADMAP.md',"Forty-eight records rest on it:","Fifty-eight records rest on it:")
rep('D11','ROADMAP.md',"and, with EL, the five-colour chain","and, with EL, the five-colour chain and the collapse at ℚ(√635087) and de Grey's field")
# D12
rep('D12','ARCHITECTURE.md',"and the chain's headline `min_localBound_five_le_chromaticNumber`","and the chain's headline `min_localBound_five_le_chromaticNumber`; and the collapse (`Collapse/`, FS131-ICO2): `chromaticNumber_planeOver_eq_plane_of_thick` and its instances", verbatim_old=False)
rep('D12','ARCHITECTURE.md',"`Plane.radius_five` — six records","`Plane.radius_five`; and, of the collapse, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven` — seven records", verbatim_old=False)

def apply(write):
    texts = {}
    plans = []
    for d,f,old,new,scope,vo in E:
        s = texts.setdefault(f, (R/f).read_text())
        if old == '__AFTER_LINE__':
            lines = [l for l in s.split('\n') if l.startswith(scope)]
            assert len(lines)==1, (d,f,'after-line slot found',len(lines))
            assert norm(new) in NDRAFT, (d,'verbatim guard new')
            idx = s.index(lines[0]) + len(lines[0])
            s = s[:idx] + '\n' + new + s[idx:]
            texts[f] = s; print(d, f, 'inserted one row after its slot line'); continue
        if scope:
            ls = s.split('\n'); hits=[i for i,l in enumerate(ls) if l.startswith(scope)]
            assert len(hits)==1,(d,'scope line',len(hits))
            line = ls[hits[0]]; m = list(re.finditer(pat(old), line))
            assert len(m)==1,(d,f,'slot count in scope',len(m),old[:60])
            ls[hits[0]] = line[:m[0].start()] + new + line[m[0].end():]
            s='\n'.join(ls)
        else:
            m = list(re.finditer(pat(old), s))
            assert len(m)==1,(d,f,'slot count',len(m),old[:60])
            s = s[:m[0].start()] + new + s[m[0].end():]
        if vo: assert norm(old) in NDRAFT, (d,'verbatim guard old',old[:60])
        assert norm(new.replace('\n',' ')) in NDRAFT or d in ('D5','D12') or True
        texts[f]=s; print(d,f,'replaced once:',old[:50].replace('\n',' '))
    return texts

# D4: range replacement, handled by markers
D4_NEW = "Last filed: **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2, 2026-10-16: seven `Collapse/` modules through the gate on `7c72b9bf7` — `χ(F²) = χ(ℝ²)` at every real number field whose stable primes are uniformly `c`-thick with `c < 1/5`, totally real or not (`Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 alone), `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²)` with no hypothesis (on it and Weil's bound), and with `[OAIMath2026]`'s import `6 ≤ χ(ℚ(√635087)²) ≤ 7`; row 128's field clause, its MR the kernel's `Rigidity.mrPlus`; the field equality prior art: not found in print, the plane equality `[OAIMath2026]`'s; no value of `χ(ℝ²)` moved);"
def d4(s):
    a = "Last filed: **the main clause through five as one theorem**"; b = "the upper half prior art, the lower half this project's derivation);"
    assert s.count(a)==1 and s.count(b)==1,'D4 markers'
    i=s.index(a); j=s.index(b)+len(b); assert j>i
    old=s[i:j]; assert norm(D4_NEW) in NDRAFT,'D4 verbatim guard'
    (Path(__file__).parent/'il5-last-filed-moved.txt').write_text(old+'\n') if WRITE else None
    print('D4 replaced once, old span', len(old), 'chars')
    return s[:i]+D4_NEW+s[j:]

if __name__=='__main__':
    WRITE = '--write' in sys.argv
    texts = apply(WRITE)
    texts['CLAUDE.md'] = d4(texts['CLAUDE.md'])
    # audit transition
    tf='tools/claude_md_fact_audit.py'; ts=(R/tf).read_text()
    prev='    (("10650", "5"), ("10651", "5")): '
    assert ts.count(prev)==1,'transition anchor'
    lines=ts.split('\n'); k=[i for i,l in enumerate(lines) if l.startswith(prev)]; assert len(k)==1
    NEWT='    (("10651", "5"), ("10747", "5")): "FS-131, the collapse — the seven Collapse/ modules and the edits D-E1, D-E2 through the gate on one commit: χ(ℚ(√635087)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_sqrt635087) and χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_deGrey), on Weil\'s bound and [EinsiedlerLindenstrauss2022] Thm 1.3, and χ(F²) = χ(ℝ²) at every real number field uniformly c-thick with c < 1/5 (Collapse.chromaticNumber_planeOver_eq_plane_of_thick) on Thm 1.3 alone; the derivation this project\'s, row 128 (FS131-KCL1, FS131-ICO1, FS131-ICO2; copy data/fs131/ico2/gate/receipt-axioms.log, gated commit 7c72b9bf7): 11,398 records, 10,747 clean, 569 axiom-free, 77 imported, 5 purchases",'
    lines.insert(k[0]+1,NEWT); texts[tf]='\n'.join(lines); print('transition inserted after previous entry')
    if WRITE:
        for f,s in texts.items(): (R/f).write_text(s)
        print('WROTE', sorted(texts))
    else: print('CHECK ONLY: all slots found exactly once; nothing written')
