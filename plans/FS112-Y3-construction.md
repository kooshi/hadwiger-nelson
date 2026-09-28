# FS112-Y3 — the construction side of FS-112 (the unit-arc half), round 3

*Job FS112-Y3, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `4609152f`. Brief: `data/fs112/briefs/Y3-112-construction-round3.md`, on
`data/fs112/briefs/Y112-construction.md` as amended by `data/fs112/briefs/Y2-112-construction-continued.md`, with `data/fs112/briefs/STANDING-RULES.md`.
This record is a new file (the brief's rule: FS112-YB2 reads Y's record while it works and must not see round 3). It continues FS112-Y's and FS112-Y2's
record `plans/FS112-Y-construction.md` and never rewrites a verdict there; where I disagree with one I say so here. Working files:
`data/fs112/fs112-y/y3_*`; tools `tools/fs112_y3_*.py` (earlier tools run, never edited). Every fragment below is **a local fragment, not a map**.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| Y3-R1 | card R's R1 holds: along any sequence obeying C-CHAIN-9's two inequalities, `λ` and `υ` are non-decreasing and two consecutive terms are equal only when both are 0; a chain infinite toward `+k` has every `λ_k < 0`, toward `−k` every `υ_k > 0`, so a one-sided infinite chain has infinitely many distinct horn radii; a map with finitely many arc radii (every doubly periodic map) has no one-sided infinite chain, and its chains have length at most `3V + 3`, `V` the number of signed curvature values its arcs can present | hand, one mind; arithmetic only | §1.4 |
| Y3-STRIPCUT | the strip's stop `Q = (1/4, top)` cannot be passed by cutting `C_{−1}` and `C_2` along `ω(Q)`: `ω(Q)` runs corner to corner through each (`(−3/4, top)` to `A_{−1}`'s apex; `(5/4, top)` to the apex `A_1`); the outer part holds the valley's forced 4-sector; at every named point of both tiles on and beside the cut, 4 is the only colour no other tile forbids — so the cut also needs a change to a midline arch or to `C_{−3}` or `C_1` | tools, exact at 15 named points; the case split hand, one mind | §2.1 |
| Y3-DISK-T* | Y2's GAP answered NO: no change near `Z^L_0` lets `T*` be blue; `T*` holds `q2 = Z^L_0 − (1, 0)` (`ω(C_0) ∩ ω(Z^L_0)`, the other point `D_0`); `|q2 − Y_0|² < 1`, so `T2_0` must vacate `B(q2, 1)`, a region from `Z^L_0` to `Y_0` and to `K = C_0 + e(276°)` on the leg `Y_0A_0`; at 7 named points of it no colour is admissible with the move's other tiles in place, so yellow's route to `C_0`'s wedge also needs a change to one of `C0`, `R_0`, `T2_1`, `U′_4`, `T1_4`, `T1_0` | tools, exact (identities, 17 changed pairs twice, 11 named points) + hand, one mind | §2.2 |
| Y3-LEG | on the disk the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2 = Z^L_0 − (1, 0)`: `|A_0 − q2|² = |A_0 − C_0|² = φ²`; both points of `ω(C_0) ∩ ω(q2)` lie on the leg's line | tools, exact (and 170 digits in sympy for the second point) | §2.2 |

## Fence log (standing rule 13; the three briefs' fences)

1. Start-up, first minute: `ls data/fs112/briefs/` with `wc -c` printed the **file names and sizes** of the fenced briefs (A112, A2-112, A3-112, N112,
   N2-112, N3-112, NB112-instance, NB112-verify-proof, NB2-112-instance, P112, PA112, YB112-*, YB2-112-instance); none was opened.
2. Same minute: `ls data/fs112/reports/` printed the **file names** of fenced reports (FS112-A, FS112-A3, FS112-N, FS112-N2, FS112-NB, FS112-NB2,
   FS112-P, FS112-PA) beside the open ones (FS112-Y, FS112-Y2, FS112-YB); none of the fenced ones was opened. `ls data/fs112/` printed directory names
   (among them `fs112-a2`, `fs112-a3`, `fs112-n`, `fs112-nb`, `fs112-nb2`, `fs112-p`, `fs112-pa`); none was listed or opened.
3. My scratch directory is `scratchpad/fs112-y3/` in this session's harness scratchpad; nothing else there was listed or opened.

## Would-have-searched-here log (standing rule 3)

- Stage 2, the disk: I would have scanned positions of `M` (T2_0's new side) and of `U_0`'s closing point beyond the rim until the checker
  accepted; instead each was derived (the side's direction bound 270° from `q2`'s tangent; the closing point inside `B̄(Y_0, 1)`, one named point
  `e(162° + 2 atan(1/28))`), and when the derived choice failed the failure was diagnosed to a named distance (`|q2 − Y_0|`, `|M − q2|`), not retried.
- Stage 2, both corners: I would have sampled a grid of points for "no colour"; instead free sets at named points on rational parametrisations of
  the relevant circles, each blocker named.

## Stage 1 — SAVED: reading, quotation check, step 0, card R's R1

### 1.1 Read from disk

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (at `4609152f`: link 2 carries one more sentence of attribution than my
context's snapshot) and G82 from disk (the other grokkings the brief names as in my snapshot); the three briefs; `plans/FS112-Y-construction.md` in full
(Y's stages 1–2, Y2's stages 3–7, closely); the reports `FS112-Y.md`, `FS112-Y2.md`, `FS112-YB.md`; `data/fs112/claims.md` in full; the plan's §1.3,
§G part 3 and §IQ; `plans/FS110-derivation.md` §1 (the chain's statements); `plans/FS110-N-proof.md` N3 §2.1–2.4 and N4 §2.1–2.8 (the chain's proofs:
contacts, the cone, the shadow, FLANK/SHAVE, RAY, STUCK, PROP, FIN, TERM — FS-110's record, not fenced); the tools `tools/fs112_y_check.py`,
`tools/fs112_y2_disk.py`, `tools/fs112_y2_dial.py` (source and outputs), `tools/fs110_y_cone.py` (the WC builder).

### 1.2 Quotation check (standing rule 5)

- `python3 tools/fs112_y3_quotes.py` (`data/fs112/fs112-y/y3_quotes.out`): **12 of 12 found** — card R's R1 quotation of C-CHAIN-9 ("`λ_k ≤ f(λ_{k+1})`
  and `f̃(υ_{k−1}) ≤ υ_k`") against `plans/FS110-derivation.md` and the claim list; the standing rules' four quotations of Kooshi (rules 0, 3, 4 against
  `CLAUDE.md`, rule 10 against `plans/CONSOLIDATION-2026-09-27.md` item 20); C-CHAIN-8, C-T2 (ii) and HOCK's sentence (claim list); and the three Y2
  sentences A3-3.5 builds on (Y2 §7 items 2–4). `--self-test`: `f` replaced by `f̃` in C-CHAIN-9 is MISSING while the faithful twin is FOUND.
- FS112-Y's 33 quotations re-found at today's HEAD (`python3 tools/fs112_y_quotes.py`: 33 found, 0 missing).
- **Not checkable:** card R part 1 (`data/fs112/fs112-a3/card-R.md`) and A3-3.5 (the advisor's record) are fenced for me; I work their text as the brief
  quotes it. A3-3.5's lines about Y2's items are not in quotation marks there (the advisor's own summary); they match Y2 §7 items 2–4 in substance.
- **No paraphrase found in my brief.**

### 1.3 Step 0 — C-HOCK: declined as mis-aimed (recorded, A3-3.5 item 0)

Y2 §7 item 2 (verbatim): "A meaningful instance needs an arc of radius `< 1` between two tiles of a valid object; none of the held exact objects has one".
I add nothing and build nothing for it. The claim C-HOCK stays open for the construction side; its first honest instance needs a valid object with a
boundary arc of radius `< 1` between two coloured tiles — none of the strip, the disk, the moved disk, FS-110's fragments (their `9/10` arcs border an
uncoloured gap) has one.

### 1.4 Card R, R1 — **TRUE, with its precise form** [hand, one mind; arithmetic only]

C-CHAIN-9's inequalities, verbatim: "`λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", with `f(λ) = λ/(1 + λ)`, `f̃(υ) = υ/(1 − υ)`, `f̃ = f⁻¹`, both increasing.
1. `f(λ) − λ = −λ²/(1 + λ) < 0` for `λ > −1`, `λ ≠ 0`; `f̃(υ) − υ = υ²/(1 − υ) > 0` for `υ < 1`, `υ ≠ 0`. Hence `λ_k ≤ f(λ_{k+1}) ≤ λ_{k+1}` and
   `υ_{k−1} ≤ f̃(υ_{k−1}) ≤ υ_k`: **both sequences are non-decreasing in `k`, and two consecutive terms are equal only when both are 0** (`λ_k = λ_{k+1}`
   forces `λ_{k+1} = 0`; `υ_{k−1} = υ_k` forces `υ_{k−1} = 0`). This is R1's "strictly increasing in `k` wherever it is nonzero", made exact.
2. **Infinite toward `+k`** (`k ≥ 0`): if some `υ_m > 0` then `1/υ_{k+1} ≤ 1/υ_k − 1` for `k ≥ m`, so `υ > 1` after more than `1/υ_m − 1` steps — impossible
   (N4-FIN's count); so every `υ_k ≤ 0`, every `λ_k < υ_k ≤ 0`, no `λ` is 0, and `λ_0 < λ_1 < λ_2 < …`. **Infinite toward `−k`**: the mirror — every
   `λ_k ≥ 0`, every `υ_k > 0`, and `… < υ_{−2} < υ_{−1} < υ_0`. Either way the curvatures at the chain points, hence (curvature `1/(C − k)` signed, `|·|`
   strictly monotone) **the radii of the horn arcs, are pairwise distinct: infinitely many radii on one normal line.** With unit arcs allowed the values
   lie in `[−1, 1]`; `f̃(1) = +∞` and `f(−1) = −∞` only shorten chains (a term equal to `±1` is an end), so nothing changes.
3. **Finitely many radii** (in particular every map periodic in two independent directions: finitely many tiles per period, finitely many arcs up to
   translation): the curvatures at chain points lie in a finite set of `V` signed values, so no one-sided infinite chain exists, and splitting any
   finite chain into its `υ < 0`, `υ = 0` (where `λ < 0`) and `υ > 0` parts, each strictly monotone, bounds **its length by `3V + 3`**.
4. **Scope.** R1 is about the inequality chain only — arithmetic, no geometry. It does not say where a chain ends or what an end needs (card R's R2);
   and it does not reach a limit object of `𝓜_K`, which need not be periodic (W-EQ-K's tight map is a Hausdorff limit; only its approximating band-proper
   designs are periodic). So: **a periodic YES candidate has only finite stuck chains, each with two ends**, and every end is a place where C-CHAIN-8's
   propagation fails — under Condition 5 nowhere (row 134), with unit arcs possibly at a unit arc (R2). A3-3.5's first alternative (R1 fails) did not fire.

## Stage 1 — SAVED

## Stage 2 — SAVED: the pinned corner, both named GAPs (A3-3.5 item 1) — both answered by a derived obstruction; no escape

Tool `tools/fs112_y3_pin.py` (outputs `data/fs112/fs112-y/y3_pin_strip.out`, `y3_pin_disk.out`, `y3_pin_disk_first.out`, `y3_pin_disk_plant.out`),
over FS112-Y's checker and Y2's strip, disk and moved disk (imported, never edited). "Free at `w`": a colour `c` such that no `c`-tile other than
the tiles being changed has points at distance `< 1` and `> 1` from `w` (exact straddle test). A free set at a point is a necessary condition for
recolouring a neighbourhood of it; an empty or wrong free set is an obstruction at that point, a nonempty one proves nothing about a region.

### 2.1 The strip: colour 4 at `Q` by cutting `C_{−1}` and `C_2` along `ω(Q)` — **the cut fails** (Y3-STRIPCUT) [tools, exact at named points; hand, one mind]

- **Exact geometry.** `ω(Q)`, `Q = (1/4, top)`, passes through `C_{−1}`'s top-left corner `(−3/4, top)` and its bottom-right corner, `A_{−1}`'s apex
  `(−1/4, √15/4)`, and through `C_2`'s corners `(5/4, top)` and `(3/4, √15/4)` = the apex `A_1`; it cuts each top tile corner to corner into an inner
  part `U` (inside `B(Q, 1)`, holding the corner at `Q`'s side) and an outer part `L`. The valley `V_{−1} = (−1/2, √3/2)` is outside `B(Q, 1)`
  (`|Q − V_{−1}|² = 3/2`), so `L` holds it.
- **The valley's top sector is forced** (Y2-FORCE, now exact at `V_{−1}`): with only `C_{−1}` removed, the free set at `V_{−1} + e(θ)/50` is `{4}` at
  `θ = 30°, 60°, 90°, 120°, 150°` (`{3}` at `0°`, `{2}` at `180°`); so `L` must stay colour 4 near `V_{−1}`. (A first registration removed the valley's
  three tiles and failed: the force comes from `A_{−2}`, `A_{−1}` themselves — an instrument slip, caught by its own mismatch; the pointwise sets then
  widen to `{3,4}`, `{2,3,4}`, `{2,4}`.)
- **Every point near the cut has one colour.** At nine named points of `C_{−1}` (the cut arc `Q − ρe`, `e` rational at `t = 1/5, 1/3, 1/2`, `ρ = 19/20,
  1, 21/20`: inside, on and outside the cut) and six of `C_2`, **the free set with the cut tile ignored is exactly `{4}`**. Blockers at `C_{−1}`'s
  points: 1 by `A_{−3}` and `A_0`; 2 by `A_{−2}` (and `A_1` near the apex); 3 by `A_{−1}` (and `A_{−4}` outside); 5 by `C_{−3}` (and `C_0` at some);
  6 by `C_1` (and `C_{−2}`, `B_{−1}` near the apex).
- **The case split (hand).** To free 4 at points `z` just above `Q`, `C_{−1}`'s colour-4 area must lie inside `B̄(z, 1)` or outside `B(z, 1)` piecewise,
  with no colour-4 piece meeting both (C_{−1} has points at `1/2` and at `> 1` from `Q`). So either `U` takes a colour `≠ 4`, or `L` does, or a band of
  another colour separates them along the cut. `L` cannot (the valley's forced sector); `U` and any band need a colour `≠ 4` at points of the named
  kind, where none is free. The same at `C_2`. **So no recolouring confined to `C_{−1}` and `C_2` frees colour 4 at `Q`**; with Y2-FORCE (no change in
  the valleys' and apexes' free directions helps), freeing 4 needs a change to a midline arch (`A_{−4}…A_1`) or to `C_{−3}` or `C_1` — `C_1` is one of
  `Q`'s own two tiles. Grade: exact at 15 named points plus the case split, one mind. Not claimed: that no larger change passes `Q`.

### 2.2 The disk: can `T*` be blue with a change near `Z^L_0` keeping `T2_0`'s top arc? — **NO; the blocker is `T2_0`'s corner `Y_0`** (Y3-DISK-T*) [tools, exact; hand, one mind]

**The object, derived** (no new square root; every point in Y2's tower `ℚ(√5)(√(10+2√5))(√((√5−1)/2))(√((25+9√5)/10))`):
- `q2 := ω(C_0) ∩ ω(Z^L_0) = Z^L_0 − (1, 0)` exactly (`|C_0 − Z^L_0| = 1/φ`, and `√(1 − 1/(4φ²)) = sin 72°`); **the other intersection is `D_0`**.
- `p* := ω(C_0) ∩` rim, from `√(4r² − 1) = 3 tan 72°/√5`, `tan 72° = √(10+2√5)/(√5 − 1)` (exact identity checked).
- `W = U′_0 ∩ B(C_0, 1)`, corners `u_0`, `p*`, `B_0`; the move takes `W` from `U′_0` (yellow then lies outside `B(C_0,1)`, touching `ω(C_0)` from `B_0` at
  252° to `p*` at 207°, which frees yellow at `C_0` on `(−18°, 117°)`), gives `W ∩ B̄(Z^L_0, 1)` to `U_0` (purple) and the rest, `T*`, blue. `T*` and
  `U_0` are closed just beyond the rim — `T*` at `s1 = Z^L_0 + e(162°)`, `s2 = C_0 + e(198°)`; `U_0` at `s1′ = Z^L_0 + e(162° + 2 atan(1/28))`, which
  lies inside `B̄(Y_0, 1)` (`s1` does not: `|s1 − Y_0| > 1`, exact) — so no point `ω(Z^L_0) ∩` rim is needed. By the subset rule (a valid object stays
  valid when tiles are intersected with a disc), acceptance of the bulged object would give Y2's in-disc object.

**What the exact check says** (`y3_pin_disk.out`; the 17 same-colour pairs that hold a changed tile, of 76; the other 59 are Y2's moved disk's,
unchanged, ACCEPT in `y2_dial_move.out`):
1. **`T*` must hold `q2`, and there it can only be blue.** On Y2's moved disk, at four named points of `W` near `q2` and outside `B̄(Z^L_0, 1)`, the free
   set with `U′_0` ignored is exactly `{yellow}` — the colour the move must remove — and blue is blocked by `T2_0` alone. `q2` is a limit point of
   `W ∖ B̄(Z^L_0, 1)` (the two circles cross there transversally), so every version of the move holds points of `T*` arbitrarily near `q2`.
2. **`T2_0` blocks blue through its corner `Y_0`, not through `Z^L_0`'s sector.** `|q2 − Y_0|² < 1` (float 0.9036) and `|q2 − Z^R_0|² > 1`, both exact:
   the route object with `T2_0` unchanged REJECTs at `(T2_0, T*)` only, its minimum at the side `Z^L_0Y_0` against `q2`. **Y2 §6.4's literal change**
   (`T2_0`'s side leaving `Z^L_0` at exactly 270°, the tangent bound `q2` sets, the sliver to `U_0`) REJECTs at `(T2_0, T*)` again and at `(U_0, U_0)`:
   the sliver's corner `M` has `|M − q2| > 1` (exact), and `U_0` now holds `q2`.
3. **So `T2_0` must vacate `B(q2, 1)`**: a curved triangle bounded by `T2_0`'s side `Z^L_0Y_0`, the part `Y_0K` of the leg `Y_0A_0`, and `ω(q2)` from `K` to
   `Z^L_0`, where `K = C_0 + e(276°)` (exact in the tower extended by `√3`: on `ω(C_0)`, on `ω(q2)`, strictly inside the leg). The leg is the
   perpendicular bisector of `C_0q2` (Y3-LEG: `|A_0 − q2|² = |A_0 − C_0|² = φ²`, exact). `|K − u_0|² > 1` (purple cannot reach `K`) and
   `|Z^L_0 − A_1|² > 1` (orange cannot reach `Z^L_0`), both exact.
4. **Points of that region with no colour.** With `T2_0` ignored and the move's other tiles in place, at 7 named points `q2 + ρe(−2 atan t)` inside
   `T2_0` (`t = 1/40, 1/20, 1/12` at `ρ = 99/100`; `t = 1/8, 1/6` at `ρ = 99/100, 19/20`) **the free set is empty**: red blocked by `C0`, `R_0`; blue by
   `T*`; green by `T2_1`, `U′_4`; yellow by `U′_0` and `T1_4`; orange by `T1_0`; purple by `U_0` (which holds `q2`).
5. **Plant:** `T*` purple → REJECT at `(T*, U_0)` (`U_0`'s diameter through `Z^L_0`), beside the route object (REJECT at `(T2_0, T*)` only).

**Verdict.** Y2 §7 item 3's question — "whether any change near `Z^L_0` that keeps `T2_0`'s top arc lets the triangle `T*` be blue" — is answered
**no**: the blocker is `T2_0`'s corner `Y_0` (distance `< 1` from `q2`, a corner of every `T*`), so `T2_0` must give up a region reaching `Y_0` and `K`,
and that region then has named points with no admissible colour unless one of `C0`, `R_0`, `T2_1`, `U′_4`, `T1_4`, `T1_0` changes too. **I disagree with
Y2 §6.4 in one clause:** "a blue `T*` meets `ω(Z^L_0)` where `T2_0`'s sector at `Z^L_0` … partly faces it … So the second move fails unless `T2_0`
changes at `Z^L_0`" — the sector does face `T*`, but the decisive straddle is at `Y_0` (0.9036); a change at `Z^L_0` alone cannot suffice. Not claimed: that
no larger change frees a fourth colour at `C_0` (the blue and orange routes there were never analysed; Y2 named only yellow's).

### 2.3 What the two answers say together (the pinned corner, strengthened) [hand, one mind]

At both positives the local move the stop suggests is blocked one ring further out: the strip's by a midline arch or the next top tile (`C_{−3}`, `C_1`),
the disk's by a ring-1 or ring-2 tile or the central tile (`T1_0`, `T2_1`, `C0`, …). **Y2-PIN strengthened (for the close):** *at each held positive's stop
point, the named local move (the strip: cut `C_{−1}`, `C_2` along `ω(Q)`; the disk: take `U′_0 ∩ B(C_0, 1)` from yellow) forces, at named points, a
change to a tile that realises its own diameter or a contact at 1 elsewhere — the free sets there are `{own colour}` or empty (exact).* Every point read
in both positives' interiors near their stops has exactly one free colour, its own: the positives are **locked** there, pointwise. A NO route could try
to make that lock a lemma (a reading, one mind; killing test: a point of either positive's interior, away from boundaries, with two free colours). **E6:
no move of the dial this round**; the obstruction is now named two tiles deep at both positives.
