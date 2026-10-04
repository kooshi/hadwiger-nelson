# Brief FS131-K2 — wave 2 of the Lean backlog: plan its foundation and skeleton (measurable colourings, covers, place homomorphisms)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 2's kernel module — its foundation sorry-free, its 28 rows as a skeleton with `sorry` at every leaf, each read back against its row, a plan per leaf
  launch: now, beside FS131-I1 (wave 1's implementer, in its own worktree) and FS131-K3 (wave 3's planner, in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w2-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/MaximalCover`, `Plane/Slack`, `Plane/Stationary`, `Plane/CoverExamples`, `Plane/FalconerReduction`, `Arith/PlaceHom`, `Arith/FalconerField`, `Arith/Dyadic`, and `Plane/YesLimit` from wave 3; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w2-kernel-plan.md`, `tools/fs131_k2_*.py`; and in the main tree, `data/fs131/k1/dispositions.csv` with `tools/fs131_k1_make_dispositions.py` (one change only, § The statements), committed on `main`, `data/fs131/k2/`, `data/fs131/reports/FS131-K2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are planning the second wave of the milestone that turns this project's hand-derived results into kernel-checked ones. The opening
job (FS131-K1, de Bruijn on Opus, like you) gave every one of the 259 backlog rows a disposition, put a shared foundation on `main`, wrote wave 1's
skeleton, and planned waves 2–10. Its plan, `plans/FS131-kernel-plan.md`, is your starting point: read §§ 4–7 in full, and § 5 (the foundation)
and § 6 (wave 1) as the model your work should match. Wave 2 is the measurable-colouring rows — covers, maximal covers, the slack suprema `µ_k(ε)`,
stationary families, the examples — and the arithmetic rows on place homomorphisms and the dyadic lemma.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate; this milestone formalizes the hand results the milestones before
it left on paper. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

Wave 2 plans while wave 1 is being implemented, so the milestone pipelines: your skeleton is built on wave 1's statements as they stand frozen
in its skeleton (commit `3358a401`), not on its proofs.

## The statements

Your rows are the 27 rows of `data/fs131/k1/dispositions.csv` with wave 2 and disposition *formalize*, and one more: FS111-C-FILL, FS111-M-R7, FS111-M-SATC,
FS111-M2-COV, FS111-M2-FIX, FS111-V0-RESCALE, FS111-W-SQ9, FS121-D3-GRUNDY, FS121-D4-FACE, FS129-OA1-NOPERLAW, FS129-SA1-FALC-RED,
FS129-SA1-PLACE-HOM, FS129-SA1-FALC-RES, FS129-MA2-FALC-HOSTS, FS129-SA1-NOAFF-FIELDS, FS129-SA1-SQRT3-LOCAL, FS129-SR2-SUPK, FS106-COMP, FS106-REM,
FS106-EQ, FS111-M2-DISC7, FS111-M-COVER-SC, FS111-M3-BAND, FS111-M3-FIXCONV, FS111-M3-HC, FS111-M3-IRREG, FS121-V5-FACE-SHARP; **and FS116-O1-YESLIM, moved here from wave 3** (inventory ruling 6: it rests only on
wave-2 rows, FS106-EQ and FS106-COMP through its merged FS129-SR2-YESLIM-EQ, and on N-EASY, and nothing rests on it). Three more rows merge into
them (FS106-SUP into FS129-SR2-SUPK, TC1-SQRT3-DYADIC into FS129-SA1-SQRT3-LOCAL, FS129-SR2-YESLIM-EQ into FS116-O1-YESLIM), and their content
must be carried. You are the one writer of the disposition table for this milestone's waves 2 and 3 while you run: make the move in
`tools/fs131_k1_make_dispositions.py` (YESLIM's wave 3 → 2), regenerate `data/fs131/k1/dispositions.csv`, run `tools/fs131_k1_dispositions.py`
green, and commit both on `main` from the main tree at your first stage — a table file, no Lean, so it does not touch `main`'s gate. Each row's statement is
quoted, with its errata and merge notes, in `plans/LEAN-BACKLOG.md` at the row's heading; the CSV's reason column names any ruling that changes it.
The definitions behind each statement are in its derivation file, at the address the backlog gives. The opening plan's rule for how every row is
stated:

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md § 7.3 What each wave's planning job must hold

Read all six items of that section; they are this job's checklist.

## Done means

1. **Wave 2's foundation** (the opening plan § 7.1's row for wave 2: covers `AeCover k`, `IsMaximalCover`, `µ_k(ε)` with band-properness, tile and
   periodic forms, upper density, tight and slack, essential multicolour, saturated, stationary families, `χ_CP`), sorry-free, with a spec example
   per definition and a named inhabitant per structure a theorem takes as a hypothesis, and one fresh `debruijn-domain-modeling` pass over it.
2. **The outside theorems wave 2 needs**, each decided and recorded with its reason: Krylov–Bogolyubov for `ℤ²`, de Bruijn–Erdős, Banach–Alaoglu,
   `[Falconer1981]` Lemma 1, and the supporting lemma N-EASY (row 130's free half). Formalized when under about an hour of agent work (and when
   unsure, formalize); otherwise an `axiom` with the four items of `LEAN.md` § Assumptions, or a separate job you name. N-EASY's consumer is FS116-O1-YESLIM, now in this wave. Our own hand results never
   enter as axioms.
3. **The skeleton**: every row of wave 2 in Lean with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only the
   `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated on the branch.
4. **Your record**, `plans/FS131-w2-kernel-plan.md` on the branch, in the opening plan's § 6 form: the read-back of each formal statement against its
   row, a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named children, what is hard), and a § "Where it is, and how the implementer
   works" written as the implementer's handoff (it may copy the opening plan's § 6.1 and change what differs). Stages headed "Stage n — SAVED";
   "Theorems this phase proved" (usually none).
5. The report, in standing rule 11's form.

## What is yours to decide

The representation of the foundation, the module layout, the order of the rows, and every formalize-or-import decision above. If a row cannot be
stated without a hypothesis its derivation hid, or a term is never fixed (the opening plan § 7.3 item 2 names where it expects these), that is a
finding: message me at once. A widening the kernel allows is a generalization: message me at once as well, because later work may build on the
narrower form. If wave 2 turns out to need something from wave 3's rows (arc maps and fragments, planned beside you), say so and stop that leaf;
the opening plan says the two waves are independent, and a dependency would be a finding about it.

## Stages

1. **The readback**: check the two quotations above against their sources; restate your rows and the outside theorems in your record. Confirm the
   worktree builds as given (one `./scripts/build.sh` run under the slot). Commit on the branch and push it (`git push -u origin fs131-w2`).
2. **The foundation**, sorry-free, validated, building. Commit.
3. **The outside theorems' decisions**, and any formalized here. Commit.
4. **The skeleton**, the read-backs, and the per-leaf plans (`debruijn-obligation-modeling` invoked fresh). Commit, and message me the commit.
5. **The handoff section**, then report.

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2`, branch `fs131-w2` at `3358a401` (wave 1's skeleton), with
  `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy, made by the project's recipe (`plans/FS131-kernel-plan.md` § 6.1).
  Never replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
  BATCH=4 ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once — the slot's ledger admits jobs up
  to a 90 GB total and makes a third wait (`plans/FS131-close-inventory.md` ruling 5). On exit 75, wait ten minutes and retry. `lake env lean <file>`
  is for iteration only, never evidence that a module is green.
- **Nothing with a `sorry` reaches `main`** (the opening plan § 7.5): your foundation and skeleton stay on `fs131-w2` and land with the wave, after
  its implementer's gate. Do not merge into `main`.
