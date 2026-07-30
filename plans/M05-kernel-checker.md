# M05 — the kernel-checkable certificate checker

> A refutation checker Lean's **kernel** can run, its soundness proof, and the packed certificate
> format it consumes. Terminal test: a real de Grey cube refutation checked by the kernel, axioms
> exactly `[propext, Classical.choice, Quot.sound]`, at a measured cost that scales to the full
> 1024-cube split.

*Subplanned 2026-07-29 on the laptop (12 cores, 31 GB), idle, load < 0.7. All timings are CPU
seconds (user + sys), minimum of three runs, baseline subtracted, each run under a
`systemd-run --scope -p MemoryMax` cap.*

---

## 0. What this subplan overturned

Three things the spike (`plans/spike-kernel-lrat.md`) had wrong or unmeasured. Each changed the
design, so they lead.

**(a) The "exactly one bit set" lemma is already in Lean core.** The spike said
`x ≠ 0 → x &&& (x-1) = 0 → ∃ i, x = 2^i` was "genuinely not in Mathlib (checked in several
phrasings)" and budgeted 30–40 lines plus a Mathlib contribution. It is
`Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo` in `Init.Data.Nat.Power2.Lemmas`, with
`Nat.isPowerOfTwo n := ∃ k, n = 2 ^ k`, both directions, axiom-clean, plus a `Decidable` instance
that is exactly the two-operation test. Verified in `spikes/M05Probe.lean`.

This is the **third** time a "not present" claim here has been wrong (`Nat.ldiff`,
`Nat.testBit_two_pow_sub_one`, now this). The search that found it was `grep` over the *toolchain
source tree*, not `exact?` and not Loogle — and it was in **core**, which a Mathlib-only search
cannot see. That is the transferable lesson, and it is now in `CLAUDE.md`.

**(b) A clause database built by accumulation is dead — measured, catastrophically.** The natural
shape is a trie grown by `insert` as derived clauses arrive. Measured per-propagation-step cost of
exactly that:

| clause database | clauses | per step |
|---|---|---|
| trie built by a chain of `insert`s | 2,381 | 2.14 ms |
| trie built by a chain of `insert`s | 33,089 | **16.7 ms** |

**Cost per lookup is proportional to the size of the whole database, not to the lookup depth.** A
data structure built by *N* nested function applications costs O(N) to bring to weak head normal
form, and each of its sub-terms costs again — so the "O(log n)" descent is O(n) in practice. At
33,089 clauses this route is 60 days. Reproduce with `spikes/M05Bench.lean`.

The fix is the one M04 already found for the vertex table: **the database must be a literal.**

**(c) The per-step cost is bound by the number of kernel reduction steps, not by bit width.** The
spike's headline was 0.35 ms per propagation step for big-integer masks, measured with no clause
lookup in it. With the lookup included it is ~2.5 ms, and the arithmetic is the cheap part. The
cost model, measured directly:

| what | cost |
|---|---|
| one iteration of a trivial recursive `Nat`-fuel loop | **33 µs** (linear: 20k → 0.66 s, 100k → 3.28 s) |
| `x &&& y`, `x ^^^ (x &&& y)`, `x &&& (x-1)`, `x % 2^k`, `2^k` at 6324 bits | **free** — inside loop-overhead noise |
| `1 <<< n`, `w >>> n` at 6324 / 50,000 bits | 15 µs / 22 µs |
| a literal chunk table lookup + clause reconstruction | **~2.2–3.0 ms**, flat in table size *and* chunk size |

**Every big-integer operation this project needs is free. Reduction steps are what cost.** At ~33 µs
a step, a propagation costs whatever its step count is — so the design target is *fewest reduction
steps per propagation*, and bit width is irrelevant. This also independently explains the spike's
measurement of core's own checker at 100–180 ms per step: core rebuilds a 6,325-slot assignment
array per propagation, and 6,325 × 33 µs = 209 ms. The model predicts the number that was already
measured, which is the reason to trust it.

## 1. The projection, and the kill criterion it trips

| | |
|---|---|
| propagation steps at depth 5 (measured, spike § 4) | 1.30 × 10⁷ |
| projected per step, literal table + unpack + propagate + decode | ~1.5–2.5 ms |
| **total processor time** | **5.4–9.0 hours** |
| wall clock, 96 independent cubes over 12 cores | **~30–50 minutes** |

**The spike's kill criterion 4 said "abandon if per-step exceeds ~2 ms, which would put the total
past a day."** The threshold is tripped and its stated consequence is not: 96 cubes are embarrassingly
parallel, so the total is hours of processor time and under an hour of wall clock. The criterion was
written against a single-threaded picture. **Restated for M05: abandon if projected processor time
exceeds ~40 hours, or if a re-checker on 4 cores cannot finish overnight.** We are a factor of four
inside that.

Recorded plainly: this milestone got ~7× more expensive than the spike advertised, and it is still
affordable. The 0.35 ms figure should not be quoted again.

## 2. The shape

Three modules. The whole trust surface is two kernel-checked `Bool`s and one theorem.

```
Sat/Mask.lean        the propositional layer — clauses and assignments as bitmasks,
                     one propagation step, and its soundness
Sat/ClauseTable.lean the literal chunk table and its agreement with a `CNF Nat`
Sat/MaskCheck.lean   the certificate decoder, the checker, `maskCheck_sound`
```

### 2.1 The certificate is nothing but hint lists

The design that fell out of (b): **all clauses — input and derived — live in one emitted literal
table**, because derived clauses are known to the emitter in advance. The checker never inserts
anything. Its only state is a **watermark**: clause ids below it are justified.

So an action does not need to carry a clause, and it does not need to carry an id either — ids are
dense and consumed in order:

```lean
inductive Action where
  | addRup   (hints : List Nat)   -- justifies the clause at the current watermark
  | addEmpty (hints : List Nat)   -- justifies ⊥, and ends the proof
```

The certificate is a packed sequence of hint lists. That is smaller than the spike's format (no ids)
and it removes the dynamic database entirely.

**Decision — clauses in the table, not in the certificate.** *Alternative:* each action carries its
own clause literals, as core's `IntAction` does, and the checker keeps a database. *Why this one:*
the database would have to be an accumulator, which measurement (b) shows costs O(database) per
lookup. *Confidence: high* — the 2.14 ms → 16.7 ms scaling is unambiguous.

**Decision — no `del` action, and the emitter drops deletion lines.** *Alternative:* parse deletions
and ignore them, as the spike proposed. *Why this one:* a larger clause database only makes
propagation *harder*, so ignoring deletion can never accept a bad certificate; with the table
emitted as a literal there is nothing to delete from, and dropping the 381 deletion lines per cube
in the emitter keeps `Action` two constructors wide. *Confidence: high.*

### 2.2 The propagation step, and what it does *not* need

For a clause under construction `C`, start from `α₀ = ⟨C.neg, C.pos⟩` — the assignment that
falsifies `C`. Then per hinted clause `D`:

```lean
up := D.pos ^^^ (D.pos &&& α.neg)     -- positive literals not yet false
un := D.neg ^^^ (D.neg &&& α.pos)     -- negative literals not yet false
u  := up ||| un
-- u = 0                    → conflict; the RUP check succeeds
-- u ≠ 0 ∧ u &&& (u-1) = 0  → propagate: α := ⟨α.pos ||| up, α.neg ||| un⟩
-- otherwise                → fail
```

Three findings that shrink this relative to the spike's design:

* **No width, and no complement.** "Not yet false" is a *set difference*, `D.pos ^^^ (D.pos &&& α.neg)`,
  not a complement-within-width. So `W = 2^w - 1` never appears, and
  `Nat.testBit_two_pow_sub_one` — which the spike called "the load-bearing one" — is **not on the
  path at all**. The variable count leaves the design entirely.
* **No "is the clause already satisfied" test.** Dropping it is sound: a satisfied literal is
  non-false, hence inside `u`, hence *is* the propagated literal when `u` is a single bit. Saves
  three operations per step and one branch. Recorded because it looks like a missing safety check
  and is not one.
* **A tautology test is genuinely required.** With `v` in both `D.pos` and `D.neg`, a single-bit `u`
  can carry two literals, and propagating both makes the assignment inconsistent — from which a
  later clause yields a bogus conflict. Worked example in § 5. So: `compile` drops tautological
  input clauses (sound — removing clauses only weakens the database), and the checker rejects a
  tautological derived clause loudly.

### 2.3 The propositional layer stays free of masks

Satisfaction and extension are stated over `testBit` against a total assignment, never over a mask
of one — which is what lets the bridge to `Std.Sat.CNF.Unsat` (a `∀ a : Nat → Bool`) go through
without a width argument:

```lean
def MClause.Sat (a : Nat → Bool) (c : MClause) : Prop :=
  (∃ i, c.pos.testBit i = true ∧ a i = true) ∨ (∃ i, c.neg.testBit i = true ∧ a i = false)

def Asg.Extends (a : Nat → Bool) (α : Asg) : Prop :=
  (∀ i, α.pos.testBit i = true → a i = true) ∧ (∀ i, α.neg.testBit i = true → a i = false)
```

**Consequence: `CNF.numLiterals` and `Std.Sat.CNF.lt_numLiterals` are not needed.** The spike named
them as the route for variables the formula never mentions. With no width in the design there is
nothing to bound.

### 2.4 The invariant, and the induction

One invariant, over the watermark:

> **Every clause the table holds at an id below the watermark is entailed by `f`.**

and inside a RUP check, one more:

> **Any total assignment that satisfies `f` and falsifies the clause under construction extends the
> checker's current partial assignment.**

The second is the spike's § 7 invariant, unchanged. The first replaces "every clause in the database
is entailed", and is easier because the database never changes — only the watermark moves.

### 2.5 The table

A pivot-split literal tree of big `Nat` chunks — M04's `PtTable` pattern, with chunks instead of
points. Each chunk packs a block of fixed-width clause slots; each slot packs the clause's literals
as 24-bit zig-zag fields, terminated by a zero field.

**Decision — one uniform slot width, not one per chunk.** *Alternative:* a per-chunk width read from
a chunk header, so that one long derived clause does not pad every slot in the table. *Why this one:*
it is the cheapest adequate shape, it costs one fewer reduction step per lookup, and which wins
depends entirely on the real distribution of derived-clause lengths — which is unmeasured (§ 7).
*Confidence: medium — if learned clauses turn out to have a long tail, the per-chunk width goes in.*

Measured at 37,000 clauses × 8 literals: 2.4 MB of source, **12.7 s to elaborate**, and a lookup
cost flat in both table size (2,000 → 37,000 clauses: 2.73 → 3.06 ms) and chunk size (2,160 →
50,000 bits: 3.06 → 2.82 ms). 50 Kbit chunks are marginally best of the two measured; a proper
sweep is an implementation task, worth about 10%.

Projected artifact: the input-clause table is **shared across all 96 cubes** (same colouring
formula), ~1.5 MB. Per-cube derived tables are ~0.5 MB each. With ~80 MB of hint payload, the whole
proof is **~110 MB** of compiled modules.

## 3. The statement

```lean
theorem maskCheck_sound {f : CNF Nat} {L : Layout} {tbl : ClauseTable} {cert : List Nat}
    (hagree : agreesWithCNF L tbl f = true)
    (hcheck : maskCheck L tbl f.clauses.size cert = true) :
    f.Unsat
```

Both hypotheses are closed `Bool`s the kernel decides. `agreesWithCNF` compares the table's first
`f.clauses.size` slots against masks computed *by Lean* from `f`, so the emitter stays untrusted in
exactly the M04 sense: a wrong table cannot make a false theorem, only a failed check. Projected
cost of `agreesWithCNF` on the real formula: 33,089 lookups ≈ **85 s**, once per formula, not per
cube.

**Decision — agreement is a pointwise check, not `compile f = tbl`.** *Alternative:* define a Lean
`compile : CNF Nat → ClauseTable` and prove the emitted table equal to it. *Why this one:* a Lean-built
table is an accumulator, and reducing one costs 32.6 s *and* produces a structure of a different
shape from the literal, so the equality cannot be stated directly. Pointwise agreement compares like
with like. *Confidence: high.*

## 4. Skeleton — the agenda

`Sat/Mask.lean`, `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean`, every signature and full theorem
statement present, `sorry` at every leaf. The leaves, in dependency order, with what each is:

Eleven leaves.

| leaf | what it is | risk |
|---|---|---|
| `MClause.ok_iff` | the `Bool` tautology test means `Ok` | low |
| `MClause.sat_ofClause_iff` | packed masks agree with `CNF.Clause.eval` | low — `testBit_or`, `testBit_two_pow` |
| `Asg.extends_negate` | a falsifying assignment extends `α₀ = ¬C` | low |
| `propagate_conflict_sound` | `u = 0` contradicts `Extends` plus `Sat` | low |
| `propagate_prop_sound` | **the one genuinely new proof** — a single-bit propagation preserves `Extends` | medium |
| `justified_of_agreesWithCNF` | the checked table gives entailment for the formula's own ids | low |
| `rup_sound` | induction over the hint list on `Extends` | low, once the two `propagate` leaves land |
| `runActions_more` | the watermark invariant survives a batch of actions | low |
| `runActions_done` | justifying `⊥` refutes any satisfying assignment | low |
| `runChunks_sound` | the same across chunks | low |
| `maskCheck_sound` | composition | low |

`propagate_prop_sound` is the only leaf whose shape is not routine, and its two ingredients are both
in hand: `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo` gives `u = 2^i`, and disjointness of
`up`/`un` (from the tautology check) forces the single non-false literal to be the one the
assignment gains.

### 4.1 The spec, validated where it is cheap

The skeleton elaborates, and its spec sections already run the whole path on
`(x ∨ y) ∧ (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y)` — the same formula as
`spikes/KernelLratEscape.lean`, so the two routes check the same refutation. What passes today, with all
eleven `sorry`s still standing at the leaves above:

* the packing round-trips: every table slot equals the mask independently compiled from the clause
  list by `MClause.ofClause`;
* a genuine three-step refutation — derive `(x)`, derive `(¬x)`, derive `⊥` — is **accepted**;
* the decoder's output is pinned by `#guard_msgs` on its rendered form, so a format change is caught
  by name rather than by a mysterious `false`;
* **all six negative controls go red**: a hint citing an unjustified clause, a hint list that does
  not propagate, the empty-clause action removed, a corrupted table slot, a table checked against a
  different formula, an empty certificate;
* the tautology hazard of § 2.2 is pinned as a `#guard` — `propagate` really does force a variable
  both ways when handed a tautology, which is what makes `Ok` load-bearing rather than decorative;
* and the terminal test in miniature passes **through the kernel**: `spikes/M05Axioms.lean` shows
  `maskCheck … = true` by `decide +kernel` depending on axioms `[propext]` — no native evaluation.

So the format, the checker, the decoder, and the trust boundary are all validated before a single
soundness proof is attempted. What remains is the proofs and the scale.

## 5. Negative controls — the gate must be seen to fail

Per `CLAUDE.md` § "Make the gate fail, and watch it fail", each check gets a partner that goes red.

| control | must fail with |
|---|---|
| certificate filed against a different cube's formula | `maskCheck` false |
| one hint id raised above the watermark | `maskCheck` false |
| a satisfiable formula with a hand-built "certificate" | `maskCheck` false |
| one clause slot in the table corrupted | `agreesWithCNF` false |
| a **tautological** derived clause admitted, tautology check removed | the doctored checker "proves" an arbitrary clause — the § 2.2 worked example, as a test that the check is load-bearing |
| the empty-clause action removed from the certificate | `maskCheck` false (no `addEmpty`, no success) |

The tautology control is the important one: it is the only place where removing a check produces a
*wrong theorem* rather than a failed check, so it is the one that must be exhibited.

## 6. Measured, do not re-derive

* Core's shipped `LRAT.check` is blocked by `Std.HashMap` in `DefaultClause.ofArray` reaching an
  `@[extern] opaque` word size. Not the well-founded recursion, not `Array` mutation.
* Core's *generic* `lratChecker` does kernel-reduce and `lratCheckerSound` is axiom-clean
  (`spikes/KernelLratEscape.lean`) — but at 100–180 ms per step it is 22.6 days.
* Depth 5 is the cube-split optimum: 1,024 cubes, 96 non-trivial, 1.30 × 10⁷ hint entries. Depth 4
  is over a 785× cliff; deeper is worse. The monolithic instance does not finish in 320 s.
* No RAT support needed (zero `.addRat` across three certificate families). **Pin the solver flags**
  rather than trusting the default to stay RUP-only; the checker fails loudly if it changes.
* **Do not use `Nat.ldiff`.** Kernel acceleration is by *name* for `land`/`lor`/`xor`; `ldiff` is a
  Mathlib definition and reduces through the `bitwise` recursion at ~one step per bit — 50 operations
  at 6324 bits does not complete in 240 s, where `x &&& y` is free. Use `x ^^^ (x &&& y)`.
* **Recurse structurally, never `Nat.fold`** — superlinear in the kernel.
* **Do not build hint lists with `List.range` + `List.map`.** Measured 0.83 ms per element in the
  kernel. This was a real defect in my own benchmark harness before it was a design note; the real
  decoder recurses structurally over packed fields and does not touch either.
* `Fin` pairs cost ~2.4 KB of olean each (M04's `Edges.olean`: 18.6 MB for 7,877 pairs) because each
  carries a proof. Plain `Nat` data in a literal tree costs ~145 bytes per node (M04's `Table.olean`:
  14.5 MB for ~100,000 nodes). A `Nat` *literal* costs ~2.3 KB. **Few big literals, no proofs in
  emitted data.**

## 7. Unmeasured, and worth measuring during implementation

Ranked by how much they move the projection.

1. **Whether a better split set beats greedy-by-degree.** Total hint entries multiply straight into
   the 5.4–9 hour projection, and only one split family has ever been tried. Solving is ~2 minutes
   for all 1,024 cubes, so this is cheap to explore and is the single highest-leverage knob.
2. **Real learned-clause lengths.** `unpack` costs one reduction step per literal, and the projection
   assumed ~10. Read it off a real certificate before fixing the slot layout.
3. **Chunk-size sweep** for the table and for the certificate — worth ~10%, and the two optima need
   not coincide.
4. **Whether a shallower, wider table tree pays.** Descent is ~8 reduction steps of the ~50 per
   propagation; a 16-way fan-out could halve it.
5. **Storing input clauses as masks rather than literal lists.** Removes `unpack` for the majority of
   lookups; costs ~52 MB of shared olean. Probably not worth it, but it is the fallback if the
   projection comes in high.

## 8. Fallbacks

If `propagate_prop_sound` resists past a few days, **rung B ships through `native_decide` on the
same packed certificates and the same table** — the checker, the format, and the emitter are all
reusable, and only the final `Bool` evaluation changes. A stall costs the proof, not the milestone.
The trust ledger would then grow one purchase per cube, which is exactly what M05 exists to avoid,
so this is a retreat and is to be reported as one.
