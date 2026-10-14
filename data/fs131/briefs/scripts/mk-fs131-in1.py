exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IN1: the five-colour chain's second implementer — three ready lanes of the third planner (H, C, N), on a branch
# that joins the entropy base (fs131-we1) and the third planner's skeleton (fs131-wk7).
# Usage: mk-fs131-in1.py <inventory item of KN7's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K7=int(sys.argv[1])
TREE="fs131-wch"; BR="fs131-wl1"; JOB="FS131-IN1"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-three-lanes.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-we1"
E1=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-we1"); K7T=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wk7")
assert sh("git","-C",W,"rev-parse","--short=9","HEAD")==E1
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D18=Q(C,"- 2026-10-14 — **NF2-LEAF-18's statements are typed","§ Dated lines")
D20=Q(C,"- 2026-10-14 — **NF2-LEAF-20 is narrowed","§ Dated lines")
WQ=WT+"fs131-wq1/"; P7=WQ+"plans/FS131-KN7-chain-next.md"; P6=W+"plans/FS131-KN6-chain-first-layer.md"
IE=W+"plans/FS131-IE1-implementation.md"
for p in (P7,P6,IE,ROOT+"plans/FS131-EN2-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — three ready lanes of the five-colour chain: the largest Haar multiple, the smaller set's four leaves, and the names at entropy zero

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the second implementer on the chain under "five colours at the square root of 47" — three of the lanes its third planner left ready, on one branch that first joins the entropy base the first implementer proved and the skeleton the third planner typed
  launch: now, in the first implementer's tree (its job is finished; nobody else writes there) on a new branch; the chain's fourth planner works in `fs131-wq1` on branch `fs131-wk8` and may type statements in `Rigidity/ChainAtTA.lean` and `Rigidity/PositiveEntropy.lean` (different declarations from yours; I join the two); the port's planner works in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the join does not go through as described, and with one line when the joined branch builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-we1` at `{E1}`; its build is current for that commit) and into which you merge `fs131-wk7` (at `{K7T}`) with `--no-ff` as your first commit (`git merge-tree` reports it clean); then, **proofs, private helpers and import lines only — no statement changes, no definition changes**: `Proofs/HadwigerNelson/Rigidity/HaarMultiple.lean`, `Proofs/HadwigerNelson/Rigidity/ZeroEntropyNames.lean`, `Proofs/HadwigerNelson/Rigidity/SolenoidErgodic.lean`, and in `Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` the four leaves of lane C only; your checks under `tools/` (named for this job); `plans/{JOB}-implementation.md`; `data/fs131/in1/`; `data/fs131/reports/{JOB}.md`. **Not** the entropy file's tenth leaf, any module under `Outside/`, `Rigidity/PositiveEntropy.lean`, the other leaves of `Rigidity/ChainAtTA.lean` (`chainInterface`, `entropySplit`), the draft claim lists. Nothing on `main`; nothing in the outside release's clone
  budget: {BUDGET}

Hello. This chain is the first-ranked thing this project has to show and the longest road left. Its first implementer
ported the outside release's entropy files and proved nine leaves of the chain's own entropy file over them; its
third planner then typed three more modules and left them ready, each with a plan per leaf. You take those three.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
Under "the plane over the field of the square root of 47 needs exactly five colours" sit two deductions of ours from
one printed theorem. The modules here are the pieces of those deductions that need no further planning: the largest
multiple of Haar measure below a measure (the first step of the positive-entropy split), four small facts about the
set the chain's measure rigidity is stated on, and the counting of names at entropy zero (the first half of the
zero-entropy side).

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what these modules now are:

{D18}
{D20}
The third planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

{item(K7)}
**Your leaves** (paths in the third planner's tree; the same files are in yours after the join): the third planner's lanes **H** (`{WQ}Proofs/HadwigerNelson/Rigidity/HaarMultiple.lean`; its record § 6.2: the statements read
aloud against the derivation's step and a plan per leaf), **C** (four leaves of `Rigidity/ChainAtTA.lean` —
`measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector`, and the rotation-invariance of the point mass at
the trivial character; the second planner's record § 5.6 and Stage 3b item 5) and **N** (`{WQ}Proofs/HadwigerNelson/Rigidity/ZeroEntropyNames.lean`
and `{WQ}Proofs/HadwigerNelson/Rigidity/SolenoidErgodic.lean`; the third planner's record § 5.2–5.4: statements, passes and a plan per leaf).
Lane N's last leaf, the maximal inequality `measure_frequentVisits_le`, is the release's
`excessiveOccupation_measure_bound` with its definitions unfolded; the port of it is on your branch after the join
(`{W}Proofs/HadwigerNelson/Outside/OAI015Maximal.lean`), so that leaf is yours too. Their statements are the files'; read
them in the source. **The plans**: the third planner's record `{P7}` (the same file is in your tree after the join),
the second planner's `{P6}`, and the deriver's `plans/FS131-EN2-derivation.md` (entries EN2-CNT, EN2-ZE, EN2-PE2-MAX's
step 1). The first implementer's record `{IE}` is the worked pattern for this chain's files (its readback, dumps and
axiom checks).

## Done means

1. **The join and the readback** (a saved stage): the merge commit; the quoted lines checked against their sources;
   each leaf's statement restated in one line beside the plan's route; the stored statements of the four files dumped
   from the built joined tree before any edit (one build under the slot first: the joined branch compiles the third
   planner's modules over the first implementer's).
2. **Lanes H and C** (saved stages as they fall). Re-price what is left from the first two leaves you finish and say
   so in your record.
3. **Lane N** (saved stages as they fall): the names at entropy zero, and the ergodicity bridge; its first leaf is
   the longest by the plan.
4. **No statement and no definition changed**, shown from the kernel's side against the dump of item 1 (a planted
   change watched firing); no `sorry` left in your files and lane C's four leaves; one build under the slot with no
   warning from them; the axioms of every public declaration of your files printed from the built tree — the
   standard three and nothing else (none of them may read the chain's declared printed theorem), with a planted
   record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the model for each hypothesis that
   lacks one; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports a proof needs; the order of the lanes; another route for a leaf where the plan's
does not go through (tell me which). Not yours: any statement or definition; the leaves listed as not yours; the
declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** Measured: one file through `lake env lean` costs 3 to 24 seconds and 3.6 GB; a build with only small
modules stale takes about 7 minutes. Write against `lake env lean` and build rarely; do not edit a module file while a
build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name in1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`.
Another planner builds from time to time: on exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/in1/`.
Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-three-lanes.md","w").write(b); print("ok",len(b))
