exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICM2: M13's six private leaves — Lemma P's two first, then q in {3, 7}, the dyadic sizes, the exact spectra at
# 23, 27 and 31; the certificate link at q in {11, 19} left for the join.
# Usage: mk-fs131-icm2.py <item of KR1's hand-back> <item of KC13's hand-back> <item of ICM1's hand-back> <item of IKC2's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KR,KC,KL,KK=[int(x) for x in sys.argv[1:5]]
TREE="fs131-wch"; BR="fs131-wcm2"; JOB="FS131-ICM2"; W=WT+TREE+"/"; JOIN=""; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wcm" and [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not (l.startswith("?? data/fs131/icl1/") or l.startswith("?? data/fs131/icl2/") or l.startswith("?? data/fs131/icm1/"))]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
DA=Q(C,"- 2026-10-14 — **One archimedean factor**","§ Dated lines")
PK=W+"plans/FS131-K12A-count.md"; RG=W+"Proofs/HadwigerNelson/"
PL=W+"plans/FS131-ICM1-implementation.md"; PM=W+"plans/FS131-KR1-chain-map.md"; WN=WT+"fs131-wnf/"; PC=WN+"plans/FS131-KC13-certificates.md"
DT=Q(C,"- 2026-10-14 — **The class-ratio checker is proved sound**","§ Dated lines")
for p in (PK,PL,PM,PC,RG+"Rigidity/ClassRatio.lean",RG+"Rigidity/CountCompletion.lean",RG+"Arith/NormOneTarget.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M13's six remaining leaves, Lemma P first

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of M13's remaining leaves — the class-ratio module's three public theorems are composed over six private leaves; you prove Lemma P's two first (Hensel's fibre count `card_fibre`, and the bound on a character new at a level `norm_charSum_new_le`), which alone make the uniform bound `tca_uniform` rest on Weil's bound and nothing else; then the residue sizes 3 and 7, the dyadic sizes, and the exact spectra at 23, 27 and 31; the certificate link at 11 and 19 stays named until the lines are joined
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf's first part prices it above twice the last implementer's estimate, if a stored statement lacks a class binder its section declares (item 847's defect), and with one line when `tca_uniform` rests on Weil's bound and the standard three alone; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wcm` at `{TIP}`; its build is current for that commit): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (its six private leaves, each restated in the last implementer's record); new modules under `Proofs/HadwigerNelson/Rigidity/` or `Proofs/HadwigerNelson/Arith/` for exact-spectrum checks if they are better public, with their lines in the build's lists and `ARCHITECTURE.md`; their rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/icm2/`; `data/fs131/reports/{JOB}.md`. **Not** the count's modules (proved), `Arith/FibreCert*` (another line), any module under `Outside/`, the declared `StandingFive.kloosterman_bound` (read as declared), the declared printed theorem. Untracked files of earlier jobs in `data/fs131/icl1/`, `icl2/`, `icm1/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The class-ratio module M13 now has its three public theorems composed — the uniform bound the count reads, the
uniform tail, and the per-prime leaf — over six private leaves. You prove them, the two that unblock the uniform bound
first.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The count's proof reads `tca_uniform`; with Lemma P proved it rests on Weil's bound, a declared outside theorem the library
already holds, and the standard three.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the count reads from M13 and what
the certificate checker holds:

{DC}
{DT}
The map planner's, the certificate planner's, the last implementer's and the certificate implementer's hand-backs, as I
logged them (their words in quotation marks, the rulings mine):

{item(KR)}
{item(KC)}
{item(KL)}
{item(KK)}
**Your work, in order** (each leaf restated with its route in the last implementer's record `{PL}` § Stage 3 and
§ Stage 4; the map's M13 route `{PM}` § 2.6; the certificate planner's § 5.2 (K4 = Lemma P) and § 5.3 (the exact spectra at
23 and 31) in `{PC}`): (1) **Lemma P** — `card_fibre`, `norm_charSum_new_le` (≈ 350–700 lines). (2)
`chromaticNumber_le_four_of_small` (q ∈ {{3, 7}}). (3) `ratioAtMost_dyadic`. (4) `charBound_one_exact` (q ∈ {{23, 27, 31}}:
exact rational cosine bounds, π bracketed by `Real.pi_gt_d20` and `Real.pi_lt_d20`). (5) `ratioAtMost_cert` (q ∈ {{11, 19}})
**stays named**: it reads `FibreCertSound.card_le_of_certOK` and the certificates' checks on the line `fs131-wc15`/`fs131-wc16`,
closed when the lines are joined. Re-price each leaf from its first part and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf restated beside its route; the
   stored statements of your files dumped from the built tree before any edit.
2. **Lemma P** (a saved stage, and the one line to me when `tca_uniform` rests on Weil's bound and the standard three).
3. **The other leaves** (saved stages as they fall).
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files and of `count_of_oneAvoidingDensityBound` printed from the built tree, each
   listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the new modules; imports; the order after Lemma P; another route for a leaf where the
recorded one does not go through (tell me which). An unread binder of a statement in your files is dropped under item
726's word, listed and named. Not yours: any other change to a statement or definition; a new declared axiom; the files
listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wcm`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icm2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/icm2/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-m13-leaves.md","w").write(b); print("ok",len(b))
