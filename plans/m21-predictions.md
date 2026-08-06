# M21 §0 — pre-registered predictions (written 2026-08-05, BEFORE any measurement)

Machine: desktop (32 cores, 125 GB). Closure: Z3-closure-dg630x1/3, n=4678, 24405 edges
(identity from the M20 profile artifact — not a measurement of this §0).

## §0-A — the coupling census

Definitions fixed in advance. Pivot: closure vertex with a nonempty 1/3-class. Cover set
S_p = N(p) ∪ C(p) (M18's object). Coupling weight of an unordered pivot pair {a,b}: the
number of (edge, orientation) incidences — for each closure edge (u,v), one count for each
(x,y) ∈ P(u)×P(v) with {x,y}={a,b}, x≠y, where P(w) = {pivots p : w ∈ S_p}. Far pair:
S_a ∩ S_b = ∅.

* **A1** — the d² spectrum of coupled pairs is concentrated: ≥ 60% of total coupling weight
  sits on ≤ 10 exact d² values (the construction's own step distances), with a long thin tail.
* **A2** — the maximum coupling weight over ALL pairs is attained at an overlapping (near)
  pair with d² ∈ {1/3, 1}; the maximum over FAR pairs is ≥ 8 and < half the near maximum.
* **A3** — d² = 1/3 and d² = 1 are among the top-3 d² classes by total weight.
* **A4** — pivot count for this closure: between 1,000 and 4,678; point estimate ~3,000.

Decision rule (registered): the Lean classification target d is the d² class maximizing FAR-pair
total coupling weight, tie-broken by smaller field support of d².

## §0-C — the periodicity probe

For a pivot pair (p,q) let u² = (q−p)²/d² (complex, exact in the field — no square root
needed; finite order of u ⟺ finite order of u²). Search multiplicative relations
u^{2m}·σ^l·ζ₆^k = 1 with σ the M19 seam, |m| ≤ 6, |l| ≤ 6, k ∈ 0..5, (m,l) ≠ (0,0) or k ≠ 0.

* **C1** — for unit-distance pivot pairs (d² = 1), a relation IS found for at least some pairs
  (edge directions are construction-lattice words).
* **C2** — for the strongest-coupled FAR pair, NO relation up to the bound: the two strips are
  incommensurate; the naive finite-state coupled automaton fails. Confidence: medium.
* **C3** — among the top-10 d² classes, at most half have d² a perfect square in the field
  (d itself in the field); most phases need the u² trick even to state.

## §0-B — the 2-pivot joint profile

At the strongest-coupled far pair (per A's decision rule) and a null control pair (zero
coupling weight, comparable |S| and d): sample ~1,500 jointly-locally-legal pattern pairs
(π_p on S_p, π_q on S_q, each ≤ 3 colours, no conflict on cross chords or shared vertices),
one SAT call each with both pin sets, k = 5, 60 s budget.

* **B1** — ZERO joint kills at k = 5, at both the coupled pair and the null pair; no-verdict
  residue reported and never folded; time-to-verdict distributions of coupled vs null pair not
  significantly different. (Every ambient-pressure measurement so far has been flat; the cap
  theorem says one pivot cannot generate pressure, and closure-scale cross chords are sparse.)
* **B2** — controls: at k = 3 every sampled pattern pair is KILLED (the closure contains M20's
  4-chromatic one-pivot systems, so k = 3 is unsatisfiable regardless of pins) — validates the
  kill path end to end; a deliberately cross-chord-conflicting pattern pair is REFUSED by the
  local-legality check before any SAT call.

Registered interpretation: a genuine joint kill at k = 5 would be the milestone's headline
measurement and must be re-verified (fresh UNSAT re-run, then queued for the kernel route)
before being called a finding. A flat B1 + no-relation C2 + weak-far-coupling A2 together do
NOT close the thread: they say closure-scale sampling is too sparse, and the milestone's Lean
target (the cross-chord classification + the coupling-seam identity at the chosen d) proceeds
on the exact geometry, where the full circles — not the sample — carry the coupling.

## §0-D — the pair-system chromatic probe at d = 1  *(registered 2026-08-05 after §0-A's
census named d² = 1 the strongest far coupling, BEFORE any §0-D code was written or run)*

The census made the unit-distance pivot pair the canonical coupled object (strongest far
coupling, 40 cross chords at closure scale; each pivot lies on the other's outer circle; the
whole system lives in the seam field ℚ(√3,√11) — the four circle-intersection points are
1/2 ± i√3/2, 5/6 ± i√11/6, 1/6 ± i√33/18-family, all seam-field). The probe: generate both
pivots' chord lattices exactly (ζ₆ steps on outers, ω steps on inners, seam maps, bounded
word length, exact ℚ(√3,√11,i) arithmetic), take every exact unit pair (float prefilter,
exact confirm), include the cap's 9-point witness in each system, and ask SAT for k = 4.

* **D1** — the finite pair samples stay 4-colourable (SAT at k = 4) at every word-length
  budget we can afford. Confidence: LOW-MEDIUM — this is the first measurement of the
  milestone with a live chance of going the other way (the d = 1 interlock is strong: each
  centre is a vertex ON the partner's outer circle). Registered branch: UNSAT would be a
  candidate χ ≥ 5 continuum-family witness far smaller than de Grey's graph — re-verify,
  shrink, and take it to the kernel route immediately; SAT keeps the two-pivot-cap
  conjecture (χ(pair system) = 4) as the milestone's Lean centerpiece.
* **D2** — if SAT, the extracted model is NOT a pair of 60°-sector colourings (the solver
  will produce something unstructured); whether sector colourings CAN mesh at d = 1 is then
  a separate finite check worth doing exactly, since a meshing sector pair would be the
  constructive upper-bound proof shape. Confidence: low (structure inspection, not a bet).
* **D3** — control: the same builder at k = 3 is UNSAT (each half contains the cap's
  9-point witness, which is not 3-colourable), watched failing.
