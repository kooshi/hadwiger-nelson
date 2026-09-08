# Theorem A in the kernel — the general residue colouring (pre-subplan stub)

*Written 2026-09-08 by Opus 5, immediately after B1 landed (`plans/STUB-field-wall-kernel.md` §B),
at Kooshi's direction: "I do want the general theorem kernel checked as well." Written before a
compaction so the shape survives it. Not yet subplanned; the WORKFLOW passes have not been run.*

## 1. The target

`plans/FIELD-WALL-THEOREM.md` §5.1, Theorem A:

> Let `F ⊂ ℝ` be a number field, `L = F(i)`, and let `𝔭` be a nonzero prime ideal of `O_L` fixed by
> complex conjugation (`𝔭̄ = 𝔭`). Then the unit-distance graph on `F²` is properly colourable with
> `N(𝔭) = |O_L/𝔭|` colours. Hence `χ(G(F²)) ≤ min { N(𝔭) : 𝔭 a prime of F(i) with 𝔭̄ = 𝔭 }`.

B1 proved the **instance** `F = ℚ(√3, √11)`, `N(𝔭) = 4`, by a route that never names a prime, a
valuation or a localization. This item is the general statement, which does name them.

Also unformalized and in scope if it comes cheap: **Lemma 5.2**, the factorization of `2` in
`ℚ(i, √3, √11)` — `2·O_L = (𝔭₁𝔭₂)²` with residue field `𝔽₄` and both primes conjugation-fixed. B1
does not need it (its two residue maps are exhibited directly); Theorem A instantiated at `K` would.

## 2. The split that the B1 experience suggests

B1's §8 is already the general argument with the arithmetic inlined. What made it work is not the
prime — it is four properties of a subring. So the work splits into an abstract rung and an
arithmetic rung, and the first is cheap.

**A1 — the residue colouring lemma (abstract, ~120 lines, no number theory).** Something close to:

```lean
theorem colorable_of_residue {A : Subring ℂ} (hconj : ∀ z ∈ A, (starRingEnd ℂ) z ∈ A)
    {F : Type*} [CommRing F] [Nontrivial F] [Fintype F] (ψ : A →+* F) (k : ℕ)
    (hk : Fintype.card F = k) {S : Set ℂ}
    (hS : ∀ z ∈ S, ∀ w ∈ S, dist z w = 1 → z - w ∈ A) :
    ((unitDistance ℂ).induce S).Colorable k
```

The proof is B1's §8 verbatim with `psiZero`/`oddDenom`/`F4` made variable: a unit vector `u ∈ A`
has `ū = u⁻¹ ∈ A`, so `ψ u` is a unit of `F` hence nonzero; every unit step stays in one coset of
`A`; choose representatives; colour by `ψ (z − base z)`. **B1's headline should then be re-derived
as its instance** — that is a subtraction from `FieldWall4.lean`, not an addition, and it is the
honest test that the abstraction is the right one.

*Note the hypothesis shape:* B1 does not need `A` to contain the points, only the unit-distance
differences. Keep it that way — it is what lets `S` be the whole plane over `F`.

**A2 — the arithmetic rung (the price lives here).** For a real number field `F` with `L = F(i)` and
a conjugation-fixed prime `𝔭` of `O_L`, the local ring `A = (O_L)_𝔭 ∩ ℂ` satisfies A1's hypotheses:

1. conjugation maps `A` to `A` (from `c(𝔭) = 𝔭`);
2. every unit vector lies in `A` — `v_𝔭(u) + v_𝔭(ū) = 0` and `v_𝔭(ū) = v_{c(𝔭)}(u) = v_𝔭(u)`, so
   `v_𝔭(u) = 0`;
3. the residue map `A → O_L/𝔭` is a ring hom onto a finite field of size `N(𝔭)`.

Step 2 is the whole content and it is two lines *given* the valuation's Galois-equivariance.

## 3. What to probe before writing a line (names NOT yet checked against the pinned Mathlib)

* `NumberField`, `NumberField.RingOfIntegers`, `IsDedekindDomain.HeightOneSpectrum` and its
  `valuation` / `intValuation`;
* Galois equivariance of the valuation — `IsDedekindDomain.HeightOneSpectrum.comap` along a ring
  automorphism, or whatever plays that role; **this is the load-bearing name and the first thing to
  find**;
* finiteness of the residue field and `Ideal.absNorm` = its cardinality
  (`Ideal.absNorm_apply`, `Ideal.fintypeQuotientOfFreeOfNeBot`, the `NumberField` instances);
* the embedding `L ↪ ℂ` and complex conjugation on it as a `RingHom` — B1 used `starRingEnd ℂ`
  directly because everything was already a subring of `ℂ`; the general statement has to place an
  abstract `L` in `ℂ` (an `Algebra L ℂ`, or quantify over a subfield of `ℂ` from the start).

**The last bullet was the modeling fork. Kooshi settled it, 2026-09-08:** *"the more general you
can make it, the more interesting it is. If you need to do the more simple case first before
returning again for the more general, that's fine."* So generality is the objective, the concrete
case is a permitted **stepping stone and not a substitute**, and a milestone that stops at a lower
rung says so and records the return. §3a is the ladder that direction points up.

## 3a. The generality ladder, and where the interesting rung actually is

Written down because "be more general" needs a target to aim past, and because the obvious reading
of it is the wrong one: moving from *a subfield of `ℂ`* to *an abstract number field with a chosen
complex embedding* is a phrasing change, not a generalization — the content is identical and the
proof is the same proof. The rung that pays is one further out.

| rung | statement | what it buys |
|---|---|---|
| 0 | `χ(ℚ(√3,√11)²) = 4` | landed (B1) |
| 1 | A1: any conjugation-stable subring `A ⊆ ℂ` with a finite quotient | the colouring stops depending on the field |
| 2 | Theorem A over a number field inside `ℂ` | the write-up's statement, with the arithmetic |
| 3 | Theorem A over an abstract number field + a complex embedding | *nothing* — the same proof, re-typed |
| **4** | **drop `ℂ`: the Cayley form** | the interesting one — see below |

**Rung 4.** The unit-distance graph on `F²` *is* the Cayley graph of the additive group `F(i)` with
connection set the norm-one group — the write-up's own §2 framing. Nothing in the colouring argument
uses `ℝ`, `ℂ`, distance or geometry: it uses an abelian group, an involution, the elements with
`u·ū = 1`, a subring containing them, and a homomorphism to something finite. Stated that way the
theorem covers the real plane, the finite planes, and any quadratic extension of any commutative
ring at once.

**That is not idle generality — this repository already holds two instances of it.**
`LocalGlobal.lean` has `addCayleyMap` / `addCayleyColoring` (a table proper along a connection set
colours the Cayley graph) and `Additive.lean` has `additiveColoring` (a homomorphism nonzero on the
edge differences is a colouring); `UnitQuadrance.lean` has the finite planes as
`unitQuadrance R` for *any* commutative ring. **First action of the subplan, before any new
statement is written: read those three and find out whether A1 is nearly free from them, or whether
they already are the general theorem with the norm-one condition missing.** If they are, the work
is smaller than §2 prices it and the payoff is larger — one theorem under `FieldWall4`,
`Additive`, `LocalGlobal` and the finite-plane bound together.

**Staging, then.** A1 (rung 1) first, because it makes `FieldWall4` smaller and is the shape of the
argument in isolation; then rung 4 if the reading above holds, with rung 2 as its corollary; rung 3
only if someone asks for the write-up's exact phrasing. Rung 2 alone is an acceptable stopping
point *with the return recorded* — that is Kooshi's licence, not a licence to stop at rung 2 by
default.

## 4. Risks, and the stop rule to register

* Mathlib's Dedekind-domain valuation API is the one place this could balloon. **Stop rule to
  register in the subplan: if the Galois-equivariance of `v_𝔭` is not available within ~150 lines,
  land A1 alone** (which is real, reusable, and makes `FieldWall4` smaller) and report A2 as not
  landed with the exact missing statement named.
* A1 is worth doing even if A2 never lands, and it is worth doing FIRST for that reason.
* Nothing here is new mathematics; it is the repository's own standard applied to a statement the
  project already relies on. The publication bar is untouched.

## 5. Ground rules carried over (`plans/BACKLOG-FOR-OPUS.md`)

Branch `backlog`; never `lake build` (use `./scripts/build.sh`); one heavy job at a time; register
new theorems in `scripts/Axioms.lean`; do not edit `CLAUDE.md` § Frontier / § Grokkings or the
frontier-set ranking; results go into a `## §B. Built` section of this stub.
