exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LJ1: the landing of the three-and-four-colours line (five modules under Arith/ and Instances/UpperHalfCorollaries).
# Usage: mk-fs131-lj1.py <inventory item of FS131-KJ1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KJ=int(sys.argv[1])
TREE="fs131-wrc"; BR="fs131-wj1"; JOB="FS131-LJ1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
assert not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-landing.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")==BR
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
C="data/fs131/claims-NF4.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
TH=Q(C,"NF4-THEOREM: ","§ The theorem (the asking lane's wording, rank 2)")
NC=Q(C,"NF4-NC: ","§ Not claimed")
DL=Q(C,"- 2026-10-13 — **Statements of the line that say more than the list")
REC=W+"plans/FS131-KJ1-joining-module.md"
for p in (REC,ROOT+"plans/FS131-LU1-landing.md",ROOT+"data/fs131/lu1/gate/receipt-axioms-final.log",ROOT+"data/fs131/lu1/drafts-slots.py"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — land the three-and-four-colours line through the full gate: six files, no `sorry`, the theorem's three clauses in the kernel

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the lander of one finished line of six files — no `sorry`, built in its tree, every public declaration printing the standard three axioms or those and one declared outside theorem; you take it through every step of the gate on one commit, register its records, retire the hypothesis it now proves, read its headlines aloud against the claim list, and draft the front-page lines; the merge into `main` is the coordinator's, at your green line
  launch: now, in the tree the line was joined in — its last job has handed back and nobody else writes there; a planner and an implementer of other milestones work in other trees and share the build slot; the last landing was merged and its drafts filed, so `main` at `{MAIN}` is what you merge and what your drafts quote
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the records do not explain, if the read-aloud finds a statement that says more or less than its claim, or if a count does not come out as § Done means predicts; **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-LJ1-landing.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, at `{TIP}`; its compiled library is current for the line's last build): the merge of `main`; the six files `Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean`, `Proofs/HadwigerNelson/Arith/TorsionExtraction.lean`, `Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean`, `Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean`, `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean`, `Proofs/HadwigerNelson/Instances/UpperHalfCorollaries.lean` — **docstrings only, no statement changes**; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` where a row needs a word; `plans/FS131-LJ1-landing.md`; `data/fs131/lj1/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the registrations, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. This is the third landing on this machine in two days. The second went through the gate on its first full
pass yesterday evening, and its record is the pattern for yours — with two things it learned the hard way, which are
in § Done means.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
This line is the second-ranked finding and the first of this project's own to reach the gate: for real quadratic
fields, which planes need two, three and four colours; over every real number field, exactly when three colours
suffice; and a lower bound of four for any subfield of the reals whose unit vectors generate one third. Four
implementers proved its four modules on four branches, and a fifth job joined them with the landed residue module,
proved the ten joining statements and read every credit against the paper it names. In that tree nothing rests on an
unproved step. Until the gate is green none of it is "held".

## The statements

The claim list `data/fs131/claims-NF4.md` — the theorem, its "not claimed" line, and the dated line that says where
the kernel says more (its five earlier dated lines are in the file; read them there):

{TH}
{NC}
{DL}
The joining job's hand-back as I logged it, with my receipt (its words are in quotation marks; the rulings are mine):

{item(KJ)}
Where everything is, in your tree: the joining job's record `{REC}` — **its § Stage 7 gathers the drafts for the
landing and the filing in one place** (the audit block of 96 records at `{W}data/fs131/kj1/audit-block.txt`; the
note on the assumptions step; the drafts for the ledger rows, the front page, `LEAN.md` and the bibliography, each
with its slot), its § Stage 4 the credits read against the paper, its § Stage 5 the readings from the built tree.
The last landing's record `plans/FS131-LU1-landing.md` on `main` and its receipts `data/fs131/lu1/gate/` — **its
three final receipts are the "previous" side of your digests**, and its stages 4 and 7 are the two lessons below.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the joining job's record read;
   `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`; the last landing's record. Merge
   `main` into the branch (it holds the last landing's filing: the front page, the ledger, the fact-audit tool):
   trial the merge and name its conflicts first; keep both sides. Dump the stored statements of the six files from
   the built tree before any edit. Build.
2. **Docstrings, no statement**: whatever the joining job's record leaves for the landing; nothing in a file outside
   your six (the corrections it drafts for older files wait for one sweep).
3. **The registrations**: the 96 records as one block of yours in the audit script — by the joining job's count 84
   under the banner for the standard three or fewer and 12 under the banner for records that rest on a declared
   outside theorem (Weil's bound, `StandingFive.kloosterman_bound`; no record may rest on two declared theorems);
   if the audit's state-reading controls go red on a count, move it by that file's own rule after seeing it red;
   `tools/check_architecture.py` exit 0 (four rows of `ARCHITECTURE.md` still call the proved modules skeletons:
   the joining job drafted their words); the doubled-name check.
4. **What the library assumes**: `./scripts/assumptions.sh --self-test`, then the step, **run before you edit
   anything of it**, and its output kept. The line proves a statement the library has carried as a written-out
   hypothesis of ours (the lower bound through four, the chain's `hRow99`), now on Weil's bound. **The step will
   not tell you** — the last landing found that it reports a proved hypothesis only when the hypothesis is a named
   one — so the entry is retired on your own reading, as that landing did (its stage 4). Say in your record what
   the entry becomes: a hand result of ours discharged, with the theorem that discharges it resting on a declared
   outside theorem. Write the ledger with the script's own flag, and set the nine counts the step then prints beside
   the ones on the front page (`axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1`),
   each difference explained by name.
5. **The vacuity step** and its `--self-test`: how the scan classes every new site; and name by hand the kernel
   model of each hypothesis-shaped headline (the joining job's four models are in the joining module).
6. **Read aloud**, in your record: the theorem's three clauses and the row-99 statements against the claim list's
   theorem line, its "not claimed" line and its dated lines, clause by clause — every hypothesis Lean has that the
   claim lacks and every one the claim has that Lean does not need; which clauses rest on the standard three alone
   and which also on Weil's bound, read from your own print; and for each exact value the kernel theorem that holds
   each half, by name with its axioms. A difference is a message to me before the gate runs.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search
   whose plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test`
   green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and
   `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build
   --trace`, under the slot), silent, with its planted control red; the notes check and the records check as the
   last landing ran them. The three digests against `data/fs131/lu1/gate/receipt-axioms-final.log`,
   `data/fs131/lu1/gate/receipt-vacuity-final.log` and `data/fs131/lu1/gate/receipt-assumptions-final.log` (say
   exactly which front-page lines they report stale). By my arithmetic from the joining job's count the audit
   should read 7,602 records, 7,531 clean, 38 imported, with the axiom-free and purchase counts unchanged — a
   difference is a message to me, not a failure. Every step's log saved under `data/fs131/lj1/gate/` and named,
   with its wall time and peak memory. Then one line to me.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LJ1)", each with the log line
   it comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once
   (the last landing's `data/fs131/lu1/drafts-slots.py` is the pattern; **give the fact-audit tool's table every
   token your drafts retire — the code spans whole, and a count both with and without its comma** — the last filing
   failed its audit on five such tokens): the audit's and the gate's count lines and the assumptions counts in
   `CLAUDE.md`; a `GATE_CHANGES` entry; the ledger rows this line regrades, from the joining job's drafts checked
   against what landed (rows 52, 73, 79, 82, 99, 105 — each only as far as its statement landed; row 52's two
   values are still not in the kernel, only their upper halves); the front page's sentences on three and four
   colours; **whose each value is, exactly as the joining job read it against the paper** (the values two and three
   and the upper bounds are Fischer's; what is ours is the lower bound of four against every colouring at radicands
   11 modulo 12, the three-colour criterion over every real number field, and the clause for subfields of the reals);
   `LEAN.md`'s facts from the five records; the bibliography's row. And the open gate items at this landing, by name.
9. **Your record**, stages headed "Stage n — SAVED (FS131-LJ1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with
   the gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; how the records are grouped; the batch size of each build; the
wording of an open gate item; whether a rebuild after the merge is saved by copying compiled files from the tree
whose gate passed last (`fs131-wnf`) — three jobs did that and I accepted it on the condition that the record says
what was copied, from where, and how it was compared. Not yours: any statement; the merge into `main`; a push;
anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md`, `LEAN.md` and older
landings' records do not apply.** Measured by the last two landings here: every whole-library gate step is one `lean`
process of 4.4 to 5.1 GiB; a build in which only small modules are stale is 5.5 to 8 minutes; the whole final pass
was 22 to 24 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lj1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build:
`--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. Two other jobs share the slot,
each asking up to 12 GiB for a build: on exit 75 wait and retry, and tell me if a step has waited an hour. Stop a
process by its PID, never by matching its command line. `/tmp` is wiped at power-off: every log your record cites
lives under `data/fs131/lj1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-landing.md","w").write(b); print("ok",len(b))
