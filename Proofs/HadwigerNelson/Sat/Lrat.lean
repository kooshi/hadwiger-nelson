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
| `by decide +kernel` | gets much further: it *does* reduce `Array.any`, the `@[no_expose]` `Decidable (∃ v, VarMem v f)` instance, and `compactLratChecker` on trivial input — then sticks inside `Formula.performRupAdd` after ~40 s |
| `by native_decide` | succeeds, instantly |

So the LRAT half of this project buys a native-evaluation axiom, and buys it for *every*
certificate including the two-clause one. Core's own `bv_decide` does the same — its final step is
`nativeEqTrue`, not a kernel reduction — so this is the state of the art rather than a gap in our
setup. The kernel-checked route would require an LRAT checker written to reduce, with its own
soundness proof; that is a milestone, not a tactic swap, and it is tracked as open work in
`ARCHITECTURE.md` § 5.

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

end HadwigerNelson
