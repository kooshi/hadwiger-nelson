# data/fs54/char2 — the residue graphs at an inert prime above 2

`U_Q = Cay(F_{Q^2}, mu_{Q+1})`, Q a power of 2: the target of a prime of F above 2 that is INERT in F(i) (FS-54 §1.5).

| Q | spectrum / Hoffman | chromatic number | source |
|---|---|---|---|
| 2, 4, 8, 16, 32 | floors 4, 2.67, 4.00, 3.43, 4.00 | **4** (colourings found and verified on every edge; 3 refused at Q = 4 by CaDiCaL) | `tools/fs54_char2_residue.py` → `../char2-residue.out` |
| **64** | λ_min = −15, **Hoffman χ ≥ 5.33 → ≥ 6**, α ≤ 768 (six needs 683) | **6 ≤ χ ≤ 8**: a LINEAR 8-colouring exists (three F_2-functionals 20, 2969, 1084 on the polynomial basis of `poly64.txt`; every unit vector has a nonzero image); DSATUR gives 19 | `tools/fs54_char2_spectra.py`, `tools/fs54_char2_q64_colour.py` |
| 128 | λ_min = −19, Hoffman χ ≥ 7.79 | ≥ 8 | `tools/fs54_char2_spectra.py` |

The field arithmetic in `fs54_char2_spectra.py` is carry-less multiplication modulo an irreducible trinomial, found and
checked in the script; `mu{Q}.npy` is {x : x^{Q+1} = 1}. **An earlier exp-table build gave a spurious λ_min = −129 at
Q = 128** (its "primitive polynomial" was not): discard any Q = 128 number not from the carry-less rebuild.

**Open: is U_64 six- or seven-colourable?** What is known (2026-09-16):

| instrument | result | trust |
|---|---|---|
| nauty | \|Aut(U_64)\| = 3,194,880 = 4096 · 65 · 12 exactly — translations, μ₆₅ rotations, the 12 Frobenius powers; nothing hidden | exact |
| Delsarte LP / ϑ′, reduced to the 64 norm classes (`tools/fs54_char2_q64_lp.py` → `lp-q64.out`) | **768.0**, exactly the Hoffman bound — the linear-programming route gains nothing | float LP, no certificate needed (it refuses nothing) |
| KaMIS `redumis`, 6 seeds (`tools/fs54_char2_q64_kamis.py`, records `kamis-q64-seed{0..5}.json`) | **512 on all six**, every set verified independent; translation stabilisers of dimension 4, 5, 5, 5, 6, 5 — so not the dimension-9 classes of the linear 8-colouring, but the same size | *found*: α ≥ 512 only |
| derivation | an independent set periodic under an 𝔽₂-subspace of dimension ≥ 8 has **at most 512** points: its 16-vertex cube-like quotient has α ≤ 2, since an independent triple spans an independent subgroup of order 4 whose four cosets would four-colour U_64 (Hoffman forbids) | proof |
| derivation | a **683-set** (a six-colour class) must put **≥ 50.2 %** of its nontrivial Fourier energy on the 195 characters with λ = −15 (the energy's weighted mean eigenvalue must be −13.008); a 586-set (seven colours) is forced nothing. The six KaMIS sets carry 36–44 % there, and 5–9 % on λ = +13 | proof; measured |
| CaDiCaL, k = 6 and k = 7, 20 M conflicts, clique pin + colour precedence (`tools/fs54_char2_q64_sat.py`) | **stopped by pid after 3 h 33 m with no verdict** (the script prints only at the end): a refutation needs Hoffman-strength counting, which resolution does not find even at 361 vertices (`data/fs50/nscale/`), and a colouring needs classes of 683 / 586 against a plateau of 512 | nothing — measures the encoding, not the graph |

**Reading, not a claim:** 512 = 4096/8 is an attractor; if α(U_64) = 512 then χ(U_64) = 8 exactly (the linear 8-colouring
exists) and U_64 is not in the window. **The one bound with a real chance:** the three-point (Schrijver) SDP refuses six if
it reaches 682/768 = 0.888 of Hoffman — the odd planes' measured reaches are 0.797–0.931, five of nine below 0.888; refusing
seven needs 0.762, never seen. It needs a characteristic-2 port of the block SDP and its exact checker (G₀ = μ₆₅ ⋊ C₁₂,
order 780; real blocks of size ≤ 64). A six-colouring would make U_64 the first six-chromatic residue target, realised only
by fields of degree ≥ 12.
