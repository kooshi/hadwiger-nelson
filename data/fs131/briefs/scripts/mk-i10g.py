exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-I10G: wave 10's remaining implementer — `LevelGraph`'s two leaves, `UsablePlace`'s one, and the open gate items wave 10's
# second landing left (ruling 575 (a)). Tree fs131-w10g, cut from `main`; its first act merges the third planner's tip (make the tree first).
import subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs131-w10g"; JOB="FS131-I10G"; W=WT+TREE+"/"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
assert BASE,"make the worktree first"
K=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w10k")
A="Proofs/HadwigerNelson/Arith/"; WK=WT+"fs131-w10k/"
REC=WK+"plans/FS131-w10-kernel-plan.md"; LAND="plans/FS131-L10B-landing.md"
LEAVES="\n".join([Q(WK+A+"LevelGraph.lean","theorem StationarySet.prob_mul_card_le_indepNum "),Q(WK+A+"LevelGraph.lean","theorem map_neg_conv_cosetAverage "),
                  Q(WK+A+"UsablePlace.lean","theorem exists_usable_place :")])+"\n"
HEADS="\n".join([Q(A+"SpectralInputs.lean","theorem si4 "),Q(A+"SpectralInputs.lean","theorem spectral_carried_iff "),Q(A+"SpectralInputs.lean","theorem contChars_haar_null "),
                 Q(A+"StandingFive.lean","theorem usable_card_ge "),Q(A+"StandingFive.lean","theorem no_small_usable ")])+"\n"
PLAN="\n".join(Q(REC,p) for p in ["### 16.3 The plan per leaf","`StationarySet.prob_mul_card_le_indepNum`. Write","- L-a ","- L-b ","- L-c ","`map_neg_conv_cosetAverage`: `κ.map Neg.neg = κ`",
                                   "### 16.1 A usable place","- U1 ","- U2 ","- U3 ","- U4 ","About 450 lines; U2 is the hard child.","| `si4` |","| `spectral_carried_iff` |","| I-K10c-1 |","No statement of this pass may be changed"])+"\n"
OPEN="\n".join(Q(LAND,p) for p in ["- **`contChars_haar_null`**, **`spectral_carried_iff`**, **`si4`**","- **`usable_card_ge`, `no_small_usable`**","- **Not a gate item, a reading**"])+"\n"
b=f'''# Brief {JOB} — wave 10's three open leaves, and the gate items its second landing left open, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: wave 10's remaining implementer — merge the third planner's tip into a branch cut from `main`; prove the level row's two leaves and the leaf that exhibits a usable place of the standing field, without changing a statement; then close what the wave's second landing left open: two small Lean models, and the docstrings that still describe them as owed
  launch: when a slot frees; the wave's fourth planner starts later, from the commit your first act makes
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job — **once, early, with the hash of your merge commit** (item 1: the wave's planning line is moved onto it, so that its fourth planner and you share one history); for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs); **before you take the plan's fallback on the usable place** (a named hypothesis in place of the irreducibility: the gate now lists every such hypothesis, so it is my ruling, with what you tried); or for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{BASE}`): after the merge, `{A}LevelGraph.lean` and `{A}UsablePlace.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); **new declarations and docstrings only** in the landed `{A}SpectralInputs.lean`, `{A}StandingFive.lean` and `{A}FloorPlanes.lean` (the two models, and the notes that call them owed), or a new module of your own for the models, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner, and the merge's conflict); `plans/{JOB}-implementation.md`, `tools/fs131_i10g_*.py`, `data/fs131/i10g/`, `data/fs131/reports/{JOB}.md`; **not** any statement, definition or proof of a landed module, `scripts/Assumptions.lean` (the landing's), `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 10 is the arithmetic: the floors on the chromatic numbers of the finite targets a number field's primes supply, and the
measure-theoretic inputs of the chain that carries them to a field's plane. It has landed twice. Its third planner then stated three more
leaves, which are yours, and the second landing named — honestly, in its record — the theorems on `main` whose hypotheses no Lean object
is yet known to satisfy; the cheap ones of those are yours too.

## Why this job

A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule asks more than truth: for every theorem
whose hypotheses are structures, a Lean object meeting all of them at once. Two landed theorems bound "every usable place of the
standing field" — a family the kernel does not yet know to be non-empty; the leaf `exists_usable_place` is the object that makes them say
something. The level row is the last stated row of the wave. Kooshi, on pricing this work:

{KOOSHI}
What the planner and the landing handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`):

{item(555)}
{item(575)}
{item(556)}
{item(573)}
{item(596)}
## The statements

No statement changes in this job. Your three leaves, as they stand on `origin/fs131-w10k` at `{K}` (in your tree after the merge; read
each whole, with its docstring):

{LEAVES}
The landed heads whose open gate items you close (on `main`):

{HEADS}
What the second landing left open, in its record's words:

{OPEN}
The plan (the third planner's record, `{REC}`, Stages 14–17: read them whole — § 16.3 has the level row's children, § 16.1 the usable
place's, § 16.2 the models with their notes, § 16.5 its words to you):

{PLAN}
## Done means

1. **Your readback, then the merge.** Check the quotations against their sources. Merge `origin/fs131-w10k` (at `{K}`) into your
   branch: my trial conflicts in `scripts/Axioms.lean` only — keep both sides' blocks. Build once; `./scripts/dupnames.sh`. Since the
   planner wrote, the second landing made `NumberField standingField` a global instance (ruling 555 (a)), so its § 16.5's `haveI`
   caution no longer binds: use the instance. `#check` your three leaves and read the binders the kernel shows (inventory item 556: a
   section `variable` enters a theorem only if its statement mentions it). Open your record with what you may and may not change.
   Commit, push, and **send me the merge commit's hash**.
2. **The level row** (`LevelGraph`, two leaves, about 280 lines by the planner): `map_neg_conv_cosetAverage`, then L-a, L-b, L-c for
   `StationarySet.prob_mul_card_le_indepNum`. Save after each (a build, the axioms print for it with a control that fires, a statement
   check on elaborated signatures — the milestone's instrument is
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py`, on another wave's branch: copy it under a
   name of your own and say so — commit, push). **Before you prove a helper, search the tree for its statement's shape, not for a
   name** (item 596). Re-price after the first leaf and say so.
3. **The usable place** (`UsablePlace`, one leaf, about 450 lines; the prime 83, children U1–U4; U2 is the hard child). The plan's
   fallback for U2 — a named hypothesis on the leaf, never an axiom — is a message to me first, with what you tried: the gate's new
   step lists every hypothesis of that kind, and a leaf proved over one still leaves the two landed bounds without a known object.
   When the leaf is proved, the docstrings of `usable_card_ge` and `no_small_usable` say so, and name it.
4. **The two models** the planner priced at about 55 lines together: the point-mass model for `si4` and the trivial-action model for
   `spectral_carried_iff`, each a Lean declaration meeting every hypothesis of its theorem at once, with the theorem applied to it;
   then each docstring's note, which today says "not a Lean declaration", names the declaration. `contChars_haar_null`'s model needs a
   classical theorem the library assumes by name and is not asked. And `FloorPlanes`' first docstring paragraph, which still reads the
   floor as a statement about "the plane": the kernel's floor is about the norm-one Cayley graph of the field of `Q²` elements, and no
   declaration yet links that graph to the finite plane (the fourth planner states that link as a row) — make the paragraph say what
   the kernel holds. Docstrings and new declarations only: no landed statement, definition or proof moves, and your statement check
   shows it.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond item 1's, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint
   --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573).
   Leave no background process running, and keep what your record cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; a list of the
   open gate items you closed and those you leave, by name; the report in standing rule 11's form, ending with what is left and its
   route. Stopping at a saved stage with part of the work done is a good report — the planner itself expects U2 may hand back.

## What is yours to decide

The route inside each leaf, your helpers, where the two models live, and the order after item 1. The plan is one mind's; its Mathlib
names marked with a tick were checked and the rest it leaves to you. Change a route that does not go and say so. A statement is not
yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a finding. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave10-leaves.md","w").write(b)
print("written",JOB,"base",BASE,"| w10k",K)
