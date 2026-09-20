# FS-59 — four colours over ℚ(√167)

*Minted 2026-09-17 at FS-58's close. Written for a session with zero conversation memory. Read beside: `plans/FS58-four-colours.md`
(§2 D1–D3, §R-B2–B5, §C), `plans/FS58-prelude-seven-cycle-gadget.md`, `data/fs58/search-167/README.md`, `CLAUDE.md` G59, G60, G61.*

## 1. The question, in plain language

Colour the points of the plane whose coordinates lie in ℚ(√167) so that points at distance exactly 1 differ. Our local–global
conjecture predicts at least six colours are needed (no small residue plane bounds this field). **Nothing above three is proven.** FS-58
proved four for ℚ(√11), ℚ(√23), ℚ(√71), ℚ(√95), ℚ(√191) (four is exact there) and ℚ(√47) by finite certified graphs, and the same
instruments found nothing over ℚ(√167).

**Raised to rank 1 on 2026-09-17, and the reason changed the stub's purpose.** Kooshi adopted the local–global conjecture and set the
target at seven (`CLAUDE.md` § The mission). That makes this field the place to *attack* the belief rather than assume it: with G64,
the conjecture's proved range is L ≤ 3 generally, L ≤ 4 given √3 and L ≤ 5 for multiquadratic F ⊇ K; **L = 6 has no instance at all if
the wall holds; and L ≥ 7 is Hadwiger–Nelson itself.** So the cases between "proved" and "the whole problem" are nearly exhausted, and
**ℚ(√167) is the cheapest one left** — predicted ≥ 6, proven 3, with a three-colour gap at discriminant 668. A four here confirms the
level-4 clause at a field outside every proved class; **a proof that three suffices kills the conjecture's main clause outright**, which
is the single most valuable negative available to this project. Run it to find out which, not to confirm either.

## 2. What is known

* **The 3-adic barrier** [kernel, `ThreeAdicBarrier.lean`]: every unit-distance graph over ℚ(√167) whose edge directions have
  denominators prime to 3 is 3-colourable. A four-chromatic graph must use a direction with 3 in its denominator.
* **Two routes landed elsewhere** (FS-58 §R-B3, §R-B5): (a) a forced pair at `3u` in a thick piece of a 3-integral pool, then a
  four-copy chain (ℚ(√11)); (b) a ball in a *saturated 3-non-integral lattice* with short odd cycles refusing three colours outright
  (ℚ(√23), 47, 71, 95, 191). Every hit came from a lattice with covolume `≥ 10⁻⁴` and an odd cycle of length `≤ 9`.
* **ℚ(√167) at the height searched** [tools, `data/fs58/search-167/`]: 755 orbit classes to denominator 2520; no 3-non-integral
  saturated lattice of covolume `≥ 10⁻⁵` has an odd cycle within a 20,000-point cap; the coarse lattices with 7-cycles are 3-integral
  (3-colourable by the barrier). The quotient filter (a lattice with a 3-colourable finite quotient never refuses) kills 28 of 31
  candidates; of the three live, one is 3-colourable to 3,065,169 points, two are `Unknown` at 1,800 s (2.36M, 4.46M points).
* **Periodic colourings of 3-integral pools are affine** (FS-58 R-B1) and tensor products of the 3-adic plane with non-3-colourable
  residue planes are rigid (§0 O7): the rigidity that made ℚ(√11) land is present; what ℚ(√167) lacks at low height is short odd cycles
  through coarse, 3-non-integral structure.

## 3. Routes, cheapest first

* **R1 — decide the two live balls** (`q1+132+396.2` at 2.36M points, `q1+324+1620` at 4.46M): a checkpointed long solve or
  cube-and-conquer (price cubes on a sample first; break symmetry). A refusal is the result, via extraction as in FS-58 B5.
* **R2 — search beyond denominator 2520** for a saturated 3-non-integral lattice with an odd cycle, running the quotient filter before
  any ball (the filter is minutes, a ball is hours).
* **R3 — the chain route on 3-integral pools with 7-cycles** (FS-58 D3): thick pieces of `W₁₄₀` (covolume `2.8·10⁻⁵`, coordinates to 49)
  need physical margins that cost `10⁷` points; design pieces from the forcer shape found over ℚ(√11) (the 52-point forcer runs along a
  rational direction) rather than boxes.
* **R4 — the theory:** is the infinite 3-integral graph rigid at three colours (FS-58 D3.5: a finite forcer exists iff it is)? A proof
  would settle ℚ(√167) without a search.

## 3a. Traverse, don't search — four instruments recorded 2026-09-20 (from a conversation with Kooshi during FS-61)

*Kooshi's question: balls with colourings decide quickly; is there a cliff between three-colourable and not, and can the search be
turned into a gradient or a bisection instead of a blind enumeration of balls? The answer was already in FS-61's records. Written
here for a reader with no conversation memory; the measurements are FS-61's (`plans/FS61-quadratic-census.md`, "The owner's re-plan
after phase B′", ruling 3a; raw data `data/fs61/fields/*/balls.jsonl`).*

**What the records show (the phase diagram).** Put every asked ball at its **average degree** `2·edges/points` (734 balls, all tiers
and fields of FS-61): under degree 4 every ball is three-colourable in a fraction of a second; **degree 4–6 is the hardness peak —
39 of the 70 `Unknown`s, and every decided ball there is colourable** (random graphs have their 3-colouring threshold at degree
≈ 4.7; 25 `Unknown`s sit on control planes that are 3-colourable by theorem); **no ball below degree 6.6 has ever refused**; from
degree 14 up **nothing is undecided** — among balls of ≥ 200,000 points, 28 colourable and 15 refused, slowest 259 s. On a fixed
refusing lattice the *smallest* refusing ball is the slow one and larger radii refuse in seconds (47: 104 s at `R = 1.2`, 0 s at 1.5;
119: 114 s → 1 s; 95: 32 s → 1 s). **So hardness is not the signal of having crossed to four colours — it is the signal of standing
near the threshold, from either side — and the move is away from it, toward higher degree, where both answers are cheap.** Size is
not the wall; degree is.

**R5 — aim every ask by degree (solver-free, the gradient itself).** `degree ≈ g·φ(R)²`, `g` the lattice's unit-vector count,
`φ(R) = [2R²·acos(1/(2R)) − ½√(4R² − 1)]/(πR²)` the overlap of a radius-`R` disc with its unit translate, squared because a ball is a
bidisc (observed / predicted over the 734 balls: median 1.000, range 0.715–1.184). **Figure of merit of a lattice:
`N₁₄ = π²·R₁₄⁴ / covolume`, the points needed to reach degree 14** (`R₁₄` solves `g·φ(R)² = 14`). Rank every 3-non-integral
saturated lattice by `N₁₄` before any ball is built; ask once, at `R₁₄`; **never step down in radius** (FS-61's tier-`1b` ladder
1.5 → 1.2 → 1.0 stepped down in degree, into the hard band, and 24 of its 37 asks came back undecided). This also re-aims **R2**:
the lattice search beyond denominator 2520 should *maximise `g` at given covolume*, not merely find an odd cycle. **At 167:** the
best lattices known have `g` = 20–36 against 108 for the lattice that landed 11 — that, in one number, is why 167 is hard. The
36-vector lattice (`120|1,1,1,3;0,2,0,2;0,0,2,2;0,0,0,4`) reaches degree 14 at `R ≈ 1.67`, about 1.5 M points (5–8 GB, one worker);
the 20-vector lattices cannot reach degree 8 under 2 M points. **FS-61's tier `1c` asked it (2026-09-20): degree 14.0 on 1,474,541 points, three-colourable in 3.66 s** — so the
best lattice known at 167 is, on this evidence, colourable at every radius; at `NMAX = 420` 167 has 16 `Open` lattices, and almost
none reaches degree 8 under 2,000,000 points. 167 needs lattices with more unit vectors, not deeper asks of these. **Check first:** at what degree did FS-58's two `Unknown` balls (2.36 M and 4.46 M points, R1 above) sit? If under ~8,
R1 as written is aimed at the hard band and should be re-aimed before any cube-and-conquer is priced.
*Monotone axes that make bisection sound:* radius (balls are nested, so refusal is upward-closed in `R`); lattice inclusion
(`Λ ⊂ Λ′` ⟹ refusal passes up, colourability passes down — **verify whether the census driver propagates verdicts along inclusion;
if not, some `Open` lattices are already decided for free**); colours `k`.

**R6 — counterexample-guided growth: build the core bottom-up, staying on the cheap side.** The certified cores are tiny — 131 to
1,190 points — yet they are found by refusing balls of 45,000–600,000 points and shrinking (assumption cores, then deletion: hours
at 95). Invert it. Start from a short odd cycle through a 3-non-integral direction (the barrier, row 72, says one is needed). Loop:
(1) find a 3-colouring `c` of the current piece `P` — cheap, `P` is small and colourable; (2) collect the **killers** of `c`: lattice
points within the allowed region whose neighbours in `P` already show all three colours under `c` (adding one makes `c`
inextensible — this project's *fan / coverage* compulsion, rows 3–4, G13); (3) add a small batch chosen to kill the most colourings
in a *sampled pool*, not just `c` (M50's batch-halo idea, G33: batches compose by construction); repeat. It ends when `P` refuses —
and `P` is near the true core's size, so the refutation and its LRAT are small and there is no deletion stage — or when some
colouring has no killer in the region, which is a verified colouring of that region (a `Colourable` record). **Progress is
measurable at every step** (pool colourings surviving; R7's dial on `P`), which is what a ball refusal never gives. The lattice is
translation-invariant, so the obstruction is everywhere and the seed's position is free. *Pitfalls:* greedy growth can bloat along
one direction (keep `P` inside a ball of radius ~1.5: every refusal on record fits in diameter ≤ 3.6); near the end `P` enters the
hard band, but at thousands of points, not hundreds of thousands; a sampled pool measures the solver (row 13), so diversify the
sampler. *Controls before believing anything:* on 47, 71 or 119 it must reach a refusing piece of the order of the known cores
(169, 131, 456 points) in minutes; on a control plane (ℚ(√2), ℚ(√7)) it must terminate with an extending colouring and never
refuse; a planted missing edge must turn a refusing piece colourable.

**R7 — the rigidity dial: how close is a colourable piece to the cliff?** Sample many 3-colourings of a colourable ball (random
phases and seeds, a local-search sampler beside CDCL), normalise by the pinned edge, and aggregate **by difference vector `δ`**
using translation invariance: `P_same(δ)` = the fraction of (colouring, position) samples with `c(x) = c(x + δ)`. A free system
reads 1/3; structure shows as `P_same(δ)` near 0 or 1; **a forced pair is `P_same(δ) = 1` over all colourings.** The dial is the
fraction of probed `δ` that never vary, tracked against `R` and across lattices: it should climb toward the refusal radius, so it
ranks lattices from the *colourable* side, where every ask is cheap. **And it feeds the chain route directly (R3/R4, G55):** a `δ`
that never varies is a *candidate* forced pair; confirm it with one pinned refusal (`c(x) ≠ c(x + δ)`) on a small piece; and at 167
the chain's arithmetic hypothesis is nearly free — no usable prime below 23 means 2, 3, 5, 7, 11, 13, 17, 19 are all invertible in
the unit-vector ring, so *any* forced pair at a `δ` built from those primes lands the next colour, at three colours and again at
four and five. *Caveat, from this project's own ledger (row 13): pool statistics measure the solver, not the colouring space — a
never-varying `δ` is a candidate until the pinned ask refuses, and the dial is for ranking, never for a claim.*

**R8 — the order parameter on the refusing side.** For a ball that may refuse but will not decide, give a *finder* four colours and
minimise the number of vertices using the fourth (local search; the GPU's kind of work). Zero is a 3-colouring. A density of
fourth-colour vertices that stays clearly positive across many restarts is evidence — never proof — that the lattice refuses, and
how deep; its reciprocal estimates the core's size, which prices R6's growth budget.

**R9 — Kooshi's triangle as the seed of a forcer: the chain route, re-priced** (recorded 2026-09-20; he raised the triangle again
the day the phase diagram was found, and the two fit). *The object* is recorded in full, with credit, in
`plans/FS58-prelude-seven-cycle-gadget.md`: ℚ(√167)'s shortest odd cycle is a 7-cycle drawn as a triangle — a **run of three
collinear unit edges** from `0` to `3w`, `w = (0, −1)`, closed by two legs, each the long diagonal of a unit diamond
(`cos θ = 24/25`), apex `(√167/10, −3/2)`; 9 points, 11 unit edges; the Moser spindle is the same family's run-of-one member. **All
of its directions have denominator 140 — no 3 — so by the kernel barrier (row 72) it can never refuse on its own**, and the prelude's
experiment (unions of rotated copies to 50,000 points, 3-colourable in 0.6 s) confirmed that. What that experiment never asked is
the question the triangle is shaped for:
* **Its base is the chain route's target pair.** The kernel proof at ℚ(√11) rests on a 52-point forcer that makes `c(0) = c(3u)`
  along a rational direction; in any affine (rigid) 3-colouring of 3-integral material `3w` is a period. So the base `(0, 3w)` is
  the natural candidate forced pair at 167 and the triangle the natural seed. **The ask: on a piece of the pure 3-integral pool
  `W₁₄₀` (where the 7-cycles live) containing the run, is there a 3-colouring with `c(0) ≠ c(3w)`?** `UNSAT` is a finite forcer.
  Use only 3-integral material: the prelude measured that mixing in 3-non-integral rotations kills every additive colouring (16 → 0)
  and with them the rigidity a forcer needs. Its `R = 140` control had 16 additive colourings; whether it had any *non*-additive one
  was not asked — that is this ask.
* **The chain is explicit and short** [exact arithmetic, checked 2026-09-20]: with `w₂₄ = ((11 + √167) + i(−11 + √167))/24` and its
  Galois conjugate `w₂₄′ = ((11 − √167) + i(−11 − √167))/24`, both unit vectors, `w₂₄ + w̄₂₄ + w₂₄′ + w̄₂₄′ = 11/6`, so
  **`1/6 = 1 + 1 − w₂₄ − w̄₂₄ − w₂₄′ − w̄₂₄′` and `1/3` is a sum of twelve unit vectors**: twelve transported copies of the forcer
  chain `0` to `1` by periods `3uᵢ`, and the unit edge `(0, 1)` closes it (G55; FS-58 did it with four at ℚ(√11)). The 3 in the
  denominator enters only through the transports, exactly as the barrier requires. A shorter representation of `1/3` may exist; this
  one suffices.
* **The route needs nothing that 167 was found to lack.** R5's finding is that 167's *3-non-integral* lattices hold too few unit
  vectors (20–36) to refuse. The chain route never refuses a 3-non-integral ball; it needs a finite forcer in the 3-integral pool,
  and the denominator-140 lattice is rich (the prelude's `R = 140` union shows 50 directions up to sign — about a hundred unit
  vectors; **check the count**) at covolume `2.8·10⁻⁵`.
* **Re-priced by the phase diagram.** FS-58 (D3) priced *box-shaped* thick pieces at `10⁷` points and stopped (R3 above). A capsule
  around the run `[0, 3w]`, or a ball of radius ≈ 1.6 about its midpoint, is of order one to two million points at an average degree
  in the thirties — the regime where every ask on FS-61's record decided in seconds to minutes, colourable or not. It is **one pinned
  ask**, memory measured first (edges, not points, set the footprint at that degree). `UNSAT` ⟹ extract the forcer's core ⟹ twelve
  copies and an edge ⟹ **χ(ℚ(√167)²) ≥ 4**, the jackpot of this stub, by the route the kernel already knows. `SAT` ⟹ a verified
  non-affine colouring of that piece: thicken, or run R6 seeded on the triangle with the pin `c(0) ≠ c(3w)` as its target and R7's
  `P_same(3w)` as its progress bar.
* *Before running:* read FS-58 §D3 and §R-B3 for what was actually asked of `W₁₄₀` (so this is not a repeat); confirm `g`; and keep
  the control — the same pinned ask on the ℚ(√11) pool must reproduce the known forcer.

**Order for the subplan:** **R9's one pinned ask is the cheapest decisive experiment in this stub and goes first**, after its
"before running" checks. R5 is free and comes with it (it is a table). R6 with its controls is the instrument to build. R7 is an
afternoon on top of any sampler and serves both R6 and the chain route. R8 only if R6 stalls. R1's long solves come after all of
them, re-aimed by R5.

## 4. Registered expectations (candidates, to be registered at the subplan)

* R1 refuses at least one of the two live balls (low, 0.25): nothing in the colourable neighbour suggests it.
* R2 finds a qualifying lattice below denominator 10,000 (medium, 0.4).

## 5. Failure and jackpot clauses

* **Jackpot:** `χ(ℚ(√167)²) ≥ 4` — the conjecture's lower levels at the field it predicts six for, and FS-56's carried target.
* **Informative failure:** a proof that every graph over ℚ(√167) up to some height is 3-colourable by an explicit non-residue rule.
* **Not a failure:** an `Unknown` at a budget.

**Bearing on χ(ℝ²) ≥ 6:** none directly; high for the conjecture's account of fields no residue plane bounds.
