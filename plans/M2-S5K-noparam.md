# M2-S5K — Lemma NP in the kernel, its genus-0 control, and C3's one-variable form (crunch job J17K2)

*Kernel job J17K2 of the 2026-09-25 crunch, milestone M2 (FS-39 phase C's C3 lemmas). Brief:
`data/crunch-2026-09-25/briefs/J17K2-M2-lemma-NP-kernel.md` (with `STANDING-RULES.md`). Opus 5.5, de Bruijn. Started from the
green gate at `47ed6c60` (J17K's close). This job stands in for a blind verifier of J17's one piece of fresh hand algebra.*

## Theorems this phase proved

All **[kernel]**, on axioms exactly `[propext, Classical.choice, Quot.sound]`, in `Proofs/HadwigerNelson/NoParam.lean`
(namespace `HadwigerNelson.NoParam`).

| theorem | what it says | grade |
|---|---|---|
| `exists_eq_C_mul_sq_of_mul_eq_sq` | in `k[X]`, a factor coprime to its cofactor in a square is a nonzero constant times a square | kernel |
| `natDegree_eq_zero_of_mul_mul_sub_eq_sq` | NP's polynomial core: `p`, `q` coprime and `p·q·(p² − q²)` a square ⟹ `p`, `q` constant (`2 ≠ 0`) | kernel |
| `exists_algebraMap_eq_of_sq_eq` | a rational function whose square is a polynomial is a polynomial | kernel |
| `not_isSquare_cube_sub_self` | **Lemma NP** (J17-T4), over every field with `2 ≠ 0` | kernel |
| `not_isSquare_cube_sub_self_of_charZero` | NP in the brief's form (characteristic zero; `IsAlgClosed` unused and dropped) | kernel |
| `twin_not_mem_range_C`, `isSquare_twin_sq_sub_one` | **the genus-0 twin is false**: `a = (X² + 1)/(2X)` is nonconstant and `a² − 1` is a square | kernel |
| `X_sq_not_mem_range_C`, `isSquare_cube_sub_self_X_sq_zmod_two` | **NP is false in characteristic 2**: over `𝔽₂`, `(X²)³ − X² = (X(X² + 1))²` | kernel |
| `not_mem_adjoinTranscendental_of_sq_eq` | C3's core: `x ∉ F`, `y² = x³ − x`, `t` transcendental over `F ⊆ ℝ` ⟹ not both `x, y ∈ F(t)` | kernel |
| `transcendental_two_add_liouvilleNumber` | `2 + L` is transcendental over `ℚ` | kernel |
| `not_mem_adjoinTranscendental_liouville` | **C3, one-variable containment form** (J17-T5's kernel form) | kernel |
| `sqrt_not_mem_adjoinTranscendental_bot_liouville` | its inhabitant: `√((2 + L)³ − (2 + L)) ∉ ℚ(L)` | kernel |
| `mem_range_C_of_sq_eq_cube_sub_self` | the curve `y² = x³ − x` has no new points over `k(X)`: both coordinates constant (`2 ≠ 0`) | kernel |
| `IsPureTower` (definition), `mem_of_isPureTower` | the curve has no new points in any purely transcendental tower `K ⊆ K(t₁) ⊆ ⋯` inside a field with `2 ≠ 0` | kernel |
| `not_forall_mem_isPureTower` | **C3⁺** (J17-T6's kernel form): no subfield of `ℝ` holding `2 + L` and `√((2 + L)³ − (2 + L))` has a ring hom into a pure tower over a field algebraic over `ℚ` | kernel |
| `isPureTower_bot_liouville`, `not_forall_mem_adjoinTranscendental_bot_liouville` | inhabitants: `ℚ ⊆ ℚ(L)` is a one-step tower; C3⁺ at `E = ℝ`, `Ω = ℝ` | kernel |

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

## Stage 2 — SAVED

### 2.1 Lemma NP, leaf by leaf

Every leaf of the skeleton closed; the module elaborates with zero `sorry`, and the real build (`scripts/slot.py --mem 60 --cpus 16 --
env MEMMAX=60G ./scripts/build.sh`) is green: 178 of 178 batches, 2 modules rebuilt (`NoParam`, `Proofs`), **0 with warnings**, 3 m 35 s
(`build/gate/build/20260925T230317Z-169920.log`; the build output is also in `data/m2/j17k2/build-stage2.log`). NP's part of the module
(the core, the square-root lemma, the wrapper, the corollary) is **99 lines**, docstrings included.

| leaf | elaborations to green | note |
|---|---|---|
| `exists_eq_C_mul_sq_of_mul_eq_sq` | 1 | `exists_associated_pow_of_mul_eq_pow'` + `Polynomial.isUnit_iff` |
| `natDegree_eq_zero_of_mul_mul_sub_eq_sq` | 1 | degenerate cases `p = 0`, `q = 0`, `p² = q²` by `IsCoprime.isUnit_of_dvd'`; the relation `r₁²α⁴ − r₂²β⁴ − r₃γ² = 0` by one `linear_combination`; `Polynomial.flt_catalan` at `(4, 4, 2)` |
| `exists_algebraMap_eq_of_sq_eq` | 1 | `IsIntegrallyClosed.exists_algebraMap_eq_of_isIntegral_pow` (the UFD instance is in `RingTheory/Polynomial/RationalRoot`) |
| `not_isSquare_cube_sub_self` | 1 | `(b·q²)² = p·q·(p² − q²)` by one `linear_combination` over `a·Q = P`; then the core; then `a = C(p₀/q₀)` |
| twin, `𝔽₂` control, C3 | 2–3 | fixes were names only (`_root_.map_ne_zero`, `push_cast` for a subfield power, an `nlinarith` hint) |

**Read aloud against the informal claim.** `not_isSquare_cube_sub_self`: for every field `k` in which `2 ≠ 0` and every rational
function `a ∈ k(X)` that is not a constant (`a ∉ Set.range RatFunc.C`), `a³ − a` is not of the form `r·r` with `r ∈ k(X)`. NP's source
statement is the case `k = ℂ`. ✓ It is **stronger** than the source in two directions (any field, any characteristic but 2), and both
controls show the extra generality is not free: characteristic 2 is a genuine exception, and constants are (the second spec example,
`C(2)³ − C(2) = C(√6)²` over `ℝ`).

### 2.2 The plant: NP's route run on the genus-0 twin — watched red for the genus, not for scaffolding

`data/m2/j17k2/TwinProbe.lean` (not in the library) transports every step of NP's proof to the twin `a² − 1`, reusing the module's
own lemmas: lowest terms, `(b·q)² = (p − q)(p + q)`, the integrally-closed step, the two coprime factors each a unit times a square
(`p − q = r₁γ²`, `p + q = r₂δ²`), and the relation `r₂δ² − r₁γ² − 2q = 0`, which has signature `(2, 2, 1)`; then
`Polynomial.flt_catalan`. Run (`lake env lean`, under the slot):

    data/m2/j17k2/TwinProbe.lean:55:5: error: unsolved goals
    ⊢ False
    'twin_core_attempt' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]

**Exactly one error, and it is at line 55, the signature hypothesis** `q·r + r·p + p·q ≤ p·q·r` at `(2, 2, 1)`, which `norm_num`
reduces to `False` (`8 ≤ 4`; in reciprocals `1/2 + 1/2 + 1 > 1`, the Fermat–Catalan curve of genus 0). Every scaffolding step — the
coprimality of `p ∓ q` (which needs `2` a unit), the square-root lemma, the unit-times-square lemma, the relation, the degree
bookkeeping, the whole `RatFunc` wrapper — elaborated. The probe's last `example : False` also elaborated: it feeds the errored theorem
the kernel's twin counterexample (`isSquare_twin_sq_sub_one`, `twin_not_mem_range_C`), so the signature step is the **only** thing
standing between this route and a contradiction. At NP the same step reads `32 ≤ 32` (`1/4 + 1/4 + 1/2 = 1`, genus 1) and holds.

Getting there took one round of scaffolding fixes in the probe itself (a `simp` that made no progress on `2 = C 2`, twice; an unused
coprimality lemma with a malformed field-notation step, deleted) — errors of the probe's writing, found and removed before the reading
above; recorded so the "exactly one" is not mistaken for a first-try result.

**Restored:** `NoParam.lean` untouched by the probe (it lives under `data/`); the module re-elaborates green, and the build above is of it.

### 2.3 The predictions registered at 1.3, scored so far

| product | p | outcome |
|---|---|---|
| NP lands in full, any field with `2 ≠ 0` | 0.80 | **HELD** |
| NP's module part ≤ 200 lines | 0.70 | **HELD** (99) |
| twin counterexample in the kernel | 0.90 | **HELD** |
| NP's route on the twin fails only at the signature inequality | 0.65 | **HELD** (after the probe's own scaffolding was fixed, 2.2) |
| C3 one-variable lands | 0.75 | **HELD** (landed in stage 2, ahead of stage 3) |
| C3⁺ | 0.15 | open — stage 3 |

**J17K's P-J17Kc** ("Lemma NP lands via `Polynomial.abc` in at most 200 lines", p = 0.50), passed here unscored: **HELD** — through
`Polynomial.flt_catalan`, which is `Polynomial.abc` (Mason–Stothers) plus the signature arithmetic, in 99 lines.

### Would-have-searched log (stage 2)
- None. The probe is a derivation run on a second instance, not a search.

## Stage 3 — SAVED

### 3.1 C3, one-variable form

Landed in stage 2 (`not_mem_adjoinTranscendental_liouville`, its core `not_mem_adjoinTranscendental_of_sq_eq`, its inhabitant at
`F = ℚ`, `t = L`). **Read aloud:** for every subfield `F` of `ℝ` all of whose elements are algebraic over `ℚ`, and every real `t`
transcendental over `F`, the two reals `2 + L` and `√((2 + L)³ − (2 + L))` (`L = Σ 10^(−n!)`) are not both in the subfield `F(t)`
generated by `F` and `t`. That is the brief's C3 one-variable containment form, verbatim in substance. ✓ The proof goes through
`adjoinTranscendentalEquiv` (reused from `Transcendental.lean`): `F(t) ≅ F(X)` as `F`-algebras, NP over the field `F` makes the image
of `x` a constant `f`, and the `F`-algebra map sends `f` back to `f`, so `x ∈ F`, against `x` transcendental.

### 3.2 C3⁺ — landed

The brief's C3⁺ asks that `E` embed in no purely transcendental extension `F′(t₁, …, t_m)` of any number field `F′`. §2.3's route
(restriction to a generic line) is replaced by an **induction on the tower**, which NP's generality makes free: NP holds over *every*
field with `2 ≠ 0`, in particular over `F′(t₁, …, t_{i})`, so one step `K(t) ≅ K(X)` descends a point of the curve from `K(t)` to `K`
(`mem_range_C_of_sq_eq_cube_sub_self`: `a` constant by NP, then `b² ∈ K` makes `b` a degree-0 polynomial).

- `IsPureTower K L` (inside any field `Ω`): `refl`, and `adjoin t` when `t` is transcendental over the previous field.
- `mem_of_isPureTower`: for `2 ≠ 0` in `Ω`, a point `(a, b) ∈ L²` of `y² = x³ − x` has `a, b ∈ K`.
- `not_forall_mem_isPureTower`: for `E ⊆ ℝ` holding `x` and `y`, `Ω` of characteristic 0, `IsPureTower K L`, `K` algebraic over `ℚ`,
  and any ring hom `φ : E → Ω`, `φ` does not land in `L` (else `φ(x) ∈ K` is algebraic, and `φ`, a `ℚ`-algebra embedding, reflects
  algebraicity: `isAlgebraic_algHom_iff` with `RingHom.toRatAlgHom`).

**Read aloud against C3⁺.** "E embeds in no purely transcendental extension `F′(t₁, …, t_m)` of any number field `F′`": take
`Ω := F′(t₁, …, t_m)`, `K :=` the copy of `F′`, `L := Ω`; a number field is algebraic over `ℚ`. ✓ **Two hand steps stay outside the
kernel**, both standard and both named in the module doc: (i) an algebraically independent family `t₁, …, t_m` over `F′` is a tower of
successive transcendental adjunctions (so `IsPureTower` covers every `F′(t₁, …, t_m)`); (ii) for the C3 of §2.3 itself ("`E` is not
`F(T)`"), the transcendence-degree step `|T| = 1` — C3⁺ makes (ii) unnecessary, since `E = F(T)` would embed `E` in a pure extension.
So **C3's content is now in the kernel up to step (i)**, a definitional reading of "purely transcendental".

Inhabitants: `isPureTower_bot_liouville` (`ℚ ⊆ ℚ(L)` inside `ℝ`, one step; the tower's `adjoin` constructor inhabited), and
`not_forall_mem_adjoinTranscendental_bot_liouville` (C3⁺'s hypotheses all met at `E = ℝ`, `Ω = ℝ`, `K = ℚ`, `L = ℚ(L)`, `φ = id`).

### 3.3 Predictions scored

| product | p | outcome |
|---|---|---|
| C3⁺ lands in this job | 0.15 | **HELD** — the prediction was low because it priced §2.3's restriction-to-a-line route; the generality found at the skeleton (NP over any field with `2 ≠ 0`) turned C3⁺ into a 25-line induction |

### Would-have-searched log (stage 3)
- None.
