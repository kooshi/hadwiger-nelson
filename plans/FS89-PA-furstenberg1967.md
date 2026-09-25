# FS-89 prior-art reading — Furstenberg 1967, *Disjointness in ergodic theory, minimal sets, and a problem in Diophantine approximation*

*Reader: de Bruijn (FS-89's prior-art reader for this paper), 2026-09-25. Brief: `data/fs89/briefs/PA-furstenberg1967-reader-brief.md`
(commit 710e826e). Copy read: `~/source/library/pdf/Furstenberg1967-disjointness-ergodic-theory-minimal-sets.pdf` (49 pages, a Google
scan; PDF page = journal page). Text taken with `pdftotext -layout`; the OCR layer has spacing noise and garbles script letters (the
class letters 𝓕, 𝓜, 𝓔 and Greek), so every quotation below is **verbatim up to that noise, with the script letters restored** and
marked where a restoration was needed. Where a quotation's words carry weight and the OCR is doubtful, the page image was read
(marked "image-checked").*

**Scope of this record.** Everything here is a statement about what this one paper prints. It edits no shared file. Verdicts are stated at
their exact scope: "the method is Furstenberg's" and "the theorem is Furstenberg's" are different claims and are kept apart.

## 0. Bibliographic facts

- H. Furstenberg, *Disjointness in Ergodic Theory, Minimal Sets, and a Problem in Diophantine Approximation*, Mathematical Systems
  Theory, Vol. 1, No. 1 (Springer-Verlag New York), pp. 1–49 (1967). Footnote 1 (p. 1): "This research was sponsored in part by the Air
  Force Office of Scientific Research and by a grant from the Sloan Foundation." Affiliation: The Hebrew University, Jerusalem.
- Structure (from the Summary, pp. 1–2, and the headings): §0 Summary; **Part I. Disjoint Processes** (p. 2 onward, with an Appendix);
  **Part II. Disjoint Flows** (pp. 23–34); **Part III. Properties of Minimal Sets** (pp. 34–45); **Part IV. A Problem in Diophantine
  Approximation** (pp. 45–49); Bibliography (p. 49; 14 entries). Received 15 July 1966.

## 1. Reading log

| part / section | pages | read | heading and what it holds |
|---|---|---|---|
| §0 Summary | 1–2 | in full | see below |
| Part I | 2–23 | headings and theorem statements only; proofs not read (enough to see Part III uses none of it) | see the end of §1.3 |
| Part II | 23–34 | in full | see §1.2 |
| Part III | 34–45 | in full | see §1.3 |
| Part IV | 45–49 | in full; pp. 45, 47, 48 image-checked | see §1.4 |
| Bibliography | 49 | in full | see §5 |

### 1.0 Summary (pp. 1–2) — read in full

- Processes (measure spaces with measure-preserving maps) and flows ("compact metric spaces with groups of homeomorphisms") are called
  **disjoint** by the "product appears as a factor" condition (p. 1): "An alternative condition is that whenever the two processes appear
  as factors of a third process, then their product too appears as a factor. … We choose the second of these conditions as the more
  useful and refer to it as disjointness."
- **The minimal-set application, verbatim (pp. 1–2):** "For flows the principal application of disjointness is to the study of
  properties of minimal sets (Part III). Consider the flow on the unit circle K = {z: |z| = 1} that arises from the transformation
  z → z². What can be said about the "size" of the minimal sets for this flow … Uncountably many such minimal sets exist in K. … More
  recent examples, however, show that the Hausdorff dimension may be positive. We shall show that, nevertheless, A is small in the sense
  that it does not form a basis for K. That is, there always exist numbers in K which are not finite products of members of A."
- "Our solution to this problem depends upon the fact that minimal flows are disjoint from a class of flows that we call 𝓕-flows. In
  ordinary arithmetic if x and y are relatively prime and y is a factor of xz, then y is already a factor of z. The analogue of this fact
  for flows is given in Lemma III.1, and this provides the key to our analysis." (p. 2)
- **The Diophantine application, verbatim (p. 2):** "Which sets S of positive integers have the property that for every irrational α and
  ε > 0, there exists an s ∈ S with |α − x/s| < ε/s for some integer x? A complete solution may be given in the case that S is a
  multiplicative semigroup of integers. In that case we find (Theorem IV.1) that S necessarily possesses this property unless it is
  contained in the set of powers of a single integer (in which case it does not)."
- Reading order (p. 2): "it is possible for a reader interested in topological dynamics to omit Part I which deals with processes and to
  read only Parts II and III. Although Part IV is presented as an application of the notion of disjointness (and this will be apparent
  after reading Part III), we have suppressed any explicit dependence on the preceding parts in order to make Theorem IV.1 more readily
  accessible."

### 1.2 Part II. Disjoint Flows (pp. 23–34) — read in full

Setting: **a flow is a pair (Ω, T) with Ω compact metric and T a single continuous map of Ω into Ω** (p. 23–24: "A flow is a pair (Ω,T),
where Ω is a compact metric space and T is a continuous map of Ω into Ω. When T is one-one and onto it generates a group of
homeomorphisms of Ω, and we speak of a bilateral flow."). Part II is **one-parameter throughout**; the multi-map setting enters only in
Part IV (§1.4).

- **Definition II.1 (p. 24), verbatim:** "Two flows X = (Ω_X,T) and Y = (Ω_Y,T) are disjoint whenever there exists a flow Z with
  Z →α X, Z →β Y, then there also exists a homomorphism Z →γ X × Y with α = π_X γ, β = π_Y γ. We then write X ⊥ Y."
- **Lemma II.1 (p. 24), verbatim:** "X ⊥ Y if and only if the only closed subset A ⊂ Ω_X × Ω_Y satisfying (a) TA ⊂ A, (b) π_X A = Ω_X,
  (c) π_Y A = Ω_Y, is A = Ω_X × Ω_Y." — **the form Part III uses.**
- Proposition II.1 (factors of disjoint flows are disjoint), II.2 (disjoint flows have no common non-trivial factor), p. 24.
- **§3 Classes of flows (pp. 25–31).** (A) Bernoulli flows 𝓑; Definition II.2 (finite type). **(B) Ergodic flows 𝓔 (p. 26), verbatim:**
  "We say that a flow X is ergodic if every T-invariant proper closed subset of Ω_X is nowhere dense." (C) Weakly mixing flows 𝓦; the
  torus-endomorphism example (p. 27): "(G,m_G,T) is a weakly mixing process if and only if T* has no finite orbit in Ĝ. (If G is a
  torus, then T is represented by an integer matrix and the condition is that no root of unity occur among its eigenvalues.)"
- **(D) 𝓕-flows (p. 27), verbatim:** "We say that a flow X = (Ω,T) belongs to the class 𝓕 (for "fixed point"), or that X is an
  𝓕-flow, if it satisfies the two conditions: (i) Each of the flows (Ω,T^m), m = 1,2,3, ··· is ergodic; (ii) The totality of all fixed
  points of all the powers T^m (i.e., {ω: for some m, T^m ω = ω}) is dense in Ω." Examples (p. 27): Bernoulli flows; **toral
  endomorphisms `(G,T)` with `T*` having no finite orbit** ("T ∈ GL(r,Z/qZ) which is finite, and some power T^m is the identity" on
  points of denominator `q` prime to `det`); the circle `Tx = tx`, `t ≠ 0` an integer, p. 27.
- (E) Minimal flows 𝓜 (p. 28); Proposition II.4 ("A minimal flow is ergodic"); (F) semi-simple 𝓢 (Proposition II.5, 𝓢 ∩ 𝓔 = 𝓜);
  Definition II.3 (recurrent sequences, p. 28–29); Proposition II.6 (p. 29); (G) distal flows 𝓓 (Propositions II.7–II.10, pp. 29–31;
  Definition II.4, group extensions); (H) Kronecker flows 𝓚 (p. 31). Summary list (i)–(vi), p. 31, including (vi) "𝓓 ∩ 𝓦 = 𝓕 ∩ 𝓜 =
  {trivial flow}".
- **§4 Disjointness relations (pp. 32–33).** **Theorem II.1 (p. 32), verbatim:** "If two flows are disjoint, one of them must be
  minimal." **Theorem II.2 (p. 32), verbatim: "𝓕 ⊥ 𝓜."** — introduced by "The following result will be referred to repeatedly in Part
  III." Proof: nested minimal sets `Ω_Y^{(k)}` for `T^{n_k}` with `n_k | n_{k+1}` and every `m` dividing some `n_k`; ergodicity of
  every `(Ω_X, T^{n_k})` (condition (i)) forces the sections to be everything; density of periodic points (condition (ii)) finishes.
  **Corollary (p. 33): "𝓕^⊥ = 𝓜^⊥⊥ = 𝓜"** (verbatim up to OCR).
- **§5 Weakly mixing flows (pp. 33–34).** Proposition II.11 (p. 33): "𝓦 × 𝓜 ⊂ 𝓔." **Theorem II.3 (p. 33): "𝓦 ⊥ (𝓓 ∩ 𝓜)."**
  Problems F and G (p. 34).

**What Part III takes from Part II:** Lemma II.1 (the closed-set criterion for disjointness), the class 𝓕 with its toral examples, and
Theorem II.2 (𝓕 ⊥ 𝓜). This is checked against Part III's text in §1.3.

### 1.3 Part III. Properties of Minimal Sets (pp. 34–45) — read in full

**§1. Minimal Subsets of Groups (pp. 34–35).** Setting, verbatim (p. 34): "Let G be a compact abelian group and T an endomorphism of G
such that X = (G,T) is an 𝓕-flow. In Part II, §3 (D), we showed that this is the case if G is a finite-dimensional torus, and T an
endomorphism of G corresponding to an integer matrix with no roots of unity among its eigenvalues. It will also be the case if
G = A × A × A × ···, where A is a compact abelian group and T represents the shift operator. With this assumption, X ⊥ 𝓜 by Theorem
II.2, and in particular, X is disjoint from its own minimal subflows." **One map T throughout.**
- **Definition III.1 (p. 34), verbatim:** "Let G be a topological group and T an endomorphism of G. A closed T-invariant subset A of G is
  said to be restricted if AB = G for some closed T-invariant set B ⊂ G, implies B = G." (Written multiplicatively.)
- Definition III.2 (basis) and **Lemma III.1 (p. 34), verbatim:** "Let G be a non-trivial compact metrizable group, and suppose that
  (G,T) is ergodic. Then a restricted set cannot be a basis of G."
- **Theorem III.1 (p. 35), verbatim (script 𝓕 restored):** "If (G,T) is an 𝓕-flow, then every minimal set for (G,T) is restricted." —
  "The main result of this section".
- **Lemma III.2 (p. 35), verbatim:** "Let X and Y be disjoint flows, and suppose there is a flow Z and a homomorphism X × Z →π Y. Then for
  each ξ ∈ Ω_X, the map ζ → π(ξ,ζ) takes Ω_Z onto Ω_Y." Introduced as "reminiscent of the familiar fact that if a number divides a
  product and is relatively prime to one of the factors, it necessarily divides the remaining factor." (The Summary, p. 2, calls the
  flow analogue "Lemma III.1" in the OCR layer; the body's divisibility lemma is III.2. Not image-checked; cosmetic.)
- Proof of Theorem III.1 (p. 35): `π(μ, β) = μβ` maps `M × B` onto `G`; `X = (M,T) ⊥ Y = (G,T)` (minimal against 𝓕); Lemma III.2 gives
  `μB = G` for each `μ ∈ M`, so `B = G`. **This is the whole of the "M − M is proper" mechanism, one map at a time.**

**§2. Relative Dimension, Hausdorff Dimension and Topological Entropy (pp. 35–38).** The shift on `Ω = A^ℕ`, `A = {0,…,a−1}`, and its
image `τ_a x = ax mod 1` on `K = ℝ/ℤ`. **Proposition III.1 (p. 36), verbatim:** "Let A be a T-invariant subset of Ω and let A* denote the
corresponding subset of K. Then d(A*) and 𝓗(A) exist and D(A*) = d(A*) = 𝓗(A)/log a" (Hausdorff dimension = relative (box) dimension =
topological entropy / log a; entropy letter restored).

**§3. Deterministic Flows (pp. 38–39).** Deterministic = zero topological entropy. **Proposition III.2 (p. 38), verbatim:** "If A is a
τ_a-invariant closed subset of K such that (A,τ_a) is deterministic, then A is restricted." Then the conjecture he refutes (p. 38): "There
appears to be a certain amount of evidence to support the conjecture that minimal flows are deterministic … We shall see however that
this evidence is misleading and that there exist minimal flows which are not deterministic, or, equivalently, minimal sets for (K,τ_a)
with positive Hausdorff dimension." **Theorem III.2 (p. 38), verbatim:** "There exist minimal sets with positive topological entropy."
(The construction: a recurrent sequence built on a partition of ℕ into arithmetic progressions with a random filling; "if a > 4, the
flow associated with {ξ(n)} will have positive topological entropy", p. 39; Hahn–Katznelson credited with a sharper, strictly ergodic
form, unpublished.) **Together with Proposition III.1 this is the one-generator (lacunary) phenomenon: `×a` on the circle has minimal
sets of positive Hausdorff dimension, hence infinite, non-torsion minimal sets.**

**§4. 𝓜 × 𝓜 ⊄ 𝓢 (pp. 39–41).** Proposition III.3 (p. 40): a subflow of the finite-alphabet shift with infinite space has `X × X` not
semi-simple; the Sturmian example `sgn sin(nα + θ)` (p. 40).

**§5. Binary Sequence Spaces (pp. 41–43).** `Ω₂ = {0,1}^ℕ` as a ring. **Proposition III.4 (p. 41), verbatim:** "If A is a restricted
subset of Ω₂ and M is a minimal set in Ω₂, then MA is restricted." — "a sharpening of Theorem III.1". Definition III.3 (restricted
sequences, the family R); Proposition III.5 (p. 42): an invariant set is restricted iff it lies in R; **Theorem III.3 (p. 43):** "Let R₀
denote the subring of Ω₂ generated by all recurrent binary sequences. Then R₀ ⊂ R." Corollary: R₀ is of the first category.

**§6. R₀-Flows (p. 43).** Definition III.4 (R₀-measurable sequences), Theorem III.4, Definition III.5, **Theorem III.5 (p. 43–44)**
(closure properties of the class 𝓡₀; non-trivial Bernoulli flows are not in it).

**§7. A Necessary Condition for an R₀-flow (pp. 44–45).** "Free on Q" (p. 44); **Theorem III.6 (p. 44), verbatim:** "If (A,T) ∈ 𝓡₀ then
A cannot be free on a relatively dense set (see Definition II.3)." Problems H and I (p. 45).

**What Part III bears on FS-89:** §1 (Theorem III.1, Lemma III.2: the disjointness proof that a minimal set cannot fill `G` against any
closed invariant `B`) and §2–§3 (Proposition III.1 with Theorem III.2: one generator carries infinite minimal sets of positive
dimension). §§4–7 are about products of minimal flows and binary sequence rings; they do not bear. **Part III contains no
multi-parameter statement and no statement about orbits of points**: both enter only in Part IV.

**Part I (pp. 2–23), at the level read.** Sections: 1 Factors and Products of Processes; 2 Disjointness (Lemma I.1, Lemma I.2,
Propositions I.1–I.2); 3 Classes of Processes (Proposition I.3); 4 Entropy (Propositions I.4–I.5); 5 Entropy and Disjointness
(**Theorem I.1, p. 11, verbatim: "Two processes with positive entropy cannot be disjoint."**); 6 (Theorem I.2, p. 14: the processes
disjoint from the Bernoulli processes are the deterministic ones — the Summary's "the processes with entropy 0 are just those which are
disjoint from all Bernoulli flows"; class letters garbled in the OCR, not image-checked); 7 Disjointness and Weakly Mixing Processes
(Theorems I.3–I.4); 8 Relations Among Classes; 9 Disjointness and Filtering (Theorem I.5); 10 Stochastic Sequences and Disjointness
(Theorem I.6); Appendix. **Part III uses none of Part I's results**; it borrows only the word "deterministic" (Part I §3, cited p. 38)
and the analogy "the processes disjoint from Bernoulli processes are precisely the deterministic processes" (p. 38). One Part I remark
touches tori (p. 14, after Theorem I.1): unimodular `A`, `B` with no root-of-unity eigenvalues give positive-entropy processes on `K^m`,
`K^n`, hence non-disjoint, so an `A × B`-invariant measure on `K^{m+n}` with Lebesgue marginals other than Lebesgue exists; "It would be
of interest to construct such a measure directly." Measure-theoretic; not our question.

### 1.4 Part IV. A Problem in Diophantine Approximation (pp. 45–49) — read in full; pp. 45, 47, 48 image-checked

**§1. Minimal Sets on Tori (pp. 45–46).**
- **The lead-in (p. 45, image-checked), verbatim:** "We let K^r denote the r-dimensional torus considered as an additive group: K^r =
  R^r/Z^r. The endomorphisms of K^r correspond to r × r integer matrices, and these form a semigroup E(r). Each σ ∈ E(r) determines a flow
  on K^r, and under certain mild conditions, (K^r,σ) will be an 𝓕-flow. Theorem III.1 then gives us certain information about minimal
  sets of (K^r,σ): If M is minimal and B is an invariant set, then M + B = K^r implies B = K^r."
- **The multi-parameter remark (p. 45, image-checked), verbatim:** "In all this we have been dealing exclusively with a "one-parameter"
  semigroup of transformations. It is not difficult to see that the various notions we have used generalize to the situation where a
  more complicated semigroup acts on the space. Namely, we can allow flows (Ω,Σ) where Σ is now not a single transformation, but an
  abelian semigroup of transformations. The notions of minimal flows, semi-simple flows, 𝓕-flows, and the notion of disjointness all
  generalize to this situation. Developing the analogy we may obtain a generalization of Theorem III.1 to abelian groups on which an
  abelian semigroup of endomorphisms acts. Specifically, we may obtain the following result whose usefulness will develop presently."
  **The general form (any compact abelian group) is announced here in words, never stated or proved in this paper**; what is stated and
  proved is the torus.
- **Proposition IV.1 (p. 45, image-checked), verbatim:** "Let Σ denote a commutative semigroup of endomorphisms of the r-torus K^r. We
  assume (i) that the adjoint semigroup of endomorphisms Σ* of the dual group Z^r possesses no finite invariant subset in Z^r − {0}, and
  (ii) that there exists a prime q with the property that all det σ, σ ∈ Σ, are relatively prime to q. Then if M and B are two closed
  Σ-invariant subsets of K^r and M is minimal with respect to these properties, M + B = K^r implies M = K^r."
  - **A misprint in the conclusion.** The printed statement ends "implies **M** = K^r". The lead-in (above) and the proof's last line
    (p. 46, "Hence ξ + B = K^r, whence B = K^r. This proves the proposition.") both give **B**. Read literally, the printed conclusion is
    false: take `B = K^r`; `K^r` is never minimal, since `{0}` is a closed invariant proper subset. Berend 1983 p. 530 (as quoted in
    `plans/FS89-PA-berend1984.md`) prints it with "B = T^r" and with hypothesis (i) replaced by "there exists some ergodic endomorphism σ
    in Σ". That is **Berend's corrected paraphrase, not Furstenberg's words.** Furstenberg's proof asserts the step between the two forms of
    (i) (p. 46: "hypothesis (i) ensures the existence in Σ of an endomorphism with no roots of unity among its eigenvalues") with no
    argument; the converse direction is one line.
  - **Remark (p. 45, image-checked), verbatim:** "We do not know whether condition (ii) is essential. Condition (i) is indispensable
    because, for example, if Σ were finite, the conclusion of the proposition would be false."
  - **Proof (pp. 45–46), "in a disguised form, avoiding the language of flows".**
    1. `Σ^(n) := {σ ∈ Σ : σ ≡ 1 mod q^n}`. Every `σ ∈ Σ` has a power in `Σ^(n)`, because `Σ mod q^n` is a finite group of matrices, by (ii).
    2. Nested `Σ^(n)`-minimal sets `M^(n) ⊆ M`. Their translates `σ_i M^(n)` over coset representatives cover `M`; commutativity is used
       here.
    3. So some translate of `M^(n) + B` has interior, and then `M^(n) + B` itself does. It is invariant under an element with no
       root-of-unity eigenvalue, which acts ergodically on Lebesgue measure (Halmos [8]). So it has full measure, and being closed it is
       `K^r`.
    4. The points `(a₁q^{−n}, …, a_rq^{−n})` are fixed by `Σ^(n)`, and they are dense. For `ξ` in every `M^(n)`, `ξ + B` contains all of
       them, so `ξ + B = K^r` and `B = K^r`.

    **No step asks any element to expand any direction.** Eigenvalues of modulus 1 that are not roots of unity are allowed, and only
    (i) and (ii) are used.
- **What "M − M is proper" is, exactly.** Take `B = −M`, which is closed and Σ-invariant. The (corrected) proposition then gives
  `M − M = K^r ⟹ M = K^r`, which is impossible for a minimal `M`. So **for every Σ-minimal `M`, `M − M ≠ K^r`**. Furstenberg never states
  this corollary separately. He uses it once, in the proof of Proposition IV.2 (p. 48): "M − M = K. Now this contradicts Proposition
  IV.1."

**§2. Semigroups of Endomorphisms of K (pp. 46–49).** `r = 1`: Σ is a multiplicative semigroup of integers.
- **Definition IV.1 (p. 47, image-checked), verbatim:** "A multiplicative semigroup Σ of integers is lacunary if all the members of Σ⁺ are
  powers of a single integer a. Otherwise, Σ is non-lacunary." Examples: "{a^p, a^{p+1}, a^{p+2}, ···} is a lacunary semigroup.
  {2^n3^m; n,m = 1,2,3, ···} is a non-lacunary semigroup."
- **Lemma IV.1 (p. 47, image-checked), verbatim:** "Let Σ be a non-lacunary semigroup, and suppose Σ⁺ = {s₁,s₂,s₃, ···} with s_i <
  s_{i+1}. Then, as n → ∞, s_{n+1}/s_n → 1." Proof: "an additive semigroup of positive real numbers is either contained in a discrete
  subgroup, or becomes more and more dense as the numbers tend to ∞", applied to `log Σ`.
- **Lemma IV.2 (p. 47, image-checked), verbatim:** "Let Σ be a non-lacunary semigroup and let A be a closed Σ-invariant subset of K with
  the property that 0 is a non-isolated point of A. Then A = K." Proof (p. 48): for `δ_n ∈ A`, `δ_n → 0`, the multiples `s_nδ_{n₂}`
  step by less than ε once the ratios are within `1 + ε`, so they are ε-dense in `[0,1]`.
- **Proposition IV.2 (p. 48, image-checked), verbatim:** "If Σ is a non-lacunary semigroup of integers, the only minimal sets in K for Σ
  are finite sets (of rationals)." Proof, verbatim in its core: "Let M be a minimal set for Σ. M − M is a Σ-invariant set. If M is
  infinite then M − M contains 0 as a non-isolated point. But then, by the foregoing lemma, M − M = K. Now this contradicts Proposition
  IV.1. We conclude that M is finite. Since Σ is infinite, a Σ-invariant set can be finite only if it consists of rationals." (It first
  passes to a non-lacunary `Σ′ ⊆ Σ` with a prime `q` prime to all its members, so that (ii) holds.)
- **Theorem IV.1 (p. 48, image-checked), verbatim:** "If Σ is a non-lacunary semigroup of integers and α is an irrational, then Σα is
  dense in K." Proof, in outline:
  1. The orbit closure `Δ` contains a minimal set, hence a rational `p/q` (Proposition IV.2). It is non-isolated in `Δ`, because `Σα`
     consists of irrationals.
  2. So `0` is non-isolated in `qΔ`, and `qΔ = K` by Lemma IV.2.
  3. Hence `Δ ∪ (Δ + 1/q) ∪ ··· ∪ (Δ + (q−1)/q) = K`, so `Δ` has interior, and `sΔ ⊂ Δ` for `s > 1` gives `Δ = K`.
- **The lacunary counterexample (p. 48, image-checked), verbatim:** "The conclusion of the theorem is clearly false for lacunary
  semigroups. For, let a be a positive integer and set α = Σ_{k=1}^∞ a^{−k²}. Then {a^n α} modulo 1 has only the limit points 0, a^{−1},
  a^{−2}, ···."
- The rest (pp. 48–49):
  - Hardy–Littlewood (`{n^r α}` is dense) as a special case.
  - "The semigroup {2^n3^m} corresponds to a subset which is thinner than any of the {n^r} and for which the same conclusion still holds."
  - Equidistribution fails in this generality (p. 49): for `α = Σ 6^{−n_k}` with `n_k` of sufficiently rapid growth, `{s_n α}` is not
    equidistributed ("We mention without proof").
- **No invariant-measure question is posed in this paper.** Part IV's only measure is Lebesgue measure, in Proposition IV.1's proof. So
  the "×2×3 measure problem" (the close inventory's item 1: "the open ×2×3-type problem") is not stated here, and its attribution to
  Furstenberg needs another source.

## 2. Our records' quotations of Furstenberg, checked against the source (question 2)

**The two second-hand quotations the brief names.**

1. **"Prop. IV.1: for a minimal set `M`, `M − M` is proper."**
   - **Holds, as a corollary and at the torus's scope.** The printed proposition is `M + B = K^r ⟹ B = K^r` for a Σ-minimal `M` and a
     closed Σ-invariant `B`, with the conclusion misprinted as `M = K^r` (§1.4). "`M − M` is proper" is its instance `B = −M`, which
     Furstenberg uses in Proposition IV.2's proof (p. 48) and never states.
   - **Its scope:** a commutative semigroup of endomorphisms of a finite-dimensional **torus**, under (i) (no finite `Σ*`-invariant set in
     `Z^r − {0}`) and (ii) (a prime `q` prime to every `det σ`).
   - **It does not reach a solenoid such as `R̂_S`.** The group form is announced in words on p. 45, and neither stated nor proved. The
     held proof for our action is Berend 1984 Theorem I.2 with Proposition II.6 (`plans/FS89-PA-berend1984.md` §5(a)).
   - **Berend's p. 530 wording is his, not Furstenberg's:** "B = T^r" in the conclusion, and "some ergodic endomorphism" for (i).
2. **The equivalence Berend lists** (`[Berend1984min]` §1, pp. 499–500, citing "[3, prop. III.1, th. III.2, prop. IV.2, th. IV.1]").
   - **The citation is accurate; the description in our records is not quite.**
   - Berend's words are "some of Furstenberg's results … can be combined to yield the following". The theorem has **five** equivalent
     conditions, (1)–(5), assembled from **four** results. Furstenberg states no such equivalence.
   - What each cited result supplies:
     - **Proposition IV.2 and Theorem IV.1:** non-lacunary ⟹ minimal sets finite and rational, and irrational orbits dense (Berend's
       (5) ⟹ (1)–(3)).
     - **Proposition III.1 and Theorem III.2:** Hausdorff dimension = topological entropy / log a, and minimal sets of positive entropy
       exist (for a > 4 in the proof, p. 39). Together they give the lacunary side: one generator has minimal sets of positive dimension
       (Berend's (4) ⟹ (5)).
   - Berend makes the same use on p. 502. His Lemma 3.3 builds its minimal set "As in the proof of theorem III.2 in [3]" and gets
     `dim > 0` "in view of [3, prop. III.1]".

**Every place in `plans/FS89-*.md`, `CLAUDE.md` and the neighbouring shared files that names Furstenberg** (read from disk at commit
710e826e plus the uncommitted `plans/FS89-PA-berend1984.md`). A verdict of "holds" means the words are true of this paper at the scope
written. Every "fix" names what should change. **I edit none of these files.**

| # | where | what it says | verdict |
|---|---|---|---|
| 1 | `BIBLIOGRAPHY.md` main row `[Furstenberg1967]` (l. 305) | "the ×2×3 closed-set theorem (an orbit of a non-lacunary semigroup on the circle is finite or dense; Prop. III.1, Th. III.2, Prop. IV.1–IV.2, Th. IV.1, as combined in `[Berend1984min]` §1)" | **content holds** (Theorem IV.1, p. 48; rational orbits are trivially finite). **Labels need a fix:** the finite-or-dense theorem is Th. IV.1, proved from Lemmas IV.1–IV.2 and Props. IV.1–IV.2. Prop. III.1 and Th. III.2 are the lacunary (one-generator) side, not the ×2×3 theorem. Berend's list has Prop. IV.2, not IV.1 |
| 2 | same row | "Prop. IV.1 (`M − M` proper for a minimal `M`) is the input to Berend's Prop. 4.1 case 1" | **holds**: Berend ETDS p. 504 applies "Proposition IV.1 of [3]" to conclude "M − M is a proper subset of T^r" (a torus, so in scope). Add: corollary of the printed statement (with its misprint), toral |
| 3 | same row, copy and read columns | "not held … **not read**; its statements used here are as quoted in `[Berend1984min]` §1" | **stale**: held (`pdf/Furstenberg1967-…pdf`, Kooshi's save, close inventory item 45); read per §1 |
| 4 | `BIBLIOGRAPHY.md` acquisition row 13 (l. 70) | "not requested (nothing rests on it beyond Berend's quotation)" | **stale**: acquired |
| 5 | `CLAUDE.md` Frontier item 25 | "Two primes restore Furstenberg–Berend rigidity modulo the rotated direction" | **holds as a name.** Furstenberg's part is the circle under a non-lacunary semigroup. "Two primes" is the analogue of his "non-lacunary", in Berend's word "multi-parameter" |
| 6 | `CLAUDE.md` G76 | "the exclusion is **closed-set** (Furstenberg–Berend) rigidity on `R̂` with the archimedean directions rotated" | **holds as a name.** Nothing with a rotated direction is in this paper (§4) |
| 7 | `CLAUDE.md` prior-art position, "Not ours" | "closed-set rigidity for hyperbolic multi-parameter actions and the isometric direction's minimal circles (`[Furstenberg1967]`, `[Berend1984min]`)" | **holds only jointly; split it.** This paper holds the circle case (Th. IV.1, Prop. IV.2) and the disjointness input (Th. III.1; Prop. IV.1 for tori). "Hyperbolic multi-parameter" and "the isometric direction's minimal circles" are Berend's (ETDS Thm 2.1 and Lemma 3.1). **Suggested:** "closed-set rigidity on the circle under non-lacunary semigroups and the disjointness input (`[Furstenberg1967]` Th. IV.1, Props. IV.1–IV.2); for hyperbolic multi-parameter toral actions, and the isometric direction's minimal circles (`[Berend1984min]`, `[Berend1983]`)" |
| 8 | `LEDGER.md` row 95, prior art | "`[Berend1984min]` … and `[Furstenberg1967]` supply the frame and the method" | **holds.** This paper supplies the `M − M` architecture, the density lemma on the circle and the disjointness input (§3) |
| 9 | `plans/FS89-close-inventory.md` item 1 | "re-pose … from invariant measures (the open ×2×3-type problem) to invariant closed sets (Furstenberg–Berend rigidity, proved in print)" | **closed-set half holds.** This paper does not pose the measure problem (§1.4, last bullet) |
| 10 | `plans/FS89-rational-band-rigidity.md` §0.1 (l. 30) | "**Furstenberg's shape**: an orbit avoiding a fixed open set" | **holds**: Theorem IV.1's contrapositive at `r = 1` (an orbit missing an open set is rational) |
| 11 | same, §0.4 item 1 (l. 74) | "Furstenberg's closed-set theorem (×2×3) and Berend's generalisations … require every eigen-direction to be expanded by some element" | **fix: the expansion requirement is Berend's, not Furstenberg's.** At `r = 1` it is automatic; Furstenberg's hypothesis is non-lacunarity. His Prop. IV.1 asks no expansion at all, only (i) and (ii) |
| 12 | same, §0.4 item 3 (l. 86) and §G.6 (l. 383) | "Furstenberg's multi-parameter condition" | **wording fix:** his term is "non-lacunary" (Def. IV.1, p. 47). "Multi-parameter" is Berend's. Furstenberg writes "one-parameter" (p. 45) for a single map. Substance holds |
| 13 | same, §PA.1 (ll. 396–398) | "Furstenberg's ×2×3 theorem is the case of the circle with the semigroup ⟨2, 3⟩: an orbit that avoids an open set is finite (torsion)" | **holds** (Th. IV.1 with Prop. IV.2; his example is `{2^n3^m; n,m ≥ 1}`) |
| 14 | same, §PA.3 (l. 456) and §C.1 (l. 715) | "contradicting Furstenberg's Prop. IV.1: `M − M` is proper" | **holds** at the torus's scope (Berend's use, ETDS p. 504) |
| 15 | same, §PA.3 (ll. 470–472) | "not held … Berend's minimal-sets paper states the four-way equivalence it proves for the circle (Prop. III.1, Th. III.2, Prop. IV.2, Th. IV.1)" | **fix:** five conditions, from four results, combined by Berend (item 2 above). Now held |
| 16 | same, G.1 row FS-73 (l. 371) | "T38 … the Furstenberg correspondence" | **not this paper.** The correspondence principle is not in the 1967 text |
| 17 | `plans/FS89-S1D-derivation.md` §2 opening (l. 87) | "Case 1's contradiction at the band needs no Furstenberg Prop. IV.1" | **holds** |
| 18 | same, D1-L3 (l. 115) | "This is Furstenberg's non-lacunary step, done `p`-adically" | **holds at method scope**, with the difference named in §3 row D1-L3 |
| 19 | same, D1-T1 Remark 2 (l. 157) | "Without D1-L4, case 1 needs Furstenberg's Prop. IV.1 (`M − M ≠ G` for minimal `M ≠ G`) [external, not held]" | **fix twice.** (a) Prop. IV.1 is stated for tori; for `G = R̂_S` the held statement is Berend 1984 Thm I.2 + Prop. II.6 (Furstenberg announces it in words only, p. 45). (b) "not held" is stale. ("`M ≠ G`" is automatic: `G` is never minimal, since `{0}` is invariant) |
| 20 | same, §6 (l. 395) | "Furstenberg Prop. IV.1 … is still not held" | **stale** |
| 21 | `plans/FS89-derivation.md` FS89-D1-L3 (l. 192) | "`[Berend1984min]` Prop. 4.1, case 1, which in print needs Furstenberg Prop. IV.1 and Berend 1983 §4 (not held)" | **attribution holds; "not held" stale** for both |
| 22 | same, FS89-D1-L4 (l. 197) | "Prior art: none (the band replaces Furstenberg's "`M − M` is proper")" | **holds** (§3: D1-L4 not found; the slot it fills is Prop. IV.1's in Prop. IV.2's proof) |
| 23 | `plans/FS89-S1VB-verification.md` §B2 (l. 194) | "Furstenberg's original lemma bases the difference set at `0`, which every automorphism fixes, and so needs no recurrence at all" | **holds**: Prop. IV.2's proof applies Lemma IV.2 to `M − M` with `0` non-isolated (p. 48); no recurrence is used |
| 24 | same, ll. 24 and 163 | "a Furstenberg-type (×a×b in finite quotients) statement"; "a Furstenberg-type density statement in finite quotients" | **no such statement in this paper.** Its one finite-quotient device is `Σ mod q^n` in Prop. IV.1's proof (pp. 45–46), used for periodic points, not density |
| 25 | `plans/FS89-S0B-band-set.md` (l. 244) | "the Furstenberg–Berend shape … the second prime's unit acts at 5 as an isometry with dense orbits and breaks the one-parameter freedom" | **half holds.** "A second independent generator breaks one-parameter freedom" is Furstenberg's (lacunary against non-lacunary). "Acts … as an isometry with dense orbits" is not: his second generator expands, and works through `log Σ` being non-discrete (Lemma IV.1) |
| 26 | `plans/FS89-PA-berend1984.md` l. 18 | "Furstenberg's theorem ([5, p. 48]: a non-lacunary semigroup of integers moves an irrational densely mod 1)" | **holds** (Th. IV.1, p. 48) |
| 27 | same, l. 44 | "the multi-parameter form of Furstenberg's Prop. IV.1" | **wording fix:** Prop. IV.1 is already multi-parameter (commutative semigroups). Berend's Thm I.2 is its **group-flow** form (ℱ-flows on any compact group), which Furstenberg announced on p. 45 |
| 28 | same, l. 289 | "Proposition [1, p. 45]" quoted from Berend 1983 p. 530 as "Furstenberg's Prop. IV.1 in the form D's Remark 2 wanted" | **holds as a quotation of Berend.** It differs from the print in (i)'s wording and in the conclusion's letter (the print's misprint, §1.4) |
| 29 | same, ll. 309, 352 | "its Prop. IV.1 is now available held, as 1984 Thm I.2 + Prop. II.6 and 1983 p. 530"; the note owed to the row | **superseded**: the original is held and read (§1.4) |

## 3. Verdicts on FS-89's statements (question 3)

**The verdicts take three values:**
- **in print:** the statement is in this paper;
- **method in print, statement not:** the argument's shape is here and the statement is not;
- **not found in this paper.**

This paper's whole setting is:
- a single endomorphism of a compact abelian group (Part III);
- a commutative semigroup of endomorphisms of a torus (Prop. IV.1);
- the circle under a semigroup of integers (Part IV §2).

It has no solenoid, no `p`-adic place, no number ring other than `ℤ`, no characters of a ring and no band.

| statement | verdict | result and page | note |
|---|---|---|---|
| **D1-L3** (case 1 at `\|S\| ≥ 2` ⟹ `M − M = R̂_S`) | **method in print, statement not** | Lemma IV.2 (p. 47): a closed Σ-invariant `A ⊆ K` with `0` non-isolated is `K`; Lemma IV.1 (p. 47): the dichotomy "contained in a discrete subgroup, or more and more dense"; Prop. IV.2's proof (p. 48): applied to `M − M` | **Same architecture:** a density lemma applied to the difference set based at `0`. **Different density mechanism.** Furstenberg's comes from two *expanding* generators whose logarithms do not lie in a discrete subgroup, so ratios tend to 1. D1-L3's works at `v`, whose value group is discrete; density comes from the unit part, where the second prime's `w_q` is a `v`-adic unit (an isometry at `v`) generating an open subgroup; then strong approximation goes from the `v`-line to `R̂_S`. None of the `p`-adic unit mechanism, strong approximation or the solenoid is here. "Furstenberg's non-lacunary step, done `p`-adically" is accurate if read as "Lemma IV.1's dichotomy transposed to `ℚ_v^×`". The `p`-adic branch itself is Berend 1984 §II.3 (the Berend reader) |
| **D1-L4** (the parity line: `θ₂ ∈ M − M` ⟹ a corner in `M`) | **not found** | — | The slot it fills is Prop. IV.1's in Prop. IV.2's proof (p. 48), where Furstenberg contradicts `M − M = K` by disjointness. No value constraint, band or distinguished character appears anywhere in the paper |
| **D1-T1** (`MS₄(S)`: minimal sets in `T + A`) | **method in print, statement not** | Prop. IV.2 (p. 48), with Prop. IV.1 (p. 45) and Lemma IV.2 (p. 47): for non-lacunary Σ the minimal sets in `K` are finite sets of rationals | The `r = 1` analogue with no isometric direction, so the conclusion is "torsion", not "torsion plus archimedean". Furstenberg's proof has only D1-T1's **case 1**: on the circle every small difference lies in the expanded direction. The contradiction comes from Prop. IV.1, not from a band. **Case 2 (D1-L2) is absent**; it is Berend's |
| **RQ₄** (`Θ₄(Q) ⊆ T + A`) | **not found** | — | Nothing on `ℤ[i][1/p]`, characters or bands |
| **the one-prime failure** (row 97: over `ℤ[U₅]` the band set is not `T + A`) | **method in print, statement not** — what is printed is the phenomenon at `r = 1` | Definition IV.1 (lacunary, p. 47); the example `α = Σ a^{−k²}`, whose `×a`-orbit closure has "only the limit points 0, a^{−1}, a^{−2}, ···" (p. 48); Theorem III.2 with Prop. III.1 (pp. 36, 38): `×a` has minimal sets of positive Hausdorff dimension; Summary (p. 1): "Uncountably many such minimal sets exist in K" for `z ↦ z²` | "Lacunary" is his word for one generator on the circle. Our `⟨i, w₅⟩` on a two-dimensional solenoid, with one infinite generator, is its analogue, not an instance. **The mechanisms differ.** His examples are homoclinic to `0`: sparse digits, or recurrent sequences on arithmetic progressions. S0B's is heteroclinic between two torsion leaves inside a band set (the Berend reader's same remark for Berend) |
| *not asked:* D1-L2 (case 2 ⟹ a point of `T + A`) | **not found** | — | No contracted or isometric direction exists at `r = 1`, and the torus proposition never splits `M − M` |
| *not asked:* "`M` minimal and `M − M = R̂_S` ⟹ `M = R̂_S`" (PA-B2's input) | **announced, not stated or proved here** | p. 45 remark: "a generalization of Theorem III.1 to abelian groups on which an abelian semigroup of endomorphisms acts"; stated and proved for tori only (Prop. IV.1) | The held proof for `R̂_S` is Berend 1984 Thm I.2 + Prop. II.6. Its toral form holds with isometric directions present (§4) |
| *not asked:* RS₄(S), RQ₅, N₀, EQ, FT, C-HD1, C-47, C-167 | **not found** | — | Outside the paper's setting |

## 4. Isometric or rotating components (question 4)

**Short answer.** Furstenberg never considers a closed invariant set under an action with a rotating direction inside the same group,
and proves no finite-or-dense or torsion conclusion there. Two things in the paper touch the question.

1. **A rotation as a separate factor: disjointness.** The flow `(K, ×2)` is an 𝓕-flow (Part II §3(D), p. 27) and weakly mixing (p. 27).
   An irrational rotation `(K, x ↦ x + α)` is a Kronecker flow (§3(H), p. 31), minimal and distal.
   - Theorem II.2 (𝓕 ⊥ 𝓜, p. 32), read through Lemma II.1 (p. 24), then says: under the single map `(x, y) ↦ (2x, y + α)` on `K × K`, the
     only closed invariant set projecting onto both circles is `K × K`. Theorem II.3 (𝓦 ⊥ 𝓓 ∩ 𝓜, p. 33) gives the same.
   - **This is the one statement in the paper about "×2 alongside an irrational rotation"**, and it is in product form.
   - A rotation and `×2` on the *same* circle do not commute (`2(x + α) ≠ 2x + α`), so that pair is outside his abelian-semigroup
     framework. He does not consider it.
2. **A rotation inside a torus, as a linear isometry.** Prop. IV.1 (p. 45) assumes only (i) and (ii). Its proof uses Halmos's ergodicity
   for an element with no root-of-unity eigenvalues and the density of `q`-power torsion points. **Nothing requires expansion.**
   - So its conclusion — a minimal `M` with `M + B = K^r` forces `B = K^r` — holds for commutative semigroups with eigenvalues of modulus
     1 that are not roots of unity. An ergodic quasi-hyperbolic toral automorphism is an example.
   - **Furstenberg does not remark on this.** For such actions he states nothing about what minimal sets look like. The finite-or-dense
     theorem is proved only at `r = 1`, where no isometric direction exists.

**What this means for "modulo the archimedean leaf".**
- It is **not in this paper**.
- What the paper does show, at the torus's scope, is that the **disjointness half** of the argument, "`M − M` is proper", **does not need
  hyperbolicity**. That is the toral counterpart of what the Berend reader found held for our solenoid (Berend 1984 Thm I.2 + Prop. II.6;
  `plans/FS89-PA-berend1984.md` §5(a)).
- So the obstruction our derivation met at the archimedean place is confined to the **other half**, the finite-or-torsion conclusion.
  That half is Berend's hyperbolicity condition (his ETDS Lemma 3.1), and in Furstenberg it is only the `r = 1` Prop. IV.2.

This reading of the division of labour is mine, one mind, **[reading]**. Its killing test: a toral commutative semigroup satisfying (i)
and (ii) with a minimal `M` such that `M − M = K^r`. That would refute the (corrected) Prop. IV.1, and I expect none.

## 5. The reference list, mined (question 5)

Fourteen entries (p. 49, image-checked). Pages are where the OCR layer shows the marker; `[9]` and `[14]` have no marker in the OCR
layer.

| # | entry, as printed | cited at | bears on FS-89? |
|---|---|---|---|
| 1 | R. L. Adler, A. G. Konheim, M. H. McAndrew, *Topological entropy*, Trans. Amer. Math. Soc. 114 (1965) 309–319 | pp. 36, 38 | no (entropy, for Prop. III.1 and §3) |
| 2 | R. Ellis, *Distal transformation groups*, Pacific J. Math. 8 (1958) 401–405 | pp. 25, 29 | no |
| 3 | H. Furstenberg, *Stationary Processes and Prediction Theory*, Princeton Univ. Press, 1960 | p. 21 (Part I §10) | no |
| 4 | H. Furstenberg, *Strict ergodicity and transformations of the torus*, Amer. J. Math. 83 (1961) 573–601 | p. 10 (Part I, group extensions of a rotation) | no (skew products on tori; unique ergodicity) |
| 5 | H. Furstenberg, *The structure of distal flows*, Amer. J. Math. 85 (1963) 477–515 | pp. 25, 29–30 (Prop. II.9) | no |
| 6 | W. H. Gottschalk, G. A. Hedlund, *Topological Dynamics*, Amer. Math. Soc. Colloq. Publ., "Vol. 83, 1961" as printed (the book is Vol. 36, 1955; not checked further) | pp. 25, 28 | no (textbook) |
| 7 | W. H. Gottschalk, *An irreversible minimal set*, in *Ergodic Theory*, Academic Press, 1963 | p. 38 | no |
| 8 | P. R. Halmos, *On automorphisms of compact groups*, Bull. Amer. Math. Soc. 49 (1943) 619–624 | pp. 27, 46 | **marginal**: the ergodicity input of Prop. IV.1's proof (p. 46: an endomorphism with no root-of-unity eigenvalue acts ergodically on Lebesgue measure) and of p. 27 (weak mixing for Haar measure iff the adjoint has no finite orbit). Berend 1984 Thm I.3 states the ergodicity criterion in the dual form (source not checked). Nothing of ours rests on it |
| 9 | P. R. Halmos, *Lectures on Ergodic Theory*, Math. Soc. Japan, 1956 | no marker found | no |
| 10 | P. R. Halmos, *Entropy in Ergodic Theory*, Univ. Chicago Press, 1959 | pp. 10, 12 | no |
| 11 | I. Niven, H. S. Zuckerman, *On the definition of normal number*, Pacific J. Math. 1 (1951) 103–109 | p. 23 | no |
| 12 | H. E. Robbins, *On a class of recurrent sequences*, Bull. Amer. Math. Soc. 43 (1937) 413–417 | p. 38 | no |
| 13 | V. A. Rokhlin, *New progress in the theory of transformations with invariant measure*, Russian Math. Surveys 15 (1960) 1–22 | pp. 8–9, 14–15 | no |
| 14 | T. S. Wu, *On homomorphisms in topological dynamics*, (to appear) | no marker found | no |

**No entry is a source for closed sets under a group with a rotating direction.** As the Berend reader found for Berend's lists, the
references are textbooks plus the author's own work.

## 6. Proposed bibliography rows (for the close planner; not written into `BIBLIOGRAPHY.md`)

**Main table:**

> | **[Furstenberg1967]** | H. Furstenberg, *Disjointness in ergodic theory, minimal sets, and a problem in Diophantine approximation*,
> Math. Systems Theory 1 (1967) 1–49, doi 10.1007/BF01692494; zbMATH 0146.28502 (reviewer's review) | **FS-89's home theorem.**
> - The ×2×3 closed-set theorem: Th. IV.1 (p. 48): "If Σ is a non-lacunary semigroup of integers and α is an irrational, then Σα is dense
>   in K". Also Prop. IV.2 (p. 48): its minimal sets are finite sets of rationals.
> - The density lemma: Lemma IV.2 (p. 47), a closed invariant set with `0` non-isolated is `K`, applied to `M − M` (p. 48). FS89-D1-L3
>   is its method transposed to `ℚ_v`.
> - The disjointness input: Th. III.1 (p. 35), one map; Prop. IV.1 (p. 45), commutative toral semigroups under (i) and (ii). Its printed
>   conclusion "implies M = K^r" is a misprint for "B = K^r" (lead-in p. 45; proof p. 46). Its corollary "`M − M ≠ K^r` for minimal `M`"
>   is Berend's input to `[Berend1984min]` Prop. 4.1, case 1, and FS89-D1-L4 replaces it at the band.
> - The lacunary side: Th. III.2 with Prop. III.1 (pp. 36, 38); the example `Σ a^{−k²}` (p. 48).
> - The group-flow form of Prop. IV.1 is only announced (p. 45); for `R̂_S` it is `[Berend1984]` Thm I.2 + Prop. II.6.
> - No isometric or rotating direction is treated, and no invariant-measure question is posed.
>
> | held: `pdf/Furstenberg1967-disjointness-ergodic-theory-minimal-sets.pdf` (Kooshi's save, 2026-09-25; a Google scan, 49 pp.) |
> **read:** Parts II–IV in full, with pp. 45, 47, 48, 49 checked against the page image. Part I at headings and statements only. By
> FS-89's prior-art reader, 2026-09-25, `plans/FS89-PA-furstenberg1967.md` |

**Acquisition table row 13:** status "not requested" → "held (Kooshi's save, 2026-09-25); read, see the main row".

## 7. Items for the close inventory (sent to the owner; the owner logs them)

1. **Reading done:** Furstenberg 1967, Parts II–IV in full; the key pages image-checked. The record is this file.
2. **Verdicts** (§3):
   - D1-L3 and D1-T1: **method in print, statement not**.
   - D1-L4 and RQ₄: **not found**.
   - The one-prime failure: **method in print** (the lacunary phenomenon at `r = 1`), **statement not**, with a different mechanism
     (homoclinic here, heteroclinic in S0B).
   - **None of FS-89's statements is in this paper.**
3. **A misprint to carry into every quotation:** Prop. IV.1 prints "implies M = K^r". The lead-in and the proof give `B = K^r`. Berend
   1983 p. 530 silently corrects it, and rewords (i).
4. **Corrections owed to shared files** (§2 table): rows 1, 3, 4 (`BIBLIOGRAPHY.md`); row 7 (`CLAUDE.md` prior-art position: split the
   joint attribution); rows 11, 12, 15, 16 (the plan, if it is edited at all); rows 19–21 (the "not held" notes in S1D and the derivation
   file, and Remark 2's torus-only scope); rows 24, 25, 27 (wording in S1VB, S0B and the Berend record).
5. **A scope fact that supports PA-B2** (the Berend reader's band-free `MS_k`). Furstenberg's toral Prop. IV.1 needs no hyperbolicity, so
   "`M − M` proper" survives isometric directions. The archimedean obstruction sits only in the finite-or-torsion half. §4, **[reading,
   one mind]**.
6. **Prior-art debt closed:** "Furstenberg 1967 not held / not read" in `BIBLIOGRAPHY.md`, the plan's §PA.3, S1D Remark 2 and §6, and
   FS89-D1-L3's entry.
7. **Not this paper** (for whoever attributes them):
   - the invariant-measure ×2×3 problem (inventory item 1's "open ×2×3-type problem");
   - the "Furstenberg correspondence" cited at FS73-T38.

## 8. "Would have searched here" log

- Would have searched for the source of the ×2×3 measure problem, to attribute inventory item 1's phrase. Instead: recorded only that
  this paper does not pose it, since a search for its first statement is outside this brief.
- Would have looked up Gottschalk–Hedlund's volume number. Instead: recorded the entry as printed, with the discrepancy flagged.
- No search for a finite witness was needed or made.

## Theorems this phase proved

None. This is a reading. The one inference of my own is the §4 division-of-labour remark and the note that the printed Prop. IV.1 is
false as literally stated (a one-line counterexample, `B = K^r`). Both are graded **[reading]** and **[hand, one line]** where they
stand.
