# FS-91 crunch job J09v — a blind second reading of J09's "no mixing" theorem (J4) and its corollaries (J4-C, J4-A)

*de Bruijn (Opus 5.5), 2026-09-25, acting as a blind verifier under the brief
`data/crunch-2026-09-25/briefs/J09v-M1-no-mixing-blind.md` (with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`). Blind: J09's record
beyond its quoted lines 364–367, J02's record, the M1 plan, the FS-91 derivation and close files, and every other crunch record were not
opened before the stage-3 verdicts were committed. Data `data/fs91/j09v/`; tools `tools/crunch_j09v_*.py`.*

## Stage 1 — SAVED

### 1.1 Quotation check

| quotation in the brief | source | result |
|---|---|---|
| J4, J4-C, J4-A (brief lines 24–27) | `plans/FS91-S0FV-three-colours-blind.md` lines 364–367, read by `sed -n '364,367p'` and nothing else of that file | **verbatim**, character for character, grade tags included |
| CLG, Lemma C/C′ "in the same file" (brief lines 37–40) | `data/fs91/j07/lemma-statements.md` items 7, 8, 13 | the brief's Lemma C/C′ line is a **paraphrase**, not a quotation; faithful to items 7–8 (the exception "possibly at a ramified stable dyadic place" is item 8's). I use items 7–8 verbatim, never the paraphrase |
| J01-7 (brief line 41) | not in any file I may open (the brief gives no address); the lemma file's `H_k` line states the same inclusion ("`Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every `F ⊆ ℝ`, some finite `N_k` (input: J03a-8 / J01; not J07's)") | consistent with `H_k`; **unchecked as a quotation**. I use `H_3` in the lemma file's words |
| S1 (brief line 13: "for every real number field, `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`") | M1's plan, fenced | **unchecked** (source fenced). I read J4-C's and J4-A's "S1" as that sentence and say so at each verdict |
| FS-89's notation (`Θ_k`, `A`, `T_N`, band) | `plans/FS89-derivation.md` "Notation, fixed once" | consistent with the brief |
| `[Fischer1990]`'s "additive" | the held PDF (`library/papers/1-s2.0-0012365X9090324B-main.pdf`), abstract and §1 | "a map `v: C₀(F^d) → G` to an additive group `G` of order `k` so that `v(ξ) ≠ 0` whenever `‖ξ‖ = 1`, is said to be an additive k-coloring of `F^d`"; `C₀` is the additive group the unit vectors generate, which is `R_F` in the plane (U is a multiplicative group, so `ℤ[U]` is the additive span of `U`) |

### 1.2 Readings fixed before any derivation

- **"additive character"** (the brief offers two readings): (Fi) Fischer's — a homomorphism `R_F → (1/3)ℤ/ℤ` non-zero on every unit
  vector; (Re) a character factoring through a residue map `R_F → O_𝔓/𝔓` at a stable place and then an additive map to `𝔽₃`. I verify
  under both and say whether they coincide.
- **"ramified stable dyadic prime"**: a conjugation-stable prime of `L = F(i)` above 2 that is **ramified in `L/F`** (the only reading
  under which it is Lemma C′'s exception). The other reading, "ramified over ℚ", excludes more fields (ℚ(√3), ℚ(√11)); I note the
  verdict under it too.
- **"prime above 3 of residue field `𝔽₃`"**: a prime `𝔭` of `F` (a prime of `L` cannot have residue field `𝔽₃`, since `i ∈ L`).
- **`N₃`**: the number of such `𝔭`, as the claim's "one quadruple per prime" fixes it.

### 1.3 C0 — probabilities before derivation

*Written after reading the inputs and a mental sketch, before any written derivation or computation.*

| claim | P(TRUE as stated, under the readings above) | the step I expect to decide it |
|---|---|---|
| J4 | 0.85 | whether every band-3 character at a stable place is one of an `𝔽₃`-place's four (level reduction at 3, the inert dyadic places, the usable `q ≥ 7`), and whether a parity summand `{1/2}` at a second place can hide inside a "mixed" character |
| J4-C | 0.85 | the passage from `χ ≤ 3` to `Θ₃ ≠ ∅` (FS81-T2, resting on FS73-T22 ⟹, hand), and the bipartite case |
| J4-A | 0.60 | what `L(F)` and "a prime above 3 of residue field `𝔽₃`" mean for an infinite algebraic field or a transcendental extension (definitional scope), König's lemma over a tower of finite sets, and the bipartite case |

### 1.4 "Would have searched here" log

| # | move by search I would have made | what I did instead |
|---|---|---|
| — | none at stage 1 | — |

## Stage 2 — SAVED — J4, derived blind

### 2.0 The claim, verbatim (`plans/FS91-S0FV-three-colours-blind.md` lines 364–365)

> "**J4** — no mixing: for a real number field with no ramified stable dyadic prime, `Θ₃(R_F)` is exactly the `4N₃` additive characters,
> one quadruple per prime above 3 of residue field `𝔽₃`. [hand, one mind; Weil external] — §2.5."

### 2.1 Verdict

**TRUE**, under the readings of §1.2, and under both readings of "additive" (they name the same set, J4.9). Under the other reading of
"ramified" (over ℚ rather than in `F(i)/F`) the hypothesis is stronger and the statement stays true. The hypothesis is exactly "`F²` is
not bipartite" (J4.0), and it is necessary: without it `Θ₃` contains the parity character `θ₂`, and with it the whole family
`θ₂ + λ_e`, `|e| ≤ 1/6` — never finitely many (ℚ, ℚ(√5), ℚ(√2)). Grade of my derivation: **[hand, second mind (blind); Weil external for
`q ≥ 29`; tools exact at `q ≤ 27`]**. Inputs used: `H₃` (J01-7), Lemma C and C′ (items 7–8), (W) (item 9), U3 (item 3); CLG-b, CLG-b_n,
CLG-d, CLG-e (items 5, 6, 11, 17) and Lemma AV (item 12) are **re-derived** below at `k = 3` rather than taken as statements.

### 2.2 The derivation

*Setting.* `F` a real number field, `L = F(i)`, `c` complex conjugation, `U = {u ∈ L : u c(u) = 1}`, `R = ℤ[U]` (the additive span of
`U`, since `U` is a multiplicative group), `B = B₃ = [1/3, 2/3] ⊂ ℝ/ℤ`. **(H)**: no conjugation-stable prime of `L` above 2 is ramified in
`L/F`.

- **J4.0 (the stable places; (H) is non-bipartiteness).** `L/F` has relative discriminant dividing `−4`, so it is unramified at odd primes;
  a stable prime is not split, so a stable `𝔓` above odd `p` is inert over `𝔭 = 𝔓 ∩ F`, which happens iff `x² + 1` is irreducible over
  `O_F/𝔭 = 𝔽_q`, iff `q ≡ 3 (mod 4)`. So the primes of `F` above 3 with residue field `𝔽₃` are exactly the stable `𝔓 | 3` with `q = 3`
  (residue field `𝔽₉` in `L`), and `N₃` counts them. Under (H) a stable dyadic `𝔓` is unramified and not split, hence inert, residue
  field `𝔽_{Q²}`, `Q = N𝔭`. (H) ⟺ `F²` not bipartite: if (H) fails at `𝔓`, then `c` generates the inertia group, acts trivially on the
  residue field `k_𝔓`, so every `u ∈ U` reduces to `x` with `x² = 1` in characteristic 2, i.e. to 1, and any `𝔽₂`-functional of `k_𝔓` with
  `1 ↦ 1` is a two-colouring; if (H) holds, a two-colouring is an additive `ψ : R → 𝔽₂` with `ψ(U) = 1` (`[Fischer1990]` Thm 1(ii)), which
  is a ring homomorphism (`ψ(Σaᵢuᵢ·Σbⱼvⱼ) = Σaᵢbⱼ`), killing 2, so factoring through `R/2R ≅ ∏_{stable 𝔓|2} O_𝔓/2O_𝔓` (C′), a finite
  product of local rings, hence through one residue field `𝔽_{Q²}` — which has no ring map to `𝔽₂`; with no stable dyadic place `R/2R = 0`.
- **J4.1 (torsion plus archimedean).** By `H₃`, `θ = τ + (ℓ mod 1)`, `τ` killed by some `N`, `ℓ ∈ Hom_ℚ(L, ℝ) = Hom_ℝ(L ⊗ ℝ, ℝ)`.
- **J4.2 (localise `τ`).** Under (H), C′ gives `R/NR ≅ ∏_{stable 𝔓|N} A_𝔓`, `A_𝔓 = O_𝔓/NO_𝔓`, so `τ = Σ_𝔓 τ_𝔓 ∘ ρ_𝔓`. Each `ρ_𝔓` is onto
  and `U` spans `R`, so `S_𝔓 := ρ_𝔓(U)` spans `A_𝔓` additively.
- **J4.3 (joint image; dense fibres).** (W) with `Σ` = the stable `𝔭 | N` and every archimedean place: `U` is dense in
  `∏_𝔭 T(F_𝔭) × ∏_{w|∞} T(F_w)`. The finite factor maps continuously onto a discrete set, so the image of `U` in `∏ A_𝔓` is `∏ S_𝔓`
  (the local images), and each fibre of `U → ∏ A_𝔓` is dense in `∏_{w|∞} T(F_w)`.
- **J4.4 (the archimedean part; CLG-d at `k = 3`).** On a fibre over `s`, `θ = τ(s) + ℓ`. At a complex place `w` of `F`, `T(F_w) = {(z, 1/z)}`
  spans `L ⊗_F F_w ≅ ℂ²` over ℝ and `ℓ_w(z, 1/z) = Re(αz + β/z)` is odd and unbounded unless `ℓ_w = 0`; an unbounded `ℓ_w` makes `θ` dense
  in ℝ/ℤ on the fibre, against the band. So `ℓ_w = 0`. At a real place, `T(F_w) = S¹ ⊂ ℂ` and `ℓ_w(z) = Re(ē_w z)` takes exactly
  `[−|e_w|, |e_w|]`; the sum over real places takes `[−r, r]`, `r = Σ|e_w|`. Density and the closed band give **`τ(s) + [−r, r] ⊆ B` for
  every `s`**, so `τ ∈ Θ₃`.
- **J4.5 (Minkowski; CLG-b and CLG-b_n at `k = 3`).** `τ(U) = Σ_𝔓 Y_𝔓`, `Y_𝔓 = τ_𝔓(S_𝔓)`, non-empty and symmetric (`−1 ∈ U`). For symmetric
  `X, Y` with `X + Y ⊆ B`, let `m_X, m_Y` be their least norms; `±m_X ± m_Y` all lie in `X + Y`, so `|m_X − m_Y| ≥ 1/3`, so one of them is
  `≥ 1/3`: `X ⊆ B` or `Y ⊆ B`. By induction on the number of places, **some `Y_{𝔓₀} ⊆ B`**: `τ_{𝔓₀}` is a band-3 character of `T_{𝔓₀,m}`.
  (With no stable place above `N`, `τ(U) = {0} ⊄ B`, so `Θ₃ = ∅`.)
- **J4.6 (level reduction; CLG-e at `k = 3`, every stable place under (H), every `e(𝔭|p)`).** Let `𝔓` be stable and unramified in `L/F`,
  `π ∈ F` a uniformiser of `F_𝔭` (so `𝔓 = πO_𝔓`), `m ≥ 2`, and `λ` a band-3 character of `A = O_𝔓/𝔓^m` on `S_m`. For `w ∈ O_𝔓`,
  `z = 1 + π^{m−1}w` is a unit and `z/c(z) ≡ 1 + π^{m−1}(w − c(w)) (mod 𝔓^m)` (as `2(m−1) ≥ m`); so for `x ∈ S_m`, `S_m ⊇ x + D_x`,
  `D_x = x̄ π^{m−1} V̄₀` with `V̄₀ = {w̄ − w̄^q} = ker Tr_{𝔽_{q²}/𝔽_q}`, an `𝔽_q`-line. `λ(D_x)` is a subgroup of exponent `p`, so of order 1 or
  `p ≥ 2`, and a coset of a subgroup of order `p ≥ 2` has a point of norm `≤ 1/(2p) ≤ 1/4 < 1/3`: so `λ(D_x) = 0`. The lines `x̄V̄₀`,
  `x̄ ∈ μ_{q+1}`, coincide only for `x̄ ∈ 𝔽_q^× ∩ μ_{q+1} ⊆ {±1}`, and `q + 1 ≥ 3`, so at least two distinct lines span `𝔽_{q²} ≅ 𝔓^{m−1}/𝔓^m`:
  `λ` kills `𝔓^{m−1}/𝔓^m` and descends to level `m − 1`. **Every band-3 character of `T_{𝔓,m}` factors through level one.** (The ramified
  dyadic place is exactly where this fails: no uniformiser of `L_𝔓` lies in `F`.)
- **J4.7 (level one).** `S_1 = μ_{q+1} ⊂ 𝔽_{q²}` (Hilbert 90 on the residue field, `c` inducing the `q`-Frobenius). (i) **Inert dyadic**:
  characters take values in `{0, 1/2}`; band 3 needs `1/2` on all of `μ_{Q+1}`, but `Σ_{s∈μ_{Q+1}} s = 0` with `Q + 1` odd terms gives
  `0 = 1/2`. None. (ii) **Odd `q ≥ 7`**: a band-3 character gives an independent set `{x : λ(x) ∈ [t, t + 1/3)}` of size `≥ q²/3` for some `t`
  (averaging; Lemma AV), while Hoffman with Weil's `|λ_min| ≤ 2√q` gives `α ≤ 2q²√q/(√q + 1)² < q²/3` once `q − 4√q + 1 > 0`, i.e. `q ≥ 19`;
  `q = 7, 11` (and 19, 23, 27, as a second route) by the exact enumeration of §2.3 B. None. (iii) **`q = 3`**: `λ` on `𝔽₉ = 𝔽₃ ⊕ 𝔽₃ i` is in
  the band iff `λ(1), λ(i) ∈ {1/3, 2/3}`: **exactly four**, each with value set `{1/3, 2/3}` on `μ₄`.
- **J4.8 (no mixing).** `Y_{𝔓₀} = {1/3, 2/3}` by J4.6–J4.7. Put `X = Σ_{𝔓≠𝔓₀} Y_𝔓`; for `x ∈ X`, `x + 1/3 ∈ B` and `x + 2/3 ∈ B` force
  `x ∈ [0, 1/3] ∩ [2/3, 1] = {0}`. So `X = {0}`, every other `Y_𝔓` is a symmetric singleton `{0}` or `{1/2}`, and `{1/2}` would be a band-3
  character of `T_{𝔓,m}` with value `1/2`, which J4.6–J4.7 exclude. So `τ_𝔓(S_𝔓) = 0`, and `S_𝔓` spans `A_𝔓`: `τ_𝔓 = 0`. Then
  `τ(U) = {1/3, 2/3}` and J4.4 forces `r = 0`, so `ℓ = 0` and **`θ = λ ∘ ρ̄_{𝔓₀}`**, `λ` one of the four.
- **J4.9 (the converse, the count, and "additive").** Each `λ ∘ ρ̄_𝔓` lies in `Θ₃` (CLG-a). They are pairwise distinct: `R → ∏_{stable 𝔓|3}
  O_𝔓/3O_𝔓` is onto (C′ at an odd prime), and distinct characters of the product pull back to distinct characters. So `|Θ₃(R_F)| = 4N₃`.
  Reading (Re) is this set by construction. Reading (Fi), Fischer's additive 3-colourings `R → ℤ/3` non-zero on `U`, is `Θ₃ ∩ T₃` (values
  `1/3, 2/3` lie in the band), which is the same set. **The two readings coincide.**

**What it adds to FS81-T6** (read from its statement): T6 classifies `Θ₃(ℚ(√d))` at `d ≡ 3, 7 (mod 12)` as the additive characters and
leaves open "whether every additive 3-colouring is Fischer's up to symmetry"; J4 gives every real number field under (H), and the count:
**four per `𝔽₃`-place**, which answers T6's open line for every real quadratic `d ≡ 3 (mod 4)`: `N₃ = 1` at `d ≡ 3 (mod 12)` (3 ramified;
Fischer's colourings, 4 of them), `N₃ = 2` at `d ≡ 7 (mod 12)` (3 split; two places, 8 characters), `N₃ = 0` at `d ≡ 11 (mod 12)`.

### 2.3 Exact checks (`tools/crunch_j09v_check.py`, 2.2 s; output `data/fs91/j09v/check.txt`: ALL CHECKS PASS)

| part | what it checks (a claim the derivation fixed first) | result |
|---|---|---|
| A (gp) | `N₃` and the dyadic behaviour in `L/F` at the named fields | ℚ(√3) `N₃ = 1` (3 ramified), dyadic inert; ℚ(√7) `N₃ = 2`, dyadic split (no stable dyadic); ℚ(√11) `N₃ = 0`, dyadic inert; ℚ(√2,√3) `N₃ = 0`, dyadic inert (`e_F = 4`); ℚ(√3,√7) `N₃ = 2` (both ramified over ℚ), dyadic split; ℚ and ℚ(√5): ramified stable dyadic (contrast) |
| B | J4.7 at level one: band-3 characters of `Cay(𝔽_{q²}, μ_{q+1})`, `U_Q` | 4 at `q = 3`; 0 at 7, 11, 19, 23, 27; 0 at `U₂, U₄, U₈` |
| C | J4.6: every band-3 character of the level-`p^k` target in explicit local rings, and whether it is level one | `ℤ₃[i]` mod 3, 9, 27: 4, all level one, order 3; `ℤ₃[√3][i]` mod 3, 9 (levels 2, 4): 4, all level one; `ℤ₂[√3][ω]` (ℚ(√3)'s and ℚ(√11)'s inert dyadic) mod 2, 4, 8: **0**; ramified contrast `ℤ₂[i]`: 1 (the parity character), `ℤ₂[ζ₃][i]`: 4 of order 2 |
| D | J4.8 no mixing: every character of `∏ O_𝔓/N` on the product circle | ℚ(√7) `N = 3, 9`: **8**; ℚ(√3,√7) `N = 3, 9`: **8**; ℚ(√3) `N = 18, 24, 36`: **4**; ℚ(√11) `N = 8`: **0** — each `= 4N₃`. Contrast ℚ: 5 = 4 + `θ₂` |
| plants | P1 diagonal joint image at ℚ(√7) (the independence J4.3 supplies, removed); P2 `c :=` identity (the circle collapses to `{1}`); P3 `i` dropped from `μ₄` | 36, 6, 6 against faithful 8, 4, 4: each fires, each for its own reason (36 = 4 × 9: every character of the diagonal splits nine ways) |

*Caveat on the contrast rows.* At a ramified stable dyadic place Lemma C′ does not hold, so `∏ O_𝔓/N` over-represents `R/NR`; the contrast
counts (5 at ℚ, 4 at `ℤ₂[ζ₃][i]`) are counts of local characters, not of `Θ₃(R) ∩ T_N`. The contrast they carry is qualitative and exact:
`θ₂ ∈ Θ₃` there, of order 2, not additive in either reading, and `θ₂ + λ_e ∈ Θ₃` for `|e| ≤ 1/6`.

*Scope of the checks.* ℚ(√2,√3)'s dyadic place (`e_F = 4`) has no hand-built local ring here; its row rests on part A (inert in `L/F`)
with J4.6–J4.7, which are uniform in `e`.

### 2.4 Slips and readings noted at stage 2

- The claim's "additive" is unambiguous after all (J4.9): both readings name one set.
- (H) could be stated as "`F²` not bipartite" (J4.0); the claim's form is the one Lemma C′ needs, and they are equivalent.
