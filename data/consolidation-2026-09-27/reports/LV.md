# Job LV — a second reading of job LP's attribution moves: report to the owner

*Job LV of the consolidation and library run, 2026-09-27 (de Bruijn, Opus 5.5). Record: `data/consolidation-2026-09-27/lv/record.md` (stages 1–4,
all SAVED; commits 6d585bd8, 42aada3b, 8222dce1, 89c34d51, 7af3345f and this one). Every source page was read from the held scans before LP's
words on it. None of this moves the answer; it changes what the project calls its own.*

## Verdicts

| item | verdict | in one line |
|---|---|---|
| **P1 — Theorem A** | **agree, with two differences** | The construction is `[Fischer1990]` Thm 1(i) (p. 183) and `[Johnson2006]` p. 213, as LP said. (a) Its first printed instances are older: `[BendaPerles2000]` (typed 1976) two-colours `ℚ²` and `ℚ³` by colouring the unit-vector group and copying it to the cosets (pp. 120–121). (b) What LP left "ours" (the metric-free, arbitrary-group statement) is **"not found in print"**, not established. `[Johnson1982]` *Coloring Abelian groups* is `[Johnson2006]`'s reference [10], cited on the very page that defines the construction. It is unread: the publisher's bot check refused a scripted fetch. |
| **P2 — the bridge; the unit-vector ring of ℚ** | **agree, one word changed** | Benda–Perles pp. 117–118 print `χ(ℝ²) = χ(𝔸²)` by Tarski; the number-field form is one compactness step, which `[Johnson2006]` p. 214 states with their credit. `H²` is on p. 120. Madore's ¶5.4 is not a restatement: he re-derived it without the paper, and his own footnote 5 credits Benda–Perles through MathSciNet's review. `[Fischer1990]` p. 182 had already credited them in 1990. |
| **P3 — the posed questions** | **agree** | Johnson 2000 p. 176 and 2006 p. 214 are verbatim. His "≥ 4" question is answered yes at `m = 11`, in the kernel (row 73). His ">" question is answered yes at `m = 47`, [hand], through measure rigidity (row 121). The family `m ≡ 11 (mod 12)` has four at every member ([hand], row 82) and value `L` wherever `L ≤ 5` (rows 99, 123); it is open where `L ≥ 6`. His suggested field ℚ(√23) is four (row 73). I checked `CLOSED-QUESTIONS.md` §1.1, §1.2, §1.7, §2.3, §2.6, §2.7, §2.8 and §3 against the sources and the rows. §2.8's quotation matches Sokolov–Voronov's held v1 (pp. 26, 4), and its polarity is right. Three places needed correction (listed below). |
| **P4 — `[Fischer1994]` cited** | **agree** | `[Johnson2000]` [9] and `[Johnson2006]` [8] are Fischer 1994, and both restate `χ(K²) = 4`. So `WORKFLOW.md`'s "nothing cites it" is false. Also checked: neither survey is in OpenAlex. Semantic Scholar was rate-limited, so it is unchecked. |
| **P5 — Townsend** | **agree, one omission** | I compared three passages of the 2005 print with the held manuscript: simplification (c), Theorem 1, and the end of Theorem 5's proof. All three match. (c) is unargued in the 2005 print, in the manuscript, and in Soifer ch. 25 (p. 257). Ch. 25 is Townsend's 2007 exposition (p. 255). LP's list of differences missed one: in 2005 the abstract's *"(known) result"* became *"proposition"*. Caution: the "manuscript" is a Word PDF created 2024 with a 1979 copyright line. |
| **P6 — LP's two derived claims** | **both check at [hand]** | The fractional Benda–Perles–Tarski sandwich `χ_f,0 ≤ χ_f(𝒜²) ≤ χ_f(ℝ²)` holds unconditionally, and row 129 closes it given MR (LV-T1). Johnson's `χ_f` equals the finitely-supported one (his Proposition, proof p. 106). The disconnectedness of `(F², 1)` for every real number field holds, including row 100's exception fields (LV-T2). One fix: its citation named `[Fischer1990]` Thm 1, which holds no integrality. |

## Corrections made in place (each logged old → new in the record, stage 2)

1. `LEDGER.md` row 57: the construction's first instances (Benda–Perles pp. 120–121) added. "Ours" now reads "not found in print as far as read, `[Johnson1982]` unread".
2. `LEDGER.md` § The claim list, Not ours: Theorem A's construction gains Benda–Perles pp. 120–121. The bridge now reads "credited to them by `[Fischer1990]` p. 182; re-derived as `[Madore2015]` ¶5.4, whose footnote 5 credits them".
3. `LEDGER.md` row 107: the same credit chain.
4. `LEDGER.md` claim list, rows 82–83: "both pose the family as open" → "2000 poses the family, 2006 asks whether any `m` needs four".
5. `LEDGER.md` row 100: Lemma C′ answers Johnson's §5 question at `n = 2` "outside the exception fields".
6. `CLOSED-QUESTIONS.md` §1.1 and `BIBLIOGRAPHY.md` `[BendaPerles2000]`: the p. 121 quotation had gained a closing parenthesis the print lacks; now *"G₁(Q²(√2) or"* with a note.
7. `CLOSED-QUESTIONS.md` §1.2: Benda–Perles's 1976 instances quoted; "Ours" carries the `[Johnson1982]` debt.
8. `CLOSED-QUESTIONS.md` §2.7: the heading claimed "every real number field", but the body excludes row 100's exception fields. The derived bracket cited `[Fischer1990]` Thm 1; it now cites `[Fischer1990b]` Lemma 1, and the multiquadratic disconnectedness is attributed to that paper's Corollary (Zaks for ℚ(√m)). "The exception fields' `A`" is narrowed: `[Fischer1990b]` Thm 5 covers the quadratic ones.
9. `CLOSED-QUESTIONS.md` §3: the fractional sandwich is now "[derived; two readers]".
10. `BIBLIOGRAPHY.md`: in `[BendaPerles2000]`, the credit chain (item 2). In `[Townsend2005]` and FS-108's banner, the "(known) result" difference. In `[Johnson1982]`, its bearing, the refused fetch, and Semantic Scholar's machine summary, marked as not the paper's words.

## `CLAUDE.md` drafts, corrected (not applied; total **+346 bytes**, 295,835 → 296,181)

| # | where | proposed | bytes | against LP |
|---|---|---|---|---|
| D-1 | item 14, l. 270 | `**nothing is claimed new while … are unread**` → `not found in print — \`[Johnson2000]\` and \`[Johnson2006]\` pose it as open (\`CLOSED-QUESTIONS.md\` §1.7)` | +25 | same |
| D-2 | § The prior-art position, ll. 330–332 | `— and all stop where⏎Madore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form (that⏎formulation);` → `— and all but \`[Fischer1990]\` (Thm 1(i), the coset construction) stop where⏎Madore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form made metric-free (not found in⏎print; \`[Johnson1982]\` unread);` | +98 | **changed**: "all stop where Madore declines" is false of Fischer's own lineage, and LP's draft left it standing |
| D-3a | § Publication, l. 179 | `The equality is his; the six later posers` → `The equality is his, restated in two surveys (\`[Johnson2000]\` p. 176, \`[Johnson2006]\` p. 214); the six later posers` | +74 | **changed**: LP placed this sentence right before "What is ours", where it read as ours |
| D-3b | same bullet, l. 180 | `Theorem A's general form (his congruence family is a proper subfamily` → `Theorem A's metric-free form and reach (the construction \`[Fischer1990]\`'s; his congruence family is a proper subfamily` | +50 | **changed**: the parenthesis is about which fields A four-colours, so "metric-free form" alone left it orphaned |
| D-4 | rank 17, l. 370 | `` `[Johnson2000]`, `[Johnson2006]` first; `` → `` … read, not found; `` | +10 | same |
| D-5 | G63, l. 1261 | `` is **`[Madore2015]` ¶5.4 with ¶1.3, by Tarski** (noted by `[BendaPerles2000]`, unread; `` → `` is **`[BendaPerles2000]` pp. 117–118 (1976), by Tarski** (re-derived as `[Madore2015]` ¶5.4 with ¶1.3, whose fn. 5 credits them; `` | +44 | **changed**: "restated" → "re-derived, fn. 5 credits them" |
| D-6 | G56's grade, l. 1041 | `` `[Madore2015]` ¶5.4 plus de Bruijn–Erdős `` → `` `[BendaPerles2000]` pp. 117–118 (Madore's ¶5.4) plus de Bruijn–Erdős `` | +30 | same |
| D-7 | rank 5, l. 358 | `three of five items answered at FS-110 (row 134); left: Townsend's (c) in full; \`[Townsend2005]\`` → `four of five answered (row 134; \`[Townsend2005]\` is the manuscript, (c) unargued); left: Townsend's (c) in full` | +15 | same |

(`⏎` marks a line break in the file. All eight old strings were checked to occur exactly once.)

**Other drafts:**
- **`WORKFLOW.md` 3.2 item 8.** Proposed: *"it is in neither OpenAlex nor Semantic Scholar, and the two surveys that cite it (`[Johnson2000]`, `[Johnson2006]`, in the same unindexed journal) are not in OpenAlex either, so **no database citation walk can arrive at it** — only reading the field's own surveys can"*. LP wrote that the surveys are "in no citation database"; only OpenAlex was checked.
- **G49 instance.** LP's instance, plus one clause: *"and `[Madore2015]`'s footnote 5, held and read since FS-18, had pointed the bridge at `[BendaPerles2000]` all along, as `[Fischer1990]` p. 182 had in 1990"*. The construction clause gains "first instances `[BendaPerles2000]`'s (1976)".
- **FS-20.** LP's note, ending instead: *"… and the metric-free statement — the last not found in print, with `[Johnson1982]` unread: read it before any manuscript claims it."*

## Zaks 1999 (Geombinatorics IX(2) 90–95), read in full

**It pre-empts nothing of ours.** Row 59 is about the plane over K and proves only the necessary direction of the valuation law. Zaks proves, in
`ℚ⁴`, the *sufficient* direction that row 59 leaves open over K: every proper four-colouring gives one colour to pairs at `√2` and at 2
(Lemmas 1–2) and different colours to pairs at every odd integer distance (Theorem 3). I checked the proofs by hand, including two misprints and
Johnson's correction to Lemma 2.

**New, derived at one mind (LV-T3; a second reader is owed):** combined with Benda–Perles's `[H⁴ : D] = 2` and the quaternion residue of row 57's
remark, Zaks's Lemma 1 gives the whole law in `ℚ⁴`:
- a pair is forced to one colour iff `v₂(|x − y|²) ≥ 1`;
- a pair is forced to different colours iff `v₂(|x − y|²) = 0`;
- a pair is free iff `v₂(|x − y|²) < 0`.

So a four-colouring of `ℚ⁴` forbidding both 1 and `d` exists iff `d² = p/q` with `p` and `q` odd. This answers `[Johnson2006]` p. 212's question
(*"For which d > 0 does there exist a 4-coloring of ℚ⁴ which forbids both distances 1 and d?"*), which he called still open in 2006, and it
confirms his guess about `4k + 2` and `√(4k + 2)`. It is entered in `CLOSED-QUESTIONS.md` §3 at one mind. Nothing after 2006 was searched.
Bearing on the answer: none. It is dimension four.

## Gates (each exit status read directly)

| gate | result |
|---|---|
| `python3 tools/bib_audit.py` | **exit 0** — every cited work resolves |
| `python3 tools/claude_md_fact_audit.py --base 2d229561` | **exit 0**, AUDIT PASSED (0 failures) |

## For the owner, ranked

1. **Decide D-2 and D-3** (the ones I changed from LP's). **Default if nothing is done:** `CLAUDE.md` keeps "all stop where Madore declines" and "Ours: Theorem A's general form", which the sources now contradict.
2. **`[Johnson1982]` wanted.** It is open access at ScienceDirect (doi 10.1016/0012-365X(82)90122-4), but only a browser can fetch it. It decides whether Theorem A's metric-free form is ours at all. **Default:** "ours" stays "not found in print, `[Johnson1982]` unread".
3. **LV-T3 needs a second reader** before it moves beyond `CLOSED-QUESTIONS.md` §3. A draft clause for row 59's **Open:** is in the record, stage 3.
