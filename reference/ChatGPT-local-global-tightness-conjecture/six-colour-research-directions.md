# Two concrete routes toward six colours

Research note · 14 September 2026

There are two useful next projects: search for a unit-distance gadget that forces two points at distance 2 to have different colours in every five-colouring, and search for a six-colouring of the finite unit-distance graph modulo 83. The first would give a six-colour lower bound for the real plane. The second would give a six-colour upper bound for a particular number-field plane. If both succeed in the field below, they would determine its chromatic number exactly.

Write

\[
K=\mathbb Q(\sqrt3,\sqrt{11}),\qquad
F=K(\sqrt7)=\mathbb Q(\sqrt3,\sqrt7,\sqrt{11}).
\]

Here \(\chi(F^2)\) means the number of colours needed to colour all points with coordinates in \(F\), requiring different colours whenever two points are exactly one unit apart. Both projects remain proposals; this note supplies neither the required gadget nor the finite six-colouring.

## 1. Lower bound: force different colours at distance 2

**Target.** Find a finite unit-distance graph \(G\), with coordinates in \(F\), and marked vertices \(a,b\) such that:

1. \(G\) has a proper colouring using at most five colours.
2. \(\lVert a-b\rVert=2\).
3. Every proper five-colouring of \(G\) gives \(a\) and \(b\) different colours.

The marked pair is not a unit edge. Its surrounding unit edges must enforce the inequality indirectly. Requiring an actual five-colouring makes this a non-vacuous forcing gadget.

### Why this would suffice

Exoo and Ismailescu constructed a finite graph whose edges have lengths 1 or 2 and which cannot be five-coloured. It has 426 vertices, 2,009 edges of length 1, and 892 edges of length 2; all coordinates lie in \(K\). We use their published result as an input. [Exoo–Ismailescu, *A 6-chromatic two-distance graph in the plane* (2019), §2](https://arxiv.org/pdf/1909.13177).

For each length-2 edge \(xy\) of that graph, place an isometric copy of \(G\) with \(a\) at \(x\) and \(b\) at \(y\). Keep the original unit edges and all unit edges of the copies; discard the length-2 edges.

Suppose the resulting unit-distance graph had a five-colouring. Its restriction to each copy of \(G\) would force the endpoints of the replaced length-2 edge to differ. Its restriction to the original 426 vertices would therefore properly colour every original edge of either length. That contradicts the cited result. Thus the resulting graph needs at least six colours.

**The construction stays in \(F\).** Identify plane points with elements of \(F(i)\). For an oriented length-2 edge \(xy\), the required isometry is

\[
T(z)=x+\frac{y-x}{b-a}(z-a).
\]

The multiplier has complex norm 1 because both displacements have length 2. It belongs to \(F(i)\), so the transformed real and imaginary coordinates remain in \(F\).

If \(G\) has \(n\) vertices, the construction uses at most

\[
426+892(n-2)
\]

vertices. Coincident vertices only reduce that count; additional unit edges do not weaken the contradiction. This argument proves a lower bound of six. It does not supply a six-colouring of the constructed graph.

### The first computational test

The supplied research note reports a five-colourable, 51,133-vertex unit-distance graph over \(F\). Its coordinates and colouring certificate were not supplied here, so they remain inputs for the proposed experiment. [Supplied note, §6](sandbox:/workspace/scratch/8719a7b4fdce/upload/local-global-tightness.txt).

Use that graph as the first candidate:

1. Verify its unit edges and a baseline five-colouring.
2. Enumerate pairs \(a,b\) whose **squared distance is exactly 4**, using exact field arithmetic.
3. For each pair, ask a SAT solver whether the graph has a five-colouring with the additional constraint \(c(a)=c(b)\).
4. If the answer is UNSAT, retain a checkable proof and reduce the graph while preserving the marked pair and the contradiction.

| Result of the equality-constrained test | Meaning |
| --- | --- |
| SAT, with a verified colouring | This pair does not force different colours. |
| UNSAT, with a verified proof and a baseline five-colouring | This is the required forcing gadget. |
| Timeout or unresolved | No conclusion about this pair. |

Tests for pairs forced to have the **same** colour do not settle this question: they test the opposite relation. A complete negative result here would rule out suitable pairs in the tested graph, while leaving other graphs over \(F\) available.

The source note's prime-11 obstruction explains the choice of field. It reports that, over fields with a degree-one prime above 11, every pair forced different in all five-colourings is already at unit distance. Under that result, the proposed gadget cannot exist in Heule's field \(K(\sqrt5)\). Adjoining \(\sqrt7\) removes that degree-one prime and therefore removes this particular obstruction. That permits the search; it does not establish that a gadget exists. [Supplied note, §5, Corollary 3.3](sandbox:/workspace/scratch/8719a7b4fdce/upload/local-global-tightness.txt).

**Assessment.** This is a focused lower-bound search because one successful pair has a direct route to a finite graph requiring six colours. The uncertain step is finding the pair.

## 2. Upper bound: colour the finite plane modulo 83

**Target.** Find a proper six-colouring of

\[
H=\operatorname{UD}(\mathbb F_{83}),
\]

whose vertices are pairs \((x,y)\) modulo 83, with adjacency defined by

\[
(x-x')^2+(y-y')^2\equiv1\pmod{83}.
\]

The graph has \(83^2=6,889\) vertices, degree 84, and 289,338 undirected edges.

### What a colouring would prove

The usable prime above 83 gives a graph homomorphism from each connected component of the unit-distance graph on \(F^2\) to \(H\). Consequently,

\[
\chi(F^2)\le\chi(H).
\]

A verified six-colouring of \(H\) would therefore prove \(\chi(F^2)\le6\), using the reduction theorem already developed in the source note. This implication does not require the local–global tightness conjecture. [Supplied note, §§2 and 6](sandbox:/workspace/scratch/8719a7b4fdce/upload/local-global-tightness.txt).

The spectral lower bound already gives \(\chi(H)\ge6\): the Weil–Hoffman estimate is

\[
\chi(H)\ge1+\frac{84}{2\sqrt{83}}>5.
\]

Thus a six-colouring would settle the finite graph's chromatic number at exactly six. It would still leave the lower bound for \(F^2\) to be proved. In the source note's arithmetic analysis, it would also establish \(L(F)=6\), where \(L(F)\) is the best upper bound available from a single usable residue graph.

### A preliminary independent-set search

A colour class is an independent set: no two of its vertices are adjacent. Any six-colouring of \(H\) must contain a colour class of size at least

\[
\left\lceil\frac{6,889}{6}\right\rceil=1,149.
\]

This suggests first searching for an independent set with 1,149 vertices. It is a smaller target than partitioning all vertices into six independent sets, although it may still be difficult.

A floating-point Fourier computation of the adjacency spectrum gave

\[
\lambda_{\min}\approx-17.708727741963592.
\]

For a regular graph, Hoffman's independence bound is

\[
\alpha(H)\le
\frac{6,889(-\lambda_{\min})}{84-\lambda_{\min}},
\]

whose numerical evaluation is approximately \(1,199.4587694\). The required average class size, \(6,889/6\approx1,148.17\), is fairly close to this ceiling. That makes the search look constrained, but does not decide feasibility. These decimal values are exploratory numerical calculations; a proof relying on their precision would need certified eigenvalue bounds.

| Result | What it establishes |
| --- | --- |
| An independent set of size at least 1,149 | A necessary condition for six-colourability is met. A six-colouring still requires a partition. |
| A certified bound \(\alpha(H)\le1,148\) | \(H\) cannot be six-coloured, so \(\chi(H)\ge7\). |
| A verified six-colouring | \(\chi(H)=6\) and \(\chi(F^2)\le6\). |
| An unsuccessful search, or failure under imposed symmetry | No general impossibility result. |

In particular, proving \(\chi(H)\ge7\) would not prove a lower bound of seven, or even six, for \(F^2\) or the real plane. The homomorphism transfers upper bounds in the direction displayed above.

An independent-set certificate is a list of vertices, checked against the modular distance equation. A colouring certificate is a list of 6,889 colour labels, checked on all 289,338 edges. An impossibility claim needs a separate checkable proof; search failure alone is insufficient.

**Assessment.** This is a finite, well-specified upper-bound project with easily checked positive certificates. The 1,149-vertex independent-set search is a useful preliminary target, not a substitute for a full colouring.

If both projects succeed over \(F\), their conclusions combine to give

\[
6\le\chi(F^2)\le6,
\qquad\text{hence}\qquad
\chi(F^2)=6\quad\text{and}\quad\chi(\mathbb R^2)\ge6,
\]

without assuming local–global tightness.
