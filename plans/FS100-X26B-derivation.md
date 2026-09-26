# FS-100 stage 5, wave 3 — X26B: a blind second derivation of CLS, SPC's archimedean step, and row 100's exception

*Job X26B (Coxeter, Opus 5.5), 2026-09-26, from 11:44 UTC; brief `data/crunch-2026-09-26-x2x3/briefs/X26B-cls-every-field-blind-derivation.md`
with `STANDING-RULES.md`. Stop 12:50 UTC. Working files `data/fs100/x26b/`, checks `tools/x26b_*.py`.*

## Theorems this phase proved

*(filled at stage 3)*

## Fences (the blind)

Not opened, at any point: `plans/FS100-X23D-derivation.md`, `plans/FS100-X23V-verification.md`, `data/fs100/x23d/`, `data/fs100/x23v/`,
`tools/x23d_*.py`, `tools/x23v_*.py`, reports `X23*.md`, `X29C.md`, briefs `X23*.md`, `plans/POROS-2026-09-26-x2x3-crunch.md`,
`plans/FS100-X25B-derivation.md`, `data/fs100/x25b/`, and the bodies of commits "X23D…", "X23V…", "X25B…", "X23 advisor…". **Touches: none.**
(The directory listing of `briefs/` shows the file names `X23D-…md`, `X23V-…md`, `X25B-…md`; names only, no content opened. `git status` at
launch listed the untracked paths `data/fs100/x22d/`, `data/fs100/x22v/`, `tools/x22d_checks.py`, `tools/x22v_c0.py` — X22's, not fenced, not opened.)
What I read: `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md` (loaded), the brief, `STANDING-RULES.md`, the queue plan's §2 and §7
(`plans/CRUNCH-2026-09-26-x2x3-queue.md` lines 1–110, 246–345), `LEDGER.md` rows 52, 57, 66, 67, 75, 94, 99, 100, 105, 112, 113, 117,
`plans/R88-derivation.md` lines 1–100 (notation, T-A, R88-TC's scope paragraph), and the outline of `plans/FS84-SI-D-derivation.md`.

## Stage 1 — SAVED (quotation check; C0 sealed before any derivation)

### 1.1 Quotation check (standing rule 5), against `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, list X23 (lines 316–323)

| brief's quotation | source | result |
|---|---|---|
| CLS: "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff `L(F) ≥ 5`." | line 320–321 | **verbatim** |
| CLS named risks: "`q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n` places." | line 321–322 | **verbatim** |
| The gloss "every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`" | SPC, line 316–317 | **verbatim** (the parenthesis inside SPC) |
| SPC: "For every real number field `F` outside row 100's exception: if T-C(A) holds at `S = ∅` (…), then J45's A⁺ and SP-Cor hold with J45's proofs" | line 316–317 | **verbatim but truncated**: the source continues ", and, given MR, `χ(F²) ≥ 5`." The brief restricts me to the archimedean step, so the truncation narrows the task and widens nothing. Logged, not a defect. |
| "the step where `F` has `n > 2` real places **and** where `F` has a complex place" | brief only | the source's named risk is "A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places" (line 318); "a complex place" is the brief's addition — a widening of the task, harmless. Note: "`n = [F:ℚ] > 2` real places" in the source conflates degree and real places; a field with a complex place has `n_real < [F:ℚ]`. |
| Exception: "row 100's exception (a ramified stable dyadic place)" | `LEDGER.md` row 100: "Lemma C′: `R_F = O′` … with **no Galois hypothesis**, except possibly at a ramified stable dyadic place" | agrees in substance; the ledger says "possibly" — the exception is a gap in the proof of `R = O′`, not a proved failure. |

### 1.2 Notation used below (from the sources, fixed once)

`F ⊆ ℝ` a number field, `L = F(i)`, `c` the non-trivial automorphism of `L/F` (complex conjugation on every embedding fixing `F`), `U` the
norm-one elements of `L/F`, `R = ℤ[U]`. A place `w` of `L` is **stable** if `c(w) = w`. For a stable finite `w` over `v` of `F`: `O_w`,
`π` a uniformiser of `F_v`, `𝔽_q` the residue field of `F_v`, `U_w = {x ∈ O_w : x x^c = 1}`; the **local plane** is `Cay(O_w, U_w)` and its
**level k** is `Cay(O_w/𝔭_w^k, image of U_w)`; its **all-levels (four-colour) ratio** `ρ(w)` is `sup_k α(level k)/|level k|` (non-decreasing
in `k` by pullback, so a limit), the measurable independence density of the compact local plane. At a stable archimedean `w` (over a real place
of `F`) the local plane is `UD(ℝ²)` and `ρ(w) = m₁(ℝ²)`. `L(F)` = least chromatic number of a level-one residue target at a stable finite
place (Notation, `CLAUDE.md`).

### 1.3 C0 — probabilities per claim, sealed before any derivation

*Honest timing: sealed at 06:50, after reading the inputs above and before writing any derivation. While reading I had noticed one fact
(every unit vector is `≡ 1` at a ramified dyadic place), which moved the exception's number.*

| claim | TRUE | FALSE | GAP | where I expect a failure, if any |
|---|---|---|---|---|
| CLS(F), per-place reading | 0.70 | 0.08 | 0.22 | `q = 27` (no FS-66 certificate there; must be Hoffman or nothing); the dyadic inert tower over a ramified base (level structure); ramified odd towers at 11, 19 (FS-66's certificates are for `UD(ℤ/p^k,2)`) |
| SPC, archimedean step at `n > 2` real places | 0.45 | 0.10 | 0.45 | a product `(ℝ²)^n` with connection set `(S¹)^n`: its measurable independence ratio is not obviously `m₁(ℝ²)` |
| SPC, archimedean step with a complex place of `F` | 0.65 | 0.05 | 0.30 | a complex place of `F` splits in `L`, so it is not stable; the risk is only in how J45's proof uses `A(R_F)` |
| Exception excluded by the ratio condition (never inside the class) | 0.92 | 0.03 | 0.05 | the ratio at a ramified dyadic place read on the closure of `R` rather than `O_w` |

### 1.4 Would-have-searched-here log (running)

- (none yet)

## Stage 2 — SAVED (CLS: **TRUE**, per-place reading; the exception excluded)

### 2.1 What CLS reduces to

A place `w` of `L` is stable iff `c(w) = w`. Over a place `v` of `F`: (i) `v` real → one complex `w`, stable, local plane `UD(ℝ²)`;
(ii) `v` complex → `L ⊗_F F_v = ℂ × ℂ`, the two places swapped by `c` (`τ₂ = τ₁ ∘ c`): **split, not stable**; (iii) `v` odd, residue
field `𝔽_q`: `F_v(i)/F_v` is unramified (`i` is a unit, `−1` a unit), so `w` is stable iff inert iff `−1` is a non-square in `𝔽_q` iff
`q ≡ 3 (mod 4)` — whatever the ramification `e(v|p)`; (iv) `v` dyadic: split, inert (target `U_Q`, `Q = N(v)`), or ramified.
So **every finite stable place has one of three level-one targets**: `Γ_q` (`q ≡ 3 mod 4`), `U_Q` (dyadic inert), or, at a ramified
dyadic `w`, `Cay(𝔽_Q, {1})` (every unit vector `≡ 1 mod 𝔭_w`: `c` is trivial on the residue field, so `ū ≡ u`, `u² ≡ 1`, `u ≡ 1` in
characteristic 2). `L(F)` is the least `χ` of these targets (Notation). CLS is then the conjunction, over every target type `T` that occurs,
of **`χ(T) ≥ 5 ⟺ ρ(tower over T) < 1/4`**, plus `ρ = m₁(ℝ²) < 1/4` at every real place (`[AmbrusEtAl2023]`, re-checked `0.246989`; external +
cert), which never decides anything.

### 2.2 The level structure of every stable tower (the step the named risks sit on)

**Lemma X26B-L1 (new characters are small at every stable finite place, any ramification) [hand; exact control].** Let `w | v` be a stable
finite place, `w` unramified over `v` (odd, or dyadic inert), `π` a uniformiser of `F_v`, residue field `𝔽_q`. Every additive character `χ`
of `O_w` of exact level `k ≥ 2` (trivial on `π^k O_w`, not on `π^{k−1}O_w`) has `|∫_{U_w} χ(u) du| ≤ 2/(q+1)` (`v` odd) and `≤ 1/(q+1)`
(`v` dyadic). The ramification index `e(v | p)` does not enter.
*Proof.* The norm-one torus of the étale `O_w/O_v` is smooth, so `U_w → U(O_v/π^k)` is onto (Hensel) and Haar on `U_w` pushes to uniform
measure on every level. For `k ≥ 2`, `N(1 + π^{k−1}t) = 1 + π^{k−1}Tr(t) + π^{2k−2}N(t) ≡ 1 + π^{k−1}Tr(t) (mod π^k)` (`π` is `c`-fixed),
so the fibre of `U(O/π^k) → U(O/π^{k−1})` through `u₀` is `{u₀(1 + π^{k−1}t) : t̄ ∈ ker Tr_{𝔽_{q²}/𝔽_q}}`, a coset of an `𝔽_q`-line
(`𝔽_q·i` for `q` odd, `𝔽_q` itself for `q` even). On it `χ` is `χ(u₀)·ψ_a(ū₀ t̄)`, `ψ_a(y) = χ(π^{k−1}y)` a non-trivial additive character
of `𝔽_{q²}`, `ψ_a = ψ₀(Tr_{𝔽_{q²}/𝔽_p}(a ·))`, `a ≠ 0`. Its sum over the line vanishes unless `Tr_{𝔽_{q²}/𝔽_q}(a ū₀ ℓ) = 0` for the line's
generator `ℓ`, i.e. `ū₀ ∈ (aℓ)^{−1}𝔽_q^*` — a line through 0, which meets `μ_{q+1}` in at most `|𝔽_q^* ∩ μ_{q+1}|` points: 2 for `q` odd
(`±1`), 1 for `q` even (`gcd(q − 1, q + 1) = 1`). So at most `2/(q + 1)` (resp. `1/(q + 1)`) of `U_w` carries a non-zero fibre sum, each of
modulus `≤` its mass. ∎
*Control* (`tools/x26b_spectra.py`, exact counts): level two of a ramified (`e = 2`) tower, residue `𝔽₃`, `𝔽₇` and dyadic `𝔽₂`
(the last is `K`'s place, row 67's `P_m`): degrees `12, 56, 6 = (q + 1)q`; `max |λ_new|/d = 0.5, 0.25, 0.3333` — **the bound, attained**.

**Corollary X26B-L2 (the all-levels bounds hold at ramified bases) [hand].** (a) The all-levels Hoffman ratio of a stable finite tower is
`−λ̃/(1 − λ̃)` with `λ̃ = min(λ̃_min(T), −c₀/(q+1))`, `T` its level-one target, `c₀ = 2` (odd) or `1` (dyadic). (b) FS-66's fibre-share
inequality `⟨φ, A₁φ⟩ ≤ 2Σφ(1 − φ)` holds at every level of **every** stable tower over `Γ_q` — ramified or not — since its only inputs are
L1's bound and the uniform fibres of `S_k → S_1` (re-derived: old characters have `λ_k = q^{k−1}λ₁`, Parseval puts `Σφ(1−φ)/q²` on the new
ones); so `ρ ≤ B₁(q)/q²`. This is row 75's Lemma T / "Lemma P at new levels" re-derived blind, and it closes the named risk "ramified stable
places" and the X23V-named case "dyadic inert over a ramified base" (nothing in L1 sees `e`).

### 2.3 The table (`tools/x26b_spectra.py` → `data/fs100/x26b/spectra.out`; exact integer counts, cosines at 50 digits; seven controls, plant fires 5 of 7)

| level-one target | `d` | `λ_min` | `λ_min/d` | Hoffman `h` | `χ` | all-levels `ρ` | verdict |
|---|---|---|---|---|---|---|---|
| `Γ₃` | 4 | −2 | −1/2 | 1/3 | 3 | `≥ 1/3` | `L ≤ 3`, class fails ✓ |
| `Γ₇` | 8 | −4.4940 | −0.56174 | 0.35969 | 4 | `≥ 2/7` | `L ≤ 4`, class fails ✓ |
| `Γ₁₁` | 12 | −4.7958 | −0.39965 | 0.28553 | 5 | `≤ 28.204320/121 = 0.23309` (FS-66 cert, **re-run CERTIFIED here**) | `< 1/4` ✓ |
| `Γ₁₉` | 20 | −7.6097 | −0.38049 | 0.27562 | 5 | `≤ 77.511742/361 = 0.21471` (FS-66 cert) | `< 1/4` ✓ |
| `Γ₂₃` | 24 | −7.9607 | −0.33170 | 0.249077 | ≥ 6 | `≤ h` | `< 1/4` (margin `9.2·10⁻⁴`) ✓ |
| **`Γ₂₇`** | 28 | **−8 exactly** | −2/7 | **2/9** | ≥ 6 | `≤ 2/9` | `< 1/4` ✓ — **the named risk `q = 27` closes by Hoffman; no certificate needed** |
| `Γ₃₁` | 32 | −10.66651 | −0.3333285 | 0.2499973 | ≥ 5 | `≤ h` | `< 1/4` (margin `2.745·10⁻⁶`) ✓ |
| `Γ_q`, `q ≥ 43` | `q+1` | `≥ −2√q` (Weil; checked at 43, 47) | `> −1/3` iff `q ≥ 34` | `< 1/4` | ≥ 6 | `≤ h` | ✓ |
| `U_2, U_4, U_8, U_16, U_32` | `Q+1` | −1, −3, −3, −7, −11 | ≤ −1/3 | ≥ 1/4 | **4** (linear colourings below) | `≥ 1/4` | `L ≤ 4`, class fails ✓ |
| **`U_64`** | 65 | −15 | −0.23077 | 3/16 | ≥ 6 (floor) | `≤ 3/16` | ✓ — **the named risk "`U_Q`, `Q ≥ 64`" closes** |
| `U_128` | 129 | −19 | −0.14729 | 0.12838 | | `≤ h` | ✓; `Q ≥ 128` by Weil (`2√Q/(Q+1) < 1/3` from `Q ≥ 34`) |
| ramified dyadic `Cay(𝔽_Q,{1})` | 1 | −1 | −1 | 1/2 | 2 | `≥ 1/2` | `L = 2`, class fails ✓ |

New-level characters (L1) sit at `≥ −2/(q+1)` or `≥ −1/(Q+1)`, above every level-one minimum in the table, so no level lowers `λ̃`.
**`U_Q` at `Q ≤ 32` is four-colourable by formula** (`tools/x26b_uq_colour.py` → `data/fs100/x26b/uq-colour.out`, a complete enumeration of
the codimension-2 `𝔽₂`-subspaces avoiding `μ_{Q+1}`, at the ban's edge and logged): 1, 10, 36, 68 subspaces at `Q = 2, 4, 8, 16`; 11
`𝔽₄`-hyperplanes at 32 (G54's eleven, the control; the plant — an extra connection element — moves it to 6). **Finding:** at `Q = 4, 16`
(`f` even) **no `𝔽₄`-hyperplane** avoids `μ_{Q+1}`; the four-colourings there are `𝔽₂`-linear but not `𝔽₄`-linear. G56's "4-colourable at
`Q = 2, … , 32` (CaDiCaL)" is thereby re-derived by formula, not by solver.

### 2.4 Verdict

**CLS: TRUE** for every real number field `F`, in the per-place reading, **including row 100's exception** (both sides are false there).
- (⟹) If `L(F) ≤ 4`, a stable place's level-one target `T` has `χ(T) ≤ 4`, so a colour class has density `≥ 1/4`; its pullback is independent at
  every level (reduction is a homomorphism of Cayley graphs), so `ρ ≥ 1/4`. [hand; one line]
- (⟸) If `L(F) ≥ 5`, every finite stable target is `Γ_q` with `q ∈ {11, 19, 23, 27, 31} ∪ {q ≥ 43}` or `U_Q` with `Q ≥ 64` (the table's `χ`
  column: `Γ₃, Γ₇, U_{≤32}` and the ramified dyadic have `χ ≤ 4`), and each has `ρ < 1/4` by §2.3 with L1–L2. The real places have `m₁ < 1/4`.
  [hand + tools exact + cert (FS-66 at 11, 19) + external (m₁)]
**The four named risks:** `q = 27` — Hoffman `2/9`, exact; `U_Q`, `Q ≥ 64` — `3/16` at 64, Weil above, any base; ramified stable places —
L1 (the ramification never enters); the archimedean part at `n` places — per place it is `m₁`, `n` never enters CLS (it enters SPC: §3).
**The exception (row 100: a ramified stable dyadic place): never inside the class**, and never inside `L ≥ 5`: at such a place every unit vector
is `≡ 1 mod 𝔭_w`, so `{x : ℓ(x̄) = 0}` (`ℓ : 𝔽_Q → 𝔽₂` linear, `ℓ(1) = 1`) is independent of density `1/2` in **any** closed subgroup of `O_w`
containing 1 — so the ratio is `≥ 1/2` whether or not `R = O′` there (the only thing the exception leaves unproved), and `L(F) = 2`.
So "outside row 100's exception" can be dropped from CLS, and from COR too (`min(L, 5) = 2 ≤ χ` holds trivially there).

**Independence note.** Where my route may differ from X23D/X23V's: L1 is a fibre computation on the smooth norm torus, uniform in `e` and in
the residue characteristic; it makes the dyadic-over-ramified case the same line as every other. I have not seen either record.

### 2.5 Would-have-searched-here log (stage 2)

- Would have asked a SAT solver whether `U₄`, `U₁₆` are four-colourable once the `𝔽₄`-hyperplane count came back 0; instead enumerated the
  codimension-2 `𝔽₂`-subspaces (a complete enumeration of a set fixed by the linear-colouring derivation; at the edge, logged).
- Would have searched for a `B₁` certificate at 27; instead computed the exact spectrum (Hoffman suffices, `2/9`).
