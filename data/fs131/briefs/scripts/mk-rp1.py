exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess,sys
# Run at launch, after FS131-M7's hand-back: the quotations are read from the joined tree.
# usage: mk-rp1.py "<M7's doubled-names sentence or pointer, one line>"
EXTRA=sys.argv[1] if len(sys.argv)>1 else "FS131-M7's report ends with the list of names that stand twice and statements that stand under two names in the joined tree; that list is part of yours"
C=WT+"fs131-w5c/"
TIP=subprocess.run(["git","-C",C,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
V=C+"Proofs/HadwigerNelson/Plane/ValidMap/"
QA="plans/FS131-QA4-audit.md"; E7="plans/FS131-E7-derivation.md"; LN="plans/FS131-lint-measurement.md"
H62="6.2 The list of what is owed, ranked by what rests on the theorem"
b=f'''# Brief FS131-RP1 — wave 5's remedy pass on `fs131-w5c`: the audits' docstring lines, the ruled statement tidies, and the statements that stand twice, in one rebuild

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RP1
  identity: {IDENT}
  role: one pass over wave 5's joined line that makes every ruled small change the audits and the last jobs left — corrected inhabitant notes, six ruled statement tidies, three unused binders, the statements that stand under two names — each checked by script, in as few rebuilds as the order allows; nothing here is new mathematics
  launch: now, in the tree FS131-M7 has handed back, beside FS131-BA3 (the outward bend's last two children, on `fs131-w5z`) and FS131-KM1 (the example maps' planner, on `fs131-wm`)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a ruled change that does not go through as ruled (a caller you did not expect, a proof that reads the hypothesis after all), a docstring correction whose corrected claim you cannot verify, a doubled statement whose two forms turn out to differ, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RP1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/FS131-RP1-remedy.md` (new, on branch `fs131-w5c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `{TIP}`): the files the list below names — docstrings in them, and the statements ruled to change with their callers; `ARCHITECTURE.md`, `scripts/Axioms.lean` (a block of your own, headed "FS131-RP1", above the `=== PURCHASED ===` banner; and the records of any declaration you rename or remove), `scripts/vacuity-baseline.txt` only if a renamed declaration is in it, `plans/FS131-RP1-remedy.md`, `tools/fs131_rp_*.py`, `data/fs131/rp/`, `data/fs131/reports/FS131-RP1.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` nor the outward bend's other four modules (FS131-BA3 is finishing them on `fs131-w5z`, and its branch is merged into this one after you: an edit here collides — their tidies are listed last, for after that merge), no statement beyond the ruled ones, `main`
  budget: {BUDGET}

Hello. You are doing the housekeeping that lets wave 5 of the Lean backlog land clean. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones. Wave 5 — the termination procedure and the density argument over it — is now one line, and every open leaf it has
is being closed on a sibling branch. Along the way three audits and a dozen jobs left small ruled changes for "the remedy pass": notes in docstrings
that claim more than is true, hypotheses no proof reads, a theorem stated with half a hypothesis idle, the same fact under two names. None is
mathematics. Each is cheap now and costs a rebuild of everything downstream once the wave is on `main`. This is that pass.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the
gate's inhabitant rule (`LEAN.md` § The gate) treats a docstring's "inhabitant of the hypotheses" as a claim: seventeen such notes on this line are
false as written. Kooshi, on pricing this work:

{KOOSHI}
The rulings that make the list (read each whole in the inventory; the letters are cited below):

{item(427)}
{item(419)}
{item(441)}
{item(450)}
{item(432)}
{item(434)}
{item(455)}
## The statements

The statements ruled to change, as they stand in your tree (read each whole):

{Q(V+"UnitArc.lean","theorem nb4p ")}
{Q(V+"BendCollar.lean","theorem bend_toward_collar ")}
{Q(V+"Procedure.lean","theorem exists_rayStep ")}
{Q(V+"Procedure.lean","theorem exists_shaveStep ")}
The audits' rows and the sources of each corrected text:

{Q(QA,"| 2 | QA4-2: 17 docstrings naming `bowtie`",H62)}
{Q(QA,"| 3 | `bend_toward_collar` (`BendCollar`): `hmax`, `hlen` unused",H62)}
{Q(QA,"| 8 | Docstring lines with no mathematics:",H62)}
{Q(LN,"All three are one shape:")}
{Q(E7,"### 1.4 A finding met on the way: `nb4p` never reads half of `hnb`")}
{Q(E7,"### 7.5 What it does to the stuck family's docstrings")}
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
4. **The statements that stand twice** (ruling 434 (d)): `finite_arcs_inter_compact` and `finite_arcs_meeting_compact`; `HasDegree.eq` and
   `HasDegree.unique`; `IsRingArc.union` and `IsRingArc.union_of_overlap`; and whatever {EXTRA}. For each: check the two statements are one, keep
   the name further upstream, re-point the other's users, remove it and its `scripts/Axioms.lean` record. One that turns out to differ is a
   message to me.
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
Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/FS131-RP1-remedy.md","w").write(b)
print("written at tip",TIP)
