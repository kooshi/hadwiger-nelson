
## Stage 15 — SAVED (FS131-K10c): the read-backs (statements against the sentences they serve; proofs are the kernel's and were not read)

### 15.1 The planes' floor's implementer (FS131-I10D; `FloorPlanes`, `NormOneTarget` as merged)

| statement | sentence (inventory item 538) | verdict |
|---|---|---|
| `circle_sum_le_of_ne` | "the bound needs `a ≠ 0` **or** `b` anisotropic" | **says it.** Odd characteristic, `ψ ≠ 1`, `b ≠ 0`, `a ≠ 0 ∨ b₁² + b₂² ≠ 0`, over `KloostermanBound F`: `‖Σ_{s₁²+s₂²=a} ψ(b·s)‖ ≤ 2√q`. Checked against `circle_sum_eq_kloosterman` by hand in the four cases: both non-zero — a Kloosterman sum with both coefficients non-zero; `a ≠ 0`, `b` isotropic — `Σ_{x≠0} ψ(−ax) = −1`; `a = 0`, `b` anisotropic — `Σ_{x≠0} ψ(d/x) = −1`; both zero — excluded |
| `circle_sum_zero_of_isotropic` | "at radius 0 with `b` isotropic the sum is `χ(−1)(|F| − 1)`" | **says it; and under its hypotheses `χ(−1) = 1`**: a non-zero isotropic `b` exists only when `−1` is a square, so the sum is `q − 1` and the factor is decoration. Its hypotheses are satisfiable exactly at `q ≡ 1 (mod 4)` (model: `ZMod 5`, `b = (1, 2)`; item 500's `ZMod 13`, `b = (1, 5)`, sum 12). **For the bibliography's sentence write `q − 1`, with "(`−1` a square)"** |
| `two_sqrt_lt_circle_sum_zero` | "so it exceeds `2√|F|` from six elements on" | **says it**: with `6 ≤ q`, `2√q < ‖sum‖` (`q − 1 > 2√q ⟺ q² − 6q + 1 > 0 ⟺ q ≥ 6`). With the last row it is effective from `q = 9` (`q ≡ 1 (mod 4)`, a prime power); at `q = 5` the sum is 4 `< 2√5` and the printed bound holds — agreeing with the second pass's tool (violations at 9, 13, 17, 25, 49, none at 5) |

**So the correction the bibliography may cite**: "`[MMST1996]` Theorem 3 (p. 231) at `n = 2` holds exactly when `a ≠ 0` or `b`
is anisotropic (`circle_sum_le_weil`, [kernel] over the import `[Weil1948]`), and fails at `a = 0`, `b ≠ 0` isotropic, `q ≥ 9`,
where the sum is `q − 1` (`circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`, [kernel], no axiom)." The first half
rested on `KloostermanBound` as a hypothesis; it is now `circle_sum_le_weil` in the import's module. The three say no more
and no less than their sentences. Helpers read by head and found to say what their names say: `sum_addChar_mul_left`,
`sum_units_addChar_mul`, `sum_addChar_mul_sq`, `sum_plane_quadratic`, `exists_ringHom_pow`, `card_filter_pow_eq_self`,
`exists_mulShift_eq`, `card_filter_pow_eq_one`, `sum_eq_zero_add_sum_units`.

**The link it could not check: the kernel does not hold it.** `normOneCayley` occurs in `StandingFive`, `NormOneTarget` and
their consumers only (grep over `Proofs/`); `finitePlane p` is `unitQuadrance (ZMod p)` (`UnitQuadrance.lean:57`); no
declaration relates the two (no `→g` or `≃g` with `levelTarget` or `normOneCayley` on either side). **What the floor's kernel
sentence is**: "for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, every field `k` of `Q²` elements with a non-trivial involution `σ` has
`χ(Cay(k, {x : x·σ(x) = 1})) ≥ 7`" — a sentence about the norm-one Cayley graph of `𝔽_{Q²}`, which is exactly the object
`localBound` reads (`levelTarget P 1 = normOneCayley _ σ` by `rfl`, inside `le_localBound`), so **TC1-STANDING-FIVE's
"`L(F) ≥ 7`" is whole**. What is *not* a kernel sentence is G56's wording "every usable plane `Γ_Q = UD(𝔽_Q, 2)` refuses six":
that needs `normOneCayley k σ ≃g unitQuadrance k₀` for the fixed field `k₀` at `Q ≡ 3 (mod 4)` (coordinates `x = u₁ + u₂ι`,
`ι² = −1`, `x·σ(x) = u₁² + u₂²` — the coordinates I10D's `normOne_charSum_ge` builds inside its proof), then
`7 ≤ (finitePlane p).chromaticNumber` for primes `p ≡ 3 (mod 4)`, `p ≥ 98`. About 150 lines; **not stated here** (no row
reads it; `LEDGER.md`'s and G56's sentences should say "the norm-one target of `𝔽_{Q²}`" until it is).
**The floor at six from `Q ≥ 62`**: stated and proved, `targetFloor_six_of_kloosterman`, `targetFloor_six_weil` — the
bibliography's `[Weil1948]` row reads it ("`> 5` for `p ≥ 62`"), with the same caveat about the object.

### 15.2 The target at 128's implementer (FS131-I10E; `Floor128` as merged, 41 declarations added)

| statement | used for | verdict |
|---|---|---|
| `exists_root` | every field of `128²` elements holds a root `g` of the certificate's `P` | says it (`ev g P = 0`, `ev` the code read as a polynomial) |
| `exists_root_pow_eq` | `P` is primitive: every `x ≠ 0` is `g^j`, `j < 16383` | says it; `16383 = 2¹⁴ − 1` |
| `class_le` | for `r < 127`, at most 74 of the 129 register states `step^[127j + r] 1` are odd | says it; with `exists_addChar` (`ψ₀(gⁿ) = 1 − 2·(state mod 2)`) a class sum is `129 − 2·count ≥ −19` |
| `normOne_eq_image` | `{u : u^129 = 1} = {g^(127j) : j < 129}` | says it; `16383 = 127·129` |
| `charSum_128_ge` | the planner's leaf, unchanged | — |

**The two Bézout identities: keep.** They cost under a second; dropping them means editing a generator and its `--check`
control that another job owns (`tools/fs131_k10b_gen128.py` emits their four literals); and they are a second witness of
`P`'s irreducibility (coprime to `x⁴ − x` and `x¹²⁸ − x`, so no factor of degree dividing 2 or 7) that a reviewer can check
without the 16,383-step orbit. **Owed at the landing**: `Floor128`'s module docstring and theirs say what they are — "not
read by the bridge; an independent witness of irreducibility" (the architecture row already says the first half).
**The floor at six for the target with 64 elements** (`𝔽_{2¹²}`, norm-one group of order 65): **not a row** — no backlog
row or filed result reads `χ(U₆₄) ≥ 6` in Lean; it is G56's window at [tools]. Price: the bridge with its constants made
parameters (degree 14 → `n`, `P`, `16383`, `129`, `127`, the count bound) is about 350 lines moved into a parametric module
and about 60 for each instance with its certificate — under half a job, plus a generator for the 64 certificate (a new tool;
the second pass's is another job's). Six would follow with room: any `λ_min ≥ −15` gives `1 + 65/15 > 5` (the spectrum of `U₆₄` is not computed here). State
it when the window's theorem ("6-open") is formalized.

### 15.3 The first pass's third implementer (FS131-I10C; `StandingFive` on `main`, its twelve new statements)

`g_eta` (η is a root of `x⁷ + x⁶ − 12x⁵ − 7x⁴ + 28x³ + 14x² − 9x + 1`), `finrank_E7_and_K` (7 and 4), `minpoly_eta`,
`irreducible_gPoly`, `im_eq_zero_of_aeval_gPoly` (every complex root of `g` is real), `finrank_standingField_le` with
`closure_eq_adjoin`, `finrank_closure`, `dvd_of_pow_pow_eq` (true in any monoid: both exponents are multiples of the least
period of `x` under `y ↦ y^p`), `fourteen_dvd_of_char_two`, `card_ge_of_usable` with `usableBelow_347`,
`card_fixed_of_involution`, `two_sq_ne_of_isIntegral`: **each says its sentence, by head.** `cev_hvec : cev chi29 hvec = η`
says "η = ζ + ζ¹² + ζ¹⁷ + ζ²⁸" only through `cev`, `chi29`, `hvec`, **whose bodies I did not read** — one statement not fully
read back.

**`NumberField standingField`: make it a global instance, at the second landing.** It is `local instance
instNumberFieldStanding` in `StandingFive` (line 702). Reason: every module downstream that needs it — the usable place
(§ 16.1), the instance of the rows at the standing field — must otherwise declare its own; two anonymous `instance :
NumberField standingField` in two modules get one generated name and merge in silence (`LEAN.md` § The gate, `dupnames`),
and a named one in each is a doubled proposition. It is `Prop`-valued at one specific type: no diamond, no search cost, and
one canonical proof. The edit — `local instance` → `instance`, one word, in a landed module — is the landing's.

### 15.4 The third implementer of the second pass (FS131-I10F; Amendment 1 item 4)

- `fibre_mem_factorSets`: if an event of the product depending on the first two coordinates is `l`-continuous and `T₁` is
  eventually the identity, its fibre over an atom of positive mass is `l`-continuous for the second system — the plan's
  child C5, says it.
- `cylMap ε A`, `cylSets ε`: `(x, ω) ↦ (x, (ε a ω)_{a ∈ A})` for a finite `A`, and the events that are preimages under
  some `cylMap` — the cylinders of child C2; definitions, read by head only.
- `contVec_prod_eq_coin`: `contVec_prod_eq` at `Ω₁ = Ω₂ = Unit`, `Ω₃ = ℤ → Bool` under `Measure.infinitePi` with the shift.
  **A model of every hypothesis, with the first system trivial**: `h₁` and `[Finite Ω₁]` hold degenerately. The theorem is no
  refutation, so the gate's rule is met; the fuller model (a non-trivial finite `Ω₁`) is forty lines the landing may add.
- `sp_if_hypotheses_trivial_bot (hBH)`: every hypothesis of `sp_if` but `hBH`, at once, at `F = ℚ` with the trivial
  interface — `MulStable`, `NegCircle`, a finite rotation-invariant `ν` with `ν(E) = 0`, an `IsHaarFourier m`, `ν ≠ a • m`.
  Says it. **How `sp_if`'s docstring should put the open item** (Amendment 1 item 3): "MODEL: given `hBH`, every other
  hypothesis holds at once at `F = ℚ` with `Interface.trivial` (`sp_if_hypotheses_trivial_bot`). `hBH` is the
  Herglotz–Bochner theorem for the countable discrete group `unitRing ⊥` — a classical theorem named as a hypothesis from
  outside the backlog (plan § 7.4), true, not in the kernel; it is a statement to prove, not a structure to inhabit, and no
  smaller group serves (`unitRing ⊥ ⊇ ℤ`)." The gate item then reads "open by one classical theorem", not "no model".
- `ae_eq_measurable_of_majority`: proved as stated; reads neither `hG` nor `hc`, of `[Finite K]` only countability
  (ruling 542: dropped at the landing). SI-5's step (c) (§ 14.3) will ask nothing the lemma does not read.
