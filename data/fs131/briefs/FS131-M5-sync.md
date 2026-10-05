# Brief FS131-M5 — `main` merged into `fs131-w5` (wave 4, Woodall and MERGE brought into wave 5), then four short children of `exists_preBend`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-M5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's sync — merge `main` into `fs131-w5`, taking `main`'s side for every wave-4 module, applying `framePt → fromFrame` in wave 5's own files, removing identical copies, and checking it; then, as budget allows, four short children of `exists_preBend` in `BaseDense`
  launch: now, beside FS131-IL1 (lane A of the limit, on `fs131-w5c`) and FS131-E6 (an Ephodos derivation, in the main tree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a conflict that is more than taking `main`'s side for a wave-4 module or keeping both sides elsewhere, a name both sides declare with different statements, a statement the merge shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-M5.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 47, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the merge's files (conflicts resolved as § Done means 2 says); wave 5's own modules for the rename and the deletions of identical copies only (no statement or definition changes); `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` (the four children named below and children beside them); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-I5-implementation.md`, `tools/fs131_m5_*.py`, `data/fs131/m5/`, `data/fs131/reports/FS131-M5.md`; **not** `main`, `BendCollar`'s statement, `HexRing`/`BaseWalk` beyond the merge, `Terminal` (the `Terminal` lane is `fs131-w5c`), nor the gate scripts' recorded counts
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are bringing `main` into wave 5's branch. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones; on `main` now
are waves 1–4, Woodall's chain and MERGE, all held. Wave 5 (termination and density) has been proved on branches cut before wave 4 landed, so they carry stale
copies of wave 4's modules — and the next jobs need `main`'s proved versions (the strengthened bend's construction needs wave 4's cut engine, `bv_l3` and the
limit's procedure need the moves). Since `fs131-w5` and `main` parted (`111830c8`), only four files changed on both sides: `ARCHITECTURE.md`, `Proofs.lean`,
`scripts/Axioms.lean` and one proof file, `Plane/ValidMap/BaseSteps`. After the merge, four short children of `exists_preBend` are yours if budget allows.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 lands on
`main`; every later job on this branch wants `main`'s wave 4. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The rulings that launch you, what KB2 handed back, and how the last merges and landings went:

> 379. **Rulings on KB2's held items, and its slot.** (a) **Merge `main` into `fs131-w5` now** (the alternative, re-proving the cut engine in `BendCollar`
> — source: plans/FS131-close-inventory.md

> 378. **FS131-KB2 handed back** (Stage 46 SAVED, harness ≈ 420k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 43–46;
> — source: plans/FS131-close-inventory.md

> 318. **WAVE 4 LANDED on `main`, held in the kernel** (FS131-G4, done, harness ≈ 462k; report `fs131-w4`'s `data/fs131/reports/FS131-G4.md`; record Stages 44–48;
> — source: plans/FS131-close-inventory.md

> 375. **MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 358. **Ruling on RS1's slot: FS131-I5o on `fs131-w5`** — (1) **merge `fs131-w5p` (at `5086e856`) into `fs131-w5`** (both sides touch only `ARCHITECTURE.md`,
> — source: plans/FS131-close-inventory.md

> 369. **FS131-I5o handed back: `row134BaseUA` is held on `fs131-w5`** (Stage 42 SAVED, harness ≈ 384k by the task notice; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

## The statements

No backlog statement changes in this job. After the merge, the four children (`sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` at `caada347`; read each whole there, with its route in its
docstring), their first lines:

> theorem ncard_coloursAt_le_two_of_mem_openArc {P : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem unenclosedC_of_homeomorph {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {u : ℂ} {K : Set ℂ} (hK : Bornology.IsBounded K)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem exists_maxRingArc (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem hfree_of_baseHyp (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hH : F.BaseHyp u) (hP : P ∈ closedBall u 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read KB2's Stages 43–46, I5o's merge stage (39) and ML1's Stage 14 on
   `fs131-w4mm` (how it took `main`'s side and checked it); build `fs131-w5` once as given (`caada347`) before editing anything. Commit and push.
2. **The merge**: `git merge origin/main` into `fs131-w5`. Take `main`'s side for every wave-4 module (`main`'s are proved; this branch's are stale copies),
   keeping any declaration this branch added there that `main` lacks (name it in the record) — `BaseSteps` is the one proof file both sides changed; keep both
   sides in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean`. Apply `framePt → fromFrame` in wave 5's own files (`FlankUA`, and any other wave-5 file
   that uses it), and check that no `framePt` resolves to wave 2's `Plane/Slack.framePt`. Remove identical copies wave 5 made of `main`'s lemmas (I5h's
   `isPreconnected_hornSet_unit` against `Surgery`'s `isPreconnected_hornSet` if identical in effect; any other the dupes tools find — run
   `tools/fs131_ml_dupes.py` adapted to this branch, or a script of your own, with a plant). Run a three-way statement check (`tools/fs131_wl_mergestmts.py`
   or I5o's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/tools/fs131_i5o_merge_check.py`): every statement of either side byte-identical to the side that changed it. Build; an axioms print against the
   merged build, with the wave-4 leaves this branch carried as stale `sorry` now on the standard three, and a control on `sorryAx`; the `sorry` count by file
   before and after. Commit the merge as its own stage and push.
3. **The four children**, as budget allows: `ncard_coloursAt_le_two_of_mem_openArc`, `unenclosedC_of_homeomorph`, `exists_maxRingArc`, `hfree_of_baseHyp`;
   save after each; no statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **Your record**, stages headed "Stage n — SAVED (FS131-M5)", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge
   `fs131-w5c`, run the full gate, or touch `main`. Leave no background process running. Stopping at a saved stage with work left, named, is a good report.

## What is yours to decide

The merge's mechanics and its checks, the order of the children, and where a supporting lemma lives within your touches. If the merge meets a conflict that is
more than taking `main`'s side for a wave-4 module, or a name both sides declare with different statements, stop and message me with the hunks. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; the merge brings many changed modules, so the first build after it is long. Never replace the build with a symlink.
Nothing with a `sorry` reaches `main`.
