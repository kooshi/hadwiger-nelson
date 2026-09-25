# J07 — lemma statements, for the blind verifier's second phase (statements only; no proofs)

*Source: `plans/FS91-S1D-character.md` (J07, FS-91 crunch M1), 2026-09-25. Each line is the statement as used; grades are J07's claim,
not a verdict. Characters only throughout — nothing here is about `χ(F²)`.*

**Notation.** `F` a real number field (finite degree, `F ⊆ ℝ`; other embeddings may be complex), `L = F(i)`, `c` complex conjugation,
`U = U_F = {u ∈ L : u·c(u) = 1} = T(F)` with `T = R¹_{L/F}𝔾_m`, `R = R_F = ℤ[U]`. A **stable place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`;
`𝔭 = 𝔓 ∩ F`; `T(F_𝔭) = {x ∈ L_𝔓 : x·c(x) = 1}`; `S_{𝔓,m}` its image in `O_𝔓/𝔓^m`; `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`.
`B_β = {z ∈ ℝ/ℤ : ‖z‖ ≥ β}`, `0 < β ≤ ½`, `B_k = B_{1/k}`; `Θ_β(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B_β}`; a band-`β` character of a Cayley
graph `Cay(G, S)` is a homomorphism `λ : G → ℝ/ℤ` with `λ(S) ⊆ B_β`. `A(R_F) = {ℓ mod 1 : ℓ ∈ Hom_ℚ(L, ℝ)}` (every archimedean place of
`L`). `T_N(R_F)`: characters killed by `N`. `H_k`: `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every `F ⊆ ℝ`, some finite `N_k` (input:
J03a-8 / J01; not J07's). `L(F)`: the least `χ` of the level-one residue targets of the stable places (`Γ_q` at odd, `U_Q` at inert dyadic,
a matching at ramified dyadic ones).

1. **U1.** `U ⊆ O_𝔓^×` for every stable `𝔓`; hence `R ⊆ O_𝔓` (the localisation). [hand]
2. **U2.** `R ⊗ ℚ = L`. [hand]
3. **U3.** `−1, i ∈ U`; so `λ(S_{𝔓,m})` is symmetric for every character `λ`. [hand]
4. **CLG-a.** A band-`β` character of `T_{𝔓,m}` composed with the reduction `R → O_𝔓/𝔓^m` lies in `Θ_β(R_F)`; no hypothesis on `F` or `𝔓`. [hand]
5. **CLG-b.** For `0 < β ≤ ½`, `X, Y ⊆ ℝ/ℤ`, `X = −X`, `X + Y ⊆ B_β`: if some `x ∈ X` has `‖x‖ < β`, then every `y ∈ Y` has `‖y‖ ≥ β + ‖x‖`. [hand + tools exact]
6. **CLG-b_n.** If `X_1 + ⋯ + X_n ⊆ B_β` with every `X_j` non-empty and symmetric, some `X_j ⊆ B_β`. [hand]
7. **Lemma C.** For every real number field `F` and prime `p`: inside `L ⊗ ℚ_p = V_s × V_n` (stable and non-stable primes above `p`),
   `R ⊗ ℤ_p = R̄_p × V_n`, where `R̄_p`, the closure of `R` in `∏_{stable 𝔓|p} Ô_𝔓`, is an open subring of finite index; hence
   `R/p^jR ≅ R̄_p/p^jR̄_p` for all `j`, `R/NR ≅ ∏_{p|N} R̄_p/NR̄_p`, `dim_{𝔽_p} R/pR = Σ_{stable 𝔓|p} [L_𝔓 : ℚ_p]`, and for every `N` there is
   `K` with `R ∩ ∏_{stable 𝔓|N} 𝔓^K ⊆ NR`. No Galois hypothesis. [hand, one mind]
8. **Lemma C′.** `R̄_p = ∏_{stable 𝔓|p} Ô_𝔓` (equivalently `R/NR ≅ ∏_{stable 𝔓|N} O_𝔓/NO_𝔓` for `N` a power of `p`) for every `p`, except
   possibly `p = 2` when some stable dyadic place is ramified in `L/F`; inert stable dyadic places always split off as full factors. No
   Galois hypothesis. [hand, one mind]
9. **(W) Weak approximation.** For every finite set `Σ` of places of `F` (archimedean included), `U` is dense in `∏_{v∈Σ} T(F_v)`; at a real
   place `T(F_v) = S¹`, at a complex place `T(F_w) = {(z, 1/z)} ≅ ℂ^×`. [hand; standard]
10. **(J) Joint image (CLG-c, corrected form).** The image of `U` in `R/NR` is the image of `∏_{stable 𝔓|N} T(F_𝔭)`; when no stable place
    above `N` is ramified dyadic it is `∏_𝔓 S_{𝔓, v_𝔓(N)}` under Lemma C′'s isomorphism; every fibre of `U → R/NR` is dense in
    `∏_{w|∞} T(F_w)`. [hand]
11. **CLG-d.** If `θ = τ + (ℓ mod 1) ∈ Θ_β(R_F)`, `τ` torsion, `ℓ ∈ Hom_ℚ(L, ℝ)`, then `ℓ` vanishes on `L ⊗_F F_w` at every complex place
    `w`, and `τ(U) + [−r, r] ⊆ B_β` with `r = Σ_{w real} |e_w|` (`ℓ_w(z) = Re(ē_w z)`); in particular `τ ∈ Θ_β(R_F)`. Every real number field. [hand]
12. **Lemma AV.** A band-`β` character of a finite Cayley graph `Cay(G, S)` forces `α(Cay(G, S)) ≥ β|G|`. [hand]
13. **CLG_k.** Given `H_k`, for every real number field `F` and `k ≥ 2`: `Θ_k(R_F) ≠ ∅` iff some stable `𝔓` and level `m` carry a band-`k`
    character of `T_{𝔓,m}`; `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`; a character `k`-colouring of `F²` exists only if some `T_{𝔓,m}` is
    `k`-colourable. Inputs: `H_k`, 1–3, 6, 7, 9, 11. [hand]
14. **CLG, converged form.** Given `H_β` at every band: `κ(R_F, U_F) = max_{stable 𝔓} κ_loc(𝔓)`, `κ_loc(𝔓) = sup{β : some T_{𝔓,m} has a
    band-β character}`, the maximum attained; `χ_char = ⌈1/κ⌉`. [hand]
15. **Lemma LB.** At a stable `𝔓` over odd `p`, `e = e(𝔭|p)`: a band-`β` character of `T_{𝔓,m}` of exact level `L ≥ 2` has
    `2β·p^a ≤ 1`, `a = ⌊(⌊L/2⌋ − 1)/e⌋ + 1`. [hand + tools exact]
16. **Lemma LB′.** In 15, moreover `2β·p^E ≤ p^{E−a} − 1` with `E = ⌈L/e⌉`. So at `e = 1` level 2 needs `k ≥ 2p²/(p−1)` and level 3 needs
    `k ≥ 2p³/(p²−1)`; at `e ≥ 2` level 2 never occurs. [hand + tools exact]
17. **CLG-e.** At a stable place over odd `p`, every band-`k` character of `T_{𝔓,m}` factors through `T_{𝔓,1}` whenever `k ≤ 2p`; at an
    inert stable dyadic place the same for `k = 3`; `U_Q` (level one, inert dyadic) has no band character at all. Ramified dyadic at
    `k = 3`: not claimed. [hand + tools exact]
18. **CLG-g.** Given `H_k`, `k ≥ 3`, `F` a real number field, `Θ_k(R_F) ≠ ∅`: then `L(F) ≤ k`, unless every stable place carrying a band
    `k`-character carries it only above level one and is (E1) odd with residue field `𝔽_{p^f}`, `f ≥ 3`, `2p < k < χ(Γ_{p^f})`, or (E2)
    inert dyadic of norm `Q ≥ 64` with `k < χ(U_Q)` and `k ≥` `U_Q`'s Hoffman floor (G54's all-levels ratio used). Inputs add G56's
    four-colourings of `U_Q`, `Q ≤ 32`, and Brooks's bound `χ(Γ_p) ≤ p + 1`. [hand; tools-grade inputs named]
19. **CLG-g corollaries.** (g1) no exception at `k ≤ 5`; (g2) no exception for `[F : ℚ] ≤ 2` at any `k`; (g3) at `k = 6` only (E2) with
    `Q = 64`; at `k = 7`, (E1) only at `q = 3^f`, `f ≥ 3`, `e(𝔭|3) = 1`, exact level 3, and (E2) at `Q = 64`. [hand]
20. **Level-one inputs.** For prime `q ≡ 3 (mod 4)`: `Γ_q` has no band-4 character for `q ≥ 11` (middle half against Weil; exact at
    11–59); no band-5 character at `q ∈ {23, 43, 59}` (exact) or `q ≥ 67` (Lemma AV with Hoffman–Weil). [hand + tools exact + external Weil]
21. **HD1 via CLG.** For ℚ(√59), ℚ(√83), ℚ(√131): every `θ ∈ Θ₄(R_F)` is `λ_D∘ρ_D` for the unique stable dyadic place `D`. Inputs: 13, 17,
    20, 12, and FS86-B1-LD (the dyadic tower Hoffman-tight at four colours at every level). Not used: FS-66's certificates, `[Zhang2012]`,
    Lemma R. [hand]
22. **C-47 via CLG.** `Θ₄(R_{ℚ(√47)}) = ∅`. Inputs: 13, 17, 20. [hand]
23. **C-167 via CLG.** `Θ₅(R_{ℚ(√167)}) = ∅`. Inputs: 13, 17, 20; no certificate. [hand + tools exact]
24. **Controls.** CLG returns: the ramified dyadic place at level 1 for `θ₂`; one dyadic place of K at level 3 for `[Fischer1994]`
    (existing checker `data/fs86/b1/fischer_vk_control.gp`); the stable place above 7 of ℚ(√11) at level 1 for C9; an `𝔽₃` or ramified
    dyadic place for every `θ ∈ Θ₃` (J02-T1's generalisation); `κ_loc(𝔓′) ≤ κ_loc(𝔓′ ∩ L)` for `F ⊆ F′`. [hand + tools]
25. **Under the corrected `A(R_F)`:** FS89-CL3, CL4, CL5 are TRUE; each FS-89 proof step already reads every real place; the narrow
    reading sits only in FS89-CL2's wording. [hand]
