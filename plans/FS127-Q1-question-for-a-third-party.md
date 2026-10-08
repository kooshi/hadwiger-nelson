# Does every measurable colouring of the plane that avoids the unit distance almost everywhere have a point that behaves like a vertex?

*A question for a reader outside our project. It is self-contained: nothing below needs access to our files.
8 October 2026.*

## 0. The question in brief

Colour the plane with $k$ colours by a Lebesgue measurable map, so that almost every pair of points at distance 1
receives two different colours. If the colour classes were the tiles of a map, three tiles would meet at a vertex, and a
classical argument would say, for each of the three edges at that vertex, that neither of the edge's two colours occurs
in an explicit open region along the unit circle about the vertex. **We ask whether every such colouring, however
irregular, has a point at which that conclusion holds for some cycle of at least three colours** (Question 1, § 2).

We have proofs — by hand, and not independently checked — when a certain closed set of exceptional points is finite in
a disc, and when three colours leave room along one unit circle. In general we can neither prove nor refute it. Three attempts stalled, each at a step stated in
§ 6. The case that matters is $k = 6$; a counterexample with $k \ge 7$ would also tell us something.

Why we ask. The chromatic number of the plane is 6 or 7, and it is the least $k$ for which a colouring of the above kind
exists ([NFC], Theorems 1.1 and 1.3; § 4). Our statements about measurable six-colourings begin "if the colouring has a
point with such-and-such data on its unit circle". Whether every colouring has such a point is the step asked here. A
proof would not by itself decide between 6 and 7 (§ 8).

**Status marks used below.** *Printed*: stated in a cited work; we say what the work states. **[hand, one mind,
unchecked]**: derived by hand by a single mind in our project and not independently checked — treat it as a claim. Other
marks are explained where they occur. Question 1 is a statement about measurable sets and rests on none of our results.

## 1. Setting and definitions

Notation: $|E|$ is the Lebesgue measure of a plane set $E$; $B(z, r)$ is the open disc; $S^1$ is the unit circle with
arc-length measure $\sigma$; $R$ is the rotation by $\pi/3$. Colours are also called *labels*.

**Definition 1 (weak measurable colouring; [NFC], Definition 1.2).** Let $k \ge 1$. A *weak measurable $k$-colouring* of
the plane is a Lebesgue measurable map $c : \mathbb R^2 \to \{1, \dots, k\}$ such that
$$\{(x, u) \in \mathbb R^2 \times S^1 : c(x) = c(x + u)\}$$
is a null set for Lebesgue measure times $\sigma$. Its *classes* are $A_i = c^{-1}(i)$. Changing $c$ on a null set
changes nothing below. A colouring that is *proper* (no two points at distance 1 share a colour) and has measurable
classes is a weak measurable colouring; the converse fails.

**Definition 2 (essential support).** $H_i = \{z : |A_i \cap B(z, r)| > 0 \text{ for every } r > 0\}$, a closed set.

**Definition 3 (straddling region; [NFC], § 7).** For a non-empty compact set $K$,
$$\Delta(K) = \{z : \min_{q \in K} |z - q| < 1 < \max_{q \in K} |z - q|\},$$
an open set. If $K$ is connected, every point of $\Delta(K)$ is at distance exactly 1 from some point of $K$. For two
points we write $\Delta(p, q) = \Delta(\{p, q\})$: the points lying in one of the open unit discs about $p$ and $q$ and
strictly outside the other closed disc. For $0 < |p - q| < 2$ it is a pair of open lunes, of width at most $|p - q|$,
lying along the two unit circles.

**Definition 4 (witnesses).** Let $c$ be a measurable colouring, $p$ a point and $a \ne b$ two labels. A point $q \ne p$
*witnesses the pair $\{a, b\}$ at $p$* if
$$|A_a \cap \Delta(p, q)| = |A_b \cap \Delta(p, q)| = 0,$$
equivalently if $H_a$ and $H_b$ are both disjoint from $\Delta(p, q)$. The *witness graph* $W_p$ is the graph on the
labels whose edges are the pairs witnessed at $p$ by some point. A *witnessed cycle at $p$* is a cycle of $W_p$:
distinct labels $i_0, \dots, i_{\ell-1}$ with $\ell \ge 3$, and points $q_0, \dots, q_{\ell-1}$ other than $p$, such
that $q_j$ witnesses $\{i_j, i_{j+1}\}$ at $p$ for every $j$ modulo $\ell$. The points $q_j$ need not be distinct or close
to $p$.

*Where the definition comes from.* Suppose two connected open sets $T_a$, $T_b$ carry the labels $a$, $b$ almost
everywhere and their closures share two points $p \ne q$ (tiles of a map with a common edge through $p$). Then $q$
witnesses $\{a, b\}$ at $p$: a point $z \in \Delta(p, q)$ is at distance exactly 1 from a point of a path in $T_a$
running from near $p$ to near $q$, and almost-everywhere properness then forbids the label $a$ near $z$ (statement P1
in § 5; [NFC], § 7, names [SV], Propositions 1–2, as the precedent, for interfaces that come from a regular map). So at
a vertex where three tiles meet pairwise along edges there is a witnessed triangle. A witnessed cycle is what remains of "a vertex with
its edges" when there is no map. The difficulty is that a measurable class need not contain any connected piece.

**Further definitions, used in the variants and in § 6.**

*Disc averages* ([NFC], § 7). $p_i^\varepsilon(z) = |A_i \cap B(z, \varepsilon)| / (\pi \varepsilon^2)$. These are
continuous, non-negative, and sum to 1 at every point. For $\alpha > 0$ we call the open set
$\{p_i^\varepsilon > \alpha\}$ a *smoothed class* of the label $i$.

*Transition graph and cyclic centres* ([NFC], Definition 6.1 and Theorem 6.5). For distinct labels $i, j$, a ball $B$
and a vector $h$, let $D_{ij}(B, h) = |\{q \in B : \{c(q), c(q + h)\} = \{i, j\}\}|$. The *transition graph* $\Gamma_x$
of a point $x$ is the graph on the labels in which $ij$ is an edge exactly when
$\limsup_{h \to 0} D_{ij}(B, h)/|h| > 0$ for every ball $B$ centred at $x$. A *cyclic centre* is a point $x$ whose
$\Gamma_x$ contains a cycle; $\mathcal L$ denotes the set of cyclic centres. It is closed (the set of points at which a
given pair is an edge is closed; [NFC], § 6).

*Palettes* ([NFC], Definition 5.1). A point is *typical* if it is a Lebesgue density point of the class of its own
label. A pair $(y, r)$ is a *typical circle sampling* if $y + re$ is typical for almost every $e \in S^1$. A *trace* at
$x$ is a weak-$*$ limit in $L^\infty(S^1; \mathbb R^k)$ of the functions $e \mapsto (1_{A_i}(y_n + r_n e))_{i}$ along
typical circle samplings with $y_n \to x$ and $r_n \to 1$. The *palette* $P_x(e)$ is the set of labels $i$ such that
some trace $b$ at $x$ has $b_i(e) > 0$ (an essential union, defined for almost every direction $e$).

[NFC] states Definitions 5.1 and 6.1 for five labels; we use the same words for $k$ labels.

## 2. The question

**Question 1 (existence of a witnessed cycle).** *Is the following true? For every integer $k \ge 1$, every weak
measurable $k$-colouring of the plane and every closed disc $D$ of radius greater than 1, there are a point $p \in D$,
an integer $\ell \ge 3$, distinct labels $i_0, \dots, i_{\ell-1}$ and points $q_0, \dots, q_{\ell-1}$ other than $p$
such that, for each $j$ modulo $\ell$, the closed essential supports $H_{i_j}$ and $H_{i_{j+1}}$ are both disjoint from
$\Delta(p, q_j)$.*

In the words of Definition 4: every closed disc of radius above 1 contains a point with a witnessed cycle.

**The same question as a search for a counterexample.** *Is there, for some $k$, a weak measurable $k$-colouring of the
plane and a closed disc $D$ of radius greater than 1 such that the witness graph $W_p$ is a forest at every point $p$ of
$D$?*

Remarks on the quantifiers.

- *The number of colours.* For $k \le 5$ no weak measurable $k$-colouring exists ([NFC], Theorem 1.4; a colouring with
  fewer colours is one with five), so the statement is empty. For $k \ge 7$ such colourings exist (the hexagonal
  colouring, § 7), and the statement holds for every one we can write down (by P1 or P4 of § 5). For $k = 6$ no such colouring is known and
  none is excluded; if none exists the statement is empty at six, and showing that none exists is the Hadwiger–Nelson
  problem itself. The useful answers are therefore a proof
  that does not need to know whether six-colourings exist (for all $k$, or for $k = 6$ from properties any such
  colouring must have), or a counterexample at some $k \ge 7$.
- *The disc.* The radius 1 is where our one unconditional result lives (P2 in § 5: every closed disc of radius above 1
  contains a cyclic centre). The weaker statement with "some point of the plane" in place of "some point of $D$" would
  serve our purpose equally, and we cannot prove that either. A counterexample needs only one disc.
- *What is not asked of $p$.* Nothing says the labels $i_j$ occur near $p$, and nothing says $p$ is a cyclic centre.
  This is deliberate: the consequences we draw from a witnessed cycle (§ 5, P7 and P8) use the points $q_j$ and nothing
  else. It has a cost: the statement is true for cheap reasons wherever a colouring leaves *room* — three labels whose
  supports avoid an annulus about the unit circle of $p$ (P4) — at points where nothing meets. The variants below ask
  for more.

## 3. Variants

Each variant is open to us in general. The implications stated are one-line consequences of the definitions unless a
statement of § 5 is named.

**Variants of the data at the point.**

- **(1a) Anchored.** In Question 1 require also that $p \in H_{i_j}$ for every $j$ and
  $q_j \in H_{i_j} \cap H_{i_{j+1}}$ for every $j$: the labels are present where they are witnessed. (1a) implies the
  statement of Question 1.
- **(1b) Connected pieces.** Say that $q$ is *reached from $x$ in label $i$* if there are $\alpha > 0$, a sequence
  $\varepsilon_n \to 0$ and connected sets $C_n$ with $p_i^{\varepsilon_n} > \alpha$ at every point of $C_n$, such that
  both $x$ and $q$ are limits of sequences $z_n \in C_n$. *Does every closed disc of radius above 1 contain a point $x$
  and a cycle of labels $i_0, \dots, i_{\ell-1}$ such that for each $j$ some $q_j \ne x$ is reached from $x$ in both
  $i_j$ and $i_{j+1}$?* By P5 this implies the statement of Question 1. It is the step at which our third attempt
  stopped.
- **(1c) Continua.** *Does every closed disc $D$ of radius above 1 contain a point $x$ with a radius $\rho > 0$, distinct
  labels $i_0, \dots, i_{\ell-1}$ ($\ell \ge 3$) and compact connected sets $K_j \subset \overline{B(x, \rho)}$ such that
  $x \in K_j$, $K_j$ meets the circle $\partial B(x, \rho)$, and $H_{i_j}$ and $H_{i_{j+1}}$ are both disjoint from
  $\Delta(K_j)$, for every $j$ modulo $\ell$?* This implies the statement of Question 1 (take
  $q_j \in K_j \cap \partial B(x, \rho)$ and use $\Delta(x, q_j) \subset \Delta(K_j)$). We can prove it when
  $\mathcal L \cap D$ is finite (P3); it is the statement our first attempt could not prove without that hypothesis.
- **(1d) Finiteness.** *Is the set $\mathcal L$ of cyclic centres of every weak measurable six-colouring locally finite?*
  With P3 this would give (1c). For five colours it is [NFC], Theorem 6.5 (a statement about a class that Theorem 1.4
  then shows to be empty). For seven colours it is false (§ 7, Example B). Weaker hypotheses on $\mathcal L \cap D$ that
  would still give (1c) — for instance "countable" — are open to us (§ 6, attempt 1).

**A variant of the class of colourings.** A *set with null unit pairs* is a measurable set $T$ with
$(\mathrm{Leb} \otimes \sigma)\{(x, u) : x \in T,\ x + u \in T\} = 0$. A *measurable Grundy $k$-colouring* is a
partition $(A_1, \dots, A_k)$ of the plane, up to a null set, into sets with null unit pairs, in which $A_1$ is maximal
(under inclusion up to null sets) among sets with null unit pairs and each $A_m$ is maximal among sets with null unit
pairs contained in the complement of $A_1 \cup \dots \cup A_{m-1}$. It is the measurable form of a greedy colouring.

- **(2) Grundy colourings.** *Do Question 1 and its variants (1a)–(1d) hold for measurable Grundy colourings?* By P9
  every weak measurable $k$-colouring can be turned into a measurable Grundy $k$-colouring, so for our purpose the
  restricted class would be enough. Nothing we hold decides any of them in this class; in particular we do not know
  whether a measurable Grundy seven-colouring can have cyclic centres accumulating at a point. The hexagonal colouring
  with $r = 2/5$ and Examples B and C of § 7 are not Grundy colourings (§ 7, item 10), so they do not test this class.

**A different question behind the same step.**

- **(3) A longer cycle.** A witnessed triangle is not known to be contradictory at six colours; the exclusion we state
  in § 5 (P8) is about a witnessed four-cycle. So "data that can be used" has a stronger reading: *is there a radius
  $R_0 > 1$ such that, for every weak measurable six-colouring and every closed disc $D$ of radius $R_0$ containing
  finitely many cyclic centres, the conclusion of P3 holds at some point of $D$ with $\ell \ge 4$?* This is what our
  second attempt aimed at. It is a different statement from Question 1: it assumes what (1d) asks, and asks for more.

## 4. What you may assume: printed results

[NFC] is a preprint accompanied by a formalization in Lean 4. We compiled that formalization from source; its headline
theorem (no proper five-colouring of the plane) and the direction "a proper $k$-colouring gives a weak measurable one"
of Theorem 1.3 are accepted by Lean's kernel on the three standard axioms. We read the manuscript in full once and
found no gap.

- **T1 ([NFC], Theorem 1.3).** For every $k$, a proper $k$-colouring of the plane exists if and only if a weak
  measurable $k$-colouring exists. (The direction "weak measurable gives proper" is proved in [NFC] from T3, a
  translation and the de Bruijn–Erdős theorem [dBE]. It is not part of [NFC]'s Lean formalization; a Lean proof of it is
  in our own library.)
- **T2 ([NFC], Theorems 1.1 and 1.4).** There is no weak measurable five-colouring of the plane; consequently
  $6 \le \chi(\mathbb R^2) \le 7$.
- **T3 ([NFC], Lemma 4.3).** In a weak measurable $k$-colouring, the set of density points of each class contains no two
  points at distance 1; these sets are disjoint and their union has full measure.
- **T4 ([NFC], Lemma 7.2).** $p_i^\varepsilon(q) + p_i^\varepsilon(z) \le 1$ for **every** pair $q, z$ with
  $|q - z| = 1$, every label $i$ and every $\varepsilon > 0$; and if $q_n \to q$, $\varepsilon_n \to 0$ and
  $\liminf p_i^{\varepsilon_n}(q_n) > 0$ then $q \in H_i$. (Stated in [NFC] in a section that assumes five colours; the
  proof given there does not use the number of colours, and the accompanying Lean statement of the inequality is for
  every $k$.)
- **T5 ([NFC], Proposition 7.1, with Lemmas 7.3–7.8).** For a weak measurable five-colouring (the proof works on a
  square of side ten): there are $\ell \in \{3, 4, 5\}$, distinct labels, a point $x$, a radius $\rho$ and compact
  connected sets $K_j \subset \overline{B(x, \rho)}$ through $x$ meeting $\partial B(x, \rho)$, each with a limiting
  direction at $x$,
  such that $H_{i_j}$ and $H_{i_{j+1}}$ are disjoint from $\Delta(K_j)$. Its proof uses [NFC], Theorem 6.5 (for five
  colours, $\mathcal L$ is closed and locally finite). Since no five-colouring exists, what matters here is the method;
  § 6 describes it.
- **T6 (Lebesgue's covering theorem; [HW], Theorem IV 2, for the square).** If a closed square is covered by finitely
  many closed sets none of which meets two opposite sides, some point of the square lies in three of them. [NFC],
  Lemma 7.5, proves the consequence it needs, by Brouwer's fixed point theorem: a closed square of side ten has no
  relatively open cover of multiplicity at most two (no point in more than two members) and mesh at most two (no member
  of diameter above two). *The disc form*, which P2, P3 and § 6 use, is ours, by the proof of that lemma **[hand, one
  mind, unchecked]**: a closed disc of radius $r$ has no finite relatively open cover of multiplicity at most two whose
  members have diameter at most $m < r$.
- **T7 (the hexagonal seven-colouring; [NFC], § 1, after Hadwiger).** Tile the plane by regular hexagons of circumradius
  $r$ and colour them by the seven cosets of an index-seven sublattice of the lattice of centres. Two points of one
  hexagon are at most $2r$ apart; points of distinct hexagons of one colour are at least $(\sqrt{21} - 2) r$ apart. For
  $r = 2/5$ these are $0.8$ and more than $1.03$, and the colouring is proper.

For orientation only: for colourings with regular classes much more is known — for instance [SV], Theorem 2, states
that no polygonal colouring of the plane with six colours exists. Nothing below uses it.

## 5. Our own results — context, not to be relied on

Each of these is ours. Unless another mark is given, each is **[hand, one mind, unchecked]**. Question 1 and the
variants (1a)–(1d) and (3) do not depend on them. What does depend on them: the implication "(1b) gives Question 1"
(P5); the sentence "(1d) gives (1c)" (P3); the reduction to Grundy colourings (P9); and everything § 8 says about what
an answer would be good for (P7, P8).

- **P1 (a connected one-label region gives witnesses).** Let $c$ be a weak measurable colouring with finitely many
  labels, $i$ a label, and $T$ a connected open set almost every point of which has the label $i$. Then $H_i$ is
  disjoint from $\Delta(K)$ for every compact set $K$ contained in the closure of $T$.
- **P2 (cyclic centres exist).** For every $k \ge 1$ and every weak measurable $k$-colouring of the plane, every closed
  disc of radius greater than 1 contains a cyclic centre.
- **P3 (finitely many cyclic centres give continua).** Let $k \ge 1$, let $c$ be a weak measurable $k$-colouring of the
  plane, and let $D$ be a closed disc of radius greater than 1 with $\mathcal L \cap D$ finite. Then there are a point
  $x \in \mathcal L$ in the interior of $D$, an integer $\ell$ with $3 \le \ell \le k$, distinct labels
  $i_0, \dots, i_{\ell-1}$, a radius $\rho > 0$ with $\overline{B(x, \rho)} \subset D$ and
  $\mathcal L \cap \overline{B(x, \rho)} = \{x\}$, and for each $j$ modulo $\ell$ a compact connected set
  $K_j \subset \overline{B(x, \rho)}$, a unit vector $v_j$ and points $q_{j,m} \in K_j \setminus \{x\}$ such that:
  (1) $x \in K_j$ and $K_j$ meets $\partial B(x, \rho)$;
  (2) $q_{j,m} \to x$ and $(q_{j,m} - x)/|q_{j,m} - x| \to v_j$ as $m \to \infty$;
  (3) $H_{i_j} \cap \Delta(K_j) = \emptyset$ and $H_{i_{j+1}} \cap \Delta(K_j) = \emptyset$;
  (4) $K_j \subset H_{i_j} \cap H_{i_{j+1}}$;
  (5) $i_j i_{j+1}$ is an edge of $\Gamma_x$.
  *Consequently* Question 1 and its anchored form (1a) have the answer yes on every disc with finitely many cyclic
  centres.
  *How it relates to print:* clauses (1)–(3) for five colours on a square are T5; we reread that proof for $k$ colours
  and a disc. Clauses (4) and (5) are read off the same proof by us. Clause (5) goes against the letter of a sentence of
  [NFC], which says of its Proposition 7.1: "The extracted cycle need not consist of edges of $\Gamma_x$". Nothing else
  in this document uses clause (5).
- **P4 (room gives witnesses).** Let $c$ be a measurable map from the plane to a finite set of labels, $p$ a point,
  $\eta > 0$, and $I$ a set of labels each of whose supports $H_i$ is disjoint from the open annulus
  $\{z : 1 - \eta < |z - p| < 1 + \eta\}$. Then every $q$ with $0 < |q - p| \le \eta$ witnesses every pair of labels of
  $I$ at $p$. So if $I$ has at least three labels, $p$ has a witnessed cycle. (The proof is the triangle inequality.
  Neither properness nor the presence of any label of $I$ near $p$ is used.)
- **P5 (connected pieces of a smoothed class give the exclusion).** Let $c$ be a weak measurable $k$-colouring, $i$ a
  label, $\alpha > 0$, $\varepsilon_n \to 0$, and $C_n$ connected sets with $p_i^{\varepsilon_n} > \alpha$ at every
  point of $C_n$. Let $K$ be the set of limits of convergent sequences $z_n \in C_n$. Then no point of $H_i$ has one
  point of $K$ nearer than 1 and another point of $K$ farther than 1. (Ingredients: T4, connectedness of $C_n$, and
  $p_i^\varepsilon \to 1_{A_i}$ in $L^1$ on bounded sets. One label at a time; no second label, no cyclic centre.)
- **P6 (a label that crosses the circle three times has no witness).** Let $H$ be a set, $p$ a point and
  $f_1, f_2, f_3$ three distinct unit vectors such that each point $p + f_m$ is a limit of points of $H$ nearer than 1
  to $p$ and a limit of points of $H$ farther than 1 from $p$. Then no point $q \ne p$ has
  $H \cap \Delta(p, q) = \emptyset$.
- **P7 (what one witness does: one side of the unit circle).** Let $c$ be a measurable map from an open set $U$ to a
  finite set of labels, $E$ a set of labels, and $x \ne q$ two points with $H_i \cap \Delta(x, q) = \emptyset$ for every
  $i \in E$. Let $w \in U$ with $|w - x| = 1$ and $|w - q| \ne 1$. Then there is $\eta > 0$ such that: if $|w - q| < 1$,
  almost every $z \in B(w, \eta)$ with $|z - x| > 1$ has its label outside $E$; if $|w - q| > 1$, almost every
  $z \in B(w, \eta)$ with $|z - x| < 1$ has its label outside $E$. (No properness is used.) Applied to the three edges
  of a witnessed triangle with labels $i_0, i_1, i_2$: at every point $w$ of the unit circle about $x$ at distance other
  than 1 from the three witnesses, the strip just outside or the strip just inside that circle near $w$ carries, almost
  everywhere, only the other $k - 3$ labels.
- **P8 (what a witnessed four-cycle forces at six colours).** Let $c$ be a weak measurable six-colouring of the plane,
  $p$ a point, $a_0, a_1, a_2, a_3$ four distinct labels and $q_0, \dots, q_3$ points other than $p$ such that $q_j$
  witnesses $\{a_j, a_{j+1}\}$ at $p$ for $j$ modulo 4, and let $X, Y$ be the two other labels. Then the set of
  directions $e$ whose palette $P_p(e)$ contains neither $X$ nor $Y$ has positive measure.
  *Status:* for Borel colourings this statement is formalized in Lean 4 in our own library and accepted by its kernel on
  the three standard axioms, over the palette lemmas of [NFC]'s Lean development. The version for a colouring of an
  open set containing the closed unit disc about $p$ is [hand, one mind, unchecked].
  *An instance:* no weak measurable six-colouring carries only two labels, almost everywhere, on an annulus about a
  unit circle (the four other labels then have room, P4).
- **P9 (the Grundy normal form).** Every weak measurable $k$-colouring with classes $(S_1, \dots, S_k)$ can be modified,
  keeping it a weak measurable $k$-colouring and never raising a point's label, into a measurable Grundy colouring
  $(A_1, \dots, A_k)$ with $A_m \supset S_m \setminus (A_1 \cup \dots \cup A_{m-1})$; in it, every point of the support
  of $A_m$ is at distance exactly 1 from the support of $A_i$, for every $i < m$. The construction chooses a maximal
  set at each step and is not unique. *Status:* [hand; two independent derivations, the second made without sight of
  the first].

## 6. The three attempts

### Attempt 1 — limits of connected fibres of a graph-valued map, without assuming the cyclic centres finite

*Route.* This is the method of [NFC], § 7 (T5), reread for $k$ colours. Fix $0 < \alpha < 1/k$. At every point some
$p_i^\varepsilon$ is at least $1/k$, so
$q_i^\varepsilon = (p_i^\varepsilon - \alpha)_+ / \sum_m (p_m^\varepsilon - \alpha)_+$ is a continuous map from the plane
to the simplex on the labels, and $q_i^\varepsilon > 0$ exactly where $p_i^\varepsilon > \alpha$. Away from the cyclic
centres, and off finitely many small discs whose total radius tends to 0 with $\varepsilon$, at most two coordinates are
positive, so the map takes its values in the complete graph $\mathcal G$ on the labels ([NFC], Lemma 7.3); those small
discs are filled in through trees ([NFC], Lemma 7.4); one small disc is kept around each cyclic centre, and here
finiteness of $\mathcal L \cap D$ is used for the first time, to keep their total radius small. A connected set on which
coordinate $i$ is positive has diameter at most $1 + o(1)$, by T4 ([NFC], Lemma 7.6). If the loop of the map around
every kept disc were null-homotopic in $\mathcal G$, the map would extend over a disc of radius above 1, and the
connected components of the sets where one coordinate is positive would form an open cover of multiplicity at most two
and mesh below the radius, against T6 in its disc form. Hence some cyclic centre carries a loop that is *essential*
(not null-homotopic) in $\mathcal G$; with no cyclic centre at all the same argument gives a contradiction outright,
which is P2. To extract more, take a cyclic centre $x$ with essential
loops at all scales of a sequence and an annulus $\overline{B(x, \rho)}$ minus the kept disc about $x$. The reduced word
of the inner loop contains a simple cycle of labels; for each edge of that cycle, the preimage of the edge's midpoint
has a connected component that crosses the annulus ([NFC], Lemmas 7.7–7.8); Hausdorff limits of these components are
the continua $K_j$, and clause (3) holds because every point of $\Delta(K_j)$ is at distance exactly 1 from a point of
the connected fibre, where both labels have average above $\alpha$.

*The step it could not take.* The annulus must contain no other cyclic centre: the map is not defined on the discs kept
around cyclic centres, and the crossing argument uses that the annulus has fundamental group $\mathbb Z$. If other cyclic
centres accumulate at every cyclic centre that carries essential loops, there is no such annulus.

*The statement it could not prove.* Variant (1c) with no hypothesis on $\mathcal L \cap D$ — in the first instance for
$\mathcal L \cap D$ countable.

*What is missing.* Either a reason why some cyclic centre carrying essential loops is isolated in $\mathcal L$, in a
class of colourings to which every six-colouring can be brought; or a crossing argument that tolerates infinitely many
cyclic centres. What the argument reads of $\mathcal L \cap D$ is exactly two things: that it can be covered by discs
of total radius tending to 0, and that the centre finally chosen is isolated. For $\mathcal L \cap D$ countable we have
only a sketch: fill the kept discs in order of Cantor–Bendixson rank, so that a centre of rank one becomes isolated
among the unfilled ones. The step not done is uniformity, along the sequence $\varepsilon_n \to 0$, over the infinitely
many centres of lower rank.

### Attempt 2 — forcing a cycle of length at least four, given finitely many cyclic centres

*Route.* Assume $D$ contains finitely many cyclic centres, so that P3 applies, and suppose every point it returns is a
triangle ($\ell = 3$) — the aim is variant (3), by contradiction. For map-type colourings a chain of steps excludes a
six-colouring all of whose vertices are three-coloured (by our records it is the argument behind [SV], Corollary 1; we
did not reread that paper for this note): the unit circle about such a vertex is coloured by the three other colours;
that colouring has a winding number, so it changes colour at least nine times; each change leads into the disc to a
further vertex; a count then produces two vertices of one type (the same three colours) less than 2 apart; and two unit
circles coloured by the same three colours, with centres between 1 and 2 apart, are excluded. We tried to carry the
chain over. Its first step carries: at a point $x$ with the data of P3 for $\ell = 3$, with $N$ the set of the three
other labels, at every direction $e$ perpendicular to no $v_j$ there are an
arc about $e$ and a one-sided strip along the unit circle about $x$ over that arc — outside the circle if
$e \cdot v_j > 0$ for at least two $j$, inside if $e \cdot v_j < 0$ for at least two $j$ — on which the colouring takes
only labels of $N$ almost everywhere (P7, with witnesses taken on the $K_j$ close to $x$). Let $\Pi_x(e) \subset N$ be
the set of labels of positive weight at $e$ in the weak-$*$ limits of the samples $f \mapsto (1_{A_i}(x + r_n f))_i$ with $r_n \to 1$ from that side (an essential union, as for the palette). Then
$\Pi_x(e) \ne \emptyset$ and $\Pi_x(e) \cap \Pi_x(Re) = \emptyset$ for almost every $e$ (the second from [NFC],
Corollary 5.4, stated there for five colours; its Lean statement is for every $k$). We also have the
winding statement in the form needed: if a measurable $\Pi$ from $S^1$ to the non-empty subsets of a three-element set
satisfies $\Pi(e) \cap \Pi(Re) = \emptyset$ almost everywhere, is locally constant off a finite set $J$, and no two
points of $J$ are at angle $\pi/3$, then the closed walk it makes round the triangle on the three labels has winding
number congruent to 3 modulo 6 [hand, one mind, unchecked].

*The step it could not take.* Finiteness of $J$. For two labels on an open strip [NFC], Lemma 8.6, gives rigidity (the
colouring is locally one label). For three labels on a strip nothing comparable is known to us, and two of the three may
alternate at every scale.

*The statement it could not prove.* **(S2)** *For every weak measurable six-colouring of the plane and every point $x$
with the data (1)–(3) of P3 for $\ell = 3$, the set $J_x$ of directions $e$ having no arc about $e$ on which $\Pi_x$ is
almost everywhere equal to one set is finite, and no two of its points are at angle $\pi/3$.* Its first clause is the
stall. Behind it, the two last steps of the chain (the count, and the exclusion of two like vertices between 1 and 2
apart) have no measurable form that we know.

*What is missing.* A rigidity statement for three labels on a one-sided strip along a unit circle, using the $\pi/3$
exclusion. A caution: if some weak measurable six-colouring has room for the three labels of $N$ along such a strip,
angular stripes of shrinking period (as in Example C of § 7) make $J_x$ infinite, so (S2) can hold only for a
restricted class of six-colourings — which class is not settled — or it is false at six. No six-colouring is known,
so this caution is conditional.

### Attempt 3 — two-point witnesses directly

*Route.* P5 removes everything from attempt 1 except connectedness: a connected set inside one superlevel set
$\{p_i^{\varepsilon} > \alpha\}$ already carries the exclusion for the label $i$, with no filling, no exceptional discs
and no cyclic centre. So a pair $\{a, b\}$ is witnessed at $x$ by $q$ as soon as $q$ is reached from $x$ in both labels
(variant (1b)). And points where three smoothed classes meet exist with no hypothesis: for $0 < \alpha < 1/k$ the
components of the sets $\{p_i^\varepsilon > \alpha\}$ cover the plane and have diameter at most $1 + o(1)$, so by T6
in its disc form every closed disc of radius above 1 contains, at every small scale $\varepsilon$, a point lying in
three of them.

*The step it could not take.* The selection of a point through which connected pieces of two smoothed classes pass and
reach a common second point — for each edge of some cycle of labels, with the second point at a distance bounded below
along a sequence $\varepsilon_n \to 0$. At a point lying in three of the sets, the three components through it overlap
pairwise in open sets, but nothing bounds the diameters of those overlaps from below (§ 7, item 7). Attempt 1 gets its
lower bound from the annulus; without an isolated centre there is none.

*The statement it could not prove.* The statement of Question 1 itself.

*What is missing.* A lower bound, at some point and along some sequence of scales, for the size of a connected piece
common to two smoothed classes; or a third source of witnesses. The two sources we have — connected pieces (P5) and room
(P4) — are independent of each other, and a counterexample has to defeat both at every point of a disc.

## 7. What is known to fail, and colourings to test ideas on

### Example colourings

All are built on the hexagonal seven-colouring of T7 with $r = 2/5$; $v$ is a vertex at which hexagons of colours
1, 2, 3 meet. A point of $B(v, 0.03)$ is within $0.83$ of every point of each of the three hexagons at $v$ and more
than $1$ from every other hexagon of the colours 1, 2, 3, which is why recolouring inside $B(v, 0.03)$ with the colours
1, 2, 3 keeps the colouring proper at every unit pair.

- **Example A (the hexagonal colouring itself).** Its cyclic centres are the vertices. At each vertex there is a
  witnessed triangle on its three colours, for two reasons: the tiles (P1), and room (P4) — the three colours avoid an
  annulus of half-width $0.012$ about the unit circle of every point within $0.01$ of the vertex. So every such point has a witnessed
  triangle, and all but the vertex are not cyclic centres. With $r = 1/2$ the tiles have diameter exactly 1 and the room
  is gone (the three colours of a vertex now occur in every annulus about its unit circle); P1 still applies at the
  vertices.
- **Example B (islands).** For $n \ge 6$, recolour with colour 3 the open disc of radius $4^{-n}$ centred at the point
  of the common edge of the hexagons 1 and 2 at distance $2^{-n}$ from $v$. The two points where each disc's boundary
  meets that edge are cyclic centres, and they accumulate at $v$.
- **Example C (stripes).** Fix $x$ with $|x - v| = 1$. In the part of $B(v, 0.03)$ outside the unit circle about $x$,
  give the point $x + \rho e^{i\theta}$ with $1 + 2^{-n-1} < \rho \le 1 + 2^{-n}$ the colour
  $1 + (\lfloor 3 \cdot 2^n \theta \rfloor \bmod 3)$. On an arc of directions the circle samples about $x$ of radii
  $1 + \tfrac34 2^{-n}$ converge weak-$*$ to $(\tfrac13, \tfrac13, \tfrac13)$ in the coordinates 1, 2, 3: a palette of
  three labels on a set of directions of positive measure.
- **Example D (dust; described, not written out by formula).** Around a point, nested closed curves of a second label
  whose thickness tends to 0 faster than their radius: the point is a density point of the first label, while every connected subset of
  $\{p^\varepsilon > \alpha\}$ for the first label near it has diameter tending to 0 with $\varepsilon$. Planted with
  the colours 1, 2, 3 inside $B(v, 0.03)$ it is a proper colouring in which P5 gives no witness at that point — and P4
  still does.

### Natural strengthenings that fail

Each is **[hand, one mind, unchecked]**; items 4 and 5 have not even a numerical check behind them.

1. *"The cyclic centres are locally finite, at every $k$."* False at $k = 7$: Example B.
2. *"At every cyclic centre the conclusion of P3 holds."* False at $k = 7$ with clause (4): at the accumulation point
   $v$ of Example B, $H_1 \cap H_2$ near $v$ is the edge with the islands removed, which contains no connected set
   through $v$ other than $\{v\}$. Clauses (1)–(3) alone do hold at $v$, by room. At the isolated cyclic centres of
   Example B all clauses hold. So finiteness in P3 is sufficient and not necessary, and a weaker hypothesis must still
   pick out the right centre.
3. *"A witnessed cycle at $p$ shows that its labels meet at $p$."* False: Example A, the points near a vertex.
4. *"An anchored witnessed triangle at $p$ makes $p$ a cyclic centre."* False: in Example A let colour 3 also fill a
   small disc inside the hexagon of colour 1, tangent to the 1–2 edge at a point $p$ near $v$. Then $p$ lies in all
   three supports and has an anchored witnessed triangle, while colours 2 and 3 meet near $p$ only at $p$, with
   $D_{23}(B, h) = O(|h|^{3/2})$; so $\Gamma_p$ is a path.
5. *"A cyclic centre carries an essential loop."* False: six sectors coloured 1, 2, 3, 1, 3, 2 about a point (planted
   near $v$ in Example A) have all three pairs as edges of the transition graph, and the loop about the point reads the
   word $(12)(23)(31)(13)(32)(21)$, which reduces to the empty word. (The planted disc creates other cyclic centres on
   its rim.)
6. *"Almost every palette has at most two labels"* (true of five colours by [NFC], Proposition 5.6). False at $k = 7$:
   Example C. In Example C the unit circle about $x$ also crosses two of the three hexagons at $v$ along arcs, so those
   two labels have no witness at $x$ at all (P6): Example C is not a witnessed triangle with a wild unit circle.
7. *"A point lying in three smoothed classes lies in pairwise overlaps of definite size."* False: four sectors coloured
   $i, l, j, l'$ about a point give, at every scale, two points lying in three of the sets, at which the overlap of the
   $i$-set and the $j$-set has the diameter of the scale.
8. *"Through a density point of a class passes a connected piece of its smoothed class of definite size."* False:
   Example D.
9. *"Fill the triangles of the label graph; then only cycles of length at least four stay essential, and a covering
   theorem for multiplicity three forces one."* False: for $k \ge 4$ every loop of the complete graph on the labels is
   null-homotopic once all triangles are filled, and on a disc with finitely many cyclic centres the filled map exists
   for every colouring, with a cover of multiplicity at most three and mesh at most $1 + o(1)$. The enlarged target
   carries no obstruction, and loses the one that the graph carries.
10. *"The examples are Grundy colourings, so they also test variant (2)."* False: for no order of the seven colours is
    the hexagonal colouring with $r = 2/5$, or Example B, or Example C, a measurable Grundy colouring. For orders that
    begin with a colour of $v$, some output of the construction in P9 applied to Example B or C has a single colour on
    all of $B(v, 0.03)$; nothing is known about every output.

**What a counterexample to Question 1 must look like** (each line rests on the result of § 5 it names): in the disc it
has infinitely many cyclic centres (P3); at no point of the disc do three labels have room along the unit circle (P4),
so it is not the hexagonal colouring with a circumradius strictly between $1/(\sqrt{21} - 2)$ and $1/2$, nor anything
planted in the room of that colouring; at no point of the disc do three connected one-label open sets meet, each two of
them sharing a further boundary point (P1); and at no point of the disc is there a cycle of labels each edge of which
has a point reached in both its labels (P5). We know no colouring with these properties and have no proof that none
exists.

## 8. What would count as an answer, and what it would imply

- **A proof of Question 1** — for all $k$, or for $k = 6$ from properties every weak measurable six-colouring must
  have. *It would imply:* every weak measurable six-colouring has, in every closed disc of radius above 1, a point with
  a witnessed cycle of length 3, 4, 5 or 6, so our conditional statements (P7, P8, and others of the same kind) would
  hold for every such colouring. *It would not imply* $\chi(\mathbb R^2) = 7$. For that, every witnessed cycle would
  have to lead to a contradiction at six colours, and none is known to: P8 constrains a four-cycle without excluding
  it, and a witnessed triangle is what an ordinary three-coloured vertex of a map carries (P1).
- **A proof of a variant** — (1a), (1b), (1c) or (1d), or any of them for measurable Grundy colourings. Each of
  (1a)–(1c) gives Question 1 and more; (1d) gives (1c) through P3; a proof for Grundy colourings serves through P9. The
  same limit applies: none of them decides between 6 and 7.
- **A counterexample with $k \ge 7$**: a weak measurable $k$-colouring and a disc of radius above 1 in which every
  witness graph is a forest. *It would imply* that no argument blind to the number of colours proves Question 1, so
  that a proof at six must use six or pass to a restricted class. *It would not imply* anything about
  $\chi(\mathbb R^2)$. A counterexample to a variant only — say a measurable Grundy colouring with accumulating cyclic
  centres — would be valuable in the same way for that variant.
- **A counterexample with $k = 6$** would in particular be a weak measurable six-colouring, and by T1 and T2 that gives
  $\chi(\mathbb R^2) = 6$. We state the implication because it is true; it is the open problem itself and not what we
  expect this question to produce.
- **A reduction to a named statement**: for instance, that Question 1 follows from a property of sets with null unit
  pairs (a lower bound for connected pieces of their smoothed versions at some point), or from a rigidity statement
  such as (S2), or that it is equivalent to one of the variants. If the question is a known problem under another
  name — in geometric measure theory, in the theory of distance-avoiding sets, in measurable combinatorics — the name
  and a reference are an answer.
- **For variant (3)**: a proof would give every weak measurable six-colouring whose cyclic centres are locally finite a
  point with a witnessed cycle of length at least four. Of these P8 speaks to length four only, and constrains it
  without excluding it; so this too would stop short of seven.

## 9. What is not claimed

- That a weak measurable six-colouring exists, or that none does.
- That the statement of Question 1 is true, or false, at any $k \ge 6$; only that it holds for the colourings named in
  § 7 and under the hypotheses of P1, P3, P4 and P5.
- That a positive answer gives $\chi(\mathbb R^2) = 7$ (§ 8).
- That any result of § 5 is correct beyond its stated status.
- That the three attempts exhaust the reasonable approaches, or that the difficulty they met is intrinsic.
- That the question is new. We have not made a literature search for it in its own right; we did not meet it in the
  works cited.

## References

- **[NFC]** *The Euclidean plane is not five-colorable*, preprint dated September 23, 2026, with a Lean 4
  formalization; in the repository `https://github.com/openai/math`, commit
  `adc7f1241b42e322a6451854ab7e4b4c146bf78a`; the manuscript is at
  `https://github.com/openai/math/blob/main/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/paper.pdf`.
- **[SV]** G. Sokolov, V. Voronov, *On the chromatic number of the plane for map-type colorings*, arXiv:2502.01958;
  Discrete Mathematics 349 (2026) 115321.
- **[HW]** W. Hurewicz, H. Wallman, *Dimension Theory*, Princeton University Press, revised edition 1948.
- **[dBE]** N. G. de Bruijn, P. Erdős, *A colour problem for infinite graphs and a problem in the theory of relations*,
  Indagationes Mathematicae 13 (1951) 371–373.
