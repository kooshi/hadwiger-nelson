# Brief FS131-QA3 — the definitions audit: every definition and statement clause of waves 4 and 5 read against its source, with an adversarial example each

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-QA3
  identity: de Bruijn, the Lean 4 engineer — your agent file (`.claude/agents/debruijn.md`) is your identity and its standard of evidence is yours; this is an audit job, not a planning job, so the planning workflow's stages do not apply — § Done means gives this job's own
  role: read every definition, and every clause of a stated theorem that restates a source in its own idiom, in waves 4 and 5's Lean against the source it formalizes; for each, try to build an instance the source excludes but the Lean admits (too weak), one the source admits but the Lean excludes or no instance at all (too strong), or a clause whose idiom changes its meaning; report each finding with its fix and who should make it
  launch: in the next of the four slots to free (Kooshi: no fifth slot), beside the three running jobs of that moment, none of whose files you touch
  mission: § Why this job
  statements: § What is audited
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job at once for each definition or clause you find faulty, with its counterexample; the report goes to `data/fs131/reports/FS131-QA3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all) and `CLAUDE.md` § The standard of evidence above rung B
  record: `plans/FS131-QA3-audit.md`
  touches: `plans/FS131-QA3-audit.md`, `data/fs131/qa3/`, `tools/fs131_qa3_*.py`, `data/fs131/reports/FS131-QA3.md`, and scratch under `/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/qa3/`; **read-only everywhere else** — no edit to any `Proofs/` file, any worktree, or any branch
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. The Lean backlog's implementers keep finding the same kind of fault in definitions the planners wrote: a definition, or a clause of a statement, that
does not say what its source says. Each was caught before anything reached `main`, and each cost an implementer a session built on it. Kooshi approved an
audit to find the rest before the next implementers build on them.

## Why this job

Kooshi approved it (his words are quoted in § What is audited). Today's instances, each with the counterexample that exposed it — a definition that dropped a clause its source states:

> 231. **FS131-I5 mid-job, a definition defect in KB's skeleton** (message 2026-10-04): `BaseCtx.retArcs_nested` (`Plane/ValidMap/BaseWalk`) cannot be proved by any
> — source: plans/FS131-close-inventory.md

a definition looser than its source:

> 241. **FS131-I5b mid-job, a definition defect in `MapGraph`** (message 2026-10-04): **`cvb_hole_disconnected` is false as written**, because Lean's `IsHoleOf` is weaker
> — source: plans/FS131-close-inventory.md

and a clause whose pointwise idiom changed a directional statement:

> 251. **FS131-IC5 mid-job, a statement defect in `stuck_structure`'s sides clause** (message 2026-10-04; `Contact.lean` on `fs131-w4c` at `addcfbf3`, l. 4065): the clause
> — source: plans/FS131-close-inventory.md

(each item continues there, with the ruling in the next). Earlier, Woodall's merged and normal forms were unsatisfiable on every valid plane map (item 158),
which the inhabitant rule now guards:

>   inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a
> — source: LEAN.md

The vacuity scan cannot see any of these: it catches a "for all" over an empty type, not a predicate that says less, more, or other than its source.

## What is audited

The approval, verbatim:

> 255. **Kooshi, 2026-10-04 (verbatim)**, on the definitions audit (interim report's one decision): *"That audit is approved, but no special slot. It must use one of the
> — source: plans/FS131-close-inventory.md

The code, read by `git show <branch>:<path>` or read-only from the worktrees under `.claude/worktrees/`: **wave 5 first** — branch `fs131-w5` (`Proofs/HadwigerNelson/Plane/ValidMap/` —
`Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`, `BaseWalk`, `BaseDense`), whose implementers have built least on it; **then wave 4's** — `fs131-w4`
(`Plane/ValidMap/Basic`, `Sectors`, `UnitArc`, `BaseSteps`, `Plane/SVMap`, `Plane/StuckChain`), `fs131-w4c` (`Contact`) and `fs131-w4m` (`Moves`, `Cone`, as far as
they exist). The sources are the rows (`plans/LEAN-BACKLOG.md`), the derivation and verification files they cite (`plans/FS110-*`, `plans/FS112-*`,
`plans/FS114-*`, `plans/FS129-*`, `plans/FS131-E4-derivation.md`), and the planners' read-backs (`.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md`
§§ 2.2, 3.2, 8.2; its merged base plan `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`; `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 2, 3.2,
7.2, 8.2, 12.2). **Known and ruled — do not re-report**: items 142, 158, 213/227 (`UnenclosedC`), 231/232 (`IsRetArc`), 241/242 (`IsHoleOf`, already handed to the
planar-infrastructure job), 251/252 (`stuck_structure`'s sides clause). FS131-QA1's tools (`tools/fs131_qa1_decls.py`, `tools/fs131_qa1_dupes.py`) list
declarations; FS131-QA2's record (`plans/FS131-QA2-audit.md`) is the impossible-assumption audit of waves 1–4 as they stood then — read it so as not to repeat it.

## Done means

1. **The census**: every definition (a `def … : Prop`, a structure, a predicate on maps, fragments, points, arcs or graphs) in the audited modules, and every
   clause of a stated theorem that restates a source sentence in a Lean idiom (pointwise for directional, set-level for pathwise, closure-level for boundary),
   each with its source address. A table.
2. **For each, the adversarial check**: an instance the Lean admits and the source excludes, one the source admits and the Lean excludes, or the finding that
   none exists, by reading and, where it helps, a short Lean `example` or exact check in your scratch. A definition with no non-degenerate instance is a
   finding. Each faulty one goes to me by message at once, with its counterexample stated precisely.
3. **The verdict, in plain words first**: how many items were checked, how many match their sources, every finding ranked by how much work rests on it, with a
   concrete fix (the definition or clause as it should read, quoted against its source) and who should make it — the branch's implementer, the planar job, or a
   deriver if the source itself is unclear.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; the report in standing rule 11's form. Stopping at a saved stage with the rest
   named is a good report.

## What is yours to decide

The order within each wave, the sample where the census is too large to finish (say how you chose — the definitions most theorems rest on first), and the
method for each check. Read-only toward the code: a fix you find is a recommendation, routed through me.

## The machine

No build of the branches is needed; a scratch Lean check runs under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 -- <command>`)
against a worktree's built oleans read-only, never writing into an implementer's tree, and never `lake build`. You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
