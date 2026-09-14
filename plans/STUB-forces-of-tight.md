# FS-41 — `forces_of_tight`: Hoffman-tight Cayley graphs force everything in the eigenspace lattice (STUB, 2026-09-13; minted at the FS-38 close from phase D's kernel skeleton, `plans/FS38-derivation.md` § Kernel skeleton)

*Read beside: `plans/FS38-derivation.md` D-2 (a)–(c) (the theorem and its proof, by hand), D-3 (the classifier table),
`plans/FS38-residue-tower.md` §R2 (what the kernel holds at levels 4 and 5), `Proofs/HadwigerNelson/TwoAdicTower.lean`,
`Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`, `FanGap.lean`, `CLAUDE.md` ledger row 67 and G54,
`BIBLIOGRAPHY.md` `[Hoffman1970]`, `[Haemers2021]`, `[AbiadEtAl2025]`, `[GodsilMeagher2016]`.*

## 1. Mission context, in plain language

FS-38 found the mechanism behind the 2-adic tower's forcing, and it is not about the prime 2 at all. On a Cayley graph of a
finite abelian group — the vertices are the group's elements, two of them joined when their difference lies in a fixed
symmetric set S — the eigenvalues are the character sums over S. Hoffman's ratio bound says an independent set has at most
n·(−λ_min)/(d − λ_min) elements, with equality exactly when its indicator, minus its average, lies in the least eigenspace.
When λ_min = −d/(k−1) ("k-tight"; the literature's *Hoffman colorable*), a proper k-colouring's classes must all attain the
bound, so each class's indicator is a combination of the constant and the minimising characters, and the colouring is
constant on cosets of H_min, the common kernel of those characters — every pair with difference in H_min is forced equal by
every k-colouring, every class has n/k elements, and no vertex has a colour absent from its closed neighbourhood. That is
Theorem D2-A, proved by hand in six lines over Fourier inversion. It explains the 2-adic tower (tight at every level, H_min =
𝔓⁴ from level 5), the 3-adic tower at three colours (every 3-colouring of UD(ℤ/9, 2) is 3-periodic, a prediction met with no
solver), and why no residue plane above 3 forces anything at any colour count ≤ 7 (tightness needs (p+1)/(k−1) ≤ 2√p by
Weil, and only p = 3 is tight). Kooshi's programme says the derivation matters more than the objects; this stub is the
derivation in the kernel.

## 2. What we know

| fact | trust | where |
|---|---|---|
| Theorem D2-A: tight ⟹ balanced ∧ H_min-periodic ∧ gap-free | hand, six lines | `plans/FS38-derivation.md` D-2 (a) |
| the 2-adic tower is tight at every level (Lemma 1), H_min = 𝔓⁴ from level 5 (Lemmas 2–3, the lattice certificate) | hand; the level-4 spectrum computed; the certificate's elementary divisors 1, 2, 4, 4 by exact integer arithmetic on two code paths | D-2 (b)–(c) |
| level 4 pairwise free; level 5 forces exactly the kernel of the level map | **kernel** | `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean` |
| the 3-adic control: 3-tight at levels 1–4, four minimisers, H_min = 3·(ℤ/3^m)² from level 2 | exact character sums, two independent constructions; the ℤ/9 asks agree on two engines | D-2, P-D2 |
| balance and gap-freedom of a Hoffman colouring on a regular graph | prior art: Blokhuis–Brouwer–Haemers 2007 Prop. 2.3, via `[AbiadEtAl2025]` Prop. 2.1 | `BIBLIOGRAPHY.md` |
| the Fourier form (periodicity under H_min) and the tower propagation | not found in the literature (§PA of the FS-38 plan) | — |
| Mathlib has `AddChar`, orthogonality and Fourier inversion on finite abelian groups; the ratio bound is not in Mathlib | checked at phase D | `Mathlib/Analysis/Fourier/FiniteAbelian/` |

## 3. Derivations first

The statements, in the record's vocabulary (`Forces`, `addCayley`, `FanGap`):

```
theorem forces_of_tight {A} [AddCommGroup A] [Fintype A] [DecidableEq A] (S : Finset A)
    (hS : ∀ s ∈ S, -s ∈ S) (h0 : 0 ∉ S) (k : ℕ) (hk : 2 ≤ k) (H : AddSubgroup A)
    (htight : ∀ χ : AddChar A ℂ, -((S.card : ℝ) / (k - 1)) ≤ (∑ s ∈ S, χ s).re)
    (hker : ∀ χ : AddChar A ℂ, (∑ s ∈ S, χ s).re = -((S.card : ℝ) / (k - 1)) → ∀ h ∈ H, χ h = 1) :
    ∀ h ∈ H, Forces (addCayley (S : Set A)) k 0 h
theorem not_fanGap_of_tight … : ∀ (C : (addCayley (S : Set A)).Coloring (Fin k)) v γ, ¬ FanGap C v γ
theorem colorable_balanced_of_tight … : ∀ C c, (Finset.univ.filter (C · = c)).card * k = Fintype.card A
```

**D1 — the proof's shape.** The ratio bound is a real inequality about one independent set: write its indicator as
(a/n)·1 + z, expand zᵀMz = 0 against λ_min‖z‖², and read off a ≤ n(−λ_min)/(d − λ_min) with equality iff z is in the
least eigenspace. Summing over k classes forces every inequality to be an equality. The Fourier step: a function whose
support lies in characters trivial on H is H-periodic. Nothing needs the group to be a ring.

**D2 — the instances.** The 2-adic tower: tightness at every level by Lemma 1 (a pulled-back character's eigenvalue
doubles with the degree), the 45 minimisers at level 4 and their trivial common kernel by `decide` (sums of 24 fourth
roots of unity — a finite computation in `ℤ[i]`), the lattice certificate as a 4×4 determinant over ℤ[ω, √3]. The 3-adic
tower likewise. The finite planes: a `decide` at 3 (tight) and the slack verdicts at 7, 11, 19 by exact character sums.

**D3 — what it would promote.** Ledger row 67's "derived" for every level m ≥ 5 becomes kernel, G54's tight direction
becomes kernel, and the record has one theorem where it has two towers and a table.

## 4. Phases

| phase | what | cost |
|---|---|---|
| A | the ratio bound and its equality case over `AddChar`, in the Cayley form; `forces_of_tight` and its two siblings | 1–2 days |
| B | the 2-adic instances: `twoAdicPlane_tight` (Lemma 1), the level-4 minimisers by `decide`, the lattice certificate; `twoAdicPlane_forces_iff` for every m ≥ 5 | 1–2 days |
| C | the 3-adic instance and the finite-plane table (tight at 3, slack at 7, 11, 19) | half a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the theorem closes over Mathlib's `AddChar` with no new axiom and no `native_decide` | high |
| P2 | the level-4 minimiser count 45 and the trivial common kernel decide in the kernel under a minute | medium — the character sums are 256 × 24 terms in ℤ[i]; the cost is in the representation |
| P3 | the rhombus forcing at three colours over ℚ(√3) (row 58) is the 3-adic instance — the drawing checks against the tower | low-medium — the advisor's candidate, never checked; the falsifier is the rhombus's vertices failing to draw into UD(ℤ/9, 2) |

## 6. Bearing on 6, honestly

**Medium, mechanism only.** It finds no object. It makes the classifier a theorem, and a classifier that is a theorem
decides in advance where the residue method can force anything at all: nowhere at five colours over a field sealed by a
prime above 3, and only at tight quotients (FS-42) otherwise.

## 7. Addresses

`plans/FS38-derivation.md` (the proof), `Proofs/HadwigerNelson/TwoAdicTower.lean`, `Instances/TwoAdicFour.lean`,
`Instances/TwoAdicFive.lean`, `FanGap.lean`, `LocalGlobal.lean` (`card_le_chromaticNumber_mul_indepNum`), `build/fs38-d/`
(gitignored scratch: `spectrum.py`, `spanU1.py`, `recheck_lemma3.py`, `fpspec.py`, `tightsweep.py` — regenerable).
