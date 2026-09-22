# FS-70 — the owner's review of phase 1b (the CM lattice with the wall-breaker), 2026-09-22

*Scored by artifact against `data/fs70/records/phase-1b.md` (commits `6a3612d5` … `f5f3b06e`). Implementer: Opus 5, ≈545k tokens.*

## 1. Verdict: ACCEPTED. No refusal; the fabric is the densest built and the freest measured.

| what | how I checked | result |
|---|---|---|
| The L6 screen row (`group6:u3:2+zeta6:rho15`: `M = 144`, rank 6, `g = 54`, no additive colouring of either kind, every target live) | against `po_cm_lattice.py 2 rho15` (mine) | identical to the integer |
| The twelve unit vectors beyond the 42 generators are the ζ₆-orbit of `v = (1+i√15)/4` and its conjugate, because `ρ₁₅ = −v̄²`; hence `½ = v + v̄ ∈ Λ` and the empty additive family is the plan's §3.4 **theorem** | by hand | right, and it corrects my review of phase 1, which reported the empty family as a computation |
| The 14-core of the sums-of-≤-5 ball: 217,015 points, 2,059,614 edges, average degree 18.98, `forces 4/3` SAT in 1.17 s | `po_verify_ask.py` (mine; 1,084 unit vectors over denominator 144, complete unit-distance graph by translate lookup) | **my edge set equals the file's exactly; the colouring is proper; the pair is separated** |
| The arena at ρ₁₅ on the CM base: 54,433 points, 78 cross edges (30 diagonal, 48 off-diagonal), G53's counting ratio `L = 0` of 30 at every base radius, control SAT in 0.15 s | the record's anatomy against G52/G53's definitions | consistent; the compulsion is absent, not weak |
| Five instrument defects found by running (the streaming CNF writer silently refusing three asks; a control refused on unparsable specs; a core command that raised after printing; a plant red for the wrong reason; scratch-only logs) | the record's account of each, with the plant that now fires | in order — every one biased toward looking like work done, and every one caught before a verdict rested on it |

## 2. What phase 1b adds to the null

* **Rank 6 is the lever on density:** the rank-8 lattices' 14-cores are empty; L6's 14-core exists at degree 18.98 on 16 % of
  the points, and **the solve time falls as the density rises** (8.2 s at degree 14.1; 1.2 s at 19.0 on twice the vertices) —
  G65's colourable regime, far from any threshold.
* **One fact does all the killing on L6 and all the freeing:** `½ ∈ Λ` (the 2-adic wall broken inside the lattice) removes every
  additive colouring, every Kempe swap and every `2Λ`/`4Λ`-periodic rule at once, which is exactly why only a solver can speak
  there — and the solver colours everything.
* The `|n| ≤ 3` step is priced and declined (a complete saturation needs ≈ 195 GB or 1.8·10⁸ `qfminim` vectors), not skipped.

## 3. Ruling

The milestone is one phase from closing on a typed null. **Phase 1c runs the literature's own method — the rotation sweep
over every in-field rotation that creates cross edges on the CM base (Heule's and Voronov's `W = M_s ∪ ψM_s`, ranked by new
edges)** — because phase 1b asked that shape at one rotation only. After it, the close (mine): ledger row, grokking, the stub's
banner, FS-48's siblings re-aimed through the screens, the Kempe screen minted as a stub against FS-61's lattices.
