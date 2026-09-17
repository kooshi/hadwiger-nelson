# FS-59 — four colours over ℚ(√167)

*Minted 2026-09-17 at FS-58's close. Written for a session with zero conversation memory. Read beside: `plans/FS58-four-colours.md`
(§2 D1–D3, §R-B2–B5, §C), `plans/FS58-prelude-seven-cycle-gadget.md`, `data/fs58/search-167/README.md`, `CLAUDE.md` G59, G60, G61.*

## 1. The question, in plain language

Colour the points of the plane whose coordinates lie in ℚ(√167) so that points at distance exactly 1 differ. Our local–global
conjecture predicts at least six colours are needed (no small residue plane bounds this field). **Nothing above three is proven.** FS-58
proved four for ℚ(√11), ℚ(√23), ℚ(√71), ℚ(√95), ℚ(√191) (four is exact there) and ℚ(√47) by finite certified graphs, and the same
instruments found nothing over ℚ(√167).

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

## 4. Registered expectations (candidates, to be registered at the subplan)

* R1 refuses at least one of the two live balls (low, 0.25): nothing in the colourable neighbour suggests it.
* R2 finds a qualifying lattice below denominator 10,000 (medium, 0.4).

## 5. Failure and jackpot clauses

* **Jackpot:** `χ(ℚ(√167)²) ≥ 4` — the conjecture's lower levels at the field it predicts six for, and FS-56's carried target.
* **Informative failure:** a proof that every graph over ℚ(√167) up to some height is 3-colourable by an explicit non-residue rule.
* **Not a failure:** an `Unknown` at a budget.

**Bearing on χ(ℝ²) ≥ 6:** none directly; high for the conjecture's account of fields no residue plane bounds.
