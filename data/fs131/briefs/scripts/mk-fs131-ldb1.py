exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LDB1: the landing of the density bound m1(R^2) <= 0.2470 ([AmbrusEtAl2023] Thm 1) on main, through the full gate.
# Usage: mk-fs131-ldb1.py
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-w10g"; BR="fs131-wldb"; JOB="FS131-LDB1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wdb3"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
RQ="data/fs131/REQUEST-2026-10-13.md"; C="data/fs131/claims-NF2.md"
D1=Q(C,"- 2026-10-14 — **The density bound has a route with no periodic reduction","§ Dated lines")
LD="plans/FS133-LD1-landing.md"
for p in (ROOT+LD,ROOT+"data/fs133/ld1/gate/receipt-axioms-final.log",ROOT+"data/fs133/ld1/gate/receipt-vacuity-final.log",
          ROOT+"data/fs133/ld1/gate/receipt-assumptions-final.log",ROOT+"data/fs133/ld1/drafts-slots.py",
          W+"plans/FS131-IDB3-implementation.md",W+"plans/FS131-IDB2-implementation.md",W+"plans/FS131-IDB1-implementation.md",W+"plans/FS131-KDB1-density-bound.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — land the density bound `m₁(ℝ²) ≤ 0.2470` on `main` through the full gate

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the lander of the density bound — `[AmbrusEtAl2023]` Theorem 1, every Lebesgue-measurable planar set with no two points at distance one has upper density at most 0.2470, proved on its own line in about sixty modules (Bessel functions, the Fourier side, the window, the paper's certificate checked by the kernel); you merge `main` into it, take it through every step of the gate on one commit, read its headline aloud, and draft the front-page lines; the merge into `main` is the coordinator's, at your green line
  launch: now, in the density bound's tree — its last job has handed back and nobody else writes there; three other jobs work in other trees and share the build slot; `main` at `{MAIN}`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if the merge conflicts outside `ARCHITECTURE.md` and `Proofs.lean`, if a gate step fails in a way the records do not explain, if the read-aloud finds the statement saying more or less than the paper's, and **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wdb3` at `{TIP}`; its build holds the whole bound) and into which you merge `main` (`git merge-tree` reports no conflict); docstrings, prose only, where they are stale; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`, `ARCHITECTURE.md` as the gate's steps require; your checks under `tools/` named for this job; `plans/{JOB}-landing.md`; `data/fs131/ldb1/`; `data/fs131/reports/{JOB}.md`. **Not** any statement or definition; any generated module's text (regenerate only through its generator, unchanged); the paper's certificate files; anything in another tree. Nothing on `main`; no push
  budget: {BUDGET}; save a stage after the readback, after the merge builds, after each gate step that passes, and at the green line

Hello. Kooshi asked this morning for the density bound to be proved here rather than assumed. Four jobs did it today, on
a route with no periodic reduction and no Bessel citation, the certificate checked by the kernel with no `native_decide`.
You make it held.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W2: ")}
His answer, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The five-colour chain's count reads the
bound; on `main` it will read it with no outside hypothesis.

## The statements

The dated line of the chain's claim list that says what the route is:

{D1}
And the four hand-backs behind this landing, as I logged them (their words in quotation marks, the rulings mine):

{item(845)}
{item(866)}
{item(895)}
{item(911)}
The headline is `Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound` (`Plane/DensityBound/Theorem`). The records
of the four jobs are in this tree (`{W}plans/FS131-KDB1-density-bound.md`, `{W}plans/FS131-IDB1-implementation.md`,
`{W}plans/FS131-IDB2-implementation.md`, `{W}plans/FS131-IDB3-implementation.md`), each with drafts for this landing. The last
landing's record on `main` is `{LD}` — its receipts `data/fs133/ld1/gate/` are **the "previous" side of your digests**, and
its slot checker `data/fs133/ld1/drafts-slots.py` is the pattern for yours.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `LEAN.md` § The gate, § Assumptions and
   § Trust ledger as they stand on `main`. Merge `main` (a trial first); build under the slot.
2. **Read aloud**, in your record: the headline's stored statement against the paper's Theorem 1 (p. 4) — word for word,
   the library's `OneAvoidingDensityBound` against the paper's sentence — and the three places the library asks for less
   (IDB2's reading, item 895).
3. **The full gate on one commit**, as the last landing ran it (its record § Stage 5): `./scripts/build.sh` with zero
   warnings; zero `sorry` in `Proofs/` (a search whose plant fires); the doubled-name check and its `--self-test`;
   `scripts/axioms.sh` clean with `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled;
   `./scripts/assumptions.sh` and `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint, silent, with its
   planted control red; the notes check and the records check; every generator's `--check` on its generated modules. The
   three digests against `data/fs133/ld1/gate/receipt-axioms-final.log`, `data/fs133/ld1/gate/receipt-vacuity-final.log` and
   `data/fs133/ld1/gate/receipt-assumptions-final.log`; predict this landing's counts before the run and reconcile every
   difference. Every step's log saved under `data/fs131/ldb1/gate/` with its wall time and peak memory. Then one line to me.
4. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes
   from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once (give the
   fact-audit tool's table every token your drafts retire): the audit's, the gate's and the assumptions' count lines in
   `CLAUDE.md`; a sentence in § Where the problem stands for the bound and for `m₁(ℝ²) < 1/4` with no hypothesis
   (`Plane.mOne_lt_quarter`); `LEDGER.md` where row 129 or another row cites the bound; `ARCHITECTURE.md` § Trust; the
   `LEAN.md` lines from the four records; the bibliography's `[AmbrusEtAl2023]` and `[KMOR2016]` rows (with p. 18's sign of
   `J₀′`); a `GATE_CHANGES` entry. **Whose it is**: the theorem is `[AmbrusEtAl2023]`'s; the finite-window route, the
   formalization and the kernel check are this project's. And the open gate items, by name.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in the standing rules' form. Leave no process running
   or queued. Stopping at a saved stage with the gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; the batch size of each build; the wording of a docstring or an open
gate item. Not yours: any statement; any generated module's text; the merge into `main`; a push.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** The merge adds `main`'s port (31 generated modules) and the density equality's eight; the first build compiles
them. Every whole-library gate step is one `lean` process of up to about 5.5 GiB; the last landing's final pass took about
35 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ldb1 -- <command>`

A gate step over the whole library: `--mem 8`. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`;
never `lake build`. On exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: every log your record cites
lives under `data/fs131/ldb1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a local
backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-landing.md","w").write(b); print("ok",len(b))
