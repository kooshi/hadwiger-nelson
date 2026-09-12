# Phase H2's answer: the record is the cheapest live member of a classified one-integer family

*Product owner's ruling, 2026-09-12, with its evidence. Supersedes the target in
`plans/M63-phaseH2-find-the-base.md` §2. Every number below was produced today and every gate below is a
theorem this repository already owns. Read §1 and §5 if you read nothing else.*

---

## §1 — The ruling, in one paragraph

The phase was briefed to **find a new base** — a lattice putting about thirty points on one fixed circle,
because that count is the usable cross-edge count. **That target is dead three ways over** (§2), and what
replaced it does not need a new base at all. The rotations that admit this construction form a
**one-integer family** — a classification, not a selection — and the cheap members of it put their circle
on a **scaled copy of the lattice's own unit shell**, so the two requirements the phase was trading against
each other are the same requirement and are satisfied together, for free, **on `[Parts2020a]`'s own
lattice**. The record is the **unique cheapest live member**. The next live member needs the same lattice
grown to 1.69× the radius; the cheapest member whose field is **6-open** — the only known mechanism for
χ ≥ 6 — needs 1.95×, and is a rotation this repository already recorded independently.

---

## §2 — Why the briefed target died

Three independent findings, all from 2026-09-12, listed in the order that makes them read as one fact.

1. **The count is free, so it cannot be the difficulty.** The norm-one multiplier group that slides points
   around such a circle is **infinite**, so any number of circle points is achievable by construction in
   some finitely generated module — no search, no literature. (Poros, PH2-1. It also kills the product
   owner's hypothesis that an ideal-theoretic formula would *bound* the count: no bound exists, because the
   group is infinite. The multiple-of-6 prediction is confirmed and **trivial**, a free group action, and is
   really a multiple of **12** for a `ζ₁₂`-closed module, `ζ₁₂` being the roots of unity of `K(i)`.)
2. **The count is the one coordinate on which the good and bad circles AGREE.** Measured on one lattice:
   the record's circle has points of unit degree **30** and denominator **1**; the phase's circle, **1** and
   **42**. Both counts are unbounded. (The first figure was published as 14 and **retracted by its own
   author** on re-check — a double-counted tangency inside a truncating cut. 30 is the module's norm-1
   shell count, which §4 explains: it is not a coincidence that the corrected figure is exactly `|S|`. The
   contrast strengthens; both originally printed numbers were wrong.) A quantity two objects share cannot explain why one refuses four
   colours and the other does not. (Poros, PH2-2.)
3. **The diagonal cross-edge family is a perfect matching, and inside a large sufficient family its whole
   contribution saturates at four conditions** — "the colour permutation must move every colour occurring
   on the circle and fix the centre's" — **however many points the circle carries.** So the 9th through
   30th circle point add nothing there. (Poros, PH2-7, corrected by the planner to the weaker and correct
   form: this is *not* a bound on the count, it is a large sufficient family in which the count is nearly
   worthless, so whatever value the count has must come from outside it. The one refusal anyone holds *is*
   outside it, which is consistent and is evidence for neither side.)

And the price of the briefed target, priced from both ends by three agents independently (PH2-9):
**~30 circle points are free if unit-distance structure is abandoned; at Parts's coarseness the phase's
circle is capped at 18; and buying the missing factor costs 81× the arena at equal radius.** The brief
optimised a quantity that is free at one end of that trade and unaffordable at the other, and stated
neither end.

**The durable half of that card, which outlives this phase.** On a `ℤ`-module the unit-distance graph is
the Cayley graph with connector set `S = {v ∈ M : |v|² = 1}` (ledger row 56, `addCayleyMap`), so the
requirement everyone wrote down as unquantified — *"enough unit-distance structure"* — **is exactly the
norm-1 shell count `|S|`**: every module point has unit degree `|S|`, and `|S| = 0` is an edgeless base
however many circle points it holds. So the phase's two requirements were always **two shell counts of the
same module**, and §3 is the observation that one choice makes them the same shell.

---

## §3 — The classification

A **diagonal** cross edge joins a point to its own rotated image, and is a unit edge exactly when the
point's squared radius is `r² = 1/(2 − 2cos θ)`. Therefore:

> **`r²` is a rational integer `n` if and only if `cos θ = (2n−1)/(2n)`.**
>
> *Proof.* `r²` is rational iff `cos θ` is. Write `cos θ = c/d` reduced; then `r² = d/(2(d−c))`, and
> `r² = n` gives `d = 2n(d−c)`, so `c = d(2n−1)/(2n)`, and `gcd(c,d) = 1` forces `d = 2n`, `c = 2n−1`. ∎
>
> Confirmed independently by exhaustive search over every reduced `c/d` with `d < 400`: no other rational
> cosine puts the diagonal circle at integer squared radius.

So the candidate rotations are

```
ρ_n = ( (2n−1) + i·√(4n−1) ) / (2n) ,     diagonal circle |p|² = n ,     radicand 4n−1
```

> **PRIOR ART, and it must be stated before the family is (added 2026-09-12, after `[PartsOdd2022]` was
> read in full).** This family is **not new**. It is the `m₁ = m₂ = m`, `r = 1` slice of `[PartsOdd2022]`
> §3's published formula `ρ(r) = exp(i·arccos((m₁² + m₂² − r²)/(2m₁m₂)))`, which is the **law of cosines**
> on the two radii and the rotation edge, with the side condition `|m₁−m₂| < r < |m₁+m₂|` being the
> triangle inequality. At `m₁ = m₂ = m, r = 1` it gives `cos θ = (2m²−1)/(2m²)` — **exactly our gate-A
> subfamily `n = m²`**. He also **builds** a base joined to rotated copies at other rotations (his `G306`,
> a hexagonal core plus rotated rotors at `m₁ = m₂ = 8` with odd `r` in 1…15, whose `r = 1` case is our
> `n = 64`).
>
> **What is therefore ours, stated narrowly:** (i) the *characterisation* — that a rational integer
> diagonal radius forces **exactly** this family, an if-and-only-if he does not state; (ii) the **field
> screen** over it, gates B/C/D, which is where he stops (his only remark in that direction is that the
> parameters give *"a rich set of different options for embedding a graph into extensions of the field
> ℚ"*); and (iii) **unit distance**. His construction is an **odd-distance** graph over lengths {1,3,5,7},
> and type M is a unit-distance notion — so `[Parts2020a]` §4's *"working constructions of type M with
> other rotations are not known yet"* **stands unrefuted**, by his own two papers.
>
> **The consequence for how this phase is valued: the unworked ground is the FIELD, not the angle.** The
> reason to want `n = 16` was never that its angle is unused — that is now demonstrably in print — but
> that `√7` lands in a field this project's own sieve calls 6-open. Every ranking in §5 should be read
> that way.

- **`n = 4` is `ρ₁₅ = (7 + i√15)/8`, the 509-vertex record's own rotation.**
- **`n = 16` is `ρ₆₃ = (31 + 3i√7)/32`**, and `CLAUDE.md` G8 records `√ρ₆₃ = (3√7 + i)/8` as one of the
  generators closing all 67 of de Grey's edge-direction classes. Verified exactly:
  `((3√7 + i)/8)² = (31 + 3i√7)/32`. **One integer parameter reproduces two objects this repository
  recorded independently, years apart in its own history.**

**The endpoint bound generalises with it.** Collinearity forces `t² + s² − 2cos θ·t·s = 1`, positive
definite, so every cross-edge endpoint has radius at most `1/|sin θ| = 2n/√(4n−1)`. At `n = 4` that is
`8/√15 = 2.0656`, **exactly** the bound already recorded for the record — the derivation's positive
control. Growing the arena past it adds points and no cross edges.

---

## §4 — The free circle: why `n` should be a square

**Theorem (module closure).** If `n = k²` for some `k` that is a **multiplier of the module** `M` — that
is, `k·M ⊆ M`, which is automatic for `k ∈ ℤ` and **must be checked otherwise** — then
`k·S ⊆ {p ∈ M : |p|² = n}`, where `S` is the module's norm-1 shell.

*Corrected 2026-09-12: the first version said "for some `k ∈ K`", which is false. The planner found the
counterexample from the other side: at `n = 12`, `k = 2√3` is a square root in `K` but multiplying by it
**swaps Parts's two coordinate slots**, so 0 of his 30 unit vectors land inside. (His circle at `n = 12` is
nonetheless nonempty — `2·(norm-3 shell)` puts **42** points there — by the `k ∈ ℤ` form applied to `m = 3`.)
So the usable form of gate A is the integer one, and everything beyond it goes through §5a.* Hence the circle carries **at least `|S|` points**, and the unit
neighbours of `k·v` are `k·v + S` — all module points. So each circle point carries **unit degree `|S|`**
once the arena reaches radius `|k| + 1`.

**Measured on Parts's lattice** (rebuilt here, 3,433 points at radius 2.44, gate below):

| | |
|---|---|
| norm-1 shell `\|S\|` | **30** |
| the record's circle `\|p\|² = 4` | **30 points, and the set is EXACTLY `2·S`** — every point, no extras, no omissions |
| `m·S` for `m = 2, 3, 4, 6, 8` | 30 points each, every norm exactly `m²` |
| the phase's circle `α = (7+√33)/3` | **0 points — and `α` is not a square in `K`** |

**So the record's "30 circle points" are literally its doubled unit vectors.** Its cross-edge count equals
its unit-shell count *by identity*, not by coincidence, and the reason is that `4 = 2²`. The phase's angle
sits off that diagonal — `α` is not a square in `K` — which is precisely why its circle gave 8 points of
unit degree 1 rather than 30 of degree 30.

**Integer shells of Parts's lattice, exactly:** `|p|² = 1 → 30`, `2 → 0`, `3 → 42`, `4 → 30`, `5 → 60`,
`6 → 0`, `7 → 0`, `8 → 0`, `10 → 0`.

---

## §5 — The family, screened by four gates, each a theorem we already hold

| gate | test | the theorem |
|---|---|---|
| **A** | `n` is a square in `K` | §4 — the circle then contains `k·S`: ≥ 30 points at full unit degree, free |
| **B** | `sin θ ∉ K` | else the **whole arena** lies in `K²` and `chromaticNumber_seamPlane` (χ(K²) = 4, kernel-checked, ledger row 57) four-colours **every possible base**. No count can help |
| **C** | `4n−1`'s square class odd and ≡ 5, 7 (mod 8) | the 2-adic wall (G35, G37); else no fifth colour is possible at all |
| **D** | `11` inert, with C | the field is **6-open** (G43) — the only known mechanism for χ ≥ 6 |

```
   n  radius  endpt  4n-1  sqfree   A     B     C     D    verdict
   1   1.000  1.155     3      3   yes   NO    no    no    DEAD   arena inside K^2, chi = 4
   3   1.732  1.809    11     11   yes   NO    no    no    DEAD   arena inside K^2, chi = 4
   4   2.000  2.066    15     15   yes  yes   yes    no    LIVE, 5-sealed      <- rho_15, THE RECORD
   9   3.000  3.043    35     35   yes  yes    no    no    dead   wall intact
  11   3.317  3.355    43     43   yes  yes    no    no    dead   wall intact
  12   3.464  3.501    47     47   yes  yes   yes    no    LIVE, 5-sealed
  16   4.000  4.032    63      7   yes  yes   yes   yes    LIVE + 6-OPEN       <- rho_63, a G8 generator
  25   5.000  5.025    99     11   yes   NO    no    no    DEAD   arena inside K^2, chi = 4
  36   6.000  6.021   143    143   yes  yes   yes    no    LIVE, 5-sealed
  44   6.633  6.652   175      7   yes  yes   yes   yes    LIVE + 6-OPEN
  48   6.928  6.946   191    191   yes  yes   yes    no    LIVE, 5-sealed
  64   8.000  8.016   255    255   yes  yes   yes   yes    LIVE + 6-OPEN
 100  10.000 10.013   399    399   yes  yes   yes    no    LIVE, 5-sealed
 108  10.392 10.404   431    431   yes  yes   yes   yes    LIVE + 6-OPEN
 132  11.489 11.500   527    527   yes  yes   yes   yes    LIVE + 6-OPEN
```
*(rows failing gate A omitted from this table; see §6. Complete for `n ≤ 140`.)*

**One gate-D row is a guess, not a reading.** At `n = 36` the radicand is `143 = 11·13`, so 11 divides it
and **ramifies** — neither inert nor split — and G43's criterion (*wall broken ∧ 11 inert*) is **silent on
ramification**. The table marks it "not 6-open" because the screen tested `d % 11 ≠ 0`, which is a
convention and not a theorem. Whether a ramified 11 can give 6-openness is **open**, and the same question
will recur at every `n` whose radicand is divisible by 11. Flagged by Poros against its own table.

**Ranked by cost, cost being the arena radius the endpoint bound demands:**

| | `n` | arena radius | × the record | field |
|---|---|---|---|---|
| new 5-chromatic object | **4** | 2.066 | 1.00× | **the record itself** |
| | **12** | 3.501 | **1.69×** | `K(√47)`, 5-sealed |
| | 36 | 6.021 | 2.91× | `K(√143)`, 5-sealed |
| a rung toward χ ≥ 6 | **16** | 4.032 | **1.95×** | **`K(√7) = ℚ(√3,√7,√11)`, 6-open** — ≈25,000 base points, ≈50,000 arena vertices |
| | 44 | 6.652 | 3.22× | `K(√7)`, 6-open |
| | 64 | 8.016 | 3.88× | `K(√255)`, 6-open |

**The cost law, because getting it wrong changes the ruling.** Parts's lattice is a **rank-4** module cut
by a bound on all conjugates, so its point count grows like **`r⁴`**, not `r²` and not `r⁸`: 1,603 at
radius 2.0 and 3,433 at 2.44 fixes the exponent. So `n = 16` costs ≈25,000 base points and ≈50,000 arena
vertices — **affordable**. An `r⁸` estimate put it at 358,000 and had it filed as a later milestone; the
planner caught the exponent, and the ruling moved with the number.

**Three observations that are the phase's product.**

1. **The record is the cheapest live member — cheapest only, NOT unique.** Every smaller member dies, and
   the two that die below it — `n = 1` and `n = 3` — die by **Theorem B**, a theorem of ours. *Corrected
   2026-09-12: the first version of this line said "unique", which was a claim about all members made from
   a table filtered to gate-A rows. Gate A is sufficient, not necessary (§6), and the screening agent found
   `n = 20` 6-open with **60** circle points — twice the record's — via `2·(norm-5 shell)`. Verified. See
   §5a for the general gate and the real queue.* That is a small structural
   explanation of `[Parts2020a]` §4's *"working constructions of type M with other rotations are not known
   yet"*: at the cheap end there is nothing else to find.
2. **`n = 12` and `n = 16` need no new base.** They need Parts's own lattice grown to radius 3.50 and
   4.03, where gate A hands them 30 circle points at full unit degree for free. **The phase's briefed
   mission — find a new lattice — is obsolete for this route.**
3. **`n = 16`'s field is `ℚ(√3,√7,√11)`**, which is exactly the field this repository's own **FS-22** stub
   has been pointing at (*"Parts's four-colour construction with the Moser twist in place of his √5 step
   lands in ℚ(√3,√7,√11), a 6-open field"*, currently ranked 10th). Two independent routes arriving at one
   field is the reason to raise it.

---

## §5a — The general gate, and the real queue (added 2026-09-12, replacing §5's filter)

Gate A was a special case. **The general gate is: `n` lies in the value set of the module's norm form** —
exhaustively enumerable as a finite integer problem, with no radius to argue about, since a point of norm
`n` is automatically inside radius `√n`. On Parts's lattice, `|p|² = n` holds iff

```
P = ab + cd = 0        and        S = a² + 33b² + 3c² + 11d² = 144n
```

and gate A is the sub-case `n = k²·m` with `k ∈ ℤ` and `m` already in the value set: then
`k·(norm-m shell) ⊆ (norm-n shell)`, free. Verified for every `(k, m)` visible in the radius-2.44 cut.

**The queue: 6-open members with a NONEMPTY circle over Parts's own lattice, `n ≤ 120`**, shell count in
brackets — exhaustive over the integer problem above, not over a radius cut:

> **16 (30), 20 (60), 44 (30), 60 (84), 64 (30), 76 (60), 108 (66), 112 (60)**

Eight members, not two. **`n = 16` is still the cheapest** (endpoint bound 4.032 against `n = 20`'s 4.500),
so §1's ordering survives, but `n = 20` carries twice the circle points and its radicand **79** is one of
the four 6-open radicals `CLAUDE.md` G37 already names (*"7, 13, 79, 127, …"*). `n = 16`'s radicand is 7,
the **first** one named. Two members of this family land in two of the four fields the project had already
written down as 6-open, which is the strongest external check the family has.

**A measured 2-adic law, not proved:** `v₂(n)` odd ⟹ the shell is empty over Parts's lattice — all 30 such
`n ≤ 120` are empty, and every `n ≡ 2 (mod 4)` with it. That is what kills `n = 2, 6, 8, 10` and it is the
arithmetic reason the cheap end of the family has nothing on this base.

**The count has a closed formula, and it is prior art.** The prior-art gate located it in the
**quasicrystal** literature — coincidence site modules, `[BaakeGrimm2003]` — and verified it at six points
on this project's own field, where it reproduced our measured **30** and **18** out of sample. Two cautions
that came with it, both the gate's own corrections: the formula is **exact on the ring of integers and
false on a sub-order**, and *every base this milestone builds is a sub-order*, so it **over-promises** circle
points on exactly the objects being built — a candidate base must be **counted, never predicted**. And it
carries a class-number hypothesis for `ℚ(√3,√11,i)` that nobody has checked; the four numbers the gate hands
the mission are exhaustive measurements rather than formula predictions, so they stand regardless, but a
prediction for an uncounted module does not.

---

## §6 — Scope, honestly: what this does NOT say

- **Gate A is sufficient, not necessary.** `n = 5` is not a square in `K` and yet Parts's lattice has
  **60** points at `|p|² = 5`. So members off gate A are **not** eliminated by §4 — they are merely
  denied the free circle, and must buy circle count and unit attachment separately, which is PH2-9's 81×
  factor. The original mission's shape survives *for them*, now with a reason it is expensive.
- **`n = 2`: the obstruction is THINNESS, and it is measured.** Corrected from the product owner's first
  guess, which was wrong twice over. The shell *inside* Parts's lattice is empty — 0 of 3,433 — but the
  circle is far from empty in the field, and it is **better material than the phase's own angle**:
  `2 = 1² + 1²`, so `(1,1)` sits on it at denominator **1**, and **180** points of that circle have a
  unit-distance neighbour already in Parts's lattice, four of them at denominator 1, each adjacent to
  `(1,0)` — against the phase's angle managing 72 glue points at cheapest denominator 42. **So `n = 2` is
  alive, 6-open, and cheaper than the record**, and the thing that probably kills it is that its endpoint
  bound of 1.5119 contains only **499** lattice points, so its entire cross-edge-bearing arena is about
  1,000 vertices — against a 509-vertex record that was *reduced* from a 3,433-point base. **And thinness
  cannot be bought with radius**: material past the endpoint bound carries no cross edge and is absorbed
  (G40). That is one measurable column, not a search. (Poros, PH2-10.)
- **Nothing here shows any member PRODUCES five-chromaticity.** No type-M arena ever has: the record's
  refusal is **inherited**, since its arena contains Heule-510, a graph certified 5-chromatic *before* the
  construction is applied (PH-10). The reference class for "this works" is **n = 1**, not n = 2.
- **The diagonal kind alone is a matching** (§2.3) and saturates fast. A live member still needs its
  **non-diagonal** cross edges enumerated, and those are what the record's two connecting orbits supply.
  Gate A buys the diagonal family and says nothing about the rest.
- **The 4-colour filter fires one way only.** A member surviving gates A–D is **un-eliminated, not
  alive** — one argument against it can no longer be made, and nothing more. **Silence is not evidence.**

---

## §7 — Controls, and one live failure of the product owner's own

- **The known-answer gate ran first and passed**: Parts's lattice rebuilt to 3,433 points at radius 2.44
  with **exactly 30** points on `|p|² = 4`. Nothing above was believed before it.
- **The squareness predicate was controlled on both outcomes** — `{1,3,4,11,33}` true and `{2,5,6,7}`
  false, each checked against an independent squarefree-class test, so the predicate is demonstrably not a
  constant function.
- **A vacuous pass, caught, and worth recording.** The product owner's first attempt at §4's set
  comparison compared the norm-4 shell against `2·S` and printed **`EQUAL: True`** — while both sets were
  **empty**, because the exact norm returns a field element in a 4-tuple basis and was being compared
  against a bare integer. The subset test on two empty sets passes for free. It is the exact failure mode
  `CLAUDE.md` catalogues as this project's oldest — *a check that reports nothing when it could not run* —
  and it was produced by the person who wrote that paragraph, twenty minutes after quoting it in a
  briefing. **The repair that caught it is now in the script: assert both sets nonempty before believing a
  set identity.**
- **Which half produced each number.** The shell counts, the `2·S` identity and the integer-shell census
  are **measured** on the lattice with exact field arithmetic (error mode: a *missed* point, which would
  make counts too low). The classification, the endpoint bound and gates B–D are **derived** (error mode:
  an *invented* consequence, which flatters). They are recorded separately for that reason.

---

## §8 — What to do next, ranked

1. **Screen `n = 12` and `n = 16` on the grown lattice**: build Parts's lattice to radius 3.50 and 4.03,
   confirm the 30 free circle points and their unit degree, then enumerate **all** cross edges at `ρ_n` —
   diagonal and not — with the cross-edge law taken as a parameter. This is the whole of the mission that
   remains, and it needs no new base.
2. **Screen `n = 2` for its real obstruction.** It is 6-open, its arena is 73% of the record's radius, and
   its circle is empty on Parts's lattice but not in the field. Either it dies for a nameable reason, which
   is a result, or it is the cheapest thing on this list by a wide margin.
3. **Raise FS-22.** Its field and `n = 16`'s are the same, reached independently.
4. **Record the arena's field in the phase-G/H census.** No document in phase G, H or H2 states what field
   the new rotation's arena lives in; it is `K(√(202 − 22√33))`, and FS-30's *"nothing on either base is
   6-open"* is a claim about a subject that was never written down (PH2-8).

## §9 — Credit

The classification, the `n = 16`/`ρ₆₃` identification, the `sin θ ∈ K` screen, the 14×/42× table, the
matching argument and the joint pricing are **Poros's** (`plans/POROS-2026-09-12-m63-phaseH2.md`, cards
PH2-1 … PH2-9); the correction narrowing the matching argument to "a large sufficient family" is the
**planner's**; the shell-count bound and the measurement that a divisor formula errs **optimistically**
are the **prior-art agent's**. The uniqueness proof of §3, the endpoint-bound generalisation, gate A and
§4's identity are the product owner's, as is the vacuous pass in §7.

**Three of the advisor's own numbers were corrected during the phase, every one of them in the direction
that flattered the record's side** — the `r⁸` pricing of `ρ₆₃` (caught by the planner; the ruling moved
with it), the claim that `n = 16` was the unique 6-open member at radius ≤ 8 (refuted by the advisor's own
printed table, which listed `n = 64` at radius exactly 8 — caught by the planner), and the unit degree 14
(caught by the advisor itself on re-check; the true value is 30). The advisor recorded all three against
itself within an hour of writing a card about the same bias in other people's instruments. That is G21
operating exactly as the grokking describes, and the reason the corrections are in this file rather than
lost is that two readers were looking at one table.
