
## Stage 12 — SAVED (FS131-K10c): the page against the statement — `[Weil1948]` p. 207 and `KloostermanBound`

**Verdict: the page states the bound the floor needs, at every finite field of characteristic not 2, and the Lean statement
differs from it in exactly one way — it carries no hypothesis on the characteristic. The axiom is stated in the page's own
form, with that hypothesis; `KloostermanBound F` is derived from it in the kernel.** Nothing was left that I could not close.

### 12.1 What was read, and how

The held PDF `~/source/library/pdf/pnas-1948-weil-on-some-exponential-sums.pdf` (4 pages, PNAS 34, pp. 204–207): all four
pages as page images; pp. 206–207 again rendered at 300 dpi and cropped to the displays (the PDF's text layer garbles every
formula — `|E0(x)x(x2* a)l 42 Nq` for the first display of p. 207 — so no formula below is taken from it). The note has no
sections and no numbered theorem; its numbered displays are (1)–(5), and the bound is an unnumbered display.

### 12.2 The page's own words

- p. 204, last two lines: "Let `k` be a finite field of `q` elements; consider the field `k(t)` of rational functions …".
- p. 205: "Let `χ` be a character of the multiplicative group `k*` of the non-zero elements in `k`. Let `𝔡` be a finite
  divisor, consisting of the points `ξ_ν` with the coefficients `a_ν` … We shall assume that no `a_ν` is a multiple of the
  order of `χ`." And of the characters `ω`: "the values of `ω` are `p^s`-th roots of unity, if `p` is the characteristic of
  `k`".
- p. 206, display (5): "`|Σλ(x)χ[R_𝔡(x)]| ≤ (N + d − 2)√q`", then: "For instance, we can define a character `ω`, of
  conductor `(T²)`, by putting, for every series of constant term 1: `ω(1 + x₁T + x₂T² + …) = −ψ(x₁)`, where `ψ` is a
  character of the additive group of `k`, not everywhere equal to 1. This gives `|Σψ(x)χ[R_𝔡(x)]| ≤ d√q`. If the
  characteristic `p` of `k` is not 2, we have `d = 2` for `R_𝔡(t) = t² − a`, `a ≠ 0`; hence, in that case,"
- p. 207: "`|Σψ(x)χ(x² − a)| ≤ 2√q`. If, in this, we take for `χ` the character of `k*` of order 2 (equal to 1 for squares,
  and to −1 for non-squares, in `k*`), an elementary transformation⁴ shows that the sum in the left-hand side is identical
  with the so-called Kloosterman sum `Σψ(cx + dx⁻¹)`, for `4cd = a`; hence `|Σ_{x≠0} ψ(cx + dx⁻¹)| ≤ 2√q`, and, in the case
  of a prime field of `p` elements, with `p ≠ 2`: `|Σ_{x=1}^{p−1} e^{2πi/p (cx + d/x)}| ≤ 2√p`." Footnote 4: "Davenport, H.,
  Crelles J., 169, 158–176 (1933); cf. in particular Th. 5, p. 172."

### 12.3 Side by side

| the page | `KloostermanBound F` (`Arith/FloorPlanes.lean`) | the axiom `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman.lean`) |
|---|---|---|
| "`k` a finite field of `q` elements" | `(F : Type*) [Field F] [Fintype F]`; `q` is `Fintype.card F` | the same, `F : Type u` |
| "If the characteristic `p` of `k` is not 2 … in that case" | **absent** | `(hp : ringChar F ≠ 2)` |
| "`ψ` is a character of the additive group of `k`, not everywhere equal to 1" | `ψ : AddChar F ℂ`, `ψ ≠ 1` | `(ψ : AddChar F ℂ) (hψ : ∃ x, ψ x ≠ 1)` |
| "for `4cd = a`", with "`a ≠ 0`" (p. 206) | `a b : F`, `a ≠ 0`, `b ≠ 0` (its `a`, `b` are the page's `c`, `d`) | `(c d a : F) (h4 : 4 * c * d = a) (ha : a ≠ 0)` |
| "`Σ_{x≠0} ψ(cx + dx⁻¹)`" | `∑ x : Fˣ, ψ (a * ↑x + b * ↑x⁻¹)` | `∑ x ∈ univ.filter (fun x : F => x ≠ 0), ψ (c * x + d * x⁻¹)` |
| "`| … | ≤ 2√q`" | `‖…‖ ≤ 2 * Real.sqrt (Fintype.card F)` | the same |

### 12.4 Every way they could differ, each settled from the page

1. **The characteristic.** The display sits under "If the characteristic `p` of `k` is not 2 … hence, in that case", so the
   page states nothing at characteristic 2 (there `t² − a` is a square and `4cd = 0`). `KloostermanBound F` has no such
   hypothesis: an axiom `∀ F, KloostermanBound F` would say more than the page. **Settled: the axiom carries
   `ringChar F ≠ 2`** (rulings 500, 515). The floor loses nothing: it reads the bound at fields of `q ≡ 3 (mod 4)` elements
   (`ringChar_ne_two_of_card_mod_four`, proved). *Chosen over restricting the axiom to those fields*: the page's own class is
   the form a reader can check against the page with no arithmetic of ours in between, and the next consumer (the order
   bound FS89-S0A-3 "on Weil", the floor at other residues) may read other odd fields. (At the even fields of 4, 8 and 16
   elements the inequality itself holds by exact computation, § 12.5; the page's route does not exist there, and nothing here
   assumes it.)
2. **`4cd = a ≠ 0` against `a ≠ 0 ∧ b ≠ 0`.** In characteristic not 2, `4 ≠ 0`, so `4cd ≠ 0 ⟺ c ≠ 0 ∧ d ≠ 0`: the two
   ranges of coefficient pairs are the same set. Kernel: `four_mul_mul_ne_zero_iff` (proved); exact arithmetic: check (C).
   Every `a ≠ 0` occurs, square or not: for a non-square `a` the two zeros of `t² − a` are conjugate points, which the page
   admits ("divisors which are rational over `k`, i.e., such that conjugate points over `k` have the same coefficient",
   p. 205), each with coefficient 1, not a multiple of the order 2 of `χ`; `a = 0` would give one point with coefficient 2
   and is the case the page's assumption excludes.
3. **"for `4cd = a`" — every such pair, or some?** Every: the transformation is the count `#{x ≠ 0 : cx + d/x = u} = 1 +
   χ(u² − 4cd)` (a quadratic `cx² − ux + d` with `c, d ≠ 0`), so `Σ_{x≠0} ψ(cx + d/x) = Σ_u ψ(u)(1 + χ(u² − a)) =
   Σ_u ψ(u)χ(u² − a)` because `Σ_u ψ(u) = 0` for `ψ` not everywhere 1 — for each pair with `4cd = a` [hand, mine, three
   lines]. Exact arithmetic: check (I), the identity in `ℤ[ζ_p]` at every character and every pair, nine fields; the fault
   `2cd = a` breaks it.
4. **"a character … not everywhere equal to 1" against `ψ ≠ 1`.** `AddChar F ℂ` is the monoid homomorphisms
   `Multiplicative F → ℂ`: `ψ 0 = 1`, `ψ (x + y) = ψ x * ψ y`. On a finite field `ψ(x)^p = ψ(p·x) = 1`, so the values are
   `p`-th roots of unity — the page's characters ("the values … are `p^s`-th roots of unity"), no more and no fewer.
   `ψ ≠ 1 ⟺ ∃ x, ψ x ≠ 1` is `AddChar.ne_one_iff` (Mathlib; `DFunLike.ne_iff`). The axiom is stated with `∃ x, ψ x ≠ 1`,
   the page's words.
5. **The range of summation.** `x ≠ 0` in `k`, against `x : Fˣ` with `↑(x⁻¹)`: `sum_units_eq_sum_ne_zero` (proved, by
   `unitsEquivNeZero`) and `Units.val_inv_eq_inv_val`. Lean's `0⁻¹ = 0` never enters: `0` is not summed. The axiom sums
   over `univ.filter (· ≠ 0)`, the page's subscript.
6. **The constant.** `2√q`, `q` the number of elements of `k` — not `p`: the prime case is displayed separately with `√p`.
   `Fintype.card F` is `q`. The inequality is non-strict in print and in Lean.
7. **Prime powers.** "a finite field of `q` elements" from p. 204 governs the display; the prime field is "the case of a
   prime field". The floor reads `p^f`, `p ≡ 3 (mod 4)`, `f` odd: inside the page.
8. **The absolute value** is the complex modulus; `‖·‖` on `ℂ`.
9. **Which `ψ`?** All of them: the character `ω` of conductor `(T²)` is defined from any `ψ` not everywhere 1. **A slip in
   print, outside the imported sentence**: "`ω(1 + x₁T + …) = −ψ(x₁)`" cannot be meant as printed (at the series 1 it gives
   `−1`); with `λ(x) = ω(1 − xT)` (p. 205) the reading that yields the next display, `Σψ(x)χ[…]`, is `ψ(−x₁)`. Either way
   the displayed inequality quantifies over every `ψ` not everywhere 1, and `ψ ↦ ψ(−·)` permutes those, so the sentence
   imported does not depend on the reading.
10. **Instances and universes.** `[DecidableEq F]` forms the filter (or, in `KloostermanBound`, the `Fintype Fˣ`) and carries
    no content; the axiom is universe-polymorphic in `F`, and its consumers instantiate it at `Type`.
11. **Is the sentence a theorem of the note, or a remark?** A consequence the note derives ("hence") from its (5), which rests
    on "the Riemann hypothesis" for function fields (footnote 3, Weil's 1948 monograph) and class-field theory. It is the
    classical Weil bound; the import is the sentence, not the derivation.

### 12.5 The sentence, checked by exact arithmetic (`tools/fs131_k10c_kloosterman.py`; no floats)

Characters are enumerated as the `𝔽_p`-linear functionals of the field (all the characters of an elementary abelian
`p`-group, with no appeal to the trace form); a sum is a vector of exponent counts in `ℤ[ζ_p]`; `|K|² ≤ 4q` is decided in
rational interval arithmetic on `2cos(2π/p)`, the largest root of an integer polynomial isolated by sign changes (exact at
`p = 3`, where the sums are integers), with an exact zero test where an interval straddles 0.

| field | sums checked (every `ψ ≠ 1`, every `c, d ≠ 0`) | violations | equalities | the transformation (I) | (C) |
|---|---|---|---|---|---|
| 7 | 216 | 0 | 0 | holds, all | holds |
| 9 | 512 | 0 | 0 | holds, all | holds |
| 3, 5, 11, 13, 25, 27, 49 (`--all`) | 8; 64; 1,000; 1,728; 13,824; 17,576; 110,592 | 0 | 0 | holds, all | holds |
| 4, 8, 16 (`--char2`; outside the page, reported only) | 27; 343; 3,375 | 0 | 0 | fails (as it must: `4cd = 0`) | fails |

Outputs: `data/fs131/k10c/kloosterman-7-9.out` (exit 0), `kloosterman-all.out` (exit 0). **Faults, each watched to fire**
(exit 1): `--fault trivial` (admit `ψ = 1`: `K = q − 1`, 36 violations at 7 and 64 at 9), `--fault zero` (admit `c = d = 0`),
`--fault const` (test `|K| ≤ √q`: 192 violations at 9 — the check sees the constant), `--fault transform` (the
transformation at `2cd = a`: 384 mismatches at 9 — the check sees the 4); `data/fs131/k10c/kloosterman-fault-*.out`.
Grade: [tools]. It shows the sentence true at nine odd fields, two of them the brief's; it is no proof beyond them.
