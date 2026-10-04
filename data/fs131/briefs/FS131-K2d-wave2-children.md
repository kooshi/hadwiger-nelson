# Brief FS131-K2d — wave 2 of the Lean backlog: state the children of its last 18 leaves

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K2d
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the successor of FS131-K2c on wave 2's plan — state in the skeleton the children K2c named but did not state (the ◇ rows of the plan's § 12.2) for the leaves in `Plane/CoverExamples`, `Arith/PlaceHom` and `Arith/FalconerField`, plan `exists_not_uniform_kept`'s children in the record, and write the next implementer's handoff
  launch: now, beside FS131-I2e (wave 2's implementer, in `.claude/worktrees/fs131-w2` on branch `fs131-w2`), FS131-I3e (wave 3's implementer, in its own worktree) and FS131-E1 (a deriver, no Lean, in the main tree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K2d.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w2-kernel-plan.md` (on your branch `fs131-w2d`; you add stages to it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2d` (branch `fs131-w2d`, made for you from `fs131-w2` at `29082313`): `Proofs/HadwigerNelson/Plane/CoverExamples.lean`, `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `Proofs/HadwigerNelson/Arith/FalconerField.lean`, new modules of your own under `Proofs/HadwigerNelson/Arith/` or `Proofs/HadwigerNelson/Instances/` if a child needs one (the orbit tables, say), `Proofs.lean` and `ARCHITECTURE.md` (only for those new modules and their imports), `scripts/Axioms.lean` (a block "FS131-K2d", before `=== PURCHASED ===`), `plans/FS131-w2-kernel-plan.md`, `tools/fs131_k2d_*.py`, `data/fs131/k2d/`, `data/fs131/reports/FS131-K2d.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are picking up wave 2's plan from FS131-K2c (de Bruijn on Opus, like you), which re-planned all 34 of the wave's remaining leaves and stated
children in the skeleton for 16 of them before its context ran out. Wave 2 is the measurable-colouring rows — covers and maximal covers, the slack
suprema, stationary colourings, the worked examples R7, DISC7, HC and IRREG — and the arithmetic rows on place homomorphisms and Falconer fields. Its
fifth implementer, FS131-I2e (de Bruijn on Sonnet), is working right now on the 16 leaves whose children are stated, in the wave's own worktree. Your
job is the other 18: turn each route K2c wrote in a table line into lemmas an implementer can close.

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), so none of wave 2 is
held until its last leaf is proved, and these 18 leaves are the ones no implementer can start: four Sonnet implementers in a row stopped on leaves whose
routes were sketched in a line. The next implementer on this wave will be an Opus one, as a trial Kooshi authorized (inventory item 103), and your
children are what it works from. Kooshi's standing word on Lean work: formalization is never a cost that ranks routes (`CLAUDE.md` § Counter-priors).

## The statements

The leaves are the `sorry` declarations at `29082313` in the three files that are yours: in `Plane/CoverExamples`, `sq9_saturated_both`,
`r7_aeColouring`, `r7Cls_saturated`, `r7_boundary`, `r7Cls_isMaximalCover`, `disc7_isMaximalCover`, `disc7_isRegularMUA`, `disc7_upperDensity`,
`IsMUA.add_normal_mem_essSupport`, `g1Bounds_hcGap`, `hc_isRegularMUA`, `hc_band_components`, `fatZ_spec` and `hc_irreg`; in `Arith/PlaceHom`,
`exists_placeHom` and `noAffine_fields`; in `Arith/FalconerField`, `falconerFan_five_field` and `falconerFan_five_placeHom`. The eighteenth,
`exists_not_uniform_kept`, lives in `Plane/Slack`, which FS131-I2e holds. Their statements were fixed by the planners and the rulings (read back in
`.claude/worktrees/fs131-w2d/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3) and do not change in this job. K2c's report names the gap you close:

> RESULT: GAP at a planning step — 18 leaves (lane A's 4, CoverExamples' 13, exists_not_uniform_kept) have routes and named children in § 12.2 (◇) but their children are not yet stated in the skeleton; HC/IRREG's need plans/FS111-M3-finiteness.md §§ 2.2–2.4 read line by line first
> — source: .claude/worktrees/fs131-w2/data/fs131/reports/FS131-K2c.md

Each leaf's route and its named children are its line in § 12.2's table. The HC rows' line, for instance:

> | `hc_isRegularMUA`, `hc_band_components`, `hc_irreg` | stage 7.4 and 9.2's named children | ◇ `hcBandTop_spec`, `hcUp_slivers`, `hc_unitAvoiding`, `hc_sausage_cover`, `hc_lemmaNL`, `hc_exclusion`, `hc_ae_phi_pos`; for IRREG the bulge-crossing `|E| > 0` and Baire on `(Z − ρ) ∪ (Z + ρ)` | **not decomposed further here**: the statements need `plans/FS111-M3-finiteness.md` §§ 2.2–2.4 read line by line; a planning stage of its own (estimate 8–10 children of 30–40k each for HC, 4 for IRREG) |
> — source: .claude/worktrees/fs131-w2d/plans/FS131-w2-kernel-plan.md § 12.2 The table (order: lane P analysis, lane P examples, lane A, each top to bottom)

## Done means

1. **Your readback first**: check both quotations against their sources; restate in your record the 18 leaves with their ◇ children from § 12.2; build
   the worktree once as given (the build directory was copied from `fs131-w2`'s at `29082313`, so it should be nearly current). Commit and push.
2. **`plans/FS111-M3-finiteness.md` §§ 2.2–2.4 read line by line** before the HC children are stated (and its stage 4 for IRREG, `hc_irreg` and
   `fatZ_spec`), as K2c asked.
3. **The children in the skeleton** for the 17 leaves in your three files: each child a `sorry`ed lemma with its statement, each leaf re-pointed at its
   children (an assembly proof from them where you can write one, as K2c did for `chiM0_le_of_fragments`), the Mathlib lemmas each uses confirmed with
   `#check` at the pin, an honest price per child for an implementer, and the order. A child priced above about 40k tokens is split again or explained.
   The orbit children (`gamma7_orbit`, `gamma11_orbit`, `gamma19_orbit`, by `decide +kernel` over tables) are priced from one you prove or measure.
4. **`exists_not_uniform_kept`'s children planned in your record** as Lean statements, ready to paste into `Plane/Slack` by whichever implementer next
   holds that file; you do not edit `Plane/Slack`.
5. **The build green** through the worktree's `./scripts/build.sh` with only `sorry` warnings; `tools/check_architecture.py` exit 0; a
   `scripts/Axioms.lean` record for every new declaration.
6. **Ready to merge back**: at the end, merge `fs131-w2`'s head into `fs131-w2d` (keep both sides of the append-only lines in `scripts/Axioms.lean`,
   `Proofs.lean` and `ARCHITECTURE.md`), build green again, and push. The merge of your branch into `fs131-w2` is the next implementer's first step, not
   yours, because FS131-I2e is working in that tree. Leave `main` alone.
7. **The handoff** for the next implementer, in the form of § 13 (where it is, the build, what it may and may not change, the order, the landing), for
   these 18 leaves; then the report in standing rule 11's form. Your stages are appended to the record headed "Stage n — SAVED" from the next number
   (14), with "Theorems this phase proved" (usually none). If your context runs short, save the stated children first and hand back with the rest named:
   that is a good report.

## What is yours to decide

Every route and decomposition, how faithfully to follow K2c's table (say in the record where you depart and why), whether an obligation-modeling pass
over the new children pays (`debruijn-obligation-modeling`, invoked fresh), and whether to prove a child yourself where that is the quickest way to show a
route works. The handoff rule your successors work under is § 13's:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2d/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

If a route turns out to need new mathematics — not a formalization step — that is a missing lemma: state it and message me, and I route it to a
deriver. If a statement turns out false or mis-stated, message me with the counterexample: two such have been caught in this wave already (items 37 and
86), each found by the mind closest to the Lean.

## The machine

Build only from inside your worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
three trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean -DautoImplicit=false <file>` is for iteration only. The
worktree's `.lake/packages` is a symlink to the main tree's and its `.lake/build` its own copy; never replace the build with a symlink — two trees
compiling into one build race on the same compiled files. Nothing with a `sorry` reaches `main`.
