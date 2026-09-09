import Proofs.HadwigerNelson.Brick
import Proofs.HadwigerNelson.DistanceGraph

/-!
# A brick certificate colours a distance graph, not just the unit-distance graph (FS-24 G7b)

`Brick.colorable` says a passing certificate properly colours the plane's unit-distance graph;
`Brick.avoids` says the same colouring never repeats a colour at any *guarded* distance. Those are
two facts about one function, and since M49 the repository has had the object that holds them
together: `distanceGraph ℂ D`, the graph joining two distinct points whenever their distance lies in
`D`. **A passing certificate is a proper colouring of that graph, for every `D` whose distances are
square roots of guards** — which is this file, in three declarations and no new mathematics.

## Why a separate module

`Brick.lean` (M35) predates `DistanceGraph.lean` (M49) and does not import it. Adding the import
there would rewrite `Brick.lean`'s compiled artifact and rebuild `Instances/Seven.lean`,
`Instances/Nine.lean` and `Instances/Interval.lean` — the last being the module carrying
`5 ≤ χ(ℝ²) ≤ 7`. A new leaf that imports both and is imported by its one consumer rebuilds one file,
and it is also the right home: the bridge is a general fact about `Brick`, and the nine-colour
avoider is an instance of it (`Instances/Nine.lean`).

## What it buys

The repository's certified upper bounds become **two-distance** upper bounds wherever the
certificate carries an avoidance guard. `Instances/Nine.lean` instantiates it at
`χ(ℝ²; {1, √(3/2)}) ≤ 9`. That is the shape a future avoider find is quoted in — an avoider at
`k ≤ 6` bounds what seven-forcers can use, and one at `k = 5` would prove `χ(ℝ²) ≤ 5` outright
(M35 §0a C1) — so the consumer exists before the find, which is what the module was built for.

## One side condition that never appears

`distanceGraph` needs `0 ∉ D` wherever a listed distance must give *distinct* points. Here it is
never assumed and never needed: a distance in `D` is `√q` for a guard `q`, and `Brick.check_pos`
proves every certified guard positive, so `0 ∈ D` is impossible. The certificate discharges it, not
the caller.

**Non-vacuity**: `Instances/Nine.lean`'s `nineBrick` with `nineBrick_check_avoid` is a named
inhabitant of every hypothesis below, and the theorems there are its instances.
-/

namespace HadwigerNelson

open SimpleGraph

namespace Brick

variable {k : ℕ} (B : Brick k)

/-- **A passing certificate is a proper colouring of every distance graph it guards.** The
hypothesis reads: every forbidden distance is the square root of a listed guard. It is the weakest
form — a caller may forbid any subset of the guarded distances, in any order — and it subsumes both
`Brick.colorable` (take `D = {1}`, guard `1`) and `Brick.avoids` (take `D = {√q}`). -/
theorem colorable_distanceGraph {guards : List ℚ} {D : Set ℝ}
    (hchk : B.check guards = true)
    (hD : ∀ r ∈ D, ∃ q ∈ guards, r = Real.sqrt (q : ℝ)) :
    (distanceGraph ℂ D).Colorable k :=
  ⟨Coloring.mk B.color fun {_ _} hadj => by
    obtain ⟨q, hq, hr⟩ := hD _ hadj.2
    exact B.avoids hq hchk hr⟩

/-- The bound in chromatic-number form. -/
theorem chromaticNumber_distanceGraph_le {guards : List ℚ} {D : Set ℝ}
    (hchk : B.check guards = true)
    (hD : ∀ r ∈ D, ∃ q ∈ guards, r = Real.sqrt (q : ℝ)) :
    (distanceGraph ℂ D).chromaticNumber ≤ k :=
  (B.colorable_distanceGraph hchk hD).chromaticNumber_le

/-- **The two-distance form**: a certificate carrying the properness guard `1` and one avoidance
guard `q` colours the plane with *both* `1` and `√q` forbidden. This is the shape the record quotes
— "a certified `k`-colouring avoiding `√q`" is exactly `χ(ℝ²; {1, √q}) ≤ k`. -/
theorem colorable_avoiding {guards : List ℚ} {q : ℚ}
    (h1 : (1 : ℚ) ∈ guards) (hq : q ∈ guards) (hchk : B.check guards = true) :
    (distanceGraph ℂ {1, Real.sqrt (q : ℝ)}).Colorable k := by
  refine B.colorable_distanceGraph hchk ?_
  rintro r (rfl | rfl)
  · exact ⟨1, h1, by norm_num⟩
  · exact ⟨q, hq, rfl⟩

end Brick

end HadwigerNelson
