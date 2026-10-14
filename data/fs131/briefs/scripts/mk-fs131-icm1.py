exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICM1: the chain's implementer on the count's line — the count's last leaf and its model at Q, then M13 (the
# class-ratio module): its per-prime leaf by residue size, Lemma P, the uniform tail.
# Usage: mk-fs131-icm1.py <item of KR1's hand-back> <item of KC13's hand-back> <item of ICL2's hand-back> <item of IKC2's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KR,KC,KL,KK=[int(x) for x in sys.argv[1:5]]
TREE="fs131-wch"; BR="fs131-wcm"; JOB="FS131-ICM1"; W=WT+TREE+"/"; JOIN=""; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wcl2" and [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not (l.startswith("?? data/fs131/icl1/") or l.startswith("?? data/fs131/icl2/"))]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
DA=Q(C,"- 2026-10-14 — **One archimedean factor**","§ Dated lines")
PK=W+"plans/FS131-K12A-count.md"; RG=W+"Proofs/HadwigerNelson/"
PL=W+"plans/FS131-ICL2-implementation.md"; PM=W+"plans/FS131-KR1-chain-map.md"; WN=WT+"fs131-wnf/"; PC=WN+"plans/FS131-KC13-certificates.md"
DT=Q(C,"- 2026-10-14 — **The class-ratio checker is proved sound**","§ Dated lines")
for p in (PK,PL,PM,PC,RG+"Rigidity/ClassRatio.lean",RG+"Rigidity/CountCompletion.lean",RG+"Arith/NormOneTarget.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the count's last leaf, then the class-ratio module M13 proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer on the count's line — first the count's own last leaf (`Counting.tendsto_haarK_bad`) and the model at the rationals that shows the count's hypotheses inhabited; then M13, the class-ratio module (`Rigidity/ClassRatio`: at each stable prime one ratio bound below one quarter for every set with no two adjacent points in every level's target — the per-prime leaf by residue size, Lemma P lifting level one to all levels, and the uniform tail), as far as you reach; the certificate branch at residue sizes 11 and 19 reads the checker proved sound on another line, so that link stays a named leaf here
  launch: now, in the count's last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a branch's first two leaves price it above twice its plan, if a stored statement lacks a class binder its section declares (item 847's defect), and with one line when `count_of_oneAvoidingDensityBound` rests on no leaf of the count's own; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wcl2` at `{TIP}`; its build is current for that commit): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/CountCompletion.lean` (its one leaf) and `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (M13's leaves); new modules for M13's branches under `Proofs/HadwigerNelson/Rigidity/` or `Proofs/HadwigerNelson/Arith/` if the leaves are better public, and `Proofs/HadwigerNelson/Rigidity/CountModels.lean` for the model, with their lines in the build's lists and `ARCHITECTURE.md`; their rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/icm1/`; `data/fs131/reports/{JOB}.md`. **Not** the count's proved files, `Arith/FibreCert*` (on another line; read its statement by address, do not copy it), any module under `Outside/`, the declared outside theorem `StandingFive.kloosterman_bound` (read as declared), the declared printed theorem. Untracked files of the last jobs are in `data/fs131/icl1/` and `data/fs131/icl2/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The count is proved but for four named leaves, and one of them is its own. Another is M13's uniform bound
`tca_uniform`, which reads M13's per-prime leaf. You take both: the count's leaf and its model first, then M13.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
M13 is upstream of the count and on the chain's critical path; the count's statement reads `tca_uniform`.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the count reads from M13 and what
the certificate checker now holds:

{DC}
{DT}
The map planner's, the certificate planner's, the count's last implementer's and the certificate implementer's
hand-backs, as I logged them (their words in quotation marks, the rulings mine):

{item(KR)}
{item(KC)}
{item(KL)}
{item(KK)}
**Your work, in order.** (1) **`Counting.tendsto_haarK_bad`** by the route in the last implementer's record `{PL}`
§ Stage 5 (150–250 lines), and **the model at the rationals** in `Rigidity/CountModels` (the route drafted in
`{W}plans/FS131-ICL1-implementation.md` § 6.2). (2) **M13**: the map planner's route `{PM}` § 2.6 — (a) the exclusions at
`L ≥ 5`, (b) Lemma P and the levels, (c) level one by residue size (`q ≥ 37` by Weil through the library's Hoffman bound
`RatioBound.card_mul_le_of_indep` and `NormOneTarget.targetFloor_of_charSum`; `q ∈ {{23, 27, 31}}` by exact spectra; the dyadic
sizes), (e) the uniform tail — and the certificate planner's record `{PC}` § 5.2 (K3, K4 = Lemma P, K5) and § 5.3 (the
exact certificates at 23 and 31). **The branch at `q ∈ {{11, 19}}`** reads `FibreCertSound.card_le_of_certOK` and the two
certificates' checks, which live on the line `fs131-wc15` (from `main`); state that link here as one named private leaf
with its exact statement, to be closed when the lines are joined — do not copy the checker. Re-price each branch from
its first two leaves and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit — reading every
   instance and definition for a class binder its section declares and its stored type lacks.
2. **The count's leaf and its model** (a saved stage, and the one line to me).
3. **M13's branches** (saved stages as leaves fall); re-priced from their first two leaves.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files and of `count_of_oneAvoidingDensityBound` printed from the built tree — the
   standard three, Weil's bound where the branch at `q ≥ 37` reads it, or `sorryAx` only through named leaves — each
   listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the new modules; imports; the order inside M13; another route for a leaf where the plan's
does not go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word,
listed and named. Not yours: any other change to a statement or definition; a new declared axiom; the files listed as not
yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wcl2`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB; an exact-spectrum check is kernel seconds (the certificate planner's estimate).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icm1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. On exit 75 wait ten minutes and retry. A cap kill under a
`timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is
wiped at power-off: anything your record cites lives under `data/fs131/icm1/`. Report at once any disk, memory or count
reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-count-leaf-m13.md","w").write(b); print("ok",len(b))
