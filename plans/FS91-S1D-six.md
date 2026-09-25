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

## Stage 3 — SAVED (SIX-b: the complete lists at 23 and 43)

**Logged as the ban's edge:** a complete exact enumeration of `c ∈ 𝔽_q^×` (22 and 42 values), the set fixed by SIX-a; nothing sampled,
nothing searched. `tools/crunch_j08_kappa.py` (0.04 s): `m(c) = min_{t ∈ V_c} |t|`, `κ = max_c m(c)/q`, band `k` at `c` iff `k·m(c) ≥ q`.

| `q` | `m(c)` over the non-square `c` (squares: `m = 0`, by stage 2's 4(a)) | band 6 | band 7 | band 8 | band 9 | **`κ(Γ_q)`** | **`χ_char(Γ_q)`** |
|---|---|---|---|---|---|---|---|
| 23 | `c = 5,7,10,11,14,15,17,19,20,21,22` → `2,1,1,3,1,1,2,1,3,3,1` | ∅ | ∅ | **`{11, 20, 21}`** | same | **3/23** | **8** |
| 43 | `c = 2,3,5,7,8,12,18,19,20,22,26,27,28,29,30,32,33,34,37,39,42` → `2,1,2,2,1,1,2,3,1,1,1,1,1,3,3,1,5,1,2,2,1` | ∅ | ∅ | **∅** | **`{33}`** | **5/43** | **9** |

(J08-2, J08-3.) At 23, `V₁₁ = V₂₀·s = V₂₁·s′` (one scaling class; argmax values and `V_c` in `data/fs91/j08/kappa-23-43.json`).

**Controls.**
1. **Measured cross-check:** every `m(c)` at 23 and 43 recomputed from the circle directly (`a` with `N(a) = c`, min over `x² + y² = 1`
   of `|2(a₁x − a₂y)|`) — **agrees at all 64 values of `c`**; and stage 2's direct band test counts `72` band-8 `a`'s at 23 (`= 3 × 24`)
   and `0` at 43, `44` band-9 `a`'s at 43 (`= 1 × 44`) — the same answer by the other half.
2. **Plant:** the law with `t² + 4c` fires at the cross-check at 23 (`c = 1, 2, 3` first); its faithful twin passes.
3. **Row 69's periodic colourings** (`data/fplane/periodic-below-71.json`): at every `p ≡ 3 (mod 4)` in the file the one-direction
   circulant's `D` is **exactly `V_c` for one non-square `c`** (3:2, 7:3, 11:6, 19:10, 23:7, 31:12, 43:22, 47:13, 59:30, 67:34, 71:22) —
   SIX-a's law checked against committed data from another milestone. Since `V_{s²c} = s·V_c`, **every band `k`-character is a circular
   `k`-colouring `t ↦ ⌊k·(st mod q)/q⌋` of that same circulant `C_q`**, so `χ(C_q) ≤ χ_char(Γ_q)`; the file's (untrusted) solver
   refusals `chi_circ_lo` are consistent with every `χ_char` computed (below).
4. **The brief's control failed at 43, for a stated reason, and the brief's premise is the defect.** The brief: "the tool must find a class
   at `k = 8` at both (row 69's ceilings)". At 23 it does. **At 43 no band 8-character exists**, by both halves; row 69's ceiling 8 at 43 is
   the file's **line colouring** of `C₄₃` (checked proper here, 8 colours), which is **not of multiplier form**: `χ(C₄₃) ≤ 8 < 9 = χ_char(Γ₄₃)`.
   So row 69's ceilings are periodic (one-direction) colourings, a strictly larger class than character colourings; the premise conflated
   them. Logged as a brief slip, not a tool defect.

`χ_char` beside the file's circulant bracket (`[chi_circ_lo (untrusted), chi_circ (verified)]`): 3: 3 [3,3]; 7: 4 [4,4]; 11: **6** [6,6]
(`χ(Γ₁₁) = 5`, kernel, by a non-line colouring); 19: 5 [5,5]; 23: 8 [8,8]; 31: 8 [8,8]; 43: **9** [8,8]; 47: 10 [9,10]; 59: 10 [9,10];
67: **14** [9,12]; 71: **18** [9,12].

**Read aloud, against "characters only":** *no character of Γ₂₃ or Γ₄₃ is a band six- or seven-character, and none of Γ₄₃ a band
eight-character; so no colouring of the form `x ↦ ⌊kλ(x)⌋`, `λ` a character, colours Γ₂₃ with fewer than 8 colours or Γ₄₃ with fewer
than 9.* **It says nothing about `χ(Γ₂₃)` or `χ(Γ₄₃)`**: the window question (G56 — is either six-chromatic?) is untouched; a six-colouring,
if one exists, is not a character colouring, and at 43 not even a best-possible line colouring is one.

**Predictions scored.** C0-43 (0.12) and the planner's P-W6 (0.15): **lost** — no band six-character at 23 or 43. C0-23: lost at 0.10
(contaminated) and against the uncontaminated heuristic 0.77 (the heuristic's `P(no c) ≈ (7/8)^11 = 0.23` happened). **Agreement noted,
not used:** the planner's J03-3 (read by the logged leak) claims band 8 at 23 exactly at `c ∈ {11, 20, 21}`; the tool's list is the same.

## Stage 4 — SAVED (SIX-c: the Weil threshold and the complete lists below it)

### J08-4 — the threshold, derived [hand, given Weil]

*Statement.* **If `Γ_q` (`q` prime, `q ≡ 3 (mod 4)`) has a band `k`-character, then with `L = ⌈q/k⌉`,
`L(q + 1) ≤ 2√q·(q − L)`; hence `q + 1 ≤ 2(k − 1)√q`, and `q < Q_k := 4(k − 1)²`.** So `Q₆ = 100`, `Q₇ = 144`; and in general
`χ_char(Γ_q) > 1 + √q/2`.

*Proof.* Let `λ_a` be band `k` and `M(t) = #{z ∈ μ_{q+1} : Tr(az) = t}`; `Σ_t M(t) = q + 1`. For `h ≠ 0`,
`M̂(h) = Σ_t M(t)e(ht/q) = Σ_z e(Tr(haz)/q)` is the eigenvalue of `Γ_q` at the non-trivial character `λ_{ha}`; it is real (`z ↦ −z`), and
by stage 2's multiplicities `M̂(h) = −Σ_t χ(t² − 4c)e(ht/q)`, a mixed sum with a squarefree quadratic, so **`|M̂(h)| ≤ 2√q` (Weil)**.
Take `A = {0, …, L − 1}` and the Fejér function `g = 1_A ∗ 1_{−A}`, `g(t) = #{(x, y) ∈ A² : x − y = t}`: `g ≥ 0`, supported on
`|t| ≤ L − 1 < q/k`, `g(t) = q⁻¹Σ_h |Â(h)|² e(ht/q)`, `Σ_h |Â(h)|² = qL`. The band condition puts `M = 0` on `|t| < q/k`, so
`0 = Σ_t M(t)g(t) = q⁻¹[L²(q + 1) + Σ_{h≠0} |Â(h)|² M̂(h)] ≥ q⁻¹[L²(q + 1) − 2√q(qL − L²)]`, i.e. `L(q + 1) ≤ 2√q(q − L)`. With
`q/k ≤ L`: `(q + 1)/k ≤ 2√q(1 − 1/k)`, i.e. `√q + 1/√q ≤ 2(k − 1)`. ∎ (The band-1/4 analogue is FS89-S0A-8, sharper there because the
value set is forced to be exactly the middle half.)

*Checked against every exact value* (`tools/crunch_j08_threshold.py`, 0.36 s): at all **218 primes `q ≡ 3 (mod 4)` below 3,000**,
`χ_char(Γ_q)` computed exactly (complete enumeration of `c` per `q`) passes the exact integer form `L²(q+1)² ≤ 4q(q − L)²`; the least
slack is 0 (at 3 and 7, where the bound is attained); **no band 6-character at any `q ≥ 100` and no band 7-character at any
`q ≥ 144` below 3,000**, as the theorem says. **Plant:** the Weil constant 1 in place of 2 is violated by the exact values at
`q = 3, 7, 19` (fires at the consistency check); the faithful twin has no violation. The Weil input itself was checked numerically at
`q ≤ 67` in stage 2 (margins ≥ 0.44).

### J08-5 — the complete lists below `Q_k` [hand + tools exact, given Weil above `Q_k`]

*Logged as the ban's edge:* all `q ≡ 3 (mod 4)` prime below `Q_k`, and for each all `c ∈ 𝔽_q^×` — a set fixed by J08-4 and SIX-a.

| `k` | `Q_k` | `(q : c)` with a band `k`-character, complete | every other usable prime |
|---|---|---|---|
| 6 | 100 | `3: {2}`; `7: {5}`; `11: {2, 10}`; `19: {15}` | none (below 100 by enumeration; from 100 by J08-4) |
| 7 | 144 | `3: {2}`; `7: {3, 5, 6}`; `11: {2, 10}`; `19: {13, 15}` | none |

**So the primes `q ≡ 3 (mod 4)` whose plane carries a band six- or seven-character are exactly 3, 7, 11, 19** — every window member (23,
31, 43, 47) and every prime from 23 up has `χ_char(Γ_q) ≥ 8`. `χ_char` below 200 (with J08-4's floor in brackets): 3: 3 [3]; 7: 4 [4];
11: 6 [4]; 19: 5 [4]; 23: 8; 31: 8; 43: 9; 47: 10; 59: 10; 67: 14; 71: 18; 79: 14; 83: 17; 103: 15; 107: 16; 127: 22; 131: 22; 139: 24;
151: 19; 163: 33; 167: 24; 179: 26; 191: 24; 199: 25 (`κ` exact beside each in `data/fs91/j08/threshold.json`).

**The second route at `k = 6` agrees.** Six colours are refused outright on Γ_q at 59, 67, 79, 83 by certificate and at 71 and from 103 by
spectrum (rows 68–69, G44, G56) — for every colouring, so for characters; the character enumeration refuses six (indeed up to
`χ_char − 1 ≥ 9`) at the same `q` independently. On the window members 23–47 only the character route speaks (six is undecided for `χ`).

**Prime powers (remark, outside SIX-a's scope).** At `q = p^f`, `f ≥ 2`, every character of `𝔽_{q²}` takes values in `(1/p)ℤ/ℤ`, so a band
character `λ` is non-zero on the circle and `pλ` is a proper `p`-colouring of `Γ_q`. At 27 that would give `χ(Γ₂₇) ≤ 3`, against
`χ(Γ₂₇) ≥ 6` (row 70, cert): **`χ_char(Γ₂₇) = ∞`, no band character at any `k`** [hand + cert]. Not needed below (no field here has 27).

**Would have searched here:** would have run a local search for a band-six character "near" the best `c` at 43, or over random `a`; instead
the complete `c`-list, fixed by SIX-a, and J08-4 for every larger `q`.

