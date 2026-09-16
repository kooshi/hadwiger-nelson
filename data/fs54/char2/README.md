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

**Open: is U_64 six- or seven-colourable?** `tools/fs54_char2_q64_sat.py 6 <conflicts>` and `… 7 <conflicts>` (CaDiCaL,
clique pin plus colour precedence) were launched 2026-09-16 at 20,000,000 conflicts each; their verdicts, when recorded,
go here. A six-colouring would make U_64 the first six-chromatic residue target, realised only by fields of degree ≥ 12.
