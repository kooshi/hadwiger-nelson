# FS-73 C3 competition — Coxeter's scripts (exact checks of derived statements; no solver search)

Every script is untrusted, as `CLAUDE.md` says of `tools/`. The theorems are in `plans/FS73-C3-Coxeter.md` §3, and these
scripts only check what those theorems predict. Python 3.14 with sympy 1.14 and scipy 1.18 (HiGHS).

| script | what it checks | command | cost (desktop) |
|---|---|---|---|
| `dist3.py` | H-i in rank 1: `G(Z,D)` 3-colourable (1-D SFT cycle) ⟺ `∃θ ‖θd‖ ≥ 1/3` | `python3 dist3.py 11` | seconds |
| `q11d.py` (+ `theta2.py`, `exact_tree.py`) | ℚ(√11) `Λ₁₀`: `Θ` = 16 isolated additive points (exact rational simplex); `F = 3Λ` | `python3 q11d.py` | ~2.5 min, 150 MB |
| `shapes.py` | `Θ` for FS-61 shapes `M|HNF` over `ℚ(√d)`, frame-based float tree | `python3 shapes.py 30 "1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 11 59` | seconds to minutes |
| `ctl.py` (+ `lllbb.py`) | the same with an LLL basis and a direct tree on `θ ∈ [0,1]^4` | `python3 ctl.py "60|5,0,0,1;0,1,5,0;0,0,10,0;0,0,0,2" 95 45` | < 1 min |
| `find167.py` | first nonempty cell of `Θ` for ℚ(√167) survivors, then an exact rational check | `python3 find167.py 348 167 100` | ~60 s |
| `walls1d.py`, `walls2.py`, `pf.py` | rank-1 colouring shifts as 1-D SFTs: recurrent classes, walls, `P` vs `F` | `python3 walls2.py 4 10`; `python3 pf.py 1,5,7,10 40` | seconds to a minute |
| `walls_scan.py`, `scan12.py` | resumable scans for four-colour walls with `P ≠ 0` | see the plan file §4 C-6 | under the lock |

The colouring of `Ld14c588b` is in `data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json`. The owner verified it
independently.
