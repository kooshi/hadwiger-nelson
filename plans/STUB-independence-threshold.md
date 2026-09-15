# FS-50 — The independence number at the threshold: does UD(𝔽₈₃, 2) have an independent set of 1,149 points? — the first digit's certificate, at 83 and at 23 (STUB, 2026-09-14; minted by the product owner after FS-40's phases A and A′; Kooshi: the next instrument, to be subplanned by the workflow)

*Read beside: `plans/STUB-first-digit-83.md` (FS-40: what phases A and A′ found on 2026-09-14 and why the digit continues here),
`plans/STUB-first-digit-23.md` (FS-17: the same question one colour down, whose certificate side this stub takes over),
`data/fplane/README.md` (the records of the day: the equivariant censuses, the local-search plateau), `data/fplane/alpha-p{11,19,23}.json`
(the independence ladder M61 measured), `~/source/descent-engine/plans/WO-18-independent-set.md` (the Rust engineer's design
for the finding side, cut out of WO-17), `~/source/descent-engine/crates/plane-colour/` (the colourer, its controls, its
record format); `CLAUDE.md` G44 (Kloosterman control), G48 (the conjecture and its predictions), G54 (tight or slack), row 56
(`card_le_mul_of_colorable`, the kernel consumer), row 53 (the finite-plane bound); `plans/M63-phaseH2-solver.md` (the
cube-and-conquer pipeline with proof logs).*

## 1. Mission context, in plain language

The finite Euclidean plane UD(𝔽₈₃, 2) — 6,889 points, each joined to the 84 at unit quadrance — is the first residue plane
of the 6-open field ℚ(√3,√7,√11) in which this project built its own five-chromatic object (row 64). Its chromatic number is
at least 6 by the spectrum, and whether it is exactly 6 decides what the local–global conjecture (G48) predicts for that
field: 6 if the plane is six-colourable, 7 otherwise (every other usable prime of the field has a floor of 8 or more). On
2026-09-14 the cheap checks were run (FS-40 phases A and A′): the symmetric census refused 59 of 63 rotation classes and left
four undecided at the budget in both formulations; the Rust local-search colourer, on the whole plane and on the three minimal
symmetric quotients, plateaued at ≈ 6% monochromatic edges within seconds and never moved. **No six-colouring was found, and
nothing was decided.** A local search exhibits or does not; a symmetric family's absence proves nothing about the digit.

What the colourer's best assignment showed is the shape of the next question. Its six classes were already balanced at
≈ 1,150 vertices — 95.7% of the largest independent set the spectrum permits (Hoffman's ratio bound: α ≤ 1,199.46) — and each
carried about five same-class neighbours per vertex. A six-colouring is six independent sets covering 6,889 points, so
**it needs an independent set of at least ⌈6,889/6⌉ = 1,149 points** (`card_le_mul_of_colorable`, kernel, row 56). The
obstruction the search hit was not the partition but that sets of that size in this graph are not independent. So the
digit's question reduces, in its necessary half, to one number:

> **Is α(UD(𝔽₈₃, 2)) ≥ 1,149?** If not, χ(UD(𝔽₈₃, 2)) ≥ 7, the field's local bound is 7, and the conjecture predicts
> χ(ℚ(√3,√7,√11)²) = 7 — its boldest form, at the one 6-open field we hold an object in.

Two instruments, for the two sides. **Finding** an independent set of 1,149 (evidence the condition is met; the object is
then the seed for a colouring search, and nothing is decided): the engineer's WO-18, a multi-threaded local search for one
large independent set, the better-conditioned question — one set, one objective. **Certifying** α ≤ 1,148 (a proof that six
is impossible): exact combinatorial search with symmetry breaking and proof logs, because **every relaxation is blind** — ϑ,
Schrijver's ϑ′ and Hoffman coincide at 83 to ten decimals (`fplane.py theta`, 2026-09-14: 1199.459 all three, as at 11, 19
and 23), so no LP or SDP over the scheme can drop below 1,199, and the 51-vertex gap to 1,148 is closed only by search. The
calibration bed is **the same question at 23 for five colours**: α ≥ 106 needed, Hoffman 131.8, the lower bound 69 (three
null lines), size 106 **undecided at a two-hour wall** in M61 (`alpha-p23.json`) — FS-17's certificate side, which this stub
takes over, so that whatever decides 23 either scales to 83 or shows why not.

**How loose is the ratio bound on these planes?** At 11, α = 28 exactly (SAT and a refusal) against Hoffman 34.55 — loose
by 19%; at 19, α ≥ 76 against 99.5; at 23, α ∈ [69, 131]. If the looseness at 11 held at 83, α would be ≈ 970, far below
1,149. That is the reading behind P1, and it is a reading.

## 2. What we know

| fact | trust | where |
|---|---|---|
| a k-colouring needs α ≥ ⌈n/k⌉ | **kernel** | `card_le_mul_of_colorable`, `card_le_chromaticNumber_mul_indepNum` (row 56) |
| Hoffman: α(83) ≤ 1,199.46; the floor 6 | derived on exact character sums, floats to 1e-12 | `spectral-p83.json` |
| ϑ = ϑ′ = Hoffman at 11, 19, 23, 83 (float LP) | computed 2026-09-14 (`fplane.py theta --below 84`) | this stub; row 56's "ϑ = Hoffman at eleven primes" |
| α(11) = 28; α(19) ≥ 76; α(23) ∈ [87, 131] (the engineer's WO-18 planning prototype, 2026-09-14, re-verified: `data/fs50/alpha-p23-ge87.json`), 106 undecided at 7,200 s | verified sets; the solver's refusal at 11 | `alpha-p11/19/23.json`, `data/fs50/` |
| greedy independent set at 83: 358 over 25 orders (≈ a random 84-regular graph's 363); **the engineer's planning ladder (2026-09-14, one core): plane local search 492 in 30 s; rotation quotients exhausted at orders 84 / 42 / 28 = 505 / 589 / 533 exactly (origin included), the ladder peaking at 588–589 at orders 14, 21, 42; the line quotient exhausted at 7 × 83 = 581 — the best set held is 589, 49% of the ratio bound, against 66–81% at 11, 19, 23 where the search is near exact** | the engineer's measurements, the 490- and 87-point sets re-verified here | `WO-18-independent-set.md` §2.2 |
| **WO-18 shipped (2026-09-14, `plane-independent`, gate green): α(UD(𝔽₈₃,2)) ≥ 597** by the chain (the order-6 quotient's 595-point set through `--start` into the plane search, 16 threads); the whole plane alone plateaus at 574 in 600 s; the target 1,149 `not_found`; at 23 the target 106 `not_found` at 87; every symmetric rung beat the free search; the per-thread spread widens to 75 points over a run (a portfolio is the cheapest next gain, the engineer's D85) | 46 records, every set re-verified here from the definition | `data/fs50/wo18/`, `~/source/descent-engine/plans/WO-18-outcome.md` |
| the colourer's best six classes: 1,128–1,174 vertices, same-class degree 4.7–5.3 | [C], re-verified here | `plane-colour-p83-k6.json` |
| no six-colouring with a rotational symmetry outside four open classes; none found by local search on the whole plane or the three minimal quotients | the solver's refusals; "not found" | `equivariant-p83-k6*.json`, `plane-colour-p83-k6*.json` |
| 42 independent lines of 83 points (directions of non-residue norm) | derived | `WO-18-independent-set.md` |
| the automorphism group holds the translations (p²), the rotations (p+1) and a reflection: order ≥ 2p²(p+1) = 1,157,352 at 83, 25,392 at 23 | derived (`PlaneRotation.lean` for the rotations) | row 60 |

## 3. Derivations first (G46: name the object in its discipline)

**D1 — the object.** An independent set of UD(𝔽_p, 2) is a subset of the finite plane avoiding one quadrance — the
single-distance case of the finite-field distance problem. The prior-art gate searches that literature by its own names:
"sets avoiding a distance in 𝔽_q²", "independence number of the finite Euclidean graph", "unit-distance graph over finite
fields", the Iosevich–Rudnev distance theorem and its two-dimensional sharpenings (a set of size ≫ q^{3/2} determines every
distance — weaker than Hoffman here; whether anything sharper is known for one distance in dimension two is the question),
`[Vinh2006]`, `[Krebs2022]`, `[SchneiderSilva2013]`, and the Delsarte–Schrijver bounds (`[Delsarte1973]`, `[Lovasz1979]`) to
confirm the blindness is known rather than measured.

**D2 — the symmetry, and what it buys a refutation.** The cardinality instance "an independent set of size ≥ N" carries the
full automorphism group. Symmetry breaking that is sound for a refutation: pin the origin **in** the set (translation); pin
the set's second point onto a fixed representative of each rotation orbit of the non-neighbours (the rotations fix the
origin, so the orbits of the remaining points under the order-84 rotation group are the cubes: ≈ 6,888/84 = 82 cubes at 83,
≈ 22 at 23) — a natural cube-and-conquer split where every cube is a genuine sub-instance and the cubes' refusals compose
by the orbit argument. Deeper: the reflection fixing the origin and the pinned point halves each cube. Each cube's refusal
is a proof log; the composition (the orbit lemma) is a hand step now and a kernel target later.

**D3 — the encoding.** M61's CNF (edge clauses + a sequential counter "at least N" + the origin pinned) was undecided at
23 in two hours. The counter encoding matters at n = 6,889: totalizer or sorting-network cardinality, or pseudo-Boolean
solvers, priced against each other at 23 first; and the dual form — "no set of 1,149" as a covering by 6,889 − 1,148 = 5,741
excluded points — is worth one look, since Hoffman's proof is a weighting argument and a weighted counter may propagate better.

**D4 — the finding side.** WO-18 as the engineer designed it: tabu over "insert a vertex, evict its conflicting neighbours"
or penalty search at a fixed target size; one independent search per thread; the plateau curve as the record; verified
sets only. Controls: at 11 it must find 28 and never 29 (α = 28 is on record); at 19 it must find ≥ 76; at 83 the 42
independent lines of 83 points and the colourer's classes are the calibration objects — a search that cannot reach 358 in
a second is broken. **Run it equivariantly as well as on the plane** (the engineer's closing note, 2026-09-14): the colourer's
best symmetric run beat its whole-plane run on a smaller space with a fifth of the budget, so on this instance the symmetric
search is the better buy at the same objective; and note the colourer's neighbourhood scans the whole conflicting set
(O(|conflicted| · k) per move, not O(degree)), so its plateau is partly the search's — the independent-set probe must not
inherit that shape without measuring it.

**D5 — the kernel form.** If a refusal at 83 lands with proof logs: `seven_le_chromaticNumber_finitePlane83` from
`card_le_mul_of_colorable` and the refusal replayed as LRAT cores per cube (FS-38 K3's recipe extracts the core by backward
reachability; the M63 H2 logs were ~1 GB per twenty cubes and never checked — price before promising). The composition of
cube refusals into "no independent set of 1,149" is the orbit lemma (D2) and is stated in the skeleton.

## 4. Phases

| phase | what | cost | stop rule / acceptance |
|---|---|---|---|
| PA | the prior-art gate under D1's names, two disciplines (finite-field distance problems; coding-theory bounds) — half a day; anything found on α of the finite Euclidean graph at a single distance is read before D2 runs | half a day | a known bound below 1,149 would close the milestone before any search. **Run 2026-09-14 (`plans/FS50-prior-art.md`): no known bound and no exact value of α for any finite Euclidean plane in the literature; the real-plane autocorrelation LP with subgraph constraints, transplanted (`tools/fplane_lp.py`), gives 1,197.06 at 83 against the needed 1,148 (12% at 11, 0.2% at 83) — the certificate needs search** |
| A | WO-18 built in `~/source/descent-engine` (the Rust engineer; the colourer's engine, driver, record and controls reused) and run at 11, 19, 23, 83: the best independent set found, its plateau curve, verified sets only | a day to build; minutes per run | the curve at 83; a set ≥ 1,149 is the jackpot for the finding side (P1 refuted) and the seed for phase D  **Done 2026-09-14: best 597 (52% of 1,149), the curve in `data/fs50/wo18/p83-plane-600s.json`; P2 (plateau below 1,000) met** |
| B | the certificate at 23: "α ≥ 106?" by cube-and-conquer over the rotation orbits (D2) with the encodings of D3 raced, proof logs kept under `build/fs50/` and the verdict written per cube to a checkpoint outside `build/` (`data/fs50/ckpt/`), the resume command in the README | a desktop-day, priced | decided either way: a refusal is χ(UD(𝔽₂₃,2)) ≥ 6 on the solver's word with logs (FS-17's first digit is then not five); a set of 106 meets the necessary condition and FS-17 continues on the colouring side |
| C | the certificate at 83: "α ≥ 1,149?" by the same pipeline, priced from B's per-cube cost and the 13× larger instance; **ask for the 256-core server if a desktop-day does not cover it** (Kooshi's standing offer), and run there | priced first; a desktop-day to days | a refusal is χ(UD(𝔽₈₃,2)) ≥ 7 with logs: L(ℚ(√3,√7,√11)) = 7 and the conjecture's prediction 7 there; a set of 1,149 sends the digit back to the colouring side with a seed |
| D | if a set of the threshold size is found at either prime: the colouring search seeded by it (the colourer with the set pinned as one class) | hours | a colouring is the digit; not found is recorded as such |
| E | the kernel: D5 priced; if affordable, `seven_le_chromaticNumber_finitePlane83` (or `six_le_…23`) with the cube cores; else the solver's word recorded as the solver's word | days if attempted | gates green; the ledger row states exactly what is kernel and what is the solver's |
| F | the record: the ledger row, G48's predictions rewritten (7 for K(√7) if C refuses), FS-17 and FS-40 re-scoped or closed, `CLAUDE.md` under 150,000 bytes | half a day | — |

## 5. Registered predictions (both outcomes reachable)

| id | prediction | confidence | falsifier |
|---|---|---|---|
| P1 | α(UD(𝔽₈₃,2)) < 1,149, so χ ≥ 7 | medium-high — the ratio bound is 19% loose at 11, the greedy sits at a random graph's value, the colourer's classes of that size carry five conflicts per vertex | an independent set of 1,149, verified |
| P2 | WO-18's best independent set at 83 plateaus below 1,000 | medium | a set above 1,000 |
| P3 | the certificate at 23 (106) is decided by cube-and-conquer within a desktop-day | medium — the two-hour wall was one monolithic CDCL run | undecided cubes after a day: then the encoding (D3) is the lever before the server is |
| P4 | at 83 the certificate needs the server | medium | a desktop-day suffices |
| P5 (hunch) | α(23) < 106, so UD(𝔽₂₃,2) is not five-colourable and FS-17's digit is 6 or more | low-medium — the same looseness reading, one prime down | a set of 106 |

## 6. Failure and jackpot clauses

Failure: the certificate runs stall (cubes undecided) at both primes after the encodings are raced and the server is used —
then the record holds the plateau curves and the undecided sizes, the digit stays open, and the honest sentence is that the
first digit is beyond this project's refutation reach at 83. Jackpot, two shapes: (i) a refusal at 83 — HALT AND VERIFY (the
CNF regenerated from the definition and diffed, the proof logs checked by an independent checker if one is installed, the
orbit composition written out) — is a certified χ ≥ 7 on the solver's word, the first plane above its floor at a 6-open
field's first usable prime, and the conjecture's prediction for that field becomes 7; (ii) a set of 1,149 found — the
necessary condition met, the colouring search re-armed with a seed, and the digit alive on the six side.

## 7. Bearing on 6, honestly

**None directly; medium-high on the conjecture.** No outcome here produces a six-chromatic unit-distance graph. What it
produces is the conjecture's boldest prediction pinned to a field we have built in — 7 for ℚ(√3,√7,√11) if the refusal
lands — or, if the set exists, the first hard structural datum on the six side of a finite plane. It also unifies FS-17 and
FS-40's certificate halves under one pipeline, calibrated where it is cheap.

## 8. Addresses

`tools/fplane.py` (`alpha`, `theta`, `spectral`, `equivariant`), `data/fplane/` (`alpha-p*.json`, `spectral-p83.json`, the
2026-09-14 records), `Proofs/HadwigerNelson/LocalGlobal.lean` (`card_le_mul_of_colorable`), `PlaneRotation.lean` (the rotations),
`plans/M63-phaseH2-solver.md` (cube-and-conquer with proof logs), `~/source/descent-engine/plans/WO-18-independent-set.md`,
`~/source/descent-engine/crates/plane-colour/`; records to `data/fs50/` with a README row per file; checkpoints under
`data/fs50/ckpt/`, never under `build/`.

---

## §PA. The prior-art gate — `plans/FS50-prior-art.md` (run 2026-09-14, before this subplan)

In one sentence: nobody has computed the independence number of any finite Euclidean plane or bounded it below the ratio
bound; every relaxation over the pair scheme is blind (Schrijver 1979 plus our measurement); the real-plane 1-avoiding-set
LP with subgraph rows, transplanted (`tools/fplane_lp.py`), bites 12% at 11 and 0.2% at 83; the two literatures that could
have held the answer do not cite each other. Everything below rests on that section and on the advisor's pass
`plans/POROS-2026-09-14-fs50-planning.md`.

## §S. The subplan (2026-09-14, de Bruijn as planner; the advisor's pass read first, per Kooshi's ordering)

### §S0. State on disk at opening

| what | where | trust |
|---|---|---|
| the finding side, shipped: `plane-independent` (WO-18), gate green, 46 records re-verified here from the definition | `~/source/descent-engine/crates/plane-independent/`, `plans/WO-18-outcome.md`; `data/fs50/wo18/` | the tool's word plus our re-verification of every set |
| **α(UD(𝔽₈₃,2)) ≥ 597** (the order-6 quotient's 595 through `--start` into the plane search); the plane alone 574 in 600 s; the ladder over every divisor of 84 (566/543/541/595/589/541/589/589/533/589/505 at orders 2…84), the line quotient 581; the rotation classes at orders 84/42/28 and the line quotient **exhausted** (505/589/533/581, the engineer's branch and bound, origin included) | `data/fs50/wo18/p83-*.json` | verified sets; the exact class optima on the engineer's word (Python B&B, planning session) |
| **α(UD(𝔽₂₃,2)) ≥ 87**; α(19) ≥ 76; α(11) = 28 | `data/fs50/alpha-p23-ge87.json`, `data/fplane/alpha-p{11,19}.json` | verified sets; the refusal at 11 cadical's |
| the targets: 1,149 at 83 `not_found` (600 s, 16 threads); 106 at 23 `not_found` (300 s) | `data/fs50/wo18/p83-k6.json`, `p23-k5.json` | the search's word |
| the relaxations: Delsarte = ϑ′ = Hoffman (1,199.459 at 83); + subgraph rows 1,197.064; the atom LP adds nothing | `data/fs50/lp-*.json` | float LP, controls green |
| the CDCL negatives at 23 (size 106): six cardinality encodings undecided at 900 s; class cubes 0–10 undecided at 840 s, class 11 in 132 s, class 12 in 12 s; **the monolith undecided at every N from 110 to 140, above the ratio bound**; at 19 (size 77) the same shape, undecided at every N from 77 to 110; at 11 smooth (0.3–32 s) | `data/fs50/race23/`, `race19/`, `nscale/` | the solver's word |
| core-guided MaxSAT (RC2): 28 at 11 in 0.44 s; stalls at 19 and 23 with upper bounds 110 and 151 after twenty minutes | `data/fs50/maxsat/` | the solver's word |
| the advisor's pass: the residual-density threshold (≈ 0.41) behind the cube cliff; the Fourier-mass anomaly (the exact 28-set puts 70% of its mass on the λ_min class, the 87-set 51%, the 597-set 1.7%; a 1,149-set is forced to ≥ 76% on four classes); the triple-level SDP as the certificate's proof system; three reframings | `plans/POROS-2026-09-14-fs50-planning.md` | readings with falsifiers |
| the kernel consumer: `not_colorable_of_mul_lt` (`k · a < card ⟹ ¬ Colorable k` from "every independent finset has ≤ a"), `finitePlane p`, `rotHom` | `LocalGlobal.lean:196`, `UnitQuadrance.lean:57`, `PlaneRotation.lean:85` | kernel |

### §S1. Units — fixed once

Points are `(x, y) ∈ 𝔽_p²`, vertex id `v = x·p + y`; the quadrance `Q(x, y) = x² + y²`; the plane `UD(𝔽_p, 2)` joins points at
quadrance 1 of their difference; `p ≡ 3 (mod 4)` throughout, so no nonzero vector is isotropic, every nonzero class (a
circle) has `p + 1` points, and the rotations (`rotHom`, the norm-one elements of `𝔽_p(i)`) act freely and transitively on
each circle. "The ratio bound" is Hoffman's `n(−λ_min)/(d − λ_min)` on exact character sums; "the threshold" is `⌈n/k⌉`
(1,149 at `(83, 6)`; 106 at `(23, 5)`); "a bound" is an upper bound on α, and the record separates float readings from
exact certificates by name. A refutation is "on the solver's word" until its certificate is checked by an independent
program; the kernel row is `not_colorable_of_mul_lt`.

### §S2. What the day's measurements decided (the shape, from numbers, before any derivation)

1. **The finding side is done and reads P2 as met**: the plateau at 83 is 597, 52% of the threshold, and every symmetric
   family peaks near half of it. The remaining finding-side instrument is the advisor's spectral seeding (card 2), an hour
   of the engineer's time — a *dial* on whether the near-Hoffman basin at 83 is empty, not a search for the set.
2. **Resolution is the wrong proof system for the certificate**, measured three ways: the solver's reach is a residual
   density (≈ 0.41 at both 19 and 23), so no assignment-shaped cube tree lifts 0.167 to it; at 19 and 23 the solver cannot
   refute sizes the ratio bound refutes on paper; core-guided MaxSAT stalls above the ratio bound. Phases B–C as stubbed
   (cube-and-conquer with LRAT) are **retired**, and P3/P4 with them (wrong instrument, scored in §S7).
3. **The certificate, if any, is semidefinite**: the pair level is Hoffman (1,199) and closes nothing; the local LP rows
   close 0.2%; the triple level (Schrijver 2005's shape in the commutant of the point stabiliser) is the one instrument
   whose bounding power comes from the spectrum, and its value at 11 against the exact α = 28 decides the milestone's
   shape — the advisor's thresholds: `< 29` go straight to 23 and 83; `29–30.39` beats every local row, go to 23 and read
   the fraction of the Hoffman-to-truth gap closed; `≥ 30.39` the certificate side closes honestly.
   **Measured at opening (§S3).**
4. **The calibration runs backwards from the stub's intuition** (the advisor): deciding 11 needs 84% of its
   Hoffman-to-truth gap closed, 23 about 67%, 83 about 10% if the truth is ≈ 600–750 — a modest instrument at 11 can be
   decisive at 83, and the reading at 23 is the fraction of the gap, not the threshold.

### §S3. The opening measurement: the triple-level SDP at 11 (`tools/fplane_sdp.py`, run at subplanning)

**The formulation** (the tool's docstring is the derivation, one paragraph): for an independent `S ⊆ 𝔽_p²` and
`x^z = 1_{S−z}`, `Y = (1/|S|) Σ_{z∈S} x^z x^zᵀ ⪰ 0` counts triples (`Y[u,v] = #{z ∈ S : u+z, v+z ∈ S}/|S|`), and
`M − Y ⪰ 0` where `M[u,v] = g(Q(v−u))` is the pair autocorrelation (`M = (1/|S|) Σ_{z∈V} x^z x^zᵀ`); `Y ≥ 0`, zero on any
pair touching a unit vector, `Y[u,u] = Y[0,u] = g(Q(u))`, `Σ_v Y[u,v] = |S| g(Q(u))`, `tr Y = |S|`, `Y[u,v] ≤ Y[u,u]`;
`Y` averaged over the point stabiliser `O(2, p)` and identified under the swap and the S₃ relabelling
`(u, v) ↦ (−u, v−u)`; with `|S| = s` fixed everything is linear, and the bound is the largest feasible `s` by bisection.
At 11: **151 pair orbits, 36 killed by a unit vector**, two 121 × 121 PSD blocks — no block-diagonalisation needed below
83. **Controls**: the pair-only reduction reproduces Delsarte (34.537 against 34.550 at bisection tolerance 0.05 —
green); the verified 28-set's own `Y_S` satisfies every constraint (the load-bearing one, the advisor's trap 1); the
second matrix mis-signed as a plant must make `s = 28` infeasible.

**The decision rule, registered before the number** (the advisor's, adopted): `< 29` — the SDP decides 11 exactly: go
straight to 23 and 83 and write the exact-certificate phase; `29 – 30.39` — beats every local row: go to 23, read the
fraction of the Hoffman-to-truth gap closed, then 83; `≥ 30.39` — no better than local rows: the certificate side of
FS-50 closes honestly ("beyond every instrument this project can name"), nothing is spent on the server, and the
milestone's product is the finding side's ladder plus the negatives.

**§S3.1 The number (2026-09-14, `data/fs50/sdp-p11-linear.json`): the triple-level bound at 11 is 29.18** (Schrijver's
linear form, SCS and Clarabel agreeing to four decimals; with the 188 subgraph rows added 29.18 again — the local LP is
subsumed by the triple level). Against Hoffman 34.55 and the truth 28 it closes **82% of the Hoffman-to-truth gap**;
the rule's middle band: it beats every local row (30.39) and does not decide 11 exactly (an exact dual would certify
`α(11) ≤ 29`). Controls: the pair-only form 34.54 (Delsarte); the verified 28-set's raw `Y_S` satisfies the swap and S₃
identities exactly and, averaged, every constraint; the bisection form is feasible at 28 and infeasible with the second
matrix mis-signed. **So: go to 23** (phase C, launched at once), reading the fraction of the gap closed; by the advisor's
calibration (83 needs ≈ 10% of its gap) the line is live. Two facts for the tool's record: cvxpy canonicalises a chain
of scaled sparse terms catastrophically (254 s against 17 s for the identical problem as one linear map at 11), and SCS
is fifteen times faster than Clarabel here at the accuracy a reading needs.

**§S3.2 At 19 and 23 (2026-09-14, `data/fs50/sdp-p19-linear.json`, `sdp-p23-linear.json`): 85.67 at 19** (Hoffman 99.50,
truth ≥ 76: 59% of the gap; `α(19) ≤ 85` if certified — 77 undecided) **and 108.55 at 23** (Hoffman 131.76, truth ≥ 87:
52% of the gap; `α(23) ≤ 108` if certified — **the five-colour threshold 106 is missed by 2.5**, so FS-17's first digit stays
open, bracketed `[87, 108]`). Both with every control green and the subgraph rows adding nothing (P8 met: more than a third).
The fraction closed declines with `p` — 82%, 59%, 52% — and the advisor's calibration needs ≈ 10% at 83; the extrapolation is
a reading, and phase E is the measurement. 673 / 1,167 orbits; SCS minutes at 23.

**Phase D′, added by this number:** the exact rational dual and its checker are built at 11 first — certifying
`α(UD(𝔽₁₁,2)) ≤ 29` exactly is one above the truth and is nevertheless the first bound below the ratio bound for any
finite Euclidean plane with a stranger-checkable certificate, and 11 (151 orbits, two 121 × 121 blocks) is the right
size to develop the checker and its negative controls against before 23 and 83.

### §S4. Derivations that fix the shape

**D6 — the certificate's proof system.** The refutation "no independent set of size ≥ N" is, at every prime from 19 up
and at every N tried, out of resolution's reach even where the ratio bound refutes it on paper (§S0); its natural proof
is a degree-two sum of squares (the ratio bound is `A − λ_min I ⪰ 0` on the indicator's projection), which neither
resolution nor cutting planes simulate. The proof system that carries it is Positivstellensatz/SOS; a certificate is a
PSD Gram matrix (or a dual feasible point of the SDP) with rational entries, checked by exact linear algebra — the
advisor's Q4. So the certificate phase produces **a list of rationals**, and the independent checker is a few hundred
lines of exact arithmetic (as `wo18-recheck.py` is for sets), never an LRAT replayer.

**D7 — what a reviewer who trusts none of our Python must check** (the acceptance of any certificate here): (i) the
identities and the PSD-ness of every block of a rational dual, by an independent exact program; (ii) the one-page
derivation that identities + PSD ⟹ `|S| ≤ N` for every independent `S` (Schrijver 2005 §2 transplanted to the Cayley
graph on `𝔽_p²` with its point stabiliser — to be written out, not cited); (iii) the kernel's `not_colorable_of_mul_lt`
for the step from α to χ. Smaller than any LRAT bundle this project has produced.

**D8 — the symmetry reduction at 83** (the derivation the 83 phase needs, priced by the advisor): `Y` lives in the
commutant of `O(2, 83)` on `ℂ^{V}`, `|V| = 6,889`; the orbit count on ordered pairs is 285,935 by Burnside before the S₃
identities (≈ 48k after), and the commutant block-diagonalises into one 83 × 83, two 41 × 41 and forty-one 82 × 82 blocks
per matrix (86 blocks ≤ 83 for the pair `Y`, `M − Y`) — a desktop job for a first-order solver in memory, hours for an
interior-point solver with an 18 GB Schur complement. **The control that the reduction is right is the direct solve at
23** (529 × 529 blocks, no reduction): the block-diagonalised value at 23 must equal it to the bisection tolerance, and
the verified 87-set must stay feasible in both.

**D8′ — the reduction, concretely (the spec for phase E).** Fix a generator `ζ` of the rotation group (order `p+1`) and, on
each circle `C_c`, a base point `u_c` and the angular coordinate `θ ∈ ℤ/(p+1)` with `x = u_c ζ^θ`. A `G`-invariant matrix `Y`
is determined by its **angular profiles**: for each ordered pair of circles `(c, c′)` the function `f_{cc′}(θ) = Y[u_c, u_{c′} ζ^θ]`
(`p+1` values, each an orbit variable), plus `Y[0, u_c]` and `Y[0,0]`. Its blocks are discrete Fourier transforms of the
profiles: for the two-dimensional irreducible `ρ_j` (`1 ≤ j ≤ (p−1)/2`) the `(p−1) × (p−1)` block has entries
`B_j[c, c′] = Σ_θ f_{cc′}(θ) cos(2π jθ/(p+1))` (the sine part agrees by Schur, and the reflection makes the profile even
once the base points are chosen on a common reflection axis per circle type); the trivial block (`p × p`) is the `j = 0` sum
bordered by the origin's row `Y[0, u_c]·√(p+1)`-normalised; the two `(p−1)/2 × (p−1)/2` blocks are the `j = (p+1)/2`
alternating sums restricted to each circle type (the circles a given reflection meets — `c/Q(u)` a square — and the others).
`M(y)` has the same form with `f^M_{cc′}(θ) = g(Q(u_c − u_{c′} ζ^θ))`. So the map from orbit variables to block entries is a
sparse linear map with `p+1` nonzeros per entry — ≈ 24 M nonzeros at 83, built once — and `Y ⪰ 0 ⟺ every block ⪰ 0`.
**Controls before 83 (run 2026-09-14, green):** the reduced solve reproduces 29.1768 at 11 exactly and 108.5464 at 23 against the direct 108.5461 (`tools/fplane_sdp_blocks.py`; the same class counts 151 / 1,167 as the direct tool; 49,447 classes at 83), and the
reduced true-set `Y_S` blocks must be PSD. The certificate at 83 then lives in the blocks (`U_b` = the Fourier vectors,
rational after clearing `ℚ(ζ_{p+1})⁺` — or, simpler for the checker, the blocks are verified PSD and the identity is checked
on the full orbit coefficients through the same map, which needs no algebraic numbers if the map's entries are kept as
exact cosines in `ℚ(ζ_{p+1})` — a detail phase E decides and records).

**D9 — the kernel form is two stubs away, and this milestone states so.** Level one (an exact rational Delsarte dual,
positive definite over ℚ-blocks grouped by the Galois orbits of `ℚ(ζ_p)`) is FS-41's "Hoffman's equality case in Fourier
form" and would put `χ(UD(𝔽₈₃,2)) ≥ 6` in the kernel, **which is not there now** (row 53's floor is float-derived); level
two is the triple certificate. Neither is this milestone's deliverable (§S7 D-4); the ledger row says exactly what is
the solver's, what is exact-rational, and what is kernel — and the kernel content of FS-50 is the consumer
`not_colorable_of_mul_lt` at `(k, a) = (6, 1148)` (§S9), no more.

### §S5. Phases, costs, stop rules (replacing §4's B–E, which are retired by §S2.2)

| phase | what | cost | stop rule / acceptance |
|---|---|---|---|
| A ✓ | WO-18 — done 2026-09-14 (§S0) | — | 597; P2 met |
| B | **the triple-level SDP at 11** (§S3), controls green; the number scored against the decision rule | an hour (run) | the rule decides the branch below |
| C | **at 23**: the direct SDP (529 × 529 blocks) — the bound, the fraction of the Hoffman-to-truth gap closed, the verified 87-set feasible; and, if the bound is `< 106`, α(23) ≤ 105 on the solver's word and FS-17's first digit is 6 or more | hours on the desktop; checkpoint = the bisection log (each feasibility verdict written to `data/fs50/ckpt/sdp-p23.json`, resume by re-reading it) | a value; `< 106` is a result for FS-17, `≥ 106` is the calibration only |
| D | **the exact rational dual at the smallest prime the SDP decides** (11 if `< 29`; else 23 if `< 106`): round the dual, verify with an independent exact-arithmetic script (D7 (i)), write D7 (ii) as one page | a day | a certified `α ≤ N` that a stranger checks by exact linear algebra — the first bound below the ratio bound for any finite Euclidean plane |
| E | **at 83**: D8's reduction, controlled at 23; the SDP solved; if `< 1,149`, the exact dual as in D — then **χ(UD(𝔽₈₃,2)) ≥ 7 on an exact certificate**, L(ℚ(√3,√7,√11)) = 7, G48's prediction 7 | two to four days (the reduction, the solve, the rounding); the desktop, no server (the advisor's trap 3) | a bound; `< 1,149` is the jackpot; `≥ 1,149` with the 597 floor is the honest bracket `[597, bound]` |
| F | the finding-side dial: spectral seeding of the engineer's search from the bottom eigenspaces (the advisor's card 2) — WO-19, an hour of engineering, two hours of desktop time | small | a plateau near 600 says the near-Hoffman basin is empty (P1 to very high); a verified set above 700 re-reads everything |
| G | the record: the ledger row (what is solver / exact-rational / kernel), G44/G48 rewritten, FS-17 and FS-40 re-scoped, the kernel stubs minted (D9), `CLAUDE.md` under 150,000 bytes | half a day | — |

**If §S3's number is `≥ 30.39`**: phases C–E are cancelled, F runs, G records the closure honestly, and the stub FS-41 gains
the SDP's kernel form as its own line. **The server is not asked for at any branch** — no instrument on this list needs it
(the advisor's trap 3; P4 retired).

### §S6. The stub's predictions, scored at subplanning; the advisor's, registered

| id | prediction | status |
|---|---|---|
| P1 | α(83) < 1,149 | **high** now (was medium-high): every symmetric family peaks near half the threshold; the best set is 52% of it; the Fourier-mass anomaly says a 1,149-set lives in a regime no search has visited. Falsifier unchanged: a verified set of 1,149 |
| P2 | WO-18's plateau below 1,000 | **met** (597; the plane alone 574) |
| P3 | the 23 certificate by cube-and-conquer within a desktop-day | **retired — wrong instrument**: the monolith and every cube below class 11 are undecided at 840 s, and the solver cannot refute sizes above the ratio bound |
| P4 | 83 needs the server | **retired — wrong instrument**; no branch of §S5 asks for it |
| P5 | α(23) < 106 | kept, low-medium; the SDP at 23 (phase C) is its test |
| **P6** (the advisor's hunch, registered) | α(83) ≤ 750 | falsifier: a verified set above 750; the SDP at 83 is its upper test |
| **P7** (the advisor's) | the triple-level bound at 11 lies in `[28.5, 30]` | falsifier: a value `≥ 30.39` with both controls green |
| **P8** (mine) | at 23 the triple level closes more than a third of the Hoffman-to-truth gap (`< 116.9` against 131.76 and 87) | **met: 108.55, 52%** (2026-09-14); 83 is predicted to clear 1,149 by the advisor's 10% reading — a reading, phase E measures it |

### §S7. Decisions settled at subplanning (choice · alternative · why · confidence)

| # | choice | alternative | why | confidence |
|---|---|---|---|---|
| D-1 | the certificate is semidefinite (the triple level), not CDCL | cube-and-conquer with a deeper split, as stubbed | measured three ways (§S2.2): resolution does not reach the spectral argument at 19 or 23 at any size | high |
| D-2 | measure at 11 first and let the registered rule pick the branch | go to 23 directly | 11 has the exact α and two controls; an afternoon decides whether the line is live | high |
| D-3 | the exact certificate is a rational dual checked by exact arithmetic; LRAT is not promised anywhere | LRAT cores per cube (the stub's D5) | there is no CDCL refutation to log, and a global statement's core is the whole graph | high |
| D-4 | the kernel form is stubbed, not built: this milestone's kernel content is the consumer at `(6, 1148)` | prove `χ ≥ 7` at 83 in the kernel from an exact dual | level one alone (the ratio bound over ℚ-blocks) is FS-41's whole milestone and `χ ≥ 6` at 83 is not in the kernel today; promising the triple level would be a promise about hours nobody has measured | high |
| D-5 | no planner subagent; the subplan and the modeling passes in the main session; implementers for phases C–E as Opus sessions one at a time | a planner subagent | Kooshi's halt; the shape is decided by one measurement, not by a long design | high |
| D-6 | no server at any branch | keep P4's ask | the instruments that remain fit the desktop; a server-day returning "unknown" is the failure clause at full price | high |
| D-7 | the product is offered to Kooshi as the *table* (certified bounds below the ratio bound at 11, 23, 83) with the 83 digit as its application — his call (the advisor's card 3) | the bit at 83 alone | the same computation produces the table for free, and a miss at 83 is then a row, not a failure | recommendation; medium on his answer |

### §S8. Gap audit against the stub and the brief

| promise | status |
|---|---|
| PA — half a day, a known bound closes it | done; nothing known; the LP transplant measured (0.2%) |
| A — WO-18, run at 11/19/23/83, the curve | done, 597; controls; every set re-verified |
| B — the certificate at 23 by cubes with logs, checkpoints under `data/fs50/ckpt/` | **changed**: the SDP at 23 (phase C), its bisection log as the checkpoint, no LRAT |
| C — the certificate at 83, the server if needed | **changed**: the SDP at 83 (phase E) on the desktop; the server dropped |
| D — the colouring seeded by a found set | **dropped with reason**: no set near the threshold exists to seed with (52% of it); the engineer's D87 (`--pin-class`) stays filed for the day one does |
| E — the kernel form priced | **changed**: priced and declined for this milestone (D-4); two stubs minted at the close |
| F — the record | kept (phase G) |
| the advisor's cards 1–3 | card 1 = phase B; card 2 = phase F; card 3 = D-7, to Kooshi |

### §S9. The skeleton — every statement, elaborating

The kernel content of FS-50 is the consumer, stated at the plane and the numbers, with no `sorry` and an explicit vacuity
declaration: its hypothesis *is* the milestone's question, so the gate must read it `UNKNOWN` (as `hexShell_plane6`), never
`VACUOUS`.

```lean
/-- **The consumer of a certified `α(UD(𝔽₈₃, 2)) ≤ 1148`.** If every independent set of the finite plane at 83 has at most
1,148 points, the plane is not six-colourable, and its chromatic number is at least 7. The hypothesis is FS-50's open
question; VACUITY: `UNKNOWN` by design (a certificate is the milestone's deliverable, in the SDP proof system — not LRAT). -/
theorem seven_le_chromaticNumber_finitePlane83_of_indep_le
    (h : ∀ s : Finset (ZMod 83 × ZMod 83), (finitePlane 83).IsIndepSet (s : Set _) → s.card ≤ 1148) :
    7 ≤ (finitePlane 83).chromaticNumber := by
  -- `not_colorable_of_mul_lt h (by decide : 6 * 1148 < 6889)` and `SimpleGraph.le_chromaticNumber_of_not_colorable`
  sorry
```

Beside it, `example : 6 * 1148 < Fintype.card (ZMod 83 × ZMod 83) := by decide` pins the arithmetic, and the same
statement at 23 (`6 ≤ … of h : … ≤ 105`) for FS-17. Both close at implementation from `not_colorable_of_mul_lt`; nothing
else is stated, because nothing else is provable from what the milestone can certify.

## §M1. Domain-modeling pass (`debruijn-domain-modeling`, fresh invocation, 2026-09-14)

**The three models, and what is intrinsic in each.**

1. **The Lean consumer.** §S9's theorem is a correct instance where a theorem is available (G30's failure 6). The
   intrinsic quantity is `indepNum`, and the general statement is one lemma:
   `le_chromaticNumber_of_indepNum_le [Fintype V] (h : G.indepNum ≤ a) (hk : k * a < Fintype.card V) : k + 1 ≤ G.chromaticNumber`
   (from `not_colorable_of_mul_lt` with `IsIndepSet.card_le_indepNum`, and the lower-bound face of Mathlib's
   `chromaticNumber`; the names queried at implementation, not recalled). The 83 and 23 corollaries are one line each with
   `h : (finitePlane 83).indepNum ≤ 1148` (resp. `≤ 105`), each carrying the vacuity declaration `UNKNOWN`: the hypothesis
   is the milestone's question. §S9 is rewritten so.
2. **The SDP.** Intrinsic: the *orbit algebra* — `Y` indexed by orbits of the point stabiliser `O(2, p)` on ordered pairs of
   difference vectors, further identified under the swap and the S₃ relabelling of a triple's base point (the two
   involutions `(u,v) ↦ (v,u)` and `(u,v) ↦ (−u, v−u)` generate S₃, checked: their product has order 3). Incidental, and a
   choice to be measured: **the normalisation.** The bisection form divides by `|S|` and adds the row-sum identities
   `Σ_v Y[u,v] = |S|·g(Q(u))`, which are bilinear and so need `|S|` fixed — ten solves per bound, but possibly a stronger
   relaxation; Schrijver's **linear form** drops them, maximises `tr Y` in one solve, and has a clean dual — which is the
   object the exact-certificate phase rounds. Decision rule: run both at 11 and 23; if the values agree to the tolerance,
   the linear form is the instrument (one solve, one dual); if the bisection form is strictly smaller, its infeasibility
   certificate at `s = N` (a Farkas dual, also a list of rationals) is the certificate and the extra cost is paid.
   **A control the current tool lacks, added now:** the S₃ and swap identities must hold *exactly* on the verified set's own
   raw `Y_S` (they are identities of the triple count, not consequences of averaging); only the `O(2)` symmetry is imposed
   by averaging. A wrong S₃ map is invisible in a float value and visible here.
3. **The block structure at 83, derived rather than cited.** `O(2, p)` is the dihedral group of order `2(p+1)`; on each
   circle it acts as on the vertices of a `(p+1)`-gon (a reflection fixes a line, which meets a circle in two points when
   `c/Q(u)` is a square and none otherwise, so the circles split into two types); the permutation character on
   `V = {0} ∪ (p−1) circles` has `fix(id) = p²`, `fix(rotation) = 1`, `fix(reflection) = p`. Multiplicities: the trivial
   representation `p` times (one per circle plus the origin), the two one-dimensional representations with the rotation
   acting by `−1` each `(p−1)/2` times (one per circle of the matching type), and each of the `(p+1)/2 − 1` two-dimensional
   representations `p − 1` times. Check at 11: `11² + 5² + 5² + 5·10² = 671 = ` the Burnside count of orbits on ordered
   pairs `(1 + 10 + 10 + 100 + 550)`. So at 83 the commutant of one matrix is **one 83 × 83, two 41 × 41 and forty-one 82 × 82
   blocks** — the advisor's numbers, with the count of two-dimensional blocks corrected to `(p+1)/2 − 1` (a formula slip
   there; the 41 is right). The projectors are the isotypic projectors of the dihedral character table, computable exactly
   over `ℚ(ζ_{p+1})⁺`; the control is the direct solve at 23 (D8).

**The seams.** The unsampled member: `p ≡ 1 (mod 4)` (isotropic vectors, the circle with `p − 1` points) — out of scope by
§S1 and refused by name in every tool. The adversarial member: a float SDP value that clears 1,149 by less than the solver's
tolerance — the plan reads no float as a verdict (§S4 D6; the advisor's trap 1). The next lemma for free: the same
`le_chromaticNumber_of_indepNum_le` at 23 with `(6, 105)` states in the existing vocabulary — it does.

**Rewritten skeleton (replaces §S9's):**

```lean
/-- **From an independence-number bound to a chromatic lower bound.** `k` colour classes of size ≤ `a` cover at most
`k·a` vertices. -/
theorem le_chromaticNumber_of_indepNum_le [Fintype V] (h : G.indepNum ≤ a) (hk : k * a < Fintype.card V) :
    (k + 1 : ℕ∞) ≤ G.chromaticNumber := by sorry
/-- The consumer at 83: VACUITY DECLARED `UNKNOWN` — the hypothesis is FS-50's question. -/
theorem seven_le_chromaticNumber_finitePlane83_of_indepNum_le (h : (finitePlane 83).indepNum ≤ 1148) :
    7 ≤ (finitePlane 83).chromaticNumber := le_chromaticNumber_of_indepNum_le h (by decide)
/-- The consumer at 23 (FS-17's first digit): VACUITY DECLARED `UNKNOWN`. -/
theorem six_le_chromaticNumber_finitePlane23_of_indepNum_le (h : (finitePlane 23).indepNum ≤ 105) :
    6 ≤ (finitePlane 23).chromaticNumber := le_chromaticNumber_of_indepNum_le h (by decide)
```

## §M2. Obligation-modeling pass (`debruijn-obligation-modeling`, fresh invocation, 2026-09-14)

**The partition.** *Prove (kernel):* `le_chromaticNumber_of_indepNum_le` — three local obligations, no induction: (1) from
`h : G.indepNum ≤ a` every independent finset has card `≤ a` (`IsIndepSet.card_le_indepNum` then `le_trans`); (2)
`not_colorable_of_mul_lt` gives `¬ G.Colorable k`; (3) the lower-bound face of `chromaticNumber` —
`¬ Colorable k ⟹ k < χ ⟹ k + 1 ≤ χ` in `ℕ∞` (the contrapositive of `chromaticNumber_le_iff_colorable` or its current
name, then `Order.add_one_le_of_lt`; queried, not recalled). The instances' arithmetic `6 * 1148 < Fintype.card (ZMod 83 ×
ZMod 83)` goes through `Fintype.card_prod` and `ZMod.card`, not bare `decide`. *Prove (hand, one page — D7 (ii)):* the
certificate's soundness, derived below. *Test:* the pair-only reduction equals Delsarte (green at 11); the verified set's
raw `Y_S` satisfies the swap and S₃ identities exactly and, averaged, every constraint; the mis-signed plant refuses the
true size; the linear and bisection forms agree or the difference is recorded; at 83 the block-diagonalised value at 23
equals the direct one. *Assume:* `p ≡ 3 (mod 4)`; floats are readings, the rational dual is the verdict.

**The statement from which the soundness proof derives — a nonnegative-combination identity.** Write every constraint of
the relaxation as `c_i(y) ≥ 0` (entrywise nonnegativity, the killed orbits as `−y_k ≥ 0` and `y_k ≥ 0`, `y[u,v] ≤ y[u,u]`,
the subgraph rows) or `e_j(y) = 0` (`g(0) = 1`), all *affine in the orbit variables `y`*, and the two matrix constraints
`Y(y) ⪰ 0`, `M(y) − Y(y) ⪰ 0` with `Y, M` *linear in `y`*. A **certificate for `N`** is: rational multipliers `λ_i ≥ 0`, `ν_j`
(any sign), and rational PSD matrices `Z₁, Z₂` (given as PSD blocks `Z^b` with rational maps `U_b`, `Z := Σ_b U_b Z^b U_bᵀ` —
PSD whatever the `U_b` are, so the block-diagonalisation need not be verified, only used) such that

    N − tr Y(y)  ≡  ⟨Z₁, Y(y)⟩ + ⟨Z₂, M(y) − Y(y)⟩ + Σ_i λ_i c_i(y) + Σ_j ν_j e_j(y)     as affine functions of y.

**Soundness** is then two lines: for an independent `S` of size `s`, its own `y_S` (the orbit-averaged triple counts)
satisfies every constraint (the primal construction: `Y_S = (1/s) Σ_{z∈S} x^z x^zᵀ` is a sum of rank-one PSD matrices,
`M_S − Y_S = (1/s) Σ_{z∉S} …` likewise, the zeros are independence, the identities are counting, the S₃ identity is the
relabelling of a triple's base point, and averaging over `O(2, p)` preserves every constraint because each is convex and
`G`-invariant), so every term on the right is `≥ 0` at `y_S`, hence `s = tr Y(y_S) ≤ N`. Weak duality, stated as the
identity a stranger checks coefficient by coefficient in `ℚ`. **What the checker verifies:** (i) the affine identity —
`≈ 48k` rational coefficients at 83, computed orbit-wise as `⟨Z, E_k⟩ = Σ_b tr(Z^b · U_bᵀ E_k U_b)` (the algebra's structure
constants, a fixed cost); (ii) each `Z^b ⪰ 0` exactly (rational `LDLᵀ`, or a Gram factor `Z^b = BᵀB` — the form the
kernel's GMP `Nat` checks in `O(1)` steps per entry by Kronecker packing, D9); (iii) `λ ≥ 0`. Nothing else. The
block-diagonalisation's *correctness* is never on the trust surface: a wrong `U_b` can only make the certificate weaker
or the identity fail, never unsound. **This is the statement the plan commits to**, and phase D's checker is written
against it before any dual is rounded — so that rounding is judged by the checker, not by the solver's residual.

**The measure of the burn-down.** Phase B–E each replace one obligation with finitely many smaller: B reads one number;
C computes one bound and its checks; D closes the identity at one prime (the rounding may fail — then the certificate is
for a weaker `N`, recorded as such, never patched by loosening the checker); E repeats D at 83 with the blocks. The kernel
lemma is one `sorry` replaced by three named steps.

**Mutation audit, registered.** Drop `hk` from the kernel lemma: unprovable (the conclusion is false for the complete
graph on `a` vertices with `k = 1`). Replace `Z₂`'s sign in the identity: the true set's `y_S` violates the mis-signed
matrix constraint (the plant of §S3, watched red). Delete the S₃ identification: the value rises (weaker relaxation) and
the raw-`Y_S` control cannot catch it — which is why the raw control checks the identity and not the averaging.

## §M3. Experience-modeling pass (`debruijn-experience-modeling`, fresh invocation, 2026-09-14)

**Three consumers, and what each holds.** *The stranger with the certificate:* a file and a checker, nothing of ours;
they hold the claim they are asked to believe (`α(UD(𝔽_p,2)) ≤ N`) and must be able to see, from the file alone, what
is being checked and why it implies the claim. *The record's reader* (a ledger row, a README line): must never mistake
a float value for a bound. *The Lean reader and `exact?`:* the lemma must be findable by its conclusion's shape.

**The certificate's wire form** (`data/fs50/cert-p<p>-N<N>.json`; rationals as strings `"a/b"` — JSON has no rationals
and a float on this wire is the wrong object): `kind: "fplane-alpha-certificate"`, `p`, `N`, `claim` in words,
`vertex_index`, `edge_rule` (the same two sentences every record of this project carries), `symmetry` ("`O(2,p)` × swap
× S₃ on ordered pairs of difference vectors"), `orbits` (one representative pair per orbit, as vertex ids — the checker
recomputes the orbits from the group and refuses a mismatch), `constraints` (each with `kind` ∈ {`nonneg`, `killed`,
`le_diag`, `subgraph_row`, `g0`}, its coefficients over orbits, its bound), `multipliers` (`lambda ≥ 0` per inequality,
`nu` per equality), `psd` (for `Z1` and `Z2`: a list of blocks, each `{U, Z}` with `U` a rational map and `Z` a rational
PSD block — or `gram: B` with `Z = BᵀB` when the producer can supply it, which is the kernel-friendly form), and
`derivation: "plans/FS50-certificate-soundness.md"` (D7 (ii), one page). Nothing else; in particular no solver output,
no residuals, no float value — those live in the SDP tool's record, a different file with a different `kind`.

**The checker's conversation** (`tools/fplane_cert_check.py`, exact arithmetic only, `fractions.Fraction` and integer
`LDLᵀ`; a few hundred lines, its own controls): it prints one line per check in the order of marginal evidence —
(1) the group and the orbits rebuilt from `p` and compared to the file's representatives; (2) every multiplier `λ ≥ 0`;
(3) every PSD block, by exact `LDLᵀ` (pivots ≥ 0) or by `Z = BᵀB`; (4) the affine identity, coefficient by coefficient
over orbits — and on failure names the **first offending coefficient by its orbit's representative pair, with both sides
as rationals** ("identity fails at orbit 37, representative (12, 95): lhs 3/8, rhs 5/16"), a PSD failure by its block and
pivot, a multiplier by its index. The last line is one sentence, either `CERTIFIED: every independent set of UD(F_p, 2)
has at most N points — exact arithmetic, no solver trusted` or `NOT A CERTIFICATE: <the first failure>`; and when
`k·N < p²` for the `k` the caller names, a second sentence: `hence UD(F_p, 2) is not k-colourable (kernel consumer:
le_chromaticNumber_of_indepNum_le)`. **Silence is never a pass**: a missing field, a non-rational string, an orbit count
that disagrees, all refuse by name. Its negative controls ship with it: a certificate with one coefficient altered,
one with a PSD block's pivot flipped, one with a multiplier negated — each refused naming the site.

**The SDP tool's verdict words** (`tools/fplane_sdp.py`'s record, `kind: "fplane-sdp"`): every value carries
`"a float reading (solver, status, tolerance); not a bound on α — a bound is a separate certificate file checked by
fplane_cert_check.py"`; the controls are listed with their results (pair-only = Delsarte; the verified set's raw S₃/swap
identities and averaged feasibility; the mis-signed plant); the two forms (linear, bisection) are both reported when run,
with their difference. A value below the threshold prints the threshold beside it and the sentence "the certificate phase
decides".

**The ledger row's three trust levels, fixed in advance so the close cannot blur them:** `[solver]` — the local search's
`not_found`, RC2's and cadical's verdicts, the exact class optima of the engineer's branch and bound; `[exact-rational]` —
a certificate the checker accepted, with the checker and the one-page derivation as the trust surface; `[kernel]` — the
consumer lemma and its two instances (`UNKNOWN` by declaration). The row's headline is the strongest *exact* statement
held; a float SDP value appears only as "reads `v` (float)" beside the exact one or the words "no certificate".

**Names, by convention, for `exact?`:** the conclusion first — `add_one_le_chromaticNumber_of_indepNum_le` (hypotheses
`G.indepNum ≤ a`, `k * a < Fintype.card V`; the Mathlib shape queried at implementation, and if Mathlib already holds
`card_le_chromaticNumber_mul_indepNum`'s consumer under another name, that name is used and ours is not minted); the
instances `seven_le_chromaticNumber_finitePlane83_of_indepNum_le`, `six_le_chromaticNumber_finitePlane23_of_indepNum_le`.
Docstrings state the implication and nothing stronger: they must not read as "χ ≥ 7".

**The breakdown designed first:** the plausible mistakes — a certificate file for another `p` handed to a run at 83, a
float where a rational should be, a checker run on the SDP record by mistake (`kind` mismatch) — each refused by name
before any arithmetic, exactly as `plane-independent` refuses a start record from a foreign plane.


**Decision, 2026-09-15 05:05 (product owner): the checker's `--against` path re-ordered so the verdict is the last line of every
run.** The checker is frozen except by a recorded decision; this is one. Observed at 83: with `--against` the four checks
CERTIFIED the file, the 597-set was re-verified, and then — after 34 minutes in the quadratic orbit construction and an n × n
table that ran BEFORE the `p > 29` feasibility guard — the run ended `NOT A CERTIFICATE: --against assembles …`, a last line
contradicting the verdict two screens above it (the implementer located the lines; it did not touch the checker, per its
brief). The change (`tools/fplane_cert_check.py`): (i) a problem with the SET — absent, unreadable, outside the plane, not
independent — is a `SetProblem`, never a `Refusal`: it prints `THE --against SET IS NOT USABLE: …`, exits 2, and restates the
CERTIFIED sentence last; (ii) the set's independence is re-verified straight from coordinates, O(|S|²), at every p; (iii) the
display's affordability (`p ≤ 29`, since it assembles n² entries) is decided from p alone before any quadratic work, and an
unaffordable display is a NOTE ("… the verdict above stands"), exit 0; (iv) `run_against` is the one function both `main` and
the self-test use, so the last line the self-test checks is the last line a user sees. Controls added (the self-test's 12–14,
beside 11 re-typed): an unavailable display ends on CERTIFIED with exit 0; an unusable set exits 2, names the set, and still
ends on CERTIFIED; the display itself at p = 7 runs and ends on CERTIFIED. The whole self-test re-run green (25.6 s); the 83
certificate re-checked with `--against` in 16.9 s, exit 0; the 11 certificate's display path unchanged. **Verification protocol
at 83, consequently:** the untouched checker on the file first (it decides), then a second rounding from the same iterate at a
different cut and denominator, then `--ldl`; the 597-set's independence is what `--against` does supply at 83.

## §Close — 2026-09-15 (WORKFLOW step 9)

**Outcome.** The question was "is α(UD(𝔽₈₃,2)) ≥ 1,149?" and the answer is **no**: α ≤ 1082, by two independent exact
certificates (ledger row 68; `data/fs50/README.md` "The refusal of six at 83"; `data/fs50/p83-refusal/`). Trust levels:
[solver] the local search's 597 and the relaxation's converged reading (the producer's iterate 1,064 at 41,000 iterations,
still moving; recorded when it lands); [exact-rational] the certificates at 11, 23 and 83, checked by the stranger-checkable
checker and its exact LDL; [kernel] `add_one_le_chromaticNumber_of_indepNum_le` and the three declared instances, whose
hypothesis at 83 is discharged by the checker, not the kernel (FS-52). Consequence: L(K(√7)) = 7 and the conjecture's boldest
prediction is pinned (G48); the window for six and reciprocity's exclusion of it (G56); FS-40 absorbed; FS-53 minted.

**Predictions scored.** P1 (the refusal at 83) met. P2 met earlier. P3/P4 retired at the opening. P5 kept. **P6 (the
advisor's α(83) ≤ 750): unscored and explicitly declined** — the instrument's ceiling is the relaxation's value (≈ 1,064),
so 750 is out of its reach; it would need a stronger relaxation or exact search, both priced in FS-53 phase B; no stub of its
own. P7 as recorded. P8 met.

**Decisions.** D-1..D-6 as recorded. **D-7 / Kooshi's card 3** (the product as the table or the bit): both, in this order —
the bit at 83 is this milestone's row, the table across the window is FS-53. **The third dominance row** (the reading tools'
tighter relaxation): valid, new, inactive at 11 and 23 at equal tolerance; not adopted; revisit only if the two 83 solves
converge to different values at equal tolerance (§1 item 10 of the 2026-09-15 handoff). **The checker changed once**, under
the §M3 decision above (`--against` ends on the verdict). **The certificate recipe:** round a fresh short continuation's own
dual at its chunk end, never a long-run iterate and never through `--round-only`'s nudge (the README's mechanism paragraph).

**Conjecture sweep** (WORKFLOW step 9): every "conjecture" in this plan names the local–global conjecture (G48) or a
registered prediction; the two unpursued items are P6 above (declined, with its reason) and the third-row strengthening
(a recorded decision with its revisit condition). Nothing minted.

**Left open, with their homes:** the converged reading at 83 (the producer; README); the deterministic reproduction of the
Pardiso arm with other cuts (README, when it lands); whether χ(UD(𝔽₈₃,2)) is exactly 7 (a seven-colouring; FS-53's table);
the certificate's kernel form (FS-52); the ratio bound's (FS-51); the field-level residue step (FS-47).
