exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-I6Z2: the continuation of wave 6's centre implementer, on the same branch (fs131-w6z). Its first act joins the third pass's
# three sibling branches into one line; then `vt_w`, `erosion`, `pencil_window`.
import subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs131-w6z"; JOB="FS131-I6Z2"; W=WT+TREE+"/"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
L=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w6l"); K=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w6k")
S="Proofs/HadwigerNelson/Plane/Saturated/"; V=W+S
KP=W+"plans/FS131-w6-kernel-plan.md"; REC=W+"plans/FS131-I6Z-implementation.md"
LEAVES="\n".join(Q(V+"Centre.lean","theorem "+n+" ") for n in ["vt_w","vt","erosion","pencil_window"])+"\n"
DEFS="\n".join([Q(V+"LocalGraph.lean","structure IsInterfaceChart "),Q(V+"LocalGraph.lean","theorem AeColouring.local_graph "),
                Q(WT+"fs131-w6l/"+S+"Parallel.lean","theorem _root_.HadwigerNelson.Plane.HasTwoDiscsAt.mem_essClosure "),
                Q(WT+"fs131-w6l/"+S+"Parallel.lean","theorem IsTangentPt.mem_essClosure ")])+"\n"
PLAN="\n".join(Q(KP,p) for p in ["| Z | `Plane/Saturated/Centre` |","| `vt_w` |","| `erosion` |","| `pencil_window` |"])+"\n"
LEFT="\n".join(Q(REC,p) for p in ["Three leaves, all in `Centre.lean`","**`vt_w` is the keystone**","1. *(proved)* F2","2. `L` is constant","3. Just after `s₂`","4. `L s ∈ ∂_e S_a`",
                                   "5. Each half lies on **one** branch","6. The cell on the far side","7. One region:","**`erosion`**:","**`pencil_window`**:","**A cost both consumers of `vt` share"])+"\n"
b=f'''# Brief {JOB} — wave 6, the centres continued: three sibling branches joined, then the three leaves left of `Centre`, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the continuation of wave 6's centre implementer, on its branch — join the third planning pass's three implementer branches into one line; then prove the three leaves left in `{S}Centre.lean` (`vt_w`, `erosion`, `pencil_window`) from your predecessor's route, without changing a statement, saving after each child
  launch: when a slot frees, in the tree your predecessor (FS131-I6Z) handed back; the other two branches of the pass are idle and whole
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job — **once, early, with the hash of the joined line** (item 1: three more implementers are cut from it); for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs); for a name two of the three branches both declare; or for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`): `{S}Centre.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); new declarations in `{S}LocalGraph.lean` if the chart-restriction lemma belongs beside the structure it restricts (a proved module on this line: nothing existing in it changes); `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` for the join's conflicts and a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner; `plans/{JOB}-implementation.md`, `tools/fs131_i6z2_*.py`, `data/fs131/i6z2/`, `data/fs131/reports/{JOB}.md`; **not** any statement, the other modules of the wave beyond the join's mechanical conflicts (`Parallel`'s two open leaves are a deriver's question, and the fourth pass's three modules are three later implementers'), any landed module, `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 6 is the saturated class: what a measurable colouring's interfaces look like once every colour class is as large as it can
be — segments and unit-curvature arcs off a singular set, and what happens at the singular points. Its third planning pass stated
thirty-four leaves in four modules; three implementers proved twenty-nine of them on three sibling branches. Yours is the branch that
holds `Centre`: four of its seven leaves are proved, and the implementer who proved them stopped at a saved stage with the route to the
other three written out. You continue from that page.

## Why this job

A result counts as held only when its Lean module passes the gate. The three leaves are the wave's statements at a singular point —
`vt_w`, that the layer beyond a tangent interface is one region there, and its two consumers — and they are the part of route M's
regularity step the frontier calls "contact" (`CLAUDE.md` § The aim; `LEDGER.md` rows 140–144). And the wave cannot be finished from
three branches: the fourth planning pass's twenty-eight leaves are three more implementer jobs, each to be cut from a line that holds
all of the third pass's proofs. Your first act makes that line. Kooshi, on pricing this work:

{KOOSHI}
What your predecessor and its two siblings handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`):

{item(579)}
{item(576)}
{item(590)}
{item(566)}
{item(556)}
{item(573)}
{item(596)}
## The statements

No statement changes in this job. Your three leaves, and `vt`, which is proved from `vt_w` (each head's first line; read each whole in
your tree, with its docstring):

{LEAVES}
The chart your predecessor's route turns on, and the tangent-type fact that arrives with the join (the last two are on
`origin/fs131-w6l` at `{L}`, in your tree after item 1):

{DEFS}
The planner's rows for the three (its record, `{KP}`: read §§ 13–15 whole):

{PLAN}
**What is left and its route, in your predecessor's words** (its record, `{REC}`, § 4.3 — read the record whole; these are the first
lines of the paragraphs that are yours):

{LEFT}
## Done means

1. **Your readback, then the join.** Check the quotations against their sources. Merge `origin/fs131-w6l` (at `{L}`), then
   `origin/fs131-w6k` (at `{K}`), into your branch. My trials: yours with either is clean; the two with each other conflict in
   `scripts/Axioms.lean` only — keep every block. Build once; `./scripts/dupnames.sh` on the joined tree (three implementers minted
   helpers side by side: a doubled name is a message to me with both statements, and the later-minted one is renamed). Count the
   `sorry` leaves: by my arithmetic from the three hand-backs and the fourth pass's, 33 — three yours, two in `Parallel`, and
   nineteen, one and eight in `Fragment`, `ReduceI` and `Owed`; a different count is a finding. `#check` your three leaves and read
   the binders the kernel shows (inventory item 556). Commit, push, and **send me the hash with the line "wave 6's third pass is one
   line at this commit"**.
2. **The chart-restriction lemma first** (ruling 579 (a)): an `IsInterfaceChart` restricted to a shorter interval and a smaller
   domain — the cost both consumers of `vt` share, which no plan priced. Your predecessor names why it is not free (the `sides`
   field); prove it once, as a lemma of your own, before either consumer needs it.
3. **`vt_w`**, by the seven children as written (the first is proved); child 3 is the analytic core, and child 7 reads an area
   estimate the library does not hold. **A wider form is yours to make without asking, under a name of your own** — `htan` and
   `hcurv` on a neighbourhood of `[s₁, s₂]` only — **with `vt_w` as stated derived from it**: no statement changes that way, and the
   two consumers may cite whichever serves them. Changing `vt_w`'s own statement is a message to me first.
4. **`erosion`**, then **`pencil_window`**, each through `vt`. Save after each child or leaf (a build, the axioms print with a
   control that fires, a statement check on elaborated signatures against `{BASE}` — your predecessor's instruments are in `tools/`
   on your branch, and its record §§ 2.2 and 4.2 say how it ran them — commit, push). **Before you prove a helper, search the tree for
   its statement's shape, not for a name** (item 596) — after the join the tree holds two siblings' helpers on the same objects.
   Re-price after the restriction lemma and `vt_w`'s second child, and say so.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond item 1's two, run the gate, or touch `main`. `Parallel`'s two open leaves are not yours: they wait
   for a deriver. **After your last green build, the guarded lint** — `lake lint --no-build -- --no-build --trace` under the slot
   with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background process running, and keep what
   your record cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. **This may be more than one job holds**: your predecessor priced
   each leaf at several hundred lines and registered small odds of closing any in the context it had left. The join and the
   restriction lemma alone release other work; `vt_w` proved is a result. Stopping at a saved stage and saying exactly what is left
   is a good report — it is how you came to have a route at all.

## What is yours to decide

The route inside each child, your helpers, where the restriction lemma lives, whether to make the wider `vt_w`, and the order after
item 2. The route is one mind's, read against the statements and not proved: change a step that does not go and say so. A statement is
not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a finding. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave6-centre.md","w").write(b)
print("written",JOB,"base",BASE,"| l",L,"| k",K)
