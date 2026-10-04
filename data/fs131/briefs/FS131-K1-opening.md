# Brief FS131-K1 — the Lean backlog's opening: the kernel reframe, a disposition for every row, the foundation, and wave 1's skeleton

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; its § A kernel milestone is this job
  role: open a kernel milestone — the reframe (§G, §PA), a disposition for each of the backlog's 259 rows, the foundation's definitions, wave 1's skeleton with a plan per leaf, and the plan for the waves after it
  launch: now, alone; the implementer for wave 1 launches when your wave-1 skeleton is committed (stage 6), while you write stage 7
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — ruling 1 of the milestone's inventory (`plans/FS131-close-inventory.md` § Rulings in force): no phase-1 fence in this milestone; read the derivation files from the start
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, the stage-6 commit, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-kernel-plan.md`
  touches: `plans/FS131-kernel-plan.md`, `data/fs131/k1/`, `tools/fs131_k1_*.py`, new modules under `Proofs/HadwigerNelson/` (the directory is yours to choose), `Proofs.lean` (import lines only), `ARCHITECTURE.md` (the module map, for the modules you add), `scripts/Axioms.lean` (records for your modules only), `data/fs131/reports/FS131-K1.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are opening the milestone that turns this project's hand-derived results into kernel-checked ones. Since Workflow 3.1 a milestone
closes only when its Lean module passes the gate; the milestones closed before that left their results proved on paper only, and this one
formalizes them — 259 rows, with the audit's merged forms — so that every result the frontier builds on is held in the kernel or named as an
explicit hypothesis. You plan; a Sonnet implementer (`.claude/agents/debruijn-implementer.md`) builds from your skeleton and plan, wave by wave.
The plan you write is the contract every later job works from, so the shape of the foundation matters more than any single leaf.

## Why this job

Kooshi set this milestone when he moved the workflow to kernel closes:

> We will of course need to handle the backlog of lean work before we can continue forward with this. We'll handle that in a dedicated session after the cross audit.
> — source: plans/STUB-lean-backlog.md § The request (Kooshi, verbatim)

And on how to price it:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The milestone's stub, `plans/STUB-lean-backlog.md`, holds the rest of the context (what it works from, the held items, the related stubs FS-101
and FS-113, and a provisional bearing that your opening rewrites). Read it first.

## The statements

The claim list is `plans/LEAN-BACKLOG.md` (ruling 2 of the inventory): 259 rows, every statement, grade, handoff, erratum and merge line quoted
by script (`tools/fs129_l1_backlog.py`, whose `--check` re-reads the file against its sources) from the derivation files, `plans/*-derivation.md`.
Its sections: § The order (178 rows, dependencies first), § FS-129's compositions (32 merged forms), § Left the order (26), and a closing section
(23, among them the eight inputs of ledger row 121, χ(ℚ(√47)²) = 5). Read its § How to read this file and § Cautions first; the cautions change
what is formalized (C109: three FS89 rows false as written; C116: seven rows whose errata govern; C126 and C131: keep V6-HUG's colour step; C137: two
merged forms that omit a clause of their source; C13: three conditional seeds; C139: verifier records named for promotion). The file is about
456 KB; reading it whole at once costs about a quarter of your budget, so extract what you need by script (ids, sections, statements, merge notes)
and read rows by address.

Two of the file's own reading rules decide which text of a row is the one to formalize:

> - **Dated notes**: every paragraph filed under an entry that begins *Erratum*, *Errata* or *Correction*, every banner *Correction owed* directly above it, and every numbered item of a `## Errata` section whose bold lead names it, is quoted under its statement, with its address. Where such a note and the entry differ, the note governs (plans/FS112-derivation.md's own rule for its section).
> — source: plans/LEAN-BACKLOG.md § How to read this file

> - **Never formalized as filed**: the twelve superseded entries of `plans/FS129-derivation.md` have no row; § FS-129's compositions lists each with its superseding form.
> — source: plans/LEAN-BACKLOG.md § How to read this file

The definitions of a row's terms are in its derivation file, at the address the row gives; nothing is fenced.

## Done means

The milestone's inventory fixes what "Closed" means, written before you launched:

> 1. **Every one of the 259 rows of `plans/LEAN-BACKLOG.md` has one disposition**, recorded in the plan with its reason:
> — source: plans/FS131-close-inventory.md § What "Closed" means here (written before any job launched)

— and the four dispositions are listed under it there: *formalize* (in its merged form, else in the form its errata and cautions govern),
*merged into* another row, *excluded* (an empty class the audit named, a superseded form, or a statement shown false), *outside theorem* (an
`axiom` with the four items of `LEAN.md` § Assumptions). Read the whole section, and its announcement rule beneath it. Your job delivers:

1. **`plans/FS131-kernel-plan.md`**, your record, in stages headed "Stage n — SAVED", with the heading "Theorems this phase proved" (a planning job
   usually proves none; say so), holding §G, §PA, the dispositions' summary, the foundation's model, wave 1's per-leaf plans, and the waves after.
2. **`data/fs131/k1/dispositions.csv`**: one line per row of the backlog — id, section, disposition, the row it merges into (if any), wave, module,
   and the reason with its address where the disposition differs from the backlog's own merge note or caution. With **`tools/fs131_k1_dispositions.py`**,
   which confirms that every row id of the backlog appears exactly once, that every *merged into* target is a *formalize* row, that every
   *excluded* row cites its reason, and that every row's upstream ids sit in an earlier or the same wave; its `--self-test` plants one fault of each
   kind and watches it fire.
3. **The foundation**: the shared objects the rows are stated over, as Lean definitions in skeleton modules, elaborating through `./scripts/build.sh`,
   each with an `#eval` or `example` that would fail if it drifted and, for each structure a theorem takes as a hypothesis, a named inhabitant; the
   modules in `ARCHITECTURE.md`'s map in the same commit.
4. **Wave 1's skeleton**: every statement of wave 1 in Lean with `sorry` at every leaf, each read back against its row's statement in the plan (the
   read-back is the gate item no automation replaces), and a plan per leaf — its route, the Mathlib lemmas it uses (each confirmed with `#check`), its
   named children, and what is hard.
5. **The plan for the waves after wave 1**: per wave, its rows, its modules, the outside theorems it needs, and what its planning job must hold.
6. The report, in standing rule 11's form.

## What is yours to decide

Nearly everything about the formalization: the waves (the stub expects them along the order's layers), the module layout, the representation of
the foundation, which outside theorems are formalized here (under about an hour of agent work, and when unsure, formalize) and which enter as
axioms or as a separate planning job, and whether this milestone absorbs FS-101 (`plans/STUB-main-clause-five-kernel.md`) or FS-113
(`plans/STUB-mr-in-lean.md`). Our own hand results that a declaration needs before their row lands enter as explicit hypotheses, never as axioms
(`LEAN.md` § Assumptions).

Dispositions that need a ruling — say each in the plan with its reason, and I rule and log it: the three conditional seeds (caution C13); any of
the eight seeds the audit excluded as empty that you would formalize after all (`plans/FS129-close-inventory.md` item 156 (i) allows it with a
reason; the emptiness itself may be worth a theorem); any row of § Left the order you would not formalize (the inventory's ruling 3 makes
*formalize* their default); and any row whose statement you would change.

One design question I cannot answer for you: a skeleton with `sorry` committed on `main` leaves the gate red until its implementer lands it, and
other milestones will run beside this one. Say how you keep `main`'s gate meaningful between waves (a branch per wave, modules kept out of the
import surface until they land, or something better).

And attack the framing: if a row cannot be stated without a hypothesis the derivation hid, or a term is never defined, or a merged form is the
wrong statement, that is a finding — message me at once, because Ephodos may later build on the narrower form.

## Stages

1. **The readback** (standing rule 3): check the five quotations above against their sources and log the result; restate in your own words what
   "Closed" means here and the four dispositions. **Register your expectations before reading the derivations closely**, each with a probability
   where one applies: how many statement defects the kernel will find among the 210 rows of § The order and § FS-129's compositions; which outside
   theorems will enter as axioms; how many waves. Commit.
2. **§G**: grep `.claude/skills/grokkings/SKILL.md` for the entries about the kernel, the gate and the cost model, read each by number, and say
   what each changes in this plan; and survey what this library already holds that the rows reuse (`ARCHITECTURE.md`, `Proofs/HadwigerNelson/`).
   Commit.
3. **§PA**: Mathlib's coverage of the objects the rows are stated over (the Euclidean plane, circles and arcs, Lebesgue measure and density points,
   measurable colourings, compactness of colourings, planar maps), grepped by the statement's shape; any formalization in print; and for each
   outside theorem the rows rest on, formalize, axiom, or separate job, with its reason. Commit.
4. **The dispositions**: `data/fs131/k1/dispositions.csv` and its checker, green, with the self-test watched; the summary and the ruling list in the
   plan. Commit, and message me the ruling list.
5. **The foundation** (`debruijn-domain-modeling`, invoked fresh): the definitions, validated, building. Commit.
6. **Wave 1's skeleton** (`debruijn-obligation-modeling`, invoked fresh; `debruijn-experience-modeling` if the module crosses a consumer boundary):
   the statements, the read-backs, the per-leaf plans. Commit, and **message me the commit**, so wave 1's implementer can launch while you go on.
7. **The waves after wave 1**, and the answer to the design question above. Commit, then report.

Any generalization, shorter route, statement defect or missing lemma goes to me by message the moment you find it (your agent file § What leaves
your lane at once), not only in the report.

## The machine

You run alone in the main tree; no worktree is needed. Builds only through `./scripts/build.sh` under `scripts/slot.py` (`LEAN.md` § Building;
never `lake build`); `lake env lean <file>` for iteration only, and never as evidence a module is green. One Lean build at a time on this machine.
