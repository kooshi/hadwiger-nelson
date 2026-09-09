# The mascot of a 5-chromatic field — derivation log

*Kooshi's challenge, 2026-09-08: derive, by algebra alone and with no search, the analogue of the
Moser spindle for one of the fields whose plane is 5-chromatic. Working name for the product: the
**Claude(deBruijn)–Kooshi spindle**. This file is the durable record; it is written for a reader
who has none of the session's context.*

## 0. What "mascot" means, made precise

The Moser spindle is the mascot of `K = ℚ(√3, √11)` because three things coincide:

1. **It is the minimal forcing shape at three colours.** The abstract minimal gadget forcing two
   vertices to share a colour at `k` colours is `K_{k+1}` minus one edge — a `(k−1)`-clique with two
   non-adjacent vertices joined to all of it. At `k = 3` that is `K₄ − e`, and `K₄ − e` **is drawable
   with unit distances**: it is the rhombus, two unit triangles glued on an edge, whose far tips lie
   at `√3`. Four points.
2. **The twist is forced by the distance.** A pair forced equal at distance `d` is refuted by
   rotating a copy about one endpoint through `ρ_d = (2d² − 1 + i√(4d² − 1))/(2d²)`. At `d = √3` that
   is `ρ = (5 + i√11)/6`.
3. **The field is exactly what the two ingredients generate**: `√3` from the lattice, `√11` from the
   twist. `K` is the smallest field drawing the object, and `χ(K²) = 4` exactly (Theorem B).

So a mascot is: *minimal forcing shape × the twist its distance names × the field the two generate.*

## 1. The parity law (new; verified exactly in `ladder.py`)

Let `ρ` be the Moser twist, `cos = 5/6`, `sin = √11/6` — the rotation the project's T13 says every
unit edge of every object here lies on some power of. Put a hub at the origin and walk the circle of
radius `√3` by repeated `ρ`: the points `q_j = √3·w·ρ^j`. The chord from step 0 to step `j` has

> `d_j² = m_j / 3^(j−1)`,  `m_1 = 1`, `m_2 = 11`, `m_{j+1} = 5·m_j − 9·m_{j−1} + 2·3^j`.

Modulo 2 the recurrence is `m_{j+1} ≡ m_j + m_{j−1}` — Fibonacci, seeded `1, 1` — so

> **`d_j²` is even if and only if `3 | j`.**

The chords: `1, √33/3, 8/3, 5√33/9, 31/9, 16√33/27, 83/27, 35√33/81, 136/81, …`

**Why it decides the field.** Theorem B's residue colouring is a proper 4-colouring of every
`K`-object and it identifies two points exactly when their difference has positive `𝔭`-adic
valuation — for a rational `d²`, exactly when `d²` is even. A pair *forced* monochromatic at four
colours must be identified by **every** proper 4-colouring, that one included. Hence:

> **On the Moser ladder, a pair forced monochromatic at four colours sits at a step divisible by 3.
> The first is `d_3 = 8/3`, and spindling it adjoins `√247`.**

Equivalently and more memorably: `ρ ≡ −ζ₆ (mod 8)`, so the Moser twist has order 3 modulo 8, and the
whole ladder collapses onto the hexagonal lattice mod 8. The "8" in `8/3` *is* that modulus.

**Two confirmations, both found after the derivation, neither used in it.**
- Our own M53 rigidity dial (`plans/FIELD-WALL-SESSION-HANDOFF.md` §8) measured forced-equal pairs at
  four colours **only** at that valuation — 163/178 at `8/3`, none at distances 2 or 4, over 15,230
  pairs. That was recorded as an unexplained regularity. It is this law.
- **[Parts2020hv]** (arXiv:2010.12661 §2, downloaded and read today) publishes an empirical table:
  pairs at `1/3, 5/3, 7/3, √3, √(11/3)` are forced *non*-monochromatic at four colours, and a pair at
  `8/3` is forced monochromatic. Every entry is the parity law — odd numerators non-mono, the single
  even one mono. He gives no explanation. **The arithmetic explains a published table.**

## 2. The minimal configuration (new)

Five points, four colours: some pair repeats. The arithmetic says which pair *can*. So the mascot's
base is a 5-point configuration with exactly one even-`d²` pair, and as many unit edges as possible.

> **The centre of a unit hexagon together with four consecutive vertices of its ring** —
> `c = 0`, `r₁ = 1`, `r₂ = ζ₆`, `r₃ = ζ₆²`, `r₄ = ζ₆³ = −1`.

It carries **seven unit distances, the maximum possible on five points in the plane**, and its three
non-unit pairs are `r₁r₃ = √3`, `r₂r₄ = √3`, `r₁r₄ = 2`. Squared: `3, 3, 4` — exactly one even. It is
the unique such configuration up to isometry (checked: the other maximal 5-point unit configuration
is this one relabelled).

**The forcing is two lines.** `{c, r₂, r₃}` is a unit triangle. `r₁` and `r₄` are each joined to all
three of it — `r₁` by unit, unit, `√3`; `r₄` by unit, `√3`, unit. So in the `{1, √3}` distance graph
the five points are `K₅ − e`, the missing edge being `r₁r₄`. Every proper 4-colouring therefore
gives `r₁` and `r₄` the same colour, and they lie at distance **2**.

**Then the twist.** `4·2² − 1 = 15`, so `ρ₁₅ = (7 + i√15)/8`. Rotating the configuration about `r₁`
sends `r₄` to `r₄'` with `|r₄ − r₄'| = 2·|ρ₁₅ − 1| = 2·(1/2) = 1` — a unit edge between two points
forced to the same colour. **Nine vertices, `χ ≥ 5`.**

**The relation to `K(√247)`.** The hexagon is the same construction with `ζ₆` in place of `ρ`:
`ζ₆` also has order 3 modulo 2 (`ζ₆³ = −1 ≡ 1`), its step-3 chord is `|ζ₆³ − 1| = 2`, and `4·4 − 1 =
15` gives `√5`. So the two mascots are one family indexed by (rotation, radius), and the arithmetic
that picks the step is the same in both. The hexagon is the cheaper member.

## 3. Where it stands, honestly

The nine-vertex object above is complete, derived, and verifiable by hand — but it is a **two-distance
graph** (`{1, √3}`), so what it proves is `χ(ℝ²; {1, √3}) ≥ 5`, not `χ(ℝ²) ≥ 5`. Its coordinates lie
in `ℚ(√3, √5)`. Converting it into a genuine unit-distance graph requires realising each `√3` edge
as a **virtual edge at four colours**: a unit-distance graph, coordinates in `K`, forcing two points
at distance `√3` to differ in every proper 4-colouring. Four instances are needed.

Such gadgets are known to exist — Parts cites them — but every one was found by computer search over
200+ vertices, which this challenge forbids. **This is the single remaining ingredient, and the
reduction to it is total.**

**Why it is hard, stated as a theorem rather than a complaint.** A forced-*equal* pair at `k` colours
is a `(k+1)`-chromatic object with one non-unit edge; a forced-*distinct* pair is one with two
vertices identified. At `k = 3` the minimal gadget `K₄ − e` is drawable with unit distances, so the
Moser spindle is self-contained. At `k = 4` the minimal gadget needs two points joined to a whole
triangle, and in the unit-distance graph **no such pair exists** — the point equidistant from three
given points is unique. So the step from four colours to five *cannot* be taken inside the
unit-distance graph by the minimal shape, and every route out of that obstruction has so far cost a
computer. That is a structural statement about why `χ ≥ 5` is expensive and `χ ≥ 4` is free.

**Partial progress on the gadget, arithmetic.** Any 4-colouring given by a homomorphism out of the
difference lattice factors through that lattice mod 4, and mod 4 the ladder collapses onto the
Eisenstein lattice. There the homomorphism `a + bζ₆ ↦ a − b (mod 4)` is proper on all six units and
**identifies** the `√3`-pair `1 + ζ₆` — so no amount of ladder or lattice material can force a
`√3`-pair distinct, and the mod-3 colouring of the triangular lattice makes every `√3`-pair
monochromatic outright. The gadget must therefore contain material outside `⟨ζ₆, ρ⟩`; the seam
rotation `σ = (√3 + i√33)/6` does enlarge the lattice mod 4, and Parts's own base-graph coordinates
`(a + b√33 + ic√3 + id√11)/12` carry exactly that. What is not crossed is the gap from "no additive
colouring identifies them" to "no colouring identifies them".

## 4. Prior art checked (WORKFLOW step 3a)

- **[Parts2020hv]** J. Parts, *The chromatic number of the plane is at least 5 — a human-verifiable
  proof*, arXiv:2010.12661, Geombinatorics 30/2 (2020) 77–102. **Held now at
  `library/pdf/arXiv-2010.12661-parts-human-verifiable.pdf`; §§1–3 read.** A genuinely
  human-verifiable proof of `χ ≥ 5` exists and predates us by six years — so "first human-verifiable"
  is not available as a claim. His method is colouring trees over computer-found base graphs; there
  is no algebra in it, no field statement, and no explanation of his own mono/non-mono table.
- **[Parts2020a]** arXiv:2010.12665, the 509-vertex record. Held **unread** in our library since this
  morning — a G50 liability, flagged, not yet discharged.
- The 553-vertex Heule graph's "key component of 420 points in `ℚ(√3,√11)²`" is noted in the
  literature; consistent with Theorem B, since a `K`-component alone is 4-colourable.

## 5. The derivation, in its final and shortest form

Let `ω` be a rotation of the plane with `cos θ = c`, and walk a circle about a hub by repeated `ω`.
Because `|ω| = 1` we have `ω̄ = 1/ω`, so

> `ω² + ω + 1 = ω·(ω + 1 + ω̄) = ω·(2c + 1)`,

and therefore `ω³ − 1 = (ω − 1)·ω·(2c + 1)`. Since `|ω| = 1`:

> **the step-3 chord is `|2c + 1|` times the step-1 chord.**

Normalise so that consecutive ladder points are at unit distance. Then the step-3 chord is exactly
`2c + 1`. A pair forced monochromatic at four colours over `K` needs 2-adic valuation at least 2 —
`𝔽₄`-residue arithmetic gives valuation `> 0`, and the six `ℤ/4`-type additive colourings of the
Eisenstein lattice raise it to `≥ 2` — so the requirement on the rotation is

> **`4 | (2c + 1)` two-adically.**

For the Moser twist `c = 5/6`, `2c + 1 = 8/3`, of 2-adic valuation **3**. The radius that makes the
steps unit is `r = 1/√(2 − 2c) = √3`. And the spindle radicand is `4·(8/3)² − 1 = 247/9`.

**Uniqueness (bounded search, `unique.py`, all `c = p/q` with `q ≤ 400`).** Nine rotations satisfy
all of {unit steps, drawable in `K`, `4 | 2c+1`}. Exactly two have base field equal to `K` rather
than a proper subfield — `c = 5/6` (chord `8/3`, radicand `247/9`) and `c = −139/150` (chord `64/75`,
radicand `10759/5625`, adjoining `√10759 = √(7·29·53)`). **`c = 5/6` is the one of least height, and
it is the only one that already carries the rung below**: its first two rungs, with their rhombi,
*are* the Moser spindle. The mascot is the Moser spindle continued from two rhombi to four.

## 6. Two corrections, one to the literature and one to this session's own advice

**(a) It answers a question Parts states and abandons.** `[Parts2020hv]` §2, in the section he
introduces as "ideas, mostly those that have turned out to be dead ends": *"The fan-like graph
obtained by sequentially connecting four 4-vertex rhombus graphs with a common vertex seems tempting
too. The distance between the extreme vertices of this graph is 8/3, that is, a mono-pair can be
formed. For three such rhombuses, the distance between the extreme vertices is √(11/3), which can be
a non-mono pair. **The only question is what to do with it?**"* — He has the configuration, the `8/3`,
and the `√(11/3)`, and does not see that the hub together with the four extreme vertices is `K₅`
minus one edge in the `{1, √3, √(11/3)}` distance graph. That is the answer to his question, it is
two lines, and it is what makes the object force.

**(b) The sieve verdict, corrected and then sharpened (`sieve.py`).** Poros reported that every
distance the law can select lands in a 5-sealed field, hence that `K`-fabric can never reach a
6-open one. **That is false as stated**: sieving *every* deep ladder chord, the fields alternate —
`j = 3` sealed (`√247`), **`j = 6` 6-OPEN** (`√33063`), `j = 9` sealed, `j = 12` 6-open, and so on.
Two sub-findings fall out:
- **Every spindle over a deep pair breaks the 2-adic wall automatically** — the radicand `4d² − 1` is
  `≡ 7 (mod 8)` in every row, with no exceptions, because `d²` is 2-adically deep. That is G48's
  mechanism appearing as an identity rather than a case check. So 6-openness is decided *purely* by
  the Legendre symbol of the radicand modulo 11.
- But the conclusion survives for a better reason. **The minimal forcing shape can only target the
  *first* deep chord.** A configuration whose target is a later one contains earlier deep pairs too,
  so the pigeonhole yields a disjunction over several candidate monochromatic pairs rather than a
  forcing, and the spindle has nothing single to act on. On the Moser ladder the first deep chord is
  `8/3` and its field is sealed. **Minimality and 6-openness are in direct opposition here**, and
  that is a theorem about the shape, not an accident of the arithmetic.

## 7. THE ANSWER: the challenge is impossible as posed, and the proof is kernel-checked

**`Proofs/HadwigerNelson/Mascot.lean`, zero sorry, axioms exactly `[propext, Classical.choice,
Quot.sound]`.**

The Moser spindle is built by one recipe: take the **smallest graph forcing two non-adjacent
vertices to share a colour** at `k` colours, hinge two copies at a common vertex, and pick the hinge
angle so the two forced vertices land at distance 1. The recipe stops at `k = 3`, provably.

| theorem | statement |
|---|---|
| `card_le_of_forces` | a graph forcing a pair at `k` colours has `≥ k + 1` vertices |
| `colorable_of_not_adj` | a graph on `n + 1` vertices with a non-adjacent pair is `n`-colourable |
| `isNClique_of_forces_of_card` | at exactly `k + 1` vertices it is complete minus the forced edge, so it contains a `k`-clique |
| `no_four_unit_points` | four points of the plane are never pairwise at distance 1 |
| `not_forces_of_unit_drawing` | **no five points of the plane carry a pair forced to share a colour at four colours** |

**Generalized the same day** (`Mascot.lean`, second pass): the obstruction is host-generic —
`not_forces_of_drawing` says *a host graph with no `k`-clique draws no minimal forcing gadget at `k`
colours*, with the clique number the entire hypothesis and nothing geometric in the statement, and
`not_forces_of_unit_drawing` is its plane instance **at every `k ≥ 4`** (and at `≤ k+1` vertices,
since below the floor forcing is impossible outright). The other direction is now a theorem too:
`exists_forces_of_unit_drawing_three` exhibits the rhombus DRAWN — four points at `ζ₆, 0, 1, ζ̄₆`,
injective, every edge exactly one unit, forcing its far corners at three colours. So the threshold
is sharp, not merely bounded.

The proof of the geometric half is the one worth keeping: four points pairwise at distance 1 give
three plane vectors whose Gram determinant is `1/2` from the distance data and `0` because any three
vectors in a two-dimensional space are dependent. One `ring` call and one `linear_combination` each.

**The contrast is the content.** At three colours the minimal gadget is `K₄` minus an edge, and it
*is* a unit-distance graph — the rhombus of two unit triangles, far tips at `√3`, exactly what the
Moser spindle hinges. At four colours the minimal gadget contains `K₄`, and the plane's
unit-distance graph has clique number 3. **The plane's clique number equals the colour count at
`k = 3` and falls below it forever after**, so the recipe that produces a seven-vertex object at
three colours produces nothing at all at four. That is why every 5-chromatic unit-distance graph
ever built has five hundred vertices and a computer behind it.

## 8. What this retracts, in my own work of today

§2's nine-point object is **dead**, twice over, and both deaths were findable before I built it:

1. It used pairs at `√3` as edges, on a misreading of `[Parts2020hv]` §2 where a mangled `√` glyph
   in the text extraction turned distance **3** into `√3`. Parts's Table 1 (`[Parts2020a]`, read
   today) lists non-monochromatic **pairs** at `3, 7/3, 5/3, 1/3, √(11/3)` and puts `√3` only among
   the **triples**.
2. ~~Worse, no such gadget can exist: `core9_plane` says every proper 4-colouring of the plane has a
   monochromatic `√3`-pair, so `√3` admits no virtual edge at four colours, ever.~~ **RETRACTED
   2026-09-09, later the same day, while kernel-checking the valuation law.** The argument is
   unsound: `core9_plane` quantifies over proper four-colourings of the *whole plane*, and this
   repository's own `χ(ℝ²) ≥ 5` makes that type **empty**, so the theorem is vacuously true and
   forbids nothing (`Instances/Interval.lean`, `isEmpty_coloring_plane_four`). The same applies to
   `core122_plane` at distance 2. The duality *"a plane-wide pigeonhole at `d` forbids every virtual
   edge at `d`"* is empty at four colours for the same reason, and its non-vacuous form — over a
   class of objects that really is four-colourable, i.e. over `K` by Theorem B — is sketched but
   unproved (`plans/STUB-four-colour-valuation-law.md`). **The object stays dead**: reason 1 above
   and reason 3 below are each fatal on their own, and the valuation law adds a third that *is*
   proved — a `√3`-pair over `K` can never be forced *monochromatic*. What I cannot claim, and did,
   is that a `√3` virtual edge is impossible.
3. The skeleton was published anyway: `[ExooIsmailescu2019]` build a 79-point configuration in
   `ℚ[√3,√11,√247]` with `sin θ = 3√247/128` — my twist exactly.

**What survives from §§1–6 is the arithmetic**: the valuation law and the identity
`ω² + ω + 1 = ω(2c+1)`. Stubbed as `plans/STUB-four-colour-valuation-law.md`.

## 9. The word "minimal" is itself a posted open question

Found by Coxeter on the same page of `[ExooIsmailescu2019]` as the Theorem B question, three lines
on, verbatim:

> *"What is the minimum order of a 5-chromatic unit distance graph in the plane?"*

So the challenge's own adjective names an open problem, and §7's theorem is a (weak) structural
contribution to it rather than a side remark: a graph *forcing a pair* at four colours needs at
least `k + 1 = 5` vertices by `card_le_of_forces`, and the five-vertex case is excluded outright by
`not_forces_of_unit_drawing`. Pushing that floor upward is the same programme as the posted
question — the current bracket is somewhere above 9 (criticality plus the known maximum
unit-distance counts) and at most 509 (`[Parts2020a]`).

**And the T20 correction is now precisely scoped, which matters more than the retraction.**
`[ExooIsmailescu2019]`'s Claim 2.1 has the same field, the same rotation `sin θ = 3√247/128`, and
the same forced-pair-then-spindle move — but their forced pair is **conditional** (on no
monochromatic `√(11/3)`-pair), so their spindle yields a pigeonhole and their proof needs three
acts, in their own words *"less efficient as it employs three steps"*. Ours is **unconditional** on
K-fabric (the 588-vertex core), hence `χ ≥ 5` in one act, and `χ(K(√247)²) = 5` exactly (M58) is not
in them at all. **Only the word "first" is withdrawn.** Poros's warning against over-correcting was
the right one: a correction stated too broadly costs as much as the error.
