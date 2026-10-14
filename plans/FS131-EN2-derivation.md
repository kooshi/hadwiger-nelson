# FS131-EN2 — two questions from the kernel planner of the five-colour chain: how much classical ergodic theory the two deductions read

*Ephodos (the deriver), 2026-10-13, from the brief `data/fs131/briefs/FS131-EN2-two-questions.md` and `plans/STANDING-RULES.md`. A
derivation job on a fixed claim list, `data/fs131/claims-EN2.md`. Working files and exact checks: `data/fs131/en2/` (the brief's
`touches:` names no path under `tools/`, so the checks live with the working files, as FS131-EN1's do). One mind throughout; no
second mind has read any of it.*

## Theorems this phase proved

*(one line each, grade per `CLAUDE.md` § Notation; filled in as the stages land)*

*All [hand], one mind, no second mind; the two computed checks are complete enumerations of small finite sets. None is claimed new.*

- **EN2-MEAN** — the asker's scheme (Markov on the information function, a subsequence with summable bad sets) — **not derived: stalls at the choice of the subsequence** — § 3.0
- **EN2-MEAN-WINDOW** — two runs of Step 3 at heights `M₁ ≤ M₂`, thinnesses `δ₁ ≥ δ₂`: `∏|z|_v ≤ (16ε)^{[L:ℚ]}·M₁³·M₂³·δ₁`; the pair `(M, M^c)` closes when `K > 3 + 3c` — [hand] — § 3.1
- **EN2-MEAN-SCHEME** — Markov's bounds are summable along an admissible sequence of scales iff `Σ_n H_n/n² < ∞` — [hand] — § 3.2, § 3.2′
- **EN2-MEAN-RATE** — a shift-invariant measure of entropy zero with `H_n ≥ (6 log 2/π²)·n/(1 + log₂ n)` (a mixture of de Bruijn orbits) — [hand; one step computed exactly, control `debruijn-marginals`] — § 3.3
- **EN2-MEAN-MODEL** — functions `I_n ≥ 0`, non-decreasing in `n`, of mean `o(n)`, with no point good along any admissible sequence — [hand] — § 3.4
- **EN2-CNT** — at most `(2a)^{θn + k}·g^{2n/k}` words of length `n` with at most `θn` bad starts — [hand; checked by enumeration on 228 cases, control `count-names`] — § 3.5
- **EN2-ZE** — rate zero puts no atom of `ξ_n` below `e^{−βn}` on a set of measure `≥ 1 − η`, for every large `n`; no ergodicity; reads one maximal inequality — [hand] — § 3.5
- **EN2-L31** — X01D's Lemma 3.1′, statement unchanged, with part (iii) of its proof resting on EN2-ZE — [hand] — § 3.6
- **EN2-DECOMP** — X02D § 3.2's conclusions on the canonical decomposition, with no uniqueness of an ergodic decomposition — **derived** — § 4.0
- **EN2-LEB-INV**, **EN2-AC-ERG**, **EN2-SING-COMP** — the parts of the Lebesgue decomposition are invariant; an invariant measure absolutely continuous to an ergodic one is a multiple of it; the canonical components of a measure singular to `m` are not `m` — [hand] — § 4.2
- **EN2-PE2-SING** — the singular part of `τ` with respect to Haar measure is `U`-invariant of entropy zero for every `u`, and `τ − τ_s = a·m`, `a = max{c : c·m ≤ τ}` — [hand, given Lemma Γ and Lemma W by statement] — § 4.2
- **EN2-PE2** — PE-2 and its ergodic form, the statement of FS100-PE2 unchanged — [derived from EN2-PE2-SING] — § 4.2, § 4.3
- **EN2-EQUIV** — `u_*κ(x) = κ(ux)` almost everywhere, for the canonical kernel on the `Γ`-invariant sets (true, and not needed) — [hand] — § 4.4
- **EN2-PE2-MAX** — PE-2's first sentence with `a` the largest Haar multiple below `τ`, reading neither the Lebesgue decomposition nor the ergodicity of Haar measure — [hand, given Lemma Γ and Lemma W by statement] — § 5.2

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

---

## Stage 3 — SAVED (EN2-MEAN: the scheme as worded stalls; a narrower statement serves, and reads one maximal inequality)

### 3.0 Verdict first

**As worded — Markov's inequality on the information function, a subsequence of scales with summable bad sets, no almost-everywhere
theorem — not derived; it stalls at the choice of the subsequence.** Steps 4–5 compare consecutive scales, and the comparison closes
only on a window (§ 3.1), so the scales must form a chain of bounded ratio; along every such chain Markov's bounds are summable if and
only if `Σ_n H_n/n² < ∞` (§ 3.2), and entropy zero does not give that (§ 3.3: an invariant measure of entropy zero with
`H_n ≥ c·n/log n`). No argument that reads of the information functions only that they are non-negative, non-decreasing in `n`, and of
mean `o(n)` can do better (§ 3.4).

**A narrower statement serves, and it is a theorem with a short proof (§ 3.5): EN2-ZE.** For a measure of entropy zero the one thing
the deduction takes from Shannon–McMillan–Breiman — a set of measure near full on which no atom of `ξ_n` is smaller than `e^{−βn}`, for
every large `n` — follows from Markov's inequality at **one** block length, a count of words, and **the maximal ergodic inequality for
the indicator of a set**. Lemma 3.1′ then stands word for word (§ 3.6), and Steps 3–7 and EF_F⁺ are untouched. What is no longer read:
Shannon–McMillan–Breiman, conditional information, the martingale theorem, the ergodic decomposition for `u*`, Jacobs's formula,
Egorov. What is read instead is one maximal inequality — not a convergence theorem, but the kind of statement almost-everywhere
theorems are made from; so the literal answer to "with no almost-everywhere theorem" is *no, one maximal inequality*, and the answer
to "is Shannon–McMillan–Breiman formalized or dropped" is *dropped*. The release proves that inequality (§ 5.1).

### 3.1 Two runs of Step 3 compared: the window

Notation is X01D's (§ 3.4–3.5 there): a run of Step 3 at height `M` and thinness `δ` takes `x`, a lift `x̃`, the box
`Q_{v*}(2ε, δ)` and multipliers in `V_M`, and returns `ℓ = v₁ − v₂ ∈ R ∖ {0}`, `r ∈ Λ` and `e = ℓx̃ − r`, with the bounds of X01D's
table (l. 259–263) read at `δ` in place of `δ(M)`: at archimedean places `|e| < 4ε`, `|ℓ| ≤ 2` (ordinary); at a finite `v*`
`|e|_{v*} ≤ M·δ`, `|ℓ|_{v*} ≤ M`; at split `w ≠ v*`, `|e|_w, |ℓ|_w ≤ m(w)` with `∏_w m(w) ≤ M²`.

Take two runs for the same `x` and `x̃`, at `(M₁, δ₁)` and `(M₂, δ₂)` with `M₁ ≤ M₂` and `δ₁ ≥ δ₂`, and `z := ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ −
ℓ₂e₁ ∈ Λ` (X01D l. 271). At `v*` (ultrametric): `|z|_{v*} ≤ max(M₁·M₂δ₂, M₂·M₁δ₁) = M₁M₂δ₁`. Over split `w ≠ v*`: `∏_w |z|_w ≤
∏_w m₁(w)m₂(w) ≤ M₁²M₂²`. Archimedean: ordinary `|z| < 16ε`, normalised product `< (16ε)^{[L:ℚ]}`. So

  `∏_{v of W} |z|_v ≤ (16ε)^{[L:ℚ]}·M₁³·M₂³·δ₁`,

and by Lemma PF `z = 0` as soon as the right side is below `1/C_Λ`. With `δ = M^{−K}` and `M₂ = M₁^c` the right side is
`(16ε)^{[L:ℚ]}·M₁^{3 + 3c − K}`: Step 4 closes for the pair `(M, M^c)` when `K > 3 + 3c`, and X01D's pair `(M, M²)` at `K = 16` is the
case `M^{9 − K} = M^{−7}` (l. 274). The bound is polynomial in the larger height `M₂` because `ℓ₂` has height up to `M₂²` at the split
places; that is what makes it a window.

**What the window asks of a scheme that supplies only a mass bound.** Suppose the scheme supplies, at the scale `n` (atoms of `ξ_n`,
thinness `δ = c·s^{−(n−1)}` by X01D (ii)), the bound `μ(ξ_n(x)) ≥ e^{−βn}` (μ normalised). The pigeonhole of Step 3 then needs more
than `e^{βn}` multipliers, so a height `M` with `log M ≥ (βn − C₀)/α′`, `α′` the true growth exponent of `#V_M` (`#V_M ≤ C·M^{α′}`:
the rational unit vectors of bounded height are counted exactly, X12B l. 97). Two scales `(n₁, β₁)`, `(n₂, β₂)`, `n₁ < n₂`, can be
compared by the window only if `3 log M₁ + 3 log M₂ < (n₁ − 1) log s − C₁`, hence only if

  `β₂·n₂ < (α′ log s / 3)·n₁ + C₂`.

Call a sequence of scales and rates `(n_j, β_j)` **admissible** when `β_{j+1}·n_{j+1} ≤ c·n_j` for all `j`, for a constant `c`. Steps
4–5 as they stand run along admissible sequences and along no others. (Letting the rates `β_j` tend to `0` lets the ratios
`n_{j+1}/n_j` grow — the thinness exponent `K_j = log(1/δ_j)/log M_j ≈ α′ log s/β_j` grows with them — and that freedom is inside the
definition.)

derivation: EN2-MEAN-WINDOW
  statement: In X01D's Steps 3–4 at a finite `v*`, for two runs of Step 3 for the same point and lift at heights `M₁ ≤ M₂` and
    thinnesses `δ₁ ≥ δ₂`, the element `z = ℓ₂r₁ − ℓ₁r₂` of `Λ` satisfies `∏_v |z|_v ≤ (16ε)^{[L:ℚ]}·M₁³·M₂³·δ₁` over the places `v`
    of `W`; so `z = 0` when `(16ε)^{[L:ℚ]}·C_Λ·M₁³·M₂³·δ₁ < 1`, and with `δ = M^{−K}`, `M₂ = M₁^c` that holds for every large `M₁`
    when `K > 3 + 3c`.
  uses only: the three rows of X01D's table at `δ` in place of `δ(M)` (ll. 259–263); the ultrametric inequality at `v*` and at the
    split places; `∏_w m(w) ≤ M²` for each run; Lemma PF; `δ₂ ≤ δ₁`
  not claimed: that no other comparison of two scales could close outside a polynomial window; an archimedean `v*` (there the factor
    at `v*` is `64·δ₁²` and `K > 1 + c` suffices, by X01D's parenthesis at l. 274–275, not re-derived here); anything about X12B's
    step 5, whose window has other constants
  argument: § 3.1 Two runs of Step 3 compared
  verdict: derived
  grade: hand
  minds: 1
  model: X01D's own pair: `c = 2`, `K = 16`, the bound `(16ε)^{[L:ℚ]}·M^{9 − K} = (16ε)^{[L:ℚ]}·M^{−7}` (X01D l. 274)
  prior art: known — it is X01D § 3.5's estimate with the two scales left free; the method is `[EinsiedlerFish2010]` Lemma 3.2's
    step from `M₁` to `M₁²` (read, pp. 5–6)
  handoff: none — a relay-result for EN2-MEAN; M8's planner may use it to choose `K` if it wants scales in another ratio

### 3.2 The scheme as worded: summable along an admissible chain

A statement about sequences. Let `(H_n)_{n ≥ 1}` be non-negative and non-decreasing (as `H_n = H_μ(ξ_n)` is: `ξ_{n+1}` refines
`ξ_n`), and `c > 0`. Markov's inequality gives `μ{I_n > βn} ≤ H_n/(βn)`, and the scheme wants scales `n_j` and rates `β_j`, admissible
(`β_{j+1}n_{j+1} ≤ c·n_j`), with `Σ_j H_{n_j}/(β_j n_j) < ∞`.

*If such a sequence exists then `Σ_n H_n/n² < ∞`.* For every `j`, `H_{n_{j+1}}/(β_{j+1}n_{j+1}) ≥ H_{n_{j+1}}/(c·n_j)`, so
`Σ_j H_{n_{j+1}}/n_j < ∞`. For `n_j < n ≤ n_{j+1}`, `H_n ≤ H_{n_{j+1}}`, and `Σ_{n > N} n^{−2} < 1/N`. Hence
`Σ_{n > n_1} H_n/n² ≤ Σ_j H_{n_{j+1}}/n_j < ∞`.

### 3.2′ The converse: from the series to a chain

*If `Σ_n H_n/n² < ∞` then the dyadic chain at a fixed rate is admissible and summable.* Take `n_j = 2^j`, `β_j = c/2`:
`β_{j+1}n_{j+1} = c·2^j = c·n_j`. For `2^j ≤ n < 2^{j+1}`, `H_n ≥ H_{2^j}` and `n^{−2} > 4^{−(j+1)}`, so
`Σ_{2^j ≤ n < 2^{j+1}} H_n/n² ≥ H_{2^j}/(4·2^j)`, and `Σ_j H_{2^j}/((c/2)·2^j) ≤ (8/c)·Σ_n H_n/n² < ∞`.

So the scheme as worded proves Lemma 3.1′'s conclusion along a chain for the measures with `Σ_n H_μ(ξ_n)/n² < ∞` — for instance
`H_n = O(n/(log n)^{1+κ})` — and for no others.

derivation: EN2-MEAN-SCHEME
  statement: For a non-decreasing sequence `H_1, H_2, …` of non-negative reals and a real `c > 0`: there are integers
    `1 ≤ n_1 < n_2 < …` and reals `β_j > 0` with `β_{j+1}·n_{j+1} ≤ c·n_j` for every `j` and `Σ_j H_{n_j}/(β_j·n_j) < ∞` if and only
    if `Σ_n H_n/n² < ∞`.
  uses only: `H` non-decreasing and non-negative; `Σ_{n > N} n^{−2} < 1/N`; for the converse the dyadic blocks
  not claimed: that the true bad sets `{I_n > βn}` are summable only then (Markov's bound can lose: § 3.3's example has summable bad
    sets along some admissible sequences with rates tending to 0); anything about a proof that does not go through a union bound
  converse: § 3.2′ The converse
  argument: § 3.2 The scheme as worded
  verdict: derived
  grade: hand
  minds: 1
  model: `H_n = √n` (the series converges; the dyadic chain at `β = c/2` has bounds `2/(c·2^{j/2})`); and on the other side
    `H_n = n/log(n + 1)` (the series diverges)
  prior art: known — a condensation argument; not searched, nothing claimed
  handoff: none — it is the reason EN2-MEAN stalls, and reaches the kernel lane only as that reason

### 3.3 Entropy zero does not give the series: a mixture of de Bruijn orbits

For `k ≥ 1` put `d_k = 2^k`, let `w_k` be a binary de Bruijn word of order `d_k` (a cyclic word of length `P_k = 2^{d_k}` in which
every binary word of length `d_k` occurs once as a window), and `μ_k` the uniform probability on the `P_k` shifts of the periodic
sequence `w_k^∞` — a shift-invariant measure on `{0,1}^ℤ` carried by one finite orbit. Let `p_k = (6/π²)·k^{−2}` and
`μ = Σ_k p_k μ_k`. `P` is the letter at time `0`, so `ξ_n` is the partition by the word at times `0, …, n − 1`.

1. *`H_n(μ_k) = min(n, d_k)·log 2`.* For `n ≤ d_k` every word of length `n` is the prefix of `2^{d_k − n}` words of length `d_k`, each
   a window once: the `n`-marginal of `μ_k` is uniform. For `n ≥ d_k` the `P_k` windows are distinct (their first `d_k` letters
   differ), each of mass `1/P_k`. (Control `debruijn-marginals`: orders 2, 4, 8, every `n ≤ d + 2`.)
2. *`H_n(μ) ≥ (6 log 2/π²)·n/(1 + log₂ n)`.* Entropy is concave in the measure (Jensen for `−t log t`, word by word), so
   `H_n(μ) ≥ Σ_k p_k H_n(μ_k) ≥ n log 2·Σ_{k ≥ ⌈log₂ n⌉, k ≥ 1} p_k`, and `Σ_{k ≥ K} k^{−2} > 1/K`, `⌈log₂ n⌉ ≤ 1 + log₂ n` (at `n = 1`
   the sum is `1`). Hence `Σ_n H_n(μ)/n² = ∞`.
3. *Entropy zero.* `H_n(μ) ≤ Σ_k p_k H_n(μ_k) + H(p)`, with `H(p) = −Σ_k p_k log p_k < ∞`, so
   `H_n(μ)/n ≤ log 2·Σ_k p_k min(1, 2^k/n) + H(p)/n → 0` (dominated convergence). The time-zero partition generates, so the shift has
   entropy zero for `μ`.
4. *The conclusion holds anyway.* `μ` is carried by a countable set, and a point `x` of the `k`-th orbit has
   `μ(ξ_n(x)) ≥ μ{x} = p_k/P_k` for every `n`.
5. *Even the true bad sets are not summable along the dyadic chain at a fixed rate.* Let `n = 2^J`, `β < log 2`,
   `q_n = Σ_{k ≥ J} p_k ≥ (6/π²)/J`. The words charged by some `μ_k` with `k < J` number at most `Σ_{k<J} 2^{2^k} ≤ 2^{1 + n/2}`; every
   other word `w` has `μ[w] = q_n·2^{−n} < e^{−βn}`. So `μ{I_n > βn} ≥ q_n·(1 − 2^{1 − n/2})`, and the sum over `J` diverges like the
   harmonic series. The union of these bad sets over `J ≥ J₀` is nevertheless small: a point of the `k`-th orbit is good at every
   scale `n` with `e^{−βn} ≤ p_k/P_k`, so for large `J` the bad set at `2^J` is carried by the orbits with `k > J − C` (`C` depending
   on `β` only), and the union is carried by the orbits with `k > J₀ − C`, of mass tending to `0`. The bad sets are nested up to a
   shift, and a union bound cannot see that.

derivation: EN2-MEAN-RATE
  statement: There is a shift-invariant Borel probability `μ` on `{0,1}^ℤ`, of entropy zero, whose partition by the letter at time 0
    has `H_μ(ξ_n) ≥ (6 log 2/π²)·n/(1 + log₂ n)` for every `n ≥ 1`, so that `Σ_n H_μ(ξ_n)/n² = ∞`; and `μ`-almost every point `x` has
    `inf_n μ(ξ_n(x)) > 0`.
  uses only: the de Bruijn property of each `w_k`; concavity of Shannon entropy in the measure and the bound
    `H(Σ p_k μ_k) ≤ Σ p_k H(μ_k) + H(p)`; `Σ_{k ≥ K} k^{−2} > 1/K`; `H(p) < ∞` for `p_k ∝ k^{−2}`
  not claimed: that such a measure lives on the dual `R̂` and is invariant under the unit vectors — by EF_F⁺ itself none does that
    violates the deduction's conclusion, so the example is a model of the hypothesis "entropy zero" and not of the chain's setting;
    that the measure is ergodic (it is a mixture; an ergodic example is not needed and not sought)
  argument: § 3.3 Entropy zero does not give the series
  verdict: derived
  grade: hand
  minds: 1
  model: the measure itself; at `d = 8` the word has period 256, every 5-letter word occurs 8 times, and the 256 windows of length
    8, 9, 10 are distinct (the control's third line)
  prior art: owed — that zero-entropy systems have block entropies of every sublinear growth is folklore (recalled, not read; the
    words would be "slow entropy", "entropy dimension", "complexity of zero entropy systems"); not searched
  handoff: none — a counter-model for the scheme, not a statement of the chain

control: debruijn-marginals
  of: EN2-MEAN-RATE — step 1, on the de Bruijn words of orders 2, 4, 8: every window count as derived
  run: python3 ../data/fs131/en2/debruijn_mixture.py 2 4 8
  expect: 2 4 0
    4 16 0
    8 256 0
  fault: python3 ../data/fs131/en2/debruijn_mixture.py 2 4 8 --plant

### 3.4 What the scheme reads is not enough: a model with no dynamics

Fix `λ ≥ 1`. On `[0, 1)` with Lebesgue measure let `E_m` (`m ≥ 3`) be the arc of length `ε_m = 1/(m log m)` starting where
`E_{m−1}` ends, the arcs laid end to end around the circle `ℝ/ℤ`. `Σ_m ε_m = ∞`, so every point lies in `E_m` for infinitely many `m`.
Put `I_n(x) := λ·max{m ≤ n : x ∈ E_m}` (and `0` if there is none). Then `I_n ≥ 0`; `I_n ≤ I_{n+1}`; and
`∫ I_n ≤ λ·Σ_{3 ≤ m ≤ n} m·ε_m = λ·Σ_{3 ≤ m ≤ n} 1/log m = o(n)`.

Let `(n_j, β_j)` be any sequence with `β_{j+1}·n_{j+1} ≤ λ·n_j`. If `x ∈ E_m` and `n_j < m ≤ n_{j+1}`, then
`I_{n_{j+1}}(x) ≥ λ·m > λ·n_j ≥ β_{j+1}·n_{j+1}`: `x` is bad at the scale `n_{j+1}`. Every `m > n_1` falls in one such interval and
each interval holds finitely many `m`, so **every** point is bad at infinitely many scales of the sequence.

So the three facts the scheme reads of the information functions — non-negative, non-decreasing in `n`, mean `o(n)` — are consistent
with *no point at all* being good along any admissible sequence. These `I_n` are the information functions of no measure-preserving
system (§ 3.5 forbids it); what separates the two is the invariance of the measure, and that is what a proof must read.

derivation: EN2-MEAN-MODEL
  statement: For every `λ ≥ 1` there are measurable functions `I_1 ≤ I_2 ≤ …` on `[0, 1)`, non-negative, with `∫ I_n = o(n)` for
    Lebesgue measure, such that for every sequence of integers `n_1 < n_2 < …` and reals `β_j > 0` with `β_{j+1}·n_{j+1} ≤ λ·n_j`
    for all `j`, every point `x` has `I_{n_j}(x) > β_j·n_j` for infinitely many `j`.
  uses only: `Σ 1/(m log m) = ∞`; `Σ_{m ≤ n} 1/log m = o(n)`; the arcs laid end to end
  not claimed: that these functions are information functions of a partition under any map; that no proof without a maximal
    inequality exists — only that none can read these three facts alone
  argument: § 3.4 What the scheme reads is not enough
  verdict: derived
  grade: hand
  minds: 1
  model: `λ = 1`, the dyadic chain `n_j = 2^j` at `β_j = 1/2`: a point of `E_m`, `2^j < m ≤ 2^{j+1}`, has `I_{2^{j+1}} ≥ m > 2^j =
    β_{j+1}·n_{j+1}`
  prior art: known — the sliding-arc ("typewriter") sequence that converges in mean and at no point; textbook, recalled
  handoff: none — a counter-model

derivation: EN2-MEAN
  statement: Steps 4–5 (X01D ll. 226–246) can run on convergence in mean — `μ{I_n > εn} ≤ H_n/(εn)` by Markov's inequality on the
    information function, along a subsequence of scales chosen so that the bad sets are summable — with no almost-everywhere theorem.
  uses only: —
  not claimed: that the deduction needs Shannon–McMillan–Breiman (it does not: EN2-ZE, EN2-L31); that no rearrangement free of every
    maximal inequality exists (not shown; EN2-MEAN-MODEL shows only what such a rearrangement could not be built from)
  argument: § 3.0 Verdict first
  verdict: stalls at: the choice of the subsequence — Steps 4–5 need consecutive scales inside the window of EN2-MEAN-WINDOW, so the
    sequence must be admissible, and along admissible sequences Markov's bounds are summable only when `Σ_n H_n/n² < ∞`
    (EN2-MEAN-SCHEME), which entropy zero does not give (EN2-MEAN-RATE). Tried against it: rates `β_j → 0` with growing ratios (inside
    EN2-MEAN-SCHEME's statement, no gain); the monotonicity of `I_n` (it reduces every scale to a chain and no further); passing to
    the complement of `T + K_{v*}` and asking only for positive measure (the same union bound); a pigeonhole on atoms in place of
    masses (one scale again); one scale with the dynamics of `u*` on a tube about the leaves (fails: Haar measure charges every
    tube and no leaf). What serves in its place: EN2-ZE
  grade: hand
  minds: 1

### 3.5 The narrower statement: entropy zero puts no small atoms on a large set

**The count (EN2-CNT).** Let `𝒜` be an alphabet of `a` letters, `k ≥ 1`, `𝒢` a set of words of length `k`, `g ≥ 2` real with
`#𝒢 ≤ g`, `θ ≥ 0`, `n ≥ k`, and `W` the set of words `w` of length `n` with at most `θn` *bad starts* — positions
`0 ≤ j ≤ n − k` with `w[j, j + k) ∉ 𝒢`.

*Parse.* Read `w` from the left: at position `j`, if `j ≤ n − k` and `w[j, j + k) ∈ 𝒢`, emit that block and move to `j + k`; otherwise
emit the single letter `w_j` and move to `j + 1`. A single is emitted only at a bad start or at one of the last `k − 1` positions, so
the parse of a word of `W` has at most `θn + k − 1` singles. The parse is a sequence of *tokens* — single letters (`a` kinds) and
blocks (`#𝒢` kinds) — whose concatenation is `w`; so `w ↦` its parse is injective, and `#W` is at most the number of token sequences
of total length `n` with at most `θn + k` singles.

*Weigh.* Let `t = 1/(2a)` and `c_m := Σ t^{#singles}` over all token sequences of total length `m`. Then `c_0 = 1`,
`c_m = a·t·c_{m−1} + #𝒢·c_{m−k}` (the last token; the second term only for `m ≥ k`), and with `ρ := g^{2/k}`:
`a·t/ρ ≤ 1/2` and `#𝒢·ρ^{−k} ≤ g·g^{−2} ≤ 1/2`, so `c_m ≤ ρ^m` by induction (`c_m = 2^{−m}` for `m < k`). A sequence with at most
`θn + k` singles has `t^{#singles − (θn + k)} ≥ 1`, so

  `#W ≤ t^{−(θn + k)}·c_n ≤ (2a)^{θn + k}·g^{2n/k}`.

(Control `count-names`: steps "parse", "count of token sequences" and the final bound, on 228 cases by complete enumeration.)

derivation: EN2-CNT
  statement: Let `𝒜` be a finite alphabet of `a ≥ 1` letters, `k ≥ 1`, `𝒢` a set of words of length `k` over `𝒜`, `g ≥ 2` a real
    number with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`. The number of words `w` of length `n` over `𝒜` having at most `θn` positions
    `0 ≤ j ≤ n − k` with `w[j, j + k) ∉ 𝒢` is at most `(2a)^{θn + k}·g^{2n/k}`.
  uses only: the greedy parse and its injectivity; the recursion for the weighted count of token sequences; `g ≥ 2` and `#𝒢 ≤ g`
  not claimed: a sharp exponent (a binomial count gives `exp(n·h(2θ))` in place of `(2a)^{θn}` for the choice of positions; the
    weighted count is used because it needs no bound on binomial sums); anything for `n < k`
  argument: § 3.5 The narrower statement
  verdict: derived
  grade: hand
  minds: 1
  model: `a = 2`, `k = 3`, `𝒢 = {000}`, `g = 2`, `θ = 9/10`, `n = 13`: all `8192` words have at most `11.7` bad starts (there are
    11 starts), and the bound is `4^{14.7}·2^{26/3} > 8192`
  prior art: known — the count of names covered by good blocks in the covering proofs of the entropy theorem (Ornstein–Weiss;
    Shields's book; recalled, not read); the weighted recursion is a standard device
  handoff: de Bruijn — the statement as written, for module M8; pure combinatorics over `Fin n → α`, no measure

control: count-names
  of: EN2-CNT — the parse bound, the count of token sequences and the final inequality, on every word of length at most 13 for
    five pairs (k, 𝒢) and four values of θ
  run: python3 ../data/fs131/en2/count_names.py
  expect: 0 0 0 228
  fault: python3 ../data/fs131/en2/count_names.py --plant

**The lemma (EN2-ZE).** `(X, μ)` a probability space, `T : X → X` measurable with `T_*μ = μ`, `P : X →` a finite set of `a` letters,
measurable; `[x]_n` the set of points with the same name of length `n` as `x`; `H_n` the entropy of the partition into these sets;
`inf_n H_n/n = 0`. Given `β, η > 0` (`η ≤ 1`):

1. *Parameters.* `γ := β/8`, `θ := min(η/2, β/(8 log 2a))`.
2. *One block length, by Markov on the terms of `H_k`.* `H_{m+n} ≤ H_m + H_n` (invariance), so `H_{jk₀}/(jk₀) ≤ H_{k₀}/k₀`: there is
   `k` with `γk ≥ log 2` and `H_k ≤ γθ²k`. Let `𝒢` be the names `w` of length `k` with `μ[w] ≥ e^{−γk}`; `#𝒢 ≤ e^{γk} =: g`, `g ≥ 2`.
   Let `B := {x : name_k(x) ∉ 𝒢}`. Each `w ∉ 𝒢` has `−log μ[w] > γk`, and the terms of `H_k` are non-negative, so
   `H_k ≥ γk·μ(B)`: `μ(B) ≤ θ²`.
3. *Every length at once, by the maximal inequality.* Let `E := {x : #{0 ≤ j < n : T^j x ∈ B} > θn for some n}`. The maximal ergodic
   inequality for the indicator of `B` gives `θ·μ(E) ≤ μ(B)`: `μ(E) ≤ θ`.
4. *Few names off `E`.* For `x ∉ E` and `n ≥ k/θ`: the block of `name_n(x)` at `j ≤ n − k` is `name_k(T^j x)`, which is outside `𝒢`
   only if `T^j x ∈ B`; so `name_n(x)` has at most `θn` bad starts and lies in the set `W_n` of EN2-CNT, with
   `#W_n ≤ (2a)^{θn + k}·e^{2γn} ≤ (2a)^{2θn}·e^{2γn} ≤ e^{βn/2}`.
5. *Small atoms are few in mass.* Let `S_n` be the union of the sets `[w]_n`, `w ∈ W_n`, with `μ[w]_n < e^{−βn}`:
   `μ(S_n) ≤ #W_n·e^{−βn} ≤ e^{−βn/2}`.
6. *The set.* Take `N₀ ≥ k/θ` with `Σ_{n ≥ N₀} e^{−βn/2} ≤ η/2` and `X′ := X ∖ (E ∪ ⋃_{n ≥ N₀} S_n)`. Then `μ(X′) ≥ 1 − θ − η/2 ≥
   1 − η`, and for `x ∈ X′`, `n ≥ N₀`: `name_n(x) ∈ W_n` and `[x]_n ⊄ S_n`, so `μ([x]_n) ≥ e^{−βn}`. ∎

No limit is taken, no conditional expectation is formed, and nothing is assumed ergodic, invertible or standard Borel. Step 2 is
where entropy zero is spent, and it is spent as Markov's inequality — the asker's instinct — but at one block length, not along a
sequence of scales; step 3 is where the invariance of the measure is spent, and it is what the union bound over scales could not
replace.

derivation: EN2-ZE
  statement: Let `(X, μ)` be a probability space, `T : X → X` measurable with `T_*μ = μ`, and `P` a measurable map from `X` to a
    finite set; write `[x]_n` for the set of points `y` with `P(T^j y) = P(T^j x)` for `0 ≤ j < n`, and `H_n` for the Shannon entropy
    of the partition of `X` into these sets. If `inf_{n ≥ 1} H_n/n = 0`, then for every `β > 0` and `η > 0` there are `N₀` and a
    measurable `X′ ⊆ X` with `μ(X′) ≥ 1 − η` such that `μ([x]_n) ≥ e^{−βn}` for every `x ∈ X′` and every `n ≥ N₀`.
  uses only: subadditivity of `H_n` (to make the block length large); Markov's inequality on the terms of one `H_k`; the maximal
    ergodic inequality for the indicator of one measurable set under a measure-preserving map; EN2-CNT; a geometric series
  not claimed: anything at positive entropy (step 2 fails there: Markov gives `μ(B) ≤ h/(h + γ)`, not small); convergence of
    `−(1/n) log μ([x]_n)`, almost everywhere or otherwise; a countable partition; that the proof is new
  argument: § 3.5 The narrower statement
  verdict: derived
  grade: hand
  minds: 1
  model: an irrational rotation of the circle with `P` the indicator of an arc: `H_n ≤ log(2n)`, and every `[x]_n` is one of at most
    `2n` arcs; and against the hypothesis, the fair-coin shift: `H_n/n = log 2`, `μ([x]_n) = 2^{−n}`, the conclusion false for
    `β < log 2`
  prior art: known — the upper half of the Shannon–McMillan–Breiman theorem at entropy zero, without ergodicity; the route is the
    covering proof of the entropy theorem (Ornstein–Weiss 1983; Shields, *The Ergodic Theory of Discrete Sample Paths*) with the
    pointwise ergodic theorem replaced by Hopf's maximal inequality and the choice of good blocks by Markov's inequality (both
    sources recalled, not read; not searched; no novelty claimed)
  handoff: de Bruijn — the statement as written, for module M8, in place of Shannon–McMillan–Breiman; its one classical input is the
    maximal inequality for an indicator, which the release states and proves (`excessiveOccupation_measure_bound`, § 5.1)

### 3.6 Lemma 3.1′ stands, word for word

Parts (i), (ii) and (iv) of X01D's proof (ll. 230–236, 239–241) are kept. Part (iii) (ll. 237–239) is replaced by:

(iii′) Let `μ̄ = μ/μ(R̂)`, `T` the map `χ ↦ u*·χ` of `R̂`, which preserves `μ̄`, and `P` the map sending a point to the cell of `ξ`
that holds it; then `[x]_n` is the atom `ξ_n(x)`. The entropy `h_μ(u*)` is that of `μ̄`, and it is the supremum over finite
measurable partitions of `inf_n H_n/n`; so `h_μ(u*) = 0` gives `inf_n H_{μ̄}(ξ_n)/n = 0`. EN2-ZE at `β₁` and `η/(2μ(R̂))` gives `N₀`
and a Borel `X′` with `μ(X′) > μ(R̂) − η` and `μ(ξ_n(x)) ≥ μ(R̂)·e^{−nβ₁}` for `n ≥ N₀`, `x ∈ X′`.

(iv) then reads as before with the constant `μ(R̂)` carried: `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ μ(ξ_n(x)) ≥ μ(R̂)·(δ/(cs))^{β₁/log s} ≥ δ^β`
once `β₁/log s < β` and `δ₀` is small. Steps 3–7 of X01D read Lemma 3.1′ only through its statement, so EF_F⁺ stands as filed. X12B's
step 2 (ll. 113–115) is replaced the same way.

derivation: EN2-L31
  statement: Fix `ε > 0` with `∏_{v|∞}(2ε(1 + |u*|_v^{1/2}))² · ∏_{w split} max(1,|u*|_w) < 1/C_Λ` (ordinary moduli inside,
    normalised outside). For every `β > 0` and `η > 0` there are `δ₀ > 0` and a Borel `X′ ⊆ R̂` with `μ(X′) > μ(R̂) − η` such that
    `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ δ^β` for every `x ∈ X′`, every lift `x̃`, and every `0 < δ ≤ δ₀`.
  uses only: X01D's parts (i), (ii), (iv) as written; EN2-ZE for the map `χ ↦ u*·χ`, the normalised measure and the partition `ξ`;
    that the entropy of a map is at least the rate of each finite partition
  not claimed: any change to the statement (it is X01D ll. 226–228, quoted); anything about parts (i) and (ii), which were not
    re-derived here; that the hypotheses of the lemma (set above it in X01D: `μ` a `U`-invariant finite measure, `h_μ(u*) = 0`,
    `v*` an expanding place of `u*`) are changed
  argument: § 3.6 Lemma 3.1′ stands
  verdict: derived
  grade: hand
  minds: 1
  model: EF-X's circle measure `λ_ρ` (X01D § 2.2; entropy zero for every `u`) at a finite `v*`: a point `x = π(x̃)` of the circle has
    `x̃_{v*} = 0`, so for every `δ > 0` the box `π(x̃ + Q_{v*}(2ε, δ))` holds the arc of the circle within archimedean distance `2ε`
    of `x`, of mass independent of `δ` — at least `δ^β` for small `δ`
  prior art: known — `[EinsiedlerFish2010]` Lemma 3.1 (read, pp. 3–4), which cites the almost-everywhere theorem for the same set
  handoff: de Bruijn — Lemma 3.1′ with its proof's third part resting on EN2-ZE; the module reads no Shannon–McMillan–Breiman,
    no Jacobs formula, no ergodic decomposition for `u*` and no Egorov

### 3.7 The attack on my own argument

- *A measure and a partition on which convergence in mean holds and the needed conclusion fails.* Among measure-preserving systems
  there is none: EN2-ZE is a theorem (and so is Shannon–McMillan–Breiman). What exists is (a) a measure-preserving system of entropy
  zero on which the **scheme** fails and the conclusion holds (EN2-MEAN-RATE), and (b) functions with every property the scheme reads
  and no good point (EN2-MEAN-MODEL), which come from no invariant measure. The two together locate the missing input: invariance,
  used across all lengths at once.
- *Does EN2-ZE prove too much?* Run on the fair-coin shift it proves nothing false: step 2 needs `γk ≥ log 2` and `H_k ≤ γθ²k`, i.e.
  `log 2 ≤ γθ²`, which forces `γ ≥ log 2/θ² > β` — the parameters of step 1 cannot be chosen.
- *The ends of the parse.* A word whose length is not a multiple of `k`, and blocks that would overrun the end, are the usual place
  for an off-by-`k`; the control enumerates every length from `k` to 13.
- *`E` is defined with "for some `n`", including `n < k`.* That only enlarges `E`; the maximal inequality bounds it as defined.
- *Does (iii′) use the right entropy?* The lemma's hypothesis is `h_μ(u*) = 0` and the proof needs the rate of one partition; the rate
  is at most the entropy by definition. No generator is needed, and the release's `measureEntropy` is a supremum over finite
  partitions (§ 5.1).
- *What a second mind should attack first:* step 4's sentence "the block of `name_n(x)` at `j` is `name_k(T^j x)`" (it is the
  definition of a name, and it is where the dynamics enters the count), and step 3's use of the inequality for *every* `n`.

### 3.8 Would-have-searched-here log

- None. The two computations are complete enumerations of finite sets whose extent the derivation fixed (de Bruijn windows; words
  of length at most 13).

---

## Stage 4 — SAVED (EN2-DECOMP: derived, and more than was asked — no uniqueness of an ergodic decomposition, no permutation of components, no decomposition for `U`)

### 4.0 Verdict first

**Derived.** The step from `Γ` to `U` goes through on the canonical decomposition in the form the release states it (existence
only), and what replaces X02D § 3.2 is shorter than what it replaces: **PE-2's two parts are the Lebesgue decomposition of the
measure with respect to Haar measure.** The absolutely continuous part is a multiple of `m` because `m` is ergodic; the singular
part is `U`-invariant because the Lebesgue decomposition is unique; and for each admissible `Γ` the canonical `Γ`-components of the
singular part are almost surely not `m` — they charge an `m`-null set fully — so Lemma Γ and the mixture lemma give it entropy zero
on `Γ`. Three things X02D § 3.2 reads are not read at all:

- **the uniqueness of the ergodic decomposition** (ll. 205, 209): at l. 205 its conclusion is used by no later step (§ 4.1); at
  l. 209 what is consumed is "the components of the non-Haar part are not `m`", which singularity gives in one line;
- **"`U` permutes the components"**: true, by a computation (§ 4.4), and idle;
- **the ergodic decomposition for `U`** (l. 216, step 5): `τ′` is the singular part, formed with no decomposition.

The uniqueness that *is* read is that of the Lebesgue decomposition, which Mathlib holds. L. 225 is in § 3.3, X02D's second route,
which the chain does not need once § 3.2's conclusion stands. The statements PE-2 and its ergodic form are unchanged (EN2-PE2), and
the route gives a little more than they say: `τ′` can be taken singular to `m` (EN2-PE2-SING).

### 4.1 The reading: step 1's conclusion is read by no later step

X02D § 3.2, step by step, for what each reads of step 1's conclusion `(u_*)_♯P = P` (l. 205):

| step | lines | reads of step 1 |
|---|---|---|
| 2, the split | 206–207 | nothing: "`ν′_Γ` is `U`-invariant (it is `(ν − a_Γ m)/(1 − a_Γ)`)" reads the invariance of `ν` and of `m`; the entropy of `ν′_Γ` reads T3 |
| 3, `U`-ergodic `ν` | 208–210 | nothing: it reads step 2's invariance, the extremality of `ν`, and T1's uniqueness a second time, for another purpose |
| 4, all of `U` | 211–212 | nothing: Lemma W |
| 5, PE-2 | 216–218 | nothing: the `U`-ergodic decomposition, (★), T3 |

So the citation at l. 205 is idle, and with it step 1's remark that `u_*` preserves `Z_Γ`. § 3.3 (the second route) says of itself
that it "reaches (★) without permuting components".

### 4.2 The step from `Γ` to `U`, on the Lebesgue decomposition

*Setting.* `X = R̂`: a compact metrizable group, so a standard Borel space. `U` acts by continuous automorphisms `χ ↦ u·χ`. `m` is
Haar probability: `u_*m = m` for every `u` (in the kernel's form of "Haar" — every Fourier coefficient off `0` vanishes — because
`∫χ(r) d(u_*m) = ∫χ(ur) dm` and `ur ≠ 0`). `ν` is a `U`-invariant Borel probability. Lemma Γ and Lemma W are X02D's (§ 3.1; ll.
156–163), read by statement.

1. **The Lebesgue decomposition.** `ν = ν_ac + ν_s`, `ν_ac ≪ m`, `ν_s ⟂ m`, and the pair is unique.
2. **Both parts are `U`-invariant** (EN2-LEB-INV). For `u ∈ U`: `u_*ν_ac ≪ u_*m = m`; `u_*ν_s ⟂ u_*m = m` (if `m(S) = 0` and
   `ν_s(Sᶜ) = 0` then `u_*m(uS) = 0` and `u_*ν_s((uS)ᶜ) = 0`, `u` being a bijection measurable both ways); and
   `u_*ν_ac + u_*ν_s = u_*ν = ν`. By uniqueness, `u_*ν_ac = ν_ac` and `u_*ν_s = ν_s`.
3. **`ν_ac = a·m`, `a = ν_ac(X)`** (EN2-AC-ERG). Let `g = dν_ac/dm`. For `u ∈ U` and Borel `B`:
   `ν_ac(B) = ν_ac(u⁻¹B) = ∫ 1_B(ux) g(x) dm(x) = ∫_B g∘u⁻¹ dm` (the last by `u_*m = m`), so `g∘u⁻¹` is a density of `ν_ac` too and
   `g∘u⁻¹ = g` `m`-almost everywhere. `m` is ergodic for one non-torsion `γ₀ ∈ U` — for `(3 + 4i)/5`, say: a character `r ∈ R` with
   finite `γ₀`-orbit has `(γ₀^j − 1)r = 0` for some `j ≥ 1`, so `r = 0`, and an `L²(m)` function invariant under `γ₀` has Fourier
   coefficients constant on orbits, hence zero off `0` (X02D l. 200–201 is this argument for `Γ`). So `g` is `m`-almost everywhere
   constant.
4. **For every admissible `Γ`, `h_{ν_s}(γ) = 0` for all `γ ∈ Γ`.** If `ν_s = 0` there is nothing to prove. Otherwise let
   `λ = ν_s/ν_s(X)`, a `Γ`-invariant probability (step 2, `Γ ⊆ U`), `𝓘_Γ` the σ-algebra of Borel sets `B` with `γB = B` for all
   `γ ∈ Γ`, and `κ` the conditional-expectation kernel of `λ` on `𝓘_Γ`. The canonical decomposition (the release's
   `action_ergodic_decomposition`, both conjuncts, at `H = Γ`, `Y = R̂`, `μ = λ`) says: `∫ κ(x) dλ(x) = λ`, and for `λ`-almost every
   `x` the probability `κ(x)` is `Γ`-invariant and `Γ`-ergodic. Take `S` Borel with `m(S) = 0`, `λ(S) = 1`. Then
   `1 = λ(S) = ∫ κ(x)(S) dλ(x)` with `κ(x)(S) ≤ 1`, so `κ(x)(S) = 1` for almost every `x`; as `m(S) = 0`, **`κ(x) ≠ m`**
   (EN2-SING-COMP). By Lemma Γ, `h_{κ(x)}(γ) = 0` for every `γ ∈ Γ`, for almost every `x` (`Γ` is countable). By the mixture lemma
   (the release's `measureEntropy_kernel_zero`, at `Z = (R̂, 𝓘_Γ)`, `τ = λ` restricted to `𝓘_Γ`, `T = γ·`):
   `h_λ(γ) = 0`.
5. **All of `U`.** Every non-torsion `u ∈ U` lies in an admissible `Γ` (Lemma W); a torsion `u` has entropy zero for every
   measure (X02D l. 166). So `h_{ν_s}(u) = 0` for every `u ∈ U`.

**PE-2.** For a `U`-invariant finite positive `τ ≠ 0` apply 1–5 to `τ/τ(X)`: `τ = a·m + τ_s`, `a = τ_ac(X) ≥ 0`, and `τ′ := τ_s` is
finite, positive, `U`-invariant, of entropy zero for every `u`. ∎

**What `a` is.** `a·m = τ_ac ≤ τ`. If `c·m ≤ τ` then, with `S` as in step 4 for `τ_s`, `c·m = c·m|_{Sᶜ} ≤ τ|_{Sᶜ} = τ_ac`, so
`c ≤ a`: `a = max{c ≥ 0 : c·m ≤ τ}`.

### 4.3 The ergodic form, from the same decomposition

Let `ν` be `U`-invariant and `U`-ergodic. Take `S` with `m(S) = 0`, `ν_s(Sᶜ) = 0`, and `S̃ := ⋃_{u ∈ U} uS`: still `m`-null (`U`
countable, `m` invariant), still carrying `ν_s`, and `uS̃ = S̃` for every `u`. Then `ν(S̃) = ν_ac(S̃) + ν_s(S̃) = ν_s(X)`, and
ergodicity gives `ν_s(X) ∈ {0, 1}`. If `1`: `ν = ν_s` has entropy zero for every `u` (§ 4.2). If `0`: `ν = ν_ac = a·m`, a
probability, so `ν = m`. That is (★), X02D l. 214. ∎

*On the word "equivalently" in the filed statement.* Here both sentences are proved outright. The implication from the ergodic form
back to the decomposition is X02D's step 5 and reads the ergodic decomposition for `U`; this route does not use it and does not
re-derive it.

### 4.4 "`u` permutes the components" is a computation — and is not needed

For the record, since the asker's question names it. Let `ν` be `U`-invariant, `Γ ⊆ U` a subgroup, `κ` the conditional-expectation
kernel of `ν` on `𝓘_Γ`, `u ∈ U`. `u` commutes with `Γ`, so `u⁻¹I ∈ 𝓘_Γ` for `I ∈ 𝓘_Γ` (`γu⁻¹I = u⁻¹γI = u⁻¹I`), and likewise `uI`.
For bounded Borel `f` and `I ∈ 𝓘_Γ`: `∫_I E_ν[f | 𝓘_Γ]∘u dν = ∫_{uI} E_ν[f | 𝓘_Γ] dν = ∫_{uI} f dν = ∫_I f∘u dν` (twice
`u_*ν = ν`), and `E_ν[f | 𝓘_Γ]∘u` is `𝓘_Γ`-measurable; so `E_ν[f∘u | 𝓘_Γ] = E_ν[f | 𝓘_Γ]∘u` almost everywhere, i.e.
`∫ f d(u_*κ(x)) = ∫ f dκ(ux)` for almost every `x`. Over a countable family of `f` that determines a measure: **`u_*κ(x) = κ(ux)`
for `ν`-almost every `x`.** It is the one place commutativity is used, and § 4.2 does not use it: the step from `Γ` to `U` needs only
`Γ ⊆ U` and that each `u` preserves `m`.

*A variant that stays on `ν`'s own kernel* (not filed as an entry; one paragraph). With `κ` the kernel of `ν` itself on `𝓘_Γ` and
`A_Γ := {x : κ(x) = m}` (in `𝓘_Γ`: countably many Fourier coefficients), the conditional-expectation property gives
`ν|_{A_Γ} = ν(A_Γ)·m`, and `ν(A_Γ) = max{c : c·m ≤ ν}` by the lemma "if `c·m ≤ ν` with `c > 0` and `m` is `Γ`-ergodic, then
`κ(x) = m` for `m`-almost every `x`" — proved by the same invariance of a density as step 3, read from the other side. It reaches
the same `τ′` with one more lemma and a measurability check, so the Lebesgue route is the one handed over.

### 4.5 The attack on my own argument

- *A place where two decompositions that agree almost everywhere are treated as equal.* Looked for at each step. Step 2 equates
  measures, by the uniqueness of the Lebesgue decomposition: an equality, not an almost-everywhere agreement. Step 3 concerns a density,
  defined `m`-almost everywhere, and concludes an almost-everywhere constancy. Step 4 uses one kernel — Mathlib's `condExpKernel` is a
  function defined everywhere — and three statements each true off a `λ`-null set (`κ(x)` ergodic; `κ(x)(S) = 1`; Lemma Γ's
  conclusion for the countably many `γ`), intersected. No two kernels are compared, and no representing measure on a space of measures
  is formed. X02D's argument did compare (the representing measure of `u_*ν` with the image of that of `ν`); this one has nothing to
  compare.
- *Where it would break.* Without the ergodicity of `m`, step 3 fails: the mean of the Haar measures of the two cosets of a closed
  subgroup of index two is absolutely continuous to `m` and no multiple of it (FS100-PE1's second counterexample is such a measure
  for a non-admissible `Γ`). With all of `U` acting there is no such measure, because `m` is ergodic for `(3 + 4i)/5` alone.
- *Does it prove too much?* It never says an absolutely continuous measure has positive entropy, nor that a zero-entropy measure is
  singular; `a·m` is simply whatever is absolutely continuous. For the circle measure of EF-X the decomposition is `a = 0`, `τ′ = λ_ρ`
  (it is carried by `A`, and `m(T + A) = 0` is J45's N1 (c), by statement, as EN1 § 8.1 lists it — not needed by the argument).
- *The measurable set `{m}`.* X02D's `a_Γ = P({m})` needs the singleton measurable in a space of measures. Step 4 needs no such set:
  "`κ(x)(S) = 1`" is a statement about one Borel set.
- *What a second mind should attack first:* step 2's "`u_*ν_s ⟂ m`" (it is where `u` bijective and bimeasurable is used), and step
  4's use of the release's theorem for `λ`, a measure invariant under `Γ` but obtained from `ν` by a decomposition that is not
  `Γ`-specific.

derivation: EN2-LEB-INV
  statement: Let a group `U` act on a measurable space `X` by bijections measurable in both directions, and let `m`, `ν` be finite
    measures on `X` with `u_*m = m` and `u_*ν = ν` for every `u ∈ U`. Then the absolutely continuous part and the singular part of
    `ν` with respect to `m` are each invariant under every `u ∈ U`.
  uses only: existence and uniqueness of the Lebesgue decomposition of a finite measure with respect to a finite measure; that the
    image of an absolutely continuous (singular) pair under a bimeasurable bijection is absolutely continuous (singular)
  not claimed: anything for a map that is not invertible; that the density of the absolutely continuous part is invariant (that is
    EN2-AC-ERG's first step)
  argument: § 4.2 The step from `Γ` to `U`
  verdict: derived
  grade: hand
  minds: 1
  model: `X` the circle `ℝ/ℤ`, `U` the group of order two generated by the rotation by `1/2`, `m` Lebesgue,
    `ν = ½·m + ¼·(δ_0 + δ_{1/2})`: `ν_ac = ½·m` and `ν_s = ¼·(δ_0 + δ_{1/2})`, each invariant
  prior art: known — textbook (the Lebesgue decomposition commutes with a measure isomorphism); Mathlib holds
    `MeasurableEmbedding.singularPart_map`, seen by name at this library's pin, not read
  handoff: de Bruijn — the statement as written, for module M7 (a few lines over Mathlib's `singularPart`)

derivation: EN2-AC-ERG
  statement: Let `T` be a bijection of a measurable space `X`, measurable in both directions, preserving a probability `m` for which
    `T` is ergodic, and let `λ` be a finite measure on `X` with `λ ≪ m` and `T_*λ = λ`. Then `λ = λ(X)·m`.
  uses only: the Radon–Nikodym density `g` of `λ`; `g∘T⁻¹ = g` almost everywhere, from the invariance of `λ` and of `m`; an
    almost-everywhere invariant integrable function of an ergodic map is almost everywhere constant
  not claimed: the statement for a non-ergodic `m` (false: the mean of the Haar measures of two cosets of a subgroup of index two);
    anything about entropy
  argument: § 4.2 The step from `Γ` to `U`
  verdict: derived
  grade: hand
  minds: 1
  model: `X = R̂`, `T` multiplication by `(3 + 4i)/5`, `m` Haar: ergodic because no non-zero element of `R` has a finite orbit under
    a non-torsion unit vector; `λ = m` itself
  prior art: known — textbook (an invariant measure absolutely continuous to an ergodic one is proportional to it; recalled as
    Walters, *An Introduction to Ergodic Theory*, ch. 6, not read)
  handoff: de Bruijn — the statement as written, with the ergodicity of Haar measure on `R̂` under one non-torsion unit vector as its
    companion leaf (the Fourier argument of X02D l. 200–201)

derivation: EN2-SING-COMP
  statement: Let `X` be a standard Borel space, `𝓘` a sub-σ-algebra of its Borel σ-algebra, `m` and `λ` probabilities on `X` with
    `λ ⟂ m`, and `κ` the conditional-expectation kernel of `λ` on `𝓘`. Then for `λ`-almost every `x` there is a Borel set of
    `κ(x)`-measure 1 and `m`-measure 0; in particular `κ(x) ≠ m`.
  uses only: `∫ κ(x)(S) dλ(x) = λ(S)` for one Borel set `S`; `κ(x)(S) ≤ 1`
  not claimed: that `κ(x)` is ergodic or invariant for any action (the release's theorem supplies that, separately); any group
  argument: § 4.2 The step from `Γ` to `U`
  verdict: derived
  grade: hand
  minds: 1
  model: `X = [0, 1]`, `𝓘` trivial, `m` Lebesgue, `λ = δ_0`: `κ(x) = δ_0` for every `x`, and `S = {0}`
  prior art: known — a one-line consequence of the disintegration identity
  handoff: de Bruijn — the statement as written, for module M7; over the release's first conjunct
    (`condExpKernel μ m ∘ₘ μ.trim hm = μ`)

derivation: EN2-PE2-SING
  statement: For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`, the singular part `τ_s` of
    `τ` with respect to Haar measure `m` is `U`-invariant with `h_{τ_s}(u) = 0` for every `u ∈ U`, and `τ − τ_s = a·m` with
    `a = max{c ≥ 0 : c·m ≤ τ}`.
  uses only: EN2-LEB-INV; EN2-AC-ERG with the ergodicity of `m` under one non-torsion unit vector; EN2-SING-COMP; the canonical
    ergodic decomposition for the countable group `Γ` on the standard Borel space `R̂`, existence only, in the release's form; Lemma Γ
    (X02D § 3.1, which reads `[EinsiedlerLindenstrauss2022]` Thm 1.2 on the pieces) and Lemma W (X02D ll. 156–163), by statement;
    that a mixture of invariant measures of entropy zero has entropy zero; `Γ ⊆ U` and `u_*m = m`; that a torsion `u` has entropy zero
  not claimed: that `U` is used as an abelian group in this step (it is not; Lemma Γ and Lemma W use it); that an invariant measure
    of entropy zero for every `u` is singular to `m` (that would need Haar measure to have positive entropy for some `u`, which this
    step never reads); Lemma Γ and Lemma W themselves, which were not re-derived; the fields where `R ≠ O′`, at which Lemma Γ's
    inputs are as X02D leaves them
  argument: § 4.2 The step from `Γ` to `U`
  verdict: derived
  grade: hand
  minds: 1
  model: `τ = m + λ_ρ` with `λ_ρ` EF-X's circle measure (X01D § 2.2), carried by `A`, which is `m`-null (J45's N1 (c), by
    statement): `τ_s = λ_ρ`, `a = 1`; and `τ = m`: `τ_s = 0`, `a = 1`
  prior art: known — the Lebesgue decomposition of an invariant measure into invariant parts is textbook; its use for this step in
    place of an ergodic decomposition of `τ` under `U` was not searched for and is not claimed new
  handoff: de Bruijn — for module M7, in place of X02D § 3.2 steps 1–5: `entropySplit` with `τ′` the singular part

derivation: EN2-PE2
  statement: PE-2 (PE-lim): for every real number field `F`, every `U`-invariant finite positive measure `τ` on `R̂` is `a·m + τ′`,
    `a ≥ 0`, `τ′` `U`-invariant with `h_{τ′}(u) = 0` for every `u ∈ U`; equivalently every `U`-ergodic `ν` is `m` or of zero entropy
    for every `u`.
  uses only: EN2-PE2-SING for the first sentence; for the second, EN2-PE2-SING, a `U`-invariant `m`-null set carrying the singular
    part, and the ergodicity of `ν`
  not claimed: any change to the statement (it is FS100-PE2's, `plans/FS100-derivation.md` l. 191, quoted); its grade there (two
    derivations blind to each other) — this is a third route to the step from `Γ` to `U` only, one mind, over the same Lemma Γ
  converse: one-way — both sentences are proved outright (§ 4.2, § 4.3); the implication from the ergodic form to the decomposition
    is X02D's step 5, which reads the ergodic decomposition for `U` and is not used or re-derived here
  argument: § 4.3 The ergodic form
  verdict: derived
  grade: derived from: EN2-PE2-SING
  minds: 1
  model: `τ = m + λ_ρ` as in EN2-PE2-SING: `a = 1`, `τ′ = λ_ρ`; ergodic `ν = λ_ρ`: not `m`, entropy zero for every `u`
  prior art: known — FS100-PE2 (X02D § 3.2–3.3; X02V § 2.3); the statement's own prior-art cell stands as filed
  handoff: de Bruijn — module M7's `entropySplit`; the statement is unchanged, its proof's step from `Γ` to `U` is § 4.2

derivation: EN2-EQUIV
  statement: Let a countable abelian group `U` act on a standard Borel space `X` by Borel automorphisms preserving a probability
    `ν`, let `Γ` be a subgroup of `U`, and `κ` the conditional-expectation kernel of `ν` on the σ-algebra of `Γ`-invariant Borel
    sets. Then for every `u ∈ U`, `u_*κ(x) = κ(ux)` for `ν`-almost every `x`.
  uses only: `u` commutes with `Γ` (so `u` and `u⁻¹` preserve the `Γ`-invariant σ-algebra); `u_*ν = ν`; the defining property of
    conditional expectation; a countable family of bounded Borel functions that determines a measure
  not claimed: that PE-2 needs it (it does not: § 4.2); an everywhere statement; anything for `u` not commuting with `Γ`
  argument: § 4.4 "`u` permutes the components" is a computation
  verdict: derived
  grade: hand
  minds: 1
  model: `X = (ℤ/2)²`, `Γ` generated by the flip of the first coordinate, `u` the flip of the second, `ν` uniform: `κ(x)` is uniform
    on the `Γ`-orbit of `x`, and `u` carries the orbit of `x` to the orbit of `ux`
  prior art: known — equivariance of conditional expectation under a measure-preserving automorphism of the sub-σ-algebra; textbook
  handoff: none — answers the asker's sub-clause; idle for PE-2

derivation: EN2-DECOMP
  statement: § 3.2 goes through on the canonical decomposition, where "`u` permutes the components" is a computation and no
    uniqueness theorem is read.
  uses only: EN2-PE2-SING and EN2-PE2 (the conclusions of § 3.2, by a route that reads the canonical decomposition for `Γ` in
    existence form); EN2-EQUIV (the sub-clause); § 4.1 (the reading)
  not claimed: that no uniqueness statement of any kind is read — the uniqueness of the Lebesgue decomposition is, and Mathlib holds
    it; that X02D's § 3.2 survives line by line (its steps 1, 3 and 5 are replaced, not repaired); anything about § 3.3 or about
    X02V's route, each of which cites uniqueness and neither of which is needed
  argument: § 4.0 Verdict first
  verdict: derived
  grade: derived from: EN2-PE2-SING, EN2-PE2, EN2-EQUIV
  minds: 1
  model: the measure `τ = m + λ_ρ` of EN2-PE2-SING, on which every step of § 4.2 is non-trivial except Lemma Γ's Haar case
  prior art: known — see EN2-PE2-SING
  handoff: de Bruijn — M7 reads T1 as the release's `action_ergodic_decomposition` and nothing more of the ergodic decomposition

### 4.6 Would-have-searched-here log

- None.

---

## Stage 5 — SAVED (for the kernel lane: what each module reads; a leaner variant for M7; the look-back; drafts)

*Every "is the statement" below is said of a stored statement I read in the release's source (§ 1.2), not of a name. I built nothing
and ran nothing there; "proves" means what the asker's survey means by it (a `theorem` with a proof in a file with no `sorry` and no
`axiom` by search), and for the three maximal-inequality files I read the proofs as well.*

### 5.1 Module M8 (EF_F⁺): the classical statements Lemma 3.1′ needs, in place of Shannon–McMillan–Breiman

| # | the statement, with its hypotheses | where it is | is the named declaration that statement? |
|---|---|---|---|
| 1 | *The rate of one partition is zero.* For a probability `μ` preserved by `T` and a measurable `P : Y → Fin k`: if the entropy of `T` is `0` then `liminf_n H_n/n = 0`, hence `inf_n H_n/n = 0` | by definition, in either library: this library's `ksEntropy` is a supremum over partitions of a `liminf`; the release's `measureEntropy` is `⨆ k, ⨆ P : Y → Fin k, ⨆ _, ofReal (observationEntropyRate μ T P)` with `observationEntropyRate := sInf {H_N/N : N ≥ 1}` (`PrimePackets/ShannonEntropy.lean` ll. 276–299) | yes — it is the definition. **No limit theorem is read**: EN2-ZE is stated with the infimum on purpose |
| 2 | *A large block length with small `H_k/k`.* From a `liminf` equal to `0`: immediate (infinitely many `k`). From an infimum equal to `0`: by subadditivity, `H_{jk} ≤ j·H_k` | the release's `orbitEntropy_subadditive` (ll. 257–260): for `[IsProbabilityMeasure μ]`, `MeasurePreserving T μ μ`, fibres of `P` measurable, `Subadditive (fun N => observationEntropy μ (orbitName T P N))`; or its `tendsto_observationEntropyRate` (ll. 281–285) | yes, each is the statement. Needed only if the module reads the release's `sInf` form; with this library's `liminf` form nothing is needed |
| 3 | *Markov on the terms of one `H_k`.* For a probability vector `p` on a finite set and `c > 0`: `Σ_{a : p a < e^{−c}} p a ≤ H(p)/c` | **fresh**; two lines over `Real.negMulLog` (each term of `H` is non-negative, and a term with `0 < p a < e^{−c}` is at least `c·p a`) | not in the release by name; not looked for further |
| 4 | *The maximal ergodic inequality for the indicator of a set.* For a finite measure `μ`, `MeasurePreserving T μ μ`, a measurable `A` and `δ > 0`: `δ·μ{x : ∃ n, δ·n < #{j < n : T^j x ∈ A}} ≤ μ(A)` | **the release**, `DukePrimeDegree/Dynamics/MaximalOccupation.lean` ll. 49–52, `excessiveOccupation_measure_bound`: `(μ : Measure Y) [IsFiniteMeasure μ] {T : Y → Y} (hT : MeasurePreserving T μ μ) {A : Set Y} (hA : MeasurableSet A) {δ : ℝ} (hδ : 0 < δ) : ENNReal.ofReal δ * μ (excessiveOccupation T A δ) ≤ μ A`, with `excessiveOccupation T A δ := {x | ∃ n : ℕ, δ*n < (visitCount T A n x : ℝ)}` and `visitCount T B N x := ((Finset.range N).filter fun j => T^[j] x ∈ B).card` (`PrimePackets/InverseEntropy.lean` l. 248) | **yes, it is the statement, word for word.** It is not among the declarations the asker's § 4.2 names (the survey covered `PrimePackets/` and `DukePrimeDegree/Entropy/`; this is `DukePrimeDegree/Dynamics/`). Under it: `finite_hopf_maximal` (`Dynamics/HopfMaximal.lean`, 107 lines), whose proof I read: it uses Mathlib's `birkhoffSum` and integrals only. An equivalent form with the good set handed over: `exists_discrete_average_good_set` (`Geometry/DiscreteMaximal.lean` ll. 51–58): a measurable `G` with `μ Gᶜ ≤ ofReal ((∫ g)/c)` and `∀ x ∈ G, ∀ n, birkhoffSum T g n x ≤ c·n` |
| 5 | *The count*, EN2-CNT | **fresh**; combinatorics on `Fin n → α` | — |
| 6 | a geometric series; a countable union bound | Mathlib | — |

**Imports, for whoever ports #4.** `HopfMaximal.lean` imports `Geometry/LeafLusinGoodSet` (the family's geometry) and
`Mathlib.Dynamics.BirkhoffSum.Basic`; nothing in the 107 lines I read uses the first. `MaximalOccupation.lean` imports `HopfMaximal`
and `PrimePackets/InverseEntropy` (for `visitCount`, `visitCount_cast`, `measurable_visitCount`), which imports `IdealNorms`. So the
cone as declared is large and the cone as used is two short files and three lemmas; computing it is the port's first step, and
writing the 230 lines fresh over Mathlib is the fallback. This library's Mathlib has no maximal or pointwise ergodic theorem that I
found by name (`Mathlib/Dynamics/BirkhoffSum/`: four files).

**No longer read by M8.** Shannon–McMillan–Breiman (in neither library); Egorov (Mathlib, not needed); Jacobs's formula and the
ergodic decomposition for the single map `u*`; conditional information; the martingale theorem. **Of the two declarations the
asker's § 4.2 lists beside Shannon–McMillan–Breiman, neither is EN2-ZE.** `measureEntropy_eq_zero_of_good_names`
(`Entropy/EntropyCover.lean` ll. 50–60) is its converse: finite sets `G N` of names carrying all but `ε` of the mass with
`log #(G N) ≤ ε·N`, eventually, for every partition and `ε`, give entropy zero. `measureEntropy_lower_of_good_atoms`
(`ShannonEntropy.lean` ll. 435–444), applied to the sets `A_N` of points whose atom is smaller than `e^{−βN}` (each name-cell meets
`A_N` in mass at most `e^{−βN}`), gives at entropy zero only that `μ(A_N)` is below any `w > 0` for infinitely many `N` — less than
Markov's inequality gives, and not a set good at every large scale.

**What the planner types for the module**, in sentences: (a) EN2-CNT as stated; (b) EN2-ZE as stated, for `MeasurePreserving T μ μ`,
a probability `μ`, `P : Y → Fin k` with measurable fibres, hypothesis "the rate of `P` is `0`" in the library's own form; (c)
EN2-L31, which is X01D's Lemma 3.1′ unchanged, proved from X01D's parts (i), (ii), (iv) and (b) at `T = rot u*`. Steps 3–7 are as
X01D has them. If the planner wants scales in a ratio other than `M, M²`, EN2-MEAN-WINDOW gives the exponent: `K > 3 + 3c`.

### 5.2 Module M7 (PE-2): the classical statements the step from `Γ` to `U` needs, and a variant that needs fewer

**On § 4.2's route (the Lebesgue decomposition).**

| # | the statement, with its hypotheses | where it is | is the named declaration that statement? |
|---|---|---|---|
| 1 | *The Lebesgue decomposition with uniqueness*, for finite measures on a measurable space | Mathlib (`Measure.singularPart`, `Measure.rnDeriv`, the uniqueness lemmas; `MeasurableEmbedding.singularPart_map` seen by name) | not the release's; Mathlib's statements not read by me beyond their names |
| 2 | *T1, existence, canonical form.* For a countable group `H` acting on a standard Borel space `Y` (non-empty), each `g • ·` preserving a probability `μ`: with `κ` the conditional-expectation kernel of `μ` on the σ-algebra of sets invariant under every `g`, `∫ κ dμ = μ` and `κ(x)` is `H`-invariant and `H`-ergodic for almost every `x` | the release, `PrimePackets/ErgodicDecomposition.lean` ll. 127–134, `action_ergodic_decomposition` (quoted in § 1.4) | **yes, it is the statement** — both conjuncts, with invariance of the components inside `ErgodicSMul`. Used at `H = Γ`, `Y = Dual F`, `μ =` the normalised singular part. **Its uniqueness is not read anywhere** |
| 3 | *A mixture of invariant measures of entropy zero has entropy zero.* For a probability `τ` on `Z`, a Markov kernel `κ : Z → Y`, a measurable `T`, `κ z` preserved by `T` and of entropy zero for `τ`-almost every `z`: the entropy of `T` for `κ ∘ₘ τ` is zero | the release, `PrimePackets/EntropyMixtures.lean` ll. 499–504, `measureEntropy_kernel_zero` | **yes, it is the statement.** Used at `Z = Y` with the invariant σ-algebra, `τ = μ.trim _`, the same typing as #2's own conclusion |
| 4 | *Haar measure on `R̂` is ergodic for multiplication by one non-torsion unit vector* | **fresh** (the Fourier argument: X02D l. 200–201) | — it needs the characters to span a dense subspace of `L²(m)` (Stone–Weierstrass on the compact dual), which is the heaviest leaf on this route |
| 5 | *An invariant measure absolutely continuous to an ergodic one is a multiple of it* (EN2-AC-ERG); *the parts of the Lebesgue decomposition are invariant* (EN2-LEB-INV); *the components of a measure singular to `m` are not `m`* (EN2-SING-COMP) | fresh, short, over #1 and #2 | — |

**A variant that reads neither the Lebesgue decomposition nor the ergodicity of Haar measure.** § 4.2 identified the constant:
`a = max{c ≥ 0 : c·m ≤ τ}`. Start from there instead.

1. *The largest Haar multiple.* For a finite measure `τ`, the set `{c ≥ 0 : c·m ≤ τ}` (setwise inequality on Borel sets) contains
   `0`, is bounded by `τ(X)` and is closed; let `a` be its maximum. `τ′ := τ − a·m` is a finite positive measure, `U`-invariant
   because `τ` and `m` are, and **no `c > 0` has `c·m ≤ τ′`**.
2. *The Haar set of the kernel is null.* Fix an admissible `Γ`; suppose `τ′ ≠ 0`; `λ := τ′/τ′(X)`; `κ` the conditional-expectation
   kernel of `λ` on `𝓘_Γ`. For `r ∈ R ∖ {0}` let `f_r(x) := ∫ χ(r) dκ(x)(χ)`, an `𝓘_Γ`-measurable function and a version of
   `E_λ[ev_r | 𝓘_Γ]`, and `A := {x : f_r(x) = 0 for all r ≠ 0}`, in `𝓘_Γ` (`R` is countable). The measure `λ|_A` has Fourier
   coefficient `∫_A ev_r dλ = ∫_A f_r dλ = 0` at each `r ≠ 0` (the defining property of conditional expectation, `A ∈ 𝓘_Γ`) and
   mass `λ(A)`; a finite measure on `R̂` is determined by its Fourier coefficients (X02D's T4, which Lemma Γ reads already), so
   `λ|_A = λ(A)·m`. Hence `λ(A)·τ′(X)·m ≤ τ′`, and by step 1 `λ(A) = 0`.
3. *Entropy zero.* For `λ`-almost every `x`: `x ∉ A`, so `κ(x)` — a probability — has a non-zero Fourier coefficient off `0` and is
   not `m`; it is `Γ`-invariant and `Γ`-ergodic (the release's theorem); Lemma Γ gives `h_{κ(x)}(γ) = 0` for all `γ ∈ Γ`; the
   mixture lemma gives `h_{τ′}(γ) = 0`. Lemma W and the torsion case finish as before. ∎

The inputs of this variant: Haar measure exists and is `U`-invariant; T4; the release's two theorems (#2, #3 above); Mathlib's
conditional expectation; Lemma Γ and Lemma W. It proves PE-2's first sentence — which is what the typed `EntropySplit` says — and
not the ergodic form, nor that `τ′ ⟂ m`; for those § 4.2–4.3 stand. Given the ergodicity of `m` the two routes produce the same `a`
and the same `τ′` (§ 4.2, "What `a` is").

derivation: EN2-PE2-MAX
  statement: For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`, the set of reals `c ≥ 0`
    with `c·m ≤ τ` has a largest element `a`, and `τ − a·m` is a positive `U`-invariant measure with `h_{τ − a·m}(u) = 0` for every
    `u ∈ U`.
  uses only: `u_*m = m`; that a finite measure on `R̂` is determined by its Fourier coefficients; the conditional-expectation kernel
    of a `Γ`-invariant probability on the `Γ`-invariant σ-algebra, with the release's two properties (it integrates to the measure;
    its values are almost surely `Γ`-invariant and `Γ`-ergodic) and the defining property of conditional expectation on one
    invariant set; Lemma Γ and Lemma W by statement; that a mixture of invariant measures of entropy zero has entropy zero; that a
    torsion `u` has entropy zero
  not claimed: the ergodic form of PE-2; that `τ − a·m` is singular to `m` (true by EN2-PE2-SING, which reads the ergodicity of
    `m`; this argument does not show it); Lemma Γ and Lemma W themselves
  argument: § 5.2 Module M7
  verdict: derived
  grade: hand
  minds: 1
  model: `τ = m + λ_ρ` (EN2-PE2-SING's model): `a = 1`, since `c·m ≤ m + λ_ρ` forces `c ≤ 1` on the complement of the `m`-null set
    carrying `λ_ρ`; `τ − m = λ_ρ`
  prior art: known — see EN2-PE2-SING; not searched
  handoff: de Bruijn — the route to `entropySplit` with the fewest classical inputs: no Lebesgue decomposition, no ergodicity of
    Haar measure, no uniqueness of an ergodic decomposition, no decomposition for `U`

**Two points of typing the planner will meet** (sentences, not Lean). (i) The typed `EntropySplit` asks for a *probability* `ρ` of
entropy zero with `τ = a•m + b•ρ`; when `τ′ = 0` take `b = 0` and `ρ` the point mass at the trivial character (rotation-invariant;
every name-cell has mass `0` or `1`, so its entropy is zero). (ii) It quantifies over `m` with `IsHaarFourier m`; both routes use one
such `m` throughout, and by T4 there is only one.

**No longer read by M7.** The uniqueness of the ergodic decomposition (the asker's "formalize fresh" item); the ergodic
decomposition for `U`; the measurability of `{m}` in a space of measures; on the variant, the ergodicity of Haar measure.
**Still read:** T1's existence in the release's form; T2 and T4 inside Lemma Γ (not this job's question); T3's consequence.

### 5.3 The look-back

- **Could each have been foreseen?** EN2-ZE: yes, by a coder — a source of rate zero has a short codebook, and no code is beaten by
  more than a logarithm; the surprise is only that Markov's inequality, which the asker reached for, is the right tool at one block
  length and the wrong one across scales. EN2-PE2-SING: yes, by anyone asked "what are the two parts canonically?" — the
  absolutely continuous and the singular. X02D reached the same two parts through a measure on a space of measures.
- **Do they deform into neighbours?** EN2-ZE at entropy `h > 0` wants the upper half of the entropy theorem and its step 2 fails
  (Markov gives `h/(h + γ)`); with an ergodic theorem in place of Markov it is the covering proof of that theorem. With the
  release's `measureEntropy_eq_zero_of_good_names` it is one direction of a characterisation of entropy zero by eventually-few
  names. EN2-PE2-SING with `m` replaced by any `U`-ergodic invariant probability `m₀` and "Lemma Γ" by "every `Γ`-ergodic measure
  other than `m₀` has property `𝒫`", for a property closed under mixtures: the singular part with respect to `m₀` has `𝒫`.
- **What else does the home say?** That `a = max{c : c·m ≤ τ}` and `τ′ ⟂ m` (drawn, § 4.2). That for a `U`-ergodic `ν`, `ν = m` or
  `ν ⟂ m` (drawn, § 4.3). Not drawn: whether every invariant measure of entropy zero for all `u` is singular to `m` — it needs
  Haar measure to have positive entropy for some `u`, which nothing on this path reads.
- **Is it new, in the new words?** Not searched, and nothing here is claimed new (the claim list's own *not claimed*). Both
  arguments are textbook material rearranged; the sources named are recalled, not read.
- **How it was found.** EN2-MEAN: by taking the asker's scheme seriously enough to compute its window and its summability
  (§§ 3.1–3.2), finding the obstruction exact, and then asking what every measure of entropy zero carries (few names) instead of
  what a failure would carry (a slow rate); a side attempt to do without the chain of scales (one scale and the dynamics on a
  tube) was killed by Haar measure. EN2-DECOMP: by writing the step for a measure theorist with the words "ergodic decomposition"
  struck; and the variant of § 5.2 by reading what constant the Lebesgue route had identified.

### 5.4 Drafts for files I do not write

**A dated note for `plans/FS100-derivation.md`, to follow the paragraph of FS100-EFP** (the original text stands; nothing in it is
wrong):

> *Dated note, 2026-10-13 (FS131-EN2; `plans/FS131-EN2-derivation.md` §§ 3.5–3.6).* Lemma 3.1′'s proof need not read
> Shannon–McMillan–Breiman, Jacobs's formula or Egorov. Its part (iii) follows from EN2-ZE — for a measure-preserving map and a
> finite partition of rate zero, a set of measure near one on which no atom of `ξ_n` is smaller than `e^{−βn}` for every large `n` —
> whose inputs are Markov's inequality at one block length, a count of words (EN2-CNT) and the maximal ergodic inequality for the
> indicator of a set. [hand], one mind. The statement of EF_F⁺ and every other step are unchanged.

**A dated note for `plans/FS100-derivation.md`, to follow the paragraph of FS100-PE2:**

> *Dated note, 2026-10-13 (FS131-EN2; `plans/FS131-EN2-derivation.md` §§ 4.1–4.3, § 5.2).* The step from `Γ` to `U` need not read
> the uniqueness of the ergodic decomposition, nor an ergodic decomposition for `U`, nor that `U` permutes the `Γ`-components. With
> `a = max{c : c·m ≤ τ}`, `τ′ = τ − a·m` is the singular part of `τ` with respect to `m`; for each admissible `Γ` its canonical
> `Γ`-components are almost surely not `m`, and Lemma Γ with the mixture lemma gives entropy zero (EN2-PE2-SING, EN2-PE2-MAX).
> [hand], one mind. In X02D § 3.2 the uniqueness cited at l. 205 is read by no later step. PE-2's statement is unchanged; a little
> more holds: `τ′` may be taken singular to `m`.

**For `plans/FS131-EN1-derivation.md` § 7.2** (a pointer, to follow its last sentence): "Taken by FS131-EN2: the scheme is summable
along an admissible sequence if and only if `Σ_n H_n/n² < ∞` (EN2-MEAN-SCHEME), and the deduction needs no almost-everywhere
convergence theorem — one maximal inequality (EN2-ZE)."

**For the asker's record** (the planner's own file; a note, not an edit): its § 4.2 rows "T1" and "Shannon–McMillan–Breiman" and its
§ 4.4 bullets for M7 and M8 are answered by § 5.1 and § 5.2 here; the release's `excessiveOccupation_measure_bound` joins the port
list of M0 or is written fresh in M8.

**`plans/GROKKING-INSTANCES.md`, § G79, a new instance, verbatim:** "FS131-EN2 (2026-10-13). The wall arrived as a counterexample's
invariant — 'a summable rate along a geometric sequence, which zero entropy does not supply' (`plans/FS131-EN1-derivation.md`
§ 7.2) — and sharpening it kept it a wall (EN2-MEAN-SCHEME: summable iff `Σ H_n/n² < ∞`). What moved the question was an invariant
every measure of entropy zero carries: at one block length most of the mass sits on few names, and long names are concatenations of
short ones (EN2-ZE). Source: `plans/FS131-EN2-derivation.md` § 2.1, § 3.5."

**`plans/GROKKING-INSTANCES.md`, § G92, a new instance, verbatim:** "FS131-EN2 (2026-10-13). Two proofs read more than their
conclusions consume. X02D § 3.2 cites the uniqueness of the ergodic decomposition three times; one citation is idle and the other
two are consumed only as 'the non-Haar components are not Haar' — the step is the Lebesgue decomposition with respect to Haar
measure (EN2-PE2-SING), and does not use that `U` is abelian. X01D's Lemma 3.1′ cites Shannon–McMillan–Breiman and consumes its
upper half at entropy zero on one set (EN2-ZE). Found by listing, per citing line, what is taken from the theorem
(`plans/FS131-EN2-derivation.md` §§ 1.3–1.4)."

**`BIBLIOGRAPHY.md`, reading status of `[OAIMath2026]`, family 015, to follow the planner's drafted sentence:** "FS131-EN2
(2026-10-13) read in full, statements and proofs, `DukePrimeDegree/Dynamics/HopfMaximal.lean`, `Dynamics/MaximalOccupation.lean` and
`Geometry/DiscreteMaximal.lean` (the finite Hopf maximal inequality and its form for visits to a set); stored statements of
`action_ergodic_decomposition`, `condExpKernel_ae_constant`, `measureEntropy_kernel_zero`, `orbitEntropy_subadditive`,
`tendsto_observationEntropyRate`, `measureEntropy_lower_of_good_atoms`, `measureEntropy_eq_zero_of_good_names`; nothing built."
**Rows for works named from memory and not held** are listed in the report as prior-art debts, not drafted as rows: nothing in this
record rests on them.

### 5.5 Predictions

None was registered before the verdicts (the brief asks for none), so none is scored. Said for the record: before computing § 3.2 I
expected the asker's scheme to stall, and before § 4.2 I expected the canonical route to work with equivariance as the asker
described it; the second expectation was wrong in the direction of *less being needed*.

### 5.6 Would-have-searched-here log (whole job)

- None. No step here is one a search could decide.
