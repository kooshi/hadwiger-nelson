# FS131-PAS3 — Kubicki, Lehel and Morayne 2002, read in full against rational four-space at four colours

*Job FS131-PAS3 (brief `data/fs131/briefs/FS131-PAS3-kubicki-lehel-morayne.md`, written 2026-10-17 00:55 UTC). Ephodos, the prior-art
gate (§PA) on one paper and one result. Worktree `.claude/worktrees/filing2`, branch `fs131-pas3`, cut from `main` at `1253d345c`.
The paper: G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin. Theory Ser. B
84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030 — held as
`~/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (nine pages, a text layer;
received 17 December 1999, published online 27 August 2001). Cited below as KLM.*

## Theorems this phase proved

Written at stage 3 (none before it).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

- The three block quotations (inventory items 1075, 1080, 1082) are verbatim in `plans/FS131-close-inventory.md`, on `main` and in
  this worktree: `data/fs131/pas3/quote_check.py` (whitespace collapsed, each block a substring of the source) prints `quotations: 3
  verbatim: 3`, exit 0; with one character planted in each (`--plant`) it prints `verbatim: 0`, exit 1 — the control fires.
- The two inline quotations of the paper's abstract are in its text layer (`pdftotext`, p. 45): *"We show that every 2-coloring of
  Q 2 or Q 3, and every 4-coloring of Q 4 is rigid."* (the brief's *"every 2-coloring of Q 2 or Q 3, and every 4-coloring of Q 4 is
  rigid"*, verbatim, exponents flattened by the text layer) and *"rigid colorings which uniquely extend from any open subset of Q n"*
  (the brief's *"uniquely extend[s] from any open subset of Q n"*, with the brief's bracketed inflection). **No mismatch.**
- The probe's phrases (item 1075, `plans/FS131-PAS2-prior-art.md` § 2.1) are all words of the printed abstract: *"Q^4 is rigid"*,
  *"every 4-coloring of"*, *"uniquely extend"*, *"points at distance one get distinct colors"* (the abstract reads *"any two points at
  distance one get distinct colors"*). The probe's misses (*"dense"*, *"component"*, *"unique"*, *"forbid"*) are absent from the abstract
  too: the probe read the abstract correctly. What it could not read is what "rigid" means; § 2.1 answers it.

### 1.2 C7, A3 and the two drafted forms, in my words

- **C7** (`CLOSED-QUESTIONS.md` § 3, *"Which distances can a four-colouring of `ℚ⁴` forbid beside 1?"*). Johnson asks (`[Johnson2006]`
  p. 212, again `[Johnson2010]` p. 169) for which `d > 0` some proper four-colouring of the unit-distance graph on `ℚ⁴` also gives
  different colours to every pair at distance `d`. The entry's answer, verbatim: *"for `d` realised in `ℚ⁴` (`d² ∈ ℚ`; for `d² ∉ ℚ` no
  pair is at distance `d` and a colouring exists trivially — LX's scope repair), exactly the `d` with `d² = p/q`, `p, q` odd — and then
  every proper four-colouring forbids `d`."* Under it sits the compulsion law (LV-T3 = LX-T5): with `w(z) = v₂(|z|²)`, a pair `x ≠ y`
  is forced equal in every proper four-colouring when `w(x − y) ≥ 1`, forced different when `w(x − y) = 0`, and free (some colouring
  joins it, some splits it) when `w(x − y) < 0`. Its parts, as the brief names them: the compulsion law (three clauses), A3, and
  the answer to Johnson's question.
- **A3** (`.claude/worktrees/il5/plans/FS131-KFS1-four-space-plan.md` § 1.2, read only): *"Every proper four-colouring is, on each
  component `x₀ + R`, the residue map `R → R/P ≅ 𝔽₄` followed by a bijection to the colours, where `R = {w ≥ 0} = H ⊗ ℤ₍₂₎` (`H` the
  Hurwitz order) and `P = {w ≥ 1} = (1 + i)R`."* In my words: each component of `G(ℚ⁴, 1)` has one proper four-colouring up to
  renaming the colours — it is **uniquely four-colourable** — and that colouring is reduction modulo the prime of the quaternion order
  above 2. KFS1's § 2.1 builds it from Zaks's Lemma 1 (forced equal at `√2`), the component of the origin (`⟨S⟩ = R`), and the unit
  tetrahedron `T = {0, 1, h, h′}` meeting the four residue classes once each.
- **Form (A)** (`plans/FS131-PAS2-prior-art.md` § 2.4 item 1, to be used *"if Kubicki–Lehel–Morayne 2002 does not prove the residue
  structure"*): the answer is not found in print; Johnson poses it again in 2011 with this answer as his guess; the similarity step is
  `[BauJohnsonNoble2021]` Thm 3.3.
- **Form (B)** (the same item, *"if it does"*): the answer is in print in part — every four-colouring of `ℚ⁴` is rigid, from which the
  answer follows with Benda–Perles's components and `[Johnson1990]` Thm 3; neither posing by Johnson cites the paper; ours is the
  residue form and the derivation of the forbidden distances.
- **Draft 2** (the same § 2.4, item 2): Johnson–Voloshin 2007's question on the period group of a four-colouring of `ℚ⁴`, answered by
  `[Zaks1999]` Lemma 1 with the component structure; held because its attribution might move with this paper.

What form (B) presumes, stated so it can be checked: that KLM's "rigid" carries A3, i.e. that a four-colouring of `ℚ⁴` is fixed by
data that every colouring shares up to a renaming (a unit tetrahedron, say). Stage 2 reads what "rigid" means.

## Stage 2 — SAVED: the reading

Read in full, pp. 45–53, from the page images and the text layer (2026-10-17): the abstract, § 1 (introduction), § 2 (notation and
Theorems A–C), § 3 (patch colourings: Thms 3.1, 3.2, Cor. 3.3, Prop. 3.4), § 4 (rigid colourings: Lemma 4.1, Thms 4.2–4.4, Lemma
4.5, Thm 4.6), the acknowledgments and the seventeen references. Quotations below are from the text layer, exponents restored; the
page is the printed page.

### 2.1 What "rigid" means, and the paper's other definitions

- **Colouring** (p. 46): *"A proper coloring of the unit-distance graph G(A) with k colors is a partition of A into k independent sets,
  C₁, …, C_k. We will simply refer to 𝒞 = {C₁, …, C_k} as a k-coloring of A"*. A colouring is a partition: two colourings are equal
  when they are equal up to renaming the colours. Every "k-coloring" in the paper is proper.
- **Trace** (p. 49): *"We denote by 𝒞 | B the l-coloring of B consisting of all nonempty sets C₁ ∩ B, …, C_k ∩ B (l ≤ k)."*
- **Rigid** (p. 49), verbatim: *"For D ⊆ ℝⁿ, a k-coloring 𝒞 of D is said to be rigid if for every open set U ⊆ ℝⁿ intersecting D, and
  for every k-coloring 𝒞′ of D, the equality 𝒞 | (U ∩ D) = 𝒞′ | (U ∩ D) implies 𝒞 = 𝒞′. In other words, a k-coloring of D is rigid
  whenever its trace on any relatively open nonempty subset of D determines the coloring globally."*
- **`S^{n−1}`-dense** (p. 49): *"A k-coloring of ℚⁿ is called S^{n−1}-dense if each of the k − 1 colors is dense in S^{n−1} + x, for all
  x ∈ ℚⁿ."* (the `k − 1` colours other than the colour of `x`; `S^{n−1}` the unit sphere about 0, p. 46).
- **Patch colouring** (p. 47): *"A k-coloring 𝒞 = {C₁, …, C_k} of a set A ⊆ ℝⁿ is called a patch coloring of A provided there are pairwise
  disjoint open sets U_i ⊆ ℝⁿ such that C_i ⊆ cl(U_i)."*

**So "rigid" is uniqueness of extension from an open set, not from a few points.** The data a rigid colouring is recovered from is its
trace on `U ∩ ℚ⁴` for an open `U` — infinitely many points, dense in `U`, from every component of `G(ℚ⁴, 1)` (each component is a
coset of a dense subgroup). And when `U` is a ball of diameter below 1, that trace contains no unit pair: properness puts no
constraint on it. Rigidity says the map from colourings to their traces on `U` is one-to-one; it says nothing about which traces
occur. A3 says the opposite kind of thing: a component's colouring is fixed, up to renaming, by no data at all — the component is
uniquely four-colourable. The reading form (B) presumed (*"determined, on each component, by its values on a few points (a unit
tetrahedron, say)"*, `plans/FS131-PAS2-prior-art.md` § 2.3 item 3) is not the paper's.

### 2.2 Every result about `ℚ⁴`, or about `ℚⁿ` or `Fⁿ` at `n = 4`, quoted

- **Theorem A** (p. 46, de Bruijn–Erdős): *"Every graph G with finite chromatic number χ(G) has a finite subgraph H such that χ(H) =
  χ(G)."* **Theorem B** (p. 47, "folklore"): *"If A is a residual subset of ℝⁿ and X ⊆ ℝⁿ is countable, then there exists v ∈ ℝⁿ such that
  X + v ⊆ A."* **Theorem C** (p. 47): *"The set ℚⁿ is dense in S^{n−1}."* (credited to Sierpiński for `n = 2`, "by induction on n" in
  general).
- **Theorem 3.1** (p. 47): *"If A is a residual subset of ℝⁿ then χ(A) = χ(ℝⁿ)."* — de Bruijn–Erdős's finite witness translated into `A` by
  Theorem B. Then: *"It is worth noting that the analogue of Theorem 3.1 with the full measure sets replacing the residual sets is also
  true. The proof based on the measure version of Theorem B remains the same."*
- **Theorem 3.2** (p. 47): *"Let A ⊆ ℝⁿ be a nonempty set which is dense in S^{n−1} + x, for all x ∈ A. If A has a patch k-coloring, then
  there exists a k-coloring of ℝⁿ."* **Corollary 3.3** (p. 48): *"If ℚⁿ has a patch k-coloring, then there exists a k-coloring of ℝⁿ."*
  And p. 48: *"Notice that every connected component of the unit-distance graph G(ℚⁿ) also satisfies the hypothesis of Theorem 3.2. Thus
  one can slightly strengthen Corollary 3.3, for n = 2, 3, 4, by replacing ℚⁿ with any connected component of G(ℚⁿ). For n ≥ 5, Benda
  and Perles [1] proved that G(ℚⁿ) is connected. For n = 2, 3, and 4, G(ℚⁿ) has infinitely many connected components"*.
- **Lemma 4.1** (p. 49): *"Every k-coloring of ℚⁿ which is S^{n−1}-dense is also rigid."* Its proof: a point `x` with `x − s ∈ U` for a
  rational unit `s` sees, inside `(S^{n−1} + x) ∩ U`, points of all `k − 1` other colours, so its colour is the remaining one in both
  colourings; repeat along sums of rational unit vectors (Theorem C).
- **Context** (p. 49): *"It is also known that the minimum number of colors necessary to color ℚ⁴ is four (and no chromatic colorings are
  known for n ≥ 5). Johnson asked in [6] whether all colors are dense in any 4-coloring of ℚ⁴. Zaks answered this question in the
  affirmative in [16]. … By extending Zaks' arguments we are able to prove a slightly stronger density property of chromatic colorings."*
- **Theorem 4.3** (p. 50), the paper's one theorem on `ℚ⁴`: *"Every 4-coloring of ℚ⁴ is S³-dense and, therefore, rigid."* Proof, in
  full: *"Zaks proves in [16] that each color of any 4-coloring of ℚ⁴ is a dense set in ℚ⁴. He proves the fact that if x, y, u, w ∈ ℚ⁴
  are vertices of a regular tetrahedron of unit side length, then, for every ε > 0, the set (S³ + x) ∩ B(y; ε) contains infinitely many
  points of all colors different from that of x. Thus to prove S³-density it is enough to see that for any x, y ∈ ℚ⁴ with dist(x, y) = 1,
  there exist rational points u, w ∈ ℚ⁴ such that (x, y, u, w) is a regular tetrahedron."* — then the matrix `A(y)` with rows
  `(y₁, y₂, y₃, y₄)`, `(y₂, −y₁, y₄, −y₃)`, `(−y₃, y₄, y₁, −y₂)`, `(y₄, y₃, −y₂, −y₁)`, `A y = y′ = (1, 0, 0, 0)`, and the tetrahedron
  `{0, y′, u′, w′}`, `u′ = (1/2, 1/2, 1/2, 1/2)`, `w′ = (1/2, −1/2, 1/2, 1/2)` (*"also used in [16]"*), pulled back by `A⁻¹`. **Checked
  here** (entry `klm-tetrahedron`): `A Aᵀ = |y|² I` and `A y = (|y|², 0, 0, 0)` as polynomial identities (sympy; one sign flipped in
  row 3 breaks the first), and over 1,032 rational unit vectors the six distances of `{0, y, A⁻¹u′, A⁻¹w′}` are 1
  (`tools/fs131_pas3_check.py matrix`, 0 failures; planted sign fault, 677). The step the paper adds to `[Zaks1989]` is sound.
- **After it** (p. 50): *"As an extension of Theorem 4.3, S^{n−1}-density and thus rigidity can be also added to a general result by
  Zaks [16]."* — **Theorem 4.4** (p. 51): *"Let F be any subfield of ℝ. If χ(G(Fⁿ)) = m, G(Fⁿ) has a maximal complete subgraph with m
  vertices, and m − 1 ≠ 2^r, for any integer r > 0, then every m-coloring of G(Fⁿ) is S^{n−1}-dense and, therefore, rigid."* *"We omit
  the proof; it bears roughly the same relation to the proof of Zaks' Theorem 2 in [16] as the proof of our Theorem 4.3 to that of Zaks'
  Theorem 1 in [16]."* At `F = ℚ`, `n = 4`, `m = 4` it restates Theorem 4.3.
- **Open, by the paper** (p. 50): *"The obvious question whether the converse of Lemma 4.1 is true, that is rigid colorings of ℚⁿ are
  always S^{n−1}-dense, remains open."*; (p. 49) *"we do not know whether there are rigid k-colorings of ℚ², for any k > 3."*

**Nowhere in the paper:** a pair of points that every four-colouring colours alike or differently (beyond distance 1 itself), the
2-adic valuation or any parity of denominators in `ℚ⁴`, quaternions as an algebra (the matrix is used only as a rational rotation), a
second forbidden distance, a classification or count of the four-colourings, the words "unique" or "component" applied to a
colouring. The paper does not cite `[Zaks1999]`, `[Johnson2006]`, `[Fischer1990]` or `[Chilakamarri1988]`.

### 2.3 The rest of the paper

- **Proposition 3.4** (p. 48): the chessboard two-colouring of `ℚ²` is a patch colouring for every `ℓ_p` metric with integer `p > 2`, by
  Fermat's Last Theorem; *"Q² has no patch 2-coloring with respect to the l_p-metric, for p = 2. In fact, as it is well-known, each color
  in every 2-coloring of ℚ² is dense."* No bearing.
- **Theorem 4.2** (p. 50): *"Every 2-coloring of ℚ² and, every 2-coloring of ℚ³ is rigid."*
- **Lemma 4.5 and Theorem 4.6** (pp. 51–52): *"There exists an S¹-dense and, thereby, rigid 3-coloring of ℚ²."* Decoded: on the 3-integral
  points `G^{[3]}` (denominators prime to 3), the class `A_i = ⋃ ([jb]/[b], [(i + j)d]/[d])` is `{(α, β) : β − α ≡ i (mod 3)}` (a numerator
  `≡ jb` over a denominator `≡ b` is `≡ j`), extended to `ℚ²` by coset representatives. It is an additive colouring by a character of
  `ℤ₍₃₎²` onto `𝔽₃`, non-zero on every rational unit vector because exactly one of the numerators of `(a/c, b/c)` is divisible by 3 — the
  `[Fischer1990]`-type colouring at the prime 3 (G38), printed here as a rigid colouring of a 2-chromatic space.

### 2.4 C7's parts against the paper

| C7's part | stated in KLM? | implied in a few lines? | what KLM has |
|---|---|---|---|
| compulsion law, forced equal (`w(x − y) ≥ 1`) | no | no — its tools (Lemma 4.1, Zaks's density lemma, the tetrahedron through each unit edge) conclude density and recovery from a trace; none produces a pair every colouring colours alike, and that is the step C7 needs (`[Zaks1999]` Lemma 1, at `√2`) | — |
| forced different (`w = 0`) | at distance 1 only, by definition | no | each colour other than `c(x)` is dense on the unit sphere about `x` (Thm 4.3) |
| free (`w < 0`) | no | no | p. 48: infinitely many components for `n = 4` (Benda–Perles) — the reason pairs in different components are free |
| A3 (residue form, per component) | no | **no; the other way round** — A3 implies Thm 4.3 in a few lines (entry `klm43-from-structure`, § 3.3.1); Thm 4.3 does not give A3, because recovery from a trace on an open set is not uniqueness, and the paper's own Thm 4.6 separates the two (entry `rigid-not-unique`, § 3.3.2) | Thm 4.3, a consequence of A3 |
| the answer to Johnson's question (`d² = p/q`, `p, q` odd) | no | no — the paper never names a distance other than 1; it cites Johnson's [6] (`[Johnson1990]`) only for the density question | — |

**The paper's notion against A3, exactly.** Write `ρ_C` for the residue map on a component `C`. A3: every colouring is `σ_C ∘ ρ_C` on
each `C`. Thm 4.3 (rigidity half): two colourings that agree up to one renaming `σ` on `U ∩ ℚ⁴` agree up to `σ` everywhere. A3 implies
the second because every residue class of every component is dense in `ℝ⁴`, so `U` sees all four classes of each component and pins
`σ_C′ = σ ∘ σ_C` there. The second does not imply the first: it bounds no count of colourings, and on `ℚ²` at three colours the paper's
rigid colouring and its mirror image are two rigid colourings that differ, on one component, by no renaming. So KLM's rigidity is
strictly weaker than A3 as a property of a colouring; on `ℚ⁴` at four colours both hold, and A3 is the one that answers Johnson.

### 2.5 The reference list (p. 52–53), mined

| KLM ref. | work | this repository |
|---|---|---|
| [1] | Benda–Perles, Colorings of metric spaces, Geombinatorics 9 (2000) 113–126 | `[BendaPerles2000]`, read in full |
| [2] | de Bruijn–Erdős 1951 | `[deBruijnErdos1951]`, not held |
| [3] | K. B. Chilakamarri, Unit-distance graphs in Minkowski metric spaces, Geom. Dedicata 37 (1991) 345–356 | **not in the bibliography** (Zbl 0716.05022) |
| [4] | H. Hadwiger, Portugal. Math. 4 (1944) 140–144 — KLM print the title *"Überdeckungssätze für den Euklidischen Raum"*; zbMATH has *"Ein Überdeckungssatz für den Euklidischen Raum"* | **not in the bibliography** (Zbl 0060.40610) |
| [5] | T. Jensen, B. Toft, Graph Coloring Problems, Wiley 1995 | **not in the bibliography** (Zbl 0855.05054) |
| [6] | P. D. Johnson Jr., Two-colorings of a dense subgroup of ℚⁿ that forbid many distances, Discrete Math. 79 (1990) 191–195 | `[Johnson1990]`, read in full |
| [7] | Larman–Rogers 1972 | `[LarmanRogers1972]`, listing only |
| [8] | J. Pach, Finite point configurations, Handbook of Discrete and Computational Geometry, CRC 1997, 3–18 | **not in the bibliography** (Zbl 0914.51012) |
| [9] | M. Reid, On the connectivity of unit distance graphs, Graphs Combin. 12 (1996) 295–303 | `[Reid1996]`, named only |
| [10] | W. Sierpiński, Elementary Theory of Numbers, North-Holland/PWN 1988 | `[Sierpinski1964]` is the 1964 edition; listing only |
| [11] | A. Soifer, Chromatic number of the plane: a historical essay, Geombinatorics 1 (1991) 13–15 | `[Soifer1991]`, listing only |
| [12] | L. A. Székely, Erdős on unit distances and the Szemerédi–Trotter theorems (abstract, Budapest 1999) | **not in the bibliography** (the later chapter: Zbl 1035.05037) |
| [13], [14] | Taylor–Wiles, Wiles 1995 (Fermat's Last Theorem, for Prop. 3.4) | not entered: no bearing |
| [15] | Woodall 1973 | `[Woodall1973]` |
| [16] | J. Zaks, On four-colorings of the rational four-space, Aequationes Math. 37 (1989) 259–266 | `[Zaks1989]`, not held; reviewer's text and abstract only — **KLM add second-hand content**: its Theorem 1 (each colour of a four-colouring of `ℚ⁴` is dense), its tetrahedron lemma (above), and a Theorem 2 that KLM's Thm 4.4 extends to every subfield `F` of `ℝ` (p. 50) |
| [17] | J. Zaks, On the connectedness of some geometric graphs, JCTB 49 (1990) 143–150 | `[Zaks1990conn]`, listing only |

None of the unlisted works bears on C7. The zbMATH numbers were looked up for this table (`data/fs131/pas3/zb_refs.txt`).

### 2.6 Who cites the paper

`[Johnson2006]`'s reference list (pp. 216–218, read from the page images; the scan has no text layer) has 24 entries and not this
paper; `[Johnson2010]` (the held volume's text layer, which finds "Zaks" eleven times) never names Kubicki, Lehel or Morayne; nor does
`[Soifer2024]` (text layer; "Zaks" eleven times). OpenAlex lists no citing work (FS131-PAS2 § 2.1). Neither of Johnson's posings of
the question cites it — as expected, since it does not touch the question.

### 2.7 What else in the paper bears on this project's results

1. **Row 130's translation step.** Thm 3.1 with its measure remark (p. 47) is in print in 2002: `χ(A) = χ(ℝⁿ)` for every residual and
   every full-measure `A ⊆ ℝⁿ`, by de Bruijn–Erdős and a translate of the finite witness into `A` (Theorem B, and its measure form: for a
   conull `A` and countable `X` some translate `X + v` lies in `A`). Read against row 130: it is the mechanism of N-EASY
   (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`) and of the row's step *"every finite set can be translated into the density points"*, for the special
   hypothesis that the colouring is proper on every unit pair inside a conull set — no measurability asked, and no bad pairs except
   those meeting a null set. Neither contains the other: N-EASY allows a null set of bad *pairs* that need not come from a null set of
   points, and asks measurability. Row 130 credits N-EASY's argument to `[GwynStavrianos2022]` Lemma 2 (2022); KLM 2002 is an earlier
   printed instance of the same move for colourings proper on a conull or residual set. A prior-art line is drafted in § 3.4.
2. **Patch colourings and maps** (Thm 3.2, Cor. 3.3): `k` pairwise disjoint open sets with dense union, none containing two points at
   distance 1, give `χ(ℝⁿ) ≤ k` — the boundary need not be coloured, and need not be null (Thm 3.1's residual form carries a fat
   nowhere-dense boundary, which the measurable route does not). The map class this project works in has null boundaries, so this adds
   nothing to row 130's consequences there; it is a printed source for "a tight map's open tiles alone bound `χ`".
3. **Theorem 4.4 in the plane** reaches only `m = 2`: a plane's cliques have at most three points, and `m = 3` is excluded by
   `m − 1 = 2 = 2¹`. So the paper is silent on the one plane case where `χ = ω = 3`, `ℚ(√3)²` (G38), where `[Fischer1990]` Thms 8–9
   make every three-colouring additive (G61's account). Whether that gives rigidity there is not asked here (§ 3.5, a question routed).
4. **`χ(ℚ⁴) = 4` and the components** are cited to Benda–Perles and Chilakamarri's school, as this repository does; nothing new.
