exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-LD1: the landing of the density equality (FS-133's Lean module, eight files) on main, after the port, by the join
# recipe of FS131-KO1 § 4.5, through the full gate; FS-133 is Closed when it passes.
# Usage: mk-fs133-ld1.py
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs133-wk1"; BR="fs133-wl1"; JOB="FS133-LD1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs133-wpq"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
assert TIP=="110f1c923",TIP
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
ONE=Q(C,"K133-ONE: ","§ Statements"); FN=Q(C,"K133-FN: ","§ Statements"); PAIR=Q(C,"K133-PAIR: ","§ Statements")
NONE=Q(C,"K133-NC-ONE: ","§ Not claimed"); NALL=Q(C,"K133-NC-ALL: ","§ Not claimed")
RECIPE="plans/FS131-KO1-port-plan.md"; PLAN=W+"plans/FS133-kernel-plan.md"; IPQ=W+"plans/FS133-IPQ1-implementation.md"
ICD=W+"plans/FS133-ICD1-implementation.md"; LP="plans/FS131-LP1-landing.md"
for p in (ROOT+RECIPE,PLAN,IPQ,ICD,ROOT+LP,ROOT+"data/fs131/lp1/drafts-slots.py",ROOT+"data/fs131/lp1/gate/receipt-axioms-final.log",
          ROOT+"data/fs131/lp1/gate/receipt-vacuity-final.log",ROOT+"data/fs131/lp1/gate/receipt-assumptions-final.log",
          ROOT+"plans/STUB-one-class-transfer.md",ROOT+"plans/FS133-close-inventory.md",W+"Proofs/HadwigerNelson/Plane/OneClass/Field.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — land the density equality on `main` through the full gate, after the port: FS-133 closes

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the lander of the density equality — a module of eight files under `Plane/OneClass/` with nothing unproved, on one declared theorem of the outside release that the port, now on `main`, proves; you join it with `main` by the port planner's recipe (the copied definitions and the declared theorem removed, the ported ones read in their place), make two ruled corrections, take it through every step of the gate on one commit, read its headlines aloud against their claim list, and draft the front-page lines that close its milestone; the merge into `main` is the coordinator's, at your green line
  launch: now, in the density equality's tree — its last job has handed back and nobody else writes there; three other jobs (the class-ratio certificates, the density bound's planner, the chain's implementer) work in other trees and share the build slot; `main` at `{MAIN}` holds the port and its filing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if the join conflicts outside the files the recipe names, if a step of the recipe's check column fails (step 8's dump not IDENTICAL is a stop), if the read-aloud finds a statement that says more or less than its claim-list entry, if a count is not what the audit's own arithmetic predicts, and **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs133-wpq` at `{TIP}`; its compiled library is current for that commit): the merge of `main`; the recipe's edits — deleting `Proofs/HadwigerNelson/Outside/OAI158Transfer.lean` with its lines, and in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean` the six copied definitions and the declared `residual_fourier` (the kept declarations character for character, the module docstring rewritten), one import line in `Proofs/HadwigerNelson/Plane/OneClass/Field.lean`; the two ruled corrections in the module's files under `Proofs/HadwigerNelson/Plane/OneClass/` (below; no other statement change); docstrings, prose only, where they still call `residual_fourier` declared; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the recipe and the gate's steps require; your checks under `tools/` named for this job; `plans/{JOB}-landing.md`; `data/fs133/ld1/`; `data/fs133/reports/{JOB}.md`. **Not** any module under `Outside/` the port generated (the generator writes those, and it is frozen), any other module, the front files (you draft their lines). Nothing on `main`; no push
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the join builds, after each gate step that passes, and at the green line

Hello. This is the fifth landing on this machine in two days. The density equality was proved in the kernel last
night, file by file, by five implementers, with one theorem of the outside release taken as declared; this
afternoon the port of that release's proofs landed on `main`, and the theorem it declared is now proved there. You
bring the two together and make it held.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
When this module passes the gate on `main`, FS-133 (the one-class transfer) is Closed: its Lean module is through the
gate. Its headline answers a question the literature has posed — the first clause of `[DuczVarga2026]`'s Conjecture 1
and `[MatolcsiEtAl2025]` §2's equality question — and its claim list says plainly that the result is not new (below).

## The statements

The module's headlines, as its claim list states them, and what it does not claim (`data/fs133/claims-K1.md`):

{ONE}
{FN}
{PAIR}
{NONE}
{NALL}
The density equality's last hand-backs and the rulings on its landing, as I logged them (their words in quotation
marks; the rulings are mine and are your rules):

{item(779)}
{item(789)}
{item(798)}
{item(840)}
{item(841)}
**The recipe** is `{RECIPE}` § 4.5 on `main` (steps 0–9; step 0 is done, item 798). It names the branch `fs133-wb1`;
`fs133-wpq` descends from it and holds the whole module. **The two ruled corrections:** (1) the unread
`[IsProbabilityMeasure μ]` of `ofReal_integral_le_measure_pos` dropped (item 789 ruling 1) — a statement change, dumped
before and after, its callers rebuilt; (2) ICD1's block wording corrected from IPQ1's DQ1 (item 789 ruling 2; the record
`{IPQ}`). Where everything else is, in your tree: the plan `{PLAN}`, the implementers' records (`{ICD}`, `{IPQ}` and the
three before them). On `main`: the port's landing record `{LP}` — its receipts `data/fs131/lp1/gate/` are **the "previous"
side of your digests**, and its slot checker `data/fs131/lp1/drafts-slots.py` is the pattern for yours; the milestone's
stub `plans/STUB-one-class-transfer.md` and inventory `plans/FS133-close-inventory.md` (read, not written).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `LEAN.md` § The gate, § Assumptions and
   § Trust ledger as they stand on `main`; step 1 of the recipe (the dump of every named constant of the eight modules,
   from this tree's build, before the merge).
2. **The join** (recipe steps 2–9; a saved stage, the build's one line to me): the merge of `main` (a trial first, naming
   any conflict); steps 3–5; the doubled-name check before the audit (step 6); the build (step 7); the dump compared
   (step 8: IDENTICAL, or INSTANCES-ONLY and then the kernel `Eq.refl` check with its plants; `Spectral.residual_fourier`
   a theorem of the port, its stored type the declared one's — the port's landing logged that receipt, item 840); the
   axioms of `residual_fourier_cross`, `OneClass.exists_field` and every record of the module (step 9: the standard three).
3. **The two corrections**, shown from the kernel's side against item 1's dump (the dropped binder the only change).
4. **Read aloud**, in your record: each headline's stored statement against its claim-list entry above — the density
   equality in both forms, the finite-subset limit, the labelling claim both ways — and say which Lean names carry each.
5. **The full gate on one commit**, as the port's landing ran it (its record § Stage 7): `./scripts/build.sh` with zero
   warnings; zero `sorry` in `Proofs/` (a search whose plant fires); the doubled-name check and its `--self-test`;
   `scripts/axioms.sh` clean with `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled;
   `./scripts/assumptions.sh` and `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint
   --no-build -- --no-build --trace`, under the slot), silent, with its planted control red; the notes check and the
   records check; the generator's `--check` on the port's modules (unchanged by you). The three digests against
   `data/fs131/lp1/gate/receipt-axioms-final.log`, `data/fs131/lp1/gate/receipt-vacuity-final.log` and
   `data/fs131/lp1/gate/receipt-assumptions-final.log` (say exactly which front-page lines they report stale). The audit
   reads 9,024 records on `main` (8,961 clean, 32 axiom-free, 26 imported, 5 purchases); predict this landing's counts
   from the module's records before the run, and reconcile every difference. Every step's log saved under
   `data/fs133/ld1/gate/` and named, with its wall time and peak memory. Then one line to me.
6. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it
   comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once (give the
   fact-audit tool's table every token your drafts retire): the audit's, the gate's and the assumptions' count lines in
   `CLAUDE.md`; FS-133's state Derived → Closed wherever `CLAUDE.md` names it (§ Frontier, its open-milestones paragraph,
   § Publication's "Held so far" clause, § The aim), with the Lean names; `LEDGER.md` row 129's grade regraded to
   [kernel] for what the module holds, the rest left at its grade; `plans/FRONTIER-STUBS.md`'s line and the stub's
   banner; `ARCHITECTURE.md` § Trust and its rows; `LEAN.md`'s lines from the implementers' records; a `GATE_CHANGES`
   entry. **Whose it is**: say what the claim list's not-claimed lines say — the statement is not new; the kernel proof
   is this project's; the transfer and the residual Fourier step are `[OAIMath2026]`'s. And the open gate items, by name.
7. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in the standing rules' form, the counts read
   from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with the gate
   red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; the batch size of each build; the wording of a docstring or an
open gate item. Not yours: any statement but the ruled binder; any generated module's text; the generator; the merge
into `main`; a push; anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs133-wpq`; the merge adds the port's 31 generated modules and
`Outside/OAI158Collapse`, so the first build compiles them (the port's own build of 58 modules took 11 minutes here).
Measured by the port's landing: every whole-library gate step is one `lean` process of up to 5.5 GiB; a whole final pass
was about 35 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ld1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build: `--mem 10 --cpus 4 --
env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may hold 12 GiB of the slot for long
stretches: on exit 75 wait ten minutes and retry, and tell me if a step has waited an hour. A cap kill under a `timeout`
wrapper shows as exit 143, not 137 (read the system log for "oom-kill"). Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: every log your record cites lives under `data/fs133/ld1/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
os.makedirs(ROOT+"data/fs133/briefs",exist_ok=True)
open(ROOT+f"data/fs133/briefs/{JOB}-landing.md","w").write(b); print("ok",len(b))
