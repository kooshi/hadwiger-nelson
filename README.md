# Hadwiger–Nelson in Lean 4

**The problem.** How many colours are needed to colour every point of the plane so that two points at distance exactly 1
never get the same colour? This number, $\chi(\mathbb{R}^2)$, is the chromatic number of the plane. Since 1950 it has been
known to be 4, 5, 6 or 7. De Grey (2018) ruled out 4. In 2026 a manuscript released by OpenAI, with a Lean proof, ruled
out 5. So $\chi(\mathbb{R}^2)$ is 6 or 7, and deciding which is the open Hadwiger–Nelson problem.

**This repository** is a Lean 4 library, built on Mathlib, aimed at that problem. It has not solved it. The table below lists
what it has proved along the way that is its own, and how each result is checked. Most rows are about the plane over a field:
for a subfield $F \subseteq \mathbb{R}$, $F^2$ is the set of points whose two coordinates both lie in $F$, and $\chi(F^2)$ is
the least number of colours such that no two points of $F^2$ at distance 1 share a colour. Since $F^2$ is a subset of the
plane, $\chi(F^2) \le \chi(\mathbb{R}^2)$.

## What this project proved

**Status.** **Lean**: checked by Lean's kernel, using only Lean's three standard axioms. **Lean + W**, **Lean + W + EL**:
checked by the kernel, which also assumes, without proof, the published theorems named — **W** is Weil's 1948 bound for
Kloosterman sums, **EL** is Einsiedler and Lindenstrauss's 2022 rigidity theorem for commuting automorphisms of solenoids,
and **O5** (used further down) is OpenAI's 2026 theorem that the plane has no proper five-colouring. **hand**: proved on
paper, not yet formalized.

| Result | Status |
|---|---|
| **[1](#1-fields-that-need-exactly-five-colours)** $\chi(\mathbb{Q}(\sqrt{47})^2) = 5$, and four more fields need exactly five colours | Lean + W + EL |
| **[2](#2-the-chromatic-number-of-a-number-fields-plane-up-to-five)** $\chi(F^2) = L(F)$ whenever $L(F) \le 5$, for every real number field $F$ | Lean + W + EL |
| **[3](#3-exactly-when-three-colours-suffice)** $\chi(F^2) = 3$ $\iff$ some prime of $F$ has residue field $\mathbb{F}_3$ (for $F^2$ not bipartite) | Lean + W |
| **[4](#4-real-quadratic-fields-that-need-four-colours)** $\chi(\mathbb{Q}(\sqrt{m})^2) \ge 4$ for every $m \equiv 11 \pmod{12}$ | Lean |
| **[5](#5-a-quadratic-field-whose-plane-needs-as-many-colours-as-the-plane)** $\chi(\mathbb{Q}(\sqrt{635087})^2) = \chi(\mathbb{R}^2)$ | Lean + W + EL |
| **[6](#6-finite-graphs-and-measurable-sets-have-the-same-density)** $\alpha_1(\mathbb{R}^2) = m_1(\mathbb{R}^2)$ and $\chi_f(\mathbb{R}^2) = 1/m_1(\mathbb{R}^2)$ | Lean |
| **[7](#7-six-against-seven-as-a-stability-question)** $\chi(\mathbb{R}^2) \ge 7$ $\iff$ $\lim_{\varepsilon \to 0} \mu_6(\varepsilon) < 1$ | Lean |
| **[8](#8-one-bounded-disc-decides-it)** $\chi(\mathbb{R}^2) \ge 7$ $\iff$ some disc has no measurable 6-colouring proper at almost every unit pair | Lean |
| **[9](#9-the-p-adic-plane-needs-unboundedly-many-colours)** $\chi_{\mathrm{Bor}}(\mathbb{Q}_p^2) \ge 1 + \frac{p+1}{2\sqrt{p}}$ for $p \equiv 3 \pmod 4$: unbounded in $p$ | Lean + W |
| **[10](#10-three-colourings-of-lattice-cayley-graphs)** $\mathrm{Cay}(\mathbb{Z}^d, S)$ is 3-colourable $\iff$ some character $\theta$ has $\theta(S) \subseteq [\frac13, \frac23]$ | Lean |

The symbols, in one line each (each is defined in full in its row's section below):

- A *real number field* is a subfield of $\mathbb{R}$ of finite degree over $\mathbb{Q}$.
- $L(F)$: the least chromatic number among certain finite graphs on the residue fields of $F(i)$ (row 2).
- $\alpha_1$: the least ratio of independence number to size over finite point sets; $m_1$: the largest density of a
  measurable set with no two points at distance 1; $\chi_f$: the fractional chromatic number (row 6).
- $\mu_6(\varepsilon)$: the largest density that six measurable classes avoiding distances near 1 can cover (row 7).
- $\chi_{\mathrm{Bor}}(\mathbb{Q}_p^2)$: the least number of colours, with Borel colour classes, for the $p$-adic plane (row
  9).
- A *character* $\theta$ of $\mathbb{Z}^d$: a homomorphism $\mathbb{Z}^d \to \mathbb{R}/\mathbb{Z}$ (row 10).

What each Lean theorem behind rows 1–10 assumes is exactly what its status names: none takes a further unproved result as a
hypothesis. [`RESULTS.md`](RESULTS.md) gives each one's Lean name and its axioms as `#print axioms` prints them.

**On novelty.** For results of this project the page says "prior art: not found in print". That reports the literature
searches recorded in [`LEDGER.md`](LEDGER.md); it is not a claim of priority. Results that are other people's are listed
[further down](#other-peoples-results-that-the-library-checks), with their authors.

## The results

### 1. Fields that need exactly five colours

```math
\chi\big(\mathbb{Q}(\sqrt{47})^2\big) = 5
```

The same value holds for $\mathbb{Q}(\sqrt{143})$, $\mathbb{Q}(\sqrt{311})$, $\mathbb{Q}(\sqrt{335})$ and
$\mathbb{Q}(\sqrt3, \sqrt5)$, and $\chi(\mathbb{Q}(\sqrt{167})^2) \ge 5$.

- **In words.** Five colours suffice for the points of the plane with coordinates in $\mathbb{Q}(\sqrt{47})$, and four do
  not. Among real quadratic fields $\mathbb{Q}(\sqrt d)$ it is the one with the least $d$ that needs five: the table in [row
  4](#4-real-quadratic-fields-that-need-four-colours) gives at most four for every smaller $d$. Because
  $\mathbb{Q}(\sqrt{47})^2$ lies in the plane, this is also a proof that $\chi(\mathbb{R}^2) \ge 5$ that exhibits no graph.
- **Why it matters.** Moorhouse (2010, in conference slides) asked: "What about χ(ℚ(√47)²)?". Johnson (2006, p. 214) asked
  whether any $\mathbb{Q}(\sqrt m)^2$ needs more than four colours ("very interesting, if the answer is yes!"). Davies
  (October 2026, p. 5) lists $n \equiv 47, 143, 167 \pmod{168}$ as the open cases and asks whether any of them contains a
  five-chromatic unit-distance graph. And it answers in part Exoo and Ismailescu's (2019) question, "what is the smallest
  subfield of E² that requires 5 colors?": among real quadratic fields, it is $\mathbb{Q}(\sqrt{47})$.
- **A consequence.** $\mathbb{Q}(\sqrt{47})$ contains no $\sqrt3$, so its plane has no equilateral triangle of side 1; by the
  de Bruijn–Erdős theorem some finite triangle-free unit-distance graph in it needs five colours. That answers, without a
  construction, the existence half of Open Problem 55.1 in Soifer's book (2024), "Construct a triangle-free 5-chromatic
  unit-distance graph".
- **What it rests on.** The upper bound $\le 5$ is prior art: the plane maps to the finite plane $\mathbb{F}_{11}^2$, which
  needs five colours (Moorhouse 2010); it is checked on Lean's standard axioms alone. The lower bound is [row
  2](#2-the-chromatic-number-of-a-number-fields-plane-up-to-five) at these fields, so it assumes W and EL.
- **Prior art** for the lower bound: not found in print (`LEDGER.md` rows 121 and 123).
- **Not claimed.** An explicit five-chromatic graph; anything about six colours; more than $\ge 5$ at
  $\mathbb{Q}(\sqrt{167})$, where this project's conjecture predicts at least six.
- **By hand, not yet in Lean.** $\chi = 5$ for every squarefree $d \equiv 47, 143, 167 \pmod{168}$ with
  $L(\mathbb{Q}(\sqrt d)) = 5$: 44 of the 52 such $d$ below 3000.

### 2. The chromatic number of a number field's plane, up to five

Let $F$ be a real number field and $\mathcal{O}$ the ring of integers of $F(i)$. For each prime ideal $\mathfrak{P}$ of
$\mathcal{O}$ that complex conjugation maps to itself, form the finite graph on the residue field $\mathcal{O}/\mathfrak{P}$
that joins $x$ and $y$ when $(x - y)\,\overline{(x - y)} = 1$. Let $L(F)$ be the least chromatic number of these graphs.
$F^2$ has a graph homomorphism to each of them, so $\chi(F^2) \le L(F)$; this upper bound is due to Moorhouse (2010),
Manturov (2012) and Madore (2015). The theorem says it is exact up to five:

```math
\chi(F^2) = L(F) \quad \text{whenever } L(F) \le 5,
```

and, with no condition on $F$, $\min(\chi(F^2), 5) = \min(L(F), 5)$.

- **In words.** If some prime gives a residue graph that can be coloured with $k \le 5$ colours, $F^2$ needs exactly the
  least such $k$. If none does, $F^2$ needs at least five.
- **Why it matters.** Fischer (1990, §1) asked "whether some algebraic criterion can be found to determine the chromatic
  number of F² where F is a subfield of ℝ, of finite degree over ℚ"; Johnson repeated the question (2000, Problem 4.4). This
  answers it wherever $L(F) \le 5$, and decides for every real number field whether four colours suffice. This project
  conjectures that $\chi(F^2) = L(F)$ whenever $L(F) \le 6$, and in a bolder form that $\chi(\mathbb{R}^2) = 7$; the case
  $L(F) = 6$ and the bolder form are open.
- **What it rests on.** W and EL, declared as axioms. EL enters through a measure-rigidity theorem for the group of unit
  vectors of $F(i)$ (the $z$ with $z \bar z = 1$), which this project derived from EL; the derivation is checked in Lean.
- **Prior art.** The conjecture is this project's. The lower bound and the measure-rigidity theorem: not found in print
  (`LEDGER.md` row 123).
- **Not claimed.** Anything at $L(F) \ge 6$ beyond $\chi(F^2) \ge 5$.

### 3. Exactly when three colours suffice

Let $F$ be a real number field whose plane cannot be coloured with two colours. Then $\chi(F^2) = 3$ if and only if some
prime ideal of the ring of integers of $F$ has residue field $\mathbb{F}_3$, the field with three elements. Also
$\chi(F^2) \le 3 \iff L(F) \le 3$, and $\chi(F^2) = L(F)$ whenever $L(F) \le 4$.

- **Example.** In $\mathbb{Q}(\sqrt{11})$ the prime 3 stays prime and its residue field is $\mathbb{F}_9$, so three colours
  do not suffice for $\mathbb{Q}(\sqrt{11})^2$ (it needs exactly four, [row
  4](#4-real-quadratic-fields-that-need-four-colours)).
- **Why it matters.** It answers Fischer's and Johnson's question (row 2) at three colours, by looking only at how the prime
  3 factors in $F$, and extends Fischer's (1990) values for real quadratic fields to every real number field.
- **What it rests on.** W, used at one step. The direction "a prime with residue field $\mathbb{F}_3$ gives a
  three-colouring" needs only the standard axioms.
- **Credit and prior art.** The two-colour case for every real number field, and the three-colour case for fields that
  contain $\sqrt3$, are GPT Astra's, an OpenAI model's, from a conversation with this project's owner (2026-09-14). The
  general case: prior art not found in print (`LEDGER.md` row 99).
- **By hand, not yet in Lean.** Every three-colouring of such a plane comes from a single prime; and
  $\chi(\mathbb{Q}(\alpha, \sqrt7)^2) = 4$ for $\alpha^3 = \alpha + 1$.

### 4. Real quadratic fields that need four colours

For every positive integer $m \equiv 11 \pmod{12}$,

```math
\chi\big(\mathbb{Q}(\sqrt{m})^2\big) \ge 4 .
```

More generally, for every subfield $F \subseteq \mathbb{R}$: if $1/3$ lies in the ring generated by the unit vectors of $F^2$
(the points of $F^2$ at distance 1 from the origin, read as complex numbers) and $F^2$ cannot be 2-coloured, then
$\chi(F^2) \ge 4$ (and $\chi(F^2) \ne 3$ even without the second condition). With Fischer's values, this completes the table
for real quadratic fields up to four colours (in Lean as one theorem):

| squarefree $m$ | $\chi$ |
|---|:-:|
| $m \not\equiv 3 \bmod 4$ | 2 |
| $m \equiv 3, 7 \bmod 12$ | 3 |
| $m \equiv 11 \bmod 12$, except the next row | 4 |
| $m \equiv 47, 143, 167 \bmod 168$ | $\ge 4$ ([row 1](#1-fields-that-need-exactly-five-colours)) |

- **Why it matters.** Johnson (2006, p. 214) asked: "does there exist a positive integer m such that χ(G(ℚ²(√m), 1)) ≥ 4?".
  Yes: $m = 11$, and every $m \equiv 11 \pmod{12}$. Johnson (2000, p. 176) had called this family open, and Benda and
  Perles's Open Question (4) asks for the chromatic number of the plane over every algebraic extension of $\mathbb{Q}$.
- **What it rests on.** Lean's standard axioms only. For $\mathbb{Q}(\sqrt{11})$ the kernel also checks an explicit 204-point
  triangle-free unit-distance graph that cannot be 3-coloured.
- **Prior art.** The values 2 and 3 and every upper bound are Fischer's (1990, Theorems 8, 9 and 10(i)). For
  $m \equiv 23 \pmod{24}$ Fischer (Theorem 10(ii)) had the identity the proof uses, and concluded only that no *additive*
  colouring with few colours exists. The step to all colourings, and the lower bound four: not found in print (`LEDGER.md`
  rows 73 and 82).

### 5. A quadratic field whose plane needs as many colours as the plane

```math
\chi\big(\mathbb{Q}(\sqrt{635087})^2\big) = \chi(\mathbb{R}^2)
```

The same holds for $\mathbb{Q}(\sqrt3, \sqrt5, \sqrt7, \sqrt{11})$, the field of de Grey's graph. With OpenAI's 2026 theorem
that no proper five-colouring of the plane exists (assumed as **O5**, below),
$6 \le \chi(\mathbb{Q}(\sqrt{635087})^2) \le 7$.

- **The general statement.** $\chi(F^2) = \chi(\mathbb{R}^2)$ for every real number field $F$ that has a constant $c < 1/5$
  with this property: at every prime $\mathfrak{P}$ of $F(i)$ fixed by complex conjugation, and every $m \ge 1$, every
  non-trivial additive character of $\mathcal{O}/\mathfrak{P}^m$, summed over the elements of norm one, has absolute value at
  most $c$ times their number. Weil's bound gives such a $c$ for the two fields named, whose smallest conjugation-fixed
  primes lie above 103 and above 131.
- **In words.** The whole Hadwiger–Nelson problem lives in the plane over one real quadratic field. In outline: the small
  character sums keep a colouring of $F^2$ from exploiting any prime of $F$, EL rules out the one remaining escape, and what
  is left is a colouring of the whole plane, with as many colours, that is proper at almost every unit pair. By OpenAI's
  theorem, such colourings need $\chi(\mathbb{R}^2)$ colours.
- **Why it matters.** Benda and Perles (written in 1976, printed in 2000) showed that some number field's plane needs exactly
  $\chi(\mathbb{R}^2)$ colours, without naming one. Davies (2026, Theorem 1.1) proved
  $\chi(\mathbb{Q}^d) = \chi(\mathbb{R}^d)$ for $d \ge 5$, and wrote of the plane that "we suspect that a more complicated
  extension of ℚ² might be required". Here a real quadratic field suffices, given W and EL. Since $\mathbb{Q}(\sqrt{635087})$
  contains no $\sqrt3$, its plane has no unit equilateral triangle; with O5 and de Bruijn–Erdős (an argument outside Lean),
  some finite triangle-free unit-distance graph is six-chromatic.
- **What it rests on.** The general form: EL. The two fields: also W. The bounds 6 and 7: also O5.
- **Prior art.** The field equality: not found in print (`LEDGER.md` row 128). The equality it passes through, between
  $\chi(\mathbb{R}^2)$ and the measurable chromatic number, is OpenAI's.
- **By hand, not yet in Lean.** A density form for independent sets of $F^2$ (`LEDGER.md` row 129).

### 6. Finite graphs and measurable sets have the same density

```math
\begin{gathered}
\alpha_1(\mathbb{R}^2) = m_1(\mathbb{R}^2) \\
\chi_f(\mathbb{R}^2) = 1/m_1(\mathbb{R}^2)
\end{gathered}
```

Here $\alpha_1(\mathbb{R}^2)$ is the infimum, over finite non-empty point sets $S$ of the plane, of
$\alpha(S)/\lvert S \rvert$, where $\alpha(S)$ is the size of the largest subset of $S$ with no two points at distance 1;
$m_1(\mathbb{R}^2)$ is the supremum of the upper densities of measurable sets with no two points at distance 1; and $\chi_f$
is the fractional chromatic number. The same holds over the algebraic plane (points with algebraic coordinates), and
$f(n)/n \to m_1(\mathbb{R}^2)$, where $f(n)$ is the least independence number of a unit-distance graph on $n$ points of the
plane.

- **Why it matters.** It proves the first clause of Dúcz and Varga's Conjecture 1 (2026), and answers the question Matolcsi,
  Ruzsa, Varga and Zsámboki (2025, §2) call open, whether $\chi_f(\mathbb{R}^2) = 1/m_1(\mathbb{R}^2)$; Johnson had posed it
  earlier (1996; 2000). With the known bounds on $m_1(\mathbb{R}^2)$ (at least 0.2293, Croft 1967; at most 0.2470, Ambrus,
  Csiszárik, Matolcsi, Varga and Zsámboki 2023), it puts $\chi_f(\mathbb{R}^2)$ between about 4.05 and 4.36.
- **What it rests on.** Lean's standard axioms only. The key step is OpenAI's rigidity theorem (Theorem 2.3 of their
  manuscript), whose Lean proof was ported into this library and checked again here.
- **Prior art.** For the plane: not found in print (`LEDGER.md` row 129). Davies (2026, Theorem 1.1) proves the same equality
  in dimensions four and up.
- **Not claimed.** Any value of $m_1(\mathbb{R}^2)$, or that it equals Croft's constant (Dúcz and Varga's second clause).

### 7. Six against seven, as a stability question

```math
\chi(\mathbb{R}^2) \ge 7 \iff \lim_{\varepsilon \to 0} \mu_6(\varepsilon) < 1
```

Here $\mu_6(\varepsilon)$ is the largest upper density that six disjoint measurable sets can cover when, inside each set, the
pairs of points at distance between $1 - \varepsilon$ and $1 + \varepsilon$ form a null set. It grows as $\varepsilon$
shrinks; Lean states the limit as the supremum over $\varepsilon > 0$.

- **In words.** The plane can be coloured with six colours exactly when six classes, each avoiding a thin band of distances
  around 1, can cover the plane up to holes whose density tends to 0 as the band narrows. Seven colours are needed exactly
  when the holes cannot shrink to nothing. This turns a question about arbitrary colourings into one about measurable sets
  with a little room to spare.
- **What it rests on.** Lean's standard axioms only, through OpenAI's transfer theorem (a colouring of the plane gives a
  Borel one proper at almost every unit pair), whose proof is ported into this library.
- **Prior art.** Not found in print as an equivalence (`LEDGER.md` row 131). Sokolov and Voronov (2025, §9) state the
  conditional form.

### 8. One bounded disc decides it

$\chi(\mathbb{R}^2) \ge 7$ if and only if, for some $R > 0$, the open disc of radius $R$ about the origin has no
Borel-measurable colouring with six colours that is proper at almost every unit pair inside the disc. More generally, for
every $k$, the plane can be $k$-coloured exactly when every such disc has such a $k$-colouring.

- **In words.** A proof of seven needs to rule out these weak six-colourings on one bounded disc. A proof of six needs them
  on discs of every radius, with no colouring of the whole plane.
- **What it rests on.** Lean's standard axioms only; the direction toward seven goes through OpenAI's transfer theorem.
- **Prior art.** Partly: for the whole plane the argument is Gwyn and Stavrianos's (2022, Lemma 2); the bounded case for
  proper colourings is Kruskal's (2008); the direction toward seven is OpenAI's transfer theorem restricted to a disc. The
  disc form for weak colourings: not found in print (`LEDGER.md` row 161).

### 9. The p-adic plane needs unboundedly many colours

For a prime $p \equiv 3 \pmod 4$, join two points $x, y$ of $\mathbb{Q}_p^2$ when $Q(x - y) = 1$, where
$Q(v) = v_1^2 + v_2^2$ (for these $p$ the form $Q$ has no non-trivial zero over $\mathbb{Q}_p$). Every colouring of this
graph whose colour classes are Borel sets uses at least

```math
1 + \frac{p + 1}{2\sqrt{p}}
```

colours, so the Borel chromatic number $\chi_{\mathrm{Bor}}(\mathbb{Q}_p^2)$ is not bounded as $p$ varies. Its values are 3,
4, 5 and 5 at $p = 3, 7, 11, 19$, and $5 \le \chi_{\mathrm{Bor}}(\mathbb{Q}_{23}^2) \le 8$.

- **Why it matters.** Bardestani and Mallahi-Karai (2017, Question 1) asked whether one constant bounds
  $\chi_{\mathrm{Bor}}(\mathbb{Q}_p^2)$ for all such $p$; their own method gives $O(p^2)$. The answer is no.
- **What it rests on.** The bound, and the value at 3: W. The values at 7, 11 and 19 and the bounds at 23: Lean's standard
  axioms only. The proof applies Hoffman's ratio bound to the finite graphs on $(\mathbb{Z}/p^k)^2$, at every level $k$; it
  does not use the posers' spectral theorem.
- **Prior art.** The lower bound, the answer and the lower halves of the values: not found in print (`LEDGER.md` row 75;
  zbMATH listings of both posers and abstract queries were searched; MathSciNet and the Russian-language literature were
  not). The upper halves come from Madore's construction (2015) with the known values of the finite planes (Moorhouse 2010).
- **Not claimed.** The chromatic number of $\mathbb{Q}_p^2$ with no measurability required, which stays open. At $p = 23$ an
  exact certificate, checked by a separate program and joined to the statement by hand, gives $\chi_{\mathrm{Bor}} \ge 6$.

### 10. Three-colourings of lattice Cayley graphs

Let $\Lambda \cong \mathbb{Z}^d$ and let $S = -S$ be a finite generating set. Then the Cayley graph
$\mathrm{Cay}(\Lambda, S)$ can be 3-coloured if and only if some homomorphism $\theta : \Lambda \to \mathbb{R}/\mathbb{Z}$
maps every element of $S$ into $[\frac13, \frac23]$, if and only if it has a periodic 3-colouring (one invariant under a
subgroup of finite index). Periodic 3-colourings are dense among all 3-colourings, so two vertices that every periodic
3-colouring colours alike are coloured alike by every 3-colouring.

- **Why it matters.** Ellenberg (MathOverflow, 2018) asked whether a $k$-colourable graph of this kind always has a periodic
  $k$-colouring: "I don't even know how to do this for A = Z!". Gibbs and Mixon asked related questions on the Polymath16
  project (2018), and Chandgotia, Gangloff, Hellouin de Menibus and Oprocha (2025, Question 6.2) carry the question as open.
  This answers it at three colours, and with it Abrishami et al.'s Problem 4.6 (2025) at three colours for these graphs. At
  four colours it is open.
- **Status.** Checked by Lean's kernel on the standard axioms alone, in a wider class than stated here: the criterion for
  every abelian group and every finite or infinite step set without $0$, the periodic form for every finitely generated
  group with finitely many steps, and density for every finite generating set, torsion allowed. The clause about which
  colourings are rigid is in Lean too; the statement about the cells of the set of such $\theta$ is proved by hand only.
- **Prior art.** The lift of a 3-colouring to integer heights is Chandgotia's device; density at the standard generators is
  expected folklore and is not claimed. The criterion for arbitrary generating sets: not found in print (`LEDGER.md` row 79); for the wider class the Lean
  proof covers, prior art not yet searched.
  Not read: the rest of two of those papers' reference lists, and the literature on homomorphism shifts with non-standard
  generating sets beyond the queries run.

### Also proved by hand

Most of this project's recent work is about six against seven: partial results, proved by hand, on measurable six-colourings
of the plane, such as where their colour classes can meet and what a boundary along a unit circle forces. Most have a single
derivation, not yet repeated independently, and none of them decides the problem. [`ROADMAP.md`](ROADMAP.md) lists them, with
everything else not yet formalized.

## Other people's results that the library checks

The library also proves these known results. In each case the theorem is its authors' and the Lean proof is this project's.
All are checked on Lean's standard axioms alone, except $6 \le \chi(\mathbb{R}^2) \le 7$, which also assumes O5.

| Result | Whose |
|---|---|
| $\chi(\mathbb{R}^2) \ge 4$ | classical: the Moser spindle |
| $5 \le \chi(\mathbb{R}^2) \le 7$ | de Grey (2018) and Heule's smaller graphs (2018); the seven-colouring is classical |
| $6 \le \chi(\mathbb{R}^2) \le 7$ | OpenAI (2026); Lean + O5 |
| $\chi(\mathbb{R}^2) = \chi_m^0(\mathbb{R}^2)$ | OpenAI (2026, Theorem 1.3) |
| $\chi_m^0(\mathbb{R}^2) = \chi_m(\mathbb{R}^2)$ | Davies (2026, Lemma B.1) |
| $m_1(\mathbb{R}^2) \le 0.2470$ | Ambrus, Csiszárik, Matolcsi, Varga, Zsámboki (2023) |
| $\chi(\mathbb{Q}(\sqrt3, \sqrt{11})^2) = 4$ | Fischer (1994) |
| $\chi(F^2) \le L(F)$ | Moorhouse (2010), Manturov (2012), Madore (2015) |
| $\chi(\mathbb{Q}^2) = 2$ | Woodall (1973) |
| $\chi(F(t)^2) = \chi(F^2)$, $t$ transcendental | Fischer (1990, Theorem 6) |

- $\chi_m^0(\mathbb{R}^2)$ is the least $k$ for which some Borel $k$-colouring of the plane is proper at almost every unit
  pair; $\chi_m(\mathbb{R}^2)$ is Falconer's measurable chromatic number, with Lebesgue-measurable colour classes and proper
  at every unit pair. The direction $\chi \le \chi_m^0$ is argued in print by Gwyn and Stavrianos (2022).
- **What is this project's in these proofs.** For the five-colour bound, the kernel checks the graphs' non-colourability
  through a checker it can run for LRAT, a format for SAT solvers' refutation proofs. For the seven-colouring, "the colouring
  is classical; ours is the certificate". For $\mathbb{Q}(\sqrt3, \sqrt{11})$ the Lean proof uses a different four-colouring
  from Fischer's, with values in $\mathbb{F}_4$ rather than $\mathbb{Z}/4$. For the density bound it starts from the paper's
  own certificate and needs no citation of Bessel-function facts.
- **OpenAI's results** come from their Lean development (family 158 of their 2026 manuscript collection), which was built and
  audited here. Its theorem that no proper five-colouring exists enters as an axiom (O5). Its transfer theorem and its
  rigidity step enter as theorems: their proofs are ported into this library and checked by this kernel.

## What the library assumes

Every theorem here reduces to what Lean's kernel checked plus what this section lists.

- **Lean's three standard axioms**: `propext`, `Classical.choice`, `Quot.sound`.
- **Three published theorems, declared as axioms.** Each is stated in its source's own form and read back against the source,
  has a model of its hypotheses in its file, and is listed in [`ARCHITECTURE.md`](ARCHITECTURE.md) § 5:
  - **W**, `StandingFive.kloosterman_bound`: Weil's bound for Kloosterman sums (Weil 1948, p. 207). Over a finite field of
    characteristic not 2, with $\psi$ a non-trivial additive character and $4cd = a \ne 0$,
    $\lVert \sum_{x \ne 0} \psi(cx + dx^{-1}) \rVert \le 2\sqrt q$.
  - **EL**, `Rigidity.positive_entropy_rigidity`: Einsiedler and Lindenstrauss's positive-entropy rigidity for
    $\mathbb{Z}^d$-actions ($d \ge 2$) on solenoids with no virtually cyclic factors (2022, Theorem 1.3).
  - **O5**, `Outside.OAI158.no_proper_five_coloring`: no map $\mathbb{C} \to$ `Fin 5` gives different colours to every two
    points at distance 1 (OpenAI 2026, family 158). The axiom's statement is the release's stored statement, term for term.
- **Two further pieces of OpenAI's release are proved, not assumed**: its transfer theorem
  `Outside.OAI158.proper_to_borel_weak` and its rigidity step `Outside.OAI158.Spectral.residual_fourier`. Their proofs are
  ported into `Proofs/HadwigerNelson/Outside/`, keep the release's Apache 2.0 licence
  (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), and are checked by this kernel.
- **Five native-evaluation purchases.** Five declarations use `native_decide`, so they trust Lean's compiler rather than its
  kernel. All five are in `Instances/SpindleBound.lean`; they cross-check the SAT encoding on the Moser spindle, and no
  theorem on this page rests on them.
- **Hypotheses.** Some theorems take an outside result, or a result of this project not yet formalized, as an explicit
  hypothesis ("if Herglotz–Bochner holds, then …"). Such a theorem prints only the standard axioms, so
  `scripts/assumptions.sh` lists every one: 33 hypotheses (7 standing for outside theorems, 21 for hand results of this
  project, 5 for open questions), taken in 109 (hypothesis, theorem) pairs. No theorem on this page or in
  [`RESULTS.md`](RESULTS.md) takes one.

**The audit at the last gate** (2026-10-16) checked 11,466 records: 10,804 rest on some of the standard three axioms and
nothing else, 574 on no axiom at all, 83 on at least one of W, EL and O5, and 5 are the purchases. No record rests on
`sorry`. The independent replay `lean4checker` has not been run on the current tree; it is the publication gate
([`ROADMAP.md`](ROADMAP.md) § 5), and landing W, EL and O5 themselves in Lean is listed there too.

## How to check it

**Toolchain.** Lean `v4.32.0` and Mathlib at tag `v4.32.0`, pinned by `lean-toolchain` and `lakefile.toml`. Install
[elan](https://github.com/leanprover/elan) (`./install-toolchain.sh` does it), then fetch Mathlib's prebuilt files:

```bash
lake exe cache get
```

**Build.** Use `./scripts/build.sh`, never a bare `lake build`. Some modules peak near 9 GB of memory, and Lake sizes its job
pool from the machine, so an unbounded build can ask for hundreds of gigabytes. The script builds modules in dependency
order, in batches of `BATCH` (default 10), each under a memory cap of `MEMMAX` (default `100G`). It needs Linux with
`systemd` user scopes and `python3`. Set both variables for your machine:

```bash
BATCH=2 MEMMAX=24G ./scripts/build.sh
```

`./scripts/build.sh --plan` prints the batches and builds nothing. On Arch Linux, run `source scripts/dev-env.sh` first: the
toolchain's bundled `clang` fails against Arch's system LLVM.

**The gate**, after a build. Each step is a script with a `--self-test` that plants faults and checks that every one is
caught.

- `./scripts/axioms.sh` — every public declaration's `#print axioms` (in `scripts/Axioms.lean`), checked as a set against its
  section: clean, imported (declared outside theorems only), or purchased.
- `./scripts/assumptions.sh` — every hypothesis that stands for an outside or unformalized result is declared with its
  source, and every theorem taking it is listed.
- `./scripts/vacuity.sh` — no theorem is a `∀` over an empty domain: where a binder's domain could be empty, the library
  exhibits an inhabitant or declares the emptiness with its reason.
- `./scripts/dupnames.sh` — no name is declared by two modules (Lean can merge two such theorems silently at import).
- `lake lint --no-build -- --no-build` — Mathlib's environment linters, on the built library.

**One theorem by hand.** Put this in a file and run `lake env lean <file>`:

```lean
import Proofs
#check @HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
```

`lake env lean` does not apply the lakefile's options, so `autoImplicit` is not off unless you pass `-DautoImplicit=false`.
Use it to read statements, not to decide that a module is green.

## Layout

- `Proofs/HadwigerNelson/` — the library (about 2,170 files, many of them generated certificate data). `Plane/` holds the
  measurable and regularity results; `Arith/`, `Rigidity/`, `Collapse/` and `SpectralChain.lean` the number-field results;
  `PadicPlane/` the $p$-adic plane; `Instances/` the concrete graphs and fields; `Outside/` the imported and ported parts of
  OpenAI's release; `Sat/` the refutation checker the kernel runs. Every name is under the namespace `HadwigerNelson`.
- `Proofs.lean` — the import surface.
- [`RESULTS.md`](RESULTS.md) — every result on this page with its Lean names, its axioms as printed, its sources and full
  references.
- [`ROADMAP.md`](ROADMAP.md) — everything not yet formalized: hand results, computations outside the kernel, the assumed
  theorems.
- [`LEDGER.md`](LEDGER.md) — one row per result (167 rows): its grade, where it lives, its prior art, and a claim list of
  what is this project's and what is not. A row the ledger marks `[hand]`, `[tools]` or `[cert]` is not, or not wholly, in
  the kernel.
- [`CLOSED-QUESTIONS.md`](CLOSED-QUESTIONS.md) — the questions posed in print that this project answered, quoted, with the
  prior art that limits each answer.
- [`BIBLIOGRAPHY.md`](BIBLIOGRAPHY.md) — every cited work, what rests on it, and how much of it was read. Its § E translates
  this project's working terms (for example "usable prime", "local bound", "stable prime", used in `plans/` and in
  docstrings) into the literature's, where the literature has them.
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — the module map, checked against the import graph, and § 5, Trust.
- [`LEAN.md`](LEAN.md) — the repository's Lean conventions: the build, the gate, the kernel's cost model, how outside
  theorems are imported.
- `scripts/` — the build and the gate.
- `tools/` — generators and instruments in Python. Nothing in `tools/` is trusted: a generator bug can only produce data the
  kernel refuses.
- `plans/` — the working records: one file per milestone, derivation and job; `plans/FRONTIER-STUBS.md` ranks the open
  questions.
- [`CLAUDE.md`](CLAUDE.md) — the context every agent shares: the project's current state, its rules and its working theory.
- `data/` — the jobs' inputs and outputs: certificates, briefs, reports, logs of gate runs.
- `visualizations/` — interactive pages for some of the objects.

## How it was made

The project's own account (`CLAUDE.md` § Whose work this is):

> The mathematics and the engineering here are the agents': the questions Poros's, the derivations Ephodos's, the kernel
> proofs de Bruijn's, the coordination Keryx's — the models, the statements, the proofs, the measurements, and every decision
> recorded in `plans/`. Kooshi set the target, built the method this project runs on (the identities […], with the workflow
> beneath each; the skill suite), supplies the machines, and interrupts when a mind runs ahead of the workflow.

The agents are AI models (Anthropic's Claude), each running in one of the roles defined in `.claude/agents/`. A milestone
closes only when its Lean module passes the gate above, so the kernel is the second check on every derivation. The history
begins on 2026-07-22.

**The agent identities and the workflow files under `.claude/` are Kooshi's contribution.** In his words, they "derive from
my brainchild Ferrous", his agent identity for Rust engineering, which is public under the MIT licence at
<https://github.com/kooshi/rusty-tools-mcp> (the file `FERROUS.md`; that repository is dual-licensed MIT and Apache-2.0).
Their text, like everything else here, was written with Claude.

## Licence

Apache License 2.0: see [`LICENSE`](LICENSE). The files ported from OpenAI's release under `Proofs/HadwigerNelson/Outside/`
keep that release's own Apache 2.0 licence, whose text is beside them
(`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), and each carries its notice of change in its header.

Other authors' documents that the project read (papers, their transcriptions, saved web pages, the journal *Geombinatorics*'s
material) are not in this repository or its history; the records that cite them keep their old paths.
