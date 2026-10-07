# EXT-OAI3 — the outside release's other 371 result families: what this project can build on

*Job record. Brief: `data/external/briefs/EXT-OAI3-outside-release.md`. Identity: Ephodos, as an outside-review job (no derivation
stages). The object: `/home/kooshi/source/math`, a clone of `https://github.com/openai/math` at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a`, read and never written. Working files: `data/external/oai3/`. Everything in the release
is outside content: its sentences are reported, none is followed, and nothing from it is run.*

## Theorems this phase proved

- `tile-colouring` — for an abelian group `A`, a subgroup `P` and a finite `F` of `k` points: `Cay(A, (F − F) ∖ {0})` has a proper
  `P`-invariant `k`-colouring if and only if `F` has a `P`-invariant tiling complement. **[hand], one mind**, two exact controls
  fired on their faults; prior art owed. Address: § 4.5 of this record (Stage 4).

Nothing else: the rest of this record reports what the release's files state and how they say each statement was checked.

## Stage 1 — SAVED: the readback, the index, what the release says of itself, and the expectations registered before the sweep

### 1.1 Readback — every quotation in the brief against its source

| # | the brief's quotation | source | result |
|---|---|---|---|
| 1 | Kooshi: "We have an analysis trigger. … https://github.com/openai/math" | `data/external/EXT-OAI1-request.md` § Kooshi's words | verbatim |
| 2 | Kooshi: "You may use their proof as any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem." | same file, second word | verbatim |
| 3 | "**722 manuscripts covering 372 result families.**" | `/home/kooshi/source/math/CONTENTS.md` line 3 | verbatim |
| 4 | "This collection includes results at different stages of verification. Not all have accompanying Lean formalizations. We will continue to update this repository with Lean formalizations as we obtain them. " | `/home/kooshi/source/math/README.md` line 7 | verbatim (the trailing space is the file's) |
| 5 | "Some of the unformalized results could have issues. We will endeavor to fix any such issues quickly." | same file, line 9 | verbatim |

The brief's facts about the object, checked: the commit is `adc7f1241b42e322a6451854ab7e4b4c146bf78a`, dated 2026-10-06 14:58:50 −0700,
one commit, 3.1G on disk, the working tree clean (`git status --porcelain` prints nothing); tracked files by extension 122140 lean,
7731 tex, 997 md, 762 pdf, 501 bib, 479 json, 125 py, 28 txt — as the brief says (and, below its list: 23 patch, 14 cpp, 11 log,
11 gitignore). The request file holds all three of Kooshi's messages, as the brief says.

**One mismatch, small**: the brief says "eleven reasoning summaries". The folder `reasoning_traces/` holds eleven *files* — ten PDFs
and one TeX source (`mezard-parisi-formula.tex`) — and the README's table lists **ten** subjects (families 007, 017, 087, 102, 159,
197, 221, 271, 287, 362). Family 158 has no reasoning summary.

### 1.2 The index

Built by `data/external/oai3/build_index.py` (mine; it reads the release and writes only beside itself; it runs `pdftotext` on each
manuscript's first two pages and nothing from the release). Outputs, all under `data/external/oai3/`:

- `families.tsv` — one row per result family: number, subject, manuscript count, Lean note, comparator files, title, catalogue sentence;
- `index.jsonl` — one row per manuscript: family, title, PDF path, catalogue abstract, the manuscript folder's own title and date,
  whether the catalogue of formalizations lists it, and the abstract as `pdftotext` reads it from the PDF (an independent source);
- `index.md` — the same, readable;
- `index-summary.txt` — the counts below;
- `control-three-rows.txt` — the hand control.

**The counts** (`index-summary.txt`, verbatim):

```
families parsed from CONTENTS.md: 372 (distinct: 372; numbered 001..377; contiguous: False)
manuscripts parsed from CONTENTS.md: 722 (distinct pdf paths: 722)
preprint folders on disk: 722; in catalogue and on disk: 722; on disk not in catalogue: []; in catalogue not on disk: []
catalogue pdf missing on disk: []
manuscripts with TeX source in their folder: 722
README title equals catalogue title: 668 of 722
catalogue notes after a manuscript link: ['secondary writeup'] on 1 manuscripts
families with a subject from overview.tex: 372
families whose catalogue entry links a Lean note: 235; lean/docs notes on disk: 235; families with a note on disk: 235; mismatch: []
formalization.yaml: sources listed 162; of them manuscripts in the catalogue 162; main_results (comparator configs) 185
manuscripts in a family with a Lean note: 467; manuscripts named in their family's note: 330
pdf abstracts located by the heuristic: 722 of 722
families by subject: Theoretical computer science 40; Combinatorics 37; Algebraic and complex geometry 36; Number theory 31; Probability and statistical mechanics 29; Differential geometry 29; Mathematical physics 25; Operator algebras 19; Algebra 18; Topology 18; Real and complex analysis 16; Partial differential equations 16; Convex and metric geometry 15; Group theory 14; Dynamical systems and ergodic theory 12; Functional analysis 11; Mathematical logic 6
```

**What the object is, as found** (the brief asked for this as a finding):

- **722 manuscripts in 372 families**, as it says; every manuscript is one folder under `preprints/` holding exactly one PDF, a
  `README.md` (title, "Author: OpenAI", date, a BibTeX block) and a `build/` folder with its TeX source — all 722 have TeX.
- **The family numbers run 001 to 377 with five numbers absent**: 045, 061, 070, 123, 163. The catalogue does not say why.
- **Seventeen subjects**, from `overview.tex`; the largest are theoretical computer science (40 families), combinatorics (37),
  algebraic and complex geometry (36) and number theory (31); "Dynamical systems and ergodic theory" has 12, "Convex and metric
  geometry" 15.
- **Lean, three different counts, and they must not be confused**: **235 of 372 families** have a formalization note
  (`lean/docs/NNN.md`), and the catalogue links exactly those; the notes name 330 manuscripts; `lean/formalization.yaml`, which
  calls itself the "Catalog of papers with a formalized main result", lists **162 papers** as sources and **185 main results**,
  each with a comparator configuration; the folder `lean/ComparatorChallenges/` holds 405 challenge files. So a family "with Lean"
  can mean a note whose scope is narrower than the manuscript: each row below quotes the note's own scope sentence.
- The 54 title differences between the catalogue and the manuscripts' own READMEs are typographic (dashes, `π` against "pi",
  TeX against Unicode) but for four: family 003's second manuscript is "The Quasi-Riemann Hypothesis (alternate 11/12 proof)" in the
  catalogue and "The Quasi-Riemann Hypothesis" in its folder; two SLE manuscripts carry subtitles in their folders; and one
  half-plane title differs in notation only.

**The control** (`control-three-rows.txt`): three index rows — family 167 (`A-power-saving-for-planar-unit-distances-…`), family 172
(`A-classification-of-finite-Euclidean-Ramsey-configurations-…`) and family 337 (`Sharp-integral-fillings-in-CAT(0)-spaces-…`, the
folder whose name first broke the parser) — each set against the PDF's first page read by `pdftotext -layout` and against the
`abstract` environment of the manuscript's TeX: title, date and abstract agree in all three. Two parser faults were met and fixed on
the way, both failing loudly (a folder name with parentheses; a catalogue line with a trailing note): the script stops on any
catalogue block it cannot parse, so a silent drop is not possible, and the counts 372 and 722 match the release's own.

### 1.3 What the release says of itself (quoted)

- **What it is** (`README.md` line 3): "This repository contains mathematical manuscripts and supporting proof artifacts produced by
  an internal OpenAI model."
- **Why** (line 5): "As part of model development, we evaluate our models on open research problems. We expanded these evaluations
  after performance on our existing mathematical evaluations saturated. Some outputs build upon earlier results produced by the
  models."
- **Verification** (lines 7, 9): the two sentences of the readback, rows 4 and 5; and (line 19) "Many, but not all, of the
  manuscripts have been formalized."
- **How produced** (line 41): "The vast majority of results were obtained with the same procedure using an unreleased internal
  OpenAI model. On average, each result used three hours of ChatGPT Pro thinking compute with that model. Over the course of the
  evaluation, the model was posed approximately 4,000 problems. Aggregating the output into result families and manuscripts and
  requiring an appropriate level of significance led to the catalog outlined above."
- **Exceptions** (line 43): "Exceptions to this fixed procedure include work on a zero-free region for the Riemann zeta function and
  proof of the Hodge Conjecture for CM abelian varieties. Additionally, the writeup for the Re(s) > 11/12 zero-free region for the
  Riemann zeta function was human edited for readability."
- **Versions** (line 48): "We will preserve the public release history of this collection. Corrections and revisions will be recorded
  as new versions, with previously released versions remaining accessible."
- **Citation** (line 50): "To cite the individual manuscript, use the BibTeX block in its directory."
- **Families** (line 14): "A family groups related papers, which may include a principal result, companion arguments, consequences,
  or alternative proofs. Each family is classified by mathematical discipline."
- **Licence**: `LICENSE` is the Apache License, Version 2.0; `lean/formalization.yaml` says `license: "Apache-2.0"`.
- **The Lean library, of itself** (`lean/formalization.yaml`): `status: scope: "Partial progress."`; `automation: methods: - method:
  agent`; **`review: status: unchecked`**; toolchain `leanprover/lean4:v4.34.1`; it "builds-on" Mathlib and 30-odd other libraries it
  lists (among them `PrimeNumberTheoremAnd`, `carleson`, `sphere-eversion`, `schoenflies-lean`). `lean/README.md`: "This directory
  contains Lean formalizations of some results in this repository."
- **How to check** (`lean/ComparatorChallenges/README.md`): "Install `comparator`, `landrun`, and `lean4export`, and make them
  available on `PATH`." — three outside programs; this job runs none of them (the brief; and FS-131 inventory item 619 (b) holds the
  comparator's audit as a job of its own).

So the grade a row here can carry is one of three, in this project's words: **[external; Lean in the release, statement and
comparator challenge named, not built or audited here]**; **[external; Lean note with a narrower scope, quoted]**; **[external;
manuscript only]**. Only family 158 is at **[kernel, outside]** (built and audited here, FS-131 inventory items 614, 619).

### 1.4 Expectations, registered before the sweep

Written after building the index and running its control, and before reading the list of titles or running any keyword. What I had
seen by then: the three families the brief names (073, 167, 172), two of them in the control's rows; nothing else of the catalogue
beyond its first two families.

| # | expectation | probability | what it decides |
|---|---|---|---|
| E1 | at least one Tier A family exists beyond 073, 167, 172 (and 158) | 0.7 | whether the first message carries more than the brief's own three |
| E2 | some other family claims more on the Hadwiger–Nelson problem itself (the plane's chromatic number, its measurable form, or `m₁(ℝ²)`) than family 158 does | 0.08 | an immediate message, and the asking lane's re-rank |
| E3 | a Tier B hit: a proof of something this project takes as a hypothesis or outside theorem, or an answer to a question its frontier poses | 0.3 | whether a hypothesis in `scripts/assumptions-ledger.txt` can be discharged by citation |
| E4 | a Tier C hit beyond what EXT-OAI2 found inside family 158 | 0.15 | a line owed to `LEDGER.md` § The claim list |
| E5 | the release can be triaged in one context at the level of every family's title and catalogue sentence and every manuscript's title (372 + 722), with abstracts and statements read only for the families flagged | 0.85 | whether a second reviewer is needed (the brief's item 6) |

**On size** (the brief's item 6): the catalogue is 640 KB; the 372 family sentences are 178 KB and the 722 titles about 50 KB. Every
family title and sentence and every manuscript title can be read in this context; the 722 abstracts in full cannot, and need not be:
a family's sentence is the catalogue's own statement of its problem. Where I cut: abstracts and manuscripts are opened only for
families the two passes flag; Tier A hits are read at their statements, not in full, as the brief says.

## Stage 2 — SAVED: the sweep, its control, and the first tier

### 2.1 How the sweep was made

Two passes, neither trusted alone.

- **By eye**: all 372 family titles with their catalogue sentences, and all 722 manuscript titles, read in full
  (`data/external/oai3/families-read.txt`, one line per family, generated from the index). Abstracts were opened only for families
  flagged.
- **By keyword** (`data/external/oai3/sweep.py`; Python `re`, never `grep -E`; output `sweep-output.txt`): the brief's phrases in the
  discipline's words and from the other side, and three groups of mine — the same questions elsewhere, what this project assumes or
  poses, and methods — over each family's title and sentence, each manuscript's title and catalogue abstract, and the abstract
  `pdftotext` read from the PDF.
- **The control** (`sweep-control.txt`): in a scratch copy of the index, three of the brief's phrases ("measurable chromatic number",
  "distance-avoiding", "Moser spindle") were planted in one row's abstract (row 400, family 218); the sweep finds all three there,
  and finds none in the true index.

**Zero hits in the whole release** for: "measurable chromatic", "distance-avoiding", "unit-distance graph", "distance graph",
"forbidden distance", "de Grey", "Moser", "polychromatic", "density … avoid", "Kneser", "sphere packing", "kissing", "Steinhaus",
"Lovász", "Hoffman", "Furstenberg", "invariant measure", "Rajchman", "Kloosterman", "Herglotz", "Tarski", "real closed",
"Hedetniemi", "Cayley graph", "four-colour", "Kempe", "descriptive", "incidence". "Hadwiger" hits family 157 (Hadwiger's conjecture
on clique minors — another Hadwiger) and 158; "Nelson" and "chromatic number of the plane" hit 158 alone; "unit distance" hits 158
and 167; "Falconer" hits 073 alone (the distance conjecture, not his theorem on measurable colourings).

### 2.2 The first tier — five families (sent to the coordinator, 2026-10-07)

Catalogue sentences verbatim from `/home/kooshi/source/math/CONTENTS.md`; Lean status as the release states it, none of it built or
audited here.

| family | title | catalogue sentence | manuscripts | Lean, as the release states it |
|---|---|---|---|---|
| 073 | The Falconer distance conjecture | "Resolves the Falconer distance conjecture in every dimension d ≥ 2: every compact set $E\subset\mathbb R^d$ with Hausdorff dimension greater than $d/2$ determines a set of Euclidean distances of positive Lebesgue measure." | 1 | note `lean/docs/073.md`; challenges `PlanarFalconer.lean`, `FalconerAllDimensions.lean`, each with a solution module; the catalogue's main-results list names the planar one only |
| 166 | The higher-dimensional Erdős distinct-distances conjecture | "For every fixed d ≥ 3, any n ≥ 2 distinct points in ℝ<sup>d</sup> determine at least $c_dn^{2/d}$ distinct distances, with $c_d\gt 0$ depending only on dimension. This matches the integer-grid order and resolves the higher-dimensional Erdős distinct-distances conjecture with a constant-factor bound." | 1 | none: manuscript only |
| 167 | Planar distinct distances and unit-distance bounds | "Proves the weak pinned Erdős distance conjecture: for every fixed ε > 0, all but $o(n)$ points of any n-point planar set determine at least $n^{1-\varepsilon}$ distinct nonzero distances. A complementary theorem bounds the number of unit-distance pairs by $O(n^{4/3-\delta})$ for an absolute δ > 0." | 2 | note `lean/docs/167.md`; challenges `PinnedDistances.lean`, `PlanarUnitDistances.lean`, each with a solution module; the note says both "The separate unit-distance power-saving theorem is not included." and that the formalization proves it; the main-results list names the pinned one only |
| 172 | Classification of finite Euclidean Ramsey configurations | "Classifies finite point configurations that occur monochromatically, at their original scale, in every finite coloring of sufficiently high-dimensional Euclidean space. The characterization is an algebraic condition over the coordinate field. It also disproves the Leader–Russell–Walters conjecture that every such configuration is a subset of a finite transitive set." | 1 | note `lean/docs/172.md`; seven challenges; `OAI.EuclideanRamsey.classification` and `OAI.GrahamSpherical.full_main` are in the main-results list |
| 156 | Borsuk's conjecture fails in dimension nine | "Constructs a compact subset of ℝ<sup>9</sup> that cannot be covered by ten sets of strictly smaller diameter, disproving Borsuk's covering assertion already in dimension nine. The example consists of rank-one orthogonal projectors onto lines in ℝ<sup>4</sup>, with the Frobenius metric." | 1 | note `lean/docs/156.md`; challenge `BorsukNine.lean`, in the main-results list |

**The tier widened, and why**: the brief's Tier A names "the same questions in other dimensions … or for other forbidden distances".
Borsuk's partition number is the chromatic number of a set's diameter graph — the classical sibling of this problem — so 156 is in.
The brief's own keyword listing had 073, 167 and 172; 166 and 156 are from the reading.

**No other family claims anything on the Hadwiger–Nelson problem itself** — the plane's chromatic number, the measurable or
almost-everywhere form, the chromatic number of a field's plane or a finite plane, a finite unit-distance graph's chromatic number,
or the density of a unit-distance-avoiding set (E2: not met, as expected).

**Three counts of "has Lean"** in this release, found while reading the five: a family note exists (235 families); the paper is among
the 162 "with a formalized main result" in `lean/formalization.yaml`; a comparator challenge is in that file's main-results list
(178 of the 405 challenge configurations on disk are; 227 are not). Each row in the stages below says which of the three it means.

**Family 158, one item seen in passing** (not re-read): its Lean note lists a second comparator challenge, `PlaneColoring.lean` —
`theorem properColoring_seven : ProperColoring 7`, namespace `OAI.Problem160`, solution module `OAI.Geometry.PlaneColoring.Main` —
"the upper bound includes every boundary point of the coloring regions" (`lean/docs/158.md`).

### 2.3 Candidates flagged for the other tiers, from the reading (confirmed or dropped in the stages below)

- Tier B candidates: the release's own Lean library, for a proof of anything this project imports (Weil's bound for Kloosterman
  sums; Bochner–Herglotz; the real-algebraic descent) — a sweep of the library's declaration names, stage 4; family 015 (its
  abstracts name "measure rigidity").
- Tier D candidates: 015, 028, 084, 090, 096, 144, 145, 154, 155, 157, 182, 231, 266, 354, 366.

## Stage 3 — SAVED: the first tier at its statements

*Read at the statements, not in full (the brief's item 3): each family's main theorems from its TeX source, the Lean note, the
comparator challenge. Not claimed: the correctness of any of them. Grades are in this project's words; "Lean in the release" means a
challenge file with a solution module exists in the release's library — none was built, replayed or audited here, and the
release's own catalogue says `review: status: unchecked`.*

### 3.1 Family 172 — finite Euclidean Ramsey configurations (the one that touches this project's ground)

Manuscript: `preprints/A-classification-of-finite-Euclidean-Ramsey-configurations-September-23-2026/` (26 pages; `build/sections/`).
**The definition** (`01-introduction.tex`): "A finite nonempty set $A$ in a Euclidean space is \emph{Ramsey} if, for every integer
$r\ge2$, there is an integer $D\ge1$ such that every map $c:\R^D\to\{1,\ldots,r\}$ is constant on a congruent copy of $A$. … The
coloring is an arbitrary function. In particular, no measurability or other regularity is assumed."
**The theorem** (Theorem 1.1, "Classification", verbatim): "Let $A=\{a_1,\ldots,a_s\}\subset\R^d$ be a finite set of at least two
points with affine span $\R^d$, and define $p_i,F,B,m_F$ as above. Then $A$ is Ramsey if and only if there is a matrix
$P\in\operatorname{Mat}_{d+1}(B)$ such that $(p_i\otimes1)^T P(1\otimes p_i)=0$ $(1\le i\le s)$, $m_F(P_{\alpha\beta})=\delta_{\alpha\beta}$
$(1\le\alpha,\beta\le d)$." — with $p_i=(1,a_i)^T$, $F=\Q((a_i)_\alpha)$ the coordinate field, $B=F\otimes_{\Q}F$ and $m_F:B\to F$
multiplication. Its consequences as stated: every subtransitive set and every set of at most five points on a circle is Ramsey; a
twelve-point set on the unit circle and a nine-point generic circle configuration are not; the Leader–Russell–Walters
characterization fails in its necessity direction.
**The necessity half** (Proposition `alg:necessity`, `02-tensors.tex`): "If [the tensor equation] has no solution, then there is an
integer $r_0\geq2$ such that every $\R^D$ admits an $r_0$-coloring with no monochromatic congruent copy of $A$." Its colouring: a
ℚ-linear functional $\ell$ on $(\R\otimes_\Q\R)^s\oplus\mathrm{Sym}_d(\R)$ separating $(0,\ldots,0,I_d)$ from the image of the tensor
map; $h_i(x)=\ell_i(x\otimes x)$, $H_i(z)=\sum_j h_i(z_j)$; "Color a point $z$ by the $s$-tuple of interval labels of the
representatives of $H_i(z)$ modulo $2$", $K^s$ colours, $K = 2s+1$, in every dimension. "These are purely algebraic functionals; no
continuity or measurability is asserted or needed."
**Checking, as the release states it**: note `lean/docs/172.md` — "The formalization gives the tensor-field classification for
full-affine-span configurations, covers singleton and affine-span reductions, and proves that every Ramsey configuration is
cospherical" — and seven comparator challenges; `OAI.EuclideanRamsey.classification` (`OAI/Combinatorics/EuclideanRamsey/Main.lean`)
and `OAI.GrahamSpherical.full_main` are in the catalogue's main-results list, the other five challenges are not.
Grade here: [external; Lean in the release, not built or audited here].
**What it would let a deriver do.** Nothing in the plane directly: the theorem is about every number of colours in unbounded
dimension, and a two-point set is Ramsey, so it bounds no chromatic number of a fixed space. What it holds that this project can use
is a **method on its own ground**: the obstruction side is a colouring of ℝ^D by the values modulo 2 of ℚ-quadratic functionals read
off the coordinate field — the unbounded-dimension sibling of this project's additive and character colourings (G41, G74, G77, row
100) — and the classification says exactly when no such algebraic colouring can avoid a configuration: when an identity holds in
$F\otimes_\Q F$ *before* multiplication. That is the same kind of certificate as the chain theorem's ring membership (`1/δ ∈ ℤ[U_F]`,
G55, row 103): a ring identity that kills every colouring of a class. A planner could ask one thing of it: whether the tensor
condition has a fixed-dimension, fixed-colour-count form — "which finite configurations over a field `F` occur monochromatically in
every `k`-colouring of `F²`" is this project's forced-pair and virtual-edge vocabulary (row 42) asked of general configurations.
**Not a frontier-changer**: no line of § Where the problem stands moves. Since family 158's transfer makes wild colourings no better
than measurable ones in the plane, its colourings cannot save a colour there.

### 3.2 Family 156 — Borsuk in dimension nine (a nerve-type obstruction with a rigidity statement at the threshold)

Manuscript: `preprints/A-nine-dimensional-counterexample-to-Borsuks-covering-assertion-September-23-2026/` (18 pages).
**The theorem** (Theorem 1.1, verbatim): "The compact set $X=\{uu^{\mathsf T}:u\in\mathbb R^4,\ \|u\|=1\}
\subset\{A\in\operatorname{Sym}_4(\mathbb R):\operatorname{tr}A=1\}$, with the Frobenius metric, has diameter $\sqrt2$ and cannot be
covered by ten subsets of diameter strictly less than $\sqrt2$." Corollary: "For every integer $d\geq9$, there is a compact subset of
$\mathbb R^d$ of diameter $\sqrt2$ that cannot be covered by $d+1$ subsets of strictly smaller diameter." In this project's words:
"Two projectors in $X$ are at diameter distance precisely when their underlying lines are orthogonal", so the statement is that the
orthogonality graph on the lines of ℝ⁴ needs eleven colours for covers by sets of smaller diameter.
**Its method, in its words** (`introduction.tex`, Proof overview): "A hypothetical cover by ten sets of strictly smaller diameter can
be enlarged to an open cover. A smooth partition of unity then gives nonnegative functions $f_1,\ldots,f_{10}$ on $\mathbb{RP}^3$,
with sum one, such that orthogonal lines have disjoint sets of positive coordinates." Then: "its mod-two degree forces every maximal
support to have four labels and the sum of these tetrahedral faces to be a cycle"; "At the threshold of $k(k+1)/2$ labels on
$\mathbb{RP}^{k-1}$, a maximal support with fewer than $k$ labels would give a positive-dimensional regular level set inside one
affine projective chart"; the finite part "follows them across adjacent tetrahedra by purely combinatorial arguments". Key internal
statement: "There is no admissible map $\mathbb{RP}^3\to\Delta^9$."
**Checking, as the release states it**: note `lean/docs/156.md`; challenge `BorsukNine.lean`, `OAI.BorsukNine.main_theorem`
(`OAI/Geometry/Borsuk/`), in the main-results list. Grade here: [external; Lean in the release, not built or audited here].
**What it would let a deriver do.** It is a second worked instance, beside family 158's act 3 (FS-131 inventory item 618), of
replacing a colouring by a continuous map to a simplex whose supports are disjoint at the forbidden distance, and of killing the map
topologically — here with a statement family 158 does not have: **at the threshold number of labels every maximal support is forced
to have exactly dim + 1 labels**, a rigidity of the tight case. `plans/STUB-six-by-the-nerve.md` needs statements of that kind at six
(palettes of at most two labels; cyclic centres locally finite — item 618's [P₆], [L₆]). Its limit is stated in its first step: the
enlargement to an open cover needs slack, so it reaches this project's colourings with slack (the hypothesis `Voronov11`, the band
`[1 − ε, 1 + ε]` of row 131) and not exact or almost-everywhere colourings. A reader for the nerve route should read its §§ 3–5
(`extension.tex`, `topology.tex`, `six-labels.tex`; about 12 pages). **Not a frontier-changer.**

### 3.3 Families 073, 166, 167 — distance sets and unit-distance counts (neighbours; no lever found)

| family | main theorem, verbatim from the manuscript | pages | checking, as the release states it | grade here |
|---|---|---|---|---|
| 073 | "Let \(d\ge2\) be an integer and let \(E\subset\R^d\) be compact. If \(\dim_H E>d/2\), then \(\cL^1(\Delta(E))>0\)." (`build/sections/00_introduction.tex`, Theorem `thm:main`) | 64 | note `lean/docs/073.md`: "The formalization proves the Falconer distance conjecture in every dimension"; challenges `PlanarFalconer.lean` (in the main-results list, `OAI.PlanarFalconer.mainTarget_proved`) and `FalconerAllDimensions.lean` (`OAI.Falconer.falconer_distance_conjecture`; solution module named `…Falconer.Campaign123PlanarFurstenbergProof`; not in that list) | [external; Lean in the release, not built or audited here] |
| 166 | "For every integer \(d\ge3\), there is a constant \(c_d>0\) such that every finite set \(P\subset\mathbb R^d\) of \(n\ge2\) distinct points satisfies \(|\Delta(P)|\ge c_d n^{2/d}\)." (`build/sections/introduction.tex`, Theorem `thm:main`) | 103 | no Lean note | [external; manuscript only] |
| 167, first | "For every fixed $s>0$, one has $F_n(s)\longrightarrow0$ as $n\longrightarrow\infty$", where $F_n(s)$ is the largest fraction, over $n$-point planar sets $P$, of ordered pairs $(x,y)$ whose distance from $x$ is repeated at least $n^s$ times from $x$; corollary: "every sufficiently large $n$-point planar set has a pin determining at least $n^{1-\varepsilon}$ distinct nonzero distances" | 27 | challenge `PinnedDistances.lean`, `OAI.WeakPinned.main`, in the main-results list | [external; Lean in the release, not built or audited here] |
| 167, second | "There are absolute constants \(0<C<\infty\) and \(1\le\beta<4/3\) such that \(u(n)\le Cn^\beta\) for every nonnegative integer \(n\)", $u(n)$ the largest number of unit-distance pairs among $n$ planar points | 53 | challenge `PlanarUnitDistances.lean` with solution module `OAI.Geometry.UnitDistances.Main`; not in the main-results list; the note `lean/docs/167.md` says in one paragraph "The separate unit-distance power-saving theorem is not included." and in the next that the formalization proves it | [external; Lean status contradictory in the release's own note] |

**What they would let a deriver do.** I found no lever, and say why. Falconer's conjecture is about the measure of the *whole*
distance set; a colour class avoids one prescribed distance and may have positive measure, so the theorem neither bounds a class nor
forces the distance 1. The unit-distance bound caps the edge count of an `n`-vertex unit-distance graph at `O(n^{4/3−δ})`: it bears
on average degree (G65's phase diagram reads degree, at fixed lattices where the count is exact anyway) and on no chromatic
statement. The distinct-distance theorems are about `n`-point sets with no colouring in them. They are the brief's Tier A by
subject; none changes a file here beyond a bibliography line. **None is a frontier-changer.**

## Stage 4 — SAVED: tiers B, C and D, a tier the brief did not name, and one entry of this job's own

### 4.1 Tier B — what this project assumes or poses: three hits

**B1 — an elementary Kloosterman bound, in Lean, for the sum this project's axiom is about.**
- *Where*: `/home/kooshi/source/math/lean/OAI/NumberTheory/Jacobsthal/` — `Estimates/PairCollisionCount.lean` (374 lines; imports
  nine Mathlib modules and nothing else), `Probability/KloostermanFourthMoment.lean` (72 lines), `Primes/KloostermanPrimeBound.lean`
  (85 lines). Namespace `OAI.Erdos970.ErdosKloosterman`. It is part of family 021's formalization (Jacobsthal's function; note
  `lean/docs/021.md`), not a result the release lists.
- *The statements, verbatim*: `noncomputable def sum {R : Type*} [CommRing R] [Fintype R] (ψ : AddChar R ℂ) (a b : R) : ℂ :=
  ∑ u : Rˣ, ψ (a * (u : R) + b * (↑u⁻¹ : R))`; `theorem fourth_norm_le (ψ : AddChar F ℂ) (hψ : ψ.IsPrimitive) (a b : F)
  (hab : a ≠ 0 ∨ b ≠ 0) : ‖sum ψ a b‖^4 ≤ 3 * (Fintype.card F : ℝ)^3` (with `{F : Type*} [Field F] [Fintype F]`); and for prime-power
  moduli `theorem standardSum_prime_power_bound (p a : ℕ) [Fact p.Prime] (ha : 1 ≤ a) (h k : ℤ) : ‖standardSum (p^a) h k‖ ≤
  ((a+1 : ℕ) : ℝ)^2 * ((p^a : ℕ) : ℝ)^((3 : ℝ)/4) * ((Nat.gcd (p^a) (Int.gcd h k) : ℕ) : ℝ)^((1 : ℝ)/4)`
  (`Primes/PrimePowerBound.lean`).
- *What it is*: `|K(a, b)| ≤ 3^{1/4} q^{3/4}` over every finite field — the elementary fourth-moment bound, by counting the solutions
  of `x + y = z + w`, `1/x + 1/y = 1/z + 1/w`. It is **not** Weil's `2√q`.
- *Grade and checking*: [external; Lean in the release, not built here]; by text, the release's library holds no `sorry` and no
  `axiom` declaration (`rg` over `lean/OAI`: zero files with `sorry`; three hits for `^axiom `, all inside comments).
- *What of ours it touches*: the library's one declared outside axiom, `HadwigerNelson.StandingFive.kloosterman_bound`
  (`Proofs/HadwigerNelson/Arith/WeilKloosterman.lean` l. 51; `CLAUDE.md` § Trust ledger), the named hypothesis `KloostermanBound`
  (`Arith/FloorPlanes.lean` l. 39: the same sum, `∑ x : Fˣ, ψ (a * x + b * x⁻¹)`, bounded by `2 * Real.sqrt (Fintype.card F)`), the
  inline hypothesis `KloostermanFrom347`, and the eight theorems the ledger lists as resting on the axiom; G44; row 123's chain.
- *What it would let a planner do*: with a bound `B(q)` on the non-trivial eigenvalues of a residue target of degree `q + 1`, the
  ratio bound refuses `k` colours once `B(q)/(q + 1) < 1/(k − 1)`. Weil gives that from `√q > (k − 1) + √((k − 1)² − 1)` — `q > 34`,
  `62`, `98`, `142` for `k = 4, 5, 6, 7` (G44's and G56's smaller figures at 59 and 71 are exact spectra, not Weil); this bound gives
  it once `q > 3(k − 1)⁴` — `q > 243`, `768`, `1,875`, `3,888`. So each floor this project takes from Weil
  holds from this theorem at every large residue field, and the axiom is needed only at the finitely many usable `q` in between —
  where an exact evaluation of the sums, or a sharper elementary bound, would remove it. That is a route to "the standard three
  axioms" for the eight resting theorems that needs no algebraic geometry. Not priced here: the finite list's cost in the kernel.
- *To rely on it*: port the three files to this repository's pin (Apache-2.0; the pins are 1,502 Mathlib commits apart, FS-131
  inventory item 619) and build them; read `pairCollisions_card_le` (the count `≤ 3(q − 1)²`), which carries the whole argument.

**B2 — the periodic-colouring question (FS-76's C3-aper; `[Ellenberg2018]`; `[AbrishamiEtAl2025]` Problem 4.6), answered no at some
colour count in rank 3, given family 155.**
- *Where*: `preprints/A-translational-tile-with-no-fully-periodic-tiling-in-dimension-three-September-23-2026/` (26 pages).
- *The statement, verbatim* (Theorem `thm:main`): "There is a finite nonempty set $T\subset\Z^3$ such that: (i) $T$ tiles $\Z^3$ by
  translations, but no translation set $A$ with $A\oplus T=\Z^3$ is invariant under a subgroup of finite index in $\Z^3$; (ii) the
  set $\Omega=T+[0,1]^3$ tiles $\R^3$ by translations up to null sets, but no such tiling has a translation set invariant under a
  lattice of full rank in $\R^3$."
- *Grade and checking*: [external; Lean in the release, not built or audited here] — note `lean/docs/155.md`; challenge
  `PeriodicTilingThree.lean`, theorem `periodic_tiling_counterexample_and_minimality`, which also states `IsLeast {d |
  HasTileWithoutPeriodicComplement d} 3`. The tile's size is not in the statement.
- *What of ours it touches*: `plans/STUB-four-colour-inheritance.md` question 1 ("does every four-colourable Cayley graph of `ℤ^r`
  have a periodic four-colouring?", C3-aper); `BIBLIOGRAPHY.md`'s rows `[Ellenberg2018]` ("`[CGHO2025bg]` §6.2.1 carries it as open
  in 2025"), `[AbrishamiEtAl2025]` ("the paper is silent on ℤ^d, d ≥ 2") and `[GreenfeldTao2024]` ("FS-73's C3-aper is the colouring
  form for Cayley graphs of ℤ^r. Paper not read"); G71's sentence that three colours are periodic "with no arithmetic of the lattice"
  and that at four "decidability is stated open in print"; row 79.
- *The link is this job's own entry* (`tile-colouring`, § 4.5 below): a proper `k`-colouring of `Cay(A, (F − F) ∖ {0})`, `k = |F|`,
  invariant under a subgroup `P`, exists if and only if `F` has a `P`-invariant tiling complement. **Given family 155's theorem**,
  `Cay(ℤ³, (T − T) ∖ {0})` is `|T|`-colourable and has no periodic `|T|`-colouring: the existence question has the answer no at
  `k = |T|`, in rank 3. **Given `[GreenfeldTao2024]`** (held here by its review only: recalled, not read), the same entry gives no in
  some large rank from refereed work. *Not claimed*: anything at four colours; anything about a unit-distance lattice; that the
  reduction is new (prior art owed: the zbMATH Open API answered HTTP 503 to four queries on 2026-10-07).
- *What it would let a deriver do*: stop treating "colourable ⟹ periodically colourable" as possibly true for every `k` in the
  abstract class — row 79's three-colour theorem is then a statement about three, and the four-colour question is a threshold
  question (where between 3 and `|T|` does periodicity fail, and in which rank: the periodic tiling conjecture holds in `ℤ` and
  `ℤ²`, by the manuscript's own account and its minimality clause). For FS-76's question 2 it removes the hope of a two-sided
  certificate scheme in the abstract class at large `k`.
- *To rely on it*: build and audit family 155's Lean (a job of its own, as family 158's was); read `[GreenfeldTao2024]`.

**B3 — the machinery of measure rigidity, in Lean (FS-113, "measure rigidity in full, in Lean").**
- *Where*: `/home/kooshi/source/math/lean/OAI/NumberTheory/DukePrimeDegree/` — 886 files, 87,763 lines; family 015.
- *What its files say they formalize* (headers, not read further): conditional entropy and information for countable partitions,
  conditional measures along leaves, and steps cited to "Einsiedler--Katok (2003)" (Lemmas 6.1, 8.1, 8.2, Props. 5.1, 8.3),
  "Einsiedler--Katok--Lindenstrauss (2006), Theorem 1.3 and Corollary 1.4" and "Einsiedler--Lindenstrauss, Proposition 7.44".
  The note `lean/docs/015.md`: "The formalization proves equidistribution of volume-weighted torus packets for totally real number
  fields of every fixed prime degree at least five." Challenge `DukePrimeDegree.lean`.
- *Grade*: [external; Lean in the release, not built or audited here; scope narrower than the family — the note covers the
  prime-degree manuscript only, not the quartic and sextic ones].
- *What of ours it touches*: the hypotheses `MR`, `PE2`, `EFPlus`, `RU` of `SpectralChain.Interface` (row 120's chain, which rests on
  `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement), `plans/STUB-mr-in-lean.md`, and § The aim's "Lean throughout — MR in full".
  It is not the solenoid theorem this project imports; it is the same toolkit (leafwise measures, entropy contribution, the
  high-entropy and low-entropy steps), and Mathlib has none of it.
- *To rely on it*: a reading of the folder's `Entropy/` and `Geometry/` statements against EL2021's proof, by whoever opens FS-113.

**Searched and not found** (the release's library, by declaration name, and the catalogue): Weil's bound itself (`2√q`); a
Bochner–Herglotz theorem on a character group outside family 158's own files (`Herglotz` hits are the disc's representation theorem
in other families; `spectralMeasure` in family 144's folder is for one transformation of the 3-torus); Tarski–Seidenberg or a
transfer to the real algebraic numbers (two files name Tarski, neither a transfer lemma; EXT-OAI2's bridge without Tarski stands as
the only item); `Voronov11` (six colours with slack) — no family; any independence number of a finite plane (`Alpha11`, `Alpha23`,
`Alpha83`) — no family; an invariant-measure theorem for a group action (`OAI/Dynamics/SmoothObstruction/InvariantMeasure.lean`
proves `exists_invariant_probability` for one continuous map, not `InvariantMeasureOnClosed`'s two commuting families). No family
answers a question of `CLOSED-QUESTIONS.md` or a ranked stub other than FS-76's and FS-113's above.

### 4.2 Tier C — prior art for this project's claim list: none found outside family 158

The search: `LEDGER.md` § The claim list read whole; its vocabulary and the literature's (`BIBLIOGRAPHY.md` § E's translations) swept
over the index in 28 patterns (`data/external/oai3/sweep-tierC.txt`: "additive colouring", colourings by cosets or homomorphisms,
"unit-vector group/ring", "character colouring", "regular chromatic", "circular chromatic", "Cayley", "height function",
"local–global", "categorical product", "frozen", "norm one", "Galois ring", "totally real", "solenoid", and others), beside the
full reading of the 372 catalogue sentences. Every hit was opened in the index and is unrelated (residue fields of local rings,
valuations in algebraic geometry, 2-adic Galois representations, height functions of lattice models). **No statement this project
lists as its own appears in any family but 158**, whose overlap EXT-OAI2 has recorded (rows 128 and 130's equality). No line is
owed to the claim list from this job.

### 4.3 Tier D — methods and neighbours, named, not studied

| family | what it is (catalogue's words, shortened) | Lean note | why it is named |
|---|---|---|---|
| 090 | triangular-lattice universal optimality; manuscripts include "A sharp Fourier certificate for planar circle packing" | yes | exact Fourier (linear-programming) certificates in the plane — the method family of the bounds on `m₁(ℝ²)` (row 129; FS-133's densities) |
| 084 | Erdős similarity, geometric case: compact sets of measure near one with no affine copy of `{qⁿ}` | yes | constructions of large measurable sets avoiding a pattern |
| 182 | power savings for sets with no difference in a polynomial's values | yes | density of difference-avoiding sets: the one-dimensional `G(ℤ, D)` neighbour (G78) |
| 155 | a translational tile of `ℤ³` with no periodic tiling | yes | Tier B above (B2); also the aperiodic-order gate (FS-63) |
| 366 | planar Mumford–Shah: the discontinuity set is locally a `C^{1,α}` arc, a crack tip or a triple junction at 120°, finitely many components on compacts | none | a regularity theory for planar interfaces with a locally finite singular set — the shape of route M's REG-J′ and FS-127's question |
| 354, 337 | the isoperimetric profile of the cubic 3-torus with every finite-perimeter minimizer; sharp Cartan–Hadamard isoperimetry | yes | finite-perimeter sets and their regularity (§ The aim, link 6) |
| 071 | Koebe's circle-domain conjecture | yes | its Lean folder is the release's planar topology (see 4.4) |
| 144, 145, 154 | simple Lebesgue spectrum on the 3-torus; Rokhlin's multiple mixing; pointwise multiple ergodic averages | 144, 145 yes; 154 none | spectral and mixing theory of measure-preserving maps; no route identified |
| 015 | torus-packet equidistribution | yes | Tier B above (B3) |
| 157 | fractional colouring against clique minors (Hadwiger's conjecture on minors) | yes | graph colouring; no route identified |
| 096 | Gaussian propeller: optimal measurable partitions of Gaussian space | yes | an optimisation over measurable partitions; no route identified |
| 028 | bounded components of the graph on Gaussian primes at distance at most `D` | yes | a distance graph on a point set; no route identified |
| 165, 187, 266 | crossing numbers of complete graphs; Snaky in 21 moves; no four mutually unbiased bases in dimension six ("a complete certified computation under the stated binary64 arithmetic and compiler conditions") | yes | machine-checked finite combinatorial or geometric statements: how the release packages a certified computation |
| 231 | the free uniform spanning forest is a factor of IID | yes | measurable equivariant constructions on graphs; no route identified |

### 4.4 A tier the brief did not name — the release's Lean library as infrastructure (the framing, attacked)

The four tiers sort the release by its *results*. The thing in it with the most bearing on this project's own stated programme is
not a result: it is 122,140 Lean files at Lean 4.34.1 under the Apache License 2.0, with no `sorry` and no `axiom` declaration by
text, holding developments this project's backlog and its "Lean throughout" line need and Mathlib lacks. Seen by name only (file
counts by `rg -l`; nothing built, nothing read past headers):

| what this project needs | where the release has material | files naming it |
|---|---|---|
| the map argument — Jordan curves, Schoenflies, planar domains (§ The aim link 4: "for Jordan boundaries, owed") | `OAI/Analysis/CircleDomains/` (family 071) | 418 |
| finite-perimeter sets and regularity (link 6: "De Giorgi's structure theory for finite-perimeter classes") | `OAI/Geometry/Perimeter/Regularity/` 174, `OAI/Geometry/CubicTorus/` 97 (family 354), `OAI/Analysis/AllenCahn/` 50 | 321 |
| entropy and leafwise measures (FS-113) | `OAI/NumberTheory/DukePrimeDegree/` (family 015) | 886 in the folder |
| Kloosterman sums (the one declared axiom) | `OAI/NumberTheory/Jacobsthal/` (family 021) | 19 |
| Hausdorff dimension, Frostman measures, energy integrals | `OAI/MeasureTheory/Falconer/` (family 073) | not counted |
| the proper seven-colouring and family 158's cone | `OAI/Geometry/PlaneColoring/` | 46 (audited: EXT-OAI1) |

Two cautions travel with it. The pins differ (1,502 Mathlib commits, FS-131 inventory item 619), so every piece is a port; and the
release's catalogue grades its own library `review: status: unchecked`, so a piece is trusted here only as family 158 was — built,
axioms printed, statement read. **A survey of the library by need — which of these folders states a lemma this project's backlog
would otherwise prove — is a job of its own, for the kernel lane's planner, and I recommend it.**

Two further things the tiers do not name. **Dependencies between families**: the README says "Some outputs build upon earlier
results produced by the models", and catalogue sentences cite one another (family 001 "Together with result 032", 002 "With result
006"); a family this project cites must have its in-release dependencies traced first — family 158's cone was Mathlib alone
(EXT-OAI1). **What the catalogue's silence means**: the README says "the model was posed approximately 4,000 problems" and the
catalogue keeps 372 families "requiring an appropriate level of significance"; so the absence of a family on seven colours, on six,
or on the density `m₁(ℝ²)` says nothing about whether those were posed.

### 4.5 This job's one entry — the link from a tiling to a colouring

derivation: tile-colouring
  statement: for every abelian group A, every subgroup P of A and every finite subset F of A with k ≥ 1 elements, the graph
    Cay(A, (F − F) ∖ {0}) has a proper colouring with k colours invariant under translation by P if and only if some subset T of A
    invariant under translation by P satisfies T ⊕ F = A
  uses only: that A is an abelian group and P a subgroup; that the k points of a translate of F differ pairwise by non-zero
    elements of F − F; that T ⊕ F = A means every element of A is t + f for one pair (t, f); no finiteness of A, no rank, no order
  not claimed: that the graph's chromatic number is k when F does not tile; anything at a colour count other than |F|; anything
    about a graph whose connection set is not a difference set; that a colouring with fewer period constraints is a tiling of a
    smaller tile
  converse: § Argument — tile-colouring, from a tiling to a colouring
  argument: § Argument — tile-colouring, from a colouring to a tiling
  verdict: derived
  grade: hand
  minds: 1
  model: A = ℤ, F = {0, 1}, P = 2ℤ — Cay(ℤ, {±1}) is properly 2-coloured by parity, and T = 2ℤ has T ⊕ F = ℤ
  prior art: owed
  handoff: none — a relay-result for the coordinator and the asking lane; it crosses to the kernel lane only if FS-76's existence
    question is kept

control: tile-colouring-forward
  of: tile-colouring — the forward direction, on ℤ/n for 2 ≤ n ≤ 9, every F containing 0 with 2 ≤ |F| ≤ 4 and every subgroup, by
    complete enumeration of colourings and of translation sets; the fault takes the connection set (F ∪ −F) ∖ {0}
  run: python3 ../data/external/oai3/tile_colour_check.py --direction forward
  expect: 0 colourable and not tileable in 767 cases (n <= 9, |F| <= 4); both in 77
  fault: python3 ../data/external/oai3/tile_colour_check.py --direction forward --connection F

control: tile-colouring-converse
  of: tile-colouring — the converse direction, on the same set; the fault adds ±1 to the connection set
  run: python3 ../data/external/oai3/tile_colour_check.py --direction converse
  expect: 0 tileable and not colourable in 767 cases (n <= 9, |F| <= 4); both in 77
  fault: python3 ../data/external/oai3/tile_colour_check.py --direction converse --connection plus1

#### Argument — tile-colouring, from a colouring to a tiling

Write `S = (F − F) ∖ {0}` and let `c` be a proper colouring of `Cay(A, S)` with `k = |F|` colours, with `c(x + p) = c(x)` for
`p ∈ P`. (1) For each `y ∈ A` the `k` points `y + f`, `f ∈ F`, are distinct and pairwise adjacent, since `(y + f) − (y + f′) = f −
f′ ∈ S` for `f ≠ f′`. So `c` takes `k` different values on `y + F`: every colour occurs there once. (2) Fix a colour `j` and put
`C = c⁻¹(j)`, `T = −C`. By (1), for each `y` there is one `f ∈ F` with `y + f ∈ C`. Given `x ∈ A`, apply this to `y = −x`: there is
one `f` with `f − x ∈ C`, that is, with `x − f ∈ T`. So every `x` is `t + f` for one pair `(t, f) ∈ T × F`: `T ⊕ F = A`. (3) `C` is
invariant under `P` because `c` is, and `−P = P`, so `T` is.

#### Argument — tile-colouring, from a tiling to a colouring

Let `T ⊕ F = A` with `T + p = T` for `p ∈ P`. For `x ∈ A` let `c(x)` be the `f` of its one representation `x = t + f`; the colour
set is `F`, of `k` elements. *Proper*: if `c(x) = c(x′) = f` and `x − x′ = g − g′` with `g ≠ g′` in `F`, then with `x = t + f`,
`x′ = t′ + f` we get `t − t′ = g − g′`, so `t + g′ = t′ + g` is one element with two representations (`g′ ≠ g`), against `T ⊕ F`.
*Invariant*: `x + p = (t + p) + f` with `t + p ∈ T`, so `c(x + p) = f = c(x)`.

#### What rests on it

With `P` running over the subgroups of finite index: `F` tiles `A` with no fully periodic tiling if and only if
`Cay(A, (F − F) ∖ {0})` is `|F|`-colourable with no periodic `|F|`-colouring — so the periodic tiling conjecture for a tile is
`[Ellenberg2018]`'s question for one graph at one colour count. B2 above is this with family 155's tile, and its grade is the weaker
of the two: [hand, one mind] over an outside theorem not audited here. The look-back: it could have been foreseen — the bibliography
row for `[GreenfeldTao2024]` already calls C3-aper "the colouring form" of the tiling question — and it deforms to its neighbours
(any group, any period subgroup); what it does not reach is a colour count below the clique number, which is where four colours on a
triangle-free or `K₄`-free lattice lives.

## Stage 5 — SAVED: drafts for files this job does not write, the expectations scored, and what is left

### 5.1 Drafts (each names its slot; none is filed by this job)

**D1 — `BIBLIOGRAPHY.md` § A, row `[OAIMath2026]` (line 401), last cell: replace its closing sentence** "**Every other family (371):
listed in the catalogue only, unread**" **with:**

> **The other 371 families: swept by EXT-OAI3 (2026-10-07, `plans/EXT-OAI3-review.md`; index `data/external/oai3/`)** — every family's
> title and catalogue sentence and every manuscript's title read; nine families opened further, none read in full and none built or
> audited here. *Read at their main statements* (TeX source, Lean note, comparator challenge): 172 (*A classification of finite
> Euclidean Ramsey configurations*; Lean in the release), 156 (*A nine-dimensional counterexample to Borsuk's covering assertion*;
> Lean), 073 (*The Falconer distance conjecture in all dimensions*; Lean), 166 (*The higher-dimensional Erdős distinct-distances
> conjecture*; manuscript only), 167 (*The weak pinned planar distance theorem*, Lean; *A power saving for planar unit distances*,
> Lean status contradictory in the release's note), 155 (*A translational tile with no fully periodic tiling in dimension three*;
> Lean). *Lean statements read, by text*: family 021's elementary Kloosterman bound (`OAI.Erdos970.ErdosKloosterman.fourth_norm_le`,
> three files importing only Mathlib). *File headers only*: family 015's `OAI/NumberTheory/DukePrimeDegree/` (886 files). *Every
> other family: catalogue sentence only.* The release's catalogue grades its own library `review: status: unchecked`.

**D2 — `BIBLIOGRAPHY.md` § A, same row, second cell (what of ours rests on it): add after its last sentence:**

> Nothing of ours rests on any family but 158. Candidates, each unadopted until its own job: family 021's Kloosterman bound against
> the declared axiom `StandingFive.kloosterman_bound` (EXT-OAI3 § 4.1 B1); family 155 with EXT-OAI3's entry `tile-colouring` against
> FS-76's C3-aper (B2); family 015's Lean against FS-113 (B3); families 156 and 172 as method (its §§ 3.1–3.2).

**D3 — `BIBLIOGRAPHY.md` § C, row `[GreenfeldTao2024]` (line 805): replace** "FS-73's C3-aper is the colouring form for Cayley graphs of
ℤ^r. Paper not read" **with:**

> FS-73's C3-aper is the colouring form for Cayley graphs of ℤ^r, and the link is exact for one graph: a tile `F` has a fully periodic
> tiling iff `Cay(A, (F − F) ∖ {0})` has a periodic `|F|`-colouring (EXT-OAI3's `tile-colouring`, [hand], one mind, prior art owed) —
> so a single aperiodic tile of `ℤ^d` answers `[Ellenberg2018]`'s question no at `k = |F|` in rank `d`. Paper not read: whether its
> theorem gives such a tile in some `ℤ^d` is recalled from its review, not read.

**D4 — a bearing line for `plans/STUB-four-colour-inheritance.md`, to follow its line 7** ("Provisional bearings, updated at the
2026-09-25 crunch's close …"):

> **Provisional bearings, updated 2026-10-07 (EXT-OAI3):** C3-aper is false in the abstract class at some colour count, given either of
> two outside theorems — `[OAIMath2026]` family 155 (a tile of `ℤ³` with no periodic tiling; Lean in the release, not audited here) or
> `[GreenfeldTao2024]` (large rank; recalled, not read) — through EXT-OAI3's `tile-colouring`: `Cay(A, (F − F) ∖ {0})` is
> `|F|`-colourable with a periodic `|F|`-colouring iff `F` tiles periodically. Question 1 is therefore a threshold question (the least
> `k ≥ 4` and the least rank at which a `k`-colourable Cayley graph of `ℤ^r` has no periodic `k`-colouring; for graphs of this
> difference-set form ranks 1 and 2 are excluded by the periodic tiling theorems there — recalled, not read; the release's challenge
> states that three is the least dimension), and question 2's two-sided certificate scheme cannot
> exist for every `k`. Nothing moves at four colours or on a unit-distance lattice.

**D5 — a bearing line for `plans/STUB-mr-in-lean.md` § Provisional bearings, to follow its first paragraph:**

> *2026-10-07 (EXT-OAI3):* `[OAIMath2026]` family 015's Lean folder `OAI/NumberTheory/DukePrimeDegree/` (886 files, 87,763 lines, Lean
> 4.34.1, Apache-2.0; headers only read) names conditional entropy for countable partitions, leafwise measures and steps of
> Einsiedler–Katok 2003 and Einsiedler–Katok–Lindenstrauss 2006 — the toolkit EL2021's proof uses, absent from Mathlib. Read its
> `Entropy/` and `Geometry/` statements before planning PE-2's inputs from scratch; every piece is a port across 1,502 Mathlib commits.

**D6 — a line for `CLAUDE.md` § Trust ledger, to follow** "its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1."
**(a candidate, not a change of state — file it only if the kernel lane takes the job):**

> A route to removing the axiom is on record (EXT-OAI3 § 4.1 B1): `[OAIMath2026]` family 021's Lean proves `|K(a, b)|⁴ ≤ 3q³` over every
> finite field in three files importing only Mathlib, which gives each floor from `q > 3(k − 1)⁴`; what is left is the usable residue
> fields below that threshold.

**D7 — a bearing line for `plans/STUB-six-by-the-nerve.md`, to follow its line 8:**

> *2026-10-07 (EXT-OAI3 § 3.2):* `[OAIMath2026]` family 156 (Borsuk in dimension nine; Lean in the release, not audited here) is a
> second instance of the map-to-a-simplex method, with a rigidity statement at the threshold number of labels — every maximal support
> has exactly dim + 1 labels, by a mod-two degree count — of the kind [P₆] and [L₆] ask for. Its first step enlarges a cover to an open
> one, so it applies with slack only. Read its `extension.tex`, `topology.tex` and `six-labels.tex` at the opening.

**D8 — `LEDGER.md` § The claim list:** no line. No prior art for any item of the list was found outside family 158 (§ 4.2).

**D9 — `plans/GROKKING-INSTANCES.md` § G92** (a held result reaches as far as its argument), a new instance, verbatim:

> EXT-OAI3 (2026-10-07): the bibliography row for `[GreenfeldTao2024]` had called C3-aper "the colouring form" of the periodic tiling
> conjecture since FS-73's close and stopped there; read for what a tiling *is* in graph words — a clique partition — the form is an
> equivalence for one graph, and the published counterexample answers the question the stub carried as open (EXT-OAI3 § 4.5). Source:
> `plans/EXT-OAI3-review.md` § 4.1 B2.

### 5.2 The expectations of § 1.4, scored

| # | expectation | registered | outcome |
|---|---|---|---|
| E1 | a Tier A family beyond 073, 167, 172 | 0.7 | **met** — 166 (distinct distances in higher dimension) and, by widening, 156 (Borsuk) |
| E2 | another family claims more on the problem itself than 158 | 0.08 | **not met** — none claims anything on it |
| E3 | a Tier B hit | 0.3 | **met**, three, each partial: a weaker bound than the axiom's; an answer at a colour count other than four; machinery, not the theorem |
| E4 | a Tier C hit beyond 158 | 0.15 | **not met** |
| E5 | one context suffices at the depth of titles and catalogue sentences | 0.85 | **met** |

Brier score over the five: (0.09 + 0.0064 + 0.49 + 0.0225 + 0.0225)/5 = 0.126. The miss is E3, priced at 0.3: I priced it as "does
a family prove one of our hypotheses", and the hits came from two places that question does not look — the release's Lean library
below its headline results (B1, B3), and a consequence nobody had drawn from a result on another subject (B2).

### 5.3 What this job did not do

- It read no manuscript in full and built no Lean. Every grade above is the release's own statement about itself.
- It did not survey the Lean library by need (§ 4.4): only seven name patterns and five folders were looked at.
- Tier D is named from catalogue sentences; a family whose bearing shows only inside its manuscript is not in it. The 722 abstracts
  were swept by keyword and read only for flagged families.
- Prior art for `tile-colouring` is unmeasured (the zbMATH API returned HTTP 503 to four queries at the time of the job).
- The frontier stubs were read at their one-line questions (`plans/FRONTIER-STUBS.md`'s table, 74 rows), not stub by stub; a stub
  whose question is narrower than its line could hide a hit.
