# FS131-PAS3 — Kubicki, Lehel and Morayne 2002, read in full against rational four-space at four colours

*Job FS131-PAS3 (brief `data/fs131/briefs/FS131-PAS3-kubicki-lehel-morayne.md`, written 2026-10-17 00:55 UTC). Ephodos, the prior-art
gate (§PA) on one paper and one result. Worktree `.claude/worktrees/filing2`, branch `fs131-pas3`, cut from `main` at `1253d345c`.
The paper: G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin. Theory Ser. B
84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030 — held as
`~/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (nine pages, a text layer;
received 17 December 1999, published online 27 August 2001). Cited below as KLM.*

## Theorems this phase proved

- `klm43-from-structure` — if every proper four-colouring of `ℚ⁴` has A3's residue form, then every one is `S³`-dense and rigid in
  KLM's sense (KLM Thm 4.3, by a route independent of `[Zaks1989]`): [hand], one mind; § 3.2, argument § 3.3.1.
- `rigid-not-unique` — KLM Thm 4.6's rigid three-colouring of `ℚ²` and its mirror image are rigid three-colourings that no
  renaming of the colours relates on the component of the origin: [hand], one mind; § 3.2, argument § 3.3.2.
- `klm-tetrahedron` — KLM p. 50's step, every rational unit vector of `ℚ⁴` an edge of a rational regular unit tetrahedron, checked:
  [hand], one mind, prior art known (KLM's); § 3.2, argument § 3.3.3.

Nothing in the kernel. Nothing of C7 itself is derived here: C7 is the consolidation run's LV-T3 and LX-T5–T6.

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
  row 3 breaks the first), and over 729 rational unit vectors the six distances of `{0, y, A⁻¹u′, A⁻¹w′}` are 1
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

## Stage 3 — SAVED: the verdict, the entries, the drafts

### 3.1 Verdict: **form (A), brought to the reading** — C7 is not in this paper, and the paper's theorem is a consequence of C7's structure clause

1. **The paper does not state any of C7's parts, and implies none in a few lines** (§ 2.4): no forced pair, no second distance, no
   uniqueness. Its "rigid" (p. 49) is recovery of a colouring from its trace on an open set, which bounds no count of colourings.
2. **The implication runs the other way.** A3 gives KLM's Thm 4.3 — `S³`-density and rigidity — in a few lines (entry
   `klm43-from-structure`), so the library's Part A, once A3 lands, holds the printed theorem as a corollary, by a route that does not
   go through `[Zaks1989]` (closed, unread here).
3. **The paper's notion is strictly weaker than A3**, and the paper itself shows the gap: its rigid three-colouring of `ℚ²` and that
   colouring's mirror image are both rigid and differ on one component by no renaming (entry `rigid-not-unique`).
4. **So form (B) does not apply** (it presumed the paper proves the residue structure), and form (A) does, amended to name the paper so
   that a reader who meets *"every 4-coloring of Q⁴ is rigid"* sees it placed. Draft 2 (periods) is untouched by the paper.
5. **Not misstated.** C7 and A3, as `CLOSED-QUESTIONS.md` § 3 and the KFS1 plan state them, are not contradicted by anything in the
   paper; nothing in it is a statement defect for Part A. One thing the paper adds that the library could state: Thm 4.3 itself, as
   a corollary of A3 (§ 3.4 item 6, an option for the kernel lane).

### 3.2 The entries

derivation: klm43-from-structure
  statement: if every proper four-colouring of the unit-distance graph on ℚ⁴ is, on each component x₀ + R, a bijection of the
    colours composed with the residue map R → R/P ≅ 𝔽₄ (A3, with R = {w ≥ 0}, P = {w ≥ 1}, w(z) = v₂(|z|²)), then every proper
    four-colouring of ℚ⁴ is S³-dense and rigid in the sense of [KubickiLehelMorayne2002] p. 49
  uses only: A3; that the residue map R → R/P is a ring homomorphism onto a field of four elements in which 1, h = (1+i+j+k)/2 and
    h′ = (1+i+j−k)/2 lie in the three non-zero classes; that P contains (2/3ᵏ)ℤ⁴ for every k; that S³ ∩ ℚ⁴ is dense in S³ (KLM's
    Theorem C); that S³ is connected
  not claimed: that KLM's Theorem 4.3 gives A3 — rigidity is recovery from a trace, not uniqueness (entry rigid-not-unique); anything
    about the proof in [Zaks1989], which is unread here; the converse of KLM's Lemma 4.1, which the paper leaves open
  argument: § 3.3.1
  verdict: derived
  grade: hand
  minds: 1
  model: the residue colouring of ℚ⁴, with one bijection on every component — proper by [Johnson1990] Thm 3 (KFS1 plan step A8);
    it is the colouring A3 describes, so the hypothesis is inhabited
  prior art: partly: [KubickiLehelMorayne2002] Thm 4.3 states the conclusion, proved there from [Zaks1989]'s tetrahedron lemma; the
    route from A3 not found in print (not searched beyond this paper's citers, of which there are none)
  handoff: de Bruijn — optional, for FS131-KFS1's Part A: the rigidity half as a corollary of A3 (each P-coset is dense, so an open
    set sees every residue class of every component), stating the printed theorem in the library's words; the S³-density half needs
    the density of S³ ∩ ℚ⁴ in S³ and a closed subgroup of finite index in S³ being S³

derivation: rigid-not-unique
  statement: the 3-colouring 𝒜 of ℚ² constructed in [KubickiLehelMorayne2002] Thm 4.6 and its image μ𝒜 under the reflection
    μ(α, β) = (α, −β) are rigid 3-colourings of ℚ² in the sense of its p. 49; the points 0 and (7/5, 7/5), both in the component of
    the origin, lie in one class of 𝒜 and in two classes of μ𝒜, so no renaming of the colours carries 𝒜 to μ𝒜 on that component
  uses only: KLM's Thm 4.6 (𝒜 is rigid); that μ is an isometry of ℝ² mapping ℚ² onto itself; that on the 3-integral points 𝒜's
    classes are {β − α ≡ i (mod 3)} (p. 52's definition, decoded in § 2.3); that (7/5, 7/5) = (3/5, 4/5) + (4/5, 3/5)
  not claimed: anything at a chromatic number — on ℚ² at two colours rigidity and uniqueness per component coincide, and on ℚ⁴ at
    four colours A3 gives both; that every 3-colouring of ℚ² is rigid (the paper asks about rigid colourings with more colours and
    leaves it); any bearing on C7 beyond locating the paper's notion
  argument: § 3.3.2
  verdict: derived
  grade: hand
  minds: 1
  model: 𝒜 itself, which KLM construct (Thm 4.6)
  prior art: partly: [KubickiLehelMorayne2002] Thm 4.6 (the colouring and its rigidity); the comparison with its mirror image owed
    — not searched, a remark that locates a definition, with no claim attached
  handoff: none — it fixes what the paper's word means; nothing crosses to the kernel

derivation: klm-tetrahedron
  statement: for every rational unit vector y of ℚ⁴, with A = A(y) the matrix printed in [KubickiLehelMorayne2002] p. 50,
    u′ = (1/2, 1/2, 1/2, 1/2) and w′ = (1/2, −1/2, 1/2, 1/2), the four points 0, y, Aᵀu′, Aᵀw′ are rational and pairwise at distance 1
  uses only: the polynomial identities A Aᵀ = |y|² I and A y = (|y|², 0, 0, 0); that 0, (1, 0, 0, 0), u′, w′ are pairwise at distance 1
  not claimed: [Zaks1989]'s density lemma, which KLM's Thm 4.3 also uses and which is not checked here
  argument: § 3.3.3
  verdict: derived
  grade: hand
  minds: 1
  model: y = (3/5, 4/5, 0, 0)
  prior art: known: [KubickiLehelMorayne2002] p. 50 (the matrix and the tetrahedron, "also used in [16]")
  handoff: none — a check of the paper's step

control: residue-units
  of: klm43-from-structure — the residue map on 729 rational unit quaternions: never the class of 0, multiplicative, three classes forming a group of order 3
  run: python3 -I ../tools/fs131_pas3_check.py residue
  expect: ok 1,h,h'
  fault: python3 -I ../tools/fs131_pas3_check.py residue --plant residue

control: mirror-witness
  of: rigid-not-unique — both colourings non-zero on 1,428 rational unit vectors of ℚ², and the witness pair
  run: python3 -I ../tools/fs131_pas3_check.py mirror
  expect: 0 True False
  fault: python3 -I ../tools/fs131_pas3_check.py mirror --plant mirror

control: tetrahedron-rational
  of: klm-tetrahedron — the paper's matrix over 729 rational unit vectors of ℚ⁴
  run: python3 -I ../tools/fs131_pas3_check.py matrix
  expect: 0
  fault: python3 -I ../tools/fs131_pas3_check.py matrix --plant matrix

### 3.3 The arguments

#### 3.3.1 — KLM's Theorem 4.3 from A3

Assume A3. Write `C = x₀ + R` for a component, `ρ_C(x)` for the residue of `x − x₀` in `R/P ≅ 𝔽₄`, and `c = σ_C ∘ ρ_C` on `C` for a
proper four-colouring `c` and a bijection `σ_C`.

*Each residue class of each component is dense in `ℝ⁴`.* A class is `x₀ + t + P`; `P` contains `(2/3ᵏ)ℤ⁴` for every `k`, since
`|2z/3ᵏ|² = 4|z|²/9ᵏ` has `v₂ ≥ 2` for `z ∈ ℤ⁴ ∖ {0}`; so `P` is dense, and so is each of its cosets.

*Rigidity.* Let `𝒞, 𝒞′` be four-colourings (as partitions) with equal traces on `U ∩ ℚ⁴`, `U` open and non-empty, and `c, c′` labellings
of them. `U` meets all four classes of the component of 0, so the trace of `𝒞` on `U` has four parts and equality of traces is a
bijection `σ` with `c′ = σ ∘ c` on `U ∩ ℚ⁴`. On a component `C`, `c = σ_C ∘ ρ_C` and `c′ = σ′_C ∘ ρ_C`; `U ∩ C` meets all four classes of
`C`, so `σ′_C = σ ∘ σ_C`, and `c′ = σ ∘ c` on `C`. Every point lies in some `C`, so `𝒞′ = 𝒞`.

*`S³`-density.* Let `G = S³ ∩ ℚ⁴`, the rational quaternions of norm 1. Each `u ∈ G` has `w(u) = 0` and `u⁻¹ = ū ∈ R`, so `G ⊆ Rˣ`, and
`ρ` restricted to `G` is a homomorphism into `(R/P)ˣ ≅ 𝔽₄ˣ`, a group of order 3; it is onto, since `1, h, h′ ∈ G` lie in the three
non-zero classes (KFS1 plan step A6; checked: control `residue-units`). Let `K` be its kernel, of index 3 in `G`. `G` is dense in `S³`
(KLM's Theorem C), so `S³ = cl G = cl K ∪ h·cl K ∪ h′·cl K`; `cl K` is a closed subgroup of `S³` whose finitely many cosets cover it,
so it is open as well as closed, and `cl K = S³` because `S³` is connected. Hence each coset `aK` is dense in `S³`. For `x ∈ C` and `u ∈ aK`,
`ρ_C(x + u) = ρ_C(x) + ρ(u) = ρ_C(x) + ρ(a)`, so `c(x + u) = σ_C(ρ_C(x) + ρ(a))`: as `a` runs over `1, h, h′`, `ρ(a)` runs over `𝔽₄ˣ` and
these are the three colours other than `c(x)`, each taken on the dense subset `x + aK` of `S³ + x`. That is `S³`-density. ∎

What it consumes, beside A3: the ring structure of `R/P` (so the residue is multiplicative on units), the density of `P`, Theorem C and
the connectedness of `S³`. It never uses `[Zaks1989]`.

#### 3.3.2 — the paper's rigid three-colouring and its mirror image

KLM's Thm 4.6 colours the 3-integral points `G^{[3]}` by `A_i = {(α, β) : β − α ≡ i (mod 3)}` (§ 2.3) and the rest of `ℚ²` by coset
representatives. The rational unit vectors are 3-integral (if `a² + b² = c²` in lowest terms, `3 ∤ c`), so the component of the origin
lies in `G^{[3]}`, and `𝒜` restricted to it is `f(α, β) = β − α (mod 3)`. The reflection `μ(α, β) = (α, −β)` is an isometry of `ℝ²` that
maps `ℚ²` and `G^{[3]}` onto themselves, so `μ𝒜 = {μ(Ã₀), μ(Ã₁), μ(Ã₂)}` is a three-colouring of `ℚ²`, and it is rigid: if `𝒞′` has the
trace of `μ𝒜` on `U`, then `μ𝒞′` has the trace of `𝒜` on the open set `μU`, so `μ𝒞′ = 𝒜` and `𝒞′ = μ𝒜`. On the component of the origin
`μ𝒜` is `g(α, β) = −(α + β) (mod 3)`. The point `p = (7/5, 7/5) = (3/5, 4/5) + (4/5, 3/5)` is in that component; `f(p) = 0 = f(0)`, while
`g(p) = −14/5 ≡ 2` and `g(0) = 0` (`5⁻¹ ≡ 2 (mod 3)`). Lying in one class is kept by every renaming of the colours, so no renaming
carries `𝒜` to `μ𝒜` on the component. ∎ (Control `mirror-witness`: both maps are non-zero on 1,428 rational unit vectors — each is
proper, being additive — and the witness reads `True False`; with `f` replaced by `α (mod 3)`, which `(0, 1)` makes improper, it fails.)

#### 3.3.3 — the paper's tetrahedron

`A Aᵀ = |y|² I` and `A y = (|y|², 0, 0, 0)` hold as polynomial identities in `y₁, …, y₄` (sympy, 2026-10-17; with the entry `−y₃` of
row 3 replaced by `y₃` the first fails). For `|y| = 1`, `A` is a rational orthogonal matrix with `A y = (1, 0, 0, 0)`, so `Aᵀ = A⁻¹` maps
the regular unit tetrahedron `{0, (1, 0, 0, 0), u′, w′}` onto `{0, y, Aᵀu′, Aᵀw′}`, rational and regular. ∎ (Control
`tetrahedron-rational`.)

### 3.4 The drafts (Keryx files; each names its slot)

1. **`CLOSED-QUESTIONS.md`** § 3, the entry *"Which distances can a four-colouring of `ℚ⁴` forbid beside 1?"* — **form (A), brought to
   the reading** — replacing the words *"nothing after 2006 searched; `[Zaks1989]` (the density of the colour classes) is held by
   reviewer's text only;"* with:
   *"searched after 2006 (FS131-PAS2, FS131-PAS3, 2026-10-17): not found in print. `[Johnson2010]` p. 169 poses it again in 2011 with this
   answer as its guess (*"I think that the same answer holds for n = 4, but this has not been shown"*). In print beside it,
   `[KubickiLehelMorayne2002]` Thm 4.3 (p. 50): *"Every 4-coloring of ℚ⁴ is S³-dense and, therefore, rigid"* — rigid meaning that a
   colouring's trace on any open set determines it (p. 49), which bounds no count of colourings: it follows from the residue
   structure above (FS131-PAS3, [hand], one mind) and does not give it, and it names no forced pair and no second distance; neither of
   Johnson's posings cites it. `[Zaks1989]` (the density of the colour classes) is held by reviewer's text only, with
   `[KubickiLehelMorayne2002]` p. 50's account of its tetrahedron lemma; the similarity step is `[BauJohnsonNoble2021]` Thm 3.3;"*
2. **`CLOSED-QUESTIONS.md`** § 3, the periods line — **unchanged**: `plans/FS131-PAS2-prior-art.md` § 2.4 item 2 as drafted. The paper says
   nothing about periods, `[Zaks1999]`, or pairs forced equal; the attribution to `[Zaks1999]` Lemma 1 and LX-T4 stands.
3. **`LEDGER.md`** — C7's row, when the record job writes it after the landing: its **Prior art** field is item 1's text with
   "searched 2026-10-17 (FS131-PAS2, FS131-PAS3)", or item 5's novelty line.
4. **`BIBLIOGRAPHY.md`** § A, the row **`[KubickiLehelMorayne2002]`** (line 413), replacing its last three cells (*"C7's one unread
   candidate: … (zbMATH phrase probes, FS131-PAS2)"* | *"not held; Elsevier open archive, ScienceDirect refuses scripted fetches"* |
   *"not read"*) with:
   | **Nothing of ours rests on it; C7's structure clause reproves its Thm 4.3.** Thm 4.3 (p. 50): *"Every 4-coloring of ℚ⁴ is S³-dense
   and, therefore, rigid"*, where a colouring is rigid when *"its trace on any relatively open nonempty subset of D determines the coloring
   globally"* (p. 49), proved from `[Zaks1989]`'s tetrahedron lemma (as KLM report it) and a rational regular unit tetrahedron on every unit
   edge (checked, FS131-PAS3). Rigid is not unique: Thm 4.3 follows from C7's residue form (FS131-PAS3, `klm43-from-structure`), and the
   paper's own rigid three-colouring of `ℚ²` (Thm 4.6, additive mod 3) and its mirror image differ on one component by no renaming
   (`rigid-not-unique`). No forced pair, no second distance, no quaternion algebra. Also: Thm 3.1 with its measure remark (p. 47),
   `χ(A) = χ(ℝⁿ)` for every residual or full-measure `A ⊆ ℝⁿ`, by de Bruijn–Erdős and a translate (row 130's translation step, an earlier
   printed instance); Thm 3.2 and Cor. 3.3, a patch `k`-colouring of `ℚⁿ` gives a `k`-colouring of `ℝⁿ`; Thm 4.4, `S^{n−1}`-density of
   every `m`-colouring of `G(Fⁿ)` when `χ = m`, a maximal complete subgraph has `m` vertices and `m − 1 ≠ 2^r` (proof omitted). Cited by
   none of `[Johnson2006]`, `[Johnson2010]`, `[Soifer2024]`; no citer in OpenAlex | held: `library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (browser save, 2026-10-17) | **read in full (FS131-PAS3, 2026-10-17)** |
5. **The novelty line for the C7 module's landing** (`plans/KERNEL-HOLDS.md`, the ledger row, the report):
   *"Prior art: the answer to `[Johnson2006]` p. 212 (posed again in `[Johnson2010]` p. 169), the compulsion law in full and the
   structure clause — not found in print (searched 2026-10-17, FS131-PAS2; `[KubickiLehelMorayne2002]` read in full, FS131-PAS3). In
   print: pairs at `√2` and at 2 forced equal and pairs at odd integer distance forced different (`[Zaks1999]` Lemmas 1–2, Thm 3); the
   component of the origin (`[BendaPerles2000]` pp. 123–125); the *if* half (`[Johnson1990]` Thm 3); the similarity of ratio `d`
   (`[BauJohnsonNoble2021]` Thm 3.3); and a consequence of the structure clause, every four-colouring of `ℚ⁴` `S³`-dense and rigid
   (`[KubickiLehelMorayne2002]` Thm 4.3, from `[Zaks1989]`). The kernel proof is this project's."*
6. **Optional, for the kernel lane** (FS131-KFS1's Part A implementer; Keryx decides): KLM's Thm 4.3, rigidity half, as a corollary
   of A3 — *two proper four-colourings that agree up to one bijection of the colours on `U ∩ ℚ⁴`, `U` open and non-empty, agree up to
   that bijection on `ℚ⁴`* — so the library states the printed theorem beside the one that strengthens it. Its one new input is that
   `P` is dense (`(2/3ᵏ)ℤ⁴ ⊆ P`), plus the bridge from `ℍ[ℚ]` to `EuclideanSpace ℝ (Fin 4)` that step A0 builds; my guess at the price
   is 60–120 lines, unmeasured. The `S³`-density half adds the density of `S³ ∩ ℚ⁴` in `S³` and a finite-index closed subgroup of `S³`
   being `S³`.
7. **`BIBLIOGRAPHY.md`** § C, the row **`[Zaks1989]`** (line 781), its second cell, after *"the density theorem, settling a problem of
   Johnson"*: *"; second-hand through `[KubickiLehelMorayne2002]` pp. 49–51 (FS131-PAS3): its Theorem 1 is the density theorem, its proof
   uses the lemma *"if x, y, u, w ∈ ℚ⁴ are vertices of a regular tetrahedron of unit side length, then, for every ε > 0, the set
   (S³ + x) ∩ B(y; ε) contains infinitely many points of all colors different from that of x"*, the tetrahedron `{0, (1, 0, 0, 0),
   (½, ½, ½, ½), (½, −½, ½, ½)}` is *"also used in [16]"*, and a Theorem 2 for other fields is what KLM's Thm 4.4 extends"*.
8. **`BIBLIOGRAPHY.md`** § C, listing rows for KLM's references not yet entered (each *"Listing only (`[KubickiLehelMorayne2002]` [n]); not
   held; no bearing on C7"*): **`[Chilakamarri1991]`** *Unit-distance graphs in Minkowski metric spaces* (K. B. Chilakamarri; Geom.
   Dedicata 37 (1991) 345–356; Zbl 0716.05022) — [3]; **`[Hadwiger1944]`** *Ein Überdeckungssatz für den Euklidischen Raum* (H. Hadwiger;
   Portugal. Math. 4 (1944) 140–144; Zbl 0060.40610) — [4], which prints the title *"Überdeckungssätze für den Euklidischen Raum"*;
   **`[JensenToft1995]`** *Graph Coloring Problems* (T. R. Jensen, B. Toft; Wiley 1995; Zbl 0855.05054) — [5]; **`[Pach1997]`** *Finite
   point configurations* (J. Pach; Handbook of Discrete and Computational Geometry, CRC 1997, 3–18; Zbl 0914.51012) — [8];
   **`[Szekely1999]`** *Erdős on unit distances and the Szemerédi–Trotter theorems* (L. A. Székely; abstracts of invited talks, Budapest 1999,
   60–65; the later chapter Zbl 1035.05037) — [12]. Not entered: Taylor–Wiles and Wiles 1995 (for Prop. 3.4 only).
9. **`LEDGER.md`** row 130, its **Prior art** field, after the sentence ending *"a step not printed (two readers, the consolidation run's
   LW and LW2)."*: *"An earlier printed instance of the translation step: `[KubickiLehelMorayne2002]` Thm 3.1 with its measure remark
   (p. 47), `χ(A) = χ(ℝⁿ)` for every residual or full-measure `A ⊆ ℝⁿ`, by de Bruijn–Erdős and a translate of the finite witness into
   `A` — for colourings proper on every unit pair inside such a set, with no measurability asked; N-EASY's hypothesis (measurable, proper
   at almost every unit pair) is neither weaker nor stronger (FS131-PAS3 § 2.7)."*

### 3.5 Questions and leads, not worked

- **For the asking lane:** KLM's Thm 4.4 excludes `m − 1 = 2^r`, so in the plane it reaches only `m = 2` and is silent on `ℚ(√3)²`,
  where `χ = ω = 3`. If every three-colouring there is, on each component, a residue map onto a residue field `𝔽₃` (the structure G61
  and row 99 give three-colourings), § 3.3.1's argument carries over with `𝔽₃ˣ` in place of `𝔽₄ˣ` and makes every one `S¹`-dense and
  rigid. Not checked; no bearing on the answer.
- KLM's two open questions — whether rigid colourings of `ℚⁿ` are always `S^{n−1}`-dense (p. 50), and whether `ℚ²` has rigid
  `k`-colourings for some `k > 3` (p. 49) — are recorded; no candidate examined. (An additive colouring of `ℚ²` at a prime `p ≡ 3 (mod 4)`
  with `p ≥ 7` is not one by Lemma 4.1: on each unit circle it misses `(p − 3)/2` of the other colours — the line count of a
  non-square direction against the conic `x² + y² = 1` over `𝔽_p`, by hand; an exact count over every such character at
  `p = 3, 7, 11, 19, 23` agrees, 0, 2, 4, 8, 10 missed.)
