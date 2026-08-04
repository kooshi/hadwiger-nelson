# M20 — The extension problem (stub)

*Carry-forward notes, written 2026-08-04 as M19 closed. Not yet subplanned. This is the
question the two-circle theorem poses by its own boundary, and the milestone where the hunt
gets a finer gradient than `minCov`.*

## 1. The question, precisely

M19's two-circle theorem: the induced unit-distance graph on a 120°-pivot's cover set
`S = N(p) ∪ C` is **always** 3-colourable — locally, three colours always suffice. So
`minCov(p) = 4` can only mean: *no proper 5-colouring of the ambient graph restricts to a
3-colour pattern on `S`* — every locally-legal 3-pattern is killed by the requirement that
it extend to the whole graph. Coverage 4 is an **extension obstruction**, and M20 asks
whether construction can manufacture one:

> Can ambient structure force a 4th colour onto a cover set by restricting which proper
> 3-colourings of the (always-3-colourable) two-circle graph extend?

Nothing rules it out — the barrier theorem was stated with exactly this boundary — and
nothing yet witnesses it: E0–E2 all sat at 3.

## 2. The finer gradient: the extension profile

`minCov` is too coarse for this hunt: it sits at 3 until the day it jumps. The right
instrument watches the thing that actually shrinks:

**The extension profile of a pivot** := the set of proper ≤3-colour patterns on `G[S]`
(up to colour permutation) that are realized by *some* proper 5-colouring of the ambient
graph. `minCov = 4` ⟺ the profile is empty. A gadget's worth = how many patterns it kills.

Feasibility (measure in §0 before believing): `|S| ≈ 21..36` at the closure's pivots, with
in-`S` degree ≤ 4 — enumerate the proper 3-colourings of `G[S]` exactly (backtracking;
likely 10²–10⁴ up to permutation), then one SAT call per pattern ("ambient 5-colouring with
these unit clauses on `S`"). Sub-second calls; a per-pivot profile in minutes. The strip
labels from `TwoCircle.lean` give the patterns *names* (which orbit wears which table
shift), so profiles are comparable across pivots and across gadget edits.

## 3. §0 measurement obligations (next round, before specifying)

1. **The baseline profile.** At the closure's pivot 630 (and 2–3 others): enumerate the
   3-patterns of `G[S]`, SAT-test extendability of each, report the profile size and its
   structure (which strip-label classes of patterns extend). *This number has never been
   measured for any pivot.* Prediction to register before running: profiles are large and
   the E-battery gadgets killed few or no patterns (they moved nothing).
2. **Pattern-killing per gadget, re-run of the E-battery.** Same gadgets as M19 §0(d), now
   scored by profile shrinkage instead of minCov. If E1/E2 killed a measurable fraction,
   the hunt has its gradient; if they killed ~nothing, the barrier-conjecture thread
   (§5.3) gets its first real evidence.
3. **The strip's own colouring space.** How rigid is the two-circle graph's 3-colouring
   space in theory? On one Γ-orbit strip: classify proper 3-colourings of the label graph
   (transfer-matrix count; the e/o colouring is one point of the space). A structure
   theorem here ("every proper 3-colouring of the strip is …") would turn profile
   enumeration from search into arithmetic — and is itself M20's Lean-side candidate.
4. **Where extension pressure could come from.** The ambient graph meets `S` through
   vertices at distance ≤ 1 from some `S`-member: census which ambient vertices constrain
   many `S`-members at once (the "clamp" candidates), and whether any known construction
   (spindle images, second closures) produces clamps that couple *distant* `S`-members —
   the coupling no `S`-internal edge can provide (chord bound: in-`S` degree ≤ 4).

## 4. Candidate deliverables (to be refined at subplanning)

1. **The extension-profile instrument** (`tools/extend.py` or grown inside `coverage.py`):
   per-pivot profile, bias-free by construction (every reading is a SAT verdict, not a pool
   statistic — the M19 §0(b) lesson applied from birth). Self-tested, regen-check-wired.
2. **A gadget measured to kill patterns** — the first observed extension pressure, however
   small; industrialize whatever moves.
3. **The strip-colouring structure theorem** (Lean): the classification from §3.3, stated
   at whatever strength the measurement demands. This is the natural successor to
   `TwoCircle.lean` and shares all its machinery (labels, tables, `label_step`).
4. **If profiles refuse to shrink under everything tried**: the honest barrier write-down —
   a conjecture (or theorem, if the structure theorem is strong enough) that the closure
   algebra's gadgets cannot create extension obstructions, with the measured evidence.

## 5. Scope notes and standing decisions

* **Writeups and upstreaming are deferred until something worth publishing lands**
  (Kooshi, 2026-08-04) — this covers the rung-B write-up, the greedy-colouring Mathlib
  candidate, and any two-circle-theorem exposition. The deferral is standing policy, not
  per-item.
* **General-radius two-circle theorem** stays deferred until a milestone needs it (the
  1/3 class remains the live one; if §3.4's clamp census implicates another class's
  geometry, that is the trigger).
* **Kernel route unchanged**: a `minCov = 4` reading (empty profile) becomes a claim only
  through M16's `Fan.of_unsat`-style certification — and note the profile gives exactly
  the cube-split for it: one UNSAT certificate per locally-legal pattern.
* Rotation policy unchanged (agreed 2026-08-03): if profiles go flat across gadget
  families, the designated perspective shift is the certified-6-colouring angle.

## 6. Operational rules in force (unchanged, recorded in CLAUDE.md)

All builds through `scripts/build.sh`; `lake` only from the repo root; on any segfault halt
and report immediately; one heavy job at a time; `tools/` untrusted; pool statistics
measure the sampler, not the space.
