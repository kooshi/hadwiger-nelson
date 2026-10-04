# Brief FS131-QA2 — impossible assumptions: an audit of every hypothesis the backlog's Lean takes, for a real instance that satisfies it

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-QA2
  identity: de Bruijn, the Lean 4 engineer — your agent file (`.claude/agents/debruijn.md`) is your identity and its standard of evidence is yours; this is an audit job, not a planning job, so the planning workflow's stages do not apply — § Done means gives this job's own
  role: find every hypothesis in the backlog's Lean that no real instance satisfies, or that only a degenerate model satisfies — across `main` and every open branch — and read wave 4's skeleton statements against their rows; report plainly, with the fix and who should make it
  launch: now, in a special-purpose slot Kooshi authorized for this audit, beside three running jobs (wave 2's implementer, Woodall's planner, the `localSectors` landing), none of whose files you touch
  mission: § Why this job
  statements: § What is audited
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job at once for any hypothesis you find unsatisfiable on real instances, or any statement that says less or other than its row; the report goes to `data/fs131/reports/FS131-QA2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all) and `CLAUDE.md` § The standard of evidence above rung B
  record: `plans/FS131-QA2-audit.md`
  touches: `plans/FS131-QA2-audit.md`, `data/fs131/qa2/`, `tools/fs131_qa2_*.py`, `data/fs131/reports/FS131-QA2.md`, and scratch under `/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/qa2/`; **read-only everywhere else** — no edit to any `Proofs/` file, any worktree, or any branch
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. Today the Lean check found its worst kind of flaw: a definition no real map can satisfy. Woodall's normal form was stated as a condition on *every*
picture of a point, and the Lean picture admits invisible zero-width sectors, so the condition failed wherever two colours meet. Every theorem assuming it
was empty, the gate stayed green, and the only example anyone had supplied was a one-colour map where the condition says nothing. A deriver found it; the
definitions are repaired. Kooshi asked for an audit that looks for the rest of this class before implementers build on it.

## Why this job

The vacuity scan (`LEAN.md` § The gate) catches a "for all" over an empty *type*, and skips theorems concluding `False` — refutations — by design. It cannot
see a Prop-valued hypothesis that is unsatisfiable on real instances. The finding that started this:

> 158. **Statement defect — definitions: `WoodallMerged` and `WoodallNormal` are unsatisfiable on every valid plane map; `exists_woodallMerged` is false at
> — source: plans/FS131-close-inventory.md

(the item continues there). The rule written from it:

> inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a
> — source: LEAN.md

## What is audited

The request, verbatim:

> 165. **Kooshi, 2026-10-04 (verbatim)**: *"Ok, I'm caught up. Yes, run the impossible assumption audit. And thank you and all the agents for your excellent work.
> — source: plans/FS131-close-inventory.md

The code: `main` (waves 1 and 3 landed, Lebesgue's covering theorem, the axiom gate's repair); `fs131-w2` (wave 2), `fs131-w4` (wave 4's skeleton and 32
proofs), `fs131-ww` (Woodall's chain, repaired on E3's NiceAt forms at `89a4aad0`), `fs131-w3b` (`localSectors`, about to land). Read them by `git show
<branch>:<path>` or read-only from their worktrees under `.claude/worktrees/`. The rows are `plans/LEAN-BACKLOG.md` and the derivation files it cites; wave 4's
read-backs are its plan (`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2, 12.2). FS131-QA1's tools (`tools/fs131_qa1_decls.py`,
`tools/fs131_qa1_dupes.py`, `tools/fs131_qa1_quality.py`) list declarations; its record (`plans/FS131-QA1-audit.md`) is the first audit's, which read 22
statements and found the definitions free of traps of the empty-*type* kind.

## Done means

1. **The census**: every definition used as a hypothesis (a `def … : Prop`, a structure, a predicate on maps, colourings, points or fragments) in a theorem of
   the backlog's modules, with the theorems that assume it — refutation-shaped ones (concluding `False`) first, since the scan skips them. A table.
2. **For each, an instance that exercises every clause** — named in the library, or constructed in your scratch as a short Lean or exact check — or the
   finding that none exists. "Exercises" means the clause is not vacuous on it: a condition on points of two or more colours needs a map with such a point; a
   condition on every picture needs a point with more than one picture. A definition whose only inhabitants are degenerate is a finding even if it is
   satisfiable. A definition unsatisfiable on real instances — message me at once.
3. **Wave 4's skeleton statements read against their rows** (all of §§ 3.2, 7.2, 8.2 and 12.2's, as far as your context allows), the fidelity table in QA1's
   form: same / stronger / weaker (with what) / different. Wave 4's regularity clause (inventory item 142) is known; do not re-report it.
4. **The verdict, in plain words first**: how many hypotheses were checked, how many have real instances, every finding ranked with a concrete fix (an
   inhabitant to add, a definition to repair, a statement to restate) and who should make it.
5. Your record in stages headed "Stage n — SAVED", committed by explicit path; the report in standing rule 11's form. Stopping at a saved stage with the rest
   named is a good report.

## What is yours to decide

The order, the sample where the census is too large to finish (say how you chose), and the method for each instance (a Lean `example` in scratch, an exact
check, or a hand construction stated precisely). Read-only toward the code: a fix you find is a recommendation, routed through me.

## The machine

No build of the branches is needed; a scratch Lean check runs under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 -- <command>`)
against a worktree's built oleans read-only, never writing into an implementer's tree, and never `lake build`. You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
