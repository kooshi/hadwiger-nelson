# M63 phase C — the derivation file: theorems from the joint-stage plan (FS-71 batch 4b)

*Filed 2026-09-23 by the batch-4b implementer (FS-71, the theorem audit). Home for theorems proved in
`plans/M63-phaseC-joint-stage.md` (the joint test — both `[Parts2020a]` halves deletable at once). No ledger
row of M63's own covers phase C (rows 64–65 are phases H2/H3); these entries are found from the file alone.
Ids `M63C-T1`…*

## The theorems

**M63C-T1 — Exact resume of the joint-stage search reproduces one uninterrupted run. [hand; the phase-C
implementer, 2026-09-11]** Split a run's decided facts into *problem facts* (the 4-colourability verdicts on
the pin, on phase-1 candidates, on each correction set, and the recorded minima/`w*` — all determined by the
fixed finite graph alone) and *launch facts* (an undecided candidate or atom, and the search budgets — both
properties of a particular execution). **Claim:** a relaunch that (i) refuses unless the stage's identity and
problem hash match the checkpoint, (ii) restores every problem fact, (iii) returns every launch fact to the
open pool (undecided candidates unblocked, unknown phase-1 atoms re-asked), and (iv) continues, ends with the
same `(E, w*, method)` as one uninterrupted run under the union of the budgets. *Proof:* by (i) the search
space and weights agree; by (ii) and the fact/kind table, every restored fact is a fact about that space; the
level loop rebuilds its MaxSAT instance each iteration from `(Y, blocked)` with `blocked = E ∪ U`, and after
(iii) `U = ∅`, so the instance matches exactly what an uninterrupted run would hold, and
`M63-T1`'s ("M63 §O(1c)" in the source) preservation argument applies unchanged; termination is the same
lexicographic measure with `|U|` appended to the first component. `plans/M63-phaseC-joint-stage.md` §O2.
*What resume does not promise:* the correction sets harvested after the resume point (a fresh incremental
solver may return a different model for the same colourable ask) — the harvest order is a launch artifact,
never part of the claim. *Proof verdict:* closes. *Rests on it:* every resumed record in `data/m62/` whose
launch history spans more than one process (D1b, hismove, the joint runs). *Prior art:* ours, specific to
this checkpoint design; SAT-solver checkpoint/resume correctness is engineering practice, not typically a
named theorem; nearest held: none; zbMATH: `ab:"resume" & ab:"checkpoint" & ab:"SAT solver"` (0 hits).
*Kernel:* declined — a correctness statement about a Python checkpoint format.

**M63C-T2 — Joint problems in one double coset are isomorphic. [hand; the phase-C implementer, 2026-09-11]**
For a rotation `h` placing the small half `ρ·h·S` against the frozen large half `L`, if `h' = a·h·b` with
`a ∈ Stab(W_L)` and `b ∈ Stab(W_S)`, the joint problems `(W_L, h·W_S)` and `(W_L, h'·W_S)` are isomorphic by a
weight-preserving bijection of selections, hence share the same minimum and (up to the bijection) the same
level sets. *Proof:* applying `a` diagonally to both halves is an automorphism of the arena (it preserves
unit distance and both polynomial conditions of the cross-edge law over `K`, by M62 §R19(1), kernel-adjacent
but not itself checked here), fixes `W_L` since `a ∈ Stab(W_L)`, and sends `h·W_S` to
`a·h·W_S = h'·b⁻¹·W_S = h'·W_S`; the bijection carries selections and their weights across, and `R` is
preserved. `plans/M63-phaseC-joint-stage.md` §O4. **The converse is explicitly not claimed**: two different
double cosets may still give isomorphic problems, so the file's own honest reading is "at most two
inequivalent joint problems" for the rotations considered, not "there are two". *Proof verdict:* closes.
*Rests on it:* the reduction of the census's rotation classes to a bounded number of joint-problem instances
worth solving; a symmetry-breaking argument phase G's census reuses in spirit for its own class-key
questions (§11.6, not separately filed). *Prior art:* ours, specific to this construction; double-coset
symmetry reduction is standard in group-invariant search (symmetric integer programming, already the
prior-art frame for row 62's orbit-closure theorem via `[HerrRehnSchurmann2013]`, held — not re-searched
here since the mechanism is the same family); zbMATH: `ab:"symmetry breaking" & ab:"orbit" & ab:"double
coset"` (1 hit, "Symmetry breaking for representations of rank one orthogonal groups" — a different setting,
representation theory rather than combinatorial search). *Kernel:* declined — group-action bookkeeping over
a specific finite object.

**M63C-T3 — The joint positive control's answer, given his published minimality. [hand; the phase-C
implementer, 2026-09-11]** Over `W = L374 ∪ ρ·S136` with both halves independently deletable, if `374` is the
true minimum of `L`-selections against the frozen `S136` and `136` is the true minimum of `S`-selections
against the frozen `L374` (both `[Parts2020a]`'s own published minimality claims), then the only refusing
selection of `W` is the whole of it: the minimum is **508 atoms (509 vertices), with exactly one minimum**.
*Proof:* let `(L', S') ⊆ (L374, S136)` refuse four colours. By upward closure `(L', S136)` refuses, so
`|L'| ≥ 374` by the minimality of 374 against `S136`; and `(L374, S')` refuses, so `|S'| ≥ 136` by the
minimality of 136 against `L374`. Hence `L' = L374` and `S' = S136`. `plans/M63-phaseC-joint-stage.md` §O9.
This discharges, as a corollary, the previously-unchecked control that every single-vertex deletion of the
509-vertex record is colourable (`M63-parts-reproduction.md` §4 phase B). **Confirmed by the running search**
(`plans/M63-parts-reproduction.md` §R2.2: exactly one minimum, `exhaustive-level`, phase-1 census 508
critical / 0 droppable / 0 unknown, 58 s) — the control fired exactly as the theorem predicted, which is
itself evidence for `[Parts2020a]`'s minimality claims rather than merely for this project's tooling. *Proof verdict:* closes. *Rests on it:* the honesty of every later joint-stage bound (§R2.2b: "no joint selection of
503 atoms or fewer refuses four colours"); the record's status as the calibration bed for phase D's
verification chain. *Prior art:* ours; the minimality inputs are `[Parts2020a]`'s (held, §PA of the
milestone's own gate). *Kernel:* declined — a one-off numerical corollary of `M63-T2`'s upward closure
applied to two specific published numbers, not a general statement.

## Readings and measurements that were called theorems

- **O1 ("Monotonicity survives the joint stage")** restates `M63-T2`'s upward-closure argument for the
  two-sided (both halves deletable) case and observes that the proof "never mentions which vertices are
  deletable" — an instance, not a new theorem.
- **O5 ("A group element is named by its image of a free point")** — `g ↦ g·x` is injective on `G` when
  `Stab(x)` is trivial, by `g·x = g'·x ⟹ g'⁻¹g ∈ Stab(x) = {1}`. Elementary group theory (a one-line fact),
  used as a naming convention for the census; not filed as a theorem in its own right.
- **The joint-stage census's numerical findings** (423 forced atoms of 576, 153 free; the two runs' shared
  phase-1 census) are computed facts about a specific finite graph, reported in `plans/
  M63-parts-reproduction.md` §R2, not general claims.

## Conjectures surfaced, not claimed

None beyond what the file itself states as open (the census of joint-problem double cosets beyond the
rotations already checked, §O4's "at most two inequivalent problems" left unresolved into "exactly two").

## Prior art re-attributed

None.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63C-T1 | declined — checkpoint-format correctness |
| M63C-T2 | declined — group-action bookkeeping over one finite object |
| M63C-T3 | declined — numerical corollary of `M63-T2`, not a general statement |
