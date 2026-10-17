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

### 2.3 Verdict: **pending `[KubickiLehelMorayne2002]`** — not found in print among everything read; one 2002 paper unread whose summary points at the core of it

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

**Two leads from the coordinator's web search, checked (2026-10-17):** arXiv:2602.17943 is G. Istrate, C. Zara, *Hypersphere-based restricting
conditions for colorings of the Euclidean space* (20 February 2026) — colourings of `ℝⁿ` under hypersphere forcing conditions, by its abstract;
no bearing on `ℚ⁴`. The University of Haifa record *"On four-colourings of the rational four-space"* is `[Zaks1989]` (Aequationes Math. 37,
June 1989, doi 10.1007/BF01836448), not `[Zaks1999]`; its abstract is the one read in § 2.2. The coordinator's headless fetch of
Kubicki–Lehel–Morayne 2002 failed too (ScienceDirect 403); a browser save is requested, and a short follow-up job reads it.

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

## Stage 3 — SAVED: row 129's plane clause is in print — Li–Su 2026 (found off-brief, during C14's search)

### 3.1 How it was found, and what was read

zbMATH `ab:"independence ratio" & ab:"plane"` (tag `C14`, 4 hits) returned arXiv:2610.15424. **Read in full** (6 pages; fetched from
arXiv 2026-10-17, held as `library/pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf`): S. Li, Y. Su, *Every n points in the
plane contain (m1 + o(1)) n points with no unit distance*, arXiv:2610.15424v1 [math.CO], 11 October 2026. The PDF is dated *"October 10,
2026"*. The coordinator checked the identity from the same PDF (title, both authors, the arXiv stamp, Theorem 1.1, 6 pages).

- **Theorem 1.1**, verbatim: *"lim f (n)/n = m1 . Moreover f (n) ≥ m1 n for every n ≥ 1."* (n → ∞), with `f(n) = min{α(P) : P ⊂ ℝ², |P| = n}`
  and `m₁` the supremum of the upper densities of measurable planar sets with no two points at distance 1 (§ 1; Remark 2.1: the same value
  for discs or squares, real or integer radii). **Corollary 1.2:** `0.22936 n ≤ f(n) ≤ (0.2470 + o(1)) n`.
- They call it *"the first half of a conjecture of Dúcz and Varga"* (abstract), quoting `[DuczVarga2026]` § 2.1's Conjecture 1, and Erdős
  Problem #1070 in Bloom's database.
- **Route** (§§ 3–5): `f(n)/n → α*` with `α* = inf α(P)/|P|` over finite `P ⊂ ℝ²` (Fekete-type, § 3); `α* ≥ m₁` (Larman–Rogers, § 4); and
  `m₁ ≥ α*` (§ 5, *"the new part"*): a random independent subset of the algebraic plane, invariant under algebraic translations and
  rotations, built by *"a single-label version of the transfer in Section 4 of the OpenAI preprint"*, with *"Theorem 5.1 (Haar rigidity [10,
  Thm. 2.3])"* — `[OAIMath2026]` Thm 2.3, the same input as FS-133.
- **Formalized** (§ 6): Lean 4 with Mathlib, on a verbatim copy of `[OAIMath2026]`'s import closure; `f div tendsto m1`, `m1 mul le f`, and
  disc-convention twins; *"#print axioms reports only propext, Classical.choice and Quot.sound"*; repository `github.com/daizisheng/erdos-1070`,
  release v1.0 (not cloned or built here).
- **Not stated there** (my reading, one mind, from the full text): `α₁(𝒜²) = m₁(ℝ²)` as a theorem (the algebraic plane is the proof's
  setting, not a stated result); any fractional chromatic number — the word "fractional" occurs only in a reference title; `[MatolcsiEtAl2025]`
  § 2's equality question; Johnson's 1996 and 2000 questions.

**Inference, one mind, labelled:** `χ_f,0(ℝ²) = 1/m₁(ℝ²)` follows from Li–Su's Theorem 1.1 with `[MatolcsiEtAl2025]` Theorem 2
(`χ_f,0(ℝ²) = 1/α₁(ℝ²)`). The equality with the infinite graph's `χ_f(ℝ²)`, which is what `[MatolcsiEtAl2025]` § 2 asks, needs in addition
`χ_f(ℝ²) ≤ 1/m₁(ℝ²)` (FS-133's C133-CHIF, through periodic approximants C133-PER); no printed source for that step was checked in this job.

**The dates, and only what they show.** Their PDF is dated 10 October 2026 and was posted 11 October 2026. FS-133's derivation of the same
equality is dated 7 October 2026 (`plans/FS133-E1-derivation.md`, commit `7ceb406ef`, C133-ONE and C133-FN), and its kernel proof 14 October
2026 (FS133-LD1). This project learned of Li–Su on 17 October 2026, by this job. Neither work cites the other. **The first clause is credited
to them, as published first.**

### 3.2 Drafts (Keryx files; each names its slot)

1. **`README.md`** § 6 *"Finite graphs and measurable sets have the same density"*, the **"Why it matters"** bullet (l. 224). Replace
   *"It proves the first clause of Dúcz and Varga's Conjecture 1 (2026), and answers the question Matolcsi, Ruzsa, Varga and Zsámboki
   (2025, §2) call open, whether $\chi_f(\mathbb{R}^2) = 1/m_1(\mathbb{R}^2)$; Johnson had posed it earlier (1996; 2000)."* with:
   *"Its first part, $f(n)/n \to m_1(\mathbb{R}^2)$, is the first clause of Dúcz and Varga's Conjecture 1 (2026); Li and Su proved it first in
   print (arXiv:2610.15424, posted 11 October 2026, with a Lean proof), and this library's proof, derived on 7 October and kernel-checked on 14
   October, was found independently of theirs. The fractional part answers the question Matolcsi, Ruzsa, Varga and Zsámboki (2025, §2) call
   open, whether $\chi_f(\mathbb{R}^2) = 1/m_1(\mathbb{R}^2)$; Johnson had posed it earlier (1996; 2000)."* (The sentence after it, on the
   bounds 4.05–4.36, stays.)
2. **`README.md`** § 6, the **"Prior art"** bullet (l. 230). Replace *"For the plane: not found in print (`LEDGER.md` row 129)."* with:
   *"For the plane, $f(n)/n \to m_1(\mathbb{R}^2)$ and $\alpha_1(\mathbb{R}^2) = m_1(\mathbb{R}^2)$ are Li and Su's (arXiv:2610.15424, 2026),
   by the same rigidity theorem of OpenAI's. The algebraic-plane form and the fractional equalities are not stated there; for them, prior art
   not found in print (`LEDGER.md` row 129)."* (The Davies sentence after it stays.)
3. **`RESULTS.md`** § 6 *"The density equality for the plane"*, the **"Whose"** bullet (ll. 151–156). Replace *"For the plane: prior art not
   found in print."* with *"For the plane: `α₁(ℝ²) = m₁(ℝ²)`, as `f(n)/n → m₁(ℝ²)`, is `[LiSu2026]`'s Theorem 1.1 (posted 11 October 2026,
   with a Lean proof over the same `[OAIMath2026]` Thm 2.3), published before this project's kernel proof (14 October; derivation 7 October)
   and found independently of it. `α₁(𝒜²) = m₁(ℝ²)` and the fractional equalities are not stated there (a reading, one mind, FS131-PAS2):
   prior art not found in print."* — and in the same bullet replace *"In the plane, `f(n)/n → m₁(ℝ²)` is the first clause of
   `[DuczVarga2026]`'s Conjecture 1, and"* with *"`f(n)/n → m₁(ℝ²)` is the first clause of `[DuczVarga2026]`'s Conjecture 1, as `[LiSu2026]`
   says; and"*. The last sentence, *"The kernel proof is this project's."*, stays.
4. **`CLAUDE.md`** § The mission, **Publication**, the second *"What clears the bar"* bullet (l. 158). Replace *"with no hypothesis, row 129's
   plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's equality question —
   formalized: in the kernel since FS133-LD1, on the standard three axioms, through `[OAIMath2026]`'s rigidity step, ported; for the plane,
   prior art not found in print (row 129; `plans/FS131-ER1-davies-reading.md` § Stage 7) — `[Davies2026]` Thm 1.1 proves the same equality in
   dimensions four and up —; the kernel proof is this project's."* with: *"with no hypothesis, row 129's plane clause (FS-133) answers
   `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms, through
   `[OAIMath2026]`'s rigidity step, ported; for the fractional equality, prior art not found in print (row 129); its first part, `f(n)/n →
   m₁(ℝ²)` (`[DuczVarga2026]`'s Conjecture 1, first clause), is `[LiSu2026]`'s, published first (11 October 2026) and found independently
   — `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up —; the kernel proof is this project's."*
5. **`CLOSED-QUESTIONS.md`**, the entry *"**`[DuczVarga2026]` Conjecture 1, first clause …**"* (l. 659), after *"…the second clause
   (`m₁ = δ_Croft`) is open."*: insert *"**The first clause is in print:** `[LiSu2026]` Theorem 1.1, *"lim f (n)/n = m1 . Moreover f (n) ≥ m1
   n for every n ≥ 1."* (arXiv:2610.15424, posted 11 October 2026, with a Lean proof over `[OAIMath2026]` Thm 2.3), published before FS-133's
   kernel proof (14 October; its derivation is dated 7 October) and found independently of it; this project learned of it on 17 October
   (FS131-PAS2). The fractional equality and Johnson's questions are not stated there (a reading, one mind)."* And replace *"Not closed until
   FS-133's Lean module passes the gate."*, which FS133-LD1 discharged, with *"Kernel-checked since FS133-LD1 (2026-10-14)."* — if Keryx's
   filing has not already done so.
6. **`LEDGER.md`** row 129, its **Prior art** field. Replace *"the equalities not found (F §3.6, five queries; a gate under
   descriptive-combinatorics names owed; FS-133's gate (fifteen arXiv queries, two web searches, 2026-10-07; zbMATH down): not found; the
   descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4));"* with: *"the plane's clause `α₁(ℝ²) =
   m₁(ℝ²)`, as `f(n)/n → m₁(ℝ²)`, is `[LiSu2026]` Theorem 1.1 (arXiv:2610.15424, PDF dated 10 October 2026, posted 11 October, Lean-formalized
   over `[OAIMath2026]` Thm 2.3), published first; FS-133's derivation (7 October) and kernel proof (14 October) were made without knowledge of
   it, found 17 October by FS131-PAS2 (zbMATH `ab:"independence ratio" & ab:"plane"`) — FS-133's own gate of 7 October (fifteen arXiv queries,
   two web searches, zbMATH down) predates it. `α₁(𝒜²) = m₁(ℝ²)` and the fractional equalities `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)` are not
   stated there (a reading, one mind); `χ_f,0(ℝ²) = 1/m₁(ℝ²)` follows from it with `[MatolcsiEtAl2025]` Thm 2, and the step to `χ_f(ℝ²)` is
   C133-CHIF (an inference, one mind) — for these, not found in print; the descriptive-combinatorics neighbours named, unread
   (`plans/FS133-one-class-transfer.md` § PA.4);"*. In the row's statement cell, *"`f(n)/n → m₁(ℝ²)` — the first clause of `[DuczVarga2026]`
   Conjecture 1 —"* may gain *"(first in print: `[LiSu2026]`)"*; Keryx's call.
7. **`plans/KERNEL-HOLDS.md`** l. 7, the clause *"**the density equality for the plane** (FS-133, FS133-LD1)"*: it claims no novelty, so no
   correction is owed. Optional, for one home per fact: after *"(`[DuczVarga2026]` Conjecture 1, first clause;"* insert *"first proved in print
   by `[LiSu2026]`;"*.
8. **`BIBLIOGRAPHY.md`** § A, a new row: **`[LiSu2026]`** | S. Li, Y. Su, *Every n points in the plane contain (m1 + o(1)) n points with no
   unit distance*, arXiv:2610.15424v1 [math.CO] (11 October 2026; the PDF dated 10 October 2026), 6 pp.; Lean development
   `github.com/daizisheng/erdos-1070`, release v1.0 | **Row 129's plane clause in print, first:** Theorem 1.1, *"lim f (n)/n = m1 . Moreover f
   (n) ≥ m1 n for every n ≥ 1."*, the first clause of `[DuczVarga2026]` Conjecture 1 (Erdős Problem #1070), by a single-label version of
   `[OAIMath2026]` § 4's transfer over its Thm 2.3, formalized in Lean 4 on the standard three axioms (§ 6). Found independently of FS-133
   (derived 7 October, kernel 14 October); found here 17 October (FS131-PAS2). Not stated there: `α₁(𝒜²) = m₁`, any fractional chromatic
   number (a reading, one mind) | `library/pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf` | **read in full** (FS131-PAS2,
   2026-10-17); its Lean repository not cloned. And § B, the library row: *`pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf`
   | `[LiSu2026]` | read in full*.

## Stage 4 — SAVED: C14, the fractional chromatic number of the plane over `ℚ(√3, √11)`

### 4.1 The queries (2026-10-17; tag `C14` in `data/fs131/pas2/queries.jsonl`, 51 queries)

| discipline | queries (hits) |
|---|---|
| authors, complete listings | zb `au:"Cranston, Daniel W."` (95, all titles read); `au:"Rabern, Landon"` (47); `au:"Matolcsi, Máté"` (70); `au:"Varga, Dániel"` (12); `au:"Zsámboki, Pál"` (9); `au:Ducz \| au:Dúcz` (5); `au:"Ambrus, Gergely"` (43); `au:"Ruzsa, Imre Z." & py:2015-2026` (30) — the plane, fraction, independence and lattice titles listed in the log; none on a field plane |
| fractional colouring of distance graphs | zb `ab:"geometric fractional chromatic number"` (4); `ab:"Moser lattice"` (4); `ab:"Moser ring"` (1); `ab:"fractional chromatic number" & ab:"plane"` (14); `… & ab:"unit distance"` (6); `… & ab:"rational"` (7, unrelated); `… & ab:"field"` (4, unrelated); `… & ab:"algebraic"` (8, unrelated); `ab:"independence ratio" & ab:"unit distance"` (2); `ab:"independence ratio" & ab:"plane"` (4 — **Li–Su, § 3 above**); `ab:"Hall ratio" & ab:"plane"` (1); `ab:"Moser spindle" & ab:"fractional"` (1: Jungić 2023, an expository survey, by its DOI and a probe: no "field", no "rational"); `ab:"sqrt{11}" & ab:"chromatic"` (2); `ab:"\sqrt{3},\sqrt{11}"` (5); `ab:"sqrt 3" & ab:"sqrt 11"` (21); `ab:"Cranston" & ab:"Rabern"` (6, all graph theory); ax `abs:"geometric fractional chromatic number"` (4); `abs:"Moser lattice"` (4); `abs:"Moser ring"` (1); `abs:"fractional chromatic number" AND abs:"plane"` (6); `abs:"independence ratio" AND abs:"unit distance"` (2); `abs:"fractional chromatic number" AND abs:"number field"` (0); `… AND abs:"rational points"` (0); `abs:"unit distance" AND abs:"algebraic numbers" AND abs:"fractional"` (0); `abs:"Cranston" AND abs:"Rabern"` (3, unrelated); `abs:"Hall ratio" AND abs:"unit distance"` (1); OpenAlex "fractional chromatic number unit distance graph number field algebraic plane" (210; first 25 read, unrelated) |
| harmonic analysis of distance-avoiding sets | zb `ab:"1-avoiding"` (36, two on unit distances); `ab:"1-avoiding" & ab:"lattice"` (2, unrelated); `ab:"avoiding unit distances"` (1); `ab:"unit distance" & ab:"lattice" & ab:"density"` (2); `ab:"avoiding" & ab:"unit distance" & ab:"rational"` (0); `ab:"independence density" & ab:"Cayley graph"` (0); `ab:"independence ratio" & ab:"Cayley graph" & ab:"amenable"` (0); `ab:"distance-avoiding" & ab:"subgroup"` (0); `ab:"unit distance graph" & ab:"independence number" & ab:"field"` (0) |
| citation graph | works citing `[CranstonRabern2015]`: Semantic Scholar 11, OpenAlex 10 (the same 11 records as on 2026-09-16, plus none); citing `[MatolcsiEtAl2025]`: Semantic Scholar 5 (Li–Su 2026, Dúcz–Varga, Dúcz, Lev–Matolcsi–Pach–Varga 2025 on Kravitz sets, Engel et al. 2024 on beam search), OpenAlex 0; citing `[AmbrusEtAl2023]`: OpenAlex 3 (Hubert et al. 2024, Cohen–Mani 2025, Tolmachev 2025: densities of periodic or typical avoiding sets); citing `[Ducz2026]`, `[DuczVarga2026]`: 0 in OpenAlex. Every title read; none addresses a field plane |

### 4.2 What was read

- **`[Ducz2026]`** (held; **re-read in full, all five pages, 2026-10-17**, against C14 as the brief asks). What it states:
  - abstract: *"In [MRVZ25], Matolcsi et al. show that the fractional chromatic number of the plane is at least 4. Their proof uses a 27-vertex
    unit-distance graph in the Moser lattice, with geometric fractional chromatic number exactly 4. We show that this bound is tight for graphs
    in the Moser lattice by exhibiting geometric 4-colorings of the entire lattice. The same colorings also extend to the entire Moser ring."*;
  - p. 2: *"We extend this coloring to the entire Moser lattice, showing that any graph within this lattice has such a non-fractional geometric
    4-coloring."*; Lemma 2.1 (an integral colouring is geometric iff same-colour depends only on distance) and Lemma 2.2 (its colour classes are
    the cosets of a sublattice);
  - **Theorem 3.1**: `π(v) = 1 + l₁ + 2l₂`, `l₁ = a + b + d`, `l₂ = a + c + d (mod 2)`, *"is a geometric 4-coloring of L_Moser"*; p. 4: both
    colourings *"also generalize to the entire Moser ring R₂"*, `R₂ = {(a + bω₁ + cω₃ + dω₁ω₃)/3ᵏ}` (a remark credited to Varga, no separate
    theorem); **Theorem 3.2**: *"L_Moser has exactly two integral geometric 4-colorings"*;
  - p. 2: the attainment at a finite graph *"is not a logical necessity, and remains to be explained"*.

  **So it states the supremum of the geometric fractional chromatic number over the finite unit-distance graphs in the Moser lattice — and,
  by the remark, in the Moser ring — and that it is 4, attained by `[MatolcsiEtAl2025]`'s `G27`.** It does not state the field's value, the
  fractional chromatic number of any infinite graph, the blow-up, or anything outside the ring. How each relates to C14:
  - *The ring and the field.* With `K = ℚ(√3, √11)`, `L_Moser ⊂ R₂ ⊂ K²`, and `R₂` spans only a four-dimensional `ℚ`-subspace of the
    eight-dimensional `K²` (`ℚ(ω₁, ω₃) = ℚ(√−3, √−11)` inside `K(i)`). The plane over `K` has unit vectors the ring does not (`K(i)`'s
    norm-one group, of infinite rank), so a statement about `R₂`'s graphs is a statement about a subgraph.
  - *Upper bounds.* Dúcz's `χ_gf(G) ≤ 4` for finite `G ⊂ R₂` gives `χ_f(G) ≤ 4` there, weaker than C14's upper half on its domain and
    covering less of it: C14's upper half, `χ_f(K²) ≤ χ(K²) = 4`, is `[Fischer1994]`'s value (Theorem B in the kernel), on all of `K²`.
    Conversely C14's argument gives Dúcz's inequality on the whole field: by `plans/FS56-field-blowup.md` B2, `χ_f(K²) ≥ χ_gf(H)` for every
    finite `H ⊂ K²`, so with `χ_f(K²) ≤ 4`, **every finite unit-distance graph over `K` has `χ_gf ≤ 4`** — Dúcz's bound carried from the
    Moser ring to the field, by a different mechanism (a 4-colouring of `K²` and the field blow-up, not a geometric colouring); not his
    explicit colourings or his uniqueness (Thm 3.2). [derived from FS56-T2 and row 57, one mind (this job); a composition of held results,
    not a new derivation.]
  - *Lower bounds.* Dúcz's statement is an upper bound and gives no lower bound on any `χ_f`. C14's lower half is `[MatolcsiEtAl2025]`
    Theorem 1's blow-up of `G27` read inside `K²` (B1–B2), which neither Dúcz nor MRVZ states.
  - **Verdict on the relation:** Dúcz is a **special case, at the Moser ring and for the geometric parameter, of a corollary of C14's
    argument** — not C14, and not implied by it in his explicit form. The value `χ_gf = 4` "at the Moser ring" is his with MRVZ's `G27`, as
    FS131-PAS1 recorded.
- **`[MatolcsiEtAl2025]`** (held; re-read 2026-10-17: § 1, § 3 Theorem 1 with its proof and Theorem 2's statement and opening, § 4 Definition 1 and Remark 1, Corollary 1 and Conjecture 1).
  Theorem 1's proof takes *"the group K of Euclidean transformations generated by T"* — the congruences between subsets of the graph — and its
  Følner sets; it never says the group preserves a field, and the paper never names `ℚ(√3, √11)` or cites `[CranstonRabern2015]`'s question
  (it cites the paper for the lower-bound history, its reference [5]). Remark 1 records only `[ℚ(ω₁, ω₃) : ℚ] = 4`.
- **`[DuczVarga2026]`** (held; § 2.2 and § 4's opening re-read): *"The entire G27 graph is a subset of L_Moser, and by [6], no graph in this
  lattice can achieve χgf(G) > 4."*; *"Matolcsi et al. also carried out searches not restricted to the lattice … another starting from the
  already constructed graph G27, which failed to improve on the value 4."* Nothing on a field; its `G29` leaves `K` (row 71, FS56-T6).
- `[CranstonRabern2015]`'s question as quoted in § 1.6 was not re-read (held, read 2026-09-08; the quotation is checked verbatim against
  `CLOSED-QUESTIONS.md`, stage 1).

### 4.3 Verdict: **not found in print**; its two halves and its instance at the Moser ring are in print

- **C14 as stated** — `χ_f(G(ℚ(√3,√11)², 1)) = 4`, `[CranstonRabern2015]`'s question — **not found in print** (the searches in § 4.1, adding
  to 2026-09-16's). No citing work of `[CranstonRabern2015]`, `[MatolcsiEtAl2025]`, `[Ducz2026]` or `[DuczVarga2026]` addresses a field plane.
- **In print:** the upper half (`[Fischer1994]`'s `χ(K²) = 4`); the lower half's ingredients (`[MatolcsiEtAl2025]`'s `G27` and Theorem 1),
  of which the field-internal reading is ours; and at the Moser ring, `sup χ_gf = 4` (`[Ducz2026]` Thm 3.1 and its ring remark, with `G27`).
- **Not misstated.** A reader would write `χ_f(ℚ(√3,√11)²) = 4`, as Cranston and Rabern do. The value holds for both of Johnson's
  definitions of `χ_f` of an infinite graph (the upper bound is a 4-colouring, the lower bound passes through finite subgraphs).
- **A generalization the argument already carries** (inventory): every finite unit-distance graph over `K` has `χ_gf ≤ 4`, which extends
  `[Ducz2026]`'s Moser-ring statement to the field (§ 4.2). It is a corollary of held results, at their grade ([hand] B2, [kernel] Theorem B).

### 4.4 Drafts (each names its slot)

1. **`CLOSED-QUESTIONS.md`** § 1.6, after its last sentence (*"…none addresses a field plane."*): *"**Searched again 2026-10-17 (FS131-PAS2):**
   the citers of `[CranstonRabern2015]` (Semantic Scholar 11, OpenAlex 10) and of `[MatolcsiEtAl2025]` (Semantic Scholar 5), the complete
   zbMATH listings of Cranston, Rabern, Matolcsi, Varga, Zsámboki, Dúcz, Ambrus and Ruzsa (since 2015), and 36 title and abstract queries
   in two disciplines: not found in print. **At the Moser ring the instance is in print:** `[Ducz2026]` Thm 3.1 gives geometric 4-colourings
   of the Moser lattice and, by its p. 4 remark, of the Moser ring, so with `G27` the geometric fractional chromatic number of their finite
   graphs has supremum exactly 4. The ring spans half of `K²`'s dimension, and Dúcz states nothing about `χ_f` of an infinite graph or about
   the field. Conversely, this entry's argument carries his bound to the whole field: every finite unit-distance graph over `ℚ(√3,√11)` has
   `χ_gf ≤ 4` (B2 with Theorem B; one mind)."*
2. **`LEDGER.md`** row 71, after *"…`[CranstonRabern2015]`'s first question (`CLOSED-QUESTIONS.md` §1.6);"*: *"prior art: the value not found in
   print (searched 2026-09-16 and 2026-10-17, FS131-PAS2); the upper bound is `[Fischer1994]`'s, the lower bound's graph and blow-up
   `[MatolcsiEtAl2025]`'s, and at the Moser ring `sup χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `G27`;"*.
3. **`BIBLIOGRAPHY.md`**:
   - `[Ducz2026]`, its status cell: append *"; re-read in full 2026-10-17 against C14 (FS131-PAS2): it states the supremum of `χ_gf` over the
     finite graphs of the Moser lattice (and, by a remark, the Moser ring) is 4 — not the field's value, nor any infinite graph's `χ_f`"*.
   - `[MatolcsiEtAl2025]`, its status cell: append *"; §§ 1, 3, 4 re-read 2026-10-17 (FS131-PAS2): Theorem 1's group is never said to
     preserve a field; `ℚ(√3,√11)` and Cranston–Rabern's question are not named"*.
   - `[DuczVarga2026]`: append *"; § 2.2 re-read 2026-10-17 (FS131-PAS2)"*.
   - § C, a listing row: *Jungić, "Still Spinning: The Moser Spindle at Sixty", Math. Mag. (2023), doi 10.1080/0025570X.2023.2176684, Zbl
     1535.05104* | *found by zbMATH `ab:"Moser spindle" & ab:"fractional"` (FS131-PAS2); summary withheld, probed: "spindle" and "fractional
     chromatic number" present, "field" and "rational" absent; not held, not read*.

**C14's novelty line**, for the kernel planner's module and the public pages when it lands: *"`χ_f(ℚ(√3,√11)²) = 4` answers
`[CranstonRabern2015]`'s question; prior art: not found in print (FS131-PAS2, 2026-10-17). The upper bound is Fischer's (1994), the lower
bound's graph and blow-up are Matolcsi, Ruzsa, Varga and Zsámboki's (2025), read inside the field; at the Moser ring the geometric value 4 is
Dúcz's (2026)."*
