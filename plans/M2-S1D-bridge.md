# M2-S1D — the bridge χ(ℝ²) = sup over real number fields of χ(F²), by hand (crunch job J17)

*Record of crunch job **J17** (derivation), milestone M2 (FS-39's hand step, `plans/STUB-plane-bridge.md`). Brief:
`data/crunch-2026-09-25/briefs/J17-M2-bridge-derivation.md` with `STANDING-RULES.md`. Opus 5.5, 2026-09-25. Working files:
`data/m2/j17/`. No Lean written, no build run. Novelty claimed: **none** (standing rule 4; the product is a correct write-up with the
credit right).*

## Theorems this phase proved

*Grades from `CLAUDE.md` § Notation. **None is new mathematics** (standing rule 4): T1–T3 are the bridge, credited to `[Madore2015]`
¶5.4 with ¶1.3 and the classical theorems named; T4–T8 are explicit instances of classical facts, filed so that the record's claim "Fischer's
step is false" carries a proof. Kernel decisions are §3.3's.*

| id | statement (one line) | grade | where | kernel decision |
|---|---|---|---|---|
| J17-T1 | **C1**: every finite unit-distance drawing in `ℝ²` descends to a real number field; injective and induced forms too | [hand], resting on Tarski's quantifier elimination for real closed fields (route T) **or** on the Artin–Lang homomorphism theorem (route AL) | §2.1 | stub (FS-39 phase B2; months) |
| J17-T2 | the real algebraic numbers form a real closed field | [hand], classical | §2.0 (RC) | **kernel candidate** (~1 day; Mathlib's own TODO) |
| J17-T3 | **C2**: `χ(ℝ²) = max` over real number fields of `χ(F²)` (the sup is attained) | [hand] from T1 and de Bruijn–Erdős; `[Madore2015]` ¶5.4's | §2.2 | kernel as a conditional theorem, C1 a named hypothesis (~1 day) |
| J17-T4 | Lemma NP: no nonconstant `a ∈ ℂ(t)` has `a³ − a` a square | [hand]; Mason–Stothers (proof included; Mathlib `Polynomial.abc`) | §2.3 | declined (value low); optional ~½ day |
| J17-T5 | **C3**: `ℚ(π, √(π³ − π))` is not purely transcendental over any number field | [hand] from T4 and Lindemann | §2.3 | declined |
| J17-T6 | C3⁺: that field embeds in no purely transcendental extension of any number field | [hand] from T4 | §2.3 | declined |
| J17-T7 | `ℚ(π/2, √(3 − π²/4))` (a pointless conic) is not purely transcendental over any number field, but lies in `ℚ(√2)(s)` | [hand], elementary | §2.3 | declined |
| J17-T8 | C3′: `χ(ℚ(π, √(π³ − π))²) = 2` | [hand]; an instance of `[Madore2015]` Prop. 3.2 at a degree-one place | §2.3 | declined |
| J17-T9 | **C4**: `χ(ℝ²) ≠ 6` iff every real number field with `χ = 6` has a finite real extension with `χ = 7` | [derived] from T3 and `χ(ℝ²) ≤ 7` (row 33) | §2.4 | kernel as a conditional theorem with T3 (~hours on top) |
| J17-T10 | the equational existential fragment of Tarski (∃T) and Artin–Lang are interderivable in a few lines | [hand], classical | §2.1 | — |

**Verdicts on the fixed claim list:** C1 TRUE · C2 TRUE (and attained) · C3 TRUE (explicit field, genus 1; a genus-0 one besides) · C4 TRUE.

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

## Stage 2 — SAVED

### 2.0 Conventions and the three tools every proof below uses

- For a commutative ring `R`, **`Γ(R²)`** has vertex set `R²` and an edge `p ~ q` iff `(p₁ − q₁)² + (p₂ − q₂)² = 1` (Madore Def. 2.1;
  this repository's `unitQuadrance R`). For a subfield `F ⊆ ℝ` it is exactly the unit-distance graph on `F × F`, and `χ(F²) := χ(Γ(F²))`.
  It depends only on the abstract field `F`, never on an embedding.
- **R_alg** := the real algebraic numbers `{x ∈ ℝ : x algebraic over ℚ}` (Madore's `ℚ^{r−alg}`).
- **(H) Homomorphisms.** A graph homomorphism `G → G′` (not necessarily injective) gives `χ(G) ≤ χ(G′)`: pull a colouring back (Madore
  ¶1.7). A ring homomorphism `ψ : R → R′` into a nonzero ring induces `Γ(R²) → Γ(R′²)` coordinatewise: the edge relation is a polynomial
  identity with integer coefficients, and adjacent images differ because `0 ≠ 1` in `R′` (Madore ¶2.2).
- **(dBE) De Bruijn–Erdős, homomorphism form.** For any graph `G` and `k ∈ ℕ`: `G` is `k`-colourable iff every finite graph `H` admitting a
  homomorphism `H → G` is `k`-colourable (Madore ¶1.3 with ¶1.7; the axiom of choice is assumed throughout, as there; Mathlib:
  `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` with target `⊤ : SimpleGraph (Fin k)`).
- **(RC) R_alg is a real closed field.** *Proof.* It is a subfield of `ℝ` (algebraic numbers form a field), ordered by `ℝ`. If `0 < a ∈ R_alg`,
  `√a ∈ ℝ` is a root of `X² − a`, so algebraic over `R_alg`, hence over `ℚ`, so `√a ∈ R_alg`. An odd-degree polynomial over `R_alg` has a real
  root (intermediate value theorem), algebraic over `R_alg` and so over `ℚ`, hence in `R_alg`. An ordered field in which positives are squares
  and odd-degree polynomials have roots is real closed (the standard characterisation; BCR §1.2 "Real Closed Fields", by section — the book is
  not held). ∎

### 2.1 C1 — every finite unit-distance drawing in ℝ² descends to a real number field

> **C1** — "For every finite graph `H` and every map `f : V(H) → ℝ²` with `‖f(x) − f(y)‖ = 1` on every edge, there is a real number field
> `F` and a map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1` on every edge." (Non-injective `g` allowed.)

**Verdict: TRUE** [hand], by either of two routes, each resting on one cited theorem of real algebra; **and the strengthening holds**: if
`f` is injective, `g` can be taken injective (so a genuine unit-distance *embedding* descends, not only a homomorphic image).

Write `n = |V(H)|` and let `S_H` be the system, in variables `(X_v, Y_v)_{v ∈ V(H)}`, of the equations
`(X_u − X_v)² + (Y_u − Y_v)² − 1 = 0`, one per edge `uv`. It has integer coefficients, and `P := (f(v))_v ∈ ℝ^{2n}` solves it.

**Route T — Tarski, after `[Madore2015]` ¶5.4.**
1. The sentence `φ_H := ∃(X_v, Y_v)_v ⋀_{uv ∈ E(H)} (X_u − X_v)² + (Y_u − Y_v)² = 1` is a first-order sentence of the language of rings with
   no parameters, and `ℝ ⊨ φ_H` (witness `P`).
2. **Tarski:** the theory of real closed fields admits quantifier elimination, so a real closed subfield of `ℝ` is an elementary substructure of
   `ℝ` (`[Zapletal2022]` = arXiv:2201.00275, Fact 4.2 and Corollary 4.3, held and read; they cite Marker, *Model Theory: An Introduction*,
   §3.3, not held; Madore cites Poizat 2000, Thm 6.41, not held). With (RC), `R_alg ≼ ℝ`, so `R_alg ⊨ φ_H`. (Completeness of the theory
   suffices here, since `φ_H` has no parameters; that is what Madore's "decidability" is standing in for, Q6.)
3. A witness `(x_v, y_v)_v ∈ R_alg^{2n}` is finitely many real algebraic numbers, so `F := ℚ(x_v, y_v : v ∈ V(H))` is a number field and
   `F ⊆ ℝ`. Put `g(v) := (x_v, y_v)`; every edge equation holds. ∎
4. *Injective form.* If `f` is injective, add for each pair `u ≠ v` a fresh variable `Z_{uv}` and the equation
   `Z_{uv}·((X_u − X_v)² + (Y_u − Y_v)²) = 1`; `ℝ` still satisfies the enlarged existential sentence, so `R_alg` does. The same trick keeps any
   chosen non-edge at a non-unit distance (`W_{uv}·((X_u − X_v)² + (Y_u − Y_v)² − 1) = 1`), so even the *induced* unit-distance graph of the
   drawing descends.

**Route AL — the Artin–Lang homomorphism theorem (the specialisation route, the one that extends route C).**
1. Let `A := R_alg[f(v)₁, f(v)₂ : v ∈ V(H)] ⊆ ℝ`, the `R_alg`-subalgebra of `ℝ` generated by the `2n` coordinates. It is a finitely
   generated `R_alg`-algebra and an integral domain (a subring of a field); its fraction field lies in `ℝ`, where a sum of squares vanishes only
   if every term does, so `A` is a **real affine domain** over `R_alg` (in `[GoelPatilVerma2022]`'s sense: "an integral domain A is real if and
   only if its quotient field Q(A) is real").
2. **Artin–Lang** (`[GoelPatilVerma2022]` = arXiv:1809.02818v2, Theorem 3.11, read, verbatim: "Let K be a real closed field and let A be a
   real affine domain over K. Then there exists a K-algebra homomorphism ϕ : A −→ K."; proof there referred to Lang, *The theory of real
   places*, Ann. of Math. 57 (1953) 378–391; BCR §4.1 is titled "The Artin-Lang Homomorphism Theorem and the Real Nullstellensatz", its
   theorem numbering not read). With (RC) it gives an `R_alg`-algebra homomorphism `φ : A → R_alg`.
3. Put `g(v) := (φ(f(v)₁), φ(f(v)₂))`. Each edge identity `(f(u)₁ − f(v)₁)² + (f(u)₂ − f(v)₂)² = 1` holds in `A`, and `φ` is a ring
   homomorphism fixing `1`, so it holds for `g` (this is (H) for the ring map `φ`). The finitely many coordinates of `g` generate a number
   field `F ⊆ R_alg ⊆ ℝ`. ∎
4. *Injective form.* `[GoelPatilVerma2022]` Corollary 3.12 (Artin–Lang applied to `A[1/(f₁⋯f_m)]`) gives `φ` with `φ(f_i) ≠ 0` for finitely
   many prescribed nonzero `f_i ∈ A`; take `f_{uv} := (f(u)₁ − f(v)₁)² + (f(u)₂ − f(v)₂)²` for `u ≠ v`.

**Why the base change to `R_alg`, and why this is "route C extended".** Artin–Lang needs a real closed base, and `ℚ[coordinates]` is not
over one; taking the compositum `A = R_alg[…]` *inside* `ℝ` keeps a domain and avoids a tensor product that need not be one. Route C
(FS39-T1; `[Fischer1990]` Thm 6; `[Madore2015]` Prop. 3.2) is the same move — a ring homomorphism into a formally real field preserves the
unit-distance relation — with two differences: it specialises along **one place `t ↦ 0`** and must therefore prove **every** unit vector of the
field integral (so that the whole plane `F(t)²` is coloured); route AL specialises only **the finitely many coordinates of one finite graph**,
needs no integrality at all, and lets (dBE) pay for the rest. The cost moves from "integrality at a place" to "existence of a real point",
which is exactly Artin–Lang's content.

**The two routes are not independent.** BCR's chapter order (§1.4 "The Tarski-Seidenberg Principle" before §4.1) and a search summary of
their chapter 4 indicate that they derive Artin–Lang from Tarski–Seidenberg (not read); Lang's 1953 proof goes through real places instead.
For C1 only the equational existential fragment is used — **(∃T)** "a system of polynomial equations over a real closed `R` with a solution in
a real closed `R′ ⊇ R` has one in `R`" — and (∃T) and Artin–Lang are interderivable in a few lines: (∃T) ⟹ AL: for `A = R[X]/𝔭` a real
affine domain, `Frac A` has an ordering (Artin–Schreier), its real closure `R′` contains `R` as an ordered subfield, the residue classes `X̄`
solve the generators of `𝔭` in `R′`, and (∃T) moves the solution to `R`, i.e. gives `A → R`; AL ⟹ (∃T) (for `R′ ⊆ ℝ`) is route AL above.
Stage 3 prices each against Mathlib.

### 2.2 C2 — the bridge

> **C2** — "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of `F²` meaning that of the unit-distance graph on
> `F × F`."

**Verdict: TRUE** [hand], from C1 and (dBE); the supremum is attained. **Credit: `[Madore2015]` ¶5.4 with ¶1.3** (he proves
`χ(ℝ^d) = χ(R_alg^d)`; the last step to number fields is step 3 below, one line he does not write); first noted by `[BendaPerles2000]` per
`[Fischer1990]`'s introduction (unread); asserted without proof in `[Soifer2024]` ch. 11 (Open Problem 11.1's comment); attempted with a
false step in `[Fischer1990]` Remark 1.

*Proof.* Let `S := sup_F χ(F²) ∈ ℕ ∪ {∞}`, `F` over the number fields contained in `ℝ`.
1. (`S ≤ χ(ℝ²)`) For each `F`, the inclusion `F ↪ ℝ` gives `Γ(F²) → Γ(ℝ²)` by (H), so `χ(F²) ≤ χ(ℝ²)`. And `χ(ℝ²) ≤ 7` (`LEDGER.md`
   row 33, kernel), so every term is at most 7, `S` is finite, and **the supremum is a maximum** (a nonempty set of naturals bounded by 7).
2. (`χ(ℝ²) ≤ S`) Let `k := S`. By (dBE) it suffices that every finite `H` with a homomorphism `f : H → Γ(ℝ²)` is `k`-colourable. Such an `f`
   is a map `V(H) → ℝ²` with unit edges. By C1 there are a number field `F ⊆ ℝ` and `g : V(H) → F²` with unit edges, i.e. a homomorphism
   `H → Γ(F²)`; by (H) `χ(H) ≤ χ(F²) ≤ S = k`.
3. (Madore's form, for the record) The same argument with `R_alg` in place of the number fields gives `χ(ℝ²) = χ(R_alg²)`; and every finite
   subgraph of `Γ(R_alg²)` has its finitely many coordinates in a number field, so `χ(R_alg²) = sup_F χ(F²)` by (dBE) — the one line between
   ¶5.4's statement and C2. ∎

*Remarks.* (a) The proof works verbatim in every dimension `d` (Madore states ¶5.4 for `d`). (b) Only the upper half uses C1; the lower half
is how rungs A and B were always certified (the stub's D1). (c) Attainment gives one number field `F₀ ⊂ ℝ` with `χ(F₀²) = χ(ℝ²)`, and then
every real number field containing `F₀` has the same value — `[Fischer1990]` Remark 2's "maximal" fields, now with a proof. (d) Without choice
the statement is about something else (Madore §7; Shelah–Soifer): (dBE) is the only choice-dependent step.

### 2.3 C3 — Fischer's Remark 1, first sentence

> **C3** — "`[Fischer1990]` Remark 1's first sentence is false: there is a finitely generated field `E ⊂ ℝ` over `ℚ` that is not a purely
> transcendental extension of any finite algebraic extension of `ℚ`." (With an explicit `E`.)

**Verdict: TRUE** [hand; self-contained except the transcendence of `π` (Lindemann) and the Mason–Stothers theorem, whose short proof is
included].

**The explicit field (positive genus, as the brief asks).** `E := ℚ(π, y) ⊂ ℝ` with `y := √(π³ − π)` (real, since `π³ − π > 0`). Any real
transcendental `x > 1` in place of `π` works — e.g. `x = 2 + L`, `L` Liouville's number, whose transcendence Mathlib holds
(`Liouville.transcendental`), whereas `π`'s it does not (M2 plan §2.2). `E` is the function field of the elliptic curve `Y² = X³ − X`
(genus 1), via `X ↦ π`, `Y ↦ y`.

**Lemma NP (no rational parametrisation).** There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in `ℂ(t)`.

*Proof.* Suppose `b² = a³ − a` with `a` nonconstant. Write `a = p/q`, `p, q ∈ ℂ[t]` coprime, `q ≠ 0`, and `b = c/e`, `c, e` coprime. Then
`c²q³ = e²·p(p − q)(p + q)`. The four polynomials `p, q, p − q, p + q` are pairwise coprime (characteristic 0). So `q³ | e²` (as `q` is coprime
to `p(p−q)(p+q)`) and `e² | q³` (as `e` is coprime to `c`): `e² = λq³`, `λ ∈ ℂˣ`, and then `c² = λ·p(p − q)(p + q)`. Comparing valuations at
each prime of `ℂ[t]`, every one of `q, p, p − q, p + q` has only even valuations, so each is a unit times a square, hence a square in `ℂ[t]`:
`p = α², q = β², p − q = γ², p + q = δ²`. Then
`α⁴ = β⁴ + (γδ)²`, with `β⁴, (γδ)², α⁴` pairwise coprime and not all constant (`a` nonconstant forces `α` or `β` nonconstant). Put
`D := max(deg α, deg β) ≥ 1`; then `deg γ + deg δ = (deg(p − q) + deg(p + q))/2 ≤ 2D`. **Mason–Stothers** gives
`max(deg β⁴, deg (γδ)², deg α⁴) ≤ n₀(α⁴β⁴γ²δ²) − 1`, where `n₀` counts distinct roots; the left side is `4D`, the right at most
`deg α + deg β + deg γ + deg δ − 1 ≤ 4D − 1`. Contradiction. ∎

*Mason–Stothers, with Snyder's proof* (`A + B = C` in `K[t]`, `char K = 0`, pairwise coprime, not all constant ⟹ `max deg ≤ n₀(ABC) − 1`).
The Wronskian `W := AB′ − A′B = AC′ − A′C` is nonzero (else `A/B` is constant, forcing all three constant by coprimality). Each of
`gcd(A, A′)`, `gcd(B, B′)`, `gcd(C, C′)` divides `W` (the third by the second expression), they are pairwise coprime, and
`deg gcd(A, A′) ≥ deg A − n₀(A)`. So `deg A + deg B + deg C − n₀(ABC) ≤ deg W ≤ deg A + deg B − 1`, i.e. `deg C ≤ n₀(ABC) − 1`; by symmetry
(`B + (−C) = −A`, etc.) the same for `A` and `B`. ∎ (Stothers 1981, Mason 1984; this proof N. Snyder, *Elem. Math.* 55 (2000) 93–94 —
reference from memory, not re-read; the proof is given in full above, so nothing rests on the citation.)

*Proof of C3.* `E` is generated over `ℚ` by two elements. Suppose `E = F(T)` with `F ⊆ E` finite over `ℚ` and `T` algebraically independent
over `F`. Since `F/ℚ` is algebraic, `|T| = trdeg_F E = trdeg_ℚ E = 1` (`π` is transcendental, `y` algebraic over `ℚ(π)`), so `E = F(t)`.
Then `π = a(t)` and `y = b(t)` for some `a, b ∈ F(t) ⊆ ℂ(t)` with `b² = a³ − a`, and `a` is nonconstant because `π ∉ F`. Lemma NP forbids
this. ∎

**C3⁺ (the stronger fact behind the brief's "positive genus").** `E` embeds in **no** purely transcendental extension `F′(t₁, …, t_m)` of any
number field `F′` [hand]: an embedding would give `a, b ∈ F′(t₁, …, t_m)` with `b² = a³ − a`, `a` nonconstant; restricting to a line
`t_i = c_i + d_i s` (rational `c, d` chosen off the finitely many hypersurfaces where a denominator vanishes identically or `a` becomes constant
along it) gives nonconstant `a(s)`, `b(s) ∈ ℂ(s)`, against Lemma NP. **This is why positive genus matters**: Fischer's own Theorem 6 reaches
any `E` that sits inside some `F′(T)` (a finite real extension made purely transcendental), and C3⁺ says no such `F′` exists here — so no
repair of Remark 1 by Fischer's tools alone reaches this `E`.

**A genus-0 counterexample too, more elementary** [hand]. `E₀ := ℚ(x, √(3 − x²))` with `x = π/2` (so `3 − x² > 0`). Its constant field (the
algebraic closure of `ℚ` in `E₀`) is `ℚ`: an algebraic `θ ∈ E₀` of degree `m ≥ 2` would give `[ℚ(θ, x) : ℚ(x)] = m ≤ 2`, so
`E₀ = ℚ(θ)(x)` and `3 − x²` would be a square in `ℚ(θ)(x)` — impossible, `3 − x²` being squarefree of degree 2. So if `E₀ = F(T)` then
`F ⊆ ℚ`, `E₀ = ℚ(t)`, and `x = p(t)`, `√(3 − x²) = q(t)` with `p² + q² = 3` in `ℚ(t)`; evaluating at a rational `t₀` off the poles gives
rationals with `p(t₀)² + q(t₀)² = 3`, impossible since `3` is not a sum of two rational squares (the 3-adic valuation / sum-of-two-squares
criterion). ∎ **But `E₀` does not defeat Fischer's method**: `E₀ ⊆ ℚ(√2)(s)` (the conic has the point `(1, √2)`, so it is rational over
`ℚ(√2)`), and Theorem 6 then gives `χ(E₀²) ≤ χ(ℚ(√2)²) = 2`. Hence the brief's insistence on positive genus is right, and the stub's and
G63's parenthetical "(a function field of positive genus)" names the *robust* counterexample, not the only one.

**C3′ — the conclusion survives where the premise dies, on this `E`** [hand; an instance of `[Madore2015]` Prop. 3.2]. `χ(E²) = 2`. The
curve `Y² = X³ − X` is smooth at the rational point `(0, 0)` (`∂/∂X = −1 ≠ 0`), so its local ring there is a discrete valuation ring
`O ⊂ E` with residue map `ρ : O → ℚ`, `ρ(π) = ρ(y) = 0`. Every unit vector `(u, v) ∈ E²` lies in `O²`: otherwise, with `v_O(u) ≤ v_O(v)` and
`v_O(u) < 0`, `w := v/u ∈ O` and `u⁻² = 1 + w²` with `u⁻¹` in the maximal ideal, so `ρ(w)² = −1` in `ℚ`. So reduction by `ρ` on `O²` plus a
section of `E²/O²` colours `E²` from any colouring of `ℚ²` (Madore Prop. 3.2, the repository's `cosetResidue`), and `χ(ℚ²) = 2` (Woodall).
**So on `E` Fischer's second sentence ("`E^d` can be `k`-colored iff `F^d` can") holds with `F = ℚ`, the constant field, although his first
sentence is false there.** Whether it holds for **every** finitely generated `E ⊂ ℝ` with `F` its constant field is surfaced below, not claimed.

### 2.4 C4 — the exact form of "χ(ℝ²) ≠ 6"

> **C4** — "`χ(ℝ²) ≠ 6` if and only if every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`"
> (`plans/STUB-plane-bridge.md` §5, FS62-T2), given C2.

**Verdict: TRUE** [derived: from C2 with its attainment, and `χ(ℝ²) ≤ 7`, `LEDGER.md` row 33]. FS62-T2's proof is correct; written here with
the one input it leaves implicit (attainment).

*Proof.* (⟸) Suppose `χ(ℝ²) = 6`. By C2 the supremum is attained: some real number field `F` has `χ(F²) = 6`. Every finite extension
`F′ ⊂ ℝ` of it has `χ(F′²) ≤ χ(ℝ²) = 6 < 7` (§2.2 step 1). So the right side fails. (⟹) Suppose `χ(ℝ²) ≠ 6` and `χ(F²) = 6` for a real
number field `F`. Then `6 ≤ χ(ℝ²) ≤ 7`, so `χ(ℝ²) = 7`, and C2's attainment gives a real number field `E` with `χ(E²) = 7`. The compositum
`F′ := FE ⊂ ℝ` is finite over `F`, and `7 = χ(E²) ≤ χ(F′²) ≤ χ(ℝ²) = 7`. ∎ If no real number field has `χ(F²) = 6`, the right side holds
vacuously and (⟸) shows `χ(ℝ²) ≠ 6` — consistent, and it is `G64`'s S ⟹ W for number fields.

*What it is:* a restatement of Hadwiger–Nelson's top rung ("six is never where the climb stops"), not a reduction of it (FS62-T2, G64 —
agreed).

### 2.5 Surfaced, not claimed (for the close's conjecture sweep)

- **Q-const.** For a finitely generated `E ⊂ ℝ` with constant field `F` (the algebraic closure of `ℚ` in `E`), is `χ(E²) = χ(F²)`?
  `χ(F²) ≤ χ(E²)` always; `≤ χ(K²)` for the residue field `K` of every place of `E` whose residue field has `−1` a non-square (Madore
  Prop. 3.2); so equality holds whenever `E/F` has such a place of degree one — e.g. `E = F(C)` with `C` having a smooth `F`-point (C3′), or
  `E` purely transcendental (FS39-T1). A counterexample needs a curve with no such `F`-point all of whose real points lie over fields `K` with
  `χ(K²) > χ(F²)`, and a finite graph in `E²` that needs the extra colours. G63's headline "the chromatic number of a field plane is arithmetic
  only: transcendence is free" is proved only for **purely** transcendental extensions; Q-const is its general form. Bearing on χ ≥ 6: none.
  Recommendation: record as a question in G63; mint no stub.

### 2.6 Would-have-searched log (stage 2)

- A solver check that a specific finite graph (e.g. a rotated Moser spindle with a transcendental rotation) has an algebraic drawing — not
  needed: C1 is a theorem, and no instance was asked. Instead: nothing.
- Hunting a counterexample to Q-const by trying curves — **out** (try-cases-until-one-works); recorded as a question instead.

## Stage 3 — SAVED

### 3.1 What Mathlib holds, by file (the pinned Mathlib, `.lake/packages/mathlib`, read with `grep`; no build)

| need | held (file) | missing (query) |
|---|---|---|
| real closed fields | `class IsRealClosed` and elementary lemmas (`FieldTheory/IsRealClosed/Basic.lean`, 127 lines); its TODO: "real numbers, real algebraic numbers, hyperreals form a real closed field" | **no instance at all, not even `IsRealClosed ℝ`** (`grep -rl IsRealClosed`: that one file) |
| the real algebraic numbers | `algebraicClosure F E : IntermediateField F E` (`FieldTheory/AlgebraicClosure.lean:40`); IVT (`intermediate_value_Icc`) and polynomial sign at the ends (`Analysis/Polynomial/Order.lean`) | the (RC) instance |
| orderings | `RingPreordering`, `RingOrdering`, supports (`Algebra/Order/Ring/Ordering/Defs.lean`, `Basic.lean`, after Lam 1984); `IsSemireal`, `IsFormallyReal` | **existence of an ordering on a formally real field** (Artin–Schreier; no Zorn extension of preorderings) |
| real closure | — | `grep -rl "realClosure\|RealClosure"`: 0 |
| Tarski | ModelTheory: syntax, semantics, `ElementarySubstructure`, `Theory.IsComplete`, the ring language, `ACF_isComplete` and Lefschetz (`ModelTheory/Algebra/Field/IsAlgClosed.lean`, **by categoricity**, a method that cannot transfer: no theory of real closed fields is categorical in any infinite cardinality); `IsQF` (`ModelTheory/Complexity.lean`) | a theory `RCF`, quantifier elimination, any QE test; Sturm sequences (only Descartes's rule, `Algebra/Polynomial/RuleOfSigns.lean`) |
| Artin–Lang, real places | valuation subrings, Chevalley's extension (`RingTheory/Valuation/LocalSubring.lean:118`, `LocalSubring.exists_le_valuationSubring`) | Artin–Lang; real places; Baer–Krull |
| de Bruijn–Erdős | `Finset.rado_selection` (`Combinatorics/Compactness.lean:64`), `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (`Combinatorics/SimpleGraph/Finsubgraph.lean:154`) | — |
| C3's inputs | `Polynomial.abc` = Mason–Stothers (`NumberTheory/FLT/MasonStothers.lean:55`); `Liouville.transcendental`; `Algebra.trdeg`, transcendence-basis cardinality (`RingTheory/AlgebraicIndependent/`) | π's transcendence (M2 plan §2.2) — use `2 + L` |

### 3.2 The price of each route

| piece | route T | route AL | price |
|---|---|---|---|
| (RC): `IsRealClosed` for `algebraicClosure ℚ ℝ` (and for `ℝ`) | ✓ | ✓ | **~1 day**; a Mathlib TODO, upstreamable |
| (∃T) for `R_alg ⊆ ℝ`: an equation system over `R_alg` solvable in `ℝ` is solvable in `R_alg` | ✓ (the whole content) | ✓ (inside AL's textbook proof) | **months**: needs a parametric one-variable elimination (Sturm, Thom or Cohen–Hörmander) and either full QE in ModelTheory or a direct projection theorem. Reference point: Cohen–Mahboubi's Coq formalisation of QE for real closed fields (*Logical Methods in Computer Science*, 2012) — from memory, not read |
| Artin–Schreier: a formally real field has an ordering | — | ✓ | ~2 days (Zorn over the held `RingPreordering`) |
| real closure of an ordered field (existence) | — (not needed if (∃T) is proved directly) | ✓ (the textbook proof embeds `Frac A` in one) | weeks |
| Artin–Lang itself | — | ✓ | = (∃T) + the two rows above + glue (J17-T10); Lang's place-theoretic proof instead needs real places and Baer–Krull, absent — no cheaper |
| de Bruijn–Erdős assembly; C2, C4 from C1 | ✓ | ✓ | ~1 day |

**Ranking: route T is the cheaper, and neither is cheap.** Artin–Lang is not an independent foundation: every proof known to me passes through
a Sturm-type root count or through Tarski, and its textbook proof is (∃T) plus orderings and real closures. Route AL's advantage is not price
but vocabulary: it is a ring homomorphism, the same move as route C and Theorem A. **The FS-39 stub's price for phase B ("one to two days,
Mathlib-dependent") is wrong by an order of magnitude**; the M2 plan's "weeks" (§2.2) is still low.

**What the kernel can have now, honestly:**
1. **B0 — (RC)**, `IsRealClosed ℝ` and `IsRealClosed (algebraicClosure ℚ ℝ)`: ~1 day, upstreamable, needed by every route.
2. **B1 — the bridge as a conditional theorem**: `chromaticNumber_plane_eq_iSup_numberField_of_descent (h : RealAlgebraicDescent) : …` with
   `RealAlgebraicDescent` the statement of C1 (or of (∃T) for `R_alg ⊆ ℝ`) as a `Prop`, the hypothesis `VACUITY DECLARED` with the reason
   "true by Tarski; Mathlib lacks Tarski", plus C4 (FS62-T2) on top; ~1 day. It gives every "`χ(ℝ²) = …`" sentence a kernel statement with
   exactly one named hypothesis, which is FS-39 stub D3's intent without a `sorry`.
3. **B2 — (∃T) in the kernel**: months; defer, do not stub a date.

### 3.3 The registered predictions, scored

| id | prediction | p | outcome |
|---|---|---|---|
| P-J17a | "no printed proof of the bridge is found besides `[Madore2015]` ¶5.4 (and Fischer's flawed Remark 1)" | 0.70 | **held on everything readable** — Soifer asserts without proof (Open Problem 11.1's comment); Zapletal's two papers use the mechanism for other statements; the zbMATH gate found nothing. **Not scorable at one source:** `[BendaPerles2000]`, which Fischer credits with noting the reduction and whose zbMATH review is withheld. Scored *held, conditional* |
| P-J17b | "the Artin–Lang route's kernel price is judged lower than the Tarski route's" | 0.50 | **FALSE** (judged): AL's textbook proof contains (∃T); §3.2. Confidence medium — it would change if a proof of Artin–Lang from valuation theory alone (Chevalley extension, which Mathlib holds) were found; none is known to me |
| C0 (§1.2) | C1 0.97, C2 0.95, C3 0.97, C4 0.90 | — | all four TRUE; the one risk that bit was none — C4's attainment, which FS62-T2 left implicit, is supplied by C2's boundedness |

### 3.4 Proposed edits (standing rule 7: the front-page lane writes them; proposed here only)

**`CLAUDE.md` G63.**
- Title: "The chromatic number of a field plane is arithmetic only: transcendence is free" → "…: **pure** transcendence is free".
- The sentence "The remaining gap is a different one: descending an arbitrary finitely generated `F ⊆ ℝ` needs a place whose residue field stays
  formally real (real places, Artin–Lang), where the model-theoretic route needs Tarski–Seidenberg, which Mathlib does not hold. Price both
  before committing." → "**Priced (J17, `plans/M2-S1D-bridge.md` §3):** both routes need the existential fragment of Tarski — Artin–Lang's
  textbook proof is that fragment plus orderings and real closures — so the model-theoretic route is the cheaper, and both are months; the
  kernel can have the bridge now only as a conditional theorem with the descent as its one named hypothesis."
- In the prior-art paragraph, "which is false in general (a function field of positive genus), and then invokes de Bruijn–Erdős. So the
  statement χ(ℝ²) = sup over number fields has been in print since 1990 with a flawed step; what is left to us is the repair (real places, or
  Tarski–Seidenberg) and the kernel form." → "which is false in general — `ℚ(π, √(π³ − π))` (genus 1, inside no purely transcendental extension
  of any number field) and `ℚ(π/2, √(3 − π²/4))` (a conic with no rational point) are counterexamples (J17-T5–T7) — and then invokes de
  Bruijn–Erdős. **The bridge is proved correctly in `[Madore2015]` ¶5.4 with ¶1.3, by Tarski**; it was first noted by `[BendaPerles2000]`
  (credited in Fischer's introduction; unread) and asserted without proof in `[Soifer2024]` ch. 11 (Open Problem 11.1's comment); written in
  full, by Tarski and by Artin–Lang, in `plans/M2-S1D-bridge.md` §2. Nothing of it is ours but the write-up."
- Add, before the *Do*: "**Open (J17 §2.5, Q-const):** for a finitely generated `E ⊂ ℝ` with constant field `F`, is `χ(E²) = χ(F²)`? True
  when `E/F` has a place of degree one with formally real residue field (pure transcendence; a curve with a smooth `F`-point, J17-T8); open
  otherwise."
- G56's "FS-39's bridge, which is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős" is correct as it stands.

**`plans/STUB-plane-bridge.md` (FS-39).**
- §3 D4's prior-art paragraph: "So (ii) has been *stated* in print since 1990 and never correctly *proved* there; this stub's product is the
  repair — real places, or Tarski–Seidenberg — and the kernel form." → "(ii) was noted by Benda–Perles (1976 manuscript), stated with a false
  step by Fischer (1990), asserted by Soifer (2009, Open Problem 11.1's comment) and **proved correctly by Madore (2015, ¶5.4 with ¶1.3, by
  Tarski)**; the repair is written in full in `plans/M2-S1D-bridge.md`. This stub's remaining product is the kernel form."
- §3a: "owed, never run" → "run: J04 (one zbMATH query) and J17 (fifteen; `plans/M2-S1D-bridge.md` §1.3): nothing beyond `[Madore2015]`,
  `[Fischer1990]`, `[Soifer2024]` ch. 11 and the unread `[BendaPerles2000]`."
- §4: phase B "one to two days, Mathlib-dependent" → split into **B0** (RC instances, ~1 day), **B1** (the conditional bridge and C4, ~1
  day), **B2** ((∃T) in the kernel, months, deferred); phase C becomes B1's corollaries.
- §5: add after the displayed corollary "(both directions use that the supremum is attained, which holds because every value is at most 7)".

**`plans/M2-kernel-lane.md` §2.3** (the lane's own record; J04's or the owner's to edit): the lineage omits `[BendaPerles2000]`, whom Fischer's
introduction credits; and "the bridge is `[Madore2015]` ¶5.4" was already in `BIBLIOGRAPHY.md` (FS-53, 2026-09-15) — a re-finding.

**`BIBLIOGRAPHY.md`.**
- New: `[GoelPatilVerma2022]` K. Goel, D. P. Patil, J. Verma, *Nullstellensätze and Applications*, arXiv:1809.02818v2 (2022) — Thm 3.11
  (Artin–Lang) and Cor. 3.12 read; route AL's citation. `[Lang1953]` S. Lang, *The theory of real places*, Ann. of Math. 57 (1953) 378–391 —
  not held, cited through GPV. `[BCR1998]` Bochnak–Coste–Roy, *Real Algebraic Geometry* — not held; table of contents read (§4.1 "The
  Artin-Lang Homomorphism Theorem and the Real Nullstellensatz"; the number 4.1.2 unverified). `[Marker2002]` and `[Poizat2000]` — not held;
  cited through Zapletal and Madore for Tarski. `[WangKosheleva1998]` *Chromatic-number-type theorems are logically non-trivial*,
  Geombinatorics (Zbl 0915.03011) — review read; adjacent (undecidability of second-order colour statements; no conflict with the bridge).
  `[CohenMahboubi2012]` — the Coq QE-for-RCF pricing reference, not read.
- `[Madore2015]`: add "¶5.4 re-read 2026-09-25 (J17): the step from `ℚ^{r−alg}` to number fields is not written (one line); 'decidability'
  stands for completeness; footnote 5 cites Soifer's Problem 11.1 and Benda–Perles."
- `[Soifer2024]`: add ch. 11's Open Problem 11.1 verbatim and its comment "The set of all algebraic numbers would work" (asserted, not proved).
- `[BendaPerles2000]`: add that `[Fischer1990]`'s introduction credits them with noting that finite algebraic extensions suffice for `χ(ℝ²)`,
  and that zbMATH's review is withheld ("contents unavailable due to conflicting licenses").
- `[Zapletal2022]` (arXiv:2201.00275, held): add "Fact 4.2 and Cor. 4.3 (a real closed subfield of `ℝ` is an elementary submodel) are route T's
  citation for Tarski in `plans/M2-S1D-bridge.md`".

**`CLOSED-QUESTIONS.md`: no row.** Soifer's Open Problem 11.1 is posed in print, but its answer (the algebraic numbers; and, by attainment, a
single unnamed number field) is Madore's and Soifer's own, not ours.

**`plans/FS62-derivation.md` FS62-T2:** add "the proof uses that the supremum is attained (all values ≤ 7)" — `J17-T9` supplies it.

### 3.5 Would-have-searched log (stage 3)

- None. Pricing was by reading Mathlib's files with `grep`; no build, no solver.
