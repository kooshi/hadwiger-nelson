import Proofs.HadwigerNelson.Plane.MaximalCover

/-!
# The example colourings and covers (FS-131 wave 2)

Row stated here so far: **FS111-W-SQ9**. Rows still to state, with their objects (`plans/FS131-w2-kernel-plan.md` § 4.4, left
for the next planning session): FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG.

FS111-W-SQ9's colouring is by **closed** squares; `sq9` (`Plane/Cover`) uses half-open squares, which differ from it on the
null grid only, and tightness and saturation read densities alone, so they are the same statements.
-/

namespace HadwigerNelson.Plane

/-- **FS111-W-SQ9**: the half-square nine-colouring is a.e.-proper (it is `sq9 : AeColouring 9`), tight, saturated, and
saturated with positive-density partners. -/
theorem sq9_tight_saturated : sq9.Tight ∧ Saturated sq9.cls ∧ SaturatedPos sq9.cls := by
  sorry

end HadwigerNelson.Plane
