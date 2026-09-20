# FS-61 — the census of real quadratic fields: which planes need four colours

*Derived by `python3 tools/fs61_census.py table` from `data/fs61/fields/<d>/*.jsonl`; never hand-edited. Plan:
`plans/FS61-quadratic-census.md`. Machine: desktop (16 physical cores / 32 threads, 128 GB).*

**Read this first.** Colour the points of the plane whose two coordinates lie in `ℚ(√d)` so that no two points exactly
1 apart share a colour; `χ(ℚ(√d)²)` is the fewest colours that suffice. The forty fields below are the only real
quadratic fields whose plane can need four (§1), and the project's local–global conjecture predicts every one of them
does. **"Not landed" means no certificate was found at the stated depth; it is not evidence that three colours
suffice — the conjecture predicts at least four for every row of this table.**

**The columns.**

* **d** — the field is `ℚ(√d)`. **mod 8** — 3 or 7; the two halves behave differently (R-mod8).
* **L** — the best upper bound the finite residue planes give, `[lower, upper]` when the target's own chromatic number
  is undecided. `χ(ℚ(√d)²) ≤ L`, prior art at hand level.
* **N₁, N₃** — the least denominator of a non-rational unit vector, and the least denominator divisible by 3. A witness
  needs a direction with 3 in a denominator (the kernel's 3-adic barrier, `CLAUDE.md` row 72).
* **lattices** — the tier's lattices by state: `C2`/`C3` colourable by a linear form mod 2 or mod 3 (exact),
  `Cq` by a verified periodic quotient colouring, `R` refused, `O` open.
* **balls asked / over cap / unknown** — of the ball records, how many were actually put to a solver. A lattice too
  fine for the tier's point cap is never built, so **a field with few asks has been looked at less than its lattice
  count suggests**.
* **bracket** — the refusal bracket of the best lattice: (largest radius verified colourable, smallest refused).
* **state** — `Landed (certified)` only when the frozen checker printed CERTIFIED; `Refusal claimed` is a solver's
  word; `Not landed at tier 1` is a null at a depth.
* **evidence** — `kernel` (11 only), `checker`, `solver claim`, or `none`.
* **value** — the bracket on `χ(ℚ(√d)²)` with a source for each end.


| d | mod 8 | L | N₁ | N₃ | lattices (C2/C3/Cq/R/O) | balls asked / over cap / unknown | bracket | state | evidence | value | what would deepen it |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **11** | 3 | 4 | 6 | 6 | 70 (28/17/19/4/2) | **4** / 10 / 0 | – … 1.0 | Landed (certified) | kernel | 4 ≤ χ ≤ 4 | `` |
| **23** | 7 | 4 | 8 | 12 | 94 (20/35/12/6/21) | **15** / 42 / 2 | 1.8 … 1.3 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **35** | 3 | 4 | 6 | 6 | 53 (23/13/16/0/1) | **0** / 2 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 35 --tier 2` |
| **47** | 7 | 5 | 12 | 12 | 55 (8/18/0/5/24) | **32** / 30 / 2 | 1.8 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 5 | `` |
| **59** | 3 | 4 | 30 | 30 | 29 (10/9/8/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 59 --tier 2` |
| **71** | 7 | 4 | 12 | 12 | 50 (11/17/14/7/1) | **11** / 11 / 3 | 1.0 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **83** | 3 | 4 | 42 | 42 | 18 (6/4/6/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 83 --tier 2` |
| **95** | 7 | 4 | 12 | 12 | 41 (10/11/14/6/0) | **11** / 7 / 3 | 1.0 … 1.2 | Refusal claimed | solver claim | 4 ≤ χ ≤ 4 | `python3 tools/fs61_census.py land 95` |
| **107** | 3 | 4 | 54 | 54 | 16 (6/4/6/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 107 --tier 2` |
| **119** | 7 | 4 | 12 | 12 | 54 (9/15/22/7/1) | **11** / 11 / 3 | 1.0 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **131** | 3 | 4 | 30 | 30 | 22 (7/7/6/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 131 --tier 2` |
| **143** | 7 | 5 | 12 | 12 | 24 (7/5/0/1/11) | **12** / 14 / 2 | 1.8 … 1.5 | Landed (certified) | checker | 4 ≤ χ ≤ 5 | `` |
| **155** | 3 | 4 | 18 | 18 | 29 (9/6/12/0/2) | **2** / 2 / 0 | 1.8 … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 155 --tier 2` |
| **167** | 7 | [6, 8] | 24 | 24 | 20 (1/6/7/0/6) | **0** / 12 / 0 | – … – | Not landed at tier 1 | none | ≤ [6, 8] | `python3 tools/fs61_census.py census-field 167 --tier 2` |
| **179** | 3 | 4 | 30 | 30 | 15 (3/4/6/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 179 --tier 2` |
| **191** | 7 | 4 | 20 | 48 | 28 (3/11/10/4/0) | **8** / 4 / 2 | – … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **203** | 3 | 4 | 18 | 18 | 18 (4/5/7/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 203 --tier 2` |
| **215** | 7 | 5 | 24 | 24 | 24 (3/8/11/0/2) | **2** / 2 / 0 | 1.8 … – | Not landed at tier 1 | none | ≤ 5 | `python3 tools/fs61_census.py census-field 215 --tier 2` |
| **227** | 3 | 4 | 114 | 114 | 6 (0/2/4/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 227 --tier 2` |
| **239** | 7 | 4 | 24 | 24 | 24 (3/9/8/0/4) | **0** / 8 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 239 --tier 2` |
| **251** | 3 | 4 | 70 | 75 | 13 (3/4/5/0/1) | **0** / 2 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 251 --tier 2` |
| **263** | 7 | 4 | 24 | 24 | 15 (1/7/6/0/1) | **2** / 0 / 0 | 1.8 … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 263 --tier 2` |
| **287** | 7 | 4 | 24 | 24 | 27 (3/9/8/0/7) | **3** / 11 / 0 | 1.8 … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 287 --tier 2` |
| **299** | 3 | 4 | 18 | 18 | 14 (2/3/9/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 299 --tier 2` |
| **311** | 7 | 5 | 28 | 48 | 19 (2/5/8/0/4) | **1** / 7 / 0 | 1.5 … – | Not landed at tier 1 | none | ≤ 5 | `python3 tools/fs61_census.py census-field 311 --tier 2` |
| **323** | 3 | 4 | 18 | 18 | 11 (2/3/5/0/1) | **0** / 2 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 323 --tier 2` |
| **335** | 7 | 5 | 36 | 36 | 12 (2/3/5/0/2) | **1** / 3 / 0 | 1.5 … – | Not landed at tier 1 | none | ≤ 5 | `python3 tools/fs61_census.py census-field 335 --tier 2` |
| **347** | 3 | 4 | 78 | 78 | 4 (0/2/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 347 --tier 2` |
| **359** | 7 | 4 | 36 | 36 | 12 (2/4/2/3/1) | **7** / 5 / 3 | – … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **371** | 3 | 4 | 30 | 30 | 6 (2/1/3/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 371 --tier 2` |
| **383** | 7 | 5 | 28 | 72 | 5 (0/3/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 5 | `python3 tools/fs61_census.py census-field 383 --tier 2` |
| **395** | 3 | 4 | 42 | 42 | 10 (4/2/4/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 395 --tier 2` |
| **407** | 7 | 4 | 24 | 24 | 10 (2/3/4/0/1) | **0** / 2 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 407 --tier 2` |
| **419** | 3 | 4 | 50 | 78 | 4 (1/1/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 419 --tier 2` |
| **431** | 7 | 4 | 32 | 60 | 10 (2/3/2/0/3) | **2** / 4 / 0 | 1.8 … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 431 --tier 2` |
| **443** | 3 | 4 | 78 | 78 | 2 (0/0/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 443 --tier 2` |
| **455** | 7 | 4 | 24 | 24 | 20 (6/5/7/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 455 --tier 2` |
| **467** | 3 | 4 | 78 | 78 | 1 (0/0/1/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 467 --tier 2` |
| **479** | 7 | 5 | 36 | 36 | 9 (2/3/2/0/2) | **0** / 4 / 0 | – … – | Not landed at tier 1 | none | ≤ 5 | `python3 tools/fs61_census.py census-field 479 --tier 2` |
| **491** | 3 | 4 | 50 | 102 | 4 (2/1/1/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1 | none | ≤ 4 | `python3 tools/fs61_census.py census-field 491 --tier 2` |

**40 fields.** 8 Landed (certified); 31 Not landed at tier 1; 1 Refusal claimed.
Balls on the census population (lattices the filter left open): 343 records, **124 asked**, 219 over cap, 20 unknown. Counting every record, including the balls phase 0's paired controls asked on already-certified lattices at d = 47: 395 records, 147 asked.

