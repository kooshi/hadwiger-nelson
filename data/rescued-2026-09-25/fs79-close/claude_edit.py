import re
p='/home/kooshi/source/lean-dir/CLAUDE.md'
s=open(p).read()
def rep(old,new,count=1):
    global s
    n=s.count(old)
    assert n==count, (n, old[:80])
    s=s.replace(old,new)

# --- Frontier: last updated
rep("*Last updated: 2026-09-23 — **FS-73 closed**",
"*Last updated: 2026-09-24 — **FS-79 closed** (rows 80–81; G73 minted; G71 and G68 scoped): **four colours, cell by cell** — no certificate of non-four-colourability comes from the colour complex one cell at a time (four no-gos, each for its named format: edge-local heights, the loop winding, parity-free face fluxes, coindex topological bounds), and plain density of periodic four-colourings fails in rank 1; **`L21cc6506` is four-colourable and loose at four colours**, so the chain route has no input there; on a finite part of ℚ(√167)'s saturated chain 7 minimal lattices survive capped screens ⟨P3B-FRONTIER⟩. Before that: 2026-09-23 — **FS-73 closed**")

# --- item 14: L21cc6506 at four colours
rep("four colours, at last, where the conjecture predicts six (row 79);",
    "four colours, at last, where the conjecture predicts six (row 79), and at four colours that lattice is loose (row 81);")

# --- item 20 scope
rep("a four-colouring carries no height (`K₄`'s square complex is `ℝP²`), so\n   four colours — where every question the hunt asks lives — have no such criterion, and a two-sided certificate exists only if\n   four-colourability of these graphs is decidable.",
"`K₄`'s square complex is `ℝP²`, whose one loop invariant is each relation's length parity, the same for every colouring (row 80), so four colours — where every question the hunt asks lives — have no such criterion, and a two-sided certificate exists only if four-colourability of these graphs is decidable, which is stated open in print (`[CGHO2025bg]` §6.2.1). At three colours it answers a question posed three times in 2018 — Ellenberg's, Gibbs's, Mixon's (`CLOSED-QUESTIONS.md` §2.4).\n21. **Four colours, cell by cell** (row 80, G73). No certificate of non-four-colourability comes from the colour complex one cell at a time: an edge-local height exists only where `S` has a sum-closed half (rank ≤ 2, always four-colourable; Moore–Newman's triangular lattice is the case) and, from five colours up, on no presentation with two generator classes; the loop winding is the graph's parity; parity-free face fluxes are trivial wherever directions span induced cubes; coindex topological bounds stop at four on every unit-distance graph. Plain density of periodic four-colourings fails in rank 1. **These are no-gos of four named formats, not of a kind of invariant**: window-frequency certificates, cocycles of radius ≥ 2, the index topological bounds and algebraic certificates are open, and at ℚ(√167) they are what is left (FS-80).\n22. **ℚ(√167) at four colours** (row 81). `L21cc6506`, the lattice of `χ ≥ 4`, is four-colourable and loose (`F = P = 0`, a full-dimensional `Θ₄` cell), so the chain route has no input there. On a finite part of the saturated chain 118 of 130 screened lattices four-colour and 7 minimal ones survive capped screens ⟨P3B-ITEM⟩ — survivors, not refusals. Five over ℚ(√167) is FS-59's question.")

# --- prior-art position
rep("the three-colour criterion, density and dichotomy for abelian Cayley graphs and the `Θ` certificate (rows 78–79); every kernel certificate.",
    "the three-colour criterion, density and dichotomy for abelian Cayley graphs and the `Θ` certificate (rows 78–79); the classification of four-colour edge-local heights over every generating set, the four no-gos by format and the rank-1 one-way walls and criterion, and `L21cc6506`'s looseness at four colours (rows 80–81); every kernel certificate.")
rep("**Not ours:** the height lift behind",
    "**Not ours:** the four-colour grid's cohomological triviality (`[CGHO2025coh]`), the triangular lattice's four-colour height (`[MooreNewman2000]`), the Zig-zag Theorem (`[SimonyiTardos2006]`); the periodic-colouring question (`[Ellenberg2018]`; Gibbs and Mixon on Polymath16, 2018); the height lift behind")

# --- ledger pointer
rep("**Rows 1–79 live in `LEDGER.md`**","**Rows 1–81 live in `LEDGER.md`**")

# --- open milestones
old_next=s[s.index("**Next, the default: FS-79"):s.index("stand at rank 2 behind it.")+len("stand at rank 2 behind it.")]
rep(old_next,"")
rep("**Open milestones, in order.** **None is open.** **FS-73 — the rigidity dichotomy — CLOSED 2026-09-23**",
"**Open milestones, in order.** **None is open.** **FS-79 — the invariant question at four colours — CLOSED 2026-09-24** (rows 80–81, G73; `plans/STUB-invariant-question-four-colours.md` carries the banner; `plans/FS79-invariant-question.md`, its §R-close first; `plans/FS79-derivation.md` T1–T43): four no-gos of named formats and plain density false in rank 1 (row 80); `L21cc6506` loose at four colours (row 81); FS-80 minted, FS-59, FS-74 and FS-76 re-aimed. **Next: Kooshi's choice**, advised by a fresh Poros (his request at this close); the table's top is the default only if nothing is chosen. **FS-73 — the rigidity dichotomy — CLOSED 2026-09-23**")
rep("five stubs minted (FS-74 to FS-78).  **FS-71","five stubs minted (FS-74 to FS-78); FS-79 was minted after it. **FS-71",0) if False else None
s=s.replace("five stubs minted (FS-74 to FS-78).  **FS-71","five stubs minted (FS-74 to FS-78). **FS-71")

# --- ranked stubs intro line
i=s.index("**Ranked stubs** (re-ranked 2026-09-23"); k=s.index("`plans/FRONTIER-STUBS.md` is authoritative",i)
s=s[:i]+"**Ranked stubs** (re-ranked 2026-09-24 at FS-79's close: FS-79 closed; FS-59 to rank 1 (re-aimed: the survivors, the next screens, the chain route beyond `L21cc6506`); FS-74 at rank 2 (re-aimed: a many-layer effect, not an edge-local height); FS-80 minted at rank 3; FS-76 re-aimed (plain density false in rank 1; the chirality reduction and the rank-1 criterion proved); FS-9's bearing rewritten; G73 forwarded into FS-59, FS-74, FS-76, FS-80 and FS-9;\n"+s[k:]

# --- table rows
lines=s.split("\n")
def idx(prefix):
    c=[n for n,l in enumerate(lines) if l.startswith(prefix)]
    assert len(c)==1,(prefix,c); return c[0]
fs59_new="| 1 | **FS-59 ℚ(√167): five colours** — `plans/STUB-four-colours-167.md` (§0 first) | Four is proven (row 79); at four colours `L21cc6506` is four-colourable and loose (row 81), so the chain route must look beyond it. **Does ℚ(√167)² need five?** On a finite part of the saturated chain 7 minimal lattices survive capped screens ⟨P3B-TABLE⟩. Next, cheapest first: quotients at `N = 13–24` and longer residue asks on the survivors; the classification at 43; each survivor's `Θ₄` cells (one full-dimensional cell makes it loose, G73); the chain route (G55) on any survivor that stays rigid; derive the `8 ∤ M` pattern; a ball only after, priced by a measured four-colour hardness band | **the conjecture's cheapest exposed prediction and therefore, under the 2026-09-17 target, the falsification target** — predicted ≥ 6 against a proven 4, and FS-66 made the prediction robust to every level of the tower at 23 (row 75) |"
fs80_new="| 3 | **FS-80 a window-frequency certificate at four colours** — `plans/STUB-window-frequency-certificate.md` (minted at FS-79's close) | the one obstruction route FS-79 left open (row 80, G73): an invariant-measure (window-frequency) Farkas certificate of non-four-colourability whose size the point group and the multilayer structure keep small — `Θ₃`'s averaging move at four colours — aimed at ℚ(√167)'s survivors; the advisor's residue-label reading as its first test; beside it the radius-≥ 2 cocycle route (`[CGHO2025coh]` Thm 5.8) and the index topological bounds | speculative; the only solver-free route to five at ℚ(√167) the competition left standing; a size no-go sends five back to arithmetic (FS-59) |"
fs76_new="| 4 | **FS-76 four colours: inheritance, certificates, decidability** — `plans/STUB-four-colour-inheritance.md` | existence and inheritance at four colours for Cayley graphs of ℤ^r (`[Ellenberg2018]`'s question at `k = 4`, `[AbrishamiEtAl2025]` 4.6; plain density is false in rank 1, row 80); the chirality reduction is a theorem and the rank-1 criterion exact (`plans/FS79-derivation.md` T34–T35), so rank 1 closes if \"every phase rigid ⟹ no wall\" is proved; Kooshi's question — a two-sided four-colour certificate exists iff four-colourability is decidable, stated open in print; local instances FS-72 and KR6 | none directly; high on the programme — whether lattice compulsions at four and five colours are always visible to periodic colourings |"
a=idx("| 1 | **FS-79 the invariant question"); lines[a]=fs59_new
b=idx("| 2 | **FS-74 the algebraic explanation**")
lines[b]=lines[b].replace("| 2 | **FS-74 the algebraic explanation** — `plans/STUB-algebraic-explanation.md` (Kooshi's) | ","| 2 | **FS-74 the algebraic explanation** — `plans/STUB-algebraic-explanation.md` (Kooshi's) | **Re-aimed at FS-79's close:** de Grey's rigidity is not an edge-local height even on its own language, and each of its 48 non-Eisenstein unit vectors sits alone in an Eisenstein coset, so the stripes and `8Λ` are a many-layer effect (row 80). ",1)
lines.insert(b+1,fs80_new)
c=idx("| 4 | **FS-76"); lines[c]=fs76_new
d=idx("| 2 | **FS-59 ℚ(√167): five colours**"); del lines[d]
e=idx("| 28–30 | FS-9 topological bounds")
lines[e]="| 28–30 | FS-9 topological bounds (entered at FS-79: the coindex bounds stop at four on every unit-distance graph; the index bounds are the stub's question now, row 80), FS-10 Nullstellensatz certificates, FS-5 bookkeeping | reading rooms and loose ends | low |"
s="\n".join(lines)

# --- grokkings intro range
rep("G1–G72 are","G1–G73 are")

# --- G21 instance
rep("showed a single character of amplitude 0.74 that named the period 23 at once.",
"showed a single character of amplitude 0.74 that named the period 23 at once. **And a one-period census measures its period** (FS-79, row 81): 4,490 orbits of `L21cc6506`'s 4Λ-periodic colourings, every one Kempe-rigid, and two known `Θ₄` cells (a point, a 2-cell) read as a candidate rigid lattice; a three-minute look at the cells themselves found full-dimensional ones and `P = F = 0` — finitely many periodic colourings always meet in a full-rank group, and a finder that stops at its first point measures that point.")

# --- G30 topology
m=re.search(r"unentered: topology, FS-9; commutative algebra,\s*\n\s*FS-10\)", s); assert m
s=s[:m.start()]+"→ topology (entered at FS-79: its cell-local four-colour formats are empty or blind and the coindex bounds stop at four on\n  unit-distance graphs; the index bounds and non-local cocycles are open, row 80); unentered: commutative algebra, FS-10)"+s[m.end():]

# --- G49 instance
rep("no zbMATH or citation search reaches a blog comment. *Do: at every","no zbMATH or citation search reaches a blog comment. **FS-79's instance, the question itself:** searched as a question\n  (WORKFLOW 3.2 item 3), the milestone's structural form was `[Ellenberg2018]`'s MathOverflow question, carried as open with\n  decidability by `[CGHO2025bg]` §6.2.1 and posed on Polymath16 by Gibbs and Mixon in 2018 — FS-73's three-colour theorem had already\n  answered it at `k = 3`. *Do: at every")

# --- G50 instance
rep("*Do: scan, at the opening\n  and before the derivation, every held-but-unread paper whose title touches the milestone.",
"**FS-79's instances:** FS-73 listed both CGHO homshift titles from an\n  arXiv search and never opened them, though one states that milestone's own question as open — so FS-73's close recorded decidability\n  as \"not found\"; and in one competition two theorems were cited from memory (the three-runner lonely-runner theorem, replaced by a\n  direct proof; Nešetřil–Rödl's sparse incomparability, used to decline a held item and still unchecked). *Do: scan, at the opening\n  and before the derivation, every held-but-unread paper whose title touches the milestone.")

# --- G51 run 3
rep("they now live in scratch until hand-back (the protocol document).",
"they now live in scratch until hand-back (the protocol document). **Its third run** (FS-79, 2026-09-24; Kooshi primed the\n  competitors differently — a boat-builder, a tango dancer — with identical information): both first routes took the same face and kind\n  and converged on one theorem (edge-local heights trivial, row 80), with different second lines; retractions de Bruijn 2, Coxeter 2,\n  Poros 0, all free; the prediction that priming would diverge the first routes won only weakly. The owner's and the plan-phase\n  advisor's held sets had converged on one flux construction independently, and both competitors killed it by derivation. A second covert\n  channel: the harness delivers a hand-back to whichever agent last woke the advisor, so an interim hand-back carried Coxeter's progress to\n  de Bruijn, who disclosed it at once; hand-backs are now content-free and every report goes by explicit message (the protocol, rule 1).")

# --- G60 scope
rep("a walls half and a recurrent half (`plans/FS73-derivation.md` T38); at three colours both\n  close (row 79).",
"a walls half and a recurrent half (`plans/FS73-derivation.md` T38); at three colours both\n  close (row 79). *What this entry caps is the one-point densities* (FS-79): window frequencies are not controlled by `χ_f` — their LP is\n  exact in rank 1 (row 80) — and FS-73's `Θ₃ = ∅` is itself an averaged pair statistic plus integrality [reading, Poros], so G72's\n  averaging move is not capped here (FS-80).")

# --- G68 scope
rep("so a lattice is loose exactly when finitely many periodic colourings' Kempe period groups meet in 0, a gap being the case of an\n  isolated component.",
"so finitely many periodic colourings whose Kempe period groups meet in 0 make a lattice loose, a gap being the case of an isolated component — sufficient, not necessary: `L21cc6506` is loose through a full-dimensional `Θ₄` cell, infinitely many periodic colourings, while all 4,490 orbits of one period have full-rank Kempe groups (row 81; whether finitely many already meet in 0 there is open).")
rep("compute the Kempe period groups before calling a lattice rigid.*","compute the Kempe period groups, and the `Θ_k` cells (G73), before calling a lattice rigid.*")

# --- G71 scope
rep("complex is `ℝP²` (the cube modulo its antipode), so a four-colouring carries only a winding in `Hom(R, ℤ/2)`: no height, no slope,\n  no polytope — `G(ℤ, {1,3,4,5})` four-colours with no linear colouring — and whatever makes de Grey's lattice rigid at four colours\n  (`F = 8Λ`, row 78) is not this mechanism.",
"complex is `ℝP²` (the cube modulo its antipode), whose one loop invariant, the ℤ/2 winding in `Hom(R, ℤ/2)`, is each relation's\n  length parity, fixed by the graph (row 80): no height, no slope, no polytope from loops. An edge-local height exists only where `S`\n  has a sum-closed half (Moore–Newman's triangular lattice and its degenerations, rank ≤ 2, all four-colourable; the grid's absence of\n  one is `[CGHO2025coh]` Thm 1.1, FS73-T29's prior art), so the absence holds wherever a certificate is wanted (G73) — `G(ℤ, {1,3,4,5})`\n  four-colours with no linear colouring — and whatever makes de Grey's lattice rigid at four colours (`F = 8Λ`, row 78) is not a height\n  of this kind, even on its own language.")
rep("At four colours expect no slope, no linear criterion and no\n  two-sided certificate: a refusal there is still a finite graph.",
"At four colours expect no slope, no linear criterion and no\n  two-sided certificate (decidability is stated open in print): a refusal there is a finite graph, or an averaged or non-local\n  certificate (G73).")
rep("and a `Θ`-type two-sided certificate at four colours.","and a `Θ`-type certificate built from edge-local heights at four colours anywhere in the class.")
rep("a four-colour rigidity theorem over a class of lattices\n  that uses no arithmetic of the lattice.*","a four-colour rigidity theorem over a class of lattices\n  that uses no arithmetic of the lattice — not met at FS-79 (P-G71).*")

# --- G72 first count
rep("If the structural question keeps producing nothing a direct attack would not, the method is ceremony.*",
"If the structural question keeps producing nothing a direct attack would not, the method is ceremony.*\n  **First count (FS-79, `plans/FS79-invariant-question.md` §R-close.3):** the class-level results — four no-gos of named formats and\n  the rank-1 criterion (row 80) — came through the structural question, by derivation; the instance result — `L21cc6506` loose (row\n  81) — came from an exact computation, an extension of FS-73's `Θ` tree, aimed at a derived claim by the advisor's question; and the\n  *Do*'s last sentence was missed once (the new tool not aimed at phase 0's survivors the day it landed; run the next day as P3b).")

# --- G73 new (insert before G51)
g73=open('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-close/g73.txt').read().rstrip("\n")
rep("* **G51 — A competitor and an advisor beat one mind.", g73+"\n* **G51 — A competitor and an advisor beat one mind.")

# --- toolchain: pysat CaDiCaL interrupt
rep("**Venvs and package depots live outside `build/`**",
"**A pysat solver's interrupt is per back-end** (FS-79 phase 0): pysat's CaDiCaL back-ends ignore `interrupt()` — \"Limited solve is\ncurrently unsupported by CaDiCaL\" is raised inside the timer thread, so a Timer budget never fires and the solve runs unbounded. Bound a\npysat CaDiCaL ask by a parent-enforced subprocess timeout (external kissat or cadical), or use a back-end that supports `solve_limited`.\n\n**Venvs and package depots live outside `build/`**")

# --- gate: waiter instance
rep("PIDs cannot self-match; patterns always can.",
"PIDs cannot self-match; patterns always can. **Fourth instance (FS-79 phase 0): a waiter on the log of a chain\nthat had already been killed and replaced** — its condition could never become true, and it was found only at the phase's end. Arm a\nwaiter on the live job's pid, and re-arm it whenever the job it watches is replaced.")

open(p,'w').write(s)
print(len(s.encode()))
