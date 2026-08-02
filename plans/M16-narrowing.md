# M16 — Narrowing

*Subplanned 2026-08-02, on the desktop (32 cores, 128 GB). The stub's carry-forward notes are
superseded by measurement; the stub's § 3–4 triage discipline survives unchanged and is implemented
in the tool.*

> **M15 made a fan's existence free and left its narrowness untouched. M16 asked the narrowness
> question of the only fans in existence — and the answer arrived at subplanning time, in 1.5
> seconds, because the sweep the stub priced as expensive is collapsed by one observation: a single
> separating colouring rejects most classes at once. The milestone is now the certified form of
> that answer, plus the instrument the certificate needed: comparing exact field distances as real
> numbers, inside the kernel.**

---

## 0. What subplanning measured (all on the desktop, 2026-08-02)

### (a) The class inventory at the four fan pivots

For each of de Grey's four removable pivots (630, 633, 1420, 1423), the other 1,580 vertices fall
into **1,340 exact squared-distance classes** — identical profile at all four pivots, as the
rotation symmetry demands:

| kind | count per pivot | sizes |
|---|---|---|
| all classes | 1,340 | min 1 / median 1 / max 6 |
| rational `r²` | 22 | — |
| rational and **spindle-able** | **7** (`r² = 1/3, 4/9, 5/9, 1, 11/9, 16/9, 7/3`) | 2–4 vertices |
| `r² = 1/2` (the one closable width-2 geometry) | **0** | the jackpot class is *empty* |
| irrational `r²` | 1,318 | nearly all singletons |

The `r² = 1` class is the pivot's neighbourhood (all four pivots have degree 4 — removable vertices
are low-degree), where a fan is impossible outright.

### (b) The sweep is not expensive — the stub's cost model was off by five orders of magnitude

The stub budgeted 300 s per solve and priced the de Grey question in hours. Measured:

* a plain 5-colouring of the 1,581-point graph: **0.03 s**;
* the reject answer for one class (`fan(630, class, 5)` returning `separated`): **0.04 s**;
* **one separating colouring rejects 1,085 of 1,340 classes** (81%) — the colouring answers for
  every class whose members all miss the pivot's colour, so the pool of models replaces almost
  every solver call.

The sweep over **all 1,340 classes × all four pivots** — not just the spindle-able ones —
completed in **1.5 s total, 29 solver calls, zero deferrals**. The triage rule of the stub's § 3
stays in the tool because the *next* graph may need it; on this instance nothing was deferred, so
the negative is complete rather than budget-shaped.

### (c) The result: no fan narrows, at any width, to any single class

> **Every one of the 1,340 equidistance classes at every one of the four pivots is separated by an
> explicit proper 5-colouring.** Eight colourings per pivot suffice (five at 633). No fan in de
> Grey's graph — the only graph at the χ ≥ 5 boundary that carries five-colour fans at all — is
> confined to a single distance class. The closable width-2 geometry (`r² = 1/2`) is not merely
> unoccupied but empty of vertices.

Controls, all run before this was believed:

* **Known-hit control.** The identical sweep loop on de Grey's own 397-point opening configuration
  (orbit of his 39 seeds under the order-12 hexagonal group) at four colours reports **exactly one
  hit: the fan confined to the `r² = 4` class at the origin** (6 partners; M14 § 0(b) measured
  width 3 there, and 3 of the 6 suffice). The sweep can say "confined" when confinement exists.
* **Model verification.** Every separating colouring re-checked proper on all 7,877 edges and
  separating on its class, by a re-parse that shares no helper with the sweep's model reader.
* **Positive control** (running in background at subplan commit): the fan over *all* 1,580
  partners at 630 and 633 must come back UNSAT through the same `fanEdges` encoding — M15
  established this through the `k−1`-colour encoding; this closes the loop through the fan
  encoding. ~1.7–1.9 h each expected.

### (d) Numeric distinctness of the class values — what the Lean certificate must witness

The 1,340 class values per pivot are pairwise distinct as *real numbers*:

| pivot | scaled value range (denom² = 589,824) | min adjacent gap | relative |
|---|---|---|---|
| 630 | 16,740 … 8,714,586 | 6.50 | 7.5 × 10⁻⁷ |
| 633 | 1,972 … 6,893,405 | 1.96 | 2.8 × 10⁻⁷ |

So rational interval bounds on the four generators at ~10⁻¹² relative width separate every adjacent
pair with orders of magnitude to spare, and the interval widths compound linearly (16 terms,
integer coefficients ≤ ~10⁷).

### (e) Why the Lean statement needs that distinctness at all

The honest headline quantifies over **real** distances — "no set of vertices all at one real
distance from the pivot carries a fan". The classes are computed in `Q4`, and `Q4.eval` is *not*
known injective (deliberately — `Field/Quadratic.lean`'s docstring makes never needing injectivity
a design point). Two `Q4`-distinct class values that secretly evaluated to the same real would
merge two classes into one real class, and separating each part with *different* colourings does
not separate the union. The repair is not an injectivity theorem (linear independence of the
sixteen radicals — real mathematics, unbudgeted); it is **interval separation of these 1,340
concrete literals**: sort by numeric value, and kernel-check `hi(i) < lo(i+1)` for 1,339 adjacent
pairs from rational bounds on the generators whose correctness is `l² < d < h²` — a decidable
integer fact. Distinct intervals ⇒ distinct reals, for exactly the values in hand, which is all the
headline consumes.

This is the milestone's instrument: **`Q4` values compared as real numbers, in the kernel**. Rung D
will want it again every time a candidate's geometry has to be read (which distances exist, which
classes are which) rather than checked against a fixed target.

## 1. The deliverable

1. **The certified negative, one theorem per pivot** (names final at implementation):

   ```
   theorem deGrey_no_narrow_fan_630 :
       ∀ (r : ℝ) (Q : List (Fin 1581)), (630 : Fin 1581) ∉ Q →
         (∀ q ∈ Q, dist (deGrey.point q) (deGrey.point 630) = r) →
         ¬ Fan (edgeGraph 1581 deGrey.edges) 5 630 Q
   ```

   on axioms exactly `[propext, Classical.choice, Quot.sound]`. Read aloud: *no list of vertices,
   not containing the pivot, all at one real distance from it, carries a five-colour fan.* The
   `p ∉ Q` hypothesis is forced by `Fan`'s deliberate adversarial member (`Fan G k p [p]` is
   trivially true — Fan.lean § negative controls).

2. **`Field/Approx.lean`** — the interval instrument: rational (or dyadic-integer; § 3) interval
   arithmetic, sound bounds for `Q4.eval` of literals from checked generator bounds, and a
   list-separation checker whose soundness theorem yields pairwise-distinct reals.

3. **`tools/narrow.py`** — the sweep as a committed, controlled tool: pool-of-colourings bulk
   rejection, solver only on pool survivors, the stub's § 3–4 triage discipline (`DEFERRED` never
   folded, unconditional deferred-count line), and the known-hit + injected-oracle controls.

4. **`tools/emit_narrow.py`** — emits the per-pivot certificate data: class table, sorted class
   values, generator bounds, packed colourings, per-class colouring hints.

5. **The honest report** — including that the stub's central question is answered *no* for all
   four known fans, and the M17 stub (where a narrow fan could come from, given that interrogating
   the existing witnesses is now exhausted).

## 2. The certificate's shape

Per pivot `p`, emitted untrusted and checked by the kernel:

| datum | size | checked by |
|---|---|---|
| `classId : v ↦ Fin 1340` (packed) | 1,580 entries | (i) `distSq (verts v) (verts p) = classVal[classId v]` for every `v ≠ p` — ties every vertex to its class value; **the expensive check**, ~1,580 tower `distSq`s ≈ 70 s/pivot at M04's rate |
| `classVal : List Q4` | 1,340 literals, sorted by real value | (ii) interval separation: adjacent values have disjoint intervals ⇒ pairwise distinct reals |
| `colourings : List ℕ` (3 bits/vertex, packed) | ~8 per pivot | (iii) each proper on all 7,877 edges |
| `hint : Fin 1340 → colouring index` (packed) | 1,340 entries | (iv) for every `v ≠ p`: colouring `hint[classId v]` gives `v` a colour ≠ its colour at `p` |

Soundness (the bridge theorem, once, generic): checks (i)–(iv) true ⇒ the headline. Proof sketch:
`Q` empty — any committed colouring refutes `Fan _ _ _ []`. `Q` nonempty — pick `q₀ ∈ Q`; for any
`q ∈ Q`, `dist q p = dist q₀ p` pushes through `eval_distSq` (M02's bridge) to
`eval (classVal[classId q]) = eval (classVal[classId q₀])`, and (ii) forces
`classId q = classId q₀`; then colouring `hint[classId q₀]` separates every member of `Q` by (iv)
and is proper by (iii), so it witnesses `¬ Fan` directly from the definition.

The reals appear only in the once-proved bridge; every per-vertex and per-class obligation is a
closed `Bool` the kernel decides. This is M05/M15's arrangement, at a fraction of M15's size
(≈ 32 colourings against 1,063).

## 3. Decisions settled by measurement here

* **All 1,340 classes are in the headline, not only the 7 spindle-able ones.** The sweep costs the
  same (the pool rejects the tail), the statement quantifies over every real distance with no
  vocabulary about spindles, and the read-aloud form needs no caveat. Alternative — restricting to
  rational classes — was the cheaper-looking option before the pool measurement and saves nothing
  after it.
* **All four pivots are certified directly.** The rotation relating 630→1420 is not an
  automorphism of the graph (M11: no witness has one), so `Fan.map` cannot transport the negative;
  4 × the certificate is ~5 min of kernel time and zero new machinery.
* **Interval separation instead of `eval`-injectivity.** Injectivity of `Q4.eval` is the linear
  independence of sixteen radicals over ℚ — true, classical, and a milestone of its own to
  formalize (nothing in Mathlib was found for multiquadratic towers; `Nat.Prime.irrational_sqrt`
  covers one level). The certificate needs distinctness of 1,340 *concrete* values, which intervals
  decide with integer arithmetic. Confidence high; the one fact that would change it is Mathlib
  shipping multiquadratic independence, at which point `Approx` stays useful for rung D's geometry
  reading regardless.
* **Interval endpoints are integers over an explicit scale, not rationals — measured, 6.3×.**
  The ℚ carrier costs **107 s per pivot** on the real workload (1,340 approximations through
  2⁴⁰-denominator bounds; min of three runs 107.2 s), all of it `Rat` normalization through the
  kernel-unaccelerated `Nat.gcd` — M02's finding paid a second time. The ℤ carrier runs the same
  workload in **16.9 s including the probe file's own elaboration**. The scale is an *argument of
  the `Mem` relation* (`Ival.Mem I s x` reads `lo ≤ x·s ≤ hi`), never an index of the type:
  `ofInt` speaks at denominator 1, `add` at a shared denominator, `mul` multiplies denominators,
  and the four-level tower lands at `scale⁴` with no division, no rounding lemma, and no gcd
  anywhere. Alternative rejected: a fixed global scale with rounding division at each `mul` —
  it needs two rounding lemmas and buys nothing the fixed tower depth doesn't already give.
* **Class values are zig-zag-packed `Nat`s, one per class, decoded by `unpackQ4`** — not
  `List Q4` literals. M02 measured a module of ~3,000 sixteen-component tower literals at 28 s /
  3.9 GB to elaborate; packed numerals make the instance module's elaboration trivial (M04's
  rule: a `Nat` literal costs ~2.3 KB of olean, a literal tree ~145 bytes *per node*), and the
  decoder is five lines with **no soundness obligation** — the decoded value simply *is* the value
  every check and every proof mentions. The kernel decodes a class value in ~50 flat operations
  against the ~670-cons average walk that a `List Q4` lookup already costs, so the packing is
  cheaper on both sides of the elaborator/kernel line.
* **`hint` is per-class, not per-vertex.** A per-vertex hint would let two same-class vertices cite
  different colourings, which un-proves exactly the union step the headline needs. The per-class
  shape makes the mistake unrepresentable.
* **The per-vertex walk is `(List.finRange n).all`, kept after checking the definition.**
  `List.finRange = List.ofFn = Fin.foldr` in core — a linear list build with no `Array` behind it,
  so the kernel walks it once. The grouped-by-class layout (per class, a member list) was weighed
  and rejected: it would need a "members form a permutation of the non-pivot vertices"
  completeness check that the per-vertex walk gets by construction — a vertex cannot escape its
  obligation when the walk visits every vertex.
* **Degenerate members audited at the definition** (the unsampled-member sweep): extra unused
  classes in `classVals` only strengthen `sepChain`'s obligation — sound slack; duplicate class
  values are refused by `sepChain` itself; `k = 0` is excluded by `sound`'s `0 < k` exactly as
  M03 does; a `scale` of 0 makes `sepIvals` unsatisfiable against `Mem` (both intervals would
  have to contain 0), so no positivity side condition is carried anywhere; and the `n = 1`
  no-partners certificate is *sound and useful* — it reduces the headline to colourability, which
  is why `check` demands a nonempty colouring list (a control pins it).

## 3.5 The obligations, decomposed (obligation pass, 2026-08-02)

Every leaf was derived against the real imports before being written down; the citations below
were found by grep, not recalled. Two statement changes came out of the pass:

* **`IsChain` leaves the surface.** Batteries' `isChain_iff_pairwise` demands `[Trans R R R]`,
  which a bare lambda never carries, and both consumers want `Pairwise` anyway. The public lemma
  is `pairwise_lt_of_sepChain : l.Pairwise (eval · < eval ·)` — transitivity folded in once, via a
  `haveI : Trans _ _ _` local instance inside the proof, never at a consumer.
* **`eval_lt_of_hi_lt_lo` is stated as the named bridge** — the *one* place interval data touches
  ℝ's order. Its own derivation settles the scale-0 question: at denominator 0 both membership
  facts force both intervals to contain 0, contradicting disjointness, so the lemma carries no
  positivity hypothesis and the case split (`Nat.eq_zero_or_pos`) is internal.

The leaf table — each obligation, its derivation shape, and the citation that closes it:

| leaf | shape | closes by |
|---|---|---|
| `mem_ofInt`, `Mem.add`, `Mem.scaleUp` | unfold + one monotonicity step | `push_cast`, `mul_le_mul_of_nonneg_right`, `add_le_add` |
| `Mem.mul` | the corner bash, isolated in a private ℝ-lemma `A ≤ a → a ≤ B → C ≤ b → b ≤ D → min₄ ≤ ab ∧ ab ≤ max₄` | `rcases le_total 0 b` then sign of the active endpoint; each of ~6 leaves one `mul_le_mul` variant or `nlinarith`. Grepped: Mathlib has no `Icc`-product-bounds lemma to cite |
| `mem_sqrt` | rewrite `√d·s = √(d·s²)` then square both comparisons | `Real.sqrt_mul'`, `Real.sqrt_sq`, `Real.le_sqrt`, `Real.sqrt_le_iff` (all present, checked) |
| `Adjoin.mem_approx` | `eval ⟨a,b⟩ = eb a + eb b·r` (a `rfl`-lemma stated privately) then `Mem.add`/`Mem.scaleUp`/`Mem.mul` | 3 lines |
| `Q4.mem_approx` | unfold both four-level nestings, apply the level lemma four times; fix the scale `1·s·s·s·s = s⁴` by `ring` on ℕ | ~8 lines |
| `pairwise_lt_of_sepChain` | induction mirroring `sepIvals`'s own recursion, `eval_lt_of_hi_lt_lo` at each step, `isChain_iff_pairwise` (Batteries) under a local `Trans` instance | |
| `pairwise_ne_of_sepChain` | `.imp ne_of_lt` | 1 line |
| `index_eq_of_eval_eq` | `by_contra` + `lt_or_gt_of_ne`, `List.pairwise_iff_getElem` (core `Init/Data/List/Nat/Pairwise.lean`), `List.getElem?_eq_some_iff` | ~8 lines |
| `exists_coloring_of_proper` | transcription of `colorable_delete_of_packed` minus the pivot cases; the colouring is `Coloring.mk` of the unpacked values with `Nat.mod_lt _ hk` | ~12 lines |
| `eval_distSq_eq_of_dist_eq` | `key : eval (q.distSq p) = normSq (q.toPlane D − p.toPlane D) · D²` by `eval_distSq` + `field_simp` + `ring`; then `dist → normSq` by `Complex.dist_eq` + `Complex.sq_abs` | ~12 lines |
| `NarrowCert.sound` | no induction anywhere: split `check` into its five conjuncts; `Q = []` is refuted by any committed colouring; `Q = q₀ :: _` pins `classId q = classId q₀` through `eval_distSq_eq_of_dist_eq` → `index_eq_of_eval_eq` (positions transported along `List.getElem?_map`), then the class's one colouring separates all of `Q` | ~35 lines of named `have`s; a private `checkVertex` destructuring lemma keeps the match plumbing out of the argument |

The per-vertex facts arrive from `(finRange n).all` via `List.all_eq_true` + `List.mem_finRange`
(core, checked). **No leaf needs an induction beyond the one list walk in
`pairwise_lt_of_sepChain`**, and no recursion needs a termination argument — `sepIvals` is
structural.

Prove / test / assume, partitioned: *proved* — everything above; *tested* — the 16 spec `#guard`s
plus the emitter-side controls of § 4 (data-shape facts a wrong emitter would break); *assumed* —
`0 < k` (M03's standing hypothesis, discharged by `decide` at every instance) and `D ≠ 0`
(discharged by `decide` from the committed denominator).

Mutation audit to run at the gate: drop `0 ≤ I.lo` from `sqrtOk` (mem_sqrt must fail — a negative
lower endpoint squares large for the wrong reason); drop the `!colourings.isEmpty` conjunct
(`sound`'s nil case must fail); swap `pairwise_lt`'s `<` for `≤` (index_eq must fail); state
`sound` without `pivot ∉ Q` (must fail on the adversarial `Fan G k p [p]`).

## 4. Negative controls (each to be watched red)

| control | goes red when |
|---|---|
| known-hit sweep control (committed in `narrow.py`) | the sweep loop stops being able to report a confined fan |
| injected never-answering oracle | a deferral is folded into a verdict, or a summary prints a verdict with work skipped |
| a colouring made improper (one edge endpoint recoloured) | check (iii) fails to catch it |
| a hint pointing at a colouring that does not separate its class | check (iv) fails to catch it |
| two adjacent `classVal` entries swapped | check (ii)'s sortedness/disjointness fails to catch it |
| a generator bound with `h² < d` | the bound check fails to catch it |
| `classId` binding a vertex to the wrong class value | check (i) fails to catch it |
| full-fan positive control at 630/633 | the fan encoding stops agreeing with M15's `k−1` encoding |

## 5. Cost projection

| item | projected | basis |
|---|---|---|
| kernel: check (i), 4 pivots | ~4.7 min | M04's 45 ms/`distSq` on this table |
| kernel: checks (ii)–(iv) | seconds | integer comparisons; interval ops are ~10² small-`Int`/`ℚ` ops per class value |
| elaboration of the instance data | small | ~1,340 `Q4` literals + ~32 packed `Nat`s per pivot ≈ single-module scale, no chunking expected |
| solver, whole sweep | < 2 s (done) | measured |
| positive controls | ~4 h background | M15's removability timings |

Chunking: not expected to be needed (the whole certificate is ~200× smaller than M15's); if check
(i) at 1,580 `distSq`s per module exceeds memory comfort, split per pivot — the natural seam.

## 6. Carry-forward (M17 stub, to be written at close)

The four known fans do not narrow, and the shrunk witnesses provably carry no fan at all. So no
existing witness yields the closing move's input, and the next question is **construction**: can a
configuration be *built* whose fan is confined to one spindle-able class — de Grey's own route ran
orbit → wide fan at one class (`r² = 4`) → spindle at that class → width-1 fan elsewhere, and the
known-hit control above is exactly that structure being detected. The open items: what makes his
397-point configuration's fan single-class when de Grey's *full graph's* fans are not (measure:
the four removable pivots are artifacts of the closing spindle, not orbit structure); and whether
orbit closures at five colours ever confine a fan (the first sweep of M17, over the M13 universes,
now costs seconds per configuration with the pool trick).
