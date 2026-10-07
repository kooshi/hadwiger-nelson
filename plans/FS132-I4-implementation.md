# FS132-I4 — the join: the ported outside lemmas under the exclusion's skeleton, and the leaves that stand on them

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I4-join.md` on `main` at `4bb0c8c4a`.
Branch `fs132-wi4`, cut from `fs132-wk1` at `1c5e2609a`; worktree `.claude/worktrees/fs132-wi4`. Working files:
`data/fs132/i4/`. The planner's record is `plans/FS132-kernel-plan.md` (not edited here); the port's is
`plans/FS132-I2-implementation.md` on branch `fs132-wi2` (not edited here).*

## Theorems this phase proved

*One line per kernel theorem, with its declaration and its axioms. Filled as the stages save; the axioms are printed
at the last stage from the built modules.*

(none yet — stage 1 is the readback)

## Stage 1 — SAVED (FS132-I4): the readback, and the branch built as given

**The quotations.** `data/fs132/i4/readback.py` reads every quotation of the brief (a run of `>` lines closed by a
`> — source:` line) and checks that its text, whitespace-normalized, occurs in the named source:
**21 quotations, 21 matched** (`data/fs132/i4/readback.out`, exit 0) — Kooshi's two, the fifteen first lines of the
leaves in `State`, `Excl`, `ChartMeasure`, `Kill`, the planner's four. Control: with one letter of the first quotation
changed (`--fault`) the run reads `matched=20 mismatched=1` and exits 1 (`readback-fault.out`). No finding about the brief.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the planner's record Stages 5–7 (§§ 5.1–5.4, 6.1–6.4, 7, 7.1); the port's record §§ 2.1, 3.1, 3.2, 3.4,
3.5, 3.6 and its drafts; the skeleton's `Basic`, `Placeholders`, `State`, `Excl`, `TwoPairs`, `ChartMeasure`, `Kill`,
`Chart`, `Shift`, `StepLemma`, `Orbit` (whole); the hand argument `plans/FS132-E3-derivation.md` Stage 3 (the entries,
M0–M9, the ring form, on `main`) and `plans/FS132-derivation.md` § 1 (on `main`).

**The branch as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`:
**exit 0**, "all 1860 modules already up to date, nothing built" (`data/fs132/i4/logs/build-0-as-given.out`); 71
`declaration uses sorry` warnings, by module: `Chart` 11, `ChartMeasure` 4, `CyclicCentre` 3, `Excl` 2, `Kill` 2,
`Placeholders` 3, `Shift` 7, `State` 8, `StepLemma` 8, `Tips` 7, `Winding` 16 — the planner's count (§ 7, "71").

**What this job's leaves are** (17 `sorry`s in four files, and the three placeholders the join removes):
`State` 8 (`measurableSet_liftPalette`, `OutsideOrbit.ae_iff_not`, `.ae_flip`, `.change_at`, `.chart_avoids`,
`exists_tip`, `.hubColours`, `.hubColours_flip`), `Excl` 2 (`exists_change_of_ae_outside`, `ae_real_of_ae_angles`),
`ChartMeasure` 4 (`chart_quasiMeasurePreserving`, `shear_quasiMeasurePreserving`, `ae_ne_of_not_isTip`,
`unitPair_chart_ae`), `Kill` 2 (`no_double_change`, `step_kill`). `TwoPairs` has none of its own.
