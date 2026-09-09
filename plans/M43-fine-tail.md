# M43 — The fine-tail campaign: the from-above six-hunt at the open scales
# (SUBPLAN — §0 registered 2026-08-12, laptop, BEFORE any instrument runs.
#  Read order for a fresh session: `plans/M40-chi-omega-hunt.md` WHOLE, `plans/
#  M42-gap-kernel.md` §R (the promotion template), CLAUDE.md § Frontier rows 37/39,
#  G23/G24. The original stub is preserved at the bottom; its scaled-shell
#  parenthetical is CORRECTED by D5 below.)

## The mission

For every scale `p`, a proper colouring of the constraint graph `G(p)` (join two
triangular-lattice addresses when their cells hold a unit pair) IS a proper colouring
of the plane: `χ(ℝ²) ≤ χ(G(p))`. Below the classical window every probed band forces
≥ 7 outright while ω collapses to 3–5 (G24). **Nobody has refuted six on the fine
tail's open scales, and nobody has found a six-colouring** — and a six-colouring of
ANY band is `χ(ℝ²) ≤ 6`. This campaign attacks the sharpest open scale (the 1/7
flanks) and the unprobed regions, with instruments that already exist plus five
bounded extensions. All claims are per-BAND (open T² intervals; boundary scales
belong to no band — M40 A3 standing).

## §0a — Derivations, committed before any instrument (each hand-verified twice)

**D1 — The threshold formulas, closed form.** The difference body H = 2·(Voronoi
cell) is the hexagon with vertices `2·hole_i` (the six points of type (±2/3, ±2/3)),
circumradius 2/√3, inradius 1, edge midpoints the six unit vectors. For an offset
`d = (a,b)`, the polarization against the six H-vertices takes exactly the values
`±2a, ±2b, ±2(a+b)`, and against the six edge-midpoint normals the values are the
same halved. Hence, writing the canonical representative with `0 ≤ a ≤ b`:

  * **depart(a,b)** (= max_H Q(d+w), a vertex of H) `= Q + 2(a+b) + 4/3` — all
    classes, axis included (this is M42's kernel `exists_unit_pair_corner` reach).
  * **arrive(a,b)** (= min_H Q(d+w)):
    - axis class `(0,b)`: the perpendicular foot lands at an H-edge midpoint —
      `arrive = (b−1)²` (so **every integer T is a threshold**: `(0, n+1)` arrives
      at `T² = n²`);
    - interior class `1 ≤ a ≤ b`: the foot leaves the edge segment (the in-segment
      condition is `a ≤ 2/3`), so the minimum is at the nearest H-VERTEX —
      `arrive = Q − 2(a+b) + 4/3`.

  Consistency: reproduces every M40 D1 row, M42's norm-1 (`3/13`) and norm-4
  (`3/28`) kernel windows, and the A1 norm-49 class split ((7,0) arrives 36;
  (3,5) arrives 103/3). Non-axis thresholds are ≡ 1/3 (mod 1); integer thresholds
  are exactly the perfect squares (axis arrivals).

**D2 — The 1/7 flank bands, exact.** All thresholds in T² ∈ (44, 54), from D1 by
exhaustion over canonical classes (two independent hand passes):

| T² | event |
|---|---|
| 133/3 | (1,5) departs AND (4,5) arrives (double event — tool-check row) |
| 139/3 | (3,6) arrives |
| **49** | **(0,8) arrives** (the T = 7 boundary) |
| 148/3 | (0,6) departs |
| 151/3 | (2,7) arrives |
| 157/3 | (3,4) departs |

So the two target bands are:

* **B_lo, the coarse flank**: `T² ∈ (139/3, 49)`, `p ∈ (1/7, √(3/139)) ≈
  (0.14286, 0.14690)`. Edge classes (11): (0,6)₃₆ (3,4)₃₇ (2,5)₃₉ (1,6)₄₃ (4,4)₄₈
  (0,7)₄₉ (3,5)₄₉ (2,6)₅₂ (1,7)₅₇ (4,5)₆₁ (3,6)₆₃. Degree 114 (three orbit-6
  classes, eight orbit-12).
* **B_hi, the fine flank**: `T² ∈ (49, 148/3)`, `p ∈ (√(3/148), 1/7) ≈
  (0.14240, 0.14286)`. Edge classes = B_lo's + **(0,8)₆₄**. Degree 120.

Registered interior probe scales: **T = 48/7** (T² = 2304/49 ≈ 47.02) for B_lo;
**T = 351/50** (T² = 49.2804) for B_hi. Both checked interior; the writer re-checks
at record time (A3).

**D3 — Evidence re-keying, and the transfer order.** The closed-criterion edge set
at T = 7 exactly equals B_hi's class set ((0,8) enters tangentially at min = 49; no
other class is tangent there — non-axis thresholds are ≡ 1/3 and 49's only axis
event is (0,8)). Therefore **all M39/M40 measurements at "p = 1/7" attach to B_hi's
graph**: balls to Q ≤ 225 six-colour (SAT), tori refuse six to period 36
(period-bounded). Since B_lo ⊂ B_hi as edge sets (same vertex set): a B_hi
colouring is a B_lo colouring (SATs transfer down); a B_lo refutation is a B_hi
refutation (UNSATs transfer up). Consequences, both load-bearing for the campaign
order: **the coarse flank has NO torus evidence at all** (checked against the
m39/m40 artifacts at campaign start — an artifact read, not a measurement), making
it the softest known spot in the entire family; and **B_lo is the primary target in
BOTH directions** — a six there is the jackpot outright, and a refutation there
closes both flanks at once. The band-inclusion poset generalizes this: consecutive
bands differ by one class, and every containment is a free transfer edge (I2).

**D4 — ω = 3 on both flanks, and the only pin is a triangle.** Each band's
edge-norm ratio is < 2 (B_lo: 63/36 = 1.75; B_hi: 64/36 = 1.78), so no four points
are pairwise within the band's distance window (the √2 four-point bound, D5/M40),
and A2's associate triangle `{0, u, ζ₆u}` exists for every edge class: **ω = 3
exactly on both flanks** — and on every band with T² ≥ 133/3 (ratio check per band
thereafter; D5's uniform bound covers T² > 45.30 regardless). Explicit registered
triangle for both flanks: **{(0,0), (0,6), (−6,6)}**, all three sides in class
(0,6) (norm 36).

**D5 — The scaled-shell recursion EXHAUSTS at M ∈ {1, 3, 4} (stub corrected).**
A scaled closed shell `z·shell` (7 points, difference classes `z`, `z(1+ζ₆)`, `2z`,
norms M, 3M, 4M with M = Q(z)) is a 7-clique on a band iff the three class windows
overlap. By D1 the binding inequality for non-axis z is `depart(z) > arrive(2z)`,
i.e. `M + 2s + 4/3 > 4M − 4s + 4/3` ⟺ **Q(z) < 2·s(z)** (s = a+b of the canonical
rep), which holds only for z = (1,1); the axis case (0,k) needs `3k² − 6k − 1/3 < 0`,
which holds only for k ≤ 2. So the complete list of scaled-shell 7-clique windows is
z ∈ {1, 1+ζ₆, 2}: the classical window, the √3 window (M39), the M = 4 window (M42)
— **and no others, ever**. Combined with D4: no 7-clique of ANY shape exists on any
band with T² > 45.3. The stub's parenthetical ("the M = k copy at p ≈ 1/(2k)
predicts sevens recur") was WRONG: sevens recur only empirically (the 1/6 flanks,
ω = 3, χ = 7), and every fine-tail seven is a gap seven. Every G24 falsifier stays
armed.

**D6 — Coset sixes are already dead at every scale.** M37's kernel theorem
(`Coset.seven_le_card`): every nearest-point coset colouring, any scale, any
sublattice, any tie-breaking, uses ≥ 7 colours. So the six-hunt is non-coset from
the start; no index-6 sublattice check is needed (and the sevens below the window
are already measured non-coset with trivial stabilizers — the six, if it exists, is
wilder still). The skew-torus sweep (I4) is precisely the widest periodic search
that does not assume coset structure.

**D7 — The pinning ladder, soundness settled here (Kooshi's question, 2026-08-12:
"could we set the colour of a fan to improve speed?").** Ranked, each with its
soundness argument:

1. **Triangle pin** (unit clauses: the D4 triangle gets colours 0,1,2). EXACT both
   ways — any proper colouring palette-permutes onto the pin, so SAT and UNSAT are
   both preserved. Breaks 6·5·4 = 120 of the 720 palette symmetries at k = 6.
   Measured precedent for pins at k = 6: 160× in LRAT lines on the 23-core (there
   with a 4-clique; a triangle buys less, still expected large).
2. **First-occurrence completion.** `_ball_clauses` already carries
   first-occurrence palette breaking (first 40 vertices); combined with the pin it
   breaks the remaining 3! over colours {3,4,5}. Compatible: the pinned triangle
   occupies the first three index slots, colours in first-occurrence order.
3. **The literal fan pin is UNSOUND and is NOT used**: asserting "N(v) sees all six
   colours" is, by A1 (the criticality factorization), equivalent to χ ≥ 7 at v —
   it assumes the conclusion. What IS sound is the fan as a DECOMPOSITION:
   `χ(ball) > 6 ⟺ every 6-colouring of ball − v covers N(v)` (A1, unconditional
   form), so the refutation may be asked as "colour ball − v with N(v) confined to
   five colours" — one vertex smaller, ONE call by palette WLOG (the M32
   `coverage_query` genre). Registered as the alternative encoding if the direct
   ask stalls; agreement of the two encodings on a decided instance is a control.
4. **Colour cube-and-conquer** (the G18 lever, the real escalation): pin the
   triangle, then cube on the colour pattern of a nearby second vertex set (e.g.
   the opposite triangle {(0,0)-adjacent associate at −u}); cubes partition the
   space exactly, run embarrassingly parallel, and the M34 measurement (monolithic
   3600 s cap vs six ~800 s cubes) is the precedent. Deployed only if a flank
   resists both direct and A1-form asks.
5. Geometric lex-leader over the ball's D6 symmetry (≤ 12×) — noted, DEFERRED:
   clause overhead tends to eat the gain; cubes dominate it.

## §0b — Instruments (tools/celllat.py grown in place; all UNTRUSTED)

* **I1 — patch reach fix.** `patch()` still calls `edge_set(T)` at fixed reach 14,
  which starts clipping edge offsets at T ≈ 11 (coords need ≈ 1.155·(T + 1.155)).
  Re-point at `edge_set40` (reach-correct, cached). Planted control: at T = 13 the
  old and new edge sets must DIFFER (the clipped offsets named); at T = 7 they must
  agree exactly.
* **I2 — bands to T² = 84 + the transfer poset.** Extend the decomposition; green
  control: the D2 table reproduced EXACTLY (six thresholds, the 133/3 double
  event, the two flank class sets). New: per-band diff vs the previous band (class
  added/removed) and the containment transfers it implies, recorded in the artifact.
* **I3 — the pin option.** `--pin` on ball and torus probes: unit clauses for the
  D4 triangle (per-band, derived from the band's least edge class — `{0, u, ζ₆u}`),
  composed with the existing first-occurrence breaking per D7.2. Controls: pinned
  vs unpinned agree on one known SAT row (B_hi ball R = 15) and one known UNSAT row
  (the planted red of I5); speedup measured and reported, never assumed.
* **I4 — skew (HNF) tori.** `--colour-hnf T k d1 s d2`: the torus ℤ²/Λ',
  Λ' = ⟨(d1, 0), (s, d2)⟩, 0 ≤ s < d1; edge wrap by HNF reduction. Any
  Λ'-periodic colouring of index I is I×I-rectangular-visible, so skew tori add no
  new EXISTENCE power — they are an efficiency instrument: determinant-I coverage
  at I vertices instead of I². Controls: `(m, 0, n)` reproduces the rectangular
  verdict on a decided row; mass-red k = 4 refused on every skew probe.
* **I5 — the campaign driver.** Per-band: interior rational scale (mediant of the
  band ends, reduced), the ask ladder (ball k = 6 at R ∈ {8, 11, 15, 18, 21};
  rectangular tori m×n ≤ 36; skew determinant sweep 37..96 at short caps), every
  row band-checked at write (A3), UNKNOWN rows recorded as unknown with their caps.
  Planted red: the (52/3, 20)-band ball at T = 259/60, R = 6 (M40's decided
  refutation) must refuse k = 6.
* **I6 — local-search six-finder: DEFERRED** unless CDCL stalls on the SAT side
  (unknown-at-cap on instances suspected satisfiable); if built, it gets its own
  §0-style registration first. Not part of this campaign by default.

## §0c — Registered predictions

* **P1 [high]** — `--bands` reproduces D2 exactly, including the 133/3 double event
  and the 11/12-class flank sets. A discrepancy is an instrument bug OR a hand
  error; either is reported at face value and resolved before any probe runs.
* **P2 [high]** — exhaustive ω = 3 on both flanks (D4), and on every probed band
  with T² > 45.3 thereafter (D5).
* **P3 [medium]** — the coarse flank refuses six on all rectangular tori ≤ 36 and
  all skew determinants ≤ 96 probed. Stated so the SAT branch cannot be over-read:
  ANY six-colouring fires P6's clause verbatim. Prior on six at B_lo: ≈ 0.2 —
  the highest of any known band. The evidence both ways, registered: FOR seven —
  eighteen probed bands all ≥ 7, the nearest resolved siblings (1/6 flanks) are
  χ = 7 at the same ω = 3, and G24's integrality mechanism has appeared everywhere
  probed; FOR six — every previously refuted band died to a SMALL ball (refuting
  cores at |v| ≲ 1.9·T; the 1/6-flank ω = 3 core sits at |v| ≤ √52 ≈ 1.2·T), while
  at 1/7 the balls SAT out to 2.14·T — if the forcing mirrored its siblings, R = 15
  would already have caught it. It has not: either the core is qualitatively
  larger here, or six is colourable.
* **P4 [medium]** — the fine flank's refusal difficulty GROWS with determinant
  (solver-time signal on the skew sweep), consistent with χ ≥ 7 whose obstruction
  needs period > 36; the alternative reading (a big torus SATs) is P6.
* **P5 [medium-high]** — the between-region census (T² ∈ (20, 103/3)): every band
  ≥ 7 outright at modest ball radius (the G24 track record), each with a shrinkable
  core; ω per band in {3, 4, 5}.
* **P6 [low — the jackpot clause, verbatim from M39/M40]** — any k ≤ 6 SAT at any
  scale IS a χ(ℝ²) ≤ 6 candidate: HALT the campaign; re-derive the edge set
  independently; verify the lifted colouring directly against the exact criterion
  in a second encoding; report to Kooshi BEFORE interpretation. Promotion needs the
  plane-properness certificate for cell-constant colourings (M37-sharpness genre),
  priced only if this fires.
* **P7 [low-medium]** — the Exoo-line literature (ε-unit-distance graphs) already
  contains χ ≥ 7 for distance intervals comparable to our 1/6-flank bridge value
  ε = 2p/√3 ≈ 0.19; our bridge corollaries are novel only at finer scales, if at
  all. Checked (WebSearch) BEFORE any interval-distance novelty claim; the check's
  outcome recorded at face value either way.
* **P8 [medium]** — if any ball refuses six on a 1/7 flank (the refutation branch):
  the 1-minimal core has 30–150 vertices, is centre-free (the 117-core motif — the
  ω = 3 forcing lives in an annulus), shows near-rot6 broken orbit structure, and
  promotes same-day through the M42 template (`Instances/Core23/` as the model:
  addresses + norm filter in Lean, `emit_mask.py --colours 6`, Gadget closure over
  the pinned TRIANGLE — D7.1's palette argument, weaker than a 4-clique's, expect
  a larger LRAT).
* **P9 [medium]** — the pin (I3) speeds the flank asks by ≥ 3× on a decided
  instance; the A1-form encoding (D7.3) agrees with the direct ask wherever both
  decide. Neither expectation gates anything; both are measured and reported.

## §0d — Failure clauses (all standing rules, restated as binding here)

* `unknown ≥ cap` is NEVER a verdict — recorded as unknown-with-cap, never as
  refusal; no chromatic claim from a capped row.
* Torus UNSAT is period-bounded only; outright χ claims come from BALLS alone.
* Any k ≤ 6 SAT: the P6 halt-and-verify clause, verbatim, before interpretation.
* Boundary scales (T² at a threshold) belong to no band and are never probed.
* Shrink caps: a core that exceeds its cap reports "≤ size, NOT 1-minimal".
* Any crash, any process: HALT and report to Kooshi (hardware, standing).
* One heavy job at a time; heavy escalations (balls R ≥ 18 at k = 6, skew
  determinants ≥ 48, rectangular > 36) are DESKTOP work — ask which machine with
  the measured wall in hand before provisioning.

## §0e — Deliverables and the kernel line

Artifact `build/m43-finetail.json` (band-keyed rows per A3; schema line naming the
jackpot clause and the caveat split). Explorer: `build/m40-spectrum.html` gains the
new bands/verdicts; the published Gap Atlas artifact is UPDATED at its existing URL,
never re-minted. §R in this file; Frontier close (ledger row, G24 extension or
revision, paths re-ranked). Kernel work only on a find: a refutation promotes
through the M42 template same-day (P8); a six-colouring triggers P6 and only then
prices the properness certificate. Otherwise this milestone ships measurements,
two derivation corrections (D5's exhaustion; the stub's parenthetical), and the
instrument growth — and says so plainly.

## Phases, in execution order

0. **§0 committed** (this document) — then the modeling passes (WORKFLOW step 5).
1. **Instruments + controls** (I1–I5; self-test40 extended with the D2 green
   control and the I1/I5 planted checks; artifact-read confirming the coarse
   flank's torus virginity).
2. **The coarse flank** (T = 48/7): quick torus sweep first (the cheapest
   highest-information ask in the campaign — these are FRESH questions at every
   period), then ball ladder, then skew sweep; pin measurements (P9) ride along.
3. **The fine flank** (T = 351/50): skew determinant sweep 37..96 (the refusals
   stop at 36 today), ball ladder past R = 15; transfers from phase 2 applied
   first.
4. **The between-region census** (T² ∈ (20, 103/3)): bands, ω, quick k = 6/7
   balls per band; escalate only what resists or surprises.
5. **The deep tail** (T² ∈ (148/3, ~84)): band census + quick probes as budget
   allows; honest stopping point recorded.
6. **Exoo pricing** (P7, one WebSearch pass) — before any interval claim.
7. **Close**: artifact, explorer + Gap Atlas update, §R, Frontier.

## §0f — Domain-modeling pass (2026-08-12, applied BEFORE any instrument; amendments
## only sharpen §0a–e — two of them are soundness catches)

* **A1 — Measurements and inferences never share a row.** The unit of claim stays
  the band (a verdict is a fact about one fixed graph), and the transfer poset is a
  DERIVED layer: artifact rows record measurements only; propagated verdicts live in
  a separate `transfers` section, each entry (from_band, to_band, reason: subset),
  recomputed from the band table — never stored as if measured. Otherwise a later
  instrument correction leaves orphaned copies of a retracted verdict, silently.
  Caveat sharpened while checking D3: consecutive bands are comparable only across a
  SINGLE-event threshold; at a double event (133/3: one arrival AND one departure)
  the neighbours are incomparable. The flank pair crosses the pure arrival at 49, so
  B_lo ⊂ B_hi stands.
* **A2 — The probe scale is a coordinate, not a claim.** Any interior rational gives
  the same graph, so rows key on the band id (exact T² interval + canonical class
  reps, per M40 A3) with the probe T recorded as provenance. The registered flank
  scales (48/7, 351/50) stand; for the bulk census phases the driver derives the
  scale canonically (smallest-denominator rational T with T² interior), so two
  sessions probing one band produce comparable rows by construction.
* **A3a — SOUNDNESS CATCH: the pin and first-occurrence breaking do not compose
  freely.** The standing `break_sym` clauses force colours to open in index order;
  a triangle pinned to (0,1,2) at arbitrary positions can contradict that order and
  turn a SAT instance UNSAT. Sound composition: the pinned triangle must be
  pts[0..2] IN pin-colour order — then any proper colouring palette-permutes onto
  the pin and the remaining colours first-occurrence-relabel over later vertices.
  I3 therefore reorders pts to put the triangle at the head. Self-test planted red:
  K3 pinned to colours (1,2,0) in position order under break_sym must come back
  UNSAT (the unsound composition seen failing on a 3-colourable graph), and the
  head-ordered pin must stay SAT.
* **A3b — SOUNDNESS CATCH: the A1-form encoding cannot carry the triangle pin or
  full first-occurrence.** "N(v) omits SOME colour" is WLOG-reduced to "omits
  colour 5" by a transposition — which the pin and a full precedence chain both
  break. Exact form: delete v, forbid colour 5 on N(v), first-occurrence breaking
  over colours 0..4 only (colour 5 outside the chain), NO pin. Its UNSAT ⟺ the
  direct ask's UNSAT is A1 unconditional (M34 `not_colorable_iff_covers` — no
  colourability side condition; vacuous case agrees). Control: agreement with the
  direct encoding on one decided SAT and one decided UNSAT instance.
* **A4 — Degeneracy hazard: a torus can swallow an edge offset.** If any edge
  offset lies IN the period lattice Λ', the quotient has a self-loop and every
  UNSAT from it is a triviality, not evidence (rectangular is not immune: 6×36 at
  the flanks contains the edge offset (6,0)). `--colour-hnf` and the rectangular
  driver check `offset ∈ Λ'` exactly for every edge offset and REFUSE degenerate
  tori, recording them as skipped-degenerate. Planted control: ⟨(37,0),(0,1)⟩ at
  the flanks must be refused (it contains (0,6)).
* **A5 — Row self-sufficiency.** Each row carries: band id (exact T² endpoints as
  strings + canonical classes), object (kind + params), ask (k, encoding
  direct/a1-form, pin spec or none, break spec), verdict ∈ {sat, unsat, unknown}
  with **claim_scope explicit** (`outright` for balls, `period-bounded` for tori,
  `none` for unknown), cap, seconds, solver, probe T, date. A future session
  re-derives everything from the row: band bounds from the classes via D1, the
  edge set from the probe T. The illegal reading (torus UNSAT quoted as χ) is made
  unrepresentable by the claim_scope vocabulary rather than guarded by prose.
* **A6 — The other two passes, decided with reasons**: obligation-modeling SKIPPED
  (nothing is proven in Lean this milestone unless a find fires, and the promotion
  path's obligations are the already-modeled M42 template); experience-modeling
  SKIPPED (no lemma API, notation, or diagnostic surface is minted; artifact and
  explorer follow standing schemas).

---

# §R — Results (2026-08-12, laptop, 12 cores; every verdict at face value;
# artifact `build/m43-finetail.json`)

**The headline: the sharpest open scale is CLOSED — χ = 7 exactly on both 1/7 flank
bands, the refutation double-encoded, and the entire fine tail probed this campaign
reads ≥ 7 outright wherever a verdict landed.** And the from-above six-door is closed
twice over: the campaign's own refutation at 1/7, and an external theorem (found by
the registered P7 literature check) that conditionally forces ≥ 7 on the WHOLE cell
family at every scale.

## The 1/7 flanks (phases 2–3)

* **The coarse flank B_lo (T² ∈ (139/3, 49), probe T = 48/7) refuses six colours
  OUTRIGHT**: pinned balls at R = 9, 10, 11, 12, 13, 14, 15, 18, 21 ALL UNSAT
  (57–105 s each); minimal refuting radius **R\* = 9 — 301 vertices** (R = 8 is SAT
  by transfer from the fine flank's R = 8 SAT). Double-encoding: the **A1
  centre-deletion form refutes the R = 9 ball independently** (no pin, different
  symmetry breaking, 2,028 s) — the M33 "double-encoded" standard met at the ball
  level before any kernel step.
* **The fine flank B_hi follows by inclusion** (same vertex set, superset edges), and
  M39's 24×24 torus seven-colouring at closed T = 7 (= B_hi's class set) restricts
  down to B_lo: **χ = 7 exactly on both flanks.** ω = 3 on both (P2 ✓).
* **No periodic six-colouring with period-lattice index ≤ 96 exists on either
  flank**: the exhaustive HNF sweep — ALL 7,624 sublattices per flank, k = 6 —
  returned degenerate-or-UNSAT with ZERO unknown, mass-red k = 4 control green
  (P3 ✓). Below det 24 every lattice is degenerate (swallows an edge offset).
* Pin economics (P9 ✓): the D4 triangle pin decides the R = 15 ball in 57 s where
  break-only, raw, and clipped variants ALL cap out at 2,400 s — worth ≥ 42× here;
  0.13 s vs 1.49 s on the small decided control.

## The controls story (G21 hygiene, both directions)

* My five unpinned control encodings on the big balls returned UNKNOWN at cap —
  not one confirmed and not one refuted the pinned verdicts; the pin composition's
  soundness rests on the A3a derivation (re-verified during the campaign: relabel
  onto the pinned triangle, then first-occurrence over the remaining colours) plus
  the two-sided agreement controls, and the second-encoding confirmation was moved
  to where instances decide: the a1-form at R = 9 (green, above) and the kernel
  chain (below).
* **The registered evidence-for-six was an artifact of my own misreading**: M39/M40's
  "balls to 225 six-colour" at T = 7 means 225 VERTICES (radius parameter 8, |v| ≤ 8
  ≈ 1.14·T, SAT in 0.08 s) — not Q-radius 225. Nobody had ever asked R ≥ 9 at 1/7.
  P3's registered prior reasoning ("if the forcing mirrored the siblings, R = 15
  would have caught it") was built on that misreading — and the siblings' scale law
  (refuting cores at 1.2–1.9·T) is exactly where the refutation landed (1.31·T).
* Two instrument catches by the new self-test before any campaign row: the K3
  planted red I registered was itself wrong ((1,2,0) satisfies the staircase; the
  true conflict is (0,2,1)); and my first ball builder CLIPPED the hex Q-ball with a
  square box — the same G21 shape as M39's reach clipping, caught in-house. The
  M39-era `patch`/`shrink` ball builders had the same clip (their UNSATs remain
  sound — a subset refuting suffices — their SAT frontiers described the clipped
  object); both fixed.

## The censuses (phases 4–5)

* **Between-region (T² ∈ (20, 103/3)), ten bands, ALL ≥ 7 outright** (ball
  UNSATs at R ≈ 1.9·T, k = 7 balls SAT): ω = 4, 4 then 3 on the eight finer bands —
  the ω-collapse arrives by T² ≈ 67/3, far earlier than D5's uniform bound. P5 ✓.
* **Deep tail (T² ∈ (148/3, 84), p down to ≈ 0.109), twenty-one bands**: ω = 3 on
  every one, k = 7 balls SAT on every one (no ≥ 8 pocket down there), and k = 6:
  three more bands ≥ 7 OUTRIGHT; eighteen returned honest unknowns at cap 600
  (recorded as unknowns, per §0d) — escalation round at cap 2,400 run (results in
  the artifact; whatever remains unknown is the recorded stopping point).

## P7: the literature check fired, and it rewrites the campaign's meaning

* **Voronov, arXiv:2304.10163 (2023, rev. 2025-04): the Exoo conjecture is proven —
  every closed interval [1−ε, 1+ε] of forbidden distances needs ≥ 7 colours, for
  ARBITRARY ε > 0, in the Euclidean and any Minkowski plane.** (External preprint;
  unverified by our standards; method not stated in the abstract.)
* **Derived consequence (this campaign's §R, checked twice):** any proper
  six-colouring of ANY G(p) with p < √3/2 would be a plane colouring whose
  same-colour distance set misses a whole closed interval around 1 — intra-cell
  distances stay ≤ 2p/√3 < 1, and the finitely many cross-cell offset windows near 1
  are closed sets not containing 1, so a positive gap δ exists — properly
  6-colouring Voronov's G_{δ/2}. Contradiction. **Conditional on [Voronov2023]:
  χ(G(p)) ≥ 7 for the ENTIRE cell family, every band, all the way down** — G23/G24's
  "why is every band ≥ 7" has a conditional explanation, and by de Bruijn–Erdős
  compactness every band owns a finite refuting ball. Our refutations are the
  finite, exact, kernel-checkable certificates of that fact — the currency the
  continuum proof does not produce.
* **Parts, arXiv:2303.14722: "islands of certainty" with exact interval-χ values
  {7, 8, 9, 12, 13} and 10/11 unknown** — matching our band atlas's measured values
  {7, 8-pocket, 9, 12} with no 10/11 band found. The two atlases are cousin
  coordinatizations of the same phenomenon; his exact-value islands are a standing
  cross-reference for our open pocket upper bound (χ ∈ [8, 16]).
* The D8 interval-distance bridge is fully subsumed (χ_ε ≥ 7 ∀ε beats every bridge
  corollary we could mint); no novelty claim is made for it, as registered.

## The core, the autopsy, and the kernel (P8 — reported UNMET, with the measurement)

* **The 1-minimal core: 160 vertices, 2,978 edges, 24 point-group orbits, centre-ful**
  (the 1/6 flank's ω = 3 core was centre-free — the annulus motif does NOT recur),
  every vertex necessity-witnessed, most orbits partial (11-of-12, 5-of-6: the same
  broken near-symmetry as the 23-core and de Grey's 122-core). Its edges were
  **re-derived two independent ways** — the exact interval criterion computed fresh per
  pair, and the ten-norm filter {36,37,39,43,48,49,52,57,61,63} — 2,978 both, identical
  pair lists, and the norm filter is exactly sound on this band (every offset of an edge
  norm is an edge; 114 offsets).
* **P8's shape prediction was WRONG in both halves it could be scored on** (registered:
  30–150 vertices, centre-free): the core is 160 and it keeps its centre.
* **THE AUTOPSY: the 1/7 seven-forcing does NOT factor as pigeonhole × kill.** Act One is
  free by counting (the closed shell's 7 addresses have all 21 mutual offsets at norms
  {1,3,4}, none of them edges here, so six colours force a repeat) — but **Act Two does
  not exist**: on the LARGEST 6-colourable stage (the R = 8 ball, 241 vertices — more
  material than the whole core), forcing a pair to share a colour is satisfiable at
  EVERY small non-edge class (norms 1, 3, 4, 7, 9, 12; all decided in under a second),
  and likewise at R = 5 and R = 7. Equivalently: **zero virtual edges at k = 6 on the
  largest colourable stage** — the from-above echo of M41's 0/40 flat verdict from below.
  **This is the falsifier G26 registered and never found in five cores**: the first
  clique-free forcer in the family that refuses the factorization. The compulsion here is
  not pair-mediated; it is genuinely global over ~160 vertices — which is what "carried by
  integrality" had been asserting, now measured as an absence rather than inferred from a
  relaxation gap. Scope stated honestly: balls centred on the pair up to 241 vertices, the
  six smallest non-edge classes.
* **The relaxation collapse extends and deepens**: the certified Hoffman bracket at the
  coarse flank is **χ ≥ 3.56** (degree 114, λ_min ∈ [−44.4937, −44.4737], converged
  246,635 boxes) against the truth 7 — below even G\*'s 4.09. Every standard bound is now
  measured low at the fine tail too.
* **Kernel promotion: PRICED AND DEFERRED — the registered same-day clause is UNMET, and
  this is the honest report.** The pinned formula (960 vars, 18,031 clauses) refutes
  monolithically in **462 s**, so the search is cheap; the *certificate* is not — proof
  logging passed **196 MB in 90 s** and was killed. Cube-and-conquer works and the kernel
  side needs no new machinery (the M34 Gadget algebra composes one `ofUnsat` per surviving
  port pattern): one extra pinned vertex splits 462 s into 249.5 + 31.3 + 0.1 + 0.0 s, and
  a second splits the 31.3 s branch into 19.5 + 3.9 + 1.3 + 0.0 + 0.0 s. But the budget
  comparison is decisive, and it is now exact rather than extrapolated: **one MEDIUM cube
  (the 31 s branch) logs 798,002 LRAT lines / 62 MB** — sixty-three times the ENTIRE
  122-core certificate (12,578 lines, 7,892 derived clauses) and 3,600× the 23-core's 219.
  The full depth-1 tree is ~10⁷ lines / ~600 MB. This is an M06-scale certificate build
  (GB of module data, tens of hours of elaboration), not a same-day step.
  **Recommendation: do not spend it.** The statement it would certify is (i) conditionally
  implied by a published theorem [Voronov2023], (ii) not a rung toward χ ≥ 6, and (iii) below
  the standing publication bar. The template stays proven and ready (M42) for a target
  that earns it.

## The predictions, scored

* **P1 CONFIRMED** — `--bands` reproduced the hand-derived D2 table exactly, including the
  133/3 double event and both flank class sets.
* **P2 CONFIRMED** — ω = 3 exhaustively on both flanks, and on every band probed below
  T² ≈ 67/3 (the collapse arrives EARLIER than D5's uniform bound predicted: ω = 4 persists
  only to T² ≈ 64/3).
* **P3 CONFIRMED, and then some** — no six-colouring on any of 7,624 period lattices per
  flank (index ≤ 96, zero unknown); and the band refuses six OUTRIGHT, which the prediction
  did not dare. The registered prior (0.2 on six) was built on my own misreading of M39's
  "balls to 225" (that is 225 VERTICES, radius 8 ≈ 1.14·T — nobody had asked R ≥ 9); the
  sibling scale law in the same paragraph called it correctly at 1.31·T.
* **P4 not scored** — the refutation landed before the determinant-difficulty trend
  mattered.
* **P5 CONFIRMED** — all ten between-region bands ≥ 7 outright, ω ∈ {3,4}.
* **P6 never fired** — no k ≤ 6 SAT anywhere; the mass-red k = 4 control green on every
  sweep.
* **P7 DELIVERED, and it reframes the milestone** — the literature check found the Exoo
  conjecture PROVEN (Voronov), which conditionally forces ≥ 7 on the entire family.
* **P8 WRONG on shape, UNMET on the same-day promotion** — reported above with the numbers.
* **P9 CONFIRMED emphatically** — the pin is worth ≥ 42× on the flank balls (57 s vs
  2,400 s cap) and 11.5× on the small decided control; the a1-form agreed with the direct
  ask wherever both decided (one SAT row, two UNSAT rows).

## What was NOT done (honesty ledger)

* **Twelve deep-tail bands remain honestly unknown at cap** (k = 6, cap 2,400 s, R ≈ 1.9·T):
  T² ∈ (163/3, 169/3), (175/3, 181/3), and ten bands above 199/3. They are unknown, not
  refuted, and the transfer closure adds nothing (deep-tail bands are not nested — each
  threshold both adds and drops classes, so the free-lift lever only worked at the flank
  pair's pure arrival).
* The k = 8 question at the deep pocket is untouched (M40's χ ∈ [8,16] stands).
* No kernel work landed this milestone; nothing is claimed kernel-side.
* [Voronov2023] and [Parts2023] are external preprints, unverified by this project's standards;
  every consequence drawn from them is labelled conditional.
  **AMENDED 2026-09-09 (bibliography key audit; the milestone's verdict at its close is left as written).**
  Two updates for a later reader: `[Voronov2023]` was **read and verified** at FS-18 on 2026-09-08 — its
  Theorem 1.1 is proved non-computationally — so the conditional it carried is **discharged** and the cell
  family's `≥ 7` at every scale is unconditional (`CLAUDE.md` ledger row 40, G24/G29). `[Parts2023]` is
  arXiv:2303.14722, **held and still unread**; it was cited here under a key that did not exist in
  `BIBLIOGRAPHY.md` until the audit defined it, and anything resting on it stays conditional.

---

# THE ORIGINAL STUB (2026-08-12, M42 close — kept per deprecate-never-delete;
# its scaled-shell parenthetical is corrected by §0a D5 above)

## The mission, in plain language

For every scale `p`, a proper colouring of the constraint graph `G(p)` (join two
triangular-lattice addresses when their cells hold a unit pair) IS a proper colouring
of the plane: `χ(ℝ²) ≤ χ(G(p))`. M39–M40 mapped the family: sevens in the classical
window, twelve then nine just below it, sevens forced WITHOUT cliques all the way down
to `p = 0.2236` (G24). **Nobody has ever refuted six on the fine tail's open scales,
and nobody has found a six-colouring** — and any six-colouring of ANY band is
`χ(ℝ²) ≤ 6`, new mathematics of the first order. This campaign attacks the two open
regions directly, with instruments that already exist.

## The target list, ranked (M40's measured verdicts)

1. **The `p = 1/7` region** — the sharpest open scale. Measured: ω = 3 (the plane's
   own clique number), balls to radius 225 remain **six-colourable** (SAT), tori
   refuse six only to period 36 (UNSAT — period-bounded, NEVER a chromatic claim).
   Undecided in BOTH directions, with signals both ways. CAUTION (M40 band re-keying):
   `T = 7` is itself a threshold scale — every integer `T` is, since the `(n+1, 0)`
   class arrives at `T² = n²` — so "p = 1/7" means the FLANKING BANDS, keyed by
   point-group class, not the boundary scale; run the band decomposition first and
   name the band intervals exactly (the 1/6 flanks came out ω = 3, χ = 7 — gap four;
   the 1/7 flanks are the open siblings).
2. **The unprobed tail below `p = 0.2236`** — no census at all: band decomposition,
   exhaustive ω, ball χ probes per band. The scaled-shell recursion (the M = k copy of
   the closed shell at `p ≈ 1/(2k)`-ish windows) predicts sevens RECUR; between those
   windows the six-question is open at every band.

## The two outcomes, and what each costs

* **Refutation** (a ball at some radius refuses k = 6): `χ(G(p)) ≥ 7` OUTRIGHT for
  that band — the last fine-tail door closes, G24 extends, and the result promotes
  same-day through the **M42 template**: derive the ball's edges in Lean from
  addresses + the norm filter (`Instances/Core23/Edges.lean` is the model), emit CNF
  from Lean (`scripts/Dimacs.lean`), `tools/emit_mask.py --colours 6`, Gadget palette
  closure over any clique (ω = 3 here — pin a triangle, expect the palette lever to be
  weaker: measured 160× at the 23-core's 4-clique; Mycielski's edge pin was 26×).
  1-minimal shrink (`tools/celllat.py --shrink`) before certifying.
* **A six-colouring** (SAT on a torus or any periodic/aperiodic scheme): this is the
  standing JACKPOT clause — **χ(ℝ²) ≤ 6 candidate. HALT AND VERIFY**: independent
  re-derivation of the edge set, a second encoding checking the colouring directly,
  report to Kooshi BEFORE interpretation. Promotion needs a plane-properness
  certificate for cell-constant colourings (the M37-sharpness-style covering-radius
  argument — necessity of the band criterion — which M42 deliberately did NOT build;
  price it only if a colouring is found).

## Instruments (all standing, `tools/celllat.py` M40 suite)

Class-keyed band decomposition (`bands`), exact `edge_reach`, exhaustive
`max_clique40` (cap ≥ 13), ball SAT probes at k = 6 with radius escalation, torus
probes with Sinz exact-α machinery, batched 1-minimal shrink with necessity
certificates, colouring anatomy (stabilizer/coset tests — the witnesses' structure if
one appears). Multicore per the standing rule (threads within a tool run, RAM the only
hazard). Bigger tori (periods 42–72) and deep balls may want the DESKTOP — ask which
machine before believing core counts; timings never compared across machines.

## Registered-prediction discipline (write §0 BEFORE running)

Predictions to register at subplan time, at minimum: (i) the 1/7 flank bands' exact
intervals and class keys, hand-derived from D1-style threshold arithmetic; (ii) an ω
prediction per band; (iii) a prior on six per band with the evidence both ways stated;
(iv) the failure clauses — `unknown ≥ cap` is never a verdict, torus UNSAT is
period-bounded only, any SAT six-colouring fires the halt-and-verify clause verbatim.
Acceptance criteria must be exact (necessary AND sufficient) — G21 discipline, stated
at registration.

## Also in scope, priced before claimed

* **The interval-distance bridge**: `χ_{[1−ε,1+ε]}(ℝ²) ≥ χ(G(p))` at `ε = 2p/√3` —
  before ANY novelty claim about interval-distance chromatic numbers, check the Exoo
  line of literature (Exoo's ε-unit-distance graphs; also Grytczuk et al.) — the
  bridge may already be beaten by known interval results.
* The explorer (`build/m40-spectrum.html`, artifact "The Gap Atlas" 🔺) gains the new
  bands/verdicts — update, never re-mint.

## Why this is worth a milestone

It is the highest-expected-information experiment the from-above direction owns: every
outcome moves the map (a refutation closes the sharpest open scale and extends the gap
law; a six-colouring is the result). The alternation discipline (Kooshi, 2026-08-12:
"attack from both directions, narrowing the cuts") has the from-below thread parked
with its reduction sharp (G26: one k = 5 gadget closes χ ≥ 6); this is the from-above
thrust that either finds the entry or proves the fine tail is all sevens.
