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
