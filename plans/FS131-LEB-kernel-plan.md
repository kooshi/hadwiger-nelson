# FS131-LEB — Lebesgue's covering theorem for the square, in the kernel (de Bruijn, the planner)

*Job FS131-LEB, de Bruijn (Opus 5.5), launched 2026-10-04 in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-leb`
(branch `fs131-leb`, from `main` at `bbee15f0`). Brief `data/fs131/briefs/FS131-LEB-lebesgue.md`, with `plans/STANDING-RULES.md`,
`LEAN.md` and `RUNNING.md` § Building. No fence (inventory ruling 1). Working files `data/fs131/leb/`.*

## Theorems this phase proved

None yet (updated at each stage).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| "66. **Ruling — Lebesgue's covering theorem for the square** (K4b's OUT-LEB; TS-T's first clause rests on it; Mathlib has neither it nor Brouwer nor Sperner):" | `plans/FS131-close-inventory.md` line 385 | **verbatim** |
| the docstring's first line, "/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of" | `.claude/worktrees/fs131-w4/Proofs/HadwigerNelson/Plane/SVMap.lean` line 249 (branch `fs131-w4`, HEAD `6bd00949`) | **verbatim** |
| the code block (`closedSquare`, the docstring, `lebesgue_covering_square` with `sorry`) | same file, lines 246–258 | **verbatim**, except the one path the brief says it rewrote: the source reads `` (`plans/FS131-w4-kernel-plan.md` § 7: `` where the brief reads `` (`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 7: `` |
| "all implementers now run on Opus (item 137)" | inventory line 825, item 137 (Kooshi, 2026-10-04: "all implementers should be Opus") | matches |
| the ruling's bibliography debt ("Hurewicz–Wallman, *Dimension Theory*, Thm IV 2, recalled, not read, not held") | inventory item 66, lines 386–390 | matches |

Context the brief does not quote, checked: wave 4's two declarations live in `namespace HadwigerNelson.Plane` (SVMap.lean line 28), so
their full names are `HadwigerNelson.Plane.closedSquare` and `HadwigerNelson.Plane.lebesgue_covering_square`; SVMap.lean opens
`Complex Real Set Filter Topology Metric` (line 30). This module therefore uses namespaces that `open Topology` cannot reach
(`HadwigerNelson.SpernerGrid`, `HadwigerNelson.LebesgueCovering`; a namespace `HadwigerNelson.Topology` would be opened by wave 4's
`open … Topology …` from inside `HadwigerNelson`, and its `closedSquare` would then be ambiguous with wave 4's).

### 1.2 The statement, restated

For a point `c : ℂ` and a side `s > 0`, let `Q = closedSquare c s = [c.re, c.re + s] × [c.im, c.im + s]`. Let `F : Fin m → Set ℂ` be
closed sets with `Q ⊆ ⋃ i, F i`, such that no `F i ∩ Q` has both a point with `re = c.re` (the left side) and a point with
`re = c.re + s` (the right side), and no `F i ∩ Q` has both a point with `im = c.im` (bottom) and a point with `im = c.im + s` (top).
Then some `z ∈ Q` lies in `F i`, `F j`, `F l` for three pairwise distinct indices `i, j, l`.

**Read against the classical theorem** (Hurewicz–Wallman Thm IV 2, read in Stage 2): the cube there is decomposed into closed sets
"none of which contains points of two opposite faces", and the conclusion is that "at least n + 1 of these closed sets have a common
point". Wave 4's statement is the case `n = 2` applied to the closed sets `F i ∩ Q`: the hypothesis is stated for `F i ∩ Q`, the
opposite faces of the square are its opposite sides, and "n + 1 of these sets" is read as three distinct *indices* (the stronger
reading when two `F i` coincide; the proof below gives distinct indices directly). **Same statement; true; not vacuous.** *(Corrected
at Stage 3: the three-set model first written here was wrong — its `F 0 = [0, ½] × [0, 1]` meets both the bottom and the top, which
`hBT` forbids. Wave 4's hypotheses force `m ≥ 4`: the four corners of `Q` lie in four distinct sets, since any two corners share a
side-pair they lie on opposite ends of. The model is the four closed quadrants, kernel-checked as `quadrant_hypotheses`; for `m < 4`
the hypotheses are contradictory.)* No hypothesis is missing: a finite index type is necessary (the singletons of `Q` are a closed
cover by sets meeting no two sides, and no point lies in two of them).

### 1.3 The build as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
launched 07:26 (log `data/fs131/leb/build-stage1.log`); at this stage's commit it is still waiting for the slot (ledger 80 of 90 GiB,
two other trees building). Its result is recorded in Stage 2. Because `scripts/build_order.py` builds every file under `Proofs/`, that
build includes the skeleton modules of Stage 3 (already elaborated with `lake env lean`, sorry warnings only).

## Stage 2 — SAVED: the source read

### 2.1 Hurewicz–Wallman, *Dimension Theory* (Princeton University Press, revised edition 1948; first edition 1941)

Obtained from the Internet Archive's Digital Library of India scan, item `in.ernet.dli.2015.84609` (the 184-page PDF and its OCR text,
fetched 2026-10-04 into the session's scratch directory; not committed — **for the library**: `~/source/library/pdf/hurewicz-wallman-1948-dimension-theory.pdf`
from `https://archive.org/download/in.ernet.dli.2015.84609/2015.84609.Dimension-Theory.pdf`). The scan is the 1948 printing; the
wave-4 docstring's "(1941)" names the first edition, whose Thm IV 2 is recalled, not read, here.

| part | pages | read | what it holds |
|---|---|---|---|
| Ch. IV § 1, A)–C) | 37–40 | read (OCR, with the scan's page heads) | a mod-2 degree `n(φ, T)` counted over a triangulation of `Sₙ` (a parity count of simplexes covering a point), hence no retraction of the ball onto its sphere, hence **Brouwer's fixed-point theorem** (C) |
| Ch. IV § 1, D) | 40–41 | read | **the partition theorem**: if `Bᵢ` is closed and separates the opposite faces `Cᵢ, Cᵢ'` of `Iₙ` (`i = 1..n`), then `B₁ ⋯ Bₙ ≠ ∅`; proof by Brouwer applied to `x ↦ x + (±d(x, Bᵢ))ᵢ` |
| Ch. IV § 2 (Thm IV 1) | 41–42 | read | `dim Iₙ = n`, `dim Eₙ = n`, from D) |
| Ch. IV § 3, **Thm IV 2** | 42–44 | **read in full** | statement: *"Suppose an n-dimensional cube is the sum of a finite number of closed sets, none of which contains points of two opposite faces. Then at least n + 1 of these closed sets have a common point."* (p. 42). Auxiliary A) (p. 42–43: extending a separator of `AC, AC'` in a closed `A` to a separator of `C, C'` in `X`, by complete normality) and B) (p. 43: a decreasing chain `K₁ ⊃ ⋯ ⊃ Kₙ` of successive separators is nonempty, from A) and D)). **The proof** (pp. 43–44): *"Denote by L₁ the sum of the sets in the given decomposition of Iₙ which meet C₁, L₂ the sum of the remaining sets which meet C₂, L₃ the sets not in L₁ + L₂ which meet C₃, …, and L_{n+1} the sum of the sets which meet no Cᵢ"*; then `Kᵢ = L₁ ⋯ Lᵢ (L_{i+1} + ⋯ + L_{n+1})` satisfy B), so `L₁ ⋯ L_{n+1} ≠ ∅`, *"the theorem itself then follow[ing] from the fact that each of the original closed sets of the given decomposition is contained in only one Lᵢ"* |
| Ch. I § 3 (history), Ch. V | — | not read | the remark (p. 44) points to Ch. V for the covering-dimension reading |

The OCR text was checked against the page heads it carries (`40`, `§ 2 ] … 41`, `42`, `§3] LEBESGUE'S COVERING THEOREM 43`, `44`); the
quoted sentences are the OCR's with its spacing repaired.

### 2.2 A modern source: Vander Woude, Dixon, Pavan, Radcliffe, Vinodchandran, arXiv:2306.12593 (2023)

*Neighborhood Variants of the KKM Lemma, Lebesgue Covering Theorem, and Sperner's Lemma on the Cube* (fetched 2026-10-04; **for the
library**: `~/source/library/pdf/arXiv-2306.12593-vanderwoude-neighborhood-kkm-lebesgue.pdf`).

| part | read | what it holds |
|---|---|---|
| § 1 intro, § 1.1 (Defs 1.1, 1.4, 1.5; Thms 1.2, 1.6, 1.7; Cors 1.8–1.9 with proofs) | read | Thm 1.6 is Lebesgue's covering theorem for `[0,1]ᵈ` (*"Given a Lebesgue cover of [0,1]ᵈ, there exists a point p ∈ [0,1]ᵈ belonging to at least d + 1 sets in the cover"*), citing Lebesgue 1911 and H–W Thm IV 2; Thm 1.7 the cubical KKM lemma; the three are *"naturally equivalent"* |
| § 1.2 (Def 1.10, Thm 1.12, Rems 1.11–1.14) | read | cubical Sperner lemmas (Kuhn 1960, Wolsey 1977, De Loera–Peterson–Su 2002), with `2ᵈ` or `d + 1` colours |
| App. A.1 (Lemmas A.1–A.4) | read | careful proofs of the equivalences: A.2 (KKM-Lebesgue ⟹ Lebesgue) labels a point by the least index of a set containing it, the labelling used here |
| §§ 2–4, A.2, B (the neighborhood variant, Brunn–Minkowski) | not read | not used |

### 2.3 What the route takes from each

The grouping (step 1 of the module's route) is Hurewicz–Wallman's own, for `n = 2`: `L₀` = sets meeting the left side, `L₁` = other
sets meeting the bottom, `L₂` = the rest; "each of the original closed sets … is contained in only one Lᵢ" gives three distinct
indices. Where H–W then use B) and D) (separators, complete normality, Brouwer), this module proves the three-set statement directly
by a Sperner parity count on a triangulated grid and the Lebesgue number lemma — the combinatorial route the modern source names
(Sperner ⟺ KKM ⟺ Lebesgue), with A.2's least-index labelling. H–W's own Brouwer proof (§ 1 A) is itself a mod-2 count over a
triangulation, so the parity idea is the same at bottom.

### 2.4 The build as given (Stage 1's pending item)

Recorded in § 3.6.

## Stage 3 — SAVED: the route, the prior-art search, and the modules

### 3.1 Prior art for the formalization (grepped at the pin, `v4.32.0`, 2026-10-04)

- **Mathlib, by the statement's shape and by name**: `rg -i "sperner|brouwer|knaster|KKM|poincar.*miranda|lebesgue.*cover|covering theorem"`
  over `Mathlib/` and every package in `.lake/packages/` finds no Sperner lemma of combinatorial topology, no Brouwer fixed-point
  theorem, no KKM lemma, no Lebesgue covering theorem, no Poincaré–Miranda, no Hex theorem. The hits are Sperner's *theorem* on
  antichains (`Mathlib/Combinatorics/SetFamily/LYM.lean`, `IsAntichain.sperner`), Vitali/Besicovitch covering theorems (measure
  theory), and Hausdorff dimension — none of them this statement. In this repository: nothing (`rg -il "sperner|lebesgue_covering|brouwer" Proofs`).
- **What Mathlib does hold, and the route uses**: `lebesgue_number_lemma_of_metric` (`Mathlib/Topology/MetricSpace/Pseudo/Lemmas.lean`),
  `IsCompact.reProdIm`, `IsClosed.reProdIm`, `Complex.mem_reProdIm`, `Complex.norm_le_abs_re_add_abs_im`, `Set.Finite.isClosed_biUnion`.
  Every Mathlib name used is confirmed with `#check` at the pin: `data/fs131/leb/Checks.lean`, output `data/fs131/leb/checks.out`.
- **Outside Lean** (recalled, not checked): Isabelle/HOL-Analysis and HOL Light hold Brouwer's theorem, reached through a KKM/Sperner
  argument; a Lean 3 formalization of Sperner's lemma was in progress in the Mathlib community. Neither is read here, and nothing rests on them.

### 3.2 The route

1. **Grouping** — Hurewicz–Wallman's first step for `n = 2` (§ 2.3): `g i = 0` if `F i` meets the left side, `1` if not but it meets
   the bottom, `2` otherwise; `G k = ⋃_{g i = k} F i` (closed: a finite union). The hypotheses give: the left side lies in `G 0`, the
   right side misses `G 0` (`hLR`), the bottom lies in `G 0 ∪ G 1`, the top misses `G 1` (`hBT`, read only for sets missing the left
   side). A common point of `G 0, G 1, G 2` lies in `F i₀, F i₁, F i₂` with `g iₖ = k`, so the indices are distinct.
2. **The three-set form** (`exists_mem_inter_three`) — by contradiction: the rectangle is compact and covered by the open sets `(G k)ᶜ`,
   so the Lebesgue number lemma gives `δ`; a grid of mesh `(b − a)/N + (d − c)/N < δ`; each vertex labelled by the least `k` with the
   vertex in `G k` (`leastLabel`, the labelling of `[VanderWoude2023]` Lemma A.2). The boundary conditions become Sperner's: left
   column `0`, right column `≠ 0`, bottom row `≠ 2`, top row `≠ 1`.
3. **Sperner on the grid** (`exists_rainbowCell`) — the mod-2 door count: a door is a `{0, 1}` edge; a triangle has an odd number of
   doors iff it is rainbow (`door_cell`, 81 cases, `decide`); in a strip with no rainbow triangle the interior edges cancel, so the two
   horizontal lines have equal door parity (`rowDoors_succ_eq`; the strip's end edges carry no doors, by the side conditions); the
   bottom line has odd parity (labels in `{0, 1}` from `0` to `1`: a telescoping sum), the top line none. The rainbow triangle's three
   vertices lie in one `δ`-ball about its corner `(i, j)`, which misses some `G k` — but one of the vertices is in `G k`.

### 3.3 The modules (both proved; no `sorry`)

| module | declarations | lines |
|---|---|---|
| `Proofs/HadwigerNelson/Topology/SpernerGrid.lean` (namespace `HadwigerNelson.SpernerGrid`; Mathlib only) | `door`, `Rainbow`, `RainbowCell` (with `Decidable` instances), `rowDoors`, `bit`; finite checks `zmod2_add_self`, `zmod2_two`, `door_cell`, `door_eq_zero_of_ne_zero`, `door_eq_zero_of_ne_one`, `door_eq_bit_add_bit`, `Rainbow.exhaust`, `fin3_eq_one`; counts `rowDoors_succ`, `rowDoors_add_rowDoors`, `sum_range_add_succ`, `rowDoors_bottom`, `rowDoors_top`, `rowDoors_succ_eq`; **`exists_rainbowCell`**; spec examples and the one-cell model `oneCell` | ~170 |
| `Proofs/HadwigerNelson/Topology/LebesgueCovering.lean` (namespace `HadwigerNelson.LebesgueCovering`; imports `SpernerGrid`) | `leastLabel` and its five lemmas; `gridPt` and `gridPt_mem`, `gridPt_re_zero`, `gridPt_re_self`, `gridPt_im_zero`, `gridPt_im_self`, `dist_gridPt_le`; **`exists_mem_inter_three`**; **`lebesgue_covering_rect'`**, **`lebesgue_covering_rect`**; `closedSquare`, `closedSquare_eq_reProdIm`, **`lebesgue_covering_square`**; spec examples; `quadrant`, `quadrant_hypotheses` | ~350 |

The namespaces avoid `HadwigerNelson.Topology` on purpose (§ 1.1): wave 4's `open … Topology …`, written inside `HadwigerNelson`,
would open it too, and its `closedSquare` would be ambiguous with wave 4's own.

**Wave 4's discharge, tested**: `data/fs131/leb/Wave4Bridge.lean` copies wave 4's two declarations verbatim into `namespace
HadwigerNelson.Plane` with its `open` line and closes the theorem by
`:= LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT` (the two `closedSquare`s have one body and unfold to one term);
it elaborates, and `#print axioms` reads `[propext, Classical.choice, Quot.sound]` (`data/fs131/leb/wave4-bridge.out`). Wave 4 may
instead delete its own `closedSquare` and use this module's.

**Linters**: `#lint in Proofs.HadwigerNelson.Topology` (Batteries, 14 linters) — 0 errors in 41 declarations (`data/fs131/leb/lint.out`).

### 3.4 Generalizations (each proved; messaged to the coordinator mid-job)

1. **Any closed rectangle and any finite index type** (`lebesgue_covering_rect`): the square is the case `b − a = d − c`.
2. **The wider hypothesis** (`lebesgue_covering_rect'`): the top/bottom condition is needed only for sets that miss the left side —
   the grouping never reads the horizontal sides of a set it has put with the left side. Strictly wider: wave 4's hypotheses force at
   least four sets (§ 1.2, corrected), while three suffice here (a left strip from bottom to top, two squares on the right).
3. **The three-set (cubical KKM) form** (`exists_mem_inter_three`), the statement both theorems reduce to.

Not taken: the `n`-cube with `n + 1` sets. It needs an `n`-dimensional triangulation of the cube (Freudenthal–Kuhn) and an
`n`-dimensional Sperner count, which is a separate job, not a small extension of the grid count here.

### 3.5 Corrections owed by this record

- § 1.2's first model was wrong (corrected in place there); wave 4's hypotheses need `m ≥ 4`.
- The brief's citation "Hurewicz–Wallman, *Dimension Theory* (1941)" names the first edition; the copy read is the 1948 revised
  printing, whose Thm IV 2 is on p. 42. The module's docstrings cite the 1948 printing.

### 3.6 The build as given (Stage 1's pending item)

The Stage 1 build ran 07:34–07:42 under the slot: **OK, 440 of 440 batches**, `build/gate/build/20261004T123419Z-3512914.log` in the
worktree. Because `build_order.py` walks every file under `Proofs/`, it first compiled the two skeleton modules (with `sorry` warnings),
then, at its end, recompiled them in their proved form (`rebuilt: Topology.SpernerGrid, Topology.LebesgueCovering, Proofs`, no warnings).
The tree as given from `main` built unchanged: no other module was rebuilt.
