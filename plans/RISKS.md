# RISKS — the standing register of what could stop the descent

*Created 2026-09-03 on Kooshi's direction ("let's document the important ones and keep track of
them"), from the honest assessment at M52's cull. Maintained like the Frontier: every milestone
close re-reads every row, updates its status and its last measurement, and adds what the milestone
found. A risk is never deleted; a retired one keeps its row with the reason. Each row carries the
SIGNAL that would show the risk biting (the monitor), what we hold against it, and whose reading
it is when the reading is a person's.*

## R1 — The field wall (structural; could be fatal)

**The risk.** Every committed point lies in ℚ(√3, √11), the seed's own field (T14: all 1,767 glue
points, every unit edge an exact identity). Every seam-field unit graph ever closed here was
4-chromatic (M24–M26), the known 5-forcers need √5 or √7 (G1), and the unit part must become
5-chromatic before the descent can end (`SpareColour.lean`). If the design keeps selecting in-field
material, the loop cannot end however far the dial falls.

**Kooshi's reading (2026-09-03):** *either truly no kill needs any of the points we've thrown
away so far, or our algorithm has a blind spot.*

**Monitor.** The field census after every commit: **does a design ever keep an out-of-field
point?** (Today: 0 of 1,767, five commits.) And its sharper form: the per-field kill census —
of the pool points that kill classes in the profile, how many are out-of-field? (Not yet run.)

**The question it raises, answered by measurement:** *is it even possible for the field to
generate √5 or √7 material in a single iteration?* — the depth-1 pool's radicand square classes
(`tools/pool_field_census.py`, first run 2026-09-03; the numbers in the ledger row below). A glue
point of two points at distance `d` adjoins `√(4/d² − 1)`; over `K = ℚ(√3, √11)` the reachable
extensions are `K(√m)` for `m` in the square classes of those radicands; `3` and `11` are squares
in `K`, so the rational classes are `{1, 2, 5, 7, 10, 14, 35, 70}` plus the non-rational ones
(`1 + √3`-type radicands). `√5` needs a pair at `d² = 4/(1 + 5q²)` (`d = √(2/3)` at `q = 1`);
`√7` at `d² = 4/(1 + 7q²)` (`d = 1/√2`); `√15` (ρ₁₅'s field) at `d = 1/2`.

**Mitigation.** The copies' partner lattice (the first √5 material a composed object would hold;
registered in `plans/M53-iteration-5.md`); a design run restricted to out-of-field pool points as
a control; and the field-wall milestone (R5) that would say whether the wall is a theorem.

**Status:** OPEN, not yet biting (the dial is still falling on in-field material).

## R2 — The tail costs more than the head (the computability tightrope)

**The risk.** Cheap kills go first (P7's selection effect, M49); per-cheat halo cost rose 25 → 13 →
85 points across iterations 1–3 before the richer object cut it; the class count grows ~1.3–1.5×
per absent cheat (2,588,314 at 85 absent); refutations near a minimal set take an hour each and
accepted drops are sequential (WO-14 A4). The remaining cheats are the ones nothing has touched.

**Kooshi's reading:** *we'll optimize, throw more compute at it, come at it from different angles
with different fields, maybe even different mathematics altogether if need be. A matter of time,
compute, and brainpower.*

**Monitor.** The sub-batch curve at each floor (no affordable point = the tightrope failing); the
per-cheat halo cost per commit; the stall fraction (T11) across iterations (G33's falsifier).

**Mitigation.** The culler (WO-14), WO-16's licence holding, WO-15's exact minimum, the server
(§12 of M52 — for the PARALLEL parts only), the field change of R1's mitigation.

**Status:** OPEN, expected.

## R3 — The evidence standard slipping (manageable; a path exists)

**The risk.** Every commit rests on two SAT encodings agreeing; the one-hot carries palette-symmetry
breaking whose soundness is what the 3-bit re-encode checks. On the culled 167-set the 3-bit did not
finish in four hours. The kernel certificate of the final object is unbuilt; its refutation is at
five colours over thousands of points, plausibly 10–100× the 1581's.

**Kooshi's rule (2026-09-03):** *we should never rely on a single instrument to certify.*

**Monitor.** Any commit or cull whose second encoding is `unknown` at cap is reported as CANDIDATE,
never certified; the certify's 3-bit wall time per commit as a standing column.

**Mitigation.** Cube-and-conquer for the certify's refutations (the M52 §13 lever; a WO-12 item);
the M06 pipeline's geometry now known to apply (T14).

**Status:** OPEN; the culled set's certificate stands on one encoding until the long 3-bit run lands.

## R4 — Outgrowing the desktop (an inevitability)

**The risk.** The pool grows ~n²: 1.47 M points and ~8 GB per profile worker at 1,981 object points;
roughly four times that at 4,000. Two or three iterations from now the desktop cannot hold the
profile.

**Monitor.** The pool size and per-worker memory at every iteration (the memory pre-flight's own
refusal is the signal).

**Mitigation.** The server (two server nodes, 1.5 TB): WO-3's replan (courier + qualify), the pool
port, NUMA placement, the ferry format (M52 §12).

**Status:** OPEN, expected.

## R5 — The wall we could not name (if χ(ℝ²) = 5) — formalize the field wall

**The risk.** If the plane is 5-colourable no descent ends, and from inside the loop a hard stall
and an impossible one look the same; there is no stall criterion that separates them.

**Kooshi's direction (2026-09-03):** *formalize the field wall — new milestone.* Stub:
`plans/STUB-field-wall.md`. The two halves: the LATTICE CLOSURE lemma (the depth-1 lattice over
K-points lies in K adjoined the radicands' roots — an easy theorem that names exactly which fields
one iteration can reach) and the FIELD-WALL CONJECTURE (every finite unit-distance graph with all
points in K = ℚ(√3, √11) is 4-colourable). The conjecture cuts both ways: true, the descent must
leave K to end; false, its counterexample is a seam-field 5-chromatic unit graph — which is exactly
what the descent's unit part would be if it ever ended inside K.

**Status:** OPEN; the stub written 2026-09-03.

## R6 — Unknown-unknowns of the instrument kind

**The risk.** Instrument slips that read as findings have occurred about daily and every one was
caught by a control, a second encoding, or a row read against its log (the float √3, the phantom
duplicates, the near-unit copy chord, the CONTRADICTION message, the pgrep self-match). Exposures
left: the enumerator verifying itself with the certify as the only decorrelation; float tolerances
wherever exact arithmetic has not replaced them; context loss (twice this week).

**Kooshi's reading:** *noted — I trust your rigor will save us there.*

**Monitor.** Every headline carries its population and conditioning (G21); every verdict names only
the branch that fired (G30); every instrument has a planted red seen red before its first real run.

**Status:** OPEN by nature; the discipline is the mitigation.
