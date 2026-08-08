# M23 — The pivot triangle and the metapivot system (SUBPLAN)

*Pre-subplan compiled 2026-08-08 at M22 close (tangent results, branch mining).
Subplan pass 2026-08-08: §0 registrations written BEFORE the censuses ran (order
auditable in this file's own structure — predictions in §0.1/§0.2 precede results in
§0.3); the deep-dive's hand-derived exact structure is §2b; the skeleton map is §4;
scope decisions in §7. Skeleton: `Proofs/HadwigerNelson/Triangle.lean`.*

## 0. Registrations

### 0.1 Subplan-time censuses — predictions registered before running

These three are EXACT enumerations (no statistics, so no p-hacking surface), but the
discipline is kept anyway: predictions written first, then the scripts run, results in
§0.3. Scripts in scratch; promotion to `tools/couple.py` happens at implementation.

**A. The 8-circle glue inventory** (4 centres 0, 1, ζ₆, m = (1+ζ₆)/3; radii 1 and
1/√3 each; all 24 proper circle pairs, exact `frac_c` arithmetic). Predictions:

* A1. No tangency anywhere: all 24 pairs strictly inside the annulus (hand-checked:
  pivot pairs d² = 1, pivot–meta d² = 1/3, against (r₁±r₂)² ∈ {0, 4, 4/3, (1±1/√3)²}).
* A2. **37 distinct intersection points**, decomposed: 3 pivots + 1 centroid +
  3 mirror apexes (oo− of pivot pairs) + 3 down-centroids (ii− of pivot pairs) +
  12 pivot-pair seam points (oi/io ±) + 6 pivot–meta oo + 6 rot3-partners
  (= pivot-meta io) + 3 pivot–meta ii new points ((0, √3/3)-type).
* A3. **Seven points lie on ≥ 3 circles** (the incidence spine): each pivot on
  {outer of both other pivots, inner(m)} — so outer(pᵢ) ∩ inner(m) = the other two
  pivots, NO new points; the centroid on all three pivot inners; each down-centroid
  on two pivot inners AND inner(m). Everything else on exactly 2 circles.
* A4. **Field closure**: every coordinate lies in ℚ(√3, √11, √33) — the SEAM field.
  The pivot–meta oo points carry √33 (hand-computed sample: 3m·seamRatio =
  (1/4 − √33/12, √11/4 + √3/12)); pivot-pair oi/io carry √11; the rest ℚ(√3). The
  triangle + metapivot object does NOT grow the field. (The M24+ recursion would.)

**B. The loop census** (words over generators {R_p^±1, S_p^±1} for p ∈ {0, 1, ζ₆, m};
R = ζ₆-rotation about p (= `hexStep p`), S = σ-rotation about p; exact affine maps
z ↦ ζ₆^aσ^b z + t, closure ⟺ (a ≡ 0 mod 6) ∧ b = 0 ∧ t = 0; cyclically reduced words,
bounded length). Predictions:

* B1. Every closed word has σ-exponent exactly 0 (theorem-backed: ζ₆^aσ^b = 1 with
  b ≠ 0 would give σ^{6b} = 1 against the seam's infinite order). The census's real
  content is the TRANSLATION lattice.
* B2. Minimal nontrivial closed pure-hex loops at **length 6**: (R₀R₁)³ (= the
  rot3-about-centroid identity cubed) and (R₀R₁R₂)² (= the edge-midpoint flip squared).
* B3. Minimal closed loops using seam generators from ≥ 2 pivots at **length 6**:
  the seam hexagon S₀S₁⁻¹S₂S₀⁻¹S₁S₂⁻¹ (length-2 subwords SᵢSⱼ⁻¹ are translations
  τᵢⱼ = (1−σ)(pᵢ−pⱼ); the three pivot differences sum to 0). Cyclic constraint flow
  A→B→C→A in its purest algebraic form — exists at the triangle, impossible at the
  pair (τ₀₁ alone never cancels).
* B4. No closed word with R_m-content ≢ 0 mod 6 unless matched by pivot-R content:
  specifically R_m ∉ ⟨R₀,R₁,R₂,S·⟩ at any probed length (wallpaper argument: m is a
  3-fold centre of the hex group p6 — its site symmetry is C₃, so 60° about m would
  extend the group; R_m² = R₀R₁ IS inside). Census confirms at bounded length; the
  wallpaper argument stays a `--` note, not a formalization target.
* B5 (exploratory, no prediction): the S_m translation lattice ((1−σ)·(m−pᵢ)-vectors,
  denominators 3) vs the pivot τ lattice — census maps their intersection.

**C. The matched-pair chord-family audit** (re-run of the §3.2 object build with FULL
endpoint labels, against the §2b classifications). Predictions:

* C1. **Zero oo sporadics.** The pre-subplan's "(2,±2)o, (4,±2)o" sporadic labels are
  mislabeled or denote mixed-circle chords: the oo factorization (§2b.5) proves every
  outer–outer cross chord is matching or hub — no third family exists. If the census
  shows a genuine non-matching non-hub oo chord, the factorization is WRONG (sympy
  re-check is part of this census).
* C2. The 8 sporadics with chord vector (−1/2, ±√3/2)-type are **ii chords on the
  Möbius branch** (they satisfy x(3y−2) = y at the (0,1) anchor); the 4 with
  (−5/6, ±√11/6)-type are oi/io (the quadratic family = iterated gluing).
* C3. sympy symbolic verification of both factorization identities (§2b.5, §2b.6)
  under ūu = v̄v = 1: exact zero.

### 0.2 Statistical registrations — protocols and effect sizes fixed NOW, run at implementation

1. **Triangle joint census** (`--joint` extended to triples). Population: pivot
   triples in the de Grey closure pairwise at unit distance (fallback if none exist
   at sufficient count: synthetic triangle ambient = the depth-capped 8-circle
   lattice). Prediction: cyclic kill fraction at unit triangles EXCEEDS the
   independence composition of M21's pair rates by ≥ 10 points on matched pattern
   samples. Null control: three mutually far pivots — flat at independence. Every
   kill re-verified through the independent pin-only injection encoding (M21
   protocol).
2. **Metapivot floor**: `minCov`/forbid-last-t on the union of all four systems'
   cover sets (three pivots + centroid). Prediction (honest null): the floor stays
   3 — the rainbow floor has held at all 6,173 pivots ever examined; a 4 here is a
   major finding and gets the full verification battery before being believed.
3. **Seam-alignment replication at fresh pairs** (M22 §6.4's post-hoc, now
   registered): protocol EXACTLY the M22 decomposition + ≥ 20-decoy specificity
   sweep, at ≥ 4 NEVER-EXAMINED far pairs. Prediction: seam-lattice concentration
   ≥ +8 pts over matched-composition controls at ≥ 3 of 4 pairs AND half-offset
   depletion ≤ −8 pts at ≥ 3 of 4; true-lattice decoy rank ≤ 3/21 at each
   replicating pair. Failure to replicate = the M22 reading is demoted to
   single-pair anecdote, stated so in the Frontier.
4. **Ladder-coset census of kill cores**: for each kill core, the (a,b)-coset
   relations of pin pairs about the pinned pivot (exact, `--ladder` addressing).
   Prediction: co-ladder pin pairs overrepresented ≥ 2× vs matched random pin sets
   drawn from the same pin pool. (Independent of #3; runs regardless.)
5. **Branch re-validation** (before any use of the numbers): (a) the bi-sector
   cell-graph 4-UNSAT claims re-derived through OUR forcer at widths 60°→5° —
   UNSAT side only (the 5-SAT side is worthless as evidence under the exact-math
   stance); prediction: replicates at every width. (b) free-partner closure
   density-falls (2.52 vs 2.98 edges/point) re-derived with our `--partner`;
   prediction: replicates within ±0.1.
6. **Colour closure at the gap distance** d = |ζ₆σ⁹ − 1| — GATED behind triangle
   budget (unchanged from the pre-subplan; the clamp spec from the kill census is
   the starting design if opened).

### 0.3 Census results (appended after the runs; predictions above were written to file first)

**A** (`m23_inventory.py`): A1 **confirmed** — zero tangency/empty cases, all 24
pairs strictly two-point. A2 **refuted in the interesting direction**: **34**
distinct points, not 37 — the three points I predicted as "new" pivot–meta ii glue
points are the **mirror centroids** (adjacent-triangle centroids): inner(pᵢ) ∩
inner(m) = {the centroid's reflections across the two edges at pᵢ} — a THIRD
no-new-points coupling. The metapivot couplings create new points ONLY at
outer∩outer (6 points, the √33 family). A3 count **confirmed**: exactly 7 points
on ≥ 3 circles — the 3 pivots (each on the other two outers + inner(m)), the
centroid (all three pivot inners), the 3 mirror centroids (two pivot inners +
inner(m)); all 27 others on exactly 2. A4 **confirmed**: every coordinate in
ℚ(√3,√11,√33) — 2 rational points, 14 in ℚ(√3), 4 pure-√11, 14 √33-bearing. The
2b.3/2b.4 identities verified exactly at all three pivots; negative control fired.

**B** (`m23_loops2.py`; v1 had a BFS dedup bug — state-only dedup blocked closing
steps — fixed to (state, last-letter) dedup): B1 theorem-backed (closure forces
σ-exponent 0). B2 **refuted**: minimal pure-hex relations at length **4** (18
words, the parallelogram family R₀R₁′R₂′R₁ — hex-commensurability lets
translations from different pivot pairs cancel pairwise); (R₀R₁)³ and (R₀R₁R₂)²
are relations but not minimal. B3 **confirmed**: minimal pure-seam relation
length **6**, the twelve minimal words are EXACTLY the registered seam-hexagon
family S₀S₁′S₂S₀′S₁S₂′ and its images, and every one uses all three pivots — so
within length ≤ 6 the PAIR has no pure-seam relation at all: seam loops require
the triangle, hex loops do not. The sharpest algebraic form yet of "the third
pivot buys closed constraint flow". B4 **confirmed**: R_m (60° about the
metapivot) unreachable from pivot generators through length 6 (130k states;
wallpaper reading: m is a 3-fold centre of p6 — R_m² = R₀R₁ is inside, R_m is
not). B5: same-pivot R/S commutators appear at length 4 (rotations about one
point commute), nothing else new below length 6.

**C** (`m23_chords.py`): C1 **confirmed** — ZERO outer–outer sporadics; the
pre-subplan's "(2,±2)o/(4,±2)o" labels were the o-side endpoints of mixed
chords. C2 composition corrected: **4** sporadics on the ii Möbius branch
(x(3y−2) = y verified exactly) + **8** mixed oi/io (iterated gluing), **0
unexplained** — the §2b classifications fully account for the sporadic census.
C3 **confirmed**: sympy verifies both factorization identities and the Möbius
anchor form symbolically (exact zero / unit ratio).

*Consequences folded into §4: the third no-new-points coupling (group 4), the
seam-hexagon loop as a Lean statement, the hex parallelogram as the minimal hex
relation, and the one-operator `rotAbout` unification (group 7).*

## 1. What M22 handed this milestone

* **The general gluing classification is certified** (`Glue.sphere_inter_sphere`):
  distinct centres + annulus condition → intersection = {gluePoint, reflAxis mirror};
  empty cases both ways; unit-axis bridge `reflAxis_eq_reflAcross`. The metapivot's
  axis-1/√3 coupling is already a proven spec example.
* **`Coupled` public classifications** (the four unit-axis gluings, general in the
  unit pair): `outer_inter_outer`, `outer_inter_inner`, `inner_inter_outer`,
  `inner_inter_inner`, plus the `reflAcross` package. (`inter_eq_pair` itself is
  private — M23 consumes the four public faces.)
* **The first certified near-relation**: ζ₆σ⁹ within chord 1/50 of 1 and provably
  ≠ 1. Geometric closure through σ is dead at any number of pivots; colour closure
  is the live thread.
* **The kill mechanism named** (tools-side): outer-circle constraints necessary in
  100% of probed ambient kills, inner in 75%; cores 4–8 pins median 6; seam-lattice
  alignment post-hoc at one pair (now registered as §0.2.3).
* **Depth is dead**: k = 4 SAT through two partner generations; 67–70% partner
  collision; 76% of adjunction instances field-free. Structure, not iteration.

## 2. The object

Three pivots pairwise at distance 1 — anchored at 0, 1, ζ₆ (coupling directions 1,
ζ₆, ζ₃: hex-commensurate, so exact closed loops exist that the pair provably lacks).
The centroid m = (1+ζ₆)/3 = ⟨1/2, √3/6⟩ is at 1/√3 from all three pivots — the first
triple glue point — and is itself the centre of the fourth two-circle system (the
**metapivot**): its inner circle passes through the three pivots, its outer through
the six 120°-partners rot3^{±1}(m about pᵢ). Full object: **8 circles, 4 centres**,
dihedral symmetry. The 26-circle recursion stays M24+ (§7).

### 2b. Derived exact structure (subplan deep-dive, 2026-08-08 — each hand-verified numerically; the skeleton states them, implementation proves them)

1. **The hex step permutes the pivots cyclically**: hexStep 0 1 = ζ₆,
   hexStep 1 ζ₆ = 0, hexStep ζ₆ 0 = 1. So each pivot IS the (+)-branch oo glue
   point of the other two: the triangle is *self-glued* — `outer_inter_outer` at
   each pair = {third pivot, mirror apex}.
2. **The centroid is the (+)-branch ii glue point of all three pairs at once**:
   p + innerGlueRatio·(q−p) = m for all three ordered pairs (0,1), (1,ζ₆), (ζ₆,0).
   (`Coupled.innerGlueRatio` = ⟨1/2, √3/6⟩ IS the centroid at the (0,1) anchor.)
3. **outer(pᵢ) ∩ inner(m) = the other two pivots** — the metapivot's inner circle
   glues each pivot's outer circle exactly at the remaining pivots; this coupling
   creates NO new points. (Two candidate points on a 2-point intersection, both
   pinned by known memberships.)
4. **inner(pᵢ) ∩ outer(m) = the two rot3-partners of m about pᵢ** — same mechanism:
   rot3 pᵢ m and rot3²  pᵢ m are on inner(pᵢ) (rot3 preserves spheres about pᵢ) and
   at distance 1 from m (`rot3_unit_triangle` at dist² = 1/3), and the intersection
   has exactly two points.
5. **The outer–outer chord rigidity** (NEW, the pair's cross-web classified): for
   x ∈ sphere p 1, y ∈ sphere q 1, dist p q = 1:
   dist x y = 1 ⟺ y = x + (q−p) ∨ x = q ∨ y = p.
   Proof shape: with unit frames u, v the condition |u + v − 1| = 1 factors as
   (u+v)(u−1)(v−1) = 0 — pure algebra, no irrationality. Consequences: the
   unit-translation perfect matching is COMPLETE on outer–outer (every non-hub oo
   cross chord is a translate pair — for the full uncountable circles, not just
   ladders); a generic outer point's partners on the partner's outer circle are
   exactly {its translate, the far pivot}.
6. **The inner–inner Möbius classification** (NEW): for x ∈ sphere 0 (1/√3),
   y ∈ sphere 1 (1/√3): dist x y = 1 ⟺ y = x + 1 ∨ x(3y − 2) = y.
   (General (p,q) form by the affine transport z ↦ p + z(q−p); the relation is
   conj-free.) The ii foreign web is the graph of a Möbius map — rational over the
   base field, NO √disc adjunction. Verified numerically to 4 decimals at a random
   angle, and on the collinear pair x = √3/3, y = 1 + √3/3.
7. **Field growth is localized to mixed-radius chords**: oi/io cross chords are
   `sphere x 1 ∩ sphere q (1/√3)` — iterated `sphere_inter_sphere` instances whose
   gluing discriminant adjoins √disc; oo and ii chords (5, 6) are rigid/rational.
   The partner-adjunction field-growth mechanism of M22 is EXACTLY the mixed-radius
   web, nothing else. (Explains why 2 of every outer probe's ≤ 4 partners are
   always lattice: translate + pivot.)
8. **Loop identities** (each a one-line `ring`-fact once stated; census B maps the
   full lattice): 1 − ζ₆ = ζ₆⁻¹ = conj ζ₆, hence
   R_{ζ₆}(z) = R₀(z) + 1 (the matching translation is a two-pivot hex word),
   R₀(R₁(z)) = rot3 m z (the metapivot's triangle operator is generated by two
   pivot hex steps — 1/(1−ζ₃) = m), and R₀(R₁(R_{ζ₆}(z))) = ζ₆ − z (the triple
   word is the point-flip through the 0–ζ₆ edge midpoint).
9. **No tangency in the whole object** (annulus strict everywhere — §0.1 A1), so
   every classification instance is a genuine 2-point set.

## 3. The tangent's results (2026-08-08, recorded at pre-subplan; unchanged)

### 3.1 Ladder theory of the pair (exact; the `--ladder` instrument formalizes it)

* Components ("ladders") are angle-cosets: address lattice a·60° + b·θσ; two parity
  tubes each. Ladders of one system interact only through the pivot hub.
* **The pair shares exactly ten points**: two pivots + eight glue points
  (oo (1/2,±√3/2); oi (1/6,±√11/6); io (5/6,±√11/6); ii (1/2,±√3/6)).
* **Eight of the ten lie in the single natural ladder pair** — addresses (±1,0),
  (0,±1), (3,∓2), pivots (0,0), all tube 0; io glue angle identity 180° − 2θσ.
* **The ii pair at ±30° is in NO pivot ladder** (30 = a·60 + b·θσ has no integer
  solution) — and (1/2, √3/6) IS the metapivot: the fourth system sits exactly in
  the pair's blind spot.
* **The natural ladder pair carries the unit-translation perfect matching**
  (z ↦ z + (q−p) maps P-circles to Q-circles, address map (a,b) ↦ (a+3,b)) **plus
  exactly 12 sporadic cross chords** (census exact to |b| ≤ 10, all within |b| ≤ 2;
  §0.1 C audits their family labels against the new classifications).
* **The wider web**: up to four unit-partners per point; exactly one is always the
  translate — and (§2b.7) a second is always the far pivot on oo; the √disc
  adjunction lives in oi/io only.

### 3.2 The matched pair is 4-exact (tools-side, decided 2026-08-08)

χ of the FULL infinite matched ladder pair (both natural ladders + matching + 12
sporadics + 6 fusions + both pivots with entire hub reach) = **4 exactly**:
k = 3 UNSAT (contains M20's nine-point forcing, control fired); period-1 bulk
colouring verified independent of the solver (P-outer [2,1,2,1,2,1], P-inner
[3,3,1,2,0,0], Q-outer [3,1,3,1,3,1], Q-inner [1,3,2,2,0,0], pivots 3/2; saved
`build/m23-ladderpair-pattern.json`); defect splice SAT with 144 pinned boundary
vertices. Reading: the maximally-linked exact two-ladder core cannot force a 5th
colour — the M21/M22 pressure lives in the foreign (mixed-radius, §2b.7) web or
needs the third pivot.

### 3.3 The broadcast framing (working metaphor)

A pivot's colour is forbidden on its entire outer circle at once (never its own
inner). One pivot: free, χ = 4. Two: interference through the cross-web — real
pressure, no contradiction. Three + metapivot: broadcasts form a CYCLE (B3's seam
hexagon is its algebraic skeleton), and the metapivot's outer circle reaches all
three pivots' inner circles — the region their own pivots cannot touch. M23's
question: can a closed broadcast cycle, riding the exact loops, be made too
expensive for 5 colours somewhere finite? (de Bruijn–Erdős: any χ ≥ 5 verdict has
a finite witness; the loops say where to look.)

## 4. The Lean skeleton (`Proofs/HadwigerNelson/Triangle.lean`)

Imports `Proofs.HadwigerNelson.Glue` (which carries Compulsion → TwoCircle,
ClassGeometry, Coupled chain). Namespace `HadwigerNelson.Triangle`. Obligation
groups (statements in full in the skeleton; every leaf `sorry`):

1. **The anchor** — `centroid : ℂ := ⟨1/2, √3/6⟩`; dist facts: three pivot pair
   distances = 1, three pivot–centroid distances = √3/3 (+ `centroid =
   Coupled.innerGlueRatio` as a spec `example := rfl`).
2. **The self-gluing cycle** (§2b.1): three `hexStep` permutation identities; the
   three oo classifications instantiated (corollary form: `sphere 0 1 ∩ sphere 1 1 =
   {ζ₆, mirror}` etc. — one stated fully, others as the permutation makes cheap).
3. **The centroid as triple glue point** (§2b.2): three ratio identities
   `p + innerGlueRatio·(q−p) = centroid`; corollary: centroid ∈ all three pivot
   inner circles.
4. **The no-new-points couplings** (§2b.3, 2b.4, and §0.3-A's third):
   `sphere (0:ℂ) 1 ∩ sphere centroid (√3/3) = {1, ζ₆}`,
   `sphere (0:ℂ) (√3/3) ∩ sphere centroid 1 = {rot3 0 centroid, rot3 0 (rot3 0 centroid)}`,
   and `sphere (0:ℂ) (√3/3) ∩ sphere centroid (√3/3) =
   {reflAcross 0 1 centroid, reflAcross 0 zeta6 centroid}` (the mirror centroids)
   (representative instances at pivot 0; the other pivots by the same proof shape —
   domain pass decides whether symmetry transport earns machinery or three copies
   are cheaper).
5. **The ten-point sharing theorem** (the tangent's count as a kernel object):
   `system p ∩ system q` = the explicit ten-element set, general in the unit pair;
   plus `Set.ncard … = 10` at the (0,1) anchor (distinctness by coordinate bounds).
6. **The chord classifications** (§2b.5, 2b.6 — the milestone's new named
   structure): `unit_chord_outer_outer` (general unit pair),
   `unit_chord_inner_inner` (at the (0,1) anchor; general form only if the proof
   makes it free), corollary `outer_partner_pair`: for x on outer(p), x ≠ q:
   `sphere q 1 ∩ sphere x 1 = {x + (q−p), p}`.
7. **The loop identities** (§2b.8 + §0.3-B): the one-operator unification
   `rotAbout (u p z : ℂ) := p + u·(z−p)` (hexStep, seamImage, rot3 are all
   instances — spec examples pin each); `one_sub_zeta6`; the matching-translation
   word, the rot3-centroid word, the triple-word flip; the **hex parallelogram**
   (the census's minimal hex relation, length 4); the **seam hexagon**
   S₀S₁′S₂S₀′S₁S₂′ = id (the census's minimal seam relation — the certified
   closed constraint cycle that needs all three pivots); the algebraic backbone
   `zeta6 ^ a * seam ^ b = 1 ↔ 6 ∣ a ∧ b = 0` (ℤ exponents; the census-B1 fact
   as a theorem).
8. **Spec set**: non-vacuity examples (concrete memberships), the adversarial
   member ((−1 : ℂ) ∉ system 0 ∩ system 1 — on outer(0), distance 2 from 1), a
   Möbius-branch concrete chord (x = √3/3, y = 1 + √3/3), a hub-branch chord, and
   the ten-point set's sample membership.

NOT in the skeleton: pivot–meta oo gluing coordinates (√33 points — the generic
`sphere_inter_sphere` instance carries them when needed; no consumer yet); the
oi/io chord family (it IS `sphere_inter_sphere`, nothing to mint); ladder
formalization (gated, §7); the matched-pair colouring theorem (gated, §7).

## 5. Instruments (implementation phase)

* `--loops`: the loop census promoted (exact affine-word enumeration, closure
  tests, minimal-loop reporting; self-test: the B2/B3 loops close, a perturbed
  word does not).
* `--joint` triples (§0.2.1), metapivot floor mode (§0.2.2), the replication
  harness for §0.2.3/4 (reuses `--kills` machinery), branch re-validation (§0.2.5).
* JSON exporter for the visualization (§6) — the page reads exported data, never
  hand-copied constants.

## 6. The visualization deliverable (standing, per Kooshi 2026-08-08)

Extend `visualizations/two-circle-theorem.html` (or sibling `triangle.html`, same
idiom) AS FINDINGS LAND: the triangle + metapivot 8-circle object with its 37-point
glue inventory (§0.1 A) and incidence spine; the loop census's minimal exact cycles
drawn on the configuration (B2/B3's seam hexagon especially — the broadcast cycle
made visible); kill-core coset/alignment renderings from §0.2.3/4 as they run.
Self-contained, inline JS; every plotted fact labeled kernel-checked /
exact-tools / sampled-triage.

## 7. Scope

* **IN**: §4 skeleton (groups 1–8); §0.1 censuses (subplan) + §0.2.1–5 instruments
  (implementation); §5 promotions; §6 visualization.
* **GATED**: the matched-pair colouring theorem (χ(matched pair) = 4 in Lean, the
  pair analogue of `Strip.lean`) — construction data in hand
  (`build/m23-ladderpair-pattern.json`), but it is a Strip-scale project; gate:
  triangle layer lands with budget remaining. NOTE the honest ceiling found at
  subplanning: the *completeness* half (no unlisted cross chords in the infinite
  object) is provable for oo (rigid, §2b.5) and ii (Möbius + irrationality) but
  for oi/io it is a Mordell–Lang-type finiteness question (division-group points
  on a genuine curve) — NOT affordable. The Lean statement, if opened, is χ = 4
  for the graph with the certified family list, stated as such. — The ≤ 5
  pair-colouring certification stays gated behind §0.2.5a as before. Colour
  closure at the gap distance behind budget (§0.2.6).
* **OUT** (M24+, claims unspent): the 26-circle recursion and the spindle witness
  factory; kernel certification of individual SAT kills; write-ups (standing
  policy 2026-08-04).

## 8. Mined from the `opus-larp` branch (evaluated 2026-08-08; unchanged record)

* Adopted: the `inter_eq_pair` factoring (verified, negative-controlled).
* sympy 1.14 installed — the arbiter for field-membership questions.
* Superseding numbers: 76% of adjunction instances free (sympy-exact) vs M22's
  37.5% PSLQ triage.
* Unvalidated branch triage → §0.2.5. Naming hazard: Mathlib's root `discrim`.

## 9. Standing constraints

Writeups/upstreaming deferred (2026-08-04). Builds via `scripts/build.sh` only.
Segfault ⇒ halt and report to Kooshi. One heavy job at a time. Killed patterns
become claims only through the kernel route. Predictions registered BEFORE
instruments — held at M21, M22, and §0 of this plan.
