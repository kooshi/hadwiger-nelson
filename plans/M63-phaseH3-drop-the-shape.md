> **SUPERSEDED 2026-09-12 — RUN AND CLOSED. The object is dead and so is the direction.** The shape-free
> `n = 2` arena is **four-colourable at every radius, by derivation**, and dropping the shape reaches only
> members that a single base-free screen kills. **Read `plans/M63-phaseH3-plan.md` for the verdict and the
> six family-level results that survive; read this file only for the brief as it was written.** Its §2 table
> is wrong in the flattering direction on two rows: the doublings it credits to `n = 2` belong to dropping
> the shape (the unit shell does not depend on `n` at all), and "7.1× smaller in arena radius" is 2.67× in
> radius — 7.1 is its square. Per WORKFLOW: deprecate, never delete.

# Phase H3 stub — drop the shape: a 6-open arena at squared radius 2

*Written 2026-09-12 at phase H2's close, under WORKFLOW's stub rule: full mission context in plain
language, everything the deciding session knew, written so a fresh session with zero conversation memory
can subplan it with all meaning intact. **Not started.** Kooshi has not authorised it; it is ranked and
specified so he can.*

---

## §1 — The mission, in one paragraph

Every five-colour graph of this kind is a **lattice** plus a **rotated copy** sharing one centre, joined by
edges between points exactly one unit apart. Phase H2 established that the usable rotations are a
**classified one-integer family** — `cos θ = (2n−1)/(2n)`, which *is* the classical spindle construction at
distance `√n` — and built a verified five-chromatic object at `n = 16` in a field the five-colour sieve does
not seal. It also established, by arithmetic rather than search, that **the thing limiting every one of
these objects is not the lattice's fineness, its radius, or its field, but two coordinate-slot conditions
inherited from `[Parts2020a]`** — his *shape*: `p₁ ∈ ℚ(√33)` and `p₂ ∈ √3·ℚ ⊕ √11·ℚ`. **This phase drops
the shape at the cheapest 6-open member, `n = 2`.** If it works, the object is **7.1× smaller in arena
radius** than phase H2's and sits in the same unsealed field.

---

## §2 — The target, exactly

**Rotation:** `ρ₂ = (3 + i√7)/4`, i.e. `cos θ = 3/4`, `sin θ = √7/4`. Diagonal circle at `|p|² = 2`.
Radicand `4n − 1 = 7`. Field `K(√7) = ℚ(√3,√7,√11)` — **6-open** (G43; residue degree 2 at 11, confirmed
by direct computation in phase H2 §6m).

**Endpoint bound** (no cross edge exists outside it, proved): `1/|sin θ| = 2n/√(4n−1) = 4/√7 = **1.5119**`,
against the 509-vertex record's `8/√15 = 2.0656` and phase H2's `32/√63 = 4.0316`.

| | `n = 2` (this phase) | `n = 4` (the record) | `n = 16` (phase H2, verified χ ≥ 5) |
|---|---|---|---|
| arena radius | **1.5119** | 2.0656 | 4.0316 |
| circle points, Parts's shape | **0** | 30 | 30 |
| circle points, **shape dropped** | **60** | 60 | 60 |
| unit vectors available | **60** | 30 | 30 |
| field | `K(√7)`, **6-open** | `K(√15)`, 5-sealed | `K(√7)`, **6-open** |

**So the arithmetic offers twice the record's circle count and twice its unit-neighbour count, in an
unsealed field, at 73% of its radius.** All sixty solutions at `n = 2` are classified into five coordinate
patterns and **not one has Parts's shape** — which is why his lattice scores 0 rather than merely low. One
of the sixty is `p = (1,1)`, at denominator **1**, excluded for the single reason that `1 ∉ √3·ℚ ⊕ √11·ℚ`.

---

## §3 — What is proved, what is inherited, what is unknown

**PROVED and safe to build on** (phase H2; addresses in §5):
- The rotation family is a **classification**: `1/(2 − 2cos θ)` is a rational integer `n` **iff**
  `cos θ = (2n−1)/(2n)`. Nothing outside the family has an integer diagonal radius.
- **It is the spindle construction.** `2d²(1 − cos θ) = 1` with `n = d²` gives the same equation, and the
  adjoined radicand `√(4d² − 1) = √(4n−1)` is the family's. `n = 3` is the Moser twist, `n = 4` is `ρ₁₅`.
- **The endpoint bound** `1/|sin θ|` — verified to return the record's own recorded `8/√15` at `n = 4`,
  which is a **free positive control on any re-derivation.** Material past it adds points and no cross edge.
- **`sin θ ∉ K`** must hold or the whole arena lies in `K²` and `chromaticNumber_seamPlane` (kernel-checked,
  `χ(K²) = 4`) four-colours **every** base. At `n = 2`, `√7 ∉ K`. Screen this first on anything.
- **Wall-breaking is exactly `n` even**, with no per-member check: `4n−1` is odd so its squarefree part is
  `≡ 3 (mod 8)` for odd `n` and `≡ 7 (mod 8)` for even `n`, and the class `≡ 5 (mod 8)` never occurs here.
- **The arithmetic count is exact and cheap**, and it reproduced all six measured counts under the shape
  constraint and gave the ceiling without it. `h(K) = h(K(i)) = 1`, roots of unity `⟨ζ₁₂⟩` (pari).

**INHERITED — measurements on one object, not requirements. Treating them as rules is what cost phase H2 a
day:**
- **Parts's SHAPE.** Two coordinate-slot conditions. **This phase exists to drop them.** They are not a
  theorem about anything; they are how his lattice happens to be written.
- **"Two kinds of cross edge are needed."** The evidence is one object's measurement plus his prose. The
  product owner proposed the sharper "one kind that is not a matching" and the advisor **refuted its
  load-bearing step**: a perfect matching between two four-colourable graphs *can* force. What survives is
  a conditional theorem (phase H2 §6b), not a requirement.
- **His two congruences.** Measured to cost **nothing** on every shell tested, and `tools/typem.py`'s
  docstring claims they give group-closure by construction — **but that is the code's claim, not a
  measurement.** §6 below makes verifying it the cheap first step.

**UNKNOWN, and this is the whole risk:**
- **Whether a shape-free set attaining 60 can also be group-closed, finite under an exact disk cut, and
  joined by the cross-edge law.** The arithmetic counts points on a circle and knows none of that.
- **The disk cut changes concretely.** Parts's `|p|²` always lands in `ℚ(√33)`, which is why his cut has
  **two** conjugate conditions; a shape-free module has **four**. Budget for that, and expect the point
  count at a given radius to differ from any figure quoted for his lattice.
- **Whether the resulting arena refuses four colours.** Phase H2's `n = 16` did, but its refusal came
  through 36 off-diagonal cross edges, and nothing says `n = 2` has any.

---

## §4 — The traps, each one already paid for once

1. **A statistic on an unrepresentative subpopulation, read as a property of the whole.** This fired
   **four** times in phase H2 — a false "exactly 10" invariant from twelve reseeded samples of one
   colouring; a contention factor from two non-comparable cube ranges; a hardness prediction from a partial
   census in which the easiest case happened to have finished; and an "equality exactly when `4 | m`"
   attributed to a run nobody had read. **The instrument that catches it is not care: it is keeping a
   PREDICTED quantity beside the measured one and reconciling them whenever they disagree.**
2. **A control that would have passed.** The arithmetic instrument's fast enumerator packed four
   coordinates into a 64-bit word needing 88 bits, silently collapsing values. It made counts **too
   large** — which for a *ceiling* reads as conservative and **would have passed the domination check
   against all six measured values.** Only a second, deliberately slow implementation caught it. **Write
   the naive enumerator.**
3. **A generator whose image excludes the target.** Three times in this milestone a decisive zero came from
   a search that could not represent what it was searching for, **with its positive control passing.**
   Before believing any zero, write down the generator's image and check the target is inside it.
4. **`sin θ ∈ K` unscreened.** Four members of the family die free to a kernel theorem. One square test.
5. **A refusal is the suspect verdict**, because cross edges come from a law and an invented edge makes a
   refusal arrive faster and cheaper. In phase H2 the exposure was bounded by showing that **no single one
   of the 36 off-diagonal constraints was load-bearing**; do the equivalent here rather than flagging it.

---

## §5 — Read these, in this order

| file | what it is |
|---|---|
| **this stub** | the mission — read whole, first |
| `plans/M63-phaseH2-the-family.md` | phase H2's full record. **§6l is this phase's justification** (the shape is the obstruction), §3/§3a the classification and the spindle identity, §5/§5a the screened family, §6k the verdict, §6b the conditional theorem, §7 the controls |
| `plans/M63-phaseH2-arithmetic.md` | the arithmetic instrument: the ceiling, the shape count, the corrected 2-adic law, the `n = 2` classification into five coordinate patterns, and the enumerators |
| `plans/M63-phaseH2-solver.md` | how the `n = 16` verdict was reached — the interface reduction, the 19-pattern rigidity, the 20-claim trust core. **The method transfers directly** |
| `plans/POROS-2026-09-12-m63-phaseH2.md` | the advisor's ledger, PH2-1…PH2-13 |
| `build/m63-phaseH2-artifacts/` | the evidence, on disk, with its own README. **Not scratch — do not clean it** |
| `CLAUDE.md` ledger row 64, G52, G53, G7 | the results in current-state form |

---

## §6 — The cheapest first steps, ordered by information per minute

1. **Verify Parts's two congruences are the `ζ₆`-closure conditions** — measured to cost nothing, but
   asserted only by a docstring. **If they are, only the shape has to be given up**, which is a far smaller
   change than dropping both. This is the cheap version of the whole phase and it is unrun.
2. **Reproduce 30 on `|p|² = 4` in his lattice with your own machinery**, and the endpoint bound `8/√15 =
   2.0656` at `n = 4`. Both are known answers; if either fails, nothing downstream is believable.
3. **Build the shape-free denominator-12 module inside radius 1.5119** under the *four*-conjugate cut, and
   count: total points, the norm-1 shell, and the `|p|² = 2` shell. **Predict all three from the arithmetic
   before looking**, and reconcile.
4. **Enumerate every cross-edge kind at `cos θ = 3/4`** — diagonal and not — with the law as a parameter and
   a second independent derivation of every edge. Phase H2's two implementations agreed 126/126 with 0
   invented; match that standard.
5. **Only then** ask a solver, and use phase H2's reduction rather than the monolithic arena: one half alone
   four-coloured in **0.35 s** where the whole object had spent 766 s and produced nothing.

---

## §7 — Acceptance

- The prior-art gate is **not** re-run from scratch: phase H2's is complete and its verdict stands — the
  angle family is `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice, he builds at other rotations for **odd**
  distances, and **what is ours is the characterisation, the field screen, and unit distance.** But **if
  this phase drops the shape, that is new ground in a paper's terms and needs its own half-hour**, in the
  vocabulary of coincidence site modules and of representation by norm forms.
- Every experiment's prediction and cost registered before it runs, scored met / not met / not decided,
  **with both outcomes confirmed reachable.**
- Every control seen red before it is believed green, plants bounded on **both** sides.
- Every candidate states its **radius sums** with every verdict, so the criterion is inherited rather than
  re-derived.
- **No aggregate verdict.** Six agreeing rows and one disagreeing is seven facts, not a score.

**The two sentences to carry into every report:**
- **Un-eliminated is not alive.** Surviving a screen means one argument can no longer be made, nothing more.
- **Silence is not evidence.** The four-colour filter fires one way only.

**And one this phase adds:** **the result is the field, not the size.** Phase H2's object is 51,133
vertices against a 509-vertex record and is still the more valuable object, because its field is unsealed.
If `n = 2` works it will be smaller *and* unsealed — but if it is merely smaller, it is worth less.
