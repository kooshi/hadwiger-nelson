# M18 — The 120° class

*Subplanned 2026-08-03 from the 2026-08-02 stub. Direction set by Kooshi: the project is
exclusively a hunt for new mathematics, however small, ratcheting toward major findings — and
M18 is the first milestone whose objective is structure nobody has named.*

**The milestone in one line:** turn M17's resisting histogram into named, kernel-checked
structure — the chord bound, the triangle identity, the 120° closure, "no class confines
alone", and the coverage⟺fan reduction — and stand up the instrument (`minCov`) that measures
distance-to-confinement instead of a binary verdict.

## 0. Measurements (before specifying — all on the desktop, 2026-08-03)

### 0(a) The headline: the closures' coverage gap is maximal, not marginal

`minCov(p, C) :=` the minimum over proper 5-colourings of how many colours land on
`N(p) ∪ C`. By the coverage⟺fan reduction (§2, `Coverage.lean`), `minCov = 5` *is*
confinement; the instrument is `tools/coverage.py` (colour-symmetric forbidding: one SAT call
per level, every upper bound witnessed by a re-checked colouring, budget cuts reported as
bounds, never folded).

| candidate | pivot | class | `minCov` | reading |
|---|---|---|---|---|
| `Z3-closure-dg630x1/3` (4,678 pts) | 630 | r²=1/3, closed, 9 members | **3 of 5** | the rainbow floor, exactly |
| `Z3-closure-dg633x1/3` (4,678 pts) | 633 | r²=1/3, closed, 9 members | **3 of 5** | the rainbow floor, exactly |

The ℤ/3 closures force *exactly* what their triangles guarantee and nothing more: some proper
colouring puts only the 3 triangle colours on all 21 vertices of `N(p) ∪ C`. The
neighbourhood contributes zero. Confinement is two full colours away, and both are owed by
`N(p)` — the constructive problem is now stated: **force two more colours onto a pivot's
unit-neighbourhood whose 1/3-class is closed.**

### 0(b) The distribution: the whole closure sits at or below the floor

All-pivots sweep of closure-630's 1/3-classes (4,615 pivots carry one; exact SAT walks at
every pivot the growing pool could not bound below 4): every walked pivot lands at
**`minCov ∈ {2, 3}`** — 3 where the pivot's class fragment contains a triangle, 2 where it
does not (measured 743 vs 102 in the first 845 walks; final histogram appended below when the
run lands). Nobody anywhere in the most triangle-rich graph in existence is even *one* colour
from confinement. Any coverage-driven construction starts from 3, not from 4.

### 0(c) The census: the three predictions hold, and the resisters get names

`tools/classstat.py` walks every pivot of a configuration and censuses the unit edges *inside*
each exact class key (degrees, components, cycle lengths, triangles), then checks three
predictions and exits nonzero on a violation — the lemmas' empirical mirror, run before the
kernel is asked to check them:

1. **max in-class degree ≤ 2** (the chord bound) — holds at every one of 556,876 keys of de
   Grey's graph and 2,055,477 of the closure;
2. **triangles only at r² = 1/3** — holds: 1,592 (de Grey) and 5,046 (closure) triangles,
   every one at 1/3;
3. **cycles only from the field's roots of unity** `{3,4,6,12}` — holds: observed cycle
   lengths are exactly `{3}` (at 1/3) and `{6}` (at r²=1, the order-6 angle), and **no
   pentagon class carries a unit edge**.

Structure table (de Grey, top keys by in-class edges): r²=1 — 8,520 edges, 6-cycles, but every
member is adjacent to the pivot, so it can never resist; **r²=1/3 — 7,392 edges, density
0.57, all 1,592 triangles**; r²=3 — 2,304 edges, density 0.36, *pure paths*; then 7/3, 5/9,
and the **√33 family** (√33 = √3·√11): a dozen distinct irrational keys (10/3±⅓√33, 8/9±⅑√33,
…) totalling ≈ 9,000 in-class edges of pure path structure — more than 1/3's total, spread
across many keys. M17's "irrationals resist second" bucket is now named: it is the √33 family,
and its mechanism (path structure constraining pool colourings) is the same as r²=3's, just
distributed. The resist-join run (`--resist`) lands the per-key resistance-vs-width
normalization; appended below when done.

### 0(d) The pentagon correction — caught before formalizing the wrong theorem

The stub's claim "1/3 is the only class that brings odd cycles at all" is **false at plane
level**: a class at r² = (5±√5)/10 closes into unit *pentagons* (order-5 rotation,
cos 72° = (√5−1)/4 ∈ ℚ(√5)). What saves uniqueness in every graph this workspace can build is
the *coordinate field*: sin 72° = √(10+2√5)/4 generates a cyclic quartic field, not a
multiquadratic one, so ℚ(√3,√5,√7,√11) cannot express the order-5 rotation — nor ζ₈ (needs
√2) — leaving `{3,4,6,12}` as the only closable cycle orders and **3 as the only odd one**.
Consequences: the plane-level Lean statement is the *triangle* identity (true unconditionally);
the odd-cycle-uniqueness claim is a theorem *about the field* (deferred, §5); and the census
checks pentagon keys explicitly so the exclusion is watched, not assumed.

### 0(e) Costs that shaped the plan

Per-level SAT call on a 4,678-pt closure: 0.2–1.5 s warm (pool-seeded); the full all-pivots
exact walk is ~1 hour — affordable once, not per candidate. Graph rebuild from recipe:
~2.5 min (Python `edges()`, O(n²) exact arithmetic). Census: ~1 min (de Grey), ~9 min
(closure). The Lean side has no kernel-scale data: every M18 lemma is elementary algebra
(`linear_combination` certificates) or small graph theory; no generated modules, no
certificates, no `decide` at scale.

## 1. Why this milestone exists — the evidence trail (from the stub, corrected by §0(d))

* **The 120° identity** (verified computationally 2026-08-02, now §0(c)-mirrored): the spindle
  rotation at r² turns by cos θ = (2r²−1)/2r²; at 1/3 that is −1/2 — exactly 120°, order 3.
  Doubling twice at one pivot closes a ℤ/3 orbit (1,581 → 3,138 → 4,678 → +0), and the closed
  class partitions into unit equilateral triangles.
* **The colour budget**: every proper colouring paints each triangle with 3 distinct colours,
  so a closed 1/3-class eats 3 of 5 colours; separation threads the 2-colour gap. That is
  what M17's 17,259 resisting calls look like from inside.
* **The single-class impossibility**: in-class unit edges are chords of one circle subtending
  a fixed angle ⇒ degree ≤ 2 ⇒ 3-colourable ⇒ no class confines alone. Confinement is an
  interplay theorem. (Now a Lean skeleton statement, not just an argument.)
* **The coverage reduction**: `p` is fanned by `C` iff every proper colouring puts all 5
  colours on `N(p) ∪ C` — the binary verdict becomes the `minCov` gradient. (Now stated as an
  iff; the recolouring direction is the proof's only content.)
* **r²=3 is NOT explained by the 120° story** (its angle is irrational, its structure pure
  paths); §0(c)'s census + resist join is the measurement obligation the stub demanded.
* Both ℤ/3 closures were swept at M17's close: fully separated. §0(a) now says *how*
  separated: at the rainbow floor exactly.

## 2. The deliverables and their skeleton (elaborates green, `sorry` at every leaf)

Three new modules, all leaves (nothing imports them; no certificate rebuild exposure):

**`Proofs/HadwigerNelson/Greedy.lean`** — the missing Mathlib lemma:
`SimpleGraph.colorable_of_degreeLT : (∀ v, G.degree v < k) → G.Colorable k`. Searched and not
found (no greedy, no Δ+1, no degeneracy colouring in Mathlib at this pin); to be re-queried by
shape with `exact?`/Loogle before the sorry burns, per the claims-of-absence rule.

**`Proofs/HadwigerNelson/ClassGeometry.lean`** — the plane-level structure, over ℂ (M04's
working plane; rotation is multiplication):

| statement | content |
|---|---|
| `eq_or_eq_or_eq_of_two_spheres` | two distinct circles share ≤ 2 points (the chord bound) |
| `distSq_centroid_unit_triangle` | the centroid of a unit triangle is at squared distance 1/3 from each vertex |
| `eq_centroid_of_equidistant_unit_triangle` | an equidistant point *is* the centroid |
| `exists_unit_triangle_iff` | **a class carries a unit triangle ⟺ r² = 1/3** |
| `omega3`, `rot3` + 7 lemmas | ω = e^{2πi/3} in coordinates; rot3 is an isometry fixing classes, ρ³ = id, moves the 1/3-class exactly 1, orbits are unit triangles |
| `classOnlyGraph` | the graph of a class's own unit edges, nothing else |
| `not_fan_of_edges_within` | abstract: edges ⊆ Q, degrees < 3, k ≥ 4 ⇒ ¬Fan |
| `degree_classOnlyGraph_le_two` | the chord bound worn by the graph |
| `not_fan_classOnlyGraph` | **no distance class can confine a fan by itself** |

**`Proofs/HadwigerNelson/Coverage.lean`** — the reduction:

| statement | content |
|---|---|
| `fan_iff_coverage` | **Fan ⟺ every colouring covers `N(p) ∪ Q` with all k colours** (needs only `p ∉ Q`) |
| `three_le_card_of_triangle_mem` | the rainbow floor: a triangle in Q forces 3 colours on Q |

**Instruments** (`tools/`, untrusted, self-tested with negative controls):
`coverage.py` (minCov; §0(a,b)) and `classstat.py` (census + violation reporter + resist
join; §0(c)) — both already landed and green; they are §0's instruments and deliverables at
once. `scripts/regen-check.sh` gains both self-tests at the gate.

## 3. What is NOT in M18 (scope pushed forward, with stubs where obliged)

1. **Coverage-driven construction** — engineering candidates that force coverage 5 (pivots
   inside many unit triangles whose 1/3-class is closed) → **M19**. M18 hands it the
   objective function (`fan_iff_coverage`), the floor (§0(a): start at 3), and the instrument.
2. **The field-exclusion theorem** (only-triangles-in-Q4: sin 72° ∉ Q4, sin 45° ∉ Q4 via
   norm arguments in the multiquadratic tower) — real mathematics, deferred until a milestone
   needs it as more than commentary; the census watches it empirically meanwhile.
3. **Kernel-certifying any concrete coverage reading** — `minCov = 5`, if ever observed, goes
   through M16's `Fan.of_unsat` route in its own milestone. M18 certifies *statements*, not
   instances.

## 4. Gate additions (beyond the standard: build green, zero sorry, axioms clean, lint silent)

* `coverage.py --self-test` and `classstat.py --self-test` wired into `regen-check.sh`;
* the census run on de Grey's graph must exit zero (the three predictions are the lemmas'
  empirical mirror — a violation fails the gate);
* every ClassGeometry lemma gets its misuse/negative control (a `#guard_msgs`-pinned failure
  or a decide-refuted variant) per "make the gate fail";
* `#print axioms` on the three new modules: exactly `[propext, Classical.choice, Quot.sound]`
  (no `Decidable` machinery here should tempt a `native_decide`; zero purchases).

## 5. Operational rules in force (unchanged, recorded in CLAUDE.md)

All builds through `scripts/build.sh`; on any segfault halt and report; one heavy job at a
time; `lean4checker` replays deferred indefinitely (publication gate, other hardware);
`tools/` untrusted throughout.

---

*Appendix (§0 completions, to land before the gate): final all-pivots histogram for
closure-630; the resist join table for de Grey; closure-633 census if the numbers above shift
any conclusion.*
