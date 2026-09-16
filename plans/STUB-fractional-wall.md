# FS-57 — the fractional wall: refuse six colours at the members that can be reached

*Minted 2026-09-16 at FS-54's close, from Kooshi's question "Is it possible to attempt to prove that 6 is impossible?" and the
assessment in `plans/FS54-twenty-seven.md` §W. Written for a session with zero conversation memory. Read beside: `CLAUDE.md`
G56, **G59**; `reference/wall-at-six/WALL-AT-SIX.md` (§2 W and W_f, §4, §6.3) and its two responses in
`reference/wall-at-six/responses/`; `plans/FS54-L3-certificate-soundness.md`; `data/fs54/d4/README.md`;
`data/fs54/char2/README.md`.*

## 1. The statement, and why it is finite

The **finite residue targets** are U_Q = Cay(𝔽_{Q²}, μ_{Q+1}) for Q ≡ 3 (mod 4) of odd exponent (the finite Euclidean planes
Γ_q) and for Q a power of 2. **The wall W** says none of them has chromatic number exactly 6; equivalently no number field has
local bound 6, so the residue method can never certify six. Every Q is settled except **23, 27, 31, 43, 47 and 64** (below 23
the targets are ≤ 5-colourable; 59, 67, 71, 79, 83 refuse six by certificate or spectrum; Weil refuses six from 98, and
Hoffman from 128 in characteristic 2). So W is six finite graph statements.

**W_f, the fractional wall** (first response to the wall document, credited GPT Astra): α(U_Q) < Q²/6 at the six. It implies
W with no heuristic (χ ≥ ⌈χ_f⌉ = ⌈Q²/α⌉), and by Zhang's and Zhu's product theorems it also rules six out for every composite
residue target built from first-level primes (`CLAUDE.md` G43/G59).

## 2. Where each member stands, and what reaches it

| Q | W_f needs α ≤ | best certified | drop needed | largest found | instrument, measured price | verdict |
|---|---|---|---|---|---|---|
| **47** | 368 | 371 (three-point, converged) | **0.76 %** | 265 | level-3 GLV relaxation: 4,121,921 variables, 462 blocks (orders 529–1,128), 26 GB RAM, **5.15 s/iteration on graphics card A**, checkpoint at 340 its (`data/fs54/d4/ckpt/admm-q47-l3.npz`); projected **6,400–16,000 iterations, 9–23 h (low confidence)**; decision point ≈ 1,500 its (~2 h, 1,000 past the warm-up peak); certificate producer needs a port (hours) | **in reach** |
| **64** | 682 | 768 (Hoffman = Delsarte LP) | 11.2 % | 512 (KaMIS, 6 seeds of 6) | three-point SDP ported to characteristic 2: G₀ = μ₆₅ ⋊ C₁₂ (order 780, nauty-exact), real blocks of size ≤ 64; needs 0.888 of Hoffman, reached by 5 of 9 odd planes | **plausible** |
| 23 | 88 | 108 | 18.5 % | 87 | level 3 drops 3–4.5 %; nothing priced reaches it | not in reach |
| 27 | 121 | **141** (level 3) | 14.2 % | 117 | level 3 already spent | not in reach |
| 31 | 160 | 200 | 20.0 % | 146 | — | not in reach |
| 43 | 308 | 365 (three-point, stopped iterate) | 15.6 % | 258 | — | not in reach |

**Side results on the way, each a first digit rather than a wall step:**
* **Five refused at 23**: the level-3 calibration iterate reads 105.431 < 106 at 3,500 iterations
  (`data/fs54/d4/ckpt/calib-q23.npz`); `tools/fs54_l3_cert_round.py` reads it; ≈ 1 CPU-hour to an exact certificate. **This is
  also FS-56's precondition** — FS-56 runs it first.
* **Five refused at 31** needs N < 193, 3.92 % under the converged 200.88; level 3 at 31 is ~7× the size of 27 (estimated).

## 3. Why no single theorem carries W, and the routes that might

* **No uniform bound works.** α ≤ c·q^{3/2} proves W at 23 only with c < 0.799, but α(19) ≥ 76 gives c ≥ 0.918. A proof must
  use something that changes between 19 and 23, or go member by member.
* **Exact search does not reach.** KaMIS's exact branch-and-reduce on UD(𝔽₁₉,2) with unit weights sat at 70 for 600 s, below the
  heuristic's 76 (`build/fs54-exact/q19-bnr.log`, regenerable); CDCL was undecided at 23 even for sizes above Hoffman's bound
  (`data/fs50/nscale/`).
* **Higher levels of the hierarchy**: price level 4 (or the level-2 Lasserre moment matrix, `[LPS2017]`/`[GMS2012]`) at 23, the
  smallest hard member, calibrated at 19 (level 3 reads 81.5 there against the found 76).
* **Structure, the idea-shaped route**: prove that every independent set above some size is periodic under a subgroup. The
  exhaustive periodic search at 27 tops out at **117** (`data/fs54/periodic-alpha-q27.json`), so such a theorem settles 27
  outright. At 64: sets periodic under an 𝔽₂-subspace of dimension ≥ 8 have ≤ 512 points [proof], and a 683-set must put
  ≥ 50.2 % of its nontrivial Fourier energy on the 195 least-eigenvalue characters [proof] — the first step of a stability
  version of the second response's U₃₂ rigidity theorem (Hoffman equality ⟹ hyperplanes).
* **The finding side at 27** (FS-54's unrun D5): a six-colouring search seeded from structure — the 117-sets as a fixed class,
  the antipodal quotient (FS-55) — since `plane-colour` from random starts cannot find even 7 or 8 colours at 27 (D97).

## 4. Order and stop rule

1. 47 to its decision point (~2 h), re-project from its own curve, then run to a certificate if the projection holds.
2. The characteristic-2 three-point port at 64, then its solve (minutes).
3. Price level 4 at 23 (pricing only).
4. **Stop rule:** if step 3 finds no route for 23, 27, 31 or 43, write the wall up as proved at the members that fell and
   open at the rest, and stop.

**Bearing on χ ≥ 6:** none directly — W is a statement about what the residue method can certify, and it neither proves nor
refutes χ(ℝ²) ≥ 6. Its value is structural (G59) and it sharpens FS-56's prediction from "≥ 6" to "7".
