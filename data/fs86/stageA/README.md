# FS-86 stage A — the planner's spec checks (2026-09-24/25)

Seconds each, standard Python 3 + sympy/numpy; no solver, no search. Cited by `plans/FS86-dyadic-rigidity.md` §0, §S.1 and FS86-A1–A4.

| script | what it checks | output |
|---|---|---|
| `spec_checks.py` | splitting of p < 60 in Q(sqrt d), d in {59, 83, 131, 11, 167, 47}; stability (q = 3 mod 4); `3d = 1 (mod 8)` (Q2(sqrt d) = Q2(sqrt 3)) | `spec_checks.out` |
| `units.py`, `units_fast.py` | two enumerators of U_M (the (a,c) loop, FS81's; a (b,e) loop, vectorised), cross-checked at M = 30, 210, 2730 | — |
| `index.py` | rank, covolume of Lambda_M in the O-basis {1, i, w, iw}, w = (1 + i sqrt d)/2, and 1/p membership [exact] | `index_510.out` |
| `profile.py`, `inert.py` | level-one image targets at every prime of norm <= 59 where Lambda_M is integral; circle coverage [exact]; Hoffman ratio [float, aiming only] | `profile_510.out`, `inert_510.out` |
| `cover59.py`, `hoff59.py` | the ramified prime 59: image coverage for M = 2730, 46410 [exact]; Hoffman for Lambda_2730's image [float] | `cover59.out`, `hoff59_2730.out` |
| `rich.py` | the first profile of Lambda_2730 (superseded by the above; kept for provenance) | — |

Float numbers are aiming only; stage B (B3) certifies them exactly.
