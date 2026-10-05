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

/-- **The selection** (`[SokolovVoronov2025]` Lemma 5, BV-C6 and Prop. 18, as BASE-V § 1a.2–1a.3 and FS110-CD § 2.5 derived them): a circle
colouring with no swap point is the rotating hexagon, or for each pair of colours it has three change points with that pair, pairwise more than
`60°` apart (chords longer than `1`). Circle-abstract; Lemma 5's recolouring keeps each kept point's pair, so the points are the colouring's own. -/
theorem select (hns : ∀ x, ¬ C.IsSwap x) :
    (∃ ψ b, C.IsHex ψ b) ∨
      ∀ v w : ZMod 3, v ≠ w → ∃ x : Fin 3 → ℝ, (∀ i, C.ChangeWith (x i) v w) ∧ ∀ i j, i ≠ j → 1 < ‖e (x i) - e (x j)‖ := by
  sorry

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

/-- **Lemma 3 in pseudo-colour form** (`[SokolovVoronov2025]` Lemma 3; BASE-V's BV-L3 route — the unit-distance linkage and the band lemma —
on the two pseudo-colourings): two cubic trichromatic points of `B̄(u, 1)` with one multicolour are not at distance in `(1, 2)`. Their circles may
carry in- and out-contact unit arcs (plan § 2.2), so `bv_l3`'s `RingProper` is not available; the inputs are `exists_pseudoCircle` at both,
(i) across the circles from `pair_i`, the double event from `pair_ii` (or `bv_nd`), and `linkage_dot_ne_zero`. -/
theorem BaseCtx.l3_base (B : F.BaseCtx u) {u₁ u₂ : ℂ} (h₁ : u₁ ∈ closedBall u 1) (h₂ : u₂ ∈ closedBall u 1)
    (c₁ : F.IsCubicTrichromatic u₁) (c₂ : F.IsCubicTrichromatic u₂) (hsame : F.coloursAt u₁ = F.coloursAt u₂)
    (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2) : False := by
  sorry

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
