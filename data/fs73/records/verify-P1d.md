# FS-73 P1d — independent verification of the two forced pairs `8/9` and `v = −(4/9)(1 + √−11)` over K

*Verifier: an independent de Bruijn (Opus 5.5) agent briefed by the product owner, 2026-09-23. One writer (this agent).
Machine: the desktop. Every solver ask and proof check ran under the shared heavy lock.*

## Verdicts, in one table

| check | verdict | evidence |
|---|---|---|
| 1. Rebuild: rank 4, 54 unit vectors, `1/9, 4/9 ∈ Λ`, 39,829 points, 366,660 edges, common neighbours | **pass, every number matches** | own exact code; ball count confirmed a second way (generation from the basis) and the HNF against PARI |
| 2a. The ball is four-colourable | **pass** | Theorem B's residue colouring at each prime above 2, verified on all 733,320 directed edges |
| 2b. Negative controls must NOT be refused: `δ = 2` (pair `±1`), `δ = 4/9` (pair `±2/9`) | **pass** | Glucose returns SAT in seconds; each separating colouring verified edge by edge, independently of the CNF |
| 2c. Positive control: Harder's `8/3` (pair `±4/3`) must be refused | **pass** | Glucose UNSAT, 13.2 CPU s; DRUP proof VERIFIED by drat-trim |
| 3a. `8/9` (pair `±4/9`) | **refused** | Glucose UNSAT, 130.2 CPU s; proof VERIFIED by drat-trim (186 s) |
| 3b. `v` (pair `∓(2/9)(1 + √−11)`) | **refused** | Glucose UNSAT, 37.2 CPU s; proof VERIFIED by drat-trim (43 s) |
| 4. Span of the point-group orbits of `8/9` and `v` is exactly `8Λ` | **pass**, with a finding | index 4096; but **`v`'s orbit alone spans `8Λ`**, and `8/9`'s orbit spans only a rank-2 subgroup of it (see Doubts) |


**Independence.** Before the verdicts below were in, this agent read only: `CLAUDE.md` from disk (§ "The standard of evidence
above rung B", § Toolchain, the gate's paragraphs on negative controls), the two replication recipes in
`data/fs73/records/phase-P1.md` (§ "The replication recipe for `8/9`" and § "…for `v`"), and
`plans/FS73-rigidity-dichotomy.md` §0. It did **not** read `tools/fs73_lattice.py`, `tools/fs73_screen.py`, any CNF or file
under `data/fs73/census/`, or the rest of the phase record. Every tool below (`tools/fs73v_*.py`) was written from the recipe.

## Theorems this phase proved

None. Verification is measurement. The exact computations below are tools-grade facts about the recipe's objects (no kernel
involvement), listed so the close can file them:

| fact | grade | where |
|---|---|---|
| The ball of radius 3/2 (both embeddings) in de Grey's lattice Λ over K has 39,829 points and 366,660 unit edges; `|U| = 54`; `1/9 ∈ Λ`, `1/18 ∉ Λ` | [tools], exact integer arithmetic | `tools/fs73v_lattice.py` |
| Every proper 4-colouring of that ball identifies `±4/9` (δ = 8/9), `∓(2/9)(1 + √−11)` (δ = v) and `±4/3` (δ = 8/3) | [cert] — Glucose DRUP refutations accepted by drat-trim, a checker independent of the solver and of the census's solvers | check 3; `build/fs73v/*.drat` (regenerable) |
| The ℤ-linear automorphisms of Λ preserving U form a group of order 24, `⟨ζ₆·⟩ ⋊ Gal(E₄/ℚ)` | [tools], exact | `tools/fs73v_orbits.py` |
| The span of `v`'s orbit under that group is exactly `8Λ` (index 4096); `8/9`'s orbit spans the rank-2 `(8/9)ℤ[ζ₆] ⊂ 8Λ` | [tools], exact | `tools/fs73v_orbits.py` |

The consequence the census draws (every 4-colouring of `Cay(Λ, U)` is `8Λ`-periodic) follows from rows 2–4 by translation and
automorphism invariance of the forced set; it is the census's theorem, and this record only re-verifies its inputs.

## Check 1 — the rebuild (own representation, own saturation of U, no floating point in any decision)

**Representation.** A point `z = x + iy` of the plane over `K` lies in the quartic CM field `E₄ = ℚ(√−3, √−11)` (every
generator `ζ₆^m ρ^n` does). Stored on the ℚ-basis `(1, √−3, √−11, √33)`, scaled by 36 to integers `(A, B, C, D)`; then
`x = (A + D√33)/36`, `y = (B√3 + C√11)/36`. With `S = A² + 3B² + 11C² + 33D²` and `T = AD + BC`, the two complex embeddings of
`E₄` (the four real embeddings of `K`, in pairs) give `|τ(z)|² = (S ± 2T√33)/1296`. So, in integer arithmetic only:
- unit vector ⟺ `S = 1296` and `T = 0`;
- ball of radius 3/2 in both embeddings ⟺ `S ≤ 2916` and `132·T² ≤ (2916 − S)²`.

**U** was saturated by exhaustive enumeration of every integer `(A, B, C, D)` with `S = 1296` (bounds `|A| ≤ 36`, `|B| ≤ 20`,
`|C| ≤ 10`, `|D| ≤ 6`, each exact), filtered by `T = 0` and exact lattice membership (the HNF of the 30 generators, own code).
This is the recipe's second enumeration done independently; it is exhaustive because every element of Λ lies in `(1/36)ℤ⁴`
(the generators do, re-proved by the code). **The ball** by exhaustive enumeration of the integer box `|A| ≤ 54`, `|B| ≤ 31`,
`|C| ≤ 16`, `|D| ≤ 9` (4,305,609 points; bounds exact from `S ≤ 2916`), filtered by the exact ball predicate and membership.
**Edges** by lookup of `p + u` for every point `p` and every `u ∈ U`.

| quantity | recipe | this rebuild | verdict |
|---|---|---|---|
| rank of Λ | 4 | 4 (HNF of `36Λ`: rows `(1,1,1,3), (0,2,0,2), (0,0,2,2), (0,0,0,4)`, index 16 in ℤ⁴) | match |
| coordinates in `(1/36)ℤ` | yes | yes (`1/36 ∉ Λ`, `1/18 ∉ Λ`) | match |
| `|U|` | 54 (30 generators + 24) | 54 (30 generators, all distinct, all in U; 24 more) | match |
| `1/9 ∈ Λ`, `4/9 ∈ Λ` | yes | yes (HNF coefficients `(4,−2,−2,−1)` and `(16,−8,−8,−4)`) | match |
| ball points | 39,829 | 39,829 (none on the boundary sphere, so `≤` versus `<` is immaterial) | match |
| edges | 366,660 | 366,660 | match |
| `±4/9`: in Λ, in ball, common neighbours | yes, yes, none | yes, yes, **0**; both endpoints have degree 54 | match |
| `∓(2/9)(1 + √−11)`: in Λ, in ball, common neighbours | yes, yes, "some" | yes, yes, **2**; both endpoints have degree 23 | match |

`tools/fs73v_lattice.py` (build: 0.75 s user, 0.35 GB, desktop).

Cross-checks of the rebuild. (i) The Hermite normal form of `36Λ` from this file's own routine and PARI's `mathnf` describe
the same lattice (each basis lies in the other; determinant 16). (ii) The 39,829 ball points were found a second way, by
generating integer combinations of the four basis rows rather than filtering the box by membership; the two sets are
identical. (iii) A floating-point view of the 54 unit vectors deviates from modulus 1 by at most `1.1·10⁻¹⁶` in both
embeddings. This was a sanity print only and decided nothing.

The 24 unit vectors beyond the generators, for the record (coordinates `(a, b, c, d)`, meaning `a + b√−3 + c√−11 + d√33`):
`±(2/3, ±2/9, ±1/6, ·1/18)` (8 vectors), `±(1/4, ±1/12, ±1/4, ·1/12)` (8), `(0, ±4/9, 0, ±1/9)` (4), and `(0, ±1/6, 0, ±1/6)` (4),
the signs of the last coordinate being tied to the others (`T = AD + BC = 0`). The list is in the tool's output.

## Check 2 — controls, before any refusal is believed

**2a. The ball is four-colourable.** The colouring is Theorem B's residue colouring at a prime of `E₄` above 2, computed by this
file's own reduction map. On the integral basis `{1, ζ₆, θ, ζ₆θ}` with `θ = (1 + √−11)/2`, a point
`z = a + b√−3 + c√−11 + d√33` has coordinates `(a − b − c − d, 2b + 2d, 2c + 2d, −4d)`, all 2-integral for every ball point
(asserted). The map sends `ζ₆ ↦ ω` and `θ ↦ ω^s` in `𝔽₄ = 𝔽₂(ω)`; `s = 1, 2` are the two primes above 2, each fixed by
conjugation. Both colourings are proper on all 733,320 directed edges, recomputed from U and independent of any CNF, and each
uses all four colours. As expected, both identify every pair asked below, since every `δ` asked is divisible by 2.

**2b. Negative controls.** Encoding as in check 3.

| pair | `δ` | solver | verdict | CPU s | separating colouring |
|---|---|---|---|---|---|
| `±1` | 2 | PySAT Glucose 4, break `nb` | SAT | 1.44 | verified: 0 monochromatic of 733,320 directed edges, `c(p) ≠ c(q)` |
| `±1` | 2 | Glucose binary, break `cn` (the common neighbour is the origin) | SAT | 4.0 | verified likewise |
| `±2/9` | 4/9 | PySAT Glucose 4, break `nb` | SAT | 4.14 | verified likewise |

Both outcomes were reachable: the same encoding refuses in checks 2c and 3. The colouring checker has its own negative
control: recolouring one vertex to its neighbour's colour makes it report exactly that edge (2 directed), and the faithful
colouring reports 0.

*A note on the brief:* it described `2` as "separable by a period-2 colouring". No period-2 colouring can separate `δ = 2`,
because `2 ∈ 2Λ`. My separating colourings are colourings of the ball only; I did not look for a periodic one.

**2c. Positive control: Harder's 8/3** (pair `±4/3`, degree 11 each, no common neighbour). Glucose UNSAT in **13.21 CPU s**
(167,447 conflicts), against the census's ~122 s with CaDiCaL. The DRUP proof (42,773,619 bytes, binary) is **VERIFIED** by
drat-trim in 12.8 s; its core holds 23,307 of the 1,745,446 clauses.

## Check 3 — the two pairs, re-asked with this verifier's own encoding

**Encoding** (`tools/fs73v_sat.py`; different from the recipe's in every choice the recipe names):
- vertex order is a seeded random permutation (seed 20260923), and clause order is shuffled with the same generator;
- variables are colour-major, `x(v, c) = c·n + pos(v) + 1`;
- **exactly one** colour per vertex: one at-least-one clause and all six at-most-one clauses;
- `¬x(u,c) ∨ ¬x(w,c)` for every edge and colour;
- the pins `x(p, 0)`, `x(q, 1)`;
- **one** break of the residual 2↔3 symmetry, never two:
  - **`cn`** pins a common neighbour `w` of `p` and `q` to colour 2. *Proof of soundness:* in any proper colouring with
    `c(p) = 0`, `c(q) = 1`, `w` is adjacent to both, so `c(w) ∈ {2, 3}`. If `c(w) = 3`, applying the transposition (2 3) to
    the whole colouring keeps it proper, keeps both pins, and makes `c(w) = 2`.
  - **`nb`** is the unit clause `¬x(w, 3)` for one neighbour `w` of `p`, used when there is no common neighbour. *Proof:* the
    same transposition, applied when `c(w) = 3`.
  - The relabelling `c(p) ↦ 0`, `c(q) ↦ 1` is sound because `c(p) ≠ c(q)` in any colouring the ask admits.
- So UNSAT means that **every proper 4-colouring of the ball gives `p` and `q` the same colour**. The ball is a subgraph of
  `Cay(Λ, U)`, so every 4-colouring of the lattice graph has `c(x) = c(x + δ)` for all `x`.

**Solver.** Glucose, built from `github.com/audemard/glucose` at commit `674dbba7` (2025-12-30): `simp/glucose_release`
(sha256 `6f7e4c70…`), run with `-certified -vbyte` (binary DRUP streamed to disk) and `-cpu-lim=3600`. Glucose is MiniSat
lineage and shares no code with CaDiCaL or kissat. Cryptominisat 5.15 was rejected, because its version banner shows it
embeds CaDiCaL. **Proof checker:** drat-trim, built from `github.com/marijnheule/drat-trim` at commit `2e3b2dc0` (2024-11-25).
Every proof check is run as a **pair**. The faithful formula must print `s VERIFIED`. The same proof against the formula with
the pin on `q` deleted must not: that formula is satisfiable, which the tool proves by exhibiting a model (Theorem B's
colouring, relabelled), so no refutation of it can exist. `tools/fs73v_proofcheck.py`.

| pair | `δ` | break | CNF sha256 (vars / clauses) | verdict | CPU s | conflicts | proof (bytes, sha256) | drat-trim faithful | drat-trim planted |
|---|---|---|---|---|---|---|---|---|---|
| `±4/3` (control) | 8/3 | `nb` | `f173d288…` (159,316 / 1,745,446) | UNSAT | 13.21 | 167,447 | 42,773,619, `d3f2750f…` | VERIFIED, 12.8 s, core 23,307 clauses | NOT VERIFIED |
| `±4/9` | **8/9** | `nb` | `c645e66d…` (same sizes) | **UNSAT** | **130.19** | 1,365,913 | 229,033,560, `c3745c98…` | **VERIFIED**, 186 s, core 69,803 clauses | NOT VERIFIED |
| `∓(2/9)(1+√−11)` | **v** | `cn` | `777c2997…` (same sizes) | **UNSAT** | **37.19** | 459,684 | 91,653,743, `7cc573f7…` | **VERIFIED**, 43 s, core 26,632 clauses | NOT VERIFIED |

The proofs are in `build/fs73v/`, which git ignores; each can be regenerated from its CNF (rebuilt deterministically by
`tools/fs73v_sat.py`) in the CPU time shown. Full digests are in `data/fs73/records/verify-P1d-asks.jsonl`.

## Check 4 — exact algebra: the span of the orbits is `8Λ`

`tools/fs73v_orbits.py` does not assume the point group; it computes it. It takes every ℤ-linear bijection of Λ that maps U
onto U, which are exactly the additive graph automorphisms fixing 0. The search runs over images of the ℚ-basis
`(1, ζ₆, ρ, ζ₆ρ)` in U, staged through the six roots of unity, with exact rational arithmetic.
- **The point group has order 24.** It equals the group generated by multiplication by `ζ₆` and the four automorphisms of
  `E₄/ℚ` (complex conjugation, `σ₃: √−3 ↦ −√−3`, and `σ₁₁: √−11 ↦ −√−11`), so no exotic linear symmetry exists.
- Multiplication by `ρ` is not in it.
- Orbit of `8/9`: 6 elements. Their span has **rank 2**, `(8/9)ℤ[ζ₆]`, and lies inside `8Λ`.
- Orbit of `v`: 12 elements. **Their span alone is exactly `8Λ`**: its Hermite normal form equals `8·HNF(Λ)`, and its index in
  Λ is 4096.
- The two orbits together also span exactly `8Λ`.
- `Λ` is free of rank 4, so `Λ/8Λ ≅ (ℤ/8)⁴`.

## Doubts, however small

1. **The whole `8Λ` conclusion rests on `v` alone.** `8/9 ∈ span(orbit(v))`, because
   `(4/9)(1 + √−11) + (4/9)(1 − √−11) = 8/9`. So `8/9`'s refusal is implied by `v`'s, adds nothing to the span, and is a
   consistency check rather than an independent leg. Had `v` failed, the forced group would have been known only to contain
   the rank-2 group `(8/9)ℤ[ζ₆]`. The claim as stated ("both … together … generate `8Λ`") is true, but it presents two legs
   where there is one.
2. **The recipe's CNF for `v`, read as written, combines two breaks of the same colour symmetry.** It says the `v` CNF is
   "identical to `8/9`'s" (which has value precedence of colour 2 over colour 3) "except the pair", and that it pins a common
   neighbour to colour 2. Both constraints break the 2↔3 swap. Together they are unsound in general: after the pin, the
   first vertex in the order coloured from {2, 3} may be forced to 3, and no swap is left to fix it. A refusal from that CNF
   could therefore be an artefact. **It is not one here: my encoding, with one sound break (check 3), refuses `v` too.** But
   the recipe, or the census code behind it, should be read for which it is (see the comparison below), and the census's
   other refusals using the same combination, if any, need the same check.
3. **Not checked here:** the other half of the sandwich, `P_found = 8Λ`. That half says every `δ ∉ 8Λ` is separated by some
   exhibited periodic colouring, and "`F = P = 8Λ`, the question settled at K" needs it as much as it needs the refusals. My
   negative controls separate `2` and `4/9` on the ball only; that is a local fact, not a periodic colouring of Λ. A cheap
   independent check: `F/8Λ` is a subgroup of `(ℤ/8)⁴` stable under the order-24 point group, and it is trivial exactly when
   it holds no element of order 2. So it suffices to verify one exhibited periodic colouring separating `4λ` for one
   representative `λ` of each point-group orbit on the 15 nonzero classes of `Λ/2Λ`.

## Reproduction (every command from the repository root; scratch = the verifier's scratchpad directory)

```
python3 tools/fs73v_lattice.py                 # check 1 (0.8 s)
python3 tools/fs73v_controls.py                # pair facts + residue colouring (check 2a), 4 s
python3 tools/fs73v_orbits.py                  # check 4, 2.5 s
python3 tools/fs73v_sat.py two --brk nb --solver glucose4            # check 2b, SAT in seconds
python3 tools/fs73v_sat.py <pair> --brk <nb|cn> --solver glucose-ext --proof build/fs73v/proof-<pair>-<brk>.drat
python3 tools/fs73v_proofcheck.py <pair> <brk> build/fs73v/proof-<pair>-<brk>.drat
```
`glucose-ext` and the proof checker need the two binaries built from source in scratch (commands: Glucose `cd simp && make r`,
drat-trim `gcc -O2 -o drat-trim drat-trim.c`, both with `LIBRARY_PATH` unset — the Lean dev environment's `LIBRARY_PATH` breaks
the system linker). Pairs: `eight_ninths` (`nb`), `v` (`cn`), `harder_eight_thirds` (`nb`), `two`, `four_ninths`.

**What a kill redoes.** Each ask is one solver call (≤ 1 h budget; actual ≤ 131 CPU s) and each proof check one drat-trim call
(≤ 186 s); results are appended to the jsonl at each completion, so a kill redoes at most the one call in flight.

## Budget spent (desktop, CPU seconds)

Rebuild and algebra ~15 s; negative controls ~10 s; Glucose asks 13 + 37 + 130 = 180 s; drat-trim 2 × (13 + 43 + 186) ≈ 485 s;
the abandoned brute-force point-group search 5 min (replaced by the staged search, 2.5 s). No run exceeded 0.7 GB.
