# M18 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer (WORKFLOW 2.0 step 9's theorem-tracking rule, backfilled by the
theorem audit). Enumeration: `plans/M18-the-120-degree-class.md` read in full. Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — Odd cyclic rotations beyond order 3 do not arise in K. [hand; the M18 implementer; deferred and never
completed]** No point of `K² = ℚ(√3,√5,√7,√11)²` realises a unit-distance closed cycle of odd order other than 3: in
particular the order-5 rotation by 72° (`cos 72° = (√5−1)/4 ∈ ℚ(√5)`, `sin 72° = √(10+2√5)/4`) is not expressible in
`K`, because `ℚ(sin 72°)` is a cyclic quartic field (Galois group `ℤ/4`) while every subfield of `K` has Galois group a
quotient of the elementary abelian `(ℤ/2)³`, which contains no element of order 4 — so `ζ₅ ∉ K` and, by the same
argument, `ζ₈ ∉ K` (which needs `√2 ∉ K`), leaving `{3,4,6,12}` as the only closable cycle orders and 3 the only odd
one. *Proof:* `plans/M18-the-120-degree-class.md` §0(d) ("The pentagon correction — caught before formalizing the
wrong theorem") — a one-paragraph sketch that states the mechanism and explicitly defers the formal statement to "§5";
the file's actual §5 ("Operational rules in force") does not contain it, and no later milestone found in this audit
(`cyclic quartic`, `sin 72`, `pentagon` grepped across `plans/`) completes it. *Proof verdict:* unsure — owner to
re-derive (the mechanism is right in outline — a cyclic-order-4 Galois group cannot embed in an elementary abelian
2-group — but the sketch never checks that `ℚ(sin 72°)` really is Galois of degree 4 with cyclic group, nor spells
out the `ζ₈` clause with the same care). *Rests on it:* the census finding in `tools/classstat.py` ("no pentagon class
carries a unit edge", row 13) stands as a [tools] measurement on its own regardless of this argument's completion.
*Prior art:* ours — elementary Galois theory of multiquadratic fields, applied to a project-specific object; no held
key. zbMATH: `ti:"cyclotomic field" & ab:"multiquadratic"` (0 hits), `ab:"Galois group" & ab:"regular pentagon" &
ab:"unit distance"` (0 hits). *Kernel:* declined — the plane-level Lean statement actually proved at M18 is the
(unconditional) triangle identity; this field-theoretic uniqueness claim was explicitly deferred and never
formalised.

## Readings and measurements that were called theorems

- The row 13 ledger clause "the growth-family hunt is closed exhaustively (557M class-tests); SAT pool statistics
  measure the solver, not the colouring space" is pure [tools] negative knowledge (M17–M19), not a theorem; already
  correctly graded in `LEDGER.md`.

## Conjectures surfaced, not claimed

(none beyond T1 itself, filed above with verdict *unsure*)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined — informal, deferred, never completed |
