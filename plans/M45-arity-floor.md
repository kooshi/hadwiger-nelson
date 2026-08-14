# M45 — The arity floor: what order does the compulsion actually live at?
# (STUB — written 2026-08-13. Read order for a fresh session: this file, then CLAUDE.md
#  G9/G13/G17/G28 (the four independent statements that the mechanism is above pair order),
#  `plans/M43-fine-tail.md` §R "The core, the autopsy, and the kernel", and
#  `tools/rigidity.py` (the meters — `triple_query`, and the arity-generic avoidance layer).)

## The one-paragraph version, for a reader who knows nothing

When we ask "does this object force anything?", we have been asking about **pairs**: is some pair
of points compelled to get the same colour, or compelled to get different colours? Across four
campaigns, on every object we hold, the answer has been *no* — a flat table. In the last milestone
we found an object that **provably needs seven colours** and *still* has no pair-level compulsion
of any kind. That was reported as a finding about the object. It may instead be a finding about
our instrument: a tool that can only see relationships between two points will read zero on any
mechanism that lives among three or more, and we have never once asked a three-point question on
an object whose answer we already know. This milestone asks it, on the one object where a zero is
as informative as a hit.

## Why this is worth a milestone rather than an afternoon

Three independent grokkings, arrived at by three different routes, all say the same thing:

* **G9** (from de Grey's forcer at four colours): pairwise rigidity is empty above the forcing
  level, so a geometric argument "must live at triple order or higher".
* **G13** (from the centre-transition ladder): coverage compulsion is a *k-set* property,
  "structurally invisible to the pairwise rigidity sweep" — the same fact seen at two orders.
* **G28** (from the fine-tail autopsy): an object that forces seven colours has zero pair-level
  compulsion at every small class, on more material than its own refuting core.

And G21 — this project's own methodological invariant — says that when a search refuses, the first
question is whether the acceptance test was the exact condition or merely a sufficient one. **A
pair meter reading zero on a mechanism of arity three is exactly that failure**, and G28 is
currently the strongest negative result in the record. It deserves to be either promoted to a
measured statement about arity or demoted to a statement about our instruments; right now it is
being cited as the first while resting on evidence for the second.

The milestone that follows it (`plans/M44-from-below-gadget.md`) already tells its own author to
"ask class- and coverage-order questions, not only pair questions" — and then ranks a **pair** ask
first. That inconsistency is the practical reason to settle the arity question before the gadget
hunt consumes it as an assumption.

## The design property that makes this worth doing (and that no previous probe had)

**A calibrated test bed.** Every prior "is anything forced?" campaign ran on objects whose forcing
status was unknown or whose forcing was the thing being hunted — so a zero reading was
uninterpretable (no mechanism, or no instrument?). Here the object is known:

* the **1/7 coarse-flank core** — 160 vertices, 2,978 edges, 24 point-group orbits, 1-minimal,
  every vertex necessity-witnessed, edges re-derived two independent ways; **it provably refuses
  six colours**, and we know its pair meters read exactly zero;
* the **`G*` 23-vertex core** — kernel-checked at χ = 7 with ω = 4 (`Instances/Core23/`), small
  enough to answer *every* question exhaustively, and known to factor as pigeonhole × kill, so it
  is the positive control: whatever arity the mechanism sits at there, we can compare.

So a hit is real signal and a zero raises the arity floor. Both outcomes are results — the
property that this project's flat campaigns have consistently lacked.

## The phases

* **§0 — registration** before any run, per the standing discipline: objects, per-probe priors
  with the evidence both ways, acceptance criteria necessary as well as sufficient, failure
  clauses, and the explicit statement of what a zero at each arity does and does not license.
* **§1 — arity 3, exhaustively where affordable.** The avoidance layer in `tools/rigidity.py` is
  already arity-generic (it accepts tuples of any size ≥ 2); `triple_query` exists and was
  exercised at M32 on 140 *targeted* triples at four colours. What has never been run is a
  **systematic** arity-3 sweep on a known-forcing object. The point-group orbit structure (24
  orbits on the 160-core) cuts the triple space by roughly the group order before any solver runs.
  Both directions per triple: is a pattern *compelled* (the M20 `no_mono_outer_triple` genre — a
  compulsion acting through no edge), and is a pattern *impossible*.
* **§2 — arity 4, and coverage order.** If arity 3 is also flat, push one further and run the
  coverage/min-cover meter (`tools/rigidity.py` `coverage_query`) at six colours around the core's
  vertices — the k-set question G13 named as the missing instrument and which was built at M32 but
  never aimed here.
* **§3 — the same ladder on the 23-core, exhaustively.** It is small enough that "every question,
  answered" is affordable, and it is kernel-certified, so its answers are ground truth for
  calibrating what a forcing object's arity profile even looks like.
* **§4 — the verdict on G28**, written either way: promoted to "the compulsion has arity ≥ N,
  measured" with N named, or demoted to "the pair meters read zero, and so do the arity-3 meters,
  and the honest statement is that we have not found the order it lives at."

## The second question, same objects, same afternoon: why are the cores always *broken*-symmetric?

Registered here because it is anatomy of the same material and costs nothing extra.

**The observation.** Every 1-minimal carrier this project has ever produced is *nearly* symmetric
with the symmetry deliberately incomplete: de Grey's 122-vertex carrier (12 *near*-six-fold
shells), the 23-vertex `G*` core (near-six-fold, broken), the 160-vertex fine-tail core ("most
orbits partial — 11-of-12, 5-of-6"). These live in **unrelated arithmetic** — the first in a field
of nested square roots with rotations detuned by fractions of a degree, the last in plain integer
arithmetic on the triangular lattice with no radical anywhere and no detuning parameter at all —
different fields, different numbers of colours, different construction lineage, identical
signature.

**The suspected cause, which is nearly an argument already.** G7 says exact symmetry adds no
colour constraint: a symmetric copy can reuse the base's pattern. If that is right then a
symmetric object is never minimal — whatever full orbit it contains can be thinned — and **broken
near-symmetry is not a design choice or a coincidence but what minimality does to any forcer
inside a symmetric ambient, in any field.**

**The check, on data already on disk.** M43 records `orbit_profile` and `n_orbits` per core in
`build/m43-finetail.json`; M40/M41 record the same for the five earlier cores. The registered
prediction: *every* 1-minimal core has at least one incomplete orbit under the ambient's point
group, and re-adding a missing orbit member never restores colourability. Both halves are
checkable in an afternoon, the second by direct solver ask. If it holds across all seven recorded
cores in two unrelated families, it is a stateable law with a proof sketch attached; if a fully
orbit-complete 1-minimal core exists, the reading dies on the spot and G7's scope narrows.

## The honest prior

Low expectation of a hit at arity 3 (four campaigns of flatness is real evidence, even if it is
evidence about instruments), high confidence that the *answer* is worth having either way, and
high confidence in the broken-symmetry check producing a clean yes or no from data already
written to disk. This is the cheapest milestone on the board and the only one whose negative
result is itself a publication-grade sentence about mechanism: *the compulsion is not visible at
arity ≤ N on an object we can certify forces.*
