exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LP1: the landing of the port of the outside release's transfer proof (31 generated modules, the switch,
# Outside/OAI158Collapse), through the full gate.
# Usage: mk-fs131-lp1.py <item of KO1's hand-back> <item of IPD1's hand-back> <ruling items, comma-separated>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KO,KD=int(sys.argv[1]),int(sys.argv[2]); RU=[int(x) for x in sys.argv[3].split(",")]
TREE="fs132-wi1"; BR="fs131-wlp"; JOB="FS131-LP1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wpl"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
RQ="data/fs131/REQUEST-2026-10-13.md"
PL=W+"plans/FS131-KO1-port-plan.md"; IA=W+"plans/FS131-IPA1-implementation.md"; IB=W+"plans/FS131-IPB1-implementation.md"; ID=W+"plans/FS131-IPD1-implementation.md"
CMP=W+"tools/fs131_ipa1_readback_port.py"
for p in (PL,IA,IB,ID,CMP,ROOT+"plans/FS131-LJ1-landing.md",ROOT+"data/fs131/lj1/gate/receipt-axioms-final.log",
          ROOT+"data/fs131/lj1/gate/receipt-vacuity-final.log",ROOT+"data/fs131/lj1/gate/receipt-assumptions-final.log",ROOT+"data/fs131/lj1/drafts-slots.py"): assert os.path.exists(p),p
RULES="\n".join(item(n) for n in RU)
b=f'''# Brief {JOB} — land the port of the outside release's transfer proof through the full gate: one declared outside theorem becomes a theorem

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the lander of the port — thirty-one modules generated from the outside release, every proof checked by this kernel, the switch that made the declared transfer theorem the ported one under its name, all registered and built green in its tree; you finish the four read-back items its last implementer left (rulings below), take it through every step of the gate on one commit, read its headlines aloud, and draft the front-page lines; the merge into `main` is the coordinator's, at your green line
  launch: now, in the port's tree — its last job has handed back and nobody else writes there; a planner and an implementer of the five-colour chain work in other trees and share the build slot; `main` at `{MAIN}` holds no Lean change since the tree's compiled library (`747e139d0`), only records
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the records do not explain, if the read-aloud finds a statement that says more or less than the release's, if a count does not come out as § Done means predicts, and **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wpl` at `{TIP}`; its compiled library is current for that commit, 58 modules rebuilt by the last implementer): the merge of `main`; the comparator `tools/fs131_ipa1_readback_port.py` (its rules, name map, and a streaming or per-constant-hash reader, each with its planted control); docstrings only — no statement changes — in `Proofs/HadwigerNelson/Outside/OAI158Collapse.lean`, `Proofs/HadwigerNelson/Outside/OAI158.lean`, `Proofs/HadwigerNelson/Plane/RadiusOutside.lean` and `Proofs/HadwigerNelson/Plane/LebesgueNumber.lean` where they still call the transfer a declared outside theorem; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` where a row needs a word; `plans/{JOB}-landing.md`; `data/fs131/lp1/`; `data/fs131/reports/{JOB}.md`. **Not** any generated module's text (the generator writes those, and it is frozen), any other module, the density equality's branch. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the read-back items, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. This is the fourth landing on this machine in two days, and the first that removes an axiom. Four implementers
ported the outside release's transfer proof file by file over the night, met every place where Mathlib changed between
the release's version and ours, and brought each to a ruling; the last one made the switch and built the library
green. Your job is to make it held.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W4: ")}
{Q(RQ,"W2: ")}
On `main` the library rests on three declared outside theorems. After this landing it rests on two — Weil's bound and
the release's five-colouring theorem — and `χ(ℝ²) = χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) = χ_m(ℝ²)` and
the disc criterion's half toward seven rest on the standard three. They are other people's mathematics, ported with
their proofs; the credit goes in every line you draft.

## The statements

The port's planner's hand-back, the last implementer's hand-back, and my rulings on the read-back items it left (their
words in quotation marks; the rulings are mine and are your rules):

{item(KO)}
{item(KD)}
{RULES}
Where everything is, in your tree: the plan `{PL}` (§ 4.4 the switch, § 4.6 what the landings read, § 4.3 the
adaptation class), the three implementers' records `{IA}`, `{IB}`, `{ID}` (the last one's § 4–6: the switch's receipts,
the registration, the gate steps it ran, its § 5.4 the four read-back items, its drafts), the comparator `{CMP}`. The last
landing's record `plans/FS131-LJ1-landing.md` on `main`, its receipts `data/fs131/lj1/gate/` — **its three final receipts
are the "previous" side of your digests** — and its slot checker `data/fs131/lj1/drafts-slots.py`, the pattern for yours.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the four records read; `LEAN.md`
   § The gate, § Assumptions and § Trust ledger as they stand on `main`. Merge `main` into the branch (records only:
   trial it and name any conflict first). Dump the stored statements of `Outside/OAI158`, `Outside/OAI158Collapse`,
   `Plane/RadiusOutside` and `Plane/LebesgueNumber` from the built tree before any edit.
2. **The read-back finished** (a saved stage): the comparator made to run within 8 GiB (ruling 4 of item {KD}), its
   planted controls re-run; the four items under rulings 1–3; the comparator's `--self-test` with every new rule; the
   ADAPTED_VALUE elaboration control; level one for lane D. READBACK OK, or a message to me.
3. **Docstrings** of the moved theorems and the two leaf modules, prose only, the stored statements shown unchanged.
4. **The registrations**: the audit's state-reading controls (`scripts/axioms-controls.txt`: imported 38 → 26,
   declared imports and library axioms 3 → 2), each seen red before it is moved by that file's own rule; the
   assumptions ledger written by the script's own flag after the step is run and its output kept — its twelve
   stale-consumer failures are the transfer's consumers; `tools/check_architecture.py` exit 0; the doubled-name check.
5. **Read aloud**, in your record: the transfer theorem's stored statement against the release's
   (`HadwigerNelson.Outside.OAI158.proper_to_borel_weak` against the release's `proper_to_borel_weak`, term for term —
   the read-back's verdict and your own print); and the twelve records that rested on it, each by name with its axioms
   from your own print.
6. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search whose
   plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test` green;
   `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and `--self-test` green;
   `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build --trace`, under the
   slot), silent, with its planted control red; the notes check and the records check as the last landing ran them;
   the generator's `--check` on all 31 modules. The three digests against `data/fs131/lj1/gate/receipt-axioms-final.log`,
   `data/fs131/lj1/gate/receipt-vacuity-final.log` and `data/fs131/lj1/gate/receipt-assumptions-final.log` (say
   exactly which front-page lines they report stale). The last implementer's counts, which I reconciled: the audit
   9,024 records — 8,961 clean, 32 axiom-free, 26 imported, 5 purchases — with 2 declared imports and 2 library
   axioms; the assumptions digest `axioms=2 rests=27`, the other seven counts unchanged; the vacuity scan
   `declarations=17785 refutations-skipped=232` with no new site — a difference is a message to me, not a failure.
   Every step's log saved under `data/fs131/lp1/gate/` and named, with its wall time and peak memory. Then one line to me.
7. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LP1)", each with the log line it
   comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once (give
   the fact-audit tool's table every token your drafts retire): the audit's, the gate's and the assumptions' count
   lines in `CLAUDE.md`; every sentence of `CLAUDE.md` that calls `Outside.OAI158.proper_to_borel_weak` a declared
   outside theorem, rewritten to say it is the release's theorem ported with its proof and kernel-checked here (§ The
   aim, § Where the problem stands, § Trust ledger); a `GATE_CHANGES` entry; `ARCHITECTURE.md` § Trust; `LEAN.md`'s
   lines from the four records (the port's classes: adaptations, ruled statement changes, the cascade, pin differences,
   the comparator's rules); the bibliography's `[OAIMath2026]` row's reading status. **Whose it is**: the transfer and
   every ported proof are `[OAIMath2026]`'s; the port, the adaptations and the kernel check at this pin are this
   project's. And the open gate items at this landing, by name.
8. **Your record**, stages headed "Stage n — SAVED (FS131-LP1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with the
   gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; the comparator's streaming design within its controls; the batch
size of each build; the wording of an open gate item. Not yours: any statement; any generated module's text; the
generator; the merge into `main`; a push; anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured by the last two landings here: every whole-library gate
step is one `lean` process of 4.4 to 5.1 GiB (the library is now about 1,400 records larger: re-measure the first one);
a build in which only small modules are stale is 5.5 to 8 minutes; a whole final pass was 22 to 24 minutes. Run the
memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lp1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build: `--mem 10 --cpus 4 --
env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The comparator within 8 GiB (it took 20 GiB unchanged;
do not run it above 8). Two other jobs share the slot: on exit 75 wait and retry, and tell me if a step has waited an
hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: every log your
record cites lives under `data/fs131/lp1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-landing.md","w").write(b); print("ok",len(b))
