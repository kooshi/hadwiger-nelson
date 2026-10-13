exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN6: successor planner on the five-colour chain — the join with main, the modeling passes, the first build,
# the re-cut of two modules by the deriver's answers, and the entropy base planned to its leaves.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-wch"; JOB="FS131-KN6"; W=WT+TREE+"/"
assert not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-chain-first-layer.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")==TREE
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
H="§ How the chain is run (the deriver's five statements, each derived by hand, one mind)"
ST="\n".join(Q(C,p,H) for p in ("NF2-MRPLUS: ","NF2-MRPLUS-SCOPE: ","NF2-FROM-TWO: "))
NC=Q(C,"NF2-NC: ","§ Not claimed")
L17=Q(C,"NF2-LEAF-17: ","§ The chain's leaves (the map's, numbered as there)")
L18=Q(C,"NF2-LEAF-18: ","§ The chain's leaves (the map's, numbered as there)")
PLAN=W+"plans/FS131-KN3-chain-plan.md"; REP=W+"data/fs131/reports/FS131-KN3.md"; KD=W+"data/fs131/kn3/"
for p in (PLAN,REP,KD,ROOT+"plans/FS131-EN2-derivation.md",ROOT+"plans/FS131-EN1-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the chain under "five colours at the square root of 47": bring its first layer through a build, run the passes its first planner could not, re-cut two modules by what the derive lane found today, and plan its entropy base to the leaves

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the successor of the planner who laid out this chain's architecture this afternoon and stopped at its budget with three steps of the lane's workflow undone, each of which it named
  role: the kernel lane's planner continuing a chain of about sixteen planned modules — make its first four files build on today's `main`, run the modeling passes before anyone proves over its definitions, rewrite the two modules whose inputs the derive lane changed today, and plan the entropy base (the port and the definitions) down to leaves an implementer can take
  launch: now, in the first planner's tree — it has handed back and nobody else writes there; an implementer works on another milestone in `fs133-wk1` and a planner-prover on another line in `fs131-wrc`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement or definition whose form a modeling pass changes (the old and the new form, and why), for a statement defect, for anything in the deriver's two answers that does not type as written, before you build any file of the outside release anywhere (say what and how large), and with one line when the first layer is through the build with the linters read; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KN6-chain-first-layer.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`; its compiled library is older than `main` by two landings): the merge of `main` (`{MAIN}`); the four modules under `Proofs/HadwigerNelson/Rigidity/` and new modules of this chain's entropy base, with their lines in the build's lists — statements and definitions may change **only by a modeling pass or by the re-cut of § Done means item 4, each change recorded with its reason**; the draft claim lists under `data/fs131/kn3/` (rewritten where the re-cut changes them, the old text kept in git); `plans/FS131-KN6-chain-first-layer.md`; a dated section appended to the first planner's plan where a leaf's plan changes; `data/fs131/kn6/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; nothing in another tree; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: about 400k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the merge builds, after each pass, after the re-cut, and after each module's statements and each few leaves' plans; hand back at a saved stage rather than start a step you cannot finish — what is left is then a successor's from your record

Hello. This chain is the first-ranked thing this project has to show, and the longest road left: the plane over the
field of the square root of 47 needs exactly five colours, and the general statement it is a case of. A planner of
this lane drew its architecture this afternoon — the chain's hypotheses as closed statements about a field, four
files that elaborate one by one, seventeen draft claim lists for the modules to come — and ran out of budget with
three things undone, which it named. Since then the derive lane has answered both questions that planner left for it,
and each answer makes the chain shorter. This job puts the two together.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
So every hand result under this chain is to be discharged in the kernel, and only the printed theorem it finally
reads may stay a declared outside theorem. Nobody proves over a definition that a modeling pass may still move, and
the first planner said plainly that its passes were not run and its files had never been through a build. An
implementer launched on this chain today would be building on sand; after this job, implementers start on the
entropy base with statements that will not move under them.

## The statements

How the chain is run, from its claim list `data/fs131/claims-NF2.md` (the whole list is yours to read; these are the
lines everything else hangs from):

{ST}
{NC}
The two leaves the derive lane's answers change:

{L17}
{L18}
What the first planner handed back and left undone, and what the deriver answered today, as I logged them (their
words are in quotation marks inside each item; the rulings are mine):

{item(661)}
{item(711)}
Where the rest is. The first planner's record `{PLAN}` (its § Stage 5 has the four files and a slip it found by
reading its declared statement back from the kernel; § Stage 6 the architecture and what starts next; § 4 its survey
of the outside release's entropy files), its report `{REP}`, and its seventeen draft claim lists in `{KD}`. The
deriver's record `plans/FS131-EN2-derivation.md` (its § 3.5–3.6 the lemma that replaces the entropy theorem; § 4 the
positive-entropy step as a Lebesgue decomposition; § 5.1–5.2 what each of the two modules must read, set against the
release's stored statements, and a variant that reads still less). The table the chain is built from:
`plans/FS131-EN1-derivation.md` § 8.1. **The rulings that bind this chain** are listed with their inventory item
numbers in `plans/SESSION-HANDOFF-2026-10-13.md` § 5; read each at its number in `plans/FS131-close-inventory.md`
(items 642, 646, 649, 651, 658, 659, 666) — they fix at which characters the interface runs, which printed theorem is
declared and in which sense, what is formalized and not imported, and that the count at every level is typed only
under the scope hypothesis. One of them is a rule not yet in `LEAN.md`: **an axiom's binders go in its own signature,
never on a `variable` line.**

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the four files' definitions and
   statements listed, each beside the claim-list line it answers; the first planner's "not done" list restated; the
   deriver's two answers restated against the draft claim lists of the two modules they change.
2. **The join and the first build** (a saved stage): merge `main`; bring the compiled library up to date; the four
   files through `./scripts/build.sh` under the slot, the linters' verdict read from the log, what they flag fixed
   without touching a statement's meaning. Send me the one line, with wall time and peak memory.
3. **The modeling passes, as fresh invocations of your lane's skills** (a saved stage each): the domain pass on
   the entropy definitions, on the set of torsion-plus-archimedean characters, on the predicate for ramified places,
   and on every other definition and headline of the four files; the obligation pass on the leaves the plan calls
   long; the experience pass on what a reader of the published statements meets. For each change: the old form, the
   new form, the reason, the re-elaboration. A pass that changes nothing says so with what it weighed.
4. **The re-cut** (a saved stage): the two modules the deriver's answers change — the one that read the entropy
   theorem, and the one that split a measure by entropy — with their draft claim lists rewritten from the deriver's
   entries (statements copied, not retold), the route chosen where the deriver offers two, the classical statements
   each now reads named with where they come from (Mathlib, the release by port, or fresh), and what leaves the
   chain's list of classical inputs. Draft the dated lines for the claim list's two leaves above — I file them.
5. **The entropy base, planned to its leaves** (saved stages as its parts fall): which of the release's files are
   brought here by port and what their cone is; the chain's own entropy definitions pinned to the number the printed
   theorem means, with that read-back written down (the first planner says the declared statement's read-back "has
   a hole" until this is done); the statements typed and compiled with `sorry` at the leaves only; a plan per leaf
   an implementer with none of your context can follow; the split into lanes that share no file.
6. **For the declared printed theorem**: what its four items (`LEAN.md` § Assumptions: outside theorems and our own)
   still lack after this job, as a list for me — the journal's page numbers and a second reader against the page are
   known to be owed.
7. The report in the standing rules' form.

## What is yours to decide

Every change a pass makes; the route for the positive-entropy step; whether the maximal inequality the deriver
names is ported from the release's two files or written fresh; how the entropy base is cut into modules; the batch
size of your builds; whether to bring the compiled library up to date by recompiling (47 minutes was measured for a
similar gap) or by copying compiled files from the tree whose gate passed today (`fs131-wnf`) — two jobs did that
today and I accepted it on the condition that the record says what was copied, from where, and how it was compared
(inventory items 694 and 709).

Not yours: proving the leaves (prove one only if it falls in a few lines while you test a plan); the modules of the
chain beyond the entropy base and the two the re-cut changes; the sense in which the printed theorem is declared
(ruled); the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 10 minutes; one such build at `BATCH=8` peaked
at 12.3 GB summed over its processes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn6 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree (the
first planner's `{KD}lean1.sh` does this). The build: `--mem 12 --cpus 4 -- env MEMMAX=12G BATCH=4
./scripts/build.sh` from inside the worktree; never `lake build`. Two other jobs build from time to time: on exit 75
wait ten minutes and retry; if your build has waited an hour, tell me. Stop a process by its PID, never by matching
its command line, and leave none running or queued when you hand back. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/kn6/`.

The outside release (`~/source/math`) is read only: write nothing there and run nothing there. Our audit of it
(`plans/EXT-OAI1-audit.md`) built the cone of its plane proof and not the family these entropy files belong to; what
you need of that family beyond reading its source is a question for me before it is a build.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-chain-first-layer.md","w").write(b); print("ok",len(b))
