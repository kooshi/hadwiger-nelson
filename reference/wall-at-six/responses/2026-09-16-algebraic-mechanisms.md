# Algebraic mechanisms behind the wall at six

Derived 2026-09-16 from the definitions in `WALL-AT-SIX.md.txt`.

Two conclusions have full proofs below:

1. **Rigidity at Q = 32.** Every maximum independent set of U₃₂ is an affine hyperplane over F₄. There are exactly 44 such sets, and exactly 11 partitions into four colour classes.
2. **Invariance through inert prime-power towers.** At every tower level, the degree and least adjacency eigenvalue acquire the same factor. The Hoffman lower bound is therefore exactly unchanged, in both odd and dyadic residue characteristic under the hypotheses below.

Additional deductions explain the linear four-colouring cutoff at Q = 64, the parity change in dyadic cliques, and limitations on periodic six-colourings. None of these results settles six-colourability of an unresolved target. These are derivations, not claims of research priority or Lean formalization.

## 1. A useful algebraic property of the unit circle

Let E = F_{Q²}, let conjugation be z ↦ z^Q, and put

\[
S=\{u\in E^*:u\bar u=1\},\qquad
U_Q=\operatorname{Cay}(E,+,S).
\]

Suppose u,v ∈ S and u+v=d≠0. Since conjugation agrees with inversion on S,

\[
\bar d=\bar u+\bar v=\frac1u+\frac1v=\frac d{uv}.
\]

Consequently

\[
u+v=d,\qquad uv=d/\bar d.
\]

Thus **a nonzero sum determines its unordered pair of unit summands**, if that pair exists: they are the roots of

\[
X^2-dX+d/\bar d=0.
\]

In characteristic two, distinct summands never have sum zero, so S is a Sidon set in the sense that all sums of unordered distinct pairs are different. In odd characteristic the zero sums from antipodal pairs are the exception. This is an algebraic property of the conic, not a numerical observation.

For Q = 2^m, a more precise common-neighbour formula follows. For d≠0, set t=N(d). Dividing a prospective unit summand by d gives the equation

\[
z^2+z+1/t=0.
\]

The two roots have the required norm and relative trace precisely when this polynomial is irreducible over F_Q. Hence

\[
|S\cap(d+S)|=
\begin{cases}
2,&\operatorname{Tr}_{F_Q/F_2}(1/N(d))=1,\\
0,&\operatorname{Tr}_{F_Q/F_2}(1/N(d))=0.
\end{cases}
\]

For a unit displacement d this trace is Tr(1)=m mod 2. Therefore:

- If m is even, U_{2^m} is triangle-free.
- If m is odd, every edge lies in exactly one K₄. Its four vertices have the form x+uF₄, for u∈S. In this case F₄*⊂S, and S is a disjoint union of (Q+1)/3 multiplicative F₄*-orbits.

In particular, U₆₄ is triangle-free. The increase in its chromatic lower bound is not caused by larger cliques.

## 2. Complete rigidity of the four-colourings of U₃₂

Throughout this section, E=F₁₀₂₄, viewed as a five-dimensional vector space over F₄, and S=μ₃₃.

### 2.1 An explicit four-colouring without a search

Take a primitive eleventh root β∈E. Since 33=3·11,

\[
S=F_4^*\,\langle\beta\rangle.
\]

Consider

\[
T(x)=\operatorname{Tr}_{E/F_4}(x)
=x+x^4+x^{16}+x^{64}+x^{256}.
\]

The powers of 4 modulo 11 are {1,4,5,9,3}, the nonzero quadratic residues. Thus T(β^j), for j≠0 mod 11, takes the two values

\[
r=\sum_{a\in R}\beta^a,\qquad
s=\sum_{a\notin R,\ a\ne0}\beta^a.
\]

Here r+s=1. Also 2 is a quadratic nonresidue modulo 11, so r²=s. Therefore

\[
r^2+r+1=0.
\]

The values r,s are the two nontrivial cube roots of unity in F₄, and both are nonzero. Moreover T(1)=1. By F₄-linearity,

\[
T(u)\ne0\qquad(u\in S).
\]

It follows that **x↦T(x) is a proper four-colouring**. Each colour class has 4⁴=256 vertices.

The affine lines x+uF₄ are K₄s, so every independent set has at most one point in each line of any fixed unit direction. These lines partition E. Consequently α(U₃₂)=256 and χ(U₃₂)=4.

This explains the existence of four colours through arithmetic modulo 11, rather than merely supplying a verified colouring.

### 2.2 The least-eigenvalue characters form exactly one norm circle

Use the additive characters

\[
\psi_a(x)=(-1)^{\operatorname{Tr}_{E/F_2}(ax)},\qquad
\lambda_a=\sum_{u\in S}\psi_a(u).
\]

The trivial eigenvalue is λ₀=33. For a≠0, splitting S into its eleven F₄*-orbits gives

\[
\lambda_a=4M_a-11,
\]

where M_a is the number of these projective directions annihilated by x↦Tr_{E/F₄}(ax). Each orbit contributes either 3 or −1.

The colouring above gives λ₁=−11. Multiplication by S preserves the sum, so λ_a=−11 for every a∈S.

We now prove that there are no others. Use the standard Weil bound |λ_a|≤2√32 for nontrivial characters, as in the supplied record. The only possible nontrivial eigenvalues are

\[
-11,-7,-3,1,5,9.
\]

Every multiplicity is a multiple of 33, because S acts freely on nonzero character indices. Let r_j denote the multiplicity of j divided by 33. The first five spectral moments give

\[
\begin{aligned}
\sum r_j&=31, &\sum j r_j&=-1, &\sum j^2r_j&=991,\\
\sum j^3r_j&=959, &\sum j^4r_j&=63391.
\end{aligned}
\]

These moments can be checked without a spectral computation. Closed walks of lengths 2 and 3 number 33 and 66 per vertex. For length 4, the Sidon property gives 528 nonzero displacements with two common neighbours and all other nonzero displacements with none, so the count is

\[
33^2+4\cdot528=3201
\]

per vertex. Subtracting the trivial eigenvalue's contribution gives the displayed moments.

Apply the polynomial

\[
P(X)=(X+7)(X+3)(X-5)(X-9)
=X^4-4X^3-74X^2+156X+945.
\]

It vanishes at four of the six possible eigenvalues, and the moments yield

\[
10240r_{-11}+1024r_1=15360,
\quad\text{or}\quad
10r_{-11}+r_1=15.
\]

Since r_{−11} is a positive integer and r₁≥0, we must have r_{−11}=1. Thus

\[
\boxed{\{a\ne0:\lambda_a=-11\}=S.}
\]

The only non-elementary estimate used in this isolation step is the standard Weil bound. Exact Walsh computations independently confirm the conclusion.

### 2.3 Equality in Hoffman plus the Sidon property forces hyperplanes

Let A be any independent set of size 256, and let f=1_A. Use normalized Fourier coefficients, so

\[
f(x)=\sum_a \widehat f(a)\psi_a(x),\qquad
\widehat f(0)=1/4.
\]

The set attains Hoffman's bound, because 1024·11/(33+11)=256. The equality condition forces every nonconstant Fourier coefficient into the least eigenspace. By §2.2,

\[
\operatorname{supp}\widehat f\subseteq\{0\}\cup S.
\]

Put B={a∈S: f̂(a)≠0}. The identity f²=f becomes convolution of Fourier coefficients. If distinct a,b∈B had a+b∉S, the coefficient at a+b would be

\[
0=2\widehat f(a)\widehat f(b),
\]

because the Sidon property permits no other unordered pair of nonzero supported frequencies with that sum. This is impossible. Thus a+b∈S for every distinct a,b∈B.

This forces |B|≤3. Indeed, choose a,b∈B and write c=a+b. If w∈B were different from a,b,c, both pairs {b,c} and {w,a+w} would be distinct pairs in S summing to a, contradicting the Sidon property.

B cannot be a singleton: its Fourier equation would read f̂(a)=2(1/4)f̂(a). If a,b∈B, the equation at c=a+b forces c∈B. Therefore

\[
B=\{a,b,a+b\}.
\]

Writing the three nonzero coefficients as A₁,A₂,A₃ gives

\[
A_1=4A_2A_3,\quad A_2=4A_1A_3,\quad A_3=4A_1A_2.
\]

All three have absolute value 1/4, with compatible signs. Consequently

\[
f(x)=\tfrac14(1+\varepsilon_1\psi_a(x))
                  (1+\varepsilon_2\psi_b(x)).
\]

So A is an affine binary subspace of codimension two.

There is one final improvement. Since a,b,a+b∈S, the ratio b/a has norm one and its sum with 1 also has norm one. The sum-product identity of §1 shows it solves X²+X+1=0. Hence b/a∈F₄*, and the binary subspace is actually an F₄-hyperplane:

\[
\boxed{A=\{x\in E:\operatorname{Tr}_{E/F_4}(ax)=c\}}
\quad(a\in\mu_{33},\ c\in F_4).
\]

Normals differing by an element of F₄* give the same parallel class. There are 33/3=11 directions and four translates per direction: **44 maximum independent sets**.

Every proper four-colouring consists of four maximum independent sets. Two F₄-hyperplanes with different directions intersect, so its four classes must be parallel. Thus there are **11 unordered colour partitions**, or 11·4!=264 colourings with four fixed colour labels.

This is a proved periodicity phenomenon inside the family. It does not imply analogous rigidity at 27 or 64: their extremal spectral situations are different.

## 3. Why binary linear four-colouring stops at 64

For Q=2^m, a binary linear four-colouring has a kernel W of codimension two in E. Let its independent defining characters have indices a,b. Character orthogonality gives

\[
|S\cap W|=\frac{Q+1+\lambda_a+\lambda_b+\lambda_{a+b}}4.
\]

The colouring is proper exactly when this count is zero.

At Q=32, λ_min=−11, so zero requires all three characters to lie in the least eigenspace. The rigidity proof above identifies exactly how this can occur.

At Q=64, the Weil bound already gives λ_a≥−16 for nontrivial characters. There is also a simple congruence: since the sum of the roots of X⁶⁵−1 is zero, the number of u∈S with Tr(au)=1 is even. Consequently λ_a≡65≡1 mod 4, so λ_a≥−15. Therefore, without needing to compute the spectrum,

\[
\boxed{|S\cap W|\geq(65-45)/4=5.}
\]

Thus every codimension-two binary subspace contains at least five forbidden unit vectors. This lower bound is attained. The following were independently computed using exact integer Walsh transforms and direct edge checks:

| Q | λ_min | Minimum number of unit vectors in a binary codimension-two subspace | Verified linear colouring |
|---|---:|---:|---:|
| 2 | −1 | 0 | 4 |
| 4 | −3 | 0 | 4 |
| 8 | −3 | 0 | 4 |
| 16 | −7 | 0 | 4 |
| 32 | −11 | 0 | 4 |
| 64 | −15 | 5 | 8 |

The lower bound of five follows algebraically from Weil and the congruence. Exact integer computations verify that it is attained and that λ_min=−15, and supply the displayed colourings. The general intersection identity is a proof for all m.

For a reproducible Q=64 witness, represent F₄₀₉₆ as F₂[t]/(t¹²+t³+1), storing coefficients in a 12-bit integer. The three colour bits given by parity against masks (935,2066,1898) form a proper eight-colouring. Masks (20,2438) define a codimension-two subspace meeting S in exactly five points. A mask a acts on v by popcount(a & v) modulo two.

### A restriction on periodic six- or seven-colourings

Any cubelike graph on at most 16 vertices that is colourable with at most seven colours is in fact four-colourable. On 16 vertices such a colouring has an independent triple. Translate it to {0,a,b}. Then {0,a,b,a+b} is an independent two-dimensional subspace, whose four cosets give a four-colouring. On eight vertices an independent pair gives the analogous four-colouring; the smaller cases are immediate.

It follows that a six- or seven-colouring of U₆₄ cannot be periodic under a translation subspace of dimension at least eight. Otherwise its quotient would be a cubelike graph on at most 16 vertices and could be recoloured with four colours, contradicting the spectral lower bound for U₆₄.

Also, every linear eight-colouring of U₆₄ has quotient K₈: a missing nonzero connection in an eight-vertex cubelike quotient would give a four-colouring. Therefore none of those eight classes can simply be merged. These are restrictions on possible constructions; they do not exclude general nonlinear six-colourings.

## 4. The least eigenvalue is inherited throughout inert towers

Let O be a discrete valuation ring with uniformizer π and finite residue field k of order Q. Let O_E be its unramified quadratic extension, with norm N. Put

\[
A_j=O_E/\pi^jO_E,\quad
S_j=\{u\in A_j:N(u)=1\},\quad
G_j=\operatorname{Cay}(A_j,+,S_j).
\]

Assume either Q is even or Q≡3 mod 4. These are the two inert residue families in the supplied note. The dyadic ramified case is not part of this theorem.

**Theorem.** For every j≥1,

\[
|A_j|=Q^{2j},\qquad
d_j=Q^{j-1}(Q+1),\qquad
\boxed{\lambda_{\min}(G_j)=Q^{j-1}\lambda_{\min}(G_1).}
\]

In particular,

\[
1+\frac{d_j}{|\lambda_{\min}(G_j)|}
=1+\frac{Q+1}{|\lambda_{\min}(U_Q)|}.
\]

### Proof

The norm-one conic is smooth over k: the polar derivative at a unit is a nonzero linear functional. Each point at level j−1 therefore has Q lifts at level j. This proves the degree formula.

The additive characters diagonalize the adjacency matrix. Divide them into two cases.

**Characters trivial on the last layer.** Such a character factors through A_{j−1}. Since every unit vector there has Q lifts, its eigenvalue at level j is Q times its previous eigenvalue.

**Characters nontrivial on the last layer.** The last layer π^{j−1}A_j is k² as an additive group. Fix a nontrivial additive character of k; the restricted character can be written using a nonzero k-linear functional L on k².

Above a residue unit vector u, the norm-one lifts are invariant under the last-layer tangent line

\[
T_u=\{v:B(u,v)=0\},
\]

where B is the polar form of the residue norm. Summing over each tangent-line coset cancels unless L vanishes identically on T_u. We count how many residue unit vectors can survive.

- In odd characteristic, identify the norm with x²+y². If L(x,y)=ax+by, the tangent is generated by (−u_y,u_x), so survival requires −a u_y+b u_x=0. The point u must lie on one fixed line through zero. A quadratic norm takes the value 1 at at most two points of that line.
- In characteristic two, B is a nondegenerate alternating form in dimension two, so T_u=ku. Survival requires L(u)=0. On that line there is exactly one norm-one point: the norm is anisotropic, and squaring is a bijection on k.

Each surviving residue point has Q^{j−1} lifts. Thus every character nontrivial on the last layer has eigenvalue of absolute value at most

\[
2Q^{j-1}\quad\text{in odd characteristic},
\qquad Q^{j-1}\quad\text{in characteristic two}.
\]

Meanwhile λ_min(G₁)≤−2 in the odd case, since the vertices (0,0),(1,0),(1,1),(0,1) induce a four-cycle. In the even case λ_min(G₁)≤−1 because the graph contains an edge. These inequalities follow by interlacing, or by extending the corresponding small-graph Rayleigh vectors by zero.

The new characters therefore cannot have a smaller eigenvalue than Q^{j−1}λ_min(G₁). Induction gives the same bound for inherited characters, and a character inherited from a least-eigenvalue character of G₁ attains it. This proves the theorem. ∎

### Consequences for the escape hatches

- Any exclusion supplied by Hoffman at the residue level survives every inert prime-power level. In particular, the odd targets with Q=71 or Q≥98 cannot acquire a six-colouring higher in their towers.
- The dyadic Q≥128 exclusions also survive. At Q=128 the lower bound remains at least eight.
- The towers at Q=2,8,16,32 are all exactly four-chromatic: the rounded Hoffman bound is four, and reduction pulls back the known four-colouring. The Q=3 towers are exactly three-chromatic by the same argument.
- The Q=4 tower is not settled by this sandwich: its rounded Hoffman bound is three while its residue graph needs four colours.
- The SDP improvements at Q=59,67,79,83 do not automatically lift by this argument. Their least-eigenvalue bounds alone do not exclude six.

Combining this theorem with the low-Q colourings in the supplied record gives a finite restriction even when arbitrary tower levels and products are allowed. Any full CRT norm target with chromatic number exactly six must include a prime-power factor whose residue size belongs to

\[
\boxed{\{23,27,31,43,47,59,64,67,79,83\}.}
\]

To see this, a small factor that is at most five-colourable makes the whole product at most five-colourable by projection. If there is no small factor and no factor in this displayed list, every factor has Hoffman bound strictly greater than six, even at higher levels. Their categorical product does too: adjacency eigenvalues multiply, so the Hoffman bound of a product of regular graphs is the minimum of the factors' Hoffman bounds. Alternatively, use fractional Hedetniemi and the fractional lower bounds. The finite list uses the supplied low-Q colourings and the reported exact spectral exclusion at 71.

This reduces the possible residue sizes, not the unbounded tower exponents. It does not prove that the remaining tower levels stabilize in chromatic number.

## 5. A direct field-side explanation for the dyadic parity restriction

If a real number field F contains √3, then F(i) contains the primitive cube root

\[
\omega=(-1+i\sqrt3)/2.
\]

It is an algebraic integer of norm one. At an inert prime above 2 it reduces to a nontrivial cube root: its polynomial X²+X+1 has value 1 at X=1 in characteristic two. Thus its order remains three and it belongs to μ_{Q+1}. Necessarily

\[
3\mid Q+1.
\]

For Q=2^m this means m is odd. **Consequently U₆₄ cannot be an inert dyadic target of a field containing √3.** This supplies the dyadic part of the observation that the known five-chromatic fields cannot see the six-window targets.

## 6. Verification and provenance

The arguments in §§1–5 are algebraic proofs, with the standard Weil bound explicitly used in §§2.2 and 3. The finite computations in §3 verify sharpness, spectra, and colouring witnesses. The original project's hidden witnesses and certificate checker were not needed for the proofs. Applications to the full window use the input classifications identified in the text.

Independent checks performed here:

- Exact field arithmetic, integer Walsh spectra, the common-neighbour trace formula, and direct edge checks of the displayed linear colourings for every Q=2,4,8,16,32,64.
- Construction of the 44 claimed independent sets and 11 colour partitions at Q=32, and verification that the least-eigenvalue characters correspond exactly to μ₃₃ under the trace pairing. The proof, rather than enumeration of arbitrary subsets, establishes completeness.
- Exhaustive binary codimension-two character-space search, giving minima 0,0,0,0,0,5 for the six dyadic targets.
- Numerical Fourier checks of the tower formula modulo 3,9,27; 7,49,343; 11,121; and 23,529. These computations are checks of the proof, not replacements for it.
- Extension-ring checks at residue size 27 over Z/3 and Z/9, with least eigenvalues −8 and −216; at dyadic residue sizes 4 and 8 over Z/4, with least eigenvalues −12 and −24; and at dyadic residue size 2 through five levels, with least eigenvalues −1,−2,−4,−8,−16.

Finite Euclidean graph spectra over prime-power rings have prior literature, notably Medrano–Myers–Stark–Terras, *Finite Euclidean graphs over rings*, Proc. AMS 126 (1998), 701–710. The publisher's full text was unavailable during this reading; I have not established whether its results already state the exact tower corollary in §4. [Publisher link](https://www.ams.org/journals/proc/1998-126-03/S0002-9939-98-04294-4/S0002-9939-98-04294-4.pdf).

For the product alternative, Zhu's fractional Hedetniemi theorem and Zhang's vertex-transitive independence-ratio theorem are established prior art, as recorded in the preceding note. [Zhu, Theorem 2.4](https://arxiv.org/pdf/2502.16078); [Zhang, Theorem 1.8](https://arxiv.org/pdf/1007.0797).

The unresolved mathematical task is still to exclude or construct a nonlinear six-colouring in one of the window targets. The rigidity theorem proves that algebraic periodicity can be compulsory in this family; it does not make that property universal.

## Appendix: reproducible dyadic checks

The following Python uses NumPy and integer finite-field arithmetic. It verifies spectra and constructions; the proofs above supply the universal conclusions. It can be saved as `verify_dyadic_norm_graphs.py` and run directly.
```python
"""Reproducible verification for norm-one Cayley graph deductions."""
import json
from collections import Counter
import numpy as np


def mul(a, b, poly):
    n = poly.bit_length()-1
    out = 0
    while b:
        if b & 1:
            out ^= a
        b >>= 1
        a <<= 1
        if a >> n:
            a ^= poly
    return out


def power(a, e, poly):
    out = 1
    while e:
        if e & 1:
            out = mul(out, a, poly)
        a = mul(a, a, poly)
        e >>= 1
    return out


def remainder(a, b):
    while a and a.bit_length() >= b.bit_length():
        a ^= b << (a.bit_length()-b.bit_length())
    return a


def gcd(a, b):
    while b:
        a, b = b, remainder(a, b)
    return a


def irreducible(poly):
    n = poly.bit_length()-1
    x = 2
    for j in range(1, n+1):
        x = mul(x, x, poly)
        if j <= n//2 and gcd(x ^ 2, poly) != 1:
            return False
    return x == 2


def walsh(a):
    a = np.array(a, dtype=np.int64, copy=True)
    h = 1
    while h < len(a):
        blocks = a.reshape(-1, 2*h)
        left, right = blocks[:, :h].copy(), blocks[:, h:].copy()
        blocks[:, :h] = left+right
        blocks[:, h:] = left-right
        h *= 2
    return a


def colour(vertex, masks):
    return sum(((vertex & a).bit_count() & 1) << j
               for j, a in enumerate(masks))


results = []
for m in range(1, 7):
    q = 1 << m
    n = q*q
    poly = next(p for p in range(n+1, 2*n, 2) if irreducible(p))
    unit = [u for u in range(1, n) if power(u, q+1, poly) == 1]
    assert len(unit) == q+1
    indicator = np.zeros(n, dtype=np.int64)
    indicator[unit] = 1
    ev = walsh(indicator)
    assert ev[0] == q+1
    pair_sums = {u ^ v for i, u in enumerate(unit) for v in unit[i+1:]}
    assert len(pair_sums) == q*(q+1)//2
    common = walsh(ev*ev)//n
    for d in range(1, n):
        norm = power(d, q+1, poly)
        x = power(norm, q-2, poly)
        trace = 0
        for _ in range(m):
            trace ^= x
            x = mul(x, x, poly)
        assert trace in (0, 1)
        assert common[d] == 2*trace
    best, pair = q+1, None
    bvec = np.arange(1, n)
    for a in range(1, n):
        nums = q+1+ev[a]+ev[bvec]+ev[bvec ^ a]
        nums[a-1] = 4*(q+1)
        j = int(nums.argmin())
        val = int(nums[j])//4
        if val < best:
            best, pair = val, [a, int(bvec[j])]
    assert best == sum(all((s & a).bit_count()%2 == 0 for a in pair) for s in unit)
    masks = pair if best == 0 else None
    if m == 6:
        rng = np.random.default_rng(20260916)
        for trial in range(200000):
            a,b,c = map(int, rng.integers(1, n, size=3))
            span = {0,a,b,c,a^b,a^c,b^c,a^b^c}
            if len(span) != 8:
                continue
            if sum(int(ev[t]) for t in span) == 0:
                masks = [a,b,c]
                break
        assert masks is not None
    assert masks is not None
    # Independently check the colouring directly on every edge.
    labels = [colour(v, masks) for v in range(n)]
    assert all(labels[v] != labels[v^s] for v in range(n) for s in unit)
    row = {
        'Q':q, 'field_polynomial_bits':hex(poly),
        'spectrum':sorted(Counter(map(int, ev)).items()),
        'minimum_unit_points_in_binary_codim2_subspace':best,
        'minimizing_masks':pair,
        'proper_linear_colour_masks':masks,
        'colour_class_sizes':sorted(Counter(labels).values()),
        'common_neighbour_trace_identity_verified':True,
        'sidon_verified':True,
    }
    if m == 5:
        minimal = set(map(int, np.flatnonzero(ev == -11)))
        assert len(minimal) == 33
        assert len({a^b for a in minimal for b in minimal if a < b}) == 528
        planes = {frozenset([a,b,a^b]) for a in minimal for b in minimal
                  if a != b and a^b in minimal}
        assert len(planes) == 11
        classes = set()
        for plane in planes:
            a,b = sorted(plane)[:2]
            for label in range(4):
                block = tuple(v for v in range(n) if colour(v,[a,b]) == label)
                assert len(block) == 256
                classes.add(block)
        assert len(classes) == 44
        def trace4(x):
            ans = 0
            for _ in range(5):
                ans ^= x
                x = power(x,4,poly)
            return ans
        assert all(trace4(u) != 0 for u in unit)
        def trace2(x):
            ans = 0
            for _ in range(10):
                ans ^= x
                x = mul(x,x,poly)
            return ans
        masks_from_units = {sum(trace2(mul(u,1 << j,poly)) << j for j in range(10)) for u in unit}
        assert masks_from_units == minimal
        row['Q32_trace4_colouring_verified'] = True
        row['Q32_minimal_character_support_is_unit_circle'] = True
        row['Q32_algebraic_maximum_independent_sets_constructed'] = len(classes)
        row['Q32_algebraic_colour_partitions_constructed'] = len(planes)
    results.append(row)
    print(json.dumps(row), flush=True)
```
