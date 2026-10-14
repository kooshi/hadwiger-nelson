exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-K8B1: the chain's eighth planner — M8b's parts 2–4 (thin boxes and Lemma 3.1′, the pigeonhole and the global
# point, the leaves and wandering shells) typed over the interface TateModel F, to zeroEntropyCarried.
# Usage: mk-fs131-k8b1.py <item of KN9's hand-back> <item of KT1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K9,KT=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wk8b"; JOB="FS131-K8B1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wkt"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
L21=Q(C,"NF2-LEAF-21: ")
DH=Q(C,"- 2026-10-14 — **NF2-LEAF-21's height count is replaceable","§ Dated lines")
DW=Q(C,"- 2026-10-14 — **EF_F⁺ on a weaker reading of the ring","§ Dated lines")
DI=Q(C,"- 2026-10-14 — **The model of the dual is typed as an interface","§ Dated lines")
P9=W+"plans/FS131-KN9-chain-zero-entropy.md"; PT=W+"plans/FS131-KT1-tate.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (P9,PT,RG+"TateModel.lean",RG+"ZeroEntropyNames.lean",RG+"ChainAtTA.lean",W+"data/fs131/kn3/claims-M8-zero-entropy-carried.md",
          ROOT+"plans/FS100-X01D-derivation.md",ROOT+"plans/FS131-EN2-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the zero-entropy side's second half typed to its leaves over the adelic model

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the eighth planner on this chain
  role: the kernel lane's planner for M8b's parts 2–4 — thin boxes and Lemma 3.1′, the pigeonhole and the global point, the leaves and the wandering shells — typed to their leaves over the interface `TateModel F` the last planner typed, ending at `zeroEntropyCarried`, the chain's leaf that says a zero-entropy rotation-invariant measure is carried by the smaller set
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's pieces implementer works in `fs131-wq1`, the port's last implementer in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change (the interface included), if a classical input none of the chain's lists names is needed, and if `zeroEntropyCarried`'s hypothesis `NoRamifiedStableDyadic F` turns out to be read by your plan after all (item 788's ruling keeps it until the proof shows it unread); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-zero-entropy-second.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wkt` at `{TIP}`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists and `ARCHITECTURE.md`; the draft claim list `data/fs131/kn3/claims-M8-zero-entropy-carried.md` where your plan changes it (old text kept in git); `plans/{JOB}-zero-entropy-second.md`; `data/fs131/k8b1/`; `data/fs131/reports/{JOB}.md`. **Not** any typed statement of another module — `Rigidity/TateModel.lean` and lane T's modules, `Rigidity/ZeroEntropyNames.lean`, `Rigidity/RingScope.lean`, `Rigidity/ChainAtTA.lean` (where `zeroEntropyCarried`'s statement lives; it is read, its proof's home is yours to propose) — the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after each part's statements, and after each few leaves' plans

Hello. Two planners decided the zero-entropy side's second half in words, and the last one typed the interface to the
adelic model it reads and planned the model's construction at two agent-days. The interface is there so that you can
type the half that reads it now, beside the construction. You do.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
This half is the last unplanned stretch of the chain's measure rigidity: with it typed, every module from the solenoid
to `MRPlus F` has statements an implementer can take.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) this half carries, and the three dated lines that say
what it now reads:

{L21}
{DH}
{DW}
{DI}
The two hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

{item(K9)}
{item(KT)}
Where everything is: the zero-entropy planner's record `{P9}` § 4.2 (parts 2–4 decided over the model, on the weaker
reading) and § 4.4 (what you inherit); the interface planner's record `{PT}` § Stage 2 (the nine fields, what `Λ` is,
what is proved over the interface) and § 4.1–4.2; the interface `{RG}TateModel.lean`; the names already typed and proved
`{RG}ZeroEntropyNames.lean` (EN2-ZE, Lemma 3.1′'s part (iii)); `zeroEntropyCarried`'s statement in `{RG}ChainAtTA.lean`;
the draft claim list `{W}data/fs131/kn3/claims-M8-zero-entropy-carried.md`; the derivations
`plans/FS100-X01D-derivation.md` §§ 3.1–3.8 and `plans/FS131-EN2-derivation.md` (EN2-L31).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the three parts restated from the
   zero-entropy planner's § 4.2 with what each reads of the interface, field by field.
2. **Part 2, thin boxes and Lemma 3.1′** (a saved stage): typed with `sorry` at the leaves only, Lemma 3.1′'s part (iii)
   over the typed EN2-ZE word for word, each statement read aloud against X01D or EN2-L31, each with a model, a plan per
   leaf.
3. **Part 3, the pigeonhole and the global point** (a saved stage), on the shorter height input (the second dated line).
4. **Part 4, the leaves and the wandering shells** (a saved stage), ending at a proof of `zeroEntropyCarried`'s
   statement from parts 2–4 and the interface — its home proposed (it sits upstream of the parts in `ChainAtTA`), the
   composition typed with the parts as leaves.
5. **Whether `NoRamifiedStableDyadic F` is read**: by your plan's every step, stated with where; if no step reads it,
   say so — the implementer then drops it under the standing rule.
6. **Lanes**, sharing no file, with what each needs (lane T's leaves among them); **the domain pass as a fresh skill
   invocation on every new definition, and the obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; the order of the parts; where the composition lives. Not yours: a declared axiom;
a change to a typed statement of another module (the interface included) without my ruling; proving leaves beyond a
few lines while testing a plan; lane T; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name k8b1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's landing may hold the slot for
up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/k8b1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-zero-entropy-second.md","w").write(b); print("ok",len(b))
