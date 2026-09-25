# M50 — the theorem audit (FS-71 batch 2b; ledger row 45)

*Filed 2026-09-22 by the batch-2b implementer. Enumeration: `plans/M50-batch-descent.md` read in full
(the stub, §B–§Bʹʹʹ, §0–§4, §R7 predictions, §S, §Sʹ–§Sⁱᵛ, §Sⁱᵛ-adv, §S-CONT, §R1–§R6); `LEDGER.md`
row 45 and § B; `plans/M51-descent-engine.md` §C, §R0 and its docstring cross-references, to trace
where two of M50's own hand-sketched lemmas actually landed in the kernel (they did, one milestone
later — see "Kernel already, one milestone later" below); `Proofs/HadwigerNelson/SpareColour.lean`,
`Proofs/HadwigerNelson/EntropyFloor.lean`, `Proofs/HadwigerNelson/PartnerLattice.lean` read in full.*

## The theorems

**M50-T1 — Batch-halo composition is sound. [hand; the phase-0/2 implementer]**
Killing is monotone in the point set, and orbit-filtered sub-batch enumeration is sound, complete and
one-representative-per-orbit. For a stage graph on vertex set `V` with a cheat (distance-2 edge) set `E₂` and a target pair `(A,B)`:
(i) **monotonicity** — if a halo point set `P` kills a separating colouring `c` of the current object
(no proper extension of `c` to `P` with `A ≠ B` exists) then so does every superset `Q ⊇ P` (a solution
of `Q`'s constraint problem restricts to one of `P`'s, since `P`'s constraints are a subset and the
colouring lists depend only on the fixed `c`); (ii) **the sub-batch filter is sound, complete and
one-representative-per-orbit** — for a candidate batch `B' ⊇ B`, the palette-canonicalized separating
colourings of `(stage − B')` filtered to properness on `B' ∖ B` are exactly the palette-orbit
representatives of the separating colourings of `(stage − B)`: (a) *sound* — a filtered colouring is
proper on `stage − B` (properness on `(stage−B')`'s edges plus `B'∖B` is properness on all of
`stage − B`'s); (b) *complete* — any separating colouring `d` of `stage − B` is one of `stage − B'` too,
so its palette orbit has a representative `c` in the canonicalized list of `(stage − B')`, and
properness on `B'∖B` together with `c(A) ≠ c(B)` are both palette-invariant, so `c` passes the filter;
(c) *one per orbit* by construction of the canonicalization. **Consequence used throughout the
milestone's engine:** a single halo, designed against the WHOLE batch's separating-colouring list, may
be committed in one certified step removing many cheats at once — composition by construction, no
per-edge ordering needed (used to remove 19, then 24, cheats in single commits, §R4/§R6). *Proof:*
`plans/M50-batch-descent.md` §Bʺ ("The instrument's invariants, partitioned prove / test / execute" —
the monotonicity bullet and "the sub-batch filter is one-representative-per-orbit" bullet, both stated
with their complete arguments in two-to-three sentences each); tested end-to-end against M49's own
684/1,010 sub-batch counts (reproduced exactly, §R1–R2) and a dedicated monotonicity probe planted in
`--self-test`. *Proof verdict:* closes. *Rests on it:* row 45's "batch halos compose by construction"
clause; every certified multi-cheat commit in M50 and M51 (§R4, §R6's iteration-2 commits, the
iteration-3 floor). *Prior art:* ours — this is the descent engine's own soundness architecture,
specific to this project's vocabulary (`Forces`, cheats, halos); no discipline-neutral restatement was
attempted since the claim is definitional once `Forces`'s edge-monotonicity (already kernel,
`Forcer.Forces.mono`) is granted for the "killing" half. zbMATH: `ab:"list coloring" & ab:"monotone" &
ab:"extension"` (2 hits, standard list-colouring extendability results, not this construction);
`ab:"orbit" & ab:"canonical" & ab:"symmetry breaking" & ab:"SAT"` (11 hits, the symmetry-breaking-in-SAT
literature generally — the specific one-representative-per-orbit argument for a *palette* group acting
on colourings is not found among the titles). *Kernel:* declined — stated and used as tool-side prose
throughout the descent (M50 §Bʺ item 3: "recorded here because the control leans on it"); never
formalized, and the milestone's own kernel budget went to `PartnerLattice.lean`'s two lemmas instead
(below).

**M50-T2 — The E–I stage's absolute compulsion inventory, complete. [tools; the phase-adversarial implementer, correcting an earlier sampled estimate from the same milestone]**
The Exoo–Ismailescu `{1,2}` stage carries exactly 148 absolute virtual edges at distance `{3, 4}` and
(on the full 412-triple census) 43 never-3-distinct families. Over ALL 51,350
palette-canonicalized proper 5-colourings of `H` (M49's certified seed, exact and complete — not
sampled), exactly 148 pairs at distance 3 or 4 read palette-agreement mass `P = 0` (monochromatic in
NONE of them) — i.e. they are virtual edges of the distance-graph `distanceGraph ℂ {1,2,3,4}`
restricted to `H`'s drawing, unconditionally, confirmed by ten-of-ten direct SAT asks (no separation
pin) all UNSAT. Independently, a complete census of all `C(214,3) = 1,570,584` vertex triples finds 412
that are never rainbow across the same 51,350 colourings (206 √3-equilateral, 92 √7-equilateral, 67
`(√7,√7,2√3)`-isosceles, **43 `(√13,√13,√3)`-isosceles** — a family the milestone's own earlier
17-point-sampled sweep had missed entirely, √13's spindle radicand 51 = 3·17 lying outside this
project's owned fields — and 4 `2√3`-equilateral). *Proof:* `plans/M50-batch-descent.md` §Sⁱᵛ-adv,
"What it verified beyond the sample" ("The absoluteness inventory is now COMPLETE, not sampled:
148/148 pairs and 83/83 triples UNSAT..."; "The never-3-distinct census, cast-free, is ~23× the §Sⁱᵛ
count... it-1 holds 412"), cross-checked between two independently written codebases (the adversarial
agent's and the milestone's own committed tool) agreeing number for number, with four negative
controls SAT. *Proof verdict:* closes. **Demotion recorded in the same pass, filed here as its own
correction rather than left implicit**: the milestone's own earlier count of "16 never-3-distinct
triples" (§Sⁱᵛ item 2b) was a **cast artifact** — computed only over a 17-point sampled subset of `H`,
not the full 214 — and is superseded by the 412 above; nothing about the earlier sampled subset was
wrong, its *scope* was simply narrower than the sentence describing it claimed (G21's rule applied to a
positive count, not only to a negative one). *Rests on it:* row 45's "148 absolute virtual edges at
d ∈ {3,4} (measured)"; the polarization reading (§Sⁱᵛ item 2d) that motivated the target-distance
compass for M51's gadget hunt. *Prior art:* ours — this is a fact about one specific certified object
(`H`), not a general theorem; no literature search applies. *Kernel:* declined — the claim quantifies
over a specific finite colouring list held only as SAT-enumerated data (`build/m50-skewscan-*.json`),
not a Lean structure.

## Readings and measurements that were called theorems

- **The entropy floor's "contrapositive" application — REFUTED as written, by the milestone's own
  record (§Sⁱᵛ-adv).** §Sⁱᵛ item 4 stated: "any object with fewer than `2^{n/4}/120` five-colouring
  classes has a 5-chromatic unit part" and applied it to the seed `H` (35 classes) to predict a
  4→5 phase crossing strictly before the descent's end. The adversarial pass found the counterexample
  sitting two subsections away in the milestone's own text: `H` itself has exactly 35 classes (far
  below the floor) while `H`'s *unit part alone* is 4-colourable (§Sʹʹʹ) — the theorem is about ONE
  graph's own colouring count against its OWN chromaticity, and cannot be applied across a
  graph/subgraph pair. The underlying theorem — "if `χ(G) ≤ k−1` on `n` vertices then `G` has
  `≥ 2^⌈n/(k−1)⌉` proper `k`-colourings" — is correct and is filed nowhere as a defective proof: it
  is fully proved in the kernel at M51 (`two_pow_le_card_coloring`, `EntropyFloor.lean` — see below).
  What is demoted here is only the *contrapositive misapplication*, which never had a proof and is
  recorded as a conjecture below.
- **The stall as an LP duality object (§Sⁱᵛ item 5) — REFUTED as written (§Sⁱᵛ-adv).** The proposed
  packing/covering LP dual treats "killing" as a per-point set-cover primal; the project's own §R10
  K₃,₃ caveat already states that killing is a property of the whole point *set*, not decomposable
  into single-point contributions, so the dual bounds only single-point-kill covers. The registered
  validation test (compare the LP bound against M49's measured 87–267-point depth-two gadgets) would
  have detonated the frame outright: those refusers have NO single-point kill in any field (the LP
  reads `+∞`) while gadgets of 87–267 points exist. Withdrawn; the salvage (bounding single-point-kill
  covers only) is subsumed by the monotonicity half of M50-T1.
- **K₅'s projectivity (§Sⁱᵛ item 6, confirmed §Sⁱᵛ-adv) is prior art**, not a theorem of this project:
  for `k ≥ 3`, `K_k` is projective (its only polymorphisms are dictators up to palette permutation) —
  `[GreenwellLovasz1974]` for the base fact, strengthened by `[LaroseTardif2002]`'s "strongly
  projective" result (Inv–Pol with a trivial polymorphism clone: every `S₅`-invariant relation is
  pp-definable from `≠`). Neither paper is held or read here (both newly logged in
  `BIBLIOGRAPHY.md` § R.4, item 11, this commit); the milestone's own three consequences — (i) no
  colouring-combination operation (crossover/averaging/majority-vote) can propose new 5-colourings
  from old ones; (ii) no colour-side algebraic obstruction to a χ ≥ 6 gadget can exist, only geometric
  ones; (iii) separating-colouring lists have no exploitable algebraic closure structure — are the
  project's own corollaries of an unread theorem, filed as *readings*, not theorems, pending the
  check owed against the two papers. *[Correction at FS-89's close, 2026-09-25, from the products reader (`plans/PA-products-GL1974-LT2002.md` §0 item 6, §3; both papers read in full): the check is paid. The base fact holds: `[GreenwellLovasz1974]` Corollary 3 at `n = 5`. "Strongly projective" is misattributed: it is `[Larose2002]` (Larose alone, Can. J. Math. 54 (2002) 757–768; not held, its review read), not `[LaroseTardif2002]`, which never uses the phrase. The Inv–Pol consequence is the general Galois correspondence given Corollary 3, in neither paper, and "trivial polymorphism clone" is inexact (`Pol(K₅)` is the permuted projections; only its idempotent part is trivial). The reader judges the `S₅` consequence promotable from reading to hand grade on that basis; this close notes it and leaves the grades above as filed.]*
- **§R5's exact geometric observations** (the blind centres v58/v115, the metapivot hexagon, the
  four-point total pigeonhole, the full forcing sweep's fifteen minimal 4-set pigeonholes) are exact,
  complete-enumeration checks of Kooshi's own hand observations on ONE object (`H`) — genuinely
  rigorous, but scoped entirely to that object with no stated general claim, and not consumed by any
  later theorem beyond the polarization reading already covered by M50-T2. Not filed as separate
  theorems.
- **§R3's "the growth compounds, and no refuser provably survives the grown lattice"** and the
  iteration-2/3 depth-profile numbers (§R3, §R6) are measurements of one campaign's progress against
  one object at one point in time, already summarized correctly in row 45's tools clause ("growth
  re-opens refusers").

## Conjectures surfaced, not claimed

- **The entropy-floor contrapositive misapplication** (demoted above): "an object with fewer than
  `2^{n/4}/120` five-colouring classes, counted on a subgraph, forces its unit-distance supergraph to
  be 5-chromatic" — false as a cross-graph statement; no consumer.
- **The LP-duality stall bound** (demoted above): "`1/max-kill-mass` lower-bounds a depth-D gadget's
  point count" — refuted by the project's own K₃,₃ caveat and the registered validation test;
  withdrawn, M51-instrument candidacy explicitly abandoned in the record.

## Prior art re-attributed

- K₅'s projectivity and its "strongly projective" strengthening: `[GreenwellLovasz1974]`,
  `[LaroseTardif2002]` — new bibliography row added (§ R.4, item 11) this commit; both remain "not
  held; not read", so the consequences above stay *readings* pending a read. *[At FS-89's close, 2026-09-25: both are now held and read in full (`plans/PA-products-GL1974-LT2002.md`); the "strongly projective" strengthening is `[Larose2002]`'s, not `[LaroseTardif2002]`'s, and the row is § R.4 item 14 — see the note above.]*

## Kernel already, one milestone later (found while tracing the seed for T1)

**Not filed as M50 theorems** (per FS-71 §M.2: a theorem's home is where it was proved, not where it
was first sketched) but recorded here because row 45 does not name either file and no other ledger row
does: the two constructive centrepieces this milestone designed with proof sketches but no Lean —
**the spare-colour lemma** (§Sⁱᵛ, "The constructive centrepiece": *"a (k−1)-colourable graph admits no
pair compulsion of either polarity between non-adjacent vertices at k colours"*) and **the entropy
floor theorem** (§Sⁱᵛ item 4, the correctly-scoped half: *"if χ(G) ≤ k−1 on n vertices then G has at
least 2^⌈n/(k−1)⌉ proper k-colourings"*) — were both promoted to full kernel proofs the very next
milestone, M51, phase 0k (`plans/M51-descent-engine.md` §C, §R0): `Proofs/HadwigerNelson/SpareColour.lean`
(`not_forces_of_colorable`, `not_separated_of_colorable`, `Forces.not_colorable`,
`Separated.not_colorable`) and `Proofs/HadwigerNelson/EntropyFloor.lean` (`two_pow_le_card_coloring`,
`not_colorable_of_card_coloring_lt`), both on axioms exactly `[propext, Classical.choice, Quot.sound]`.
This is the same pattern batch 1 found between M33 and M34 (a hand sketch promoted to kernel one
milestone later): the theorems are **kernel already** and not filed here or in `M51-derivation.md`
(which accordingly holds no theorems of its own — see its own file's header note). **Flagged as a gap
in the ledger itself, for the product owner**: `SpareColour.lean` and `EntropyFloor.lean` are cited by
name nowhere in `LEDGER.md` or `CLAUDE.md` (checked: `grep -n "SpareColour\|EntropyFloor" LEDGER.md
CLAUDE.md` returns nothing) — the spare-colour lemma is explicitly consumed by grokking G40 and by
`FS70-T3`'s parenthetical ("carries no four-colour pair compulsion (the spare-colour lemma)"), so its
proof is a real dependency of held content with no ledger address of its own. **Proposed:** either
extend row 45's "Where" column to add `SpareColour.lean`, `EntropyFloor.lean`, `PartnerLattice.lean`
alongside `Glue.eq_gluePoint_of_unit_pair`/`Glue.finite_two_unit_neighbors` (which ARE already in row
45's text), or mint a dedicated row for M51 at the close. Left to the owner, per the batch's writer
rules.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M50-T1 | declined — tool-side prose invariant, never formalized |
| M50-T2 | declined — a specific-object SAT census, not a Lean-representable claim |
