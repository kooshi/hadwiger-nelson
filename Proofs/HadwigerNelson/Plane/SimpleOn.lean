import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.ValidMap.Sectors

/-!
# "Simple" on a set: the class a fragment's argument reads

FS-131 wave 7's first foundation (`plans/FS131-w7-kernel-plan.md`, Stage 2; job FS131-K7). `ArcMap.Simple` (`Plane/ArcMap`)
reads the rows' word *simple* — "every tile an open disc whose closure meets each other tile's closure in a connected set or
not at all, and does not meet itself" (`plans/FS114-N-proof.md` l. 444) — **literally, over every tile of the map**. On a
fragment, a tile that crosses the boundary of the fragment's open set is then asked to be a Jordan domain too, and whether
it is depends on how that open set happens to be cut — nothing an argument about the disc `B̄(p, R)` ever reads.

`ArcMap.SimpleOn S` is the same word **over the tiles that meet `S`** (a tile meets `S` when its closure has a point of `S`):
each is a Jordan domain, and two distinct ones have closures meeting in a preconnected set. The rows of waves 7 and 8 are
stated with `F.SimpleOn (closedBall p R)` for a fragment on `B̄(p, R)`:

* it is implied by `F.Simple` (`Simple.simpleOn`), and over `S = univ` it is `F.Simple` (`simpleOn_univ`), so each row so
  stated implies the row as filed — the class is wider, the statement stronger (G92: the class the argument reads);
* it shrinks with the set (`SimpleOn.mono`), so a simple map of the plane, or a fragment simple on a larger disc, meets the
  hypothesis with no restriction of the map;
* **it is exactly the literal reading of the whole-tile restriction**: `F.SimpleOn (ball p ρ) ↔ (F.wholeRestrict p ρ).Simple`
  (`simpleOn_ball_iff`; FS129-OR1-WHOLE's `F_ρ`, whose tiles are the tiles of `F` meeting `B(p, ρ)`). So the two readings
  differ by one application of `wholeRestrict`, and what the literal reading costs a consumer is that restriction together
  with the transfer of every other hypothesis along it;
* the two facts the library reads from *simple* hold with it, at a point of `S`: a tile's cone is one closed interval of
  directions (`SimpleOn.coneAt_eq_angleIcc`), separated from every other tile's cone there
  (`SimpleOn.coneAt_eq_angleIcc_sep`, FS131-E2-SEP's proof with the Jordan hypothesis read at the two tiles it names).

Not taken: a purely local form ("each tile is a Jordan domain near each point of `S`"). The first clause localizes; the
second — closures meet in a connected set, "the plane form of `μ = 0`" — is about the whole of two closures and does not.

**Inhabitants.** `halfDisc` is simple (`halfDisc_simple`), hence simple on every set (`halfDisc_simpleOn`); the adversary
`not_simpleOn_of_not_jordan` shows the first clause is read at every tile meeting `S`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **Simple on `S`**: every tile whose closure meets `S` is a Jordan domain, and two distinct such tiles have closures
meeting in a preconnected set. The rows' *simple*, read over the tiles a fragment on `S` shows (`Simple` is `SimpleOn univ`). -/
def SimpleOn (S : Set ℂ) : Prop :=
  (∀ T, F.IsTile T → (closure T ∩ S).Nonempty → IsJordanDomain T) ∧
    ∀ T T', F.IsTile T → F.IsTile T' → (closure T ∩ S).Nonempty → (closure T' ∩ S).Nonempty → T ≠ T' →
      IsPreconnected (closure T ∩ closure T')

variable {F}

/-- A simple map is simple on every set. -/
theorem Simple.simpleOn (hS : F.Simple) (S : Set ℂ) : F.SimpleOn S :=
  ⟨fun T hT _ => hS.1 T hT, fun T T' hT hT' _ _ hne => hS.2 T T' hT hT' hne⟩

/-- Over the whole plane the two words agree. -/
theorem simpleOn_univ : F.SimpleOn univ ↔ F.Simple := by
  refine ⟨fun h => ⟨fun T hT => h.1 T hT ?_, fun T T' hT hT' hne => h.2 T T' hT hT' ?_ ?_ hne⟩, fun h => h.simpleOn _⟩
  · obtain ⟨x, hx⟩ := hT.nonempty
    exact ⟨x, subset_closure hx, mem_univ x⟩
  · obtain ⟨x, hx⟩ := hT.nonempty
    exact ⟨x, subset_closure hx, mem_univ x⟩
  · obtain ⟨x, hx⟩ := hT'.nonempty
    exact ⟨x, subset_closure hx, mem_univ x⟩

/-- Simple on a set, simple on every smaller one. -/
theorem SimpleOn.mono {S S' : Set ℂ} (hS : F.SimpleOn S') (h : S ⊆ S') : F.SimpleOn S :=
  ⟨fun T hT hm => hS.1 T hT (hm.mono (inter_subset_inter_right _ h)), fun T T' hT hT' hm hm' hne =>
    hS.2 T T' hT hT' (hm.mono (inter_subset_inter_right _ h)) (hm'.mono (inter_subset_inter_right _ h)) hne⟩

/-- **The two readings of "simple" on a fragment differ by the whole-tile restriction**: `F` is simple on the open disc
`B(p, ρ)` exactly when `F_ρ` (`wholeRestrict`, FS129-OR1-WHOLE) is simple in the literal sense. -/
theorem simpleOn_ball_iff {p : ℂ} {ρ : ℝ} : F.SimpleOn (ball p ρ) ↔ (F.wholeRestrict p ρ).Simple := by
  have hmeet : ∀ T : Set ℂ, (closure T ∩ ball p ρ).Nonempty ↔ (T ∩ ball p ρ).Nonempty := fun T =>
    closure_inter_open_nonempty_iff isOpen_ball
  constructor
  · rintro ⟨h1, h2⟩
    refine ⟨fun T hT => ?_, fun T T' hT hT' hne => ?_⟩
    · obtain ⟨hT, hm⟩ := isTile_wholeRestrict_iff.mp hT
      exact h1 T hT ((hmeet T).mpr hm)
    · obtain ⟨hT, hm⟩ := isTile_wholeRestrict_iff.mp hT
      obtain ⟨hT', hm'⟩ := isTile_wholeRestrict_iff.mp hT'
      exact h2 T T' hT hT' ((hmeet T).mpr hm) ((hmeet T').mpr hm') hne
  · rintro ⟨h1, h2⟩
    refine ⟨fun T hT hm => ?_, fun T T' hT hT' hm hm' hne => ?_⟩
    · exact h1 T (isTile_wholeRestrict_iff.mpr ⟨hT, (hmeet T).mp hm⟩)
    · exact h2 T T' (isTile_wholeRestrict_iff.mpr ⟨hT, (hmeet T).mp hm⟩)
        (isTile_wholeRestrict_iff.mpr ⟨hT', (hmeet T').mp hm'⟩) hne

/-- **A tile's cone at a point of `S` is one closed interval of directions**, in a map simple on `S`
(`Simple.coneAt_eq_angleIcc`, with the Jordan hypothesis read at the one tile it names). -/
theorem SimpleOn.coneAt_eq_angleIcc {S : Set ℂ} (hS : F.SimpleOn S) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ}
    (hxS : x ∈ S) (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ :=
  (hS.1 T hT ⟨x, hx, hxS⟩).coneAt_eq_angleIcc hT.isOpen hx

/-- **The separated interval at a point of `S`** (FS131-E2-SEP, `Simple.coneAt_eq_angleIcc_sep`, at the class its proof
reads): in a map simple on `S`, a tile's cone at a point `x ∈ S` of its closure is one closed interval whose open part
meets no other tile's cone at `x`. The proof is `Simple.coneAt_eq_angleIcc_sep`'s, word for word, the Jordan hypothesis
taken at the two tiles with `x` in their closures. -/
theorem SimpleOn.coneAt_eq_angleIcc_sep {S : Set ℂ} (hS : F.SimpleOn S) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ}
    (hxd : x ∈ F.dom) (hxS : x ∈ S) (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ ∧
      ∀ T', F.IsTile T' → T' ≠ T → x ∈ closure T' → Disjoint (coneAt T' x) (angleIoo β₁ β₂) := by
  have hπ := Real.pi_pos
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hxd
  have hloc : ∀ S : Set ℂ, coneAt S x = coneAt (S ∩ ball x r₀) x := fun S =>
    Subset.antisymm (fun β hβ => coneAt_inter_ball hC.pos hβ) (coneAt_mono inter_subset_left x)
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have hball : ball x r₀ ⊆ T := by
      obtain ⟨z, hzT, hzd⟩ := Metric.mem_closure_iff.mp hx r₀ hC.pos
      exact hT.subset_of_preconnected (convex_ball x r₀).isPreconnected (hC.empty hn)
        (by rw [mem_ball, dist_comm]; exact hzd) hzT
    have hxT : x ∈ T := hball (mem_ball_self hC.pos)
    refine ⟨0, 2 * π, by positivity, by linarith, ?_, ?_⟩
    · ext β
      simp only [mem_coneAt_of_mem_isOpen hT.isOpen hxT β, true_iff]
      obtain ⟨m, hm1, hm2⟩ := exists_shift_Ico 0 β
      exact mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith⟩
    · intro T' hT' hne hx'
      exfalso
      obtain ⟨z, hzT', hzd⟩ := Metric.mem_closure_iff.mp hx' r₀ hC.pos
      exact hne (hT'.eq_of_mem hT hzT' (hball (by rw [mem_ball, dist_comm]; exact hzd)))
  · obtain ⟨i, hi⟩ := hC.exists_tile_inter_ball hn hT (hS.1 T hT ⟨x, hx, hxS⟩) hx
    have hM := hC.sorted.mono
    refine ⟨G.β i, G.nextβ i, hM i, hM.nextβ_le_add i, ?_, ?_⟩
    · rw [hloc, hi, hC.cone r₀ ⟨hC.pos, le_rfl⟩ i]
    · intro T' hT' hne hx'
      obtain ⟨j, hj⟩ := hC.exists_tile_inter_ball hn hT' (hS.1 T' hT' ⟨x, hx', hxS⟩) hx'
      have hji : j ≠ i := by
        rintro rfl
        obtain ⟨w, hw⟩ := hC.sector_nonempty ⟨hC.pos, le_rfl⟩ j
        have hwT : w ∈ T := (hi.symm ▸ hw : w ∈ T ∩ ball x r₀).1
        have hwT' : w ∈ T' := (hj.symm ▸ hw : w ∈ T' ∩ ball x r₀).1
        exact hne (hT'.eq_of_mem hT hwT' hwT)
      rw [hloc, hj, hC.cone r₀ ⟨hC.pos, le_rfl⟩ j]
      exact hM.disjoint hji.symm

end ArcMap

/-! ### Spec examples and the inhabitant -/

/-- **Inhabitant**: the half-disc map is simple on every set. -/
theorem halfDisc_simpleOn (S : Set ℂ) : halfDisc.SimpleOn S := ArcMap.halfDisc_simple.simpleOn S

/-- No tile meets the empty set, so every map is simple on it: the hypothesis is about tiles meeting `S` and nothing else. -/
example {k : ℕ} (F : ArcMap k) : F.SimpleOn ∅ :=
  ⟨fun _ _ h => absurd h (by simp), fun _ _ _ _ h => absurd h (by simp)⟩

/-- **Adversary**: a tile meeting `S` that is not a Jordan domain refutes `SimpleOn S` — the first clause is read at every
tile the set shows. -/
theorem ArcMap.not_simpleOn_of_not_jordan {k : ℕ} {F : ArcMap k} {S T : Set ℂ} (hT : F.IsTile T)
    (hm : (closure T ∩ S).Nonempty) (hJ : ¬ ArcMap.IsJordanDomain T) : ¬ F.SimpleOn S :=
  fun h => hJ (h.1 T hT hm)

end HadwigerNelson.Plane
