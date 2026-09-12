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

## §3a — The family IS this project's spindle construction (added 2026-09-12)

Not a new theorem — a **re-description**, and its value is that it imports a kernel-checked theorem as the
refutation route and explains where `4n − 1` comes from.

**Spindling** a pair forced equal at distance `d` rotates a copy of the gadget so that the two far endpoints
land at **distance 1**: `2d²(1 − cos θ) = 1`, hence `cos θ = (2d² − 1)/(2d²)`. With `n = d²` that is
**exactly §3's family**, `sin θ = √(4n − 1)/(2n)`, and the spindle adjoins `√(4d² − 1) = √(4n − 1)` — the
family's radicand, the quantity every gate in §5 is computed from.

So **the diagonal cross edge and the spindle's closing edge are the same edge**, and a type-M construction at
`ρ_n` is the spindle over the pair (centre, circle point) at distance `√n`. This project held both
descriptions and never connected them. The check that it is the same family, not a similar one:

| `n` | `d` | `cos θ` | angle | radicand | what it is | `CLAUDE.md` G7 records |
|---|---|---|---|---|---|---|
| **3** | `√3` | 5/6 | 33.557° = 30° **+ 3.557°** | 11 | **the Moser twist** | *"the Moser twist 3.557° off 30°"* |
| **4** | 2 | 7/8 | 28.955° = 30° **− 1.045°** | 15 | **`ρ₁₅`, the record** | *"ρ₁₅ 1.045° off 30°"* |
| **16** | 4 | 31/32 | 14.362° | 63 → 7 | the candidate | — |

**Both of G7's recorded "detunes off a crystal angle" are this family at `n = 3` and `n = 4`**, to three
decimal places, and G7's own sentence — *"a spindle at distance `d` … forces the next colour only if
`√(4d² − 1)` breaks the relevant wall"* — is the family's radicand. The agreement is exact because it is
one construction, not two.

**The family is therefore a ladder, one rung per colour, and each rung fails for the reason the next fixes:**

| `n` | radicand | squarefree | in `K`? | wall broken? | rung | why it stops there |
|---|---|---|---|---|---|---|
| 3 | 11 | 11 | **yes** | no | **χ ≥ 4** | the Moser spindle's own rotation is **field-internal**, so it can never reach five |
| 4 | 15 | 15 | no | **yes** | **χ ≥ 5** | the first wall-breaking member — the record — but its field is **5-sealed**, so it can never reach six |
| 16 | 63 | **7** | no | **yes** | **χ ≥ 6?** | the cheapest member that is wall-breaking **and** 6-open |

**What this buys, concretely.** A circle point taking the centre's colour in **every** proper four-colouring
is a **pair forced equal at four colours** (`Forces`), at distance 4, and ledger row 44's
`not_colorable_of_forced_equal` — kernel-checked — says a forced-equal pair at any `d ≥ 1/2` refutes
`k`-colourability. So **one forced circle point refutes the arena through a theorem already proved**, making
the object an illustration of the mechanism rather than the evidence for it. Row 59's valuation law
**permits** it: a four-colour forced pair needs positive valuation at the prime above 2, and the distance
here is 4. Under test as of 2026-09-12: over 12 seeded colourings of one half, **exactly 10 of the 30 circle
points** took the centre's colour every time, and a colouring with **none** of them doing so is **UNSAT**.
Whether any single point is *forced* — and whether those twelve colourings are genuinely distinct rather
than twelve walks into one basin — is the live question.

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

**The gate-D ramification question, raised by Poros against its own table and now CLOSED by derivation
(product owner, 2026-09-12) — the convention was right, and for a reason.** At `n = 36` the radicand is
`143 = 11·13`, so 11 **ramifies** in `F = K(√d)` — neither inert nor split — and G43's criterion (*wall
broken ∧ 11 inert*) is silent on that case. The screen tested `d % 11 ≠ 0`, which was a convention. The
derivation, from two theorems already held:

| type in `F/K` | `e` | `f` | residue field | `q mod 4` | is `i` in it? | usable? | verdict |
|---|---|---|---|---|---|---|---|
| split | 1 | 1 | `𝔽₁₁` | 3 | no | **yes** | 5-sealed |
| **ramified** | 2 | 1 | `𝔽₁₁` | 3 | no | **yes** | **5-sealed** |
| inert | 1 | 2 | `𝔽₁₂₁` | 1 | **yes** | no | **6-open** |

**Sealing depends on the residue DEGREE `f` alone, through `q = 11^f mod 4`.** G35's usable primes are
exactly the conjugation-fixed primes of `F(i)`, which is to say those whose residue field does **not**
contain `i`, i.e. `q ≡ 3 (mod 4)`. Split and ramified both have `f = 1`, leaving `q = 11 ≡ 3`, so `i` is
absent, the prime of `F(i)` above it stays conjugation-fixed, G43's bound `χ ≤ χ(UD(𝔽₁₁,2)) = 5` applies,
and the field is sealed. Only **inert** gives `f = 2` and `q = 121 ≡ 1 (mod 4)`: then `i` **is** in the
residue field, the prime of `F(i)` **splits**, it is not conjugation-fixed, no bound is delivered, and the
field is 6-open. **So ramified behaves exactly like split, the screen is correct, and G43's criterion is
better stated as "11 has residue degree 2" — "inert" being the squarefree-`d` wording of the same thing.**

**And the last gap, closed by the advisor: ramification cannot interfere anywhere in the argument**, because
the reduction never needs the *points* to be integral — only the **differences** — and a difference of norm 1
has valuation 0 whatever the ramification index is. So `e` plays no role at any step, which is exactly why the
table collapses to `f`. The advisor's own accounting of its flag is worth keeping: *it was about a missing
justification, not a wrong value* — the row said "no" as a guess and the derivation confirms "no", so nothing
moves except that the column now has a ground.

**Its recurrence, quantified by the planner and checked here with one exception he did not have:** 11
divides the squarefree radicand exactly when `n ≡ 3 (mod 11)` — `n = 3, 14, 25, 36, 47, 58, 69, 80, 102,
113, 124, 135` at `n ≤ 140` — **except when `11²` divides `4n−1`**, which happens first at `n = 91`
(`363 = 3·11²`, squarefree part **3**), where 11 is *unramified* and the member instead dies on gate B,
since `3 ∈ K`. One member in eleven, with one exception in that eleven. **Offered for attack rather than
asserted:** it rests on reading G35's usability as exactly "the residue field omits `i`", and if that
reading is wrong the whole column moves.

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
- **`n = 2` is DEAD by derivation, and the route to that verdict was wrong twice before it was right.**
  First guess (product owner): *the circle is empty* — wrong, `2 = 1²+1²` puts `(1,1)` on it at denominator
  **1**, and **180** of its points have a unit neighbour already in Parts's lattice, four at denominator 1
  adjacent to `(1,0)`, against the phase's own angle managing 72 at cheapest denominator 42 (Poros). Second
  guess (product owner, from the screening agent's measurement): *thinness* — its arena is 499 points with
  **2,634** unit edges and mean degree **10.56** against the record's 1,771 / 12,810 / 14.47, thin on two
  axes, and thinness cannot be bought with radius. True, but not the reason. **The actual verdict, measured
  law-free from first principles (Poros): `n = 2` has 60 cross edges and every one of them is a CENTRE
  edge. Zero diagonal, zero off-diagonal — stable as the cut grows from 1.5119 to 2.0 (499 → 1,603 base
  points, still 60).** So its arena is two copies of a four-colourable graph glued at one vertex plus the
  centre star, which §6b proves four-colourable outright. **`n = 2` is not the discriminating case for
  anything**, and it was never the near-miss it looked like.
- **Nothing here shows any member PRODUCES five-chromaticity.** No type-M arena ever has: the record's
  refusal is **inherited**, since its arena contains Heule-510, a graph certified 5-chromatic *before* the
  construction is applied (PH-10). The reference class for "this works" is **n = 1**, not n = 2.
- **The diagonal kind alone is a matching** (§2.3) and saturates fast. A live member still needs its
  **non-diagonal** cross edges enumerated, and those are what the record's two connecting orbits supply.
  Gate A buys the diagonal family and says nothing about the rest.
- **The 4-colour filter fires one way only.** A member surviving gates A–D is **un-eliminated, not
  alive** — one argument against it can no longer be made, and nothing more. **Silence is not evidence.**
- **"DEFEATS THE FOUR-COLOUR CERTIFICATE" IS RETIRED AS A SIGNAL — it is automatic** (screening agent,
  2026-09-12, derivation plus measurement). The certificate's colouring is a group homomorphism into a
  four-element field of characteristic two, and a free circle is `t ×` the unit shell, so **every circle
  point carries the centre's residue whenever `t` is even** — and a colour twist cannot repair it, because
  the shared centre pins the twist. Measured: the circle residues all equal the centre's, and **0 of 24**
  twists work at either prime. **The record itself has `t = 2`, so its certificate is defeated for the
  same free reason.** Every value in the phase's "distance to a colourability proof" table — the record's
  30, the colourable reference's 18, stage 1's 8 — is therefore a reading of a quantity that is free
  wherever the circle is free. Anything earlier in this file, in the mission brief, or in any report of
  mine that offered "the certificate is defeated at both primes" as evidence **was offering nothing.**

---

## §6a — What to measure instead: the NON-FREE residual (added 2026-09-12)

With the certificate signal retired (§6) and the circle count demoted (§2), the screening agent took the
cross-edge decomposition apart rather than celebrating that it reproduced the record's, and what is left is
the first quantity in this phase that is not free.

**The `126 = 60 + 36 + 30` decomposition, by how much of it is forced:**

| part | count | forced by | is the cosine involved? |
|---|---|---|---|
| centre edges | **60** | `2 × 30` for **every** rotation — the shared centre and the unit shell | **no** |
| diagonal | **30** | the free circle, gate A | **no** |
| off-diagonal | **36** | nothing — this is the law-exposed part | **yes** |

So 90 of the 126 are a **free two-sided control** and only 36 carry information. All 126 were re-derived by a
second independent implementation: **0 invented edges**, so the law is sound *and* complete at the new
parameter. **And the two objects genuinely differ where it counts:** the record's 36 sit on **one**
conjugate radius pair, `ρ₆₃`'s on **three**, including a rational pair the record has no analogue of.

**`n = 20` demotes the circle count by instance, not by argument.** It has **twice** the record's circle
(60 points) and its decomposition is `120 = 60 + 0 + 60` — **zero** off-diagonal cross edges. Its entire
cross structure is a centre star plus a perfect matching, and a matching carries no colour pressure (G14).
**The quantity this phase was built to maximise points the wrong way**, and this instance also confirms the
126 is not an artefact of one pipeline.

**The proposed objective, replacing the circle count:** the **off-diagonal share of the monochromatic
cross edges** — the part of the certificate's defeat that is *not* free. On the phase's own
distance-to-colourability metric `ρ₆₃` scores **54** against the record's 30 and stage 1's 8; but the
record's 30 are **entirely** the forced diagonal kind, losing not one off-diagonal edge, whereas **24 of
`ρ₆₃`'s 54 are off-diagonal.** So `ρ₆₃` is the first arena in this phase whose certificate defeat is not
free, and 24 is the number to carry forward. **Caveat, stated by the agent that proposed it:** on the only
positive instance anyone holds, that metric's leader is the free quantity, so the new objective is a
better-motivated guess and not a validated one.

**Prior art on the field question: none, and structurally none.** In coincidence-site theory a coincidence
rotation of a module is by definition `α/ᾱ` with `α` in the module's **own** ring, so it lies in the
module's own field and **generates no extension at all** (the square lattice's lie in `ℚ(i)`, the
hexagonal's in `ℚ(√−3)`). "Which extension does this rotation adjoin" is only a meaningful question when
the rotation is **not** a coincidence rotation of the base — **which is exactly the type-M case**, and it
is why the rotated copy meets the base in one vertex and the construction needs cross *edges* rather than
shared points. So that literature gave a shelling formula and could not have given a field classification,
and **the field half of this phase is ours with no citation to fear.** The next room for it is not
crystallography but rational points on the norm-one torus (the Pell conic); the 6-openness half rests on
this project's own sieve and has no literature at all.

---

## §6b — The matching-only arenas are settled by a THEOREM, not a solver (added 2026-09-12)

**The product owner proposed that "a type-M arena needs two kinds of cross edge" is really "it needs one
kind that is not a matching", leaning on G14 (*a matching carries no colour pressure*). The advisor refuted
the load-bearing step and proved the correct conditional form.**

**What is false:** *"a matching cannot force"* is **not a theorem**. Two four-colourable graphs joined by a
perfect matching need **not** be four-colourable — if the matched pairs realise every ordered pair of
colours, no relabelling of the second copy escapes. G14's scope does not reach a rotated copy sharing a
centre, and the general claim is false outright.

**What is true, and it is better.** The two halves are the *same* graph on the same index list (G46's data-
layout fact), so any arena colouring may be tried as `(C on the base, π∘C on the copy)` for a permutation
`π` of the four colours. Then:

- **the centre star is provably FREE**, not merely "absorbed" by G40. The shared centre forces `π` to fix
  its own colour; a centre cross edge needs `π(C(v)) ≠ C(0)` for a unit vector `v`; and `C(v) ≠ C(0)`
  already holds inside the base, so `π(C(v)) = C(0)` would force `C(v) = C(0)` — contradiction. **Every `π`
  fixing the centre's colour satisfies the entire centre family at once.**
- **the diagonal matching reduces to a condition on colour classes, not on points:** `π` must move every
  colour that occurs on the circle.

> **Theorem (advisor, 2026-09-12).** An arena whose only non-centre cross structure is the diagonal matching
> is **four-colourable as soon as the base has one proper four-colouring in which no circle point takes the
> centre's colour** — then take `π` to be a three-cycle on the other three colours.

**This replaces an arena solve with a cheap search on the base**, and it is **conditional**: the hypothesis
can fail, and then the twist family is exhausted and nothing is decided — *silence is not evidence*. **And
the residue colouring can never be the witness** when the circle is an even multiple of the unit shell,
because it sends every circle point to the centre's own colour. The witness must be a four-colouring of a
kind this project has never enumerated.

**Measured consequence already in hand.** The solver agent asked exactly this question on `ρ₆₃`'s base and
it is **UNSAT in 20 s** — no proper four-colouring of that base avoids the centre's colour on all 30 circle
points. `ρ₆₃` also carries 36 off-diagonal edges, so the theorem does not apply to it; what the UNSAT says
is that the twist family cannot colour its arena, which is PH2-7's conclusion reached by measurement. **For
a matching-only member the same question is the whole answer, and it costs about 20 seconds.**

## §6c — One formula reproduces every count three agents measured, and the target list closes at two

**The circle count is exactly the base's shell count at `|p|² = n`.** Nothing else — no radius, no cosine,
no field. Enumerated from the congruence conditions directly:

| `n` | 2 | 4 | 9 | 12 | 16 | 20 |
|---|---|---|---|---|---|---|
| count | **0** | **30** | **54** | **42** | **30** | **60** |
| measured independently by | advisor | control (the record) | planner | planner | planner | screening agent |

**Six for six across three agents**, and it supersedes both earlier forms of the condition: not "`n` is a
perfect square" (the advisor's) and not "`n` is a square in `K`" (the product owner's), but **`n = k²·m`
with `k ∈ ℤ` and `m` a squared distance the base already realises** — `12 = 4·3` and `20 = 4·5` are free
for that reason, and `2` is not free at all.

**And the affordable 6-open targets are exactly two.** Every `n` whose power of 2 is **odd** has an empty
circle over Parts's lattice — now **30 of 30** values checked, upgrading a hunch to a measured law — and
6-openness forces `n` even. So a 6-open member with a non-empty circle needs `4 | n`, and at `n ≤ 31` that
leaves **`{16, 20}` and nothing else.** The other four 6-open members below 31 (`2, 10, 22, 24`) are empty
for a 2-adic reason **no radius and no refinement of this lattice can fix.** The search space for this phase
is two objects.

## §6d — Why the verdict now computing is the milestone's real test

The record's refusal is **inherited**: its arena contains Heule-510, a graph certified five-chromatic
*before* the type-M construction is applied (PH-10). `ρ₆₃`'s rotation differs, so its arena almost certainly
does **not** contain that graph. **`ρ₆₃` is therefore the first arena of the record's exact shape whose
refusal could not be inherited** — which makes the computation in flight the milestone's real test rather
than one candidate among several, and makes a *four-colourable* verdict there informative rather than
disappointing.

---

## §6e — The counting compulsion: the phase's first objective that is NOT free (added 2026-09-12)

**How it arrived, because the route matters.** The solver agent reported that over 12 seeded colourings of
`ρ₆₃`'s base, exactly 10 of the 30 circle points took the centre's colour **every time** — a candidate
lattice invariant. The product owner asked for one control: *different seeds do not prove different
colourings.* The control killed the number. Re-run with **pattern-blocking** (each round forbids the exact
30-point pattern just seen, so the next colouring differs by construction), one colouring put **all 30**
circle points at the centre's colour and *"at least 11"* is satisfiable in 0.1 s. **The twelve identical
readings were one colouring sampled twelve times.**

**What survives is a one-sided bound, and it is the useful shape.** *"At most 9"* is **UNSAT**, so

> **every proper four-colouring of the base puts at least `L = 10` of the 30 circle points at the centre's
> colour.** A **floor**, not an invariant. *(Provisional: being re-verified two-sidedly on a standalone
> solver, since an incremental-solver anomaly is under investigation — see §7. "At most 10" must come back
> SAT or the cardinality encoding is the story rather than the lattice.)*

**And the floor is a refutation criterion, fully general.** Let `C` be **any** proper four-colouring of the
arena; put `f(v) = C(v)` and `g(v) = C(Rv)` for `v` in the base. Both are proper four-colourings of the
base, because the copy is isometric and carries the same internal edge list (G46). Then:

1. `R0 = 0`, so **`f(0) = g(0)`** — the shared centre;
2. each diagonal cross edge `(v, Rv)` gives **`f(v) ≠ g(v)`** at every circle point — the free circle;
3. with `B(h) = {circle v : h(v) = h(0)}`, any `v ∈ B(f) ∩ B(g)` gives `f(v) = f(0) = g(0) = g(v)`,
   contradicting 2.

So `B(f)` and `B(g)` are **disjoint**, hence `|B(f)| + |B(g)| ≤` the circle count, and

> **`2L > circle count` ⟹ the arena is NOT four-colourable** — with `L` a property of the **base alone**,
> no arena solve required.

**Scope, exactly.** It is **not** confined to the colour-twist family `(C, π∘C)` — `f` and `g` above are
arbitrary and independent, which is precisely the objection the planner raised against PH2-7 and this
construction escapes it. It uses **only** the diagonal cross edges, so the off-diagonal ones can only help.
It is **sufficient and not necessary**: `2L ≤ count` decides nothing, and silence is not evidence.

**Why both cheap routes closed, in one sentence.** The one-vertex route needs `L = count`; the
intersecting-family route needs `2L > count`; `ρ₆₃` measures `L/count = 1/3`. All three are readings of the
same quantity, and the two cheap ones were asking for values far above the one the object has.

**Both cheap routes, closed with evidence rather than left unmeasured:**
- **No circle point is forced.** All 30 tested individually — each query asks for a colouring with the
  centre at colour 0 and that circle point **not** at colour 0 — and **all 30 are satisfiable** (0.15–1.9 s
  each). So `Forces` is **not inhabited** here at distance 4, and row 44's `not_colorable_of_forced_equal`
  cannot be applied to this arena. These are **SAT** answers and therefore self-certifying, so they survive
  the incremental anomaly.
- **The achievable centre-coloured sets are not an intersecting family.** Two disjoint ones exhibited:
  `{111, 2289, 3513, 6332, 12496, 13070, 19234, 22053, 23277, 25455}` and
  `{107, 2211, 3559, 6316, 12506, 13060, 19250, 22007, 23355, 25459}`.

> **THE PHASE'S OBJECTIVE, replacing the circle count:** maximise **`L / (circle count)`**. Refutation above
> **1/2**; `ρ₆₃` sits at **1/3**. This is the first quantity in this phase that **a free construction cannot
> hand over** — the circle count is free (§2), the certificate's defeat is free (§6), and `L` is neither.

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
