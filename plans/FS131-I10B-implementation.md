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
