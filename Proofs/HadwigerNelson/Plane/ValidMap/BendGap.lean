import Proofs.HadwigerNelson.Plane.ValidMap.CollarMapOut
import Proofs.HadwigerNelson.Plane.ValidMap.R2Cap
import Proofs.HadwigerNelson.Plane.ValidMap.HornChart

/-!
# The away bend of one gap: the outward collar bend (FS131-KA1's skeleton; mirror of `Plane/ValidMap/BendCollar`)

`bend_away_gap`: on a valid map, a constant-sided unit arc whose inner colour is absent at the centre, near whose interior points `Γ`
is `ω(P)` alone, whose radius-2 arc lies in the domain and **has no contact of the inner colour at an interior angle**, bends away
from the centre by a homeomorphism supported in a collar — the clause package `AwayBend` (`plans/FS131-bendaway-kernel-plan.md` § 3,
lane C). The ends may be contacts: there the lens is tangent to `ω(P)`, and its clearness is FS131-E5's end case (`claim_e`,
`end_cap`, `r2_side_dichotomy`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section Gap

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **A thin outward lens over a gap is clear for the inner colour** (the mirror of `exists_lens_clear`, with the tangent ends): for
`R = 1 + τ/2` close to `1`. Route (plan § 2.5): a point of the class at distance `1` from a lens point is near or far (`n2_sign`);
near, it is within `< 1` (`n2_env_near_away`, the class off a disc about `P` by `hin`); far, it is within `r` of the radius-2 arc
(`n2_env_away`), so — the arc off small discs about its ends being compact and off the class's closure (`hgap`) — within `η` of an
end, where it is beyond the end (`claim_e`) or on the gap's side at distance `≥ 2` from `P` and off the cap (`r2_side_dichotomy`'s
"none" case, forced by `hgap`), hence farther than `1` (`end_cap`, once `R ≤ ρ₀ − 1`). **Open — `sorry`** (child C4, the new
mathematics of the bend). Inhabitant of the hypotheses: owed with the away bend's model (plan § 5). -/
theorem exists_lensOut_clear (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom) (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) :
    ∀ᶠ τ in 𝓝[>] (0 : ℝ), ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo 1 (outerProf θ₁ θ₂ (1 + τ / 2) θ)), F.IsClear c z := by
  sorry

/-- **The outward collar exists** over a gap (mirror of `exists_collarFit`): radii `R' = 1 − τ`, `R = 1 + τ/2`, `R'' = 1 + τ`, each
clause for all small `τ` — `clear` by `exists_lensOut_clear`; thin and in the domain by `collarK_thin`; `Γ`-free off the arc by
`exists_collar_free`, **as it stands** (the collar is the toward bend's). **Open — `sorry`** (child C5; short once C4 is in). -/
theorem exists_collarFitOut (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) (hε : 0 < ε) :
    ∃ R' R R'', CollarFitOut F P θ₁ θ₂ c c' ε R' R R'' := by
  sorry

/-- No unit arc is created (mirror of `CollarFit.map_ringArcsWithin`: the lens curve has radius `R ≠ 1`). **Open — `sorry`** (child C6). -/
theorem CollarFitOut.map_ringArcsWithin (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.RingArcsWithin F := by
  sorry

/-- **R1** for the outward bend (mirror of `CollarFit.map_R1`, through the mirrors of `exists_one_side`, `sides_end`, `sides_eq`:
near an end the collar lies on one side of `ω(Q)`, `Q ≠ P`, and both its halves keep their colours and the end in their closures).
**Open — `sorry`** (child C6). -/
theorem CollarFitOut.map_R1 (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by
  sorry

/-- **R2** for the outward bend (mirror of `CollarFit.map_R2`). **Open — `sorry`** (child C6). -/
theorem CollarFitOut.map_R2 (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    hfit.map.IsRingArc Q a b d d' := by
  sorry

/-- **The outward bend is a local step on its collar** (`LocalStep.of_cutArcs` with the two lens arcs, inside the collar by the mirror
of `CollarFit.lensCurve_subset` and `collarOutArcs_carrier`; `map_agreesOff` weakened to the collar). **Open — `sorry`** (child C7). -/
theorem CollarFitOut.map_localStep (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    LocalStep F hfit.map (collarK P θ₁ θ₂ R' R'') := by
  sorry

/-- **The horn clause for the outward bend** (the arc step's form; the same route as `CollarFit.map_hornCount_le`, plan § 4): off the
collar `hasHornCount_iff_of_agree`; in the collar and not an end, `0` (`hasHornCount_zero_of_mem_interiorPts`, or
`hasHornCount_zero_of_two_spheres` on the lens curve's two circles); at an end `hasHornCount_iff_of_germ_swap` with `κ₀ = ±1`,
`κ₀' = ±1/R`. **Open — `sorry`** (child C8). -/
theorem CollarFitOut.map_hornCount_le (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
    (hj : F.HasHornCount x j) : ∃ j' ≤ j, hfit.map.HasHornCount x j' := by
  sorry

/-- **The outward collar bend is an away bend** over its arc: every field of `AwayBend` for `hfit.map`, `hfit.homeo` and the collar.
Fields: `valid` `map_valid`; `compact` `isCompact_polarSet_Icc`; `thick`, `free` the fit's; `ring_K` by the collar's polar form;
`step` `map_localStep`; `fix_off`, `maps`, `fix_Γ` the mirrors of `homeo_eq_self`, `homeo_mem_collarK`, `homeo_fix_Γ`; `interior`,
`colours`, `degree`, `repeated` the `pushforward_*` lemmas (`pushforward_hasDegree`; off the domain the maps agree near the point);
`horn` `map_hornCount_le`; `within`, `r1`, `r2` above; `bent` by `map_lens` at `t = 1`, so `rest` is empty. **Open — `sorry`**
(child C9, the assembly). -/
theorem CollarFitOut.awayBend (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    AwayBend F hfit.map hfit.homeo (collarK P θ₁ θ₂ R' R'') P θ₁ θ₂ c ε := by
  sorry

/-- **The away bend of one gap**: the outward collar bend exists and is an away bend. Inhabitant of the hypotheses: owed with the away
bend's model (plan § 5; on a fragment, `isoFrag`'s half-arcs on either side of its isolated contact). -/
theorem bend_away_gap (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), AwayBend F M h K P θ₁ θ₂ c ε := by
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFitOut hF hA hin hdom hfree hgap hε
  exact ⟨hfit.map, hfit.homeo, _, hfit.awayBend hF⟩

end Gap

end ArcMap

end HadwigerNelson.Plane
