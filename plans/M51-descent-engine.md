# M51 — the descent engine: iteration 3+ at speed (pre-subplan stub)

*Stub written 2026-08-24 at the M50 close, on Kooshi's direction: "our engineering for M51
should be focused on optimizing the speed of the whole process." Per the stub rule this file
carries everything the deciding session knew, so a fresh session with zero conversation memory
can subplan it with all meaning intact. Companion files: `plans/M52-nominated-gadgets.md` (the
stall-response plan), `plans/STANDING-QUESTIONS.md` (the durable ideas ledger — READ IT, it
holds the theory this stub only references), `plans/M50-batch-descent.md` §R (the evidence).*

## Mission context, in plain language

The project's target is χ(ℝ²) ≥ 6. The kernel already holds the reduction: a finite
unit-distance graph that forces one designated pair of points to receive the SAME colour in
every proper 5-colouring closes the theorem through the spindle
(`OneDefect.not_colorable_of_forced_equal`; one non-unit edge suffices —
`add_one_le_chromaticNumber_unitDistance_of_one_defect`). Exoo–Ismailescu's 214-point graph H
forces exactly such a pair (A = index 205, B = index 206) — but 446 of its edges are "cheats"
at distance 2 rather than 1. **The descent replaces cheats with certified unit-distance halos,
one batch per iteration.** If it reaches zero cheats, χ(ℝ²) ≥ 6. Every iteration also turns the
dial μ (fewest distance-2 edges of a non-5-colourable {1,2}-graph) down, which is publishable
progress in itself at the μ ≤ 1 jackpot.

**The state at M50's close** (all certified, `build/m50-object-S29-depth2r-it2v2-depth1.json`):
the composed object has **1,008 points, 403 cheats — 43 of 446 removed** in two batch commits
(19 then 24). The batch law is proven in practice: design ONE halo against the WHOLE batch's
separating-colouring list and removals compose by construction (G33). The iteration-3 floor
(edges essential alone) is **17 of 403**; the rest of the batch structure is described in
`plans/M50-batch-descent.md` §R6.

## Why iteration 3+ is the recommended frame (the evidence)

**The core probe (M50 §R6, the close's decisive measurement): growth alone re-opens every
refuser.** Each kept refuser edge `e` was re-asked on the grown object: enumerate the
separating colourings of (object − removed − {e}) exactly (55–500 seed classes each), then ask
whether the object's OWN depth-1 partner lattice (394,604 points) kills them. Result: **five
edges FALL clean** — including M49 hold-outs — **and the six others hold ZERO provably
surviving colourings** (2,402 classes, 2,351 killed, 49 undecided at 7,200-s caps, never
folded). The same edges refused every pool of the smaller object at M49. The committed
material's own partner lattice grows faster than the rigidity it must break: **the loop is
self-accelerating at depth 1** (G33's reading; falsifiers registered there — an iteration whose
lattice kills fewer than the last, or a width-stall fraction that grows).

**The named resistance:** 277 of iteration 2's 4,945 committable colourings have WIDTH-shaped
kills — strong-rung satisfiable, capped minimizations landing at 2,551–14,960 points and still
descending. These do not block the loop (they were re-hit into kept edges), but they are the
measured signature of the regime where depth-1 points stop sufficing; M49's restricted depth-2
gadgets (87–267 points each) are the priced response.

**The intermediate deliverable, guaranteed:** the spare-colour lemma (statement and sketch in
STANDING-QUESTIONS §K1) implies the object's pure unit part must cross from 4-colourable to
not-4-colourable strictly before the descent ends — and the crossing commit mints a **new
5-chromatic unit-distance graph** of a construction genre no published witness uses
(glue-lattice-grown). The monitor is one SAT ask per commit (`tools/m50_skewscan.py --unitchi`);
it reads 4-colourable at 1,008 points. This is a certified deliverable BEFORE any 6-result.

## The speed mandate (Kooshi, 2026-08-24): the loop's cost anatomy, measured

M50's iteration 2 broke every iteration-1 cost model and forced SIX engine swaps mid-flight
(§R6 records each with its regression). M51 makes speed a design goal instead of a repair. The
measured per-phase baselines on the desktop (32 cores), and the known bottleneck in each:

| Phase | it-2 measured | bottleneck | known lever |
|---|---|---|---|
| Pool build | 922 s, SERIAL, 1.2 GB | single-threaded candidate/census loop | parallelize `_partners_about` + the annulus census; CACHE the pool to disk keyed by object fingerprint (rebuilt ≥ 4× at M50 — pure waste) |
| Enumeration | 24 min (it-1, cubes) / hours (it-2 with restarts) | cube-round stretches; restart loss | it was EXACT both times — keep; persist cube state more aggressively |
| Profile | ~4 h at 3 asks/s (45,365 classes) | the ~139k-point core SAT per ask (~5 s UNSAT; SAT-side toward caps) | incremental SAT (pysat, NOT installed — evaluate installing python-sat: edge clauses built once per worker, avail lists as assumptions; plausibly 5–20×); or drop whole-pool semantics where the design only needs killability (see below) |
| Cover (wave) | ~1–2 h | per-colouring ladder + ddmin ~1–3 min each | already 12-wide; widen; batch the ddmins |
| Shrink | ~1 h | kills-all sweeps | already screened+parallel; live-set restriction (learned at M50: shrink against the COMMIT list, not the cover list) |
| Certify | 620 s | fine | none needed |
| Floor census | 378 s | fine | none needed |
| Hard unknowns | 49 asks undecided at 2 h | genuine SAT hardness | do NOT chase with caps — the cover kills these colourings with subsets, where whole-pool SAT is not the primitive |

**The structural speed question the subplan must answer first:** the profile's whole-pool
semantics ("does the ENTIRE pool kill this colouring") is the completeness question, needed for
the hitting set — but the cover only needs *a* kill per colouring. M50 already tiered this
(strong-rung UNSAT ⟹ killed, by kill-monotonicity; greedy extension ⟹ survives). The subplan
should consider inverting the pipeline: run the COVER first with cheap rungs, and whole-pool
profile ONLY the colourings the cover cannot kill cheaply — the expensive completeness question
asked exactly where it decides something (the hitting set's survivor list). Expected effect:
the 4-h profile collapses to minutes of cover plus a small residue of genuine asks.

**Engineering rules banked from the six swaps** (each learned at measured cost): thread pools
serialize on the GIL unless the work is subprocess-dominated — fork process pools after warming
caches; checkpoint every verdict (restarts and engine swaps become free, and the checkpoint IS
the regression set); `np.add.at` and per-round `np.repeat` are the slow scatter — cached rows +
`bincount`; rungs sorted smallest-first with fall-through, never break, on an oversized kill;
an `Undecided` is a third verdict everywhere and never folds; verdict messages must name the
cause that actually fired (incident 3); stage batches ACCUMULATE (incident 2); kill the process
GROUP (`setsid` + `kill -- -PID`); ONE heavy job at a time; on any segfault HALT and report.

## The shape of the milestone

1. **Phase 0 — the engine pass**: the speed levers above, each behind the standing regression
   (the profile checkpoint files + `--self-test` + the M49 reproduction controls). Decide the
   pysat question with a measurement, not a preference. Pool caching keyed by fingerprint.
2. **Phase 1 — iteration 3 at depth 1**: enumerate the 17-floor stage (seed-blocked), profile
   (or cover-first, per phase 0's decision), hit, design, certify, recurse. The core probe
   predicts most of the floor falls. Standing per-commit columns: χ(unit part), the floor
   census, the polarization table (`tools/m50_skewscan.py --scan`), the P5-style field census.
3. **Phase 2 — iterate until the depth-1 well runs dry** (the loop is cheap once phase 0
   lands); each iteration's numbers go in §R as they close.
4. **Phase 3 — the depth-2 escalation** for whatever resists: the restricted depth-2 pool
   (M49's machinery, M50's engines), priced by the width-stalls.
5. **Throughout**: the jackpot clause VERBATIM — any μ ≤ 1 at five colours is HALT AND VERIFY;
   any χ(unit) = 5 crossing is HALT, certify the minted witness, and report before continuing.

## Registered expectations (priors for the subplan to sharpen)

* E1: after phase 0, one full depth-1 iteration completes in ≤ half a desktop-day (prior 0.6).
* E2: iteration 3 removes ≥ 10 of the 17 floor edges in one commit (prior 0.6 — the probe's
  falls, discounted for composition effects).
* E3: the width-stall fraction grows across iterations (the G33 falsifier watched as a dial,
  prior 0.5 — either way it is the recursion's cost curve, G25).
* E4: χ(unit) crosses to 5 within the milestone (prior 0.3 — genuinely open; the crossing is a
  halt-and-certify event, not a background statistic).

## Failure clauses

Stall (no committable batch at depth 1 and depth 2 unaffordable): the milestone closes with the
measured cost curve as the finding and `plans/M52-nominated-gadgets.md` becomes the recommended
next — its calibration corpus and diet meter are already built. Engine regression (any swap
whose regression set disagrees): revert first, diagnose second. The 49 hard unknowns are NOT a
debt of this milestone; they die by subset kills or not at all.
