# FS131-E6 — SHAVE's residual case (F6): a lone horn shaveable only at `σ = ±1`

*Job FS131-E6, Ephodos (Opus 5.5), 2026-10-05. Brief `data/fs131/briefs/FS131-E6-shave.md` with `plans/STANDING-RULES.md`; claim list
`data/fs131/claims-E6.md`. Working files `data/fs131/e6/`; tools `tools/fs131_e6_*.py`. Nothing in this milestone is fenced (inventory,
§ Rulings in force, ruling 1). Lean sources read on `main` (`a9342834`) and on `fs131-w5c` (`d3d38d3a`, IL1's tip at reading time).*

## Theorems this phase proved

- **E6-OCCURS** — a valid clean plane map (twelve colours, no unit arc) whose only site is a lone horn shaveable only at `σ = 1`, `κ₁ = 0 < 1 < 2 = κ₂` — [hand, one mind; tools exact] — § 3.1–3.3, `e6-occurs`
- **E6-NODROP** — at that vertex no local modification creating no unit arc and adding no colour lowers the degree, so `exists_vertexStep`'s degree clause is false there — [derived, one mind; tools exact] — § 3.4, `e6-nodrop`
- **E6-CONE** — a horn whose colour's allowed cone has empty interior has bounds in `[−1, 1]`; so every F6 horn has a non-degenerate allowed cone — [hand, one mind; `horn_bounds_of_noMerge`'s proof with its cone hypothesis made direct] — § 4.1, `e6-cone`
- **E6-OPEN** — at a horn whose colour's allowed cone has non-empty interior, recolouring a thin wedge beside it with its colour is valid, creates no unit arc, adds no colour, does not raise the degree, removes a horn, keeps far allowed cones — [hand, one mind; the clearness step is `clear_near_end`, kernel] — § 4.2, `e6-open`
- **E6-ROUTE** — the vertex step repaired: MERGE, else RAY, else SHAVE when the cone is degenerate, else OPEN; each lowers degree plus horns — [derived, one mind] — § 4.3, `e6-route`

## Stage 1 — SAVED: the readback, the question restated, the prediction registered

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| F6's opening clause "**F6 — a residual case of SHAVE (a question for the deriver; statement risk for `exists_terminalMap`).** `ShaveAvailable v` (wave 4's" | `.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md` l. 153 | verbatim |
| item 373's opening "**FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s" | `plans/FS131-close-inventory.md` l. 3269 | verbatim |
| item 374's opening "**Rulings on KL1's held items, and its slot.** (a) **The moves' new lemmas** are proved on wave 5's branch after it merges `main` (ruling 372 (a)): in a" | same file l. 3291 | verbatim |
| item 371's opening "**FS131-KL1 (the limit planner), by message: N4-TERM's count does not descend over `main`'s SHAVE as built; a clean step is owed; `exists_red` has a shorter" | same file l. 3239 | verbatim |
| the N4-SHAVE row | `plans/FS110-N-proof.md` l. 718 | verbatim |
| the N4-TERM row | `plans/FS110-N-proof.md` l. 723 | verbatim |
| the question Q and its *not claimed* line | `data/fs131/claims-E6.md` § The question | verbatim |
| the claim list's `ShaveAvailable` | `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 150–156 (`main`) | verbatim |
| the claim list's `exists_shave` | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1490–1502 (`main`) | verbatim |
| the claim list's `IsModification` | `fs131-w5c`'s `Plane/ValidMap/Chain.lean` l. 80–86 | verbatim |
| the claim list's `exists_terminal` | `fs131-w5c`'s `Plane/ValidMap/Terminal.lean` l. 3703–3720 | verbatim |

**One mismatch, a finding about the brief:** Done-means item 1 says "`horn_bounds_of_noMerge` on `main`". It is not on `main`
(`grep -rn horn_bounds Proofs/` on `main`: no hit; `main` has no `Plane/ValidMap/FlankUA.lean`). It is on `fs131-w5c` (and `fs131-w5`),
`Plane/ValidMap/FlankUA.lean` l. 722–740. I read it there. Its proof uses `2 ≤ m` only to turn `¬ MergeAvailable v` into
`interior (F.allowedCone v c) = ∅`; the bound itself comes from `woodallCone` (`main`, `Plane/ValidMap/Cone.lean` l. 1427–1435), which
needs no sector count. This matters below (§ 2.2).

### 1.2 Read for this job

`plans/FS110-N-proof.md` § Continuation — FS110-N4 (all of it: N4-SHADOW, N4-FLANK, N4-SHAVE, N4-RAY, N4-STUCK, N4-PROP, N4-FIN, N4-TERM,
the verdict § 2.8 with its "partial remedy, sketch"); `plans/FS112-derivation.md` header and § 1 entries FS112-WALK through FS112-N2-TERM;
`plans/FS112-N-proof.md` § 1.3–1.4 (the walk table; row 7 is N4-SHAVE with FLANK and RAY); KL1's plan
(`fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`) §§ 2.1–2.4, 3.1, 3.3, 3.4; inventory items 371–377; `Basic.lean` l. 1–240 (frames,
`tanHeight`, `hornSet`, `IsClear`, sectors, `IsHorn`, flanks, contacts, `allowedCone`, the moves' preconditions, `Terminal`, `IsStuck`);
`Cone.lean`'s `contact_inType_or_outType`, `coneAt_subset_allowedCone`, `woodallCone`; `Contact.lean`'s `exists_rayMerge`, `exists_merge`;
`fs131-w5c`'s `Chain.lean` l. 1–90, `Procedure.lean` (whole), `Limit.lean`'s `LocalStep`, `IsClean`, `IsSite`, `Terminal.lean`'s
consumers of `Terminal` (every use, by grep: § 3); and, found on the way and bearing directly, `plans/FS110-derivation.md`'s FS110-N4-TERM,
FS110-NB4-CS, FS110-A6-C2 entries and `plans/FS110-NB4-verification.md` §§ 2.3, 2.8, 2.9 and § 4.1 (divergence D3: "count `Φ + #horns`
… then SHAVE on single horns and the opening remedy both join the moves").

### 1.3 The question, restated in my words (the claim list's statement governs)

Frame at `v`: `a = e α`, `n = e(α + π/2)`, `N = v + n`, `S′ = v − n`. A **lone horn** is a horn `IsHorn v α κ₁ κ₂ c` whose colour has one
sector at `v` (`HasSectors v c 1`). For it, `horn_bounds_of_noMerge` is silent, so `κ₁ < −1` or `κ₂ > 1` is possible. `ShaveAvailable v`
through it asks for one `σ ∈ [κ₁, κ₂]` with the horn's points strictly above the tangent circle `Σ_σ` clear for the upper flank `g` and the
rest clear for the lower flank `h`. The residual case F6: the only such `σ` is `1` (or `−1`) and `κ₁ < σ < κ₂`. Then `Σ_σ` is `ω(N)` (or
`ω(S′)`, `tanAbove_one_iff`, `tanAbove_neg_one_iff`), its trace inside the horn is a unit arc not in `F`'s `Γ`, and every shave creates it,
which `IsModification` (`RingArcsWithin`) forbids. Three outcomes are named: F6 cannot occur where the procedure meets it; F6 occurs (a
configuration exhibited exactly); or F6 occurs and the route does something else there.

### 1.4 Registered before the written derivation (G21; scored at the end of this job)

| id | prediction | probability | what it decides |
|---|---|---|---|
| E6-P1 | F6 occurs in a valid map: a valid plane map at some `k ≥ 7` (no valid six-map of the plane is known, FS-114) carries a lone horn with `ShaveAvailable` only at `σ = 1`, `κ₁ < 1 < κ₂`, checked exactly | 0.85 | whether the answer is "impossible" or "repair" |
| E6-P2 | F6 forces `interior (allowedCone v c) ≠ ∅` (the contrapositive of `woodallCone`) | 0.97 | whether the repair can be a move that needs a non-degenerate allowed cone |
| E6-P3 | FS110 § 2.8's sketched wedge-opening ("OPEN": recolour a thin wedge beside the horn, on the interior side of `D_c(v)`, with `c`) is valid at every lone horn with `int D_c(v) ≠ ∅`, with unit arcs allowed: no unit arc created, no colour added at `v`, degree not raised, one horn fewer | 0.85 | the repair's move |
| E6-P4 | at some F6 instance no local modification at `v` lowers `v`'s degree, so `exists_vertexStep`'s clause "`∃ m' < m, F'.HasDegree v m'`" is false there | 0.75 | whether `exists_vertexStep`'s statement must change |
| E6-P5 | `exists_terminal`'s statement, `exists_terminalMap`'s and `IsTerminalMap` need no change | 0.85 | whether a backlog statement must be re-read |

Both directions are named reachable: P1 failing means a derivation that F6 cannot occur (the answer the brief lists first); P5 failing means
a statement repair.

The question as an open entry (the loop's opening form; replaced by derived entries from stage 2 on):

derivation: e6-question
  statement: a valid map can have a vertex v with ShaveAvailable v through a lone horn whose only admissible split is σ = 1 (or −1) with κ₁ < σ < κ₂
  argument: § 1.3 The question, restated in my words (the claim list's statement governs)
  verdict: stalls at: stage 1 — nothing derived yet; the configuration and the route are stage 2's

## Stage 1 — SAVED

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh), run on the claim

### 2.1 The stall, read

No argument has been tried yet; the stall is KL1's: "every shave there adds an arc of `ω(v ± n)`". Its shape is *a known theorem that almost
applies* — `exists_shave` and `horn_bounds_of_noMerge` cover every horn but this one, and the hypothesis that fails (`−1 ≤ κ₁`, `κ₂ ≤ 1`) is
consumed only through `woodallCone`, which reads `int D_c(v) = ∅`, not the sector count (§ 1.1).

### 2.2 For a stranger (a geometer who works on partitions of the plane avoiding one distance)

*The plane is cut by finitely many circular arcs and segments near every point into open regions, each coloured, so that no two interior points
of one colour are at distance exactly `1`. For a colour `x` let `X` be its set and `X ⊕ S¹ = {z : dist(z, X ∩ ·) = 1 somewhere}` its unit
shadow: a point may take colour `x` exactly when it lies outside `X ⊕ S¹`. At a boundary point `v` one region of colour `c` is a cusp between
two circles tangent at `v` to the direction `a`, of curvatures `κ₁ < κ₂`; directly above it is colour `g`, below it colour `h`. To remove
the cusp from `v` by recolouring it with `g` and `h` one needs a curve through `v`, tangent to `a`, with the part of the cusp above it
outside `G ⊕ S¹` and the part below outside `H ⊕ S¹`. Near `v` both shadows are bounded by curves tangent to `a` (the unit offsets of the
`g`- and `h`-regions touching the unit circle `ω(v)` at its poles `v ± n`). Can the two offsets coincide with the unit circle `ω(v + n)`
inside the cusp, so that the only admissible curve is a unit circle — which is forbidden as a new boundary? And if so, what else removes
the cusp?*

Words the stranger stops at: "horn" (struck: a cusp sector), "flank" (struck: the regions adjacent along the cusp's arcs), "SHAVE",
"modification", "terminal" (struck: the procedure's vocabulary), "allowed cone `D_c(v)`" (kept: it is a determiner, the cone of directions
at `v` not in the unit shadows of the `c`-regions touching `ω(v)` — the stranger's field calls a region of this kind a contact of `X` with
the circle, and the cone the intersection of the contacts' half-planes).

**This is a coincidence of two unit offsets at the pole of `ω(v)`.** The offset of a circle of radius `R` about a point on the normal line
is the concentric circle of radius `R − 1` (FS110-N4-SHADOW, re-read: `f̃(υ) = υ/(1 − υ)` going up, `f(λ) = λ/(1 + λ)` going down); the offset of
a *corner* (a region at `N` meeting `N` in a positive angle away from `±a`) is `ω(N)` itself — the limit `f(∞) = 1`. So the `h`-shadow from
`N` is bounded by a circle of curvature at most `1`, reaching `1` exactly for a corner at `N`; the `g`-shadow from `S′` is bounded by a circle
of curvature `f̃(υ)`, which is `1` exactly at `υ = 1/2`, a region at `S′` bounded by the circle of radius `2` about `N`.

### 2.3 The features, sorted (receipts: the argument step that consumes each, or the control that varies it; stage 3 plants the controls)

| feature | sort | receipt |
|---|---|---|
| (D1) an `h`-region at `N`, out-type, meeting `N` away from the `+a` tangent (a corner) | **determines** | its shadow near `v` on the `+a` side is exactly `B(N, 1)` (§ 3.2, computed); a tangent `h`-region at `N` of curvature `λ > −1` casts `f(λ) < 1`, puts `h`-shadow below `ω(N)` and kills `σ = 1`; no `h` at `N` leaves `σ` free up to `κ₂` — control `e6-sigma-up` |
| (D2) a `g`-region at `S′`, out-type, bounded on the `+a` side by the circle of radius `2` about `N` (curvature `1/2` at `S′`) | **determines** | its shadow near `v` on the `+a` side is exactly the outside of `B̄(N, 1)`; curvature `υ < 1/2` at `S′` gives `f̃(υ) < 1` and frees `σ ∈ [f̃(υ), 1)` — control `e6-sigma-down`. (An in-type `g`-region at `N`, FS112-FLANK's Siamese case, is a second source of the same shadow; not used in the model) |
| (D3) the horn crosses `ω(N)`: `κ₁ < 1 < κ₂` | **determines** | F6's own clause; with `κ₂ ≤ 1` the admissible `σ = 1` is the horn's own arc (FS112-WALK row 7) |
| (D4) the horn's colour has one sector at `v` | **splits**: consumed only as "`int D_c(v) ≠ ∅`" | the bound `κ₂ ≤ 1` comes from `woodallCone`, which needs `int D_c(v) = ∅` and nothing else (§ 1.1); a colour of two sectors with `int D_c(v) ≠ ∅` is MERGE's (priority, F7). So the determiner is the cone, not the count |
| the curvatures `κ₁`, `κ₂` themselves | accompanies | any `κ₁ < 1 < κ₂` with (D1)–(D2): the admissible set is `{1}` (§ 3.2's computation holds for every such pair) |
| the number of colours `k` | accompanies | the model (§ 3.1) uses `c, g, h` and a background of fresh colours; nothing in § 3.2 reads `k` |
| Condition 5 | accompanies | the model has no arc of radius `1` (`e6-no-unit-arc`): F6 occurs under Condition 5 too |
| the rest of the map (other vertices, `c`'s other regions) | accompanies the occurrence; **determines the repair's degree count** | § 3.4: with an in-type `c`-contact constraining `D_c(v)` to an open half-plane about `e(π/4)`, no colour can be removed from `v` locally |

### 2.4 Homes, each with its dictionary and its test

**H1 — FS110's shadow calculus at its boundary values** (own home). Dictionary: `h`-shadow boundary ↔ `f(λ)` of the `h`-region's arc at `N`,
with the corner as `λ = ∞`; `g`-shadow boundary ↔ `f̃(υ)` at `S′`; the admissible splits ↔ `[σ_g, σ_h]` (NB4 § 2.3). *Old proofs apply at once:*
yes — N4-FLANK's list read for a horn whose arcs are not in `(−1, 1)`. *Exceptions vanish:* the residual case is the endpoint `σ_g = σ_h = 1`,
no clause. *Predicts a neighbour:* `σ_h ≤ 1` for every `h`-region at `N` and `σ_g ≥ −1` for every `g`-region at `S′` (the maps `f`, `f̃` never
cross `±1` the other way), so the upper residual case needs `h` at `N` cornered and the lower one `g` at `S′` cornered — checked in the model
(§ 3.2). *Both ways:* yes. **Adopted for the occurrence.** It also shows a precision owed: NB4 § 2.3's "`[σ_g, σ_h] ⊂ (−1, 1)`", carried by
NB4's D3 to single horns ("the §2.3 criterion is unchanged"), holds only for horns with bounds in `(−1, 1)`.

**H2 — FS-112's unit-arc calculus: the interface SHAVE would create is an (R2) arc.** Dictionary: the new arc `ω(N) ∩ horn` ↔ a unit arc
centred at `N` with inner colour `g` (inside `ω(N)`) and outer colour `h`; (D1) ↔ "the centre carries the outer colour" (out-kind); (D2) ↔ "the
inner colour's class holds the whole radius-2 arc `R₂(ᾱ)`" (the `g`-region along the circle of radius `2` about `N` at `S′`). So when
`g ∉ P_cl(N)` the forced interface is exactly an **(R2) arc** — the kind FS112-N2-BENDS says no bend removes (toward: the outer colour is at
`N`; away: R2 along the arc) and FS112-N2-FLANK-Q says every horn bound `±1` sits on. *Predicts:* after such a shave, `g`'s lower bound at
`v` is exactly `1` on an (R2) arc — the structure `exists_terminal`'s clause 3 allows. *Consequence for the route:* the shave's product is a
terminal-shaped arc, but `IsModification` forbids creating any unit arc, so this home **kills the repair "shave and keep the arc"** under the
statement as fixed; it does not decide occurrence. Adopted as the reading of why F6 is not an accident.

**H3 — Woodall's step 3 / FS110-W-MERGE, with one sector** (the repair's home; prior art in print: `[SokolovVoronov2025]` Prop. 7, the
polygonal form — recolour the triangle between two boundary segments of one colour, held PDF, read 2026-10-05 l. 317–333 of my extraction).
Dictionary: W-MERGE's gap between two `c`-sectors inside `int D_c(v)` ↔ a wedge between the horn and a chosen ray inside `int D_c(v)`;
N3-CLEAR (directions interior to `D_c(v)` are clear near `v`) ↔ the same; N3-UP (an out-type region at a pole shadows a monotone set) ↔
the second-order sliver beside the horn. *Old proofs apply:* all but one step. **The changed step, named:** W-MERGE's gap is bounded on both
sides by `c`, so its clearness near the horn's side is inherited from the other `c`-sector; a wedge beside a lone horn has a free side, and
near the horn's own direction `α` the wedge is clear only if the contacts tight at `α` — the poles `N`, `S′` — shadow monotone sets that
cannot reach the wedge without reaching the horn. FS110 § 2.8 sketched this ("a single `c`-horn … opens into a positive-angle sector by
recolouring a thin wedge on the interior side (N3-CLEAR, N3-UP)") for `D_c(v)` a half-plane; FS110-NB4-CS (one mind) used it as a sketch.
*Predicts a neighbour:* the opening never lowers the degree when no sector lies inside the wedge — so a route counting degree alone cannot
use it (§ 3.4). **Adopted for the repair.**

**H4 — saturated colourings and contact (G84, G85).** Dictionary: a horn tip carved by unit circles ↔ G84's contact mechanism. Test: G84 is
about maximal or saturated colourings, and SHAVE's tip is neither; nothing transfers that H1–H3 do not already give. **Killed** (it explains,
predicts nothing here).

### 2.5 The class each statement belongs to

- **Occurrence** (E6-OCCURS): every `k ≥ 3` plus a background, Condition 5 or not — the determiners are (D1)–(D3) with the cone free.
- **The repair** (E6-OPEN): every horn whose colour's allowed cone has non-empty interior, at a vertex of a valid map covering `B̄(v, 1)` —
  the lone horn and the F6 case are instances, not hypotheses; F6 itself needs no clause of its own once E6-CONE (F6 ⟹ `int D_c(v) ≠ ∅`) is
  derived.
- **The degree count** (E6-NODROP): one instance suffices to refute `exists_vertexStep`'s degree clause; the class statement is "OPEN lowers
  the horn count and not the degree", the measure owed is degree plus horns (NB4's D3: "count `Φ + #horns`").

Recognition's verdict: the description under which the answer is forced is *the coincidence of two unit offsets at a pole, and its repair is
a one-sector Woodall merge*. Dispatched to stage 3 (the derivations and the exact model). Not dispatched to `ephodos-invention`: no
collision of held descriptions; H2's (R2) reading and `IsModification` do not contradict, they exclude one repair.

## Stage 2 — SAVED

## Stage 3 — SAVED: F6 occurs — a valid plane map, exact; and at it no local step lowers the degree

### 3.1 The model

Coordinates: `v = 0`, `α = 0` (`a = (1, 0)`, `n = (0, 1)`), `N = (0, 1)`, `S′ = (0, −1)`; `ρ = ℓ = ℓ′ = r_c = 1/10`; `w = (3/5, 4/5)`.
Colours: `c, g, h` and nine background colours. Tiles:

| tile | colour | set | role |
|---|---|---|---|
| `H` | `c` | `{|z| < ρ, x > 0, y > 0, x² + y² − y > 0}` | the horn: `hornSet 0 0 0 2 r = H ∩ B(0, r)` for `r < ρ` (lower arc the axis, curvature `0`; upper arc `C₂: x² + (y − 1/2)² = 1/4`, curvature `2`) |
| `G₀` | `g` | `{|z| < ρ, y > 0} ∖ cl H` | the upper flank (connected: the parts `x < 0` and inside `C₂` overlap) |
| `H₀` | `h` | `{|z| < ρ, y < 0}` | the lower flank |
| `T` | `h` | `{N + s e(φ) : 0 < s < ℓ, π/3 < φ < 2π/3}` | an out-type corner of `h` at `N` |
| `T′` | `g` | `{|z − N| > 2, x > 0, |z − S′| < ℓ′}` | an out-type `g`-region at `S′`, bounded on the `+a` side by the circle of radius `2` about `N` (upward curvature `1/2` at `S′`) |
| `T_c` | `c` | `B((1 − r_c) w, r_c)` | an in-type `c`-region touching `ω(0)` at `w` only (internally tangent) |
| background | 9 colours | the squares of side `3/5` centred at `(3i/5, 3j/5)`, colour `(i mod 3, j mod 3)`, minus the closures of the features | `B(0, ρ)` lies in square `(0,0)`, `T` in `(0,2)`, `T′` in `(0,−2)`, `T_c` in `(1,1)` (V6) |

Arcs: the grid lines; the rim `∂B(0, ρ)`; the axis from `−ρ` to `ρ`; `C₂`'s arc from `0` to the rim (`x > 0`); `T`'s two rays and its arc of radius `ℓ`;
`T′`'s arc of the circle of radius `2` about `N`, its ray down from `S′` and its arc of radius `ℓ′`; `T_c`'s circle. **No arc of radius 1**
(`e6-arcs`), so Condition 5 holds and every unit arc is (Q) or (R2) vacuously; every arc separates two colours (clean).

### 3.2 Validity (no two interior points of one colour at distance exactly 1), by colour

- **Background.** One square has diameter `(3/5)√2 < 1`; two squares of one colour differ by a multiple of `9/5` in a coordinate, so their gap is
  at least `2·(3/5) = 6/5 > 1`. Cutting out features keeps this (V5).
- **`c`: `H` and `T_c`.** Each has diameter `< 1`. For `z ∈ H` (`x, y > 0`, `|z| < ρ`) and `p ∈ T_c`: `p_x, p_y ≥ m := (1 − r_c)·3/5 − r_c = 11/25`,
  so `z·p ≥ m(x + y) ≥ m|z| > |z|²/2` (as `2m > ρ`), and `|z − p|² = |p|² − 2z·p + |z|² < |p|² < 1` (V1).
- **`g`: `G₀` and `T′`.** For `q ∈ G₀` with `x > 0`: `q` is inside `C₂`, and `x² + (y − 1)² = (x² + y² − y) + 1 − y < 1`, so `|q − N| < 1` and
  `|q − p| ≥ |p − N| − |q − N| > 2 − 1` for `p ∈ T′`. For `q ∈ G₀` with `x ≤ 0` (`y > 0`) and `p ∈ T′` (`p_x > 0`, `p_y < 1 − √(4 − p_x²)`):
  `|q − p|² > p_x² + (√(4 − p_x²) − 1)² = 5 − 2√(4 − p_x²) > 1` (V2, V3).
- **`h`: `H₀` and `T`.** For `q ∈ H₀`, `p = N + s e(φ)`: `e(φ)·(q − N) ≤ ρ/2 − (√3/2)(1 − ρ) < 0`, so `|q − p|² = |q − N|² + s² − 2s e(φ)·(q − N) >
  |q − N|² = q_x² + (1 − q_y)² > 1` (V4).

### 3.3 F6 at `v = 0`

`IsHorn 0 0 0 2 c` (H's set is `hornSet` exactly for `r < ρ`), `IsFlankAbove 0 0 2 g` (inside `C₂` near `0` is `G₀`), `IsFlankBelow 0 0 0 h`, and
`HasSectors 0 c 1`: a lone horn, `κ₁ = 0 < 1 < 2 = κ₂`. For `z` near `0` with `x > 0`:
- **the `h`-shadow is exactly `B(N, 1)`.** `T`'s points satisfy `|z − p| > |z − N|` (the bound of V4, now for `|z| < ρ` above the axis too: `e(φ)·(z − N) ≤
  ρ/2 − (√3/2)(1 − ρ) < 0`), so `inf_T |z − p| = |z − N|` (not attained) and `sup > 1`; the `h`-flank `H₀` is within `2ρ`. So `z` is `h`-clear iff
  `|z − N| ≥ 1`, and for `|z − N| < 1` an explicit `y = (0, 1 + s″) ∈ T` with `s″ = z_y − 1 + √(1 − z_x²) ∈ (0, ℓ)` has `|z − y| = 1`.
- **the `g`-shadow is exactly the outside of `B̄(N, 1)`.** For `p ∈ T′`, `|z − p| > 2 − |z − N|` (V2's bound), so `|z − N| ≤ 1` is `g`-clear; for
  `|z − N| > 1` the point `y = N + (1 + d)(z − N)/d`, `d = |z − N|`, lies in `T′` (`|y − N| = 1 + d > 2`, `y_x > 0`, `|y − S′| < ℓ′` for `|z| < 1/50`) and
  `|z − y| = 1`.
- **So the admissible set is `{1}`.** At `σ = 1`: the points with `TanAbove 0 0 1 z` (`|z − N| < 1`, `tanAbove_one_iff`) are `g`-clear and the rest `h`-clear —
  `ShaveAvailable 0` holds. At `σ ∈ [0, 1)`: `z = (t, s t²)` with `max(σ, 0)/2 < s < 1/2` is in the horn, `TanAbove σ`, and `|z − N| > 1` for all small `t`
  (signs of `tanHeight κ (t, st²) = t²(s − κ/2 − κs²t²/2)`), so not `g`-clear. At `σ ∈ (1, 2]`: `1/2 < s < σ/2` gives horn points not `TanAbove σ`
  with `|z − N| < 1`, not `h`-clear. Exact at `t = 10⁻³, 10⁻⁴, 10⁻⁵` and ten values of `σ` (`e6-sigma-down`, `e6-sigma-up`); the sign argument is
  for every small `t`.
- **No other site.** The sites (`IsSite`: a repeated colour or a horn) of the model: `v` alone. The rim points of `B(0, ρ)` are cubic with transversal
  arcs; `N` (two sectors, angles `60°`, `300°`), `S′` (`90°`, `270°`), the features' corners and the grid corners (four colours, one sector each) carry no
  repeated colour and no horn; no point but `v` has a horn. So `v` is the only point with an available move, and it has exactly `ShaveAvailable`.
- **What the planned step meets.** `exists_shave` needs `κ₂ ≤ 1` (here `2`); `shave_step_gen` (KL1 § 3.3) needs `|σ| ≠ 1` or `σ ∈ {κ₁, κ₂}` (here
  `σ = 1 ∉ {0, 2}`). The shave along `σ = 1` would create the arc `ω(N) ∩ H`, inner colour `g`, outer `h`, centre `N` carrying `h` and not `g`, with `g`
  along the radius-2 arc `R₂` at `S′`: an **(R2) arc** (§ 2.4, H2) — and `IsModification` forbids it.
- **The allowed cone.** The only `c`-contact on `ω(0)` is `w` (in-type), so `allowedCone 0 c = {d : d·w ≥ 0}`, a closed half-plane with the horn's
  direction `e 0` inside it (`w·e 0 = 3/5`): `int D_c(0) ≠ ∅`, as E6-CONE (stage 4) says every F6 must have.

### 3.4 At the model no local step lowers `v`'s degree (E6-NODROP)

Let `F′` be valid, agree with the model off `B̄(0, ρ′)`, `ρ′ < 1/10` (so `T`, `T′`, `T_c` are unchanged), create no unit arc (`RingArcsWithin`), and
carry no colour at `0` the model does not. Then `F′.coloursAt 0 = {c, g, h}`, so `0` has at least three sectors:
1. **`h ∈ F′.coloursAt 0`.** Near the direction `225°` (`z = (−t, −t)`) points are in `shadow T_c` (`z·w < 0`: `p = λw` with `λ = z·w + √((z·w)² + 1 −
   |z|²) ∈ (1 − 2r_c, 1)` has `|z − p| = 1`) and in `shadow T′` (`|z − S′| < 1`: `p = S′ + (1/100, −b)` with `|z − p| = 1`, `p ∈ T′`). Shadows of open sets
   are open, interior points are dense, so interior points of `F′` accumulate at `0` along that direction, each of a colour other than `c` and `g`;
   one colour accumulates, and it is carried at `0`, so it is `h`.
2. **`g ∈ F′.coloursAt 0`.** The same near `z = (−2t, t)` (`z·w = −2t/5 < 0`, `z_y > 0`): in `shadow T_c` and in `shadow T` (`|z − N| < 1`).
3. **`c ∈ F′.coloursAt 0`.** Otherwise a ball `B(0, ρ″)` meets only `g`- and `h`-interior points (colours not carried at `0` are bounded away). Old horn
   points inside `B(N, 1)` are in `shadow T`, so not `h`: they are `g` or on `Γ′`; those outside `B̄(N, 1)` are in `shadow T′`, so `h` or on `Γ′`. Every point of
   `ω(N) ∩ H ∩ B(0, ρ″)` is then a limit of `g`-interior and of `h`-interior points, hence in `Γ′`: an arc of `ω(N)` in `Γ′` with sides `g`, `h`, which the
   model's `Γ` does not meet — a unit arc created.
Each colour at a point holds a sector there (the sector chart), so the degree is at least `3`. **Hence `exists_vertexStep`'s conclusion
"`∃ m' < m, F'.HasDegree v m'`" is false at the model (`m = 3`), for every `δ ≤ 1/10`, while every hypothesis of `exists_vertexStep` holds there**
(`F` valid and clean, `0 ∈ F.dom`, `ShaveAvailable 0`, `HasDegree 0 3`). The witnesses at `t = 10⁻³`: `e6-nodrop`.

### 3.5 Entries

derivation: e6-occurs
  statement: there is a valid clean plane map with twelve colours and no arc of radius 1 in which the only site is a vertex v with ShaveAvailable v through a lone horn of bounds κ₁ = 0 < κ₂ = 2, admissible at the split σ = 1 and at no other σ
  uses only: the shadow near v of an out-type region at N meeting N away from the +a tangent is B(N, 1); the shadow near v of a region outside the circle of radius 2 about N, at S′ on the +a side, is the outside of B̄(N, 1); the validity inequalities of § 3.2
  not claimed: a valid six-coloured plane map with such a vertex (no valid six-map of the plane is known, FS-114); that the twelve colours are needed (the background's nine are a convenience); that F6 needs Condition 5 to fail
  argument: § 3.2 Validity (no two interior points of one colour at distance exactly 1), by colour
  verdict: derived
  grade: hand
  minds: 1
  model: § 3.1 The model — the statement is an existence claim and the model is its witness
  converse: one-way — an existence statement; "the only site" describes the model, it characterizes nothing
  prior art: new — "cusp" (0), "tangen" (5) in my extraction of [SokolovVoronov2025]'s text, none on a cusp; FS110-A6-C2's single horn exists locally but is doubly shadowed, not F6
  handoff: Keryx — the model, for de Bruijn's implementer of exists_vertexStep, as the instance the lone-horn case must meet

derivation: e6-nodrop
  statement: at the model's vertex v, every valid map that agrees with the model off a closed disc about v of radius below 1/10, creates no unit arc and carries no colour at v that the model does not, carries c, g and h at v, so v has degree at least 3
  uses only: the shadows of T_c, T and T′ at the directions 225°, about 153° and in the horn (explicit witnesses at distance 1); shadows of open sets are open; Γ is nowhere dense; a colour carried at a point holds a sector there
  not claimed: anything about modifications that change the map at distance 1/10 or more from v; that exists_vertexStep's other clauses fail
  argument: § 3.4 At the model no local step lowers `v`'s degree (E6-NODROP)
  verdict: derived
  grade: derived from: e6-occurs
  minds: 1
  model: the model of § 3.1 with δ = 1/20 in exists_vertexStep
  prior art: partly: plans/FS110-NB4-verification.md § 2.9 — "no move of N4's lowers Φ there" at a cubic vertex with a cusp horn; the degree count is this job's
  handoff: de Bruijn — exists_vertexStep's clause "∃ m' < m, F'.HasDegree v m'" is false at the model; its corrected statement is drafted in stage 4

control: e6-arcs
  of: e6-occurs — the model has no arc of radius 1
  run: python3 ../tools/fs131_e6_model.py --check arcs
  expect: arcs: 7 circular radii (plus segments: the grid, the axis, T's two rays, T''s ray, the opening's ray); unit arcs: 0
  fault: python3 ../tools/fs131_e6_model.py --check arcs --unit-arc

control: e6-valid
  of: e6-occurs — the inequalities validity reduces to
  run: python3 ../tools/fs131_e6_model.py --check valid
  expect: valid: 6 of 6 lemma inequalities hold
  fault: python3 ../tools/fs131_e6_model.py --check valid --rho 9/10

control: e6-sigma-down
  of: e6-occurs — every σ below 1 is refuted by a g-shadow witness in T′; the radius 2 about N determines it
  run: python3 ../tools/fs131_e6_model.py --check sigma
  expect: sigma: below 1 refuted 6/6; above 1 refuted 4/4; admissible {1}
  fault: python3 ../tools/fs131_e6_model.py --check sigma --R 21/10

control: e6-sigma-up
  of: e6-occurs — every σ above 1 is refuted by an h-shadow witness in T; the corner at N determines it
  run: python3 ../tools/fs131_e6_model.py --check sigma
  expect: sigma: below 1 refuted 6/6; above 1 refuted 4/4; admissible {1}
  fault: python3 ../tools/fs131_e6_model.py --check sigma --apex 1/50

control: e6-nodrop
  of: e6-nodrop — the four witnesses; the in-type c-region T_c determines the first, second and fourth
  run: python3 ../tools/fs131_e6_model.py --check nodrop
  expect: nodrop witnesses: 4 of 4
  fault: python3 ../tools/fs131_e6_model.py --check nodrop --no-tc

## Stage 3 — SAVED

## Stage 4 — SAVED: the repair derived — E6-CONE, E6-OPEN (the one-sector wedge-opening), the repaired lone-horn case, the potential

*Coordinator's message received mid-stage (inventory items 382–383): finding accepted; derive OPEN and the repaired case with the descent on
degree plus horns; hand back OPEN's Lean statement in `exists_merge`'s shape with the reuse question answered, the restated
`exists_vertexStep` clause and `acted_finitely`, and the corrections owed to FS110-N-proof's N4 rows and FS112-WALK row 7. All four are below.*

### 4.1 E6-CONE — a horn with a bound outside `[−1, 1]` has a non-degenerate allowed cone

*Statement.* `F` valid, `F.Covers v 1`, `F.IsHorn v α κ₁ κ₂ c`. If `interior (F.allowedCone v c) = ∅` then `−1 ≤ κ₁` and `κ₂ ≤ 1`. Hence every F6
horn (`κ₁ < σ < κ₂` with `σ = ±1`, so `κ₂ > 1` or `κ₁ < −1`) has `interior (F.allowedCone v c)` non-empty.

*Proof.* `horn_bounds_of_noMerge`'s proof (`fs131-w5c`, `FlankUA.lean` l. 724–740) from its line `have hD` on: `c ∈ F.coloursAt v` from the horn;
`woodallCone` with `hD` gives, for small `r`, every `c`-sector equal to `hornSet v β κ κ' r` with `−1 ≤ κ < κ' ≤ 1`; the horn set is a `c`-sector, so
`e α = e β` (`e_eq_of_mem_coneAt_hornSet`) and `hornSet_curv_eq` gives `κ₁ = κ`, `κ₂ = κ'`. The hypotheses `¬ MergeAvailable v`, `2 ≤ m`,
`HasSectors v c m` were used only to produce `hD`. ∎ The model: `allowedCone 0 c = {d : d·w ≥ 0}` with `κ₂ = 2` (§ 3.3).

### 4.2 E6-OPEN — the one-sector wedge-opening (FS110 § 2.8's sketch, derived with unit arcs allowed)

*Statement.* `F` valid, `F.Covers v 1`, `F.IsHorn v α κ₁ κ₂ c`, `interior (F.allowedCone v c)` non-empty. Then for every `δ > 0` there is `ρ ∈
(0, δ)` and a valid map `F′` agreeing with `F` off `B̄(v, ρ)`, creating no unit arc, keeping Condition 5, carrying no new colour at `v`, with `v`'s
degree not raised and its number of horns lowered by at least one, the rim's points of at most three colours with none repeated, and
`allowedCone v′ c` unchanged at every `v′ ∉ B̄(v, ρ)`.

*Proof.*
1. **The horn's direction is allowed.** `α ∈ coneAt (F.region c) v` (the horn set approaches `v` along `α`, `IsHorn.mem_coneAt_region`), so
   `e α ∈ F.allowedCone v c` (`coneAt_subset_allowedCone`, N3-CONF).
2. **A side.** `allowedCone v c` is a convex cone (`add_mem_allowedCone`, `smul_mem_allowedCone`) with non-empty interior, so `cone_side`
   (`MergeMove`, kernel) gives `e α ∈ interior` or a side `σ = ±1` and `ψ ∈ (0, π)` with `e (α + σψ)` in the cone; in the first case take `σ = 1`.
3. **The wedge is clear — a kernel lemma already.** `clear_near_end` (`MergeMove` l. 530, kernel) with `θ = α`, `κ` the horn's `σ`-side curvature
   (`κ₂` for `σ = 1`, `κ₁` for `σ = −1`), `hK` from step 2, `hbase` from the horn's own tile (its germ lies in the tile's closure): there are `ε, ρc
   > 0` such that every `v + s e φ` with `0 < s < ρc`, `φ` on the `σ` side of the germ's point (`0 ≤ σ(φ − germDir α κ s)`) and `|φ − α| ≤ ε` is
   clear for `c`. Its proof is the one this case needs: N3-CLEAR at the contacts with a margin at `e α`, and at the contacts tight at `e α` — the
   poles `v ± n` — N3-UP's push (`clear_of_push`: the lens for in-type tiles near the pole on the `σ` side, the lune for out-type tiles near the
   other). In the words of § 2.4's H3: the tight contacts the side allows are exactly those whose shadows are monotone away from the wedge
   (for `σ = 1`: in-type at `N`, out-type at `S′`), so a shadowed wedge point would shadow the horn point beneath it — a monochromatic unit
   pair in `F`.
4. **The ray.** The sector chart at `v` (`Near`, `localSectors`) has finitely many germs. Let `X` be the first sector on the `σ` side of the horn
   whose cone has positive angle (`[α, α + σψ_X]`, `ψ_X > 0`); the sectors strictly between the horn and `X` are horns along `α` (the swallowed
   ones, possibly none). Choose `ψ₁ ∈ (0, min(ε, ψ_X))` with `α + σψ₁` no germ's direction, and `ρ < min(δ, ρc)` inside the chart's radius.
5. **The map.** `W` := the points of `B(v, ρ)` strictly between the horn's `σ`-germ and the ray `v + ℝ₊ e(α + σψ₁)` (the swallowed horns and the part
   of `X` below the ray). `F′` := `F` with `W` coloured `c`, the swallowed germs dropped, the ray and an arc of `∂B(v, ρ)` across `W` added (then
   `exists_clean`, which drops the horn's `σ`-germ, now with `c` on both sides).
6. **Valid** by the validity transfer (`Valid.of_agreesOff`): every interior point of `F′` in `B̄(v, ρ)` coloured anew is in `W ⊆` step 3's clear set;
   two new `c`-points are within `2ρ < 1`.
7. **No unit arc; Condition 5.** The new arcs are a segment and an arc of radius `ρ < 1`, the rest of `Γ′` lies in `Γ`
   (`ringArcsWithin_of_Γ_subset`).
8. **Colours, degree, horns at `v`.** Only `c` is added near `v`, and `c ∈ F.coloursAt v`. The sectors after: the new `c`-sector (the horn, the
   swallowed horns and `W`) bounded by the horn's `−σ`-germ, tangent at `α`, and the ray at `α + σψ₁` — positive angle, no horn; `X` above the ray —
   positive angle, still one sector; every other sector unchanged. So degree′ = degree − (swallowed) and horns′ = horns − 1 − (swallowed horns).
9. **The rim.** `∂B(v, ρ)` meets `Γ` transversally at points that are no vertices (the chart), so each new rim point carries at most three colours;
   where `X` lies on both sides of the rim arc it is not added (or `exists_clean` drops it), so no rim point has a repeated colour.
10. **`D_c(v′)` off the disc** — `merge_allowedCone`'s route (`MergeMove` l. 3440): the closure of the recoloured set lies in `{v}` and the open
    set `U = {v + s e φ : 0 < s < ρc, φ strictly between the horn's −σ-germ and α + σε}`, all of whose points are clear for `c` (the horn's
    interior points by validity, the rest by step 3); by `dist_ne_one_of_isOpen_isClear` no point of `U` lies on `ω(y)` for `y` in the closure of
    `c`'s class, so the contacts of `c` on `ω(v′)` agree, and each new `c`-tile at a contact holds an old one there and is in- or out-type with it
    (the new map is valid). ∎

*Model.* At § 3.1's `v`: `σ = 1`, `ψ₁` with `tan ψ₁ = 2/5`, `X = G₀`; `e6-open-model` checks step 3's inequality in the model's own terms.

### 4.3 E6-ROUTE — the vertex step repaired (priority form, F7)

At a site `v` of a clean valid map with an available move, for every `δ > 0`, a clean valid modification that is a local step on a disc of radius
below `δ` about `v`, adds no colour at `v`, leaves no other site in the disc, and **lowers `Π(v) := degree(v) + horns(v)`**:
- **MERGE available** — `exists_merge_aux`, then `exists_clean`: the degree drops (KL1's count after cleaning); no horn is made (the merged
  `c`-sector's outer germs are old ones; two horns along one ray merge into one horn), so `Π` drops.
- **else MERGE-RAY** — `horn_bounds_of_noMerge` gives the outer bounds in `[−1, 1]`, `exists_rayMerge_aux`, `exists_clean`: degree down, horns down.
- **else SHAVE through a `c`-horn.** With no MERGE, a colour of two or more sectors has `interior (allowedCone v c) = ∅`; so:
  - `interior (allowedCone v c) = ∅` (every horn of a repeated colour, and a lone horn in Woodall's cone): E6-CONE gives `−1 ≤ κ₁`, `κ₂ ≤ 1`, so
    `exists_shave_aux` applies with the available `σ ∈ [κ₁, κ₂] ⊆ [−1, 1]` (a split at `±1` is the horn's own arc, FS112-WALK row 7), then
    `exists_clean`: the horn's two germs drop and `Σ` is added — degree down by one; the flanks keep their kind (a flank horn stays a horn between
    `σ` and its far curvature), the shaved horn is gone — horns down;
  - otherwise (a lone horn with a non-degenerate allowed cone — every F6 horn, by E6-CONE): **E6-OPEN**, then `exists_clean`: degree not up,
    horns down.
- `KL1 § 3.3`'s `shave_step_gen` is no longer needed: every lone horn with a bound outside `[−1, 1]` is opened, not shaved.

### 4.4 The trace

| statement | reads F6? | fate |
|---|---|---|
| `exists_terminal` (`fs131-w5c`, `Terminal.lean`) | through `IsTerminalMap`'s `Terminal` (no SHAVE anywhere) | **unchanged, and carried**: its route needs E6-OPEN; FS112-N2-TERM's hand statement does not assert "no SHAVE at a single horn", so the Lean statement says more than the hand proof carried until now — E6-OPEN supplies the missing step (FS110 § 2.8's sketch, NB4's D3) |
| `exists_terminalMap` (`Procedure.lean`) | yes | **unchanged**, true over the repaired step; § 3.5's model is an instance of its hypotheses at `k = 12` where the move is OPEN |
| `IsTerminalMap`, `Terminal`, `ShaveAvailable`, `IsModification` | — | **unchanged** (`Terminal` is consumed downstream only at points with a repeated colour, `isStuck_of_hasRepeatedColour`; nothing needed weakening once OPEN exists) |
| `exists_vertexStep` (KL1's child, a `sorry`) | yes | **its degree clause is false at the model** (E6-NODROP); restated below with the potential `Π` |
| `exists_terminalSeq` (`sorry`) | through `acted_finitely` | **statement unchanged**; its child `acted_finitely` counts `Π` at sites (below) |
| `exists_arcStep` (`sorry`) | indirectly | **one clause owed**: no step raises a site's horn count (below) — a bend's new curve leaves an end vertex at a changed angle, and must not become tangent there to another arc; a genericity choice of the bend's profile, to be checked against `bendMap` |
| FS110-N4-TERM (row and § 2.7) | yes | corrections drafted in § 4.6; Keryx's item 372 (d) already corrects "Φ(v) down by one" for the construction as built |

### 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

**(1) OPEN, in `exists_merge`'s shape.** New declarations, in the module downstream of `Moves` and `MergeMove` (ruling 372 (a)):

```lean
/-- **`v` has exactly `j` horns**: for every small radius, exactly `j` of its sectors are horn sets. -/
def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
  ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard = j

/-- **E6-CONE** (`horn_bounds_of_noMerge` with its cone hypothesis made direct): a horn of a colour whose allowed cone has empty
interior has bounds in `[−1, 1]`. -/
theorem horn_bounds_of_interior_empty (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {α κ₁ κ₂ : ℝ}
    (hH : F.IsHorn v α κ₁ κ₂ c) (hD : interior (F.allowedCone v c) = ∅) : -1 ≤ κ₁ ∧ κ₂ ≤ 1

/-- **FS131-E6-OPEN** (FS110 § 2.8's wedge-opening): if `c` has a horn at `v` and `int D_c(v)` is non-empty, recolouring with `c` a
thin wedge beside the horn, on a side where `D_c(v)` has interior directions, gives a valid map, equal to `F` off a small disc about
`v`, creating no unit arc (so Condition 5 is kept), in which `v` gains no colour, `v`'s degree does not rise and it has one horn fewer,
the new points on the rim carry at most three colours with none repeated, and no other point's allowed cone for `c` changes. -/
theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ}
    (hm : F.HasDegree v m) (hj : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.coloursAt v ⊆ F.coloursAt v ∧
      (∃ m' j', m' ≤ m ∧ j' < j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c
```

**Can `MergeMove`'s construction be reused?** Its lemmas, yes, unchanged: `cone_side` (the side), `clear_near_end` (the whole clearness, step 3
— it already contains `clear_of_push` and `push_contacts_of_mem_allowedCone`), `dist_ne_one_of_isOpen_isClear` and `merge_allowedCone`'s route
(`D_c(v′)`), and its rim argument (no repeated colour). Its surgery, not as it stands: `mergeArcs`/`mergeCol` recolour a gap that runs from
one `c`-germ to the next `c`-germ and add only a rim arc; OPEN's gap runs from the horn's `σ`-germ to a **new ray inside the sector `X`**, so it
needs one more arc (a segment from `v`) and a colouring that splits `X` along it. Two ways: (a) a variant of `mergeArcs`/`mergeCol` whose gap's far
end is the ray (closest to `merge_allowedCone`'s proof, and it keeps the rim free of repeated colours by construction); (b) `Moves`' `Near.move`
with `E = {the ray}` and `col' = c` on `W`, then `exists_clean` (the full rim circle and the horn's `σ`-germ are dropped by cleaning — KL1's
finding (2)). I would take (a). Whether `HasHornCount` is the encoding, or a horn count read off `BranchGerms` (germ pairs with equal directions),
is the implementer's call.

**(2) `exists_vertexStep`, restated** (`fs131-w5c`, `Procedure.lean`; replaces the hypotheses' "`{m : ℕ} (hdeg : F.HasDegree v m)`" and the
conclusion's "`(∃ m' < m, F'.HasDegree v m')`"):

```lean
theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x
```

Its proof is § 4.3's case split. **`acted_finitely`**, restated: *a site is acted on finitely often: its potential `degree + horns` never rises —
a vertex step elsewhere leaves it (`LocalStep`, and no site in that step's disc but its centre), an arc step leaves it (its degree clause and the
new horn clause) — and each vertex step at it lowers it; a centre as before (its bad count rises only at the finitely many vertex steps within
`3` and at the at most `k` stages where it loses a colour, and each arc step at it lowers it).* **`exists_arcStep`'s owed clause**, added beside
"`(∀ x m, F.HasDegree x m → F'.HasDegree x m)`": `(∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j')`.

### 4.6 Corrections owed (dated drafts; the original text left standing above each)

**`plans/FS110-N-proof.md`, § Continuation — FS110-N4, theorem table, below the N4-SHAVE row (l. 718) and the N4-TERM row (l. 723), and below
§ 2.8's "partial remedy, sketch" (l. 918–920):**

> *Erratum (2026-10-05, FS131-E6, `plans/FS131-E6-derivation.md` §§ 3–4):* **N4-SHAVE** holds as written in § 2.2's setting (`−1 < κ_− < κ_+ < 1`,
> the horns N3-DEG gives). At a **single horn** (its colour one sector at `v`) the bounds may leave `[−1, 1]`, and then the admissible splits can be
> exactly `σ = 1` (or `−1`) strictly inside the horn: an out-type corner of `h` at `N` shadows exactly `B(N, 1)`, and a `g`-region at `S′` bounded by
> the circle of radius `2` about `N` shadows exactly its outside (`f̃(1/2) = 1`, `f(∞) = 1`). The split is then an arc of radius 1, which breaks
> Condition 5 — realised by an exact valid plane map that satisfies Condition 5 (FS131-E6-OCCURS). **N4-TERM**, with NB4's D3 (SHAVE on single horns,
> count `Φ + #horns`), reaches a map with no SHAVE at any horn only with § 2.8's wedge-opening, which is now derived for every horn whose colour's
> allowed cone has non-empty interior, unit arcs allowed (FS131-E6-OPEN); every F6 horn has such a cone (FS131-E6-CONE). The count is degree plus
> horns: at FS131-E6's model no local step lowers the degree (FS131-E6-NODROP). The residue NB4-CS names (doubly shadowed single-horn Woodall cones) is
> unchanged.

**`plans/FS112-N-proof.md` § 1.4, row 7 (N4-SHAVE with FLANK, RAY), and `plans/FS112-derivation.md`'s FS112-WALK entry, below its proof
verdict:**

> *Erratum (2026-10-05, FS131-E6):* row 7's "SHAVE creates no unit arc (its circle `Σ` has curvature `σ_h ∈ [κ₋, κ₊)`, and `σ_h = −1` forces `Σ` onto
> the existing lower arc)" holds for horns with bounds in `[−1, 1]` (row 5's). At a single horn whose bounds leave `[−1, 1]` SHAVE's only split can be
> `σ = ±1` strictly inside the horn, and SHAVE then creates a unit arc — an (R2) arc of `ω(N)` when the `g`-shadow comes from a `g`-region along the
> radius-2 circle at `S′`, a both-kind arc when it comes from FLANK's in-type `g` at `N` (FS131-E6-OCCURS, exact). This is a step that fails by
> creating a unit-arc centre, not at one it reads, so the headline's "every other step holds off unit-arc centres at points it reads" gains this
> case. The route replaces SHAVE there by the wedge-opening (FS131-E6-OPEN).

**`plans/FS110-NB4-verification.md` § 2.3 and divergence D3** (a precision): "split along the circle … of any curvature in `[σ_g, σ_h] ⊂ (−1, 1)`"
holds for horns with bounds in `(−1, 1)`; D3's "the §2.3 criterion is unchanged" for single horns misses `σ_g = σ_h = ±1` (FS131-E6-OCCURS).

### 4.7 Entries

derivation: e6-cone
  statement: at a point v of a valid map covering B̄(v, 1), a horn of colour c along e α with bounds κ₁ < κ₂ such that interior (allowedCone v c) is empty has −1 ≤ κ₁ and κ₂ ≤ 1; so every horn shaveable only at σ = ±1 strictly between its bounds has a non-empty interior of its colour's allowed cone
  uses only: woodallCone (every c-sector a horn set with bounds in [−1, 1] when the interior is empty); a horn set's bounds are determined by the set
  not claimed: that a colour of one sector with an empty-interior cone has a horn at all; anything about the second sentence's converse
  argument: § 4.1 E6-CONE — a horn with a bound outside `[−1, 1]` has a non-degenerate allowed cone
  verdict: derived
  grade: hand
  minds: 1
  model: § 3.1's v: κ₂ = 2 and allowedCone 0 c = {d : d·w ≥ 0}; and fs131-w5c's bowtie at 0 for the first sentence (horn_bounds_of_noMerge's inhabitant)
  prior art: known: horn_bounds_of_noMerge (fs131-w5c, FlankUA.lean l. 724) — its proof, read with its cone hypothesis made direct
  handoff: de Bruijn — horn_bounds_of_interior_empty, § 4.5 (1)

derivation: e6-open
  statement: at a point v of a valid map covering B̄(v, 1), if c has a horn at v and interior (allowedCone v c) is non-empty, then for every δ > 0 recolouring with c a wedge beside the horn inside B(v, ρ), ρ < δ, gives a valid map agreeing off B̄(v, ρ), creating no unit arc, with no new colour at v, the degree at v not raised, one horn fewer at v, rim points of at most three colours none repeated, and allowedCone v′ c unchanged for v′ off the disc
  uses only: N3-CONF (the horn's direction is allowed); cone_side; clear_near_end (N3-CLEAR with a margin, N3-UP's lens and lune at the poles); the sector chart's finitely many germs; the validity transfer; no new arc of radius 1; merge_allowedCone's route for the far cones
  not claimed: that the opening lowers the degree (e6-nodrop: it cannot always); that the horn's colour has one sector (the statement does not need it); anything without a non-empty interior (Woodall's cone, where shaving is the move)
  argument: § 4.2 E6-OPEN — the one-sector wedge-opening (FS110 § 2.8's sketch, derived with unit arcs allowed)
  verdict: derived
  grade: hand
  minds: 1
  model: § 3.1's v with σ = 1 and tan ψ₁ = 2/5 (control e6-open-model)
  prior art: partly: plans/FS110-N-proof.md § 2.8 (the sketch, D_c(v) a half-plane); [SokolovVoronov2025] Prop. 7 (the polygonal triangle recolouring, read 2026-10-05); the cusp case not found in print
  handoff: de Bruijn — exists_open and HasHornCount, § 4.5 (1), with MergeMove's lemmas reused and its surgery varied by one segment

derivation: e6-route
  statement: at a point v of a clean valid map where MERGE, MERGE-RAY or SHAVE is available, for every δ > 0 there is a clean valid modification that is a local step on a closed disc about v of radius below δ, adds no colour at v, leaves no other site in the disc, and lowers the degree of v plus its number of horns
  uses only: exists_merge_aux, exists_rayMerge_aux, exists_shave_aux, exists_clean (their constructions as KL1 § 3.3 lists); horn_bounds_of_noMerge; e6-cone; e6-open; MERGE and SHAVE create no horn at v and the flanks keep their kind
  not claimed: that the degree alone drops (false at e6-nodrop's model); that the arc step keeps every site's horn count (a clause owed, § 4.4); anything at a point where no move is available
  argument: § 4.3 E6-ROUTE — the vertex step repaired (priority form, F7)
  verdict: derived
  grade: derived from: e6-cone, e6-open
  minds: 1
  model: § 3.1's v (the OPEN branch); the other branches are the held moves' own
  prior art: partly: plans/FS110-NB4-verification.md § 4.1 D3 — "count Φ + #horns … SHAVE on single horns and the opening remedy both join the moves"
  handoff: de Bruijn — exists_vertexStep restated, acted_finitely's potential, exists_arcStep's horn clause, § 4.5 (2)

control: e6-open-model
  of: e6-open — the wedge's clearness inequality and the far ray inside the allowed cone, at the model; a ray past the cone breaks both
  run: python3 ../tools/fs131_e6_model.py --check open
  expect: open: wedge c-clear; far ray inside D_c(v); v after: 3 sectors, 0 horns
  fault: python3 ../tools/fs131_e6_model.py --check open --open-dir -5,2

### 4.8 Predictions, scored (registered § 1.4)

| id | probability | outcome |
|---|---|---|
| E6-P1 (F6 occurs in a valid plane map, `k ≥ 7`, exact) | 0.85 | **met** — `k = 12`, and under Condition 5 as well (stronger than registered) |
| E6-P2 (F6 forces `int D_c(v) ≠ ∅`) | 0.97 | **met** — E6-CONE |
| E6-P3 (OPEN valid at every horn with `int D_c(v) ≠ ∅`, no unit arc, no colour added, degree not up, one horn fewer) | 0.85 | **met** (one mind) — and its clearness step was already a kernel lemma, `clear_near_end` |
| E6-P4 (at some F6 instance no local step lowers the degree) | 0.75 | **met** — E6-NODROP |
| E6-P5 (`exists_terminal`, `exists_terminalMap`, `IsTerminalMap` unchanged) | 0.85 | **met** — two `sorry` children change (`exists_vertexStep`, `exists_arcStep`), no backlog statement |

Brier over the five: `((0.15)² + (0.03)² + (0.15)² + (0.25)² + (0.15)²)/5 = 0.0272`. All five went the way registered; the one I priced lowest (P4) was
the one that needed a construction choice: without the in-type `c`-region `T_c`, `c` has no contact on `ω(0)`, `D_c(0)` is the whole plane, and
recolouring all of `G₀` with `c` lowers the degree to `2` — so the instance had to be built against the clause, not found.

## Stage 4 — SAVED
