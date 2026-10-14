exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICL2: the count's second implementer — the join of the count's first lanes with the chain's line, then lanes Λ2
# (the finite side) and Λ3 (the archimedean side and the completion), item 847's repair, and the model at Q.
# Usage: mk-fs131-icl2.py <item of K12A's hand-back> <item 847> <item of IJ1's hand-back> <item of ICL1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KC,KS,KI,KL=[int(x) for x in sys.argv[1:5]]
TREE="fs131-wch"; BR="fs131-wcl2"; JOB="FS131-ICL2"; W=WT+TREE+"/"; JOIN="1e438c171"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wcl" and [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/icl1/")]==[]
assert sh("git","-C",ROOT,"merge-base","--is-ancestor",JOIN,"fs131-wt3")=="" and subprocess.run(["git","-C",ROOT,"merge-base","--is-ancestor",JOIN,"fs131-wt3"]).returncode==0
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
DA=Q(C,"- 2026-10-14 — **One archimedean factor**","§ Dated lines")
PK=W+"plans/FS131-K12A-count.md"; RG=W+"Proofs/HadwigerNelson/"
PL=W+"plans/FS131-ICL1-implementation.md"
for p in (PK,PL,RG+"Rigidity/FiniteZhang.lean",RG+"Rigidity/CountResidue.lean",RG+"Rigidity/CountDescent.lean",RG+"Rigidity/CountTorus.lean",RG+"Rigidity/CountCompletion.lean",
          W+"data/fs131/k12a/leaves/LeafK.lean",W+"data/fs131/k12a/leaves/LeafR.lean",W+"data/fs131/k12a/leaves/LeafZ.lean",W+"data/fs131/k12a/leaves/LeafE.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain's count: its first lanes joined with the chain's line, then the finite side and the completion proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the count's second implementer — first the merge of the count's proved lanes Λ1 and Λ4 (branch `fs131-wcl`) into the chain's line after the ring-map replacement; then lane Λ2, the finite side (Zhang's bound on the finite targets, the residue rings, the descent), with the one ruled repair of a skeleton instance's stored type; then lane Λ3, the archimedean side and the completion; then the model at the rationals that shows the count's hypotheses inhabited, as far as you reach
  launch: now, in the count's last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from the chain's line; the chain's implementer proves M3 and M2b in another tree on that line, the M11 planner types in a third, the certificate implementer works on its own line; all share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the merge conflicts anywhere but `ARCHITECTURE.md` and `Proofs.lean`, if a leaf is false as stated or needs a hypothesis it lacks, if the first two leaves of a lane price it above twice the planner's lines, if a stored statement lacks a class binder its section declares beyond the one ruled below, and with one line when the merged tree builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from the chain's line at `{JOIN}` (`git checkout -b {BR} {JOIN}`) and into which you merge `fs131-wcl` with `--no-ff` as your first commit, `ARCHITECTURE.md`'s and `Proofs.lean`'s conflicts resolved by keeping both sides; then **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/FiniteZhang.lean`, `CountResidue.lean`, `CountDescent.lean` (lane Λ2), `CountTorus.lean` and `CountCompletion.lean` (lane Λ3), with one ruled exception: the instance `Counting.finite_quot` in `CountResidue` gains `[NumberField F]` in its stored type when proved (item {KS} ruling 2), dumped before and after; a new module `Proofs/HadwigerNelson/Rigidity/CountModels.lean` for the model at the rationals, with its lines in the build's lists and `ARCHITECTURE.md`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/icl2/`; `data/fs131/reports/{JOB}.md`. **Not** `WindowDensity`, `PlaneZhang`, `CountExtension` (proved), `Plane/OneAvoidingDensity.lean` (the paper's statement; its proof is the density bound's job), `Rigidity/ContinuityGroup.lean`, `ClassRatio.lean` (M13's), `InvariantMeasure.lean` and `BochnerTau.lean` (in another tree now), any module under `Outside/`, the declared printed theorem. Untracked files of the last job are in `data/fs131/icl1/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The count's first implementer proved its plane lane and its extension lane in under an hour, at a third to
three fifths of the planned lines. The chain's join implementer has meanwhile replaced the count's ring map by lane T's,
in the two files the last two lanes work in. You bring the two together and prove the rest of the count.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The count is the chain's longest single module, on its critical path; these two lanes are the rest of it.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the count is and the shorter
route it takes:

{DC}
{DA}
The count planner's hand-back, the ruling on the skeleton instance, the join implementer's hand-back and the count's
first implementer's, as I logged them (their words in quotation marks, the rulings mine):

{item(KC)}
{item(KS)}
{item(KI)}
{item(KL)}
**Your work, in order.** (1) **The merge** and one build under the slot. (2) **Λ2** — `FiniteZhang`, `CountResidue`,
`CountDescent` (the planner's record `{PK}` § 5.2, row Λ2; the plan per leaf § 3.2): open with `ratioLe_prod`; the leaf
`Counting.ofUnitRing_mem_localRing` follows in two lines from `ofUnitRing_mem_stableIntegers` and `mem_stableIntegers`
(item {KI}); `finite_quot` as ruled. Λ2 reads M13's `tca_uniform` as stated (M13's proof is another job's). (3) **Λ3** —
`CountTorus`, `CountCompletion` (§ 5.2, row Λ3): open with `mem_closure_pow`, to re-price block A; the first leaves of
blocks K, R, Z and E are proved in scratch in `{W}data/fs131/k12a/leaves/` — fold in those that are this lane's.
(4) **The model at the rationals** — an `InvariantColouring` at F = ℚ, its route and price drafted by the last implementer
(its record `{PL}` § 6.2) — in `Rigidity/CountModels`. Re-price each lane from its first two leaves and tell me if one
prices over a week.

## Done means

1. **Readback** (a saved stage, and the one line to me when the merged tree builds): the quoted lines checked against
   their sources; each leaf's statement restated in one line beside its plan; the stored statements of your five files
   dumped from the built tree before any edit — reading every instance and definition for a class binder its section
   declares and its stored type lacks.
2. **Λ2** (saved stages as leaves fall); re-priced from its first two leaves.
3. **Λ3** (saved stages as leaves fall); re-priced from its first two leaves.
4. **The model** (a saved stage).
5. **No statement and no definition changed** but the ruled one, shown from the kernel's side against item 1's dump (a
   planted change watched firing); one build under the slot with no warning from your files but their remaining leaves';
   the axioms of every public declaration of your files, and of `Counting.count_of_oneAvoidingDensityBound`, printed from
   the built tree — the standard three, or `sorryAx` only through named leaves — each listed, with a planted record
   watched showing.
6. **Drafts for the landing**, in your record: the audit's block for your files; the models; any `LEAN.md` lines.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each lane; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wcl`; your branch adds the join implementer's changes (a
small rebuild, minutes). One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icl2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`. The certificate job holds up to 10 GiB of the slot for long stretches: on exit 75 wait ten minutes and
retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/icl2/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-count-finite-completion.md","w").write(b); print("ok",len(b))
