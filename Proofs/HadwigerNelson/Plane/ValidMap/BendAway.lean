import Proofs.HadwigerNelson.Plane.ValidMap.Limit
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove

/-!
# The away bend's clause package and its composition over a subdivision (FS131-KA1's skeleton)

`bend_away_part` (`Plane/ValidMap/BendStep`) bends a constant-sided unit arc away from its centre everywhere but on its radius-2
contacts. The plan (`plans/FS131-bendaway-kernel-plan.md`): cut `[θ₁, θ₂]` at finitely many angles so that each open piece is wholly
contact or wholly contact-free (`R2Subdiv`), leave a contact piece alone (`AwayBend.idle`), bend a contact-free piece — a *gap* — by the
outward collar bend (`bend_away_gap`, `Plane/ValidMap/BendGap`), and compose (`AwayBend.join`). This module holds what the composition
reads and nothing of the collar:

* `AwayBend F M h K P a b c ε` — **the clause package** of one bend over `[a, b]`: `bend_away_part`'s clauses, with two that make the
  package compose (`ring_K`: the collar meets `ω(P)` only on the closed arc; `rest`: all but finitely many non-contact interior angles
  are bent) in place of the last clause, which is derived once at the end (`AwayBend.contact_of_onRingArc`).
* `R2Subdiv C a b` — a finite subdivision of `[a, b]` into pieces wholly in `C` or wholly off it, as an inductive predicate, so the bend
  is an induction on it.
* `LocalStep.union` — two local steps in a row are a local step on the union.

**Models.** `AwayBend`: `AwayBend.idle` (the idle bend, on any valid map with a ring arc — `l60Frag`, `l60Frag_isRingArc`); a moving
one is `bend_away_gap`'s. `R2Subdiv`: the spec examples below.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **A finite subdivision of `[a, b]` by a set `C` of angles**: each open piece lies in `C` (`contact`) or misses it (`gap`). -/
inductive R2Subdiv (C : Set ℝ) : ℝ → ℝ → Prop
  /-- A piece whose open interval lies in `C`. -/
  | contact {a b : ℝ} : a < b → Ioo a b ⊆ C → R2Subdiv C a b
  /-- A piece whose open interval misses `C`. -/
  | gap {a b : ℝ} : a < b → Disjoint (Ioo a b) C → R2Subdiv C a b
  /-- Two subdivisions end to end. -/
  | join {a b c : ℝ} : R2Subdiv C a b → R2Subdiv C b c → R2Subdiv C a c

/-- A subdivided interval has positive length. -/
theorem R2Subdiv.lt {C : Set ℝ} {a b : ℝ} (h : R2Subdiv C a b) : a < b := by
  induction h with
  | contact hab _ => exact hab
  | gap hab _ => exact hab
  | join _ _ ih1 ih2 => exact ih1.trans ih2

/-- **A subdivision from local ones** (plan § 3, child D6; pure order and compactness): if every point of `[a, b]` has a
neighbourhood all of whose sub-intervals of `[a, b]` are subdivided, then `[a, b]` is. Route: a Lebesgue number `δ` of the cover
(`lebesgue_number_lemma_of_metric`), `n` with `(b − a)/n < δ`, and `join` along `a + j (b − a)/n` by induction on `j`. **Open —
`sorry`.** Inhabitant of the hypotheses: `C = ∅` (every interval is one gap). -/
theorem R2Subdiv.of_local {C : Set ℝ} {a b : ℝ} (hab : a < b)
    (hloc : ∀ x ∈ Icc a b, ∃ δ > 0, ∀ u v, u < v → u ∈ Icc a b → v ∈ Icc a b → |u - x| < δ → |v - x| < δ →
      R2Subdiv C u v) : R2Subdiv C a b := by
  sorry

/-- Spec: one piece off the empty set; one piece in the whole line; two pieces around a point of a one-point set. -/
example : R2Subdiv (∅ : Set ℝ) 0 1 := .gap one_pos (disjoint_empty _)

example : R2Subdiv (univ : Set ℝ) 0 1 := .contact one_pos (subset_univ _)

example : R2Subdiv ({1} : Set ℝ) 0 2 :=
  .join (.gap one_pos (by rw [Set.disjoint_singleton_right]; exact fun h => lt_irrefl _ h.2))
    (.gap (by norm_num) (by rw [Set.disjoint_singleton_right]; exact fun h => lt_irrefl _ h.1))

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Two local steps in a row are a local step on the union** (`keep` and `new` chase an arc through the middle map). -/
theorem LocalStep.union {M₁ M₂ : ArcMap k} {K₁ K₂ : Set ℂ} (h1 : LocalStep F M₁ K₁) (h2 : LocalStep M₁ M₂ K₂) :
    LocalStep F M₂ (K₁ ∪ K₂) where
  agreesOff := by
    refine ⟨h1.agreesOff.1.trans h2.agreesOff.1, fun z hz => ?_⟩
    have hz1 : z ∉ K₁ := fun h => hz (Or.inl h)
    have hz2 : z ∉ K₂ := fun h => hz (Or.inr h)
    exact ⟨(h1.agreesOff.2 z hz1).1.trans (h2.agreesOff.2 z hz2).1, (h1.agreesOff.2 z hz1).2.trans (h2.agreesOff.2 z hz2).2⟩
  keep := fun a ha hd =>
    h2.keep a (h1.keep a ha (hd.mono_right subset_union_left)) (hd.mono_right subset_union_right)
  new := by
    intro b hb hbF
    by_cases hb1 : b ∈ M₁.arcs
    · rcases h1.new b hb1 hbF with h | ⟨a, ha, hne, hsub⟩
      · exact Or.inl (h.trans subset_union_left)
      · exact Or.inr ⟨a, ha, hne.mono (inter_subset_inter_right _ subset_union_left), hsub⟩
    · rcases h2.new b hb hb1 with h | ⟨a₁, ha₁, hne, hsub⟩
      · exact Or.inl (h.trans subset_union_right)
      · by_cases ha₁F : a₁ ∈ F.arcs
        · exact Or.inr ⟨a₁, ha₁F, hne.mono (inter_subset_inter_right _ subset_union_right), hsub⟩
        · rcases h1.new a₁ ha₁ ha₁F with h | ⟨a, ha, hne', hsub'⟩
          · exact Or.inl ((hsub.trans h).trans subset_union_left)
          · exact Or.inr ⟨a, ha, hne'.mono (inter_subset_inter_right _ subset_union_left), hsub.trans hsub'⟩

/-- **A cut-and-new-arcs map is a local step** (FS131-IA1's W1 and W2 in one statement, for both collar bends): if `M` agrees with `F`
off `K`, its arcs are `F`'s with the open arc `r((θ₁, θ₂))` of `ω(P)` cut out (`cutArcs`) and a set `S` of new arcs inside `K`, and `K`
holds the closed arc, then `M` is a local step of `F` on `K`. `keep` (W1): an arc of `ω(P)` missing the closed arc is its own piece
(`m := ⌊(θa − θ₂)/(2π)⌋`). `new` (W2): a proper piece's arc holds `r(θ₁)` or `r(θ₂)` (`cutArcs_subset`). **Open — `sorry`** (plan § 3,
child D5). Inhabitant of the hypotheses: the toward collar bend, `CollarFit.map` with `S = {collarArcA, collarArcB}` and `K = collarK`
(`CollarFit.map_agreesOff`, `collarModel`). -/
theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
    (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K := by
  sorry

/-- **The away bend's clause package** over the closed arc `r([a, b])` of `ω(P)` with inner colour `c`: `M` is `F` bent by the
homeomorphism `h`, supported in the compact set `K` within `ε` of the arc. The fields are `bend_away_part`'s clauses with the arc's
ends `a`, `b`, except: `ring_K` (new: `K` meets `ω(P)` only on the closed arc) and `rest` (all but finitely many interior angles off the
radius-2 contacts are bent) stand in for the last clause, which follows from them (`AwayBend.contact_of_onRingArc`). -/
structure AwayBend (F M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (P : ℂ) (a b : ℝ) (c : Fin k) (ε : ℝ) : Prop where
  /-- The bent map is valid. -/
  valid : M.Valid
  /-- The collar is compact. -/
  compact : IsCompact K
  /-- The collar lies within `ε` of the closed arc. -/
  thick : K ⊆ thickening ε (ringArc P a b)
  /-- The collar meets `Γ` only on the closed arc. -/
  free : F.Γ ∩ K ⊆ ringArc P a b
  /-- The collar meets `ω(P)` only on the closed arc. -/
  ring_K : K ∩ sphere P 1 ⊆ ringArc P a b
  /-- The bend is a local step on the collar. -/
  step : LocalStep F M K
  /-- Off the collar the homeomorphism is the identity. -/
  fix_off : ∀ z ∉ K, h z = z
  /-- The collar is carried into itself. -/
  maps : ∀ z ∈ K, h z ∈ K
  /-- `Γ` off the open arc is fixed. -/
  fix_Γ : ∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo a b → h z = z
  /-- Interior points and their colours are carried. -/
  interior : ∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)
  /-- The colours at a point are carried. -/
  colours : ∀ z, M.coloursAt (h z) = F.coloursAt z
  /-- Degrees are carried. -/
  degree : ∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n
  /-- Repeated colours are carried. -/
  repeated : ∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z
  /-- No horn count rises (the arc step's form). -/
  horn : ∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j'
  /-- No unit arc is created. -/
  within : M.RingArcsWithin F
  /-- R1: the constant-sided unit arcs of `M` are `F`'s, with the same sides. -/
  r1 : ∀ Q a' b' d d', M.IsRingArc Q a' b' d d' → F.IsRingArc Q a' b' d d'
  /-- R2: `F`'s constant-sided unit arcs off the open arc survive. -/
  r2 : ∀ Q a' b' d d', F.IsRingArc Q a' b' d d' → Disjoint (ringPt Q '' Ioo a' b') (ringPt P '' Ioo a b) →
    M.IsRingArc Q a' b' d d'
  /-- Each interior point of the arc is fixed or becomes an interior point of the inner colour. -/
  bent : ∀ θ ∈ Ioo a b, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region c
  /-- All but finitely many interior angles off the radius-2 contacts are bent. -/
  rest : {θ | θ ∈ Ioo a b ∧ ringPt P θ ∉ M.region c ∧ P + 2 * e θ ∉ closure (F.region c)}.Finite

/-- **The idle bend** over a piece all of whose interior angles are radius-2 contacts: `M = F`, `h = id`, `K = ∅` (plan § 3, child
D1: every field is `rfl`-like, `rest` is empty by `hC`). It reads neither a ring arc nor `0 < ε` (inventory ruling 446 (b)).
Inhabitant of the hypotheses: none named in Lean — an (R2) witness at a ring arc of a valid map is the open gate item of `BendStep`'s
header (ruling 427 (d)). -/
theorem AwayBend.idle (hF : F.Valid) {P : ℂ} {a b : ℝ} {c : Fin k}
    (hC : ∀ θ ∈ Ioo a b, P + 2 * e θ ∈ closure (F.region c)) {ε : ℝ} :
    AwayBend F F (Homeomorph.refl ℂ) ∅ P a b c ε where
  valid := hF
  compact := isCompact_empty
  thick := empty_subset _
  free := fun _ h => h.2.elim
  ring_K := fun _ h => h.1.elim
  step := LocalStep.refl F ∅
  fix_off := fun _ _ => rfl
  maps := fun _ h => h.elim
  fix_Γ := fun _ _ _ => rfl
  interior := fun _ => ⟨Iff.rfl, fun _ => rfl⟩
  colours := fun _ => rfl
  degree := fun _ _ => Iff.rfl
  repeated := fun _ => Iff.rfl
  horn := fun _ j h => ⟨j, le_rfl, h⟩
  within := fun _ _ h => h
  r1 := fun _ _ _ _ _ h => h
  r2 := fun _ _ _ _ _ h _ => h
  bent := fun _ _ => Or.inl rfl
  rest := by
    convert Set.finite_empty (α := ℝ)
    exact Set.eq_empty_of_forall_notMem fun θ hθ => hθ.2.2 (hC θ hθ.1)

/-- **What the next piece reads of a bent map** (plan § 3, child D2): after a bend over `[a, b]` within `ε ≤ 1/2`, the piece `(b, c₂)` of
a ring arc `r([a, c₂])` of `F` is a ring arc of `M` with the same sides, the inner colour is still absent at `P`, `Γ_M` is `ω(P)` alone
near its interior points, and the radius-2 contacts are `F`'s (the collar stays within `1/2` of `ω(P)`). **Open — `sorry`.** -/
theorem AwayBend.next {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {a b c₂ ε : ℝ} {c c' : Fin k} (hF : F.Valid)
    (hA : F.IsRingArc P a c₂ c c') (hab : a < b) (hbc : b < c₂) (hε : ε ≤ 1 / 2) (hin : c ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo a c₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hb : AwayBend F M h K P a b c ε) :
    M.IsRingArc P b c₂ c c' ∧ c ∉ M.coloursAt P ∧
      (∀ θ ∈ Ioo b c₂, ∃ r > 0, M.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) ∧
      ∀ θ, P + 2 * e θ ∈ closure (M.region c) ↔ P + 2 * e θ ∈ closure (F.region c) := by
  sorry

/-- **Two bends end to end** (plan § 3, child D3): a bend of `F` over `[a, b]` and a bend of the result over `[b, c₂]`, both within
`ε ≤ 1/2` of their arcs, are a bend of `F` over `[a, c₂]` by the composite homeomorphism on the union of the collars. **Open —
`sorry`**; every field is checked by hand in the plan (the fields `ring_K`, `interior` and `rest` are what make `bent` and `rest`
compose). -/
theorem AwayBend.join {M₁ M₂ : ArcMap k} {h₁ h₂ : ℂ ≃ₜ ℂ} {K₁ K₂ : Set ℂ} {P : ℂ} {a b c₂ ε : ℝ} {c c' : Fin k} (hF : F.Valid)
    (hA : F.IsRingArc P a c₂ c c') (hab : a < b) (hbc : b < c₂) (hε : ε ≤ 1 / 2) (h1 : AwayBend F M₁ h₁ K₁ P a b c ε)
    (h2 : AwayBend M₁ M₂ h₂ K₂ P b c₂ c ε) : AwayBend F M₂ (h₁.trans h₂) (K₁ ∪ K₂) P a c₂ c ε := by
  sorry

/-- **`bend_away_part`'s last clause from the package** (plan § 3, child D4; the pointwise form the arc step reads, inventory ruling
444): an interior point of the arc still on a unit arc of `M` about `P` has its radius-2 point in the closure of the inner colour's
class — the arc of `M` through it holds unbent angles accumulating at `θ`, all but finitely many of them contacts (`rest`), and the
contacts are closed. **Open — `sorry`.** -/
theorem AwayBend.contact_of_onRingArc {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ ε : ℝ} {c : Fin k}
    (hb : AwayBend F M h K P θ₁ θ₂ c ε) {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (hon : M.OnRingArc P (ringPt P θ)) :
    P + 2 * e θ ∈ closure (F.region c) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
