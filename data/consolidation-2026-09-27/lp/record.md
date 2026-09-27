# Job LP — the papers: record

*Job LP of the consolidation and library run, 2026-09-27 (brief `data/consolidation-2026-09-27/briefs/LP-papers.md`; standing rules
`…/briefs/STANDING-RULES.md`). de Bruijn, Opus 5.5. HEAD at launch: a5fe409d. Every quotation below is verbatim, with its journal page;
the full transcriptions are in the reading notes under `~/source/library/notes/` (outside the repository, beside the scans).*

## Theorems this phase proved

*(Filled as they come; none at stage 1 — stage 1 is a reading.)*

## Stage 1 — SAVED

### `[Johnson2006]`, read in full

P. D. Johnson Jr., *Coloring the rational points to forbid the distance one — a tentative history and compendium*, Geombinatorics XVI(1)
(July 2006) 209–218. Read in full from renders at 150 dpi (`~/source/library/pdf/johnson-2006-…-209-218.pdf`, six sheets, pp. 208–219).
Transcription, reference list and the field-plane log: `~/source/library/notes/johnson-2006-reading.md`. No word of the scan was uncertain.

**What it is.** A ten-page survey of `χ(G(ℚⁿ, 1))` with one page (pp. 212–214) on planes over real quadratic and biquadratic fields —
every result there attributed to Johnson 1987 (`[Johnson1987]`, his [11]) or to Fischer (`[Fischer1990]`, `[Fischer1994]`, his [7], [8]).
**Contrary to `[Johnson2010]`'s description, it prints no table and no value for `G(ℚ(√m)², D)` beyond Johnson's and Fischer's** —
it holds nothing on residue planes, finite planes, number fields of degree ≥ 3, or lower bounds above three for any quadratic field.

**The three findings.**

1. **It poses our question, as open, in 2006 — and our rows answer it.** p. 214, verbatim: *"I think that the following is an open
   problem: does there exist a positive integer m such that χ(G(ℚ²(√m), 1)) ≥ 4? The same question with "≥" replaced by ">" is very
   interesting, if the answer is yes!"* The "≥" question is answered **yes, m = 11, with the lower bound in the kernel** (`LEDGER.md` row 73:
   `four_le_chromaticNumber_planeOver_eleven`; the upper bound 4 is `[Fischer1990]` Thm 10(i), prior art), and for every squarefree
   `m ≡ 11 (mod 12)` at [hand, two derivations] (row 82). The ">" question is answered **yes, m = 47: `χ(ℚ(√47)²) = 5`** at [hand],
   through MR (row 121; in the kernel only over named hypotheses, row 127). → a new `CLOSED-QUESTIONS.md` row (stage 2).
2. **It records `[Fischer1994]`'s value in print in 2006.** p. 214: *"In [8] Fischer proves that if p and q are square-free relatively
   prime positive integers satisfying p ≡ 3 mod 16, q ≡ 11 mod 16, and pq ≡ 1 mod 32, then G(ℚ²(√p, √q), 1) has an additive 4-coloring.
   Since G(ℚ²(√3, √11), 1) contains the Moser spindle, it follows that χ(G(ℚ²(√3, √11), 1)) = 4."* So the value was not only in a
   proceedings volume no database indexes: it was in the survey `[Soifer2024]` ch. 11 sends its readers to. Every later posing of
   `CLOSED-QUESTIONS.md` §1.1 (rows 2–7, 2010–2025) missed a 2006 survey as well as the 1994 paper. **Two statements in our files are now
   false**: that `[Fischer1994]` "is in no citation database and nothing cites it" (`WORKFLOW.md` step 3.2 item 8, `BIBLIOGRAPHY.md`
   `[Fischer1994]`, `CLOSED-QUESTIONS.md` §1.1) — `[Johnson2006]` cites it as its [8]. The half about citation databases stands.
3. **Theorem A's coset construction is `[Fischer1990]` Thm 1(i), and Johnson prints its general Cayley form.** p. 213, verbatim:
   *"If S is an additive subgroup of ℝⁿ and D ⊆ (0, ∞), … An additive k-coloring of G(S, D) is a proper coloring achieved by finding a
   group homomorphism of ⟨S_D⟩ into some abelian group of order k so that each u ∈ S_D is mapped to a non-zero group element, which
   assures that G₀(S, D) is properly colored, and then copying the coloring on the other components of G(S, D), which are copies of
   G₀(S, D) associated with the cosets of ⟨S_D⟩ in S."* Checked in the source the same stage — `[Fischer1990]` p. 181 defines an
   additive k-colouring as *"A group homomorphism v: C₀(F^d) → G to an additive group G of order k so that v(ξ) ≠ 0 whenever ‖ξ‖ = 1"*
   (`C₀` the subgroup the unit vectors generate), and his Theorem 1(i), p. 183, proves *"If F^d has an additive k-coloring, then F^d can
   be k-colored"* by exactly the coset copy: *"Since the connected components of F^d are translates of C₀(F^d), to k-color F^d it
   suffices to k-color C₀(F^d)."* So the homomorphism out of a subgroup that is not the whole group (and, for `d ≥ 3`, not a ring),
   extended coset by coset — the step `[Madore2015]` Prop. 3.9 *"has not found the courage to try to formulate under the most general
   auspices"* — was in print in 1990 for every `F^d`, and in 2006 for every `G(S, D)`. **What stays ours in Theorem A**: the statement
   for an arbitrary graph drawn in an arbitrary abelian group (no metric, torsion allowed, any subgroup containing the edge differences),
   which is a routine abstraction of Fischer's, and the kernel proof. Our records credited Fischer's Thm 1 only with "the unit argument".

**Verdicts on our claims** (the brief's list). *Pre-empted* = the attribution moves; *partly* = the part named; *not found* = not in it.

| our claim | verdict | Johnson 2006's words (page) |
|---|---|---|
| Row 52 — the finite-plane bound `χ(F²) ≤ χ(Γ_q)`, `χ(Γ₁₁) = 5` | **not found** | no finite or residue plane appears |
| Row 53 — the field sieve, `chromaticNumber_finitePlane11`, `chromaticNumber_heule510` | **not found** | — |
| Row 54 — the lift | **not found** | — |
| Row 55 — the residue obstruction, the distance law | **not found** | — |
| Row 56 — local–global tightness | **not found** | — |
| Row 57 — Theorem B's value `χ(K²) = 4` | **already moved** (`[Fischer1994]`); Johnson 2006 is a second printed statement, 2006 | p. 214, quoted in finding 2 |
| Row 57 — Theorem B's `𝔽₄` residue colouring, kernel proof | **not found** | Fischer's colouring is the additive `ℤ/4` one (p. 214) |
| Row 57 — Theorem A's general form | **partly** — the construction is `[Fischer1990]` Thm 1(i) (for `F^d`), stated by Johnson for every `G(S, D)`; ours is the metric-free abstraction and the kernel proof | p. 213, quoted in finding 3 |
| Row 63 — two colours: the quadratic case | **already credited** (`[Johnson1987]`, `[Fischer1990]` Thm 8) | pp. 212–213: *"if m ≡ 1 or 2 mod 4, then there is a 2-coloring of (ℚ(√m))² = ℚ²(√m) which forbids all the distances √(p/q)"*; *"Fischer [7] shows that χ(G(ℚ²(√m), 1)) > 2 for all square-free positive m ≡ 3 mod 4"* |
| Row 63 / G38 — the multiquadratic two-colour iff; the 2-adic decomposition; `CompositumFive` | **not found** | its only multiquadratic item is Fischer's additive 4-colouring (p. 214); its one general two-colour fact is Fischer's regular-polygon theorem (p. 214) |
| Row 73 — `χ(ℚ(√11)²) = 4`; four at 23, 47, 71, 95, 191 | **not found; posed as open on p. 214** | finding 1 |
| Row 79 — the three-colour criterion; `χ(ℚ(√167)²) ≥ 4` | **not found** | p. 213–214: *"Fischer also shows that there is no additive k-coloring of G(ℚ²(√167), 1) for k ≤ 10, but there is certainly a (proper) 7-coloring"* |
| Rows 82–83 — from additive to all three-colourings; T4; the census | **not found; the gap is named** | p. 213: *"non-existence of an additive k-coloring does not imply the non-existence of a k-coloring"* — exactly the step row 82 takes; the additive half (`m ≡ 23 mod 24`, no additive `k ≤ 6`) is Fischer's, already credited |
| Row 99 — three colours over every real number field | **not found** | only the quadratic value 3 at `m ≡ 3, 7 (mod 12)`, Fischer's (p. 213), already credited |
| Rows 119–123 — `χ(ℚ(√167)²) ≥ 4` in the kernel; MR; `χ(ℚ(√47)²) = 5`; the main clause through five | **not found; the ">" question posed on p. 214** | finding 1 |
| Row 132 — the regular half | **not found** (Woodall 1973 appears for `ℚ²` only, p. 209) | — |
| The bridge `χ(ℝ²) = sup_F χ(F²)` (`LEDGER.md` § Not ours: *"(`[Madore2015]` ¶5.4, by Tarski; noted by `[BendaPerles2000]`)"*) | **attribution to move to `[BendaPerles2000]`, pending stage 2's reading of the source** | p. 214: *"in one of the most spectacular and subsequently neglected (my opinions) sections of [2], it is shown, using some fancy Tarskian logic and the well known compactness result of de Bruijn and Erdős [6] on coloring infinite graphs, that for each n there is a finite (dimensional) real algebraic extension F of ℚ such that χ(G(Fⁿ, 1)) = χ(G(ℝⁿ, 1))"* |

**Values printed for a field plane**, all logged with pages in the reading note: `ℚ²`: 2; `ℚ³`: 2; `ℚ⁴`: 4; `ℚ⁵…ℚ⁸`: ≥ 7, 10, 13, 16;
`ℚ(√m)²`: 2 for `m ≡ 1, 2 (mod 4)`, > 2 for `m ≡ 3 (mod 4)`, 3 for `m ≡ 3, 7 (mod 12)`, no additive `k ≤ 6` for `m ≡ 23 (mod 24)`, no
additive `k ≤ 10` at `m = 167`; `ℚ(√3,√11)²`: 4; Fischer's biquadratic family: an additive 4-colouring. **No value contradicts a row of ours.**

**Other open questions it poses** (for `CLOSED-QUESTIONS.md` §3 only if we are placed to answer; we are not): p. 212, *"For which d > 0
does there exist a 4-coloring of ℚ⁴ which forbids both distances 1 and d?"* — nothing of ours answers it (row 57's quaternion remark gives
the four-colouring of `ℚ⁴` forbidding 1, not the set of `d`). Not listed.

### Reference list mined (24 references) → `BIBLIOGRAPHY.md`

Existing entries updated with "cited as [n] by `[Johnson2006]`" and any discrepancy: `[BendaPerles2000]`, `[Chilakamarri1988]`,
`[deBruijnErdos1951]` (Johnson prints pp. 369–373; zbMATH 371–373), `[Fischer1990]`, `[Fischer1994]`, `[Johnson1987]` (Johnson's own
shorter title), `[Johnson1990]`, `[JungreisReidWitte1990]` (statement now read in Johnson's words, still not the paper), `[Woodall1973]`,
`[Zaks1989]` (Johnson prints 1980 — a typo; zbMATH 1989), `[Zaks1992]`. New § C rows, each **[title from `[Johnson2006]`'s reference
list]**, metadata checked against zbMATH: Abrams–Johnson 2001, Chilakamarri 1990, Chilakamarri 1993, Frankl–Wilson 1981, Johnson 1982,
Johnson–Lee 2006, Larman–Rogers 1972, Mann 2001, Mann 2003, Schoenberg 1937, Soifer 1991, Trick (web), Zaks 1999. None bears on a field
plane beyond `ℚⁿ`, by Johnson's own account of them; none is a stage-4 fetch target.

### Would have searched here

Nothing (a reading).
