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
Sat/Mask.lean        the propositional layer — `LitSet`, one type read two ways, plus one
                     propagation step and its soundness
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

### 2.3 One type, two readings — the domain-modeling pass

*Run 2026-07-29. Probe: `spikes/M05Model.lean`. Every claim below was checked in Lean before the
skeleton was changed.*

The skeleton carried `MClause` and `Asg` as two structures with identical fields, plus `Asg.negate`
swapping them. **That distinction was incidental structure.** A clause and a partial assignment are
one object — a set of literals — read two ways: a clause says *some* literal holds, an assignment says
*every* one does.

**Decision — one type `LitSet`, with `Any` (clause) and `All` (assignment).** *Alternative:* two
structures, so that swapping `propagate`'s arguments is a type error. *Why this one:* the evidence is
mechanical. The theorem relating the two readings,

```lean
theorem all_iff_not_any (L : LitSet) (a : Nat → Bool) : L.All a ↔ ¬ L.negate.Any a
```

comes out as **`And.comm` after normalization — a two-line proof.** Two genuinely different types
could not do that; it is De Morgan on one datum. The type distinction would also have bought little:
swapping the arguments is a wrong call, not an illegal state, and it can only cause a failed check.
*Confidence: high* — the proof is in the file, and it replaced a leaf (`extends_negate`) rather than
adding one.

**Decision — the non-tautology invariant stays extrinsic (`LitSet.Ok`).** *Alternative:* a `Subtype`
or a bundled proof field, since `propagate_prop_sound` needs it and `Justified` carries it at every
id. *Why this one:* forced by the collapse above. The clause reading needs it; the assignment reading
has no use for it at all, because the soundness argument always has a total assignment in hand whose
existence rules inconsistency out for free. Bundling would tax exactly the half of the uses that do
not need it. *Confidence: high* — this is the placement cut with a clean answer.

**Decision — `testBit` is the vocabulary; no bit-set abstraction of our own.** *Alternative:* a
`BitSet` wrapper over `Nat` with its own membership lemma API. *Why this one:* core tags
`Nat.testBit_and`, `testBit_or` and `testBit_xor` `@[simp, grind =]`, so **`testBit` is the library's
own normal form**, not a preference of ours. A wrapper would fight it: `simp` and `grind` unfold
straight through, and every lemma would need restating. *Confidence: high — cited, not reasoned.*

**Consequence: `CNF.numLiterals` and `Std.Sat.CNF.lt_numLiterals` are not needed.** The spike named
them as the route for variables the formula never mentions. With no width in the design there is
nothing to bound.

**And the arithmetic core came out model-free.** The single-bit argument reduces to one `Nat` fact
with no SAT in it, which is now **proved** rather than pending:

```lean
theorem or_eq_two_pow_cases {x y i : Nat} (hu : x ||| y = 2 ^ i) (hd : x &&& y = 0) :
    (x = 2 ^ i ∧ y = 0) ∨ (x = 0 ∧ y = 2 ^ i)
```

Grepped against the toolchain source and Mathlib: genuinely absent, unlike the last three such
claims. Worth offering upstream. It is also exactly where the non-tautology hypothesis is consumed —
without `x &&& y = 0` both sets could hold the bit — so the invariant's necessity is now visible in
one statement instead of argued in prose.

### 2.4 The packing parameters live in the table, and the decoder is a variable

**Decision — the clause table's field width, slot capacity and slots-per-chunk are *fields of the
table*.** *Alternative:* a separate `Layout` structure passed alongside, as the first skeleton had.
*Why this one:* the emitter chose them, they are untrusted exactly as the chunks are, and
`agreesWithCNF` re-derives the formula through them — so they are part of the emitted datum. Keeping
them out meant threading a parameter through `rup`, `runActions` and `runStream`, none of which ever
inspect it. Cost: about three extra projections per lookup out of ~50 reduction steps.
*Confidence: high.*

**Decision — the certificate's field width is a separate number, and the decoder is a parameter of
the checker.** *Alternative:* one shared layout for both blobs, which is what reusing 24 bits
everywhere amounts to. *Why this one:* two blobs, two packings, and § 7 already predicts their optima
will differ. Making the decoder a parameter then does something better than tidy the signature —
`runStream_sound` is proved for **every** function of the decoder's type, so "nothing about the
decoder is trusted" becomes a universally quantified variable instead of a docstring promise, and
accidental reliance on the real decoder would be a type error. *Confidence: high* — it weakens a
hypothesis, which makes the theorem stronger and the proof easier.

**Decision — the watermark stays a `Nat`.** *Alternative:* a `Finset` of justified ids, or a deep
embedding of derivations as an inductive relation. *Why this one:* what the checker establishes is a
downward-closed prefix, ids are dense because our own emitter numbers them, and nothing here ever
reasons *about* proofs — only runs them. Both alternatives are speculative generality.
*Confidence: high.*

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

### 2.5 Obligation modeling — the statements the proofs come from

*Run 2026-07-29, after the domain pass. Every restatement below was checked in Lean before being
adopted; seven of the pending leaves closed in the process.*

**Decision — every soundness statement concludes something positive, not `False`.** *Alternative:*
the first skeleton's shape, `… = true → False`, with each layer used via `.elim`. *Why this one:* the
positive form is what composes. `rup_sound` concluding "this clause is entailed" rather than "a
contradiction follows" is what lets the empty-clause case be an *instance* of it, and it is why
`maskCheck_sound` is now a single line instead of a contradiction dance. *Confidence: high — the line
count is the evidence.*

**The empty clause needs no special handling.** `(⟨0,0⟩ : LitSet).Entails f ↔ f.Unsat` — "the empty
clause follows from `f`" *is* "`f` is unsatisfiable". So `runActions`' two branches are the same
operation on different clauses, and both cite one lemma. Proved.

**Decision — one `Outcome`-indexed statement replaces two theorems.**

```lean
def Outcome.Sound (t : ClauseTable) (f : CNF Nat) : Outcome → Prop
  | .done   => f.Unsat
  | .more w => Justified t f w
  | .fail   => True

theorem runActions_sound (hJ : Justified t f w) : (runActions t w acts).Sound t f
```

*Alternative:* the separate `runActions_more` and `runActions_done` the first skeleton had. *Why this
one:* they were two inductions over the same list with the same invariant, differing only in what the
terminal case concludes — indexing the conclusion by the outcome makes that one induction with three
two-line cases. *Confidence: high.*

**Decision — `rup_sound` is stated at an arbitrary assignment, not at the caller's `L.negate`.**
*Alternative:* an accumulator-generalized private helper underneath a clean public statement — the
usual two-level shape. *Why this one:* the accumulator here is already a universally quantified
argument, so the general statement *is* the public one and the caller's form is its instance via
`negate_negate`. One statement instead of two. `all_iff_not_any` — the duality found by the domain
pass — is exactly what converts "no satisfying assignment agrees with `α`" into "`α.negate` is
entailed", so the two passes' outputs meet here. *Confidence: high.*

**Decision — `agreesAux`'s strengthened statement carries membership, not position.** *Alternative:*
index-based, `∀ k < cs.length, t.get (id₀ + k) = ofClause cs[k]`. *Why this one:* membership is what
the conclusion consumes — `CNF.eval` is an `Array.all`, and core's membership variant
`Array.all_eq_true_iff_forall_mem` exists — so the position form would have dragged `getElem` side
conditions through a proof that never needs an index. It also makes the base case *vacuous*
(`id₀ ≤ id` and `id < id₀ + 0` cannot both hold) rather than a peeled special case.
*Confidence: high.*

**Decision — the undecided literal set is a named definition, and `propagate` is written over it.**
*Alternative:* leave the three expressions inline and state the shared lemmas over them. *Why this
one:* both propagation proofs need exactly one fact — the satisfied literal survives into the
undecided set — and that fact cannot be *stated* without naming the set. Naming it also isolates the
only two places bit arithmetic appears (`testBit_xor_and`, `or_eq_two_pow_cases`), so the two
soundness proofs become case analysis with no arithmetic in them. Costs about three reduction steps
per propagation out of roughly fifty. *Confidence: medium — if tuning shows those steps matter,
`propagate` inlines against a stated equation lemma without touching a proof.*

**Every recursion is structural over a list.** Descent measures, in full: hint list (`rup`), action
list (`runActions`), chunk list (`runStream`), clause list (`agreesAux`, `any_foldl_insert`), and the
slot's literal capacity (`unpackAux`, a `Nat` fuel). **Nothing in the checked path needs a termination
argument or well-founded recursion**, which was a design goal and now holds by construction.
`generalizing` is needed in four places: the fold accumulator, the starting id, the assignment, and
the watermark.

### 2.6 Experience modeling — the surface M06, `tools/`, and a reviewer consume

*Run 2026-07-29, after the obligation pass.*

**Decision — the diagnostic is the primary definition and the `Bool` is derived from it.** *Alternative:*
M04's arrangement — a `Valid : Bool` for the kernel beside a `badEdges : List` for `#eval`, related by a
proved lemma (`badEdges_eq_nil_iff`). *Why this one:* a `Bool` coming back `false` over 134,396 hints,
96 times, tells whoever must fix it nothing, so a diagnostic is not optional. Defining
`maskCheck := (whyNot …).isNone` and `agreesWithCNF := (firstFault …).isNone` means the checker and its
explanation are **the same computation**, so drift between them is impossible rather than ruled out by
an obligation someone maintains — and it removes a leaf instead of adding one. *Confidence: high — this
is an improvement on M04's own pattern, and worth carrying back when M08 reworks the geometry.*
Reduction cost is neutral: `Option CertFault` and `Bool` are one constructor either way, and faults are
built only on the failing path.

**The failure taxonomy**, each constructor carrying the clause id it happened at — which is what
locates a fault inside a 3,657-step certificate:

| fault | what it means |
|---|---|
| `TableFault.slotMismatch id held wanted` | the emitted table and the formula part company at `id`, with both values shown |
| `TableFault.tautology id held` | the formula's own clause at `id` has a variable on both sides |
| `CertFault.malformedChunk` | the certificate's field width or header is wrong |
| `CertFault.derivedTautology` | the clause being derived has a variable on both sides |
| `CertFault.hintUnjustified` | a hint cited a clause at or above the watermark — usually a stale certificate |
| `CertFault.hintNoPropagate` | a hint left two or more literals undecided — usually hints out of order |
| `CertFault.hintsExhausted` | the hints ran out before any conflict |
| `CertFault.noEmptyClause` | the certificate ended without deriving `⊥` |

**Decision — the emitter's contract lives in one table, indexed by the fault it causes.** *Alternative:*
leave it distributed across the docstrings of the definitions that implement each piece, which is where
it was. *Why this one:* a Python generator author has to get all of it right or the check fails, and the
question they actually hold is "I got `hintUnjustified`, what did I break?" — so the contract is indexed
by the fault, not by the definition. It is in `Sat/MaskCheck.lean`'s module docstring, stated as
authoritative so nobody has to open a second module. *Confidence: high.*

**Decision — `maskCheck_sound` takes the table, field width and certificate as *explicit* arguments.**
*Alternative:* implicit, as first written. *Why this one:* found by walking the call site — nothing
determines them, since the goal fixes only the formula, so every one of ~1000 generated cube modules
would have written `(t := …) (fw := …) (cert := …)`. That is the "argument every caller supplies by
hand" smell, and the binder mode was the bug rather than the caller. A generated module is now one
citation, and there is an `example` in the spec section pinning exactly that call site so a regression
is caught. *Confidence: high.*

**Decision — no graph-level bridge lemma in M05.** *Alternative:* export
`not_colorable_of_maskCheck`, combining this milestone's soundness theorem with M03's
`not_colorable_of_unsat`. *Why this one:* a per-cube module only needs unsatisfiability of its own
formula, and the graph-level step happens once in M06's assembly module, where M03's
`not_colorable_of_cubes` already lives. Adding the bridge here would make the checker module — imported
by every generated cube — depend on Mathlib. *Confidence: high.*

**Decision — keep `LitSet.Any`/`All` rather than domain names like `Sat`/`Agrees`.** *Alternative:* the
domain's own words, which read better to a reviewer in isolation. *Why this one:* the cold read shows
`Any`/`All` never reach the consumer surface — consumers see `Entails`, `Ok`, `Justified`,
`agreesWithCNF`, `maskCheck`, `whyNot` — while inside the module the logical form (`∃` versus `∀`) is
exactly what the lemmas are about, and it is what makes the duality legible. *Confidence: medium — if a
reviewer stumbles on them, rename; nothing depends on the choice.*

**The reasoning surface is stated and sealed.** Both modules now say, in their module docstrings, that
consumers reason through exactly `maskCheck_sound` and diagnose through `whyNot` /
`ClauseTable.firstFault`, and that `propagate`, `rupWhy`, `runActions`, `runStream`, `ClauseTable.get`
and `unpackAux` are shaped for reduction-step count and are never to be unfolded — a proof that wants
to is a missing lemma.

**Pinned with `#guard_msgs`:** the rendered text of four faults and of the decoder's output. The
serialized surface, not the API behind it, is what a future reader meets, so it is what goes under
regression control.

## 3. The statement

```lean
theorem maskCheck_sound {t : ClauseTable} {f : CNF Nat} {fw : Nat} {cert : List Nat}
    (hagree : t.agreesWithCNF f = true)
    (hcheck : maskCheck t fw f.clauses.size cert = true) : f.Unsat
```

Both hypotheses are closed `Bool`s the kernel decides. `agreesWithCNF` compares the table's first
`f.clauses.size` slots against literal sets computed *by Lean* from `f`, so the emitter stays untrusted
in exactly the M04 sense: a wrong table cannot make a false theorem, only a failed check. Projected
cost of `agreesWithCNF` on the real formula: 33,089 lookups ≈ **85 s**, once per formula, not per cube.

**This theorem is already proved** — it is the composition of `justified_of_agreesWithCNF` and
`runStream_sound`, and it went green during the modeling pass. What is open is the four inductions
under it.

**Decision — agreement is a pointwise check, not `compile f = tbl`.** *Alternative:* define a Lean
`compile : CNF Nat → ClauseTable` and prove the emitted table equal to it. *Why this one:* a Lean-built
table is an accumulator, and reducing one costs 32.6 s *and* produces a structure of a different
shape from the literal, so the equality cannot be stated directly. Pointwise agreement compares like
with like. *Confidence: high.*

## 4. Skeleton — the agenda

`Sat/Mask.lean`, `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean`, every signature and full theorem
statement present, `sorry` at every leaf. The leaves, in dependency order, with what each is:

**Ten leaves**, after two modeling passes closed eleven proofs and decomposed the two risky ones.
Every remaining leaf is a *single* induction or a *single* case analysis — none needs a walkthrough,
which is the test the obligation pass was run against.

| leaf | what it is | shape |
|---|---|---|
| `LitSet.ok_iff` | the `Bool` tautology test means `Ok` | `Bool`/`Prop` bridge |
| `LitSet.any_insert` | adding one literal adds exactly its satisfaction | `testBit_or`, `Nat.one_shiftLeft`, `testBit_two_pow` |
| `LitSet.any_foldl_insert` | the fold, accumulator quantified | induction on the clause list, `generalizing L` |
| `any_undecided` | a satisfied literal survives into the undecided set | `testBit_xor_and`, case analysis |
| `propagate_conflict_sound` | an empty undecided set contradicts `any_undecided` | case analysis, no arithmetic |
| `propagate_prop_sound` | **the one genuinely new argument** | case analysis over `or_eq_two_pow_cases` |
| `disagreement_eq_none_mem` | the table's prefix holds the formula's clauses | induction on `cs`, `generalizing id₀` |
| `rup_sound` | propagation to a conflict entails the clause | induction on hints, `generalizing α` |
| `runActions_sound` | one `Outcome`-indexed induction | induction on actions, `generalizing w` |
| `runStream_sound` | the same across chunks, arbitrary decoder | induction on chunks, `generalizing w` |

Already proved, across both passes: `or_eq_two_pow_cases` and `testBit_xor_and` (all the bit
arithmetic there is), `all_iff_not_any` and `negate_negate` (the duality), `not_any_zero` and
`entails_zero_iff_unsat` (why the empty clause is not a special case), `ok_undecided` (where the
non-tautology hypothesis is consumed), `any_ofClause_iff`, `justified_of_agreesWithCNF`, and
`maskCheck_sound` — the last now one line.

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
  list by `LitSet.ofClause`;
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
| certificate filed against a different cube's formula | `maskCheck` false, `whyNot` naming a fault |
| one hint id raised above the watermark | `CertFault.hintUnjustified`, **message pinned** |
| a hint list that does not propagate | `CertFault.hintNoPropagate`, **message pinned** |
| a satisfiable formula with a hand-built "certificate" | `maskCheck` false |
| one clause slot in the table corrupted | `TableFault.slotMismatch` with both values |
| a **tautological** derived clause admitted, tautology check removed | the doctored checker "proves" an arbitrary clause — the § 2.2 worked example, as a test that the check is load-bearing |
| the empty-clause action removed from the certificate | `CertFault.noEmptyClause`, **message pinned** |
| an empty certificate | `CertFault.noEmptyClause`, **message pinned** — not a vacuous success |

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
