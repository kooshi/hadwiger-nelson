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
reading when two `F i` coincide; the proof below gives distinct indices directly). **Same statement; true; not vacuous** (a model:
`m = 3`, `c = 0`, `s = 1`, `F 0 = [0, ½] × [0, 1]`, `F 1 = [½, 1] × [0, ½]`, `F 2 = [½, 1] × [½, 1]`; the triple point is `½ + ½ i`).
For `m < 3` the hypotheses are contradictory, as the theorem implies; no hypothesis is missing (a finite index type is necessary:
the singletons of `Q` are a closed cover by sets meeting no two sides, and no point lies in two of them).

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

(Recorded in Stage 3 when it lands.)
