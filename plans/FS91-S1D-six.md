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

## Stage 5 — SAVED (SIX-d: level collapse and the ramified place; SIX-e: the three fields)

### J08-6 — level collapse at every odd stable place, `p > k/2` [hand, one mind; the band form of row 75's fibre step, FS89-S0A-4's at every `k`]

*Statement.* Let `𝔓` be a stable place of `L = F(i)` of odd residue characteristic `p`, `O` its local ring, `T_m = Cay(O/𝔓^m, S_m)`
(`S_m` the image of the local norm-one group `N¹ = {u : u·c(u) = 1}`). **If `p > k/2`, every band `k`-character of `T_m` factors through
`T_1`.** Hence `χ_char(T_m) = χ_char(T_1)` whenever `χ_char(T_1) < 2p`, and no level carries a band `k`-character, `k < 2p`, unless level
one does. No assumption on ramification in `F/ℚ`.

*Proof.* `L/F` is unramified above odd primes, so a uniformiser `π` of `F_𝔭` is one of `L_𝔓` and `c(π) = π`; `c(i) = −i`. Let `m ≥ 2`, `λ`
band `k` on `S_m`, and `ρ = λ|_{𝔓^{m−1}/𝔓^m}`; suppose `ρ ≠ 0`. (i) For `y` with `c(y) = −y`, the Cayley transform `(1 + y)/(1 − y)` has
norm one; with `y = π^{m−1}ia/2`, `a ∈ ℤ`, it is `≡ 1 + π^{m−1}ia (mod 𝔓^{2m−2})`, and `2m − 2 ≥ m`; so for every `u ∈ N¹`,
`u(1 + π^{m−1}ia) ∈ S_m`, and `λ(u(1 + π^{m−1}ia)) = λ(u) + a·j(u)`, `j(u) = ρ(π^{m−1}iu)` depending on `u mod 𝔓`. (ii) `ρ(π^{m−1}·)` is a
non-zero `𝔽_p`-linear functional on the residue field `κ = 𝔽_{q²}`; the reduction of `N¹` contains `μ_{q+1}` (the Cayley transform again),
whose `𝔽_p`-span is a subfield containing `μ_{q+1}`, hence all of `κ` (a proper subfield `𝔽_{p^e}`, `e | 2f`, `e ≤ f`, has
`p^e − 1 < p^f + 1`); so `j(u) ≠ 0` for some `u`, and `j(u)` generates `(1/p)ℤ/ℤ`. (iii) Then `{λ(u) + a·j(u) : a ∈ ℤ}` is a whole coset of
`(1/p)ℤ/ℤ`, which has a point within `1/(2p) < 1/k` of 0 — outside `B_k`. Contradiction; so `ρ = 0`, `λ` descends to level `m − 1`, where it
is band on `S_{m−1}` (the image of `S_m`); induct. ∎

**SIX-d answered.** *Higher levels at 23 and 43:* `23 > 7/2`, so band 6- and 7-characters of `UD(ℤ/23^m, 2)` would descend to Γ₂₃, which has
none (J08-2); likewise at 43. In fact `χ_char` is constant up both towers: 8 at 23 (`8 < 46`), 9 at 43 (`9 < 86`). *The ramified place above
167* in ℚ(√167): stable (residue field `𝔽_167`, `167 ≡ 3 (mod 4)`), level-one target `Γ_167`, where `χ_char(Γ_167) = 24` (`κ = 7/167`,
J08-4's floor 8); by J08-6 (`e = 2` over `ℚ_167` is allowed) no level carries a band `k`-character for `k ≤ 23`. **No band 6- or
7-character at any level of 23, 43 or 167** — by collapse, not by computation at higher levels.

### J08-7 — the pullback (CLG-a), proved here [hand]

At a stable `𝔓`, every `u ∈ U_F` is a `𝔓`-unit (`v_𝔓(c(u)) = v_{c𝔓}(u) = v_𝔓(u)` and `u·c(u) = 1`), so `R_F = ℤ[U_F] ⊆ O_𝔓`, reduction
`R_F → O/𝔓^m` is a ring map, and it carries `U_F` into `S_m`. So a band `k`-character of `T_{𝔓,m}` composed with reduction lies in
`Θ_k(R_F)`. ∎ (No density needed in this direction.)

### J08-8 — the three fields [hand + tools exact; the upper halves unconditional, the lower halves **given CLG_k (J07, unverified)**]

*Stable places* (`tools/crunch_j08_threshold.py` §(4), by the criteria: a place is stable iff its residue field in `F` is `𝔽_q` with
`q ≡ 3 (mod 4)`; all three fields break the 2-adic wall — each has the odd square class 7 or 167 ≡ 7 (mod 8), G35 — so none has a stable
dyadic place; for the multiquadratic fields every odd ramified prime (3, 5, 7, 11) has residue field `⊇ 𝔽_{p²}`, not stable):

| field | stable level-one targets examined (all below the derived bound `4(m − 2)²`) | min `χ_char` | at | bound |
|---|---|---|---|---|
| ℚ(√167) | 23: 8; 43: 9; 59: 10; 67: 14; 71: 18; 79: 14; 83: 17; 103: 15; 131: 22; 139: 24; and the ramified 167: 24 | **8** | 23 (`c ∈ {11, 20, 21}`) | 144 |
| K(√7) = ℚ(√3,√7,√11) | 83: 17; 131: 22; 167: 24; 227: 29; 479: 48; 503: 63; 563: 52; 887: 111 | **17** | 83 (`c = 43`, `κ = 5/83`) | 900 |
| de Grey's `K(√5,√7)` = ℚ(√3,√5,√7,√11) | 131: 22; 479: 48; 1091: 110; 1151: 116; 1319: 147; 1559: 142 | **22** | 131 (`c = 30`, `κ = 6/131`) | 1600 |

*Why the minimum is over all targets:* by J08-4 a target with `χ_char ≤ m − 1` has `q < 4(m − 2)²`, and every stable `q` below that bound
was computed; by J08-6 no higher level does better (`m < 2p` at every stable place). *Measured cross-check:* `m(c)` read directly off the
circle equals the law at every `c` for `q = 59, 83, 131, 167` (`tools/crunch_j08_crosscheck.py`, plant fires).

**The statements, each read aloud against "characters only, never `χ`":**
> **Correction owed (2026-09-25 crunch):** see `plans/FS91-S1V-six.md` stage 4 (the divergence table and its closing notes); carried in `plans/FS91-close-inventory.md` row 109. Not applied here; the close rewrites this entry.

- **ℚ(√167).** *Unconditional (J08-7 + J08-3):* `Θ₈(R_{ℚ(√167)}) ≠ ∅` — a character eight-colouring of ℚ(√167)'s plane exists (the
  pullback of `λ_a`, `N(a) = 11`, at either place above 23; `χ ≤ 8` itself was already row 69's via the residue map). *Given CLG_7 (J07,
  unverified):* `Θ₇(R_{ℚ(√167)}) = ∅`, hence `Θ₆ = ∅` (`Θ_k` grows with `k`), so **`χ_char(ℚ(√167)²) = 8`** = min over its targets. SIX-e's
  biconditional holds with both sides true: no target carries a band six-character (J08-5, J08-6), and given CLG_6, `Θ₆ = ∅`. **Not
  claimed:** anything about `χ(ℚ(√167)²)` beyond `4 ≤ χ ≤ 8`; the conjecture's `≥ 6` there is untouched — a colouring with fewer than six
  colours, if one exists, is not a character colouring (given CLG).
- **K(√7).** *Unconditional:* `Θ₁₇ ≠ ∅`. *Given CLG_16:* **`χ_char(K(√7)²) = 17`**; in particular `Θ₆ = Θ₇ = ∅` given CLG_6, CLG_7.
- **de Grey's field.** *Unconditional:* `Θ₂₂ ≠ ∅`. *Given CLG_21:* **`χ_char = 22`**; `Θ₆ = Θ₇ = ∅` given CLG_6, CLG_7.

**What it means for six (a reading, one line each).** At the 6-open fields character colourings are **far above** `χ ≤ 7` (the plane's
own bound): 17 and 22 colours. So, given CLG, the only colourings that could make any of these three planes six-chromatic — or even
seven-chromatic below the plane's hexagonal bound — are **non-character** colourings; G64's "six hides only in the gap between `L(F)` and
`χ(F²)`" sharpens to "six hides only in non-character colourings", and at these fields character colourings do not even reach seven.
Killing test of this reading: none — it is a restatement of J08-8 plus the plane's 7-colouring.

**Consistency with `[Fischer1990]` Ex. 4** (row 50: no additive `k`-colouring of ℚ(√167)'s plane with `k < 11`): a torsion band character
of order `N` is an additive `N`-colouring; the band characters found have order 23 (and 43, 59, … at the other targets), all `≥ 11` —
consistent; and given CLG_7 the statement `Θ₇ = ∅` is stronger than Fischer's for `k ≤ 7` in the band sense and says nothing for
`8 ≤ k ≤ 10` beyond the order bound (an order-23 character is band 8 but is a 23-colouring as an additive map).

**Predictions scored.** P-167 (`χ_char ≥ 7`, 0.80): **won, given CLG**. P-167-8 (`= 8` exactly, 0.45): **won, given CLG**. C0-167 (8 at
0.50): won. The field results are exactly as strong as CLG_7, CLG_16, CLG_21.

## Stage 6 — SAVED (SIX-f: the band-1/6 torsion characters of `Q`, N₀'s analogue; band 1/5 as a by-product)

`Q = ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (4)]`; its stable places are `2 = (1+i)²` (ramified) and the inert `q ≡ 3 (4)`. By J01-7 (verified),
`Θ₆(Q) ⊆ T + A`: `θ = τ + α`, `τ = Σ_{v ∈ P} τ_v` (finite `P`), `α(x + iy) = ux + vy` with `r = √(u² + v²)`.

### J08-9 — the reduction to a finite sumset question [hand; the dyadic step and weak approximation are Lemma N₀'s (FS89-S0A-3)]

1. **Sumset form.** The circle `x² + y² = 1` is ℚ-rational, so `U_ℚ` is dense in `S¹ × ∏_{v∈P} T(ℤ_v)` (weak approximation, N₀); `α` is
   continuous and each `τ_v` locally constant, so the closure of `θ(U_ℚ)` is **`[−r, r] + Σ_v C_v`**, `C_v = τ_v(T(ℤ_v))`, and `θ` is band 6
   iff that set lies in `B₆ = [1/6, 5/6]`. Each `C_v` is symmetric (`−1 ∈ T`).
2. **Levels.** Odd `q ≥ 7`: level 1 (J08-6's fibre, run inside the sum: the values fill a coset of step `1/q ≤ 1/7`, which has a point
   within `1/14 < 1/6` of 0). `q = 3`: level ≤ 3 (at exact level `m ≥ 4`, the fibre `t₀·Cayley(3^j i s′/2)`, `j = ⌈m/2⌉`, fills a coset of
   step `3^{−(m−j)} ≤ 1/9`, a point within `1/18`). `2`: order `| 8` (N₀'s step-1/4 coset, whose point within `1/8 < 1/6` of 0 is forbidden
   at band 1/6 as at 1/4).
3. **Places.** Let `q ≥ 7` with `τ_q ≠ 0` (level one: `C_q = V_c/q`, `≥ (q+1)/2` values) and pick any value `c′` of the rest (non-empty,
   symmetric), `d = ‖c′‖`. Then `C_q ⊆ (B₆ − c′) ∩ (B₆ + c′)` = the arc about ½ of half-length `1/3 − d` ∪ the arc about 0 of half-length
   `d − 1/6`. (a) `d ≤ 1/6`: `C_q ⊆ B₆`, so `λ_a` is band 6 on Γ_q: `q ∈ {7, 11, 19}` (J08-5). (b) `1/6 < d < 1/3`: `(q+1)/2` residues in two
   arcs of total length `1/3`: `(q+1)/2 ≤ q/3 + 2`, `q ≤ 9`: `q = 7`. (c) `d ≥ 1/3`: `V_c ⊆ {‖t/q‖ ≤ 1/3}` (**anti-band**): by J08-4's
   Fejér argument on the `≥ q/3 − 1` consecutive residues `q/3 < t < 2q/3` this is impossible for `q ≥ 107` (the exact inequality checked
   for every `q ≡ 3 (4)` in `[107, 10⁶]`; beyond, `q²/6 ≫ 2q^{3/2}`), and exactly below 107 it occurs only at **`3 (c = 1, 2)`, `7 (c = 2, 3)`,
   `11 (c = 6)`**. So **`P ⊆ {2, 3, 7, 11, 19}`, with `τ₂` on `ℤ[i]/8`, `τ₃` on `ℤ[i]/27`, `τ_q` on `ℤ[i]/q`**: a finite set, fixed by the
   derivation. The same three cases at band 1/5 give `P ⊆ {2, 3, 7, 11, 19}` too (band mode `χ_char ≤ 5`: 3, 7, 19; anti-band at `3/10`
   is inside the list above; the middle case gives `q ≤ 5`; level 1 at 3 since `1/6 < 1/5`).

### J08-10 — the complete list at band 1/6 [hand (J08-9) + tools exact]; J08-11 — at band 1/5

*Logged as the ban's edge:* an exhaustive product over the value-set classes of every character of `ℤ[i]/8` (11 classes), `ℤ[i]/27` (17),
`ℤ[i]/7` (7), `ℤ[i]/11` (11), `ℤ[i]/19` (19) — 273,581 tuples, each sumset checked exactly (denominator 316,008), early exit —
`tools/crunch_j08_sixf.py`, 2.6 s. `r_max = min ‖s‖ − 1/k` over the sumset. Representatives are `(ux + vy)/M`.

| band 1/6: torsion type `τ` (places: order × number of characters) | example | `r_max` (`|α| ≤`) |
|---|---|---|
| parity `(x + y)/2` (2: order 2, ×1) | `(x+y)/2` | 1/3 |
| 3: order 3, ×4 (`c` non-square) | `(x+y)/3` | 1/6 |
| 7: order 7, ×8 | `(2x+3y)/7` | 5/42 |
| 2: order 4, ×4 (two classes) and order 8, ×8 | `(x+y)/4`, `(x+2y)/4`, `(2x+3y)/8` | 1/12 each |
| parity + 11: order 11, ×12 (anti-band `c = 6`) | `(x+y)/2 + (x+y)/11` | 2/33 |
| parity + 7: order 7, ×8 (two classes, anti-band `c = 2, 3`) | `(x+y)/2 + (x+2y)/7`, `… + y/7` | 1/21 each |
| 19: order 19, ×20 (`c = 15`) | `(4x+5y)/19` | 5/114 |
| 11: order 11, ×12 (two classes, `c = 2, 10`) | `(2x+2y)/11`, `(2x+5y)/11` | 1/66 each |
| parity + 3: order 3 (two classes, ×4 each) | `(x+y)/2 + (x+y)/3`, `… + y/3` | 0 |
| **parity + 3: order 9, ×12 (two classes) — a 3-adic level-two type** | `(x+y)/2 + y/9`, `… + 2y/9` | 0 |
| 2: order 2 (`x/2`, `y/2`) + 3: order 3, ×4 | `y/2 + (x+y)/3` | 0 |
| 2: order 8, ×8 + 3: order 3, ×4 | `y/8 + (x+y)/3` | 0 |

**18 class-tuples, 173 torsion characters; `Θ₆(Q) = ⋃ {τ + α : |α| ≤ r_max(τ)}` over this list, and `Θ₆(Q) ⊆ T_{105,336} + A(Q)`,
`105,336 = 8·9·7·11·19`** — N₀'s analogue (`N = 168` at band 1/4). **Band 1/5 (J08-11):** 10 tuples, 77 characters — parity (`3/10`), order 3
(`2/15`), order 7 (`3/35`), dyadic order 4 ×2 and 8 (`1/20`), parity + 11 (`3/110`), parity + 7 ×2 (`1/70`), 19 alone (`1/95`); `N₅ = 35,112 =
8·3·7·11·19` — the order bound FS89-S0A-10 called "finite, not computed, at five".

**Controls.** (1) **Band 1/4 reproduces Lemma N₀ exactly** (FS89-S0A-3, two blind derivations): parity, dyadic order 4 and 8, order 3 with
`|α| ≤ 1/12`, order 7 with `|α| ≤ 1/28`, nothing mixed — the same machine, a known positive. Plant P2: the same predicate applied to the
band-1/5 list refuses it. (2) `T(ℤ₂) mod 8` is computed from the solutions mod 64 (all lift) and equals N₀'s eight points; plant P1 (all 32
congruence solutions mod 8) is refused. (3) **Measured half** (`tools/crunch_j08_sixf_points.py`): every listed type at bands 1/4, 1/5, 1/6,
with `α` at `r_max` in eight directions, is band on all **1,916 rational unit vectors** from primitive triples with `c ≤ 1,500`; at
`r_max + 1/200` every one fails somewhere (so each `r_max` is sharp on `U_ℚ` itself); the negative control `x/27` fails. (4) **Every passing
tuple has a summand whose own value set is in the band** — the `n`-fold peeling lemma's conclusion (J03-1, J07's CLG-b), checked on all 34
tuples at the three bands: a free consistency check of CLG for `F = ℚ`.

**Read aloud:** *the characters `θ` of `ℤ[U_ℚ]` putting every rational unit vector in `[1/6, 5/6]` are exactly `τ + α` with `τ` one of the
173 listed torsion characters and `α` real-linear of norm at most `r_max(τ)`.* Characters only; `χ(ℚ²) = 2`.

**Would have searched here:** would have searched random characters of `ℤ[i]/N` for band-1/6 combinations; instead J08-9 fixed the places and
levels and the product over value-set classes was exhausted.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J08-1 | SIX-a: every band `k`-character of Γ_q is `λ_a`, with value set `V_{N(a)}` (multiplicities 2/1/0); band iff `min_{V_c}|t| ≥ q/k`; only non-square `c` can be band | hand; law = direct circle at every `a`, `q ≤ 67` | stage 2 |
| J08-2 | `χ_char(Γ₂₃) = 8`, `κ = 3/23`; band 8 exactly at `c ∈ {11, 20, 21}`; no band 6 or 7 | tools exact (two halves) | stage 3 |
| J08-3 | `χ_char(Γ₄₃) = 9`, `κ = 5/43`; band 9 exactly at `c = 33`; no band 6, 7, 8 | tools exact (two halves) | stage 3 |
| J08-4 | band `k` on Γ_q ⟹ `⌈q/k⌉(q+1) ≤ 2√q(q − ⌈q/k⌉)` ⟹ `q < 4(k−1)²`; `χ_char(Γ_q) > 1 + √q/2` | hand, given Weil; consistent with all 218 exact values below 3,000 | stage 4 |
| J08-5 | band 6 and band 7 characters exist exactly at `q ∈ {3, 7, 11, 19}` (lists of `c` in stage 4); `χ_char ≥ 8` for every prime `q ≡ 3 (4)` from 23 | hand (J08-4) + tools exact | stage 4 |
| J08-6 | level collapse: at an odd stable place with `p > k/2`, every band `k`-character of any level factors through level one | hand, one mind | stage 5 |
| J08-7 | pullback (CLG-a): a band `k`-character of a stable target composed with reduction lies in `Θ_k(R_F)` | hand | stage 5 |
| J08-8 | `χ_char` = 8 (ℚ(√167)), 17 (K(√7)), 22 (de Grey's field) given CLG_7, CLG_16, CLG_21; `Θ₈`, `Θ₁₇`, `Θ₂₂ ≠ ∅` unconditionally | hand + tools exact; lower halves given CLG (J07, unverified) | stage 5 |
| J08-9 | `Θ₆(Q)` reduces to a sumset over places `{2, 3, 7, 11, 19}`, levels `8, 27, q` | hand (N₀'s dyadic step and weak approximation cited) | stage 6 |
| J08-10 | the complete band-1/6 list for `Q`: 18 types, 173 torsion characters, `Θ₆(Q) ⊆ T_{105336} + A` | hand + tools exact; control N₀ reproduced | stage 6 |
| J08-11 | the band-1/5 list for `Q`: 10 types, 77 characters, `N₅ = 35,112` | hand + tools exact | stage 6 |
| J08-R | `χ_char(Γ₂₇) = ∞` (no band character at any `k`) | hand + cert (row 70) | stage 4 remark |

## Would-have-searched log (all stages)

- Stage 3: would have run a local search for a band-6 character at 23 or 43; instead the complete list over `c` (22, 42 values).
- Stage 4: would have sampled large `q` for band 6/7; instead J08-4's threshold and the complete list below it.
- Stage 5: would have searched higher tower levels at 23, 43, 167 for band characters; instead J08-6's collapse.
- Stage 6: would have searched random combinations of local characters; instead J08-9's finite place/level set, exhausted.
- No search was run. Every enumeration is over a set a derivation fixed first (standing rule 3's edge), each logged at its stage.

## Proposed edits (for the front-page lane; this job edits none of these files)

- `LEDGER.md` § B: J08-1 … J08-11, J08-R (one line each; the derivation file is this record until the close moves it).
- `CLAUDE.md` Frontier items 11/12/15 and G56/G59/G64: "a six-colouring of a window member, if one exists, is not a character colouring:
  `χ_char(Γ₂₃) = 8`, `χ_char(Γ₄₃) = 9` (J08)"; "given CLG, character colourings of ℚ(√167)'s, K(√7)'s and de Grey's planes need exactly
  8, 17, 22 colours" (item 25 / G76's Do line: aim no six-hunt at character colourings).
- `plans/STUB-four-colours-167.md` (FS-59) and `plans/STUB-adelic-window-colouring.md` (FS-64): the one-character case is closed at six and
  seven, given CLG_7; `χ_char(ℚ(√167)²) = 8`.
- **Row 69's ceilings are line colourings, not character colourings**: at 43 the ceiling 8 is not a character colouring (`χ_char = 9`) —
  any sentence reading row 69's ceilings as characters is wrong (the J08 brief's control did).
- FS89-S0A-10's "finite, not computed, at five": `N₅ = 35,112`, computed (J08-11).

