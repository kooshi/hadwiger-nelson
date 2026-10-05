# FS131-IX1 — the crossing lemma `inter_nonempty_of_interleaved`

*de Bruijn, the implementer (FS131-IX1), 2026-10-05. Brief: `data/fs131/briefs/FS131-IX1-crossing.md` (main tree). Branch `fs131-w5x`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x`, cut from `fs131-w5p` at `01011037`.*

## Theorems this phase proved

None yet (stage 1).

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
