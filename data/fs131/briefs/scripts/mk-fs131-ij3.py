exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IJ3: the chain's implementer — M2b's last leaf with ContinuityGroup's eight helpers public, then the entropy side:
# lane A (the admissible pair), the split's leaves, M5-E and M5-P, M9-S last.
# Usage: mk-fs131-ij3.py <item of IJ2's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KI=int(sys.argv[1]); K8,K9=761,791
TREE="fs131-wq1"; BR="fs131-wt5"; JOB="FS131-IJ3"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wt4"
OLD=("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/","data/fs131/itt1/","data/fs131/itk1/","data/fs131/ij1/","data/fs131/ij2/")
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in OLD)]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DB=Q(C,"- 2026-10-14 — **`BochnerOn` is read by M11 only","§ Dated lines")
DE=Q(C,"- 2026-10-14 — **NF2-LEAF-20 is narrowed: the entropy split is read at one rotation","§ Dated lines")
DH=Q(C,"- 2026-10-14 — **The finite-fibred step reads the declared clause (4) as stated","§ Dated lines")
PI=W+"plans/FS131-IJ2-implementation.md"; P8=W+"plans/FS131-KN8-chain-split.md"; P9=W+"plans/FS131-KN9-chain-zero-entropy.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (PI,P8,P9,RG+"BochnerTau.lean",RG+"ContinuityGroup.lean",RG+"UnitCircle.lean",RG+"EntropySplitMax.lean",RG+"EntropyFibres.lean",RG+"PositiveEntropy.lean",RG+"ChainAtTA.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M2b's last leaf, then the entropy side proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer — first M2b's last leaf (`archimedean_support`, with the eight private lemmas of M10's module it reads made public), which completes the road from the continuity group to M11; then the chain's entropy side: lane A (`exists_admissiblePair`, one admissible pair at every real number field, planned and proved here), the entropy split's remaining leaves, the positive-entropy lanes M5-E and M5-P, and M9-S last, as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs share the build slot (M11's implementer, the count's last lanes, the certificate checker)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a lane's first two leaves price it above twice its plan (or, for lane A, above 1,000 lines), if a stored statement lacks a class binder its section declares (item 847's defect), and with one line when `bochnerOn_tauPrime` prints the standard three; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wt4` at `{TIP}`; its build is current for that commit): in `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean`, `private` removed from the eight lemmas `BochnerTau` reads through `open private` and nothing else (item {KI} ruling 1; M11's implementer removes it from three others in that file on another branch — touch no other line), and `BochnerTau`'s `open private` line dropped; **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/BochnerTau.lean`, `UnitCircle.lean` (lane A), `EntropySplitMax.lean` (the split), `EntropyFibres.lean` (M5-E), `PositiveEntropy.lean` (M5-P), and in `ChainAtTA.lean` the one proof of `noRamifiedStableDyadic_of_tca` (M9-S) and nothing else; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ij3/`; `data/fs131/reports/{JOB}.md`. **Not** M11's modules, the count's modules, `ClassRatio.lean`, `RingScope.lean`'s `unitRing_eq_stableIntegers` (off the path), any module under `Outside/`, the declared printed theorem `positive_entropy_rigidity`. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/` and plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`, `itk1/`, `ij1/`, `ij2/`): leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The last implementer proved M3 and the hard leaf of M2b, leaving one leaf of M2b with its route written down.
After it, what the chain's line still has unproved outside the count, M11 and M13 is its entropy side: one admissible
pair, the entropy split's leaves, and the two positive-entropy files. You take all of it, in that order.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
`archimedean_support` is the last leaf between M10 and M11; the entropy side is the chain's positive-entropy half, read by
its headline through the entropy split.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what M2b's consumer reads and what the
entropy side is now:

{DB}
{DE}
{DH}
The two entropy planners' hand-backs and the last chain implementer's, as I logged them (their words in quotation marks,
the rulings mine; item {K8}'s ruling 4 carries a note of mine on lane A, unchecked, for you to use or discard):

{item(K8)}
{item(K9)}
{item(KI)}
**Your work, in order.** (1) **M2b's last leaf**: the eight lemmas made public first, then `archimedean_support` by the
route in the last implementer's record `{PI}` § 5.7 (450–700 lines). (2) **Lane A**, `exists_admissiblePair` in
`UnitCircle` — no planner has typed its children: plan it in your record first (its statement read aloud, its route, its
leaves as private helpers), then prove it. (3) **The split's leaves** in `EntropySplitMax` (the planner's record `{P8}`).
(4) **M5-E**, `EntropyFibres` (9 leaves), then **M5-P**, `PositiveEntropy` (10, `haar_or_zero_entropy` last) — the plan per
leaf in `{P9}` (§ 5.1 for the lanes). (5) **M9-S**, `noRamifiedStableDyadic_of_tca`, if you reach it. Re-price each lane
from its first two leaves and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit, every instance
   and definition read for a class binder its section declares and its stored type lacks.
2. **M2b complete** (a saved stage, and the one line to me when `bochnerOn_tauPrime` prints the standard three).
3. **Lane A, the split, M5-E, M5-P, M9-S** (saved stages as leaves fall).
4. **No statement and no definition changed** but the ruled `private`s, shown from the kernel's side against item 1's dump
   (a planted change watched firing); one build under the slot with no warning from your files but their remaining
   leaves'; the axioms of every public declaration of your files printed from the built tree, each listed, with a planted
   record watched showing; the guarded lint with no finding in your files.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each item after the first; lane A's route (mine in item {K8} is a
note, not a plan); another route for a leaf where its plan's does not go through (tell me which). An unread binder of a
statement in your files is dropped under item 726's word, listed and named. Not yours: any other change to a statement
or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt4`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ij3 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ij3/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-m2b-entropy.md","w").write(b); print("ok",len(b))
