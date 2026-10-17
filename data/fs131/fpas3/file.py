#!/usr/bin/env python3
"""File FS131-PAS3's § 3.4 items 1, 4, 7, 8, 9 and FS131-PAS2's § 2.4 item 2 (item 1086) verbatim.
Every slot found exactly once, whitespace-insensitive, before anything is written; all or nothing.
Usage: file.py [--plant]"""
import re,sys
ROOT="/home/kooshi/source/lean-dir/"
E=[]  # (file, slot, new, mode) mode: 'rep' replace slot; 'after' insert new text right after slot; 'line' insert new line(s) after slot's line
E.append(("CLOSED-QUESTIONS.md",
"nothing after 2006 searched; `[Zaks1989]` (the density of the colour classes) is held by reviewer's text only;",
"searched after 2006 (FS131-PAS2, FS131-PAS3, 2026-10-17): not found in print. `[Johnson2010]` p. 169 poses it again in 2011 with this answer as its guess (*\"I think that the same answer holds for n = 4, but this has not been shown\"*). In print beside it, `[KubickiLehelMorayne2002]` Thm 4.3 (p. 50): *\"Every 4-coloring of ℚ⁴ is S³-dense and, therefore, rigid\"* — rigid meaning that a colouring's trace on any open set determines it (p. 49), which bounds no count of colourings: it follows from the residue structure above (FS131-PAS3, [hand], one mind) and does not give it, and it names no forced pair and no second distance; neither of Johnson's posings cites it. `[Zaks1989]` (the density of the colour classes) is held by reviewer's text only, with `[KubickiLehelMorayne2002]` p. 50's account of its tetrahedron lemma; the similarity step is `[BauJohnsonNoble2021]` Thm 3.3;",
"rep"))
E.append(("CLOSED-QUESTIONS.md",
"the *only if* the half p. 212 calls open. **Not closed:** a gate; the kernel." if False else "the *only if* the half p. 212 calls open. **Not claimed:** a gate; the kernel.",
"- **Periods of four-colourings of `ℚ⁴`.** Johnson–Voloshin 2007 p. 66, Question 2: *\"Can a 4-coloring of ℚ⁴ forbidding the distance 1 ([2], [5]) be found with a dense group of periods? Can such a 4-coloring be found with P = {0, 0, 0, 0}?\"* Every one has a dense group of periods, so none has `P = {0}`: it contains the subgroup the vectors of length `√2` generate, by `[Zaks1999]` Lemma 1 (p. 94 says those components are monochromatic and dense). The intersection of all of them is exactly `{x : v₂(|x|²) ≥ 1}` (LX-T4, [hand], one mind).",
"line"))
E.append(("BIBLIOGRAPHY.md",
"| C7's one unread candidate: its withheld summary contains \"Q^4 is rigid\", \"every 4-coloring of\", \"uniquely extend\" (zbMATH phrase probes, FS131-PAS2) | not held; Elsevier open archive, ScienceDirect refuses scripted fetches | not read |",
"| **Nothing of ours rests on it; C7's structure clause reproves its Thm 4.3.** Thm 4.3 (p. 50): *\"Every 4-coloring of ℚ⁴ is S³-dense and, therefore, rigid\"*, where a colouring is rigid when *\"its trace on any relatively open nonempty subset of D determines the coloring globally\"* (p. 49), proved from `[Zaks1989]`'s tetrahedron lemma (as KLM report it) and a rational regular unit tetrahedron on every unit edge (checked, FS131-PAS3). Rigid is not unique: Thm 4.3 follows from C7's residue form (FS131-PAS3, `klm43-from-structure`), and the paper's own rigid three-colouring of `ℚ²` (Thm 4.6, additive mod 3) and its mirror image differ on one component by no renaming (`rigid-not-unique`). No forced pair, no second distance, no quaternion algebra. Also: Thm 3.1 with its measure remark (p. 47), `χ(A) = χ(ℝⁿ)` for every residual or full-measure `A ⊆ ℝⁿ`, by de Bruijn–Erdős and a translate (row 130's translation step, an earlier printed instance); Thm 3.2 and Cor. 3.3, a patch `k`-colouring of `ℚⁿ` gives a `k`-colouring of `ℝⁿ`; Thm 4.4, `S^{n−1}`-density of every `m`-colouring of `G(Fⁿ)` when `χ = m`, a maximal complete subgraph has `m` vertices and `m − 1 ≠ 2^r` (proof omitted). Cited by none of `[Johnson2006]`, `[Johnson2010]`, `[Soifer2024]`; no citer in OpenAlex | held: `library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (browser save, 2026-10-17) | **read in full (FS131-PAS3, 2026-10-17)** |",
"rep"))
E.append(("BIBLIOGRAPHY.md",
"the density theorem, settling a problem of Johnson",
"; second-hand through `[KubickiLehelMorayne2002]` pp. 49–51 (FS131-PAS3): its Theorem 1 is the density theorem, its proof uses the lemma *\"if x, y, u, w ∈ ℚ⁴ are vertices of a regular tetrahedron of unit side length, then, for every ε > 0, the set (S³ + x) ∩ B(y; ε) contains infinitely many points of all colors different from that of x\"*, the tetrahedron `{0, (1, 0, 0, 0), (½, ½, ½, ½), (½, −½, ½, ½)}` is *\"also used in [16]\"*, and a Theorem 2 for other fields is what KLM's Thm 4.4 extends",
"after"))
E.append(("BIBLIOGRAPHY.md",
"| Noble 2012 (Zbl 1262.05121) |",
"\n".join([
"| **`[Chilakamarri1991]`** K. B. Chilakamarri, *Unit-distance graphs in Minkowski metric spaces*, Geom. Dedicata 37 (1991) 345–356, Zbl 0716.05022 | Listing only (`[KubickiLehelMorayne2002]` [3]); not held; no bearing on C7 |",
"| **`[Hadwiger1944]`** H. Hadwiger, *Ein Überdeckungssatz für den Euklidischen Raum*, Portugal. Math. 4 (1944) 140–144, Zbl 0060.40610 | Listing only (`[KubickiLehelMorayne2002]` [4], which prints the title *\"Überdeckungssätze für den Euklidischen Raum\"*); not held; no bearing on C7 |",
"| **`[JensenToft1995]`** T. R. Jensen, B. Toft, *Graph Coloring Problems*, Wiley 1995, Zbl 0855.05054 | Listing only (`[KubickiLehelMorayne2002]` [5]); not held; no bearing on C7 |",
"| **`[Pach1997]`** J. Pach, *Finite point configurations*, Handbook of Discrete and Computational Geometry, CRC 1997, 3–18, Zbl 0914.51012 | Listing only (`[KubickiLehelMorayne2002]` [8]); not held; no bearing on C7 |",
"| **`[Szekely1999]`** L. A. Székely, *Erdős on unit distances and the Szemerédi–Trotter theorems*, abstracts of invited talks, Budapest 1999, 60–65 (the later chapter Zbl 1035.05037) | Listing only (`[KubickiLehelMorayne2002]` [12]); not held; no bearing on C7 |"]),
"line"))
E.append(("LEDGER.md",
"a step not printed (two readers, the consolidation run's LW and LW2).",
" An earlier printed instance of the translation step: `[KubickiLehelMorayne2002]` Thm 3.1 with its measure remark (p. 47), `χ(A) = χ(ℝⁿ)` for every residual or full-measure `A ⊆ ℝⁿ`, by de Bruijn–Erdős and a translate of the finite witness into `A` — for colourings proper on every unit pair inside such a set, with no measurability asked; N-EASY's hypothesis (measurable, proper at almost every unit pair) is neither weaker nor stronger (FS131-PAS3 § 2.7).",
"after"))
def pat(s): return re.compile(r"\s+".join(re.escape(t) for t in s.split()))
if "--plant" in sys.argv: E[0]=(E[0][0],E[0][1].replace("2006","2007",1),E[0][2],E[0][3])
texts={}
for f,_,_,_ in E: texts.setdefault(f,open(ROOT+f).read())
for i,(f,old,new,mode) in enumerate(E):
    n=len(list(pat(old).finditer(texts[f]))); print(f"slot {i+1} {f}: {n} match(es)")
    if n!=1: print("FAIL: not exactly once"); sys.exit(1)
order=sorted(range(len(E)),key=lambda i:(E[i][0],-pat(E[i][1]).search(texts[E[i][0]]).start()))
for i in order:
    f,old,new,mode=E[i]; s=texts[f]; m=pat(old).search(s)
    if mode=="rep": s=s[:m.start()]+new+s[m.end():]
    elif mode=="after": s=s[:m.end()]+new+s[m.end():]
    else:
        e=s.index("\n",m.end()); s=s[:e+1]+new+"\n"+s[e+1:]
    texts[f]=s
for f,s in texts.items(): open(ROOT+f,"w").write(s)
print("filed",len(E),"items")
