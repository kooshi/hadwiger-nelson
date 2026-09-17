# FS-61 — which real quadratic fields need four colours, and why

*Minted 2026-09-17 at FS-58's close. Read beside: `plans/FS58-four-colours.md` (§2, §R-B4, §R-B5, §C), `data/fs58/search-23/README.md`,
`CLAUDE.md` G48, G55, G61.*

## 1. The question

The local–global conjecture predicts `χ(ℚ(√d)²) = L(ℚ(√d))` (the best residue-plane bound) whenever `L ≤ 6`. FS-58 proved `χ ≥ 4` by
finite witnesses for `d = 11, 23, 47, 71, 95, 191` — every one `≡ 2 (mod 3)` and `≡ 3 (mod 4)` — and nothing for 167. **Map the real
quadratic fields**: for which `d` does the direct route (saturated 3-non-integral lattice → quotient filter → ball refusal → extraction)
land, and what arithmetic decides it?

## 2. What to measure and what to explain

* **The census:** squarefree `d < 500` (at least), each with its `L(ℚ(√d))`, the route's outcome, the witness size, and the
  lattice statistics (covolume, least odd cycle, the classes used). Minutes per field (FS-58 B5's scan ran six fields in ten minutes).
* **The known values to reproduce** (controls): `χ = 2` for `d ≢ 3 (mod 4)` (`[Fischer1990]`), `χ = 3` for `d ≡ 0, 1 (mod 3)` with an odd
  cycle (`[Moorhouse2010]` Cor. 8.3), so the route must *fail* there — a refusal at such `d` is an instrument defect, not a finding.
* **Readings to test:** (i) short odd cycles in a coarse 3-non-integral lattice decide landing at low height (FS-58 §R-B5);
  (ii) the 2-adic obstruction for `d ≡ 7 (mod 8)` (no diamond chord of odd rational parity) and its effect on witness size;
  (iii) the ratio-bound reading R-C (G60) as the asymptotic explanation — carried here from FS-58's phase E; its prior art (equidistribution
  of norm-one elements, `[AkhtariVaalerWidmer2025]`; `[DutourSikiricEtAl2021]` for the fixed-height bound) is in `BIBLIOGRAPHY.md`.
* **Prior-art owed:** the multiplicativity of `K₃` (3-colourings of `G × H` with `χ(H) > 3` factor through `G`; Häggkvist–Hell–Miller–
  Neumann-Lara 1988, Greenwell–Lovász 1974) behind FS-58 D3.4; Johnson's 2000 status report and `[Johnson2006]` for any printed value.

## 3. Expectations and clauses

* The route lands for most `d ≡ 2 (mod 3)`, `≡ 3 (mod 4)` with `d < 300` and small `L` (medium).
* **Jackpot:** a theorem — every real quadratic field with a usable plane at 7 has `χ = 4` — from a uniform construction.
* **Informative failure:** a field with `L = 4` whose plane is 3-colourable — the conjecture's level-4 clause refuted.

**Bearing on χ(ℝ²) ≥ 6:** none directly; it tests the conjecture's lower levels across a family, which is the programme's method.
