import Proofs.HadwigerNelson.UnitQuadrance

/-!
# The finite facts of J45-SI-C and of (G2) at 7: the band colouring of `Γ₇` (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** `plans/FS84-SI-D-derivation.md` § 2.2–2.3: "`γ = ⌊4θ⌋`, `θ = (2x + 3y)/7`, is
proper on `Γ₇`; its gapped vertices are exactly the 14 with `7θ ∈ {0, 5}`, all missing colour 3, and they span 28 directed
edges"; "`Z̄ = {θ = 0}` is independent and every vertex of it is gapped with missing colour 3"; "`Z̄` is the set of gapped
vertices of colour 0"; the conditional supports of the noisy colouring — `{γ(v)}` off `Z̄`, `{0, 3}` on `Z̄` — "are disjoint
on every edge of `Γ₇`: 0 of 392 directed edges meet". These were `tools/crunch_j45_gap7.py`'s items (1)–(5), [tools exact];
here each is a `decide +kernel` against the library's `finitePlane 7`, so the row's grade "[hand + tools exact]" loses its
tools half.

`θ` is carried as the residue `7θ = 2x + 3y ∈ {0, …, 6}` (`theta7`), so `γ = ⌊4·theta7/7⌋`.

**Inhabitants.** `exists_adjacent_gapped` exhibits (G2)'s adjacent gapped pair with one missing colour, so (G2) at 7 is a
theorem, not a hypothesis.
-/

namespace HadwigerNelson.GapSeven

open SimpleGraph

/-- `7θ = 2x + 3y` as a residue in `{0, …, 6}`. -/
def theta7 (v : ZMod 7 × ZMod 7) : ℕ := (2 * v.1 + 3 * v.2).val

/-- **C9's band colouring** `γ = ⌊4θ⌋ = ⌊4·(7θ)/7⌋` of `Γ₇`. -/
def gamma (v : ZMod 7 × ZMod 7) : Fin 4 := Fin.ofNat 4 (4 * theta7 v / 7)

/-- `v` is **gapped with missing colour `m`**: `m` is absent from the closed neighbourhood of `v`. -/
def Gapped (v : ZMod 7 × ZMod 7) (m : Fin 4) : Prop :=
  gamma v ≠ m ∧ ∀ w, (finitePlane 7).Adj v w → gamma w ≠ m

instance (v : ZMod 7 × ZMod 7) (m : Fin 4) : Decidable (Gapped v m) := by unfold Gapped; infer_instance

/-- The conditional support of the noisy colouring at a vertex: `{0, 3}` on `Z̄ = {θ = 0}`, `{γ(v)}` off it. -/
def supp (v : ZMod 7 × ZMod 7) : Finset (Fin 4) := if theta7 v = 0 then {0, 3} else {gamma v}

/-- **(1)** `γ` is a proper four-colouring of `Γ₇`. -/
theorem gamma_proper : ∀ u v : ZMod 7 × ZMod 7, (finitePlane 7).Adj u v → gamma u ≠ gamma v := by
  decide +kernel

/-- **(1′)** The gapped vertices are exactly those with `7θ ∈ {0, 5}`. -/
theorem gapped_iff : ∀ v : ZMod 7 × ZMod 7, (∃ m, Gapped v m) ↔ theta7 v = 0 ∨ theta7 v = 5 := by
  decide +kernel

/-- **(1″)** Every gapped vertex misses colour 3 and no other. -/
theorem gapped_eq_three : ∀ (v : ZMod 7 × ZMod 7) (m : Fin 4), Gapped v m → m = 3 := by
  decide +kernel

/-- **(2)** `Z̄ = {θ = 0}` is the set of gapped vertices of colour 0. -/
theorem zbar_iff : ∀ v : ZMod 7 × ZMod 7, theta7 v = 0 ↔ gamma v = 0 ∧ Gapped v 3 := by
  decide +kernel

/-- **(3)** `Z̄` is independent. -/
theorem zbar_indep : ∀ u v : ZMod 7 × ZMod 7, theta7 u = 0 → theta7 v = 0 → ¬ (finitePlane 7).Adj u v := by
  decide +kernel

/-- **(4)** The supports are disjoint on every edge of `Γ₇` ("0 of 392 directed edges meet"). -/
theorem supp_disjoint : ∀ u v : ZMod 7 × ZMod 7, (finitePlane 7).Adj u v → Disjoint (supp u) (supp v) := by
  decide +kernel

/-- **(5)** (G2) at 7: two adjacent vertices, each gapped with the same missing colour. -/
theorem exists_adjacent_gapped : ∃ a b : ZMod 7 × ZMod 7, (finitePlane 7).Adj a b ∧ Gapped a 3 ∧ Gapped b 3 := by
  decide +kernel

/-- `Γ₇` has 392 directed edges, and the gapped vertices span 28 of them. -/
theorem card_edges : (Finset.univ.filter fun p : (ZMod 7 × ZMod 7) × (ZMod 7 × ZMod 7) =>
      (finitePlane 7).Adj p.1 p.2).card = 392 ∧
    (Finset.univ.filter fun p : (ZMod 7 × ZMod 7) × (ZMod 7 × ZMod 7) =>
      (finitePlane 7).Adj p.1 p.2 ∧ Gapped p.1 3 ∧ Gapped p.2 3).card = 28 := by
  decide +kernel

/-! ## Spec -/

-- `gamma` would drift if the band or the functional moved: `θ = 6/7` is colour 3, `θ = 0` colour 0.
example : gamma (0, 2) = 3 := by decide
example : gamma (0, 0) = 0 := by decide
example : theta7 (1, 1) = 5 := by decide
-- the control of `gapped_eq_three`: colour 0 is not missing at a gapped vertex of colour 0.
example : ¬ Gapped (0, 0) 0 := by decide +kernel
-- `supp` on and off `Z̄`.
example : supp (0, 0) = {0, 3} := by decide
example : supp (0, 2) = {3} := by decide

end HadwigerNelson.GapSeven
