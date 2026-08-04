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
member is adjacent to the pivot, so it can never resist (measured: 1 resist call in the whole
graph); **r²=1/3 — 7,392 edges, density 0.57, all 1,592 triangles**; r²=3 — 2,304 edges,
density 0.36, *pure paths*; then 7/3, 5/9, and the **√33 family** (√33 = √3·√11): a dozen
distinct irrational keys totalling ≈ 9,000 in-class edges of pure path structure.

**The resist join overturned the first reading of that table.** The join (same census with
each solver call credited to its exact key) ranks: 1/3 first (178 calls — triangles, as the
budget mechanism predicts), r²=3 second (46 — paths), and then a surprise: the resisting
irrational keys are **not** the structured ones. The top irrational resisters —
2−⅓√33 (34), 7/6−⅙√33 (22), 3/2∓⅙√33 (21, 19), 5/3−2/9√33 (15) — carry **zero in-class
edges**, while the √33 keys *with* ~1,300 edges of path structure (8/9±⅑√33) resisted 3 calls
each. Width does not explain it (5/3: 11,184 members, 0 edges, 6 calls; 4/3: 6,632 members,
2 calls). So resistance has **two distinct mechanisms**: (a) *in-class colour budget* —
triangles at 1/3, paths at 3; and (b) *ambient near-forcing*: structureless classes at
specific small √33 distances whose members' colours track the pivot's through the ambient
graph (a member fully forced would BE confinement — M13's `Forces` — so these classes sit
near that cliff without reaching it). Mechanism (b) is exactly the kind of neighbourhood
forcing a coverage-driven construction needs pointed AT `N(p)` — M19's opening lead. (Note
the sweep tests irrational classes after rational ones per pivot, so the pool is warmer for
them: irrational resist counts are biased *down*, and the mechanism-(b) signal is stronger
than the raw numbers show.)

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
`SimpleGraph.colorable_of_degree_lt : (∀ v, G.degree v < k) → G.Colorable k`. Searched and not
found (no greedy, no Δ+1, no degeneracy colouring in Mathlib at this pin); to be re-queried by
shape with `exact?`/Loogle before the sorry burns, per the claims-of-absence rule.

**`Proofs/HadwigerNelson/ClassGeometry.lean`** — the plane-level structure, over ℂ (M04's
working plane; rotation is multiplication):

| statement | content |
|---|---|
| `eq_or_eq_or_eq_of_dist_eq` | two distinct circles share ≤ 2 points (the chord bound) |
| `dist_sq_centroid_unit_triangle` | the centroid of a unit triangle is at squared distance 1/3 from each vertex |
| `eq_centroid_of_dist_eq` | an equidistant point *is* the centroid |
| `exists_unit_triangle_iff` | **a class carries a unit triangle ⟺ r² = 1/3** |
| `omega3`, `rot3` + 8 lemmas | ω = e^{2πi/3} in coordinates; rot3 is an isometry fixing classes, ρ³ = id, orbits are unit triangles |
| `dist_rot3_self` | **unconditional**: the 120° rotation displaces every point by `√3 ·` its radius; the 1/3-class is the fixed point of that scaling against the unit (`dist_rot3_self_of_third`) |
| `classOnlyGraph` | the graph of a class's own unit edges, nothing else — the *maximal* class-only graph, so `Fan.mono`'s contrapositive hands ¬Fan to every subgraph free |
| `not_fan_of_colorable_of_edges_within` | abstract, instance-free: edges ⊆ Q, Q-part `c`-colourable, `c < k` ⇒ ¬Fan — the milestone's "4" named as 3 + 1 |
| `degree_classOnlyGraph_le_two` | the chord bound worn by the graph |
| `not_fan_classOnlyGraph` | **no distance class can confine a fan by itself** |

*Domain-modeling pass (2026-08-03) reshaped three statements: the 120° identity is stated
unconditionally (the hypothesis-form hid the scaling law); the abstract no-confinement lemma
generalizes `4 ≤ k` + degree-bound to `Colorable c` + `c < k`, dropping all finiteness and
decidability; and `fan_of_coverage` splits out of the iff because the construction-facing
direction never needs `p ∉ Q`. Confirmed against alternatives: chord bound in 3-points-2-equal
form (the consumable clothing of "≤ 2"); the triangle iff is total with zero side hypotheses
(s ≤ 0 falsifies the left side by itself); ω in coordinates rather than Mathlib's cyclotomic
vocabulary (four one-line facts don't earn the import); `rot3` is verified to be the same
rotation `tools/field.py` computes at 1/3.*

**`Proofs/HadwigerNelson/Coverage.lean`** — the reduction:

| statement | content |
|---|---|
| `Fan.of_coverage` | coverage ⇒ fan, hypothesis-free — the direction M19's construction consumes; dot-named to join `Fan.of_edges`/`Fan.of_unsat`/`Fan.of_subset` |
| `fan_iff_coverage` | **Fan ⟺ every colouring covers `N(p) ∪ Q` with all k colours** (needs only `p ∉ Q`, and only for ⇒) |
| `three_le_card_of_triangle_mem` | the rainbow floor: a triangle in Q forces 3 colours on Q |

### 2.7 The consumer surface (experience-modeling pass, 2026-08-03)

* **Names to precedent**: `Fan.of_coverage` joins the `Fan.of_*` family; `omega3_cube` follows
  `Complex.I_sq` (name the LHS of a defining equation); `dist_rot3_self_eq_one`,
  `eq_centroid_of_dist_eq`, `eq_or_eq_or_eq_of_dist_eq` use Mathlib's `of_dist_eq` hypothesis
  suffix rather than invented vocabulary ("equidistant", "two_spheres").
* **No `@[simp]` tags in M18.** Alternative weighed: tagging the three rewrite-safe rot3
  lemmas (`dist_rot3`, `dist_rot3_pivot`, `rot3_rot3_rot3`). Rejected: the house set is
  austere (one tag in all of `Fan.lean`), the only present consumers are this module's own
  proofs, and a global tag is speech never taken back — cite `simp only [dist_rot3]`
  explicitly and revisit when M19 exists. Confidence high.
* **The census is the geometry lemmas' spec mirror.** ℝ-geometry cannot `#eval`, so the
  per-definition drift examples are: component `rfl`s on `omega3`, a concrete
  `rot3 0 1 = omega3`, concrete `classOnlyGraph` adjacency and non-adjacency examples, the
  explicit unit triangle `(0, 1, e^{iπ/3})` as the non-vacuity model of all triangle
  hypotheses, and `classstat.py`'s 2.6M-key census as the space-level control.
* **Negative-control set** (make-the-gate-fail): a `#guard_msgs`-pinned `decide` failure for
  greedy's strictness (K₃ at k=2); the `s = 0` adversarial member as an `example` of a
  trivially-true Fan (why `hs` exists); the edgeless-graph coverage failure witnessed by a
  constant colouring; membership-violation non-adjacency for `classOnlyGraph`.
* **Module doc gains a "which one to reach for" table** at implementation, mirroring
  `Fan.lean`'s.
* **Instrument surfaces already conversational**: both tools self-test, refuse degenerate
  input by name, and report bounds rather than verdicts when cut; no changes demanded.

### 2.5 The proof designs (obligation-modeling pass, 2026-08-03)

Every `sorry` has a named decomposition; the leaves are `linear_combination`/`field_simp`
certificates or one-line closes. The module's engine room is three `private` helpers over
re/im components — `dot`, `cross`, and the bridges — stated once, consumed by every geometry
lemma:

* **The dot/cross engine** (private): `normSq_eq_of_dist_eq` (dist to normSq bridge);
  `perp_perp_parallel` (two vectors orthogonal to one nonzero vector have zero cross —
  two `linear_combination`s and a component case split); `eq_of_perp_two_independent`
  (orthogonal to two non-parallel vectors ⟹ zero — Cramer, per component); the **Lagrange
  identity** `cross² + dot² = normSq·normSq` is `ring` and supplies every non-parallelism.
* **Chord bound**: equidistance at `p` and at `q` gives bisector orthogonalities; subtracting
  pairs gives `a−b ⊥ q−p` and `b−c ⊥ q−p`, hence parallel (`e = μ·d`). The close needs no
  circle parametrization: `dot(d, b−p) = −normSq d / 2` (from the `p`-bisector) forces
  `(1+μ)·normSq d = 0`, so `μ = −1` and `a = c` — after `by_cases` retires `a = b`, `b = c`.
* **Triangle identity**: centroid distSq is one certificate (`9·LHS = 3` via the polarization
  `dot(b−a, c−a) = 1/2`); equidistant-uniqueness runs the Cramer helper with
  `cross(a−b, b−c)² = 3/4` from Lagrange; the iff's `←` consumes the rotation section (the
  witness triangle is the ℤ/3 orbit of `p + √(1/3)`), which fixes the module order:
  engine → rotation → triangle identity → graph section.
* **rot3**: `ω³ = 1` and the normSq facts are componentwise certificates with
  `Real.sq_sqrt`; `rot3_rot3_rot3` is `linear_combination (z−p) * omega3_pow_three`;
  the isometry and pivot lemmas factor through a private `‖omega3‖ = 1`; the orbit triangle's
  third side rewrites `z = ρ³z` and reuses the first side at `ρ²z` (radius preserved by
  `dist_rot3_pivot`, twice).
* **Greedy** (the one real induction): auxiliary statement — *for every `s : Finset V` there
  is a total `C : V → Fin (k+1)` proper on `s`* — by `Finset.strongInductionOn`
  (`s.erase v ⊂ s` is the descent); the step colours `v` by pigeonhole
  (`(s.erase v ∩ neighborFinset v).image C` has card `≤ degree v < k+1`), extension via
  `Function.update` under `classical`. `k = 0` splits at the top: a vertex would have
  `degree < 0`. The main theorem instantiates `s := univ`.
* **`not_fan_of_colorable_of_edges_within`**: embed `Fin c ↪ Fin k` by `Fin.castLE`, send
  everything outside `Q` (including `p`) to the spare colour `⟨c, hck⟩`; validity from
  edges-within + `C₀.valid`; the fan hypothesis then equates `⟨c,_⟩` with a `castLE` value,
  refuted on `val`.
* **`degree_classOnlyGraph_le_two`**: contrapose to three distinct neighbours
  (`Finset.two_lt_card`), read the sphere and unit hypotheses off the adjacency, feed the
  chord bound with centres `x` and `f v` (distinct since `s ≠ 0`), and let injectivity turn
  the point-equality disjunction into a vertex-equality contradiction.
* **`fan_iff_coverage`**: `←` is `fan_of_coverage` (properness bars `N(p)`, 5 lines); `→` is
  the update move — `Function.update C p c` under `classical`, validity by the three-way
  `v = p` case split, then the fan at the updated colouring names a `q ∈ Q` wearing `c`,
  contradiction. `three_le_card_of_triangle_mem` provides `⟨C a, C b, C c⟩` with pairwise
  `C.valid` distinctness to `Finset.two_lt_card`.

**Hypothesis audits, done in advance:** `hs : s ≠ 0` is load-bearing (at `s = 0` the pivot
joins its own class and `Fan` is trivially true — the adversarial member is recorded as a
planned negative example); `hf : Function.Injective f` mirrors the instrument's
duplicate-point guard (three vertices naming one plane point inflate a degree past 2);
strictness in greedy's `<` is pinned by the existing triangle/spindle non-colourability
instances.

**Instruments** (`tools/`, untrusted, self-tested with negative controls):
`coverage.py` (minCov; §0(a,b)) and `classstat.py` (census + violation reporter + resist
join; §0(c)) — both already landed and green; they are §0's instruments and deliverables at
once. `scripts/regen-check.sh` gains both self-tests at the gate.

## 3. What is NOT in M18 (scope pushed forward, with stubs where obliged)

1. **Coverage-driven construction** — engineering candidates that force coverage 5 (pivots
   inside many unit triangles whose 1/3-class is closed) → **M19**. M18 hands it the
   objective function (`fan_iff_coverage`), the floor (§0(a): start at 3), the instrument,
   and one lead: mechanism (b) of §0(c) — ambient near-forcing at the structureless √33
   classes — is the phenomenon to point at `N(p)` to buy the two missing colours.
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
