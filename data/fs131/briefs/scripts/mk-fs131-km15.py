exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KM15: M15, the instances of the five-colour chain, Q(sqrt 47) first — typed, priced, then proved as far as the
# budget reaches, on the chain's joined line.
# Usage: mk-fs131-km15.py <item of IJN1's hand-back> <item of ICM2's hand-back> <item of the Searcher's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KJ,KC,KS=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wq1"; BR="fs131-wm15"; JOB="FS131-KM15"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wj"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
L23=Q(C,"NF2-LEAF-23: ","§ The chain's leaves (the map's, numbered as there)")
NC=Q(C,"NF2-NC: ","§ Not claimed")
W6=Q(RQ,"Once the chain lands, we'll do some sanitization")
MAP=W+"plans/FS131-KR1-chain-map.md"; RG=W+"Proofs/HadwigerNelson/"
for p in (MAP,W+"plans/FS131-IJN1-join.md",RG+"Rigidity/ChainHeadline.lean",RG+"Rigidity/ClassRatio.lean",RG+"SpectralChain.lean",
          RG+"Instances/SqrtFortySeven.lean",RG+"Instances/UpperHalfValues.lean",RG+"Arith/UpperHalf.lean",ROOT+"LEAN.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M15, the instances, `ℚ(√47)` first — typed, priced, and proved as far as you reach

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; on this job you also prove the leaves you plan, after your plan is saved (my ruling, item {KJ} (1))
  role: the kernel lane's planner and first prover for module M15 of the five-colour chain — the instance at `ℚ(√47)`: `NumberField` for its `Subfield ℝ`, `5 ≤ localBound` there by computing every stable prime and its level-one target, and `χ(ℚ(√47)²) = 5` composed from the chain's headline and the kernel's upper half; typed to its leaves with a plan per leaf, priced from first leaves, then proved in the plan's order as far as your budget reaches
  launch: now, in the chain's joined tree (its last job has handed back; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a statement of the chain is false at `ℚ(√47)` or needs a hypothesis it lacks, if a stable prime falls outside the map's reading (§ 2.7), if M15 needs a private leaf of `Rigidity/ClassRatio` made public, if the first leaves price M15 above 2,000 lines, and with one line when `χ(ℚ(√47)²) = 5` is stated and its axioms printed; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-instances.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wj` at `{TIP}`; its compiled library is current for that commit, build 5): new modules for M15 (under `Proofs/HadwigerNelson/Instances/` or `Proofs/HadwigerNelson/Rigidity/`, yours to choose) with their lines in the build's lists and `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/{JOB}-instances.md`; `data/fs131/km15/`; `data/fs131/reports/{JOB}.md`. **Not** any existing module's file — `Rigidity/ClassRatio.lean` is another job's on another branch (FS131-ICM3), and `Instances/SqrtFortySeven.lean`, `SpectralChain.lean` and the headline's module are read, not edited; any module under `Outside/`; the declared printed theorem. Untracked files of earlier jobs under `data/fs131/`: leave them. Nothing on `main`; no push
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the statements, after the plan per leaf with its price, and as leaves fall

Hello. The five-colour chain's headline is stated on this branch with every hypothesis the chain proves discharged:
for every real number field, `min(L(F), 5) ≤ χ(F²)`. What it is for is one field. `χ(ℚ(√47)²) = 5` answers a question
Moorhouse asked in 2010 and the existence half of Soifer's Open Problem 55.1, and it is the result whose landing starts
the repository's publication. You type the instance that reads the headline there, and prove it.

## Why this job

Kooshi's word for when the publication pass begins:

{W6}
In the plan's terms, "the chain lands" is `χ(ℚ(√47)²) = 5` through the gate on `main` with no hypothesis of ours left
(`plans/SESSION-HANDOFF-2026-10-14.md` § 1). M15 is the last module of that road nobody has typed.

## The statements

The chain's leaf for M15, and what the chain does not claim, from its claim list (`data/fs131/claims-NF2.md`):

{L23}
{NC}
The join's hand-back, the last hand-back on M13's line, and the day's search, as I logged them (their words in quotation
marks, the rulings mine):

{item(KJ)}
{item(KC)}
{item(KS)}
**Where everything is** (all in your tree): the map planner's record `{MAP}` § 2.7 — M15's statements, "No scope model is
needed", the reading of `5 ≤ L(ℚ(√47))` ("`47 ≡ 7 (mod 8)` puts no stable prime above 2; `3` and `7` are inert …"), the
floors at `p ∈ {{11, 19, 23, 31}}` and at every `p ≥ 43` by Weil, and the price; the headline
`{RG}Rigidity/ChainHeadline.lean`; `localBound`, `StablePrime` and `levelTarget` in `{RG}SpectralChain.lean`; M13's
per-prime class-ratio facts in `{RG}Rigidity/ClassRatio.lean` (`RatioAtMost`, `tca_of_five_le_localBound`, the private
leaves at each residue size); the field `F47` and the upper half `chromaticNumber_planeOver_sqrt47_le_five` in
`{RG}Instances/SqrtFortySeven.lean`; `{RG}Instances/UpperHalfValues.lean` and `{RG}Arith/UpperHalf.lean`; the join's record
`{W}plans/FS131-IJN1-join.md`. `LEAN.md` § Searching — Lean, and § The kernel's cost model.

**Two things the composition needs from elsewhere, each to be stated as a hypothesis or read by name, not proved here:**
the density bound (`Plane.OneAvoidingDensityBound`, the headline's `hOA`) is proved on another line and reaches `main`
at its landing, so your final theorem may take it as a hypothesis; and the per-residue-size class-ratio facts are M13's
(another job proves them on its line). If a fact you need is a private leaf of `ClassRatio`, tell me which: it is made
public on M13's line, and you read it by name — a fact is proved once.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut; the headline, `localBound`,
   `StablePrime` and `levelTarget` printed from the kernel and restated in one line each; § 2.7's reading restated step
   by step, with what each step needs from Mathlib at this pin (searched by name, `#check`ed).
2. **The statements typed** (a saved stage), `sorry` at the leaves only, each read aloud against NF2-LEAF-23 and § 2.7,
   each with a model: `NumberField` for `F47`; **every stable prime of `ℚ(√47)` and its residue size** as a statement of
   its own; `5 ≤ localBound F47`; and **`χ(ℚ(√47)²) = 5`** from the headline and the upper half, over the density bound
   as a hypothesis at most. **The domain pass as a fresh skill invocation on every new definition, and the obligation pass
   on every new statement**, and every instance and definition's stored type read for a class binder its section declares
   (item 847's defect).
3. **Priced from first leaves** (written in scratch, elaborated, measured) — at least the stable-prime classification's
   hardest leaf; every classical input named and searched for by name; **no axiom declared**. The next field's price
   (`ℚ(√143)`), one line, from the same measure.
4. **The leaves proved** in the plan's order, as far as you reach; then one build under the slot with no warning from your
   files but their remaining leaves'; the axioms of every public declaration of your files printed from the built tree —
   the standard three, Weil's bound, `positive_entropy_rigidity`, or `sorryAx` only through named leaves, each listed; the
   guarded lint (`lake lint --no-build -- --no-build --trace`) with no finding in your files.
5. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with leaves
   left, each named with its plan, is a good report.

## What is yours to decide

How M15 is cut into modules; the route of each leaf; the order after item 1; how far into item 4 you reach. An unread
binder of a statement of yours is dropped. Not yours: a declared axiom; a change to a typed statement of another module
without my ruling; an edit to any existing module's file; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wj` at build 5. One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name km15 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. On exit 75 wait ten minutes and retry. A cap kill under a
`timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is
wiped at power-off: anything your record cites lives under `data/fs131/km15/`. Report at once any disk, memory or count
reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-instances.md","w").write(b); print("ok",len(b))
