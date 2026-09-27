# FS106-QB — blind second mind on FS106-TQ's quantitative route (FS-106, the regular half)

*Job FS106-QB (Coxeter, Opus 5.5), 2026-09-27. Brief: `data/fs106/briefs/B106-blind-second.md`; instance sheet:
`data/fs106/briefs/QB106-instance.md`; standing rules: `data/fs106/briefs/STANDING-RULES.md`. Blind: nothing fenced was opened before stage 3's
commit. Working directory `data/fs106/fs106-qb/`; tools `tools/fs106_qb_*.py`.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| QB-R | Kept points (balls of radii `ε/2`, `2ε` at least 9/10 full of one tight class) avoid every distance in `[1 − ε, 1 + ε]`, `0 < ε ≤ 1/2`; any `η < 0.1100` | hand, one mind; constants tools-exact | §2.1; `tools/fs106_qb_rem_constants.py` |
| QB-CORE | A density point of a class that avoids distance 1 almost everywhere sees upper density 0 of that class at every point at distance 1 | hand, one mind | §2.1 |
| QB-B | D-SLACK's forms (a) and (b) are equivalent; an `ε`-slack class is tight; `µ₆(ε) ≤ µ₆⁰`, `µ₆` monotone | hand, one mind | §2.2 |
| QB-K | The unit-pair form `∫_B f(f ∗ σ)` is weak-* continuous on bounded sets of `L^∞` (the circle measure is Rajchman) | hand, one mind; standard | §2.3 |
| QB-EQ | `χ_m⁰ ≤ 6 ⟺ χ_CP ≤ 6 ⟺ µ₆⁰ = 1 ⟺ lim µ₆(ε) = 1 ⟺` (e) periodic pixelated band-proper partial colourings with vanishing holes `⟺` (f) NC; no MR, no Voronov (row 130 for `χ_CP`); the same for every `k` | hand, one mind (+ row 130, two) | §2.4 |
| QB-SUP | `µ₆⁰ = lim µ₆ = lim µ₆^tile = lim µ₆^per`, with `µ₆^per(ε) = µ₆(ε)` at each `ε`; `µ₆⁰` attained | hand, one mind | §2.6 |
| QB-REM | C-Q-REM (i) with `η = 1/10`, `ε ≤ 1/2`; (ii) given a jointly measurable version (D-CP has none built in; one exists) | hand, one mind | §2.5 |
| QB-ATT | `µ₆(ε)` is attained by a stationary random family, and by almost every sample of it | hand, one mind | §2.7 |
| QB-V11 | "`µ₆(ε) < 1` for every `ε > 0`" ⟺ V-1.1 (Euclidean, six colours) | hand, one mind | §2.7 |
| QB-F / QB-EPS | Fill lemma; given `[Voronov2023]` Thm 1.3, every partial 6-colouring with `Leb ⊗ Leb`-null band pairs leaves lower density `≥ ε²/(6 + ε)² ≥ ε²/49` (`ε ≤ 1`) uncovered; unconditionally the statement implies V-1.1 at each `ε` | hand, one mind; conditional on V-1.3 (external) | §2.8 |
| QB-HIT | Strips of width `2ε` at spacing `s ≤ 2` meet every unit circle and bicycle in positive length; density `2ε/s`, as low as `ε`; hitting-form arguments prove at most that | hand, one mind | §2.9 |
| QB-LOC | Parts's 6-tiling shrunk by `ε` is band-proper with every coloured point of chromaticity 1; C-Q-LOCAL for every `δ > δ₆` | hand, one mind; Parts's figures external | §2.10 |
| QB-P | Pixel lemma: any band-proper partial 6-colouring of `U₃` becomes, at arbitrarily small cost in slack and coverage, one with chromaticity `≤ 2` (or 1) everywhere; so a trichromatic-point lemma for partial colourings already implies C-Q-STAB | hand, one mind | §2.10 |

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation (in the brief or the sheet) | source | result |
|---|---|---|
| TQ-EQ, TQ-EPS2, TQ-SUP, TQ-HIT, "quoted verbatim from the deriver's list of theorems" | FS106-TQ's record (fenced) | **unchecked until stage 4** (the source is fenced) |
| C-Q-EQ "(l. 170): "`χ_m⁰(ℝ²) ≥ 7` if and only if `lim_{ε→0} µ₆(ε) < 1`."" | `data/fs106/claims.md` l. 170 | matches |
| line numbers C-Q-REM l. 162, C-Q-COMP l. 167, C-Q-LOCAL l. 179 | `data/fs106/claims.md` | match |
| "The definitions of `µ₆(ε)`, `µ₆⁰`, CP colourings, the normal form and the rest are in `data/fs106/claims.md` §0, §1 and §6" | `data/fs106/claims.md` | **discrepancy: `µ₆⁰` is defined nowhere in `claims.md`** (grep: no occurrence). I fix my own definition (§1.2) and check TQ's at stage 4 |
| "`LEDGER.md` row 130's statement: `χ_CP(ℝ²) = χ_m⁰(ℝ²)`" | `LEDGER.md` l. 175 | matches (row 130 reads "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`", no MR) |
| D-M "(FS-103's `data/fs103/claims.md` D-M, verbatim)" | `data/fs103/claims.md` l. 47–48 | matches (truncated before `χ_B`, no change of sense) |
| D-CP "(FS-103's D-CP (b), verbatim)" | `data/fs103/claims.md` l. 35–38 | matches, truncated; the dropped sentence matters here: **"No joint measurability is part of the definition."** (used in §2.5) |
| D-VPROP, D-VMC (`[Voronov2023]` Defs. 2.1, 2.3–2.4) | `library/pdf/arXiv-2304.10163-voronov.pdf`, text layer l. 215–274 | match |
| C-Q-STAB's `[SokolovVoronov2025]` §9 p. 26 quotation | `library/pdf/arXiv-2502.01958-maptype.pdf`, text layer l. 1038–1041 | matches. Context not quoted in the claim, relevant here: the same paragraph says "the area of regions S = S(ε), after excluding which we obtain a proper coloring with forbidden distance interval [1 − ε, 1 + ε], at ε → 0 has asymptotics S(ε) = Ω(ε2 )" (no proof printed) and cites "the 1/6997 part of the plane remains uncolored [8]" |
| `[Parts2020c]` "more than 99.985698% of the Euclidean plane" | `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`, abstract | matches; the paper's own void fraction is "δ6 ≈ 0.000143017209" (§2.3) |
| I-D1, I-D2, I-D4 (from `plans/FS103-M-derivation.md`) | fenced for this job | unchecked (not used as inputs below except I-D4, which I re-derive in §2.6) |
| standing rule 0's Kooshi quotation | `CLAUDE.md` § Counter-priors (read from disk) | matches |

Also found: `BIBLIOGRAPHY.md` l. 171 lists `[Parts2020c]` as "not held"; it is held at `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`
(file dated 2026-09-27 00:15). A correction owed.

### 1.2 My definitions (fixed before any derivation)

- `σ` normalised arc length on `S¹`; `σ_t` its dilate to the circle of radius `t`; `H¹` arc length. Upper density `d̄(A) = limsup_{R→∞} |A ∩ B(0,R)|/|B(0,R)|`,
  lower density `d̲` with `liminf`.
- **Tight family:** disjoint measurable `C₁, …, C₆` with `(Leb ⊗ σ){(x, w) : x ∈ C_j, x + w ∈ C_j} = 0` for each `j`.
  **`µ₆⁰`** `:= sup d̄(C₁ ∪ ⋯ ∪ C₆)` over tight families.
- **`ε`-slack family:** D-MU's condition, `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`; `µ₆(ε)` as D-MU.
- **`µ₆^per(ε)`:** the same supremum over `ε`-slack families invariant under `Lℤ²` for some `L > 0` (the "periodic grid-square" families; the density
  exists).
- **`µ₆^tile(ε)`:** the same supremum over `ε`-slack families each of whose classes is, up to a null set, a union of cells `hk + [0, h)²`, `k ∈ ℤ²`, for some
  `h > 0` (pixelated; V-2.1's tiles specialised to a square grid). `µ₆^{tile,per}` both at once.
- **NC ("near-covering a.e.-proper colourings of every disc"):** for every `R > 0` and `δ > 0` there is a tight family inside `B(0, R)` covering at least
  `(1 − δ)|B(0, R)|`. (The strong reading, `δ = 0`, is treated too.)
- **Hitting-form argument (TQ-HIT):** an argument whose only use of the uncovered set `H` is that `H` meets every unit circle `T₁(u)` and every bicycle
  `T₁(u) ∪ T₁(v)`, `1 < |u − v| < 2`, in a set of positive length (equivalently, for strips, that `H` has positive measure in every `η`-neighbourhood of each).

### 1.3 Expectations, registered before any written derivation (after one mental pass; nothing fenced seen)

| claim | my expectation | probability |
|---|---|---|
| TQ-EQ / C-Q-EQ | TRUE, no MR, no Voronov; the hard direction (vanishing holes ⟹ colouring) by weak-* compactness, the circle's Fourier decay making the unit-pair form continuous, then a support selection | 0.85 |
| TQ-EPS2 | TRUE **only conditionally** on a Voronov-type non-existence (V-1.3's band form on `U₃`), since without one a band-proper full 6-colouring would leave nothing uncovered; constant improvable | 0.8 that it is conditional; 0.8 that it holds given V-1.3 |
| TQ-SUP | TRUE under my definitions; `µ₆^per(ε) = µ₆(ε)` at every `ε`, not only in the limit | 0.8 |
| TQ-HIT | TRUE as a limitation statement; the density constant is not optimal | 0.9 |
| C-Q-REM (i), core, (ii) | TRUE; `η = 1/10` suffices for `ε ≤ 1/2`; (ii) needs a jointly measurable version (D-CP has none built in) | 0.85 |
| C-Q-COMP (i) | TRUE (through row 130 for `χ_CP`) | 0.85 |
| C-Q-COMP (ii) | attained: TRUE; `µ₆(ε) < 1`: TRUE only conditional on V-1.1, and equivalent to it | 0.75 |
| C-Q-LOCAL | TRUE for `δ >` Parts's void fraction (shrink the tiles); the equality case needs a fact about the tiling not checked; the consequence TRUE in a sharpened form: on partial colourings a trichromatic-point lemma is as strong as C-Q-STAB itself | 0.7 |

**G21 audit, registered now:** the flattering reading of TQ-EQ is "the problem became easy". My expectation: the equivalence is a compactness
restatement that moves no value — it trades "no measurable a.e.-proper 6-colouring" for "a bound on `µ₆(ε)` uniform in `ε`", and every bound held
(TQ-EPS2's, S–V's `Ω(ε²)`) tends to 0 with `ε`.

### 1.4 Controls

1. **The constants of C-Q-REM (i)** in exact-plus-interval arithmetic (`tools/fs106_qb_rem_constants.py`), with planted faults that must fail for
   their own reason: `η = 0.12` (above the threshold); one common scale `ρ` for both points (no admissible geometry); `ε = 0.9` (the arc bound breaks).
2. **Known positives for the equivalence at other `k`:** at `k = 7` the hexagonal colouring has slack, so `lim µ₇(ε) = 1` and `χ_m⁰ ≤ 7`, consistent;
   at `k = 4`, `χ_m⁰ ≥ χ(ℝ²) ≥ 5` (I-EASY) forces `lim µ₄(ε) < 1`, consistent with Croft's `δ₄ ≈ 0.0825` (`[Parts2020c]` §2.1) — a statement the
   equivalence must not contradict.
3. **The analytic step's necessity:** the compactness step must use the decay of `σ̂`; with the edge measure replaced by a non-Rajchman one it must not
   go through (row 130's "false without it"), and I check my proof uses the decay exactly once.
4. **TQ-EPS2's direction:** the fill argument must use "six" only through V-1.3 — with seven colours (the hexagonal tiling, no holes, slack) it must
   produce no contradiction.

## Stage 2 — SAVED

*Derivations, blind. Notation as §1.2. `B(x, r)` open disc, `U_r(x)` closed disc, `|·|` Lebesgue measure. Every lemma is one mind (this job).*

### 2.1 Lemma R — kept points avoid the band (C-Q-REM (i), deterministic form), and the pointwise core

**Lemma R.** Let `D ⊆ ℝ²` be measurable with `(Leb ⊗ σ){(z, w) : z ∈ D, z + w ∈ D} = 0`, let `0 < ε ≤ 1/2`, `η = 1/10`. If
`|B(x, 2ε) ∖ D| ≤ η|B(x, 2ε)|` and `|B(y, ε/2) ∖ D| ≤ η|B(y, ε/2)|`, then `|x − y| ∉ [1 − ε, 1 + ε]`.

*Proof.* Suppose `d = |x − y| ∈ [1 − ε, 1 + ε]`. Put `A = D ∩ B(y, ε/2)`, `X = B(x, 2ε)`. Fubini on `(y′, w) ↦ (y′, y′ + w)`, `σ` symmetric:
`∫_{B(y,ε/2)} H¹(S(y′, 1) ∩ X ∖ D) dy′ = ∫_{X ∖ D} H¹(S(z, 1) ∩ B(y, ε/2)) dz`. (1) *Every arc is long:* for `y′ ∈ B(y, ε/2)`, `s = |y′ − x| ∈
[1 − 3ε/2, 1 + 3ε/2]`, and a point of `S(y′, 1)` at angle `θ` from the direction `y′ → x` is at squared distance `(s − 1)² + 4s sin²(θ/2)` from `x`; with
`s ≤ 7/4` and `sin(θ/2) ≤ ε/2` this is `≤ 9ε²/4 + 7ε²/4 = 4ε²`, so `H¹(S(y′, 1) ∩ X) ≥ 4 arcsin(ε/2) ≥ 2ε`. (2) *Every chord is short:* a unit circle meets a
disc of radius `ε/2` in one arc of chord `≤ ε`, length `≤ 2 arcsin(ε/2) ≤ 1.01073 ε` (`arcsin t/t` increasing; `arcsin(1/4) ≤ 0.252680`). Hence
`∫_A H¹(S(y′, 1) ∩ X ∩ D) dy′ ≥ (1 − η)(πε²/4)(2ε) − η(4πε²)(1.01073ε) = πε³(0.45 − 0.40429) > 0`, a positive `Leb ⊗ H¹`-measure of pairs `(y′, z)`
in `D × D` with `|y′ − z| = 1`: contradiction. The threshold is `η < 0.11006`. ∎ Exact check: `tools/fs106_qb_rem_constants.py` (rational arithmetic, rigorous
arcsin bounds; three plants refused for their own reasons: `η = 0.12`; one common radius — no arc is guaranteed, since circles from `B(y, ρ)` pass up to
`ε + ρ` from `x`, which is why two scales are needed; `ε` up to 0.9).

**Pointwise core** (C-Q-REM's own line, "if `x` is a density point of a class `D` avoiding distance 1 at every pair, then every point at distance 1 from
`x` has density 0 in `D`"). TRUE, and more: it holds when `D` avoids distance 1 only almost everywhere (`Leb ⊗ σ`-null), and "density 0" holds as
*upper* density 0. *Proof.* Let `|x − y| = 1`, `d̄_D(y) = θ > 0`: there are `r → 0` with `|D ∩ B(y, r)| ≥ (θ/2)πr²`. For `y′ ∈ B(y, r)`, `S(y′, 1)` passes within
`r` of `x`, so meets `B(x, 2r)` in an arc of length `≥ 2√3 r(1 − O(r))`; the arcs landing in `B(x, 2r) ∖ D` have total `≤ |B(x, 2r) ∖ D| · 2.1r = o(r²)·r`
(density point). So `∫_{D∩B(y,r)} H¹(S(y′,1) ∩ B(x,2r) ∩ D) dy′ ≥ (θ/2)πr² · 3r − o(r³) > 0` for small `r`: a positive measure of unit pairs in `D`, so a
pair exists — contradiction both with "every pair" and with "almost every pair". ∎

### 2.2 Lemma B — slack implies tight; D-SLACK's two forms agree

**Lemma B.** For measurable `C` and `ε > 0`: `(Leb ⊗ Leb){(x, y) ∈ C² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0` (form (a)) **iff** for every `t ∈ [1 − ε, 1 + ε]`,
`(Leb ⊗ σ){(x, w) : x ∈ C, x + tw ∈ C} = 0` (form (b)). In particular an `ε`-slack class is tight (`t = 1`).

*Proof.* Polar coordinates: form (a)'s measure is `∫_{1−ε}^{1+ε} 2πt φ(t) dt`, `φ(t) = (Leb ⊗ σ){x ∈ C, x + tw ∈ C}`; (b) ⟹ (a) at once. For (a) ⟹ (b), localise:
`φ_B(t) = ∫_B ∫ 1_C(x) 1_C(x + tw) dσ(w) dx` is continuous in `t`, since `|φ_B(t) − φ_B(t′)| ≤ sup_{|h| ≤ |t − t′|} ‖1_{C∩B″}(· + h) − 1_{C∩B″}‖₁ → 0`
(`B″ ⊇ B + U₃(0)`; continuity of translation in `L¹`). `φ_B ≥ 0` vanishes a.e. on `[1 − ε, 1 + ε]`, hence everywhere there; sum over a countable cover by balls. ∎
So `µ₆(ε) ≤ µ₆⁰` for every `ε > 0`, and `µ₆(ε)` is non-increasing in `ε`, so `lim_{ε→0} µ₆(ε) = sup_ε µ₆(ε)` exists.

### 2.3 Lemma K — the unit-pair form is weak-* continuous (the only analytic input); Lemma S — support selection

**Lemma K.** Let `f_m → F` weak-* in `L^∞(ℝ²)`, `sup ‖f_m‖_∞ < ∞`. Then for every ball `B`, `∫_B f_m (f_m ∗ σ) → ∫_B F (F ∗ σ)`.

*Proof.* On `B`, `f ∗ σ` depends only on `f` on `B⁺ = B + U₁(0)`; set `g_m = f_m 1_{B⁺}`, `G = F 1_{B⁺}`; then `g_m ⇀ G` weakly in `L²`, supports in the compact
`B̄⁺`. With `h_m = g_m − G`: `ĥ_m(ξ) = ⟨h_m, e^{2πi⟨·,ξ⟩}1_{B⁺}⟩ → 0` for every `ξ`, and `|ĥ_m| ≤ |B⁺|^{1/2} M`. Plancherel:
`‖h_m ∗ σ‖₂² = ∫|ĥ_m|²|σ̂|² ≤ ∫_{|ξ|≤A} |ĥ_m|² + (sup_{|ξ|>A} |σ̂|²) M²`; the first term → 0 by dominated convergence, the second is small because
`σ̂(ξ) = J₀(2π|ξ|) → 0` — **the circle measure is Rajchman; this is the one place it is used** (control 3: with a non-Rajchman edge measure the step fails,
matching row 130's "false without it"). So `g_m ∗ σ → G ∗ σ` in `L²`, and `∫_B f_m(f_m∗σ) − ∫_B F(F∗σ) = ∫_B f_m(h_m∗σ) + ∫_B (f_m − F)(G∗σ) → 0`. ∎
(For the band form, the kernel is `1_{annulus} ∈ L¹` and continuity is elementary; no decay is needed.)

**Lemma S.** If `F = (F₁, …, F₆)`, `F_j ≥ 0` measurable, `∫∫ F_j(x)F_j(x + w) dσ(w) dx = 0` for each `j`, and `Σ_j F_j > 0` a.e., then
`c(x) = min{j : F_j(x) > 0}` (colour 1 on the null rest) is a measurable 6-colouring proper at `Leb ⊗ σ`-almost every edge.
*Proof.* `{c = j} ⊆ {F_j > 0}`, and `F_j(x)F_j(x + w) > 0` only on a null set; the null rest `N` meets a null set of edges (`∫ σ{w : x + w ∈ N} dx = |N|`). ∎

### 2.4 TQ-EQ and C-Q-EQ

Six statements: **(a)** `χ_m⁰(ℝ²) ≤ 6`; **(b)** `χ_CP(ℝ²) ≤ 6`; **(c)** `µ₆⁰ = 1`; **(d)** `lim_{ε→0} µ₆(ε) = 1`; **(e)** for every `δ > 0` there are `ε > 0`,
`L, h > 0` and an `Lℤ²`-periodic, `h`-pixelated partial 6-colouring with **no** monochromatic pair at distance in `[1 − ε, 1 + ε]` (every pair, not a.e.)
and uncovered density `≤ δ`; **(f)** NC (§1.2), in either reading.

- (a) ⟺ (b): `LEDGER.md` row 130 (held, no MR).
- (a) ⟹ (c) and (a) ⟹ (f): the colour classes, or their restrictions.
- (c) ⟹ (e): §2.6 step (iv) then step (iii) (kept points, periodise, pixelate).
- (e) ⟹ (d): an (e) family is `ε`-slack. (d) ⟹ (c): Lemma B.
- **(c) ⟹ (a) — the direction the sheet asks to audit.** Take tight families `𝒞^m` with `d̄(⋃𝒞^m) ≥ 1 − δ_m`, `δ_m ↓ 0` (`δ_m > 0`), holes `H_m`. Put
  `r_m = δ_m^{−1/4}`. Along `R_n → ∞` with `|H_m ∩ B(0, R_n)| ≤ (δ_m + o(1))|B(R_n)|`, the average over `x ∈ B(0, R_n)` of `|H_m ∩ B(x, r_m)|` is
  `≤ |B(r_m)| · |H_m ∩ B(0, R_n + r_m)|/|B(R_n)| ≤ (δ_m + o(1))|B(r_m)|`, so some `x_m` has `|H_m ∩ B(x_m, r_m)| ≤ 2δ_m π r_m² = 2π δ_m^{1/2}`. Let `f^m` be
  the indicator vector of `𝒞^m(· + x_m)` (translation keeps tightness); pass to a weak-* limit `F` (bounded sets of `L^∞ = (L¹)*` are weak-* sequentially
  compact, `L¹` separable). The constraints `F_j ≥ 0`, `ΣF_j ≤ 1` are weak-* closed; for every `r`, `∫_{B(0,r)} (1 − ΣF_j) = lim ∫_{B(0,r)} 1_{H_m(·+x_m)} ≤
  lim 2πδ_m^{1/2} = 0`, so `ΣF_j = 1` a.e.; by Lemma K, `∫_B F_j(F_j∗σ) = lim ∫_B f_j^m(f_j^m ∗ σ) = 0` for every ball. Lemma S gives (a). ∎
  The hypothesis needs only *upper* density; C-Q-COMP (i)'s "lower density" is stronger than needed.
- (f) ⟹ (a): the same, with `𝒞^m` a tight family in `B(0, 2m)` covering `≥ (1 − m^{−3})` of it and `x_m ∈ B(0, m)` chosen as above with
  `|H_m ∩ B(x_m, m)| ≤ 4π/m`; with `δ = 0` no averaging is needed.

**Verdict.** TQ-EQ: **TRUE** as a chain of six equivalences, **no MR, no Voronov**, [hand, one mind here], with (a) ⟺ (b) resting on row 130
[hand, two derivations]. C-Q-EQ: **TRUE** — the negation of (a) ⟺ (d), the limit existing by monotonicity. **G21 audit** (§2.11): true, and it moves no value.

### 2.5 C-Q-REM (i), (ii)

D-CP carries **no joint measurability** (FS-103's text says so). A process continuous in probability on a separable metric index set with values in a finite
set has a jointly measurable modification (Doob; e.g. Kallenberg, *Foundations*, the measurable-version lemma — cited, not re-read); "in normal form"
presupposes such a version, and I fix one.

- **(i)** For that version, `E[(Leb ⊗ σ){(x, w) ∈ B × S¹ : c(x) = c(x + w)}] = ∫_B ∫ P(c(x) = c(x + w)) dσ dx = 0`, so almost surely each class `S_j` is tight;
  then Lemma R with `D = S_j` (and `|S̃_j Δ S_j| = 0`): **TRUE**, `η = 1/10` for `0 < ε ≤ 1/2` (any `η < 0.1100`), every `k`. The claim must be read for small `ε`
  (for `ε ≥ 1` it is false trivially: a kept point and kept points near it). [hand, one mind]
- **Pointwise core:** **TRUE**, stronger as stated in §2.1. [hand, one mind]
- **(ii)** `Bad(ω) = {x : x not a density-1 point of S_{c(x)}(ω)}` is `|·|`-null for every `ω` (Lebesgue), jointly measurable, and its indicator at `h` has the same
  law as at `0` (the densities `∫_{B(h,r)} 1{c(x) = c(h)} dx`, `r` rational, are `L¹(P)`-limits of Riemann sums, whose laws are fixed by the translation-invariant
  finite-dimensional laws). So `P(0 ∈ Bad) = E|Bad ∩ B(0,1)|/π = 0`; off `Bad`, `0` is kept at scale `ε` for all small `ε`; dominated convergence:
  `P(0 not kept at scale ε) → 0`. **TRUE.** [hand, one mind]

### 2.6 TQ-SUP

Steps: **(i)** `µ₆(ε) ≤ µ₆⁰` (Lemma B). **(ii)** `µ₆^per(ε) = µ₆(ε)` at every `ε < 1`: given an `ε`-slack family with `d̄ ≥ µ₆(ε) − δ`, take `R` with
fraction `≥ µ₆(ε) − 2δ` in `B(0, R)`; among the `L`-squares inside `B(0, R)` (`L ≪ R`) one has fraction `≥ µ₆(ε) − 2δ − O(L/R)`; restrict the family to it and
repeat with period `L + 2` — inside a copy the classes are subsets, across copies distances are `≥ 2 > 1 + ε`; density `≥ (µ₆(ε) − 3δ)L²/(L + 2)²`.
**(iii)** Pixelation: `µ₆^tile(ε − 2√2 h) ≥ µ₆(ε)` for `2√2h < ε`: colour a cell `Q` of `hℤ² + [0, h)²` by `min{j : |C_j ∩ Q| > 0}` when one exists; two cells coloured
`j` containing points at distance in `[1 − ε + 2√2h, 1 + ε − 2√2h]` have all their cross pairs in `[1 − ε, 1 + ε]`, and `(C_j ∩ Q) × (C_j ∩ Q′)` has positive
measure — contradiction; so the pixelated classes have **no** band pairs at all, and they cover `⋃C_j` up to a null set. (It commutes with (ii) when `h | L + 2`.)
**(iv)** `lim_{ε→0} µ₆^per(ε) ≥ µ₆⁰`: given a tight family with `d̄ ≥ µ₆⁰ − δ`, an `L`-square `Q` with fraction `≥ µ₆⁰ − 2δ`; the kept subsets `K_j^ε ⊆ C_j`
(`η = 1/10`, radii `ε/2, 2ε`, fullness measured against `C_j`) have no two points at distance in `[1 − ε, 1 + ε]` (Lemma R) and `1_{K_j^ε} → 1_{C_j}` a.e. (Lebesgue),
so for small `ε` the kept union has fraction `≥ µ₆⁰ − 3δ` in `Q`; periodise as in (ii).

So `µ₆⁰ ≤ lim µ₆^per = lim µ₆ ≤ µ₆⁰`, and `µ₆^tile(ε) ≤ µ₆(ε) ≤ µ₆^tile(ε′)` for `ε′ < ε` gives the tile limit; the same for `µ₆^{tile,per}`. **Verdict: TRUE**
under §1.2's definitions, [hand, one mind]; stronger than stated at step (ii) (equality at each `ε`, not only in the limit). Also: `µ₆⁰` is **attained**
(§2.7's compactness with Lemma K; the argument of (c) ⟹ (a) without the hole condition).

### 2.7 C-Q-COMP

- **(i) TRUE** (and with upper density): (c) ⟹ (a) of §2.4, then row 130 for `χ_CP`. [hand, one mind; row 130 two]
- **(ii), attainment: TRUE.** The fuzzy families `F ∈ L^∞(ℝ², [0,1]⁶)`, `ΣF ≤ 1`, whose band form `∫_B F_j (F_j ∗ 1_{annulus})` vanishes on every ball, form a weak-*
  compact metrizable space `X` (the band form is weak-* continuous: the kernel is `L¹`), on which `ℝ²` acts continuously. For near-optimal families, the averages
  over `x ∈ B(0, R_n)` of the Dirac masses at their translates converge (Krylov–Bogoliubov) to invariant laws with `E[(1/π)∫_{B(0,1)} ΣF] ≥ µ₆(ε) − o(1)`; a limit
  law has `≥ µ₆(ε)`. The support selection `F ↦ ({F₁ > 0}, {F₂ > 0} ∖ {F₁ > 0}, …)` is Borel (weak and norm Borel sets agree on bounded sets of `L²_loc`) and
  equivariant, and keeps band-nullness; its image is a stationary random `ε`-slack family with mean coverage `≥ µ₆(ε)`. By Wiener's ergodic theorem each sample's
  density exists and has mean `≥ µ₆(ε)`, while each sample is a deterministic family, of upper density `≤ µ₆(ε)`: so **almost every sample attains `µ₆(ε)`**.
- **(ii), `µ₆(ε) < 1`: TRUE conditionally — exactly as strong as V-1.1 (Euclidean, six colours).** If `µ₆(ε) = 1`, the attaining family covers the plane up to a
  null set, and I-D4's construction (re-derived: §2.8, Lemma F with `r → 0`, i.e. `c(x) = min{j : x ∈ supp C_j}`) is proper at every pair at distance in
  `(1 − ε, 1 + ε)`, contradicting V-1.1 at `ε/2`; conversely a band-proper 6-colouring gives `µ₆(ε) = 1`. So "`µ₆(ε) < 1` for every `ε`" ⟺ V-1.1 (Euclidean,
  `k = 6`). [hand, one mind; conditional on V-1.1, external]

### 2.8 TQ-EPS2 — true only through a Voronov theorem; the constant improves

**Lemma F (fill).** Let `C₁, …, C₆` be `ε`-slack, `0 < r < ε/2`, `z ∈ ℝ²`, and suppose `|B(x, r) ∖ H| > 0` for every `x ∈ U₃(z)` (`H` the uncovered set). Then
`c′(x) = min{j : |C_j ∩ B(x, r)| > 0}` colours all of `U₃(z)` and is proper for `[1 − (ε − 2r), 1 + (ε − 2r)]` at every pair (D-VPROP): two points of colour `j` at a
distance in that interval have all cross pairs of their `r`-balls in `[1 − ε, 1 + ε]`, a positive measure of band pairs of `C_j`. The hypothesis holds when
`|H ∩ B(z, 3 + r)| < πr²`. ∎ (`r → 0` over `supp C_j` is I-D4.)

**V-1.3 as printed kills `c′`:** the closures of `c′`'s six classes are closed and cover `U₃(z)`, and a unit pair in one closure gives nearby points of that class at
a distance in the open band — so none realises the unit distance, contradicting V-1.3. Hence, **given V-1.3**, every disc of radius `3 + r` has
`|H ∩ B(z, 3 + r)| ≥ πr²`; averaging centres over `B(0, R)` gives `d̲(H) ≥ (r/(3 + r))²` for every `r < ε/2`, so
**`d̲(H) ≥ ε²/(6 + ε)² ≥ ε²/49` for `0 < ε ≤ 1`** — stronger than `ε²/78`.

**Without a Voronov-type theorem TQ-EPS2 cannot hold as an unconditional statement:** it implies, at each `ε`, that no `ε`-band-proper 6-colouring of the plane
exists (a band-proper colouring's classes are `ε`-slack and leave nothing uncovered), i.e. V-1.1 at that `ε`. **Verdict: TRUE conditional on V-1.3 as printed
(or V-1.3's band form, C-CS-2's easy direction), with the better constant `ε²/(6 + ε)²`; FALSE-as-unconditional is not established, but the statement is at least
as strong as V-1.1 and has at most its grade.** [hand, one mind; external input `[Voronov2023]` Thm 1.3] Consistent with `[SokolovVoronov2025]` §9's unproved
"`S(ε) = Ω(ε2 )`" and with Parts (control 4: with seven colours the fill produces a band-proper 7-colouring, no contradiction — the hexagonal tiling).

### 2.9 TQ-HIT

The strips `S = {(x, y) : dist(y, (1/2)ℤ) ≤ ε}`, `ε < 1/4`, have density `4ε`; every unit circle `T₁(u)`, `u = (a, b)`, has `y`-range `[b − 1, b + 1]`, which contains
some `k/2` in its interior, so `T₁(u)` crosses the line `y = k/2` transversally and meets `S` in arcs of positive length; every bicycle contains a unit circle.
Any conclusion that uses the uncovered set only through this hitting property holds for `S`, so it bounds the uncovered density by at most `4ε` — indeed by
at most `ε`: spacing `2` works too (an interval of length 2 always meets `2ℤ`, and a circle tangent to a line still meets the `ε`-strip in an arc).
**Verdict: TRUE** as a limitation of hitting-form arguments; the constant `4ε` improves to `ε`. [hand, one mind] "Effective" can only mean hitting: if the complement
of such strips were band-properly 6-colourable for `ε → 0`, (e) would hold and `χ_m⁰ ≤ 6`.

### 2.10 C-Q-LOCAL, and the pixel lemma behind its consequence

**The statement.** `[Parts2020c]` §2.3: the 6-tiling puts voids at every vertex — rhombus/dodecagon voids "at vertices of type A" (degree 4) and arrowhead voids
"at the corners of the inclined sides instead of the vertices of type B" (degree 3); its void fraction is "δ6 ≈ 0.000143017209" (`δ₆`). The tiling is **tight**
("use equalities rather than inequalities"): tiles have closure-diameter `≤ 1`, and two tiles of one colour have all cross distances `≤ 1` (Siamese, allowed) or all
`≥ 1`. Shrink every tile to `T_ε = {x : B(x, ε) ⊆ T}`: diameters and Siamese distances drop to `≤ 1 − 2ε`, other same-colour distances rise to `≥ 1 + 2ε`, so the
tiling is proper for `[1 − ε, 1 + ε]`; the shrunk tiles are pairwise at positive distance, so **every coloured point has chromaticity 1** (Def. 2.4, read in the
coloured set) — not merely below 3; the loss is `O(ε)` in density; a translate of `U₃` with hole fraction at most the average exists. **TRUE for every
`δ > δ₆`.** At `δ = δ₆` exactly it needs a translate with hole fraction strictly below the mean — nonconstancy of `x ↦ |H ∩ U₃(x)|`, plausible (tiny voids on a
lattice) and **not checked**: a GAP at the endpoint only, immaterial to the consequence. [hand, one mind; Parts's figures external]

**The consequence, sharpened. Pixel lemma P.** From any `ε`-band-proper partial 6-colouring of `U₃(0)` (measurable classes) with uncovered fraction `δ₀`, and any
`h < ε/(2√2)`, `τ > 0`: pixelate (§2.6 (iii)) and delete an open square of side `τh` about every grid vertex. The result is `(ε − 2√2h)`-band-proper, uncovered
fraction `≤ δ₀ + τ²`, and every coloured point has a neighbourhood meeting at most two cells — **chromaticity `≤ 2` everywhere** (deleting `O(τ)` along edges
too gives chromaticity 1). (Measurability costs nothing: for a band-proper colouring, `c″(x) = min{j : x ∈ cl C_j}` has closed-set-difference classes that avoid the
open band and cover at least as much.) Hence, for every `δ` (not only `δ ≥ δ₆`): a lemma "every `ε′`-band-proper partial 6-colouring of `U₃` with uncovered fraction `≤ δ` has
a trichromatic point in its coloured set", for all `ε′ > 0`, **already implies C-Q-STAB at every `δ′ < δ`**; and C-Q-STAB at `δ` makes that lemma vacuous. So a
trichromatic-point step is not a reduction of C-Q-STAB: it carries its full strength. **Verdict on the consequence: TRUE in this sharpened form** [hand, one mind];
as literally derived from C-Q-LOCAL alone it is a non-sequitur below `δ₆` (C-Q-STAB needs only some small `δ`, C-Q-LOCAL speaks of `δ ≥ δ₆`). "Needs an
obstruction spread over a set of positive measure" is a **[reading]**: P excises every point-located obstruction at arbitrarily small measure cost. Killing
test: a proof of C-Q-STAB whose only use of the colouring is a finite or null set of special points.

### 2.11 G21 audit of TQ-EQ, and the controls

- **What the equivalence does not do.** It trades "no measurable a.e.-proper 6-colouring" for "a bound on `µ₆(ε)` **uniform** in `ε`". Every bound held tends
  to 0 with `ε`: `1 − µ₆(ε) ≥ ε²/(6 + ε)²` given V-1.3 (§2.8), and `1 − µ₆(ε) ≤ δ₆ + O(ε)` by Parts (§2.10). **The fallacy to look for in the deriver's record:**
  "V-1.1 gives `µ₆(ε) < 1` for each `ε`, hence the limit is `< 1`" — false inference (a limit of numbers below 1 can be 1). The equivalence is a compactness
  restatement; the problem is exactly as hard as before, now in a quantitative costume (S–V's §9 remark, made an "iff" for measurable colourings).
- **Control 1** (constants): passed, plants refused (§2.1). **Control 2** (other `k`): the same proof gives `χ_m⁰ ≤ k ⟺ lim µ_k(ε) = 1` for every `k`; at `k = 7`
  the hexagonal colouring has slack, both sides true; at `k = 4`, `χ_m⁰ ≥ χ(ℝ²) ≥ 5` (I-EASY) gives `lim µ₄(ε) < 1`, consistent with Croft's `δ₄ ≈ 0.0825`.
  **Control 3** (analytic step): Lemma K uses the Rajchman property once, and the band version needs none. **Control 4** (six only through V-1.3): passed (§2.8).

## Stage 3 — SAVED (the write-up, committed before anything fenced is opened)

### 3.1 Verdicts

| # | claim | verdict | minds | grade |
|---|---|---|---|---|
| 1 | **TQ-EQ**, above all "vanishing holes ⟹ colouring" | **TRUE**, all six equivalences, no MR, no Voronov; (a)⟺(b) is row 130 | one (this job) | [hand]; row 130 [hand, two] |
| 1′ | **C-Q-EQ** | **TRUE** | one | [hand] |
| 2 | **TQ-EPS2** | **TRUE conditional on `[Voronov2023]` Thm 1.3** (as printed), with the better constant `ε²/(6 + ε)²`; as an unconditional statement it implies V-1.1 at each `ε`, so it can have no better grade than a Voronov theorem | one | [hand] over [external, unrefereed] |
| 3 | **TQ-SUP** | **TRUE** under §1.2's definitions (stronger: `µ₆^per(ε) = µ₆(ε)` at each `ε`; `µ₆⁰` attained) | one | [hand] |
| 4 | **TQ-HIT** | **TRUE** as a limitation; the density `4ε` improves to `ε` (spacing 2) | one | [hand] |
| 5 | **C-Q-REM** (i) | **TRUE**, `η = 1/10` for `0 < ε ≤ 1/2`; false for large `ε` trivially (read for small `ε`) | one | [hand; constants tools-exact] |
| 5 | **C-Q-REM** pointwise core | **TRUE**, stronger (a.e.-avoidance suffices; upper density 0) | one | [hand] |
| 5 | **C-Q-REM** (ii) | **TRUE**, given a jointly measurable version — which D-CP does not build in, but continuity in probability supplies | one | [hand] |
| 6 | **C-Q-COMP** (i) | **TRUE** (upper density suffices) | one (+ row 130) | [hand] |
| 6 | **C-Q-COMP** (ii) | attainment **TRUE**; "`µ₆(ε) < 1`" **TRUE conditional on V-1.1**, and equivalent to it over all `ε` | one | [hand]; conditional half over [external] |
| 7 | **C-Q-LOCAL** | **TRUE for every `δ > δ₆`** (chromaticity 1, not only below 3); **GAP at the endpoint `δ = δ₆`** (needs a translate of `U₃` with hole fraction below the mean; unchecked); consequence: **TRUE in the sharpened form of the pixel lemma** — a trichromatic-point step carries C-Q-STAB's full strength at every `δ`; as derived from C-Q-LOCAL alone it is a non-sequitur below `δ₆`; "spread over positive measure" a [reading] | one | [hand]; the last clause [reading] |

### 3.2 What the owner should know (G21)

- TQ-EQ is true and is a **compactness restatement**: it moves no value. `lim µ₆(ε) < 1` needs a bound uniform in `ε`; every bound held vanishes with `ε`
  (`ε²/(6 + ε)²` from V-1.3; `δ₆ + O(ε)` from Parts from above). The fallacy to watch for anywhere downstream: from "`µ₆(ε) < 1` for each `ε`" (= V-1.1) to
  "`lim µ₆(ε) < 1`".
- The analytic content is Lemma K (the Rajchman property of the circle) plus a support selection; row 130 already uses the same weak-* closure, so the novelty
  of TQ-EQ over row 130 is modest: the slack side and the periodic/pixelated forms.
- The trichromatic-point method of Voronov and Sokolov–Voronov **cannot see partial colourings at all**: the pixel lemma removes every point of chromaticity
  `≥ 3` (even `≥ 2`) at arbitrarily small cost. Any proof of `lim µ₆ < 1` must use the colouring on a set of positive measure.

### 3.3 Proposed edits (for the close; I edit none of these files)

- `BIBLIOGRAPHY.md` l. 171 `[Parts2020c]`: "not held" → held at `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`; read by this job:
  abstract, §1 (definitions, constraints, pigeonhole), §2.1–2.3 in full; §2.4 onward and the figures not read.
- `BIBLIOGRAPHY.md` `[SokolovVoronov2025]`: §9's "S(ε) = Ω(ε2 )" (unproved there) is the printed form of TQ-EPS2's order; add to the entry.
- Prior-art debt: the weak-* compactness of distance-avoiding families with the circle's Fourier decay is standard in the `m₁(ℝ²)` literature (attainment of the
  supremum density; `[BachocEtAl2014]`'s operator framework); a search for "fractional/partial colouring with vanishing holes ⟺ measurable colouring" was not
  run (budget).

### 3.4 Inventory items (for the report)

- result — QB-EQ / QB-SUP: TQ-EQ and TQ-SUP TRUE, one blind mind — §2.4, §2.6
- result — QB-EPS: TQ-EPS2 TRUE only conditional on V-1.3; constant `ε²/(6 + ε)²` — §2.8
- result — QB-P: pixel lemma; trichromatic-point methods cannot prove C-Q-STAB — §2.10
- result — QB-V11: "`µ₆(ε) < 1` ∀ε" ⟺ V-1.1 — §2.7
- correction owed — `BIBLIOGRAPHY.md` `[Parts2020c]` is held — §1.1
- correction owed — the instance sheet's "`µ₆⁰` … in `claims.md`": it is not there — §1.1
- prior-art debt — the compactness/Rajchman step in the `m₁` literature — §3.3

### "Would have searched here" log

- Would have run a SAT/MILP search for a pixelated band-proper 6-colouring of `U₃` with small holes, to probe C-Q-STAB's `δ` — instead derived the pixel lemma P,
  which says such a search's trichromatic-free outputs exist whenever any output exists.
- Would have run a Delsarte/Cohn–Elkies-type LP to bound `µ₆(ε)` numerically — instead the fill lemma F gives `ε²/(6 + ε)²` by hand (given V-1.3).
- Would have reconstructed Parts's tiling numerically to test the endpoint `δ = δ₆` of C-Q-LOCAL — not a search, but outside the budget; left as the named GAP.
