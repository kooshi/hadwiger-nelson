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

**First measurement (2026-09-03, `data/m52/poolfield-<it-4>.json`):** the answer is YES. Over the
iteration-4 object's 950,371 pairs at distance < 2 (exact in K) there are 1,435 distinct radicands:
the in-field class holds 32 of them, 140,195 pairs, **280,390 pool points — 15 % of the pool**; the
√5 class 2 radicands / 4,092 pairs / 8,184 points; the √35 class 4 / 27,378 / 54,756 (so √7 is
reachable with √5); √2 8,839 pairs; √14 1,884; and **1,394 radicands in non-rational classes,
767,983 pairs, 1,535,966 points — 81 % of the pool**. Every one of the 1,767 committed points came
from the 15 % in-field slice. *Reading, falsifiable:* the design's tiers rank pool points by their
unit degree in the object, and in a crystal object high degree means ON the half-twist ladder,
i.e. in-field (an out-of-field glue point generically has only its two parents as unit
neighbours), so the selection is structural — a blind spot, not a verdict on the material. **The
test that decides it** (queued after the cull): replay one batch's classes against the
OUT-OF-FIELD pool alone — its kill mass by class is the number; zero means Kooshi's first horn
(no kill needs them), nonzero means the second (the tiers hide them).

**Correction (2026-09-04, M53 phase C, the exact split of the BUILT pool):** the census's pool-point
counts were 2·pairs, an upper bound; in-field glue points fuse (a ladder point with k object neighbours
is the glue point of C(k, 2) pairs), so the in-field slice of the 1,636,399-point pool is **16,348 points
(1.0 %)**, not 280,390 (15 %), and the out-of-field slice is 1,620,051 (99.0 %), of which 1,620,044 have
exactly two object neighbours. "≥ 3 object neighbours" is the in-field slice to seven points in 1.6 M —
G34's reading measured as an identity (`plans/M53-iteration-5.md` §R1).

**Kooshi's conditional (2026-09-03), if the test reads zero:** *keep only the √3 and √11 points for
all iterations until we hit a wall — a tradeoff between the field-wall monitor and the compute
exponent.* Registered in `plans/M53-iteration-5.md` (the in-field pool: ~6× smaller pool, profile
memory and design set; sound by monotonicity as every restricted pool is; the monitor kept as a
once-per-iteration full-pool re-ask of one batch's in-field survivors, whose first out-of-field-only
kill lifts the restriction).

**RESOLVED AS A THEOREM (2026-09-05):** the wall is real — χ(G(K²)) = 4 by the residue colouring
modulo a conjugation-fixed prime of K(i) above 2 (`~/field-wall-conjecture.md` §5, hand-proved; checked
here on the seed and on the 1,981-point object with zero search, `tools/residue_colouring.py`). A
descent confined to K cannot end (no pair compulsion at five colours exists in K); the in-field pool
is a non-terminating loop and Kooshi's conditional is withdrawn by the theorem. **The monitor becomes:
does the design keep a WALL-BREAKING point** — a radicand whose square class is 5 or 7 (mod 8), or a
non-rational radicand r with −r a square in both 2-adic completions of K (the note's §7.3 test, an
instrument to build). **Status:** the risk is a theorem; its mitigation is the new plan's (the
wall-breaking pool; the copy at a wall-breaking angle is the classical endgame).

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

**Status (2026-09-05):** the field wall is PROVED (see R1); what R5 named as unnameable splits in two —
the field wall (a theorem now; its kernel formalization is the next milestone, planned by the session
holding the proof) and the plane's own answer (whether χ(ℝ²) = 5), which no stall criterion inside a
loop can separate from a hard stall; the new plan owns both.

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
