# FS-91 S1V-six — blind verification of J08's claims (character colourings at the exposed fields), job J11

*Crunch job J11, 2026-09-25, Opus 5.5, acting as de Bruijn (a blind verifier). Brief:
`data/crunch-2026-09-25/briefs/J11-M1-six-blind-verifier.md` with `STANDING-RULES.md`. The verdicts are mine. Fenced until the phase-1
verdicts are committed: J08's record, data, tools and commits; the plan `plans/FS91-character-local-global.md` beyond the quoted blocks;
every other crunch record.*

## Stage 1 — SAVED (quotation check and C0)

### Q. Quotation check (standing rule 5)

Every quotation in the brief checked against `plans/FS91-character-local-global.md` (only the lines named below were opened).

| brief item | source | result |
|---|---|---|
| W1 = SIX-a, "For a prime `q ≡ 3 (mod 4)`, every band `k`-character … non-square or 0}`." | plan l. 458–460 | **verbatim** |
| W2 = SIX-b, "The complete list of `c ∈ 𝔽_q^×` … `χ_char(Γ₄₃)`" | plan l. 461–462 | text identical; the source does not put it in quotation marks (it is a task line, not a claim) |
| W3 = SIX-c, "For `k ∈ {6, 7}`: an explicit `Q_k` … the complete list below it." | plan l. 463–464 | text identical; unquoted in the source, as W2 |
| W4 = SIX-e, "Given CLG_6 and CLG_7 (J07, unverified): … de Grey's field `K(√5,√7)`." | plan l. 467–468 | **verbatim** |
| `κ(Γ_q) = max{β : some character λ has λ(μ_{q+1}) ⊆ [β, 1 − β]}` | plan l. 519 (§M.1): "`κ(G, S) = max{β : some character λ has λ(S) ⊆ B_β}` (compactness makes it a maximum); `χ_char = ⌈1/κ⌉`", with `B_β = [β, 1 − β]` (plan, `0 < β ≤ ½`) | a faithful **instantiation** at `S = μ_{q+1}`, not a quotation; the source also states `χ_char = ⌈1/κ⌉` |
| "band `k`-character … `λ(S) ⊆ [1/k, 1 − 1/k]`" (brief's first paragraph) | plan l. 434: "`λ(S) ⊆ B_k`" | faithful (B_k = [1/k, 1 − 1/k]) |
| "A band six-character of Γ₂₃ or Γ₄₃ would be the first exactly six-chromatic finite Euclidean plane (`CLAUDE.md` G56)" | `CLAUDE.md` § Where the problem stands item 11, G56; rows 69, 71, 75 (five refused at 23 and 43) | correct: a band six-character six-colours the plane, and five is refused at both |
| positive control: "some band eight-character should exist at 23 and 43, or explain why those colourings are not characters" | the brief's own expectation | logged as the brief's expectation, to be scored |

**What else was opened, and why (logged, not hidden).** W4's hypothesis "CLG_6 and CLG_7" is not quoted in the brief, and an implication
cannot be checked without its hypothesis. So I read the plan's §S definitions and the CLG_k statement, l. 431–441 (statements only, no
route), and l. 519–520 (the κ definition, whose next clause begins "CLG in its converged form: `κ(R_F, U_F) = max over stable places 𝔓
of κ(O_𝔓, S_𝔓)`, under `H_β` …" — read in passing). Verbatim, the hypothesis I use:

> **CLG_k.** "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of
> `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`, and a character
> `k`-colouring of `F²` exists only if some residue target of `F` is `k`-colourable." (plan l. 439–441)

> **`H_k`** "is the hypothesis `Θ_k(R_F) ⊆ T + A` for every real number field `F`" (plan l. 435); the owner's news: J01-7 verified, so
> `H_k` holds at every `k`, with `A(R_F) = Hom_ℚ(F(i), ℝ)` mod 1 (every archimedean embedding).

> "The **residue target at level `m`** is `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`, `S_{𝔓,m}` the image of the local norm-one group"; "a
> **stable place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`" (plan l. 432–434).

Nothing of J08's record, data, tools or commits, nor §PA.1, §P or §P.basis, was opened.

### C0. Predictions (probabilities), written before any tool is written

*Honesty note:* W1's reduction is two lines and I derived it while reading the inputs, before writing this section, so P(W1) is not an
independent prediction. Everything below it was written before any computation.

| claim | P(TRUE as stated) | reasoning at this point |
|---|---|---|
| W1 (SIX-a) | 0.97 | trace form nondegenerate; `aμ_{q+1}` is the norm-`N(a)` circle; `Tr = t, N = c` solvable off `𝔽_q` iff `X² − tX + c` irreducible, in `𝔽_q` only at discriminant 0 |
| W2 (SIX-b): J08's lists match mine value by value | 0.80 | a finite exact list; errors would be in the reading of `(−q/2, q/2)` or of `c` |
| W3 (SIX-c): J08's `Q_k` valid and its list complete | 0.75 | my Weil threshold: a triangle minorant gives "band `k` ⟹ `q + 1 ≤ 2(k − 1)√q`", i.e. `q ≤ 97` (k = 6), `q ≤ 141` (k = 7) — the same line as the Hoffman ratio bound, since a band `k`-character has a colour class of `q⌈q/k⌉ ≥ q²/k` points |
| W4 (SIX-e): TRUE / GAP / FALSE | 0.55 / 0.40 / 0.05 | GAP risk: "`χ_char = min` over targets" needs CLG at the minimising `k` (or only its easy pullback half) and, for "targets" read at level 1, a level collapse; FALSE risk: a wrong target list |
| **a band six-character exists at 23 or at 43** | **0.04** | `data/fplane/periodic-below-71.json`: every band character has `c` a non-square (else `0 ∈ V_c`), and all non-square `c` give isomorphic circulants `Cay(ℤ/q, V_c)` (`V_{m²c} = mV_c`); the file's circulant has `0 ∉ D`, so it IS that class, and its (untrusted) solver reads `α = 3` at 23 and `α = 6` at 43, while band six needs the interval `{0,…,3}` (23) or `{0,…,7}` (43) independent there; and 23's local-search plateau is 87 < 92 = 23·⌈23/6⌉ |
| a band seven-character at 23 or 43 | 0.05 | the same file: band seven needs `{0,…,3}` (23) and `{0,…,6}` (43) independent |
| band eight at 23 / at 43 (the brief's positive control) | 0.88 / 0.50 | at 23 two square conditions on 11 non-squares; at 43 five on 21 |
| `χ_char(Γ₂₃) = 8`; `χ_char(Γ₄₃) ∈ {8, 9}` | 0.80; 0.70 | the circulant file's 8-colourings; none need be an interval colouring |

## Stage 2 — SAVED (phase 1, blind: W1–W4 verdicts)

*Written before any J08 file, datum, tool or commit was opened. Tools: `tools/crunch_j11_band.py` (sha256 `d291bbf8…`),
`tools/crunch_j11_targets.py` (`00622c92…`), `tools/crunch_j11_q27.gp` (`5b42d842…`); data `data/fs91/j11/band-lists.json`
(`7d26c44d…`), `targets.json` (`045d866c…`), `q27.out` (`c6484361…`). Re-run: `python3 tools/crunch_j11_band.py self-test && python3
tools/crunch_j11_band.py run --qmax 199 --direct-qmax 143 --out data/fs91/j11/band-lists.json` (8 s); `python3 tools/crunch_j11_targets.py
self-test && python3 tools/crunch_j11_targets.py run --bound 2000 --pari-bound 300 --out data/fs91/j11/targets.json` (6 s); `gp -q
tools/crunch_j11_q27.gp < /dev/null`.*

### Verdicts

| claim | verdict | in one line |
|---|---|---|
| **W1 (SIX-a)** | **TRUE** | two-line derivation (below); every character of every `Γ_q`, `q ≤ 139`, enumerated directly on the circle and its value set compared with `V_{N(a)}` — 0 mismatches of sets and of minima |
| **W2 (SIX-b)** | **TRUE as a computation; my lists:** at 23, band 6: none; band 7: none; band 8: `c ∈ {11, 20, 21}`; `κ(Γ₂₃) = 3/23`, `χ_char(Γ₂₃) = 8`. At 43, bands 6, 7, 8: none; band 9: `c = 33` only; `κ(Γ₄₃) = 5/43`, `χ_char(Γ₄₃) = 9` | value-by-value comparison with J08 is stage 4 |
| **W3 (SIX-c)** | **TRUE as a computation; mine:** `Q₆ = 97`, `Q₇ = 141` (Weil + Hoffman: band `k` ⟹ `(q + 1)² ≤ 4(k − 1)²q`); below them band 6 occurs only at `q = 3 (c = 2), 7 (5), 11 (2, 10), 19 (15)`, band 7 only at `q = 3 (2), 7 (3, 5, 6), 11 (2, 10), 19 (13, 15)` | none at any `q` from 23 to 199; the non-prime window member 27 has no band character at any `k` (J11-T6) |
| **W4 (SIX-e)** | **ℚ(√167): TRUE** (both clauses, given CLG_6 and CLG_7; the second needs only CLG_7's iff and yields `χ_char(ℚ(√167)²) = 8`). **K(√7) and K(√5,√7): first clause TRUE (given CLG_6); second clause GAP** at the step "`Θ_k(R_F) = ∅` for `8 ≤ k < min`": the minimum over targets is **17** (K(√7), at 83) and **22** (de Grey's field, at 131), so `χ_char = min` needs CLG_8 … CLG_16 (resp. … CLG_21), not only CLG_6 and CLG_7 — unless CLG_k's own "Hence `χ_char(F²) = min`" sentence is read as part of the hypothesis, in which case the clause is the hypothesis restated | targets verified by Legendre logic and PARI (below) |

**Scope held:** every statement here is about characters; nothing is claimed about `χ` at `k ≥ 4` (G71). Positive colourings: a band `k`
character gives `χ(Γ_q) ≤ k`; no band character is a statement about characters only.

### W1 — the derivation (J11-T1, T2)

`q` prime, `q ≡ 3 (mod 4)`, `𝔽_{q²} = 𝔽_q(i)`, `N(x + iy) = x² + y²`, so the unit circle is `μ_{q+1} = ker N`.
1. *Every character is `λ_a`.* `(𝔽_{q²}, +) ≅ (ℤ/q)²`, so a character lands in `(1/q)ℤ/ℤ`; the trace form `(a, x) ↦ Tr(ax)` is
   non-degenerate, so every character is `x ↦ Tr(ax)/q` for a unique `a`; `a = 0` is band for no `k` (it is 0 on `S`).
2. *Its values on the circle.* `aμ_{q+1} = {w : N(w) = c}`, `c = N(a)` (N is onto `𝔽_q^×` with kernel `μ_{q+1}`). A `w` with `Tr w = t`,
   `N w = c` is a root of `X² − tX + c`: if `t² − 4c` is a non-square, its two roots are conjugate in `𝔽_{q²} ∖ 𝔽_q` and both lie on the
   circle; if `t² − 4c = 0`, `w = t/2 ∈ 𝔽_q` has `N w = w² = c`; if `t² − 4c` is a non-zero square, the roots are distinct in `𝔽_q`, and
   `w ∈ 𝔽_q` with `2w = t`, `w² = c` would force discriminant 0. So `λ_a(μ_{q+1}) = V_c/q`, with multiplicity `1 − η(t² − 4c)`.
3. *Band.* With `t` centred in `(−q/2, q/2)`, `t/q` has distance `|t|/q` to ℤ, so `λ_a(S) ⊆ [1/k, 1 − 1/k]` iff every `t ∈ V_c` has
   `|t| ≥ q/k`. ∎ **T2:** `0 ∈ V_c` iff `−4c` is a non-square iff `c` is a square (`−1` is a non-square), so **every band character has
   `c` a non-square**, and `κ(Γ_q) = max_c d(c)/q` with `d(c) = min_{t ∈ V_c} |t|`, `χ_char(Γ_q) = ⌈q/max_c d(c)⌉`.
   Note `V_{m²c} = mV_c`: all non-square `c` give isomorphic circulants `Cay(ℤ/q, V_c)`; band-ness is not invariant under `m`.

### W3 — the threshold (J11-T3)

If `λ` is band `k`, the class `{x : λ(x) ∈ [0, 1/k)}` is independent (two of its points differ by less than `1/k` in `λ`) and has
`q·⌈q/k⌉ ≥ q²/k` points. Hoffman's ratio bound with `|λ_min| ≤ 2√q` (Weil; `CLAUDE.md` G44; the eigenvalue at `b ≠ 0` is
`−Σ_t η(t² − 4N(b)) e(t/q)`, a Weil sum of a squarefree quadratic, `≤ 2√q`) gives `q²/k ≤ q²·2√q/(q + 1 + 2√q)`, i.e.
**band `k` ⟹ `q + 1 ≤ 2(k − 1)√q`**, exactly `(q + 1)² ≤ 4(k − 1)²q`. So `k = 6`: `q ≤ 49 + √2400 = 97.99`, **Q₆ = 97**; `k = 7`:
`q ≤ 71 + √5040 = 141.99`, **Q₇ = 141**. (A Fourier minorant `1_J * 1_{−J}`, `|J| = ⌈q/k⌉`, gives the same line with `max|λ|` in place
of `|λ_min|`.) The list below `Q_k` is a complete exact enumeration of `c ∈ 𝔽_q^×` over the primes the inequality leaves; the tool
also runs to `q = 199` and asserts the inequality at every band character it meets (0 violations).

`χ_char(Γ_q)` for every prime `q ≡ 3 (4)` to 199 (`κ = D/q`): 3: 3 · 7: 4 · 11: **6** · 19: 5 · 23: 8 · 31: 8 · 43: 9 · 47: 10 · 59: 10 ·
67: 14 · 71: 18 · 79: 14 · 83: 17 · 103: 15 · 107: 16 · 127: 22 · 131: 22 · 139: 24 · 151: 19 · 163: 33 · 167: 24 · 179: 26 · 191: 24 ·
199: 25. Two things a reader might not expect: **`χ_char(Γ₁₁) = 6 > χ(Γ₁₁) = 5`** (kernel, row 53), so at 11 no optimal colouring is a
character colouring; and `χ_char` is not monotone in `q`.

**Hand check at 23 (independent of the tool).** The 11 non-squares `c` mod 23 with `4c`, then `t² − 4c` at `t = 1, 2, 3`:
5 (4c = 20: 4 sq, 7 non-sq), 7 (5: 19 non-sq), 10 (17: 7 non-sq), **11** (21: 3, 6 sq; 11 non-sq), 14 (10: 14 non-sq), 15 (14: 10
non-sq), 17 (22: 2 sq, 5 non-sq), 19 (7: 17 non-sq), **20** (11: 13, 16 sq; 21 non-sq), **21** (15: 9, 12 sq; 17 non-sq), 22 (19: 5
non-sq). So `d(c) = 3` exactly at `c ∈ {11, 20, 21}` and `< 3` elsewhere: band 8 (`8·3 ≥ 23`), not band 7 (`7·3 < 23`). At 43, `c = 33`
(`4c ≡ 3`): `t² − 3` for `t = 1…5` is 41, 1, 6, 13 (squares), 22 (non-square), so `d = 5`: band 9, not 8.

### The positive control (the brief's expectation, scored)

`data/fplane/periodic-below-71.json`'s colourings are circulant colourings: constant on the cosets of a line, i.e. `x ↦ f(π(x))` for a
linear functional `π` — the kernel of a character — with an **arbitrary** colouring `f` of `Cay(ℤ/q, D)`. I checked (exact): at every
member the file's `D` equals `V_c` for one non-square `c` (23: `c = 7`; 31: 12; 43: 22; 47: 13), each colouring is proper, and **no
colour class of any of them is an interval after any multiplier `m`** — so none is a character colouring `⌊k(λ + β)⌋`. **At 23 the
expectation is met** (band 8 exists, `c ∈ {11, 20, 21}`; the file's own colouring is just not one). **At 43 it is not met: no band
eight-character exists** (`χ_char(Γ₄₃) = 9`); the file's 8-colouring of the circulant `Cay(ℤ/43, V₂₂)` is a line-periodic colouring
that no interval colouring matches. "Periodic under a line" is strictly wider than "character".

### W4 — the fields (J11-T7 to T11)

*Level collapse (T7, hand).* At a stable place `𝔓` of residue characteristic `p` that is inert in `L/F` (unramified or ramified over
ℚ), a band `k`-character `λ` of `T_{𝔓,m}`, `m ≥ 2`, with `p > k/2` factors through level `m − 1`: the fibre `{s(1 + π^{m−1}ir) : r ∈ 𝔽_p}`
lies in `S_{𝔓,m}` (`N(1 + π^{m−1}a) ≡ 1 + π^{m−1}(a + ā)` since `2m − 2 ≥ m`, and `a + ā ≡ 0` is `a ∈ i𝔽_p`), so if `λ(π^{m−1}si) ≠ 0`
the values `λ(s) + r·λ(π^{m−1}si)` fill a coset of `(1/p)ℤ/ℤ`, which meets the open arc `(−1/k, 1/k)` of length `2/k > 1/p`. So
`λ(π^{m−1}s̄i) = 0` for every `s̄ ∈ μ_{q+1}`; these span the residue field over `𝔽_p` (`μ_{q+1} ⊄ 𝔽_p`), so `λ` kills `𝔓^{m−1}/𝔓^m`.
At `k ∈ {6, 7}` every stable place of the three fields has `p ≥ 23`, so "target" may be read at level 1 without loss.
*Pullback (T8, hand; CLG-a).* At a stable `𝔓`, `v_𝔓(u) = v_𝔓(ū)` and `v_𝔓(uū) = 0`, so `U_F ⊂ O_𝔓^×` and a band character of
`T_{𝔓,m}` composed with `R_F → O_𝔓/𝔓^m` lies in `Θ_k(R_F)`: **`χ_char(F²) ≤ min` over targets holds unconditionally.**
*Monotonicity:* `B_k ⊆ B_{k+1}`, so `Θ_k ⊆ Θ_{k+1}`.

*The targets (T9, tools exact + PARI).* Odd `p` never ramifies in `F(i)/F`, so `𝔓 | p` is stable iff the residue field `𝔽_{p^f}` of
`F` lacks `i`: `p ≡ 3 (mod 4)` and `f` odd. For multiquadratic `F`, `f = 1` iff every radicand in `⟨D⟩` prime to `p` is a square mod
`p`. Dyadic: each field holds a radicand `≡ 7 (mod 8)` (167; 7), and `ℚ₂(√d) = ℚ₂(i)` for such `d`, so every dyadic place splits in
`L/F`: **no stable dyadic place** (PARI: 2 has `g_L = 2g_F` in all three). PARI's `idealprimedec` on `F` and `L` agrees at every
`p < 300` for all three fields (0 mismatches; plants `forget_ramified_rule`, `p1mod4_allowed` fire against it; `no_dyadic_check` fires on
ℚ(√3), where 2 is stable).

| field | stable places (level-1 target `Γ_q`), with `χ_char` | no band 6/7 at any target | min over targets |
|---|---|---|---|
| ℚ(√167) | 23: 8 · 43: 9 · 59: 10 · 67: 14 · 71: 18 · 79: 14 · 83: 17 · 103: 15 · 131: 22 · 139: 24 · 151: 19 · 163: 33 · **167 (ramified)**: 24 · … | yes (targets ≥ 23; W3's lists) | **8, at 23** (Weil floor ≥ 9 from 227 on) |
| K(√7) = ℚ(√3,√7,√11) | 83: 17 · 131: 22 · 167: 24 · 227: 29 · 479: 48 · 503: 63 · 563: 52 · 887: 111 · 1091, 1151, … | yes | **17, at 83** (Weil floor ≥ 18 beyond 887) |
| K(√5,√7) (de Grey's) | 131: 22 · 479: 48 · 1091: 110 · 1151: 116 · 1319: 147 · 1559: 142 · 1811, … | yes | **22, at 131** (Weil floor ≥ 23 beyond 1559) |

No ramified prime is stable for K(√7) or de Grey's field (at 3, 7, 11 — and 5 — the inertia field's radicands include a non-residue, so
`f = 2`). The minimum is certified complete: the tool asserts the Weil floor exceeds it past the enumeration bound 2000.

*The implication (T10, T11).* Given CLG_6 (iff half) with T7: `Θ₆(R_F) ≠ ∅` iff some `(𝔓, m)` carries a band six-character iff some
level-1 target does — and none does, for all three fields; so **the first clause holds and `Θ₆(R_F) = ∅` for all three**. Given CLG_7,
likewise `Θ₇(R_F) = ∅`, so `χ_char(F²) ≥ 8` for all three. With T8: **`χ_char(ℚ(√167)²) = 8`** (pulled back from `Γ₂₃`'s band-8
characters `c ∈ {11, 20, 21}`), and unconditionally `6 ≤ χ_char(ℚ(√167)²) ≤ 8` (lower bound row 96's `Θ₅ = ∅`, given FS-53's and FS-66's
certificates). **For K(√7): `8 ≤ χ_char ≤ 17`; for de Grey's field: `8 ≤ χ_char ≤ 22`** from CLG_6 and CLG_7; equality with the
minimum needs `Θ_k = ∅` for every `k` up to 16 (resp. 21) — CLG at those `k`, which W4's hypothesis does not name. **This is the
GAP**, and it is a statement about what the hypothesis carries, not a doubt about the minimum.

### What else phase 1 found

- **J11-T6 (Γ₂₇, the non-prime window member).** A character of `𝔽_{729}` takes values in `(1/3)ℤ/ℤ`; by exact enumeration (PARI,
  728 characters × 28 circle points) every character is 0 on **at least 4** circle points, so **`Γ₂₇` has no band character at any `k`**;
  the count also reproduces `λ_min = (3·4 − 28)/2 = −8` (row 70). Control: the same code at 23 finds characters with no zero on the circle.
- **Planted faults** (standing rule 7): `drop_disc_zero` fires on value sets (8), `norm_without_quarter` on value sets (7), `skip_t_zero`
  on "band `c` not a non-square" (15), a stronger-than-true Weil inequality refuses a real band character at `(3, 3)`. **Two plants are
  unreachable and kept, labelled:** `uncentred` (reading `|t|` in `[0, q)`) cannot fire, because `V_c = −V_c` makes `min t = min |t|` —
  found by running it; `weil_k_not_k_minus_1` is a weaker inequality and cannot refuse.

### Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| J11-T1 | W1: every band `k`-character of `Γ_q` is `λ_a`, with `λ_a(μ_{q+1}) = V_{N(a)}/q`; band iff `min_{V_c}|t| ≥ q/k` | hand + tools exact (direct control at every prime `q ≤ 139`) | stage 2 §W1; `crunch_j11_band.py` |
| J11-T2 | every band character has `N(a)` a non-square; `χ_char(Γ_q) = ⌈q/max_c d(c)⌉` | hand | §W1 |
| J11-T3 | band `k` at `Γ_q` ⟹ `(q + 1)² ≤ 4(k − 1)²q`; `Q₆ = 97`, `Q₇ = 141` | hand, given Weil (G44) | §W3 |
| J11-T4 | W2's lists at 23 and 43; `κ(Γ₂₃) = 3/23`, `χ_char(Γ₂₃) = 8`; `κ(Γ₄₃) = 5/43`, `χ_char(Γ₄₃) = 9` | tools exact + hand (23 in full, 43 at `c = 33`) | `data/fs91/j11/band-lists.json` |
| J11-T5 | band 6 and band 7 characters of prime `Γ_q` exist only at `q ∈ {3, 7, 11, 19}`; `χ_char` table to 199 | tools exact, given T3 | same |
| J11-T6 | `Γ₂₇` has no band character at any `k` | tools exact (PARI) | `tools/crunch_j11_q27.gp`, `data/fs91/j11/q27.out` |
| J11-T7 | level collapse at stable inert places with `p > k/2` | hand | §W4 |
| J11-T8 | pullback: `χ_char(F²) ≤ min` over targets, unconditionally | hand | §W4 |
| J11-T9 | the stable places of ℚ(√167), K(√7), K(√5,√7); none dyadic | tools exact + PARI to 300 | `data/fs91/j11/targets.json` |
| J11-T10 | given CLG_7: `χ_char(ℚ(√167)²) = 8`; unconditionally `6 ≤ χ_char(ℚ(√167)²) ≤ 8` | hand + tools, given row 96 | §W4 |
| J11-T11 | given CLG_6, CLG_7: `8 ≤ χ_char(K(√7)²) ≤ 17`, `8 ≤ χ_char(K(√5,√7)²) ≤ 22`; `≤` unconditional | hand + tools | §W4 |

### Would have searched here

- A colouring search for six or seven colours on `Γ₂₃`, `Γ₄₃` restricted to characters → the reduction to `c ∈ 𝔽_q^×` (22 and 42 values),
  enumerated completely; logged as the allowed kind (a finite set fixed by a derivation).
- A sweep over primes "until band six stops appearing" → the Weil–Hoffman inequality fixed `Q₆ = 97`, `Q₇ = 141` first; the enumeration
  to 199 only checks the derived inequality.
- A direct enumeration of every character of `Γ_q` on its circle (`q ≤ 139`, 19,320 characters at 139): a complete finite control, not a
  search — it compares sets with the reduction's.
- A search over primes for each field's smallest `χ_char` → the Weil floor fixed the range (2000) that certifies each minimum.
- At 27, a colouring search → a complete count of 728 characters on 28 points.

### C0 scored (phase 1)

W1 TRUE (0.97, not independent). No band six at 23 or 43 (P(exists) 0.04): held. No band seven (0.05): held. Band eight at 23 (0.88):
held; at 43 (0.50): **none**. `χ_char(Γ₂₃) = 8` (0.80): held; `χ_char(Γ₄₃) ∈ {8, 9}` (0.70): 9. W4 GAP risk (0.40): fired, at the step
named in C0 (the minimising `k` exceeding the named CLG_k), for two of the three fields. W2/W3 agreement with J08: stage 4.

## Stage 3 — SAVED (phase 2: the W4 gap, against J08's lemma statements only)

*Opened: `plans/FS91-S1D-six.md` "Theorems this phase proved" (its l. 298–314), statements only; no proof, data, tool or commit of J08.*

J08's statement of the field result, verbatim: **J08-8** "`χ_char` = 8 (ℚ(√167)), 17 (K(√7)), 22 (de Grey's field) given CLG_7, CLG_16,
CLG_21; `Θ₈`, `Θ₁₇`, `Θ₂₂ ≠ ∅` unconditionally" (hand + tools exact; lower halves given CLG (J07, unverified)).

**The step I lacked, derived.** I wrote in stage 2 that equality with the minimum `m` needs "CLG_8 … CLG_{m−1}". One instance suffices:
`B_k ⊆ B_{k+1}` gives `Θ_k(R_F) ⊆ Θ_{k+1}(R_F)`, so `Θ_{m−1} = ∅` forces `Θ_k = ∅` for every `k ≤ m − 1`. With CLG_{m−1}'s iff half, the
level collapse J11-T7 (it needs `p > (m − 1)/2`: `83 > 8` for K(√7) at `m − 1 = 16`, `131 > 10.5` for de Grey's field at 21), and no
level-1 target carrying a band `(m − 1)`-character (that is what "min = `m`" says, `targets.json`), `Θ_{m−1}(R_F) = ∅`; with the
unconditional pullback J11-T8, `χ_char(F²) = m`. **So J08-8, with the hypotheses it names (CLG_7, CLG_16, CLG_21), is TRUE.**

**Verdicts after phase 2.**
- **W4 as quoted in the brief** ("Given CLG_6 and CLG_7 … `χ_char = min` … the same for K(√7) and de Grey's field"): **GAP stands** for the
  second clause at K(√7) and de Grey's field — CLG_6 and CLG_7 give only `8 ≤ χ_char ≤ 17` and `8 ≤ χ_char ≤ 22` — and the missing step
  is exactly **CLG_16** (resp. **CLG_21**), one instance each, by monotonicity. TRUE for ℚ(√167) and for the first clause everywhere.
- **J08-8 as J08 states it:** TRUE (given the CLG instances it names). J08 did not state anything wider than the quoted W4; it stated the
  narrower, correct hypothesis.
- **Correction to my stage 2** (kept above, corrected here): "needs CLG_8 … CLG_16 (resp. … CLG_21)" → "needs CLG_16 (resp. CLG_21); the
  intermediate instances follow by monotonicity". J11-T11 reads: given CLG_{m−1}, `χ_char(K(√7)²) = 17` and `χ_char(K(√5,√7)²) = 22`.

| id | statement | grade | address |
|---|---|---|---|
| J11-T12 | `Θ_k(R_F) ⊆ Θ_{k+1}(R_F)`; hence `χ_char(F²) = m` follows from the pullback and CLG_{m−1} alone, `m` the minimum over targets, whenever every stable place has `p > (m − 1)/2` | hand | stage 3 |
