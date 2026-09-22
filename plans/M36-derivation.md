# M36 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer. Enumeration: `plans/M36-seven-coloring.md` read in full.
Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — The coset-7 brick family is forced boundary-tight, in the separated design regime. [hand; the M36
implementer; confirmed exactly]** For the brick colouring model with table `(i + 3j) mod 7` (the norm-7 coset
colouring of `ℤ[ζ₆]` induced by the ideal `(τ)`, `τ = −3 + ζ₆`, `N(τ) = 7`) laid out as `w × h` cells with row shear
`s = w/2` on an `m × n` torus, **provided** the `|Δb| = 1` offsets are separated rather than enclosed
(`(3w/2)² ≥ 1`, "the design regime"): the self-offset `(0,0)` forces the strictly-separating certificate's upper end
`hi = w² + h² ≤ 1`, and the coset offset `(1,2)` forces its lower end `lo = w² + h² ≥ 1` — jointly pinning
`w² + h² = 1` exactly. So every member of this one-parameter family has cell diagonal exactly the unit distance, and
no *strictly*-separating certificate (`q < lo ∨ hi < q`) can accept any of them; only a *boundary-tight* one
(`q ≤ lo ∨ hi ≤ q`) can — which is why M35's phase-2 search (built on the strict check, plus a `diag² < 1` search-grid
filter) refused the whole family outright, twice over. *Proof:* `plans/M36-seven-coloring.md` §0a, C2 ("The coset-7
brick pattern is boundary-tight BY FORCE — which is exactly why M35's phase 2 refused, and why its verdict was an
artifact of the certificate rather than a fact about the plane"). *Confirmed exactly* at the rational instance
`(w,h,s) = (4/5, 3/5, 2/5)`: the offset census found exactly the three predicted tight rows — `(0,0)` tight at its
upper end, `(±1,±2)` tight at their lower end — and no others, over a window padded six rings beyond the
certificate's own reach (`plans/M36-seven-coloring.md` §R, P1). *Proof verdict:* closes, **as scoped** (shear fixed
at `w/2`, the coset-7/`ℤ[ζ₆]` table, the "separated" regime). **Not general**: a later, broader sweep at shear `0`
over an unrelated rectangle/coset-8 family (`12 × 8` cells at `3/5 × 2/5`) found a valid `k = 8` colouring with a
*slack* diagonal (`√(13/25)`) — outside this statement's hypotheses (different shear, different coset structure), so
it is not a counterexample to the claim as scoped here, but the plan's own wording of C2 ("boundary-tightness is not
a property of the cell, it can sit at any interior offset the rational geometry lands on", §R P12) is too narrow if
read as a claim about brick colourings in general; this entry states the narrower, correct scope. *Rests on it:* the
specific rational witness `(w,h,s) = (4/5,3/5,2/5)` that M36's kernel certificate (`sevenBrick`, `Instances/Seven.lean`,
row 33) uses; the non-strict soundness condition itself (`Brick.sound`, kernel, via the companion argument C1 in the
same section — the open-box geometry of a half-open cell forces `d² < hi` always and `d² > lo` only when `lo > 0`,
hence the acceptance rule `q ≤ lo ∨ hi ≤ q`, which IS in the kernel). *Prior art:* the classical fact that a
7-colouring of the plane exists via a hexagonal tiling at the critical scale is folklore (row 33: "the colouring is
classical; ours is the certificate"); the specific "why must this family sit exactly on the unit circle" derivation
(C2) is a project-internal explanation of a certificate-design artifact, not itself literature content. zbMATH:
`ti:"brick" & ab:"chromatic number" & ab:"plane"` (0 hits), `ab:"periodic coloring" & ab:"unit distance" &
ab:"boundary"` (0 hits). Nearest held key: `[SokolovVoronov2025]` / `[deGreyParts2022]` (§ A) for the general
hexagonal-coset-colouring landscape — a different, later question (row 34+, batch 2), noted for orientation only.
*Kernel:* declined for the general family claim (C2, as an if-and-only-if over the whole parametrised family, was
never separately formalised); the *instance* is **kernel** via `sevenBrick` / `Brick.check_pos` / `Brick.sound`
(`Instances/Seven.lean`, `Brick.lean`, row 33, M36) — `sevenBrick.check [1] = true` by `decide +kernel`.

## Readings and measurements that were called theorems

- C6 ("the pixel question is retired, not run"): a covering-radius back-of-envelope calculation (`N ≥ 12`) used to
  justify not re-running a fine-pixel brick probe — a hand estimate, not a proved bound, and not consumed elsewhere.
- The P12 "unregistered find" (the coset coefficient must be `c = 3` or `c = 5`, matching the ideal test exactly) is
  an empirical cross-validation of `Instances/Seven.lean`'s algebra, not a separately stated theorem.

## Conjectures surfaced, not claimed

(none)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined for the general family claim; the specific instance (`sevenBrick`) is kernel |
