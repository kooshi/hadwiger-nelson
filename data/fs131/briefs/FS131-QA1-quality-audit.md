# Brief FS131-QA1 — the quality of the Lean written for the backlog so far: an audit

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-QA1
  identity: de Bruijn, the Lean 4 engineer — your agent file (`.claude/agents/debruijn.md`) is your identity and its standard of evidence is yours; this is an audit job, not a planning job, so the planning workflow's stages do not apply — § Done means gives this job's own
  role: audit the Lean the backlog milestone has written so far — wave 1 on `main`, waves 2, 3, 4 and Woodall's chain on their branches — for statement fidelity, trust, and code quality, and say plainly what it is like and what to fix, when
  launch: now, in a special-purpose slot Kooshi authorized for this audit, beside five running jobs (four implementers, each in its own worktree, and a deriver), none of whose files you touch
  mission: § Why this job
  statements: § What is audited
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job at once for anything that threatens correctness (a statement that says less or other than its row, a vacuous hypothesis, a trust leak); the report goes to `data/fs131/reports/FS131-QA1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full and `CLAUDE.md` § The standard of evidence above rung B
  record: `plans/FS131-QA1-audit.md`
  touches: `plans/FS131-QA1-audit.md`, `data/fs131/qa1/`, `tools/fs131_qa1_*.py`, `data/fs131/reports/FS131-QA1.md`, and scratch under `/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/qa1/`; **read-only everywhere else** — no edit to any `Proofs/` file, any worktree, or any branch
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k

Hello. The Lean backlog milestone (FS-131) turns this project's hand-derived results into kernel-checked ones, wave by wave. Since this morning about
thirty agents — planners on Opus, implementers mostly on Sonnet — have written roughly 30,000 lines of Lean across four branches, and wave 1 has landed.
The gates (`LEAN.md` § The gate) check that it builds, has no `sorry` where it claims none, rests on declared axioms, and that no theorem is a "for all"
over an empty domain. They do not check whether the code is good: whether each statement says what its row says, whether proofs are robust or brittle,
whether the same lemma is proved three times in three waves, whether a reader could follow it, whether it will merge cleanly and publish well. Kooshi
asked what the code is like, and authorized you to find out.

## Why this job

Nothing is published before it is formalized, and a formalization is judged first by whether its statements are the right ones (`CLAUDE.md` § The
standard of evidence above rung B). Implementers have already caught about ten statements that said less or other than their rows (inventory items
18–19, 34, 37, 39, 48, 57, 61, 63, 72, 77, 86, 100, 112, 134) — each a finding, each fixed. Whether more are hiding in statements no implementer has
reached yet is the question that matters most here; code quality is the second.

## What is audited

The request, verbatim:

> for the experiment."* — and: *"What does the general quality of the code look like so far? I'll authorize another special case auditor for what we've
> — source: plans/FS131-close-inventory.md

The standard every statement is held to:

> **Read the final statement aloud against the informal claim.** The one gate item no automation replaces, and the one that catches
> — source: CLAUDE.md § The standard of evidence above rung B

(the bullet continues: "proving the wrong theorem."). The code: wave 1 on `main` (landed, `d59ffcdf` and after); wave 2 on `fs131-w2`, wave 3 on
`fs131-w3`, wave 4 on `fs131-w4`, Woodall's chain on `fs131-ww` — read them with `git show <branch>:<path>` or read-only from their worktrees under
`.claude/worktrees/`, never writing there (implementers are working in them). The rows are `plans/LEAN-BACKLOG.md` (each with its errata and merge
notes) and the derivation files it cites; each wave's read-backs are in its plan (`.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md`, and the `-w3-` and `-w4-` plans in their
worktrees; `.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md`); the rulings that changed statements are the inventory items above.

## Done means

1. **Statement fidelity, sampled and stated as such.** Pick at least fifteen row theorems across the five bodies of code — proved ones first, and the
   central ones of each wave — and read each formal statement against its row and the derivation entry, unfolding every definition it uses down to
   Mathlib's: quantifiers, hypotheses (dropped, added, weakened), the carrier (could it be empty or trivial?), the conclusion, the metric and the plane's
   type. A table, one line per theorem: row, declaration, verdict (same / stronger / weaker — with what — / different). Say how you chose the sample.
2. **Definitions that rows rest on**, every one in each wave's foundation modules, read for traps of the kind that sink formalizations (a home-made
   notion that differs from the standard one, a structure that is accidentally empty, a coercion that changes meaning).
3. **Trust**: the declared import (`falconer_lemma2_nonempty`), the named hypotheses (`Row130M1`, `hR78`, `hR88`, `hR88per`, `Voronov11`) and every
   `axiom` in the branches — each used as declared, none silently assumed where a row claims more.
4. **Code quality**, measured where it can be: proof length outliers; brittle tactics (unbounded `simp`, `decide` on large terms, heavy `nlinarith`);
   duplication across waves (the same fact proved more than once — sector and distance lemmas are likely places); dead or WIP code; stale docstrings;
   linter workarounds (`have _ := h` and the like); naming against Mathlib's conventions; docstring coverage of public declarations; module sizes and
   structure against `ARCHITECTURE.md`; merge risk across branches (append-only files); anything that would embarrass the code in front of a Mathlib
   reviewer. Concrete instances with `path:line`.
5. **The verdict, in plain words first**: what the code is like, an honest overall grade with its reasons, then findings ranked — (A) correctness and
   fidelity risks; (B) trust; (C) debt worth fixing before each wave lands; (D) debt to fix before publication; (E) practices worth keeping — each with a
   concrete fix and who should make it (an implementer, a planner, or nobody yet). Credit what is good as plainly as what is not.
6. Your record in stages headed "Stage n — SAVED", committed by explicit path; the report in standing rule 11's form. Stopping at a saved stage with the
   rest named is a good report.

## What is yours to decide

The sample, the measurements, how deep to read, and the grade. Read-only toward the code: a fix you find is a recommendation, routed through me, never an
edit. If a finding would change a statement, message me at once; implementers are working on these files now and a ruling reaches them by me.

## The machine

No build is needed; if you measure anything heavy (compile time of a module, say), run it under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py
--mem 8 --cpus 4 -- <command>`) in your own scratch, never in an implementer's worktree, and never `lake build`. Builds' own logs are under each
worktree's `build/gate/build/`. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
