# FS-91 S1V — blind verification of the character local–global theorem (crunch job J10, milestone M1)

*De Bruijn (Opus 5.5), blind verifier of J07, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J10-M1-character-blind-verifier.md`,
with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. The verdicts are mine. Fence honoured: of `plans/FS91-character-local-global.md`
only the quoted statement lines were opened (lines 430–436, 439–441, 452–456, 519–521, located by `grep`); no J07 file, no J02 record, no
other crunch record was opened.*

*Owner's news at launch (statements only), used below: (1) J01-7 verified by two blind readings — RQ_k at every k, and
`Θ_k(R_F) ⊆ T_{N_k} + A(R_F)` for every `F ⊆ ℝ` and every `k`; (2) over `R_F` the archimedean part is the **wide**
`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, never one embedding's `λ_e`; (3) J02's three-colour theorems have two derivations; fence stands.*

## Stage 1 — SAVED (quotation check and C0)

### 1.1 Quotation check (standing rule 5)

| brief item | source | result |
|---|---|---|
| the definitions block ("`F` a real number field (a subfield of ℝ … `H_k` is the hypothesis `Θ_k(R_F) ⊆ T + A` for every real number field `F`.") | `plans/FS91-character-local-global.md` lines 431–436 | **verbatim**; the source continues after "real number field `F`" with a parenthetical of `H_k`'s evidence ("row 95 and the gluing at `k = 4, 5`; PA-B3 with the gluing at `k ≤ 9`, verified by J01; every `k` given J01-7"), which the brief cut — harmless truncation |
| V1 = CLG_k | same file, lines 439–441 | **verbatim** |
| V2 = the κ-form | same file, lines 520–521, inside §M.1 (heading at line 515) | **verbatim** (the source also defines `κ(G, S) = max{β : …}` on line 519, as the brief says) |
| V3 = CLG-g | same file, lines 454–455 | **verbatim**; the source adds after the closing quote "— with the exception made explicit" |
| V4 = CLG-f | same file, lines 452–453 | **paraphrased, one item dropped.** Source: "`[Fischer1994]`'s ℤ/4 colouring of K (row 89) returns a dyadic target at level 3; row 94's C9 on ℚ(√11) returns Γ₇; row 96's HD1, C-47, C-167 and J02-T1 fall out." Brief: "… row 96's three corollaries follow." **J02-T1 is dropped**, and "fall out" of the class theorem (CLG-a to CLG-g) became "consequences of V1". I verify the brief's fixed list (Fischer, C9, HD1, C-47, C-167) as consequences of V1 and of V1's proof separately, and I cannot check J02-T1 (J02's records are fenced; its statement is not in any file I may open) |
| the wide `A` (owner's news 2) versus FS-89's §0.1 `A` | `plans/FS89-rational-band-rigidity.md` §0.1: "`A` (archimedean): `λ_e(x) = Re(ē x) mod 1`, `e ∈ ℂ`" | FS-89's `A` is one embedding's, on `Q ⊂ ℚ(i)` (where it is the whole of `Hom_ℚ(ℚ(i), ℝ)`, so no conflict there). Over `R_F` I read `A(R_F) = {x ↦ ℓ(x) mod 1 : ℓ ∈ Hom_ℚ(F(i), ℝ)}` throughout, as instructed |

### 1.2 C0 — probabilities per claim, registered before the derivation is written

Honest timing: formed after reading the verified inputs (FS-89 §0.1–0.3, FS89-derivation §1, FS86 Lemma R and CL2, ledger rows 88, 89,
94–97), during which a route sketch had already begun; registered before any line of the derivation below was written.

| claim | P(TRUE as stated) | the reason, and the most likely failure |
|---|---|---|
| V1 (CLG_k) | 0.85 | ⟸ looks unconditional (a residue map sends unit vectors into the local norm-one image). ⟹ needs a torsion character of `R_F` to factor through finitely many stable places — the place Lemma R's scope (CL2) could bite — and a "one factor carries the band" step, which could fail for a Minkowski sum of value sets |
| V2 (κ-form) | 0.85 | stands or falls with V1's ⟹; a reading risk in "`κ(O_𝔓, S_𝔓)`" (completion or localisation) and in "max" over infinitely many places |
| V3 (CLG-g) | 0.75 | needs V1 plus a descent from level `m` to level one at `p > k/2`; the exception clause may be misplaced (ramified dyadic places) |
| V4 (controls from V1) | 0.55 | Fischer and C9 look like instances; but HD1 is a statement about **every** band character, which an existence equivalence cannot give, and "at level 3" is a property of one explicit functional, not of V1 |

### 1.3 The would-have-searched-here log (no finite-witness search to 2026-10-01)

| # | the move I would have made by search | what I did instead |
|---|---|---|
| — | (stage 1: none) | — |

## Stage 2 — SAVED (phase 1, blind: my own route to V1–V4)

### 2.1 Conventions (fixed once; FS-89's §0.1 notation otherwise)

`F ⊆ ℝ` a number field (other embeddings may be complex), `L = F(i)`, `c` the non-trivial automorphism of `L/F` (complex conjugation on
`L ⊂ ℂ`), `T` the norm-one torus of `L/F`: `T(E) = {x ∈ L ⊗_F E : x·c(x) = 1}` for `E ⊇ F`, so `U_F = T(F)` (the unit vectors `x + iy`,
`x² + y² = 1`, are exactly the norm-one elements). `R_F = ℤ[U_F]`. `O′ := {x ∈ L : v_𝔓(x) ≥ 0 for every stable prime 𝔓}`. Stable primes of
`L` ↔ places of `F` non-split in `L` (inert, or ramified — ramified only above 2, since `L = F(i)`). `S_{𝔓,m}` = the image of `T(F_v)` in
`(O_𝔓/𝔓^m)^×`, `v` the place of `F` under `𝔓`. `‖x‖` = distance from `x ∈ ℝ/ℤ` to 0, so `B_β = {‖x‖ ≥ β}`. **Archimedean part, wide** (owner's
news 2): `A(R_F) = {x ↦ ℓ(x) mod 1 : ℓ ∈ Hom_ℚ(L, ℝ)}`; `ℓ` extends uniquely to an ℝ-linear, continuous `ℓ_ℝ` on
`L ⊗_ℚ ℝ = ∏_{w | ∞} L ⊗_F F_w ⊇ T(F_∞) := ∏_{w|∞} T(F_w)`, where `T(F_w) = S¹` at a real place of `F` and `T(F_w) ≅ ℂ^×`
(`{(a, 1/a)} ⊂ ℂ × ℂ`, `c` swapping the factors) at a complex one. `H_k` as quoted in §1.1, `T + A` read with the wide `A`.

### 2.2 The lemmas (my route; hand unless marked)

**J10-L1 (the ring, every real `F`).** (a) `R_F` is the ℤ-span of `U_F` (`U_F` is a multiplicative group containing 1). (b) `ℚ·R_F = L`: for
`a ∈ F`, `u_a = (1+ia)/(1−ia) ∈ U_F` (norm `u_a·c(u_a) = 1`; `1 − ia ≠ 0` as `a` is real), `u_a ≠ −1`, and `ia = (u_a − 1)/(u_a + 1)`;
`ℚ[U_F]` is a finite-dimensional domain, hence a field, containing `i = u_1` and every `ia`, hence `L`. (c) `R_F ⊆ O′`: `u·c(u) = 1` and
`v_𝔓(c(u)) = v_{c𝔓}(u) = v_𝔓(u)` at a stable `𝔓` give `v_𝔓(u) = 0`. (d) `O_L[U_F] = O′`. ⊆ by (c). ⊇: for a non-stable `𝔔`
(`c𝔔 ≠ 𝔔`) choose `a ∈ L^×` with `v_𝔔(a) = −1`, `v_{c𝔔}(a) = 0` (approximation theorem); `u = a/c(a) ∈ U_F` has `v_𝔔(u) = −1`. Put
`D = O_L[U_F]`, `x ∈ O′`, `J = {d ∈ D : dx ∈ D}`. If `J ≠ D`, take a maximal `𝔐 ⊇ J`; `𝔓 := 𝔐 ∩ O_L ≠ 0` (else `D_𝔐 ⊇ L`, `𝔐 = 0`, `D = L`,
impossible as `D ⊆ O′ ≠ L`); `(O_L)_𝔓 ⊆ D_𝔐 ⊊ L`, and a DVR has no proper overring but its fraction field, so `D_𝔐 = (O_L)_𝔓`; then every
`u ∈ U_F` is `𝔓`-integral, so `𝔓` is stable (by the `u = a/c(a)` above), so `x ∈ (O_L)_𝔓 = D_𝔐`, `x = d/s` with `s ∉ 𝔐`, `s ∈ J ⊆ 𝔐`: a
contradiction. So `J = D`, `x ∈ D`. (e) **There is an integer `c ≥ 1` with `c·O′ ⊆ R_F`**: by (b) `R_F` contains a ℚ-basis of `L`, so
`c·O_L ⊆ R_F` for a common denominator `c`; by (a) and (d) `O′` is the set of sums `Σ oⱼuⱼ` (`oⱼ ∈ O_L`, `uⱼ ∈ U_F`), and
`c·oⱼuⱼ ∈ R_F·R_F ⊆ R_F`. **No scope restriction**: (e) holds at CL2's ℚ(√5), ℚ(√17) too, where `R_F ≠ O′`; only Lemma R's equality
`R_F = O′` (FS86-B1-LR (a)–(b)) needs its scope, and nothing below uses it.

**J10-L2 (weak approximation for `T`).** For every finite set `Σ` of places of `F`, archimedean ones included, `U_F` is dense in
`∏_{v∈Σ} T(F_v)`. *Proof:* the stereographic map `t ↦ ((1−t²)/(1+t²), 2t/(1+t²))` from `{t ∈ E : 1 + t² ≠ 0}` onto `T(E) ∖ {(−1, 0)}`,
for any field `E ⊇ F` (lines through `(−1, 0)` of slope `t`), is continuous with open dense image in `T(F_v)` (at a complex place `T(F_v)`
is ℂ^× minus nothing essential: the two excluded slopes `±i` are the asymptotes); `F` is dense in `∏ F_v` (approximation theorem); so the
image of `F` is dense in `∏ T(F_v)`. In particular `U_F → ∏_{𝔓∈Σ} S_{𝔓,M}` is **onto**, jointly with any archimedean target (each level-`M`
congruence subgroup of `T(F_v)` is open).

**J10-L3 (factorisation of a torsion character).** Let `τ ∈ Hom(R_F, ℝ/ℤ)`, `Nτ = 0`. Let `Σ` = the stable primes dividing `cN` (`c` from
L1(e)), `M ≥ max_{𝔓∈Σ} v_𝔓(cN)`, `G = ∏_{𝔓∈Σ} O_𝔓/𝔓^M`. Then `ker(R_F → G) ⊆ NR_F ⊆ ker τ`: if `x ∈ R_F` has `v_𝔓(x) ≥ M` on `Σ`, then
`x/(cN) ∈ O′` (integral on `Σ` by `M`, and elsewhere since `x ∈ O′`), so `x ∈ N·cO′ ⊆ NR_F`. Hence `τ` factors through the image `I ⊆ G`;
extend to a character `τ′ = Σ_𝔓 τ′_𝔓` of `G` (finite abelian groups), `τ′_𝔓` a character of `O_𝔓/𝔓^M`, and `τ(x) = Σ_𝔓 τ′_𝔓(x mod 𝔓^M)`
for every `x ∈ R_F`. (If `Σ = ∅`, `τ = 0`.) With `R_F = O′` (Lemma R's scope) `I = G` and the `τ′_𝔓` are canonical; otherwise they depend on
the extension, which no conclusion below does.

**J10-L4 (the value set of a band character in `T + A`).** Let `θ = τ + α ∈ Θ_β(R_F)`, `τ` torsion as in L3, `α = ℓ mod 1` wide. Put
`V_𝔓 = τ′_𝔓(S_{𝔓,M})` and `V_∞ = ℓ_ℝ(T(F_∞)) ⊆ ℝ`. Then (i) every `V_𝔓` is symmetric (`−1 ∈ S_{𝔓,M}`, a group); (ii) `V_∞` is connected
(`T(F_∞)` is: circles and ℂ^×) and symmetric (`−1 ∈ T(F_∞)`, `ℓ_ℝ` linear), so `0 ∈ V_∞`; (iii) **`Σ_𝔓 V_𝔓 + V_∞ ⊆ B_β` (mod 1)**: given
`(s_𝔓) ∈ ∏ S_{𝔓,M}` and `t ∈ T(F_∞)`, L2 gives `u_n ∈ U_F` with `u_n ≡ s_𝔓 (mod 𝔓^M)` on `Σ` and `u_n → t`, so
`θ(u_n) = Σ τ′_𝔓(s_𝔓) + ℓ_ℝ(u_n) → Σ τ′_𝔓(s_𝔓) + ℓ_ℝ(t)`, and `B_β` is closed. (iv) If `ℓ_ℝ` is non-zero on the factor of a complex place of
`F`, then `V_∞ = ℝ` (`Re(pa + q/a)` is unbounded on ℂ^× unless `p = q = 0`), contradicting (iii): **the archimedean part of a band character
vanishes at every complex place of `F`.** (v) With `t` chosen so that `ℓ_ℝ(t) = 0` (by (ii)): the Minkowski sum `Σ_𝔓 V_𝔓 ⊆ B_β` —
the torsion part alone is a band character on `U_F` (FS89-S0A-7's archimedean averaging, here for the wide `A` and complex places).

**J10-L5 (the sign lemma).** If `V₁, …, V_r ⊆ ℝ/ℤ` are symmetric and each meets `{‖x‖ < β}` (`β ≤ 1/2`), so does `V₁ + ⋯ + V_r`. *Proof:*
pick `xⱼ ∈ Vⱼ` with representatives in `(−β, β)`; given a partial sum `s ∈ (−β, β)`, add `xⱼ` if `s, xⱼ` have opposite signs and `−xⱼ ∈ Vⱼ`
otherwise; then `|s ± xⱼ| ≤ max(|s|, |xⱼ|) < β`. For `r = 0` read the empty sum as `{0}`.

**J10-L6 (descent at `p > k/2`).** Let `𝔓` be a stable prime **inert** in `L/F`, of residue characteristic `p` and residue field `𝔽_{q²}`
(`q = N(v)`), `m ≥ 2`, and `λ` a band `k`-character of `T_{𝔓,m}`. If `2p > k`, `λ` is trivial on `𝔓^{m−1}/𝔓^m`, so it is the pullback of
a band `k`-character of `T_{𝔓,m−1}`, and by induction of one of `T_{𝔓,1}`. *Proof:* `π ∈ F` a uniformizer (unramified). For `a ∈ 𝔽_{q²}`
and `y = 1 + π^{m−1}ã` (`ã` a lift), `y/c(y) ∈ T(F_v)` reduces to `1 + π^{m−1}(a − ā)`; `{a − ā}` is the kernel `H` of the trace
`𝔽_{q²} → 𝔽_q` for odd `p` and `𝔽_q` (the image of the trace) for `p = 2` — in both cases a one-dimensional `𝔽_q`-line, and in both cases
`1 + π^{m−1}H ⊆ S_{𝔓,m}`. For `s ∈ S_{𝔓,m}` with level-one image `s̄`, `λ(s(1 + π^{m−1}h)) = λ(s) + χ_{s̄}(h)`, where
`χ_{s̄}(h) = λ(π^{m−1}s̄h)` is an additive character of `H` (elementary abelian `p`-group). If `χ_{s̄} ≠ 0` its values are all of
`(1/p)ℤ/ℤ`, so the fibre's values form the coset `λ(s) + (1/p)ℤ`, whose spacing `1/p < 2/k` puts a point in the open arc `{‖x‖ < 1/k}` —
not band. So `χ_{s̄} = 0` for every `s̄ ∈ S_{𝔓,1} = μ_{q+1}` (every level-one point lifts). `λ(π^{m−1}·)` then kills the 𝔽_q-span of
`μ_{q+1}·H`, which is all of `𝔽_{q²}` (else `μ_{q+1} ⊆ 𝔽_q^×`, i.e. `μ_{q+1} ⊆ μ_{gcd(q+1, q−1)} ⊆ μ₂`, false). **[tools exact:
`tools/crunch_j10_checks.py` (A) — every character of `ℤ[i]/p²` at `p = 3, 7, 11`, `k = 3…9`: `|S₂| = p(p+1)`, fibres of size `p`, no
band character from above level one when `2p > k`; plant A (fibres deleted) fires. At `p = 3`, `k = 9` there are 36 band characters not from
level one: the exception clause of CLG-g is not vacuous.]** At a **ramified** stable place (dyadic only) the level-one target is
`Cay(𝔽_Q, {1})` — every norm-one element is `≡ 1` (G56) — a perfect matching, so `χ(T_{𝔓,1}) = 2`.

**J10-L7 (a Hoffman-tight factor pins `±1/4`).** If `λ` is a band 4-character of a finite abelian Cayley graph `Cay(G, S)` with
`α ≤ |G|/4`, then `min_{s∈S} ‖λ(s)‖ = 1/4`. *Proof:* if every `‖λ(s)‖ ≥ β > 1/4`, the sets `I_t = {x : λ(x) ∈ [t, t + β)}` are independent
(two points of a half-open arc of length `β` are at circle distance `< β`) and average `β|G|` over `t`, so `α ≥ β|G| > |G|/4`.

### 2.3 Verdicts

| claim | verdict at `k ≤ 9` | verdict at every `k` | hypotheses used |
|---|---|---|---|
| **V1 = CLG_k** | **TRUE** | **TRUE given `H_k`** (so TRUE outright on J01-7, per the owner's news 1) | ⟸ none; ⟹ `H_k` (wide `A`), L1–L5 |
| **V2 = the κ-form** | **TRUE** | **TRUE given `H_β` at `β = κ(R_F, U_F)`** (which follows from `H_{⌈1/β⌉}`) | as V1; either reading of `κ(O_𝔓, S_𝔓)` |
| **V3 = CLG-g** | **TRUE** | **TRUE given `H_k`** | V1, L6, G56's ramified target |
| **V4 = the controls** | Fischer: TRUE (dyadic from V1's route; "level 3" from the explicit functional); C9: TRUE; C-47: TRUE; C-167: TRUE; **HD1: GAP as a consequence of V1** — closed from V1's *proof* with Lemma D | — (all at `k = 4, 5`, where `H_4`, `H_5` are row 95) | see below |

**V1, ⟸ (unconditional).** `R_F ⊆ O_𝔓` and `U_F ⊆ T(F_v)` (L1(c)), so reduction `R_F → O_𝔓/𝔓^m` is a ring map sending `U_F` into
`S_{𝔓,m}`; a band `k`-character `λ` of `T_{𝔓,m}` pulls back to `λ∘red ∈ Θ_k(R_F)`.
**V1, ⟹.** `θ ∈ Θ_k(R_F)`; by `H_k`, `θ = τ + α`, `τ` torsion, `α ∈ A(R_F)`. L3 and L4(v): `Σ_𝔓 V_𝔓 ⊆ B_k`. If every `V_𝔓` met `{‖x‖ < 1/k}`,
L5 would put a point of the sum there; so some `V_𝔓 ⊆ B_k`, i.e. `τ′_𝔓` is a band `k`-character of `T_{𝔓,M}` (`Σ ≠ ∅`, since the empty sum
`{0}` is not in `B_k`). **The "Hence" clause:** `min_{𝔓,m} χ_char(T_{𝔓,m}) ≥ χ_char(F²)` unconditionally (⟸), with equality under
`H_{k₀}`, `k₀ = χ_char(F²)` (⟹ at `k₀`); since `Θ_{k′} ⊆ Θ_k` for `k′ ≤ k`, `H_k` gives `H_{k′}` for all `k′ ≤ k`, so **under `H_k` alone the
equality is proved when `χ_char(F²) ≤ k`**, and when `χ_char(F²) > k` only the inequality — a scope note on the clause as attached to
"Let `k ≥ 3` satisfy `H_k`", moot given J01-7 (every `k`). (`k₀ = 2`: `H₂` holds trivially — a band 2-character is `1/2` on `U_F`, hence of
order 2 by L1(a); `k₀ = ∞`: both sides `∞` by ⟸.) The last clause follows (`⌊kλ⌋` colours `T_{𝔓,m}`).
**Scope.** Every real number field, **complex embeddings included** (L2 and L4(ii) treat ℂ^× factors; L4(iv) is the extra fact they give).
**Lemma R is not needed** — only L1(e), `cO′ ⊆ R_F`, which holds for every real `F`. The level `m` returned is at most `max v_𝔓(cN)`.
**`H_k` is used only at the given `F`**, not for every field.

**V2.** Under every reading of `κ(O_𝔓, S_𝔓)` (the completion with continuous characters `= sup_m κ(T_{𝔓,m})`; the completion or the
localisation with all characters): `κ(T_{𝔓,m}) ≤ κ(O_𝔓, S_𝔓) ≤ κ(R_F, U_F)` (pull back to the target; restrict to `R_F ⊆ O_𝔓`,
`U_F ⊆ S_𝔓`). `κ(R_F, U_F)` is attained (the `Θ_β` are closed in the compact dual and decrease in `β`). If `κ := κ(R_F, U_F) > 0`, take
`θ ∈ Θ_κ`; under `H_κ` the ⟹ argument with `β = κ` (L5 at `β = κ`) gives `(𝔓*, M)` with `κ(T_{𝔓*,M}) ≥ κ`. So the maximum over stable
places is **attained**, at a finite level, and equals `κ(R_F, U_F)`. `H_β ⟸ H_{⌈1/β⌉}` (`B_β ⊆ B_{⌈1/β⌉}`). If `κ = 0` no hypothesis is needed.

**V3.** Under `H_k`, `Θ_k(R_F) ≠ ∅` gives a band `k`-character of some `T_{𝔓,m}` (V1). If `𝔓` is ramified in `L/F` (dyadic), `L(F) ≤ 2 ≤ k`
(L6's last line; G56). If `𝔓` is inert and `m = 1` or `2p > k`, L6 gives a band `k`-character of `T_{𝔓,1}`, so `χ(T_{𝔓,1}) ≤ k` and
`L(F) ≤ k` (`L(F)` = the least chromatic number of the level-one targets, § Notation, G56). What remains is exactly "`p ≤ k/2` above level
one". **TRUE**, every real `F`, complex embeddings included, no Lemma R. The exception is **not vacuous** at the character level: at `p = 3`,
`k = 9`, 36 band characters of `T_{3,2}` over `ℚ₃` do not come from level one (tool (A)).

**V4, item by item** (as consequences of V1, the brief's reading; the plan's CLG-f says "fall out" of the class theorem CLG-a–g, which I
have not seen).
- **Fischer (row 89).** Fischer's character `τ = f/4` has order 4 and `α = 0`; at `K`, L3's `Σ` is the stable primes dividing `4c`. Whether
  `c = 1` at `K` (Lemma R's scope holds at `K`: both dyadic places inert in `L/K`, FS86-CL2) or not, the primes of `Σ` dividing `4` are the two
  dyadic ones, and the odd ones in `Σ` (if `c > 1`) carry `τ′_𝔓 = 0` when `I = G`; V1's route returns a **dyadic** target — TRUE. **"At
  level 3" is not a consequence of V1**; it is a fact about the explicit functional: I re-ran the existing checker
  `data/fs86/b1/fischer_vk_control.gp` (seconds): `f` maps `𝔓₁³` (not `𝔓₁²`) into `4ℤ_(2)` and no power of `𝔓₂` — so `τ` reads `𝔓₁` alone,
  at level exactly 3, and the band factor is `T_{𝔓₁,3}`; `f(u) = −5/3 ≡ 1 (mod 4)` on the checker's unit vector. **TRUE** with that input.
- **C9 (row 94).** `θ = τ + α`, `τ = (2x + 3y)/7` read at one of the two stable places above 7 (7 splits in ℚ(√11), `7 ≡ 3 mod 4`), `α`
  archimedean of size `< 1/28`. The sign lemma's band factor is that place (the other factor is `{0}`), at level one: values `{2,3,4,5}/7
  ⊆ [1/4, 3/4]` (tool (B); plant B fires). Returns `Γ₇` — **TRUE**.
- **C-47 (row 96).** Stable places of ℚ(√47): none dyadic (`−47 ≡ 1 mod 8`, split: tool (C)); odd ones of prime residue field `q ≡ 3 (4)`,
  `q ≥ 11` (3 and 7 inert in `F`: tool (C)). V1 at `k = 4` (`H₄`: row 95) + L6 (`p ≥ 3 > 2`) + FS89-S0A-8's level-one Weil count (no band
  4-character of `Γ_q`, `q ≥ 11`) give `Θ₄ = ∅`. **TRUE, without Lemma R** (S0A-8 needed it; V1's route does not).
- **C-167 (row 96).** Stable places of ℚ(√167): none dyadic; odd `q ∈ {23, 43, 59, …, 167}`. V1 at `k = 5` (`H₅`: row 95) + L6 (`p ≥ 3 > 5/2`)
  + FS89-S0A-9's level-one refusals (23, 43 by FS-66's and FS-53's certificates, 59 by Hoffman, `q ≥ 67` by Weil) give `Θ₅ = ∅`. **TRUE.**
  (At the character level the certificates are more than needed at 23 and 43 — only "no band 5-character of `Γ_q`" is used — not pursued:
  it would be an enumeration of `q²` characters, logged below.)
- **HD1 (row 96, CL3).** HD1 describes **every** point of `Θ₄` (all are dyadic torsion); V1 decides only whether `Θ₄` is empty, so **HD1 is not
  a consequence of V1's statement — GAP at "V1 ⟹ HD1"**. It **is** a consequence of V1's *proof*: for `F = ℚ(√d)`, `d ∈ {59, 83, 131}`
  (`d ≡ 3 mod 8`: the one dyadic place has completion `ℚ₂(√3)`, inert in `L/F`; the odd stable `q` are prime, `≥ 11`: tool (C)), let
  `θ ∈ Θ₄`. No odd factor is band (L6 + S0A-8), so by L5 the dyadic factor is: `V₀ ⊆ B₄`; by Lemma D (FS86-B1-LD: the dyadic target is
  Hoffman-tight at four colours at every level, so `α ≤ |G|/4`) and L7, `±1/4 ∈ V₀`. For `w` in `W = Σ_{odd} V_𝔓 + V_∞`, `±1/4 + w ∈ B₄` forces
  `w ∈ {0, 1/2}`; `V_∞` is connected and contains 0, so `V_∞ = {0}` and `α = 0` (`T(F_∞)` spans `L ⊗ ℝ`); each odd `V_𝔓` has odd-order values
  and `V_𝔓 − V_𝔓 ⊆ {0, 1/2}`, so `V_𝔓 = {0}`, and `τ′_𝔓` vanishes on the image of `R_F` (L1(a)). So `θ = τ′₀∘red₀`, a dyadic pullback: HD1.
  **Inputs: `H₄` (row 95), S0A-8, Lemma D — no FS-66 certificate, no `[Zhang2012]`, no Lemma R** (CL3's route, through FS86-dB-Theta, needed
  FS-66's certificates at 11 and 19 and Zhang's Thm 1.8(i)). So the verdict on V4's HD1 item is GAP as stated, TRUE as "a consequence of
  V1's route plus Lemma D".
- **J02-T1** — in the source's CLG-f, dropped by the brief (§1.1); its statement is fenced from me. **Not checked.**

**Which hypotheses, once more.** `H_k` with the wide `A` (with one embedding's `λ_e` the hypothesis is false over ℚ(√3), owner's news 2, and
nothing above would follow); L1–L7 are hand and use no Lemma R, no certificate, no external theorem beyond the approximation theorem and the
elementary structure of DVRs; V4's items add row 95 (`H₄`, `H₅`), S0A-8, S0A-9 (with its certificates), Lemma D, and the existing Fischer
checker.

### 2.4 Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| J10-L1 | for every real number field `F`: `R_F` = ℤ-span of `U_F`; `ℚR_F = L`; `R_F ⊆ O′`; `O_L[U_F] = O′`; `cO′ ⊆ R_F` for some integer `c ≥ 1` | [hand] | §2.2 |
| J10-L2 | `U_F` is dense in `∏_{v∈Σ} T(F_v)` for every finite set of places `Σ`, archimedean included; `U_F → ∏ S_{𝔓,M}` is onto | [hand] | §2.2 |
| J10-L3 | a torsion character of `R_F` of order dividing `N` factors through `∏_{stable 𝔓 | cN} O_𝔓/𝔓^M` | [hand] | §2.2 |
| J10-L4 | the value set of `τ + α ∈ Θ_β(R_F)` contains `Σ V_𝔓 + V_∞`; `V_∞` connected symmetric; the archimedean part vanishes at every complex place of `F`; the torsion part alone is band on `U_F` | [hand] | §2.2 |
| J10-L5 | a Minkowski sum of symmetric subsets of ℝ/ℤ each meeting `{‖x‖ < β}` meets it | [hand] | §2.2 |
| J10-L6 | at an inert stable place of residue characteristic `p > k/2`, every band `k`-character of `T_{𝔓,m}` comes from level one; the exception at `p ≤ k/2` is non-vacuous (`p = 3`, `k = 9`) | [hand + tools exact at level 2, `p = 3, 7, 11`, `k ≤ 9`] | §2.2; `tools/crunch_j10_checks.py` (A); `data/fs91/j10/checks.out` |
| J10-L7 | a band 4-character of a Cayley graph with `α ≤ |G|/4` takes the value `±1/4` | [hand] | §2.2 |
| J10-T1 | **V1 (CLG_k)**: ⟸ unconditional; ⟹ given `H_k`; every real number field, complex embeddings included, no Lemma R | [hand, blind] | §2.3 |
| J10-T2 | **V2 (κ-form)**: `κ(R_F, U_F) = max_𝔓 κ(O_𝔓, S_𝔓)`, attained at a finite level, given `H_κ` | [hand, blind] | §2.3 |
| J10-T3 | **V3 (CLG-g)** given `H_k` | [hand, blind] | §2.3 |
| J10-T4 | **HD1 for ℚ(√59), ℚ(√83), ℚ(√131) from `H₄` + S0A-8 + Lemma D**, no FS-66 certificate, no Zhang, no Lemma R | [hand, blind; one mind] | §2.3 V4 |
| J10-T5 | C-47 from V1 + L6 + S0A-8 without Lemma R; C-167 from V1 + L6 + S0A-9 | [hand; compositions] | §2.3 V4 |

### 2.5 The would-have-searched-here log

| # | the move I would have made by search | what I did instead |
|---|---|---|
| 1 | search small fields for a band character with no band target (a counterexample to V1) | derived V1 (§2.2–2.3); no search |
| 2 | enumerate band characters at level two to see whether the descent holds | derived L6 first, then checked it by a **complete exact enumeration of a derivation-fixed set** (every character of `ℤ[i]/p²`, `p = 3, 7, 11`, `k ≤ 9`; 0.24 s) — at the edge of the ban, logged as such |
| 3 | enumerate the `q²` level-one characters of `Γ₂₃`, `Γ₄₃` to replace FS-53's and FS-66's certificates in C-167 by "no band 5-character" | not run; S0A-9 (a verified input) suffices |
| 4 | recompute Fischer's level by my own PARI build | re-ran the existing checker `data/fs86/b1/fischer_vk_control.gp` (an existing checker on an existing object) |

### 2.6 Inventory items for the owner (proposed; I edit no front-page file)

- result — V1, V2, V3 TRUE given `H_k`, blind, every real `F` incl. complex embeddings, no Lemma R — §2.3.
- result — HD1 at ℚ(√59), ℚ(√83), ℚ(√131) with fewer inputs than CL3 (no FS-66 certificate, no Zhang, no Lemma R; Lemma D and S0A-8 instead) — §2.3 V4 (J10-T4).
- result — L1(e) `cO′ ⊆ R_F` for every real field (Lemma R's step that survives CL2) — §2.2.
- result — L4(iv): the archimedean part of a band character vanishes at every complex place of `F` — §2.2.
- correction owed — V4's HD1 item cannot follow from V1's *statement* (existential); the plan's CLG-f should say "from CLG's proof with Lemma D" — §2.3.
- correction owed — CLG_k's "Hence" clause needs `H` at `χ_char(F²)`, which `H_k` supplies only when `χ_char(F²) ≤ k` (moot given J01-7) — §2.3.
- slip — the brief's V4 dropped J02-T1 from the quoted CLG-f and paraphrased "fall out" as "follow" (as consequences of V1) — §1.1.
