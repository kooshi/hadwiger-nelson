exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IJ2: the chain's implementer — M3 (the invariant measure) and M2b (Bochner at the twisted parts), and one ruled
# attribute on `archTop`, on a branch from the joined line.
# Usage: mk-fs131-ij2.py <item of IJ1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KI=int(sys.argv[1]); KR=823
TREE="fs131-wq1"; BR="fs131-wt4"; JOB="FS131-IJ2"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wt3"
OLD=("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/","data/fs131/itt1/","data/fs131/itk1/","data/fs131/ij1/")
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in OLD)]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DM=Q(C,"- 2026-10-14 — **M2 and M3 are typed by averaging**","§ Dated lines")
DB=Q(C,"- 2026-10-14 — **`BochnerOn` is read by M11 only","§ Dated lines")
PR=W+"plans/FS131-KR1-chain-map.md"; PI=W+"plans/FS131-IJ1-implementation.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (PR,PI,RG+"InvariantMeasure.lean",RG+"BochnerTau.lean",RG+"ContinuityGroup.lean",RG+"Herglotz.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the invariant measure and Bochner at the twisted parts proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer — one ruled attribute on the skeleton's `Rigidity.archTop` (so the guarded lint passes), then the map's modules M3 (`InvariantMeasure`: an invariant probability measure on a closed invariant set of the dual, for a countable group) and M2b (`BochnerTau`: Bochner's theorem at the twisted parts, the road from the continuity group to M11), as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the certificate checker, the density bound's covering, the count's plane and extension lanes) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if M2b's hard leaf prices it above 2,000 lines, if a stored statement lacks a class binder its section declares (item 847's defect); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wt3` at `{TIP}`; its build is current for that commit): in `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean` (or wherever `archTop` is declared) **one attribute only**, `@[nolint unusedArguments]` on `archTop` with a one-line comment giving the reason (item {KI} ruling 1); **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/InvariantMeasure.lean` and `Proofs/HadwigerNelson/Rigidity/BochnerTau.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ij2/`; `data/fs131/reports/{JOB}.md`. **Not** the count's modules (lanes of their own), `ChainAtTA.lean`, the lane T and M8b modules, `Herglotz.lean` and `ContinuityGroup.lean` beyond the one attribute, any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`, `itk1/`, `ij1/`): leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The last implementer joined the chain's two lines, proved that the continuity group is exactly T + A over every
real number field, and proved Herglotz–Bochner on every countable abelian group. You take the next two modules of the
map on the same road.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
M2b is the step from the continuity group to M11, the last unplanned module on the chain's critical path; M3 is short
and reads M2a's weights, now proved.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what M2 and M3 are and who reads M2b:

{DM}
{DB}
The map planner's hand-back and the last implementer's, as I logged them (their words in quotation marks, the rulings mine):

{item(KR)}
{item(KI)}
**Your work, in order.** (0) **The attribute** on `archTop`, then the guarded lint (`lake lint --no-build -- --no-build
--trace`, under the slot) silent on the chain's files with its planted control red. (1) **M3**, `InvariantMeasure` (2
leaves; the map planner's record `{PR}` § 2.2 and § 4.3). (2) **M2b**, `BochnerTau` (4 leaves; § 2.1): the hard leaf
`exists_twisted_parts` first, to re-price — the last implementer found it true as stated and sketched its route (its
record `{PI}` § 5.5). That record is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit, every instance
   and definition read for a class binder its section declares and its stored type lacks.
2. **The attribute and the lint** (a saved stage).
3. **M3, then M2b** (saved stages as leaves fall); re-price M2b from its first two leaves and say so.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched
   showing.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each module; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt3`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ij2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree — and
run every command from inside it (the last implementer's slip: a background job started from the main tree). The build:
`--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and
retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ij2/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-m3-m2b.md","w").write(b); print("ok",len(b))
