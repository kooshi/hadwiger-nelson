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
