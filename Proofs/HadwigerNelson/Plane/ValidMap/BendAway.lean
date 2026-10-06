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
neighbourhood all of whose sub-intervals of `[a, b]` are subdivided, then `[a, b]` is. A Lebesgue number `η` of the cover
(`lebesgue_number_lemma_of_metric`) makes every sub-interval shorter than `η` subdivided; `n` with `(b − a)/n < η`, and `join` along
`a + (j + 1)(b − a)/n` by induction on `j`. Inhabitant of the hypotheses: `C = ∅` (every interval is one gap). -/
theorem R2Subdiv.of_local {C : Set ℝ} {a b : ℝ} (hab : a < b)
    (hloc : ∀ x ∈ Icc a b, ∃ δ > 0, ∀ u v, u < v → u ∈ Icc a b → v ∈ Icc a b → |u - x| < δ → |v - x| < δ →
      R2Subdiv C u v) : R2Subdiv C a b := by
  choose! δ hδ hsub using hloc
  obtain ⟨η, hη, hleb⟩ := lebesgue_number_lemma_of_metric (ι := Icc a b) (c := fun x => ball (x : ℝ) (δ x)) isCompact_Icc
    (fun _ => isOpen_ball) (fun x hx => mem_iUnion.mpr ⟨⟨x, hx⟩, mem_ball_self (hδ x hx)⟩)
  -- every sub-interval shorter than the Lebesgue number is subdivided
  have hshort : ∀ u v, u < v → u ∈ Icc a b → v ∈ Icc a b → v - u < η → R2Subdiv C u v := by
    intro u v huv hu hv hlt
    obtain ⟨⟨x, hx⟩, hball⟩ := hleb u hu
    have h1 : u ∈ ball x (δ x) := hball (mem_ball_self hη)
    have h2 : v ∈ ball x (δ x) := hball (by rw [mem_ball, Real.dist_eq, abs_of_pos (sub_pos.mpr huv)]; exact hlt)
    rw [mem_ball, Real.dist_eq] at h1 h2
    exact hsub x hx u v huv hu hv h1 h2
  have hba : 0 < b - a := sub_pos.mpr hab
  obtain ⟨n, hn⟩ := exists_nat_gt ((b - a) / η)
  have hn0 : (0 : ℝ) < n := (div_pos hba hη).trans hn
  obtain ⟨d, hd⟩ : ∃ d : ℝ, d = (b - a) / n := ⟨_, rfl⟩
  have hd0 : 0 < d := by rw [hd]; exact div_pos hba hn0
  have hnd : (n : ℝ) * d = b - a := by rw [hd]; field_simp
  have hdη : d < η := by
    rw [div_lt_iff₀ hη] at hn
    rw [hd, div_lt_iff₀ hn0]
    linarith [mul_comm (n : ℝ) η]
  -- the first `j + 1` steps of length `d`
  have key : ∀ j : ℕ, (j : ℝ) + 1 ≤ n → R2Subdiv C a (a + ((j : ℝ) + 1) * d) := by
    intro j
    induction j with
    | zero =>
      intro h
      have h1 : ((0 : ℕ) : ℝ) + 1 = 1 := by norm_num
      rw [h1, one_mul]
      rw [h1] at h
      exact hshort a (a + d) (by linarith) ⟨le_rfl, hab.le⟩ ⟨by linarith, by nlinarith⟩ (by linarith)
    | succ j ih =>
      intro h
      push_cast at h ⊢
      have hj : (0 : ℝ) ≤ j := Nat.cast_nonneg j
      have hle : ((j : ℝ) + 1 + 1) * d ≤ b - a := by rw [← hnd]; exact mul_le_mul_of_nonneg_right h hd0.le
      refine (ih (by linarith)).join (hshort _ _ (by nlinarith) ⟨by nlinarith, by nlinarith⟩ ⟨by nlinarith, by linarith⟩
        (by nlinarith))
  obtain ⟨m, rfl⟩ : ∃ m : ℕ, n = m + 1 := Nat.exists_eq_succ_of_ne_zero (by rintro rfl; simp at hn0)
  have hfin := key m (by push_cast; exact le_rfl)
  have hend : a + ((m : ℝ) + 1) * d = b := by push_cast at hnd; linarith
  rwa [hend] at hfin

/-- Spec: one piece off the empty set; one piece in the whole line; two pieces around a point of a one-point set. -/
example : R2Subdiv (∅ : Set ℝ) 0 1 := .gap one_pos (disjoint_empty _)

example : R2Subdiv (univ : Set ℝ) 0 1 := .contact one_pos (subset_univ _)

example : R2Subdiv ({1} : Set ℝ) 0 2 :=
  .join (.gap one_pos (by rw [Set.disjoint_singleton_right]; exact fun h => lt_irrefl _ h.2))
    (.gap (by norm_num) (by rw [Set.disjoint_singleton_right]; exact fun h => lt_irrefl _ h.1))

/-- Spec: `R2Subdiv.of_local` at its hypotheses' inhabitant `C = ∅` (near every point, every sub-interval is one gap), and at
`C = {1}` on `[0, 2]` — near `1` a sub-interval is cut at `1` when it straddles it, as `exists_r2Subdiv` cuts at a contact's end. -/
example : R2Subdiv (∅ : Set ℝ) 0 1 :=
  R2Subdiv.of_local one_pos fun _ _ => ⟨1, one_pos, fun _ _ huv _ _ _ _ => .gap huv (disjoint_empty _)⟩

example : R2Subdiv ({1} : Set ℝ) 0 2 :=
  R2Subdiv.of_local (by norm_num) fun _ _ => ⟨1, one_pos, fun u v huv _ _ _ _ => by
    have hgap : ∀ {p q : ℝ}, p < q → (1 ≤ p ∨ q ≤ 1) → R2Subdiv ({1} : Set ℝ) p q := fun hpq h =>
      .gap hpq (by
        rw [Set.disjoint_singleton_right]
        rintro ⟨h1, h2⟩
        rcases h with h | h <;> linarith)
    by_cases h1 : u < 1 ∧ 1 < v
    · exact .join (hgap h1.1 (Or.inr le_rfl)) (hgap h1.2 (Or.inl le_rfl))
    · rw [not_and_or, not_lt, not_lt] at h1
      exact hgap huv h1⟩

/-- Two angles less than a turn apart with one point of `ω(P)` are equal (`e_eq_e_iff`; `ringPt_ne_of_abs_sub_lt` of
`Plane/ValidMap/BaseDense`, which this module is upstream of, is its contrapositive). -/
theorem ringPt_inj_of_abs_sub_lt {P : ℂ} {θ θ' : ℝ} (h : |θ - θ'| < 2 * π) (he : ringPt P θ = ringPt P θ') : θ = θ' := by
  have hπ := Real.pi_pos
  have he' : e θ = e θ' := by simpa [ringPt] using he
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he'
  have h1 : |(n : ℝ)| * (2 * π) < 2 * π := by
    rw [show θ - θ' = (n : ℝ) * (2 * π) by linarith, abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * π)] at h
    exact h
  have h2 : |(n : ℝ)| < 1 := by
    by_contra hge
    push Not at hge
    nlinarith
  have h3 : n = 0 := by
    have : |n| < 1 := by exact_mod_cast h2
    exact Int.abs_lt_one_iff.mp this
  rw [hn, h3]; simp

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
(`m := ⌊(θa − θ₂)/(2π)⌋`). `new` (W2): a proper piece's arc holds `r(θ₁)` or `r(θ₂)`. **The proof is FS131-IA2's**, copied from its
module `Plane/ValidMap/ArcStep` on branch `fs131-w5y` (at `3f8270c0`, l. 584–663), where the same statement was proved first (plan
§ 3, child D5; inventory items 443, 448 (a)); at the final sync that copy is deleted and this declaration kept. Inhabitant of the
hypotheses: the toward collar bend, `CollarFit.map` with `S = {collarArcA, collarArcB}` and `K = collarK`
(`CollarFit.map_agreesOff`, `collarModel`). -/
theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
    (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K := by
  have hπ := Real.pi_pos
  have h2π : 0 < 2 * π := by positivity
  have hturn : ∀ (t : ℝ) (m : ℤ), ringPt P (t + m * (2 * π)) = ringPt P t := fun t m => by
    rw [ringPt, ringPt, show t + (m : ℝ) * (2 * π) = t + 2 * π * m by ring, e_add_int_mul]
  refine ⟨hag, fun a ha hd => ?_, fun b hb hbF => ?_⟩
  · rw [harcs]
    left
    by_cases hne : ∀ θa θb, a ≠ .circ P 1 θa θb
    · exact Or.inl ⟨ha, hne⟩
    · push Not at hne
      obtain ⟨θa, θb, rfl⟩ := hne
      obtain ⟨-, hab, -⟩ := F.nondegenerate _ ha
      right
      obtain ⟨m, hm⟩ : ∃ m : ℤ, m = ⌊(θa - θ₂) / (2 * π)⌋ := ⟨_, rfl⟩
      have hm1 : (m : ℝ) * (2 * π) ≤ θa - θ₂ := by
        have := Int.floor_le ((θa - θ₂) / (2 * π))
        rw [← hm] at this
        rwa [le_div_iff₀ h2π] at this
      have hm2 : θa - θ₂ < ((m : ℝ) + 1) * (2 * π) := by
        have := Int.lt_floor_add_one ((θa - θ₂) / (2 * π))
        rw [← hm] at this
        rwa [div_lt_iff₀ h2π] at this
      have hlo : cutLo θ₂ θa m = θa := max_eq_left (by linarith)
      have hhi : cutHi θ₁ θb m = θb := by
        refine min_eq_left ?_
        by_contra hlt
        push Not at hlt
        -- otherwise the arc holds a point of the closed arc, a point of `K`
        have ht1 : max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) ≤ θb := max_le hab.le hlt.le
        have ht2 : max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) ≤ θ₂ + ((m : ℝ) + 1) * (2 * π) :=
          max_le (by linarith) (by linarith)
        have ht3 : θ₁ + ((m : ℝ) + 1) * (2 * π) ≤ max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) := le_max_right _ _
        have hmem : ringPt P (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π))) ∈ (Arc.circ P 1 θa θb).carrier := by
          rw [carrier_circ_one]
          exact ⟨_, ⟨le_max_left _ _, ht1⟩, rfl⟩
        have hK' : ringPt P (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π))) ∈ K := by
          have := hturn (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) - ((m + 1 : ℤ) : ℝ) * (2 * π)) (m + 1)
          rw [sub_add_cancel] at this
          rw [this]
          refine hK ⟨_, ⟨?_, ?_⟩, rfl⟩
          · push_cast; linarith
          · push_cast; linarith
        exact Set.disjoint_left.mp hd hmem hK'
      exact ⟨θa, θb, ha, m, by rw [hlo, hhi]; exact hab, by rw [hlo, hhi]⟩
  · rw [harcs] at hb
    rcases hb with hb | hb
    · rcases hb with ⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩
      · exact absurd hb hbF
      · right
        refine ⟨_, ha, ?_, ?_⟩
        · have hne : cutLo θ₂ θa m ≠ θa ∨ cutHi θ₁ θb m ≠ θb := by
            by_contra hcon
            push Not at hcon
            rw [hcon.1, hcon.2] at hbF
            exact hbF ha
          have hlo : θa ≤ cutLo θ₂ θa m := le_max_left _ _
          have hhi : cutHi θ₁ θb m ≤ θb := min_le_left _ _
          rcases hne with hne | hne
          · have hlo' : cutLo θ₂ θa m = θ₂ + m * (2 * π) := by
              rcases max_choice θa (θ₂ + m * (2 * π)) with h | h
              · exact absurd h hne
              · exact h
            refine ⟨ringPt P θ₂, ?_, hK ⟨θ₂, ⟨h12.le, le_rfl⟩, rfl⟩⟩
            rw [carrier_circ_one, ← hturn θ₂ m]
            exact ⟨_, ⟨by rw [← hlo']; exact hlo, by rw [← hlo']; linarith⟩, rfl⟩
          · have hhi' : cutHi θ₁ θb m = θ₁ + (m + 1) * (2 * π) := by
              rcases min_choice θb (θ₁ + (m + 1) * (2 * π)) with h | h
              · exact absurd h hne
              · exact h
            refine ⟨ringPt P θ₁, ?_, hK ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩⟩
            have hθ₁ := hturn θ₁ (m + 1)
            rw [carrier_circ_one, ← hθ₁]
            refine ⟨_, ⟨?_, ?_⟩, rfl⟩
            · push_cast; rw [← hhi']; linarith
            · push_cast; rw [← hhi']; exact hhi
        · rw [carrier_circ_one, carrier_circ_one]
          exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _))
    · exact Or.inl (hS b hb)

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

/-! ### What the composition reads of one bend

Three facts of a package, none of them geometry beyond angles: off the collar the two maps have the same `Γ` and classes
(`AgreesOff`, pointwise); a collar within `1/2` of `ω(P)` stays off `P` and off the radius-2 circle, so the colours at radius-2 points
are kept (`closure_region_iff`); and the collar meets `ω(P)` only on its own closed arc (`ring_K`), so the points of `ω(P)` at other
angles of a short arc are off it (`ringPt_notMem`). -/

/-- Off the set of an agreement, a point is on `Γ` of both maps or of neither. -/
theorem AgreesOff.mem_Γ_iff_of_notMem {M : ArcMap k} {U : Set ℂ} (h : M.AgreesOff F U) {z : ℂ} (hz : z ∉ U) :
    z ∈ M.Γ ↔ z ∈ F.Γ := by
  rw [M.mem_Γ_iff, F.mem_Γ_iff, h.1, (h.2 z hz).1]

/-- Off the set of an agreement, a point is in a class of both maps or of neither. -/
theorem AgreesOff.mem_region_iff_of_notMem {M : ArcMap k} {U : Set ℂ} (h : M.AgreesOff F U) {z : ℂ} (hz : z ∉ U) (j : Fin k) :
    z ∈ M.region j ↔ z ∈ F.region j := by
  obtain ⟨h1, h2⟩ := h.2 z hz
  simp only [region, mem_inter_iff, mem_preimage, mem_singleton_iff, h1, h2]

/-- **A collar within `1/2` of `ω(P)`** holds only points at distance between `1/2` and `3/2` from `P`. -/
theorem AwayBend.dist_centre {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {a b ε : ℝ} {c : Fin k}
    (hb : AwayBend F M h K P a b c ε) (hε : ε ≤ 1 / 2) {z : ℂ} (hz : z ∈ K) : 1 / 2 < dist z P ∧ dist z P < 3 / 2 := by
  obtain ⟨x, ⟨θ, -, rfl⟩, hzx⟩ := Metric.mem_thickening_iff.mp (hb.thick hz)
  have h1 := dist_ringPt P θ
  have h2 := dist_triangle z (ringPt P θ) P
  have h3 := dist_triangle (ringPt P θ) z P
  rw [dist_comm (ringPt P θ) z] at h3
  exact ⟨by linarith, by linarith⟩

/-- **The colours at a radius-2 point are kept** by a bend within `ε ≤ 1/2`: the collar stays within `3/2` of `P`, so the two maps
agree on the ball of radius `1/2` about a point at distance `2` from `P`. -/
theorem AwayBend.closure_region_iff {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {a b ε : ℝ} {c : Fin k}
    (hb : AwayBend F M h K P a b c ε) (hε : ε ≤ 1 / 2) {w : ℂ} (hw : dist w P = 2) (j : Fin k) :
    w ∈ closure (M.region j) ↔ w ∈ closure (F.region j) := by
  refine mem_closure_iff_of_inter_eq isOpen_ball (mem_ball_self (by norm_num : (0 : ℝ) < 1 / 2)) ?_
  ext y
  simp only [mem_inter_iff, and_congr_left_iff]
  intro hy
  refine hb.step.agreesOff.mem_region_iff_of_notMem (fun hyK => ?_) j
  have h1 := (hb.dist_centre hε hyK).2
  have h2 := dist_triangle w y P
  rw [mem_ball, dist_comm] at hy
  linarith

/-- **A point of `ω(P)` at an angle off the closed arc, less than a turn from each of its angles, is off the collar** (`ring_K`). -/
theorem AwayBend.ringPt_notMem {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {a b ε : ℝ} {c : Fin k}
    (hb : AwayBend F M h K P a b c ε) {θ : ℝ} (hθ : θ ∉ Icc a b) (hnear : ∀ θ' ∈ Icc a b, |θ' - θ| < 2 * π) :
    ringPt P θ ∉ K := by
  intro hK
  obtain ⟨θ', hθ', he⟩ := hb.ring_K ⟨hK, by rw [mem_sphere]; exact dist_ringPt P θ⟩
  exact hθ (ringPt_inj_of_abs_sub_lt (hnear θ' hθ') he ▸ hθ')

/-- **What the next piece reads of a bent map** (plan § 3, child D2): after a bend over `[a, b]` within `ε ≤ 1/2`, the piece `(b, c₂)` of
a ring arc `r([a, c₂])` of `F` is a ring arc of `M` with the same sides (`r2`: its open arc misses the bent one's), the inner colour is
still absent at `P` (`P` is off the collar), `Γ_M` is `ω(P)` alone near its interior points (they are off the closed collar, where
`Γ_M = Γ_F`), and the radius-2 contacts are `F`'s (`closure_region_iff`: the collar stays within `1/2` of `ω(P)`). -/
theorem AwayBend.next {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {a b c₂ ε : ℝ} {c c' : Fin k} (hF : F.Valid)
    (hA : F.IsRingArc P a c₂ c c') (hab : a < b) (hbc : b < c₂) (hε : ε ≤ 1 / 2) (hin : c ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo a c₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hb : AwayBend F M h K P a b c ε) :
    M.IsRingArc P b c₂ c c' ∧ c ∉ M.coloursAt P ∧
      (∀ θ ∈ Ioo b c₂, ∃ r > 0, M.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) ∧
      ∀ θ, P + 2 * e θ ∈ closure (M.region c) ↔ P + 2 * e θ ∈ closure (F.region c) := by
  have hπ := Real.pi_pos
  have hlen : c₂ - a ≤ π / 3 := l60_le hF hA
  -- the next piece's interior points are off the collar
  have hoff : ∀ θ ∈ Ioo b c₂, ringPt P θ ∉ K := fun θ hθ =>
    hb.ringPt_notMem (fun h' => not_lt.mpr h'.2 hθ.1) fun θ' hθ' => by
      rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2, hθ'.1, hθ'.2]
  refine ⟨?_, ?_, fun θ hθ => ?_, fun θ => hb.closure_region_iff hε (by simp [dist_eq_norm]) c⟩
  · refine hb.r2 P b c₂ c c' ⟨hbc, (ringArc_subset_ringArc hab.le le_rfl).trans hA.2.1,
      fun θ hθ => hA.2.2 θ ⟨hab.trans hθ.1, hθ.2⟩⟩ ?_
    rw [Set.disjoint_left]
    rintro _ ⟨θ, hθ, rfl⟩ ⟨θ', hθ', he⟩
    have heq : θ' = θ := ringPt_inj_of_abs_sub_lt
      (by rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2, hθ'.1, hθ'.2]) he
    linarith [hθ.1, hθ'.2]
  · have hPK : P ∉ K := fun hK => by
      have := (hb.dist_centre hε hK).1
      rw [dist_self] at this
      linarith
    have hcol := hb.colours P
    rw [hb.fix_off P hPK] at hcol
    rw [hcol]
    exact hin
  · obtain ⟨r₁, hr₁, hsub⟩ := hfree θ ⟨hab.trans hθ.1, hθ.2⟩
    obtain ⟨r₂, hr₂, hball⟩ := Metric.isOpen_iff.mp hb.compact.isClosed.isOpen_compl _ (hoff θ hθ)
    refine ⟨min r₁ r₂, lt_min hr₁ hr₂, fun z hz => hsub ⟨?_, ball_subset_ball (min_le_left _ _) hz.2⟩⟩
    exact (hb.step.agreesOff.mem_Γ_iff_of_notMem (hball (ball_subset_ball (min_le_right _ _) hz.2))).mp hz.1

/-- **Two bends end to end** (plan § 3, child D3): a bend of `F` over `[a, b]` and a bend of the result over `[b, c₂]`, both within
`ε ≤ 1/2` of their arcs, are a bend of `F` over `[a, c₂]` by the composite homeomorphism on the union of the collars. Field by
field: the fields `ring_K`, `interior` and `rest` are what make `bent` and `rest` compose — a bent point of the first piece is off the
second collar (`ringPt_notMem`), a point of `Γ_F` the first bend fixes is on `Γ` of the middle map (`interior`), and the middle map's
radius-2 contacts are `F`'s (`closure_region_iff`), so what is left unbent is the two pieces' leftovers and the junction angle. -/
theorem AwayBend.join {M₁ M₂ : ArcMap k} {h₁ h₂ : ℂ ≃ₜ ℂ} {K₁ K₂ : Set ℂ} {P : ℂ} {a b c₂ ε : ℝ} {c c' : Fin k} (hF : F.Valid)
    (hA : F.IsRingArc P a c₂ c c') (hab : a < b) (hbc : b < c₂) (hε : ε ≤ 1 / 2) (h1 : AwayBend F M₁ h₁ K₁ P a b c ε)
    (h2 : AwayBend M₁ M₂ h₂ K₂ P b c₂ c ε) : AwayBend F M₂ (h₁.trans h₂) (K₁ ∪ K₂) P a c₂ c ε := by
  have hπ := Real.pi_pos
  have hlen : c₂ - a ≤ π / 3 := l60_le hF hA
  have hag1 := h1.step.agreesOff
  have hag2 := h2.step.agreesOff
  have hsub1 : ringArc P a b ⊆ ringArc P a c₂ := ringArc_subset_ringArc le_rfl hbc.le
  have hsub2 : ringArc P b c₂ ⊆ ringArc P a c₂ := ringArc_subset_ringArc hab.le le_rfl
  -- angles of the arc with one point of `ω(P)` are equal
  have hinj : ∀ θ θ', θ ∈ Icc a c₂ → θ' ∈ Icc a c₂ → ringPt P θ = ringPt P θ' → θ = θ' := fun θ θ' hθ hθ' he =>
    ringPt_inj_of_abs_sub_lt (by rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2, hθ'.1, hθ'.2]) he
  -- the first piece's points, but its far end, are off the second collar
  have hoff2 : ∀ θ ∈ Ico a b, ringPt P θ ∉ K₂ := fun θ hθ =>
    h2.ringPt_notMem (fun h' => not_lt.mpr h'.1 hθ.2) fun θ' hθ' => by
      rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2, hθ'.1, hθ'.2]
  -- a point of `Γ_F` that the first bend fixes is on `Γ` of the middle map
  have hΓ1 : ∀ z ∈ F.Γ, h₁ z = z → z ∈ M₁.Γ := by
    intro z hz hfix
    rw [F.mem_Γ_iff] at hz
    rw [M₁.mem_Γ_iff, ← hag1.1]
    exact ⟨hz.1, fun hI => hz.2 ((h1.interior z).1.mp (by rwa [hfix]))⟩
  -- the points of the arc from the junction on are fixed by the first bend
  have hfix1 : ∀ θ ∈ Icc b c₂, h₁ (ringPt P θ) = ringPt P θ := fun θ hθ =>
    h1.fix_Γ _ (hA.2.1 ⟨θ, ⟨hab.le.trans hθ.1, hθ.2⟩, rfl⟩) fun ⟨θ', hθ', he⟩ => by
      have := hinj θ' θ ⟨hθ'.1.le, (hθ'.2.trans hbc).le⟩ ⟨hab.le.trans hθ.1, hθ.2⟩ he
      linarith [hθ'.2, hθ.1]
  refine
    { valid := h2.valid
      compact := h1.compact.union h2.compact
      thick := union_subset (h1.thick.trans (thickening_subset_of_subset ε hsub1))
        (h2.thick.trans (thickening_subset_of_subset ε hsub2))
      free := ?_
      ring_K := ?_
      step := h1.step.union h2.step
      fix_off := fun z hz => ?_
      maps := fun z hz => ?_
      fix_Γ := fun z hz hzO => ?_
      interior := fun z => ⟨(h2.interior (h₁ z)).1.trans (h1.interior z).1,
        fun hz => ((h2.interior (h₁ z)).2 ((h1.interior z).1.mpr hz)).trans ((h1.interior z).2 hz)⟩
      colours := fun z => (h2.colours (h₁ z)).trans (h1.colours z)
      degree := fun z n => (h2.degree (h₁ z) n).trans (h1.degree z n)
      repeated := fun z => (h2.repeated (h₁ z)).trans (h1.repeated z)
      horn := fun x j hj => ?_
      within := fun p x hx => h1.within p x (h2.within p x hx)
      r1 := fun Q a' b' d d' hM => h1.r1 Q a' b' d d' (h2.r1 Q a' b' d d' hM)
      r2 := fun Q a' b' d d' hD hdis => h2.r2 Q a' b' d d'
        (h1.r2 Q a' b' d d' hD (hdis.mono_right (image_mono (Ioo_subset_Ioo le_rfl hbc.le))))
        (hdis.mono_right (image_mono (Ioo_subset_Ioo hab.le le_rfl)))
      bent := fun θ hθ => ?_
      rest := ?_ }
  · -- `free`
    rintro z ⟨hzΓ, hzK⟩
    by_cases hz1 : z ∈ K₁
    · exact hsub1 (h1.free ⟨hzΓ, hz1⟩)
    · exact hsub2 (h2.free ⟨(hag1.mem_Γ_iff_of_notMem hz1).mpr hzΓ, hzK.resolve_left hz1⟩)
  · -- `ring_K`
    rintro z ⟨hzK | hzK, hzs⟩
    · exact hsub1 (h1.ring_K ⟨hzK, hzs⟩)
    · exact hsub2 (h2.ring_K ⟨hzK, hzs⟩)
  · -- `fix_off`
    show h₂ (h₁ z) = z
    rw [h1.fix_off z fun h' => hz (Or.inl h'), h2.fix_off z fun h' => hz (Or.inr h')]
  · -- `maps`
    show h₂ (h₁ z) ∈ K₁ ∪ K₂
    by_cases hz1 : z ∈ K₁
    · by_cases h' : h₁ z ∈ K₂
      · exact Or.inr (h2.maps _ h')
      · rw [h2.fix_off _ h']; exact Or.inl (h1.maps z hz1)
    · rw [h1.fix_off z hz1]; exact Or.inr (h2.maps z (hz.resolve_left hz1))
  · -- `fix_Γ`
    have hz1 : h₁ z = z := h1.fix_Γ z hz fun ⟨θ, hθ, he⟩ => hzO ⟨θ, ⟨hθ.1, hθ.2.trans hbc⟩, he⟩
    show h₂ (h₁ z) = z
    rw [hz1]
    exact h2.fix_Γ z (hΓ1 z hz hz1) fun ⟨θ, hθ, he⟩ => hzO ⟨θ, ⟨hab.trans hθ.1, hθ.2⟩, he⟩
  · -- `horn`
    obtain ⟨j₁, hj₁, hc₁⟩ := h1.horn x j hj
    obtain ⟨j₂, hj₂, hc₂⟩ := h2.horn x j₁ hc₁
    exact ⟨j₂, hj₂.trans hj₁, hc₂⟩
  · -- `bent`
    show h₂ (h₁ (ringPt P θ)) = ringPt P θ ∨ ringPt P θ ∈ M₂.region c
    rcases lt_or_ge θ b with hlt | hge
    · have hK2 : ringPt P θ ∉ K₂ := hoff2 θ ⟨hθ.1.le, hlt⟩
      rcases h1.bent θ ⟨hθ.1, hlt⟩ with hfix | hreg
      · left; rw [hfix, h2.fix_off _ hK2]
      · right; exact (hag2.mem_region_iff_of_notMem hK2 c).mpr hreg
    · have hf := hfix1 θ ⟨hge, hθ.2.le⟩
      have hΓθ : ringPt P θ ∈ M₁.Γ := hΓ1 _ (hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩) hf
      rw [hf]
      rcases hge.lt_or_eq with hgt | heq
      · exact h2.bent θ ⟨hgt, hθ.2⟩
      · left
        refine h2.fix_Γ _ hΓθ fun ⟨θ', hθ', he⟩ => ?_
        have := hinj θ' θ ⟨hab.le.trans hθ'.1.le, hθ'.2.le⟩ (Ioo_subset_Icc_self hθ) he
        linarith [hθ'.1]
  · -- `rest`
    refine ((h1.rest.union (Set.finite_singleton b)).union h2.rest).subset ?_
    rintro θ ⟨hθ, hreg, hcl⟩
    rcases lt_trichotomy θ b with hlt | heq | hgt
    · exact Or.inl (Or.inl ⟨⟨hθ.1, hlt⟩,
        fun hreg1 => hreg ((hag2.mem_region_iff_of_notMem (hoff2 θ ⟨hθ.1.le, hlt⟩) c).mpr hreg1), hcl⟩)
    · exact Or.inl (Or.inr heq)
    · exact Or.inr ⟨⟨hgt, hθ.2⟩, hreg,
        fun hcl1 => hcl ((h1.closure_region_iff hε (by simp [dist_eq_norm]) c).mp hcl1)⟩

/-- **`bend_away_part`'s last clause from the package** (plan § 3, child D4; the pointwise form the arc step reads, inventory ruling
444): an interior point of the arc still on a unit arc of `M` about `P` has its radius-2 point in the closure of the inner colour's
class — the arc of `M` through it holds a non-degenerate interval of unbent angles with `θ` at an end; were `θ` no contact, the
contacts being closed, a non-degenerate interval of non-contact unbent angles would lie in the finite set `rest`. -/
theorem AwayBend.contact_of_onRingArc {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ ε : ℝ} {c : Fin k}
    (hb : AwayBend F M h K P θ₁ θ₂ c ε) {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (hon : M.OnRingArc P (ringPt P θ)) :
    P + 2 * e θ ∈ closure (F.region c) := by
  obtain ⟨a₀, b₀, hab, ⟨t, ht, hte⟩, hsub⟩ := hon
  have hπ := Real.pi_pos
  have het : e t = e θ := by simpa [ringPt] using hte
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp het
  -- an angle `φ` with `φ + n · 2π ∈ [a₀, b₀]` is on `Γ_M`, so not in the class
  have hΓ : ∀ φ : ℝ, φ + n * (2 * π) ∈ Icc a₀ b₀ → ringPt P φ ∉ M.region c := by
    intro φ hφ hreg
    have hmem : ringPt P (φ + n * (2 * π)) ∈ M.Γ := hsub ⟨_, hφ, rfl⟩
    rw [show ringPt P (φ + n * (2 * π)) = ringPt P φ by
      rw [ringPt, ringPt, show φ + (n : ℝ) * (2 * π) = φ + 2 * π * n by ring, e_add_int_mul]] at hmem
    exact hreg.1.2 hmem.2
  by_contra hnot
  have hcl : IsClosed {φ : ℝ | P + 2 * e φ ∈ closure (F.region c)} :=
    isClosed_closure.preimage (continuous_const.add (continuous_const.mul continuous_e))
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hcl.isOpen_compl θ hnot
  have hmem : ∀ φ, φ ∈ Ioo θ₁ θ₂ → φ + n * (2 * π) ∈ Icc a₀ b₀ → |φ - θ| < δ →
      φ ∈ {θ | θ ∈ Ioo θ₁ θ₂ ∧ ringPt P θ ∉ M.region c ∧ P + 2 * e θ ∉ closure (F.region c)} :=
    fun φ h1 h2 h3 => ⟨h1, hΓ φ h2, hball (by rw [mem_ball, Real.dist_eq]; exact h3)⟩
  -- a non-degenerate interval of such angles, on the side of `θ` where the arc of `M` continues
  obtain ⟨u, v, huv, hI⟩ : ∃ u v, u < v ∧
      Icc u v ⊆ {θ | θ ∈ Ioo θ₁ θ₂ ∧ ringPt P θ ∉ M.region c ∧ P + 2 * e θ ∉ closure (F.region c)} := by
    rcases ht.2.lt_or_eq with hlt | heq
    · refine ⟨θ, min (min (θ + (b₀ - t)) ((θ + θ₂) / 2)) (θ + δ / 2),
        lt_min (lt_min (by linarith) (by linarith [hθ.2])) (by linarith), fun φ hφ => ?_⟩
      have h1 : φ ≤ θ + (b₀ - t) := hφ.2.trans ((min_le_left _ _).trans (min_le_left _ _))
      have h2 : φ ≤ (θ + θ₂) / 2 := hφ.2.trans ((min_le_left _ _).trans (min_le_right _ _))
      have h3 : φ ≤ θ + δ / 2 := hφ.2.trans (min_le_right _ _)
      exact hmem φ ⟨by linarith [hφ.1, hθ.1], by linarith [hθ.2]⟩ ⟨by linarith [hφ.1, ht.1], by linarith⟩
        (by rw [abs_lt]; constructor <;> linarith [hφ.1])
    · refine ⟨max (max (θ - (t - a₀)) ((θ₁ + θ) / 2)) (θ - δ / 2), θ,
        max_lt (max_lt (by linarith) (by linarith [hθ.1])) (by linarith), fun φ hφ => ?_⟩
      have h1 : θ - (t - a₀) ≤ φ := ((le_max_left _ _).trans (le_max_left _ _)).trans hφ.1
      have h2 : (θ₁ + θ) / 2 ≤ φ := ((le_max_right _ _).trans (le_max_left _ _)).trans hφ.1
      have h3 : θ - δ / 2 ≤ φ := (le_max_right _ _).trans hφ.1
      exact hmem φ ⟨by linarith [hθ.1], by linarith [hφ.2, hθ.2]⟩ ⟨by linarith, by linarith [hφ.2, ht.2]⟩
        (by rw [abs_lt]; constructor <;> linarith [hφ.2])
  exact Set.Icc_infinite huv (hb.rest.subset hI)

end ArcMap

end HadwigerNelson.Plane
