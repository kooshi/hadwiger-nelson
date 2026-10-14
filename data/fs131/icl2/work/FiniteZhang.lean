import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

/-!
# Independence ratios of Cayley graphs on finite abelian groups, and of their products (FS-131, job FS131-K12A; module M12, block Z; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C5, "the stationary Zhang count", and NH-Y′; X25B-PZ;
`[Zhang2012]` Thm 1.8's counting). A connection set `S` of a finite additive group `G` defines the Cayley graph
`x ~ y ⟺ y − x ∈ S`. Independence is read **in the connection set**: `SIndep S I` says `y − x ∉ S` for all `x, y ∈ I`,
`x = y` included — so a connection set holding `0` has no non-empty independent set, which is the right reading for the
product's factors (a factor with one point and the loop `0` multiplies nothing away: `ratioLe_pi` at an empty index).
`RatioLe S c` says every independent set holds at most the fraction `c` of `G`.

* `card_le_mul_card_closedNbhd` — **the neighbourhood ratio** (NH-Y′ in finite form): in a symmetric Cayley graph of ratio
  at most `c`, every independent `I` has `|I| ≤ c |N[I]|`. Route: for a maximum independent `J` and every `t`,
  `((J + t) \ N[I]) ∪ I` is independent; average `|(J + t) ∩ N[I]| = |J| |N[I]| / |G|` over `t`.
* `ratioLe_prod` — **Zhang's product bound**: the connection set `S₁ ×ˢ S₂` of `G₁ × G₂` has ratio at most `c` when each
  factor has. Route: the social and lonely points of each row (`[Zhang2012]`'s count), with the neighbourhood ratio on both
  factors.
* `ratioLe_pi` — the same over a finite product, by induction.
* `ratioLe_subgroup` — **a subgroup holding the connection set** has the ratio of the group: an independent set of the
  subgroup, translated to every coset, is independent in the group.

The count (module `Rigidity/CountDescent`) reads `ratioLe_pi` and `ratioLe_subgroup` at the residue levels of the stable
primes, and `card_le_mul_card_closedNbhd` in the plane-by-finite count (`Rigidity/PlaneZhang`).

**Models.** `RatioLe S 1` holds for every `S` (an independent set is a subset); `RatioLe {1} (1/2)` on `ZMod 2` (a single
point is the largest independent set).
-/

namespace HadwigerNelson.Rigidity

open Finset

variable {G : Type*} [AddCommGroup G] [Finite G]

/-- `I` is independent in the Cayley graph of `S`: no difference of two of its points (equal points included) lies in
`S`. -/
def SIndep (S : Set G) (I : Finset G) : Prop := ∀ x ∈ I, ∀ y ∈ I, y - x ∉ S

/-- **The independence ratio of the Cayley graph of `S` is at most `c`.** -/
def RatioLe (S : Set G) (c : ℝ) : Prop := ∀ I : Finset G, SIndep S I → (I.card : ℝ) ≤ c * Nat.card G

/-- The closed neighbourhood `N[I] = I ∪ (I + S)`. -/
noncomputable def closedNbhd (S : Set G) (I : Finset G) : Finset G :=
  (Set.toFinite {y : G | y ∈ I ∨ ∃ x ∈ I, y - x ∈ S}).toFinset

/-- **The neighbourhood ratio** (NH-Y′, finite form). -/
theorem card_le_mul_card_closedNbhd {S : Set G} {c : ℝ} (hS : ∀ s ∈ S, -s ∈ S) (h : RatioLe S c) {I : Finset G}
    (hI : SIndep S I) : (I.card : ℝ) ≤ c * (closedNbhd S I).card := by
  classical
  haveI := Fintype.ofFinite G
  set N := closedNbhd S I with hN
  have memN : ∀ y, y ∈ N ↔ y ∈ I ∨ ∃ x ∈ I, y - x ∈ S := fun y => by
    simp [hN, closedNbhd]
  -- a maximum independent set
  obtain ⟨J, hJmem, hJmax⟩ := Finset.exists_max_image ((univ : Finset G).powerset.filter (SIndep S)) Finset.card
    ⟨∅, by simp [SIndep]⟩
  have hJ : SIndep S J := (Finset.mem_filter.mp hJmem).2
  have hmax : ∀ K : Finset G, SIndep S K → K.card ≤ J.card := fun K hK =>
    hJmax K (Finset.mem_filter.mpr ⟨Finset.mem_powerset.mpr (Finset.subset_univ _), hK⟩)
  -- each translate meets `N` in at least `|I|` points
  have step : ∀ t : G, I.card ≤ ((J.map (addRightEmbedding t)).filter (· ∈ N)).card := by
    intro t
    set Jt := J.map (addRightEmbedding t)
    let K := Jt.filter (· ∉ N) ∪ I
    have hK : SIndep S K := by
      intro x hx y hy
      simp only [K, Finset.mem_union, Finset.mem_filter] at hx hy
      rcases hx with ⟨hx, hxN⟩ | hx <;> rcases hy with ⟨hy, hyN⟩ | hy
      · obtain ⟨x', hx', rfl⟩ := Finset.mem_map.mp hx
        obtain ⟨y', hy', rfl⟩ := Finset.mem_map.mp hy
        simpa using hJ x' hx' y' hy'
      · intro hs
        exact hxN ((memN x).mpr (Or.inr ⟨y, hy, by simpa using hS _ hs⟩))
      · intro hs
        exact hyN ((memN y).mpr (Or.inr ⟨x, hx, hs⟩))
      · exact hI x hx y hy
    have hdisj : Disjoint (Jt.filter (· ∉ N)) I := by
      rw [Finset.disjoint_left]
      intro a ha haI
      exact (Finset.mem_filter.mp ha).2 ((memN a).mpr (Or.inl haI))
    have h1 := hmax K hK
    rw [Finset.card_union_of_disjoint hdisj] at h1
    have h2 := Finset.card_filter_add_card_filter_not (s := Jt) (· ∈ N)
    rw [Finset.card_map] at h2
    omega
  -- sum over the translates
  have hsum : ∑ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card = J.card * N.card := by
    have : ∀ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card = ∑ y ∈ N, if y - t ∈ J then 1 else 0 := by
      intro t
      rw [Finset.card_eq_sum_ones, Finset.sum_filter, Finset.sum_map]
      rw [← Finset.sum_filter, ← Finset.sum_filter]
      refine Finset.sum_bij (fun x _ => x + t) ?_ ?_ ?_ ?_ <;> simp
      · exact fun a ha hN => ⟨hN, ha⟩
      · exact fun b hb hbt => ⟨b - t, ⟨hbt, by simpa using hb⟩, by simp⟩
    simp_rw [this]
    rw [Finset.sum_comm]
    have hy : ∀ y : G, (∑ t : G, if y - t ∈ J then 1 else 0) = J.card := by
      intro y
      rw [← Finset.sum_filter, ← Finset.card_eq_sum_ones]
      refine Finset.card_bij (fun t _ => y - t) ?_ ?_ ?_ <;> simp
      · intro a ha; exact ⟨y - a, by simpa using ha⟩
    simp [hy, mul_comm]
  have hG : (0 : ℝ) < Nat.card G := by exact_mod_cast Nat.card_pos
  have hα := h J hJ
  have key : (Nat.card G : ℝ) * I.card ≤ J.card * N.card := by
    have : ∑ _t : G, I.card ≤ ∑ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card :=
      Finset.sum_le_sum fun t _ => step t
    rw [hsum, Finset.sum_const, Finset.card_univ, ← Nat.card_eq_fintype_card, smul_eq_mul] at this
    exact_mod_cast this
  have hN0 : (0 : ℝ) ≤ N.card := Nat.cast_nonneg _
  nlinarith

-- FS131-ICL2: the proofs below. `ratioLe_prod` is `[Zhang2012]`'s count: the lonely points of each row and the social
-- columns; `ratioLe_pi` is induction on the finite index through additive equivalences (`ratioLe_of_addEquiv`).

/-- A ratio bound on a finite group is non-negative: the empty set is independent. -/
private theorem ratioLe_nonneg {S : Set G} {c : ℝ} (h : RatioLe S c) : 0 ≤ c := by
  have h0 := h ∅ (by simp [SIndep])
  have hG : (0 : ℝ) < Nat.card G := by exact_mod_cast Nat.card_pos
  rw [Finset.card_empty, Nat.cast_zero] at h0
  by_contra hc
  push Not at hc
  nlinarith

omit [Finite G] in
/-- A ratio bound moves along an additive equivalence that carries one connection set onto the other. -/
private theorem ratioLe_of_addEquiv {G' : Type*} [AddCommGroup G'] (e : G ≃+ G') {S : Set G} {S' : Set G'}
    (he : ∀ x, x ∈ S ↔ e x ∈ S') {c : ℝ} (h : RatioLe S' c) : RatioLe S c := by
  classical
  intro I hI
  have hI' : SIndep S' (I.map e.toEquiv.toEmbedding) := by
    intro x' hx' y' hy'
    obtain ⟨x, hx, rfl⟩ := Finset.mem_map.1 hx'
    obtain ⟨y, hy, rfl⟩ := Finset.mem_map.1 hy'
    intro hs
    refine hI x hx y hy ((he _).2 ?_)
    rw [map_sub]
    exact hs
  have h' := h _ hI'
  rwa [Finset.card_map, Nat.card_congr e.toEquiv.symm] at h'

omit [Finite G] in
/-- A finite set's size, as a sum of indicators over the whole type. -/
private theorem card_eq_sum_ite {α : Type*} [Fintype α] [DecidableEq α] (T : Finset α) :
    T.card = ∑ x, if x ∈ T then 1 else 0 := by
  rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.card_eq_sum_ones]

/-- **Zhang's product bound**, two finite factors. -/
theorem ratioLe_prod {G₁ G₂ : Type*} [AddCommGroup G₁] [Finite G₁] [AddCommGroup G₂] [Finite G₂] {S₁ : Set G₁} {S₂ : Set G₂} {c : ℝ} (hS₁ : ∀ s ∈ S₁, -s ∈ S₁) (hS₂ : ∀ s ∈ S₂, -s ∈ S₂)
    (h₁ : RatioLe S₁ c) (h₂ : RatioLe S₂ c) : RatioLe (S₁ ×ˢ S₂) c := by
  classical
  haveI := Fintype.ofFinite G₁
  haveI := Fintype.ofFinite G₂
  intro I hI
  have hc : 0 ≤ c := ratioLe_nonneg h₁
  have hpair : ∀ a b a' b', (a, b) ∈ I → (a', b') ∈ I → a' - a ∈ S₁ → b' - b ∈ S₂ → False :=
    fun a b a' b' h h' h1 h2 => hI _ h _ h' (Set.mk_mem_prod h1 h2)
  -- the rows `X b`, their lonely points `L b`, the social columns `A a`, the touched columns `B a`
  set X : G₂ → Finset G₁ := fun b => univ.filter fun a => (a, b) ∈ I with hX
  set L : G₂ → Finset G₁ := fun b => (X b).filter fun a => ∀ a' ∈ X b, a' - a ∉ S₁ with hL
  set A : G₁ → Finset G₂ := fun a => univ.filter fun b => a ∈ X b ∧ a ∉ L b with hA
  set B : G₁ → Finset G₂ := fun a => univ.filter fun b => a ∈ closedNbhd S₁ (L b) with hB
  have memX : ∀ a b, a ∈ X b ↔ (a, b) ∈ I := fun a b => by simp [hX]
  have memL : ∀ a b, a ∈ L b ↔ a ∈ X b ∧ ∀ a' ∈ X b, a' - a ∉ S₁ := fun a b => by simp [hL]
  have memA : ∀ a b, b ∈ A a ↔ a ∈ X b ∧ a ∉ L b := fun a b => by simp [hA]
  have memB : ∀ a b, b ∈ B a ↔ a ∈ closedNbhd S₁ (L b) := fun a b => by simp [hB]
  have memN₁ : ∀ (T : Finset G₁) y, y ∈ closedNbhd S₁ T ↔ y ∈ T ∨ ∃ x ∈ T, y - x ∈ S₁ := fun T y => by
    simp [closedNbhd]
  have memN₂ : ∀ (T : Finset G₂) y, y ∈ closedNbhd S₂ T ↔ y ∈ T ∨ ∃ x ∈ T, y - x ∈ S₂ := fun T y => by
    simp [closedNbhd]
  -- a social point of a row has a neighbour in the row
  have social : ∀ a b, a ∈ X b → a ∉ L b → ∃ a'' ∈ X b, a'' - a ∈ S₁ := by
    intro a b ha haL
    by_contra hne
    push Not at hne
    exact haL ((memL a b).2 ⟨ha, hne⟩)
  -- (1) the lonely points of a row are independent
  have hLind : ∀ b, SIndep S₁ (L b) := fun b x hx y hy => ((memL x b).1 hx).2 y ((memL y b).1 hy).1
  -- (2) the social column of `a` is independent
  have hAind : ∀ a, SIndep S₂ (A a) := by
    intro a b hb b' hb' hs
    obtain ⟨hab', hab'L⟩ := (memA a b').1 hb'
    obtain ⟨a'', ha'', has⟩ := social a b' hab' hab'L
    exact hpair a b a'' b' ((memX a b).1 ((memA a b).1 hb).1) ((memX a'' b').1 ha'') has hs
  -- (3) the closed neighbourhood of the social column of `a` misses the columns `a` touches
  have hdisj : ∀ a, Disjoint (closedNbhd S₂ (A a)) (B a) := by
    intro a
    rw [Finset.disjoint_left]
    intro b hbN hbB
    have hbB' := (memB a b).1 hbB
    rcases (memN₂ _ b).1 hbN with hbA | ⟨b₀, hb₀, hbs⟩
    · obtain ⟨haX, haL⟩ := (memA a b).1 hbA
      rcases (memN₁ _ a).1 hbB' with haL' | ⟨a', ha', has⟩
      · exact haL haL'
      · exact ((memL a' b).1 ha').2 a haX has
    · obtain ⟨haX₀, haL₀⟩ := (memA a b₀).1 hb₀
      have hbs' : b₀ - b ∈ S₂ := by simpa using hS₂ _ hbs
      rcases (memN₁ _ a).1 hbB' with haL' | ⟨a', ha', has⟩
      · obtain ⟨a'', ha'', has''⟩ := social a b₀ haX₀ haL₀
        exact hpair a b a'' b₀ ((memX a b).1 ((memL a b).1 haL').1) ((memX a'' b₀).1 ha'') has'' hbs'
      · exact hpair a' b a b₀ ((memX a' b).1 ((memL a' b).1 ha').1) ((memX a b₀).1 haX₀) has hbs'
  -- (4) the counts
  have hrow : ∀ a b, (if (a, b) ∈ I then 1 else 0 : ℕ) =
      (if a ∈ L b then 1 else 0) + (if b ∈ A a then 1 else 0) := by
    intro a b
    by_cases hI' : (a, b) ∈ I
    · have haX : a ∈ X b := (memX a b).2 hI'
      by_cases haL : a ∈ L b
      · simp [hI', haL, memA]
      · simp [hI', haL, memA, haX]
    · have haX : a ∉ X b := fun h => hI' ((memX a b).1 h)
      have haL : a ∉ L b := fun h => haX ((memL a b).1 h).1
      simp [hI', haL, memA, haX]
  have cardI : I.card = ∑ b, (L b).card + ∑ a, (A a).card := by
    rw [card_eq_sum_ite I, Fintype.sum_prod_type]
    simp_rw [hrow, Finset.sum_add_distrib]
    rw [Finset.sum_comm (f := fun a b => if a ∈ L b then 1 else 0)]
    congr 1
    · exact Finset.sum_congr rfl fun b _ => (card_eq_sum_ite (L b)).symm
    · exact Finset.sum_congr rfl fun a _ => (card_eq_sum_ite (A a)).symm
  have cardNB : ∑ b, (closedNbhd S₁ (L b)).card = ∑ a, (B a).card := by
    simp_rw [card_eq_sum_ite (closedNbhd S₁ _), card_eq_sum_ite (B _), memB]
    exact Finset.sum_comm
  -- (5) the two neighbourhood ratios
  have hLle : ∀ b, ((L b).card : ℝ) ≤ c * (closedNbhd S₁ (L b)).card := fun b =>
    card_le_mul_card_closedNbhd hS₁ h₁ (hLind b)
  have hAle : ∀ a, ((A a).card : ℝ) ≤ c * ((Nat.card G₂ : ℝ) - (B a).card) := by
    intro a
    have hN := card_le_mul_card_closedNbhd hS₂ h₂ (hAind a)
    have hu : (closedNbhd S₂ (A a)).card + (B a).card ≤ Nat.card G₂ := by
      rw [← Finset.card_union_of_disjoint (hdisj a), Nat.card_eq_fintype_card]
      exact Finset.card_le_univ _
    have hu' : ((closedNbhd S₂ (A a)).card : ℝ) ≤ (Nat.card G₂ : ℝ) - (B a).card := by
      have : ((closedNbhd S₂ (A a)).card : ℝ) + (B a).card ≤ Nat.card G₂ := by exact_mod_cast hu
      linarith
    calc ((A a).card : ℝ) ≤ c * (closedNbhd S₂ (A a)).card := hN
      _ ≤ c * ((Nat.card G₂ : ℝ) - (B a).card) := mul_le_mul_of_nonneg_left hu' hc
  -- (6) sum
  have hsumL : (∑ b, ((L b).card : ℝ)) ≤ c * ∑ a, ((B a).card : ℝ) := by
    calc (∑ b, ((L b).card : ℝ)) ≤ ∑ b, c * ((closedNbhd S₁ (L b)).card : ℝ) := Finset.sum_le_sum fun b _ => hLle b
      _ = c * ∑ a, ((B a).card : ℝ) := by rw [← Finset.mul_sum]; exact_mod_cast congrArg (fun n : ℕ => c * n) cardNB
  have hsumA : (∑ a, ((A a).card : ℝ)) ≤ c * ((Nat.card G₁ : ℝ) * Nat.card G₂) - c * ∑ a, ((B a).card : ℝ) := by
    calc (∑ a, ((A a).card : ℝ)) ≤ ∑ a, c * ((Nat.card G₂ : ℝ) - (B a).card) := Finset.sum_le_sum fun a _ => hAle a
      _ = c * ((Nat.card G₁ : ℝ) * Nat.card G₂) - c * ∑ a, ((B a).card : ℝ) := by
        rw [← Finset.mul_sum, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
          ← Nat.card_eq_fintype_card]
        ring
  have hI : (I.card : ℝ) = ∑ b, ((L b).card : ℝ) + ∑ a, ((A a).card : ℝ) := by exact_mod_cast cardI
  rw [Nat.card_prod, Nat.cast_mul, hI]
  linarith

/-- **Zhang's product bound**, a finite product. -/
theorem ratioLe_pi {ι : Type*} [Finite ι] {H : ι → Type*} [∀ i, AddCommGroup (H i)] [∀ i, Finite (H i)] {S : ∀ i, Set (H i)} {c : ℝ} (hc : 0 ≤ c)
    (hS : ∀ i, ∀ s ∈ S i, -s ∈ S i) (h : ∀ i, RatioLe (S i) c) :
    RatioLe {d : ∀ i, H i | ∀ i, d i ∈ S i} c := by
  refine Finite.induction_empty_option (P := fun ι => ∀ (H : ι → Type _) [∀ i, AddCommGroup (H i)]
    [∀ i, Finite (H i)] (S : ∀ i, Set (H i)), (∀ i, ∀ s ∈ S i, -s ∈ S i) → (∀ i, RatioLe (S i) c) →
      RatioLe {d : ∀ i, H i | ∀ i, d i ∈ S i} c) ?_ ?_ ?_ ι H S hS h
  · -- along an equivalence of the index: `(∀ b, H b) ≃+ ∀ a, H (e a)`
    intro α β e hα H _ _ S hS h
    have key := hα (fun a => H (e a)) (fun a => S (e a)) (fun a => hS (e a)) (fun a => h (e a))
    let φ : (∀ b, H b) ≃+ ∀ a, H (e a) := { Equiv.piCongrLeft' H e.symm with map_add' := fun _ _ => rfl }
    refine ratioLe_of_addEquiv φ (fun d => ?_) key
    show (∀ b, d b ∈ S b) ↔ ∀ a, d (e a) ∈ S (e a)
    refine ⟨fun hd a => hd (e a), fun hd b => ?_⟩
    have hb := hd (e.symm b)
    rw [Equiv.apply_symm_apply] at hb
    exact hb
  · -- the empty index: one point, and the connection set is everything
    intro H _ _ S _ _ I hI
    have hI0 : I = ∅ := by
      rw [Finset.eq_empty_iff_forall_notMem]
      intro x hx
      exact hI x hx x hx (fun i => i.elim)
    rw [hI0, Finset.card_empty, Nat.cast_zero]
    exact mul_nonneg hc (Nat.cast_nonneg _)
  · -- `Option α`: the factor at `none` times the rest (`ratioLe_prod`)
    intro α _ hα H _ _ S hS h
    have h2 := hα (fun a => H (some a)) (fun a => S (some a)) (fun a => hS (some a)) (fun a => h (some a))
    have hS2 : ∀ s ∈ {d : ∀ a, H (some a) | ∀ a, d a ∈ S (some a)},
        -s ∈ {d : ∀ a, H (some a) | ∀ a, d a ∈ S (some a)} := fun s hs a => hS (some a) (s a) (hs a)
    have hprod := ratioLe_prod (hS none) hS2 (h none) h2
    let φ : (∀ i, H i) ≃+ H none × ∀ a, H (some a) := { Equiv.piOptionEquivProd with map_add' := fun _ _ => rfl }
    refine ratioLe_of_addEquiv φ (fun d => ?_) hprod
    show (∀ i, d i ∈ S i) ↔ (d none ∈ S none ∧ ∀ a, d (some a) ∈ S (some a))
    exact Option.forall

/-- **A subgroup holding the connection set has the group's ratio.** -/
theorem ratioLe_subgroup (A : AddSubgroup G) {S : Set G} (hSA : S ⊆ A) {c : ℝ}
    (h : RatioLe S c) : RatioLe {d : A | (d : G) ∈ S} c := by
  classical
  haveI := Fintype.ofFinite G
  haveI := Fintype.ofFinite (G ⧸ A)
  intro I hI
  -- `I` translated to every coset by a transversal: `(i, q) ↦ i + q.out`
  let f : A × (G ⧸ A) → G := fun p => (p.1 : G) + p.2.out
  have hq : ∀ p : A × (G ⧸ A), ((f p : G) : G ⧸ A) = p.2 := by
    intro p
    show ((((p.1 : G) + p.2.out : G)) : G ⧸ A) = p.2
    rw [QuotientAddGroup.mk_add, (QuotientAddGroup.eq_zero_iff _).2 p.1.2, zero_add, QuotientAddGroup.out_eq']
  have hf : Function.Injective f := by
    intro p p' hpp'
    have h2 : p.2 = p'.2 := by rw [← hq p, ← hq p', hpp']
    have h1 : (p.1 : G) = p'.1 := by
      have e : (p.1 : G) + p.2.out = p'.1 + p'.2.out := hpp'
      rw [h2] at e
      exact add_right_cancel e
    exact Prod.ext (Subtype.ext h1) h2
  set J : Finset G := (I ×ˢ (univ : Finset (G ⧸ A))).image f with hJdef
  have hJ : SIndep S J := by
    intro x hx y hy hs
    obtain ⟨⟨i, q⟩, hiq, rfl⟩ := Finset.mem_image.1 hx
    obtain ⟨⟨j, q'⟩, hjq, rfl⟩ := Finset.mem_image.1 hy
    simp only [Finset.mem_product] at hiq hjq
    by_cases hqq : q = q'
    · subst hqq
      apply hI i hiq.1 j hjq.1
      show ((j - i : A) : G) ∈ S
      have e : f (j, q) - f (i, q) = ((j - i : A) : G) := by
        simp only [f, AddSubgroup.coe_sub]
        exact add_sub_add_right_eq_sub _ _ _
      rw [← e]
      exact hs
    · apply hqq
      have hmem : f (j, q') - f (i, q) ∈ A := hSA hs
      have e : ((f (i, q) : G) : G ⧸ A) = ((f (j, q') : G) : G ⧸ A) :=
        QuotientAddGroup.eq.2 (by rw [neg_add_eq_sub]; exact hmem)
      rw [hq, hq] at e
      exact e
  have hcard : J.card = I.card * Nat.card (G ⧸ A) := by
    rw [hJdef, Finset.card_image_of_injective _ hf, Finset.card_product, Finset.card_univ, Nat.card_eq_fintype_card]
  have hJc := h J hJ
  rw [hcard, AddSubgroup.card_eq_card_quotient_mul_card_addSubgroup A] at hJc
  push_cast at hJc
  have hpos : (0 : ℝ) < Nat.card (G ⧸ A) := by exact_mod_cast Nat.card_pos
  have e : (I.card : ℝ) * Nat.card (G ⧸ A) ≤ (c * Nat.card A) * Nat.card (G ⧸ A) := by linarith
  exact le_of_mul_le_mul_right e hpos

theorem ratioLe_one (S : Set G) : RatioLe S 1 := fun I _ => by
  haveI := Fintype.ofFinite G
  rw [one_mul, Nat.card_eq_fintype_card]
  exact_mod_cast card_le_univ I

/-! ## Spec examples -/

/-- On `ZMod 2` with the connection set `{1}`, a single point is independent. -/
example : SIndep ({1} : Set (ZMod 2)) {0} := by
  intro x hx y hy
  simp only [Finset.mem_singleton] at hx hy
  subst hx; subst hy
  decide

end HadwigerNelson.Rigidity
