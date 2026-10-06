exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-w7m"; JOB="FS131-I7M"; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert BASE,"make the worktree first"
C=W+"Proofs/HadwigerNelson/Plane/RouteT/Count.lean"
SR="plans/SEARCH-2026-10-06.md"
b=f'''# Brief {JOB} — wave 7, the six-colour model: the search's certified colouring of a 12 × 12 torus grid stated as count data and evaluated by the kernel; the six-colour theorems' docstrings made true

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: a small implementer job on wave 7's count branch — state the six-colouring a search found today as a Lean inhabitant of the count's structure at six colours, let the kernel evaluate every field, apply to it the five theorems it inhabits, prove that it fails the sixth theorem's extra hypothesis, and correct the docstrings that say no such object is held
  launch: when a slot frees, on a branch cut from the count implementer's hand-back; nobody else works on that file
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job if a field fails in the kernel (at once, with the field and the cell: the certificate's checker and the kernel would then disagree, and that is the finding), if the kernel's cost on the fields is out of reach by every shape you try (with the measurements), or for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w7a` at `{BASE}`): a new module beside the count's (`Proofs/HadwigerNelson/Plane/RouteT/Grid12.lean` or a name you prefer) for the model and what is proved of it, with `Proofs.lean` and `ARCHITECTURE.md` for it — a heavy kernel evaluation stays out of the count's own module; `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` — **docstrings only**, the module's and the six theorems', and `ARCHITECTURE.md`'s stale row for it (the count implementer's drafted text is in its record, Drafts 6); `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner); `plans/{JOB}-implementation.md`, `tools/fs131_i7m_*.py`, `data/fs131/i7m/`, `data/fs131/reports/{JOB}.md`; **not** any statement, definition or proof in the count's module, `Rainbow`, the search's files on `main`, `main`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Today an implementer proved wave 7's *tile count* — a count over the tiles of a map that bounds how many colours it can carry —
on a *combinatorial map*, and reported that its six theorems at six colours had no object satisfying their hypotheses: true, perhaps,
of nothing. The project's owner allowed a search. It came back in a quarter of an hour with a six-colouring of the square grid on a
12 × 12 torus that meets every field of the count's structure — by an exact checker, which is a certificate and not a proof. You put
it through the kernel.

## Why this job

A result counts as held only when the kernel has checked it, and a theorem whose hypotheses nothing is known to satisfy fails this
project's gate (`LEAN.md` § The gate, the inhabitant rule). The owner's word, the count's hand-back, and the search's (read each item
whole in the inventory):

{item(574)}
{item(564)}
{item(580)}
Two things make this more than bookkeeping. The checker is a transcription of the Lean definitions by another lane: the kernel's
evaluation is the first check that the transcription is the definitions. And the model inhabits five of the six theorems, not all six
— it fails the extra hypothesis of the sixth — so what the docstrings should say afterwards is exact, and different for the sixth.

## The statements

No statement, definition or proof of the count's module changes. The structure and the grid, the constructor the two existing models
use, those models, and the six theorems (read each whole, with its docstring):

{Q(C,"structure CountData ")}
{Q(C,"def torusGrid ")}
{Q(C,"def gridCountData ")}
{Q(C,"def grid15Col ")}
{Q(C,"def grid15 ")}
{Q(C,"theorem grid15_card_tac ")}
{Q(C,"theorem room ")}
{Q(C,"theorem slack ")}
{Q(C,"theorem ends_identity ")}
{Q(C,"theorem joint_first ")}
{Q(C,"theorem kill ")}
{Q(C,"theorem joint ")}
The search's result — the model's formula is in its record's § 3.1, its certificate is
`/home/kooshi/source/lean-dir/data/search/2026-10-06/MODEL-torusGrid-12-12.json` (`col_cells[x][y]`, the colour of the cell `(x, y)`),
and its checker is `/home/kooshi/source/lean-dir/tools/search_20261006_check.py`; I checked that the formula reproduces the table at
all 144 cells:

{Q("plans/SEARCH-QUEUE.md","| 8 | 2026-10-06, FS131-I7A |")}
{Q(SR,"### 3.1 The model")}
## Done means

1. **Your readback first**: check the quotations against their sources; read the count's module from the grid section to its end
   (how `gridCountData` discharges each field for the two models, and what each cost the kernel), the count implementer's record on
   them (`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-I7A-implementation.md`, its § 3), the search's record
   (`/home/kooshi/source/lean-dir/{SR}`, §§ 1.3, 3.1, 4.1), and `LEAN.md` § The kernel's cost model. Run the search's checker on the
   certificate yourself. Build the branch once as given (one `sorry`, in `Rainbow`, not yours). Open your record. Commit and push.
2. **Price before you build**: the two existing models have 9 and 16 cells; this one has 144, and nobody has measured it. State the
   colouring (by the formula — a closed term, not a table of 144 literals, unless the kernel prefers the table: measure both on one
   field), then time the kernel on **one** field before you write the rest, and say in your record what it cost and what you chose.
   The search offers a shortening it did not try: the colouring has a four-cell fundamental domain under 36 translations that act
   on the colours by permutations — a lemma that a field's condition is invariant under such a translation reduces 144 cells to 4.
   No `native_decide`. If every shape is out of reach, that is a message to me with the measurements, and a good report.
3. **The model**: a named `CountData (torusGrid 12 12) 6`, every field by the kernel's evaluation, with its record in
   `scripts/Axioms.lean`; and the number the search reports of it, as a theorem — its count of tactic darts, 288.
4. **The five theorems applied to it**, each an `example` or a named corollary in your module: `room`, `slack`, `ends_identity`,
   `joint_first`, and `joint` at the count data it asks for (the search says "`joint`'s count data": read `joint`'s other hypotheses
   and say plainly which the model meets and which are about an assignment it does not supply).
5. **The sixth, stated exactly**: a theorem that this model does **not** satisfy `kill`'s extra hypothesis — its `hK1` fails, the
   search says because every edge is tactic and so `nonTac` is 0 at every vertex. Prove what is true of the model there, in the form
   that makes `kill`'s docstring exact.
6. **The docstrings, and nothing else in that module**: the module's sentence and the theorems' "no inhabitant is held" lines become
   true — five name the model; `kill`'s says that no inhabitant is known, that this model fails `hK1` by the theorem of item 5, and
   that whether any count data satisfy it is an open question for a deriver (the search's record § 4.1 has one mind's reading that
   none does on a square grid: cite it as that). Shown by script: the diff of that module touches no line outside a docstring, and
   every declaration's elaborated signature is what it was (the count implementer's tool does this, with controls:
   `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/tools/fs131_i7a_stmt_check.py`).
7. A build after each of items 3–6 or group, the axioms print with a control that fires, `./scripts/dupnames.sh`,
   `tools/check_architecture.py` exit 0; **after your last green build, the guarded lint** — `lake lint --no-build -- --no-build
   --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). No new `axiom`, no
   `native_decide`. You do not run the gate or touch `main`. Leave no background process running, and keep what your record cites
   under your `data/` folder.
8. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its sentence; the kernel's
   measured times; the report in standing rule 11's form, with what the kernel's agreement or disagreement with the search's checker
   says about that checker. Stopping at a saved stage with the model stated and some fields evaluated is a good report.

## What is yours to decide

The shape of the colouring's term, how each field is put to the kernel, whether the symmetry is worth its lemma, the module's name
and layout, and whether one of the search's four 48-cell models on a sheared torus is the better object (they are raw permutations,
not a `torusGrid`, so they cost a new map; the search's record § 2.2 has them). The model is not yours to alter: if the kernel refuses
a field, do not repair the colouring — report the field and the cell. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave7-model.md","w").write(b)
print("written",JOB,"base",BASE)
