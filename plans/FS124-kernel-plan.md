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

## Stage 3 — SAVED (FS124-K1): the plan per leaf, the two remaining passes, phase 1 closed (blind)

The skeleton after the passes: build exit 0, `476 of 476 batches, 4 module(s) rebuilt, 3 module(s) with warnings` — 57
`declaration uses sorry` (33 + 16 + 8) and no other warning (`data/fs124/k1/logs/build-2-skeleton.log`);
`tools/check_architecture.py` PASS. The claims as the environment stores them: `data/fs124/k1/signatures.txt` (`#check` of
fifteen declarations, read against § 2.3: the binders are those written, no section variable enters, `radius_five` and
`seven_le_chromaticNumber_plane_iff_exists_ball` have no binder).

**The coordinator's rulings of 14:2x UTC** (in reply to § 2.4's message; nothing in the reply came from the fenced files):
keep both join theorems, each docstring saying which half needs the import — done; the statements in the form the proof
gives, the list's measurable forms as corollaries under them — that is the skeleton's shape; the module header says that
the release's definition asks almost-everywhere measurability and this one measurability, and why — done; generalization 7
goes to the deriver as a question and is not planned here.

### 3.1 The routes, in one paragraph each

**GRAPH (and the definition).** `AeProperOn U c` is nullness of `monoPairSet U c` for `volume ⊗ arcLength`; since the set
reads the angle through `e θ` alone it is null for Lebesgue measure on `ℂ × ℝ` (`aeProperOn_iff_volume`, by
`prod_arcLength_eq_zero_iff_volume`: the set is the union of the integer translates, in the angle, of its part over
`[0, 2π)`). A unit pair `(v, w)` is `(rigidMotion h 0, rigidMotion h 1)` for `h = (v, arg (w − v))`
(`exists_rigidMotion_edge`). A motion `q` carries `v`, `w` into `U` onto one label exactly when `motionMul q h ∈
monoPairSet U c` (`rigidMotion_motionMul`, `mem_monoPairSet_iff_rigidMotion`), and `q ↦ motionMul q h` preserves Lebesgue
measure (`measurePreserving_motionMul_right`: over each angle a translation of the plane, and a translation of the angle —
`MeasurePreserving.skew_product` between two swaps), so those `q` are null (`QuasiMeasurePreserving.preimage_null`, which
asks no measurability of the set). Countably many pairs: `ae_ball_iff`. The motions carrying a compact `K` into an open `U`
are open by the tube lemma (`IsCompact.eventually_forall_of_forall_eventually`) from joint continuity; a non-empty open set
of `ℂ × ℝ` has positive measure, so it meets the conull set of good motions (`Measure.exists_mem_of_measure_ne_zero_of_ae`).

**COUNTABLE.** The same, with the compact set `closure V` and the motion `0`.

**UP.** A finite `V` lies in a disc about `0` of some radius `R`; the hypothesis gives a colouring of a disc of radius `R`
about some `p`, the translation by `p` carries `V` into it, and the one-good-motion lemma colours `V`. De Bruijn–Erdős
(`SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`, as in `chromaticNumber_plane_le_chiM0`) finishes.

**DOWN.** `Outside.OAI158.nonempty_aeColouring_of_colorable` (which is `proper_to_borel_weak` in this library's words)
gives an `AeColouring k`; its colouring is a weak colouring of `univ`, hence of every set.

**FIVE.** UP's contrapositive (`exists_radius_of_not_colorable`) at `Outside.OAI158.not_colorable_five`.

### 3.2 The leaves

*Size is lines of proof. "P1", "P2" = proved in `data/fs124/k1/lean/Probe1.lean`, `Probe2.lean` (to be lifted; the
probes' names carry a `probe_` prefix). Every Mathlib name below was `#check`ed at this pin
(`data/fs124/k1/lean/checks1.lean`, `checks2.lean`), or is used in a probe that elaborates. The order of each file is a
valid order of proof: no leaf uses a later one.*

**`Plane/WeakColouringOn`** (33 leaves, about 150 lines)

| leaf | route | size |
|---|---|---|
| `rigidMotion_apply_zero`, `_apply_one`, `rigidMotion_zero`, `rigidMotion_translation`, `rigidMotion_add_two_pi` | `simp [rigidMotion]`, with `e` unfolded for `e 0 = 1` and `e_add_two_pi` for the last | 1 each |
| `dist_rigidMotion` | `dist_add_left`, `dist_eq_norm`, `← mul_sub`, `norm_mul`, `norm_e` | 2 |
| `continuous_rigidMotion` | P2: `continuous_fst`, `continuous_snd`, `continuous_e` | 3 |
| `continuous_rigidMotion_apply` | `continuous_const.add (continuous_const.mul continuous_id)` | 1 |
| `rigidMotion_motionMul` | P1: `simp only [rigidMotion, motionMul, e_add]; ring` | 1 |
| `exists_rigidMotion_edge` | witness `(v, Complex.arg (w - v))`; `Complex.norm_mul_exp_arg_mul_I (w - v)` with `‖w - v‖ = 1` | 6 |
| `measurePreserving_motionMul_right` | P1: `MeasurePreserving.skew_product` (base: `measurePreserving_add_right volume h.2`; fibre: `measurePreserving_add_right volume (e θ * h.1)`), conjugated by `Measure.measurePreserving_swap` | 12 |
| `measurePreserving_motionMul_left` | `MeasurePreserving.prod` of `z ↦ q.1 + e q.2 * z` — `(measurePreserving_add_left volume q.1).comp (rotation (Circle.exp q.2)).measurePreserving`, with `rotation_apply`, `Circle.coe_exp` — and `measurePreserving_add_left volume q.2` | 10 |
| `prod_arcLength_eq_restrict` | P2: `Measure.volume_eq_prod`, `← Measure.prod_restrict`, `Measure.restrict_univ` | 1 |
| `prod_arcLength_eq_zero_iff_volume` | P2: `Measure.restrict_apply'`; cover by `n = ⌊θ / 2π⌋`, `Function.Periodic.int_mul` on `e_add_two_pi`; each translate null by `(MeasurePreserving.id _).prod (measurePreserving_add_right _ _)` | 28 |
| `mem_monoPairSet_iff_rigidMotion` | P1: `simp [monoPairSet, rigidMotion]` | 1 |
| `monoPairSet_eq_iUnion` | `ext`; both directions by hand (the pattern of `Outside.OAI158.weakColoring_iff_unitPairsNull`'s `hpre`) | 6 |
| `mem_monoPairSet_of_e_eq` | rewrite `e θ` | 2 |
| `aeProperOn_iff_unitPairsNull` | `monoPairSet_eq_iUnion`, `measure_iUnion_null_iff` | 2 |
| `aeProperOn_iff_ae` | `ae_iff`; the two sets are equal (`Classical.not_imp`, `not_not`) | 3 |
| `aeProperOn_iff_volume` | `prod_arcLength_eq_zero_iff_volume mem_monoPairSet_of_e_eq` | 1 |
| `monoPairSet_mono`, `AeProperOn.mono` | term; `measure_mono_null` | 1 each |
| `aeProperOn_congr` | the two sets are equal: both ends lie in `U` | 5 |
| `aeProperOn_of_proper` | the set is empty: `dist x (x + e θ) = 1` (`dist_eq_norm`, `sub_add_cancel_left`, `norm_neg`, `norm_e`) | 5 |
| `aeProperOn_of_proper_off_null` | `monoPairSet U c ⊆ N ×ˢ univ ∪ (fun q => motionMul q (1, 0)) ⁻¹' (N ×ˢ univ)`; `Measure.prod_prod`; `measurePreserving_motionMul_right (1, 0)`; back to `arcLength` by `prod_arcLength_eq_restrict` and `Measure.restrict_le_self` | 12 |
| `AeProperOn.comp_rigidMotion` | `monoPairSet (g⁻¹ U) (c ∘ g) = (motionMul g ·) ⁻¹' monoPairSet U c`; `aeProperOn_iff_volume` twice; `measurePreserving_motionMul_left` | 6 |
| `isWeakColouringOn_univ_iff` | `aeProperOn_iff_unitPairsNull`, `univ_inter` | 4 |
| `AeColouring.isWeakColouringOn`, `IsWeakColouringOn.exists_aeColouring`, `.mono`, `.comp_rigidMotion` | terms | 1–2 each |
| `exists_isWeakColouringOn_ball_iff` | `comp_rigidMotion` with `(p, 0)` and `(-p, 0)`; `rigidMotion (p, 0) ⁻¹' ball p R = ball 0 R` | 10 |
| `exists_isWeakColouringOn_iff_subtype` | `→`: restrict (`measurable_subtype_coe`), `aeProperOn_iff_ae`; `←`: `fun z => if h : z ∈ U then c ⟨z, h⟩ else 0`, `Measurable.dite`, `dif_pos` | 15 |

**`Plane/Radius`** (16 leaves, about 90 lines)

| leaf | route | size |
|---|---|---|
| `exists_isWeakColouringOn_seven` | `r7_aeColouring`, `AeColouring.isWeakColouringOn` | 2 |
| `AeProperOn.ae_rigidMotion_edge` | P1, from `aeProperOn_iff_volume.mp hc` | 8 |
| `AeProperOn.ae_rigidMotion` | `ae_ball_iff hV` twice; `exists_rigidMotion_edge`; the edge lemma | 10 |
| `AeProperOn.ae_rigidMotion_arcLength` | `prod_arcLength_eq_restrict`, `ae_restrict_of_ae` | 2 |
| `aeProperOn_iff_ae_rigidMotion` | `aeProperOn_iff_ae`, the two `_apply_` lemmas | 2 |
| `isOpen_setOf_mapsTo_rigidMotion` | P2 | 5 |
| `AeProperOn.exists_rigidMotion` | `IsOpen.measure_pos` on the motions carrying `closure V` into `U`; `Measure.exists_mem_of_measure_ne_zero_of_ae` with `ae_restrict_of_ae`; `subset_closure` | 10 |
| `colorable_induce_of_forall_ne` | `SimpleGraph.Coloring.mk` | 3 |
| `AeProperOn.colorable_induce` | `exists_rigidMotion` with `g₀ = 0`, `hV.isClosed.closure_eq`, `hV.isCompact`, `hV.countable` | 8 |
| `radius_graph` | the three pieces | 8 |
| `radius_countable` | `exists_rigidMotion` with `g₀ = 0` | 3 |
| `colorable_plane_of_forall_finite` | `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`, as in `chromaticNumber_plane_le_chiM0` | 6 |
| `colorable_induce_of_forall_aeProperOn_ball` | `hV.isBounded.subset_ball_lt 0 0`; `g₀ = (p, 0)`, `rigidMotion_translation` | 12 |
| `colorable_plane_of_forall_aeProperOn_ball`, `exists_radius_of_not_colorable`, `radius_up` | the above; `by_contra`, `push Not`; `SimpleGraph.chromaticNumber_le_iff_colorable` | 1, 4, 5 |

**`Plane/RadiusOutside`** (8 leaves, about 30 lines)

| leaf | route | rests on |
|---|---|---|
| `isWeakColouringOn_univ_iff_weakColoring` | `isWeakColouringOn_univ_iff`, `Outside.OAI158.weakColoring_iff_unitPairsNull` | no axiom |
| `exists_isWeakColouringOn_univ_iff` | the two bridges of `Plane/WeakColouringOn` | no axiom |
| `exists_isWeakColouringOn_of_colorable`, `radius_down` | `Outside.OAI158.nonempty_aeColouring_of_colorable` | `proper_to_borel_weak` |
| `radius_five` | `exists_radius_of_not_colorable`, `Outside.OAI158.not_colorable_five` | `no_proper_five_coloring` |
| `exists_radius_no_weak_four` | the same at `isEmpty_coloring_plane_four` | no axiom |
| `colorable_iff_forall_ball` | `radius_down`, `radius_up` | `proper_to_borel_weak` |
| `seven_le_chromaticNumber_plane_iff_exists_ball` | `add_one_le_chromaticNumber_iff_not_colorable (n := 6)`, the line above, `push Not` | `proper_to_borel_weak` |

**What is hard.** Nothing is deep. Where a first attempt may miss: the shape of `ae_ball_iff`'s predicate (state `p`
explicitly); the function equality under `measurePreserving_motionMul_left` (`funext`, `rotation_apply`, `Circle.coe_exp`);
the decidability instance for `Measurable.dite` (`open Classical in`, or `Classical.decPred`); the cast in `7 ≤ χ ↔ ¬
Colorable 6`. `volume : Measure (ℂ × ℝ)` is `volume.prod volume` by `Measure.volume_eq_prod` and by `rfl`; the instance
`IsOpenPosMeasure` for it is found (`Measure.prod.instIsOpenPosMeasure`).

**The price so far**: seven leaves of the 57 — the composition law, right multiplication, the motion reading of the
monochromatic pairs, the one-edge lemma, the measure identity, the periodicity lemma, openness: the ones I expected to cost
most — are proved in the two probes, 80 lines, each on its first or second attempt, in under twenty minutes of work. The
module is about 270 lines of proof. Stage 5 measures it in the build.

### 3.3 The pass on the obligations (`debruijn-obligation-modeling`, run fresh)

No induction anywhere; every global claim reduces to a local one named above (a countable family of null sets; one
measure-preserving map; one neighbourhood per point of a compact set; one finite graph). Two statements changed shape:

- **The periodicity lemma's hypothesis.** First draft: `S` invariant under `θ ↦ θ + 2π`, which needs an induction over `ℤ`
  to reach `θ − 2πn`. The statement the proof derives from is that `S` reads the angle **through `e θ` alone**
  (`e θ = e θ' → (x, θ) ∈ S → (x, θ') ∈ S`): `Function.Periodic.int_mul` then gives every integer at once, and each use
  site discharges it by rewriting `e θ`.
- **The measure identity `prod_arcLength_eq_restrict`** is named as its own leaf: the periodicity lemma, the
  each-motion-once corollary and the null-set lemma all pass through it.

Mutations tried on paper, each breaking the statement as it should: GRAPH without `IsOpen U` (`U` a closed disc, `V` a
boundary point: the motions are not open); COUNTABLE without `IsOpen U` (`U = {0, 1}`, a constant colouring: weak, since
`U` is null, and no motion separates `0` from `1`); UP with one radius instead of every radius (a disc of radius `1/2`
has a weak one-colouring); FIVE at seven colours (false: R7; kept as an `example`); the subtype form without `k ≥ 1`
(`k = 0`, `U = ∅`). The partition: everything is proved; the spec examples are the tests; nothing is assumed beyond the
two declared outside theorems, each used once.

### 3.4 The pass on the surface (`debruijn-experience-modeling`, run fresh)

Three consumers, and what each reaches for:

- **An exclusion on a disc** holds `hc : IsWeakColouringOn (ball p R) c` and wants a contradiction from a finite
  configuration. `AeProperOn.colorable_induce` was missing — the third conjunct of `radius_graph` is not something to dig
  out of a conjunction — and is added; `Plane/Radius` ends with the consumer's path as an `example` through public lemmas
  alone. For density arguments: `aeProperOn_iff_unitPairsNull` lands in the library's `UnitPairsNull` vocabulary.
- **A fragment on discs of every radius** must *produce* `AeProperOn`. `aeProperOn_of_proper_off_null` (proper off a null
  set, no measurability) is added for it; `aeProperOn_of_proper` is its case `N = ∅`. It then cites
  `colorable_plane_of_forall_aeProperOn_ball`.
- **The front page** cites `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`. Each
  docstring now says which half needs the import. For the second: *seven ⟹ some disc has no weak six-colouring* is UP's
  contrapositive and needs none; ***a disc with no weak six-colouring ⟹ seven* needs `proper_to_borel_weak`**. So an
  exclusion on a disc proves seven only through the transfer, and a six-colouring of every disc proves six with no import.

Names: `rigidMotion_apply_zero`, `rigidMotion_apply_one` (the motion at a point) and `rigidMotion_zero` (the parameter
`0`), so that `rigidMotion_zero` means what the convention predicts; `simp` is given those three and nothing else. The
three claims keep claim-keyed names (`radius_graph`, `radius_countable`, `radius_up`, `radius_down`, `radius_five`), as
this library's row-keyed theorems do; every piece a consumer applies has a name that states it. Docstrings assert only
what a theorem backs: that every orientation-preserving isometry is a `rigidMotion`, and that the parameters cover the
group, are marked "not proved here".

### 3.5 For the landing (the implementer's job and the coordinator's files)

- **`scripts/Axioms.lean`** (not touched by this job). CLEAN: the public surface of `Plane/WeakColouringOn` and
  `Plane/Radius`, and of `Plane/RadiusOutside` the three marked "no axiom". IMPORTED on
  `Outside.OAI158.proper_to_borel_weak`: `exists_isWeakColouringOn_of_colorable`, `radius_down`,
  `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball`. IMPORTED on
  `Outside.OAI158.no_proper_five_coloring`: `radius_five`. No record rests on both. **The audit is the check of § 3.4's
  sentence about halves**: `radius_up` and `exists_radius_of_not_colorable` must print the standard three.
- **`scripts/Assumptions.lean`**: no new entry is expected. Every hypothesis here is a condition on the theorem's own `k`
  (`radius_up`'s family of colourings, `exists_radius_of_not_colorable`'s `¬ Colorable k`, `radius_down`'s `χ ≤ k`); none
  is closed. The count `rests=` rises by five; the nine counts in `CLAUDE.md` § Trust ledger are the coordinator's to
  refile.
- **Vacuity.** The binders are `c : ℂ → Fin k` at a free `k` (generic). A later theorem that takes a weak **five**-colouring
  of a large disc, or of the plane, as a hypothesis has an empty domain given `radius_five`; `LEAN.md` § The gate's rule
  for emptiness resting on an import applies to it, not to anything here.
- **Names**: none of the 57 declarations, nor `monoPairSet`, `AeProperOn`, `IsWeakColouringOn`, `rigidMotion`, `motionMul`,
  is declared in `main` or in any worktree under `.claude/worktrees/` (searched 14:0x UTC). `HadwigerNelson.Motion`
  (`Proofs/HadwigerNelson/Motion.lean`, exact motions over `Q4`) is a different object under a different name.
- **`AeColouring.exists_motion`** (`Plane/YesLimit`) is `AeProperOn.exists_rigidMotion` at `U = univ` in the other order
  of parameters. It stays as it is: no statement on the main line is touched.
