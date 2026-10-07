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

## Stage 2 — SAVED (FS132-I4): the join

**The merge.** `git merge --no-ff fs132-wi2` (tip `4060fe1d6`) into `fs132-wi4`: **automatic, no conflict** — merge
commit `466d0fa1d`. Both sides had added lines to `Proofs.lean` and to `ARCHITECTURE.md` § 3; git kept both (the eight
`Outside.OAI158…` imports beside the twelve `Plane.SixRing…` ones; the eight rows beside the thirteen). What the merge
brought into this branch: the eight generated modules under `Proofs/HadwigerNelson/Outside/`, the port's edit of
`Outside/OAI158Palette.lean` (docstrings and the header's notice of change: the module re-elaborates and so does every
module downstream of it), its block in `scripts/Axioms.lean` (lines "FS132-I2" … "FS132-I2: end of the block"), its
tools and data, its record. (The merge commit is the one commit of this job not made by explicit path: git refuses a
partial commit during a merge; the index held the merge's 81 files and nothing else — checked with `git status` before
it was concluded.)

**The merged tree, placeholders still present** — `build.sh` under the slot: exit 0, 25 modules rebuilt, 71 `sorry`
warnings, 9m14s (`data/fs132/i4/logs/build-1-merged.out`). No name clashes at this state: the placeholders are
`HadwigerNelson.SixRing.*`, the ported theorems `HadwigerNelson.Outside.OAI158.*`.

**The four statements, the placeholder's form beside the ported theorem's, as the kernel stores them.**
`data/fs132/i4/join/Compare.lean` → `Compare.out` (`lake env lean` on the merged tree, exit 0): for each short name the
stored type of `HadwigerNelson.SixRing.<name>` against that of `HadwigerNelson.Outside.OAI158.<name>`, by `Expr.equal`
(structural, with binder names and binder annotations) and by `==` (up to bound-variable names):

| statement | placeholder (`Plane/SixRing/Placeholders`, deleted) | ported (`Outside/…`) | `Expr.equal` |
|---|---|---|---|
| `palette_transfer_pair` | `{k} (c) (hc) (hw : WeakColoring k c) (x : ℂ) : ∀ᵐ p ∂angularMeasure.prod angularMeasure, c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2` | the same (`OAI158PaletteDensity`) | **IDENTICAL** |
| `palette_sixty_disjoint` | `{k} (c) (hc) (hw) (x) : ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f + ↑sixty))` | the same (`OAI158PaletteTransport`) | **IDENTICAL** |
| `two_state_impossible` | `{k} {c} (hc) (hw) (x) (J K : Finset (Fin k)) (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2) (s : Angles → Bool) (hs : Measurable s) (hJ : RealState hc x {t \| s ↑t = false} J) (hK : RealState hc x {t \| s ↑t = true} K) (hflip : ∀ᵐ t ∂angularMeasure, s (t + ↑(π / 3)) = !s t) : False` | the same (`OAI158States`) | **IDENTICAL** |
| `mem_spatialSupport_ae` | `{k} (c) (hc) (i : Fin k) : ∀ᵐ z : ℂ, c z = i → z ∈ spatialSupport c i` | the same (`OAI158AngularBoundary`) | **IDENTICAL** |

The eight `#check`s with full names are in `Compare.out` under the verdicts. Controls in the same run, both read
DIFFERENT as they must: one statement against another (`Expr.equal=false`), and a statement against itself with its
first binder's annotation flipped (`Expr.equal=false`, `==` true — so `Expr.equal` is the comparison that sees a binder
made implicit, and it is the one the verdicts use).

**The join.** `Plane/SixRing/Placeholders.lean` deleted (`git rm`); its import line out of `Proofs.lean`; its row out of
`ARCHITECTURE.md` § 3; its importers pointed at the ported modules — imports only:

| module | was | is |
|---|---|---|
| `ChartMeasure` | `Chart`, `Shift`, `Placeholders` | `Chart`, `Shift`, `Outside/OAI158PaletteDensity`, `Outside/OAI158AngularBoundary` |
| `Excl` | `Placeholders` | `Outside/OAI158PaletteTransport` |
| `TwoPairs` | `Excl` | `Excl`, `Outside/OAI158States` |
| `State` | `ChartMeasure`, `StepLemma` | the same and `Outside/OAI158PaletteTransport` |

(and one sentence of `State.lean`'s module docstring, which said "placeholders until the port's join").
**Every leaf or call site that had to change: none.** No statement, no proof term and no call site of any module was
touched: `TwoPairs.no_alternating_groups` calls the ported `two_state_impossible` with the argument list it called the
placeholder with, and `open Outside.OAI158` resolves the four short names as the planner's § 7.1 said it would.

**The joined tree** — `build.sh` under the slot: **exit 0**, 7 modules rebuilt (`ChartMeasure`, `Excl`, `Kill`, `State`,
`Orbit`, `TwoPairs`, `Proofs`), 8m52s, **68 `sorry` warnings** = 71 − the 3 placeholders (`Chart` 11, `ChartMeasure` 4,
`CyclicCentre` 3, `Excl` 2, `Kill` 2, `Shift` 7, `State` 8, `StepLemma` 8, `Tips` 7, `Winding` 16;
`data/fs132/i4/logs/build-2-join.out`).
`tools/check_architecture.py`: **exit 0**, `RESULT: PASS`, 330 rows against 330 modules, 0 import mismatches
(`logs/arch-2-join.out`). `./scripts/dupnames.sh` (slot, 16 GiB): **exit 0**, 1867 of 1867 package modules scanned, no
name declared by two modules, 23 generated on demand (`logs/dupnames-2-join.out`).

**The coordinator's relay, received while the join built** (from FS132-I3, branch `fs132-wi3`, at its commit
`6fe55ef78`: the step lemma's module proved; `volume_change_pairs_pos` lost `hS`, `exists_shiftMap` lost `huw`, under
the planner's permission (1); mine to decide whether to merge that commit now). **Decision: merge `fs132-wi3` at
`6fe55ef78` into this branch, next (stage 3)** — so that `exists_tip` is written once against the final binders and the
final merge of the two branches finds no call site to adjust; this branch writes neither `StepLemma.lean` nor
`Shift.lean`, so that branch's later commits merge over it without conflict.
