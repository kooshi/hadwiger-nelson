import Proofs.HadwigerNelson.Instances.DeGrey.Forcing

/-!
# χ(ℝ²) ≥ 5 — the plane needs five colours

The headline. Colour the points of the plane so that no two points exactly one unit apart share a
colour: four colours are not enough.

## The argument, in one paragraph

de Grey's 1581-point graph is **two copies of one 791-point set**, rotated about `(−2, 0)` by
`π/2 ∓ arcsin(1/8)`; they share exactly one point and are joined by exactly one edge. Suppose the
whole graph had a proper 4-colouring. Restricted to the first copy it is still proper, and a
kernel-checked refutation says that copy forces its end of the joining edge to take the shared
point's colour. **The second copy is the first one rotated** — Lean checks all 791 point
correspondences — so it forces its end the same way, from the same refutation. Both ends therefore
have the shared point's colour, and the edge between them forbids exactly that. Hence no proper
4-colouring; and since every listed edge really is one unit long, the plane needs a fifth colour.

## What this rests on

Nothing but the kernel and the three standard axioms.

| | |
|---|---|
| one refutation, kernel-checked | **18,441,901 propagation steps** across 1,222 segment modules |
| the rotation | 791 exact identities in `ℚ(√3,√5,√7,√11)`, 95 CPU s |
| the geometry | 7,877 exact distance identities, kernel-decided (M08) |
| the reduction from a finite graph to the plane | M01 |

**No native evaluation anywhere** — `scripts/Axioms.lean` is the receipt. CaDiCaL proposed the
certificate and is trusted for none of it: a wrong certificate fails a segment check, and a wrong
clause table fails `agreesWithCNF`.

## What changed, and why the number above is half of what it was

Until M09 this proof used **two** refutations, one per copy — 34,169,571 propagation steps, 2,265
segment modules, 396 MB, and 27.8 hours of processor time. The second copy's refutation was
redundant: its graph is the first copy's, rotated, and a rotation preserves distance. Making that a
theorem (`Instances/DeGrey/Rotation.lean`, `HadwigerNelson.Motion`) deleted 1,043 modules, 180 MB of
source and 12.8 hours, and replaced them with 95 CPU seconds of exact arithmetic.

**The geometry cost did not change, and this file said otherwise in an earlier draft.** `deGreyRot`'s
second half *is* derived — its distances come from the first half's plus the rotation, and none are
recomputed — but the `deGrey_valid` it sources from still checks all 7,877, because that edge list is
frozen upstream of the surviving certificate. What the rotation deleted is the **certificate**. The
derivation is what M11 needs, where a placed copy's coordinates are defined by the motion rather than
listed and the check becomes `rfl`.

## Three witnesses, and why that is not repetition

This repository proves `χ(ℝ²) ≥ 5` three times, from three graphs:

| | vertices | edges | propagation steps the kernel re-runs | |
|---|---|---|---|---|
| `chromaticNumber_plane_ge_five` | 1581 | 7877 | 18,441,901 | de Grey's graph, de Grey's argument |
| `chromaticNumber_plane_ge_five_510` | 510 | 2504 | 1,413,841 | `Instances/Heule510/Bound.lean` |
| `chromaticNumber_plane_ge_five_553` | 553 | 2722 | 1,104,106 | `Instances/Heule553/Bound.lean` |

They share no vertex, no edge and no certificate. What they do share is this repository's encoding of
"has no 4-colouring" as a formula, and its checker — exactly the two components no theorem here can
validate, because a wrong encoding proves a true statement about the wrong question. **A bug in either
would have to be one that certifies three unrelated graphs.** That is the reason to have all three,
and it is a different reason from wanting a smaller number.

The first is the one to read if you want de Grey's result formalized: his graph, and his own argument
— now including the rotation his construction is built from. The others are the ones to *check*,
being 13× cheaper.

Two of the three graphs are not ours. The 510- and 553-point coordinate lists are Marijn Heule's,
vendored at `tools/heule/`. What is proved is a statement about those points as written, and it does
not depend on how they were found — see `Instances/Heule510.lean`.

## For a reader who trusts none of this

Four commands, in the order a sceptic should run them. None requires re-running a solver, reproducing
a seed, or reading any Python.

```
lake build                    # the kernel checks everything: geometry, certificate, rotation, reduction
./scripts/axioms.sh           # what the theorem depends on beyond the kernel — expect the standard three
./scripts/lean4checker.sh     # replay every declaration through an independently written kernel
grep -rn --include=*.lean 'sorr[y]' Proofs/   # expect nothing
```

(The bracket in that last pattern is not a typo: written literally, the command would be found by
itself, and a debt scan that always reports one hit is a debt scan people learn to ignore.)

**On the third command, stated plainly rather than glossed.** Replaying a certificate through a second
kernel repeats every propagation step, single-threaded, in one process that cannot be split. At de
Grey's 18.4 million steps that is another ~15 hours and has not been run to completion here, so the
independent-kernel claim covers the geometry, the rotation, the soundness proofs and the composition —
and not those steps. **At 1.4 million steps it finishes**, which is the main thing the smaller
witnesses buy and the reason they exist in this repository at all.

`chromaticNumber_plane_ge_five` depends on axioms `[propext, Classical.choice, Quot.sound]` — the
standard three, and nothing else. **No `native_decide`, so no compiler and no CPU is trusted**, which
matters here more than anywhere: "this graph has no 4-colouring" quantifies over `4^1581` assignments,
a 952-digit number, and there is no spot check a human could perform instead.

The four claims to read against the informal statement, each one click away:

* **the plane's own terms** — `deGrey_unit_distances`: every listed edge joins two points of the plane
  at distance exactly 1, from exact integer arithmetic in `ℚ(√3,√5,√7,√11)`, no floating point;
* **the construction** — `deGrey_rotation`: the second copy of de Grey's point set really is the first
  one rotated, checked point by point;
* **the combinatorics** — `deGreyRot_not_colorable_four`, and under it one refutation of 18.4 million
  propagation steps, every one re-run by the kernel (and the same conclusion reached independently
  from two other graphs — see above);
* **the reduction** — `UDCert.add_one_le_chromaticNumber_plane_of_valid`: a finite unit-distance graph
  with no 4-colouring bounds the chromatic number of the whole plane.
-/

namespace HadwigerNelson

-- The `fail` branch is unreachable *when the gadgets refute*, which is exactly when the linter runs.
-- It is reachable on the day it matters, and that is the day the directive exists for.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **de Grey's graph has no 4-colouring.** The three constraints of
`Instances/DeGrey/Forcing.lean` admit no colouring of the three vertices they speak about, decided
over all 64. -/
theorem deGreyRot_not_colorable_four : ¬ (edgeGraph 1581 deGreyRotEdges).Colorable 4 :=
  not_colorable_of_gadget deGreyGadgets (by
    first
    | decide
    | fail "de Grey's three gadgets do not jointly refute. For the port colourings that \
            survive, in a file with `import Proofs.HadwigerNelson.Instances.DeGrey.Forcing` \
            and inside `namespace HadwigerNelson`:  #eval deGreyGadgets.survivors")

/-- **χ(ℝ²) ≥ 5.** No assignment of four colours to the points of the Euclidean plane avoids giving
two points at distance exactly 1 the same colour.

Read against the informal claim: `unitDistance V` is the graph on a metric space whose edges join
points at distance exactly 1, `chromaticNumber` is Mathlib's `⨅ n ∈ {n | Colorable n}, n` in `ℕ∞`,
and `5 ≤ ·` says every colouring with four or fewer colours fails. The bound is a lower bound on the
chromatic number of the plane, which is the Hadwiger–Nelson quantity. -/
theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  deGreyRot.add_one_le_chromaticNumber_plane_of_valid deGreyRot_valid deGreyRot_not_colorable_four

end HadwigerNelson
