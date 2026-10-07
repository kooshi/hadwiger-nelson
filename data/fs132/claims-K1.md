# FS-132 — the kernel lane's claim list (FS132-K1)

*Fixed by Keryx, 2026-10-07 (UTC), for the kernel lane's planner: the statements and their not-claimed lines, copied by script
from the derivers' entries, and nothing else — no grade, no route, no model. Terms a statement uses and does not define are
those of `[OAIMath2026]` family 158 (its manuscript's Definitions 1.2, 5.1, 6.1; its Lean under
`lean/OAI/Geometry/PlaneColoring/` of the clone) and of the import module `Proofs/HadwigerNelson/Outside/OAI158.lean`. In the
order the planner takes them. A later change is a dated line at the end.*

**C132-M-ORBIT** — statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure

*Not claimed (C132-M-ORBIT):* anything when the palettes near one of the six directions ψ + kπ/3 hold no outside label on a set of positive measure (rings with (Q) arcs at the orbit: FS-124); that a six-colouring with hypothesis (a) exists; that a point whose transition graph contains a four-cycle carries the sets K_j (that is the extraction's, under its hypothesis on the centres); anything at seven labels or more (M2 and M9 spend six); anything about a cycle of three, five or six labels; any value of χ(ℝ²); that a map's four-colour vertex carries the sets K_j (the edge exclusion for maps is row 134's base, not re-derived here)

**C132-M-EXCL** — statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y

*Not claimed (C132-M-EXCL):* what C132-M-ORBIT does not claim; that the centre is binary for no pair at all (only for the pair outside the cycle)

**C132-DIAG-WIDE** — statement: let U be an open set of the plane containing the closed unit disc about a point p, c a weak measurable six-colouring of U, and D, D′ two disjoint pairs of labels; then there is no measurable map w from the unit circle to {D, D′} with w(e) ⊂ P_p(e) and w(Re) ≠ w(e) for almost every unit vector e, R the rotation by π/3

*Not claimed (C132-DIAG-WIDE):* anything about a ring that takes a third state (a palette holding an outside label) on a set of positive measure — the mixed rings of FS-124; anything at seven labels or more (three labels outside leave the triangle properly colourable)

**C132-CONFINE** — statement: let K be a compact connected set and H a set with H ∩ Δ(K) = ∅; then for every z ∈ H, either K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅; in particular, if x ∈ K and z ∈ H with |z − x| < 1 then K ⊂ B̄(z, 1), and if x ∈ K, z ∈ H, |z − x| = 1 and (q_m) is a sequence in K ∖ {x} tending to x with (q_m − x)/|q_m − x| → v, then v·(z − x) ≥ 0 when K ⊂ B̄(z, 1) and v·(z − x) ≤ 0 when K ∩ B(z, 1) = ∅

*Not claimed (C132-CONFINE):* which of the two cases occurs; that the two cases exclude each other when |z − x| = 1 (K = {x} satisfies both); anything about labels — the statement has no colouring in it

**C132-CORES-FREE** — statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed disc of radius greater than 1 contains a cyclic centre

*Not claimed (C132-CORES-FREE):* that a closed disc of radius 1 or less contains one (in the model every disc of radius 2/5 does; the constant here is the mesh bound of Lemma 7.6, not a sharp one); that the centre found carries any continuum; anything about a colouring defined only on a disc

**C132-INDEX** — statement: Let a, b, c be three labels, Θ the union of the edges ab, bc, ca of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6

*Not claimed (C132-INDEX):* anything for a ring that is only measurable; for a loop whose changes at e and at Re may coincide (six sectors a, b, c, a, b, c of angle π/3 have degree 2, and a, b, a, b, a, b degree 0: the control's fault); for four labels (the target is then a graph of rank three, with no degree); that the ring of any colouring satisfies the hypothesis

**C132-RING-WIND** — statement: let N be a set of three labels, Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e, and J the set of the directions e having no arc about e on which Π is almost everywhere equal to one set; if J is finite and no two of its points are at angle π/3, then on each arc of S ∖ J the function Π is almost everywhere one singleton or one pair, two consecutive arcs carry subsets of one pair, and the closed walk they make around the triangle on N has winding number congruent to 3 modulo 6

*Not claimed (C132-RING-WIND):* the conclusion when two points of J are π/3 apart (the fault of control `ring-degree`); when J is infinite; for a set N of four labels; that the pure-side palette of any colouring has a finite J

## Dated lines

- **2026-10-07 (the coordinator's ruling on the planner's mid-phase question; FS-132 inventory item 22):** for the kernel
  module, **C132-M-ORBIT, C132-M-EXCL and C132-DIAG-WIDE are stated first for a weak measurable six-colouring of the whole
  plane** — the instance `U = ℂ` of each statement above — so that the release's statements they stand on can be declared
  outside theorems in the import's form. The statements above, for an open set containing the closed unit disc, stay as the
  claim list's; their local form in Lean is a port with a changed hypothesis and is not planned in this job: say what it
  would take, and stop there. *Why*: the road to seven reads colourings of the whole plane (the transfer gives one); the
  local form is read by fragments on discs, which no Lean statement consumes yet.

