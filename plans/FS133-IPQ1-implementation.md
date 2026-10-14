# FS133-IPQ1 — the density equality's last two leaves: `Plane/OneClass/Pair`, Q4 and Q5

*de Bruijn, the implementer; job FS133-IPQ1 (brief: `data/fs133/briefs/FS133-IPQ1-pairs.md`, on `main`). Branch
`fs133-wpq`, cut from `b84e09ef8` (FS133-ICD1's head, branch `fs133-wcd`) in the worktree `.claude/worktrees/fs133-wk1`.
The plan is `plans/FS133-kernel-plan.md` § 5.4 (lane D: Q4, Q5) with § 5.5; FS133-ICD1's record § 1.3 and § 4.5.
Working files: `data/fs133/ipq1/`. Files this job writes: `Plane/OneClass/Pair.lean` (proofs and private helpers
only), possibly a new module under `Plane/OneClass/` for the two new pieces, this record, the report.*

## Theorems this phase proved

(Filled at the build of record.)

## Stage 1 — SAVED: the readback, the leaves restated, the stored statements dumped before any edit

**1.1 The brief's quotations.** `tools/fs133_ipq1_readback.py` (FS133-ICD1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **4 matched, 0 mismatched**, exit 0
(`data/fs133/ipq1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-PAIR and K133-NC-PAIR
against `data/fs133/claims-K1.md`; inventory item 779 against `plans/FS131-close-inventory.md`. With `--fault` (the
last character of each quoted line changed): 0 matched, 4 mismatched, exit 1 (`readback-brief-fault.out`). No finding
about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the agent file's workflow; the plan's §§ 4.1, 5.0–5.5; FS133-ICD1's record whole; `Pair.lean` whole; the
derivation's entry C133-PAIR with § Argument and § Converse (`plans/FS133-E1-derivation.md` ll. 637–763, on `main`).

**1.3 Each leaf, in one line, beside the plan's route.** The file's text is the statement; the line is a reading.

| leaf | the statement, in one line | the plan's route (§ 5.4) |
|---|---|---|
| **Q4** `exists_measurable_admissibleAe` | for a finite `Λ` and an algebraic pattern `N`, a labelling admissible on `E` gives a labelling `ℓ'` of `ℂ` whose every fibre is Borel and which, at each `r`, has no forbidden pair at `(x, x + r e^{iθ})` for `(Leb ⊗ arc)`-almost every `(x, θ)` | `exists_invariant_of_closed` on the closed set of admissible labellings of `E`; `exists_field` at `ι := Λ` with the indicators of `{ℓ 0 = a}`; clause (c) at `z := r ∈ E`; Tonelli over the countable `(r, a, b)`; fix `ω`; the least `a` with `H a (x, ω) > 0` where the sum is `1` (the release's `positiveSelect`) |
| **Q5** `exists_admissibleOn_of_ae` | for a finite `Λ` and a pattern whose constrained distances are countable and positive, a labelling with null-measurable fibres admissible almost everywhere gives a labelling admissible at every pair of points of `ℂ` | density-point cores of the fibres; a two-set, radius-`r` density-point lemma; every finite set has a translate inside the conull union of the cores (`exists_translate_mem`); Rado selection (`Finset.rado_selection`) for the pattern |

**1.4 The stored statements before any edit.** The build as the last implementer left it: `lake build --no-build`
under the slot reads `All targets up-to-date (6048 jobs)`, exit 0 (`data/fs133/ipq1/nobuild-before.log`; it replays
`Pair`'s two `sorry` warnings, ll. 106 and 114). `data/fs133/ipq1/lean/StatementDump.lean` (FS133-ICD1's dumper, its
body unchanged, the module list all seven modules of `Plane/OneClass`) prints every named constant of the seven from
their compiled data, in the full print and the print with instance and proof arguments erased:
`data/fs133/ipq1/moved/before.out.xz` (sha256 in `before.sha256`) — **`SectionDensity` 9 named and 3 private, `Defs`
53 and 4, `InvariantLaw` 9 and 19, `Field` 1 and 30, `Algebraic` 9 and 1, `Fractional` 7 and 11, `Pair` 19 named and
0 private; 175 in all**; no `ABSENT`. This job edits only `Pair`; the other six are dumped to show them untouched.
