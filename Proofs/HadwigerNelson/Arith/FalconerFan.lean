import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex

/-!
# Falconer fans through graph homomorphisms (FS-131 wave 1)

Rows: **FS129-SA1-FALC-FAN** (carrying FS129-MA1-FALC-T and FS129-MA2-FALC-GAP4) and **FS129-SA1-FALC-DICHO-K** (carrying
FS129-MA2-FALC-DICHO). Plan: `plans/FS131-kernel-plan.md` § 6.

A **Falconer fan at `k` colours** with apex `a` and tip `t` (`a ≠ t`, not adjacent): every proper `k`-colouring of `H − a`
in which `N(a)` avoids two distinct colours `c₁, c₂` gives `t` one of `c₁, c₂`. `H − a` is the induced subgraph on
`{v | v ≠ a}`. The rows say "a finite graph"; neither argument reads finiteness, so it is not assumed (reported).
Inhabitant: the unit rhombus at four colours (`rhombus_falconerFan`).
-/

namespace HadwigerNelson.Arith

open SimpleGraph

/-- A Falconer fan at `k` colours with apex `a` and tip `t`. -/
def FalconerFan {V : Type*} (H : SimpleGraph V) (k : ℕ) (a t : V) : Prop :=
  a ≠ t ∧ ¬ H.Adj a t ∧
    ∀ C : (H.induce {v | v ≠ a}).Coloring (Fin k), ∀ c₁ c₂ : Fin k, c₁ ≠ c₂ →
      (∀ v (hv : v ≠ a), H.Adj a v → C ⟨v, hv⟩ ≠ c₁ ∧ C ⟨v, hv⟩ ≠ c₂) →
        ∀ ht : t ≠ a, C ⟨t, ht⟩ = c₁ ∨ C ⟨t, ht⟩ = c₂

/-- The unit rhombus `0 – {1, 2} – 3` with the short diagonal `1 – 2`. -/
def rhombus : SimpleGraph (Fin 4) :=
  SimpleGraph.fromRel fun i j => (i, j) ∈ [((0 : Fin 4), (1 : Fin 4)), (0, 2), (1, 2), (1, 3), (2, 3)]

/-- **Inhabitant**: the unit rhombus is a Falconer fan at four colours with apex `0` and tip `3`. -/
theorem rhombus_falconerFan : FalconerFan rhombus 4 0 3 := by
  have r12 : rhombus.Adj 1 2 := by simp [rhombus, fromRel_adj]
  have r13 : rhombus.Adj 1 3 := by simp [rhombus, fromRel_adj]
  have r23 : rhombus.Adj 2 3 := by simp [rhombus, fromRel_adj]
  have r01 : rhombus.Adj 0 1 := by simp [rhombus, fromRel_adj]
  have r02 : rhombus.Adj 0 2 := by simp [rhombus, fromRel_adj]
  refine ⟨by decide, by simp [rhombus, fromRel_adj], ?_⟩
  intro C c₁ c₂ hc hav ht
  have h12 : C ⟨1, by decide⟩ ≠ C ⟨2, by decide⟩ := C.valid r12
  have h13 : C ⟨1, by decide⟩ ≠ C ⟨3, ht⟩ := C.valid r13
  have h23 : C ⟨2, by decide⟩ ≠ C ⟨3, ht⟩ := C.valid r23
  have a1 := hav 1 (by decide) r01
  have a2 := hav 2 (by decide) r02
  clear hav
  revert h12 h13 h23 a1 a2 hc
  generalize C ⟨1, by decide⟩ = x1
  generalize C ⟨2, by decide⟩ = x2
  generalize C ⟨3, ht⟩ = x3
  clear C
  revert x1 x2 x3 c₁ c₂
  decide

/-- **FS129-SA1-FALC-FAN**: let `k ≥ 3`, `(H, a, t)` a Falconer fan at `k` colours, and `ρ : H →g T`. (A) For every
proper `k`-colouring `C` of `T` and every colour `γ` absent from `N_T[ρ(a)]`, `C(ρ(t)) ∈ {C(ρ(a)), γ}`, and every
colour absent from `N_T[ρ(t)]` lies in `{C(ρ(a)), γ}`. (B) Every proper `(k − 1)`-colouring of `T` gives `ρ(a)` and
`ρ(t)` one colour and leaves none of its `k − 1` colours absent from `N_T[ρ(t)]`. -/
theorem falconerFan_hom {V W : Type*} {H : SimpleGraph V} {T : SimpleGraph W} {k : ℕ} (hk : 3 ≤ k) {a t : V}
    (hfan : FalconerFan H k a t) (ρ : H →g T) :
    (∀ (C : T.Coloring (Fin k)) (γ : Fin k), (∀ x, (x = ρ a ∨ T.Adj (ρ a) x) → C x ≠ γ) →
      (C (ρ t) = C (ρ a) ∨ C (ρ t) = γ) ∧
        ∀ δ : Fin k, (∀ x, (x = ρ t ∨ T.Adj (ρ t) x) → C x ≠ δ) → δ = C (ρ a) ∨ δ = γ) ∧
    (∀ C : T.Coloring (Fin (k - 1)), C (ρ a) = C (ρ t) ∧
      ∀ δ : Fin (k - 1), ∃ x, (x = ρ t ∨ T.Adj (ρ t) x) ∧ C x = δ) := by
  classical
  obtain ⟨hat, hnadj, hF⟩ := hfan
  have hA : ∀ (C : T.Coloring (Fin k)) (γ : Fin k), (∀ x, (x = ρ a ∨ T.Adj (ρ a) x) → C x ≠ γ) →
      (C (ρ t) = C (ρ a) ∨ C (ρ t) = γ) ∧
        ∀ δ : Fin k, (∀ x, (x = ρ t ∨ T.Adj (ρ t) x) → C x ≠ δ) → δ = C (ρ a) ∨ δ = γ := by
    intro C γ hγ
    have hta : t ≠ a := hat.symm
    have hγa : C (ρ a) ≠ γ := hγ (ρ a) (Or.inl rfl)
    -- the pulled-back colouring of `H − a`
    let C0 : (H.induce {v | v ≠ a}).Coloring (Fin k) :=
      SimpleGraph.Coloring.mk (fun v => C (ρ v.1)) (fun {u v} h => C.valid (ρ.map_adj h))
    have hav : ∀ v (hv : v ≠ a), H.Adj a v → C0 ⟨v, hv⟩ ≠ C (ρ a) ∧ C0 ⟨v, hv⟩ ≠ γ := by
      intro v hv hadj
      have hT : T.Adj (ρ a) (ρ v) := ρ.map_adj hadj
      exact ⟨(C.valid hT).symm, hγ _ (Or.inr hT)⟩
    refine ⟨hF C0 (C (ρ a)) γ hγa hav hta, ?_⟩
    intro δ hδ
    let C1 : (H.induce {v | v ≠ a}).Coloring (Fin k) :=
      SimpleGraph.Coloring.mk (fun v => if v.1 = t then δ else C (ρ v.1)) (by
        intro u v h
        have hH : H.Adj u.1 v.1 := h
        have hne : u.1 ≠ v.1 := hH.ne
        by_cases hu : u.1 = t
        · have hv : v.1 ≠ t := fun hv => hne (hu.trans hv.symm)
          simp only [hu, if_true, hv, if_false]
          have hT : T.Adj (ρ t) (ρ v.1) := by rw [← hu]; exact ρ.map_adj hH
          exact (hδ _ (Or.inr hT)).symm
        · by_cases hv : v.1 = t
          · simp only [hu, if_false, hv, if_true]
            have hT : T.Adj (ρ t) (ρ u.1) := by rw [← hv]; exact ρ.map_adj hH.symm
            exact hδ _ (Or.inr hT)
          · simp only [hu, hv, if_false]
            exact C.valid (ρ.map_adj hH))
    have hC1 : ∀ v : {v | v ≠ a}, C1 v = if v.1 = t then δ else C (ρ v.1) := fun v => rfl
    have hC0 : ∀ v : {v | v ≠ a}, C0 v = C (ρ v.1) := fun v => rfl
    have hav1 : ∀ v (hv : v ≠ a), H.Adj a v → C1 ⟨v, hv⟩ ≠ C (ρ a) ∧ C1 ⟨v, hv⟩ ≠ γ := by
      intro v hv hadj
      have hvt : v ≠ t := fun h => hnadj (h ▸ hadj)
      have : C1 ⟨v, hv⟩ = C0 ⟨v, hv⟩ := by rw [hC1, hC0]; simp [hvt]
      rw [this]; exact hav v hv hadj
    have := hF C1 (C (ρ a)) γ hγa hav1 hta
    rw [hC1] at this
    simpa using this
  refine ⟨hA, fun C => ?_⟩
  have hle : k - 1 ≤ k := Nat.sub_le _ _
  let C' : T.Coloring (Fin k) :=
    SimpleGraph.Coloring.mk (fun x => Fin.castLE hle (C x)) (fun {u v} h hh =>
      C.valid h (Fin.castLE_injective hle hh))
  let γ : Fin k := ⟨k - 1, by omega⟩
  have hlt : ∀ x, C' x ≠ γ := by
    intro x h
    have := congrArg Fin.val h
    simp [C', γ] at this
    exact absurd this (Nat.ne_of_lt (C x).isLt)
  obtain ⟨h1, h2⟩ := hA C' γ (fun x _ => hlt x)
  have hta : C (ρ a) = C (ρ t) := by
    rcases h1 with h | h
    · exact (Fin.castLE_injective hle h).symm
    · exact absurd h (hlt _)
  refine ⟨hta, fun δ => ?_⟩
  by_contra hcon
  push Not at hcon
  have habs : ∀ x, (x = ρ t ∨ T.Adj (ρ t) x) → C' x ≠ Fin.castLE hle δ := fun x hx h =>
    hcon x hx (Fin.castLE_injective hle h)
  rcases h2 _ habs with h | h
  · have := Fin.castLE_injective hle h
    exact hcon (ρ t) (Or.inl rfl) (by rw [this, hta])
  · have := congrArg Fin.val h
    simp [γ] at this
    exact absurd this (Nat.ne_of_lt δ.isLt)

/-- **FS129-SA1-FALC-DICHO-K**: a Falconer fan `(H, a, t)` at `k ≥ 3` colours has `χ(H) ≥ k − 1`, and every proper
`(k − 1)`-colouring of `H` gives `a` and `t` one colour. (The row conditions the second clause on `χ(H) = k − 1`; that
hypothesis is idle — a `(k − 1)`-colouring exists only when `χ(H) ≤ k − 1`, and then the first clause gives equality — so
the clause is stated unconditionally, which implies the row's form.) -/
theorem falconerFan_chromaticNumber {V : Type*} {H : SimpleGraph V} {k : ℕ} (hk : 3 ≤ k) {a t : V}
    (hfan : FalconerFan H k a t) :
    ((k - 1 : ℕ) : ℕ∞) ≤ H.chromaticNumber ∧ ∀ C : H.Coloring (Fin (k - 1)), C a = C t := by
  have hB := (falconerFan_hom hk hfan (SimpleGraph.Hom.id (G := H))).2
  refine ⟨?_, fun C => (hB C).1⟩
  rw [SimpleGraph.le_chromaticNumber_iff_colorable]
  intro m ⟨C⟩
  by_contra hm
  push Not at hm
  have hle : m ≤ k - 1 := hm.le
  let C' : (⊤ : SimpleGraph (Fin m)).Coloring (Fin (k - 1)) :=
    SimpleGraph.Coloring.mk (fun x => Fin.castLE hle x) (fun {u v} h hh =>
      h (Fin.castLE_injective hle hh))
  have hB' := (falconerFan_hom hk hfan (T := (⊤ : SimpleGraph (Fin m))) (C : H →g ⊤)).2 C'
  obtain ⟨x, -, hx⟩ := hB'.2 ⟨k - 2, by omega⟩
  have hC' : ∀ y, C' y = Fin.castLE hle y := fun y => rfl
  have h3 := congrArg Fin.val hx
  rw [hC'] at h3
  simp only [Fin.val_castLE] at h3
  have h4 := x.isLt
  omega

end HadwigerNelson.Arith
