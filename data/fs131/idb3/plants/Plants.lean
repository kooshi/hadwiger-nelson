import Proofs.HadwigerNelson.Plane.DensityBound.X23Data
import Proofs.HadwigerNelson.Plane.DensityBound.Cells.Data
/-!
FS131-IDB3 stage 2 — planted faults against the kernel's checks (each `plant*` must be REFUSED by `decide +kernel`; each
`partner*`, the same check on the unplanted data, must pass). Run against the farm (`data/fs131/idb3/farm.sh`).
-/
namespace HadwigerNelson.DensityBound.X23Check
open BesselCert.Cells

-- (a) a wrong distance: the sixth `w₂` distance moved by `2·2⁻⁶⁴` (beyond the `2⁻⁶⁴` the covering allows)
theorem plantDist : distsOk ptsL enclL (P23.Ds.tail.set 5 (P23.Ds.tail[5]! + 2)) w2T = true := by decide +kernel
theorem partnerDist : distsOk ptsL enclL P23.Ds.tail w2T = true := by decide +kernel

-- (b) a missing congruence: row 115 of `wc00` (I = [1,5,7] ↦ J = [2,7,5], 0-based) with J's last point 5 → 0, so the
-- row claims `X|{1,5,7} ≅ X|{2,7,0}`, two triangles with different side lengths
/-- Row 115 of `wc00` with its `J` corrupted. -/
def badRow : Nat := wc00.getD 115 0 - 5 * B72 ^ 25
theorem plantCong : rowOk ptsL badRow = true := by decide +kernel
theorem partnerCong : rowOk ptsL (wc00.getD 115 0) = true := by decide +kernel

-- (c) an atom with `V < 0`: the bound lowered to `w_T + 6·10⁻⁸`, below the certificate's `max L = w_T + 6.71·10⁻⁸`
-- (chunk 26 holds such an atom); the partner at `w_T + 7·10⁻⁸` passes, so the check is tight at the true minimum of V
set_option maxRecDepth 100000 in
theorem plantAtom : fr26.all (subtreeOk (boundN - 10 ^ 16 + 6 * 10 ^ 13) (vertsL.drop KF) KF) = true := by
  decide +kernel
theorem partnerAtom : fr26.all (subtreeOk (boundN - 10 ^ 16 + 7 * 10 ^ 13) (vertsL.drop KF) KF) = true := by
  decide +kernel

-- (d) the groups are the terms' own: a changed `w₁` is refused
theorem plantGroups : vertsL.map Prod.snd = groupsOf (terms (w1N + 1) w2T wcR) := by decide +kernel

-- (e) the frontier is the DFS's own: the frontier with its first state dropped is refused
theorem plantFrontier : (collect (vertsL.take KF) 0 0 0).map packSt = frL.tail := by decide +kernel

end HadwigerNelson.DensityBound.X23Check
