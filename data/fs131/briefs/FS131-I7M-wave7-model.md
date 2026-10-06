# Brief FS131-I7M — wave 7, the six-colour model: the search's certified colouring of a 12 × 12 torus grid stated as count data and evaluated by the kernel; the six-colour theorems' docstrings made true

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I7M
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: a small implementer job on wave 7's count branch — state the six-colouring a search found today as a Lean inhabitant of the count's structure at six colours, let the kernel evaluate every field, apply to it the five theorems it inhabits, prove that it fails the sixth theorem's extra hypothesis, and correct the docstrings that say no such object is held
  launch: when a slot frees, on a branch cut from the count implementer's hand-back; nobody else works on that file
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job if a field fails in the kernel (at once, with the field and the cell: the certificate's checker and the kernel would then disagree, and that is the finding), if the kernel's cost on the fields is out of reach by every shape you try (with the measurements), or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-I7M.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I7M-implementation.md` (new, on branch `fs131-w7m`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m` (branch `fs131-w7m`, cut from `fs131-w7a` at `5777e8e7`): a new module beside the count's (`Proofs/HadwigerNelson/Plane/RouteT/Grid12.lean` or a name you prefer) for the model and what is proved of it, with `Proofs.lean` and `ARCHITECTURE.md` for it — a heavy kernel evaluation stays out of the count's own module; `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` — **docstrings only**, the module's and the six theorems', and `ARCHITECTURE.md`'s stale row for it (the count implementer's drafted text is in its record, Drafts 6); `scripts/Axioms.lean` (a block of your own, headed "FS131-I7M", above the `=== PURCHASED ===` banner); `plans/FS131-I7M-implementation.md`, `tools/fs131_i7m_*.py`, `data/fs131/i7m/`, `data/fs131/reports/FS131-I7M.md`; **not** any statement, definition or proof in the count's module, `Rainbow`, the search's files on `main`, `main`
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

> 574. **Kooshi's word on the queued search, a conditional, 2026-10-06, verbatim: "If hardware can spare the resources, and if the search actually has a chance of returning, you can launch the searcher... otherwise we file its question as an open one for a deriver." And: "make sure to keep the handoff updated with anything learned as well as current state of the milestone. […]"** (source: his message of 2026-10-06, about 20:30 UTC, after my interim report; the search is `plans/SEARCH-QUEUE.md` line 8, item 564 (e)).
> — source: plans/FS131-close-inventory.md

> 564. **FS131-I7A done at its Stage 3: route T's count is proved — nineteen leaves and two models; four of the nineteen were false as the skeleton stated them, repaired as ruled; `anchor` not started** (implementer, Opus; harness 451k and 60 minutes by the task notice; record `fs131-w7a`'s `plans/FS131-I7A-implementation.md`; report `data/fs131/reports/FS131-I7A.md`; four commits, tip `5777e8e7`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 580. **The day's search done (SEARCH-2026-10-06): queue line 8 answered yes at [cert] — a six-colour count exists on a combinatorial map of Euler characteristic 0; it inhabits five of the six theorems, not `kill`** (the Searcher; harness 265k and 25 minutes by the task notice; record `plans/SEARCH-2026-10-06.md`; report `data/search/2026-10-06/report.md`; commits `a88a6741`, `068587cc`, `7dc8b162`, `93840f55` on `main`, under `plans/`, `data/search/` and `tools/search_20261006_*.py`).
> — source: plans/FS131-close-inventory.md

Two things make this more than bookkeeping. The checker is a transcription of the Lean definitions by another lane: the kernel's
evaluation is the first check that the transcription is the definitions. And the model inhabits five of the six theorems, not all six
— it fails the extra hypothesis of the sixth — so what the docstrings should say afterwards is exact, and different for the sixth.

## The statements

No statement, definition or proof of the count's module changes. The structure and the grid, the constructor the two existing models
use, those models, and the six theorems (read each whole, with its docstring):

> structure CountData {D V F : Type*} [Fintype D] [Fintype V] [Fintype F] [DecidableEq V] [DecidableEq F]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> def torusGrid : CMap ((ZMod n × ZMod m) × Fin 4) (ZMod n × ZMod m) (ZMod n × ZMod m) where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> def gridCountData (k : ℕ) (col : ZMod n × ZMod m → Fin k)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> def grid15Col (f : ZMod 4 × ZMod 4) : Fin 15 :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> def grid15 : CountData (torusGrid 4 4) 15 :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem grid15_card_tac : #grid15.tac = 4 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem room (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem slack (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem ends_identity [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) : ∑ p, C.charge p + 2 * C.unused = 0 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem joint_first [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem kill [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) (hK1 : ∀ p, M.deg p = 4 → 2 ≤ C.nonTac p) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem joint (C : CountData M 6) (hχ : M.chi2 = 0) (w : D → V → ℚ) (u : ℚ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

The search's result — the model's formula is in its record's § 3.1, its certificate is
`/home/kooshi/source/lean-dir/data/search/2026-10-06/MODEL-torusGrid-12-12.json` (`col_cells[x][y]`, the colour of the cell `(x, y)`),
and its checker is `/home/kooshi/source/lean-dir/tools/search_20261006_check.py`; I checked that the formula reproduces the table at
all 144 cells:

> | 8 | 2026-10-06, FS131-I7A | whether the six-colour theorems of route T's count (`CountData.room`, `slack`, `ends_identity`, `joint_first`, `kill`, `joint`) have a model on combinatorial maps or are empty there: "does a `CountData M 6` with `M.chi2 = 0` exist?" Excluded by hand, one mind, not in Lean: linear colourings `ax + by mod 6` and row-shifted colourings `x + s(y) mod 6` of the square grid | 6-colourings of small torus grids (and other maps with `V₄ ≥ 3V₆`) meeting `CountData`'s fields, each a local check | `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/data/fs131/reports/FS131-I7A.md` (search request); its record § 3.3; inventory item 564 | **answered yes**, 2026-10-06: SEARCH-1006-GRID12 [cert] — a six-colouring of `torusGrid 12 12` meets every field of `CountData` (`data/search/2026-10-06/MODEL-torusGrid-12-12.json`, checked by `tools/search_20261006_check.py`; a closed formula in `plans/SEARCH-2026-10-06.md` § 3.1); it inhabits `room`, `slack`, `ends_identity`, `joint_first` and `joint`'s count data, **not `kill`'s K1** (every edge of it is tactic). No other `torusGrid n m` with `3 ≤ n ≤ m ≤ 13` has one, and no quotient of the square grid by a sublattice of index below 48 (2,736 refutations, each verified by cake_lpr); free-boundary windows of the Cairo, prismatic pentagonal, deltoidal trihexagonal, snub square and elongated triangular tilings are refuted. Open for a deriver: whether `kill` is empty (§ 4). |
> — source: plans/SEARCH-QUEUE.md

> ### 3.1 The model
> — source: plans/SEARCH-2026-10-06.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the count's module from the grid section to its end
   (how `gridCountData` discharges each field for the two models, and what each cost the kernel), the count implementer's record on
   them (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/plans/FS131-I7A-implementation.md`, its § 3), the search's record
   (`/home/kooshi/source/lean-dir/plans/SEARCH-2026-10-06.md`, §§ 1.3, 3.1, 4.1), and `LEAN.md` § The kernel's cost model. Run the search's checker on the
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
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py`).
7. A build after each of items 3–6 or group, the axioms print with a control that fires, `./scripts/dupnames.sh`,
   `tools/check_architecture.py` exit 0; **after your last green build, the guarded lint** — `lake lint --no-build -- --no-build
   --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). No new `axiom`, no
   `native_decide`. You do not run the gate or touch `main`. Leave no background process running, and keep what your record cites
   under your `data/` folder.
8. **Your record**, stages headed "Stage n — SAVED (FS131-I7M)", "Theorems this phase proved", each read against its sentence; the kernel's
   measured times; the report in standing rule 11's form, with what the kernel's agreement or disagreement with the search's checker
   says about that checker. Stopping at a saved stage with the model stated and some fields evaluated is a good report.

## What is yours to decide

The shape of the colouring's term, how each field is put to the kernel, whether the symmetry is worth its lemma, the module's name
and layout, and whether one of the search's four 48-cell models on a sheared torus is the better object (they are raw permutations,
not a `torusGrid`, so they cost a new map; the search's record § 2.2 has them). The model is not yours to alter: if the kernel refuses
a field, do not repair the colouring — report the field and the cell. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
