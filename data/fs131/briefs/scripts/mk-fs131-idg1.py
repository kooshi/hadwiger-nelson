exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IDG1: the chain's third implementer — the dual group (lane D), Pontryagin duality (lane PD-I), the unit circle
# (lane U), on a branch that first joins the chain's proved lanes (fs131-wl1) into the duality planner's branch (fs131-wpd).
# Usage: mk-fs131-idg1.py <item of IN1L's hand-back> <item of KPD1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KI,KP=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wq1"; BR="fs131-wdg"; JOB="FS131-IDG1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wpd"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "iq1/stmt" not in l]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); WL=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wl1")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DP=Q(C,"- 2026-10-14 — **Pontryagin duality for a countable discrete group needs no Peter–Weyl","§ Dated lines")
D3=Q(C,"- 2026-10-14 — **PE-1′'s connectedness is a third duality fact","§ Dated lines")
P8=W+"plans/FS131-KN8-chain-split.md"; PP=W+"plans/FS131-KPD1-pontryagin.md"; RT=W+"data/fs131/kpd1/route/"
IL=WT+"fs131-wch/plans/FS131-IN1L-implementation.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (P8,PP,RT,IL,RG+"DualGroup.lean",RG+"UnitCircle.lean",RG+"Duality.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the dual group, Pontryagin duality and the unit circle, proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's third implementer — three lanes its last two planners left ready, on one branch that first joins the chain's proved lanes into the duality planner's branch: the dual of a countable group as a compact Polish group with Fourier uniqueness and Haar measure; Pontryagin duality over it; the unit vectors as a group acting by rotation
  launch: now, in the duality planner's tree (its job is finished; nobody else writes there) on a new branch; the port's implementer works in `fs132-wi1` and the density equality's in `fs133-wk1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the join does not go through as described, and with one line when lane D's leaves are proved; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wpd` at `{TIP}`; its build is current for that commit) and into which you merge `fs131-wl1` (at `{WL}`) with `--no-ff` as your first commit (`git merge-tree` reports it clean); then, **proofs, private helpers and import lines only — no statement changes, no definition changes**: `Proofs/HadwigerNelson/Rigidity/DualGroup.lean`, `Proofs/HadwigerNelson/Rigidity/Annihilator.lean`, `Proofs/HadwigerNelson/Rigidity/SubgroupHaar.lean`, `Proofs/HadwigerNelson/Rigidity/Duality.lean`, `Proofs/HadwigerNelson/Rigidity/DualConnected.lean`, and `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean` except its leaf `exists_admissiblePair`; and, from the chain's last implementer's drafts (its record § Drafts for the landing), the `ARCHITECTURE.md` imports cell of `Rigidity/ZeroEntropyNames` and the rows of its three modules, and the stale module docstrings it names (prose only); your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/idg1/`; `data/fs131/reports/{JOB}.md`. **Not** `exists_admissiblePair`, `Rigidity/Pieces.lean`, `Rigidity/EntropySplitMax.lean`, `Rigidity/ChainAtTA.lean`, the entropy file's tenth leaf, any module under `Outside/`, the declared printed theorem. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`
  budget: {BUDGET}

Hello. This chain is the first-ranked thing this project has to show. Its last implementer proved three lanes and with
them the theorem that assembles the headline from its eight hypotheses; its last planner found that the Pontryagin
duality the chain reads costs hours, not the week it was feared to, because it rests on one module of the chain's own
that is not proved yet: the dual group's. You prove that module, the duality over it, and the unit-circle module beside
them.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
Every duality headline of the chain reaches an unproved step only through the dual group's leaves, Fourier uniqueness
above all; with them proved, the pieces' module and the positive-entropy split can be built on solid ground.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the duality lane now is:

{DP}
{D3}
The two hand-backs as I logged them (their words in quotation marks, the rulings mine):

{item(KI)}
{item(KP)}
**Your leaves**: lane **D**, the thirteen leaves of `{RG}DualGroup.lean` (the plan per leaf: `{P8}` § 2.5, with item 757
on Fourier uniqueness by Mathlib's `ext_of_forall_mem_subalgebra_integral_eq_of_polish` and Haar by `haarMeasure ⊤`);
lane **PD-I**, the four duality modules, whose proofs are written and measured in the planner's copies `{RT}` (26 of 28
leaves elaborate there) — fold them in, prove the two spec leaves the planner left (its record `{PP}` § 4.1), build, and
compare the stored terms; lane **U**, `{RG}UnitCircle.lean`'s leaves other than `exists_admissiblePair` (the plan:
`{P8}` § 2.5). The order: D first (PD-I's headlines rest on it), then PD-I, then U. The last implementer's record
`{IL}` is the worked pattern for this chain's files (its join, dumps and axiom checks) and holds the drafts for the
architecture cell and the docstrings.

## Done means

1. **The join and the readback** (a saved stage): the merge commit; one build under the slot of the joined tree; the
   quoted lines checked against their sources; each leaf's statement restated in one line beside its plan; the stored
   statements of your six files dumped from the built tree before any edit.
2. **Lane D** (saved stages as leaves fall, and the one line to me when they are all proved); re-price what is left
   from the first two leaves and say so.
3. **Lane PD-I** (a saved stage): the route copies folded in, the two spec leaves proved, the stored terms compared
   with the planner's dump (no statement moved).
4. **Lane U** (a saved stage).
5. **The architecture cell and the docstrings** from the last implementer's drafts; `tools/check_architecture.py` passes.
6. **No statement and no definition changed**, shown from the kernel's side against the dump of item 1 (a planted
   change watched firing); no `sorry` left in your files but `exists_admissiblePair`; one build under the slot with no
   warning from them but that leaf's; the axioms of every public declaration of your files printed from the built tree —
   the standard three and nothing else, with a planted record watched showing.
7. **Drafts for the landing**, in your record: the audit's block for your files; the model for each hypothesis that
   lacks one; any `LEAN.md` lines.
8. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports a proof needs; another route for a leaf where the plan's does not go through (tell
me which). An unread binder of a statement in your files is dropped without asking, listed in your statement check as a
ruled difference and named in your report (the standing word of item 726). Not yours: any other change to a statement or
definition; the leaves listed as not yours; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wpd`; the join adds the entropy branch's three ported
modules and its proved files, so the first build compiles them (expect 10–20 minutes). One file through `lake env
lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idg1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`. On
exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/idg1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-dual-group.md","w").write(b); print("ok",len(b))
