# Shifted-sequence colourings of the 23 board — a tangent from the puzzle (2026-10-07)

Kooshi's idea, from playing `visualizations/unit-step-puzzle/`: fill the board deterministically — place a colour, move
by one clash step, place the next colour, repeat. Made exact as a family: **one master sequence `W` of `q` colours laid
along a direction `v`; each of the `q` lines parallel to `v` carries it from its own offset `g(u)`**,
`c(t·v + u·w) = W[(t + g(u)) mod q]`. Straight stripes are the case `g` linear. Up to the graph's symmetries there are
two direction types (`v` a multiple of a clash step, or not); both are run.

Run by Keryx in the search role, at Kooshi's word, outside any milestone. **Not filed** (no ledger row, no queue line).

| board `q` | least colours in the family | straight stripes (row 101) | the board's own number |
|---|---|---|---|
| 7 | 4 | 4 | 4 |
| 11 | 6 | 6 | 5 |
| 19 | 5 | 5 | 5 |
| 23 | **8** | 8 | 6, 7 or 8 (open) |

At 23: no choice of offsets lets one colour sit at four positions of the sequence (a class of 92 cells) — UNSAT for both
direction types — so each colour holds at most 69 cells and seven colours cannot cover 529; the seven-colour instance is
UNSAT directly as well. Eight is found.

**Grade**: [tools], one mind. Every colouring found is re-checked cell by cell against the 24 steps. The "no" answers at
23 are the solver's word (kissat 4.0.4), no proof logged or checked. Controls: `offsets_search.py` (a plain backtrack
over offsets, exhaustive, no solver) and `offsets_sat.py` (one SAT instance per case) agree at 7, 11 and 19, on both the
yes and the no side; the family's 6 at 11 and 8 at 23 equal row 101's values for straight stripes.

**A remark, by hand, unchecked by a second mind**: a colouring of the 23 board with fewer than 23 colours that satisfies
`c(x + s) = π(c(x))` for a nonzero `s` and a permutation `π` of the colours has `π = id` on the colours used (`π²³ = id`
there, and a permutation of fewer than 23 things with every cycle length dividing 23 is the identity), so it is constant
along `s` — a function of one linear form, a straight stripe colouring. With row 101: **a colouring of the 23 board with
at most seven colours has no translation symmetry, even up to a permutation of colours.**

Files: `offsets_search.py` (run on 7, 11, 19; too slow at 23 in Python, stopped), `offsets_sat.py`, `out/q23-sat.txt`.
Reproduce: `python3 scripts/slot.py --mem 4 --name puzzle23 -- python3 data/puzzle23/offsets_sat.py 23 col 7` (about
four minutes) and `… 23 cls 4` (seconds).

## How many cells can one colour hold? (same day, second tangent; `one_colour.py`)

Kooshi: "It feels like the largest independent set could be solved by exhaustive exact search (with pruning and other
optimizations) by a more traditional computer science algo rather than SAT."

**The number that matters is 88.** 529 = 6·88 + 1, so six colours need one colour on at least 89 cells: **if no clash-free
set of 89 cells exists, the 23 board needs at least seven colours** (row 69's window would lose 23). Seven colours need
only 76. The certificate's ceiling is 105 (row 71).

| instrument | result | grade |
|---|---|---|
| exact branch and bound inside rotation-invariant families (order of the rotation: 24, 12, 8, 6) | best unions of orbits: 73, **85**, 81, 85 cells | exact within each family; sets re-checked |
| the same at order 4 | at least 85 | node cap hit — a lower bound only |
| tabu local search over all sets, 13 runs (7 from the stripes class of 69, 6 from random maximal sets of 62–64) | **87 cells in every run**, within about a second; **88 in none**, about 6–8 million swap moves each | a lower bound: α(Γ₂₃) ≥ 87, each set re-checked cell by cell (`out/one-colour*.txt` hold the sets) |

**What is and is not established.** Held at [tools]: a clash-free set of 87 cells exists, so α(Γ₂₃) ∈ [87, 105].
**Not established: that 87 is the maximum.** That every run stops at exactly 87 is a reading, with its killing test — one
clash-free set of 88. No earlier record of a lower bound on α(Γ₂₃) was found in a quick search of the ledger and the
grokkings (not a full check).

**What an exact answer would take** (unbudgeted, unqueued; a search-lane job when the budget returns): decide whether a
clash-free set of 89 cells exists. Notes for whoever plans it: (1) the board is vertex-transitive, so fix the origin in
the set and use the 48 symmetries fixing it; (2) the cheap bounds are far off — the largest clique is a triangle, so a
clique-cover bound is a third of what is left, and the certificate's 105 is final for its instrument — so plain branch
and bound will not prune until very deep; (3) for a vertex-transitive graph, α(Γ)/529 ≤ α(H)/|H| for every set of cells
H, so one piece H with an exactly computed α(H) < 0.1682·|H| proves it; because 87/529 = 0.1645 the piece must be nearly
as hard as the board (for a union of j parallel no-clash lines, j·3.783 ≤ α(H) < j·3.870: no integer fits below j = 10;
at j = 10 it would have to be exactly 38 of 230 cells, and that would give α = 87 outright); (4) Russian-doll search over
nested unions of lines is the classical algorithm of this shape.

**Corrections, same evening (found while fixing the claim list for the tool's planner).** (1) "No earlier record of a
lower bound" is wrong for the sibling repository: its independent-set tool already holds 87 at 23, sixteen threads
agreeing (`/home/kooshi/source/descent-engine/plans/WO-18-outcome.md` § 2.3) — measured there against the 106 that five
colours need, not against the 89 that six need. (2) "no integer fits below j = 10" is false: `87j/23 ≤ α(H) < 89j/23`
has the integer solutions 19, 23, 27 at j = 5, 6, 7 as well; j = 5 is out for whole lines, because one whole line is
already 23 clash-free cells. The corrected statement is `data/puzzle23/claims.md` S5.

## The tool (Kooshi's word, `REQUEST.md` K3) — state

- What it must decide is fixed in `claims.md` (D1–D3, S1–S6). S3–S5 are one mind's, by hand, unchecked.
- **The planner is launched** (21:5x UTC, 2026-10-07; job WO22-FP1, the Rust engineer of the sibling repository, Opus;
  brief `briefs/WO22-FP1-exact-independence-plan.md`, gate pass, generator `briefs/mk-wo22-fp1.py`). Its record will be
  in the sibling repository: `/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md` (it may rename it).
  It writes there and under that repository's `scratch/wo22/` only, commits locally, and does not push — the product
  owner (this session) reviews and pushes.
- **Next, at its hand-back**: review the plan by artifact (the commits exist; one measurement re-run); any statement it
  found false is corrected in `claims.md` by a dated line; then the implementer's brief (a fresh mind of the same agent
  type, on the plan), on the pattern of the planner's generator. The decisive run is DECIDE(23, 89).
- The milestone handoff (`plans/SESSION-HANDOFF-2026-10-07.md`) is untouched at Kooshi's word; this section is this
  tangent's handoff.
