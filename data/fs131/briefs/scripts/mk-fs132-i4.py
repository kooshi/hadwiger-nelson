exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-I4: the join of the port with the exclusion's skeleton, then the leaves that stand on the ported statements (the
# palettes' steps; the ring form's two leaves) and the leaves on null sets through the chart and the kill. Worktree fs132-wi4,
# cut from fs132-wk1's final tip; the port is branch fs132-wi2.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs132-wi4"; JOB="FS132-I4"; W=WT+TREE+"/"; assert os.path.isdir(W),"make the worktree first"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD"); PORT=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs132-wi2")
RQ="data/external/EXT-OAI1-request.md"
KP=W+"plans/FS132-kernel-plan.md"; S=W+"Proofs/HadwigerNelson/Plane/SixRing/"; WI2=WT+"fs132-wi2/"
os.makedirs(ROOT+"data/fs132/i4",exist_ok=True)
ST="\n".join(Q(S+"State.lean",p) for p in ["theorem OutsideOrbit.ae_iff_not ","theorem OutsideOrbit.ae_flip ","theorem OutsideOrbit.change_at ","theorem OutsideOrbit.chart_avoids ","theorem exists_tip ","theorem OutsideOrbit.hubColours ","theorem OutsideOrbit.hubColours_flip "])
EX="\n".join(Q(S+"Excl.lean",p) for p in ["theorem exists_change_of_ae_outside ","theorem ae_real_of_ae_angles "])
CM="\n".join(Q(S+"ChartMeasure.lean",p) for p in ["theorem chart_quasiMeasurePreserving ","theorem shear_quasiMeasurePreserving ","theorem ae_ne_of_not_isTip ","theorem unitPair_chart_ae "])
KL="\n".join(Q(S+"Kill.lean",p) for p in ["theorem no_double_change ","theorem step_kill "])
PLAN="\n".join([Q(KP,"A, B, C need nothing ported and share no file","Stage 5"),Q(KP,"**The planner's standing permissions to an implementer**","Stage 5"),
                Q(KP,"**Hard, in order**:","Stage 5"),Q(KP,"Nothing of this job is half done.","Stage 7")])
b=f'''# Brief {JOB} — the join: the ported outside lemmas under the exclusion's skeleton, then the leaves that stand on them, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer who joins two finished pieces of work and builds on the join — merge a colleague's port of three outside lemmas under a planner's skeleton, delete the placeholders that stood in for them, and then prove the leaves that rest on those lemmas (the palettes' steps and the ring form's two leaves) and the leaves on null sets through the chart and the final contradiction
  launch: now, in a worktree of your own cut from the planner's final tip; one other implementer is proving the step lemma's module and the shift's on a branch of its own, and a deriver works on `main` — neither writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **when the join builds** (one line: whether any leaf's statement or call site had to change, and what the merge touched); **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does), and for a ported statement whose form does not serve the leaf that cites it; and for a question you cannot work around; the report goes to `data/fs132/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from branch `fs132-wk1` at `{BASE}`; its `.lake/build` is its own copy, made today): the merge of branch `fs132-wi2` (the port, tip `{PORT}`) into your branch; under `Proofs/HadwigerNelson/Plane/SixRing/`: `Placeholders.lean` (deleted at the join), `State.lean`, `Excl.lean`, `TwoPairs.lean` (imports only), `ChartMeasure.lean`, `Kill.lean` (proofs; statements only as the planner's three permissions allow), and the import lines of any module that imported the placeholders; new helper modules beside them if you need them; `Proofs.lean` and `ARCHITECTURE.md` (the merge's two insertions kept, the placeholders' row and line removed, whole new lines for helpers); `scripts/Axioms.lean` (the port's block as merged; a block of your own, headed "{JOB}"); `plans/{JOB}-implementation.md`, `data/fs132/i4/`, `data/fs132/reports/{JOB}.md`; **not** `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` or `Shift.lean` (another implementer's, on branch `fs132-wi3`: you import their statements and do not wait for their proofs), `Chart.lean`, `Tips.lean`, `Winding.lean`, `CyclicCentre.lean` (unassigned lots), anything under `Proofs/HadwigerNelson/Outside/` (generated: a ported statement that does not serve is a message), any landed statement, the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: {BUDGET}

Hello. This project works on the Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance
1 share one. An outside proof moved the answer to six or seven four days ago; since then this project has derived by hand a
theorem of its own on that ground — in a measurable six-colouring, a point where four colour classes meet in a cycle cannot
have the unit circle about it show the two remaining colours almost everywhere — and Kooshi decided this morning that it is
formalized first. Two colleagues have each finished a half of what that needs. A planner stated the hand proof as forty-nine
leaves across twelve modules, with the theorem already proved from them; it rests on three lemmas of the outside Lean
development, which it wrote as placeholders. An implementer ported those three lemmas with everything under them — one hundred
and sixty-three declarations, kernel-checked here on the standard three axioms, no new axiom. Nobody has yet put the two
together. That is your first step, and the leaves that could not be proved until it was done are the rest of your job.

## Why this job

Kooshi's word of this morning — its last sentence is why the lemmas were ported and not declared — and what he has said of
formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
The join is where two honest pieces of work can still disagree: the planner wrote its placeholders from the release's
statements and says no leaf changes when they are replaced; the porter says its theorems keep the release's names and
binders, so that "the planner's placeholders are a deletion". Both are probably right, and neither has seen the other's
files compile together. If a leaf's statement or a call site must change to meet the ported form, that is not a failure of
anyone's — it is the first thing I want to hear, with the leaf's name. After the join, the leaves on the palettes are where
the hand argument first touches the colouring (its steps M1 to M3), and the two on the chart's null sets and the final
contradiction are the ones the planner ranks hardest. A leaf that will not go through as stated is a result: this theorem
has one derivation, and the kernel is its second check.

## The statements

**The port**, on branch `fs132-wi2` (tip `{PORT}`; its worktree, to read, is `{WI2}`): eight generated modules under
`{WI2}Proofs/HadwigerNelson/Outside/` beside the palette module, its record `{WI2}plans/FS132-I2-implementation.md` (read its
§§ 2.1, 3.4, 3.5 and its drafts for the landing), its block in the axioms script. Its four targets are
`palette_transfer_pair`, `palette_sixty_disjoint`, `two_state_impossible` and `mem_spatialSupport_ae`, in the namespace
`HadwigerNelson.Outside.OAI158`; it also holds the two lemmas on quasi-measure-preserving maps that the planner's leaves
would cite (`circleSum_quasiMeasurePreserving`, `angleMk_quasiMeasurePreserving`).

**The skeleton**, in your worktree: `{S}Placeholders.lean` (the three statements as `sorry`, and the fourth with the release's
proof — the file the join deletes), and your four files of leaves. First lines of the leaves — read each whole in its file,
with its docstring, which says in words what step of the argument it is:

{ST}
{EX}
{CM}
{KL}
**The planner's record**, `{KP}` — read its Stages 5 to 7 whole (§ 5.1 the modules and the lots; § 5.2 the assembly read
back; § 5.3 each leaf's readback, model, route with the Mathlib names it `#check`ed, size, and whether it waits on the port;
§ 7.1 where a successor takes over). What it says of the lots, its permissions, the hard leaves, and the join:

{PLAN}
**The hand argument**: `/home/kooshi/source/lean-dir/plans/FS132-E3-derivation.md`, Stage 3, steps M1 to M3 (the state on the
ring, the chart, the mixed set), M8's relation and M9 (the final contradiction); and the theorem's entry,
`/home/kooshi/source/lean-dir/plans/FS132-derivation.md` § 1 (read these at those paths: your worktree's copies may predate
them).

## Done means

1. **Your readback first**: the quotations against their sources; the planner's Stages 5 to 7; the port's record sections
   named above; your files whole. Build your branch once as given, under the slot. Open your record. Commit and push.
2. **The join.** Merge branch `fs132-wi2` into yours (a merge commit; the two branches add lines to `Proofs.lean` and
   `ARCHITECTURE.md` side by side — keep both). Delete the placeholders' file, its row and its import line; point its
   importers at the ported modules; build under the slot. **In your record: for each of the four statements, the
   placeholder's form beside the ported theorem's, and every leaf or call site that had to change, or "none".** Run
   `tools/check_architecture.py` and `./scripts/dupnames.sh`. Commit, push, and **message me**.
3. **The leaves on the ported lemmas**: the palettes' module (the state, its flip under the 60° rotation, the change, the
   chart's avoidance, the tip), the ring form's two leaves, and whatever of the two-pair ring's module the join exposes.
   **Before you prove a helper, search this library and the ported modules for its statement's shape, not for a name** — the
   port brought one hundred and sixty-three declarations, and the lemma you need about almost-every direction or about the
   angle chart may be among them.
4. **The leaves on null sets through the chart, and the final contradiction**: the chart is quasi-measure-preserving (the
   planner offers two routes — the release's lemma after a linear change, now ported, or polar coordinates), the shear, the
   unit-pair chart statement the planner ranks hardest, the relation with no double change, and the kill. These import the
   statements of the step lemma and the shift's bounds from the other implementer's two files; you do not need their proofs.
5. **Statements**: unchanged, except by the planner's three permissions, each use reported with the leaf's name and the
   change; anything else is a message to me. No `axiom`, no `native_decide`, no new hypothesis on an existing leaf.
6. **After each file is green**: build under the slot, commit by explicit path, push. After your last green build: your
   block in the axioms script and the axioms printed for every theorem you proved, with a control that fires (the standard
   three and nothing else — the ported lemmas rest on neither declared outside theorem, so nothing above them should);
   `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`; the guarded lint — `lake lint --no-build -- --no-build --trace`
   under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved. You do not run the full gate or touch `main`.
7. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured;
   the report in standing rule 11's form. **Stopping at a saved stage with the join green and the palettes' module proved is
   a good report** — say exactly which leaves are left, and what each still needs.

## What is yours to decide

How the merge is resolved; the route for every leaf; the helpers and where they live; the order after the join. The planner's
routes are one mind's: change what does not go, and say so. The ported modules are generated — you read them and cite them,
and a statement there that needs another form is a message to me, not an edit. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs132/briefs/"+JOB+"-join.md","w").write(b)
print("written",JOB,"base",BASE,"port",PORT,len(b))
