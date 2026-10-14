exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KM11: the planner of M11 (A⁺ at S = ∅, the hypothesis `(chainInterface F).APlusOfR88` of the chain's headline),
# typed to its leaves and priced; the cyclic-subspace step stated as a lemma.
# Usage: mk-fs131-km11.py <item of KR1's hand-back> <item of IJ1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KR,KI=int(sys.argv[1]),int(sys.argv[2])
TREE="fs132-wi1"; BR="fs131-wm11"; JOB="FS131-KM11"; W=WT+TREE+"/"; WQ=WT+"fs131-wq1/"; BASE="1e438c171"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-f4"
assert subprocess.run(["git","-C",ROOT,"merge-base","--is-ancestor",BASE,"fs131-wt3"]).returncode==0
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
DB=Q(C,"- 2026-10-14 — **`BochnerOn` is read by M11 only","§ Dated lines")
DC=Q(C,"- 2026-10-14 — **The count reads one constant**","§ Dated lines")
for p in (ROOT+"plans/FS131-close-inventory.md",ROOT+"LEAN.md",ROOT+"plans/FS84-SI-D-derivation.md",WQ+"plans/FS131-KR1-chain-map.md",WQ+"Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean",WQ+"Proofs/HadwigerNelson/Rigidity/BochnerTau.lean",WQ+"Proofs/HadwigerNelson/Rigidity/InvariantMeasure.lean",WQ+"Proofs/HadwigerNelson/Rigidity/Herglotz.lean",WQ+"Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M11 (A⁺ at the empty set), typed to its leaves and priced

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the twelfth planner on this chain, and the planner of its last unplanned module but one
  role: the kernel lane's planner for module M11 — the hypothesis `(chainInterface F).APlusOfR88` of the chain's headline: for every invariant colouring and trace spectral measure, the condition R88TCA forces the measure's real part off T + A to be negative — typed to its leaves with a plan per leaf, its one step no record states as a lemma (the cyclic-subspace step) stated and planned, its composition typed, and the whole priced from first leaves written in scratch
  launch: now, in a finished tree on a new branch cut from the chain's joined line; the chain's implementer proves M3 and M2b in another tree on that line, and three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a hypothesis of `APlusOfR88` is unread or a shorter route removes a step, if a classical input none of the chain's lists names is needed, and if M11 prices over a week from its first leaves; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-aplus.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from the chain's line at `{BASE}` (`git checkout -b {BR} {BASE}`; the tree's compiled library is `main`'s at the port's landing, so the first build compiles the chain's modules — budget 15–40 minutes, and read while it runs): new modules under `Proofs/HadwigerNelson/Rigidity/` for M11 with their lines in the build's lists and `ARCHITECTURE.md`; `plans/{JOB}-aplus.md`; `data/fs131/km11/`; `data/fs131/reports/{JOB}.md`. **Not** any typed statement of another module (`ChainAtTA`'s `chainInterface` and its `APlusOfR88` are read, not changed; M10's `contChars_tauPrime`, M2a's `bochnerHerglotz_of_countable` and M2b's `BochnerTau` are read as stated), the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the statements, after the plan per leaf, and after each priced first leaf

Hello. The chain's map priced every module; one of them, M11, it read and priced but did not type, and it names one
step in it that no record states as a lemma. M10 (the continuity group is T + A) and M2a (Herglotz–Bochner on every
countable group) are now proved on the chain's line, and M2b is being proved. You type M11 so its implementers can start.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
M11 sits at the end of the chain's road `M4 → M10 → M2b → M11`; it is the last module whose statements are not yet
typed, so its plan is on the chain's critical path.

## The statements

What the chain does not claim, and the dated lines of its claim list (`data/fs131/claims-NF2.md`) that bear on M11:

{NC}
{DB}
{DC}
The map planner's hand-back and the last chain implementer's, as I logged them (their words in quotation marks, the
rulings mine):

{item(KR)}
{item(KI)}
**Where everything is** (on the chain's line: the same paths in your branch once it is cut; until then in the chain
implementer's tree, read only): the map planner's record `{WQ}plans/FS131-KR1-chain-map.md` § 2.4 — M11 read: its route
(J45 SI-1, SI-3, SI-4, A⁺ with remark (ii)), steps (a)–(g), "(d) … **the step no record states as a lemma**", its price
"1,500–2,500 lines", and what it needs (M10, M2b, M4); `{WQ}Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` (the headline
and `chainInterface`, whose field `APlusOfR88` you prove); `{WQ}Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean`,
`{WQ}Proofs/HadwigerNelson/Rigidity/Herglotz.lean`, `{WQ}Proofs/HadwigerNelson/Rigidity/BochnerTau.lean`,
`{WQ}Proofs/HadwigerNelson/Rigidity/InvariantMeasure.lean`; the derivation entries J45 (`plans/FS84-SI-D-derivation.md`)
and the records the map planner cites. `LEAN.md` § The kernel's cost model.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut and built;
   `(chainInterface F).APlusOfR88` printed from the kernel and restated; the map planner's steps (a)–(g) restated with
   what each reads and produces, and which kernel theorems already hold each.
2. **The statements typed** (a saved stage): with `sorry` at the leaves only, each read aloud against its derivation
   entry, each with a model; **step (d), the cyclic-subspace step, stated as a lemma** of its own with its hypotheses
   named; the composition proving `APlusOfR88` from the parts. **The domain pass as a fresh skill invocation on every
   new definition, and the obligation pass on every new statement** — and every instance and definition's stored type
   read for a class binder its section declares (item 847's defect).
3. **Priced from first leaves** (written in scratch, elaborated, measured), at least step (d)'s hard leaf; every
   classical input named, searched for by name at the pin, formalize-or-declare stated, **no axiom declared**.
4. **Lanes**, sharing no file, with what each waits on and its measured price.
5. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
6. The report in the standing rules' form.

## What is yours to decide

How M11 is cut into modules; which derivation route each step takes; the order after item 1; how far into item 3 you
reach. Not yours: a declared axiom; a change to a typed statement of another module without my ruling; proving leaves
beyond the first leaves a price needs; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name km11 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree, and run every command from inside it. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. A cap kill
under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its command line.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/km11/`. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-aplus.md","w").write(b); print("ok",len(b))
