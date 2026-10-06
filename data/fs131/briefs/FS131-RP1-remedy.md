# Brief FS131-RP1 — wave 5's remedy pass on `fs131-w5c`: the audits' docstring lines, the ruled statement tidies, and the statements that stand twice, in one rebuild

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RP1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one pass over wave 5's joined line that makes every ruled small change the audits and the last jobs left — corrected inhabitant notes, six ruled statement tidies, three unused binders, the statements that stand under two names — each checked by script, in as few rebuilds as the order allows; nothing here is new mathematics
  launch: now, in the tree FS131-M7 has handed back, beside FS131-BA3 (the outward bend's last two children, on `fs131-w5z`) and FS131-KM1 (the example maps' planner, on `fs131-wm`)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a ruled change that does not go through as ruled (a caller you did not expect, a proof that reads the hypothesis after all), a docstring correction whose corrected claim you cannot verify, a doubled statement whose two forms turn out to differ, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RP1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-RP1-remedy.md` (new, on branch `fs131-w5c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `3381e47f`): the files the list below names — docstrings in them, and the statements ruled to change with their callers; `ARCHITECTURE.md`, `scripts/Axioms.lean` (a block of your own, headed "FS131-RP1", above the `=== PURCHASED ===` banner; and the records of any declaration you rename or remove), `scripts/vacuity-baseline.txt` only if a renamed declaration is in it, `plans/FS131-RP1-remedy.md`, `tools/fs131_rp_*.py`, `data/fs131/rp/`, `data/fs131/reports/FS131-RP1.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` nor the outward bend's other four modules (FS131-BA3 is finishing them on `fs131-w5z`, and its branch is merged into this one after you: an edit here collides — their tidies are listed last, for after that merge), no statement beyond the ruled ones, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are doing the housekeeping that lets wave 5 of the Lean backlog land clean. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones. Wave 5 — the termination procedure and the density argument over it — is now one line, and every open leaf it has
is being closed on a sibling branch. Along the way three audits and a dozen jobs left small ruled changes for "the remedy pass": notes in docstrings
that claim more than is true, hypotheses no proof reads, a theorem stated with half a hypothesis idle, the same fact under two names. None is
mathematics. Each is cheap now and costs a rebuild of everything downstream once the wave is on `main`. This is that pass.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the
gate's inhabitant rule (`LEAN.md` § The gate) treats a docstring's "inhabitant of the hypotheses" as a claim: seventeen such notes on this line are
false as written. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The rulings that make the list (read each whole in the inventory; the letters are cited below):

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

> 419. **Rulings on LN1's held items; a correction to ruling 417 (b); the slot.** (a) **The three binders are removed** (two theorems become strictly stronger,
> — source: plans/FS131-close-inventory.md

> 441. **Rulings on E7's held items, and its slot.** (a) **`nb4p` is restated with the one conjunct its proof reads**, at wave 5's remedy pass (the
> — source: plans/FS131-close-inventory.md

> 450. **Rulings on IR3's held items, and its slot.** (a) **Wave 5's lines are joined now, not after the outward bend**: FS131-M7, on
> — source: plans/FS131-close-inventory.md

> 432. **Rulings on IS1's held items, and its slot.** (a) **`Terminal` imports `Plane/StuckChain`, and the `ARCHITECTURE.md` Imports cell stays as
> — source: plans/FS131-close-inventory.md

> 434. **Rulings on item 433.** (a) **`bend_away_part`'s planner takes the next freed slot, ahead of the models' planner FS131-KM1** — a `debruijn`
> — source: plans/FS131-close-inventory.md

> 455. **Rulings on BA1's held items, and its slot.** (a) **The inhabitant `awayModel` goes to the models' planner, FS131-KM1, with the other
> — source: plans/FS131-close-inventory.md

> 458. **FS131-M7 done: wave 5 is one line on `fs131-w5c`; `Procedure` holds no `sorry`; and a gap in the gate found — Lean accepts one theorem
> — source: plans/FS131-close-inventory.md

> 459. **Rulings on M7's held items, and its slot.** (a) **What the doubled name costs, as I read it — hygiene, not soundness**: the two merged
> — source: plans/FS131-close-inventory.md

## The statements

The statements ruled to change, as they stand in your tree (read each whole):

> theorem nb4p {G : ArcMap 6} (hF : G.Valid) {v : ℂ} (hv : G.Covers v 1) (h4 : (G.coloursAt v).ncard = 4) {ψ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem exists_rayStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} {n : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_shaveStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k} {n : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

The audits' rows and the sources of each corrected text:

> | 2 | QA4-2: 17 docstrings naming `bowtie` as the inhabitant under `Covers v 1` or `IsPlaneMap` (`FlankUA` 9, `Terminal` 8; § 3.5's list) — every later reading of the stuck family trusts them | each note corrected: "`bowtie` at `0` satisfies every hypothesis but `F.Covers 0 1` (FS131-QA4, QA4-B1); no Lean model of all at once; the completed bowtie at [hand]" | the implementers of `fs131-w5` (`FlankUA`) and `fs131-w5c` (`Terminal`) | 17 docstring lines; their dependents rebuild once | **yes** — a landed docstring is environment data, and correcting it after landing rebuilds every dependent on `main` |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> | 3 | `bend_toward_collar` (`BendCollar`): `hmax`, `hlen` unused, and with them no model in `l60Frag` | drop both; a named theorem stating QA4-C1's conjunction beside `collarModel`; a docstring line naming it on `bend_toward_collar` and `exists_collarFit` | the implementer who next edits `BendCollar`, under ruling 419 (d)(ii) | about 30 lines, text in `data/fs131/qa4/QA4Collar.lean` | **yes** — a statement change is cheapest before the landing |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> | 8 | Docstring lines with no mathematics: (a) the three moves and their `_aux` forms — an inhabitant note; (b) `pair_ii`, `fail_leavingCentre`, `fail_colours` (`BaseSteps`) — the note names an inhabitant of one hypothesis on a map where the others cannot hold; say so; (c) `rot_out`, `rot_in` (`HexRing`), `exists_eleventh_of`, `exists_far_end` (`MapTopology`), `dense3`, `cv_exists` (`BaseDense`) — the base's line or the open line; (d) Woodall's refutation steps (`SectorsAt.false_of_ncard_le_two_on_arc`, `false_of_four_le_sectors`, `woodall_step4`, `townsend_lemma`) — "a refutation step", naming `sevenBrickMap_woodallModel`; (e) `LocalSeq.const` — "idle", not "every clause exercised"; (f) one module-level line naming the model for the families that are AT-ONCE, unnamed (TS-T, the ring-arc theorems, `Cone`'s contact lemmas, `MapTopology`) | the lines | the wave-5 files: their current implementers; `main`'s files: one remedy pass | about 30 lines | wave 5's files: yes; `main`'s: with the remedy pass (one rebuild) |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> All three are one shape: **a `[NumberField _]` instance argument that neither the statement nor the proof uses.**
> — source: plans/FS131-lint-measurement.md

> ### 1.4 A finding met on the way: `nb4p` never reads half of `hnb`
> — source: plans/FS131-E7-derivation.md

> ### 7.5 What it does to the stuck family's docstrings, read against three of its theorems
> — source: plans/FS131-E7-derivation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the audit's §§ 3.1, 3.5 and 6 (`plans/FS131-QA4-audit.md`), the
   lint measurement's findings (`plans/FS131-lint-measurement.md`), FS131-E7's §§ 1.4, 3.7, 4.4, 5.4, 6.5 and 7.5 (`plans/FS131-E7-derivation.md`),
   and FS131-M7's report (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/data/fs131/reports/FS131-M7.md`). Build the branch once as
   given. Write your work list into your record as a table — item, file, the ruling, the change, its callers — before the first edit: the order of
   edits decides how many rebuilds you pay. Commit and push.
2. **The statement tidies** (each: the statement, its callers, a script check that exactly the ruled statements changed; group them so that the
   files furthest upstream are edited first):
   (a) `nb4p` — `hnb` keeps the one conjunct its proof reads (ruling 441 (a)); the docstring says the other half suffices too, at [hand], by the
   mirror (E7 § 5.4);
   (b) `bend_toward_collar` — `hmax` and `hlen` go (rulings 419 (d), 427 (a); the audit's QA4-C3 is the proof without them), with a named theorem
   beside `collarModel` stating QA4-C1's conjunction (the text is `data/fs131/qa4/QA4Collar.lean`) and a docstring line on `bend_toward_collar` and
   on `exists_collarFit` naming it;
   (c) `exists_rayStep` and `exists_shaveStep` — `hn` goes (ruling 450 (c)), with the one caller;
   (d) the three `[NumberField _]` binders of the lint measurement (ruling 419 (a)), with their callers.
3. **The docstrings**: the seventeen `bowtie` notes (audit § 3.5: nine in `FlankUA`, eight in `Terminal`) — each says what `bowtie` satisfies and
   the one hypothesis it fails, and names the hand model of the whole set, which since FS131-E7 is its twelve-colour map `P₅` (E7 § 7); the stuck
   family's "no model … is known" lines, by E7's § 7.5; the lines for `a4six`, `straddlers_third`, `nb4p` and `flank_ne_of_doublyShadowed` that E7
   drafted (ruling 441 (b)); the audit's rank 8, (a)–(f), and rank 7's line on `exists_arcStep` if FS131-M7's new docstring dropped it;
   FS131-IS1's two drafted `ARCHITECTURE.md` cells (ruling 432 (b); its record's Stage 62, § Drafts, in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md`). A note you correct is a claim you make: check each
   named object against each hypothesis it is said to satisfy, by the statement or by `tools/fs131_qa4_notes.py` (on `main`:
   `/home/kooshi/source/lean-dir/tools/fs131_qa4_notes.py`), and run that tool over the branch when you are done — no CONFLICT left.
4. **The name that stands twice, and the statements under several names** (rulings 434 (d), 459 (c)). First **`conj_e`**, declared by both
   `Plane/Chord` and `Plane/SixFragment` — on `main` since 2026-10-04; Lean accepts it silently because the two are theorems of one type in
   sibling modules: make it one declaration in a module both import, with `sq_norm_eq`/`sq_norm_re_im`, the same two files' second duplicate.
   Then the list FS131-M7's report ends with ("Names that stand twice, and statements under two names, in the joined tree": seven statements,
   each with its import relation), and `finite_arcs_inter_compact`/`finite_arcs_meeting_compact` (item 433). For each: check the statements are
   one, keep the name furthest upstream, re-point the others' users, remove them and their `scripts/Axioms.lean` records. One that turns out to
   differ is a message to me. The pairs the report marks "not duplicates" stay. Re-run M7's `tools/fs131_m7_dupes.py --whole` at the end: no name
   twice.
5. **The check**: a build with no warning but `sorry` (the outward bend's open children, nothing of yours); the axioms print for every statement
   you changed and every declaration you kept of a doubled pair; `tools/check_architecture.py` exit 0; your statement check with its plants fired.
   No new `axiom`, no `native_decide`. You do not run the gate, merge another branch, or touch `main`. Do not edit a file while a build of it
   runs. Leave no background process running, and keep what your record cites under `data/fs131/rp/`.
6. **Your record**, the table of item 1 with each row's outcome; the report in standing rule 11's form, ending with **the list left for after
   the outward bend's merge** — you do not do these: `hF` out of `CollarFit.map_hornCount_le` with its callers (ruling 457 (b)); the "skeleton"
   headers of the bend's modules and of FS131-KA1's block in `scripts/Axioms.lean`, and `BendStep`'s header (items 454, 456); the two forms
   `ringPt_inj_of_abs_sub_lt` and `ringPt_ne_of_abs_sub_lt` (item 454) — and anything you met that belongs with them. Stopping at a saved stage
   with the statement tidies done and the docstrings part done is a good report.

## What is yours to decide

The order, the wording of each corrected note within what is true, which name of a doubled pair survives, and how to group the rebuilds. If a ruled
change turns out wrong when you make it — a proof does read the hypothesis, a note's corrected claim fails — do not force it: leave that item, say
why, and message me; the ruling is mine to fix. If you see a tidy of the same kind that no ruling names, list it in your report; do not make it.
Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
