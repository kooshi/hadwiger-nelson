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
   the record's circle has points of unit degree **14** and denominator **1**; the phase's circle, **1** and
   **42**. Both counts are unbounded. A quantity two objects share cannot explain why one refuses four
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

**Theorem (module closure).** If `n = k²` for some `k ∈ K`, then `k·S ⊆ {p ∈ M : |p|² = n}`, where
`S` is the module's norm-1 shell. Hence the circle carries **at least `|S|` points**, and the unit
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

**Ranked by cost, cost being the arena radius the endpoint bound demands:**

| | `n` | arena radius | × the record | field |
|---|---|---|---|---|
| new 5-chromatic object | **4** | 2.066 | 1.00× | **the record itself** |
| | **12** | 3.501 | **1.69×** | `K(√47)`, 5-sealed |
| | 36 | 6.021 | 2.91× | `K(√143)`, 5-sealed |
| a rung toward χ ≥ 6 | **16** | 4.032 | **1.95×** | **`K(√7) = ℚ(√3,√7,√11)`, 6-open** |
| | 44 | 6.652 | 3.22× | `K(√7)`, 6-open |
| | 64 | 8.016 | 3.88× | `K(√255)`, 6-open |

**Three observations that are the phase's product.**

1. **The record is the unique cheapest live member.** Every smaller member dies, and the two that die
   below it — `n = 1` and `n = 3` — die by **Theorem B**, a theorem of ours. That is a small structural
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

## §6 — Scope, honestly: what this does NOT say

- **Gate A is sufficient, not necessary.** `n = 5` is not a square in `K` and yet Parts's lattice has
  **60** points at `|p|² = 5`. So members off gate A are **not** eliminated by §4 — they are merely
  denied the free circle, and must buy circle count and unit attachment separately, which is PH2-9's 81×
  factor. The original mission's shape survives *for them*, now with a reason it is expensive.
- **`n = 2` is un-eliminated and its circle is empty on Parts's lattice.** `|p|² = 2` holds 0 points there
  (measured), yet `(1,1)` is a `K`-point of norm 2, so the circle is nonempty in the field. `n = 2` is
  wall-broken and 6-open with an arena radius of only **1.512 — 73% of the record's** — so it remains the
  most attractive unscreened member and the one most likely to be hiding its reason for failing. Its
  reason is not §4.
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
