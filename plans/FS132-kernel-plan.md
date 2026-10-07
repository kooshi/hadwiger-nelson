# FS-132 — the kernel plan (FS132-K1): seven statements about measurable six-colourings, planned blind, then open

*The planner's record (de Bruijn, branch `fs132-wk1`, worktree `.claude/worktrees/fs132-wk1`). Brief:
`data/fs132/briefs/FS132-K1-kernel-plan.md` (on `main` at `e49499f57`). Claim list: `data/fs132/claims-K1.md` (on `main`; the
worktree was cut at `808ef9bf2`, one commit before it, so the list is read from the main tree). Current state only per stage;
each stage is saved before the next starts.*

## Theorems this phase proved

None in the kernel: a planning job. What it states is the skeleton (stage 3 onward); what it derived by hand, blind, is in the
stages below, each at grade [hand, one mind — the planner's, blind of the derivers'].

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
| `Plane/SixRing/Confine` | 124 | 0 | yes, no warning |
| `Plane/SixRing/Winding` | 196 | 16 | yes |
| `Plane/SixRing/Orbit` | 169 | 9 (5 OUTSIDE placeholders, `no_alternating_groups`, `no_alternating_pairs`, `no_outside_orbit`, `exists_change_of_ae_outside`, `ae_real_of_ae_angles` — 10 declarations, one warning per declaration) | yes |
| `Plane/SixRing/CyclicCentre` | 96 | 3 | yes |

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
`transition_avoiding_trace` does. (2) *A leaf of ours*: C132-CONFINE, six statements, 124 lines, three iterations (one
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
