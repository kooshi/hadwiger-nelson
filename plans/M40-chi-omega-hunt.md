# M40 — The χ > ω hunt: bands, hidden cliques, and the clique-free seven-forcer
# (SUBPLAN — §0 registered 2026-08-12, desktop, before any instrument runs)

*On Kooshi's go at the direction discussion after M39 ("look especially for anything that
just looks suspiciously organized"). The from-below sibling is stubbed as
`plans/M41-k5-gradient.md`. Read order for a fresh session: `plans/M39-constraint-graph.md`
WHOLE (the family, the exact criterion, the census, the ball refutations), then CLAUDE.md
G21–G23.*

## The mission

M39's census, cross-read against its own ball refutations, contains anomalies it never
looked at. This milestone names them, derives what can be derived by hand BEFORE any
instrument runs, fixes the instrument the anomalies expose, and hunts the mechanism. The
family is `G(p)` — the constraint graph on triangular-lattice addresses at scale `p`,
where a proper colouring of `G(p)` IS a proper colouring of the plane. Everything below is
in the address form `Q(a,b) = a² + ab + b²` and `T = 1/p`; the difference body
`H = 2·(Voronoi cell)` is the hexagon with vertices `2·hole_i` (circumradius `2/√3`,
inradius `1`, in address metric).

## §0a — Derivations, committed before any instrument (each hand-verified)

**D1 — The family is piecewise-constant in the scale, with rational breakpoints.** An
offset `d` is an edge iff `min_H Q(d+w) ≤ T² ≤ max_H Q(d+w)`, and both ends are rationals
depending only on `d`'s point-group class. So as `T²` sweeps upward each norm class
switches on at its `min` and off at its `max`, and **`G(p)` is one fixed graph on each
open band between consecutive thresholds**. Every census claim, every SAT verdict, every
ball refutation is therefore a statement about a BAND, not a point (boundary scales,
where `T²` equals a threshold, are tie-break-sensitive — all claims below are for open
bands). Hand-derived threshold table for the coarse region (address arithmetic, exact;
the tool must reproduce these EXACTLY as its green control):

| norm class (rep) | arrives at T² = min | departs at T² = max |
|---|---|---|
| 1 (1,0)  | 0 (adjacent cells) | **13/3** (vertex (2/3,2/3): Q(5/3,2/3) = 39/9) |
| 3 (1,1)  | 1/3 | **25/3** (Q(5/3,5/3) = 75/9) |
| 4 (2,0)  | 1 | **28/3** (Q(8/3,2/3) = 84/9) |
| 7 (1,2)  | **7/3** (nearest H-vertex (2/3,2/3): Q(1/3,4/3) = 21/9) | 43/3 |
| 9 (3,0)  | **4** (edge midpoint (−1,0): Q(2,0), tangential ip2 = 0) | 49/3 |
| 12 (2,2) | **16/3** (aligned vertex (−2/3,−2/3): Q(4/3,4/3) = 48/9) | — |
| 13 (3,1) | **19/3** (nearest point is the H-vertex, dist² = 6.25 + 1/12) | — |
| 16 (4,0) | 9 | — |

**D2 — The hidden 10-clique.** The ten lattice points of the side-3 triangle
`{(a,b) : a, b ≥ 0, a + b ≤ 3}` have all 45 pairwise difference norms in **{1, 3, 4, 7, 9}**
(the differences are, up to sign and point-group action: (1,0)→1, (1,1)→3, (2,0)/(2,−2)→4,
(2,1)/(3,−1)/(3,−2)/(1,−3)?* — verified exhaustively by hand: every difference of two
triangle points has norm in that set; the extreme pairs are the corners, e.g.
(3,0)−(0,3) = (3,−3) → 9). By D1 the band `T² ∈ (4, 13/3)`, i.e.
**`p ∈ (√(3/13), 1/2) ≈ (0.4804, 0.5)`**, has edge-norm set exactly {1,3,4,7,9} (norm 9
has arrived, norm 1 has not yet departed, norm 12 arrives only at 16/3, norm 13 at 19/3).
So on that whole open band the triangle is a **10-clique**: `χ(G(p)) ≥ 10` — TWO colours
above M39's 8-clique theorem, in the band immediately below its window. M39 could not see
this: its clique search was capped at 8 (D4) and its SAT campaign never asked k = 9. The
side-4 triangle is never a clique (its corner difference (4,0) needs norm 16, which
arrives at T² = 9 only after norm 1 departs at 13/3).

**D3 — G\*: the clique-free seven-forcer.** The next band down, `T² ∈ (13/3, 16/3)`, i.e.
**`p ∈ (√3/4, √(3/13)) ≈ (0.4330, 0.4804)`**, has edge-norm set exactly **{3, 4, 7, 9}**
— the norm-1 edges are GONE (nearest-neighbour cells decouple), norm 12 has not arrived.
Call this one fixed graph **G\***. M39's census (reach 4 — sufficient here: every edge
offset has |d|² ≤ 11 so coordinates within ±3) found **ω(G\*) = 4**, and its ball
refutation at `p = 6/13 ∈` the band (radius-4/5/6 balls refuse SIX) plus torus SATs at
seven give **χ(G\*) = 7 exactly**. A canonical, vertex-transitive, finitely-checkable
graph with **χ − ω = 3**, sitting in a family where every previous lower bound was a
clique. The mechanism that forces colours 5, 6, 7 in G\* is a new object; extracting and
naming it is this milestone's headline goal.

**D4 — The census's fine-scale ω values are an instrument artifact (a G21 instance).**
`max_clique(T, reach=4, cap=8)` measures the search box and the cap, not the graph:
(i) at T = 6 the census reports ω = 2, but the equilateral triangle
`{0, (3,3), (−3,6)}` (side norm 27, all three differences norm 27, all edges at T = 6 by
the census's own edge list + point-group invariance) has coordinates outside the reach-4
box; (ii) at T = 2 the reported "8" is the cap sitting on D2's 10-clique. The fix:
`reach ≥ ⌈T + 2/√3⌉ + 1` (every clique translates to contain 0 and then lives in the edge
norm-ball), cap raised until slack. The corrected census REVISES M39's ω narrative; the
kernel windows are untouched (their cliques live where the box sufficed).

**D5 — The tail has the plane's own clique number.** All edges have
`|d| ∈ [T − 2/√3, T + 2/√3]` (necessary), so any clique's pairwise distances lie within
ratio `(T + 2/√3)/(T − 2/√3)`. Four points in the plane pairwise within distance ratio
< √2 do not exist (any 4 points contain a triangle with an angle ≥ 90°: convex position
→ some quadrilateral angle ≥ π/2; otherwise the interior point sees three angles summing
2π; then `c² ≥ a² + b² ≥ 2·min²`). The ratio drops below √2 for
`T > (2/√3)(3 + 2√2) ≈ 6.7302`, and equilateral Loeschian triangles (`0, u, ζ₆u`, any
Loeschian norm in the window — the window in norm has width ≈ 4.6·T and always contains
Loeschian values) give ω ≥ 3. So **ω(G(p)) = 3 for every p ≤ 1/7** — exactly the
unit-distance plane's clique number — while `χ(G(p)) ≥ 5` everywhere (pullback of the
kernel χ(ℝ²) ≥ 5) and = 7 at p = 1/6 one step above the threshold. The fine tail is a
discretized Hadwiger–Nelson, one finite question per band.

**D6 — The spectral instrument (the argument cliques cannot supply).** G(p) is a Cayley
graph on ℤ² (connection set S = the band's edge offsets), so its spectrum is the range of
the integer trig polynomial `λ(θ) = Σ_{s∈S} cos(2π s·θ)`, `θ ∈ [0,1)²`, degree d = |S| at
θ = 0. Independence-density bound (Hoffman ratio, torus-wrap argument: an independent set
of upper Banach density δ wraps onto the m-torus with O(m) boundary repairs, torus Hoffman
applies, m → ∞): `δ ≤ −λ_min/(d − λ_min)`. Any proper k-colouring has a class of density
≥ 1/k, hence **`χ(G(p)) ≥ 1 + d/(−λ_min)`, computable per band** with a certified bracket
on λ_min by adaptive interval subdivision (pure rational/interval arithmetic on cosine
boxes; a grid value alone OVER-estimates the bound and is never quoted as one). G21
discipline: this bound is SUFFICIENT-only as a lower-bound generator — a low bound claims
nothing; its roles are the dip map (where could six live) and mechanism discrimination.

**D7 — The fractional discriminator.** Tori are vertex-transitive, so
`χ_f(torus) = N/α(torus)` exactly, and the torus is a homomorphic image of G(p), so
`χ_f(G(p)) ≤ N/α(torus)`. α computed exactly by SAT with a totalizer (binary search,
UNSAT/SAT bracket). At G\* on the 12×12 torus: if `α ≥ 24` then `χ_f(G*) ≤ 6 < 7 = χ` —
the seven-forcing is an **integrality phenomenon, invisible to every fractional/spectral
relaxation**; if `α < 24` the fractional story strengthens instead. Either way the
mechanism class is pinned. (One-sided: small-torus α only upper-bounds χ_f.)

**D8 — The interval-distance bridge.** A G(p)-edge's two lattice points sit within
covering radius `p/√3` of the unit pair, so their scaled distance lies in
`[1 − 2p/√3, 1 + 2p/√3]`; any plane colouring avoiding ALL distances in that interval
restricts to a proper G(p)-colouring on the lattice. Hence
**`χ_[1−ε,1+ε](ℝ²) ≥ χ(G(p))` at `ε = 2p/√3`** — every band theorem is a lower bound for
the interval-distance chromatic number of the plane (Exoo's ε-unit-distance genre):
≥ 10 at ε ≈ 0.567 (D2), ≥ 7 at ε = 1/(3√3) ≈ 0.1925 (p = 1/6), pushed further down by
any fine-scale ≥ 7. A literature check (Exoo 2005 ε-graphs and successors) is REGISTERED
as due diligence before any novelty claim about this bridge.

**D9 — The non-coset seven-colouring is already guaranteed by arithmetic.** M39 found
k = 7 SAT at 6/13 on the 12×12 torus. A coset colouring by an index-7 sublattice Λ′
descends to that torus only if `12ℤ² ⊆ Λ′`, i.e. `12 ∈ Λ′`; for the norm-7 ideal,
`7 ∤ N(12) = 144`, so it does not. **The found colouring is provably not a coset
colouring of any norm-7 ideal** — M39's P5 question ("genuinely non-coset
seven-colourings would be a finding in their own right"), answered before extraction.
What it IS — class sizes (necessarily non-uniform: 7 ∤ 144), stabilizer sublattice,
coset-merge structure over finer ideals — is the measurement.

## §0b — Instruments (all UNTRUSTED, tools/celllat.py grown in place)

* **Reach/cap fix + corrected census** (`--census2`): reach = ⌈T + 2/√3⌉ + 1, cap 13;
  green control = the coarse rows the old box already covered must reproduce; the D1
  threshold table must be reproduced exactly by a new `--bands` mode (exact breakpoint
  enumeration in T², per norm class, up to a stated norm bound).
* **Band SAT asks**: k = 9, 10, 11 at a rational scale interior to the 10-clique band
  (T = 41/20); k = 6..8 asks stay armed with M39's semantics. Mass-red k = 4 control on
  every new scale probed. The M39 catastrophe guard stays armed verbatim.
* **The shrink engine** (`--shrink T k R`): 1-minimal core of a ball refutation by greedy
  vertex deletion with re-solve (each deletion's UNSAT re-verified; final core re-solved
  from a fresh encoding as the second-path check). Output: core addresses, edges, point-
  group orbit decomposition, per-vertex necessity witnesses (deleting it → SAT model).
* **Colouring anatomy** (`--extract T k m n`): re-derive the SAT model, then: class
  sizes, the colouring's stabilizer sublattice (all torus translations fixing it), class
  difference-norm spectra, and a coset-merge test (is each class a union of cosets of
  some index-N sublattice, N ≤ 36).
* **α by totalizer** (`--alpha T m n`): exact independence number on the torus; sequential
  totalizer, binary search with certified UNSAT/SAT bracket.
* **Spectral sweep** (`--spectral`): per band, the certified λ_min bracket (adaptive
  interval subdivision) and the Hoffman χ bound; the dip map across all bands down to
  T = 12. Numeric honesty: brackets reported as brackets.
* Artifact: `build/m40-chiomega.json` (M39's artifact stays frozen as the historical
  record; the corrected census SUPERSEDES its `census` array and says so in the schema
  line). Explorer: extend the M39 spectrum page into `build/m40-spectrum.html` with the
  corrected ω row, the band structure, the dip map, and the cores rendered.

## §0c — Registered predictions

* **P1 [high]** — the corrected census reproduces every coarse row where the old box
  sufficed, and revises T = 2 to ω = 10 (D2's triangle; ≥ 10 is derivation, = 10 is the
  prediction) and the fine rows upward to ω = 3 (D5).
* **P2 [high]** — `--bands` reproduces the D1 threshold table exactly.
* **P3 [medium]** — at T = 5/3 (p = 0.6, norms {1,3,4,7}) the exhaustive ω = 8: no
  9-clique exists there, so the ball's ≥ 9 is a genuine **non-clique excess** — the
  family's first, at coarse scale; its 1-minimal core is then a named gadget.
* **P4 [medium]** — k = 9 refuses on tori in the 10-clique band (χ ≥ 10 there is D2;
  whether χ = 10, 11, or 12 is open; a 12-coset colouring gives ≤ 12 — the norm-12
  vectors are not edges of that band).
* **P5 [medium]** — the 1-minimal core of the 6/13 six-refusal has ≤ 45 vertices and a
  visible point-group orbit organization (the shrink respects no symmetry, so emergent
  orbit structure is signal).
* **P6 [medium]** — α(12×12 at 6/13) ≥ 24, i.e. the G\* seven-forcing is an integrality
  phenomenon (D7). Refutation = the fractional route strengthens; either way pinned.
* **P7 [medium-high]** — the certified Hoffman bound at G\* is < 7 (consistent with P6;
  spectral does not explain the seven).
* **P8 [certain, arithmetic + reported structure]** — the extracted 12×12 seven-colouring
  at 6/13 is non-coset (D9); its actual structure reported at face value, whatever it is.
* **P9 [low — the jackpot, stated so a find cannot be over-read]** — any k ≤ 6 SAT at any
  scale IS `χ(ℝ²) ≤ 6`: halt the campaign, re-derive the edge set independently, verify
  the lifted colouring directly against the plane criterion, second encoding, report to
  Kooshi before interpretation. (M39 P4 verbatim; the guard stays armed.)
* **P10 [medium]** — the dip map names at least one fine band where clique (= 3) and
  Hoffman (< 6) both leave a six-colouring open — the six-hunt target list becomes
  concrete, scale by scale.

## §0d — Failure clauses

* A shrink that exceeds its per-call cap reports "≤ size, NOT 1-minimal" honestly and
  moves on; a core is only named a core when every remaining vertex has a necessity
  witness.
* Spectral brackets that fail to converge are reported as brackets; no χ claim from an
  unconverged bracket; no kernel claim from ANY numeric spectral value this milestone.
* α binary search timing out reports the certified [lb, ub] only.
* Boundary scales (T² exactly at a threshold) are excluded from every band claim
  (tie-break-sensitive; the tool's closed criterion accepts them — noted, not used).
* Torus UNSAT stays period-bounded unless a BALL refutation is quoted (M39 standing rule).
* Any segfault, any process: HALT and report to Kooshi (standing).

## §0e — Deliverables and the kernel line

Corrected census + band table; the 10-clique band verdicts (k = 9..11); the cores with
orbit anatomy; the seven-colouring anatomy; the dip map; `build/m40-spectrum.html`; §R;
Frontier close with ledger row and grokking updates (G23 sharpens; the census-artifact
lesson extends G21's file). **Kernel promotion is priced and DEFERRED to a named
follow-up**: the 10-clique window theorem needs exact-hexagon unit-pair witnesses for the
norm-1 pairs below p = 1/2 (M38's inscribed-disc constructor provably cannot reach them —
its norm-1 window is p > 1/2), and χ(G\*) = 7 as a kernel statement needs ball-edge
certificates in the M06-chain shape. Both are affordable-looking and neither gates the
structure hunt.
