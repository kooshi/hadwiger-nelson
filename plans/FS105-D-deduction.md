# FS105-D — does EL2021's Theorem 1.2 follow from its Theorem 1.3? (blind verifier)

*Job FS105-D, Opus 5.5, 2026-09-26. Brief: `data/fs105/briefs/D105-deduction-blind.md` with `data/fs105/briefs/STANDING-RULES.md`.
Blind until stage 2 is committed: nothing on the brief's fence list opened.*

## Theorems this phase proved

| id | statement | grade, minds | address |
|---|---|---|---|
| D-T1 | For a ℤ^d-action α by automorphisms of a solenoid X: if α is irreducible and not virtually cyclic, then d ≥ 2 and no algebraic factor map φ : X → X₂ onto a non-trivial X₂ carries a virtually cyclic action; if α is totally irreducible, the same holds for every restriction α_Λ′, Λ′ of finite index | [hand], 1 mind (this job) | §2.1 steps 0a–0d |
| D-T2 | EL2021 Theorem 1.3, as stated and read in the senses S1–S6 of §2.3, implies EL2021 Theorem 1.2 | [hand], 1 mind (this job) | §2.1 steps 1–3 |
| D-T3 | (classical, re-derived for the record) if G ≤ X is a finite subgroup, T an automorphism of X with T(G) = G and µ a T-invariant probability measure, then h_µ(T) = h_{π_*µ}(T_{X/G}) | [hand] from the Abramov–Rokhlin formula, 1 mind | §2.1 step 3, B1 |

## Stage 1 — SAVED

### 1.0 The brief's quotations, checked against their sources (standing rule 5)

| brief's words | source | result |
|---|---|---|
| EL2021 "states a Theorem 1.2. On p. 2 it says that theorem was 'already proven in the announcement [7]'" | EL2021 arXiv v1 p. 2: "The following theorem (already proven in the announcement [7]) gives a full generalization of the result of Rudolph and Johnson to actions on higher-dimensional solenoids." | **verbatim, p. 2, correct** |
| "The announcement … gives only an outline" | EL2003 p. 102: "A sketch of how Theorem 1.1 is proved using Theorem 5.1 is given in §6. Full details of the proofs of all theorems announced in this note will be given in [5]."; §6 is headed "Outline of the proof of Theorem 1.1" and ends "Using the total irreducibility of α it is not hard to conclude at this stage that µ is Haar measure on X." | **correct** (the announcement's route to its Thm 1.1 is direct, from its Thm 5.1, not through its Thm 1.3) |
| "EL2021 proves its more general Theorem 1.3" | EL2021 §4.3 "Proof of Theorem 1.3 assuming Theorem 4.1", §7.2 "Proof of Theorem 4.1" | **correct**; EL2021 nowhere writes a deduction of Thm 1.2 from Thm 1.3 (grep of every "Theorem 1.2" in the text: pp. 2, 3 only; p. 3 says "The proofs of Theorem 1.2 and Theorem 1.3 follow the outline of Rudolph's proof") |
| papers "held at `~/source/library/pdf/…`" | `ls` | both held; EL2003's PDF dated 2026-09-26 20:07 |

### 1.1 The two theorems, verbatim

Source: `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (arXiv:2101.11120v1), read from the
`pdftotext` layer and checked against a rendered image of pp. 2–4; super- and subscripts written as in the PDF (`ℤ^d`, `αⁿ`).

**Theorem 1.2** (p. 2): "**Theorem 1.2.** [7, Thm. 1.1] Let α be a totally irreducible, not virtually-cyclic ℤ^d-action by automorphisms of a
solenoid X. Let µ be an α-invariant and ergodic probability measure. Then either µ = m_X is the Haar measure of X, or the entropy h_µ(αⁿ) = 0
vanishes for all n ∈ ℤ^d."

**Theorem 1.3** (pp. 2–3): "**Theorem 1.3** (Positive entropy rigidity theorem). Let α be a ℤ^d-action (d ≥ 2) by automorphisms of a solenoid X.
Suppose α has no virtually cyclic factors, and let µ be an α-invariant and ergodic probability measure on X. Then there exists a subgroup
Λ ⊆ ℤ^d of finite index and a decomposition µ = (1/J)(µ₁ + … + µ_J) of µ into mutually singular measures with the following properties for
every j = 1, …, J.
(1) The measure µ_j is α_Λ-ergodic, where α_Λ is the restriction of α to Λ.
(2) There exists an α_Λ-invariant closed subgroup G_j such that µ_j is invariant under translation with elements in G_j, i.e.
µ_j(B) = µ_j(B+g) for all g ∈ G_j and every measurable set B ⊆ X.
(3) For n ∈ ℤ^d αⁿ_* µ_j = µ_k for some k ∈ {1, …, J} and αⁿ(G_j) = G_k.
(4) The measure µ_j induces a measure on the factor X/G_j with h_{µ_j}(αⁿ_{X/G_j}) = 0 for any n ∈ Λ. (Here α_{X/G_j} denotes the action
induced on X/G_j)."

### 1.2 Every definition they use, verbatim

- **solenoid, irreducible, totally irreducible, virtually cyclic** (p. 2): "In the following a solenoid X is a compact, connected, abelian group
  whose Pontryagin dual X̂ can be embedded into a finite-dimensional vector space over ℚ. The simplest example is a finite-dimensional torus. A
  ℤ^d-action α by automorphisms of a solenoid X is called irreducible if there is no proper infinite closed subgroup which is invariant under α,
  and totally irreducible if there is no finite index subgroup Λ ⊆ ℤ^d and no proper infinite closed subgroup Y ⊆ X which is invariant under the
  induced action α_Λ. A ℤ^d-action is virtually cyclic if there exists n ∈ ℤ^d such that for every element m ∈ Λ of a finite index subgroup
  Λ ⊆ ℤ^d there exists some k ∈ ℤ with α^m = α^{kn}."
- **factor** — never defined as a standalone word. The paper's senses: (i) p. 4, "If φ : X₁ → X₂ is a surjective continuous homomorphism and
  satisfies α₂ⁿ∘φ = φ∘α₁ⁿ for all n ∈ ℤ^d, we say φ is an *algebraic factor map*." (ii) Thm 1.3(4) itself: "the factor X/G_j". (iii) §7.2,
  Lemma 7.4's proof, the one place the hypothesis is used: "By the Jordan decomposition over ℚ, X has a factor isomorphic to Y_irred; the fact
  that α(ℤ^d) on Y_irred is virtually cyclic now contradicts our standing assumption that X has no virtually cyclic factors." (iv) §1.3 and §9
  speak separately of "measurable factors", always with that adjective.
- **Haar measure m_X; ergodic; entropy h_µ(αⁿ)** — standard, not redefined: m_X the Haar probability measure; ergodic = every α-invariant
  measurable set has measure 0 or 1; h_µ(T) the Kolmogorov–Sinai entropy of the single transformation T. EL2021 §3 defines entropy
  *contributions* h_µ(T, V) but Theorems 1.2–1.3 use the plain entropy.

### 1.3 Prior, and what a wrong-reason TRUE would look like

**Prior: TRUE, 0.85.** The authors call 1.3 a strengthening, and total irreducibility should collapse the `G_j` to `{finite, X}`. The 0.15 is
spread over three places I expect trouble: the sense of "no virtually cyclic factors" (the trivial factor `X/X = {0}` is virtually cyclic for
every action, so a literal reading makes 1.3 vacuous), the `G_j` that are finite but non-zero, and the passage from `Λ` to `ℤ^d` and from the
`µ_j` to `µ`.

**A wrong-reason TRUE** would: (a) read total irreducibility as `G_j ∈ {0, X}` and skip finite non-zero `G_j` (the conclusion on `X/G_j` then
has to be carried back to `X` through a finite-to-one extension); (b) treat `G_j` as α-invariant when 1.3 gives only `α_Λ`-invariance (total,
not plain, irreducibility is what is needed); (c) conclude `h_µ(αⁿ) = 0` only for `n ∈ Λ`, or only for one `µ_j`; (d) use "the `µ_j` form one
orbit", which 1.3's statement does not say; (e) verify "no virtually cyclic factors" only for `X` itself, or under the literal reading that
includes `{0}` (then 1.2 would follow vacuously from a theorem with no instances); (f) forget `d ≥ 2`.

### 1.4 Would have searched here

None: the question is a deduction; no search of any kind was a candidate move.

### 1.5 Hazard logged at stage 1

The harness-assigned scratchpad (`/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-…/scratchpad/`) is **shared with other sessions**: a
`wc -l` over it listed some hundred other agents' files by name (e.g. `brief_quotes.txt`, `plan_quotes.txt`, `el.txt`). I opened none of them;
my `pdftotext` also wrote `el2021.txt` and `el2003.txt` into that shared root, overwriting two same-named files (produced from the same PDFs,
so probably identical, unverified). All my later work is in the subdirectory `scratchpad/fs105d/`. For the owner: a covert channel for blind
verifiers, and a way for one agent to clobber another's working files.

## Stage 2 — SAVED

**Verdict: TRUE.** Theorem 1.2 follows from Theorem 1.3's statement, in a page, with the definitions read in the senses S1–S6 below; the
one sense that is forced rather than natural is S3 (the trivial factor is excluded from "virtually cyclic factors"). Grade **[hand]**, **one
mind** (this blind job). Of Theorem 1.3's conclusions the deduction uses the existence of Λ and of the decomposition, pairwise singularity,
the invariance half of (1), (2) and (4); **(3) is not used**, nor is ergodicity of the µ_j.

### 2.1 The deduction

*Setting.* α is a ℤ^d-action by automorphisms of a solenoid X, totally irreducible and not virtually cyclic (the senses of these words:
§2.3); µ is an α-invariant, α-ergodic Borel probability measure on X. X̂ is a subgroup of some ℚ^m, hence countable, so X is compact
metrizable and every finite Borel measure on it is regular. Fix a translation-invariant metric on X.

**Step 0 — the hypotheses of Theorem 1.3 hold.**

- **0a (d ≥ 2).** If d = 1, α is virtually cyclic (n = 1, Λ = ℤ, k = m); if d = 0, α is virtually cyclic (n = 0, Λ = {0}). So d ≥ 2.
  (This holds under either reading of the Λ-quantifier in "virtually cyclic", S2.)
- **0b.** X is a solenoid, and µ is an α-invariant, ergodic probability measure: as in Theorem 1.3.
- **0c (X ≠ {0}).** On X = {0} every action is virtually cyclic (n = 0). So X ≠ {0}; being connected and Hausdorff, X is infinite.
- **0d (no virtually cyclic factors, sense S3).** Let φ : X → X₂ be an algebraic factor map (p. 4) with X₂ ≠ {0}, and K = ker φ. K is
  closed; it is α-invariant (φ(αⁿ x) = α₂ⁿ(φ x) = 0 for x ∈ K); it is proper (X₂ ≠ {0}). α is irreducible (total irreducibility with
  Λ = ℤ^d), so K is not infinite: K is finite. Suppose the action α₂ on X₂ is virtually cyclic, with n ∈ ℤ^d and Λ of finite index: for
  each m ∈ Λ there is k ∈ ℤ with α₂^m = α₂^{kn}. Put β = α^{m−kn}, a continuous automorphism of X. Then φ∘β = α₂^{m−kn}∘φ = φ, so
  f(x) = β(x) − x lies in K for every x. f is a continuous homomorphism from the connected X into the finite (hence discrete) K, so f(X)
  is a connected subset of a discrete space containing 0: f ≡ 0. Hence α^m = α^{kn} for every m ∈ Λ, with the same n and Λ: α is virtually
  cyclic, a contradiction. The case φ = id_X (K = {0}) is included. *If "factors" also counts the factors of a restriction α_Λ′* (S3′):
  the same argument, with total irreducibility at Λ′ making K finite, and the Λ-subgroup Λ″ ≤ Λ′ it produces being of finite index in ℤ^d.

  **So Theorem 1.3 applies**: there are Λ ≤ ℤ^d of finite index, q := [ℤ^d : Λ], and µ = (1/J)(µ₁ + … + µ_J), the µ_j pairwise
  singular probability measures (S4), each α_Λ-invariant (from (1)), with closed α_Λ-invariant subgroups G_j such that µ_j is
  G_j-translation-invariant (2) and h_{µ_j}(αⁿ_{X/G_j}) = 0 for n ∈ Λ (4).

**Step 1 — each G_j is finite or all of X.** G_j is a closed subgroup invariant under α_Λ with Λ of finite index. Total irreducibility (S1)
says no such subgroup is both proper and infinite. So G_j = X or G_j is finite. *(Irreducibility alone would not do: G_j is only
α_Λ-invariant.)*

**Step 2 — Case A: some G_{j₀} = X. Then µ = m_X.**
- µ_{j₀} is a Borel probability measure invariant under every translation of X, so µ_{j₀} = m_X by uniqueness of Haar measure (C1).
- m_X is α-invariant: αⁿ_* m_X is a translation-invariant probability measure (αⁿ is a surjective continuous homomorphism), hence m_X.
- So ν := µ − (1/J)m_X = (1/J)Σ_{k≠j₀} µ_k is an α-invariant measure (difference of two α-invariant finite measures, and positive).
  Suppose J ≥ 2 and put ν′ = ν/ν(X) = (1/(J−1))Σ_{k≠j₀} µ_k, an α-invariant probability measure. Each µ_k (k ≠ j₀) is singular to
  µ_{j₀} = m_X, so ν′ ⊥ m_X: there is a Borel A with m_X(A) = 1 and ν′(A) = 0. Put A′ = ∩_{n∈ℤ^d} α^{−n}A, a countable intersection,
  exactly α-invariant. m_X(A′) = 1 (each α^{−n}A has m_X-measure 1, m_X being α-invariant) and ν′(A′) ≤ ν′(A) = 0. Then
  µ(A′) = (1/J)·1 + ((J−1)/J)·0 = 1/J ∈ (0, 1), contradicting the ergodicity of µ (C3). So J = 1 and µ = µ₁ = m_X.

**Step 3 — Case B: every G_j is finite. Then h_µ(αⁿ) = 0 for every n ∈ ℤ^d.**
- **B1 (to X, for each j and n ∈ Λ).** Let N = |G_j|, π : X → Y := X/G_j, T = αⁿ, S = αⁿ_{X/G_j} (defined because αⁿ(G_j) = G_j), so
  π∘T = S∘π, and µ_j is T-invariant (step 0d). The σ-algebra 𝒜 = π^{−1}ℬ_Y is countably generated, T^{−1}𝒜 = 𝒜 (S is a homeomorphism),
  and its atoms are the fibres π^{−1}(y) = x + G_j, N points each. The conditional measures of µ_j given 𝒜 are a.e. carried by the atoms
  (X standard Borel, 𝒜 countably generated), so for every finite partition R of X, H_{µ_j}(R | 𝒜) = ∫ H_{(µ_j)_x^𝒜}(R) dµ_j(x) ≤ log N,
  a measure on N points charging at most N cells. Applying this to R = ⋁_{i<k} T^{−i}P gives h_{µ_j}(T, P | 𝒜) = lim_k (1/k)
  H(⋁_{i<k}T^{−i}P | 𝒜) = 0 for every finite P, so h_{µ_j}(T | 𝒜) = 0. By the Abramov–Rokhlin formula (C4),
  h_{µ_j}(T) = h_{π_*µ_j}(S) + h_{µ_j}(T | 𝒜) = 0 + 0, the first term being Theorem 1.3(4). (Values in [0, ∞]; no finiteness is used.)
- **B2 (to µ, for n ∈ Λ).** Each µ_j is αⁿ-invariant, so by affinity of entropy (C5) h_µ(αⁿ) = (1/J)Σ_j h_{µ_j}(αⁿ) = 0.
- **B3 (to ℤ^d).** For n ∈ ℤ^d, qn ∈ Λ (Lagrange in the finite group ℤ^d/Λ). µ is αⁿ-invariant, and h_µ((αⁿ)^q) = q·h_µ(αⁿ) (C6), so
  q·h_µ(αⁿ) = h_µ(α^{qn}) = 0, whence h_µ(αⁿ) = 0.

Steps 1–3 exhaust the cases, so either µ = m_X or h_µ(αⁿ) = 0 for all n ∈ ℤ^d: Theorem 1.2. ∎

### 2.2 Classical theorems used

| id | theorem | used at |
|---|---|---|
| C1 | uniqueness of Haar probability measure on a compact (here metrizable) group; a continuous automorphism preserves it | step 2 |
| C2 | the continuous image of a connected space is connected; a finite Hausdorff space is discrete | step 0d |
| C3 | an ergodic measure is not a proper convex combination of two mutually singular invariant probability measures (proved in step 2 from the definition, by the invariant set A′) | step 2 |
| C4 | Abramov–Rokhlin: h_µ(T) = h_{π_*µ}(S) + h_µ(T \| π^{−1}ℬ_Y) for a factor map π of measure-preserving systems on standard Borel spaces (EL2021 p. 17 uses it as "the Rokhlin entropy addition formula"); with disintegration of µ over a countably generated σ-algebra | step 3, B1 |
| C5 | affinity of entropy: h_{Σ p_j µ_j}(T) = Σ p_j h_{µ_j}(T) for T-invariant µ_j (e.g. Walters, *An Introduction to Ergodic Theory*, Thm 8.1; only "≤" is needed, and that follows from H_{Σp_jµ_j}(P) ≤ Σ p_j H_{µ_j}(P) + H(p)) | step 3, B2 |
| C6 | Abramov's power formula h_µ(T^q) = q·h_µ(T), q ≥ 1 (e.g. Walters Thm 4.13) | step 3, B3 |

The textbook sources are cited from standard knowledge; none was opened at this job (no copy found under `~/source/library/`).

### 2.3 The senses the deduction needs

| id | word | sense needed | why it is the paper's sense | if read otherwise |
|---|---|---|---|---|
| S1 | "totally irreducible" | there is no **pair** (Λ, Y), Λ ≤ ℤ^d of finite index, Y ≤ X a proper, infinite, closed, α_Λ-invariant subgroup | the literal "no Λ and no Y" is false of every action (Λ = ℤ^d exists) | — |
| S2 | "virtually cyclic" | ∃n ∈ ℤ^d ∃Λ of finite index ∀m ∈ Λ ∃k ∈ ℤ: α^m = α^{kn} | the natural parse | the reading "for every finite-index Λ" (i.e. α(ℤ^d) ⊆ ⟨αⁿ⟩) changes nothing: steps 0a and 0d run verbatim under it |
| S3 | "α has no virtually cyclic factors" | no algebraic factor map (p. 4) onto a **non-trivial** solenoid carries a virtually cyclic action; equivalently no quotient X/K, K a closed α-invariant **proper** subgroup | the hypothesis is stated before µ, so it concerns α alone; the one use of it (Lemma 7.4) produces an algebraic factor ("X has a factor isomorphic to Y_irred"); the paper writes "measurable factor" when it means one | **counting the trivial factor X/X = {0}**, which is virtually cyclic for every action (n = 0), makes Theorem 1.3's hypothesis unsatisfiable and the deduction vacuous — the one reading under which "TRUE" would be a wrong-reason TRUE. Counting also the factors of α_Λ′ (S3′) is harmless: step 0d covers it. Reading "factor" as *measurable* factor is not the paper's sense and is not attempted |
| S4 | the µ_j | Borel **probability** measures | EL2021's own proof (§4.3): "the probability measures µ_j are α_Λ-invariant and ergodic" | if the µ_j were only positive measures, step 2's normalisation still works when each µ_j ≠ 0 (a zero µ_j cannot be ergodic) |
| S5 | "ergodic", "α_Λ-ergodic" | invariant, and every invariant Borel set has measure 0 or 1 | standard | — |
| S6 | h_µ(αⁿ), h_{µ_j}(αⁿ_{X/G_j}) | Kolmogorov–Sinai entropy of the single transformation, w.r.t. the measure (the push-forward π_*µ_j on X/G_j) | standard; §3's "entropy contributions" are a different quantity, and not the one in 1.2–1.3 | — |

### 2.4 Audit of the TRUE against §1.3's wrong-reason list

(a) finite non-zero G_j: handled (B1). (b) α_Λ- versus α-invariance: step 1 uses total irreducibility, and says why plain irreducibility
does not suffice. (c) Λ to ℤ^d and µ_j to µ: B2 and B3. (d) the orbit of the µ_j: not used; Case A uses only that µ and m_X are
α-invariant. (e) "no virtually cyclic factors" for every non-trivial factor, and the trivial one excluded by name (S3). (f) d ≥ 2: 0a.
Also checked: X = {0} is excluded by "not virtually cyclic" (0c), so "nontrivial factor" and "infinite factor" coincide (a non-trivial
quotient of a connected group is connected, hence infinite).

### 2.5 What this does and does not settle

It settles only the logical step 1.3 ⟹ 1.2. It gives Theorem 1.2 exactly the grade of Theorem 1.3: [external], a published theorem with a
complete proof in EL2021 (ETDS 42 (2022)), unchecked here. It checks nothing inside that proof; in particular the reduction Lemma 4.2 (to
adelic actions) and Lemma 7.4 (where "no virtually cyclic factors" is consumed) were read (§4.1–§4.3, §7.2 to Cor. 7.6) but not audited.
Reading status of the two papers for `BIBLIOGRAPHY.md`: EL2021 — §1 in full, §2 in full, §3.1–§3.3 read, §4.0–§4.4 in full, §5 Theorem
5.1's statement only, §7.1 Theorem 7.1's statement and Lemma 7.2's opening, §7.2 through Corollary 7.6; §§6, 8, 9 unread. EL2003 — held
(`~/source/library/pdf/EinsiedlerLindenstrauss2003-rigidity-zd-actions-tori-solenoids-era-9-99-110.pdf`); §1 in full, §2 to Prop. 2.1 and
the definition of arithmetic actions, §3's opening, §6 in full; §§4–5 unread.

**Proposed `BIBLIOGRAPHY.md` edit** (the close writes it): the `[EinsiedlerLindenstrauss2003]` row (line 706) says "Author's summary only …
Not held"; it is now held at the path above, read in the sections just listed, and its Thm 1.1 is verbatim EL2021's Thm 1.2 except
"Let µ be an α-ergodic measure" for EL2021's "Let µ be an α-invariant and ergodic probability measure", and "λ" for "m_X".

## Stage 3 — SAVED (after stage 2 was committed as 46550398: `plans/FS105-R-reading.md` §2.1, with its §2.2, read)

**Truth: no divergence.** FS105-R §2.1 reaches TRUE for "Thm 1.3 ⟹ Thm 1.2", with the same forced sense of "no virtually cyclic factors"
(non-trivial algebraic factors; the trivial factor makes Thm 1.3 vacuous; Lemma 7.4 as the witness of the paper's sense), the same case split
(each `G_j` finite or `X`, by total irreducibility at Λ), and the same classical inputs (Haar uniqueness, ergodic ⟹ extreme, Abramov–Rokhlin
with the `log |G_j|` fibre bound, affinity, Abramov's power formula). Each step of its §2.1 was re-checked against my §2.1; I found no error in
it. **The deduction now stands at [hand], two minds, reached blind.**

**Divergences of route** (none changes the verdict):

| # | step | FS105-R §2.1 | this job | comment |
|---|---|---|---|---|
| 1 | virtually cyclic factor lifts to α (my 0d, its 1(b)) | dual: `X′^⊥` has finite index in the torsion-free `X̂`, and an automorphism of `X̂` is fixed by its restriction to a finite-index subgroup | primal: `x ↦ α^{m−kn}x − x` is a continuous homomorphism of the connected `X` into the finite `ker φ`, hence 0 | the same fact seen from the two sides of Pontryagin duality |
| 2 | Case A (some `G_j = X`) | uses Thm 1.3(3): the ℤ^d-orbit of `j` is `{j}`, the rest is a union of orbits, so `µ″` is α-invariant; then extremality | does not use (3): `µ − (1/J)m_X` is α-invariant because µ and `m_X` are; then an explicit α-invariant set of µ-measure `1/J` | mine needs one fewer conclusion of Thm 1.3 (my §2 opening: (3) is not used at all) |
| 3 | scope of the "factor" lemma | its Lemma 2.1 proves, for **every** α, that the hypothesis passes to α_Λ (via `X″ = ⋂ αⁿX′`) and to the adelic lift | my 0d covers factors of α_Λ′ only under total irreducibility (S3′), and I did not audit the adelic lift (§2.5) | its Lemma 2.1 is stronger and I checked (i) by hand: the relations `α^m = α^{kn₀}` mod `X′` conjugate to mod `αⁿX′` with the same `k`, `X″ ⊆ X′ ⊊ X`, `X″` α-invariant. Sound. (ii) not re-checked |
| 4 | senses written out | S3 explicitly; total irreducibility "quantifies over every finite-index Λ" (= my S1); probability of the µ_j implicit | S1–S6 tabled, including the literal "no Λ and no Y" parse of total irreducibility (S1) and the Λ-quantifier of "virtually cyclic" (S2), both shown harmless | presentation only |
| 5 | `X = {0}` | not mentioned | excluded by "not virtually cyclic" (0c) | not a gap in its argument: for `X = {0}` the conclusion µ = m_X = δ₀ holds anyway |

**What neither does:** audit Thm 1.3's own proof. FS105-R's (a0) is explicitly "provided Thm 1.3's proof … holds for the actions used", its
(a9), stage 3 — outside this job's fence and not read here.

### Inventory items for the owner (standing rule 9)

- result — EL2021 Thm 1.3 ⟹ Thm 1.2: TRUE [hand], now two blind minds (FS105-R §2.1, FS105-D §2.1); Case A needs neither Thm 1.3(3) nor the orbit argument — `plans/FS105-D-deduction.md` §2.1, Stage 3.
- result — D-T1: irreducible + not virtually cyclic ⟹ d ≥ 2 and no non-trivial virtually cyclic algebraic factor [hand] — §2.1 step 0d.
- correction owed — `BIBLIOGRAPHY.md` line 706, `[EinsiedlerLindenstrauss2003]` "Author's summary only … Not held": held since 2026-09-26, sections read listed — §2.5.
- slip / tool defect — the harness scratchpad handed to this blind job is shared with other sessions (other agents' files visible by name); I overwrote two same-named files (`el2021.txt`, `el2003.txt`, same PDFs) — §1.5.
