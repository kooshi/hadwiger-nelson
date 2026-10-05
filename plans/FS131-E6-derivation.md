# FS131-E6 — SHAVE's residual case (F6): a lone horn shaveable only at `σ = ±1`

*Job FS131-E6, Ephodos (Opus 5.5), 2026-10-05. Brief `data/fs131/briefs/FS131-E6-shave.md` with `plans/STANDING-RULES.md`; claim list
`data/fs131/claims-E6.md`. Working files `data/fs131/e6/`; tools `tools/fs131_e6_*.py`. Nothing in this milestone is fenced (inventory,
§ Rulings in force, ruling 1). Lean sources read on `main` (`a9342834`) and on `fs131-w5c` (`d3d38d3a`, IL1's tip at reading time).*

## Theorems this phase proved

*(filled at each stage; one line per theorem, its grade and address)*

## Stage 1 — SAVED: the readback, the question restated, the prediction registered

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| F6's opening clause "**F6 — a residual case of SHAVE (a question for the deriver; statement risk for `exists_terminalMap`).** `ShaveAvailable v` (wave 4's" | `.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md` l. 153 | verbatim |
| item 373's opening "**FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s" | `plans/FS131-close-inventory.md` l. 3269 | verbatim |
| item 374's opening "**Rulings on KL1's held items, and its slot.** (a) **The moves' new lemmas** are proved on wave 5's branch after it merges `main` (ruling 372 (a)): in a" | same file l. 3291 | verbatim |
| item 371's opening "**FS131-KL1 (the limit planner), by message: N4-TERM's count does not descend over `main`'s SHAVE as built; a clean step is owed; `exists_red` has a shorter" | same file l. 3239 | verbatim |
| the N4-SHAVE row | `plans/FS110-N-proof.md` l. 718 | verbatim |
| the N4-TERM row | `plans/FS110-N-proof.md` l. 723 | verbatim |
| the question Q and its *not claimed* line | `data/fs131/claims-E6.md` § The question | verbatim |
| the claim list's `ShaveAvailable` | `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 150–156 (`main`) | verbatim |
| the claim list's `exists_shave` | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1490–1502 (`main`) | verbatim |
| the claim list's `IsModification` | `fs131-w5c`'s `Plane/ValidMap/Chain.lean` l. 80–86 | verbatim |
| the claim list's `exists_terminal` | `fs131-w5c`'s `Plane/ValidMap/Terminal.lean` l. 3703–3720 | verbatim |

**One mismatch, a finding about the brief:** Done-means item 1 says "`horn_bounds_of_noMerge` on `main`". It is not on `main`
(`grep -rn horn_bounds Proofs/` on `main`: no hit; `main` has no `Plane/ValidMap/FlankUA.lean`). It is on `fs131-w5c` (and `fs131-w5`),
`Plane/ValidMap/FlankUA.lean` l. 722–740. I read it there. Its proof uses `2 ≤ m` only to turn `¬ MergeAvailable v` into
`interior (F.allowedCone v c) = ∅`; the bound itself comes from `woodallCone` (`main`, `Plane/ValidMap/Cone.lean` l. 1427–1435), which
needs no sector count. This matters below (§ 2.2).

### 1.2 Read for this job

`plans/FS110-N-proof.md` § Continuation — FS110-N4 (all of it: N4-SHADOW, N4-FLANK, N4-SHAVE, N4-RAY, N4-STUCK, N4-PROP, N4-FIN, N4-TERM,
the verdict § 2.8 with its "partial remedy, sketch"); `plans/FS112-derivation.md` header and § 1 entries FS112-WALK through FS112-N2-TERM;
`plans/FS112-N-proof.md` § 1.3–1.4 (the walk table; row 7 is N4-SHAVE with FLANK and RAY); KL1's plan
(`fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`) §§ 2.1–2.4, 3.1, 3.3, 3.4; inventory items 371–377; `Basic.lean` l. 1–240 (frames,
`tanHeight`, `hornSet`, `IsClear`, sectors, `IsHorn`, flanks, contacts, `allowedCone`, the moves' preconditions, `Terminal`, `IsStuck`);
`Cone.lean`'s `contact_inType_or_outType`, `coneAt_subset_allowedCone`, `woodallCone`; `Contact.lean`'s `exists_rayMerge`, `exists_merge`;
`fs131-w5c`'s `Chain.lean` l. 1–90, `Procedure.lean` (whole), `Limit.lean`'s `LocalStep`, `IsClean`, `IsSite`, `Terminal.lean`'s
consumers of `Terminal` (every use, by grep: § 3); and, found on the way and bearing directly, `plans/FS110-derivation.md`'s FS110-N4-TERM,
FS110-NB4-CS, FS110-A6-C2 entries and `plans/FS110-NB4-verification.md` §§ 2.3, 2.8, 2.9 and § 4.1 (divergence D3: "count `Φ + #horns`
… then SHAVE on single horns and the opening remedy both join the moves").

### 1.3 The question, restated in my words (the claim list's statement governs)

Frame at `v`: `a = e α`, `n = e(α + π/2)`, `N = v + n`, `S′ = v − n`. A **lone horn** is a horn `IsHorn v α κ₁ κ₂ c` whose colour has one
sector at `v` (`HasSectors v c 1`). For it, `horn_bounds_of_noMerge` is silent, so `κ₁ < −1` or `κ₂ > 1` is possible. `ShaveAvailable v`
through it asks for one `σ ∈ [κ₁, κ₂]` with the horn's points strictly above the tangent circle `Σ_σ` clear for the upper flank `g` and the
rest clear for the lower flank `h`. The residual case F6: the only such `σ` is `1` (or `−1`) and `κ₁ < σ < κ₂`. Then `Σ_σ` is `ω(N)` (or
`ω(S′)`, `tanAbove_one_iff`, `tanAbove_neg_one_iff`), its trace inside the horn is a unit arc not in `F`'s `Γ`, and every shave creates it,
which `IsModification` (`RingArcsWithin`) forbids. Three outcomes are named: F6 cannot occur where the procedure meets it; F6 occurs (a
configuration exhibited exactly); or F6 occurs and the route does something else there.

### 1.4 Registered before the written derivation (G21; scored at the end of this job)

| id | prediction | probability | what it decides |
|---|---|---|---|
| E6-P1 | F6 occurs in a valid map: a valid plane map at some `k ≥ 7` (no valid six-map of the plane is known, FS-114) carries a lone horn with `ShaveAvailable` only at `σ = 1`, `κ₁ < 1 < κ₂`, checked exactly | 0.85 | whether the answer is "impossible" or "repair" |
| E6-P2 | F6 forces `interior (allowedCone v c) ≠ ∅` (the contrapositive of `woodallCone`) | 0.97 | whether the repair can be a move that needs a non-degenerate allowed cone |
| E6-P3 | FS110 § 2.8's sketched wedge-opening ("OPEN": recolour a thin wedge beside the horn, on the interior side of `D_c(v)`, with `c`) is valid at every lone horn with `int D_c(v) ≠ ∅`, with unit arcs allowed: no unit arc created, no colour added at `v`, degree not raised, one horn fewer | 0.85 | the repair's move |
| E6-P4 | at some F6 instance no local modification at `v` lowers `v`'s degree, so `exists_vertexStep`'s clause "`∃ m' < m, F'.HasDegree v m'`" is false there | 0.75 | whether `exists_vertexStep`'s statement must change |
| E6-P5 | `exists_terminal`'s statement, `exists_terminalMap`'s and `IsTerminalMap` need no change | 0.85 | whether a backlog statement must be re-read |

Both directions are named reachable: P1 failing means a derivation that F6 cannot occur (the answer the brief lists first); P5 failing means
a statement repair.

The question as an open entry (the loop's opening form; replaced by derived entries from stage 2 on):

derivation: e6-question
  statement: a valid map can have a vertex v with ShaveAvailable v through a lone horn whose only admissible split is σ = 1 (or −1) with κ₁ < σ < κ₂
  argument: § 1.3 The question, restated in my words (the claim list's statement governs)
  verdict: stalls at: stage 1 — nothing derived yet; the configuration and the route are stage 2's

## Stage 1 — SAVED
