# M2-S5K — Lemma NP in the kernel, its genus-0 control, and C3's one-variable form (crunch job J17K2)

*Kernel job J17K2 of the 2026-09-25 crunch, milestone M2 (FS-39 phase C's C3 lemmas). Brief:
`data/crunch-2026-09-25/briefs/J17K2-M2-lemma-NP-kernel.md` (with `STANDING-RULES.md`). Opus 5.5, de Bruijn. Started from the
green gate at `47ed6c60` (J17K's close). This job stands in for a blind verifier of J17's one piece of fresh hand algebra.*

## Theorems this phase proved

*(filled at each stage; every entry [kernel] unless marked)*

| theorem | grade | address |
|---|---|---|
| — | — | — |

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| Lemma NP: "There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in `ℂ(t)`." | `plans/M2-S1D-bridge.md` §2.3 | verbatim |
| "`α⁴ = β⁴ + (γδ)²`" | same | verbatim |
| "`deg γ + deg δ … ≤ 2D`" | same | verbatim; the ellipsis stands for "`= (deg(p − q) + deg(p + q))/2`" |
| the brief's unquoted gloss of the hand proof ("`a = p/q` coprime; the four pairwise coprime factors are squares") | same | a fair summary, not a quotation; the source's words are "The four polynomials `p, q, p − q, p + q` are pairwise coprime (characteristic 0)" and "each is a unit times a square, hence a square in `ℂ[t]`" |
| C3 one-variable containment form | J17K's brief (`data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` lines 39–42) | verbatim (the J17K2 brief drops J17K's parenthesis about `π`; nothing changes) |
| C3⁺: "`E` embeds in **no** purely transcendental extension `F′(t₁, …, t_m)` of any number field `F′`" | `plans/M2-S1D-bridge.md` §2.3 | verbatim |
| `protected theorem Polynomial.abc …` | `Mathlib/NumberTheory/FLT/MasonStothers.lean:55` | verbatim, line correct |
| `exists_associated_pow_of_mul_eq_pow'` | `Mathlib/RingTheory/PrincipalIdealDomain.lean:482` | present at that line |
| `adjoinTranscendental`, `adjoinTranscendentalEquiv`, `transcendental_liouvilleNumber_bot` | `Proofs/HadwigerNelson/Transcendental.lean` (namespace `HadwigerNelson.RouteC`) | present; reused, not re-defined |
| the plant: "`a = (X² + 1)/(2X)` gives `a² − 1 = ((X² − 1)/(2X))²`" | the brief (J17K's) | checked by hand: `(X²+1)² − 4X² = (X² − 1)²` ✓ |
| J17K's parenthesis "(Dropping `CharZero k` is *not* a good plant: NP stays true in odd characteristic; only the proof's derivative step breaks.)" | J17K's brief line 130 | **half right, see 1.2**: NP stays true in odd characteristic, but no step of the proof below breaks there — Mathlib's `Polynomial.flt_catalan` handles characteristic `p` by descent. And NP is **false** in characteristic 2 (`a = X²`), which makes `2 ≠ 0` the exact hypothesis |

No quotation was found paraphrased in a way that changes a claim.

### 1.2 A find at the skeleton, which changes the route

Mathlib holds, beside `Polynomial.abc`, **`Polynomial.flt_catalan`** (`Mathlib/NumberTheory/FLT/Polynomial.lean:198`): no nonconstant
coprime `a, b, c` with `C u·a^p + C v·b^q + C w·c^r = 0`, for `p, q, r ≠ 0` with `q·r + r·p + p·q ≤ p·q·r` and `p, q, r` nonzero in `k`
— in **any** characteristic (its characteristic-`p` case is a descent). The hand proof's `α⁴ = β⁴ + (γδ)²` is signature `(4, 4, 2)`,
and `4·2 + 2·4 + 4·4 = 32 ≤ 32 = 4·4·2`: the boundary case, which the lemma admits (its three Mason–Stothers inequalities are strict).
So the route is:

1. `a = p/q` in lowest terms (`RatFunc.num`, `RatFunc.denom`); `b² = a³ − a` gives `(b·q²)² = p·q·(p² − q²)`, and `k[X]` being
   integrally closed, `b·q² = g` is a polynomial (this replaces the hand proof's `c²q³ = e²·…` and its `e² = λq³` step);
2. `p`, `q`, `p² − q²` pairwise coprime, so each is a unit times a square (`exists_associated_pow_of_mul_eq_pow'` three times, units
   of `k[X]` being `C r`); **no algebraic closure is needed**: the units ride in `flt_catalan`'s coefficients `u, v, w`;
3. `r₁²α⁴ − r₂²β⁴ − r₃γ² = 0`, and `flt_catalan` at `(4, 4, 2)` makes `α`, `β` constant.

**Changes from the brief's proposed Lean, each with its reason.**

| change | reason |
|---|---|
| `[IsAlgClosed k] [CharZero k]` → `(h2 : (2 : k) ≠ 0)` | stronger, and needed: C3 applies NP over `F ⊆ ℝ`, not over `ℂ`; the brief's form is kept as the corollary `not_isSquare_cube_sub_self_of_charZero` (with `IsAlgClosed` dropped, since it is unused) |
| `p − q`, `p + q` not split; `p² − q²` one factor | the split needs characteristic ≠ 2 for coprimality and buys nothing: `flt_catalan` takes `γ²` with `γ² ~ p² − q²` directly |
| a second control beside the twin: NP over `ZMod 2` at `a = X²` | the hypothesis `2 ≠ 0` is then shown not idle (G30 item 6: delete each hypothesis once) |

### 1.3 C0 — the order, stated honestly

**Slip, mine (J17K's slip repeated):** the skeleton and its first two leaves (the unit-times-square lemma and the whole polynomial
core) were written and elaborated before this C0 reached disk; both closed on the first elaboration. The predictions below were formed
before the first leaf was written, and are scored only on products **not yet attempted** at the time of writing.

| product | p |
|---|---|
| Lemma NP lands in full (the `RatFunc` wrapper included), over any field with `2 ≠ 0` | 0.80 |
| NP's module part (core + wrapper) is at most 200 lines | 0.70 |
| the twin counterexample lands in the kernel | 0.90 |
| NP's route run on the twin fails **only** at `flt_catalan`'s signature inequality (the genus), with every scaffolding step elaborating | 0.65 |
| C3 one-variable form lands | 0.75 |
| C3⁺ lands in this job | 0.15 |

### 1.4 The price, from the first two leaves

| leaf | brief's price | measured |
|---|---|---|
| `exists_eq_C_mul_sq_of_mul_eq_sq` (unit times square) | inside stage 2's ~120k | 3 lines, first elaboration |
| `natDegree_eq_zero_of_mul_mul_sub_eq_sq` (the polynomial core, with the degenerate cases `p = 0`, `q = 0`, `p² = q²`) | same | 45 lines, first elaboration; `#print axioms` the standard three; negative control (a false `example` in the same file) fires |

Iteration: 2.0 s wall per `lake env lean` of the skeleton and of the leaf file, under `--mem 10`. Working file:
`data/m2/j17k2/Leaf.lean`.

### Would-have-searched log (stage 1)
- None.
