# FS110-CD — blind verification: Sokolov–Voronov Corollary 1 almost everywhere, no `d = 2` exception

*Job FS110-CD (Coxeter, verifier, blind), Opus 5.5, 2026-09-27. Brief: `data/fs110/briefs/CD110-reduction-blind.md` with
`data/fs110/briefs/STANDING-RULES.md`. Blind: nothing fenced opened before stage 3 is committed. Working directory for scratch:
the harness scratchpad `fs110-cd/` (own files only); committed working files: `data/fs110/fs110-cd/`.*

## Stage 1 — SAVED

### 1.1 Quotation check

Source: `~/source/library/pdf/arXiv-2502.01958-maptype.pdf` (arXiv v1, 4 Feb 2025), text extracted with `pdftotext -layout`, read in
full (all 29 pages, §§1–10 and the appendix). Also read, for the steps S–V import: `~/source/library/pdf/arXiv-2304.10163-voronov.pdf`
(`[Voronov2023]`, S–V's reference [11]) §2 (Prop. 2.2), §3 (Props. 3.2–3.4), §6 (Lemma 6.1).

The statements the brief asks for, verbatim (ligatures and the extraction's line breaks normalised; nothing else changed):

- **Condition 3.** "(lf = “locally finite”) A Jordan coloring of a plane is called locally finite if any bounded subset of the plane
  intersects only a finite number of boundaries."
- **Condition 5.** "(fa = “forbidden arcs”) If any boundary intersects with a circle of unit radius at a finite set of points, we say
  that arcs of unit curvature are forbidden."
- **Condition 6.** "(3col = “no trichromatic vertices of degree 4+”) There are no trichromatic vertices of degree greater than 3."
- **Condition 7** (the one Corollary 1 uses). "(cubic = “no vertices of degree 4+”) The degree of any vertex is 3, or, in other words,
  the map is an embedding of some planar cubic graph."
- **Corollary 1.** "χ_{map+fa+cubic}(R²) = 7." (Preceded by: "Obviously, Condition 7 is stronger than Condition 6.")
- **Lemma 3.** "Suppose that the Conditions 4, 5 (“map-type”, “forbidden arcs”) are satisfied for a proper 6-coloring. Then there do not
  exist two trichromatic points u1, u2 with same multicolor such that 1 < ∥u1 − u2∥ < 2 and the boundaries between each pair of colors
  in their multicolor extend from each of them."
- **Lemma 4.** "Suppose that the Conditions 4, 5, 6 (“map-type”, “forbidden arcs”, “no trichromatic vertices of degree 4+”) are
  satisfied for a proper 6-coloring. Then there are either two trichromatic points between 1 and 2 with the same multicolor, or two
  trichromatic points less than 2 with non-intersecting multicolors."
- **Lemma 5.** "If ω is properly colored with three colors, then it is possible to recolor some of the monochromatic arcs of ω so that
  the coloring remains proper and becomes cyclic. This recoloring does not create new bichromatic points, and the previous bichromatic
  points either become interior points of monochromatic arcs or remain unchanged."
- **Proposition 17.** "On ω, there do not exist six points x1, …, x6 with two-element pseudo-colors such that these points are the
  vertices of a regular hexagon, where: • At x1 and x4, the semicircles on ω are colored 1 and 2. • At x2 and x5, the semicircles on ω
  are colored 2 and 3. • At x3 and x6, the semicircles on ω are colored 3 and 1. • At each xi, the semicircle on the side of xi−1 is
  colored in the first color of the pair, and the semicircle on the side of xi+1 is colored in the second."
- **Proposition 18 (3.2, [11]).** "If there are at least 9 bichromatic points in a cyclic regular coloring of a circle, then for any
  pair of colors {1, 2}, {2, 3}, {1, 3}, {1, 3} there are three bichromatic points with such multicolor whose pairwise distances between
  them are greater than 1."
- **Proposition 19 (3.3, [11]).** "If a closed circle of unit radius centered at point u is 6-colored under the conditions of Theorem 1,
  and the circle ω(u) contains at least 9 bichromatic points, then for each pair of colors {1, 2}, {2, 3}, {1, 3}, {1, 3} there are three
  bichromatic points with such a multicolor for which (a) pairwise distances are greater than 1, (b) the bichromatic boundaries extending
  from their point on the circle end at a tricolor point inside the circle."
- **Appendix, proof of Prop. 19** (the recolouring): "For any boundary p1 p2 connecting two bichromatic points p1, p2 on the circle, it
  is possible to completely recolor the region of diameter less than 1 that p1 p2 separates from the circle into one of the colors, after
  which the points p1, p2 become monochromatic. The coloring of the circle and the interior will remain correct."
- **Appendix, proof of Lemma 4** (the pigeonhole), closing sentences: "If the multicolors of two points pj coincide, we immediately get
  the desired one. Otherwise, inside the circle there are 2⁻¹·C(6,3) = 10 trichromatic points whose multicolors are pairwise different
  and do not complement each other up to {1, 2 . . . , 6}. It remains to notice that on the boundary of the union of three regions of
  colors 1, 2, 3 whose vertex is u, there is at least one more trichromatic point (Fig. 6)." (The extraction prints the count as
  "21 63"; I read it as 2⁻¹·C(6,3) = 10 from the sentence's own count. "colors 1, 2, 3" here must mean the regions at u, whose colours
  are 4, 5, 6 in the proof's normalisation — a printed slip, logged.)
- **Corollary 3** (used by the pigeonhole). "There do not exist two trichromatic points with disjoint multicolors such that the distance
  between them is less than 2 and the boundaries between each pair of colors in their respective multicolor sets extend from each point."

Quotations in my brief and the standing rules, checked:

| quotation | source | result |
|---|---|---|
| rule 0: "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim (grep -F, 1 hit) |
| rule 3: "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | `CLAUDE.md` § Toolchain | verbatim |
| rule 3: "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` Frontier item 23 | verbatim |
| brief: "every pigeonhole endpoint lies in the open disc" | FS110-CB's record (fenced) | **not checkable before stage 4**; checked there |
| brief item 1, the claim's statement ("A locally finite map … distance exactly 1") | a restatement, not a quotation | compared with the print below |

**The brief's statement against the print.** It is not S–V's Corollary 1 but its almost-everywhere analogue on a narrower class:
- S–V's colourings are proper at *every* point (Condition 1), with boundary points given a colour (Observation 1); the brief's asks only
  that same-coloured tiles have no two *interior* points at unit distance, and allows adjacent tiles of one colour (S–V's Condition 2
  forbids that).
- "Tiles bounded by finitely many circular arcs and segments, none of radius 1" implies Condition 5 (such a curve meets a unit circle in
  at most two points per piece) and is narrower than it.
- "Exactly three tiles at every vertex" is Condition 7 (cubic). The brief says "Read Conditions 3, 5 and 6"; Corollary 1 uses 7, which
  implies 6. Logged, no consequence.

### 1.2 Restatement

**Setting (A).** `M` is a locally finite map of ℝ² whose tiles are bounded by finitely many circular arcs and segments, none of radius 1,
each vertex on exactly three tiles. `c` assigns each tile one of six colours so that for tiles `T, T′` of one colour (possibly `T = T′`)
no `x ∈ int T`, `y ∈ int T′` have `|x − y| = 1`.

**Claim to verify.** No such `(M, c)` exists; and in particular, in S–V's route (Lemma 4's pigeonhole in a closed unit disc about a
trichromatic vertex `u`, then Lemma 3 or Corollary 3), no colliding pair of pigeonhole points is at distance exactly 2 — equivalently, no
colliding pair is antipodal on the unit circle `ω(u)` — so no `d = 2` exception is needed. CB's reported route: replace Prop. 19's
recolouring of the plane by a reduction on the circle only, after which every pigeonhole endpoint is in the open disc.

**Where `d = 2` enters the print.** Lemma 4's pigeonhole places eleven trichromatic points in the closed unit disc about `u` (u; the
nine endpoints `p` of boundaries from the nine selected circle points; one point on the boundary of the regions at `u`). A colliding
pair is then fed to Lemma 3 (same multicolour; needs `1 < d < 2`) or Corollary 3 (disjoint; needs `d < 2`). In the closed disc
`d ≤ 2`, with equality exactly for antipodal points of `ω(u)`. Nothing in the print keeps the points off `ω(u)`; and Prop. 19's
recolouring changes the plane, so the points it finds are trichromatic in the recoloured colouring, not certainly in the original one,
while Lemma 3 and Corollary 3 are applied to the original.

### 1.3 Registered expectation (before stage 2 is written)

*Registered after reading the paper and Voronov's §§2–3, 6, and after a first look at the geometry of the `d = 2` configuration: two
points antipodal on `ω(u)` have unit circles tangent at `u` itself, and `u` is a vertex whose three regions cover a neighbourhood.*

- **Expected (about 0.7):** the `d = 2` collisions can be killed without keeping the points off `ω(u)`, by a lemma about the regions at
  `u` (a region of a colour of `u` that reaches a point `v` of `ω(u)` from inside forces `u`'s region of that colour into the closed
  unit disc about `v`; two antipodal such discs meet only at `u`). So the verdict on "no `d = 2` exception" is TRUE. I expect the
  circle-only reduction to be derivable (Voronov's recolouring argument read on the circle alone) — but I expect it **not** to put every
  endpoint in the open disc: a selected circle point that is itself a vertex, with its third colour inside the disc, looks like an
  endpoint on `ω(u)` that no reduction on the circle removes. So on CB's sub-claim "every pigeonhole endpoint lies in the open disc" I
  expect GAP (at that configuration), with the conclusion rescued by the lemma above.
- **The other outcome, reachable:** a configuration in which two colliding points sit antipodally on `ω(u)` and neither Lemma 3,
  Corollary 3 nor any region lemma excludes it — then the verdict is GAP at `d = 2` with that configuration named. Or: the circle-only
  reduction fails (the recoloured circle is not proper), and CB's route has a GAP there.
- What would move me: an endpoint type on `ω(u)` whose third-colour region lies *outside* the disc surviving the reduction (the region
  lemma would not apply to it).

## Stage 2 — SAVED

*The derivation, blind. Notation: `B(x,r)` open disc, `B̄(x,r)` closed disc, `ω(x)` the unit circle about `x`; `σ` the rotation of
`ω(u)` by 60° about `u` (two points of `ω(u)` are at distance 1 iff one is `σ^{±1}` of the other). Grades per `CLAUDE.md` § Notation.*

### 2.0 From setting (A) to a merged map, and the three facts used from Props. 1–3

Delete every edge of `M` whose two sides have one colour. The regions of the resulting network `N′` are open, each is one colour, and
`C_i` (the union of the regions of colour `i`) has **no two points at distance 1**: if `p, q ∈ C_i` with `|p − q| = 1`, move `p` to a
tile interior `p′` nearby; `ω(p′)` meets the open set `C_i ∋ q` in an arc of positive length, which the edges (finitely many arcs and
segments of radius ≠ 1, each meeting `ω(p′)` in ≤ 2 points) cannot cover, so it holds a tile-interior point of colour `i` at distance 1
from `p′`. Every remaining edge has two colours on its sides, so **adjacent regions differ in colour**; a point of `N′` is either a
**trichromatic vertex** (an original vertex with three colours; degree 3) or a **bichromatic point** (two regions of different colours
near it; possibly a corner, where an original vertex had two tiles of one colour); `N′` may have closed components with no vertex.
**Two regions of one colour never share a closure point.** The multicolour `c(x) = {i : x ∈ closure(C_i)}` has ≤ 3 elements (S–V's
Lemma 2 is free in the cubic setting). Every piece of `N′` is an arc or segment of radius ≠ 1: Condition 5 holds, and every unit circle
meets `N′` in a locally finite set. [hand]

The facts used below, re-derived in this setting (each by perturbing into the open sets `C_i`):
- **(F1)** (Prop. 1) If `z ∈ C_i` and a connected `K ⊆ C_i` has points at distance `< 1` and `> 1` from `z`: impossible (`ω(z)` meets `K`).
- **(F2)** (Prop. 3) If `z ∈ C_i` and `|z − w| = 1`, then `i ∉ c(w)`. (Else take `w′ ∈ C_i` near `w`; `ω(w′)` passes through the
  neighbourhood of `z` inside `C_i`.)
- **(F3)** (diameter) A region `R` of colour `i` has no two points at distance 1, and `R × R` is connected, so `|x − y| < 1` for all
  `x, y ∈ R`; hence `|v − v′| ≤ 1` for `v, v′ ∈ closure(R)`.
[hand, re-derived here]

### 2.1 The object at `u`

`u` is a trichromatic vertex, `c(u) = {4, 5, 6}`, with regions `R₄, R₅, R₆`. S–V's §6–7 facts are taken as input (see §2.9): the
**pseudo-colouring** `c′(x) = c(x) ∩ {1, 2, 3}` of `ω(u)` is nonempty at every point, never `{1, 2, 3}` (Corollary 3), and divides
`ω(u)` into finitely many arcs; call a point where the arc colour changes **circle-bichromatic** and let `P` be the set of them. It is
proper in S–V's sense (Prop. 15): **mono–mono** — two points of `ω(u)` at unit distance, each interior to an arc, differ in colour;
**bi–bi** — two circle-bichromatic points at unit distance carry different pairs (Prop. 14).
- *Mono–mono follows from (F2) alone:* if `x, y` at unit distance are interior to `a`-arcs, take `x″ ∈ C_a` near `x`; `ω(x″)` crosses
  `ω(u)` transversally at a point `y′` near `y`, inside the `a`-arc, so `a ∈ c(y′)`, against (F2). [hand]
- Bi–bi (Prop. 14, through Prop. 5 and S–V's annulus) is read from print, not re-derived here.

### 2.2 Lemma H (a region of a colour of `u` that enters the disc) [hand, one mind]

**Lemma H.** Let `j ∈ {4, 5, 6}` and let `R′` be a region of colour `j` with `R′ ∩ B(u, 1) ≠ ∅`. Then `|x − y| < 1` for all `x ∈ R_j`,
`y ∈ R′`. Consequently (a) `R′ ⊆ B(u, 1)`; (b) if `v ∈ closure(R′)` then `R_j ⊆ B̄(v, 1)`.

*Proof.* If `R′ = R_j`, (F3). Otherwise `R_j × R′` is connected, `|x − y| ≠ 1` on it, and it holds a pair at distance `< 1` (take
`y₀ ∈ R′ ∩ B(u,1)` and `x₀ ∈ R_j` with `|x₀ − u| < 1 − |y₀ − u|`). (a): let `x → u`; an open set inside `B̄(u,1)` is inside `B(u,1)`.
(b): let `y → v`. ∎

**Corollary H′ (no straddling).** A region of colour `j ∈ {4, 5, 6}` lies in `B(u,1)` or in `ℝ² ∖ B̄(u,1)`. And two regions of colours in
`{4, 5, 6}`, one inside and one outside, share no closure point: such a point `z ∈ ω(u)` would put the edge between them (at a
bichromatic `z`), or the edge `e_jk` between the two sectors (at a vertex `z`), inside `B̄(u,1) ∩ closure(ℝ² ∖ B(u,1)) = ω(u)` near `z` —
an arc of radius 1 in `N′`. [hand]

### 2.3 Lemma L (points of `ω(u)` and the inward continuation) [hand, one mind]

Near any `z ∈ ω(u)`, `ω(u)` minus `z` is two arcs `J₁, J₂`, each inside one open sector at `z` (edges meet `ω(u)` in a locally finite
set); an edge from `z` is, near `z`, in the open disc or in the open exterior (one arc or segment, tangent or not). A sector of colour
in `{4,5,6}` at `z ∈ ω(u)` contains no point of `ω(u)` (pseudo-colours are nonempty), so it lies wholly inside or wholly outside.

Let `z ∈ ω(u)` be a vertex with `c(z) = {a, c, i}`, `a, c ∈ {1,2,3}`, `i ∈ {4,5,6}`. Call `z` **V-in** if its `i`-region meets
`B(u, 1)` and **V-out** otherwise. Walking round `z`: the `i`-sector is bounded by `e_ai`, `e_ci`, which lie on its side of `ω(u)`.
- **V-out and `e_ac` enters the disc** ⟹ the inside half-disc at `z` is split by `e_ac` into two edge-free parts, one containing
  points next to `J₁`, the other next to `J₂`; so `J₁ ⊆ a`, `J₂ ⊆ c` (or reversed): **`z` is circle-bichromatic**. This holds when
  `e_ac` is tangent to `ω(u)` from inside too.
- **V-in** ⟹ `e_ac` does not enter the disc: if it did, `e_ac`, `e_ai`, `e_ci` would all lie in the closed disc near `z`, the exterior
  half-disc would be one sector holding both `J₁` and `J₂`, and walking the interior half from `J₁` to `J₂` would cross `a`, `i`, `c` in
  turn — so `J₁` and `J₂` would lie in two different sectors after all. A V-in vertex **is** circle-bichromatic (`J₁ ⊆ a`, `J₂ ⊆ c`, the
  `i`-sector between them inside).
- **V-out and `e_ac` does not enter the disc** ⟹ all three edges are in the closed exterior, the inside half is one sector, `J₁, J₂` lie
  in it: `z` is **not** circle-bichromatic.

For a bichromatic `z ∈ ω(u)` on an `a|c` boundary: it is circle-bichromatic iff one branch of the boundary enters the disc and the other
does not (both inside, or both outside, leave `J₁, J₂` in one sector).

**The inward continuation** of `b ∈ P` with pseudo-pair `{a, c}`: start along the branch of the `a|c` boundary that enters the open disc
(it exists unless `b` is a V-in vertex), and follow it — through corners, and through points where it touches `ω(u)` from inside and
returns inside — until it (E1) reaches a trichromatic vertex in `B(u, 1)`; or (E2) reaches `ω(u)` and leaves the closed disc, or reaches a
vertex `v ∈ ω(u)`. The walk is finite (local finiteness) and its two sides are one `a`-region and one `c`-region throughout.
- In (E2) at a vertex `v` reached from inside along `e_ac`: `v` is V-out and circle-bichromatic, or V-in (then `e_ac` arrived tangent
  from inside). At a bichromatic exit point: circle-bichromatic by the criterion above.
- Call `b` **returning** if its continuation ends at a circle-bichromatic point `b′ ∈ P` (then the continuation of `b′` is the same curve
  `β` reversed, and `b′` is returning with partner `b`).

**Lemma E (endpoints).** If `b ∈ P` is not returning, its endpoint `p(b)` — the vertex where the continuation ends, or `b` itself when `b`
is a V-in vertex with no continuation — lies in `B(u, 1)`, or is a **V-in vertex on `ω(u)`**. Its multicolour is `{a, c, i}` with
`i ∈ {4,5,6}` (were `i ∈ {1,2,3}`, `p(b)` would be a `{1,2,3}` vertex at distance ≤ 1 from `u`, against Corollary 3). [hand]

### 2.4 Lemma R (the circle-only reduction replacing Prop. 19) [hand, one mind]

Let `(b, b′)` be a returning pair joined by `β` (an `a|c` boundary path in the closed disc).
1. `|b − b′| < 1`: both lie in the closure of the `a`-region along `β` (F3 gives `≤ 1`), and `= 1` would put two `{a,c}` circle points at
   unit distance (bi–bi).
2. Let `I` be the **minor arc** of `ω(u)` from `b` to `b′` (under 60°). `β ∪ I` bounds a region `Q` inside the convex lens
   `B̄(b,1) ∩ B̄(u,1)` (`β` lies in the closure of one region, so within 1 of `b`; so does `I`), which has `u` on its boundary; so `u ∉ Q`.
   Name the colours so that `Q` is on the `c`-side of `β`. Then `I` near `b` and near `b′` has colour `c`, and the arcs of `ω(u)` just
   beyond `b` and `b′` have colour `a` (they are on the other side of `β`, or in the `a`-sector of a V-out vertex).
3. **Separation.** For `x` in the open arc `I` and `y ∈ ω(u)` with `|x − y| = 1`: `ω(y) ∩ ω(u) = {x, σ^{±2}(x)}` and `σ^{±2}(x) ∉ I`
   (it is 120° from `x`, `I` is under 60°), so `ω(y)` crosses `I` once and puts `b`, `b′` strictly on opposite sides; this persists for all
   `y″` near `y`; so `ω(y″)` meets `β ⊆ closure(C_a) ∩ closure(C_c)`. By (F2), **`a ∉ c(y)` and `c ∉ c(y)`: the pseudo-colour of `y` is
   `{e}`**, the third colour.
4. Returning paths are disjoint (a path through a vertex would have ended there; a vertex on `ω(u)` has one edge per pair, and only
   `e_ac` enters the disc at a V-out vertex), so the arcs `I` are nested or disjoint. **Reduce:** recolour each **maximal** `I` wholly with
   its outer colour `a`. Every point of `P` on a maximal `I` (both ends included) stops being bichromatic; no bichromatic point is created;
   every surviving bichromatic point keeps its two local colours.
5. **The reduced colouring is proper** (checked on every pair `x, y` at unit distance):
   - both unchanged: inherited;
   - `x` in an open maximal arc `I₁` (now `a₁`), `y` unchanged: by 3, `y` is interior to an `e₁`-arc, `e₁ ≠ a₁`;
   - `x = b₁` an end of `I₁` (now `a₁`), `y` unchanged: were `y` interior to an `a₁`-arc, the points just beyond `b₁` (colour `a₁`) and their
     partners (just beside `y`, colour `a₁`) would violate mono–mono in the original;
   - `x ∈` open `I₁`, `y ∈` closed `I₂` (another maximal arc): by 3 applied to both, `y` and `x` have one-colour pseudo-colours, so no end of
     `I₂` lies in the open `σ^{±1}(I₁)` and no end of `I₁` in the open `σ^{∓1}(I₂)`; overlapping arcs then coincide, `I₂ = σ^{±1}(I₁)`,
     which forces `a₂ = a₁` and puts the arcs just beyond `b₁` and just beyond `b₂ = σ^{±1}(b₁)` (both colour `a₁`) at unit distance —
     against mono–mono in the original. So this case does not occur;
   - `x = b₁`, `y = b₂` ends of two maximal arcs: by 3, the side of `b₂` facing `σ^{±1}(I₁)` has colour `e₁`, and the side of `b₁` facing
     `σ^{∓1}(I₂)` has colour `e₂`. If `I₂` lies on the same side of `b₂` as `σ^{±1}(I₁)`, then `c₂ = e₁` and `c₁ = e₂`, so `a₂ = a₁` and the two
     beyond-arcs violate mono–mono as before; otherwise `a₂ = e₁ ≠ a₁`. Fine;
   - bi–bi: the bichromatic points are a subset of the original ones, with their colours.

   The reduction touches the circle colouring only; the plane colouring, and so every trichromatic point used later, is the original.

### 2.5 Selection (Prop. 17, Lemma 5, Prop. 18 on the reduced colouring)

Apply Lemma 5 to the reduced colouring, giving a proper cyclic colouring whose bichromatic points are original points of `P` that are not
returning, with their original local colours. It has `3k` bichromatic points; `k = 1` is impossible (a 120° arc of one colour holds a unit
chord); `k = 2` forces six arcs of exactly 60° in the pattern of Prop. 17, whose six points are original circle-bichromatic points with the
same half-neighbourhood colours — excluded by Prop. 17 (read from print). So `k ≥ 3` and Prop. 18 gives, for each pair, three points of
that pair pairwise more than 1 apart. By Lemma E each has an endpoint in `B(u,1)` or a V-in vertex on `ω(u)`.

**Lemma 5, re-derived** [hand]: take the shortest arc `A` of colour 1 with both neighbours 2 (length `< 60°` by mono–mono). If `σ^{±1}`
of the closed `A` holds no point interior to a 2-arc, recolour `A` to 2. Otherwise, say `σ(A)` does. Partner constraints at `σ(s)`, `σ(t)`
(`A = [s, t]`): just outside `σ(A)` is never 2, inside `σ(A)` never interior-1, and `σ(s)`, `σ(t)` are not `{1,2}`-points; so the 2-arc
`W` in `σ(A)` lies in the closed `σ(A)` and is flanked by 3 on both sides; minimality gives `W = σ(A)`. Recolouring `σ(A)` to 3 can only be
blocked from `σ²(A)` (`A` holds no interior 3), and so on round the hexagon: `σ^k(A)` has colour `k+1` flanked by `k+2` (mod 3). Then
recolour `A, σ³A → 2`, `σA, σ⁴A → 3`, `σ²A, σ⁵A → 1`: every recoloured arc takes its flanks' colour and each recoloured arc's partners are
two others of the six, now of the other two colours. Each step lowers the number of arcs. ∎ (S–V's proof, with the nesting step written out.)

**Prop. 18, re-derived** [hand]: in a cyclic proper colouring with `k ≥ 3` points of each pair, suppose two consecutive `{1,2}`-points
`u₁ < u₂` are less than 60° apart; between them lie `v` (`{2,3}`) and `w` (`{3,1}`). Partner constraints make `(σv, σw)` free of interior 3,
and if it has no `{1,2}`-point it is one colour, 1 or 2, and then `σw` (if 1) or `σv` (if 2) is a `{1,2}`-point. So the next `{1,2}`-point
after `u₂` is within 60°; by induction all consecutive gaps are under 60°, and one point from each of three alternate 60° sectors (a hexagon
avoiding the points) are pairwise more than 60° and less than 180° apart. If some gap is at least 60° — then more than 60° by bi–bi — the
gaps are all over 60° and any three consecutive points serve. ∎

### 2.6 The eleventh point

Let `R*` be the connected component of `closure(C₄ ∪ C₅ ∪ C₆)` containing `u`. Its regions are chained to `u`'s by shared closure points,
so by Corollary H′ **every region of `R*` lies in `B(u, 1)`** and `R* ⊆ B̄(u, 1)`. A vertex `q ∈ ∂R*` with two `R*`-sectors (colours
`j ≠ k` in `{4,5,6}`) and one outside sector (colour `x ∈ {1,2,3}` by maximality) has `c(q) = {x, j, k}`, and its `j`- and `k`-regions lie
in `B(u, 1)`. **Existence** of such a `q` is S–V's one sentence (Fig. 6); Voronov's Lemma 6.1 proves it from "all regions are 1-connected"
(the outer rim of `R*` cannot be one region). In the merged map of §2.0 a region can be multiply connected; if the outer rim of `R*` is one
region `R°` of a colour `j`, no such `q` exists on it. **I do not settle that case here** (see §2.8); the `d = 2` argument below needs only the
type of `q`, not its existence.

### 2.7 Theorem D2: no colliding pair of the pigeonhole is at distance 2 [hand, one mind]

The pigeonhole points: `u`; the nine endpoints `p(b)` (Lemma E); `q` of type `{x, j, k}` (§2.6). All lie in `B̄(u, 1)`, so a distance of 2
occurs only for two points of `ω(u)` antipodal about `u`. `u` is at distance ≤ 1 from the others. The `p`'s have multicolours
`{a, c, i}` (two of `{1,2,3}`, one of `{4,5,6}`), never complementary to one another or to `c(u)`; `q`'s complement `{y, z, l}` is of that form.
So the collisions are: (i) two `p`'s with one multicolour; (ii) `q` with the `p` of the complementary multicolour.

- **(i)** `p = p(b)`, `p′ = p(b′)` with `c = {a, c, i}`, antipodal on `ω(u)`. By Lemma E both are V-in vertices, so by Lemma H(b)
  `R_i ⊆ B̄(p, 1) ∩ B̄(p′, 1)`. For `|p − p′| = 2`, `|x−p|² + |x−p′|² = 2|x−u|² + 2`, so the two closed discs meet only at `u`. `R_i` is open
  and nonempty: **contradiction.**
- **(ii)** `q ∈ ω(u)` and `p = 2u − q` with `c(p) = {y, z, l}`. By §2.6 the `j`- and `k`-regions at `q` are in `B(u,1)`, so Lemma H(b)
  gives `R_j ∪ R_k ⊆ B̄(q, 1)`; `p` is V-in, so `R_l ⊆ B̄(p, 1)`. With `e = q − u`, the points `u + t·e⊥` (`t ≠ 0` small) are at squared
  distance `1 + t²` from both `q` and `p`: the open cusps between the two tangent discs at `u` meet none of `R₄, R₅, R₆` — but a small disc
  about the vertex `u`, minus its three edges, is the union of three sectors of `R₄, R₅, R₆`. **Contradiction.**

Hence the pigeonhole never hands Lemma 3 or Corollary 3 a pair at distance 2: **S–V's `d = 2` case does not arise, and no exception at
`d = 2` is needed** — on the route §§2.4–2.7, which never recolours the plane. ∎

What the theorem does **not** say: that every endpoint lies in the open disc. A selected point `b ∈ P` that is itself a V-in vertex (its
`i`-sector inside the disc, its `a|c` edge leaving outward) has no inward continuation; its endpoint is `b ∈ ω(u)`. The reduction cannot
remove it (it is circle-bichromatic and returning to nothing), and nothing in §§2.0–2.6 excludes it: its local constraints (Lemma H, and the side of `u`'s annulus at `b`) are
consistent, as the configuration shows. **Configuration for a stranger (E3):** `u = 0`, `b = (1, 0)`. At `u`: the `i`-sector is the wedge `|arg z| < 40°` (inside `B̄(b,1)`
near `u`, as Lemma H requires), the other two sectors split the rest by a third edge along `arg = 180°`. At `b`: the `i`-sector is the
wedge `150° < arg(z − b) < 210°`, pointing at `u` and inside `B(u,1)` near `b`; the `a`-sector is `210° < arg(z − b) < 360°`; the
`c`-sector is `0° < arg(z − b) < 150°`; `e_ac` is the ray `arg(z − b) = 0`, leaving the disc. `ω(u)` passes `b` along the directions
90° (in `c`) and 270° (in `a`), so `b ∈ P` is an `{a, c}`-point, V-in, with no inward continuation: its endpoint is `b ∈ ω(u)`. u's
annulus at `b` is on the outer side (two of `u`'s edges, at ±40°, lie within 90° of the direction 0°), as it must be since the inner side
at `b` has colour `i`. Being globally impossible (if Corollary 1 a.e. holds, every
configuration is), it cannot be a counterexample; it is the local configuration an argument for "every endpoint in the open disc" must
exclude, and I have none.

### 2.8 Other seams met on the way (outside the claim; for the owner)

1. **`d = 1`, same multicolour.** Two endpoints `p(b), p(b′)` with one multicolour come from `b, b′` of one pair more than 1 apart; the
   `a`-regions along their paths differ (F3) and have all cross-distances `> 1` (connectedness, as in Voronov's Lemma 6.1), so
   `|p − p′| ≥ 1`. Lemma 3 needs `> 1`. At `|p − p′| = 1` exactly, the `a`- and `c`-sectors at both ends face away from each other and the
   `i`-sectors face each other; whether `ω(p′)` enters the `i`-sector at `p` is a comparison of curvatures of `e_ai`, `e_ci` with 1 — a
   tangency case this job does not settle.
2. **The eleventh point in a multiply connected merged map** (§2.6): if the outer rim of `R*` is one region `R°` of colour `j`, S–V's
   sentence gives no point, and Voronov's proof uses simple connectivity. In setting (A) merged regions can be multiply connected (a ring of
   same-coloured tiles). Not settled here.
3. **Prop. 19 as printed** recolours the plane; its trichromatic points belong to the recoloured colouring, while Lemma 3 and Corollary 3 are
   applied to the original. Lemma R is the circle-only replacement; the print's `d = 2` gap is independent of that and closed by Theorem D2.

### 2.9 What the argument uses from the print

| item | used for | status here |
|---|---|---|
| Props. 1–3 | (F1)–(F3) | **re-derived** in the a.e. setting (§2.0) |
| Lemma 2 (no 4-chromatic point) | multicolours ≤ 3 | **free** in the cubic merged map (§2.0) |
| Props. 9–11, Cor. 2 (the annulus) | pseudo-colours nonempty, finitely many arcs | read; a.e. form not re-derived (Prop. 2 a.e. is (F1)) |
| Corollary 3 (disjoint, `d < 2`) | `{1,2,3}` excluded on `ω(u)` and at endpoints; collisions (ii) at `d < 2` | read; a.e. form sketched: the two annular curves cross when `d < 2` and a crossing point is in the closure of no colour |
| Lemma 3 (same, `1 < d < 2`) | collisions (i) at `1 < d < 2` | read; **not** re-derived |
| Props. 14–15 (pseudo-colouring proper) | input to Lemma R, Lemma 5, Prop. 18 | mono–mono **re-derived** from (F2); bi–bi (Prop. 14, via Prop. 5) read, not re-derived |
| Prop. 17 (no six-arc hexagon) | `k ≥ 3` | read; not re-derived |
| Lemma 5 | cyclic form | **re-derived** (§2.5); needed |
| Prop. 18 | three points per pair | **re-derived** (§2.5, Voronov's Prop. 3.3 route); needed |
| Prop. 19 | — | **not used**; replaced by Lemma R |
| Lemma 4's pigeonhole count | the ten classes and the collisions | re-derived (§2.7) |
| the eleventh point (Fig. 6) | existence of `q` | read; **not settled** in multiply connected merged maps (§2.8 item 2) |

### 2.10 Exact checks (`tools/fs110_cd_checks.py`, output `data/fs110/fs110-cd/checks.out`; seconds; formula-given objects only)

| check | what it confirms | planted fault, and why it fires |
|---|---|---|
| A1 | two closed unit discs with centres 2 apart meet only at the midpoint (the identity `|x−p|²+|x−p′|² = 2|x−u|² + |p−p′|²/2`, sympy) | centres 1.9 apart: the common point `(0, t)`, `t² = 1 − 0.9025`, exists — fires |
| A2 | the cusp points `u + t·e⊥` are at squared distance `1 + t²` from `q` and `2u − q` | — (a polynomial identity) |
| A3 | Lemma R step 3: `ω(σ^{±1}x)` puts `b`, `b′` (at −25°/+20°, and −59°/+1° about `x`) strictly on opposite sides; exact in `ℚ(√3)` | partner at 40° instead of 60°: no separation — fires |
| A4 | the (E3) configuration of §2.7 meets its stated local constraints | an `i`-wedge of half-angle 100° at `u` violates Lemma H's cone condition — fires for that reason |
| B | properness (mono–mono, bi–bi) of rational-degree circle colourings; Prop. 18 on the cyclic 9-, 12-, 30-arc colourings; Prop. 18 fails on six arcs; Lemma 5's simple recolouring (a 2° arc inserted at 50°) and its six-arc chain (six 2° arcs at 70° + 60°k in the six-arc base, which Lemma 5 takes back to the six-arc hexagon — the case Prop. 17 excludes) | an arc inserted at 59° is improper for the mono–mono reason; unequal chain lengths (one 2.5° arc) are improper for the mono–mono reason — the derived "the chain arcs have equal length" step — both fire |

*Harness defects found by the first run and fixed (logged as tool defects, not derivation errors):* the uniform 15-arc cyclic colouring was
listed as a positive control, but it is improper (a 60° turn is 2.5 arcs, landing half of each arc on an arc of its own colour) — it is now
a negative control; and the arc-length guard rejected arcs of exactly 60°, though an open 60° arc holds no unit chord (the six-arc hexagon
is proper as a circle colouring; Prop. 17 is what excludes it).

## Stage 3 — SAVED

*Verdicts, committed before anything fenced is opened. First, the self-audit of stage 2 (the result is the flattering one; G21).*

### 3.0 Audit of stage 2

1. **Lemma R step 2, tightened.** Stage 2 argued "the arcs just beyond `b` and `b′` both have colour `a`, the arcs on the `I`-side both
   `c`" through a region `Q` bounded by `β ∪ I`. If `β` touches `ω(u)` from inside, `β ∪ I` is not a simple closed curve. The repair: push
   `β` off `ω(u)` into the open disc near each touch point (a homotopy fixing a neighbourhood of `b` and `b′`). The pushed path `β′` meets
   `ω(u)` only at `b, b′`, so `β′ ∪ I` is a Jordan curve with interior `Q′` lying on one fixed side of `β′` along its whole length. Near `b`
   (and near `b′`) the disc is cut by `β′` into the part next to the `I`-side arc, which is `Q′`, and the part next to the beyond-arc. Since
   `β′ = β` near the ends and the regions on the two sides of `β` are one `a`-region and one `c`-region throughout, the `I`-side arcs at
   both ends lie in the region on the `Q′`-side, and the beyond-arcs in the other. The claim stands; `u ∉ Q` is not needed anywhere.
   [hand]
2. **Lemma R step 5, the case `x ∈` open `I₁`, `y ∈` closed `I₂`, re-walked:** by step 3 the set `σ(I₁) ∪ σ⁻¹(I₁)` of partners holds only
   points with one-colour pseudo-colours, so it holds no end of `I₂`, and symmetrically. Two open arcs each under 60° that meet, with no end
   of either strictly inside the other, are equal. Then `I₂ = σ^{±1}(I₁)`, every point of it has pseudo-colour `{e₁}`, so `c₂ = e₁`, and
   symmetrically `c₁ = e₂`; hence `a₂ = a₁`, and the beyond-arcs at `b₁` and at `σ^{±1}(b₁)` are both interior `a₁` at unit distance —
   excluded by mono–mono. Holds.
3. **Endpoint types, re-walked (Lemma E):** an endpoint on `ω(u)` arises only (E3) as a selected V-in vertex, or at the end of a
   continuation arriving at a vertex of `ω(u)` from inside — V-out ones are circle-bichromatic and make `b` returning; V-in ones are
   endpoints. A continuation cannot arrive at an (E3) vertex (there `e_ac` does not enter the disc), so endpoints of distinct selected
   points are distinct. A third colour in `{1,2,3}` at any endpoint meets Corollary 3 at distance ≤ 1. Holds.
4. **Theorem D2 uses no genericity** (no appeal to which side of `ω(u)` the annulus lies on at `p` or `q`); both cases close by Lemma H and a
   two-disc identity checked exactly (A1, A2). Holds.
5. **The stranger's configuration (E3)** is checked exactly for its stated local constraints (A4). It is not claimed to extend to a
   6-colouring of the plane; it names the step a strict-interiority argument must cover.

### 3.1 Verdicts

| # | claim | verdict | minds | grade |
|---|---|---|---|---|
| 1a | S–V's `d = 2` case (two colliding pigeonhole points antipodal on `ω(u)`, same or disjoint multicolours) never arises; **no exception at `d = 2` is needed** in Corollary 1 a.e. for curved cubic maps under Condition 5 | **TRUE** — Theorem D2 (§2.7) | one (this job) | [hand]; its two geometric identities [tools] (A1, A2) |
| 1b | Prop. 19's recolouring of the plane can be replaced by a reduction on the circle only, leaving the plane colouring (and so every pigeonhole point) original | **TRUE** — Lemma R (§2.4, tightened §3.0.1) | one | [hand] |
| 1c | CB's sub-claim as the brief quotes it: after the circle-only reduction "every pigeonhole endpoint lies in the open disc" | **GAP at (E3)** in my derivation: a selected circle point that is itself a V-in vertex (third-colour sector inside the disc, its `a|c` edge leaving outward) is its own endpoint, on `ω(u)`; also a continuation arriving tangentially at a V-in vertex of `ω(u)`. No circle-only reduction I can derive removes them (they are circle-bichromatic and return to nothing). Not FALSE: if Corollary 1 a.e. holds, no configuration is a counterexample; the stranger's configuration is §2.7's. **It does not matter for 1a**: Lemma H kills every antipodal collision that involves such points | one | [hand] |
| 1d | S–V Corollary 1 a.e. as a whole (curved cubic maps, Condition 5, six colours, tiles' interiors) | **not settled here: GAP** at two steps outside the brief's claim — (i) same multicolour at `d = 1` exactly (Lemma 3 needs `d > 1`; §2.8.1), (ii) the eleventh point when the outer rim of `R*` is one multiply connected region (§2.8.2) — and resting on inputs read but not re-derived in the a.e. form (Lemma 3, Prop. 14, Prop. 17, the annulus) | one | — |
| 2a | Lemma 5 (cyclic recolouring of a proper 3-coloured circle; no new bichromatic points) | **needed; TRUE**, re-derived (§2.5) with the nesting step written out; checked on two formula-given colourings (B) | one (+ print) | [hand] |
| 2b | Prop. 18 (≥ 9 bichromatic points in a cyclic proper colouring ⟹ three of each pair pairwise more than 1 apart) | **needed; TRUE**, re-derived by Voronov's Prop. 3.3 route (§2.5); checked on the 9-, 12-, 30-arc colourings and shown false on six arcs (B) | one (+ print) | [hand] |
| 2c | Prop. 19 | **not needed** (replaced by Lemma R); as printed it recolours the plane, so its trichromatic points are the recoloured colouring's | — | — |
| 2d | the rest of the print used | per §2.9's table: Props. 1–3 and mono–mono re-derived; Lemma 2 free in the cubic setting; Corollary 3 a.e. sketched; Lemma 3, Prop. 14, Prop. 17, Props. 9–11 read, not re-derived | — | — |

**Printed slips logged (MISSTATED in print, no consequence found):** Prop. 18 and Prop. 19 list the pair `{1, 3}` twice (for `{3, 1}`,
`{1, 2}`, …); the appendix's eleventh point speaks of "regions of colors 1, 2, 3 whose vertex is u" where `u`'s colours are 4, 5, 6;
Voronov's Prop. 3.3 proof ends "pairwise distances between which are equal to 1" for "greater than 1".

**Registered expectation, scored:** expected TRUE on "no `d = 2` exception" by a region lemma rather than by strict interiority, and GAP on
strict interiority at a selected V-in vertex — **met on both counts**. The reachable other outcome (an antipodal colliding pair outside
every lemma; or an improper reduced circle) did not occur.

## Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| Setting (A) reduces to a merged map with (F1)–(F3); Lemma 2 is free for cubic maps | [hand] | §2.0 |
| Pseudo-colouring mono–mono from (F2) alone | [hand] | §2.1 |
| Lemma H (a region of a colour of `u` entering `B(u,1)` forces `R_j ⊆ B̄(v,1)` for every `v` in its closure) and Corollary H′ (no straddling of `ω(u)`) | [hand] | §2.2 |
| Lemma L (points of `ω(u)`: V-in / V-out, the circle-bichromatic criterion, the inward continuation) | [hand] | §2.3 |
| Lemma E (non-returning endpoints lie in `B(u,1)` or are V-in vertices of `ω(u)`) | [hand] | §2.3, §3.0.3 |
| Lemma R (circle-only replacement for Prop. 19; the reduced colouring is proper; no plane recolouring) | [hand] | §2.4, §3.0.1–2 |
| Lemma 5 and Prop. 18, re-derived | [hand]; examples [tools] | §2.5, §2.10 |
| `R* ⊆ B̄(u,1)` with all its regions in `B(u,1)`; the eleventh point's type | [hand] | §2.6 |
| **Theorem D2: no colliding pigeonhole pair at distance 2** | [hand]; identities [tools] | §2.7 |
| Exact checks A1–A4, B with fired plants | [tools] | `tools/fs110_cd_checks.py`, `data/fs110/fs110-cd/checks.out` |

### Would-have-searched log

| move I would have made by search | what I did instead |
|---|---|
| a colouring solver asked for a local configuration with a selected circle point on `ω(u)` whose endpoint cannot be moved inside | wrote the (E3) configuration by hand (§2.7) and checked its local constraints exactly (A4) |
| a sweep of circle colourings to test Lemma 5 and Prop. 18 | re-derived both by hand (§2.5) and checked them on five colourings given by formula (B) |
