import Proofs.HadwigerNelson.Plane.ValidMap.MergeMove
-- FS131-IMM2: a working draft of record § 5.2's first part (MERGE's definitions, the index lemmas, the outer pieces), for whoever
-- continues. It elaborates against the stage-5 oleans (`bash data/fs131/imm/iter.sh data/fs131/imm/wip/B.lean`, iteration only, never
-- evidence); it is not part of the library. Move it into `MergeMove` (and delete this file) when its section is built on.

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## MERGE's map: the gap, the new arcs, the colouring -/

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The germ indices of the gap after `idx s a`: `idx s m` for `a < m ≤ b`. -/
def gapGerm (s : Fin n) (a b : ℕ) : Set (Fin n) := {j | ∃ m, a < m ∧ m ≤ b ∧ idx s m = j}

/-- The sector indices of the gap after `idx s a`: `idx s m` for `a < m < b`. -/
def gapSec (s : Fin n) (a b : ℕ) : Set (Fin n) := {i | ∃ m, a < m ∧ m < b ∧ idx s m = i}

/-- Germ `j`'s branch out to `r`, without `v`. -/
def branch (v : ℂ) (r : ℝ) (j : Fin n) : Set ℂ := branchPt v (G.β j) (G.κ j) '' Ioo 0 r

/-- **The gap out to `r`**: its sectors and its germs' branches. -/
def gapSet (v : ℂ) (s : Fin n) (a b : ℕ) (r : ℝ) : Set ℂ :=
  (⋃ i ∈ gapSec s a b, G.sector v r i) ∪ ⋃ j ∈ gapGerm s a b, G.branch v r j

/-- A germ is **phantom** (for the sector colours `col`) when the sectors on its two sides have one colour. -/
def Phantom {k : ℕ} (col : Fin n → Fin k) (j : Fin n) : Prop := ∃ i, next i = j ∧ col i = col j

/-- **MERGE's colouring** at the radius `ρ`: `c` on the gap out to `ρ/2`; on a germ's branch out to `ρ`, the colour of the sector
after the germ; `Fcol` elsewhere. -/
noncomputable def mergeCol {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (Fcol : ℂ → Fin k) (s : Fin n) (a b : ℕ) (c : Fin k)
    (ρ : ℝ) : ℂ → Fin k := fun z => by
  classical
  exact if z ∈ G.gapSet v s a b (ρ / 2) then c else if h : ∃ j, z ∈ G.branch v ρ j then col h.choose else Fcol z

/-- **The rim arc** at `ρ/2` across the gap, from germ `idx s (a + 1)` to germ `idx s b`. -/
noncomputable def rimArc (v : ℂ) (s : Fin n) (a b : ℕ) (ρ : ℝ) : Arc :=
  .circ v (ρ / 2) (G.liftDir s (a + 1) (ρ / 2)) (G.liftDir s b (ρ / 2))

/-- **MERGE's new arcs** at the radius `ρ`: the germs off the gap out to `ρ/2`; the non-phantom germs' pieces between `ρ/2` and `ρ`;
and the rim arc at `ρ/2` across the gap when the gap has a sector. No arc on `∂B(v, ρ)`. -/
noncomputable def mergeArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (s : Fin n) (a b : ℕ) (ρ : ℝ) : Set Arc :=
  (fun j => germArc v (G.β j) (G.κ j) (ρ / 2)) '' (gapGerm s a b)ᶜ ∪
    (⋃ j ∈ {j | ¬ Phantom col j}, (germArc v (G.β j) (G.κ j) ρ).outer v (ρ / 2)) ∪
    {A | a + 1 < b ∧ A = G.rimArc v s a b ρ}

theorem mem_gapGerm {s : Fin n} {a b : ℕ} {j : Fin n} : j ∈ gapGerm s a b ↔ ∃ m, a < m ∧ m ≤ b ∧ idx s m = j := Iff.rfl

theorem mem_gapSec {s : Fin n} {a b : ℕ} {i : Fin n} : i ∈ gapSec s a b ↔ ∃ m, a < m ∧ m < b ∧ idx s m = i := Iff.rfl

/-- **Every index is on the orbit once in `[a, a + n)`** (for `a < n`). -/
theorem exists_rep (s : Fin n) {a : ℕ} (ha : a < n) (i : Fin n) : ∃ m, a ≤ m ∧ m < a + n ∧ idx s m = i := by
  obtain ⟨m₀, hm₀, h⟩ := exists_idx_eq s i
  rcases le_or_gt a m₀ with h1 | h1
  · exact ⟨m₀, h1, by omega, h⟩
  · exact ⟨m₀ + n, by omega, by omega, by rw [idx_add_n, h]⟩

/-- The orbit is injective on `[a, a + n)`. -/
theorem idx_inj {s : Fin n} {a m m' : ℕ} (h1 : a ≤ m) (h2 : m < a + n) (h3 : a ≤ m') (h4 : m' < a + n)
    (he : idx s m = idx s m') : m = m' := by
  rcases lt_trichotomy m m' with h | h | h
  · exact absurd he (idx_ne h (by omega))
  · exact h
  · exact absurd he.symm (idx_ne h (by omega))

/-- An index on the orbit at `m ∈ [a, a + n)` is a gap germ exactly when `a < m ≤ b` (for `b < a + n`). -/
theorem idx_mem_gapGerm_iff {s : Fin n} {a b m : ℕ} (hb : b < a + n) (h1 : a ≤ m) (h2 : m < a + n) :
    idx s m ∈ gapGerm s a b ↔ a < m ∧ m ≤ b := by
  constructor
  · rintro ⟨m', hm'1, hm'2, he⟩
    have := idx_inj (by omega) (by omega) h1 h2 he
    omega
  · rintro ⟨h3, h4⟩; exact ⟨m, h3, h4, rfl⟩

/-- An index on the orbit at `m ∈ [a, a + n)` is a gap sector exactly when `a < m < b` (for `b < a + n`). -/
theorem idx_mem_gapSec_iff {s : Fin n} {a b m : ℕ} (hb : b < a + n) (h1 : a ≤ m) (h2 : m < a + n) :
    idx s m ∈ gapSec s a b ↔ a < m ∧ m < b := by
  constructor
  · rintro ⟨m', hm'1, hm'2, he⟩
    have := idx_inj (by omega) (by omega) h1 h2 he
    omega
  · rintro ⟨h3, h4⟩; exact ⟨m, h3, h4, rfl⟩

/-- The germ after sector `idx s m` is phantom exactly when the two sectors beside it have one colour. -/
theorem phantom_idx_succ_iff {k : ℕ} {col : Fin n → Fin k} {s : Fin n} {m : ℕ} :
    Phantom col (idx s (m + 1)) ↔ col (idx s m) = col (idx s (m + 1)) := by
  constructor
  · rintro ⟨i, hi, hc⟩
    rw [← next_idx] at hi
    rw [← next_injective hi]; exact hc
  · intro h; exact ⟨idx s m, next_idx s m, h⟩

end BranchGerms

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

/-- Half a small radius is small. -/
theorem Small.half {ρ : ℝ} (h : X.Small ρ) : X.Small (ρ / 2) :=
  ⟨by linarith [h.1], by linarith [h.1, h.2.1], by linarith [h.1, h.2.2.1], by linarith [h.1, h.2.2.2]⟩

/-- A branch point is at its distance from `v`. -/
theorem dist_branchPt (j : Fin X.n) {t : ℝ} (ht : 0 ≤ t) : dist (branchPt v (X.G.β j) (X.G.κ j) t) v = t := by
  rw [dist_eq_norm, norm_branchPt_sub v _ _ ht]

/-- The outer pieces of germ `j`'s arc out to `ρ`, outside `B(v, ρ/2)`, lie on its branch between `ρ/2` and `ρ`. -/
theorem outer_subset {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) :
    ∀ A ∈ (X.germ ρ j).outer v (ρ / 2), A.carrier ⊆ branchPt v (X.G.β j) (X.G.κ j) '' Icc (ρ / 2) ρ := by
  have hv : v ∈ (X.germ ρ j).carrier := by rw [carrier_germ h]; exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
  obtain ⟨h1, -⟩ := Arc.outer_spec (germArc_nondegenerate v _ _ h.1) hv (by linarith [h.1] : (0 : ℝ) < ρ / 2)
  intro A hA z hz
  obtain ⟨-, hsub, hd⟩ := h1 A hA
  have hz' : z ∈ (X.germ ρ j).carrier := hsub hz
  rw [carrier_germ h] at hz'
  obtain ⟨t, ht, rfl⟩ := hz'
  refine ⟨t, ⟨?_, ht.2⟩, rfl⟩
  have := hd _ hz
  rwa [dist_branchPt j ht.1] at this

/-- A point of germ `j`'s branch between `ρ/2` (excluded) and `ρ` lies on an outer piece. -/
theorem mem_outer {ρ : ℝ} (h : X.Small ρ) (j : Fin X.n) {t : ℝ} (ht : t ∈ Ioc (ρ / 2) ρ) :
    branchPt v (X.G.β j) (X.G.κ j) t ∈ ⋃ A ∈ (X.germ ρ j).outer v (ρ / 2), A.carrier := by
  have hv : v ∈ (X.germ ρ j).carrier := by rw [carrier_germ h]; exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
  obtain ⟨-, h2⟩ := Arc.outer_spec (germArc_nondegenerate v _ _ h.1) hv (by linarith [h.1] : (0 : ℝ) < ρ / 2)
  have ht0 : 0 ≤ t := by linarith [ht.1, h.1]
  refine h2 ⟨?_, ?_⟩
  · show _ ∈ (X.germ ρ j).carrier
    rw [carrier_germ h]; exact ⟨t, ⟨ht0, ht.2⟩, rfl⟩
  · rw [mem_closedBall, dist_branchPt j ht0, not_le]; exact ht.1

end Near

end ArcMap

end HadwigerNelson.Plane
