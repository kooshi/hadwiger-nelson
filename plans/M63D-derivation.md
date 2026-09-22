# M63 phase D — the derivation file: theorems from the loop plan (FS-71 batch 4b)

*Filed 2026-09-23 by the batch-4b implementer (FS-71, the theorem audit). Home for theorems proved in
`plans/M63-phaseD-the-loop.md` (the expansion loop and its obligation-modelling pass); `plans/
M63-phaseD-close-audit.md` is an audit of phase D against its own plan and proved nothing new (see the batch
report). No ledger row of M63's own covers phase D. Ids `M63D-T1`…*

## The theorems

**M63D-T1 — The expansion loop has no measure, and its improving steps are bounded even so. [hand; the
phase-D implementer, 2026-09-11]** `A ↦ ⋃{M}(A ∪ Δ)` is not monotone in `A` (M64's overcompression finding —
the minimal asymmetric refuser is usually not a subgraph of the minimal symmetric one — is exactly a witness
of non-monotonicity), so the fixed-point iteration has no Knaster–Tarski measure: `|W|` is unbounded above
(expansion only adds vertices) and `|M|` is not monotone either (`{M}` grows and shrinks as `W` changes).
**But** the loop only ever accepts an *improving* incumbent, so at a fixed rung the sequence of accepted
minima is strictly decreasing in the positive integers, bounded below by `[Parts2020a]`'s own published
`v5 ≥ 28`; hence a run starting at 375 can improve **at most 347 times**. *Proof:* the non-monotonicity claim
is `plans/M63-phaseD-the-loop.md` §O1, citing M64 §R5's overcompression result (`M64-T1`/`T2`, already filed,
FS-71 batch 4a); the bound on improvements is immediate from strict decrease plus the stated lower bound.
*Proof verdict:* closes. *Rests on it:* the design choice to run the loop on a stall budget and verdict
rather than a termination measure (§O0's "prove/test/assume" partition; the per-iteration report of
`(|M|, |{M}|, |A|)`). *Prior art:* the non-monotonicity is this project's own finding (via `M64-T1`); bounding
improving steps by a known floor is elementary. *Kernel:* declined — bounds a specific search loop's step
count, not a statement about `F²`.

**M63D-T2 — Expansion cannot make the minimum worse, at a fixed rung, companion and cross-law. [hand; the
phase-D implementer, 2026-09-11]** Let `W' = W ∪ Δ` with the same companion `C`, the same rung (subgroup)
`H`, and the same cross-edge law. Then `w*(W') ≤ w*(W)`, and every minimum of `W` is still feasible in `W'`.
*Proof:* let `S` be a selection of `W`'s atoms with `R_W(S)`. The atoms of `W` remain atoms of `W'` (`H`
acts on the enlarged deletable set; old orbits are unchanged and `Δ` contributes new ones), so `S` is a
selection of `W'`; and `W'[S ∪ fixed] ∪ C = W[S ∪ fixed] ∪ C` as graphs, since `Δ`'s vertices are not in `S`
and so are not induced, so `R_{W'}(S)` holds at the same weight. `plans/M63-phaseD-the-loop.md` §O2. This is
control d6.6's soundness proof (a map entry reporting a larger `|M|` than the unexpanded level is a bug, not
a finding). **The three hypotheses are each load-bearing** (checked by deletion, per G30's audit discipline):
*same rung* fails without proof — a rung is a subgroup of `Aut(A)`, which itself changes as `A` grows (the L
side reads 375 at rung 1 and 376 at three of its rung-2 involutions), so raising the rung can strictly raise
the minimum (`M64-T2`'s subgroup-lattice monotonicity is the general mechanism); *same companion* and *same
cross-law* are each a different key property if varied. This is the general form of the earlier, weaker
statement `M63-T2` (which has no rung hypothesis because the small-half probe never varies the rung); phase
F's whole union-ladder programme (`plans/M63-phaseF-beat-509.md` §1.2) is built directly on this theorem,
citing it verbatim, and restricts every run to rung 1 specifically because it is the only rung immune to
expansion. *Proof verdict:* closes. *Rests on it:* `M63D-T7`; phase F's entire schedule; the corollary "a
single run over `A ∪ U` that closes proves no subset of `U` reaches the target" that phase F's ladder is
built from. *Prior art:* ours, specific to this rung-parametrised search; see `M63-T2`'s entry for the
elementary graph-theoretic fact underneath. *Kernel:* declined — object-specific, and generalises `M63-T2`
with a hypothesis (`M63-T2` is a special case at the trivial rung).

**M63D-T3 — A target ask preserves completeness on success and yields a one-sided bound on failure. [hand;
the phase-D implementer, 2026-09-11]** Asking `reduce_stage` at a target `t` (is there a refusing selection
of weight `≤ t`?) is sound in both outcomes. *Success:* the search returns `w* ≤ t` and enumerates the level
at `w*`; the target removed only candidates of weight `> t ≥ w*`, so `M63-T1`'s completeness invariant is
untouched and `{M}` is complete at `w*` (the pruning is beat-the-incumbent pruning, independently sound).
*Failure:* the MaxSAT lower bound over the harvested `Y` exceeds `t`; since `Y ⊆ Y*` gives
`mhs(Y) ≤ mhs(Y*)`, this proves `w* > t` and nothing else — no level, no `A`, no upper bound. *Proof:* `plans/
M63-phaseD-the-loop.md` §O3. **The step named as easy to get wrong:** a failure is only a failure if no ask
came back `unknown`; an undecided ask yields verdict `unknown-at-target`, and "no improvement exists" may not
be asserted — so a record produced under a target must never render with the word *minimum*. *Proof verdict:*
closes. *Rests on it:* every "target-mode" run in phase D and phase F (all of phase F's ladder rungs; §1.3 of
`plans/M63-phaseF-beat-509.md` cites this by name); the cost-saving claim of §R3.2 (the target's saving is
exactly the level enumeration it skips, a corollary of this soundness argument rather than a separate
theorem). *Prior art:* ours, specific to this search shape; branch-and-bound with a target/incumbent cutoff
is standard optimisation practice (not separately searched — the mechanism is elementary once `M63-T1`'s
sandwich is in hand). *Kernel:* declined.

**M63D-T4 — Upward closure survives moving the atoms from vertices to edges, with the vertex-count identity lost. [hand; the phase-D implementer, 2026-09-11]** For a fixed vertex set `V` and companion `C`, the
predicate `R_E(S) := (V, S) ∪ C` refuses four colours (`S` ranging over edge subsets `⊆ E`) is upward closed
in `S`. *Proof:* if `S ⊆ S'` and `R_E(S)` holds, a proper four-colouring of `(V, S') ∪ C` is in particular
proper on `(V, S) ∪ C` (every edge of `S ⊆ S'` is respected), so `(V, S')` colourable would force `(V, S)`
colourable, contradicting `R_E(S)`. `plans/M63-phaseD-the-loop.md` §O4. So `M63-T1`'s whole machinery (MCS/MUS
duality, the completeness invariant, the sandwich) carries verbatim with edges as atoms and a singleton
correction set read as a critical edge: **the minimum hitting set over edge atoms is the exact edge
minimum.** **Three things that do not carry, named as soundness obligations rather than details:** (1)
`|M| = w* + 1`'s "+1" is a vertex-side identity (the shared centre is the reduced part's one fixed deletable
vertex) — the edge objective has no such offset; (2) a solver symmetry-break pin must lie in `fixed` and
remain pairwise-adjacent in the graph being asked, or an edge-deletion run can silently return `unsat` for a
colourable graph (the same hazard phase C met on the vertex side, `pin_is_sound`); (3) a unit-distance graph
requires every edge to be a unit pair, never that every unit pair be an edge, so a refusing edge-subgraph on
the same points is still a valid unit-distance witness — the convention `[deGreyParts2023]`'s own footnote 2
already uses when discarding 36 edges. *Proof verdict:* closes. *Rests on it:* the whole edge-minimisation
sweep of phase D §R3.7/§R3.15 and the 2,279-edge object of `plans/M63-SESSION-HANDOFF-2026-09-11.md` §4.
*Prior art:* ours; the underlying fact is `M63-T2`'s (an induced subgraph of a colourable graph is
colourable) read on the edge lattice instead of the vertex lattice. *Kernel:* declined.

**M63D-T5 — A capped level makes every downstream necessity-based statistic over-report. [hand; the phase-D
implementer, 2026-09-11]** If `{M}_capped ⊊ {M}` (the level enumeration was halted before exhaustion), then
`necessary({M}_capped) ⊇ necessary({M})`, generally strictly. *Proof:* `necessary` is the intersection of the
level's members; intersecting over fewer sets can only grow the intersection. `plans/
M63-phaseD-the-loop.md` §O5. The bound itself survives a cap (the hitting set over `Y ⊆ Y*` is still a
lower bound; a verified selection is still an upper bound) — what dies is everything computed from `{M}` as
a *complete* object: the look-ahead proxy's necessity counts, `A_capped ⊆ A`, exchange classes, the affine
hull (M64 §0(ix)'s machinery, which assumes a complete level by hypothesis). *Proof verdict:* closes. *Rests on it:* the ruling that a capped level halts the loop and is reported as an incomplete cap, never silently
absorbed into the map (§3.3's design; §D.7 of the close-audit records that the outcome map was therefore
repurposed as an answer rather than a scoring surface). *Prior art:* ours; elementary set theory (monotonicity
of intersection under a growing index set), stated because the direction of the resulting bias (over-report,
never under-report) is the actual finding. *Kernel:* declined.

**M63D-T6 — A free degree floor on the edge minimum of any refusing subgraph on the record's vertex set.
[hand; Poros, 2026-09-11, credited; the centre caveat and the 1,016/1,018 split are the phase-D implementer's]**
Let `G` be `[Parts2020a]`'s 509-vertex record and `H ⊆ G` any refusing subgraph on the same vertex set. Then
every vertex `v` critical in `G` (meaning `G − v` is four-colourable) has `deg_H(v) ≥ 4`. *Proof:* if
`deg_H(v) ≤ 3`, at most three colours are forbidden at `v` in any four-colouring of `H − v` (which is
four-colourable since `H − v ⊆ G − v` and `G − v` is), so a fourth colour is free and the colouring extends
to `v`, contradicting that `H` refuses. `plans/M63-phaseD-the-loop.md` §O6. Phase C's own C4.1 established
all 508 non-centre atoms of the record are critical, but **the shared centre is never an atom and its
criticality was not among what C4.1 proved** — so, rigorously and without assuming the centre's criticality,
`2·e(H) = Σ_v deg_H(v) ≥ 508 × 4 + deg_H(centre) ≥ 2032`, giving **`e_min ≥ 1016`**, and `e_min ≥ 1018` once
one further colourable-ask control confirms the centre is itself critical. **What the floor is worth:** it
is far below the published `e5 ≤ 2406` and closes nothing about the true minimum, but it makes the sweep
self-checking — a returned object with a degree-3 non-centre vertex is a bug, and a reported edge count
below 1,016 is a failure rather than a record. *Proof verdict:* closes. *Rests on it:* every edge-minimisation
record's self-check described above. *Prior art:* ours; the underlying fact (a `k`-colourable graph minus a degree-`< k` vertex extends
its colouring) is elementary graph theory; zbMATH: `ab:"critical vertex" & ab:"minimum degree" & ab:"edge
count"` (0 hits). *Kernel:* declined.

**M63D-T7 — The full transfer lattice between a restricted and an unrestricted search over the same stage.
[hand; the phase-D implementer, credited also to the small-half probe and to Poros as independent
derivations agreeing, 2026-09-11]** For a restricted search (over a subset of atoms, or under a symmetry
rung) and the corresponding unrestricted search of the same stage: a **decided ask** transfers both ways,
verbatim (colourability of `S ∪ C` depends only on `S` and `C`); a **refusing selection** (an incumbent)
transfers upward only (`W'[S] ∪ C = W[S] ∪ C` when `S ⊆ atoms(W)`, the `M63D-T2` argument); **non-criticality**
transfers upward only (a superset of a refusing selection still refuses); **criticality** transfers downward
only (new material can substitute for an atom that was critical in the smaller stage); a **correction set**
transfers downward only (importing one upward can exclude a genuine record, since a selection could satisfy
it only through material the larger stage adds). *Proof:* case by case, `plans/M63-phaseD-the-loop.md` §R3.7,
matching `M63-T2`'s D1 (which established the refusing-selection and non-criticality rows independently, on
a different object) and Poros's own derivation of the same table. **This is what makes the secondary
question — "did `{M}` grow?" — cheap after a restricted primary search has run**: it inherits the whole
graph-level harvest (phase-1 census, correction sets) and discards only the search-level state (minima,
`w*`, the undecided list). *Proof verdict:* closes. *Rests on it:* card 20's "the secondary is a decision
that becomes an enumeration the moment it fires" and the `yes-but-level-truncated` verdict for a secondary
whose level did not close; the general statement is credited in the close-audit (§D.6 item 3) as "not
Parts-specific" — a reusable transfer table for any restricted/unrestricted pair of searches over one graph.
*Prior art:* ours; supersedes and extends `M63-T2` (adds the criticality and correction-set rows, and the
downward-only direction, that the earlier probe did not need). *Kernel:* declined.

## Readings and measurements that were called theorems

- **R3.2's "a derivation that was right and then incomplete"** (the target knob's cost saving, quantified as
  `old/(old+new)` per candidate) is a cost-engineering measurement refined from `M63D-T3`'s soundness proof,
  not a separate mathematical claim.
- **R3.4, "THE COMPANION FINDING"** — that `[Parts2020a]`'s companion graph is a per-row parameter of his own
  table rather than a fixed object, and changes as his loop runs — is a corrected *reading* of his published
  data (a finding about what his Table 1 means), not a theorem about the mathematics.
- **The 89-candidate outcome map and its density-zero result** (§R3.7/close-audit §D.7) are computed facts
  about one closed menu on one accumulator, reported honestly as an *answer* (single-orbit growth from
  `A412` closed) rather than a scoring surface, per the close-audit's correction — a measurement, not a
  theorem.

## Conjectures surfaced, not claimed

None beyond what the files state as open (whether a four-orbit combination — his own successful move — can
be found by any systematic search here; the close-audit records this as undone, not conjectured).

## Prior art re-attributed

None.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63D-T1 | declined — bounds one search loop's step count |
| M63D-T2 | declined — generalises `M63-T2`; object-specific |
| M63D-T3 | declined |
| M63D-T4 | declined |
| M63D-T5 | declined — elementary set theory, object-specific direction-of-bias finding |
| M63D-T6 | declined |
| M63D-T7 | declined — reusable but not a statement about `F²` |
