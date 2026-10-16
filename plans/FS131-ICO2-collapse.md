# FS131-ICO2 — the collapse finished: the last three modules, the build, the gate and the drafts

*Implementer's record (de Bruijn, the implementer, on Opus 5.5). Brief: `data/fs131/briefs/FS131-ICO2-collapse.md` (on `main`
at `57984248b`). Worktree `.claude/worktrees/kcl1`, branch `fs131-ico1`, taken over at `ebeb126d1` (clean). The plan:
`plans/FS131-KCL1-collapse-plan.md`; the previous implementer's record: `plans/FS131-ICO1-collapse.md`. Scripts and logs under
`data/fs131/ico2/`.*

## Theorems this phase proved

None yet at kernel grade (filled in as the gate passes).

## Stage 1 — SAVED: the readback

**Quotations.** The planner's checker (`data/fs131/kcl1/quote_check.py`, read-only) run on this brief and on the ICO1 brief
(whose § The statements is part of this one), against this worktree and against the main tree (`data/fs131/ico2/quote_check.out`):
this brief's two quotations (inventory items 988 and 993, `plans/FS131-close-inventory.md`) verbatim in both trees; the ICO1
brief's five (W2, row 128, the three headline statements) verbatim in this worktree, and the first two verbatim in the main
tree, whose third source (`Collapse/Headline.lean`) does not exist there — the skeleton is on this branch only, as expected.
Control: a copy of this brief with one letter changed inside its first quotation ("Weil" → "Weel") is reported NOT FOUND at
character 897 with exit 1 (`quote_check_plant.out`; the planted copy deleted after). **No mismatch.**

**The branch against the previous record's stage 5.** The branch is at `ebeb126d1`: the stage-5 report `32da5595c` with `main`
merged (`20fd89a89`, bringing `Rigidity/MainClauseFive` and records). `git status` clean. `grep -cw sorry`: 0 in `Thick`,
`Mixing`, `Colouring`, `Dichotomy`; 4 in `Slice`, 8 in `Selection`, 9 in `Headline` — as item 993 records. `main` is ahead by
two commits (`57984248b`, this brief; `99e78e428`, the handoff), neither touching `Proofs/`. The four proved modules have never
passed `./scripts/build.sh`: the first build of this job (`data/fs131/ico2/build1.log`) is their first real compile.

**The order of work.** (1) `Collapse/Slice` (4 leaves: `measure_ne_eq_k`, `tendsto_measure_ne_k`, `exists_extension_k`,
`exists_slice_k`, copies of `Rigidity/CountExtension` at `Fin k`), with an `omit [NumberField F] in` at `measure_ne_eq_k` if its
proof does not read the instance (item 993's ruling); (2) `Collapse/Selection` (8 leaves); (3) `Collapse/Headline` (9 `sorry`s:
`not_colorable_one_planeOver`, `chromaticNumber_planeOver_eq_plane_of_thick`, the two `isSquare_*`, the two `le_of_isSquare_*`,
the two `weil_*_lt_fifth`, `not_thick_bot`); a saved stage after each; (4) the experience pass on the headline names and
docstrings; (5) the build, no `sorry` in `Collapse/`; (6) merge `main`, the gate on one commit by the steps of
`data/fs131/clone1/run-gate.sh` copied under `data/fs131/ico2/`, every count change against `data/fs131/il5/gate/`, the
statement comparison against `data/fs131/ico1/statements-before.txt.gz` with the ruled changes (the `omit`s at `ThickAt.mono` and
`measure_ne_eq_k`, and `Collapse/Thick`'s two Mathlib imports) shown from the kernel's side, the vacuity scan's new sites with each
structure hypothesis's inhabitant, `#print axioms` of the three headlines and D-E1, D-E2; (7) the read-aloud against row 128;
(8) the drafts; (9) the report.

**Iteration.** While a build walks, the module under work is written in a copy under `data/fs131/ico2/work/` and compiled in the
previous job's farm (`build/ico1-farm`, by `data/fs131/ico1/lean1.sh`; the farm's `Thick`, `Mixing`, `Colouring`, `Dichotomy`
oleans are real files compiled from the committed sources within a minute of each commit); the copy goes over the module between
builds. The farm is iteration, never evidence: the build is the check.
