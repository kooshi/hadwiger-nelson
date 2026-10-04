# FS-131 — the Lean backlog: the hand results this project derived, formalized in the kernel, each once and in its strongest form (stub; a special case)

*Filed 2026-10-03 by Keryx, the coordinator, at Kooshi's word, as a **special case** like FS-129: it is not ranked among the stubs, and it runs next,
in a session of its own. This file holds the request verbatim and the context a fresh session needs to open it; its plan is de Bruijn's opening
job (a kernel milestone, `.claude/agents/debruijn.md` § A kernel milestone), and its bearing on the answer is provisional until that opening.*

## The request (Kooshi, verbatim)

On Workflow 3.1 (2026-10-03, quoted in `plans/WORKFLOW3-lane-edits-proposed.md`):

> We will of course need to handle the backlog of lean work before we can continue forward with this. We'll handle that in a dedicated session after the cross audit.

On the audit's method (2026-10-03, his decision 3, `plans/FS129-cross-application-audit.md` § 1): "3. yes, excellent idea." — answering whether
the audit should prepare the backlog's input, so that the backlog formalizes each statement once, in its strong form.

On FS-129's Derived filing (2026-10-03, night): "Next up, the backlog. I'll start a new session for it. Please make sure everything is in order."

The standing words that govern it are in `CLAUDE.md`: § Counter-priors (on Lean: *"Do not consider Lean formalization a cost. It's practically
mechanical for us, it's just a matter of time."*), § Publication (*"for milestones, we can trust the literature"*; the three axioms preferred
*"if it's just a week or so of agentic work"*), and `LEAN.md` § Assumptions (an outside theorem over about an hour of agent work may enter as an
`axiom` with four items; our own hand results enter as explicit hypotheses, never as axioms).

## What it is (the coordinator's reading; de Bruijn's opening replaces it)

Workflow 3.1 closes a milestone only when its Lean module passes the gate; the milestones closed before it left their hand results unformalized.
This milestone formalizes them, and with them FS-129's compositions, so that every [hand] result the project builds on is either held in the
kernel or named as an explicit hypothesis. **FS-129 is Closed when its compositions pass the gate here** (`plans/FS129-close-inventory.md` item 4).

## What it works from

- **The input: `plans/LEAN-BACKLOG.md`** (built by FS129-L1 with `tools/fs129_l1_backlog.py`; 259 rows). Read its § How to read this file and its
  § Cautions first. § The order (178 rows, each after what it rests on: 75 seeds whose `handoff:` names de Bruijn, 3 conditional seeds, 100 upstream
  entries), § FS-129's compositions (32 merged forms), § Left the order (26 rows that left only because no seed rests on them — not because they
  lack value), and a closing section of 23 (among them the eight J45 statements under row 121, χ(ℚ(√47)²) = 5, and the FS89 rows under caution
  C109). Every statement there is quoted by script from its derivation file, with its errata.
- **The cautions that change what is formalized** (each attached to its rows in the backlog): merged forms in place of the statements they merge;
  15 results not to formalize as stated (their hypotheses describe an empty class, `plans/FS129-SR1-audit.md` § Stage 5), 8 of them seeds; seven
  entries whose errata the index cannot see; DOUBLETIP is not to replace V6-HUG's colour step (or EMPTY-NS is lost); FS89-S0A-2 is unprovable as
  written. The rulings on them are `plans/FS129-close-inventory.md` items 116, 126, 131, 137, 139, 156.
- **The derivation files**, `plans/*-derivation.md` (now 1,355 entries); `plans/FS129-derivation.md` (44 entries); `LEDGER.md` (rows 1–154), whose rows
  are regraded to [kernel] as their modules land.
- **The kernel and its rules**: `LEAN.md` (§ The gate; § The kernel's cost model; § Assumptions; § The package; builds only through
  `./scripts/build.sh` under `scripts/slot.py`, never `lake build`), `ARCHITECTURE.md`, `scripts/Axioms.lean`.
- **Related ranked stubs**: FS-101 (`plans/STUB-main-clause-five-kernel.md`, the main clause through five in the kernel) and FS-113
  (`plans/STUB-mr-in-lean.md`, measure rigidity in full, in Lean). Whether this milestone absorbs either is the opening's call.
- **Not this backlog**: `plans/BACKLOG-FOR-OPUS.md` is an older, unrelated triage of stubs (2026-09-08).

## How it opens (Workflow 3.1)

A kernel milestone opens with de Bruijn's own reframe — §G for the grokkings about the kernel, the gate and the cost model, read by number; §PA, a
prior-art gate for formalizations (Mathlib's coverage, and any formalization in print) — then planning jobs: the planner (`debruijn`, Opus) writes
the skeleton with `sorry` at every leaf and a plan per leaf; the implementer (`debruijn-implementer`, Sonnet) replaces every `sorry` without changing
a statement and runs the gate. At 259 rows the planner is expected to propose waves along the order's layers. A statement the kernel shows wrong
goes back to Ephodos as a statement defect; a missing lemma, as a question. At most three agents at a time (Kooshi, 2026-10-03).

## Held for Kooshi, with defaults (from `plans/FS129-close-inventory.md` item 173)

The order (the backlog, then FS-124; default: stands); the 46 GB of partial proofs from a dropped search (default: kept on disk, ignored by git);
the finite-graph search toward six (`plans/SEARCH-QUEUE.md` row 3; default: held); a blind second mind on FS129-OR1-QFREE (default: none — the
kernel is the second check); the prior-art debt of FS-129's entries (default: owed until publication).

## Bearing on the answer

*Provisional (the coordinator's); de Bruijn's opening rewrites it.* None by itself: it moves no value of χ. It is the promotion path for every
[hand] result the frontier rests on — row 121's χ(ℚ(√47)²) = 5, FS-129's FS129-SR3-QFREE-NS, FS-116's exclusions — and the bar for publishing any
of them (`CLAUDE.md` § Publication).

## Deliverables

- Kernel modules passing the gate for the backlog's statements, each formalized once, in its merged form; outside theorems imported with their four
  items; our own unformalized results as explicit hypotheses.
- `LEDGER.md` rows regraded to [kernel] with their assumptions named; the Frontier and the Proof Atlas updated at the close.
- FS-129 Closed (its inventory ticked); statement defects and missing lemmas routed to Ephodos.
