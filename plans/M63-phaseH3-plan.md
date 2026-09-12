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
