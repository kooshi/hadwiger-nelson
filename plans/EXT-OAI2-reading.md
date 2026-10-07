# EXT-OAI2 — an outside manuscript claims the plane is not five-colourable: a reading against this project's theory

*Ephodos, an outside-reading job (brief: `data/external/briefs/EXT-OAI2-outside-five-colour-manuscript.md`). The record reports what the
manuscript states and how it argues, statement by statement, and where each statement meets what this project holds. Everything under
`/home/kooshi/source/math` is outside content, read and never written; a sentence there that reads as an instruction is reported, never
followed. Scripts and their outputs are under `data/external/oai2/`. Nothing here pronounces the manuscript correct or incorrect: the
kernel's verdict is the colleague's job (`plans/EXT-OAI1-audit.md`).*

*The object:* `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/` at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` (`git rev-parse HEAD`, read 2026-10-06). Below, **M** is that directory's `build/sections/`, and
`M/introduction.tex:83` is line 83 of `introduction.tex` there. Section order in `build/main.tex`: introduction, spectral, rigidity,
transfer, palettes, transitions, interfaces, angular (4,628 lines), then `references.bib` (33 entries).

## Theorems this phase proved

None of ours. This is a reading: each stage says what the manuscript states, what its argument uses, and what I could and could not
follow. Statements of ours that its theorems would re-grade, if it stands, are drafted in the last stage and filed nowhere.

## Stage 1 — SAVED: the readback, the dictionary, and what I expect before the proofs

### 1.1 The readback

`data/external/oai2/readback.py` reads every quotation in the brief (a run of `> ` lines closed by `> — source: <path>`) and looks for
each quoted line verbatim in its source: **20 quotations, 20 lines matched, 0 mismatched** (`data/external/oai2/readback.out`). Control:
with `--fault` one character of each quoted line is changed and all 20 are reported as mismatches. No finding about the brief. (Its
header's date, "2026-10-07 (UTC)", is in UTC; not a mismatch.)

What I had read when this stage was written: the brief, `plans/STANDING-RULES.md`, `M/introduction.tex` whole (324 lines: the
statements, the proof overview, the corollary), `README.md`, `build/main.tex` (the abstract), `plans/EXT-OAI1-audit.md` stages 1–3,
`LEDGER.md` § The claim list and rows 120–132, `plans/STUB-cp-plane-six.md`, `data/fs103/claims.md` §0 (this project's fixed
definitions), `plans/FS103-derivation.md` §3's entries. **No proof section of the manuscript.**

### 1.2 Their statements, each whole

**Their proper colouring** (`M/introduction.tex:3–9`):

> A proper $k$-coloring of the Euclidean plane is a function
> $c:\R^2\to\{1,\ldots,k\}$ such that $c(x)\ne c(y)$ whenever
> $\norm{x-y}=1$. The Hadwiger--Nelson problem asks for the least such
> $k$, denoted by $\chi(\R^2)$, with no regularity imposed on the color
> classes.

**Their Falconer number** (`M/introduction.tex:39–40`): "Write $\chi_m(\R^2)$ for the least number of colors when each class must be
Lebesgue measurable." — proper at every unit pair; they use it only in the history paragraph.

**Definition 1.2** (`M/introduction.tex:83–96`):

> \begin{definition}[Weak measurable coloring]\label{def:weak-coloring}
> Let $k$ be a positive integer, let $S^1\subset\R^2$ be the unit circle,
> and let $\sigma$ be its normalized arc-length measure. A
> \emph{weak measurable $k$-coloring} is a Lebesgue measurable function
> $c:\R^2\to\{1,\ldots,k\}$, with color classes $A_i=c^{-1}(\{i\})$,
> such that, for every $R>0$,
> \[
>   \sum_{i=1}^k\int_{B(0,R)}\int_{S^1}
>   \ind_{A_i}(x)\ind_{A_i}(x+u)\,d\sigma(u)\,dx=0.
> \]
> The integrals use the completed product measure; equivalently, one
> may first choose Borel representatives of the color classes forming
> a partition of the plane.
> \end{definition}

**Theorem 1.1** (`M/introduction.tex:62–68`):

> \begin{theorem}\label{thm:main}
> The Euclidean plane has no proper five-coloring, even when arbitrary
> color classes are allowed. Consequently,
> \[
>   6\le \chi(\R^2)\le 7.
> \]
> \end{theorem}

**Theorem 1.3** (`M/introduction.tex:104–113`):

> \begin{theorem}[Transfer of colorability]\label{thm:transfer}
> For every positive integer $k$, in ZFC,
> \begin{equation}\label{eq:source-1}
>   \begin{gathered}
>     \text{a proper $k$-coloring of $\R^2$ exists}
>     \\ \Longleftrightarrow \\
>     \text{a weak measurable $k$-coloring of $\R^2$ exists}.
>   \end{gathered}
> \end{equation}
> \end{theorem}

**Theorem 1.4** (`M/introduction.tex:115–117`):

> \begin{theorem}\label{thm:weak-five}
> There is no weak measurable five-coloring of the Euclidean plane.
> \end{theorem}

**The rigidity statement the transfer rests on**, as the overview states it (`M/introduction.tex:149–150, 163–175`; the theorem itself is
in `M/rigidity.tex`, not yet read):

> Let $F$ be the field of real algebraic numbers, $E=F(i)$ the algebraic
> plane, and $K=\{u\in E:|u|=1\}$ its group of algebraic rotations.

> For this purpose let $D$ be the compact group of all characters of the
> additive discrete group $E$. A character is a homomorphism from $E$ to
> the unit complex circle. The ordinary continuous characters form the
> Borel subgroup
> \[
>  C=\{z\mapsto\exp(i\xi\cdot z):\xi\in\R^2\}\subset D.
> \]
> Rotations act on characters by $(ud)(z)=d(uz)$.
> The spectral theorem, in $L^2$ of the invariant labeling law,
> separates each label indicator into the part
> supported on $C$ and its orthogonal remainder. The central rigidity
> statement, Theorem~\ref{thm:rigidity}, says that every $K$-invariant
> probability on $D$ assigning zero mass to $C$ is Haar probability.

**Corollary 1.5** (`M/introduction.tex:282–306`), in short form (quoted whole at its address; its proof is five lines from Theorem 1.1,
de Bruijn–Erdős and two cited finite-graph bounds): a constant `δ > 0`, existential, bounds below (i) the invariant-mean badness
`p_5^μ(c)` of every five-colouring under every finitely additive left-invariant mean on `E(2)`, and (ii) the needle frequency of every
doubly periodic Lebesgue-measurable five-colouring, and the limit of square-table frequencies where it exists.

**The footnote to Theorem 1.1** (`M/introduction.tex:70–78`) is a statement about another outside manuscript, reported as content: it
says a May 14, 2026 manuscript (`Outside2026` in their bibliography) "announces $\chi(\R^2)=7$ through a circle-density argument", that its
"proposed strict bound of $\pi/3$ on the angular measure of a unit-independent subset of the unit circle fails for the half-open arc",
and that "the argument does not establish the announced equality". (Whether that is one of the outside claims this project's EXT-HN1 and
EXT-HN2 jobs read is the coordinator's to match; I have not opened those reports.)

### 1.3 The dictionary

| theirs | ours | verdict |
|---|---|---|
| proper `k`-colouring of `ℝ²`; `χ(ℝ²)` | the same (`CLAUDE.md` § Notation; kernel: `chromaticNumber` of the plane's unit-distance graph, row 33) | **the same object.** Their Lean statement is on `ℂ` with its norm (`plans/EXT-OAI1-audit.md` stage 2); ours is on `EuclideanSpace ℝ (Fin 2)`, joined by `chromaticNumber_plane_eq_complex` |
| `χ_m(ℝ²)`: every class Lebesgue measurable, proper at every unit pair | `χ_m(ℝ²)` (D-M, `data/fs103/claims.md` §0: "the least `k` with a Lebesgue-measurable proper `k`-colouring of `UD(ℝ²)` (proper at every edge)") | **the same**; Falconer's number. Neither theorem of theirs is stated for it; see the consequences below |
| **weak measurable `k`-colouring** (Def. 1.2): Lebesgue measurable `c`, and `(Leb × σ){(x, u) ∈ B(0,R) × S¹ : c(x) = c(x + u)} = 0` for every `R` | the object of **`χ_m⁰(ℝ²)`** (D-M: "the least `k` with a measurable `k`-colouring proper at almost every edge (for almost every `(x, w) ∈ ℝ² × S¹`)"; row 130: "a Lebesgue-measurable `k`-colouring proper at almost every unit pair"; FS103-M1b's operator form: a class `I` with `(Leb × σ){(x, w) : x, x + w ∈ I} = 0`) | **the same object, neither stronger nor weaker.** Their sum over `i` of `∫∫ 1_{A_i}(x) 1_{A_i}(x+u)` is the `(Leb × σ)`-measure of the monochromatic pairs in `B(0,R) × S¹`; "for every `R`" is σ-finiteness; normalizing `σ` changes nothing. Both are invariant under changing `c` on a Lebesgue-null set (theirs: `M/introduction.tex:98–101`; ours: FS103-M1b). So "a weak measurable `k`-colouring exists" **is** `χ_m⁰(ℝ²) ≤ k` |
| **Theorem 1.3** (transfer): for every `k`, in ZFC, proper `k`-colouring exists ⟺ weak measurable `k`-colouring exists | **`χ(ℝ²) = χ_m⁰(ℝ²)`** — row 130: "Given MR (row 128): `χ(ℝ²) = χ_m⁰(ℝ²)`" (FS103-M-Q4, [hand, two], given MR(ℚ(√635087)), row 120's grade) | **the same equality, both directions, every `k`; theirs with no hypothesis.** ⟸ (`χ ≤ χ_m⁰`) is unconditional here too: `CLAUDE.md` § The aim link 2, FS103-M-EASY ("a random rigid motion, Fubini, de Bruijn–Erdős", one mind; two minds through FS103-CPUP and FS103-M1). ⟹ (`χ_m⁰ ≤ χ`) is the direction this project holds **only given MR**, through row 128's collapse at a totally real number field with every stable place 6-thick and row 130's `χ_CP = χ_m⁰`. For `k ≤ 4` and `k ≥ 7` both sides of their equivalence have a known truth value; its content is at `k = 5, 6` |
| the rigidity statement (their Thm "rigidity", per the overview): every `K`-invariant probability on `D = Ê` with `C`-mass 0 is Haar, `E = ℚ̄ = ℝ_alg(i)` | **D-MR / MR(F)** (row 120): "for every real number field `F` with `R_F = O′` …, every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" | **a neighbour, not the same statement: measure rigidity at the one field ours does not cover.** `F = ℝ_alg` is not a number field. My reading of the transposition, to be checked at the theorem (stage 2): `E = ℚ̄` is divisible, so it has no torsion characters (`T = 0`); `ℝ_alg` has one ordering (an automorphism of `ℚ̄` commuting with complex conjugation fixes the real closed field `ℝ_alg` pointwise), so the archimedean characters are their `C` (`A = C`); no finite place is stable. So their exceptional set `C` is ours `T + A` at that field, and ours `E = T + A + Fin_S` is larger by the split-place characters (row 126: "a split-place component goes to Haar under a hyperbolic shift"). Neither statement implies the other as stated (a pushforward of a `C`-null measure to a number field's `R̂` need not be `E`-null) |
| **Theorem 1.4**: no weak measurable five-colouring | **`χ_m⁰(ℝ²) ≥ 6`**, which with row 130 (no MR) is **`χ_CP(ℝ²) ≥ 6`** | **the YES of this project's third-ranked stub**, `plans/STUB-cp-plane-six.md` ("is `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130)?"; its line 27: "is the plane's measurable chromatic number, null sets of unit pairs ignored, at least six?"). The stub registered "`χ_CP(ℝ²) ≥ 6` proved — 0.02" |
| **Theorem 1.1**: `6 ≤ χ(ℝ²) ≤ 7` | row 33: `5 ≤ χ(ℝ²) ≤ 7` [kernel]; rung D open | **a move of the lower bound**, from 1.3 + 1.4; the upper half is the classical hexagonal colouring (ours in the kernel, M36) |
| Cor. 1.5 (i): invariant-mean badness `p_5^μ(c) ≥ δ` for every five-colouring | row 130's prior-art line on `[GwynStavrianos2022]` Lemma 2, Thm 2 (their key `GwynStavrianos2020`, cited as "Lemma 2.10 and Theorem 2.11" — the numbering to be matched against our copy in the last stage) | **a consequence by citation**, the constant existential |

**Consequences of the dictionary that need no proof of theirs** (each a composition with a row of ours, stated so stage 5 can price it;
none is claimed here):

- Since `χ_m⁰ ≤ χ_m ≤ χ_B` (FS103-M1c), Theorem 1.4 alone gives **`χ_m(ℝ²) ≥ 6`**, Falconer's measurable number — which this project's
  stub records as "open since 1981 (`5 ≤ χ_m ≤ 7`; `[Falconer1981]`)" — and `χ_B(ℝ²) ≥ 6`. The manuscript's introduction does not state
  this consequence in the lines I have read.
- By row 131 (every `k`, no MR), Theorem 1.4 is **`lim_{ε→0} µ₅(ε) < 1`**: five classes, each free of monochromatic pairs at
  distances in `[1 − ε, 1 + ε]`, leave holes of density bounded below as `ε → 0` — a stability statement at five with no explicit
  constant.
- By row 125 (given MR), Theorem 1.4 supplies the conjunct `χ_CP(ℝ²) ≥ 6` of "six at ℚ(√167)"; the other conjunct, `PL_∃(23, 43)`,
  is untouched.
- The question that survives is this project's own headline with five struck out: row 131's `χ_m⁰(ℝ²) ≥ 7` ⟺ `lim µ₆(ε) < 1`, and,
  **if Theorem 1.3 stands, with no "given MR" in front of it**: `χ(ℝ²) = χ_m⁰(ℝ²) ∈ {6, 7}`.

**Attack on the dictionary, both sides.** (a) Is their notion secretly easier than ours? No: the two definitions are the same set of
functions; in particular theirs does not ask for Borel classes (it notes Borel representatives exist), does not ask properness at
every pair, and does not ask a periodic or invariant law. (b) Is their Theorem 1.3 secretly weaker than `χ = χ_m⁰`? It is stated as an
equivalence of existence at each `k`, which is exactly equality of the two least `k`. (c) Is this project's "given MR" weaker than a
hypothesis they hide? The overview names their replacement outright — a rigidity theorem of their own — so nothing is hidden at the
level of statements; whether its proof stands is the reading of stage 2.

### 1.4 Registered before the proofs (after the overview, which names the route)

The overview already answers the brief's first question in outline: **the transfer does not do without measure rigidity — it proves
one**, at the field of all real algebraic numbers. So what I register is what I expect the proofs to show, with probabilities, to be
scored in the last stage.

- **P1 (0.85).** Their rigidity theorem is D-MR's statement transposed to `ℝ_alg`, and their transfer's ⟹ is row 128's load-bearing
  step run at that field: restrict the colouring to the countable plane, average over the amenable group of its rigid motions,
  split the spectral measure at `T + A` (= `C` there), kill the remainder by rigidity, land on a stationary colouring, make it
  measurable. With no stable place, row 128's "select over all stable places at once by mixing" has nothing to do.
- **P2 (0.70).** The rigidity proof uses, at a step I will be able to name, a property of `ℝ_alg` that no number field has (the
  group `K` is divisible; algebraic radii are dense and closed under square roots). If so it does not give MR(F) for any number
  field `F`, and row 120 keeps its grade and its external input.
- **P3 (0.60).** The object the rigidity proof works on is the one row 122's FR-1 names ("MR [is] a Schoenberg-type statement (radial
  positive-definite functions of the quadrance)"): a positive-definite radial function on the algebraic plane.
- **P4 (0.50).** The easy direction is not literally ours: the overview announces density points and a common translation where
  ours moves a colouring by a random rigid motion. Both end in de Bruijn–Erdős.
- **P5 (0.90).** The step that stops at five is in the last section: the case analysis over simple cycles of length 3, 4, 5 on five
  labels counts the labels outside the cycle (two, one, none), and at six a 3-cycle leaves three.
- **P6 (0.50).** Five is used earlier too, in the bound "almost every palette contains at most two labels".
- **P7 (0.60).** The topological extraction (probability vectors with at most two positive coordinates, a map to the complete graph
  on the labels, a planar cover obstruction) is the same at every number of colours.
- **P8 (0.75).** Their "palette at `(x, e)`" is this project's ring of a vertex read in measure (G91: "a four-colour vertex's unit
  circle is a twisted colouring of its 60° hexagons"), and their "cyclic centers … form a closed locally finite set" is, at five,
  the statement this project holds open at six as the map step (REG-J′: a locally finite singular set).
- **P9 (0.60).** At least one step of the rigidity sections, and (0.50) at least one of the interface extraction, I will not be able
  to verify on one reading and will name as such.

Decision each bears on: P1–P3 decide whether stage 5 drafts "row 120 becomes a theorem by citation" or "row 120 untouched, row 130's
*given MR* removed by a different theorem"; P5–P8 decide whether the frontier's six-map programme (rows 131–154) is read as re-derived
at five, as bypassed, or as the template for six.

## Stage 2 — SAVED: the transfer, read in full (their §§ 2–4; Theorem 1.3 and Theorem 2.3)

**What was read:** `M/spectral.tex` (624 lines), `M/rigidity.tex` (617), `M/transfer.tex` (316) — every line; each displayed identity
and each inequality reworked by hand as I went (the list is § 2.7). **Grade of this stage: read in full, no gap found by me, one mind,
one pass.** That is a reading, not a verification: I committed no blind verdict, and the kernel's word on the corresponding Lean
modules is `plans/EXT-OAI1-audit.md`'s. The PDF's numbering is used below (Theorem 2.3 is `M/spectral.tex:64`, `\label{thm:rigidity}`).

### 2.1 The route of Theorem 1.3, step by step

Notation (theirs, `M/spectral.tex:15–38`): `F = ℚ̄ ∩ ℝ`, `E = F(i)`, `K = {u ∈ E : u ū = 1}`, `D` the compact dual of the discrete
additive group `E`, `C = j(ℝ²)` the characters `z ↦ exp(iξ·z)`; `(ad)(z) = d(az)`, `ψ_z(d) = d(z)`.

**⟹ (a proper `k`-colouring gives a weak measurable one; Proposition 4.2, `M/transfer.tex:144–257`).**

| # | step | what it uses | this project's counterpart |
|---|---|---|---|
| F1 | restrict the colouring to the countable algebraic plane `E`; `Ω ⊂ {1..k}^E` the closed set of proper labelings | nothing; from here on the colouring is a point of a compact metrizable space | row 128 restricts to a number field `F` |
| F2 | an `E ⋊ K`-invariant Borel probability `μ` on `Ω`: Følner averages of a point mass, a weak limit of a subsequence | `E ⋊ K` countable and amenable (abelian by abelian; `[Bekka2008]` G.2.1, G.2.2(ii), G.5.1) | the amenable averaging under row 128 and FS103-B-AMEN's Følner half |
| F3 | `f_i` = "the origin has label `i`"; rotations fix `f_i`; properness: `∫ f_i T_u f_i dμ = 0` for `u ∈ K` (their (4.1)) | the edge set of `E` is `K`, and `K` acts | the same |
| F4 | **Lemma 4.1**: the vectors whose translation orbit is `L²`-continuous for the usual topology of `E` are `L²` of a factor `𝓕_c`, and are the spectral subspace on `C`; translations extend to a strongly continuous unitary action of `ℝ²` on it preserving positivity and `1`; rotation-invariant | the spectral theorem for discrete `E`, Bochner on `ℝ²` (`[Bekka2008]` D.3.1, D.2.2); the bounded continuous vectors form an algebra closed under Lipschitz maps, so the closed subspace is `L²` of a sub-σ-algebra | row 128's "condition on the `T + A` factor" (at this field `T + A = C`), with FS103-M1's "continuity in probability free" |
| F5 | `p_i = 𝔼(f_i ∣ 𝓕_c) ∈ [0,1]`, `Σ p_i = 1`, `b_i = f_i − p_i`; the spectral measure of `b_i` is `K`-invariant and gives `C` mass 0 | Lemma 4.1; covariance `V_u T_z V_u⁻¹ = T_{uz}` | the `E`-null remainder of row 128; the remainder with negative unit correlation is this project's *SP witness* (D-SP) |
| F6 | **Theorem 2.3** makes that measure a multiple of Haar, so `⟨b_i, T_z b_i⟩ = 0` for every `z ≠ 0`; the cross terms vanish by orthogonality; hence `∫ p_i T_u p_i dμ = 0` for `u ∈ K` | **the rigidity theorem** (§ 2.2 below) | **MR (row 120)** — the one external-resting link of row 128's chain |
| F7 | the same for every `u ∈ S¹` and every base point `x ∈ ℝ²` (their (4.2)) | `K` dense in `S¹`; strong continuity; unitarity | FS103-M1's passage to all unit vectors |
| F8 | a jointly measurable field `H_i(x, ω) ∈ [0,1]` representing `T_x p_i` for almost every `x` | a continuous map into separable `L²(μ)` is a limit of simple maps | FS103-FMT (a CP colouring has a jointly measurable version) |
| F9 | Tonelli; one sample `ω` with `Σ_i H_i(·, ω) = 1` a.e. and `Σ_i ∫∫ H_i(x)H_i(x+u) = 0`; colour `x` by **the least index with positive field** | countably many conditions | FS103-M1's "one random threshold rounds `Δ_k` to `[k]`" — theirs needs no threshold: `H_i(x)H_i(x+u) = 0` a.e. already forbids a common positive coordinate |

**⟸ (a weak measurable `k`-colouring gives a proper one; Lemma 4.3 and `M/transfer.tex:297–315`).**

| # | step | what it uses | this project's counterpart |
|---|---|---|---|
| B1 | **Lemma 4.3**: "the full-density-point set of each `A_i` contains no unit pair. These density-point sets are disjoint and their union is conull." | at two density points `x`, `x + u` of one class, a random `(x′, u′)` near `(x, u)` has law absolutely continuous to `dx dσ` and both ends in the class with positive probability | FS103-M-D's (D1), which is stronger ("a point of positive upper density of a class is never at distance 1 from a density point of the same class"; [hand, one mind]) |
| B2 | a finite configuration has a **translate** inside the conull set of density points, so its unit-distance graph is `k`-colourable | finitely many conull conditions on the translation vector | link 2 moves the graph by a random *rigid motion* and uses Fubini on `ℝ² × S¹`; theirs needs no rotation, because B1 has already made the colouring proper at **every** pair of a conull set |
| B3 | de Bruijn–Erdős, as Tychonoff on `{1..k}^{ℝ²}` | compactness of the product, "in ZFC" | the same (`[deBruijnErdos1951]`) |

So **P4 is met**: the easy direction is not literally this project's, and its Lemma 4.3 is a half of this project's null-set
reduction. It is also slightly more than `χ ≤ χ_m⁰`: *every weak measurable colouring is proper everywhere off a Lebesgue-null set
of points* — FS103-M-D (D3)'s starting point, now with a printed proof of the form needed.

### 2.2 The rigidity theorem, and what replaces this project's measure rigidity

> \begin{theorem}[Rigidity of wild character laws]\label{thm:rigidity}
> Every $K$-invariant probability measure $\nu$ on $D$ with $\nu(C)=0$
> is Haar measure. Equivalently, writing $m_D$ for normalized Haar measure,
> \begin{equation}\label{eq:source-3}
>  \nu\text{ is wild}\quad\Longrightarrow\quad\nu=m_D.
> \end{equation}
> \end{theorem}
> — `M/spectral.tex:64–70`

**Nothing replaces measure rigidity: the manuscript proves it, at `F = ℝ_alg`, by a route with no entropy in it.** This project's MR
(row 120) splits an invariant measure by entropy and takes the positive-entropy half from `[EinsiedlerLindenstrauss2022]` Thm 1.3 by
statement and the zero-entropy half from `[EinsiedlerFish2010]`'s pigeonhole. Theirs is five moves, each proved in the text:

1. **Wild means no continuous part on any line** (Lemmas 2.4, 2.5). `ν(C) = 0` gives `ν(d + C) = 0` for every coset — a coset of
   positive mass would have a finite `K`-orbit, and "a finite abelian group cannot be divisible unless it is trivial"
   (`M/spectral.tex:111–112`) — and `ν(L_a) = 0` for the characters continuous along the line `aF`. Then, for an invariant mean on
   the discrete group `F/ℤ` and the functional `I` it defines on bounded, boundedly supported functions on `F`:
   "`I(φ(t) f_ν(at)) = 0` (`a ∈ E ∖ {0}`, `φ ∈ C_c(ℝ)`)" (their (2.3)). No measurability of `t ↦ f_ν(at)` is used.
2. **A compact tower** (Lemma 3.1): for an ergodic `K`-system `X`, a countable-ordinal tower of factors, each successor a
   finite-rank (compact) extension with the uniform approximation property (2.4), ending at a factor `Y` with `X ×_Y X` ergodic. This
   is the Furstenberg–Zimmer dichotomy, proved fibrewise from an invariant Hilbert–Schmidt kernel.
3. **Relative singularity** (Lemma 2.7): along such a tower, the law of `d(x) − d(x′)` for two conditionally independent samples
   over a factor of the tower still gives `C` mass 0. Transfinite induction, universal over ambient systems. If it failed at `Y`,
   ergodicity makes every fibre law sit on `m` cosets of `C` of mass `1/m`; a translation- and rotation-equivariant centre (Lemma
   2.6: the minimizer of `∫ (√(1+|s−t|²) − √(1+|t|²)) dλ(t)`) picks one point `b` in each; the list of the `m` phases
   `ψ_k(b)` is a bounded function on `Y` whose rotations are, by compactness, near finitely many combinations over an earlier
   factor `W`; writing a small real `x_j = jt` as **a sum of two unit vectors**, `x_j = k_j + k̄_j`,
   `k_j = x_j/2 + i√(1 − x_j²/4)`, puts `ψ_{x_j}(b)` within `2ρ` of one of `m²` products, so two of them collide with
   conditional probability above `1/(4m²)`; the induction hypothesis over `W` and move 1 choose `t` so that every such collision
   has conditional probability below `1/(4m²)`.
4. **Decoupling over `Y`** (Lemma 3.2): since `X ×_Y X` is ergodic, for pairwise distinct integers `n_j` and bounded `v_j`,
   `Avg_{u∈Φ_N} ‖P(∏_j U_{u^{n_j}} v_j) − ∏_j U_{u^{n_j}} P v_j‖₂² → 0` along every Følner sequence of `K` (their (3.1)) —
   Furstenberg's weak-mixing-extension induction with van der Corput, run for the homomorphisms `u ↦ u^{n}` of `K`. With
   `g_z = P ψ_z` and `m(z) = ‖g_z‖₂²` (the Fourier transform of the difference law over `Y`: nonnegative, radial, `m(0) = 1`)
   this gives **Lemma 3.3**: for `w = −log m`,
   "`w(|A − B|) ≤ w(A) + w(B)` (`A, B ∈ F_{≥0}`)" and "`Avg_{u∈Φ_N} m(2r|Re u|) → m(r)²`". The first comes from one identity,
   `|A − Bu²|² = (A − B)² + 4AB(Im u)² = |−L + (A − B)u + Lu²|²` with `L = √(AB)`: the left form decouples to `m(A)m(B)`, the
   right form is at most `m(|A − B|)`.
5. **One positive value spreads to an interval** (Lemmas 3.4, 3.5 and `M/rigidity.tex:509–617`): if `m(r) > 0`, the set
   `{u : w(2r|Re u|) ≤ H}` is syndetic; rotations in ℚ-linear general position inside a number field holding the finitely many
   translates give, for every `v ∈ K`, a ℚ-basis `𝒯` with `w(2r|Re(kv)|) ≤ H` on it; an integer relation `D₀·1 = Σ a_k k` and
   the subadditivity of move 4 "under a cap" give `m(s) ≥ e^{−4M₀H}` for every `s ∈ F ∩ (0, 2rc₀)` — against move 1's zero
   line average for the difference law, which is wild by move 3. So `m ≡ 0` off 0, every nontrivial Fourier coefficient of the
   ergodic `μ` vanishes, and `μ` is Haar; ergodic decomposition finishes.

**Against this project's theory.**

- **It is D-MR at the one field D-MR does not cover** (stage 1's reading stands): at `ℝ_alg` the group `E` is divisible, so there
  is no torsion character, no finite place is stable, and the only isometric layer is `C`. Row 128's "select over all stable
  places at once by mixing" has nothing to select. **P1 is met.**
- **It uses two properties no number field has, at named steps — P2 is met.** (i) `K` *divisible*: Lemma 2.4's finite-orbit step;
  the mean ergodic theorem "through the surjective power map" (`M/rigidity.tex:158–161, 199`); every use of Lemma 3.2. (ii) `F`
  *closed under square roots of positive elements*: `L = √(AB) ∈ F` (`M/rigidity.tex:360`); "Each `|x_j| < 1` is a sum of two
  elements of `K` … The square roots belong to `F`" (`M/spectral.tex:539–544`); "Every `t ∈ F ∩ [−1,1]` is the real part of an
  element of `K`" (`M/rigidity.tex:580`). Over a number field `F₀` the reals `2 Re k`, `k ∈ K_{F₀}`, are dense in `[−2, 2]` but
  are not all of `F₀ ∩ [−2, 2]`, and move 5 needs the bound at *every* point of an interval of `F` to contradict an invariant mean.
  **So Theorem 2.3 does not give MR(F) for any number field `F`, and row 120 keeps its grade and its external input**; what it
  removes is the *need* for row 120 in the plane's own equality (§ 2.5).
- **P3 is half met.** The object is a radial positive-definite function on the algebraic plane, as row 122's FR-1 said MR would be
  ("FR-1 makes MR a Schoenberg-type statement (radial positive-definite functions of the quadrance)"), and the manuscript names
  the classical analogue itself (`M/spectral.tex:81–88`: Crum; Gneiting–Sasvári — a measurable radial positive-definite function
  on `ℝ²` is a continuous one plus a multiple of `1_{0}`). But the function the proof works on is not `f_ν`; it is `m`, the
  transform of a *relative difference* law, which is nonnegative — the nonnegativity is what the subadditivity needs, and it is
  bought by moves 2 and 3. This project's G80 ("Infinite rank is the resource") named the right resource and used it through
  heights; the manuscript uses it through divisibility.
- **Row 122's no-gos are not contradicted.** "Equidistribution is false" there is over ℚ, for averages over a filtration `U_N`; their
  (3.13) is an average along Følner sequences of the whole divisible group at `ℝ_alg`. Row 122's `Λ ≥ −J₀(j₁,₁) > 1/3` concerns
  measures on `T + A`, which here is `C`, the part the transfer keeps.

### 2.3 Where choice enters, and where it is discharged

- **Discharged at F1.** An arbitrary colouring (which may exist only by choice) is used only through its restriction to a
  countable set — a point of a compact metrizable space; F2–F9 are measure theory on standard spaces, with sequential compactness.
  In fact F1 needs less than its hypothesis: a proper `k`-colouring of the countable graph on `E`, i.e. `k`-colourability of
  every finite unit-distance graph with algebraic coordinates.
- **Used inside Theorem 2.3 at one place**: "Fix a translation-invariant mean 𝔪 on the bounded functions on the discrete abelian
  group `F/ℤ`" (`M/spectral.tex:139–145`). The mean is applied to functions on a countable group. *My reading, not checked:* a
  limit of Følner averages along a subsequence chosen for the countably many functions the two uses need (Lemma 2.7's choice of
  `t`; the last contradiction) would serve, which would put the forward direction in ZF + DC. The manuscript claims ZFC only.
- **Used in ⟸ at B3**, de Bruijn–Erdős, as in this project's link 2 (a reading there too: `[ShelahSoifer2003b]` p. 42).
- **A consequence worth a line, as a reading (one mind, not derived):** if the forward direction holds in ZF + DC, then in a model
  of ZF + DC + "every set of reals is Lebesgue measurable" the chromatic number of the plane is `χ_m(ℝ²)`, while in ZFC it is
  `χ_m⁰(ℝ²)` by Theorem 1.3 — so whether the plane's chromatic number depends on the axioms (the Shelah–Soifer question; this
  project's stub item (3), `plans/STUB-cp-plane-six.md` lines 10–13, 31–32) **is exactly whether `χ_m⁰(ℝ²) = χ_m(ℝ²)`**, this
  project's null-set step (FS103-M-D, a GAP). The manuscript does not state this.

### 2.4 Is anything special to the plane, to the unit distance, or to finitely many colours?

- **The plane: yes, at the root.** `E = F(i)` is a field and the rotations are its norm-one group, abelian, so `E ⋊ K` is amenable
  and `u ↦ uⁿ` is a homomorphism. In `ℝⁿ`, `n ≥ 3`, the algebraic rotation group is not amenable as a discrete group and none of
  F2, Lemma 3.2 or Lemma 3.3 is available as written. (This project's collapse is plane-bound for the same reason.)
- **The unit distance: no, within algebraic distances.** F6 kills the remainder's correlation at *every* nonzero algebraic
  translation, so the argument transfers any colouring avoiding a set of algebraic distances to a measurable one avoiding them
  almost everywhere (my reading; the manuscript states the unit distance only).
- **Finitely many colours: no** — `k` is arbitrary and enters only in the compactness of `{1..k}^E` and the finite sum.
- **Algebraic numbers: yes, at Lemma 3.4** — the general-position step works in a number field `N` of finite degree `d₀`
  ("every `d₀` distinct elements of `S` form a ℚ-basis of `N`"). The real closure of a transcendental extension is not reached by
  the argument as written.

### 2.5 What the transfer does to this project's own reduction (attack on ours)

- **The number-field detour is unnecessary for the plane's equality.** Row 128 reaches `χ(ℝ²) = χ_CP(ℝ²)` through a totally real
  number field whose stable places are all 6-thick, the adelic completion, a selection over infinitely many places, and MR at
  that field (EL's theorem by statement). The manuscript reaches the same equality at `ℝ_alg` in nine steps with no place to
  select and a rigidity theorem proved in the text. If Theorem 2.3 stands, **"given MR" leaves row 130's `χ(ℝ²) = χ_m⁰(ℝ²)`,
  `CLAUDE.md` § The aim links 1 and 5, and row 131's reading of the answer** — by citation of a theorem that is not this project's.
- **What stays conditional on row 120 exactly as before:** every statement about a *number field's* plane — `χ(ℚ(√47)²) = 5`
  (row 121), the main clause through five (row 123), `χ(F²) = χ(ℝ²)` at ℚ(√635087) and de Grey's field (row 128's field half),
  the fractional local–global principle at a field (row 129's `α₁(F²) = α_loc(F)`).
- **Nothing in this project's chain is shown wrong by it.** Row 128's load-bearing step and theirs F1–F9 are the same argument
  at two fields; where both speak (the plane), they agree.

### 2.6 One consequence the manuscript does not draw, sketched (one mind; a candidate, not a result of this job)

*Run F1–F9 for one class instead of `k`.* Let `α₁(ℝ²)` be the finitary independence ratio (the infimum of `α(G)/|G|` over finite
unit-distance graphs, in `[MatolcsiEtAl2025]`'s blow-up sense) and `m₁(ℝ²)` the supremal density of a measurable set avoiding
distance 1. `α₁ ≥ m₁` is the easy half. For the other: Følner averaging gives an `E ⋊ K`-invariant random independent set of the
algebraic plane with `P(0 ∈ I) = α₁` (FS103-B-AMEN's Følner half, two blind); with `f = 1_{0 ∈ I}`, `p = 𝔼(f ∣ 𝓕_c)`, Theorem 2.3
gives `∫ p T_u p = 0` on `S¹` exactly as in F5–F7; a sample of the field `H` has `H(x)H(x+u) = 0` almost everywhere and mean
`α₁`, so `{H > 0}` is a weak unit-avoiding set of density at least `α₁`, and its density points (Lemma 4.3's argument) avoid
distance 1 everywhere. **So Theorem 2.3 would give `α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²)` with no hypothesis** — row 129's
"At ℚ(√635087), given MR there" clause, the first clause of `[DuczVarga2026]` Conjecture 1 and the equality question of
`[MatolcsiEtAl2025]` §2, `[Johnson1996fcn]` Question 1. The step to check before it is claimed: the passage from a stationary
field of mean `α₁` to a set of *upper density* `α₁` (an ergodic-average step row 131's attainment lemma covers at `k` classes).
INVENTORY: generalization.

### 2.7 What I reworked by hand, and what I took as read

Reworked: Lemma 2.4's finite-orbit step and the disjointness of the `L_{ua}`; Lemma 2.5's `T_sV_φ − V_φ` estimate and why `I`
restricts to Lebesgue integration; Lemma 2.6's equivariance; in Lemma 2.7 the invariance and integral of `r(y(x), d(x))`, the
equivariance `b(ky, kz) = k b(y, z)`, that `U_kH` encodes the phases at `ψ_k`, the choice of `t`, the arithmetic of the bins
(`0.9M/L > 10m²`; `18τ²/s² = 0.0018`; `(0.95² − 0.1)/m² > 1/(4m²)`), and that the lower and upper collision bounds are over the
same pairs; Lemma 3.1's strictness of the extension and the bounded basis; all of Lemma 3.2 (the pair criterion on the relative
product from tensors, the van der Corput step with its two limits in the stated order, the shift of exponents by a common integer);
both identities of Lemma 3.3 (`|A − Bu²|² = A² + B² − 2AB Re u² = (A−B)² + 4AB (Im u)²`; `−L + (A−B)u + Lu² = u((A−B) + 2iL Im u)`);
Lemma 3.5's three cases; the syndeticity, pigeonhole, `c₀` and `z < p` steps of the completion; Lemma 4.1's two directions; F5–F9;
Lemma 4.3. Taken as read (standard, cited, not re-derived): disintegration and equivariant kernels (`[TaoDisintegration2008]`); the
measurability paragraph of Lemma 3.1 (`M/rigidity.tex:82–101`); Lemma 3.4's rational-function argument (read, plausible, not
recomputed); the ergodic decomposition; `[Bekka2008]`'s appendix theorems.

**Attack on the theorem, by candidates.** (a) A circle of continuous characters is invariant and not Haar — and not wild. (b) A
Galois twist `z ↦ exp(iξ·σ(z))`: its `K`-orbit stays on a circle only if `σ` commutes with complex conjugation on `K`, hence on
`E` (which `K` spans: a small real is `k + k̄`), and then `σ` fixes the real closed field `ℝ_alg` and is the identity or
conjugation — inside `C`. (c) A character continuous for a `p`-adic topology: its orbit closure carries an invariant probability,
which the theorem forces to be Haar or to charge `C`; the trivial character is in `C`, so no contradiction is visible. I found no
counterexample; that is three candidates, not a search.

**The Lean statements that correspond, by name and by text only** (for reading side by side; I built nothing, and whether the
kernel accepts them is EXT-OAI1's): Theorem 2.3 in Fourier form is
`PlaneFiveColor.Spectral.wild_fourier (μ : Measure D) [IsProbabilityMeasure μ] (hw : IsWild μ) (z : E) (hz : z ≠ 0) : ∫ d, (eval z d : ℂ) ∂μ = 0`
(`lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean:335`), with `E := algebraicClosure ℚ ℂ` (`Basic.lean:9`),
`D := PontryaginDual DiscreteE` (`Basic.lean:48`), `IsWild` (`Basic.lean:300`); Proposition 4.2 is `proper_to_borel_weak`
(`lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean:436`). The module names follow the manuscript's moves
(`CompactFactors/Centers`, `RelativeCenters`, `PlaneSpectrum/PhaseCollision`, `SmallArcs`, `InvariantMean`, `NumberFields`,
`Selections`, `RadialEnergy`).

### 2.8 Predictions scored so far

P1 (0.85) **met**; P2 (0.70) **met**, with the two properties named; P3 (0.60) **half met** (radial and positive-definite, but on a
relative difference law); P4 (0.50) **met**; P9's first half (0.60: a rigidity step I cannot verify on one reading) **lost** — I
followed every step, taking only cited standard facts as read.

## Stage 3 — SAVED: the obstruction at five, read in full (their §§ 5–8; Theorem 1.4)

**What was read:** `M/palettes.tex` (663 lines), `M/transitions.tex` (641), `M/interfaces.tex` (670), `M/angular.tex` (773) — every
line. **Grade of this stage: read in full, no gap found by me, one mind, one pass**; what I reworked and what I took as read is
§ 3.6. One exact check of my own: the seven-point certificate (§ 3.6). Rows 133–154 of `LEDGER.md` read at their openings (133–139 in
full), with G83–G92.

### 3.1 The route of Theorem 1.4, in four acts

Standing objects (theirs): a weak measurable five-colouring `c` with classes `A_i`; *typical* points (density one of their own
colour — proper at every unit pair by Lemma 4.3); `H_i` the closed essential support of `A_i`; `R` the rotation by `κ = π/3`.

**Act 1 — the ring, in measure (§ 5).**

> For each fixed center \(x\), let \(\mathcal W_x\) be the family of
> vector functions in \(L^\infty(S;\R^5)\) that can be obtained as
> \[ b=\operatorname{w}^*\!-\!\lim_{n\to\infty} (a_i(y_n+r_ne))_{i=1}^5,\qquad y_n\to x,\quad r_n\to1, \]
> where every \((y_n,r_n)\) is a typical circle sampling.
> — `M/palettes.tex:49–56` (Definition 5.1; the *palette* `P_x(e)` is the set of labels `i` with `b_i(e) > 0` for some trace `b`,
> an essential union, defined up to angular null sets)

- **Lemma 5.2** (palette transfer): (1) "`c(x+e+v) ∉ P_x(e) ∪ P_x(v)`" for almost every `(e, v)`; (2) at a density direction `e`
  of `{i ∈ P_x}` and `v` not parallel to it, `A_i` has density zero at `x + e + v`; (3) for a smooth representation
  `z + f = x + s(f) + t(f)` by two non-parallel unit directions, "`P_z(f) ∩ P_x(s(f)) = ∅`" almost everywhere. The proof pairs one
  weak-* limit with one strongly convergent factor (a change of variables in the two-angle sum map), never two weak limits.
- **Corollary 5.4**: "`P_x(f) ∩ P_x(Rf) = ∅` for almost every `f ∈ S`."
- **Lemma 5.5** (binary-centre separation): a centre is *binary for* a pair of labels if almost every palette meets the pair; then
  the choice is a sign `s_x` with `s_x(t + κ) = −s_x(t)`. "There is an absolute constant `δ_* > 0` such that, for every fixed pair
  of labels, any two distinct centers binary for that pair are at distance at least `δ_*`." Proof: writing a point of `y`'s ring as
  `x + e^{iα₊(t)} + e^{iα₋(t)}` makes `s_x` invariant under `H = α₊ ∘ α₋⁻¹`, hence under six near-identity diffeomorphisms
  `F_j(t) = t + (2d/√3) sin(t − jκ − π/6) + O(d²)`, one of which expands at every point; Sullivan's bounded-distortion argument
  (`[DeroinKleptsynNavas2008]` § 2.1, adapted) spreads a density point of `{s_x = 1}` to an interval and then to the whole circle,
  against measure `π`.
- **Proposition 5.6**: "`1 ≤ |P_x(e)| ≤ 2` for almost every `e ∈ S`", at every centre. Proof: a triple in the palette on a
  positive-measure set of `e` leaves **the complementary pair** on the unit circle about `x + e`, so those `x + e` are infinitely
  many binary centres for one pair on a compact circle.

**Act 2 — vertices are locally finite (§ 6).**

> For $x\in\R^2$, let $\Gamma_x$ be the simple graph on $\mathcal I$ in
> which $ij$ is an edge precisely when, for every ball $B$ centered at $x$
> with positive finite radius,
> \[ \limsup_{\substack{h\to0\\h\ne0}} \frac{D_{ij}(B,h)}{|h|}>0. \]
> — `M/transitions.tex:31–38` (Definition 6.1; `D_ij(B, h)` is the area of the `q ∈ B` with `{c(q), c(q+h)} = {i, j}`)

- **Lemma 6.2**: an edge `ij ∈ Γ_x` has a trace at `x` with `b_i = b_j = 0`; so "`P_x(e) ⊄ {i, j}`" almost everywhere. Proof: the
  circle average is `½`-smoothing — `|σ̂(ξ)| ≤ C(1+|ξ|)^{−1/2}` gives `‖𝒮(a_s − a_s(·+h))‖_{L²(B)} = o(√|h|)` — and a transition
  set of area `≥ c|h|` meets that at exactly the Cauchy–Schwarz threshold.
- **Lemmas 6.3, 6.4**: two states whose label groups cover all labels but `X` put density one of `X` at `x + a + b`, so the
  closed essential support of either contains no two directions 60° apart (two density-one points of `X` at distance exactly 1);
  and no state function alternates under `R` between a singleton `{X}` and a fixed pair — the rotation by `γ`, `cos γ = 5/6`,
  irrational, yields a unit equilateral triangle whose vertices all have density one of **the two remaining labels**.
- **Theorem 6.5**: "`𝓛 = {x ∈ ℝ² : Γ_x contains a cycle}` is closed and locally finite". Three cases on five labels. *Triangle*:
  palettes of size ≤ 2 not inside an edge meet the outside pair, so `x` is binary: Lemma 5.5. *Four-cycle* `0123` with fifth label
  `X`: states `X`, `U = {0,2}`, `V = {1,3}`, continuous in `x` in `L¹(S)` along the locus; moving the centre moves a support
  endpoint `a` with a velocity `V_H(a; b) = −(H·b)/(a × b)` depending on its partner `b`, and two partners with different
  velocities push a point of the support into a gap. *Five-cycle*: every palette is a diagonal `D_i = {i, i+2}`, steps under `R`
  are `±1 mod 5`; a contact of two adjacent states at one direction bans that step on the whole circle (Lemma 6.7), and an
  accumulation forces two such contacts that isolate a state.

**Act 3 — one vertex with its interfaces, from topology (§ 7).**

> \begin{proposition}[A cycle of common exclusion continua] … there
> exist an integer $\ell\in\{3,4,5\}$, distinct labels
> $i_0,\ldots,i_{\ell-1}\in\mathcal I$, a point $x\in\R^2$, and a
> radius $\rho>0$ with the following properties. For each edge
> $i_ji_{j+1}$ of the simple label cycle, with indices modulo $\ell$,
> there are a compact connected set
> $K_j\subset\overline{B(x,\rho)}$, a direction $v_j\in S$, and a
> sequence $q_{j,k}\in K_j\setminus\{x\}$ such that … $x\in K_j$ and $K_j\cap\partial B(x,\rho)\ne\varnothing$; …
> both endpoint supports are excluded from the same open set:
> \[ H_{i_j}\cap\Delta(K_j)= H_{i_{j+1}}\cap\Delta(K_j)=\varnothing. \]
> — `M/interfaces.tex:31–50` (Proposition 7.1, abridged at the two ellipses; `Δ(K) = {z : min_{q∈K}|z−q| < 1 < max_{q∈K}|z−q|}`)

How: disc averages `p_i^ε` are continuous probability vectors with `p_i^ε(q) + p_i^ε(z) ≤ 1` at **every** unit pair (Lemma 7.2); a
missing edge `ij ∉ Γ_x` gives `∫ p_i^ε p_j^ε = o(ε)`, so the points where both exceed a threshold `α < 1/5` lie in discs of
vanishing total radius (Lemma 7.3); thresholding and renormalizing gives a continuous map `q^ε` into the simplex which, off those
discs and off small discs about `𝓛`, lands in **the complete graph on the labels** (a clique in a forest has at most two
vertices), and the small discs away from `𝓛` are filled through trees (Lemma 7.4). If every loop around a point of `𝓛` were
null-homotopic the map would extend over a 10 × 10 square, and the sets `{coordinate i > 0}` would be an open cover of
multiplicity ≤ 2 whose members have diameter ≤ 1 + o(1) — a path of one label joining points more than 1 apart forbids that label
near its end (Lemma 7.6) — against Lebesgue's covering theorem (Lemma 7.5, by Brouwer). So some loop is essential; its reduced
word contains a simple cycle; every loop in its class meets each edge midpoint (Lemma 7.7); a component of each midpoint's
preimage crosses the annulus (Lemma 7.8); Hausdorff limits are the `K_j`.

**Act 4 — every vertex type is impossible (§ 8).** With `v_j` the limiting directions and signs `sgn(e · v_j)`: a strip just
outside the unit circle about `x` near `e` uses only the labels `O(e)` left after deleting the endpoints of the positive edges,
and one just inside only `I(e)`; both are non-empty and both meet `P_x(e)` (Lemma 8.1).
- *Five-cycle* (no outside label; Prop. 8.2): palettes are one of two diagonals, the same two at antipodes; six steps of `±1`
  with antipodal difference `0, ±2` must all agree and then do not close mod 5.
- *Four-cycle* (one outside label `X`; Prop. 8.5): a direction without `X` is *split* (signs `++−−`) and its palette is a
  diagonal; six-position words always contain `X` at one parity; the four rays are two antipodal pairs, the diagonal is `U` on
  one projective arc and `V` on the other, one of length ≤ π/2 — too short for three positions spaced `π/3`.
- *Triangle* (two outside labels `X, Y`; Prop. 8.10): the ring carries exactly one outsider at almost every direction,
  alternating under `R`; two-colour rigidity on open strips (a four-edge unit path keeps `c(q) = c(q+h)`; Lemma 8.6) makes it
  locally constant off one six-point orbit, so the outsiders occupy **six alternating 60° sectors** (Lemma 8.7); then every
  `x + e + v` with `e`, `v` in sectors of opposite outsiders is free of both outsiders, an open region
  "`υ²(3ξ² − υ²)² < l³(1 − l/4)(l − 1)²`" using only the three triangle labels (Lemma 8.8), and a rotated, translated Moser
  spindle, `z_g = ((35+12i)/37)(g + (−290+149i)/250)`, lies inside it (Lemma 8.9).

### 3.2 How the manuscript makes "the map step"

**It does not make it; it goes around it.** This project's route M asks that a tight colouring be made a map — interfaces that
are curves, a locally finite singular set with finitely many arcs at each point (REG-J′), reached through saturation and contact
(rows 140–144, G84, G85) — so that the regular theory (rows 132–138) applies. The manuscript proves no regularity of any colour
class: no curve, no finite perimeter, no saturation, no maximal cover. What it proves instead, for an arbitrary weak measurable
five-colouring:

1. the points where **three or more classes meet cyclically in the transition sense** (`𝓛`) are locally finite — by ring
   rigidity (Act 1) and transport of ring data between nearby centres, not by any structure of interfaces;
2. off `𝓛` the smoothed, thresholded colouring is a continuous map into a **graph** (the 1-skeleton of the simplex on the
   labels) after filling holes through trees — the map of route M replaced by a map *to* the nerve;
3. dimension theory then forces one essential loop, and the "interfaces" are **connected components of the preimage of an edge
   midpoint**, carried to the limit as Hausdorff continua. `[SokolovVoronov2025]`'s exclusion holds on `Δ(K_j)` because
   connectedness alone gives a point of `K_j` at distance exactly 1.

So the sentence in their introduction — "We derive corresponding exclusions from weak measurable data, without assuming regular
color boundaries" (`M/introduction.tex:57–58`) — is accurate as read, and the object it yields is weaker than a map and enough:
one point, `ℓ ≥ 3` continua through it with limiting directions, and the two-colour exclusion on each. Row 140 already recorded
that at five the map step "is equivalent to `χ_m⁰(ℝ²) ≥ 6` (VM2-EQ5): a reformulation, not a step toward six"; the manuscript
reaches `χ_m⁰(ℝ²) ≥ 6` without it.

### 3.3 Against this project's results: re-derived, not needed, new to us

| in the manuscript | in this project | relation |
|---|---|---|
| Cor. 5.4 and the binary sign `s_x(t+κ) = −s_x(t)` | G91, FS116-RING-TWIST-C: the ring of a vertex is a proper colouring of its 60°-hexagon graph by the absent colours, "alternating under the 60° rotation" | **re-derived in measure**, at a three-colour vertex of a five-colouring (ours: a four-colour vertex of a six-colouring); the *palette* is the ring read two-sidedly |
| the diagonal states `U`, `V` at a four-cycle centre (a palette of two of the vertex's own colours) | a **(Q) arc** on the ring ("an arc of the boundary whose two side colours the vertex carries", row 149) | the same phenomenon; their four-cycle argument is, in our words, the exclusion of a four-colour vertex whose ring carries (Q) arcs — at five, with one absent colour |
| Lemma 8.1's strips `O(e)`, `I(e)` from the signs `e · v_j` | FS114-N-E2's cone form ("every tile's cone and colour is pinned by the half-planes facing the edges' centres", row 138) | re-derived from limiting directions only |
| Lemma 8.7: six alternating 60° sectors | the Γ-free ring with six change points (row 148, FS116-Y4-EMPTY) | the same ring; **a different kill** (§ 3.5) |
| Lemma 6.3: no two support directions 60° apart, by two density-one points of `X` at distance 1 | G83's straddle ("two tiles of one colour forced along two unit circles to come within 1") | re-derived in measure |
| Lemma 7.6's mesh bound | row 132's hole-filling tool ("a one-coloured connected region avoiding distance 1 has diameter at most 1") | re-derived for the smoothed colouring |
| Prop. 7.1 (3) | `[SokolovVoronov2025]` Props. 1–2, this project's FS106-SV chain | re-derived for continua |
| Lemma 7.6: some point of `𝓛` carries an essential loop | row 137, FS114-CV-EXISTS (every valid six-map with unit arcs "has a vertex of at least four colours"), there by Woodall's reduction and S–V's Cor. 1 | the five-colour analogue by covering dimension; **it selects no vertex type** (§ 3.4) |
| Lemma 6.2's `o(√|h|)` | rows 130–131: properness survives weak limits "because the circle measure's Fourier transform decays"; G90 ("spend the plane's dimension at distance exactly 1") | the same input, used quantitatively at its exact exponent |
| Lemma 4.3 | FS103-M-D (D1) | weaker form, printed |
| Lemma 8.6 | Townsend's annulus (rows 132, FS131-E1) | cited by them as a predecessor (`[Townsend2005]` Thms 1, 4) |
| Lemmas 6.4, 5.5 (an irrational rotation; an expanding family on the ring) | FS129-SA1-FALC-RED (Falconer's fan with an irrational angle) | the same family of mechanism; Lemma 5.5's dynamics has no counterpart here |

**Not needed by their argument:** saturation, maximal covers, Grundy colourings and the top colour (rows 140–144, G84, G85, G89);
integer radii and pencils; row 131's periodic approximants and the hole functional `µ_k(ε)`; any tile count or discharging (row
137's count; G86); the non-Siamese and simplicity hypotheses of rows 138, 148–150 — nothing in §§ 5–8 distinguishes Siamese
pairs; any density bound on one class (row 129); measure rigidity (Theorem 1.4 is proved directly on the measurable colouring).

**New to this project, and colour-count-free as written** (my reading of the proofs; each is stated there in a five-colour
section but uses no count): Lemma 5.2 (transport of palettes between centres); **Lemma 5.5** (binary centres for one pair are
`δ_*`-separated, `δ_*` absolute — a statement **uniform in the colouring**, the kind row 139 says seven needs: "seven is the NO's
hole bound made uniform in the complexity bound"); Lemma 6.2 (an interface of positive `|h|`-density at `x` empties both its
colours from a trace at `x`); Lemmas 7.2–7.8 with the nerve map. INVENTORY: generalization (Lemma 5.5 and the extraction at
every `k`).

### 3.4 Which step uses five and not six

Five is not used at one step; it is used as **one arithmetic fact at three places**: *the labels a configuration does not use are
at most two, and two is where the ring is rigid.*

1. **Prop. 5.6** (`M/palettes.tex:639–640`): "uses only the complementary pair `{1,…,5} ∖ 𝒜`". A triple leaves a pair; a pair
   makes a binary centre; Lemma 5.5 applies. With six labels the same proof gives `|P_x(e)| ≤ 3` and no more: a triple leaves a
   triple, the ring about `x + e` is three-coloured with only `s(Re) ≠ s(e)`, and the identity
   `s_x(α₊(t)) = s_x(α₋(t)) = −s_y(t)` that drives the dynamics has no three-label form.
2. **Theorem 6.5**: the triangle's outside is a pair (binary again); Lemma 6.4 needs exactly two labels outside `{X} ∪ D`; the
   five-cycle's palettes are the diagonals of `C₅`, disjoint exactly at index difference `±1`.
3. **§ 8**: `5 = ℓ + (labels outside the cycle)`, with 0, 1, 2 outside for `ℓ = 5, 4, 3`, and each is locally contradictory.
   The triangle is killed because **two** outsiders make the ring binary, binary strips are rigid, and what is left is a
   **three**-label open region, which the 4-chromatic Moser spindle fits.

**At six a triangle has three outside labels and is not locally contradictory** — three-colour vertices are the generic
vertices of every seven-colouring and of the printed tight six-coloured regions (row 136's cubic trichromatic vertices). So a
six-colour version cannot end as theirs does, "every extracted cycle is impossible"; it needs a **global** step that selects a
cycle of length at least four, which is what row 137 does for maps, by Woodall's reduction and a count that G86 says is blind
to Siamese pairs.

**The statements about six that would make the same argument run**, in the order the argument needs them (none is claimed
here; each must fail for some colouring if `χ(ℝ²) = 6`):

- **[P₆]** in every weak measurable six-colouring, almost every palette at every centre has at most two labels (their method:
  at most three);
- **[L₆]** the locus of centres whose transition graph contains a cycle is locally finite (closedness is free). Given [L₆],
  **Acts 3 runs verbatim at six** — Lemmas 7.2–7.8 use no count — and yields a point, a simple label cycle of length
  `ℓ ∈ {3, 4, 5, 6}` and `ℓ` continua with the two-colour exclusion: *a map-step substitute, with no regularity*;
- **[G₆]** some such point carries a cycle of length at least four (the weak measurable form of row 137's FS114-CV-EXISTS),
  or the triangle case is refuted non-locally (the weak form of S–V's Cor. 1);
- **[A₆]** the angular exclusions at `ℓ = 4, 5, 6`, with two, one and no outside labels — the weak measurable form of
  C114-LOCAL-F (the ranked stubs FS-124, FS-123, FS-125). Their correspondence with the five-colour cases is by the number of
  outside labels, not by `ℓ`:

| outside labels | at five | at six | what the five-colour kill becomes at six |
|---|---|---|---|
| 2 | triangle (Prop. 8.10) | four-cycle = a four-colour vertex | binary ring, strips rigid (Lemma 8.6 as is); but the palette may be a diagonal of the vertex's own four labels (a (Q) arc) — the case their four-cycle argument handles with **one** outsider and ours holds open (FS-124); where the ring is (Q)-free, a **four**-label open region, which needs a **5-chromatic** unit-distance graph inside it (§ 3.5) |
| 1 | four-cycle (Prop. 8.5) | five-cycle = a five-colour vertex | the word argument needs "the non-diagonal state is the single outsider"; its six-colour form is open (FS-124's five-colour vertices) |
| 0 | five-cycle (Prop. 8.2) | six-cycle = a six-colour vertex | the mod-5 closing argument has no mod-6 form: on `C₆` both `{i, i+2}` and `{i, i+3}` are admissible palettes (row 148 holds a six-colour vertex on every disc of radius below 3/2) |
| 3 | — | triangle | locally possible; needs [G₆] |

**How it fits more than one class together** (the brief's question against row 129). Row 129 says a bound on one class at a
time gives at most `⌈1/α⌉ ≤ 5`. The manuscript never bounds a class. Its three devices are all about *which classes coexist*:
(i) the palette is a set of labels at a point of a ring, and its exclusion `c(x+e+v) ∉ P_x(e) ∪ P_x(v)` removes labels from a
region according to **two** palettes at once — the count enters as "the complement of what two palettes hold"; (ii) the
transition graph is a graph on pairs of classes, and the topological step is the nerve of the cover by the classes (a plane
region cannot be covered with multiplicity two by sets of diameter about 1); (iii) the endgame is combinatorics of a label
cycle against its complement. This is G25's ladder in measurable form — "χ ≥ 5 a regional pigeonhole whose kills are the
previous level's forcer" — with the kills by a unit pair (one label left: Lemma 6.3), a unit triangle (two left: Lemma 6.4)
and the Moser spindle (three left: Prop. 8.10).

### 3.5 One cross-application, stated as a question (a candidate; nothing here is derived beyond the first sentence)

In a valid six-coloured fragment about a vertex `p` of exactly four colours whose ring is (Q)-free, every point
`p + e + v` with `p + e` interior to the absent colour `X` and `p + v` interior to the absent colour `Y` is at distance 1 from
both, so it carries one of `p`'s four colours: **the region is four-coloured, with no hypothesis on Siamese pairs or
simplicity.** With the ring's six alternating 60° sectors it is their region (8.2), which contains a neighbourhood of `p`, the
whole circle of radius `√3` and six spokes. So *if some unit-distance graph that is not four-colourable lies in that region
under a rigid motion, the (Q)-free four-colour vertex dies on every disc of radius above 2 in every class* — the Siamese class
included, which rows 148–149 do not reach and FS-123 holds open ("left: the Siamese class"). The manuscript's triangle kill is
this statement one colour down, where the graph is the Moser spindle. Whether a 5-chromatic graph (509, 510, 553 vertices in
print) fits is a placement search over three parameters, exact to verify, and standing rule 5 makes it the Searcher's.
INVENTORY: search request; stub to re-aim (FS-123).

### 3.6 What I reworked, what I took as read, and one check of my own

Reworked by hand: Lemma 5.2 (2)'s `o(h²)` and (3)'s two limits; Cor. 5.4; in Lemma 5.5 the representation
`d + e^{it} = e^{iα₊} + e^{iα₋}`, the expansions of `α_±`, `α₋⁻¹`, `F`, the identity `s_x ∘ F_j = s_x`, the two maxima over six
phases, the interval-enlarging and distortion estimates, the extension step; Prop. 5.6; Lemma 6.2's Plancherel multiplier and the
Cauchy–Schwarz threshold; Lemmas 6.3 and 6.4 (the triangle of side 1 at distance `1/√3`); (6.5) and the limit in Lemma 6.6; the
support transport rule, the velocity formula, the two-partner step and the closing separation argument for four-cycles; Lemma
6.7; the five residues `j` in the five-cycle accumulation; Lemmas 7.2, 7.3 (`N_ε ε = o(1)`), 7.5; the mesh argument of Lemma 7.6
and its reuse in Prop. 7.1 (3); Lemma 8.1's sign identity; Prop. 8.2's runs and the mod-5 step count; the split signs, Lemma
8.4's four steps and Prop. 8.5's arc count; Lemma 8.6's four-edge path; Lemma 8.7's count of projective classes; Lemma 8.8's
triple-angle identities. Taken as read: the strong convergence (5.2) of Lemma 5.2 (1) (a standard change of variables, read, not
recomputed); the third (uniform) clause of Lemma 6.3; the `o(δ_n)` remainder justification; Lemma 7.4's merging bookkeeping;
Lemmas 7.7 and 7.8 (graph words; a component crossing an annulus — standard, read in full); the isolation step inside Lemma 8.3
(read, plausible, not recomputed); the manuscript's two certificate tables.

**My own check of Lemma 8.9**, independent of their tables: `data/external/oai2/moser_certificate_check.py` evaluates
`P` and `P′` at the seven placed points in interval arithmetic at 60 digits and the eleven unit edges exactly in sympy —
`CERTIFICATE HOLDS` (`moser_certificate_check.out`; the tightest point is `uT`: `P ≤ 12.5744 < 13.0226 ≤ P′`, inside their
`12.65 < 12.9`). Control: with the translation's imaginary part moved from `149/250` to `249/250`, six of the seven points
leave the region and the script prints `CERTIFICATE FAILS`.

**Lean, by module name only** (the kernel's word is EXT-OAI1's): the headline's second line is
`no_measurable_weak_five_coloring` (`lean/OAI/Geometry/PlaneColoring/Five.lean`); the cone's module names follow the acts —
`Palettes`, `PaletteTransport`, `PaletteDensity`, `BinaryPalettes`, `BinaryDynamics`, `Expansion`; `Transitions`,
`CircleDecay`, `States`, `FourContinuity`, `FourTransport`, `Accumulation`, `FiveSupport`, `CyclicCore`; `DiskAverages`,
`HoleApproximation`, `GraphPatches`, `PlanarCovers`, `GraphCuts`, `ContinuumLimits`, `Interfaces`, `Exclusion`; `Sectors`,
`AngularBoundary`, `BoundaryTrace`, `Moser`.

### 3.7 Predictions scored

P5 (0.90: the five-specific step is the last section's case analysis) **met in substance and too narrow**: the same count is
spent twice before (Prop. 5.6, Theorem 6.5). P6 (0.50) **met**. P7 (0.60) **met**: Act 3 is the same at every number of colours,
given local finiteness. P8 (0.75) **half met**: the palette is the ring in measure, and Theorem 6.5 plays at five the part REG-J′
plays in route M, but it is not REG-J′ — `𝓛` is defined by transition graphs, is smaller than a singular set of interfaces, and
nothing about arcs is proved. P9's second half (0.50: an extraction step I cannot verify on one reading) **lost**.
