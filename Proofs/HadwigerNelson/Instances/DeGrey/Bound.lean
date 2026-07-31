import Proofs.HadwigerNelson.Instances.DeGrey.Forcing
import Proofs.HadwigerNelson.Instances.DeGrey

/-!
# χ(ℝ²) ≥ 5 — the plane needs five colours

The headline. Colour the points of the plane so that no two points exactly one unit apart share a
colour: four colours are not enough.

## The argument, in one paragraph

de Grey's graph is two copies of a smaller graph, sharing one vertex and joined by one edge
(`Instances/DeGrey/Split.lean`). Suppose the whole graph had a proper 4-colouring. Restricted to
either copy it is still proper, and each copy *forces* its end of the joining edge to take the shared
vertex's colour (`Sat/Forcing.lean`, from one kernel-checked refutation per copy). So both ends of the
joining edge have the shared vertex's colour — and they are joined by an edge, which forbids exactly
that. Hence no proper 4-colouring exists; and since every listed edge really is one unit long (M04's
geometry, `deGrey_valid`), the plane needs a fifth colour.

## What this rests on

Nothing but the kernel and the three standard axioms. The two refutations are checked by
`HadwigerNelson.runSegment`, whose soundness is proved in `Sat/MaskCheck.lean`; the geometry is 7877
exact identities in `ℚ(√3,√5,√7,√11)` decided by kernel reduction; the reduction from a finite graph
to the plane is M01's. **No native evaluation anywhere** — `scripts/Axioms.lean` is the receipt.

CaDiCaL proposed the two certificates and is trusted for neither: a wrong certificate fails a segment
check, and a wrong clause table fails `agreesWithCNF`.

## Three witnesses, and why that is not repetition

This repository proves `χ(ℝ²) ≥ 5` three times, from three different graphs:

| | vertices | edges | propagation steps the kernel re-runs | |
|---|---|---|---|---|
| `chromaticNumber_plane_ge_five` | 1581 | 7877 | 34,169,571 | de Grey's graph, de Grey's argument |
| `chromaticNumber_plane_ge_five_510` | 510 | 2504 | 1,413,841 | `Instances/Heule510/Bound.lean` |
| `chromaticNumber_plane_ge_five_553` | 553 | 2722 | 1,104,106 | `Instances/Heule553/Bound.lean` |

They share no vertex, no edge and no certificate. What they do share is this repository's encoding of
"has no 4-colouring" as a formula, and its checker — and those are exactly the two components no
theorem here can validate, because a wrong encoding proves a true statement about the wrong question.
**A bug in either would have to be one that certifies three unrelated graphs.** That is the reason to
have all three, and it is a different reason from wanting a smaller number.

The first is the one to read if you want de Grey's result formalized: his graph, and his own two-copy
forcing argument rather than a brute-force search. The others are the ones to *check*, being 25× cheaper.

Two of the three graphs are not ours. The 510- and 553-point coordinate lists are Marijn Heule's,
vendored at `tools/heule/`. What is proved is a statement about those points as written, and it does
not depend on how they were found — see `Instances/Heule510.lean`.

## For a reader who trusts none of this

Four commands, in the order a sceptic should run them. None of them requires re-running a solver,
reproducing a seed, or reading any Python.

```
lake build                    # the kernel checks everything: geometry, certificates, reduction
./scripts/axioms.sh           # what the theorem depends on beyond the kernel — expect the standard three
./scripts/lean4checker.sh     # replay every declaration through an independently written kernel
grep -rn --include=*.lean 'sorr[y]' Proofs/   # expect nothing
```

(The bracket in that last pattern is not a typo: written literally, the command would be found by
itself, and a debt scan that always reports one hit is a debt scan people learn to ignore.)

**On the third command, stated plainly rather than glossed.** Replaying a certificate through a second
kernel repeats every propagation step, single-threaded, in one process that cannot be split. At de
Grey's 34.2 million steps that is another 28 hours and has never been run to completion here, so the
independent-kernel claim has always covered the geometry, the soundness proofs and the composition —
and not those steps. **At 1.4 million steps it finishes**, which is the main thing the smaller
witnesses buy and the reason they exist in this repository at all.

`chromaticNumber_plane_ge_five` depends on axioms `[propext, Classical.choice, Quot.sound]` — the
standard three, and nothing else. **No `native_decide`, so no compiler and no CPU is trusted**, which
matters here more than anywhere: "this graph has no 4-colouring" quantifies over 4^1581 assignments, a
952-digit number, and there is no spot check a human could perform instead.

The three claims to read against the informal statement, each one click away:

* **the plane's own terms** — `deGrey_unit_distances`: every listed edge joins two points of the plane
  at distance exactly 1, from exact integer arithmetic in `ℚ(√3,√5,√7,√11)`, no floating point;
* **the combinatorics** — `deGrey_not_colorable_four`, and under it two refutations totalling 34.2
  million propagation steps, every one re-run by the kernel (and the same conclusion reached
  independently from two other graphs — see above);
* **the reduction** — `deGrey_bound_of_not_colorable`: a finite unit-distance graph with no
  4-colouring bounds the chromatic number of the whole plane.
-/

namespace HadwigerNelson

/-- **χ(ℝ²) ≥ 5.** No assignment of four colours to the points of the Euclidean plane avoids giving
two points at distance exactly 1 the same colour.

Read against the informal claim: `unitDistance V` is the graph on a metric space whose edges join
points at distance exactly 1, `chromaticNumber` is Mathlib's `⨅ n ∈ {n | Colorable n}, n` in `ℕ∞`,
and `5 ≤ ·` says every colouring with four or fewer colours fails. The bound is a lower bound on the
chromatic number of the plane, which is the Hadwiger–Nelson quantity. -/
theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  deGrey_bound_of_not_colorable deGrey_not_colorable_four

end HadwigerNelson
