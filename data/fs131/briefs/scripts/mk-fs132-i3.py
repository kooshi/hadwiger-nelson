exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-I3: an implementer on the exclusion's leaves that need nothing ported — the step lemma (real analysis, no colouring)
# first, then the shift's calculus. Worktree fs132-wi3, cut from fs132-wk1 at the planner's "leaves committed and green" tip.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs132-wi3"; JOB="FS132-I3"; W=WT+TREE+"/"; assert os.path.isdir(W),"make the worktree first"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; INV2="plans/FS132-close-inventory.md"
KP=W+"plans/FS132-kernel-plan.md"; S=W+"Proofs/HadwigerNelson/Plane/SixRing/"
os.makedirs(ROOT+"data/fs132/i3",exist_ok=True)
STEP="\n".join(Q(S+"StepLemma.lean",p) for p in ["theorem step_lemma ","theorem exists_step_or_density_triple ","theorem exists_window ","theorem exists_shiftMap ",
        "theorem exists_density_pair ","theorem volume_pattern_pos ","theorem step_at_of_change ","theorem volume_change_pairs_pos "])
SHIFT="\n".join(Q(S+"Shift.lean",p) for p in ["theorem exists_shift_lipschitz ","theorem dist_chart_chart_shift ","theorem shift_pos ","theorem measurable_shift "])
PLAN="\n".join([Q(KP,"A, B, C need nothing ported and share no file","Stage 5"),Q(KP,"**The planner's standing permissions to an implementer**","Stage 5"),
                Q(KP,"**Hard, in order**:","Stage 5")])
b=f'''# Brief {JOB} — the step lemma and the shift's calculus: the two analytic leaves-files of the first night's exclusion, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of two modules of a planner's skeleton — replace every `sorry` in the module of the step lemma, then in the module of the shift's calculus, with a proof, changing no statement beyond what the planner has permitted in writing; the step lemma first, because the grade of this milestone's first theorem waits on it
  launch: now, in a worktree of your own cut from the planner's branch; the planner's successor is still writing other modules on that branch, a second implementer is porting outside lemmas on another, and no one else writes the two files that are yours
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **when `step_lemma` is proved with no `sorry` beneath it** (one line: which route went through, the planner's or the derivation's); **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); and for a question you cannot work around; the report goes to `data/fs132/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from branch `fs132-wk1` at `{BASE}`; its `.lake/build` is its own copy, made today): `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` and `Proofs/HadwigerNelson/Plane/SixRing/Shift.lean` (proofs; statements only as the planner's three permissions allow); new helper modules beside them if you need them, with whole new lines for them in `Proofs.lean` and `ARCHITECTURE.md`; `scripts/Axioms.lean` (a block of your own, headed "{JOB}"); `plans/{JOB}-implementation.md`, `data/fs132/i3/`, `data/fs132/reports/{JOB}.md`; **not** any other file under `Proofs/HadwigerNelson/Plane/SixRing/` (other lots: the planner's and later implementers'), anything under `Proofs/HadwigerNelson/Outside/`, any landed statement, the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: {BUDGET}

Hello. This project works on the Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance
1 share one. Four days ago an outside proof moved the answer to six or seven; in the night since, this project derived by hand a
theorem of its own on that ground: in a measurable six-colouring of the plane, a point where four colour classes meet in a
cycle cannot have the unit circle about it show the two remaining colours almost everywhere. Its proof has nine steps. Seven
of them have been derived, reworked or reached independently by more than one mind. Two have not: the step lemma — a
statement of pure real analysis, with no colouring in it — has one derivation and a planner's variant of it, both by hand.
The kernel is this project's second check, and you are the one who runs it on that step.

## Why this job

Kooshi decided this morning that this theorem is formalized first; his word, and what he said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
A planner has turned the hand argument into forty-nine leaves across twelve modules, each a Lean statement with `sorry`, read
back against its step, with a route and the Mathlib names it found. The theorem itself is already proved from the leaves. Two
modules are yours. What would cost most here is a leaf proved by changing what it says: the assembly above it elaborates
against the statements as they stand, and a leaf quietly weakened would break it — or, worse, a leaf quietly strengthened in
its hypotheses would leave the assembly proving less than it claims. So statements change only by the planner's written
permissions, and anything else comes to me. And a leaf that will not go through is not a failure of yours: the hand argument
has one derivation at this step, and "this leaf is false, here is the counterexample" is the most valuable message this job
can send.

## The statements

**Your two files**, in your worktree: `{S}StepLemma.lean` (eight leaves: the step lemma — the derivation's "Lemma S" — and its
children) and `{S}Shift.lean` (seven: the explicit shift between two unit-distance charts, its sign, its Lipschitz bound, its
measurability; `exists_shiftBounds` is already proved from them). First lines of the leaves — read each whole in its file,
with its docstring, which says in words what step of the argument it is:

{STEP}
{SHIFT}
**The planner's record**, `{KP}` — read its Stage 5 whole (§ 5.1 the modules, § 5.2 the assembly read back, § 5.3 each leaf's
readback, model, route with the Mathlib names it `#check`ed, and size; § 5.4 its numerical checks), and Stage 3's § 3.2,
where its predecessor read the hand argument's last steps line by line. What it says of your lots, its permissions, and its
ranking of the hard leaves:

{PLAN}
**The hand argument**: `/home/kooshi/source/lean-dir/plans/FS132-E3-derivation.md`, Stage 3, steps M7 (the shift) and M8 (the
step lemma); and the theorem's entry with the account of who derived and read each step,
`/home/kooshi/source/lean-dir/plans/FS132-derivation.md` § 1 (read these two at those paths: your worktree's copies may
predate them). The planner proved Lemma S along a variant of its own — a dyadic window in place of a continuity argument, a
base point of four density points in place of an integration over a neighbourhood — and says so in its record: one mind, by
hand. Either route is yours to take; say in your record which one the kernel accepted.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's Stage 5 and the two steps of the hand
   argument; your two files whole. Build your branch once as given, under the slot. Open your record. Commit and push.
2. **The step lemma's module**: every `sorry` replaced, `step_lemma` proved from its children. **Before you prove a helper,
   search this library and Mathlib for its statement's shape, not for a name** — the children are statements about a
   measurable set of reals and its density points, about a window, about an increasing bi-Lipschitz map near the identity:
   Mathlib's Lebesgue density theorem and its Lipschitz-image bounds are the planner's named tools, and a lemma of this shape
   may exist. **Read `step_lemma`'s statement aloud, in your record, against the hand argument's Lemma S**, and print its
   axioms with a control that fires. **Message me when it is proved.**
3. **The shift's module**: every `sorry` replaced. The planner names the heavy leaf (the Lipschitz bound on a closed square,
   with a numerical value that works) and a kernel theorem of this library that gives the sign; its numbers are checks, not
   proofs — the leaf needs an honest estimate.
4. **Statements**: unchanged, except by the planner's three permissions, each use reported with the leaf's name and the
   change; anything else is a message to me. No `axiom`, no `native_decide`, no new hypothesis on an existing leaf.
5. **After each file is green**: build under the slot, commit by explicit path, push. After your last green build: your
   block in `scripts/Axioms.lean` and the axioms printed for every theorem you proved (the standard three, and nothing
   else — these two modules stand on nothing outside), `tools/check_architecture.py` exit 0, `./scripts/dupnames.sh`, and the
   guarded lint — `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its
   output saved. You do not run the full gate, merge another branch, or touch `main`.
6. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds, your own token count at each stage); the report in standing rule 11's form. **Stopping at a saved
   stage with the step lemma proved and the shift's module untouched is a good report** — say exactly which leaves are left.

## What is yours to decide

The route for every leaf; the helpers and where they live; the order within each file; whether the planner's variant or the
hand argument's own route is the one to formalize. The planner's routes are one mind's, written fast: change what does not
go, and say so. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
{NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs132/briefs/"+JOB+"-step-lemma.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
