# FS-89 prior-art reading — Berend, *Multi-invariant sets on compact abelian groups* (TAMS 286, 1984)

*Reader: de Bruijn, 2026-09-25, on the owner's brief `data/fs89/briefs/PA-berend1984-reader-brief.md` (commit 0e4c6920). The paper is
D. Berend, Trans. Amer. Math. Soc. 286 (1984), no. 2, 505–535 (received 24 March 1983), held at
`~/source/library/pdf/Berend1984-multi-invariant-sets-compact-abelian-groups.pdf` (31 pages, a scan with an OCR text layer). Every
statement quoted below was read from the page image, not from the OCR layer, which garbles Σ, Ω and the valuations.*

*Read first, from disk: the plan `plans/FS89-rational-band-rigidity.md` §0.1–§0.2 and §PA; `plans/FS89-S1D-derivation.md` §1–§5;
`plans/FS89-S1VB-verification.md` §B1–§B3; `plans/FS89-S0B-band-set.md` §3; `BIBLIOGRAPHY.md` rows `[Berend1983]`, `[Berend1984min]`.*

## 1. Reading log, chapter by chapter

### Front matter and Introduction (pp. 505–506) — read in full

- **Abstract (p. 505), verbatim:** "Let G be a finite-dimensional connected compact abelian group. Generalizing previous results,
  dealing with the case of finite-dimensional tori, a full characterization is given herewith of those commutative semigroups Σ of
  continuous endomorphisms of G which satisfy the following property: The only infinite closed Σ-invariant subset of G is G itself."
- The Introduction quotes Furstenberg's theorem ([5, p. 48]: a non-lacunary semigroup of integers moves an irrational densely mod 1),
  and the torus theorem of [1] (= Berend 1983) with its three conditions, verbatim as in Theorem II.1 below with `T^r` for `Ω_a^r`.
- The plan of the paper (p. 506): the groups are "duals of torsion-free discrete abelian groups of finite rank"; Chapter II the
  `a`-adic multi-solenoid, dual of `ℤ[1/a]^r`, "The main theme of the proof is carrying out the p-adic analogues of considerations
  held in the course of proving the case of T^r employing archimedean valuations"; Chapter III its quotient groups; Chapter IV duals
  of `A^r`, "A being a rank 1 torsion-free group of idempotent type"; Chapter V the general case, as quotients of Chapter IV's.
- MSC 22D40, 54H20; secondary 10F10, 10F45, 28A65. Acknowledges H. Furstenberg.

### Chapter I. Multi-parameter flows (pp. 506–509) — read in full

Sections: **1. Disjointness** (pp. 506–508); **2. Group flows** (pp. 508–509).

- Definitions: a *flow* `(Ω, Σ)` (compact metric space, semigroup of continuous self-maps with unit); homomorphisms, products;
  Definition I.1 *disjoint*; Lemma I.1 (disjointness criterion, "The proof bears no difference relative to the one-parameter case
  [5, Lemma II.1]"); Lemma I.2; Definition I.2 *ergodic* ("every closed Σ-invariant proper subset of Ω is nowhere dense"); Definition
  I.3 *minimal*; **Definition I.4 (ℱ-flow)**, p. 507: a descending sequence of subsemigroups `Σ = Σ^(1) ⊇ Σ^(2) ⊇ ⋯` with (1)
  `(Ω, Σ^(k))` ergodic for every `k`, (2) `Σ/Σ^(k)` "has a finite group structure", (3) "The collection of fixed points of `Σ^(k)`
  becomes dense: `⋃_k {ξ ∈ Ω | Σ^(k)ξ = {ξ}} = Ω`" (closure).
- **Theorem I.1 (p. 508), verbatim:** "Let X = (Ω_X, Σ) be an ℱ-flow and Y = (Ω_Y, Σ) a minimal flow. Then X and Y are disjoint."
- **Definition I.5 (p. 509), verbatim:** "Let (G, Σ) be a group flow. A closed Σ-invariant set A ⊆ G is *restricted* if the only
  closed Σ-invariant set B ⊆ G for which A + B = G is B = G."
- **Theorem I.2 (p. 509), verbatim — the chapter's main theorem:** "If (G, Σ) is a group ℱ-flow, then every minimal set is
  restricted."
- Theorem I.3 (p. 509; cited from [3, p. 76]): "(G, 𝓑, μ, σ) is ergodic iff every nontrivial γ ∈ Γ has an infinite orbit in the dual
  group under the dual endomorphism of σ."
- **What Theorem I.2 is for us.** Take `B = −M`, which is closed and invariant because every element acts by an endomorphism: *in a
  group ℱ-flow, a minimal `M` with `M − M = G` is `G`.* This is the multi-parameter form of Furstenberg's Prop. IV.1, the input the
  derivation agent's D1-T1 Remark 2 marked "[external, not held]". Berend uses it exactly so in Prop. II.7 (below).

### Chapter II. Invariant sets on multi-solenoids of finite type (pp. 509–524) — read in full

Sections: **1. Generalities and the main theorem** (pp. 509–512); **2. The necessity of the conditions** (pp. 512–516);
**3. Sufficiency—sets containing 0 as a nonisolated point** (pp. 516–521); **4. The sufficiency of the conditions** (pp. 521–524).

**§1.** `a = p₁⋯p_h` square-free; `Ω_a` the dual of `ℤ[1/a]`; `ℤ[1/a] → ℝ × ℚ_a`, `s ↦ (s, s)`, a discrete embedding, with
`Ker(π) = {(s, −s)}` (p. 510); `Ω_a^r = (ℝ^r × ℚ_a^r)/ℤ[1/a]^r`; `End(Ω_a^r) = M_r(ℤ[1/a])`, every endomorphism lifting uniquely to
`ℝ^r × ∏_j ℚ_{p_j}^r`, acting diagonally on each factor (pp. 510–511); `p₀ = ∞`, `|·|_j` the `p_j`-adic valuation extended to finite
extensions. Definition II.1 (p. 511): "(Ω_a^r, Σ) is an *ID flow* if the only infinite closed Σ-invariant subset of Ω_a^r is Ω_a^r
itself." Definition II.2 (p. 512): rational (in)dependence, `σ^l = τ^m`.

**Theorem II.1 (p. 512), verbatim — the chapter's main theorem:** "A commutative semigroup Σ of endomorphisms of Ω_a^r is ID if and
only if the following conditions hold:
(1) There exists an endomorphism σ in Σ such that f_{σ^n} is irreducible over Q for every positive integer n.
(2) For every common eigenvector v of Σ there exists an endomorphism σ_v ∈ Σ whose eigenvalue in the direction of Σ is of norm
greater than 1.
(3) Σ contains a pair of rationally independent endomorphisms."

Remark II.1 (p. 512): the common eigenvectors of (2) are the `r(h + 1)` basis vectors diagonalising Σ over finite extensions of the
fields `ℚ_{p_j}`, `0 ≤ j ≤ h` — **the archimedean place `j = 0` included**. So condition (2) is hyperbolicity at every place.

**§2 (necessity).** Lemma II.2 (`m_σ` irreducible), II.3 (simultaneous diagonalisation over the algebraic numbers), II.4
(`[K : ℚ] = r`), Prop. II.1 (condition (1)), Lemma II.5 (diagonal basis with Galois compatibility; "see [1, Lemma 3.4]").
**Proposition II.2 (p. 514), verbatim:** "For every 1 ≤ i ≤ r and 0 ≤ j ≤ h there exists a σ ∈ Σ such that |λ_{i,j,σ}| > 1."
Its proof is the construction that matters for question 4 (§3 below): if every `|λ_{1,j,σ}| ≤ 1`, the projection of
`𝓔_R = ℚ_{p_j}^r ∩ {Σ_{i=1}^{k} α_i v^{i,j} | α_i ∈ K_j, |α_i|_j ≤ R ∀ 1 ≤ i ≤ k}` "on Ω_a^r is a Σ-invariant set in Ω_a^r for any
R > 0. This projection is an infinite closed set and for sufficiently small R > 0 it is properly contained in Ω_a^r."
Lemma II.6 (p. 515): one element (`S(σ)` or `G(σ)`) is never ID — Case I builds a forward orbit, Case II (automorphism) the
two-sided orbit of a point with only expanding components, "infinite and … 0 is its only accumulation point". Prop. II.3
(pp. 515–516, necessity of (3)) via `[D_ℚ(σ) : G(σ)] < ∞` from the S-unit theorem.

**§3 (the heart; p. 516 on), verbatim setting:** "Σ is a commutative semigroup of endomorphism of Ω_a^r satisfying the conditions of
Theorem II.1. E is a closed Σ-invariant subset of Ω_a^r which contains 0 as a nonisolated point. We want to show that E = Ω_a^r."
The steps, each read:
- p. 517: the new (eigen)basis `v^{i,j}` of `∏_j K_j^r`; `V_A` the span of the coordinates in a set `A` of pairs `(i, j)`; the
  Σ-invariant subspaces are exactly the `V_A`. "Let M be a minimal set of pairs (i, j) such that V_M contains such a sequence
  [a null sequence of nonzero points of Ẽ]."
- **Lemma II.7 (p. 517), verbatim:** "Let σ ∈ Σ. Then either |λ_{i,j,σ}| > 1 for all (i, j) ∈ M or |λ_{i,j,σ}| ≤ 1 for all
  (i, j) ∈ M." Proof: if σ expands `M₁` and has `|λ| ≤ 1` on `M₂ = M ∖ M₁`, iterate σ on the null sequence until the size first
  reaches `a`; a limit point is "a nonzero point of Ẽ lying in V_{M₁}"; letting `a → 0` gives a null sequence in `V_{M₁}`,
  contradicting minimality. **Note the non-strict `≤ 1` on `M₂`: the argument needs no contraction there.**
- "(9) |λ_{i,j,σ}| > 1, (i, j) ∈ M" for some σ, from Lemma II.7 **and condition (2)** (p. 517).
- Lemma II.8 (p. 518): a point `u^(0) ∈ Ẽ ∩ V_M`, all coordinates nonzero, with `σ̃^{−n}u^(0)` a null sequence in Ẽ.
- Lemma II.9 (p. 518): for σ, τ ∈ Σ the ratios `log|λ_{i,j,τ}|/log|λ_{i,j,σ}|` are one constant `α` on `M`.
- **Lemma II.10 (p. 518), verbatim:** "There exist some 0 ≤ s ≤ h and elements ξ_i ∈ K_s for i ∈ M_s, not all of which are 0, such
  that for every t ∈ ℤ_s the vector w^(t) = u^(0) + Σ_{i∈M_s} (exp(ξ_i t) − 1)u^{(0)}_{i,s} e^{i,s} lies in Ẽ, where u^(0) is as in
  (10)." Proof (pp. 518–519): two rationally independent σ, τ satisfying (9); for irrational `α` the toral proof [1, Lemma 4.5];
  for rational `α`, powers make `α = 1`, and `w^(k) = τ̃^k(u^(k)) = Σ ρ^k_{i,j} u^{(0)}_{i,j} e^{i,j}` with `ρ_{i,j} = λ_{i,j,τ}λ^{−1}_{i,j,σ}`
  **a unit** in `K_j`; after a power `ρ ∈ U_{j,[e_j/(p_j−1)]+1}`, `θ = log ρ`, and "the closure of {(kθ_{i,j})} … is a subgroup, which
  is infinite since σ and τ are rationally independent", containing "a subgroup of the form {0} × ⋯ × H_s × ⋯ × {0}, where H_s is …
  of the form ℤ_p ξ".
- **Lemma II.11 (p. 519), verbatim:** "For every ε > 0 the set Ẽ forms an ε-net for arbitrarily long line segments in V_M." (A *line
  segment* is `a + {0} × ⋯ × ℤ_{p_s}b × ⋯ × {0}`; for `s = 0` the toral proof [1, Lemma 4.6]; for `s ≥ 1` a `p`-adic `exp`
  estimate (18) and the expanding σ, pp. 519–520.)
- **Proposition II.4 (p. 520), verbatim:** "E contains a translate of some infinite closed ℤ[1/a]-submodule of Ω_a^r." (Hausdorff
  limit of the segments, p. 521.)
- Lemma II.12 (p. 521, from [1, Lemma 4.7]): `G_m → G` in the Hausdorff metric iff every `γ ≠ 0` leaves the annihilators eventually.
- **Proposition II.5 (p. 521), verbatim:** "Let σ be an endomorphism of Ω_a^r with f_{σ^n} irreducible over Q for every positive
  integer n and H an infinite closed ℤ[1/a]-submodule of Ω_a^r. Then σ^m(H) → Ω_a^r as m → ∞." (Proof via a linear recurrence, "[2,
  p. 302, Problem 9]", i.e. Borevich–Shafarevich's exercise on zeros of linear recurrences, a Skolem–Mahler–Lech-type fact.)
- Conclusion (p. 521): "The conditions of Theorem II.1 were thus shown to imply that a closed Σ-invariant subset of Ω_a^r which
  contains 0 as a nonisolated point is necessarily Ω_a^r itself."

**§4 (pp. 521–524).** Lemma II.13 (`Ω_a^r[l]` finite), II.14 (kernels of epimorphisms finite), **II.15 (p. 522): "Let σ be an ergodic
endomorphism of Ω_a^r. A finite σ-invariant set consists only of torsion elements."**, II.16 (`q`-power torsion dense for `q ∤ a`), II.17
(a finitely generated subsemigroup keeping the conditions).
- **Proposition II.6 (p. 523), verbatim:** "Let Σ be an arbitrary semigroup of endomorphisms of Ω_a^r. Suppose that: (1) There exists
  some ergodic σ ∈ Σ. (2) There exists a prime q not dividing a such that det σ is a q-adic unit for every σ ∈ Σ. Then (Ω_a^r, Σ) is an
  ℱ-flow." Berend: "It generalizes Proposition IV.1 of [5] in two respects. First, it relates to semigroups of endomorphisms of Ω_a^r
  instead of T^r and, secondly, it drops the commutativity assumption." **No hyperbolicity and no multi-parameter hypothesis.**
- **Proposition II.7 (p. 523), verbatim:** "Let M be a Σ-minimal set. M is a finite set of torsion elements." Proof, verbatim: "By
  Lemma II.17, Σ may be assumed to be finitely generated. Hence Σ satisfies the conditions of Proposition II.6. Suppose M is infinite.
  Then M − M is a closed Σ-invariant set containing 0 as a nonisolated point. The results of §3 imply M − M = Ω_a^r. Since (Ω_a^r, Σ)
  is an ℱ-flow it follows from Theorem I.2 that M = Ω_a^r. The contradiction proves the proposition."
- The end of the proof of Theorem II.1 (p. 523): an infinite closed invariant `E` has an accumulation-point set containing a torsion
  point (Prop. II.7), so `lE` contains 0 non-isolated, so `lE = Ω`, so `E` has interior, so `E = Ω` by ergodicity.
- Remark II.2; **Theorem II.2 (p. 524)**: an ID semigroup contains an ID subsemigroup on at most `max{2, r(h + 1)}` generators.
</content>
</invoke>
<invoke name="Bash">
<parameter name="command">cd /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-pa-berend/; sed -n 1005,1256p berend.txt
### Chapter III. Quotient groups of multi-solenoids of finite rank (pp. 524–529) — read in full

Sections: **1. Generalities and the main theorem** (pp. 524–525); **2. The necessity of the conditions** (pp. 525–526); **3. The
sufficiency of the conditions** (pp. 526–527); then Remark III.1, Example III.1, Theorems III.2–III.3 (pp. 528–529).

- Setting (p. 524): `G = Ω_a^r/H`, `ℤ^r ⊆ Â ⊆ ℤ[1/a]^r`, `H = ∏_j H_j` with `H_j` a closed subgroup of `ℤ_{p_j}^r`, lifted into
  `{0} × ℤ_a^r`; every endomorphism lifts to `Ω_a^r` and to `ℝ^r × ℚ_a^r`. `V_j` = the `ℚ_{p_j}`-span of `H_j`; p. 525 proves every
  eigenvalue of `σ|V_j` has norm ≤ 1 (else the compact `H_j` would carry an unbounded orbit).
- **Theorem III.1 (p. 525), verbatim — the chapter's main theorem:** "A commutative semigroup Σ of endomorphisms of Ω_a^r/H is an ID
  semigroup iff the following conditions are satisfied: (1) There exists some σ ∈ Σ such that f_{σ^n} is irreducible over Q for every
  n ∈ N. (2) For every common eigenvector v of Σ, which is not an eigenvector of the restriction of Σ to ∏_{j=1}^{h} V_j, there exists
  some σ_v ∈ Σ whose eigenvalue in the direction of v is of norm greater than unity. (3) Σ contains a pair of rationally independent
  endomorphisms."
  **This is the paper's one theorem with hyperbolicity relaxed on some directions** — "rigidity modulo a compact factor" in the most
  literal sense: the unexpanded directions are `p`-adic directions inside the compact subgroup `H` that the quotient kills. The
  archimedean place (`j = 0`) is never relaxed: `V_j` is defined only for `j ≥ 1`.
- Props III.1–III.3 (necessity), with Prop. III.2 reusing Prop. II.2's set `𝓔_R`.
- **Proposition III.4 (p. 527), verbatim:** "Let E be a closed Σ-invariant subset of Ω_a^r/H containing 0 as a nonisolated point.
  Then E = Ω_a^r/H." **Its proof ends, verbatim:** "Thus, the lifting of E to ∏_{j=0}^{h} Q_{p_j}^r contains a nontrivial null
  sequence of points lying in a Σ-invariant subspace V of ∏_{j=0}^{h} Q_{p_j}^r having the following property: For every common
  eigenvector of the restriction of Σ to V there exists some σ ∈ Σ with its corresponding eigenvalue of norm greater than unity.
  Examining the sufficiency part of the proof of Theorem II.1 we observe that this information guarantees that the lifting of E to
  Ω_a^r is Ω_a^r itself, and hence E = Ω_a^r/H."
  **This sentence is D1-L3's principle in Berend's words** (§3 below): Chapter II §3 uses hyperbolicity only along an invariant
  subspace that carries a null sequence of `E`. The null sequence is put into `V` by discarding its `S`-components, which lie in `H`
  (the quotient makes them zero), not by any dynamics.
- Lemmas III.1–III.5 (p. 527) as in Chapter II; the proof of sufficiency "is now carried out as in the case of Ω_a^r. It is easy to see
  that (Ω_a^r/H, Σ) may be assumed to be an ℱ-flow. Then we show that a Σ-minimal set is necessarily a finite set of torsion elements."
- Remark III.1, Example III.1 (p. 528): ID semigroups on `Ω_a^r/H` are rare (`T × Ω₂` admits none). Theorem III.2 (p. 528): "Let G be
  a connected compact abelian group. If G is not homogeneous, then there exist no ID semigroups of endomorphisms on G." Theorem III.3
  (p. 529): a small ID subsemigroup, `max{2, r(h + 1) − d(H)}` generators.

### Chapter IV. Multi-solenoids of arbitrary type (pp. 529–532) — read in full

Sections: **1. Generalities and the main theorem** (pp. 529–530); **2. The proof of the theorem** (pp. 530–532).

- Setting (p. 529): `P = {p₀ = ∞, p₁, p₂, …}`, `Ω_P` the dual of `ℤ[1/P]`, a quotient of the restricted product
  `∏′_{p∈P} ℚ_p = ℝ × ∏′_{j≥1} ℚ_{p_j}` by the diagonal `ℤ[1/P]` (self-dual, [7, 25.34.b]); also the inverse limit of the
  finite-type `Ω_a` over products `a` of primes of `P`. Endomorphisms of `Ω_P^r` are `r × r` matrices over `ℤ[1/P]`.
- **Theorem IV.1 (p. 530), verbatim — the chapter's main theorem:** "A commutative semigroup of endomorphisms of Ω_P^r is ID iff it
  satisfies the three conditions stated in Theorem II.1."
- Remark IV.1 (p. 530), verbatim in part: "The second condition of the theorem relates, in the case of infinite P, to infinitely many
  eigenvectors … The third condition of the theorem follows in this case from the second one. In fact, this is valid since for every
  endomorphism σ all the eigenvalues λ_{1,σ}, …, λ_{r,σ} are units in K_p for almost all p."
- The proof (pp. 530–531) does not split into two parts: it projects `E` to quotients of the finite-type groups and applies Theorem
  III.1 there. Lemma IV.1 (`Ω_P^r[l]` finite); **Lemma IV.2 (p. 530), verbatim:** "Let a and b be positive integers with a|b and let
  π: Ω_b^r → Ω_a^r denote the natural projection. If x ∈ Ω_b^r is a torsion element then π(x) ∈ Ω_a^r is a torsion element whose order
  is the same as that of x." **Proposition IV.1 (p. 531):** "There exists an a such that π_a(E) is infinite." (Its proof: if `π_a(E)`
  is finite it lies in `Ω_a^r[l]`; Lemma IV.2 and the inverse limit give `E ⊆ Ω_P^r[l]`, which is finite.) **Proposition IV.2
  (p. 531):** "For every product a of primes in P, π_a(E) = Ω_a^r." — by a finitely generated `Σ₀` hyperbolic at the places of `a`,
  and Theorem III.1 on `Ω_b^r/∏_{j>h} H′_j`, where `H′_j` quotients out, at the extra primes of `b`, the directions `Σ₀` does not
  expand.
- Remark IV.2 (pp. 531–532): "in the infinite type case no finitely generated semigroup (commutative or not) is ID."

### Chapter V. Finite-dimensional connected compact abelian groups (pp. 532–535) — read in full

Sections: **1. Generalities and the main theorem** (pp. 532–533); **2. The proof of the theorem** (pp. 533–535).

- Setting (p. 532): `G = Ω_P^r/H`, `ℤ^r ⊆ Ĝ ⊆ ℤ[1/P]^r`; `H = ∏_{j≥1} H_j`; `V_j` the span of `H_j` for `j ≥ 1` and **`V₀ = {0}`**;
  `H̲_j := V_j ∩ ℤ_{p_j}^r`.
- **Theorem V.1 (p. 533), verbatim — "the main result of the whole paper":** "A commutative semigroup Σ of endomorphisms of Ω_P^r/H is
  ID iff the following conditions hold: (1) H̲_j = H_j for almost every j. (2) There exists a σ ∈ Σ such that f_{σ^n} is irreducible
  over Q for every n ∈ N. (3) For every j ≥ 0 and every common eigenvector v of the semigroup Σ of linear transformations of
  Q_{p_j}^r, which is not an eigenvector of the restriction of Σ to V_j, there exists an endomorphism σ_v ∈ Σ whose eigenvalue in the
  direction of v is of norm greater than unity. (4) Σ contains a pair of rationally independent endomorphisms."
  With `V₀ = {0}`, **the archimedean place is never exempted from hyperbolicity** anywhere in the paper.
- Remark V.1; Lemmas V.1–V.2; Prop. V.1 (some `π_a(E)` infinite); the end "analogous to that of the case of Ω_P" (p. 534). Remark
  V.2 (p. 534): with infinite `P`, finitely generated ID semigroups exist only on groups isomorphic to finite-type quotients; the
  condition `H̲_j = H_j` is equivalent to divisibility of `Γ_j = Γ ∩ ℤ[1/p_j]^r/ℤ^r` (stated without proof).
- Example V.1 (pp. 534–535; rationals with square-free denominator: no ID semigroup) and **Theorem V.2 (p. 535), verbatim:** "Let G be a
  connected compact abelian group and let Γ = Ĝ. A necessary condition for the existence of ID semigroups of endomorphisms on G is that Γ
  be a homogeneous group of idempotent type."

### References (p. 535) — read; mined in §7 below

## 2. Question 2 — does the framework cover our action?

**Our object in Berend's coordinates.** For finite `S`, `R_S = ℤ[i][1/a]` with `a = ∏_{p∈S} p`, and as a group `R_S = ℤ[1/a] ⊕ ℤ[1/a]·i ≅
ℤ[1/a]²`. So `R̂_S = Ω_a^2` (Chapter II, `r = 2`, `h = |S|`), and Berend's `ℝ² × ∏_{p|a} ℚ_p²` is our `ℂ × ∏_{v|S} ℚ(i)_v`: every
`p ∈ S` splits in `ℚ(i)`, so `K_j = ℚ_p` and the two eigen-coordinates at `p_j` are exactly our two places `π_p`, `π̄_p`. Multiplication
by `u ∈ U_S` is a matrix in `M_2(ℤ[1/a])` with eigenvalues `u`, `ū`; its dual is our `θ ↦ θ∘u`. `Q = ℤ[i][1/p : p ≡ 1 (4)] ≅ ℤ[1/P]²`
with `P = {∞} ∪ {p ≡ 1 (mod 4)}`: Chapter IV's `Ω_P^2` (`ℤ[1/P]` is rank one of idempotent type, so Theorem V.2's necessary condition
holds). Berend's semigroups may be groups (Lemma II.6 (2) treats `G(σ)`); ours is a commutative group of automorphisms.

| Berend's hypothesis | our action `U_S` on `R̂_S` (and `U_ℚ` on `Q̂`) | met? |
|---|---|---|
| Thm II.1 (1): some σ with `f_{σ^n}` irreducible over ℚ for all `n` | `σ = w_p`: `f = x² − (2Re w_p)x + 1`; `w_p^n ∉ ℚ` since `|w_p^n| = 1` and `w_p` is not a root of unity | **met**, at every `S ≠ ∅` |
| Thm II.1 (2), hyperbolicity: every common eigenvector expanded by some element, **the archimedean place included** (Remark II.1) | at `p ∈ S`: eigenvalues `ι(u), ι(ū)` of `u = w_p` have `p`-adic norms `p^{−1}` and `p` (the `π_p` and `π̄_p` coordinates), so `w_p` and `w_p^{−1}` expand the two coordinates; this is our `|w_p|_v = p^{∓1}`, and Berend's "norm greater than 1" is the same normalisation. At `∞`: every `u ∈ U_S` has eigenvalues `u, ū` of modulus 1 | **fails at the archimedean place only** — as expected |
| Thm II.1 (3), multi-parameter: two rationally independent elements | `w_p, w_q` (`p ≠ q`) are independent (ideal factorisation). At `|S| = 1` every pair in `⟨i⟩ × ⟨w_p⟩` is dependent (`σ^{4d} = τ^{4b}`) | **met iff `|S| ≥ 2`** — D1-L3's hypothesis is exactly this condition |
| Thm IV.1 (Q, infinite type) | (1) and (3) met; (2) met at every finite prime, fails at `∞`; Remark IV.1: (3) follows from (2) there | fails at `∞` only |
| Prop. II.6 (ℱ-flow): an ergodic element, and a prime `q ∤ a` with every `det σ` a `q`-adic unit | `w_p` is ergodic by Theorem I.3 (`γw_p^n` distinct for `γ ≠ 0`, `R_S` a domain); `det(u) = N(u) = uū = 1` | **met, at every `S`** — no hyperbolicity needed |

**Consequence.** The ID theorem (II.1, IV.1) does not apply, and its conclusion is false for us (`Θ₄` is an infinite closed proper
invariant set). But three of the paper's results are hypothesis-free enough to apply verbatim: **Prop. II.6** (our flow is an ℱ-flow),
**Theorem I.2** (so every minimal set is restricted), and **Lemmas II.14–II.15** (finite kernels; finite invariant sets of an ergodic
element are torsion). And §3's method applies wherever its null sequence lives in the `S`-adic coordinates (§4 below).

## 3. Question 4 — does the paper treat a non-hyperbolic direction?

**No theorem or remark in this paper states rigidity modulo an isometric (archimedean) direction.** What it has, in order of closeness:
1. **Prop. III.4's closing observation, p. 527** (quoted in §1, Chapter III): §3's argument uses hyperbolicity only along the invariant
   subspace carrying the null sequence. This is the principle behind D1-L3; Berend states it for a Chapter III quotient, where the
   non-expanded directions are `p`-adic and killed by `H`.
2. **Theorem III.1 (p. 525) and Theorem V.1 (p. 533)**: hyperbolicity is exempted on the directions spanned by the compact subgroup `H`
   — "rigidity modulo a compact factor", achieved by *quotienting*. **With `V₀ = {0}` (p. 532) the archimedean place is never exempt**,
   and it cannot be treated this way: our `A` is dense in `R̂_S`, not a closed subgroup, so there is no quotient to pass to.
3. **Prop. II.2's proof (p. 514)**: a non-expanded eigen-direction carries the infinite closed invariant proper set `𝓔_R` of bounded
   coefficients. At our archimedean place `𝓔_R` is the closed leaf disc `{λ_e : |e| ≤ R′}` about `τ = 0`: the leaves' existence, in
   print as a *necessity* argument, as a disc (invariant) not a circle (minimal). The circles' minimality is `[Berend1984min]` Lemma 3.1,
   not this paper.
4. **In the 1983 companion, Example 4.3 (p. 525), verbatim:** "As another example, let Σ be generated by σ = (5 0; 0 5) and τ = (3 −4;
   4 3). We have λ_{1,τ} = 3 + 4i and λ_{2,τ} = 3 − 4i, so that the eigenvalues of both σ and τ are of modulus 5. Here, the resulting
   subset of C contains 0 as a nonisolated point and is invariant under multiplication by 5 and by 3 + 4i. Such a set is not necessarily
   C itself. The union of all circles, whose centers are at the origin and whose radii are of the form 5^k, k an arbitrary integer, is an
   example of a set having these properties." **The ratio τσ^{−1} is our `w₅ = (3 + 4i)/5`**: Berend meets our archimedean rotation in
   1982, as an isometric ratio of two expanding elements that makes Lemma 4.5's arc a circle rather than a spiral. The torus there is
   still ID (both elements expand), so it is a remark about an intermediate reduction, not a rigidity-modulo statement.

## 4. Question 3 — verdicts

| statement | verdict | theorem and page | note |
|---|---|---|---|
| **D1-L2** (case 2 ⟹ `M ∩ (T + A) ≠ ∅`; minimal ⟹ `M ⊆ T + A`, a finite union of circles) | **method in print, statement not** | Lemmas II.14–II.15 (p. 522); 1983 Lemmas 5.1–5.2 (p. 529) | Berend's finiteness step: `x ∈ Ker(σ^m − σ^n)`, an epimorphism with finite kernel, so `x` is torsion. D1-L2 step 2 is this with the kernel taken **modulo `A`** (`y = x − λ_{v/c̄}` killed by `c = w_p^n − 1`), which is not in the paper. In the hyperbolic setting, case 2 is "0 isolated in `M − M`", which Prop. II.7's proof (p. 523) turns into "M finite" in one clause. The circle description is not in this paper (`[Berend1984min]` Lemma 3.1) |
| **D1-L3** (case 1 ⟹ `M − M = G`, `|S| ≥ 2`) | **method in print, statement not** (the nearest printed sentence is an in-proof observation) | §II.3: Lemma II.7 (p. 517), Lemmas II.8–II.11 in the `p`-adic branch `s ≥ 1` (pp. 518–520), Prop. II.4 (p. 520); the principle in words in Prop. III.4's proof (p. 527) | Step for step: D1-L3's step 1 (the pure `v`-adic element; V-B's Lemma E) is **Lemma II.7's construction**, which needs only `|λ| ≤ 1` off the expanded coordinate, so a rotated archimedean component is harmless; steps 2–4 (`closure⟨i, w_q⟩` open, `D ⊇` a translate of `K_{R−a}`) are **Lemma II.10's `p`-adic arc** `u^(0) + (exp(ξt) − 1)u^(0)`, `t ∈ ℤ_p`, from two rationally independent elements with `α = 1` and the unit ratio `ρ = w_q` at `v`; step 5 (density) is Lemma II.11 + Prop. II.4, with Prop. II.5 replaced by the density of the image of `K_v` (strong approximation, or V-B's annihilator — Berend's Lemma II.12 is the same annihilator criterion). Basing at `0` via `M − M` (V-B's B2 disclosure) is Berend's Prop. II.7 and 1983 Prop. 5.1. `|S| ≥ 2` is Thm II.1 (3). **What is not in print:** the statement with a non-hyperbolic archimedean direction present; the paper never has one |
| **D1-T1** (`MS₄(S)`, `|S| ≥ 2`) | **method in print, statement not** | Prop. II.7 (p. 523); 1983 Prop. 5.1 (pp. 530–531) | Same two-case skeleton (minimal `M` infinite ⟹ `M − M` has 0 non-isolated ⟹ `M − M = G` ⟹ contradiction). Prop. II.7's conclusion ("finite set of torsion elements") is false for our action (leaf circles); no modulo-`A` form in the paper. **The paper supplies one step verbatim:** Theorem I.2 (p. 509) with Prop. II.6 (p. 523) gives "`M − M = G` ⟹ `M = G`" for our action, a band-free replacement for D1-L4 (§5) |
| **RS₄(S)**, every `|S| ≥ 2` (S1VB-14) | **not found in this paper** | — | The point-level step (VB1) has no analogue: Berend's point step is the `lE` argument at the end of Thm II.1's proof (p. 523), which needs no continuous part. VB1's Lemma JC (joint closure of `(w̄^{bn}, w^{bn}|_v)` in `S¹ × O_v^×`) is the device of Lemma II.10's proof (closure of `{kθ}` in `T^{m₀} × ∏ R_j^{m_j}`, p. 519); the band sweep SW is ours |
| **RQ₄**, **RQ₅** | **not found in this paper** | — | No band, no `T + A`. The finite-to-infinite-type passage (Chapter IV, Lemma IV.2 and Prop. IV.1, pp. 530–531: projections preserve torsion orders, and a bounded order lifts through the inverse limit) is a **method analogue** of D2-L1/VB4's bounded-order layering; the archimedean alignment on `R ∩ uR` is not in the paper |
| **One-prime failure** (S0B-T3–T5: non-torsion closed invariant sets inside `Θ₄(R₅)`) | **not found as stated; the phenomenon's method in print** | Lemma II.6 (p. 515) and Prop. II.3 (pp. 515–516); 1983 Lemma 3.6 and Prop. 3.2 (pp. 518–520) | Berend: a one-parameter group is never ID — Case II builds a two-sided orbit "infinite and … 0 is its only accumulation point" (a **homoclinic** orbit), and Prop. II.3 extends it to `D(σ) = ⋃ G(σ)α_i`, of which `⟨i⟩ × ⟨w₅⟩` is one. S0B's points are **heteroclinic** between two torsion leaves, and inside a band set: not in the paper. (Our rank-one action also fails (2), so Prop. II.2's disc exists there too) |

**In one line:** nothing of FS-89's is in this paper as a statement; its method is, almost entirely — D1-L3 above all, whose `p`-adic
content is Chapter II §3 written out, and whose governing principle Berend states in words on p. 527.

## 5. What the paper hands over: the band-free minimal-set theorem, and a widening to route to a verifier

**(a) In print and applicable verbatim [hand check of hypotheses, mine]:** by Prop. II.6 (p. 523) `(R̂_S, U_S)` is an ℱ-flow for every
finite `S` (§2's table), so by Theorem I.2 (p. 509) every minimal set is restricted; with `B = −M`, **a minimal `M` with `M − M = R̂_S` is
`R̂_S`.** This is the input D1-T1's Remark 2 called "Furstenberg's Prop. IV.1 (`M − M ≠ G` for minimal `M ≠ G`) [external, not held]". It
is held now, in its multi-parameter solenoid form (and in its toral form as quoted in the 1983 paper, p. 530, "Proposition [1, p. 45]").

**(b) The consequence D's Remark 2 anticipated [hand, one mind, mine; resting on D1-L2 and D1-L3, each verified twice]:** for every finite
`S` with `|S| ≥ 2`, **every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A`** — case 2 by D1-L2; case 1 gives `M − M = R̂_S` by D1-L3, hence
`M = R̂_S` by (a). No band enters. So `MS_k(S)` holds at every band `k` and every `|S| ≥ 2`, and D1-L4 and D5-L1 are not needed for it.

**(c) A widening, unverified [hand, one mind, mine; NOT checked by anyone else — for the owner to route]:** V-B's VB1 uses the band only in
Lemma SW, which needs a full coset of `(1/p)ℤ/ℤ` to meet the open arc `(−1/k, 1/k)`, i.e. `k < 2p` for the prime `p` under the expanded
place. With (b) in place of D1-L4/D5-L1, VB2 gives `RS_k(S)` for every `|S| ≥ 2` and every `k < 2·min S`, and VB3–VB4 carry it to `Q`: at
`S = {5, 13}`, **`RQ_k` for every `k ≤ 9`** (and `RS₅(S)` without `5 ∈ S`). If it holds, it moves FS-89's five-colour result to six
through nine colours for character colourings. Points to check: that VB1–VB4 use `k` nowhere but SW (I read them for this and found no
other use); Prop. II.6's hypotheses as checked in §2; and that `Θ_k ≠ R̂_S` (true: `0 ∉ Θ_k`). **Not claimed here;** reported to the owner.

## 6. Question 6 — the companion, Berend 1983 (TAMS 280, 509–532), now held and read

Held since this reading as `~/source/library/pdf/Berend1983-multi-invariant-sets-on-tori.pdf` (Kooshi's browser save, 24 pages, OCR
text layer; received by the editors 24 May 1982). Read status per section:

| section | pages | read | what it holds for FS-89 |
|---|---|---|---|
| 1. Introduction | 509–510 | in full | Furstenberg's two-stage proof: (1) 0 non-isolated ⟹ whole group, (2) disjointness for arbitrary sets |
| 2. The main theorem | 511 | in full | **Theorem 2.1** (the toral ID theorem, conditions (1)–(3) as in the 1984 Theorem II.1); Definition 2.1 (ID: "infinite invariant is dense") |
| 3. The necessity of the conditions | 511–520 | in full (Prop. 3.1's ideal-theoretic proof at reading speed) | Lemma 3.5 (p. 517), Case II: a non-expanded complex eigen-direction carries "the projection of an ellipse (its interior included) {z v^(1) + z̄ v^(2) : z ∈ C, |z| ≤ a}" — the toral form of 1984's `𝓔_R` and of our leaf disc about 0. Lemma 3.6 (p. 518): one element is never ID (homoclinic Case II). Prop. 3.2: necessity of (3) |
| **4. Sufficiency—sets with 0 as a nonisolated point, "from (4.1) on"** | 520–529 | **in full**; pp. 521 and 525 checked against the page image | The step `[Berend1984min]` Prop. 4.1's case 1 cites. Lemma 4.2 (p. 521; the `≤ 1` form, verified on the image) — 1984's Lemma II.7; **(4.1)** `|λ_{i,σ}| > 1` on `V_k`; Lemma 4.3 (null sequence `σ̃^{−n}u^(0)`); Lemma 4.4 (constant log ratio); **Lemma 4.5 (p. 524): the arc from rational independence** — "elliptical in case l₀ = 0 and spiral in case l₀ > 0"; Example 4.3 (p. 525; the `w₅` remark, §3 item 4); Lemma 4.6 and Props. 4.1–4.2 (ε-nets for long segments; a translate of an infinite closed subgroup); Lemma 4.7 (Hausdorff convergence by annihilators); Prop. 4.3 (van der Waerden and irreducibility: `σ^{m_i}(H) → T^r`). **All archimedean**: the torus has no `p`-adic coordinate. D1-L3 replaces this step by its `p`-adic analogue, which is 1984 §II.3 (the `s ≥ 1` branch), not this section |
| 5. The sufficiency of the conditions | 529–531 | in full | Lemmas 5.1–5.2 (finite kernels; finite invariant sets torsion) — D1-L2's method; Lemma 5.3; **"Proposition [1, p. 45]" (p. 530), verbatim:** "Let Σ denote a commutative semigroup of endomorphisms of T^r. We assume (i) that there exists some ergodic endomorphism σ in Σ, and (ii) that there exists a prime q with the property that all det σ, σ ∈ Σ, are relatively prime to q. Then if M and B are closed Σ-invariant subsets of T^r and M is minimal with respect to these properties, M + B = T^r implies B = T^r." — Furstenberg's Prop. IV.1 in the form D's Remark 2 wanted; **Prop. 5.1 (p. 530): "Let M be a Σ-minimal subset of T^r. Then M is necessarily a finite set of torsion elements."** — the toral D1-T1 skeleton |
| 6. Remarks | 531–532 | in full | Theorem 6.1 (≤ max{2, r} generators); decidability remarks; Example 6.1 |
| References | 532 | read | five entries, §7 |

**Where the 1984 paper leans on 1983 for anything in question 3.** For D1-L3 it does not: the `p`-adic branch it needs is written out in
1984 §II.3; it defers to 1983 only for the archimedean branches (Lemma 4.5 for irrational `α`, Lemma 4.6 for `s = 0`, p. 518–519) and
for Lemma 4.7 (= II.12), none of which D1-L3 uses (its null sequence is at one `p`-adic place, `α = 1`). For D1-L2 it cites nothing (II.14
and II.15 are proved there). For the structure of D1-T1 it cites 1983's Lemma 5.3 (finitely generated subsemigroup), not needed at finite
`S`. **No second browser save is needed; the one made closes the debt.**

## 7. Question 5 — the reference lists, mined

**1984 (p. 535), eleven entries:**

| # | entry | bears? |
|---|---|---|
| 1 | D. Berend, *Multi-invariant sets on tori*, TAMS 280 (1983) 509–532 | **yes** — the companion; §6 |
| 2 | Z. I. Borevich, I. R. Shafarevich, *Number theory*, Academic Press 1966 | no — "[2, p. 302, Problem 9]", the recurrence-zero fact in Prop. II.5; D1-L3 does not use Prop. II.5 |
| 3 | J. R. Brown, *Ergodic theory and topological dynamics*, Academic Press 1976 | no — Theorem I.3's ergodicity criterion (standard) |
| 4 | L. Fuchs, *Infinite abelian groups* II, Academic Press 1973 | no — types (Chapter III–V) |
| 5 | H. Furstenberg, *Disjointness in ergodic theory, minimal sets, and a problem in diophantine approximation*, Math. Systems Theory 1 (1967) 1–49 | **yes** — `[Furstenberg1967]`, the home theorem; its Prop. IV.1 is now available held, as 1984 Thm I.2 + Prop. II.6 and 1983 p. 530 |
| 6 | H. Furstenberg, *Intersections of Cantor sets and transversality of semigroups*, in *Problems in Analysis* (Gunning, ed.), Princeton 1970, 41–59 | no, by title and by Berend's use (Diophantine connections) — not held; the one entry of the list on a different question (transversality), not on invariant sets modulo a factor |
| 7 | E. Hewitt, K. A. Ross, *Abstract harmonic analysis* I, Springer 1963 | no — solenoids (§10), local direct products, self-duality (25.34) |
| 8 | N. Jacobson, *Lectures in abstract algebra* II, Van Nostrand 1953 | no |
| 9 | K. Mahler, *Introduction to p-adic numbers and their functions*, CUP 1973 | no — `p`-adic basics |
| 10 | W. Narkiewicz, *Elementary and analytic theory of algebraic numbers*, PWN 1974 | no — `p`-adic exp/log (Lemma II.10), `S`-unit theorem |
| 11 | B. L. van der Waerden, *Modern algebra* II, Ungar 1950 | no — elementary divisors |

**1983 (p. 532), five entries:** Furstenberg 1967 (yes, as above); Khinchin, *Three pearls of number theory* (van der Waerden's theorem,
Prop. 4.3; no); Narkiewicz 1974 (no); K. B. Stolarsky, *Algebraic numbers and diophantine approximations*, Dekker 1974 (effective unit
theorem, §6; no); van der Waerden, *Modern algebra* I (no).

**"Modulo a compact factor" — flagged:** no entry of either list can hold it; both lists are textbooks plus Furstenberg. The only
printed forms are Berend's own (1984 Thms III.1/V.1 by quotient; 1983 Example 4.3; `[Berend1984min]` Lemma 3.1 and Remark 2.1). Beyond
these lists, the candidates are later works citing Berend (the plan's §PA query 24): Starkov 1999 (minimal sets of algebraic actions on
a torus), Urban 2007/2008/2014 (`S`-adic duals), Maucourant 2010 — unread; I name them, I did not open them.

## 8. Proposed bibliography rows (for the close planner; NOT written into `BIBLIOGRAPHY.md`)

The present combined row (`BIBLIOGRAPHY.md` line 303, `[Berend1983]` "Also **[Berend1984]**") should be split in two, and the file table
gains two rows.

**`[Berend1983]`** | D. Berend, *Multi-invariant sets on tori*, Trans. Amer. Math. Soc. 280 (1983), no. 2, 509–532; doi
10.1090/s0002-9947-1983-0716835-6; zbMATH 0532.10028 (reviewer's review, V. Losert) | **FS-81's §IQ recognition (the toral ID theorem,
Thm 2.1, and why it fails at isometric archimedean places) and FS-89's**: §4 "from (4.1) on" is the archimedean step `[Berend1984min]`
Prop. 4.1's case 1 cites (arc from rational independence, Lemma 4.5; ε-nets and a translate of a subgroup, Props. 4.1–4.2); Lemma 3.5
Case II is the toral leaf disc; **Example 4.3 (p. 525) meets `w₅ = (3+4i)/5` as an isometric ratio and names the circles of radii `5^k`**;
Lemmas 5.1–5.2 are D1-L2's finiteness method; p. 530 quotes Furstenberg's Prop. IV.1 in the form FS-89 D1-T1 Remark 2 needed | `pdf/Berend1983-multi-invariant-sets-on-tori.pdf` (Kooshi's browser save, 2026-09-25) | **read in full** (2026-09-25, FS-89's prior-art reader, `plans/FS89-PA-berend1984.md` §6; OCR layer, pp. 521 and 525 checked against the page image)

**`[Berend1984]`** | D. Berend, *Multi-invariant sets on compact abelian groups*, Trans. Amer. Math. Soc. 286 (1984), no. 2, 505–535; doi
10.1090/s0002-9947-1984-0760973-x; zbMATH 0523.22004 (no review) | **FS-89's nearest theorem in print, read: none of FS-89's statements
is in it; its method is.** Thm II.1 (ID on `Ω_a^r` iff (1) irreducibility, (2) hyperbolicity at every place including `∞`, (3) two
rationally independent elements) — our action meets (1), meets (3) iff `|S| ≥ 2`, fails (2) at `∞` only. §II.3 (Lemmas II.7–II.11,
Props. II.4–II.5) is D1-L3's method, written out `p`-adically; Prop. III.4's proof (p. 527) states its principle (hyperbolicity needed only
along the subspace carrying the null sequence). **Thm I.2 + Prop. II.6 apply to FS-89's action verbatim** (a minimal `M` with `M − M = G`
is `G`), replacing Furstenberg's Prop. IV.1 in D1-T1's band-free form. Thms III.1/V.1 exempt `p`-adic directions only by quotient; the
archimedean place is never exempt. Chapter IV (`Ω_P`, infinite type) covers `Q̂`; its projection passage is D2-L1's method analogue |
`pdf/Berend1984-multi-invariant-sets-compact-abelian-groups.pdf` (Kooshi's browser save, 2026-09-25) | **read in full** (2026-09-25,
FS-89's prior-art reader, `plans/FS89-PA-berend1984.md`; every quoted statement checked against the page image)

**File-table rows:** `pdf/Berend1983-multi-invariant-sets-on-tori.pdf` | `[Berend1983]` | read in full (2026-09-25, FS-89 reader) ·
`pdf/Berend1984-multi-invariant-sets-compact-abelian-groups.pdf` | `[Berend1984]` | read in full (2026-09-25, FS-89 reader).

**Also owed (a note for `[Furstenberg1967]`'s row):** its Prop. IV.1 is now read in held form — 1983 p. 530 quotes it for commutative
toral semigroups, and 1984 Thm I.2 + Prop. II.6 generalise it to solenoids and non-commutative semigroups.

## 9. Items for the close inventory (sent to the owner; the owner logs them)

1. The reading is done; the verdict table is §4: nothing of FS-89's is in print as a statement; the method is, above all D1-L3's (§II.3).
2. The prior-art debt on `[Berend1983]` §4 and `[Berend1984]` is closed; the bibliography rows in §8 replace the combined row.
3. **In print and applicable:** Thm I.2 + Prop. II.6 (1984) give "minimal `M`, `M − M = G` ⟹ `M = G`" for `(R̂_S, U_S)`; D1-T1's Remark 2
   input "[external, not held]" is held. Consequence (b) of §5: band-free `MS(S)` at every `|S| ≥ 2` [hand, one mind].
4. **Unverified widening, to route to a verifier** (§5 (c)): `RS_k(S)` for `k < 2·min S` and `RQ_k` for `k ≤ 9` [hand, one mind, unchecked].
5. A recognition for the grokkings (the owner's call): Berend 1983 Example 4.3 (p. 525) is the earliest printed sighting of our
   archimedean leaves — the ratio `(3+4i)/5 = w₅` and the circles of radii `5^k`.
6. The close's wording: FS-89's statements can be called **"not in Berend 1983, 1984 or 1984 (ETDS); method Berend's"**; "new" still
   needs the later literature citing Berend (§7's flagged list), which this reading did not open.

## Theorems this phase proved

| id | statement | grade | where |
|---|---|---|---|
| PA-B1 | `(R̂_S, U_S)` meets Berend 1984's hypotheses (1) at every `S`, (3) iff `|S| ≥ 2`, (2) at every finite place and not at `∞`; it is an ℱ-flow (Prop. II.6) at every finite `S` | hand (hypothesis check) | §2 |
| PA-B2 | for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A` (D1-L2, D1-L3, Berend Thm I.2 + Prop. II.6) | hand, one mind; rests on D1-L2 and D1-L3 (verified twice) | §5 (b) |
| PA-B3 | (candidate) `RS_k(S)` for `k < 2·min S`, `|S| ≥ 2`; `RQ_k` for `k ≤ 9` (PA-B2 with VB1–VB4) | hand, one mind, **unverified** | §5 (c) |

## Would-have-searched-here log

None: the reading needed no search of any kind. Two zbMATH/web look-ups were not needed (the reference lists are textbooks).
