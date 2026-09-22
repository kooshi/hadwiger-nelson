# FS-70 phase 1 — the asks: what landed

*Written 2026-09-22 by the phase-1 implementer (Opus 5), against `plans/FS70-five-over-sqrt3-sqrt5.md` §4 phase 1,
`data/fs70/records/phase-0.md`, and the owner's brief and review §4. Machine: the desktop (16
physical cores / 32 threads, 125 GB). Every number names the command that produced it.*

---

## 1. Headline

**(filled at the close)**

---

## 2. The correction that had to be made before any ask: `eq` and `sep` are named by their CONCLUSION

The owner's brief says: *"`eq (A, B)` — the pair **contracted** into one vertex …; `sep (A, B)` — `A = 0, B = 1`."*
That is the wrong way round, and the brief itself names the reason it matters (*"they differ by one literal and a
wrong one reads as a jackpot"*). The plan's §1.2 — *"forced-equal ask at `(A, B)`: `A = 0, B = 1`; virtual-edge ask:
`A = B = 0`"* — and `fs70_fabric.write_shape`, whose `eq_*` CNF pins `[(i0, 0), (jt, 1)]` and whose `sep_*` CNF pins
`[(i0, 0), (jt, 0)]`, both name a pin by what its **refutation** proves, not by the constraint it carries:

| pin | the formula imposes | UNSAT means | SAT means |
|---|---|---|---|
| `control` | a unit triangle pinned 0, 1, 2 | the fabric itself is 5-chromatic — **halt and verify** | a 4-colouring exists |
| **`forces δ`** (`eq`) | `c(0) ≠ c(δ)`: the pair joined by an edge, a common neighbour pinned to a third colour | **Forces**: every proper 4-colouring gives `0` and `δ` one colour — the milestone's target | some 4-colouring separates them |
| **`separated δ`** (`sep`) | `c(0) = c(δ)`: the pair **contracted** | **Separated**: a virtual edge at `δ` (Haugland's shape) | some 4-colouring joins them |

The mathematics decides it: the chain theorem (G55) consumes a **forced-equal** pair, and `Λ_forced` — the screen
that says which targets are worth asking — is by construction the set of `δ` that *every* additive colouring makes
monochromatic, which is the screen for `forces`. Contracting the pair asks the opposite question. The brief's
target list (`eq 4/3` chain 3, `eq 4/7` chain 2, `sep √3`) is consistent with this reading throughout; only its one
sentence about the encoding is inverted, and the likeliest cause is that phase 0's positive control — Haugland's
`A = B` ask — really is a *contracted* encoding, because his object carries a **virtual edge**, not a forced pair.

`tools/fs70_ask.py` prints `UNSAT would mean: …` before every ask and writes the conclusion into the row, so no
verdict in `asks.jsonl` can be read the wrong way round.

---

## 3. The instrument

`tools/fs70_ask.py run DIR PIN` — one ask, appended to `data/fs70/asks.jsonl` at its verdict, with an in-flight
file carrying the pid, the process group and the resume command while it runs.

**The calibration** (`python3 tools/fs70_ask.py selftest`), whose answer is known by hand both ways: **K₅ minus an
edge** — `A` and `B` non-adjacent, both joined to a triangle. Every proper 4-colouring gives the triangle three
colours and `A`, `B` the fourth, so the pair is forced equal; `forces` must refuse it and `separated` must colour
it, and the faithful twin (one triangle edge dropped) must colour both. The geometry is deliberately not
unit-distance — two plane points have at most two common unit-distance neighbours, so no unit-distance graph
contains K₅ minus an edge at all — because this calibrates the encoder and the solvers, not the fabric.

**Three plants, each refused for its named reason:**

| plant | what it breaks | how it was seen to refuse |
|---|---|---|
| `pin_swapped` | `forces` pins the pair to the *same* colour (the `separated` constraint under the `forces` name) | *"twin under forces:4/3 read UNSAT, and by hand it is SAT"* — the false-jackpot direction |
| `edges_dropped` | one edge lost from the graph | *"forced under forces:4/3 read SAT, and by hand it is UNSAT"* — a lost edge makes colouring easier, so a refusal vanishes and a null looks real |
| `sha_unchecked` | the graph asked need not be the graph recorded | *"a point moved after the file was written was accepted"* |

**A fourth plant was written and removed because it fired on nothing**, which is worth recording: under `forces`
the edge joining the pair is **redundant** — pinning `c(A) = 0` and `c(B) = 1` already says `c(A) ≠ c(B)`, and the
edge only strengthens propagation. What is not redundant is the third pin, which is sound only because `A`, `B`
and `w` really do form a triangle once the edge is added.

**Two cube engines, because the obvious one is unusable in two different ways.** PySAT's Kissat **ignores
assumptions** (it warns and carries on), so every cube would silently be solved as the whole instance — refused by
name. PySAT's CaDiCaL takes assumptions but supports neither `incr=True` nor `solve_limited`, so it can carry no
per-cube budget — reported in the row (`per_cube_budget: null`), not worked around. The default `auto` uses phase
0's proven file-based kissat pass below four million clauses and in-process CaDiCaL above it. The engine is now
constructed **in the parent**, where an error is visible: an exception inside a `multiprocessing` pool initializer
makes the pool retry it for ever with no output at all, which is how the first version of this cost twenty minutes
and looked like a hung solver.

---

## 4. The Kempe screen: the 2-unit route is dead by derivation, not at a budget

**(section filled below as the screen lands)**

---

## 5. The asks

**(table filled as verdicts land)**

---

## 6. Decisions

**(filled at the close)**

---

## 7. Where the plan, phase 0 or the brief was wrong

**(filled at the close)**

---

## 8. WORKFLOW step 9's two sweeps over this phase's additions

**(filled at the close)**
