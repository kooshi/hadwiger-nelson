# FS-124 — the kernel plan for the radius clause (job FS124-K1)

*De Bruijn, the planner. Brief: `data/fs124/briefs/FS124-K1-kernel-plan.md`. Claim list: `data/fs124/claims-K1.md` (five
statements: C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE). Branch `fs124-wk1`, cut from `main` at `596100d4`. Working
files: `data/fs124/k1/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

None in the library: this is a planning job, and every leaf of the three skeleton modules is a `sorry`. Three leaves were
taken through `lean` outside the library to validate the model (`data/fs124/k1/lean/Probe1.lean`, Stage 2); they are
evidence for the plan, not theorems of the library.

## Stage 1 — SAVED (FS124-K1): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/k1/readback.py <brief>` takes every quoted block of the brief
with its `— source:` line and looks for it, whitespace-normalized, in the file named: **12 of 12 found** (Kooshi's two
passages; the five statements' first lines against `data/fs124/claims-K1.md`; `structure AeColouring`,
`AeColouring.exists_motion`, `chromaticNumber_plane_le_chiM0`; the two axioms). Control: `--control` changes the case of one
letter in each quotation and must find none of the twelve — it found none (exit 0 on both runs). The claim list in this
worktree is byte-identical to `main`'s copy (`diff`).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K1.md`; `Plane/AeColouring`, `Plane/UnitPairs`, `Plane/YesLimit`, `Outside/OAI158`,
`Plane/Basic`, `UnitDistance`; of the release (read-only, `/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/`):
`Coloring.lean`, `WeakColoring.lean`, `MeasurableProper.lean`, `Basic.lean`, `Seven.lean` to line 70, and the declaration
headers of `BorelTransfer.lean`, `Compactness.lean`, `Five.lean`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 —
`build: OK — 474 of 474 batches, 136 module(s) rebuilt, 0 module(s) with warnings, 20m37s`
(`data/fs124/k1/logs/build-0-as-given.log`).

**Three notes on the brief** (none changes the job):
1. The worktree's `.lake/build`, "its own copy, made today", was behind the branch by 136 modules; the first build took
   20m37s where a current copy takes about three minutes.
2. The list says "weak `k`-colouring" in GRAPH and COUNTABLE and "weak measurable `k`-colouring" in UP, DOWN and FIVE. By
   the list's own definition a weak colouring is measurable, so the two phrases name one notion; I read them so.
3. The brief's `touches:` does not name `scripts/Axioms.lean` or `scripts/Assumptions.lean`. I leave both alone; § the plan
   lists what the landing adds to them.

**Touches of fenced material, disclosed** (standing rule 8):
- 13:41 UTC, `git log --oneline | head -3` in the worktree, run to confirm the branch point. It printed the **subject** of
  commit `1eb1aa603`: "FS124-E1: stage 3 — C124-RADIUS derived: a random rigid motion on one open set per finite graph
  (C124-RADIUS-GRAPH), up, down at every k over the declared outside theorem, the five-colour corollary; gate exit 0, one
  control fired on its fault". What it carried: that the deriver's GRAPH moves one open set's colouring by a random rigid
  motion (the statement itself says "for almost every one of them"), that DOWN is over the declared outside theorem (the
  list's not-claimed line: "anything without that import"), that FIVE is a corollary. No body was read. The launch
  context also showed five subjects of FS-124 commits (FS124-P2 stage 0; inventory items 9 and 10; the re-posing brief;
  FS124-E1's report), none naming a route.
- 13:54 UTC, the session's shared scratch directory: I wrote one object file of my own under
  `scratchpad/olean/Proofs/HadwigerNelson/Plane/` and the listing I printed showed that the directory already held
  symbolic links, named after existing `Plane` modules, into worktree `fs132-wk1`'s build. Nothing of FS-124 was in what
  I saw. I removed my file and have used `build/` inside this worktree since (ignored by git).

## Stage 2 — SAVED (FS124-K1): the definition, the statements typed and read back, the skeleton (phase 1, blind)

Three modules, built through `./scripts/build.sh` under the slot: exit 0, `476 of 476 batches, 4 module(s) rebuilt, 3
module(s) with warnings` — the warnings are the 54 `declaration uses sorry` lines (31 + 15 + 8) and nothing else
(`data/fs124/k1/logs/build-1-skeleton.log`). `tools/check_architecture.py`: PASS, 310 rows, 0 import mismatches; with the
three files on disk and their rows removed it fails (`missing: […]`), so the check sees them.

| module | imports | holds |
|---|---|---|
| `Plane/WeakColouringOn` | `Plane/AeColouring` (closure: 2 library modules) | the definitions and their API — the module other modules import |
| `Plane/Radius` | the above, `Plane/CoverExamples`, `UnitDistance` (closure: about 17) | GRAPH, COUNTABLE, UP; no import |
| `Plane/RadiusOutside` | `Plane/Radius`, `Outside/OAI158` (closure: 1,285, through `Instances/Interval`) | DOWN, FIVE, the join, the definition against the import's |

### 2.1 The definition

```lean
noncomputable def rigidMotion (q : ℂ × ℝ) (z : ℂ) : ℂ := q.1 + e q.2 * z
noncomputable def motionMul (q h : ℂ × ℝ) : ℂ × ℝ := (rigidMotion q h.1, q.2 + h.2)
def monoPairSet (U : Set ℂ) (c : ℂ → α) : Set (ℂ × ℝ) := {q | q.1 ∈ U ∧ q.1 + e q.2 ∈ U ∧ c q.1 = c (q.1 + e q.2)}
def AeProperOn (U : Set ℂ) (c : ℂ → α) : Prop := (volume.prod arcLength) (monoPairSet U c) = 0
structure IsWeakColouringOn (U : Set ℂ) (c : ℂ → Fin k) : Prop where
  measurable : Measurable c
  aeProperOn : AeProperOn U c
```

**Read against the list's words** ("a measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair
of a point `z` of `U` and a unit vector `u` with `z + u` in `U`"):

- *"for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U`"* — `AeProperOn U c`: the pairs
  `(z, θ)` with `z ∈ U`, `z + e θ ∈ U` and `c z = c (z + e θ)` are null for `volume ⊗ arcLength`, Lebesgue measure on the
  plane times arc-length on the unit circle in the angle `θ ∈ [0, 2π)`. This is the library's convention for "almost every
  unit pair" (`Plane/UnitPairs`), and `aeProperOn_iff_unitPairsNull` says it in the library's primitive: every class cut
  down to `U` is `UnitPairsNull`. `aeProperOn_iff_ae` is the list's sentence word for word.
- *"a measurable map `c` from `U` to `k` labels"* — typed as a **total** `c : ℂ → Fin k` with `Measurable c`, read on `U`
  alone (`aeProperOn_congr`: the second clause does not see `c` off `U`). The list's literal form is a map on the subtype;
  `exists_isWeakColouringOn_iff_subtype` is the theorem that the two are one notion for measurable `U` and `k ≥ 1`. It is
  also where the difference lives: at `k = 0`, `U = ∅` the subtype form has a colouring and the total form has none. Every
  statement of the list says `k ≥ 1`, so nothing claimed is lost, and `k ≥ 1` is then a hypothesis of no Lean statement:
  a `c : ℂ → Fin k` exists only for `k ≥ 1`.
- *"an open set `U`"* — `U` is any set in the definition; the theorems that need it open take `IsOpen U`.
- *"`k` labels"* — `Fin k` in `IsWeakColouringOn`, as in `AeColouring k` and the import's `WeakColoring k`. `AeProperOn` is
  stated for any label type, since it reads nothing of it.

**Why two notions.** GRAPH, COUNTABLE and UP use only the second clause: nullness in Lean is outer measure `0`, so no
measurability of `c` is needed to say or to use it. `AeProperOn` is therefore the hypothesis of every core lemma, and
`IsWeakColouringOn` — the list's notion, the one the import delivers — is the hypothesis of the three claims as worded and
the conclusion of DOWN. The consequence is in § 2.4, generalization 1.

**Why a predicate on total functions, not a structure with a domain.** One colouring serves many sets (DOWN: one `c` for
every `U`; `IsWeakColouringOn.mono`), and a map on the subtype breeds dependent proofs inside an almost-everywhere statement
(read the right side of `exists_isWeakColouringOn_iff_subtype`). `AeColouring k` stays the bundled whole-plane object.

**At the whole plane, by theorems**: `isWeakColouringOn_univ_iff` — `IsWeakColouringOn univ c ↔ Measurable c ∧ ∀ j,
UnitPairsNull (c ⁻¹' {j})`, the two fields of `AeColouring`; `AeColouring.isWeakColouringOn`,
`IsWeakColouringOn.exists_aeColouring`; and against the import, `isWeakColouringOn_univ_iff_weakColoring` —
`IsWeakColouringOn univ c ↔ Measurable c ∧ Outside.OAI158.WeakColoring k c`. **One difference from the import's own
definition, stated in that theorem's docstring**: the release's `WeakColoring` asks `AEMeasurable c volume`; mine asks
`Measurable c`, which is what `AeColouring` asks and what `proper_to_borel_weak` delivers (`∃ d, Measurable d ∧ WeakColoring
k d`). That an almost-everywhere-measurable weak colouring has a Borel representative that is still one needs a lemma this
library does not hold (changing a colouring on a null set keeps the pair condition); no claim needs it and it is not
planned.

### 2.2 Rigid motions, and which measure "almost every rigid motion" is

A rigid motion is `rigidMotion (x, θ) : z ↦ x + e θ * z`, rotation about `0` by `θ` then translation by `x`
(`dist_rigidMotion`: an isometry). Every orientation-preserving isometry of the plane is one; the converse is not stated,
and no statement needs it: the claims say "almost every motion" and "there is a motion", and both are about the parameters.

**The pairs are the motions.** `rigidMotion (x, θ)` carries the reference edge `(0, 1)` to `(x, x + e θ)`
(`rigidMotion_zero`, `rigidMotion_one`), and every oriented unit pair is such an image for exactly one motion. So the space
`ℂ × ℝ` of `Plane/UnitPairs` is the space of motions' parameters, and `volume ⊗ arcLength` — each motion once, its angle in
`[0, 2π)` — is Haar measure of the motion group in these coordinates. **"Almost every rigid motion" is `volume ⊗ arcLength`
on `ℂ × ℝ`: the same measure space as "almost every unit pair".** `mem_monoPairSet_iff_rigidMotion` reads the definition
that way: `AeProperOn U c` says almost every motion carrying `0` and `1` into `U` separates them
(`aeProperOn_iff_ae_rigidMotion`) — **the definition is C124-RADIUS-GRAPH at the reference edge**, and the clause is its
extension to every countable set.

The proofs move in Lebesgue measure on all of `ℂ × ℝ` (every real angle, each motion countably often), where translating
the angle preserves the measure; `prod_arcLength_eq_zero_iff_volume` passes between the two for a set that reads the angle
through `e θ` alone, and the statements are given in both forms (`AeProperOn.ae_rigidMotion` over all angles, the stronger;
`AeProperOn.ae_rigidMotion_arcLength` and `radius_graph` with each motion once). "Open" is open in `ℂ × ℝ`: the
parametrization is a covering map of the motion group, so a set of motions is open exactly when its set of parameters is
(a remark, not a theorem: no group is declared).

`motionMul q h` is the parameter of `rigidMotion q ∘ rigidMotion h`. No `Group` instance: two facts are used, and each is
a leaf — right multiplication preserves Lebesgue measure (GRAPH), left multiplication does (motions carry weak colourings).

### 2.3 Each statement typed, read back clause by clause

**C124-RADIUS-GRAPH** — `radius_graph` (`Plane/Radius`). No outside theorem.
```lean
theorem radius_graph {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
    (hV : V.Finite) (hVU : V ⊆ U) :
    (IsOpen {q : ℂ × ℝ | MapsTo (rigidMotion q) V U} ∧ {q : ℂ × ℝ | MapsTo (rigidMotion q) V U}.Nonempty) ∧
      (∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, MapsTo (rigidMotion q) V U →
        ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w)) ∧
      ((unitDistance ℂ).induce V).Colorable k
```
"Let k ≥ 1" — idle (§ 2.1). "U an open set" — `hU`. "c a weak k-colouring of U" — `hc`. "V a finite subset of U" — `hV`,
`hVU`. "the rigid motions g with g(V) ⊂ U form a non-empty open set" — the first conjunct, in parameters. "for almost every
one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1" — the second:
almost every motion (each once), if it carries `V` into `U`, separates every unit pair of `V`. "so the unit-distance graph
on V has a proper k-colouring" — the third; `(unitDistance ℂ).induce V` is the library's graph on a set of points
(`Bridge`). *Not claimed, and not said*: nothing for infinite `V` (the core lemma, a separate declaration, does say more:
§ 2.4); no existence of a weak colouring; no bound on the measure of good motions beyond full.

**C124-RADIUS-COUNTABLE** — `radius_countable`. No outside theorem.
```lean
theorem radius_countable {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
    (hV : V.Countable) (hK : IsCompact (closure V)) (hVU : closure V ⊆ U) :
    ∃ q : ℂ × ℝ, MapsTo (rigidMotion q) V U ∧
      ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w)
```
"V a countable subset of U whose closure is a compact subset of U" — `hV`, `hK`, `hVU` (`V ⊆ U` follows). "the
unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U" — the motion
`q`, `MapsTo`, and properness of `v ↦ c (rigidMotion q v)` on the unit pairs of `V`, which `colorable_induce_of_forall_ne`
turns into a `Coloring`. *Not claimed, and not said*: uncountable `V`; `V` accumulating at the boundary; measurability of
the colouring obtained.

**C124-RADIUS-UP** — `radius_up`. No outside theorem.
```lean
theorem radius_up (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) :
    (∀ V : Set ℂ, V.Finite → ((unitDistance ℂ).induce V).Colorable k) ∧ (unitDistance ℂ).chromaticNumber ≤ k
```
"if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring" — `h`. "every finite
unit-distance graph in the plane has a proper k-colouring" — read as: the unit-distance graph on every finite set of points
is `k`-colourable (a graph drawn on those points with unit edges is a subgraph of it). "and χ(ℝ²) ≤ k" — the second
conjunct, `χ(ℝ²)` being `(unitDistance ℂ).chromaticNumber` (`chromaticNumber_plane_eq_complex` equates it with the number
over `EuclideanSpace ℝ (Fin 2)`). *Not claimed, and not said*: no radius; not the converse; nothing at `k = 6`.

**C124-RADIUS-DOWN** — `radius_down` (`Plane/RadiusOutside`). **Rests on `Outside.OAI158.proper_to_borel_weak`.**
```lean
theorem radius_down (h : (unitDistance ℂ).chromaticNumber ≤ k) :
    ∀ U : Set ℂ, IsOpen U → ∃ c : ℂ → Fin k, IsWeakColouringOn U c
```
Word for word. *Not claimed, and not said*: nothing without the import (the docstring names it); not `χ(ℝ²) ≤ 6`; no
regularity beyond measurability.

**C124-RADIUS-FIVE** — `radius_five`. **Rests on `Outside.OAI158.no_proper_five_coloring`.**
```lean
theorem radius_five : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c
```
"There is R > 0 such that no open disc of radius R" — at any centre `p` — "has a weak measurable five-colouring." *Not
claimed, and not said*: no value of `R`; nothing at six.

**Vacuity.** No statement quantifies over an empty domain: `exists_isWeakColouringOn_seven` (R7, `r7_aeColouring`) is a
weak seven-colouring of every set, so it satisfies at once the hypotheses of GRAPH and COUNTABLE (`U = univ`, `V = {0, 1}`:
three `example`s in `Plane/Radius` run the three theorems on it), of UP at `k = 7`, and DOWN's hypothesis holds at `k = 7`.
At `k = 6` UP's hypothesis is the open problem itself (`colorable_iff_forall_ball`); at `k = 5` it fails (FIVE). Each
docstring says so. Adversaries kept in the files: one colour is not `AeProperOn` a disc of radius `2` and is on a disc of
radius `1/2`; FIVE's sentence is false at seven.

### 2.4 What the typing found (sent to the coordinator at 14:17 UTC, before this commit)

No statement defect. Generalizations — each is what the proof uses, and each has its declaration in the skeleton unless
marked:

1. **Measurability of `c` is idle in GRAPH, COUNTABLE and UP** (`AeProperOn`). A colouring proper at every unit pair of `U`
   is `AeProperOn` with no regularity (`aeProperOn_of_proper`), so UP in the proof's form,
   `colorable_plane_of_forall_aeProperOn_ball`, contains the classical "every disc `k`-colourable ⟹ the plane is".
   *Observation, not planned*: a valid fragment covering a disc has its monochromatic pairs over the null arcs, hence is
   `AeProperOn` the disc with no measurability of `F.col`, and `chromaticNumber_plane_le_six_of_fragments` would follow from
   this module with no periodization (`chiM0_le_of_fragments` says more: a measurable colouring of the plane).
2. **GRAPH's almost-every clause for countable `V`, with no hypothesis on where `V` lies, pair by pair**
   (`AeProperOn.ae_rigidMotion`). Finiteness serves only openness of `{q | MapsTo …}`; compact closure only makes that set
   non-null.
3. **The definition is the clause at one edge** (§ 2.2), and the proof is one right translation of a null set.
4. **DOWN for every subset, one colouring for all** (`exists_isWeakColouringOn_of_colorable`); openness unused.
5. **UP and FIVE with discs at any centres** (`colorable_plane_of_forall_aeProperOn_ball`,
   `exists_isWeakColouringOn_ball_iff`); UP's contrapositive at every `k` with no import (`exists_radius_of_not_colorable`),
   which at `k = 4` is FIVE's sentence on the standard three axioms (`exists_radius_no_weak_four`).
6. **`k ≥ 1` idle** in all five.
7. *Not planned; a question for the deriver*: for a measurable weak colouring of a measurable `U`, every direction is good,
   not almost every one (the release's `weak_all_directions` argument on `U ∩ class ∩ ball`), so "almost every rigid motion"
   would sharpen to "every rotation and almost every translation". My derivation, one mind, unchecked.

Added beyond the list, as the join: `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` (both on
`proper_to_borel_weak` alone).

### 2.5 The modeling pass on the definition (`debruijn-domain-modeling`, run fresh)

The first draft had two parameter spaces — motions as `(θ, t) ∈ ℝ × ℂ`, pairs as `(x, θ) ∈ ℂ × ℝ` — and a per-pair map
between them, `g ↦ (g v, θ_g + φ)`, whose measure-preservation was the technical leaf. The pass's question, *what is the
space of unit pairs intrinsically*, has the answer "a torsor of the motion group": the per-pair map is right multiplication
by the motion carrying the reference edge to the pair. Taking the parameters of a motion to **be** its pair made the two
spaces one, turned the definition into the clause at the reference edge, and named the one operation (`motionMul`) that the
proof and the invariance lemma both use, from the two sides. What the pass refused: a `Group` instance on the parameters
(no consumer needs inverses or associativity), the circle `AddCircle (2π)` as the angle type (the library's primitive
`UnitPairsNull` is over real angles in `[0, 2π)`, and one periodicity lemma is the price), a bundled structure with a
domain. Seams checked: `U = ∅`, `U` with no unit pair, `V` a point, `k = 0` (above); a null non-open `U`, on which the
definition says nothing — which is why the definition takes any set and the theorems ask `IsOpen`.

**The probe** (`data/fs124/k1/lean/Probe1.lean`; `lean` against this worktree's build, iteration-level, not a build):
`rigidMotion_motionMul`, `measurePreserving_motionMul_right`, `mem_monoPairSet_iff_rigidMotion` and the one-edge lemma from
nullness over all angles, 35 lines in all, no error. Control: the composition law with `z + 1` for `z` fails at `ring`.
