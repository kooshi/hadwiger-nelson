import Proofs.HadwigerNelson.PadicPlane.Basic

/-!
# The upper half: `χ_Bor(ℚ_p²) ≤ χ(UD(𝔽_p, 2))` at `p ≡ 3 (mod 4)` (FS131-KPA1, proved by FS131-IQP1)

**Read aloud, against `[Madore2015]` Prop. 3.2 and Rem. 3.6 (pp. 6–7).** Madore: when the residue form is anisotropic, the
map `x ↦ x − ξ_C` on each coset `C` of `ℤ_p²` in `ℚ_p²` (`ξ_C` a chosen point of `C`) is a graph homomorphism
`Γ(ℚ_p²) → Γ(ℤ_p²)`, because every edge joins two points of one coset (unit vectors are integral,
`norm_le_one_of_sq_add_sq_eq_one`); composed with reduction modulo `p` it is a homomorphism to `UD(𝔽_p, 2)`, so
`χ(ℚ_p²) ≤ χ(𝔽_p²)`. Each coset is open, so the map is locally constant and the pulled-back colouring has open classes:
**it is Borel**. The posers prove only `O(p²)` (`[BardestaniMallahiKarai2017]` Lemma 3.3, box colourings).

* `exists_residueMap` — a map `ρ : ℚ_p² → 𝔽_p²` carrying edges to edges, every fibre open.
* `exists_borelColoring_of_colorable` — the Borel colouring itself;
  `borelChromaticNumber_le_of_colorable`, `borelChromaticNumber_le_chromaticNumber` — the upper half.

The construction is Madore's; that it is Borel is the one line above. Prior art in construction.

**Models.** `exists_residueMap` has no hypothesis but `p ≡ 3 (mod 4)`, inhabited at `p = 3` and `7`;
`borelChromaticNumber_le_of_colorable`'s hypothesis is inhabited by every colouring of a finite plane in the library
(`finitePlane3_colorable_three`, `finitePlane7_colorable_four`, `finitePlane11_colorable_five`).
-/

namespace HadwigerNelson.PadicPlane

open SimpleGraph MeasureTheory

variable (p : ℕ) [Fact p.Prime]

/-- **Madore's homomorphism, locally constant** (`[Madore2015]` Prop. 3.2): at `p ≡ 3 (mod 4)` there is a map
`ρ : ℚ_p² → 𝔽_p²` carrying every edge of the p-adic plane to an edge of `UD(𝔽_p, 2)`, each of whose fibres is open. (A
point minus a fixed representative of its coset of `ℤ_p²`, reduced modulo `p`.) -/
theorem exists_residueMap (hp : p % 4 = 3) :
    ∃ ρ : ℚ_[p] × ℚ_[p] → ZMod p × ZMod p,
      (∀ x y, (padicPlane p).Adj x y → (finitePlane p).Adj (ρ x) (ρ y)) ∧ ∀ z, IsOpen (ρ ⁻¹' {z}) := by
  classical
  -- `ℤ_p² ⊂ ℚ_p²` as an additive subgroup, and the inclusion
  set H : AddSubgroup (ℚ_[p] × ℚ_[p]) :=
    (PadicInt.subring p).toAddSubgroup.prod (PadicInt.subring p).toAddSubgroup with hHdef
  have hmemH : ∀ v : ℚ_[p] × ℚ_[p], v ∈ H ↔ ‖v.1‖ ≤ 1 ∧ ‖v.2‖ ≤ 1 := fun v => by
    rw [hHdef, AddSubgroup.mem_prod]
    exact Iff.and (PadicInt.mem_subring_iff p) (PadicInt.mem_subring_iff p)
  set e : ℤ_[p] × ℤ_[p] →+ ℚ_[p] × ℚ_[p] :=
    (PadicInt.Coe.ringHom (p := p)).toAddMonoidHom.prodMap (PadicInt.Coe.ringHom (p := p)).toAddMonoidHom with hedef
  have heapp : ∀ u, e u = ((u.1 : ℚ_[p]), (u.2 : ℚ_[p])) := fun _ => rfl
  have hesurj : ∀ v ∈ H, ∃ u, e u = v := fun v hv =>
    ⟨(⟨v.1, ((hmemH v).1 hv).1⟩, ⟨v.2, ((hmemH v).1 hv).2⟩), by rw [heapp]⟩
  -- a representative of each coset of `ℤ_p²`
  set c : ℚ_[p] × ℚ_[p] → ℚ_[p] × ℚ_[p] := fun x => (QuotientAddGroup.mk x : (ℚ_[p] × ℚ_[p]) ⧸ H).out with hcdef
  have hc : ∀ x, x - c x ∈ H := by
    intro x
    have h := QuotientAddGroup.eq.1 (QuotientAddGroup.out_eq' (QuotientAddGroup.mk x : (ℚ_[p] × ℚ_[p]) ⧸ H))
    rwa [neg_add_eq_sub] at h
  have hc2 : ∀ x y, x - y ∈ H → c x = c y := by
    intro x y hxy
    have h : (QuotientAddGroup.mk x : (ℚ_[p] × ℚ_[p]) ⧸ H) = QuotientAddGroup.mk y :=
      QuotientAddGroup.eq.2 (by rw [neg_add_eq_sub, ← neg_sub]; exact H.neg_mem hxy)
    simp only [hcdef, h]
  -- the point minus its representative, in `ℤ_p²`, and its residue modulo `p`
  choose d hd using fun x => hesurj (x - c x) (hc x)
  set R : ℤ_[p] × ℤ_[p] →+ ZMod p × ZMod p :=
    (PadicInt.toZMod (p := p)).toAddMonoidHom.prodMap (PadicInt.toZMod (p := p)).toAddMonoidHom with hRdef
  have hRapp : ∀ u, R u = (PadicInt.toZMod u.1, PadicInt.toZMod u.2) := fun _ => rfl
  have hdiff : ∀ x y, x - y ∈ H → e (d x - d y) = x - y := by
    intro x y hxy
    rw [map_sub, hd, hd, hc2 x y hxy]
    abel
  refine ⟨fun x => R (d x), fun x y hxy => ?_, fun z => ?_⟩
  · -- an edge stays in one coset (unit vectors are integral) and its difference reduces to a unit vector of `𝔽_p²`
    obtain ⟨-, hxy1⟩ := unitQuadrance_adj.1 hxy
    obtain ⟨h1, h2⟩ := norm_le_one_of_sq_add_sq_eq_one hp hxy1
    have hH : x - y ∈ H := (hmemH _).2 ⟨h1, h2⟩
    set w := d x - d y with hwdef
    have hw : e w = x - y := hdiff x y hH
    have hw1 : w.1 ^ 2 + w.2 ^ 2 = 1 := by
      apply PadicInt.ext
      have h := congrArg (fun v : ℚ_[p] × ℚ_[p] => v.1 ^ 2 + v.2 ^ 2) hw
      simp only [heapp, Prod.fst_sub, Prod.snd_sub] at h
      push_cast
      rw [h]
      exact hxy1
    have hRw : (R w).1 ^ 2 + (R w).2 ^ 2 = 1 := by
      rw [hRapp, ← map_pow, ← map_pow, ← map_add, hw1, map_one]
    have hsub : R (d x) - R (d y) = R w := by rw [hwdef, map_sub]
    rw [finitePlane, unitQuadrance_adj]
    refine ⟨fun h => ?_, ?_⟩
    · have h' : R (d x) = R (d y) := h
      rw [h', sub_self] at hsub
      rw [← hsub] at hRw
      simp at hRw
    · have e1 : (R (d x)).1 - (R (d y)).1 = (R w).1 := by rw [← hsub]; rfl
      have e2 : (R (d x)).2 - (R (d y)).2 = (R w).2 := by rw [← hsub]; rfl
      rw [e1, e2]
      exact hRw
  · -- within distance `1` of a point, the residue does not change
    rw [Metric.isOpen_iff]
    intro x hx
    refine ⟨1, one_pos, fun y hy => ?_⟩
    rw [Metric.mem_ball, Prod.dist_eq, max_lt_iff, dist_eq_norm, dist_eq_norm] at hy
    have hH : y - x ∈ H := (hmemH _).2 ⟨hy.1.le, hy.2.le⟩
    set w := d y - d x with hwdef
    have hw : e w = y - x := hdiff y x hH
    have hw1 : ‖w.1‖ < 1 := by
      have h : (w.1 : ℚ_[p]) = y.1 - x.1 := congrArg Prod.fst ((heapp w).symm.trans hw)
      rw [PadicInt.norm_def, h]
      exact hy.1
    have hw2 : ‖w.2‖ < 1 := by
      have h : (w.2 : ℚ_[p]) = y.2 - x.2 := congrArg Prod.snd ((heapp w).symm.trans hw)
      rw [PadicInt.norm_def, h]
      exact hy.2
    have hz0 : ∀ a : ℤ_[p], ‖a‖ < 1 → PadicInt.toZMod a = 0 := fun a ha => by
      rw [← RingHom.mem_ker, PadicInt.ker_toZMod, IsLocalRing.mem_maximalIdeal, PadicInt.mem_nonunits]
      exact ha
    have hRw : R w = 0 := by rw [hRapp, hz0 _ hw1, hz0 _ hw2]; rfl
    rw [Set.mem_preimage, Set.mem_singleton_iff] at hx ⊢
    rw [← hx, ← sub_eq_zero, ← map_sub, ← hwdef, hRw]

/-- **A Borel colouring of the p-adic plane from one of `UD(𝔽_p, 2)`**: a `k`-colouring of the finite plane, pulled back
along `exists_residueMap`, is a proper `k`-colouring of the p-adic plane whose classes are open, hence Borel. The inhabitant
of every hypothesis that asks for a Borel colouring of the p-adic plane (`PadicPlane/Measure`). -/
theorem exists_borelColoring_of_colorable (hp : p % 4 = 3) {k : ℕ} (h : (finitePlane p).Colorable k) :
    ∃ c : (padicPlane p).Coloring (Fin k), ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑c ⁻¹' {i}) := by
  obtain ⟨ρ, hρ, hopen⟩ := exists_residueMap p hp
  obtain ⟨C⟩ := h
  refine ⟨SimpleGraph.Coloring.mk (fun x => C (ρ x)) fun hxy => C.valid (hρ _ _ hxy), fun i => ?_⟩
  -- each class is a union of open fibres of `ρ`, hence open, hence Borel
  have hO : IsOpen (⇑(SimpleGraph.Coloring.mk (G := padicPlane p) (fun x => C (ρ x))
      fun hxy => C.valid (hρ _ _ hxy)) ⁻¹' {i}) := by
    rw [isOpen_iff_forall_mem_open]
    intro x hx
    refine ⟨ρ ⁻¹' {ρ x}, fun y hy => ?_, hopen (ρ x), rfl⟩
    have hy' : ρ y = ρ x := hy
    have hx' : C (ρ x) = i := hx
    show C (ρ y) = i
    rw [hy', hx']
  exact MeasurableSpace.measurableSet_generateFrom hO

/-- **The upper half**: a `k`-colouring of `UD(𝔽_p, 2)` bounds the Borel chromatic number of the p-adic plane by `k`. -/
theorem borelChromaticNumber_le_of_colorable (hp : p % 4 = 3) {k : ℕ} (h : (finitePlane p).Colorable k) :
    borelChromaticNumber (padicPlane p) ≤ k :=
  let ⟨c, hc⟩ := exists_borelColoring_of_colorable p hp h
  borelChromaticNumber_le_of_coloring c hc

/-- **The upper half, as numbers**: `χ_Bor(ℚ_p²) ≤ χ(UD(𝔽_p, 2))`. -/
theorem borelChromaticNumber_le_chromaticNumber (hp : p % 4 = 3) :
    borelChromaticNumber (padicPlane p) ≤ (finitePlane p).chromaticNumber := by
  have h := SimpleGraph.colorable_chromaticNumber_of_fintype (finitePlane p)
  have hne : (finitePlane p).chromaticNumber ≠ ⊤ := SimpleGraph.chromaticNumber_ne_top_iff_exists.2 ⟨_, h⟩
  calc borelChromaticNumber (padicPlane p) ≤ ((finitePlane p).chromaticNumber.toNat : ℕ∞) :=
        borelChromaticNumber_le_of_colorable p hp h
    _ = (finitePlane p).chromaticNumber := ENat.coe_toNat hne

end HadwigerNelson.PadicPlane
