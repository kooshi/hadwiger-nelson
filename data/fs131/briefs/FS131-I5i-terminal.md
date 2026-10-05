# Brief FS131-I5i — wave 5 of the Lean backlog, the `Terminal` half continued: stuck chains' ends, the CV-HD cluster and the terminal map on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5i
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's second `Terminal` implementer — continue FS131-I5h's work on `fs131-w5c` from its Stage 28, in item 329's order, saving after each leaf
  launch: now, beside FS131-I5g (wave 5's other half, on `fs131-w5`) and FS131-IP5 (the planar chain, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a step of E5's or NB3's derivation that fails in Lean, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5i.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it from Stage 29, headed as yours — I5g writes stages on `fs131-w5` meanwhile, and the merge keeps both)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only `cv_exists` and children beside it; supporting lemmas in `FlankUA` or a new module upstream of `Terminal` (statements of other files unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5h_*.py`, `tools/fs131_i5i_*.py`, `data/fs131/i5h/`, `data/fs131/i5i/`, `data/fs131/reports/FS131-I5i.md`; **not** `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph` or `BaseDense` outside `cv_exists` (I5g's and the planar job's), nor wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are continuing the `Terminal` half of wave 5 of the Lean backlog. Wave 5 is **termination and density**: the terminal valid map the moves reach,
the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. Two of your leaves had stopped at a GAP in a filed hand step (NB3-END item 2,
and the same exclusion in FS114-CVB § 1.4 item 5); FS131-E5 derived both, with no statement change, through two lemmas, and FS131-I5h has just proved those
lemmas in the kernel (`Plane/ValidMap/HornShadow`). Your ten leaves are not started; I5h's record says where each stands and suggests children for the first.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and this half is now
the longest path to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5c` at `72149b07` — `n3_end_of_not_inType`, `cv_class`, `cv_hd_main`, `y3_end_needs`, `cv_hd`, `c_double`, `c_ends`, `exists_red`,
`exists_terminal` (`Terminal`) and `cv_exists` (`BaseDense`) — each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2. What I5h handed back, and the ruling that launches you:

> 328. **FS131-I5h handed back** (Stage 28 SAVED, harness ≈ 387k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 27–28;
> — source: plans/FS131-close-inventory.md

> 329. **Ruling on I5h's slot: the `Terminal` continuation, FS131-I5i, on `fs131-w5c` from Stage 28.** In flight after it: 1 (I5g) + 1 (IP5) + 1 (I5i) = 3. Choice:
> — source: plans/FS131-close-inventory.md

Where each leaf stands, in I5h's words — read its Stage 28 in full, the suggested children and the sign warning above all:

> - **`n3_end_of_not_inType`** (`Terminal`). Its three conclusions: `HasRepeatedColour S′` is E5 § 3.4 (now over `sep_add_pi_S`); `4 ≤ #P_cl(S′)` and the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 28 — SAVED (FS131-I5h): E5's lemmas SH and SEP, kernel theorems (`Plane/ValidMap/HornShadow`, new)

> - **`cv_class`**: its "None" disjunct by `sep_N`/`sep_add_pi_N` at `N` and § 3.4's argument at `S` (E5 § 3.5); its bowtie disjunct over `cv_hd`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 28 — SAVED (FS131-I5h): E5's lemmas SH and SEP, kernel theorems (`Plane/ValidMap/HornShadow`, new)

> - **`cv_hd_main`** (H: CVB § 1.6, both branches), **`y3_end_needs`** (H: YB3 § 3.1), **`cv_hd`** (M over `cv_hd_main`), **`c_double`** (E–M over `cv_hd`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 28 — SAVED (FS131-I5h): E5's lemmas SH and SEP, kernel theorems (`Plane/ValidMap/HornShadow`, new)

E5's verdict and its derivations, the route for the repeated colour and for `cv_class`'s "None" case — read § 3 in full:

> 321. **FS131-E5 done: both steps hold, no statement changes** (harness ≈ 491k by the task notice; record `plans/FS131-E5-derivation.md`, Stages 1–5; report
> — source: plans/FS131-close-inventory.md

> ### 3.4 NB3-END item 2, derived
> — source: plans/FS131-E5-derivation.md

> ### 3.5 FS114-CVB § 1.4 item 5, and `cv_class`'s "None" case, derived
> — source: plans/FS131-E5-derivation.md

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4 (it lands later on its own), so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read I5h's Stages 27–28, E5's record § 3 in full, and I5d's and I5e's notes under
   `n3_end` (record Stages 18 and 20.2); build `fs131-w5c` once as given (`72149b07`) before editing anything. Commit and push.
2. **The order of item 329**: `n3_end_of_not_inType` — its repeated colour first (E5 § 3.4 over F2–F6 and `sep_add_pi_S`), then NB3-END items 3–5 for its
   other two conclusions; `cv_class`; the CV-HD cluster (`cv_hd_main`, `y3_end_needs`, `cv_hd`, `c_double`, `c_ends`); `exists_red`; `exists_terminal`; then
   `cv_exists`. Save after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file
   while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control that must show `sorryAx`. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`; the merge happens
   on my word.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I5i)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the order's dependencies, and where a supporting lemma lives within your touches. I5h's suggested children are a
route, not a rule. NB3-END items 3–5 are one mind's derivation (NB3's), not re-derived by E5: if a step of them, or of E5's, fails in Lean, stop that leaf and
message me with the step and the smallest counterexample or the missing hypothesis — it goes back to Ephodos — and go on with the others. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
