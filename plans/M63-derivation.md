# M63 — the derivation file: theorems from the opening documents (FS-71 batch 4b)

*Filed 2026-09-23 by the batch-4b implementer (FS-71, the theorem audit). Home for theorems proved in M63's
three named "opening documents" — `plans/M63-incremental-hitset.md`, `plans/M63-parts-reproduction.md`,
`plans/M63-probe-S-expansion.md` — plus `plans/M63-kernel-certification-route.md` and
`plans/M63-SESSION-HANDOFF-2026-09-11.md`, neither of which proved anything of its own (see the batch report,
`data/fs71/batch-4b.md`, for what each of those two holds instead). Phase-specific theorems are filed
separately: `plans/M63C-derivation.md`, `plans/M63D-derivation.md`, `plans/M63G-derivation.md`. Ids
`M63-T1`… (bare milestone prefix, since these are not tied to one lettered phase). M63 has no ledger row of
its own for phases C–G and the opening documents (rows 64–65 are phases H2 and H3), so these entries are
found from the files alone, per the brief.*

## The theorems

**M63-T1 — The completeness invariant of the level-enumeration loop. [hand; the M63 planner, 2026-09-11]** Let
`Atoms` be a finite set, `R : 2^Atoms → Prop` upward closed (a *key property*, expressed as
`¬ Colorable(W[S ∪ fixed] ∪ C, 4)` for a fixed companion graph `C`), `w` a weight function, `w* = min{w(S) :
R(S)}`, and `Y ⊆ Y*` the family of minimal correction sets (complements of maximal `¬R`-sets) harvested so
far, with `mhs` the minimum-weight hitting-set functional. Maintaining `E` = the optima of weight `w*` found
so far, under the loop that (i) blocks a member of `E` only, never a fresh weight-`w*` set that already
satisfies `R`, and (ii) inserts into `Y` only a correction set verified by an actual colouring of its
complement: **`E` is exactly `{S : R(S), w(S) = w*}` when the loop halts (MaxSAT returns UNSAT over
`Y ∪ {blocked}`).** *Proof:* the invariant `E ⊆ {S : R(S), w(S) = w*}` is preserved every iteration (a
blocking clause removes only a member of `E`, already recorded; a new correction set removes only sets that
are not `R`-true, since it is derived from an actual colouring) and no unrecorded `R`-true weight-`w*` set is
ever removed; termination is the lexicographic measure `(#{S : w(S) = w*} − |E|, |Y*| − |Y|)`, each
component finite and each iteration strictly decreasing one of them; at halt no weight-`w*` set both hits
`Y` and avoids `E`, and every `R`-true weight-`w*` set hits `Y* ⊇ Y`, hence lies in `E`.
`plans/M63-parts-reproduction.md` §O(1). The companion "sandwich" half — `mhs(Y) ≤ mhs(Y*)` always, with
equality once a feasible `h` is found — is the same argument one level down (weight, not the level set) and
is proved in the same section. **The underlying MCS/MUS hitting-set duality this loop is built on
(`R(S) ⟺ S meets every minimal correction set`) is the theorem already filed as `FS32-T1`**
(`plans/FS32-derivation.md` T1, filed in FS-71 batch 4a from a later, independent re-derivation for the SMUS
reduction) — not re-filed here; M63-T1 is specifically the completeness invariant built on top of it, which
FS32-T1 does not state. *Proof verdict:* closes. *Rests on it:* the whole reproduction pipeline's optimality
claims (`|M| = 136`, `|M| = 374/375`, the joint-stage bound); `M63C-T3`; every "exhaustive-level" record in
`data/m62/`. *Prior art:* ours as a completeness argument for this specific loop shape; the general
MUS/MCS-hitting-set duality is standard (see `FS32-T1`'s entry: Liffiton–Sakallah, held); nearest held:
none — no dedicated paper on minimum-weight hitting set held; zbMATH: `ab:"minimum hitting set" &
ab:"correction set"` (0 hits), `ti:"MaxSAT" & ab:"lower bound" & ab:"correction set"` (0 hits). *Kernel:*
declined — a correctness argument about a Python search loop, not a statement about `F²`.

**M63-T2 — Expansion cannot raise, and cannot lose, a minimum. [hand; the phase-D-probe implementer,
2026-09-11]** Let `A ⊆ A' `be finite point sets sharing the same fixed companion and cross-edge law, and let
`R` be a key property expressed as non-4-colourability of `W[S ∪ fixed] ∪ C`. Then every minimum weight-`w*`
selection `S` of `A` is still a valid selection of `A'` with `R(S)` holding at the same weight, so
`w*(A') ≤ w*(A)`, and no run over `A'` can report a minimum above `w*(A)` or a level `{M}(A')` smaller than
`{M}(A)`'s image. *Proof:* whether a selection `S ⊆ A` refuses four colours depends only on `S` together
with the frozen companion, and on nothing else (the atoms of `A` remain atoms of `A'`, and
`A'[S ∪ fixed] ∪ C = A[S ∪ fixed] ∪ C` as graphs since the added points are not induced by `S`); `plans/
M63-probe-S-expansion.md` §5, "D1"; the identical statement is derived independently as `monotonicity_note`
in `data/m62/m63-trim-test.json` ("adding vertices can never raise w*… over-proposing can cost only time,
never correctness") and used, credited to this derivation, as phase D's `O2` (`M63D-T2`, which adds the
"same rung" hypothesis this general statement does not need) and as the load-bearing lemma of phase F's
whole union-ladder programme (`plans/M63-phaseF-beat-509.md` §1.2). *Proof verdict:* closes. *Rests on it:*
the small-half probe's three-state scoring (below 136 / grown level / inert); phase F's whole ladder design;
`M63D-T2`, `M63D-T7`. *Prior art:* ours as stated for this search shape; the underlying fact (an induced
subgraph of a `k`-colourable graph is `k`-colourable) is elementary graph theory, stated nowhere as a named
theorem in the held bibliography; zbMATH: `ab:"induced subgraph" & ab:"chromatic number" & ab:"monotone"`
(4 hits: Ramsey functions, Grundy/b-chromatic comparison on `K_{2,t}`-free graphs, `z`-chromatic number —
none is this fact). *Kernel:* declined — elementary and object-specific to the search's data structures; the
one-line graph-theoretic fact it rests on (`H ⊆ H' ⟹ Colorable H' k → Colorable H k`) is either already in
Mathlib's `SimpleGraph` API or a one-line consequence of `SimpleGraph.Coloring.comp`/induced-subgraph
machinery, not checked here.

**M63-T3 — Soundness of the incremental and decision MaxSAT hitting-set engines. [hand; the M63 implementer,
2026-09-11; law credited to Poros]** (i) *Incremental engine.* A core extracted from a MaxSAT instance is an
implicate of the hard clauses present at extraction; adding further hard clauses only strengthens the
formula, so a core extracted earlier remains a valid core (hence a valid lower-bound contribution) after
more correction sets are added — so accumulating cores and relaxations across iterations gives a monotone
non-decreasing sequence of valid lower bounds, and the loop halting with the oracle returning SAT at that
bound certifies optimality for the current formula. (ii) *Decision engine.* Since the correction-set family
`Y` only grows, the previous optimum `w*_{old}` remains a valid lower bound for the new family; asking "is
there a hitting set of weight ≤ `w*_{old}`?" and receiving SAT means the optimum is exactly `w*_{old}`. *Proof:*
`plans/M63-incremental-hitset.md` §3, "Soundness of the incremental engine" and the following paragraph.
Both are verified against `batch` (a from-scratch WCNF plus fresh RC2 solve every iteration) by an 18-control
self-test including two planted-fault controls (a correction set dropped that binds the bound, reddening
correctly; a redundant duplicate dropped, correctly reading identical) and by catching a real bug in the
decision engine's own first implementation (a variable-name collision silently disabling the cardinality
constraint, overstating the lower bound — the unsound direction — caught by the equivalence check within
minutes of the code being written). *Proof verdict:* closes. *Rests on it:* the "adopt, large win" recommendation
of §7 and the production integration of §7b–7c (D1b's and hismove's closed records, `|M| = 373` at level
26,724 and `HIS MOVE -> yes`). *Prior art:* ours as an argument for this specific pair of engines; incremental
SAT / core-guided MaxSAT with warm restarts is a large, well-known literature (RC2 itself, held only as a
tool, not a bibliography entry); zbMATH: `ti:"MaxSAT" & ab:"lower bound" & ab:"correction set"` (0 hits — the
query is aimed at the specific correction-set formulation, not at core-guided MaxSAT generally, which is not
this project's contribution). *Kernel:* declined — search-engine correctness, not a statement about `F²`.

## Readings and measurements that were called theorems

- **The domain-modelling pass's three "predictions"** (`plans/M63-parts-reproduction.md` §M, "Three
  predictions the model made before being consulted, all confirmed on his own files"): that Table 1's
  symmetry column is `|Stab(M)|`; that the accumulative graph is more symmetric than its minima; that
  canonicalization separates genuinely different minima and collapses group images. Each is a computed fact
  about `[Parts2020a]`'s published data, checked by one program run — a **measurement**, not a theorem: no
  general claim is stated or proved, only three specific numerical/structural facts about his four tables.
- **The reduction cost laws** (`plans/M63-incremental-hitset.md` §2: "enumeration wall-clock ~ c·w*·|E|²/2";
  the linear derivative measured at six prefixes; the 2.11e-5 s/2.5-day figures) — fitted, curve-validated
  empirical cost models of a Python search procedure, explicitly labelled measured throughout the source and
  scored against out-of-sample points; not theorems about the mathematics.
- **The "decisive experiment"** (`plans/M63-parts-reproduction.md` §R1) — a reproduction of
  `[Parts2020a]`'s published `v166e774 → v136e564` S-subgraph reduction from this project's own geometry,
  matching his Table 1 row exactly and recovering `|{M}| = 8` as his own convention once the symmetry group
  is named correctly. A measurement (agreement with a published table), never a theorem.
- **"THE BASE QUESTION IS ANSWERED: YES"** (`plans/M63-SESSION-HANDOFF-2026-09-11.md` §10) is an earlier,
  narrative-form record of the exact same finding filed formally as `M63G-T5` (§12.5–12.6 of
  `plans/M63-phaseG-bases-and-rotations.md`): a `K²`-point of squared norm `(7+√33)/3` realising a live
  radius sum for the new rotation, exhibited and checked. §6d/§6e of the same handoff file are the earliest
  record of the σ-criterion filed formally as `M63G-T4`. Not separately filed here — see `M63G-T4`, `M63G-T5`
  and their provenance notes.

## Conjectures surfaced, not claimed

None found in these files beyond what the ledger rows and grokkings already record as open (FS-35's
expansion look-ahead; the outer loop's absent termination measure, `plans/M63-parts-reproduction.md` §O(3),
which is a stated *fact* — no measure exists — not a conjecture).

## Prior art re-attributed

None. Every construction and law in these files traces to `[Parts2020a]` (already the held bibliography's
central primary source for M62–M64) or to this project's own instruments; no new external paper surfaced.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63-T1 | declined — search-loop correctness, not a statement about `F²` |
| M63-T2 | declined — the one graph fact it rests on may already be in Mathlib's `SimpleGraph` API (not checked); the search-specific statement is object-specific |
| M63-T3 | declined — search-engine correctness |
