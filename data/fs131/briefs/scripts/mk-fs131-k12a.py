exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-K12A: the chain's tenth planner — M12, the count (Interface.Count), typed to its leaves in its five blocks.
# Usage: mk-fs131-k12a.py <item of the density-bound ruling> <item of KR1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KD,KR=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wk12"; JOB="FS131-K12A"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wkr"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
DC=Q(C,"- 2026-10-14 — **The count reads one constant**","§ Dated lines")
DM=Q(C,"- 2026-10-14 — **`m₁(ℝ²) < 1/4` is a named outside hypothesis, not declared**","§ Dated lines")
PR=W+"plans/FS131-KR1-chain-map.md"; P3=W+"plans/FS131-KN3-chain-plan.md"; K3=W+"data/fs131/kn3/claims-M12-count.md"
RG=W+"Proofs/HadwigerNelson/"
for p in (PR,P3,K3,RG+"Rigidity/ChainAtTA.lean",RG+"Rigidity/ClassRatio.lean",RG+"Plane/OneAvoidingDensity.lean",ROOT+"plans/FS131-EN1-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the count, typed to its leaves

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the tenth planner on this chain, and the first on its longest module
  role: the kernel lane's planner for module M12, the count — the hypothesis `(chainInterface F).Count` of the chain's headline — in its five blocks as the last planner listed them, typed to its leaves with a plan per leaf, each classical input it reads named and priced from a first leaf, so that its three-to-six-week estimate becomes a measured price and its lanes can be staffed
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's implementer works in `fs131-wq1`, the port's landing in `fs132-wi1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a hypothesis of the count is unread or a shorter route removes a block, if a classical input none of the chain's lists names is needed, and if a block is priced over two weeks from its first leaf; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-count.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wkr` at `{TIP}`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` or `Proofs/HadwigerNelson/Plane/` with their lines in the build's lists and `ARCHITECTURE.md`; `plans/{JOB}-count.md`; `data/fs131/k12a/`; `data/fs131/reports/{JOB}.md`. **Not** any typed statement of another module (`Plane/OneAvoidingDensity`'s `OneAvoidingDensityBound` is read as a named hypothesis and not changed; `Rigidity/ClassRatio`'s `tca_uniform` is read), the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after each block's statements, and after each block's priced first leaf

Hello. The chain's map is complete, and it shows one module larger than the rest put together: the count, which turns
a field's local data at its stable primes into the statement the chain's measure-theoretic half reads. Its estimate is
three to six weeks, from Mathlib's coverage alone. You make it a plan and a measured price.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The count is on the chain's critical path, after M13's uniform tail, and its price decides how far the chain is from
the gate; an estimate from coverage is not a price.

## The statements

What the chain does not claim, and the two dated lines that fix what the count reads:

{NC}
{DC}
{DM}
The ruling on the count's outside input and the map planner's hand-back, as I logged them (their words in quotation
marks, the rulings mine):

{item(KD)}
{item(KR)}
Where everything is: the map planner's record `{PR}` § 2.5 (the count read: its blocks C1–C5, what Mathlib lacks —
Doob–Cohn, weak approximation for the norm-one torus, the Vitali family on the non-doubling product — and its price) and
§ Stage 5 (the map); the chain's architecture `{P3}` (row M12); the draft claim list `{K3}`; the headline and
`chainInterface` in `{RG}Rigidity/ChainAtTA.lean`; the uniform tail in `{RG}Rigidity/ClassRatio.lean`; the outside input,
typed, in `{RG}Plane/OneAvoidingDensity.lean`; the derivation `plans/FS131-EN1-derivation.md` and the records it cites.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `(chainInterface F).Count` printed from
   the kernel and restated; the map planner's five blocks restated with what each reads and produces.
2. **Each block typed** (a saved stage per block): statements with `sorry` at the leaves only, each read aloud against
   its derivation entry, each with a model, a plan per leaf naming Mathlib's declarations at the pin; the composition
   from the blocks to `Count` typed. **The domain pass as a fresh skill invocation on every new definition, and the
   obligation pass on every new statement.**
3. **Each block priced from a first leaf** (written in scratch, elaborated, its cost measured), not from a table; every
   classical input named, searched for by name at the pin, formalize-or-declare stated, **no axiom declared**.
4. **Shorter routes**: any block the chain's proved or planned modules already discharge, or that the headline does not
   read in full; message me at once.
5. **Lanes**, sharing no file, with what each waits on and its measured price; the count's row of the map rewritten.
6. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
7. The report in the standing rules' form.

## What is yours to decide

How the blocks are cut into modules; which derivation route each takes; the order after item 1; how far into item 3
you reach. Not yours: a declared axiom; a change to a typed statement of another module without my ruling; proving
leaves beyond the first leaf a block's price needs; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 324 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name k12a -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's landing may hold the slot for
up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/k12a/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-count.md","w").write(b); print("ok",len(b))
