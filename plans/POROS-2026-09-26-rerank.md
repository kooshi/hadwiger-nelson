# Poros — advising the 2026-09-26 re-rank (job R2)

*Advisor's record for job R2 (brief `data/rerank-2026-09-26/briefs/R2-rerank-advisor.md`). The planner is de Bruijn, job R1, whose
plan is `plans/RERANK-2026-09-26.md`. The ranking is R1's; this record holds my expectation (written before any draft of R1's was
read), the frame items, the cards sent, and the disagreements. Grades are the sources'; nothing here is a result.*

## Stage 1 — expectation, written before reading R1's drafts

### The goal, in the principal's words

Kooshi, 2026-09-26: *"six colours, or a proof that no field's plane needs exactly six colours"*; *"If we end up at a wall which collapses
HN to another known open problem, that in itself would be a writeup"*; on FS-62, *"It's just one possibility with some soft evidence."*

### Evidence inventory (read against an expectation written before the reading)

- `LEDGER.md` row 125, six at ℚ(√167) — read against: "six at ℚ(√167) is an arithmetic question with a real-place residue" — surprised: yes.
  Its own sentence *"`χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`"* makes every field-level six pass through `χ_CP(ℝ²) ≥ 6`; the
  arithmetic can only add conjuncts (PL), never lower the bar. X21D's density table says the same for density routes.
- `LEDGER.md` row 110, windows at five colours — read against: "a ℚ(√167)-specific reduction" — surprised: yes. Its last clause is
  general: *"with a real place and only thick finite places the question is exactly `χ_B(ℝ²) ≤ 5`"*.
- `CLAUDE.md` G43 — read against: nothing new expected — surprised: yes, in combination. De Grey's field ℚ(√3,√5,√7,√11) has **no usable
  prime below 131** and a broken wall, so its stable places are all at `q ≥ 131`, where `λ*/d ≤ 2√131/132 = 0.1734` — below `1/4`
  (thick at five) and below `1/5` (thick at six, by the Weil bound alone; the exact spectrum at 131 is seconds).
- `LEDGER.md` rows 120, 124 (MR; SEL-k for every real number field and `k ≥ 2`) — read against: "they reach the `L ≤ 5` fields" —
  surprised: no; SEL-k is stated for every field and every `k`.
- `plans/FS100-X21D-derivation.md` §4, `plans/FS100-X21V-verification.md` §2.9 — read against: "someone has already stated the field with no
  non-thick place" — surprised: yes, **it is absent**. X21V calls `χ_CP(ℝ²) ≥ 6` *"weaker than rung D"*, which is true only without MR.
  `grep` for the equivalence (rung D ⟺ `χ_CP(ℝ²) ≥ 6`, or a field all of whose places mix) over `plans/`, `CLAUDE.md`, `LEDGER.md`: nothing.
- `plans/POROS-2026-09-25-wanted-poster-167.md` R6 — read against: "the reading debt on `χ_m(ℝ²) ≥ 6` was paid" — surprised: yes, unpaid
  (row 125: `[Falconer1981]` "not held, second-hand"). One web search today (Bachoc–Nebe–Oliveira–Vallentin, arXiv:0801.1059; the
  2025 map-type paper arXiv:2502.01958; survey lines): `5 ≤ χ_m(ℝ²) ≤ 7`, open. Recalled and searched, not read in full.
- `plans/FRONTIER-STUBS.md` ranks 1–59 — read against: "the top of the table is aimed at six" — surprised: yes. Rank 1 is six at
  ℚ(√167) (see below: dominated); ranks 2–3 (FS-90, FS-100's leftovers) have bearing "none" on the table's own word.
- R1's drafts — unread (none received; my expectation is committed first).

### The frame item that changes the ranking: HN may collapse to its measurable form, at de Grey's own field

**The composition, stated as a candidate for R1 and the domain to check, not as a result.** Given MR (row 120, [hand]):
1. (row 124, SEL-k) `F²` is `k`-colourable iff it has a rotation- and translation-invariant random `k`-colouring with spectrum on `T + A`;
   `T` reads only stable places, because `R_F = O′` inverts the rest (row 100).
2. (rows 109–110, the mixing selection) a stable place whose target is `k`-thick (`λ* < 1/(k−1)`) drops out of the product; real places
   merge to one `UD(ℝ²)` factor (row 110, slicing; row 125, B-1).
3. At de Grey's field every stable place is at `q ≥ 131` (G43), so thick at five and at six. Hence, for `k ∈ {5, 6}`,
   `χ(F_dG²) ≤ k ⟺ χ_CP(ℝ²) ≤ k` — **with no product lemma**, unlike ℚ(√167), whose non-thick stable places are 23 and 43.
4. (row 125) `χ(ℝ²) ≤ χ_CP(ℝ²)` by de Bruijn–Erdős and the countable pull-back, with no MR.

Together: **χ(ℝ²) = χ(ℚ(√3,√5,√7,√11)²) = χ_CP(ℝ²)**, given MR and the mixing selection in the CP format at infinitely many thick places.
So rung D (χ(ℝ²) ≥ 6) would be equivalent to `χ_CP(ℝ²) ≥ 6`, the null-set-tolerant stationary form of the measurable chromatic number of
the plane — Falconer's 1981 problem, `5 ≤ χ_m(ℝ²) ≤ 7`, open; `χ_CP ≥ 6` implies `χ_m ≥ 6`, since `χ_CP ≤ χ_m`. This is exactly the
wall Kooshi named: HN collapsing to another known open problem. What the known literature believes is `χ ≤ χ_m`, with strict inequality
possible only through the axiom of choice; the composition says the strict inequality cannot occur in the CP form — which is why it
needs checking before anyone repeats it.

**What it does to the target, if it holds.**
- *Six colours* (rung D) ⟺ `χ_CP(ℝ²) ≥ 6`. Every field-level six is that statement plus conjuncts. **Six at ℚ(√167) (FS-59, rank 1) is
  rung D ∧ PL_∃(23, 43): strictly harder than rung D itself**, as a route to six. Its remaining value is the conjecture's prediction there.
- *No field at exactly six* (S, FS-62) ⟹ `χ_CP(ℝ²) ≠ 6` (else de Grey's field is exactly six). So S is not a softer branch: it contains the
  measurable problem's "≠ 6". Its other conjunct, given `χ_CP(ℝ²) = 7`, is a **finite** family of CP product statements at six colours —
  only places that are not 6-thick (`q` below about 100, and dyadic `U_Q` of small norm) can matter, the window (G56, G59) being the
  one-factor case.
- The window stubs (FS-57, FS-65, FS-17, FS-69) bear on S's product conjunct only, and only if `χ_CP(ℝ²) = 7`. On six colours for the
  plane: none.
- FS-64 (a window colouring beating six over ℚ(√167)) is PL's negation: a CP five-colouring of `Y` is either `χ_CP(ℝ²) ≤ 5` (HN = 5) or a
  Hedetniemi-type drop through 23 and 43. FS-96 and FS-64 are one question from two sides.
- The finite-witness routes to six (FS-49, FS-42, FS-43, FS-44, FS-78) keep their bearing (a finite 6-chromatic graph needs no MR) and
  gain an existence statement: given the collapse, one exists iff `χ_CP(ℝ²) ≥ 6`. Post-ban, speculative.

### Where six is most likely to be won or shown impossible — my expectation

- **Most likely outcome of the next milestone:** the collapse lands at [hand] (P = 0.60), breaks at one named step (P = 0.30; my guess at
  the step: the thick-drop in the null-vertex CP format over infinitely many places at once, or the format SEL-k delivers versus row 110's
  window format), or is found in print (P = 0.10).
- **Six itself:** won, near-term, P ≈ 0.03 (it is `χ_m`-strength, open 45 years); shown impossible for fields (S), P ≈ 0.02. The realistic
  product is the collapse — a reduction of HN to a named open problem — which is the write-up Kooshi named.
- **Where an attack exists on the measurable problem** (Hamming's "reasonable attack"): the density route at `j ≥ 2` — a CP five-colouring
  needs a CP-`j`-colourable part of density `≥ j/5` for every `j ≤ 4`, so `m_j(ℝ²) < j/5` for one `j ∈ {2, 3, 4}` gives six (X21D §4;
  `j = 1` is dead by Croft). Not known to be held or refuted. Fourier/SDP bounds of the Oliveira–Vallentin / Ambrus et al. kind; an
  optimisation, post-ban unless its shape is derived first.

### My top three (existing or new), with confidence

| # | stub | why first | expected product | confidence |
|---|---|---|---|---|
| 1 | **NEW — the measurable collapse**: given MR, `χ(ℝ²) = χ(F_dG²) = χ_CP(ℝ²)` | decides the frame every other stub is ranked in; a composition of held rows plus one exact spectrum; solver-free; the write-up Kooshi named | lands at [hand] 0.60; breaks at a named step 0.30; prior art 0.10 | medium — it changes if B-1's ⟹ uses a property of ℚ(√167) beyond "its non-thick stable places are 23 and 43" |
| 2 | **NEW or re-aimed (FS-62/FS-64's successor) — `χ_CP(ℝ²) ≥ 6`, the measurable problem**: reading first (Falconer 1981, Soifer's measurable chapter, the Polymath16 measurable page, arXiv:0801.1059, Ambrus et al. 2023), then `m_j(ℝ²) < j/5` for `j = 2, 3, 4` | if (1) holds this *is* rung D; the only route to six the ledger leaves that is not a finite witness | a reading and a derived LP shape; a bound at some `j`: 0.05; the reading changes the plan: 0.30 | low on outcome, high on rank |
| 3 | **FS-62 re-aimed — S given MR**: `χ_CP(ℝ²) ≠ 6` ∧ finitely many CP product statements at six (the non-6-thick places) | the other half of Kooshi's target, made finite; solver-free | the reduction at [hand]: 0.50 | medium |

Below them I expect FS-101 (the kernel port; no bearing on six, high value for the write-up) and FS-102 (the fallback write-up, which the
collapse would headline). FS-59 drops from rank 1: its six is dominated as a route (above); its prediction stays the conjecture's.

### Frame items for R1 (brief item 2)

1. **A route no stub names:** the collapse (above). No stub holds de Grey's field as the PL-free field, or rung D ⟺ `χ_CP(ℝ²) ≥ 6`.
2. **Moot or bypassed by rows 116–127:** FS-80 (five at ℚ(√167) is held, row 123); FS-72 (five over ℚ(√3,√5) is held; the lattice is only
   its explicit object); FS-84 (closed); FS-97 (absorbed); FS-48's `L ≥ 5` entries (row 123); FS-60's lower halves (row 119).
3. **High on momentum rather than bearing:** FS-59 at rank 1 (dominated as a route to six); FS-90 at rank 2 and FS-100's leftovers at rank 3
   (TR-ROT, C-4, NA₀) — bearing "none" on the table's own word; they are row 88's type-(B) question, not six.
4. **"Reduced to a known open problem" is the likely outcome in four places:** HN ⟹ the measurable chromatic number of the plane
   (Falconer; given the collapse); S's product conjunct ⟹ Hedetniemi-type statements for CP colourings of products with `UD(ℝ²)` (the
   measurable/Borel Hedetniemi question); row 88 ⟹ NA₀, homoclinic points of algebraic actions (`[LindSchmidt1999]`, row 126); FS-76's rank
   one ⟹ countable ⟹ finite for one-dimensional SFTs of distance graphs (row 108).

### Hunch ledger

```
hunch: the-collapse-composes
  claim: given MR, χ(ℝ²) = χ(ℚ(√3,√5,√7,√11)²) = χ_CP(ℝ²), from rows 110, 120, 124, 125 and G43 with no new idea
  basis: read
  falsifier: a step of B-1's ⟹ (FS100-B12, X21D §4) that uses a property of ℚ(√167) other than its non-thick stable set, and fails at de Grey's field; or λ*(Γ₁₃₁)/132 ≥ 1/5 exactly
  registered: 2026-09-26
  status: open

hunch: measurable-six-is-open-in-print
  claim: no paper claims χ_m(ℝ²) ≥ 6 or χ_m(ℝ²) ≤ 6
  basis: read
  falsifier: such a claim in the literature (one web search today; Falconer 1981 and Soifer's chapter unread)
  registered: 2026-09-26
  status: open

hunch: fs59-rank-one-is-momentum
  claim: as a route to six, FS-59 is dominated by the collapse field — its six is rung D ∧ PL_∃(23, 43)
  basis: derived
  falsifier: the collapse failing at de Grey's field for a reason that does not also hit ℚ(√167)
  registered: 2026-09-26
  status: open

hunch: no-bound-on-chi-cp-this-cycle
  claim: the next milestone on χ_CP(ℝ²) proves no bound beyond five in either direction
  basis: prior
  falsifier: m_j(ℝ²) < j/5 for some j ∈ {2,3,4}, or a measurable "+1" mechanism from a finite forced pair
  registered: 2026-09-26
  status: open
```

### The card sent to R1

```
question: does-the-collapse-hold-at-de-greys-field
  evidence: row 125, "χ(F²) ≤ χ_CP(ℝ²) for every countable F ⊆ ℝ"; row 110, "with a real place and only thick finite places the question is exactly χ_B(ℝ²) ≤ 5"; G43, de Grey's field has no usable prime below 131
  expected: some stub or record already states a field with no non-thick stable place; none does (grep, 2026-09-26)
  ask: does B-1's ⟹ run verbatim at a field all of whose stable places are thick, making χ(ℝ²) = χ_CP(ℝ²)?
  if it does: a new stub at rank 1, the collapse; FS-59 falls to "conjecture-specific, rung D ∧ PL"; FS-62 re-aimed to S given MR; the window stubs rank only under S
  if it does not: the step that fails is named, and FS-59 keeps rank 1 with that step as its bearing
  answered by: derivation
  cost: one derivation session; the exact spectrum at 131 in seconds
  hunch: it does — every link is a held row, and ℚ(√167)'s PL arises only from 23 and 43
  falsifier: a link of B-1 that uses two real places or a non-thick place essentially
  rank: 1
```

## Stage 1 — SAVED

## Stage 2 — the weak step, read in the record (before any draft of R1's)

The card's addressee was "derivation"; the record answers most of it. **T-J39-3** (J39 §3.2, with J48's repair; quoted in
`plans/FS100-X21D-derivation.md` line 65): *"Let `N_k(F)` be the finite set of stable places of `F` that are not `k`-thick, and `Y_{F,k} =
UD(ℝ²) × ∏_{v ∈ N_k(F)} G_v`. … **So, given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**" (every `k`, every totally
real `F`)*. De Grey's field is totally real and, by G43, has `N_5 = N_6 = ∅` if every stable place at `q ≥ 131` is thick (Weil: `λ*/d ≤
0.1734 < 1/5`; higher levels `2/(q+1)`). Then `Y = UD(ℝ²)` and the collapse is a **two-line corollary of a held [hand] theorem**, stated for
every `k` and every totally real field and applied, so far, only at ℚ(√167), where `N_5 = {23, 43}`.

- Hunch `the-collapse-composes`: evidence for it strengthened (read); status still open — it needs a mind to write the corollary and the
  exact thickness at the stable places of de Grey's field, and T-J39-3's own grade ([hand], J39 + J48 blind) carries into it.
- Revised expectation: lands at [hand] P = 0.80; breaks P = 0.12 (the likely place now: the thickness definition at all levels, or T-J39-3's
  CP format differing from `χ_CP` as row 125 uses it); found in print P = 0.08.
- **The one question left open by the reading: which known problem `χ_CP(ℝ²)` is.** Row 110 names the formats: *"with a real place and only
  thick finite places the question is exactly `χ_B(ℝ²) ≤ 5`"* (Borel, everywhere proper), and *"measurable into the null-vertex format"*,
  with *"from measurable to everywhere-proper"* not claimed. If the CP format is Borel everywhere-proper, then `χ ≤ χ_m ≤ χ_B = χ_CP = χ`
  and **given MR, `χ(ℝ²) = χ_m(ℝ²) = χ_B(ℝ²)`** — the plane's three chromatic numbers coincide. If it is null-tolerant, then `χ(ℝ²) =
  χ_CP(ℝ²) ≤ χ_m(ℝ²)`, and rung D still ⟺ `χ_CP(ℝ²) ≥ 6`, a statement at least as strong as `χ_m ≥ 6`. Either way rung D is the CP form.

## Stage 2 — SAVED

## Stage 3 — R1's stage 1 read; advice sent

**R1's stage 1** (`plans/RERANK-2026-09-26.md`, `85a8d9fc`) states the same collapse (its F1) and records the two derivations as blind to
each other: R1 derived and sent it before my message of `75d3c4b2` arrived. My attack (stage 2) held steps 1–3 against the record. R1 ranks
on FS100-BC's CP format: pairwise almost-sure properness, continuity in probability, no joint measurability. So F1 gives `χ(ℝ²) =
χ_CP(ℝ²) ≤ χ_m(ℝ²)`, never `χ = χ_m`. Agreed.

**R1's reading of "83 is not 6-thick"** checks out: Hoffman refuses six at `q` iff `|λ_min|/d < 1/5`. Six at 83 needed a certificate
(row 68), so `λ*(83) ≥ 1/5`.

**A quadratic instance of F1, computed here** (sympy, exact Legendre symbols; a number-theoretic enumeration, not a search for a
witness). The smallest squarefree `d ≡ 7 (mod 8)` with every prime `p ≡ 3 (mod 4)`, `p ≤ 83`, inert in ℚ(√d) is **`d = 635087`**
(prime). Its usable primes begin 103, 107, 127, 163, 191, and `2√103/104 = 0.1952 < 1/5` by Weil. `ℚ₂(√d) = ℚ₂(i)`, so the wall is
broken and `R = O′`. So `N₅ = N₆ = ∅` at degree 2, where MR and T-J39-3 have been exercised; the next four are 823415, 1017623, 1598231
and 1971119. De Grey's field (degree 16) adds MR's admissibility at degree 16, a sixteen-place merge and its stable-place list, all
unexercised. Recommended: ℚ(√635087) as F1's checkable instance, de Grey's field as the statement.

**Advice sent to R1** (SendMessage, after `85a8d9fc`):
1. The quadratic instance above.
2. FS-63 is not `χ_CP(ℝ²)`'s home: with `N_k = ∅` there are no p-adic factors and no model set. The home is measurable/Borel graph
   combinatorics, harmonic analysis of distance-avoiding sets and invariant random colourings. F1's prior-art gate should be run in those
   words.
3. Make MR's hardening an explicit rank. Its external step and its two-mind steps are the collapse's weakest link. FS-100's leftovers
   (TR-ROT, C-4) bear none.
4. Agreed: FS-80 re-aimed to a window LP over stationary colourings is the averaged certificate `χ_CP ≥ 6` needs. It is post-ban unless
   its shape is derived.
5. A disagreement to record if R1 makes it: any window stub (FS-57, FS-65, FS-17, FS-69, FS-55) ranked above the `χ_CP` reading.

**Hunch update.**

```
hunch: the-collapse-composes
  claim: given MR, χ(ℝ²) = χ(ℚ(√3,√5,√7,√11)²) = χ_CP(ℝ²), from rows 110, 120, 124, 125 and G43 with no new idea
  basis: read
  falsifier: a step of T-J39-3's proof that fails with N_k(F) = ∅ over infinitely many thick places at k = 6; or a stable place of F_dG with λ* ≥ 1/5
  registered: 2026-09-26
  status: open (a second mind, R1, reached it blind; both attacks held it against the record; not yet verified by a derivation of its own)
```

## Stage 3 — SAVED
