# FS-91 stage S1, job J08 — six at the exposed fields (character colourings only)

*Crunch job J08 (de Bruijn, Opus 5.5, 2026-09-25), under `data/crunch-2026-09-25/briefs/J08-M1-six-at-exposed-fields.md` and
`STANDING-RULES.md`. Plan: `plans/FS91-character-local-global.md` §S "J08", §M.1 (read in full except the fenced §P.basis). Data:
`data/fs91/j08/`. Tools: `tools/crunch_j08_*.py`. **Characters only, never `χ`**: every statement below is about band characters
(`Θ_k`, `χ_char`); at `k ≥ 4` the absence of a character colouring says nothing about `χ` (G71).*

## Stage 1 — SAVED (the quotation check, the fence log, C0)

### Q. The quotation check (standing rule 5)

| # | the brief's quotation | source | result |
|---|---|---|---|
| Q1–Q6 | SIX-a … SIX-f | plan §S "J08" | **verbatim, all six** (whitespace-normalised substring match, script in the stage-1 commit message's session). Note: in the plan only SIX-a and SIX-e are inside quotation marks; SIX-b, -c, -d, -f are the same words unquoted — no change of meaning |
| Q7 | "`κ(Γ_q) = max_c min_{t ∈ V_c} |t|/q`, with `χ_char(Γ_q) = ⌈1/κ(Γ_q)⌉`" | plan §M.1 | **verbatim** for `κ`; the `⌈1/κ⌉` clause is §M.1's general "`χ_char = ⌈1/κ⌉`" instantiated — agrees |
| Q8 | "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` Frontier item 23 | **verbatim** |
| Q9 | rows 50, 53, 68–71, 75 as summarised in the brief | `LEDGER.md` | **agree**, with one attribution slip: "K(√7)'s usable primes 83 and ≥ 103" is row 68's sentence; row 53 gives only "K(√7) (83)" and de Grey's "131, 479". 97/529 = 0.1834 > 1/6 (row 75) agrees |
| Q10 | the owner's news: `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`; J01-7 verified | `plans/FS91-S0V2-SWm-second-reading.md` lines 42, 56, 197 | **agrees** |

### F. Fence log (§P.basis)

**A leak, logged.** My first `grep -n "basis"` over the plan printed, besides §P.basis's line number, **line 583 of the plan's
"Theorems this phase proved" table, whose row J03-3 states the planner's hand answer at `q = 23`** (bands 6, 7, 8), and a fragment of
line 565 (§X). §P.basis itself (lines 508–512) was not read. I therefore **know the planner's claimed answer at 23**. Consequences: (i)
my 23 result is produced by an exact tool from the derived law, never by hand, so the planner's claim cannot enter it; (ii) C0's number
for 23 below is contaminated and is recorded with the uncontaminated heuristic beside it; (iii) the plan's fence covers §P.basis only,
yet J03-3 in the theorems table carries its content — **a fence defect for the owner** (J11's fence: J11 is fenced from the plan? — the
brief says J11 is fenced from my record, data, tools and brief; whether J11 may read the plan's theorems table is the owner's call).

### C0. Registered probabilities (before any tool ran)

| id | statement | p | basis |
|---|---|---|---|
| C0-a | SIX-a true as stated | 0.97 | re-derived in my head before stage 2 (two lines: a line `Tr(ax) = t` meets the norm-`c` circle iff `X² − tX + c` is irreducible or a square) |
| C0-23 | a band six-character exists at level one of Γ₂₃ | 0.10 (contaminated); uncontaminated heuristic **0.77** | heuristic: for `c` a non-square, band 6 needs `t² − 4c` a square at `t = 1, 2, 3` (three coin flips), 11 values of `c`: `1 − (7/8)^11`. The file `data/fplane/periodic-below-71.json` also carries an untrusted solver refusal of seven colours on the one-direction circulant at 23, which (see stage 3) bounds characters too |
| C0-43 | a band six-character exists at level one of Γ₄₃ | 0.12 | band 6 needs `t = 1..7` (seven flips), 21 values: `1 − (127/128)^21 ≈ 0.15`, shaded for the same untrusted circulant refusal at 43 |
| C0-167 | `χ_char(ℚ(√167)²)` given CLG_6, CLG_7 | 6: 0.10; 7: 0.30; 8: 0.50; ≥ 9: 0.10 | 23 and 43 dominate; 59, 67, … refuse six by certificate (rows 68–69) |

## Stage 2 — SAVED (SIX-a re-derived; its law checked against the circle)

### SIX-a, derived (J08-1)

*Setting.* `q` prime, `q ≡ 3 (mod 4)`, `𝔽_{q²} = 𝔽_q(i)`, `w̄ = w^q` (so `ī = −i`), `N(w) = w w̄`, `Tr(w) = w + w̄`. `μ_{q+1} = ker N` is the
unit circle `x² + y² = 1`, and `Γ_q = Cay(𝔽_{q²}, μ_{q+1})`.

1. **Every character is `λ_a`.** `𝔽_{q²}` is elementary abelian of exponent `q`, so every homomorphism to `ℝ/ℤ` lands in `(1/q)ℤ/ℤ ≅ 𝔽_q`
   and is `𝔽_q`-linear; the trace form is non-degenerate, so every linear functional is `x ↦ Tr(ax)` for a unique `a`. `λ_0 = 0` is band
   for no `k`, so every band character is `λ_a` with `a ≠ 0`.
2. **The band condition.** `λ_a(z) ∈ B_k = [1/k, 1 − 1/k]` iff the centred representative `t ∈ (−q/2, q/2)` of `Tr(az)` has `|t| ≥ q/k`.
   So `λ_a` is band `k` iff no value of `Tr(a·)` on `μ_{q+1}` has `|t| < q/k`.
3. **The value set.** As `z` runs over `μ_{q+1}`, `w = az` runs over the norm-`c` circle `{N(w) = c}`, `c = N(a) ∈ 𝔽_q^×`. Every such `w`
   is a root of `X² − Tr(w)X + c` (`w² − (w + w̄)w + w w̄ = 0`). Fix `t`. (i) `t² − 4c` a non-square: the polynomial is irreducible, its two
   roots `w, w̄` have trace `t` and norm `c` — **two** points. (ii) `t² − 4c = 0`: the only candidate is `w = t/2 ∈ 𝔽_q`, and it qualifies
   (`N(t/2) = t²/4 = c`, `Tr(t/2) = t`) — **one** point. (iii) `t² − 4c` a non-zero square: the candidates are the two roots in `𝔽_q`, where
   `N(w) = w²` and `Tr(w) = 2w`, forcing `t² = 4c`, false — **no** point. Hence `{Tr(az)} = V_{N(a)}`, with multiplicities 2 / 1 / 0
   (total `q + 1`, a check). ∎ **Verdict: SIX-a TRUE** (C0-a scored: held at 0.97).
4. **Two consequences used below.** (a) `0 ∈ V_c` iff `−4c` is a non-square iff `c` is a **square** (`−1` is a non-square): so only the
   `(q − 1)/2` non-square `c` can be band, and for them `t² − 4c ≠ 0` always, `|V_c| = (q + 1)/2`, each value twice. (b) **Scaling:** for
   `s ∈ 𝔽_q^×`, `V_{s²c} = s·V_c`; with `−4c = r²` (non-square `c`), `V_c = r·W₀`, `W₀ = {u : u² + 1` a non-square`}`. So **a band
   `k`-character exists iff some dilate `r·W₀` misses the interval `|t| < q/k`** — one set `W₀` per `q`, all its non-zero dilates.

### The measured half (the law is derived, so its refusals are the suspect verdict — `CLAUDE.md` § The gate)

`tools/crunch_j08_sixa.py` (2.3 s, 14 MB): at `q ∈ {3, 7, 11, 19, 23, 31, 43, 47, 59, 67}`, **every** `a ≠ 0` (15,020 in all): the direct
multiset `{2(a₁x − a₂y) : x² + y² = 1}` equals the law's `m_c` exactly; the direct band test equals the law's band test at every
`k = 3..12` (150,200 comparisons, **both outcomes reached** — 2,128 band-true; at 67 none up to 12); `a ↦ (2a₁, −2a₂)` is a bijection onto
`Hom(𝔽_q², ℤ/q)`. **Plants**, each paired with a faithful twin that passes: P1 (the law with `t² + 4c`) fires at the value-set comparison,
`q = 7, a = (0,1), t = 0` (direct 2, law 0); P3 (the direct side with the wrong trace `a₁x + a₂y`) fires at `q = 7, a = (0,1), t = 1`.
Weil sanity (float): `max_{a≠0} |Σ_z e(Tr(az)/q)| ≤ 2√q` at all ten `q`, smallest margin 0.44 at 59. Output (written on every run, null
or not): `data/fs91/j08/sixa-check.json`.

