# M55 — the theorem audit (FS-71 batch 3a; ledger row 49)

*Filed 2026-09-22 by the batch-3a implementer. Enumeration: `plans/M55-absorption.md` read in full (mission
context through §3's D1–D6 derivations, the phase order, §R0–§R6's close and addenda); `LEDGER.md` row 49 and
§ B; `Proofs/HadwigerNelson/Absorb.lean` (full declaration list, to fix exact kernel names and to confirm which
of D1–D6 landed in the kernel and which stayed hand).*

## The theorems

**M55-T1 — D1: the extension principle (Extends). [hand; the M55 implementer, generalising M53-T11's
spare-colour corollary]** Say `A ⊆ V` *extends* at `k` colours if every proper `k`-colouring of `G[A]` is the
restriction of a proper `k`-colouring of `G`. Then for `p, q ∈ A`: `Forces G k p q ↔ Forces G[A] k p q` and
`Separated G k p q ↔ Separated G[A] k p q`; consequently, if `A` extends at `k` and `G[A]` is `(k−1)`-colourable,
no pair compulsion at `k` colours lives among `A`'s vertices — the spare-colour lemma *relative to a piece*.
*Proof:* `plans/M55-absorption.md` §3 D1 — restriction gives one direction, extension the other; the corollary
is `SpareColour`'s argument applied to `G[A]` instead of `G`, transported back through the `iff`.
*Proof verdict:* closes; the whole content of the theorem-side of the milestone is stated here as "sufficient
conditions for 'A extends'" (D2–D4 below). *Rests on it:* every one of D2–D4; the whole absorption programme's
architecture (M55's own §1: "the abstract carrier"). *Prior art:* ours — a direct generalisation of the
spare-colour lemma (`LEDGER.md` row 45, itself uncredited to an outside source) from `A = V` to a general
extending subset; no discipline-neutral literature search attempted for this exact abstraction (it is a
restatement of `Forces`/`Separated` relativized to an induced subgraph, a standard move once the definitions
are granted). zbMATH `ab:"precoloring extension" & ab:"critical"` (general precolouring-extension literature;
nothing matching a "does every colouring of the induced subgraph extend" abstraction phrased this way). *Kernel:*
**kernel** — `Extends` (def), `Extends.forces_iff`, `Extends.separated_iff`, `Extends.not_forces_of_colorable`,
`Extends.not_separated_of_colorable` (`Absorb.lean`).

**M55-T2 — D2: hub-and-matching absorption. [hand; the M55 implementer]** Suppose `x ∈ A` (the hub) with
(i) `G[B ∪ {x}]` `k`-colourable (`B = V ∖ A`), (ii) every `b ∈ B` has at most one neighbour in `A`, and
(iii) the `B`-vertices whose `A`-neighbour is not `x` are pairwise non-adjacent. Then `A` extends at `k+1`
colours. **Hypothesis (iii) is load-bearing**: a `k`-colourable piece need not be `k`-*choosable*, so a matching
attachment with adjacent endpoints can refuse to extend (`K₂,₄` attached by a matching at three colours is the
planted red, exhibited in §7 and kernel-checked as `k4MinusEdgeHub`/`k33Pendants`). *Proof:*
`plans/M55-absorption.md` §3 D2 — given a `(k+1)`-colouring `c` of `G[A]`, take a `k`-colouring `φ` of
`G[B ∪ {x}]`, permute `φ`'s palette so `φ(x) = c(x)` when `c(x) ≤ k` (then every `x`-neighbour in `B` clashes
with `c(x)`'s value already), colour `B` by `φ`, then repaint each clashing non-hub vertex with the spare colour
`k+1` — the repainted set is independent by (iii) and untouched by the hub's own constraints by (ii).
*Proof verdict:* closes; the plain matching case (`x` with no `B`-neighbour) is D2's instance with `A ↦ A ∖ {x}`
absorbed trivially. *Rests on it:* D6(a)/(b)'s application to the multi-spindle star and the flower (see
"Readings and measurements" below); row 49's
kernel citations. *Prior art:* ours — the repaint argument is a specific composition technique for this
project's spindle-union constructions; the closest standard concept is **list colouring / Hajós-style vertex
identification**, neither of which states this exact conditional. zbMATH `ab:"hub" & ab:"graph coloring" &
ab:"extension"` (0 hits matching); `ab:"matching" & ab:"list coloring" & ab:"extendable"` (general list-colouring
extendability, nothing matching the hub-plus-matching shape). *Kernel:* **kernel** —
`extends_of_hubs` (the general, multi-hub form: a hub *map* `hub : V → V` sending every `b ∉ A` to some hub in
`A`, generalizing D2's single-hub statement — see M55-T3 for how this is more general than the plan's own D2),
`extends_of_hub_matching` (the single-hub instance, matching D2's statement exactly), `extends_of_matching` (the
no-hub case). **This is `CLAUDE.md` G40's cited target**: "a spindle copy hangs by its fused centre plus one
chord, so more spindles or centres cannot create a compulsion" is `extends_of_hubs` applied to a multi-spindle
star with each copy's fused centre as its hub — a direct instance, not a further derivation.

**M55-T3 — The repaint lemma, more general than D2 as stated. [hand → kernel; the M55 implementer, found while
formalizing]** `Absorb.lean`'s `extends_of_repaint` generalizes D2's hub-and-matching argument to an arbitrary
"clashes" structure: a piece vertex `b ∉ A` *clashes* under `(c, φ)` when a neighbour across the cut wears the
colour `φ(b)`; if for every colouring `c` of `G[A]` some `k`-colouring `φ` of the piece exists whose clashing set
is independent, `A` extends. D2 (M55-T2) is the case where `φ` is built from a hub-fixing palette permutation
and (iii) guarantees independence combinatorially; `extends_of_hubs` is the case where the hub structure is a
map rather than a single vertex. *Proof:* `Absorb.lean` §"The repaint lemma" (declaration `extends_of_repaint`)
— found and named during the M55 implementer's formalization pass, not present as a separately numbered item
in the plan's own D1–D6 list (the plan states D2 directly in its hub-specific form; the repaint lemma is the
*general* shape the Lean proof needed as an intermediate step, then specialized twice). *Proof verdict:* closes
— it is kernel. *Rests on it:* `extends_of_hubs`, `extends_of_hub_matching`, `extends_of_matching` all factor
through it. *Prior art:* ours — an implementation-driven generalization; not separately searched (it is a
strict generalization of M55-T2, whose own search already covers it). *Kernel:* **kernel**
(`extends_of_repaint`, `Absorb.lean`). **Cross-batch note**: the brief flags "the spare-colour lemma… may live
here as `extends_of_repaint` — say so if it does." **It does not.** `extends_of_repaint` is the *piece-relative*
absorption mechanism (D1/D2's engine), a strictly different theorem from `SpareColour.lean`'s absolute
spare-colour lemma (`not_forces_of_colorable`/`not_separated_of_colorable` at `A = V`, filed under M50/M51,
`LEDGER.md` row 45, batch 2b) — `Extends.not_forces_of_colorable` (M55-T1, this file) is the correct kernel
address for the *relative* form the brief may have meant; `extends_of_repaint` is one proof-step further in,
the mechanism that makes `Extends A k+1` provable for a non-trivial `A`, not the spare-colour statement itself.

**M55-T4 — D3: degree absorption (the `(k+1)`-core). [hand; the M55 implementer]** A vertex `b` of degree
`≤ k`: every `(k+1)`-colouring of `G − b` extends (its neighbours use at most `k` colours, leaving one free).
Iterating (peel every vertex of degree `≤ k`, then every vertex whose degree in the remainder is `≤ k`, …)
leaves the `(k+1)`-core; every pair compulsion at `k+1` colours among the core's vertices is the core's own,
and nothing outside the `(k+1)`-core is ever visible at that colour count. *Proof:* `plans/M55-absorption.md`
§3 D3, one sentence (D2 with `A = V ∖ {b}`, `B = {b}`, hub trivial — a colouring of `G − b` colours `b` by
whatever the remaining colour is). *Proof verdict:* closes. *Rests on it:* the reading that M54's depth-one
cross-pool points (degree ≤ 4 each, two parents and ≤ 2 pool edges) are invisible at five colours unless depth
two raises their degree — confirmed in M55's own B5 census (M55-T7). *Prior art:* the `k`-core / degeneracy
peeling technique is **standard graph theory** (a `k`-degenerate graph is `(k+1)`-colourable by exactly this
greedy peel; the fact is textbook, e.g. any introductory graph-colouring text) — this entry's contribution is
noticing the *forced-pair-localizing* reading ("nothing outside the core is ever visible"), which is D1's
lens applied to degree rather than to a specific forced pair. zbMATH `ti:"degeneracy" & ab:"graph coloring" &
ab:"greedy"` — standard, many hits, not searched exhaustively since the base fact is textbook. *Kernel:*
**kernel, and the ITERATED form is kernel too — corrected from an earlier pass of this entry that missed it.**
`extends_of_extensionOrder` (`Absorb.lean`) is exactly the iterated-peeling statement (`ExtensionOrder G k A L`:
a greedy order adding vertices of degree `≤ k` into `A` one at a time; if the order exhausts the complement,
`A` extends); `extends_compl_singleton_of_degree_le` is its one-vertex instance, proved FROM
`extends_of_extensionOrder` at `L = [b]` (`Absorb.lean` lines 359–376), not a separate primitive — the
`data/m55/README.md` names `extends_of_extensionOrder` as "greedy absorption (the `k`-core)" in exactly these
words, which is what caught the miss.

**M55-T5 — D4: symmetric copies force only through fused points. [hand; the M55 implementer]** Let `G′` be two
disjoint copies of `G` joined by chords `(a, a′)` for `a` in a set `S` (a spindle's *ring* chords, no fusion).
For `k ≥ 2`, every `k`-colouring `c` of the first copy extends: colour `a′` with `c(a) + 1 (mod k)`. So a
spindle's refusal at `k+1` colours lives entirely in the fused centre (its image under the rotation *is* the
centre), and a petal attached by ring chords alone is absorbed with no spare colour spent at all. *Proof:*
`plans/M55-absorption.md` §3 D4 — the recolouring `c(a)+1 (mod k)` never repeats `c(a)` (`k ≥ 2`), so every ring
chord is proper, and the second copy's own internal edges are proper because `c ↦ c+1` is a colour-preserving
permutation of `Fin k`. *Proof verdict:* closes. *Rests on it:* the reading that de Grey's own single-centre
"flower" genre (M55's B4, D6 below) is absorbed regardless of petal count, *by this theorem alone*, with no
appeal to hub structure — ring chords need no hub at all. *Prior art:* ours — an elementary symmetric-graph
observation; the closest standard notion is a **graph automorphism-induced colouring extension**, not
separately searched as a named result (the argument is three lines once `symCopy` is defined). *Kernel:*
**kernel** — `symCopy` (def), `symCopy.coloringOfPerm`, `extends_symCopy` (`Absorb.lean`).

**M55-T6 — D6(c): fusion is impossible between copies of `U`. [hand; the M55 implementer]** For centres
`x ≠ x′` (both in `U ⊂ K²`), the composite `R_{x′}⁻¹ R_x` is translation by `(x′−x)(1 − e^{−iθ})`, and
`1 − e^{−iθ} = (9+3i√247)/128 ∉ K(i)` (the ρ-rotation's own field), so `R_x(U)` and `R_{x′}(U)` share no point.
*Proof:* `plans/M55-absorption.md` §3 D6 — direct field-membership check (`(9+3i√247)/128` has a nonzero
`√247`-coefficient, so it is not in `K(i)`). *Proof verdict:* closes, an exact algebraic fact. *Rests on it:*
D6's other three claims (see "Readings and measurements" below — (a)'s "0 cross chords measured" between
copies rests on this); the reading that dense fusion (de Grey's own 1344/234-fusion record) needs fabric
already grown inside `F₂₄₇`, never mere repetition of `U`'s own rotation. *Prior art:* ours — elementary field
arithmetic specific to the ρ₁₅/ρ₆₃-family rotations (`CLAUDE.md` G7); no discipline-neutral search applies (a
one-line field-membership computation). *Kernel:* declined — an ad hoc field computation with no named Lean
consumer.

**D6's other three claims — not given separate T-ids; readings and tools-grade measurements, not theorems in
their own right.** (a) *The `m`-spindle star extends by derivation, for every `m`* — `extends_of_hubs`
(M55-T2) applies to each copy **provided** its conic cross chords form a matching with pairwise non-adjacent
copy-side endpoints, which is **checked by census on the two built objects** (two- and three-spindle stars: 8
and 11 cross chords respectively, 0 between copies by M55-T6), **not derived from the rotation's geometry for
an arbitrary `m`** — so the "for every `m`" clause is a reading, not a proved universal, and is recorded as
such in "Readings and measurements" below. (b) *The flower reads floppy at `K ≤ 3`, though D2 does not decide
its hub* — a tools-grade measurement (four-colourability of `flower − x` and the exhaustive five-colour sweep,
both confirmed at `K = 1, 2, 3` only). (d) *"What survives every absorption theorem"* is a qualitative summary
sentence, not a claim with a proof to check. All three are filed in "Readings and measurements" below, per
`plans/FS71-theorem-audit.md` §M.1's kind-before-grade rule (a claim checked only on the objects built, with no
general derivation, is a measurement even where a specific instance closes).

**M55-T7 — F₂₄₇ depth-two: the cross-thickening frees the critical set asymmetrically. [tools; the M55
implementer]** A depth-two cross-only census (pairs with one endpoint on each `K`-coset side) of the witness
plus its depth-one pool (2,433 points total): 2,243 of 345,704 tested pairs (0.65%) glue in `F₂₄₇`, giving
1,195 new points with 309 fusions (a quarter reached from ≥ 3 parent pairs — "the F₂₄₇ thickening is
lattice-like, again"). The criticality census on `W`'s own 1,175 vertices (pool points can never be critical)
finds **937 of 1,175 critical, 238 freed — every one on the copy side (R(core₁)), none on the core side**; the
freed set is still coverable by no two unit circles, so the dial reads zero at five colours by M54-T1 alone,
with no sweep needed. *Proof:* `plans/M55-absorption.md` §R4, both censuses (`cross-lattice --depth 2
[--cross-only]`, `critical --only`). *Proof verdict:* closes (tools grade — exact geometry, exhaustive census on
the specific object, 937/1,175 confirmed by verified colourings). *Rests on it:* `LEDGER.md` row 49's own text
("a depth-two F₂₄₇ cross thickening frees 238 critical vertices, all on the copy side"); the open question T24
("what distinguishes the two K-cosets in the F₂₄₇ pool — the asymmetry must come from the rotation's direction
relative to the fabric's own ladder structure"), registered but not answered here or in this batch's material.
*Prior art:* ours — a measurement on one specific constructed object, not a general claim; no literature search
applies. *Kernel:* declined — tools grade only, no kernel form; the open asymmetry question (T24) has no
consumer yet.

## Readings and measurements that were called theorems

- **D6(a) — the `m`-spindle star extends for every `m`.** Confirmed on the two objects actually built (the
  two- and three-spindle stars: `extends_of_hubs` applies once the census confirms the matching hypothesis on
  each), stated in the source as a general "for every `m`" reading. Not filed as a theorem: the matching
  condition is checked per object, not proved to follow from the rotation's geometry at arbitrary `m` — a
  gap the source itself does not close (its own three-spindle attempt found `F₃ ∩ F₁ ≠ ∅`, one layer of the
  argument that needed the weaker two-ask fallback instead of the clean derivation — see P-M55-5 below).
- **D6(b) — the flower reads floppy at `K ≤ 3`.** Tools grade: `flower − x` 4-colourable and the five-colour
  sweep 0/0, confirmed at `K = 1, 2, 3` (11 s, 29.8 s at `K = 2, 3`); no general-`K` claim proved.
- **D6(d) — "what survives every absorption theorem."** A qualitative summary sentence (dense, non-symmetric,
  non-hub interfaces), not a claim with an independent proof.
- **P-M55-3, ν(core-star₂) = ν(star₂) = 2**: "MET by derivation" per the close's own table — this is M54-T4's
  `ν ≤ 2` half (from the census) combined with M54-T3's `C = ∅ ⟹ ν ≥ 2`, not a new theorem; the direct
  enumeration that would confirm it exactly (the "ladder") could not run at 7,809 points (§ Incidents). Not
  filed as a separate entry.
- **The three-spindle star's `F`'s pairwise-disjoint claim (P-M55-5)** — MISSED (`F₃ ∩ F₁ = {29, 1753}` on the
  first pair tried), so the clean "star extends by derivation for `m ≥ 3`" reading needed the census fallback
  D6(a) already records; the object's `C = ∅` still held (by the two remaining asks the weaker derivation
  left), but `ν ∈ [2,3]` stayed undecided. A measured partial result, not a closing theorem; not filed
  separately.
- **T24 (the copy-side asymmetry)** is registered as an open question in the source, explicitly not answered;
  correctly left as a conjecture, not claimed as a theorem (see "Conjectures surfaced" below).

## Conjectures surfaced, not claimed

- **T24 — the F₂₄₇ pool's freed-critical-vertex asymmetry.** `plans/M55-absorption.md` §R4: "the asymmetry must
  come from the rotation's direction relative to the fabric's own ladder structure (T13)" — a hypothesis with no
  proof attempt in the material read; registered as open at the M55 close, no successor milestone in this
  batch's range revisits it. No stub found naming it as a live target (`rg -n "T24" plans/` returns only its
  own minting inside M55's file); a candidate for a fresh stub if the asymmetry is ever wanted, not minted here
  (outside this batch's mandate — reading and filing only).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M55-T1 | kernel (`Extends`, `Extends.forces_iff`, `Extends.separated_iff`, `Extends.not_forces_of_colorable`, `Extends.not_separated_of_colorable`) |
| M55-T2 | kernel (`extends_of_hubs`, `extends_of_hub_matching`, `extends_of_matching`) — G40's cited target |
| M55-T3 | kernel (`extends_of_repaint`) — not the spare-colour lemma's home; see cross-batch note |
| M55-T4 | kernel (`extends_of_extensionOrder`, the general iterated form; `extends_compl_singleton_of_degree_le` its one-vertex instance) |
| M55-T5 | kernel (`symCopy`, `symCopy.coloringOfPerm`, `extends_symCopy`) |
| M55-T6 | declined — ad hoc field computation, no Lean consumer |
| D6(a),(b),(d) (no id) | not applicable — readings/measurements, not filed in § B |
| M55-T7 | declined — tools grade only |
