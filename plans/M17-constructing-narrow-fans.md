# M17 — Constructing a narrow fan (stub)

*Carry-forward notes, written 2026-08-02 as M16 closed. Not yet subplanned.*

> **M16 closed the narrowing route through every witness in existence.** The four five-colour fans
> in de Grey's unshrunk graph are kernel-certified non-narrow (`deGrey_no_narrow_fan_*`); the
> shrunk witnesses are kernel-certified to carry no fan at all (M15). There is nothing left to
> interrogate. A fan confined to one spindle-able distance class — the closing move's input — must
> now be **built**, which is the question the hunt has been converging on since M13.

## 1. What the calibration route says a narrow fan is made of

De Grey's own four-colour narrow fan (the known-hit control in `tools/narrow.py` detects it in
~10 s) sits at the origin of `orbit(S, hex₁₂)` — 397 points — confined to the `r² = 4` class,
because the underlying hexagonal patch can be monochromatic *only* at a handful of distances, and
the orbit multiplies that scarcity into every direction at once. The five-colour obstacle is
measured (M12 § 0(e)): **nothing this project owns forces anything at five colours** — across
16,657 exact distance classes in four graphs, the only forcing class is the unit distance itself.
So the construction question is really: *what plays the hexagonal patch's role one colour up?*

## 2. What M16 put in the toolkit

* **Confinement is now a ~free per-candidate question.** The pool-of-colourings sweep answers
  "does any pivot's fan confine to one class" for a 1,581-point graph in under half a second;
  `narrow.py` carries the triage discipline, the self-auditing report line, and the known-hit
  control, so a candidate scan can run inside a generation loop.
* **A hit converts to a kernel theorem with existing machinery**: `Fan.of_unsat` on the confined
  class, `not_colorable_of_spindled_fan` (width ≤ 2) or spindle-and-rescan (any width, de Grey's
  own iterate — M14 § 0(k): the narrower fan appears at a *different* pivot).
* **A miss converts to a certified negative** through `NarrowCert` at ~2 min of kernel time per
  pivot — but certify *selectively*; the certificate is for results worth publishing, not for
  every rejected candidate.
* **`Field/Approx.lean` reads geometry inside Lean**: any question of the form "which of these
  exact distances coincide as reals / how do they order" is now kernel-decidable from interval
  data, with no injectivity assumption. A candidate's class structure can be certified, not just
  computed in Python.

## 3. Candidate directions, none yet measured

Ranked by how directly they attack "the patch one colour up"; each needs a measurement before any
is chosen at subplanning:

1. **Orbit closures at five colours over richer seeds.** M13's universes were 4-colour-cheap;
   nobody has swept orbit constructions *at five colours* for confined fans, because until M15
   the existence test cost 51 s per pivot and until M16 the confinement test did not exist. The
   first measurement: `narrow.py` over every 5-chromatic-adjacent configuration the constructor
   can build in a day of desktop time.
2. **Glue-then-narrow.** M15's glued candidates all carry fans spanning many classes. Whether
   *deleting* vertices can concentrate a fan into one class (the reverse of shrinking, which
   destroys fans) is unmeasured, and the sweep makes the objective computable per deletion.
3. **Field growth.** The spindle radicals of `r² = 1, 3/2, 2, 3` gave the four primes; a fan
   confined at a currently-unavailable radius (e.g. `r² = 4/3`, needing `√39`) would still be a
   *finding* — the field is derived, not chosen (M12 § 0(f)), and `missing_root` names the price.

## 4. Standing constraints (unchanged, carried once more)

Rejecting a candidate is ~free (0.02 s to 5-colour); refuting at five colours costs 10–30× four
(M12); refutation cost is non-monotone in size (M07); the interface ceiling for exhaustive gadget
checks is ten vertices (M11); a search that cannot re-find the rung below is not credible for the
rung above (M13). "Searched X, found nothing" is a result and goes in the write-up.

## 5. Gate debt noted at M16 close

The full-library independent-kernel replay (`lean4checker` over everything, open since M13's
killed run) was **launched at M16's close**; the M16 modules themselves were replayed scoped and
green at the gate. If the full replay is still running when M17 is subplanned, its status goes in
that report — never silently absorbed.
