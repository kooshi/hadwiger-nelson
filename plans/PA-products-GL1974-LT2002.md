# PA reading — Greenwell–Lovász 1974 and Larose–Tardif 2002

*Prior-art reader: de Bruijn, 2026-09-25, for the FS-89 close. Brief: `data/fs89/briefs/PA-products-reader-brief.md` (commit 567fa749).
Both papers read in full: Greenwell–Lovász from the page images (300 dpi renders, key statements re-read on crops); Larose–Tardif from
its text layer, with every displayed formula checked against the page image. No shared file edited; findings are for the close
planner.*

## 0. Findings, ranked

1. **The "uniquely `n`-colourable" statement is Greenwell–Lovász's Corollary 1 (p. 336), exactly as `[Tardif2008]` quotes it**:
   *"If χ(G) > n and G is connected then K_n × G is uniquely n-colourable."* Two hypotheses (connected; `χ(G) > n`), no finiteness
   assumption (the proof is pointwise plus connectivity, so it holds for infinite `G`). It is a corollary of the stronger **Theorem 1**
   (p. 335), whose hypothesis on `G` is **exactly gap-freedom** in this project's sense (G68): *"any two n-colourings of G differ in
   at least two points"* holds iff no `n`-colouring of `G` has a vertex whose closed neighbourhood misses a colour (PA-P1). So the
   repair FS-61 found for FS-58's measured fact — gap-freedom — is the hypothesis Greenwell–Lovász printed in 1974, placed on the
   factor that is **not** `K_n`.
2. **G70's `K₄ × K₄` step holds, but it is not an instance of Corollary 1** (`χ(K₄) = 4`, not `> 4`). It is **Corollary 3**
   (p. 336, `n = 4`, `k = 2`): *"(K_n)^k has exactly k n-colourings"*, counted up to relabelling, derived for `n ≥ 3`; so `K₄ × K₄`
   has exactly two, the projections (48 labelled). Two records gloss it as "`K_n` is uniquely `n`-colourable in the categorical
   product", which names the wrong statement: `K₄ × K₄` is not uniquely 4-colourable. **Row 86's use is an instance of Corollary 1**,
   provided `Y` is connected — which `LEDGER.md` row 86's sentence omits and FS85-derivation dB3 / FS85-IA5 state.
3. **§5.4's criterion at `G = K_k` is printed inside Greenwell–Lovász's proof.** Case 2 of Theorem 1 colours every non-injective
   map `[n] → [n]` by a repeated value (`γ'`, p. 336); that is a proper `n`-colouring of `E_n(K_n)`, each map coloured within its own
   image — exactly the form §5.4 says a proof must take (PA-P2). Theorem 1 says more than §5.4 at `G = K_k`: the other factor may be
   `k`-colourable if it is connected and gap-free, and then each colouring comes from one factor or the other.
4. **The class for which FS-67 is answered in print is `G = K_k^s`** (every `s ≥ 1`, `k ≥ 3`): Theorem 1 iterated (PA-P3), and,
   by its zbMATH review, the main theorem of **Larose, *Strongly projective graphs*, Can. J. Math. 54 (2002) 757–768** (not held).
   Among G54's tight residue targets this covers **`Γ₃ = UD(𝔽₃, 2) ≅ K₃ × K₃`** and **the dyadic `U₂ = Cay(𝔽₄, μ₃) = K₄`**, with
   their direct powers (PA-P4) — not FS-58's 81-vertex `S₁`, not `U₃₂`, not any higher tower level.
5. **Larose–Tardif 2002 does not bear on §5.4 directly.** Its objects are idempotent homomorphisms `G^n → G` and maximum independent
   sets of **powers** `G^n`; a power's cofactor `G^{n−1}` has `χ ≤ χ(G)`, outside FS-67's `χ(H) > k`. It gives no answer for
   vertex-transitive `G` or for G54's targets. Its line of descent does: LT's Problem 6.1 leads to `[Zhang2012]`'s MIS-normality
   theorem, which **as printed also covers the equal-ratio case** (MIS-normal unless a factor is IS-imprimitive) — so FS-67 holds for
   vertex-transitive `H` with `χ_f(H) = k < χ(H)` when both factors are IS-primitive (PA-P5). The stub's re-aim reads Theorem 1.8 for
   the strict case only.
6. **"Strongly projective" is not in Larose–Tardif 2002.** The phrase never occurs; the paper is Larose's single-author CJM paper
   (item 4). M50's two records and `plans/STANDING-QUESTIONS.md` cite it under the wrong paper (and STANDING-QUESTIONS under the wrong
   authors). The fact M50 actually uses — every polymorphism of `K₅` is a projection up to a palette permutation — **is Greenwell–
   Lovász's Corollary 3 at `n = 5`**. Its "Inv–Pol" consequence is the general Galois correspondence, in neither paper, and
   "trivial polymorphism clone" is inexact: `Pol(K₅)` consists of the permuted projections, and only its idempotent part is trivial.
7. **Side results.** LT2002 Lemma 1.1 prints Albertson–Collins's no-homomorphism lemma with its equality case, which checks the ratio
   half of `[HahnTardif1997]`'s "recalled, not read" row. Greenwell–Lovász's question (b) (p. 335) is **Hedetniemi's conjecture**,
   recorded in 1974 as "as far as we know, unanswered". Their §4 classifies the colourings of infinite powers of `K_n` by 0–1
   measures (Pósa's observation; Lempert independently).

## 1. Greenwell–Lovász 1974

**Copy.** `~/source/library/pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf`: 6 pages, a scan with no text layer,
Acta Math. Acad. Sci. Hungar. 25 (3–4) (1974) 335–340. Received 14 May 1973. Authors: D. Greenwell (Iowa State University, Ames),
L. Lovász (Eötvös Loránd University, Department of Geometry). **Read in full, every page.**

### 1.1 Reading log

| § | pages | content | read |
|---|---|---|---|
| Introduction | 335 | the programme (verbatim below) | full |
| 1. Notation and terminology | 335 | loopless simple graphs; the direct product of a family `G_α, α ∈ A` (arbitrary index set); `ΠG` for powers; "If γ is an n-colouring of G then γ(v) will denote the colour of v (which will always be an integer between 1 and n)" — colourings are maps to `{1,…,n}`, not required to be onto | full |
| 2. Colourings of products | 335–337 | questions (a), (b); Theorem 1 and proof; Corollaries 1–3; the traffic-signal reading; Theorem 2 and proof | full |
| 3. Forbidden subgraphs | 337–338 | Theorem 3 (line- and point-critical extensions), its proof via `(K_{n−1})^q` and Corollary 3; Corollary; a simpler construction when `χ(G) ≤ n − 2` | full |
| 4. The colourings of `Π_A K_n` | 338–340 | 0–1 measures; induced colourings; Theorem 4 and proof by induction on `n` | full |
| References | 340 | four items (§5) | full |

### 1.2 The results, verbatim

- **Introduction (p. 335):** "It will be shown that under some (rather restrictive) conditions the n-colourings of the (weak) direct
  product (cardinal product, Kronecker product, conjunction) are only those trivially induced by n-colourings of the factors. This
  result will be used to show that there are uniquely n-colourable graphs without short odd cycles and to prove the following theorem:
  A graph G can be embedded into a line-critical n-chromatic graph if and only if the contraction of any edge of G results in an
  (n−1)-colourable graph."
- **The product (p. 335):** "the graph whose vertex set is the cartesian product of the V(G_α) with two vertices adjacent if and only
  if they are adjacent in every component."
- **Questions (p. 335):** "(a) Are these all the n-colourings of the product? Also, this observation yields χ(Π_{α∈A} G_α) ≦
  min_{α∈A} χ(G_α). (b) Does here the equality hold if A is finite? Question (b) is, as far as we know, unanswered. The answer to
  question (a) is negative in general. However, we are going to give positive answer to (a) in some special cases."
- **Theorem 1 (p. 335):** "Suppose G is a connected graph such that any two n-colourings of G differ in at least two points. Then each
  n-colouring of K_n × G is induced by an n-colouring of one of the factors."
- **Its proof (p. 336)**, for a colouring `β` of `K_n × G`. *Case 1*: some `x` has `β(1,x), …, β(n,x)` all different; a neighbour `y`
  then has `β(i,y) = β(i,x)`, and connectivity makes `β` induced from `K_n`. *Case 2*: "For all x ∈ V(G), there are i ≠ j such that
  β(i, x) = β(j, x). Denote this colour by γ'(x)." For fixed `x`, `γ_k = γ'` off `x` and `β(k,x)` at `x` is an `n`-colouring of `G`;
  "The n-colourings γ₁, …, γ_n differ only in x; therefore, by our assumption on G, they are identical. Hence β(i, x) is the name for
  every i, which proves that β is induced by the n-colouring γ_k of G." (*"name"* is a misprint for *"same"*.)
- **Corollary 1 (p. 336):** "If χ(G) > n and G is connected then K_n × G is uniquely n-colourable."
- **Corollary 2 (p. 336):** "For all n ≧ 3, there is a uniquely n-colourable graph without odd cycles shorter than a given number s."
  (Via Corollary 1 and large-odd-girth graphs of large chromatic number, Erdős [1] or Erdős–Hajnal [2]; "This result improves the
  results of Harary, Hedetniemi and Robinson [3] and Nešetřil [4].")
- **Corollary 3 (p. 336)**, after "It is easy to see that (K_n)^k = Π_{(1,…,k)} K_n is connected for n ≧ 3, so by induction on k,
  we have the following useful corollary to Theorem 1": "(K_n)^k has exactly k n-colourings." (Colourings are counted up to
  relabelling; the `n ≥ 3` is in the sentence before, not in the display.)
- **The traffic signal (p. 336):** "Given k switches, each having n positions, a traffic signal has n lights of different colours,
  and, depending on the position of the switches, always one of these lights is on. We know that if we change the position of all
  switches, the colour of the traffic signal changes. Then the signal depends on one of the switches only."
- **Theorem 2 (p. 337):** "The independence number of (K_n)^k is n^{k−1} and furthermore the only maximum independent sets are those
  obtained by fixing one component." (Proof on the odometer of a '67 Buick: a maximum independent set `S` gives the `n`-colouring
  with classes `C_i = {(a_α + i) : (a_α) ∈ S}`, so Corollary 3 fixes a component. The `n ≥ 3` is again implicit; at `n = 2` the
  second clause is false.)
- **Theorem 3 (p. 337):** "Let n ≧ 4. If G contains an edge e such that χ(Ge) ≧ n then G is a forbidden subgraph for a graph to be
  line critically n-chromatic. Otherwise G can be extended to a line critical n-chromatic graph. Furthermore any graph G with
  χ(G) < n can be extended to a point critical n-chromatic graph." (`Ge` is the contraction of `e`. The proof's last paragraph, p. 338,
  proves the point-critical clause under the weaker hypothesis "χ(G − v) < n for all v ∈ V(G)".)
- **Corollary (p. 338):** "If G is a subgraph of a line-critical n-chromatic graph then it is an induced subgraph of a line-critical
  n-chromatic graph."
- **§4 (p. 338):** "As Π_A K_n contains a complete n-graph (the diagonal), its chromatic number is n. However, in the case when A is
  infinite, it always has n-colourings other than those induced by n-colourings of the factors. This was observed by L. Pósa." A 0–1
  measure is finitely additive with `μ(A) = 1`; the colouring induced by factor colourings `β_α` and `μ` colours `(a_α)` by the `k`
  with `μ{α : β_α(a_α) = k} = 1`.
- **Theorem 4 (p. 339):** "Each n-colouring of Π_A K_n (n ≧ 3) is induced by n-colourings of the factors and a measure μ of A."
  Footnote: "Theorem 4 was proved independently by L. Lempert." And (p. 340): "If A is finite it has only trivial 0−1 measures and
  hence corollary 3 follows from theorem 4."

### 1.3 What the reading adds

- **Theorem 1's hypothesis is gap-freedom** (PA-P1): two `n`-colourings differing exactly at `x` exist iff `x` can be recoloured,
  iff its closed neighbourhood misses a colour in one of them. The hypothesis holds vacuously when `χ(G) > n`, which is Corollary 1.
- **Only one factor is arbitrary.** Every statement has a complete-graph factor: `K_n × G` (Theorem 1), powers of `K_n` (Corollaries
  3, Theorems 2, 4). Nothing is said about a product of two general graphs.
- **Question (b) is Hedetniemi's conjecture**, uncredited to Hedetniemi and posed here as open in 1974 (refuted by `[Shitov2019]`).

## 2. Larose–Tardif 2002

**Copy.** `~/source/library/pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf`: 10 pages, text layer. J. Graph
Theory 40 (2002) 162–171, doi 10.1002/jgt.10041. Received 5 Feb 2000, revised 15 Jan 2002. B. Larose (Champlain Regional College and
Concordia), C. Tardif (Regina). **Read in full, every page.**

### 2.1 Reading log

| § | pages | content | read |
|---|---|---|---|
| 1. Introduction | 162–164 | categorical product; idempotent maps; projectivity; `K_m` (`m ≥ 3`) projective; GL's use; Lemma 1.1, Corollary 1.1 | full |
| 2. Projective graphs | 164–165 | probes, constructible sets; Lemma 2.1; Theorem 2.1 (from their [11]) | full |
| 3. Circular graphs | 165–167 | `Circ(r, s)`; Lemma 3.1; Theorems 3.1, 3.2; the transposition remark | full |
| 4. Kneser graphs | 167–169 | EKR / Hilton–Milner; Fact 4.1; Corollary 4.1 and proof | full |
| 5. Truncated simplices | 169–170 | `T_s`; Fact 5.1; non-canonical maximum independent sets of `T_s²`; Theorem 5.1 | full |
| 6. Concluding comments | 170–171 | Problem 6.1; circular chromatic number; Zhu's conjecture 6.1; Theorem 6.2 | full |
| References | 171 | twelve items (§5) | full |

### 2.2 The results, verbatim

- **Projectivity (p. 163):** "A homomorphism φ : G^n ↦ G (that is, an edge-preserving map) is called idempotent if it satisfies the
  identity φ(x, x, …, x) = x. G is called projective if the only idempotent homomorphisms from the powers of G to G are the
  projections."
- **Complete graphs (p. 163):** "In particular, if G is a complete graph on m vertices, then the m-colorings of the powers of G are, up
  to a re-labeling of the colors, idempotent homomorphisms from the powers of G to G. It turns out that the complete graphs on three or
  more vertices are projective, thus the m-colorings of their powers are completely characterized. In an article entitled
  ''Applications of product colorings'', Greenwell and Lovász [8] use this result to give a characterization of the independent sets of
  maximal cardinality in powers of complete graphs, and use it in constructions of graphs with interesting chromatic properties."
- **Lemma 1.1 (p. 163; Albertson–Collins [1]):** "Let G, H be graphs such that H is vertex-transitive and there exists a homomorphism
  φ : G ↦ H. Then, α(G)/|V(G)| ≥ α(H)/|V(H)|. Furthermore, if equality holds in (1), then for any independent set I of cardinality
  α(H) in H, φ⁻¹(I) is an independent set of cardinality α(G) in G."
- **Corollary 1.1 (p. 163):** "Let G be a vertex-transitive graph. Then for any n, we have α(Gⁿ) = α(G) · |V(G)|^{n−1}."
- **The question and the classes (p. 164):** "does a power of a vertex-transitive graph G contain independent sets of maximal
  cardinality other than the ''canonical'' ones, that is, the inverse images of independent sets of G under projections?" … "Powers of
  complete graphs are the simplest examples of non-projective graphs whose powers have only canonical maximal independent sets."
- **Theorem 2.1 (p. 165; their [11]):** "Let G be a graph with at least three vertices. Then, the following are equivalent: G is
  projective. All the pairs of vertices of G are constructible. All the subsets of vertices of G are constructible." (A constructible
  set is the set of images of a probe vertex over all homomorphisms of a probe with fixed vertices pinned — a pp-definable unary
  relation with constants.)
- **Lemma 3.1 (p. 166):** "The independence number of Circ(r, s) is r, and the only maximal independent sets of Circ(r, s) are the arcs
  A_k = {k, k+1, …, k+r−1}." (*Maximal* means *of maximum cardinality* throughout the paper.) Also: "[i, j] ∈ E(Circ(r, s)) if and only
  if A_i and A_j are disjoint."
- **Theorem 3.1 (p. 166):** "The circular graphs are projective."
- **Theorem 3.2 (p. 166):** "The maximal independent sets of Circ(r, s)ⁿ are just the canonical ones, that is, the sets
  pr⁻¹_{m,n}(A_k), m = 1, …, n, k = 0, …, s − 1." Then (p. 167): "Theorem 3.2 generalizes the result of Greenwell and Lovász [8] on
  complete graphs. The basic idea of the proof can easily be transposed to any other Cayley graph G on an abelian group, provided that
  G is projective and isomorphic to the graph of non-intersection of its maximal independent sets."
- **Fact 4.1 (p. 168):** "The only independent sets of maximal cardinality in K(r, s)ⁿ are the sets pr⁻¹_{m,n}(I_k), m = 1, …, n,
  k = 0, …, s − 1." ("a particular case of a much more general result of Ahlswede, Aydinian, and Khachatrian [3]"; the proof is
  sketched, "Pasting together these local characterizations".)
- **Corollary 4.1 (p. 168):** "The Kneser graphs are projective."
- **Truncated simplices (p. 170):** `T_s²` has maximum independent sets "that are not of the canonical form"; **Theorem 5.1:** "The
  truncated simplices are projective." So projectivity does not give canonical maximum independent sets of the square.
- **Problem 6.1 (p. 170):** "Let G be a non-bipartite vertex-transitive graph. Suppose that the only independent sets of maximal
  cardinality in G² are the preimages of the maximal independent sets of G under projections. Then, does the same hold for all powers
  of G?" — answered yes by Ku–McMillan (JGT 60 (2009) 295–301) and by Zhang, per `[Zhang2012]`'s introduction (second-hand).
- **Theorem 6.2 (p. 171):** "Let G, H be connected graphs such that the circular graph Circ(r, s) admits homomorphisms into both G and
  H. If χ_c(G) > s/r and χ_c(H) > s/r, then χ_c(G × H) > s/r." — "an analogue of the Duffus-Sands-Woodrow theorem [6]", derived from
  Theorem 3.1 and their [10] Thm 1.4 (projective `Circ(r, s)`, `r, s` coprime, retract of a product of connected graphs ⟹ retract of a
  factor).

### 2.3 What the reading adds

- The paper **states** `K_m` projective for `m ≥ 3` (p. 163) and proves nothing about it; the proof in print is Greenwell–Lovász's
  Corollary 3 (idempotent `σ ∘ pr_i` forces `σ = id`).
- It is a paper about **powers**. No statement concerns `G × H` with distinct factors except Theorem 6.2, which is about *which factor
  maps* (circular multiplicativity), not about *what the maps look like* — the distinction FS-61 drew for El-Zahar–Sauer.

## 3. Every citation in the repository, checked

Grep of the brief, run 2026-09-25, plus the two hits in `plans/STANDING-QUESTIONS.md` and `plans/FS71-theorem-audit.md`.
*Holds* = the cited paper says it, at the stated scope. Line numbers are those of the working tree at `HEAD` = 567fa749
(`BIBLIOGRAPHY.md` at f97baa8e); the close planner's own edits may shift them.

| file:line | what it attributes | verdict |
|---|---|---|
| `CLAUDE.md`:1329 (G70) | `K₄ × K₄`'s only proper four-colourings are its two projections (Greenwell–Lovász) | **holds** — Corollary 3, p. 336, `n = 4`, `k = 2`; equivalently Theorem 1 with `G = K₄`. Not Corollary 1 |
| `CLAUDE.md`:251 (prior-art position) | `K_k × Y` uniquely colourable (`[KlotzSander2017]` Thm 4.2, after Greenwell–Lovász) | **holds** for connected `Y` with `χ(Y) > k` (Corollary 1) |
| `LEDGER.md`:109 (row 86) | product route: `K_k × Y`, `Y` a triangle-free circulant of order prime to `k`, `χ(Y) > k`, uniquely `k`-colourable, after Greenwell–Lovász | **holds with a missing hypothesis**: Corollary 1 needs `Y` connected (a disconnected `Y` gives independent relabellings per component). dB3 and IA5 state it; the row's sentence drops it |
| `BIBLIOGRAPHY.md`:66 (§ R.4 item 9) | FS-58's measured statement is not GL's theorem; false in general (`C₅ × K₄`); "true under a tightness hypothesis our object has" | first two **hold**; "true" **overstates** — it is FS-67's open question, proved in print only when the tight factor is `K_k` or `K_k^s` (§4) |
| `BIBLIOGRAPHY.md`:132 (`[GreenwellLovasz1974]`) | the quote; "the n-colourable factor must be `K_n` itself"; used in "a derivation about projective (dictator) graphs … to be re-found" | quote **holds** (Corollary 1); "must be `K_n`" holds for Corollary 1, but Theorem 1 lets the other factor be `n`-colourable when gap-free; the derivation is **found**: M50 (`plans/M50-batch-descent.md`:798, `plans/M50-derivation.md`:98–104, 129–133) and `plans/STANDING-QUESTIONS.md`:103–104, resting on Corollary 3 |
| `BIBLIOGRAPHY.md`:133 (`[LaroseTardif2002]`) | M50's "strongly projective graphs"; the `S₅` Inv–Pol consequence; GL the base fact | **does not hold**: "strongly projective" is in Larose, CJM 54 (2002) 757–768 (Zbl 1020.05029), not this paper; the Inv–Pol consequence is in neither; the base fact holds (GL Corollary 3) |
| `BIBLIOGRAPHY.md`:290 (`[Tardif2008]`) | §4.2 quotes GL: "if G is connected and χ(G) > n, then G × Kₙ is uniquely n-colorable" | **holds** — Corollary 1, p. 336, same hypotheses and conclusion |
| `BIBLIOGRAPHY.md`:583 (`[KlotzSander2017]`) | Thm 4.2 extends GL (`X` uniquely `n`-colourable and 2K₂-free, `Y` connected, `χ(Y) > n`) | **consistent**: `X = K_n` gives Corollary 1 exactly (Klotz–Sander not re-read here) |
| `BIBLIOGRAPHY.md`:542 | arXiv:2604.01408's GL link "a citation, not a shared question" | not checked (needs that paper) |
| `BIBLIOGRAPHY.md`:742 (§ D task 2) | re-find where GL was used | **answered for GL**: the M50 and STANDING-QUESTIONS sites above |
| `plans/PA-tardif2023.md`:25, 244, 295 | GL is the case `G = K_k` of §5.4; GL = "`G × K_n` uniquely `n`-colourable when `χ(G) > n`" | **holds**, and more: GL's proof (Case 2) contains the `k`-colouring of `E_k(K_k)` itself (PA-P2) |
| `plans/PA-tardif2023.md`:278 | `[Tardif2008]` is FS-67's GL relay | holds |
| `plans/FS71-theorem-audit.md`:420 | one textbook citation added, `[LaroseTardif2002]` | the key resolves to a real paper, but the content it was added for is Larose's CJM paper |
| `plans/POROS-2026-09-25-fs86-plan.md`:28–29 | topic list: uniquely colourable graphs (GL), MIS-normal products (Zhang, Larose–Tardif), projectivity | **holds** at scope — LT2002 is MIS-normality of *powers* |
| `plans/FS58-derivation.md`:71, 78; `plans/FS58-four-colours.md`:176 | GL is prior art "for `K_n` factors", unread | **holds**; "unread" now stale. GL does not reach D3.4: its `S₁` has 81 vertices and degree 8, while `K₃^m` on 81 vertices has degree 16, so `S₁` is no direct power of `K₃` |
| `plans/STUB-quadratic-census.md`:28; `plans/SESSION-HANDOFF-2026-09-25-fs86-open.md`:43 | GL as an owed reading | **paid** by this record |
| `plans/FS61-quadratic-census.md`:165, 204–213 | the Tardif quote; "the 3-colourable factor must be `K₃` itself"; gap-freedom repairs `C₅ × K₄`; "No citation of GL may carry D3.4" | **all hold**; the gap-freedom repair is GL's own Theorem 1 hypothesis, on the non-`K_n` factor |
| `plans/SESSION-HANDOFF-2026-09-20.md`:120 | "not GL, false in general — `C₅ × K₄` — and true under gap-freedom/tightness" | first two hold; "true" **overstates** (as `BIBLIOGRAPHY.md`:66) |
| `plans/STUB-tight-product-colourings.md`:3 | GL is §5.4's `G = K_k` | **holds** (PA-P2) |
| `plans/STUB-tight-product-colourings.md`:36–38 | nearest printed statement GL via Tardif; "the colourable factor must be `Kₙ`"; "None of the four originals has been read" | quote holds; add Theorem 1's form; "unread" stale for GL |
| `plans/STUB-tight-product-colourings.md`:58 (D1) | "If the tight case is printed, this stub closes as a citation" | printed only for `G = K_k^s` (§4); the stub does not close |
| `plans/FRONTIER-STUBS.md`:53 (FS-67 row) | "it is not Greenwell–Lovász"; "the four originals are unread" | "not GL" **holds** for general tight `G`; GL settles `G = K_k^s` (including `Γ₃`, `U₂`); "unread" stale for GL |
| `plans/FS85-derivation.md`:97 (dB3, product route) | `K_k × Y`, `Y` connected, triangle-free, order prime to `k`, `χ(Y) > k`, uniquely `k`-colourable (KS Thm 4.2 after GL) | **holds** — Corollary 1; circulance and triangle-freeness are one line each |
| `plans/FS85-input-audit.md`:277, 314, 317, 376 | GL credited for the product mechanism of IA5 | **holds** (Corollary 1) |
| `plans/FS85-derivation.md`:352; `plans/FS85-C-deBruijn.md`:347; `plans/POROS-2026-09-24-fs85-competition.md`:476, 716; `plans/FS85-R3-five-part.md`:136; `plans/FS85-close-inventory.md`:153; `plans/FS85-rigidity-without-triangles.md`:1019 | the "Greenwell–Lovász shape/question": is every colouring of a sparse product pulled back from the tight factor? | **a reading, not an instance**, correctly labelled as such where labelled: GL treats full direct products of loopless graphs with a `K_n` factor; the 5-part graph is a subgraph of a product whose 3-part factor has loops (FS85-C-deBruijn:345), and no factor is complete |
| `plans/POROS-2026-09-24-fs85-competition.md`:115 | "`G ↛ N(H)`; for `H = K₄` it is Greenwell–Lovász" | **holds**: GL's `γ'` 4-colours `N(K₄)`, so a connected `G` with `χ(G) ≥ 5` has no such map |
| `plans/COXETER-2026-09-08-mascot.md`:59 | "the Greenwell–Lovász phenomenon (`K_n` is uniquely `n`-colourable in the categorical product)" for `K₄ × K₄` | the fact used **holds** (Corollary 3); the gloss **misnames it** — `K₄ × K₄` has two colourings, and uniqueness (Corollary 1) needs `χ > n` |
| `plans/MASCOT-derivation.md`:135, 150–154 | `K₄ × K₄` has exactly 48 proper 4-colourings, each a projection; "check owed: `[GreenwellLovasz1974]` … not held" | **holds** (Corollary 3: 2 × 4! = 48); same gloss issue; the check is **paid** |
| `plans/FS86-dyadic-rigidity.md`:314 | topic list: uniquely colourable graphs (GL; KS) | holds |
| `plans/M50-batch-descent.md`:798 | "K₅ projectivity — theorem CONFIRMED (Greenwell–Lovász 1974; Larose–Tardif 2002, 'strongly projective graphs')" | GL half **holds** (Corollary 3, `n = 5`); LT2002 states `K_m` projective (p. 163) but has no "strongly projective" |
| `plans/M50-derivation.md`:98–104, 129–133 | GL the base fact, strengthened by LT2002's "strongly projective" result (Inv–Pol with a trivial polymorphism clone) | GL **holds**; "strongly projective" **misattributed**; "trivial polymorphism clone" inexact (§0 item 6); the consequence (every `S₅`-invariant relation pp-definable from `≠`) is true by the Galois correspondence given Corollary 3, and is in neither paper |
| `plans/STANDING-QUESTIONS.md`:103–104 (T6) | "(Greenwell–Lovász 1974; Larose–Tardif, 'Strongly projective graphs', Canad. J. Math. 2002)" | GL **holds**; the second citation has the **wrong authors** — Larose alone |

## 4. Question 3: the bearing on FS-67's restatement (`plans/PA-tardif2023.md` §5.4)

**Is §5.4 in either paper?** Not as stated. Neither paper defines `K_k^G` or the improper part `E_k(G)`, and neither quantifies over
all connected `H` with `χ(H) > k`. **In part, yes:** Greenwell–Lovász's proof of Theorem 1 is §5.4 at `G = K_k`, both halves:
- **Loops are isolated (§5.4 (i)).** Case 1 shows a vertex whose fibre is a bijection propagates it unchanged to every neighbour.
- **`χ(E_k(K_k)) ≤ k` (§5.4 (iii)).** Case 2's `γ'`, a repeated value of a non-injective map, is a proper `k`-colouring of the
  non-injective maps, and it colours each map within its own image (PA-P2).

Poros's FS-85 record already had the dichotomy (i)–(ii) at `k = 4` (`plans/POROS-2026-09-24-fs85-competition.md`:104–117, hunch
P-prod, "never sent"). §5.4's "recorded nowhere in FS-67's stub or FS-86's derivation" is true at that scope, but the close planner may
want to credit that record.

**Does Larose–Tardif's projectivity answer it for a class?** Not by itself:
- **Its objects are the wrong ones.** Projectivity concerns idempotent maps `G^n → G`, and the independent-set theorems concern powers
  `G^n`, whose cofactor has `χ ≤ χ(G)`.
- **For `G = K_k` it is Greenwell–Lovász again.** Idempotent maps of powers of `K_k` are Corollary 3.
- **Truncated simplices are a caution.** They are vertex-transitive and projective, yet `T_s²` has non-canonical maximum independent
  sets. So "projective" does not give "colour classes of `G × H` are canonical".

**What does answer it for a class:**
- **Complete-graph powers.** For `G = K_k^s` (`k ≥ 3`) FS-67 holds for every connected `H` with `χ(H) > k`, finite or not (PA-P3; in
  print, by its review, as Larose CJM 2002's main theorem). These graphs are Hoffman-tight at `k`: degree `(k−1)^s`,
  `λ_min = −(k−1)^{s−1}`.
- **Among G54's targets** this is **`Γ₃ ≅ K₃ × K₃`** and **`U₂ = K₄`**, and products of their copies, e.g. G70's `K₄ × K₄` (PA-P4).
  It does not reach FS-58's `S₁`, `U₃₂`, `U₄`, or any tower level ≥ 2.
- **Vertex-transitive `G` and `H`.** Here the tool is `[Zhang2012]`, the descendant of LT's Problem 6.1, not LT (PA-P5). With `G`
  vertex-transitive and `α(G) = |G|/k`, every `k`-colouring of `G × H` is a pullback from `G` whenever `H` is vertex-transitive and
  connected with `χ(H) > k` and either:
  - `χ_f(H) > k`, the strict case already in the stub; or
  - `χ_f(H) = k`, provided `G` and `H` are IS-primitive.

  **What is left** for vertex-transitive `H` is `χ_f(H) < k < χ(H)`. Then the colour classes need not be maximum and MIS-normality
  says nothing. That is exactly Tardif's regime, and every non-vertex-transitive `H`.

## 5. Reference lists mined

**Greenwell–Lovász** (p. 340):

| ref | work | here |
|---|---|---|
| [1] | P. Erdős, *Graph theory and probability II*, Canad. J. Math. 13 (1961) 346–352 | not held, not cited |
| [2] | P. Erdős, A. Hajnal, *On chromatic graphs* (Hungarian, English summary), Mat. Lapok 18 (1967) 1–4 | not held, not cited |
| [3] | F. Harary, S. T. Hedetniemi, R. W. Robinson, *Uniquely colorable graphs*, J. Combin. Theory 6 (1969) 271–278 | not held, not cited |
| [4] | J. Nešetřil, *On uniquely colorable graphs without short cycles*, "to appear in Cas. Pest. Math." | = `[Nesetril1973]` (Čas. Pěst. Mat. 98 (1973) 122–125), **held, read in full** |

**Larose–Tardif** (p. 171):

| ref | work | here |
|---|---|---|
| [1] | M. O. Albertson, K. L. Collins, *Homomorphisms of 3-chromatic graphs*, Discrete Math 54 (1985) 127–132 | named in `[HahnTardif1997]`'s row, not held; Lemma 1.1 here prints its statement |
| [2] | R. Ahlswede, L. H. Khachatrian, *The complete intersection theorem for systems of finite sets*, European J Combin 18 (1997) 125–136 | not held, not cited |
| [3] | R. Ahlswede, H. Aydinian, L. H. Khachatrian, *The intersection theorem for direct products*, European J Combin 19 (1998) 649–661 | not held, not cited |
| [4] | J. A. Bondy, P. Hell, *A note on the star chromatic number*, J Graph Theory 14 (1990) 479–482 | not held, not cited |
| [5] | E. Corominas, *Sur les ensembles ordonnés projectifs et la propriété du point fixe*, C R Acad Sci Paris Sér I 311 (1990) 199–204 | not held, not cited |
| [6] | D. Duffus, B. Sands, R. E. Woodrow, *On the chromatic number of the product of graphs*, J Graph Theory 9 (1985) 487–495 | `BIBLIOGRAPHY.md` § R.4 item 9, not held |
| [7] | P. Erdős, C. Ko, R. Rado, *Intersection theorems for systems of finite sets*, Quart J Math 12 (1961) 313–320 | not held, not cited |
| [8] | D. Greenwell, L. Lovász, 1974 | `[GreenwellLovasz1974]`, held, read (§1) |
| [9] | A. J. W. Hilton, E. C. Milner, *Some intersection theorems for systems of finite sets*, Quart J Math Oxford (2) 18 (1967) 369–384 | not held, not cited |
| [10] | B. Larose, C. Tardif, *Hedetniemi's conjecture and the retracts of a product of graphs*, Combinatorica 20 (2000) 531–544 (Zbl 0996.05065) | not held, not cited; its Thm 1.4 carries LT's Thm 6.2 |
| [11] | B. Larose, C. Tardif, *Strongly rigid graphs and projectivity*, "to appear in Multiple-valued Logic" | not held, not cited; the source of Theorem 2.1. zbMATH 1009.05121 (2001) carries its summary with the title suppressed; volume and pages unconfirmed |
| [12] | X. Zhu, *Star chromatic numbers and products of graphs*, J Graph Theory 16 (1992) 557–569 | not held, not cited |

**Not cited by either, and bearing** (zbMATH API, 2026-09-25):
- **B. Larose, *Strongly projective graphs*, Can. J. Math. 54(4) (2002) 757–768, Zbl 1020.05029.** Reviewer's review read (M. Frick),
  paper not held. The review states its main theorem: "If a connected graph G does not admit a homomorphism into K, where K is an odd
  cycle or a complete graph of order at least 3, then, for every s ≥ 1, the graph G × K^s admits exactly s homomorphisms into K (up to
  automorphisms of K)", via exponential graphs `E_s(K) = K^{K^s}`. The review's definition of `K^G` has an `f`/`g` slip.
- **B. Larose, *Families of strongly projective graphs*, Discuss. Math. Graph Theory 22(2) (2002) 271–292, Zbl 1029.05133.** Listing
  only.
- **C. Y. Ku, B. B. McMillan, *Independent sets of maximal size in tensor powers of vertex-transitive graphs*, J. Graph Theory 60
  (2009) 295–301.** Second-hand via `[Zhang2012]`, which says it answers LT's Problem 6.1.

## 6. Proposed bibliography rows (for the close planner)

| key | entry | role | copy | read |
|---|---|---|---|---|
| **[GreenwellLovasz1974]** | D. Greenwell, L. Lovász, *Applications of product colouring*, Acta Math. Acad. Sci. Hungar. 25(3–4) (1974) 335–340, doi 10.1007/BF01886093, zbMATH 0294.05108 (received 14 May 1973) | **Thm 1 (p. 335):** "Suppose G is a connected graph such that any two n-colourings of G differ in at least two points. Then each n-colouring of K_n × G is induced by an n-colouring of one of the factors" — the hypothesis is gap-freedom (G68). **Cor. 1 (p. 336):** "If χ(G) > n and G is connected then K_n × G is uniquely n-colourable" (row 86, FS-85 IA5). **Cor. 3 (p. 336, n ≥ 3):** "(K_n)^k has exactly k n-colourings" (G70's `K₄ × K₄`; M50's `K₅` projectivity). **Thm 2:** α(K_n^k) = n^{k−1}, maximum sets fix one component. Thm 3: line/point-critical extensions. **Thm 4:** colourings of infinite powers of `K_n` are induced by 0–1 measures (Pósa; Lempert). Question (b), p. 335, is Hedetniemi's conjecture. FS-67 holds for `G = K_k^s` by Thm 1 (`plans/PA-products-GL1974-LT2002.md` PA-P3) | `pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf` (scan, no text layer) | **read in full** (`plans/PA-products-GL1974-LT2002.md` §1) |
| **[LaroseTardif2002]** | B. Larose, C. Tardif, *Projectivity and independent sets in powers of graphs*, J. Graph Theory 40(3) (2002) 162–171, doi 10.1002/jgt.10041, zbMATH 1003.05077 | Projectivity (idempotent maps `G^n → G` are projections) against canonical maximum independent sets of powers. `K_m` (`m ≥ 3`) projective, stated p. 163. Lemma 1.1: the Albertson–Collins no-homomorphism lemma with its equality case. Cor. 1.1: `α(G^n) = α(G)|V(G)|^{n−1}` for vertex-transitive `G`. Circular graphs projective with canonical maximum independent sets in every power (Thms 3.1, 3.2); Kneser graphs the same (Fact 4.1, Cor. 4.1); truncated simplices projective with non-canonical ones in the square (Thm 5.1). Problem 6.1 (answered: Ku–McMillan 2009; Zhang). Thm 6.2: circular analogue of Duffus–Sands–Woodrow. **Not the source of "strongly projective"** (that is `[Larose2002]`); no statement about `G × H` colourings | `pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf` | **read in full** (`plans/PA-products-GL1974-LT2002.md` §2) |
| **[Larose2002]** (new, § R.4 candidate) | B. Larose, *Strongly projective graphs*, Can. J. Math. 54(4) (2002) 757–768, zbMATH 1020.05029 | The "strongly projective" source M50 and `plans/STANDING-QUESTIONS.md` meant. By its review: `G` connected with no homomorphism to `K` (odd cycle or `K_n`, `n ≥ 3`) ⟹ `G × K^s` has exactly `s` homomorphisms to `K` up to `Aut K` — FS-67 for `G = K_k^s`, via exponential graphs | not held | **review only** (zbMATH reviewer's review, M. Frick) |

## 7. Theorems this reading proved

| id | statement | grade | where / kernel decision |
|---|---|---|---|
| PA-P1 | GL Theorem 1's hypothesis "any two `n`-colourings of `G` differ in at least two points" ⟺ every `n`-colouring of `G` is gap-free (no closed neighbourhood misses a colour); vacuous iff `χ(G) > n` | hand (two lines) | §1.3; decline (definitional) |
| PA-P2 | GL's `γ'` (a repeated value) is a proper `k`-colouring of `E_k(K_k)` that colours each map within its image: if `f ~ g` are non-injective, `γ'(f) = f(i) = f(i')`, `i ≠ i'`, and for every `m` one of `i, i'` differs from `m`, so `γ'(f) ≠ g(m)`; hence `γ'(f) ∉ g([k])` | hand | §4; candidate for FS-67's D4 kernel form with PA-T6 |
| PA-P3 | For `k ≥ 3`, `s ≥ 1`, `H` connected with `χ(H) > k` (any cardinality): the `k`-colourings of `K_k^s × H` are exactly `σ ∘ pr_i`, `i ≤ s`. Induction on `s`: `G' = K_k^{s−1} × H` is connected (Weichsel; `H` non-bipartite), its colourings `σ ∘ pr_i` are gap-free, so GL Thm 1 applies to `K_k × G'` | hand, from GL Thm 1 (Weichsel's connectivity theorem cited, not held); in print by review as `[Larose2002]` | §4; stub FS-67 (the class it settles) |
| PA-P4 | `Γ₃ = Cay(𝔽₃², {(±1,0),(0,±1)}) ≅ K₃ × K₃` via `(a, b) ↦ (a+b, a−b)` (invertible over `𝔽₃`, onto `{(±1,±1)}`); `U₂ = Cay(𝔽₄, μ₃) = K₄`; so FS-67 holds for these targets and their direct powers. FS-58's 81-vertex `S₁` (degree 8) is no direct power of `K₃` (`K₃^4` has degree 16) | hand | §4; decline (two lines) |
| PA-P5 | `G`, `H` vertex-transitive, `α(G) = |G|/k`, `H` connected, `χ(H) > k`, `α(H)/|H| ≤ 1/k`: if `G × H` is MIS-normal, every `k`-colouring of `G × H` is a pullback from `G` (classes are maximum by Zhang's equality; a `G`-type and an `H`-type preimage meet; all `H`-type would `k`-colour `H`). By `[Zhang2012]` Thm 1.8 (arXiv v1 as held) MIS-normality holds in the strict case, and in the equal case when both factors are IS-primitive | hand, conditional on Zhang's Thm 1.8 as printed | §4; FS-67 stub, to be checked against rows 88–89 |

## 8. For the close planner

1. **`LEDGER.md` row 86:** add "connected" to `Y` in the product-route sentence.
2. **G70:** the citation holds. If it is ever expanded, it should name Corollary 3, not "uniquely colourable".
3. **Stale "unread" and "check owed" markers for GL:**
   - `plans/FRONTIER-STUBS.md` row 10;
   - FS-67's stub §2 and D1;
   - `plans/FS58-derivation.md` and `plans/FS58-four-colours.md`;
   - `plans/MASCOT-derivation.md`.
4. **"True under gap-freedom/tightness"** is an overstatement in `BIBLIOGRAPHY.md`:66 and `plans/SESSION-HANDOFF-2026-09-20.md`:120.
   In print it holds only for tight factors `K_k^s`.
5. **The "strongly projective" misattribution** sits in three places:
   - `plans/M50-batch-descent.md`:798;
   - `plans/M50-derivation.md`:100–101, 131–132;
   - `plans/STANDING-QUESTIONS.md`:104.

   Re-attribute it to `[Larose2002]`, and list that paper in § R.4. The M50 consequence rests on GL Corollary 3 and the Galois
   correspondence, so it can be promoted from *reading*, grade hand.
6. **FS-67's stub:** Larose CJM 2002 is the D1 item most likely to hold the tight case in exponential-graph form. The equal-ratio half
   of Zhang's Theorem 1.8 (PA-P5) bears on the re-aim's "what is left".
7. **Credit:** §5.4's dichotomy was first written in `plans/POROS-2026-09-24-fs85-competition.md` hunch P-prod (at `k = 4`).
8. **Found while checking, unrelated to the two papers:** the equality clause of LT2002's Lemma 1.1 is the printed form of
   `[HahnTardif1997]`'s recalled ratio statement. Its core-divisibility half remains unchecked.
