import Proofs.HadwigerNelson.Instances.TwoAdicFour
import Proofs.HadwigerNelson.FanGap

/-!
# Level five of the 2-adic tower forces exactly the kernel of the level map

`P₅ = Cay(O/𝔓⁵, S₅)`, 1,024 vertices, degree 48. **The 2-adic law at its threshold, both halves in the kernel:**

* **Forcing.** `P₅ + edge (0, δ)` with `δ = ((4, 0), (0, 0))` — one of the three nonzero elements of `𝔓⁴/𝔓⁵`, the
  kernel of the level map — is not 4-colourable: an LRAT-checked refusal through the M05 pipeline (measured at 4,068
  LRAT lines, 0.1 s; `scripts/regen-check.sh`'s flags). The three depth-4 elements are one orbit under multiplication
  by `ω` (`twoAdicOmegaHom`, `Forces.map`), so one refusal covers them all.
* **Freedom.** A difference outside the kernel maps to a nonzero difference of `P₄`, which some table of
  `Instances/TwoAdicFour.lean` separates; the pullback along `twoAdicLevelHom 4` separates it at level five.

So `Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0`. Corollary: no 4-colouring of any level `≤ 5` has a gap
(a gap would pull up to level five and make it slack, hence pairwise free). **The solver-dependent surface is exactly one
declaration**, `twoAdicFive_not_colorable_with_edge`; `twoAdicFive_forces_delta` is a one-liner from it (a colouring with
`C 0 ≠ C δ` is a colouring of `P₅ ⊔ edge`). **[hand 1]** identifies `twoAdicPlane 5`
with `Cay(O/𝔓⁵, S₅)`; **[hand 2]** would draw a K-certificate into it; neither is kernel (FS-38 §S3).
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-- The representative depth-4 difference `4 ∈ 𝔓⁴/𝔓⁵` (`4 = π⁴·unit`). -/
def twoAdicFiveDelta : TwoAdicLevel 5 := ((4, 0), (0, 0))

theorem twoAdicFiveDelta_mem_ker : twoAdicLevelMap 4 twoAdicFiveDelta = 0 := by
  sorry

theorem twoAdicFiveDelta_ne_zero : twoAdicFiveDelta ≠ 0 := by decide

/-- The kernel of the level map is `{0, δ, ωδ, ω²δ}`. -/
theorem twoAdicFive_ker_eq {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d = 0) :
    d = 0 ∨ d = twoAdicFiveDelta ∨ d = twoAdicOmega 5 twoAdicFiveDelta ∨
      d = twoAdicOmega 5 (twoAdicOmega 5 twoAdicFiveDelta) := by
  sorry

/-- **The refusal, kernel-checked**: `P₅` with the edge `(0, δ)` added has no 4-colouring — the LRAT certificate
through the pipeline (implementer: an edge list on `Fin 1024` in bijection with `TwoAdicLevel 5`, `decide` that every
listed pair is an edge of `P₅` or is `(0, δ)`, then `Colorable.of_hom`). -/
theorem twoAdicFive_not_colorable_with_edge :
    ¬ ((twoAdicPlane 5) ⊔ SimpleGraph.fromEdgeSet {s(0, twoAdicFiveDelta)}).Colorable 4 := by
  sorry

/-- **Level five forces the representative depth-4 difference.** -/
theorem twoAdicFive_forces_delta : Forces (twoAdicPlane 5) 4 0 twoAdicFiveDelta := by
  sorry

/-- The whole kernel is forced: the orbit under `ω` (`Forces.map` along `twoAdicOmegaHom 5`, which fixes `0`). -/
theorem twoAdicFive_forces_of_ker {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d = 0) :
    Forces (twoAdicPlane 5) 4 0 d := by
  sorry

/-- Outside the kernel nothing is forced: `Forces.image` along `twoAdicLevelHom 3 : P₅ →g P₄` lands in level four,
which is pairwise free. -/
theorem twoAdicFive_not_forces_of_ne {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d ≠ 0) :
    ¬ Forces (twoAdicPlane 5) 4 0 d := by
  sorry

/-- **The 2-adic law at level five**: forced at the origin iff the difference lies in `𝔓⁴`. -/
theorem twoAdicFive_forces_iff {d : TwoAdicLevel 5} :
    Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0 := by
  sorry

/-- The same for every pair, by the Cayley reduction. -/
theorem twoAdicFive_forces_iff' {x y : TwoAdicLevel 5} :
    Forces (twoAdicPlane 5) 4 x y ↔ twoAdicLevelMap 4 (y - x) = 0 := by
  sorry

/-- **No gap at level five** — a forced pair forbids slackness (`Slack.forces_iff`). -/
theorem twoAdicFive_not_slack : ¬ Slack (twoAdicPlane 5) 4 := by
  sorry

/-- **No gap at level four either**: slackness pulls UP along the level hom `twoAdicLevelHom 3 : P₅ →g P₄`
(`Slack.of_hom`), and level five is not slack. One line; placed here, downstream of the LRAT, because that is its only
proof; the same chain reaches every level `≤ 5`. -/
theorem twoAdicFour_not_slack : ¬ Slack (twoAdicPlane 4) 4 := by
  sorry

end HadwigerNelson
