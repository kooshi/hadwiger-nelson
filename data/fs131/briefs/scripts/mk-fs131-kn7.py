exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN7: the chain's next planner — a possible defect in the declared printed theorem first; then lane N typed;
# the ergodic decomposition's used cone by trial; the next modules planned.
# Usage: mk-fs131-kn7.py <inventory item of KN6's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K6=int(sys.argv[1])
TREE="fs131-wq1"; BR="fs131-wk7"; JOB="FS131-KN7"; W=WT+TREE+"/"; CH=WT+"fs131-wch/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-chain-next.md")
assert os.path.isdir(W+".lake/build")
CT=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wch")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
D3=Q(C,"- 2026-10-14 — **The headline with closed hypotheses takes eight")
P6=CH+"plans/FS131-KN6-chain-first-layer.md"; PE=CH+"Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean"
M7=CH+"data/fs131/kn3/claims-M7-entropy-split.md"; M8=CH+"data/fs131/kn3/claims-M8-zero-entropy-carried.md"
EL="/home/kooshi/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf"
for p in (P6,PE,M7,M8,EL,ROOT+"plans/FS131-EN2-derivation.md",CH+"tools/fs131_kn6_release_copy.py"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain, next: a possible defect in its declared printed theorem first, then the zero-entropy module typed, the ergodic decomposition's cost measured, and the next modules planned

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the third planner on this chain, after two who laid out its architecture and brought its first layer through a build
  role: the kernel lane's planner on the chain under "five colours at the square root of 47" — first, settle whether the printed theorem the chain declares asserts something its page does not (one possible defect is named below); then type the two statements a module needs before an implementer can take it, measure by trial what one of the outside release's theorems costs to port, and plan the chain's next modules to their leaves
  launch: now, in a tree whose last job is long finished, on a new branch cut from the chain's branch; an implementer works on the chain's entropy files in `fs131-wch` (its branch `fs131-we1`), and a landing of another line is in flight in `fs131-wrc` with priority on the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** with your finding on the declared theorem (§ Done means item 2) before you build on it either way; at once for a statement defect anywhere in the chain; before you elaborate any file of the outside release (say which and how large — the method of item 717 is already approved, so this is a notice, not a request, unless the file fails its scan); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KN7-chain-next.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from the chain's branch `fs131-wch` (at `{CT}`): new modules of the chain under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists; `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` **only if § Done means item 2 ends in a repair I have ruled on**; `Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean` statements only where a module you plan needs one typed; the draft claim lists under `data/fs131/kn3/` where your plans change them (old text kept in git); `plans/FS131-KN7-chain-next.md`; `data/fs131/kn7/`; `data/fs131/reports/{JOB}.md`. **Not** `Proofs/HadwigerNelson/Rigidity/Entropy.lean` or the three ported modules (an implementer's, on another branch). An untracked folder `data/fs131/iq1/stmt/` from an older job is in this tree: leave it, commit nothing of it. Nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: about 400k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the finding on the declared theorem, after each module's statements, and after each few leaves' plans; hand back at a saved stage rather than start a step you cannot finish

Hello. Yesterday this chain went through a build for the first time and its planner found that the headline needs one
hypothesis fewer; the derive lane had already removed two classical theorems from its path. This job continues from
that planner's record — and starts with the one thing it flagged that could be wrong rather than merely unfinished.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The chain ends at one printed theorem, declared as an axiom because it is someone else's and long to formalize. An
axiom that says more than its page can be inconsistent, and then everything built on it proves anything; the kernel
cannot see that. Nothing is proved over the declared theorem yet, so a defect in it costs least now.

## The statements

What the chain does not claim, from its claim list `data/fs131/claims-NF2.md`, and the latest of its dated lines:

{NC}
{D3}
The last planner's hand-back as I logged it (its words are in quotation marks; the rulings are mine — (b) is your
first item):

{item(K6)}
Where everything is. The chain's branch `fs131-wch` (its tree is the implementer's now; read it by path): the last
planner's record `{P6}` (§ Stage 6: what the declared theorem's four items still lack; § 5: the entropy base and its
lanes; § 3a–3c: the passes), the declared theorem in `{PE}` (the `axiom` at its line 64), and the two re-cut claim
lists `{M7}` and `{M8}`. The page: `[EinsiedlerLindenstrauss2022]` in `BIBLIOGRAPHY.md`, our copy `{EL}`. The deriver's
record `plans/FS131-EN2-derivation.md` (its entries EN2-CNT and EN2-ZE are the two statements lane N needs typed; § 5
says what each module reads, against the release's stored statements). The trial method for the release's files:
`{CH}tools/fs131_kn6_release_copy.py` and inventory item 717.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the declared statement read from
   the kernel's side; the last planner's § Stage 6 restated.
2. **The declared theorem, against its page** (a saved stage, and a message to me before anything else is built on
   it): the possible defect named in item (b) above — that the statement asserts a Borel structure on the quotient by
   a closed subgroup from an instance the hypothesis does not supply — settled one way or the other, with the page and
   line of the printed statement it is read against; and the other two points the last planner listed for a second
   reader (the infimum form of the entropy; "ergodic" as strict invariance) each with its reading. If the statement
   needs a repair, propose it with the old and new forms and why the new one is implied by the page; **do not make
   it before my ruling**.
3. **Lane N typed** (a saved stage): the two statements the deriver wrote for the zero-entropy side (EN2-CNT and
   EN2-ZE), typed in a new module with `sorry` at the leaves, each read back aloud against its entry, each with a
   model; a plan per leaf an implementer can follow.
4. **The ergodic decomposition, measured by trial** (a saved stage): the used cone of the release's ergodic
   decomposition and of its generating-sequence files, by the method of item 717 (scan, copy into an ignored folder,
   elaborate one file at a time under the slot); what each needed at this pin; whether the positive-entropy module's
   one port input is hours or days.
5. **The next modules planned to their leaves**: the positive-entropy split on the deriver's variant, and the rest
   of the zero-entropy side, each with its statements typed and compiled with `sorry` at the leaves only, a plan per
   leaf, and lanes that share no file. **Run the domain pass as a fresh skill invocation on every new definition.**
6. **Drafts**: dated lines for the claim list; the read-back of the declared theorem as it stands after item 2.
7. The report in the standing rules' form.

## What is yours to decide

How the new modules are cut; which of the deriver's two routes each takes where it offers two; the order after item
2; how much of the chain's later modules you reach. Not yours: a change to the declared theorem without my ruling;
proving leaves beyond a few lines while testing a plan; the chain's entropy file and its ported modules; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a
build with only small modules stale about 7 minutes. This tree's compiled library is older than `main`; bring it up
to date as the last two planners did (copy from `fs131-wnf` by checksum, the record saying what was copied and how it
was compared — that tree is not to be written to) or by recompiling.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn7 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. **A landing's gate steps have priority on the slot**; on exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs131/kn7/`. Copies of the release's text stay under the tree's ignored
`build/` folder and are in no commit.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-next.md","w").write(b); print("ok",len(b))
