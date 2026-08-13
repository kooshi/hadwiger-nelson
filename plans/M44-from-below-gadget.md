# M44 — The from-below gadget hunt: the one object that closes χ(ℝ²) ≥ 6
# (STUB — written 2026-08-12 at the M43 close. Read order for a fresh session:
#  `plans/M41-k5-gradient.md` WHOLE (the reduction, the autopsy dictionary, the flat
#  table, the deferred probes in §R), `plans/SHAPES-OF-SIX.md` (the shape space),
#  CLAUDE.md G26/G27/G28 and the open structural question.)

## Why this is now the only live path

M43 closed the from-above direction. The cell family `G(p)` needs seven colours at
every scale where a verdict exists, the last undecided scale (`p = 1/7`) came out
seven exactly, and — conditional on an external theorem we did not verify (Voronov's
proof of the Exoo conjecture) — the whole family is ≥ 7 at every scale, so no
refinement of that construction can ever produce a six-colouring. **Every remaining
route to new mathematics in this repository runs through the from-below reduction.**

## The target, stated exactly (M41's G26, kernel half already standing)

> Find a finite unit-distance graph `H` with two distinguished vertices `u, v` at plane
> distance **√3 or 2**, such that **every proper 5-colouring of `H` gives `u` and `v`
> different colours.**

That is the whole thing. The kernel already holds Act One — `HexShell.hexShell_pigeonhole`
(M35): every proper ≤ 6-colouring of the plane has a monochromatic pair at √3 or 2, on the
closed first shell of the triangular lattice. Nine copies of `H` placed on that shell,
composed by the M34 genre (`Pigeonhole.mono_pair_of_not_colorable_append`, the bridge that
turns class-avoidance into ordinary non-colourability), close **χ(ℝ²) ≥ 6**. The
composition machinery, the certificate chain, and the plane corollary layer are all built
and exercised (M34, M42). What is missing is `H`, and only `H`.

## What M43 changed about how to hunt it (G28 — read this before designing anything)

Every "is anything forced?" meter this project owns has read ZERO on every composed
object (G10, G17, G27's twelve objects, M41's 0/40 virtual-edge asks at exact √3/2
pairs). M43 found out what that silence can mean: at the 1/7 flank, an object that
**provably forces seven colours** has **no pair-level compulsion whatsoever** — every
forced-equality at every small non-edge class stays satisfiable on more material than
its own refuting core. So:

* **A zero reading from a pair meter is not evidence of distance from forcing.** The
  mechanism can live entirely above pair arity. Designs rejected because "the meters
  read flat" were possibly rejected on a blind instrument.
* **Ask class- and coverage-order questions instead**: the min-cover query (M32
  `coverage_query`), the class-avoidance sweep (M33/M35, k-generic and standing), and
  the fan/criticality factorization (A1, kernel) are the instruments that see what pair
  meters cannot. M35's k = 5 sweep read clean on everything we held — the honest reading
  now is that the objects were wrong, not that the question was.
* **The one structural asymmetry worth exploiting**: the 5-forcers we hold are
  exactly-5-chromatic, so they are 5-TIGHT — the fabric M35's G19 said the 6-hunt lacked.
  A gadget hunt over unions of certified 5-chromatic witnesses (M41 minted three NEW
  ones via the Galois orbit, and the hetero-dimers share up to 1,101 vertices) is the
  richest 5-tight material that has ever existed here.

## The ranked probes (all deferred from M41 §R, re-ordered by M43's lesson)

1. **Forced-distinct asks at √3 and 2 inside 5-tight unions** — not the floppy closures:
   take a certified 5-chromatic witness `W`, place a second copy so that a √3 or
   distance-2 pair spans the two, and ask whether the pair is forced distinct at k = 5.
   The dimers exist (M41: interfaces to 1,101 shared vertices) and their solver-effort
   excess (10×, single-sample) is the only nonzero signal the whole gradient campaign
   produced.
2. **Coverage-order asks on the same material** — min-cover at k = 5 around a candidate
   pair, which is what would fire if the compulsion sits at class order (the G28 lesson
   applied).
3. **Detuned (non-crystal) tilings** — G7/G12/G14 say the coupling channel is thin and
   the detune is the mechanism; an aperiodic or quasi-periodic placement of 5-chromatic
   domains is the shape SHAPES-OF-SIX §3 calls Shape B, untested.
4. **The gen-2 k = 5 class sweep at depth** — M41 ran the pair meters on gen-2 (284,873
   points) but not the class sweep; it is the one instrument that has ever found a
   compulsion nobody predicted (M33's d = 2 pigeonhole).

## Registered-prediction discipline

Same as every campaign here: §0 written and committed BEFORE any instrument runs, with
(i) the exact objects, (ii) a prior per probe with the evidence both ways, (iii)
acceptance criteria that are necessary as well as sufficient (G21), (iv) the failure
clauses — `unknown ≥ cap` is never a verdict, and **any forced-distinct find at √3 or 2
fires a HALT AND VERIFY: it is χ(ℝ²) ≥ 6, the result this entire project exists for.**
Re-derive the graph independently, re-refute in a second encoding, and report before
interpreting.

## The honest prior

Four independent campaigns have found nothing forced at k = 5 (M31, M32, M41, and M35's
class sweep). The reduction is exact and the target is sharp, but nothing in the measured
record suggests the gadget is close. What M43 supplies is not optimism — it is the
knowledge that the silence may have been instrumental, plus the elimination of the only
competing direction. If M44 also comes back flat, the honest next question is whether
χ(ℝ²) = 5 (in which case the hunt is for an upper-bound construction, and G22 has already
blacked out the lattice colourings) rather than whether we are looking in the wrong place.
