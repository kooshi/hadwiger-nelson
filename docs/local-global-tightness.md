# The local–global tightness conjecture for unit-distance graphs over number fields

> **Status (de Bruijn, 2026-09-14).** This is the statement as sent to the outside advisor on 2026-09-13, unchanged. The
> advisor's response — hand proofs of the conjecture's two- and three-colour levels, the chain theorem that replaces the
> spindle, the conditional five-level, an 18-vertex four-chromatic graph over ℚ(√2,√3) and eight copies over ℚ(√3,√7,√11) —
> is filed under `reference/ChatGPT-local-global-tightness-conjecture/` with our verification note (`VERIFICATION.md`),
> credited as **GPT Astra**, and consumed by stubs FS-45 and FS-46 (`plans/FRONTIER-STUBS.md`). Since the sending: Theorem 3
> and Corollaries 3.1–3.2 are kernel-checked (`CLAUDE.md` ledger row 66, FS-38 closed 2026-09-13); the 2-adic tower's
> stabilisation at level 4 is row 67; the frozen-vertex census of §7 is FS-43.

*A statement prepared for external review, 2026-09-13. It is self-contained: nothing below assumes access to the research
record it comes from. Every claim carries a trust tag.*

| tag | meaning |
|---|---|
| **[K]** | machine-checked: stated and proved in Lean 4 over Mathlib, verified by the Lean kernel on the standard axioms |
| **[H]** | a hand proof, given or sketched here |
| **[C]** | computed with untrusted code and then verified as stated (a colouring checked against every edge; a table checked by exhaustive lookup) |
| **[S]** | a SAT solver's refutation, not independently certified |
| **[L]** | a result of the literature, cited |
| **[Conj]** | a conjecture |

## 0. Summary

Let $F \subset \mathbb R$ be a number field and $\chi(F^2)$ the chromatic number of the unit-distance graph on $F^2$. A classical
argument — reduce coordinates modulo a suitable prime of $F(i)$ — bounds $\chi(F^2)$ above by the chromatic number of a finite
Cayley graph (Woodall, Fischer, Moorhouse, Manturov, Madore). We call the minimum of these bounds over all such primes the
**local bound** $L(F)$, and we have $\chi(F^2) \le \min(7, L(F))$ **[L], [K]** at the level of certificates.

> **Conjecture (local–global tightness).** For every real number field $F$, $\chi(F^2) = \min(7, L(F))$.

That is: the small primes of $F$ do not merely bound the chromatic number of its plane, they determine it. The conjecture is
attained at every field where the value is known (values 2, 3, 4 and 5; Table 2). Its content is entirely on the lower-bound
side, and the one mechanism that has ever produced those lower bounds — a pair of points forced to share a colour, then a
rotation ("spindle") putting them at distance 1 — is shown here (Theorem 3, new, **[C]**, formalization in progress) to have
**no instance at the step from five colours to six**: over every field whose local bound is attained at the prime 11, no finite
unit-distance graph has two points forced equal by all five-colourings. So the conjecture, if true above five, is true for a
reason nobody has named.

Under one stated assumption (that the finite plane over $\mathbb F_{83}$ is six-colourable, §6), the conjecture predicts
$\chi(\mathbb Q(\sqrt3,\sqrt7,\sqrt{11})^2) = 6$, hence a finite six-chromatic unit-distance graph and $\chi(\mathbb R^2) \ge 6$; without
any assumption it predicts $\chi(\mathbb Q(\sqrt3,\sqrt5,\sqrt7,\sqrt{11})^2) = 7$, hence $\chi(\mathbb R^2) = 7$. We do not claim either.
We are asking whether the conjecture is known, whether it is plausible, and whether a counterexample or a mechanism is visible
from outside.

## 1. Setting

For a subfield $F \subseteq \mathbb R$, $\mathrm{UD}(F)$ is the graph with vertex set $F^2$ and an edge between two points at Euclidean
distance exactly 1; $\chi(F^2)$ is its chromatic number. Three standard facts frame everything:

1. $\chi(\mathbb R^2) \in \{5, 6, 7\}$: at least 5 by de Grey's 1,581-vertex graph **[L]** (de Grey 2018; our record holds a kernel-checked
   certificate of it, **[K]**), at most 7 by the hexagonal tiling colouring (Isbell, in Hadwiger 1961) **[L]**, also **[K]** in our record.
2. $F^2 \subseteq \mathbb R^2$ is an induced subgraph, so $\chi(F^2) \le \chi(\mathbb R^2) \le 7$ for every real field, and a finite
   unit-distance graph over $F$ that needs $k$ colours shows $\chi(\mathbb R^2) \ge k$.
3. (de Bruijn–Erdős 1951 **[L]**) $\chi(F^2)$ is the maximum of $\chi(G)$ over finite subgraphs $G$. So "$\chi(F^2) \ge k$" means
   "some finite unit-distance graph with coordinates in $F$ is not $(k-1)$-colourable".

The reverse bridge, $\chi(\mathbb R^2) = \sup_F \chi(F^2)$ over number fields, needs (3) together with the fact that a finite unit-distance
graph in $\mathbb R^2$ has a drawing with real-algebraic coordinates (the drawing variety is defined over $\mathbb Q$; Tarski's transfer
principle). It is not used below except in §8.

Throughout, $E = F(i)$, points $(x, y) \in F^2$ are identified with $z = x + iy \in E$, and complex conjugation is the nontrivial
automorphism of $E/F$. Then $|z - w|^2 = (z-w)\overline{(z-w)} = N_{E/F}(z-w)$, and a **unit vector** is an element $u \in E$ with
$u\bar u = 1$.

## 2. The local bounds

### 2.1 The residue theorem

Let $\mathcal O_E$ be the ring of integers of $E$ and $\mathfrak P$ a nonzero prime ideal of $\mathcal O_E$ with $\bar{\mathfrak P} = \mathfrak P$
(conjugation-stable). Write $\kappa = \mathcal O_E/\mathfrak P$ for its residue field, $\sigma$ for the involution of $\kappa$ induced by
conjugation, and

$$S_{\mathfrak P} = \{\, u \in \kappa : u\,\sigma(u) = 1 \,\}.$$

$S_{\mathfrak P}$ is symmetric ($-S = S$) and does not contain $0$, so it is the connection set of a Cayley graph
$\mathrm{Cay}(\kappa, S_{\mathfrak P})$ on the additive group of $\kappa$: $u \sim v$ iff $u - v \in S_{\mathfrak P}$.

> **Theorem 1 (the residue bound).** For every conjugation-stable prime $\mathfrak P$ of $\mathcal O_E$ there is a graph homomorphism
> $\mathrm{UD}(F) \to \mathrm{Cay}(\kappa_{\mathfrak P}, S_{\mathfrak P})$ on each connected component. Hence
> $$\chi(F^2) \le \chi\big(\mathrm{Cay}(\kappa_{\mathfrak P}, S_{\mathfrak P})\big) \le |\kappa_{\mathfrak P}|.$$

*Proof* **[H]**. Let $v = v_{\mathfrak P}$ be the valuation. For a unit vector $u$: $v(u) + v(\bar u) = v(1) = 0$, and $v(\bar u) = v_{\bar{\mathfrak P}}(u) = v(u)$
because $\bar{\mathfrak P} = \mathfrak P$; so $v(u) = 0$ and $u$ is a unit of the local ring $\mathcal O_{E,\mathfrak P}$. The connected components of
$\mathrm{UD}(F)$ are the cosets of the additive subgroup $\Lambda$ generated by unit vectors, and $\Lambda \subseteq \mathcal O_{E,\mathfrak P}$.
Fix a component $C = t + \Lambda$ and define $\rho_C(z) = (z - t) \bmod \mathfrak P \in \kappa$. If $z \sim w$ in $C$ then $u = z - w$ is a unit
vector, $\rho_C(z) - \rho_C(w) = u \bmod \mathfrak P$, and $(u \bmod \mathfrak P)\,\sigma(u \bmod \mathfrak P) = u\bar u \bmod \mathfrak P = 1$ because $\sigma$ is
induced by conjugation on the stable prime. So the images are adjacent (in particular distinct). A proper colouring of the Cayley
graph pulls back along $\rho_C$ on each component, and the components are coloured independently. $\square$

The theorem is classical in each of its cases. Woodall (1973) two-colours $\mathbb Q^2$ by exactly this reduction at the prime
$(1+i)$ of $\mathbb Z[i]$; Fischer (1990) develops the additive framework; Moorhouse (2010, §8.2, §10.3), Manturov (2012) and Madore
(2015, Prop. 3.2, Cor. 3.4) give the odd-prime case as $\chi(F^2) \le \chi(\mathrm{UD}(\mathbb F_q))$ (below). Our record proves it in the
Lean kernel at the level of ring homomorphisms and explicit certificates (a certificate is a finite list of points with coordinates in
an explicit ring, together with the edge list) **[K]**; the step "every finite unit-distance graph over $F$ is such a certificate"
is the integrality argument above and is a hand step in our record **[H]**.

### 2.2 The two shapes of the bound

Let $\mathfrak p = \mathfrak P \cap \mathcal O_F$ with residue field $\mathbb F_q$, $q = p^f$.

**Odd $p$.** $E/F$ is unramified above $\mathfrak p$ (the discriminant of $i$ is $-4$), so a stable $\mathfrak P$ above $\mathfrak p$ exists iff
$\mathfrak p$ is inert in $E$, iff $-1$ is not a square in $\mathbb F_q$, iff $q \equiv 3 \pmod 4$ (equivalently $p \equiv 3 \pmod 4$ and $f$ odd).
Then $\kappa = \mathbb F_{q^2} = \mathbb F_q(i)$, $\sigma$ is the Frobenius $u \mapsto u^q$, and $S_{\mathfrak P}$ is the kernel of the norm
$\mathbb F_{q^2}^\times \to \mathbb F_q^\times$, a cyclic group of order $q+1$. Writing $u = a + bi$, the Cayley graph is

$$\mathrm{UD}(\mathbb F_q) := \text{the graph on } \mathbb F_q^2 \text{ with } (a,b) \sim (c,d) \iff (a-c)^2 + (b-d)^2 = 1,$$

the *finite Euclidean plane* of Medrano–Myers–Stark–Terras (1996), Vinh's *unit-quadrance graph* (2005): $q^2$ vertices, regular of
degree $q+1$. So **a prime of odd residue degree above $p \equiv 3 \pmod 4$ gives $\chi(F^2) \le \chi(\mathrm{UD}(\mathbb F_q))$.** A prime of
even residue degree gives nothing ($-1$ is then a square in the residue field and unit vectors need not be $\mathfrak p$-integral).

**$p = 2$.** Here $E/F$ may ramify. If $-1$ is a square in the completion $F_{\mathfrak p}$, $\mathfrak p$ splits in $E$ and there is no stable
prime above it. Otherwise $F_{\mathfrak p}(i)/F_{\mathfrak p}$ is quadratic and either

- *ramified*: $\kappa = \mathbb F_q$ with $\sigma = \mathrm{id}$, so $S = \{u : u^2 = 1\} = \{1\}$ in characteristic 2, and $\mathrm{Cay}(\kappa, \{1\})$ is
  a perfect matching: **the bound is 2** (the plane is bipartite); or
- *unramified*: $\kappa = \mathbb F_{q^2}$, $\sigma$ the Frobenius, $S$ the norm-one group of order $q+1$. For $q = 2$ this is
  $\mathrm{Cay}(\mathbb F_4, \mathbb F_4^\times) = K_4$: **the bound is 4**.

| completion $F_{\mathfrak p}$ at a prime above 2 | $F_{\mathfrak p}(i)$ | residue graph | bound | example |
|---|---|---|---|---|
| $\mathbb Q_2$ | ramified | $K_2$ | 2 | $\mathbb Q$ (Woodall) |
| $\mathbb Q_2(\sqrt2)$ | ramified | $K_2$ | 2 | $\mathbb Q(\sqrt2)$ |
| $\mathbb Q_2(\sqrt5) = \mathbb Q_2(\zeta_3)$ | ramified | matching on $\mathbb F_4$ | 2 | $\mathbb Q(\sqrt5)$ (Fischer 1990, Thm 8) |
| $\mathbb Q_2(\sqrt3) = \mathbb Q_2(\sqrt{11})$ | unramified ($\mathbb F_4$, Frobenius) | $K_4$ | 4 | $\mathbb Q(\sqrt3)$, $\mathbb Q(\sqrt{11})$, $\mathbb Q(\sqrt3,\sqrt{11})$ |
| $\mathbb Q_2(\sqrt7) \ni i$ | split | — | none | $\mathbb Q(\sqrt7)$, $\mathbb Q(\sqrt3,\sqrt5,\sqrt{11})$ |

(For a real multiquadratic field, "no bound at 2" happens exactly when some odd square class is $\equiv 7 \pmod 8$, since then $-d$ is a
2-adic square for that $d$ and $i = \sqrt{-d}/\sqrt d$ lies in the completion.)

**Definition.** The **local bound** of $F$ is
$$L(F) = \min_{\mathfrak P\ \text{stable}} \chi\big(\mathrm{Cay}(\kappa_{\mathfrak P}, S_{\mathfrak P})\big) \in \{2, 3, 4, \dots\} \cup \{\infty\},$$
the minimum over all conjugation-stable primes of $\mathcal O_{F(i)}$ ($\infty$ if there are none). By Theorem 1,
$$\chi(F^2) \le \min(7, L(F)).$$

*A note on the definition.* Our earlier working definition used $|\kappa_{\mathfrak P}|$ at the prime 2 rather than the chromatic number of the
residue graph; that reads 4 for $\mathbb Q(\sqrt5)$ where the plane is bipartite, and the sharp form above reads 2. The sharp form is
the one the conjecture is stated with.

### 2.3 The finite Euclidean planes

Everything above five colours passes through the values $\chi(\mathrm{UD}(\mathbb F_q))$, $q \equiv 3 \pmod 4$. What is known:

- $\mathrm{UD}(\mathbb F_q)$ is a Cayley graph of $\mathbb F_q^2$; its eigenvalues are Kloosterman sums (Medrano–Myers–Stark–Terras 1996), bounded in
  absolute value by $2\sqrt q$ (Weil 1948). Hoffman's bound (1970) then gives
  $$\chi(\mathrm{UD}(\mathbb F_q)) \ \ge\ 1 + \frac{q+1}{2\sqrt q},$$
  which exceeds 5 from $q = 59$ and exceeds 6 from about $q = 97$ **[L]**; we computed the exact spectra for every prime $q < 600$ **[C]**.
- Exact values: $\chi(\mathrm{UD}(\mathbb F_3)) = 3$ ($\mathrm{UD}(\mathbb F_3) \cong K_3 \square K_3$) **[K]**; $\chi(\mathrm{UD}(\mathbb F_7)) = 4$ **[C][S]**; $\chi(\mathrm{UD}(\mathbb F_{11})) = 5$
  **[K]** (Moorhouse 2010, Table 6.1, agrees); $\chi(\mathrm{UD}(\mathbb F_{19})) \in \{4, 5\}$ (an explicit five-colouring **[K]**; four colours undecided).
- Undecided, with the exact Hoffman floor from the computed spectrum: $q = 23, 31, 43, 47$ (floor 5; five colours undecided after four
  solver-hours each), $q = 59, 67, 79, 83$ (floor 6), $q = 71, 103, 107$ (floor 7), $q = 131$ (floor 8), $q = 167$ (floor 8), $q = 479$ (floor 13).

So a prime above 59 can never give a bound of 5, and only $q \in \{59, 67, 79, 83\}$ could give a bound of exactly 6.

### 2.4 Deeper levels, and the completion

Reduction modulo $\mathfrak P^m$ gives, by the same proof, a homomorphism $\mathrm{UD}(F) \to \mathrm{Cay}(\mathcal O_E/\mathfrak P^m, S_m)$ for every $m$, and
these graphs map onto one another downward, so their chromatic numbers are non-increasing in $m$. The sharpest local invariant at
$\mathfrak P$ is therefore not the level-one graph but the chromatic number of the unit-distance graph over the completion $F_{\mathfrak p}$
(Bardestani–Mallahi-Karai 2017 study this object; they show its *Borel* chromatic number is finite exactly when $x^2 + y^2$ is
anisotropic over $F_{\mathfrak p}$, which is the stability condition above). Wherever a finite graph over $F$ attains the level-one bound,
every level attains it too: this is the case at 2 for $\mathbb Q(\sqrt3,\sqrt{11})$ (value 4) and at 11 for $\mathbb Q(\sqrt3,\sqrt5,\sqrt{11})$ (value
5). Whether it holds at 83 is open (§6). We state the conjecture at level one, which is what has been tested, and note the refinement
in §8.

## 3. The conjecture

> **Conjecture 1 (local–global tightness, level-one form).** For every real number field $F$,
> $$\chi(F^2) = \min\big(7,\ L(F)\big).$$
>
> **Conjecture 1$'$ (completion form).** The same with $L(F)$ replaced by the minimum over stable primes of the chromatic number of
> the unit-distance graph over the completion $F_{\mathfrak p}$.
>
> **Weak form.** Whenever $L(F) \le 6$, $\chi(F^2) = L(F)$.

By Theorem 1 and de Bruijn–Erdős, Conjecture 1 is equivalent to: *for every real number field $F$, some finite unit-distance graph with
coordinates in $F$ needs $\min(7, L(F))$ colours.* Its entire content is on the lower-bound side. In words: the arithmetic of $F$ at its
small primes decides the chromatic number of its plane, and the plane's number is always reached by a finite graph that the primes
permit.

## 4. Evidence

**Table 2 — every field where $\chi(F^2)$ is known to us.** In each row the value equals $\min(7, L(F))$.

| $F$ | 2-adic bound | odd primes giving a bound (first few) | $L(F)$ | $\chi(F^2)$ | lower bound by | trust |
|---|---|---|---|---|---|---|
| $\mathbb Q$ | 2 | 3 (→3), 7, 11, … | 2 | 2 | an edge | [L] Woodall |
| $\mathbb Q(\sqrt2)$, $\mathbb Q(\sqrt5)$ | 2 | — | 2 | 2 | an edge | [H] |
| $\mathbb Q(\sqrt3)$ | 4 | 3 (→3), 11 (→5) | 3 | 3 | the unit triangle | [H] |
| $\mathbb Q(\sqrt7)$ | none | 3 (→3), 7 (→4) | 3 | 3 | an odd cycle (Fischer's criterion) | [H] |
| $K = \mathbb Q(\sqrt3,\sqrt{11})$ | 4 | 11 (→5), 83, 107, … | 4 | 4 | the Moser spindle | **[K]** both bounds (χ(K²) = 4 is our Theorem B, answering Moorhouse §1 and closing Madore's 4 ≤ χ ≤ 5) |
| $K(\sqrt{35})$ | 4 | 107, 131, … | 4 | 4 | the Moser spindle | [K] lower; upper by Theorem 1 at 2 with the [H] integrality step |
| $\mathbb Q(\sqrt3,\sqrt5,\sqrt{11})$ (Heule's field) | none | 11 (→5), 131, … | 5 | 5 | Heule's 510-vertex graph | **[K]** both bounds (the upper bound modulo the [H] integrality step) |
| $K(\sqrt{247})$, $K(\sqrt{23})$ | none | 11 (→5), … | 5 | 5 | 5-chromatic graphs we built there | [S] lower bound; [K] upper via 11 |

Two remarks on how the table was produced, because they are the reason the conjecture was formulated.

**The values were reached by one mechanism, and the mechanism removes its own prime.** Every increase of the chromatic number along
the table came from a *forced pair*: two points that every $k$-colouring of some finite graph paints alike, then a rotation about one of
them carrying the other to distance 1 from itself, which forces a $(k+1)$-th colour. The rotation adjoins a square root, and the square
root kills the very prime that gave the bound $k$:

> **Theorem 2 (the tightness mechanism) [H], radicand step [K].** Let $\mathfrak p$ be a prime of $F$ with residue field $\mathbb F_q$,
> $q \equiv 3 \pmod 4$, such that $\mathrm{UD}(\mathbb F_q)$ is $k$-colourable. Let $G$ be a finite unit-distance graph over $F$ and $u, v$ two of its
> points with $C(u) = C(v)$ for every proper $k$-colouring $C$ of $G$; put $d^2 = |u - v|^2$. Then
> (i) $d^2 \in \mathfrak p$;
> (ii) the graph $G \cup \rho G$, where $\rho$ is the rotation about $u$ with $|\rho v - v| = 1$, has no proper $k$-colouring, and its
> coordinates lie in $F' = F(\sqrt{4d^2 - 1})$;
> (iii) every prime of $F'$ above $\mathfrak p$ has even residue degree, so Theorem 1 at $\mathfrak p$ gives no bound for $F'$.

*Proof.* (i): by Theorem 1, $G$ maps into $\mathrm{UD}(\mathbb F_q)$; on that Cayley graph, if $\mathrm{UD}(\mathbb F_q)$ is $k$-colourable then no two
distinct points are forced equal (rotate a colouring by the norm-one group: a common period of a colouring and of its quarter-turn
spans the whole plane, forcing the colouring constant) — **[K]** for prime $q$, **[H]** for $q = p^f$; so the images of $u$ and $v$ coincide, i.e. $u - v \in \mathfrak P$ and
$d^2 = N(u - v) \in \mathfrak p$. (ii): the spindle argument; $\cos\theta = 1 - 1/(2d^2)$, $\sin\theta = \sqrt{4d^2-1}/(2d^2)$. (iii): $x = \sqrt{4d^2-1}$
satisfies $x^2 \equiv -1 \pmod{\mathfrak p'}$ for every $\mathfrak p' \mid \mathfrak p$, so the residue field of $\mathfrak p'$ contains $\sqrt{-1}$, hence
$\mathbb F_{q^2}$. **[K]**: no ring homomorphism from a ring containing such an $x$ to $\mathbb F_q$ exists. $\square$

Instances: the rhombus over $\mathbb Q(\sqrt3)$ forces a pair at distance $\sqrt3$ at three colours ($d^2 = 3 \in (\sqrt3)$); the spindle
adjoins $\sqrt{11}$, and in $\mathbb Q(\sqrt3,\sqrt{11})$ the prime 3 has residue degree 2: the bound at 3 is gone, the 2-adic bound 4 is the
next, and the Moser spindle attains it. At four colours the measured forced pairs are: over $K$, deep fabric forces pairs at
distances $8/3$ and $8/\sqrt3$ (squared distance of 2-adic valuation 6) **[C]**; over $K(\sqrt5)$, de Grey's 791-point forcer forces
its axis pair at distance 4 and five antipodal pairs at $4/\sqrt3$ **[C]**. Their spindles adjoin $\sqrt{247}$, $\sqrt{759}$ ($= \sqrt3\sqrt{11}\sqrt{23}$),
$\sqrt{63} = 3\sqrt7$ and $\sqrt{183}$ ($= \sqrt3\sqrt{61}$); each puts a square root of $-1$ into every 2-adic completion, so the bound 4
disappears, and the next bound is 5 from the prime 11 — attained in $K(\sqrt5)$ by Heule's and Parts's graphs, in $K(\sqrt{247})$ and
$K(\sqrt{23})$ by ours, and exceeded (no bound below 6) in de Grey's $K(\sqrt5,\sqrt7)$. **[L]** for the constructions (de Grey 2018,
Heule 2018, Parts 2020), **[C]** for the forced pairs (complete sweeps of the four-colourings of the relevant fabric).

**The pattern of the nulls.** At five colours, complete sweeps for forced pairs over every 5-chromatic graph we hold — Heule's two,
Parts's, ours, de Grey's — and over a purpose-built 51,133-vertex graph in a field with no bound below 6, found none **[C]**. Theorem 3
explains the first group.

## 5. The obstruction at five colours (new)

> **Theorem 3 (a free colour at the image frees the pair) [H]; verified [C]; Lean formalization in progress.**
> Let $f : G \to P$ be a graph homomorphism, $c$ a proper $k$-colouring of $P$, and $v = f(u)$ a vertex at which $c$ has a *free colour*: some
> $\gamma \ne c(v)$ that appears on no neighbour of $v$. Then for every vertex $u' \ne u$ of $G$ there is a proper $k$-colouring $c'$ of $G$
> with $c'(u) \ne c'(u')$.

*Proof.* If $c(f(u)) \ne c(f(u'))$, take $c' = c \circ f$. Otherwise let $c' = c \circ f$ except $c'(u) = \gamma$. Every neighbour $y$ of $u$ has
$f(y)$ adjacent to $f(u) = v$, so $c(f(y)) \ne \gamma$; every other edge is coloured by $c \circ f$; so $c'$ is proper, and
$c'(u') = c(v) \ne \gamma = c'(u)$. $\square$

> **Corollary 3.1.** If $P$ is $k$-colourable with a free colour at every vertex (on a Cayley graph, one such vertex suffices, by
> translation), then no two distinct vertices of any graph mapping homomorphically into $P$ are forced equal at $k$ colours.
>
> **Theorem 3$'$ (two vertices at once).** If one colour $\gamma$ is absent from the closed neighbourhoods of two adjacent vertices $v, v'$ of $P$
> in some $k$-colouring, then for non-adjacent $u \in f^{-1}(v)$, $u' \in f^{-1}(v')$ some $k$-colouring of $G$ gives $u$ and $u'$ the same colour
> (recolour both with $\gamma$).

**Facts at 11 [C].** In our kernel-checked five-colouring of $\mathrm{UD}(\mathbb F_{11})$, three vertices — $(2,4)$, $(7,8)$, $(9,6)$ — see only three
colours on their twelve neighbours, so each has a free colour. A second five-colouring exists in which colour 4 is absent from the
closed neighbourhoods of both $(0,0)$ and $(1,0)$ (verified on all 726 edges); rotations by the norm-one group carry that edge to every
edge. Non-adjacent distinct vertices of $\mathrm{UD}(\mathbb F_{11})$ are identified by some five-colouring **[K]** (our earlier work).

> **Corollary 3.2.** For every graph $G$ with a homomorphism into $\mathrm{UD}(\mathbb F_{11})$, at five colours: two vertices are forced equal iff
> they are the same vertex, and two vertices are separated by every colouring iff they are adjacent.
>
> **Corollary 3.3 (field level) [H] for the integrality step.** Let $F$ be a real number field with a prime of residue degree one above 11.
> Then no finite unit-distance graph over $F$ has two distinct points forced equal by all five-colourings, at any distance, and every
> pair separated by all five-colourings is at distance 1. In particular Theorem 2's mechanism has **no instance** at $k = 5$ over such
> fields. Every multiquadratic field containing $\mathbb Q(\sqrt3,\sqrt{11})$ with $L(F) = 5$ is such a field: its 2-adic residue graphs give 2 or 4,
> none of $19, 23, 31, 43, 47$ has residue degree one over $\mathbb Q(\sqrt3,\sqrt{11})$ (3 is a non-residue modulo 19, 31, 43 and 11 is a non-residue
> modulo 23, 47), and from 59 up no finite plane is five-colourable; so a bound of 5 can only come from 11 at residue degree one.

**The contrast that makes this a mechanism rather than an accident.** At the steps the ladder did climb, the residue graph had no free
colour anywhere: $\mathrm{UD}(\mathbb F_3) \cong K_3 \square K_3$, whose three-colourings are Latin squares (every vertex sees both other colours), and
$K_4$ at the prime 2 (uniquely colourable). At 11 the five-colourings have slack. Slack at the residue graph kills forcing (Theorem 3);
the absence of slack merely permits it. So the 5 → 6 step differs in kind from 3 → 4 and 4 → 5.

This also answers, for every distance, a question Gibbs posed in Polymath16 (2 May 2018): whether the point $5/3$ is forced to the
origin's colour in every five-colouring of a certain graph over Heule's field, as a route to a sixth colour. No point is.

## 6. What the conjecture predicts

**Assumption A.** $\chi(\mathrm{UD}(\mathbb F_{83})) = 6$ (its Hoffman floor from the exact spectrum is 6; six-colourability is undecided).

Let $K = \mathbb Q(\sqrt3,\sqrt{11})$. For a multiquadratic field $F \supseteq K$, the primes giving a bound are the $p \equiv 3 \pmod 4$ at which every
radicand is a square (residue degree one); over $K$ this forces $p \equiv 11 \pmod{12}$ with 11 a square mod $p$, and the smallest such
primes are 11, 83, 107, 131, 167, …. Among the primes with a floor of exactly 6 ($59, 67, 79, 83$), only 83 satisfies this. Hence:

- **$F = K(\sqrt7) = \mathbb Q(\sqrt3,\sqrt7,\sqrt{11})$.** No 2-adic bound ($7 \equiv 7 \pmod 8$); 11 has residue degree 2 (7 is not a square mod 11);
  the primes of degree one are 83, 131, 167, 227, 479, …; so $L(F) = \chi(\mathrm{UD}(\mathbb F_{83}))$, which under Assumption A is 6. Our record
  holds a 51,133-vertex unit-distance graph over this field that is 5-chromatic **[S]** for the lower bound, **[C]** for the five-colouring.
  **Conjecture 1 + Assumption A predict $\chi(F^2) = 6$**: a finite six-chromatic unit-distance graph with coordinates in $F$, hence
  $\chi(\mathbb R^2) \ge 6$. (Conjecture 1$'$ needs the stronger assumption that the 83-adic plane, not only its level-one quotient, is
  6-chromatic.)
- **$F = \mathbb Q(\sqrt3,\sqrt5,\sqrt7,\sqrt{11})$, de Grey's field.** No 2-adic bound; the first prime of degree one is 131 (floor 8), then 479 (floor
  13); so $L(F) \ge 8$ and **Conjecture 1 predicts $\chi(F^2) = 7$, hence $\chi(\mathbb R^2) = 7$**, with no assumption. This is the conjecture's
  bold form and its most exposed prediction: it says the field of de Grey's original 5-chromatic graph is already 7-chromatic.
- **Every other multiquadratic field containing $K$** either has 11 of degree one (then $L = 5$ and the field is fully understood by
  Corollary 3.3 as far as pair compulsions go) or has $L \ge 6$; among the latter, $L = 6$ requires 83 of degree one, i.e. $7$ or another
  radicand making 83 usable — $K(\sqrt7)$ and $K(\sqrt{127})$ are the smallest.

So under Conjecture 1 the whole of Hadwiger–Nelson above five reduces to one question per field: is the best local bound attained?
And the first field where "attained" would mean six is $K(\sqrt7)$, under Assumption A.

## 7. What a proof of the lower bound would have to be

Theorem 1 supplies every upper bound in Table 2 and Theorem 2 supplied every lower bound above 2, by a forced pair one colour below.
Corollary 3.3 says that route is closed at five colours over every field with a bound of 5. A proof of $\chi(K(\sqrt7)^2) \ge 6$, or of any
instance of the conjecture above five, therefore needs a lower-bound mechanism the residue theory does not provide. We know of none.
Two structural facts constrain it:

1. Any forced pair at five colours in a graph over a field with no bound below 6 must sit at two vertices that are *frozen* in every
   five-colouring (Theorem 3 with $f = \mathrm{id}$): every five-colouring puts all four other colours on each of their neighbourhoods.
   No graph we hold has been checked for frozen vertices; the check is cheap and is our next measurement.
2. Over such a field no five-colouring is additive (Fischer 1990, Thm 10(ii): a wall-broken plane has no additive $k$-colouring for
   $k \le 10$) and none factors through a residue graph. Whatever rigidity a six-forcer exploits is non-arithmetic in this sense.

## 8. Falsifiers, refinements, and questions for the reader

**Falsifiers.** A real number field with $\chi(F^2) < \min(7, L(F))$. The natural candidates are the fields with no bound below 6: a
five-colouring of $\mathrm{UD}(K(\sqrt7))$ or of $\mathrm{UD}(\mathbb Q(\sqrt3,\sqrt5,\sqrt7,\sqrt{11}))$ would refute the conjecture outright. Such a colouring
would come from no prime and would not be additive.

**Refinements we are aware of.** (a) Level one versus the completion (§2.4, Conjecture 1$'$). (b) Non-prime quotients: Theorem 1
generalizes to any finite quotient of the unit-vector lattice $\Lambda$ by a subgroup containing no unit vector (Fischer's and Moorhouse's
framework); Moorhouse (2010, §9) observes that composite ideals cannot beat the best prime unless Hedetniemi's conjecture fails, but
non-ideal subgroups are not covered by that remark. (c) The real place: the "7" in $\min(7, L)$ is the archimedean bound, $\chi(\mathbb R^2) \le 7$;
a uniform statement "$\chi(F^2) = \min_v \chi(F_v^2)$ over all places" would put the unknown $\chi(\mathbb R^2)$ on both sides.

**Questions.**

1. Is Conjecture 1, or the sharpness of Theorem 1, stated or discussed anywhere? Moorhouse (2010) asks for $\chi(K^2)$ for specific
   fields and conjectures $\chi(\mathbb F_q^2) \to \infty$; Madore (2015) gives $4 \le \chi(\mathbb Q(\sqrt3,\sqrt{11})^2) \le 5$; we have not found
   the tightness question posed.
2. Do you know a field with $\chi(F^2) < \min(7, L(F))$, or a reason to expect one?
3. Is there a known mechanism for lower bounds on $\chi(F^2)$ other than a forced pair plus a spindle (§7)? Density arguments,
   Borsuk–Ulam type arguments, and topological bounds have not, to our knowledge, produced a 6-chromatic unit-distance graph.
4. Is $\chi(\mathrm{UD}(\mathbb F_{83})) = 6$ known, or approachable (6,889 vertices, degree 84, floor 6)? A six-colouring symmetric under the norm-one
   group would be a start; its nonexistence proves nothing.
5. Is the chromatic number of the unit-distance graph over $\mathbb Q_p^2$ (or over the completion of $K(\sqrt7)$ at 83) equal to that of the
   finite plane $\mathrm{UD}(\mathbb F_p)$? Bardestani–Mallahi-Karai treat the Borel version; the ordinary version decides between Conjectures 1 and 1$'$.
6. The prediction $\chi(\mathbb Q(\sqrt3,\sqrt5,\sqrt7,\sqrt{11})^2) = 7$: does anything known make it implausible, beyond the absence of a
   6-chromatic graph after eight years of search?

## 9. References

- M. Bardestani, K. Mallahi-Karai, *On a generalization of the Hadwiger–Nelson problem*, Israel J. Math. (2017); arXiv:1507.05300.
- N. G. de Bruijn, P. Erdős, *A colour problem for infinite graphs and a problem in the theory of relations*, Indag. Math. 13 (1951) 371–373.
- A. D. N. J. de Grey, *The chromatic number of the plane is at least 5*, Geombinatorics 28 (2018) 18–31.
- K. G. Fischer, *Additive k-colorable extensions of the rational plane*, Discrete Math. 82 (1990) 181–195.
- H. Hadwiger, *Ungelöste Probleme Nr. 40*, Elem. Math. 16 (1961) 103–104 (Isbell's seven-colouring); see A. Soifer, *The New Mathematical Coloring Book*, Springer 2024, for the history and the number-field chapter (Benda–Perles).
- M. J. H. Heule, *Computing small unit-distance graphs with chromatic number 5*, Geombinatorics 28 (2018); arXiv:1805.12181.
- A. J. Hoffman, *On eigenvalues and colorings of graphs*, in *Graph Theory and its Applications*, Academic Press 1970, 79–91.
- D. A. Madore, *The Hadwiger–Nelson problem over certain fields*, arXiv:1509.07023 (2015).
- V. O. Manturov, *On the chromatic numbers of integer and rational lattices*, J. Math. Sci. 214 (2016) 687–698; arXiv:1206.1934.
- A. Medrano, P. Myers, H. M. Stark, A. Terras, *Finite analogues of Euclidean space*, J. Comput. Appl. Math. 68 (1996) 221–238.
- G. E. Moorhouse, *On the chromatic numbers of planes*, preprint (2010), ericmoorhouse.org/pub/chromatic.pdf.
- J. Parts, *Graph minimization, focusing on the example of 5-chromatic unit-distance graphs in the plane*, Geombinatorics 29 (2020); arXiv:2010.12665.
- Polymath16, *Hadwiger–Nelson problem*, blog threads and wiki (2018–); the 5/3 question is P. Gibbs, thread 3, 2 May 2018.
- L. A. Vinh, *On chromatic number of unit-quadrance graphs (finite Euclidean graphs)*, arXiv:math/0510092 (2005).
- A. Weil, *On some exponential sums*, Proc. Nat. Acad. Sci. USA 34 (1948) 204–207.
- D. R. Woodall, *Distances realized by sets covering the plane*, J. Combin. Theory Ser. A 14 (1973) 187–200.

## Appendix A. The fields, at a glance

| field | 2-adic bound | primes of degree one giving a bound | $L$ | $\chi$ | objects we hold there |
|---|---|---|---|---|---|
| $\mathbb Q(\sqrt3)$ | 4 | 3 (→3) | 3 | 3 | the rhombus (forces at 3) |
| $K = \mathbb Q(\sqrt3,\sqrt{11})$ | 4 | 11 (→5), 83 (→≥6), 107, 131 | 4 | 4 [K] | Moser spindle; the seam closures; fabric with 171 four-colour forced pairs |
| $K(\sqrt5)$ = Heule's | none | 11 (→5), 131, 239 | 5 | 5 [K] | Heule-510, Heule-553, Parts-509 |
| $K(\sqrt{247})$, $K(\sqrt{23})$, $K(\sqrt5,\sqrt{247})$ | none | 11 (→5) | 5 | 5 [S] | our 5-chromatic graphs |
| $K(\sqrt{35})$ | 4 | 107, 131 | 4 | 4 | — |
| $K(\sqrt7)$ | none | 83 (floor 6), 131 (8), 167, 227, 479 | 6 under Assumption A | ∈ {5,6,7}; ≥ 5 [S] | the 51,133-vertex 5-chromatic graph |
| $K(\sqrt{127})$ | none | 83, 167, 239 | 6 under Assumption A | ∈ {5,6,7} | — |
| $K(\sqrt{13})$, $K(\sqrt{79})$ | none | 107 (7), 131 / 107, 227 | ≥ 7 | ∈ {5,6,7} | — |
| $\mathbb Q(\sqrt3,\sqrt5,\sqrt7,\sqrt{11})$ = de Grey's | none | 131 (8), 479 (13) | ≥ 8 | ∈ {5,6,7}; ≥ 5 [K] | de Grey's 1,581-vertex graph |

The floors in parentheses are exact Hoffman floors from computed spectra; "$\chi = k$ [S]" means a finite graph refuted by a SAT solver
at $k-1$ colours and coloured with $k$, verified.
