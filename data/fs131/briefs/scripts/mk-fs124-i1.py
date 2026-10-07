exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-I1: the implementer of FS-124's first module (the radius clause) on the planner's branch fs124-wk1, in its worktree.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs124-wk1"; JOB="FS124-I1"; W=WT+TREE+"/"; assert os.path.isdir(W)
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; CK="data/fs124/claims-K1.md"
KP=W+"plans/FS124-kernel-plan.md"; P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/i1",exist_ok=True)
THM="\n".join([Q(P+"WeakColouringOn.lean","def AeProperOn "),Q(P+"Radius.lean","theorem radius_graph "),Q(P+"Radius.lean","theorem radius_countable "),
               Q(P+"Radius.lean","theorem radius_up "),Q(P+"RadiusOutside.lean","theorem radius_down "),Q(P+"RadiusOutside.lean","theorem radius_five "),
               Q(P+"RadiusOutside.lean","theorem colorable_iff_forall_ball "),Q(P+"RadiusOutside.lean","theorem seven_le_chromaticNumber_plane_iff_exists_ball ")])
PLAN="\n".join([Q(KP,"**What the module costs**:","Stage 5"),Q(KP,"2. Order: `WeakColouringOn` top to bottom (27 left)","Stage 5")])
CLAIMS="\n".join(Q(CK,f"**{n}** — statement:") for n in ["C124-RADIUS-GRAPH","C124-RADIUS-UP","C124-RADIUS-DOWN"])
b=f'''# Brief {JOB} — the radius clause in the kernel: forty-nine leaves of a planner's skeleton, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of the first module of the milestone opened today — replace every `sorry` in three modules of a planner's skeleton with a proof, changing no statement; then make the module ready for a landing: its axioms printed, its records drafted, its checks run
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; a landing of another milestone is in flight on `main`, and a deriver works under `plans/` and `data/` on `main`; you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the two theorems of the join print their axioms** (the standard three and the one declared outside theorem each names, and nothing else); and for a question you cannot work around; the report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`; its `.lake/build` is its own, built by the planner today): `Proofs/HadwigerNelson/Plane/WeakColouringOn.lean`, `Proofs/HadwigerNelson/Plane/Radius.lean`, `Proofs/HadwigerNelson/Plane/RadiusOutside.lean` (proofs only; helpers under names no other module declares); new helper modules beside them only if you need them, with whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `scripts/Axioms.lean` (a block of your own, headed "{JOB}": the clean records, and the records that rest on a declared outside theorem under the IMPORTED banner, as the planner's § 3.5 lists them); `plans/{JOB}-implementation.md`, `data/fs124/i1/`, `data/fs124/reports/{JOB}.md`; **not** any statement or definition of the three modules (a statement that will not go through comes back through me), any other module, `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the landing's: you draft their lines), the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each module, and if three attempts on one leaf fail, or you are past the second module with less than half of the third's leaves left to do, stop at a saved stage and hand back** — the planner priced the whole job at well under an hour

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and by an outside theorem this library declares, the plane's number is that of measurable colourings proper
at almost every unit pair. This afternoon a deriver of this project showed by hand how either answer would be reached: six,
if every disc has such a six-colouring — with no regularity asked of it at all; seven, if one disc has none. A planner then
stated that as a Lean module, working blind from the statements, found the same proof from the other side, and found the
statements hold more widely than claimed. It left a skeleton that builds, with eight leaves proved and forty-nine to go.
They are yours.

## Why this job

Every later result of this milestone — an exclusion on one disc, a six-coloured fragment of any regularity — will be
consumed through this module, and its last theorem is the form the problem now has: `7 ≤ χ(ℝ²)` if and only if some disc
about the origin has no weak six-colouring. A leaf proved by changing what it says would be worse here than a leaf left
open, because consumers will cite these statements by name. Kooshi's word of this morning, and what he has said of
formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
## The statements

**The claims**, in the kernel lane's claim list `{CK}` (read it whole): the first lines of three of the five —

{CLAIMS}
**The skeleton**, in your worktree under `{P}`: the shared definition's module, the radius clause's, and the module of the
statements that use a declared outside theorem. The definition and the theorems the module is for (first lines; read each
whole in its file, with its docstring — the planner states the wide forms as the cores and the claims' words as corollaries
under them):

{THM}
**The planner's record**, `{KP}` — read it whole: Stage 2 (the definition, each statement typed and read back, what the
typing found, its modeling pass), Stage 3 (§ 3.1 the routes; § 3.2 **every leaf with its route, its Mathlib names `#check`ed
at this pin, and its size**; § 3.5 what the landing needs), Stage 4 (its route beside the deriver's: one proof), Stage 5
(the price from eight leaves, and where you start). What it says the job costs, and its order:

{PLAN}
**The hand argument**, should a leaf's route fail and you want the other side's wording:
`/home/kooshi/source/lean-dir/plans/FS124-E1-derivation.md`, Stage 3 (five entries).

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; the three modules whole. Build the
   branch once as given, under the slot (it should end with 49 `sorry` warnings and no other). Open your record. Commit
   and push.
2. **The three modules, in the planner's order**, each leaf by its route in § 3.2 unless it fails — then yours, said in your
   record. **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.** After
   each module: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped — the planner gave this module no written
   permissions, and its statements are fixed; anything that must change is a message to me.
4. **When the last leaf is in**: the axioms of every theorem of the three modules printed, with a control that fires —
   the clean ones on the standard three; the five that use an import each on exactly the one the planner's § 3.5 names;
   **message me with the lines of the two join theorems**. Your block in `scripts/Axioms.lean`; `tools/check_architecture.py`
   exit 0; `./scripts/dupnames.sh`; the guarded lint — `lake lint --no-build -- --no-build --trace` under the slot with
   `--mem 8` (`LEAN.md` § The gate), its output saved. You do not run the full gate, merge another branch, or touch `main`:
   a landing job takes the branch when the landing now in flight is back.
5. **Read aloud**, in your record: `radius_up`, `radius_down` and the two join theorems against the claims' words — and for
   the last, which half needs the import and which does not, as its docstring says.
6. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), and drafts for the landing (the lines for `scripts/Assumptions.lean` if the definition's
   conditions need declaring; the counts the audit should expect). The report in standing rule 11's form. **Stopping at a
   saved stage with the first two modules proved is a good report** — say exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers and where they live; how you iterate. The planner's routes were
each checked against the pin and eight of them through the build; where one does not go, change it and say so. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/"+JOB+"-radius.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
