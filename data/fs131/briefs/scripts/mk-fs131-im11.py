exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IM11: M11's implementer — lanes M11-S (SpectralSubspace), M11-T (TraceSplit), M11-A (APlus), on the planner's branch.
# Usage: mk-fs131-im11.py <item of KM11's hand-back> <item of IJ1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KM,KI=int(sys.argv[1]),int(sys.argv[2])
TREE="fs132-wi1"; BR="fs131-wm12"; JOB="FS131-IM11"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wm11"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/km11/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D1=Q(C,"- 2026-10-14 — **M11 typed**","§ Dated lines")
D2=Q(C,"- 2026-10-14 — **The cyclic-subspace step is a lemma","§ Dated lines")
D3=Q(C,"- 2026-10-14 — **SI-1 and SI-3 in colour indicators**","§ Dated lines")
PR=W+"plans/FS131-KM11-aplus.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"; SC=W+"data/fs131/km11/scratch/"
for p in (PR,RG+"SpectralSubspace.lean",RG+"TraceSplit.lean",RG+"APlus.lean",RG+"ContinuityGroup.lean",SC+"Density.lean",SC+"Gram.lean",SC+"SpectralVector.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M11 (A⁺ at the empty set) proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: M11's implementer — the chain's hypothesis `(chainInterface F).APlusOfR88`, composed by its planner as `Rigidity.aPlusOfR88` over 33 leaves in three new modules: the cyclic-subspace step (`SpectralSubspace`), the trace measure split in colour indicators (`TraceSplit`), and A⁺ with its factor colouring (`APlus`), proved as far as you reach; three private helpers of M10's module made public for it
  launch: now, in the planner's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs share the build slot (the chain's M3 and M2b, the count's last lanes, the certificate checker)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a lane's first two leaves price it above twice the planner's lines, if a stored statement lacks a class binder its section declares (item 847's defect), and with one line when `aPlusOfR88` prints the standard three; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wm11` at `{TIP}`; its build is current for that commit): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/SpectralSubspace.lean`, `TraceSplit.lean` and `APlus.lean`; in `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean`, `private` removed from `mem_nhds_profTop`, `eventually_archTop` and `archHom` and nothing else (item {KM} ruling 1; another job adds one attribute to that file on another branch — touch no other line); their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/im11/`; `data/fs131/reports/{JOB}.md`. **Not** any other module, `ChainAtTA.lean`, the count's modules, any module under `Outside/`, the declared printed theorem. Untracked files of the planner are in `data/fs131/km11/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. M11 is the last module of the chain's critical road to be planned, and its planner has just typed it, stated its
one unwritten step as a lemma that needs no Bochner theorem, proved two of its hard leaves in scratch, and priced the
whole at about one implementer-day. You prove it.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
With M11 proved, the chain's headline loses its hypothesis `APlusOfR88`.

## The statements

The three dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what M11 is now:

{D1}
{D2}
{D3}
The planner's hand-back and the last chain implementer's, as I logged them (their words in quotation marks, the rulings mine):

{item(KM)}
{item(KI)}
**Your lanes, in order** (the planner's record `{PR}` § 4.3; the plan per leaf in § 2 and § 3): **M11-S**
(`SpectralSubspace`) — fold in first the planner's scratch proofs `{SC}Density.lean` (`exists_trigPoly_tendsto`),
`{SC}Gram.lean` (`gram_sum_eq`) and `{SC}SpectralVector.lean` (`exists_spectral_vector`'s assembly); then **M11-T**
(`TraceSplit`); then **M11-A** (`APlus`), with the three helpers made public first. Re-price each lane from its first two
leaves and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your four files dumped from the built tree before any edit.
2. **The lanes** (saved stages as leaves fall, and the one line to me when `aPlusOfR88` prints the standard three).
3. **No statement and no definition changed** but the three helpers' `private`, shown from the kernel's side against
   item 1's dump (a planted change watched firing); one build under the slot with no warning from your files but their
   remaining leaves'; the axioms of every public declaration of your files printed from the built tree — the standard
   three, or `sorryAx` only through named leaves — each listed, with a planted record watched showing; the guarded lint
   (`lake lint --no-build -- --no-build --trace`) with no finding in your files.
4. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
5. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each lane; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wm11`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name im11 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile (put later text in a copy under `data/`). The certificate
job holds up to 10 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a
`timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is
wiped at power-off: anything your record cites lives under `data/fs131/im11/`. Report at once any disk, memory or count
reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-aplus.md","w").write(b); print("ok",len(b))
