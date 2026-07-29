# Spike — can the kernel check a SAT refutation at de Grey's scale?

*Run 2026-07-29, laptop (12 cores, 31 GB). All timings CPU seconds (user + sys), minimum of three
runs, baseline subtracted. Solver runs under a 6 GB cgroup cap.*

**Verdict: GO.** Three findings. The second is why the first is not enough, and the third removes
what looked like the biggest obstacle.

1. **The kernel can already check an LRAT refutation today, with no new soundness proof.** Verified
   end to end, axioms exactly `[propext, Classical.choice, Quot.sound]`.
2. **But it is ~430× too slow** — 22.6 days of processor time for de Grey, measured, versus **1.26
   hours** for the big-integer design. So the fast checker is not an optimisation; it is the thing
   that makes a kernel-checked `χ(ℝ²) ≥ 5` possible at all.
3. **Certificate delivery, which looked like the largest hazard, is solved** (§ 7b). The obvious
   representation needs ~22 GB and will not elaborate; packing the certificate into big-integer
   chunks — the same trick as the checker — brings it to **~80 MB, elaborating in seconds**.

---

## 1. Why the shipped checker cannot reduce — one cause, not the one recorded

`Sat/Lrat.lean` used to say `decide +kernel` "sticks inside `Formula.performRupAdd` after ~40 s".
**Both halves were wrong**, and it aimed the whole plan at the wrong target. `performRupAdd` reduces
fine; so does the well-founded recursion, the `Array` mutation, and the entire propagation engine.

The single obstruction:

* `DefaultClause.ofArray` builds every clause through an `Std.HashMap` to detect duplicate and
  complementary literals — the only hash map in the whole LRAT tree;
* hash-map bucket indexing computes on `USize`, whose width is `System.Platform.numBits`;
* `System.Platform.numBits` is `(System.Platform.getNumBits ()).val`, and `getNumBits` is
  `@[extern] opaque` — **the kernel has no delta rule for it**, so `2 ^ numBits` never becomes a
  literal and every `USize` operation is stuck forever.

Verified: `#reduce System.Platform.numBits` prints the unreduced
`(System.Platform.getNumBits PUnit.unit).1`; `(USize.ofNat 8 - 1).toNat = 7` will not reduce, while
the same statement over fixed-width `UInt64` reduces instantly.

## 2. Core already ships a checker that *does* reduce

`lratChecker` — generic, structurally recursive over `List (Action β α)` of **pre-converted** actions
— never calls `ofArray`, so it never touches a hash map. And `lratCheckerSound` is axiom-clean.

Verified on a genuine three-step RUP refutation of an unsatisfiable four-clause formula with
hand-built `DefaultClause`s:

```lean
theorem escape : lratChecker F prf = .success := by decide +kernel
theorem escape_unsat : Unsatisfiable V3 F :=
  lratCheckerSound F (DefaultFormula.readyForRupAdd_ofArray _)
    (DefaultFormula.readyForRatAdd_ofArray _) prf (by …) escape
-- 'escape_unsat' depends on axioms: [propext, Classical.choice, Quot.sound]
```

**So "the kernel-checked route needs its own soundness proof" was false.** What it needs is
throughput.

## 3. Throughput of the two candidates — measured

Per unit-propagation step, at de Grey's variable count (6324 variables / 6325 assignment slots):

| checker | per propagation step |
|---|---|
| core's `lratChecker` (25 → 200 step chains) | **~100–180 ms, and superlinear** |
| big-integer masks, dense clause masks | **0.35 ms** |
| big-integer masks, sparse literal lists | 0.90 ms |

Core's engine rebuilds a full 6325-slot assignment array per propagation and indexes clauses
positionally, which is where the 100–180 ms goes.

**Dense masks beat sparse literal lists 2.6×**, against instinct: GMP does a 6324-bit operation in a
few limb operations, while the sparse version pays list traversal and per-literal `testBit`.

## 4. What a de Grey refutation actually costs — the cube-depth cliff

Full instance, no proof logging: **does not finish in 320 s.** The cube split is mandatory.

Split set `W` chosen greedily by degree, with a unit triangle pinned to colours 0/1/2. Per
*properly-coloured* cube (the only non-trivial ones); an improperly-coloured cube costs 122 hints:

| depth | cubes = 4^depth | proper | adds / cube | **hint entries / cube** | cert / cube | **total hints** |
|---|---|---|---|---|---|---|
| 3 | 64 | — | *timed out at 240 s, 1.3 GB partial* | — | — | — |
| 4 | 256 | 48 | 2,113,042 | **105,590,674** | 951 MB | **5.07 × 10⁹** |
| **5** | **1,024** | **96** | **3,657** | **134,396** | 962 KB | **1.30 × 10⁷** |
| 6 | 4,096 | 192 | 2,790 | 138,042 | 980 KB | 2.70 × 10⁷ |
| 8 | 65,536 | 528 | 2,454 | 100,019 | 721 KB | 6.07 × 10⁷ |
| 10 | 1,048,576 | 1,464 | 2,055 | 82,423 | 614 KB | 2.48 × 10⁸ |

**There is a cliff between depth 4 and depth 5 — 785× in certificate size, 786× in hint entries.**
Depth 4 is over it and depth 5 is under it. Depth 5 is the optimum: fewest total hint entries *and*
only 1,024 cube theorems.

## 5. The decision, in processor time

At depth 5, **1.30 × 10⁷ hint entries** to check:

| route | total | wall clock at 5 parallel jobs |
|---|---|---|
| core's `lratChecker` @ 0.15 s/step | **22.6 days** | ~4.5 days |
| big-integer masks @ 0.35 ms/step | **1.26 hours** | **~15 minutes** |
| *today's route — compiled, `native_decide`* | seconds | seconds, but buys a compiler-trust axiom |

That is the whole case. The fast checker converts a dead route into a 15-minute one.

## 6. The design, as measured into shape

* **Assignment: two big `Nat`s** (`trueMask`, `falseMask`) over 6324 variables. Invariant
  `trueMask &&& falseMask = 0`, both ⊆ `W = 2^6324 - 1`.
* **Complement within the width is `W ^^^ x`, and "and-not" is `x ^^^ (x &&& y)`. Do not replace
  either with `Nat.ldiff`.** This is a trap, and it is the shape a reader will want to tidy into.
  `Nat.ldiff` *does* exist (Mathlib's, with `Nat.testBit_ldiff` ready-made) — an earlier note here
  claiming `Nat` has no and-not was wrong. But it is **not hardware-accelerated**: it is defined by
  recursion over bits, so at 6324 bits it costs thousands of steps where the accelerated operations
  cost one. Measured at 6324 bits over 500 operations: `x &&& y` and `x ^^^ (x &&& y)` both ~0.8–0.9 µs
  each; the `Nat.ldiff` version did not finish the same benchmark. Reaching for the cleaner-looking
  primitive silently costs the entire speedup this spike rests on.
* **Clauses: two big `Nat`s each** (`pos`, `neg`), dense. ~35,900 clauses per cube × 2 × 790 bytes ≈
  **56 MB** — the memory worry was misplaced: each cube adds only ~3,700 clauses, not the ~250,000 a
  pigeonhole instance suggested.
* **Deletion can be ignored entirely.** A smaller clause database only makes propagation *harder*,
  so skipping `.del` can never accept a bad certificate — and at 56 MB there is no reason to.
* **No RAT support needed.** Zero `.addRat` in the repo's spindle certificates, zero across a
  246,779-addition pigeonhole certificate, zero here. A RUP-only checker fails loudly if that ever
  changes. **Pin the solver flags** rather than relying on the default staying RUP-only.
* **"Exactly one bit set" has two routes; both work, and the trade is measured.**
  `x ≠ 0 → x &&& (x-1) = 0 → ∃ i, x = 2^i` is **genuinely not in Mathlib** (checked in several
  phrasings — and note a failed `exact?` proves nothing on its own; the shape has to be varied).
  - *Route A, no lemma:* have the untrusted emitter name the unit variable `i` and verify `un = 2^i`
    — one accelerated shift, one accelerated compare, and `Nat.testBit_two_pow` says exactly which
    bit it is. **Costs one extra field per propagation step, and there are 1.3 × 10⁷ of them**, so it
    roughly doubles the artifact: ~80 MB → ~140 MB.
  - *Route B, prove the lemma:* the checker derives the unit literal and the certificate carries no
    extra field. The proof splits on parity and is tractable — for even `x = 2y` the trick on `x`
    reduces exactly to the trick on `y` (`2y &&& (2y-1) = 2 * (y &&& (y-1))`), and for odd `x = 2y+1`
    it forces `y = 0`, hence `x = 1`. Both steps follow from bit extensionality plus the parity
    lemmas. Roughly 30–40 lines, and a genuine contribution back to Mathlib.
  - **Take Route B inside M05, with Route A as the fallback.** It buys ~60 MB and a cleaner checker
    for ~30 lines, and it is not a blocker either way.
* **Reject tautological clauses at load** (`pos &&& neg ≠ 0`): the unassigned-literal mask counts
  *variables*, so a variable occurring both ways is one bit but two literals.
* **Recurse structurally over a `List`, never `Nat.fold`** — `Nat.fold` is superlinear in the kernel
  (1,600 iterations costs 6.2 s with no data structures involved).
* Lemmas confirmed present: `Nat.testBit_or`, `testBit_and`, `testBit_xor`, `testBit_two_pow`,
  `Nat.eq_of_testBit_eq`, `Nat.testBit_ldiff`, and — the one that makes the width-complement
  legitimate, so it is the load-bearing one —
  **`Nat.testBit_two_pow_sub_one : (2^n - 1).testBit i = decide (i < n)`**.

## 7. The soundness proof, sketched

One induction, one invariant. Let `τ` be any total assignment satisfying the formula, and suppose it
*falsifies* the clause being derived. Then `τ` agrees with the checker's starting assignment
`α₀ = ¬C`. **Invariant: `τ` extends `αᵢ`.** Each hinted clause is unit or falsified under `αᵢ`; in
the unit case `τ ⊨ D` and every other literal of `D` is already false under `αᵢ ⊆ τ`, so `τ` must
satisfy the remaining literal — the invariant survives. At the end the checker reaches a clause all
of whose literals are false under `αₙ ⊆ τ`, contradicting `τ ⊨ D`. Hence `τ ⊨ C`. ∎

The obligation is exactly `maskCheck_sound (π) (cnf) : maskCheck π (compile cnf) = true → cnf.Unsat`,
with `compile` **inside** the statement so the mask compiler stays untrusted — a bug there can only
make the check fail. Skeleton elaborates. Note `CNF.Unsat` quantifies over arbitrary total
`a : Nat → Bool`, so the bridge lemma must handle variables the formula never mentions;
`Std.Sat.CNF.lt_numLiterals` is the route.

## 7b. Certificate delivery — was the largest hazard, now solved (measured 2026-07-29)

The obvious representation does not work, and it fails on **elaboration**, not on checking.

Rendering one real depth-5 cube certificate as `Array IntAction` — the format core wants:

| fraction of ONE cube | additions | hints | Lean source | elaborates? | olean |
|---|---|---|---|---|---|
| 10% | 327 | 10,138 | 89 KB | yes, 10.6 s | **17 MB** |
| 50% | 1,638 | 85,932 | 630 KB | **no — `maxHeartbeats` in `isDefEq`** | — |
| 100% | 3,276 | 134,396 | 969 KB | **no** | — |

Extrapolated to the full proof that is **~22 GB and it does not elaborate at all**. Each `Int` in an
array literal carries `OfNat` machinery, so ~1.7 KB of compiled module per hint entry.

**The fix is the spike's own insight applied to the data**: put the certificate in `Nat`s, not in
inductive structures. Pack each action's hint list into one `Nat` as fixed-width fields (24 bits per
id, entry count in the low 16 bits; literals zig-zag encoded to make them unsigned). Field extraction
is `(w >>> (24*k)) &&& 0xFFFFFF` — accelerated, the same operations the checker already uses.

That alone took the whole certificate from "will not elaborate" to **7.5 s and 16.4 MB**. Tuning the
chunk size then found a clean cost model — 391 KB of payload, split every which way:

| chunks | bits/chunk | elaboration | olean | overhead/chunk |
|---|---|---|---|---|
| 3,276 | 976 | 3.8 s | 8.0 MB | 2.3 KB |
| 328 | 9,756 | 2.3 s | 1.17 MB | 2.3 KB |
| **64** | **50,000** | **5.3 s** | **556 KB** | 2.3 KB |
| 16 | 200,000 | 18.8 s | 443 KB | 2.3 KB |
| 4 | 800,000 | 71.5 s | 415 KB | 2.5 KB |
| 1 | 3,200,000 | **298 s** | 405 KB | — |

Two clean laws: **olean overhead is a flat ~2.3 KB per chunk** regardless of chunk size, and
**elaboration time is linear in chunk size** (a single 3.2 Mbit literal is stored with *zero*
overhead — 405 KB for 391 KB of data — but takes five minutes to parse).

**Design: ~50 Kbit chunks, ~64 per cube.** Roughly 700 KB of compiled module per cube, so
**~80 MB for the whole proof** — a downloadable, re-checkable artifact, against 22 GB for the naive
form. Hex source is no cheaper than decimal (same olean, same time), so decimal is fine.

Also learned from this: real certificates **do contain deletion lines** (381 of them here, removing
2,770 clause ids). A checker may ignore them semantically but must *parse* them.

## 8. Kill criteria

Abandon and fall back to `native_decide` if any of these is observed:

1. The mask-to-assignment bridge lemma resists past a few days — it is the one genuinely new proof.
2. A real de Grey cube certificate turns out to contain `.addRat` steps after the solver flags are
   pinned.
3. ~~Emitting ~94 MB of certificate data proves unworkable.~~ **Resolved — see § 7b.** Packed into
   ~50 Kbit `Nat` chunks it is ~80 MB of compiled modules and elaborates in seconds. The naive
   `Array IntAction` form was ~22 GB and would not elaborate; that is the trap, and it is now
   measured and avoided.
4. Measured per-step cost at full scale exceeds ~2 ms, which would put the total past a day.

## 9. What was left unmeasured

* Elaborating a ~35,900-entry clause table of 6324-bit integers. M04's pivot-split table
  (`HadwigerNelson.PtTable`) is the pattern and gives O(log n) kernel lookup, but a table of *big
  integers* at that size has not been built.
* Whether a better split set `W` beats the greedy-by-degree one used here.
* Whether the depth-5 cliff position is a property of `W` or of the graph.
