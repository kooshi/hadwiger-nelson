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
