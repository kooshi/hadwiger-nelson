import Proofs.HadwigerNelson.Arity
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# The plane is homogeneous, so one forced pair is all of them

A finite gadget forces a *particular* pair of points to wear different colours. The six-colour
programme needs the statement about *every* pair at that distance, and the bridge is the one
symmetry the plane has and a finite graph does not: its isometry group is transitive on ordered
pairs at a fixed distance.

Concretely, `z ↦ a·z + b` with `a = (y − x)/(y₀ − x₀)` and `b = x − a·x₀` carries `(x₀, y₀)` to
`(x, y)`, and `‖a‖ = 1` exactly because the two pairs are equidistant. Distance-preserving maps are
homomorphisms of the unit-distance graph, so a colouring pulls back along one — and the hypothesis
"this pair is forced apart in every colouring" applies to the pulled-back colouring.

## What this buys, and when

Nothing here is deep, and no novelty is claimed for any step. It exists because it is the piece a
future find consumes on the day it is found: the from-below hunt produces `Separated G 5 u v` — a
finite gadget whose every proper 5-colouring separates two of its points — and `Separated.plane`
turns that into a statement about the whole plane in one call. Composed with
`Instances/HexShell.lean`'s pigeonhole it yields `χ(ℝ²) ≥ 6`, which is what this repository exists
to reach.

## The degenerate case, and why it needs no hypothesis

`forced_pair_of_forced` carries no `x₀ ≠ y₀`. At zero distance the hypothesis
`∀ C, C x₀ ≠ C y₀` refutes *itself* against any colouring, and the conclusion supplies one — so the
side condition a first draft would carry is not merely unnecessary but would be noise. The `x₀ = y₀`
branch of the proof is where that is discharged, and `AritySpec` exercises it.
-/

namespace HadwigerNelson

open SimpleGraph

/-- **The plane's isometry group is transitive on ordered pairs at a given distance.**

The map is `z ↦ a·z + b`, an explicit rotation-and-translation; `hne` is load-bearing, since with
`x₀ = y₀ ≠ x` no map at all sends one point to two. A bare `Isometry` rather than an
`IsometryEquiv`, because every consumer only pulls a colouring back along it and surjectivity would
be an obligation nobody spends. -/
theorem exists_isometry_map_pair {x₀ y₀ x y : ℂ} (hne : x₀ ≠ y₀) (h : dist x y = dist x₀ y₀) :
    ∃ g : ℂ → ℂ, Isometry g ∧ g x₀ = x ∧ g y₀ = y := by
  have hsub : y₀ - x₀ ≠ 0 := sub_ne_zero.mpr hne.symm
  set a : ℂ := (y - x) / (y₀ - x₀) with ha
  have hnorm : ‖a‖ = 1 := by
    rw [ha, norm_div]
    rw [Complex.dist_eq, Complex.dist_eq] at h
    rw [show ‖y - x‖ = ‖y₀ - x₀‖ by rw [← norm_neg (y - x), ← norm_neg (y₀ - x₀)]; simpa using h]
    exact div_self (norm_ne_zero_iff.mpr hsub)
  refine ⟨fun z => a * z + (x - a * x₀), Isometry.of_dist_eq fun z w => ?_, by ring, ?_⟩
  · rw [Complex.dist_eq, Complex.dist_eq, show a * z + (x - a * x₀) - (a * w + (x - a * x₀))
      = a * (z - w) by ring, norm_mul, hnorm, one_mul]
  · have hkey : a * (y₀ - x₀) = y - x := div_mul_cancel₀ _ hsub
    linear_combination hkey

/-- **One forced pair is all of them.** If some pair of the plane is separated by every proper
colouring, then so is every pair at the same distance.

No side condition: see the module docstring. The colour type is arbitrary because
`SimpleGraph.Coloring.comap` already is, so the generality costs nothing here and nothing at the
call site. -/
theorem forced_pair_of_forced {α : Type*} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (unitDistance ℂ).Coloring α, C x₀ ≠ C y₀) (hd : dist x y = dist x₀ y₀)
    (C : (unitDistance ℂ).Coloring α) : C x ≠ C y := by
  by_cases hne : x₀ = y₀
  · exact absurd rfl (hne ▸ h C)
  obtain ⟨g, hg, hgx, hgy⟩ := exists_isometry_map_pair hne hd
  have := h (C.comap (unitDistanceHom (unitDistance ℂ) g
    fun i j hij => by rw [hg.dist_eq]; exact unitDistance_adj.mp hij))
  rwa [show (C.comap _ : ℂ → α) x₀ = C x from congrArg C hgx,
       show (C.comap _ : ℂ → α) y₀ = C y from congrArg C hgy] at this

/-- **A gadget's virtual edge, transported to the whole plane**: every pair of the plane at the
gadget's own distance is separated.

This is the single call the six-colour programme's Act Two makes. Its arguments are exactly what a
gadget-finder holds — a drawing, the exact-arithmetic proof that its edges are unit-length, the
distance of the forced pair, and the separation itself — and its conclusion is exactly the shape
`Instances/HexShell.lean`'s composition consumes.

It exists because without it every caller writes the same three-step composition by hand
(`Separated.comap`, then `unitDistanceHom`, then `forced_pair_of_forced`, then a `dist` massage),
once per distance class. The `_plane` suffix is this repository's convention for "the plane
corollary of", as in `hexShell_pigeonhole` and `hexShell_plane`. -/
theorem Separated.plane {ι : Type*} {G : SimpleGraph ι} {k : ℕ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hs : Separated G k u v)
    (C : (unitDistance ℂ).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x ≠ C y :=
  forced_pair_of_forced (fun C' => hs.comap (unitDistanceHom G q hq) C') (hxy.trans hd.symm) C

end HadwigerNelson
