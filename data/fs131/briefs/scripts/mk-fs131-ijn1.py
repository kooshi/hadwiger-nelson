exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IJN1: the chain's join — fs131-wla (M11, lane A) and fs131-wcm (the count, M13 composed) merged into fs131-wt5
# (M2b, the entropy side); M9-S and the model; the landing rulings that are code; the headline closed over what is open.
# Usage: mk-fs131-ijn1.py
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K8,K9=761,791
TREE="fs131-wq1"; BR="fs131-wj"; JOB="FS131-IJN1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wt5"
OLD=("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/","data/fs131/itt1/","data/fs131/itk1/","data/fs131/ij1/","data/fs131/ij2/","data/fs131/ij3/")
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in OLD)]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DB=Q(C,"- 2026-10-14 — **The headline with closed hypotheses takes eight, not nine","§ Dated lines")
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
DM=Q(C,"- 2026-10-14 — **M11 typed**","§ Dated lines")
PI=W+"plans/FS131-IJ3-implementation.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (PI,RG+"ChainAtTA.lean",RG+"ZeroEntropyClosed.lean",RG+"EntropySplitMax.lean",RG+"UnitCircle.lean",RG+"InvariantMeasure.lean"): assert os.path.exists(p),p
for b_ in ("fs131-wla","fs131-wcm"): assert sh("git","-C",ROOT,"branch","--list",b_)!=""
b=f'''# Brief {JOB} — the five-colour chain joined on one branch, its small leaves closed, its headline read from the kernel

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's join implementer — merge the finished branches of the chain (M11 and lane A on `fs131-wla`; the count and M13's composition on `fs131-wcm`) into the branch where M2b and the entropy side are proved; prove the two small leaves left there (M9-S and the model `mulTwoThree_model`); carry out the landing rulings that are code (statements moved downstream, a declared theorem registered with the audit, unread binders dropped, shared helpers made one); and state the chain's headline with every proved hypothesis discharged, its axioms printed, so that what is left is named by the kernel
  launch: now, in the entropy implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work on lines that join this one later (M13's leaves on `fs131-wcm2`, the certificates on `fs131-wc16`, the density bound on `fs131-wdb3`) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a merge conflicts anywhere but `ARCHITECTURE.md` and `Proofs.lean`, if a moved statement's stored type changes beyond the ruled binder, if the headline needs a hypothesis no proved or named leaf supplies, and with one line when the joined branch builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-join.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wt5` at `{TIP}`; its build is current for that commit), into which you merge `fs131-wla` and `fs131-wcm` with `--no-ff`, one each, conflicts in `ARCHITECTURE.md` and `Proofs.lean` resolved by keeping both sides; then: the proofs of `noRamifiedStableDyadic_of_tca` (in `ChainAtTA`) and `ZdAction.mulTwoThree_model`; the landing rulings below, each a ruled change dumped before and after; a new statement `Rigidity.min_localBound_five_le_chromaticNumber` (or your name) — the headline `min_localBound_five_le_chromaticNumber_of_closed` with each hypothesis it can now discharge discharged by its proved theorem, the rest kept as hypotheses, its conclusion character for character the headline's; docstrings where a moved or proved declaration's text is stale (`UnitCircle`'s two, item 897's D2; `ClassRatio`'s "skeleton"); `scripts/Axioms.lean`'s and `scripts/assumptions-ledger.txt`'s entries for the declared printed theorem; `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/{JOB}-join.md`; `data/fs131/ijn1/`; `data/fs131/reports/{JOB}.md`. **Not** M13's six private leaves (another job proves them on `fs131-wcm2`), `Arith/FibreCert*` and the density bound's modules (their own lines), any module under `Outside/`, the declared outside theorems' statements. Untracked files from older jobs are in this tree: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The five-colour chain has been proved on branches all day — the adelic model, the zero-entropy side, the entropy
split and the admissible pair, M2b and M11, the count, and M13's composition — and each branch reads the others' statements
as typed. You join the finished branches, close the small leaves, apply the rulings the landing would otherwise carry,
and print what the chain's headline now rests on.

## Why this job

Kooshi's rule for what goes out, and his conditional instruction:

{Q(RQ,"W2: ")}
The chain's landing is the trigger for the publication pass (W6 in the same file); its headline, read from the kernel on
one branch, is what tells us how far that is.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the headline takes, what the count
is and what M11 is:

{DB}
{DC}
{DM}
The two entropy planners' hand-backs, as I logged them (their words in quotation marks, the rulings mine — item {K8}'s
ruling 5 and item 811's ruling 1 are the moves below):

{item(K8)}
{item(K9)}
**Your work, in order.** (1) **The merges** (`fs131-wla`, then `fs131-wcm`; `git merge-tree` reports `ARCHITECTURE.md` alone
for each) and one build under the slot. (2) **The two leaves**: `noRamifiedStableDyadic_of_tca` (M9-S, `ChainAtTA`) and
`ZdAction.mulTwoThree_model` (priced 100–150 lines in the last implementer's record `{PI}`). (3) **The landing rulings that
are code**, each listed in your record with its source item, each stored type dumped before and after:
   - `entropySplit` and `zeroEntropyCarried` (with its readers) move out of `ChainAtTA` downstream into
     `Rigidity/ZeroEntropyClosed`, `entropySplit` proved there as `entropySplit_of_admissiblePair _ (exists_admissiblePair _).some`,
     the scope binder dropped where unread (items 761 ruling 5, 811 ruling 1);
   - the declared printed theorem `Rigidity.positive_entropy_rigidity` registered with the audit — its four items from
     `{W}plans/FS131-KN6-chain-first-layer.md` § Stage 6 and the repair R1 of `{W}plans/FS131-KN7-chain-next.md`;
   - the five unread binders of lane N's statements dropped with a dump (item 770 ruling 2);
   - Lemma F made public if a second module reads it (item 801 ruling 1);
   - M3's private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers: noted for the landing, which joins `main` (they
     cannot be shared until then — say so in your record).
(4) **The headline closed**: state it as above, prove it from the parts, print its axioms from the built tree, and list
every leaf its `sorryAx` comes through, by name and line. Expect M13's six leaves, the certificates' link, and the
density bound's instance.

## Done means

1. **Readback** (a saved stage, and the one line to me when the joined branch builds).
2. **The two leaves** (a saved stage).
3. **The rulings** (a saved stage), each shown from the kernel's side.
4. **The headline** (a saved stage): its stored statement printed and read aloud against the old headline's conclusion;
   its axioms; the named leaves it still reads.
5. **No other statement or definition changed**, shown from the kernel's side against dumps taken after the merges (a
   planted change watched firing); one build under the slot with no warning but the named leaves'; the guarded lint;
   `dupnames`; the architecture check; the axioms of every public declaration in the files you touch, each listed.
6. **Drafts for the landing**, in your record: the audit's block for the joined chain; the assumptions ledger's lines;
   `LEAN.md` lines.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The order inside each item; the proofs; the headline's name; how the moves are cut so that no import cycle forms. Not
yours: any statement change beyond the ruled ones; M13's leaves; the other lines' files; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt5`; the merges add M11, lane A, the count and M13's
composition (expect 10–20 minutes for the first build).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ijn1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ijn1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-join.md","w").write(b); print("ok",len(b))
