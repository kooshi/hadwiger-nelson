# Poros — advising the FS-73 planner through its opening (2026-09-23)

*Record of the advisor (Poros, Opus 5.5) for FS-73, the rigidity dichotomy (`plans/STUB-rigidity-dichotomy.md`). Sole writer: Poros.
Not committed by Poros; the planner (de Bruijn, agent `a8c97a4521448222a`) commits it by path. Every message's substance, every
retraction on either side, and my own errors against myself are kept here, so nothing lives only in a context window.*

## 0. My expectation, written before any exchange with the planner (2026-09-23)

*Written after reading the stub, the handoff §0, the protocol §0–§3 and the in-context copy of `CLAUDE.md`'s grokkings; BEFORE reading
`plans/FS70-derivation.md`, `plans/MASCOT-derivation.md` or `LEDGER.md` rows 66/67/76 — those are inventory items read against this.*

### 0.1 The inheritance question, said for a stranger — and two reductions I expect to hold

Let Λ ⊂ ℂ be a finitely generated additive subgroup (rank r), U = Λ ∩ S¹ its (finite) set of unit vectors, G = Cay(Λ, U). Proper
four-colourings of G, viewed as points of {1..4}^Λ, form a **ℤ^r subshift of finite type** X (a "hom-shift" into K₄ over a
non-standard generating set). A colouring is *periodic* when it is invariant under a finite-index sublattice NΛ. C3 asks: if every
periodic colouring identifies 0 and δ (and, in the stub's Kempe reading, is Kempe-rigid at δ), does some finite ball force (0, δ)?

- **R1 — the "finite ball" is free, by compactness** (König / de Bruijn–Erdős, Tychonoff on {1..4}^Λ): some finite ball forces
  (0, δ) ⟺ every proper 4-colouring of the *infinite* G has c(0) = c(δ). So C3 is not about finite balls at all. It is: **do the
  periodic points of X witness its 2-point patterns** — does X ∩ {c(0) ≠ c(δ)} ≠ ∅ imply that some *periodic* point has
  c(0) ≠ c(δ)? Density of periodic points in X is sufficient. Compactness gives no bound on the ball's radius.
- **R2 — the vacuous case contains the existence question.** If X is nonempty and has no periodic point, "rigid under every
  periodic colouring" holds vacuously, and at δ = u ∈ U the conclusion (a finite ball forcing an *edge's* ends equal) is
  impossible for a 4-colourable graph. So C3 for all δ implies *"every 4-colourable Cay(Λ, U) has a periodic 4-colouring"*. FS-72's
  rank-8 lattice (`group:u3:2+w4`, no periodic colouring found) is exactly this case: if it is 4-colourable with no periodic
  colouring, C3 in its literal form is dead. G30 failure mode 5 (a ∀ over an empty domain) in the milestone's own statement.

### 0.2 Which discipline owns it (their vocabulary, not ours)

- **Symbolic dynamics of multidimensional SFTs**: "periodic points dense", "aperiodic SFT" (Berger 1966, Robinson 1971),
  "strongly irreducible ℤ² SFTs have dense periodic points" (Lightwood, ~2003–04; open for ℤ^d, d ≥ 3 — recalled, not read),
  "hom-shift" (Chandgotia–Marcus), "domino problem". Our shifts are far from mixing — rigidity IS non-mixing — so the positive
  density theorems do not apply as recalled, and the aperiodic constructions are the negative toolkit.
- **Graph theory**: "periodic colourings of periodic / quasi-transitive graphs" — Burr 1984 (Wang tiles into periodic-graph
  colourings, undecidability; recalled), and a recent paper I recall as Abrishami–Esperet–Giocanti–Hamann–Knappe–Möller, *Periodic
  colorings and orientations in infinite graphs* (~2023–24), which I believe asks whether k-colourable Cayley graphs of ℤ^d have
  periodic k-colourings — **recalled, not read; the gate should check it**. Also "frozen colourings", "Kempe equivalence".
- **Statistical mechanics**: zero-temperature antiferromagnetic 4-state Potts model on the lattice with interaction set U; the
  "periodic ground-state problem" (Radin); Kempe moves = the Wang–Swendsen–Kotecký cluster algorithm and its (non-)ergodicity
  (Mohar–Salas; recalled).
- For (3), the Kempe index: **topological graph theory — voltage graphs and derived graphs** (Gross–Tucker: the components of a
  derived graph correspond to cosets of the local voltage group, so [NΛ : V] is a component count); crystallography's "quotient
  graph / periodic net". For (2): algebraic number theory (splitting in CM extensions E/E⁺), already the project's.

### 0.3 Grokkings and rows I expect to bear (provisional; the planner's §G is the authority)

- **G69, G68, G70** — the stub's own core. G70 bears hardest on (1): over K the "why" may be a **local lemma** (the hexagon lemma
  makes every √3-clean colouring 2R-periodic) and not periodic rigidity at all — so the positive instance may be explained by a
  mechanism that does not generalise as "inheritance".
- **G61(2) / G55 / rows 58, 72–73** — the three-colour twin: the rhombus makes *every* 3-colouring 3R-periodic, so at three colours
  over √3-fields inheritance is automatic (X is a finite quotient). Expect the planner to find the two regimes where C3 is free:
  X all-periodic (a local periodicity lemma of full rank) and X with dense periodic points (mixing). K is a mixture.
- **G66** — "refusing at level one" is not "refusing at period p^k": χ is only non-increasing up a tower; G66 certified no drop at
  7, 11, 19, 23 only. Bears on (2)'s rigidity column.
- **G42 / G41** — additive rigidity is Kempe closure (γ = 0) and "forcing does not need rigidity": a second meaning of "rigid" in
  the corpus. I expect ≥ 3 distinct "rigid"s in play (G42's γ = 0; G69's Kempe component reaching δ; G61(2)'s tight-and-unique;
  G70's √3-clean ⟹ residue) and a plan that conflates two of them.
- **G54** (tight/slack; tight towers force at depth), **G21** (the hypothesis "rigid under every periodic colouring" is measured
  on an enumeration, N ≤ 12), **G30 #5 and #7** (vacuity), **G45 / G66's Lemma W** (local gain vs global bracing — the same
  local/periodic gap in another costume), **G17** (sub-rung compulsions have small carriers), **G64** (index as a norm: 81 = 3⁴),
  **G62, C2** (commensurate ⟹ periodic ⟹ finite quotient), **G51** (the competition).
- Rows **66** (gap ⟹ free: the periodic colouring that *refutes* forcing), **67** (tight tower forces from level 5; "says nothing
  about any finite chunk" — the gap C3 names), **76**, **57**, **58**, **73**.

### 0.4 Where I expect a plan for FS-73 to go wrong

1. **Computing toward (1).** Neither side of C3 is finitely reachable: "rigid at every period" is a Π-statement over all N (and
   the screens reach N ≤ ~12), and a counterexample's "every ball separates" needs an *aperiodic colouring rule*, not a solver. A
   phase that reports "rigid at N ≤ 12 and separated at every ball of radius ≤ R" is consistent with both answers — its
   uninformative outcome is certain. (1) is a derivation; balls are an instrument for (2), not for (1).
2. **The known positive instance is an instance of the conclusion, not of the inference.** Over K the pair is forced (Harder), so
   the implication holds there whatever the hypothesis says; it is no control for the mechanism. Informative instances are where
   the hypothesis holds and the conclusion is unknown — or the vacuous case (R2).
3. **Composite periods.** "Every odd prime's target refuses" ≠ "no odd-period colouring": Λ/pqΛ's Cayley graph is a *diagonal
   subgraph of the categorical product* of the two targets, and at four colours Hedetniemi fails (`[Tardif2023]`, `[Zhu2025]` as
   cited in G55), so a composite-period colouring local at neither prime is not excluded by a prime-by-prime table. Same for p^k
   (G66). Expect the classification's column (c) to be stated prime-by-prime and to need a lemma or a column for N composite.
4. **"Rigid" unquantified.** Found-vs-every periods; Kempe-rigid vs identifies; which of the corpus's rigids.
5. **The prior-art gate searched in "rigid", "Kempe index", "periodic colouring" of *the plane*** — our words — instead of
   "periodic points", "subshift of finite type", "hom-shift", "ground state", "derived graph".

### 0.5 Hunch ledger (opened with the expectation)

```markdown
hunch: inheritance-is-periodic-point-witnessing
  claim: by compactness, C3 is equivalent to "periodic points of the 4-colouring shift of Cay(Λ,U) witness every 2-point pattern (equal/unequal at offset δ)"; density of periodic points is sufficient
  basis: derived
  falsifier: a reading of the stub's / FS70's definition of "rigid" or "forces" under which compactness does not apply (e.g. U infinite, or "forces" not quantified over all proper colourings)
  registered: 2026-09-23
  status: confirmed (by: derivation — König/Tychonoff, checked independently by the planner; and read — FS58-T4 held it at three colours; Mathlib `nonempty_hom_of_forall_finite_subgraph_hom`, Finsubgraph.lean:154)

hunch: literal-C3-contains-FS72
  claim: C3 stated for every δ, with no non-vacuity hypothesis, implies every 4-colourable lattice graph has a periodic 4-colouring; FS-72's rank-8 lattice is its killing test if 4-colourable
  basis: derived
  falsifier: C3's written statement (FS70-derivation) presupposes a periodic colouring exists, or quantifies δ outside U
  registered: 2026-09-23
  status: confirmed (by: derivation, accepted by the planner; the plan splits it off as C3-aper = `[AbrishamiEtAl2025]` Problem 4.6 restricted to 1-ended abelian Cayley graphs)

hunch: K-is-explained-by-a-local-lemma-not-by-inheritance
  claim: over K the forcing of 8/3 follows from G70's hexagon lemma (clean colourings are 2R-periodic, 8/3 ∈ 2R) plus a separate finite argument on √3-dirty colourings; periodic rigidity plays no role in the mechanism
  basis: analogy (G61(2)'s rhombus at three colours; protocol §2's card on dirty colourings)
  falsifier: a √3-dirty 4-colouring of the Moser lattice that is not a limit of periodic colourings, on which Harder's object is what forces — or a record showing Harder's object uses no √3-pigeonhole at all
  registered: 2026-09-23
  status: open

hunch: composite-periods-escape-the-prime-table
  claim: rigidity "at every odd prime" (level one) does not exclude periodic 4-colourings at composite or prime-power periods; the classification's column (c) needs a lemma it does not yet have
  basis: prior (Tardif 2023 at four colours; G66's non-increasing tower)
  falsifier: a lemma in FS70-derivation (T9 or nearby) showing every period-N colouring factors through one prime, or that the diagonal Cayley graph refuses whenever each factor does
  registered: 2026-09-23
  status: open (no such lemma in the record — T9's mechanism file flags rank 6 as "a subgraph of a product … not derived"; the test is the plan's P-R1 on L3, a period dividing 2·3⁴ forced by [2Λ : V] = 81)

hunch: kempe-index-is-a-norm
  claim: V (the closed-walk voltage lattice of a two-colour Kempe component) is stable under the colouring's stabiliser in the multiplier ring, so [NΛ : V] is an ideal norm — 81 = 3⁴ at rank 6
  basis: analogy (G64's norm reading; Gross–Tucker local voltage group)
  falsifier: a Kempe index at rank 6 that is not a norm of any ideal of the relevant order, or a V not stable under the colouring's symmetries
  registered: 2026-09-23
  status: open, demoted in weight (R3 shows membership e ∈ V decides escapes, not the index; the plan carries it as P-R2, low-medium)
hunch: H1-equals-H2
  claim: for a lattice unit-distance graph, "every periodic 4-colouring identifies (0,δ)" (H1) is equivalent to "every periodic 4-colouring is Kempe-rigid at δ for every b" (H2)
  basis: derived
  falsifier: a periodic colouring C, C(0)=C(δ), with δ ∉ K₀ for some b, on a lattice where H1 holds — i.e. an error in the re-periodisation (the union K₀+W′ not a union of components, or W′ not of finite index)
  registered: 2026-09-23
  status: confirmed (by: derivation, re-derived independently by the planner, message 4; in the plan as R3 with a kernel leaf `not_periodicForces_of_voltageEscape`)

hunch: lattice-is-hoffman-tight-over-K
  claim: de Grey's rank-4 lattice graph Cay(Λ,U) over K has min over T⁴ of Σ_u cos 2πθ·u equal to −d/3, attained only at 2-power-torsion characters, so every odd-period quotient refuses four colours by Hoffman
  basis: analogy (G54: the 2-adic plane is tight at k = 4; Theorem B's residue colouring at 2)
  falsifier: a numerical minimum of the trig polynomial below −d/3 − ε, or a minimiser that is not 2-power torsion
  registered: 2026-09-23
  status: killed (by: the planner's numerics, message 5 — continuous minimum −22.4095 at a generic θ; tight only at the N = 2, 4, 6 quotients)
```

## 1. Evidence inventory

*Items read against the expectation above (§0). Format: item — expected — surprised?, with the address.*

- `plans/FS70-derivation.md` § Conjectures (C3) — expected: C3 as the stub states it (periodic rigidity ⟹ finite ball forces) —
  **surprised: yes.** FS-70's C3 is a different statement: "rigid" is *defined* there as "carries a four-colour forced pair", and C3
  is an arithmetic iff (reductions cover the residue circles at every *small* odd prime ∧ the 2-adic tower tight at the target's
  depth). The stub's C3 is the inheritance implication. Two conjectures under one label; "small" unquantified.
- `plans/FS70-derivation.md` T10 — expected: the Kempe component lifts as a coset of a voltage lattice; the deciding quantity the
  index — **surprised: partly.** T10's own equivalence `δ ∈ K₀ ⟺ δ̄ ∈ Q₀ ∧ δ − p(δ̄) ∈ V` shows membership decides, not the index;
  T10.2 nevertheless calls `[NΛ : V]` "the deciding invariant". Led to the H1 ⟺ H2 derivation (§2, message 3).
- `data/fs70/owner/mechanism-periodic-colourings-2026-09-22.md` (T9's proof) — expected: a lemma handling composite periods and
  primes that split in E⁺ — **surprised: yes, the dog did not bark.** The table is one prime of E⁺ at a time; every checked instance
  (5, 7, 13 inert in ℚ(√33); 11 ramified) has a single prime of E⁺ above p, so the product case never arose; rank 6 is flagged "a
  subgraph of a product … not derived here". Also: "Mod 11 and 13 the 54 residues are distinct, a proper subgraph of the targets …
  still refusing" — at 11 and 13 the quotient is NOT the residue target, and its refusal is a SAT fact, not arithmetic.
  Hunch composite-periods-escape-the-prime-table: not refuted; strengthened (split-in-E⁺ primes such as 17, 29, 31 for ℚ(√33) are the
  first product cases at a *single* rational prime).
- `data/fs70/owner/prior-art-kempe-2026-09-22.md` — expected: a gate in our vocabulary — **surprised: yes, twice.** (i) It touched
  the owning discipline and filed it as a pointer: Alon–Briceño–Chandgotia, *Mixing properties of colourings of the ℤ^d lattice*
  (2021), "not fetched, not read" — Chandgotia is the hom-shift author; G50 says this blocks the opening. (ii) `[Polymath16wikiR2]`
  Cor. 9 is a *local periodicity-propagation lemma* over K (2R₁-periodic on R₁ ⟹ on R₁ + ρR₁) and Prop. 6 exhibits non-periodic
  (tri-sector) colourings — the one place the literature treats all colourings, not periodic ones, of the lattice over K. Supports
  hunch K-is-explained-by-a-local-lemma.
- `LEDGER.md` § B, grepped for kempe/periodic/rigid/compact (read after messages 1–10) — expected: nothing stating R1 —
  **surprised: yes.** **FS58-T4** is R1 at three colours ("a finite forcer … exists iff the infinite 3-integral graph itself is
  rigid at that difference, by compactness", `plans/FS58-derivation.md` line 83), and its kernel note says no `Colorable`
  compactness wrapper exists (checked only in `Coloring*.lean`) — but `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` is at
  `Mathlib/Combinatorics/SimpleGraph/Finsubgraph.lean:154` in our pin; FS-39's phase-A target is nearly free. **FS58-T3** (line 58):
  periodic 3-colourings factor through a *tensor product* of the 3-adic tower and the stable residue planes, its first version having
  wrongly concluded "every finite quotient is a 3-group" — the three-colour ancestor of hunch composite-periods-escape-the-prime-table.
  Also: M57-T7 (forcing without rigidity), FS38-D1/D2-A, M61-T4 (periodic quotients of finite planes), M63H3-T8 (commensurate ⟹
  periodic).
- `plans/MASCOT-derivation.md` T6–T11 — expected: G70's content; the phase walls as the non-periodic family — **surprised: no** (as
  expected), one detail: MASCOT-T10's striped colourings are periodic along rows with an arbitrary phase sequence across them —
  rank-1-transversal configurations.
- `LEDGER.md` rows 66, 67, 76 — expected: row 67 says the tower "says nothing about any finite chunk" — **surprised: yes, once.**
  Row 67 registers **P-D3**: "no finite K²-graph forces depth 4", although the 2-adic tower forces depth 4 — the corpus's own
  registered prediction that local (2-adic periodic) forcing does not inherit to finite graphs at depth 4 over K; sent to the planner
  as bearing on the census's (ii). Row 76: 23,083 is our ball; Harder's smallest forcing subgraph is 745 (M56's core 588).

## 2. Exchange log

1. **Poros → planner (opening, 2026-09-23).** R1 (compactness: the finite ball is free; C3 is a periodic-points question on the
   4-colouring SFT) and R2 (the vacuous case: literal C3 implies every 4-colourable lattice graph has a periodic 4-colouring; FS-72's
   lattice is its killing test); the two C3s (FS70-derivation vs stub). Asked which C3 is the milestone's.
2. **Planner → Poros.** Agrees with R1 and R2; reached R1 independently; will carry R1 in Lean via
   `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (G plus the edge uv) as a kernel leaf. Competition gets C3 with an explicit
   non-vacuity hypothesis; the aperiodic case becomes a named question C3-aper. Proposes three strengths of "rigid": H1 (every
   periodic colouring identifies), H2 (G69's Kempe-rigid), H2-found (N ≤ 12); claims H2 ⟹ H1 and that under H1 escapes have
   rank V < rank Λ ("partially periodic, like MASCOT-T10's phase walls"). Splits FS-70's C3 into C3-local (odd targets refuse ∧ tower
   tight ⟹ H1; "FS-67's question at four colours") and C3-inherit (H1 ⟹ forcing); competition takes C3-inherit, non-vacuous, at H1.
   Expects Weil/Hoffman to refuse four colours from residue size q ≈ 37 up, so finitely many primes need computing (unchecked).
3. **Poros → planner.** (a) **H1 ⟺ H2**, not only H2 ⟹ H1: any Kempe escape from a periodic colouring re-periodises — swap the
   union K₀ + W′ over a finite-index W′ ⊇ V missing e = δ − p(δ̄) (subgroups of ℤ^r are profinitely closed); so under H1 no escape of
   any rank exists; the screen tests H1 at every period W′ ⊇ V from one colouring; membership e ∈ V decides, not the index — T10.2
   and question (3) may aim at the wrong quantity. (b) The q ≈ 37 cutoff cannot exist: the period-p quotient is Cay(Λ/pΛ, U mod p),
   a sparse subgraph of the residue target once the circle outgrows U (11 and 13 for de Grey's lattice, by the mechanism file); its
   Hoffman floors converge to the lattice's own 1 + d/|m| (m = min over T^r of Σ_u cos 2πθ·u), which is ≤ 4 when any periodic
   4-colouring exists. Slack ⟹ no spectral refusal at large p; tight ⟹ refusal at every period missing the minimisers (G54's sign for
   the lattice itself). Hunch: de Grey's lattice is tight with 2-power-torsion minimisers. Frame note: tightness controls invariant
   measures, not every point — the residue is domain walls. Offered to run the trig-polynomial check.

4. **Planner → Poros.** Accepts (a) and (b); **retracts two claims** (both free, nothing committed): (i) "infinite-index escapes
   survive under H1" — checked the re-periodisation itself (translations by NΛ permute the components; NΛ/V residually finite);
   (ii) the q ≈ 37 Weil/Hoffman cutoff — "the quotient is a subgraph of the target, and Weil on the target transfers nothing". The plan
   will state H1 ⟺ H2 (credited), re-aim question (3) to "what determines NΛ/V and the targets' images in it at rank 6", and put the
   lattice's own m(Λ) against −d/3 as the classification's first column. Runs the de Grey trig-polynomial check itself ("where cost
   decides the shape, measure before specifying"), my tight-with-2-torsion-minimisers guess registered as its prediction before
   looking. Calls the invariant-measures-vs-walls note the sharpest statement of the competition's question, "the same shape as
   MASCOT-T10's open case (ii)".

5. **Planner → Poros.** The tightness guess (P-S1) **lost**: de Grey's K-lattice (⟨ζ₆^m ρ^n, |n| ≤ 2⟩, rank 4, 54 vectors) has
   continuous min over T⁴ of −22.4095 at a generic θ ≈ (0.070, 0.842, 0.035, 0.956) against −18 = −d/3 — **slack**. Exact quotient
   minima N = 2…12: −18 at 2, 4, 6 (tight); −18.034 at 5, −14.345 at 7, −18.142 at 8, −9.518 at 9, −18.271 at 10, −21.581 at 11,
   −18.928 at 12; N = 3 inadmissible. Odd refusals at 5 and 11 are NOT spectral (floors 3.99, 3.50; UNSAT by solver,
   `data/fs70/quotient/degrey-K-control.json`); 7 spectral (4.76); 13 by solver. N = 8, 10, 12 slack and four-colourable, yet the
   gap finder records no gapped colouring at any admissible N ≤ 12 — the planner proposed it as "the first observation of G54's
   middle case", registered falsifiable, with a re-check in phase 1. Asked whether this moves the C3 choice or the walls note.
6. **Poros → planner.** Hunch killed; **retracted my walls frame note** as a statement of the competition's question at K (it
   rested on tightness; without it the H1-to-forcing gap has two parts, recurrent non-periodic and non-recurrent, both live).
   The "new thing" is a **corollary**: Harder's forced 8/3 + T6/row 66 ⟹ every periodic colouring of every quotient of de Grey's
   lattice is gap-free — not G54's middle case (G54 concerns residue planes; "slack but gap-free" is automatic for any slack Cayley
   graph with a nontrivial forced pair); the re-check re-labelled as a free cross-check of two unshared instruments (the forces
   refusal and the gap finder). C3 choice unchanged (C3-inherit, non-vacuous, H1); the spectral route is gone at K. Asked: what is
   the competition's *informative instance* (H1 is established nowhere except via forcing), and which corpus entries construct
   non-periodic lattice colourings. Verified my recalled citation (arXiv:2411.01951, Combinatorial Theory 5(4) 2025, Problem 4.6 is
   R2's existence question in general, open; follow-up arXiv:2604.22705), read at abstract/extraction level only; re-flagged the
   unread Alon–Briceño–Chandgotia (2021) as a G50 block.

7. **Poros → planner (card for question 3).** [2Λ : V] = 81 = 3⁴ ⟹ 2Λ/V is a 3-group ⟹ 162Λ ⊆ V ⟹ L3's Kempe escape re-periodises
   (W′ = V) to a separating colouring of period dividing 2·3⁴ — a composite (2- and 3-adic) period. Ask: does it factor through
   Λ/2Λ or some Λ/3^jΛ alone? Neither ⟹ the prime-by-prime table is blind by construction, the classification needs a composite-period
   column, and (3) becomes FS-67's product question at four colours; through 3^j alone ⟹ T9's reading survives at rank 6. Hunch:
   neither.
8. **Planner → Poros.** Accepts all three points of message 6; **third retraction** (the "first observation of G54's middle case" —
   it is a corollary of Harder's refusal + T6; goes into phase 1 as a cross-check of two unshared instruments). C3-inherit, non-vacuous,
   at H1 confirmed; tools named (T10 with H1 ⟺ H2, G70's hexagon lemma, `[Polymath16wikiR2]` Cor. 9, compactness as a kernel leaf).
   The instance question "changes the plan": an **H1 census** phase before the competition — (i) the periodic Kempe screen over every δ
   in a box on de Grey's lattice and K-siblings, known-forced targets subtracted (8/3 Harder; 8/√3 M56; 4, 4/√3 the 791-point forcer,
   G9), the rest asked by ball solves; (ii) FS-70's rich 2-unit lattices (Kempe-rigid at 4/3, 8/3, 4, 4/7, 4/√3 under 48 additive
   colourings; tower-forced by T7; finite forcing never asked) as "the strongest candidate for H1 plausibly true, forcing open";
   (iii) a lattice whose periodic colourings provably factor through a tight tower (FS-67 at four colours). Names in §G as bears the
   corpus's non-periodic constructions: `[Polymath16wikiR2]` Prop. 6 tri-sectors, MASCOT-T10 case (ii), row 11's strip automaton, T2/T10
   swaps, G70's √3-dirty colourings. §PA reads: AEGHKM 2025 (§1, §4.3, §5.1, §6; Problem 4.6 restricted to 1-ended abelian Cayley
   graphs = C3-aper; ℤ² not strongly periodic, Carroll–Penland 2015), Waite 2026 (arXiv:2604.22705), Alon–Briceño–Chandgotia–
   Magazinov–Spinka arXiv:1903.11685 (five authors; frozen q-colourings of ℤ^d exist iff q ≤ d+1; Prop. 2.2 a non-frozen criterion),
   Burr 1984, Hochman 2025, Eggleton–Erdős–Skilton 1990.
9. **Poros → planner.** (1) the census can confirm C3-inherit, never refute it — state the uninformative outcome ("separates at every
   radius afforded") and confirm it is reachable; (2) (ii)'s rigidity is over 48 additive colourings, not H1-found — P-M2 (gapped at
   N = 3 or 5) run? cheapest reading first (G68); T8's U is generators only; (3) row 67's **P-D3** (no finite K²-graph forces depth 4
   although the tower does) is the corpus's own registered prediction on (ii)'s question — register (ii) depth by depth with it in
   view; (4) record fix: 23,083 is our ball, Harder's smallest forcing subgraph 745, M56's core 588 — G69's "three orders" compares
   balls. 
10. **Poros → planner (follow-up, addresses read).** `data/fs70/records/phase-1e.md` §3.4 / line 488: the rich lattices were screened
   at N = 2, 4 only; N = 3 inadmissible (line 394); N = 5, 7 never asked — P-M2's live half unrun; rigid verdicts are "under a
   generator-only screen" (line 502: saturation needed "if anyone wants their rigid verdicts to mean anything"). Corrected my own
   citation (the 10⁷ figure is G69's, not G65's).

11. **Poros → planner.** FS58-T4 is R1 at three colours (credit it to FS-58, not to either of us); its kernel note's "no wrapper" was
   checked in the wrong file — the planner's Finsubgraph lemma discharges FS-39's phase-A target; FS58-T3 is the three-colour
   tensor-product factorisation, the corpus's precedent for the classification's column (c), with the same prime-by-prime slip
   recorded and caught at FS-58.

12. **Poros → product owner (status).** Frame changes so far (R1 is FS58-T4; R2 contains AEGHKM Problem 4.6 / FS-72; H1 ⟺ H2; de
   Grey's lattice slack; the positive instance tests nothing → H1 census); two decisions ahead for the PO: (1) the held items H-1,
   H-2 (default: to the competition-phase advisor only, not into the briefs); (2) the product axis for question (1) — a realistic
   "done" is sharpened reductions + the K instance explained by its local lemma + a sufficient condition + the census's candidates,
   not a theorem or counterexample (default: the plan says theorem-or-counterexample and I raise it again in the final report).

13. **Product owner → Poros (rulings).** Decision 1: the held items stay out of the plan and out of §C; they go in full into my final
   report; the competition's advisor offers them to both competitors identically, at the same moment, and only after each has written
   its own first route. Decision 2 (settled by the PO as a planning question, not a re-scope): the target stays "a theorem or a
   counterexample"; the plan must register a prediction with both outcomes reachable and name the fallback deliverables as partial
   products (sharpened reductions; the K instance explained by its local lemma; a sufficient condition; the census's candidate list),
   headline "not landed" if neither lands. The PO tells the planner the same, without the held items.

14. **Planner → Poros.** Plan committed as `9d1fe367` (`plans/FS73-rigidity-dichotomy.md`, with this record as it then stood).
   Asked which SILENT entries bear (counts: grokkings 43 B / 27 S; rows 33 / 44; § B 91 / 163), naming its least-sure: G15, G58,
   rows 22–24, M45-T1, MASCOT-T5, M63D-T7, FS66-T9. P-Q1 registered: not landed 0.60, counterexample 0.30 (mostly abstract class),
   theorem 0.10.
15. **Poros → planner.** (1) **G59 is a trap, and a correction of my message 11:** Cay(Λ/NΛ, U) is a *subgraph* of the product of
   local targets (U mod N a finite diagonal subset — 54 of 24 × 48 pairs at N = 35), not the product; FS58-T3's tensor identification
   used weak approximation over an infinite U; so FS-67-type pull-back results and G59's χ_f-of-products hatch bound the quotient only
   from above; C3-local is not "FS-67 at four colours" for finite-U lattices. (2) G15 bears on fallback (b): the K explanation
   factors as G70's dichotomy (Act One) × a kill on the dirty branch. (3) M63D-T7 bears weakly — C3's bookkeeping (separations
   transfer up, refusals only down); cite in the census acceptance. (4) G58: bears through a PO-held item — leave the verdict. (5) Rows
   22–24: one periodicity check. (6) G64 weak bear for (3). Agreed silent: M45-T1, MASCOT-T5, FS66-T9.
16. **Poros → planner (after reading the committed plan §0, §S, §C, §P, §X).** **P1d's target box "every lattice point with |δ| ≤ 4"
   is infinite** (a rank-4 subgroup of ℂ is dense). Both sides of C3 are **subgroups**: F (forced; X translation-invariant) and P
   (common periods of periodic colourings), and P_found (finite index, ⊇ lcm(N)Λ, exact from the found colourings and R3). **C3-inherit
   at a lattice for all δ ⟺ P = F.** The census = the finite group P_found / F_known, one ask per nontrivial coset; at K, P_found =
   F_known would be a complete found-level confirmation. Vectors, not distances: √3 ∉ ℚ(√−3,√−11), so "8/√3 (M56)" on de Grey's
   rank-4 lattice is the distance of (8/3)(1+ζ₆) ∈ F already. Card: report rank F_known and rank P_found — ρ is not a multiplier
   (ρ³ = (16/9)ρ − 5/3 ∉ Λ), so 8/3's transport orbit spans rank 2; rank 4 would make X finite and C3 at K trivial; rank 2 makes the
   K instance a genuinely 2-D shift. **Verified after sending** (sympy, HNF of the 30 generators ζ₆^m ρ^n, |n| ≤ 2: rank 4,
   denominator 36; ρ³ ∉ Λ, ρ·ρ² ∉ Λ, 8/3 ∈ Λ, (8/3)(1+ζ₆) ∈ Λ, 1/9 ∈ Λ, 1/27 ∉ Λ).
17. **Planner → Poros (crossed message 16).** Adopted message 15 in `974ec8fa`: G15, G59, G64, M63D-T7 now bear; C3-local corrected to a
   diagonal subgraph; **fourth retraction** ("FS-67 at four colours"); rows 22–24 get a periodicity check in P1f; G58 left silent with
   the PO-held note; §X records both counting conventions (mine 2, planner's 4). Handing back to the PO. Message 16 may not have
   reached the plan — flagged to the PO.

18. **Poros → product owner.** Message 16 crossed the planner's hand-back and is not in the plan at `974ec8fa` (P1d still reads
   "every lattice point with |δ| ≤ 4"); asked the PO to carry the subgroup census (P_found / F_known, vectors not distances, the ranks
   of F_known and P_found) into P1's implementer brief or have the planner amend.

19. **Planner → Poros.** Message 16's P1d fix adopted in `73114a7f`, checked on the lattice's coordinates (ρ³ ∉ Λ; 8/3's ζ₆-orbit
   rank 2, (24,0,0,0), (0,0,24,0), …; (8/3)(1+ζ₆) = (24,0,24,0)). The census now computes P_found / F_known, one ask per nontrivial
   coset, both ranks reported; the rank-2 point is in §C as a thing worth knowing and registered as P-C4 (Poros).

20. **Product owner → Poros (correction, with the final-report request).** P_found ⊇ lcm(N)·Λ has rank 4 while P-C4 predicts F_known
   of rank 2, so P_found / F_known ≅ ℤ² × finite — **infinite**, not "the finite group" of message 16. The finite version: one forcing
   ask per *generator* of P_found modulo F_known (F a subgroup, so forcing every generator forces all of P_found). Generators in
   lcm(N)·Λ are H1-found only because of the periods searched, so the census's decisive quantity may be whether P_found stabilises as
   the periods grow; if the true P has finite index at K, C3 at K holds exactly when F has full rank, and a rank-2 F would be a
   **counterexample at K**, not only a two-dimensional shift.
   **Poros's check: the PO is right on both counts, and I was wrong on both.** (i) The quotient is infinite; the finite object is a
   generating set. (ii) Given P of finite index: F of finite index ⟹ every colouring is F-periodic, X is finite, all colourings are
   periodic, so P = F and C3 holds for every δ; conversely C3 ⟹ P = F ⟹ F of finite index. So "C3 at K ⟺ F full rank" holds under
   finite-index P, and my P-C4 consequence ("rank 2 ⟹ a genuinely 2-D shift") understated it: under finite-index P, rank-2 F is a
   counterexample at K. One addition of mine: generators of P_found inside lcm(N)·Λ are also *unaskable* — a vector of 27,720·Λ is
   long in the conjugate embedding too, so any Minkowski ball holding it is ~10⁴ times the radius of Harder's. Forcing asks can
   only be made at short generators; the artifact generators are decided by searching larger periods (does P_found shrink toward
   F_known?), never by balls.

## 3. Retraction count

| side | count | what was withdrawn, and what killed it |
|---|---|---|
| planner | 4 | (4) "C3-local is FS-67's question at four colours" — killed by the finite-U point (message 15): the quotient is a diagonal subgraph of the product, not the product. (3) "the N = 8, 10, 12 gap-freedom is the first observation of G54's middle case" — killed as a corollary of Harder's forcing + T6/row 66 (message 6→8). (1) "under H1 every escape the screen can find has rank V < rank Λ" — killed by the re-periodisation (swap K₀ + W′, W′ ⊇ V of finite index missing e; ℤ^r/V residually finite); (2) "Weil/Hoffman refuse four colours from q ≈ 37 up" — killed because the period-p quotient is Cay(Λ/pΛ, U mod p), a subgraph of the target once the circle outgrows U, whose Hoffman floor tends to the lattice's own ≤ 4. Both in the free window, 2026-09-23. |
| Poros | 2 | (2) message 11's "FS58-T3's tensor-product shape is the precedent for column (c)" — for finite-U lattices the quotient is a subgraph of the tensor product (FS58-T3 used weak approximation over an infinite U); retracted in message 15, free window. (1) the frame note "tightness controls invariant measures, so C3-inherit at H1 comes down to walls" as a statement of the competition's question at K — killed by the planner's measurement that de Grey's lattice is Hoffman-slack at four colours (−22.41 vs −18). Retracted in message 6, free window. (The hunch lattice-is-hoffman-tight-over-K itself is a *lost prediction*, counted in §4, not as a retraction.) |

*After the planner's hand-back (outside the free window): two more of mine, caught by the product owner — "the finite group
P_found / F_known" (the quotient is ℤ² × finite; the finite object is a generating set) and P-C4's consequence understated (under a
finite-index P, rank-2 F is a counterexample at K). The first is committed in `73114a7f`'s P1d row and needs its wording fixed; exact
replacement text is in the hand-back. Counting both: Poros 4, planner 4. The planner's §X records its own count (4) and mine at
hand-back (2).*

## 4. My own errors, against myself

1. **The tightness prediction lost** (registered as a guess, message 3; killed message 5). What it cost: nothing committed; the
   planner spent a few seconds of numerics, which it had budgeted anyway. The mechanism of the miss: I reasoned from the level-one
   quotient (λ = −d/3 at the residue colouring's characters, by equidistribution of U in 𝔽₄^×) to the global minimum without
   asking what a *generic* character does — 54 cosines at a generic point of T⁴ can go well below the value at 2-torsion. The rule it
   amends: a tightness guess needs the continuous minimum, not the minimum over the torsion points one happens to understand.
2. **A frame note conditioned on that guess** ("the residue is domain walls") was received as "the sharpest statement of the
   competition's question" before the condition was checked — I offered it in the same message as the unchecked premise. Retracted
   (§3). The rule: do not ship a consequence in the same message as its unchecked premise when the consequence is quotable alone.
3. **R1 sent as if new without walking § B first** (message 1). FS58-T4 held it at three colours, and I found it only after the
   planner had accepted R1 and planned to credit it. Cost: an attribution that would have gone into the plan wrong; corrected in
   message 11 before the plan was committed. Mechanism: I asked the planner to walk every § B line and did not grep § B myself
   before sending a "reduction". The rule: a reduction offered to the owner is searched in the owner's own ledger first.
4. **A mis-cited grokking** (message 9: the 10⁷ figure attributed to G65; it is G69's). Caught by me on re-reading, corrected in
   message 10. Cost: none. Mechanism: citing from memory of two adjacent entries on the same subject.
5. **"The finite group P_found / F_known"** (message 16, adopted into the plan at `73114a7f`). Wrong: P_found has rank 4 (it
   contains lcm(N)·Λ) and my own P-C4 predicts F_known of rank 2, so the quotient is ℤ² × finite. Caught by the product owner at the
   final-report request. Cost: one planner commit carries the wrong word "finite"; the census logic survives with "a finite generating
   set of P_found modulo F_known" in its place. Mechanism: I checked the subgroup claim and the vector arithmetic (sympy) and did not
   check the rank of the quotient against the prediction I sent in the same message. The rule: when a message carries both a
   construction and a prediction, check the construction against the prediction before sending.
6. **P-C4's consequence understated** (message 16: rank-2 F ⟹ "a genuinely two-dimensional shift"). If the true P has finite index,
   rank-2 F is a counterexample to C3 at K. Caught by the product owner. Mechanism: I reasoned about F alone and never combined it with
   the finite-index structure of P that I had stated three lines earlier.

## 5. Held for the product owner (not sent to the planner — possible head start for the competition)

*Two partial approaches to C3-inherit itself (not sharpenings of its statement). **PO ruling (message 13):** out of the plan and §C;
in full in my final report; offered by the competition's advisor to both competitors identically and at the same moment, only after
each has written down its own first route. **Their content is deliberately not written in this committed record**, so that the
record cannot brief a competitor who reads it: H-1 is a necessary condition on one shape of counterexample; H-2 is a
constructive family for the recurrent part of the gap. Full text: the hand-back to the product owner, 2026-09-23.*
