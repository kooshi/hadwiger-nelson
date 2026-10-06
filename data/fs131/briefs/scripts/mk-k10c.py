exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys,subprocess
# optional arguments: the second-pass implementers' branches that are back, as name=tip (e.g. fs131-w10d=abcd1234), for the read-backs
BACK=[a.split("=") for a in sys.argv[1:]]
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
TREE="fs131-w10k"; JOB="FS131-K10c"; W=WT+TREE+"/"
TIP=subprocess.run(["git","-C",W,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
REC=W+"plans/FS131-w10-kernel-plan.md"; A=W+"Proofs/HadwigerNelson/Arith/"; AR="Proofs/HadwigerNelson/Arith/"
PAPER="/home/kooshi/source/library/pdf/pnas-1948-weil-on-some-exponential-sums.pdf"
LI="/home/kooshi/source/library/pdf/jnt-1992-li-feng-character-sums-abelian-ramanujan-graphs.pdf"
if BACK:
    BACKTXT="Back at this writing, each on `origin`: "+", ".join(f"`{n}` at `{t}`" for n,t in BACK)+". Read their new *statements* (helpers and models, not proofs) against the sentences they serve, as the second pass did for the first two implementers (its §§ 6.4, 8.6); a statement that says more or less than its sentence is a message."
else:
    BACKTXT="None of the second pass's three implementers is back at this writing; I will send you each branch's tip by message as it hands back. Read their new *statements* (helpers and models, not proofs) against the sentences they serve, as the second pass did for the first two implementers (its §§ 6.4, 8.6); what is not back by your last stage is named in your handoff."
ITEMQ="\n".join(item(n) for n in [500,515,510,520,507])+"\n"
IMPORT="\n".join([Q("BIBLIOGRAPHY.md","| **[Weil1948]** |"),Q(A+"FloorPlanes.lean","def KloostermanBound "),Q(A+"FloorPlanes.lean","theorem kloostermanBound_of_card_le_five "),Q(A+"FloorPlanes.lean","theorem targetFloor_seven_of_kloosterman "),
    Q(A+"TargetFloors.lean","theorem standingFloor_seven"),Q(A+"TargetFloors.lean","theorem standingFloor_five"),Q(A+"TargetFloors.lean","theorem seven_le_localBound_of_kloosterman"),
    Q(REC,"### 7.3 Row (ii) — the planes:"),Q(REC,"**The exact statement the hypothesis carries**"),Q(REC,"**Which fields it must cover**:"),Q(REC,"**Draft for `ARCHITECTURE.md` § Trust**"),
    Q("LEAN.md","- **An imported theorem carries four things**"),Q("LEAN.md","  1. its docstring names its `BIBLIOGRAPHY.md` key"),Q("LEAN.md","  2. its Lean statement is read back"),Q("LEAN.md","  3. one model of its hypotheses"),Q("LEAN.md","  4. a line in `ARCHITECTURE.md` § Trust")])+"\n"
ROWS="\n".join([Q(REC,"### 8.3 J45-SI-C and J45-SI-5"),Q(REC,"**Not stated — where K10c takes over.**"),Q(REC,"### 8.4 J45-N1 (a), (b) — not stated"),Q(REC,"Stating `τ′_S` needs the `S`-adic completions"),
    Q(REC,"### 8.7 The new row (ruling 507 (b))"),Q(REC,"It belongs to the wave:"),Q(REC,"### 8.6 The second implementer's statements read back"),Q(REC,"### 9.4 For the joining job")])+"\n"
b=f'''# Brief {JOB} — wave 10's third planning pass: the read-back of Weil's page and the import, then the four rows the second pass left unstated

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: wave 10's third planner — first read a held paper's page against the Lean statement of the one classical bound the wave assumes, and make it an imported axiom with the four items this project requires; then state the four rows the second pass left (two about random colourings of a Cayley graph, the topology they are stated over or its two-fact interface, and the comparison of a profinite level with its finite quotient graph) as new modules, `sorry` at each leaf, each read back against its row; then read back the implementers' new statements; a plan and a price per leaf, and a handoff
  launch: when a slot frees, in the tree the second pass (FS131-K10b) handed back; that pass's three implementers prove its leaves on branches of their own, cut from this branch's tip
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job — **at once and before anything else if the page does not state what `KloostermanBound` states** (with the page's words and the difference: a hypothesis it carries and ours lacks, a case it excludes, a constant), and for a statement defect in a row (with the entry's address and the line of the argument), a change you find you need in a module that is fixed (below), a generalization or a shorter route, any further outside theorem you would import, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ Assumptions and § Trust ledger: what an imported theorem carries and how the audit reads it; § The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w10-kernel-plan.md` (on branch `{TREE}`; the two passes' record — your stages from 10, headed {JOB})
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): **new modules only** under `{AR}` (the import in a module of its own, which imports the floor's modules and nothing imports back), with `Proofs.lean` and `ARCHITECTURE.md` for them — `ARCHITECTURE.md` § Trust for the import's line; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", and the import's registration where the audit's existing imported entries are registered), `plans/FS131-w10-kernel-plan.md`, `tools/fs131_k10c_*.py`, `data/fs131/k10c/`, `data/fs131/reports/{JOB}.md`; **not** the wave's fourteen existing modules (the four of the first pass are being landed on `main` by another job; the ten of the second pass are fixed — three implementers are proving them on branches cut from this one: a statement you need there is a message, a lemma beside them goes in a module of yours), any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record; I file them)
  budget: {BUDGET}

Hello. You are finishing the plan of wave 10, the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–5 are on `main`, and wave 10's first four files are being landed as you start. Its
second planner stated the *finite-target floor* — certain finite graphs need seven colours, which a theorem about a degree-28 field leans
on — as two rows. One of them rests on a classical inequality, Weil's bound for Kloosterman sums, which stands in Lean as a named
hypothesis (`KloostermanBound`) because no page stating it had been read. The page is now held. Reading it against the Lean statement is
your first act, and it is the one place in this wave where a wrong sentence would be invisible to the kernel.

## Why this job

An axiom that misstates its paper can be inconsistent, and then every theorem built on it is provable, false ones included. This wave has
already met that risk once: the second planner stopped before stating an axiom from another held paper, read the page, and found the
printed theorem false in a case (inventory item 500, below). So the import here is by rule a planner's read-back against the page's own
words, never a copy of a summary — mine included: my reading of the page (item 515) located the statement and is not the read-back. The
rows after it are what the wave still owes before its second landing. Kooshi, on assuming the literature and on pricing this work:

{Q("LEAN.md","- **A milestone may assume the literature** (Kooshi, 2026-10-03).")}
{KOOSHI}
What the earlier passes handed back and the rulings in force (read each item whole in the inventory):

{ITEMQ}The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"4. **Names every hypothesis from outside the backlog**")}
## The statements

**The import.** The paper is `{PAPER}` (four pages; the bound is displayed on p. 207). Its bibliography row, the Lean statement it must
match, the model the second pass proved, the three theorems that carry the hypothesis, the second pass's words on it, and the rule:

{IMPORT}**The rows not stated, and the read-backs** — the second pass's words (its record's §§ 8.3, 8.4, 8.6, 8.7, 9.4; read Stages 6–9 whole):

{ROWS}## Done means

1. **Your readback first**: check every quotation above against its source; read the two passes' record whole (Stages 1–9), the floor's
   modules (`FloorPlanes`, `NormOneTarget`, `TargetFloors`, `RatioBound`), and the plan's §§ 7.1–7.5. Build the branch once as given (its
   `sorry` leaves are the three implementers'; none is yours). Open your stages in the record with what you may and may not change. Commit
   and push.
2. **The page against the statement** — before any Lean. In your record, side by side: the page's hypotheses and inequality in its own
   words (the field, the characteristic, the character, the condition on the two coefficients, the range of summation, the constant), and
   `KloostermanBound F` clause by clause; then every way they could differ, each settled from the page — the characteristic (rulings 500,
   515: the page says not 2; the floor reads the bound only at fields of `q ≡ 3 (mod 4)` elements, so the axiom is stated with
   characteristic not 2 and loses nothing); `4cd = a ≠ 0` against `a ≠ 0 ∧ b ≠ 0`; a character "not everywhere equal to 1" against
   `ψ ≠ 1`; the sum over `x ≠ 0` against a sum over units; prime powers. Check the statement by exact arithmetic where it can be computed (a tool under `tools/`, cyclotomic integers and no floats: every character
   and coefficient pair at a field of seven elements and at one of nine, a prime power), so the sentence you are about to assume is at
   least true there. **If the page and the statement differ in any way you cannot close, stop and message me: no axiom.**
3. **The import, with its four items** (`LEAN.md` § Assumptions): the `axiom` in a module of its own, its docstring naming `[Weil1948]`,
   the section and the page; the read-back of step 2 in your record; a model of its hypotheses in the same file (the second pass's
   `kloostermanBound_of_card_le_five` at `ZMod 3` serves if the axiom's hypotheses are met there — say so, or give another); the line in
   `ARCHITECTURE.md` § Trust (the second pass's draft is quoted above). Then `standingFloor_seven`, `standingFloor_five` and
   `seven_le_localBound_of_kloosterman` applied to it, under names of your own, with the axioms print showing exactly the standard three and
   the import, and declared to the gate as `LEAN.md` § Trust ledger says (one `AxiomAudit.declareImport` line in the IMPORTED section of
   `scripts/Axioms.lean`, every record resting on the axiom audited there). Draft, for me to file at the landing: the changed counts — the
   library's declared outside theorems go from one (`falconer_lemma2_nonempty`) to two, and the audit's imported count, which counts
   *records* resting on one, rises from 4 by the records that rest on yours (my item 515 (c) said "from 4 to 5"; that confused the two) —
   and any line `LEAN.md` § Trust ledger needs. Commit this stage on
   its own and send me the hash: the wave's second landing reads it.
4. **The four rows**: J45-SI-5 and J45-SI-C's measure parts, in the form over an arbitrary filter that the second pass recommends unless
   your reading of the arguments says otherwise; J45-N1 (a)(b), or the two facts about the filter that the other rows read of it, as an
   interface (which of the two is yours to decide, with the reason — ruling 510 (b)); the level row, X25B-L1's pulled-back level against the
   finite quotient graph, in the form X25B-T's chain reads, which nobody has opened — settle it from the entry, or send it back as a
   deriver's question. Each with `sorry` at its leaves, read back against its row, with its inhabitant or vacuity line.
5. **The read-backs.** {BACKTXT} Also the first pass's third implementer's twelve new statements in `StandingFive` (ruling 520 (b); on
   `origin/fs131-w10c`, and on `main` once the first landing is in), and whether `NumberField standingField` becomes a global instance
   there — a recommendation with its reason; the edit, if any, is the second landing's.
6. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no `axiom` but the one import, no `native_decide`;
   `./scripts/dupnames.sh` on your tree — no name declared by two modules (the second pass's § 9.4 lists the names it declared in existing
   namespaces from new modules).
7. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from
   the first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), a handoff for
   implementers by file, and an updated list for the wave's second joining job. A leaf you can prove in about an hour, prove, and say so.
8. The report, in standing rule 11's form. You do not merge another branch into this one unless I ask it by message, run the gate, or touch
   `main`. Leave no background process running, and keep what your record cites under `data/fs131/k10c/`. The import is the part that must
   be whole; if the four rows are more than this pass holds, stopping at a saved stage and saying exactly where a fourth pass takes over is
   a good report.

## What is yours to decide

The verdict of the read-back — it is yours alone, and "the page does not say this" is a complete and welcome answer; the axiom's exact
form within what the page states (a hypothesis on the characteristic, or the statement restricted to the fields the floor reads — say
which and why); the form of each of the four rows within what its row claims; which of them are stated and which named as an interface;
the modules and the order after the import. Two minds planned what you stand on: where it does not carry what a row reads, say so by
message before working around it. A second held paper states the bound for the norm-one sums directly (`{LI}`, its abstract; ruling
515 (a) keeps it as a cross-check of `normOne_charSum_ge`'s statement, not as the import): use it so if it helps. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave10-third.md","w").write(b)
print("written",JOB,"at tip",TIP,"back:",BACK)
