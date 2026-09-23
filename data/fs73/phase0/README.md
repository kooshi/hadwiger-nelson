# FS-73 phase 0 — the planner's measurement (2026-09-23, desktop)

`degrey_lattice_spectrum.py` computes lambda(theta) = sum over U of cos(2 pi theta.u) for de Grey's K-lattice
<zeta6^m rho^n, |n| <= 2> (rank 4, 54 unit vectors; `klat.py` is lines 1-66 of `data/fs70/owner/po_kempe_control_K.py`, the
owner's construction, plus the 8/3 coordinates). It prints the minimum over every period-N quotient's characters (N = 2..12)
and a continuous minimum over T^4 (4,000 BFGS starts, seed 1). Run: `python3 degrey_lattice_spectrum.py .` (about a minute).
Output: `degrey_lattice_spectrum.out`. Reading (plans/FS73-rigidity-dichotomy.md §R0): slack as a lattice graph
(min -22.41 against -d/3 = -18); tight exactly at N = 2, 4, 6; the N = 5, 11 refusals (data/fs70/quotient/degrey-K-control.json)
are not spectral. [measured; floats; the N-table's exact values are algebraic numbers not certified here]
