exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN8: the chain's fourth planner — the statements the positive-entropy split reads (the dual as a compact group,
# Fourier uniqueness, Lemma Γ), the split's module typed to its leaves, then the zero-entropy side's second module.
# Usage: mk-fs131-kn8.py <inventory item of KN7's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K7=int(sys.argv[1])
TREE="fs131-wq1"; BR="fs131-wk8"; JOB="FS131-KN8"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-chain-split.md")
assert os.path.isdir(W+".lake/build")
CT=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wk7")
assert sh("git","-C",W,"rev-parse","--short=9","HEAD")==CT, "tree not at fs131-wk7's tip"
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
D20=Q(C,"- 2026-10-14 — **NF2-LEAF-20 is narrowed","§ Dated lines")
L20=Q(C,"NF2-LEAF-20: ")
L21=Q(C,"NF2-LEAF-21: ")
P7=W+"plans/FS131-KN7-chain-next.md"; P6=W+"plans/FS131-KN6-chain-first-layer.md"; P3=W+"plans/FS131-KN3-chain-plan.md"
M7=W+"data/fs131/kn3/claims-M7-entropy-split.md"; M8=W+"data/fs131/kn3/claims-M8-zero-entropy-carried.md"
for p in (P7,P6,P3,M7,M8,ROOT+"plans/FS131-EN2-derivation.md",ROOT+"plans/FS100-X02D-derivation.md",ROOT+"plans/FS100-X01D-derivation.md",
          W+"Proofs/HadwigerNelson/Rigidity/HaarMultiple.lean",W+"Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain, next: what the positive-entropy split reads, typed; the split's module typed to its leaves; then the zero-entropy side's second module

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the fourth planner on this chain, after three who laid out its architecture, brought its first layer through a build, repaired its declared printed theorem to its page and typed two of its modules
  role: the kernel lane's planner on the chain under "five colours at the square root of 47" — type the statements the positive-entropy split reads from other modules (the dual of the field as a compact group with its Borel structure and Haar measure; Fourier uniqueness; Lemma Γ), type the split's own module to its leaves, and, as far as you reach, the zero-entropy side's second module
  launch: now, in the tree the last planner used (its job is finished), on a new branch cut from its branch; the port's planner works in `fs132-wi1` and the density equality's implementer in `fs133-wk1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, or a statement change of ours other than the one § What is yours to decide pre-approves; before you elaborate any file of the outside release (say which and how large — the method of item 717 is approved, so this is a notice unless the file fails its scan); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-chain-split.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from `fs131-wk7` (at `{CT}`, checked out there now): new modules of the chain under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists and `ARCHITECTURE.md`; statements in `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` (the module that holds `haar_or_zero_entropy`) and `Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` only where a module you plan needs one typed or the pre-approved change below; the draft claim lists under `data/fs131/kn3/` where your plans change them (old text kept in git); `plans/{JOB}-chain-split.md`; `data/fs131/kn8/`; `data/fs131/reports/{JOB}.md`. **Not** the proofs in `Rigidity/Entropy.lean`, `Rigidity/ZeroEntropyNames.lean`, `Rigidity/SolenoidErgodic.lean`, `Rigidity/HaarMultiple.lean`, the C0 leaves of `Rigidity/ChainAtTA.lean`, or any module under `Outside/`: those are five ready lanes for implementers (the last planner's record § 6.4), who will work from your branch or its parent; a statement in one of them that your plan needs changed comes to me first. An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}; you cannot read that count, so save a stage (a commit on your branch) after the readback, after each module's statements, and after each few leaves' plans; hand back at a saved stage rather than start a step you cannot finish

Hello. The last planner on this chain repaired the declared printed theorem to its page, weakened the entropy split
to what its one consumer reads (so the theorem that assembles the measure-rigidity statement from its two halves is now
proved with nothing under it), typed the zero-entropy names and the largest Haar multiple, and measured the release's
ergodic decomposition as a port of hours. It ran out of room before typing the split's own module. That is where you
start.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The chain is the kernel proof that the plane over the field of √47 needs five colours (ledger rows 121 and 123), on
one declared printed theorem. Its proved theorems are only as far along as its planned statements: five lanes are
ready for implementers, and the two modules after them — the split, and the zero-entropy side's second half — are
still words. The planners are the chain's critical path.

## The statements

What the chain does not claim, from its claim list `data/fs131/claims-NF2.md`, and the two leaves this job's modules
carry, with the dated line that narrowed the first:

{NC}
{L20}
{L21}
{D20}
The last planner's hand-back as I logged it (its words are in quotation marks; the rulings are mine — rulings 2 and 3
are yours to act on):

{item(K7)}
Where everything is, all in your tree on its branch: the last planner's record `{P7}` (§ 6.3: the split's module
planned in words, with its vocabulary decided; § 6.4: the lanes; § 6.2: the Haar multiple; § 2.1: the quotient's
σ-algebra; § Stage 4: the release's decomposition and what it asks of the space), the planner before it
`{P6}` (§ 5.6: the lanes; § Stage 4: the re-cut), the chain's architecture `{P3}` (its module table: M2 Fourier
uniqueness and Herglotz–Bochner, M4 the dual as a compact group with Haar measure, M5 `haar_or_zero_entropy`, M6 the
pieces and Lemma Γ, M7 the split, M8 the zero-entropy side), and the two draft claim lists `{M7}` and `{M8}`. The
deriver's records on `main`: `plans/FS131-EN2-derivation.md` (§ 5.2, entry EN2-PE2-MAX: the split's proof in steps;
entries EN2-L31 and the model for the zero-entropy side), `plans/FS100-X02D-derivation.md` (§ 3.1, Lemma Γ; § 3.2, from
`Γ` to `U`) and `plans/FS100-X01D-derivation.md` (§ 2.0, the model of the dual as adeles modulo the diagonal; Lemma
3.1′ and the pigeonhole of Lemma 3.2′).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the last planner's § 6.3 restated in
   your record, with the statements of the declared theorem and of `EntropySplit` as the kernel prints them.
2. **What the split reads, typed** (a saved stage): the dual of the field as a compact group — its topology,
   compactness, `PolishSpace` and `StandardBorelSpace` for its Borel structure (ruling 3 of the item above), and its
   Haar probability measure invariant under translation and under the rotations; Fourier uniqueness for finite measures
   on it; Lemma Γ as X02D § 3.1 states it — each in the module the chain's architecture assigns it, or a better cut you
   name, with `sorry` at the leaves only, each read aloud against its source, each with a model, a plan per leaf.
3. **`haar_or_zero_entropy`'s Polish question settled** (ruling 2 of the item above): whether its proof needs `[PolishSpace X]`;
   if it does, make the change on the standing word, with the dumps and the dated line it asks for.
4. **The split's module typed** (a saved stage): `entropySplit`'s module from the vocabulary of the last planner's § 6.3
   (the unit vectors as a subgroup of the circle, their rotation action on the dual, admissibility, the Borel structure)
   and its statements (a)–(d) there, each read aloud against EN2-PE2-MAX's steps, each with a model, a plan per leaf,
   compiled with `sorry` at the leaves only. Name the step that would fail if a reading were wrong.
5. **The zero-entropy side's second module planned, as far as you reach**: the model of the dual as adeles modulo the
   diagonal, Lemma 3.1′ over the names already typed, the pigeonhole, the wandering step — typed with `sorry` at the
   leaves only and planned per leaf, or, if you do not reach it, its vocabulary decided in words as the last planner did
   for the split.
6. **Lanes**: the implementer lanes after this job, sharing no file, with what each needs; **run the domain pass as a
   fresh skill invocation on every new definition, and the obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; any `LEAN.md` or bibliography lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; which of the deriver's routes each takes where it offers two; the order after item
1; how far into item 5 you reach. **Pre-approved, on the standing word of ruling 2:** adding `[PolishSpace X]` to
`haar_or_zero_entropy`, on its conditions. Not yours: any other change to a statement already typed without my ruling;
the declared theorem; proving leaves beyond a few lines while testing a plan; the five implementer lanes' proofs; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; the disk has about 330 GB free — do not copy compiled libraries
between trees.** This tree's compiled library is the last planner's, current with your branch's parent: build on it.
One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn8 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kn8/`.
Copies of the release's text stay under the tree's ignored `build/` folder and are in no commit. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-split.md","w").write(b); print("ok",len(b))
