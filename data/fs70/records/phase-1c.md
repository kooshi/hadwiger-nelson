# FS-70 phase 1c — the in-field rotation sweep: what landed

*Written 2026-09-22 by the phase-1c implementer (Opus 5), against the owner's phase-1c brief, the phase-1b
record `data/fs70/records/phase-1b.md`, and the owner's review `data/fs70/owner/review-phase1-2026-09-22.md`.
Machine: the desktop (16 physical cores / 32 threads, 125 GB). Every number names the command
that produced it.*

---

## 1. Headline

**No refusal — and for the first time in this milestone the null is mostly a theorem. Of the 3,499 rotations
of ℚ(√3,√5) that couple this base to a rotated copy of itself, 3,290 are four-colourable by a residue map with
no solver, and all 87 of the rest that couple at all were asked and coloured.**

1. **The literature's own method has now been run on this field, and `ρ₁₅` was not its best candidate.** Every
   known five-colour forcer is a base plus a rotated copy joined at distance 1; phase 1b asked that shape at
   one rotation. The list is now **complete for every rotation of denominator ≤ 42**, plus every class a second
   enumeration found above that — 3,499 symmetry classes, each with the **exact** cross-edge anatomy of its
   arena. `ρ₁₅` — the rotation the field screen selected and phase 1b spent its whole budget on — is **rank 6
   by coupling among the live rotations, not rank 1**, and only **one class in 3,499 is type-M**, the family
   that screen searches (§4c).
2. **The theorem, and it was not in the brief (§3).** The base's ℚ-span is the CM field `E₀ = ℚ(√−3,√−5)`, so
   a rotation is *commensurate* with the base exactly when it lies in `E₀`. `E₀` has **one** prime above 2,
   with residue field `𝔽₄`, and it is **inert** over the one prime of `ℚ(√15)` below it — so complex
   conjugation, which is the CM involution there, fixes it, and **every unit vector of `E₀` has valuation
   zero: no commensurate rotation can break the 2-adic wall.** Its arena therefore lies in a 2-integral rank-4
   lattice and the residue map to `𝔽₄` four-colours it outright, at any radius, for any base inside `E₀`.
   Checked and not merely quoted: twelve explicit additive colourings, verified edge by edge, **0
   monochromatic of up to 354,960**.
3. **What that costs a forcer, as a number (§4b).** The whole top of the list by coupling — 2,712 cross edges
   down to 492 at rank 20 — is commensurate and dead. The best rotation that can refuse anything has **84**.
   **A factor of 32 separates the best coupling available from the best coupling that is allowed to matter**,
   and that is G52's *"necessary and visibly not sufficient"* with a price attached.
4. **All 87 live arenas colour** (§5), 54,433 points and ~352,330 edges each, in 0.15–2 s; the complete
   population rather than the brief's top twenty. Every colouring is committed and re-verified on its own
   arena's edges: **88 colourings, 0 monochromatic edges**.
5. **G53's counting compulsion is absent, not weak, on every rotation that could carry it** (§4d): three
   wall-breaking classes have a diagonal circle, and `L = 0` at all three — some proper four-colouring of the
   base gives the centre a colour no circle point carries. `ρ₁₅`'s row reproduces phase 1b's exactly.
6. **The instrument had a defect that was quietly shrinking every count, and a control written for something
   else found it** (§6a). The geometric join's 3×3 grid lost pairs when a rotated coordinate landed at
   `0.9999999999999998`: measured at `ψ = ζ₆`, where the answer is known by hand, **6 of 42,660 pairs**. A
   missing cross edge makes an arena easier to colour, so the defect flattered exactly this phase's null. The
   radius is now derived rather than guessed, the known-answer case is asserted on every run, and a plant puts
   the defect back. **`ρ₁₅`'s arena came out right under the broken join** — the passing control proved
   nothing, and the case that exercised the failure had to be provoked.

**What this adds to phase 1b's null.** Phase 1b asked one rotation and found no compulsion. This phase asked
the question the literature's method actually poses — *which* rotation — and the answer is that on the CM base
over ℚ(√3,√5) the rotations divide cleanly in two: those with enough coupling to matter are, by an arithmetic
theorem, unable to break the wall, and those that break the wall have two orders of magnitude less coupling
and colour in under two seconds. *Said precisely: what is measured is the base `⟨ζ₆^m u^n : |n| ≤ 2⟩` at sums
of ≤ 4 (and ≤ 5 for the top few), with the rotation list complete for denominator ≤ 42 and for whatever the
`(z+s)/w` generator reached above it. Nothing here is about rotations outside those enumerations, about arity
above 2, or about a base outside `E₀`.*

---

## 2. What the phase was asked, and the one change I made to how it is asked

**The brief's enumeration bounds the wrong object, and rho15 is the measurement that says so.**

The brief asks for the rotation list by way of `psi = (z + s)/w`: a rotation makes a cross edge exactly when
`|z - psi.w| = 1` for some `z, w` in the base `B`, and writing `s = psi.w - z` for the joining unit vector turns
that into a division. Bucket `B` by the exact value of `|.|^2`, run `z` over `B` and `s` over a pool, look up
the `w` whose norm matches. That is a complete enumeration — **of the rotations whose joining vector lies in the
pool**, which is not the same as the rotations of bounded denominator.

Measured, on the one rotation this milestone has already built an arena on. `rho15`'s 138 pairs are joined by
unit vectors of denominator

    1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 36, 48, 72, 144

(`build/fs70/rot/why52.log`). The atlas — `data/fs70/atlas.jsonl`, every unit vector of the field to denominator
42, the largest pool this milestone owns — contains 82 of the 138, and after dropping the 30 pairs with `w = 0`
(where `psi = 0/0` is not a rotation at all) the sweep reports **52**. So the brief's route would have ranked
`rho15` at 52 against its true 138, and every other rotation likewise, by a factor nobody can predict.

**So the phase runs two enumerations and says what each is complete for** (`CLAUDE.md` G21):

| | what it enumerates | what it is complete for | what its counts are |
|---|---|---|---|
| **`scan`** — the list this phase reports | every unit vector `psi` of the pool; its cross edges on `B` are counted by a float grid proposing and exact field arithmetic deciding | **every rotation of denominator at most the pool's cap** — a bound on the object of interest | **exact** |
| **`sweep`** — the generator | the brief's `(z + s)/w` | every rotation, at **any** denominator, whose joining vector is in the pool | **lower bounds** |

The two are complementary: the scan cannot see a rotation of denominator above 42, the sweep can; the sweep
cannot count, the scan can. The sweep's classes that the scan's pool does not contain are re-counted exactly by
the scan's own routine and merged into the list (`fs70_rotations.py merge`).

**One more property of the sweep, recorded because it is what makes its counts vary within a symmetry class:**
its pool is not closed under multiplication by `zeta6`. The bijection carrying `psi`'s triples to `(zeta6.psi)`'s
sends `s` to `zeta6.s`, whose denominator can be twice `s`'s, and so can fall outside the pool. (Galois does
preserve denominators, so it does preserve the count.) The scan's identical control **is** sound, because there
each member's count comes from the geometry rather than from the pool — and that is the control that found the
defect in section 6.

---

## 3. The theorem the list produced: a commensurate twist of this base can never refuse four colours

This is the phase's structural product, and it was not in the brief. It came out of a column I added to the
rotation list for orientation — whether the rotation lies in the CM field — and then turned out to decide the
whole top of the list.

### 3a. What "commensurate" is here, exactly

The base lattice is `⟨ζ₆^m u^n : |n| ≤ 2⟩` with `u = (−2 + i√5)/3`. Its **ℚ-span** is the CM field
`E₀ = ℚ(√−3, √−5)`, of degree 4. So `ψ·(the ℚ-span) = (the ℚ-span)` exactly when `ψ ∈ E₀` — and then `ψΛ` and
`Λ` span the same 4-dimensional ℚ-space, the arena lies inside **one rank-4 lattice**, and the twist is
commensurate in G62's sense. Otherwise the arena lattice has rank 6 or 8 (`ρ₁₅`'s is 8). The test is exact and
costs four comparisons: `ψ = (x, y)` is in `E₀` iff `x` has no `√3` and no `√5` part and `y` has no rational and
no `√15` part (`E₀ = ℚ⟨1, √15, i√3, i√5⟩`).

### 3b. Every unit vector of the CM field is a 2-unit

**Measured first, on two independent populations.** Of the 3,499 symmetry classes the `(z+s)/w` sweep found,
**3,008 are commensurate and not one of them is wall-breaking**; of the 2,020 unit vectors in the atlas, 206 lie
in `E₀` and **not one of them has non-zero 2-adic depth**, while 800 of the other 1,814 do.

**Then proved, in seconds, with PARI** (`data/fs70/rot/cm-prime-above-2.log`):

| | primes above 2 | `e` | `f` | residue field |
|---|---|---|---|---|
| `E₀ = ℚ(√−3,√−5)` | **one** | 2 | 2 | **𝔽₄** |
| `ℚ(√15)`, its maximal real subfield | **one** | 2 | 1 | 𝔽₂ |

One prime above each, so the relative extension at 2 is `e = 1, f = 2`: **inert, not split.** Complex
conjugation on `F(i)` restricts to `E₀` as the CM involution over `ℚ(√15)`, and an inert prime is fixed by it,
so for any `ψ ∈ E₀` with `ψψ̄ = 1`,

        v(ψ) + v(ψ̄) = 2 v(ψ) = v(1) = 0,   hence   v(ψ) = 0.

**So no unit vector of the CM field breaks the 2-adic wall, and the exclusion is a theorem rather than a
measurement.**

### 3c. What that kills, and it is an infinite family

A commensurate twist's arena lies in `Λ + ψΛ ⊂ E₀`, which is 2-integral (the base's own 30 unit vectors all
have depth 0, and so does `ψ`), so every edge difference of the arena is a unit at that one prime, and
**reduction to its residue field 𝔽₄ is a proper four-colouring of the whole arena** — Theorem A
(`CLAUDE.md` row 57), at any radius, for any base inside `E₀`, with no solver.

**And the complement is the same theorem.** Wall-breaking implies non-2-unit implies not in `E₀`: **every
wall-breaking rotation of this base is incommensurate.** So on this base the two properties a forcer needs —
a broken wall, and enough coupling between the layers — are pulling in opposite directions, and the list below
measures how far apart.

This is G52's *"breaking the wall is necessary and visibly not sufficient"* with a **price** attached, and the
price is the whole difficulty of the milestone.

---

## 4. The rotation list

`data/fs70/rotations.jsonl` — **3,499 symmetry classes**, each with the exact cross-edge anatomy of its arena
on the CM base at sums of ≤ 4 (27,217 points, 176,124 edges). The header names the base, the pool and the
route. Built by `fs70_rotations.py scan` over the atlas (2,020 unit vectors of denominator ≤ 42, 158 classes),
then `merge`d with the 3,341 further classes the `(z+s)/w` sweep found at higher denominator — each of those
re-counted by the scan's own routine, so **every count in the file is exact**, whichever enumeration proposed
the rotation.

Quotient: `ψ ~ ζ₆^m · σ(ψ)^{±1}` for the six sixth roots of unity, inversion (= conjugation on a unit vector,
which swaps the two halves) and the four Galois maps of `F/ℚ` (which permute the base's generators, so they
carry the arena to the same graph — G27's hidden symmetry). Order at most 48. The class is reported at the
member with the largest diagonal, because `|1 − ψ|` — and hence which cross edges are *diagonal* — moves when
`ψ` is multiplied by a sixth root of unity, while the arena itself does not.

### 4a. The distribution

| | classes | with ≥ 1 cross edge |
|---|---|---|
| **all** | **3,499** | **2,625** |
| **2-unit — dead by the residue map (§3)** | **3,290** | **2,538** |
| **wall-breaking — the ones that can be asked** | **209** | **87** |
| commensurate (in the CM field) | 3,008 | 2,495 |
| trivial (`ψ` a sixth root of 1, so `ψB = B`) | 1 | 1 |
| type-M (`|1 − ψ|² = 1/n`) | 1 | 1 |
| with a diagonal circle at all | 6 | 6 |

**94 % of the list is dead by theorem, and so is 97 % of the part of it that couples at all.**

### 4b. The price of the wall, as a number

Largest cross-edge count by 2-adic depth:

| depth | −6 | −5 | −4 | −3 | −2 | −1 | **0** | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| classes with a cross edge | 2 | 5 | 4 | 5 | 15 | 15 | **2,538** | 18 | 7 | 9 | 1 | 4 | 1 |
| largest cross | 72 | 60 | 60 | 36 | 48 | 48 | **2,712** | 36 | 36 | 60 | 78 | 84 | 12 |

The whole top of the list by coupling — 2,712, 2,004, 1,896, 1,728, … down to 492 at rank 20 — is **2-unit and
commensurate**, every one. The best **live** rotation has **84**. A factor of **32** separates the best rotation
that could refuse anything from the best rotation full stop.

### 4c. The twenty that get asked

| # | ψ | den | depth | type-M n | cross | diag | off-diag |
|---|---|---|---|---|---|---|---|
| 1 | `(−25/32 + √3/32 − √5/32 − 5√15/96, −1/32 + 25√3/96 − 5√5/32 − √15/32)` | 96 | 5 | – | 84 | 0 | 84 |
| 2 | `(−11/16, 3√15/16)` | 16 | −6 | – | 72 | 12 | 60 |
| 3 | `(−7/12 − 5√3/24, 7√5/24 − √15/12)` | 24 | −4 | – | 60 | 0 | 60 |
| 4 | `(−3/8 − 5√3/24, 3√5/8 − √15/24)` | 24 | 3 | – | 60 | 0 | 60 |
| 5 | `(−√5/48 − 35√15/144, 7/48 − 25√3/144)` | 144 | −5 | – | 60 | 0 | 60 |
| **6** | **`ρ₁₅ = (7 + i√15)/8`** | **8** | **4** | **4** | **78** | **30** | **48** |
| 7–20 | 48, 48, 48, 48, 48, 42, 42, 36, 36, 36, 36, 36, 36, 36 off-diagonal | 4–25,352 | −5…3 | – | | | |

**`ρ₁₅` — the rotation phase 1b spent its whole arena budget on — is rank 6, not rank 1.** Five rotations
couple the two layers more strongly than it does, and the field screen that selected `ρ₁₅` (G7's type-M family,
`CLAUDE.md` row 64) could not see them: **only one class in the whole list of 3,499 is type-M**, and only six
have a diagonal circle at all. The type-M family is a thin slice of the rotations this field actually has.

### 4d. G53's counting screen, on every rotation that has a circle

The counting compulsion needs a diagonal circle — points `w` with `|w − ψw| = 1`, i.e. `|w|² = 1/|1 − ψ|²` —
and refutes the arena when `2L > (circle count)`, where `L` is the least number of circle points carrying the
centre's colour over all proper four-colourings of the base alone. Run on the three wall-breaking classes that
have a circle (`build/fs70/rot/counting-screen.log`):

| ψ | circle radius² | circle | L | ratio | refutes? |
|---|---|---|---|---|---|
| `(−11/16, 3√15/16)` | 8/27 | 12 | 0 | 0.000 | no |
| `ρ₁₅` | 4 | 30 | **0** | 0.000 | no |
| `(1/4, −√15/4)` | 2/3 | 24 | 0 | 0.000 | no |

`ρ₁₅`'s row reproduces phase 1b §5 exactly. **The compulsion is not weak on this fabric, it is absent**, on
every rotation that could carry it: some proper four-colouring of the base gives the centre a colour that *no*
circle point carries. (The instrument's UNSAT branch is exercised by the two hand graphs in `fs70_arena`'s
self-test, so `L = 0` here is a reading and not a binary search that can only say zero.)

---

## 5. The asks

Every wall-breaking, non-trivial rotation that makes a cross edge was asked at four colours — **all 87, not
the brief's top twenty**, because the arenas are 54,433 points and answer in seconds, so the complete
population cost thirteen minutes and is a stronger statement than a sample. Rows in `data/fs70/asks.jsonl`;
each arena's `graph.json`, `verdict.json` and colouring under `build/fs70/rot/asks/`.

### 5a. Base at sums of ≤ 4 — the complete population

| | |
|---|---|
| arenas asked | **87 of 87** — every wall-breaking, non-trivial class with a cross edge |
| each | 54,433 points (27,217 per half, 1 shared), ~352,330 edges, average degree 12.95 |
| cross edges | 84 at the top, 24 at the bottom; `ρ₁₅` 78 |
| verdict | **SAT, 87 of 87** |
| solver time | 0.15–2 s each; whole run 13 minutes including building the arenas |

Every verdict is read from **the ledger row the ask wrote**, never from its log (§6e). No refusal, no
UNKNOWN, nothing at a budget.

### 5b. Base at sums of ≤ 5 — the top five, and one finding that does not depend on the verdicts

Each arena is **272,041 points, ~2,099,210 edges, average degree 15.43** — five times the `k = 4` arena, and
denser than anything phase 1b built below its 805,693-point ball.

**The cross-edge count does not grow.** Rank 1 has **84** cross edges at `k = 4` and **84** at `k = 5`; rank 2
has **72** and **72**; the `(z, w)` pair counts are 144 and 144, 132 and 132. The halves grow fivefold and the
coupling between them does not move at all. Phase 1b saw the same of `ρ₁₅`'s diagonal *circle* (30 points at
every radius from ≤ 2 to ≤ 5) and left it as an open question; this extends the observation **off the
diagonal**, and it is still an observation and not a proof (§9, conjecture 2). If it is a theorem, growing a
base can never buy a twisted bilayer over this field more compulsion than the rotation already gives it.

| rank | ψ | cross at `k = 4` | cross at `k = 5` | verdict at `k = 5` | solver |
|---|---|---|---|---|---|
| 1 | `(−25/32 + √3/32 − √5/32 − 5√15/96, …)` | 84 | **84** | **SAT** | kissat, default, **699 s** |
| 2 | `(−11/16, 3√15/16)` | 72 | **72** | **SAT** | kissat `--sat`, **710 s** |
| 3–5 | | 60, 60, 60 | — | *running at handback* | kissat `--sat`, 1,200 s each |

**A solver-effort note, and a prediction of mine that LOST.** At `k = 4` these arenas answer in 0.15–2 s; at
`k = 5` the first took **699 s**. The default configuration had spent 712 s on rank 2 with no verdict when I
stopped it and relaunched aimed at the satisfiable direction (`--sat = --target=2 --restartint=50`), on phase
1b's measurement that this configuration settles large satisfiable instances its default cannot. **It bought
nothing: rank 2 came back SAT in 710 s under `--sat`, against rank 1's 699 s under the default** — the same
number, on instances that differ by twelve edges. So the cost at `k = 5` is the instance and not the
configuration, and phase 1b's finding does not transfer to this shape. What the kill forfeited is named in the
in-flight marker: twelve minutes of solver time and no result. Both numbers are facts about one solver on one
encoding of one graph, never about the graph (G21).

Whatever these return, they cannot change §5a: a colouring at `k = 5` would be one more colouring, and a
refusal would be the milestone and would be verified three ways before anything else happened.

### 5c. What was not asked, and why it is a theorem rather than a budget

The 3,290 2-unit classes were **not asked and do not need to be**: §3's theorem four-colours every one of their
arenas by the residue map, and §3's check exhibits that colouring on the twelve with the most cross edges —
`fs70_rotations.py screen` builds an additive ℤ/4 colouring from the arena lattice's HNF (no saturation needed)
and verifies it on **every** arena edge:

    12 commensurate arenas, ranks all 4, up to 354,960 edges each
    0 monochromatic edges in every one           (`data/fs70/rot/commensurate-screen.json`)

So the phase's null is **87 solver verdicts plus a theorem covering 3,290 more**, not 87 verdicts and 3,290
silences.

---

## 6. The instrument, and the defect that a control written for something else found

`tools/fs70_rotations.py` (new), `tools/fs70_rot_asks.py` (new). Self-test and plants: section 6c.

### 6a. The defect: the geometric join was silently losing cross edges

Every geometric question here is put to a float grid and answered by the field: the grid proposes every pair
whose squared distance is within `1e-6` of 1, the float error on these coordinates is about `1e-15`, and
`e_normF(z - w) == 1` decides. That decision is sound because the identity embedding of `F` in the reals is
injective — the field element equals the rational 1 exactly when the real number does.

The proposal step is where it went wrong. With cells of side 1 and the obvious 3×3 neighbourhood, a pair at
distance 1 was assumed to lie in adjacent cells. It need not: `floor` puts a rotated coordinate that lands at
`0.9999999999999998` a whole cell below one that lands at `1.0`, and a pair with `|dx|` near 1 then straddles
**two** cells and is never proposed.

**What found it was a control written for something else.** I had added a class-equality check — the arena of
`psi` and of `zeta6^m . sigma(psi)^{±1}` is one and the same graph (rotate the plane, swap the halves, apply the
field automorphism), so every member of a symmetry class must return the same counts. It fired. Chasing it
produced a case whose answer is known **by hand**: `psi = zeta6` maps the `zeta6`-invariant base onto itself, so
its pairs are exactly the ordered unit-distance pairs of the base, twice the edge count. The join read
**42,654 against 42,660 — six pairs lost.**

**The direction matters.** A missing cross edge makes an arena *easier* to colour. The defect flattered exactly
the null this phase was looking for, and it would have done so silently on every rotation in the list.

The repair: the neighbourhood radius is now **derived** — `int(sqrt(target + tol)/CELL) + 1`, which bounds
`|floor(a) - floor(b)|` for `|a - b| <= D` with nothing left to chance — the cell is 0.5, the known-answer case
is asserted on **every run** and not only in the self-test, and `--plant grid_radius_short` puts the defect back
so the check is seen to fail.

**And the passing control proved nothing before that.** `rho15`'s arena came out right — 54,433 points, 352,326
edges, 78 = 30 + 48 — under the *broken* join, because none of its 138 pairs happened to straddle. G21's rule in
its sharpest form: the case that exercises the failure had to be *provoked*, and what provoked it was the
trivial rotations, which nobody would have thought worth counting.

### 6b. The control the brief asked for, both halves

* **The sweep must find `rho15` with phase 1b's anatomy.** It does, and by a route that shares no code with
  phase 1b's: phase 1b derives the arena's edges from the **saturation of the arena lattice**, this derives them
  from the **geometry**. Independently: 54,433 points, 352,326 edges, **78 cross = 30 diagonal + 48
  off-diagonal**, 1 shared point, 138 `(z, w)` pairs at distance 1 — integer for integer with
  `data/fs70/records/phase-1b.md` §5.
* **A `rho15` with one wrong digit must be refused.** `--plant psi_digit` replaces `(7 + i√15)/8` with
  `(7 + √3 + i√15)/8`, which has `|.|² ≠ 1`; the tool refuses it by name (*"is not a unit vector … it is not a
  rotation of this plane and no arena can be built on it"*) before any arena exists. Seen to fire.

### 6c. The two-algorithm cross-check, and what it cost to get it

The scan runs the `z` side of the grid join over **one representative of each ζ₆-orbit of the base** and
multiplies the answer by six. Every quantity it computes is ζ₆-equivariant, and the argument is three lines:
`(z, w) ↦ (ζ₆z, ζ₆w)` preserves `|z − ψw|` because `ζ₆` and `ψ` are both complex numbers and commute; it
preserves `ψw ∈ B` because the base is ζ₆-invariant; and it preserves `z ∈ ψB`, because `ζ₆z ∈ ψB` iff
`ψ⁻¹ζ₆z = ζ₆ψ⁻¹z ∈ B` iff `ψ⁻¹z ∈ B`. The action is free off the origin, so the pair set is a free ζ₆-set; the
30 pairs at the origin are added back by hand and are inside-half edges for every `ψ`.

**Why it is checked rather than argued.** 349 rotations had already been counted by the **unreduced** join
before the reduction existed (the first launch of the scan, killed — section 7, decision 3). Those rows were
kept. Comparing them against the reduced run, field by field:

    349 rotations shared, 10 fields each = 3,490 comparisons, 0 disagreements
    (`build/fs70/rot/crosscheck_join.py`; of the 349, 104 have a cross edge and the largest is 2,712)

and the self-test asserts the two routes agree on four rotations including `rho15`, so the check is on every
run and not only in this one.

### 6c-bis. The one scope limit on the arena graphs, stated

An arena's edges come from two sources: **within a half**, the base lattice's saturation, complete by
construction; **between the halves**, the geometric join. The two can be checked against each other only where
the *arena lattice's* own saturation is affordable, which costs the box of its denominator and is refused above
`M = 144`. That is affordable at `ρ₁₅` (`M = 144`) and the two derivations agree exactly — 352,326 edges both
ways, phase 1b's number and mine. It is **not** affordable at the other rotations, whose arena denominators run
to 864 and beyond, so for those the between-halves edges rest on the geometric route alone.

What backs that route where it cannot be cross-checked: the float band is 1e-6 against a float error of ~1e-15,
the neighbourhood radius is derived rather than guessed (§6a), every proposal is decided by exact field
arithmetic, and the known-answer case (`ψ` a sixth root of unity, where the count must be twice the base's edge
count) is asserted on **every run**. A missed edge would make an arena easier to colour; the plant
`grid_radius_short` shows the check that would catch one firing at a loss of 13 in 42,660.

### 6d. Self-test and plants — all green, `build/fs70/rot/plants.log`

The self-test's four parts, each a number known independently of this tool:

1. `ρ₁₅`'s arena rebuilt: 54,433 / 352,326 / 78 = 30 + 48 / 1 shared / 138 pairs — phase 1b's, by a different
   derivation (§6b).
2. the reduced and unreduced grid joins agree in every field on four rotations including `ρ₁₅` (§6c);
3. the scan finds `ρ₁₅` with that anatomy from its own pool, and the trivial rotations are recognised
   (`shared == base_points`: a sixth root of unity maps the base onto itself);
4. `ψ = ζ₆` gives exactly twice the base's edge count — the case that caught the defect;
5. the `(z+s)/w` sweep finds `ρ₁₅` and its count is a strict lower bound on the exact one;
6. the lattice-only pool produces **nothing outside the CM field** and cannot find `ρ₁₅` — the pool is the
   enumeration, demonstrated rather than asserted.

Six planted faults, each seen to fire, and each for its own named reason:

| plant | what it breaks | what refused it |
|---|---|---|
| `psi_digit` | `ρ₁₅` fed with one wrong digit | *"is not a unit vector (\|.\|² = 67/64 + 7√3/32): it is not a rotation of this plane and no arena can be built on it"* |
| `norm_match_loose` | the exact field-element check after the hash lookup is skipped | bins whose `ψ` is not a unit vector |
| `centre_uncorrected` | the 60 shared-centre pairs left in the count | *"the sweep is claimed to be a LOWER bound: it reads 92 against the exact 90"* |
| `geom_tol_tight` | the proposal band collapsed to zero width | the ζ₆ known-answer: 10,288 pairs against 42,660 |
| `pool_truncated` | the pool of `s` silently cut to eight vectors | *"the scan did NOT find rho15"* |
| `grid_radius_short` | the grid neighbourhood one cell short — **the defect this tool shipped with** | the ζ₆ known-answer: **42,647 against 42,660** |

The last row is the point of the exercise: the plant reproduces the original defect's *size* — thirteen pairs
lost out of 42,660, a 0.03 % error that no eyeball would catch and that moves every cross count downward.

### 6e. A second detector that fired for the wrong reason, in the run itself

The ask driver's refusal check was `'UNSAT' in the subprocess's stdout`. `fs70_ask.py` prints
*"UNSAT would mean: …"* before **every** ask, by design, so the driver declared a refusal on the very first
arena — which had just come back **SAT in 0.15 s**. It halted, as it is supposed to on a refusal, and the line
immediately above the alarm said SAT.

It failed in the safe direction (a false alarm, not a false null) and it cost two minutes. The repair is the
rule in `CLAUDE.md`: **assert on the written artifact, never on the list that produced it.** The driver now
reads the verdict out of the ledger row the ask appended, matched by the arena's point and edge counts, and
says so loudly if no row was written at all rather than treating a failed ask as a null about the graph.

---

## 7. Decisions

| # | the choice | the alternative I weighed | why this one won | confidence |
|---|---|---|---|---|
| 1 | **Run two enumerations and label the brief's one a generator**, whose counts are lower bounds | Run the brief's `(z+s)/w` enumeration as specified and rank by its counts | `ρ₁₅`'s own 138 pairs are joined by unit vectors of denominator up to 144 against the atlas's cap of 42, so that route reports 52 — a 2.7× understatement on the one rotation whose answer was known, and an unknown factor on every other. Ranking by it would have put the wrong rotations at the top. The generator is kept because it is the only route that reaches denominators above 42, and **177 of the 209 wall-breaking classes are above 42** — it is not redundant, it is half the list. | **high** — the discrepancy is measured on a known answer, not argued |
| 2 | **Ask all 87 live arenas, not the brief's top twenty** | The top twenty, as briefed | The arenas are 54,433 points and answer in 0.15–2 s; the whole population cost thirteen minutes. A complete population turns "the top twenty colour" into "every rotation of this field that can refuse anything, and makes a cross edge, colours", which is a different sentence. | **high** |
| 3 | **Kill the first scan at 349 of 2,020 and restart with the ζ₆ symmetry reduction** | Let it finish (ETA ~33 minutes and rising) and add the reduction afterwards for the `k = 5` pass | `CLAUDE.md`'s rule: a run blocking its own replacement is killed by default, and with a checkpoint the cost of being wrong is the redo, not the result. Here the redo cost **nothing at all** — the 349 rows were computed by a correct algorithm and became the two-algorithm cross-check of §6c, which is better evidence than anything I would have written for the reduction otherwise. | **high** — but see §8, the *diagnosis* I killed it on was partly wrong |
| 4 | **Report the class at its largest-diagonal member** rather than its largest-count member | Report it at the member with the most cross edges | `diagonal` and `type_m_n` are properties of the member, not of the class: `\|1 − ψ\|` moves when `ψ` is multiplied by a sixth root of unity, while the arena does not. Taking the largest-count member silently reported `type_m_n = None` for `ρ₁₅`'s own class, which is how I found it. | **high** |
| 5 | **Verify the commensurate theorem on twelve arenas instead of quoting it** | State the PARI computation and move on | A theorem whose instrument I wrote this morning, covering 94 % of the list, is exactly where a quiet defect would hide. Twelve explicit colourings verified on every edge cost nine seconds each and make the 3,290 unasked classes evidence rather than an assertion. | **high** |
| 6 | **Build the additive screen on the arena GRAPH, not the arena lattice** | Use `fs70_fabric.additive_screen`, which phase 1b already validated | That screen needs the arena lattice's **saturation**, which costs the box of its denominator and is refused above `M = 144`; most arenas here have `M` in the hundreds. Asking the weaker and sufficient question — is there a homomorphism to a group of order 4 nonzero on the edge differences **this graph actually has** — needs only the HNF and 4^rank ≤ 65,536 candidates, and a hit is still an explicit four-colouring. A miss says nothing, and is recorded as saying nothing. | **high** |

---

## 8. Where the brief, phase 1b or I was wrong

| where | what it says | what is the case |
|---|---|---|
| **the brief, ask (i)** | the rotation list is enumerated as `ψ = (z + s)/w` over the base and a pool of `s`, and **ranked** by the resulting cross-edge count | That enumeration bounds the **joining vector**, not the rotation. Measured on `ρ₁₅`: 52 against 138, because 56 of its 138 pairs are joined by unit vectors of denominator 48, 72 or 144 while the atlas stops at 42. The route is kept as a generator — it is the only one that reaches denominators above 42, and 177 of the 209 wall-breaking classes are there — but the counts and the ranking come from a direct scan (§2). |
| **the brief, ask (i)** | *"the top twenty by off-diagonal cross edges"* as the thing to report | Reported, but the top twenty **of the whole list** is 2,712 down to 492 cross edges and every one of them is dead by theorem. The table a reader needs is the top twenty of the **live** classes, which starts at 84. Both are in §4. |
| **the brief, ask (ii)** | *"a 2-unit `ψ` keeps the arena 2-unit … screen those out by that theorem"* | Right, and it is stronger than the brief states: every **commensurate** rotation is a 2-unit, by an inertness computation the brief did not anticipate (§3), so the theorem covers a family described by geometry and not only one described by valuations. |
| **the brief, ask (iii)** | the true control would be the sweep on Harder's base over `K = ℚ(√3,√11)`, *"but the tools have no ℚ(√3,√11) arithmetic — do not build it"* | Followed. The substitute controls (find `ρ₁₅` with 78 = 30 + 48; refuse a wrong-digit `ρ₁₅`) both passed — **and neither would have caught the defect in §6a**, which needed a case whose answer is known by hand. That case was the trivial rotations, which no part of the brief asks for. |
| **my own first diagnosis**, decision 3 | I read the fixed grid join at **14.29 s per rotation** against 1.51 s for the broken one and concluded the fix was 9× slower | That 14.29 s was measured **while fourteen scan workers were saturating the machine**. On a quiet machine the same join is 1.81 s. The kill was still right — the *throughput* was 54 rotations/minute and falling, and the reduction is exact and gives 4–5× — but the number I reached for was a contended wall-clock used as a quiet-CPU cost, which is the error `CLAUDE.md` names in as many words. The honest statement of the ruling is throughput, not a per-call ratio. |
| **my own refusal detector** | the ask driver read `'UNSAT' in stdout` | It matched `fs70_ask.py`'s own explanatory line and declared a refusal on a SAT verdict (§6e). |
| **my own merge step** | `fs70_rotations.py merge` counts 3,341 classes with `p.map` | **No checkpoint.** The scan and the asks both checkpoint; the merge does not, so a kill during its twelve minutes would have redone all of it. It survived; it is a defect of mine and it is recorded rather than quietly fixed after the fact. |

---

## 9. WORKFLOW step 9's two sweeps over this phase's additions

* **"conjecture"** — two, neither claimed, both stub candidates for the owner.
  1. **Is `commensurate ⟹ 2-unit` a fact about this base, or about CM fields?** §3 proves it for
     `E₀ = ℚ(√−3,√−5)` by one inertness computation. The same argument runs for any CM field `E` whose prime
     above 2 is not split over its real subfield, and *fails* where it is split. If the split case can be
     realised by a CM base over some real field, that base's commensurate twists are **not** all dead, and the
     whole strategy this phase closes would reopen there. The test is a `nflist` sweep over small CM fields and
     costs an afternoon.
  2. **Does a type-M arena's cross-edge set ever grow with the base?** At every rotation measured here the
     answer is no: the arena at sums of ≤ 5 has exactly the cross edges the arena at ≤ 4 has (84 and 84, 72 and
     72), while the halves grow fivefold. Phase 1b measured the same of `ρ₁₅`'s diagonal circle (30 at every
     radius from ≤ 2 to ≤ 5) and left it as its own conjecture 2. This phase extends the observation off the
     diagonal and still does not prove it. If it is a theorem, **the coupling of a twisted bilayer over this
     field is a bounded quantity fixed by the rotation alone**, and growing a base can never buy compulsion.
* **"not claimed"** —
  (i) that any rotation **outside** the two pools is dead — the list is complete for denominator ≤ 42 directly
  and for whatever the `(z+s)/w` generator reached above that, and a rotation absent from it is absent from
  those enumerations, never from the field;
  (ii) that the arenas are four-colourable at radii beyond those asked — what is measured is the base at sums
  of ≤ 4 for all 87 and ≤ 5 for the top few;
  (iii) anything at arity above 2 — every ask here is a whole-arena control;
  (iv) that `L = 0` in §4d is a property of the arena rather than of the base — G53's criterion is sufficient
  and never necessary, so a `no` from it is a null;
  (v) that the commensurate theorem says anything about a base **not** inside `E₀`; it is a statement about the
  ℚ-span of the CM lattice this milestone chose.

---

## 10. What a kill would have redone, and what is on disk

Every long step checkpointed except one, which is recorded in §8.

| step | wall | checkpoint | a kill redoes |
|---|---|---|---|
| the scan, 2,020 rotations | ~8 min on 14 workers | `build/fs70/rot/scan-k4.partial`, one row per rotation flushed as it lands | the 14 rotations in flight |
| the `(z+s)/w` sweep | ~3 min, single-threaded | none — it writes once at the end | the whole sweep, three minutes |
| **the merge, 3,341 rotations** | **~12 min on 14 workers** | **none — `p.map` with no partial file** | **all of it. My defect, §8** |
| the 87 asks at `k = 4` | 13 min total | the ledger row at each verdict, plus `verdict.json` per arena | the arena being built, ~12 s |
| the asks at `k = 5` | ~12 min each | the same | the arena being built, ~60 s |
| the plants | ~6 min | none needed | six minutes |

**Durable artifacts** (everything a reader needs is under `data/`, not `build/`, which is scratch an agent may
clean): `data/fs70/rotations.jsonl` (the list), `data/fs70/asks.jsonl` (the verdicts),
`data/fs70/rot/cm-prime-above-2.log` (§3's PARI computation), `data/fs70/rot/commensurate-screen.json` (§5c's
twelve verified colourings), `data/fs70/records/phase-1c.md` (this file).

**Regenerating everything:**

```
python3 tools/fs70_rotations.py --selftest              # and --plants
python3 tools/fs70_rotations.py scan  'group6:u3:2' 4 --pool atlas --jobs 14 \
        --partial build/fs70/rot/scan-k4.partial --out data/fs70/rotations.jsonl
python3 tools/fs70_rotations.py sweep 'group6:u3:2' 4 --pool atlas --out build/fs70/rot/sweep-k4.jsonl
python3 tools/fs70_rotations.py merge data/fs70/rotations.jsonl build/fs70/rot/sweep-k4.jsonl --jobs 14
python3 tools/fs70_rot_asks.py data/fs70/rotations.jsonl --top 87 --k 4
python3 build/fs70/rot/screen_commensurate.py 12
python3 build/fs70/rot/crosscheck_join.py
```

## 11. The machine, and a note for the owner

**Phase 1b was still running when this phase started, and is not finished.** The brief said its runs were
"finishing … within the hour"; in fact its implementer committed four minutes after I began
(`54d7b9f7`, 04:02) and its `build/fs70/price_cubes.py` has held a core and 15 GB throughout this phase. I did
not touch it. Two agents committing to one repository is a staffing fact the owner should know about, not
something for me to resolve: I kept to my own paths, appended to the shared `data/fs70/asks.jsonl` only
through `fs70_ask.py` (which opens it in append mode, so line-level interleaving is safe), and committed
explicit paths only.

The two orphan watchers the brief named (pids 308047, 309502) were killed by process group and verified by
effect — no `tail -f` on any FS-70 log survives, and the only match left was my own `grep`'s.
