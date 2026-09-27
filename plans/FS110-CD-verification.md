# FS110-CD — blind verification: Sokolov–Voronov Corollary 1 almost everywhere, no `d = 2` exception

*Job FS110-CD (Coxeter, verifier, blind), Opus 5.5, 2026-09-27. Brief: `data/fs110/briefs/CD110-reduction-blind.md` with
`data/fs110/briefs/STANDING-RULES.md`. Blind: nothing fenced opened before stage 3 is committed. Working directory for scratch:
the harness scratchpad `fs110-cd/` (own files only); committed working files: `data/fs110/fs110-cd/`.*

## Theorems this phase proved

*(filled at stage 3)*

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

### Would-have-searched log

| move I would have made by search | what I did instead |
|---|---|
| none yet | — |
