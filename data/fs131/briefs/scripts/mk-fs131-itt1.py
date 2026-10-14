exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ITT1: the chain's implementer — the join of its proof branch (fs131-wp23) and its planning branch (fs131-wk8b),
# then lane T's first lanes (T-I, T-L, T-A) and M9-R, and T-C as far as it reaches.
# Usage: mk-fs131-itt1.py <item of KT1's hand-back> <item of K8B1's hand-back> <item of IP23's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KT,KB,KP=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wq1"; BR="fs131-wt1"; JOB="FS131-ITT1"; W=WT+TREE+"/"; WC=WT+"fs131-wch/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wp23"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in ("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/"))]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); K8=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wk8b")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DI=Q(C,"- 2026-10-14 — **The model of the dual is typed as an interface","§ Dated lines")
DT=Q(C,"- 2026-10-14 — **Tate's self-duality in the form the model reads, on a global character","§ Dated lines")
PT=WC+"plans/FS131-KT1-tate.md"; PB=WC+"plans/FS131-K8B1-zero-entropy-second.md"; P9=WC+"plans/FS131-KN9-chain-zero-entropy.md"
SC=WC+"data/fs131/kt1/scratch/FormG.lean"; IP=W+"plans/FS131-IP23-implementation.md"
for p in (PT,PB,P9,SC,IP,WC+"Proofs/HadwigerNelson/Rigidity/TateModel.lean",WC+"Proofs/HadwigerNelson/Rigidity/ThinBoxes.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: its two newest branches joined, then the adelic model's first lanes proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer — first the join of its proof branch (the dual group, Pontryagin duality, the pieces, the entropy file, two ports, all proved) with its planning branch (the deduction under the declared theorem, the ring, the adelic model's interface and construction, the zero-entropy side's second half, all typed); then one statement moved so that two lanes do not declare it twice; then lane T's first lanes — the interface's four derived leaves, the local and the archimedean arithmetic — and the ring's lane M9-R, and the global character's lane T-C as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's map planner works in `fs131-wch` on a branch from the planning branch (it types new modules only); the port's landing runs in `fs132-wi1` and may hold the build slot for an hour
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the join conflicts anywhere but `ARCHITECTURE.md`, if a leaf is false as stated or needs a hypothesis it lacks, and with one line when the joined branch builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wp23` at `{TIP}`; its build is current for that commit) and into which you merge `fs131-wk8b` (at `{K8}`) with `--no-ff` as your first commit, `ARCHITECTURE.md`'s conflict resolved by keeping both sides' rows (`git merge-tree` reports that file alone); then: the statement of `Rigidity.TateModel.sigmaCompactSpace` moved, text unchanged, from `Proofs/HadwigerNelson/Rigidity/ThinBoxes.lean` to `Proofs/HadwigerNelson/Rigidity/TateModel.lean` (item {KB}'s ruling 2); then **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/TateModel.lean`, `TateLocal.lean`, `TateArch.lean`, `TateCharacter.lean` and `RingScope.lean` (its lane M9-R leaves only: `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing`); the docstring drafts D5 of the last implementer's record (prose only, item {KP}'s ruling 1); your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/itt1/`; `data/fs131/reports/{JOB}.md`. **Not** `TateKernel.lean`, the M8b modules, `PositiveEntropy.lean`, `EntropyFibres.lean`, `EntropySplitMax.lean`, `ChainAtTA.lean`, any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`): leave them. Nothing on `main`
  budget: {BUDGET}

Hello. Tonight the chain's work forked into two branches: one where implementers proved the dual group, Pontryagin
duality, the pieces with Lemma Γ, the entropy file and two ports of the outside release; one where planners typed the
deduction under the declared theorem, the ring, the adelic model's interface and its construction, and the zero-entropy
side's second half. You join them, and start proving the adelic model.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The adelic model (Tate's self-duality in the form the zero-entropy side reads) is the chain's longest single stretch,
priced by its planner at about two agent-days; its first lanes are the ones everything else in it reads.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the model is now:

{DI}
{DT}
The three hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

{item(KT)}
{item(KB)}
{item(KP)}
**Your work, in order.** (1) **The join**: the merge commit; one build under the slot of the joined tree. (2) **The
move**: `TateModel.sigmaCompactSpace`'s statement from `ThinBoxes` to `TateModel`, text unchanged, the stored
statements of both modules dumped before and after (the moved one IDENTICAL, now in `TateModel`; nothing else moved).
(3) **T-I**, `TateModel`'s four derived leaves (`mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap`),
`sigmaCompactSpace` with them if `isOpenMap` reads it. (4) **T-L**, `TateLocal`: fold the three proofs closed in the
planner's scratch `{SC}` first, then its other leaves. (5) **T-A**, `TateArch`. (6) **M9-R**, the ring's two leaves on
the model's path. (7) **T-C**, `TateCharacter`, as far as you reach. The plans per leaf: the interface planner's record
`{PT}` § 4.3 (lane T) and § 5.1 (the lanes); the zero-entropy planner's `{P9}` § 3 (M9-R); the second-half planner's
`{PB}` § 6.1 (the collision). The last implementer's record `{IP}` is the worked pattern for this chain's files and
holds the docstring drafts D5.

## Done means

1. **The join and the readback** (a saved stage, and the one line to me when the joined tree builds): the quoted lines
   checked against their sources; each leaf's statement restated in one line beside its plan; the stored statements of
   every file you touch dumped from the built joined tree before any edit.
2. **The move** (a saved stage), shown from the kernel's side.
3. **The lanes** (saved stages as leaves fall); re-price what is left of lane T from the first two leaves of each lane
   and say so.
4. **No statement and no definition changed** but the move, shown from the kernel's side against item 1's dump (a
   planted change watched firing); one build under the slot with no warning from your files but their remaining
   leaves'; the axioms of every public declaration of your files printed from the built tree — the standard three, or
   `sorryAx` only through named leaves — each listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside items 3–7; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the declared printed
theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 329 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wp23`; the join adds the planning branch's modules, so the
first build compiles them (expect 10–20 minutes). One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name itt1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`. On
exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/itt1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-join-tate.md","w").write(b); print("ok",len(b))
