# FS-89 Stage 1 — the blind verifier's record (verifier H, "V")

*De Bruijn (Opus 5.5), acting as the blind verifier, 2026-09-25. Brief: `data/fs89/briefs/S1-V-verifier-brief.md` (commit
bc22114d). Read before this record was opened: the brief; the plan `plans/FS89-rational-band-rigidity.md` §0.1–§0.3, §PA.1–§PA.2
and §IQ only; S0A's record up to the line "**Lemma N₀.**" (lines 1–65) and its C4 table header rows; S0B's record except §6
(lines 210–245). Not opened: S0A's proof of Lemma N₀ and the rest of S0A §C1 after it, S0B §6, the plan's §0.4, §PA.3–4, §S, §C.1,
anything of the derivation agent's, the close inventory.*

## C0 — predictions (a probability per statement, before any derivation was written)

Honesty note (the S0A verifier's form): these were written after reading the brief and the fenced sources above, and after a
few minutes of mental pass over the statements. For V-A1 that pass already contained the argument (a character torsion on every
`R_S` is determined by one rational, by the injectivity of `ℚ(i)` into each completion), so its number is a posterior of that
pass, not a prior of a blank mind. The others are priors.

| statement | predicted verdict | probability |
|---|---|---|
| V-A1 (U1: `RS₄(S)` for all finite `S ⊇ S₀` ⟹ RQ₄) | TRUE; the last step holds with no band input | 0.90 |
| V-A1's last step alone ("torsion on every `R_S` ⟹ torsion on `Q`") | TRUE | 0.90 |
| V-A2, N₀ (S0A-3) as quoted | TRUE | 0.80 |
| V-A2, U2 as quoted (the list and the four margins) | TRUE | 0.60 (the likeliest failure: an order-8 type with margin 1/8, or a 2-part of order 16) |
| V-A3 (S0B-T6, a second prime kills every rational heteroclinic with torsion difference prime to 13), in the form I derive | TRUE | 0.55 |
| V-A4 (a rank-`r` orbit model with one step rule per prime and a gluing condition; the `T + A` criterion "one leaf everywhere") | derivable as described | 0.85 |

## V-A1 — verdict: TRUE; the last step needs no band, no weak approximation and no bound from Lemma N₀

**Statement (quoted, the plan §0.3 U1):** "if `RS₄(S)` holds for every finite `S ⊇ S₀` (some fixed `S₀`), then RQ₄ holds." With the
brief's rider: if the last step ("a character of `Q` torsion on every `R_S` is torsion, or at least in `T + A`, given the band")
fails, say exactly how. It does not fail.

**Theorem V1.** Let `φ` be a character of `Q` and `𝒮` a family of finite nonempty sets of split primes, directed under inclusion,
with `⋃_{S∈𝒮} R_S = Q`. If `φ|_{R_S} ∈ T(R_S) + A(R_S)` for every `S ∈ 𝒮`, then `φ ∈ T(Q) + A(Q)`; more precisely `φ = τ + λ_e`
with one `e ∈ ℂ` and `τ` torsion of order equal to the order of `(φ − λ_e)|_{ℤ[i]}`. [hand, elementary]

*Proof.*
1. **One archimedean part.** Write `φ|_{R_S} = τ_S + λ_{e_S}`. For `S ⊆ S′` in `𝒮`, restricting the `S′` decomposition to `R_S`
   gives `λ_{e_{S′} − e_S} = τ_S − τ_{S′}|_{R_S}` on `R_S`, a torsion character in `A(R_S)`. `T(R_S) ∩ A(R_S) = 0` because `R_S` is
   `p`-divisible for any `p ∈ S` (nonempty): if `Nλ_c = 0` on `R_S`, then `N Re(c̄ p^{−k}) ∈ ℤ` and `N Re(c̄ i p^{−k}) ∈ ℤ` for all
   `k`, so `N Re c, N Im c ∈ p^kℤ` for all `k`, so `c = 0`. Hence `e_S = e_{S′}`, and by directedness one `e` serves every `S`.
2. **The torsion order is read on `ℤ[i]`.** Put `ψ := φ − λ_e`; then `ψ|_{R_S} = τ_S` is torsion for every `S ∈ 𝒮`. Let `N_S` be
   the order of `τ_S`. (a) `N_S` is prime to every `p ∈ S`: if `N_S = pM`, then for `x ∈ R_S`, `Mτ_S(x) = Mτ_S(p · x/p) =
   N_Sτ_S(x/p) = 0`, contradicting minimality. (b) The restriction `τ_S|_{ℤ[i]}` has order exactly `N_S`: let `M` be its order; for
   `x = y/s ∈ R_S` (`y ∈ ℤ[i]`, `s` a product of primes of `S`) choose `s′` with `ss′ ≡ 1 (mod N_S)`; then `(1 − ss′)x ∈ N_S R_S`, so
   `Mτ_S(x) = Mτ_S(ss′x) = s′·Mτ_S(y) = 0`, whence `M = N_S`. (c) All the restrictions `τ_S|_{ℤ[i]}` are the one character
   `ψ|_{ℤ[i]}`; so `N_S = N := ord(ψ|_{ℤ[i]})`, the same finite number for every `S`.
3. **Torsion on `Q`.** Every `x ∈ Q` lies in some `R_S`, `S ∈ 𝒮`, and there `Nψ(x) = Nτ_S(x) = 0`. So `Nψ = 0` on `Q`, and
   `φ = ψ + λ_e ∈ T_N(Q) + A(Q)`. ∎

**Corollary (U1).** If `RS₄(S)` holds for every finite `S ⊇ S₀`, then RQ₄ holds. [hand] *Proof.* For `θ ∈ Θ₄(Q)` and finite
`S ⊇ S₀ ∪ {5}`: `U_S ⊆ U_ℚ`, so `θ|_{R_S} ∈ Θ₄(R_S) ⊆ T + A`; the family `{S ⊇ S₀ ∪ {5} finite}` is directed, nonempty-membered and
exhausts `Q`; apply V1. ∎

**What the proof actually uses, and a sharper form.**
- **No band, no weak approximation, no Lemma N₀.** The planner's worry (a character torsion on every `R_S` with orders growing in
  `S`) cannot happen: the order of a torsion character of `R_S` is the order of its restriction to `ℤ[i]`, and that restriction is
  the same character for every `S`. The band enters only to make the restrictions band characters.
- **The equivalence it gives, which is the usable form.** RQ₄ ⟺ for every finite `S`, the *restriction image* `Θ₄(Q)|_{R_S}` lies
  in `T + A`. (⟸ is V1; ⟹ because restriction maps `T + A` into `T + A`.) The restriction image is the set of band characters of
  `R_S` that extend to band characters of `Q`; by compactness it is `⋂_{S″ ⊇ S} (Θ₄(R_{S″})|_{R_S})`, generally a proper subset of
  `Θ₄(R_S)`. So **U1's hypothesis is strictly stronger than what RQ₄ needs**: RS₄(S) asks about every band character of `R_S`,
  and `RS₄({5})` is false (S0B-T3/T4) while RQ₄ is open. If `RS₄(S)` fails for every finite `S` (U3's and U5's reading), U1 is a
  true implication with a false hypothesis and routes nothing; the restriction-image form is the one that can.
- **In adelic words** (the same fact): a character of `Q` has a representative `(e; (b_v)_{v∈S_all})` with every `b_v ∈ O_v`
  (partial fractions move finitely many poles into `Q`), restriction to `R_S` keeps the components at `S`, and `T + A` on `R_S` is
  "the components at `S` are the images of one `r ∈ ℚ(i)`" (S0B-T2's criterion, one prime at a time). Since `ℚ(i) → ℚ(i)_v` is
  injective, the rationals `r_S` for nested `S` coincide, so one `r` serves every split place. This is V1 again; the elementary
  proof above is the one the verdict rests on.

**Divergence table (against the planner's reason in §0.3).**

| step | the planner | V | kind |
|---|---|---|---|
| restrictions are band characters | yes | yes (`U_S ⊆ U_ℚ`) | agree |
| archimedean parts agree | by 5-divisibility, `T ∩ A = 0` (S0A-2) | by `p`-divisibility of `R_S` for any `p ∈ S`; needs `S ≠ ∅` | agree; `5` incidental |
| the last step | "a Lemma-N₀-type weak-approximation argument should bound its order"; flagged unverified | the order is `ord(ψ|_{ℤ[i]})`, independent of `S`, by one line of arithmetic; no band, no approximation | **simplification**: the step is not hard, and the bound comes from `ℤ[i]`, not from the band |
| usefulness | "if RS₄(S) for every finite S" | hypothesis likely false for every `S` (S0B at `{5}`; U3/U5 readings); the restriction-image form is an equivalence | **addition** |

## Would-have-searched-here log

(one line per move I would have made by search, and what I did instead)

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
