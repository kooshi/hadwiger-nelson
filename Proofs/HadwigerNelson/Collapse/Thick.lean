import Proofs.HadwigerNelson.Rigidity.CountCompletion

/-!
# Thickness: the mixing constant of every stable place, and of every level of the completion (FS-131, job FS131-KCL1; module C1)

**Read aloud, against the informal claim** (`LEDGER.md` row 128: "every stable place 6-thick (`λ*_v < 1/5` at every level,
both signs)"; D-GV and D-THK (c) of `data/fs103/claims.md` § 0). For a stable prime `P` of `L = F(i)` and a level `m ≥ 1`, the
residue target is the Cayley graph of `𝓞 ⧸ P^m` on its norm-one elements (`Rigidity.Counting.normOneQ`). Its normalised
eigenvalues are the averages of the additive characters over the norm-one set; the **mixing constant** of the place is their
largest modulus over the non-trivial characters and every level. `ThickAt P c` says it is at most `c`; `Thick F c` says so at
every stable prime — **uniformly**, one constant for all.

* `thickAt_weil` — **level one by Weil, every level by Lemma P** (V1-L7; X26B-L1): at a stable prime not above `2` with
  `|𝓞 ⧸ P| = Q²`, the constant `2√Q/(Q + 1)`.
* `thick_of_card` — **the Weil route to uniform thickness**: if no stable prime lies above `2` and every residue size is `Q²`
  with `Q ≥ B`, then `Thick F (2√B/(B + 1))`.
* `thick_of_forall_thickAt` — **row 128's per-place form gives the uniform one**: if every stable prime is `c_P`-thick with
  `c_P < c₀`, one constant below `c₀` serves all (Weil makes the tail small; finitely many primes below any norm).
* `not_isRamified_of_thickAt` — a place thicker than `1` is not ramified (at a ramified stable prime the norm-one residues
  at level one are `{1}`), so a thick field is outside row 100's exception.
* `levelThick` — **from places to the levels of the completion**: the image of `R` at level `k` is a finite group, the image
  of the unit vectors is the product of the norm-one sets (`[S9]`, `image_levR_unitVectors_of_unramified`), and every
  non-trivial character of the level group averages over it to at most `c` in modulus (a character of a subgroup extends,
  `exists_addChar_extend`; a character of a product sums over a product set as the product of the sums,
  `norm_sum_piFinset_le`).

**Models.** `Thick F c` at `c < 1/5` holds at `ℚ(√635087)` (`Collapse/Headline`, `thick_sqrt635087`); it fails at `ℚ`, whose
stable prime above `2` is ramified (`not_thick_bot`). `ThickAt P 1` holds at every `P` (`thickAt_one`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

/-- **`P` is `c`-thick**: at every level `m ≥ 1`, every non-trivial additive character of `𝓞 ⧸ P^m` sums over the norm-one
elements to at most `c` times their number, in modulus — the residue target's normalised eigenvalues, both signs. -/
def ThickAt (P : StablePrime F) (c : ℝ) : Prop :=
  ∀ m : ℕ, 1 ≤ m → ∀ (hfin : (normOneQ P m).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ m) ℂ), ψ ≠ 1 →
    ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ c * hfin.toFinset.card

variable (F) in
/-- **`F` is uniformly `c`-thick**: every stable prime is `c`-thick, with one constant `c`. -/
def Thick (c : ℝ) : Prop := ∀ P : StablePrime F, ThickAt P c

/-- Thickness is monotone in the constant. -/
theorem ThickAt.mono {P : StablePrime F} {a b : ℝ} (h : ThickAt P a) (hab : a ≤ b) : ThickAt P b :=
  fun m hm hfin ψ hψ => (h m hm hfin ψ hψ).trans (mul_le_mul_of_nonneg_right hab (Nat.cast_nonneg _))

/-- Every stable prime is `1`-thick: a character into `ℂ` of a finite group has values of modulus one. -/
theorem thickAt_one (P : StablePrime F) : ThickAt P 1 := by
  sorry

/-! ## Weil and Lemma P -/

/-- **Level one by Weil, every level by Lemma P** (V1-L7, I-WEIL; X26B-L1): at a stable prime not above `2` with
`|𝓞 ⧸ P| = Q²`, every non-trivial character at every level sums over the norm-one set to at most `2√Q/(Q + 1)` of its size.
Rests on `StandingFive.kloosterman_bound` (through `circle_sum_le_weil`). -/
theorem thickAt_weil (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) :
    ThickAt P (2 * Real.sqrt Q / ((Q : ℝ) + 1)) := by
  sorry

/-- The Weil constant `2√Q/(Q + 1)` decreases from `Q = 1` on. -/
theorem weil_const_anti {B Q : ℕ} (hB : 1 ≤ B) (hBQ : B ≤ Q) :
    2 * Real.sqrt Q / ((Q : ℝ) + 1) ≤ 2 * Real.sqrt B / ((B : ℝ) + 1) := by
  sorry

/-- **The Weil route to uniform thickness**: no stable prime above `2`, and every residue size `Q²` with `Q ≥ B`. -/
theorem thick_of_card {B : ℕ} (hB : 1 ≤ B)
    (h : ∀ P : StablePrime F, (2 : 𝓞 (fieldI F)) ∉ P.P ∧ ∃ Q : ℕ, B ≤ Q ∧ Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) :
    Thick F (2 * Real.sqrt B / ((B : ℝ) + 1)) := fun P => by
  obtain ⟨h2, Q, hBQ, hQ⟩ := h P
  exact (thickAt_weil P h2 hQ (hB.trans hBQ)).mono (weil_const_anti hB hBQ)

/-- **Row 128's per-place thickness gives the uniform one** (V1-L7's "the sup is a maximum over finitely many places"):
if every stable prime is `c_P`-thick for some `c_P < c₀`, one `c < c₀` serves every stable prime. Weil puts all but finitely
many below any positive constant; there are finitely many stable primes below any absolute norm. -/
theorem thick_of_forall_thickAt {c₀ : ℝ} (h : ∀ P : StablePrime F, ∃ c < c₀, ThickAt P c) :
    ∃ c < c₀, Thick F c := by
  sorry

/-- **A thick place is not ramified**: at a ramified stable prime the norm-one residues at level one are `{1}`, and a
character with `ψ 1 ≠ 1` sums to modulus `1` over them. -/
theorem not_isRamified_of_thickAt {P : StablePrime F} {c : ℝ} (h : ThickAt P c) (hc : c < 1) : ¬ IsRamified P := by
  sorry

/-! ## From places to the levels of the completion -/

/-- **A character of a subgroup of a finite abelian group extends** to the group (the restriction map of the duals is onto:
its kernel is the dual of the quotient, and the duals have the groups' sizes, `AddChar.card_eq`). -/
theorem exists_addChar_extend {G : Type*} [AddCommGroup G] [Finite G] (H : AddSubgroup G) (ψ : AddChar H ℂ) :
    ∃ ψ' : AddChar G ℂ, ∀ h : H, ψ' h = ψ h := by
  sorry

/-- **A character of a finite product sums over a product set as the product of its factors' sums**, so a non-trivial one
is bounded by its non-trivial factor: if every non-trivial character of every factor sums over `S i` to at most `c·|S i|`,
so does every non-trivial character of the product over `∏ S i`. -/
theorem norm_sum_piFinset_le {ι : Type*} [Fintype ι] [DecidableEq ι] {A : ι → Type*} [∀ i, AddCommGroup (A i)]
    [∀ i, Finite (A i)] [∀ i, DecidableEq (A i)] (S : ∀ i, Finset (A i)) {c : ℝ} (hc : 0 ≤ c)
    (hS : ∀ i (φ : AddChar (A i) ℂ), φ ≠ 1 → ‖∑ s ∈ S i, φ s‖ ≤ c * (S i).card) (ψ : AddChar (∀ i, A i) ℂ)
    (hψ : ψ ≠ 1) : ‖∑ s ∈ Fintype.piFinset S, ψ s‖ ≤ c * (Fintype.piFinset S).card := by
  sorry

/-- **`[S9]` at level `k` over unramified stable primes**: the unit vectors map onto the product of the norm-one sets.
`Rigidity.Counting.image_levR_unitVectors` with its hypothesis `TCA F` read where it is used — "no stable prime is
ramified" — and no further. -/
theorem image_levR_unitVectors_of_unramified (hun : ∀ P : StablePrime F, ¬ IsRamified P) (k : ℕ) :
    levR F k '' {r | (r : ℂ) ∈ unitVectors F} = normOneLev F k := by
  sorry

variable (F) in
/-- **The level-`k` group**: the image of `R = ℤ[U]` in `Lev F k = ∏_{P ∈ level k} 𝓞 ⧸ P^k` (the range of `proj k` on the
completion, `Rigidity.Counting.range_proj`). -/
abbrev LevImg (k : ℕ) : AddSubgroup (Lev F k) := (levR F k).range.toAddSubgroup

variable (F) in
/-- **The level-`k` connection set**: the norm-one points of the level group — the image of the unit vectors, where no stable
prime is ramified. -/
def levU (k : ℕ) : Set (LevImg F k) := {d | (d : Lev F k) ∈ normOneLev F k}

theorem finite_levU (k : ℕ) : (levU F k).Finite := Set.toFinite _

/-- **Thickness at the levels of the completion**: over a uniformly `c`-thick field (`c < 1`), every non-trivial character of
the level-`k` group (`k ≥ 1`) averages over the level's connection set to at most `c` in modulus. -/
theorem levelThick {c : ℝ} (hT : Thick F c) (hc : c < 1) {k : ℕ} (hk : 1 ≤ k) (ψ : AddChar (LevImg F k) ℂ)
    (hψ : ψ ≠ 1) : ‖∑ s ∈ (finite_levU (F := F) k).toFinset, ψ s‖ ≤ c * (finite_levU (F := F) k).toFinset.card := by
  sorry

/-- The level's connection set is not empty (`1` is a unit vector). -/
theorem levU_nonempty (k : ℕ) : (levU F k).Nonempty := by
  sorry

/-! ## Spec -/

-- `Thick` is `ThickAt` at every stable prime, with one constant.
example (c : ℝ) : Thick F c ↔ ∀ P : StablePrime F, ThickAt P c := Iff.rfl

-- every place is `1`-thick (characters of a finite group have modulus one): the constant `1` is the trivial bound.
example (P : StablePrime F) : ThickAt P 1 := thickAt_one P

end

end HadwigerNelson.Collapse
