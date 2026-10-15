import Proofs.HadwigerNelson.Arith.RatioBound

/-!
# The fibre-share inequality on a Cayley graph over a finite abelian group with a quotient (FS131-IKL1)

**Read aloud, against FS-66's `data/fs66/b1/SOUNDNESS.md` § 2 (L2).** `G` and `H` are finite abelian groups and
`π : G → H` is a surjective homomorphism; `S ⊆ G` and `T ⊆ H` are finite sets. Two facts about them are taken as
hypotheses:

* *Hensel's count*: `π` carries `S` into `T`, and every point of `T` has exactly `c` points of `S` over it;
* *L1, the bound on new characters*: every character `ψ` of `G` that is not trivial on the kernel of `π` has
  `Re Σ_{s ∈ S} ψ(s) ≥ −2c`.

Let `I ⊆ G` have no difference in `S`, and let `n(y) = |I ∩ π⁻¹(y)|` be its fibre counts. Then
`fibreShare_le`:

  `c·|H|·Σ_y Σ_{t ∈ T} n(y)·n(y + t) ≤ 2c·(|G|·|I| − |H|·Σ_y n(y)²)`.

With `K = |G|/|H|` the size of a fibre (`card_fibre_mul`) and `φ(y) = n(y)/K`, it is `q(φ) ≥ 0` for
`q(φ) = 2·Σ_y φ(y)(1 − φ(y)) − Σ_y Σ_{t ∈ T} φ(y)·φ(y + t)`, which is FS-66's L2.

**The proof** is SOUNDNESS § 2 in characters, with no adjacency operator: for the indicator `f` of `I`,
`Σ_ψ |f̂(ψ)|²·Re λ_ψ = 0` (no difference of `I` in `S`; `RatioBound.sum_fourier_sq_mul_charSum_eq_zero`). The characters
trivial on the kernel are the `χ ∘ π` (`exists_eq_compAddMonoidHom`). For each such character `f̂(χ ∘ π)` is the
transform of `n` on `H`, and `λ_{χ∘π} = c·Σ_{t ∈ T} χ(t)`; their part of the sum is `c·|H|·Σ_y Σ_t n(y)·n(y + t)`
(`sum_weighted_sq_mul_charSum`). The rest is at least `−2c` times its Parseval mass, `|G|·|I| − |H|·Σ_y n(y)²`.

**Model.** `fibreShare_le_model`: `G = H = ZMod 2`, `π` the identity, `S = T = {1}`, `c = 1`, `I = {0}`. Every
hypothesis holds; L1 holds vacuously, since `π` has trivial kernel.
-/

namespace HadwigerNelson.FibreShare

open Finset

variable {G H : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G] [AddCommGroup H] [Fintype H] [DecidableEq H]

/-- The number of points of `I` in the fibre of `π` over `y`. -/
def fibreCount (π : G →+ H) (I : Finset G) (y : H) : ℕ := (I.filter fun x => π x = y).card

omit [Fintype G] [DecidableEq G] [Fintype H] [DecidableEq H] in
/-- **Descent**: a character of `G` trivial on the kernel of a surjective `π` is a character of `H` composed with `π`. -/
theorem exists_eq_compAddMonoidHom (π : G →+ H) (hπ : Function.Surjective π) (ψ : AddChar G ℂ)
    (hψ : ∀ e, π e = 0 → ψ e = 1) : ∃ χ : AddChar H ℂ, χ.compAddMonoidHom π = ψ := by
  have hs : ∀ y, π (Function.surjInv hπ y) = y := Function.surjInv_eq hπ
  have hker : ∀ x x', π x = π x' → ψ x = ψ x' := by
    intro x x' h
    have h0 : π (x - x') = 0 := by rw [map_sub, h, sub_self]
    calc ψ x = ψ (x - x' + x') := by rw [sub_add_cancel]
      _ = ψ (x - x') * ψ x' := AddChar.map_add_eq_mul ψ _ _
      _ = ψ x' := by rw [hψ _ h0, one_mul]
  refine ⟨{ toFun := fun y => ψ (Function.surjInv hπ y), map_zero_eq_one' := ?_, map_add_eq_mul' := ?_ }, ?_⟩
  · show ψ (Function.surjInv hπ 0) = 1
    rw [hker _ 0 (by rw [hs, map_zero]), AddChar.map_zero_eq_one]
  · intro a b
    show ψ (Function.surjInv hπ (a + b)) = ψ (Function.surjInv hπ a) * ψ (Function.surjInv hπ b)
    rw [hker _ (Function.surjInv hπ a + Function.surjInv hπ b) (by rw [hs, map_add, hs, hs]),
      AddChar.map_add_eq_mul]
  · ext x
    show ψ (Function.surjInv hπ (π x)) = ψ x
    exact hker _ _ (hs _)

omit [DecidableEq G] in
/-- **A fibre has `|G|/|H|` points**: every fibre of a surjective homomorphism is a translate of every other. -/
theorem card_fibre_mul (π : G →+ H) (hπ : Function.Surjective π) (y : H) :
    (univ.filter fun x => π x = y).card * Fintype.card H = Fintype.card G := by
  classical
  obtain ⟨x₀, hx₀⟩ := hπ y
  have heq : ∀ y', (univ.filter fun x => π x = y').card = (univ.filter fun x => π x = y).card := by
    intro y'
    obtain ⟨x₁, hx₁⟩ := hπ y'
    refine card_nbij' (fun x => x - (x₁ - x₀)) (fun x => x + (x₁ - x₀)) ?_ ?_ ?_ ?_
    · intro x hx
      rw [coe_filter, Set.mem_setOf_eq] at hx ⊢
      exact ⟨mem_univ _, by rw [map_sub, map_sub, hx.2, hx₁, hx₀]; abel⟩
    · intro x hx
      rw [coe_filter, Set.mem_setOf_eq] at hx ⊢
      exact ⟨mem_univ _, by rw [map_add, map_sub, hx.2, hx₁, hx₀]; abel⟩
    · intro x _
      show x - (x₁ - x₀) + (x₁ - x₀) = x
      abel
    · intro x _
      show x + (x₁ - x₀) - (x₁ - x₀) = x
      abel
  calc (univ.filter fun x => π x = y).card * Fintype.card H
      = ∑ y' : H, (univ.filter fun x => π x = y').card := by
        rw [sum_congr rfl fun y' _ => heq y', sum_const, smul_eq_mul, card_univ, mul_comm]
    _ = Fintype.card G := by
        rw [← card_eq_sum_card_fiberwise (f := π) (s := univ) (t := univ) (fun _ _ => mem_univ _), card_univ]

/-- **The weighted triple sum on `H`**: for real weights `a`,
`Σ_χ â(χ)·conj â(χ)·Σ_{t ∈ T} χ(t) = |H|·Σ_u Σ_{t ∈ T} a(u)·a(u + t)`, with `â(χ) = Σ_u a(u)·χ(u)`. -/
theorem sum_weighted_sq_mul_charSum (a : H → ℝ) (T : Finset H) :
    ∑ χ : AddChar H ℂ, (∑ u, (a u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (a u : ℂ) * χ u) * ∑ t ∈ T, χ t =
      (Fintype.card H : ℂ) * ∑ u, ∑ t ∈ T, ((a u * a (u + t) : ℝ) : ℂ) := by
  have h1 : ∀ χ : AddChar H ℂ, (∑ u, (a u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (a u : ℂ) * χ u) * ∑ t ∈ T, χ t =
      ∑ u, ∑ v, ∑ t ∈ T, ((a u * a v : ℝ) : ℂ) * χ (u - v + t) := by
    intro χ
    rw [map_sum, sum_mul_sum, sum_mul]
    refine sum_congr rfl fun u _ => ?_
    rw [sum_mul]
    refine sum_congr rfl fun v _ => ?_
    rw [mul_sum]
    refine sum_congr rfl fun t _ => ?_
    rw [map_mul, Complex.conj_ofReal, ← AddChar.map_neg_eq_conj, sub_eq_add_neg, AddChar.map_add_eq_mul,
      AddChar.map_add_eq_mul]
    push_cast
    ring
  calc ∑ χ : AddChar H ℂ, (∑ u, (a u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (a u : ℂ) * χ u) * ∑ t ∈ T, χ t
      = ∑ χ : AddChar H ℂ, ∑ u, ∑ v, ∑ t ∈ T, ((a u * a v : ℝ) : ℂ) * χ (u - v + t) :=
        sum_congr rfl fun χ _ => h1 χ
    _ = ∑ u, ∑ v, ∑ t ∈ T, ((a u * a v : ℝ) : ℂ) * ∑ χ : AddChar H ℂ, χ (u - v + t) := by
        rw [sum_comm]
        refine sum_congr rfl fun u _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun v _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun t _ => ?_
        rw [mul_sum]
    _ = ∑ u, ∑ t ∈ T, ∑ v, ((a u * a v : ℝ) : ℂ) * (if u - v + t = 0 then (Fintype.card H : ℂ) else 0) := by
        refine sum_congr rfl fun u _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun t _ => sum_congr rfl fun v _ => ?_
        rw [AddChar.sum_apply_eq_ite]
    _ = (Fintype.card H : ℂ) * ∑ u, ∑ t ∈ T, ((a u * a (u + t) : ℝ) : ℂ) := by
        rw [mul_sum]
        refine sum_congr rfl fun u _ => ?_
        rw [mul_sum]
        refine sum_congr rfl fun t _ => ?_
        rw [sum_eq_single (u + t)]
        · rw [if_pos (by abel)]
          ring
        · intro v _ hv
          rw [if_neg, mul_zero]
          intro h
          exact hv (eq_of_sub_eq_zero (by rw [show v - (u + t) = -(u - v + t) by abel, h, neg_zero]))
        · intro h
          exact absurd (mem_univ _) h

/-- **Parseval for weights on `H`**: `Σ_χ |â(χ)|² = |H|·Σ_u a(u)²`. -/
theorem sum_weighted_sq (a : H → ℝ) :
    ∑ χ : AddChar H ℂ, (∑ u, (a u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (a u : ℂ) * χ u) =
      (Fintype.card H : ℂ) * ∑ u, ((a u * a u : ℝ) : ℂ) := by
  have h := sum_weighted_sq_mul_charSum a {0}
  simp only [sum_singleton, AddChar.map_zero_eq_one, mul_one, add_zero] at h
  exact h

/-- **The fibre-share inequality** (FS-66's L2, in the abstract; the module docstring reads it aloud). -/
theorem fibreShare_le (π : G →+ H) (hπ : Function.Surjective π) (S : Finset G) (T : Finset H) (c : ℕ)
    (hST : ∀ s ∈ S, π s ∈ T) (hfib : ∀ t ∈ T, (S.filter fun s => π s = t).card = c)
    (hL : ∀ ψ : AddChar G ℂ, (∃ e, π e = 0 ∧ ψ e ≠ 1) → -(2 * (c : ℝ)) ≤ (∑ s ∈ S, ψ s).re)
    (I : Finset G) (hI : ∀ x ∈ I, ∀ y ∈ I, x - y ∉ S) :
    (c : ℝ) * Fintype.card H * ∑ u, ∑ t ∈ T, (fibreCount π I u : ℝ) * fibreCount π I (u + t) ≤
      2 * c * (Fintype.card G * I.card - Fintype.card H * ∑ u, (fibreCount π I u : ℝ) ^ 2) := by
  set n : H → ℝ := fun u => (fibreCount π I u : ℝ) with hn
  -- the transform of `I` at `χ ∘ π` is the transform of the fibre counts at `χ`
  have hsumI : ∀ χ : AddChar H ℂ, ∑ x ∈ I, χ (π x) = ∑ u, (n u : ℂ) * χ u := by
    intro χ
    rw [← sum_fiberwise' I π χ]
    refine sum_congr rfl fun u _ => ?_
    rw [sum_const, nsmul_eq_mul, hn]
    simp only [fibreCount, Complex.ofReal_natCast]
  -- the eigenvalue at `χ ∘ π` is `c` times the eigenvalue of `T` at `χ` (Hensel's count)
  have hsumS : ∀ χ : AddChar H ℂ, ∑ s ∈ S, χ (π s) = (c : ℂ) * ∑ t ∈ T, χ t := by
    intro χ
    rw [← sum_fiberwise_of_maps_to' hST χ, mul_sum]
    refine sum_congr rfl fun t ht => ?_
    rw [sum_const, hfib t ht, nsmul_eq_mul]
  -- the weights `N ψ = |f̂(ψ)|²` and the real parts `L ψ = Re λ_ψ`
  set N : AddChar G ℂ → ℝ := fun ψ => Complex.normSq (∑ x ∈ I, ψ x) with hN
  set L : AddChar G ℂ → ℝ := fun ψ => (∑ s ∈ S, ψ s).re with hL'
  have hA : ∑ ψ : AddChar G ℂ, N ψ * L ψ = 0 := by
    have h := congrArg Complex.re (RatioBound.sum_fourier_sq_mul_charSum_eq_zero S I hI)
    rw [Complex.re_sum, Complex.zero_re] at h
    rw [← h]
    refine sum_congr rfl fun ψ _ => ?_
    rw [Complex.mul_conj, Complex.re_ofReal_mul]
  have hB : ∑ ψ : AddChar G ℂ, N ψ = Fintype.card G * I.card := by
    have h := congrArg Complex.re (RatioBound.sum_fourier_sq I)
    rw [Complex.re_sum] at h
    have h2 : ((Fintype.card G : ℂ) * (I.card : ℂ)).re = (Fintype.card G : ℝ) * I.card := by
      rw [← Nat.cast_mul, Complex.natCast_re, Nat.cast_mul]
    rw [h2] at h
    rw [← h]
    refine sum_congr rfl fun ψ _ => ?_
    rw [Complex.mul_conj, Complex.ofReal_re]
  -- the characters trivial on the kernel: the image of `χ ↦ χ ∘ π`
  obtain ⟨img, himg⟩ : ∃ img : Finset (AddChar G ℂ),
      img = (univ : Finset (AddChar H ℂ)).image fun χ => χ.compAddMonoidHom π := ⟨_, rfl⟩
  have hinj : Set.InjOn (fun χ : AddChar H ℂ => χ.compAddMonoidHom π) (univ : Finset (AddChar H ℂ)) :=
    (AddChar.compAddMonoidHom_injective_left π hπ).injOn
  have hsplit : ∀ f : AddChar G ℂ → ℝ, ∑ ψ, f ψ = ∑ χ : AddChar H ℂ, f (χ.compAddMonoidHom π) +
      ∑ ψ ∈ univ \ img, f ψ := by
    intro f
    rw [← sum_sdiff (subset_univ img), himg, sum_image hinj, add_comm]
  have hNimg : ∀ χ : AddChar H ℂ, ((N (χ.compAddMonoidHom π) : ℝ) : ℂ) =
      (∑ u, (n u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (n u : ℂ) * χ u) := by
    intro χ
    rw [Complex.mul_conj]
    show ((Complex.normSq (∑ x ∈ I, χ (π x)) : ℝ) : ℂ) = _
    rw [hsumI]
  -- the part trivial on the kernel
  have himgA : ∑ χ : AddChar H ℂ, N (χ.compAddMonoidHom π) * L (χ.compAddMonoidHom π) =
      c * Fintype.card H * ∑ u, ∑ t ∈ T, n u * n (u + t) := by
    have h := congrArg Complex.re (sum_weighted_sq_mul_charSum n T)
    have e : ∀ χ : AddChar H ℂ, N (χ.compAddMonoidHom π) * L (χ.compAddMonoidHom π) =
        (c : ℝ) * ((∑ u, (n u : ℂ) * χ u) * (starRingEnd ℂ) (∑ u, (n u : ℂ) * χ u) * ∑ t ∈ T, χ t).re := by
      intro χ
      rw [← hNimg, Complex.re_ofReal_mul]
      show N (χ.compAddMonoidHom π) * (∑ s ∈ S, χ (π s)).re = _
      rw [hsumS, ← Complex.ofReal_natCast, Complex.re_ofReal_mul]
      ring
    rw [sum_congr rfl fun χ _ => e χ, ← mul_sum, ← Complex.re_sum, h]
    rw [← Complex.ofReal_natCast, Complex.re_ofReal_mul]
    simp only [← Complex.ofReal_sum, Complex.ofReal_re]
    ring
  have himgB : ∑ χ : AddChar H ℂ, N (χ.compAddMonoidHom π) = Fintype.card H * ∑ u, n u ^ 2 := by
    have h := congrArg Complex.re (sum_weighted_sq n)
    rw [Complex.re_sum] at h
    rw [sum_congr rfl fun χ _ => (Complex.ofReal_re (N (χ.compAddMonoidHom π))).symm]
    simp only [hNimg]
    rw [h, ← Complex.ofReal_natCast, Complex.re_ofReal_mul]
    simp only [← Complex.ofReal_sum, Complex.ofReal_re, sq]
  -- the rest: L1
  have hrest : ∀ ψ ∈ univ \ img, -(2 * (c : ℝ)) * N ψ ≤ N ψ * L ψ := by
    intro ψ hψ
    have hnot : ∃ e, π e = 0 ∧ ψ e ≠ 1 := by
      by_contra hcon
      push Not at hcon
      obtain ⟨χ, hχ⟩ := exists_eq_compAddMonoidHom π hπ ψ hcon
      exact (mem_sdiff.1 hψ).2 (by rw [himg]; exact mem_image.2 ⟨χ, mem_univ _, hχ⟩)
    have hl := hL ψ hnot
    have hN0 : 0 ≤ N ψ := Complex.normSq_nonneg _
    have hm := mul_le_mul_of_nonneg_left hl hN0
    show _ ≤ N ψ * (∑ s ∈ S, ψ s).re
    linarith
  have hrestB : ∑ ψ ∈ univ \ img, N ψ = Fintype.card G * I.card - Fintype.card H * ∑ u, n u ^ 2 := by
    have h := hsplit N
    rw [hB, himgB] at h
    linarith
  have hlow : -(2 * (c : ℝ)) * ∑ ψ ∈ univ \ img, N ψ ≤ ∑ ψ ∈ univ \ img, N ψ * L ψ := by
    rw [mul_sum]
    exact sum_le_sum hrest
  have htot := hsplit fun ψ => N ψ * L ψ
  rw [hA, himgA] at htot
  rw [hrestB] at hlow
  simp only [hn] at htot hlow ⊢
  linarith

/-- The hypotheses of `fibreShare_le` hold together: `G = H = ZMod 2`, `π` the identity, `S = T = {1}`, `c = 1`, and
`I = {0}`; L1 holds with nothing to check (the kernel is trivial). -/
theorem fibreShare_le_model :
    Function.Surjective (AddMonoidHom.id (ZMod 2)) ∧
    (∀ s ∈ ({1} : Finset (ZMod 2)), AddMonoidHom.id (ZMod 2) s ∈ ({1} : Finset (ZMod 2))) ∧
    (∀ t ∈ ({1} : Finset (ZMod 2)),
      (({1} : Finset (ZMod 2)).filter fun s => AddMonoidHom.id (ZMod 2) s = t).card = 1) ∧
    (∀ ψ : AddChar (ZMod 2) ℂ, (∃ e, AddMonoidHom.id (ZMod 2) e = 0 ∧ ψ e ≠ 1) →
      -(2 * ((1 : ℕ) : ℝ)) ≤ (∑ s ∈ ({1} : Finset (ZMod 2)), ψ s).re) ∧
    (∀ x ∈ ({0} : Finset (ZMod 2)), ∀ y ∈ ({0} : Finset (ZMod 2)), x - y ∉ ({1} : Finset (ZMod 2))) := by
  refine ⟨Function.surjective_id, ?_, ?_, ?_, ?_⟩
  · intro s hs
    exact hs
  · intro t ht
    rw [mem_singleton] at ht
    subst ht
    decide
  · rintro ψ ⟨e, he, hψe⟩
    exact absurd (by rw [show e = 0 from he, AddChar.map_zero_eq_one]) hψe
  · intro x hx y hy
    rw [mem_singleton] at hx hy
    subst hx
    subst hy
    decide

end HadwigerNelson.FibreShare
