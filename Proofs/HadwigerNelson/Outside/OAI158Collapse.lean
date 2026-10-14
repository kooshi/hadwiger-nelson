import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer
import Proofs.HadwigerNelson.Plane.YesLimit

/-!
# The transfer's consumers: the plane's chromatic number is its measurable one (FS-132; moved by FS-131)

`proper_to_borel_weak` (T), `[OAIMath2026]` family 158's transfer of colourability, is a theorem of this library: its
proof is ported (`Outside/OAI158BorelTransfer`, under its name; FS-131, the port of `plans/FS131-KO1-port-plan.md`).
The declarations below are this library's forms of it — `χ(ℝ²) = χ_m⁰(ℝ²)` and the criterion
`7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1` among them. They stood in `Outside/OAI158` while T was declared there as an axiom, and moved
here unchanged, character for character with their docstrings (FS131-IPD1, the switch of the plan's § 4.4), because the
ported theorem is downstream of that module. Where a docstring below says a theorem "rests on the standard three axioms
and `proper_to_borel_weak`", it now names a theorem: each rests on the standard three axioms.
-/

open MeasureTheory

namespace HadwigerNelson.Outside.OAI158

/-- **T in this library's words**: if the plane has a proper `k`-colouring, it has a measurable `k`-colouring proper
at almost every unit pair. Rests on the standard three axioms and `proper_to_borel_weak`. Inhabitant of the
hypothesis: `k = 7`, by `exists_properColoring_seven` through `properColoring_iff_colorable`. -/
theorem nonempty_aeColouring_of_colorable {k : ℕ} (h : (unitDistance ℂ).Colorable k) :
    Nonempty (Plane.AeColouring k) := by
  obtain ⟨c, hc⟩ := properColoring_iff_colorable.mpr h
  haveI : NeZero k := ⟨fun h0 => by subst h0; exact (c 0).elim0⟩
  obtain ⟨d, hd, hw⟩ := proper_to_borel_weak hc
  exact nonempty_aeColouring_of_weak hd hw

/-- **The transfer, colour by colour**: the plane has a proper `k`-colouring exactly when it has a measurable
`k`-colouring proper at almost every unit pair. The direction from a proper colouring is `proper_to_borel_weak`; the
other is this library's N-EASY (`Plane.chromaticNumber_plane_le_chiM0`), which needs no import. -/
theorem colorable_iff_nonempty_aeColouring {k : ℕ} :
    (unitDistance ℂ).Colorable k ↔ Nonempty (Plane.AeColouring k) :=
  ⟨nonempty_aeColouring_of_colorable, fun ⟨a⟩ => SimpleGraph.chromaticNumber_le_iff_colorable.mp
    (Plane.chromaticNumber_plane_le_chiM0.trans (Plane.chiM0_le a))⟩

/-- **`χ_m⁰(ℝ²) ≤ χ(ℝ²)`** — the half of row 130's collapse this project held only given measure rigidity. Rests on
the standard three axioms and `proper_to_borel_weak`. -/
theorem chiM0_le_chromaticNumber_plane : Plane.chiM0 ≤ (unitDistance ℂ).chromaticNumber := by
  rw [SimpleGraph.chromaticNumber]
  refine le_iInf₂ fun k hk => ?_
  obtain ⟨a⟩ := nonempty_aeColouring_of_colorable hk
  exact Plane.chiM0_le a

/-- **Row 130's collapse, with no measure rigidity: `χ(ℝ²) = χ_m⁰(ℝ²)`.** One half is `proper_to_borel_weak`, the
other this library's N-EASY. On branch `fs131-w9` the proposition `Plane.Row130Collapse` is this equality by
definition, assumed there by the theorems of `Plane/Reduction`; at that wave's join this theorem proves it, and
each of those theorems then holds on this import in its place. -/
theorem chromaticNumber_plane_eq_chiM0 : (unitDistance ℂ).chromaticNumber = Plane.chiM0 :=
  le_antisymm Plane.chromaticNumber_plane_le_chiM0 chiM0_le_chromaticNumber_plane

/-- **The third item, run**: the transfer applied to this library's seven-colouring of the plane gives a Borel
seven-colouring proper at almost every unit pair. -/
example : ∃ d : ℂ → Fin 7, Measurable d ∧ WeakColoring 7 d := by
  obtain ⟨c, hc⟩ := exists_properColoring_seven
  exact proper_to_borel_weak hc

/-- **The one question, for the plane's chromatic number itself: `χ(ℝ²) ≥ 7 ⟺ lim_{ε → 0} µ₆(ε) < 1`.** Row 131's
criterion — `Plane.seven_le_chiM0_iff`, FS106-EQ at six classes, this library's own theorem on the standard three
axioms — rewritten by `chromaticNumber_plane_eq_chiM0`. Rests on the standard three axioms and `proper_to_borel_weak`
alone: `no_proper_five_coloring` is not used. It has no hypothesis, so no model is asked (FS132-L1).

**Read aloud**, against the front page's sentence (`CLAUDE.md` § The aim, item 5: "`χ(ℝ²) = χ_m⁰(ℝ²)` …, and
`χ_m⁰(ℝ²) ≥ 7` iff six classes, each free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane
up to holes of density tending to 0 as `ε → 0`"): *the plane needs at least seven colours exactly when there is a
`δ > 0` such that, for every `ε > 0`, any six disjoint measurable sets, each with only a null set of pairs of its own
points at a distance in `[1 − ε, 1 + ε]`, leave uncovered a part of the plane of lower density at least `δ`.* Term by
term:

* `(unitDistance ℂ).chromaticNumber` is the plane's chromatic number in row 33's sense:
  `chromaticNumber_plane_eq_complex` equates it with `(unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`, the
  number `chromaticNumber_plane_interval` bounds by `5` and `7`. With that upper end, `7 ≤ χ` is `χ = 7`; with the
  lower end of `chromaticNumber_plane_six_or_seven` (which rests on the other import), its negation is `χ = 6`.
* `Plane.mu 6 ε` is the best six-class cover at slack `ε`: the supremum, over families of six measurable, pairwise
  disjoint sets each `Plane.BandNull` at `ε`, of the upper density of their union (`Plane.upperDensity`: the `limsup`
  of the covered fraction of the disc of radius `R` about `0`, as `R → ∞`). `⨆ ε > 0, Plane.mu 6 ε` is its limit as
  `ε → 0⁺`: a narrower band is a weaker condition (`Plane.antitone_mu`), so the supremum over `ε > 0` is the limit
  from the right at `0`, and `Plane.tendsto_mu` names that limit `Plane.muZero 6`.
* `< 1`: the limit is at most `1` (`Plane.mu_le_one`), and it is `1` exactly when the uncovered part can be made of
  density as small as one likes by taking `ε` small (the form of `Plane.chiM0_le_iff_periodic`: for every `δ > 0`
  some `ε > 0` and some family at `ε` cover upper density at least `1 − δ`). So `< 1` says that the holes keep a
  density bounded below, by one bound for every `ε > 0` and every family: the covered fraction of the discs about
  `0` has `limsup` at most `1 − δ`, so the uncovered fraction has `liminf` at least `δ`.

**Where the statement and the sentence differ in wording, and why that is no gap.** The sentence says each class is
*free* of monochromatic pairs in the band; `Plane.mu` asks that such pairs be *null* (`Plane.BandNull`), the weaker
condition (`Plane.bandNull_of_bandFree`) and so the larger supremum (`Plane.muPer_le_muTile`, `Plane.muTile_le_mu`).
The limit is the same under the strict reading and under the strictest — periodic families of half-open grid squares
with no such pair at all: `Plane.tendsto_muTile` and `Plane.tendsto_muPer` have the same limit `Plane.muZero 6`, and
`Plane.chiM0_le_iff_periodic` states the criterion in that form at every number of classes. The plane of the statement
is `ℂ`, as in every `Plane` module. -/
theorem seven_le_chromaticNumber_plane_iff :
    7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff

end HadwigerNelson.Outside.OAI158
