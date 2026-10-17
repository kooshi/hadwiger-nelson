import Proofs.HadwigerNelson.Plane.G27.All
import Proofs.HadwigerNelson.Plane.G27.Law

/-!
# `G27`'s certificate checked, and the density bound it gives (FS-131, FS131-ISF1)

* `cert_bound` — every set of the 27 points with no listed edge inside it has the certificate's terms summing to at most
  `Dn` (that is, `Σ_{Y ⊆ S} y_Y ≤ 1`): the residual DFS accepts from the root (`good_root`, through the split tree and its
  leaf groups, `Plane/G27/All`), so `dfsR_sound` bounds the root's value on the set, and the root is the rows' and
  singletons' terms sorted and merged (`root_sorted`, `segs_ok`), which preserves values (`val_sortRounds`).
* `density_le_quarter` — `[MatolcsiEtAl2025]` Thm 3, read against an invariant law: every translation- and
  rotation-invariant random independent set of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4`
  (`density_le_of_cert`, `Plane/G27/Law`).

Record: `plans/FS131-ISF1-seam-fractional.md`.
-/

namespace HadwigerNelson.G27

open DensityBound.X23Check Collapse
open scoped ENNReal

/-- The rows of the certificate, joined. -/
def rowsAll : List ℕ := segR.flatten

/-- Their coefficients, joined. -/
def coefsAll : List ℕ := segC.flatten

theorem rowsAll_ok : rowsAll.all (rowOk ptsL) = true := (segsOk_spec segs_ok).1

theorem rowsAll_fit : rowsFit rowsAll coefsAll = true := (segsOk_spec segs_ok).2.1

/-- The certificate's terms have the root's value on every set. -/
theorem val_expand_eq_root (U : ℕ) : val U (expand singL rowsAll coefsAll) = val U rootL := by
  rw [expand, val_append, rowsAll, coefsAll, (segsOk_spec segs_ok).2.2 U, ← eqL_eq root_sorted, val_sortRounds,
    List.map_cons, List.sum_cons]

/-- **The certificate's condition (iii), checked by the kernel**: on every set of the 27 points with no listed edge inside
it, the terms weigh at most `Dn` — `Σ_{Y ⊆ S} y_Y ≤ 1` over the common denominator. -/
theorem cert_bound (U : ℕ) (hU : U < 2 ^ 27) (hI : IndepFrom adjL 0 U) : val U (expand singL rowsAll coefsAll) ≤ Dn := by
  rw [val_expand_eq_root]
  have hdfs : dfsR (leafOk Dn) adjL 0 0 rootL = true := goodB_root good_root
  refine dfsR_sound Dn adjL 0 0 rootL hdfs (wfAdj_of_wfB wf_ok) U (fun i hi => ⟨Nat.zero_le _, ?_⟩) ?_
  · rw [zero_add, adjL_length]
    by_contra h
    rw [Nat.testBit_lt_two_pow (lt_of_lt_of_le hU (Nat.pow_le_pow_right (by norm_num) (by omega)))] at hi
    exact Bool.false_ne_true hi
  · rwa [Nat.zero_or]

/-- **`[MatolcsiEtAl2025]` Thm 3, read against an invariant law**: every translation- and rotation-invariant random
independent set of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4`. -/
theorem density_le_quarter (μ : IndepLaw seamField) : μ.density ≤ 4⁻¹ :=
  density_le_of_cert μ rowsAll_ok rowsAll_fit cert_bound

end HadwigerNelson.G27
