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
| Part I | 2–23 | headings and theorem statements only; proofs not read | see §1.1 |
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
