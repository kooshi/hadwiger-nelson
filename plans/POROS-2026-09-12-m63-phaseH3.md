# Poros ledger — M63 phase H3, "drop the shape"

*Advisor's file, opened 2026-09-12, restarted fresh for this phase. Entries **PH3-1** onward, in my
predecessor's format: the claim, my position, the grounds, the disposition, and what would change my mind.
Nothing in this phase had been committed to a solver, a paper, or a third party when these were written —
`CLAUDE.md` G51's free-retraction window was open, and this file is what I spent it on.*

**What I advise against:** `plans/M63-phaseH3-drop-the-shape.md` (the brief) and
`plans/M63-phaseH3-plan.md` §0 and §2 (the product owner's registered predictions P-H3-1 … P-H3-5).

**Everything numeric below is my own exact integer arithmetic, run before I read the corresponding
claim's supporting file wherever the order allowed it.** Scripts are in my scratch directory
`/home/kooshi/.claude/jobs/d4cccfde/tmp/`; every count is reproduced by a known-answer control stated in
the entry that uses it. No float decides any verdict in this file.

---

## The controls every count below rests on

| control | expected | measured | where |
|---|---|---|---|
| my disk-cut enumerator on Parts's lattice at his radius 2 | **1,603** (`tools/typem.py parts_lattice`, his §5.6) | **1,603** | `parts_S.py` |
| my shell enumerator, Parts's shape, `\|p\|² = 1` | **30** (the brief's own table) | **30** | `shell.py` |
| my shell enumerator, Parts's shape, `\|p\|² = 4` | **30** (`M63-phaseH2-the-family.md` §6c, six-for-six across three agents) | **30** | `shell.py` |
| shape-free ceiling at `\|p\|² = 2` | **60** (`M63-phaseH2-arithmetic.md` §4) | **60** | `shell.py`, `shell_ok.py` |
| eight-dimensional volume heuristic vs exact count | unknown | **within 0.5%** at `R² = 16/7` | `count8b.py` |
| two-sided plant on every lattice-membership test | guarded 0 escapes / planted 100% escapes | as expected | `closure.py`, `parts_S.py`, `count_U.py` |

**Module ambiguity resolved first, because every count depends on it.** "Denominator 12" can mean
`12p ∈ ℤ[√3,√11]²` or `12p ∈ O_K²`, and `[O_K : ℤ[√3,√11]] = 4` (disc `K` = 17,424; disc of the order =
278,784; ratio 16 = index²), so the two differ by **16×** in bulk density. They do **not** differ on the
shells that the phase's headline uses — I counted both and got 30 / 60 / 0 / 60 either way — but any
*volume* claim must say which module it means. P-H3-1's covolume is the `ℤ[√3,√11]` one.

---

## PH3-1 — The brief's premise that the shape is what excludes `n = 2`

**Claim (brief §2, §4a; `M63-phaseH2-arithmetic.md` §4).** At `n = 2` the circle `|p|² = 2` holds **60**
denominator-12 points, **none** of which has Parts's coordinate shape, so his lattice scores 0 for the
shape and not for the radius, the denominator or the field.

**Position: UPHELD, and it is the one part of the phase I could not dent.**

**Grounds.** I re-derived the shell equations from scratch rather than reading his enumerator. For
`p₁ = (a₀+a₁√3+a₂√11+a₃√33)/12` and `p₂` likewise, `|p|² = N` is the integer system

```
Q(A) + Q(B) = 144N ,  Q(v) = v₀² + 3v₁² + 11v₂² + 33v₃²
```
with the three radical forms `2(v₀v₁+11v₂v₃)`, `2(v₀v₂+3v₁v₃)`, `2(v₀v₃+v₁v₂)` summing to zero across the
two coordinates. Enumerated exactly, over **both** candidate modules:

| | `\|p\|² = 1` | `\|p\|² = 2` |
|---|---|---|
| Parts's shape, `12p ∈ ℤ[√3,√11]²` | 30 | **0** |
| Parts's shape, `12p ∈ O_K²` | 30 | **0** |
| shape-free, `12p ∈ ℤ[√3,√11]²` | 60 | **60** |
| shape-free, `12p ∈ O_K²` | 60 | **60** |

The zero survives enlarging the module from the order to the full ring of integers and survives dropping
every congruence — it is the two coordinate-slot conditions alone. **And the brief's §3 worry that "the 60
may or may not have been computed under the conjugate constraints" is moot, not merely answered:**
`|p|² = 2` is an equation *in `K`*, so every Galois conjugate of it also reads 2, and `2 < 16/7 = 2.2857`,
so **all sixty points satisfy the four-conjugate disk cut at `R = 4/√7` automatically.** There is no
conjugate constraint left to apply.

**What would change my mind:** a sixty-first point, or a point of the sixty failing an exact recomputation
of `|p|²`.

---

## PH3-2 — The brief's headline comparison, "twice the record's circle count and twice its unit-neighbour count"

**Claim (brief §2, the bolded sentence under the table).** *"The arithmetic offers twice the record's
circle count and twice its unit-neighbour count, in an unsealed field, at 73% of its radius."*

**Position: REFUTED as stated. Both doublings belong to dropping the shape, not to choosing `n = 2`, and
the brief's own table says so one row above the sentence.**

**Grounds.** The table's "circle points, shape dropped" row reads **60, 60, 60** at `n = 2, 4, 16`. The
doubling against the record's 30 is therefore available at the record's *own* `n = 4` without changing `n`
at all. The unit-neighbour row is worse: the unit shell `|p|² = 1` does not depend on `n` **at all** — I
measured 30 with the shape and 60 without, and that single pair of numbers is the whole content of a row
printed as `60 / 30 / 30`. The row compares a shape-free count at `n = 2` against shape-constrained counts
at `n = 4, 16` and reads as a property of `n`.

**What `n = 2` uniquely buys, once the comparison is made like against like:** the radius (1.5119 against
2.0656 and 4.0316) and the field. And the field is **shared with `n = 16`, which is already built and
verified** — so the honest unique gain of `n = 2` over phase H2's own object is radius alone.

**One number in the same paragraph is wrong by its own units.** Brief §1: *"the object is **7.1× smaller in
arena radius** than phase H2's"*. `4.0316 / 1.5119 = 2.667`. 7.1 is the **area** ratio, `2.667²`.

**What would change my mind:** a reason the shape-drop is cheaper at `n = 2` than at `n = 4` — which would
be a real argument, and is not the one made.

---

## PH3-3 — P-H3-1's derivation, and its measured value

**Claim (plan §0, P-H3-1).** The shape-free arena is bigger than Parts's by better than an order of
magnitude; the admissible region in `ℝ⁸` is a product of four disks of radius `R`, volume `(πR²)⁴`; the
covolume is `(528/12⁴)² = 6.48364e-4`; the raw count at `R = 4/√7` is `4,099,300`; at congruence index 256
the answer is `≈ 16,000`.

**Position: UPHELD in every step, and now MEASURED rather than estimated — 16,309.**

**Grounds.** Each step checked independently:

- **The region really is a product of four disks.** `|p|² = p₁² + p₂²` and `σ(|p|²) = (σp₁)² + (σp₂)²`, so
  the cut at each of the four real embeddings is a disk in that embedding's coordinate pair, and the eight
  real coordinates group as four independent pairs. ✔
- **The covolume `528/12⁴` per coordinate is right.** The matrix is `(1/12)·H·diag(1,√3,√11,√33)` with `H`
  the order-4 Hadamard sign matrix, `|det H| = 4^{4/2} = 16`, `√(3·11·33) = 33`, so `16·33 = 528`. ✔
- **The calibration is right.** Parts's `|p|²` lies in `ℚ(√33)`, so his cut is two disks in `ℝ⁴`, covolume
  `(2√33/144)² = 0.00636576`, index 16 — I confirmed the index 16 by counting residues mod 4: 16 of 256
  satisfy his two congruences. Volume `(4π)²/0.00636576/16 = 1,550` against his measured 1,603. ✔
- **The volume heuristic is accurate in eight dimensions**, which was the step I most expected to fail and
  the reason I measured it: exact raw count at `R² = 16/7` is **4,120,577** against the heuristic's
  4,100,808 — **0.5% high**. (At `R² = 1` it is 3.3% high, so the heuristic improves with radius, as it
  should.)
- **The exact answer.** In the lattice generated by the sixty unit vectors — see PH3-5 for why that is the
  right lattice — the four-conjugate disk of radius `4/√7` holds exactly **16,309** points. P-H3-1's band
  was `[12,000, 22,000]`. **Met, to within 2%.**

So the arena is **32,617 vertices** (`2 × 16,309 − 1`, sharing the centre), against phase H2's 51,133, and
the plan §2 addendum's sentence — *"smaller than phase H2's object in both vertices and radius, and about
43× the record's vertex count at 73% of its radius"* — is correct as written. 16,309/374 = 43.6.

**What would change my mind:** a build that uses `O_K` rather than `ℤ[√3,√11]`, or the maximal group-closed
lattice rather than the unit-generated one. Either would multiply the count (by up to 16 and by exactly 16
respectively) and both are live misreadings of the phrase "the denominator-12 module" — see PH3-5.

---

## PH3-4 — P-H3-3's "a ζ₆-submodule of `K²` of index four in the denominator-12 one"

**Claim (plan §0, P-H3-3).** Parts's shape is ζ₆-stable, hence *"a ζ₆-submodule of `K²` of index four in
the denominator-12 one. Dropping it therefore cannot break ζ₆-closure; it can only enlarge."*

**Position: the ζ₆-stability is UPHELD; the index is REFUTED as written, and the written form contradicts
P-H3-1 one page earlier.**

**Grounds.** The stability calculation is correct — I checked it: `√3·p₂ ∈ ℚ ⊕ √33ℚ` and
`√3·p₁ ∈ √3ℚ ⊕ √11ℚ`, so both slots return. But the shape forces **four of the eight coordinate slots to
zero** (`p₁` has no `√3` or `√11` part, `p₂` no rational or `√33` part). It is a rank-**4** ℚ-subspace of a
rank-**8** space: the index is **infinite**, the codimension is four. And P-H3-1's own derivation depends
on exactly this — its `(πR²)⁴`-over-`ℝ⁸` volume argument is a rank-8 computation, which an index-4
sublattice could not be. **Two registered predictions in one document disagree about the rank of the
object the phase is built on.**

The number four is not imaginary, and it is worth keeping because it is a real finding — it just belongs to
a different pair of lattices. See PH3-5.

**What would change my mind:** nothing; this is arithmetic. The repair is one word — *codimension* — plus
deleting "index four", or replacing it with PH3-5's statement.

---

## PH3-5 — Brief §6 step 1 asks the wrong question, and answering it correctly would cost the phase 16×

**This is the entry I would most like read.**

**Claim (brief §6 step 1; plan §0 P-H3-3).** *"Verify Parts's two congruences are the ζ₆-closure
conditions — measured to cost nothing, but asserted only by a docstring. If they are, only the shape has to
be given up."* P-H3-3 scores this met if the congruences are *"necessary as well as sufficient"*.

**Position: the congruences are SUFFICIENT and NOT NECESSARY for group closure — so the step as written
returns "not met" — but that answer is a trap, because the closure-maximal lattice is USELESS and building
it would inflate the phase's object sixteenfold into sixteen disconnected copies of the object it wants.
The right question is not closure at all.**

**Grounds, in four measured steps.**

1. **A strictly larger group-closed lattice exists inside Parts's own shape.** Writing his point as
   `(a,b,c,d)` for `p₁ = (a+b√33)/12`, `p₂ = (c√3+d√11)/12`, his conditions are `a≡b≡c≡d (mod 2)` and
   `a−b+c+d ≡ 0 (mod 4)` — index **16** in `ℤ⁴`. The *maximal* order-24-closed denominator-12 lattice in
   that shape is `S = {a ≡ c, b ≡ d (mod 2)}`, index **4**. I verified `S` against the shipped
   `tools/typem.py parts_group()` maps with a two-sided plant: 4,000 random members of `S`, **0** escapes
   under all 24 group elements; 4,000 members with one parity broken, **4,000** escapes. `[S:P] = 4`,
   confirmed by residue count and by the disk cut (6,259 points against his 1,603 at radius 2 — ratio 3.90).
2. **The same holds shape-free.** The maximal order-24-closed denominator-12 lattice in the rank-8 module is
   `L = {a₀≡b₁, a₁≡b₀, a₂≡b₃, a₃≡b₂ (mod 2)}`, index **16** in `ℤ⁸`, derived from `ζ₆`'s halving and
   verified self-preserving; same two-sided plant, 0 / 4,000. At `R = 4/√7` it holds **260,401** points.
3. **But `S` and `L` are useless, and for a reason that is a theorem, not a measurement.** All 30 unit
   vectors of the shape lie in `P`, and all 60 shape-free unit vectors lie in `U` — so for any two lattice
   points at distance 1, the *difference* is in the unit-generated lattice, and **no unit edge ever crosses
   between cosets.** The unit-distance graph on `S` is therefore **four disjoint translated copies** of the
   graph on `P`, and the one on `L` is **sixteen** disjoint copies of the one on `U`. 260,401/16,309 =
   15.97 — the ratio is the coset count, exactly as the argument predicts.
4. **What Parts's congruences actually are.** I computed the index in `ℤ⁴` of the lattice **generated by his
   30 unit vectors**: it is **16**, and all 30 satisfy his congruences. **His lattice is precisely the
   ℤ-span of its own unit vectors.** The shape-free analogue: the span of the 60 unit vectors has index
   **256** in `ℤ⁸` — and adding the 60 circle points does not change it, so the circle is already inside.

**So the correct statement, replacing both branches of P-H3-3's scoring:** *Parts's congruences are not the
closure conditions and were never meant to be; they are the statement that his lattice is generated by its
own unit vectors. Closure is the weaker property and it has a larger solution, which is exactly why the
docstring's "group-closure by construction" is true and uninformative.*

**The cost of the trap, priced.** The phase's step 1, executed as written, finds the congruences merely
sufficient, reports P-H3-3 "not met", and points step 3 at `L` — 260,401 base points, a **520,801-vertex**
arena, ten times phase H2's, which the brief's own step 5 (phase H2's interface reduction, 20 core-hours on
25,567-vertex halves) cannot reach. And its **base** would be sixteen disjoint translated copies of the 16,309-point one that
was wanted — *corrected after the fact: its **arena** need not be disconnected, because a cross edge joins
the base to the rotated copy and may link two different cosets, which I did not measure. So the honest
charge against `L` is a 16× cost for material whose only possible contribution is through cross edges
nobody has counted, not that it is disconnected outright.* **Nothing in the brief or the plan would have
caught this**, because both ask about
closure and neither asks about generation.

**And it rescues P-H3-1's guess.** *"Index 256 (all eight residues tied mod 2, plus one mod-4 condition —
Parts's pattern, doubled)"* is the right index for the wrong reason: 256 is the index of the
**unit-generated** lattice, and the mechanism is generation, not a doubled congruence pattern. The
prediction is met; the sentence explaining it is not the reason it is met.

**What would change my mind:** a construction in which the base is *not* built from unit steps — Parts's is
`(+)ⁿHᵐ`, sums of unit-hexagon points, so his is — or a demonstration that the extra cosets of `L` carry
cross edges to the rotated copy even though they carry no internal unit edges. *That second one is a real
question and I have not closed it* (see PH3-8).

---

## PH3-6 — RETRACTED BY ME: "the phase's object is half a million vertices"

**What I claimed, for about twenty minutes.** Having derived the maximal ζ₆-closed index (16, not 256) and
verified it against the shipped group maps with a two-sided plant, I concluded that the shape-free base was
**260,401** points and the arena **520,801** vertices — ten times phase H2's, beyond the solver route the
brief names, and therefore that P-H3-1's `≈16,000` was low by 16× and the plan §2 addendum's "smaller than
phase H2's object" was backwards.

**Retracted, completely.** The index-16 derivation is correct and the measurement is correct; the
**inference from it was wrong**, because I had answered the brief's question (what is group-closed) instead
of the phase's question (what will actually be built). The lattice the phase will build is the
unit-generated one, index 256, **16,309** points — and P-H3-1 is met.

**The mechanism of my miss, because it is the one this project keeps paying for.** I took the module
definition from the *document I was auditing* (brief §6 step 1: "verify the congruences are the ζ₆-closure
conditions") rather than from the object, and so inherited its frame while believing I was testing it.
What broke it was not care: it was running one more control than the argument needed — the index of the
span of Parts's own 30 unit vectors — on the suspicion that his congruences were too specific to be a
closure condition. **The check that catches a frame error is the one that recomputes a number the frame
says you already know.**

---

## PH3-7 — P-H3-5's scoring threshold does not measure the quantity P-H3-5 predicts

**Claim (plan §2, P-H3-5).** *"I predict `cos θ = 3/4` admits off-diagonal cross edges, but fewer per
circle point than `ρ₆₃`. Scoring: met if the off-diagonal count **per circle point** at `n = 2` is strictly
below `24/54 = 0.444`."*

**Position: REFUTED as a scoring rule. The two quantities named in one sentence are different numbers, and
they disagree over a range that is where the answer most plausibly falls.**

**Grounds.** `24 of 54` is the off-diagonal **share of the monochromatic cross edges** — the quantity
`M63-phaseH2-the-family.md` §6a defines and proposes. `ρ₆₃`'s circle count is **30**, so its off-diagonal
count *per circle point* is `24/30 = 0.800`, not 0.444. A measured value anywhere in `(0.444, 0.800)` at
`n = 2` therefore satisfies the prediction's **sentence** (fewer per circle point than `ρ₆₃`) and fails its
**rule** (below 0.444). The same sentence's closing claim — *"the two known members already sit at 0.000 and
0.444, bracketing the range"* — mixes one member's share with the other's per-point rate.

**And the carve-out hides the decisive outcome.** *"Not decided if the count is zero"* is the case in which
**the phase is over**: by `M63-phaseH2-the-family.md` §6b, an arena whose only non-centre cross structure is
the diagonal matching is four-colourable as soon as one proper base four-colouring keeps the centre's colour
off the circle. Zero is not an undecided score; it is the phase's most likely terminal outcome and deserves
its own named branch.

**What would change my mind:** nothing about the arithmetic; the repair is to pick one normaliser, state
both members' values under it, and give zero its own branch.

---

## PH3-8 — `n = 2` was already killed by derivation in phase H2, and the brief does not cite the verdict

**Claim.** The brief presents `n = 2` as an untried opportunity.

**Position: the brief is missing its own most relevant prior result, and the phase's entire survival
depends on a quantity that result measured as ZERO.**

**Grounds.** `plans/M63-phaseH2-the-family.md` §6, third bullet, written by my predecessor in this chair:

> **`n = 2` is DEAD by derivation** … **`n = 2` has 60 cross edges and every one of them is a CENTRE edge.
> Zero diagonal, zero off-diagonal — stable as the cut grows from 1.5119 to 2.0 (499 → 1,603 base points,
> still 60).** So its arena is two copies of a four-colourable graph glued at one vertex plus the centre
> star, which §6b proves four-colourable outright. **`n = 2` is not the discriminating case for anything.**

Two independent confirmations that this is the same configuration phase H3 is reopening: its "499 base
points" at radius 1.5119 is **exactly** the number my own enumerator returns for Parts's lattice at
`R = 4/√7` (PH3-10), and its "zero diagonal" is the brief's own "circle points, Parts's shape: 0".

Dropping the shape converts the diagonal count from 0 to 60. It says **nothing** about the off-diagonal
count, and the brief concedes as much (§3: *"nothing says `n = 2` has any"*). So the phase reduces to one
question, and the brief's §6 puts it fourth.

**Neither the brief nor the plan names this prior verdict.** The brief's §5 reading list points at §6l, §3,
§3a, §4, §6b, §6e, §6k and §7 of that file — but not at §6's `n = 2` bullet, which is the only passage in
the record about the exact object phase H3 proposes to build.

**What would change my mind:** a nonzero off-diagonal cross-edge count at `cos θ = 3/4` over the
shape-free lattice. I am measuring it; see PH3-9.

---

## PH3-9 — THE DECISIVE MEASUREMENT: the shape-free `n = 2` arena has 72 off-diagonal cross edges

**Claim under test (brief §3, plan §0 P-H3-4, plan §2 P-H3-5).** *"Nothing says `n = 2` has any"*
off-diagonal cross edges; the cross-edge law is where the phase will be decided; the brief puts this
fourth in its work order.

**Position: MEASURED, and it comes out POSITIVE. The phase survives its own decisive test, and it did not
need the module build, the closure analysis, or a solver to find out.**

**The full decomposition**, base `U` (16,309 points), `cos θ = 3/4`, four-conjugate cut at `R = 4/√7`:

| part | `n = 2`, shape dropped | the record, `ρ₁₅` on Parts's lattice at radius 2 |
|---|---|---|
| centre | **120** | 60 |
| diagonal | **60** | 30 |
| **off-diagonal** | **72** | 36 |
| total | **252** | 126 |

**Every component is exactly twice the record's.** I flag that as a pattern seen once and not explained —
it is a candidate, not a finding, and I tried and failed to explain it (PH3-12).

**Controls, all passed before the number was believed.**

1. **Positive, against the shipped code.** My enumerator, with `cos θ` as a parameter, against
   `tools/typem.py cross_edges_rho15` on `parts_lattice(2.0)`: **126 edges, identical as sets.**
2. **Negative, against my predecessor's independent verdict.** The *same* enumerator on Parts's lattice at
   `cos θ = 3/4` returns **60 = 60 centre + 0 diagonal + 0 off-diagonal** — reproducing
   `M63-phaseH2-the-family.md` §6's *"60 cross edges and every one of them is a CENTRE edge"* exactly. So the
   72 is not a systematic invention by my code: the same code returns zero on the neighbouring input.
3. **A second derivation of the law, from scratch**, never mentioning collinearity: with
   `ρ₂ = (3+i√7)/4` and `w = u − ρ₂v`, writing `w`'s two coordinates over `K(√7)` as `A+B√7`, `C+D√7`,
   `|w|² = (A²+7B²+C²+7D²) + 2(AB+CD)√7`, so `|w|² = 1` iff `AB+CD = 0` **and**
   `A²+7B²+C²+7D² = 1`. Expanding gives `AB+CD = (u₁v₂−u₂v₁)/4` (collinearity) and
   `A²+7B²+C²+7D² = |u|²+|v|²−(3/2)Re(ūv)` — the shipped law, re-derived. Every edge re-checked through it.
4. **Radius stability.** Growing the cut past the endpoint bound must not change the count.
5. **Direction-class histogram printed**, so an over-merged direction key would show as a class of
   implausible size: 6,180 classes, sizes `{2:5400, 4:360, 6:264, 8:60, 10:12, 14:24, 16:36, 20:12,
   60:6, 62:6}`.

**Where the 72 come from, since a count without a mechanism is a number.** On a line through the centre the
two cross-edge partners of a point satisfy `λ₁ + λ₂ = 2cos θ`, because `ρ(λ² − 2cos θ·λ + 1) = 1`. At
`cos θ = 3/4` the diagonal `λ = 1` therefore pairs with `λ = 1/2` — so *every circle point whose half lies
in the base would carry a free off-diagonal edge.* **It does not: 0 of the 60 have `u/2 ∈ U`** (28 have
integer half-numerators, none survives `U`). The 72 come from elsewhere, and the sample sits on a
**conjugate radius pair** `|u|² = 4/3 ± (2/9)√11` — structurally the same place the record's 36 sit
(`M63-phaseH2-the-family.md` §6a: *"the record's 36 sit on one conjugate radius pair"*).

**What would change my mind:** the radius-stability control failing, or an exact recomputation of
`|u − ρ₂v|²` disagreeing on any of the 72.

**What this does NOT say.** P-H3-5 scores on the **monochromatic** off-diagonal share under the residue
certificate, not on the raw cross-edge count. 72 is the raw count, the analogue of the record's 36 and
`ρ₆₃`'s 36 — **not** of `ρ₆₃`'s 24. I have not computed the monochromatic share and P-H3-5 remains open.
*Un-eliminated is not alive.*

---

## PH3-10 — P-H3-2 is met, and its stated mechanism is not why

**Claim (plan §0, P-H3-2).** Parts's lattice inside `R = 4/√7` holds about **506** points and none on the
circle; scoring band `[430, 580]`.

**Position: MET — 499, exact. But the reasoning attached to the calibration does not survive.**

**Grounds.** My enumerator returns **499**, on a run whose control reproduces his 1,603 at radius 2. The
number also lands independently: `M63-phaseH2-the-family.md` §6 records *"499 base points"* at exactly this
radius, so two agents on different days agree.

**Why the mechanism does not survive.** P-H3-1 justified stating a number by calling the instrument
calibrated: it predicts 1,550 against a measured 1,603, *"3.4% low, the expected sign for a boundary
effect."* At the H3 radius the same instrument on the same lattice predicts 506 against a measured **499**
— **1.4% HIGH**. The sign flipped. There is no "expected sign for a boundary effect" here; there is a
heuristic accurate to a few percent in either direction, which is all that was needed and all that should
be claimed.

**What would change my mind:** a third radius where the sign is stable.

---

## PH3-11 — Group closure and finiteness are free, as P-H3-4 predicted; the narrowing is honest but incomplete

**Claim (plan §0, P-H3-4).** Of the brief §3's three sub-unknowns — group-closed, finite under an exact
disk cut, joined by the cross-edge law — *"two of those three I expect to be free."*

**Position: UPHELD, and now measured. But it narrows only the FIRST of the brief's three UNKNOWN bullets,
and the third bullet is untouched and is the real one.**

**Grounds.**
- **Group closure: free.** All 60 unit vectors and all 60 circle points lie in `U`, and the order-24 group
  permutes the unit shell (it preserves `|p|²` as a `K`-element, and `gal(1) = 1`), so it preserves their
  span. Verified against the shipped `parts_group()` maps with a two-sided plant.
- **Finiteness: free, and cheap.** 16,309 points (PH3-3).
- **Cross-edge law: 72 off-diagonal** (PH3-9). So all three sub-unknowns of bullet 1 resolve favourably.

**What is left untouched.** Brief §3's third bullet — *"whether the resulting arena refuses four
colours"* — is not narrowed by anything measured here and is not claimed to be. With 72 off-diagonal edges
the §6b matching-only theorem does not apply, so it cannot be settled cheaply either way: `ρ₆₃` needed
20 core-hours. **"Two of three are free" is a true statement about one bullet, and reads as a statement
about the phase.**

---

## PH3-12 — RETRACTED BY ME: "dropping the shape = adjoining a √3-scaled copy of Parts's lattice"

**What I proposed, in the hypothetical mood, as an explanation of PH3-9's exact doubling.** Multiplication
by `√3` swaps Parts's two coordinate slots — `√3·ℚ(√33) = √3ℚ ⊕ √11ℚ` and `√3·(√3ℚ⊕√11ℚ) = ℚ ⊕ √33ℚ` —
so `K² = Shape ⊕ √3·Shape` as ℚ-spaces, and `√3` is a **similarity of the plane**. That would have made
"drop the shape" mean "adjoin a `√3`-scaled copy of his own lattice", which would have explained the
doubling of every cross-edge component at a stroke.

**Retracted: it is false.** `P + √3·P` has index **2304** in `ℤ⁸` and `U` has index **256** — so `U` is
**9× denser** than `P + √3·P`, and `U ⊄ P + √3·P` (checked both inclusions; only one holds). The ℚ-space
decomposition is correct and the lattice statement is not.

**The exact doubling in PH3-9 therefore stands unexplained**, and a `2` appearing four times in a row with
no mechanism is exactly the shape of thing this project's G21 says to distrust rather than celebrate.

---

## PH3-13 — The brief's own headline metric moves the wrong way: realised unit degree FALLS from 10.56 to 7.37

**Claim (brief §2 table).** *"unit vectors available: 60"* at `n = 2` against 30 at the record, sold as
*"twice its unit-neighbour count."*

**Position: REFUTED as a measure of anything the object will have. "Available" is a ceiling on a shell;
the realised mean unit degree of the shape-free base is 7.37, against 10.56 for Parts's lattice at the
identical radius — the brief's quantity doubles while the thing it stands for drops by 30%.**

**Grounds.** Same radius `R = 4/√7`, two lattices, my own enumerator:

| base | points | unit edges | mean degree | degree-0 vertices |
|---|---|---|---|---|
| Parts's lattice (shape) | 499 | 2,634 | **10.56** | — |
| shape-free `U` | **16,309** | 60,084 | **7.37** | **264** |
| (the record's arena, radius 2.0656, for scale) | 1,771 | 12,810 | 14.47 | — |

**The control passed on the nose:** my instrument returns **499 points, 2,634 unit edges, mean degree
10.56** for Parts's lattice — the three numbers `M63-phaseH2-the-family.md` §6 states, to the digit, and I
did not look at them until after the run.

**The mechanism, which is why this was predictable and should have been predicted.** Dropping the shape
multiplies the point count by **33** (499 → 16,309) and the unit shell by **2** (30 → 60). Unit degree is
bounded by the shell, so a lattice 33× denser with only twice the offsets is necessarily sparser per
vertex. **The rank went from 4 to 8; the unit shell is a shell and did not.** The brief's table puts
"circle points" and "unit vectors available" side by side as if both were yields; only the first is.

**Why it matters beyond bookkeeping.** `M63-phaseH2-the-family.md` §6 rejected thinness as the *reason*
`n = 2` died — *"its arena is 499 points with 2,634 unit edges and mean degree 10.56 against the record's
1,771 / 12,810 / 14.47, thin on two axes... True, but not the reason."* The shape-free object is thinner
still, and now carries 264 vertices with **no unit neighbour at all**. Those 264 are pure cost in any
solver instance and pure noise in any orbit census.

**What would change my mind:** a measured mean degree on the *arena* (base plus copy plus 252 cross edges)
rather than the base — cross edges add 252 edge-endpoints across 32,617 vertices, which will not move 7.37
— or an argument that mean degree is the wrong density measure here, for which the natural candidate is
the degeneracy or the densest induced subgraph, neither of which I measured.

---

## PH3-14 — The phase's stated prize does not exist as stated

**Claim (brief §1, §7).** *"If it works, the object is 7.1× smaller in arena radius than phase H2's and
sits in the same unsealed field"*; and, in acceptance, *"if `n = 2` works it will be smaller **and**
unsealed — but if it is merely smaller, it is worth less."*

**Position: REFUTED. Measured against the object the phase is trying to improve on, `n = 2` IS merely
smaller — by 36%, not 7.1× — and the brief's own acceptance sentence then rules on it.**

**Grounds, all measured.**

| | base points | arena vertices | arena radius | field |
|---|---|---|---|---|
| `[Parts2020a]`'s record, `n = 4` | 374 | 509 | 2.0656 | `K(√15)`, **5-sealed** |
| phase H2's verified object, `n = 16` | 25,567 | 51,133 | 4.0316 | `K(√7)`, **6-open** |
| phase H3, `n = 2` shape-free | **16,309** | **32,617** | 1.5119 | `K(√7)`, **6-open** |

- **Against phase H2's object:** same field, 36% fewer vertices. *Merely smaller.*
- **Against the record:** 64× **more** vertices. Not smaller at all.
- So there is no comparison in which `n = 2` is both smaller and better-fielded, and the brief's own §7
  sentence is the ruling.

**And "7.1× smaller in arena radius" is not a size statement.** `4.0316/1.5119 = 2.667`; 7.1 is its
**square**, an area. Worse, **a radius ratio does not give a vertex ratio here at all**, because the two
objects sit on modules of different rank: phase H2's is Parts's rank-4 shape module, whose count grows like
`r⁴` (`M63-phaseH2-the-family.md`'s own cost law, fixed by 1,603 at 2.0 and 3,433 at 2.44); phase H3's is
rank 8 and grows like `r⁸`. **The radius column and the vertex column are in different currencies and the
brief converts between them.**

**What the phase can still be worth, stated so it is not lost with the headline.** A 32,617-vertex arena is
**64% of phase H2's**, its halves are 16,309 against 25,567, and its radius is 2.67× smaller — so if it
refuses four colours it is a materially cheaper certificate for the same rung, and cheaper is the right
axis for FS-6, which has to *design* inside such an object rather than merely refute one. That is a real
case and it is not the case the brief makes.

**What would change my mind:** a use for the smaller radius that the vertex count does not capture — a
shorter coordinate tower, a smaller LRAT bundle, a feasible kernel promotion. The brief gestures at
*"a shorter cross-edge search and a smaller coordinate tower"* (plan §0) and never prices either.

---

## PH3-9 addendum — the verification, in full

All four controls on the 72 landed after PH3-9 was written, and all four pass.

| control | result |
|---|---|
| edge-**set** equality with the shipped `cross_edges_rho15` on `parts_lattice(2.0)` | **126 = 126, identical as sets**; 0 in mine not shipped, 0 in shipped not mine |
| the same enumerator on Parts's lattice at `cos θ = 3/4` (my predecessor's independent verdict) | **60 = 60 centre + 0 diagonal + 0 off-diagonal** — reproduced exactly |
| every edge re-verified through the `K(√7)` route that never mentions collinearity | **72 of 72** off-diagonal, **180 of 180** centre + diagonal |
| plant: 40 off-diagonal edges with a random second endpoint | **0** accepted |
| float cross-check on three edges | `1.000000000000000` each |
| **radius stability past the endpoint bound** — grow the cut from `R² = 16/7` to `R² = 2.5`, 16,309 → **23,353** points | **120 / 60 / 72, unchanged** |

**One of my controls failed to fire on its first run and I am recording it rather than quietly fixing
it.** The stability check was written as `build(3,1)` when the function's argument is `144R²`, so it built
a **one-point** base and reported `0 / 0 / 0`. It happened to fail *loudly* — the printed expectation was
`120 / 60 / 72` and the printed base size was `1 points`, so the cause was visible in the same three lines
— but that was luck in the formatting, not design. Re-run with `build(360,1)` it fires and passes. **A
control that returns zero because it was handed an empty input is `CLAUDE.md`'s oldest failure mode, and
the only reason it did not cost me the entry is that I printed the population beside the verdict.**

---

## PH3-15 — What I think is most likely to be wrong, and it is not any of the above

**The phase's remaining risk is not arithmetic, not closure and no longer the cross-edge law. It is that
the object is too thin to refuse four colours, and the one comparison that settles it has not been made.**

| object | vertices | edges | mean degree | refuses 4 colours? |
|---|---|---|---|---|
| phase H2's verified `n = 16` arena | 51,133 | 544,530 | **21.30** | **yes**, kernel-adjacent, 20 core-hours |
| `[Parts2020a]`'s record arena | 1,771 | 12,810 | 14.47 | yes (inherited — it contains Heule-510) |
| **phase H3's `n = 2` arena, as specified** | **32,617** | **120,420** | **7.38** | **unknown** |

Phase H3's candidate is **2.9× thinner** than the only object in this family whose refusal was *produced*
rather than inherited, and thinner than the record too. `M63-phaseH2-the-family.md` §6 already rejected
thinness once as *"true, but not the reason"* `n = 2` died — but it rejected it at **10.56**, and dropping
the shape takes it to **7.37** on the base and **7.38** on the arena, with **264 vertices of degree zero**.

**Why I rank this above everything else in the phase.** Every other unknown has been resolved favourably in
the last two hours and each resolution *added points without adding neighbours*: the shape-free module is
33× denser at the same radius, its unit shell only doubled, and the cross structure grew from 60 edges to
252 — 252 edges across 32,617 vertices. **The phase's whole mechanism for gaining material gains it in the
dimension that does not carry colour pressure.**

**What would decide it cheaply, in the order I would run it.**
1. **Degeneracy of the base.** A 5-chromatic graph needs a subgraph of minimum degree 4. If the base's
   4-core is small, the arena's refusal has to come from the 252 cross edges alone, which is implausible.
   Minutes, no solver. *(I launched this; see the addendum below.)*
2. **The §6b question, which is 20 seconds.** `M63-phaseH2-the-family.md` §6b: is there a proper
   four-colouring of the base in which no circle point takes the centre's colour? The theorem does not
   apply outright — 72 off-diagonal edges see to that — but a *yes* plus a check that the twist also
   satisfies the 72 is a four-colouring of the whole arena, and the phase ends in a minute instead of a
   day. `ρ₆₃` answered UNSAT in 20 s and that is the cheapest informative thing in this phase.
3. **Only then** the module build and the interface reduction.

**What would change my mind:** a large 4-core, or a densest-subgraph measurement showing the thinness is a
long tail of isolated points around a dense core — which is exactly what the degree histogram hints at
(25 vertices at the full degree 60, and 264 at zero). **Mean degree over an inhomogeneous graph is the
statistic this project has been burned by four times; I am quoting it with that warning attached, and the
core computation is the one that carries what it measures.**

---

## PH3-15 addendum — the degeneracy test does NOT confirm PH3-15's fear, and I am weakening the entry

**Measured**, same instrument, same peel, three bases:

| base | points | degeneracy |
|---|---|---|
| Parts's lattice at `R = 4/√7` | 499 | **7** |
| Parts's lattice at `r = 2` | 1,603 | **9** |
| shape-free `U` at `R = 4/√7` | 16,309 | **7** |

**A 5-chromatic graph needs degeneracy ≥ 4, and 7 clears it.** So the shape-free base is **not** refuted by
thinness in the currency that carries the necessary condition, and PH3-15's *"too thin to refuse four
colours"* is downgraded from a prediction to a concern. I record that as a partial retraction of my own
entry: mean degree fell and the degeneracy did not, so mean degree was the weaker statistic and I led
with it.

**What survives, sharper than what I wrote.** **Dropping the shape multiplies the point count by 33 and
buys exactly zero additional degeneracy (7 → 7), while Parts's own lattice gains depth from radius alone
(7 → 9 between `R = 1.5119` and `r = 2`).** So the phase's mechanism for gaining material is measurably the
one that does not deepen the graph, and the mechanism that does deepen it — radius — is the one the phase
gives up, and gives up on a rank-8 module where it costs `r⁸` (16,309 → 23,353 for `R²` from 2.2857 to 2.5).

**The honest statement of the risk, restated:** not *"too thin to be 5-chromatic"*, which the degeneracy
refutes, but *"the phase trades the axis that is measured to deepen this family for the axis that is
measured not to."*

**What would settle it:** phase H2's `n = 16` base's degeneracy, which I did not compute and which is the
only directly relevant comparison — its arena's mean degree is 21.30 against this candidate's 7.38, and if
its degeneracy is also 7 then the whole thinness line dies and PH3-15 should be struck rather than weakened.
**That is one run and it should be made before anyone acts on PH3-15.**

---

## Summary of dispositions

| # | subject | disposition |
|---|---|---|
| PH3-1 | the 60/0 split is the shape's doing | **upheld** (reproduced exactly, both modules) |
| PH3-2 | "twice the record's circle and unit-neighbour count" | **refuted** — both doublings are the shape-drop, at any `n` |
| PH3-3 | P-H3-1's covolume derivation and its band | **upheld**; measured **16,309** against `≈16,000` |
| PH3-4 | "index four in the denominator-12 one" | **refuted** — codimension 4, index infinite; contradicts P-H3-1 |
| PH3-5 | brief §6 step 1 asks about closure, not generation | **refuted step**; the trap costs 16× if executed as written |
| PH3-6 | *my* "half a million vertices" alarm | **retracted by me** |
| PH3-7 | P-H3-5's scoring threshold | **refuted** — two different quantities in one sentence |
| PH3-8 | `n = 2` already killed in phase H2, uncited | **upheld**; superseded by PH3-9 for the shape-free case |
| PH3-9 | off-diagonal cross edges at `cos θ = 3/4` | **measured: 72** — the phase's decisive unknown resolves **positively** |
| PH3-10 | P-H3-2 | **met** at 499; its "expected sign" reasoning refuted |
| PH3-11 | P-H3-4's "two of three free" | **upheld**, and all three now resolve favourably; narrows one bullet of three |
| PH3-12 | *my* "√3-scaled copy" explanation | **retracted by me** |
| PH3-13 | realised unit degree 10.56 → 7.37 | **refutes** the brief's "twice the unit-neighbour count" |
| PH3-14 | "smaller **and** unsealed" | **refuted** — merely smaller (36%), and 7.1× is an area ratio across modules of different rank |
| PH3-18 | the record's own base and arena | **degeneracy 7 both** — PH3-15 STRUCK; the candidate sits at the record's depth with 2× its off-diagonal edges; hand the solver the 25,201-vertex 4-core |
| PH3-15 | too thin to refuse four colours | **STRUCK by PH3-18** (was: weakened, then hardened: degeneracy 7 clears the bar, but phase H2's object measures **13** and depth in this family tracks radius alone — benchmarked against the wrong object) |
| PH3-16 | P-H3-5's threshold (product owner's retraction) and the pair it belongs to | **recorded**; the rule is *when two numbers are compared, exactly one thing may differ between them* |
| PH3-17 | the §6b question | **SAT**, twelve explicit additive witnesses in seconds where three solver configurations failed for ten minutes; **no twist of any clears the 72**, so the off-diagonal edges are load-bearing and nothing is decided |

**Retractions I caused: seven** (PH3-2, PH3-4, PH3-5, PH3-7, PH3-13, PH3-14, and PH3-10's mechanism).
**Retractions I made myself: three** (PH3-6, PH3-12, PH3-15 in part).
**Claims of the phase I could not dent: two** — the 60/0 arithmetic (PH3-1) and P-H3-1's derivation
(PH3-3), which is now measured rather than estimated.

## What is still open, and nobody has touched it

1. **Does the arena refuse four colours?** Brief §3's third UNKNOWN, unnarrowed by anything here. The
   cheapest informative move is `M63-phaseH2-the-family.md` §6b's question on the base — 20 seconds on
   `ρ₆₃`'s base, and here it is not decisive because of the 72, but a *yes* that also clears the 72 ends
   the phase in a minute.
2. **P-H3-5's actual quantity.** The **monochromatic** off-diagonal share under the residue certificate.
   I measured the raw count (72), which is the analogue of the record's 36 — **not** of `ρ₆₃`'s 24.
   And note `n = 2` fails gate A, so G52's free-defeat argument does not apply here and the share is a
   genuine quantity rather than a free one.
3. **The exact doubling** of every cross-edge component against the record (120/60/72 vs 60/30/36), with
   no mechanism (PH3-12 retracted the only candidate).
4. **Whether the maximal closed lattice `L` carries cross edges between its cosets.** Its internal unit
   graph is sixteen disjoint copies of `U`'s (PH3-5), but a cross edge joins the base to the *rotated*
   copy and could link cosets — so `L`'s **arena** need not be disconnected, and PH3-5's "sixteen
   disconnected copies" is correct about the base and **not** about the arena. Unmeasured; it is the one
   way the 16× larger module could earn its cost.
5. **Phase H2's `n = 16` base's degeneracy**, without which PH3-15 cannot be struck or confirmed.

## PH3-16 — P-H3-5's threshold, retracted by the product owner, and the pair it belongs to

**Retracted by the product owner, 2026-09-12, after PH3-7.** P-H3-5 scored an off-diagonal **raw count**
against `24/54`, which is G52's share of the **monochromatic** cross edges under the residue colouring.
Two different quantities; the threshold is withdrawn. Recorded here at his request, with the entry he
asked for: **it is the same error I caught in the brief, and the pair is more instructive than either.**

| | the two numbers compared | what differed between them | what the difference was attributed to |
|---|---|---|---|
| P-H3-5 (the product owner's) | off-diagonal **per circle point** at `n = 2`, against `24/54` | the **denominator** — one is a circle count, the other a count of monochromatic cross edges | the rotation |
| brief §2 (the brief's) | 60 circle points **shape-free at `n = 2`**, against 30 **shape-constrained at `n = 4`** | the **population** — one has the shape dropped, the other does not | the rotation |

**The rule, stated so it survives deleting both examples: when two numbers are compared, exactly one thing
may differ between them.** Both of these differed in two and credited the difference to one — and in both
cases the *other* thing was the change the phase was actually making, so the error flattered the phase
rather than harming it. That is the selection mechanism `CLAUDE.md` G21 names: a defect whose result
pleases is congratulated and kept.

**The check that catches it, and it costs seconds:** *write both numbers as fractions with their
denominators spelled out in words, and confirm the denominators name the same object.* On the brief's
unit-neighbour row the check ends immediately — the denominator of "unit vectors available" is the unit
shell `|p|² = 1`, which **does not contain `n` at all**, so that row cannot be a function of `n` and the
error is visible without computing anything. On P-H3-5 it ends just as fast: "per circle point" and "of 54
monochromatic cross edges" are audibly different denominators.

**This is the third instance in this milestone** of a number travelling with its value and without its
units — `CLAUDE.md` § What compute actually helps already records a per-ask-solve rate used as a
per-candidate cost (30×), a contended-wall timing used as a quiet-CPU cost (1.59×), and a mid-window ratio
used as a completed-window one (16× against 7×). Four now, counting these two, and **not one of the four
was a wrong measurement** — each was a right measurement of a different quantity, which is exactly why
none of them looked wrong.

---

## PH3-15 SETTLED — the concern HARDENS: degeneracy in this family tracks radius, and phase H3 proposes the shallowest object in it

**The run the product owner asked for.** Phase H2's verified `n = 16` base, Parts's shape and congruences,
cut at its endpoint bound `32/√63 = 4.031747`:

> **25,567 points** (exactly ledger row 64's `51,133 = 2 × 25,567 − 1`), 272,232 unit edges, mean degree
> **21.30**, **degeneracy 13**.

**Controls:** the same fast bucket peel reproduces **7** at 499 points and **9** at 1,603 points — the two
values my earlier slow peel returned — and the point count lands on 25,567 without tuning.

**The four measurements, which turn out to be one law:**

| base | lattice | radius | points | mean degree | degeneracy |
|---|---|---|---|---|---|
| Parts's, at phase H3's radius | shape | **1.5119** | 499 | 10.56 | **7** |
| **phase H3's candidate** | **shape-free** | **1.5119** | **16,309** | **7.37** | **7** |
| Parts's, at his own radius | shape | 2.0 | 1,603 | — | **9** |
| **phase H2's verified object** | shape | **4.0317** | **25,567** | **21.30** | **13** |

**Degeneracy in this family is a function of the RADIUS and not of the lattice's density.** At
`R = 1.5119` it is 7 whether the lattice holds 499 points or 16,309 — dropping the shape multiplies the
material by **33** and adds **nothing** to the depth. Radius alone takes it 7 → 9 → 13.

**[SUPERSEDED — see PH3-18. This entry's conclusion is STRUCK: I benchmarked against the wrong object.]**

**So the concern is upheld and I state it as the phase's leading risk, in the product owner's words.**
Phase H3 proposes the **smallest radius in the whole live family**, and radius is the only variable
measured to deepen these graphs. Its candidate's degeneracy is **7**, against **13** for phase H2's object.
*(An earlier draft of this sentence added "the same 7 carried by the 499-point object §6 declared dead".
**Struck, at the product owner's correction and rightly:** that object was declared dead because it has
**zero circle points**, a parity fact about Parts's coordinate slots, and not because of its depth — so
the rhetorical force of "the same as the dead one" was unearned by a true number. PH3-18 then made it
doubly wrong.)* **The phase's headline advantage, its 73%
radius, is the same number as its leading risk.**

**What this does NOT say, and the line matters.** Degeneracy 7 clears the necessary bar (a 5-chromatic
graph needs ≥ 4), so this is **not** a refutation and I am not offering it as one. It is a
**one-dimensional** comparison against a **single** positive instance, which is the weakest kind of
evidence this project accepts, and 13-versus-7 is a gap in a statistic, not a mechanism. *Un-eliminated is
not alive, and un-resembling is not dead.*

**What would change my mind, now specifically:** a second positive instance in this family at low
degeneracy — there is none, because phase H2's is the only produced refusal — or a demonstration that the
72 off-diagonal cross edges do work that degeneracy cannot see. The second is live: 72 edges cannot change
a degeneracy of 7 by more than a little, and yet the entire difference between a dead arena and a live one
in this family has always been the off-diagonal part.

---

## PH3-17 — Item 1, the §6b question: what it asks, and why it gates the whole twist family

**Registered before the run, per this project's own rule that both outcomes be named and reachable.**
- **Uninformative outcome:** UNSAT on every twist. `M63-phaseH2-the-family.md` §6b says so in its own
  words — the twist family is exhausted and *nothing is decided*. `ρ₆₃` sat exactly there.
- **Informative outcome:** SAT on some twist, which is a four-colouring of the whole arena and ends the
  phase in a minute.
- **Both reachable:** `ρ₆₃` returned UNSAT on the same question at 25,567 points; this base is far thinner
  (mean degree 7.37, degeneracy 7, 264 isolated vertices).
- **My prediction: SAT**, on the thinness.

**Three facts settled before the solver, which are worth more than the answer.**

1. **The base alone is four-colourable, guaranteed, with no solver.** Its points lie in `K² =
   ℚ(√3,√11)²`, and `chromaticNumber_seamPlane` (Theorem B, kernel-checked, ledger row 57) gives
   `χ(K²) = 4`. So there is no chance of the base *itself* being the object — which is gate B's content
   read in the other direction, and it is why `sin θ = √7/4 ∉ K` is load-bearing here.
2. **The residue colouring cannot be the witness, and for a reason §6b does not give.** §6b's stated
   reason is that a circle which is an even multiple of the unit shell is sent to the centre's colour —
   which does not apply at `n = 2`, since `2` is not a square and gate A fails. The reason that *does*
   apply is the valuation law (ledger row 59): the residue colouring identifies two `K`-points exactly when
   their distance lies in the prime above 2, and the centre-to-circle distance is `√2` with
   `v_𝔭(2) > 0`. **So the canonical four-colouring puts all 60 circle points on the centre's colour, and
   the §6b question is precisely a request for a four-colouring that is not the canonical one.**
3. **The §6b question gates the entire twist family, so one solve settles item 1.** A permutation `π`
   fixing the centre's colour must, on every diagonal cross edge, satisfy `π(C(v)) ≠ C(v)` — i.e. no
   circle point may carry a colour `π` fixes. A three-cycle on the other three colours fixes only the
   centre's, so its constraint **is** §6b's; a transposition fixes one more colour, so its constraint is
   strictly stronger. **Hence §6b UNSAT ⟹ every twist UNSAT**, and §6b SAT still has to clear the 72
   off-diagonal constraints, which is why I ran the full search rather than the question alone.

**Method note.** The encoding is at-least-one per vertex plus a per-colour clause on each edge, the centre
pinned to colour 0 by symmetry; 65,236 variables and ~301,000 clauses. Any model restricts to a proper
colouring and any proper colouring extends to a model, so the encoding is sound and complete in both
directions. Every SAT answer is re-checked by reading the model back and verifying properness, the circle
constraint and the whole arena independently of the solver; a planted `K₅` on five base vertices is the
negative control and must come back UNSAT.


### PH3-17, superseded interim — kept because the hardness it records is real

**Status at the time of writing: running.** `ρ₆₃`'s base answered this question **UNSAT in 20 s** at
25,567 points. The shape-free `n = 2` base, at **16,309** points — 64% the size — has had CaDiCaL at 100%
of a core for **minutes**, with two further configurations (`--sat`, `--unsat`) now racing the same
instance. The answer is not yet in; the *hardness* is.

**Why the hardness is worth recording separately from the answer.** The uninformative outcome here is
UNSAT, and UNSAT is **also what the object that worked returned**. So this question does not discriminate
in the direction the phase needs — `ρ₆₃` UNSAT and phase H3 UNSAT would be the same reading — and its only
decisive outcome is SAT, which ends the phase. I registered SAT as my prediction on the thinness, and the
run so far is evidence against my own prediction: a 4-colouring satisfying 60 extra unit constraints on a
degeneracy-7 graph should have been found in seconds if one were easy to find.

**Do not read that as UNSAT.** Local search failing and CDCL taking minutes are both consistent with a
satisfiable instance whose solutions are rare, and my own local-search implementation was poor enough that
I killed it rather than trust its plateau (1,188 monochromatic edges after 400,000 steps, with an O(|bad|)
vertex pick that made each step 2,000 operations). *A search that has not finished is not a verdict.*

**One thing the wait already establishes, independent of the answer.** The base's four-colourings are
**constrained**, which is the first sign in this phase that the shape-free object has any rigidity at all —
and rigidity is the property its degeneracy of 7 suggested it lacked. If the answer comes back UNSAT it
says the 60 circle points are **forced** onto the centre's colour in every four-colouring of the base,
which is a **compulsion at distance `√2`** and is permitted rather than barred by the valuation law
(ledger row 59: a forced pair needs `v_𝔭(d²) > 0`, and `v_𝔭(2) = 1`). **That would be the most interesting
thing in this phase, and it would be a fact about the base alone — no arena, no solver on 32,617
vertices.**


### PH3-17, ANSWERED — **SAT**, constructively, with twelve explicit witnesses; and the 72 are what stops them

**The §6b question: is there a proper four-colouring of the shape-free `n = 2` base in which no circle
point takes the centre's colour? — YES. Twelve of them, written down, no solver.**

**My registered prediction was SAT. It is met.** But not by the route I expected, and the route matters
more than the answer.

**What happened first, and it is the instructive part.** Three CaDiCaL configurations — the default, `--sat`
and `--unsat` — ran on the 65,236-variable instance for **over ten minutes without answering**, and so did
a stripped instance asking only *"is the base four-colourable?"*, **which is guaranteed SAT by a theorem
this repository has in the kernel** (the base lies in `K²` and `chromaticNumber_seamPlane` gives
`χ(K²) = 4`). A solver grinding on a question whose answer is a theorem is the signal to stop solving and
start deriving.

**The derivation, and it takes seconds.** An additive colouring — a homomorphism `φ` from the lattice to a
four-element group, nonzero on every unit vector — *is* a proper four-colouring (ledger row 50, G41), and
the §6b constraint is just `φ(c) ≠ 0` on the 60 circle points, since the centre is the identity. So the
question is a search over `Hom(U, ℤ/2 × ℤ/2)`: 65,536 candidates, exact, instant.

| | count |
|---|---|
| Klein-four homomorphisms proper on the lattice | **72** |
| …of those, also clearing all 60 circle points | **12** |
| ℤ/4 homomorphisms proper on the lattice | 4 |
| …of those, also clearing the circle | **0** |

**And the distribution is the interesting object**, because it recovers the residue colouring as a member:
over the 72 proper additive colourings, the number of circle points landing on the centre's own colour is
`{0: 12 colourings, 12: 6, 20: 36, 24: 12, 60: 6}`. **The six that put all sixty on the centre's colour are
the residue-type ones** — exactly as the valuation law predicts, since `|c|² = 2`, `v_𝔭(2) = 1`, and in
characteristic two `(c₁+c₂)² = c₁²+c₂² ≡ 0`. The canonical colouring is the worst possible witness for
§6b, and eleven other behaviours exist beside it.

**I got the quotient wrong on the first attempt and it failed loudly.** I first searched homomorphisms out
of `ℤ⁸` reduced mod 2 and found **zero** proper colourings, because 28 of the 60 unit vectors are even in
`ℤ⁸` coordinates — but `U` has index **256** in `ℤ⁸`, so mod-2 on `ℤ⁸` is the wrong quotient entirely. In
`U`'s own basis **no** unit vector vanishes mod 2 and 72 colourings appear. The tell was that the run
printed the population — *"28 of 60 unit vectors are 0 mod 2"* — beside the verdict, so a zero that would
otherwise have read as a finding read instead as a broken instrument. **Second time this session that
printing the population beside the verdict is the only thing that stopped a false negative.**

### And the follow-through, which is the phase-relevant half

**No twist of any of the twelve four-colours the arena.** For each of the 12 witnesses and each colour
permutation fixing the centre's colour with no fixed point on the circle's colours, I checked the 72
off-diagonal constraints `π(C(v)) ≠ C(u)`. **All fail.**

**So the 72 off-diagonal cross edges are measurably load-bearing.** Without them the arena would be
matching-only and §6b's theorem would four-colour it outright from any of the twelve — the phase would be
over. With them, every one of the twelve is blocked. **That is the first direct evidence in this phase that
`n = 2`'s cross structure does real work**, and it is the exact quantity PH3-9 measured and the brief
ranked fourth.

**Scope, stated at its own size.** This exhausts the **additive** twist family, not the twist family, and
not the arena's colourings. *Nothing is decided* — `M63-phaseH2-the-family.md` §6b's own words, and the
position `ρ₆₃` occupied before its 20 core-hours. **Un-eliminated is not alive.**

**What the kill forfeits, named out loud.** I stopped three CaDiCaL runs and the general twist search once
the constructive answer was in hand. What that forfeits is the **general** (non-additive) twist verdict —
whether some *non*-additive base four-colouring, twisted, clears the 72. The additive family is a proper
subfamily and its exhaustion does not settle the general one. The forfeited run was, on its observed rate,
not going to finish inside its 40-minute budget in any case, and the machine is shared with the arithmetic
engineer — but the forfeit is real and it is the next thing to run, **with a warm start from one of the
twelve rather than from nothing**, because a solver that could not four-colour this base unaided will not
do better on a harder instance cold.


## PH3-18 — PH3-15 is **STRUCK**: the record's own base is degeneracy 7, and so is its five-chromatic arena

**The product owner's challenge, and it was correct.** PH3-15 set phase H3's degeneracy 7 against phase
H2's 13 and called the phase shallow. **Phase H2's object is not the benchmark — `[Parts2020a]`'s
509-vertex record is**: it is five-chromatic, it is the cheapest such object anyone holds, and its base is
374 of the 1,603 points at radius 2, so measuring the *enclosing lattice* at that radius (my 9) was
measuring the wrong graph.

**Measured, from his own published vertex lists** (`data/m62/parts-ref11/JP/Large/*.vtx`, parsed exactly
by `tools/parts_vtx.py`). **Every filename carries its edge count, so each graph ships its own
known-answer control, and all six passed:**

| his file | vertices | edges (expected) | **degeneracy** |
|---|---|---|---|
| `v374e1860.vtx` — the record's base, subtype M6A | 374 | 1,860 ✓ | **7** |
| `v374e1864.vtx` — M6B | 374 | 1,864 ✓ | **7** |
| `v374e1868.vtx` — M6A | 374 | 1,868 ✓ | **7** |
| `v374e1872.vtx` — M6C | 374 | 1,872 ✓ | **7** |
| `v136e564.vtx` — the rotated half | 136 | 564 ✓ | 5 |
| **`v509e2442.vtx` — the record itself** | **509** | **2,442 ✓** | **7** |

**A five-chromatic unit-distance graph in this family exists at degeneracy 7. It is the record.** My
concern is therefore **struck entirely, not softened** — there is no depth deficit, because the depth in
question is exactly the depth of the object the whole family is named for.

**The comparison, rebuilt against the right benchmark:**

| | base degeneracy | arena degeneracy | mean arena degree | off-diagonal cross edges | five-chromatic? |
|---|---|---|---|---|---|
| **the record, `n = 4`** | **7** | **7** | 9.60 | 36 | **yes** |
| **phase H3's candidate, `n = 2`** | **7** | ~7 | 7.38 | **72** | unknown |
| phase H2's object, `n = 16` | 13 | — | 21.30 | 36 | yes |

**So the phase is not a deficit and not a rout — it is a candidate at the record's own depth carrying
twice the record's off-diagonal cross-edge pressure.** Phase H2's 13 is the outlier in the table, bought
with 2.67× the radius, and reading the phase against it was reading it against the most massive object in
the family rather than the canonical one.

**Mechanism of my miss, because it is the same one as PH3-6.** Both times I took the comparison class from
the document in front of me rather than from the question. PH3-6 inherited the brief's module; this
inherited phase H2's object, because phase H2's record is what I had just read. `CLAUDE.md`'s own warning
covers it exactly: *a record you have just read is a high-weight pattern.* **The fix that worked both times
was someone recomputing a number the frame said was already known** — mine in PH3-6, the product owner's
here.

**The one residual, stated at a fraction of PH3-15's weight and flagged as unverified by me.**
`M63-phaseH2-the-family.md` §6d states that the record's refusal is **inherited** rather than produced,
its arena containing a graph certified five-chromatic beforehand, while phase H2's `n = 16` object's
refusal is **produced**. If that holds, then the only *produced* refusal in this family sits at degeneracy
13 and the only degeneracy-7 five-chromatic object in it inherited its refusal. **I have not checked the
inheritance claim and it is not mine.** It is a reason to be curious, not a reason to withhold solver time,
and it does not restore PH3-15.

### The actionable consequence: hand the solver the 4-core, not the lattice

Four-colourability is decided by the **4-core** (a vertex of degree ≤ 3 is always colourable last), so the
raw lattice is the wrong object to encode.

| | vertices | 4-core | 5-core | 6-core | 7-core |
|---|---|---|---|---|---|
| phase H3's arena | 32,617 | **25,201** | 19,825 | 14,473 | 1,585 |
| the record's base (control) | 374 | **374** | 350 | 340 | 265 |

**A 23% free reduction** on the instance, and the control shows why it exists here and not there: the
record's base has nothing to peel, while the shape-free lattice carries a long low-degree tail (264
vertices of degree zero among them). That tail is what dragged the *mean* degree to 7.37 and it is exactly
the statistic I warned about while quoting it. **The degeneracy was the measure that carried what it
measured; the mean degree was not.**

