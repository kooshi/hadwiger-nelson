# M2-S1D — the bridge χ(ℝ²) = sup over real number fields of χ(F²), by hand (crunch job J17)

*Record of crunch job **J17** (derivation), milestone M2 (FS-39's hand step, `plans/STUB-plane-bridge.md`). Brief:
`data/crunch-2026-09-25/briefs/J17-M2-bridge-derivation.md` with `STANDING-RULES.md`. Opus 5.5, 2026-09-25. Working files:
`data/m2/j17/`. No Lean written, no build run. Novelty claimed: **none** (standing rule 4; the product is a correct write-up with the
credit right).*

## Theorems this phase proved

*(filled at stage 3; grades from `CLAUDE.md` § Notation)*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

Every quotation and cited paragraph in the brief, checked against its source on disk. Texts extracted with `pdftotext -layout`; the passages
relied on are kept as excerpts in `data/m2/j17/excerpts/` (full texts not committed: they are the library's, not the repository's).

| # | quotation or citation in the brief | source checked | result |
|---|---|---|---|
| Q1 | C1–C4, "verbatim; your fixed claim list" | `plans/M2-kernel-lane.md` §4.2 "Fixed claim list for J17" | **identical**, character for character (whitespace-normalised `diff`) |
| Q2 | Fischer's Remark 1: "Given a finitely generated extension E ⊂ R over Q, it may be realized as a purely transcendental extension of some finite algebraic extension F over Q." (p. 188) | held PDF, `excerpts/fischer1990-thm6-remarks.txt` | **matches** (the PDF's OCR has `c` for `⊂`); page 188 correct |
| Q3 | Madore ¶5.4: "One consequence is that χ(R^d) = χ((Q^{r−alg})^d) where Q^{r−alg} stands for the real closure of Q" | held PDF, `excerpts/madore2015-p5.1-5.4.txt` | **matches as a truncation**: the source continues "(which can be seen as the set of real algebraic numbers)" and footnote 5 (see Q6). Nothing altered |
| Q4 | `plans/M2-kernel-lane.md` §2.3's longer ¶5.4 quotation ("the finite graphs G for which there exists a graph homomorphism G → Γ(E^d) with E real closed do not depend on E … This time, the proof invokes Tarski's theorem on the decidability of the first-order theory of real closed fields …") | same | **matches**, with ellipses honest |
| Q5 | "J04 found that `[Madore2015]` ¶5.4 proves it correctly, by Tarski" | `BIBLIOGRAPHY.md` `[Madore2015]` row; `CLAUDE.md` line 919 (G56) | **re-finding, not a finding.** The bibliography row already reads "§5 (read 2026-09-15, FS-53 §PA): ¶5.4 … is FS-39's bridge, prior art; with de Bruijn–Erdős it gives `χ(ℝ²) = sup_K χ(K²)` over number fields", and G56 already calls the bridge "`[Madore2015]` ¶5.4 plus de Bruijn–Erdős". What J04 found is that `plans/STUB-plane-bridge.md` §3a ("the nearest thing we have … cited in prose only") had not caught up with the bibliography. Correction owed to the stub, not a new prior-art finding |
| Q6 | "Madore ¶5.4 … proves it correctly" (the *strength* of the proof) | `excerpts/madore2015-p1.3.txt`, `-p1.7.txt`, `-p5.1-5.4.txt` (¶5.4 and footnote 5) | **a one-sentence proof sketch that is correct**, not a written proof: ¶5.4 asserts that the finite graphs admitting a homomorphism to `Γ(E^d)` "do not depend on E" for `E` real closed and cites Tarski ("[Poizat 2000, theorem 6.41]"); the chromatic-number consequence uses ¶1.3 (de Bruijn–Erdős) in ¶1.7's homomorphism form. **What he actually needs is completeness (or model completeness) of the theory of real closed fields, not its decidability**; both follow from Tarski's quantifier elimination, so the citation is sound and the word "decidability" is loose. **The last step to "sup over real number fields" is not in Madore** — he stops at `ℚ^{r−alg}`; the step (a finite set of real algebraic numbers generates a real number field) is one line, and his own Prop. 5.3 proof makes the analogous step for `ℚ^{alg}` ("since the vertices of the image generate a finite extension"). Stage 2 writes both in full |
| Q7 | "Fischer stated it in 1990 with a false step" | `excerpts/fischer1990-intro.txt` and `-thm6-remarks.txt` (Remarks 1–2) | **true, and he was not first**: his introduction says "That the answer to this question would suffice to find the chromatic number of R2 has already been noted by Benda and Perles in [2]" — `[BendaPerles2000]` (the 1976 manuscript, his reference [2] as a preprint). Madore's footnote 5 says the MathSciNet review of Benda–Perles "suggests that the remark above is already contained there". **Benda–Perles is not held and not read** (`BIBLIOGRAPHY.md` row: "not held … not read"); zbMATH's review of it is withheld ("contents unavailable due to conflicting licenses", query Q13 below) |
| Q8 | C4's wording against `plans/STUB-plane-bridge.md` §5 | stub §5 | **equivalent, not verbatim**: the stub says "has a finite real extension `F′`"; C4 says "has a finite extension `F′ ⊂ ℝ`". Same statement; C4 is the version judged here |
| Q9 | "De Bruijn–Erdős in Mathlib: `Finset.rado_selection`, `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`" | `.lake/packages/mathlib/Mathlib/Combinatorics/Compactness.lean:64`; `…/SimpleGraph/Finsubgraph.lean:154` | **both exist at those lines** (grep, no build) |
| Q10 | "Real algebra in Mathlib: `IsRealClosed` (definition only) — no Tarski, no Artin–Lang" | `.lake/packages/mathlib/Mathlib/FieldTheory/IsRealClosed/Basic.lean` exists; `grep -rl "Tarski\|ArtinLang\|realClosure\|quantifier elimination"` over Mathlib | the directory holds one file, `Basic.lean`. The grep's hits are unrelated (`ModelTheory/ElementaryMaps.lean` and `ElementarySubstructures.lean` carry the **Tarski–Vaught** test, `Order/FixedPoints.lean` Knaster–**Tarski**, Presburger arithmetic). Stage 3 prices what is there |
| Q11 | §IQ's "Bochnak–Coste–Roy, *Real Algebraic Geometry*, Thm 4.1.2" (Artin–Lang) | BCR's table of contents (Deutsche Nationalbibliothek scan, `data/m2/j17/bcr-toc.txt`); the book itself is **not held** | **section confirmed, theorem number not**: §4.1 is titled "The Artin-Lang Homomorphism Theorem and the Real Nullstellensatz" (p. 85 ff.); the number 4.1.2 is corroborated only by a search snippet. The statement is read instead in **Goel–Patil–Verma, *Nullstellensätze and Applications*, arXiv:1809.02818v2, Theorem 3.11** (`https://arxiv.org/pdf/1809.02818`; the passage in `data/m2/j17/excerpts/goel-patil-verma-thm3.11.txt`), verbatim: "Let K be a real closed field and let A be a real affine domain over K. Then there exists a K-algebra homomorphism ϕ : A −→ K." — with, there, "an integral domain A is real if and only if its quotient field Q(A) is real", and the proof referred to Lang, *The theory of real places*, Ann. of Math. 57 (1953) 378–391 |

**Two things the quotation check found that the brief did not know.**

1. **The question is posed in print, and the bridge's value asserted there without proof.** `[Soifer2024]` ch. 11 (held; the same
   problem is `[Soifer2009]` Problem 11.1, which Madore's footnote 5 cites), verbatim: *"Open Problem 11.1 Find a countable subset C
   of the set of real numbers R such that the chromatic number χ(C²) is equal to the chromatic number χ(E²) of the plane. The set of
   all algebraic numbers would work, but it would not advance our search for the chromatic number of the plane."* Madore's footnote 5,
   verbatim: *"This answers [Soifer 2009, problem 11.1], but the question is perhaps misstated since the MathSciNet review of [Benda &
   Perles 2000] … suggests that the remark above is already contained there."* So the lineage is: **Benda–Perles (1976 manuscript,
   2000 print; unread) noted it → Fischer 1990 Remark 1 (a false step) → Soifer 2009/2024 (asserted, as a side remark to an open
   problem) → Madore 2015 ¶5.4 (a correct one-sentence proof by Tarski).**
2. **The M2 plan's §2.3 lineage omits Benda–Perles**, whom Fischer himself credits. Prior-art debt: read `[BendaPerles2000]`
   (already an ILL item, the library's notes [4]) for whether they give a proof.

### 1.2 C0 — prior probabilities, before any derivation

| claim | P(TRUE as stated) | the risk I see |
|---|---|---|
| C1 | 0.97 | none mathematical; a statement slip (the norm on `F²`, a real number field) |
| C2 | 0.95 | the choice-dependence of de Bruijn–Erdős (standing assumption here, as in Madore ¶1.3); "sup" attained or not |
| C3 | 0.97 | only that the explicit `E` is shown not purely transcendental over *every* number field, not only over `ℚ` |
| C4 | 0.90 | the ⟹ direction uses `χ(ℝ²) ≤ 7` and that the sup is attained; a vacuous-hypothesis edge case |

**The M2 plan's registered predictions this job scores** (`plans/M2-kernel-lane.md` §4.3, verbatim):
- **P-J17a** — "no printed proof of the bridge is found besides `[Madore2015]` ¶5.4 (and Fischer's flawed Remark 1)" — p = 0.70.
  *Status after stage 1:* **holding on everything read** — Soifer asserts without proof; Zapletal's two papers (held,
  arXiv:2103.02757 and 2201.00275) use the same mechanism (a real closed subfield of `ℝ` is an elementary submodel) for other
  statements and do not state the bridge. **One source can still falsify it and is unread: `[BendaPerles2000]`.** Scored at stage 3.
- **P-J17b** — "the Artin–Lang route's kernel price is judged lower than the Tarski route's" — p = 0.50. Scored at stage 3.

### 1.3 The zbMATH gate J04 could not finish

Re-run 2026-09-25 through `https://api.zbmath.org/v1/document/_search` with `curl -G --data-urlencode`
(`data/m2/j17/zbmath/run_queries.py`; raw JSON beside it; transcript `data/m2/j17/zbmath/queries.out`). A 404 whose body says "No
results found" is recorded as a genuine zero; any other non-200 as a failure (none occurred). **Control:** J04's one answered query
re-run first and reproduced exactly (2 hits, the same two).

| tag | query | hits | what they are |
|---|---|---|---|
| Q0 (control) | `ab:"chromatic number" & ab:"plane" & ab:"algebraic" & ab:"de Bruijn"` | 2 | `1250.05004` *Discrete mathematics* (2010), `0612.05001` *Classic papers in combinatorics* (1987) — books; as J04 recorded |
| Q1 | `ab:"unit distance" & ab:"real closed"` | 0 | — |
| Q2 | `ab:"chromatic number of the plane" & ab:"number field"` | 0 | — |
| Q3 | `ab:"unit distance graph" & ab:"algebraic numbers"` | 0 | — |
| Q4 | `ab:"chromatic number" & ab:"real algebraic" & ab:"plane"` | 1 | `1014.00040`, the Goodman–Pollack Festschrift's contents list (the words sit in different papers' titles) — false positive |
| Q5 | `ab:"chromatic number" & ab:"subfield" & ab:"plane"` | 1 | `1074.05003`, a Kalamazoo 2000 proceedings contents list — false positive |
| Q6 | `ab:"specialization" & ab:"unit distance"` | 0 | — |
| Q7 | `ab:"real place" & ab:"chromatic"` | 0 | — |
| Q8 | `au:"Madore, David"` | 13 | one on the subject: arXiv:1509.07023 (indexed as an arXiv record, no review); also `1479.05123` (Dutour Sikirić–Madore–Moustrou–Vallentin 2021, held as `[DutourSikiricEtAl2021]`); the rest algebraic geometry and cryptography |
| Q9 (real-algebraic-geometry words) | `ab:"real closed" & ab:"chromatic number"` | 0 | — |
| Q10 (extra) | `ab:"Tarski" & ab:"chromatic number"` | 4 | one bears: `0915.03011`, Wang–Kosheleva, *Chromatic-number-type theorems are logically non-trivial*, Geombinatorics (1998): the class of second-order formulas `∀S P(S)` over Tarski's language is undecidable. **Not the bridge and not in conflict with it**: the bridge reduces each colour bound to existential first-order sentences, one per finite graph, which Tarski decides; their class quantifies over arbitrary sets. The others: Erdős's set theory (1997), a 1985 Discrete Math paper on highly symmetric graphs, relation algebras (2002) |
| Q11 (extra) | `ab:"real algebraic numbers" & ab:"unit distance"` | 0 | — |
| Q12 (extra, Fischer's words) | `ab:"chromatic number" & ab:"finitely generated" & ab:"extension"` | 1 | `1421.68162`, *Computing all maps into a sphere* — unrelated |
| Q13 | `an:0951.05037` (Benda–Perles) | 1 | the record exists; **its review text is withheld** ("zbMATH Open Web Interface contents unavailable due to conflicting licenses") — the review Madore's footnote leans on cannot be read here |
| Q14 | Fischer 1990 by title | 1 relevant | `0744.05061` (the `an:` number in the query was a guess and hit an unrelated 1984 paper; the title hit is the right one) |

**Reading of the gate:** every query in the discipline's words (graph colouring × real algebra) returns nothing beyond what is held.
The bridge lives in prose inside papers indexed under other subjects (Madore's is indexed only as an arXiv record, without review). The
negative measures these queries' words (G21); it cannot reach Benda–Perles's text.

### 1.4 Would-have-searched log

- *Stage 1:* none. (Literature queries are not finite-witness search; nothing in C1–C4 invites a solver.)

## Stage 2

*(not started)*
