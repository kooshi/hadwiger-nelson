import Proofs.HadwigerNelson.Arith.ThreeColourCharacter
import Proofs.HadwigerNelson.Kempe
import Proofs.HadwigerNelson.LocalGlobal

/-!
# Three colours on abelian Cayley graphs: the criterion and the periodic form (FS-131; planner FS131-KTC1, implementers FS131-ICT1 and FS131-ICT2)

**Read aloud, against `LEDGER.md` row 79.** Row 79: *"every Cayley graph of a finitely generated torsion-free abelian group is
3-colourable iff a character puts every generator in `[1/3, 2/3]` … ⟺ it has a periodic (circular) 3-colouring"*, for `S = −S`
finite generating. Here, in this library's words, and in the widest class the proofs read (the coordinator's ruling,
FS-131 inventory item 996):
* `colorable_three_iff_bandSet_nonempty` — for **every** abelian group `A` and **every** `S ⊆ A` with `0 ∉ S`,
  `addCayley S` is 3-colourable iff `bandSet S (band 3)` (the characters `θ : A → ℝ/ℤ` with `θ(S) ⊆ [1/3, 2/3]`) is nonempty.
  The ⟹ is the held `bandSet_three_nonempty_of_proper`; the ⟸ is the circular colouring `x ↦ ⌊3·{θ(x)}⌋`.
* `colorable_three_iff_exists_isPeriodic` — for `A` finitely generated and `S` finite: 3-colourable iff some
  3-colouring has a period group of finite index. No torsion-freeness, no symmetry, no generation.
* `not_isPeriodic_rat`, with `colorable_three_rat` — the control: over `ℚ` with the step `1` the graph is 3-colourable and no
  3-colouring is periodic, so finite generation cannot be dropped.
* `colorable_three_iff_of_fg_torsionFree` — row 79's class, as an instance of the two.

**Not claimed:** anything at `k ≠ 3`; the forms of row 79 over `Hom(Λ, ℝ)` (FS73-T22's, which needs torsion-freeness);
that the widening is new — circular colourings of abelian Cayley graphs are old (FS73-T22's prior-art line; the plan's
§ 3.6 records the question).

**Shared tool.** `exists_rat_solution_near` (a linear system with rational coefficients and a real solution has rational
solutions arbitrarily near it) is used here and by `CayleyThree/Fibre`.
-/

namespace HadwigerNelson.CayleyThree

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter SimpleGraph

/-! ## §1 Rational points near real solutions of rational linear systems -/

/-- **Rational solutions are dense in the real solutions of a rational linear system**: a system `G y = b` with rational
coefficients and a real solution `x` has a rational solution within `ε` of `x` in every coordinate. (Route: a `ℚ`-basis of
the `ℚ`-span of `1` and the coordinates of `x`; the basis vectors moved to nearby rationals; normalized at `1`.) -/
theorem exists_rat_solution_near {ι κ : Type*} [Fintype ι] [Finite κ] (G : κ → ι → ℚ) (b : κ → ℚ) {x : ι → ℝ}
    (hx : ∀ k, ∑ i, (G k i : ℝ) * x i = b k) {ε : ℝ} (hε : 0 < ε) :
    ∃ q : ι → ℚ, (∀ k, ∑ i, G k i * q i = b k) ∧ ∀ i, |(q i : ℝ) - x i| < ε := by
  classical
  -- the `ℚ`-span `V` of `1` and the coordinates of `x`, with a basis `bV`
  let V : Submodule ℚ ℝ := Submodule.span ℚ (insert (1 : ℝ) (Set.range x))
  haveI : FiniteDimensional ℚ V := FiniteDimensional.span_of_finite ℚ ((Set.finite_range x).insert 1)
  let bV := Module.finBasis ℚ V
  let xV : ι → V := fun i => ⟨x i, Submodule.subset_span (Set.mem_insert_of_mem _ ⟨i, rfl⟩)⟩
  let oneV : V := ⟨1, Submodule.subset_span (Set.mem_insert _ _)⟩
  -- the coordinates of the `x i` and of `1`
  let a : ι → Fin (Module.finrank ℚ V) → ℚ := fun i l => bV.repr (xV i) l
  let c : Fin (Module.finrank ℚ V) → ℚ := fun l => bV.repr oneV l
  -- the system holds coordinate by coordinate, since it holds in `V`
  have hsys : ∀ k l, ∑ i, G k i * a i l = b k * c l := by
    intro k l
    have hVeq : ∑ i, G k i • xV i = b k • oneV := by
      apply Subtype.ext
      rw [Submodule.coe_sum, Submodule.coe_smul]
      simp only [Submodule.coe_smul, Rat.smul_def, xV, oneV, mul_one]
      exact hx k
    have h := congrArg (fun v => bV.repr v l) hVeq
    simpa [map_sum, map_smul, a, c] using h
  -- the real point `t₀` (the basis vectors themselves) reproduces `x` and `1`
  let t₀ : Fin (Module.finrank ℚ V) → ℝ := fun l => (bV l : ℝ)
  have hrep : ∀ v : V, ∑ l, ((bV.repr v l : ℚ) : ℝ) * t₀ l = (v : ℝ) := fun v => by
    conv_rhs => rw [← bV.sum_repr v]
    rw [Submodule.coe_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [Submodule.coe_smul, Rat.smul_def]
  -- the two maps of `t`, and their values at `t₀`
  let w : ι → (Fin (Module.finrank ℚ V) → ℝ) → ℝ := fun i t => ∑ l, (a i l : ℝ) * t l
  let u : (Fin (Module.finrank ℚ V) → ℝ) → ℝ := fun t => ∑ l, (c l : ℝ) * t l
  have hw0 : ∀ i, w i t₀ = x i := fun i => hrep (xV i)
  have hu0 : u t₀ = 1 := hrep oneV
  have hwc : ∀ i, Continuous (w i) := fun i => by fun_prop
  have huc : Continuous u := by fun_prop
  -- near `t₀`, `u > 0` and `w i / u` is within `ε` of `x i`
  have hev : ∀ᶠ t in nhds t₀, 0 < u t ∧ ∀ i, |w i t / u t - x i| < ε := by
    have hut : Filter.Tendsto u (nhds t₀) (nhds 1) := hu0 ▸ huc.continuousAt.tendsto
    refine (hut.eventually (Ioi_mem_nhds one_pos)).and (Filter.eventually_all.mpr fun i => ?_)
    have hdiv : Filter.Tendsto (fun t => w i t / u t) (nhds t₀) (nhds (x i / 1)) :=
      ((hw0 i) ▸ (hwc i).continuousAt.tendsto).div hut one_ne_zero
    rw [div_one] at hdiv
    filter_upwards [Metric.tendsto_nhds.mp hdiv ε hε] with t ht
    rwa [Real.dist_eq] at ht
  obtain ⟨O, hOsub, hOopen, hO0⟩ := mem_nhds_iff.mp hev
  -- a rational point `tq` there
  obtain ⟨tq, htq⟩ := (DenseRange.piMap fun _ : Fin (Module.finrank ℚ V) => Rat.denseRange_cast (𝕜 := ℝ)).exists_mem_open
    hOopen ⟨t₀, hO0⟩
  obtain ⟨hupos, hclose⟩ := hOsub htq
  set U : ℚ := ∑ l, c l * tq l with hU
  have hUcast : (U : ℝ) = u (Pi.map (fun _ => Rat.cast) tq) := by
    simp only [hU, u, Rat.cast_sum, Rat.cast_mul, Pi.map_apply]
  have hU0 : U ≠ 0 := fun h0 => by rw [h0, Rat.cast_zero] at hUcast; linarith
  refine ⟨fun i => (∑ l, a i l * tq l) / U, fun k => ?_, fun i => ?_⟩
  · -- the system, through the coordinates
    have e1 : ∑ i, G k i * ((∑ l, a i l * tq l) / U) = (∑ i, G k i * ∑ l, a i l * tq l) / U := by
      rw [Finset.sum_div]
      exact Finset.sum_congr rfl fun i _ => by rw [mul_div_assoc]
    have e2 : ∑ i, G k i * ∑ l, a i l * tq l = b k * U := by
      simp_rw [Finset.mul_sum]
      rw [Finset.sum_comm, hU, Finset.mul_sum]
      refine Finset.sum_congr rfl fun l _ => ?_
      calc ∑ i, G k i * (a i l * tq l) = (∑ i, G k i * a i l) * tq l := by
            rw [Finset.sum_mul]; exact Finset.sum_congr rfl fun i _ => by ring
        _ = b k * (c l * tq l) := by rw [hsys k l]; ring
    rw [e1, e2, mul_div_cancel_right₀ _ hU0]
  · -- the distance, through the real maps
    have hq : (((∑ l, a i l * tq l) / U : ℚ) : ℝ) = w i (Pi.map (fun _ => Rat.cast) tq) / u (Pi.map (fun _ => Rat.cast) tq) := by
      rw [Rat.cast_div, hUcast]
      simp only [w, Rat.cast_sum, Rat.cast_mul, Pi.map_apply]
    rw [hq]
    exact hclose i

/-! ## §2 The circular colouring of a character -/

variable {A : Type*} [AddCommGroup A] {S : Set A}

/-- Finitely many positive reals have a positive common lower bound. -/
private theorem exists_pos_le {ι : Type*} [Finite ι] (δ : ι → ℝ) (h : ∀ i, 0 < δ i) : ∃ ε > 0, ∀ i, ε ≤ δ i := by
  rcases isEmpty_or_nonempty ι with hι | hι
  · exact ⟨1, one_pos, fun i => isEmptyElim i⟩
  · obtain ⟨i₀, hi₀⟩ := Finite.exists_min δ
    exact ⟨δ i₀, h i₀, hi₀⟩

/-- The representative in `[0, 1)` of a point of `ℝ/ℤ`. -/
noncomputable def rep01 (t : UnitAddCircle) : ℝ := (AddCircle.equivIco 1 0 t : ℝ)

theorem rep01_mem (t : UnitAddCircle) : rep01 t ∈ Set.Ico (0 : ℝ) 1 := by
  have h : rep01 t ∈ Set.Ico (0 : ℝ) (0 + 1) := (AddCircle.equivIco 1 (0 : ℝ) t).2
  rwa [zero_add] at h

theorem coe_rep01 (t : UnitAddCircle) : ((rep01 t : ℝ) : UnitAddCircle) = t :=
  AddCircle.coe_equivIco

/-- `rep01` is the identity on `[0, 1)`. -/
theorem rep01_coe {x : ℝ} (hx : x ∈ Set.Ico (0 : ℝ) 1) : rep01 (x : UnitAddCircle) = x := by
  have hx' : x ∈ Set.Ico (0 : ℝ) (0 + 1) := by rwa [zero_add]
  change ((AddCircle.equivIco 1 (0 : ℝ) (x : UnitAddCircle) : ℝ)) = x
  rw [AddCircle.equivIco_coe_eq hx']

/-- Two points of `[0, 1)` whose difference is a band value modulo `1` have floors of `3·t` in different classes mod 3. -/
private theorem floor_three_ne {t t' y : ℝ} (ht : t ∈ Set.Ico (0 : ℝ) 1) (ht' : t' ∈ Set.Ico (0 : ℝ) 1)
    (hy1 : 1 / 3 ≤ y) (hy2 : y ≤ 2 / 3) {n : ℤ} (hn : (n : ℝ) = t' - t - y) :
    ((⌊3 * t'⌋ : ℤ) : ZMod 3) ≠ ((⌊3 * t⌋ : ℤ) : ZMod 3) := by
  obtain ⟨ht1, ht2⟩ := ht
  obtain ⟨ht1', ht2'⟩ := ht'
  have hb1 := Int.floor_le (3 * t'); have hb2 := Int.lt_floor_add_one (3 * t')
  have hb3 := Int.floor_le (3 * t); have hb4 := Int.lt_floor_add_one (3 * t)
  have f1 : 0 ≤ ⌊3 * t'⌋ := Int.floor_nonneg.mpr (by linarith)
  have f2 : ⌊3 * t'⌋ < 3 := Int.floor_lt.mpr (by push_cast; linarith)
  have f3 : 0 ≤ ⌊3 * t⌋ := Int.floor_nonneg.mpr (by linarith)
  have f4 : ⌊3 * t⌋ < 3 := Int.floor_lt.mpr (by push_cast; linarith)
  intro heq
  rw [ZMod.intCast_eq_intCast_iff'] at heq
  push_cast at heq
  have hfl : ⌊3 * t'⌋ = ⌊3 * t⌋ := by omega
  rw [hfl] at hb1 hb2
  -- `3 (t' − t) ∈ (−1, 1)` and `3 (t' − t) = 3 y + 3 n` with `3 y ∈ [1, 2]`: no integer `n` fits
  have hn1 : (n : ℝ) < 0 := by linarith
  have hn2 : (-1 : ℝ) < n := by linarith
  have hn1' : n < 0 := by exact_mod_cast hn1
  have hn2' : -1 < n := by exact_mod_cast hn2
  omega

/-- **The circular colouring** of a character `θ`: `x ↦ ⌊3·{θ(x)}⌋ mod 3`. -/
noncomputable def circular (θ : A →+ UnitAddCircle) (x : A) : ZMod 3 := ((⌊3 * rep01 (θ x)⌋ : ℤ) : ZMod 3)

/-- **The circular colouring changes along a band step**: two points of `[0, 1)` in one third differ by less than `1/3`. -/
theorem circular_add_ne (θ : A →+ UnitAddCircle) {u : A} (hu : θ u ∈ band 3) (x : A) :
    circular θ (x + u) ≠ circular θ x := by
  obtain ⟨y, hy, hyu⟩ := hu
  change ((y : ℝ) : UnitAddCircle) = θ u at hyu
  rw [Nat.cast_ofNat] at hy
  obtain ⟨hy1, hy2⟩ := hy
  have hcoe : ((rep01 (θ (x + u)) - rep01 (θ x) - y : ℝ) : UnitAddCircle) = 0 := by
    rw [AddCircle.coe_sub, AddCircle.coe_sub, coe_rep01, coe_rep01, hyu, map_add]
    abel
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff 1).mp hcoe
  rw [zsmul_eq_mul, mul_one] at hn
  exact floor_three_ne (rep01_mem _) (rep01_mem _) (by linarith) (by linarith) hn

/-- The circular colouring of a band character, as a colouring of `addCayley S`. -/
noncomputable def circularColoring (θ : A →+ UnitAddCircle) (hθ : θ ∈ bandSet S (band 3)) :
    (addCayley S).Coloring (Fin 3) :=
  addCayleyColoring (circular θ) fun u hu x => circular_add_ne θ (hθ u hu) x

/-- The circular colouring is periodic under the kernel of its character. -/
theorem ker_le_periods_circularColoring (θ : A →+ UnitAddCircle) (hθ : θ ∈ bandSet S (band 3)) :
    θ.ker ≤ periods (circularColoring θ hθ) := by
  intro d hd x
  change circular θ (x + d) = circular θ x
  rw [AddMonoidHom.mem_ker] at hd
  unfold circular
  rw [map_add, hd, add_zero]

/-- **A colouring changes along every step**: the bridge from `addCayley S` to the held forward half. -/
theorem coloring_add_ne (hS : (0 : A) ∉ S) (C : (addCayley S).Coloring (Fin 3)) (a : A) {u : A} (hu : u ∈ S) :
    (C (a + u) : ZMod 3) ≠ C a := by
  have hu0 : u ≠ 0 := fun h => hS (h ▸ hu)
  have hadj : (addCayley S).Adj a (a + u) :=
    (addCayley_adj' _ _ _).mpr ⟨fun h => hu0 (by simpa using h), u, hu, Or.inl rfl⟩
  exact fun h => C.valid hadj h.symm

/-- **The three-colour criterion, character form (FS73-T22), every abelian group and every set of steps.** -/
theorem colorable_three_iff_bandSet_nonempty (hS : (0 : A) ∉ S) :
    (addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty :=
  ⟨fun ⟨C⟩ => bandSet_three_nonempty_of_proper (c := fun a => (C a : ZMod 3)) fun a _ hu => coloring_add_ne hS C a hu,
    fun ⟨θ, hθ⟩ => ⟨circularColoring θ hθ⟩⟩

/-! ## §3 The periodic form -/

/-- **A character of finite order has a kernel of finite index**: its range lies in the finite `N`-torsion of `ℝ/ℤ`. -/
theorem finiteIndex_ker_of_nsmul_eq_zero {θ : A →+ UnitAddCircle} {N : ℕ} (hN : N ≠ 0) (h : N • θ = 0) :
    θ.ker.FiniteIndex := by
  haveI : Finite θ.range := by
    have hfin := AddCircle.finite_torsion (1 : ℝ) (Nat.pos_of_ne_zero hN)
    refine Set.Finite.to_subtype (hfin.subset fun t ht => ?_)
    obtain ⟨a, rfl⟩ := AddMonoidHom.mem_range.mp ht
    have := DFunLike.congr_fun h a
    rw [AddMonoidHom.nsmul_apply, AddMonoidHom.zero_apply] at this
    exact this
  exact AddSubgroup.finiteIndex_ker θ

/-- **The band set over finitely many steps of a finitely generated group has a point of finite order** (FS73-T22's
"rational vertex"; `plans/FS131-KTC1-three-colour-plan.md` § 2.1, R2). Route: lift `θ` on a generating family that lists `S`
first, keep the box faces the lift lies on, `exists_rat_solution_near`, then `exists_character_of_box_point`. -/
theorem exists_torsion_mem_bandSet [AddGroup.FG A] (hSfin : S.Finite) (h : (bandSet S (band 3)).Nonempty) :
    ∃ θ ∈ bandSet S (band 3), ∃ N : ℕ, N ≠ 0 ∧ N • θ = 0 := by
  classical
  obtain ⟨θ₀, hθ₀⟩ := h
  obtain ⟨G₀, hG₀, hG₀fin⟩ := AddGroup.fg_iff.mp (inferInstance : AddGroup.FG A)
  -- a finite family `f` listing the steps and a generating set
  let T : Finset A := hSfin.toFinset ∪ hG₀fin.toFinset
  let n := T.card
  let f : Fin n → A := fun j => (T.equivFin.symm j : A)
  have hfT : ∀ a ∈ T, ∃ j, f j = a := fun a ha => ⟨T.equivFin ⟨a, ha⟩, by simp [f]⟩
  have hgen : AddSubgroup.closure (Set.range f) = ⊤ := by
    rw [eq_top_iff, ← hG₀]
    refine AddSubgroup.closure_mono fun a ha => ?_
    obtain ⟨j, hj⟩ := hfT a (Finset.mem_union_right _ (hG₀fin.mem_toFinset.mpr ha))
    exact ⟨j, hj⟩
  -- real lifts of `θ₀` on the family: in the band at the steps
  have hlift : ∀ j, ∃ y : ℝ, (y : UnitAddCircle) = θ₀ (f j) ∧ (f j ∈ S → y ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) := by
    intro j
    by_cases hj : f j ∈ S
    · obtain ⟨y, hy, hyθ⟩ := hθ₀ (f j) hj
      refine ⟨y, hyθ, fun _ => ?_⟩
      rw [Nat.cast_ofNat] at hy
      exact ⟨hy.1, by linarith [hy.2]⟩
    · exact ⟨rep01 (θ₀ (f j)), coe_rep01 _, fun h => absurd h hj⟩
  choose x hxθ hxS using hlift
  -- the lift is integral on every relation of the family
  have hint : ∀ r : (relMap f).ker, ∃ z : ℤ, ∑ j, (((r : Fin n → ℤ) j : ℤ) : ℝ) * x j = (z : ℝ) := by
    intro r
    have h0 : θ₀ (relMap f r) = 0 := by rw [AddMonoidHom.mem_ker.mp r.2, map_zero]
    have h1 : θ₀ (relMap f r) = mk1 (∑ j, (((r : Fin n → ℤ) j : ℤ) : ℝ) * x j) := by
      -- `relMap` read by unfolding (a `simp [relMap]` would mint `relMap.eq_1` here)
      change θ₀ (∑ j, (r : Fin n → ℤ) j • f j) = _
      simp only [map_sum, map_zsmul, ← zsmul_eq_mul, mk1_apply, ← hxθ]
    obtain ⟨z, hz⟩ := (AddCircle.coe_eq_zero_iff 1).mp (h1 ▸ h0 : mk1 _ = 0)
    exact ⟨z, by rw [← hz, zsmul_eq_mul, mul_one]⟩
  -- finitely many relations generate them all
  obtain ⟨m, g, hg⟩ := Submodule.fg_iff_exists_fin_generating_family.mp
    (IsNoetherian.noetherian (AddSubgroup.toIntSubmodule (relMap f).ker))
  have hgK : ∀ i, g i ∈ (relMap f).ker := fun i =>
    show g i ∈ AddSubgroup.toIntSubmodule (relMap f).ker from hg ▸ Submodule.subset_span ⟨i, rfl⟩
  choose z hz using fun i => hint ⟨g i, hgK i⟩
  -- the faces of the box the lift lies on, held fixed
  let face : Fin n → Prop := fun j => f j ∈ S ∧ (x j = 1 / 3 ∨ x j = 2 / 3)
  let vq : {j // face j} → ℚ := fun j => if x j.1 = 1 / 3 then 1 / 3 else 2 / 3
  have hvq : ∀ j : {j // face j}, ((vq j : ℚ) : ℝ) = x j.1 := by
    rintro ⟨j, -, hj | hj⟩
    · simp [vq, hj]
    · have : x j ≠ 1 / 3 := by rw [hj]; norm_num
      simp only [vq]
      rw [if_neg this, hj]
      norm_num
  let Gs : Fin m ⊕ {j // face j} → Fin n → ℚ :=
    Sum.elim (fun i j => ((g i j : ℤ) : ℚ)) (fun j' j => if j = j'.1 then 1 else 0)
  let bs : Fin m ⊕ {j // face j} → ℚ := Sum.elim (fun i => ((z i : ℤ) : ℚ)) vq
  have hsys : ∀ k, ∑ j, ((Gs k j : ℚ) : ℝ) * x j = ((bs k : ℚ) : ℝ) := by
    rintro (i | j')
    · simpa [Gs, bs] using hz i
    · simp only [Gs, bs, Sum.elim_inr]
      rw [Finset.sum_eq_single j'.1 (fun j _ hj => by rw [if_neg hj, Rat.cast_zero, zero_mul]) (by simp),
        if_pos rfl, Rat.cast_one, one_mul, hvq]
  -- the margin of the lift inside the open band, off the faces
  obtain ⟨ε, hε, hεx⟩ : ∃ ε : ℝ, 0 < ε ∧
      ∀ j, f j ∈ S → ¬ face j → ε ≤ x j - 1 / 3 ∧ ε ≤ 2 / 3 - x j := by
    let δ : Fin n → ℝ := fun j => if f j ∈ S ∧ ¬ face j then min (x j - 1 / 3) (2 / 3 - x j) else 1
    have hδ : ∀ j, 0 < δ j := fun j => by
      by_cases hj : f j ∈ S ∧ ¬ face j
      · have h1 := hxS j hj.1
        have h2 : x j ≠ 1 / 3 := fun he => hj.2 ⟨hj.1, Or.inl he⟩
        have h3 : x j ≠ 2 / 3 := fun he => hj.2 ⟨hj.1, Or.inr he⟩
        simp only [δ, if_pos hj]
        exact lt_min (by linarith [lt_of_le_of_ne h1.1 (Ne.symm h2)]) (by linarith [lt_of_le_of_ne h1.2 h3])
      · simp only [δ, if_neg hj]; exact one_pos
    obtain ⟨ε, hε, hεδ⟩ := exists_pos_le δ hδ
    refine ⟨ε, hε, fun j hjS hjf => ?_⟩
    have := hεδ j
    simp only [δ, if_pos (And.intro hjS hjf)] at this
    exact ⟨this.trans (min_le_left _ _), this.trans (min_le_right _ _)⟩
  -- a rational solution near the lift
  obtain ⟨q, hq, hqx⟩ := exists_rat_solution_near Gs bs hsys hε
  have hqg : ∀ i, ∑ j, ((g i j : ℤ) : ℝ) * ((q j : ℚ) : ℝ) = ((z i : ℤ) : ℝ) := fun i => by
    have h := hq (Sum.inl i)
    simp only [Gs, bs, Sum.elim_inl] at h
    exact_mod_cast h
  have hband : ∀ j, f j ∈ S → ((q j : ℚ) : ℝ) ∈ Set.Icc (1 / 3 : ℝ) (2 / 3) := by
    intro j hjS
    by_cases hjf : face j
    · have h := hq (Sum.inr ⟨j, hjf⟩)
      simp only [Gs, bs, Sum.elim_inr, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ,
        if_true] at h
      rw [h, hvq ⟨j, hjf⟩]
      exact hxS j hjS
    · obtain ⟨h1, h2⟩ := hεx j hjS hjf
      have h3 := abs_lt.mp (hqx j)
      exact ⟨by linarith [h3.1], by linarith [h3.2]⟩
  -- the character of the rational point
  obtain ⟨θ, hθ⟩ := exists_character_of_box_point f (x := fun j => ((q j : ℚ) : ℝ)) fun r => by
    have hr : (r : Fin n → ℤ) ∈ Submodule.span ℤ (Set.range g) := hg ▸ r.2
    obtain ⟨N, hN⟩ := (Submodule.mem_span_range_iff_exists_fun ℤ).mp hr
    refine ⟨∑ i, N i * z i, ?_⟩
    rw [← hN]
    simp only [Finset.sum_apply, Pi.smul_apply, smul_eq_mul, Int.cast_sum, Int.cast_mul, Finset.sum_mul]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← hqg i, Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  refine ⟨θ, fun u hu => ?_, ∏ j, (q j).den, Finset.prod_ne_zero_iff.mpr fun j _ => (q j).den_ne_zero, ?_⟩
  · obtain ⟨j, rfl⟩ := hfT u (Finset.mem_union_left _ (hSfin.mem_toFinset.mpr hu))
    rw [hθ j]
    have h := hband j hu
    exact ⟨(q j : ℝ), by rw [Nat.cast_ofNat]; exact ⟨h.1, by linarith [h.2]⟩, rfl⟩
  · -- `N • θ` vanishes on the family, which generates `A`
    rw [← AddMonoidHom.ker_eq_top_iff, eq_top_iff, ← hgen, AddSubgroup.closure_le]
    rintro _ ⟨j, rfl⟩
    rw [SetLike.mem_coe, AddMonoidHom.mem_ker, AddMonoidHom.nsmul_apply, hθ j, ← AddCircle.coe_nsmul,
      AddCircle.coe_eq_zero_iff]
    obtain ⟨e, he⟩ : (q j).den ∣ ∏ j, (q j).den := Finset.dvd_prod_of_mem _ (Finset.mem_univ j)
    refine ⟨(q j).num * e, ?_⟩
    have hden : ((q j).den : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (q j).den_ne_zero
    rw [he, nsmul_eq_mul, zsmul_eq_mul, mul_one, Rat.cast_def]
    push_cast
    field_simp

/-- **The three-colour criterion, periodic form**: a finitely generated abelian group with finitely many steps. (`0 ∈ S` is
harmless here: `addCayley (S \ {0}) = addCayley S`, `SimpleGraph.addCayley_erase_zero`.) -/
theorem colorable_three_iff_exists_isPeriodic [AddGroup.FG A] (hSfin : S.Finite) :
    (addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C := by
  refine ⟨fun hcol => ?_, fun ⟨C, _⟩ => ⟨C⟩⟩
  -- the graph ignores the step `0`
  have heq := addCayley_erase_zero S
  have hcol' : (addCayley (S \ {0})).Colorable 3 := heq ▸ hcol
  have h0 : (0 : A) ∉ S \ {0} := fun h => h.2 rfl
  obtain ⟨θ, hθ, N, hN, hNθ⟩ :=
    exists_torsion_mem_bandSet (hSfin.subset fun _ hx => hx.1) ((colorable_three_iff_bandSet_nonempty h0).mp hcol')
  refine ⟨(circularColoring θ hθ).comp (SimpleGraph.Hom.ofLE heq.ge), ?_⟩
  haveI := finiteIndex_ker_of_nsmul_eq_zero hN hNθ
  exact AddSubgroup.finiteIndex_of_le fun d hd x => ker_le_periods_circularColoring θ hθ hd x

/-! ## §4 The control: finite generation is needed -/

/-- Over `ℚ` with the step `1` the Cayley graph is 3-colourable (the character `x ↦ x/2`). -/
theorem colorable_three_rat : (addCayley ({1} : Set ℚ)).Colorable 3 := by
  refine (colorable_three_iff_bandSet_nonempty (by norm_num)).mpr
    ⟨mk1.comp ((AddMonoidHom.mulLeft (1 / 2 : ℝ)).comp (Rat.castHom ℝ).toAddMonoidHom), fun u hu => ?_⟩
  rw [Set.mem_singleton_iff] at hu
  subst hu
  refine ⟨1 / 2, ⟨by norm_num, by norm_num⟩, ?_⟩
  simp

/-- **No 3-colouring of `addCayley {1}` over `ℚ` is periodic**: `ℚ` is divisible, so its only subgroup of finite index is
`ℚ` itself, and a colouring with every period is constant. With `colorable_three_rat`, the periodic form fails without
finite generation. -/
theorem not_isPeriodic_rat (C : (addCayley ({1} : Set ℚ)).Coloring (Fin 3)) : ¬ IsPeriodic C := by
  intro hC
  haveI : (periods C).FiniteIndex := hC
  -- a subgroup of finite index of the divisible group `ℚ` is `ℚ`
  have htop : ∀ q : ℚ, q ∈ periods C := fun q => by
    have hi : ((periods C).index : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr AddSubgroup.FiniteIndex.index_ne_zero
    have h := (periods C).nsmul_index_mem (q / (periods C).index)
    rwa [nsmul_eq_mul, mul_div_cancel₀ _ hi] at h
  have h1 : C (0 + 1) = C 0 := mem_periods.mp (htop 1) 0
  have hadj : (addCayley ({1} : Set ℚ)).Adj 0 (0 + 1) :=
    (addCayley_adj' _ _ _).mpr ⟨by norm_num, 1, rfl, Or.inl rfl⟩
  exact C.valid hadj h1.symm

/-! ## §5 Row 79's class -/

/-- **Row 79, as an instance**: for a finitely generated torsion-free abelian group and a finite symmetric generating set
of steps without `0`, three-colourable ⟺ a character puts every step in `[1/3, 2/3]` ⟺ periodically three-colourable. -/
theorem colorable_three_iff_of_fg_torsionFree [AddGroup.FG A] [_htf : IsAddTorsionFree A] (hSfin : S.Finite) (_hsymm : -S = S)
    (_hgen : AddSubgroup.closure S = ⊤) (hS : (0 : A) ∉ S) :
    ((addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty) ∧
      ((addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C) :=
  ⟨colorable_three_iff_bandSet_nonempty hS, colorable_three_iff_exists_isPeriodic hSfin⟩

/-! ## Spec -/

-- `rep01` drifts if its interval moves: `1/2 ↦ 1/2`.
example : rep01 ((1 / 2 : ℝ) : UnitAddCircle) = 1 / 2 := rep01_coe ⟨by norm_num, by norm_num⟩

-- The circular colouring of `x ↦ x/3` on `ℤ` is `x mod 3` at `1`.
example : circular (mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))) 1 = 1 := by
  have h : (mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))) 1 = ((1 / 3 : ℝ) : UnitAddCircle) := by
    simp
  rw [circular, h, rep01_coe ⟨by norm_num, by norm_num⟩, show (3 : ℝ) * (1 / 3) = 1 by norm_num, Int.floor_one]
  rfl

end HadwigerNelson.CayleyThree
