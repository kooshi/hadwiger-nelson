*Instance file for job **FS112-YB3**, the round-3 blind verifier of FS-112's construction side. Its brief is
`data/fs112/briefs/YB112-verify-construction.md`; this file is part of it and overrides it where they differ. Filled in by the owner on 2026-09-27, when
FS112-Y3 handed back. Each item below is the side's claim, quoted verbatim from its "Theorems this phase proved" table; its grade is withheld.*

## Overrides of the brief for this instance

- **Your job id** is FS112-YB3; **your record** `plans/FS112-YB3-verification.md`; **your working directory** `data/fs112/fs112-yb3/`; **your tools**
  `tools/fs112_yb3_*.py`; **your commit subjects** "FS112-YB3: stage n"; **your report** `data/fs112/reports/FS112-YB3.md`; **your scratch** `scratchpad/fs112-yb3/`.
- **The side verified:** round 3 of the construction side, FS112-Y3 — `plans/FS112-Y3-construction.md`, `tools/fs112_y3_*.py`, `data/fs112/fs112-y/y3_*`. **All
  fenced until your step 3 is committed.** Open to you: `plans/FS112-Y-construction.md` in full (rounds 1–2, including Y2's section), both finished
  construction-side verifiers (`plans/FS112-YB-verification.md`, `plans/FS112-YB2-verification.md`, their reports, directories and tools — run YB2's tower
  checker, never edit it), and card R's text only as the side's record quotes it after your step 3.
- **Also fenced:** every advisor's record and working directory (`data/fs112/fs112-a2/`, `data/fs112/fs112-a3/`); the proof side's files and its verifiers'.
- **Machine:** anything over about 2 minutes or 2 GiB runs under `scripts/slot.py` (standing rule 8; the side slipped on this once).

## What to do

1. **Rebuild the two chain-end fragments (Y3-END-A, Y3-END-B) from their defining words below, and check each exactly** with your own checker or YB2's.
2. **Check the two pinned-corner obstructions (Y3-STRIPCUT on the strip, Y3-DISK-T* and Y3-LEG on the disk) on your own rebuilds or YB/YB2's objects** —
   exactly where the claim is exact, by derivation where it is hand.
3. **Derive or refute the hand claims: Y3-END-NEEDS first** (the proof side's stuck-ray question rests on it — audit it at the rate of a result you would want
   false), then Y3-T2-BUDGET, Y3-R3, Y3-R1.

## The claims, verbatim

- **Y3-END-A:** "a finite stuck chain `P_0, P_1, E = P_2` with C-CHAIN-9's recursion taken with equality from the end (upper arcs on the circles about `N = P_3` of radii 3, 2, 1 — the unit arc at `E` — lower boundaries the lines `y = k`), `N`'s neighbourhood completed by colours 1 (below), 3 (top, directions `[45°, 135°]`), 4 (two wedges tangent to `a`): valid, arc-closed at the unit arcs' ends, `P_1` and `E` stuck (no MERGE, MERGE-RAY or SHAVE), and a MERGE of colour 4 available at `N`"
- **Y3-END-B:** "the same chain with `N` a five-colour vertex `{1, 3, 4, 5, 6}` (colour 4 a double horn at `N`, flanks 5 and 6, and a colour-4 tile at `N + n` on the concentric circle making `D_4(N)` the line): valid, no MERGE at `N`, and a SHAVE of `N`'s 4-horns by their lower flank available"
- **Y3-END-NEEDS:** "what the end's unit-arc centre `N` needs, with `E`'s type `{g, c, h}`: to keep `E` stuck, `c` at `N` in the pinch `[δ, 180° − δ]` and `h` tangent to `±a` at `N` (so `h` in two sectors); to block the MERGE there, `h`'s sectors horns and two upper flank colours outside `{g, c, h}`, so `|P_cl(N)| ≥ 5`; to block the SHAVE too, the horns' upper arcs unit arcs of `ω(N + n)` and, at `N + n`, two distinct upper flank colours outside five used colours — a seventh colour. **So a stuck chain cannot end at a unit arc in a terminal map while `E` has three colours**"
- **Y3-STRIPCUT:** "the strip's stop `Q = (1/4, top)` cannot be passed by cutting `C_{−1}` and `C_2` along `ω(Q)`: `ω(Q)` runs corner to corner through each (`(−3/4, top)` to `A_{−1}`'s apex; `(5/4, top)` to the apex `A_1`); the outer part holds the valley's forced 4-sector; at every named point of both tiles on and beside the cut, 4 is the only colour no other tile forbids — so the cut also needs a change to a midline arch or to `C_{−3}` or `C_1`"
- **Y3-DISK-T*:** "Y2's GAP answered NO: no change near `Z^L_0` lets `T*` be blue; `T*` holds `q2 = Z^L_0 − (1, 0)` (`ω(C_0) ∩ ω(Z^L_0)`, the other point `D_0`); `|q2 − Y_0|² < 1`, so `T2_0` must vacate `B(q2, 1)`, a region from `Z^L_0` to `Y_0` and to `K = C_0 + e(276°)` on the leg `Y_0A_0`; at 7 named points of it no colour is admissible with the move's other tiles in place, so yellow's route to `C_0`'s wedge also needs a change to one of `C0`, `R_0`, `T2_1`, `U′_4`, `T1_4`, `T1_0`"
- **Y3-LEG:** "on the disk the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2 = Z^L_0 − (1, 0)`: `|A_0 − q2|² = |A_0 − C_0|² = φ²`; both points of `ω(C_0) ∩ ω(q2)` lie on the leg's line"
- **Y3-R1:** "card R's R1 holds: along any sequence obeying C-CHAIN-9's two inequalities, `λ` and `υ` are non-decreasing and two consecutive terms are equal only when both are 0; a chain infinite toward `+k` has every `λ_k < 0`, toward `−k` every `υ_k > 0`, so a one-sided infinite chain has infinitely many distinct horn radii; a map with finitely many arc radii (every doubly periodic map) has no one-sided infinite chain, and its chains have length at most `3V + 3`, `V` the number of signed curvature values its arcs can present"
- **Y3-R3:** "at both held positives every close complementary pair of vertices is saved at one common unit point by a four-colour vertex at which both members emit arcs of its unit circle (half of T2), and at both points exactly when it is a rhombus completion (the strip's `(V_m, V′_m)`, `(A_j, A′_j)`: T2 twice) — the unsaved second points are the stop points (the strip's edge vertices, the disk's rim point `C_0` and the point `w*` beyond it); the disk adds `(A_0, y)`, `y` a ring change point, saved at both by (S1)"
- **Y3-T2-BUDGET:** "if a close complementary pair `(u, v)` with `u` trivalent is saved by T2 at both common unit points, then `v = w_i + w_j − u` for two of the at most three centres `w_i` of unit arcs `u` emits; so a trivalent vertex has at most three such partners, at determined places, and a pattern saving every close complementary pair by T2 at both points has every such pair a rhombus completion — which the strip in its printed colouring cannot meet (its `(V, A)` pairs are complementary and not completions; whether some other colouring of the strip's geometry avoids them is not claimed)"

Where a symbol (`N`, `E`, `q2`, `T*`, `T2_0`, `Y_0`, `Z^L_0`, `C_k`) is defined only in the fenced record, use YB2's labels for the disk (`plans/FS112-YB2-verification.md`)
and YB's for the strip, and name the reading you take.

**After step 3 is committed:** read Y3's record and tools, and list every divergence with both addresses (your brief's step 4).
