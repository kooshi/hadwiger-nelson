exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IJ1: the chain's implementer — the join of the chain's proof line (fs131-wt2, after FS131-ITK1) with the map's and the
# count's typed modules (fs131-wk12); `Counting.toL` replaced by lane T's `ofUnitRing`; then M10, M2a, M3 and M2b proved.
# Usage: mk-fs131-ij1.py <item of ITK1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KI=int(sys.argv[1]); KR,KC,KS=823,832,847
TREE="fs131-wq1"; BR="fs131-wt3"; JOB="FS131-IJ1"; W=WT+TREE+"/"; WC=WT+"fs131-wch/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wt2"
OLD=("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/","data/fs131/itt1/","data/fs131/itk1/")
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in OLD)]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); K12=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wk12")
# the trial merge: ARCHITECTURE.md is the only conflict
mt=subprocess.run(["git","-C",ROOT,"merge-tree","--write-tree","--name-only","fs131-wt2","fs131-wk12"],capture_output=True,text=True).stdout
conf=[l for l in mt.split("\n\n")[0].splitlines()[1:] if l.strip()]
assert conf==["ARCHITECTURE.md"],conf
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DM=Q(C,"- 2026-10-14 — **M2 and M3 are typed by averaging**","§ Dated lines")
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
PR=WC+"plans/FS131-KR1-chain-map.md"; PK=WC+"plans/FS131-K12A-count.md"; PI=W+"plans/FS131-ITK1-implementation.md"
RG=W+"Proofs/HadwigerNelson/Rigidity/"; RC=WC+"Proofs/HadwigerNelson/Rigidity/"
for p in (PR,PK,PI,RG+"ChainAtTA.lean",RG+"TateModel.lean",RC+"CountResidue.lean",RC+"CountCompletion.lean",
          RC+"ContinuityGroup.lean",RC+"Herglotz.lean",RC+"InvariantMeasure.lean",RC+"BochnerTau.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: its proof line joined with the map's and the count's modules, then four of the map's modules proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer — first the join of the chain's proof line (lane T and the zero-entropy side's second half, as the last implementer left them) with the branch holding the map's six typed modules and the count's eight; then one ruled replacement (the count's ring map `Counting.toL` by lane T's `ofUnitRing`, the same map under one name); then the map's modules M10 (the continuity group), M2a (Herglotz–Bochner's existence half), M3 (the invariant measure) and M2b (Bochner at the twisted parts), as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs run in other trees (the port's landing, the class-ratio certificates, the density bound's planner) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the join conflicts anywhere but `ARCHITECTURE.md`, if the two ring maps are not the same term, if a leaf is false as stated or needs a hypothesis it lacks, if a first leaf prices a module above a week, and with one line when the joined branch builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wt2` at `{TIP}`; its build is current for that commit) and into which you merge `fs131-wk12` (at `{K12}`) with `--no-ff` as your first commit, `ARCHITECTURE.md`'s conflict resolved by keeping both sides' rows (`git merge-tree` reports that file alone); then: the replacement of `Counting.toL` by `Rigidity.ofUnitRing` in the count's modules `Rigidity/CountResidue.lean` and `Rigidity/CountCompletion.lean` (the definition deleted, every reader re-pointed, an import added; the theorems named for it may be renamed, each listed — a ruled statement change, item {KC} ruling 1); in `Rigidity/ChainAtTA.lean`, `private` removed from `mem_torsion_mul_arch_iff` and `exists_rat_coords` and nothing else (item {KR} ruling 1); then **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Rigidity/ContinuityGroup.lean`, `Rigidity/Herglotz.lean`, `Rigidity/InvariantMeasure.lean` and `Rigidity/BochnerTau.lean` (each under `Proofs/HadwigerNelson/`; they arrive with the merge); their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ij1/`; `data/fs131/reports/{JOB}.md`. **Not** the count's other modules and leaves (four lanes of their own), lane T's and M8b's modules (any leaf the last implementer left is another job's), `ZeroEntropyClosed.lean`, `Plane/OneAvoidingDensity.lean` (its statement is the paper's; its proof is another job's, on a line from `main`), `Rigidity/ClassRatio.lean`, any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`, `itk1/`): leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The chain's work is on two lines again: one where implementers proved the dual group, the pieces, the entropy
file, the adelic model and the zero-entropy side's second half; one where planners typed the rest of the map and the
count. You join them, apply one ruling at the seam, and prove the four modules of the map that the chain's critical
path runs through.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The chain's map planner read its critical path as M13's tail and the count, beside lane T → M8b and `M4 → M10 → M2b →
M11` (its record § Stage 5); M10, M2a, M3 and M2b are typed and read nothing unproved but each other (M4 and M9-R are
proved on this line); and the count's four lanes need one line to land on.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what M2 and M3 are and what the
count is:

{DM}
{DC}
The three hand-backs behind this job and one ruling on a skeleton defect, as I logged them (their words in quotation
marks, the rulings mine):

{item(KR)}
{item(KC)}
{item(KI)}
{item(KS)}
Of item {KS}: `Counting.finite_quot` in `CountResidue` is not yours to repair (lane Λ2 proves it), but you edit that
file for the replacement — leave its statement as it is. After the merge, confirm that `Rigidity.AdmissiblePair.ofPow`
is `fs131-wt1`'s version (ruling 3).
**Your work, in order.** (1) **The join**: the merge commit; one build under the slot of the joined tree. (2) **The
replacement**: first show from the kernel that the two maps are one term (`Counting.toL F = ofUnitRing F` by `rfl`, both
printed); then delete `toL`, re-point its readers, dump the count's stored statements before and after, and list every
statement that changed — each should differ only in that name. (3) **M10**, `ContinuityGroup` (6 leaves): the two lemmas
of `ChainAtTA` made public first, their statements dumped and unchanged; the plan is the map planner's record `{PR}`
§ 2.3 and § 4.3. (4) **M2a**, `Herglotz` (3 leaves; § 2.1, § 4.3). (5) **M3**, `InvariantMeasure` (2 leaves; § 2.2,
§ 4.3). (6) **M2b**, `BochnerTau` (4 leaves; § 2.1): the hard leaf `exists_twisted_parts` first, to re-price. The map
itself is § Stage 5 of that record; the count's record `{PK}` § 5.1 names the leaves the count reads from M10. The last
implementer's record `{PI}` is the worked pattern for this chain's files.

## Done means

1. **The join and the readback** (a saved stage, and the one line to me when the joined tree builds): the quoted lines
   checked against their sources; each leaf's statement restated in one line beside its plan; the stored statements of
   every file you touch dumped from the built joined tree before any edit.
2. **The replacement and the two lemmas made public** (a saved stage), shown from the kernel's side.
3. **The modules** (saved stages as leaves fall); re-price what is left from the first two leaves of each and say so.
4. **No statement and no definition changed** but the replacement, shown from the kernel's side against item 1's dump (a
   planted change watched firing); one build under the slot with no warning from your files but their remaining
   leaves'; the axioms of every public declaration of your files printed from the built tree — the standard three, or
   `sorryAx` only through named leaves — each listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside items 3–6; the names of the theorems named for `toL`; another
route for a leaf where the plan's does not go through (tell me which). An unread binder of a statement in your files is
dropped under item 726's word, listed and named. Not yours: any other change to a statement or definition; the files
listed as not yours; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt2`; the join adds the map's and the count's fourteen
modules, so the first build compiles them. One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ij1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`. The
certificate job may hold 12 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a
`timeout` wrapper shows as exit 143, not 137 (item 835). Stop a process by its PID, never by matching its command line.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ij1/`. Report at once any disk, memory or
count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-join-m10-m2.md","w").write(b); print("ok",len(b))
