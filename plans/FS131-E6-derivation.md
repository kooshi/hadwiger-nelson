# FS131-E6 — SHAVE's residual case (F6): a lone horn shaveable only at `σ = ±1`

*Job FS131-E6, Ephodos (Opus 5.5), 2026-10-05. Brief `data/fs131/briefs/FS131-E6-shave.md` with `plans/STANDING-RULES.md`; claim list
`data/fs131/claims-E6.md`. Working files `data/fs131/e6/`; tools `tools/fs131_e6_*.py`. Nothing in this milestone is fenced (inventory,
§ Rulings in force, ruling 1). Lean sources read on `main` (`a9342834`) and on `fs131-w5c` (`d3d38d3a`, IL1's tip at reading time).*

## Theorems this phase proved

*(filled at each stage; one line per theorem, its grade and address)*

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
