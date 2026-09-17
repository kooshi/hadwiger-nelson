# data/fs58/chain-11 — FS-58 phase B over ℚ(√11): the direction pool W₃(N) and the quotient screen

Plan: `plans/FS58-four-colours.md` §2 D3.7, §3 "Phase B in detail" (B0, B1), §M3 "Tool surfaces", §G rows B.
Tool: `tools/fs58_chain.py` (untrusted; exact integer arithmetic for every edge, membership and group computation; floats only
for the spectral readings). Regenerate everything with `bash data/fs58/chain-11/run-all.sh` (about 8 minutes from empty on the
desktop — six 36-vector screens of about 45 s and one 100-vector screen of about 130 s, plus pools and controls — and
seconds when the records exist). It is resumable: `screen` skips every (L, u) line and every lattice line already on
disk. For a detached run, copy the script to scratch and launch the copy with `setsid`; the header of `run-all.sh` has the
command.

## What the screen asks

A vector `(a, b, c, e)` over `N` is the point `((a + b√11)/N, (c + e√11)/N)`. `W₀ = W₃(N)` is every unit vector with
denominator dividing `N` (3 ∤ N, N even), and `Λ₀` is their ℤ-span (rank 4). A quotient is a full-rank sublattice
`L ⊂ Λ₀` (the rows of a 4 × 4 integer matrix, in the pool's basis coordinates). The quotient graph is `Cay(Λ₀/L, W₀)`, and
the pair for a direction u is `(0, 3u)`. If no generator lies in L and a proper 3-colouring of the quotient gives the two
ends of the pair different colours, then no graph whose edge vectors all lie in W₀ forces the pair (D3.7). That would kill
W₀ for u.

## Results (2026-09-17)

* **The brief's six denominators give one pool.** `W₃(N)` for N = 10, 20, 40, 70, 140, 280 is the same 36 vectors (24 outside
  ℚ(i)): every pool record has the same `vector_set_sha256` and identical generator coordinates. The reason: a unit vector is a
  norm-one element z of ℚ(√11, i) over ℚ(√11), which is integral at every prime fixed by conjugation, since
  v(z) + v(z̄) = 0. The primes above 7 and above 2 are such primes, so 7 never enters a denominator, and 2 enters only
  through x = (z + z̄)/2, which 10 already allows. The first denominators that
  grow the pool are 50 (100 vectors), 130 and 230 (108 each) and 250 (196). Their pool records are here, and 50 was also
  screened (beyond the brief).
* **No kill, at any N.** Every u is *not killed at budget*. The budget was the 11 principal lattices mΛ₀ plus 50 random
  loop-free HNF lattices of index ≤ 10⁵, with a 60 s wall per call that was never reached. Over the seven screens that is 427
  lattice records: 311 distinct lattices on the 36-vector pool (the random draws are seeded per N; the principal family
  repeats) and 61 on the 100-vector pool.
* **Why: every 3-colouring the screen found is affine.** The pool has 16 *admissible* linear forms λ: Λ₀ → ℤ/3, meaning
  forms nonzero on every generator. Up to sign that is 8 forms, the 8 colourings of the residue plane at 3 (§0 O1). Each
  gives an affine colouring, and an affine colouring never separates 3u, because λ(3u) = 0. The records bear this out with no
  exception, over all 427 lattice records:

  | quotient | lattice records | an admissible form descends to it | a non-affine 3-colouring |
  |---|---|---|---|
  | 3-colourable (colouring verified) | 21 (20 on the 36-vector pool, 1 on the 100-vector pool) | always (exactly ±λ) | none (solver claim) in every case: the affine colourings were blocked and the solver refused |
  | not 3-colourable (solver claim) | 399 | never | not asked |
  | loop (m = 5: some generators lie in 5Λ₀) | 7 | — | — |

  **Reading, not a theorem:** every periodic 3-colouring of `Cay(Λ₀, W₃(N))` is affine, so the D3.7 screen cannot kill this
  pool on any lattice. *Killing test:* a non-affine 3-colouring of any finite quotient. It would be a verified colouring
  written under `colourings/` by the `nonaffine` ask. The reading says nothing about aperiodic colourings, which only a
  finite-piece forcing probe (B2) can meet.
* **The refusals are real, not invented edges.** Adjacency here is derived from a rule, not measured, so a fast refusal is the
  suspect verdict. For L = 2Λ₀, 4Λ₀ and 7Λ₀, the refusals were re-derived on word balls of radius 1–2 (7, 157 and 461
  cosets). That check shared no code with the tool: adjacency by exact rational membership `x − y − w ∈ L`, no Smith form,
  and Glucose4 instead of CaDiCaL. It was a scratch probe and is not recorded here.
* **Price:** the largest single solver call was 0.122 s (a colourability ask); separation asks took ≤ 0.07 s and non-affine
  asks ≤ 0.087 s. Building the clauses dominates: ≤ 2.7 s per lattice at 97,416 vertices and degree 36, and 3.2–6.8 s at
  degree 96–100 for N = 50. A 61-lattice screen takes about 45 s at N = 10 and about 130 s at N = 50.

## Files

| path | what it holds | how produced | trust |
|---|---|---|---|
| `pool-N.json` (N = 10, 20, 40, 70, 140, 280, 50, 130, 230, 250) | W₀ (each vector asserted unit when written and again on re-read); counts in and outside ℚ(i); `vector_set_sha256`; representatives of u up to sign; an LLL-reduced basis (trace form) and every generator's coordinates in it; rank (asserted 4); index in ℤ⁴; covolume; the 16 admissible forms mod 3 and κ; least odd cycle (5 at every N) | `fs58_chain.py pool 11 N` | exact; the odd girth is a complete breadth-first search (the cap was not reached) |
| `pool-N.log` | the pool headline | same | log |
| `control-N.out` (N = 10, 20, 40, 70, 140, 280, 50) | `CONTROL PASS` per part: the Smith-form self-test (300 random matrices, invariants against sympy, a planted wrong Q refused); L = 3Λ₀ reads *identical*; L = ℤ(3u − w) + 7Λ₀ reads *edge*; the planted rhombus (see below); the non-affine ask reads *none* on 3Λ₀ and *exists* on a graph that has non-affine colourings; the colouring-file verifier passes a faithful file and refuses an improper edge, an unseparated pair and a wrong Q | `fs58_chain.py control 11 N --wall 60`, which deletes its old record first, so a crash cannot leave a stale PASS; `screen` refuses to run without `CONTROL PASS (all parts)` | control log |
| `mutation-audit.out` | nine single-fault copies of the tool against `control 11 10` (including a dropped generator, i.e. a missing derived edge): the faithful copy passes and all nine go red (six by a named part, three by the instrument's own catastrophe assertion) | scratch copies, control record redirected to scratch; the harness is not committed | audit record |
| `screen-N.jsonl` (N = 10, 20, 40, 70, 140, 280, 50) | one line per (L, u): `lattice`, `group` (Smith invariants), `order`, `u` (index into W₀, vector, basis coordinates), `pair` (identical / edge / non-edge), `verdict` ∈ {Separable (colouring verified), Forced (solver claim), Unknown (budget), identical, loop}, `quotient` (whether the quotient itself is 3-colourable, so a vacuous Forced is visible), `how`, timings, `colouring_file` | `fs58_chain.py screen 11 N --lattices 50 --wall 60` (fsync per line; resume = rerun) | Forced is CaDiCaL's word; there are no Separable lines |
| `screen-N.lattices.jsonl` | one line per lattice: family (`principal` m, or `random` k, draw number and seed; gaps in `draw` are rejected loops), group, degree, loops, the ratio-bound reading `hoffman_min_mean_reading`, `affine_forms_descending`, `quotient`, `nonaffine` (the ask with the pinned affine colourings blocked), `nonaffine_colouring_file` | same | affine colourings are verified proper in memory; `none` is a solver claim; Hoffman values are float readings |
| `screen-N.log` | per-lattice lines and the end summary: verdicts, Forced split into vacuous and on-a-colourable-quotient, the lattice cross-table, per-u killed or not killed | same (appended across resumes) | log |
| `verify-N.out` | re-verification of every colouring referenced by the records, re-read from its file (0 referenced at every N) | `fs58_chain.py verify 11 N` | — |
| `colourings/` | Separable and non-affine colourings, content-addressed `N{N}-{sha}.json`: the lattice, Smith invariants, Q, the enumeration convention and the colours (base64 of zlib bytes). **Empty: no colouring was ever needed** | written by `screen`, verified from the file before its line is committed | a verified colouring would be exact |
| `run-all.sh`, `run-all.log` | the regeneration script and its last log | — | log |

**The planted rhombus control, and why its host is not a full quotient.** On every 3-colourable quotient of the full graph,
each pair is either separated by every colouring or by none, which is what an affine-only colouring space looks like. Planting
a rhombus that forces a pair equal therefore leaves no colouring at all, and the resulting Forced is vacuous. So the plant
uses the group of L = m·ker κ (3-colourable by κ by construction) with only the directions in ℚ(i) as generators. The code
that asks the question is the same; only the edge array differs. There a 3u pair reads Separable unplanted and Forced
planted, and the planted graph is still 3-colourable.

**Conventions for re-checking a colouring file without the tool.** With `P·M·Q = diag(n)` (`Q` recorded), a
basis-coordinate vector `v` has digits `(v·Q)_i mod n_i`, and vertex `k = ((x₁·n₂ + x₂)·n₃ + x₃)·n₄ + x₄`. `Q` must be
unimodular, every row of `M·Q` must vanish mod `n`, and `∏ n_i = |det M|`. Together these make `v ↦ v·Q mod n` the
isomorphism `Λ₀/L → ⊕ ℤ/n_i`.

**Provenance of the N = 10 and N = 20 screens.** They ran after a PASS of an earlier control, whose planted-rhombus host was
found by random search. That search failed at N = 40 with no 3-colourable host. The host was replaced by the constructed
m·ker κ, and every control, including N = 10 and N = 20, re-passed. The screen code did not change between the two runs.
A pricing run made before the affine diagnostic existed was discarded, not banked.
