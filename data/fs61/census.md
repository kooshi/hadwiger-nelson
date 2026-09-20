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
  word; `Not landed at tier T` is a null at a depth, and it always says **which kind of null** (the owner's ruling 6,
  2026-09-20), because the three are different knowledge:
  * `(by certificate)` — the field has **no** open lattice left at this depth: every one carries a verified
    3-colouring of its whole infinite graph. More solver time at this depth is worth nothing; only deeper lattices
    (more classes, a larger `NMAX`) can land it.
  * `(by budget: k Open lattices, none askable)` — open lattices remain and **not one of them was ever put to a
    solver**: every ball the tier would build is over its point cap. Nothing about the field was measured.
  * `(asked: j of k Open lattices, no refusal)` — open lattices were asked and none refused at this depth.
* **evidence** — what backs **this row's** lower bound: `checker` (the frozen independent checker certified the
  witness in `data/fs61/witness-<d>/`), `solver claim` (a refusal no checker has confirmed), or `none`.
  **No row of this table is kernel-checked**; see the note under the table for `d = 11`.
* **value** — the bracket on `χ(ℚ(√d)²)` with a source for each end.


**The depth this table is at: tier `1c`** — the deepest tier with ball records, read from the records themselves. Tier definitions live in `data/fs61/tiers.json` and never change after their first record:

* **tier `1`** — tier 1: lattices to `NMAX = 180`, radii [1.5, 1.8], point cap 600,000, solve wall 600 s.
* **tier `1b`** — tier 1b (the radius ladder): lattices to `NMAX = 180`, radii [1.2, 1.0], point cap 600,000, solve wall 600 s. Scope: every rank-4 lattice whose state is Open and whose tier-1 R = 1.5 ball record is `Over cap (not asked)`; a lattice whose R = 1.5 ball was asked is out of scope, and tier 1's definition is unchanged
* **tier `1c`** — tier 1c (the degree-targeted ask): lattices to `NMAX = 180`, one ball per lattice at the radius where the predicted average degree reaches 14 (floor 8), point cap 2,000,000, solve wall 1800 s. Scope: every rank-4 lattice whose state is `Open` or `Refused` at a census field with no certified witness -- one uniform rule over all 31 such fields, 167 included under it like every other. A lattice's ask is decided by the degree rule below and not by which radii an earlier tier happened to reach.

| d | mod 8 | L | N₁ | N₃ | lattices (C2/C3/Cq/R/O) | balls asked / over cap / unknown | bracket | state | evidence | value | what would deepen it |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **11** | 3 | 4 | 6 | 6 | 70 (28/17/19/4/2) | **6** / 10 / 0 | 1.2 … 1.0 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **23** | 7 | 4 | 8 | 12 | 94 (20/35/12/7/20) | **22** / 51 / 5 | 1.8 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **35** | 3 | 4 | 6 | 6 | 53 (23/13/16/0/1) | **1** / 3 / 1 | – … – | Not landed at tier 1c (asked: 1 of 1 Open lattice, no refusal, 1 undecided at the wall) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 35 --tier 2` |
| **47** | 7 | 5 | 12 | 12 | 55 (8/18/0/5/24) | **35** / 37 / 5 | 1.8 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 5 | `` |
| **59** | 3 | 4 | 30 | 30 | 29 (10/9/8/1/1) | **1** / 7 / 0 | – … 1.1945 | Refusal claimed | solver claim | 4 ≤ χ ≤ 4 | `python3 tools/fs61_census.py land 59` |
| **71** | 7 | 4 | 12 | 12 | 50 (11/17/14/7/1) | **12** / 11 / 4 | 1.0 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **83** | 3 | 4 | 42 | 42 | 18 (6/4/6/0/2) | **1** / 7 / 0 | 1.2234 … – | Not landed at tier 1c (asked: 1 of 2 Open lattices, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 83 --tier 2` |
| **95** | 7 | 4 | 12 | 12 | 41 (10/11/14/6/0) | **11** / 7 / 3 | 1.0 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **107** | 3 | 4 | 54 | 54 | 16 (6/4/6/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 107 --tier 2` |
| **119** | 7 | 4 | 12 | 12 | 54 (9/15/22/7/1) | **11** / 12 / 3 | 1.0 … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **131** | 3 | 4 | 30 | 30 | 22 (7/7/6/0/2) | **2** / 6 / 1 | 1.554 … – | Not landed at tier 1c (asked: 1 of 2 Open lattices, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 131 --tier 2` |
| **143** | 7 | 5 | 12 | 12 | 24 (7/5/0/1/11) | **15** / 17 / 4 | 1.8 … 1.5 | Landed (certified) | checker | 4 ≤ χ ≤ 5 | `` |
| **155** | 3 | 4 | 18 | 18 | 29 (9/6/12/0/2) | **5** / 2 / 0 | 2.1539 … – | Not landed at tier 1c (asked: 2 of 2 Open lattices, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 155 --tier 2` |
| **167** | 7 | [6, 8] | 24 | 24 | 20 (1/6/7/0/6) | **4** / 20 / 1 | 1.6656 … – | Not landed at tier 1c (asked: 3 of 6 Open lattices, no refusal) | none | ≤ [6, 8] | `python3 tools/fs61_census.py census-field 167 --tier 2` |
| **179** | 3 | 4 | 30 | 30 | 15 (3/4/6/0/2) | **3** / 5 / 1 | 1.6656 … – | Not landed at tier 1c (asked: 2 of 2 Open lattices, no refusal, 1 undecided at the wall) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 179 --tier 2` |
| **191** | 7 | 4 | 20 | 48 | 28 (3/11/10/4/0) | **8** / 4 / 2 | – … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **203** | 3 | 4 | 18 | 18 | 18 (4/5/7/0/2) | **1** / 7 / 0 | 1.0 … – | Not landed at tier 1c (asked: 1 of 2 Open lattices, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 203 --tier 2` |
| **215** | 7 | 5 | 24 | 24 | 24 (3/8/11/0/2) | **5** / 2 / 1 | 2.1539 … – | Not landed at tier 1c (asked: 2 of 2 Open lattices, no refusal) | none | ≤ 5 | `python3 tools/fs61_census.py census-field 215 --tier 2` |
| **227** | 3 | 4 | 114 | 114 | 6 (0/2/4/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 227 --tier 2` |
| **239** | 7 | 4 | 24 | 24 | 24 (3/9/8/2/2) | **5** / 11 / 3 | 1.2771 … 1.2892 | Refusal claimed | solver claim | 4 ≤ χ ≤ 4 | `python3 tools/fs61_census.py land 239` |
| **251** | 3 | 4 | 70 | 75 | 13 (3/4/5/0/1) | **1** / 3 / 1 | – … – | Not landed at tier 1c (asked: 1 of 1 Open lattice, no refusal, 1 undecided at the wall) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 251 --tier 2` |
| **263** | 7 | 4 | 24 | 24 | 15 (1/7/6/0/1) | **3** / 0 / 0 | 2.1539 … – | Not landed at tier 1c (asked: 1 of 1 Open lattice, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 263 --tier 2` |
| **287** | 7 | 4 | 24 | 24 | 27 (3/9/8/0/7) | **11** / 15 / 4 | 2.1539 … – | Not landed at tier 1c (asked: 6 of 7 Open lattices, no refusal, 2 undecided at the wall) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 287 --tier 2` |
| **299** | 3 | 4 | 18 | 18 | 14 (2/3/9/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 299 --tier 2` |
| **311** | 7 | 5 | 28 | 48 | 19 (2/5/8/1/3) | **6** / 9 / 2 | 1.6656 … 1.2892 | Refusal claimed | solver claim | 4 ≤ χ ≤ 5 | `python3 tools/fs61_census.py land 311` |
| **323** | 3 | 4 | 18 | 18 | 11 (2/3/5/0/1) | **0** / 4 / 0 | – … – | Not landed at tier 1c (by budget: 1 Open lattice, none askable) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 323 --tier 2` |
| **335** | 7 | 5 | 36 | 36 | 12 (2/3/5/0/2) | **2** / 5 / 0 | 2.1539 … – | Not landed at tier 1c (asked: 1 of 2 Open lattices, no refusal) | none | ≤ 5 | `python3 tools/fs61_census.py census-field 335 --tier 2` |
| **347** | 3 | 4 | 78 | 78 | 4 (0/2/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 347 --tier 2` |
| **359** | 7 | 4 | 36 | 36 | 12 (2/4/2/3/1) | **8** / 5 / 4 | – … 1.2 | Landed (certified) | checker | 4 ≤ χ ≤ 4 | `` |
| **371** | 3 | 4 | 30 | 30 | 6 (2/1/3/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 371 --tier 2` |
| **383** | 7 | 5 | 28 | 72 | 5 (0/3/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 5 | `python3 tools/fs61_census.py census-field 383 --tier 2` |
| **395** | 3 | 4 | 42 | 42 | 10 (4/2/4/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 395 --tier 2` |
| **407** | 7 | 4 | 24 | 24 | 10 (2/3/4/0/1) | **2** / 2 / 1 | 1.5474 … – | Not landed at tier 1c (asked: 1 of 1 Open lattice, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 407 --tier 2` |
| **419** | 3 | 4 | 50 | 78 | 4 (1/1/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 419 --tier 2` |
| **431** | 7 | 4 | 32 | 60 | 10 (2/3/2/0/3) | **5** / 5 / 2 | 1.8 … – | Not landed at tier 1c (asked: 3 of 3 Open lattices, no refusal, 1 undecided at the wall) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 431 --tier 2` |
| **443** | 3 | 4 | 78 | 78 | 2 (0/0/2/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 443 --tier 2` |
| **455** | 7 | 4 | 24 | 24 | 20 (6/5/7/0/2) | **2** / 6 / 1 | 1.5911 … – | Not landed at tier 1c (asked: 1 of 2 Open lattices, no refusal) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 455 --tier 2` |
| **467** | 3 | 4 | 78 | 78 | 1 (0/0/1/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 467 --tier 2` |
| **479** | 7 | 5 | 36 | 36 | 9 (2/3/2/0/2) | **4** / 4 / 2 | 1.5195 … – | Not landed at tier 1c (asked: 2 of 2 Open lattices, no refusal) | none | ≤ 5 | `python3 tools/fs61_census.py census-field 479 --tier 2` |
| **491** | 3 | 4 | 50 | 102 | 4 (2/1/1/0/0) | **0** / 0 / 0 | – … – | Not landed at tier 1c (by certificate) | none | ≤ 4 | `python3 tools/fs61_census.py census-field 491 --tier 2` |

**40 fields.** 9 Landed (certified); 28 Not landed at tier 1c; 3 Refusal claimed. Of the nulls: 16 asked, 1 by budget, 11 by certificate.
Balls on the census population (lattices the filter left open): 469 records, **192 asked**, 277 over cap, 51 unknown. Counting every record, including the balls phase 0's paired controls asked on already-certified lattices at d = 47: 521 records, 215 asked.

**The kernel and this table.** **No row above is kernel-checked.** The Lean kernel does hold `χ(ℚ(√11)²) ≥ 4` —
`four_le_chromaticNumber_planeOver_eleven`, in `Proofs/HadwigerNelson/Instances/SqrtEleven.lean` — but it holds it
from FS-58's **204-point chain witness**, which is a *different graph* from the **189-point direct witness** this
census certified at `d = 11` (`data/fs61/witness-11/`). Every `evidence` cell above reading `checker` means the
frozen independent checker `tools/fs58_check_witness.py` printed `CERTIFIED` on that row's own witness, and nothing
more.

