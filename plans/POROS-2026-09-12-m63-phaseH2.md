# Poros — M63 phase H2, finding the base (2026-09-12)

*Advising the product owner and two colleagues on `plans/M63-phaseH2-find-the-base.md`.
Uncommitted by me; the product owner commits it by path. Cards are numbered `PH2-n` and are stable
identifiers — cite them, never renumber. My predecessor's stage-1 ledger is
`plans/POROS-2026-09-12-m63-phaseH.md`, cards `PH-1`…`PH-10`; phase G's is
`plans/POROS-2026-09-12-m63-rotation-screen.md`, `RS-1`…`RS-7`.*

**The frame, on its five axes, as the brief states it.**

| axis | as the brief states it | address |
|---|---|---|
| object | a `ℤ`-module in `K = ℚ(√3,√11)` with many points on the circle `\|p\|² = (7+√33)/3` | §2 |
| question | can such a module put ~30 points on that circle | §2 final line |
| discipline | representation numbers of a quadratic form; theta series; shell counts | §5 |
| audience | the product owner tonight; `[Parts2020a]` §4 at the write-up | §1 |
| product | a base whose type-M arena refuses four colours | §1 |

**Where I disagree with the brief, at the top, since that is what I was asked for.** The question on the
**question** axis is answerable in five lines of arithmetic and the answer is **yes, ~30 is free** (PH2-1).
What is not free is everything else about that circle, and the two circles being compared differ on those
other quantities by factors of **14 and 42**, measured (PH2-2). The count is the one quantity on which the
record's circle and this one **can be made equal**; it is therefore the one quantity that cannot explain why
one refuses and the other does not. §2's framing is not merely weakly supported — it selects the single
coordinate along which the two objects are not different.

And on the **object** axis there is a one-integer family that contains the record as its `n = 4` member and
a **6-open** rotation as its `n = 16` member, both already named twice in this repository (PH2-4). That is
a product-axis question and it is the product owner's, so it is a recommendation with a default, not a
finding.

---

*Eleven cards, and my own gate warns that this is a spray. I accept the warning and answer it: **the turn is
PH2-1, PH2-9 and PH2-2 together** (ranks 1–3) — the target is free, and the two circles differ everywhere except on it. PH2-4 is
a separate turn addressed to the product owner because it changes the product. The remaining five exist
because this is a phase ledger the next session reads cold, not a single turn, and each carries its own fate
rather than a shared mood. Two open (PH2-4 and PH2-8); the rest carry their fate. Everything below is a read of
committed artifacts, or exact arithmetic I ran to check a claim I was about to make — no solver, no search,
no job over ninety seconds.*

## Evidence inventory

*One line per item, because the gate reads them per line and my first draft wrapped them — it failed on eleven of twelve and the failure was mine.*

- `plans/M63-phaseH2-find-the-base.md`, the mission brief, 239 lines — read against: a target quantity whose achievability has been established before it was made the objective — surprised: yes; §6 lists "whether any module achieves ~30" as UNKNOWN, and it is provable in five lines (PH2-1)
- the witness `u` of §2, re-derived by independent expansion in a formal square root and never by the cross-edge law — read against: §2's instruction to re-derive it — surprised: no; with `a = 1/3` and `b = √3/2 + √11/6`, `u = (a−b, a+b)` so `|u|² = 2a² + 2b² = 2/9 + 19/9 + √33/3 = (7+√33)/3` exactly, radius 2.0611131819592
- the same, conjugated — read against: nothing yet, since the brief never states it — surprised: yes, and it matters; `σ(α) = (7−√33)/3 ≈ 0.41848 > 0`, so α is totally positive and every K-point of the circle survives every all-conjugates disk cut of radius ≥ 2.0612 automatically (PH2-1), meaning radius can never remove a circle point
- `data/m62/m63-phaseG-screen-r2.44.json`, the `cos` field of all eleven rotation classes — read against: nothing, since no document in the phase groups them by anything but verdict — surprised: yes, strongly; exactly one of the eleven has a rational cosine (`−7/8`) and it is the only `unsat` one, the other ten all carrying `√33` (PH2-4)
- `tools/typem.py:1130-1167`, `parts_lattice` — read against: reproducing it from the source rather than importing it — surprised: no; rebuilt from scratch in my own scratch directory, giving 3,433 points at r = 2.44, exactly 30 on `|p|² = 4` and 0 on `|p|² = (7+√33)/3`, which is §8.5's required sanity number recovered before any new number of mine was believed
- my own exact glue sweep over those 3,433 points, both circles, controls first — read against: §6's PROVED bullet, that `u` has no unit-distance neighbour in his lattice — surprised: yes, decisively; `u` has 0, but 72 other points of the same circle have one (PH2-3)
- the same sweep, positive control on the record's circle — read against: an instrument that must find glue points where they are known to exist — surprised: yes, in the informative direction; 450 distinct points of `|p|² = 4` have a unit neighbour in `Λ_parts`, 30 are in `Λ_parts` itself at its full Cayley degree 30, against the new circle's best of denominator 42 and degree 1 (PH2-2; my first draft's 14 was a double-counted tangency inside a truncating cut, corrected in that card)
- the same sweep on the antipodal circle `1/(2+2cos θ) = (43−3√33)/97` — read against: the planner's ranking of the brief's falsifier 4 — surprised: yes; 0 glue pairs of 3,433, and the reason is arithmetic and base-free (PH2-5)
- `plans/POROS-2026-09-12-m63-phaseH.md` PH-10, last paragraph — read against: the brief's §2 table treating the record's 30 as evidence about counts — surprised: yes; the record's refusal is inherited, its arena containing Heule-510 certified 5-chromatic before type M was applied, so the one positive data point's count is not evidence that any count is needed (PH2-6)
- `plans/M63-phaseH-a-base-for-a-rotation-RUN.md` §H12 — read against: PH-9's bijection surviving a second reading — surprised: yes, not for the bijection but for what its image is; `p ↦ Rp` is injective and a diagonal pair has no other partner, so the diagonal kind is a perfect matching, and this project already holds a grokking about matchings (PH2-7)
- `CLAUDE.md` § Grokkings G7, G8, G43 and § Frontier FS-22 — read against: the `n`-family of PH2-4 being new — surprised: yes, in the direction that makes it cheaper; both members are already in this repository, `ρ₁₅` and `√ρ₆₃ = (3√7 + i)/8`, and `ρ₆₃`'s field is FS-22's, ranked 10 with bearing "medium"
- `data/m62/rotations-exact-moser-r2.05.json` — read against: my predecessor's standing finding that a second base is already censused for rotations — surprised: unread. Third ledger in a row to list it; PH2-4 gives it the consumer it did not have, since it is a census on a base that is not `Λ_parts`

---

## PH2-1 — the brief's question has the answer "yes, and free", so it is not the phase's difficulty

question: is-the-target-count-achievable-at-all
  evidence: `\|p\|² = N_{K(i)/K}(p₁ + i p₂)`, so the circle is a coset `u·U¹` of the norm-one group of
    `K(i)/K`, which is rationally parametrised by `w = (1+it)/(1−it)`, `t ∈ K` — verified exactly at
    `t = 0, 1, 2, 3, 1/2, 2/3, 5`, every `\|u·w\|² − α = 0`
  expected: §6's UNKNOWN, "whether any module in this field achieves ~30 points on that circle",
    and §8.1's ceiling question, which the brief ranks as literature work
  ask: is the number of points a finitely generated module can put on that circle bounded at all?
  if unbounded: §8.1 cannot stop the mission, no literature bound will, and the brief's stated
    objective is the free half of a two-factor problem
  if bounded: the ceiling is the mission and §8.1 is rank 1
  answered by: derivation
  cost: nil
  rank: 1
  status: answered — unbounded, constructively

**The construction, in five lines.** `ζ₆ = (1 + i√3)/2` has `N(ζ₆) = 1` (checked), so `⟨ζ₆⟩ ⊂ U¹` acts on
the circle, freely, since a rotation by `60k°` fixes no nonzero point. Pick five circle points in distinct
`⟨ζ₆⟩`-cosets — available because `U¹` is infinite and `⟨ζ₆⟩` finite — and let `M` be the `ℤ`-span of their
five orbits. Then `M` is a finitely generated, `ζ₆`-closed module with **≥ 30 points on the circle**, of rank
at most 8, and its all-conjugates cut is finite because a `ℚ`-basis of `K²` maps to an `ℝ`-basis under the
Minkowski embedding. **So ~30 is free.**

**And radius is free too, for a second reason nobody has stated.** `α` is totally positive with conjugate
`(7−√33)/3 ≈ 0.4185`, and **every** point of the circle has exactly those two conjugate radii, `2.0611` and
`0.6469`. So no all-conjugates cut of radius ≥ 2.0612 can ever remove a circle point. The cut is not a
competitor for the count.

**What this does to the brief.** §2's closing question — *can a module in `ℚ(√3,√11)` put ~30 points on the
circle* — is answered **yes** before the session starts. The mission's difficulty is therefore not that
question but the **joint** one: a module that simultaneously carries the circle points and carries
unit-distance structure. §6's own unquantified H6 is named as "probably the binding constraint", and PH2-1
upgrades that from a suspicion to arithmetic: the other factor is provably free, so the binding constraint
is the one that is not.

**Ruling: the brief's §2 objective is not wrong, it is satisfied.** Replace it with the joint quantity.

---

## PH2-2 — the two circles differ by 14× and 42× on everything except the count

question: what-does-the-records-circle-have-that-this-one-lacks
  evidence: my own exact sweep over `Λ_parts(2.44)` (3,433 points, rebuilt from `tools/typem.py`'s
    congruence conditions, not imported), testing for each `λ ≠ 0` whether `D(λ) = α\|λ\|² − c²` with
    `c = (α + \|λ\|² − 1)/2` is a square in `K` — the exact condition for the unit circle about `λ` to meet
    the circle `\|p\|² = α` in `K²`. Every hit verified exactly: `\|p\|² = α` and `\|p − λ\|² = 1`
  expected: PH-8's open question — *what does `ρ₁₅` have that `5/16 − 3/16√33` lacks* — answered in
    terms of counts, since that is what the brief varies
  ask: on one lattice, how do the record's circle and the new circle differ in the quantities a base
    actually has to pay for?
  if they differ most on the count: §2's objective is the mechanism and the brief stands
  if they differ most elsewhere: the count is the coordinate along which they are the same, and
    maximising it is maximising the one thing that cannot separate them
  answered by: derivation, then my own exact arithmetic
  cost: ninety seconds
  hunch: elsewhere — `\|p\|² = 4` is a rational integer and `(7+√33)/3` is not
  falsifier: the new circle's glue points turning out to be as cheap and as attached as the record's
  rank: 3
  status: answered — elsewhere, by more than an order of magnitude; the falsifier did not fire

**The table. One lattice, `Λ_parts(2.44)`, two circles, exact arithmetic, controls below.**

| quantity | record's circle `\|p\|² = 4` | the new circle `\|p\|² = (7+√33)/3` | ratio |
|---|---|---|---|
| points **already in** `Λ_parts` | **30** | **0** | — |
| circle points with ≥ 1 unit neighbour in `Λ_parts` | 450 | 72 | 6.3× |
| — of which lie **in** the module, so carry its full Cayley degree | 30 | **0** | — |
| best unit degree of such a point | **30** | **1** | **30×** |
| cheapest denominator of such a point | **1** | **42** | **42×** |
| squared radius | `4` — a **rational integer** | `(7+√33)/3` — irrational | — |
| `N_{ℚ(√33)/ℚ}(radius²)` | `16` | `16/9` | — |
| points on the circle achievable by a module (PH2-1) | unbounded | **unbounded** | **1×** |

**The last row is the point of the table.** Every other row differs by a factor. The count is the only row
on which the two circles are equal, because on both it is unbounded — and a quantity on which two objects
agree cannot explain why they behave differently.

**The mechanism, and it is embarrassingly simple.** `cos θ = 7/8` gives `1/(2 − 2cos θ) = 4`, so **the
record's diagonal circle is the radius-2 shell of the unit-distance lattice itself.** Its points are `2 ×`
a unit vector; they lie in the lattice at denominator 1, they carry fourteen unit edges each, and there are
thirty of them because the hexagonal lattice's own second shell is there to be counted. The new angle's
diagonal circle is at an irrational squared radius that no cheap lattice shell sits on, and its best
available point is a denominator-42 vertex of unit degree 1.

**Two numbers in the row above were wrong in my first draft, both in the flattering direction, and the
mechanism is worth more than the fix.** I first printed **14**, from my sweep's per-point hit count. Two
faults, compounding: my sweep appended both roots `±s` even when `D(λ) = 0`, so a **tangency was
double-counted**, and the count was taken inside the `r = 2.44` cut, which **truncates the neighbourhood of
a radius-2 point**. Measured directly: those six points have unit degree **13** inside `r = 2.44` and
**30** inside `r = 3.05`. And 30 is not a coincidence — it is `|S|`, the **norm-1 shell count of `Λ_parts`**
(measured 30 at both radii), which the planner supplied and I verified: on a `ℤ`-module the unit-distance
graph is the **Cayley graph** with connector set `S = {v ∈ M : |v|² = 1}`, so **every module point has
degree exactly `|S|`** — this repository already holds it as `addCayleyMap` (ledger row 56,
`LocalGlobal.lean`; prior art `[Moorhouse2010]` §4.2, `[CervantesKrebs2023]`).

So the row is not a degree measurement at all, and the honest statement is stronger than the one I made:
**the record's 30 circle points are IN the module and therefore carry its full degree 30; the new circle
has none in any module of that coarseness, and its best outside point carries 1.** My 14 was a
double-counted truncation of that 30. Both faults inflated the record's side — the direction that makes the
target look explicable — which is `CLAUDE.md` G21 exactly, in my own instrument, inside an hour of my
writing a card about other people's.

**Unit degree 1 is the number that should end the "count" framing.** A vertex with one unit neighbour and one
diagonal cross edge has degree 2 in a four-colouring problem; by this repository's own absorption theorem
(G40, `Absorb.lean`) it carries no compulsion whatever — every colouring of the rest extends to it. Thirty
such vertices carry thirty times nothing.

**Controls, both directions, before any of this was believed.** The square-root-in-`K` routine was tested on
eight values with the expected verdict stated first, four findable and four not, including `2` (not a square
in `K`) and `202 − 22√33` (PH2-5) — 8 of 8 agree. The sweep's positive control is the record's circle, where
it must and does find hits. And the instrument reproduces, independently, **3,433 lattice points, 30 on
`\|p\|² = 4`, 0 on the new circle** — which is exactly §8.5's mandated known-answer check, so it was passed
before rather than after.

---

## PH2-3 — §6's first PROVED bullet has a proved premise and an unproved consequence, and the consequence is where the money is

question: is-the-whole-translate-requirement-a-consequence-of-the-exhaustive-search
  evidence: §6, bullet 1: "`u` has **no unit-distance neighbour in his lattice at any radius** —
    exhaustive… **Consequence: a base for this rotation is his lattice plus at least one whole translate
    of it.**" Both halves under one `PROVED` stamp
  expected: a consequence that follows from the premise above it
  ask: does "his lattice plus a whole translate" follow from `u` having no neighbour, or from something
    else — and is the exhaustive search's zero a fact about the circle or about `u`?
  if from something else: the stamp is covering an inference the search does not support, and the
    search's real subject is §6's unquantified H6, where its answer is not zero
  if from the premise: the bullet stands
  answered by: derivation, then my own exact sweep
  cost: nil to see, ninety seconds to count
  rank: 7
  status: answered — from something else, and the search's answer is 72, not 0

**The consequence does not come from the premise.** Any `ℤ`-module containing `Λ_parts` and any point
`p ∉ Λ_parts` contains `Λ_parts + ℤp ⊇ Λ_parts + p`, a whole translate. That is module structure, true for
every `p`, and `u`'s zero neighbours are not used. The consequence is sound; its stated derivation is not,
and the difference is not pedantry, because it hides what the search actually measured.

**What the search actually measured, extended from one representative to the circle.** `u` has no unit
neighbour in `Λ_parts` — I reproduce that, 0 at radius 2.44. But **72 other points of the same circle have
one**, exactly one each, at denominators 42 (24 points) and 84 (48 points). The brief's §9 already adopted
*vary the representative, not the module*; the exhaustive search was never re-run under that instruction, and
§6 still carries its `u`-specific zero as though it were a property of the rotation.

**Honest scope, stated because it is the half that decides the value.** 72 > 0 is a real improvement in kind
— a circle point attached to existing material rather than hanging off a translate — and it is **not** a cost
saving: denominator 42 against `u`'s 6 makes those representatives *finer*, not coarser, and unit degree 1
makes them absorbed (G40). So this card does not hand the phase a cheaper base. It hands it the correct
reading of the search: **the phase's hard requirement is attachment, and on this circle the best attachment
available anywhere is one edge.** That is PH2-2's 14× stated as a theorem about the circle rather than a
table.

---

## PH2-4 — the record is the n = 4 member of a one-integer family whose n = 16 member is 6-open

question: is-the-rotation-the-right-thing-to-hold-fixed
  evidence: `data/m62/m63-phaseG-screen-r2.44.json` — **one of eleven classes has a rational cosine,
    `−7/8`, and it is the only `unsat`.** And `1/(2 − 2cos θ) = n` forces `cos θ = (2n−1)/(2n)` and
    `sin θ = √(4n−1)/(2n)`: at `n = 4`, `R = (7 + i√15)/8 = ρ₁₅`; at `n = 16`,
    `R = (31 + 3i√7)/32 = ρ₆₃`, whose square root `(3√7 + i)/8` is one of G8's four generators of de
    Grey's direction group
  expected: nothing — no document in the phase groups the eleven rotations by the arithmetic of their
    diagonal radius
  ask: should the phase hold the rotation fixed and search modules, or hold the module family fixed and
    sweep the rotation by the integer `n = 1/(2 − 2cos θ)`?
  if the integer: the search is a one-parameter sweep with two members already in this repository, and
    the 2-adic wall and 6-openness are congruence tests on `4n − 1`
  if the module: the brief's shape stands and this card is a coincidence of two data points
  answered by: derivation, verified against `CLAUDE.md` G7, G8, G43 and FS-22
  cost: nil
  hunch: the integer — the family's formula reproduces two independently recorded objects of this
    repository from one integer each, which could have failed and did not
  falsifier: a member of the family that fails phase G's liveness or 2-adic screen for a reason the
    congruence on `4n − 1` does not see — which is the open half of this card
  rank: 4
  status: open — the addressee is the product owner, because it changes the product

**The family, swept to `n ≤ 120` (Loeschian `n`, so the circle is a shell of the hexagonal lattice).**
Wall broken iff `4n − 1 ≡ 7 (mod 8)` iff **`n` even**; 6-open iff additionally the squarefree part of
`4n − 1` is a non-residue mod 11 (G43).

| `n` | `cos θ` | radius | `4n−1` | squarefree | wall | 11 inert | **6-open** | what it is |
|---|---|---|---|---|---|---|---|---|
| 1 | `1/2` | 1 | 3 | 3 | no | no | no | `θ = 60°`, no new field |
| 3 | `5/6` | 1.732 | 11 | 11 | no | — | no | `sin θ = √11/6 ∈ K` |
| **4** | **`7/8`** | **2** | 15 | 15 | **YES** | no | no | **`ρ₁₅` — the record, 5-sealed** |
| 9 | `17/18` | 3 | 35 | 35 | no | YES | no | keeps the wall (G43) |
| 12 | `23/24` | 3.464 | 47 | 47 | YES | no | no | 5-sealed |
| **16** | **`31/32`** | **4** | 63 | **7** | **YES** | **YES** | **YES** | **`ρ₆₃`, field FS-22's `ℚ(√3,√7,√11)`** |
| 52 | `103/104` | 7.211 | 207 | 23 | YES | no | no | `√23`, G47's residue-allowed distance |
| **64** | `127/128` | **8** | 255 | 255 | **YES** | **YES** | **YES** | the second 6-open member |
| 76, 108, 112 | — | 8.7 … 10.6 | — | 303, 431, 447 | YES | YES | YES | the next 6-open members |

**A uniqueness claim of mine was wrong TWICE, and the second time was in the repair.** I first wrote "the
unique 6-open member at radius ≤ 8"; `n = 64` sits at radius exactly 8 and is 6-open, and my own sweep had
printed it. The planner caught it and I repaired it to "radius ≤ 4" — **also false**: re-indexing by `n`
rather than by `√n`, the 6-open members with `n ≤ 31` are **n = 2, 10, 16, 20, 22, 24**, of which
**three (n = 2, 10, 16) sit at radius ≤ 4.** Both errors have one cause, and it is the same restriction
PH2-10 already caught in a different sentence: **I swept only Loeschian `n`**, which silently excluded every
6-open member whose circle is not a hexagonal shell — five of the six. Correcting the parenthetical did not
propagate to the claim built on it, which is the durable lesson here: *a wrong restriction produces more
than one wrong claim, and fixing the one you noticed does not fix the others.*

**The statement with no radius in it at all**, because radius is not what a base pays — `radius⁴ / covolume`
is, and the free-circle condition is exactly what makes the circle cost nothing:

> Among `cos θ = (2n−1)/(2n)`: **the circle is free iff `n = t²` with `t ∈ ℤ`** (then `t·v` is a circle
> point for every unit vector `v`, so the count is ≥ `|S|` on any base, with no design); **the field is
> 6-open iff `n` is even and `squarefree(4n−1)` is a non-residue mod 11.** The two conditions are
> independent. **`n = 16` (`t = 4`) is the smallest `n` meeting both, and `n = 64` (`t = 8`) is the next.**
> Members meeting only 6-openness — `n = 2, 10, 20, 22, 24` at `n ≤ 31` — are **live design targets, not
> free ones**, and `n = 2` is the cheapest circle of the entire family (integer witness `(1,1)`).

**And the ramified gap is not a rarity.** `11` divides the radicand at `n = 3, 14, 25` — **3 of the first
31** — so G43's inert-versus-split criterion is silent on about a tenth of the family, not on a curiosity.

**One alarm of mine, raised and then resolved in both directions.** The planner measured `ρ₆₃`'s cross set
as `126 = 60 centre + 36 off-diagonal + 30 equal-radius` — *the record's exact decomposition at a new
parameter*, which is the single most flattering output a derived law can produce, and `CLAUDE.md`'s
measured-versus-derived asymmetry says a refusal built on invented edges reads as success. But **90 of the
126 are forced by `|S| = 30` alone and need no law**: the centre family is exactly `2|S|` (the shared centre
`0` joins `Rv` for each unit `v`, and `p` joins `R0 = 0` for each unit `p`), and the equal-radius family is
exactly `|S|` when `n = t²`. **Only the 36 off-diagonal edges are law-dependent.** So the coincidence is
explained rather than suspicious, and his gating control sharpens: predict 60 and 30 from `|S|` *before* the
recount as a two-sided control, and recount **36**, not 126.

**And a third case the rule does not cover.** At `n = 36` the radicand is `143 = 11 · 13`, so **11 divides
it and ramifies** rather than being inert or split. G43's criterion is stated for inert-versus-split and is
silent here; I have marked it `no` above, which is a guess, not a reading. One line for whoever owns G43.

**Three things this is, in decreasing confidence.**

1. **A control that passed.** One integer reproduces `ρ₁₅` and `ρ₆₃` exactly, both recorded in this
   repository for independent reasons. `[derived, verified]`
2. **An explanation of PH2-2.** The family's circle radius is `√n`, a lattice shell by construction, so
   *every* member's diagonal circle is cheap, full and attached — which is what the record has and the
   phase's rotation does not. The phase's rotation is not in this family: its `1/(2−2cos θ)` is irrational.
3. **A product question, which is the product owner's.** `ρ₁₅`'s field `K(√15)` is **5-sealed** and
   FS-30 records that nothing on either of the phase's bases is 6-open. So **a success in phase H2 delivers
   a new 5-chromatic object — the M62 record goal — and not a rung toward `χ ≥ 6`.** `n = 16` is the unique
   6-open member **whose circle is free** (see the corrected statement below), its rotation is already one of
   G8's generators, and its field is already
   ranked as FS-22. **Its price, corrected twice by the planner and re-derived here:** `Λ_parts` has `ℤ`-rank
   **4**, not 8 (my predecessor's own PH-3 — it sits in a 4-dimensional `ℚ`-subspace of `K²`), so its cut
   scales as `r⁴`, not `r⁸`. I priced it at `r⁸`: ≈ 52×, ≈ 179,000 points, ≈ 358,000 vertices. **Wrong.**
   Correct: `(4.04/2.44)⁴ ≈ 7.5×`, so ≈ **25,000 base points and a ≈ 50,000-vertex arena** — about 7× the
   record's, which this project's solver side handles routinely. His calibration confirms the exponent:
   8,347 measured at `r = 3.05` against an `r⁴` prediction of 7,827.
   **The ruling changes, so it is re-derived rather than quietly passed:** at 358,000 vertices `ρ₆₃` was a
   later milestone; at 50,000 it is the **cheapest promising item in the phase**, and the planner has moved
   it to the top of his queue on that ground. I agree with the move and the credit is his.

**Offered in the hypothetical mood, and here is what would kill it.** I have not checked that `ρ₆₃` passes
phase G's liveness criterion or its 2-adic filter on any base, nor that a radius-4 base is solvable in
practice, nor that the cross-edge set at `n = 16` is non-degenerate. Any of those fails and the card is a
pretty coincidence. **What it is not is a reason to stop phase H2** — `n = 16` is a different milestone with
a different price, and switching to it is a change of product that only the product owner makes.

---

## PH2-5 — the antipodal circle dies on a denominator, and the same one line prices every λ

question: is-the-free-lambda-equals-minus-one-kind-affordable
  evidence: `2 + 2cos θ = (43 + 3√33)/16`, whose rational norm is `1552/256 = 97/16`, against
    `2 − 2cos θ = (21 − 3√33)/16` with norm `144/256 = 9/16`. And my sweep: **0 of 3,433 lattice points
    have a unit neighbour on the antipodal circle**, against 72 on the diagonal circle
  expected: the planner's reading, that the denominator 97 "is a much uglier denominator" and might
    wreck the covolume — a worry, not a verdict
  ask: does the prime 97 in `1/(2 + 2cos θ)` force itself into every representative's denominator?
  if it does: the antipodal route is priced dead before any module is built, and the same one-line
    computation prices every `λ` in the planner's enumeration
  if it does not: the antipodal circle's small radius (0.5154, deep inside any cut) makes it the
    cheapest kind available and it belongs at the top of the queue
  answered by: derivation
  cost: nil
  rank: 6
  status: answered — it does, and the line generalises

**The derivation, three lines.** Let `𝔮` be a prime of `K` above 97. `v_𝔮(43 − 3√33) = 0` (its norm is
`1552 = 16·97`, so 97 divides the norm once per prime above it — checked: `43² − 9·33 = 1552`), so
`v_𝔮(1/(2+2cos θ)) < 0`. If `p ∈ K²` lies on that circle then `v_𝔮(p₁² + p₂²) < 0`, so
`min(v_𝔮(p₁), v_𝔮(p₂)) < 0`: **every K-point of the antipodal circle carries 97 in a coordinate
denominator.** A module containing one is finer than `Λ_parts` (denominator 12) by a factor of 97 in that
direction, and its cut count scales inversely with covolume. The planner's worry (b) is confirmed, and it is
forced rather than incidental.

**The instrument this hands the planner, which is worth more than the verdict.** For every `λ`,
`a(λ) = 1/(λ² − 2λ cos θ + 1)`, and `N_{ℚ(√33)/ℚ}(a(λ))` is one line of exact arithmetic. Its **denominator's
prime factors are forced into every representative on that circle**, hence into the module, hence into the
covolume. So the planner's λ-enumeration can be ranked **before any module is built, by a rational norm**:

> `λ = 1`: `N = 16/9` — smooth, denominators 2, 3, 6. `λ = −1`: `N = 16/97` — a prime that no base can shed.

The record's own value is `N(4) = 16`, an integer: the smoothest possible, which is PH2-2's mechanism seen
from the arithmetic side rather than the geometric one.

**Honest gap.** I have **not** decided whether the antipodal circle has any `K`-point at all — the planner's
question (a). I reduced it: `a` is a norm from `K(i)` iff `sin²θ` is, iff **`101 − 11√33` is a sum of two
squares in `K`** (using that `α`, `3 = (√3)² + 0²` and `2 = N(1+i)` are all norms, and norms form a group).
That is one Hilbert-symbol computation at the primes above 2 and 97, and I did not run it. It does not change
the ranking: 0 unit contacts and a forced 97 settle the route either way.

---

## PH2-6 — the calibration is n = 1, not n = 2, because the positive instance refuses for an external reason

question: what-is-the-reference-class-for-a-count-threshold
  evidence: PH-10's closing paragraph — `ρ₁₅`'s arena at radius 2.44 **contains Heule-510**, certified
    5-chromatic (`chromaticNumber_heule510`, ledger row 53) **before** type M is applied, with 375 of its
    510 vertices in the base and 136 on the rotated copy (`plans/M62-evolutionary-type-m.md:845`)
  expected: §2's table read as three comparable data points, 30 / 18 / 8
  ask: is the record's 30 evidence that a count near 30 is needed?
  if no: §6's UNKNOWN ("30 refuses and 18 does not — two data points and not a threshold") is
    generous; there is **one** refusal and its cause is known and is not the count
  if yes: the threshold question is well posed and §8.2's interpolation is the right experiment
  answered by: the record
  cost: nil
  rank: 5
  status: answered — no; and the controlled version of §8.2 needs no base at all

**Two data points become one and a half.** The only refusing arena contains an object whose 5-chromaticity
was certified elsewhere, so its cross-edge count is a property of a base rich enough to contain Heule-510,
not a threshold. **No type-M arena has ever been shown to *produce* five-chromaticity rather than to
*contain* it** (§H13's own sentence, which the phase should carry).

**And §8.2 is mis-priced, which is the cheapest thing in this ledger.** §8.2 proposes *building* a base at
count 20–24 to test the threshold. The same interpolation is available by **deleting** diagonal cross edges
from the record's own arena, which is committed and solves in 10.7 s:

> Thin `ρ₁₅`'s diagonal matching from 30 down to `k` and re-solve. Both outcomes are informative and both
> are reachable. Still UNSAT at `k = 8`: the count is refuted as the objective, on the phase's own positive
> instance, at exactly the count stage 1 achieved. First SAT at some `k`: the phase has a measured threshold
> where it currently has an anecdote.

It varies **only** the count, holding base, radius, kinds and tooling fixed — a controlled experiment where
§8.2's is confounded — for one solver run per point against one module construction. Sample several subsets
per `k`, include one closed under negation and the flips to match stage 1's 8, and state the sampling beside
the curve. **Cheaper still and first, with no solver: how many of Heule-510's 2,504 edges are cross edges of
that arena, and how many of those are the equal-radius 30?** That is an intersection of two committed vertex
lists. If the answer is small, the record's 30 were never load-bearing.

**Credit where it is due: the planner reached the deletion experiment independently and in a wider form
(all 126 cross edges, greedily).** Run both, his second: the all-cross-edge version measures which *kinds*
carry the refusal, which is confounded for the brief's question; the diagonal-only version is the brief's own
variable and is the one that can retire §2.

---

## PH2-7 — the diagonal kind is a perfect matching, and its contribution saturates at four

question: what-is-the-graph-theoretic-shape-of-the-quantity-being-maximised
  evidence: §H12's verified bijection — the base has 8 points on the circle and 8 diagonal cross edges,
    one each; `Λ_parts` has 30 and 30. The map is `p ↦ Rp`, injective, and a diagonal pair has no other
    partner (`λ = 1` is the coincident root of `λ² − 2λcos θ + (1 − 1/n)`, PH-7)
  expected: a count of edges, per §2
  ask: what is the subgraph those edges form, and does this project already hold a result about that shape?
  if a matching: G14 applies — "a matching is 1-regular and carries no colour pressure, even composed
    into forced-rainbow triangles" — and the phase is maximising the size of the one structure this
    repository has already measured to be inert
  if something denser: the count is a degree-like quantity and §2's objective has a mechanism
  answered by: derivation, against `CLAUDE.md` G14 and G46
  cost: nil
  hunch: a matching, and its whole contribution is a condition on colour classes rather than on points
  falsifier: a diagonal cross edge sharing an endpoint with another diagonal cross edge
  rank: 8
  status: answered — a perfect matching between the circle points and their images

**A matching, and this project already knows what matchings do.** G14, `[measured + derivation]`: *"Width
without degree does not force… A matching is 1-regular and carries no colour pressure, even composed into
forced-rainbow triangles."* §2 proposes to maximise the size of a matching.

**The sharper form, offered as a construction.** By G46 the rotated half carries the same index set and the
same internal edge list, and the residue colouring colours a rotated point by `φ` of its preimage — so a
colouring of the arena can be written as a pair `(C, π∘C)` for `C` proper on the base and `π` a permutation
of the four colours. Then:

- a **diagonal** edge `(p, Rp)` needs `π(C(p)) ≠ C(p)` — a condition on the **colour class** of `p`, not on `p`;
- the **shared centre** needs `π(C(0)) = C(0)`.

So the diagonal kind's entire contribution to unsatisfiability, within this family, is *"π must move every
colour occurring on the circle and fix the centre's"* — **at most four conditions, however many points the
circle carries.** The 9th through 30th circle point add nothing to it. And stage 1's base already has the
one circle-point residue that makes the condition unsatisfiable: `φ(u) = (0,0) = φ(0)` at both primes
(my predecessor's inventory), so no `π` fixing the centre can move it. **Stage 1 has already extracted
everything the diagonal kind can give against this family, with 8 points.**

**What this is and is not — restated after the planner pushed, and his framing is better than mine.** He
objected that the record's actual refusal is **not** in the `(C, π∘C)` family — it is Heule-510, which is
not a colour-twist of a base colouring — so a bound proved inside that family may be a bound about a family
the answer never lived in. He is right, and the card is corrected to carry his wording rather than mine:

> This is **not** a bound on the count. It is **a large sufficient family in which the count is nearly
> worthless** — large because it contains all 24 colour-twists of every proper base colouring — **so
> whatever value the count has must come from outside that family.** And the one refusal anyone holds is
> outside it, which is consistent and is not evidence either way.

That is weaker than what I wrote and it is what the derivation supports. Silence is not evidence: the
family's failure proves nothing. What survives is the replacement lever it names — **which residues the
circle's points carry, not how many points there are.** The additive
sub-family `π = (+c)` is exactly the residue certificate, and the shared centre forces `c = 0` — which is why
the certificate has only one free `δ` to lose. That is a small structural explanation of §H12's theorem that
the phase did not have.

---

## PH2-8 — the near miss, and the check the mission was one square away from not surviving

question: is-the-rotation-K-rational
  evidence: `cos θ = 11/32 + (3/32)√33 ∈ ℚ(√33) ⊂ K`, and
    `sin²θ = (303 − 33√33)/512 = 3(101 − 11√33)/512`
  expected: nothing; no document in the phase names the field the arena lives in
  ask: is `sin θ ∈ K`?
  if yes: `R ∈ K(i)`, the whole arena lies in `K²`, and `chromaticNumber_seamPlane` (`χ(K²) = 4`,
    kernel-checked, ledger row 57) four-colours **every** base for this rotation. The mission is over
    by a theorem the repository already holds, and no count can help
  if no: the arena's field is a genuine extension, the mission survives, and the extension should be
    named in the record because it is the wall-breaking radicand this rotation supplies
  answered by: derivation, then exact arithmetic
  cost: nil
  hunch: no — a 5-chromatic object must break the 2-adic wall (G1), and the phase's rotation was
    selected by a 2-adic filter it passed
  falsifier: `202 − 22√33` turning out to be a square in `ℚ(√33)`
  rank: 9
  status: answered — no, and the check was worth running

**Twice, independently.** `K = ℚ(√33) ⊕ ℚ(√33)·√3`, so an element whose square lies in `ℚ(√33)` is either in
`ℚ(√33)` or of the form `q√3`. `sin θ ∉ ℚ(√33)` (its square is not a square there), so `sin θ ∈ K` iff
`sin²θ/3 = (101 − 11√33)/512` is a square in `ℚ(√33)`, iff `202 − 22√33` is. Setting
`(m + n√33)² = 202 − 22√33` gives `mn = −11` and `m² + 33n² = 202`, hence `33n⁴ − 202n² + 121 = 0` with
discriminant `24832 = 2⁸·97` — **not a rational square, so no rational solution.** My independent exact
square-root routine returns `none` on `202 − 22√33`, as one of its eight stated controls.

**So the arena's field is `K(√(202 − 22√33))`, and 97 appears again** — necessarily, since
`(2 − 2cos θ)(2 + 2cos θ) = 4sin²θ` ties `sin θ`'s radicand to the antipodal circle's norm (PH2-5). The
minimal polynomial `4096x⁴ − 4848x² + 873` has constant term `873 = 9·97`, which is the same 97 a third time.

**Why this card exists even though it answered "no".** The uninformative outcome was the survival of the
mission and the informative one was its end, and the informative one was **reachable**: had the phase's
2-adic filter been one step weaker, or the angle one member over, a whole session would have been spent
hunting a base for a rotation whose every arena is four-colourable by a theorem in `CLAUDE.md`. **The family
of PH2-4 contains three such members at `n ≤ 9`** — `n = 1, 3, 7` all have `sin θ ∈ K`. Any rotation sweep
must screen `sin θ ∈ K` first, and it costs one square test.

**And the record should name the field.** No document in phase G, H or H2 states what field the new
rotation's arena lives in. It is a one-line fact, it is this rotation's wall-breaking radicand, and FS-30's
"nothing on either base is 6-open" is a statement about it that is currently held without its subject
written down.

---

## PH2-9 — the joint quantity, priced from both sides, and the number the brief was missing

question: what-does-the-target-actually-cost-once-unit-structure-is-required
  evidence: three independent measurements from tonight's three agents. **PH2-1 (mine, derived):** ~30 on
    the circle is free for *some* finitely generated module. **The prior-art agent (measured, exhaustive
    over `O_K + O_K`):** the count obeys `≤ |U_M| · ∏_{split 𝔭} (v_𝔭(α_eff) + 1)`, zero unless `v_𝔭` is
    even at every inert 𝔭 — never violated on thirteen exact counts, tight at three — and on a module of
    `Λ_parts`'s coarseness the new circle is capped at **18** against the record's 30, with the factor
    recoverable only by one more `√3` in the denominator, i.e. **81× the arena at equal radius**.
    **The planner (measured):** a module realising 36 circle points has rank 8, covolume 42.49, a cut of
    3,037 — and **0 points of norm 1, hence 0 unit edges**
  expected: §2's single-factor objective, and §6's H6 recorded as "unquantified by anyone"
  ask: with unit structure required, what is the real price of the brief's target?
  if it is a large fixed factor: §2's objective is not wrong, it is unaffordable at the phase's radius,
    and the phase's budget should move to a rotation whose circle is cheap
  if it is small: the brief stands and the queue should build
  answered by: derivation, then the other two agents' exact counts
  cost: nil to assemble
  rank: 2
  status: answered — and it stands jointly with PH2-1 and PH2-2, which were reaching for it — a factor of 81 at equal radius, and H6 is not unquantified

**The three facts compose into one sentence, and it is the phase's answer.**

> **~30 on that circle is free if you abandon unit-distance structure; at `Λ_parts`'s coarseness the circle
> is capped at 18; and buying the missing factor costs 81× the arena at equal radius.** The brief optimises
> a quantity that is free at one end of that trade and unaffordable at the other, and states neither end.

**H6 is not unquantified, and this is the durable part.** On a `ℤ`-module the unit-distance graph is the
Cayley graph with connector set `S = {v ∈ M : \|v\|² = 1}` (ledger row 56's `addCayleyMap`), so **"enough
unit-distance structure" is exactly the norm-1 shell count `\|S\|`** — every module point has degree `\|S\|`,
and `\|S\| = 0` means an edgeless base however many circle points it holds. `Λ_parts` has `\|S\| = 30`
(measured at both radii). So the phase's two requirements are **two shell counts of the same module** — the
norm-1 shell and the norm-α shell — and §6's H6 and §2's objective are the same kind of quantity, which is
why they trade against each other: both are driven by the arithmetic of the value, and `1` is maximally
smooth while `(7+√33)/3` is not.

**A positive control nobody fitted.** The prior-art agent's bound gives 18 for the new circle at
`Λ_parts`'s coarseness. **The brief's own second row is 18** — the colourable reference class, a *different*
circle, whose squared radius the planner computed as `(7+√33)/6 = α/2`, and 2 is a unit at the prime above 3
so the bound is the same. So his bound **retro-predicts a number in the brief's table that he did not fit
it to.** That could have failed and did not, and it is the only out-of-sample check any of tonight's
arithmetic has had. Worth one line to confirm the two 18s are the same mechanism rather than a coincidence;
if they are, the brief's own table is evidence *for* the bound and *against* the objective built on it.

**What I got wrong, and then what he got wrong, and the second repair is the useful one.** I told the
prior-art agent that the Hilbert-modular rooms "will hand you a formula driven by the ideal factorisation
of α". He measured it false — `f(3) = 4` against a divisor prediction of 36, and `f/4` not multiplicative
across 3 and 4 — and then **corrected his own refutation**: his module was `O_k + i·O_k`, a **non-maximal
order**, not the ring of integers of `K(i)`. On the maximal order (discriminant `2⁸·3⁴·11⁴`, matching the
conductor–discriminant prediction) the formula is **exact at every point he tested**: 12, 12, 36, 12 against
predictions 12, 12, 36, 12. So the standing statement is:

> **exact on the maximal order; false on a sub-order**, where principality and the partial intersection of
> the `μ₁₂`-orbits with the sub-order break it; and the **bound**
> `count ≤ |U_M| · ∏_{split 𝔭} (v_𝔭 + 1)`, zero unless `v_𝔭` is even at every inert 𝔭, **survives for every
> module.** The out-of-sample 18 above stands.

**And the warning survives with its target sharpened, which is why this matters to the phase rather than to
the bibliography: a sub-order is exactly what every base in this milestone is.** `Λ_parts` is a rank-4
congruence lattice, not a ring of integers. So on the objects this phase actually builds, **a divisor
formula predicting circle counts is wrong in the OPTIMISTIC direction** and only an exhaustive count is
safe — and the reason is now named (non-maximality) instead of being attributed to the theorem.

**The formula is prior art, in the room I asked him to raise, and the find is his.** Baake & Grimm, *A note
on shelling*, Discrete Comput. Geom. **30** (2003) 573–589 (arXiv:math/0203025): Theorem 1 and Corollary 1
give the central shelling count as `N · ∏_{split} (v + 1)`, zero unless every inert prime occurs to an even
power, and the Remark after the proof extends it verbatim to a totally complex extension of a totally real
field **whenever the class number is one**, with prefactor the number of units on the unit circle — our case
with `N = 12`, agreeing with the `μ₁₂` I derived from Kronecker. **One hypothesis to check before the phase
leans on it: is `h(ℚ(√3,√11,i)) = 1`?** The Remark requires it and neither of us has read it; a theorem
invoked with its hypotheses unchecked is this suite's own named smell. Recorded as an open item, not as a
tool.

---

## PH2-10 — what kills `n = 2`: not emptiness, and not the family — it is not a perfect square

question: what-kills-n-equals-2
  evidence: the product owner's screen of the family puts `n = 2` at radius 1.4142 with radicand 7,
    wall broken, 11 inert, **6-open**, endpoint bound `4/√7 = 1.5119` — 73% of the record's — and his
    first guess that its circle is empty because 2 is not `a² + ab + b²`
  expected: his guess — the circle `\|p\|² = 2` empty in the field
  ask: is the circle empty, and if not, what separates `n = 2` from `n = 4` and `n = 16`?
  if empty: `n = 2` dies on arithmetic and the family reduces to the shells of the lattice
  if not empty: the kill is elsewhere, and where it is decides whether the phase's cheapest 6-open
    member is alive
  answered by: derivation, then my own exact arithmetic
  cost: minutes
  hunch: not empty — `2 = 1² + 1²`
  falsifier: no `K`-point on `\|p\|² = 2`
  rank: 10
  status: answered — the guess is wrong twice over, and the real separator is squareness

**His guess is wrong, and in the direction that makes `n = 2` more interesting rather than less.**
`2 = 1² + 1²`, so **`(1,1)` is on the circle, in `K²`, at denominator 1** — and `x² + y² = 2` has
infinitely many rational points, so this is the most rationally accessible circle in the whole family.
Measured against `Λ_parts(2.44)`: **180 distinct points of `\|p\|² = 2` have a unit neighbour**, with
denominator spectrum `{1: 4, 2: 8, 6: 16, 10: 8, 12: 32, 15: 16, 20: 16, 30: 48, 60: 32}`. The four at
denominator 1 are `(±1, ±1)`, and each is at unit distance from `(1,0) ∈ Λ_parts`. Against the phase's own
rotation — 72 glue points, cheapest denominator **42** — `n = 2`'s circle is better material by a factor
of 42 in denominator and 2.5 in count.

**What his guess got right, and it is not the same thing.** The shell **over `Λ_parts`** is empty: exactly
**0 of 3,433** at `\|p\|² = 2`. Rational shell counts measured: **n = 1: 30, n = 2: 0, n = 3: 42,
n = 4: 30, n = 5: 60, n = 6: 0.** So the hexagonal reading is the right instinct at the wrong level — and
note **n = 5 is non-Loeschian and has 60 points**, which refutes my own PH2-4 parenthetical ("Loeschian
`n`, so the circle is a shell of the hexagonal lattice"): that is the `b = d = 0` slice, `Λ_parts` is
strictly bigger, and the screener is right to enumerate rather than assume. The clean sub-theorem that does
hold: **the hexagonal plane `{(x, y√3)}` never represents 2** — `x² + 3y² = 2` has no rational solution
because 2 is inert in `ℚ(√−3)` (`−3 ≡ 5 mod 8`) and `v₂(2) = 1` is odd — so no refinement of a hexagonal
lattice, at any scale or radius, ever puts a point on that circle. The pattern on this data is
`v₂(n)` odd ⟹ empty over `Λ_parts` (2 and 6 empty, 1, 3, 4, 5 not); that is a hunch, not a derivation.

**The real separator, and it corrects the family as all four of us have been stating it.** For
`n = t²` with `t` a positive **integer**, `p = t·v` with `\|v\| = 1` gives
`\|p − Rp\| = t·√(2 − 2cos θ) = t·(1/t) = 1` exactly — checked at `t = 2, 3, 4`. So **every unit vector
of the base yields a diagonal cross edge for free, and the diagonal count is ≥ `\|S\|` on any base, with
no design and no search.** `n = 2` and `n = 20` are not perfect squares and get nothing free.

> **The free-circle family is `n = t²`, `t ∈ ℤ`: `cos θ = (2t² − 1)/(2t²)`, radicand `4t² − 1`, circle
> radius `t`, diagonal count ≥ `\|S\|` always.** `t = 1` dead (`√3 ∈ K`); `t = 2` = `ρ₁₅`, the record,
> 5-sealed; `t = 3` dead (wall stands); **`t = 4` = `ρ₆₃`, 6-open, radius 4 — the smallest 6-open member
> with a free circle**; `t = 5` dead (`√11 ∈ K`); `t = 8` 6-open at radius 8.

My own "Loeschian `n`" was wrong; the planner's "`t ∈ K`" is right in form but `t`-closure costs unless
`t ∈ ℤ` (my PH2-5 pricer, applied to `t` instead of `λ`); the product owner's table lists non-squares as
members.

**So `n = 2` is not killed, and the live risk is his second guess.** Its endpoint bound is 1.5119 and
`Λ_parts(1.5119)` holds **499** points, so the whole cross-edge-bearing arena is ≈ **1,000 vertices**
against a 509-vertex record that was *reduced* from a 3,433-point base. Material beyond 1.5119 carries no
cross edge and is absorbed (G40), so thinness cannot be bought with radius — only with a finer module,
which is the covolume trade. **`n = 2` is alive, 6-open, cheap, and probably too thin — and "probably too
thin" is measurable**: the unit-edge count inside radius 1.5119, reported beside the circle count. That
column costs the screener nothing and it decides the member.

---

## PH2-11 — `n = 2` was never in phase G's census, and the reason it was excluded is why it now looks good

question: was-n-equals-2-already-tested
  evidence: `data/m62/m63-phaseG-screen-r2.44.json`, the `cos` field of all eleven classes, read exactly:
    `−7/8`, `−11/32 − (3/32)√33`, `−13/16 − (1/48)√33`, `−23/8 + (3/8)√33`, `−29/32 + (3/32)√33`,
    `−(5/33)√33`, `−7/8 + (1/24)√33`, `−9/8 + (1/24)√33`, `23/32 − (9/32)√33`, `31/64 − (15/64)√33`,
    `5/16 − (3/16)√33`. `n = 2` requires `cos θ = ±3/4`
  expected: the prior-art agent's registered prediction, either way — if `n = 2` is in the census it is a
    closed row and his result is a reproduction; if not it is the phase's new top item
  ask: is `cos θ = ±3/4` among phase G's eleven rotation classes?
  if present: `n = 2` is already screened and the arithmetic case for it must be reconciled with a
    recorded verdict
  if absent: the member with a 6-open field and an integer point on its circle was never tested, and the
    reason it was skipped is itself the finding
  answered by: the record
  cost: nil
  rank: 11
  status: answered — **absent**, and the exclusion is diagnosable

**`±3/4` is not there.** Exactly **one** of the eleven classes has a rational cosine — `−7/8`, which is
`ρ₁₅` at the sign representative PH-8 established as the meaningful one — and no other member of the family
appears at all. **`n = 2` was never tested.**

**Why it was skipped, which is the part worth keeping.** The census was *enumerated on `Λ_parts`*, and I
measured `Λ_parts`'s shell at `\|p\|² = 2` to be **0 of 3,433** (PH2-10). A rotation whose circle is empty
over the enumerating base produces no equal-radius kind there and never becomes a candidate. So the single
member of the family whose field is **6-open** and whose circle carries an **integer** point, `(1,1)`, was
excluded by the base the list was computed on.

**That is FS-30's own recorded fault firing a second time, on a second object.** FS-30 already says of the
rotation list that *"the list was computed on the wrong base"*. Here the same base-dependence did not merely
mis-count a rotation, it **omitted one** — and omission leaves no row to audit. The durable form, for
whoever writes the next census:

> An enumeration conditioned on a base cannot report what that base cannot see, and its silences are
> invisible. Enumerate the *parameter* first — here `cos θ = (2n−1)/(2n)` is one integer — and screen bases
> against it second, never the reverse.

**Scope, stated so this does not oversell.** Absence from the census is not evidence that `n = 2` works;
it means no one has looked. Its live risk is thinness and is unchanged (PH2-10): 499 `Λ_parts` points inside
its 1.5119 endpoint bound. And the ordering against `ρ₆₃` is unchanged and rests on value of information,
not on cost — `ρ₆₃`'s solver answer re-ranks `n = 2`, and `n = 2`'s does not re-rank `ρ₆₃`.

---

## hunch ledger

hunch: the-target-count-is-free
  claim: the number of points a finitely generated `ζ₆`-closed module in `K²` can place on
    `\|p\|² = (7+√33)/3` is unbounded, so §2's objective is achievable and §8.1's ceiling is not the
    mission's obstacle
  basis: derived
  address: the circle is a coset of the norm-one group of `K(i)/K`, rationally parametrised by
    `w = (1+it)/(1−it)`; seven instances checked exactly, every `\|u·w\|² − α = 0`
  falsifier: a bound on the shell count of a rank-`≤ 8` module at a fixed totally positive value that
    does not also bound the module's covolume — which would contradict the construction
  registered: 2026-09-12
  status: confirmed (by: derivation — five `⟨ζ₆⟩`-orbits of circle points in distinct cosets span a
    finitely generated module with ≥ 30 circle points, and its all-conjugates cut is finite because the
    Minkowski embedding carries a `ℚ`-basis of `K²` to an `ℝ`-basis)

hunch: the-circles-differ-in-attachment-not-in-count
  claim: the record's circle carries 30 points inside the module, at full Cayley degree 30, against 0 for
    the phase's circle whose best outside point has degree 1, and 42× in the cheapest denominator —
    while their achievable point counts are both unbounded
  basis: measured
  address: my exact sweep of `Λ_parts(2.44)`, 3,433 points — 450 glue points on `\|p\|² = 4` with a
    denominator-1 member of degree 30 (= `|S|`, the module's norm-1 shell), against 72 on
    `\|p\|² = (7+√33)/3`, none in the module and all of degree 1, denominator ≥ 42; positive control 30
    points on `\|p\|² = 4`, matching the record. **First draft said 14; corrected, see the card**
  falsifier: a point of the new circle, at any radius, with unit degree > 1 against `Λ_parts`; and the 14 I
    first recorded, which was a double-counted tangency inside a truncating cut (see the card)
  registered: 2026-09-12
  status: open — measured at radius 2.44 only, and the falsifier is one sweep at a larger radius

hunch: the-rational-cosine-family-is-the-design-axis
  claim: `cos θ = (2n−1)/(2n)` for `n` in the base's shell spectrum makes the diagonal circle a lattice
    shell — cheap, full and attached; the family's wall-breaking members are the even `n`, its 6-open
    members are those with `squarefree(4n−1)` a non-residue mod 11, and it contains `ρ₁₅` at `n = 4` and
    `ρ₆₃` at `n = 16`
  basis: derived
  address: `1/(2−2cos θ) = n ⟹ cos θ = (2n−1)/(2n)`, `sin θ = √(4n−1)/(2n)`; at `n = 4` this is
    `(7+i√15)/8` and at `n = 16` it is `(31+3i√7)/32`, matching `CLAUDE.md` G7 and G8's `√ρ₆₃ = (3√7+i)/8`
  falsifier: `ρ₆₃` failing phase G's liveness or 2-adic screen for a reason the congruence on `4n−1`
    cannot see; or a radius-4 base being unsolvable in practice
  registered: 2026-09-12
  status: open — the derivation is checked against two recorded objects; the screen is unrun

hunch: the-diagonal-kinds-contribution-saturates
  claim: within colourings of the form `(C, π∘C)`, the diagonal kind imposes only that `π` move every
    colour class occurring on the circle while fixing the shared centre's — at most four conditions,
    independent of the number of circle points
  basis: derived
  address: G46 (the rotated half shares the index set and internal edge list) plus the diagonal pair
    being `(p, Rp)` with `λ = 1`; the additive sub-family `π = (+c)` with `c = 0` forced by the shared
    centre is exactly §H12's residue certificate
  falsifier: a diagonal cross edge whose two endpoints are not a point and its own rotated image, so
    that the kind is not a matching
  registered: 2026-09-12
  status: open — sufficient condition only; its failure proves nothing, and a solver may colour outside
    the family

hunch: the-antipodal-circle-carries-a-forced-prime
  claim: every `K`-point of `\|p\|² = 1/(2 + 2cos θ)` has 97 in a coordinate denominator, so the
    `λ = −1` route cannot be made affordable on any base, and `N_{ℚ(√33)/ℚ}(a(λ))` prices every `λ`
    before any module is built
  basis: derived
  address: `N(2 + 2cos θ) = 97/16` with `43² − 9·33 = 1552 = 16·97`; at a prime `𝔮` above 97,
    `v_𝔮(\|p\|²) < 0` forces `min(v_𝔮(p₁), v_𝔮(p₂)) < 0`
  falsifier: a `K`-point of that circle whose coordinate denominators are coprime to 97
  registered: 2026-09-12
  status: confirmed (by: derivation, and by the measured 0 of 3,433 unit contacts on that circle against
    72 on the diagonal circle with the same instrument)

hunch: the-rotation-could-have-been-K-rational
  claim: `sin θ ∉ K`, so the arena is not inside `K²` and `chromaticNumber_seamPlane` does not
    four-colour it; the arena's field is `K(√(202 − 22√33))`
  basis: derived
  address: `sin θ ∈ K` iff `202 − 22√33` is a square in `ℚ(√33)`, which needs `33n⁴ − 202n² + 121 = 0`
    to have a rational root; its discriminant is `24832 = 2⁸·97`
  falsifier: a rational `n` with `33n⁴ − 202n² + 121 = 0`
  registered: 2026-09-12
  status: confirmed (by: the hand derivation and, independently, my exact square-root-in-`K` routine
    returning `none` on `202 − 22√33` as one of eight controls with stated expected verdicts, 8 of 8 agreeing)

hunch: the-count-of-circle-points-is-divisible-by-six-and-not-twelve
  claim: on a `ζ₆`-closed module the circle count is a multiple of 6 because `⟨ζ₆⟩` acts freely on
    nonzero points and preserves every centred circle; the *finite* norm-one group of the maximal order
    of `K(i)` is the roots of unity `⟨ζ₁₂⟩`, of order **12**, not 6, so a `ζ₁₂`-closed module would give
    multiples of 12 — and `Λ_parts` is not one
  basis: derived
  address: `K(i) = ℚ(√3,√11,i)` is a CM field, so a norm-one unit has all conjugates of absolute value 1
    and is a root of unity (Kronecker); its square classes are `⟨−1,3,11⟩`, which excludes `√2`, so
    `ζ₈, ζ₂₄ ∉ K(i)` and `ζ₁₂ = (√3+i)/2 ∈ K(i)`
  falsifier: a `ζ₆`-closed module with a circle count not divisible by 6, or `√2 ∈ K(i)`
  registered: 2026-09-12
  status: confirmed (by: the free action; and on independent data — my glue sets are `ζ₆`-stable and
    come out 72 and 450, both divisible by 6, with 450 **not** divisible by 12, which is `Λ_parts` being
    `ζ₆`- and not `ζ₁₂`-closed, as its order-24 group says)

---

## What I did not do

1. **I ran no solver, no search and no sweep over bases.** Everything above is a read of committed
   artifacts plus exact arithmetic on at most a few thousand points, run to check a claim I was about to
   make. My longest job was ninety seconds. The threshold curve of PH2-6, the pricer of PH2-5 and the
   screen of PH2-4 belong to the phase's own instruments.
2. **I did not decide whether the antipodal circle is non-empty in `K²`** — PH2-5's honest gap. I reduced it
   to one Hilbert-symbol question, *is `101 − 11√33` a sum of two squares in `K`*, and left it.
3. **I did not read `data/m62/rotations-exact-moser-r2.05.json`.** Third ledger in a row to list it. PH2-4
   now gives it a consumer: it is a rotation census on a base that is **not** `Λ_parts`, which is exactly
   what PH2-4's family needs screened.
4. **I did not check `ρ₆₃` against phase G's liveness or 2-adic screen**, which is the open half of PH2-4
   and the one thing that decides whether that card is a route or a coincidence.
5. **I did not verify PH2-2's 14× at radius above 2.44.** The falsifier is one sweep at a larger radius, and
   the hunch is registered open because of it.
