exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICL1: the count's first implementer — lane Λ1 (the plane: WindowDensity, PlaneZhang), then lane Λ4 (the
# extension: CountExtension), on a branch cut from the chain's joined commit.
# Usage: mk-fs131-icl1.py <item of K12A's hand-back> <item of the join's build notice>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KC,KJ=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wcl"; JOB="FS131-ICL1"; W=WT+TREE+"/"; JOIN="3ae198eac"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wk12" and sh("git","-C",W,"status","--porcelain")==""
assert sh("git","-C",ROOT,"merge-base","--is-ancestor",JOIN,"fs131-wt3")=="" and subprocess.run(["git","-C",ROOT,"merge-base","--is-ancestor",JOIN,"fs131-wt3"]).returncode==0
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
DA=Q(C,"- 2026-10-14 — **One archimedean factor**","§ Dated lines")
PK=W+"plans/FS131-K12A-count.md"; RG=W+"Proofs/HadwigerNelson/"
for p in (PK,RG+"Plane/WindowDensity.lean",RG+"Rigidity/PlaneZhang.lean",RG+"Rigidity/CountExtension.lean",RG+"Plane/OneAvoidingDensity.lean",
          W+"data/fs131/k12a/leaves/LeafP.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain's count: the plane's lane and the extension's lane proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the count's first implementer — lane Λ1, the plane (the windowed density of a set in the plane, and the plane's Zhang-type bound on pair measures), then lane Λ4, the extension (a character of the continuity group extended), as far as you reach; the count is the module that turns a field's local data at its stable primes into the statement the chain's measure-theoretic half reads
  launch: now, in the count planner's tree (its job is finished; nobody else writes there) on a new branch cut from the chain's joined commit; the chain's join implementer works in another tree on the same line, in other files; three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the first two leaves of a lane price it above twice the planner's lines, if a stored statement lacks a class binder its section declares (item 847's defect), and with one line when the joined tree builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from the chain's joined commit `{JOIN}` (`git checkout -b {BR} {JOIN}`; the tree's compiled library is current for `fs131-wk12`, so the first build compiles the proof line's modules); **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Plane/WindowDensity.lean`, `Proofs/HadwigerNelson/Rigidity/PlaneZhang.lean` (lane Λ1) and `Proofs/HadwigerNelson/Rigidity/CountExtension.lean` (lane Λ4); their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/icl1/`; `data/fs131/reports/{JOB}.md`. **Not** the count's other modules (`FiniteZhang`, `CountResidue`, `CountDescent`, `CountTorus`, `CountCompletion` — lanes Λ2 and Λ3, and the join implementer's ruled replacement in two of them), `Plane/OneAvoidingDensity.lean` (its statement is the paper's; its proof is another job's), `Rigidity/ContinuityGroup.lean` (the join implementer proves it; Λ4 reads its `TA_subset_contChars` as stated), any module under `Outside/`, the declared printed theorem. Nothing on `main`
  budget: {BUDGET}

Hello. The count is the chain's largest single module: eight files and 57 leaves, priced by its planner at 4,150–6,000
lines from five first leaves. Its four lanes share no file. You take the two that read nothing unproved in the count
itself: the plane, and the extension.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The count is on the chain's critical path; its lanes Λ1 and Λ4 can start now, and Λ2 and Λ3 wait for the join
implementer's replacement in their files.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the count is and the shorter
route it takes:

{DC}
{DA}
The count planner's hand-back and the chain's join, as I logged them (their words in quotation marks, the rulings mine):

{item(KC)}
{item(KJ)}
**Your lanes, in order.** (1) **Λ1** — `Plane/WindowDensity` (6 leaves) and `Rigidity/PlaneZhang` (5): open with
`exists_nrWindow`, then `sum_volume_inter_sq_le` (the planner's record `{PK}` § 5.2, row Λ1; the plan per leaf § 3.2;
the first leaf of block P is proved in scratch, `{W}data/fs131/k12a/leaves/LeafP.lean` — fold it in). (2) **Λ4** —
`Rigidity/CountExtension` (5 leaves): open with `exists_extension` (§ 5.2, row Λ4). It reads M10's
`TA_subset_contChars`, which the join implementer is proving in another tree: read it as stated. Re-price each lane from
its first two leaves (`LEAN.md` § The kernel's cost model) and tell me if one prices over a week.

## Done means

1. **Readback** (a saved stage, and the one line to me when the tree builds): the quoted lines checked against their
   sources; the branch cut and built under the slot; each leaf's statement restated in one line beside its plan; the
   stored statements of your three files dumped from the built tree before any edit — reading every instance and
   definition for a class binder its section declares and its stored type lacks.
2. **Λ1** (saved stages as leaves fall); re-priced from its first two leaves.
3. **Λ4** (saved stages as leaves fall); re-priced from its first two leaves.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree — the standard three, or `sorryAx` only through
   named leaves — each listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each lane; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wk12`; your branch adds the proof line's modules (the dual
group, the pieces, the entropy file, two generated ports of the outside release, the adelic model, the zero-entropy
side), so the first build compiles them — expect 20–40 minutes. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icl1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may
hold up to 12 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout`
wrapper shows as exit 143, not 137 (read the system log for "oom-kill"). Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/icl1/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-count-plane-extension.md","w").write(b); print("ok",len(b))
