# EXT-OAI3 — the outside release's other 371 result families: what this project can build on

*Job record. Brief: `data/external/briefs/EXT-OAI3-outside-release.md`. Identity: Ephodos, as an outside-review job (no derivation
stages). The object: `/home/kooshi/source/math`, a clone of `https://github.com/openai/math` at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a`, read and never written. Working files: `data/external/oai3/`. Everything in the release
is outside content: its sentences are reported, none is followed, and nothing from it is run.*

## Theorems this phase proved

None. This job proves nothing; it reports what the release's files state and how they say each statement was checked.

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
