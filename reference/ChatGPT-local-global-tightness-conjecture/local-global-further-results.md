# Further results toward local–global tightness

Prepared 2026-09-14, continuing the discussion of `local-global-tightness.txt`.

These are partial results, not a proof of the full conjecture. The mathematical arguments below are hand proofs [H], not Lean-checked. The explicit example and identities were verified using exact rational arithmetic [C]. No claim of priority is made for the results or constructions.

## Results and their dependencies

1. For every real number field, the unit-vector ring contains `1/p` exactly when there is no conjugation-stable prime above the rational prime `p`.
2. The previous result `χ(F²)=2 iff L(F)=2` follows from this ring framework; in particular the conjecture holds whenever `L(F)≤3`.
3. **For every real number field containing √3, the conjecture holds whenever `L(F)≤4`.** More precisely, `χ(F²)=3` if and only if `F` has a prime with residue field exactly F₃. The proof uses the classical multiplicativity of K₃ and the finite-plane spectral bound, but no unverified computation.
4. A chain of six unit rhombi gives an explicit **18-vertex, 33-edge, four-chromatic graph over Q(√2,√3)**. A separate exact four-colouring is included in the accompanying JSON.
5. **Assuming the four-colour forcer at distance 8/3 over K=Q(√3,√11) reported in the supplied note**, the conjecture holds whenever `L(F)≤5` for every real multiquadratic `F⊇K`. More generally, every real number field `F⊇K` in which every dyadic prime splits in `F(i)` has `χ(F²)≥5`.
6. Under the same forcer assumption, **eight copies** suffice to construct a finite graph requiring at least five colours over `K(√7)`. The eight rotation multipliers are given explicitly below.

The actual four-colour forcer, its edge list, and its exhaustive verification were not supplied. Items 5–6 are therefore conditional on that reported input. The deductions from the input are hand proofs. In particular, the 51,133-vertex graph's SAT refutation is not used.

## 1. The unit-vector ring and its finite primes

Let `F⊂R` be a number field, `E=F(i)`, and let conjugation fix `F` and send `i` to `−i`. Write

\[
U=\{u\in E:u\bar u=1\},\qquad R=\mathbb Z[U].
\]

Because `U` contains `1` and is closed under products and negation, `R` is also exactly the set of finite sums of elements of `U`. Thus its additive group is the unit-vector lattice `Λ` from the supplied note.

**Lemma 1.1.** Suppose a maximal ideal `m` of `R` contains a rational prime `p`. There is a conjugation-stable prime `P` of `O_E` above `p` such that

\[
R\subseteq\mathcal O_{E,P},\qquad
\ker(R\longrightarrow\kappa_P)=m.
\]

*Proof.* Put `B=R O_E⊂E`. This is integral over `R`; indeed a finite integral basis of `O_E` over `Z` generates `B` as an `R`-module. Lying-over gives a prime `n` of `B` above `m`. Its contraction `P=n∩O_E` contains `p`.

The localization `B_n` contains the discrete valuation ring `O_{E,P}`. A ring between a discrete valuation ring and its fraction field is either the valuation ring itself or the fraction field: an element of negative valuation would make a uniformizer invertible. Here `B_n` cannot be the field, because its maximal ideal contains the nonzero element `p`. Hence

\[
B_n=\mathcal O_{E,P}.
\]

This establishes the asserted inclusion and kernel. Every `u∈U`, together with its inverse, belongs to `R`, so `v_P(u)=0`.

If `P≠bar P`, choose `a∈P\bar P`. The element `a/bar a` belongs to `U` and has strictly positive `P`-valuation, a contradiction. Thus `P` is stable. ∎

**Theorem 1.2 (prime inversion).** For every rational prime `p`,

\[
\boxed{\frac1p\in R\quad\Longleftrightarrow\quad
\text{there is no conjugation-stable prime of }E\text{ above }p.}
\]

*Proof.* At a stable prime every unit vector, and hence every element of `R`, is integral. This excludes `1/p` if a stable prime above `p` exists. Conversely, if `1/p∉R`, then `p` is not a unit of `R`. A maximal ideal containing `pR` produces a stable prime by Lemma 1.1. ∎

For the quadratic extension `E/F`, having no stable prime above `p` means that every prime of `F` above `p` splits in `E`.

This statement concerns the complete unit-vector ring. It does not assert that a particular finite set of unit directions already generates `1/p`.

## 2. The two-colour classification

**Theorem 2.1.** For every real number field `F`,

\[
\chi(F^2)=2\quad\Longleftrightarrow\quad L(F)=2.
\]

*Proof.* If the plane is bipartite, the parity of the length of a unit-vector walk from `0` to `r∈R` is well-defined. For `r=u_1+⋯+u_n`, set `φ(r)=n mod 2`. Addition concatenates sums and multiplication expands two sums of lengths `n,m` into `nm` unit vectors. Consequently `φ:R→F₂` is a unital ring homomorphism, with `φ(u)=1` for every `u∈U`.

Apply Lemma 1.1 to its kernel. At the resulting stable dyadic prime `P`, every global unit vector reduces to `1`. If the residue involution `σ` were nontrivial, choose a nonzero residue element `b` with `b≠σ(b)` and lift it to `a∈O_E`. Then `a/bar a∈U` would reduce to `b/σ(b)≠1`. This is impossible.

Thus the residue involution is trivial. Its norm-one connection set is `{b:b²=1}={1}` in characteristic two, and its Cayley graph is a matching. Hence `L(F)=2`. The converse is the residue upper bound and the existence of an edge. ∎

It follows at once that `L(F)=3` implies `χ(F²)=3`.

## 3. Three colours when √3 belongs to the field

**Theorem 3.1.** Let `F` be a real number field with `√3∈F`. Then the following are equivalent:

\[
\chi(F^2)=3;
\qquad
\text{some prime of }F\text{ has residue field }\mathbb F_3;
\qquad
L(F)=3.
\]

In particular, the local–global tightness conjecture holds for every such field with `L(F)≤4`.

### 3.1 Rhombi force a finite quotient in characteristic three

Put

\[
\omega=\frac{1+i\sqrt3}{2},\qquad \delta=1+\omega.
\]

Both `ω` and `1−ω` are unit vectors. For every `z∈E` and `u∈U`, the four vertices

\[
z,\quad z+u,\quad z+\omega u,\quad z+(1+\omega)u
\]

form a unit rhombus with the diagonal between its two middle vertices also a unit edge. In any proper three-colouring the first and last vertices have the same colour. Therefore every `δu` is a period of any global three-colouring.

Periods form an additive subgroup. Hence `δR` consists of periods. Since

\[
(1+\omega)(1+\bar\omega)=3,
\]

every such colouring is periodic under `3R`. Its restriction to `R` descends to

\[
A=R/3R
\]

with connection set equal to the image `H` of `U`. The elements of `H` are units of `A`, so this Cayley graph has no loops.

The ring `A` is finite. To see this without a finite-generation assumption on the additive group of `R`, put `n=[E:Q]`. Any `n+1` elements of `R` have a nontrivial rational linear relation, which can be cleared and made a primitive integer relation. Reducing that relation modulo three proves that their images cannot be linearly independent over `F₃`. Thus

\[
\dim_{\mathbb F_3} A\le n.
\]

If `A` is the zero ring, periodicity already contradicts the unit edge from `0` to `1`. We may assume it is nonzero.

### 3.2 The residue factors are the full local residue fields

Let `J` be the nilradical of `A`, and write

\[
A/J\cong\prod_{j=1}^t k_j.
\]

Each factor comes from a maximal ideal of `R` containing `3`. By Lemma 1.1 it embeds into the residue field `κ_j` of a stable prime of `E` above `3`. The corresponding residue field of `F` has order `q_j=3^{f_j}`, with `f_j` odd, and

\[
\kappa_j\cong\mathbb F_{q_j^2}.
\]

In fact `k_j=κ_j`. Every norm-one element `s∈κ_j` can be written `s=b/σ(b)` with `b∈κ_j^×`, by finite-field Hilbert 90 (or by counting the image of that map). Lift `b` to `a∈O_E`. Then `a/bar a∈U⊂R` reduces to `s`.

These norm-one elements generate all of `κ_j` as a field over `F₃`. Indeed, their cyclic group has a generator of order `q_j+1`. A proper subfield of `F_{3^{2f_j}}` has order at most `3^{f_j}=q_j`, and cannot contain an element of that order. Thus the image of `R` is the full residue field.

Conjugation fixes each residue factor and acts there by its nontrivial involution. Stability of the corresponding prime shows that the maximal ideal of `R` is itself stable.

### 3.3 The residue product embeds back into the finite quotient graph

A finite commutative ring of characteristic three has a canonical copy `T` of its reduced quotient. Here is an explicit construction sufficient for this proof.

Choose `N` divisible by every residue-field degree over `F₃`, and sufficiently large that the map `a↦a^{3^N}` kills every nilpotent element. Since Frobenius is a ring homomorphism, the image

\[
T=\{a^{3^N}:a\in A\}
\]

is a subring, maps isomorphically to `A/J`, and is fixed by this Frobenius power. Conjugation commutes with Frobenius, so `T` is conjugation-stable.

Every `s∈T` satisfying `s bar s=1` is of the form `b/bar b` for some `b∈T^×`, component by component. Choose `a∈R` lifting `b`. The global unit vector `u=a/bar a` lies in `R`. Reducing `u bar a=a` modulo `3R`, and using invertibility of `bar b`, shows that `u` maps to `s`. Therefore `H` contains every norm-one element of `T`.

Consequently `Cay(A,H)` contains a subgraph isomorphic to the categorical product

\[
P_1\times\cdots\times P_t,
\qquad P_j=\mathrm{UD}(\mathbb F_{q_j}).
\]

Adjacency in this product means adjacency in every factor.

### 3.4 A three-colourable product has a three-colourable factor

The classical theorem of El-Zahar and Sauer implies that if a finite categorical product is three-colourable, at least one factor is three-colourable: a product of graphs each requiring at least four colours still requires at least four [1].

Here every `q_j` is `3^{f_j}` with `f_j` odd. If `f_j≥3`, then `q_j≥27`, and the finite-plane spectral bound gives

\[
\chi(P_j)\ge 1+\frac{q_j+1}{2\sqrt{q_j}}>3.
\]

Thus at least one `q_j` is exactly `3`. This gives a prime of `F` with residue field `F₃`.

Conversely, such a prime gives the three-colour upper bound by reduction, and `√3∈F` supplies a unit triangle. This proves the equivalence with `χ(F²)=3`. The equivalence with `L(F)=3` follows from Theorem 2.1 and the residue bound.

Finally, if `L(F)=4`, the upper bound is four and a hypothetical three-colouring would force `L(F)=3`. Hence `χ(F²)=4`. ∎

This argument does not prove the `L=4` cases for fields lacking `√3`.

## 4. Forced pairs give periods forming an ideal

**Theorem 4.1.** Let `F₀⊆F` be real fields. Suppose a finite unit-distance graph over `F₀` has distinct marked vertices `a,b` forced equal in every proper `k`-colouring. Put `δ=b−a∈F₀(i)`.

Every global proper `k`-colouring of `F²` is periodic under `δR(F)`. In particular,

\[
\boxed{\delta^{-1}\in R(F)\quad\Longrightarrow\quad\chi(F^2)>k.}
\]

*Proof.* For every `t∈F(i)` and `u∈U(F)`, the isometry `z↦t+u(z−a)` transports the marked vertices to `t` and `t+uδ`. Thus `uδ` is a period. Summing periods gives the whole subgroup `δR(F)`. If `δ⁻¹∈R(F)`, then `1` is a period, contradicting the unit edge from `0` to `1`. ∎

For a useful, nonvacuous starting gadget, require it to have a proper `k`-colouring. The applications here use this intended meaning of a forcer.

**Finite construction.** A representation

\[
\delta^{-1}=u_1+\cdots+u_m,\qquad u_j\bar u_j=1,
\]

produces a finite witness directly. Normalize the marked vertices to `0,δ`, put `s₀=0`, and define

\[
s_j=\delta\sum_{r=1}^j u_r.
\]

Place the `j`th copy of the gadget by `z↦s_{j−1}+u_j z`. Its marked vertices are `s_{j−1},s_j`. Every `k`-colouring makes the entire chain of marked vertices equal. But `s_m=1`, so adding the unit edge `0—1` makes a `k`-colouring impossible.

If the original gadget has `n` vertices, the construction has at most `m(n−1)+1` distinct vertices. Additional coincidences or additional unit edges do not invalidate the lower-bound argument. No claim that the full union has a `(k+1)`-colouring follows automatically; the construction certifies that it requires at least `k+1` colours.

This generalizes the two-copy spindle construction by allowing any finite unit-vector sum to close the chain.

## 5. An explicit four-chromatic example over Q(√2,√3)

Let

\[
\omega=\frac{1+i\sqrt3}{2},\quad
\delta=1+\omega,\quad
u=\frac{-1+2i\sqrt2}{3}.
\]

Then `u bar u=1`, and

\[
1+u+\bar u=\frac13,\qquad
\delta(1+\bar\omega)=3.
\]

Therefore

\[
\delta\bigl(1+\bar\omega+u+u\bar\omega+\bar u+\bar u\bar\omega\bigr)=1.
\]

All six summands in parentheses are unit vectors. Apply the finite construction to the standard unit rhombus with opposite marked vertices `0,δ`.

After identifying coincident vertices, the resulting point set has **18 vertices and 33 unit-distance edges**. Its six rhombi and closing edge give a hand proof that it is not three-colourable. The supplied exact verifier enumerates all unit edges, checks the rhombi, exhaustively confirms non-three-colourability, and finds and checks a four-colouring. Thus this finite graph has chromatic number exactly four.

The field plane itself also has chromatic number four. At two, the completion is `Q₂(√2,√3)`, whose square-class span is generated by `2,3`. It contains neither `i` nor the unramified quadratic generator `√−3`. Since adjoining `i` is equivalent, over this field, to adjoining `√−3`, the extension is unramified quadratic with residue extension `F₄/F₂`. Its residue graph is `K₄`, giving the upper bound.

Files:

- `example_qsqrt2_qsqrt3.json`: exact coordinates, complete induced edge list, the six rhombi, closing edge, and a four-colouring. Each coordinate is a list of rational coefficients in the basis `1,√2,√3,√6`.
- `verify_local_global_extensions.py`: independent standard-library Python verification using `fractions.Fraction`.

## 6. Consequences of the reported 8/3 four-colour forcer

Let

\[
K=\mathbb Q(\sqrt3,\sqrt{11}).
\]

**Input assumption G₄.** There exists a finite, four-colourable unit-distance graph over `K` with two marked points at distance `8/3` forced equal in all proper four-colourings.

This is the specific computed assertion in §4 of the supplied note. It is accepted here as an input, not independently certified.

Because the distance is rational, a translation and a rotation over `K` normalize the marked points to `0,8/3`.

**Theorem 6.1, conditional on G₄.** If `F⊇K` is a real number field and every prime above two splits in `F(i)`, then

\[
\chi(F^2)\ge5.
\]

*Proof.* Theorem 1.2 gives `1/2∈R(F)`, hence `3/8∈R(F)`. Apply Theorem 4.1 with `δ=8/3` and `k=4`. ∎

**Corollary 6.2, conditional on G₄.** For every real multiquadratic `F⊇K`,

\[
L(F)\le5\quad\Longrightarrow\quad
\chi(F^2)=L(F).
\]

*Proof.* The Moser spindle gives `χ(F²)≥4`, so `L(F)≥4`. If `L(F)=4`, the upper bound and the spindle settle the value.

At two, a multiquadratic completion has residue degree at most two. Since it contains `√3`, a stable dyadic prime cannot yield a ramified quadratic extension: that would give a bipartite upper bound despite the unit triangle. If its residue degree were two, it would contain the unramified quadratic extension `Q₂(√−3)`, and together with `√3` this would put `i` into the completion, making the prime split. Therefore any stable dyadic prime has residue field `F₂` downstairs and the unramified quadratic residue extension `F₄`; its graph is `K₄`.

If `L(F)=5`, no such stable prime can exist. Theorem 6.1 gives `χ(F²)≥5`, and the residue bound gives the opposite inequality. ∎

For these multiquadratic fields with `L(F)≥6`, the same reasoning gives only the lower bound five. It does not prove six or seven.

## 7. Eight copies over K(√7)

Theorem 6.1 has a short explicit realization for this field. Let

\[
w=\frac{-3+i\sqrt7}{4},\qquad w\bar w=1.
\]

The trace identities are

\[
w+\bar w=-\frac32,
\qquad w^2+\bar w^2=\frac14,
\qquad w^3+\bar w^3=\frac98.
\]

Hence

\[
\boxed{
w^3+\bar w^3-3w^2-3\bar w^2=\frac38.
}
\]

Use the eight unit multipliers

\[
w^3,\quad\bar w^3,\quad
-w^2,\quad-w^2,\quad-w^2,\quad
-\bar w^2,\quad-\bar w^2,\quad-\bar w^2.
\]

Their sum times `8/3` is exactly `1`. Eight chained copies of the normalized G₄ forcer therefore connect forced-equal endpoints `0,1`. Their closing unit edge rules out four colours.

If the forcer has `n` vertices, this gives a finite unit-distance graph over `K(√7)` with at most `8n−7` vertices requiring at least five colours. This does not use a six-colouring of the finite plane at 83. It does not supply a six-chromatic graph.

The Python verifier checks every multiplier's norm and the sum identity exactly. The separate, unresolved validation task is to supply and verify the original G₄ forcer.

## 8. Scope of the remaining gap

The arguments establish the following part of the proposed lower-bound direction:

| Fields | Range established | Dependency |
|---|---|---|
| Every real number field | `L≤3` | Hand proof |
| Every real number field containing √3 | `L≤4` | Hand proof; K₃ multiplicativity; finite-plane spectral bound |
| Every real multiquadratic field containing K | `L≤5` | Hand deduction from reported G₄ forcer |
| Every real number field containing K, with all dyadic primes split in F(i) | `χ≥5` | Same G₄ input |

The chain construction cannot by itself bridge five to six without a suitable five-colour forcer. If the supplied note's no-forced-pair result at 11 holds, it excludes starting this construction with a genuine five-colour forcer over those fields, just as it excludes the ordinary spindle.

Thus neither the full conjecture nor its six- and seven-colour predictions has been proved here.

## References and provenance

[1] M. El-Zahar and N. Sauer, *The chromatic number of the product of two 4-chromatic graphs is 4*, Combinatorica 5 (1985), 121–126. [Publisher](https://link.springer.com/article/10.1007/BF02579374). Used only for the statement that a categorical product of graphs all requiring at least four colours still requires at least four.

[2] D. A. Madore, *The Hadwiger–Nelson problem over certain fields*, 2015. [Paper](https://arxiv.org/pdf/1509.07023). Background for residue upper bounds.

[3] G. E. Moorhouse, *On the chromatic numbers of planes*, 2010. [Paper](https://ericmoorhouse.org/pub/chromatic.pdf). Background for number-field reductions and categorical products.

[4] L. A. Vinh, *On chromatic number of unit-quadrance graphs (finite Euclidean graphs)*, 2005. [Paper](https://arxiv.org/abs/math/0510092). Finite-plane spectral context; the inequality used in §3 is also stated in the supplied note.

[5] User-supplied `local-global-tightness.txt`, dated 2026-09-13. Definitions of `L(F)` and the G₄ input. The exact source graph for G₄ was not attached.

The proofs and explicit identities in this note were developed during this conversation. Their appearance here should not be taken as a determination that they are absent from the existing literature or the user's research repository.
