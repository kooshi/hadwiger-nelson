# M24 — Chord completeness and the unconditional matched-pair theorem (SUBPLAN)

*Stub recorded 2026-08-08 from the post-M23 discussion with Kooshi; subplan opened
2026-08-08 on his go. §0 predictions are registered BEFORE the experiments run —
the M22/M23 discipline that has now killed two seductive post-hoc readings.*

## The object distinction (crisp, so we prove the right theorems)

"Total colourability of the two-pivot system" in this programme means the
**matched ladder pair**: the two pivots' natural ladders (countable), closed
under ALL unit chords between their points — with the chord list made EXACT by
completeness theorems, not by a census window. It does NOT mean the uncountable
`Coupled.pairSystem` (all points of all four circles): that object's χ is the
M21 fork, still parked (M29's question). Same convention for M25/M26: the
ladder objects of their configurations, with complete chord lists.

**Sharpened at subplan (decision, recorded):** the M24 object is the **full
lattice pair** — all addresses (a, b) ∈ ℤ/6 × ℤ on all four circles, both
parity tubes, plus the two pivots — not just the tube-0 "natural" component.
Alternative: the tube-0 pair only (M23's census object). Why: the full-lattice
theorem is strictly stronger, needs no tube side-condition in the object
definition (the tube decomposition becomes a corollary, not a hypothesis), and
the deep census already scanned both tubes. Confidence: high.

## Roadmap (agreed 2026-08-08, unchanged)

* **M24**: the two-pivot matched ladder pair, unconditionally — completeness
  theorems for every chord family + the colouring theorem (χ = 4 exactly) —
  plus the **derivation batch for all axes** (the metapivot's chords and its
  own ladder derived tools-exact now; their Lean instances land in M25).
* **M25**: the 3-pivot + metapivot system — four ladders, all cross-webs,
  proven sporadic counts, colouring.
* **M26**: the 6+1 hexagram system (second triangle = the mirror centroids,
  promoted; adds the 2/√3 axis with the triple tangency at m).
* **Horizon after M26, if χ is still 4 (Kooshi, verbatim intent)**: (a) the
  infinite plane tiled with the hexagonal construction, all sporadic chords
  between all possible points (M27); (b) the construction recursed, possibly
  infinitely (M28). M29: the uncountable pair. Stubs: `plans/M25…M29`.

---

## §0 Registrations — predictions BEFORE instruments

All experiments are sympy/`tools.field` exact arithmetic (no pari dependency;
floats only ever GENERATE candidates, never decide). Script:
`build/m24-derive.py` (gitignored; snapshot discipline). Everything below was
written before the script existed.

### §0.1 E1 — The master equation and its factorizations

The claimed unification: for pivots p, q and any complex multipliers x′, v′,

```
dist (p + x′·(q−p)) (q + v′·(p−q)) = ‖q−p‖ · ‖1 − x′ − v′‖        (cross)
dist (p + x′·(q−p)) (p + v′·(q−p)) = ‖q−p‖ · ‖x′ − v′‖            (intra)
```

so at unit axis, with x, v unit lattice words and radii r₁, r₂ ∈ {1, 1/√3},
every cross family is `‖1 − r₁x − r₂v‖ = 1`, every fusion is
`1 − r₁x − r₂v = 0`, and every intra family is `‖r₁x − r₂v‖ = 1`. One
equation family carries M24 through M27 (each tiled-plane axis class is one
instance).

Registered predictions:
* **P1.1** The two display identities verify symbolically (pure ring algebra).
* **P1.2** ii (r₁ = r₂ = 1/√3), on the torus ūu = v̄v = 1: chord ⟺
  `(u+v) · ((u+v) − √3(1+uv)) = 0` — the matching branch (v = −u, the
  translate) times the **norm form** `(√3u−1)(√3v−1) = −2` exactly.
* **P1.3** oi (r₁ = 1, r₂ = 1/√3): chord ⟺ `normSq (√3(1−x) − v) = 3`;
  equivalent to M23's 3-term identity √3(x−1)(x−v²) = v(3x²−4x+3) on the
  torus; **no factorization** over ℚ(√3) (no matching family exists for oi —
  the translate maps outer to outer).
* **P1.4** oo (r₁ = r₂ = 1): chord ⟺ `(x+v)(x−1)(v−1) = 0` — must agree with
  the already-certified `Triangle.unit_chord_units` (consistency anchor).
* **P1.5** Fusion classification: oo fusion ⟺ {x,v} = {ζ₆, ζ₆⁻¹} (the oo
  glues) or the pivot cases; oi fusion ⟺ v = σ^{±1}, x = 1 − σ^{±1}/√3 =
  word(3,∓2) (io glue, lattice); ii fusion ⟺ u = ζ₁₂^{±1} — **not lattice**
  (backbone: lattice torsion is pure hex) — so the ladder pair fuses at
  exactly **8** points (pivots, oo±, oi±, io±), the ten-point theorem minus
  the two non-lattice ii glues.

### §0.2 E2 — The ii valuation argument (the completeness engine)

Frame: π := √3·σ = (1 + i√11)/2. Then π² = π − 3, π̄ = 1 − π, ππ̄ = 3,
π + π̄ = 1 (so π, π̄ coprime). At a prime 𝔭 above 3 in K = ℚ(i, √3, √11)
chosen over π: v(√3) = 1, v(π) = 2, v(π̄) = 0, v(ζ₆) = 0, v(3) = 2.

Clearing √3-powers from the norm-form branch u + v = √3(1 + uv) with
u = ζ₆^a σ^b, v = ζ₆^c σ^d turns each sign-region of (b, d) into an ultrametric
contest between four monomials with EXPLICIT valuations; a unique minimum
forces T ≠ 0 (no chord), and ties are finite checks.

Registered predictions:
* **P2.1** The frame facts above verify exactly.
* **P2.2** Region b, d ≥ 2: term valuations (2b+d, 2d+b, b+d+1, 2(b+d)+1),
  unique min b+d+1 ⟹ **no solutions**.
* **P2.3** Mixed signs (b ≥ 0 > d and reflections): unique min at the π̄-heavy
  term ⟹ **no mixed-sign ii chords at all** (matching aside, which is
  same-sign by construction v = −u).
* **P2.4** Rows b = 0 (pure hex times any d): unique min ⟹ empty. Ties are
  exactly: **b = d = 1** (36 (a,c) cases, where the sporadics live) and
  **b = 1, d ≥ 2** (resolved once by v(ζ₆^a π − 3) = 2 for all a — six exact
  computations), plus the (d,b)-symmetric images and conjugates.
* **P2.5** The b = d = 1 finite check finds EXACTLY the 4 known ii sporadics;
  `(√3·ζ₆σ − 1)(√3·ζ₆⁵σ − 1) = −2` holds EXACTLY in the field (the post-M23
  float check promoted to exact).
* **Failure clause**: if any region shows a non-unique min not in the tie list,
  the region analysis is wrong — re-derive before any Lean statement is fixed;
  if the tie set is infinite along a line, the ii completeness statement moves
  to the resolvent route (below) and the subplan is re-costed.

### §0.3 E3 — The oi valuation argument (the risk item)

Route: A := √3(1−x) − v; chord ⟺ AĀ = 3 ⟹ v(A) + v(Ā) = 2 at 𝔭. Clearing
√3-powers gives three-monomial contests for A and Ā separately.

Registered predictions:
* **P3.1** For min(|b|, |d|) ≥ 2: v(A) + v(Ā) ≠ 2 region-wise (unique mins) ⟹
  no solutions.
* **P3.2** The tie set is finite, contained in |b|, |d| ≤ 2; its finite check
  yields exactly the 4 oi + 4 io known sporadics.
* **Fallback registered now** (if the tie analysis fails): the Vieta route —
  for fixed v the two x-roots satisfy x₁x₂ = −v(v−√3)/(√3v−1) with
  |x₁x₂| = 1 (Blaschke identity |v−√3| = |√3v−1| on the torus), so lattice
  x-pairs are constrained by a product identity in the lattice group; bound
  via the backbone.
* **Failure clause**: if neither route bounds the tie set, oi completeness is
  reported NOT LANDED and the milestone re-scopes to ii + oo + intra + fusion
  completeness with oi as the named open family — no quiet rescoping.

### §0.4 E4 — The axis-1/√3 derivation batch (the metapivot's chords)

By law of cosines, the seam angle of a coupling (axis D, radii ρ₁ → ρ₂)
satisfies cos θ = (D² + ρ₁² − ρ₂²)/(2Dρ₁).

Registered predictions (the torsion table):
* **P4.1** (1/√3, 1, 1/√3): cos θ = √3/2 ⟹ θ = 30° — **ζ₁₂ torsion** (the
  pivot–metapivot outer→inner gluing is periodic, glue points {1, ζ₆} as
  certified in Triangle.lean).
* **P4.2** (1/√3, 1/√3, 1/√3): cos θ = 1/2 ⟹ 60° — ζ₆ torsion (mirror-centroid
  gluings). (1/√3, 1/√3, 1): cos θ = −1/2 ⟹ 120° — ζ₃ torsion (rot3-partner
  gluings). All three re-derive Triangle.lean's no-new-points couplings.
* **P4.3** (1/√3, 1, 1): cos θ = √3/6 — **the SAME incommensurate seam angle
  θσ** reappears on the metapivot's outer–outer couplings. The θσ resistance
  is axis-independent structure.
* **P4.4** The four cross-chord master-equation instances at D = 1/√3 derived
  exactly; factorization attempted for each; predict **no matching-type
  factor** at this axis (the translate by m−p moves points 1/√3 ≠ 1).
* **P4.5** The pivot→metapivot axis sits at 30° to the pivot→pivot anchor, so
  metapivot cross-chord equations carry a ζ₁₂ offset; the combined M25
  lattice is ⟨ζ₁₂, σ⟩, index 2 over ⟨ζ₆, σ⟩. The metapivot's own ladder is
  the SAME ⟨ζ₆, σ⟩ structure (intra operators are radius-universal), anchored
  compatibly at all three pivots because 120° = ζ₆² is in the lattice.

### §0.5 E5 — The census control bed (net fixed, ground truth pinned)

The M23-era `build/m24_deepcensus.py` candidate net is O(B) per address
(wrap-count scan) ⟹ O(B²) total — Kooshi killed the B = 500 run. Fix: solve
the wrap directly (O(1) candidates per address).

Registered predictions:
* **P5.1** The fixed net reproduces the |b| ≤ 30 result exactly (twelve
  sporadics, everything else fused-endpoint), then extends clean to B = 200.
* **P5.2** The twelve sporadics' exact addresses: ii 4 = {((1,1),(5,1)) and
  its conjugate + swaps}; oi 4 = {((2,2),(5,1)), ((2,−2),(5,−1)),
  ((4,2),(1,1)), ((4,−2),(1,−1))}; io 4 = their mirrors. All same-sign in
  (b,d), all within |b| ≤ 2, all tube-0 ↔ tube-0.
* **P5.3** The padded inner fused sets in the M23 script ((1,0), (5,0) in
  FUSED_P_INNER/FUSED_Q_INNER — those addresses are NOT fused points) never
  matched a hit: reclassification with the derived 8-point fusion list
  changes NOTHING. (If it does change something, the twelve-sporadic count
  itself was wrong — report loudly, re-open §3.2 of the M23 plan.)
* **P5.4** No chord family crosses parity tubes.

### §0.6 E6 — The colouring pattern and the χ ≥ 4 witness

* **P6.1** Stage 1–3 of `build/m23-ladderpair-check.py` reconfirm: k = 3 UNSAT
  (contains the nine-point forcing — control), period-1 bulk proper, splice
  SAT; the splice window's vertex count recorded (the Lean literal-table
  cost driver).
* **P6.2** The nine-point witness embeds at explicit lattice addresses
  (pivot + five consecutive outer hex at b = 0 + a rot3 inner triple at
  b = ±1); addresses recorded for the Lean `decide`.
* **P6.3** One registered SAT probe: does a defect-free period-1 colouring
  exist (full pattern freedom, no splice)? Predict **no** (the sporadic belt
  obstructs). If yes, the colouring module drops the window table.

### §0 results — recorded 2026-08-08 (`build/m24-derive.py`, all exact; E5 wall 1.9 s)

**E1 — all confirmed.** P1.1 both distance identities verify symbolically. P1.2
verified in the corrected constant: the cleared ii master = S·(S − √3(1+P))
(my registered target carried a spurious −√3; the two branch identifications
are exact: S = 0 is the matching, and (√3u−1)(√3v−1)+2 = −√3·(S − √3(1+P))).
P1.3: the cleared oi master, uv·(AĀ−3) cleared, and M23's 3-term identity are
the SAME polynomial (both ratios 1); irreducible over ℚ(√3). P1.4 exact match
with the certified oo factorization. P1.5 all three fusion witnesses exact:
oi-glue partner addresses are word(3, ±2); the ii fusion needs u = ζ₁₂ —
torsion of order 12, never lattice.

**E2 — conclusion confirmed, registered tie-map WRONG twice, and the
discovered structure is better than the registered sketch.**
* P2.1 frame facts all exact. P2.5 the sporadic norm-form identity exact.
* Mixed signs: EMPTY ✓ (P2.3). Rows b = 0, d ≥ 1: empty ✓.
* **Miss 1**: b = d = 0 is a TIE, not a unique-min row, and it holds real
  zeros (a,c) = (0,3), (3,0) — the points where the matching branch CROSSES
  the norm-form branch ((√3−1)(−√3−1) = −2). Already-known chords, no new
  sporadics — but the registered "empty row" claim was wrong.
* **Miss 2**: the b = 1 resolver v(ζ₆^aπ − 3) = 2 FAILS at even a:
  Nm-valuations are a = 0: 3⁴, a = 2,4: 3³, a = 1,3,5: 3² — and exactly at
  a = 0 a genuine solution lives: **(0,1) → (3,3)**, i.e. u = σ (the oi-glue
  address), v = −σ³ = ζ₆³σ³, verified exact. Glue-incident (the endpoint is
  the fused oi glue), so no new sporadic — but the registered proof sketch
  would not have closed this row.
* **The discovery that reshapes the proof**: the norm form is equivalent to
  v·(√3u − 1) = u − √3, i.e. **v = μ(u) for the Möbius involution
  μ(z) = (z−√3)/(√3z−1)** (μ² = id; the same Blaschke frame as E3's fallback).
  So ii completeness = "for which lattice u is μ(u) lattice", and the
  valuation argument collapses: for |b| ≥ 2, comparing v_𝔭 and v_𝔭̄ of
  μ(u) = (ζ₆^aπ^b − √3^{b+1})/(√3(ζ₆^aπ^b − √3^{b−1})) forces **|d| = 1**;
  the remaining |b| ≤ 1 / |d| = 1 sides are 18 explicit μ-computations. No
  staircase induction, no 36-case ties.
* Full measured solution set of the norm form (conjugation/swap closed):
  {(0,0),(3,0)} matching-crossings ∪ {(1,±1),(5,±1)} sporadics ∪
  {(0,±1),(3,±3)} glue-incident. Nothing else in |b|,|d| ≤ 8 (grid) and
  nothing else at B = 200 (E5).

**E3 — sporadic list confirmed; solution set FINITE.** The 4 registered oi
sporadics exact ((2,±2)→(5,±1), (4,±2)→(1,±1)); 12 glue-incident zeros, all
|b| ≤ 2, every one through a genuine fused endpoint; **16 solutions total,
no growth from window 8 to window 200** — unlike oo/ii, the oi family has no
infinite branch at all. Blaschke fallback identity verified. The valuation
profile: A-side unique min forces v(A) = 1 for d ≥ 2; Ā-side min(b, d+1)
unique unless b = d+1 — solutions need d = 1 or b = d+1, and the sporadics
sit exactly on the doubly-degenerate point (b,d) = (2,1). The oi proof is a
nested (2-level) resolver analysis re-using E2's Nm(ζ₆^cπ − 3) table; the
tie lines are one-parameter and close by the same two-prime bookkeeping.

**E4 — all confirmed, plus the hub-factor law.** Torsion table exact:
pivot–metapivot oi = 30° (ζ₁₂), ii = 60° (ζ₆), io = 120° (ζ₃), and oo carries
cos θ = √3/6 — **the same incommensurate θσ as the unit axis**. Factorizations
at D = 1/√3: oi picks up the factor (v−1) and io the factor (u−1) — the HUB
factors: the metapivot's inner circle passes through the pivots (D = ρ₂) and
each pivot's inner circle passes through the metapivot (D = ρ₁), so one
branch of those couplings is the hub family, exactly as at unit axis oo. The
oo and ii instances are irreducible (no matching at this axis — confirmed
v = −u fails). m = ζ₁₂/√3 exact (the 30° anchor offset; the M25 lattice is
⟨ζ₁₂, σ⟩, index 2 over ⟨ζ₆, σ⟩).

**E5 — everything confirmed.** O(B) net (angle-bin dict): B = 200 in 1.9 s
(the killed O(B²) run is fully superseded). Sporadics: EXACTLY the registered
twelve, all |b| ≤ 2, all tube-0↔tube-0 (P5.4 ✓): ii {(1,±1)→(5,±1),
(5,±1)→(1,±1)}, oi {(2,±2)→(5,±1), (4,±2)→(1,±1)}, io their mirrors. oo: zero
sporadics (2405 matching + hub/glue) ✓. P5.3: the M23 padded fused sets hid
NOTHING (empty diff) — the twelve-sporadic count stands.

**E6 — witness pinned; registered P6.3 prediction WRONG, in the best
direction.** The nine-point witness embeds at p, outer(0..4, 0),
inner(0,1), inner(2,1), inner(4,1): 15 edges, non-3-colourable,
4-colourable (exact adjacency + exhaustive check). **The b-collapsed
period-1 SAT probe with ALL families imposed (sporadics, fusions, matching,
hubs) is SAT**: a fully b-independent 24-entry table + 2 pivot colours
exists — hand-verified proper on every collapsed family:
Po = [0,1,0,1,0,1], Pi = [1,0,2,2,3,3], Qo = [2,1,2,1,2,1],
Qi = [1,2,0,0,3,3], cP = 2, cQ = 0. **The M23 defect splice was an artifact
of a pipeline that never imposed the sporadics on the cylinder — NO SPLICE
IS NEEDED.** The colouring theorem is a pure literal table with finite
congruence properness. (M23's stage-1/2/3 re-run is superseded by this
stronger object and was not repeated.)

---

## §1 M24 scope (post-§0 shape)

1. **The geometry layer** (`Ladder.lean` §A): lattice words
   (`word a b = ζ₆^a·σ^b`, ℤ exponents), the ladder-point map
   (side × circle × address → ℂ; pivots are automatic — each pivot IS the
   other side's outer(0,0), so no special vertex casing), the vertex set,
   the two master distance identities (cross and intra — E1-verified), the
   per-family chord-iff bridges, and the fusion classification (6 fused
   pairs + address injectivity). Kernel-cheap house-style field work.
2. **The completeness layer** (`Ladder.lean` §B or its own module — domain
   pass decides the split): the Möbius-involution route for ii
   (v·(√3u−1) = u−√3; |b| ≥ 2 ⟹ |d| = 1 by the two-prime π/π̄ bookkeeping in
   ℤ[ζ₆,π]-coordinates; 18 explicit boundary computations), the oi nested
   resolver argument (finite solution set of 16), intra completeness (three
   fibre lemmas: Re = 1/2, −1/2, √3/6 + the zpow backbone), and the
   assembled `cross_chord_complete` — **the twelve sporadics PROVEN exact,
   no census window**.
3. **The colouring layer**: the E6 table as literals (NO splice — b enters
   nowhere), well-definedness on fused points (6 decides), properness per
   family (ZMod 6 congruence decides driven by the edge classification),
   the nine-point lower bound (decide on the pinned witness + pullback),
   and `χ(matched ladder pair) = 4` against Mathlib's
   `SimpleGraph.chromaticNumber`, no conditional clause.
4. **The derivation batch** (tools + this plan; Lean instances deferred to
   M25): DONE at §0.4 — the torsion table (30°/60°/120° + θσ at oo), the
   hub-factor law, the ζ₁₂ anchor offset, the ⟨ζ₁₂,σ⟩ M25 lattice, all
   exact. M25 consumes these as its §0 baseline.

## §2 Assets in hand

`Triangle.lean` (chord classifications, zpow backbone, `unit_chord_units`);
`Glue.lean` (axis-general gluing); `Coupled.lean` (`inter_eq_pair`,
reflAcross layer); the census clean to |b| ≤ 30; M20's strip/witness
machinery; the M22/M23 standing constraints (builds via scripts/build.sh;
segfault ⇒ halt; one heavy job; predictions before instruments).

## §3 The Lean skeleton (`Proofs/HadwigerNelson/Ladder.lean`, 36 obligations)

Committed with this subplan; elaborates clean (`lake env lean`; the gate build
will re-confirm under the lakefile options). Namespace `HadwigerNelson.Ladder`,
imports `Triangle` (backbone, seam layer). Shape:

* **§A words** — `word a b = ζ₆^a·σ^b` (ℤ zpow); `word_add`/`word_normSq`/
  `word_ne_zero`/`word_conj`/`word_eq_one_iff` (the backbone, re-addressed).
* **§B points** — `outerPt p q a b = p + word·(q−p)`,
  `innerPt = p + (√3/3)·word·(q−p)`; `LadderSet` = the four ranges at the
  (0,1) anchor. **Pivots are automatic** (each = the other side's
  `outerPt _ _ 0 0`) — no special vertex anywhere.
* **§C masters** — `cross_dist`, `intra_dist` (pure algebra, axis-general:
  the M25–M27 spine).
* **§D bridges** (general unit pair) — `oo_complete` (matching ∨ two hubs —
  completeness free here), `ii_chord_iff` (matching ∨ division-free Möbius
  form), `oi_chord_iff` (the normSq-3 equation; io = this bridge at the
  swapped anchor, NO separate theorem).
* **§E intra completeness** — hex / rot3 / seam steps, address form, three
  theorems (fibre lemmas Re = 1/2, −1/2, √3/6 + backbone inside).
* **§F fusion completeness** — `outerPt_inj`/`innerPt_inj`/`outer_ne_inner` +
  `fusion_oo`/`fusion_oi`/`fusion_io`/`fusion_ii` (≠) — the six fused points
  and nothing else; drives colour well-definedness.
* **§G completeness core** — `iiNormTable` (10 tuples), `ii_norm_bound`
  (|b| ≥ 2 → |d| = 1 — the two-prime valuation core), `ii_norm_complete`;
  `oiTable` (16 tuples), `oi_complete`. List-membership currency
  (ZMod 6 × ℤ × ZMod 6 × ℤ), Strip.lean precedent.
* **§H colouring** — `colTab` (the E6 tables, literal), `colAddr`
  (b-independent), `ladderColour` (classical address decode, junk 0 off the
  ladder), four `ladderColour_*` decode lemmas (where injectivity + fusion
  get consumed), `ladderColour_valid`, `colorable_four_ladder`,
  `not_colorable_three_ladder` (nine-point witness),
  `chromaticNumber_ladderPair : … = 4` — the headline, against Mathlib's
  `SimpleGraph.chromaticNumber` on `(unitDistance ℂ).induce LadderSet`.
* **§I spec** — table lengths (rfl, live), table spot values (rfl, live),
  pivot memberships, the (1,1)→(5,1) sporadic chord, the adversarial
  non-chord (2,1)→(4,1), the inner matching chord.

Deliberately NOT in the skeleton: any io theorem (= oi at the swapped
anchor); the monster "edge classification" disjunction (the properness proof
does the 4×4 case split inline, citing §D–§F per case); the axis-1/√3 Lean
instances (M25 — the derivations are §0.4's exact record); ladder/tube
decomposition machinery (the full-lattice object needs none).

**Experience pass (2026-08-08).** Changed: (1) `LadderSet` → `ladderSet`,
`ladderColour` → `ladderColor` + decode-lemma names — the repo's stated
identifier convention is `color` (Sat/Encoding.lean) and defs are
lowerCamelCase (`Coupled.system` precedent); (2) `ii_chord_iff`'s matching
disjunct moved to address form (`c = a + 3 ∧ d = b`) — same currency as
`oo_complete`, so the properness consumer never pays a `word_neg_iff` step;
(3) implicature fixes: `iiNormTable`'s docstring now states the infinite
matching branch is deliberately absent; the headline docstring names the
object with the post-M23 precision (countable ladder pair, both tubes, NOT
`Coupled.pairSystem` — the read-aloud surface). Confirmed: publicize
`Triangle.unit_chord_units` with a consumer-naming docstring (over cloning —
the N-identical-privates smell; Triangle re-elaboration is minutes);
`sqrt_indep` stays Ladder-private (M25 lifts it when a second consumer
exists — recorded here as the named handle); zero simp tags (house
precedent); the two-letter family codes (oo/oi/io/ii) are standing house
vocabulary and stay. Instrument surface for implementation: promote the O(B)
census net into `tools/couple.py --census` with the planted-sporadic
negative control AND a new decorrelation self-test — the census's sporadic
output asserted equal to the Lean tables' contents (two independent
derivations of one list must agree). Deferred, recorded: the tables'
soundness direction (every entry IS a chord) has no consumer beyond the spec
examples — not stated as a theorem until M25 asks. 40 obligations;
elaborates clean.

**Obligation pass (2026-08-08).** The proof map — three shared engines carry
the module:

* **`sqrt_indep`** (new foundational child, Ladder-private): ∀ e₁ e₃ e₁₁ e₃₃ : ℚ,
  e₁ + e₃√3 + e₁₁√11 + e₃₃√33 = 0 → all four vanish. Elementary descent
  (√11 ∉ ℚ(√3), ~80 lines, children: two irrationality facts). Applied to Re
  and Im parts it turns any cleared ℂ-equation into rational coordinate
  equations — the whole completeness core stands on it, and M25–M27 reuse it.
* **The π-sequence layer**: `piC : ℂ = (1+i√11)/2` with `piC_sq : π² = π − 3`
  and `√3·seam = π`; integer sequences `px py : ℕ → ℤ`
  (`px (n+1) = −3·py n`, `py (n+1) = px n + py n`) with the bridge
  `π^n = px n + py n·π` (one induction) and congruences `3 ∣ px (n+1)`
  (definitional), `py n ≡ 1 [3]` for n ≥ 1 (induction + omega),
  `px n ≡ −3 [9]` for n ≥ 2. These transcribe every valuation contest as an
  omega-closable integer congruence — NO Dedekind/valuation machinery, no
  auxiliary ring type.
* **The symmetry pair**: `ii_norm_symm` (the norm equation is (u,v)-symmetric
  — one `linear_combination`) and conj-transport (`word_conj`); WLOG order:
  swap to |b| ≥ |d|, conj to b ≥ 0. The measured solution orbits close under
  exactly these (e.g. (3,−3,0,−1) →conj (3,3,0,1) since −3 = 3 in ZMod 6).

**`ii_norm_complete` spine** (regions after WLOG): (i) b ≥ 2 → `ii_norm_bound`
forces |d| = 1 → the d-line's six c-cases: three close onto table entries by
Möbius determinism + `word_inj` ((5,1,1,1)-type contradicts b ≥ 2 except the
glue (3,3,0,1)); three (c = 2,3,4) die by the **13-fingerprint** — μ(ζ₆^cσ)
has 13 in its rationalized denominators, lattice words never do (extraction
+ omega, uniform in b). (ii) The finite cells (b,d) ∈ {(0,0),(1,0),(1,1),
(1,−1)}: (1,0) dies by the **√33-fingerprint** (σ-coordinate present vs
absent — one argument kills all 36 (a,c)); (0,0) and (1,1) extract to
ZMod-6² statements closed by `decide` (measured zeros: (0,3),(3,0) and
(1,5),(5,1)); (1,−1) is the mixed-sign kill (congruence). `ii_norm_bound`
itself: per sign-region of d, clear, extract the minimal-level coordinate,
contradict px/py congruences by omega (E2 verified every cell).

**`oi_complete` spine**: conj-WLOG only (no swap — oi is asymmetric); two
region bounds (|b| ≥ 3 → False, |d| ≥ 2 → False; sequence congruences at the
levels the E3 staircase measured, the Nm-resolver table {81,36,108,225,108,36}
guiding the c-dependent second-order kills), then ~15 finite (b,d) cells ×
extraction + decide. Measured: all 16 solutions have |b| ≤ 2, |d| ≤ 1.

**Bridges/intra/fusion spines** (uniform toolkit): `cross_dist`/`intra_dist`
are `Complex.dist_eq` + ring-in-norm + `norm_mul`. One parametric fibre child
`unit_eq_of_re (hw : normSq w = 1) (hc : normSq c = 1) (hre : w.re = c.re) :
w = c ∨ w = conj c` serves ALL pins (ζ₆ for hex/oo-fusion, ω for rot3, σ for
seam/oi-fusion, ζ₁₂ for ii-fusion) with `normSq_one_sub (hw) :
normSq (1−w) = 2 − 2·w.re`-style Re-computations. `fusion_ii` needs no
valuation: word a b = ζ₁₂ squares to word 2a 2b = ζ₆ = word 1 0, and
2a = 1 has no solution in ZMod 6 — `decide`. `fusion_io` = `fusion_oi` at
the swapped pair (dist_comm), pure citation. oo factorization: publicize
Triangle's `unit_chord_units` (Triangle is not a certificate module; its
re-elaboration is minutes) rather than clone. ii key: private
`ii_key : normSq(1 − (√3/3)(u+v)) = 1 ↔ (u+v)·((u+v) − √3(1+uv)) = 0` on
the torus (E1-verified; cofactors at implementation, m23_cofactors style).
oi bridge is a pure scaling (normSq(√3w) = 3·normSq w) — no torus needed.

**Colouring spines**: decode lemmas = dif-branch analysis + `outerPt_inj`
(+ 3-way fused-cell splits in the Q-side lemmas, table agreement by decide —
exactly the six E6 fusion equalities). `ladderColour_valid` = ten side/circle
case arms; each rewrites by decode lemmas, extracts addresses by the family's
completeness iff, closes by one ZMod-6 decide. The nine-point witness's 15
edge facts are certified by the completeness iffs' `.mpr` directions — zero
new norm_num; non-3-colourability of the abstract 9-vertex graph by `decide`
(3⁹ cases); assembly = M20's two-half chromaticNumber pattern verbatim.

**Mutation audits** (supersedes the §4 list where they differ): (1) ii_key
constant perturbed → sporadic spec example breaks; (2) matching disjunct
dropped → matching example breaks; (3) colour-table entry flipped → fused-cell
decide + properness decide break; (4) (3,3,0,1) deleted from iiNormTable →
the b ≥ 2 assembly breaks AND the glue-chord spec example (added) breaks;
(5) ii_norm_bound conclusion weakened to |d| = 2 → the d-line kill breaks;
(6) one oiTable glue entry deleted → oi assembly + oi-glue spec example
(added) break; (7) one witness outer point removed → the 9-point decide flips
(E6-verified 3-colourable); (8) py base case flipped → congruence induction
breaks. Partition: all public statements prove; spec examples test; no
standing assumptions beyond `dist p q = 1` (discharged at the anchor by a
`dist_zero_one` clone).

**Domain pass (2026-08-08).** One substantive convergence: **the address type
is `ZMod 6 × ℤ`** (was ℤ × ℤ with `6 ∣` conditions and ZMod casts at the
tables — two currencies for one fact). Torsion × free IS the backbone
theorem, so addresses become canonical names: every completeness RHS is now
plain ZMod-6 equalities (`c = a + 3`, not `6 ∣ c − a − 3`), table membership
has no casts, injectivity is genuine injectivity (`word_inj` added), and the
colouring properness will close by 6-element decides. Cost: one periodicity
child inside `word_add` (ζ₆^val arithmetic), paid once. Also added
`word_neg_iff` (the matching branch's address bridge, −1 = ζ₆³ — a missing
joint every cross-family proof needs). Confirmed after stress: two point
defs (families are genuinely distinct master instances — a parametrized
collapse would trade six readable theorems for one unreadable one), anchored
`LadderSet`, ℂ-carrier statements with NO auxiliary ring type in the public
surface (the ℤ[ζ₆,π] coordinate work is proof machinery — obligation pass),
list tables, no Möbius `def` (the division-free equation is the normal
form), the classical dite decode with the four decode lemmas as the honest
well-definedness joints. 38 obligations after the pass; elaborates clean.

## §4 Gate

The full house gate (build green via scripts/build.sh, zero sorry, axioms
clean, lint, spec examples) plus mutation audits fixed at subplan time:
1. Norm-form constant −2 → −1: `ii_complete` must break (the sporadic check
   discriminates).
2. Drop the matching branch from `ii_chord_iff`: the translate witness must
   break ⊇.
3. oo consistency anchor: `unit_chord_units` citation — perturb the frame
   sign: must break.
4. Delete one sporadic from the twelve: `cross_chord_complete` ⊇ fails on its
   witness.
5. Tie-region weakening (b = d = 1 check run at 35 of 36 cases): must break.
6. Colour table: flip one entry: properness decide fails naming the family.
7. Fusion list: drop one of the 8: the fusion-respect check fails.
8. χ lower bound: remove one witness vertex: the 3-colouring decide flips.
