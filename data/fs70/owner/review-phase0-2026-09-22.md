# FS-70 — the owner's review of phase 0 (the fabric), 2026-09-22

*Scored by artifact against the phase's own record (`data/fs70/records/phase-0.md`, commits `5a984059` … `6100877e`). Implementer:
Opus 5, ≈495k tokens (over the ~400k asked; everything persisted, nothing lost). Every check below is my own code or my own hand,
none of it shared with `tools/fs70_*`.*

## 1. Verdict: ACCEPTED. Every deliverable lands; three corrections to the plan are right; two findings are adopted.

| what | how I checked | result |
|---|---|---|
| **The screen** (`screen.jsonl`, 20 lattices) | `po_screen_lattice.py` (mine: generators closed under ζ₁₂ and conjugation, sympy HNF, unit vectors by box enumeration over every divisor of `M`, all 4⁸ homomorphisms) on three rows of my choosing — `zeta12+u3+q7`, `zeta12+u3+v4`, `group:u3:2` | `g = 60 / 300 / 60`; ℤ/4 `1296 (432, 432, 1296, 1296) / 0 / 1296 (…)`; Klein `1296 (0, …) / 0 / 1296 (0, …)` — **all three rows exactly** |
| **The atlas** (2,020 unit vectors to denominator 42) | my box enumeration at every denominator 1–30 (1,172 vectors); the `two_unit` flag against my characteristic-polynomial 2-integrality test on 60 random rows | **identical at every denominator; 0 flag mismatches** |
| **Haugland's `G₁` and its refusal** (the positive control) | his four counts (`T₅` 1042, `T₆` 12856, `G₁` 740 / 3,985) match the paper; I rebuilt the contracted instance from their `G1.json` (739 / 3,983, pins `(124,0),(1,1),(274,2)`, branching set `[83, 286, 95, 102, 148, 253, 260]` — all reproduced), showed the ledger's 1,458 cubes are **exactly** the survivors of the complete 4⁷ split (the pruned cubes each violate an edge among pinned or branched vertices, a sound refusal), then **re-solved all 1,458 with my own CNF and PySAT's CaDiCaL 1.9.5** (`haugland-replay/`, 7,758 CPU s, max 39 s a cube) | **1,458 / 1,458 UNSAT, same cube set** — the instrument sees Haugland's forced pair one field over, on the owner's own replay |
| The tools' self-tests | both green; their six built-in plants fire by name; **two plants of my own** in scratch copies — the field product's `15·d₁d₂` changed to `14·d₁d₂` (refused: `(1/4, √15/4)` no longer a unit vector) and the screen's `≠ 0` test loosened to `≥ 0` (refused: 65,536 colourings, not 1,296) | both refused with the right message |
| The structure instruments' control | `structure-control.json`: `3Λ` on the `ζ₁₂,v` ball SAT in 0.33 s with the lifted colouring verified on all 111,990 edges; the `S₂` twin UNSAT by 4,140 self-loops with no solver; `2Λ` UNSAT by self-loops; `4Λ` SAT (which corrects the planner's §2.3 — asked as existence, a `4Λ`-periodic colouring of that ball exists) | both outcomes reachable and seen |
| The record against the files | read in full; the two step-9 greps recorded; nothing running afterwards; tree clean | in order |

## 2. Findings adopted, and what they do to phase 1

1. **The triangle lemma** (record §4(i)), checked by hand: for a proper additive `φ : Λ → ℤ/4` on any lattice holding the unit
   triangle, `φ(i√3) = 0 ⟺ φ(2) = 0 ⟺ φ(1) = 2`. So the √3 virtual edge and the distance-2 virtual edge die together, and P1's
   open part is one measured bit per lattice (does a proper `φ` with `φ(1) = 2` exist? — yes, exactly a third of them, on all nine
   lattices with any `φ`; the thirds stay measured). **P1 re-graded once more: a two-line lemma plus one measured bit.**
2. **`δ = 4/7` is chainable with two copies** (`ρ₁₅ + ρ̄₁₅ = 7/4`; `4/7 > 1/2`): a four-colour forced pair at 4/7 closes with **one
   ρ₁₅ spindle**, on every lattice holding `1/7` (the 7-family). **Added to phase 1's targets, ahead of 8/3.** And `δ = 4` closes
   with three copies, not four (`1/4 = v̄ + v² − v̄²`).
3. **The cube pass is the first resort, not the second** (P8 lost by two orders of magnitude: eight single-solver configurations,
   up to 27 min, no verdict; 1,458 cubes on 22 cores, 436 s). Phase 1's stop rule is rewritten accordingly (§4 below).
4. **L4 is two lattices** (`…+q7+s7` at `M = 42`, `…+q5+s5` at `M = 30`); as one its denominator is 630 and no complete saturation
   exists at any price. The generators-only `twounits:*` rows are over-approximations whose *kills* are not sound (flagged in the
   file) — right, and P1's stability reading rests on them only as an upper bound.
5. **`S₂` at sums of ≤ 4 is 478,333 points at degree 14.47, and its 60 generators are their own saturation** (no `partial` risk on
   L1). The lens with an m-core is the size-efficient shape.

## 3. Two things I noticed that the record does not say

* **`δ = 2/3` is chainable with three copies** (`3/2 = 1 + v + v̄`; the record's chain pool stopped at denominator 8 and length 4
  and did not list it) — **but it is additively dead on 2-unit fabric**, and I wrote the opposite in this note's first draft: on a
  lattice with `1/3`, `3φ(1/3) = φ(1)` gives `φ(1/3) = 3φ(1)`, so `φ(2/3) = 6φ(1) = 2φ(1) = φ(2)`, and the two-thirds of the
  colourings with `φ(1)` odd separate `0` from `2/3` exactly as they separate `0` from `2` (`2/3 ≡ 2 (mod 4Λ)`). It joins `eq 2` on
  the wall-breaking lattices L2/L3, where no additive colouring exists. Caught by re-deriving before ruling — the direction the error
  pointed (a new target) is the flattering one.
* The record's cost line for the control (15.7 min of single-threaded geometry) says the ℚ(ζ₈₄) arithmetic is the slow part of
  any Haugland-shaped ask one field over; over ℚ(√3,√5) the integer 8-tuples are cheap (`T₈`: 478k points in 23 s), so this
  does not transfer.

## 4. Rulings for phase 1 (one fresh Opus implementer)

1. **Lattices and targets, in order:** L1 `S₂` (Harder's shape) at `eq 4/3`, `eq 8/3`; L1′ `zeta12+u3+q7` at `eq 4/7`
   (chain 2), `eq 4/3`; L2 `S₂ + ζ₁₂{v, v̄}` and L3 `S₂ + ζ₁₂{w, w̄}`: control first, then `eq 2`, `eq 2/3`, `sep √3`, `eq 4/3`; L4 as the
   two halves; L5 the denominator-6 family — every target read off `Λ_forced` before it is asked.
2. **Shapes:** the lens (Haugland's `T_n` between `0` and the target, then the m-core) before the word ball; the word ball at
   sums of ≤ 3 (degree 11.2) as the calibration point and ≤ 4 (degree 14.5, 478k points) only where the lens has refused nothing
   at its largest affordable n.
3. **Budgets and stop rules:** per ask — one single-solver attempt at 10 min (kissat) for the SAT direction, then **cube-and-conquer
   at once** (`tools/fs70_cube.py`, branching on the highest-degree vertices, 22 jobs, each cube's verdict appended as it lands),
   per-ask cap **40 CPU-hours**; an ask past its cap is `UNKNOWN` with its encoding named and the sweep moves on. Phase cap **240
   CPU-hours** before I re-rank (the plan's 48 was written before P8 lost).
4. **On a refusal:** HALT the sweep; rebuild the graph in a fresh process; re-derive its edges; re-ask by a second cube pass with a
   different solver; check the pin is the intended one (`eq`, not `sep`); hand back to me with the ledger — I replay it as I did
   the control before phase 2 starts.
5. **On a colouring at every affordable shape:** the structure instruments' readings (quotient screen at 3, 5, 7; period screen;
   the imposed-quotient ask) or the null is not typed.
