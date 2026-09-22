# FS-70 phase 1c — the in-field rotation sweep: what landed

*Written 2026-09-22 by the phase-1c implementer (Opus 5), against the owner's phase-1c brief, the phase-1b
record `data/fs70/records/phase-1b.md`, and the owner's review `data/fs70/owner/review-phase1-2026-09-22.md`.
Machine: the desktop (16 physical cores / 32 threads, 125 GB). Every number names the command
that produced it.*

---

## 1. Headline

*(filled in at the close)*

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
defect in section 5.

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

*(filled in at the close)*

---

## 5. The asks

*(filled in at the close)*

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

### 6d. Self-test and plants

*(filled in at the close)*

---

## 7. Decisions

*(filled in at the close)*

---

## 8. Where the brief, phase 1b or the plan was wrong

*(filled in at the close)*

---

## 9. WORKFLOW step 9's two sweeps

*(filled in at the close)*

---

## 10. What a kill would have redone, and what is on disk

*(filled in at the close)*
