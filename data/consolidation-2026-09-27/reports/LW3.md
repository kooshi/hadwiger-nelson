# LW3 — the Geombinatorics archive walk, remaining reads: report to the owner

*Job LW3 of the consolidation and library run, 2026-09-27 (brief `briefs/LW3-archive-walk-debts.md`). Record: `lw/record.md` § Continuation —
LW3 (stages 1, 2, 2b SAVED; this report is stage 3). Verbatim notes for stage 1: `lw/lw3/notes-stage1.md`. Every claim is at one mind (LW3)
unless marked.*

## 1. Bearing on FS-112, FS-111 and FS-104

**The choice.** FS-112 (the unit-arc half) still opens next, unchanged by anything read in this job.

**Alternative weighed.** Re-aim FS-104 (is the plane's measurable chromatic number, null sets of unit pairs ignored, at least six?) or put it
ahead, because this job's reading touched its items (1) and (3) twice. Rejected: what was found gives FS-104 print addresses and locates where
the axiom of choice enters, but proves nothing on its question. Nothing read touches FS-111 (the scale of colour-class junctions).

**Why FS-112 wins.** Soifer's 2003 essay on six-colourings, the one older article LW2 thought might hold a six-map with unit arcs, holds none.
Every six-colouring in it is a tiling by polygons (octagons and squares, or hexagons and triangles) in which five colours avoid distance 1 and a
sixth avoids some distance below 1. There are no unit-radius arcs, no junction-scale bounds and no vanishing holes. So LW2's re-aiming of FS-112
stands as it was.

**Confidence: high** for FS-112 and FS-111 (every flagged six-colouring paper on LW2's older list is now read; the one it named is empty on both).
**Medium** that FS-104 needs no re-aiming: an unread paper that answers Johnson's 1994 question (below) could turn one of FS-104's sub-steps into a
named no-go.

**What bears on FS-104, item by item.**
- **Item (1), the null-set step** (does some measurable colouring proper at almost every unit pair have a "metrical boundary" — a null set of
  two-coloured points — that can be list-coloured from its lists of two or more colours?). Johnson 1994, *The choice number of the plane*
  (Geombinatorics 3(4) 122–128), p. 125, prints the compactness step this reduction uses: *"The well-known DeBruijn-Erdös theorem on the chromatic
  number of an infinite graph holds for the choice number. [...] if c(H) ≤ k for every finite subgraph H of G, then c(G) ≤ k"*, proved by
  Tychonoff's theorem, which uses choice. The same paper asks (p. 124): *"Is the choice number of the planar unit distance graph finite?"* No row
  answers that. If print answers it with "infinite" (I recall an average-degree lower bound for choice numbers that would do so, but have not read
  it), then item (1) cannot close by a general list-colouring theorem; it must use where the lists come from. That matches the existing hunch in
  the FS-103 derivation file (FS103-M-D).
- **Item (3), the audit of which axioms the chain uses.** The set-theory papers ask the question `CLOSED-QUESTIONS.md` §3 already records: is the
  plane's chromatic number the same with full choice as in Solovay's model, where every set is measurable? Soifer 2007 (XVII(2) p. 86) prints:
  *"Chromatic Number of the Plane Theorem. In ZFS the chromatic number of the plane is 5, 6, or 7."* This is Falconer's 1981 bound read in
  Solovay's model, with no proof printed. Since de Grey's 2018 graph, the value with full choice also lies in {5, 6, 7}, so this example of
  axiom dependence no longer separates the two systems. My reading (one mind): link 2 of the aim (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`) uses choice only in the
  de Bruijn–Erdős step. Its measure half, averaging a colouring over random rigid motions, needs only countable additivity. So, given MR,
  whether the plane's number is the same in both systems comes down to the null-set step, done without choice. In Solovay's model every subset
  of a null set is measurable, so there measurability costs nothing and only the choice-free list colouring is at issue.

## 2. Every article read, with its verdict

| article | grade in print | verdict |
|---|---|---|
| `[Soifer2003poly]` XII(4) 191–216 | survey; proofs of classical items; polygonal constructions | no bearing on FS-112 or FS-111; no pre-emption. It prints the Hoffman–Soifer six-colouring corrected (p. 204, squares of diagonal 1 and √2 − 1, not side; I checked by hand that one such square holds no unit pair). It restates the open problems for χa and X₆, and credits Woodall 1973 with a closed six-colouring of type (1,1,1, 1/√3, 1/√3, 1/(2√3)) (p. 200) |
| `[ShelahSoifer2003b]` XIII(1) 41–46 | statements; the proofs are in their JCTA paper | the journal summary of `[ShelahSoifer2003]`: the Conditional Theorem (p. 44; its hypothesis false since 2018); the axiom-dependence question (p. 45); p. 43 asserts, without proof, *"DC is sufficient for Falconer's result"* |
| `[SoiferShelah2004g]` XIII(4) 186–192 | claims; the proofs are in JCTA 105 | graphs G₂, G₃, G₄ on ℝ² (edges: difference in ε + ℚ²), with χ = 2, 3, 4 under choice and no countable colouring in ZF + AC_ℵ₀ + LM. I checked (one line) that they have no countable measurable colouring even when null sets of edges are ignored, because their difference set comes arbitrarily close to 0. The unit circle stays away from 0, which is why rows 128 and 130 can hold for the plane at all |
| `[Delahaye2006]` XV(3) 101–119 | popular exposition (a translation from *Pour la Science*, 2005) | no theorem of its own; relays the Shelah–Soifer question |
| `[Soifer2007]` XVII(2) 85–87 | a statement, no proof | ZFS theorem (above); FS-104 item (3), a print address |
| `[Polymath16wikiProb]` Lemmas 1–40 (and Propositions 35–36, Theorem 20) | wiki lemmas with proofs, some sketches | correlation inequalities for a random colouring that is invariant under rigid motions (finitely additive), each proved by a union bound over a finite configuration. This is the easy direction, `χ_fin ≤ χ_CP`, and a template for FS-104's correlation route. Row 130's hard direction (from a measurable colouring proper almost everywhere to such a random one) is not there, and nothing about row 131's band or holes is either. Theorem 20's proof, a sketch, sorts four-colourings of the triangular lattice with no "1tri" hexagon into seven cases, stripes among them: a neighbouring statement to row 106's stripe lemma, under a weaker hypothesis |
| `[Johnson1994choice]` 3(4) 122–128 (held; flagged while working) | proofs; a posed question | FS-104 item (1): prints its compactness step and poses whether the plane's choice number is finite (§ 1) |

## 3. Theorems this job proved (all [hand], one mind)

- One corrected Hoffman–Soifer square (diagonal 1, half-boundary as printed) contains no two points at distance 1.
- The Soifer–Shelah graphs G₂–G₄ have no countable measurable colouring, even when null sets of edges are allowed to be monochromatic
  (continuity of translation in L¹).
- Where link 2 uses choice (a reading, not a theorem): only in de Bruijn–Erdős. In any model of ZF, restricting a colouring of the plane to its
  finite subgraphs shows the finite-graph value is a lower bound, so without choice the plane's number can only go up.

## 4. Drafts for the owner (none applied)

**`CLOSED-QUESTIONS.md` §3, the entry "Is `χ(ℝ²)` absolute …".**
- Add the two print addresses `[ShelahSoifer2003b]` p. 45 and `[Soifer2007]` p. 86 ("In ZFS the chromatic number of the plane is 5, 6, or 7"),
  and one sentence: "since `[deGrey2018]` both values lie in {5, 6, 7}; link 2's use of choice sits in de Bruijn–Erdős alone (a reading), so
  given MR absoluteness is the null-set step done without choice".
- **New open entry:** `[Johnson1994choice]` p. 124, *"Is the choice number of the planar unit distance graph finite?"*. No row answers it; a
  candidate answer in print is unread (§ 5).

**`LEDGER.md` (drafts).**
- **Row 130's prior-art line:** add "the null-set reduction's compactness step (de Bruijn–Erdős for list colourings, by Tychonoff) is
  `[Johnson1994choice]` p. 125; the union-bound device of the easy direction is `[Polymath16wikiProb]` Lemmas 1–40, for a finitely additive
  invariant random colouring; the hard direction is in neither".
- **Row 106's prior art:** add "`[Polymath16wikiProb]` Theorem 20's proof (a sketch) classifies the four-colourings of ℤ[e^{πi/3}] with no
  '1tri' hexagon, stripes among them — a neighbouring statement under a weaker hypothesis".

**`CLAUDE.md` (drafts).**
- § The aim, link 2: append "; its use of choice is de Bruijn–Erdős alone, the averaging needs ZF + DC (a reading; `[ShelahSoifer2003b]`
  p. 42 names the same step)".
- G81, the ambiguity sentence: "the Soifer–Shelah translate graphs (`[SoiferShelah2004g]`) are ambiguous even modulo null sets of edges, their
  connection set accumulating at 0; the unit circle does not".

**`plans/STUB-cp-plane-six.md` (FS-104), a banner line.** Item (1): "compactness step in print, `[Johnson1994choice]` p. 125; is the plane's
choice number finite (Johnson's p. 124 question)? If infinite, item (1) needs the lists' origin, not choosability". Item (3): "`[Soifer2007]`
p. 86 is the ZFS statement; `[ShelahSoifer2003b]` p. 43 asserts Falconer runs in ZF + DC".

**`BIBLIOGRAPHY.md` outside § G (drafts, rule 0b).**
- § A `[ShelahSoifer2003b]` and `[Soifer2007]`: held now (the § G files) and read in full (LW3); § A `[SoiferShelah2004]`: its journal summary is
  `[SoiferShelah2004g]` in § G.
- § C `[HoffmanSoifer1993]`: the construction is printed corrected in `[Soifer2003poly]` p. 204.
- § A `[Woodall1973]`: `[Soifer2003poly]` p. 200 attributes to it a closed six-colouring of type (1,1,1, 1/√3, 1/√3, 1/(2√3)), in §§1–2, which
  are read for statements only: check it when they are read.
- § C, listing-only rows from `[Soifer2003poly]`'s references: Soifer, *A six-coloring of the plane*, JCTA 61 (1992) 292–294; Hoffman and Soifer,
  *Another six-coloring of the plane*, Discrete Math. 150 (1996) 427–429; Soifer, *An infinite class of 6-colorings of the plane*, Congr. Numer.
  101 (1994) 83–86; Raiskii, Math. Notes 7 (1970) 194–196.

## 5. Debts left

- **Check first (bears on FS-104 item (1)):** whether Johnson's question (is the plane's choice number finite?) is answered in print. The
  candidate is recalled, not read: an average-degree lower bound for choice numbers (Alon), which with the unbounded average degree of finite
  unit-distance graphs would give an infinite choice number.
- **Older, in LW2's order:** the Hoffman–Soifer correction and Brown–Dunfield–Perry II (both in archive issue 11, one fetch; the correction is
  now a low debt); Brown–Dunfield–Perry I (held); Fisher–Ullman 2(1) and Hochberg–O'Donnell 2(4) (the history of row 129); the rational-points
  papers; Kloeckner, Malen and Maier (2015); Soifer, *Relatives I*, 1(4); Chilakamarri 4(4).
- **Newly flagged while cataloguing:** Graham, *Open problems in Euclidean Ramsey theory*, XIII(4) 165–177 (held, flag P); Karabash and Soifer,
  *On Shelah–Soifer class of graphs*, 16(4) 363–366 (the set-theory series; not held).
- **Recent, from LW's list, unchanged:** Sirgedas XXX(3); Soifer 2018 XXVIII(1); Krizan XXVI(4); the maps pair (Soifer XXXVI(1), Xie
  XXXIII(2)); the journal copies of known witnesses; Ellison–Johnson XXIX(2).

## 6. Gates and incidents

- `python3 tools/bib_audit.py`: exit 0 after each edit to `BIBLIOGRAPHY.md` (five runs), read directly, never through a pipe.
- `CATALOGUE.md` and `lw/catalogue.md`: identical (`cmp`) after both edits.
- **One fetch process, five issues** (archive issues 48, 49, 52, 59, 66), exit 0. I checked that no other fetch was running with `ps` on the
  command line, not `pgrep -f`, which would match its own shell.
- **Two catalogue discrepancies, settled on the article pages:** XII(4)'s contents page names "William Paulsen" for pp. 157–166, which are by V.
  Bálint and V. Bálint jr.; XV(3)'s contents page omits Pach–Tóth, pp. 150–154.
- **Budget:** this job stopped stage 2 early, near the brief's 400k guideline, because rendered scans are expensive. Section 5 lists what is left.
- Nothing answer-moving was found, so nothing was sent to the owner early.
- Theorems this job proved: § 3.
