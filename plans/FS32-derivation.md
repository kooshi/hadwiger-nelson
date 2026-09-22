# FS-32 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Filed 2026-09-22/23 by the FS-71 batch-4a implementer (the theorem audit, `plans/FS71-theorem-audit.md`). FS-32 is
"the reduction stage as smallest group-MUS" (`plans/FS32-smus-reduction.md`, opened 2026-09-10, absorbed into M63
the same day per its own stub's banner). Its content is mostly *recognition* (the reduction stage is smallest
group-oriented MUS extraction, a solved problem in the SAT literature) plus one **priced negative** (row 62's §R3:
"reaching Parts's record by pure reduction is closed"), classified below as a measurement rather than a theorem —
and two small hand lemmas specific to this project's encoding. Enumeration: `plans/FS32-smus-reduction.md` read in
full (415 lines, §PA–§R3); cross-checked against `plans/M62-evolutionary-type-m.md` §R19–§R21 (named as this
file's own prerequisite reading) and `tools/parts_reduce.py`'s docstring (confirms FS-32's own duality argument was
independently re-derived one milestone later inside M63's reduction engine, in the same three-line shape — M63's
own territory, not re-filed here).*

## The theorems

**FS32-T1 — The correction-set duality for a monotone refusal predicate. [hand; the FS-32 implementer; prior art
Liffiton–Sakallah]** For an upward-closed refusal predicate `refutes` on subsets `S` of a vertex/group set (`S`
refutes iff `W[S] ∪ C` is not `k`-colourable, monotone since a colouring of a superset restricts to one of a
subset): **`refutes(S) ⟺ S` hits every minimal correction set** (a correction set `Cs` is a set with
`¬refutes(G ∖ Cs)`). *Proof:* `plans/FS32-smus-reduction.md` §M2, two lines each direction from monotonicity alone:
(⟸) if `S` misses a correction set `Cs` then `S ⊆ G ∖ Cs`, which is colourable, so by monotonicity `S` is too;
(⟹) if `S` refutes and `S ∩ Cs = ∅` then `S ⊆ G ∖ Cs` and monotonicity contradicts `Cs` being a correction set.
*Proof verdict:* closes. *Rests on it:* the whole hitting-set-dualization search architecture built this milestone
(`tools/gmus.py`, using `pysat`'s `OptUx`) and reused via `tools/hitset.py` (M49) for `μ`; M63's reduction engine
(`tools/parts_reduce.py`) independently re-derives the identical statement one milestone later, in the same words,
confirming it rather than superseding it. *Prior art:* this is the standard MUS/MCS hitting-set duality —
`[LiffitonSakallah2008]`, algorithmically `[IgnatievEtAl2015]` (CP 2015, tool `forqes`; both already held
"not read — named only" in `BIBLIOGRAPHY.md`, credited by FS-32's own §PA). The FS-32 implementer's own gate
explicitly records that no paper was found joining this duality to *critical subgraph extraction in graph
colouring* specifically — "a small observation, not a theorem" in the plan's own words, so nothing beyond the
proof-from-monotonicity is claimed as ours. zbMATH: `ab:"minimal unsatisfiable" & ab:"hitting set" & ab:"duality"`
(0), `ab:"correction set" & ab:"graph coloring" & ab:"critical subgraph"` (0). *Kernel:* declined — standard
SAT-literature fact, re-derived here for one application; not a target.

**FS32-T2 — The `L↔S` involution is an arena isometry. [hand; the FS-32 implementer]** Let `σ` be the Galois
automorphism `√3, √11 ↦ −√3, −√11` of `K` (one generator of Parts's order-24 group, identified as such in
`plans/M62-derivation.md` M62-T4) and `ρ = ρ₁₅` the type-M rotation. Since `ρρ̄ = 1` and `σ` is in the symmetry
group: **`ρσ(L ∪ ρS) = σS ∪ ρ(σL)`** — the arena built from `(L, S)` is isometric to the arena built from
`(σS, σL)`. Consequently `refutes(L ∪ ρS) ⟺ refutes(σS ∪ ρσL)` and the two selections have equal weight (`σ`
permutes each orbit to one of equal size). *Proof:* `plans/FS32-smus-reduction.md` §M1 decision 2 — direct algebra
from `ρρ̄=1` and `σ ∈ Aut(K/ℚ)` applied coordinatewise. *Proof verdict:* closes. *Rests on it:* the free
reproducibility control used through FS-32/M62 (any reported optimum's `τ`-image must have equal weight and must
also refute — a control, not yet exercised as an active 2× symmetry-breaking lever, per §M2's "control first, the
2× only if the run needs it"). *Prior art:* ours — a direct consequence of the field-theoretic form of the
cross-edge law and of Parts's group (M62-T4); not separately in the literature, no query run (the statement is too
specific to this construction to search for meaningfully). *Kernel:* declined.

## Readings and measurements that were called theorems, or that could be mistaken for them

- **Row 62's §R3 / the plan's own §R3 headline: "reaching Parts's record by pure reduction is closed"
  (`CLAUDE.md` § "Closed as directions" cites exactly this).** This is a **priced negative measurement**, not a
  theorem: the arena is 3,205 vertices and the record is 509, so pure reduction must shed 84% of the mass; an
  independent same-day measurement on a different base put joint drop capacity near 12%, and eight portfolio seeds
  here (weights 2,538–3,120 after ten minutes) are consistent with that ceiling. The verdict rests on
  `[Parts2020a]` §5.6 stating twice, in print, that his own method's reduction-only stage cannot reach a minimum
  (his method alternates reduction with *expansion*) — a piece of prior art the milestone leans on rather than a
  fact this milestone proved. Not filed to § B: it is a bound on an *engineering* quantity (how much weight a
  particular search algorithm can shed from a particular starting arena in measured time), not a mathematical
  claim about the record's true minimum.
- **§M2's soundness argument for the hitting-set loop** (why `w(S)` is a rigorous, non-decreasing lower bound at
  every iteration; the loop terminates because `|M|` strictly grows and is bounded by `2^m`; the exit condition
  and the optimality certificate coincide) — standard correctness reasoning for hitting-set/MUS algorithms
  (`[IgnatievEtAl2015]`'s own shape), restated here for this project's specific three-valued oracle (refutes /
  colourable / unknown-at-budget). Not separately novel; not filed.
- **§R1's planted-control finding** ("`OptUx` minimises weight, not group cardinality" — confirmed on a bed with a
  known hand answer) and **§R2's vertex-criticality census of Heule-510/553** (0 of 510 / 0 of 553 deletions
  refuse, both "vertex-critical, solver-only" — with a 2026-09-13 trust note that this is an uncertified solver
  finding, no LRAT, not committed under `data/`) — [tools] measurements, object-specific, not theorems.
- **§R2's retraction** ("two vertex-critical objects need not mean two constructions — they are the signature of
  two deletion orders that diverged," corrected by Kooshi from the implementer's first, wrong inference) — a
  methodological correction, not a theorem; recorded in the plan and kept rather than deleted, per this project's
  own demotion-record convention.
- **§B4/§R3's portfolio-spread measurement** ("23% weight spread from deletion order alone, eight seeds") — a
  [tools] measurement feeding the priced negative above, not a separate claim.

## Conjectures surfaced, not claimed

None beyond the priced negative discussed above, which is reported as a measurement rather than demoted from a
theorem (it was never claimed as one — the plan's own §R3 heading calls it "the verdict on pure reduction" and
frames it honestly as a negative about the frame rather than about the tools).

## Prior art re-attributed

None beyond what FS-32's own §PA already recorded correctly in `BIBLIOGRAPHY.md` (MUS/GMUS/SMUS, Liffiton–Sakallah
dualization, `[IgnatievEtAl2015]`'s `forqes` and its `pysat.examples.optux.OptUx` equivalent, QuickXplain — all
already marked "not held / named only", with FS-32's own §PA(c) explicitly crediting Kooshi for pointing out that
`~/source/descent-engine`'s `SubsetSolver` was already group-level MUS extraction, independently arrived at, before
the literature search ran).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS32-T1 | declined — standard SAT-literature fact, re-derived for one application |
| FS32-T2 | declined |
