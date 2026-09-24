# FS-79 phase P3 — every cell of Θ₄ on `L21cc6506`, exactly

*The P3 implementer (de Bruijn), 2026-09-24. Close-inventory item 89 (3): enumerate every cell of L21cc6506's Θ₄ exactly before any
forcing run for route (ii) (G55's chain at five colours over ℚ(√167)).*

## Registration (written and committed before the first run)

**The question.** Θ₄ = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(u) ∈ [1/4, 3/4] mod 1 for every u ∈ U}, Λ = `L21cc6506` = Λ₄₂₀, U its 60 unit vectors.
Its cells are the nonempty polytopes {θ ∈ ℝ⁴ : k_u + 1/4 ≤ θ(u) ≤ k_u + 3/4}, taken up to ℤ⁴ translation. For each cell: its dimension,
its constant unit vectors, one rational point. Then the intersection over all cells of the constant sets, and the upper bound on `P`
that the circular colourings give: `P ⊆ P_circ = ⋂_cells {δ ∈ Λ : V_cell(δ) = 0, θ_cell(δ) ∈ ℤ}`, where `V_cell` is the direction
space of the cell's affine hull.

**A reduction noted before running (to be checked, not assumed).** Multiplication by `i`, complex conjugation and the Galois flip
`√167 ↦ −√167` map the set of denominator-420 unit vectors to itself, so (if the run confirms it) they are automorphisms of
`Cay(Λ, U)` and the cell set is invariant under them. They preserve the rational pattern U_R and act on the rational plane by a rotation
of order 4, which fixes no line. The known 5,880 cell's constant set is exactly U_R. So the bound's real span `W = ⋂ V_cell^⊥` is either
**0** or **the rational plane**; nothing in between is possible, except through an error in this argument. The intersection of constant
sets is then one of ∅, {±1, ±i}, the other eight vectors of U_R, or all twelve.

**Prediction P3-1.** Probabilities for the intersection of the constant sets and the bound `W`:

| outcome | probability |
|---|---|
| `W = 0`: some cell of dimension ≥ 1 moves the rational layer, so the intersection of constant sets spans rank 0 and route (ii) at L21cc6506 is dead from circular colourings alone | 0.50 |
| `W` = the rational plane: every cell of dimension ≥ 1 freezes the rational layer, so the intersection is (a G-invariant part of) U_R and route (ii) stays open (not supported) | 0.45 |
| anything else (a rank-1 or other bound), which the symmetry argument above forbids | 0.05 |

*Why so even.* The two known cells point opposite ways: the 4,200 cell is a point, the 5,880 cell freezes exactly U_R. Nothing I know
makes the rational layer special among the five layers `b·U_R` (b ∈ {1, v, v̄, z, z̄}) except that it is the only one fixed by the
symmetries, which is no reason for it to be frozen in every cell. **Also registered:** the cell count is below 10⁴ (0.8), and no cell
is full-dimensional (0.7).

**Controls, both outcomes reachable.**
1. The 4,200 point and the 5,880 point (phase 0's witnesses) must fall in enumerated cells of dimension 0 and 2, with 60 and 12 constant
   unit vectors. A miss means the enumeration is wrong.
2. The same code at three colours must find Θ₃ empty (row 79). A leaf there means the code is wrong.
3. A planted fault, one ± pair of unit vectors dropped, must change the enumeration. If it does not, that pair's constraint is redundant
   everywhere, and the plant must be moved to another symmetry orbit before the control counts.
4. The cell set must map to itself under every automorphism in (A) above. A cell whose image is not in the list means a missed cell.

## Theorems this phase proved

*(filled at the end of the phase)*
