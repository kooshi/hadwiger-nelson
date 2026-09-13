# Phase H3 — drop the shape. Working plan and record.

*Opened 2026-09-12. Product owner's file: predictions registered before the experiments, the ordered
work, and the phase's findings as they land. The brief is `plans/M63-phaseH3-drop-the-shape.md`
(read it first); this file never restates it, it answers it.*

---

## §0 — Registered before anything ran (product owner, 2026-09-12)

**Why this section exists.** Phase H2's most expensive errors were statistics read off unrepresentative
populations, and the instrument that catches them is *a predicted quantity standing beside the measured
one* (`CLAUDE.md` § What compute actually helps). So the predictions go on record with their derivations,
so that a disagreement is forced into the open instead of being absorbed.

### P-H3-1 — The shape-free arena is BIGGER than Parts's, not smaller

The brief's table sells `n = 2` as **73% of the record's radius**. That is a statement about radius and
the brief never claims otherwise — but the natural reading, *and the one a reader will carry*, is that the
object is smaller. **I predict the opposite, by better than an order of magnitude**, because dropping the
shape doubles the module's rank and the count is governed by volume in twice the dimension.

The derivation, so it can be checked rather than believed. Write a point as
`p = (p₁, p₂)`, `p₁ = (a₀ + a₁√3 + a₂√11 + a₃√33)/12`, `p₂ = (b₀ + b₁√3 + b₂√11 + b₃√33)/12` —
**eight** integers where Parts uses four. `K = ℚ(√3,√11)` has four real embeddings, and the exact disk
cut asks that `(σp₁)² + (σp₂)² ≤ R²` at every one of them, so the admissible region in `ℝ⁸` is a product
of **four** disks of radius `R` and its volume is `(πR²)⁴`. The module's covolume is the square of one
coordinate's: the matrix sending `(a₀,a₁,a₂,a₃)` to its four conjugates factors as a `4×4` Hadamard matrix
times `diag(1, √3, √11, √33)`, so its determinant is `16 · √(3·11·33) = 16·33 = 528`, and at denominator 12
that is `528/12⁴ = 0.0254630` per coordinate, `6.48364e-4` for the pair.

At `R = 4/√7`, `R² = 16/7`: volume `(16π/7)⁴ = 2657.85`, so the count before any congruence is
**`4,099,300`**, and the answer is that divided by the index of whatever closure congruences hold.

| congruence index | predicted points inside `R = 1.5119` |
|---|---|
| 256 (all eight residues tied mod 2, plus one mod-4 condition — Parts's pattern, doubled) | **≈ 16,000** |
| 16 (only one coordinate-pair's worth of conditions) | ≈ 256,000 |

**The instrument is calibrated, which is why I am willing to state a number.** The identical computation
on Parts's own lattice at his radius 2 — two embeddings, not four, because his `|p|²` always lands in
`ℚ(√33)`; covolume `(2√33/144)² = 0.0063657`; index 16 — predicts **1,550** against his measured
**1,603**, i.e. **3.4% low**, the expected sign for a boundary effect. Applying the same correction:
**≈ 16,500** at index 256.

**Scoring.** Met if the measured count lies in `[12,000, 22,000]` (index 256) or `[200,000, 310,000]`
(index 16) and the index is what the closure analysis says it is. Not met if it is below 5,000 — which is
the interesting failure, since it would mean the shape-free module is *not* simply Parts's with four more
slots. **Both outcomes are reachable**: this is a count with no constraint tying it to any figure quoted
elsewhere, and the two brackets are disjoint.

**What it costs if I am right.** The arena is base plus rotated copy, so ~33,000 vertices at index 256 —
comparable to phase H2's 51,133 and **not** the small object the brief's radius column suggests. The
cheapness of `n = 2` is in its *radius*, which buys a shorter cross-edge search and a smaller coordinate
tower, and not in its vertex count.

### P-H3-2 — Parts's lattice inside `R = 1.5119` holds about 506 points and none on the circle

Same computation, his module, his two-embedding cut: `(16π/7)² / 0.0063657 / 16 = 506`. The brief's own
table says **0** of them lie on `|p|² = 2`, as a parity theorem. Predicting the total as well gives the
zero a denominator — *zero out of about five hundred* is a fact; *zero* alone is a number with no
population attached. **Scoring:** met in `[430, 580]`.

### P-H3-3 — The congruences are ζ₆-closure conditions, and the shape is one too

`tools/typem.py`'s own comment derives that `a ≡ b ≡ c ≡ d (mod 2)` is the ζ₆-stable form of his stated
`a,b,c,d ∈ 2ℤ`, and reports the radius-2 set measured closed under his order-24 group. **What is unrun is
the converse**: are those congruences *exactly* the closure conditions, or merely sufficient ones?

And a structural remark that belongs on record before the measurement, because it changes what "dropping
the shape" means: **Parts's shape is itself exactly ζ₆-stable.** Multiplying `p₁ + ip₂` by
`ζ₆ = (1 + i√3)/2` sends `p₁ ↦ (p₁ − √3 p₂)/2` and `p₂ ↦ (√3 p₁ + p₂)/2`; with `p₁ ∈ ℚ(√33)` and
`p₂ ∈ √3ℚ ⊕ √11ℚ`, `√3 p₂ ∈ ℚ ⊕ √33ℚ` and `√3 p₁ ∈ √3ℚ ⊕ √11ℚ`, so both slots return to where they
started. **So the shape is not an accident of how he writes coordinates — it is a ζ₆-submodule of `K²` of
rank four inside the rank-eight denominator-12 one — half the ℚ-dimension, not a finite index.** Dropping it therefore cannot break ζ₆-closure; it can only enlarge.
**Scoring:** met if the closure analysis confirms the shape is ζ₆-stable and the congruences are necessary
as well as sufficient; not met if either half fails — and the second half failing is the useful outcome,
because a merely-sufficient congruence is a free place to look for a smaller module.

### P-H3-4 — What I expect to go wrong

Not a prediction, a place to look. The brief's §3 says the unknown is *"whether a shape-free set attaining
60 can also be group-closed, finite under an exact disk cut, and joined by the cross-edge law."* Two of
those three I expect to be free — group closure by P-H3-3, finiteness by the four-conjugate cut. **The
cross-edge law is where I expect the phase to be decided**, and the brief's §6 step 4 is therefore the
step whose cost I am least willing to trim.

---

## §1 — Work in flight

| # | work | agent | state |
|---|---|---|---|
| 1 | closure conditions, known-answer gates, the shape-free module and its counts (brief §6 steps 1–3) | arithmetic | launched |
| 2 | prior-art half-hour on dropping the shape (brief §7) | prior-art | launched |
| 3 | advisor, restarted for this phase | Poros | launched |
| 4 | cross-edge enumeration at `cos θ = 3/4` (brief §6 step 4) | — | blocked on 1 |
| 5 | solver, via phase H2's interface reduction (brief §6 step 5) | — | blocked on 4 |

---

## §2 — Addendum, still before any measurement landed (product owner, same sitting)

### A correction to the natural misreading of P-H3-1

P-H3-1 says the shape-free arena is bigger than **Parts's**. It does **not** say bigger than phase H2's, and
the two comparisons point opposite ways. Setting them side by side so neither can be quoted alone:

| object | base vertices | arena radius |
|---|---|---|
| `[Parts2020a]`'s 509-vertex record | 374 | 2.0656 |
| his full denominator-12 lattice at radius 2 | 1,603 | 2 |
| phase H2's verified `n = 16` object | 25,567 | 4.0316 |
| **phase H3 predicted, `n = 2` shape-free** | **≈ 16,000** | **1.5119** |

So the honest sentence is: **smaller than phase H2's object in both vertices and radius, and about 43× the
record's vertex count at 73% of its radius.** "A smaller object" is false in every sense except radius.

### The step I think should move earlier, and why

The brief's §6 orders the work module-first (step 3) and cross-edges-second (step 4). **Part of step 4 does
not need the module at all**, and it is the step most likely to kill the phase.

G52's sharpened form says the live quantity for an object of this kind is not the circle count but the
**off-diagonal** share of the monochromatic cross edges — the part forced by neither the shared centre nor
the circle. The record's share is **0 of 30**; phase H2's `ρ₆₃` is **24 of 54**, and its refusal came through
**36 off-diagonal constraints**. The brief's own §3 concedes *"nothing says `n = 2` has any."*

And G52's other half is that **the cosine alone names the live radius sums, before any base exists**:
`d² = σ − (σ−1)/cos θ`, no radius and no lattice. So *"does `cos θ = 3/4` admit an off-diagonal cross edge
that a denominator-12 module of `K²` can realise?"* is answerable **now**, in parallel with the module
build, and a negative answer ends the phase in an hour rather than after an arena is assembled and solved.

**Decision: run it in parallel rather than in sequence.** The alternative weighed was the brief's own order,
which buys a module to enumerate over and so needs no base-free derivation — but it pays for the module
first and learns the decisive fact last. Confidence **high** that the reordering is right; **medium** that
the base-free derivation is clean enough to be decisive on its own, which is why it ships with the `n = 4`
and `n = 16` reproductions as known-answer gates rather than standing alone.

### P-H3-5 — registered before that work runs

**I predict `cos θ = 3/4` admits off-diagonal cross edges, but fewer per circle point than `ρ₆₃`.** Grounds:
`ρ₆₃`'s off-diagonal share is 24 of 54 at `cos θ = 31/32`, a cosine very close to 1, where the rotated copy
lies almost on top of the base and near-coincidences are plentiful; `cos θ = 3/4` is the coarsest rotation
in the whole live family and moves the copy furthest. **Scoring:** met if the off-diagonal count per circle
point at `n = 2` is strictly below `24/54 = 0.444`; not met if it is at or above; **not decided** if the
count is zero, which is a *different* finding and ends the phase rather than scoring this prediction.
**Both outcomes reachable** — the quantity is a count over an enumeration with no constraint tying it to
either side, and the two known members of the family already sit at 0.000 and 0.444, bracketing the range.

---

## §3 — The prior-art gate landed (2026-09-12)

Full record: `plans/M63-phaseH3-prior-art.md`. **The ground is not taken, but the idea is prior art, and it
sharpens the phase rather than weakening it.**

### What is not taken

No published five-chromatic construction uses a full field-plane vertex set — all six checked at the source
(de Grey, Heule, Parts, Exoo–Ismailescu, Voronov et al., Haugland) generate from a finite list of unit
vectors. The coincidence-site-lattice literature excludes our object **by definition** rather than by
oversight: `[BaakeZeiner2017]` §6 admits only submodules of the *same rank*, and `[BaakeGrimm2004]` only
*similarity* submodules. Ours halves the rank and lowers the symmetry; that literature has no word for it.

### What is prior art, and it is the interesting half

**The exact move was proposed on the Polymath16 blog on 19 April 2018 by Lior Silberman** — *"take points
each of whose coordinates is a point in the field"* — naming both obstacles (multiple real embeddings;
density making finiteness non-obvious), proposing lattice reduction as the fix, and saying *"I'll try
implementing this later."* **He never returned to it, and nothing follows it in 1,689,442 characters across
eighteen threads.** The full module is present in that corpus, studied as an infinite object by colouring
theory, and **never truncated to a disc and handed to a solver.** That is the gap this phase is in.

### The reframing, and it is not ours either

Parts's coordinate shape says exactly that his points lie in the **quartic CM field `ℚ(√−3,√−11)`** — the
Moser lattice's own field. The shape-free module lies in `ℚ(√3,√11,i)`. **So "dropping the shape" IS
"adjoining `i`" — adjoining the quarter turn.** That restatement is **David Speyer's**, 25 April 2018, with
the explicit basis `(a + b√−3 + c√−11 + d√33)/(2·3^k)`. That it was invisible here is a G49 vocabulary
failure and is recorded as one against us.

**Its structural consequence, now sent to the arithmetic engineer as a live question:** Parts's shape cannot
be `i`-stable, since multiplying by `i` swaps the coordinate slots and `ℚ(√33)` is barred from the imaginary
one. If the shape-free module *is* `i`-stable it is closed under `ζ₁₂`, and its symmetry group is order
**48** against his **24** — which would double the orbit rung and is not something to inherit by assumption.

### Two overclaims of ours that come out

Ruled on and handed back to the prior-art agent to fix in place:
1. **The spindle reading of the rotation family is on the Polymath16 wiki (2018)**, attached in words to
   `ω_t = exp(i·arccos(1 − 1/(2t)))` as *"the apex angle of a √t, √t, 1 isosceles triangle"*. `CLAUDE.md`
   G7 claims it as ours. It comes out. **What survives as ours: the radicand form, the field screen,
   6-openness, and dropping the Loeschian restriction.**
2. **`ρ₆₃` is the wiki's `ω₁₆` and already appears in de Grey's `ℤ[ω₁,ω₃,ω₄,ω₁₆]`.** Ledger row 64 does not
   say so. It will. The rotation is not new either; **what stays ours in that row is the screen that
   selected it, the 6-openness, and the produced refusal.**

### A second, independent reason `n = 2` was never examined

**The wiki's own rotation list is restricted to Loeschian `t`, and 2 is not Loeschian** — 3, 4 and 16 are.
This converges with, rather than contradicts, the phase's premise: two unrelated conventions both skip
exactly this rung.

### Registered consequence for P-H3-2

The prior-art agent re-derived *"0 circle points under the shape at `n = 2`"* by **Hasse local norms** — 2
splits in `ℚ(√33)`, `ℚ₂(√−3)` is unramified, so 2 has odd valuation and is not a local norm. That route
shares nothing with phase H2's derivation of the same fact, so **the two are a free two-sided positive
control on each other**, and the zero in P-H3-2 is now a theorem about the field rather than a count on one
lattice. The *denominator* in P-H3-2 (about 506 points) is still a measurement and still scores.

### A ruling on the one live reading debt

The cross-check surfaced **Zhuravlev, *Sums of squares over the Fibonacci ○-ring* (2007)** — by its title a
sums-of-two-squares count over the integers of `ℚ(√5)`, a **real quadratic** base, which is the case the
Baake–Zeiner survey's own inventory says nobody has done. It is uncharacterised (Russian original,
translation behind a paywall), and G50 says an unread title touching a live milestone blocks that
milestone's opening. **Ruling: it does not block phase H3, and here is the test it fails.**

This phase needs point counts on `|p|² = n` in a module of `K² = ℚ(√3,√11)²`, and it gets them by **exact
enumeration under a four-conjugate cut** — not from any formula borrowed from the literature. Zhuravlev's
base field is real quadratic where ours is biquadratic, and nothing of ours would rest on his count even if
it is exactly what the title says. **So it is a debt against a future write-up's attribution, not against
this phase's execution**, and it is recorded as one rather than discharged by being ignored. The
alternative weighed was chasing the translation now, which buys attribution we do not yet need at the cost
of the phase's opening hour. Confidence **high** — it flips only if the phase's counting turns out to need a
closed form rather than an enumeration, in which case this is the first place to look.

**And the finding that matters more than the paper:** it was reached only because the cross-check was run
properly. The first pass reported agreement between two databases and the agreement was an artifact of a
shared upstream record. Now installed in `CLAUDE.md` G49.

---

## §4 — The advisor landed: seven retractions, four of them mine (2026-09-12)

Full ledger: `plans/POROS-2026-09-12-m63-phaseH3.md`. **Every measurement below is the advisor's and is
pending independent confirmation** — the arithmetic engineer is re-deriving the module and the cross-edge
engineer the decomposition, both without being given these numbers. Nothing here wins by having been first.

### Scoring my own registered predictions

| | verdict |
|---|---|
| **P-H3-1** — the shape-free arena is bigger than Parts's by better than an order of magnitude | **MET.** Measured **16,309** points against a registered band of [12,000, 22,000] and a point estimate of 16,500 — **2% out**. The advisor tested the step most likely to fail, the volume heuristic in eight dimensions, and found it accurate to **0.5%**. |
| **P-H3-1's stated REASON for index 256** | **WRONG, and the right answer is the phase's most useful fact.** I guessed "Parts's pattern, doubled". The truth is that the base is **the lattice generated by its own unit vectors** — his 30 span an index-16 lattice, the shape-free 60 span an index-**256** one. The number was right for a reason I did not hold. |
| **P-H3-2** — about 506 points, and its "expected sign for a boundary effect" | **REASONING RETRACTED.** The sign **flips**: 3.4% low at radius 2, 1.4% **high** at `4/√7`. "The expected sign" was a story told about one data point. |
| **P-H3-3** — the shape is ζ₆-stable, and the congruences are the closure conditions | **HALF FALSE, AND IT MISDIRECTED.** The ζ₆-stability half is verified. The "index four" half I had already corrected. But the **whole framing was wrong**: closure is the weaker property with a *bigger* answer, and an agent answering it faithfully builds a **260,401**-point base — sixteen times too big. |
| **P-H3-5** — off-diagonal share below `24/54` | **THRESHOLD RETRACTED, by my own units error.** G52's `0 of 30` and `24 of 54` are shares of the **monochromatic** cross edges under the residue colouring; I scored a **raw count** against them. `CLAUDE.md` names this exact failure three times already — *a number in a ruling travels with what it measures, or the ruling is about something else* — and this is the fourth. |

### The brief's headline is refuted

*"Twice the record's circle count and twice its unit-neighbour count"* — **both doublings belong to dropping
the shape, not to `n = 2`.** The brief's own table shows 60 circle points at `n = 4` and `n = 16` as well,
and **the unit shell does not depend on `n` at all** (30 with the shape, 60 without, always). Worse, the
*realised* quantity moves the other way: **mean unit degree falls from 10.56 to 7.37** at the same radius,
with 264 vertices having no neighbour at all. The advisor's instrument reproduces phase H2's 499 / 2,634 /
10.56 to the digit, so the comparison is sound.

And **"7.1× smaller in arena radius" is 2.67× in radius** — 7.1 is its square, an area ratio. A radius ratio
gives no vertex ratio here in any case, because phase H2's object sits on a rank-4 module growing like `r⁴`
and this one on a rank-8 module growing like `r⁸`.

### The decisive unknown resolved — in the phase's favour, an hour early

Phase H2 had already killed `n = 2` by derivation over the **shaped** lattice: 60 cross edges, every one a
centre edge, **zero** diagonal and **zero** off-diagonal. **Neither the brief nor this plan cited that
verdict**, and the brief's reading list points at eight sections of `plans/M63-phaseH2-the-family.md` and
not that one. Dropping the shape revives it. Measured at `cos θ = 3/4` on the 16,309-point base:

> **centre 120, diagonal 60, off-diagonal 72** — exactly double the record's 60 / 30 / 36, component by
> component, which the advisor tried and failed to explain.

Controls: edge-set identity with the shipped enumerator (126 of 126, zero either way); the same code
returning 60/0/0 on Parts's lattice, reproducing phase H2 exactly; all 72 re-verified through a second
derivation that never mentions collinearity; the decomposition stable past the endpoint bound.

**So off-diagonal cross edges exist, and the matching-only theorem that would have killed the phase does not
apply.** P-H3-4 said the cross-edge law was where the phase would be decided; it was, and it passed.

### What the phase is actually worth, stated so it cannot be oversold

| | base | arena | radius | field |
|---|---|---|---|---|
| the 509-vertex record | 374 | 509 | 2.0656 | 5-sealed |
| phase H2's verified object | 25,567 | 51,133 | 4.0316 | 6-open |
| **phase H3 as specified** | **16,309** | **32,617** | 1.5119 | 6-open |

Against phase H2's object it is **merely smaller, by 36%, in the same field** — and the brief's own §7 says
an object that is merely smaller is worth less. **The real case, which the brief does not make:** 32,617
vertices with 16,309-vertex halves is a materially **cheaper certificate for the same rung**, and cheap is
the right axis for FS-6, which has to *design inside* such an object rather than refute one.

### The leading risk, and the one run that settles it

**Dropping the shape may buy material in a dimension that carries no colour pressure.** It multiplies the
point count by 33 at fixed radius and buys **zero** additional degeneracy (7 → 7), while Parts's own lattice
gains depth from radius alone (7 → 9 between 1.5119 and 2.0). Mean arena degree is **7.38 against 21.30** on
the only object in this family whose refusal was produced rather than inherited. **The phase trades the axis
measured to deepen this family for the axis measured not to.** Held as a concern, not a prediction —
degeneracy 7 does not refute 5-chromaticity. **Phase H2's `n = 16` base's degeneracy settles it**, and that
run is commissioned; if it is also 7 the concern is struck entirely.

---

## §5 — The module is built and independently confirmed (2026-09-12)

Record: `plans/M63-phaseH3-module.md`; tool `tools/shapefree.py` (`--self-test`, six sections, all green);
evidence under `build/m63-phaseH3/`. The arithmetic engineer reached index 16 / 256 and **16,309** through
two index routines sharing no code with the advisor's — hand-written integer Hermite reduction and
`sympy.hermite_normal_form` — so that number now has two independent derivations.

### The module, with every population attached

| lattice | index | points inside `R = 4/√7` | unit shell | `\|p\|² = 2` shell |
|---|---|---|---|---|
| **generated base** (span of the 60 unit vectors) | 256 | **16,309** | 60 | **60** |
| maximal group-closed | 16 | 260,401 | 60 | 60 |
| no congruence at all | 1 | 4,120,577 | 60 | 60 |
| Parts's own, same radius | — | **499** | 30 | **0** |

**Both shells hit the arithmetic ceiling already at 16,309** — density buys nothing on either, which is why
the 260,401-point object would have been pure cost. Every one of the 60 circle points is **mixed** (nonzero
in both slot halves), which is the sharpest statement of why Parts scores 0.

**Scoring:** P-H3-1 **met** (16,309 in [12,000, 22,000]; the raw pre-congruence count 4,120,577 against my
model's 4,099,300 is **+0.52%**, so the volume model is good to half a percent). P-H3-2 **met** (499 in
[430, 580], and **0 of 499** on the circle). P-H3-3a **met** and extended: the shape is ζ₆-stable and **not**
`i`-stable, so the shape-free module's rotation group is `⟨ζ₁₂⟩` and its symmetry group is order **48**, not
Parts's 24. P-H3-3b **not met for closure, met for the ring and for generation** — his congruences are
Gibbs's ring conditions (verified multiplicatively closed over 3,418,801 products, where the weaker module
fails) and are exactly the generation conditions.

### The finding that changes the outlook

**"Unit vectors available: 60" is misleading in the flattering direction.** Sixty exist; at the endpoint
bound a circle point has **2** of them as in-arena neighbours. The mechanism: **26 are inside on the first
embedding and 2 at all four.** The record and phase H2's object score **5–7 of 30** by the identical
measurement. Radius 2.0 gives 8–10; radius 2.5 gives all 60 at **56×** the points.

**So two instruments sharing nothing now agree the object is thin** — the advisor's degeneracy 7 → 7 and
mean arena degree 7.38 against 21.30, and this 2 of 60 against 5–7 of 30.

### The mechanism behind it, which is the phase's real trade and was never written down

**Parts's shape is exactly the condition that makes `|p|²` land in `ℚ(√33)`.** That is *why* his disk cut
carries **two** conjugate conditions and the shape-free one carries **four**. The shape is therefore not a
notational habit but **a device for making the disk cut cheaper**, and dropping it doubles the conjugate
constraints — which is precisely "26 inside on one embedding, 2 at all four".

> **Stated as a trade: dropping the shape buys twice the nominal circle points and twice the nominal unit
> vectors, and pays for it in realised connectivity at fixed radius.**

This belongs in the phase's findings whether the phase succeeds or fails. Out for verification.

### The question now outranking everything, and the lever it may open

The arithmetic engineer's own top ask: **the endpoint bound `1/|sin θ|` governs cross-edge ENDPOINTS, and it
may not govern the base's extent at all.** If a base may exceed it, both thinness findings are facts about a
radius nobody has to respect. Commissioned: what radius the record's 374-vertex base and phase H2's base
actually occupy relative to their own bounds, and a derivation of what does bound a base.

**And the reason the answer may be worth more than a corrected ratio.** By Theorem B the base lies in `K²`
and is **four-colourable however large it grows**, so base material can never force on its own and the
refusal must come through cross edges. Material beyond the endpoint bound therefore adds **no cross edges**
but **constrains which four-colourings the base admits**, cutting the set of patterns it can present on the
circle — and phase H2's entire refutation ran through that interface, its trust core being twenty claims
about exactly those patterns. **If that holds, growing the base past the endpoint bound is a free design
lever this family has never used**, since every object in it appears to have stopped at the bound. Whether
that is true of the record and of phase H2 is being measured rather than assumed.

---

## §6 — The cross-edge law, independently derived (2026-09-12)

Record: `plans/M63-phaseH3-crossedges.md`; evidence `build/m63-phaseH3-crossedge/`. Derived without being
shown the advisor's numbers, and it **confirms them exactly** — then adds the quantity that actually decides
these objects.

| | raw: centre / diagonal / **off-diag** | monochromatic: total / **off-diag** |
|---|---|---|
| `n = 4`, the record, Parts's lattice | 126 = 60 / 30 / **36** | 30 / **0** |
| `n = 16`, `ρ₆₃`, Parts's lattice | 126 = 60 / 30 / **36** | 54 / **24** |
| `n = 2`, Parts's **shaped** lattice | 60 = 60 / 0 / **0** | 0 / **0** |
| **`n = 2`, shape-free** | **252 = 120 / 60 / 72** | **84 / 24** |

**252 of 252 confirmed by direct exact distance, 0 invented**, and a brute force over 231,361 ordered pairs
using *only* the direct distance returned identical edges with 0 missed — the derived half checked against a
measured half, which is the discipline the refusal-is-the-suspect-verdict rule demands.

**The headline: `n = 2` carries exactly as many monochromatic off-diagonal cross edges as `ρ₆₃` — 24 — at
37.5% of its radius.** Its *share* is lower (24/84 against 24/54) only because its diagonal is twice as
large, which is the one-thing-may-differ rule applied correctly to our own result. All three known-answer
gates passed, including the third I asked be found: Parts's shaped lattice at `cos θ = 3/4` returns
60 = 60+0+0 at both cuts, reproducing phase H2's kill of `n = 2` exactly.

G52's `d² = σ − (σ−1)/cos θ` is **correct**, with an unstated scope now supplied: `sin θ ∉ K` and `u,v ∈ K²`.
The endpoint bound is a **consequence** of the law, not an assumption — which bears directly on the
commissioned question of whether it governs a base's extent.

### The two results that may outrank the object

The programme says the derivations matter an order of magnitude more than the objects, and this phase has
produced two candidate mechanisms, one of which **predicted out of sample**:

1. **A base-free counting law.** `ν·V = n d²` with `V = g² + gH + nH²` — the **principal form of
   discriminant `1 − 4n`**, the family's own radicand — and count per kind `Sh(n d²/V)`. **It reproduced
   `ρ₆₃`'s rational family `100/9 ↔ 64/9` before the agent looked it up.**
2. **A 2-adic budget criterion.** `v_𝔭(d²) = 2v_𝔭(g−h) + v_𝔭(n) − v_𝔭(V)`, where `v_𝔭(n) = 2v₂(n)` is the
   **member's entire budget — 2 at `n = 2`, 8 at `n = 16`.** It reproduces `ρ₆₃`'s 24 family-by-family, and
   *proves* no **rational** off-diagonal kind at `n = 2` can be monochromatic, while the base realises
   irrational ones that are.

**Commissioned: take both to the family.** Which members `n` can carry monochromatic off-diagonal cross
edges, and how many — a base-free screen of the decisive quantity, which is the kind of result this project
ranks above an object search. With the discipline that it must **retrodict all four known members** before
being extended, and a prediction registered on an unexamined member before looking, or it is a curve fit.

### Reconciliations and defects

- **Index 256 and 4096 are both right** — different ambient modules (`ℤ[√3,√11,√33]` against `O_K`, index 4
  per coordinate). **16,309 confirmed exactly**, now by a third route. And independently: **Parts's lattice
  is rank 4, not rank 8** — the shape halves the rank rather than thinning it, which is the fact the whole
  point-count prediction rests on.
- **Two defects, both flattering, exactly as G21 predicts.** The mutation harness broke **itself** through
  Python's bytecode cache — same size, same mtime second — and would have left mutated arithmetic running;
  only the restore check caught it. **This is the "loads two versions and identifies them by name" archetype
  wearing `(size, mtime)` as its costume**, and it is going into the record as that. And a first shape-free
  run returned **0 cross edges** from an unscaled lattice — a zero that reads as *"`n = 2` is dead"* — refused
  by the free two-sided control that centre edges must equal twice the unit vectors. **Third false zero
  caught today by printing a population beside a verdict.**
- **An image check passed at one parameter and failed at another**: the `K`-box found 2 of 2 measured kinds
  at `n = 4` and **0 of 6** at `n = 16`. Nothing in the answer rests on it; it bounds only the census of
  *unrealised* kinds. Reported rather than widened, which is right — widening a box until it agrees is how a
  check stops being one.

---

## §7 — The depth concern is struck, and solver work is commissioned (2026-09-12)

The advisor benchmarked phase H3's candidate against phase H2's object and concluded the phase proposed the
shallowest thing in the family. **I challenged the comparison class**: phase H2's object is not the relevant
benchmark, the **509-vertex record** is — it is five-chromatic, it is the canonical object, and its depth had
never been measured. It measured it, on `[Parts2020a]`'s own published vertex files, every file carrying its
edge count so each graph shipped its own known-answer control. **All six passed.**

| his file | vertices | edges | **degeneracy** |
|---|---|---|---|
| the record's base, four subtype variants | 374 | 1,860 / 1,864 / 1,868 / 1,872 ✓ | **7** each |
| the rotated half | 136 | 564 ✓ | 5 |
| **the record itself** | **509** | **2,442 ✓** | **7** |

> **A five-chromatic unit-distance graph in this family exists at degeneracy 7. It is the record.**

Not 9, not "≤ 9 possibly less" — **7**, on every variant and on the assembled arena. **The concern is struck
entirely**, its ledger entry bannered rather than deleted. Rebuilt:

| | base deg | arena deg | mean arena degree | off-diagonal | five-chromatic? |
|---|---|---|---|---|---|
| **the record, `n = 4`** | **7** | **7** | 9.60 | 36 | **yes** |
| **phase H3, `n = 2`** | **7** | ~7 | 7.38 | **72** | **unknown** |
| phase H2's object, `n = 16` | 13 | — | 21.30 | 36 | yes |

**So the phase is neither a deficit nor a rout: a candidate at exactly the record's depth carrying twice the
record's off-diagonal cross-edge pressure.** Phase H2's 13 is the outlier, bought with 2.67× the radius.

**By the rule I stated in advance — *"if the record comes in at 7, I commission it immediately"* — solver
work is commissioned.** A pre-committed trigger, fired on someone else's number.

### The mechanism of the advisor's miss, which it named rather than excused

Both of its misses took the comparison class **from the document in front of it** rather than from the
question — one inherited the brief's module definition, this one inherited phase H2's object because phase
H2's record was what it had just read. `CLAUDE.md` already warns that a record you have just read is a
high-weight pattern. **The fix that worked both times was someone recomputing a number the frame said was
already known.**

### A free 23% off the solver instance

Four-colourability is decided by the **4-core**, so the raw lattice is the wrong thing to encode.

| | vertices | 4-core |
|---|---|---|
| phase H3's arena | 32,617 | **25,201** |
| the record's base (control) | 374 | **374** |

**The control is what makes the reduction interpretable**: the record's base has nothing to peel, while the
shape-free lattice carries a long low-degree tail including **264 isolated vertices**. That tail is exactly
what dragged the *mean* degree to 7.37 — so **the degeneracy carried what it measures and the mean degree did
not**, cashing the caveat that was attached to the mean when it was first quoted.

### One residual, at a fraction of the old weight

`plans/M63-phaseH2-the-family.md` §6d holds that the record's refusal is **inherited** while phase H2's is
**produced**. If that stands, the only *produced* refusal in this family sits at degeneracy 13 and the only
degeneracy-7 five-chromatic object inherited its refusal. **Unchecked, and not the advisor's claim.** It is
step 1 of the solver brief — and it may be nearly free here, since `ℚ(√3,√7,√11)` contains no `√5` while
Heule-510/553 and de Grey's 1581 both carry it, so those cannot embed at any position or orientation.

### What is commissioned

1. **Produced or inherited** — the embedding check, field argument first.
2. **The general, non-additive twist verdict**, warm-started from one of the twelve additive colourings —
   buying back the forfeit the advisor named rather than let disappear.
3. **The interface reduction, PRICED BEFORE PAID.** Phase H2: 30 circle points, 19 colour patterns, 552
   interface patterns, 20 claims on 25,567-vertex halves, 20.03 core-hours. Here: **60** circle points and an
   order-**48** group, so the pattern count is the cost driver and is unknown. **Report the price before
   spending it.**
4. **Encode the 4-core, not the raw arena.**

---

## §8 — The endpoint bound does not govern the base, and growing it is provably free (2026-09-12)

The commissioned question came back with a derivation, two measurements that reframe the family, and a
theorem. Record: `plans/M63-phaseH3-module.md` §§5b–5d.

### The derivation

Collinearity forces `t² + s² − 2cos θ·t·s = 1`, positive definite, hence `t ≤ 1/|sin θ|`. **That is the
bound's entire content: no point beyond it is an ENDPOINT of any cross edge.** It says nothing about the
base's extent. Finiteness comes from the four-conjugate cut at every radius, and by Theorem B the base is
four-colourable however large it grows. **So what bounds the base is compute, and nothing else.**

### What the two existing objects actually do

| | relation to its own endpoint bound |
|---|---|
| `[Parts2020a]`'s 374-vertex base | **went past it, by 1.222×** — his outermost orbit reaches 2.5243 against a bound of 2.0656 |
| phase H2's `n = 16` base | **stopped exactly at it** — `576·256/63` *is* `144·(32/√63)²`, and 25,567 reproduced independently |

**And the sharper half: Parts's base is not a disk cut at all.** It is a selection of 37 + 14 orbits, which
reframes every "radius" comparison this project has made about his object. Reported with its ambiguity left
standing rather than collapsed — **12 of 509 vertices certainly beyond the bound, at most 27**, the certain
twelve coming from one orbit all of whose 24 members are present, so no choice of fillings avoids them.

### The theorem — phase H3's second family-level result

> **Every proper four-colouring of a larger base restricts to one of the smaller, so the colourings of the
> larger are a SUBSET. Therefore the set of interface patterns the base can present on the circle is
> monotone NON-INCREASING as the base grows, while the circle count is fixed. The refutation gets strictly
> easier and can never get harder.**

The counting compulsion (G53) is the special case: `L = min |B(h)|` is monotone non-decreasing, so
`2L > circle count` moves the right way and never back. **This converts "grow past the bound" from a hopeful
lever into a free one, and it is provable rather than measured.** It also means pricing the solve only at
the bound prices the *hardest* version of the problem — the instance's difficulty is driven by the interface
pattern count, and that count **falls** with radius.

### The corollary nobody saw coming, and it is about the family

**The circle sits at `√(1 − 1/(4n))` of the endpoint bound — 93.5% at `n = 2`, 96.8% at `n = 4`, 99.2% at
`n = 16`.** So **the circle is essentially on the arena boundary in every member of this family, by
construction.** Circle points are starved of neighbours because they sit at the rim, and growing past the
bound is the only thing that feeds them. That is a statement about the family, not about `n = 2`.

### The growth curve, and what is now being priced

| radius | base points | arena | circle degree, of 60 available |
|---|---|---|---|
| **1.5119** (the bound) | **16,309** | 32,618 | **2** |
| **1.7** | **41,953** | 83,906 | **4–6** |
| 2.0 | 150,769 | 301,538 | 8–10 |
| 2.5 | 898,069 | 1,796,138 | 60 — saturation, derivable from `\|q+s\| ≤ √2+1` |

**Both the bound row and the 1.7 row are commissioned for pricing.** The 1.7 row is **the record's own
realised connectivity** (its circle points carry 5–7) at an arena 1.64× phase H2's. If the pattern count
there is enough smaller to pay for the vertices, that is the instance to solve.

### What this does to the phase's two thinness findings

**Both survive as measurements and lose their force as verdicts.** The advisor's 7.38-against-21.30 and the
2-of-60 usable neighbours are facts about a radius nobody has to respect. Neither may rank the object; both
are reported with the radius attached.

### The shape trade, verified and quantified

Each conjugate condition beyond the first costs **~2.0–2.6×** in realised connectivity, independently —
step factors 2.50×, 2.60×, 2.00× imposing them one at a time, a clean geometric decay, with the
two-embedding objects' single extra condition at 2.23× inside the same range.

> **Dropping the shape buys 2× nominal — 60 circle points, 60 unit vectors — and pays two extra conjugate
> conditions, ≈2.3² ≈ 5.3×, in realised connectivity at fixed radius-relative-to-bound. Net ≈2.6× worse.**

Predicted circle degree `6.20 × 2/5.3 = 2.34` against measured **2.00** — the dominant effect, not the whole
of it, and stated as such.

### Two defects the engineer found in its own work

It read the orbit-fillings JSON's `degree` field as the orbit size (it is the *graph* degree; the centre's
row reads `degree 30, filling 1`), which made its first full/partial verdict meaningless — **caught and
recomputed before the table was reported**, a defect whose result would have flattered nobody. And it
corrected its own script's claim that first-embedding degree *"matches the Euclidean prediction"* to
**low by 13–25%, because the unit vectors are not uniformly distributed in direction** — keeping the ratio,
which is the measured thing, and discarding the absolute. **A right measurement of the wrong quantity is
this milestone's signature failure; catching one in your own output is the version that counts.**

### An inherited number under check

Phase H2's log reports `FREE CIRCLE: … unit degree in r=5 cut: min 30 max 30` — a **radius-5** measurement
two lines before that arena is built at 4.0316, where the shipped artifact's circle-point degrees are
`{5:6, 6:12, 7:12}`. The theorem is fine; the number is a property of a radius the arena does not use. **Out
for a propagation check** — with the caution that **30 legitimately appears throughout phase H2's record as
the COUNT of circle points**, and only 30-used-as-a-degree is the defect.

---

## §9 — The family screen did not land; the theorem under it did (2026-09-12)

### First, a correction to my own framing in §6

I called *"`n = 2` carries exactly as many monochromatic off-diagonal cross edges as `ρ₆₃` — 24"* the
phase's headline. **The count at `n = 2` stands as a measurement. The EQUALITY does not carry the weight I
put on it**, and the engineer flagged it against itself: the two arise by **different mechanisms**, the
family sizes differ (12 against 6), and 12 and 6 are the `ζ₆`-orbit sizes anyway. Registered by it as an
observation with its reason for being coincidence stated alongside — **a pattern recorded so it cannot later
be mistaken for a law**, which is worth more than a pattern quietly dropped. The weight is struck.

### The screen: NOT LANDED, and reported as such

Commissioned to eliminate members of the family base-free. Over `n = 1..300`, 40 members carry a rational
monochromatic kind — **but the instrument fails in both directions on members already measured**:

- **Under-reports.** `n = 2` scores **zero** and realises **24**, on an *irrational* case-A kind with
  `V = 9`. **The counterexample is this phase's own member.**
- **Over-reports.** `n = 4` lists two monochromatic kinds; Parts's lattice realises **none**.

It is a **floor on arithmetic availability, not a screen on members**, and it is the same generator-image
failure this milestone has now hit four times, firing on the family instead of on a base. **No member may be
eliminated from that list**, and the record says so rather than shipping a half-working screen.

### What survives, and it is stronger than the screen would have been

**A two-case theorem, with `V = n(g−h)² + gh` and the prime above 2 having residue field `𝔽₂`:**

- **Case A** — `g, h` both `𝔭`-units. Then `v_𝔭(V) = 0`, and `g ≡ h (mod 𝔭)` forces `e = v_𝔭(g−h) ≥ 1`, so
  `v_𝔭(d²) = 2e + v_𝔭(n) > 0`: **monochromatic for every `n`, odd included.**
- **Case B** — one of them divisible by `𝔭`. **Monochromatic iff `v_𝔭(gh) < v_𝔭(n)` — needs `n` even.**

**So my question — does `v₂(n)` as the budget make even and odd members separate? — is answered NO**, because
case A bypasses the budget entirely. The sharp form is better than the separation I hoped for:
**`n = 2`'s 24 are case A and `n = 16`'s are case B — two different mechanisms reaching the same count.**

**Retrodiction: all twelve measured families at `n = 2, 4, 16`, exactly**, including the case-A signature
`v_𝔭(|u|²) = v_𝔭(|v|²) = v_𝔭(n)`.

### Two out-of-sample landings, which is the evidence this project ranks highest

1. `ρ₆₃`'s rational family `100/9 ↔ 64/9`, **reproduced before being looked up.**
2. **P-XE-1, registered before measuring**, on `n = 3` — odd, so case B is unavailable, so both radii of every
   monochromatic off-diagonal edge must have `v_𝔭 = 0`, a region the apparatus need not enter since `n = 2`
   and `n = 16` sit at 2 and 4. Measured on 67,909 points: **300 = 120 + 84 + 96, all 300 confirmed, 0
   invented**, two monochromatic families, **both at `v_𝔭 = 0, 0`. MET.** And **the screen named the family
   in advance** — `t = 5/3`, `σ = 34/9` — with the measurement returning `t = 5/3` and radii `1` and `25/9`.
   **The law named the rotation parameter and both radii before the base existed.**

**Scope, kept attached:** 24 monochromatic off-diagonal constraints is not a refusal of four colours, and at
`n = 3` it provably cannot be, since `4n − 1 = 11` leaves the 2-adic wall unbroken. **Nothing here is a
colouring claim.** Commissioned: the two-case result written as a clean theorem — hypotheses, conclusion,
scope, and what it does *not* say — in the register a Lean formalisation could be built from, since the
programme's standard is that the mechanism is stated and proved for a class.

### Running tally of this phase's family-level results

| | |
|---|---|
| the two-case classification of monochromatic cross-edge kinds | retrodicts 12/12, two out-of-sample landings |
| **the monotonicity theorem** — the interface pattern set only shrinks as the base grows | derived (§8) |
| **the circle sits at `√(1 − 1/(4n))` of the endpoint bound in every member** | derived (§8) |
| the base-free counting law `ν·V = n d²` over the principal form of discriminant `1 − 4n` | derived (§6) |
| the shape trade: 2× nominal against ≈5.3× in realised connectivity, net ≈2.6× worse | measured (§8) |

**Four of these are about the family and not about `n = 2`** — which, if the object does not refute, is what
this phase will have been for.

---

## §10 — The propagation audit: three magnitudes moved, zero conclusions (2026-09-12)

Phase H2's radius-5 degree measurement **did** propagate — eleven sites across four of its plan files, three
of them load-bearing. `CLAUDE.md` is **clean**: ledger row 64, G52 and G53 use 30 only as a *count* (30
circle points, 30 unit vectors, `L/count = 10/30`), never as a degree.

| load-bearing site | what it decided |
|---|---|
| **Gate A's row** in the screening table | one of the four gates that selected `n = 16`: *"≥ 30 points at full unit degree, free"* |
| **the advisor's PH2-2/PH2-3 contrast**, *"degree 30 against 1"* | that the circle *count* is not the discriminator between good and bad circles |
| **the ranking row** demoting the briefed rotation | *"its circle points reach unit degree 1 where the record's reach 30"* |

> **Every comparison's direction survives — 5–7 still dominates 1 — so no gate verdict and no ranking moves.
> Three magnitudes changed and zero conclusions.** That is the good outcome of a propagation audit, and it
> is stated plainly rather than hidden or inflated.

**A judgement call, upheld:** the engineer *kept* the module-degree statements and added the arena value
beside them rather than replacing. Right, and the principle generalises — **the claims were not false, their
scope labels were ambiguous.** This project's rule that a corrected claim replaces the claim governs claims
that are *wrong*; deleting a true statement to fix a label is over-correction and loses information. Both
quantities now stand, each naming which it is.

### Two things the audit produced that outrank the audit

**1. The free-circle theorem's hypothesis has never been satisfied by anything.** Its condition — *"once the
arena reaches radius `|k| + 1`"* — was already correct, and is now marked load-bearing with the reason
nothing meets it: the circle sits at `√(1 − 1/(4n))` of the endpoint bound, so full degree at `n = 16` would
need radius **5** against a bound of **4.0316**. **A correct theorem whose hypothesis no object in the family
has ever met** says the free-degree promise has been decorative throughout — more useful than any corrected
number.

**2. The mean-degree comparison driving this phase's risk assessment was measuring the bulk.** Of phase H2's
25,567 base vertices, **8,208 (32.1%) sit at full degree 30, mean 21.29** — and its *circle* points are at
**`{5:6, 6:12, 7:12}`**. Its solver record's *"every interior point has degree exactly 30"* was true with
"interior" doing quiet work for the other two thirds; it now states the distribution.

**So 7.38 against 21.30 compared the wrong quantity.** What decides a cross-edge argument is the **circle
points'** degree:

| | circle degree | circle points | off-diag, RAW | off-diag, **MONOCHROMATIC** | arena |
|---|---|---|---|---|---|
| phase H2's verified object | **5 / 6 / 7** | 30 | 36 | **24** (share 0.444) | 51,133 |
| phase H3 at the endpoint bound | **2** | 60 | 72 | **24** (share 0.286) | 32,617 |
| **phase H3 at radius 1.7** | **4–6** | 60 | 72 | **24** (share 0.286) | 83,906 |

**Corrected after first being written with the raw column alone.** On the raw count this object is double;
**on the quantity G52 calls live it is EQUAL, at a LOWER share** — lower only because its diagonal is twice
as large. Which of share or count decides is genuinely open and is not being picked here: G52's text says
*share* while its recorded figures (`0 of 30`, `24 of 54`) are counts against a total, and for a refutation
what plausibly matters is the absolute number of constraints surviving the residue colouring. **Both are
reported, labelled, and neither may be quoted alone.**

**At radius 1.7 this object is at rough parity with phase H2's on circle connectivity, with twice the circle
points and twice the off-diagonal cross edges, for 1.64× the vertices.**

**This is the fifth instance in this milestone of a right measurement of a quantity adjacent to the
decision, and I amplified this one myself** — I carried 7.38-against-21.30 into two reports. The weight is
off, the corrected comparison is with the solver engineer, and the mean appears only with its caveat.

**What it does not settle, stated rather than assumed:** whether twice the cross-edge structure at
comparable circle degree is *better* than phase H2's or merely different — more circle points also means
more interface patterns to kill. **That trade is what the pricing measures**, so it is being priced rather
than argued.

---

## §11 — The mechanism is stated for the class (2026-09-12)

`plans/M63-phaseH3-crossedges.md` §12, 671 lines. **This is the phase's most valuable artifact**, and the
programme is explicit about why: the milestone that finds an object continues until the mechanism is stated
and proved for a class, and the paper is the algebra with the object as its example.

### A closed form that emerged while writing the theorem down, not before

> `V = n(g−h)² + gh`, and then `|u|² = ng²/V`, `|v|² = nh²/V`, `σ = n(g²+h²)/V`, `δ² = n(g−h)²/V`

**Four quantities homogeneous of degree 0, depending only on the kind**, replacing a working notation that
collided two meanings of `d`. Verified **4,000 of 4,000** against the original law and against every measured
family, with **the endpoint bound falling out as a corollary**. The engineer caught its own *"completing the
square"* as being on the wrong variable, fixed it to the exact quadratic in `τ = h/g`, and controlled the
result **20,000 of 20,000, zero violations** — a loose *phrasing* of a correct result, which is the class of
error nobody else would ever have found, because the conclusion was right throughout.

### Hypotheses surfaced that were being carried implicitly

**`(H1) √(4n−1) ∉ K` is load-bearing, not a convenience** — without it the arena lies in `K²`, Theorem B
four-colours it, and every statement in the section would be about a structure that can carry nothing. Also
surfaced: **`h(K) = 1`** (used in the line-structure lemma) and that **coprimality is only a
normalisation** — `t` fixes `(g,h)` up to a unit, `V` changes by a unit square, and every valuation and ratio
is invariant. **Hypotheses you did not know you were using are the ones a formalisation discovers the
expensive way.**

### §12.6 states what it does NOT say

Realisation gap first, with both failure directions named; then: not a colouring claim; one prime at a time;
this `K` only; coprimality is normalisation. **And the qualification that makes the two out-of-sample
landings a result rather than an overclaim: both predicted what a base WOULD realise and were right, which
is evidence for the law and not evidence that the realisation gap has closed.**

### The three-way 24 is now checkable, and it decomposes

`n = 3` has since come in at **24 as well** — three members. **Still coincidence, and now for a reason that
can be checked rather than asserted:**

| member | 24 arises as | case |
|---|---|---|
| `n = 2` | two families of size 12 | **A** |
| `n = 3` | two families of size 12 | **A** |
| `n = 16` | four families of size 6 | **B** |

**So it is not one coincidence among three: it is two members sharing a mechanism exactly, and a third
arriving by a different one.** The engineer's own framing of the danger is the right one — *a recurrence
that survives a third instance and still has no common mechanism is the kind that hardens into a law by
repetition if nobody writes the reason down.* It is written down.

**Commissioned, as the loose end that reframing opens:** is **24 a case-A constant** — does case A always
give exactly two families of size 12? Two of two is not a law, but `12` is the generic `ζ₆`-orbit size and
case A's defining condition leaves no free parameter once `O_K/𝔭 = 𝔽₂` forces `g ≡ h ≡ 1`, which is the
shape of something derivable. **And is `n = 2` unusual in being EVEN with case-A edges?** Odd members can
only be case A and are dead for refutation anyway (`4n − 1` leaves the wall unbroken), so the live
population is the even members — where `n = 16` is case B and `n = 2` is case A. **Two even members, two
mechanisms: either a dichotomy worth naming or a sample of size two.**

### A sixth instance of the milestone's signature error, and the fourth is mine

§10's table above originally carried the **raw** off-diagonal column alone, against phase H2's, implying
this object doubles the live quantity. **It does not — it equals it.** Caught by the arithmetic engineer,
**on the exact distinction I had told it to police two messages earlier.** Corrected in place above.

> **The pattern is now the finding: writing the rule down demonstrably does not install it, and what installs
> it is another reader recomputing the number.** Four of the six are mine. The instrument that works is not
> care and not the written rule — it is a second party with the standing to recompute and the instruction to
> do it.

---

## §12 — A landing struck, and the phase's premise confirmed at the record's own rotation (2026-09-12)

### The strike, and it was mine to carry

**P-XE-1 is VOID — untested, neither met nor unmet.** It tested the two-case theorem out of sample at
`n = 3`, where `4n − 1 = 11` and **`√11 ∈ K` by definition of the field** — so hypothesis `(H1)`,
`√(4n−1) ∉ K`, fails at the very member chosen to test a theorem whose load-bearing hypothesis it is. The
condition does not split there; law A is strictly stronger than the truth and enumerates a subset, and law B
demands the `√D`-part vanish, which is meaningless when `√D ∈ K` — **which is exactly why the two "agreed
300 of 300".** Demonstrated rather than inferred: from `u = (1,0)` alone, four non-collinear pairs at exact
unit distance that law A calls False.

**I had already carried that landing into this record and into a report as one of two out-of-sample
successes. It is struck.** And the engineer struck it itself, on its own instrument, against its own
interest.

**The mechanism, now installed in `CLAUDE.md`:** it *had written the fact down* — that `n = 3`'s radicand
lies in `K` — and **filed it under the wrong gate**, as *"so this member can never reach five colours"* (a
fact about the **member**) when the operative consequence was *"so my law does not apply here"* (a fact about
the **instrument**). **The same true sentence under the wrong heading becomes a note instead of a blocker.**

Consequences, bounded: the §9 screen needs an `(H1)` filter it lacked — `(H1)` fails for
`n ∈ {1, 3, 7, 19, 25, 37, 61, 69, 91, 127, 135, 169, 217, 223, 271}`, four inside its 40-member list.
**`n = 2`, `n = 4` and `n = 16` are unaffected; the gates, §0 and §12 stand.** And §11's reframing rested on
`n = 3`, so **the case-A sample was one, not two** — restored to two below, by a valid route.

### The premise, confirmed at the rotation everyone has used

> **At `n = 4` — the 509-vertex record's own member — dropping the shape turns 36 raw off-diagonal cross
> edges into 312, and 0 monochromatic ones into 144.**

Measured on 195,961 shape-free points: `492 = 120 + 60 + 312`, **492 of 492 confirmed, 0 invented**.
**Zero to a hundred and forty-four, at the rotation the record itself uses, by dropping a coordinate
restriction.** That is the cleanest possible demonstration that **the shape and not the rotation was the
obstruction** — which is the claim phase H3 was chartered to test, now confirmed at a member chosen for
being *unlike* this phase's own.

And a replacement out-of-sample landing, better than the void one: **P-XE-3 computed `Sh(64) = 12` while the
base was still enumerating**, predicting a count at a member picked for being unlike the training cases.

### `24` half-derives, and is still not called a theorem

**P-XE-4 NOT MET — the informative outcome.** `Sh(32) = 12` exactly, so the 12 is a property of the **kind**,
not of the base. The mechanism: `Sh(m) = 12·∏local(v_𝔮(m))`; the primes above 2 are **inert** in `K(i)/K`
(factor 1) and a prime over 3 **splits** (factor > 1), so **`Sh(m) = 12` exactly when `m` is a pure power of
2** — measured 6/6 on `2⁴…2⁹`, and 7/7 returning 36 or 60 once a 3-part is present. Case A forces `V` odd,
so `V | 9·odd(n)`, and `m = nD²/V` is a 2-power **iff `V` is the full odd part**; then `Sh(m) = 12`, two
orderings, **24 — derived.** **What is NOT proved is that case A forces `V` maximal**: a case-A kind with
`V = 3` would give 72. **Two for two observed, no proof, and it is not called a theorem.**

### The dichotomy dissolves — it was incomparable bases

**`n = 4` carries BOTH mechanisms**: 24 case-A and 120 case-B. So *"two even members, two different
mechanisms"* was an artifact of comparing unlike things — `n = 2` and `n = 4` measured shape-free,
`n = 16`'s case-B-only reading taken on Parts's **rank-4** lattice. **Nothing says `n = 16` lacks case-A
edges; only that Parts's lattice does not show them.** The three-way 24 is now fully explained *as*
coincidence with both sides derived: `n = 2` is `2 × 12` fully realised, `n = 16` is `4 × (12/2)`, halved by
a rank-4 base.

### The question this opens, and why the target probably survives

`n = 2` shape-free carries **24** monochromatic off-diagonal edges where `n = 4` shape-free carries **144** —
six times richer. But **`n = 4`'s field `K(√15) = K(√5)` is 5-sealed** and can never reach six, which is the
programme's target. **So: is `n = 2` the unique member that is both 6-open and affordable shape-free?**

Out for checking rather than asserted. The reasoning to verify or break: the arena radius `2n/√(4n−1)`
**increases with `n`** (1.512, 1.809, 2.066, … 4.032), so **`n = 2` is the cheapest member of the family,
period**; the shape-free module grows like `r⁸`, so `n = 16` shape-free at its own bound is of order **40
million points**; and its circle sits at radius 4, so no smaller radius reaches it at all. If that holds,
**the phase's target choice survives the engineer's own finding.**

---

## §13 — THE VERDICT: the object is four-colourable, at every radius, by derivation (2026-09-12)

Record: `plans/M63-phaseH3-solver.md`; certificate and standalone re-checker at `build/m63-phaseH3-solver/`.
**The phase's object is dead.** There was nothing to refute, so no sweep was priced and no core-hours were
spent — **the whole solver question cost under two minutes, because the answer was a derivation and not a
search.**

### How

A four-colouring of the arena is exactly a pair `(f, g)` of proper four-colourings of the **base** with
`f(0) = g(0)`, `f(v) ≠ g(v)` on the 60 diagonal cross edges and `f(u) ≠ g(v)` on the 72 off-diagonal ones —
**132 constraints on 121 interface vertices** (the 120 centre cross edges verified redundant). Searching `f`
and `g` **independently** over the additive family returns **576 passing pairs of 124,416, in 1.7 s.**

**And it is radius-independent by derivation:** additive colourings are homomorphisms on the whole lattice,
so they survive arbitrary growth, and the cross edges are pinned at 252 by the endpoint bound. Exercised at
**32,617 / 83,905 / 301,537** vertices — **0 monochromatic edges each.**

### Why it was missed, and the error in the chain is mine

The advisor searched **twists** (`g = π∘f`) and found none works. **Correct — and zero of the 576 is a
twist.** `g` need not be a permutation of `f`. **Third instance in this milestone of a generator whose image
excluded the target with its positive control passing, and the most expensive**: it kept the phase alive an
extra day. **The advisor stated its scope every time** — *"this exhausts the additive twist family, not the
twist family"* — **and I amplified it into "the 72 off-diagonal edges are measurably load-bearing", twice, in
reports. Load-bearing against twists is not load-bearing.**

### The four commissioned asks

| ask | answer |
|---|---|
| produced or inherited | **Vacuous** — a four-colourable graph has no five-chromatic subgraph. The field derivation is recorded anyway: every held witness but phase H2's own is excluded by needing `√5`, `√23` or `√247`, and the record's own file measures `√5 ×153, √15 ×78, √55 ×91, √165 ×73` while its 374-vertex base is pure `K` |
| general twist verdict | **Superseded** — a non-twist four-colouring exists, so the twist question decides nothing. No solver warm-started; none needed |
| interface pattern count | **≥ 3.83 × 10²¹** at the bound, **≥ 6.55 × 10⁴** at radius 1.7 — a certified lower bound from one colouring, no solver |
| priced cost | **Zero.** The reduction was never affordable at the bound — nineteen orders past phase H2's 552 — and there is now nothing to reduce |

**The monotonicity lever is real and enormous, and this is its first measurement: `10²¹ → 10⁴` for a 2.6×
base.** Right lever, wrong object — the additive colourings survive every radius.

### The phase's product: a base-free, radius-free, solver-free family screen

The registered prediction *"dropping the shape multiplies the colourings, and that is what glues it"* was
**NOT MET** — `n = 4` shape-free has the **same** 144 and **0 of 124,416** clear even the diagonal. The
actual mechanism is a theorem: **the colour group is 2-torsion, so if the circle `|p|² = n` lies in `2L`,
every additive colouring sends it to the centre's colour and the route dies.** Hence:

> **The additive-pair route is open exactly when `4 ∤ n`, and killed exactly when `4 | n`** — clean on all 19
> members `n ≤ 20`, with circle counts ranging 60–336 and the verdict **never tracking them**.

This is G52's *"automatic whenever `t` is even"* reached from the colouring side. **And it decides what comes
next: every 6-open member FS-30 lists — 16, 20, 44, 60, 64, 76, 108, 112 — is `≡ 0 mod 4` and immune.**

> **Phase H3 picked the cheapest member of precisely the class this route can kill.**

The cheapest untested 6-open member in the **open** class is **`n = 10`**, in `K(√39) = K(√13)`, at roughly
**6.6 million points** shape-free — beyond the present Python tooling, not absurd compiled. `n = 6` and
`n = 14` are 5-sealed.

**Scope, unchanged:** `4 ∤ n` means only that this route is **not blocked**. Each such member still needs its
own off-diagonal check. **Un-eliminated is not alive.**

### Two disagreements out for resolution, neither affecting the verdict

1. **144 against 72** additive four-colourings of the base — the solver engineer against the advisor, exactly
   double in every bucket, which smells of a quotient taken once too often or once too few. The solver ruled
   out the fatal correlation (a base missing edges would inflate the homomorphism count *and* manufacture a
   colouring) with a **field-blind brute force over 1.06 billion arena pairs** returning exactly the
   constructed edge set. Sent to the advisor to resolve, not defend.
2. **"Interface pattern count 1" for phase H2's object and for the record**, against phase H2's own recorded
   **552**. Those cannot be the same quantity, and the 552 is explicitly a **superset**. Out for
   clarification — **and if they reconcile, the number is worth more than this phase's object**, since it
   separates the two refuting objects from the dead one by twenty-one orders of magnitude and is computable
   **from the base alone, no arena and no solver.** Two positives against one negative is a hypothesis, not
   a criterion, and it will be recorded as one.

### The artifact

**47 KB certificate** plus a standalone `recheck.py` that reads only that file, rebuilds the base from
scratch at any radius, and reports — **proven to discriminate as a pair**: one flipped basis image gives
7,980 monochromatic edges and NOT PROPER, the restore gives 0 and proper. **A reviewer checks three things
and runs no solver**: that 60 vectors have `|z|² = 1`, that 252 pairs are at distance 1 under `ρ₂` and none
outside, and that a 132-row table scan has no clash. **Nothing is kernel-checked and no proof log exists,
because no solver produced one** — stated in those words.

---

## §14 — The reconciliation, and my promotion hypothesis is killed (2026-09-12)

**My guess was wrong and the engineer measured rather than adopting it.** The `1`-against-`552` gap is not
superset-versus-achievable. It is **local versus global freedom**:

| quantity | `ρ₆₃` | record | H3 @ bound | H3 @ 1.7 | `n = 4` shape-free |
|---|---|---|---|---|---|
| **(a)** local-freedom product — hold the base fixed *outside* the interface, recolour its vertices independently (lower bound) | **1** | **1** | ≥ 3.83e21 | ≥ 6.55e4 | ≥ 4.1e3 |
| **(b)** distinct interface patterns across the additive family (lower bound) | 12 | 12 | 132 | 132 | 144 |
| **true count** over all proper base four-colourings | **552** | — | — | — | — |

Known-answer check passes: **(b) = 12 ≤ 552** on `ρ₆₃`.

> **So the instrument is one-sided: it can certify "astronomically large" and can NEVER certify "small". A
> value of 1 is the instrument going silent, not evidence of rigidity.**

On `ρ₆₃` no interface vertex has local freedom — every one already sees three colours — while 552 whole-base
colourings still present 552 distinct patterns. **This is this file's oldest named failure mode, caught in a
headline number I was one message from promoting to a design criterion.** The "retrodicts phase H2 at exactly
1" reading is struck.

**What survives is apples-to-apples and still decides the phase:** phase H2's object has **exactly 552**
achievable interface patterns, enumerated; phase H3 at the bound has **at least 3.83 × 10²¹** of the same
quantity. **A true count against a valid lower bound on the same quantity — nineteen orders** — which is
what says the phase-H2 reduction was never affordable here.

**And a third object kills the promotion outright.** `n = 4` shape-free has (a) ≥ 4.1 × 10³ — also far past
552, also unaffordable by the phase-H2 route — **and is not killed by the additive pair (0 of 124,416).**

> **Large interface pattern count and additive-pair four-colourability are INDEPENDENT properties.**

So it is no longer a hypothesis separating two positives from one negative: a third object separates the two
*properties* from each other. **My "worth more than the object" reading is dead**, and it was killed in the
right way — by an object chosen to test it, not by an argument.

**Its real size, stated at that size:** a cheap **one-sided kill test** for whether the phase-H2 interface
reduction is affordable on a candidate, computable in **milliseconds** from a single base colouring. **It
rules candidates out. It can never rule one in.**

### On the 72, the sentence that survives

The advisor's twist result and mine agree on what the off-diagonal edges do: **they cut 14,400
diagonal-clearing combinations down to 576.** They do real work. **They simply do not cut it to zero, and
the twist family could not see the survivors.** *"Load-bearing against twists is not load-bearing"* is the
sentence to keep.
