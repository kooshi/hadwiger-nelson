exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-wt5"; BR="fs131-t5"; JOB="FS131-T5"; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"merge-base","HEAD","main"],capture_output=True,text=True).stdout.strip()[:8]
assert BASE,"make the worktree first"
H="Proofs/HadwigerNelson/"
b=f'''# Brief {JOB} — the gate enumerates what the library assumes: outside theorems declared as axioms, and named hypotheses, with the theorems that rest on each

*Written 2026-10-06 by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: a tooling job — make the gate enumerate every assumption a theorem of this library rests on, in both forms it takes: an outside theorem declared as an `axiom` (the audit lists these today) and a named hypothesis in a theorem's statement, standing for an outside theorem or for a hand result of ours not yet in the kernel (nothing lists these today); as a step in the form of the gate's others, with a saved receipt, a digest, and a self-test whose every control has been watched to fire; then declare what `main` assumes today
  launch: now, in a special-purpose slot Kooshi authorized for this job alone, beside three jobs on other branches; a landing of another wave is in flight on `main`, and you do not land
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for an assumption on `main` that no record of ours names (at once, with the declaration and the theorems that take it), a docstring and a record that disagree about what a hypothesis is, a design fork you would rather not settle alone (what must fail the gate and what is only counted), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail — the second is this job's method
  record: `plans/{JOB}-assumptions.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` at `{BASE}`): files under `scripts/` — new ones for the step (names yours, in the pattern of `scripts/Axioms.lean` with `scripts/axioms.sh`, and `scripts/Vacuity.lean` with `scripts/vacuity.sh`) and a controls file for it; `scripts/gate_report.py` (a digest for the new receipt); `scripts/Axioms.lean` and `scripts/axioms.sh` only if your design puts the list beside the imports' list — three other jobs are editing that file's records and its list of imports on other branches, so a file of your own merges more easily; `tools/fs131_t5_*.py`, `data/fs131/t5/` (planted cases live here, never under `Proofs/`), `plans/{JOB}-assumptions.md`, `data/fs131/reports/{JOB}.md`; **not** anything under `Proofs/` (a docstring edit there rebuilds the library, and no statement is yours to change: what your design would want there goes in your drafts), `CLAUDE.md`, `LEAN.md`, `ARCHITECTURE.md` (drafts for those go in your record), `main`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. This library's claim is that everything in it reduces to what the kernel checked plus what was explicitly chosen to trust. Today
I told the project's owner that it assumes one outside theorem. That was wrong: it declares one as an axiom, and at least five more
enter as hypotheses of the theorems that use them — and I found those with `grep`, because no instrument lists them. He asked for the
instrument. You build it.

## Why this job

His words, and the rule they refer to:

{item(551)}
{Q("LEAN.md","- **An imported theorem carries four things**","§ Assumptions: outside theorems and our own")}
{Q("LEAN.md","- **Our own hand results** that a module needs before their own module lands","§ Assumptions: outside theorems and our own")}
An axiom shows in `#print axioms`, so the audit sees it. A hypothesis does not: a theorem that says "if Herglotz–Bochner holds, then …"
prints the standard three and is counted clean, and so it should be — but then nothing a reader is shown says how much of the library is
conditional, or on what. Before this project publishes, every assumption of either form has to be discharged or stated, and a list kept
by hand goes wrong the way mine did. The correction I owe him, with what a search of `main` found:

{item(548)}
## The statements

No statement of the library changes in this job. What exists, and what is on `main` today (read each whole, with its docstring):

*The audit's list of outside axioms, and the sentence that records it:*

{Q("scripts/Axioms.lean","def declareImport (n : Name) : CommandElabM Unit := do")}
{Q("CLAUDE.md","Audited at every milestone with `#print axioms`","§ Trust ledger")}
*Named hypotheses on `main` that stand for outside theorems* (by my search; each a `Prop`-valued definition that theorems take as an
argument):

{Q(H+"SpectralChain.lean","def BochnerHerglotz ")}
{Q(H+"SpectralChain.lean","def InvariantMeasureOnClosed ")}
{Q(H+"Arith/SpectralInputs.lean","def BochnerOn ")}
{Q(H+"Plane/Slack.lean","def Voronov11 ")}
*Named hypotheses on `main` that stand for hand results of ours* (three of them; and the last landing's table of every named hypothesis
its four files take, some of which are propositions written out in a binder with no name of their own):

{Q(H+"Arith/StandingFive.lean","def StandingFloor ")}
{Q(H+"Arith/CharacterColouring.lean","def OrderBound ")}
{Q(H+"Plane/Slack.lean","def Row130M1 ")}
{Q("plans/FS131-L10A-landing.md","   | named hypothesis | states | whose | the landed theorems that take it |")}
{Q("plans/FS131-kernel-plan.md","### 7.4 Hypotheses from outside the backlog, by name")}
My search is not the list. It read docstrings for a few phrases; it cannot see a hypothesis written out inline; and it missed at least
one I know of (measure rigidity enters as `SpectralChain.Interface.MR`). Treat it as a seed and a warning.

## Done means

1. **Your readback first**: check every quotation above against its source; read the audit's two files and their procedure for an
   import (beside the IMPORTED banner), the vacuity step as the model of a check that requires evidence for something undecidable
   (`scripts/Vacuity.lean`, `scripts/vacuity.sh`, and its paragraph in `LEAN.md` § The gate), `scripts/gate_report.py`, and
   `LEAN.md` § Assumptions and § Trust ledger. Build the branch once as given (expect it up to date). Open your record. Commit and push.
2. **The design, written in your record before any code** — it is yours, and these are the questions it has to answer: (a) what counts
   as an assumption, and of which kind — an outside theorem, a hand result of ours, an open question a theorem is conditional on;
   (b) where each is declared — one list, each entry with its kind and its source (a `BIBLIOGRAPHY.md` key, or the id of a derivation
   entry), checked the way `declareImport` checks an axiom's docstring; (c) how the step finds, for every audited theorem, which
   declared assumptions its statement takes — from the theorem's type as the kernel has it, never from text; (d) what it does with a
   hypothesis that is a proposition written out in a binder with no name; and (e) **how the gate notices an assumption nobody declared**.
   That last is the hard part and, like vacuity, cannot be decided in general: say what evidence the check requires, what fails
   unconditionally, and what is counted and printed every run but cannot be decided — nothing silent. Two candidate signals, mine and
   unchecked: a library definition whose type ends in `Prop` that some theorem takes as a hypothesis and no theorem concludes; and such a
   definition whose docstring carries a bibliography key or the library's own words for these ("named hypothesis", "outside the
   backlog", "external"). Both have false positives and false negatives I can already see (a bound proved for small cases only is
   "concluded" by a theorem and still assumed elsewhere); find the others.
3. **The step**: a Lean-side scan over the built library with a wrapper in the form of the gate's others — exit status, a saved
   receipt under `build/gate/`, a one-line verdict — that prints (i) every declared outside axiom with the records that rest on it, as
   the audit does today; (ii) every declared hypothesis with its kind, its source and the audited theorems that take it; (iii) the
   counts, in a line `scripts/gate_report.py` can read; (iv) whatever your design counts but cannot decide. And `--self-test`.
4. **Make it fail, and watch it fail** (`RUNNING.md`): each control with its silent partner, each seen red — at least: a planted
   hypothesis nobody declared; a declared one that no theorem takes (stale); a declared one with no source, and one whose source is no
   bibliography key or entry id; a theorem that takes a declared hypothesis and is missing from its list; a declared *kind* that its
   docstring contradicts. Planted cases live under `data/fs131/t5/`.
5. **`main` declared**: every assumption on `main` today in the list, each with kind and source read from its docstring and from our
   records (the landing table and the plan's § 7.4 quoted above; `ARCHITECTURE.md` § 5). A docstring and a record that disagree, or an
   assumption no record names, is a message to me. The step green on `main`'s tree, its receipt saved, the counts stated.
6. **The digest and the drafts**: `scripts/gate_report.py` reads the new receipt against a previous one and against recorded counts,
   as it does for the other two; and in your record, drafts with their slots — the sentence `CLAUDE.md` § Trust ledger gains (the
   counts by kind), the paragraphs for `LEAN.md` § The gate and § Assumptions (the procedure for declaring a hypothesis; that the gate
   lists both forms), a table for `ARCHITECTURE.md` § 5, the line every landing brief must carry from now on (a wave that brings a
   named hypothesis declares it, or the step fails), and any docstring you would want changed under `Proofs/`, for a landing to make.
7. **What is on its way**, for your design and your record: branches not yet on `main` bring at least `KloostermanBound` (Weil's bound;
   about to become a declared axiom), `WEqKLimit`, `ReduceToMap`, `MapNO`, `GammaFreeEmptyNS`, `QArcsJoinOpposite`, and one job is
   removing the only declared axiom while another adds one. Say how each landing will meet the step, and what happens to the audit's
   own controls when the list of imports is empty.
8. No file under `Proofs/` changed; no `axiom`, no `native_decide`. **You do not land**: you do not merge another branch, run the full
   gate, or touch `main` — the next landing merges your branch and runs your step as part of its gate. Leave no background process
   running, and keep what your record cites under `data/fs131/t5/`.
9. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, with the enumeration of `main` as
   its first result — by kind, by name, with the count of theorems on each — and what the step counts but cannot decide. Stopping at a
   saved stage with the design written and part built is a good report.

## What is yours to decide

The design, entirely: the kinds, the list's form and home, what fails and what is counted, the names of the files and of the step, and
the order. One constraint is the owner's and is not yours to trade: both forms are enumerated — an assumption does not escape the list
because of how it entered. If the honest answer to (e) is that a class of undeclared assumptions cannot be seen by any check you can
build here, say so in the step's own output every run, with the count of what it could see. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-gate-assumptions.md","w").write(b)
print("written",JOB,"base",BASE)
