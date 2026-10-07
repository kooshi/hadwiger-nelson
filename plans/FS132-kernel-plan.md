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
