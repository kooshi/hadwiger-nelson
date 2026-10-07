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
- **2026-10-07 (after FS132-K2's hand-back; FS-132 inventory item 39): the list is extended by the second round's seven
  statements the module states next — "tier A" of the planner's draft (branch `fs132-wk1`, `plans/FS132-kernel-plan.md`
  Stage 7), in its order, the statements and not-claimed lines copied by script from `plans/FS132-derivation.md`.** Each is
  planned at the whole plane first, as the line above rules. **Named as the order after them, and fixed only when their
  planner's job is briefed**: C132-LENS, C132-LENS-SIDE, C132-LENS-FOUR, C132-LENS-GERM, C132-ALT (the third round, on these
  seven); then C132-WIT-SUPER, C132-CORES-SQUARE (a gap in the derivation file: a kernel proof would close it; the release's
  Lean mesh threshold is 2 where the statement needs every threshold above 1, so its port carries the threshold as a
  parameter), and the two index lemmas already above. **Left out, by the planner's reasons, which I accept**: entries whose
  own handoff says "only with a consumer" (C132-WITNESS, C132-TURN-EDGE, C132-PLACED-RING and the relay results), the
  extraction with its continua (it waits), the search's results (certificates in a finite family, not theorems of this
  module), the calibrations at seven, and every stall.

**C132-WIT-MARGIN** — statement: let c be a measurable map from the plane to a finite set of labels, H_i the closed essential support of the class of i, p a point, η > 0, and I a set of labels each of whose supports H_i misses the open annulus of the points z with 1 − η < |z − p| < 1 + η; then H_i ∩ Δ({p, q}) = ∅ for every i in I and every point q with 0 < |q − p| ≤ η; so if I has at least three labels, every cyclic order of three or more of them, with any such points q_j, satisfies the conclusion of C132-WIT-EX at p

*Not claimed (C132-WIT-MARGIN):* that p is a cyclic centre, or that any label of I is present at p (control `margin-witness`: thirteen points about a vertex, twelve of them no centres); that every weak colouring has such a point; the anchored form

**C132-WIT-SIDE** — statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels, H_i the closed essential support of the class of i, E a set of labels, x and q two distinct points with H_i ∩ Δ({x, q}) = ∅ for every i in E, and w a point of U with |w − x| = 1 and |w − q| ≠ 1; then there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has its label outside E if |w − q| < 1, and almost every point z of B(w, η) with |z − x| < 1 has its label outside E if |w − q| > 1

*Not claimed (C132-WIT-SIDE):* anything when |w − q| = 1; anything about the other side of the unit circle about x; that the labels of E are present anywhere

**C132-WIT-STRIP** — statement: let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable k-colouring of U, i_0, i_1, i_2 three distinct labels, N the set of the other k − 3 labels, and for each j modulo 3 let q_j be a point other than x with H_{i_j} ∩ Δ({x, q_j}) = ∅ and H_{i_{j+1}} ∩ Δ({x, q_j}) = ∅; then for every unit vector e with |x + e − q_j| ≠ 1 for j = 0, 1, 2 there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if |x + e − q_j| < 1 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if |x + e − q_j| > 1 for at least two j; the unit vectors f with |x + f − q_j| = 1 for some j are those with 2 f·(q_j − x) = |q_j − x|², at most six; and P_x(e), read with samplings inside U, meets N for almost every e

*Not claimed (C132-WIT-STRIP):* purity of both sides at one direction; that P_x(e) lies inside N; anything at the at most six excluded directions; that the labels i_j are present at x; that a point x with such q_j is a cyclic centre (it need not be: control `margin-witness`, Stage 3); anything for a cycle of four or more labels; that the class is inhabited at six

**C132-SHADOW** — statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, p and p′ two points of U with |p − p′| = 1, v a unit vector with v·(p′ − p) ≠ 0, r > 0, and W an open subset of U that contains the points p′ + sv for 0 < s < r and almost every point of which has the label i; then there is η > 0 such that, if v·(p′ − p) > 0, almost every point z of B(p, η) with |z − p′| < 1 has a label other than i, and, if v·(p′ − p) < 0, almost every point z of B(p, η) with |z − p′| > 1 has a label other than i

*Not claimed (C132-SHADOW):* anything when v is tangent at p′ to the unit circle about p — then only the points whose unit circle crosses that circle inside W are reached, a sub-wedge whose opening shrinks with the size of W (control `seeing`: 0.194, 0.083, 0.000); anything for a set W that is not open (a set of positive density reaching p′ gives the statement for the points whose unit circles meet it in positive length, which need not be almost all points of a side); anything about the other side of the unit circle about p′

**C132-CROSS** — statement: let L be a finite set of labels, U an open set of the plane, c a measurable map from U to L, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, w a point of U with |w − x| = |w − y| = 1, and 𝒦_x, 𝒦_y two finite families of pairs (K, E) of a compact set K and a set E of labels with H_i ∩ Δ(K) = ∅ for every i in E, where Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1, with x ∈ K for the pairs of 𝒦_x and y ∈ K for the pairs of 𝒦_y; let E_x^out be the union of the sets E over the pairs of 𝒦_x whose K has a point q with |w − q| < 1, E_x^in the union over the pairs of 𝒦_x whose K has a point q with |w − q| > 1, E_y^out the union over the pairs of 𝒦_y whose K has a point q with |w − q| < 1, and E_y^in the union over the pairs of 𝒦_y whose K has a point q with |w − q| > 1; then none of the four sets E_x^out ∪ E_y^out, E_x^out ∪ E_y^in, E_x^in ∪ E_y^out, E_x^in ∪ E_y^in is all of L

*Not claimed (C132-CROSS):* anything at |x − y| = 2 (the circles are tangent and one quadrant is empty: the fault of control `crossing`) or at x = y; anything about a set K all of whose points are at distance 1 from w — such a pair enters none of the four unions; that the exclusions hold for any colouring (they are hypotheses here: at an extracted centre they are clause (3) of C132-EXT-DISC, in a map the edge exclusion, C132-WITNESS below); any area or scale (the quantified form with holes is FS107-R-CP, row 133)

**C132-COMP-SHARP** — statement: let U be an open set of the plane, c a measurable map from U to a set of six labels, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, t_0, t_1, t_2 and t′_0, t′_1, t′_2 the six labels, K_0, K_1, K_2 compact sets containing x with H_{t_j} ∩ Δ(K_j) = ∅ and H_{t_{j+1}} ∩ Δ(K_j) = ∅ for each j modulo 3, K′_0, K′_1, K′_2 compact sets containing y with H_{t′_j} ∩ Δ(K′_j) = ∅ and H_{t′_{j+1}} ∩ Δ(K′_j) = ∅ for each j modulo 3, and w a point of U with |w − x| = |w − y| = 1; then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w

*Not claimed (C132-COMP-SHARP):* which of the six sets it is, or that it is one of x's; anything with seven labels or more (two triangles then leave a label outside both, and the honeycomb is the model of that); anything at a point with three labels and only two witnessed pairs (a bowtie: sectors a, b, a, c have no edge b–c, and fragments S1, BB and MX of FS110-FRAGS are valid with one); that a configuration with a set on the unit circle about w is impossible — fragment T2 is one, on small neighbourhoods of four points

**C132-PLACE** — statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, N the set of the three other labels, and ψ an angle such that at least two of the sets K_j have a point q with |x + e(ψ) − q| < 1; then there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and −κ < d < 0 the label of the point x + e(α) + e(α − 2π/3 − d) lies in N and in neither of the palettes P_x(e(α)) and P_x(e(α − 2π/3 − d)); and if at least two of the sets K_j have a point q with |x + e(ψ) − q| > 1, there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and 0 < d < κ the label of that point lies in N and in neither of those two palettes

*Not claimed (C132-PLACE):* anything on the side that is not pure — there the label lies outside the two palettes and may be a label of T; anything at a ring point with no pure side (then one of the sets K_j lies on the unit circle about the ring point, by the pigeonhole of C132-COMP-SHARP); that the two palettes are singletons, or that the outside state is a step; that the ring point is a cyclic centre

