# FS-100 X12B — a blind second derivation of EF_F⁺ (and EF_F)

*Job X12B of the ×2×3 crunch (2026-09-26). Coxeter, Opus 5.5. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X12B-ef-plus-blind-derivation.md` (with `STANDING-RULES.md`). Product owner: "main".
Blind: none of the fenced files was opened (fence log below).*

## Stage 1 — SAVED (11:12 UTC)

### 1.1 The quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| EF_F⁺, "For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` … (No ergodicity; one element; the conclusion `T + A ⊆ E`.)" | `plans/FS100-X01D-derivation.md` line 194 | **not checked** — the source is fenced for this job; checking it would break the blind. Taken as the brief states it. |
| EF_F, "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`." | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X01 (line 62–63) | **verbatim match** |
| Notation "`F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` … `E = ⋃_S (T + A + Fin_S)`" | queue §2, lines 53–55 | match in substance; the brief writes "`R̂` its Pontryagin dual" and "`A` the archimedean ones" where the queue has "`R̂` its dual" and "`A(R_F)`" — no change of meaning |
| Einsiedler–Fish, ETDS 30 (2010) 151–157 | queue §2 line 70 (Zbl 1189.37005) | match |

Einsiedler–Fish main theorem, verbatim (Thm 1.2, p. 1 of arXiv:0804.3586v2, read in full, all 8 pp.): "Let α > 0 and let Σ ⊂ N be a
multiplicative semigroup with lim inf_{N→∞} #(Σ ∩ [1, N])/N^α > 0. Let µ be an ergodic Σ-invariant Borel probability measure on T = R/Z.
Then either µ is supported on a finite number of points or µ is Lebesgue measure." Its zero-entropy half is Lemma 3.2: "Under the
assumptions of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support." (Lemma 3.2 uses ergodicity only in its last
line, "By ergodicity, we get that µ has a finite support"; before that it proves µ has atoms carrying ≥ 1/2.)

### 1.2 C0 (standing rule: before any derivation)

**Slip, logged:** I formed a first sketch of the route while reading the paper, before writing these numbers down, so they are a
reconstruction of my reading at the moment I finished the brief, not a sealed prior. At that moment: **P(EF_F⁺ TRUE) ≈ 0.45, P(EF_F TRUE) ≈ 0.55**
(the brief's hard point — a zero-entropy element sees only its own places — looked like it could leave a non-`E` measure at the other split
places; EF_F⁺'s strengthening to `T + A` looked like it could fail on `Fin_S` pieces).

### Fence log

No fenced file opened. `plans/CRUNCH-2026-09-26-x2x3-queue.md`: only §2 (lines 51–101) was printed, after a heading listing
(`grep -n "^## "`), which shows headings only.

### Would-have-searched-here log

(none yet)

## Stage 2 — SAVED (the derivation; 11:12 UTC)

**Verdict: EF_F⁺ TRUE [hand, one mind]; EF_F TRUE as its corollary.** The route is Einsiedler–Fish's Lemma 3.2 run at the places where
`u*` expands, followed by a second step EF does not need (on `𝕋` there are no other places): a finite `U`-invariant measure on the
non-compact adelic group of the remaining places must vanish at every finite split place. Neither step uses ergodicity.

### 2.0 The model of `R̂` (standard; Tate duality)

Let `S` be the set of **split** finite places of `L` (those `w ≠ w̄`; the non-stable ones) and `∞` the archimedean places.
By Lemma C (`R = O′`, integral exactly at the stable primes), `R = O_{L,S}`, the `S`-integers. `O_{L,S}` is a discrete cocompact
subgroup of `𝔸_S := L_∞ × ∏′_{w∈S}(L_w, O_w)` (restricted product; discrete since `O_L ∩ {|x|_∞ < 1} = 0`, cocompact by strong
approximation). With `ψ = ∏_v ψ_v` the standard character of `𝔸_L/L` and `ψ_S = ∏_{v∈S∪∞} ψ_v`, `𝔸_S` is self-dual by
`(a, b) ↦ ψ_S(ab)`, and the annihilator of `R` is `Λ′ := 𝔡⁻¹R` (for `a ∈ L`, `ψ_S(ar) = ∏_{v stable} ψ_v(ar)⁻¹` by the product
formula, trivial for all `r ∈ R` iff `a ∈ 𝔡_v⁻¹` at every stable `v`). So

  **`R̂ ≅ 𝔸_S / Λ′`**, `Λ′ = 𝔡⁻¹R` a `U`-stable lattice, with `u ∈ U` acting diagonally by multiplication.

In this model: **`T = L/Λ′`** (the torsion of `𝔸_S/Λ′` is `ℚΛ′/Λ′`); **`A` = the image of `L_∞ × {0}`** (an archimedean-continuous
character extends to `L_∞`, `R` being dense there); `Fin_S′` = the image of `L_∞ × ∏_{w∈S′} L_w × {0}`. So

  `x ∈ T + A` ⟺ some lift `x̃ ∈ 𝔸_S` has `x̃_w = ℓ` at **every** finite split `w`, for one `ℓ ∈ L`;
  `x ∈ E` ⟺ the same at all but finitely many `w`.

For a set `P` of places in `S ∪ ∞` put `Z_P` := the image of `{a ∈ 𝔸_S : a_v = 0 ∀ v ∈ P}` ≅ `𝔸_{S∖P}`. For `P ≠ ∅` the map
`𝔸_{S∖P} → R̂` is injective (`Λ′ ∩ {a_P = 0} = 0`, as `L ↪ L_v`), and `T ∩ Z_P = 0` (if `ℓ − ℓ′ − λ` vanishes at a place it is 0),
so `L + Z_P ≅ T × 𝔸_{S∖P}` by a continuous bijection from a Polish space — a Borel isomorphism onto a Borel set (Lusin–Souslin),
`U`-equivariant.

### 2.1 Lemma Z (the other places) — **[hand]**

**X12B-Z.** *Let `F` be a real number field, `P ⊂ S ∪ ∞` finite and non-empty, and `μ` a `U`-invariant finite positive Borel measure on
`R̂` carried by `L + Z_P`. Then `μ` is carried by `T + A`.*

Proof. Push `μ` along `L + Z_P ≅ T × 𝔸_{S∖P} → 𝔸_{S∖P}`: a `U`-invariant finite measure `ν`. Fix a finite split `w ∉ P`. There is
`u_w ∈ U` with `ord_w(u_w) ≠ 0`: take `α` with `(α) = w^h` (`h` the class number) and `u_w = α/ᾱ`; `ᾱ` generates `w̄^h`, `w̄ ≠ w`,
so `ord_w(u_w) = h`. The Borel map `a ↦ ord_w(a_w) ∈ ℤ ∪ {∞}` is equivariant (`ord_w(ua_w) = ord_w(u) + ord_w(a_w)`), so its push-forward
of `ν` is a finite measure on `ℤ ∪ {∞}` invariant under `k ↦ k + h`: it gives `ℤ` measure 0. So `a_w = 0` `ν`-a.e.; countably many `w`
⇒ `ν`-a.e. `a` vanishes at every finite split place, i.e. `a ∈ L_{∞∖P}`, and `μ` is carried by `T + A`. ∎

The same argument with `L + Z_P` replaced by `E_{S′} ≅ T × L_∞ × ∏_{w∈S′} L_w` gives

**X12B-E.** *For every real number field `F` and every `U`-invariant finite positive Borel measure `μ` on `R̂`: `μ(E ∖ (T + A)) = 0`.*
**[hand]** (So for invariant measures "carried by `E`" and "carried by `T + A`" are the same statement: EF_F⁺'s conclusion is not stronger
than EF_F's once invariance is given; only EF_F⁺'s hypotheses — no ergodicity, a finite measure — are wider.)

### 2.2 Lemma EF-P⁺ (the places of `u*`) — **[hand]**, EF Lemmas 3.1–3.2 transferred

Let `u* ∈ U` be non-torsion and `P⁺ = {v ∈ S ∪ ∞ : |u*|_v > 1}`. `P⁺ ≠ ∅`: `|u*|_v = 1` at every stable and every non-split
archimedean place (`u* ū* = 1`, `ū*` conjugate there), so if also `|u*|_v ≤ 1` on `S ∪ ∞` the product formula forces `|u*|_v = 1`
everywhere and `u*` is a root of unity (Kronecker). Let `Q ⊃ {v : |u*|_v ≠ 1}` be finite, `Q ⊇ ∞`.

**X12B-EF.** *If `μ` is a finite positive Borel measure on `R̂`, invariant under `u*` and under the rational unit vectors
`U_ℚ := {(a+bi)/c : a²+b² = c²} ⊂ U`, with `h_μ(u*) = 0`, then `μ` is carried by `L + Z_{P⁺}`.*

*The multipliers, and the count.* `q = (a+bi)/c ∈ U_ℚ` lies in `U_F` (conjugation of `L/F` restricts to that of `ℚ(i)`), and
`|q|_v = 1` at **every** archimedean place of `L` (each embedding sends `q, q̄` to complex conjugates). With `H_L(q) = ∏_{w finite}
max(1,|q|_w)` (`|·|_w = |N_{L_w/ℚ_p}(·)|_p`), `H_L(q) ≤ c^{[L:ℚ]}`. So, with `X = M^{1/[L:ℚ]}`,
  `#{q ∈ U_F : H_L(q) ≤ M} ≥ #{q ∈ U_ℚ : den q ≤ X} = (4/π + o(1))·X` — `4 + 8·#{primitive Pythagorean triples with hypotenuse ≤ X}`.
Checked exactly at `X = 5, …, 1500` (`tools/x12b_multiplier_count.py`: e.g. 1,268 at `X = 1000` against `4X/π = 1273.2`; plant — drop the
sign/swap orbit — fires at every checkpoint). This is the only polynomial growth used: exponent `1/[L:ℚ]`, any positive exponent suffices.

*Why the other places do not hurt.* A usable multiplier may expand any finite split place it likes. The argument never needs a
multiplier to shrink anything: it uses only `μ(qB) = μ(B)` (EF's "wrong-way" use of invariance, here an equality since `q` is an
automorphism), and it reads the resulting overlap equation, an equation in `L`, at `P⁺` for **smallness** and at every other place only
for a **height bound polynomial in `X`**; the product formula turns the two into exact equality at `P⁺`. The other places are then
handled by Lemma Z, not by the multipliers. The archimedean places cost nothing because every `q ∈ U_ℚ` is a rotation there.

*Proof.* Normalise `μ(R̂) = 1`.
1. **Bowen sets.** `K_Q` := the image of `∏_{w∉Q} O_w` (compact) is `u*`-stable, and `X_Q := R̂/K_Q ≅ (L_∞ × ∏_{w∈Q}L_w)/Λ′_Q`
   (surjectivity by strong approximation away from `∞`; `Λ′_Q` a lattice) is a finite-dimensional `S`-adic solenoid on which `u*` acts.
   Take a finite partition `ξ` of `X_Q` into sets of diameter `< r` (`r` below the injectivity radius), pulled back to `R̂`. Then the atom
   `B_n(x)` of `⋁_{i<n} u*^{-i}ξ` satisfies `B_n(x) ⊆ x + [B̃_n × ∏_{w∉Q} O_w]`, `B̃_n = {d : |d|_v ≤ r ∀ v ∈ Q, |d|_v ≤ r|u*|_v^{-(n-1)}
   ∀ v ∈ P⁺}` (lift the difference in `X_Q` step by step; a lattice vector of size `≤ (max|u*|+1)r` is 0).
2. **Zero dimension at `P⁺`** (EF Lemma 3.1). `h_μ(u*, ξ) ≤ h_μ(u*) = 0`, so by Shannon–McMillan–Breiman (no ergodicity: the limit is the
   ergodic components' entropy, a.e. 0) and Egorov: for every `β, ε > 0` there are `X′`, `μ(X′) > 1 − ε`, and `N` with
   `μ(B_n(x)) ≥ e^{−nβ}` for all `x ∈ X′`, `n ≥ N`.
3. **Overlap** (EF Lemma 3.2). Fix `x ∈ X′`, a lift `x̃ ∈ 𝔸_S`, and a scale `X` with `n = n(X) = ⌈K log X⌉`. The sets `qB_n(x)`,
   `q ∈ U_ℚ(X) := {den q ≤ X}`, have measure `≥ e^{−nβ}` each; if `#U_ℚ(X)·e^{−nβ} > 1` two meet: `q₁(x + [ỹ₁]) = q₂(x + [ỹ₂])`,
   `q₁ ≠ q₂`, `ỹ_i` in the box of step 1. Lifting, `(q₁ − q₂)x̃ = λ + q₂ỹ₂ − q₁ỹ₁`, `λ ∈ Λ′`; so `x̃ = ℓ + e` with
   `ℓ = λ/(q₁−q₂) ∈ L` and `e = (q₂ỹ₂ − q₁ỹ₁)/(q₁−q₂)`.
4. **Bounds.** `q₁ − q₂ = N/(c₁c₂)`, `0 ≠ N ∈ ℤ[i]`, `|N| ≤ 2c₁c₂`; hence `|q₁−q₂|_v ≥ X^{−2}` at archimedean `v` and
   `≥ (4X⁴)^{−[L:ℚ]}` at finite `v`, and `|q_i|_v ≤ X^{[L:ℚ]}`. So, with constants `a, b` depending only on `[L:ℚ]`:
   - at `v ∈ P⁺`: `|x̃_v − ℓ|_v ≤ r·X^{a}·|u*|_v^{−(n−1)}`;
   - away from `P⁺` (stable places via `λ ∈ 𝔡⁻¹` there; split places via `|ℓ|_v ≤ max(|x̃_v|, |e_v|)`; archimedean via
     `|e_v| ≤ 2rX²`): `H′(ℓ) := ∏_{v∉P⁺} max(1, |ℓ|_v) ≤ C(x̃)·X^{b}`, `C(x̃) = ∏_v max(1,|x̃_v|)·(const)` finite.
5. **Stabilisation** (EF's `M₁ → M₁²` step, by the product formula instead of `|k₁/ℓ₁ − k₂/ℓ₂| ≥ 1/ℓ₁ℓ₂`). Let `ℓ, ℓ′` come from scales
   `X` and `X²`. If `δ = ℓ − ℓ′ ≠ 0`: `1 = ∏_v |δ|_v ≤ (const)·H′(ℓ)H′(ℓ′)·∏_{v∈P⁺}(2rX^{2a}ρ^{−(n(X)−1)})`, `ρ = min_{P⁺}|u*|_v > 1`,
   i.e. `1 ≤ C′(x̃)·X^{3b + 2a|P⁺|}·X^{−K|P⁺| log ρ}`: false for `X` large once `K > (3b + 2a|P⁺|)/(|P⁺| log ρ)`. So `ℓ(X) = ℓ(X²) =
   ℓ(X⁴) = …`, and since the `P⁺`-error at scale `X^{2^j}` tends to 0, `x̃_v = ℓ` at every `v ∈ P⁺`: `x ∈ L + Z_{P⁺}`.
6. **Order of choices.** `K` depends only on `a, b, |P⁺|, ρ`; then `β = 1/(2K)` makes the pigeonhole feasible for large `X`
   (`#U_ℚ(X)·e^{−nβ} ≥ (4/π + o(1))X·X^{−1/2}·(const) > 1`); then step 2 gives `X′, N`; then `X` large (`n(X) ≥ N`, `C(x̃)` fixed).
7. `ε → 0`: `μ` is carried by `L + Z_{P⁺}` (a countable union of Borel sets). ∎

### 2.3 The claims

- **EF_F⁺ TRUE.** X12B-EF (with `U_ℚ ⊂ U`, `u* ∈ U`) puts `μ` on `L + Z_{P⁺}`, `P⁺ ≠ ∅`; Lemma Z puts it on `T + A`. Ergodicity is never
  used; one element suffices; finite positive measures are normalised.
- **EF_F TRUE**: an ergodic probability is a finite positive measure and `T + A ⊆ E`.

### 2.4 Audit of the result (standing rule 4: audited as hard as a disliked one)

| where a defect would sit | check |
|---|---|
| a counterexample at another split place `w′` (positive entropy for `u′` supported at `w′`, zero for `u*`) | excluded by the proof, and consistently: every `U`-invariant closed factor of `R̂` is dual to an ideal `I` of `R`, and `Î` sees every place, so there is no factor forgetting `P⁺` on which a `w′`-entropy measure could sit |
| too much proved | with `U` replaced by `⟨u*⟩` (no polynomial growth) step 3's pigeonhole fails, and zero-entropy non-`T+A` measures exist (e.g. `u*`-invariant measures on a `u*`-neutral coordinate); with a subgroup missing `u_w` for some `w`, Lemma Z fails at `w`. Both hypotheses are used. |
| Haar | `h_m(u*) > 0` for non-torsion `u*` (the expanding places contribute), so no conflict |
| EF-X (control) | a rotation-invariant measure on a circle in `A ≅ L_∞` over `ℚ` is carried by `T + A`: consistent |
| archimedean expansion (`F` with a complex place: a relative unit `u*` expands an archimedean place) | `P⁺` may be archimedean; step 4's archimedean bounds cover it; `U_ℚ` acts by rotations there |
| the lift in step 1 | the Bowen atom is a set in `R̂`, not a box; the inclusion rests on the injectivity-radius induction (standard for solenoid automorphisms), and on `u*` preserving `∏_{w∉Q}O_w` (`Q ⊇ supp u*`) |
| measurability of `L + Z_P`, `E_{S′}` | Lusin–Souslin (continuous injections of Polish groups) |

What is **not** checked by a second mind: every step. Grade [hand, one mind], blind to X01D.

### 2.5 A side finding on list X01's EF-G (not my claim; queue §2, readable) — **[hand]**

EF-G(a), "`h_m(u) = log H(u)`" with `H(u) = ∏_w max(1, |u|_w)` "over the finite places `w` of `L`", **fails when `F` has a complex
place**: the norm-one units of `L/F` have rank `r₂(F)` (`rank O_L^× − rank O_F^× = (r₁ + 2r₂ − 1) − (r₁ + r₂ − 1)`), so for `F = ℚ(∛2)`
there is a non-torsion `u ∈ U` with `H(u) = 1` while `h_m(u) = Σ_{v∈S∪∞} log⁺|u|_v ≥ log⁺|u|_{v∞} > 0` (the Haar entropy of an
`S`-adic solenoid automorphism counts archimedean places); and `U_1` is infinite, so EF-G(b)'s `#U_N` is `∞`. For totally real `F`
(`r₂ = 0`: ℚ(√47), ℚ(√167)) `|u|_v = 1` at every archimedean place and the defect is absent. Repair: `H` over all places.

### Would-have-searched-here log

| move I would have made by search | what I did instead |
|---|---|
| none: the route was derived; the only computation is the exact multiplier count at fixed checkpoints (a complete enumeration of a finite set whose extent the derivation fixed) | — |

## Stage 3 — SAVED (the write-up; 11:14 UTC)

### 3.1 Verdicts, per claim

| claim | verdict | grade | where |
|---|---|---|---|
| **EF_F⁺** (brief's quotation; source fenced, unchecked) | **TRUE** | [hand, one mind, blind to X01D] | §2.1 Lemma Z + §2.2 X12B-EF |
| **EF_F** (queue §2, verbatim) | **TRUE** (corollary: an ergodic probability is a finite positive measure; `T + A ⊆ E`) | [hand, one mind] | §2.3 |

**The hard point, answered in one paragraph.** A zero-entropy `u*` thins Bowen sets only at `P⁺ = {|u*|_v > 1}` (non-empty for
non-torsion `u*`, by Kronecker and the product formula). The multipliers are the **rational unit vectors** `(a+bi)/c ∈ U`,
`(4/π + o(1))·M^{1/[L:ℚ]}` of them up to height `M` (exact check at `X = 5 … 1500`), which are **rotations at every archimedean place**
and may expand any finite place they like: the argument never asks them to shrink anything, it only uses `μ(qB) = μ(B)`, reads the
overlap equation (an equation in `L`) at `P⁺` for smallness and elsewhere for a height bound polynomial in `M`, and lets the product
formula make `x` exactly `L`-rational at `P⁺`. **The other places are not controlled by the multipliers at all**: once `x` is
`P⁺`-rational, the rest of `x` lives in the non-compact group `𝔸_{S∖P⁺}`, and a finite `U`-invariant measure there vanishes at every
finite split place, because `U` contains, for each split `w`, an element `α/ᾱ` of `w`-valuation `h ≠ 0` (Lemma Z). That second step
has no analogue in EF (on `𝕋` there are no other places) and it is where invariance under all of `U` — not only the multipliers — is spent.

### 3.2 Consequences worth the owner's attention

- **For invariant measures, `E` and `T + A` are the same target** (X12B-E): `μ(E ∖ (T + A)) = 0` for every `U`-invariant finite `μ`.
  In FL-1's decomposition `σ = a·m + σ_E + τ`, `σ_E` is carried by `T + A`.
- **PE-2 + EF_F⁺ ⇒ MR(F), with no ergodic decomposition** [hand, two lines; PE-2 not checked here]: if `τ` is `U`-invariant and
  `E`-null, PE-2 writes `τ = a·m + τ′` with `h_{τ′}(u) = 0` for all `u`; `m(E) = 0`, so `τ′ ≤ τ` is `E`-null; EF_F⁺ puts `τ′` on
  `T + A ⊆ E`; so `τ′ = 0` and `τ = a·m`. This is EF-MR's first sentence (queue §2), stated for the non-ergodic form.
- **Robustness to Lemma C′'s exception** (a ramified stable dyadic place where `R` may be a proper order): the proof uses `R` only as a
  `U`-stable discrete cocompact subgroup of `𝔸_S` with `ℚR = L`; `T = ℚΛ′/Λ′` and `A` keep their shape. Not affected.
- **Side finding (§2.5):** list X01's EF-G(a) is false at `F = ℚ(∛2)` (a relative unit has `H(u) = 1`, `h_m(u) > 0`); true in shape
  for totally real `F`, which covers the FS-100 targets. Repair: take `H` over all places.

### Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| X12B-R | `R̂ ≅ 𝔸_S/𝔡⁻¹R` (`S` = split places), with `T = L/𝔡⁻¹R`, `A` = image of `L_∞`, `Fin_{S′}` = image of `L_∞ × L_{S′}` | [hand; standard — Tate duality, `S`-integers] | §2.0 |
| X12B-Z | `P ≠ ∅` finite: a `U`-invariant finite measure carried by `L + Z_P` is carried by `T + A` | [hand, one mind] | §2.1 |
| X12B-E | `U`-invariant finite `μ` ⇒ `μ(E ∖ (T + A)) = 0` | [hand, one mind] | §2.1 |
| X12B-EF | `μ` finite, invariant under `u*` (non-torsion) and the rational unit vectors, `h_μ(u*) = 0` ⇒ `μ` carried by `L + Z_{P⁺(u*)}` | [hand, one mind; EF Lemmas 3.1–3.2 transferred] | §2.2 |
| X12B-EF⁺ | **EF_F⁺ TRUE**; hence **EF_F TRUE** | [hand, one mind] | §2.3 |
| X12B-MR | PE-2 and EF_F⁺ imply MR(F) for every real number field `F` | [hand, conditional on PE-2] | §3.2 |
| X12B-G | EF-G(a) fails at `ℚ(∛2)`; `U_1` infinite there | [hand] | §2.5 |
| X12B-N | `#{q ∈ U_ℚ(i) : den q ≤ X} = 4 + 8·#{primitive triples, hypotenuse ≤ X}`, `≥ X` at the checkpoints `5 … 1500` | [tools exact; classical asymptotic `4X/π`] | `tools/x12b_multiplier_count.py` |

**Kernel decision:** declined for now — every step rests on Shannon–McMillan–Breiman, Lusin–Souslin and adelic duality, none of which
Mathlib holds at this generality; a kernel port would be months, and the consumer (MR ⇒ `χ(ℚ(√47)²) = 5`) still has other hand steps.

### Proposed `BIBLIOGRAPHY.md` row (for the front-page lane)

`[EinsiedlerFish2010]` M. Einsiedler, A. Fish, *Rigidity of measures invariant under the action of a multiplicative semigroup of
polynomial growth on T*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005, arXiv:0804.3586 — held at
`data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf` — **read in full (all 8 pp., §§1–4 and references), X12B,
2026-09-26** — role: Lemmas 3.1–3.2 are the method of X12B-EF (zero entropy ⇒ zero dimension ⇒ Diophantine approximation by
pigeonhole over the semigroup ⇒ rationality); its Thm 1.2 uses Johnson 1992 for the positive-entropy half, which X12B does not use.
(Not found in `BIBLIOGRAPHY.md` by arXiv id or Zbl number, 2026-09-26 06:09.)

### What is left

A second, independent check of X12B-EF's steps 1 (the Bowen-atom inclusion) and 5 (the product-formula stabilisation), and of Lemma Z's
use of `α/ᾱ`; the comparison with X01D (fenced here) is the owner's.
