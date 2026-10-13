# Brief FS131-KN1 — what each of this project's results about planes over number fields rests on in the Lean library, and then the plan of the first module to close the gap

*Written 2026-10-13 16:02 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow (§ A kernel milestone: this is the Lean backlog re-aimed, so its §G is the entries on the kernel, the gate and the cost model read by number, and its §PA is Mathlib's coverage of the outside theorems these results lean on)
  role: the kernel lane's planner at a change of direction — the project is being wound down and published, and the results about planes over number fields are to be in the kernel first; you say, result by result, what the library holds, what it assumes and what stands between each result and "kernel-checked on the standard three axioms and declared theorems of the literature"; then, when the ranking arrives, you plan the first module
  launch: now, in a tree of your own; beside you the asking lane ranks the same results by interest to the field, on `main` under `plans/` and `data/` — you write no file it writes; nothing is landing and no implementer is running
  mission: § Why this job
  statements: § The request, and what it covers
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **when the map is committed** (a few lines: where it is, how many results, which are nearest and which furthest from the kernel, anything that surprised you); **at once** for a result the ledger grades as kernel-checked whose theorem you cannot find or whose statement is weaker than its row, for a named hypothesis that no record explains, and for the first measurement of what a build costs on this machine; phase 2 starts on my reply, which will be a dated amendment at the foot of this brief; the report goes to `data/fs131/reports/FS131-KN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN1-number-field-kernel-map.md` (new, on branch `fs131-wnf`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-wnf`, cut from `main` at `151c4a27`; the tree is the last landing's, moved, and **its `.lake/build` matches the branch — no Lean file has changed on `main` since that landing — so phase 1 needs no build**): `plans/FS131-KN1-number-field-kernel-map.md`, `data/fs131/kn1/`, `data/fs131/reports/FS131-KN1.md`, scratch check files under `data/fs131/kn1/` (never under `Proofs/`); in phase 2, new skeleton modules under `Proofs/HadwigerNelson/` and their lines in the build's lists. Nothing on `main`, and no existing module's statements
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after each third of the map, and when the map is complete; in phase 2 a stage when the statements are typed and when each leaf's plan is written; hand back before you would guess 500k — if the map alone has filled you, say so at its commit and a successor takes phase 2 from your record

Hello. The direction of this project changed today, and the kernel lane is where the change lands.

## Why this job

For three weeks the work was aimed at six against seven for the real plane; it moved no value there. Kooshi has decided
to wind the project down and publish the repository, and what he wants in it first is Lean proofs of the findings about
planes over number fields — the part of the project a number theorist or a worker on the chromatic number of the plane
would come for. Many of those are in the kernel already. Several of the best are not: they are held by hand, or
kernel-checked only over hypotheses that stand for hand results of ours. A published repository has to say of each
headline exactly what it rests on, and the gap between "over our own unformalized lemmas" and "over printed theorems of
the literature" is the work he is asking for.

Two jobs start on his word. The asking lane ranks the findings by how much the field would want them. You do the half
no ranking needs: the map of where each stands in Lean. When its ranking is saved I pass it to you and you plan the
first module; implementers follow.

## The request, and what it covers

> W1: (2026-10-13) Ok, we're resumed […] on the laptop instead of the desktop. Hopefully that doesn't hinder us to much. I'd like to continue with the lean backlog, specifically targeting our interesting number field findings. We're going to wind this project down and publish everything as a git repo (after some cleanup and sanitization, especially moving the transcript backups out of git history). But, to do that, we need the lean proofs for the good stuff. Have a planner determine what findings would be most interesting to the mathematicians in the field, and then let's start formalizing those.
> — source: data/fs131/REQUEST-2026-10-13.md

An earlier word of his bears on it:

> H1: (2026-10-06; FS-131 inventory item 488 — the earlier word that W1 bears on) Let's keep holding off on formalizing or pricing MR for now. That backlog is big enough that I might request community support for filling it. I'm going to wait to do that too though.
> — source: data/fs131/REQUEST-2026-10-13.md

My reading of the two together (mine, labelled; tell me if the record reads otherwise): today's word lifts the hold for
the number-field results themselves, the main clause through five among them. **It does not ask for measure rigidity at
a number field to be formalized or priced: that theorem is literature, and it enters as a declared outside theorem**
with the four items of `LEAN.md` § Assumptions. So for a result that rests on it, the target is: every hypothesis that
stands for a hand result of ours is discharged, and what is left is one or more printed statements, each declared term
for term against its page. Where exactly the printed statement ends and our own deduction from it begins is the most
useful single thing your map can say about those results — the ledger's row on measure rigidity describes a printed
theorem "by statement", a deduction of ours from it, and a method of another paper "transferred".

**"Results about planes over number fields"** — draw the line yourself, widely: the chromatic number of the plane over
a real number field (values, families, bounds); the finite residue planes and the towers over them; the two theorems on
residue colourings and what stands on them; the local–global conjecture's proved range; the fractional, character,
Borel and `p`-adic statements from the same machinery; the bridge between the fields and the real plane. Where to read:

- `LEDGER.md`, row by row (grades, addresses, milestones) and its § The claim list;
- `scripts/assumptions-ledger.txt` — every (assumption, theorem) pair in the library — and the last gate's receipts in
  `data/fs124/l2/gate/` (`data/fs124/l2/gate/receipt-axioms-final.log`: every record with its axioms;
  `data/fs124/l2/gate/receipt-assumptions-final.log`: every assumption with its kind — outside, ours, open — and who
  takes it);
- `ARCHITECTURE.md` (the module map and § Trust), `LEAN.md` in full;
- the kernel records already written for this ground: `plans/FS100-K-kernel-47.md` (a dependency map and a price table
  for the main clause through five; its prices are a month old — standing practice is to re-price from the first two
  leaves, never from a table), `plans/STUB-main-clause-five-kernel.md` (what was next when that work was held),
  `plans/FS100-derivation.md` § 4, and `plans/LEAN-BACKLOG.md` — its closing section holds, among others, the eight
  statements under the row on the plane over the field of the square root of 47;
- `plans/FS131-kernel-plan.md`, the backlog's own opening, for the conventions the backlog's modules follow;
- `plans/STUB-mr-in-lean.md` for what is **not** yours here: formalizing measure rigidity itself. Read it only to place
  the boundary.

## Done means

**Phase 1 — the map.**

1. **Readback** (a saved stage): check the two quotations against their source; restate in your record what is asked
   and where you drew the line around "number-field results".
2. **The map**, one entry per result inside the line, in ledger order:
   - the row, its claim in one line, its grade as filed;
   - the Lean theorem or theorems that hold it, by full name, with the axioms each depends on (from the receipt; re-run
     a `#print axioms` only where the receipt and the row disagree) and every hypothesis each takes, with the
     assumptions ledger's kind for it;
   - for a result held by hand, or in the kernel only in a weaker or conditional form: what is missing, as a list of
     leaves in dependency order, each a statement in words exact enough to type, with the derivation entry it comes
     from by address;
   - for each outside theorem it would import: the statement as printed (bibliography key, page), whether our copy has
     been read against that page, whether Mathlib already has it or most of it (search by the statement's shape, and
     say what you searched), and your call under `LEAN.md` § Assumptions — about an hour of agent work or less:
     formalize; otherwise import, with its four items listed as owed or held;
   - one line: what a reader of the published repository could be told about this result today, and what they could be
     told after its leaves are done.
3. **The cross-cuts** the entries make visible: leaves shared by several results (those go first whatever the ranking
   says); hypotheses of kind "ours" that more than one headline takes; any result whose kernel form is stronger or
   weaker than its ledger row; any statement that a declared outside theorem already in the library now implies.
4. **No prices from tables.** Where you give a size, it is from a leaf you have typed or a proof you have read; an
   unknown is written as unknown. Formalization effort is not a reason to leave a result out of the map
   (`CLAUDE.md` § Counter-priors, the quotation on Lean).
5. Commit, then the short message to me.

**Phase 2 — on my amendment, which will name the results in the asking lane's order and point to a fixed claim list:**
the first module's statements typed and read back against the claim list, the skeleton with `sorry` at every leaf
compiling in your tree, a plan per leaf written for an implementer who has none of your context, statement defects and
generalizations sent to me at once, and the order in which two implementers could work without touching one file. If my
amendment has not come when the map is committed, hand back at that stage — that is a complete job, and I resume you or
brief a successor from your record.

## What is yours to decide

The line around "number-field results"; how to group rows into entries; which existing module a new leaf belongs to;
whether an outside theorem is formalized or imported; the skeleton's shape. If the map shows that the result everyone
expects to be first is not the best first module — because three results share a leaf that none of them is — say so,
and say which module you would start with on the kernel's evidence alone; I will put that beside the ranking.

Not yours here: ranking by interest to the field (the asking lane's); a new derivation (a missing lemma is a question
to me, and I route it to a deriver); any change to a statement that is already through the gate.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** The memory tool's defaults are the desktop's and would admit almost nothing here, so run it as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kn1 -- <command>`

One file through `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration: under the
slot with `--mem 8 --cpus 2`, from inside your worktree. A build, when phase 2 needs one, is one at a time on this
machine: `--mem 18 --cpus 10 -- env MEMMAX=18G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`.
**These numbers are mine and unmeasured here.** If a run is refused (exit 75) or killed for memory, that is the machine
and not you: tell me what it was and what it used, because that measurement sets the numbers for the implementers.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/kn1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
