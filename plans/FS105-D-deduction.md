# FS105-D — does EL2021's Theorem 1.2 follow from its Theorem 1.3? (blind verifier)

*Job FS105-D, Opus 5.5, 2026-09-26. Brief: `data/fs105/briefs/D105-deduction-blind.md` with `data/fs105/briefs/STANDING-RULES.md`.
Blind until stage 2 is committed: nothing on the brief's fence list opened.*

## Theorems this phase proved

*(filled at stage 2)*

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
