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
index four in the denominator-12 one.** Dropping it therefore cannot break ζ₆-closure; it can only enlarge.
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
