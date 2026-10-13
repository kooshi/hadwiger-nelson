# FS131-EN2 — two questions from the kernel planner of the five-colour chain: how much classical ergodic theory the two deductions read

*Ephodos (the deriver), 2026-10-13, from the brief `data/fs131/briefs/FS131-EN2-two-questions.md` and `plans/STANDING-RULES.md`. A
derivation job on a fixed claim list, `data/fs131/claims-EN2.md`. Working files and exact checks: `data/fs131/en2/` (the brief's
`touches:` names no path under `tools/`, so the checks live with the working files, as FS131-EN1's do). One mind throughout; no
second mind has read any of it.*

## Theorems this phase proved

*(one line each, grade per `CLAUDE.md` § Notation; filled in as the stages land)*

- (stage 1: none — the readback)

---

## Stage 1 — SAVED (the readback: the quotations, the names, and where each classical theorem is read)

### 1.1 Quotation check (standing rule 3)

`python3 data/fs131/en2/quote_check.py` prints `0 5` and `0 2`; with `--plant` (one character of each quotation changed) it prints
`5 5` and `2 2`. So:

| # | quotation in the brief | source | result |
|---|---|---|---|
| Q1 | W2, Kooshi's rule for what goes out | `data/fs131/REQUEST-2026-10-13.md`, the line beginning `W2:` | verbatim |
| Q2 | EN2-MEAN | `data/fs131/claims-EN2.md` § Statements | verbatim |
| Q3 | EN2-DECOMP | the same | verbatim |
| Q4 | EN2-NC | `data/fs131/claims-EN2.md` § Not claimed | verbatim |
| Q5 | "Whether a rearranged proof could live on convergence in mean …" | `plans/FS131-EN1-derivation.md` § 7.2, l. 550 | verbatim |
| Q6 | the claim list's two statements against the asker's record | `.claude/worktrees/fs131-wch/plans/FS131-KN3-chain-plan.md` ll. 396–399 and 400–402, line breaks joined | verbatim, both |

**One finding about the claim list (an address, not the sense).** EN2-MEAN says "Steps 4–5 (X01D ll. 226–246)". Those lines of
`plans/FS100-X01D-derivation.md` are Lemma 3.1′ with its proof (ll. 226–241; the section's own heading, l. 221, calls it "Step 1–2"),
a remark (ll. 243–244) and the heading of § 3.4 (l. 246). X01D's Step 4 is § 3.5 (ll. 268–277) and its Step 5 is § 3.6 (ll. 279–287).
The two addresses are the two ends of one question — the lines where the almost-everywhere theorem is *read* (l. 237–239, inside the
cited range) and the steps where its output is *consumed* at many scales — so I take the question to be about the whole passage, Lemma
3.1′ (iii) through Step 5. The question is well posed in that form.

### 1.2 What I read before any verdict (standing rule 10)

| work | read |
|---|---|
| `plans/FS100-X01D-derivation.md` | in full (436 lines) |
| `plans/FS100-X02D-derivation.md` | in full (355 lines) |
| `plans/FS100-X12B-derivation.md` | § 2.0 from l. 60, §§ 2.1–2.5 (ll. 60–165) |
| `plans/FS100-derivation.md` | the entries FS100-EFP, -EFZ, -PE1, -HX1, -PE2, -MR, -Q47 (ll. 155–215) |
| `plans/FS131-EN1-derivation.md` | § 7 and § 8 (ll. 497–646) |
| the asker's record, `.claude/worktrees/fs131-wch/plans/FS131-KN3-chain-plan.md` | Stages 4, 5 and 6 (ll. 157–424) |
| `[EinsiedlerFish2010]`, the library's PDF, text layer | § 2 and § 3 (Theorem 2.1, Lemma 3.1, Lemma 3.2 with their proofs; pp. 2–6) |
| the outside release (`~/source/math/lean/OAI/NumberTheory/`), read only, nothing built or run | in full, statements and proofs: `DukePrimeDegree/Dynamics/HopfMaximal.lean` (107 lines), `Dynamics/MaximalOccupation.lean` (120), `Geometry/DiscreteMaximal.lean` (82). Stored statements only: `PrimePackets/ErgodicDecomposition.lean` (the six general theorems; ll. 104–135 with the proof of one), `PrimePackets/EntropyMixtures.lean` (three), `PrimePackets/ShannonEntropy.lean` (five definitions, three theorems), `PrimePackets/KernelEntropy.lean` ll. 278–287 |
| Mathlib at this library's pin | `Dynamics/Ergodic/Action/Basic.lean` ll. 43–46 (`ErgodicSMul`); a search by name for a pointwise or maximal ergodic theorem under `Mathlib/Dynamics/BirkhoffSum/` (four files: sums and averages, the mean ergodic theorem; no maximal inequality, no pointwise theorem found by name) |

### 1.3 EN2-MEAN, with every name resolved

- **M8**: the asker's module for EF_F⁺ (its table, § Stage 6: "M8 | EF_F⁺ | 21, 18 | `zeroEntropyCarried`").
- **Lemma 3.1′**: X01D § 3.3, statement ll. 226–228, proof ll. 230–241. Its conclusion: for every `β, η > 0` there are `δ₀ > 0` and a
  Borel `X′` with `μ(X′) > μ(R̂) − η` such that `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ δ^β` for every `x ∈ X′` and every `0 < δ ≤ δ₀`.
- **The information function**: `I_n(x) := I_μ(ξ_n)(x) = −log μ(ξ_n(x))`, with `ξ_n = ⋁_{i<n} u*^{−i}ξ` (l. 232) and `ξ_n(x)` the atom
  of `x`; `H_n := H_μ(ξ_n) = ∫ I_n dμ` (μ normalised); `h_μ(u*, ξ) = lim H_n/n = inf H_n/n`.
- **Steps 3, 4, 5**: X01D § 3.4 (ll. 246–266), § 3.5 (ll. 268–277), § 3.6 (ll. 279–287). The second derivation: X12B § 2.2 steps
  2–5 (ll. 113–128).
- **EN1 § 7.2**: `plans/FS131-EN1-derivation.md` ll. 526–552.

**Where the classical theorem is read, and what is taken at each place.**

| place | what is read | what is taken from it |
|---|---|---|
| X01D l. 237–238, "(iii) SMB (EF Thm 2.1 …): `(1/n)I_μ(ξ_n)(x) → h_{μ_x^E}(u*, ξ)` a.e." | Shannon–McMillan–Breiman for a finite partition and an invariant measure that need not be ergodic | **an existence** (the almost-everywhere limit of `I_n/n`) **and an identification of the limit** (the entropy of the ergodic component) |
| X01D l. 238, "`∫ h_{μ_x^E}(u*) dμ = h_μ(u*) = 0` (Jacobs' integral formula), so the limit is `0` a.e." | the ergodic decomposition for `u*`, Jacobs's formula | **the value of the limit**: `0` almost everywhere |
| X01D l. 239, "By Egorov there are `X′` … and `N₀` with `μ(ξ_n(x)) ≥ e^{−nβ₁}` for `n ≥ N₀`, `x ∈ X′`" | Egorov | **a uniformity**: one set and one threshold for all `n` |
| X12B ll. 113–115 (step 2) | the same three, in one sentence | the same set `X′` and threshold `N` |
| `[EinsiedlerFish2010]` Lemma 3.1, p. 3–4 ("By the a.e. convergence in the Shannon-McMillan-Breiman theorem it follows that for every ε > 0 there exists a measurable set X′ ⊂ T with µ(X′) > 1 − ε and an N such that for every n ≥ N …") | the same theorem, for an ergodic measure | the same set and threshold |

**What is consumed downstream is one sentence**: *there are `X′` of measure above `μ(R̂) − η` and `N₀` with `μ(ξ_n(x)) ≥ e^{−nβ₁}` for
every `x ∈ X′` and every `n ≥ N₀`.* It is consumed (a) in (iv), ll. 239–241, to give the box bound at every `δ ≤ δ₀`; (b) in Step 3,
ll. 254–255, at the one scale `δ(M) = M^{−K}`, for the pigeonhole; (c) in Step 4, l. 270, at the two scales `M` and `M²` **for the same
point `x`**; (d) in Step 5, l. 283, at every scale `M, M², M⁴, …` for the same `x` ("each consecutive pair gives `z = 0`, so all share
**one** `t`"). Nothing else of the theorem is read: not the limit for a measure of positive entropy, not convergence in `L¹`, not
the lower half (`liminf I_n/n ≥ h`).

### 1.4 EN2-DECOMP, with every name resolved

- **M7**: the asker's module "PE-2: Lemma Γ; from `Γ` to `U`" (its table: "M7 | … | 20, 17 (T1) | `entropySplit`").
- **§ 3.2**: `plans/FS100-X02D-derivation.md` ll. 196–218, "From `Γ` to `U`: the advisor's route, written out and checked"; § 3.3
  (ll. 220–228) is "A second route".
- **T1**, as X02D names it (ll. 170–173): "ergodic decomposition for a countable group acting by homeomorphisms of a compact metrizable
  space — the invariant probability measures form a Choquet simplex whose extreme points are the ergodic measures, and the representing
  measure is unique." **T3** (l. 173–174): "(Jacobs): the entropy of `∫ρ dP(ρ)`, the `ρ` being `γ`-invariant, is `∫ h_ρ(γ) dP`."
- **The release's canonical form**, as stored (`PrimePackets/ErgodicDecomposition.lean` ll. 127–134):
  `theorem action_ergodic_decomposition {H Y : Type*} [Group H] [Countable H] [MulAction H Y] [mY : MeasurableSpace Y]
  [StandardBorelSpace Y] [Nonempty Y] (μ : Measure Y) [IsProbabilityMeasure μ] (hp : ∀ g : H, MeasurePreserving (fun y : Y => g • y)
  μ μ) : condExpKernel μ (actionInvariantSigma H Y) ∘ₘ μ.trim (actionInvariantSigma_le H Y) = μ ∧ ∀ᵐ x ∂μ.trim
  (actionInvariantSigma_le H Y), ErgodicSMul H Y (condExpKernel μ (actionInvariantSigma H Y) x)`, where `actionInvariantSigma H Y :=
  ⨅ g : H, MeasurableSpace.invariants (fun y => g • y)` (`KernelEntropy.lean` l. 278) — the strictly invariant measurable sets — and
  Mathlib's `ErgodicSMul` extends `SMulInvariantMeasure`, so the components are invariant as well as ergodic.

**Where T1 is read in § 3.2 and § 3.3, and what is taken at each place.**

| place | what is read | what is taken from it |
|---|---|---|
| l. 198, "`ν = ∫ ρ dP(ρ)` its `Γ`-ergodic decomposition (T1 …)" | existence, for the group `Γ ≅ ℤ²` | **an existence**: a probability `P` on the `Γ`-ergodic measures representing `ν` |
| l. 204–205, "From `u_*ν = ν` and the uniqueness in T1, `(u_*)_♯P = P`" | **uniqueness** of the representing measure | **a property of the pieces**: `P` is invariant under `u_*` (the title of step 1, "`U` permutes the components") |
| l. 206, "`a_Γ := P({m})`" | that `{m}` is a measurable set of measures | the number `a_Γ` |
| l. 208–209, "extremality gives `ν′_Γ = m`, but `m` is `Γ`-ergodic, so its representing measure is `δ_m`, while `ν′_Γ`'s is carried by `Z_Γ ∌ m` — contradiction (T1)" | **uniqueness** | **a property of the pieces**: an ergodic measure is not a mixture of other ergodic measures, so `a_Γ ∈ {0, 1}` for a `U`-ergodic `ν` |
| l. 216, "take its `U`-ergodic decomposition `τ = τ(R̂)∫ν dQ(ν)` (T1, `U` countable)" | existence, for the group `U` (countable, not finitely generated) | **an existence**: `Q`, and `a = τ(R̂)Q({m})` |
| l. 225 (§ 3.3, the second route), "T1's uniqueness identifies the pushed decomposition" | **uniqueness**, on the pieces `M̂_k` | the consistency of the non-Haar parts up the inverse system |

T3 is read at l. 207 and l. 217, each time as "a mixture of invariant measures of entropy zero has entropy zero" (the asker's § 4.2
reads it so too, and names the release's `measureEntropy_kernel_zero`).

**A first observation, to be tested in stage 3 and not yet a verdict.** Step 2 (l. 206–207) proves that `ν′_Γ` is `U`-invariant by
the formula "(it is `(ν − a_Γ m)/(1 − a_Γ)`)", which reads the invariance of `ν` and of `m` and nothing of step 1. If no later step
reads `(u_*)_♯P = P`, the citation at l. 205 is idle.

### 1.5 Would-have-searched-here log

- None: both questions are about what an argument reads.

---

## Stage 2 — SAVED (recognition: what each question is, before any verdict)

*`ephodos-recognition` invoked fresh and run on both claims. The sorted features carry their receipts; the two computed receipts are
the controls of stage 3. One mind.*

### 2.1 EN2-MEAN — the stall, the stranger, the features, the homes

**The stall, read.** Two shapes at once. *A known theorem that almost applies*: convergence in mean serves one scale and the chain
wants a sequence of them. And *a wall that describes a counterexample*: EN1 § 7.2 ends on "a summable rate along a geometric sequence,
which zero entropy does not supply" — a sentence about what a failure would carry. The description that moves such a question asks
what every measure of entropy zero does carry.

**For a stranger** (an ergodic theorist, or an information theorist who works on source coding). *A probability space `(X, μ)`, a
measurable `T : X → X` preserving `μ`, a measurable map `P` from `X` to a finite alphabet of `a` letters. The name of `x` of length
`n` is the word `P(x), P(Tx), …, P(T^{n−1}x)`; `[w]` is the set of points with name `w`; `H_n = −Σ_w μ[w] log μ[w]`. Suppose
`inf_n H_n/n = 0`. Is it true — and what is the least that proves it — that for every `β, η > 0` there are `N₀` and a set of measure at
least `1 − η` every one of whose points `x` has `μ[name_n(x)] ≥ e^{−βn}` for all `n ≥ N₀`? Nothing is assumed ergodic.* The reader
stops at no word. **This is the upper half of the Shannon–McMillan–Breiman theorem at entropy zero**; to the coder it is *a source of
rate zero has few typical names, and the ideal codelength `−log μ[name_n]` beats no code by more than a logarithm* (the second clause
recalled as Barron's lemma, not read; proved here in the one form used, § 3.5's last step).

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| entropy zero | **determines**, through one consequence: at one block length `k`, all but a given fraction of the mass sits on at most `e^{γk}` names (Markov's inequality on the terms of `H_k`) | the fair-coin shift: `μ[name_n] = 2^{−n}` everywhere, and the conclusion fails for `β < log 2` |
| `μ` is preserved by `T` | **determines**: it is what turns one block length into every length (the maximal inequality for visits to a set) | EN2-MEAN-MODEL (§ 3.4): functions `I_n ≥ 0`, non-decreasing in `n`, with `∫ I_n = o(n)`, no point good along any admissible chain |
| the rate at which `H_n/n → 0` | **accompanies** the conclusion (§ 3.5 holds at every rate); **determines** the Markov–Borel–Cantelli scheme | EN2-MEAN-SCHEME, EN2-MEAN-RATE (§§ 3.2–3.3); control `debruijn-marginals` |
| almost-everywhere convergence of `I_n/n` | **accompanies**: what is consumed is a set and a threshold, one-sided (§ 1.3) | § 3.5 runs with no limit taken |
| the identification of the limit (ergodic components, Jacobs) | **accompanies** | EN1 § 7.2's remark (Fatou); § 3.5 reads neither |
| Egorov | **accompanies** | the maximal inequality hands over the uniform set |
| ergodicity; invertibility of `T`; a standard Borel space | **accompany** | § 3.5 uses none |
| a finite alphabet | **determines** the count (`a` enters EN2-CNT's bound) | the count's factor `(2a)^{θn + k}` |
| consecutive scales in bounded ratio (Steps 4–5) | **determines** what is asked of Lemma 3.1′ | EN2-MEAN-WINDOW (§ 3.1): Step 4's product-formula bound closes exactly on a window |
| `I_n` is non-decreasing in `n` | **accompanies** the conclusion; it is what reduces "every scale" to a chain (EN1 § 7.2) | — |

**The homes.**

| home | the object's name there | its theorem | verdict |
|---|---|---|---|
| probability: convergence in mean gives almost-sure convergence along a subsequence (the asker's) | `I_n/n → 0` in `L¹` | Markov, then Borel–Cantelli along a sequence with summable bounds | **killed at one line of the dictionary**: "the subsequence is free" is false — Steps 4–5 fix the ratio of consecutive scales. Exactly: it works iff `Σ H_n/n² < ∞` (§ 3.2) |
| ergodic theory: Shannon–McMillan–Breiman (the costume's) | the information function | almost-everywhere and `L¹` convergence to the component's entropy | applies; reads the martingale theorem, a maximal lemma for conditional information, the pointwise ergodic theorem, and (as cited) the ergodic decomposition — of which the deduction consumes one one-sided set |
| ergodic theory and source coding: the count of typical names (Ornstein–Weiss's covering proof; a block code with a codebook of typical `k`-blocks) | a source of rate zero | long names are concatenations of few short ones off a sparse set of positions, so there are few of them | **adopted**. The one step that changes: the ergodic proofs count the bad positions by the pointwise ergodic theorem; with no ergodicity and entropy zero the count is by **the maximal inequality for an indicator**, and the good `k`-blocks are chosen by Markov's inequality, with no convergence theorem at all |
| geometric measure theory: "`μ` has zero dimension" (EF's own gloss on their Lemma 3.1) | upper local dimension along `v*` | — | **a mirror**: "upper local dimension zero almost everywhere" is the problem renamed; a single scale in measure is the *lower* dimension, and the upper one for an invariant measure is a theorem of dynamics again |
| a single scale and the dynamics of `u*` (shells of the `v*`-distance to a leaf, wandering under `u*`, on a tube about finitely many leaves) | — | Step 7's argument, moved to `v*` | **killed**: `u*` contracts at `σv*`, so `u*` carries a shell *into* the next and the shells' masses are only monotone; Haar measure gives every tube positive mass and every leaf none; and one element alone has zero-entropy invariant measures off the leaves. The chain of scales is not removable this way |

**What the adopted home predicts, checkable.** (a) Markov's step is special to entropy zero: at entropy `h > 0` it gives only
`μ{I_k > (h + γ)k} ≤ h/(h + γ)`, not small — so the argument should not extend to the upper half of the theorem at `h > 0` without an
ergodic theorem, and it does not. (b) With the release's `measureEntropy_eq_zero_of_good_names` (few names on most of the mass give
entropy zero) the lemma is a characterisation: entropy zero for `P` iff eventually-few names on a set of measure near one.

### 2.2 EN2-DECOMP — the stall, the stranger, the features, the homes

**The stall, read.** *A known theorem that almost applies*: existence is held, uniqueness is not. The first question is which
consequence of uniqueness each citing step consumes (§ 1.4's table: "a property of the pieces", three times).

**For a stranger** (a measure theorist). *A compact metrizable abelian group `X` with Haar probability `m`; a countable group `U` of
continuous automorphisms of `X`, for which `m` is ergodic; a `U`-invariant Borel probability `ν`. For each subgroup `Γ ≤ U` of a
certain family, it is known that every `Γ`-invariant, `Γ`-ergodic Borel probability on `X` is `m` or has entropy zero under each
`γ ∈ Γ`. Show `ν = a·m + τ′` with `a ≥ 0` and `τ′` a `U`-invariant measure of entropy zero under each `γ` of each `Γ` of the family —
one `a` and one `τ′` for all `Γ`.* **This is the Lebesgue decomposition of `ν` with respect to `m`**: `a·m` is the absolutely
continuous part (an invariant measure absolutely continuous to an ergodic one is a multiple of it), `τ′` the singular part. It is
canonical, so it is invariant under everything that preserves `ν` and `m`, and it names no `Γ`. In the costume's words: in the simplex
of invariant measures the face of an ergodic `m` is `{m}`, and the split of `ν` along that face and its complement is the Lebesgue
decomposition.

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| the representing measure `P` on the set of `Γ`-ergodic measures | **accompanies**: consumed only through `P({m})` and "the rest is off `m`" | § 4.2 never forms `P` |
| uniqueness of `P` | **splits**. Consumed (l. 209): *an ergodic `m` is not a mixture of ergodic measures other than `m`*. Not consumed (l. 205): the invariance of `P` under `u_*` | § 4.1 (l. 205 is read by no later step); § 4.2 step 4 (the components of the singular part charge an `m`-null set fully) |
| "`U` permutes the components" | **accompanies** | § 4.1; § 4.2 does not use it; it is true, by a computation (§ 4.4) |
| `U` abelian | **accompanies** PE-2's step from `Γ` to `U` (it is consumed by step 1 alone; Lemma W and the pieces read it elsewhere) | § 4.2 uses only `Γ ⊆ U` and that each `u` preserves `m` |
| `m` is ergodic for the acting group | **determines**: it makes the absolutely continuous part a multiple of `m` | without it: the mean of the Haar measures of two cosets of a subgroup of index two (FS100-PE1's second counterexample) is invariant, absolutely continuous to `m`, and no multiple of it |
| the `Γ`-ergodic decomposition exists | **determines**: Lemma Γ speaks of `Γ`-ergodic measures only | — |
| the `U`-ergodic decomposition (step 5) | **accompanies**: consumed only to assemble `τ′` | § 4.2 forms `τ′` as the singular part |
| a mixture of entropy-zero invariant measures has entropy zero | **determines** | the release's `measureEntropy_kernel_zero` |
| compactness; homeomorphisms | **accompany** the step (a standard Borel space and Borel automorphisms suffice for it) | the release's statement asks only `StandardBorelSpace` |

**The homes.**

| home | name there | theorem | verdict |
|---|---|---|---|
| Choquet theory (the costume's) | the simplex of invariant measures | a unique representing measure on the extreme points | applies; reads uniqueness |
| the canonical disintegration, with equivariance computed (the asker's) | the conditional measures on the invariant σ-algebra | `u_*κ(x) = κ(ux)` almost everywhere, because `u` preserves `ν` and the invariant σ-algebra | applies (§ 4.4) — but the cases survive the translation: the case `a_Γ ∈ {0, 1}`, the reduction to `U`-ergodic `ν` and the second decomposition all stay, and l. 209's uniqueness still needs a replacement |
| measure theory: the Lebesgue decomposition with respect to `m` | absolutely continuous and singular parts | existence and uniqueness (Mathlib) | **adopted**. Dictionary: `a_Γ·m` ↔ `ν_ac`; `(1 − a_Γ)ν′_Γ` ↔ `ν_s`; `P({m})` ↔ `ν_ac(X)`; "`P` off `m` is carried by `Z_Γ`" ↔ "the `Γ`-components of `ν_s` are almost surely not `m`"; `(u_*)_♯P = P` ↔ `u_*ν_s = ν_s`; "`a` does not depend on `Γ`" ↔ the decomposition names no `Γ`. The cases vanish: no `U`-ergodic case, no step 5. The one step proved anew: the components of `ν_s` are not `m` (one line, by singularity) |

**What the adopted home predicts, checkable.** (a) `a = ν_ac(X) = max{c : c·m ≤ ν}`. (b) PE-2's `τ′` may be taken **singular to `m`**
— more than FS100-PE2 states. (c) For a `U`-ergodic `ν`: `ν = m` or `ν ⟂ m` — the classical fact that distinct ergodic measures are
mutually singular, which is the ergodic form's first half. Each is derived in § 4.2–4.3.
