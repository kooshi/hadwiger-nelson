# What the tool must decide — fixed by Keryx, 2026-10-07 (UTC), before the planner's launch

*Statements and definitions only, one per line, each with its id. A later change is a dated line at the end. Nothing here is a verdict: whether any NO below is true is what the tool is for.*

## Definitions

D1: For a finite field `F_q` with `q` odd, the board `Γ_q` is the graph on the `q²` cells of `F_q²` in which two cells `(x, y)` and `(x′, y′)` are adjacent (they *clash*) exactly when `(x − x′)² + (y − y′)² = 1` in `F_q`.
D2: A set of cells is *clash-free* when no two of its cells clash; `α(Γ_q)` is the largest size of a clash-free set; for a set of cells `H`, `α(H)` is the largest size of a clash-free subset of `H`, and for a weight `w ≥ 0` on `H`, `α_w(H)` is the largest total weight of a clash-free subset of `H`.
D3: The open boards are `q ∈ {23, 27, 31, 43, 47}`; `27` means the field with 27 elements, not the integers modulo 27.

## Statements

S1: DECIDE(q, t) asks whether `Γ_q` has a clash-free set of `t` cells; the tool answers YES with such a set, re-checked pair by pair from D1 by code that shares nothing with the search; or NO with a certificate that a separate small checker accepts; or UNDECIDED with what was measured; it never answers NO because a search stopped.
S2: `k` colours on `q²` cells put some colour on at least `⌈q²/k⌉` cells, so a NO at `t = ⌈q²/k⌉` proves that `Γ_q` needs more than `k` colours; the first targets are `t = ⌈q²/6⌉`, which is 89, 122, 161, 309, 369 at `q` = 23, 27, 31, 43, 47.
S3: (the ratio lemma; by hand, one mind, unchecked) Translations of `F_q²` are automorphisms of `Γ_q` and act transitively on its cells, so for every set of cells `H`, every weight `w ≥ 0` on `H` and every clash-free set `A` of `Γ_q`: `|A| / q² ≤ α_w(H) / w(H)`; with `w = 1` on `H` this is `|A| / q² ≤ α(H) / |H|`. Argument: sum the `w`-weight of `A ∩ (H + v)` over all `q²` translations `v`; each cell of `A` is counted with total weight `w(H)`, so the sum is `|A| · w(H)`, and each of the `q²` terms is at most `α_w(H)`.
S4: (the method as described to Kooshi; a proposal, not a requirement) a NO at `t` is proved by one piece `H`, plain or weighted, whose exactly computed `α_w(H)` is below `t · w(H) / q²`; the pieces to try first are unions of parallel lines in a direction that contains no clash step, each of which is clash-free on its own; the exact computation is classical branch and bound, Russian-doll search over nested unions of lines being the classical algorithm of this shape; the whole board with one cell fixed in the set, under the symmetries fixing that cell, is the fallback.
S5: (arithmetic at 23; by hand, one mind, unchecked, and it replaces a wrong sentence in the record) a clash-free set of 87 cells of `Γ₂₃` is known, so a plain piece proving NO at 89 has `87·|H|/529 ≤ α(H) < 89·|H|/529`; for a union of `j` whole no-clash lines that is `87j/23 ≤ α(H) < 89j/23`, whose integer solutions for `j ≤ 12` are `α(H)` = 19, 23, 27, 38, 42, 46 at `j` = 5, 6, 7, 10, 11, 12; since one whole line is 23 clash-free cells, `j = 5` is out, and `j = 6` needs six lines no two of which can be taken whole together; any such piece gives `α(Γ₂₃) = 87` outright.
S6: (what is already measured) at `q = 23` every run of two independent local searches stops at 87 cells and none reaches 88: the sibling repository's tool (16 threads agreeing) and thirteen runs of a Python tabu search; the best set invariant under a rotation of order 12 about a cell has exactly 85 cells; the certificate's ceiling is 105.

## Dated lines

- 2026-10-07, about 22:0x UTC — **S5's last clause is false as written; found by the planner (WO22-FP1) at its readback, checked by me.** A plain piece of `j` whole lines bounds a clash-free set by `⌊23·α(H)/j⌋`. At `j` = 6, 7, 12 (`α(H)` = 23, 27, 46) that is 88 (`529/6 = 88.17`, `621/7 = 88.71`, `1058/12 = 88.17`): such a piece proves NO at 89 — enough for "more than six colours" — and leaves 88 open. Only `j` = 10 and 11 (38, 42) give 87 outright; the condition for that is `α(H) < 88·|H|/529`. The planner also notes: the pairwise-clashing condition binds `j` = 7, 10, 11 as well as 6 (two lines taken whole give 46), and S3 needs `w(H) > 0`, left implicit. **Everything else in D1–D3 and S1–S6 checked by it**: S3's argument verified, S2's five targets recomputed, the nine lines verbatim in its brief.
