# M05 — the kernel-checkable certificate checker  *(stub — carry-forward notes only)*

> A big-integer refutation checker that Lean's **kernel** can run, its soundness proof, and the
> packed certificate format it consumes. Terminal test: a real de Grey cube refutation checked by the
> kernel, axioms exactly `[propext, Classical.choice, Quot.sound]`, at a cost that scales to the full
> 1024-cube split.

Not yet subplanned. Everything below is measured — see `plans/spike-kernel-lrat.md` for the numbers,
the method, and the files that produced them.

## Why this is a milestone, and why it is ahead of the headline

It was written off as needing its own soundness proof from scratch. **That was wrong**: core's generic
`lratChecker` already kernel-reduces a real refutation and `lratCheckerSound` is axiom-clean — see the
committed proof at `spikes/KernelLratEscape.lean`. What is missing is throughput, measured at ~430×.

It comes *before* χ(ℝ²) ≥ 5 because the packed certificate format is shared work either way. Doing it
first means rung B ships once, kernel-clean, and the trust ledger never grows ~1024 native entries
only to have them removed. **If the soundness proof stalls, rung B proceeds through `native_decide` on
the same packed certificates** — so a stall costs the proof, not the milestone.

## Settled by measurement, do not re-derive

* **The shipped `LRAT.check` is blocked by one thing**: `Std.HashMap` in `DefaultClause.ofArray`,
  whose bucket indexing computes on `USize`, whose width is an `@[extern] opaque` the kernel cannot
  unfold. Not the well-founded recursion, not `Array` mutation, not `performRupAdd`.
* **Throughput at 6324 variables**: core's engine ~100–180 ms per propagation step and superlinear;
  big-integer masks **0.35 ms**. Dense clause masks beat sparse literal lists **2.6×**.
* **Scale**: depth-5 cube split → 1024 cubes, 96 of them non-trivial, **1.30 × 10⁷ hint entries
  total**. That is 22.6 days through core's checker against **1.26 hours** through masks.
* **Certificate format**: `Array IntAction` needs ~22 GB and **will not elaborate**. Packed into
  **~50 Kbit `Nat` chunks, ~64 per cube** it is ~80 MB and elaborates in seconds. Olean overhead is a
  flat ~2.3 KB per chunk; elaboration time is linear in chunk size.
* **No RAT support needed** (zero `.addRat` across three certificate families) but **deletion lines
  must be parsed** (381 in one real cube certificate), even though they may be ignored semantically.
* **Recurse structurally over a `List`, never `Nat.fold`** — `Nat.fold` is superlinear in the kernel.
* **Do not use `Nat.ldiff`.** It exists and looks like the right primitive; it is not accelerated and
  loses the entire speedup. Use `x ^^^ (x &&& y)`. See the spike for the measurement.

## Two scoped pieces of work inside this milestone

**The "exactly one bit set" lemma** (`x ≠ 0 → x &&& (x-1) = 0 → ∃ i, x = 2^i`) is genuinely absent
from Mathlib. Proving it lets the checker *derive* the forced literal instead of being told it, which
removes one field from every one of 1.3 × 10⁷ propagation steps — **roughly halving the artifact,
~140 MB → ~80 MB** — for about 30–40 lines. The recursion is worked out in the spike: split on parity.
Worth doing here, and worth offering back to Mathlib. **Fallback if it resists: the emitter names the
variable and the checker verifies `un = 2^i`, which needs no new lemma at all.**

**The all-ones complement is already sound.** `Nat.testBit_two_pow_sub_one` is in Mathlib, so
`W ^^^ x` as complement-within-width needs no new groundwork.

## The obligation

```lean
theorem maskCheck_sound (π : Array LRAT.IntAction) (cnf : CNF Nat) :
    maskCheck π (compile cnf) = true → cnf.Unsat
```

`compile` sits **inside** the statement so the mask compiler stays untrusted. The proof is one
induction with one invariant — "every total assignment satisfying the formula and falsifying the
clause under construction agrees with both masks" — sketched in § 7 of the spike. Note `CNF.Unsat`
quantifies over arbitrary total `a : Nat → Bool`, so the bridge lemma must cover variables the formula
never mentions; `Std.Sat.CNF.lt_numLiterals` is the route.

## Unmeasured, and worth measuring in the subplan

* Elaborating a ~36,000-entry clause table of 6324-bit integers. `HadwigerNelson.PtTable` is the
  pattern (O(log n) kernel lookup) but has never held big integers.
* The real per-step cost with the clause-table lookup included — the 0.35 ms microbenchmark had no
  lookup in it.
* Whether a better split set beats the greedy-by-degree one, and whether the depth-5 cliff is a
  property of that set or of the graph.
