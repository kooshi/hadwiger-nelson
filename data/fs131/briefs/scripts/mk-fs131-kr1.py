exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KR1: the chain's ninth planner — the rest of its map: the seven modules no planner has read (M2's existence
# half, M3, M10, M11, M12, M13, M15), each read, priced from Mathlib at the pin, and typed as far as reached.
# Usage: mk-fs131-kr1.py <item of KN9's hand-back> <item of K8B1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K9,KB=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wch"; BR="fs131-wkr"; JOB="FS131-KR1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wk8b"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
D8=Q(C,"- 2026-10-14 — **The headline with closed hypotheses takes eight","§ Dated lines")
P3=W+"plans/FS131-KN3-chain-plan.md"; K3=W+"data/fs131/kn3/"; CA=W+"Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean"
CL=[K3+f"claims-{m}.md" for m in ("M2-herglotz-bochner","M3-markov-kakutani","M10-continuity-group","M11-a-plus","M12-count","M13-cls","M15-instances")]
for p in [P3,CA,ROOT+"plans/FS131-EN1-derivation.md",ROOT+"plans/FS131-EN2-derivation.md"]+CL: assert os.path.exists(p),p
CLS=",\n".join(f"`{p}`" for p in CL)
b=f'''# Brief {JOB} — the five-colour chain: the rest of its map, read, priced and typed as far as you reach

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the ninth planner on this chain
  role: the kernel lane's planner for the seven modules of the chain that no planner has read yet — the existence half of Herglotz–Bochner (M2), Markov–Kakutani (M3), the continuity group (M10), A⁺ at the empty set (M11), the count (M12), the five-colour criterion at the dyadic targets (M13), and the instances with the final statement (M15) — each read against its draft claim list and its derivation, priced from Mathlib's coverage at the pin, its classical inputs named, and typed to its leaves as far as you reach, so that the chain's whole remaining road is on one map
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the port's landing runs in `fs132-wi1` and holds the build slot at times; the chain's ports run in `fs131-wq1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change, if a hypothesis of the headline turns out unread or provable from what is already proved (a shorter route), and if any classical input is priced over a week of agent work (before you plan a fallback); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-chain-map.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wk8b` at `{TIP}`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` (or a better place you name) with their lines in the build's lists and `ARCHITECTURE.md`; the seven draft claim lists under `data/fs131/kn3/` where your plans change them (old text kept in git); `plans/{JOB}-chain-map.md`; `data/fs131/kr1/`; `data/fs131/reports/{JOB}.md`. **Not** any typed statement of another module (`Rigidity/ChainAtTA.lean`'s hypotheses are read, not changed), the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after each module's reading and price, and after each module's statements

Hello. Eight planners have taken the chain from its first layer to its measure rigidity: every module from the solenoid
to the statement that a zero-entropy rotation-invariant measure is carried by the smaller set is typed, most of it
proved or planned at a measured price. Seven of the architecture's modules have never been read. They carry five of the
headline's hypotheses. You read them all and put the rest of the road on one map.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The chain is the proof that the plane over the field of √47 needs five colours (ledger rows 121 and 123). How far it is
from the gate is the sum of what these seven modules cost, and nobody knows it yet. One of them, by the architecture's
table, declares an input (`m₁(ℝ²) < 1/4`): it is formalized or declared on your price.

## The statements

What the chain does not claim, and the dated line that fixed the headline's hypotheses:

{NC}
{D8}
The two most recent planners' hand-backs, as I logged them (their words in quotation marks, the rulings mine):

{item(K9)}
{item(KB)}
Where everything is: the chain's architecture `{P3}` (its module table, rows M2, M3, M10–M13, M15: what each discharges,
what it needs, which leaves of the claim list it carries); the headline with its eight hypotheses and their definitions
in `{CA}` (`min_localBound_five_le_chromaticNumber_of_closed` and `chainInterface`); the seven draft claim lists,
{CLS}; the derivations on `main`, `plans/FS131-EN1-derivation.md` and `plans/FS131-EN2-derivation.md`, with the records
they cite. The first and seventh hypotheses' status after this night: `BochnerHerglotz` is idle at countable groups for
uniqueness (item 757: M2's job is the existence half); `hRow99` is a theorem on `main` (the three-and-four-colours
landing), so the chain takes seven once it joins `main`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; for each of the seven modules, its
   row restated from the architecture and its draft claim list read; each of the headline's hypotheses mapped to the
   module that discharges it and to the derivation entry it rests on.
2. **Each module read and priced** (a saved stage per module or two): its statements as its consumer reads them; its
   classical inputs named, each searched for by name in Mathlib at the pin (`#check` or `exact?` at the skeleton) and
   priced — from a first leaf or two where the price decides anything, from Mathlib's coverage otherwise, saying which;
   formalize-or-declare stated for each; **no axiom declared** (a declared input comes to me with its four items
   drafted). For M12's `m₁(ℝ²) < 1/4`: its source, its statement, and its price as a formalization.
3. **Shorter routes**: any hypothesis that a module already proved or planned on the chain's branches discharges, or
   that its consumer does not read in full; message me at once.
4. **Typed as far as you reach** (saved stages): the cheapest and the most-blocking modules first, by your price —
   statements with `sorry` at the leaves only, each read aloud against its source, each with a model, a plan per leaf
   with Mathlib's names; **the domain pass as a fresh skill invocation on every new definition, and the obligation
   pass on every new statement.**
5. **The map**: the chain's whole remaining road — every module, its state (proved, planned, typed, read, unread), its
   lanes, their price, what each waits on — in one table in your record, so that I can staff it and report it.
6. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
7. The report in the standing rules' form.

## What is yours to decide

The order of the seven; how the modules are cut and named; which of the derivations' routes each takes; how far into
item 4 you reach. Not yours: a declared axiom; a change to a typed statement of another module without my ruling;
proving leaves beyond a few lines while measuring; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 329 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kr1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's landing may hold the slot for
up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/kr1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-map.md","w").write(b); print("ok",len(b))
