exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KPD1: the chain's Pontryagin-duality planner — D1 and D2 for a countable discrete abelian group (lane PD of FS131-KN8).
# Usage: mk-fs131-kpd1.py <inventory item of KN8's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K8=int(sys.argv[1])
TREE="fs131-wq1"; BR="fs131-wpd"; JOB="FS131-KPD1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wk8"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "iq1/stmt" not in l]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DP=Q(C,"- 2026-10-14 — **A classical input the leaf list does not name: Pontryagin duality","§ Dated lines")
P8=W+"plans/FS131-KN8-chain-split.md"; DG=W+"Proofs/HadwigerNelson/Rigidity/DualGroup.lean"; PC=W+"Proofs/HadwigerNelson/Rigidity/Pieces.lean"
for p in (P8,DG,PC,ROOT+"plans/FS100-X02D-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: Pontryagin duality for a countable discrete group, planned and typed to its leaves

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the fifth planner on this chain, and the first on this one classical input
  role: the kernel lane's planner for one classical input of the chain under "five colours at the square root of 47" that its leaf list did not name: Pontryagin duality for a countable discrete abelian group, in the two halves the last planner named — typed to its leaves, its route chosen by measurement, priced
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's implementer works in `fs131-wch` and the port's implementer in `fs132-wi1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a statement already typed must change, and if your pricing comes out over a week of agent work (before you plan the fallback in detail); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-pontryagin.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from `fs131-wk8` (at `{TIP}`, checked out there now): new modules under `Proofs/HadwigerNelson/Rigidity/` (or a better place you name) with their lines in the build's lists and `ARCHITECTURE.md`; statements in `Proofs/HadwigerNelson/Rigidity/Pieces.lean` only where its leaves that read duality need one re-pointed to your theorems (the statement of an existing leaf changes only on my ruling); `plans/{JOB}-pontryagin.md`; `data/fs131/kpd1/`; `data/fs131/reports/{JOB}.md`. **Not** the proofs of any other module's leaves, `Rigidity/DualGroup.lean`'s statements, any module under `Outside/`, the declared printed theorem. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the statements, after the route's measurement and after each few leaves' plans

Hello. The last planner on this chain typed the modules the positive-entropy split reads, and found that one of them
leans on a classical theorem the chain's leaf list never named: Pontryagin duality, which the derivation cites as
textbook. It sized one half at about a day and the other at about the size of the Peter–Weyl theorem. You plan it.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
So the default is to formalize, not to declare. The chain's milestone may assume the literature, but every axiom it
adds is one more thing the publication must either price onto the standard three or carry, and this one may be much
smaller than it looks: what the chain reads may be far less than the general theorem.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that names the input:

{DP}
The last planner's hand-back as I logged it, with my rulings (ruling 2 is yours, including a route I saw — mine,
unchecked, offered for you to measure, not a plan):

{item(K8)}
Where everything is, in your tree: the last planner's record `{P8}` (§ 2.3: D1 and D2 as it found them, its route for
D1 and its sizing of D2; § 2.5: the plan per leaf, including the leaves of `Rigidity/Pieces` that wait on this lane; §
5.1: the lanes), the dual's module `{DG}` (the topology, compactness, Polishness, Fourier uniqueness, Haar), and the
pieces' module `{PC}` (PE-1′ and the leaves that read duality). The derivation's use: `plans/FS100-X02D-derivation.md`
(HX-1's step 1 and PE-1′).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the exact statements the chain reads
   of D1 and D2 restated — every use, by file and declaration, with what each use needs at its site (the general
   theorem, or only the case the last planner named: a closed subgroup with zero annihilator is everything).
2. **The statements typed** (a saved stage): D1 and the form of D2 the chain reads, for a countable discrete abelian
   group with the dual's existing topology, in new modules, with `sorry` at the leaves only, each read aloud against
   the use and against a textbook statement (say which, and how much of it you read), each with a model. If the general
   D2 is cheaper than the case, say why.
3. **The route, chosen by measurement** (a saved stage): the reduction to finitely generated subgroups and tori named
   in ruling 2, against the Haar-measure route, each priced from its first leaves, not from a table; Mathlib's
   coverage at the pin of each route's pieces (tori, closed subgroups of `ℝⁿ` or of a torus, Kronecker's theorem,
   characters of finitely generated abelian groups), checked by name.
4. **A plan per leaf** an implementer can follow, and the lanes, sharing no file. **Run the domain pass as a fresh
   skill invocation on every new definition, and the obligation pass on every new statement.**
5. **The price** in agent-days, from item 3. If over a week: the fallback's four items of `LEAN.md` § Assumptions
   drafted (not declared), and a message to me first.
6. **Drafts**: dated lines for the claim list; bibliography lines for every textbook you read or cite.
7. The report in the standing rules' form.

## What is yours to decide

How the statements are cut and where the modules live; which route; whether Tate's self-duality of the adeles (the
zero-entropy side's model, the last planner's § Stage 4) shares your route, in words, if you reach it. Not yours: a
declared axiom; a change to a typed statement of another module without my ruling; proving leaves beyond a few lines
while testing a route; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is the last planner's, current with your branch's parent: build on it. One file
through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kpd1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kpd1/`.
Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-pontryagin.md","w").write(b); print("ok",len(b))
