exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-LCH1: the chain's landing, part 1 — main and M13's line joined into the instances' branch, the ruled
# integrations applied, the joined tree built and checked; part 2 (the last three lines and the full gate) follows.
# Usage: mk-fs131-lch1.py <item 876> <item 916> <item 918> <item 926> <item 927>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K876,K916,K918,K926,K927=[int(x) for x in sys.argv[1:6]]
TREE="fs131-wq1"; BR="fs131-wlc"; JOB="FS131-LCH1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wm15"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main"); CM=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wcm3")
RQ="data/fs131/REQUEST-2026-10-13.md"; HO="plans/SESSION-HANDOFF-2026-10-14.md"
W6=Q(RQ,"Once the chain lands, we'll do some sanitization")
RC=Q(HO,"**Rulings to carry at the chain's landing:**","§ 4. Where each line stands")
for p in (ROOT+HO,ROOT+"plans/FS131-LDB1-landing.md",ROOT+"plans/FS133-LD1-landing.md",W+"plans/FS131-IJN1-join.md",W+"plans/FS131-KM15-instances.md",ROOT+"LEAN.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain's landing, part 1: the join with `main`, and the ruled integrations

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the first lander of the five-colour chain — you join `main` (which now holds the density bound and the density equality) and M13's line into the branch that holds the chain's headline and the instance at `ℚ(√47)`, resolve the merges, apply the integrations already ruled (the old `mOne` read through its bridge, the density bound and row 99's lower half discharged, the instance's link to M13's public theorem, one copy of each duplicated fact, the docstrings), and leave the joined tree building with every remaining `sorry` a named leaf of a line still running; part 2 joins those lines and runs the full gate
  launch: now, in the chain's tree (its last job has handed back; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a merge conflicts outside the files named below, if a statement of `main` and one of the chain's lines collide (two declarations of one name, as `Plane.mOne` did, item {K916}), if a ruled integration does not go through as ruled, and with one line when the joined tree builds with the headline and `χ(ℚ(√47)²) = 5` stated with no hypothesis; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-join.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wm15` at `{TIP}`; its compiled library is current for that commit) and into which you merge `main` (at `{MAIN}`) and M13's line `fs131-wcm3` (at `{CM}`). The trial merges conflict in `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`, `scripts/assumptions-ledger.txt` (keep both sides; the counts are part 2's) and `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` (add/add: **`main`'s version wins whole**). Then: proofs, docstrings, imports and the **ruled statement changes listed under "The integrations"** in the chain's modules, M15's modules and `Proofs/HadwigerNelson/Instances/SqrtFortySeven.lean`; two new corollaries in `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean`; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` and `ARCHITECTURE.md` as the joined tree needs; your checks under `tools/` named for this job; `plans/{JOB}-join.md`; `data/fs131/lch1/`; `data/fs131/reports/{JOB}.md`. **Not** `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (FS131-ICM4's, on `fs131-wcm4`), any `Arith/FibreCert*` or `Arith/DyadicCerts*` module (FS131-IKC4's and FS131-ICM4's), the certificate link's modules (FS131-IKL1's, on `fs131-wkl`), any module under `Outside/` or `Plane/DensityBound/`, any generated module's text. Nothing on `main`; no push
  budget: {BUDGET}; save a stage after the readback, after each merge builds, after each group of integrations, and at the hand-back

Hello. Today the five-colour chain's headline was stated with every hypothesis the chain proves discharged, the
instance at `ℚ(√47)` was proved over it, and the density bound the headline takes landed on `main`. The chain now lives
on several branches. You bring together the ones that are finished, so that when the last three lines hand back the
landing is a short join and one gate run.

## Why this job

Kooshi's word for when the publication pass begins:

{W6}
In the plan's terms, "the chain lands" is `χ(ℚ(√47)²) = 5` through the gate on `main` with no hypothesis of ours left
(`{HO}` § 1).

## The statements

The rulings carried to this landing, from the coordinator's handoff, and the hand-backs and rulings behind them, as I
logged them (their words in quotation marks, the rulings mine):

{RC}
{item(K876)}
{item(K916)}
{item(K918)}
{item(K926)}
{item(K927)}
**The integrations** (each a ruling above; each shown from the kernel's side — the stored type before and after, a
planted change watched firing — and listed in your record):
1. The chain's readers of the old `mOne` (`Plane/WindowDensity`, `Rigidity/CountDescent`, `Rigidity/PlaneZhang`) read
   `main`'s through `Plane.mOne_eq_iSup_bandFree` (item {K916}); their stored types change constant, nothing else.
2. `hOA` discharged by `Plane.oneAvoidingDensityBound` and `hRow99` by
   `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` (items {K918} (2)–(3), {K926} (2)): the headline
   `Rigidity.min_localBound_five_le_chromaticNumber` and the seven χ statements of M15 stated with no hypothesis, one
   form each.
3. M15's private link `Rigidity.ratioAtMost_two_notMem_link` deleted, its one reader pointed at M13's public
   `Rigidity.ratioAtMost_of_two_notMem`, the two statements compared from the kernel's side first (item {K926} (1)).
4. One copy of each duplicated fact: M3's private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers (item {K876});
   one of `zeroEntropyCarried` and `zeroEntropyCarried_of_numberField`, chosen by readers (item {K918} (4));
   `exists_I_integer` once, public, in M15's or `UpperHalf`'s module — `ClassRatio`'s copy stays until part 2 (item {K926} (3)).
5. The old conditional `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain` retired (item {K926} (4)).
6. Two new corollaries in `Plane/OneAvoidingDensity`: `m₁(ℝ²) ≤ 0.2470` and `m₁(ℝ²) < 1/4` with no hypothesis
   (item {K927} (3)); names yours.
7. `Rigidity.archTop`'s unused `[NumberField ↥F]`: dropped if no other stored type moves, else
   `@[nolint unusedArguments]` with its reason (item 922 (3)).
8. The docstring sweep in the files that are yours: the 28 module titles that still say "skeleton" (item {K918}), the
   `UnitCircle` docstrings (item 897), stale prose the merge exposes; comment-stripped code shown unchanged.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the stored statements of the chain's,
   M15's and `main`'s modules dumped from built trees before any edit (this tree for the chain; `fs131-w10g` — `main`'s
   gated build — for `main`'s); a collision scan of every declared name of the chain's lines against `main`'s library,
   as FS131-LDB1 ran it (`data/fs131/ldb1/collisions.out` on `main`), predicted and read.
2. **The merges** (saved stages): each built under the slot; every conflict's resolution listed.
3. **The integrations** (saved stages, in groups): each shown as above; then one build with no warning but the remaining
   leaves' `sorry`s; the headline and `χ(ℚ(√47)²) = 5` printed from the built tree with no hypothesis, their `sorryAx`
   traced to named leaves, each on a line still running (FS131-ICM4's dyadic children, FS131-IKL1's link, the `q = 19`
   bound), and nothing else; the one line to me.
4. **The gate's steps that read the joined tree** (part 2 runs them again on the final commit): the statement check
   against item 1's dumps with the ruled changes as its allowed list (a plant watched firing); `scripts/axioms.sh`; the
   guarded lint; `scripts/dupnames.sh`; `tools/check_architecture.py` — each log under `data/fs131/lch1/`.
5. **Drafts for part 2**, in your record: what is left to join, in order; the audit's block for the chain (the join's
   draft `{W}data/fs131/ijn1/draft-axioms-block.lean` brought current); the assumptions' rows; `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with the
   integrations part done, each left one named, is a good report.

## What is yours to decide

The order of the merges and of the integrations; how each conflict is resolved within the rulings; the names of the two
corollaries and of the shared lemma; the wording of docstrings. An unread binder of a statement of ours is dropped,
listed and named. Not yours: any other statement change; the files listed as not yours; the merge into `main`; a push.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wm15`. Merging `main` brings the port (31 generated modules),
the density equality and the density bound (83 modules, about 25 minutes of kernel CPU in its certificate checks): the
first build after it is long — budget an hour and read while it runs. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lch1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. A whole-library gate step: `--mem 8`. The p = 19 job can
hold up to 10 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout`
wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/lch1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-join.md","w").write(b); print("ok",len(b))
