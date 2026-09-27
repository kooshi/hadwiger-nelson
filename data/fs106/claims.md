# FS-106 — the fixed claim list (statements only)

*Written by the milestone planner (job FS106-P), 2026-09-26. **Statements only: no proof, no sketch, no route, no list of where a hypothesis is used.**
Every quotation is verbatim with its source address (the printed papers are quoted from their text layer, `pdftotext -layout`, symbols as there);
where a claim is this list's own wording, it says so. Grades are `CLAUDE.md` § Notation's. Give every claim one verdict — **TRUE** (with your
derivation), **FALSE** (with a counterexample), **GAP at a named step**, or **MISSTATED** (give the corrected statement and grade it) — with your count of
minds and your grade. A verdict on a printed theorem (§2) is a verdict on **its proof as printed**: TRUE means you checked every step; name any step you
repaired. Nothing is held unless §1 lists it with a grade. FALSE and GAP are results, as valuable as TRUE.*

## 0. Definitions

- **D-NORM** (`[Voronov2023]` §2, p. 4): "the unit circle centered at the point x ∈ R2 is T1 (x) = {y ∈ R2 : ∥y − x∥U = 1}. Similarly, the disc of
  radius r > 0 centered at x is Ur (x) = {y ∈ R2 : ∥y − x∥U ≤ r}." And (p. 3): "We say that the set M ⊂ R2 realizes a distance d if there are points
  x, y ∈ M for which ∥x − y∥U = d." Unless a claim says otherwise, the norm is Euclidean and `S(x, r)` is `T_r(x)`.
- **D-VPROP** (`[Voronov2023]` Def. 2.1, p. 5): "Let us call a coloring of the plane φ : R2 → {1, 2, . . . , k} for some forbidden interval D = [1 − ε,
  1 + ε] proper, if there is no pair of points u, v ∈ R2 such that ∥u − v∥ ∈ [1 − ε, 1 + ε] and φ(u) = φ(v)."
- **D-VMC** (`[Voronov2023]` Defs. 2.3–2.4, p. 5–6): "A point x has multicolor C(x) ⊆ {1, 2, . . . , k} in some coloring of the plane φ if there are points
  of each color belonging to C(x) in an arbitrarily small neighborhood of x, and C(x) is the maximal set by inclusion for which this condition is
  satisfied." "The number |C(x)| … will be called the chromaticity of point x. Points of chromaticity 3 will also be called trichromatic".
- **D-SV** (`[SokolovVoronov2025]` §2, p. 3–4, verbatim):
  - Condition 1: "A proper k-coloring of the plane is a function c : R2 → {1, 2, . . . , k} such that for any points x, y ∈ R2 with ∥x − y∥ = 1, we
    have c(x) ̸= c(y)."
  - Condition 2: "A Jordan (proper) coloring of the plane is a coloring in which the plane is partitioned into vertices, boundaries, and regions,
    satisfying the following conditions: • Vertices are points. • Boundaries are Jordan curves terminating at vertices. • Regions are the connected
    components formed by the vertices and boundaries, with all points in a given region assigned the same color. • Any two regions sharing a boundary
    must be assigned different colors. • Every vertex is an endpoint of at least three boundaries."
  - Condition 3: "A Jordan coloring of a plane is called locally finite if any bounded subset of the plane intersects only a finite number of
    boundaries." Condition 4: "A map-type coloring is a Jordan coloring that is also locally finite."
  - Condition 5: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden."
  - Condition 6: "There are no trichromatic vertices of degree greater than 3." Condition 7: "The degree of any vertex is 3".
  - Condition 8: "Polygonal coloring of the plane is such a map-type coloring that all regions are polygons."
  - Definition 2: "The multicolor of a point u, denoted c(u), is the set of colors assigned to the regions whose closure contains u."
- **D-M** (FS-103's `data/fs103/claims.md` D-M, verbatim): "`χ_m(ℝ²)` the least `k` with a Lebesgue-measurable proper `k`-colouring of `UD(ℝ²)` (proper at
  every edge); `χ_m⁰(ℝ²)` the least `k` with a measurable `k`-colouring proper at almost every edge (for almost every `(x, w) ∈ ℝ² × S¹`)". Here `σ` is
  normalised arc length on `S¹` and "almost every edge" is for `Leb ⊗ σ`.
- **D-CP** (FS-103's D-CP (b), verbatim): "**CP `k`-colouring** of a Cayley graph `Cay(G, T)`, `G` a second-countable LCA group (J39's gloss): a random map
  `c : G → [k]` (a family of random variables on one probability space) whose law is invariant under every translation of `G`, with `P(c(x) ≠ c(y)) → 0`
  as `y → x`, and `P(c(x) = c(x + w)) = 0` for every `x ∈ G` and `w ∈ T`."
- **D-NF, the normal form** (this list's wording, from `plans/FS103-M-derivation.md` §3.1 and `CLAUDE.md` § The aim link 5). For a measurable
  `f : ℝ² → [k]` proper at `Leb ⊗ σ`-almost every edge: `S_j = f⁻¹(j)`; `S̃_j` the points of density 1 of `S_j`; `E = ℝ² ∖ ⋃_j S̃_j` (Falconer's null
  set); `d̄_j(x) = limsup_{r→0} |S_j ∩ B(x, r)|/|B(x, r)|`; **`P(x) = {j : d̄_j(x) > 0}`**, the *essential multicolour*. The classes `S̃_j` are
  *density-open* (every point of `S̃_j` is a density point of `S̃_j`).
- **D-SLACK** (this list's wording). A measurable `f` has *slack `ε`* in form (a) if `(Leb ⊗ Leb){(x, y) : f(x) = f(y), 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`;
  in form (b) if for every `d ∈ [1 − ε, 1 + ε]`, `(Leb ⊗ σ){(x, w) : f(x) = f(x + d w)} = 0`. *Tight*: slack for no `ε > 0` (`CLAUDE.md` link 5, "tight
  (no band avoided)"; not Hoffman's sense).
- **D-AEMAP** (this list's wording). For a map-type colouring (Conditions 2–4) *a.e.-proper* means: no two points of **open regions** of one colour
  are at distance 1; boundaries and vertices carry no colour.
- **D-MU** (this list's wording, after `[SokolovVoronov2025]` §9). `µ₆(ε)`: the supremum of the upper density of `C₁ ∪ ⋯ ∪ C₆` over disjoint measurable
  `C₁, …, C₆ ⊆ ℝ²`, each with `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`.

## 1. Held inputs (use as held; each with its grade and count of minds)

- **I-D1** (`plans/FS103-M-derivation.md` §3.1, D1, verbatim): "If `y ∈ S̃_j` and `d̄_j(x) = θ > 0`, then `|x − y| ≠ 1`." [hand, one mind]
- **I-D2** (same, D2): "For `x ∈ E`, `|P(x)| ≥ 2`." [hand, one mind]
- **I-D4** (same, D4, statement): "Say `f` has *slack* if for some `ε > 0`, `(Leb ⊗ Leb){(x, y) : f(x) = f(y), 1 − ε < |x − y| < 1 + ε} = 0`. … **Then
  `c(x) = min{j : x ∈ supp S_j}` is proper at every pair at distance in `(1 − ε, 1 + ε)`, and its classes are differences of closed sets (Borel).**"
  [hand, one mind]
- **I-M1** (`LEDGER.md` row 130): "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)`" [hand, two derivations]. **I-EASY** (`plans/FS103-N-verification.md` §2.7):
  "`χ(ℝ²) ≤ χ_m⁰(ℝ²)` with no MR and no CP" [hand, two minds].
- **I-CE** (`[CurrieEggleton2016]` Thm 1, as quoted in `plans/FS103-M-derivation.md` D5): "Fix ǫ, 0 < ǫ < 3√2/4 − 1. Let H be the graph whose vertices
  are the points of R², with an edge between every pair of points whose distance lies in the interval [1, 1 + ǫ]. Then 6 ≤ χ(G) ≤ 7" [external, read].

## 2. The printed theorems (Phase V: verify each proof first-hand)

- **V-1.1** (`[Voronov2023]` Thm 1.1, p. 2): "For any 2-dimensional norm ∥ · ∥U and ε > 0 it holds that χ[1−ε,1+ε] (R2 ; U ) ≥ 7."
- **V-1.2** (Thm 1.2, p. 2): "Denote the unit circle centered at x by T1 (x) = {y : ∥x − y∥U = 1}. Then for ε > 0 and 1 < ∥u − v∥U < 2 it holds that
  χ[1−ε,1+ε] (T1 (u) ∪ T1 (v); U ) ≥ 4."
- **V-1.3** (Thm 1.3, p. 3): "Suppose that the disc of radius 3 defined by an arbitrary 2-dimensional norm is covered by 6 closed sets. Then at least
  one of these sets realizes the unit distance."
- **V-2.1** (Prop. 2.1, p. 5): "Suppose that for D = [1 − ε, 1 + ε] there exists some proper k-coloring of the plane. Let the plane, in addition, be
  divided into tiles of arbitrary shape, different tiles can be of different shapes, the diameter of each tile does not exceed h, and 2h < ε. Then for
  the interval of positive length Dh = [1 − (ε − 2h), 1 + (ε − 2h)] there exists a proper k-coloring of the plane, in which the interior of each tile is
  monochromatic, and the border points are colored in some color of the adjacent tiles."
- **V-2.2** (Lemma 2.2, p. 6): "A proper coloring of the plane in an arbitrary number of colors with a forbidden interval of positive length contains
  a point of chromaticity of at least 3. We can find such a point in a circle of unit radius centered at a given point x."
- **V-P2.2** (Prop. 2.2, p. 6): "Let φ be a proper coloring of the plane in 6 colors with a forbidden interval [1 − ε, 1 + ε]. Then any two trichromatic
  points u, v for which C(u) ∩ C(v) = ∅ are at a distance ∥u − v∥ ≥ 2 + 2ε."
- **V-4.1** (Prop. 4.1, p. 10): "The indices of the complementary arcs x1 y1 = γ1 ([0, 1]), x2 y2 = γ2 ([0, 1]) differ by no more than 1." (with the
  two implications printed there).
- **V-6.1** (Lemma 6.1, p. 12): "If a proper discrete coloring of the plane with 6 colors exists, then it contains such a pair of trichromatic points u,
  v that C(u) = C(v), 1 < ∥u − v∥ < 2."
- **SV-1** (`[SokolovVoronov2025]` Thm 1, p. 5): "If the coloring is proper, Jordan, locally finite, if a vertex with degree greater than 3 cannot be
  trichromatic, and if arcs of unit curvature are forbidden, then at least 7 colors will be required, i.e. χmap+f a+3col (R2 ) = 7."
- **SV-2** (Thm 2, p. 5): "There is no polygonal coloring of the plane in 6 colors, i.e. χpoly (R2 ) = 7."
- **SV-L1** (Lemma 1, p. 6): "There do not exist two bichromatic points with the same multicolor that are exactly one unit apart."
- **SV-C2** (Corollary 2, p. 13): "There exists η > 0 and finite families of arcs Γ1 = {γ1,1 , . . . , γ1,s } and Γ2 = {γ2,1 , . . . , γ2,s }, where γi,j ⊂
  ω, such that the following conditions hold: (a) The interiors of these arcs cover the entire circle … (b) For each 1 ≤ i ≤ s, the annulus sectors
  Q(u, γ1,i , 1−η) and Q(u, γ2,i , 1+ η) are colored in colors 1, 2, 3." (`u` trichromatic with multicolour {4, 5, 6}, `ω = ω(u)`, p. 11)
- **SV-C3** (Corollary 3, p. 14): "There do not exist two trichromatic points with disjoint multicolors such that the distance between them is less than 2
  and the boundaries between each pair of colors in their respective multicolor sets extend from each point."
- **SV-L3** (Lemma 3, p. 17): "Suppose that the Conditions 4, 5 (“map-type”, “forbidden arcs”) are satisfied for a proper 6-coloring. Then there do not
  exist two trichromatic points u1 , u2 with same multicolor such that 1 < ∥u1 − u2 ∥ < 2 and the boundaries between each pair of colors in their
  multicolor extend from each of them."
- **SV-L4** (Lemma 4, p. 19): "Suppose that the Conditions 4, 5, 6 (“map-type”, “forbidden arcs”, “no trichromatic vertices of degree 4+”) are satisfied
  for a proper 6-coloring. Then there are either two trichromatic points between 1 and 2 with the same multicolor, or two trichromatic points less than 2
  with non-intersecting multicolors."
- **TW-81** (`[Townsend1981]` p. 114–115): "THEOREM. Every 5-coloured map in the plane contains a monochrome unit." and "LEMMA. Let A° be a finitely
  disconnected unit annulus for which the unit circle contained in its closure, A, has at least one segment of length greater than [a constant garbled in the text layer; read it from the scan] containing no cut
  points of A. Then any 2-colouring of A° contains a monochrome unit." (The note prints no proof.)
- **TW-05, CO-04, WO-73, TH-99, PR-98, PA-20** — `[Townsend2005]`, `[Coulson2004]`, `[Woodall1973]`, `[Thomassen1999]`, `[Pritikin1998]`, `[Parts2020c]`:
  the reading job quotes each main theorem verbatim with its definitions (map, nice, tiling) into its record; the verdict is on the proof as printed.

## 3. The closed-set step

- **C-CS-1** (this list's wording). In `[Voronov2023]`'s proof of V-1.3 (p. 14), the closedness of the six sets is used at exactly one step, the
  passage to the limit pair `(x∗, y∗)`; that step is equivalent to: *a compact set that does not realize the distance 1 avoids every distance in some
  interval `[1 − δ, 1 + δ]`, `δ > 0`.*
- **C-CS-2** (this list's wording). V-1.3 is equivalent to the statement: *for every `ε > 0`, no colouring of `U₃(0)` with 6 colours is proper (D-VPROP,
  restricted to pairs in `U₃(0)`) for `[1 − ε, 1 + ε]`.*

## 4. Almost-everywhere forms (Phase R)

- **C-AE-SLACK** (this list's wording). A Lebesgue-measurable colouring of `ℝ²` with slack `ε > 0` (D-SLACK, form (a)) uses at least 7 colours. The same
  in form (b), and on `U₃(0)`: a measurable 6-colouring of `U₃(0)` has, for every `ε > 0`, a `Leb ⊗ Leb`-positive set of monochromatic pairs in
  `U₃(0)²` at distances in `[1 − ε, 1 + ε]`.
- **C-AE-CLOSED** (this list's wording). If six closed sets `A₁, …, A₆` cover `U₃(0)`, then for some `i` the set `{(x, w) ∈ ℝ² × S¹ : x, x + w ∈ A_i}`
  has positive `Leb ⊗ σ` measure. (And the same with `ℝ²` in place of `U₃(0)`.)
- **C-AE-POLY** (this list's wording). No polygonal colouring (D-SV Condition 8) with 6 colours is a.e.-proper (D-AEMAP).
- **C-AE-FA** (this list's wording). No map-type colouring (Conditions 2–4) satisfying Conditions 5 and 6 with 6 colours is a.e.-proper (D-AEMAP).
- **C-AE-MAP6** (this list's wording). No map-type colouring (Conditions 2–4) whose boundaries have Lebesgue measure 0 is a.e.-proper (D-AEMAP) with 5
  colours. (Say whether "boundaries of measure 0" is needed.)
- **C-AE-Q2** (this list's wording; `[SokolovVoronov2025]` Question 2, p. 26, verbatim: "Is it true that 7 colors are needed to color a locally finite map
  in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?"). Every map-type
  colouring (Conditions 2–4; boundaries may contain arcs of unit circles; vertices of any degree) that is a.e.-proper (D-AEMAP) uses at least 7 colours.
  **C-AE-Q2-EV:** the same with "proper" (Condition 1) in place of "a.e.-proper" — Question 2 as posed.
- **C-AE-NICE, C-AE-CONV** — the a.e. forms of `[Thomassen1999]`'s nice-map theorem and `[Coulson2004]`'s convex-tiling theorem, stated by the reading job
  in this list's form (open regions coloured, boundaries free) once the printed statements are quoted.

## 5. The method transfer (Phase T)

*All in the normal form D-NF for an a.e.-proper measurable `k`-colouring; "trichromatic" means `|P(u)| = 3`.*

- **C-T-L1** (this list's wording; the a.e. form of SV-L1). There are no `x, y` with `|x − y| = 1` and `P(x) = P(y)`, `|P(x)| = 2`.
- **C-T-TRI** (this list's wording; the a.e. form of V-2.2). Every closed disc of radius 1 contains a point `x` with `|P(x)| ≥ 3`.
- **C-T-CHR4** (this list's wording; the a.e. form of S–V Lemma 2, p. 8: "Under Condition 5, no point in a valid 6-coloring can have chromaticity k ≥
  4."). With `k = 6`, no point has `|P(x)| ≥ 4`.
- **C-T-ANN** (this list's wording; the a.e. form of SV-C2). If `k = 6` and `|P(u)| = 3`, then for every `η > 0` there is a Jordan curve around `u`, inside
  the `η`-neighbourhood of `S(u, 1)`, at `H¹`-almost every point of which some class `S_j` with `j ∉ P(u)` has density 1.
- **C-T-IND** (this list's wording; the a.e. form of V-4.1 and S–V Prop. 12, p. 15: "If γ1 ∼ γ2 , then | Ind γ1 − Ind γ2 | ≤ 1."). For two curves of
  C-T-ANN's kind carrying complementary parametrisations (`|γ₁(t) − γ₂(t)| = 1`), an integer index is defined from the density classes along each and
  satisfies `|Ind γ₁ − Ind γ₂| ≤ 1`.
- **C-T-BIKE** (this list's wording). For `1 < |u − v| < 2` the graph on `T₁(u) ∪ T₁(v)` joining points at distance exactly 1 has a proper 3-colouring
  by finitely many arcs.
- **C-T-PIG** (this list's wording; the a.e. form of V-6.1 and SV-L4). A 6-colouring in normal form has two trichromatic points with one essential
  multicolour at distance in `(1, 2)`, or two with disjoint essential multicolours at distance `< 2`.
- **C-T-KILL** (this list's wording; the a.e. forms of V-P2.2, SV-C3 and SV-L3). Neither configuration of C-T-PIG occurs in a 6-colouring in normal form.
- **C-T-TAN** (the advisor's wording, FS106-A, one mind: "the unit relation becomes 'same projection onto e = w₀−u', so colour j is forbidden at w₀+sb
  when e·b ∈ P_e(A_j^u). Prop 2.2 then survives iff ∩_{j∈C(u)} P(A_j^u) has positive length. It fails exactly at the bowtie (a degree-4 trichromatic
  vertex; Condition 6) and at interfaces tangent to the unit circle"). State it precisely for the normal form and decide it.

## 6. The quantitative route (Phase T)

- **C-Q-REM** (this list's wording). Fix `η ∈ (0, 1/48)`. For a CP `k`-colouring `c` of `ℝ²` in normal form, call `x` *kept at scale `ε`* if `c(x) = j` and
  `|B(x, ρ) ∩ S̃_j| ≥ (1 − η)|B(x, ρ)|` for both `ρ = ε/2` and `ρ = 2ε`. Then (i) almost surely no two kept points of one colour lie at a distance in
  `[1 − ε, 1 + ε]`; (ii) `P(0 is not kept at scale ε) → 0` as `ε → 0`.
- **C-Q-COMP** (this list's wording). (i) If for every `δ > 0` there are disjoint measurable `C₁, …, C₆ ⊆ ℝ²`, each with `Leb ⊗ σ`-null monochromatic unit
  pairs, whose union has lower density at least `1 − δ`, then `χ_CP(ℝ²) ≤ 6`. (ii) For each `ε > 0`, `µ₆(ε)` (D-MU) is attained by a stationary random
  family, and `µ₆(ε) < 1`.
- **C-Q-EQ** (this list's wording). `χ_m⁰(ℝ²) ≥ 7` if and only if `lim_{ε→0} µ₆(ε) < 1`.
- **C-Q-STAB** (the advisor's wording, FS106-A: "for some δ > 0 and every ε > 0, no colouring of the radius-3 disc by six band-proper colours plus a free
  seventh colour of density at most δ exists"; `[SokolovVoronov2025]` §9, p. 26, verbatim: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the
  fraction of the plane that can be correctly colored in 6 colors with forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow
  definitively that χmap (R2 ) = 7."). Decide it; `[Parts2020c]`'s six-colour tiling of "more than 99.985698% of the Euclidean plane" bounds any `δ` from
  above.
- **C-Q-HOLE** (this list's wording). V-2.2 and V-6.1 hold for a colouring of `U₃(0)` by six colours proper for `[1 − ε, 1 + ε]` on the complement of a
  set of density at most `δ` (for some `δ > 0` independent of `ε`), with "trichromatic point" read in the complement.

## 7. Row 40

- **C-ROW40** (this list's wording). `LEDGER.md` row 40's "conditional on `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]`" is discharged by Phase V's
  verdicts on V-1.1 and SV-2, or corrected by them.
