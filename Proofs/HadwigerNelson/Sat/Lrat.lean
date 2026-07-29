import Proofs.HadwigerNelson.Sat.Encoding
import Std.Tactic.BVDecide.LRAT.Checker

/-!
# Certificate ingestion

CaDiCaL is an untrusted oracle: it proposes an LRAT certificate, and `Std.Tactic.BVDecide.LRAT`'s
**verified** checker — `check` plus `check_sound`, both shipped in Lean core — decides whether the
certificate really establishes unsatisfiability. A wrong certificate cannot pass, and a satisfiable
formula has none.

This module is one theorem wide. Its job is to name the trust boundary, because the boundary is
not where one would guess.

## The measurement, and the purchase it forces

**`LRAT.check` does not kernel-reduce. This is structural, not a matter of scale.** Measured
2026-07-27 on `⟨#[[(0, true)], [(0, false)]]⟩` — the smallest unsatisfiable CNF there is, with a
one-step certificate:

| route | result |
|---|---|
| `by decide` | stuck immediately — the elaborator will not unfold `@[irreducible]` well-founded definitions (`Array.anyM.loop` among them) |
| `by decide +kernel` | stuck immediately too — in **under a second**, not after grinding |
| `by native_decide` | succeeds, instantly |

So the LRAT half of this project buys a native-evaluation axiom, and buys it for *every*
certificate including the two-clause one. Core's own `bv_decide` does the same — its final step is
`nativeEqTrue`, not a kernel reduction — so this is the state of the art rather than a gap in our
setup.

### Where it sticks, and why that is good news

Corrected 2026-07-29. An earlier version of this file said `decide +kernel` "sticks inside
`Formula.performRupAdd` after ~40 s". **Both halves of that were wrong**, and anyone planning from
it was aimed at the wrong target. `performRupAdd` reduces fine; so do the well-founded recursion,
the `Array` mutation, and the whole propagation engine. The obstruction is one thing in one place:

* `DefaultClause.ofArray` (`…/LRAT/Internal/Clause.lean`) builds every clause through an
  `Std.HashMap` to detect duplicate and complementary literals — the only hash map in the entire
  LRAT tree;
* hash-map bucket indexing computes on `USize`, whose width is `System.Platform.numBits`;
* `System.Platform.numBits` is `(System.Platform.getNumBits ()).val`, and `getNumBits` is
  `@[extern] opaque` — **the kernel has no delta rule for it**, so `2 ^ numBits` never becomes a
  literal and every `USize` operation is permanently stuck.

Verified directly: `#reduce System.Platform.numBits` prints the unreduced
`(System.Platform.getNumBits PUnit.unit).1`; `(USize.ofNat 8 - 1).toNat = 7` will not reduce, while
the same statement over fixed-width `UInt64` reduces instantly.

`ofArray` sits on both halves of `check`'s path — converting the input formula, and converting every
`.addRup` step — which is why the shipped entry point is blocked for any certificate at all.

### The kernel-checked route needs no new soundness proof

The other correction, and the one that matters. This file used to say the kernel-checked route
"would require an LRAT checker written to reduce, with its own soundness proof". **It does not.**
Core already ships a second, HashMap-free entry point: the generic `lratChecker`, structurally
recursive over `List (Action β α)` of *pre-converted* actions. It never calls `ofArray`, so it never
touches a hash map — and `lratCheckerSound` is axiom-clean.

Measured 2026-07-29: a genuine three-step RUP refutation of an unsatisfiable four-clause formula,
with hand-built `DefaultClause`s, gives `lratChecker F prf = .success` **by `decide +kernel`**, and
`lratCheckerSound` then yields `Unsatisfiable` with axioms exactly
`[propext, Classical.choice, Quot.sound]`. No native evaluation anywhere.

So the open question is **throughput, not possibility**: core's engine rebuilds a full assignment
array per propagation and indexes clauses positionally, and whether that reaches de Grey's scale is
a measurement, not a proof obligation. What a kernel-checked route costs is: emitting
`DefaultClause` actions rather than `IntAction` (each clause carries two proof fields, so it wants
one smart constructor proved once rather than a tactic call per clause), and enough speed.

**What the purchase is not.** The geometry half stays kernel-clean (`UDCert.Valid` is decided by
`decide`, `[propext, Quot.sound]`), and so does the spindle's non-3-colourability, which
`Instances/SpindleBound.lean` proves by brute force with no solver in sight. Only claims that route
through a certificate carry the axiom, and each such declaration says so in its own docstring.

## The axiom to grep for

At toolchain v4.32.0 `native_decide` mints a **per-declaration** axiom rather than citing
`Lean.ofReduceBool`:

```
'foo' depends on axioms: [propext, Classical.choice, Quot.sound, foo._native.native_decide.ax_1_1]
axiom foo._native.native_decide.ax_1_1 : decide (check π cnf = true) = true
```

`Lean.ofReduceBool` does not appear at all. Any gate that greps only for that name will pass a
native purchase in silence — see `scripts/Axioms.lean`.

## The convention that makes the purchase visible

Every declaration whose proof evaluates a certificate opens its docstring with the exact phrase

> **Trust purchase: native evaluation.**

so `grep -rn "Trust purchase" Proofs/` enumerates the ledger from the source, and so a reader who
opens only that one theorem is told before they read the statement. `scripts/Axioms.lean` prints the
same ledger from the *environment*; the two must agree, and the gate compares them.
-/

namespace HadwigerNelson

open Std.Sat Std.Tactic.BVDecide

/-- **Certificate ingestion.** A checked LRAT proof establishes unsatisfiability.

This theorem is axiom-clean; the purchase is made by whatever evaluates `h`. `native_decide` is
currently the only thing that can (see the module docstring), so a call site reading
`unsat_of_check (by native_decide)` is buying the axiom right there, and owes a note saying so. -/
theorem unsat_of_check {π : Array LRAT.IntAction} {f : CNF ℕ} (h : LRAT.check π f = true) :
    f.Unsat :=
  LRAT.check_sound π f h

/-! ## Diagnosis

`native_decide` can only say "no". At de Grey scale it says "no" about one of 256 cubes without
saying which, and the failing term is unreadable. This is the analogue of `UDCert.badEdges`: it runs
compiled, so it is instant at any size, and it names the culprit. -/

/-- The cubes whose certificates fail to check, each with its index in `cubes`.

**Run `#eval badCubes k n E cubes proofs` the moment a cube's `native_decide` fails.** An empty list
means every certificate checks. A cube appears here for one of three reasons, in decreasing order of
likelihood:

* the certificate is **stale** — the CNF was regenerated (different `E`, different `k`, reordered
  edge list) and the certificate's clause ids no longer refer to the clauses they were derived from;
* the certificate is attached to the **wrong cube** — an ordering mismatch between the emitter's
  loop and `allCubes k W`;
* the cube is genuinely **satisfiable**, in which case no certificate exists and the problem is
  upstream: wrong graph, wrong `k`, or a colouring really does exist.

Cubes with no certificate at all (a `proofs` list shorter than `cubes`) are reported too, rather
than silently dropped by `zip`. -/
def badCubes (k n : ℕ) (E : List (Fin n × Fin n)) (cubes : List (Cube n k))
    (proofs : List (Array LRAT.IntAction)) : List (ℕ × Cube n k) :=
  cubes.zipIdx.filterMap fun (cb, i) =>
    match proofs[i]? with
    | none => some (i, cb)
    | some π => if LRAT.check π (coloringCNF k n E ++ cubeCNF k n cb) then none else some (i, cb)

end HadwigerNelson
