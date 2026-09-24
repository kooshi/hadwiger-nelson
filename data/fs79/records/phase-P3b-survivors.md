# FS-79 phase P3b — the exact Θ₄ tool aimed at phase 0's survivors

*The P3b implementer (de Bruijn standard, Opus 5.5), 2026-09-24, desktop (16 physical cores / 32 threads,
128 GB). Close-inventory item 98 (G72's *Do*: point a new exact decision procedure at the open instances the day it lands).
Tools: `tools/fs79_p3b_theta4.py` (new; imports last night's `tools/fs79_p3_theta4.py` and phase 0's code read-only). Data:
`data/fs79/p3b/`. Every witness is checked by the untouched phase-0 checker `tools/fs79_p0_check.py`.*

## Registration (written and committed before the first run)

**The question.** For each of phase 0's seven minimal survivors Λ_M (M = 2448, 2328, 2400, 4200, 10920, 14280, 24360; 84 to 852
unit vectors), then the five non-minimal ones containing Λ₄₂₀₀ (12600, 16800, 21000, 25200, 29400): does Θ₄ = {θ ∈ Hom(Λ, ℝ) :
θ(u) mod 1 ∈ [1/4, 3/4] for every u ∈ U} have a point, and with what margin min_u (‖θ(u)‖_{ℝ/ℤ} − 1/4)?
- margin > 0: a full-dimensional cell, so the lattice is **four-colourable and loose** (F = P = 0, P3's five-step argument);
- margin = 0: a four-colouring from a lower-dimensional cell;
- Θ₄ empty, certified only by an exhausted exact tree with Farkas leaves — **no circular colouring, not a refusal of four colours**;
- otherwise undecided at the cap. Then full quotients Λ/NΛ at N = 13–24 on whatever stays uncoloured.

**What is and is not claimed.** Four-colourability and looseness from certified witnesses only. Nothing here can show that a lattice
needs five colours, and a lattice with no Θ₄ point may still be four-colourable (a non-circular colouring).

**Predictions** (registered before any finder, tree or quotient run on a survivor):

| id | prediction | probability |
|---|---|---|
| B-1 | of the seven minimal survivors, the number coloured at four colours in this phase (Θ₄ point or quotient at N = 13–24): **0** | 0.40 |
| | **1 or 2** | 0.40 |
| | **3 or more** | 0.20 |
| B-2 | of the seven, the number found **loose** (a margin > 0 Θ₄ witness): **0** | 0.65 |
| | **1 or 2** | 0.28 |
| | **3 or more** | 0.07 |
| B-3 | at least one of the seven gets a **certified** empty Θ₄ (an exhausted exact tree within the 20-minute cap) | 0.35 |
| B-4 | a quotient at N = 13–24 colours at least one survivor | 0.25 |
| B-5 | if any survivor has a Θ₄ point, the smallest (Λ₂₄₄₈, 84 unit vectors) is among them | 0.60 |

*Why.* Phase 0's float finder stopped at its first point and found one on L21cc6506 (60 unit vectors) and on ten other lattices, so
it does detect nonempty Θ₄ at this size; its failure on the survivors is weak evidence of emptiness, weaker for the small ones (84–100
vectors) than for the large ones. A Θ₄ point of Λ_Y restricts to one of every Λ_X ⊆ Λ_Y, and the survivors have 1.4 to 14 times
L21cc6506's constraints on the same four-dimensional torus; each ± pair removes half the torus, so for the 180–852-vector lattices I
expect emptiness. Quotients at N ≤ 12 already refused the survivors at most N, and a quotient colouring at N restricts to every
sublattice, so larger N help only where the smaller ones were inadmissible or undecided.

**Controls, each with both outcomes reachable.**
1. L21cc6506 (Λ₄₂₀) through the same finder must come back **loose** (margin > 0), matching P3's witness or another. A margin ≤ 0 or no
   point means the finder is weaker than a 3-minute smoke tree and its nulls mean nothing.
2. A planted wrong θ (the found θ with one coordinate moved by 1/8) must be **refused** by the phase-0 checker. A pass means the checker
   cannot see a wrong witness of this kind.
3. At three colours: the finder cannot show emptiness, so it must simply find **no** Θ₃ point on L21cc6506 (row 79: Θ₃ = ∅, two
   certificates); a point found means a defect. The exact tree at k = 3 on the smallest survivor is run only if cheap. Λ₂₄₄₈ does not
   contain Λ₄₂₀ (420 ∤ 2448), so its Θ₃ is not known in advance: that run is a measurement, not a control (by the three-colour
   criterion, Θ₃ empty would mean Λ₂₄₄₈ is not three-colourable), and it is reported as such.

## What happened

**The tool** (`tools/fs79_p3b_theta4.py`). It computes the frame for any M. U = `units_be(M, 167)`, H = hnf(U), and B is a
reduced ℤ-basis from P3's dual LLL. On Λ₄₂₀ it reproduces P3's basis exactly. B is checked both ways: its rows lie in Λ with |det| 1
in Hermite coordinates, hnf(B) = H, and every unit vector is integral in B. Unit counts agree with phase 0 on all twelve lattices.

The finder maximises the margin t ≥ 0 over x ∈ [0,1]⁴ and the integer band variables. That is a branch over band choices guided by
LP relaxations, done by HiGHS branch-and-cut (`scipy.optimize.milp`). HiGHS only proposes a band vector. The tool then re-solves the
cell's maximum margin exactly in Fractions (the exact simplex of `fs73_theta_lib`) and writes a rational point. The untouched
`tools/fs79_p0_check.py` checks every witness. Records: `data/fs79/p3b/steps.jsonl`, one fsynced line per (lattice, step).

**The Θ₄ step on the seven (05:31–05:50).** Each lattice got 1,100 s, the seven running in parallel under the heavy lock. On all
seven HiGHS reached its time limit with **no incumbent**: it found no point, even in floating point, with every u in band. The seven
are therefore **undecided at the cap**. That is not evidence of emptiness: control 3 shows the same engine cannot prove Θ₃(L21cc6506)
= ∅ in 300 s.

**Calibration (added; G21).** The controls above only showed the finder working at L21cc6506's coefficient size (ℓ¹ ≤ 298). The
survivors' coefficient vectors are about five times larger: ℓ¹ max 1,644–1,751 on the three smallest, up to 17,430 on Λ₂₄₃₆₀. So
the same finder was pointed, at 150 s each, at three lattices where phase 0 had found a Θ₄ point.
- **All three came back loose, each certified**: Λ₂₃₅₂ (68 unit vectors, ℓ¹ max 1,548, the survivors' size), cell margin 93/668;
  Λ₁₅₈₄, cell margin 173/11844; Λ₁₃₄₄, cell margin 141/668, which HiGHS reports optimal, with a witness of order 167.
- The survivors' nulls are therefore *calibrated*: at the survivors' coefficient size the finder found loose cells on three of
  three known positives in 150 s, and it found nothing on the survivors in 1,100 s.
- They are still not certificates. The calibration lattices have 68 unit vectors against the survivors' 84–852, and time to first
  point was not recorded (scipy reports only the end state).

**The exact emptiness tree was priced, not run.** P3's `certify_node` (imported) ran on one core for 60 s.
- L21cc6506: 210 root children; the first subtree was unfinished at 30,435 nodes.
- Λ₂₄₄₈: 476 root children; the first subtree was unfinished at 31,144 nodes, at about 520 nodes/s.
- Its least quadruple determinant is 4,928,028, against L21cc6506's 34,650 (142×). P3's projection for L21cc6506's full tree was
  1.7·10⁷ nodes.
- Projection for Λ₂₄₄₈: at least ~1.5·10⁷ nodes if its first subtree is typical, which is itself an underestimate since that subtree
  had not finished (≥ ~17 minutes on 28 workers at ~520 nodes/s each). If nodes scale with the determinant, ~2·10⁹ (~38 hours on 28
  workers). Both are projections, not counts. **The lower projection alone does not exclude a 20-minute run**; I did not attempt one
  because the determinant scaling puts the tree at hours to days, a capped exact tree proves nothing, and each lattice's 20-minute
  Θ₄ budget had already gone to the finder. So **Θ₄ emptiness was not attempted on any survivor**; a real price would be one
  subtree run to completion (minutes), then a sample of subtrees.

**Quotients (05:53–06:33).** Phase 0's and FS-73's code, by import: kissat with the pinned edge and precedence break, 300 s per ask,
gap-aimed then plain. Every refusal was re-asked by cadical on the unbroken encoding. The order was round-robin: N outer, lattices
smallest first. **The 30-minute cap was overrun by about 9 minutes**, because it is checked between asks and the last pair (Λ₂₄₄₈ at
N = 15) ran its full 2 × 300 s.

| lattice | N asked (both aims) | result |
|---|---|---|
| Λ₂₄₄₈ | **11** (the phase-0 gap), 13, 14, 15 | refused at 11 and 13 (replicated); refused at 14 by **one solver** (kissat UNSAT; cadical UNKNOWN at 300 s); **undecided at 15** (UNKNOWN, both aims) |
| Λ₂₃₂₈ | 13, 14 | **undecided at 13** (UNKNOWN, both aims; phase 0 also undecided there); refused at 14 (replicated) |
| Λ₂₄₀₀ | 13, 14 | refused at 13 (replicated); refused at 14 by **one solver** (cadical UNKNOWN at 300 s) |
| Λ₄₂₀₀ | 13 (14 inadmissible) | refused at 13 (replicated) |
| Λ₁₀₉₂₀ | none: 13, 14 inadmissible, and the cap fell before N = 15 | **no admissible N ≤ 15 asked** (its first admissible N ≥ 13 is 16) |
| Λ₁₄₂₈₀ | 13 (14 inadmissible) | refused at 13 (replicated) |
| Λ₂₄₃₆₀ | 13 (14 inadmissible) | refused at 13 (replicated) |

No quotient coloured any survivor. Every N ≥ 16 is unasked, and N = 15 was asked only at Λ₂₄₄₈. Admissible N ≤ 24 per lattice:
2448: 5, 7, 10, 11, 13, 14, 15, 16, 19–23; 2328: 5, 7–11, 13–24; 2400: 7, 9, 11, 13, 14, 17–19, 21–23; 4200, 24360: 8, 9, 11, 13,
16–19, 22–24; 10920: 8, 9, 11, 16–19, 22–24; 14280: 8, 9, 11, 13, 16, 18, 19, 22–24. A refusal at Λ_X carries up to every Λ_Y ⊇ Λ_X
(a colouring of Λ_Y/NΛ_Y restricts), so Λ₄₂₀₀'s refusal at 13 holds for the five lattices that contain it. These are
solver verdicts with no checked proof: tools grade, as in phase 0.

**A correction to phase 0's survivor table** (`data/fs79/records/phase-P0.md`). The table says of Λ₂₄₄₈ that "every other N ≤ 12
is inadmissible". **N = 11 is admissible at Λ₂₄₄₈ and was never asked**: phase 0's `quot_total` ran out after N = 10, where the plain
ask was UNKNOWN. Asked here, **Λ₂₄₄₈ refuses at N = 11** (gap and plain UNSAT in about 1 s each, both replicated by cadical). The
survivor row should read: refused at N = 5, 7, 11, 13; refused at N = 14 by one solver; undecided at N = 10 (plain) and N = 15.

**The five containing Λ₄₂₀₀** (12600, 16800, 21000, 25200, 29400) are **dominated by Λ₄₂₀₀, and no separate search is needed**. A
Θ₄ point on Λ_Y ⊇ Λ₄₂₀₀ restricts to a Θ₄ point on Λ₄₂₀₀, since U₄₂₀₀ ⊆ U_Y and the band condition survives restriction. A success
on any of the five would therefore be a Θ₄ point of Λ₄₂₀₀ that the same finder missed in 1,100 s on the smaller problem (the owner's
note). A 1,100 s run on the five was launched at 06:33, then **stopped at about 06:37** on that argument. It was stopped by process
group 1946610 and verified by effect: no process left, the lock free, `steps.jsonl` static for 10 s. It wrote no record, since a find
step writes only on completion. **What the kill forfeits:** five searches that were dominated anyway. Their quotient status is
inherited: refused at N = 8, 9, 11 (phase 0) and 13 (here) through Λ₄₂₀₀.

## Status of each minimal survivor, at its exact scope

| survivor | Θ₄ | quotients (this phase) |
|---|---|---|
| Λ₂₄₄₈ (84) | no point found by HiGHS at 1,100 s (calibrated: 3 of 3 known positives found loose at 150 s); emptiness not attempted (projected ≥ ~1.5·10⁷ nodes, ~2·10⁹ by determinant scaling) | refused N = 11 (**phase-0 correction**), 13; N = 14 one solver; N = 15 undecided |
| Λ₂₃₂₈ (92) | the same | N = 13 undecided; refused N = 14 |
| Λ₂₄₀₀ (100) | the same | refused N = 13; N = 14 one solver |
| Λ₄₂₀₀ (180) | the same | refused N = 13 |
| Λ₁₀₉₂₀ (324) | the same | no admissible N ≤ 15 asked |
| Λ₁₄₂₈₀ (324) | the same | refused N = 13 |
| Λ₂₄₃₆₀ (852) | the same | refused N = 13 |

"No Θ₄ point found" is not "no circular colouring", and neither is a refusal of four colours. None of this bears on whether any of
these lattices, or ℚ(√167)'s plane, needs five colours.

## Controls

| control | outcome | status |
|---|---|---|
| 1. L21cc6506 through the finder must come back loose | loose twice: in the 120 s run the cell's exact maximum margin was **3/56** (P3's witness margin was 1/324); the point used has margin 1289/32204. The 30 s run gave cell margin 23/580. Both CERTIFIED | passes |
| 2. A planted wrong θ must be refused by the phase-0 checker | the first witness with coordinate i moved by +1/8, for i = 0..3: refused 4 of 4, each THETA_OUT_OF_BAND | passes |
| 3. Θ₃ on L21cc6506: the finder must find no point | no point in 300 s. HiGHS also could not prove infeasibility in 300 s, so a finder null is uninformative | passes; this is why the nulls above are typed |
| 3′. The exact tree at k = 3 on Λ₂₄₄₈ (a measurement) | not run: it is priced like the k = 4 tree (476 root children at k = 4) and cannot be called cheap | skipped |
| Calibration: three known positives at the survivors' coefficient size | 3 of 3 loose, CERTIFIED | passes |
| A witness read at the wrong k | Λ₁₅₈₄'s witness has ‖θ(u)‖ ≥ 1/4 + 173/11844 < 1/3, so read at k = 3 it must fail: refused THETA_OUT_OF_BAND | passes |

Transcript: `data/fs79/p3b/checker-run.txt` (7 CERTIFIED, 5 refused, each refusal a planted or expected one).

## Predictions, scored

| id | registered | outcome |
|---|---|---|
| B-1: 0 of the seven coloured | 0.40 | **won** |
| B-1: 1 or 2 / 3 or more | 0.40 / 0.20 | lost |
| B-2: 0 loose | 0.65 | **won** |
| B-3: at least one certified empty Θ₄ | 0.35 | **lost**: not attempted; the tree was priced far beyond the cap |
| B-4: a quotient at N = 13–24 colours one | 0.25 | **lost** |
| B-5: Λ₂₄₄₈ among any survivors with a Θ₄ point | 0.60 | not scored (no survivor had a point) |

## Instrument notes (for the close)

- **The calibration was not in the brief's controls, and it changed what the nulls mean.** Control 1 ran at ℓ¹ ≤ 298. The survivors
  sit at ℓ¹ ≈ 1,100–17,000. A finder that works on small coefficients could plausibly fail on large ones, and only a known positive at
  the survivors' scale (Λ₂₃₅₂) separates that from emptiness. G21: a control the instrument can see, at the scale of the question.
- **HiGHS finds loose cells quickly and proves emptiness badly.** It found L21cc6506's 3/56 cell in under 120 s and Λ₁₃₄₄'s optimum
  in 107 s. On L21cc6506 at k = 3, where FS-73's exact tree proved emptiness, it proved nothing in 300 s. Its role is the finder's,
  and nothing more.
- **scipy reports no node count when no incumbent exists** (the `nodes: -1` in the survivors' records), so the search effort on the
  survivors is known only as wall time (1,100 s, one core each).
- **A pgid read by pattern matched its own shell** once (`pgrep -f` returned two pids at launch, one of them the pgrep's shell). It
  was caught before any use by reading the job's `ps` row, and the correct pgid (1909331) was written. No kill was affected.

## Decisions (four parts)

| choice | alternative | why this one won | confidence |
|---|---|---|---|
| HiGHS branch-and-cut as the margin finder, with an exact re-solve of its proposed cell | a hand-written LP-guided depth-first search (phase 0's finder, maximising margin) | the same branch over band choices, in compiled code with presolve and cuts; it found loose cells on 4 of 4 known positives | medium: a different search order might find what HiGHS missed; nothing here rules that out |
| price the exact tree, not run it | run it on 28 workers for 20 minutes | a capped exact tree proves nothing; the pilot (476 root children, first subtree unfinished past 31,000 nodes) gives only a lower bound of ~17 minutes, and determinant scaling gives ~38 hours | medium: if the first subtree is typical and small, the tree for Λ₂₄₄₈ could fit in about an hour, and one completed subtree would say so |
| quotients round-robin over N (smallest N on every lattice first) | lattice by lattice to N = 24 | small-N asks are the cheap, decisive ones (most refused in seconds); lattice-by-lattice would have spent the cap on one lattice | high |
| stop the five dominated runs | let them finish (about 15 more minutes) | a success there would be a Θ₄ point of Λ₄₂₀₀ that the same finder missed on the smaller problem; the owner offered the choice | high |

## Theorems this phase proved

| id | statement | grade | proof / address |
|---|---|---|---|
| P3b-T1 | L21cc6506 has a Θ₄ cell of maximum margin exactly 3/56 (so loose, F = P = 0, reconfirming P3-T3; P3's witness point had margin 1/324) | cert (phase-0 checker) + tools exact (the cell's LP) + hand (P3's argument) | `data/fs79/p3b/witnesses/L21cc6506-theta4-loose.json`; `steps.jsonl` |
| P3b-T2 | **Λ₁₃₄₄, Λ₁₅₈₄ and Λ₂₃₅₂ are four-colourable and loose** (F = P = 0 at four colours): cells of maximum margin 141/668, 173/11844 and 93/668. Phase 0 had them only as four-colourable | cert + hand (P3's five-step argument, which holds for any lattice) | `data/fs79/p3b/witnesses/{1344,1584,2352}-theta4-loose-cal.json` |
| P3b-T3 | **Λ₁₃₄₄ and Λ₂₃₅₂ are three-colourable**: their Θ₄ witnesses have ‖θ(u)‖ ≥ 77/167 and ≥ 260/668 > 1/3 for every u, so they lie in Θ₃. Λ₁₃₄₄'s form has order 167 | cert (phase-0 checker at k = 3) | `data/fs79/p3b/witnesses/{1344,2352}-theta3-cal.json` |
| P3b-T4 | Λ₂₄₄₈ is admissible at N = 11 and Λ₂₄₄₈/11Λ₂₄₄₈ is not four-colourable (a correction to phase 0's table) | tools (kissat and cadical UNSAT; no proof checked) | `data/fs79/p3b/quotients.jsonl`; `steps.jsonl` quot-N11 |
| P3b-T5 | Quotient refusals at N = 13: Λ₂₄₄₈, Λ₂₄₀₀, Λ₄₂₀₀ (so its five superlattices), Λ₁₄₂₈₀, Λ₂₄₃₆₀; at N = 14: Λ₂₃₂₈ (replicated); Λ₂₄₄₈ and Λ₂₄₀₀ (one solver) | tools | as above |
| P3b-T6 | Least quadruple determinants in the reduced basis: 34,650 (L21cc6506), 4,928,028 (Λ₂₄₄₈). The exact tree on Λ₂₄₄₈ has 476 root children | tools exact | `steps.jsonl` price-tree-k4 |

*Kernel decision:* declined for all. P3b-T2 and P3b-T3 concern lattices that are not on the instance list; T4 and T5 are solver
verdicts that feed only the survivor table.

## Regenerate

```
python3 tools/fs79_p3b_theta4.py frame --ids L21cc6506 minimal upper
python3 tools/fs79_p3b_theta4.py find --ids L21cc6506 --k 4 --cap 120          # control 1 (and --cap 30 --tag ctl2)
python3 tools/fs79_p3b_theta4.py find --ids L21cc6506 --k 3 --cap 300          # control 3
python3 tools/fs79_p3b_theta4.py find --ids <M> --k 4 --cap 1100               # each survivor (run in parallel under the heavy lock)
python3 tools/fs79_p3b_theta4.py find --ids 2352 1584 1344 --k 4 --cap 150 --tag cal   # calibration
python3 tools/fs79_p3b_theta4.py price --ids L21cc6506 2448 --k 4 --cap 60
python3 tools/fs79_p3b_theta4.py quot --ids 2448 --nmin 11 --nmax 11; python3 tools/fs79_p3b_theta4.py quot --ids minimal --nmin 13 --nmax 24 --total 1794
python3 tools/fs79_p0_check.py data/fs79/p3b/witnesses/<file>.json
```
Every step resumes: a (lattice, step) line already in `steps.jsonl` is skipped. The quotient asks take the heavy lock per ask
themselves, so that command is never wrapped in `flock`.
