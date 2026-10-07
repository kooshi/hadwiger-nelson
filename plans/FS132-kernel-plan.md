# FS-132 — the kernel plan (FS132-K1): seven statements about measurable six-colourings, planned blind, then open

*The planner's record (de Bruijn, branch `fs132-wk1`, worktree `.claude/worktrees/fs132-wk1`). Brief:
`data/fs132/briefs/FS132-K1-kernel-plan.md` (on `main` at `e49499f57`). Claim list: `data/fs132/claims-K1.md` (on `main`; the
worktree was cut at `808ef9bf2`, one commit before it, so the list is read from the main tree). Current state only per stage;
each stage is saved before the next starts.*

## Theorems this phase proved

None in the kernel: a planning job. What it states is the skeleton (stage 3 onward); what it derived by hand, blind, is in the
stages below, each at grade [hand, one mind — the planner's, blind of the derivers'].

**FS132-K2 (stages 4–7), on branch `fs132-wk1`, nothing landed.** Kernel-checked on the standard three axioms, no `sorry`
in their cone (`data/fs132/k2/probe/Axioms.out`): `shiftBounds_model`, `ShiftBounds.mono`, `HubColours.mono`
(`Plane/SixRing/Basic`), `mem_liftPalette` (`State`), `mem_spatialSupport_ae` (`Placeholders`, the release's proof),
`straddle_mono` (`Orbit`), and the half-line model of `NoDoubleChange` (an `example` in `StepLemma`) — definitions' models
and bookkeeping, no claim of the list. **Proved from `sorry` leaves, so not theorems until the leaves are** (their axiom
lists read `sorryAx`, as they must): `no_outside_orbit_points`, `no_outside_orbit`, `not_ae_outside`, `adjacent_tip_false`
(`Orbit`), `chart_step_false` (`Kill`), `exists_shiftBounds` (`Shift`), `no_alternating_groups`, `no_alternating_pairs`
(`TwoPairs`). By hand, one mind, at this job: the variant route for Lemma S and the reading of S5–S7 for the square
(stages 4, 5.3, 6.2) — [hand], kernel pending.

## Stage 1 — SAVED (FS132-K1): the readback

**Quotations.** By script (the brief's seven `> **C132-…` lines against the claim list's lines of the same key, character for
character): 7 of 7 MATCH. Kooshi's two quotations: both found verbatim at their sources (`data/external/EXT-OAI1-request.md`;
`CLAUDE.md` § Counter-priors). No mismatch to report.

**Read in full**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail (to its line
255); the claim list; the import module `Proofs/HadwigerNelson/Outside/OAI158.lean`; the release's manuscript sections
`introduction.tex`, `palettes.tex`, `transitions.tex`, `interfaces.tex`, `angular.tex` (whole, TeX source); `plans/EXT-OAI1-audit.md`
stages 6 and 8. **Read in part** (definitions and statements, not proofs): the release's Lean `Coloring.lean` (whole),
`Palettes.lean` (whole), `Compactness.lean` 75–300, `Transitions.lean` 1–40, `WeakColoring.lean` 110–176,
`AngularBoundary.lean` 140–335, `Interfaces.lean` 1–135 and its declaration list with `no_four_interfaces`.

**The fence.** Not read: the three derivations, the milestone's plan, the inventories, `data/fs132/claims.md`, the Poros and
handoff records, `data/fs132/{e1,e2,e3,p2,reports}`, the other briefs. One disclosed contact, names only: an `ls plans/FS132*`
in the worktree printed the eight file names (`FS132-close-inventory.md`, `FS132-E1…E4-derivation.md`,
`FS132-I1-implementation.md`, `FS132-L1-landing.md`, `FS132-six-by-the-nerve.md`); no content was shown. The milestone's plan's
file name carries the words "six by the nerve", which is a hint of a route (a nerve/covering argument) and is disclosed as such.

**The dictionary the statements are over** (the manuscript's numbering: §1 introduction, §2 transfer, §3 spectral, §4 rigidity,
§5 palettes, §6 transitions, §7 interfaces, §8 angular):

| the claim list's term | the manuscript | the release's Lean (all for a colouring of the whole plane) | general in `k`? |
|---|---|---|---|
| weak measurable `k`-colouring | Def. 1.2 | `WeakColoring k c` (`Coloring.lean:27`) — copied in `Outside.OAI158` | yes |
| typical point; typical circle sampling | §5.1 | `Typical`, `TypicalSampling` (`Compactness.lean:83–85`) | yes |
| trace family `𝒲_x`; palette `P_x(e)` | Def. 5.1 | `IsTrace c hc x b`; `paletteSet`, `palette c hc x t : Finset (Fin k)` (`Palettes.lean`) | yes |
| closed essential support `H_a` | §5.1 | `spatialSupport c i := (volume.restrict {z | c z = i}).support` (`AngularBoundary.lean:308`) | yes |
| straddle set `Δ(K)` | (7.1), eq. source-24 | `Straddle K := {z | ∃ p ∈ K, ∃ q ∈ K, dist z p < 1 ∧ 1 < dist z q}` (`:147`) | no colouring |
| limiting direction of `K` at `x` | Prop. 7.1 (2) | `ApproachingContinuum x K v` (`:235`) | no colouring |
| transition graph `Γ_x`; cyclic centre | Def. 6.1; (6.6) | `TransitionEdge c i j x` (general `k`); `transitionGraph`, `CyclicCore` (`CyclicCore.lean:213–218`, **`Fin 5` only**) | edge yes, graph no |
| sixty-degree exclusion | Cor. 5.3 | `palette_sixty_disjoint` | to be checked (stage 4) |
| palette cardinality `≤ 2` | Prop. 5.5 | `palette_cardinality` (**`Fin 5` only**) | no |
| the four-cycle exclusion | Prop. 8.5 | `no_four_interfaces` (**`Fin 5` only**, `Interfaces.lean:516`) | no |

Two facts the claims force on the definitions, seen at the readback and carried into stage 2:

1. **The claims' colourings live on an open set `U ⊇ B̄(p, 1)`; every definition of the release and of the import is for the
   whole plane.** A palette "read at the centre `p` with samplings inside `U`" is a new definition here, not a copy.
2. **The claims are at six labels; the release's palette-size bound (Prop. 5.5) and its four-cycle argument are proved at
   five**, and the claim list's own not-claimed lines say which steps spend the count ("M2 and M9 spend six").

## Stage 2 — SAVED (FS132-K1): phase 1, blind — the definitions, the statements read back, the planner's routes, the skeleton

*Blind of the three derivations, the milestone's plan, the inventories, `data/fs132/claims.md` and the other fenced paths (stage
1's list; no touch since). Read for this stage, none of it fenced: the claim list with its dated line (on `main` at `2213dbd0c`:
C132-M-ORBIT, -M-EXCL and -DIAG-WIDE are stated for the whole plane first), the release's manuscript and Lean (stage 1's list,
plus `States.lean` 243–248, `PaletteDensity.lean` 143–146 and 435–440, `BoundaryTrace.lean` 182–216, `PlanarCovers.lean` 176–192
and 302–308, the declaration lists of `Interfaces`, `States`, `PaletteDensity`, `PaletteTransport`, `BoundaryTrace`,
`HoleApproximation`, `Mesh`, `GraphRealization`), and this library's `Topology/LebesgueCovering.lean` (statements). Everything in
this stage that is not a build result is by hand, one mind (the planner's).*

### 2.1 The definitions, and whether each is copied or stated here

| object of the claims | in the skeleton | copied or stated | why | model / drift check |
|---|---|---|---|---|
| weak measurable `k`-colouring of the plane | `Outside.OAI158.WeakColoring k c` with `Measurable c` | already copied by the import | the claim list's dated line: whole plane first | `proper_to_borel_weak_model` (`k = 7`) |
| typical point, typical sampling, trace, **palette `P_x(e)`** (Def. 5.1) | `Typical`, `TypicalSampling`, `IsTrace`, `paletteSet`, `palette c hc x t : Finset (Fin k)` in `Outside/OAI158Palette` | **copied with their proofs, by script** (`tools/fs132_k1_port.py`; `--check` compares the file with the generated text) | the claims name the release's Definition 5.1; the definition needs four lemmas to be well formed (`sample_norm_le`, `sampleFn_memLp`, `WeakBall.ofNorm`'s bound, `exists_countable_essential_union`); and an outside theorem about palettes can be declared only over the release's own term | `palette_nonempty` (ported, proved): the palette is non-empty a.e. at every centre |
| closed essential support `H_a` | `spatialSupport c i := (volume.restrict {z | c z = i}).support` | copied (`AngularBoundary.lean:308`) | same | — (Mathlib's `Measure.support`) |
| straddle set `Δ(K)` | `Straddle K` (witness form) | copied (`AngularBoundary.lean:147`) | same; `SixRing.mem_straddle_iff_min_max` proves it is the claim's `min < 1 < max` for a non-empty compact `K` | two `example`s in `Plane/SixRing/Confine` (`1/2 ∉ Δ{0}`, `1/2 ∈ Δ{0, 2}`) |
| rotation by `π/3` | `t + (sixty : Angles)`, `sixty := π/3` | copied (`PaletteTransport.lean:390`) | — | — |
| transition edge; **transition graph and cyclic centre at every `k`** | `TransitionEdge` copied (`Transitions.lean:23`); `SixRing.transitionGraph`, `SixRing.CyclicCentre` **stated here** | the release's graph and core are typed at `Fin 5` only (`CyclicCore.lean:213–218`); ours is the same text at `Fin k` | symmetry proved in the definition |
| the triangle of three labels, a loop's degree, a ring's walk | `triPoint`, `triSupport`, `RingLift`, `ringBoundary` | stated here | no counterpart in the release | `indexModel`, `ringModel` (specs are leaves) |

**A weak colouring of an open set `U`** is not defined: by the dated line the local form is not planned in this job. What a
port with the changed hypothesis would take is 2.6.

### 2.2 The statements, read back against their words

**C132-M-ORBIT** → `SixRing.no_outside_orbit` (`Plane/SixRing/Orbit.lean`). Clause by clause, at `U = ℂ`:
- "c a weak measurable six-colouring" — `(hc : Measurable c) (hw : WeakColoring 6 c)`. Borel where the claim says measurable: the
  release's convention; a Lebesgue-measurable colouring agrees a.e. with a Borel one and no object here sees a null set.
- "a_0, …, a_3 four of the labels and X, Y the other two" — `a : Fin 4 → Fin 6` injective, `X ≠ Y`, `a j ≠ X`, `a j ≠ Y`.
- "for each j modulo 4, K_j a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and
  H_{a_{j+1}} ∩ Δ(K_j) = ∅" — the structure `FourCycleStraddle c p a K`, five fields, `j + 1` in `Fin 4`.
- "there are no angle ψ and number δ > 0 such that (i) … and (ii) …" — `(ψ δ : ℝ) (hδ : 0 < δ) (hi) (hii) : False`.
- (i) "for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) contains X or Y" —
  `∀ k : ℤ, ∀ᵐ θ : ℝ, |θ - ψ - k * (π / 3)| < δ → X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles)`
  (Lebesgue measure on `ℝ`; `e(θ)` is `direction (θ : Angles)`, the palette's argument is the angle).
- (ii) "for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both
  have positive measure" — `∀ η > 0, 0 < volume {θ ∈ Ioo (ψ − η) (ψ + η) | X ∈ palette …} ∧ 0 < volume {… Y …}`.
- *Not claimed*, checked: the Lean statement says nothing when (i) fails on a set of positive measure near one of the six
  directions (it is a hypothesis); does not assert a six-colouring exists (it is a refutation; its docstring says the hypothesis'
  satisfiability is the open question); says nothing of the transition graph; is at `Fin 6` only; the cycle has four labels.
- **What the typing shows that the words leave implicit.** (a) `K_j` is not asked to be connected, nor to have points
  approaching `p`: `{p, q}` satisfies the clause. (b) Nothing says the labels `a_j` occur near `p` (a label never used has empty
  support and satisfies every exclusion). (c) The palette is defined up to a null set of directions through a chosen countable
  family (`paletteGenerators`, by `Classical.choose`); (i) and (ii) are a.e. and positive-measure statements, so the choice does
  not matter — to be proved once, as `palette`'s a.e.-uniqueness (`paletteSet_minimal` is the release's lemma for it).

**C132-M-EXCL** → `SixRing.not_ae_outside`: same binders, conclusion `¬ ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette
c hc p t` ("it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y"; a.e. for the normalized
angular measure on the circle of angles, the same null sets as arc length). *Not claimed*, checked: binary only for the pair
outside the cycle.

**C132-DIAG-WIDE** → `SixRing.no_alternating_pairs`: `D D' : Finset (Fin 6)`, `D.card = 2`, `D'.card = 2`, `Disjoint D D'`;
"a measurable map w from the unit circle to {D, D′}" is a measurable `w : Angles → Bool` (`false ↦ D`, `true ↦ D'`; the two
values differ since the pairs are disjoint and non-empty); "w(e) ⊂ P_p(e)" is `(if w t then D' else D) ⊆ palette c hc p t`
a.e.; "w(Re) ≠ w(e)" is `w (t + sixty) ≠ w t` a.e. *Not claimed*, checked: a third state is excluded by `w` being two-valued;
seven labels by `Fin 6`.

**C132-CONFINE** → `SixRing.confine_of_disjoint`, `subset_closedBall_of_dist_lt`, `inner_nonneg_of_subset_closedBall`,
`inner_nonpos_of_disjoint_ball` (`Plane/SixRing/Confine.lean`, **proved**, built). "K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅" is `K ⊆
closedBall z 1 ∨ Disjoint K (ball z 1)`; the sequence clause is `q : ℕ → ℂ`, `q m ∈ K`, `q m ≠ x`, `q → x`,
`(‖q m − x‖⁻¹ : ℝ) • (q m − x) → v`, and `v · (z − x)` is the real inner product on `ℂ`. *Not claimed*, checked: no statement
decides the case; the `example` exhibits `K = {0}`, `z = 1` in both cases; no colouring occurs.

**C132-CORES-FREE** → `SixRing.exists_cyclicCentre`: `(hk : 1 ≤ k)`, `Measurable c`, `WeakColoring k c`, `1 < ρ`, conclusion
`∃ x ∈ closedBall o ρ, x ∈ CyclicCentre c`, where a cyclic centre is a point whose transition graph is not acyclic
(`[OAIMath2026]` (6.6) at `k` labels). *Not claimed*, checked: radius `> 1` strictly; no continuum; whole plane.

**C132-INDEX** → `SixRing.index_degree` (lift form) and `SixRing.index` (the claim's form over any lift). "Θ the union of the
edges ab, bc, ca of the simplex of probability vectors" is `Set.range triPoint ⊆ (ZMod 3 → ℝ)` (labels `a, b, c` are `0, 1, 2`,
orientation `0 → 1 → 2`); "no label has a positive coordinate both at φ(e) and at φ(Re)" is `∀ t i, ¬ (0 < φ t i ∧ 0 < φ (t +
sixty) i)`; "the degree of φ" is the integer `d` of a continuous lift `f` with `f (θ + 2π) = f θ + 3 d` (`exists_triLift`: one
exists; `triLift_degree_unique`: `d` is the loop's). *Not claimed*, checked: `φ` continuous; three labels.

**C132-RING-WIND** → `SixRing.ring_arc`, `ring_consecutive`, `ring_winding`, with `ringLift_degree_unique`. "Π a measurable
function from S to the non-empty subsets of N" is `P : Angles → Finset (ZMod 3)` with every fibre measurable and every value
non-empty; "J" is `ringBoundary P`; "no two of its points are at angle π/3" is `∀ t ∈ J, t + sixty ∉ J`; "the closed walk they
make around the triangle on N has winding number ≡ 3 mod 6" is `∃ F d, RingLift P F d ∧ d ≡ 3 [ZMOD 6]`, `RingLift` being a lift
through vertex and mid-edge positions that stays in one closed edge near every angle (so it is constant on each arc and a change
runs inside one edge), `d` its degree. *Not claimed*, checked: `J` finite and the `π/3` condition are hypotheses; three labels.

### 2.3 The planner's routes (blind), per statement

**C132-CONFINE — TRUE, proved in the skeleton.** The dichotomy is the negation of membership in `Straddle K`; the direction
clauses are `‖q − z‖² = ‖q − x‖² − 2⟨q − x, z − x⟩ + 1` and a limit. **Wider than claimed**: `K` any set (no compactness, no
connectedness); the direction clauses use neither `H` nor `x ∈ K`.

**C132-DIAG-WIDE — TRUE at `U = ℂ` given the release's `two_state_impossible`, of which it is an instance** (`States.lean:243`,
every `k`, any `J`, `K` with `(univ \ (J ∪ K)).card ≤ 2`). My own derivation before finding that statement was the manuscript's
Lemma 6.4 argument with two pairs in place of a singleton and a pair (the angle `γ`, `cos γ = 5/6`, irrational over `π`; a
positive-measure set of `t` with `w(t) = w(t + γ)`; the unit equilateral triangle `p + e(t + 2jπ/3)(1 − e^{iγ})` at distance
`1/√3` from `p`, each vertex a sum of two directions in opposite states, so of density zero for the four labels of `D ∪ D′`; a
small common translation makes the three vertices typical with only two labels left). It is the release's proof. **Leaves**:
`no_alternating_groups` (reword `RealState` on `ℝ` as a.e. on `Angles`, `Real.pi / 3` as `sixty`), `no_alternating_pairs`
(`card (univ \ (D ∪ D')) = 6 − 4`).

**C132-INDEX and C132-RING-WIND — TRUE, one lemma (`sixStep`), and RING-WIND does not use INDEX.** With `triSupport x` the
labels positive at position `x`: disjoint supports at `x`, `y` force `y − x ∈ [1, 2] + 3ℤ` (`step_mem_of_disjoint`: inside an
edge at `x` the only allowed `y` is the opposite vertex; at a vertex `x` the opposite closed edge), and a step at an end of its
interval forces `x` at a vertex (`fract_eq_zero_of_step_end`). For a lift `f` of degree `d`, `g(θ) = f(θ + π/3) − f(θ)` then
lies in one interval `[1 + 3m, 2 + 3m]`: for continuous `f` because `g` is continuous and the intervals are disjoint; for a
ring's step lift because each jump of `f` is at most `1`, jumps of `f` and of `f(· + π/3)` never coincide (that is the
hypothesis on `J`), and the intervals are `2` apart. Six consecutive steps sum to `3d ∈ [6 + 18m, 12 + 18m]`. If `g ≡ 1 + 3m`
or `g ≡ 2 + 3m` a.e.: in the continuous case `f` is vertex-valued everywhere, so constant, so `g = 0`; in the ring case `f` has
no jump (a jump of `f` not matched at `π/3` changes `g`), so `J = ∅`, `Π` is a.e. one set and meets its rotate. Hence
`d = 3 + 6m`. The first two conclusions of RING-WIND: a.e. `|Π| ≤ 2` (a triple leaves nothing for the rotate); at `j ∈ J` the
ring is a.e. one set `T` near `j + π/3` (not in `J`), so both arcs at `j` lie in `N ∖ T`, a pair. **Models**: `indexModel`
(ramp one edge in `π/9`, rest `π/9`; the uniform degree-3 loop fails the hypothesis); `ringModel` (nine sectors of `2π/9`
labelled `0, 1, 2` three times; the ring of `indexModel` is not a model — its changes at `θ` and `θ + π/3` coincide).
**Leaves**: the sixteen `sorry`s of `Plane/SixRing/Winding.lean`, in file order; `exists_triLift` needs path lifting for the
covering `triPoint : ℝ → Θ` (Mathlib's covering-space API; not `#check`ed — the one leaf here I have not priced).

**C132-CORES-FREE — route: the release's §7.2–7.3 with no core disc, and the cover step from this library's Lebesgue covering
theorem.** On a compact region `Q` with no cyclic centre every `Γ_z` is a forest; Lemma 7.3 (missing edge → small overlap, any
`k`: the release's `missing_edge_disk_cover` is already at `Fin k`) and the tree fillings (Lemma 7.4 with `L_0 = ∅`) give
continuous `g_n : Q → K_k` equal to the thresholded disc averages off discs of total radius `→ 0`; the components of
`{(g_n)_i > 0}` cover `Q` with multiplicity two; Lemma 7.6's argument (a component joining two points more than `1 + c` apart
puts a point of `H_i` in a ball where `p_i^ε ≤ 1 − α` off a set of vanishing area) bounds the mesh by `1 + o(1)`. A closed
square of side `s > 1` has no such cover: `no_fine_cover_square`, from `LebesgueCovering.lebesgue_covering_square` (kernel,
FS-131) after a closed shrinking of a finite subcover. **So the claim holds for every closed square of side above `1`, hence
every closed disc of radius above `1/√2`** (`exists_cyclicCentre_square`; the claim's form is derived from it in the skeleton).
What I did not re-derive: Lemmas 7.3, 7.4, 7.6 at general `k` — read, and I see no use of five beyond `α < 1/5 → α < 1/k`.

**C132-M-EXCL — from C132-M-ORBIT** (`not_ae_outside`, proved in the skeleton from two leaves). If a.e. palette holds `X` or
`Y`, the sixty-degree exclusion (`palette_sixty_disjoint`) makes exactly one present a.e., alternating under `R`; both sets have
positive measure; their closed essential supports cover the circle and are non-empty, so they meet at some `ψ`
(`exists_change_of_ae_outside`); (i) holds for every `δ`, (ii) at `ψ`.

**C132-M-ORBIT — OPEN IN PHASE 1 past its first-order steps.** Notation: `e_k = e(ψ + kπ/3)`, `z_k = p + e_k`, `s(α) ∈ {X, Y}`
the outside label of the palette at `e(ψ + α)`, `|α| < δ` (well defined a.e.: by (i) and `palette_sixty_disjoint` exactly one of
`X`, `Y` is present, the same one at even positions of the orbit and the other at odd ones).
- **S1 (chart).** `(α, β) ↦ p + e(ψ + α) + e(ψ + 2π/3 + β)` is a diffeomorphism of a neighbourhood of `0` onto one of `z_1`;
  the image has radius above `1` iff `β < α`, angle `ψ + π/3 + (α + β)/2`; `α < 0` iff inside the unit disc about `z_0`,
  `β > 0` iff inside the one about `z_2`. By `palette_transfer_pair` the colour at the image avoids `{s(α), s(β)}` for a.e.
  `(α, β)`. The same at every `z_k` (directions near `e_{k−1}`, `e_{k+1}`).
- **S2 (strips, for the hypothesis as typed).** For `q ∈ K_j`, `q ≠ p`: where `|p + e − q| < 1` a strip just outside the unit
  circle near `e` lies in `Δ(K_j)`; where `> 1`, a strip just inside (the release's `outer_straddle_strip`,
  `inner_straddle_strip`: geometry, no approach sequence). So off at most two directions per `q`, each edge `j` removes
  `a_j, a_{j+1}` from the outer or from the inner strip.
- **S3 (an unsplit orbit direction is rigid).** If near `e_1` (on one side of it, when `e_1` is a boundary direction of S2) the
  outer strip admits no cycle label, then for a.e. `(α, β)` with `β < α` the colour is `X` or `Y` and avoids `s(α)`, `s(β)`,
  so `s(α) = s(β)`; by symmetry of the pair, `s` is a.e. constant near `0`, against (ii). The same inside. Hence on each side
  of each `e_k` the edges whose outer strip is present do not cover the four cycle labels, nor do those whose inner strip is;
  every edge has one of the two; so they are two complementary pairs of adjacent edges (a finite check on `Fin 4 → Bool`, the
  release's `interface_four_split` in shape), and on `{s(α) ≠ s(β)}` the colour is one forced cycle label inside the ring
  (`a_in(k)`, the common end of the two "outer" edges) and the opposite one outside. That set has positive measure on both
  sides of the ring in every neighbourhood of `z_k`, since `s` is not a.e. constant.
- **S4 (count).** When the `K_j` approach `p` in directions `v_j` (not given by the claim as typed), each edge is "outer" at
  exactly three consecutive orbit directions, the six pairs are determined by the four hexagon sectors holding the `v_j`, and
  in every case two adjacent orbit points `z_k`, `z_{k+1}` carry the same pair `(a_in, a_out)`.
- **S5 (where I stop).** S1–S4 are consistent to first order: I found no contradiction among the forced wedges at
  neighbouring orbit points, nor between them and `p` (checked for interface directions within `30°` of
  `ψ + {0°, 60°, 180°, 240°}`). When `s` changes cleanly at `ψ` (`X` a.e. on one side, `Y` on the other) there is a
  second-order contradiction between `z_k` and `z_{k+1}` of S4: inside the ring, the region just outside the unit disc about
  `z_{k+1}` near `z_k`, and the region just outside the unit disc about `z_k` near `z_{k+1}`, are both forced to one outside
  label (not the other outside label by S1; not `a_in` because `a_in` near either point must keep within distance `1` of the
  `a_in` wedge at the other; no other cycle label by S3), and they contain unit pairs: the points at radius `1 − t` on the two
  bounding arcs are at distance `1 − (4/3)t² + O(t³)`. **For a general measurable `s` I have no argument**, and without the
  directions `v_j` S4 is not available as stated. An argument from the palettes at `p` and the strips alone cannot close it
  (my reading of the first-order data; not a model).

### 2.4 The skeleton

| module | lines | `sorry` | built (`build.sh`, `data/fs132/k1/probe/build-phase1.out`: exit 0, 6 modules rebuilt, warnings only `declaration uses sorry`, 29) |
|---|---|---|---|
| `Outside/OAI158Palette` (generated) | 818 | 0 | yes, no warning |
| `Plane/SixRing/Confine` | 128 | 0 | yes, no warning |
| `Plane/SixRing/Winding` | 178 | 16 | yes |
| `Plane/SixRing/Orbit` | 168 | 10 (5 OUTSIDE placeholders, `no_alternating_groups`, `no_alternating_pairs`, `no_outside_orbit`, `exists_change_of_ae_outside`, `ae_real_of_ae_angles`) | yes |
| `Plane/SixRing/CyclicCentre` | 85 | 3 | yes |

`Proofs.lean` and `ARCHITECTURE.md` carry the five modules (`tools/check_architecture.py`: PASS). Nothing here reaches `main`
with a `sorry`. Not run: `axioms.sh`, `vacuity.sh`, `assumptions.sh`, the linters — a skeleton is not a landing.

### 2.5 The outside statements, and the price from the pieces tried (preliminary; final form is phase 2's)

**Stood on, by their Lean names in the release** (all for every `k`, all for the whole plane):

| release statement | file:line | used by | declare or port |
|---|---|---|---|
| `two_state_impossible` | `States.lean:243` | C132-DIAG-WIDE (all of it) | either; declared needs `RealState`, `liftPalette` (copied here) |
| `palette_sixty_disjoint` | `PaletteTransport.lean:450` | M-EXCL's reduction, M-ORBIT S1 | either |
| `palette_transfer_pair` | `PaletteDensity.lean:143` | M-ORBIT S1 | either; needs `angularSum` (copied) |
| `outer_strip_trace`, `inner_strip_trace` | `BoundaryTrace.lean:182, 210` | M-ORBIT S2–S3 | either |
| `weak_density_proper`, `ae_density_actual`, `palette_nonempty`, `exists_trace` | `WeakColoring.lean`, `Compactness.lean`, `Palettes.lean` | everything | **already ported** (in `Outside/OAI158Palette`, proved) |
| `missing_edge_disk_cover`; the hole maps and the mesh bound | `PlanarCovers.lean:146`; `GraphRealization`, `HoleApproximation`, `DiskExtension`, `Mesh` | C132-CORES-FREE | **port with a changed type** (`Fin 5 → Fin k`, a square in place of the disc of radius 5): not declarable — the release does not state them at `k` |

**The price, from the two pieces tried.** (1) *A port of release files that are already at `Fin k`*: 620 lines of three files
(`WeakColoring`, `Compactness`, `Palettes` §1) elaborated at this pin after **one** Mathlib signature patch
(`eLpNorm_one_eq_lintegral_enorm` takes no explicit argument at v4.32.0) and one import to find; about fifteen minutes of
agent work, build 7.8 s. On that sample the backport costs about one fix per 600 lines; the audit's table (stage 8) priced
`palette_cardinality`'s cone at "two jobs; about 3,600 lines" — on this rate the general-`k` part of that cone
(`PaletteDensity`, `PaletteTransport`, `BoundaryTrace`, `States` to line 310: about 1,700 lines, with `CircleMaps`,
`CircleTransport`, `Transitions`' Fourier input below them) is **one job, and porting is cheaper than the read-back of five
separate axioms**. My recommendation, to be confirmed in phase 2 against what the derivers' routes need: **port, do not
declare**, the palette lemmas; the two imports stay the only axioms. The unknown is `Transitions.lean`'s input
(`PlaneSpectrum.Fourier → CircleDecay → CircleOperator`), which `palette_transfer_pair` does not need and
`transition_avoiding_trace` does. (2) *A leaf of ours*: C132-CONFINE, six statements, 128 lines, three iterations (one
notation difference: `⟪x, y⟫` carries no `_ℝ` at this pin), proved.

**Leaves per statement** (phase 1): CONFINE 0 left (done). DIAG-WIDE 2, both rewording. INDEX 9 (5 finite/real-arithmetic, 1
covering lift, 1 uniqueness, 2 model). RING-WIND 6 (measure theory on the circle; 1 model). CORES-FREE 3 stated
(`no_fine_cover_square`: topology, from the library; `closedSquare_subset_closedBall`: arithmetic; `exists_cyclicCentre_square`:
the port of §7.2–7.3 at `k`, the large one — its sub-leaves are phase 2's). M-EXCL 2 (`exists_change_of_ae_outside`,
`ae_real_of_ae_angles`: measure theory). M-ORBIT: S1–S3 are leaves an implementer could start (analysis: a chart, a
change of variables, a.e. arguments; one finite check); S4–S5 are not plannable from what I have.
**What an implementer starts with tomorrow**: the port job for the palette lemmas (it unblocks DIAG-WIDE entirely and S1–S3),
and `Winding.lean` (self-contained, no dependence on anything open).

### 2.6 The local form (`U` open, containing the closed unit disc), not planned — what a port would take

No statement of the release applies to a colouring of `U`. A local form needs: (1) `WeakColoringOn U` (the a.e. condition for
pairs with both ends in `U`) over a total measurable `c` — a colouring of `U` extends by a constant, and the release's `palette
c hc p` then reads only samplings near the unit circle about `p`, which lie in `U`; (2) `weak_all_directions` and
`weak_density_proper` for pairs inside `U` (the translation-continuity argument on a bounded open set); (3) every palette lemma
used re-proved with its sums `p + e + v` restricted to `U` — `palette_transfer_pair` ranges over the disc of radius `2`, so
its statement changes, not only its proof; (4) the strips, unchanged (they are inside any neighbourhood of the unit circle).
In my route's terms the statements S1–S5 only ever look inside `B(p, 1 + η)`, so the local form is the same plan over
restricted lemmas; in cost it is the palette port done twice in the files `WeakColoring`, `PaletteDensity`, `BoundaryTrace`.

### 2.7 Findings sent to the coordinator mid-phase (two messages, logged there as the planner's, at this grade)

1. The hard leaf (S5), and that first-order data cannot close M-ORBIT (my reading).
2. The hypothesis question: `K_j` as typed admits two-point sets.
3. Generalizations: CONFINE for every set `K`; INDEX and RING-WIND from one lemma, RING-WIND without INDEX; the INDEX model.
4. DIAG-WIDE is an instance of the release's `two_state_impossible` (attribution owed; my "generalization" of it is theirs).
5. CORES-FREE holds for squares of side above `1`, so discs of radius above `1/√2`, by this library's Lebesgue covering
   theorem; the release's cover lemma need not be ported.
6. The import question for a colouring of `U` (ruled: whole plane first).

## Stage 3 — SAVED (FS132-K1): phase 2, open — C132-M-ORBIT and C132-M-EXCL against the derivers' argument; the four-point form; C132-CORES-SQUARE stated

*The fence lifted by the coordinator's reply to the phase-1 commit `1eb4b94b0`. Read for this stage:
`plans/FS132-E3-derivation.md` (from `origin/main`), Stage 3 § "Argument — the orbit form", steps M0–M9, lines 166–306, whole.
**Not read** (budget): the rest of that record, `FS132-E1`, `-E2`, `-E4`, `-E5`, `-E6`, the milestone's plan, the inventories,
`data/fs132/claims.md`. What the coordinator's reply says of them is quoted as the coordinator's, not checked.*

### 3.1 The two routes, compared

| step | the planner's blind route (2.3) | the derivers' (`FS132-E3` Stage 3) | which the skeleton carries, and why |
|---|---|---|---|
| the state `s`, alternating | (a), S1 | M1 | one step; theirs is mine |
| the chart, the colour avoids `{s(α), s(α − d)}` | S1, chart `(α, β)` about `z_1` | M2, chart `Z(α, d) = e(α) + e(α − 2π/3 − d)` (`d > 0` iff inside the ring) | **theirs**: `d` is the radial coordinate, and M7's relation is `α′ = α + π/3 + d′ + ε(d, d′)` independent of `α` |
| a forced inner label at each hub | S2–S3: strips of the `K_j` (`outer_strip_trace`, `inner_strip_trace`), a finite check on sign patterns, both sides of the ring | M3–M5: `Tip(k)`, confinement of a tip's two sets to `B̄(y_k, 1)` by C132-CONFINE, `B̄(y) ∩ B̄(−y) = {p}`; one tip per hub, opposite at antipodes; inside the ring only | **theirs**: no strip lemma, no boundary directions, nothing outside the ring; reads one point of each set besides `p` |
| two adjacent hubs with one label | S4: a count over hexagon sectors, needing limiting directions `v_j` | M6: the signs of `q_j · e(ψ_k)` against three axes, `e(ψ_1) = e(ψ_0) + e(ψ_2)`; a check on 64 patterns | **theirs**: mine is not available for the statement as typed |
| the unit-pair relation between adjacent hubs | S5: distance `1 − (4/3)t²` between points on the bounding arcs at equal radius | M7: `ε = d d′ h`, `h(0, 0) = 2/√3`, with `0 < ε ≤ min(d, d′)/16`, `|∇ε| ≤ 1/32` | theirs; mine is its diagonal |
| a general measurable state | **not reached** | **M8, Lemma S** | theirs |
| the kill for a clean step | S5 | M9 | one step |

**The second route the blind phase found** is S2–S3: the forced inner label from the strips, on both sides of the ring. It is
not the one to build (it needs two more release lemmas, and handles the boundary directions case by case), but it gives
something M3–M5 do not state: the label forced *outside* the ring on the mixed set is the opposite one, `a_{τ(k)+2}`.

### 3.2 M7, M8, M9, read line by line (the planner as second mind; by hand)

- **M4–M6**: checked. M4 is `SixRing.subset_closedBall_of_dist_lt` and a limit; M5's count ("two tips have at least three of
  the four sets") and `τ(k + 3) = τ(k) + 2` hold; M6's three cases each close, and the supposition's three inequalities are all
  six adjacent pairs under `τ(k + 3) = τ(k) + 2`.
- **M7**: `g = (d + d′)/2 + (2/√3) d d′ + O(3)` re-derived independently (from `1 − r = (√3/2)d + d²/8`,
  `cos(π/3 + g) = ½ − ½σ − (3/2)π₂ + …`, `σ = x + x′`, `π₂ = x x′`): `h(0, 0) = 2/√3` ✓, positive ✓. `ε(d, 0) = ε(0, d′) = 0`
  ✓ (each by naming the ring point). The transversality behind "`Φ` is a local diffeomorphism" holds at the hubs (the unit
  circle about `y_0` meets the unit circle about `p` at `y_1` at angle `60°`). `ε` is an explicit function,
  `ε = arccos((r² + r′² − 1)/(2 r r′)) − π/3 − (d + d′)/2`, `r = 2cos(π/3 + d/2)`: no implicit function theorem is needed.
- **M8, Lemma S: holds on my reading.** Checked: the coordinates `(u, v, w)` are a diffeomorphism onto all triples
  `u < v < w` of `J` (`w − v = d′ + ε` is increasing in `d′` from `0`); `g′ ≥ 1 − 1/32 − 33/(32·31) > 0.93 > 7/8` (and `g′ ≤ 1 + 1/32 + 33/(32·31) < 9/8`);
  the failure of "at most one jump" gives density points `a_* < b < c_*` with the outer two equal and the middle different (if
  no such triple exists, the density points of one value all precede those of the other); `ρ_1 > 0` exists and
  `m(ρ_1) = 3/4` in the second case, so the other value has a density point within `ρ_1` of `b`; in both cases
  `I ⊂ (u_0, w_0)` with a gap, `{s = Y}` fills `3/4` of `I`, the shift on `I` is at most `ρ/4` near `(u_0, w_0)`; the overlap
  `(3/2 + 21/16 − 9/4)ρ = (9/16)ρ` ✓; the triples have positive measure by Fubini and lie in (†)'s domain. Two things the
  text leaves implicit, both fine: `s` is taken Borel (it is: `paletteSet` is measurable), so `s ∘ g` is measurable in
  `(u, v, w)`; and "its image under `g` has measure at least `7/8` of it" and "the preimage of a positive-measure set is
  positive" need `g` bi-Lipschitz, which `7/8 ≤ g′ ≤ 9/8` gives.
- **M9**: (a)–(d) checked with their ranges (`17κ_3 < κ_2`, `d′ < 16κ_3 < κ_1`, `α′ − ψ_2 < 3κ_1 ≤ κ_*`). (d)'s set is open and
  non-empty because `ε > 0`.

**Verdict of this reading: C132-M-ORBIT holds by M1–M9, and its four-point form with it; C132-M-EXCL follows (2.3). I found no
gap. Grade: two minds on M7–M9 (the deriver; this reading), M8 no longer unread.** What I did not do: re-run their controls;
read M0's claim that the release's proofs of Lemma 5.2 (1) and Cor. 5.4 spend no count (the release's Lean states both for
every `k`, which settles it for `U = ℂ`).

### 3.3 The plan per leaf, final form, for `no_outside_orbit_points` (`Plane/SixRing/Orbit.lean`)

Stands on two release statements only — `palette_sixty_disjoint`, `palette_transfer_pair` — and on the ported
`mem_spatialSupport_ae` (to copy: `AngularBoundary.lean:309–312`) and the definition of `WeakColoring`. **`outer_strip_trace`
and `inner_strip_trace` are not needed** and leave the skeleton's OUTSIDE list when the implementer reaches it.

| leaf | states | from | kind |
|---|---|---|---|
| M1 `outsideState` | a measurable `s : ℝ → Bool` on `⋃ I_k`, the palette holds exactly the label `s` names a.e., `s(θ + π/3) = !s(θ)` a.e., both values of positive measure near every `ψ_k` | (i), (ii), `palette_sixty_disjoint` | measure theory |
| M2 `chart_avoids` | for a.e. `(α, d)` near `(ψ_{k+1}, 0)`: `c (Z α d)` is neither label named by `s α`, `s (α − d)` | `palette_transfer_pair`, the map `(α, d) ↦ ((α : Angles), (α − 2π/3 − d : Angles))` is a local diffeomorphism (quasi-measure-preserving) | change of variables |
| M3 `mixed_pos` | the mixed set `W_k(κ)` has positive measure for every `κ`; `Tip k ≠ ∅` | M1 ("`s(x) = s(y)` for a.e. pair ⟹ a.e. constant"), M2 | measure theory |
| M4 `tip_confines` | `a ∈ Tip k`, `q` a point of a set of `a` ⟹ `dist q (y k) ≤ 1` and `0 < ⟪q − p, e ψ_k⟫` | `subset_closedBall_of_dist_lt` (proved), closedness | geometry, short |
| M5 `tip_unique` | `Tip k = {a (τ k)}`, `τ (k + 3) = τ k + 2`; a.e. point of `B(p, 1) ∩ N_k(κ_*)` carries `a (τ k)`, `X` or `Y` | M3, M4, `closedBall y 1 ∩ closedBall (−y) 1 = {0}`, a finite count on `Fin 4` | finite + short |
| M6 `adjacent_tips` | some `k` has `τ k = τ (k + 1)` | M4, M5; the sign pattern check | **finite**: `decide` over `Fin 4 → Fin 4 → …` (64 patterns) after the three-axes lemma `⟪q, e_1⟫ = ⟪q, e_0⟫ + ⟪q, e_2⟫` |
| M7a `shift` | the explicit `ε(d, d′)`; `dist (Z α d) (Z (α + π/3 + d′ + ε) d′) = 1`; `ε(d, 0) = ε(0, d′) = 0` | trigonometry | calculus on an explicit formula |
| M7b `shift_bounds` | `∃ κ_1 > 0`, on `(0, κ_1)²`: `0 < ε ≤ min d d′ / 16`, `ε` Lipschitz with constant `1/32` in each variable | `ε_{dd′}(0, 0) = 2/√3`, continuity of the mixed derivative | **the heavy calculus leaf**, made lighter by an exact identity checked here by hand: with `F(ε) = |Z(α, d) − Z(α + π/3 + d′ + ε, d′)|² − 1 = r² + r′² − 1 − 2 r r′ cos(π/3 + (d + d′)/2 + ε)`, `F(0) = −8 sin(d/2) sin(d′/2) cos((d + d′)/2)` (row 148's identity, with `s = d`, `t = d′`) and `F′(ε) = 2 r r′ sin(π/3 + (d + d′)/2 + ε) ∈ (3/2, 2)` near `0`; so the zero `ε` is unique, positive, and between `d d′` and `(4/3) d d′` — the sign and the bound `ε ≤ min(d, d′)/16` with no arccos differentiated. The Lipschitz bound still needs `∂F/∂d = O(d′)` at the zero |
| M7c `unitPair_chart` | `(α, d, d′) ↦ (Z α d, direction to the partner)` carries null sets of `volume ⊗ angularMeasure` to null sets, both ways | M7a, transversality | change of variables |
| M8a `no_double_change` | (†) a.e. | M5, M6, M7c, `WeakColoring`'s second clause | measure theory |
| M8b–e Lemma S | no colouring: (b) a two-valued measurable function on an interval is a.e. a function with at most one jump, or has density points `a < b < c` valued `V, V′, V`; (c) the window `(u_0, w_0, ρ)`; (d) for bi-Lipschitz increasing `g` with `7/8 ≤ slope`, `0 < g − id ≤ ρ/4` on `I` and `E ⊆ I` of measure `≥ (3/2)ρ`: `E ∩ g⁻¹ E` has positive measure; (e) Fubini against (†) | Lebesgue density (`Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet`, used by the ported `ae_density_actual`), Lipschitz images | **four leaves, real analysis** |
| M9 `kill` | (a)–(d) | M2, M5, M7, M8 | measure theory, short once M7c is there |

Fourteen leaves. Finite: M6. Geometry: M4, M5. Calculus: M7a, M7b. Analysis: the rest. **Hard, in order**: M7b, M7c, Lemma S
(d)–(e), M2.

### 3.4 The four-point form (the coordinator's item 1), done in the skeleton

`SixRing.no_outside_orbit_points`: four points `q j ≠ p` with `Straddle {p, q j}` missing the supports of `a j` and
`a (j + 1)`. `SixRing.no_outside_orbit` (the compact-set form of the claim list) is now **proved from it**
(`straddle_mono`; a point of each set by `choose`): the compact-set form asks more of the hypothesis, so it is the weaker
theorem. Compactness of the `K j` is not used at all — the field stays in `FourCycleStraddle` only because the claim has it.
**Built**: `./scripts/build.sh` under the slot after this change — exit 0, 2 modules rebuilt (`Plane.SixRing.Orbit`, `Proofs`),
warnings only `declaration uses sorry` (`data/fs132/k1/probe/build-phase2.out`); `Orbit` still has 10 (`no_outside_orbit` is
proved, `no_outside_orbit_points` is the leaf).

### 3.5 C132-CORES-SQUARE (posed by the planner; for the claim list)

> **C132-CORES-SQUARE** — statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed
> axis-parallel square of side greater than 1 contains a cyclic centre; in particular every closed disc of radius greater than
> 1/√2 does.
> *Not claimed:* a square of side 1 or less; that 1/√2 is sharp for discs (in the hexagonal model every disc of radius 2/5
> contains one); squares that are not axis-parallel (they follow by rotating the colouring; not stated); anything for a
> colouring of a bounded region.

Lean: `SixRing.exists_cyclicCentre_square`; the disc form `exists_cyclicCentre` is derived from it in the skeleton. Its route
(2.3) rests on the release's §7.2–7.3 at general `k` — **not compared with the first deriver's S5–S7 (`FS132-E1` Stage 3):
unread.** Whether a port should start: `missing_edge_disk_cover` and `DiskAverages` are at `Fin k` already;
`GraphRealization` (threshold map, forest chart: 22 occurrences of `Fin 5`), `HoleApproximation` (12), `Mesh` (6) are typed at
five and at the disc of radius 5 — a port with changed types of about 1,400 lines, plus `DiskExtension` (611 lines, no label).
**Wait**: it is the largest item here, nothing else in this plan needs it, and the queue's later entries (C132-WIT-SUPER,
C132-WIT-SIDE, noted by the coordinator, planned nowhere in this job) may change what of it is needed.

### 3.6 The outside statements and the price, final for the statements read

- **Port, declare nothing further.** C132-M-ORBIT, -M-EXCL, -DIAG-WIDE at `U = ℂ` need three release statements
  (`palette_transfer_pair`, `palette_sixty_disjoint`, `two_state_impossible`). Their cones are the general-`k` files
  `CircleMaps`, `CircleTransport`, `PaletteDensity`, `PaletteTransport`, `States` to line 310 (about 2,400 lines with
  `BinaryPalettes`' triangle), on top of the 620 already ported at one patch. One implementer job, started tomorrow, re-priced
  after its first two files. Declaring them instead costs three read-backs and three models and leaves three more axioms.
- **The local form, after all?** Yes, but second. With the lemmas ported rather than declared, the local form is a change to
  proofs this library then owns (2.6); M1–M9 read the colouring only inside `B(p, 1)` and on the ring (M3–M5 never leave the
  open disc), so the whole-plane theorem's proof is the local one once `palette_transfer_pair` is restricted to sums inside
  `U`. Plan it when the whole-plane module is green.
- **An implementer starts with**: (1) the palette port; (2) `Winding.lean` (independent); (3) Lemma S (b)–(d) and M6, which
  need nothing ported.

### 3.7 Where a successor resumes

At **stage 4**: (1) read `FS132-E1` Stage 3 S5–S7 against 2.3's route for C132-CORES-FREE and 3.5; (2) read the entries for
C132-INDEX and C132-RING-WIND (their record is not located by this job) against `sixStep`; (3) read `FS132-E5` Stage 2
(C132-WIT) against 3.4; (4) state M1–M9 as `sorry` leaves in `Plane/SixRing/Orbit.lean` in the chart `Z(α, d)` — only
`no_outside_orbit_points` carries them now; (5) drop `outer_strip_trace`, `inner_strip_trace` from the OUTSIDE placeholders.

## Stage 4 — SAVED (FS132-K2): the successor's readback

*FS132-K2 (de Bruijn, the planner's successor; brief `data/fs132/briefs/FS132-K2-kernel-plan.md` on `main`). Nothing is blind.
"Theorems this phase proved" (the heading at the top) still reads none in the kernel on a `sorry`-free cone: what stage 5
proves is assembly from `sorry` leaves, listed there.*

**Quotations.** By script, each `>`-quoted line of the brief against the file its source line names, whitespace-normalized:
12 of 12 MATCH (Kooshi's three; the two claims; the predecessor's four; inventory items 30, 31, 32). No mismatch.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail (to line 260);
`data/fs132/claims-K1.md` with its dated line; this record's Stages 1–3; `plans/FS132-E3-derivation.md` Stage 3 from its
entries through "Prior art, this job" (the nine steps M0–M9, the ring form, the fixed form, the route table, the two checks);
`plans/FS132-derivation.md` to the end of its § 1; inventory items 30–32 (to the end of 31's fourth ruling); the skeleton's
`Orbit.lean` and `Confine.lean` whole, the import module's and the ported module's declaration lists, the definitions of
`palette`, `liftPalette`, `RealState`, `angularSum`, `Straddle`, `spatialSupport`; the sibling brief FS132-I2. **Read in
part**: the release's `CircleMaps.lean` and `CircleTransport.lean` (declaration lists; `circleSum`, `angleChart`,
`circleSum_quasiMeasurePreserving`, `angularSum_quasiMeasurePreserving`, `circleSum_local_antilipschitz` whole), the four
statements the brief names in their files. **Not read at this stage**: `Winding.lean`, `CyclicCentre.lean` (stage 6), the
derivation file's §§ 2–12 (stages 6–7).

**The branch as given**: `./scripts/build.sh` under the slot — exit 0, nothing to build, three modules with `sorry` warnings
(`data/fs132/k2/probe/build-asgiven.out`).

**What the readback changed in the plan** (each is the planner's to decide; the hand argument is not changed):

1. **Fourteen leaves became forty-nine, and the top theorem is proved from them.** K1's table (§ 3.3) names steps; a step
   is several statements once typed. The assembly `no_outside_orbit_points` elaborates from the leaves (stage 5).
2. **The analytic core is stated with no palette in it** (`chart_step_false`): a weak colouring, a measurable set of
   angles, and two almost-everywhere statements in the chart. M7–M9 then need nothing ported.
3. **Tips are stated for any number of labels and any map `a` from `Fin 4`**; six and injectivity are spent in one finite
   lemma of the assembly (`exists_cycle_label`). The derivation says as much in prose ("M1, (⋆), M4, M5's first sentence,
   M6's geometry, M7 and Lemma S hold at every number of labels"); the leaves now say it in their binders.
4. **Lemma S is proved along a route that differs from the derivation's in two places** (stage 5, StepLemma): a dyadic
   window in place of "the largest radius with `m ≥ 3/4`", and a base point of four density points with a
   translation estimate in place of Fubini over a neighbourhood of `(u_0, w_0)`. Same lemma, same constants' shape;
   no change of variables in three dimensions is needed anywhere in the module.
5. **Null sets cross the chart in one direction only** (preimages), which is the release's `circleSum_quasiMeasurePreserving`;
   the derivation's "local diffeomorphism … null sets and sets of positive measure correspond" is used nowhere in its
   stronger direction.
6. **`ε` is the explicit `shift`**, and the bound `ε ≤ min(d, d')/16` needs no second-order expansion: `ε` vanishes on both
   axes and is `1/32`-Lipschitz in each variable on the closed square. Positivity is the library's own
   `Plane.twoCirc_identity` (FS129-SR1-TWOCIRC; K1's "exact identity" § 3.3 is that theorem).

## Stage 5 — SAVED (FS132-K2): the exclusion's leaves, stated; the four-point form proved from them

**Built**: `./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`) — **exit 0**, 13 modules rebuilt,
warnings only `declaration uses sorry` (`data/fs132/k2/probe/build-leaves.out`; 72 in all: 49 leaves of the exclusion, 3
placeholders, 1 leaf of the two-pair ring, and the 16 + 3 of `Winding` and `CyclicCentre`, untouched).
`tools/check_architecture.py`: PASS. Every leaf as the kernel holds it: `data/fs132/k2/probe/Sigs.out` (`#check @…` of each,
407 lines; `#print axioms no_outside_orbit_points` there reads the standard three and `sorryAx`, as it must). Not run: the
audits of the gate (a skeleton is not a landing).

**Whole plane.** Every statement is for a colouring of `ℂ`; each module's header and each claim-carrying docstring says so.
The form for an open set containing the closed unit disc is a later statement (§ 3.6).

### 5.1 The modules, and who can work without sharing a file

| module (`Plane/SixRing/…`) | holds | `sorry` | waits on the port? | an implementer for |
|---|---|---|---|---|
| `Basic` | definitions, models, drift checks | 0 | no | nobody: settled |
| `Placeholders` | the release's three statements, verbatim; `mem_spatialSupport_ae` proved | 3 | **is** the port's stand-in | nobody: deleted at the join |
| `Chart` | plane geometry of `chart`, `hub` | 11 | no | A (geometry) |
| `Tips` | M4, M5, M6, the count of six | 7 | no (imports `Chart`) | A |
| `Shift` | M7: the shift's calculus; `exists_shiftBounds` proved | 7 | no | B (calculus) |
| `StepLemma` | M8's Lemma S and children; M3's first sentence | 8 | no | C (real analysis) |
| `ChartMeasure` | null sets through the chart | 4 | `chart_quasiMeasurePreserving` only (or prove it by polar coordinates) | D (measure) |
| `Kill` | M8's (†), M9; `chart_step_false` proved | 2 | no | D |
| `State` | M1, M2, M3 on palettes | 8 | **yes**, both statements (or works against the placeholders now) | E, after or beside the port |
| `Excl` | M-EXCL's two leaves | 2 | `palette_sixty_disjoint` | E |
| `Orbit` | the assembly | 0 | — | nobody |
| `TwoPairs` | C132-DIAG-WIDE | 1 | `two_state_impossible` | E |

A, B, C need nothing ported and share no file: **three implementers can start now**. D needs `Chart` and `Shift`'s
*statements* only (it imports them; it does not wait for their proofs). E can start against the placeholders.

**The planner's standing permissions to an implementer** (so that a round trip is not needed for these): (1) a hypothesis a
proof does not use is dropped from the leaf and from its call sites, and reported — it only strengthens the leaf; (2) the
children of `step_lemma` (`StepLemma`) may be restated, `step_lemma` itself not; (3) a helper lemma is added freely, under a
name no other module declares (`LEAN.md` § Searching: never one name in two modules). Anything else that changes a statement
comes back.

### 5.2 The assembly, read back (all of it elaborates; `Orbit.lean`, `Kill.lean`, `Shift.lean`)

- `no_outside_orbit_points` — K1's statement, binder for binder unchanged. Proof: `OutsideOrbit` from (δ, i, ii);
  `exists_tip` (M1–M3) gives at each hub a tip other than `X`, `Y`, which `exists_cycle_label` (six) puts among the four;
  `choose τ`; `exists_adjacent_tips` (M4–M6) gives `τ n = τ (n + 1)`; `adjacent_tip_false` (M7–M9) at `b = a (τ n)`, its two
  hypotheses from `tip_unique` (M5). **This is the derivation's order**: tips exist, one tip per hub, three axes, the kill.
- `adjacent_tip_false` — from `OutsideOrbit.hubColours` at hub `n`, `.hubColours_flip` at hub `n + 1`, `.change_at`, and
  `chart_step_false` on the smaller of the two boxes.
- `chart_step_false` — `exists_shiftBounds`; `κ' = min(κ/3, κ₁)` (the derivation's `κ_1 ≤ κ_*/3`); `no_double_change` (†);
  `step_lemma`; `step_at_of_change`; `step_kill`.
- `exists_shiftBounds` — from `shift_pos`, `exists_shift_lipschitz`, `shift_comm`, `shift_zero_right`.
- `no_outside_orbit`, `not_ae_outside` — as K1 proved them.

### 5.3 The leaves: readback, model, plan, size

*Columns: the step and its words; what the Lean statement says where it differs or sharpens; a model of the hypotheses
where they could be empty; the route with the Mathlib or library statements it uses (each `#check`ed at this pin:
`data/fs132/k2/probe/Check1.out`, `Check2.out`); the size in lines, the planner's estimate. "Library" = whether this
library already holds the statement.*

**`Chart` (11; geometry; nothing ported; library: no — it holds `Plane.e_add_e_eq`, `Plane.norm_e`, `Plane.e_add`)**

| leaf | step, readback | route | lines |
|---|---|---|---|
| `chart_eq_polar` | M2 "`|Z| = 2 cos(π/3 + d/2)` … `arg Z = α − π/3 − d/2`": one identity for all real `α, d`, `Z = p + r(d) e(α − π/3 − d/2)` | `Plane.e_add_e_eq α (α − 2π/3 − d)` (in `Plane/SixFragment`; or four lines of `Plane.e_eq` and `Real.cos_add`), `Real.cos_neg` | 10 |
| `chart_zero`, `chart_hub` | M2 "the points near `y_k`": `Z(ψ_{n+1}, 0) = y_n` | `chart_eq_polar`, `Real.cos_pi_div_three`; a cast `((n+1 : ℤ) : ℝ)` | 6 + 6 |
| `dist_chart_centre`, `dist_chart_lt_one` | M2 "below 1 exactly when `d > 0`", the direction used, for `0 < d ≤ π/3` | polar form, `Plane.norm_e`; `Real.cos_lt_cos_of_nonneg_of_le_pi` or `Real.strictAntiOn_cos` | 6 + 10 |
| `continuous_chart` | — | `Complex.continuous_exp` | 4 |
| `chart_eq_angularSum` | M2 "the sum map is this chart" | `direction_coe` (import module), `one_mul` | 4 |
| `dist_hub`, `hub_add_three`, `hub_axes`, `hub_shift` | M5 "`y_{k+3} = −y_k`"; M6 "`e(ψ_1) = e(ψ_0) + e(ψ_2)`" | `Plane.e_add`, `e π = −1`, `Plane.e_add_e_eq`; casts | 4 × 6 |

**`Tips` (7; geometry and one finite check; nothing ported; library: no)**

| leaf | step, readback | model | route | lines |
|---|---|---|---|---|
| `IsTip.dist_le_one` | M4 "`K ⊂ B̄(z_n, 1)` … in the limit `K ⊂ B̄(y_k, 1)`", for `K = {p, q}` | `c` constant, `i` its label, `y` on the ring: every `q` within `1` of every nearby `z` — i.e. `q = p` only; non-degenerate: the hexagonal colouring near a vertex | `closure_minimal` with `isClosed_le`; at a point of the support in the open disc, `subset_closedBall_of_dist_lt` (proved, `Confine`) with `x := p` | 12 |
| `IsTip.inner_pos` | M4 "`|q − y_k|² ≤ 1` gives … `q·e(ψ_k) > 0`" | as above | `norm_sub_sq_real`, `nlinarith` as in `Confine.inner_nonneg_of_subset_closedBall` | 12 |
| `tip_antipodal` | M5 "a set of a label of `Tip(k)` is no set of a label of `Tip(k + 3)`", in its sign form: no use of `B̄(y) ∩ B̄(−y) = {p}` | — | `inner_pos` four times (`hl j`, `hr (j − 1)` with `j − 1 + 1 = j`), `inner_neg_right`; then `j' ∉ {j − 1, j, j + 1}` in `Fin 4` by `decide`/`omega` | 25 |
| `tip_unique` | M5 "`Tip(k) = {a_{τ(k)}}` is one label" | — | `tip_antipodal` twice against `τ (n + 3)`, `hub_add_three`, `add_right_cancel` | 8 |
| `adjacent_of_signs` | M6's proof, as the finite statement its control checks (64 patterns; re-checked here by brute force: none escapes) | `t = (0, 0, 0)` with any consistent signs | `fin_cases` on `t 0, t 1, t 2` (64) with `linarith` from at most four sign facts per case; or the derivation's three cases by hand | 30 |
| `exists_adjacent_tips` | M6 "`τ(k) = τ(k + 1)` for some `k`" | — | `σ j n := ⟪q j − p, hub p ψ n − p⟫`; `hpos` from `inner_pos` (`hl`, `hr`); `hneg` from the antipodal hub (`tip_antipodal`, `hub_add_three`); `hax` from `hub_axes`, `inner_add_right`; `adjacent_of_signs` | 35 |
| `exists_cycle_label` | M2 "six is spent": "a label that is neither `X` nor `Y` is one of four" | `a = (0,1,2,3)`, `X = 4`, `Y = 5` | `Finset.card_image_of_injective`, `Finset.card_le_card` into `univ \ {X, Y, i}` (three elements): `4 ≤ 3` | 12 |

**`Shift` (7; calculus; nothing ported; library: holds the sign identity `Plane.twoCirc_identity`)**

| leaf | step, readback | route | lines |
|---|---|---|---|
| `ringRadius_mem` | (M7) `r ∈ (1/2, 1]` on `[0, 1/4]`: the triangle `(r, r', 1)` is non-degenerate | `Real.cos_add`, `cos(π/3) = 1/2`, `sin(π/3) = √3/2`, `Real.cos_le_one`, `Real.one_sub_sq_div_two_le_cos`, `Real.sin_le` | 20 |
| `shift_comm` | — | `ring_nf` on the definition | 4 |
| `shift_zero_right` | M7 "`ε(d, 0) = 0`" | `ringRadius 0 = 1`; the quotient is `cos(π/3 + d/2)`; `Real.arccos_cos` | 12 |
| `dist_chart_chart_shift` | M7 "`|z − z′| = 1` ⟺ `cos(π/3 + g) = (r² + r′² − 1)/(2 r r′)`", the direction used; numerically checked here on 20,000 samples to `4·10⁻¹⁵` | `chart_eq_polar` twice; `‖r e(β) − r' e(β')‖² = r² + r'² − 2 r r' cos(β' − β)`; `β' − β = arccos(Q)` by the definition; `Real.cos_arccos` with `−1 ≤ Q ≤ 1` from `ringRadius_mem` (`(r − r')² ≤ 1 ≤ (r + r')²`) | 40 |
| `shift_pos` | M7 "`0 < ε`": "`ε(d, 0) = ε(0, d') = 0` … `h(0,0) = 2/√3`" is replaced by the exact identity at zero shift | `Plane.twoCirc_identity` at `y₀ = p + e(α − π/3)`, `y₁ = p + e(α)`, `σ = 1`, `s = d'`, `t = d`: `Q < cos(π/3 + (d + d')/2)`; `Real.strictAntiOn_arccos` | 40 |
| `exists_shift_lipschitz` | M7 "`|∇ε| ≤ 1/32`" on a closed square; numerically `κ = 1/50` works (slope `≤ 0.024`) | `Real.contDiffAt_arccos` at `1/2`; the gradient of `shift` at `(0,0)` is `0` (`∂ε/∂d = −Q_d/√(1 − Q²) − 1/2 = (√3/4)/(√3/2) − 1/2`); `ContDiffAt.exists_lipschitzOnWith_of_nnnorm_lt` with `K = 1/32`, restricted to a slice | 60 — **the heavy calculus leaf** |
| `measurable_shift` | "the state is Borel" side: the shift is a measurable function | `Real.measurable_arccos`, `Real.measurable_cos`, `Measurable.div` | 6 |

**`StepLemma` (8; real analysis, no colouring; nothing ported; library: no statement of this shape — `Plane/MetricalBoundary`
holds density-ratio tools for a general measure (`continuous_measure_inter_closedBall`, `exists_closedBall_ratio_eq_half`),
`Plane/CoverExamples.exists_density_point` a one-dimensional density point; neither is a leaf here)**

| leaf | step, readback | model | route | lines |
|---|---|---|---|---|
| `exists_step_or_density_triple` | Lemma S "Suppose the conclusion fails. Then there are Lebesgue density points `a_* < b < c_*` … with `s(a_*) = s(c_*) ≠ s(b)`" (K1: "if no such triple exists, the density points of one value all precede those of the other") | `S = Iio 0` (step); `S = (0,1)` on `(−1, 2)` (triple) | `Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet` for `S` and `Sᶜ`: a.e. point is a density point of one; `t' := sSup` of the density points of the earlier value | 70 |
| `exists_window` | Lemma S's window, dyadic: the least `n ≥ 1` with proportion `≥ 7/8` at radius `R/2ⁿ`, `R = min(b − a, c − b)`; if `n > 1` the complement has measure `> ρ/4` in `ρ ≤ |x − b| < 2ρ`, hence a density point there | `E = (−1, 1)`, `a = −2`, `b = 0`, `c = 2`: `ρ = 1`, `u = a`, `w = c` | `Nat.find`; `Real.volume_closedBall`; `Measure.exists_mem_of_measure_ne_zero_of_ae` | 80 |
| `exists_shiftMap` | Lemma S "`g_{u,w}(v) = v + ε`, increasing … `g′ ≥ 7/8`"; the slopes come out in `[31/33, 33/31]` | `ε = d d'/16` (`shiftBounds_model`) | `D ↦ D + ε(d, D)` is continuous and strictly increasing (`ShiftBounds.lip_right`); `intermediate_value_Icc`; `g v := w − D(v)`; the slope bound is two lines of `abs_le` and `linarith` from `lip_left`, `lip_right` | 80 |
| `exists_density_pair` | Lemma S's overlap with base point; constants `7/4·ρ`, `(7/8)(7/4)ρ = 49/32·ρ`, both in an interval of length `35/16·ρ`: overlap `≥ 35/32·ρ` | `F = I`, `g = id + ρ/16` | `MeasureTheory.hausdorffMeasure_real`, `LipschitzOnWith.hausdorffMeasure_image_le` (for `g` and for its inverse on `g '' F`), `measure_inter_add_sdiff`; density a.e. on `F` | 90 — **hard** |
| `volume_pattern_pos` | Lemma S's last lines, without Fubini over `(u, w)`: in the cube of side `2η` about the base point each of the four conditions fails on `o(η)·4η²` | — | for fixed `(d, d')` the four angles are translates of `α`, displaced by at most `η/16` (`lip_left`, `lip_right`); `Measure.prod_apply`/`lintegral_prod`; `IsDensityPt` unfolded at radii `η`, `2η`, `(17/16)η`, `(33/16)η` | 100 — **hard** |
| `step_lemma` | **Lemma S, verbatim in its docstring** | a half-line (`example`, proved) | `exists_step_or_density_triple` on `Ioo (t − κ/4) (t + κ/4)`; in the triple case `exists_window`, `exists_shiftMap` at `(u, w)` (`w − u < κ/2`), `exists_density_pair` for `F = E ∩ Ioo (b − ρ) (b + ρ)` (the bound `3ρ/16` from `le_left`/`le_right` and "one end within `2ρ` of `b`"), `volume_pattern_pos` at `(v, v − u, w − g v)` against `NoDoubleChange` | 60 |
| `step_at_of_change` | M8 "By M1, `s` is not almost everywhere constant near `ψ_1`, so `s` is a step at `ψ_1`" | — | if `t' < t`, `S` is null or conull on `(t', t + r) ∋ t`; `measure_mono_null` | 30 |
| `volume_change_pairs_pos` | M3 first sentence | `S = Iio t` | the product of `S ∩ I` and `Sᶜ ∩ I`, `I = Ioo (t − κ/2) (t + κ/2)`, has positive measure; its image under `(x, y) ↦ (max, |x − y|)` lies in the set; a linear measure-preserving change on each half | 40 |

**`ChartMeasure` (4; measure; library: no)**

| leaf | step, readback | route | waits | lines |
|---|---|---|---|---|
| `chart_quasiMeasurePreserving` | M2 "`Z` is a diffeomorphism", one direction | the release's `circleSum_quasiMeasurePreserving` (`CircleMaps.lean:509`, in the port's cone) after `(α, d) ↦ (α, α − 2π/3 − d)` (a shear and a reflection: measure preserving) and `Complex.volume_preserving_equiv_real_prod`; **or**, with nothing ported, `chart_eq_polar` and Mathlib's polar coordinates | the port, or not | 25 |
| `shear_quasiMeasurePreserving` | M8, pulling the statement at the second hub back to `(α, d, d')` | `Measure.measure_prod_null` / `Measure.ae_prod_iff_ae_ae`; `measurePreserving_add_right` | no | 30 |
| `ae_ne_of_not_isTip` | M5 "for an inner `a ∉ Tip(k)` there is `κ` with `A_a` null in `B(0, 1) ∩ N_k(κ)`" | `Metric.mem_closure_iff` negated: a ball about the hub misses `support ∩ ball p 1`; `mem_spatialSupport_ae`; `continuous_chart` at `(ψ_{n+1}, 0)` with `chart_hub`; `dist_chart_lt_one`; `chart_quasiMeasurePreserving.ae` | no | 35 |
| `unitPair_chart_ae` | M7 "The map `Φ : (α, d, d′) ↦ (z, z′ − z)` is a local diffeomorphism into the space of unit pairs", one direction, and M8 "Properness and `Φ` give" | the direction from `z` to its partner is `u = α + 2π/3 − d/2 − arccos((r² + 1 − r'²)/(2r))` (checked numerically here: `z + e(u) = z'` to `5·10⁻¹⁵`; strictly monotone in `d'`): it does not involve `ε`. `(α, d, d') ↦ (z, u)` is the chart in the first two coordinates and, for fixed `(α, d)`, a `C¹` function of `d'` with non-zero derivative: null sets pull back (`Measure.measure_prod_null`, then `LipschitzOnWith.hausdorffMeasure_image_le` for the local inverse in one variable); `AddCircle` coercion is measure-class preserving (`AddCircle.measurePreserving_mk`) | `chart_quasiMeasurePreserving` | 120 — **hard** |

**`Kill` (2; measure; needs nothing ported beyond `ChartMeasure`)**

| leaf | step, readback | route | lines |
|---|---|---|---|
| `no_double_change` | M8's (†), on the box `κ'` with `3κ' ≤ κ` (the derivation's `κ_1 ≤ κ_*/3`: the second hub's chart angle is `α + ε + d' + π/3`, within `κ' + κ'/16 + κ'` of `t + π/3`) | `h0` along the projection (`Measure.quasiMeasurePreserving_fst`-style), `h1` along `shear_quasiMeasurePreserving measurable_shift`, `unitPair_chart_ae`; `filter_upwards`; on a split pair `HubColours` leaves `b` | 45 |
| `step_kill` | M9 (a)–(d) with `κ_3 = κ'/128`; (a) and (c) by Fubini on the sections `d'' ∈ (h, 16h)`; (d) the set `{ψ_1 − ε < α < ψ_1}` has measure `∫∫ ε > 0` (`ShiftBounds.pos`, `measurable_shift`): **openness is not needed** | as `no_double_change`, twice; `Measure.ae_prod_iff_ae_ae`; both orientations of the step by the symmetry `(X, Y, S) ↔ (Y, X, Sᶜ)` | 150 — **hard** |

**`State` (8; palettes; stands on `palette_sixty_disjoint`, `palette_transfer_pair`)**

| leaf | step, readback | route | lines |
|---|---|---|---|
| `measurableSet_liftPalette` | "`s` is taken Borel" | `paletteSet_measurable`, `AddCircle.measurable_mk'` | 3 |
| `OutsideOrbit.ae_iff_not`, `.ae_flip` | M1 "both hold an outside label (i) and are disjoint (T3); so each holds exactly one … `s(θ + π/3) ≠ s(θ)`" | (i) at `n` and at `n + 1` (translated: `measurePreserving_add_right`), `palette_sixty_disjoint` pulled to `ℝ` (`ae_real_of_ae_angles`, or its proof), `AddCircle.coe_add` | 30 + 15 |
| `OutsideOrbit.change_at` | M1 "each `ψ_k` is an essential change point" | induction on `m` up and down from (ii) with `.ae_flip` and `.ae_iff_not`; translation invariance | 40 |
| `OutsideOrbit.chart_avoids` | M2's (⋆), for `|d| < δ/2` (both signs) | `palette_transfer_pair` along `(α, d) ↦ ((α : Angles), (α − 2π/3 − d : Angles))` (linear measure-preserving, then two coercions); `chart_eq_angularSum`; `.ae_flip` at `n − 1` and `n` gives the state at `α − 2π/3 − d` equal to the state at `α − d`; `.ae_iff_not` | 60 |
| `exists_tip` | M3 | suppose no label other than `X`, `Y` tips: `ae_ne_of_not_isTip` for each (finitely many: `Finset.inf'` of the `κ`), with `.chart_avoids`, makes the pairs of `volume_change_pairs_pos` null | 40 |
| `.hubColours`, `.hubColours_flip` | M5's last sentence with (⋆); M7 "shifts both arguments by `−π/3`, which flips both values" | `.chart_avoids`, `ae_ne_of_not_isTip`; for the flip, `.ae_flip` at `θ − π/3` | 30 + 35 |

**`Excl` (2)**: `exists_change_of_ae_outside` (the ring form's argument: the set of angles near which the state is a.e.
constant is open; connectedness of `ℝ`; `palette_sixty_disjoint`; 50 lines), `ae_real_of_ae_angles`
(`AddCircle.measurePreserving_mk` on each period, a countable union; the release's `angleMk_quasiMeasurePreserving`, in the
port's cone, is this statement; 15 lines).

**Hard, in order**: `unitPair_chart_ae`, `step_kill`, `volume_pattern_pos`, `exists_density_pair`, `exists_shift_lipschitz`.
Total, the planner's estimate: about 1,900 lines.

### 5.4 Numerical and finite checks made at this stage (`data/fs132/k2/probe/chk.py`; exact arithmetic is not claimed)

The chart's polar form, `chart p (α + π/3) 0 = p + e(α)`, the unit distance at the shift on `[0, 1/4]²` (and on
`[−1/4, 1/4]²`), the partner direction's formula and its monotonicity in `d'`, `shift = 0` on both axes,
`Plane.twoCirc_identity` in the chart; on `(0, κ]²` the ratio `ε/(d d')` lies in `[1.1547, 1.182]` at `κ = 1/50` with
slope `≤ 0.0240 < 1/32` and `ε ≤ 0.0237·min(d, d')`. M6's count by brute force: of the 64 triples none with all adjacent
tips different is sign-consistent.

## Stage 6 — SAVED (FS132-K2): the two-pair ring's leaves; the three comparisons

*Read for this stage: `plans/FS132-derivation.md` entries C132-CORES-FREE, C132-CORES-SQUARE, C132-INDEX, C132-RING-WIND
(whole, with the prose under each) and C132-EXT-DISC's `statement:`, `uses only:` and `handoff:` fields;
`plans/FS132-E1-derivation.md` Stage 3 steps S2–S11 and "Argument — cores exist" (lines 176–264, whole); the skeleton's
`Winding.lean` and `CyclicCentre.lean` (statements, whole); `Topology/LebesgueCovering.lean`'s `lebesgue_covering_square`;
the release's `Mesh.lean` (declaration list and `no_large_positive_sequence`'s statement) and
`PlanarCovers.compact_open_cover_impossible`'s statement. Not read: the release's proofs in those files; E2's argument
sections (the entries' fields are what is compared).*

### 6.1 The two-pair ring (C132-DIAG-WIDE): both rewording leaves are proved

`Plane/SixRing/TwoPairs.lean` has no `sorry` of its own. `no_alternating_groups` is proved from the placeholder
`two_state_impossible` — **the release's statement binder for binder** (`States.lean:243`; as the kernel holds the
placeholder: `data/fs132/k2/probe/Sigs.out`, last block) — and `ae_real_of_ae_angles`: the `RealState` hypotheses are
`MeasurableSet {t : ℝ | w ↑t = b}` (`AddCircle.measurable_mk'`) and the palette inclusion pulled to real angles
(`mem_palette`); the flip is `≠` on `Bool`, and `((π / 3 : ℝ) : Angles) = (sixty : Angles)` by `rfl`.
`no_alternating_pairs` is proved from it (`(univ \ (D ∪ D')).card = 6 − 4`). So the rewording is confirmed against the
statement the port will give: when the port's theorem replaces the placeholder, C132-DIAG-WIDE at `U = ℂ` stands on
`ae_real_of_ae_angles` alone (the release's `angleMk_quasiMeasurePreserving`, which the coordinator has asked the port to
bring).

### 6.2 "Centres exist": the planner's route and the square form against the first deriver's steps

**The comparison.** The first deriver's argument for C132-CORES-FREE is its steps S5–S7 "with `L_0 = ∅` and no core disc"
on a disc `D₁ = B̄(o, r′) ⊂ D`. K1's route (§ 2.3) is the same two steps S5 and S7 on a compact region, with S6 replaced:

| step | the first deriver (on a disc) | reads the region's shape? | K1's route (on a square) |
|---|---|---|---|
| S3, S4 | a missing edge gives small overlap; the threshold map, `0 < α < 1/k` | no | the same (K1: "Lemma 7.3 … any `k`") |
| S5 | holes and tree fillings on `D₁`, inside a slightly larger region `D` with no centre; with `L_0 = ∅` no core disc | **no** — it uses compactness of `D`, a Lebesgue number, and that `D₁` is interior to `D` | the same on a square `Q₁` of side `s₁ ∈ (1, s)` inside `Q` |
| S6 | no finite relatively open cover of a disc of radius `r′` of multiplicity two and mesh `m < r′` (Brouwer) | **yes — the only step that does** | this library's `lebesgue_covering_square` (kernel), in the open-cover form `no_fine_cover_square` |
| S7 | the components of `{(g̃_n)_i > 0}` cover with multiplicity two and mesh `1 + o(1)`: a path joining points more than `1 + c₀` apart, a ball about one end, unit distances, `p_i(y) + p_i(z) ≤ 1` at every unit pair, `|E_n| → 0` | **no** — paths, unit distances and areas only; the ball `U` need not lie in the region | the same |

**Verdict (a checking reading with the argument open, one mind; not a derivation).** K1's route *is* S5 and S7, and on this
reading neither reads the disc; so the square form follows by the first deriver's own steps with S6 exchanged for
Lebesgue's covering theorem, and I see no step left to derive. The entry C132-CORES-SQUARE is filed as a gap for exactly
this comparison ("Whether those steps read the disc's shape is the comparison … that nobody has done"): it is now done, at
this grade. Whether the entry's verdict moves is the coordinator's and the deriver's.

**Can the square form be planned as a kernel statement from this library's covering theorem directly?** In two parts:

- **The cover step — yes, directly, and short.** `no_fine_cover_square` (in the skeleton, a leaf): a finite subcover
  (`IsCompact.elim_finite_subcover`), a closed shrinking (`exists_subset_iUnion_closed_subset`,
  `Mathlib/Topology/ShrinkingLemma.lean:234`), re-indexed by `Fin m`; a set whose trace has diameter at most `m < s` does not
  meet two opposite sides; `lebesgue_covering_square` gives a point in three members, against the multiplicity. About 40
  lines, nothing ported, no colouring. It replaces the release's `compact_open_cover_impossible` (a degree argument on a
  region containing the disc of radius 5).
- **The statement itself — no, not directly: it needs the mesh bound in the kernel**, which is the release's hole chain.
  `missing_edge_disk_cover` and the disc averages are at `Fin k` already; `GraphRealization`, `HoleApproximation`, `Mesh` are
  typed at `Fin 5` and at `closedBall 0 5`, with `DiskExtension` under them: about 1,900 lines to port with changed types.
  **And one constant is not the claim's**: the release's Lean mesh theorem (`Mesh.lean:92`, `no_large_positive_sequence`)
  refutes preconnected sets joining points with `2 < dist x y`, and its cover obstruction is at diameters at most `2`.
  Re-typed as it stands, the kernel would hold "every closed square of side above 2 holds a cyclic centre" — a disc of
  radius above `√2`, not above `1`. The claim's radius needs the threshold `1 + c₀` (any threshold up to `√2` already gives
  C132-CORES-FREE's disc of radius above `1` through the inscribed square; `1 + c₀` for every `c₀ > 0` gives the square of
  side above `1`). The hand argument (S7) proves `1 + c₀`; the Lean proof has slack at that line (`2 * t n < dist`), so it
  is a parameter in one 154-line file, but it is a change to a proof and not only to types. **Planned as a
  planner-and-implementer job of its own** (stage 7, tier C).

### 6.3 The six-step lemma against the second deriver's two index entries

**No difference in statement.** The entries C132-INDEX and C132-RING-WIND carry the statements of the claim list character
for character (the list was copied from them), and § 2.2 read the skeleton's Lean against those words. What differs is the
route, and only for the second:

- **C132-INDEX**: the entry's `uses only:` — "continuity of φ and its lift to the line; that six rotations by π/3 compose
  to the identity; that a point of Θ whose support is disjoint from the support of a vertex lies on the closed opposite
  edge, and from the support of an interior point of an edge is the opposite vertex" — is `exists_triLift`, the six-step
  sum inside `sixStep`, and `step_mem_of_disjoint` with `fract_eq_zero_of_step_end`. One lemma, two authors.
- **C132-RING-WIND**: the entry derives it *from C132-INDEX*, "applied to the loop that sits at a vertex on a singleton
  arc, at an edge's midpoint on a pair arc, and moves along one edge across each point of J"; the skeleton proves it from
  `sixStep` on the step lift (`RingLift`: the same vertex and mid-edge positions) with no continuous loop. **The implementer
  builds the skeleton's**: it needs no interpolation and no covering lift for the ring. The derivers' is the second route.
- Models: the entry's (nine arcs, joined linearly on short intervals) and the skeleton's `indexModel` (ramp for `π/9`,
  rest for `π/9`) are the same loop at two ramp lengths; both keep a point inside an edge opposite a resting vertex.
- A check made on the way, by hand: `ringLift_degree_unique` holds as stated (two lifts of one ring differ by a multiple
  of `3` that is locally constant almost everywhere: two closed edges hold at most one such difference).

### 6.4 The four-point form against the witness card's restatement

`no_outside_orbit_points` against the entry C132-WIT-ORBIT (`plans/FS132-derivation.md` § 1), clause by clause, at `U = ℂ`:
"for each j modulo 4 let q_j be a point other than p" — `hq : ∀ j, q j ≠ p`; "with H_{a_j} ∩ Δ({p, q_j}) = ∅" — `hl`;
"and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅" — `hr`, `j + 1` in `Fin 4`; the labels, (i) and (ii) as in C132-M-ORBIT (§ 2.2). **The
same statement.** The entry's `not claimed:` line "that the labels a_j are present at p or anywhere near it (nothing in the
hypotheses says so, and nothing in the argument uses it)" is true of the Lean statement too, and of every leaf: `IsTip` is
derived, never assumed.

## Stage 7 — SAVED (FS132-K2): what else this milestone's module must state — a draft for the coordinator to fix

*The statements below are copied by script from `plans/FS132-derivation.md` on `main` (`data/fs132/k2/module_list.py`; its
`--check` fails on a named entry the file does not hold — planted and watched: exit 1 on a misspelt key, exit 0 restored);
the line under each name is the planner's. Read for the lines: every entry's `statement:`, `uses only:` and `handoff:`
fields in §§ 2–5 and 7 of the derivation file (the first 230–330 characters of each by script, seven of them whole); the
asking lane's table (`plans/POROS-2026-10-07-fs132-night.md` § What to formalize) and its corrections
(`plans/POROS-2026-10-07-fs132-round2.md` § 3.4), whole. **Not read: the arguments behind the second- and third-round
entries.** Sizes are the planner's guesses from the `uses only:` lines, not prices; re-price each from its first two leaves.*

**Already planned, from the first round** (the kernel claim list's seven): C132-M-ORBIT and C132-M-EXCL (stage 5),
C132-DIAG-WIDE (6.1), C132-CONFINE (proved), C132-CORES-FREE (6.2), C132-INDEX and C132-RING-WIND (6.3).

**Where the ranking below departs from the asking lane's, and why.** (1) C132-WIT-MARGIN, which it does not list, goes
first: fifteen lines, and it is what lets the four-point hypothesis have a kernel model. (2) C132-PLACE is stated, not
held: its hold was "until C132-LENS has its verdict", and the third round's entries now stand on it. (3) C132-SHADOW
enters: the third round's other base, and it reads nothing but weak properness. (4) C132-WIT-SUPER stays where the asking
lane put it, but it brings a port (the disc averages) and so sits in tier C. (5) C132-TURN-EDGE and C132-PLACED-RING stay
out: each entry's own handoff says "only with a consumer".

**Tier A — next, on the exclusion's leaves and the port (second round)**

1. **C132-WIT-MARGIN** (grade as filed: hand) — rests on: the definitions (`Straddle`, `spatialSupport`) and the triangle inequality; about 15 lines; not a corollary. **Stated because it gives the four-point hypothesis of `no_outside_orbit_points` a kernel model** (the gate's inhabitant rule): labels absent near the ring are witnessed by every nearby point.

   > let c be a measurable map from the plane to a finite set of labels, H_i the closed essential support of the class of i, p a point, η > 0, and I a set of labels each of whose supports H_i misses the open annulus of the points z with 1 − η < |z − p| < 1 + η; then H_i ∩ Δ({p, q}) = ∅ for every i in I and every point q with 0 < |q − p| ≤ η; so if I has at least three labels, every cyclic order of three or more of them, with any such points q_j, satisfies the conclusion of C132-WIT-EX at p
   > — source: plans/FS132-derivation.md, entry C132-WIT-MARGIN, `statement:`

2. **C132-WIT-SIDE** (grade as filed: hand) — rests on: the definitions and `mem_spatialSupport_ae`; no properness, no palette; about 50 lines; not a corollary. The leaf under WIT-STRIP, CROSS, PLACE and LENS-SIDE (the asking lane's "item 1's first leaf"). The open-set form costs nothing here (no ported lemma is read).

   > let U be an open set of the plane, c a measurable map from U to a finite set of labels, H_i the closed essential support of the class of i, E a set of labels, x and q two distinct points with H_i ∩ Δ({x, q}) = ∅ for every i in E, and w a point of U with |w − x| = 1 and |w − q| ≠ 1; then there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has its label outside E if |w − q| < 1, and almost every point z of B(w, η) with |z − x| < 1 has its label outside E if |w − q| > 1
   > — source: plans/FS132-derivation.md, entry C132-WIT-SIDE, `statement:`

3. **C132-WIT-STRIP** (grade as filed: hand) — rests on: C132-WIT-SIDE and one inequality on `|x + r f − q|`; about 100 lines for the strips and the count. **Its last clause (the palette meets `N` almost everywhere) rests on the release's `outer_strip_trace` and `inner_strip_trace`** (`BoundaryTrace.lean:182, 210`), not in the port's present cone: state that clause as a separate theorem and ask for the two lemmas' port. Carries C132-TRI-STRIP's strip clauses.

   > let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable k-colouring of U, i_0, i_1, i_2 three distinct labels, N the set of the other k − 3 labels, and for each j modulo 3 let q_j be a point other than x with H_{i_j} ∩ Δ({x, q_j}) = ∅ and H_{i_{j+1}} ∩ Δ({x, q_j}) = ∅; then for every unit vector e with |x + e − q_j| ≠ 1 for j = 0, 1, 2 there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if |x + e − q_j| < 1 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if |x + e − q_j| > 1 for at least two j; the unit vectors f with |x + f − q_j| = 1 for some j are those with 2 f·(q_j − x) = |q_j − x|², at most six; and P_x(e), read with samplings inside U, meets N for almost every e
   > — source: plans/FS132-derivation.md, entry C132-WIT-STRIP, `statement:`

4. **C132-SHADOW** (grade as filed: hand) — rests on: weak properness alone (`WeakColoring`, Fubini for `(z, u) ↦ z + u`), an intermediate value; about 120 lines; not a corollary. The third round's base (C132-LENS).

   > let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, p and p′ two points of U with |p − p′| = 1, v a unit vector with v·(p′ − p) ≠ 0, r > 0, and W an open subset of U that contains the points p′ + sv for 0 < s < r and almost every point of which has the label i; then there is η > 0 such that, if v·(p′ − p) > 0, almost every point z of B(p, η) with |z − p′| < 1 has a label other than i, and, if v·(p′ − p) < 0, almost every point z of B(p, η) with |z − p′| > 1 has a label other than i
   > — source: plans/FS132-derivation.md, entry C132-SHADOW, `statement:`

5. **C132-CROSS** (grade as filed: hand) — rests on: C132-WIT-SIDE (its step B1) and that `z ↦ (|z − x|, |z − y|)` is a local homeomorphism at `w` (four non-empty open quadrants); no properness; about 150 lines.

   > let L be a finite set of labels, U an open set of the plane, c a measurable map from U to L, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, w a point of U with |w − x| = |w − y| = 1, and 𝒦_x, 𝒦_y two finite families of pairs (K, E) of a compact set K and a set E of labels with H_i ∩ Δ(K) = ∅ for every i in E, where Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1, with x ∈ K for the pairs of 𝒦_x and y ∈ K for the pairs of 𝒦_y; let E_x^out be the union of the sets E over the pairs of 𝒦_x whose K has a point q with |w − q| < 1, E_x^in the union over the pairs of 𝒦_x whose K has a point q with |w − q| > 1, E_y^out the union over the pairs of 𝒦_y whose K has a point q with |w − q| < 1, and E_y^in the union over the pairs of 𝒦_y whose K has a point q with |w − q| > 1; then none of the four sets E_x^out ∪ E_y^out, E_x^out ∪ E_y^in, E_x^in ∪ E_y^out, E_x^in ∪ E_y^in is all of L
   > — source: plans/FS132-derivation.md, entry C132-CROSS, `statement:`

6. **C132-COMP-SHARP** (grade as filed: derived from: C132-CROSS) — corollary of C132-CROSS by one pigeonhole; about 40 lines.

   > let U be an open set of the plane, c a measurable map from U to a set of six labels, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, t_0, t_1, t_2 and t′_0, t′_1, t′_2 the six labels, K_0, K_1, K_2 compact sets containing x with H_{t_j} ∩ Δ(K_j) = ∅ and H_{t_{j+1}} ∩ Δ(K_j) = ∅ for each j modulo 3, K′_0, K′_1, K′_2 compact sets containing y with H_{t′_j} ∩ Δ(K′_j) = ∅ and H_{t′_{j+1}} ∩ Δ(K′_j) = ∅ for each j modulo 3, and w a point of U with |w − x| = |w − y| = 1; then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w
   > — source: plans/FS132-derivation.md, entry C132-COMP-SHARP, `statement:`

7. **C132-PLACE** (grade as filed: hand) — rests on: the release's `palette_transfer_pair` (port), this module's `chart`, `chart_quasiMeasurePreserving`, `chart_eq_angularSum` (leaves of the exclusion), and C132-WIT-SIDE; about 120 lines; whole plane first. The base of the third round with C132-SHADOW.

   > let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, N the set of the three other labels, and ψ an angle such that at least two of the sets K_j have a point q with |x + e(ψ) − q| < 1; then there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and −κ < d < 0 the label of the point x + e(α) + e(α − 2π/3 − d) lies in N and in neither of the palettes P_x(e(α)) and P_x(e(α − 2π/3 − d)); and if at least two of the sets K_j have a point q with |x + e(ψ) − q| > 1, there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and 0 < d < κ the label of that point lies in N and in neither of those two palettes
   > — source: plans/FS132-derivation.md, entry C132-PLACE, `statement:`


**Tier B — the third round, on A**

8. **C132-LENS** (grade as filed: derived from: C132-SHADOW) — rests on: C132-PLACE at two ring points and C132-SHADOW; the entry's own handoff: "two charts read at y_1 and y_{−1}, then C132-SHADOW with the four segments"; about 200 lines.

   > let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a, b, n the three labels outside T, ψ an angle such that for almost every θ the palette P_x(e(θ)) contains a if θ lies in (ψ − π/3, ψ) or in (ψ + 2π/3, ψ + π), b if θ lies in (ψ, ψ + π/3) or in (ψ + π, ψ + 4π/3), and n if θ lies in (ψ + π/3, ψ + 2π/3) or in (ψ + 4π/3, ψ + 5π/3), and y_k = x + e(ψ + kπ/3); if at least two of the sets K_j have a point strictly inside the unit circle about y_1, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 has its label outside {a, n}; if at least two of the sets K_j have a point strictly inside the unit circle about y_{−1}, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_{−1}| < 1 has its label outside {b, n}; and if both hold, there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 and |z − y_{−1}| < 1 has its label in T
   > — source: plans/FS132-derivation.md, entry C132-LENS, `statement:`

9. **C132-LENS-SIDE** (grade as filed: derived from: C132-LENS) — corollary of C132-LENS and C132-WIT-SIDE by one open set of positive measure; about 50 lines.

   > let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that at least two of the sets K_j have a point strictly inside the unit circle about y_1 and at least two of them have a point strictly inside the unit circle about y_{−1}; then it is not the case that at least two of the sets K_j have a point strictly outside the unit circle about y_0
   > — source: plans/FS132-derivation.md, entry C132-LENS-SIDE, `statement:`

10. **C132-LENS-FOUR** (grade as filed: derived from: C132-LENS) — corollary of C132-LENS and C132-PLACE; about 80 lines.

   > let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and k an integer such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m; then y_k lies in the closed essential supports of a, of b, of n and of a label of T, and there is η > 0 such that almost every point of B(y_k, η) outside the unit circle about x has its label in {a, b, n} and almost every point of B(y_k, η) inside the unit circles about y_{k−1} and y_{k+1} has its label in T
   > — source: plans/FS132-derivation.md, entry C132-LENS-FOUR, `statement:`

11. **C132-LENS-GERM** (grade as filed: derived from: C132-LENS-SIDE) — a finite count on `ℤ/6` and C132-LENS-SIDE; about 80 lines.

   > let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that each of the sets K_0, K_1, K_2 has a point that lies strictly inside the unit circles about three of the six points y_0, …, y_5 and strictly outside the unit circles about the other three; then there is an integer k such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m
   > — source: plans/FS132-derivation.md, entry C132-LENS-GERM, `statement:`

12. **C132-ALT** (grade as filed: hand) — rests on: C132-PLACE at two adjacent ring points and the unit-pair relation of the exclusion's `Shift` module **for both signs of `d` and `d'`** — the exclusion's leaves state it for `d, d' ≥ 0` only, so `dist_chart_chart_shift` and `ShiftBounds` need signed companions (the same proofs on `[−1/4, 1/4]²`; numerically the unit distance holds there); about 250 lines. After the exclusion's module is green.

   > let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a and b two labels outside T, ψ an angle and δ > 0 such that for every integer k the palette P_x(e(θ)) contains a for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is even and for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is odd, and contains b for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is even and for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is odd; then there is no integer k such that, for both m = k and m = k + 1, at least two of the sets K_j have a point strictly inside the unit circle about x + e(ψ + mπ/3) or at least two of them have a point strictly outside it
   > — source: plans/FS132-derivation.md, entry C132-ALT, `statement:`


**Tier C — beside them: one label's superlevel sets, the centres, the index lemmas**

13. **C132-WIT-SUPER** (grade as filed: hand) — rests on: the ported `weak_all_directions` (in `Outside/OAI158Palette`) and the release's disc averages (`DiskAverages.lean`, 333 lines, at every `k`: a port); about 150 lines beside it. The asking lane's replacement for C132-EXT-DISC.

   > let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane, i a label, p_i^ε(z) the proportion of the disc of radius ε about z lying in the class of i, α > 0, (ε_n) a sequence of positive numbers tending to 0, C_n connected sets with p_i^{ε_n} > α at every point of C_n, and K the set of the limits of convergent sequences (z_n) with z_n in C_n; then no point of the closed essential support H_i has one point of K nearer than 1 and another farther than 1
   > — source: plans/FS132-derivation.md, entry C132-WIT-SUPER, `statement:`

14. **C132-CORES-SQUARE** (grade as filed: hand) — the skeleton's `exists_cyclicCentre_square`; rests on: `no_fine_cover_square` (from this library's `lebesgue_covering_square` and Mathlib's shrinking lemma: about 40 lines, nothing ported) and the hole chain of the release at `Fin k` on a square (`GraphRealization`, `HoleApproximation`, `Mesh`, `DiskExtension`, parts of `PlanarCovers`: about 1,900 lines with changed types, **and the mesh theorem's `2 < dist x y` made `1 + c₀ < dist x y`**): a planner-and-implementer job of its own. C132-CORES-FREE is its corollary (in the skeleton).

   > for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed axis-parallel square of side greater than 1 contains a cyclic centre; in particular every closed disc of radius greater than 1/√2 does
   > — source: plans/FS132-derivation.md, entry C132-CORES-SQUARE, `statement:`

15. **C132-INDEX** (grade as filed: hand) — in the claim list; the skeleton `Winding.lean` (9 leaves); nothing ported, no colouring; about 250 lines. An implementer can start at any time.

   > Let a, b, c be three labels, Θ the union of the edges ab, bc, ca of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6
   > — source: plans/FS132-derivation.md, entry C132-INDEX, `statement:`

16. **C132-RING-WIND** (grade as filed: derived from: C132-INDEX) — in the claim list; `Winding.lean` (6 leaves and a model); from `sixStep` directly (the planner's route) — the derivers' route through C132-INDEX is the second route; about 300 lines.

   > let N be a set of three labels, Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e, and J the set of the directions e having no arc about e on which Π is almost everywhere equal to one set; if J is finite and no two of its points are at angle π/3, then on each arc of S ∖ J the function Π is almost everywhere one singleton or one pair, two consecutive arcs carry subsets of one pair, and the closed walk they make around the triangle on N has winding number congruent to 3 modulo 6
   > — source: plans/FS132-derivation.md, entry C132-RING-WIND, `statement:`


**Left out of the module, and why.**

| entry | why |
|---|---|
| C132-TRI-STRIP | carried by C132-WIT-STRIP; its own form reads the extraction's continua and limiting directions, which the module does not hold until C132-EXT-DISC is taken up |
| C132-WITNESS | its handoff: "only with a consumer". The consumer would be the composition that carries the exclusion to map fragments (the record job's finding: one fact, this one); state it when that composition is posed — it shares C132-SHADOW's Fubini leaf |
| C132-WIT-CROSSED, C132-NOESS, C132-ORBIT (the measurable shadow of the winding), C132-SEP | relay results, handoff "none"; each short, each stated only with a consumer |
| C132-EXT-DISC, C132-FILL, C132-REL, C132-WIT-EX-FIN | the extraction with its continua: the largest item; clause (5) one mind; the asking lane's "wait". C132-WIT-EX-FIN is subsumed by it. They would share the centres' port (tier C) |
| C132-TURN-EDGE, C132-PLACED-RING | handoff "only with a consumer" |
| C132-WIT-ORBIT, C132-WIT-EXCL, C132-M-EMPTY, and § 10's forms as posed | the same theorems as stated ones (6.4), or instances of them |
| the search's five entries (§ 6) | results in a named finite family: certificates with their checker, not theorems of this module |
| C132-GRUNDY7-NOT, C132-GRUNDY7-LOCAL (§ 7) | calibrations at seven; their handoff: "nothing here is for the kernel" |
| the stalls and gaps (§ 8) | a stall has nothing to formalize. One exception already in the skeleton: C132-CORES-SQUARE's statement and its cover step (6.2) |

**What the list rests on that this library does not hold** (each is planned as a port or a leaf; **none is a new axiom
or a new hypothesis**; each is a request to the coordinator, not an action of this job):

1. `outer_strip_trace`, `inner_strip_trace` (`BoundaryTrace.lean:182, 210`) — for C132-WIT-STRIP's last clause only. The
   two placeholders stage 5 dropped come back for that entry and no other.
2. The release's disc averages (`DiskAverages.lean`, at every `k`) — for C132-WIT-SUPER.
3. The hole chain at `Fin k` on a square, with the mesh threshold a parameter — for C132-CORES-SQUARE and its corollary
   C132-CORES-FREE (6.2).
4. Signed companions of `dist_chart_chart_shift` and `ShiftBounds` (both signs of `d`, `d'`), in a module of their own
   beside `Shift` — for C132-ALT. Not a port: a leaf of ours.
5. For the exclusion itself (stage 5), unchanged: `palette_transfer_pair`, `palette_sixty_disjoint`,
   `two_state_impossible`, and by the coordinator's word of today `circleSum_quasiMeasurePreserving` (in the port's cone)
   and `angleMk_quasiMeasurePreserving` (asked for).

**The open-set forms.** Every statement above that names an open set `U` is planned at `U = ℂ` first, by the claim list's
dated line. Three need no ported lemma and could be stated at `U` at no cost when the coordinator wants them: C132-WIT-SIDE,
C132-CROSS, C132-COMP-SHARP (and C132-SHADOW once `WeakColoring` has a form on an open set).

**Built at this stage**: `./scripts/build.sh` under the slot after 6.1's proof — exit 0, 2 modules rebuilt (`TwoPairs`,
`Proofs`), 71 `sorry` warnings (`data/fs132/k2/probe/build-final.out`): 49 leaves of the exclusion, 3 placeholders, 16 + 3
in `Winding` and `CyclicCentre`. `tools/check_architecture.py`: PASS.

**The coordinator's reply to the stage-5 message** (2026-10-07, as received): lots C then B (`StepLemma.lean`, then
`Shift.lean`) are briefed for one implementer, FS132-I3, in a worktree `fs132-wi3` cut from `e0c95ec12`; lots A, D, E are not
yet assigned; `circleSum_quasiMeasurePreserving` is in the port's cone and `angleMk_quasiMeasurePreserving` is asked for;
the port measured about one fix per 375 lines and no Fourier chain. **Neither `StepLemma.lean` nor `Shift.lean` was touched
on this branch after `e0c95ec12`.**

### 7.1 Where a successor takes over

Nothing of this job is half done. In order of value: (1) when the port lands, delete `Placeholders.lean`, point its three
importers (`ChartMeasure`, `Excl`, and `TwoPairs` through `Excl`) at the ported modules, rebuild — no leaf changes; (2) the
skeletons of tier A (state C132-WIT-MARGIN, -WIT-SIDE, -WIT-STRIP, -SHADOW, -CROSS, -COMP-SHARP, -PLACE with `sorry`
leaves, each read back against its entry, the modeling passes run on them); (3) the centres' job (6.2) as its own
planner's brief; (4) the local forms (§ 3.6). The modeling companions (`debruijn-domain-modeling`,
`-obligation-modeling`) were not invoked as separate passes in this job: stage 5's statements were shaped while the
assembly was made to elaborate, and the budget went to that; a successor planning tier A should run them fresh.
