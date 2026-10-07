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
