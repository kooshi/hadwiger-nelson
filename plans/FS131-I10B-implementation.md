# FS-131, wave 10 — implementation record: the stationary ratio

*Job FS131-I10B (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10b` (from the planner's `f919973e`). Brief:
`data/fs131/briefs/FS131-I10B-wave10.md` (on `main`). Plan: `plans/FS131-w10-kernel-plan.md` §§ 2, 3, 5.3, 5.5.*

**What I may change, and what I may not.** Mine: the proof of each of the three open leaves of
`Proofs/HadwigerNelson/Arith/StationaryRatio.lean` (`StationarySet.prob_le_ratio_mul`, `ratio_prod_le`, `ratio_prod_le_iSup_levels`); new helper
declarations in that file, under names no other module declares (all in the namespace `HadwigerNelson.StationaryRatio`, which only this module
opens); Mathlib imports the helpers need; a block "FS131-I10B" in `scripts/Axioms.lean`; this record; `tools/fs131_i10b_*.py`; `data/fs131/i10b/`;
the report. Not mine: any statement, hypothesis, conclusion, docstring or definition of the skeleton (a leaf that is false or too weak as stated goes
to Keryx by message); a new `axiom`; `native_decide`; the wave's other files (`SpectralInputs`, `CharacterColouring`, `StandingFive`); any landed
module; `main`; the gate; another branch.

## Theorems this phase proved

*(Filled as the stages land; see the stages below for the evidence of each.)*

## Stage 1 — SAVED (FS131-I10B): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -cF` of each quoted string in the file the brief names: `data/fs131/i10b/quotations.sh`, log
`data/fs131/i10b/logs/quotations.txt`: **eight of eight match** (`CLAUDE.md` § Counter-priors; inventory items 484, 485, 477, 478, 493 in
`plans/FS131-close-inventory.md`, read on `main`, where they are filed; the plan's §§ 5.3 and 5.5 headings in this worktree). The script's control (a
quotation altered by one word) reads 0 matches.

**Read**: the brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate fail; the planner's record
(`plans/FS131-w10-kernel-plan.md`) whole; `Proofs/HadwigerNelson/Arith/StationaryRatio.lean` whole (it imports Mathlib only, so its foundation is its
own five definitions); the derivation `plans/FS100-X25B-derivation.md` whole, its § Stage 2 (X25B-P l. 50–55, X25B-PZ l. 57–70, X25B-L1 l. 72–79)
against each leaf; inventory items 484–485 and 493–494 in full; the first implementer's record (`plans/FS131-I10A-implementation.md` on `fs131-w10`).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in this worktree, exit 0, 9 m 15 s
(`data/fs131/i10b/logs/build-0-as-given.log`). **What it rebuilt**: five modules — `Arith.StationaryRatio`, `Arith.StandingFive`,
`Arith.SpectralInputs`, `Arith.CharacterColouring` (the wave's four, absent from the copied build) and `Proofs`. Warnings: 21, every one
`declaration uses 'sorry'`: `CharacterColouring` 1, `SpectralInputs` 8, `StandingFive` 9, `StationaryRatio` 3 (lines 100, 107, 121) — the 21 leaves
the planner reported.

**The statement check** is `tools/fs131_i10b_statements.py <base> <files>`, two checks of the working file against the base commit's: (A) every
base declaration appears verbatim, exactly once — a theorem from its keyword to the first ` :=`, *followed by* ` :=` (so nothing can be appended to a
conclusion), anything else whole, docstrings included; (B) the base's lines, `sorry` lines dropped, are a subsequence of the working file's lines
(imports, the module docstring, the spec examples). `--self-test` plants five faults and each fires: one character of a statement changed; a
conclusion widened by an appended disjunct; a definition's last line dropped; a docstring edited; a spec example removed. On the file as given:
PASS, 11 base declarations and 140 base lines.

**The planner's question for the first pass** (its § 2.2 item 8: "the widening is read off the derivation, not yet off a proof"), answered on paper
before any Lean, each leaf read against the derivation's proof:

- **The statement the three proofs derive from.** A.e.-independence is `∀ᵐ t ∂ν, ∀ᵐ ω ∂P, ω ∈ B → T t ω ∉ B` (Tonelli on the definition's product
  set), and every step of the derivation is one of four moves on such statements: shift the sample point (a measure-preserving `T h` with inverse
  `T (−h)`), reflect `ν` (its symmetry), exchange "for almost every shift" with "almost surely" (Tonelli; the event "`κ`-positively many shifts
  land in `D`" is where it is read), and change the event on the same system. No Haar measure on `G` is read: **the widening holds**, for X25B-P and
  X25B-PZ at measurable groups with σ-finite symmetric `ν`.
- **X25B-L1**: the pigeonhole of the plan's finding 8 goes through as stated there — two events of share above `1/2` under one probability meet,
  and a common parameter is an edge — with no integral bound; "martingale convergence on the fibres" is replaced by continuity at `0` of
  `u ↦ P(T_u⁻¹B ∆ B)`, which by stationarity is the mean over `ω` of `m((u + A_ω) ∆ A_ω)`, `A_ω = {v : T_v ω ∈ B}`, so it follows from Mathlib's
  continuity of translation in measure (`tendsto_measure_symmDiff_preimage_nhds_zero`) and dominated convergence — no bump functions and no density
  argument in `L¹(P)`.
- **Hypotheses the paper proofs do not read** (confirmed by the linter at Stage 2–3): `MeasurableAdd₂` in X25B-P; in X25B-L1, that `K` is
  antitone (one level inside a small neighbourhood of `0` is enough), `SigmaFinite ν_X`, `MeasurableAdd₂ X`, `T2Space Y`.

## Stage 2 — SAVED (FS131-I10B): group 1 — X25B-P (`prob_le_ratio_mul`) and X25B-PZ (`ratio_prod_le`)

**The statement the proofs derive from** (`debruijn`'s loop: found before the first tactic, on paper): a.e.-independence of the event `C` in a
system is `∀ᵐ t ∂ν, ∀ᵐ ω ∂P, ω ∈ C → T t ω ∉ C` (`StationarySet.aeIndependent_iff`, by `measure_prod_null`). On statements of that shape the
derivation's steps are four lemmas, and each case of X25B-PZ's step (3) is two or three lines over them:

- `ae_T_iff` — a property holds almost surely after a shift iff it holds almost surely (`T h` preserves `P`, with inverse `T (−h)`);
- `ae_neg_iff` — a symmetric `ν` sees a property and its reflection alike;
- `ae_nb_iff` — **Tonelli**: with `nb κ e D = {ω | κ{z | T (e z) ω ∈ D} > 0}` (the skeleton's `nbhd ν` is `nb ν Neg.neg B`, by `rfl`),
  `(∀ᵐ ω, ω ∈ C → ω ∉ nb κ e D) ↔ ∀ᵐ z ∂κ, ∀ᵐ ω, ω ∈ C → T (e z) ω ∉ D` — Mathlib's `Measure.ae_ae_comm` on one measurable set;
- `pull` (the same sample space, the action restricted along a homomorphism, another event) and `couple` (the independent coupling) — the two
  ways a new `StationarySet` is made; `AEIndependent` and `nbhd` of either unfold by `rfl` to statements about the old system.

**X25B-P.** `N(A)` is `nb ν Neg.neg A`. Tonelli gives, for almost every `t`: off `N(A)` no reflected shift lands in `A` (F1); by symmetry no
shift does (F2); shifting the sample point, a point of `A` is shifted into `N(A)` (F3). For a competitor `S`, the event
`(S ∖ N[A]) ∪ A` of `S.couple W` is a.e.-independent: the four cases are `tauto` over F2, F3 and the two independences lifted to the product by
`quasiMeasurePreserving_fst/snd`. Its mass is `P(S)·P(N[A]ᶜ) + P(A)` (`prod_prod`). The supremum over `S` is taken in `ℝ≥0∞` by `ratio_mul_le`
(`ENNReal.iSup_mul`), with `ratio ≤ 1` for the cancellation — no `ε`.

**X25B-PZ** (`StationarySet.prob_le_max_ratio`, then the supremum). `N = nb ν_H (t ↦ (0, −t)) B`, `Y = B ∖ N`, `A = B ∩ N`. One fact carries
(2) and three of (3)'s four cases: **G3**, for almost every `s`, almost surely `T (s, 0) ω ∈ B → ω ∉ N` (an `H`-neighbour of `ω` in the set would
be joined to the shift by the edge `(s, t)`): `ae_nb_iff` at `C = T (s, 0)⁻¹ B`, then `ae_T_iff` at `(0, −t)`. With G2 (off `N` no `H`-shift lands
in `B`): `Y` is `H`-independent, `A` is `G`-independent, and the closed neighbourhoods `Y ∪ N_H(Y)`, `A ∪ N_G(A)` meet in a null event — the cases
`A ∩ Y = ∅`; `B ∩ N_H(Y)` null (G2 shifted); `N_G(A) ∩ B` null (G3 shifted); `N_G(B) ∩ N` null (G3 and the symmetry of `ν_G` — the derivation's
fourth case uses the symmetry of `ν_H`; either serves). Then X25B-P in each factor through `pull` along `inl`, `inr`, and `measure_union₀`.
**The plan's `null_of_edges`** (one lemma to which each case reduces by one translation) is `ae_nb_iff` with `ae_T_iff`.

**Evidence.** Build: `data/fs131/i10b/logs/build-1-group1.log` — exit 0, 451 batches, 2 modules rebuilt (`Arith.StationaryRatio` 3.8 s, `Proofs`),
8 m 12 s; `StationaryRatio`'s one warning is the open leaf (`declaration uses 'sorry'`, line 454, `ratio_prod_le_iSup_levels`); no warning other
than `sorry` in the run. Axioms: `data/fs131/i10b/axioms-group1.lean`, log `data/fs131/i10b/logs/axioms-group1.log` — 26 records: 25 on a subset of
`[propext, Classical.choice, Quot.sound]`, and the control (`ratio_prod_le_iSup_levels`, open at this stage) prints `sorryAx`. Statements:
`tools/fs131_i10b_statements.py f919973e` — PASS (11 base declarations, 140 base lines; the five faults fire). `scripts/Axioms.lean`: block
"FS131-I10B" above the PURCHASED banner, 24 records (the audit itself is the landing's).

**The unused-arguments linter, with its control** (on a scratch copy of the file with `#lint` appended; iteration only): 0 errors in 59
declarations as committed; with the five consuming `have _ := …` lines removed it reports exactly `prob_le_ratio_mul`: `[MeasurableAdd₂ G]`, and
`ratio_prod_le_iSup_levels`: `[MeasurableAdd₂ X]`, `[T2Space Y]`, `[SigmaFinite νX]`, `(hK : Antitone K)`
(`data/fs131/i10b/logs/lint-control.txt`). Those are the statement's arguments the proofs do not read (§ Findings); each is consumed by a `have`
with a comment at the line, the statements unchanged.

**Re-priced from these two leaves** (the brief's ask). The plan: 1,100 lines for the two (400 + 700), and 800 for the third; 350k harness tokens for
the file. Written: about 330 lines for the two with their toolkit (toolkit 130, X25B-P 65, X25B-PZ 135), four elaboration rounds on a scratch copy
(the file imports Mathlib only, so a round is 4 s), one build. At that rate the third leaf is about 250 lines, and the job stays well inside the
brief's guidance. **Why the plan was high by three**: it priced the derivation's sets and integrals; in the almost-sure normal form there is no
integral in X25B-P or X25B-PZ at all — Tonelli is used once, inside `ae_nb_iff`.
