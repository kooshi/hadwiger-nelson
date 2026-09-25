# J02 — the fixed claim list (statements only, no proofs), for J09's second phase

*Crunch job J02, 2026-09-25. Every lemma J02 proved, stated verbatim as in `plans/FS91-S0F-three-colours.md` (stages 2–3), with its grade.
No proof is given here. Notation: `F ⊆ ℝ` a field, `L = F(i)`, `c` complex conjugation, `U = U_F = {z ∈ L : z·c(z) = 1}`, `R = R_F = ℤ[U]`,
`Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ [1/3, 2/3]}`, `T₆` the characters killed by 6; a **stable** prime is a prime `𝔓` of `L` with
`c(𝔓) = 𝔓`; `𝒩(X) = {s ∈ X : s·c(s) = 1}` in a ring `X` with involution `c`.*

**Inputs used (not J02's):**
- FS81-T2 (for every `F ⊆ ℝ`, `χ(F²) ≤ 3 ⟹ Θ₃(R_F) ≠ ∅`).
- FS81-T3 (C1(5)) and FS81-T4 (the limit `τ`).
- GPT Astra's Lemma 1.1 and §3.1–3.3 (`reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md`).
- Weil's bound for the sums `Σ_{t ∈ μ_{q+1}} ψ(Tr(at))`.
- Row 52's residue bound; Astra's Thm 2.1; `χ(Γ₃) = 3`, `χ(Γ₇) = 4`.

---

**J02-L1 (torsion extraction) [hand; a composition of FS81-T3 and T4].** For every subfield `F ⊆ ℝ`: if `θ ∈ Θ₃(R_F)`, then
`τ(x) := lim_k θ(25^{−k}x)` is a character of `R_F` with `6τ = 0` and `τ(U_F) ⊆ {1/3, 1/2, 2/3}`, so `τ ∈ Θ₃(R_F)`.

**J02-L2 (the finite quotients `R/pR`) [hand; Astra's Lemma 1.1 and §3.1–3.2, extended to every prime].** Let `F` be a real number
field, `n = [L : ℚ]`, `p` a prime, `A_p = R/pR`.
- (a) `A_p` is a finite `𝔽_p`-algebra with `dim A_p ≤ n`, and `c` induces a ring involution on it.
- (b) Every maximal ideal `𝔪 ∋ p` of `R` equals `R ∩ 𝔓` for a stable prime `𝔓 | p` of `L`, and `c(𝔪) = 𝔪`, so `c` acts on the field
  `k_𝔪 = R/𝔪 ⊆ κ_𝔓`.
- (c) If `𝔓` is unramified in `L/F` (always for odd `p`), then `k_𝔪 = κ_𝔓 = 𝔽_{q²}`, `c` acts as its non-trivial involution with fixed
  field `κ_𝔭 = 𝔽_q` (`𝔭 = 𝔓 ∩ F`), and `𝒩(k_𝔪) = μ_{q+1}`.
- (d) If `𝔓` is ramified in `L/F` (so `p = 2`), `c` acts trivially on `k_𝔪` and `𝒩(k_𝔪) = {1}`.

**J02-L3 (the Teichmüller section and the joint lift) [hand; Astra §3.3 run on `R/6R`].** Let `F` be a real number field.
- For `p ∈ {2, 3}` let `T_p = {a^{p^M} : a ∈ A_p}`, with `M` divisible by every `[k_𝔪 : 𝔽_p]` and `p^M` above the nilpotency index of
  `A_p`'s nilradical. Then `T_p` is a `c`-stable subring of `A_p` with the same 1, and `T_p ≅ ∏_{𝔪 ∋ p} k_𝔪` compatibly with `c`.
- Put `T = T₃ × T₂ ⊂ A₃ × A₂ = R/6R`. **Every `s ∈ 𝒩(T)` is the image of a unit vector `u ∈ U`.** In particular the image of `U` in
  `R/6R` contains the product set `𝒩(T₃) × 𝒩(T₂)`.

**J02-L4 (norm-one functionals) [hand + external Weil; exact at `q = 27, 243` and `Q ≤ 32` by `tools/crunch_j02_additive_check.py`].**
- (a) For `q = 3^f`, `f` odd, an additive `λ : 𝔽_{q²} → (1/3)ℤ/ℤ` with `λ(t) ≠ 0` for every `t ∈ μ_{q+1}` exists iff `q = 3`.
- (b) For `Q = 2^f`, no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` equals 1/2 on all of `μ_{Q+1}`.

**J02-T1 (the torsion local–global theorem at three colours) [hand].** Let `F` be a real number field. A character `τ` of `R_F` with
`6τ = 0` and `τ(U_F) ⊆ [1/3, 2/3]` exists iff `F` has a stable prime above 3 whose residue field is `𝔽₃`, or a stable prime above 2
ramified in `F(i)/F`.

**J02-T2 (= S1) [hand; a composition].** For every real number field `F`, the following are equivalent:
- (1) `χ(F²) ≤ 3`;
- (2) `Θ₃(R_F) ≠ ∅`;
- (3) `Θ₃(R_F)` has a point of order dividing 6;
- (4) `F` has a stable prime above 3 with residue field `𝔽₃`, or a stable prime above 2 ramified in `F(i)/F`;
- (5) `L(F) ≤ 3`.

In particular `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`.

**J02-C2 (additive colourings) [hand; a corollary of J02-T1].** For every real number field `F`:
- `F²` has an additive 3-colouring in `[Fischer1990]`'s sense (a homomorphism `R_F → ℤ/3` non-zero on `U_F`) iff `F` has a stable prime
  above 3 with residue field `𝔽₃`;
- `F²` has an additive 2-colouring iff `F` has a stable prime above 2 ramified in `F(i)/F`.

**J02-T3 (= S2) [hand; a composition].** For every real number field `F` with `L(F) ≤ 4`, `χ(F²) = L(F)`.

**J02-C1 (= S3) [hand + tools exact (PARI)].** For `F = ℚ(α, √7)`, `α³ = α + 1`: `Θ₃(ℤ[U_F]) = ∅`, `χ(F²) = 4` and `L(F) = 4`.
The arithmetic used:
- `F` has signature `[2, 2]`;
- its two primes above 3 have `e = 1`, `f = 3`, are inert in `F(i)` and have residue field `𝔽₂₇`;
- its one prime above 2 has `e = 2`, `f = 3` and splits in `F(i)`;
- one prime above 7 has `e = 2`, `f = 1` (residue field `𝔽₇`) and is inert in `F(i)`; the other has `e = 2`, `f = 2` and splits.

**Also stated (a second derivation of a known theorem) [hand].** GPT Astra's Thm 2.1, direction ⟹: if `F²` is bipartite, `F` has a
stable prime above 2 ramified in `F(i)/F` — via J02-L3 and J02-T1's step 5 applied to the walk-parity character.
