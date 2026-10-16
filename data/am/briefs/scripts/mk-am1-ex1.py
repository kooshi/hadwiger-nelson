exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# AM1-EX1: the generic workflow repository (W17) — the identities, the workflows, the gates, the brief tooling and the
# front-file forms of this project, extracted into a domain-independent template at ../agentic-mathematics.
# Usage: mk-am1-ex1.py
import subprocess,os
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
JOB="AM1-EX1"; DEST="/home/kooshi/source/agentic-mathematics"; FORGE="/home/kooshi/source/agent-forge"
fresh(JOB)
assert not os.path.exists(DEST), DEST+" exists"
assert sh("git","-C",FORGE,"diff","--stat","4bc0e1d","HEAD","--","identities/keryx/skills","identities/poros/skills","identities/ephodos/skills","identities/debruijn/skills")=="", "the identities moved"
R="data/am/REQUEST-2026-10-16.md"
WORDS=Q(R,"W17: ")+"\n"+Q(R,"**W17, read by Keryx")
b=f'''# Brief {JOB} — the generic workflow repository: this project's minds and method, for any problem

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: a general-purpose engineer on Opus — no identity file: the owner asked for a generic agent. You read this project's identities as source material; you do not become any of them
  role: extract this repository's coordinating workflow — the identities, each lane's workflow, the output-style setting, the gates, the brief tooling, the standing rules and the forms of the front files — into a new template repository, tied to no one problem, from which anyone can attack a mathematical problem of their own, with Lean as the kernel
  launch: now; one other job is running in this repository (a publication check in its own worktree), and nothing you do touches it
  mission: § Why this job
  statements: § Kooshi's words
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; § Never, below, is absolute
  channel: message the coordinator ("main") by SendMessage at once if a vendored identity holds anything personal or project-specific that the template cannot carry unchanged, if a design question would change what a lane does, or if you need a Lean build larger than § The machine allows; the report goes to `data/am/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (its rules on worktrees and branches apply to this repository; in the new one you are the only writer)
  record: `data/am/{JOB}-record.md` (new)
  touches: everything under `{DEST}` (new; create it); in this repository only `data/am/{JOB}-record.md` and `data/am/reports/{JOB}.md`, **written but not committed** (this repository's history is being copied for publication; I file both later). **Not** any other file of this repository, and nothing in `{FORGE}`
  budget: about 400k by the harness's count, as guidance; save a stage at each item of § Done means (a commit in the new repository and a line in your record); hand back at a saved stage before about 500k

Hello. This repository attacks one mathematical problem through a pipeline of minds: a coordinator (Keryx, the top-level
session) briefs an asker who poses and ranks questions (Poros), a deriver who derives the answers (Ephodos), and a Lean
engineer who plans and builds each result in the kernel (de Bruijn, planner and implementer), with a daily Searcher and a
Clerk who files. A milestone closes only when its Lean module passes the gate. The owner wants that method — not the
problem — published as its own repository, so that anyone can open it in Claude Code and attack a problem of their own
with the same rigour. You build that repository.

## Why this job

The method is the owner's: he built the identities (forged in `{FORGE}`) and the skill suite, derived from his earlier
identity Ferrous, which is public at `https://github.com/kooshi/rusty-tools-mcp` (MIT/Apache); the workflow beneath each
identity grew in this repository. The template is what a stranger gets: it must work from a fresh clone, say nothing about
this problem except as a clearly marked example, and say nothing personal about the owner.

## Kooshi's words

{WORDS}
## The sources (read-only)

- **The identities**, byte-identical copies of `{FORGE}/identities/*/skills/` at agent-forge commit `4bc0e1d`, unchanged
  in its later commits: `.claude/skills/keryx/`, `.claude/skills/poros/` and its two companions, `.claude/skills/ephodos/`
  and its three, `.claude/skills/debruijn/` and its five, each with its gate scripts. Vendor them unchanged; never edit one.
- **The project's own identities and lanes**: `.claude/agents/poros.md`, `.claude/agents/ephodos.md`,
  `.claude/agents/ephodos-verifier.md`, `.claude/agents/debruijn.md`, `.claude/agents/debruijn-implementer.md`,
  `.claude/agents/searcher.md`, `.claude/agents/clerk.md`; the coordinator's output style `.claude/output-styles/keryx.md`;
  `.claude/settings.json`; `.claude/skills/grokkings/SKILL.md` (its form, not its entries).
- **The owner's user skills** that the coordinator's core loads: `~/.claude/skills/decompress/` and
  `~/.claude/skills/peer-delegation/`. Vendor them as project skills.
- **The shared context and its rules**: `CLAUDE.md` (its structure, its rules on current state, budgets, one home per fact,
  protected paragraphs, notation, grades, the standard of evidence, delegation one level deep, the pipeline map, the stub
  rule, conventions — none of its mathematics), `WORKFLOW.md`, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md`
  (§ Building and § Make the gate fail, and watch it fail).
- **The tooling**: `scripts/identities.py`, `scripts/slot.py`, `scripts/build.sh`, `scripts/axioms.sh`,
  `scripts/Axioms.lean`, `scripts/gate_report.py`, `scripts/assumptions.sh`, the vacuity scan (`scripts/vacuity.sh` and
  its Lean file), `scripts/lean4checker.sh`, `data/workflow3/brief_quote.py`, `data/fs131/briefs/scripts/mkbrief.py`,
  `tools/claude_md_fact_audit.py`, `tools/bib_audit.py`, `tools/check_architecture.py`, `install-toolchain.sh`,
  `lakefile.toml`, `lean-toolchain`, `lake-manifest.json`.
- **The forms of the front files**, read for their shape only: `LEDGER.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`,
  `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `plans/SEARCH-QUEUE.md`, one stub (`plans/STUB-*.md`), one
  close inventory, one derivation file, one handoff, one claim list, one brief and its generator.

**Not to carry:** the Rust identity and its engineer (`.claude/skills/ferrous-*`, `.claude/agents/ferrous-engineer.md`):
another project's, credited only; `.claude/settings.local.json`; the auto-memory; any of this problem's mathematics,
results, rows, milestone numbers, file names or history, except one short, clearly marked worked example in the README
that names this project as where the method was built, its public link left as a placeholder `<lean-dir public URL>`.

## Done means

1. **Readback** (a saved stage): the quotations checked against their source; in your record, an inventory of what you
   carry — each source, what it becomes in the template, and what is left behind and why.
2. **The skeleton** (a saved stage): `{DEST}` a git repository (`git init`, branch `main`, no remote), laid out as a
   Claude Code project a stranger opens and runs:
   - `.claude/settings.json` selecting the coordinator's output style, capping delegation at one level, setting `TZ` to
     `UTC`, and hiding the identity cores from the skill list as this repository does;
   - `.claude/output-styles/keryx.md`: the coordinator's core verbatim, then the workflow beneath it made generic;
   - `.claude/agents/*.md` for the seven lanes, each with its identity's text unchanged and its workflow made generic;
   - `.claude/skills/`: the vendored identities, the two user skills, and a grokkings file with its form and no entries;
   - a `CLAUDE.md` template: every workflow rule of this repository's `CLAUDE.md`, made generic, with marked places for the
     principal's problem, aim, notation and counter-priors;
   - the front files as forms (`LEDGER.md`, `LEAN.md`, `RUNNING.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`; in `plans/`
     the standing rules, the ranked stub list and templates for a stub, a claim list, a close inventory, a derivation file
     and a handoff), and a folder for briefs with the brief helper and the quotation filler.
3. **The kernel** (a saved stage): a Lean package at this repository's pin (Lean and Mathlib v4.32.0), one example module
   with one theorem and its spec example, and the gate made generic: the build script, the axiom audit, the zero-`sorry`
   check, the vacuity scan, the gate report; `scripts/identities.py` reworked so that `check` holds the vendored
   identities to a recorded manifest of hashes, and `sync` copies from a forge path when one is given.
4. **The controls** (a saved stage): each identity gate's self-test run from its skill directory in the new repository
   (the coordinator's `scripts/brief_gate.py all scripts/example-brief.md`, the deriver's `scripts/derive_gate.py all
   scripts/example-clean.md scripts/example-verification.md scripts/example-invention.md`, the asker's
   `scripts/poros_gate.py all scripts/example-clean.md`) exits 0, and each dirty example exits non-zero; `identities.py
   check` passes, and fails on a planted one-byte change; the fact audit and the bibliography audit run on the template's
   files; the gate scripts parse. The Lean build only as § The machine allows.
5. **The front page** (a saved stage): `README.md` for a stranger: what the method is and why it is shaped this way; the
   minds and what each hands on; a milestone's states; what the gates check; how to start (install Lean and Claude Code,
   clone, open, write the problem into `CLAUDE.md`, ask the coordinator to open the first milestone); what it costs to run;
   the credit; the worked example. A `LICENSE` (Apache-2.0, this repository's, by default). Then read the whole repository
   once as a stranger would, and fix what does not stand alone.
6. **The report** in the standing rules' form: what the template holds; every place you changed a lane's workflow in
   substance, not only in its nouns; every `CHECK:`.

## What is yours to decide

The layout, the names of the template's folders, how much of each workflow is generic and how much becomes a marked
placeholder, the README's words, and how the identity check records its manifest. Where this repository's method is
specific to its problem in a way that would mislead elsewhere, change it and say so. If the owner's request, read as
above, looks wrong to you, say so: that is a finding. Not yours: any file of this repository beyond your record and
report, anything in `{FORGE}`, the licence beyond the default, a remote or a push.

## Never

- Never write anything personal about the owner into the new repository beyond the name and GitHub handle in the credit
  line and the Ferrous link: no other name, contact detail, place, time of day, machine, account, correspondence, or
  project of his. Never write a home-directory path, a claude.ai link or a session identifier into it, or this project's
  commit hashes. The sources hold such details; carry none of them. I will scan the new repository before it goes out.
- Never commit in this repository, and never edit `{FORGE}`.
- Never add a remote to the new repository, and never push.
- Never open `.env`, any auth.json file, any keyring or any credentials file.

## The machine

Laptop, 12 cores, 31 GB; the publication check is using the cores now. Your work is files. At most one Lean build of the
example module, under the memory tool, after symlinking this repository's `.lake/packages` into the new one:
`python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 3600 --name am1 -- <command>`; never
`lake build` bare, never a Mathlib rebuild, never `lake update`. Remove the symlink before your last commit and say in
the README how a user gets Mathlib. Commit in the new repository with `TZ=UTC`; end each message with the two lines
`Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>` and
`Claude-Session: https://claude.ai/code/session_014h1tdD6Jb5oiuqxayiSiSW` (the owner keeps session links in commit messages,
as in this repository; § Never's rule on links is about files).

{NOSPAWN}
'''
open(ROOT+f"data/am/briefs/{JOB}-extract.md","w").write(b); print("ok",len(b))
