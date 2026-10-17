# FS131-PAS2 — the prior-art searches owed by C7 and C14

*Job FS131-PAS2 (brief `data/fs131/briefs/FS131-PAS2-prior-art.md`, on `main` at `24d9c671d`), Ephodos, 2026-10-17. Worktree
`.claude/worktrees/kcs1`, branch `fs131-pas2`, cut from `main` at `ac47c67b0`. A prior-art gate (`.claude/agents/ephodos.md` § The
opening job, §PA) run on two statements already derived; no derivation of its own. Query scripts and logs: `data/fs131/pas2/`
(`zb.py` and `ax.py` are FS131-PAS1's scripts with the log renamed; every query and every returned record is appended to
`data/fs131/pas2/queries.jsonl`). Papers fetched go to `~/source/library/`; none is committed here.*

## Theorems this phase proved

None. This job searches and reads; it proves nothing.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/pas2/quote_check.py` reads every block quotation of the brief and checks it, character for character, against the
source file it names (a source written `path § section` is checked against the whole file at `path`). Run against `main` (the brief
was committed there after this worktree was cut):

```
OK   data/fs131/REQUEST-2026-10-13.md 'W2: (2026-10-13, answering the choice between the two publishable form'
OK   plans/FS131-close-inventory.md '1073. **The next work, ruled (logged 2026-10-16 23:55 UTC; every landi'
OK   plans/POROS-2026-10-13-number-field-findings.md '**Rank 7 — C7. Rational four-space.** *The theorem:* for `d > 0` with '
OK   CLOSED-QUESTIONS.md '- **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?** `['
OK   plans/POROS-2026-10-13-number-field-findings.md '**Rank 9 — C14.** *The theorem:* the fractional chromatic number of th'
OK   CLOSED-QUESTIONS.md '### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`'
mismatches: 0
```

Control: a copy of the brief with one word of the closed-questions C7 entry changed (`p, q` odd → `p, q` even) prints `MISS` for
that quotation and exits 1; the copy was deleted after the run. All six quotations are verbatim.

The statements behind the quotations, read against their own sources:
1. **C7** against `data/consolidation-2026-09-27/lv/record.md` LV-T3 (the first mind, "[derived, one mind; a second reader owed]")
   and `data/consolidation-2026-09-27/lx/record.md` stage 1 (the blind second mind, LX-T1 to LX-T6) — agrees. The asking lane's form
   ("for `d > 0` with `d² ∈ ℚ`") carries LX's scope repair: as LV first worded it, the corollary was false for `d² ∉ ℚ`
   (`d = 2^{1/4}`: no pair is at that distance, so a colouring exists, yet `d²` is not `p/q`). The grade "[derived, two minds, one
   blind]" is LV with LX's blind derivation; neither is kernel-checked and there is no ledger row.
2. **C14** against `plans/FS56-field-blowup.md` (Theorem, Corollary, B1–B4) — agrees. Its lower bound is `[MatolcsiEtAl2025]`
   Theorem 1's proof read with the field kept (B1–B2: every congruence between subsets of `F²` is an isometry of `F²`), its witness
   their `G27` (re-verified here by `tools/fs56_gf_check.py`), its upper bound Theorem B.
3. **The brief's author list for C7** names Chow "from my memory, unchecked". Checked: `[Chow1993]` is held and read in full
   (`BIBLIOGRAPHY.md`); it classifies distance sets forbidden by **two**-colourings of `ℚ³` and `Aₙ` by the two-index `v₂(d²)`, so it is
   the two-colour analogue of C7, not a four-colour result. Its author is searched below with the others.

### 1.2 The two statements in the field's own words, and the query terms each suggests

**C7 — distances forbidden by four-colourings of rational four-space.** *Euclidean distance graphs (the discipline that posed it):*
for a set `D ⊂ (0, ∞)` write `G(ℚ⁴, D)` for the graph on `ℚ⁴` joining points at a distance in `D`. Benda–Perles (1976, printed
2000) and Chilakamarri (1988) proved `χ(G(ℚ⁴, 1)) = 4`; `[Johnson1990]` Thm 3 gave a four-colouring forbidding every distance in
`K = {√(p/q) : p, q odd positive}`; `[Zaks1999]` proved every proper four-colouring of `G(ℚ⁴, 1)` monochromatic on pairs at `√2`
and at 2 and bichromatic at odd integers. `[Johnson2006]` p. 212 asks: *for which `d > 0` is `χ(G(ℚ⁴, {1, d})) = 4`?* C7's answer:
for `d` realized in `ℚ⁴`, exactly `d ∈ K` — i.e. exactly when the 2-adic valuation of `d²` (Chow's *two-index*) is 0; for every
other realized `d`, `χ(G(ℚ⁴, {1, d})) ≥ 5`. Behind it a uniqueness statement: every proper four-colouring of `G(ℚ⁴, 1)` is, on
each connected component, Johnson's colouring up to a permutation of the colours (forced equal iff `v₂(|x − y|²) ≥ 1`, forced
different iff `= 0`). In the literature's derived vocabulary: it gives the **second Babai number** a lower bound, `B₂(ℚ⁴) ≥ 5`
(`[Johnson2006]` p. 215's definition, from Abrams–Johnson 2001), and it says Johnson's set `K` is the largest set of distances any
proper four-colouring of `ℚ⁴` forbids.
*Quaternion arithmetic (the second discipline):* `ℚ⁴` is the rational quaternions with `|x|² = N(x)`; the component of 0 in
`G(ℚ⁴, 1)` is the subring the norm-one quaternions generate, the Hurwitz order with odd denominators inverted (`R = H ⊗ ℤ₍₂₎`); its
maximal ideal `P = (1 + i)R` has residue field `𝔽₄`; C7 says every proper four-colouring of the Cayley graph `Cay(R, {N = 1})` is the
reduction `R → R/P ≅ 𝔽₄` up to a permutation of `𝔽₄` — a statement about colourings of a Cayley graph of an order in the
quaternion algebra ramified at 2 and ∞.
Query terms: "rational space" / "rational four-space" / "four-dimensional rational space" / `Q^4` with "chromatic" or "coloring";
"forbidden distance(s)" / "forbid" / "forbids" with "rational"; "two forbidden distances"; "distance graph" with "rational points";
"Babai number(s)"; "4-coloring" / "four-coloring" with `Q^4`; "odd distances" / "odd integral distances"; "two-index"; "quaternion"
/ "Hurwitz" / "unit quaternions" with "distance graph" / "chromatic" / "Cayley graph" / "coloring"; "uniquely colorable" with
"rational". The question's own words: "4-coloring of Q^4 which forbids both distances 1 and d". Authors: Zaks, Johnson, Benda,
Perles, Chow, Chilakamarri, Abrams, Lee, Mann, Cibulka, Raigorodskii (and coauthors Ponomarenko, Shitova), Jungreis–Reid–Witte.

**C14 — the fractional chromatic number of the plane over `ℚ(√3, √11)`.** *Fractional graph colouring and geometric graph theory
(the discipline that posed it):* write `G(F², 1)` for the unit-distance graph on `F²`, `F = ℚ(√3, √11)`. `[CranstonRabern2015]`
showed `χ_f(G(F², 1)) ≥ 76/21` and asked its value. C14: `χ_f(G(F², 1)) = 4`; equivalently the finite unit-distance graphs with
coordinates in `F` have independence ratios (Hall ratios' reciprocals) at least `1/4` with infimum `1/4`, and fractional chromatic
numbers below 4 with supremum 4. The upper bound is `χ(G(F², 1)) = 4` (`[Fischer1994]`); the lower is `[MatolcsiEtAl2025]`'s
geometric fractional chromatic number `χ_gf(G27) = 4` blown up along a Følner sequence of the (solvable) group generated by the
congruences of `G27`, which preserves `F²`. Nearby objects in the same words: the **Moser lattice** and the **Moser ring** (inside
`F²`, rank 4 against `F²`'s 8), where `[Ducz2026]` gives geometric four-colourings. *Harmonic analysis of distance-avoiding sets
(the second discipline):* the independence density `α₁` of the unit-distance graph on a dense additive subgroup of the plane (a
`ℚ`-vector space or a lattice); "1-avoiding sets" in a subgroup; the finitary Hall ratio `ρ = 1/α₁`; `m₁`. Query terms:
"fractional chromatic number" with "Q(√3,√11)" / "number field" / "algebraic" / "rational points" / "Moser lattice" / "Moser ring";
"geometric fractional chromatic number"; "independence ratio" with "unit distance" / "lattice"; "Hall ratio" with "plane"; "1-avoiding"
/ "avoiding unit distances" with "lattice" / "rational" / "field"; the question's own words "fractional chromatic number of
Q(√3,√11)". Authors: Cranston, Rabern, Matolcsi, Ruzsa, Varga, Zsámboki, Dúcz, Ambrus (and Csiszárik, Oliveira Filho, Bellitto,
Pêcher, Sédillot, Parts). Citation graphs: works citing `[CranstonRabern2015]`, `[MatolcsiEtAl2025]`, `[Ducz2026]`, `[DuczVarga2026]`.

## Stage 2 — SAVED: C7, distances forbidden by four-colourings of `ℚ⁴`

### 2.1 The queries (zbMATH Open API, arXiv API, OpenAlex, 2026-10-17; tag `C7` in `data/fs131/pas2/queries.jsonl`, 73 queries)

zbMATH prints no total when a query has no hit; those are written (0) below. Semantic Scholar refused all three queries sent to it (HTTP 429, logged); OpenAlex stood in for its citation graph.

| discipline | queries (hits) |
|---|---|
| authors, complete listings | zb `au:"Zaks, Joseph"` (84, all titles read); `au:"Johnson, Peter D."` (194, both pages, all titles read); `au:"Benda, Miroslav"` (15), `au:"Benda, M."` (18); `au:"Perles, Micha A." & (colour words)` (1); `au:"Chow, Timothy Y."` (40); `au:"Chilakamarri, Kiran B."` (26); `au:"Abrams, Aaron" & so:Geombinatorics` (2); `au:"Mann, Matthias"` (6); `au:"Cibulka, Josef"` (32); `au:Tiemeyer` (18); `au:"Noble, Matt"` (24); `au:"Raigorodskii, Andrei M." & rational` (8); `au:"Sokolov, A. A." & rational` (0) |
| Euclidean distance graphs on `ℚⁿ` | zb `ab:"rational four-space"` (0); `ab:"rational 4-space"` (0); `ti:"rational" & ti:"four" & ti:"space"` (21); `ab:"forbid" & ab:"rational" & ab:"distance"` (0); `ab:"forbidden distance" & ab:"rational"` (2); `ab:"forbidden distances" & ab:"rational"` (1); `ab:"two forbidden distances"` (2); `ab:"Babai number"` (2), `ab:"Babai numbers"` (2), `ti:"Babai"` (33); `ab:"rational points" & ab:"four-coloring"` (0), `… & ab:"4-coloring"` (0); `ab:"rational space" & ab:"chromatic"` (8); `ti:"rational space" & ti:"chromatic"` (4); `ti:"rational spaces"` (29); `so:Geombinatorics & py:2006-2015 & rational` (11); `ab:"Q^4" & ab:"chromatic"` (26); `ab:"\mathbb{Q}^4"` (48, all titles read); `ab:"rational four-dimensional"` (2); `ab:"forbids" & ab:"4-coloring"` (2); `ab:"distance graph" & ab:"rational points" & py:2006-2026` (0); `ti:"Patch colorings" \| ti:"rigid colorings"` (2); ax `abs:"rational points" AND abs:"distance graph"` (0); `abs:"Q^4" AND abs:coloring` (30, none on `ℚ⁴`); `abs:"rational space" AND abs:chromatic` (2); `abs:"forbidden distances" AND abs:rational` (1); `abs:"Babai number"` (1); `abs:"four-coloring" AND abs:"rational"` (1); `abs:"4-coloring" AND abs:"rational points"` (0); `au:Noble_M AND abs:rational` (0); OpenAlex search "rational four-space coloring forbidden distance" (796; first 50 read), "distance graphs rational points Q^4 chromatic" (1,238; first 50 read) |
| quaternion arithmetic | zb `ab:quaternion & ab:chromatic` (8, unrelated); `ab:quaternions & ab:"distance graph"` (0); `ab:quaternion & ab:"unit distance"` (0); `ab:"Hurwitz" & ab:coloring` (2, unrelated); `ab:"Hurwitz quaternions" & ab:graph` (0); `ab:"uniquely colorable" & ab:rational` (0); ax `abs:quaternion AND abs:"unit distance"` (0); `abs:quaternions AND abs:"distance graph"` (0); `abs:"Hurwitz" AND abs:coloring AND abs:distance` (0); OpenAlex "quaternions unit distance graph coloring" (228; first 50 read, unrelated) |
| citation graph (OpenAlex) | works citing `[Zaks1989]` (7), `[Johnson1990]` (9), `[Chow1993]` (2), `[BauJohnsonNoble2021]` (3), `[Johnson2010]` (0), Kubicki–Lehel–Morayne 2002 (0); every title read. `[Zaks1999]`, `[Johnson2006]` and the other Geombinatorics papers have no DOI and no citing record in any database tried |
| reviews read through the API | Zaks 1989, 1992 (uniform distances), 1999, 2001, 2005, 2009; Johnson 1990, 2001 (Abrams–Johnson), 2001 (Bohannon et al.), 2003, 2006, 2011, 2018, 2021 (BJN), 2026 (Babai spectra); Cibulka 2008; Raigorodskii–Shitova 2008; Ponomarenko–Raigorodskii 2013, 2015; Sokolov–Raigorodskii 2018; Sokolov 2018, 2023; Noble 2012 (×2), 2016; Johnson–Tiemeyer 2009, Johnson 2008, Johnson–Schneider–Tiemeyer 2007 (no review text) |
| held texts | `[Johnson2010]` (the Birkhäuser volume, held) grepped and read where it touches `ℚ⁴`; `[Soifer2024]` ch. 11 (held) grepped; `[Davies2026]` (held) grepped; Geombinatorics 17(2) (held) — Johnson–Voloshin 2007 found and read; the catalogue of the held issues 25(2)–36(1) grepped (nothing on `ℚ⁴`) |

**Withheld abstract, probed.** zbMATH withholds Kubicki–Lehel–Morayne 2002's summary but indexes it, so a phrase search restricted to the
record (`an:1024.05030 & ab:"…"`) says whether the summary contains the phrase (`data/fs131/pas2/zb_probe.py`, results in
`probes.jsonl`). Controls: a nonsense phrase misses; on Zaks 1989 (whose review is visible) "everywhere dense" hits and "is rigid"
misses. The summary contains: *"Q^4 is rigid"*, *"every 4-coloring of"*, *"uniquely"*, *"uniquely extend"*, *"points at distance one"*,
*"get distinct colors"*, *"patch k-coloring"*, *"open sets"*, *"open subset of"*, *"rational n-space"*, *"Q^2"*, *"Q^3"*, *"implies"*,
*"construct a"*; and not *"unique"*, *"uniquely determined"*, *"dense"*, *"translation"*, *"chromatic number"*, *"forbid"*, *"unit
distance"*, *"component"*, *"permutation"*. A probe shows only which words are there, not what the sentence says.

### 2.2 What was read

- **`[Johnson2010]`** (P. D. Johnson Jr., *Euclidean distance graphs on the rational points*, in *Ramsey Theory: Yesterday, Today, and
  Tomorrow*, Birkhäuser 2011, pp. 163–176; held, the whole volume). Read again for `ℚ⁴`: pp. 168–174 in full, p. 169 from the rendered page.
  **It poses C7's question a second time, after 2006, with C7's answer as its guess** (p. 169): *"The remaining open questions of interest in
  this vein are: If n ≥ 4, for which d > 0 is it the case that χ(ℚⁿ, {1, d}) = χ(ℚⁿ, 1)? We may as well worry only about those d that
  actually occur as distances between points of ℚⁿ! The Jungreis–Reid–Witte answer for n = 1, 2, 3 is: d ∈ √ℚ₀ (if d is a realized
  distance). I think that the same answer holds for n = 4, but this has not been shown. It may be implied by the methods, in [2] and [15], of
  coloring that show that χ(ℚ⁴, 1) = 4, and by the work of Joseph Zaks in [40], where he proves that for every proper 4-coloring of G(ℚ⁴, 1)
  each of the 4 color classes is dense in ℚ⁴."* and *"We leave the resolution of this problem – for which d > 0 realized as a distance
  between points of ℚ⁴ is it the case that χ(ℚ⁴, {1, d}) = 4? – as a puzzle for the pleasure of those interested. The more general question –
  for which n and d > 0 is it the case that χ(ℚⁿ, {1, d}) = χ(ℚⁿ, 1)? – is a bit of a side issue associated with the problem of finding
  B₂(ℚⁿ)."* (`ℚ₀ = {p/q : p, q odd positive integers}`, p. 168.) Its reference list names the 2007–2009 Geombinatorics papers on `ℚ³` and
  `B₁` below; none is said to touch `ℚ⁴` with two distances. p. 172 asks also *"Do there exist d > 0 such that χ(ℚ⁴, d) = 2 or 3?"*, and
  p. 174 relays Johnson–Voloshin's question on periods (next item), adding *"the key to answering the question about G(ℚ⁴, 1) might be found
  in [40]"* (`[Zaks1989]`).
- **Johnson–Voloshin 2007** (P. Johnson, V. Voloshin, *Geombinatorial mixed hypergraph coloring problems*, Geombinatorics 17(2) (October
  2007) 57–67; held in `library/geombinatorics/geombinatorics-v17-n2-2007-10.pdf`, a scan, sheets 6, 9, 10 rendered). Read: pp. 58–59 and
  64–67. p. 64 defines `P(f, A) = {u ∈ A | for all a ∈ A, f(a) = f(u + a)}`, the group of periods of a colouring `f` of an abelian group `A`;
  p. 66, Question 2, verbatim: *"Can a 4-coloring of ℚ⁴ forbidding the distance 1 ([2], [5]) be found with a dense group of periods? Can such
  a 4-coloring be found with P = {0, 0, 0, 0}?"*
- **`[BauJohnsonNoble2021]`** (S. Bau, P. Johnson, M. Noble, *On single-distance graphs on the rational points in Euclidean spaces*, Canad.
  Math. Bull. 64(1) (2021) 13–24; **fetched from Cambridge Core 2026-10-17**, now held as
  `library/pdf/BauJohnsonNoble2021-single-distance-graphs-rational-points-cmb-64-13-24.pdf`). Read: abstract, § 1, Theorem 3.3 with proof,
  § 4 (questions) and the references. **Theorem 3.3** (p. 17): *"Let n ∈ ℤ⁺ with n ≡ 0 (mod 4). For every d realized as a distance between points
  of ℚⁿ, the graphs G(ℚⁿ, d) and G(ℚⁿ, 1) are isomorphic."* — by left multiplication by a rational quaternion of norm `d²`: **the similarity
  step of C7's proof is in print here** (and Perles's ratio-`√2` similarity in `[Zaks1999]` p. 92). With Benda–Perles it answers `[Johnson2010]`
  p. 172's single-distance question for `ℚ⁴` (every realized `d` gives `χ(ℚ⁴, d) = 4`), as § 4 says of `[Johnson2008B1]`'s main result. Nothing
  in it on two distances or on the structure of four-colourings; its § 4 questions are on `ℚ³` and clique numbers.
- **Zaks 1989** (`[Zaks1989]`): the abstract only, from the University of Haifa's research portal (the paper is closed access and not held):
  it settles Johnson's problem *"showing that in every four-colouring of this graph"* every colour class is everywhere dense. Johnson 2006 and
  2011 both cite it and still call C7's question open.
- **Kubicki–Lehel–Morayne 2002** (G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin.
  Theory Ser. B 84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030). **Not read: not held.** Elsevier open archive ("bronze"), but
  ScienceDirect refuses scripted fetches (HTTP 403); no repository copy (the SZTAKI record has none). Known only through the probe in § 2.1 and
  its reference list's first entries (Benda–Perles, de Bruijn–Erdős, Chilakamarri 1991). Cited by `[Zaks1989]`'s citers list only, and by no
  work found. **Its summary says "Q^4 is rigid" beside "every 4-coloring of" and "uniquely extend".**
- Reviews and summaries only (each recorded in the log): **Cibulka 2008** (Geombinatorics 18(2) 53–65: lower bounds for `χ(ℝ⁶)`, `χ(ℚ⁵) ≥ 8`,
  `χ(ℚ⁷) ≥ 15`); **Raigorodskii–Shitova 2008** (Sb. Math. 199: lower bounds for `ℝⁿ`, `ℚⁿ` with two to four forbidden distances, asymptotic in
  `n`); **Ponomarenko–Raigorodskii 2013, 2015** (asymptotic lower bounds for `χ(ℚⁿ)`, one and two forbidden distances); **Sokolov–Raigorodskii
  2018**, **Sokolov 2018** (affine-rational analogues; `χ_aff(ℚⁿ)`); **Sokolov 2023** (distance graphs of rational quadratic forms: clique
  numbers and a rational Beckman–Quarles theorem); **Noble 2012** (`C₂(ℚ³) = 6`, `B₂(ℚ³) ≥ 6`), **Noble 2012** (two-distance graphs in `ℚ²`),
  **Noble 2016** (`χ(ℚ³, √(2s)) = 4` for some `s`); **Zaks 2001, 2005, 2009** (rational Beckman–Quarles theorems: maps preserving distances 1
  and `√2`); **Abrams–Johnson 2001** (the Babai numbers' definition). Titles only, no review text in zbMATH and not held: **Johnson–Schneider–
  Tiemeyer 2007** (`B₁(ℚ³) = 4`), **Johnson 2008** (`4 = B₁(ℚ³) = B₁(ℚ⁴)!`), **Johnson–Tiemeyer 2009** (*Which pairs of distances can be
  forbidden by a 4-coloring of ℚ³?*, Geombinatorics 18(4) 161–170 — zbMATH's title drops the exponent; `[Johnson2010]` [21] prints `ℚ³`, and
  p. 171 gives its main result, `χ(ℚ³, √2ℚ₀ ∪ √ℚᵢ) = 4`).
- `[Soifer2024]` ch. 11 (held, grepped): Benda–Perles's `χ(ℚ⁴) = 4` (Result 11.4) and the `ℚⁿ` lower bounds; no two-distance question, no
  rigidity, no Kubicki–Lehel–Morayne. `[Davies2026]` p. 3 (held): *"χ(Q2) = χ(Q3) = 2 and χ(Q4) = 4 [6,72], so the restriction d ⩾ 5 in our
  rational-point conclusion is necessary"*; nothing on four-colourings' structure.

### 2.3 Verdict: **held** — not found in print among everything read; one 2002 paper unread whose summary points at the core of it

1. **The question is in print, twice, and was open at least until 2011.** `[Johnson2006]` p. 212 (2006) and `[Johnson2010]` p. 169 (2011),
   the second time with C7's answer as the author's guess (*"I think that the same answer holds for n = 4, but this has not been shown"*).
   Johnson coauthored `[BauJohnsonNoble2021]` (submitted 2019) on `ℚⁿ` with one distance and does not return to it. No work found after
   2011 states an answer.
2. **What of C7's proof is in print.** The forced-equal pair at `√2` and at 2 (`[Zaks1999]` Lemmas 1–2); the component of 0 (Benda–Perles
   pp. 122–125); the "if" half (`[Johnson1990]` Thm 3); the quaternion similarity of ratio `d` (`[BauJohnsonNoble2021]` Thm 3.3; Perles's
   ratio-`√2` case in `[Zaks1999]`). What C7 adds is the assembly: every proper four-colouring is, on each component, the residue colouring
   onto `R/P ≅ 𝔽₄` up to relabelling, hence the forced-equal set is exactly `{v₂(N) ≥ 1}` and the answer follows.
3. **The one candidate.** Kubicki–Lehel–Morayne 2002's summary contains "Q^4 is rigid", "every 4-coloring of" and "uniquely extend". If
   it proves that a four-colouring of `ℚ⁴` forbidding distance 1 is determined, on each component, by its values on a few points (a unit
   tetrahedron, say), then step 2's assembly is theirs: uniqueness of extension and the existence of the residue colouring give the
   residue structure at once, and Johnson's question becomes a short corollary of a 2002 theorem that neither Johnson survey cites. If
   "rigid" means something else, C7 stands as "not found in print". **The verdict waits on reading it**; the coordinator has the fetch request
   (SendMessage, 2026-10-17).
4. **Two answers to questions in print, as asides (not C7, nothing new derived).** (a) Johnson–Voloshin 2007's Question 2 (*"Can a
   4-coloring of ℚ⁴ forbidding the distance 1 … be found with a dense group of periods? Can such a 4-coloring be found with P = {0, 0, 0, 0}?"*)
   is answered by `[Zaks1999]` Lemma 1 with the component structure — every proper four-colouring has a dense group of periods, containing
   the subgroup generated by the vectors of length `√2` (`[Zaks1999]` p. 94 says those components are monochromatic and dense), so none has
   `P = {0}` — and LX-T4 adds that the intersection of all of them is exactly `{x : v₂(N(x)) ≥ 1}`. (b) `[Johnson2010]` p. 172's *"Do there
   exist d > 0 such that χ(ℚ⁴, d) = 2 or 3?"* is answered no by `[BauJohnsonNoble2021]` Thm 3.3 with Benda–Perles. Neither answer is ours
   beyond (a)'s exact intersection, which is LX-T4; both wait on Kubicki–Lehel–Morayne like C7.
5. **Not misstated.** C7 as the asking lane words it is Johnson's question as he poses it in 2011 (*"for which d > 0 realized as a distance
   between points of ℚ⁴"*), with the answer in his notation `d ∈ √ℚ₀`.

**Not read:** Kubicki–Lehel–Morayne 2002 (the debt above); Zaks 1989 beyond its abstract; Johnson 2008, Johnson–Tiemeyer 2009, Johnson–
Schneider–Tiemeyer 2007, Noble 2012 (not held; Geombinatorics 16–21 are outside the held run); Raigorodskii–Shitova 2008 and
Ponomarenko–Raigorodskii 2015 beyond their summaries (asymptotic in `n`, by their summaries).

### 2.4 Drafts (Keryx files; each names its slot). Two forms: **(A)** if Kubicki–Lehel–Morayne 2002 does not prove the residue structure; **(B)** if it does.

1. **`CLOSED-QUESTIONS.md`** § 3, the entry *"Which distances can a four-colouring of `ℚ⁴` forbid beside 1?"*, replacing *"nothing after 2006
   searched"* — **(A)**: *"searched after 2006 (FS131-PAS2, 2026-10-17): not found in print. `[Johnson2010]` p. 169 poses it again in 2011
   with this answer as its guess (*"I think that the same answer holds for n = 4, but this has not been shown"*). The similarity step is
   `[BauJohnsonNoble2021]` Thm 3.3."* **(B)**: *"in print in part: every four-colouring of `ℚ⁴` is rigid (Kubicki–Lehel–Morayne 2002, <the
   theorem, quoted>), from which the answer follows with Benda–Perles's components and `[Johnson1990]` Thm 3; neither of Johnson's posings
   (2006, 2011) cites it. Ours: the residue form (`R/P ≅ 𝔽₄`) and the derivation of the forbidden distances."*
2. **`CLOSED-QUESTIONS.md`** § 3, a new line after that entry (both forms): *"**Periods of four-colourings of `ℚ⁴`.** Johnson–Voloshin 2007
   p. 66, Question 2: *"Can a 4-coloring of ℚ⁴ forbidding the distance 1 ([2], [5]) be found with a dense group of periods? Can such a
   4-coloring be found with P = {0, 0, 0, 0}?"* Every one has a dense group of periods, so none has `P = {0}`: it contains the subgroup the
   vectors of length `√2` generate, by `[Zaks1999]` Lemma 1 (p. 94 says those components are monochromatic and dense). The intersection of
   all of them is exactly `{x : v₂(|x|²) ≥ 1}` (LX-T4, [hand], one mind)."*
3. **`LEDGER.md`**: C7 has no row and this job drafts none; a row is the record job's when the kernel lands. Its **Prior art** field, when
   written: form (A) or (B) of draft 1, with the word "searched 2026-10-17 (FS131-PAS2)".
4. **`BIBLIOGRAPHY.md`** (§ C, beside the consolidation run's reference-list rows):
   - `[Johnson2010]` — append to its status cell: *"pp. 168–174 read for `ℚ⁴` (FS131-PAS2, 2026-10-17): p. 169 poses `[Johnson2006]` p. 212's
     question again, with the `√ℚ₀` answer as a guess; p. 172 asks whether `χ(ℚ⁴, d) ∈ {2, 3}` for some `d` (answered no by
     `[BauJohnsonNoble2021]` Thm 3.3); p. 174 relays Johnson–Voloshin's period question."*
   - `[BauJohnsonNoble2021]` — copy *"held: `library/pdf/BauJohnsonNoble2021-single-distance-graphs-rational-points-cmb-64-13-24.pdf` (Cambridge
     Core, 2026-10-17)"*; status *"read: abstract, § 1, Thm 3.3 with proof, § 4, references (FS131-PAS2): Thm 3.3 is C7's similarity step"*; and
     the § C row (l. 768) marked superseded by the § A row.
   - new **`[JohnsonVoloshin2007]`** — *P. Johnson, V. Voloshin, Geombinatorial mixed hypergraph coloring problems, Geombinatorics 17(2)
     (October 2007) 57–67* | *p. 64 defines the period group `P(f, A)`; p. 66 Question 2 asks for a four-colouring of `ℚ⁴` forbidding 1 with a
     dense period group, and with `P = {0}` — answered by `[Zaks1999]` Lemma 1* | *held: `library/geombinatorics/geombinatorics-v17-n2-2007-10.pdf`,
     sheets 5–10* | *pp. 58–59, 64–67 read (FS131-PAS2, 2026-10-17)*.
   - new **`[KubickiLehelMorayne2002]`** — *G. Kubicki, J. Lehel, M. Morayne, Patch colorings and rigid colorings of the rational n-space, J.
     Combin. Theory Ser. B 84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030* | *C7's one unread candidate: its withheld summary
     contains "Q^4 is rigid", "every 4-coloring of", "uniquely extend" (zbMATH phrase probes, FS131-PAS2)* | *not held; Elsevier open archive,
     ScienceDirect refuses scripted fetches* | *not read*.
   - `[Zaks1989]` — status: *"abstract read (University of Haifa research portal, FS131-PAS2): the density theorem, settling a problem of
     Johnson"*.
   - Listing rows (§ C, "searched, title or review only", FS131-PAS2): Cibulka 2008 (Zbl 1190.05067); Raigorodskii–Shitova 2008 (Zbl
     1213.05098); Ponomarenko–Raigorodskii 2013, 2015 (Zbl 1286.05051, 1317.05064); Johnson–Schneider–Tiemeyer 2007 (Zbl 1506.05072); Johnson 2008
     (Zbl 1506.05070); Johnson–Tiemeyer 2009 (Zbl 1506.51003; on `ℚ³`, its exponent dropped by zbMATH's title); Noble 2012 (Zbl 1262.05121) — each
     *"not held; no bearing on `ℚ⁴` with two distances by its review or by `[Johnson2010]`'s account"*.
