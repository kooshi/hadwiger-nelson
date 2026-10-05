import Proofs.HadwigerNelson.Plane.ValidMap.Dense
import Proofs.HadwigerNelson.Plane.RingBand

/-!
# Row 134's base with unit arcs: the walk's leaves

The skeleton of `row134BaseUA`'s proof (job FS131-KB, `plans/FS131-w5base-kernel-plan.md`): FS112-N3-BASE's walk (`plans/FS112-N-proof.md`
stage N3-3; NB3 § 1.4 steps 1–12), which is `[SokolovVoronov2025]` Lemma 4's pigeonhole as FS110-CB D1–D6, FS110-CD Lemmas H, E, R and
Theorem D2, and FS110-CE's R1–R4 and Antipodal Lemma repaired it, with each use of Condition 5 replaced by a walked step. Everything is read
in the base's context `BaseCtx F u`: a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic trichromatic, `BaseHyp u` (H),
`NoInertNear u` and `UnenclosedC u` (FS131-E4's repair (b), inventory item 227) — the hypotheses of `Row134BaseUA`, which the walk refutes. So no statement here has a model (each is a step of a proof by
contradiction, refuted by `row134BaseUA`); the carrier `BaseCtx` is OUT of the vacuity scan.

The leaves, in the walk's order:
* **A — the pseudo-colouring of `ω(p)`** at a cubic trichromatic `p ∈ B̄(u, 1)`: nonempty, at most two colours, finitely many
  non-singleton points (`pseudo_nonempty`, `pseudo_ncard_le_two`, `pseudo_finite`), and the bridge to wave 3's `CircleColouring` with no swap
  point (`exists_pseudoCircle`; (i) is `pair_i`, the no-swap clause is `pair_ii` with `noBoth`).
* **B — circle-abstract**: the circle-only reduction (`reduce`, FS110-CD Lemma R step 5) and the selection (`select`: Lemma 5, BV-C6,
  Prop. 18 — BASE-V's BV-L5, BV-C6, BV-P18).
* **C — the planar core**: the returning arcs are removable and nest (`retArc_removable`, `retArcs_finite`, `retArcs_nested`), a
  non-returning change point has an endpoint (`exists_endpoint`: Prop. 19(b) with R1–R4 and Lemma E), and the eleventh point
  (`exists_eleventh`, proved from `BaseCtx.unenclosed` by FS131-E4's E4-RIM; KB's plan § 2.3 found it a GAP without that hypothesis: the
  sources obtain it after hole-filling, which can destroy `u`).
* **D — the refuters and distances**: `endpoint_dist_ge` (the `a`-side tiles), `vin_antipodal`, `eleventh_antipodal` (Theorem D2 / the
  Antipodal Lemma), `cor3_base` (FS112-N3-COR3 under H), `l3_base` (Lemma 3 in pseudo-colour form: the circles may carry in- and
  out-contact unit arcs, so wave 5's `bv_l3` with `RingProper` does not apply — plan § 2.2), `hex_base` (Prop. 17 through `p17_ua`).
* **E — the count**: `eleventh_type` (the complement of the eleventh point's type is an endpoint type).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

/-! ## The base's context -/

/-- **The base's context at `u`** (`Row134BaseUA`'s hypotheses, bundled): a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic
trichromatic, no point of `F(M) ∪ R(M)` in `B̄(u, 2)`, no inert unit arc centred within `1` of `u`, no tile of a colour of `u` enclosing a
tile at `u`. Refuted by `row134BaseUA`; every theorem of this file is a step of that refutation (no model expected). -/
structure BaseCtx (F : ArcMap 6) (u : ℂ) : Prop where
  /-- The fragment is valid. -/
  valid : F.Valid
  /-- It covers `B̄(u, 2)`. -/
  covers : F.Covers u 2
  /-- `u` is cubic trichromatic. -/
  cubic : F.IsCubicTrichromatic u
  /-- H: no point of `F(M) ∪ R(M)` in `B̄(u, 2)`. -/
  hyp : F.BaseHyp u
  /-- No inert unit arc centred within `1` of `u`. -/
  noInert : F.NoInertNear u
  /-- No tile of a colour of `u` encloses a tile at `u`. -/
  unenclosed : F.UnenclosedC u

/-- A point is **V-in** relative to `u` (FS110-CD § 2.3): a point of `ω(u)` some tile of whose colours carried at `u` meets `B(u, 1)`. -/
def VIn (F : ArcMap k) (u p : ℂ) : Prop :=
  dist p u = 1 ∧ ∃ i ∈ F.coloursAt u, ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty

/-- **An endpoint** for the change pair `{a, c}` at `x` (FS110-CD Lemma E, over the tiles, path-free): a three-colour point `p` in the
closures of the `a`-tile and the `c`-tile at `x`, inside `B(u, 1)` or V-in on `ω(u)`. -/
def IsEndpoint (F : ArcMap k) (u x : ℂ) (a c : Fin k) (p : ℂ) : Prop :=
  (F.coloursAt p).ncard = 3 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧
    ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ x ∈ closure T₁ ∧ x ∈ closure T₂ ∧ p ∈ closure T₁ ∧ p ∈ closure T₂

/-- **A returning pair** of `ω(u)` (FS110-CD Lemma R, `plans/FS110-CD-verification.md` § 2.4, l. 200: "a returning pair joined by `β` (an `a|c`
boundary path in the closed disc)"): two distinct change points `r(s)`, `r(t)` of the pseudo-colouring of `ω(u)`, `s < t < s + 60°`, switching
between the same two colours `a`, `c` (with `c` just inside `[s, t]` at both ends and `a` just outside), joined by an `a|c` boundary in the
closed disc — a connected set `K` holding both ends inside the closures of one `a`-tile and one `c`-tile and inside `B̄(u, 1)` (CD's `β`, read
as a continuum rather than a path). The clause `K` is FS131-I5's repair (inventory items 231–232): without it a single `a|c` boundary crossing
`ω(u)` at `0°`, `20°`, `40°` makes `[0°, 20°]` and `[20°, 40°]` both returning, abutting at `r(20°)`, and nesting (`retArcs_nested`) fails. -/
def IsRetArc (F : ArcMap k) (u : ℂ) (s t : ℝ) : Prop :=
  s < t ∧ t < s + π / 3 ∧ ∃ a c, a ≠ c ∧ F.GermPseudo u s .cw a ∧ F.GermPseudo u s .ccw c ∧ F.GermPseudo u t .cw c ∧
    F.GermPseudo u t .ccw a ∧ ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧
      ∃ K, IsConnected K ∧ ringPt u s ∈ K ∧ ringPt u t ∈ K ∧ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1

end ArcMap

namespace CircleColouring

variable (C : CircleColouring)

/-- **A removable arc** of a circle colouring (FS110-CD Lemma R steps 2–3, circle-abstract): `[s, t]` of length under `60°`, both ends change
points with `c` just inside and `a ≠ c` just outside, and every partner `x ± 60°` of an inner point, off the change set, of the third colour. -/
def Removable (s t : ℝ) : Prop :=
  s < t ∧ t < s + π / 3 ∧ s ∈ C.S ∧ t ∈ C.S ∧ ∃ a c, a ≠ c ∧ C.LeftVal s a ∧ C.RightVal s c ∧ C.LeftVal t c ∧ C.RightVal t a ∧
    ∀ x ∈ Ioo s t, ∀ y, (y = x + π / 3 ∨ y = x - π / 3) → y ∉ C.S → C.c y ≠ a ∧ C.c y ≠ c

/-- The point `x` is a change point with the pair `{v, w}` (in either order). -/
def ChangeWith (x : ℝ) (v w : ZMod 3) : Prop :=
  x ∈ C.S ∧ ((C.LeftVal x v ∧ C.RightVal x w) ∨ (C.LeftVal x w ∧ C.RightVal x v))

/-- **The rotating hexagon** of a circle colouring: six change points at exact `60°` spacing, `b j` just before the `j`-th and `b (j + 1)` just
after (BV-C6's `n = 6` case; Prop. 17's configuration). -/
def IsHex (ψ : ℝ) (b : ZMod 3 → ZMod 3) : Prop :=
  Function.Injective b ∧ ∀ j : ℕ, j < 6 → C.LeftVal (ψ + j * (π / 3)) (b j) ∧ C.RightVal (ψ + j * (π / 3)) (b (j + 1))

/-! ### The reduction's machinery (FS131-I5g): a locally finite, nested-or-disjoint family of short spans, its maximal members, and a
colouring that is the outer colour on each maximal span and the original colour elsewhere -/

section ReduceAux

variable {C}

/-- Left values are invariant under the period. -/
theorem reduce_leftVal_add_int_mul {x : ℝ} (n : ℤ) {v : ZMod 3} : C.LeftVal (x + n * (2 * π)) v ↔ C.LeftVal x v := by
  constructor
  · intro h
    filter_upwards [eventually_lt_add (x := x) (a := n * (2 * π)) h] with y hy
    rwa [C.periodic.int_mul n y] at hy
  · intro h
    have h' : ∀ᶠ y in 𝓝[<] (x + n * (2 * π) + -(n * (2 * π))), C.c y = v := by rw [add_neg_cancel_right]; exact h
    filter_upwards [eventually_lt_add (x := x + n * (2 * π)) (a := -(n * (2 * π))) h'] with y hy
    rwa [show y + -(n * (2 * π)) = y - n * (2 * π) by ring, C.periodic.sub_int_mul_eq n] at hy

/-- Right values are invariant under the period. -/
theorem reduce_rightVal_add_int_mul {x : ℝ} (n : ℤ) {v : ZMod 3} : C.RightVal (x + n * (2 * π)) v ↔ C.RightVal x v := by
  constructor
  · intro h
    filter_upwards [eventually_gt_add (x := x) (a := n * (2 * π)) h] with y hy
    rwa [C.periodic.int_mul n y] at hy
  · intro h
    have h' : ∀ᶠ y in 𝓝[>] (x + n * (2 * π) + -(n * (2 * π))), C.c y = v := by rw [add_neg_cancel_right]; exact h
    filter_upwards [eventually_gt_add (x := x + n * (2 * π)) (a := -(n * (2 * π))) h'] with y hy
    rwa [show y + -(n * (2 * π)) = y - n * (2 * π) by ring, C.periodic.sub_int_mul_eq n] at hy

/-- A removable arc shifted by a whole number of periods is removable. -/
theorem Removable.add_int_mul {s t : ℝ} (h : C.Removable s t) (n : ℤ) :
    C.Removable (s + n * (2 * π)) (t + n * (2 * π)) := by
  obtain ⟨hst, hts, hs, ht, a, c, hac, h1, h2, h3, h4, hpart⟩ := h
  refine ⟨by linarith, by linarith, (C.mem_S_add_int n s).mpr hs, (C.mem_S_add_int n t).mpr ht, a, c, hac,
    (reduce_leftVal_add_int_mul n).mpr h1, (reduce_rightVal_add_int_mul n).mpr h2, (reduce_leftVal_add_int_mul n).mpr h3,
    (reduce_rightVal_add_int_mul n).mpr h4, ?_⟩
  intro x hx y hy hyS
  have hx' : x - n * (2 * π) ∈ Ioo s t := ⟨by linarith [hx.1], by linarith [hx.2]⟩
  have hyS' : y - n * (2 * π) ∉ C.S := by
    rw [← C.mem_S_add_int n]; simpa using hyS
  have := hpart _ hx' (y - n * (2 * π)) (by rcases hy with rfl | rfl <;> [left; right] <;> ring) hyS'
  rwa [C.periodic.sub_int_mul_eq n] at this

/-- Near `x`, only members of a locally finite family of short closed intervals that contain `x` cover. -/
theorem reduce_nearOnly {𝓚 : Set (ℝ × ℝ)} (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite) (x : ℝ) :
    ∀ᶠ y in 𝓝 x, ∀ p ∈ 𝓚, y ∈ Icc p.1 p.2 → x ∈ Icc p.1 p.2 := by
  set A := {p ∈ 𝓚 | p.1 ∈ Icc (x - 3) (x + 1)}
  have hA : A.Finite := hlf _ _
  have h1 : ∀ᶠ y in 𝓝 x, ∀ p ∈ A, x ∉ Icc p.1 p.2 → y ∉ Icc p.1 p.2 := by
    rw [Filter.eventually_all_finite hA]
    intro p _
    by_cases hx : x ∈ Icc p.1 p.2
    · exact Filter.Eventually.of_forall fun y h => absurd hx h
    · filter_upwards [isClosed_Icc.isOpen_compl.mem_nhds hx] with y hy _ using hy
  have h2 : Ioo (x - 1) (x + 1) ∈ 𝓝 x := Ioo_mem_nhds (by linarith) (by linarith)
  filter_upwards [h1, h2] with y hy hy2 p hp hyp
  by_contra hxp
  have hpA : p ∈ A := ⟨hp, by constructor <;> linarith [hyp.1, hyp.2, (hlen p hp).2, hy2.1, hy2.2]⟩
  exact hy p hpA hxp hyp

/-- A covered point lies in a maximal member: one that holds every member meeting it. -/
theorem reduce_exists_max {𝓚 : Set (ℝ × ℝ)} (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hnest : ∀ p ∈ 𝓚, ∀ p' ∈ 𝓚, Disjoint (Icc p.1 p.2) (Icc p'.1 p'.2) ∨ Icc p.1 p.2 ⊆ Icc p'.1 p'.2 ∨
      Icc p'.1 p'.2 ⊆ Icc p.1 p.2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite) {θ : ℝ} (h : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2) :
    ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 ∧ ∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2 := by
  set A := {p ∈ 𝓚 | θ ∈ Icc p.1 p.2}
  have hA : A.Finite := (hlf (θ - 2) θ).subset fun p ⟨hp, hθ⟩ =>
    ⟨hp, by constructor <;> linarith [hθ.1, hθ.2, (hlen p hp).2]⟩
  obtain ⟨p₀, hp₀⟩ := h
  obtain ⟨p, hpA, hmax⟩ := hA.toFinset.exists_max_image (fun p => p.2 - p.1) ⟨p₀, hA.mem_toFinset.mpr hp₀⟩
  rw [hA.mem_toFinset] at hpA
  refine ⟨p, hpA.1, hpA.2, fun p' hp' hne => ?_⟩
  rcases hnest p' hp' p hpA.1 with hd | hs | hs
  · exact absurd hne (Set.not_nonempty_iff_eq_empty.mpr (Set.disjoint_iff_inter_eq_empty.mp hd))
  · exact hs
  · have hp'A : p' ∈ A := ⟨hp', hs hpA.2⟩
    have hl := hmax p' (hA.mem_toFinset.mpr hp'A)
    rw [Icc_subset_Icc_iff (hlen p hpA.1).1.le] at hs
    rw [Icc_subset_Icc_iff (hlen p' hp').1.le]
    constructor <;> linarith [hs.1, hs.2]


/-- Left of a maximal member's left end, no member covers. -/
theorem reduce_left_uncov {𝓚 : Set (ℝ × ℝ)} (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite) {p : ℝ × ℝ} (hp : p ∈ 𝓚)
    (hmax : ∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2) :
    ∀ᶠ y in 𝓝[<] p.1, ∀ p' ∈ 𝓚, y ∉ Icc p'.1 p'.2 := by
  filter_upwards [nhdsWithin_le_nhds (reduce_nearOnly hlen hlf p.1), self_mem_nhdsWithin] with y hy hyl p' hp' hyp'
  have hsub := hmax p' hp' ⟨p.1, hy p' hp' hyp', le_rfl, (hlen p hp).1.le⟩
  exact absurd (mem_Iio.mp hyl) (not_lt.mpr (hsub hyp').1)

/-- Right of a maximal member's right end, no member covers. -/
theorem reduce_right_uncov {𝓚 : Set (ℝ × ℝ)} (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite) {p : ℝ × ℝ} (hp : p ∈ 𝓚)
    (hmax : ∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2) :
    ∀ᶠ y in 𝓝[>] p.2, ∀ p' ∈ 𝓚, y ∉ Icc p'.1 p'.2 := by
  filter_upwards [nhdsWithin_le_nhds (reduce_nearOnly hlen hlf p.2), self_mem_nhdsWithin] with y hy hyl p' hp' hyp'
  have hsub := hmax p' hp' ⟨p.2, hy p' hp' hyp', (hlen p hp).1.le, le_rfl⟩
  exact absurd (mem_Ioi.mp hyl) (not_lt.mpr (hsub hyp').2)

/-- Three colours: two values avoiding two distinct colours agree. -/
theorem reduce_zmod3 {a c v w : ZMod 3} (hac : a ≠ c) (hv : v ≠ a ∧ v ≠ c) (hw : w ≠ a ∧ w ≠ c) : v = w := by
  revert a c v w; decide

/-- **A partner of an inner point is no genuine change point** (FS131-I5f's hand check of CD § 2.4 step 5, from the partner clause
alone): if every point `y = x ± 60°` off `S` with `x ∈ (s, t)` avoids `a` and `c`, then at any `x` of `(s, t) ± 60°` the one-sided values
agree. -/
theorem reduce_partner_noChange {s t : ℝ} {a c : ZMod 3} (hac : a ≠ c)
    (hpart : ∀ x ∈ Ioo s t, ∀ y, (y = x + π / 3 ∨ y = x - π / 3) → y ∉ C.S → C.c y ≠ a ∧ C.c y ≠ c)
    {δ : ℝ} (hδ : δ = π / 3 ∨ δ = -(π / 3)) {x : ℝ} (hx : x ∈ Ioo (s + δ) (t + δ)) {v w : ZMod 3}
    (hv : C.LeftVal x v) (hw : C.RightVal x w) : v = w := by
  have hU : ∀ᶠ y in 𝓝 x, y ∈ Ioo (s + δ) (t + δ) := isOpen_Ioo.mem_nhds hx
  have key : ∀ z ∈ Ioo (s + δ) (t + δ), z ∉ C.S → C.c z ≠ a ∧ C.c z ≠ c := fun z hz hzS =>
    hpart (z - δ) ⟨by linarith [hz.1], by linarith [hz.2]⟩ z (by rcases hδ with rfl | rfl <;> [left; right] <;> ring) hzS
  obtain ⟨z₁, hz₁v, hz₁S, hz₁U⟩ := (hv.and ((C.eventually_notMem_S_lt x).and (nhdsWithin_le_nhds hU))).exists
  obtain ⟨z₂, hz₂w, hz₂S, hz₂U⟩ := (hw.and ((C.eventually_notMem_S_gt x).and (nhdsWithin_le_nhds hU))).exists
  have h1 := key z₁ hz₁U hz₁S
  have h2 := key z₂ hz₂U hz₂S
  rw [hz₁v] at h1; rw [hz₂w] at h2
  exact reduce_zmod3 hac h1 h2

/-- A circle colouring's values just left of `x` and of `x + 60°` differ (properness). -/
theorem reduce_leftVal_ne (D : CircleColouring) {x : ℝ} {v w : ZMod 3} (hv : D.LeftVal x v) (hw : D.LeftVal (x + π / 3) w) :
    v ≠ w := by
  have hw' : ∀ᶠ z in 𝓝[<] x, D.c (z + π / 3) = w := eventually_lt_add hw
  have hS' : ∀ᶠ z in 𝓝[<] x, z + π / 3 ∉ D.S := eventually_lt_add (D.eventually_notMem_S_lt (x + π / 3))
  obtain ⟨z, h1, h2, h3, h4⟩ := (hv.and (hw'.and ((D.eventually_notMem_S_lt x).and hS'))).exists
  intro hvw
  exact D.proper z h3 h4 (by rw [h1, h2, hvw])

/-- At a point where a circle colouring is locally constant, its one-sided values are its value there. -/
theorem reduce_vals_of_const (D : CircleColouring) {x : ℝ} (h : ∀ᶠ y in 𝓝 x, D.c y = D.c x) {v w : ZMod 3}
    (hv : D.LeftVal x v) (hw : D.RightVal x w) : v = w := by
  obtain ⟨z₁, h1, h1'⟩ := (hv.and (nhdsWithin_le_nhds h)).exists
  obtain ⟨z₂, h2, h2'⟩ := (hw.and (nhdsWithin_le_nhds h)).exists
  rw [← h1, ← h2, h1', h2']

section Generic

variable {𝓚 : Set (ℝ × ℝ)} {c' : ℝ → ZMod 3}

/-- **Local constancy of the reduced colouring** off the reduced change set. -/
theorem reduce_locConst (hrem : ∀ p ∈ 𝓚, C.Removable p.1 p.2) (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hnest : ∀ p ∈ 𝓚, ∀ p' ∈ 𝓚, Disjoint (Icc p.1 p.2) (Icc p'.1 p'.2) ∨ Icc p.1 p.2 ⊆ Icc p'.1 p'.2 ∨
      Icc p'.1 p'.2 ⊆ Icc p.1 p.2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite)
    (hc1 : ∀ θ, (∀ p ∈ 𝓚, θ ∉ Icc p.1 p.2) → c' θ = C.c θ)
    (hc2 : ∀ p ∈ 𝓚, (∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2) →
      ∀ θ ∈ Icc p.1 p.2, C.LeftVal p.1 (c' θ))
    {θ : ℝ} (hθ : θ ∉ C.S ∨ ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2) : ∀ᶠ y in 𝓝 θ, c' y = c' θ := by
  by_cases hcov : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2
  · obtain ⟨p, hp, hθp, hmax⟩ := reduce_exists_max hlen hnest hlf hcov
    obtain ⟨-, -, -, -, a, c, -, h1a, -, -, h2a, -⟩ := hrem p hp
    have hval : ∀ y ∈ Icc p.1 p.2, c' y = a := fun y hy => LeftVal.unique (hc2 p hp hmax y hy) h1a
    have hlt := (hlen p hp).1
    suffices h : ∀ᶠ y in 𝓝 θ, c' y = a by
      filter_upwards [h] with y hy using hy.trans (hval θ hθp).symm
    rcases eq_or_lt_of_le hθp.1 with h1 | h1
    · -- the left end
      rw [← h1, ← nhdsLT_sup_nhdsGE, Filter.eventually_sup]
      refine ⟨?_, ?_⟩
      · filter_upwards [reduce_left_uncov hlen hlf hp hmax, h1a] with y hy hya
        rw [hc1 y hy, hya]
      · filter_upwards [Icc_mem_nhdsGE hlt] with y hy using hval y hy
    rcases eq_or_lt_of_le hθp.2 with h2 | h2
    · -- the right end
      rw [h2, ← nhdsLE_sup_nhdsGT, Filter.eventually_sup]
      refine ⟨?_, ?_⟩
      · filter_upwards [Icc_mem_nhdsLE hlt] with y hy using hval y hy
      · filter_upwards [reduce_right_uncov hlen hlf hp hmax, h2a] with y hy hya
        rw [hc1 y hy, hya]
    · filter_upwards [Icc_mem_nhds h1 h2] with y hy using hval y hy
  · push Not at hcov
    have hθS : θ ∉ C.S := hθ.resolve_right (by push Not; exact hcov)
    filter_upwards [reduce_nearOnly hlen hlf θ, C.locallyConstant θ hθS] with y hy hyc
    rw [hc1 θ hcov, hc1 y fun p hp hyp => hcov p hp (hy p hp hyp), hyc]

/-- **Properness of the reduced colouring** at two points off the original change set. -/
theorem reduce_proper_off (hrem : ∀ p ∈ 𝓚, C.Removable p.1 p.2) (hlen : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2)
    (hnest : ∀ p ∈ 𝓚, ∀ p' ∈ 𝓚, Disjoint (Icc p.1 p.2) (Icc p'.1 p'.2) ∨ Icc p.1 p.2 ⊆ Icc p'.1 p'.2 ∨
      Icc p'.1 p'.2 ⊆ Icc p.1 p.2)
    (hlf : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite)
    (hc1 : ∀ θ, (∀ p ∈ 𝓚, θ ∉ Icc p.1 p.2) → c' θ = C.c θ)
    (hc2 : ∀ p ∈ 𝓚, (∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2) →
      ∀ θ ∈ Icc p.1 p.2, C.LeftVal p.1 (c' θ))
    {y : ℝ} (hy : y ∉ C.S) (hy' : y + π / 3 ∉ C.S) : c' y ≠ c' (y + π / 3) := by
  have hio : ∀ p ∈ 𝓚, C.Removable p.1 p.2 → ∀ z, z ∉ C.S → z ∈ Icc p.1 p.2 → z ∈ Ioo p.1 p.2 := by
    rintro p - ⟨-, -, hs, ht, -⟩ z hz hzp
    exact ⟨lt_of_le_of_ne hzp.1 fun h => hz (h ▸ hs), lt_of_le_of_ne hzp.2 fun h => hz (h.symm ▸ ht)⟩
  by_cases h1 : ∃ p ∈ 𝓚, y ∈ Icc p.1 p.2 <;> by_cases h2 : ∃ p ∈ 𝓚, y + π / 3 ∈ Icc p.1 p.2
  · obtain ⟨p, hp, hyp, hmax⟩ := reduce_exists_max hlen hnest hlf h1
    obtain ⟨p', hp', hyp', hmax'⟩ := reduce_exists_max hlen hnest hlf h2
    have hyo := hio p hp (hrem p hp) y hy hyp
    have hyo' := hio p' hp' (hrem p' hp') _ hy' hyp'
    obtain ⟨-, -, -, -, a, c, hac, h1a, h1c, -, -, hpart⟩ := hrem p hp
    obtain ⟨-, -, -, -, a', c₂, hac', h1a', h1c', -, -, hpart'⟩ := hrem p' hp'
    rw [LeftVal.unique (hc2 p hp hmax y hyp) h1a, LeftVal.unique (hc2 p' hp' hmax' _ hyp') h1a']
    have hA : p'.1 ≤ p.1 + π / 3 := by
      by_contra hlt; push Not at hlt
      exact hac' (reduce_partner_noChange hac hpart (Or.inl rfl) ⟨hlt, by linarith [hyo'.1, hyo.2]⟩ h1a' h1c')
    have hB : p.1 ≤ p'.1 - π / 3 := by
      by_contra hlt; push Not at hlt
      exact hac (reduce_partner_noChange hac' hpart' (Or.inr rfl) ⟨by linarith, by linarith [hyo.1, hyo'.2]⟩ h1a h1c)
    have heq : p.1 + π / 3 = p'.1 := by linarith
    rw [← heq] at h1a'
    exact reduce_leftVal_ne C h1a h1a'
  · obtain ⟨p, hp, hyp, hmax⟩ := reduce_exists_max hlen hnest hlf h1
    have hyo := hio p hp (hrem p hp) y hy hyp
    obtain ⟨-, -, -, -, a, c, -, h1a, -, -, -, hpart⟩ := hrem p hp
    push Not at h2
    rw [LeftVal.unique (hc2 p hp hmax y hyp) h1a, hc1 _ h2]
    exact (hpart y hyo (y + π / 3) (Or.inl rfl) hy').1.symm
  · obtain ⟨p, hp, hyp, hmax⟩ := reduce_exists_max hlen hnest hlf h2
    have hyo := hio p hp (hrem p hp) _ hy' hyp
    obtain ⟨-, -, -, -, a, c, -, h1a, -, -, -, hpart⟩ := hrem p hp
    push Not at h1
    rw [LeftVal.unique (hc2 p hp hmax _ hyp) h1a, hc1 _ h1]
    exact (hpart _ hyo y (Or.inr (by ring)) hy).1
  · push Not at h1 h2
    rw [hc1 _ h1, hc1 _ h2]
    exact C.proper y hy hy'

end Generic


/-- An integer multiple of `2π` shorter than `2π` is zero. -/
theorem reduce_int_eq_zero {n : ℤ} (h : |(n : ℝ) * (2 * π)| < 2 * π) : n = 0 := by
  have hπ := Real.pi_pos
  rw [abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * π)] at h
  have h1 : |(n : ℝ)| < 1 := by nlinarith [abs_nonneg (n : ℝ)]
  have : |n| < 1 := by exact_mod_cast h1
  exact Int.abs_lt_one_iff.mp this

end ReduceAux

/-- **The circle-only reduction** (FS110-CD Lemma R steps 4–5; CE's R3): recolouring each maximal arc of a finite, pairwise nested-or-disjoint
family of removable arcs by its outer colour leaves a circle colouring with no swap point, whose change points are change points of the
original outside the arcs' closed spans, with the same one-sided colours. Circle-abstract. -/
theorem reduce (hns : ∀ x, ¬ C.IsSwap x) (𝓙 : Set (ℝ × ℝ)) (hfin : 𝓙.Finite) (hrem : ∀ q ∈ 𝓙, C.Removable q.1 q.2)
    (hnest : ∀ q ∈ 𝓙, ∀ q' ∈ 𝓙, Disjoint (e '' Icc q.1 q.2) (e '' Icc q'.1 q'.2) ∨ e '' Icc q.1 q.2 ⊆ e '' Icc q'.1 q'.2 ∨
      e '' Icc q'.1 q'.2 ⊆ e '' Icc q.1 q.2) :
    ∃ C' : CircleColouring, (∀ x, ¬ C'.IsSwap x) ∧
      ∀ x ∈ C'.S, x ∈ C.S ∧ (∀ q ∈ 𝓙, e x ∉ e '' Icc q.1 q.2) ∧ ∀ v, (C'.LeftVal x v ↔ C.LeftVal x v) ∧ (C'.RightVal x v ↔ C.RightVal x v) := by
  classical
  have hπ := Real.pi_pos
  have hπ3 : π / 3 < 2 := by linarith [Real.pi_lt_four]
  -- the periodic family of real spans
  set 𝓚 : Set (ℝ × ℝ) := {p | ∃ q ∈ 𝓙, ∃ m : ℤ, p = (q.1 + m * (2 * π), q.2 + m * (2 * π))} with h𝓚
  have hremK : ∀ p ∈ 𝓚, C.Removable p.1 p.2 := by
    rintro p ⟨q, hq, m, rfl⟩; exact (hrem q hq).add_int_mul m
  have hlenK : ∀ p ∈ 𝓚, p.1 < p.2 ∧ p.2 ≤ p.1 + 2 := fun p hp =>
    ⟨(hremK p hp).1, by linarith [(hremK p hp).2.1]⟩
  have hlen3 : ∀ p ∈ 𝓚, p.2 < p.1 + π / 3 := fun p hp => (hremK p hp).2.1
  have hperK : ∀ p ∈ 𝓚, ∀ n : ℤ, (p.1 + n * (2 * π), p.2 + n * (2 * π)) ∈ 𝓚 := by
    rintro p ⟨q, hq, m, rfl⟩ n
    exact ⟨q, hq, m + n, by simp only [Prod.mk.injEq]; push_cast; constructor <;> ring⟩
  have hlfK : ∀ a b : ℝ, {p ∈ 𝓚 | p.1 ∈ Icc a b}.Finite := by
    intro a b
    refine (hfin.biUnion fun q _ => ((Set.finite_Icc ⌊(a - q.1) / (2 * π)⌋ ⌈(b - q.1) / (2 * π)⌉).image
      fun m : ℤ => (q.1 + m * (2 * π), q.2 + m * (2 * π)))).subset ?_
    rintro p ⟨⟨q, hq, m, rfl⟩, hpa, hpb⟩
    simp only [mem_iUnion, mem_image, mem_Icc]
    refine ⟨q, hq, m, ⟨?_, ?_⟩, rfl⟩
    · have : (a - q.1) / (2 * π) ≤ m := by rw [div_le_iff₀ (by positivity)]; linarith
      exact Int.cast_le.mp ((Int.floor_le _).trans this)
    · have : (m : ℝ) ≤ (b - q.1) / (2 * π) := by rw [le_div_iff₀ (by positivity)]; linarith
      exact Int.cast_le.mp (this.trans (Int.le_ceil _))
  -- the shift lemma: a point of a short span whose `e` lies in another short span meeting it lies in it
  have hshift : ∀ (a' b' w z z' : ℝ), b' - a' < π / 3 → w ∈ Icc a' b' → z' ∈ Icc a' b' → e z' = e z → |z - w| ≤ π / 3 →
      z ∈ Icc a' b' := by
    intro a' b' w z z' hl hw hz' hze hzw
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp hze
    have hn0 : n = 0 := reduce_int_eq_zero (by
      rw [show (n : ℝ) * (2 * π) = z' - z by linarith, abs_lt]
      rw [abs_le] at hzw
      constructor <;> linarith [hw.1, hw.2, hz'.1, hz'.2])
    subst hn0
    simp only [Int.cast_zero, zero_mul, add_zero] at hn
    exact hn ▸ hz'
  have heshift : ∀ (x : ℝ) (m : ℤ), e (x + m * (2 * π)) = e x := fun x m => e_eq_e_iff.mpr ⟨m, rfl⟩
  have hnestK : ∀ p ∈ 𝓚, ∀ p' ∈ 𝓚, Disjoint (Icc p.1 p.2) (Icc p'.1 p'.2) ∨ Icc p.1 p.2 ⊆ Icc p'.1 p'.2 ∨
      Icc p'.1 p'.2 ⊆ Icc p.1 p.2 := by
    -- the image of a shifted span
    have himg : ∀ q : ℝ × ℝ, ∀ m : ℤ, e '' Icc (q.1 + m * (2 * π)) (q.2 + m * (2 * π)) = e '' Icc q.1 q.2 := by
      intro q m
      ext z
      simp only [mem_image, mem_Icc]
      constructor
      · rintro ⟨x, hx, rfl⟩
        exact ⟨x - m * (2 * π), ⟨by linarith [hx.1], by linarith [hx.2]⟩, by
          rw [← heshift (x - m * (2 * π)) m, sub_add_cancel]⟩
      · rintro ⟨x, hx, rfl⟩
        exact ⟨x + m * (2 * π), ⟨by linarith [hx.1], by linarith [hx.2]⟩, heshift x m⟩
    -- a nested image, with a common point, nests the real spans
    have hsub : ∀ p ∈ 𝓚, ∀ p' ∈ 𝓚, (Icc p.1 p.2 ∩ Icc p'.1 p'.2).Nonempty →
        e '' Icc p.1 p.2 ⊆ e '' Icc p'.1 p'.2 → Icc p.1 p.2 ⊆ Icc p'.1 p'.2 := by
      intro p hp p' hp' ⟨w, hw, hw'⟩ himp
      have hl' : p'.2 - p'.1 < π / 3 := by linarith [hlen3 p' hp']
      have hend : ∀ z ∈ Icc p.1 p.2, z ∈ Icc p'.1 p'.2 := by
        intro z hz
        obtain ⟨z', hz', hze⟩ := himp ⟨z, hz, rfl⟩
        refine hshift _ _ w z z' hl' hw' hz' hze ?_
        rw [abs_le]; constructor <;> linarith [hz.1, hz.2, hw.1, hw.2, hlen3 p hp]
      exact fun z hz => hend z hz
    intro p hp p' hp'
    by_cases hd : Disjoint (Icc p.1 p.2) (Icc p'.1 p'.2)
    · exact Or.inl hd
    have hne : (Icc p.1 p.2 ∩ Icc p'.1 p'.2).Nonempty := Set.not_disjoint_iff_nonempty_inter.mp hd
    obtain ⟨q, hq, m, rfl⟩ := hp
    obtain ⟨q', hq', m', rfl⟩ := hp'
    rcases hnest q hq q' hq' with hdis | hs | hs
    · exfalso
      obtain ⟨w, hw, hw'⟩ := hne
      have h1 : e w ∈ e '' Icc q.1 q.2 := by rw [← himg q m]; exact ⟨w, hw, rfl⟩
      have h2 : e w ∈ e '' Icc q'.1 q'.2 := by rw [← himg q' m']; exact ⟨w, hw', rfl⟩
      exact Set.disjoint_left.mp hdis h1 h2
    · right; left
      refine hsub _ ⟨q, hq, m, rfl⟩ _ ⟨q', hq', m', rfl⟩ hne ?_
      simp only; rw [himg q m, himg q' m']; exact hs
    · right; right
      refine hsub _ ⟨q', hq', m', rfl⟩ _ ⟨q, hq, m, rfl⟩ (by rwa [Set.inter_comm]) ?_
      simp only; rw [himg q m, himg q' m']; exact hs
  have hcovE : ∀ θ, ∀ q ∈ 𝓙, e θ ∈ e '' Icc q.1 q.2 → ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 := by
    rintro θ q hq ⟨z, hz, hze⟩
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp hze
    refine ⟨(q.1 + ((-n : ℤ) : ℝ) * (2 * π), q.2 + ((-n : ℤ) : ℝ) * (2 * π)), ⟨q, hq, -n, rfl⟩, ?_, ?_⟩ <;>
      push_cast <;> linarith [hz.1, hz.2]
  -- the colouring: the outer colour of the maximal span, else the original colour
  choose outer houter using fun x => exists_left_const C.locallyConstant x
  have hmaxex := fun θ (h : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2) => reduce_exists_max hlenK hnestK hlfK h
  choose P hPK hPθ hPmax using hmaxex
  set c' : ℝ → ZMod 3 := fun θ => if h : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 then outer (P θ h).1 else C.c θ with hc'
  have hc1 : ∀ θ, (∀ p ∈ 𝓚, θ ∉ Icc p.1 p.2) → c' θ = C.c θ := by
    intro θ h
    have : ¬ ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 := by push Not; exact h
    simp only [hc', dif_neg this]
  have hc2 : ∀ p ∈ 𝓚, (∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc p.1 p.2).Nonempty → Icc p'.1 p'.2 ⊆ Icc p.1 p.2) →
      ∀ θ ∈ Icc p.1 p.2, C.LeftVal p.1 (c' θ) := by
    intro p hp hmax θ hθ
    have h : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 := ⟨p, hp, hθ⟩
    have hval : c' θ = outer (P θ h).1 := by simp only [hc', dif_pos h]
    have hs1 := hmax _ (hPK θ h) ⟨θ, hPθ θ h, hθ⟩
    have hs2 := hPmax θ h p hp ⟨θ, hθ, hPθ θ h⟩
    rw [Icc_subset_Icc_iff (hlenK _ (hPK θ h)).1.le] at hs1
    rw [Icc_subset_Icc_iff (hlenK p hp).1.le] at hs2
    have : (P θ h).1 = p.1 := le_antisymm hs2.1 hs1.1
    rw [hval, ← this]
    exact houter _
  have hcovper : ∀ θ, (∃ p ∈ 𝓚, θ + 2 * π ∈ Icc p.1 p.2) ↔ ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2 := by
    intro θ; constructor
    · rintro ⟨p, hp, h⟩
      refine ⟨_, hperK p hp (-1), ?_, ?_⟩ <;> push_cast <;> linarith [h.1, h.2]
    · rintro ⟨p, hp, h⟩
      refine ⟨_, hperK p hp 1, ?_, ?_⟩ <;> push_cast <;> linarith [h.1, h.2]
  set S' : Set ℝ := {θ | θ ∈ C.S ∧ ¬ ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2} with hS'
  have hlc : ∀ θ, θ ∉ S' → ∀ᶠ y in 𝓝 θ, c' y = c' θ := by
    intro θ hθ
    refine reduce_locConst hremK hlenK hnestK hlfK hc1 hc2 ?_
    by_cases hS : θ ∈ C.S
    · right; by_contra hno; exact hθ ⟨hS, hno⟩
    · left; exact hS
  have hprop : ∀ θ, θ ∉ S' → θ + π / 3 ∉ S' → c' θ ≠ c' (θ + π / 3) := by
    intro θ h1 h2
    have e1 := hlc θ h1
    have e2 : ∀ᶠ y in 𝓝 θ, c' (y + π / 3) = c' (θ + π / 3) :=
      ((continuous_add_const (π / 3)).tendsto θ).eventually (hlc _ h2)
    have hS2 : ∀ᶠ y in 𝓝[<] θ, y + π / 3 ∉ C.S := eventually_lt_add (C.eventually_notMem_S_lt (θ + π / 3))
    have e1' : ∀ᶠ y in 𝓝[<] θ, c' y = c' θ := nhdsWithin_le_nhds e1
    have e2' : ∀ᶠ y in 𝓝[<] θ, c' (y + π / 3) = c' (θ + π / 3) := nhdsWithin_le_nhds e2
    obtain ⟨y, hy1, hy2, hy3, hy4⟩ := ((C.eventually_notMem_S_lt θ).and (hS2.and (e1'.and e2'))).exists
    rw [← hy3, ← hy4]
    exact reduce_proper_off hremK hlenK hnestK hlfK hc1 hc2 hy1 hy2
  have hper : Function.Periodic c' (2 * π) := by
    intro θ
    by_cases hcov : ∃ p ∈ 𝓚, θ ∈ Icc p.1 p.2
    · obtain ⟨p, hp, hθp, hmax⟩ := reduce_exists_max hlenK hnestK hlfK hcov
      have hp' : (p.1 + 2 * π, p.2 + 2 * π) ∈ 𝓚 := by simpa using hperK p hp 1
      have hmax' : ∀ p' ∈ 𝓚, (Icc p'.1 p'.2 ∩ Icc (p.1 + 2 * π) (p.2 + 2 * π)).Nonempty →
          Icc p'.1 p'.2 ⊆ Icc (p.1 + 2 * π) (p.2 + 2 * π) := by
        intro p' hp'' ⟨w, hw, hw'⟩
        have hm : (p'.1 - 2 * π, p'.2 - 2 * π) ∈ 𝓚 := by
          have := hperK p' hp'' (-1); push_cast at this; simpa [sub_eq_add_neg] using this
        have hsub := hmax _ hm ⟨w - 2 * π, ⟨by linarith [hw.1], by linarith [hw.2]⟩,
          ⟨by linarith [hw'.1], by linarith [hw'.2]⟩⟩
        intro z hz
        have := hsub (show z - 2 * π ∈ Icc (p'.1 - 2 * π) (p'.2 - 2 * π) from ⟨by linarith [hz.1], by linarith [hz.2]⟩)
        exact ⟨by linarith [this.1], by linarith [this.2]⟩
      have h1 := hc2 _ hp' hmax' (θ + 2 * π) ⟨by linarith [hθp.1], by linarith [hθp.2]⟩
      have h2 := hc2 p hp hmax θ hθp
      have h1' : C.LeftVal p.1 (c' (θ + 2 * π)) := by
        have := (reduce_leftVal_add_int_mul (x := p.1) 1).mp (by simpa using h1)
        exact this
      exact LeftVal.unique h1' h2
    · have hcov' : ¬ ∃ p ∈ 𝓚, θ + 2 * π ∈ Icc p.1 p.2 := fun h => hcov ((hcovper θ).mp h)
      push Not at hcov hcov'
      rw [hc1 _ hcov', hc1 _ hcov, C.periodic θ]
  let C' : CircleColouring :=
    { c := c', S := S', periodic := hper, periodic_S := fun θ => by simp only [hS', mem_setOf_eq, C.periodic_S, hcovper]
      finite_S := C.finite_S.subset fun θ h => ⟨h.1.1, h.2⟩
      locallyConstant := hlc, proper := hprop }
  have hagree' : ∀ x, (¬ ∃ p ∈ 𝓚, x ∈ Icc p.1 p.2) → ∀ᶠ y in 𝓝 x, c' y = C.c y := by
    intro x hx
    push Not at hx
    filter_upwards [reduce_nearOnly hlenK hlfK x] with y hy
    exact hc1 y fun p hp hyp => hx p hp (hy p hp hyp)
  have hvals : ∀ x, (∀ᶠ y in 𝓝 x, c' y = C.c y) → ∀ v,
      (C'.LeftVal x v ↔ C.LeftVal x v) ∧ (C'.RightVal x v ↔ C.RightVal x v) := by
    intro x hx v
    refine ⟨⟨fun h => ?_, fun h => ?_⟩, ⟨fun h => ?_, fun h => ?_⟩⟩
    · filter_upwards [h, nhdsWithin_le_nhds hx] with y h1 h2
      rw [← h2]; exact h1
    · filter_upwards [h, nhdsWithin_le_nhds hx] with y h1 h2
      show c' y = v
      rw [h2]; exact h1
    · filter_upwards [h, nhdsWithin_le_nhds hx] with y h1 h2
      rw [← h2]; exact h1
    · filter_upwards [h, nhdsWithin_le_nhds hx] with y h1 h2
      show c' y = v
      rw [h2]; exact h1
  refine ⟨C', ?_, fun x hx => ⟨hx.1, fun q hq hqe => hx.2 (hcovE x q hq hqe), hvals x (hagree' x hx.2)⟩⟩
  rintro x ⟨hxS, a, b, ha, hb, hsw⟩
  have hxa := hagree' x hxS.2
  have ha' := ((hvals x hxa a).1).mp ha
  have hb' := ((hvals x hxa b).2).mp hb
  rcases hsw with ⟨hb2, ha2⟩ | ⟨hb2, ha2⟩
  · have hab : a ≠ b := reduce_leftVal_ne C' ha hb2
    by_cases hcov : ∃ p ∈ 𝓚, x + π / 3 ∈ Icc p.1 p.2
    · have hnot : x + π / 3 ∉ S' := fun h => h.2 hcov
      exact hab (reduce_vals_of_const C' (hlc _ hnot) hb2 ha2).symm
    · have hag := hagree' _ hcov
      exact hns x ⟨hxS.1, a, b, ha', hb', Or.inl ⟨((hvals _ hag b).1).mp hb2, ((hvals _ hag a).2).mp ha2⟩⟩
  · have hab : b ≠ a := reduce_leftVal_ne C' hb2 (by rwa [sub_add_cancel])
    by_cases hcov : ∃ p ∈ 𝓚, x - π / 3 ∈ Icc p.1 p.2
    · have hnot : x - π / 3 ∉ S' := fun h => h.2 hcov
      exact hab (reduce_vals_of_const C' (hlc _ hnot) hb2 ha2)
    · have hag := hagree' _ hcov
      exact hns x ⟨hxS.1, a, b, ha', hb', Or.inr ⟨((hvals _ hag b).1).mp hb2, ((hvals _ hag a).2).mp ha2⟩⟩

/-! ### The selection's machinery (FS131-I5g): first passages of an integer lift (BV-L5's running maximum, read at its jumps), the window
bounds from the band (BV-H1), the hexagon at increment `6` (BV-C6) and three far points per pair otherwise (BV-P18) -/

section SelectAux

variable {C}

/-- A function locally constant off the change set is bounded above, off the change set, on every compact interval. -/
theorem select_bdd {g : ℝ → ℤ} (hlc : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y) (a b : ℝ) :
    ∃ B, ∀ y ∈ Icc a b, y ∉ C.S → g y ≤ B := by
  refine isCompact_Icc.induction_on (p := fun t => ∃ B, ∀ y ∈ t, y ∉ C.S → g y ≤ B) ⟨0, by simp⟩ ?_ ?_ ?_
  · intro s t hst ⟨B, hB⟩
    exact ⟨B, fun y hy => hB y (hst hy)⟩
  · intro s t ⟨B, hB⟩ ⟨B', hB'⟩
    exact ⟨max B B', fun y hy hyS => hy.elim (fun h => (hB y h hyS).trans (le_max_left _ _))
      (fun h => (hB' y h hyS).trans (le_max_right _ _))⟩
  intro x _
  obtain ⟨l, hl⟩ := exists_left_const hlc x
  obtain ⟨r, hr⟩ := exists_right_const hlc x
  have ht : ∀ᶠ y in 𝓝 x, (y < x → g y = l) ∧ (x < y → g y = r) := by
    have a := eventually_nhdsWithin_iff.mp hl
    have b := eventually_nhdsWithin_iff.mp hr
    filter_upwards [a, b] with y h1 h2 using ⟨fun h => h1 h, fun h => h2 h⟩
  refine ⟨_, mem_nhdsWithin_of_mem_nhds ht, max (max l r) (g x), fun y hy _ => ?_⟩
  rcases lt_trichotomy y x with h | h | h
  · rw [hy.1 h]; exact (le_max_left _ _).trans (le_max_left _ _)
  · rw [h]; exact le_max_right _ _
  · rw [hy.2 h]; exact (le_max_right _ _).trans (le_max_left _ _)

/-- **First passage** of an integer lift through a level (BV-L5's running maximum, read at its jumps): with a positive increment `N` per
period, every level `ℓ` has a point `x` left of which (off the change set) the lift stays below `ℓ`, with values `ℓ − 1` just left of `x`
and `ℓ` just right of it. -/
theorem select_firstPassage {g : ℝ → ℤ} (hlc : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y)
    {N : ℤ} (hN : 0 < N) (hper : ∀ θ ∉ C.S, ∀ n : ℤ, g (θ + n * (2 * π)) = g θ + n * N)
    (hjump : ∀ θ, ∀ᶠ a in 𝓝[<] θ, ∀ᶠ b in 𝓝[>] θ, |g b - g a| ≤ 1) (ℓ : ℤ) :
    ∃ x, (∀ y < x, y ∉ C.S → g y < ℓ) ∧ (∀ᶠ y in 𝓝[<] x, g y = ℓ - 1) ∧ ∀ᶠ y in 𝓝[>] x, g y = ℓ := by
  have hπ := Real.pi_pos
  obtain ⟨θ₀, -, hg₀⟩ := C.exists_good_near 0 1 one_pos
  have hθ₀ : θ₀ ∉ C.S := hg₀.notMem
  obtain ⟨B, hB⟩ := select_bdd hlc θ₀ (θ₀ + 2 * π)
  set A := {x | x ∉ C.S ∧ ℓ ≤ g x} with hA
  have hne : A.Nonempty := by
    refine ⟨θ₀ + ((|ℓ - g θ₀| : ℤ) : ℝ) * (2 * π), (C.mem_S_add_int _ θ₀).not.mpr hθ₀, ?_⟩
    rw [hper θ₀ hθ₀]
    have h1 : |ℓ - g θ₀| * 1 ≤ |ℓ - g θ₀| * N := mul_le_mul_of_nonneg_left (by omega) (abs_nonneg _)
    have h2 := le_abs_self (ℓ - g θ₀)
    linarith
  have hbdd : BddBelow A := by
    refine ⟨θ₀ + ((ℓ - B : ℤ) : ℝ) / N * (2 * π), fun x ⟨hxS, hx⟩ => ?_⟩
    set n := ⌊(x - θ₀) / (2 * π)⌋
    have h1 : (n : ℝ) ≤ (x - θ₀) / (2 * π) := Int.floor_le _
    have h2 : (x - θ₀) / (2 * π) < n + 1 := Int.lt_floor_add_one _
    have h1' : n * (2 * π) ≤ x - θ₀ := by rwa [le_div_iff₀ (by positivity)] at h1
    have h2' : x - θ₀ < (n + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h2
    have hyS : x - n * (2 * π) ∉ C.S := fun h => hxS (by simpa using (C.mem_S_add_int n _).mpr h)
    have hgy : g x = g (x - n * (2 * π)) + n * N := by
      have := hper _ hyS n; rwa [sub_add_cancel] at this
    have hyB := hB _ ⟨by linarith, by linarith⟩ hyS
    have hint : ℓ - B ≤ n * N := by linarith
    have hNr : (0 : ℝ) < N := by exact_mod_cast hN
    have : ((ℓ - B : ℤ) : ℝ) / N ≤ n := by
      rw [div_le_iff₀ hNr]; exact_mod_cast hint
    nlinarith
  refine ⟨sInf A, fun y hy hyS => ?_, ?_⟩
  · by_contra hle; push Not at hle
    exact absurd (csInf_le hbdd ⟨hyS, hle⟩) (not_le.mpr hy)
  set x := sInf A
  have hP1 : ∀ y < x, y ∉ C.S → g y < ℓ := fun y hy hyS => by
    by_contra hle; push Not at hle
    exact absurd (csInf_le hbdd ⟨hyS, hle⟩) (not_le.mpr hy)
  have hxA : x ∉ A := by
    rintro ⟨hxS, hx⟩
    have hloc : ∀ᶠ y in 𝓝[<] x, g y = g x := nhdsWithin_le_nhds (hlc x hxS)
    obtain ⟨y, h1, h2, h3⟩ := (hloc.and ((C.eventually_notMem_S_lt x).and self_mem_nhdsWithin)).exists
    have := hP1 y h3 h2
    omega
  obtain ⟨l, hl⟩ := exists_left_const hlc x
  obtain ⟨r, hr⟩ := exists_right_const hlc x
  have hrℓ : ℓ ≤ r := by
    obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hr
    obtain ⟨a, haA, hau⟩ := exists_lt_of_csInf_lt hne (show x < u from hu)
    have hxa : x ≤ a := csInf_le hbdd haA
    have hxa' : x < a := lt_of_le_of_ne hxa fun h => hxA (h ▸ haA)
    have := hsub ⟨hxa', hau⟩
    simp only [mem_setOf_eq] at this
    rw [← this]; exact haA.2
  have hlℓ : l < ℓ := by
    obtain ⟨y, h1, h2, h3⟩ := (hl.and ((C.eventually_notMem_S_lt x).and self_mem_nhdsWithin)).exists
    rw [← h1]; exact hP1 y h3 h2
  have hj : |r - l| ≤ 1 := by
    obtain ⟨a, ha, hal⟩ := ((hjump x).and hl).exists
    obtain ⟨b, hb, hbr⟩ := (ha.and hr).exists
    rw [← hal, ← hbr]; exact hb
  rw [abs_le] at hj
  have hl' : l = ℓ - 1 := by omega
  have hr' : r = ℓ := by omega
  exact ⟨hl' ▸ hl, hr' ▸ hr⟩

/-- Two first-passage points of one level coincide. -/
theorem select_unique {g : ℝ → ℤ} {ℓ : ℤ} {x x' : ℝ} (h1 : ∀ y < x, y ∉ C.S → g y < ℓ) (h2 : ∀ᶠ y in 𝓝[>] x, g y = ℓ)
    (h1' : ∀ y < x', y ∉ C.S → g y < ℓ) (h2' : ∀ᶠ y in 𝓝[>] x', g y = ℓ) : x = x' := by
  have key : ∀ x x' : ℝ, (∀ᶠ y in 𝓝[>] x, g y = ℓ) → (∀ y < x', y ∉ C.S → g y < ℓ) → ¬ x < x' := by
    intro x x' h2 h1' hlt
    obtain ⟨y, hy1, hy2, hy3⟩ := (h2.and ((C.eventually_notMem_S_gt x).and (Ioo_mem_nhdsGT hlt))).exists
    have := h1' y hy3.2 hy2
    omega
  rcases lt_trichotomy x x' with h | h | h
  · exact absurd h (key x x' h2 h1')
  · exact h
  · exact absurd h (key x' x h2' h1)

/-- First-passage points increase with the level. -/
theorem select_lt {g : ℝ → ℤ} {ℓ ℓ' : ℤ} (hℓ : ℓ < ℓ') {x x' : ℝ} (h1 : ∀ y < x, y ∉ C.S → g y < ℓ)
    (h2 : ∀ᶠ y in 𝓝[>] x, g y = ℓ) (h2' : ∀ᶠ y in 𝓝[>] x', g y = ℓ') : x < x' := by
  by_contra hle; push Not at hle
  rcases eq_or_lt_of_le hle with h | h
  · subst h
    obtain ⟨y, hy1, hy2⟩ := (h2.and h2').exists
    omega
  · obtain ⟨y, hy1, hy2, hy3⟩ := (h2'.and ((C.eventually_notMem_S_gt x').and (Ioo_mem_nhdsGT h))).exists
    have := h1 y hy3.2 hy2
    omega

/-- **The window bound** (BV-P18's count): `3M + 3` levels past a first-passage point lie more than `60°` beyond it. -/
theorem select_window {g : ℝ → ℤ} (hlc : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y) {M : ℤ}
    (hband : ∀ z, z ∉ C.S → z + π / 3 ∉ C.S → 3 * M + 1 ≤ g (z + π / 3) - g z ∧ g (z + π / 3) - g z ≤ 3 * M + 2)
    {ℓ : ℤ} {x x' : ℝ} (h1 : ∀ y < x, y ∉ C.S → g y < ℓ) (h2 : ∀ᶠ y in 𝓝[>] x, g y = ℓ)
    (h2' : ∀ᶠ y in 𝓝[>] x', g y = ℓ + 3 * M + 3) : x + π / 3 < x' := by
  -- just right of `x`, and everywhere left of it, the lift is at most `ℓ`
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp h2
  have hP4 : ∀ z < u, z ∉ C.S → g z ≤ ℓ := by
    intro z hz hzS
    rcases lt_trichotomy z x with h | h | h
    · exact (h1 z h hzS).le
    · subst h
      have hloc : ∀ᶠ y in 𝓝[>] z, g y = g z := nhdsWithin_le_nhds (hlc z hzS)
      obtain ⟨y, hy1, hy2⟩ := (hloc.and h2).exists
      omega
    · exact (hsub ⟨h, hz⟩ : g z = ℓ).le
  by_contra hle; push Not at hle
  have hS' : ∀ᶠ y in 𝓝[>] x', y + -(π / 3) ∉ C.S :=
    eventually_gt_add (C.eventually_notMem_S_gt (x' + -(π / 3)))
  have hu' : x' < x' + (u - x) := by linarith [mem_Ioi.mp hu]
  obtain ⟨y, hy1, hy2, hy3, hy4⟩ := (h2'.and ((C.eventually_notMem_S_gt x').and (hS'.and (Ioo_mem_nhdsGT hu')))).exists
  have hz := hP4 (y + -(π / 3)) (by linarith [hy4.2]) hy3
  have hb := (hband (y + -(π / 3)) hy3 (by rwa [neg_add_cancel_right])).2
  rw [neg_add_cancel_right] at hb
  omega

/-- **The lower window** (BV-H1's band from below): `3M + 1` levels past a first-passage point are reached within `60°`. -/
theorem select_window' {g : ℝ → ℤ} {M : ℤ}
    (hband : ∀ z, z ∉ C.S → z + π / 3 ∉ C.S → 3 * M + 1 ≤ g (z + π / 3) - g z ∧ g (z + π / 3) - g z ≤ 3 * M + 2)
    {ℓ : ℤ} {x x' : ℝ} (h2 : ∀ᶠ y in 𝓝[>] x, g y = ℓ) (h1' : ∀ y < x', y ∉ C.S → g y < ℓ + 3 * M + 1) :
    x' ≤ x + π / 3 := by
  refine le_of_forall_pos_lt_add fun ε hε => ?_
  have hS' : ∀ᶠ y in 𝓝[>] x, y + π / 3 ∉ C.S := eventually_gt_add (C.eventually_notMem_S_gt (x + π / 3))
  obtain ⟨y, hy1, hy2, hy3, hy4⟩ := (h2.and ((C.eventually_notMem_S_gt x).and (hS'.and
    (Ioo_mem_nhdsGT (show x < x + ε by linarith))))).exists
  have hb := (hband y hy2 hy3).1
  by_contra hle; push Not at hle
  have := h1' (y + π / 3) (by linarith [hy4.2]) hy3
  omega

/-- Chords of the unit circle between angles more than `60°` and less than `300°` apart are longer than `1`. -/
theorem select_chord {a b : ℝ} (h1 : π / 3 < b - a) (h2 : b - a < 2 * π - π / 3) : 1 < ‖e a - e b‖ := by
  have hπ := Real.pi_pos
  have hc : Real.cos (a - b) < 1 / 2 := by
    rw [show a - b = -(b - a) by ring, Real.cos_neg]
    rcases le_or_gt (b - a) π with h | h
    · have := Real.cos_lt_cos_of_nonneg_of_le_pi (by positivity) h h1
      rwa [Real.cos_pi_div_three] at this
    · rw [show b - a = 2 * π - (2 * π - (b - a)) by ring, Real.cos_two_pi_sub]
      have := Real.cos_lt_cos_of_nonneg_of_le_pi (by positivity) (by linarith) (show π / 3 < 2 * π - (b - a) by linarith)
      rwa [Real.cos_pi_div_three] at this
  have hsq := norm_e_sub_e_sq a b
  have h0 := norm_nonneg (e a - e b)
  nlinarith


/-- The pair residue: for a sign `τ` and two distinct colours, one residue `r` has `{τ (r − 1), τ r}` equal to them in some order. -/
theorem select_residue {τ v w : ZMod 3} (hτ : τ = 1 ∨ τ = -1) (hvw : v ≠ w) :
    ∃ r : ZMod 3, (τ * (r - 1) = v ∧ τ * r = w) ∨ (τ * (r - 1) = w ∧ τ * r = v) := by
  rcases hτ with rfl | rfl <;> revert v w <;> decide

/-- **The selection, over an integer lift with positive winding** (BV-L5's first passages, BV-C6, BV-P18): the hexagon when the increment
per period is `6`, else three passage points per pair, pairwise more than `60°` apart. -/
theorem select_core {g : ℝ → ℤ} {τ : ZMod 3} (hτ : τ = 1 ∨ τ = -1) (hcast : ∀ y ∉ C.S, C.c y = τ * (g y : ZMod 3))
    (hlc : ∀ y ∉ C.S, ∀ᶠ y' in 𝓝 y, g y' = g y) (hjump : ∀ θ, ∀ᶠ a in 𝓝[<] θ, ∀ᶠ b in 𝓝[>] θ, |g b - g a| ≤ 1)
    {N M : ℤ} (hper : ∀ θ ∉ C.S, ∀ n : ℤ, g (θ + n * (2 * π)) = g θ + n * N)
    (hband : ∀ z, z ∉ C.S → z + π / 3 ∉ C.S → 3 * M + 1 ≤ g (z + π / 3) - g z ∧ g (z + π / 3) - g z ≤ 3 * M + 2)
    (hNlo : 18 * M + 6 ≤ N) (hNhi : N ≤ 18 * M + 12) (h3 : 3 ∣ N) (hM : 0 ≤ M) :
    (∃ ψ b, C.IsHex ψ b) ∨
      ∀ v w : ZMod 3, v ≠ w → ∃ x : Fin 3 → ℝ, (∀ i, C.ChangeWith (x i) v w) ∧ ∀ i j, i ≠ j → 1 < ‖e (x i) - e (x j)‖ := by
  have hπ := Real.pi_pos
  have hN : 0 < N := by omega
  choose xs hP1 hP3 hP2 using select_firstPassage hlc hN hper hjump
  have hLV : ∀ ℓ, C.LeftVal (xs ℓ) (τ * ((ℓ - 1 : ℤ) : ZMod 3)) := fun ℓ => by
    filter_upwards [hP3 ℓ, C.eventually_notMem_S_lt (xs ℓ)] with y h1 h2
    rw [hcast y h2, h1]
  have hRV : ∀ ℓ, C.RightVal (xs ℓ) (τ * (ℓ : ZMod 3)) := fun ℓ => by
    filter_upwards [hP2 ℓ, C.eventually_notMem_S_gt (xs ℓ)] with y h1 h2
    rw [hcast y h2, h1]
  have hS : ∀ ℓ, xs ℓ ∈ C.S := by
    intro ℓ; by_contra hx
    have h1 : ∀ᶠ y in 𝓝[<] xs ℓ, g y = g (xs ℓ) := nhdsWithin_le_nhds (hlc _ hx)
    have h2 : ∀ᶠ y in 𝓝[>] xs ℓ, g y = g (xs ℓ) := nhdsWithin_le_nhds (hlc _ hx)
    obtain ⟨y, hy1, hy2⟩ := ((hP3 ℓ).and h1).exists
    obtain ⟨y', hy1', hy2'⟩ := ((hP2 ℓ).and h2).exists
    omega
  have hmono : StrictMono xs := fun a b hab => select_lt hab (hP1 a) (hP2 a) (hP2 b)
  have hperx : ∀ ℓ, xs (ℓ + N) = xs ℓ + 2 * π := by
    intro ℓ
    refine select_unique (hP1 (ℓ + N)) (hP2 (ℓ + N)) (fun y hy hyS => ?_) ?_
    · have hyS' : y - 2 * π ∉ C.S := fun h => hyS (by simpa using (C.mem_S_add_int 1 _).mpr h)
      have := hper _ hyS' 1
      simp only [Int.cast_one, one_mul, sub_add_cancel] at this
      have := hP1 ℓ (y - 2 * π) (by linarith) hyS'
      omega
    · have h : ∀ᶠ z in 𝓝[>] (xs ℓ + 2 * π + -(2 * π)), g z = ℓ ∧ z ∉ C.S := by
        rw [add_neg_cancel_right]; exact (hP2 ℓ).and (C.eventually_notMem_S_gt _)
      filter_upwards [eventually_gt_add h] with y ⟨hy1, hy2⟩
      have := hper _ hy2 1
      simp only [Int.cast_one, one_mul, neg_add_cancel_right] at this
      omega
  have hW1 : ∀ ℓ, xs ℓ + π / 3 < xs (ℓ + 3 * (M + 1)) := fun ℓ =>
    select_window hlc hband (hP1 ℓ) (hP2 ℓ) (by rw [show ℓ + 3 * (M + 1) = ℓ + 3 * M + 3 by ring]; exact hP2 _)
  by_cases h6 : N = 6
  · left
    have hM0 : M = 0 := by omega
    subst hM0
    have hW2 : ∀ ℓ, xs (ℓ + 1) ≤ xs ℓ + π / 3 := fun ℓ =>
      select_window' hband (hP2 ℓ) (by simpa using hP1 (ℓ + 1))
    have e6 := hperx 0
    rw [h6] at e6
    have a1 := hW2 0; have a2 := hW2 1; have a3 := hW2 2; have a4 := hW2 3; have a5 := hW2 4; have a6 := hW2 5
    norm_num at a1 a2 a3 a4 a5 a6 e6
    have hx : ∀ j : ℕ, j < 6 → xs j = xs 0 + j * (π / 3) := by
      intro j hj
      interval_cases j <;> norm_num <;> linarith
    refine ⟨xs 0, fun j => τ * (j - 1), ?_, fun j hj => ?_⟩
    · intro a b hab
      have hτ' : τ * τ = 1 := by rcases hτ with rfl | rfl <;> decide
      have := congrArg (τ * ·) hab
      simp only [← mul_assoc, hτ', one_mul] at this
      exact sub_left_injective this
    · rw [← hx j hj]
      refine ⟨?_, ?_⟩
      · have := hLV j; push_cast at this ⊢; exact this
      · have := hRV j; push_cast at this ⊢; simpa using this
  · right
    have h9 : 9 * (M + 1) ≤ N := by omega
    intro v w hvw
    obtain ⟨r, hr⟩ := select_residue hτ hvw
    set k : ℤ := 3 * (M + 1) with hk
    have hcast3 : ∀ i : ℤ, (((r.val : ℤ) + k * i : ℤ) : ZMod 3) = r := by
      intro i
      have : ((k : ℤ) : ZMod 3) = 0 := by
        rw [hk]; push_cast; rw [show (3 : ZMod 3) = 0 from rfl, zero_mul]
      push_cast; rw [this, zero_mul, add_zero]; simp
    refine ⟨fun i => xs (r.val + k * (i : ℕ)), fun i => ⟨hS _, ?_⟩, ?_⟩
    · have hl := hLV (r.val + k * (i : ℕ))
      have hr' := hRV (r.val + k * (i : ℕ))
      have hc := hcast3 ((i : ℕ) : ℤ)
      rw [show (((r.val + k * (i : ℕ) - 1 : ℤ)) : ZMod 3) = (((r.val + k * (i : ℕ) : ℤ)) : ZMod 3) - 1 by push_cast; ring,
        hc] at hl
      rw [hc] at hr'
      rcases hr with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · left; exact ⟨h1 ▸ hl, h2 ▸ hr'⟩
      · right; exact ⟨h1 ▸ hl, h2 ▸ hr'⟩
    · set ℓ₀ : ℤ := ((r.val : ℕ) : ℤ)
      have d1 := hW1 ℓ₀
      have d2 := hW1 (ℓ₀ + k)
      have d3 : xs (ℓ₀ + 2 * k) + π / 3 < xs (ℓ₀ + N) := by
        have := hW1 (ℓ₀ + 2 * k)
        have hle : xs (ℓ₀ + 2 * k + 3 * (M + 1)) ≤ xs (ℓ₀ + N) := hmono.monotone (by omega)
        linarith
      rw [hperx] at d3
      rw [show ℓ₀ + k + k = ℓ₀ + 2 * k by ring] at d2
      have hx1 : xs (ℓ₀ + k * ((1 : ℕ) : ℤ)) = xs (ℓ₀ + k) := by simp
      have hx2 : xs (ℓ₀ + k * ((2 : ℕ) : ℤ)) = xs (ℓ₀ + 2 * k) := by congr 1; push_cast; ring
      have hx0 : xs (ℓ₀ + k * ((0 : ℕ) : ℤ)) = xs ℓ₀ := by simp
      intro i j hij
      fin_cases i <;> fin_cases j <;> simp only [ne_eq, not_true_eq_false] at hij <;>
        dsimp only <;>
        first
        | (rw [hx0, hx1]; exact select_chord (by linarith) (by linarith))
        | (rw [hx0, hx2]; exact select_chord (by linarith) (by linarith))
        | (rw [hx1, hx0, norm_sub_rev]; exact select_chord (by linarith) (by linarith))
        | (rw [hx1, hx2]; exact select_chord (by linarith) (by linarith))
        | (rw [hx2, hx0, norm_sub_rev]; exact select_chord (by linarith) (by linarith))
        | (rw [hx2, hx1, norm_sub_rev]; exact select_chord (by linarith) (by linarith))

end SelectAux

/-- **The selection** (`[SokolovVoronov2025]` Lemma 5, BV-C6 and Prop. 18, as BASE-V § 1a.2–1a.3 and FS110-CD § 2.5 derived them): a circle
colouring with no swap point is the rotating hexagon, or for each pair of colours it has three change points with that pair, pairwise more than
`60°` apart (chords longer than `1`). Circle-abstract; Lemma 5's recolouring keeps each kept point's pair, so the points are the colouring's own. -/
theorem select (hns : ∀ x, ¬ C.IsSwap x) :
    (∃ ψ b, C.IsHex ψ b) ∨
      ∀ v w : ZMod 3, v ≠ w → ∃ x : Fin 3 → ℝ, (∀ i, C.ChangeWith (x i) v w) ∧ ∀ i j, i ≠ j → 1 < ‖e (x i) - e (x j)‖ := by
  have hπ := Real.pi_pos
  obtain ⟨L⟩ := exists_lift C
  obtain ⟨θ₀, -, hg₀⟩ := C.exists_good_near 0 1 one_pos
  have hθ₀S : θ₀ ∉ C.S := hg₀.notMem
  have hT0 : ∀ j : ℕ, j < 6 → θ₀ + j * (π / 3) ∈ T0 C := fun j hj => by
    refine ⟨hg₀ j hj, ?_⟩
    have := hg₀.hex_notMem (i := j + 1) (by omega)
    rwa [show θ₀ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ₀ + j * (π / 3) + π / 3 by push_cast; ring] at this
  -- the band (BV-H1): no swap point keeps `D₀` in one band `{3M + 1, 3M + 2}`
  obtain ⟨M, hMc⟩ : ∃ M, ∀ z ∈ T0 C, L.m 0 z = M :=
    ⟨L.m 0 θ₀, fun z hz => m0_const L (hbig_of_noSwap L hns) z hz θ₀ (by simpa using hT0 0 (by norm_num))⟩
  have hband : ∀ z, z ∉ C.S → z + π / 3 ∉ C.S →
      3 * M + 1 ≤ L.f (z + π / 3) - L.f z ∧ L.f (z + π / 3) - L.f z ≤ 3 * M + 2 := by
    intro z hz hz'
    have h1 := hMc z ⟨hz, hz'⟩
    have h2 := Lift.D0_mod_ne (L := L) hz hz'
    unfold Lift.m at h1
    rw [D0_eq] at h1 h2
    omega
  -- the increment per period
  have hdvd : ∀ θ ∉ C.S, (3 : ℤ) ∣ L.f (θ + 2 * π) - L.f θ := by
    intro θ hθ
    have hθ' : θ + 2 * π ∉ C.S := fun h => hθ ((C.periodic_S θ).mp h)
    have := (ZMod.intCast_zmod_eq_zero_iff_dvd (L.f (θ + 2 * π) - L.f θ) 3).mp (by
      push_cast; rw [L.cast_eq _ hθ', L.cast_eq _ hθ, C.periodic θ, sub_self])
    exact_mod_cast this
  set N := L.f (θ₀ + 2 * π) - L.f θ₀ with hN
  have hstep : ∀ θ ∉ C.S, L.f (θ + 2 * π) = L.f θ + N := by
    intro θ hθ
    have hW := Lift.W_eq_aux (L := L) hθ hθ₀S
    unfold Lift.W at hW
    have h1 := hdvd θ hθ
    have h2 := hdvd θ₀ hθ₀S
    omega
  have hper : ∀ θ ∉ C.S, ∀ n : ℤ, L.f (θ + n * (2 * π)) = L.f θ + n * N := by
    intro θ hθ n
    induction n using Int.induction_on with
    | zero => simp
    | succ n ih =>
      have hS : θ + (n : ℤ) * (2 * π) ∉ C.S := (C.mem_S_add_int n θ).not.mpr hθ
      rw [show θ + (((n : ℤ) + 1 : ℤ) : ℝ) * (2 * π) = (θ + (n : ℤ) * (2 * π)) + 2 * π by push_cast; ring,
        hstep _ hS, ih]
      ring
    | pred n ih =>
      have hS : θ + ((-(n : ℤ) - 1 : ℤ) : ℝ) * (2 * π) ∉ C.S := (C.mem_S_add_int _ θ).not.mpr hθ
      have := hstep _ hS
      rw [show θ + ((-(n : ℤ) - 1 : ℤ) : ℝ) * (2 * π) + 2 * π = θ + ((-(n : ℤ) : ℤ) : ℝ) * (2 * π) by push_cast; ring,
        ih] at this
      linarith
  -- the increment lies in `[18M + 6, 18M + 12]` (the band summed over a hexagon)
  set a : ℕ → ℤ := fun j => L.f (θ₀ + j * (π / 3)) with ha
  have hb : ∀ j : ℕ, j < 6 → 3 * M + 1 ≤ a (j + 1) - a j ∧ a (j + 1) - a j ≤ 3 * M + 2 := fun j hj => by
    have := hband _ (hT0 j hj).1 (hT0 j hj).2
    simp only [ha]
    rwa [show θ₀ + ((j + 1 : ℕ) : ℝ) * (π / 3) = θ₀ + j * (π / 3) + π / 3 by push_cast; ring]
  have ha0 : a 0 = L.f θ₀ := by simp [ha]
  have ha6 : a 6 = L.f (θ₀ + 2 * π) := by simp only [ha]; congr 1; push_cast; ring
  have b0 := hb 0 (by norm_num); have b1 := hb 1 (by norm_num); have b2 := hb 2 (by norm_num)
  have b3 := hb 3 (by norm_num); have b4 := hb 4 (by norm_num); have b5 := hb 5 (by norm_num)
  norm_num only at b0 b1 b2 b3 b4 b5
  have hNlo : 18 * M + 6 ≤ N := by omega
  have hNhi : N ≤ 18 * M + 12 := by omega
  have h3N : (3 : ℤ) ∣ N := hdvd θ₀ hθ₀S
  rcases lt_or_gt_of_ne (show N ≠ 0 by omega) with hneg | hpos
  · -- negative winding: run the selection on the negated lift
    refine select_core (g := fun θ => -L.f θ) (τ := -1) (N := -N) (M := -M - 1) (Or.inr rfl) (fun y hy => ?_)
      (fun y hy => ?_) (fun θ => ?_) (fun θ hθ n => ?_) (fun z hz hz' => ?_) (by omega) (by omega) (dvd_neg.mpr h3N)
      (by omega)
    · push_cast; rw [L.cast_eq y hy]; ring
    · filter_upwards [L.locallyConstant y hy] with y' h using by rw [h]
    · filter_upwards [L.jump θ] with a' ha'
      filter_upwards [ha'] with b' hb'
      rwa [show -L.f b' - -L.f a' = -(L.f b' - L.f a') by ring, abs_neg]
    · rw [hper θ hθ n]; ring
    · have := hband z hz hz'; constructor <;> omega
  · exact select_core (g := L.f) (τ := 1) (Or.inl rfl) (fun y hy => by rw [L.cast_eq y hy, one_mul]) L.locallyConstant
      L.jump hper hband hNlo hNhi h3N (by omega)

/-! ### The linkage's height difference (FS131-I5g, for `l3_base`): one-sided values of a lift along a path with finite fibres, the band
constancy of `L₁(φ) − L₂(χ)` (BASE-V § 1b.3 step 4), relabelling, periodic finiteness -/

section LinkAux

/-- A continuous function on `[a, b]` with finite fibres keeps one side of its value just right of an interior point. -/
theorem link_side_right {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ico a b) :
    ∃ δ > 0, s₀ + δ ≤ b ∧ ((∀ s ∈ Ioo s₀ (s₀ + δ), f s < f s₀) ∨ (∀ s ∈ Ioo s₀ (s₀ + δ), f s₀ < f s)) := by
  have hF : ({s | s ∈ Icc a b ∧ f s = f s₀} \ {s₀}).Finite := (hfin _).sdiff
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hF.isClosed.isOpen_compl s₀ (by simp)
  refine ⟨min ε (b - s₀), lt_min hε (by linarith [hs₀.2]), by linarith [min_le_right ε (b - s₀)], ?_⟩
  have hne : ∀ s ∈ Ioo s₀ (s₀ + min ε (b - s₀)), f s ≠ f s₀ := by
    intro s hs hfs
    have hsb : s ∈ ball s₀ ε := by
      rw [mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hs.1, hs.2, min_le_left ε (b - s₀)]
    exact hball hsb ⟨⟨⟨by linarith [hs.1, hs₀.1], by linarith [hs.2, min_le_right ε (b - s₀)]⟩, hfs⟩, by
      simp only [mem_singleton_iff]; exact ne_of_gt hs.1⟩
  have hcI : ContinuousOn f (Ioo s₀ (s₀ + min ε (b - s₀))) :=
    hc.mono fun s hs => ⟨by linarith [hs.1, hs₀.1], by linarith [hs.2, min_le_right ε (b - s₀)]⟩
  by_contra hno
  push Not at hno
  obtain ⟨⟨s₁, hs₁, h₁⟩, ⟨s₂, hs₂, h₂⟩⟩ := hno
  have hsub : uIcc s₁ s₂ ⊆ Ioo s₀ (s₀ + min ε (b - s₀)) :=
    (ordConnected_Ioo).uIcc_subset hs₁ hs₂
  obtain ⟨c, hc', hfc⟩ := intermediate_value_uIcc (hcI.mono hsub) (show f s₀ ∈ uIcc (f s₁) (f s₂) from
    ⟨min_le_of_right_le h₂, le_max_of_le_left h₁⟩)
  exact hne c (hsub hc') hfc

/-- The mirror of `link_side_right`: just left of an interior point. -/
theorem link_side_left {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ioc a b) :
    ∃ δ > 0, a ≤ s₀ - δ ∧ ((∀ s ∈ Ioo (s₀ - δ) s₀, f s < f s₀) ∨ (∀ s ∈ Ioo (s₀ - δ) s₀, f s₀ < f s)) := by
  have hc' : ContinuousOn (fun s => f (-s)) (Icc (-b) (-a)) :=
    hc.comp continuousOn_neg fun s hs => ⟨by linarith [hs.2], by linarith [hs.1]⟩
  have hfin' : ∀ v, {s | s ∈ Icc (-b) (-a) ∧ f (-s) = v}.Finite := fun v =>
    ((hfin v).image fun s => -s).subset fun s hs => ⟨-s, ⟨⟨by linarith [hs.1.2], by linarith [hs.1.1]⟩, hs.2⟩, by simp⟩
  obtain ⟨δ, hδ, hδb, h⟩ := link_side_right hc' hfin' (s₀ := -s₀) ⟨by linarith [hs₀.2], by linarith [hs₀.1]⟩
  refine ⟨δ, hδ, by linarith, ?_⟩
  simp only [neg_neg] at h
  rcases h with h | h
  · exact Or.inl fun s hs => by simpa using h (-s) ⟨by linarith [hs.2], by linarith [hs.1]⟩
  · exact Or.inr fun s hs => by simpa using h (-s) ⟨by linarith [hs.2], by linarith [hs.1]⟩

variable {C}

/-- Just right of a point, a lift read along a continuous path with finite fibres is one of its two sides at the point, with the path on
the corresponding side. -/
theorem link_val_right (L : C.Lift) {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ico a b) {l r : ℤ} (hLR : L.Sides (f s₀) l r) :
    ∃ δ > 0, s₀ + δ ≤ b ∧ ((∀ s ∈ Ioo s₀ (s₀ + δ), L.f (f s) = l ∧ f s < f s₀) ∨
      (∀ s ∈ Ioo s₀ (s₀ + δ), L.f (f s) = r ∧ f s₀ < f s)) := by
  obtain ⟨δ, hδ, hδb, hside⟩ := link_side_right hc hfin hs₀
  obtain ⟨l', hl', hsubl⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp hLR.1
  obtain ⟨r', hr', hsubr⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hLR.2.1
  have hl'' : l' < f s₀ := hl'
  have hr'' : f s₀ < r' := hr'
  -- continuity at `s₀` within `[a, b]`
  have hcont : ∀ ρ > 0, ∃ η > 0, ∀ s ∈ Icc a b, |s - s₀| < η → |f s - f s₀| < ρ := by
    intro ρ hρ
    have := Metric.continuousWithinAt_iff.mp (hc s₀ (Ico_subset_Icc_self hs₀)) ρ hρ
    obtain ⟨η, hη, h⟩ := this
    exact ⟨η, hη, fun s hs hss => by rw [← Real.dist_eq]; exact h hs (by rwa [Real.dist_eq])⟩
  obtain ⟨η, hη, hηc⟩ := hcont (min (f s₀ - l') (r' - f s₀)) (lt_min (by linarith) (by linarith))
  refine ⟨min δ η, lt_min hδ hη, by linarith [min_le_left δ η], ?_⟩
  have hin : ∀ s ∈ Ioo s₀ (s₀ + min δ η), s ∈ Ioo s₀ (s₀ + δ) ∧ |f s - f s₀| < min (f s₀ - l') (r' - f s₀) := by
    intro s hs
    refine ⟨⟨hs.1, by linarith [hs.2, min_le_left δ η]⟩, hηc s ⟨by linarith [hs.1, hs₀.1], by linarith [hs.2, min_le_left δ η]⟩ ?_⟩
    rw [abs_lt]; constructor <;> linarith [hs.1, hs.2, min_le_right δ η]
  rcases hside with h | h
  · refine Or.inl fun s hs => ⟨?_, h s (hin s hs).1⟩
    have h1 := h s (hin s hs).1
    have h2 := (hin s hs).2
    rw [abs_lt] at h2
    exact hsubl ⟨by linarith [h2.1, min_le_left (f s₀ - l') (r' - f s₀)], h1⟩
  · refine Or.inr fun s hs => ⟨?_, h s (hin s hs).1⟩
    have h1 := h s (hin s hs).1
    have h2 := (hin s hs).2
    rw [abs_lt] at h2
    exact hsubr ⟨h1, by linarith [h2.2, min_le_right (f s₀ - l') (r' - f s₀)]⟩

/-- The mirror of `link_val_right`. -/
theorem link_val_left (L : C.Lift) {f : ℝ → ℝ} {a b : ℝ} (hc : ContinuousOn f (Icc a b))
    (hfin : ∀ v, {s | s ∈ Icc a b ∧ f s = v}.Finite) {s₀ : ℝ} (hs₀ : s₀ ∈ Ioc a b) {l r : ℤ} (hLR : L.Sides (f s₀) l r) :
    ∃ δ > 0, a ≤ s₀ - δ ∧ ((∀ s ∈ Ioo (s₀ - δ) s₀, L.f (f s) = l ∧ f s < f s₀) ∨
      (∀ s ∈ Ioo (s₀ - δ) s₀, L.f (f s) = r ∧ f s₀ < f s)) := by
  obtain ⟨δ, hδ, hδb, hside⟩ := link_side_left hc hfin hs₀
  obtain ⟨l', hl', hsubl⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp hLR.1
  obtain ⟨r', hr', hsubr⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hLR.2.1
  have hl'' : l' < f s₀ := hl'
  have hr'' : f s₀ < r' := hr'
  have hcont : ∀ ρ > 0, ∃ η > 0, ∀ s ∈ Icc a b, |s - s₀| < η → |f s - f s₀| < ρ := by
    intro ρ hρ
    obtain ⟨η, hη, h⟩ := Metric.continuousWithinAt_iff.mp (hc s₀ (Ioc_subset_Icc_self hs₀)) ρ hρ
    exact ⟨η, hη, fun s hs hss => by rw [← Real.dist_eq]; exact h hs (by rwa [Real.dist_eq])⟩
  obtain ⟨η, hη, hηc⟩ := hcont (min (f s₀ - l') (r' - f s₀)) (lt_min (by linarith) (by linarith))
  refine ⟨min δ η, lt_min hδ hη, by linarith [min_le_left δ η], ?_⟩
  have hin : ∀ s ∈ Ioo (s₀ - min δ η) s₀, s ∈ Ioo (s₀ - δ) s₀ ∧ |f s - f s₀| < min (f s₀ - l') (r' - f s₀) := by
    intro s hs
    refine ⟨⟨by linarith [hs.1, min_le_left δ η], hs.2⟩, hηc s ⟨by linarith [hs.1, min_le_left δ η], by linarith [hs.2, hs₀.2]⟩ ?_⟩
    rw [abs_lt]; constructor <;> linarith [hs.1, hs.2, min_le_right δ η]
  rcases hside with h | h
  · refine Or.inl fun s hs => ⟨?_, h s (hin s hs).1⟩
    have h1 := h s (hin s hs).1
    have h2 := (hin s hs).2
    rw [abs_lt] at h2
    exact hsubl ⟨by linarith [h2.1, min_le_left (f s₀ - l') (r' - f s₀)], h1⟩
  · refine Or.inr fun s hs => ⟨?_, h s (hin s hs).1⟩
    have h1 := h s (hin s hs).1
    have h2 := (hin s hs).2
    rw [abs_lt] at h2
    exact hsubr ⟨h1, by linarith [h2.2, min_le_right (f s₀ - l') (r' - f s₀)]⟩


/-- **The height difference along a linkage path keeps its band** (BASE-V § 1b.3 step 4, abstract): along a continuous path `s ↦ (φ s, χ s)`
with finite fibres, read through lifts `L₁`, `L₂`, the difference `L₁(φ) − L₂(χ)` at generic parameters is never `0 mod 3` (`hgen`), and its band
`⌊·/3⌋` never changes: a jump by one cannot cross a multiple of `3` without landing on it, and a jump by two is a double event, whose two changes
carry one pair — excluded unless `χ` turns there (`hdbl`). -/
theorem link_path {C₁ C₂ : CircleColouring} (L₁ : C₁.Lift) (L₂ : C₂.Lift) {φ χ : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hφc : ContinuousOn φ (Icc a b)) (hχc : ContinuousOn χ (Icc a b))
    (hφf : ∀ v, {s | s ∈ Icc a b ∧ φ s = v}.Finite) (hχf : ∀ v, {s | s ∈ Icc a b ∧ χ s = v}.Finite)
    {T₁ T₂ : Set ℝ} (hT₁ : ∀ a b, (T₁ ∩ Icc a b).Finite) (hT₂ : ∀ a b, (T₂ ∩ Icc a b).Finite)
    (hS₁ : C₁.S ⊆ T₁) (hS₂ : C₂.S ⊆ T₂)
    (hgen : ∀ s ∈ Ioo a b, φ s ∉ T₁ → χ s ∉ T₂ → (L₁.f (φ s) - L₂.f (χ s)) % 3 ≠ 0)
    (hdbl : ∀ s ∈ Ioo a b, ∀ l₁ r₁ l₂ r₂ : ℤ, L₁.Sides (φ s) l₁ r₁ → L₂.Sides (χ s) l₂ r₂ → (r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) →
      (r₂ - l₂ = 1 ∨ r₂ - l₂ = -1) → ((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0) →
      (∀ᶠ s' in 𝓝[≠] s, χ s' < χ s) ∨ (∀ᶠ s' in 𝓝[≠] s, χ s < χ s')) :
    ∀ GA GB : ℤ, (∃ δ > 0, ∀ s ∈ Ioo a (a + δ), L₁.f (φ s) - L₂.f (χ s) = GA) →
      (∃ δ > 0, ∀ s ∈ Ioo (b - δ) b, L₁.f (φ s) - L₂.f (χ s) = GB) → GA % 3 ≠ 0 ∧ GB % 3 ≠ 0 ∧ GA / 3 = GB / 3 := by
  set T := {s | s ∈ Ioo a b ∧ φ s ∉ T₁ ∧ χ s ∉ T₂} with hT
  -- the bad parameters are finitely many, so generic parameters are dense
  have hbad : {s | s ∈ Icc a b ∧ (φ s ∈ T₁ ∨ χ s ∈ T₂)}.Finite := by
    obtain ⟨m, hm⟩ := (isCompact_Icc.image_of_continuousOn hφc).bddBelow
    obtain ⟨M, hM⟩ := (isCompact_Icc.image_of_continuousOn hφc).bddAbove
    obtain ⟨m', hm'⟩ := (isCompact_Icc.image_of_continuousOn hχc).bddBelow
    obtain ⟨M', hM'⟩ := (isCompact_Icc.image_of_continuousOn hχc).bddAbove
    refine (((hT₁ m M).biUnion fun v _ => hφf v).union ((hT₂ m' M').biUnion fun v _ => hχf v)).subset ?_
    rintro s ⟨hs, h | h⟩
    · left
      exact mem_biUnion (x := φ s) ⟨h, hm ⟨s, hs, rfl⟩, hM ⟨s, hs, rfl⟩⟩ ⟨hs, rfl⟩
    · right
      exact mem_biUnion (x := χ s) ⟨h, hm' ⟨s, hs, rfl⟩, hM' ⟨s, hs, rfl⟩⟩ ⟨hs, rfl⟩
  have hdense : ∀ c d, a ≤ c → d ≤ b → c < d → ∃ z ∈ T, z ∈ Ioo c d := by
    intro c d hc hd hcd
    obtain ⟨z, hz, hzb⟩ := ((Ioo_infinite hcd).sdiff hbad).nonempty
    refine ⟨z, ⟨⟨by linarith [hz.1], by linarith [hz.2]⟩, fun h => hzb ⟨⟨by linarith [hz.1], by linarith [hz.2]⟩, Or.inl h⟩,
      fun h => hzb ⟨⟨by linarith [hz.1], by linarith [hz.2]⟩, Or.inr h⟩⟩, hz⟩
  have hT' : ∀ y ∈ Ioo a b, ∀ ε > 0, ∃ z ∈ T, |z - y| < ε := by
    intro y hy ε hε
    obtain ⟨z, hzT, hz⟩ := hdense (max a (y - ε)) (min b (y + ε)) (le_max_left _ _) (min_le_left _ _)
      (by rw [max_lt_iff, lt_min_iff, lt_min_iff]; exact ⟨⟨by linarith [hy.1, hy.2], by linarith [hy.1]⟩, by linarith [hy.2],
        by linarith⟩)
    refine ⟨z, hzT, ?_⟩
    rw [abs_lt]; constructor <;> linarith [hz.1, hz.2, le_max_right a (y - ε), min_le_right b (y + ε)]
  suffices hconst : ∀ s ∈ T, ∀ s' ∈ T, (L₁.f (φ s) - L₂.f (χ s)) / 3 = (L₁.f (φ s') - L₂.f (χ s')) / 3 by
    rintro GA GB ⟨δ, hδ, hA⟩ ⟨δ', hδ', hB⟩
    obtain ⟨z, hzT, hz⟩ := hdense a (min (a + δ) b) le_rfl (min_le_right _ _) (lt_min (by linarith) hab)
    obtain ⟨z', hz'T, hz'⟩ := hdense (max (b - δ') a) b (le_max_right _ _) le_rfl (max_lt (by linarith) hab)
    have e1 := hA z ⟨hz.1, lt_of_lt_of_le hz.2 (min_le_left _ _)⟩
    have e2 := hB z' ⟨lt_of_le_of_lt (le_max_left _ _) hz'.1, hz'.2⟩
    refine ⟨?_, ?_, ?_⟩
    · rw [← e1]; exact hgen z hzT.1 hzT.2.1 hzT.2.2
    · rw [← e2]; exact hgen z' hz'T.1 hz'T.2.1 hz'T.2.2
    · rw [← e1, ← e2]; exact hconst z hzT z' hz'T
  refine fun s hs s' hs' => const_of_local isPreconnected_Ioo hT' (g := fun s => (L₁.f (φ s) - L₂.f (χ s)) / 3) ?_
    s ⟨hs, hs.1⟩ s' ⟨hs', hs'.1⟩
  intro y hy
  obtain ⟨l₁, r₁, hs₁, hb₁⟩ := L₁.exists_sides (φ y)
  obtain ⟨l₂, r₂, hs₂, hb₂⟩ := L₂.exists_sides (χ y)
  rw [abs_le] at hb₁ hb₂
  obtain ⟨δ1, hδ1, hδ1a, h1L⟩ := link_val_left L₁ hφc hφf ⟨hy.1, hy.2.le⟩ hs₁
  obtain ⟨δ1', hδ1', hδ1b, h1R⟩ := link_val_right L₁ hφc hφf ⟨hy.1.le, hy.2⟩ hs₁
  obtain ⟨δ2, hδ2, hδ2a, h2L⟩ := link_val_left L₂ hχc hχf ⟨hy.1, hy.2.le⟩ hs₂
  obtain ⟨δ2', hδ2', hδ2b, h2R⟩ := link_val_right L₂ hχc hχf ⟨hy.1.le, hy.2⟩ hs₂
  set ε := min (min δ1 δ1') (min δ2 δ2') with hε
  have hε0 : 0 < ε := lt_min (lt_min hδ1 hδ1') (lt_min hδ2 hδ2')
  have e1 : ε ≤ δ1 := (min_le_left _ _).trans (min_le_left _ _)
  have e1' : ε ≤ δ1' := (min_le_left _ _).trans (min_le_right _ _)
  have e2 : ε ≤ δ2 := (min_le_right _ _).trans (min_le_left _ _)
  have e2' : ε ≤ δ2' := (min_le_right _ _).trans (min_le_right _ _)
  have hL : ∀ s ∈ Ioo (y - ε) y, s ∈ Ioo (y - δ1) y ∧ s ∈ Ioo (y - δ2) y := fun s hs =>
    ⟨⟨by linarith [hs.1], hs.2⟩, ⟨by linarith [hs.1], hs.2⟩⟩
  have hR : ∀ s ∈ Ioo y (y + ε), s ∈ Ioo y (y + δ1') ∧ s ∈ Ioo y (y + δ2') := fun s hs =>
    ⟨⟨hs.1, by linarith [hs.2]⟩, ⟨hs.1, by linarith [hs.2]⟩⟩
  -- the four one-sided values
  obtain ⟨A₁, hA₁, hA₁v⟩ : ∃ A₁, (∀ s ∈ Ioo (y - ε) y, L₁.f (φ s) = A₁) ∧ (A₁ = l₁ ∨ A₁ = r₁) := by
    rcases h1L with h | h
    · exact ⟨l₁, fun s hs => (h s (hL s hs).1).1, Or.inl rfl⟩
    · exact ⟨r₁, fun s hs => (h s (hL s hs).1).1, Or.inr rfl⟩
  obtain ⟨B₁, hB₁, hB₁v⟩ : ∃ B₁, (∀ s ∈ Ioo y (y + ε), L₁.f (φ s) = B₁) ∧ (B₁ = l₁ ∨ B₁ = r₁) := by
    rcases h1R with h | h
    · exact ⟨l₁, fun s hs => (h s (hR s hs).1).1, Or.inl rfl⟩
    · exact ⟨r₁, fun s hs => (h s (hR s hs).1).1, Or.inr rfl⟩
  obtain ⟨A₂, hA₂, hA₂v⟩ : ∃ A₂, (∀ s ∈ Ioo (y - ε) y, L₂.f (χ s) = A₂) ∧
      ((A₂ = l₂ ∧ ∀ s ∈ Ioo (y - ε) y, χ s < χ y) ∨ (A₂ = r₂ ∧ ∀ s ∈ Ioo (y - ε) y, χ y < χ s)) := by
    rcases h2L with h | h
    · exact ⟨l₂, fun s hs => (h s (hL s hs).2).1, Or.inl ⟨rfl, fun s hs => (h s (hL s hs).2).2⟩⟩
    · exact ⟨r₂, fun s hs => (h s (hL s hs).2).1, Or.inr ⟨rfl, fun s hs => (h s (hL s hs).2).2⟩⟩
  obtain ⟨B₂, hB₂, hB₂v⟩ : ∃ B₂, (∀ s ∈ Ioo y (y + ε), L₂.f (χ s) = B₂) ∧
      ((B₂ = l₂ ∧ ∀ s ∈ Ioo y (y + ε), χ s < χ y) ∨ (B₂ = r₂ ∧ ∀ s ∈ Ioo y (y + ε), χ y < χ s)) := by
    rcases h2R with h | h
    · exact ⟨l₂, fun s hs => (h s (hR s hs).2).1, Or.inl ⟨rfl, fun s hs => (h s (hR s hs).2).2⟩⟩
    · exact ⟨r₂, fun s hs => (h s (hR s hs).2).1, Or.inr ⟨rfl, fun s hs => (h s (hR s hs).2).2⟩⟩
  -- generic values on each side are not `0 mod 3`
  have hGL : (A₁ - A₂) % 3 ≠ 0 := by
    obtain ⟨z, hzT, hz⟩ := hdense (y - ε) y (by linarith) hy.2.le (by linarith)
    have := hgen z hzT.1 hzT.2.1 hzT.2.2
    rwa [hA₁ z hz, hA₂ z hz] at this
  have hGR : (B₁ - B₂) % 3 ≠ 0 := by
    obtain ⟨z, hzT, hz⟩ := hdense y (y + ε) hy.1.le (by linarith) (by linarith)
    have := hgen z hzT.1 hzT.2.1 hzT.2.2
    rwa [hB₁ z hz, hB₂ z hz] at this
  -- a turn of `χ` keeps its side value
  have hturn : ((∀ᶠ s' in 𝓝[≠] y, χ s' < χ y) ∨ (∀ᶠ s' in 𝓝[≠] y, χ y < χ s')) → A₂ = B₂ := by
    have hLt : ∀ P : ℝ → Prop, (∀ᶠ s' in 𝓝[≠] y, P s') → ∃ s ∈ Ioo (y - ε) y, P s := fun P h => by
      have h' : ∀ᶠ s' in 𝓝[<] y, P s' := h.filter_mono (nhdsWithin_mono y fun s (hs : s < y) => ne_of_lt hs)
      obtain ⟨s, h1, h2⟩ := (h'.and (Ioo_mem_nhdsLT (show y - ε < y by linarith))).exists
      exact ⟨s, h2, h1⟩
    have hGt : ∀ P : ℝ → Prop, (∀ᶠ s' in 𝓝[≠] y, P s') → ∃ s ∈ Ioo y (y + ε), P s := fun P h => by
      have h' : ∀ᶠ s' in 𝓝[>] y, P s' := h.filter_mono (nhdsWithin_mono y fun s (hs : y < s) => ne_of_gt hs)
      obtain ⟨s, h1, h2⟩ := (h'.and (Ioo_mem_nhdsGT (show y < y + ε by linarith))).exists
      exact ⟨s, h2, h1⟩
    rintro (h | h)
    · obtain ⟨s, hs, hsy⟩ := hLt _ h
      obtain ⟨s', hs', hs'y⟩ := hGt _ h
      rcases hA₂v with ⟨e, -⟩ | ⟨-, h'⟩
      · rcases hB₂v with ⟨e', -⟩ | ⟨-, h''⟩
        · rw [e, e']
        · exact absurd (h'' s' hs') (not_lt.mpr hs'y.le)
      · exact absurd (h' s hs) (not_lt.mpr hsy.le)
    · obtain ⟨s, hs, hsy⟩ := hLt _ h
      obtain ⟨s', hs', hs'y⟩ := hGt _ h
      rcases hA₂v with ⟨-, h'⟩ | ⟨e, -⟩
      · exact absurd (h' s hs) (not_lt.mpr hsy.le)
      · rcases hB₂v with ⟨-, h''⟩ | ⟨e', -⟩
        · exact absurd (h'' s' hs') (not_lt.mpr hs'y.le)
        · rw [e, e']
  have hA₂v' : A₂ = l₂ ∨ A₂ = r₂ := hA₂v.imp (fun h => h.1) (fun h => h.1)
  have hB₂v' : B₂ = l₂ ∨ B₂ = r₂ := hB₂v.imp (fun h => h.1) (fun h => h.1)
  have hband : (A₁ - A₂) / 3 = (B₁ - B₂) / 3 := by
    by_cases hd : A₂ = B₂
    · omega
    · have hnp : ¬ ((r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) ∧ (r₂ - l₂ = 1 ∨ r₂ - l₂ = -1) ∧
          ((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0)) :=
        fun ⟨h1, h2, h3⟩ => hd (hturn (hdbl y hy l₁ r₁ l₂ r₂ hs₁ hs₂ h1 h2 h3))
      omega
  -- the band is constant near `y`
  refine ⟨ε, hε0, fun z hz hzy z' hz' hz'y => ?_⟩
  have hval : ∀ w ∈ T, |w - y| < ε → (L₁.f (φ w) - L₂.f (χ w)) / 3 = (A₁ - A₂) / 3 := by
    intro w hw hwy
    rw [abs_lt] at hwy
    rcases lt_trichotomy w y with h | h | h
    · rw [hA₁ w ⟨by linarith, h⟩, hA₂ w ⟨by linarith, h⟩]
    · subst h
      have e1 := hs₁.2.2 fun hS => hw.2.1 (hS₁ hS)
      have e2 := hs₂.2.2 fun hS => hw.2.2 (hS₂ hS)
      have hA₁e : A₁ = L₁.f (φ w) := by rcases hA₁v with h | h <;> rw [h] <;> [exact e1.1; exact e1.2]
      have hA₂e : A₂ = L₂.f (χ w) := by rcases hA₂v' with h | h <;> rw [h] <;> [exact e2.1; exact e2.2]
      rw [hA₁e, hA₂e]
    · rw [hB₁ w ⟨h, by linarith⟩, hB₂ w ⟨h, by linarith⟩, hband]
  show (L₁.f (φ z) - L₂.f (χ z)) / 3 = (L₁.f (φ z') - L₂.f (χ z')) / 3
  rw [hval z hz hzy, hval z' hz' hz'y]

/-- **Relabelling a circle colouring** by an injection `ρ` of `ℤ/3`: the same change set, one-sided values moved by `ρ`, no swap point
kept. -/
theorem link_relabel (C : CircleColouring) {ρ : ZMod 3 → ZMod 3} (hρ : Function.Injective ρ) :
    ∃ C' : CircleColouring, C'.S = C.S ∧ (∀ θ v, C'.LeftVal θ (ρ v) ↔ C.LeftVal θ v) ∧
      (∀ θ v, C'.RightVal θ (ρ v) ↔ C.RightVal θ v) ∧ (∀ θ ∉ C.S, C'.c θ = ρ (C.c θ)) ∧
      ((∀ x, ¬ C.IsSwap x) → ∀ x, ¬ C'.IsSwap x) := by
  have hsurj : Function.Surjective ρ := Finite.surjective_of_injective hρ
  let C' : CircleColouring :=
    { c := ρ ∘ C.c, S := C.S, periodic := fun θ => by simp only [Function.comp_apply, C.periodic θ],
      periodic_S := C.periodic_S, finite_S := C.finite_S,
      locallyConstant := fun θ hθ => (C.locallyConstant θ hθ).mono fun θ' h => by simp only [Function.comp_apply, h],
      proper := fun θ h1 h2 h => C.proper θ h1 h2 (hρ h) }
  have hL : ∀ θ v, C'.LeftVal θ (ρ v) ↔ C.LeftVal θ v := fun θ v =>
    ⟨fun h => h.mono fun y hy => hρ hy, fun h => h.mono fun y hy => by
      show ρ (C.c y) = ρ v; rw [hy]⟩
  have hR : ∀ θ v, C'.RightVal θ (ρ v) ↔ C.RightVal θ v := fun θ v =>
    ⟨fun h => h.mono fun y hy => hρ hy, fun h => h.mono fun y hy => by
      show ρ (C.c y) = ρ v; rw [hy]⟩
  refine ⟨C', rfl, hL, hR, fun θ _ => rfl, fun hns x ⟨hx, a, b, ha, hb, hsw⟩ => ?_⟩
  obtain ⟨a₀, rfl⟩ := hsurj a
  obtain ⟨b₀, rfl⟩ := hsurj b
  refine hns x ⟨hx, a₀, b₀, (hL x a₀).mp ha, (hR x b₀).mp hb, ?_⟩
  rcases hsw with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact Or.inl ⟨(hL _ b₀).mp h1, (hR _ a₀).mp h2⟩
  · exact Or.inr ⟨(hL _ b₀).mp h1, (hR _ a₀).mp h2⟩

/-- A `2π`-periodic set of reals finite in one period is finite in every compact interval. -/
theorem link_periodic_finite {T : Set ℝ} (hper : ∀ θ, θ + 2 * π ∈ T ↔ θ ∈ T) (hfin : (T ∩ Ico 0 (2 * π)).Finite)
    (a b : ℝ) : (T ∩ Icc a b).Finite := by
  have hπ := Real.pi_pos
  have hint : ∀ (n : ℤ) θ, θ + n * (2 * π) ∈ T ↔ θ ∈ T := by
    intro n θ
    induction n using Int.induction_on with
    | zero => simp
    | succ n ih =>
      rw [show θ + (((n : ℤ) + 1 : ℤ) : ℝ) * (2 * π) = (θ + ((n : ℤ) : ℝ) * (2 * π)) + 2 * π by push_cast; ring, hper, ih]
    | pred n ih =>
      rw [← hper, show θ + ((-(n : ℤ) - 1 : ℤ) : ℝ) * (2 * π) + 2 * π = θ + ((-(n : ℤ) : ℤ) : ℝ) * (2 * π) by
        push_cast; ring, ih]
  have hF := ((Finset.Icc ⌊a / (2 * π)⌋ ⌊b / (2 * π)⌋ ×ˢ hfin.toFinset : Finset (ℤ × ℝ)).image
    (fun q : ℤ × ℝ => q.2 + q.1 * (2 * π))).finite_toSet
  refine hF.subset ?_
  rintro x ⟨hx, hax, hxb⟩
  set n := ⌊x / (2 * π)⌋
  have h1 : (n : ℝ) ≤ x / (2 * π) := Int.floor_le _
  have h2 : x / (2 * π) < n + 1 := Int.lt_floor_add_one _
  have h1' : n * (2 * π) ≤ x := by rwa [le_div_iff₀ (by positivity)] at h1
  have h2' : x < (n + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h2
  have hmem : x - n * (2 * π) ∈ T := by
    have := (hint (-n) x).mpr hx; simpa [sub_eq_add_neg] using this
  simp only [Finset.coe_image, Finset.coe_product, Finset.coe_Icc, mem_image, mem_prod, mem_Icc,
    Set.Finite.coe_toFinset, Prod.exists]
  refine ⟨n, x - n * (2 * π), ⟨⟨?_, ?_⟩, hmem, ?_, ?_⟩, by ring⟩
  · exact Int.floor_mono (div_le_div_of_nonneg_right hax (by positivity))
  · exact Int.floor_mono (div_le_div_of_nonneg_right hxb (by positivity))
  · linarith
  · linarith

end LinkAux

end CircleColouring

namespace ArcMap

variable {F : ArcMap 6} {u : ℂ}

/-! ## A — the pseudo-colouring of `ω(p)` at a cubic trichromatic `p ∈ B̄(u, 1)` -/

/-- **The (P) sweep**: in a valid map, a colour whose tile holds a point at distance exactly `1` from `y` is not carried at `y` (a point of its
class near `y`, translated, would sit in the tile at distance `1`). Any `k`. -/
theorem not_mem_coloursAt_of_tile_dist {k : ℕ} {F : ArcMap k} (hF : F.Valid) {a : Fin k} {T : Set ℂ} (hT : F.TileOf a T) {t y : ℂ}
    (ht : t ∈ T) (h1 : dist t y = 1) : a ∉ F.coloursAt y := by
  intro hay
  obtain ⟨δ, hδ, hδT⟩ := Metric.isOpen_iff.mp hT.1.isOpen t ht
  obtain ⟨y', hy', hy'd⟩ := Metric.mem_closure_iff.mp hay δ hδ
  have hmem : t + (y' - y) ∈ T := hδT (by rw [mem_ball, dist_eq_norm, add_sub_cancel_left, ← dist_eq_norm, dist_comm]; exact hy'd)
  refine hF _ (hT.1.subset_interiorPts hmem) y' hy'.1 ?_ (by rw [hT.2 hmem, hy'.2])
  rw [dist_eq_norm, show t + (y' - y) - y' = t - y by ring, ← dist_eq_norm, h1]


/-- Under H a point of `B̄(u, 2)` with three colours is cubic trichromatic (no repeated colour: one sector per colour; K5b's child
`isCubicTrichromatic_of_three_of_noRep` with `BaseHyp`). -/
theorem BaseCtx.cubic_of_three (B : F.BaseCtx u) {x : ℂ} (hx : x ∈ closedBall u 2) (h3 : (F.coloursAt x).ncard = 3) :
    F.IsCubicTrichromatic x :=
  isCubicTrichromatic_of_three_of_noRep (B.covers hx) h3 fun hr =>
    Set.disjoint_left.mp B.hyp hx (Or.inr ⟨B.covers hx, hr⟩)

/-- **`c′ ≠ ∅`** on `ω(p)` (FS112-N3-3, "the pseudo-colouring"; NB3 step 3): a point of `ω(p)` with no colour outside `P_cl(p)` puts `ω(p)`
in `Γ` on both sides with both sides' colours in `P_cl(p)` — a both-kind arc centred at `p`, against `noBoth` and H. -/
theorem BaseCtx.pseudo_nonempty (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) {x : ℂ}
    (hx : dist x p = 1) : (F.pseudoColours p x).Nonempty := by
  have hF := B.valid
  by_contra hne
  rw [not_nonempty_iff_eq_empty, pseudoColours, sdiff_eq_empty] at hne
  have hpu : dist p u ≤ 1 := hp
  have hxd : x ∈ F.dom := B.covers (by rw [mem_closedBall]; linarith [dist_triangle x p u])
  have hpd : p ∈ F.dom := B.covers (closedBall_subset_closedBall (by norm_num) hp)
  -- near `x` every interior point carries a colour of `x`, hence of `p`
  obtain ⟨ρ, hcol, hρ⟩ := ((eventually_col_mem_coloursAt x).and self_mem_nhdsWithin).exists
  have hρ0 : (0 : ℝ) < ρ := hρ
  obtain ⟨δd, hδd, hdom⟩ := Metric.isOpen_iff.mp F.isOpen_dom x hxd
  set ρ' := min ρ δd with hρ'
  have hρ'0 : 0 < ρ' := lt_min hρ0 hδd
  -- every point of `ω(p)` near `x` lies on `Γ`: an interior point there would carry a colour of `p` at distance `1` from `p`
  have hΓ : ∀ y, dist y p = 1 → dist y x < ρ' → y ∈ F.Γ := by
    intro y hy hyx
    have hyd : y ∈ F.dom := hdom (lt_of_lt_of_le hyx (min_le_right _ _))
    by_contra hyΓ
    have hyI : y ∈ F.interiorPts := ⟨hyd, fun h => hyΓ ⟨hyd, h⟩⟩
    have hc := hcol y ⟨hyI, mem_ball.mpr (lt_of_lt_of_le hyx (min_le_left _ _))⟩
    obtain ⟨hT, hyT⟩ := tileOf_component (⟨hyI, mem_singleton _⟩ : y ∈ F.region (F.col y))
    exact not_mem_coloursAt_of_tile_dist hF hT hyT hy (hne hc)
  -- so `x` lies on an arc of `Γ` on `ω(p)`
  have hxe : ringPt p (arg (x - p)) = x := by
    have h := eq_polar_arg (x - p)
    rw [← dist_eq_norm, hx] at h
    simp only [ofReal_one, one_mul] at h
    rw [ringPt, ← h]; ring
  have hon : F.OnRingArc p x := by
    refine ⟨arg (x - p) - ρ' / 2, arg (x - p) + ρ' / 2, by linarith, ⟨arg (x - p), ⟨by linarith, by linarith⟩, hxe⟩, ?_⟩
    rintro _ ⟨ψ, hψ, rfl⟩
    refine hΓ _ (by rw [ringPt, dist_eq_norm, add_sub_cancel_left, norm_e]) ?_
    rw [← hxe, ringPt, ringPt, dist_add_left, dist_eq_norm]
    calc ‖e ψ - e (arg (x - p))‖ ≤ |ψ - arg (x - p)| := norm_e_sub_e_le _ _
      _ ≤ ρ' / 2 := abs_le.mpr ⟨by linarith [hψ.1], by linarith [hψ.2]⟩
      _ < ρ' := by linarith
  -- a constant-sided arc near `x`: both its side colours are colours of `x`, hence of `p`
  obtain ⟨a, b, d, d', hab, hR, hsub⟩ := exists_isRingArc_of_onRingArc hon (half_pos hρ'0)
  have hmid : (a + b) / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hyx : dist (ringPt p ((a + b) / 2)) x < ρ' / 2 := hsub ⟨_, Ioo_subset_Icc_self hmid, rfl⟩
  have hnear : ∀ (j : Fin 6) (O : Set ℂ), ringPt p ((a + b) / 2) ∈ closure (F.region j ∩ O) → j ∈ F.coloursAt p := by
    intro j O hj
    obtain ⟨z, hz, hzy⟩ := Metric.mem_closure_iff.mp hj (ρ' / 2) (half_pos hρ'0)
    have hzx : dist z x < ρ := by
      have := dist_triangle z (ringPt p ((a + b) / 2)) x
      rw [dist_comm] at hzy
      linarith [min_le_left ρ δd]
    have := hcol z ⟨hz.1.1, mem_ball.mpr hzx⟩
    rw [show F.col z = j from hz.1.2] at this
    exact hne this
  have hd : d ∈ F.coloursAt p := hnear d (ball p 1) (by
    have : d ∈ F.innerColours p (ringPt p ((a + b) / 2)) := by rw [(hR.2.2 _ hmid).1]; exact mem_singleton _
    exact this)
  have hd' : d' ∈ F.coloursAt p := hnear d' (closedBall p 1)ᶜ (by
    have : d' ∈ F.outerColours p (ringPt p ((a + b) / 2)) := by rw [(hR.2.2 _ hmid).2]; exact mem_singleton _
    rw [outerColours, mem_setOf_eq, Set.sdiff_eq] at this
    exact this)
  -- a both-kind arc centred at `p`: against `noBoth` and H
  rcases noBoth hF hpd ⟨d, d', hR, hd, hd'⟩ with h4 | hrep
  · rw [hp3.2] at h4
    norm_num at h4
  · exact Set.disjoint_left.mp B.hyp (closedBall_subset_closedBall (by norm_num) hp) (Or.inr ⟨hpd, hrep⟩)

/-- **`|c′| ≤ 2`** on `ω(p)` (FS112-N3-3; NB3 step 5): three pseudo-colours make `x` cubic trichromatic and complementary to `p` at distance
`1`; `cor3` then puts four colours at the rhombus corners, inside `B̄(u, 2)`, against H. -/
theorem BaseCtx.pseudo_ncard_le_two (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) {x : ℂ}
    (hx : dist x p = 1) : (F.pseudoColours p x).ncard ≤ 2 :=
  pseudo_ncard_le_two_of_baseHyp B.valid B.covers B.hyp hp hp3 hx

/-- **Finitely many non-singleton points** on `ω(p)` (FS112-N3-3; NB3 step 4): local finiteness on the compact `ω(p)`; an arc of `Γ` not on
`ω(p)` meets it in at most two points; an arc on `ω(p)` is in- or out-contact (a single pseudo-colour along its interior), never inert
(`NoInertNear`, `p ∈ B̄(u, 1)`) nor both-kind (`noBoth`, H). -/
theorem BaseCtx.pseudo_finite (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) :
    {θ | θ ∈ Ico 0 (2 * π) ∧ (F.pseudoColours p (ringPt p θ)).ncard ≠ 1}.Finite := by
  have hF := B.valid
  have hpu : dist p u ≤ 1 := hp
  have hcov : F.Covers p 1 := fun z hz =>
    B.covers (show z ∈ closedBall u 2 by rw [mem_closedBall] at hz ⊢; linarith [dist_triangle z p u])
  have hpd : p ∈ F.dom := hcov (mem_closedBall_self zero_le_one)
  refine (F.finite_not_regular hcov (2 * π)).subset ?_
  rintro θ ⟨hθ, hne⟩
  refine ⟨Ico_subset_Icc_self hθ, fun hreg => hne ?_⟩
  have hxd : ringPt p θ ∈ F.dom := hcov (by rw [mem_closedBall, dist_ringPt])
  rcases hreg with hΓ | ⟨θ₁, θ₂, c, c', hR, φ, hφ, he⟩
  · -- off `Γ`: an interior point, its one colour absent at `p`
    have hI : ringPt p θ ∈ F.interiorPts := ⟨hxd, fun h => hΓ ⟨hxd, h⟩⟩
    have hab : F.col (ringPt p θ) ∉ F.coloursAt p :=
      not_mem_coloursAt_of_mem_sphere hF (by rw [mem_sphere, dist_ringPt]) ⟨hI, mem_singleton _⟩
    rw [pseudoColours, coloursAt_eq_of_mem_interiorPts hI]
    refine Set.ncard_eq_one.mpr ⟨F.col (ringPt p θ), ?_⟩
    ext j
    simp only [Set.mem_sdiff, mem_singleton_iff]
    constructor
    · exact fun h => h.1
    · rintro rfl
      exact ⟨rfl, hab⟩
  · -- on a constant-sided arc: exactly one side colour at `p` (not inert, not both-kind)
    have hx : ringPt p θ = ringPt p φ := by rw [ringPt, ringPt, he]
    rw [hx, pseudoColours, hR.coloursAt_eq hφ]
    have hnI := B.noInert p hp θ₁ θ₂
    have hnB : ¬ (c ∈ F.coloursAt p ∧ c' ∈ F.coloursAt p) := fun ⟨h1, h2⟩ => by
      rcases noBoth hF hpd ⟨c, c', hR, h1, h2⟩ with h4 | hrep
      · rw [hp3.2] at h4
        norm_num at h4
      · exact Set.disjoint_left.mp B.hyp (closedBall_subset_closedBall (by norm_num) hp) (Or.inr ⟨hpd, hrep⟩)
    by_cases hc : c ∈ F.coloursAt p
    · have hc' : c' ∉ F.coloursAt p := fun h => hnB ⟨hc, h⟩
      refine Set.ncard_eq_one.mpr ⟨c', ?_⟩
      ext j
      simp only [Set.mem_sdiff, mem_insert_iff, mem_singleton_iff]
      constructor
      · rintro ⟨rfl | rfl, h⟩
        · exact absurd hc h
        · rfl
      · rintro rfl; exact ⟨Or.inr rfl, hc'⟩
    · have hc' : c' ∈ F.coloursAt p := by
        by_contra h
        exact hnI ⟨c, c', hR, hc, h⟩
      refine Set.ncard_eq_one.mpr ⟨c, ?_⟩
      ext j
      simp only [Set.mem_sdiff, mem_insert_iff, mem_singleton_iff]
      constructor
      · rintro ⟨rfl | rfl, h⟩
        · rfl
        · exact absurd hc' h
      · rintro rfl; exact ⟨Or.inl rfl, hc⟩

/-! ## C — the planar core (Prop. 19(b), the reduction's arcs, the eleventh point) -/

/-- A tile whose closure holds points inside and outside `B̄(y, 1)` holds a point at distance exactly `1` from `y`. -/
theorem IsTile.exists_dist_eq_one {k : ℕ} {F : ArcMap k} {T : Set ℂ} (hT : F.IsTile T) {x₁ x₂ y : ℂ} (h₁ : x₁ ∈ closure T)
    (h₂ : x₂ ∈ closure T) (hd₁ : dist x₁ y < 1) (hd₂ : 1 < dist x₂ y) : ∃ t ∈ T, dist t y = 1 := by
  obtain ⟨t₁, ht₁, ht₁d⟩ := Metric.mem_closure_iff.mp h₁ (1 - dist x₁ y) (by linarith)
  obtain ⟨t₂, ht₂, ht₂d⟩ := Metric.mem_closure_iff.mp h₂ (dist x₂ y - 1) (by linarith)
  have e₁ : dist t₁ y < 1 := by have := dist_triangle t₁ x₁ y; rw [dist_comm] at ht₁d; linarith
  have e₂ : 1 < dist t₂ y := by have := dist_triangle x₂ t₂ y; linarith
  have hpre : IsPreconnected ((fun z => dist z y) '' T) := hT.isPreconnected.image _ (continuous_id.dist continuous_const).continuousOn
  obtain ⟨t, ht, h1⟩ := hpre.Icc_subset ⟨t₁, ht₁, rfl⟩ ⟨t₂, ht₂, rfl⟩ ⟨e₁.le, e₂.le⟩
  exact ⟨t, ht, h1⟩

/-- A germ has one pseudo-colour. -/
theorem germPseudo_unique {k : ℕ} {F : ArcMap k} {u : ℂ} {θ : ℝ} {s : Side} {a a' : Fin k} (h : F.GermPseudo u θ s a)
    (h' : F.GermPseudo u θ s a') : a = a' := by
  obtain ⟨δ, hδ, hsub⟩ := h
  obtain ⟨δ', hδ', hsub'⟩ := h'
  have hm : ringPt u (θ + s.sign * (min δ δ' / 2)) ∈ germ u θ s (min δ δ') :=
    ⟨min δ δ' / 2, ⟨by positivity, by linarith [lt_min hδ hδ']⟩, rfl⟩
  have h1 := hsub (germ_mono (min_le_left _ _) hm)
  have h2 := hsub' (germ_mono (min_le_right _ _) hm)
  simp only [mem_setOf_eq] at h1 h2
  rw [h1] at h2
  exact Set.singleton_injective h2

/-- **A change point of the pseudo-colouring is not a singleton point**: germs of two different pseudo-colours on its two sides put both colours
at the point (colours are closed), neither carried at `u`. -/
theorem pseudo_ncard_ne_one_of_change {k : ℕ} {F : ArcMap k} {u : ℂ} {θ : ℝ} {a c : Fin k} (hac : a ≠ c)
    (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .ccw c) : (F.pseudoColours u (ringPt u θ)).ncard ≠ 1 := by
  have hmem : ∀ {s : Side} {j : Fin k}, F.GermPseudo u θ s j → j ∈ F.pseudoColours u (ringPt u θ) := by
    intro s j ⟨δ, hδ, hsub⟩
    have hcl : ringPt u θ ∈ closure (germ u θ s δ) := ringPt_mem_closure_germ u θ s hδ
    have hj : germ u θ s δ ⊆ closure (F.region j) := fun z hz => by
      have := hsub hz
      simp only [mem_setOf_eq] at this
      have hz' : j ∈ F.pseudoColours u z := by rw [this]; exact mem_singleton j
      exact hz'.1
    have hnot : j ∉ F.coloursAt u := by
      obtain ⟨z, hz⟩ : (germ u θ s δ).Nonempty := ⟨_, ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩⟩
      have := hsub hz
      simp only [mem_setOf_eq] at this
      have hz' : j ∈ F.pseudoColours u z := by rw [this]; exact mem_singleton j
      exact hz'.2
    exact ⟨closure_minimal hj isClosed_closure hcl, hnot⟩
  intro h1
  obtain ⟨x, hx⟩ := Set.ncard_eq_one.mp h1
  have h1' := hmem ha
  have h2' := hmem hc
  rw [hx] at h1' h2'
  exact hac (h1'.trans h2'.symm)

/-- The germs at `θ − 2π` are the germs at `θ`. -/
theorem germ_sub_two_pi (p : ℂ) (θ : ℝ) (s : Side) (δ : ℝ) : germ p (θ - 2 * π) s δ = germ p θ s δ := by
  unfold germ
  congr 1
  funext t
  rw [show θ - 2 * π + s.sign * t = θ + s.sign * t - 2 * π by ring]
  simp only [ringPt]
  rw [show e (θ + s.sign * t - 2 * π) = e (θ + s.sign * t - 2 * π + 2 * π) from (e_add_two_pi _).symm]
  ring_nf

/-! ## A, continued — the bridge to a circle colouring (after the germ lemmas it reads) -/

/-- Germs read angles modulo `2π`. -/
theorem germ_add_int_mul (p : ℂ) (θ : ℝ) (m : ℤ) (s : Side) (δ : ℝ) : germ p (θ + 2 * π * m) s δ = germ p θ s δ := by
  unfold germ
  congr 1
  funext t
  simp only [ringPt]
  rw [show θ + 2 * π * m + s.sign * t = (θ + s.sign * t) + 2 * π * m by ring, e_add_int_mul]

/-- Ring points read angles modulo `2π`. -/
theorem ringPt_add_int_mul (p : ℂ) (θ : ℝ) (m : ℤ) : ringPt p (θ + 2 * π * m) = ringPt p θ := by
  simp only [ringPt, e_add_int_mul]

/-- A germ's pseudo-colour reads its angle modulo `2π`. -/
theorem germPseudo_add_int_mul {k : ℕ} {F : ArcMap k} {p : ℂ} {θ : ℝ} (m : ℤ) {s : Side} {a : Fin k} :
    F.GermPseudo p (θ + 2 * π * m) s a ↔ F.GermPseudo p θ s a := by
  simp only [GermPseudo, GermIn, germ_add_int_mul]

/-- Closed ring arcs read their angles modulo `2π`. -/
theorem ringArc_add_int_mul (p : ℂ) (s t : ℝ) (m : ℤ) : ringArc p (s + 2 * π * m) (t + 2 * π * m) = ringArc p s t := by
  ext z
  constructor
  · rintro ⟨θ, hθ, rfl⟩
    refine ⟨θ - 2 * π * m, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ?_⟩
    rw [← ringPt_add_int_mul p (θ - 2 * π * m) m, sub_add_cancel]
  · rintro ⟨θ, hθ, rfl⟩
    exact ⟨θ + 2 * π * m, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ringPt_add_int_mul p θ m⟩

/-- Returning arcs read their angles modulo `2π`. -/
theorem IsRetArc.add_int_mul {k : ℕ} {F : ArcMap k} {p : ℂ} {s t : ℝ} (h : F.IsRetArc p s t) (m : ℤ) :
    F.IsRetArc p (s + 2 * π * m) (t + 2 * π * m) := by
  obtain ⟨hst, hst', a, c, hac, h1, h2, h3, h4, T₁, T₂, hT₁, hT₂, K, hK, hsK, htK, hKsub⟩ := h
  refine ⟨by linarith, by linarith, a, c, hac, (germPseudo_add_int_mul m).mpr h1, (germPseudo_add_int_mul m).mpr h2,
    (germPseudo_add_int_mul m).mpr h3, (germPseudo_add_int_mul m).mpr h4, T₁, T₂, hT₁, hT₂, K, hK, ?_, ?_, hKsub⟩
  · rw [ringPt_add_int_mul]; exact hsK
  · rw [ringPt_add_int_mul]; exact htK

/-- Every returning arc is a translate by a multiple of `2π` of one starting in `[0, 2π)`. -/
theorem IsRetArc.exists_Ico {k : ℕ} {F : ArcMap k} {p : ℂ} {s t : ℝ} (h : F.IsRetArc p s t) :
    ∃ m : ℤ, s + 2 * π * m ∈ Ico 0 (2 * π) ∧ F.IsRetArc p (s + 2 * π * m) (t + 2 * π * m) := by
  have hπ := Real.pi_pos
  refine ⟨-⌊s / (2 * π)⌋, ⟨?_, ?_⟩, h.add_int_mul _⟩
  · have h1 := Int.floor_le (s / (2 * π))
    have h2 : (⌊s / (2 * π)⌋ : ℝ) * (2 * π) ≤ s := by rwa [le_div_iff₀ (by positivity)] at h1
    push_cast; nlinarith
  · have h1 := Int.lt_floor_add_one (s / (2 * π))
    have h2 : s < ((⌊s / (2 * π)⌋ : ℝ) + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h1
    push_cast; nlinarith


/-- A germ's pseudo-colour, clockwise, in interval form. -/
theorem germPseudo_cw_iff {k : ℕ} {F : ArcMap k} {p : ℂ} {θ : ℝ} {a : Fin k} :
    F.GermPseudo p θ .cw a ↔ ∃ δ > 0, ∀ φ ∈ Ioo (θ - δ) θ, F.pseudoColours p (ringPt p φ) = {a} := by
  constructor
  · rintro ⟨δ, hδ, hsub⟩
    refine ⟨δ, hδ, fun φ hφ => ?_⟩
    have hm : ringPt p φ ∈ germ p θ .cw δ :=
      ⟨θ - φ, ⟨by linarith [hφ.2], by linarith [hφ.1]⟩, by simp only [Side.sign]; ring_nf⟩
    exact hsub hm
  · rintro ⟨δ, hδ, h⟩
    refine ⟨δ, hδ, ?_⟩
    rintro _ ⟨t, ht, rfl⟩
    have := h (θ + Side.cw.sign * t) ⟨by simp only [Side.sign]; linarith [ht.2], by simp only [Side.sign]; linarith [ht.1]⟩
    exact this

/-- A germ's pseudo-colour, counter-clockwise, in interval form. -/
theorem germPseudo_ccw_iff {k : ℕ} {F : ArcMap k} {p : ℂ} {θ : ℝ} {a : Fin k} :
    F.GermPseudo p θ .ccw a ↔ ∃ δ > 0, ∀ φ ∈ Ioo θ (θ + δ), F.pseudoColours p (ringPt p φ) = {a} := by
  constructor
  · rintro ⟨δ, hδ, hsub⟩
    refine ⟨δ, hδ, fun φ hφ => ?_⟩
    have hm : ringPt p φ ∈ germ p θ .ccw δ :=
      ⟨φ - θ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, by simp only [Side.sign]; ring_nf⟩
    exact hsub hm
  · rintro ⟨δ, hδ, h⟩
    refine ⟨δ, hδ, ?_⟩
    rintro _ ⟨t, ht, rfl⟩
    have := h (θ + Side.ccw.sign * t) ⟨by simp only [Side.sign]; linarith [ht.1], by simp only [Side.sign]; linarith [ht.2]⟩
    exact this

/-- **Both germs at every point of `ω(p)` carry one pseudo-colour** (NB3 steps 3–5 together): the non-singleton points are finitely many
(`pseudo_finite`), so near `r(θ)` on each side every point has a single pseudo-colour, and on that open arc it is one colour (each colour's
set is closed, `coloursAt` reading closures, and the arc is connected). -/
theorem BaseCtx.exists_germPseudo (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) (θ : ℝ)
    (s : Side) : ∃ a, F.GermPseudo p θ s a := by
  have hπ := Real.pi_pos
  -- the non-singleton points of `ω(p)` form a finite set `Z`
  set Z : Set ℂ := ringPt p '' {θ | θ ∈ Ico 0 (2 * π) ∧ (F.pseudoColours p (ringPt p θ)).ncard ≠ 1} with hZ
  have hZfin : Z.Finite := (B.pseudo_finite hp hp3).image _
  have hmemZ : ∀ φ, (F.pseudoColours p (ringPt p φ)).ncard ≠ 1 → ringPt p φ ∈ Z := by
    intro φ hφ
    have hm : φ + 2 * π * ((-⌊φ / (2 * π)⌋ : ℤ) : ℝ) ∈ Ico 0 (2 * π) := by
      constructor
      · have h1 := Int.floor_le (φ / (2 * π))
        have h2 : (⌊φ / (2 * π)⌋ : ℝ) * (2 * π) ≤ φ := by rwa [le_div_iff₀ (by positivity)] at h1
        push_cast; nlinarith
      · have h1 := Int.lt_floor_add_one (φ / (2 * π))
        have h2 : φ < ((⌊φ / (2 * π)⌋ : ℝ) + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h1
        push_cast; nlinarith
    refine ⟨_, ⟨hm, ?_⟩, ringPt_add_int_mul p φ _⟩
    rwa [ringPt_add_int_mul]
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp (hZfin.sdiff (t := {ringPt p θ})).isClosed.isOpen_compl (ringPt p θ)
    (fun h => h.2 rfl)
  set δ := min ε π with hδ
  have hδ0 : 0 < δ := lt_min hε hπ
  -- near `θ`, off `θ`, every point is a singleton point
  have hsing : ∀ φ, 0 < |φ - θ| → |φ - θ| < δ → (F.pseudoColours p (ringPt p φ)).ncard = 1 := by
    intro φ h0 h1
    by_contra hne
    have hz := hmemZ φ hne
    have hle : |φ - θ| ≤ π := h1.le.trans (min_le_right _ _)
    have hd := dist_ringPt_ringPt p hle
    have hne' : ringPt p φ ≠ ringPt p θ := by
      intro heq
      rw [heq, dist_self] at hd
      have : 0 < Real.sin (|φ - θ| / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
      linarith
    have hlt : dist (ringPt p φ) (ringPt p θ) < ε := by
      rw [hd]
      have := Real.sin_le (by linarith : (0:ℝ) ≤ |φ - θ| / 2)
      linarith [min_le_left ε π]
    exact hball (mem_ball.mpr hlt) ⟨hz, hne'⟩
  -- on an open arc of singleton points the pseudo-colour is constant
  have hconst : ∀ J : Set ℝ, IsPreconnected J → (∀ φ ∈ J, (F.pseudoColours p (ringPt p φ)).ncard = 1) → ∀ φ₀ ∈ J,
      ∃ a, ∀ φ ∈ J, F.pseudoColours p (ringPt p φ) = {a} := by
    intro J hJ hJs φ₀ hφ₀
    obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp (hJs φ₀ hφ₀)
    have hcont : Continuous (ringPt p) := by unfold ringPt e; fun_prop
    have hcl : ∀ b : Fin 6, IsClosed {φ : ℝ | b ∈ F.coloursAt (ringPt p φ)} := fun b =>
      isClosed_closure.preimage hcont
    set U := {φ : ℝ | a ∈ F.coloursAt (ringPt p φ)}
    set V := ⋃ b ∈ ({b | b ≠ a ∧ b ∉ F.coloursAt p} : Set (Fin 6)), {φ : ℝ | b ∈ F.coloursAt (ringPt p φ)}
    have hV : IsClosed V := (Set.toFinite _).isClosed_biUnion fun b _ => hcl b
    have haP : ∀ φ, F.pseudoColours p (ringPt p φ) = {a} → a ∈ F.coloursAt (ringPt p φ) := fun φ h =>
      (show a ∈ F.pseudoColours p (ringPt p φ) by rw [h]; exact mem_singleton a).1
    have hau : a ∉ F.coloursAt p := (show a ∈ F.pseudoColours p (ringPt p φ₀) by rw [ha]; exact mem_singleton a).2
    have hcover : J ⊆ U ∪ V := by
      intro φ hφ
      obtain ⟨b, hb⟩ := Set.ncard_eq_one.mp (hJs φ hφ)
      have hbm : b ∈ F.pseudoColours p (ringPt p φ) := by rw [hb]; exact mem_singleton b
      by_cases hba : b = a
      · left; show a ∈ F.coloursAt (ringPt p φ); exact hba ▸ hbm.1
      · right; exact mem_iUnion₂.mpr ⟨b, ⟨hba, hbm.2⟩, hbm.1⟩
    have hdisj : J ∩ (U ∩ V) = ∅ := by
      ext φ
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
      intro hφ hφU hφV
      obtain ⟨b, ⟨hba, hbp⟩, hb⟩ := mem_iUnion₂.mp hφV
      obtain ⟨c, hc⟩ := Set.ncard_eq_one.mp (hJs φ hφ)
      have h1 : a ∈ F.pseudoColours p (ringPt p φ) := ⟨hφU, hau⟩
      have h2 : b ∈ F.pseudoColours p (ringPt p φ) := ⟨hb, hbp⟩
      rw [hc] at h1 h2
      exact hba ((mem_singleton_iff.mp h2).trans (mem_singleton_iff.mp h1).symm)
    rcases isPreconnected_iff_subset_of_disjoint_closed.mp hJ U V (hcl a) hV hcover hdisj with hU | hV'
    · refine ⟨a, fun φ hφ => ?_⟩
      obtain ⟨b, hb⟩ := Set.ncard_eq_one.mp (hJs φ hφ)
      have : a ∈ F.pseudoColours p (ringPt p φ) := ⟨hU hφ, hau⟩
      rw [hb] at this ⊢
      rw [mem_singleton_iff.mp this]
    · exfalso
      obtain ⟨b, ⟨hba, hbp⟩, hb⟩ := mem_iUnion₂.mp (hV' hφ₀)
      have : b ∈ F.pseudoColours p (ringPt p φ₀) := ⟨hb, hbp⟩
      rw [ha] at this
      exact hba (mem_singleton_iff.mp this)
  cases s with
  | cw =>
    obtain ⟨a, ha⟩ := hconst (Ioo (θ - δ) θ) isPreconnected_Ioo (fun φ hφ => hsing φ
      (by rw [abs_of_neg (by linarith [hφ.2])]; linarith [hφ.2]) (by rw [abs_of_neg (by linarith [hφ.2])]; linarith [hφ.1]))
      (θ - δ / 2) ⟨by linarith, by linarith⟩
    exact ⟨a, germPseudo_cw_iff.mpr ⟨δ, hδ0, ha⟩⟩
  | ccw =>
    obtain ⟨a, ha⟩ := hconst (Ioo θ (θ + δ)) isPreconnected_Ioo (fun φ hφ => hsing φ
      (by rw [abs_of_pos (by linarith [hφ.1])]; linarith [hφ.1]) (by rw [abs_of_pos (by linarith [hφ.1])]; linarith [hφ.2]))
      (θ + δ / 2) ⟨by linarith, by linarith⟩
    exact ⟨a, germPseudo_ccw_iff.mpr ⟨δ, hδ0, ha⟩⟩

/-- **The bridge**: the pseudo-colouring of `ω(p)`, through an injection `g` of `ℤ/3` onto the colours absent at `p`, is a wave-3
`CircleColouring` whose one-sided values are the germs' pseudo-colours, whose change set holds only genuine changes, and which has no swap
point. (i) is `pair_i` (`u₁ = u₂ = p`); no swap is `pair_ii` at `x`, `σx` (FS112-N3-II) with `noBoth`, H and `pseudo_ncard_le_two` (or
`bv_nd1`); finiteness is `pseudo_finite`; local constancy at singletons is the closedness of `{z : a ∈ P_cl(z)}`. -/
theorem BaseCtx.exists_pseudoCircle (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) :
    ∃ (C : CircleColouring) (g : ZMod 3 → Fin 6), Function.Injective g ∧ (∀ v, g v ∉ F.coloursAt p) ∧
      (∀ θ v, C.LeftVal θ v ↔ F.GermPseudo p θ .cw (g v)) ∧ (∀ θ v, C.RightVal θ v ↔ F.GermPseudo p θ .ccw (g v)) ∧
      (∀ θ ∈ C.S, ¬ ∃ v, C.LeftVal θ v ∧ C.RightVal θ v) ∧ ∀ x, ¬ C.IsSwap x := by
  classical
  have hπ := Real.pi_pos
  have hpu : dist p u ≤ 1 := hp
  have hcov : F.Covers p 1 := fun z hz =>
    B.covers (show z ∈ closedBall u 2 by rw [mem_closedBall] at hz ⊢; linarith [dist_triangle z p u])
  have hring2 : ∀ φ, ringPt p φ ∈ closedBall u 2 := fun φ => by
    rw [mem_closedBall]; linarith [dist_triangle (ringPt p φ) p u, dist_ringPt p φ]
  -- `g`: `ℤ/3` onto the three colours absent at `p`
  have hcard : Fintype.card (ZMod 3) = Fintype.card ↥(F.coloursAt p)ᶜ := by
    rw [ZMod.card, ← Set.toFinset_card, ← Set.ncard_eq_toFinset_card', Set.ncard_compl, Nat.card_eq_fintype_card,
      Fintype.card_fin, hp3.2]
  obtain ⟨eqv, -⟩ : ∃ eqv : ZMod 3 ≃ ↥(F.coloursAt p)ᶜ, True := ⟨Fintype.equivOfCardEq hcard, trivial⟩
  obtain ⟨g, hgdef⟩ : ∃ g : ZMod 3 → Fin 6, g = fun v => (eqv v : Fin 6) := ⟨_, rfl⟩
  have hg : Function.Injective g := fun v w h => eqv.injective (Subtype.ext (by rw [hgdef] at h; exact h))
  have hgu : ∀ v, g v ∉ F.coloursAt p := fun v => by rw [hgdef]; exact (eqv v).2
  have hgon : ∀ j, j ∉ F.coloursAt p → ∃ v, g v = j := fun j hj => ⟨eqv.symm ⟨j, hj⟩, by rw [hgdef]; simp⟩
  set P : ℝ → Set (Fin 6) := fun φ => F.pseudoColours p (ringPt p φ) with hP
  have hgerm : ∀ θ s, ∃ v, F.GermPseudo p θ s (g v) := by
    intro θ s
    obtain ⟨a, ha⟩ := B.exists_germPseudo hp hp3 θ s
    obtain ⟨v, rfl⟩ := hgon a ha.mem_pseudoColours.2
    exact ⟨v, ha⟩
  have huniq : ∀ {θ : ℝ} {s : Side} {v w : ZMod 3}, F.GermPseudo p θ s (g v) → F.GermPseudo p θ s (g w) → v = w :=
    fun h h' => hg (germPseudo_unique h h')
  -- the colouring: the clockwise germ's colour
  choose c hc using fun θ => hgerm θ .cw
  have hL0 : ∀ θ δ v, (∀ φ ∈ Ioo (θ - δ) θ, P φ = {g v}) → ∀ φ ∈ Ioo (θ - δ) θ, c φ = v := by
    intro θ δ v h φ hφ
    refine huniq (hc φ) (germPseudo_cw_iff.mpr ⟨φ - (θ - δ), by linarith [hφ.1], fun ψ hψ => h ψ ⟨?_, ?_⟩⟩)
    · linarith [hψ.1]
    · linarith [hψ.2, hφ.2]
  have hR0 : ∀ θ δ v, (∀ φ ∈ Ioo θ (θ + δ), P φ = {g v}) → ∀ φ ∈ Ioo θ (θ + δ), c φ = v := by
    intro θ δ v h φ hφ
    refine huniq (hc φ) (germPseudo_cw_iff.mpr ⟨φ - θ, by linarith [hφ.1], fun ψ hψ => h ψ ⟨?_, ?_⟩⟩)
    · linarith [hψ.1]
    · linarith [hψ.2, hφ.2]
  have hshift : ∀ θ s a, F.GermPseudo p (θ + 2 * π) s a ↔ F.GermPseudo p θ s a := fun θ s a => by
    rw [show θ + 2 * π = θ + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring]; exact germPseudo_add_int_mul 1
  set S : Set ℝ := {θ | ¬ ∃ v, F.GermPseudo p θ .cw (g v) ∧ F.GermPseudo p θ .ccw (g v)} with hS
  have hLeft : ∀ θ v, (∀ᶠ φ in 𝓝[<] θ, c φ = v) ↔ F.GermPseudo p θ .cw (g v) := by
    intro θ v
    constructor
    · intro h
      obtain ⟨w, hw⟩ := hgerm θ .cw
      obtain ⟨δ, hδ, hδP⟩ := germPseudo_cw_iff.mp hw
      have h2 : ∀ᶠ φ in 𝓝[<] θ, c φ = w :=
        Filter.mem_of_superset (Ioo_mem_nhdsLT (by linarith : θ - δ < θ)) fun φ hφ => hL0 θ δ w hδP φ hφ
      obtain ⟨φ, h1, h2⟩ := (h.and h2).exists
      rw [← h1.symm.trans h2] at hw
      exact hw
    · intro h
      obtain ⟨δ, hδ, hδP⟩ := germPseudo_cw_iff.mp h
      exact Filter.mem_of_superset (Ioo_mem_nhdsLT (by linarith : θ - δ < θ)) fun φ hφ => hL0 θ δ v hδP φ hφ
  have hRight : ∀ θ v, (∀ᶠ φ in 𝓝[>] θ, c φ = v) ↔ F.GermPseudo p θ .ccw (g v) := by
    intro θ v
    constructor
    · intro h
      obtain ⟨w, hw⟩ := hgerm θ .ccw
      obtain ⟨δ, hδ, hδP⟩ := germPseudo_ccw_iff.mp hw
      have h2 : ∀ᶠ φ in 𝓝[>] θ, c φ = w :=
        Filter.mem_of_superset (Ioo_mem_nhdsGT (by linarith : θ < θ + δ)) fun φ hφ => hR0 θ δ w hδP φ hφ
      obtain ⟨φ, h1, h2⟩ := (h.and h2).exists
      rw [← h1.symm.trans h2] at hw
      exact hw
    · intro h
      obtain ⟨δ, hδ, hδP⟩ := germPseudo_ccw_iff.mp h
      exact Filter.mem_of_superset (Ioo_mem_nhdsGT (by linarith : θ < θ + δ)) fun φ hφ => hR0 θ δ v hδP φ hφ
  -- the two-element pseudo-colour at a change point
  have hpair2 : ∀ φ (a b : ZMod 3), a ≠ b → F.GermPseudo p φ .cw (g a) → F.GermPseudo p φ .ccw (g b) →
      P φ = {g a, g b} := by
    intro φ a b hab ha hb
    have hsub : ({g a, g b} : Set (Fin 6)) ⊆ P φ :=
      insert_subset ha.mem_pseudoColours (singleton_subset_iff.mpr hb.mem_pseudoColours)
    refine (Set.eq_of_subset_of_ncard_le hsub ?_).symm
    rw [Set.ncard_pair (hg.ne hab)]
    exact B.pseudo_ncard_le_two hp hp3 (dist_ringPt p φ)
  have hd60 : ∀ φ ψ, |φ - ψ| = π / 3 → dist (ringPt p φ) (ringPt p ψ) = 1 := fun φ ψ h =>
    ((dist_ringPt_ringPt_cmp_one p (by rw [h]; linarith)).1).mpr h
  refine ⟨⟨c, S, fun θ => ?_, fun θ => ?_, ?_, ?_, ?_⟩, g, hg, hgu, hLeft, hRight, ?_, ?_⟩
  · -- periodic
    exact huniq ((hshift θ .cw _).mp (hc (θ + 2 * π))) (hc θ)
  · -- periodic change set
    simp only [hS, mem_setOf_eq, hshift]
  · -- finitely many change points per period
    refine (B.pseudo_finite hp hp3).subset ?_
    rintro θ ⟨hθS, hθI⟩
    refine ⟨hθI, ?_⟩
    obtain ⟨v, hv⟩ := hgerm θ .cw
    obtain ⟨w, hw⟩ := hgerm θ .ccw
    have hvw : v ≠ w := fun h => hθS ⟨v, hv, h ▸ hw⟩
    exact pseudo_ncard_ne_one_of_change (hg.ne hvw) hv hw
  · -- locally constant off the change set
    intro θ hθ
    simp only [hS, mem_setOf_eq, not_not] at hθ
    obtain ⟨v, hv, hv'⟩ := hθ
    obtain ⟨δ₁, hδ₁, h₁⟩ := germPseudo_cw_iff.mp hv
    obtain ⟨δ₂, hδ₂, h₂⟩ := germPseudo_ccw_iff.mp hv'
    have hcθ : c θ = v := huniq (hc θ) hv
    filter_upwards [Ioo_mem_nhds (by linarith [lt_min hδ₁ hδ₂] : θ - min δ₁ δ₂ < θ) (by linarith [lt_min hδ₁ hδ₂] : θ < θ + min δ₁ δ₂)]
      with φ hφ
    rw [hcθ]
    rcases lt_trichotomy φ θ with h | rfl | h
    · exact hL0 θ δ₁ v h₁ φ ⟨by linarith [hφ.1, min_le_left δ₁ δ₂], h⟩
    · exact hcθ
    · exact hR0 θ δ₂ v h₂ φ ⟨h, by linarith [hφ.2, min_le_right δ₁ δ₂]⟩
  · -- proper at `60°`: FS112-N3-PAIRS (i)
    intro θ hθ hθ' hcc
    simp only [hS, mem_setOf_eq, not_not] at hθ hθ'
    obtain ⟨v, hv, hv'⟩ := hθ
    obtain ⟨w, hw, hw'⟩ := hθ'
    have hvw : v = w := by rw [← huniq (hc θ) hv, ← huniq (hc (θ + π / 3)) hw]; exact hcc
    subst hvw
    obtain ⟨δ₁, hδ₁, h₁⟩ := germPseudo_ccw_iff.mp hv'
    obtain ⟨δ₂, hδ₂, h₂⟩ := germPseudo_ccw_iff.mp hw'
    set φ := θ + min δ₁ δ₂ / 2 with hφ
    have hm := lt_min hδ₁ hδ₂
    exact pair_i B.valid hp3 hp3 hcov hcov (by rw [dist_self]; norm_num) (dist_ringPt p φ) (dist_ringPt p (φ + π / 3))
      (hd60 φ (φ + π / 3) (by rw [show φ - (φ + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]))
      (h₁ φ ⟨by linarith, by linarith [min_le_left δ₁ δ₂]⟩)
      (h₂ (φ + π / 3) ⟨by linarith, by linarith [min_le_right δ₁ δ₂]⟩)
  · -- the change set holds only genuine changes
    intro θ hθ ⟨v, h1, h2⟩
    exact hθ ⟨v, (hLeft θ v).mp h1, (hRight θ v).mp h2⟩
  · -- no swap point: FS112-N3-PAIRS (ii), with NOBOTH and H
    rintro x ⟨hxS, a, b, ha, hb, hy⟩
    have hab : a ≠ b := fun h => hxS ⟨a, (hLeft x a).mp ha, h ▸ (hRight x b).mp hb⟩
    have hPx := hpair2 x a b hab ((hLeft x a).mp ha) ((hRight x b).mp hb)
    have hfin : ∀ y, |x - y| = π / 3 → (∀ᶠ φ in 𝓝[<] y, c φ = b) → (∀ᶠ φ in 𝓝[>] y, c φ = a) → False := by
      intro y hxy hyb hya
      have hPy := hpair2 y b a hab.symm ((hLeft y b).mp hyb) ((hRight y a).mp hya)
      rw [Set.pair_comm] at hPy
      have htr : ringPt p y ≠ p ∧ dist (ringPt p y) p ≠ 2 := ⟨fun h => by
        have := dist_ringPt p y; rw [h, dist_self] at this; norm_num at this, by rw [dist_ringPt]; norm_num⟩
      rcases pair_ii B.valid hp3 hp3 hcov hcov (dist_ringPt p x) (dist_ringPt p y) (hd60 x y hxy) htr (hg.ne hab) hPx hPy
        with h4 | hboth
      · exact Set.disjoint_left.mp B.hyp (hring2 x) (Or.inl ⟨B.covers (hring2 x), h4⟩)
      · obtain ⟨θ₁, θ₂, hb'⟩ := hboth
        exact Set.disjoint_left.mp B.hyp (hring2 y) (noBoth B.valid (B.covers (hring2 y)) hb' |>.elim
          (fun h => Or.inl ⟨B.covers (hring2 y), h⟩) (fun h => Or.inr ⟨B.covers (hring2 y), h⟩))
    rcases hy with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · exact hfin (x + π / 3) (by rw [show x - (x + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]) h1 h2
    · exact hfin (x - π / 3) (by rw [show x - (x - π / 3) = π / 3 by ring, abs_of_pos (by positivity)]) h1 h2

/-- **The returning arcs are removable** (FS110-CD Lemma R step 3): for `x` inside a returning arc and `y = r(x ± 60°)`, `ω(y)` crosses `ω(u)`
only at `x` within the arc, so it separates its ends; the `a`-tile and the `c`-tile, connected with both ends in their closures (through `K`),
meet `ω(y)`, so neither colour is at `y` (the (P) sweep) and `c′(y)` is the third colour. The colour pattern at the ends is in `IsRetArc`. -/
theorem BaseCtx.retArc_partner (B : F.BaseCtx u) {s t : ℝ} (hR : F.IsRetArc u s t) {x : ℝ} (hx : x ∈ Ioo s t) {a c : Fin 6}
    (ha : F.GermPseudo u s .cw a) (hc : F.GermPseudo u s .ccw c) (y : ℝ) (hy : y = x + π / 3 ∨ y = x - π / 3) :
    a ∉ F.pseudoColours u (ringPt u y) ∧ c ∉ F.pseudoColours u (ringPt u y) := by
  obtain ⟨hst, hst', a', c', -, ha', hc', -, -, T₁, T₂, hT₁, hT₂, K, -, hsK, htK, hKsub⟩ := hR
  obtain rfl := germPseudo_unique ha' ha
  obtain rfl := germPseudo_unique hc' hc
  obtain ⟨hx1, hx2⟩ := hx
  -- `r(s)` and `r(t)` on opposite sides of `ω(r(y))`
  have hfar : ∃ x₁ x₂, (x₁ = ringPt u s ∨ x₁ = ringPt u t) ∧ (x₂ = ringPt u s ∨ x₂ = ringPt u t) ∧
      dist x₁ (ringPt u y) < 1 ∧ 1 < dist x₂ (ringPt u y) := by
    rcases hy with rfl | rfl
    · refine ⟨_, _, Or.inr rfl, Or.inl rfl, ?_, ?_⟩
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.1).mpr ?_ <;> rw [abs_of_neg (by linarith)] <;> linarith [Real.pi_pos]
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.2).mpr ?_ <;> rw [abs_of_neg (by linarith)] <;> linarith [Real.pi_pos]
    · refine ⟨_, _, Or.inl rfl, Or.inr rfl, ?_, ?_⟩
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.1).mpr ?_ <;> rw [abs_of_pos (by linarith)] <;> linarith [Real.pi_pos]
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.2).mpr ?_ <;> rw [abs_of_pos (by linarith)] <;> linarith [Real.pi_pos]
  obtain ⟨x₁, x₂, hx₁, hx₂, hd₁, hd₂⟩ := hfar
  have hcl : ∀ {z}, (z = ringPt u s ∨ z = ringPt u t) → z ∈ closure T₁ ∧ z ∈ closure T₂ := by
    rintro z (rfl | rfl)
    · exact (hKsub hsK).1
    · exact (hKsub htK).1
  obtain ⟨t₁, ht₁, ht₁d⟩ := hT₁.1.exists_dist_eq_one (hcl hx₁).1 (hcl hx₂).1 hd₁ hd₂
  obtain ⟨t₂, ht₂, ht₂d⟩ := hT₂.1.exists_dist_eq_one (hcl hx₁).2 (hcl hx₂).2 hd₁ hd₂
  exact ⟨fun h => not_mem_coloursAt_of_tile_dist B.valid hT₁ ht₁ ht₁d h.1,
    fun h => not_mem_coloursAt_of_tile_dist B.valid hT₂ ht₂ ht₂d h.1⟩

/-- **Finitely many returning arcs** (FS110-CD Lemma R): their ends are change points of the pseudo-colouring, finitely many per period. -/
theorem BaseCtx.retArcs_finite (B : F.BaseCtx u) :
    {q : ℝ × ℝ | q.1 ∈ Ico 0 (2 * π) ∧ F.IsRetArc u q.1 q.2}.Finite := by
  set S := {θ | θ ∈ Ico 0 (2 * π) ∧ (F.pseudoColours u (ringPt u θ)).ncard ≠ 1} with hS
  have hfin : S.Finite := B.pseudo_finite (mem_closedBall_self zero_le_one) B.cubic
  refine (hfin.prod (hfin.union (hfin.image fun θ => θ + 2 * π))).subset ?_
  rintro ⟨s, t⟩ ⟨hs, hst, hst', a, c, hac, ha, hc, hc', ha', -⟩
  have hπ := Real.pi_pos
  refine ⟨⟨hs, pseudo_ncard_ne_one_of_change hac ha hc⟩, ?_⟩
  have ht := pseudo_ncard_ne_one_of_change hac.symm hc' ha'
  rcases lt_or_ge t (2 * π) with h | h
  · exact Or.inl ⟨⟨by linarith [hs.1], h⟩, ht⟩
  · refine Or.inr ⟨t - 2 * π, ⟨⟨by linarith, by linarith [hs.2]⟩, ?_⟩, by ring⟩
    have hc'' : F.GermPseudo u (t - 2 * π) .cw c := by
      obtain ⟨δ, hδ, h'⟩ := hc'; exact ⟨δ, hδ, by rw [germ_sub_two_pi]; exact h'⟩
    have ha'' : F.GermPseudo u (t - 2 * π) .ccw a := by
      obtain ⟨δ, hδ, h'⟩ := ha'; exact ⟨δ, hδ, by rw [germ_sub_two_pi]; exact h'⟩
    exact pseudo_ncard_ne_one_of_change hac.symm hc'' ha''

/-- **The returning arcs nest or are disjoint** (FS110-CB D5 item 1, "paths do not cross; their arcs nest or are disjoint"; FS110-CD Lemma R
step 4) — **planar core**: interleaved ends would make the `a`-tile of one pair cross the boundary of the other's tiles away from a
four-colour point, and abutting ends would need two inner `a|c` germs at one point of `ω(u)` (each point there has at most three colours, one
sector each, under H, and an `a|c` germ along `ω(u)` is an inert arc, excluded by `NoInertNear`) — the joining continua `K` of `IsRetArc` carry
this. Planned over the finite boundary graph of the disc (plan § 4, leaf C3). -/
theorem BaseCtx.retArcs_nested (B : F.BaseCtx u) {s t s' t' : ℝ} (h : F.IsRetArc u s t) (h' : F.IsRetArc u s' t') :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t := by
  sorry

/-- **A non-returning change point has an endpoint** (`[SokolovVoronov2025]` Prop. 19(b) as FS110-CD Lemma E and FS110-CE R1–R4 repaired it,
path-free in its conclusion) — **planar core**: a change point `r(θ)` of the pseudo-colouring of `ω(u)` with pair `{a, c}`, outside every returning
arc (CD's sense: `IsRetArc` carries the joining `a|c` continuum in the closed disc, inventory item 232), has an
endpoint: the `a|c` boundary from it, continued through spikes, ends at a three-colour point of `B(u, 1)` or at a V-in vertex of `ω(u)`, in the
closures of the two tiles at `r(θ)`. Planned over the finite boundary graph (the handshake lemma, plan § 4, leaf C4). -/
theorem BaseCtx.exists_endpoint (B : F.BaseCtx u) {θ : ℝ} {a c : Fin 6} (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a)
    (hc : F.GermPseudo u θ .ccw c ∨ (F.GermPseudo u θ .cw c ∧ F.GermPseudo u θ .ccw a))
    (hout : ∀ s t, F.IsRetArc u s t → ringPt u θ ∉ ringArc u s t) :
    ∃ p, F.IsEndpoint u (ringPt u θ) a c p := by
  sorry

/-- **The eleventh point** (`[SokolovVoronov2025]` p. 28, "on the boundary of the union of three regions … whose vertex is `u`, there is at
least one more trichromatic point"; FS110-CD § 2.6; FS112-N3-3) — proved from `B.unenclosed` (FS131-E4 E4-RIM, `plans/FS131-E4-derivation.md`
§ Argument for E4-RIM: the outer frontier of `u`'s `P_cl(u)`-component is connected and borders two of its tiles, since a lone bordering tile would
enclose `u`'s other tiles). Every printed source obtains it after hole-filling, which in the local base can destroy `u` (KB's plan § 2.3); the
hypothesis `UnenclosedC u` replaces that step. A three-colour point of `B̄(u, 1)` carrying exactly two colours of `u`, whose tiles of those
colours lie in `B(u, 1)`. -/
theorem BaseCtx.exists_eleventh (B : F.BaseCtx u) :
    ∃ q ∈ closedBall u 1, (F.coloursAt q).ncard = 3 ∧ (F.coloursAt q ∩ F.coloursAt u).ncard = 2 ∧
      ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1 := by
  sorry

/-! ## D — the refuters and the distances -/

/-- **Endpoints of one pair are at least `1` apart** (FS110-CB D5 item 6; FS110-CD § 2.8 item 1): two points `x₁`, `x₂` more than `1` apart
in the closures of `a`-tiles `T₁`, `T₂` (distinct, since a tile has diameter below `1`, and then all cross distances exceed `1` by validity and
connectedness), so points `p₁`, `p₂` of those closures are at least `1` apart. Any `k`, no base context. -/
theorem endpoint_dist_ge {k : ℕ} {F : ArcMap k} (hF : F.Valid) {a : Fin k} {T₁ T₂ : Set ℂ} (h₁ : F.TileOf a T₁) (h₂ : F.TileOf a T₂)
    {x₁ x₂ p₁ p₂ : ℂ} (hx₁ : x₁ ∈ closure T₁) (hx₂ : x₂ ∈ closure T₂) (hp₁ : p₁ ∈ closure T₁) (hp₂ : p₂ ∈ closure T₂)
    (hx : 1 < dist x₁ x₂) : 1 ≤ dist p₁ p₂ := by
  -- no pair of the two tiles is at distance `1` (one colour, validity)
  have hne : ∀ s ∈ T₁, ∀ t ∈ T₂, dist s t ≠ 1 := fun s hs t ht h1 =>
    hF s (h₁.1.subset_interiorPts hs) t (h₂.1.subset_interiorPts ht) h1 (by rw [h₁.2 hs, h₂.2 ht])
  -- a pair near `(x₁, x₂)` is farther than `1`
  set δ := (dist x₁ x₂ - 1) / 2 with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp hx₁ δ hδ0
  obtain ⟨t₀, ht₀, ht₀d⟩ := Metric.mem_closure_iff.mp hx₂ δ hδ0
  have hfar : 1 < dist s₀ t₀ := by
    have := dist_triangle4 x₁ s₀ t₀ x₂
    rw [dist_comm t₀ x₂] at this
    linarith
  -- so every pair is farther than `1` (the distances over the connected `T₁ × T₂` form an interval missing `1`)
  have hpre : IsPreconnected ((fun q : ℂ × ℂ => dist q.1 q.2) '' (T₁ ×ˢ T₂)) :=
    (h₁.1.isPreconnected.prod h₂.1.isPreconnected).image _ (continuous_fst.dist continuous_snd).continuousOn
  have hall : ∀ q ∈ T₁ ×ˢ T₂, 1 ≤ dist q.1 q.2 := by
    rintro ⟨s, t⟩ ⟨hs, ht⟩
    by_contra hlt
    push Not at hlt
    obtain ⟨q, hq, hq1⟩ := hpre.Icc_subset ⟨(s, t), ⟨hs, ht⟩, rfl⟩ ⟨(s₀, t₀), ⟨hs₀, ht₀⟩, rfl⟩ ⟨hlt.le, hfar.le⟩
    exact hne q.1 hq.1 q.2 hq.2 hq1
  -- and on the closures
  have hcl : closure (T₁ ×ˢ T₂) ⊆ {q : ℂ × ℂ | 1 ≤ dist q.1 q.2} :=
    closure_minimal hall (isClosed_le continuous_const (continuous_fst.dist continuous_snd))
  rw [closure_prod_eq] at hcl
  exact hcl (show (p₁, p₂) ∈ closure T₁ ×ˢ closure T₂ from ⟨hp₁, hp₂⟩)

/-- **A point of a colour's class within `1` of a tile of that colour stays within `1` of all of it** (Lemma H's distance step, FS110-CD § 2.3):
in a valid map, if `s` lies in the class of `i` and within distance `1` of a point of an `i`-tile `T`, then every point of the closure of `T` is
within distance `1` of `s` (the distances from `s` over the connected `T` form an interval that misses `1`). Any `k`, no base context. -/
theorem dist_le_one_of_mem_region {k : ℕ} {F : ArcMap k} (hF : F.Valid) {i : Fin k} {T : Set ℂ} (hT : F.TileOf i T) {s t₀ : ℂ}
    (hs : s ∈ F.region i) (ht₀ : t₀ ∈ T) (hst : dist s t₀ < 1) {q : ℂ} (hq : q ∈ closure T) : dist s q ≤ 1 := by
  have hne : ∀ t ∈ T, dist s t ≠ 1 := fun t ht h1 =>
    hF s hs.1 t (hT.1.subset_interiorPts ht) h1 (by rw [hs.2, hT.2 ht])
  have hpre : IsPreconnected ((fun t : ℂ => dist s t) '' T) :=
    hT.1.isPreconnected.image _ (continuous_const.dist continuous_id).continuousOn
  have hall : ∀ t ∈ T, dist s t ≤ 1 := by
    intro t ht
    by_contra hlt
    push Not at hlt
    obtain ⟨y, hy, hy1⟩ := hpre.Icc_subset ⟨t₀, ht₀, rfl⟩ ⟨t, ht, rfl⟩ ⟨hst.le, hlt.le⟩
    exact hne y hy hy1
  exact closure_minimal hall (isClosed_le (continuous_const.dist continuous_id) continuous_const) hq

/-- Real arithmetic for `eq_of_dist_le_one_antipodal`: two antipodal unit vectors `a`, `b` and a vector `w` within `1` of both: `w = 0`
(`b = −a`, and the parallelogram law gives `2|w|² + 2 ≤ 2`). -/
theorem antipodal_aux {a1 a2 b1 b2 w1 w2 : ℝ} (h1 : a1 ^ 2 + a2 ^ 2 = 1) (h2 : b1 ^ 2 + b2 ^ 2 = 1)
    (h3 : (a1 - b1) ^ 2 + (a2 - b2) ^ 2 = 4) (h4 : (w1 - a1) ^ 2 + (w2 - a2) ^ 2 ≤ 1) (h5 : (w1 - b1) ^ 2 + (w2 - b2) ^ 2 ≤ 1) :
    w1 = 0 ∧ w2 = 0 := by
  have hs : (a1 + b1) ^ 2 + (a2 + b2) ^ 2 = 0 := by linear_combination 2 * h1 + 2 * h2 - h3
  have hb1 : a1 + b1 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb2 : a2 + b2 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb1' : b1 = -a1 := by linarith
  have hb2' : b2 = -a2 := by linarith
  subst hb1' hb2'
  have hw : w1 ^ 2 + w2 ^ 2 ≤ 0 := by nlinarith
  exact ⟨by nlinarith [sq_nonneg w1, sq_nonneg w2], by nlinarith [sq_nonneg w1, sq_nonneg w2]⟩

/-- The closed unit discs about two antipodal points of `ω(u)` meet only at `u`. -/
theorem eq_of_dist_le_one_antipodal {u p p' s : ℂ} (hp : dist p u = 1) (hp' : dist p' u = 1) (h2 : dist p p' = 2)
    (hs : dist s p ≤ 1) (hs' : dist s p' ≤ 1) : s = u := by
  have sq : ∀ z w : ℂ, dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := fun z w => by
    rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]
  have e1 := sq p u; rw [hp, one_pow] at e1
  have e2 := sq p' u; rw [hp', one_pow] at e2
  have e3 := sq p p'; rw [h2] at e3
  have e4 : dist s p ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := s) (y := p)]
  have e5 : dist s p' ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := s) (y := p')]
  rw [sq] at e4 e5
  obtain ⟨w1, w2⟩ := antipodal_aux (a1 := p.re - u.re) (a2 := p.im - u.im) (b1 := p'.re - u.re) (b2 := p'.im - u.im)
    (w1 := s.re - u.re) (w2 := s.im - u.im) e1.symm e2.symm
    (by rw [show (2 : ℝ) ^ 2 = 4 by norm_num] at e3; linear_combination -e3)
    (by linear_combination e4) (by linear_combination e5)
  exact Complex.ext (by linarith) (by linarith)

/-- An open set containing a point `u` of `ℂ`, or meeting every ball about it, holds a point other than `u` near `u`: a point of the class of
a colour carried at `u`, distinct from `u`, within any `ε > 0`. -/
theorem exists_mem_region_ne {k : ℕ} {F : ArcMap k} {u : ℂ} {i : Fin k} (hi : i ∈ F.coloursAt u) {ε : ℝ} (hε : 0 < ε) :
    ∃ s ∈ F.region i, s ≠ u ∧ dist s u < ε := by
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp hi ε hε
  have hopen : IsOpen (F.region i ∩ ball u ε) := (F.isOpen_region i).inter isOpen_ball
  have hs₀' : s₀ ∈ F.region i ∩ ball u ε := ⟨hs₀, by rw [mem_ball, dist_comm]; exact hs₀d⟩
  obtain ⟨δ, hδ, hδs⟩ := Metric.isOpen_iff.mp hopen s₀ hs₀'
  by_cases hsu : s₀ = u
  · subst hsu
    have hm : s₀ + ((δ / 2 : ℝ) : ℂ) ∈ ball s₀ δ := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
      linarith
    refine ⟨_, (hδs hm).1, fun h => ?_, (hδs hm).2⟩
    have : ((δ / 2 : ℝ) : ℂ) = 0 := by linear_combination h
    have : (δ / 2 : ℝ) = 0 := by exact_mod_cast this
    linarith
  · exact ⟨s₀, hs₀, hsu, hs₀'.2⟩

/-- **A tile of each colour carried at a point** of the domain has the point in its closure (through the sector chart: a point of the class
near the base lies in a sector, which lies in a tile). -/
theorem exists_tileOf_of_mem_coloursAt {k : ℕ} {F : ArcMap k} {q : ℂ} (hq : q ∈ F.dom) {j : Fin k} (hj : j ∈ F.coloursAt q) :
    ∃ T, F.TileOf j T ∧ q ∈ closure T := by
  obtain ⟨r, hr, hrpos⟩ := ((exists_sector_of_mem hq).and self_mem_nhdsWithin).exists
  obtain ⟨p, hp, hpd⟩ := Metric.mem_closure_iff.mp hj r hrpos
  obtain ⟨S, hS, hpS⟩ := hr p ⟨hp.1, by rw [mem_ball, dist_comm]; exact hpd⟩
  have hSj : S ∈ F.sectorsOf q r j :=
    ⟨hS, fun z hz => ((hS.subset_region hpS hz).2 : F.col z = F.col p).trans hp.2⟩
  obtain ⟨X, hX, -, hqX⟩ := sector_subset_tile hSj
  exact ⟨X, hX, hqX⟩

/-- Squared distances in coordinates. -/
theorem dist_sq_re_im (z w : ℂ) : dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
  rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]

/-- Real arithmetic: two antipodal unit vectors `a`, `b` (`|a − b| = 2`) satisfy `b = −a`. -/
theorem antipodal_neg {a1 a2 b1 b2 : ℝ} (h1 : a1 ^ 2 + a2 ^ 2 = 1) (h2 : b1 ^ 2 + b2 ^ 2 = 1)
    (h3 : (a1 - b1) ^ 2 + (a2 - b2) ^ 2 = 4) : b1 = -a1 ∧ b2 = -a2 := by
  have hs : (a1 + b1) ^ 2 + (a2 + b2) ^ 2 = 0 := by linear_combination 2 * h1 + 2 * h2 - h3
  have hb1 : a1 + b1 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb2 : a2 + b2 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  exact ⟨by linarith, by linarith⟩

/-- **The cusp between two tangent unit discs**: for antipodal `q`, `p` on `ω(u)` and any `ε > 0`, some point within `ε` of `u` is farther than `1`
from both (`u + (ε/2) i (q − u)`, at distance `√(1 + ε²/4)` from each). -/
theorem exists_near_far_antipodal {u q p : ℂ} (hq : dist q u = 1) (hp : dist p u = 1) (h2 : dist q p = 2) {ε : ℝ} (hε : 0 < ε) :
    ∃ z₀ : ℂ, dist z₀ u < ε ∧ 1 < dist z₀ q ∧ 1 < dist z₀ p := by
  have e1 := dist_sq_re_im q u; rw [hq, one_pow] at e1
  have e2 := dist_sq_re_im p u; rw [hp, one_pow] at e2
  have e3 := dist_sq_re_im q p; rw [h2] at e3
  obtain ⟨hb1, hb2⟩ := antipodal_neg (a1 := q.re - u.re) (a2 := q.im - u.im) (b1 := p.re - u.re) (b2 := p.im - u.im)
    e1.symm e2.symm (by linear_combination -e3)
  have hpre : p.re = u.re - (q.re - u.re) := by linarith
  have hpim : p.im = u.im - (q.im - u.im) := by linarith
  refine ⟨⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩, ?_, ?_, ?_⟩
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) u ^ 2 = (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - u.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - u.im) ^ 2 = (ε / 2) ^ 2
      linear_combination (ε / 2) ^ 2 * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := u)]
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) q ^ 2 = 1 + (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - q.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - q.im) ^ 2 = 1 + (ε / 2) ^ 2
      linear_combination (1 + (ε / 2) ^ 2) * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := q)]
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) p ^ 2 = 1 + (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - p.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - p.im) ^ 2 = 1 + (ε / 2) ^ 2
      rw [hpre, hpim]
      linear_combination (1 + (ε / 2) ^ 2) * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := p)]

/-- **No two V-in points of one colour of `u` are antipodal** (FS110-CD Theorem D2 (i); FS110-CE's Antipodal Lemma): their tiles of that
colour lie in `B̄(p, 1) ∩ B̄(p′, 1) = {u}` (Lemma H(b)), against openness. -/
theorem BaseCtx.vin_antipodal (B : F.BaseCtx u) {p p' : ℂ} {i : Fin 6} (hi : i ∈ F.coloursAt u)
    (hp : dist p u = 1) (hp' : dist p' u = 1) (hpi : ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty)
    (hpi' : ∃ T, F.TileOf i T ∧ p' ∈ closure T ∧ (T ∩ ball u 1).Nonempty) : dist p p' ≠ 2 := by
  intro h2
  obtain ⟨T, hT, hpT, t₀, ht₀T, ht₀u⟩ := hpi
  obtain ⟨T', hT', hpT', t₀', ht₀T', ht₀u'⟩ := hpi'
  rw [mem_ball] at ht₀u ht₀u'
  have hε : 0 < min (1 - dist t₀ u) (1 - dist t₀' u) := lt_min (by linarith) (by linarith)
  obtain ⟨s, hs, hsu, hsd⟩ := exists_mem_region_ne hi hε
  have h1 : dist s t₀ < 1 := by
    have := dist_triangle s u t₀; rw [dist_comm u t₀] at this
    linarith [min_le_left (1 - dist t₀ u) (1 - dist t₀' u)]
  have h1' : dist s t₀' < 1 := by
    have := dist_triangle s u t₀'; rw [dist_comm u t₀'] at this
    linarith [min_le_right (1 - dist t₀ u) (1 - dist t₀' u)]
  exact hsu (eq_of_dist_le_one_antipodal hp hp' h2 (dist_le_one_of_mem_region B.valid hT hs ht₀T h1 hpT)
    (dist_le_one_of_mem_region B.valid hT' hs ht₀T' h1' hpT'))

/-- **The eleventh point is not antipodal to a complementary V-in endpoint** (FS110-CD Theorem D2 (ii)): the cusps `u + t·e⊥` between the two
tangent discs meet none of `u`'s three tiles, against the sector picture at `u`. -/
theorem BaseCtx.eleventh_antipodal (B : F.BaseCtx u) {q p : ℂ} (hq : dist q u = 1)
    (hqT : ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1)
    (hq2 : (F.coloursAt q ∩ F.coloursAt u).ncard = 2) (hp : F.VIn u p) (hdis : Disjoint (F.coloursAt q) (F.coloursAt p)) :
    dist q p ≠ 2 := by
  intro h2
  obtain ⟨hpu, i, hiu, T, hT, hpT, t₀, ht₀T, ht₀u⟩ := hp
  rw [mem_ball] at ht₀u
  have hdom : ∀ {z : ℂ}, dist z u ≤ 2 → z ∈ F.dom := fun hz => B.covers (by rw [mem_closedBall]; exact hz)
  -- `i` is `u`'s colour off `q`, and every colour of `u` is `i` or one of `q`'s
  have hip : i ∈ F.coloursAt p :=
    closure_mono (show T ⊆ F.region i from fun z hz => ⟨hT.1.subset_interiorPts hz, hT.2 hz⟩) hpT
  have hiq : i ∉ F.coloursAt q := fun h => Set.disjoint_left.mp hdis h hip
  have hdiff : (F.coloursAt u \ F.coloursAt q).ncard = 1 := by
    have := Set.ncard_inter_add_ncard_sdiff_eq_ncard (F.coloursAt u) (F.coloursAt q) (Set.toFinite _)
    rw [Set.inter_comm, hq2, B.cubic.2] at this
    omega
  have hcol : ∀ c ∈ F.coloursAt u, c = i ∨ c ∈ F.coloursAt q ∩ F.coloursAt u := by
    intro c hc
    by_cases hcq : c ∈ F.coloursAt q
    · exact Or.inr ⟨hcq, hc⟩
    · left
      obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp hdiff
      have h1 : c ∈ F.coloursAt u \ F.coloursAt q := ⟨hc, hcq⟩
      have h2 : i ∈ F.coloursAt u \ F.coloursAt q := ⟨hiu, hiq⟩
      rw [ha] at h1 h2
      exact h1.trans h2.symm
  -- the two colours shared with `q`, each with a tile at `q` inside `B(u, 1)`
  obtain ⟨j₁, j₂, hj12, hJ⟩ := Set.ncard_eq_two.mp hq2
  have hqdom : q ∈ F.dom := hdom (by rw [hq]; norm_num)
  have htile : ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∃ T', F.TileOf j T' ∧ q ∈ closure T' ∧ ∃ t ∈ T', dist t u < 1 := by
    intro j hj
    obtain ⟨T', hT', hqT'⟩ := exists_tileOf_of_mem_coloursAt hqdom hj.1
    obtain ⟨t, ht⟩ := hT'.1.nonempty
    exact ⟨T', hT', hqT', t, ht, mem_ball.mp (hqT j hj T' hT' hqT' ht)⟩
  obtain ⟨T₁, hT₁, hqT₁, t₁, ht₁, ht₁u⟩ := htile j₁ (by rw [hJ]; simp)
  obtain ⟨T₂, hT₂, hqT₂, t₂, ht₂, ht₂u⟩ := htile j₂ (by rw [hJ]; simp)
  -- a radius inside which every interior point carries a colour of `u`, and all three tiles reach
  obtain ⟨r₀, hr₀, hr₀pos⟩ := ((eventually_col_mem_coloursAt u).and self_mem_nhdsWithin).exists
  have hr₀pos' : 0 < r₀ := hr₀pos
  set ε := min (min (1 - dist t₀ u) (1 - dist t₁ u)) (min (1 - dist t₂ u) r₀) with hεdef
  have hε : 0 < ε := lt_min (lt_min (by linarith) (by linarith)) (lt_min (by linarith) hr₀pos')
  have hε0 : ε ≤ 1 - dist t₀ u := (min_le_left _ _).trans (min_le_left _ _)
  have hε1 : ε ≤ 1 - dist t₁ u := (min_le_left _ _).trans (min_le_right _ _)
  have hε2 : ε ≤ 1 - dist t₂ u := (min_le_right _ _).trans (min_le_left _ _)
  have hεr : ε ≤ r₀ := (min_le_right _ _).trans (min_le_right _ _)
  have hε1' : ε ≤ 1 := hε0.trans (by linarith [dist_nonneg (x := t₀) (y := u)])
  obtain ⟨z₀, hz₀u, hz₀q, hz₀p⟩ := exists_near_far_antipodal hq hpu h2 hε
  -- an interior point of the map near `z₀` with the same three properties
  have hU : IsOpen {z : ℂ | dist z u < ε ∧ 1 < dist z q ∧ 1 < dist z p} :=
    (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt continuous_const (continuous_id.dist continuous_const)))
  have hz₀dom : z₀ ∈ F.dom := hdom (by linarith)
  obtain ⟨z, ⟨hzu, hzq, hzp⟩, hzI⟩ := mem_closure_iff.mp (F.dense_interiorPts hz₀dom) _ hU ⟨hz₀u, hz₀q, hz₀p⟩
  have hzc : F.col z ∈ F.coloursAt u := hr₀ z ⟨hzI, mem_ball.mpr (hzu.trans_le hεr)⟩
  have hzr : z ∈ F.region (F.col z) := ⟨hzI, rfl⟩
  have hnear : ∀ t, dist t u < 1 → dist t u + ε ≤ 1 → dist z t < 1 := fun t _ ht => by
    have := dist_triangle z u t; rw [dist_comm u t] at this; linarith
  rcases hcol _ hzc with hci | hcq
  · rw [hci] at hzr
    have := dist_le_one_of_mem_region B.valid hT hzr ht₀T (hnear t₀ ht₀u (by linarith)) hpT
    linarith
  · rw [hJ] at hcq
    rcases hcq with hc1 | hc1
    · rw [hc1] at hzr
      have := dist_le_one_of_mem_region B.valid hT₁ hzr ht₁ (hnear t₁ ht₁u (by linarith)) hqT₁
      linarith
    · rw [mem_singleton_iff] at hc1
      rw [hc1] at hzr
      have := dist_le_one_of_mem_region B.valid hT₂ hzr ht₂ (hnear t₂ ht₂u (by linarith)) hqT₂
      linarith

/-- **Corollary 3 under H** (FS112-N3-COR3): two cubic trichromatic points of `B̄(u, 1)` with disjoint colours are at least `2` apart —
`cor3` would put a four-colour point within `1` of one of them, inside `B̄(u, 2)`. -/
theorem BaseCtx.cor3_base (B : F.BaseCtx u) {p p' : ℂ} (hp : p ∈ closedBall u 1) (hp' : p' ∈ closedBall u 1)
    (h : F.IsCubicTrichromatic p) (h' : F.IsCubicTrichromatic p') (hdis : Disjoint (F.coloursAt p) (F.coloursAt p')) :
    2 ≤ dist p p' := by
  by_contra hlt
  push Not at hlt
  have hcov : ∀ {q : ℂ}, q ∈ closedBall u 1 → F.Covers q 1 := fun {q} hq z hz =>
    B.covers (show z ∈ closedBall u 2 by rw [mem_closedBall] at hq hz ⊢; linarith [dist_triangle z q u])
  obtain ⟨qp, qm, -, hq⟩ := cor3 B.valid h h' (hcov hp) (hcov hp') hdis hlt
  obtain ⟨hqp, -, h4, -⟩ := hq qp (by simp)
  have hqu : qp ∈ closedBall u 2 := by
    rw [mem_closedBall] at hp ⊢; linarith [dist_triangle qp p u]
  have hdom : qp ∈ F.dom := B.covers hqu
  exact Set.disjoint_left.mp B.hyp hqu (Or.inl ⟨hdom, h4⟩)

/-! ### The unit-distance linkage of two unit circles (FS131-I5g, for `l3_base`; BASE-V § 1b.3 step 1) -/

/-- A cosine level is met finitely often on a compact interval. -/
theorem link_cos_fibre (c a b : ℝ) : {θ | θ ∈ Icc a b ∧ Real.cos θ = c}.Finite := by
  by_cases h : ∃ θ₀, Real.cos θ₀ = c
  · obtain ⟨θ₀, h₀⟩ := h
    have hπ := Real.pi_pos
    set N : ℤ := ⌈(|a| + |b| + |θ₀|) / (2 * π)⌉ with hN
    set K := Finset.Icc (-N) N
    refine ((K.finite_toSet.image fun k : ℤ => 2 * k * π + θ₀).union
      (K.finite_toSet.image fun k : ℤ => 2 * k * π - θ₀)).subset ?_
    rintro θ ⟨hθ, hc⟩
    obtain ⟨k, hk⟩ := Real.cos_eq_cos_iff.mp (h₀.trans hc.symm)
    have hθab : |θ| ≤ |a| + |b| := by
      rw [abs_le]; constructor <;> cases abs_cases a <;> cases abs_cases b <;> linarith [hθ.1, hθ.2]
    have h2k : |2 * k * π| ≤ |a| + |b| + |θ₀| := by
      rcases hk with hk | hk
      · have : 2 * k * π = θ - θ₀ := by linarith
        rw [this]; linarith [abs_sub θ θ₀]
      · have : 2 * k * π = θ + θ₀ := by linarith
        rw [this]; linarith [abs_add_le θ θ₀]
    have hkN : |(k : ℝ)| ≤ N := by
      have : |(k : ℝ)| * (2 * π) ≤ |a| + |b| + |θ₀| := by
        rw [show 2 * (k : ℝ) * π = k * (2 * π) by ring, abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * π)] at h2k
        exact h2k
      have h' : |(k : ℝ)| ≤ (|a| + |b| + |θ₀|) / (2 * π) := by rw [le_div_iff₀ (by positivity)]; exact this
      exact h'.trans (Int.le_ceil _)
    have hkK : k ∈ K := by
      rw [Finset.mem_Icc]
      have : |k| ≤ N := by exact_mod_cast hkN
      rw [abs_le] at this; exact this
    rcases hk with hk | hk
    · left; exact ⟨k, hkK, hk.symm⟩
    · right; exact ⟨k, hkK, hk.symm⟩
  · push Not at h
    exact Set.finite_empty.subset fun θ hθ => h θ hθ.2

/-- **A point on two unit circles** with distinct centres `c₁`, `c₂` is `m + r i (c₂ − c₁)` with `m` the midpoint and `r² |c₂ − c₁|² =
1 − |c₂ − c₁|²/4`. -/
theorem link_circles_rep {c₁ c₂ z : ℂ} (hne : c₁ ≠ c₂) (h₁ : dist z c₁ = 1) (h₂ : dist z c₂ = 1) :
    ∃ r : ℝ, z = (c₁ + c₂) / 2 + r * I * (c₂ - c₁) ∧ r ^ 2 * ‖c₂ - c₁‖ ^ 2 = 1 - ‖c₂ - c₁‖ ^ 2 / 4 := by
  have e1 := dist_sq_re_im z c₁
  have e2 := dist_sq_re_im z c₂
  rw [h₁] at e1; rw [h₂] at e2
  have hv : ‖c₂ - c₁‖ ^ 2 = (c₂.re - c₁.re) ^ 2 + (c₂.im - c₁.im) ^ 2 := by
    rw [Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  have hv0 : 0 < (c₂.re - c₁.re) ^ 2 + (c₂.im - c₁.im) ^ 2 := by
    rw [← hv]; have : 0 < ‖c₂ - c₁‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hne.symm); positivity
  have horth : (z.re - (c₁.re + c₂.re) / 2) * (c₂.re - c₁.re) + (z.im - (c₁.im + c₂.im) / 2) * (c₂.im - c₁.im) = 0 := by
    nlinarith
  have hab : (z.re - (c₁.re + c₂.re) / 2) ^ 2 + (z.im - (c₁.im + c₂.im) / 2) ^ 2 =
      1 - ((c₂.re - c₁.re) ^ 2 + (c₂.im - c₁.im) ^ 2) / 4 := by nlinarith
  refine ⟨((z.im - (c₁.im + c₂.im) / 2) * (c₂.re - c₁.re) - (z.re - (c₁.re + c₂.re) / 2) * (c₂.im - c₁.im)) /
    ((c₂.re - c₁.re) ^ 2 + (c₂.im - c₁.im) ^ 2), ?_, ?_⟩
  · apply Complex.ext
    · simp only [Complex.add_re, Complex.div_re, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.I_re, Complex.I_im, Complex.sub_re, Complex.sub_im, Complex.add_im]
      norm_num
      field_simp
      linear_combination (8 * (c₂.re - c₁.re)) * horth
    · simp only [Complex.add_im, Complex.div_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.I_re, Complex.I_im, Complex.sub_re, Complex.sub_im, Complex.add_re]
      norm_num
      field_simp
      linear_combination (8 * (c₂.im - c₁.im)) * horth
  · rw [hv, div_pow]
    field_simp
    linear_combination (16 * ((c₂.re - c₁.re) ^ 2 + (c₂.im - c₁.im) ^ 2)) * hab -
      16 * ((z.re - (c₁.re + c₂.re) / 2) * (c₂.re - c₁.re) + (z.im - (c₁.im + c₂.im) / 2) * (c₂.im - c₁.im)) * horth

/-- **Two distinct points on two unit circles**: every common point is one of them, and `|z₁ − z₂|² = 4 − |c₂ − c₁|²`. -/
theorem link_circles_two {c₁ c₂ z₁ z₂ : ℂ} (hne : c₁ ≠ c₂) (h₁₁ : dist z₁ c₁ = 1) (h₁₂ : dist z₁ c₂ = 1)
    (h₂₁ : dist z₂ c₁ = 1) (h₂₂ : dist z₂ c₂ = 1) (hz : z₁ ≠ z₂) :
    (∀ z, dist z c₁ = 1 → dist z c₂ = 1 → z = z₁ ∨ z = z₂) ∧ ‖z₁ - z₂‖ ^ 2 = 4 - ‖c₂ - c₁‖ ^ 2 := by
  have hv : 0 < ‖c₂ - c₁‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hne.symm)
  have hv2 : 0 < ‖c₂ - c₁‖ ^ 2 := by positivity
  obtain ⟨r₁, e₁, q₁⟩ := link_circles_rep hne h₁₁ h₁₂
  obtain ⟨r₂, e₂, q₂⟩ := link_circles_rep hne h₂₁ h₂₂
  have hsq : ∀ r r' : ℝ, r ^ 2 * ‖c₂ - c₁‖ ^ 2 = 1 - ‖c₂ - c₁‖ ^ 2 / 4 → r' ^ 2 * ‖c₂ - c₁‖ ^ 2 = 1 - ‖c₂ - c₁‖ ^ 2 / 4 →
      r = r' ∨ r = -r' := by
    intro r r' h h'
    have : r ^ 2 = r' ^ 2 := by
      have := h.trans h'.symm
      exact mul_right_cancel₀ hv2.ne' this
    exact sq_eq_sq_iff_eq_or_eq_neg.mp this
  have hr : r₂ = -r₁ := by
    rcases hsq r₂ r₁ q₂ q₁ with h | h
    · exact absurd (by rw [e₁, e₂, h]) hz
    · exact h
  refine ⟨fun z h₁ h₂ => ?_, ?_⟩
  · obtain ⟨r, e, q⟩ := link_circles_rep hne h₁ h₂
    rcases hsq r r₁ q q₁ with h | h
    · left; rw [e, e₁, h]
    · right; rw [e, e₂, h, hr]
  · have : z₁ - z₂ = ((2 * r₁ : ℝ) : ℂ) * (I * (c₂ - c₁)) := by rw [e₁, e₂, hr]; push_cast; ring
    rw [this, norm_mul, norm_mul, Complex.norm_I, Complex.norm_real, Real.norm_eq_abs, one_mul, mul_pow, sq_abs]
    linear_combination 4 * q₁

/-- Two unit circles with distinct centres meet in finitely many points. -/
theorem link_circles_finite {c₁ c₂ : ℂ} (hne : c₁ ≠ c₂) : {z | dist z c₁ = 1 ∧ dist z c₂ = 1}.Finite := by
  by_cases h : ∃ z₁, dist z₁ c₁ = 1 ∧ dist z₁ c₂ = 1
  · obtain ⟨z₁, h₁, h₂⟩ := h
    by_cases h' : ∃ z₂, dist z₂ c₁ = 1 ∧ dist z₂ c₂ = 1 ∧ z₂ ≠ z₁
    · obtain ⟨z₂, h₂₁, h₂₂, hne'⟩ := h'
      refine (Set.toFinite {z₁, z₂}).subset fun z hz => ?_
      rcases (link_circles_two hne h₁ h₂ h₂₁ h₂₂ hne'.symm).1 z hz.1 hz.2 with rfl | rfl <;> simp
    · push Not at h'
      exact (Set.finite_singleton z₁).subset fun z hz => h' z hz.1 hz.2
  · push Not at h
    exact Set.finite_empty.subset fun z hz => h z hz.1 hz.2


/-- The norm of `e α − t` squared. -/
theorem link_norm_e_sub_sq (α t : ℝ) : ‖e α - t‖ ^ 2 = 1 + t ^ 2 - 2 * t * Real.cos α := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, re_e, im_e, Complex.ofReal_re, Complex.ofReal_im, sub_zero]
  nlinarith [Real.sin_sq_add_cos_sq α]

/-- Along `φ = φ_c + θ_X cos θ` (`θ_X < π`), equal points `r_{u₁}(φ θ) = r_{u₁}(φ θ₀)` have equal `cos θ`. -/
theorem link_cos_eq_of_ringPt {u₁ : ℂ} {φ : ℝ → ℝ} {φc θX : ℝ} (hθX0 : 0 < θX) (hθXπ : θX < π)
    (hφ : ∀ θ, φ θ = φc + θX * Real.cos θ) {θ θ₀ : ℝ} (h : ringPt u₁ (φ θ) = ringPt u₁ (φ θ₀)) :
    Real.cos θ = Real.cos θ₀ := by
  have he : e (φ θ) = e (φ θ₀) := by simp only [ringPt] at h; exact add_left_cancel h
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
  have hn0 : n = 0 := CircleColouring.reduce_int_eq_zero (by
    rw [show (n : ℝ) * (2 * π) = φ θ - φ θ₀ by linarith, hφ, hφ,
      show φc + θX * Real.cos θ - (φc + θX * Real.cos θ₀) = θX * (Real.cos θ - Real.cos θ₀) by ring, abs_mul,
      abs_of_pos hθX0]
    have : |Real.cos θ - Real.cos θ₀| ≤ 2 := by
      rw [abs_le]; constructor <;> linarith [Real.neg_one_le_cos θ, Real.cos_le_one θ, Real.neg_one_le_cos θ₀,
        Real.cos_le_one θ₀]
    nlinarith)
  subst hn0
  rw [Int.cast_zero, zero_mul, add_zero, hφ, hφ] at hn
  exact mul_left_cancel₀ hθX0.ne' (add_left_cancel hn)

/-- **Finite fibres of the linkage's two angles**. -/
theorem link_fibres {u₁ u₂ : ℂ} {φ χ : ℝ → ℝ} {φc θX : ℝ} (hθX0 : 0 < θX) (hθXπ : θX < π)
    (hφ : ∀ θ, φ θ = φc + θX * Real.cos θ) (hd : ∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1)
    (hne : ∀ v, u₁ ≠ ringPt u₂ v) :
    (∀ a b v, {θ | θ ∈ Icc a b ∧ φ θ = v}.Finite) ∧ (∀ a b v, {θ | θ ∈ Icc a b ∧ χ θ = v}.Finite) := by
  have hφfib : ∀ a b v, {θ | θ ∈ Icc a b ∧ φ θ = v}.Finite := by
    intro a b v
    refine (link_cos_fibre ((v - φc) / θX) a b).subset fun θ ⟨hθ, hv⟩ => ⟨hθ, ?_⟩
    rw [hφ] at hv
    rw [eq_div_iff hθX0.ne']; linarith
  have hxfib : ∀ a b z, {θ | θ ∈ Icc a b ∧ ringPt u₁ (φ θ) = z}.Finite := by
    intro a b z
    by_cases h : ∃ θ₀, θ₀ ∈ Icc a b ∧ ringPt u₁ (φ θ₀) = z
    · obtain ⟨θ₀, -, hθ₀⟩ := h
      exact (link_cos_fibre (Real.cos θ₀) a b).subset fun θ ⟨hθ, hz⟩ =>
        ⟨hθ, link_cos_eq_of_ringPt hθX0 hθXπ hφ (hz.trans hθ₀.symm)⟩
    · push Not at h
      exact Set.finite_empty.subset fun θ hθ => h θ hθ.1 hθ.2
  refine ⟨hφfib, fun a b v => ?_⟩
  refine ((link_circles_finite (hne v)).biUnion fun z _ => hxfib a b z).subset fun θ ⟨hθ, hv⟩ => ?_
  refine mem_biUnion (x := ringPt u₁ (φ θ)) ⟨dist_ringPt _ _, ?_⟩ ⟨hθ, rfl⟩
  rw [← hv]; exact hd θ

/-- **A turn of the angle at an end of its range**. -/
theorem link_turn {χ : ℝ → ℝ} {χref θX : ℝ} (hfib : ∀ a b v, {θ | θ ∈ Icc a b ∧ χ θ = v}.Finite)
    (hrange : ∀ θ, |χ θ - χref| ≤ θX) {θ : ℝ} (hθ : |χ θ - χref| = θX) :
    (∀ᶠ θ' in 𝓝[≠] θ, χ θ' < χ θ) ∨ (∀ᶠ θ' in 𝓝[≠] θ, χ θ < χ θ') := by
  have hF : ({θ' | θ' ∈ Icc (θ - 1) (θ + 1) ∧ χ θ' = χ θ} \ {θ}).Finite := (hfib _ _ _).sdiff
  have hne : ∀ᶠ θ' in 𝓝[≠] θ, χ θ' ≠ χ θ := by
    filter_upwards [mem_nhdsWithin_of_mem_nhds (hF.isClosed.isOpen_compl.mem_nhds (fun h => h.2 (mem_singleton θ))),
      mem_nhdsWithin_of_mem_nhds (Icc_mem_nhds (show θ - 1 < θ by linarith) (show θ < θ + 1 by linarith)),
      self_mem_nhdsWithin] with θ' h1 h2 h3 h4
    exact h1 ⟨⟨h2, h4⟩, h3⟩
  have hθX : 0 ≤ θX := (abs_nonneg _).trans_eq hθ
  rcases (abs_eq hθX).mp hθ with h | h
  · left
    filter_upwards [hne] with θ' h'
    have := hrange θ'
    rw [abs_le] at this
    exact lt_of_le_of_ne (by linarith) h'
  · right
    filter_upwards [hne] with θ' h'
    have := hrange θ'
    rw [abs_le] at this
    exact lt_of_le_of_ne (by linarith) (Ne.symm h')

/-- **The angle is strictly monotone near a parameter where `|y − u₁| < 2`** (BASE-V § 1b.3 step 1: there the two partners of `y` on
`ω(u₁)` are apart, so near the parameter `x` is a function of `y`). -/
theorem link_flip {u₁ u₂ : ℂ} {φ χ : ℝ → ℝ} {φc θX : ℝ} (hθX0 : 0 < θX) (hθXπ : θX < π)
    (hφ : ∀ θ, φ θ = φc + θX * Real.cos θ) (hχc : Continuous χ)
    (hd : ∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1) (hne : ∀ v, u₁ ≠ ringPt u₂ v)
    {θ₀ : ℝ} (hθ₀ : θ₀ ∈ Ioo 0 π ∨ θ₀ ∈ Ioo (-π) 0) (h2 : dist (ringPt u₂ (χ θ₀)) u₁ < 2) :
    ∃ η > 0, StrictMonoOn χ (Icc (θ₀ - η) (θ₀ + η)) ∨ StrictAntiOn χ (Icc (θ₀ - η) (θ₀ + η)) := by
  have hπ := Real.pi_pos
  set d₀ := dist (ringPt u₂ (χ θ₀)) u₁ with hd₀
  set μ := 4 - ((d₀ + 2) / 2) ^ 2 with hμ
  have hd₀0 : 0 ≤ d₀ := dist_nonneg
  have hμ0 : 0 < μ := by rw [hμ]; nlinarith
  have hcont : Continuous fun θ => dist (ringPt u₂ (χ θ)) u₁ := by
    simp only [ringPt]; exact ((continuous_const.add (continuous_e.comp hχc)).dist continuous_const)
  obtain ⟨η₁, hη₁, hη₁c⟩ := Metric.continuous_iff.mp hcont θ₀ ((2 - d₀) / 2) (by linarith)
  have hθ₀' : 0 < |θ₀| ∧ |θ₀| < π := by
    rcases hθ₀ with h | h
    · rw [abs_of_pos h.1]; exact h
    · rw [abs_of_neg h.2]; constructor <;> linarith [h.1, h.2]
  set η := min (min (η₁ / 2) (|θ₀| / 2)) (min ((π - |θ₀|) / 2) (√μ / (4 * π))) with hη
  have hη0 : 0 < η := lt_min (lt_min (by linarith) (by linarith)) (lt_min (by linarith) (by positivity))
  have hηa : η ≤ η₁ / 2 := (min_le_left _ _).trans (min_le_left _ _)
  have hηb : η ≤ |θ₀| / 2 := (min_le_left _ _).trans (min_le_right _ _)
  have hηc : η ≤ (π - |θ₀|) / 2 := (min_le_right _ _).trans (min_le_left _ _)
  have hηd : η ≤ √μ / (4 * π) := (min_le_right _ _).trans (min_le_right _ _)
  refine ⟨η, hη0, (hχc.continuousOn).strictMonoOn_of_injOn_Icc' (by linarith) ?_⟩
  intro θ₁ hθ₁ θ₂ hθ₂ heq
  -- the two `y` agree; if the two `x` differed, they would be the two partners of `y`, at least `√μ` apart
  have hy : ringPt u₂ (χ θ₁) = ringPt u₂ (χ θ₂) := by rw [heq]
  have hnear : ∀ θ ∈ Icc (θ₀ - η) (θ₀ + η), dist (ringPt u₂ (χ θ)) u₁ < (d₀ + 2) / 2 := by
    intro θ hθ
    have := hη₁c θ (show dist θ θ₀ < η₁ by
      rw [Real.dist_eq, abs_lt]; constructor <;> linarith [hθ.1, hθ.2])
    rw [Real.dist_eq] at this
    have := (abs_lt.mp this).2
    linarith
  have hx : ringPt u₁ (φ θ₁) = ringPt u₁ (φ θ₂) := by
    by_contra hxne
    have hc := (link_circles_two (hne (χ θ₁)) (dist_ringPt _ _) (hd θ₁)
      (dist_ringPt _ _) (by rw [hy]; exact hd θ₂) hxne).2
    have hlt := hnear θ₁ hθ₁
    rw [← dist_eq_norm (ringPt u₂ (χ θ₁)) u₁] at hc
    have hge : μ ≤ ‖ringPt u₁ (φ θ₁) - ringPt u₁ (φ θ₂)‖ ^ 2 := by
      rw [hc, hμ]; nlinarith [dist_nonneg (x := ringPt u₂ (χ θ₁)) (y := u₁)]
    have hle : ‖ringPt u₁ (φ θ₁) - ringPt u₁ (φ θ₂)‖ ≤ θX * |θ₁ - θ₂| := by
      simp only [ringPt, add_sub_add_left_eq_sub]
      refine (norm_e_sub_e_le _ _).trans ?_
      rw [hφ, hφ, show φc + θX * Real.cos θ₁ - (φc + θX * Real.cos θ₂) = θX * (Real.cos θ₁ - Real.cos θ₂) by ring,
        abs_mul, abs_of_pos hθX0]
      exact mul_le_mul_of_nonneg_left (Real.abs_cos_sub_cos_le θ₁ θ₂) hθX0.le
    have h12 : |θ₁ - θ₂| ≤ 2 * η := by rw [abs_le]; constructor <;> linarith [hθ₁.1, hθ₁.2, hθ₂.1, hθ₂.2]
    have hsq : √μ ^ 2 = μ := Real.sq_sqrt hμ0.le
    have h4 : θX * |θ₁ - θ₂| ≤ π * (2 * (√μ / (4 * π))) :=
      mul_le_mul hθXπ.le (h12.trans (by linarith)) (abs_nonneg _) hπ.le
    have h5 : π * (2 * (√μ / (4 * π))) = √μ / 2 := by field_simp; ring
    have hn0 := norm_nonneg (ringPt u₁ (φ θ₁) - ringPt u₁ (φ θ₂))
    have := hle.trans (h4.trans h5.le)
    nlinarith [Real.sqrt_nonneg μ]
  have hcos := link_cos_eq_of_ringPt hθX0 hθXπ hφ hx
  rcases hθ₀ with h | h
  · rw [abs_of_pos h.1] at hηb hηc
    exact Real.injOn_cos ⟨by linarith [hθ₁.1], by linarith [hθ₁.2]⟩ ⟨by linarith [hθ₂.1], by linarith [hθ₂.2]⟩ hcos
  · rw [abs_of_neg h.2] at hηb hηc
    have := Real.injOn_cos (x₁ := -θ₁) (x₂ := -θ₂) ⟨by linarith [hθ₁.2], by linarith [hθ₁.1]⟩
      ⟨by linarith [hθ₂.2], by linarith [hθ₂.1]⟩ (by rw [Real.cos_neg, Real.cos_neg]; exact hcos)
    linarith

/-- The distance between two ring points, from the cosine of their angle difference. -/
theorem link_dist_ringPt_sq (p : ℂ) (a b : ℝ) : dist (ringPt p a) (ringPt p b) ^ 2 = 2 - 2 * Real.cos (a - b) := by
  rw [dist_eq_norm]; simp only [ringPt, add_sub_add_left_eq_sub]; exact norm_e_sub_e_sq a b

/-- **The two partners of an intersection point**: two distinct points of `ω(u₂)` at distance `1` from `P = r_{u₂}(χ_P)` are
`r_{u₂}(χ_P ± 60°)`. -/
theorem link_partners {u₂ P y₁ y₂ : ℂ} {χP : ℝ} (hPχ : P = ringPt u₂ χP)
    (h₁ : dist y₁ u₂ = 1) (h₁' : dist y₁ P = 1) (h₂ : dist y₂ u₂ = 1) (h₂' : dist y₂ P = 1) (hne : y₁ ≠ y₂) :
    (y₁ = ringPt u₂ (χP + π / 3) ∧ y₂ = ringPt u₂ (χP - π / 3)) ∨
      (y₁ = ringPt u₂ (χP - π / 3) ∧ y₂ = ringPt u₂ (χP + π / 3)) := by
  have hu : u₂ ≠ P := fun h => by have := dist_ringPt u₂ χP; rw [← hPχ, ← h, dist_self] at this; norm_num at this
  have hdp : ∀ c : ℝ, Real.cos (c - χP) = 1 / 2 → dist (ringPt u₂ c) P = 1 := by
    intro c hc
    have := link_dist_ringPt_sq u₂ c χP
    rw [hc, ← hPχ] at this
    nlinarith [dist_nonneg (x := ringPt u₂ c) (y := P)]
  have hp : dist (ringPt u₂ (χP + π / 3)) P = 1 :=
    hdp _ (by rw [show χP + π / 3 - χP = π / 3 by ring, Real.cos_pi_div_three])
  have hm : dist (ringPt u₂ (χP - π / 3)) P = 1 :=
    hdp _ (by rw [show χP - π / 3 - χP = -(π / 3) by ring, Real.cos_neg, Real.cos_pi_div_three])
  have hpm : ringPt u₂ (χP + π / 3) ≠ ringPt u₂ (χP - π / 3) := by
    intro h
    have := link_dist_ringPt_sq u₂ (χP + π / 3) (χP - π / 3)
    rw [h, dist_self, show χP + π / 3 - (χP - π / 3) = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three] at this
    norm_num at this
  have htwo := (link_circles_two hu (dist_ringPt _ _) hp (dist_ringPt _ _) hm hpm).1
  rcases htwo y₁ h₁ h₁' with e1 | e1 <;> rcases htwo y₂ h₂ h₂' with e2 | e2
  · exact absurd (e1.trans e2.symm) hne
  · exact Or.inl ⟨e1, e2⟩
  · exact Or.inr ⟨e1, e2⟩
  · exact absurd (e1.trans e2.symm) hne

/-- At most one of two distinct unit-partners of `P ∈ ω(u₁)` is at distance `2` from `u₁` (equality in the triangle inequality puts it at
`2P − u₁`). -/
theorem link_one_lt_two {u₁ P y₁ y₂ : ℂ} (hP : dist P u₁ = 1) (h₁ : dist y₁ P = 1) (h₂ : dist y₂ P = 1) (hne : y₁ ≠ y₂) :
    dist y₁ u₁ < 2 ∨ dist y₂ u₁ < 2 := by
  have hle : ∀ y, dist y P = 1 → dist y u₁ ≤ 2 := fun y hy => by linarith [dist_triangle y P u₁]
  have key : ∀ y, dist y P = 1 → dist y u₁ = 2 → y = 2 * P - u₁ := by
    intro y hy h2
    have a := dist_sq_re_im y P; have b := dist_sq_re_im P u₁; have c := dist_sq_re_im y u₁
    rw [hy] at a; rw [hP] at b; rw [h2] at c
    set A := y.re - P.re - (P.re - u₁.re) with hA
    set B := y.im - P.im - (P.im - u₁.im) with hB
    have h1 : A ^ 2 + B ^ 2 = 0 := by rw [hA, hB]; nlinarith
    have hre : A = 0 := by nlinarith [sq_nonneg A, sq_nonneg B]
    have him : B = 0 := by nlinarith [sq_nonneg A, sq_nonneg B]
    apply Complex.ext <;> simp <;> linarith
  by_contra h
  push Not at h
  exact hne ((key y₁ h₁ (le_antisymm (hle y₁ h₁) h.1)).trans (key y₂ h₂ (le_antisymm (hle y₂ h₂) h.2)).symm)


-- The construction is one declaration of explicit trigonometry; measured: it passes at 300000 heartbeats and fails at the
-- default 200000 (FS131-I5g, stage 28).
set_option maxHeartbeats 400000 in
/-- **The unit-distance linkage of two unit circles** whose centres are between `1` and `2` apart (BASE-V § 1b.3 step 1), parametrized
as one loop: `x = r_{u₁}(φ θ)`, `y = r_{u₂}(χ θ)`, `|x − y| = 1`, with `φ θ = φ_c + θ_X cos θ` sweeping the arc of `ω(u₁)` within `2` of `u₂`
and `χ` a continuous angle of `y`. At `θ = ±θ_A` the point `x` is an intersection point `P` of the two circles, and `y` its two partners
`r_{u₂}(χ_P ± 60°)`; between them `x` stays on one side of `P`. Fibres are finite; `χ` turns where `|y − u₁| = 2` and is strictly monotone
near `±θ_A` where `|y − u₁| < 2`, which holds at one of them at least. -/
theorem exists_linkage {u₁ u₂ : ℂ} (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2) :
    ∃ (φ χ : ℝ → ℝ) (θA φP χP : ℝ),
      Continuous φ ∧ Continuous χ ∧ (∀ θ, φ (θ + 2 * π) = φ θ) ∧ (∀ θ, χ (θ + 2 * π) = χ θ) ∧
      (∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1) ∧
      (∀ a b v, {θ | θ ∈ Icc a b ∧ φ θ = v}.Finite) ∧ (∀ a b v, {θ | θ ∈ Icc a b ∧ χ θ = v}.Finite) ∧
      (∀ θ, dist (ringPt u₂ (χ θ)) u₁ = 2 → (∀ᶠ θ' in 𝓝[≠] θ, χ θ' < χ θ) ∨ (∀ᶠ θ' in 𝓝[≠] θ, χ θ < χ θ')) ∧
      0 < θA ∧ θA < π ∧ φ θA = φP ∧ φ (-θA) = φP ∧
      (∀ θ ∈ Ioo (-θA) θA, φP < φ θ) ∧ (∀ θ ∈ Ioo θA (2 * π - θA), φ θ < φP) ∧
      ((χ θA = χP + π / 3 ∧ χ (-θA) = χP - π / 3) ∨ (χ θA = χP - π / 3 ∧ χ (-θA) = χP + π / 3)) ∧
      (∀ θ₀, (θ₀ = θA ∨ θ₀ = -θA) → dist (ringPt u₂ (χ θ₀)) u₁ < 2 →
        ∃ η > 0, StrictMonoOn χ (Icc (θ₀ - η) (θ₀ + η)) ∨ StrictAntiOn χ (Icc (θ₀ - η) (θ₀ + η))) ∧
      (dist (ringPt u₂ (χ θA)) u₁ < 2 ∨ dist (ringPt u₂ (χ (-θA))) u₁ < 2) := by
  classical
  have hπ := Real.pi_pos
  set t := dist u₁ u₂ with ht_def
  set w := u₂ - u₁ with hw
  have hwt : ‖w‖ = t := by rw [hw, ← dist_eq_norm, dist_comm]
  set φc := arg w with hφc
  have hwe : w = (t : ℂ) * e φc := by rw [← hwt]; exact eq_polar_arg w
  have ht0 : 0 < t := by linarith
  set c₀ := (t ^ 2 - 3) / (2 * t) with hc₀
  have hc₀1 : -1 < c₀ := by rw [hc₀, lt_div_iff₀ (by positivity)]; nlinarith
  have hc₀2 : c₀ < t / 2 := by rw [hc₀, div_lt_iff₀ (by positivity)]; nlinarith
  have ht2 : t / 2 < 1 := by linarith
  have ht2' : 1 / 2 < t / 2 := by linarith
  set θX := arccos c₀ with hθX
  have hθX0 : 0 < θX := Real.arccos_pos.mpr (by linarith)
  have hθXπ : θX < π := Real.arccos_lt_pi.mpr hc₀1
  have hcosθX : Real.cos θX = c₀ := Real.cos_arccos hc₀1.le (by linarith)
  -- the parametrization
  set φ : ℝ → ℝ := fun θ => φc + θX * Real.cos θ with hφ
  set Dsq : ℝ → ℝ := fun θ => 1 + t ^ 2 - 2 * t * Real.cos (θX * Real.cos θ) with hDsq
  have hxu : ∀ θ, ringPt u₁ (φ θ) - u₂ = e φc * (e (θX * Real.cos θ) - t) := by
    intro θ; simp only [ringPt, hφ, e_add]
    rw [show u₁ + e φc * e (θX * Real.cos θ) - u₂ = e φc * e (θX * Real.cos θ) - w by rw [hw]; ring, hwe]; ring
  have hD : ∀ θ, ‖ringPt u₁ (φ θ) - u₂‖ ^ 2 = Dsq θ := by
    intro θ; rw [hxu, norm_mul, norm_e, one_mul, link_norm_e_sub_sq]
  have hcosge : ∀ θ, c₀ ≤ Real.cos (θX * Real.cos θ) := by
    intro θ
    have h1 : |θX * Real.cos θ| ≤ θX := by
      rw [abs_mul, abs_of_pos hθX0]; nlinarith [Real.abs_cos_le_one θ]
    rw [← Real.cos_abs, ← hcosθX]
    exact Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) hθXπ.le h1
  have hDle : ∀ θ, Dsq θ ≤ 4 := by
    intro θ; simp only [hDsq]
    have := hcosge θ
    have h2 : 2 * t * c₀ = t ^ 2 - 3 := by rw [hc₀]; field_simp
    nlinarith
  have hDpos : ∀ θ, (t - 1) ^ 2 ≤ Dsq θ := by
    intro θ; simp only [hDsq]; nlinarith [Real.cos_le_one (θX * Real.cos θ)]
  have hDpos' : ∀ θ, 0 < Dsq θ := fun θ => lt_of_lt_of_le (by nlinarith) (hDpos θ)
  have hD4 : ∀ θ, Real.sin θ = 0 → Dsq θ = 4 := by
    intro θ hs
    have hc : Real.cos θ = 1 ∨ Real.cos θ = -1 := by
      have := Real.sin_sq_add_cos_sq θ; rw [hs] at this
      have : (Real.cos θ - 1) * (Real.cos θ + 1) = 0 := by nlinarith
      rcases mul_eq_zero.mp this with h | h
      · left; linarith
      · right; linarith
    simp only [hDsq]
    have h2 : 2 * t * c₀ = t ^ 2 - 3 := by rw [hc₀]; field_simp
    rcases hc with hc | hc <;> rw [hc] <;> simp only [mul_one, mul_neg, Real.cos_neg] <;> rw [hcosθX] <;> linarith
  set σ : ℝ → ℝ := fun θ => Real.sin θ / |Real.sin θ| with hσ
  set k : ℝ → ℝ := fun θ => σ θ * √(1 / Dsq θ - 1 / 4) with hk
  have hk2 : ∀ θ, k θ ^ 2 = 1 / Dsq θ - 1 / 4 := by
    intro θ
    have hnn : 0 ≤ 1 / Dsq θ - 1 / 4 := by
      have := hDle θ; have := hDpos' θ
      rw [sub_nonneg, div_le_div_iff₀ (by norm_num) (hDpos' θ)]; linarith
    by_cases hs : Real.sin θ = 0
    · have := hD4 θ hs
      simp only [hk, hσ, hs, abs_zero, div_zero, zero_mul, this]; norm_num
    · simp only [hk, hσ]
      rw [mul_pow, Real.sq_sqrt hnn, div_pow, sq_abs, div_self (pow_ne_zero 2 hs), one_mul]
  set y : ℝ → ℂ := fun θ => u₂ + (ringPt u₁ (φ θ) - u₂) * (1 / 2 + (k θ : ℂ) * I) with hy
  have hfac : ∀ θ, ‖(1 / 2 : ℂ) + (k θ : ℂ) * I‖ ^ 2 = 1 / Dsq θ := by
    intro θ
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
      Complex.I_re, Complex.I_im]
    norm_num
    rw [← sq, hk2]; ring
  have hfac' : ∀ θ, ‖(-1 / 2 : ℂ) + (k θ : ℂ) * I‖ ^ 2 = 1 / Dsq θ := by
    intro θ
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
      Complex.I_re, Complex.I_im]
    norm_num
    rw [← sq, hk2]; ring
  have hy2 : ∀ θ, dist (y θ) u₂ = 1 := by
    intro θ
    have : ‖y θ - u₂‖ ^ 2 = 1 := by
      simp only [hy, add_sub_cancel_left]
      rw [norm_mul, mul_pow, hD, hfac]; field_simp [(hDpos' θ).ne']
    rw [dist_eq_norm]; nlinarith [norm_nonneg (y θ - u₂)]
  have hyx : ∀ θ, dist (ringPt u₁ (φ θ)) (y θ) = 1 := by
    intro θ
    have : ‖y θ - ringPt u₁ (φ θ)‖ ^ 2 = 1 := by
      have : y θ - ringPt u₁ (φ θ) = (ringPt u₁ (φ θ) - u₂) * (-1 / 2 + (k θ : ℂ) * I) := by simp only [hy]; ring
      rw [this, norm_mul, mul_pow, hD, hfac']; field_simp [(hDpos' θ).ne']
    rw [dist_comm, dist_eq_norm]; nlinarith [norm_nonneg (y θ - ringPt u₁ (φ θ))]
  -- the angle of `y` at `u₂`, measured from the direction toward `u₁`
  set χref := φc + π with hχref
  have heref : e χref = -e φc := by rw [hχref, e_add_pi]
  set A : ℂ → ℝ := fun z => χref + arg ((z - u₂) * (starRingEnd ℂ) (e χref)) with hA
  have hq1 : ∀ z, dist z u₂ = 1 → ‖(z - u₂) * (starRingEnd ℂ) (e χref)‖ = 1 := by
    intro z hz; rw [norm_mul, Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm, hz]
  have hAe : ∀ z, dist z u₂ = 1 → ringPt u₂ (A z) = z := by
    intro z hz
    have hpol := eq_polar_arg ((z - u₂) * (starRingEnd ℂ) (e χref))
    rw [hq1 z hz, Complex.ofReal_one, one_mul] at hpol
    simp only [ringPt, hA, e_add]
    rw [← hpol, mul_comm (z - u₂), ← mul_assoc, e_mul_conj_e, one_mul]; ring
  have hy1u : ∀ θ, dist (y θ) u₁ ≤ 2 := by
    intro θ
    calc dist (y θ) u₁ ≤ dist (y θ) (ringPt u₁ (φ θ)) + dist (ringPt u₁ (φ θ)) u₁ := dist_triangle _ _ _
      _ = 2 := by rw [dist_comm, hyx, dist_ringPt]; norm_num
  have hslit : ∀ θ, (y θ - u₂) * (starRingEnd ℂ) (e χref) ∈ slitPlane := by
    intro θ
    by_contra hns
    rw [mem_slitPlane_iff] at hns
    push Not at hns
    set q := (y θ - u₂) * (starRingEnd ℂ) (e χref) with hqdef
    have hqn := hq1 (y θ) (hy2 θ)
    rw [← hqdef] at hqn
    have hq : q = -1 := by
      have h2 : q.re ^ 2 + q.im ^ 2 = 1 := by
        have := Complex.sq_norm q; rw [hqn, Complex.normSq_apply] at this; nlinarith
      rw [hns.2] at h2
      apply Complex.ext
      · simp only [Complex.neg_re, Complex.one_re]; nlinarith [hns.1]
      · simp only [Complex.neg_im, Complex.one_im, neg_zero]; exact hns.2
    have hyq : y θ - u₂ = q * e χref := by
      rw [hqdef, mul_assoc, mul_comm ((starRingEnd ℂ) (e χref)), e_mul_conj_e, mul_one]
    rw [hq, heref] at hyq
    have : dist (y θ) u₁ = t + 1 := by
      rw [dist_eq_norm, show y θ - u₁ = (y θ - u₂) + w by rw [hw]; ring, hyq, hwe]
      rw [show -1 * -e φc + (t : ℂ) * e φc = ((t + 1 : ℝ) : ℂ) * e φc by push_cast; ring, norm_mul, norm_e, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
    linarith [hy1u θ]
  set χ : ℝ → ℝ := fun θ => A (y θ) with hχ
  have hχe : ∀ θ, ringPt u₂ (χ θ) = y θ := fun θ => hAe _ (hy2 θ)
  -- continuity
  have hφcont : Continuous φ := by simp only [hφ]; fun_prop
  have hDcont : Continuous Dsq := by simp only [hDsq]; fun_prop
  set g : ℝ → ℝ := fun θ => √(1 / Dsq θ - 1 / 4) with hg
  have hgcont : Continuous g := by
    simp only [hg]
    exact ((continuous_const.div hDcont fun θ => (hDpos' θ).ne').sub continuous_const).sqrt
  have hσle : ∀ θ, |σ θ| ≤ 1 := by
    intro θ; simp only [hσ]
    rw [abs_div, abs_abs]
    by_cases h : Real.sin θ = 0
    · simp [h]
    · rw [div_self (abs_ne_zero.mpr h)]
  have hkcont : Continuous k := by
    rw [continuous_iff_continuousAt]
    intro θ
    by_cases hs : Real.sin θ = 0
    · have hk0 : k θ = 0 := by simp only [hk, hσ, hs, abs_zero, div_zero, zero_mul]
      have hg0 : g θ = 0 := by simp only [hg, hD4 θ hs]; norm_num
      rw [ContinuousAt, hk0]
      refine squeeze_zero_norm' (Filter.Eventually.of_forall fun θ' => ?_) (hg0 ▸ hgcont.tendsto θ)
      simp only [hk, Real.norm_eq_abs, abs_mul]
      rw [abs_of_nonneg (Real.sqrt_nonneg _)]
      exact mul_le_of_le_one_left (Real.sqrt_nonneg _) (hσle θ')
    · have hσc : ContinuousAt σ θ := by
        simp only [hσ]
        exact (Real.continuous_sin.continuousAt).div (Real.continuous_sin.abs.continuousAt) (abs_ne_zero.mpr hs)
      exact hσc.mul (hgcont.continuousAt)
  have hycont : Continuous y := by
    simp only [hy, ringPt]
    exact continuous_const.add (((continuous_const.add (continuous_e.comp hφcont)).sub continuous_const).mul
      (continuous_const.add ((Complex.continuous_ofReal.comp hkcont).mul continuous_const)))
  have hχcont : Continuous χ := by
    rw [continuous_iff_continuousAt]
    intro θ
    simp only [hχ, hA]
    have hc : Continuous (fun θ => (y θ - u₂) * (starRingEnd ℂ) (e χref)) := (hycont.sub continuous_const).mul continuous_const
    exact continuousAt_const.add ((continuousAt_arg (hslit θ)).comp (f := fun θ => (y θ - u₂) * (starRingEnd ℂ) (e χref))
      hc.continuousAt)
  -- periodicity
  have hφper : ∀ θ, φ (θ + 2 * π) = φ θ := fun θ => by simp only [hφ, Real.cos_add_two_pi]
  have hkper : ∀ θ, k (θ + 2 * π) = k θ := fun θ => by simp only [hk, hσ, hDsq, Real.sin_add_two_pi, Real.cos_add_two_pi]
  have hyper : ∀ θ, y (θ + 2 * π) = y θ := fun θ => by simp only [hy, hφper, hkper]
  have hχper : ∀ θ, χ (θ + 2 * π) = χ θ := fun θ => by simp only [hχ, hyper]
  have hδ : ∀ θ, χ θ - χref ∈ Ioc (-π) π := fun θ => by
    simp only [hχ, hA, add_sub_cancel_left]; exact ⟨neg_pi_lt_arg _, arg_le_pi _⟩
  have hdsq : ∀ θ, dist (y θ) u₁ ^ 2 = 1 + t ^ 2 - 2 * t * Real.cos (χ θ - χref) := by
    intro θ
    rw [dist_eq_norm, show y θ - u₁ = (ringPt u₂ (χ θ) - u₂) + w by rw [hχe, hw]; ring, hwe]
    simp only [ringPt, add_sub_cancel_left]
    rw [show e (χ θ) + (t : ℂ) * e φc = e χref * (e (χ θ - χref) - t) by
      rw [mul_sub, ← e_add, show χref + (χ θ - χref) = χ θ by ring, heref]; ring, norm_mul, norm_e, one_mul, link_norm_e_sub_sq]
  have harc : ∀ c, c - χref ∈ Ioc (-π) π → A (ringPt u₂ c) = c := by
    intro c hc
    simp only [hA, ringPt, add_sub_cancel_left]
    rw [conj_e, ← e_add, show c + -χref = c - χref by ring, e_eq, Complex.ofReal_cos, Complex.ofReal_sin,
      Complex.arg_cos_add_sin_mul_I hc]
    ring
  have hφ' : ∀ θ, φ θ = φc + θX * Real.cos θ := fun θ => by rw [hφ]
  have hkodd : ∀ θ, k (-θ) = -k θ := fun θ => by
    simp only [hk, hσ, hDsq, Real.sin_neg, abs_neg, Real.cos_neg, neg_div, neg_mul]
  have hyform : ∀ θ, y θ = u₂ + (ringPt u₁ (φ θ) - u₂) * (1 / 2 + (k θ : ℂ) * I) := fun θ => by rw [hy]
  have hχform : ∀ θ, χ θ = A (y θ) := fun θ => by rw [hχ]
  have hkpos : ∀ θ, 0 < Real.sin θ → Dsq θ < 4 → 0 < k θ := by
    intro θ hs hD
    simp only [hk, hσ, abs_of_pos hs, div_self hs.ne', one_mul]
    apply Real.sqrt_pos.mpr
    rw [sub_pos, div_lt_div_iff₀ (by norm_num) (hDpos' θ)]; linarith
  have hDform : ∀ θ, Dsq θ = 1 + t ^ 2 - 2 * t * Real.cos (θX * Real.cos θ) := fun θ => by rw [hDsq]
  clear_value χ A y k σ g Dsq φ θX c₀ χref φc w t
  have hdist : ∀ θ, dist (ringPt u₁ (φ θ)) (ringPt u₂ (χ θ)) = 1 := fun θ => by rw [hχe]; exact hyx θ
  have hne : ∀ v, u₁ ≠ ringPt u₂ v := fun v h => by
    have := dist_ringPt u₂ v; rw [← h] at this; linarith
  obtain ⟨hφfib, hχfib⟩ := link_fibres hθX0 hθXπ hφ' hdist hne
  have h2c : 2 * t * c₀ = t ^ 2 - 3 := by rw [hc₀]; field_simp
  have hcos_of : ∀ θ, c₀ ≤ Real.cos (χ θ - χref) := by
    intro θ
    have h1 := hdsq θ
    have h2 := hy1u θ
    have h3 : dist (y θ) u₁ ^ 2 ≤ 4 := by nlinarith [dist_nonneg (x := y θ) (y := u₁)]
    have h4 : 2 * t * c₀ ≤ 2 * t * Real.cos (χ θ - χref) := by linarith
    exact le_of_mul_le_mul_left h4 (by positivity)
  have hrange : ∀ θ, |χ θ - χref| ≤ θX := by
    intro θ
    have hab : |χ θ - χref| ≤ π := abs_le.mpr ⟨(hδ θ).1.le, (hδ θ).2⟩
    rw [← Real.arccos_cos (abs_nonneg _) hab, Real.cos_abs, hθX]
    exact Real.strictAntiOn_arccos.antitoneOn ⟨hc₀1.le, by linarith⟩
      ⟨Real.neg_one_le_cos _, Real.cos_le_one _⟩ (hcos_of θ)
  have hturn : ∀ θ, dist (ringPt u₂ (χ θ)) u₁ = 2 →
      (∀ᶠ θ' in 𝓝[≠] θ, χ θ' < χ θ) ∨ (∀ᶠ θ' in 𝓝[≠] θ, χ θ < χ θ') := by
    intro θ h2
    rw [hχe] at h2
    refine link_turn hχfib hrange ?_
    have hc : Real.cos (χ θ - χref) = c₀ := by
      have h := hdsq θ; rw [h2] at h
      have h' : 2 * t * Real.cos (χ θ - χref) = 2 * t * c₀ := by linarith
      exact mul_left_cancel₀ (mul_ne_zero two_ne_zero ht0.ne') h'
    have e1 : arccos (Real.cos |χ θ - χref|) = |χ θ - χref| := Real.arccos_cos (abs_nonneg _) ((hrange θ).trans hθXπ.le)
    rw [Real.cos_abs, hc, ← hθX] at e1
    exact e1.symm
  -- the intersection point `P`, the parameters `±θ_A`
  have hγ0 : 0 < arccos (t / 2) := Real.arccos_pos.mpr ht2
  have hγX : arccos (t / 2) < θX := by
    rw [hθX]; exact Real.strictAntiOn_arccos ⟨hc₀1.le, by linarith⟩ ⟨by linarith, ht2.le⟩ hc₀2
  have hγπ3 : arccos (t / 2) < π / 3 := by
    have h := Real.strictAntiOn_arccos (show (1 / 2 : ℝ) ∈ Icc (-1) 1 by constructor <;> norm_num)
      (show t / 2 ∈ Icc (-1) 1 by constructor <;> linarith) ht2'
    rwa [← Real.cos_pi_div_three, Real.arccos_cos (by positivity) (by linarith)] at h
  have hcosγ : Real.cos (arccos (t / 2)) = t / 2 := Real.cos_arccos (by linarith) ht2.le
  set γ := arccos (t / 2) with hγ
  have hγθ0 : 0 < γ / θX := div_pos hγ0 hθX0
  have hγθ1 : γ / θX < 1 := (div_lt_one hθX0).mpr hγX
  set θA := arccos (γ / θX) with hθA
  have hθA0 : 0 < θA := Real.arccos_pos.mpr hγθ1
  have hθAπ2 : θA < π / 2 := Real.arccos_lt_pi_div_two.mpr hγθ0
  have hcosθA : Real.cos θA = γ / θX := Real.cos_arccos (by linarith) hγθ1.le
  have hγA : γ = θX * Real.cos θA := by rw [hcosθA]; field_simp
  have hφA : φ θA = φc + γ := by rw [hφ', hγA]
  have hφA' : φ (-θA) = φc + γ := by rw [hφ', Real.cos_neg, hγA]
  clear_value θA γ
  have hin1 : ∀ θ ∈ Ioo (-θA) θA, φc + γ < φ θ := by
    intro θ hθ
    have h1 : |θ| < θA := abs_lt.mpr hθ
    have h2 : Real.cos θA < Real.cos θ := by
      rw [← Real.cos_abs θ]; exact Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg θ) (by linarith) h1
    rw [hφ', hγA]; linarith [mul_lt_mul_of_pos_left h2 hθX0]
  have hin2 : ∀ θ ∈ Ioo θA (2 * π - θA), φ θ < φc + γ := by
    intro θ hθ
    have h2 : Real.cos θ < Real.cos θA := by
      rcases le_or_gt θ π with h | h
      · exact Real.cos_lt_cos_of_nonneg_of_le_pi hθA0.le h hθ.1
      · rw [← Real.cos_two_pi_sub θ]
        exact Real.cos_lt_cos_of_nonneg_of_le_pi hθA0.le (by linarith) (by linarith [hθ.2])
    rw [hφ', hγA]; linarith [mul_lt_mul_of_pos_left h2 hθX0]
  set P := ringPt u₁ (φc + γ) with hP
  have hPχ : P = ringPt u₂ (χref - γ) := by
    simp only [hP, ringPt]
    have hsγ : Real.sin γ ^ 2 = 1 - (t / 2) ^ 2 := by rw [← hcosγ]; linarith [Real.sin_sq_add_cos_sq γ]
    have hq : e γ - t = e (π - γ) := by
      apply Complex.ext
      · simp only [Complex.sub_re, re_e, Complex.ofReal_re, Real.cos_pi_sub, hcosγ]; ring
      · simp only [Complex.sub_im, im_e, Complex.ofReal_im, Real.sin_pi_sub, sub_zero]
    rw [show u₁ + e (φc + γ) = u₂ + (e φc * (e γ - t)) by rw [e_add, show u₂ = u₁ + w by rw [hw]; ring, hwe]; ring, hq,
      ← e_add, hχref]
    ring_nf
  have hxA : ringPt u₁ (φ θA) = P := by rw [hφA]
  have hxA' : ringPt u₁ (φ (-θA)) = P := by rw [hφA']
  have hyA : dist (y θA) P = 1 := by rw [← hxA, dist_comm]; exact hyx θA
  have hyA' : dist (y (-θA)) P = 1 := by rw [← hxA', dist_comm]; exact hyx (-θA)
  have hPu : P - u₂ ≠ 0 := by
    intro h; have := dist_ringPt u₂ (χref - γ); rw [← hPχ, dist_eq_norm, h, norm_zero] at this; norm_num at this
  have hyne : y θA ≠ y (-θA) := by
    intro h
    rw [hyform, hyform, hxA, hxA', hkodd] at h
    have hk0 : 0 < k θA := hkpos θA (Real.sin_pos_of_pos_of_lt_pi hθA0 (by linarith)) (by
      rw [hDform, ← hγA, hcosγ]; nlinarith)
    have : (P - u₂) * ((2 * k θA : ℝ) * I) = 0 := by
      have h' := congrArg (fun z => z - u₂) h; simp only [add_sub_cancel_left] at h'
      push_cast at h' ⊢; linear_combination h'
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hPu h1
    · have := congrArg Complex.im h1
      simp at this; linarith
  have hchiA : (χ θA = χref - γ + π / 3 ∧ χ (-θA) = χref - γ - π / 3) ∨
      (χ θA = χref - γ - π / 3 ∧ χ (-θA) = χref - γ + π / 3) := by
    have hp : χref - γ + π / 3 - χref ∈ Ioc (-π) π := ⟨by linarith, by linarith⟩
    have hm : χref - γ - π / 3 - χref ∈ Ioc (-π) π := ⟨by linarith, by linarith⟩
    rcases link_partners hPχ (hy2 θA) hyA (hy2 (-θA)) hyA' hyne with ⟨e1, e2⟩ | ⟨e1, e2⟩
    · left; rw [hχform, hχform, e1, e2, harc _ hp, harc _ hm]; exact ⟨rfl, rfl⟩
    · right; rw [hχform, hχform, e1, e2, harc _ hp, harc _ hm]; exact ⟨rfl, rfl⟩
  have hflip : ∀ θ₀, (θ₀ = θA ∨ θ₀ = -θA) → dist (ringPt u₂ (χ θ₀)) u₁ < 2 →
      ∃ η > 0, StrictMonoOn χ (Icc (θ₀ - η) (θ₀ + η)) ∨ StrictAntiOn χ (Icc (θ₀ - η) (θ₀ + η)) := by
    rintro θ₀ (rfl | rfl) h2
    · exact link_flip hθX0 hθXπ hφ' hχcont hdist hne (Or.inl ⟨hθA0, by linarith⟩) h2
    · exact link_flip hθX0 hθXπ hφ' hχcont hdist hne (Or.inr ⟨by linarith, by linarith⟩) h2
  have hone : dist (ringPt u₂ (χ θA)) u₁ < 2 ∨ dist (ringPt u₂ (χ (-θA))) u₁ < 2 := by
    rw [hχe, hχe]; exact link_one_lt_two (dist_ringPt _ _) hyA hyA' hyne
  exact ⟨φ, χ, θA, φc + γ, χref - γ, hφcont, hχcont, hφper, hχper, hdist, hφfib, hχfib, hturn, hθA0, by linarith,
    hφA, hφA', hin1, hin2, hchiA, hflip, hone⟩

/-- **Lemma 3 in pseudo-colour form** (`[SokolovVoronov2025]` Lemma 3; BASE-V's BV-L3 route — the unit-distance linkage and the band lemma —
on the two pseudo-colourings): two cubic trichromatic points of `B̄(u, 1)` with one multicolour are not at distance in `(1, 2)`. Their circles may
carry in- and out-contact unit arcs (plan § 2.2), so `bv_l3`'s `RingProper` is not available; the inputs are `exists_pseudoCircle` at both,
(i) across the circles from `pair_i`, and the double switch of both colours excluded by `pair_ii` (two switching points carry one pair, which
needs no sense of motion), read along the linkage `exists_linkage` by the band lemma `link_path`. No velocity argument is used, so neither
`linkage_dot_ne_zero` nor `bv_nd` is an input. -/
theorem BaseCtx.l3_base (B : F.BaseCtx u) {u₁ u₂ : ℂ} (h₁ : u₁ ∈ closedBall u 1) (h₂ : u₂ ∈ closedBall u 1)
    (c₁ : F.IsCubicTrichromatic u₁) (c₂ : F.IsCubicTrichromatic u₂) (hsame : F.coloursAt u₁ = F.coloursAt u₂)
    (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2) : False := by
  classical
  have hπ := Real.pi_pos
  have hF := B.valid
  have hcov : ∀ {q : ℂ}, q ∈ closedBall u 1 → F.Covers q 1 := fun {q} hq z hz =>
    B.covers (show z ∈ closedBall u 2 by rw [mem_closedBall] at hq hz ⊢; linarith [dist_triangle z q u])
  have hring2 : ∀ {q : ℂ}, q ∈ closedBall u 1 → ∀ z, dist z q = 1 → z ∈ closedBall u 2 := fun {q} hq z hz => by
    rw [mem_closedBall] at hq ⊢; linarith [dist_triangle z q u]
  -- the two pseudo-colourings, read through one labelling `g₁`
  obtain ⟨C₁, g₁, hg₁, hg₁u, hL₁, hR₁, -, hns₁⟩ := B.exists_pseudoCircle h₁ c₁
  obtain ⟨C₂, g₂, hg₂, hg₂u, hL₂, hR₂, -, hns₂⟩ := B.exists_pseudoCircle h₂ c₂
  have hsurj : ∀ j : Fin 6, j ∉ F.coloursAt u₁ → ∃ v, g₁ v = j := by
    intro j hj
    by_contra hno
    push Not at hno
    have hsub : ((Finset.univ.image g₁ ∪ {j} : Finset (Fin 6)) : Set (Fin 6)) ⊆ (F.coloursAt u₁)ᶜ := by
      intro i hi
      simp only [Finset.coe_union, Finset.coe_image, Finset.coe_univ, image_univ, Finset.coe_singleton, mem_union,
        mem_range, mem_singleton_iff] at hi
      rcases hi with ⟨v, rfl⟩ | rfl
      · exact hg₁u v
      · exact hj
    have hdisj : Disjoint (Finset.univ.image g₁) {j} := by
      rw [Finset.disjoint_singleton_right]; simp only [Finset.mem_image, Finset.mem_univ, true_and, not_exists]
      exact hno
    have hcard : (Finset.univ.image g₁ ∪ {j}).card = 4 := by
      rw [Finset.card_union_of_disjoint hdisj, Finset.card_image_of_injective _ hg₁]; simp
    have h3 : (F.coloursAt u₁)ᶜ.ncard = 3 := by
      rw [Set.ncard_compl, Nat.card_eq_fintype_card, Fintype.card_fin, c₁.2]
    have := Set.ncard_le_ncard hsub
    rw [Set.ncard_coe_finset, hcard, h3] at this
    omega
  choose ρ hρ using fun w => hsurj (g₂ w) (hsame ▸ hg₂u w)
  have hρi : Function.Injective ρ := fun a b h => hg₂ (by rw [← hρ a, ← hρ b, h])
  obtain ⟨C₂', hS₂', hL₂', hR₂', -, hns₂'⟩ := CircleColouring.link_relabel C₂ hρi
  have hns₂'' := hns₂' hns₂
  have hL₂g : ∀ θ v, C₂'.LeftVal θ v ↔ F.GermPseudo u₂ θ .cw (g₁ v) := by
    intro θ v
    obtain ⟨w, hw⟩ := CircleColouring.exists_left_const C₂.locallyConstant θ
    have hw' : C₂'.LeftVal θ (ρ w) := (hL₂' θ w).mpr hw
    have hgw : F.GermPseudo u₂ θ .cw (g₁ (ρ w)) := by rw [hρ]; exact (hL₂ θ w).mp hw
    constructor
    · intro h; rw [CircleColouring.LeftVal.unique h hw']; exact hgw
    · intro h; rw [hg₁ (germPseudo_unique h hgw)]; exact hw'
  have hR₂g : ∀ θ v, C₂'.RightVal θ v ↔ F.GermPseudo u₂ θ .ccw (g₁ v) := by
    intro θ v
    obtain ⟨w, hw⟩ := CircleColouring.exists_right_const C₂.locallyConstant θ
    have hw' : C₂'.RightVal θ (ρ w) := (hR₂' θ w).mpr hw
    have hgw : F.GermPseudo u₂ θ .ccw (g₁ (ρ w)) := by rw [hρ]; exact (hR₂ θ w).mp hw
    constructor
    · intro h; rw [CircleColouring.RightVal.unique h hw']; exact hgw
    · intro h; rw [hg₁ (germPseudo_unique h hgw)]; exact hw'
  -- lifts, and the band of the second (BV-H1)
  obtain ⟨L₁⟩ := CircleColouring.exists_lift C₁
  obtain ⟨L₂⟩ := CircleColouring.exists_lift C₂'
  obtain ⟨θ₀, -, hg₀⟩ := C₂'.exists_good_near 0 1 one_pos
  have hT00 : θ₀ ∈ CircleColouring.T0 C₂' := ⟨hg₀.notMem, by simpa using hg₀.hex_notMem (i := 1) (by norm_num)⟩
  obtain ⟨M, hMc⟩ : ∃ M, ∀ z ∈ CircleColouring.T0 C₂', L₂.m 0 z = M :=
    ⟨L₂.m 0 θ₀, fun z hz => CircleColouring.m0_const L₂ (CircleColouring.hbig_of_noSwap L₂ hns₂'') z hz θ₀ hT00⟩
  have hbandz : ∀ z ∈ CircleColouring.T0 C₂', 3 * M + 1 ≤ L₂.D 0 z ∧ L₂.D 0 z ≤ 3 * M + 2 := by
    intro z hz
    have h1 := hMc z hz
    have h2 := CircleColouring.Lift.D0_mod_ne (L := L₂) hz.1 hz.2
    unfold CircleColouring.Lift.m at h1
    omega
  have hbandL : ∀ (x : ℝ) (l r l' r' : ℤ), L₂.Sides x l r → L₂.Sides (x + π / 3) l' r' →
      3 * M + 1 ≤ l' - l ∧ l' - l ≤ 3 * M + 2 := by
    intro x l r l' r' h0 h1
    obtain ⟨z, hz, hzD⟩ := CircleColouring.exists_T0_left L₂ h0 h1
    rw [← hzD]; exact hbandz z hz
  have hbandR : ∀ (x : ℝ) (l r l' r' : ℤ), L₂.Sides x l r → L₂.Sides (x + π / 3) l' r' →
      3 * M + 1 ≤ r' - r ∧ r' - r ≤ 3 * M + 2 := by
    intro x l r l' r' h0 h1
    obtain ⟨z, hz, hzD⟩ := CircleColouring.exists_T0_right L₂ h0 h1
    rw [← hzD]; exact hbandz z hz
  -- the linkage
  obtain ⟨φ, χ, θA, φP, χP, hφc, hχc, hφper, hχper, hdist, hφfib, hχfib, hturn, hθA0, hθAπ, hφA, hφA', hin1, hin2,
    hchiA, hflip, hone⟩ := exists_linkage ht ht'
  -- the generic sets: change points and non-singleton points of each ring
  set N₁ := {θ : ℝ | (F.pseudoColours u₁ (ringPt u₁ θ)).ncard ≠ 1} with hN₁
  set N₂ := {θ : ℝ | (F.pseudoColours u₂ (ringPt u₂ θ)).ncard ≠ 1} with hN₂
  have hNper : ∀ p : ℂ, ∀ θ, (F.pseudoColours p (ringPt p (θ + 2 * π))).ncard = (F.pseudoColours p (ringPt p θ)).ncard :=
    fun p θ => by rw [show ringPt p (θ + 2 * π) = ringPt p θ by simp only [ringPt, e_add_two_pi]]
  have hNfin : ∀ {p : ℂ}, p ∈ closedBall u 1 → F.IsCubicTrichromatic p → ∀ a b,
      ({θ : ℝ | (F.pseudoColours p (ringPt p θ)).ncard ≠ 1} ∩ Icc a b).Finite := by
    intro p hp hp3 a b
    refine CircleColouring.link_periodic_finite (fun θ => by simp only [mem_setOf_eq, hNper]) ?_ a b
    refine (B.pseudo_finite hp hp3).subset fun θ ⟨h1, h2⟩ => ⟨h2, h1⟩
  have hT₁ : ∀ a b, ((C₁.S ∪ N₁) ∩ Icc a b).Finite := fun a b => by
    rw [union_inter_distrib_right]; exact (C₁.S_inter_Icc_finite a b).union (hNfin h₁ c₁ a b)
  have hT₂ : ∀ a b, ((C₂'.S ∪ N₂) ∩ Icc a b).Finite := fun a b => by
    rw [union_inter_distrib_right]; exact (C₂'.S_inter_Icc_finite a b).union (hNfin h₂ c₂ a b)
  -- (hgen) generic pairs are not `0 mod 3`: FS112-N3-PAIRS (i)
  have hpseudo1 : ∀ θ, θ ∉ C₁.S → θ ∉ N₁ → F.pseudoColours u₁ (ringPt u₁ θ) = {g₁ (C₁.c θ)} := by
    intro θ hS hN
    have hv : C₁.LeftVal θ (C₁.c θ) := nhdsWithin_le_nhds (C₁.locallyConstant θ hS)
    have hm := ((hL₁ θ _).mp hv).mem_pseudoColours
    have h1 : (F.pseudoColours u₁ (ringPt u₁ θ)).ncard = 1 := by by_contra h; exact hN h
    obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp h1
    rw [ha] at hm ⊢; rw [mem_singleton_iff.mp hm]
  have hpseudo2 : ∀ θ, θ ∉ C₂'.S → θ ∉ N₂ → F.pseudoColours u₂ (ringPt u₂ θ) = {g₁ (C₂'.c θ)} := by
    intro θ hS hN
    have hv : C₂'.LeftVal θ (C₂'.c θ) := nhdsWithin_le_nhds (C₂'.locallyConstant θ hS)
    have hm := ((hL₂g θ _).mp hv).mem_pseudoColours
    have h1 : (F.pseudoColours u₂ (ringPt u₂ θ)).ncard = 1 := by by_contra h; exact hN h
    obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp h1
    rw [ha] at hm ⊢; rw [mem_singleton_iff.mp hm]
  have hgen : ∀ s, φ s ∉ C₁.S ∪ N₁ → χ s ∉ C₂'.S ∪ N₂ → (L₁.f (φ s) - L₂.f (χ s)) % 3 ≠ 0 := by
    intro s hs1 hs2 h0
    have hS1 : φ s ∉ C₁.S := fun h => hs1 (Or.inl h)
    have hS2 : χ s ∉ C₂'.S := fun h => hs2 (Or.inl h)
    have hc : C₁.c (φ s) = C₂'.c (χ s) := by
      have h3 : ((L₁.f (φ s) - L₂.f (χ s) : ℤ) : ZMod 3) = 0 :=
        (ZMod.intCast_zmod_eq_zero_iff_dvd _ 3).mpr (Int.dvd_of_emod_eq_zero h0)
      push_cast at h3
      rw [L₁.cast_eq _ hS1, L₂.cast_eq _ hS2] at h3
      exact sub_eq_zero.mp h3
    have hp2 := hpseudo2 (χ s) hS2 fun h => hs2 (Or.inr h)
    rw [← hc] at hp2
    exact pair_i hF c₁ c₂ (hcov h₁) (hcov h₂) (by linarith) (dist_ringPt _ _) (dist_ringPt _ _) (hdist s)
      (hpseudo1 (φ s) hS1 fun h => hs1 (Or.inr h)) hp2
  -- (hdbl) a double event carries one pair, against FS112-N3-PAIRS (ii) under H, unless `y` turns
  have hdbl : ∀ s, ∀ l₁ r₁ l₂ r₂ : ℤ, L₁.Sides (φ s) l₁ r₁ → L₂.Sides (χ s) l₂ r₂ → (r₁ - l₁ = 1 ∨ r₁ - l₁ = -1) →
      (r₂ - l₂ = 1 ∨ r₂ - l₂ = -1) → ((l₁ - l₂) % 3 = 0 ∧ (r₁ - r₂) % 3 = 0 ∨ (l₁ - r₂) % 3 = 0 ∧ (r₁ - l₂) % 3 = 0) →
      (∀ᶠ s' in 𝓝[≠] s, χ s' < χ s) ∨ (∀ᶠ s' in 𝓝[≠] s, χ s < χ s') := by
    intro s l₁ r₁ l₂ r₂ hs1 hs2 hj1 hj2 hpair
    by_cases h2 : dist (ringPt u₂ (χ s)) u₁ = 2
    · exact hturn s h2
    exfalso
    have hcast : ∀ a b : ℤ, (a - b) % 3 = 0 → (a : ZMod 3) = b := fun a b h =>
      (ZMod.intCast_eq_intCast_iff' a b 3).mpr (by omega)
    have hne : ∀ a b : ℤ, (a - b = 1 ∨ a - b = -1) → (a : ZMod 3) ≠ b := fun a b h h' => by
      have := (ZMod.intCast_eq_intCast_iff' a b 3).mp h'; omega
    obtain ⟨hv1l, hv1r⟩ := hs1.vals
    obtain ⟨hv2l, hv2r⟩ := hs2.vals
    have hpx : F.pseudoColours u₁ (ringPt u₁ (φ s)) = {g₁ (l₁ : ZMod 3), g₁ (r₁ : ZMod 3)} := by
      have hsub : ({g₁ (l₁ : ZMod 3), g₁ (r₁ : ZMod 3)} : Set (Fin 6)) ⊆ F.pseudoColours u₁ (ringPt u₁ (φ s)) :=
        insert_subset ((hL₁ _ _).mp hv1l).mem_pseudoColours (singleton_subset_iff.mpr ((hR₁ _ _).mp hv1r).mem_pseudoColours)
      have hle := B.pseudo_ncard_le_two h₁ c₁ (dist_ringPt u₁ (φ s))
      exact (Set.eq_of_subset_of_ncard_le hsub (by rw [Set.ncard_pair (hg₁.ne (hne r₁ l₁ hj1).symm)]; exact hle)).symm
    have hpy : F.pseudoColours u₂ (ringPt u₂ (χ s)) = {g₁ (l₂ : ZMod 3), g₁ (r₂ : ZMod 3)} := by
      have hsub : ({g₁ (l₂ : ZMod 3), g₁ (r₂ : ZMod 3)} : Set (Fin 6)) ⊆ F.pseudoColours u₂ (ringPt u₂ (χ s)) :=
        insert_subset ((hL₂g _ _).mp hv2l).mem_pseudoColours (singleton_subset_iff.mpr ((hR₂g _ _).mp hv2r).mem_pseudoColours)
      have hle := B.pseudo_ncard_le_two h₂ c₂ (dist_ringPt u₂ (χ s))
      exact (Set.eq_of_subset_of_ncard_le hsub (by rw [Set.ncard_pair (hg₁.ne (hne r₂ l₂ hj2).symm)]; exact hle)).symm
    have hpy' : F.pseudoColours u₂ (ringPt u₂ (χ s)) = {g₁ (l₁ : ZMod 3), g₁ (r₁ : ZMod 3)} := by
      rw [hpy]
      rcases hpair with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · rw [hcast l₁ l₂ h1, hcast r₁ r₂ h2]
      · rw [hcast l₁ r₂ h1, hcast r₁ l₂ h2, Set.pair_comm]
    have htr : ringPt u₂ (χ s) ≠ u₁ ∧ dist (ringPt u₂ (χ s)) u₁ ≠ 2 := ⟨fun h => by
      have := dist_ringPt u₂ (χ s); rw [h] at this; linarith, h2⟩
    rcases pair_ii hF c₁ c₂ (hcov h₁) (hcov h₂) (dist_ringPt _ _) (dist_ringPt _ _) (hdist s) htr
        (hg₁.ne (hne r₁ l₁ hj1).symm) hpx hpy' with h4 | ⟨θ₁, θ₂, hb⟩
    · have hx2 := hring2 h₁ _ (dist_ringPt u₁ (φ s))
      exact Set.disjoint_left.mp B.hyp hx2 (Or.inl ⟨B.covers hx2, h4⟩)
    · have hy2 := hring2 h₂ _ (dist_ringPt u₂ (χ s))
      rcases noBoth hF (B.covers hy2) hb with h4 | hrep
      · exact Set.disjoint_left.mp B.hyp hy2 (Or.inl ⟨B.covers hy2, h4⟩)
      · exact Set.disjoint_left.mp B.hyp hy2 (Or.inr ⟨B.covers hy2, hrep⟩)
  -- sides at the ends of the two paths
  obtain ⟨l₁P, r₁P, hsP, -⟩ := L₁.exists_sides φP
  obtain ⟨lA, rA, hsA, -⟩ := L₂.exists_sides (χ θA)
  obtain ⟨lB, rB, hsB, -⟩ := L₂.exists_sides (χ (-θA))
  have hsP1 : L₁.Sides (φ (-θA)) l₁P r₁P := hφA' ▸ hsP
  have hsP2 : L₁.Sides (φ θA) l₁P r₁P := hφA ▸ hsP
  have h2πA : 2 * π - θA = -θA + 2 * π := by ring
  have hsP3 : L₁.Sides (φ (2 * π - θA)) l₁P r₁P := by rw [h2πA, hφper]; exact hsP1
  have hsB3 : L₂.Sides (χ (2 * π - θA)) lB rB := by rw [h2πA, hχper]; exact hsB
  have hφc' := hφc.continuousOn (s := Icc (-θA) θA)
  have hχc' := hχc.continuousOn (s := Icc (-θA) θA)
  have hφc'' := hφc.continuousOn (s := Icc θA (2 * π - θA))
  have hχc'' := hχc.continuousOn (s := Icc θA (2 * π - θA))
  -- path 1, `[−θ_A, θ_A]`: `x` above `P`
  obtain ⟨δ1, hδ1, hδ1b, h1φ⟩ := CircleColouring.link_val_right L₁ hφc' (hφfib _ _) ⟨le_rfl, by linarith⟩ hsP1
  obtain ⟨δ2, hδ2, hδ2b, h1χ⟩ := CircleColouring.link_val_right L₂ hχc' (hχfib _ _) ⟨le_rfl, by linarith⟩ hsB
  obtain ⟨δ3, hδ3, hδ3a, h2φ⟩ := CircleColouring.link_val_left L₁ hφc' (hφfib _ _) ⟨by linarith, le_rfl⟩ hsP2
  obtain ⟨δ4, hδ4, hδ4a, h2χ⟩ := CircleColouring.link_val_left L₂ hχc' (hχfib _ _) ⟨by linarith, le_rfl⟩ hsA
  have hφ1 : ∀ s ∈ Ioo (-θA) (-θA + δ1), L₁.f (φ s) = r₁P := by
    rcases h1φ with h | h
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin1 s ⟨hs.1, by linarith [hs.2]⟩; rw [hφA'] at e1; linarith
    · exact fun s hs => (h s hs).1
  have hφ2 : ∀ s ∈ Ioo (θA - δ3) θA, L₁.f (φ s) = r₁P := by
    rcases h2φ with h | h
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin1 s ⟨by linarith [hs.1], hs.2⟩; rw [hφA] at e1; linarith
    · exact fun s hs => (h s hs).1
  obtain ⟨hB1, hB1v, hB1s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (-θA) (-θA + δ2), L₂.f (χ s) = h) ∧
      ((h = lB ∧ ∀ s ∈ Ioo (-θA) (-θA + δ2), χ s < χ (-θA)) ∨ (h = rB ∧ ∀ s ∈ Ioo (-θA) (-θA + δ2), χ (-θA) < χ s)) := by
    rcases h1χ with h | h
    · exact ⟨lB, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rB, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  obtain ⟨hA1, hA1v, hA1s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (θA - δ4) θA, L₂.f (χ s) = h) ∧
      ((h = lA ∧ ∀ s ∈ Ioo (θA - δ4) θA, χ s < χ θA) ∨ (h = rA ∧ ∀ s ∈ Ioo (θA - δ4) θA, χ θA < χ s)) := by
    rcases h2χ with h | h
    · exact ⟨lA, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rA, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  have hp1 := CircleColouring.link_path L₁ L₂ (by linarith : -θA < θA) hφc' hχc' (hφfib _ _) (hχfib _ _) hT₁ hT₂
    subset_union_left subset_union_left (fun s _ => hgen s) (fun s _ => hdbl s) (r₁P - hB1) (r₁P - hA1)
    ⟨min δ1 δ2, lt_min hδ1 hδ2, fun s hs => by
      rw [hφ1 s ⟨hs.1, by linarith [hs.2, min_le_left δ1 δ2]⟩, hB1v s ⟨hs.1, by linarith [hs.2, min_le_right δ1 δ2]⟩]⟩
    ⟨min δ3 δ4, lt_min hδ3 hδ4, fun s hs => by
      rw [hφ2 s ⟨by linarith [hs.1, min_le_left δ3 δ4], hs.2⟩, hA1v s ⟨by linarith [hs.1, min_le_right δ3 δ4], hs.2⟩]⟩
  -- path 2, `[θ_A, 2π − θ_A]`: `x` below `P`
  obtain ⟨δ5, hδ5, hδ5b, h3φ⟩ := CircleColouring.link_val_right L₁ hφc'' (hφfib _ _) ⟨le_rfl, by linarith⟩ hsP2
  obtain ⟨δ6, hδ6, hδ6b, h3χ⟩ := CircleColouring.link_val_right L₂ hχc'' (hχfib _ _) ⟨le_rfl, by linarith⟩ hsA
  obtain ⟨δ7, hδ7, hδ7a, h4φ⟩ := CircleColouring.link_val_left L₁ hφc'' (hφfib _ _) ⟨by linarith, le_rfl⟩ hsP3
  obtain ⟨δ8, hδ8, hδ8a, h4χ⟩ := CircleColouring.link_val_left L₂ hχc'' (hχfib _ _) ⟨by linarith, le_rfl⟩ hsB3
  have hφ3 : ∀ s ∈ Ioo θA (θA + δ5), L₁.f (φ s) = l₁P := by
    rcases h3φ with h | h
    · exact fun s hs => (h s hs).1
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin2 s ⟨hs.1, by linarith [hs.2]⟩; rw [hφA] at e1; linarith
  have hφ4 : ∀ s ∈ Ioo (2 * π - θA - δ7) (2 * π - θA), L₁.f (φ s) = l₁P := by
    rcases h4φ with h | h
    · exact fun s hs => (h s hs).1
    · intro s hs; exfalso
      have e1 := (h s hs).2; have e2 := hin2 s ⟨by linarith [hs.1], hs.2⟩
      rw [h2πA, hφper, hφA'] at e1; linarith
  obtain ⟨hA2, hA2v, hA2s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo θA (θA + δ6), L₂.f (χ s) = h) ∧
      ((h = lA ∧ ∀ s ∈ Ioo θA (θA + δ6), χ s < χ θA) ∨ (h = rA ∧ ∀ s ∈ Ioo θA (θA + δ6), χ θA < χ s)) := by
    rcases h3χ with h | h
    · exact ⟨lA, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rA, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  obtain ⟨hB2, hB2v, hB2s⟩ : ∃ h : ℤ, (∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), L₂.f (χ s) = h) ∧
      ((h = lB ∧ ∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), χ s < χ (2 * π - θA)) ∨
        (h = rB ∧ ∀ s ∈ Ioo (2 * π - θA - δ8) (2 * π - θA), χ (2 * π - θA) < χ s)) := by
    rcases h4χ with h | h
    · exact ⟨lB, fun s hs => (h s hs).1, Or.inl ⟨rfl, fun s hs => (h s hs).2⟩⟩
    · exact ⟨rB, fun s hs => (h s hs).1, Or.inr ⟨rfl, fun s hs => (h s hs).2⟩⟩
  have hp2 := CircleColouring.link_path L₁ L₂ (by linarith : θA < 2 * π - θA) hφc'' hχc'' (hφfib _ _) (hχfib _ _) hT₁ hT₂
    subset_union_left subset_union_left (fun s _ => hgen s) (fun s _ => hdbl s) (l₁P - hA2) (l₁P - hB2)
    ⟨min δ5 δ6, lt_min hδ5 hδ6, fun s hs => by
      rw [hφ3 s ⟨hs.1, by linarith [hs.2, min_le_left δ5 δ6]⟩, hA2v s ⟨hs.1, by linarith [hs.2, min_le_right δ5 δ6]⟩]⟩
    ⟨min δ7 δ8, lt_min hδ7 hδ8, fun s hs => by
      rw [hφ4 s ⟨by linarith [hs.1, min_le_left δ7 δ8], hs.2⟩, hB2v s ⟨by linarith [hs.1, min_le_right δ7 δ8], hs.2⟩]⟩
  -- the flips: where `|y − u₁| < 2`, the two paths reach `y` from opposite sides
  have hflipA : dist (ringPt u₂ (χ θA)) u₁ < 2 → (hA1 = lA ∧ hA2 = rA) ∨ (hA1 = rA ∧ hA2 = lA) := by
    intro hd
    obtain ⟨η, hη, hm⟩ := hflip θA (Or.inl rfl) hd
    set ε := min η (min δ4 δ6) with hε
    have hε0 : 0 < ε := lt_min hη (lt_min hδ4 hδ6)
    have e1 : ε ≤ η := min_le_left _ _
    have e2 : ε ≤ δ4 := (min_le_right _ _).trans (min_le_left _ _)
    have e3 : ε ≤ δ6 := (min_le_right _ _).trans (min_le_right _ _)
    have hs₁ : θA - ε / 2 ∈ Ioo (θA - δ4) θA := ⟨by linarith, by linarith⟩
    have hs₂ : θA + ε / 2 ∈ Ioo θA (θA + δ6) := ⟨by linarith, by linarith⟩
    have m₁ : θA - ε / 2 ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    have m₀ : θA ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    have m₂ : θA + ε / 2 ∈ Icc (θA - η) (θA + η) := ⟨by linarith, by linarith⟩
    rcases hm with hm | hm
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      left; constructor
      · rcases hA1s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₁) (not_lt.mpr f1.le)
      · rcases hA2s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₂) (not_lt.mpr f2.le)
        · exact h
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      right; constructor
      · rcases hA1s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₁) (not_lt.mpr f1.le)
        · exact h
      · rcases hA2s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₂) (not_lt.mpr f2.le)
  have hflipB : dist (ringPt u₂ (χ (-θA))) u₁ < 2 → (hB1 = rB ∧ hB2 = lB) ∨ (hB1 = lB ∧ hB2 = rB) := by
    intro hd
    obtain ⟨η, hη, hm⟩ := hflip (-θA) (Or.inr rfl) hd
    set ε := min η (min δ2 δ8) with hε
    have hε0 : 0 < ε := lt_min hη (lt_min hδ2 hδ8)
    have e1 : ε ≤ η := min_le_left _ _
    have e2 : ε ≤ δ2 := (min_le_right _ _).trans (min_le_left _ _)
    have e3 : ε ≤ δ8 := (min_le_right _ _).trans (min_le_right _ _)
    have hs₁ : -θA + ε / 2 ∈ Ioo (-θA) (-θA + δ2) := ⟨by linarith, by linarith⟩
    have hs₂ : 2 * π - θA - ε / 2 ∈ Ioo (2 * π - θA - δ8) (2 * π - θA) := ⟨by linarith, by linarith⟩
    have hper2 : χ (2 * π - θA - ε / 2) = χ (-θA - ε / 2) := by
      rw [show 2 * π - θA - ε / 2 = (-θA - ε / 2) + 2 * π by ring, hχper]
    have hper0 : χ (2 * π - θA) = χ (-θA) := by rw [h2πA, hχper]
    have m₁ : -θA - ε / 2 ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    have m₀ : -θA ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    have m₂ : -θA + ε / 2 ∈ Icc (-θA - η) (-θA + η) := ⟨by linarith, by linarith⟩
    rcases hm with hm | hm
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      left; constructor
      · rcases hB1s with ⟨-, h⟩ | ⟨h, -⟩
        · exact absurd (h _ hs₁) (not_lt.mpr f2.le)
        · exact h
      · rcases hB2s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · have := h _ hs₂; rw [hper2, hper0] at this; exact absurd this (not_lt.mpr f1.le)
    · have f1 := hm m₁ m₀ (by linarith)
      have f2 := hm m₀ m₂ (by linarith)
      right; constructor
      · rcases hB1s with ⟨h, -⟩ | ⟨-, h⟩
        · exact h
        · exact absurd (h _ hs₁) (not_lt.mpr f2.le)
      · rcases hB2s with ⟨-, h⟩ | ⟨h, -⟩
        · have := h _ hs₂; rw [hper2, hper0] at this; exact absurd this (not_lt.mpr f1.le)
        · exact h
  -- the band at the two partners of `P` (BV-H1): `χ(±θ_A) = χ_P ± 60°`
  obtain ⟨l₀, r₀, hs₀, -⟩ := L₂.exists_sides χP
  obtain ⟨lp, rp, hsp, -⟩ := L₂.exists_sides (χP + π / 3)
  obtain ⟨lm, rm, hsm, -⟩ := L₂.exists_sides (χP - π / 3)
  have b1 := hbandL χP l₀ r₀ lp rp hs₀ hsp
  have b2 := hbandR χP l₀ r₀ lp rp hs₀ hsp
  have hsm' : L₂.Sides (χP - π / 3 + π / 3) l₀ r₀ := by rw [show χP - π / 3 + π / 3 = χP by ring]; exact hs₀
  have b3 := hbandL (χP - π / 3) lm rm l₀ r₀ hsm hsm'
  have b4 := hbandR (χP - π / 3) lm rm l₀ r₀ hsm hsm'
  have hAB : (lA = lp ∧ rA = rp ∧ lB = lm ∧ rB = rm) ∨ (lA = lm ∧ rA = rm ∧ lB = lp ∧ rB = rp) := by
    rcases hchiA with ⟨eA, eB⟩ | ⟨eA, eB⟩
    · rw [eA] at hsA; rw [eB] at hsB
      obtain ⟨f1, f2⟩ := hsA.unique hsp
      obtain ⟨f3, f4⟩ := hsB.unique hsm
      exact Or.inl ⟨f1, f2, f3, f4⟩
    · rw [eA] at hsA; rw [eB] at hsB
      obtain ⟨f1, f2⟩ := hsA.unique hsm
      obtain ⟨f3, f4⟩ := hsB.unique hsp
      exact Or.inr ⟨f1, f2, f3, f4⟩
  obtain ⟨p1a, p1b, p1c⟩ := hp1
  obtain ⟨p2a, p2b, p2c⟩ := hp2
  have hB1v' : hB1 = lB ∨ hB1 = rB := hB1s.imp (fun h => h.1) (fun h => h.1)
  have hA1v' : hA1 = lA ∨ hA1 = rA := hA1s.imp (fun h => h.1) (fun h => h.1)
  have hA2v' : hA2 = lA ∨ hA2 = rA := hA2s.imp (fun h => h.1) (fun h => h.1)
  have hB2v' : hB2 = lB ∨ hB2 = rB := hB2s.imp (fun h => h.1) (fun h => h.1)
  rcases hone with hd | hd
  · rcases hflipA hd with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hB1v' with e3 | e3 <;> rcases hB2v' with e4 | e4 <;>
      rcases hAB with ⟨f1, f2, f3, f4⟩ | ⟨f1, f2, f3, f4⟩ <;> omega
  · rcases hflipB hd with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hA1v' with e3 | e3 <;> rcases hA2v' with e4 | e4 <;>
      rcases hAB with ⟨f1, f2, f3, f4⟩ | ⟨f1, f2, f3, f4⟩ <;> omega

/-- **The hexagon is excluded** (Prop. 17 with unit arcs): a rotating hexagon of the (reduced) pseudo-colouring of `ω(u)` is a `HexRing` of the
map — its six points keep their germs — so `p17_ua` (or `bv_hex`) refutes it. -/
theorem BaseCtx.hex_base (B : F.BaseCtx u) {C : CircleColouring} {g : ZMod 3 → Fin 6} (hg : Function.Injective g)
    (hL : ∀ θ v, C.LeftVal θ v → F.GermPseudo u θ .cw (g v)) (hR : ∀ θ v, C.RightVal θ v → F.GermPseudo u θ .ccw (g v))
    {ψ : ℝ} {b : ZMod 3 → ZMod 3} (hhex : C.IsHex ψ b) : False := by
  obtain ⟨hb, hh⟩ := hhex
  refine p17_ua B.valid B.covers B.cubic B.hyp (ψ := ψ) (b := g ∘ b) ⟨hg.comp hb, fun j hj => ?_⟩
  obtain ⟨hl, hr⟩ := hh j hj
  have h1 := hL _ _ hl
  have h2 := hR _ _ hr
  have hne : g (b j) ≠ g (b (j + 1)) := by
    refine hg.ne (hb.ne fun h => ?_)
    have h' : (1 : ZMod 3) = 0 := by linear_combination -h
    exact absurd h' (by decide)
  exact ⟨rot_noThird B.valid B.covers B.cubic B.hyp hne h1 h2, h1, h2⟩

/-! ## E — the count -/

/-- **The eleventh point's type** (Lemma 4's `10 + 1`): if for each pair of absent colours the three endpoints' colours of `u` are distinct
(else two endpoints share a multicolour), the complement of a type with exactly two colours of `u` is an endpoint's type. Finite combinatorics
on `Fin 6`. -/
theorem eleventh_type {U Q : Finset (Fin 6)} (hU : U.card = 3) (hQ : Q.card = 3) (hQU : (Q ∩ U).card = 2)
    (t : Finset (Fin 6) → Fin 3 → Fin 6) (ht : ∀ P, P ⊆ Uᶜ → P.card = 2 → Function.Injective (t P) ∧ ∀ i, t P i ∈ U) :
    ∃ P, P ⊆ Uᶜ ∧ P.card = 2 ∧ ∃ i, Qᶜ = insert (t P i) P := by
  -- `P` is the two absent colours outside `Q`; `t P` is onto `U`, so it hits the colour of `U` outside `Q`
  set P := Qᶜ ∩ Uᶜ with hP
  have hPU : P ⊆ Uᶜ := Finset.inter_subset_right
  have hunion : (Q ∪ U).card = 4 := by
    have := Finset.card_union_add_card_inter Q U
    omega
  have hPc : P.card = 2 := by
    have h1 : P = (Q ∪ U)ᶜ := by rw [hP, Finset.compl_union]
    rw [h1, Finset.card_compl, hunion]; rfl
  obtain ⟨hinj, hmem⟩ := ht P hPU hPc
  have hUQ : (U \ Q).card = 1 := by
    have := Finset.card_sdiff_add_card_inter U Q
    rw [Finset.inter_comm] at this
    omega
  obtain ⟨w, hw⟩ := Finset.card_eq_one.mp hUQ
  have hwU : w ∈ U := (Finset.mem_sdiff.mp (hw ▸ Finset.mem_singleton_self w)).1
  have hwQ : w ∉ Q := (Finset.mem_sdiff.mp (hw ▸ Finset.mem_singleton_self w)).2
  have himg : Finset.univ.image (t P) = U := by
    apply Finset.eq_of_subset_of_card_le
    · intro x hx
      obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hx
      exact hmem i
    · rw [Finset.card_image_of_injective _ hinj, hU]; rfl
  obtain ⟨i, -, hi⟩ := Finset.mem_image.mp (himg ▸ hwU)
  refine ⟨P, hPU, hPc, i, ?_⟩
  rw [hi]
  ext x
  simp only [Finset.mem_compl, Finset.mem_insert, hP, Finset.mem_inter]
  constructor
  · intro hxQ
    by_cases hxU : x ∈ U
    · left
      have : x ∈ U \ Q := Finset.mem_sdiff.mpr ⟨hxU, hxQ⟩
      rw [hw] at this
      exact Finset.mem_singleton.mp this
    · right; exact ⟨hxQ, hxU⟩
  · rintro (rfl | ⟨hxQ, -⟩)
    · exact hwQ
    · exact hxQ

end ArcMap

end HadwigerNelson.Plane
