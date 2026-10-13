exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LU1: the landing of the residue module (Arith/UpperHalf, Arith/QuadraticPrime, Instances/UpperHalfValues).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-wnf"; JOB="FS131-LU1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
C="data/fs131/claims-NF1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
ST="\n".join(Q(C,f"NF1-{n}: ","§ Statements") for n in ("S1A","S1B","S2","MODULE"))
NC=Q(C,"NF1-NC: ","§ Not claimed")
DL="\n".join(Q(C,"- 2026-10-13",None,k) for k in ("NF1-S2's second sentence is false as written","Three statements widened"))
P=f"/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/"
b=f'''# Brief {JOB} — land the first module of the number-field results through the full gate: a plane over a real number field needs no more colours than its residue targets, and four values that follow

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the lander of one finished module of three files — no `sorry`, built in its tree, every public declaration printing the standard three axioms; you take it through every step of the gate on one commit, register its records, retire the named hypothesis it now proves, read its headlines aloud against the claim list, and draft the front-page lines; the fast-forward of `main` is the coordinator's, at your green line
  launch: now, in the tree the module was finished in — its implementers have handed back and nobody else writes there; implementers of another line work in other trees and share the build slot; the last landing was merged and its drafts filed just before this brief was written, so `main` at `{MAIN}` is what you merge and what your drafts quote
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the records do not explain, if the read-aloud finds a statement that says more or less than its claim, or if the assumptions step does not come out as the last implementer predicted; **with one line when the gate is green on one commit** (then stop: the fast-forward of `main` is mine); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-LU1-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`; its `.lake/build` is current for that commit): the merge of `main`; the three files `Proofs/HadwigerNelson/Arith/UpperHalf.lean`, `Proofs/HadwigerNelson/Arith/QuadraticPrime.lean`, `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` — **docstrings only, no statement changes**; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` where a row needs a word; `plans/FS131-LU1-landing.md`; `data/fs131/lu1/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the registrations, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. This is the second landing on this machine today. The first went through the gate on its first full pass,
and its record is the pattern for yours — including what the machine can carry, which it measured.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The results about planes over number fields come first, and this module is the piece nearly all of them stand on: a
plane over a real number field maps homomorphically into each of its residue targets, so it needs no more colours
than they do. A planner typed it this morning and caught a false statement by typing; three implementers proved its
twenty-four leaves this afternoon with no statement changed. With it the kernel holds, on the standard three axioms:
the bound by the local bound for every real number field; the five-colour chain's headline with one of its named
hypotheses discharged; the plane over the field of the square root of 11 needs exactly four colours; the rational
plane exactly two. **None of the values is claimed as new mathematics** — the upper bounds are prior art, and what
is this project's is said in `LEDGER.md` § The claim list. Until the gate is green none of it is "held".

## The statements

The claim list, fixed before the module was planned, with its two dated lines:

{ST}
{NC}
{DL}
Where everything is, in your tree: the planner's record `{P}plans/FS131-KN2-upper-half-plan.md` (§ D: what the
landing needs; § Stage 5: its drafts for eight ledger rows, each conditional on its leaf landing); the three
implementers' records `{P}plans/FS131-IU1-implementation.md`, `{P}plans/FS131-IQ1-implementation.md` and
`{P}plans/FS131-IV1-implementation.md` — **the last gathers the drafts for the landing in one place** (the audit
block of 52 records, `{P}data/fs131/iv1/audit-block.txt`; the model table; the three lines for the assumptions
step; its predicted counts). The last landing's record `plans/FS131-LC1-landing.md` on `main` and its receipts
`data/fs131/lc1/gate/` — **its three final receipts are the "previous" side of your digests.**

## Done means

1. **Readback** (a saved stage): the seven quoted lines checked against the claim list; the four records read;
   `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`; the last landing's record, its
   stages 3 to 9. Merge `main` into the branch (it holds the last landing's module, its edits to the audit and
   assumptions scripts, and the front page as filed): trial the merge and name its conflicts first — the audit
   script, the build's lists and `ARCHITECTURE.md` are where they would be; keep both sides. Build.
2. **Docstrings, no statement**: the two rewordings the implementers left for the landing (the stable prime of the
   rational field, described by the proof's own route; the ramified homomorphism, "a ring homomorphism" where it
   says automorphism), and the reader's note on the ramified theorem (its two hypotheses are jointly satisfiable
   only when the divisible radicand is outside the set). The two stale comments in `SpectralChain.lean` that still
   call the upper half a hypothesis are **not** edited here — a comment there recompiles everything above it — and
   go into your open gate items.
3. **The registrations**: the 52 records as one block of yours in the audit script, each under the banner its
   axioms put it under (all on the standard three or fewer, by the implementers' prints); if the audit's
   state-reading controls go red on a count, move it by that file's own rule after seeing it red;
   `tools/check_architecture.py` exit 0; the doubled-name check.
4. **What the library assumes**: `./scripts/assumptions.sh --self-test`, then the step. **The module proves a
   statement the library has carried as a named hypothesis** (the upper half): by `LEAN.md` § The gate's rule the
   step fails until that hypothesis leaves the declared list. Make the edits the last implementer drafted, write
   the ledger with the script's own flag, and set what the step reports against its prediction (`rests=23` before
   the last landing made it 26; `inline` 16 to 15, `ours` 23 to 22, `takes` 98 to 106): any difference is a message
   to me.
5. **The vacuity step** and its `--self-test`: how the scan classes every new site; and name by hand the kernel
   model of each hypothesis-shaped headline — the two-colour theorems' is the stable prime of the rational field,
   which the instances file proves; the usable prime's first model in the library is the field of the square root
   of 11 at 7.
6. **Read aloud**, in your record: each headline theorem against its claim line and the dated lines, clause by
   clause — every hypothesis Lean has that the claim lacks and every one the claim has that Lean does not need;
   "into", never "onto", for the homomorphism; and for each exact value, the kernel theorem that holds its other
   half, by name with its axioms. A difference is a message to me before the gate runs.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search
   whose plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test`
   green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and
   `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build
   --trace`, under the slot), silent, with its planted control red; the notes check and the records check as the
   last landing ran them. The three digests against `data/fs131/lc1/gate/receipt-axioms-final.log`,
   `data/fs131/lc1/gate/receipt-vacuity-final.log` and `data/fs131/lc1/gate/receipt-assumptions-final.log` (say
   exactly which front-page lines they report stale). Every step's log saved under `data/fs131/lu1/gate/` and named,
   with its wall time and peak memory. Then one line to me, and stop.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LU1)", each with the log line
   it comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once
   (the last landing's `data/fs131/lc1/drafts-slots.py` is the pattern): the audit's and the gate's count lines and
   the assumptions counts in `CLAUDE.md`; a `GATE_CHANGES` entry; the ledger rows this module regrades, from the
   planner's and implementers' drafts checked against what landed (rows 52, 57, 63, 73, 99, 105, 119, 121, 123,
   127 — each only as far as its leaf landed; row 52's two further values are **not** in this module and stay as
   they are); the front page's sentences that say the upper bound is by hand or that only one inequality at the
   field of the square root of 47 is in the kernel; `LEAN.md`'s facts from the four records; the map's three
   corrections. And the open gate items at this landing, by name.
9. **Your record**, stages headed "Stage n — SAVED (FS131-LU1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with
   the gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; how the records are grouped; the batch size of each build; the
wording of an open gate item. Not yours: any statement; the fast-forward of `main`; a push; anything in another
tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md`, `LEAN.md` and older
landings' records do not apply.** Measured by the last landing here: every whole-library gate step is one `lean`
process of 4.4 to 5.1 GiB; a build in which only small modules are stale is 5.5 to 6.5 minutes at `BATCH=8` to `10`;
a build that recompiles 117 real modules is 47 minutes at `BATCH=2` with 8 GiB in its largest batch; the whole final
pass was 24 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lu1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build:
`--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. Implementers share the slot: on
exit 75 wait and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
every log your record cites lives under `data/fs131/lu1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+"data/fs131/briefs/FS131-LU1-landing.md","w").write(b); print("ok",len(b))
