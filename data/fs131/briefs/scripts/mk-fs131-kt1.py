exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KT1: the chain's seventh planner — the interface TateModel F typed, then lane T (Tate's self-duality of the
# adeles, in the form the model reads) planned to its leaves and priced.
# Usage: mk-fs131-kt1.py <item of KN9's hand-back> <item of KPD1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K9,KP=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wkt"; JOB="FS131-KT1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wk9"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
L21=Q(C,"NF2-LEAF-21: ")
DT=Q(C,"- 2026-10-14 — **Tate's self-duality reads D2 for its surjectivity","§ Dated lines")
DW=Q(C,"- 2026-10-14 — **EF_F⁺ on a weaker reading of the ring","§ Dated lines")
P9=W+"plans/FS131-KN9-chain-zero-entropy.md"; PP=WT+"fs131-wq1/plans/FS131-KPD1-pontryagin.md"; P8=WT+"fs131-wq1/plans/FS131-KN8-chain-split.md"
for p in (P9,PP,P8,ROOT+"plans/FS100-X01D-derivation.md",W+"Proofs/HadwigerNelson/Rigidity/RingScope.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the interface to the adelic model typed, then Tate's self-duality planned to its leaves

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the seventh planner on this chain
  role: the kernel lane's planner for the zero-entropy side's model — first type the structure that holds exactly the facts the zero-entropy side reads of the dual of the ring as adeles modulo the diagonal, so that two lanes can run beside each other; then plan lane T, the construction of that structure (Tate's self-duality of the adeles in the form the model reads), to its leaves, choosing between two forms of the local character by measurement, and price it
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's implementer works in `fs131-wq1` on the pieces, the port's implementer in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a classical input none of the chain's lists names is needed, and if your price for lane T comes out over a week of agent work (before you plan a fallback); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-tate.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wk9` at `{TIP}`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` (or a better place you name) with their lines in the build's lists and `ARCHITECTURE.md`; the draft claim list `data/fs131/kn3/claims-M8-zero-entropy-carried.md` where your plan changes it (old text kept in git); `plans/{JOB}-tate.md`; `data/fs131/kt1/`; `data/fs131/reports/{JOB}.md`. **Not** any typed statement of another module, the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the interface, after the measurement of the two forms, and after each few leaves' plans

Hello. The zero-entropy side of the chain reads a model of the dual of its ring: adeles modulo the diagonal, through a
standard character. Mathlib has the adele rings as topological rings and nothing of their duality. The last planner
decided the model on a weaker reading of the ring than the derivation used, priced Tate's duality at several days, and
recommended an interface so that the model's construction and the zero-entropy side's use of it can be built at the
same time. I approved the interface. You type it, then plan its construction.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The construction of the adelic model is now the longest single stretch on the chain's road; a typed interface lets the
zero-entropy side's planner and implementers start without waiting for it.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) the model serves, and the two dated lines that say
what it now reads:

{L21}
{DT}
{DW}
The two hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine; ruling 1 of the
first is the interface, ruling 2 is lane T):

{item(K9)}
{item(KP)}
Where everything is: the last planner's record `{P9}` § Stage 4 (§ 4.1: the model built for `O′` and read for `R`,
its table of the five facts M8b reads and how each is obtained; § 4.3: the classical inputs, searched at the pin; §
4.4: what M8b's planner inherits), the duality planner's record `{PP}` § 5.2 (the surjectivity from the duality theorem's
case), the split planner's record `{P8}` § Stage 4 (the model's vocabulary first decided), the ring's module
`{W}Proofs/HadwigerNelson/Rigidity/RingScope.lean` (`stableIntegers`, `R ⊆ O′` proved, `c·O′ ⊆ R` typed), and the
derivation `plans/FS100-X01D-derivation.md` § 2.0 (the model).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the five facts restated from § 4.1's
   table, each with where M8b reads it.
2. **The interface** (a saved stage): `TateModel F` typed as ruling 1 of the first item says — its fields exactly the
   five facts, each read aloud against X01D's statement of it, quantifying over nothing of ours beyond what X01D reads;
   the existence `exists_tateModel` (or your name) a leaf; a model of the structure's hypotheses where one is possible
   without the construction (say if none is); compiled with `sorry` at the leaves only.
3. **The two forms of the local character, measured** (a saved stage): both definitions of `ψ_w` the last planner names
   (or the two you find), each carried through its first two leaves in scratch, and the cheaper chosen by what the
   leaves cost, not by a table.
4. **Lane T planned** (saved stages): the construction typed to its leaves — `W`, `ψ`, `π`, the five facts as theorems
   — with `sorry` at the leaves only, each read aloud, each with a model, a plan per leaf naming Mathlib's
   declarations at the pin.
5. **The price** in agent-days, from items 3–4; if over a week, a message to me first. No axiom declared.
6. **Lanes**, sharing no file; **the domain pass as a fresh skill invocation on every new definition, and the
   obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; the form of `ψ_w`; the order after item 2. Not yours: a declared axiom; a change
to a typed statement of another module without my ruling; proving leaves beyond a few lines while measuring; M8b's
parts 2–4 (another planner's, over your interface); the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kt1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's build of the whole library
may hold the slot for up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/kt1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-tate.md","w").write(b); print("ok",len(b))
