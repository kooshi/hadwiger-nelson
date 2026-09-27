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

## Stage 2 — SAVED

### `[BendaPerles2000]` with Johnson's introduction, and `[Johnson2000]`, read in full

Both from the full issues the journal's archive returned (vol. IX no. 3, sheets 7–15 = pp. 110–127; vol. IX no. 4, sheets 9–13 =
pp. 170–179), rendered at 150 dpi. No word uncertain. Verbatim transcriptions of every statement and question:
`~/source/library/notes/benda-perles-2000-and-johnson-intro-reading.md`, `~/source/library/notes/johnson-2000-reading.md`.

**Findings.**

1. **`[Johnson2000]` poses our four-colour family by name, as open, in 2000.** p. 176: *"But the determination of χ(ℚ²(√m), 1) for
   m ≡ 11 mod 12 (m positive, square-free) is still open. Fischer does show that if m ≡ 3 mod 8, then χ(ℚ²(√m), 1) ≤ 4, so, those searching
   for a counterexample to the conjecture that χ(ℝ², 1) = 4 might start by looking at (ℚ²(√23), 1)."* With `[Johnson2006]` p. 214 (stage 1),
   this is `CLOSED-QUESTIONS.md` §1.7's question posed twice in print by the field's surveyor. Answered: χ ≥ 4 for every such `m` (row 82,
   [hand]; ℚ(√11) in the kernel, row 73), `χ = L` wherever `L ≤ 5` (rows 99, 123), open where `L ≥ 6`; ℚ(√23), his suggested start, has
   χ = 4 (row 73, tools-certified; upper bound prior art).
2. **`[Johnson2000]` also states `[Fischer1994]`'s value** (p. 176) — so it was in print in 1994, 2000 and 2006.
3. **The bridge is Benda–Perles's (1976; printed 2000).** pp. 117–118, verbatim: *"there is a theorem of Tarski which says that the theory
   of real closed fields is complete (see e.g. [1]). This implies that the above sentence if true in the reals is true in all real closed
   fields, in particular in the field of algebraic reals. Consequently, the Erdös four-color conjecture, is true iff it is true of the
   algebraic plane A², A being the field of the algebraic reals."* `LEDGER.md` § Not ours credits the bridge to *"`[Madore2015]` ¶5.4, by
   Tarski; noted by `[BendaPerles2000]`"*, and row 107's prior-art clause to *"`[Madore2015]` ¶5.4 with ¶1.3 (Tarski), noted by
   `[BendaPerles2000]` (unread)"*: the attribution moves to Benda–Perles, with Madore's a later restatement (stage 5). `[Johnson2000]` §3,
   p. 174, sharpens it: *"What they have proven really is that every finite subgraph of (ℝ², 1) is (isomorphic to) a finite subgraph of
   (𝔸², 1)."* — which is exactly what row 107's `RealAlgebraicDescent` (an existential equational transfer) is shaped for.
4. **Open Problem 11.6 verified from the source** — `[BendaPerles2000]` p. 126, Open Question (4): *"Find the chromatic number of Q²(√2) and,
   in general, of any algebraic extension of Q²."* — the same words as `[Soifer2024]`'s Open Problem 11.6. FS-20's open item R3 (quote it
   from the source) is met. Its first form, p. 121: *"But we have not thought of the chromatic number for, say G₁(Q²(√2)) or of other
   extension and we leave this as an open problem."* Johnson 2000 restates it as Problem 4.4, with *"any finite algebraic extension 𝔽"*.
   FS-91's gate called Fischer's question `[Johnson2000]`'s "problem (1)"; it is his Problem 4.4 (corrected in `CLOSED-QUESTIONS.md` §2.6).
5. **`[Johnson2000]` §5 poses the unit-vector-group question** (p. 177): *"the problem of characterizing the additive group A generated by
   the unit vectors in 𝔽ⁿ, where 𝔽 is a finite real algebraic extension of ℚ. In particular, it would be nice to know whether or not A = 𝔽ⁿ,
   i.e., whether or not (𝔽ⁿ, 1) is connected."* … *"the cases of algebraic extensions of ℚ² other than of the form ℚ²(√N₁, …, √N_t) await
   scrutiny."* Row 100's Lemma C′ (`R_F = O′`, [hand], three derivations) answers it at `n = 2` for every real number field outside the
   ramified-stable-dyadic exception; disconnectedness for every real number field is a two-line corollary [derived]. New §2.7.
6. **The unit-vector ring of ℚ is Benda–Perles's**: p. 120, *"H² consists of all (a,b)/e with (a, b, e) = 1 where e is a product of primes
   of the form 4k + 1"*, and p. 121, closed under complex multiplication — `ℤ[i][1/p : p ≡ 1 (mod 4)]`, the ring of rows 95–98, is theirs
   (1976). And `χ(ℚ²) = 2` is proved (p. 120) by the parity of that group extended coset by coset — the construction of Theorem A for `ℚ²`.
7. **Benda–Perles's Open Question (2) is closed by others**: *"whether every finite subgraph of G₁(R²) (or of G₁ (algebraic plane)) is
   embeddable into G₁(Q⁴)"* — no, since `[deGrey2018]` (five colours) against their `χ(ℚ⁴) = 4`. Listed in `CLOSED-QUESTIONS.md` §3 so it is
   not re-closed; not ours.

**Verdicts on our claims** — both papers, the list of stage 1:

| our claim | `[BendaPerles2000]` | `[Johnson2000]` |
|---|---|---|
| Rows 52–56 (residue planes) | not found | not found |
| Row 57, Theorem B's value | not found (1976) | **already moved** (`[Fischer1994]`); a printed statement, p. 176 |
| Row 57, Theorem A | **partly**: the parity colouring of `H²` extended to cosets (p. 120) is the construction for `ℚ²` (stage 1's attribution to `[Fischer1990]` Thm 1(i) stands) | describes additive colourings (p. 176), nothing more |
| Row 57, the quaternion remark (`χ(ℚ⁴) ≤ 4` via the Hurwitz order) | **the value and the index-2 structure are theirs** (pp. 122–125, `[H⁴ : D] = 2`, `H⁴` closed under quaternion multiplication) — already recorded "not new" | — |
| Row 63 / G38, two colours | quadratic: not in it (only `ℚ², ℚ³`); multiquadratic iff: **not found** | quadratic case `[Johnson1987]` (p. 176, already credited); multiquadratic iff **not found** |
| Rows 73, 82–83 | not found | **not found; posed as open, p. 176** |
| Row 79, 99, 119–123, 132 | not found | not found |
| Row 100, Lemma C′ | `ℚ`'s case is theirs (p. 120) | **the general question posed, p. 177**; `ℚ(√N)` cases `[Fischer1990b]` |
| Row 107, the bridge | **pre-empted in substance** (pp. 117–118); row 107's kernel form and Lemma NP stay ours | §3 states it as an embedding theorem |

**`CLOSED-QUESTIONS.md` rows written (stage 2):**
- §1.1 — the box: the value restated by `[Johnson2000]` p. 176 and `[Johnson2006]` p. 214; row 1 quoted from `[BendaPerles2000]` p. 126
  with its p. 121 form and Johnson's Problem 4.4; Status: `[Johnson2006]` no longer a blocker.
- §1.2 — rewritten: **answered in print before it was posed**, `[Fischer1990]` Thm 1(i) and `[Johnson2006]` p. 213; ours is the
  metric-free, arbitrary-group statement and the kernel proof; Status: it can no longer be FS-20's headline (draft for the owner below).
- §1.7 — **recorded as answered** (its hold on the two Johnson papers released): the two Johnson postings quoted; Johnson 2006's "≥ 4"
  yes at `m = 11` (kernel lower bound), ">" yes at `m = 47` ([hand], through MR); Johnson 2000's family determined wherever `L ≤ 5`, open at
  `L ≥ 6`; the prior-art paragraph and the value's gate updated.
- §2.3 — the two candidate sources checked: `[Johnson2006]` (and `[Johnson2000]`, `[BendaPerles2000]`) do not hold the multiquadratic
  iff; `[AxenovichEtAl2014]` §3–§4 by their statements (convex position, strips, parallel lines), and its Thm 2.3's two-colour clause is a
  sufficient condition on `ℚ × ℝ` subsets, not the iff for `F²` (a generator condition fails for `F²`: ℚ(√2,√6) holds √3). **Not found in
  print.**
- §2.6 — title and prior-art sentence: the two Johnson papers read, not found in either; the question's addresses corrected (Benda–Perles
  (4); Johnson's Problem 4.4, not "problem (1)").
- **§2.7 (new)** — `[Johnson2000]` §5's unit-vector group: answered at `n = 2`, [hand] (row 100's Lemma C′), with disconnectedness
  [derived]; open at `n = 3, 4`.
- **§2.8 (new, the owner's addition, Kooshi's ruling "Yes, as partial")** — `[SokolovVoronov2025]` Question 2, quoted from the held copy
  (arXiv v1 p. 26; Condition 5, p. 4): yes under Condition 5, almost everywhere, row 134's sentence and grade clause verbatim; the unit-arc half
  open (FS-112). Polarity checked: the question asks *"Is it true that 7 colors are needed …?"*; row 134 answers *"yes"*; the row says yes.
- §3 — the smallest-field item released from §1.7's hold; Benda–Perles's Question (2) listed as closed by others.

**Other open questions they pose, not listed** (nothing of ours bears): Benda–Perles (1), (3); p. 116 (`ℓ¹` on `R³`), p. 117 (the least
graph in `G₁(R², e)` not in `G₁(R², b)`), p. 122 (`χ(G_a(Q³)) = 3` for some `a`?); `[Johnson2000]` p. 172 (the smallest such graph; the
ratio question), pp. 172–173 (`K₅` in every normed plane; graphs in every `ℓ^p`, `p ∈ [p₁, p₂]`), p. 175 (*"is every countable subgraph of
(ℝ², 1) realizable as a subgraph of (𝔸², 1)?"*), 4.1.

### References mined → `BIBLIOGRAPHY.md`

`[Johnson2000]`'s fifteen and `[BendaPerles2000]`'s four, and the one paper Johnson's introduction names. Updated in place: `[Chilakamarri1988]`,
`[deBruijnErdos1951]`, `[Fischer1990]`, `[Fischer1990b]`, `[Fischer1994]`, `[Johnson1987]`, `[Johnson1990]`, `[Zaks1992]` (Johnson 2000 prints
pp. 307–311), `[Isbell / HDK1964]`, `[Johnson1996fcn]`, and the § C rows `[FranklWilson1981]`, `[Chilakamarri1990]`. New § C rows:
`[ChilakamarriMahoney1995]`, `[PurdyPurdy1988]`, `[Zaks1990conn]` (a candidate read for §2.7's connectivity half, quadratic only),
`[ChangKeisler1973]`, `[ErdosEtAl1973]`, `[Sierpinski1964]`. § B: the two issue files; `[BendaPerles2000]`'s single-paper scan marked read.
Rules 0d and 0e updated. `python3 tools/bib_audit.py`: exit 1, **for one key not mine** — `[GwynStavrianos2022]`, first seen in
`data/consolidation-2026-09-27/lw/record.md` (job LW's); every key this job added resolves.

## Stage 3 — SAVED

### `[Townsend2005]` read in full, compared with `[Townsend1979ms]` and `[Soifer2024]` ch. 25

`~/source/library/geombinatorics/geombinatorics-v14-n4-2005-04.pdf`, sheets 5–9 = pp. 184–193 (and Soifer's featured essay, *On Stephen P.
Townsend's 1979 proof*, pp. 181–183), rendered at 150 dpi; compared line by line with the manuscript's and the book's text layers. Reading
note with every difference: `~/source/library/notes/townsend-2005-reading.md`.

**Is the printed text the manuscript's? Yes — word for word in every definition, theorem and proof.** The differences: the affiliation;
the abstract (*"(known) result"* becomes *"proposition"*, and p. 184 adds *"An earlier attempt at a proof exists in the literature, but this
is shown to be flawed. This paper was written in 1979 but never published."* and the 1981 note's citation); `π/3`, `2π/3` for `⅓π`, `⅔π`; one
garbled glyph in Theorem 5 (ii), p. 192, where the manuscript has "γi" (the printed glyph uncertain); and the Lemma's stopping rule, legible in
print where the manuscript's text layer drops symbols (p. 188: *"The algorithm terminates in not more than n cycles, where ε2ⁿ > L."*).

**Does its simplification (c) close FS106-V3's gap? No.** p. 187, verbatim: *"(c) For each vertex v which is a boundary point of two
non-adjacent regions of the same colour, choose ε>0 sufficiently small and describe an ε-neighbourhood whose closure contains v and whose
intersection with each of the two regions is non-null, colouring this ε-neighbourhood the same colour as the two regions, and thus forming
one new region incorporating the original two and the ε-neighbourhood."* — the manuscript's sentence, with no argument that the new points
avoid distance 1 from the colour's other points. FS106-V3's GAP (the allowed set near `v` can pinch to cusps) stands in print; FS106-TW's
fill (`[Woodall1973]` steps 2, 3, 5, in outline) is still the only one. **(c) is not argued differently, so no [hand] check was owed.**

**`[Soifer2024]` ch. 25 is a third text, not a reprint** (p. 255: *"presented below exposition of the proof has been written by Professor
Townsend especially for this book in 2007"*). Its (c) (p. 257) is the same sentence (*"(see Fig. 25.3)"* added); its Theorem 25.7 re-argues
the manuscript's Theorem 5 — (i) *"Let v be any vertex in a 5-colored planar map and assume that it has degree 5"*, two cases by the angle
at `v`, the cut points of `T₂`, `T₃` located; (ii) *"at most two cut points"* and a `π/2`-arc remark (pp. 264–267) — and still takes the
distinct colours at a vertex from (c) (p. 266: *"since T1⁰ is 4-colored, this vertex is at most of degree 4"*). FS110-PA's "reprints it" is
corrected in `BIBLIOGRAPHY.md`. Whether the 2007 text writes out FS106-V3's other flagged steps (vertex existence; the cross-cut arguments)
is left to FS-108 (partly: the no-vertex and cross-cut arguments are longer there; vertex existence is still assumed — *"Let v be any
vertex"*).

**Written:** `plans/STUB-regular-half-residuals.md` — a banner (item 5 answered; what is left) and item 5's line. `BIBLIOGRAPHY.md` —
`[Coulson2004]` / `[Townsend2005]` (copy, read status), `[Townsend1979ms]` (the texts agree), `[Soifer2024]` (ch. 25's status corrected),
§ R.5 and rule 0d (`[Townsend2005]` out), § B (the issue file), and a § C row for Soifer's essay, `[Soifer2005Townsend]`.
`python3 tools/bib_audit.py`: exit 0.

**Draft for the owner — the ranking row** (`plans/FRONTIER-STUBS.md` and its `CLAUDE.md` mirror, rank 5; neither file is this job's):
- now: *"three of five items answered at FS-110 (row 134); left: Townsend's (c) in full; `[Townsend2005]`"* |
  *"link 4's print holes, now Townsend's only: none on the answer (row 131)"*
- proposed question cell: *"four of five items answered (row 134; `[Townsend2005]` is the 1979 manuscript word for word, (c) unargued there
  too); left: Townsend's (c) in full, with `[Soifer2024]` ch. 25's 2007 re-argument of his Theorem 5"* — bearing cell unchanged.
- **byte cost in `CLAUDE.md`:** the mirror cell `three of five items answered at FS-110 (row 134); left: Townsend's (c) in full; \`[Townsend2005]\``
  becomes `four of five answered (row 134; \`[Townsend2005]\` is the manuscript, (c) unargued); left: Townsend's (c) in full` — **+14 bytes**
  (a count in stage 5's drafts, measured there).

**Also stage 3 (the owner's second addition):** `CLOSED-QUESTIONS.md` §3's `d(6) = 1` entry — *"repaired at FS-106 except one edge case,
`d = 2`"* replaced by the edge case closed at FS-110, quoting row 132 (*"(the `d = 2` edge case does not arise: FS-110's CB and CD, both
blind)"*) and row 134 (*"the `d = 2` closure by two routes (CD's Theorem D2; CE's Antipodal Lemma)"*); BK's draft D1 checked against row 132.

### Would have searched here

Nothing (reading and comparison).

## Stage 4 — SAVED

### The references that could pre-empt

**Read (two papers):**
1. **`[Johnson2000surprises]`** — P. D. Johnson Jr., *Infinite graphs and the fractional chromatic number: some recent surprises*,
   Geombinatorics IX(3) (January 2000) 135–144 — **already held** in the IX(3) issue (sheets 19–24), read in full, no fetch.
2. **`[Johnson1996fcn]`** — P. D. Johnson Jr., *About two definitions of the fractional chromatic number*, Geombinatorics V(3) (January 1996)
   99–108 — **fetched** (archive issue 19, `~/source/library/geombinatorics/geombinatorics-v05-n3-1996-01.pdf`), pp. 99–107 read.

**Fetched, not read** (the budget line): Geombinatorics IX(2) (October 1999, archive issue 34,
`~/source/library/geombinatorics/geombinatorics-v09-n2-1999-10.pdf`) for `[Zaks1999]`. One fetch, one login, with `pgrep -af "[g]eomb_fetch"`
empty first (a bare `pgrep -f geomb_fetch.py` matched its own shell, the recorded self-match; the bracket form did not).

**What they hold — the questions of row 129, posed first by Johnson, and one more question on `ℚ(√m)²`:**
- `[Johnson1996fcn]` p. 103, Question 1: *"If χ_f(G) < ∞, is it necessarily the case that χ_f(G) = sup[χ_f(H): H is a finite subgraph of G]?
  … If the answer is "no", then what about the case G = ℝ²?"*; Question 2 (p. 103), the de Bruijn–Erdős property (`sup` attained);
  Question 3 (p. 104): *"Does χ_f have what might be called the Benda-Perles-Tarski property, that χ_f(ℝ²) = χ_f(𝒜²), where 𝒜² represents the
  unit distance graph on the field of algebraic complex numbers?"*; Question 4 (p. 105): a non-bipartite `H` with `χ_f(H) < 2 + ε`;
  Question 5 (p. 105): Fisher–Ullman's assertion *"a measurable, periodic independent set of ℝ² with density ρ generates a sequence of
  fractional colorings of ℝ² the sum of whose weights converge to 1/ρ"* — *"we need to ask if that assertion at the end of [7] is true, and
  to ask for a proof."*
- `[Johnson2000surprises]` p. 135: *"the restrictions of those questions to geometric graphs of interest here, such as the unit distance
  graph in the plane, are still open."* p. 143, Problems 3–5 (verbatim): *"Is it true that χ_f(ℝ², 1) = sup[χ_f(H); H is a finite subgraph
  of (ℝ², 1)]? Is χ_f(ℝ², 1) = χ_f(𝒜², 1), where 𝒜² is the "algebraic plane", the field of algebraic complex numbers? Is it true that for
  every ε > 0 there exists a non-bipartite finite subgraph H of (ℝ², 1) satisfying χ_f(H) < 2 + ε?"* And p. 141, Problem 2: *"For which
  positive integers m ≡ 3 mod 4 is there an induced subgraph of (ℚ²(√m), 1) isomorphic to G_∞?"* (`G_∞`: a countable clique with every edge
  subdivided twice; Levin's example, `χ_f(G_∞) = 3` while its finite subgraphs approach `1 + √2`).

**Verdicts.** Nothing pre-empts a row of ours; three questions are answered by row 129, given MR:
- **Q1 / Problem 3 — yes, given MR** (row 129's `χ_f,0(ℝ²) = χ_f(ℝ²)`), and Johnson's definition of `χ_f` for an infinite graph agrees with
  `[MatolcsiEtAl2025]`'s: his Proposition (p. 102), proved on p. 106 by truncating a countable admissible weighting to finitely many sets.
- **Q3 / Problem 4 — yes, given MR [derived, one mind]:** every finite subgraph of `(ℝ², 1)` is a subgraph of `(𝒜², 1)` (Benda–Perles's
  Tarski argument, as `[Johnson2000]` §3 states it), so `χ_f,0(ℝ²) ≤ χ_f(𝒜²) ≤ χ_f(ℝ²)`; row 129 makes the ends equal.
- **Q5 — FS103-B-CHIF** [hand, one mind; "likely folklore"] proves the assertion for any measurable 1-avoiding set (periodic ones included).
- Q4 / Problem 5 — elementary (the regular `(2k+1)`-gon of unit side has `χ_f = 2 + 1/k`, induced), not ours. Q2 and Problem 2 — not answered.
Written into `CLOSED-QUESTIONS.md` §3's fractional entry as earlier posings, with the grades above. **Not claimed:** anything unconditional; a
row of `LEDGER.md` for the derived sandwich (a draft for the owner, if wanted).

**Debts left, ranked by bearing:**
1. `[Zaks1999]` (held since this stage, unread) — the four-colour compulsions of `ℚ⁴` (pairs at `√2` and 2 forced equal; odd integer
   distances forbidden), the `ℚ⁴` shape of row 59's valuation law; read against `CLOSED-QUESTIONS.md` §1.3 before row 59 is written up.
2. `[BohannonEtAl2001]` (`BIBLIOGRAPHY.md` § R.2 item 4; Geombinatorics X(4) (April 2001) 141–164; unheld) — Johnson's circle, six open
   problems on planar distance graphs; low, since `[Johnson2006]` (July 2006) does not cite it on `ℚ(√m)²`.
3. The reference lists of `[Johnson1996fcn]` and `[Johnson2000surprises]` (17 each; fractional graph theory — Fisher–Ullman 1992, Leader
   1995, Levin, Scheinerman–Ullman) — not mined into `BIBLIOGRAPHY.md`. Fisher–Ullman, *The fractional chromatic number of the plane*,
   Geombinatorics II (1992) 8–12, is the first of them to read (the source of Question 5's assertion and of `χ_f(ℝ²) ≥ 3.5`).
4. `[Johnson1999more]` — *More on the fractional chromatic number*, Geombinatorics IX(1) (1999) 10–20, the first sequel (origins of the
   definitions); `[Mann2001]`, `[Mann2003]`, `[AbramsJohnson2001]`, `[JohnsonLee2006]` — `ℚⁿ` and Babai numbers, none on a field plane by
   Johnson's own account; lowest.

### Would have searched here

Nothing.
