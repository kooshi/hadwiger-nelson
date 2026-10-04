# Brief FS131-K3 — wave 3 of the Lean backlog: plan its foundation and skeleton (arc maps and fragments: tiles, the ring, germs, change points, (Q))

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K3
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 3's kernel module — its foundation sorry-free, its 20 rows as a skeleton with `sorry` at every leaf, each read back against its row, a plan per leaf
  launch: now, beside FS131-I1 (wave 1's implementer, in its own worktree) and FS131-K2 (wave 2's planner, in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w3-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/Tiles`, `Plane/RingGerm`, `Plane/RingBand`, `Plane/Lens`, `Plane/SixFragment`; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w3-kernel-plan.md`, `tools/fs131_k3_*.py`, `data/fs131/k3/`, `data/fs131/reports/FS131-K3.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are planning the third wave of the milestone that turns this project's hand-derived results into kernel-checked ones. The opening
job (FS131-K1, de Bruijn on Opus, like you) gave every one of the 259 backlog rows a disposition, put a shared foundation on `main` (among it
`ArcMap`, one structure for valid maps and fragments, with `Siamese` and `Simple` as predicates), wrote wave 1's skeleton, and planned waves 2–10.
Its plan, `plans/FS131-kernel-plan.md`, is your starting point: read §§ 4–7 in full, and § 5 (the foundation) and § 6 (wave 1) as the model your work
should match. Wave 3 is the first wave of the local geometry the frontier now works in — tiles, the ring of colours around a vertex, germs, change
points, (Q) arcs — with Siamese pairs allowed. Waves 4 to 9 all stand on the vocabulary you fix here, which is why the definitions matter more
than any one leaf.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate; this milestone formalizes the hand results the milestones before
it left on paper. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

Wave 3 plans while wave 1 is being implemented and wave 2 is planned beside it, so the milestone pipelines: your skeleton is built on wave 1's
statements as they stand frozen in its skeleton (commit `3358a401`), not on its proofs.

## The statements

Your rows are the 20 rows of `data/fs131/k1/dispositions.csv` with wave 3 and disposition *formalize*, less FS116-O1-YESLIM, which moved to wave 2
(inventory ruling 6; wave 2's planner updates the table): FS116-N1-GERM-R, FS116-N1-TWIST-D, FS116-N1-ECHO, FS116-N1-GERM-S, FS116-N1-QFREE4,
FS116-N2-FIVERING, FS116-RING-Q-PRIME-S, FS116-S1-CLUSTER, FS116-S1-EXIT, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-TWIST, FS116-V5-NE1,
FS116-V5-U1, FS116-Y2-SIXFRAG, FS116-Y4-FLANK, FS129-OR1-WHOLE, FS129-SR1-RINGBAND, FS129-SR1-SIXQ, FS129-SR2-TOUCHW. Four more rows merge into them
(FS116-N1-TOUCH into FS129-SR2-TOUCHW, FS116-RING-Q-PRIME into FS116-RING-Q-PRIME-S, FS110-N2-RING and FS110-Y3-GP into FS129-SR1-RINGBAND), and their
content must be carried; FS129-SR1-RINGBAND carries caution C137 (it omits FS129-OA1-RINGWIND's periodicity clauses — read the caution in
`plans/LEAN-BACKLOG.md` § Cautions). Each row's statement is quoted, with its errata and merge notes, in `plans/LEAN-BACKLOG.md` at the row's heading;
the CSV's reason column names any ruling that changes it. The definitions behind each statement are in its derivation file (most in
`plans/FS116-derivation.md` and the claim list it cites, `data/fs116/claims.md`), at the address the backlog gives. The opening plan's rule for how
every row is stated:

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md § 7.3 What each wave's planning job must hold

Read all six items of that section; they are this job's checklist. Item 2 names where this wave's statement defects are likeliest: "germ" and
"change point" at a point of `Γ ∩ ω(p)` where `Γ` crosses `ω(p)` transversally. Item 5 names FS116-Y2-SIXFRAG, one of your rows, as one of the
milestone's inhabitants: schedule it before the lemmas whose vacuity check needs it.

## Done means

1. **Wave 3's foundation** (the opening plan § 7.1's row for wave 3: `isOpen_interiorPts`; arcs of `Γ` on `ω(p)` with constant sides and their inner
   and outer colours; (Q) at a ring; germs `u±`, `v±`, change points, hubs; the circle colouring of RINGBAND), sorry-free, with a spec example per
   definition and a named inhabitant per structure a theorem takes as a hypothesis, and one fresh `debruijn-domain-modeling` pass over it. Where a
   derivation never fixed a definition the rows' words need, write the definition you chose, the alternatives, and which rows each would change —
   and message me if the choice changes what a row says.
2. **The skeleton**: every row of wave 3 in Lean with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only the
   `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated on the branch.
3. **Your record**, `plans/FS131-w3-kernel-plan.md` on the branch, in the opening plan's § 6 form: the read-back of each formal statement against its
   row, a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named children, what is hard), and a § "Where it is, and how the implementer
   works" written as the implementer's handoff (it may copy the opening plan's § 6.1 and change what differs). Stages headed "Stage n — SAVED";
   "Theorems this phase proved" (usually none).
4. The report, in standing rule 11's form.

## What is yours to decide

The representation of the local geometry, the module layout, the order of the rows, and any outside theorem (the opening plan expects none here;
if one appears, formalize it when under about an hour of agent work, else an `axiom` with the four items of `LEAN.md` § Assumptions — never one of
our own hand results). If a row cannot be stated without a hypothesis its derivation hid, or a term is never fixed, that is a finding: message me
at once. A widening the kernel allows is a generalization: message me at once as well. If wave 3 turns out to need something from wave 2's rows
(measurable colourings, planned beside you), say so and stop that leaf: the two waves are meant to be independent, and a dependency would be a
finding about the plan.

## Stages

1. **The readback**: check the two quotations above against their sources; restate your rows in your record. Confirm the worktree builds as given
   (one `./scripts/build.sh` run under the slot). Commit on the branch and push it (`git push -u origin fs131-w3`).
2. **The foundation**, sorry-free, validated, building, with the definitions' choices recorded. Commit.
3. **The skeleton**, the read-backs, and the per-leaf plans (`debruijn-obligation-modeling` invoked fresh). Commit, and message me the commit.
4. **The handoff section**, then report.

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3`, branch `fs131-w3` at `3358a401` (wave 1's skeleton), with
  `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy, made by the project's recipe (`plans/FS131-kernel-plan.md` § 6.1).
  Never replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
  BATCH=4 ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once — the slot's ledger admits jobs up
  to a 90 GB total and makes a third wait (`plans/FS131-close-inventory.md` ruling 5). On exit 75, wait ten minutes and retry. `lake env lean <file>`
  is for iteration only, never evidence that a module is green.
- **Nothing with a `sorry` reaches `main`** (the opening plan § 7.5): your foundation and skeleton stay on `fs131-w3` and land with the wave, after
  its implementer's gate. Do not merge into `main`, and do not edit `data/fs131/k1/dispositions.csv` (wave 2's planner is its writer while you run).
