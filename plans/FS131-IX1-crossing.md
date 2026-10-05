# FS131-IX1 — the crossing lemma `inter_nonempty_of_interleaved`

*de Bruijn, the implementer (FS131-IX1), 2026-10-05. Brief: `data/fs131/briefs/FS131-IX1-crossing.md` (main tree). Branch `fs131-w5x`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x`, cut from `fs131-w5p` at `01011037`.*

## Theorems this phase proved

All [kernel] (build `35fc52eb`, `build/gate/build/20261005T014018Z-251367.log`), each on exactly `[propext, Classical.choice, Quot.sound]`
(`data/fs131/ix/axioms-stage3.txt`), in `Proofs/HadwigerNelson/Plane/PlaneTopology.lean`, namespace `HadwigerNelson.Plane`:

- `inter_nonempty_of_interleaved` — **the crossing lemma**: two closed preconnected sets in `B̄(u, 1)` joining interleaved circle points meet
- `inter_nonempty_of_interleaved_of_isClosed_left` — the same with only `K` closed (`K'` merely preconnected): a generalization
- `exists_eq_of_interleaved_paths` — the crossing for paths in `B̄(u, 1)`
- children `e_mul_e_neg`, `arg_one_sub_e`, `arg_one_sub_e_of_neg`, `re_pos_of_mem_closedBall`, `ringPt_sub_ringPt_mul_e_neg`,
  `im_sub_eq_arg_sub`, `continuous_discRetract`, `discRetract_mem`, `discRetract_of_mem`, `dist_discRetract_le`, `isPreconnected_thickening`
  (and the definition `discRetract`)

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (the leaf by a Python substring test of the whole docstring and signature). Control: a fresh
string (`IX1-ctl-<nanoseconds>`) reported `MISS`; and the leaf's text with `K ∩ K'` changed to `K ∪ K'` reported `MISS`, while the true text reported
`FOUND`. (IP1's control string `ABSENT-CONTROL-STRING-xyzzy` is no longer a control in its own record: IP1 wrote it there, so `grep` finds it. Noted
so nobody reuses it.)

| quotation in the brief | source | result |
|---|---|---|
| inventory item 293 (truncated at "a binder name is not part") | `plans/FS131-close-inventory.md` (main tree) | verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |
| the leaf `inter_nonempty_of_interleaved`, docstring and signature | `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (branch, `01011037`) | verbatim |
| `noncomputable def ringPt (p : ℂ) (θ : ℝ) : ℂ := p + e θ` | `Proofs/HadwigerNelson/Plane/Basic.lean` l. 46 | verbatim |
| IP1's § 2.3 opening ("`inter_nonempty_of_interleaved` (KP's H) is left for step 5. …") | `plans/FS131-planar-implementation.md` § 2.3 | verbatim |

No mismatch. Read in full: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch it fail;
IP1's record §§ 2.1–2.3 and its "Theorems this phase proved"; KP's plan §§ 3.1–3.3 and every line naming this leaf (§ 4.1's row, § 4.3's model
"two crossing diameters", § 5.1 step 5); inventory item 293 in full.

### 1.2 What I may and may not change

**May:** prove `inter_nonempty_of_interleaved` in `Proofs/HadwigerNelson/Plane/PlaneTopology.lean`, adding children beside it, each with a spec
example; add new modules of my own under `Plane/` or `Topology/` that `PlaneTopology` imports and that import nothing under `Plane/ValidMap/`
(each into `ARCHITECTURE.md`'s module map and `Proofs.lean` in the same commit); my own block in `scripts/Axioms.lean`, headed "FS131-IX1", above the
`=== PURCHASED ===` banner; this record; `tools/fs131_ix_*.py`; `data/fs131/ix/`; `data/fs131/reports/FS131-IX1.md`.

**May not:** change the leaf's statement (not a hypothesis, not the conclusion, not `ringPt`, `e`, `closedBall`) or any other statement in the
file; touch anything under `Plane/ValidMap/` (FS131-IP2's); add an `axiom` or `native_decide`; merge into `fs131-w5p` or `fs131-w5`; run the gate;
touch `main`; edit a file while a build of it runs. A statement that looks false or short of a hypothesis goes to Keryx at once.

### 1.3 The as-given build (`01011037`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree: **OK — all 1753 modules already up to date, nothing built, 11 modules with
warnings, every warning `declaration uses 'sorry'` (98 lines), exit 0** (`build/gate/build/20261005T011928Z-104505.log`; driver log
`data/fs131/ix/build-asgiven.log`).

## Stage 2 — SAVED: Mathlib at the pin, the route, and the first children (iteration-green)

### 2.1 Grep before building (the brief's item 2)

Source grep of `.lake/packages/mathlib/Mathlib` (`grep -rlI`) and `#check` of each candidate (`data/fs131/ix/Grep.lean`, `lake env lean`, every
line either printing a signature or `Unknown identifier/constant`):

| what was looked for | result |
|---|---|
| Jordan curve theorem (`Jordan curve`, `JordanCurve`) | **not found** (no file; `#check @JordanCurve` unknown) |
| Janiszewski's theorem | **not found** (no file; `#check @Janiszewski` unknown) |
| Brouwer fixed point / no-retraction in dimension two (`Brouwer`, `brouwer`, `no_retraction`) | **not found** in topology (the `Brouwer` hits are Heyting algebras in `Order/`; `noRetraction` none; `#check @brouwer_fixed_point` unknown); topology's fixed-point files are Banach contraction (`MetricSpace/Contracting`), Picard–Lindelöf and the projective line only |
| Poincaré–Miranda | **not found** (no file; `#check @poincare_miranda` unknown) |
| winding numbers | **not found** (`windingNumber`, `winding number`: no file; `#check @Complex.windingNumber` unknown) |
| unicoherence, Phragmén–Brouwer | **not found** (the `Phragm` hits are Phragmén–Lindelöf, complex analysis) |
| the fundamental group of the circle, `¬ SimplyConnectedSpace` of any space | **not found** |
| lifts of the argument along paths and homotopies | **found**: `IsCoveringMap.existsUnique_continuousMap_lifts` (simply connected, locally path-connected domain), `IsCoveringMap.liftPath`, `IsCoveringMap.liftHomotopy`, `IsCoveringMap.monodromy`, `Complex.isCoveringMap_exp : IsCoveringMap fun z => ⟨cexp z, ⋯⟩` |
| supporting facts | **found**: `Complex.arg_mul_cos_add_sin_mul_I`, `Complex.arg_exp_mul_I`, `Disjoint.exists_thickenings` (compact and closed disjoint sets have disjoint `δ`-thickenings), `IsOpen.isConnected_iff_isPathConnected`, `IsPathConnected.joinedIn`, `JoinedIn.somePath(_mem)`, `Path.extend` (`extend_range`, `extend_zero`, `extend_one`), `ContinuousOn.clog`, `Complex.mem_slitPlane_iff`, `Complex.exp_eq_exp_iff_exists_int`, `Complex.log_im`, `Metric.isCompact_of_isClosed_isBounded`, `Metric.mem_thickening_iff` |
| a thickening of a preconnected set is preconnected | **not found** (`#check @IsPreconnected.thickening` unknown; no `onnected.*thickening` line) — a child here |

Nothing at the pin gives the crossing or any planar separation theorem directly; the one 2-dimensional input available is the lifting theorem for
`exp` over the simply connected `ℂ`, which IP1's unicoherence already uses.

### 2.2 The route chosen

**Choice — route (c), new: paths first, then continua by thickening.** Neither of IP1's routes as named; it is route (a)'s engine (the lifting
theorem on `ℂ`, which is what no-retraction rests on) applied to a parameter square instead of the disc, so no Poincaré–Miranda construction and
no separation lemma is needed.

1. **The crossing for paths** (`exists_eq_of_interleaved_paths`). Paths `γ : r(s) ⇝ r(t)`, `γ' : r(s') ⇝ r(t')` in `B̄(u, 1)` meet. If not,
   `Ψ(x + iy) = γ(x) − γ'(y)` (paths extended by `Path.extend`, which clamps) is a continuous map `ℂ → ℂ ∖ {0}`, so it lifts through `exp`
   (`Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts`, exactly as in unicoherence) to `F`. On each edge of the unit square one path is
   pinned at a circle point `r(θ)` while the other stays in `B̄(u, 1) ∖ {r(θ)}`, so `±Ψ · e(−θ)` has positive real part there (child
   `re_pos_of_mem_closedBall`) and the change of `Im F` along the edge is a difference of principal arguments (child `im_sub_eq_arg_sub`, by IP1's
   `eq_of_intValued_of_isPreconnected`). Those arguments are `arg (1 − e x) = (x ∓ π)/2` (children `arg_one_sub_e`, `arg_one_sub_e_of_neg`), and the
   four edges sum to `−2π`, while the telescoping sum of `F` at the corners is `0`. (This is Maehara's argument for the Jordan curve theorem's
   crossing lemma, `[Maehara1984]`-style; recalled, not read here — a bibliography check is owed before any citation.)
2. **From continua to paths.** Disjoint `K`, `K'` (compact: closed in the disc) have disjoint `δ`-thickenings (`Disjoint.exists_thickenings`). The
   `δ/2`-thickening of a preconnected set is open and connected (child), hence path-connected; join `r(s)` to `r(t)` there, then push the path into
   `B̄(u, 1)` by the radial retraction `ρ(z) = u + (z − u)/max(1, ‖z − u‖)`, which fixes the disc and moves a point at most its distance to any
   point of the disc, so `ρ ∘ γ` stays within `δ` of `K`. The two retracted paths meet by step 1, and the meeting point lies in both
   `δ`-thickenings — a contradiction.

**Alternatives weighed.** (a) as IP1 named it — no-retraction plus a Poincaré–Miranda construction from disjoint `K`, `K'`: every construction I
could write of the second function needs `K` to separate the disc (a sign of the form "above `K`/below `K`"), which is the crossing again, so (a)
in that form inherits IP1's objection to KP's route. (b) the boundary graph: excluded by the schedule (inventory 293 (c)). KP's Phragmén–Brouwer
route: IP1 § 2.3's objection stands — unicoherence alone cannot give it, since `ℝ³` is unicoherent and the crossing fails there; some
2-dimensional input (here the winding of `1 − e x`) is unavoidable. **Why (c):** it needs no separation theorem at all, every step is
elementary over Mathlib's API, and the 2-dimensional input is a computation of four principal arguments.

### 2.3 The first children, and the re-price

Iteration-green (`lake env lean`, 2–4 s per run) in `data/fs131/ix/Crossing.lean` (imports `PlaneTopology` and
`Mathlib.Topology.MetricSpace.Thickening`): `e_mul_e_neg`, `arg_one_sub_e`, `arg_one_sub_e_of_neg`, `re_pos_of_mem_closedBall`,
`ringPt_sub_ringPt_mul_e_neg`, `im_sub_eq_arg_sub`, and **the path crossing `exists_eq_of_interleaved_paths`** — 159 lines in about 15 minutes
of wall clock from the route to green, the first two children in two iterations each, the path crossing in two. **Re-price**: KP priced the
crossing lemma at "one session, possibly its own job"; from the first two children it is under a tenth of that. What is left is the retraction,
the thickening child and the main theorem, about 80 lines.

## Stage 3 — SAVED: the leaf proved, a generalization, the build and the receipt

### 3.1 Proved (statements byte-identical; no `axiom`, no `native_decide`)

In `Proofs/HadwigerNelson/Plane/PlaneTopology.lean`, a new section "The crossing lemma (FS131-IX1)" above the leaf, every declaration with a
docstring:

| declaration | what it says | lines |
|---|---|---|
| `e_mul_e_neg` | `e θ · e (−θ) = 1` | 2 |
| `arg_one_sub_e` | `arg (1 − e x) = (x − π)/2` for `0 < x < 2π` | 9 |
| `arg_one_sub_e_of_neg` | `arg (1 − e x) = (x + π)/2` for `−2π < x < 0` | 2 |
| `re_pos_of_mem_closedBall` | `z ∈ B̄(u, 1)`, `z ≠ r(θ)` ⟹ `0 < Re ((r(θ) − z) e(−θ))` | 22 |
| `ringPt_sub_ringPt_mul_e_neg` | `(r(a) − r(b)) e(−a) = 1 − e(b − a)` | 2 |
| `im_sub_eq_arg_sub` | `exp ∘ f = κ v` on `[0, 1]`, `Re v > 0` ⟹ `Im (f 1 − f 0) = arg (v 1) − arg (v 0)` | 32 |
| `exists_eq_of_interleaved_paths` | **the crossing for paths**: paths `r(s) ⇝ r(t)`, `r(s') ⇝ r(t')` in `B̄(u, 1)` meet | 75 |
| `discRetract` (def), `continuous_discRetract`, `discRetract_mem`, `discRetract_of_mem`, `dist_discRetract_le` | the radial retraction onto `B̄(u, 1)`: continuous, into the disc, fixing it, `dist (ρ z) k ≤ 2 dist z k` for `k` in the disc | 36 |
| `isPreconnected_thickening` | a thickening of a preconnected set in a real normed space is preconnected | 9 |
| **`inter_nonempty_of_interleaved`** | the leaf | 24 (with its statement) |
| `inter_nonempty_of_interleaved_of_isClosed_left` | **generalization**: the same with `K'` merely preconnected (`hK'` dropped) | 49 |

Spec examples added: `discRetract 0 2 = 1`; `arg (1 − e π) = 0`; and **the model of the leaf's hypotheses** (KP § 4.3's "two crossing diameters":
`[r(0), r(π)]` and `[r(π/2), r(3π/2)]` about `0`, every hypothesis discharged at once), the same model through the generalization. The module
docstring's bullet and the leaf's docstring now describe the proof (the leaf docstring's first two sentences, its statement in words, kept
verbatim; the "Proof planned … Keryx may split it" sentences replaced). `ARCHITECTURE.md`'s `Plane/PlaneTopology` row: "skeleton" → "no `sorry`",
with the route; no import changed (`Mathlib.Topology.MetricSpace.Thickening` is already transitive; `tools/check_architecture.py`: PASS).
`scripts/Axioms.lean`: block "FS-131 wave 5 (job FS131-IX1)" above the PURCHASED banner, 13 records (the leaf itself was already in
FS131-KP's block).

**The generalization, and why it holds.** If `K` is closed and `K'` only preconnected, a disjoint pair is impossible too: `K'` lies in
`V = B̄(u, 1) ∖ K`, and in one path component of it, because a point `z ∈ V` is joined inside `V` to every point of the convex set
`ball z (infDist z K) ∩ B̄(u, 1)` (the unions of these balls over the path component of `r(s')` and over the rest of `V` are two open sets
covering `K'` with no common point of `K'`). The range of a path in `V` from `r(s')` to `r(t')` is then a closed preconnected set disjoint from
`K`, against the leaf. Use: `retArcs_nested` (plan § 3.2's row) passes `closure K` to make the continua closed; with this theorem only one of
the two needs it. Not claimed with neither closed.

### 3.2 Checks, each watched failing

- `tools/fs131_ix_splice.py` (scratch → module): refuses unless the scratch's primed statement is byte-identical to the module's leaf. Control: a
  scratch copy with `(K ∩ K').Nonempty` changed to `(K ∪ K').Nonempty` → `REFUSED: … STATEMENT DIFFERS`, exit 2; the faithful scratch → `OK`, exit 0.
- `tools/fs131_ix_stmtcheck.py` (every statement of `PlaneTopology` at `01011037` byte-identical in the working copy): **12 of 12 identical**,
  14 added, exit 0. Control: a copy with the leaf's `closedBall u 1` changed to `closedBall u 2` in `hKd` → `CHANGED inter_nonempty_of_interleaved`,
  exit 2 (read directly, not through a pipe; a first read through `| grep` reported grep's 0 and was discarded).
- The quotation readback's control (§ 1.1).

### 3.3 The build (`35fc52eb`)

Under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree: **OK — 446 of 446 batches, 6 modules rebuilt (`Plane.PlaneTopology` 3.6 s,
`Plane.ValidMap.MapTopology`, `MapGraph`, `BaseWalk`, `BaseDense`, `Proofs`), 10 modules with warnings, 9 min 4 s, exit 0**
(`build/gate/build/20261005T014018Z-251367.log`; driver log `data/fs131/ix/build-stage3.log`). Last line of the full log: `Build completed
successfully (5399 jobs).` **Warnings other than `declaration uses 'sorry'`: none.** Distinct `sorry` warnings: **97** (98 as given; the one gone
is the leaf's), none in `PlaneTopology`, which drops out of the modules-with-warnings list (11 → 10). The full log's one `error:` line is the
up-to-date probe's (`lake build --no-build`: "target is out-of-date and needs to be rebuilt" for `PlaneTopology`), which is what starts the walk.

An earlier launch of this build (at `585d02ba`) was stopped while still queued for the slot, before `build.sh` started, to add the
generalization first: process group 218735 (the shell) and then 218736 (the slot wrapper, which had survived in its own group) signalled by
PID, both confirmed absent from `ps`, the log's digest unchanged afterwards (`629ab2d1…`). Nothing was built or forfeited but the queue
position.

### 3.4 The axiom receipt (against `35fc52eb`'s oleans)

`lake env lean data/fs131/ix/AxiomsIX1.lean` (imports `PlaneTopology` and `ValidMap/BaseWalk`), output saved to
`data/fs131/ix/axioms-stage3.txt`, exit 0: the leaf, `exists_eq_of_interleaved_paths`, the eleven other children and
`inter_nonempty_of_interleaved_of_isClosed_left` — **each on exactly `[propext, Classical.choice, Quot.sound]`**. The partner,
`ArcMap.BaseCtx.retArcs_not_interleaved` (FS131-IP2's leaf, still `sorry` here), shows **`[propext, sorryAx, Classical.choice, Quot.sound]`**, so
the print reads the built environment and reports `sorryAx` where it is. (The new names would not resolve against the pre-splice oleans.)

### 3.5 Measured cost, and what is left

From the as-given build's end (01:19 UTC) to the leaf iteration-green (01:35) and the generalization (01:40), by commit stamps: about 20
minutes of wall clock, then one 9-minute build. (§ 2.3's "about 15 minutes … from the route to green" was for the path crossing alone; the
commit stamps put it at four minutes after stage 1's commit, the route having been worked out before it.) Every child closed in one or two
iterations; no companion dispatch was needed. **KP's price, "one session, possibly its own job", was about thirty times high.**

**Proved: the crossing lemma, with no `sorry` left in `Plane/PlaneTopology`.** **Left: nothing in this job.** For its consumers (FS131-IP2):
`retArcs_not_interleaved` reads the leaf as given; `inter_nonempty_of_interleaved_of_isClosed_left` saves the closure step for one of the two
continua; `exists_eq_of_interleaved_paths` is there if a consumer has paths. The merge into `fs131-w5p` / `fs131-w5` waits on Keryx's word:
this branch touches `Plane/PlaneTopology.lean`, `scripts/Axioms.lean` (its own block above the PURCHASED banner), `ARCHITECTURE.md`'s
`Plane/PlaneTopology` row, and files under `data/fs131/ix/`, `tools/fs131_ix_*`, `plans/FS131-IX1-crossing.md`; nothing under `Plane/ValidMap/`.

## Drafts for the front page

No gate was run (brief item 4), so there are no gate counts to draft for `CLAUDE.md` § The gate or § Trust ledger. What the next gate over a
merge of this branch should show, for checking: **13 more CLEAN records** in `scripts/axioms.sh` (the FS131-IX1 block), no new purchase, no
new import; **one `sorry` fewer** in the library (the leaf). No ledger row is filed for the crossing lemma (plane-topology infrastructure, no
row in `LEDGER.md` names it), so there is no row to regrade; no Frontier line and no Proof Atlas grade change follow from it alone (it moves
wave 5's `retArcs_nested` path, whose rows land with wave 5).
