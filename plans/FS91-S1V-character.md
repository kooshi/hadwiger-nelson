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

## Stage 3 — SAVED (phase 2: J07's lemma statements, derived or refuted; the assembly)

*Opened after J07's stage 5 (95cd3af1) and final report (2aaa6d82) and after my phase-1 verdicts (2b692934): `data/fs91/j07/lemma-statements.md`
only — statements, no proofs; J07's record and tools unopened in this stage. Exact checks: `tools/crunch_j10_phase2.py` (mine; J07's tools
never run), output `data/fs91/j10/phase2.out` (121 checks, 0 failures; four plants fire, each for its own reason — see the tool's docstring).
Numbering is the statements file's (items 1–25).*

### 3.1 Verdict per statement

| # | J07's statement (short name) | verdict | how (mine) |
|---|---|---|---|
| 1 | U1 (`U ⊆ O_𝔓^×`, `R ⊆ O_𝔓`) | **TRUE** | = J10-L1(c) |
| 2 | U2 (`R ⊗ ℚ = L`) | **TRUE** | = J10-L1(b) |
| 3 | U3 (`−1, i ∈ U`; symmetric images) | **TRUE** | `u_0 = 1`, `u_1 = i`, `u_∞ = −1`; images of a group containing −1 |
| 4 | CLG-a | **TRUE** | = V1 ⟸ (phase 1) |
| 5 | CLG-b (`‖y‖ ≥ β + ‖x‖`) | **TRUE** | with `a = ‖x‖ < β` and `y ∈ [0, ½]` (Y's condition is invariant under `y ↦ −y`): `‖y − a‖ = |y − a| ≥ β` forces `y ≥ a + β` (if `y < a`, `|y − a| ≤ a < β`); if `a + β > ½`, `Y = ∅` and the claim is vacuous |
| 6 | CLG-b_n | **TRUE** | contrapositive of J10-L5 (the empty-`X_j` case is trivially covered; `n ≥ 1`) |
| 7 | **Lemma C** | **TRUE** (hand, mine) | below, §3.2 |
| 8 | **Lemma C′** | **TRUE** (hand, mine; tools exact at 7 field–prime pairs incl. complex embeddings; the exception is real at ℚ(√5), ℚ(√17), ℚ(α) and vacuous at ℚ(√2)) | below, §3.2 |
| 9 | (W) | **TRUE** | = J10-L2 |
| 10 | (J), CLG-c corrected | **TRUE** | from 7 and 9, §3.2; the correction is right: at a ramified stable dyadic place the image is *not* `∏ S` in general |
| 11 | CLG-d | **TRUE** | = J10-L4(iii)–(v): complex places vanish (L4(iv)); at a real place `ℓ_w = Re(ē_w ·)` has image `[−|e_w|, |e_w|]` on `S¹`; fibres dense (item 10) and `B_β` closed |
| 12 | Lemma AV | **TRUE** | J10-L7's averaging: `I_t = λ^{−1}[t, t + β)` is independent, mean size `β|G|` |
| 13 | CLG_k | **TRUE given `H_k`**, with my phase-1 scope note on its middle clause (the equality `χ_char = min` needs `H` at `χ_char(F²)`, supplied by `H_k` when `χ_char(F²) ≤ k`; moot given J01-7) | assembly §3.3 |
| 14 | CLG, converged form | **TRUE** given `H_κ` (`H_β` at every band is more than needed); `χ_char = ⌈1/κ⌉` since `Θ_{1/k} ≠ ∅ ⟺ 1/k ≤ κ` | = V2 (phase 1) |
| 15 | Lemma LB | **TRUE** (hand, mine; tools exact) | §3.2 |
| 16 | Lemma LB′ | **TRUE** (hand, mine; tools exact); its two numerical consequences and "level 2 never at `e ≥ 2`" follow; LB′ is **sharp** at (`e = 1`, level 2) and (`e = 2`, level 3) on `f = 1` towers, **not** at (`e = 1`, level 3) or (`e = 2`, level 5), where the true best margin is `1/27` | §3.2; `phase2.out` (E) |
| 17 | CLG-e | **TRUE** (hand; tools exact) — sharper than my J10-L6 at `k = 2p` (values lie in `p^{−E}ℤ`, `p` odd, so the coset `1/(2p) + p^{−1}ℤ` is unavailable) | §3.2 |
| 18 | CLG-g (E1)/(E2) form | **TRUE**, given G56's four-colourings of `U_Q` (`Q ≤ 32`), Brooks, and the all-levels Hoffman ratio of the inert dyadic tower — which G54 states for Galois rings only; **J10-L8 (§3.2) proves it for every inert tower, `F_𝔭` ramified over `ℚ₂` included**, so no scope gap remains | §3.2 |
| 19 | CLG-g corollaries | (g1) **TRUE** (U₆₄'s exact `λ_min = −15`, floor 5.33; Weil from 128); (g2) **TRUE**; (g3) at `k = 6` **TRUE**; at `k = 7`, (E2) at `Q = 64` only **TRUE** (needs U₁₂₈'s exact spectrum: `λ_min = −19`, floor 7.79 — Weil alone gives 6.7); **(E1) "`e(𝔭|3) = 1`, exact level 3": GAP** — LB and LB′ leave exact level **`2e + 1` at every `e`** open at `k = 7` (tool (G): `(1,3), (2,5), (3,7), (4,9)`); the stated lemmas give "exact level `2e(𝔭|3) + 1`", not "`e = 1`". The `f = 1` towers show the same best margin `1/27` at `(e, L′) = (1, 3)` and `(2, 5)`, so nothing in the data separates `e ≥ 2` | §3.2 |
| 20 | level-one inputs | **TRUE** (tools exact, mine: by the value multiplicity `1 − η(t² − 4N(a))`, brute-forced at 7, 11, 19, 23; no band-4 at every prime `q ≡ 3 (4)`, `11 ≤ q ≤ 59`; no band-5 at 23, 43, 59; Hoffman–Weil from 67 is arithmetic). By-products: `Γ₁₉` carries a band-5 character (norm class 15); `Γ₁₁` does not, though `χ(Γ₁₁) = 5` | `phase2.out` (F) |
| 21 | HD1 via CLG | **TRUE** | = J10-T4 (phase 1), same inputs |
| 22 | C-47 via CLG | **TRUE** | = J10-T5 |
| 23 | C-167 via CLG, "no certificate" | **TRUE**, and the "no certificate" is right: item 20's exact band-5 check at 23 and 43 replaces FS-53's and FS-66's certificates | J10-T5 + item 20 |
| 24 | Controls | **TRUE** (θ₂: a band-2 character is `½` on `S`, impossible at odd places (values in `p^{−E}ℤ`) and at inert dyadic ones (item 17), so it is ramified dyadic — "at level 1" means one exists there, which the route's extension need not return; Fischer at level 3 and C9: phase 1; `Θ₃`: CLG-e puts an odd band factor at level one and `Γ_q`, `q ≥ 7`, has no band-3 character (`χ(Γ₇) = 4`, `χ(Γ₁₁) = 5`, Hoffman–Weil from 14), inert dyadic has none; `κ_loc` monotone: pull a band character of `T_{𝔓′,m}` back along `O_𝔓/𝔓^{⌈m/e⌉} → O_{𝔓′}/𝔓′^m`, which maps `S` into `S′`) | §3.1 |
| 25 | CL3–CL5 under the wide `A` | **TRUE for the conclusions** (my phase-1 route reaches all three with the wide `A`); "each FS-89 step already reads every real place" checked only at S0A's G3 step 3 (`T(ℝ)²`, both real places of ℚ(√167)) | `plans/FS89-S0A-gluing-verification.md` G3 |

### 3.2 The derivations behind the new verdicts (mine, from the statements)

**Lemma C.** By J10-L1(e), `cO′ ⊆ R ⊆ O′`. `ℤ_p` is flat, so `c(O′ ⊗ ℤ_p) ⊆ R ⊗ ℤ_p ⊆ O′ ⊗ ℤ_p` inside `L ⊗ ℚ_p`. `O′` is the ring
of `S`-integers for `S` = the non-stable primes, `O′ = O_L[1/a]` for an `a` supported on `S` (a power of each `𝔔 ∈ S` is principal), so
`O′ ⊗ ℤ_p = ⋃_n a^{−n}∏_{𝔓|p} Ô_𝔓 = ∏_{stable 𝔓|p} Ô_𝔓 × V_n`. So `R ⊗ ℤ_p ⊇ 0 × V_n` (`V_n` is divisible), hence `R ⊗ ℤ_p = R̄_p × V_n` with
`R̄_p` its projection — a closed subring containing `c∏Ô_𝔓`, so open of finite index, and the closure of `R` (the image of `R` is dense in it:
modulo the open `c∏Ô` the ℤ- and ℤ_p-spans agree). Then `R/p^jR = (R ⊗ ℤ_p)/p^j = R̄_p/p^jR̄_p` (`V_n` divisible); CRT gives `R/NR`;
`R̄_p` is ℤ_p-free of rank `Σ [L_𝔓 : ℚ_p]`; and if `x ∈ R` has `v_𝔓(x) ≥ K` at every stable `𝔓 | N` with `K ≥ e_𝔓(v_p(N) + v_p(c))`, its image
lies in `p^{v_p(N) + v_p(c)}∏Ô ⊆ p^{v_p(N)}R̄_p` for each `p | N`, so `x ∈ NR`. No Galois hypothesis, no scope restriction. (Sharper than my
J10-L3, which used the primes dividing `cN`; the primes dividing `c` alone are not needed.)

**Lemma C′.** Let `𝔓 | p` be stable with `E = L_𝔓` unramified over `K = F_𝔭` (every odd stable place; the inert dyadic ones), residue fields
`𝔽_{q²}/𝔽_q`, `π ∈ K` a uniformizer. The norm-one torus is smooth over `O_K`, so the congruence filtration of `T(K)` has graded pieces
`μ_{q+1}` (level 0) and `1 + π^m·Lie`, `Lie = ker(Tr: 𝔽_{q²} → 𝔽_q)` (level `m ≥ 1`; `= i𝔽_q` for odd `p`, `= 𝔽_q` for `p = 2`).
(a) *The closed ℤ_p-span `Z` of `T(K)` is `O_E`:* the 𝔽_p-span of `μ_{q+1}` is `𝔽_{q²}` (a proper subfield `𝔽_{p^g}` would need
`q + 1 | p^g − 1`, whence `2f | g`); at level `m`, `z(1 + π^m h) − z ≡ z̄hπ^m` and the 𝔽_p-span of `μ_{q+1}·Lie` is `𝔽_{q²}`; a closed
submodule surjecting onto every graded piece of `O_E` is `O_E`. (b) *The closed span `D` of the differences `t − t′` is `O_E` as well:* at odd
`p` because `t − (−t) = 2t`; at `p = 2` because `Σ_{z∈μ_{q+1}}(z − 1) = −(q + 1) = 1` in characteristic 2 (`q + 1` odd), and the level-`m ≥ 1`
pieces are differences already. (c) *Splitting off:* by (W), `R̄_p ⊇ ∏_{stable 𝔓|p} T(F_𝔭)`, so it contains `(t − t′, 0, …, 0)` for `t, t′` in one
factor, hence `D_𝔓 × 0 = Ô_𝔓 × 0` for every unramified-type factor. So `R̄_p = ∏ Ô_𝔓` whenever no stable place above `p` is ramified in `L/F`,
and inert dyadic places split off regardless. At a ramified stable dyadic place `D ⊆ 𝔓` (every norm-one element is `≡ 1`, G56), and the
closure is a proper suborder exactly when the rest of the structure cannot make up the residue field — tools: ranks `2 < 4` at ℚ(√5), `2 < 4`
at ℚ(√17), `2 < 6` at ℚ(α) (residue 𝔽₈), but **full rank 4 at ℚ(√2)** (residue 𝔽₂, one place): "except possibly" is the right wording.
**Consequence (Lemma R's conclusion without its Galois hypothesis):** since `O′/R` has exponent dividing `c`, it is the sum of its `p`-parts
`(O′/R) ⊗ ℤ_p = ∏Ô/R̄_p`; so **`R_F = O′` (and `R_F` is dense in every finite product of stable completions) for every real number field with no
ramified stable dyadic place** — FS86-B1-LR's "`L/ℚ` Galois" is not needed. [hand; tools exact: full rank at ℚ(√3) (p = 3, 2), ℚ(√7) (3),
ℚ(√11) (7), ℚ(√3,√17) (2, two inert dyadic places), ℚ(α), α³ = α + 1 (3 — residue 𝔽₂₇ — and 23; complex embeddings); plant D (only `a ∈ 2O_F`)
drops the rank to 1.]

**(J).** Under Lemma C's isomorphism `R/NR ≅ ∏_{p|N} R̄_p/NR̄_p`, the closure of `U` in `∏_{stable 𝔓|N} Ô_𝔓` is `∏ T(F_𝔭)` (W), and each fibre of
`R̄ → R̄/NR̄` is open; so the image of `U` is the image of `∏ T(F_𝔭)`, which is `∏ S_{𝔓, v_𝔓(N)}` when C′ holds at every `p | N`; a fibre
`{u ≡ u₀}` is `U` intersected with an open set of `∏ T(F_𝔭)`, so it is dense in `∏_{w|∞} T(F_w)` by (W) with the archimedean places added.

**LB.** For `λ` of exact level `L ≥ 2`, put `j = ⌈L/2⌉`; `T_j/T_L` is the additive group `X = {π^j·iy}` (`y ∈ 𝔭^0/𝔭^{L−j}`, `2j ≥ L`), and on
`s·T_j` the values are `λ(s) + ψ_s(X)` with `ψ_s(x) = λ(sx)`. Writing `λ(z) = ψ₀(Tr(wz))`, `v(w) = −L − δ` (`δ` the different of `K`),
`ψ_s(iy) = ψ₀(Tr_{K/ℚ_p}(y·(−2 Im(ws))))`; some `s̄ ∈ μ_{q+1}` has `w̄₀s̄ ∉ 𝔽_q` (else `μ_{q+1} ⊆ 𝔽_q^×·const`, impossible), so `v(Im(ws)) = v(w)`
and `ψ_s` has order `p^{⌈(L−j)/e⌉} = p^a` (`⌈x/e⌉ = ⌊(x−1)/e⌋ + 1`). A coset of `p^{−a}ℤ/ℤ` has a point with `‖·‖ ≤ 1/(2p^a)`. **LB′:** the values
lie in `p^{−E}ℤ/ℤ` (`E = ⌈L/e⌉`, the exponent of `O_E/𝔓^L`), so that point is at distance `≤ ((p^{E−a} − 1)/2)/p^E`. **CLG-e (odd):** hence a band
character above level one has `k > 2p^a ≥ 2p`. **CLG-e (inert dyadic):** the same fibre gives a coset of `2^{−t}ℤ`, `t ≥ 1`, which has a point
with `‖·‖ ≤ 1/4 < 1/3`; and at level one a band character would be `½` on all of `μ_{Q+1}`, but `Σ_{z∈μ_{Q+1}} z = 0` while `Q + 1` is odd.
[tools exact: every character of every exact level of `ℤ₃[i]/3⁴`, `ℤ₇[i]/7³`, `ℚ₃(√3)(i)/𝔓⁵` (`e = 2`) and `ℚ₂(√3)(ω)/𝔓⁶` (dyadic, `e = 2`); no
band-7 character at any level ≥ 2 on any of them; at the dyadic tower band 4 first appears at exact level 3, margin exactly `1/4`.]

**J10-L8 (the all-levels ratio in every inert tower).** For `E/K` unramified with smooth norm-one torus (every odd stable place, every inert
stable dyadic place, `K` possibly ramified over `ℚ_p`), residue `𝔽_Q`: a character `λ` new at level `j ≥ 2` has eigenvalue
`μ(λ) = Q·Σ_{s ∈ S_{j−1}, w̄₀s̄ ∈ 𝔽_Q} e(λ(s̃))` (the inner sum over the kernel `1 + π^{j−1}Lie` of `S_j → S_{j−1}` vanishes unless the residue
pairing kills `Lie`, i.e. unless `w̄₀s̄ ∈ Lie^⊥ = 𝔽_Q`), and `w̄₀^{−1}𝔽_Q^× ∩ μ_{Q+1}` has at most `|𝔽_Q^× ∩ μ_{Q+1}| = gcd(Q−1, Q+1)` points; so
`|μ(λ)| ≤ c·Q^{j−1}`, `c = 2` (odd) or `1` (dyadic). Pulled back to level `m`, every eigenvalue is `≥ −cQ^{m−1} ≥ Q^{m−1}λ_min(level 1)`
(`λ_min ≤ −2` on `Γ_q`, `≤ −1` on `U_Q`), so **`λ_min(level m) = Q^{m−1}λ_min(level 1)` and every Hoffman floor survives every level** — G54's
all-levels ratio beyond Galois rings, and FS86-LP's odd-tower bound re-derived. [hand; tools: exact at all four towers above, including the
non-Galois-ring dyadic tower `ℚ₂(√3)`; plant L8 (`c = 1`) is violated on `ℚ₃(√3)(i)`, so `c = 2` is needed and attained there.]

### 3.3 The assembly — do the lemmas, as stated, imply V1–V4?

- **V1 (CLG_k) from 1–3, 6, 7, 9, 11 and `H_k`: yes.** ⟸ is 4 (from 1). ⟹: `θ = τ + α` (`H_k`); `τ ∈ Θ_k` (11); by 7's last clause `τ` factors
  through the image of `R` in `G = ∏_{stable 𝔓|N} O_𝔓/𝔓^K`; extend to `G` (ℝ/ℤ divisible) and split `τ′ = Σ τ′_𝔓`; by 9 the image of `U` in `G`
  is `∏ S_{𝔓,K}`, so `τ(U) = Σ τ′_𝔓(S_{𝔓,K}) ⊆ B_k`; 3 makes each summand symmetric and 6 gives one `τ′_𝔓` band on `S_{𝔓,K}`. **C′ (8) is not
  needed and is correctly absent from 13's inputs** — the extension step replaces it at ramified dyadic places.
- **V2 from 14: yes** (V2's hypothesis is weaker than 14's; either suffices).
- **V3 from 18: yes, strictly sharper.** 18's exceptions have `p < k/2` (E1, by 17) or `p = 2` with `k ≥ 6` (E2), both "above level one", so they
  lie inside V3's "`p ≤ k/2` above level one"; and V3's ramified dyadic case is 18's matching.
- **V4 from 21–24: yes** for Fischer (with the existing checker, as in phase 1), C9, HD1, C-47, C-167, and the three-colour control (J02-T1's
  generalisation, now visible to me as item 24's statement: TRUE given `H₃`). HD1 needs the *route* (21's inputs 13, 17, 20, 12 and Lemma D), not
  13's statement — the correction I proposed in phase 1 is already J07's wording.
- **Hypotheses:** `H_k` with the wide `A` (J01-7); no Lemma R, no Galois hypothesis, no certificate; complex embeddings covered (8 is checked
  at ℚ(α), where the place above 3 has residue 𝔽₂₇ — the (E1) region).

### 3.4 Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| J10-L8 | in every inert residue tower (odd stable place, or inert stable dyadic place; `F_𝔭` possibly ramified over `ℚ_p`) a character new at level `j` has `|λ| ≤ c·Q^{j−1}` (`c` = 2 odd, 1 dyadic), so `λ_min` scales exactly by `Q^{j−1}` and every Hoffman floor survives every level | [hand + tools exact at four towers] | §3.2; `tools/crunch_j10_phase2.py` (E) |
| J10-T6 | Lemma C and Lemma C′ as stated (re-derived blind); hence **`R_F = O′` and `R_F` dense in every finite product of stable completions, for every real number field with no ramified stable dyadic place — no Galois hypothesis**; the ramified exception holds at ℚ(√5), ℚ(√17), ℚ(α) and fails to occur at ℚ(√2) | [hand; tools exact at seven pairs and four controls] | §3.2; tool (D) |
| J10-T7 | LB, LB′, CLG-e re-derived; LB′ sharp at (`e`=1, level 2) and (`e`=2, level 3) on `f = 1` towers, not at (1, 3) or (2, 5) (true margin `1/27`) | [hand + tools exact] | §3.2; tool (E) |
| J10-T8 | (g3) at `k = 7`: LB/LB′ leave exact level `2e(𝔭|3) + 1` open at **every** `e`, so "`e(𝔭|3) = 1`" does not follow from J07's lemmas (GAP) | [hand; arithmetic tool (G)] | §3.1 item 19 |
| J10-T9 | the level-one table: no band-4 character of `Γ_q`, prime `q ≡ 3 (4)`, `11 ≤ q ≤ 59`; none of band 5 at 23, 43, 59 (none at 11 either; one at 19); `λ_min(U₆₄, U₁₂₈, U₂₅₆) = −15, −19, −31` | [tools exact, via a brute-forced multiplicity formula] | tool (F) |

### 3.5 The would-have-searched-here log (stage 3)

| # | the move I would have made by search | what I did instead |
|---|---|---|
| 5 | search for a real field whose unit-vector ring misses part of a stable local order at an odd place | derived C′ (graded pieces + difference trick), then ranked sampled unit vectors mod `p` in PARI at seven pairs fixed in advance — exact linear algebra on a derivation-fixed list, a full rank being a proof |
| 6 | hunt band characters at high levels to see where CLG-e fails | derived LB/LB′ first, then **complete exact enumeration** of every character of four derivation-fixed towers (at the edge of the ban, as in stage 2; seconds) |
| 7 | search `f = 3`, `e = 2` towers for a band-7 character at level 5 (to refute or confirm (g3)'s `e = 1`) | not run (`729⁵` characters); recorded as a GAP in the lemmas instead |
| 8 | enumerate characters of `Γ₂₃`, `Γ₄₃` | replaced by the exact value-multiplicity formula (one count per norm class), brute-forced only as its own check |

## Stage 4 — SAVED (divergence table: J07's record `plans/FS91-S1D-character.md` against my phases 1–2)

*Opened after stage 3's commit (16272ed0). Sections read: 2.3–2.7, 3.1–3.3, 4.1–4.4. `plans/CRUNCH-2026-09-25-INDEX.md` not opened (fenced).*

| # | item | J07 | J10 (mine) | kind | resolution |
|---|---|---|---|---|---|
| 1 | Lemma C, `V_n ⊆ R ⊗ ℤ_p` | a Cayley–Hamilton projector `P(u)`, `u = c(a)/a`, `(a) = 𝔔^h`, kills every other place; `π_𝔔(M)` a ring with `u_𝔔^m` | from `cO′ ⊆ R` (J10-L1(e)) and `O′ ⊗ ℤ_p = ∏Ô × V_n` (`O′ = O_L[1/a]`) | route | both close; independent; same (d) |
| 2 | Lemma C′ | Teichmüller idempotent `(t − 1)^{(q²−1)p^r} → e_𝔓` + an element of valuation 1 (a contraction fixed point at inert dyadic) | graded pieces of the smooth torus span each `𝔓^m/𝔓^{m+1}`; the difference module is everything (`Σ_{μ_{q+1}}(z − 1) = 1` in char 2) | route | both close; **scope data added by me:** the ramified exception is realised at ℚ(√5), ℚ(√17), ℚ(α) (residue 𝔽₈) and **not** at ℚ(√2) — "except possibly" is exact; both conclude `R_F = O′` with no Galois hypothesis |
| 3 | (J) fibre density at `∞` | a coset of `U^M` and the open power map `z ↦ z^M` on `S¹`, `ℂ^×` | (W) with the finite places included: a fibre is `U` ∩ an open set | route | both close |
| 4 | CLG-d | unboundedness of `Re(az) + Re(b/z)` on `ℂ^×` | the same (J10-L4(iv)) | none | convergent, independent (J07 notes it repairs FS89-S0A-7 at complex places) |
| 5 | CLG_k ⟹ | extend `τ` from its image to `∏ O_𝔓/𝔓^K`, (W), peel | the same (J10-L3–L5) | none | convergent, independent; neither uses Lemma R or C′ |
| 6 | CLG_k "Hence" (`χ_char = min`) | from "the equivalence at every `k`", `H` cited as verified at every `k` | under `H_k` alone only when `χ_char(F²) ≤ k` | scope (wording) | moot given J01-7; statement 13 should read "given `H` at every band" (or at `χ_char(F²)`) |
| 7 | LB step 3 | the socle `𝔭^{L−1}/𝔭^L` and a `p^b` rescaling | trace duality: some `s` has `v(Im(ws)) = v(w)` | route | both give `a = ⌈⌊L/2⌋/e⌉` |
| 8 | CLG-e at `k = 2p` | TRUE (LB′: values in `p^{−E}ℤ`, `p` odd) | phase 1's J10-L6 had only `2p > k`; phase 2 re-derived J07's sharper form | scope (mine weaker, both true) | adopt `k ≤ 2p`; V3's verdict unaffected |
| 9 | CLG-g (E2)'s Hoffman floor at level `m` | G54's all-levels ratio (stated for Galois rings; recomputed at 2) applied at `Q ≥ 64`, where `F_𝔭` may be ramified over ℚ₂; the odd `q = p^f` analogue "sketched, one mind, not relied on" | **J10-L8 proves it for every inert tower, odd or dyadic, `F_𝔭` ramified or not** (new character: `|λ| ≤ cQ^{j−1}`) | input scope | J07's CLG-g stands with J10-L8 as the named input |
| 10 | (g3) at `k = 7`, (E1) | "`q = 3^f`, `f ≥ 3`, `e(𝔭|3) = 1`, exact level 3 only" (4.2: "for `e ≥ 2` level 2 is impossible") | LB′ leaves exact level **`2e + 1` open at every `e`** (tool (G)); at `f = 1` the true best margins at `(e, L′) = (1, 3)` and `(2, 5)` are both `1/27`, so nothing separates `e ≥ 2` | **truth (GAP in J07)** | correct to "exact level `2e(𝔭|3) + 1`" unless a further lemma kills `e ≥ 2`; J07 checked level 2 at `e ≥ 2`, not level `2e + 1` |
| 11 | (g3), (E2) at `k = 7` | `Q = 64` only (G56's floor 8 at 128) | same; Weil alone gives floor 6.7 at 128, the exact `λ_min(U₁₂₈) = −19` (floor 7.79) is needed — recomputed | none | convergent |
| 12 | level-one inputs (20) | complete lists of `q²` characters at the named `q` | one count per norm class by `1 − η(t² − 4N)` (brute-forced as its own check) | route | convergent; my by-products: `Γ₁₉` has a band-5 character, `Γ₁₁` none |
| 13 | HD1 via CLG | inputs 13, 17, 20, 12, Lemma D | J10-T4 (phase 1): `H₄`, S0A-8, Lemma D, J10-L7 | none | **two independent derivations**; both drop FS-66's certificates, `[Zhang2012]`, Lemma R |
| 14 | HD1 as a consequence of CLG_k's *statement* | stated "via CLG" with the route's inputs | phase 1: GAP from the statement, closed from the route | none (wording already right in J07) | the plan's CLG-f "fall out" should say "from CLG's proof with Lemma D" |
| 15 | C-47, C-167 | via CLG, no certificate | the same (J10-T5), band-5 at 23, 43 by the multiplicity count | none | convergent |
| 16 | Fischer control | existing checker, level 3 at `𝔓₁` | the same checker | none | one checker, **not** an independent confirmation |
| 17 | `θ₂` control "at level 1" | the survivor is the ramified dyadic place at level 1 | a level-1 band-2 character exists there; the route's extension returns *some* level-`K` character | scope (wording) | harmless |
| 18 | CL3–CL5 under the wide `A` | every proof step checked: S0A-8 step 2, S0A-9 step 3, dB-Theta's density read both real places | conclusions re-derived; proof text checked at S0A G3 step 3 only | coverage | J07's check is the fuller one; convergent |
| 19 | ramified dyadic at `k = 3` | not decided; harmless (`L = 2`) | not claimed; V3 treats ramified dyadic as `L ≤ 2` | none | convergent |

**Summary of the divergences.** One difference of **truth**: (g3)'s "`e(𝔭|3) = 1`" (row 10) is not supported by J07's lemmas — GAP, with the
supported form "exact level `2e(𝔭|3) + 1`". One **input-scope** difference closed by a new lemma: CLG-g (E2)'s all-levels ratio (row 9, J10-L8).
Two **wording/scope** notes (rows 6, 17). Everything else is **convergent**, mostly by different routes (rows 1–3, 7, 12): Lemma C, C′, CLG-d,
CLG_k, LB, LB′, CLG-e, CLG-g, HD1, C-47, C-167 and the controls now each have two blind derivations; the Fischer control has one checker.

### 4.1 The would-have-searched-here log (stage 4)

| # | the move I would have made by search | what I did instead |
|---|---|---|
| 9 | search a `q = 3^f`, `e = 2` tower for a band-7 character at level 5 to settle row 10 | not run (out of the ban and out of reach: `729⁵` characters); row 10 recorded as a GAP in the lemmas |
