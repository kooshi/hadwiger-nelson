# M23 — The pivot triangle and the metapivot system (PRE-SUBPLAN)

*Compiled 2026-08-08 at M22 close, enriched by the post-close tangent with Kooshi
(ladder theory, the ten-point count, the broadcast framing) and the `opus-larp`
branch mining. This is the stub grown into a pre-subplan: everything the WORKFLOW
step-3 pass needs is HERE, so the subplanning run after compaction starts focused.
Nothing below is spent: predictions are candidates until registered, Lean targets are
candidates until the skeleton elaborates.*

## 1. What M22 handed this milestone

* **The general gluing classification is certified** (`Glue.lean`,
  `sphere_inter_sphere`): any two distinct centres, radii under the annulus condition
  — intersection = {gluePoint, its reflAxis mirror}; empty cases both ways; unit-axis
  bridge to `Coupled.reflAcross`. The metapivot's axis-1/√3 coupling is already a
  proven spec example. Mathlib holds only the uniqueness half
  (`EuclideanGeometry.eq_of_mem_sphere_of_mem_sphere_of_finrank_eq_two`, cited in the
  module doc).
* **`Coupled.inter_eq_pair`** (adopted from the branch): the unit-axis classification
  parametrized by the ratio — each new unit-pair gluing costs two norm facts. M23's
  three unit-separated pivot pairs instantiate it directly.
* **The first certified near-relation**: `ζ₆σ⁹` within chord 1/50 of 1
  (`normSq_zeta6_mul_seam_pow_nine_sub_one_lt`) and provably ≠ 1. Loops through σ
  NEVER close geometrically — at any number of pivots; only colour closure is live.
* **The kill mechanism named** (tools-side, controlled): outer relaxation revives
  every kill, inner 75%; cores 4–8 π_a pins (median 6), leaning inner; local kills
  are multi-class Hall failures; and post-hoc (unregistered, single pair): core-pin
  separations concentrate on the pure seam lattice {j·θσ mod 60°} (+15 pts over
  matched controls, above 20 decoys) and deplete at the half-offset (−19 pts). The
  near-cycle-shadow reading was REFUTED by the decoy sweep — the carrier is the seam
  lattice itself.
* **Depth is dead**: k = 4 stays SAT through two partner-closure generations (2.4M
  triage edges); 67–70% of partners collide back into the lattice; 76% of adjunction
  instances are free (sympy-exact, branch measurement superseding M22's PSLQ triage).
  Whatever forces the 5th colour is new STRUCTURE, not more iteration.
* Instruments promoted and validated: `tools/couple.py`
  `--near/--partner/--kills/--ladder`, 17 self-test controls, all wired into
  `regen-check.sh`.

## 2. The object

Three pivots pairwise at distance 1 — at 0, 1, ζ₆ the coupling directions are 1, ζ₆,
ζ₃: **hex-commensurate, so exact closed loops exist that both the single system and
the pair provably or measurably lack**. The centroid ⟨1/2, √3/6⟩ is at 1/√3 from all
three pivots — on all three inner circles, the first triple glue point — and is
itself the centre of a fourth two-circle system (the **metapivot**): its inner circle
passes through the three pivots (M18's triangle identity), its outer through the six
120°-partners `rot3^±1` of the centroid about each pivot (the 120° chord of a
1/√3-circle is exactly 1). Full object: **8 circles, 4 centres**, dihedral symmetry,
pivot/metapivot duality (the metapivot of {c, rot3 p c, rot3² p c} is p). The
recursion behind it (8·3 + 2 = 26 circles, three-layer role-overlapping incidence,
3 free phase moduli, spindle-tunable) is M24+ horizon — none of its claims spent.

## 3. The tangent's results (2026-08-08 — recorded here because they are otherwise conversation-mortal)

### 3.1 Ladder theory of the pair (exact; the `--ladder` instrument formalizes it)

* The two-circle graph's components ("ladders") are angle-cosets: the address lattice
  is a·60° + b·θσ (the page's (i, j) grid); each carries two parity tubes
  (tube = (b + [inner]) mod 2 — M20's two-tubes fact in address form). Every ladder
  is countable, dense in both circles, and isomorphic to every other; ladders of ONE
  system never interact except through the pivot hub.
* **The pair shares exactly ten points**: the two pivots + the eight glue points
  (oo (1/2, ±√3/2); oi (1/6, ±√11/6); io (5/6, ±√11/6); ii (1/2, ±√3/6)) — the four
  certified classifications as a set-count.
* **Eight of the ten lie in the single natural ladder pair** (P's ladder through Q,
  Q's through P), by coset arithmetic — addresses about the anchor:
  oo at (±1, 0); oi at (0, ±1); io at (3, ∓2) — the identity behind the last:
  the io glue angle is 180° − 2θσ (tan-addition on arctan√11 + arctan(√11/5)).
  All in tube 0. Nothing needs forcing; the points come with the coset.
* **The inner∩inner pair at ±30° is in NO pivot ladder at any depth**
  (30 = a·60 + b·θσ has no integer solution — θσ irrational kills b, then a = ½
  fails). The pair's blind spot — **and (1/2, √3/6) IS the metapivot**. The next
  milestone's fourth system sits exactly where the pair's own ladders cannot see.
  The second ladder (through +30°) contains both ii points at once (they differ
  by 60°).
* **The natural ladder pair is linked by the unit-translation PERFECT MATCHING**
  (found answering Kooshi's cross-link question, exact census 2026-08-08): since
  dist(P,Q) = 1, the translation z ↦ z + (Q−P) carries P's circles onto Q's circles,
  preserves the address lattice, and every vertex is unit-distance from its own
  image — one cross chord PER VERTEX between the two natural ladders (address map
  (a,b) ↦ (a+3,b), same circle). Colour reading: a proper colouring of the pair
  restricted to the natural ladders must be proper on each ladder, differ POINTWISE
  across the matching, and agree at the six fused glue vertices — the two ladders
  are entangled as whole functions, not through a bottleneck.
* **Plus exactly 12 sporadic cross chords** — census exact to |b| ≤ 10, all twelve
  within |b| ≤ 2 of the seam, at addresses {(1,±1)i, (2,±2)o, (4,±2)o, (5,±1)i}
  cross-matched; their chord vectors are the four glue units re-anchored ((−5/6,
  ±√11/6) ×2 each, (−1/2, ±√3/2) ×4 each) — NO new unit direction exists between
  the natural ladders. The sporadics are the skew chords whose loops mix the two
  ladders' coordinates; candidates for the kill-transmission skeleton.
* **The wider web** (beyond the natural pair): each point of a P-ladder has up to
  four unit-partners on Q's circles; exactly ONE is always its translate (in the
  corresponding coset), the others adjoin √disc and land in foreign Q-ladders,
  generically a different one per point. The measured ambient kill pressure lives
  in that foreign web. (Corrections recorded: density is not the sharing mechanism
  — the ladder choice is; "ladders never interact" is true within a system, false
  across; and one of every probe's partners is NEVER foreign.)

### 3.2 The broadcast framing (the working metaphor for M23's design)

A pivot is adjacent to its ENTIRE outer circle — all uncountably many ladders at
once. The 4th colour is forced locally (nine points), but the pivot's global effect
is a **broadcast**: its colour is forbidden on the whole outer circle simultaneously.
Note a pivot's broadcast NEVER reaches its own inner circle (distance 1/√3 ≠ 1).
One pivot: broadcast is free, χ = 4 exactly. Two: broadcasts interfere through the
cross-web — the 52%/32% pressure, real but not contradictory. Three + metapivot: the
broadcasts form a CYCLE, and the metapivot's broadcast (its outer circle) reaches
all three pivots' inner circles — the region their own pivots cannot touch. M23's
question: can a closed cycle of broadcasts, riding the exact hex loops, be made too
expensive for 5 colours somewhere finite? (de Bruijn–Erdős: any χ ≥ 5 verdict has a
finite witness; the loops tell us where to look for it.)

## 4. Lean targets (candidates for the subplan skeleton)

1. **The ten-point sharing theorem** (cheap, high-value):
   `dist p q = 1 → system p ∩ system q = {p, q} ∪ (the eight glue points)` — pure set
   algebra over the four certified classifications + membership facts. The tangent's
   count as a kernel object.
2. **The triangle's gluing layer**: the three unit pairs via `inter_eq_pair`
   instances; the metapivot couplings (axis 1/√3, radii {1, 1/√3} × {1, 1/√3}) via
   `Glue.sphere_inter_sphere` — note inner(pivot)∩inner(metapivot) has
   d = r₁ + r₂ = 2/√3·(1/2)… check tangency cases in the subplan pass.
3. **Metapivot incidences**: centroid on all three inner circles; the six
   120°-partners on the pivots' inner circles AND on the metapivot's outer circle
   (the 120°-chord identity, M18, re-consumed).
4. **Exact loop identities of the hex sub-network**: compositions of ζ₆/ω rotations
   about the three pivots that equal the identity (classical rotation-composition;
   the concrete triangle makes them two-line `Complex.ext` facts). The subplan pass
   decides which loops earn statements — driven by §5's loop census.
5. **The translation coupling, named** (cheap — three short lemmas): at
   `dist p q = 1`, `z ∈ sphere p r ↔ z + (q − p) ∈ sphere q r` and
   `dist z (z + (q − p)) = 1` — the perfect matching as kernel objects; optionally
   the 12-sporadic-chord census as `example`s (each is one field identity).
6. GATED: ladder/component formalization in Lean (needs graph-component machinery;
   `TwoCircle.SameOrbit` is a seed) — tools-side first, formalize only if a theorem
   needs it.

## 5. §0 instrument plan — predictions to REGISTER BEFORE building (the M22 discipline, kept)

Candidates to register (effect sizes and protocols fixed at registration):

* **Seam alignment of kill cores at fresh pairs** (from M22 §6.4, post-hoc at one
  pair): cores concentrate on {j·θσ} and deplete at the half-offset; the decoy
  protocol (≥ 20 decoys, matched-composition controls) is part of the registration.
* **Ladder-coset census of kill cores**: sharper than angular alignment — are core
  pins co-ladder (same (a, b)-coset about the pinned pivot)? The `--ladder`
  closure-vertex mode is the deferred instrument; it ships only after this
  registration.
* **The triangle loop census**: which words in the three systems' operators close
  exactly (expect: hex sub-network words close, any word with nonzero σ-content
  does not — the certified σ facts say so for pure powers; the census maps the
  boundary).
* **The triangle joint census**: pattern TRIPLES with cyclic cross-chord structure;
  does the kill fraction compound beyond the pair's 52%/32%? Null: three mutually
  far pivots.
* **Metapivot floor**: forbid-last-t on the union of all four systems' cover sets;
  the pair's floor stayed 3 — does the triple glue point move it?
* **Branch re-validation** (before any use): the continuum cell-graph claims
  (4-UNSAT/5-SAT at every width) through OUR instrument, exact where affordable
  (sympy is available); and the free-partner-closure density-falls claim.
* **Colour closure at the gap distance**: does a 4-colour equality-transmitting
  gadget exist at d = |ζ₆σ⁹ − 1| (exact in the field)? Clamp-directed (6-pin cores,
  seam-aligned). A negative is reportable.

## 6. The visualization deliverable (standing, per Kooshi 2026-08-08)

`visualizations/two-circle-theorem.html` now ends at step 8 (the pair, its ten
shared points, ladders, the probe web). M23 extends the page (or a sibling
`triangle.html` in the same idiom) **as findings land, not at the close**: the
triangle + metapivot + 8-circle system with its glue points and ladder addresses
(computable exactly via `--ladder`); the loop census's exact cycles drawn on the
configuration; kill-core angular/coset patterns from the registered tests, rendered
so Kooshi can hunt patterns by eye. Where the page needs real data, `couple.py`
grows a small JSON exporter rather than hand-copied constants. The page stays
self-contained (inline JS, no external deps) and every plotted "fact" states its
status (kernel-checked / exact-tools / sampled-triage).

## 7. Scope

* **IN**: the triangle + metapivot object (Lean layer §4.1–4.4; instruments §5);
  the registered seam-alignment and ladder-coset re-tests; the visualization
  deliverable; branch re-validation.
* **GATED** (open only if their gate fires): the ≤ 5 pair-colouring certification
  (gate: branch cell-graph claims survive exact re-validation AND the triangle work
  leaves budget — its `Locus`/sign-test design is the starting skeleton if opened);
  Lean ladder formalization (gate: a theorem statement needs it).
* **OUT** (M24+ horizon, claims unspent): the 26-circle recursion and the spindle
  witness factory; kernel certification of individual kills; write-ups (standing
  policy 2026-08-04).

## 8. Mined from the `opus-larp` branch (evaluated 2026-08-08)

* Adopted into main: the `inter_eq_pair` factoring (verified, negative-controlled).
* sympy 1.14 installed — exact nested-radical arithmetic (~35 µs/op at degree 8);
  the arbiter for field-membership questions (branch caught its own checker bug
  with five planted controls).
* Superseding numbers: 76% of adjunction instances free / 51.4% of distinct
  radicand classes (sympy-exact) vs M22's 37.5% PSLQ triage (biased population).
* Unvalidated branch triage catalogued for §5 re-validation: free-partner closure
  to 10,548 points, k = 4 SAT, density FALLS (2.52 vs 2.98 edges/point); bi-sector
  cell family 4-UNSAT / 5-SAT on the continuum at every width 60°→5°. Its claim
  that the ten double-membership points explain the mesh failure is unsupported by
  our curve-level data — hypothesis, not finding.
* Naming hazard: Mathlib's root `discrim a b c` (quadratic discriminant, same
  arity) — never mint an unqualified `discrim`.

## 9. Standing constraints

Writeups/upstreaming deferred (2026-08-04). Builds via `scripts/build.sh` only.
Segfault ⇒ halt and report to Kooshi. One heavy job at a time. Killed patterns
become claims only through the kernel route. Predictions registered BEFORE
instruments — the discipline held twice (M22 B2/C3 refuted cleanly; the M22 §6.4
decoy sweep killed a seductive post-hoc reading) and is non-negotiable.
