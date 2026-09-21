# FS-68 — the tower never rises: is the independence ratio of `UD(ℤ/p^k, 2)` the same at every level?

*Minted 2026-09-21 at FS-66's close, from its open end. Written for a reader with no conversation memory. Read beside: `CLAUDE.md`
row 75 and G66 (what FS-66 landed), G54 (tight or slack), G45 (why level one does not lift); `plans/FS66-tower-conjecture.md` (the
prover's note — statements, prior art, six routes each ending PROVED or DIES HERE, with the owner's review at its end);
`data/fs66/owner/note-2026-09-20-fibre-density.md` (the inequality and its numerics); `data/fs66/b1/SOUNDNESS.md`.*

## 1. The question, in plain language

For a prime `p ≡ 3 (mod 4)` the unit-distance graphs `G_k = UD(ℤ/p^k, 2)` form a tower: reducing modulo `p^{k−1}` is a graph
homomorphism `G_k → G_{k−1}`. Pulling an independent set back up a level multiplies it by `p²`, so the independence *ratio*
`α(G_k)/p^{2k}` can only go up with `k`, and the chromatic number can only go down. Every ceiling this project owns on the chromatic
number of a number field's plane reads **level one**; FS-66 asked whether higher levels read lower, and found that at 7, 11 and 19
(‹and 23, if its certificate has landed — check row 75›) they do not, by exact certificates.

> **Is `α(G_k) = p^{2(k−1)}·α(G₁)` for every `p` and every `k`?** Equivalently: is the fractional chromatic number constant up the
> tower; equivalently: is the largest Haar measure of a measurable independent set of the `p`-adic plane `ℤ_p²` exactly `α(G₁)/p²`?

It is **not proved at any prime for all levels**, and known exactly at one place: `α(UD(ℤ/49, 2)) = 686 = 49·14`.

## 2. What is known, and what is NOT (each with its grade)

* **[cert]** `α(G_k) ≤ U·p^{2(k−1)}` for all `k` with `U = 14.0152` (7), `28.2043` (11), `77.5117` (19), against `α(G₁) = 14, 28,
  76-or-77`. So the ratio can rise by at most 0.11 %, 0.73 %, 2 % — small, not zero. The bound comes from one inequality on the fibre
  shares `φ` of a level-`k` independent set, `⟨φ, A₁φ⟩ ≤ 2Σφ(1−φ)`, and `B₁(p) = max Σφ` under it; the certificate bounds a
  semidefinite relaxation of `B₁`.
* **[measured]** Local search finds `B₁ = α(G₁)` at 7, 11, 19; at 23 it finds a fractional point of value **87.51 against the best
  known set of 87** (16 fractional entries, edge-like pairs) — either `α(Γ₂₃) ≥ 88` or `B₁ > α` there. The *tightened* relaxation
  (adding `φ² = φ`-type rows) reads exactly 14.0000 at 7 and 28.04 at 11 (floats).
* **[proved, the prover's, owner-checked]** (W) *The weighted form is false at every p*: a level-two set on one single-direction
  line has share sum `(p²−1)/(2p) > (p−1)/2`, so fibre shares leave the stable-set polytope of level one and **no pointwise or local
  transfer argument can prove the conjecture — a proof is global.** (E) *Equal-characteristic towers are impotent* — a ring
  containing its residue field gives homomorphically equivalent levels — so the whole content of the conjecture is one twist, the
  carry of integer addition. (T) *Every spectral fact, the inequality, and every `B₁` certificate hold for every twisted cover of
  level one* — the instruments are blind to the carry. `B₁ = α` is false for general graphs (an isolated edge carries 4/3).
* **[cited, statements read, proofs unread]** `[DeCorteOliveiraVallentin2022]`: the measurable independence density of `ℤ_p²` equals
  the value of a completely-positive programme. That is exactness of *that* programme, not of finite-subgraph bounds.
* **NOT known:** the conjecture at any prime beyond level two of 7; whether any twist of `Γ_p` raises `α` (the prover's reading:
  none does); whether finite subgraphs of the `p`-adic plane reach fractional chromatic number `p²/α(G₁)`; the prover's claim that
  `Γ₇` and `Γ₁₁` are cores (recalled from memory, unchecked).

## 3. Deliverables, cheapest first

1. **The exact-face certificate at 7** — prove `B₁(7) = 14` exactly, hence `α(G_k(7)) = 14·49^{k−1}` for every `k` and the density
   of the 7-adic plane is exactly `2/7`. The float says the tightened relaxation is exact there. *Cost:* the certificate format is
   strict (positive **definite** integer blocks); an exact face needs positive **semidefinite** blocks with a named kernel, which is
   a checker format change (`fs66-b1-cert-v3`), a new soundness paragraph, and a rational (not rounded) dual — days, not hours.
2. **The human-checkable route at 7** (the prover's killing test of its own reading): is `χ_f(ℚ(√11)²) = 7/2`? The 7-adic plane
   contains ℚ(√11)² (FS-61's 189-point graph sits inside `ℚ₇²`), and a finite subgraph of fractional chromatic number `7/2` would
   give the conjecture at 7 for every level with no certificate. Ask FS-61's saturated lattice pieces for their fractional
   chromatic number (exact LP on orbit classes; `tools/fs56_gf_check.py` is the precedent). Note `(x, y) ↦ 2x + 3y` maps `Γ₇` onto the
   circular clique `K_{7/2}` (owner-verified), so `7/2` is the ceiling.
3. **The zero twist as a positive control.** Every level-two finder and relaxation in FS-66 lacked a control with a known answer.
   `UD(𝔽_p[ε]/ε², 2)` has `α = p²·α(Γ_p)` by theorem (E): a finder that cannot reach it has a void null; a relaxation that reads
   above it measures its own gap.
4. **One random-twist finder at 11** — the killing test of "no twist ever rises": a verified independent set of 3,389 in any
   twisted cover (the certificate allows up to 3,412). A night of CPU against a plateau; run last, and only with 3's control green.
5. **The kernel form of what is proved**: (E) is a two-line `unitQuadrance.map` argument; (W) is a finite family of `decide`s plus a
   general lemma. Hours, and they are statements nobody had.

## 4. Bearing on χ(ℝ²) ≥ 6, stated honestly

**None directly.** It decides whether the local–global conjecture's local bound `L(F)` is the right invariant or must be replaced by
its all-levels form — and FS-66 already shows the two agree wherever we can certify. Its value is as mechanism (what a residue
colouring can and cannot see at depth), as the first exact measurable-density value for a `p`-adic plane (deliverable 1 or 2), and as
the missing control (3) for any future level-two ask. It is idle-compute and reading-room work beside FS-59.

## 5. Failure and jackpot clauses

*Failure, stated in advance:* the exact-face certificate may not exist at the second level of the hierarchy even at 7 (the float's
14.0000 may be 14 + 10⁻⁹); then (1) is reported as not landed and (2) is the only route at 7. *Jackpot:* a verified 687-set in
`UD(ℤ/49, 2)` — it would refute a hand link or the frozen checker, since 686 is certified, and must be reported at once; or a twist
at 11 that rises, which would show the `B₁` method cannot prove the conjecture there even if it is true. *Registered expectation
(owner, 2026-09-21):* the conjecture is true at every `p`; (2) reads `7/2`; no twist rises. Confidence medium — Lemma W shows the
gain is real locally, and the only thing forbidding it globally is an over-determination nobody has turned into an argument.
