exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN9: the chain's sixth planner — M5 (haar_or_zero_entropy's deduction), M9 (the ring and the scope), then M8b
# (the zero-entropy side's second half) on KN8's vocabulary.
# Usage: mk-fs131-kn9.py <item of KN8's hand-back> <item of KPD1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K8,KP=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wk9"; JOB="FS131-KN9"; W=WT+TREE+"/"; WQ=WT+"fs131-wq1/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wl1"
JOIN="3b531d1d2"; assert sh("git","-C",ROOT,"cat-file","-t",JOIN)=="commit"
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
L21=Q(C,"NF2-LEAF-21: ")
SC=Q(C,"NF2-MRPLUS-SCOPE: ")
DT=Q(C,"- 2026-10-14 — **Tate's self-duality reads D2 for its surjectivity","§ Dated lines")
DH=Q(C,"- 2026-10-14 — **NF2-LEAF-21's height count is replaceable","§ Dated lines")
P8=WQ+"plans/FS131-KN8-chain-split.md"; PP=WQ+"plans/FS131-KPD1-pontryagin.md"; P3=W+"plans/FS131-KN3-chain-plan.md"
K3=W+"data/fs131/kn3/"
for p in (P8,PP,P3,K3+"claims-M5-totally-irreducible.md",K3+"claims-M9-ring-and-scope.md",K3+"claims-M8-zero-entropy-carried.md",
          ROOT+"plans/FS100-X01D-derivation.md",ROOT+"plans/FS105-D-deduction.md",ROOT+"plans/FS131-EN1-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain, next: the deduction under `haar_or_zero_entropy`, the ring and the scope, then the zero-entropy side's second half

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the sixth planner on this chain
  role: the kernel lane's planner on the chain under "five colours at the square root of 47" — type and plan three of its unplanned modules: M5 (Theorem 1.2 of the declared printed theorem's paper from its Theorem 1.3, the deduction under `haar_or_zero_entropy`), M9 (the ring and the scope), and M8b (the zero-entropy side's second half: the dual as adeles modulo the diagonal, thin boxes, the pigeonhole, the wandering step) on its last planner's vocabulary
  launch: now, in the chain's implementer tree (its last job is finished) on a new branch cut from the chain's newest joined commit; the chain's implementer works in `fs131-wq1` on the dual group's modules, the port's implementer in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a classical input none of the chain's lists names is needed (name it and its price), and before you elaborate any file of the outside release (a notice under item 717's method); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-chain-zero-entropy.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from the commit `{JOIN}` (the join of the chain's proved lanes into the duality planner's branch; its first parent is `fs131-wpd`, its second `fs131-wl1`, which this tree has checked out and built): new modules of the chain under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists and `ARCHITECTURE.md`; in `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` the statements M5 needs typed beside `haar_or_zero_entropy` (its own statement changes only on my ruling); the draft claim lists under `data/fs131/kn3/` where your plans change them (old text kept in git); `plans/{JOB}-chain-zero-entropy.md`; `data/fs131/kn9/`; `data/fs131/reports/{JOB}.md`. **Not** `Rigidity/DualGroup.lean`, the four duality modules, `Rigidity/UnitCircle.lean` (an implementer's, on another branch), `Rigidity/ZeroEntropyNames.lean`, `Rigidity/ChainAtTA.lean` beyond reading, the declared printed theorem, any module under `Outside/`. Nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after each module's statements and after each few leaves' plans

Hello. The chain's planners have now typed its positive-entropy half to its leaves, its implementers have proved
three lanes and the dual group, and the Pontryagin duality the chain reads turned out to cost hours. What is left
unplanned is mostly the zero-entropy side's second half and two modules upstream of it. You take them.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The planners are the chain's critical path: every unplanned module is a stretch of the road no implementer can start.
The zero-entropy side's second half is the longest of them, and its planner left its vocabulary decided in words.

## The statements

What the chain does not claim, the leaf this job's last module carries, the scope ruling the ring module states, and
the two dated lines that change what that module reads:

{NC}
{L21}
{SC}
{DT}
{DH}
The two hand-backs that left this work, as I logged them (their words in quotation marks, the rulings mine):

{item(K8)}
{item(KP)}
Where everything is: the split planner's record `{P8}` (§ Stage 4: M8b's vocabulary decided in words, four parts; §
5.1: the lanes, M5's and M8b's rows), the duality planner's record `{PP}` (§ 5.2: what Tate's self-duality reads), the
chain's architecture `{P3}` (its module table: M5, M8, M9), and the draft claim lists in your tree (`{K3}claims-M5-totally-irreducible.md`,
`{K3}claims-M9-ring-and-scope.md`, `{K3}claims-M8-zero-entropy-carried.md`). The deriver's
records on `main`: `plans/FS105-D-deduction.md` (FS105-DED, Theorem 1.2 from Theorem 1.3), `plans/FS100-X01D-derivation.md`
(§ 2.0 the model, §§ 3.1–3.8 EF_F⁺), `plans/FS131-EN1-derivation.md` (the scope: the ring equals its maximal order away
from the exceptional places; the density of the ring).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; one build of your branch under the
   slot (this tree's compiled library is for its second parent; the first parent's modules compile once); the three
   modules' rows restated from the architecture and the split planner's § Stage 4.
2. **M5 typed and planned** (a saved stage): the two statements its draft claim list marks "to type", with
   `haar_or_zero_entropy`'s proof planned per leaf from FS105-DED over the declared theorem, the finite-fibred step
   included; each statement read aloud against its source, each with a model.
3. **M9 typed and planned** (a saved stage): the ring and the scope, with the two results the leaf list does not
   number, each read aloud, each with a model, a plan per leaf.
4. **M8b typed and planned, as far as you reach** (saved stages): the split planner's four parts — the model of the
   dual as adeles modulo the diagonal (with Tate's self-duality: its surjectivity from the duality theorem's case, its
   kernel and cocompactness priced as their own leaves), thin boxes with Lemma 3.1′ over the names already typed, the
   pigeonhole with the shorter height input, the wandering shells — with `sorry` at the leaves only, each read aloud,
   each with a model, a plan per leaf; what you do not reach, its vocabulary in words.
5. **Classical inputs**: every one the plan reads that is not in Mathlib at the pin — strong approximation, Tate's
   duality, Kronecker — named, searched for by name at the pin, and priced from a first leaf or two, with the choice
   formalize-or-declare stated for each and **no axiom declared** (a declared input comes to me with its four items
   drafted).
6. **Lanes**: the implementer lanes after this job, sharing no file; **the domain pass as a fresh skill invocation on
   every new definition, and the obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; which of the derivations' routes each takes where they offer two; the order after
item 1 (M9 before M8b, which reads it); how far into item 4 you reach. Not yours: a declared axiom; a change to a typed
statement of another module without my ruling; proving leaves beyond a few lines while testing a plan; the other
lanes' files; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale 7 to 20 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn9 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kn9/`.
Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-zero-entropy.md","w").write(b); print("ok",len(b))
