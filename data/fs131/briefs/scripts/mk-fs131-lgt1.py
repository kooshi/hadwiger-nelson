exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LGT1: the five-colour chain's landing, part 3 — the full gate on one commit of the joined branch, the read-aloud,
# the drafts for the front page; the lander (FS131-LCH1) handed back before the gate, past its line.
# Usage: mk-fs131-lgt1.py <item 940> <item 941> <item 942>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K940,K941,K942=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wq1"; BR="fs131-wlc"; JOB="FS131-LGT1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
RQ="data/fs131/REQUEST-2026-10-13.md"; C="data/fs131/claims-NF2.md"
W6=Q(RQ,"Once the chain lands, we'll do some sanitization")
L23=Q(C,"NF2-LEAF-23: ","§ The chain's leaves (the map's, numbered as there)")
R121=Q("LEDGER.md","| 121 | ","§ The novel-results ledger")
REC=W+"plans/FS131-LCH1-join.md"; LDB=ROOT+"plans/FS131-LDB1-landing.md"
for p in (REC,W+"data/fs131/reports/FS131-LCH1.md",LDB,ROOT+"data/fs131/ldb1/gate",W+"data/fs131/lch1/draft-axioms-block.lean",
          W+"data/fs131/lch1/ring-scope-lemma-c-prime.lean",ROOT+"LEAN.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain's landing, part 3: the full gate on one commit

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the gate-runner of the five-colour chain's landing — you take the joined branch the last lander left building with no `sorry`, write the gate's inputs it drafted (the audit's blocks, the assumptions ledger, the vacuity counts), run the full gate on one commit as the density bound's landing ran it, read the two headline statements aloud against their claims, and draft the front page
  launch: now, in the lander's tree on its branch (the lander has handed back; nobody else writes there); no other job is running
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way that needs any statement or definition changed, if a count moves and you cannot say why, if any disk, memory or count reading is near its limit, and with one line at the green commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-gate.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{TIP}`; its compiled library is current for those sources — build 5, sources as at `2fcba050a`): `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`, `ARCHITECTURE.md` and the gate's other inputs as the gate needs them; a docstring, a lint attribute or a proof where a gate step fails on it (a statement or definition change: ask me first); your checks and scripts under `tools/` and `data/fs131/lgt1/` named for this job; `plans/{JOB}-gate.md`; `data/fs131/lgt1/`; `data/fs131/reports/{JOB}.md`; and, at your hand-back, deleting the four uncommitted raw dumps `data/fs131/lch1/statements-*.txt` (their sha256 sums are committed). **Not** `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md` (you draft their lines; I file them); any generated module's text; any module under `Outside/` or `Plane/DensityBound/`. Nothing on `main`; no push
  budget: {BUDGET}; save a stage after the readback, after the gate's inputs are written, at the green commit, and at the hand-back

Hello. The five-colour chain is joined: on this branch, every line it needs is merged, every ruled integration is
applied, and the library builds with no `sorry`. `χ(ℚ(√47)²) = 5` prints with no hypothesis. The last lander ran the
gate's steps that read the tree, and its budget ran out before the full gate on one commit. You run that gate. When it is
green and I have merged it, the chain has landed.

## Why this job

Kooshi's word for when the publication pass begins:

{W6}
In the plan's terms, "the chain lands" is `χ(ℚ(√47)²) = 5` through the gate on `main` with no hypothesis of ours left
(`plans/SESSION-HANDOFF-2026-10-14.md` § 1). The gate takes the whole library, so this one commit is the landing.

## The statements

What the two headline statements answer — the chain's leaf for the instance, from its claim list, and row 121 of the
ledger:

{L23}
{R121}
The landing's last three items as I logged them — the lander's part 2 and the announcement rule, the one `sorry` ruled,
and the lander's hand-back (their words in quotation marks, the rulings mine). Every quotation in this section is
from the main checkout `/home/kooshi/source/lean-dir/`, whose inventory is current; your tree's copy is older:

{item(K940)}
{item(K941)}
{item(K942)}
**Where everything is** (in your tree unless the path says otherwise): the lander's record `{REC}` — its § "Drafts for
part 2 — what is left, in order" is your work list (the audit's blocks, the coverage run, the assumptions step, vacuity,
the lint's negative control, the read-aloud, the front-page drafts), its § Stage 4 and § Stage 5 the state you start
from, its § "Drafts for `LEAN.md`" lines to carry into your drafts; its report `{W}data/fs131/reports/FS131-LCH1.md`. The
density bound's landing `{LDB}` § Stage 5 is how the full gate was run last time (one pass, every step in order, under the
slot; `/home/kooshi/source/lean-dir/data/fs131/ldb1/run-gate.sh`; every log with its exit status on its last line), § "Drafts for the front page (FS131-LDB1)" is the
form of the drafts, and its logs `/home/kooshi/source/lean-dir/data/fs131/ldb1/gate/` are the previous side of every
digest you compare. The drafted chain block `{W}data/fs131/lch1/draft-axioms-block.lean` must be regenerated (its one OPEN
record, Lemma C′, is deleted). The records drafting the other lines' blocks are on this branch: FS131-IKL1's § 4.3,
FS131-IKC4's and FS131-ICM4's records under `plans/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch's head checked, and its
   sources against `2fcba050a` outside `plans/` and `data/`; the work list restated in your record, one line per step,
   with the previous landing's log it compares against.
2. **The gate's inputs** (a saved stage): the audit's blocks for the chain, the link, the `p = 19` line and the dyadic
   line in `scripts/Axioms.lean`, and a coverage run (every public constant a record or reached); the assumptions step
   (`--self-test`, a run, `--write-ledger`, the nine counts); the vacuity scan (`--self-test`, the counts reconciled
   against `main`'s `declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38
   generic=1411 unknown=2`); the lint's negative control. Each count that moves, explained in one line.
3. **The full gate on one commit** (a saved stage): one pass, every step in order, under the slot, as `{LDB}` § Stage 5
   ran it — the build, zero `sorry`, the axiom audit, the lint, the statement check against the lander's dumps, vacuity,
   assumptions, `dupnames`, architecture, coverage — every log under `data/fs131/lgt1/gate/` with its exit status, the
   commit's full hash recorded, each check's control watched firing. **The one line to me at the green commit.**
4. **Read aloud** (in your record): `Rigidity.min_localBound_five_le_chromaticNumber` and
   `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`, each printed from the gated build with its axioms, read
   against NF2-LEAF-23 and row 121 above, every binder and every defined term traced to its definition; then M15's other
   values against `LEDGER.md` row 123.
5. **Drafts for the front page**, in your record, in the density bound's landing's form, each slot checked once by a
   script: `CLAUDE.md` (the Frontier's lines, "What the kernel holds", the Trust ledger — the library now declares a third
   outside theorem, `Rigidity.positive_entropy_rigidity` —, the assumptions' counts, the gate's counts), `LEDGER.md` rows
   121, 123 and 127 regraded with what they rest on, `LEAN.md` lines (the lander's among them), and bibliography lines.
6. The report in the standing rules' form. Delete the four raw dumps once the gate's statement check has read them. Leave
   no process running or queued. Stopping at a saved stage with what is left named is a good report.

## What is yours to decide

The order inside each step; how each input is generated; the scripts; what to do when a step fails, within your touches;
the drafts' wording. An unread binder of a statement is reported to me, not dropped. Not yours: any statement or
definition change; the files listed as not yours; the merge into `main`; a push.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 308 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for its sources (build 5). One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lgt1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. **The build, measured by the last lander:** `--mem 16 --cpus 4 -- env MEMMAX=16G
BATCH=2 ./scripts/build.sh` for any build that recompiles the density bound's cells or the `p = 19` checks (at `BATCH=8`
and 10 GiB the kernel's OOM killer stops it inside its scope); `BATCH=8` at 10 GiB only when neither is stale. Never
`lake build`; do not edit a file a running build will compile. A whole-library gate step: `--mem 8`. On exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never
by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/lgt1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-gate.md","w").write(b); print("ok",len(b))
