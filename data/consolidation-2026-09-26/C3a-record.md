# C3a — claims front page: record

*Job C3a of the 2026-09-26 documentation consolidation (brief `data/consolidation-2026-09-26/briefs/C3a-claims-front-page.md`,
standing rules beside it). de Bruijn, Opus 5.5. HEAD at launch: `9b3ec6ab`. `CLAUDE.md` at launch: 296,094 bytes.*

## Stage 1 — SAVED

Items 1–2 of the brief.

| file | location | old claim (quoted) | new claim | justified by |
|---|---|---|---|---|
| `CLAUDE.md` | header, size budget | "**Size budget: none during the 2026-09-26 ×2×3 crunch** (Kooshi: *\"CLAUDE.md unbounded temporarily so we don't need to compress on the fly\"*); **otherwise keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the 2026-09-25 crunch's end: …" | "**Size budget: keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the ×2×3 crunch's end, after it ran unbounded: *\"the 300kB limit returns, …\"* (his second paragraph, verbatim); at the 2026-09-25 crunch's end: …" | Kooshi's words, brief §"Kooshi's words" ¶2 |
| `CLAUDE.md` | § Publication, third bullet | "**It has not fired.** **A candidate:** `χ(ℚ(√47)²) = 5` (row 121) answers … whether the rule fires is Kooshi's call, after the value's prior-art gate (pending, X24R). It appeared to have, once, for Theorem B" | "**It half fires** (Kooshi, 2026-09-26): … [hand], over MR (row 120) and an external theorem, in the kernel only in row 127's conditional form; its prior-art gate found nothing in print (X24R, row 121). His ruling: (three quotes verbatim) … The write-up is the fallback … the project pushes on toward six first … The rule appeared to fire once before, for Theorem B" | Kooshi's ruling (brief ¶3, ¶5); row 121 (X24R gate done: "not found in print") |
| `CLAUDE.md` | § Publication, FS-20 line | "**The paper is FS-20** (`plans/STUB-theorem-B-writeup.md`; re-scoped 2026-09-22 — whether it is still worth writing is Kooshi's call)" | "**The Theorem B paper is FS-20** (…; whether it is still worth writing is Kooshi's call; the fallback write-up above has no stub of its own)" | consistency: FS-20 is the Theorem B paper; the half-firing result is a different write-up |

Gates after stage 1: fact audit `--base 9b3ec6ab` PASS (0 failures; no ALLOW line added); `--dupes` 10 (unchanged from launch);
`fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` PASS; `check_architecture.py` PASS. `CLAUDE.md` 296,855 bytes.

Owed elsewhere (not mine to touch): a stub for the fallback write-up of rows 120–123 (Kooshi's call whether to mint it; C3b or the owner).

## Stage 2 — SAVED

Items 3–4 of the brief.

| file | location | old claim (quoted) | new claim | justified by |
|---|---|---|---|---|
| `CLAUDE.md` | Frontier, "The problem." | "This repository kernel-certifies the whole classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on the standard three axioms." | the same, "its lower end through de Grey's graph (rung B)", then "**The lower end now also follows algebraically, with no witness object:** a subfield's plane is a subgraph of ℝ²'s, so `χ(ℚ(√47)²) = 5` (row 121) gives χ(ℝ²) ≥ 5 — at [hand] grade, over MR (row 120: EL2021 Thm 1.2 by statement and Einsiedler–Fish's method transferred), not in the kernel, where row 127 holds it only over named hypotheses", then Kooshi's reading verbatim | rows 120, 121, 127, 33 |
| `CLAUDE.md` | § The mission, rung table, row B | "…our foundation, not our product" | "…our foundation, not our product. Also derived with no witness object, at [hand] (§ Where the problem stands)" | pointer (one home per fact) |
| `CLAUDE.md` | § The mission, target | "**The target, as of 2026-09-17: seven** (Kooshi, on reading G64 — …)" | "**The target, as of 2026-09-26: six, or a proof that no field's plane is six-chromatic** (G64's S) — Kooshi: (verbatim) … Beyond it, seven (2026-09-17, on reading G64 — …)" | Kooshi's words (brief ¶4); G64's statement S |
| `CLAUDE.md` | Paths forward, Open milestones | "**One is open: FS-84** … its remaining stages (S2 onward, from 2026-10-01) are re-aimed toward Soifer 55.1 as posed (the table's rank 4)." | "**None is open.** FS-84 … is **closed**: FS-100 stage 5 answered its question (row 121), and its remaining stages, an explicit triangle-free graph, are not pursued — Kooshi, 2026-09-26: (verbatim). S1 … and S1V … stand" | row 121; Kooshi's ruling (brief ¶6) |
| `CLAUDE.md` | Paths forward, rank 4 | "**FS-84 ℚ(√47): five colours** … S2 onward (post-ban) re-aimed to an explicit triangle-free five-chromatic graph … the owner's ruling, Kooshi may close it instead. Before the answer, …" | "**FS-84 ℚ(√47): five colours — closed (2026-09-26)** … answered by FS-100 stage 5 (row 121); the explicit triangle-free graph (Soifer 55.1 as posed) not pursued, Kooshi's ruling (Open milestones); its rank held so the table's numbering stands" (FS-97's precedent at rank 13) | row 121; Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry | "…so 55.1's \"construct\" and 55.2 stay open. FS-84 (post-ban) carries the explicit graph." | "…stay open. **The constructive half is not a project goal:** FS-84, which would have built the explicit graph, is closed (Kooshi, verbatim)." | Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry | "…the yes side is untouched. **Still open.**" | "…the yes side is untouched; the rigidity question stays open." (55.1's existence half is no longer open, row 121) | row 121 |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry, last sentence | "…55.1 as posed (construct one) and 55.2 stay open (FS-84's re-aim)." | "…stay open, and are not pursued here." | Kooshi's ruling |

Gates after stage 2: fact audit `--base 9b3ec6ab` PASS (no ALLOW added); `--dupes` 10 (one new run, FS-97's "kept at its rank so the
numbering stands | — |", caught and reworded); ledger-§B strict PASS; bib PASS; architecture PASS. `CLAUDE.md` 297,506 bytes.

Owed to C3b: `plans/STUB-five-colours-47.md`'s banner (closed, not re-aimed) and `plans/FRONTIER-STUBS.md`'s rank-4 row and closed list.

## Stage 3 — SAVED

The sweep of `CLAUDE.md` (item 5). Method: the diff since the version the X30F/X31C front pages started from (`a6ff3684`) read in full,
so what they had already rewritten was not re-done; then every sentence carrying MR, `given MR`, a ℚ(√47)/ℚ(√167)/ℚ(√3,√5) value, `L ≤ 4/5`,
`FS-59`, `55.1`, "exposed", "predicts", "open"/"not landed" near those fields, walked in context (141 + 40 hits), plus a read of the mission,
"Where the problem stands" items 1–29, the paths-forward table rows 1–59 and G48, G55, G56, G59, G64 in full. Grade rule applied:
"given MR" → "[hand], through MR (row 120/123)" or the row pointer; never a bare unconditional.

| # | location | old claim (quoted) | new claim | row |
|---|---|---|---|---|
| 1 | § The mission (2) | "Its proved range is item 10's — every `L ≤ 5` (row 123);" | "…every `L ≤ 5`, at [hand] through MR (row 123);" | 120, 123 |
| 2 | § The mission (2), exposed predictions | "— **all met** (rows 121, 123); and at least six at **ℚ(√167)**, proven 4 in the kernel (row 119) and ≥ 5 (row 123)," | "— **all met**, at [hand] through MR (rows 120–121, 123); … and ≥ 5 at [hand] (row 123)," | 120, 121, 123 |
| 3 | § The mission (2), "A finite refusal only confirms" | "so five over ℚ(√167) cannot falsify it (FS-59)," | "so five over ℚ(√167), held at [hand] (row 123), confirmed it and could not falsify it," | 123 |
| 4 | Frontier, Last-updated line | "**Paid (theorem); MR not landed** (`plans/FS100-three-field-lemma.md` §R-close)" | "…(…§R-close; MR landed at stage 5, row 120)" | 120 |
| 5 | Item 2 | "over K that is sufficient for five, given M56's 8/3 forcer (G55)." | "…given M56's 8/3 forcer (G55) or, independently, through MR (row 123, [hand])." (wall-broken `F ⊇ K` has `L ≥ 5`, G56) | 123 |
| 6 | Item 12 | "against four in the kernel (row 119) and five at K0's grade (row 121)." | "…and five at [hand], through MR (row 123)." | 123 (ALLOW `K0's`) |
| 7 | Item 14 | "ℚ(√47)'s bracket (item 10) cannot close from above by residues at any depth (§1.7, row 75)." | "ℚ(√47)'s bracket closed at five from below (item 10, row 121); no residue at any depth could have closed it at four (§1.7, row 75)." | 121, 75 |
| 8 | Item 18 | "(row 123, given MR)" | "(row 123, [hand], through MR)" | 123 |
| 9 | Item 22 | "Five over ℚ(√167) holds by two routes (row 123);" | "…by two routes, at [hand] through MR (row 123);" | 123 |
| 10 | Item 23 | "**Without triangles** rigidity is free in the abstract class and in the plane is Soifer's Open Problem 55.1 (row 86, §3), undecided at ℚ(√59) (item 24)." | "…free in the abstract class; in the plane it implies Soifer's Open Problem 55.1 (row 86, §3), whose existence half row 121 answers, and it is undecided at ℚ(√59) (item 24)." (row 86: rigidity ⟹ 55.1) | 86, 121 |
| 11 | Item 24 | "with MR held (row 120)" | "with MR held at [hand] (row 120)" | 120 |
| 12 | Item 27 | "the selection onto `T + A` is false as stated; at ℚ(√47) moot since row 121." | "…over T-C(A)'s class (the `L ≥ 5` fields) its `E`-form is moot through MR, no four-colouring existing there (rows 121, 123)." | 117, 123 |
| 13 | Item 29 | "(rows 120–122; FS-100 stage 5)" | "(rows 120–122; FS-100 stage 5; [hand])" | 120–122 |
| 14 | The open structural question | "Every known χ ≥ 5 argument factors as pigeonhole × kill (G15)." | "Every known χ ≥ 5 argument on a finite graph factors as pigeonhole × kill (G15); the field-level one through measure rigidity (row 121) names no finite graph." | 121 |
| 15 | Paths forward rank 1, FS-59, question | "**Does ℚ(√167)² need five?** Solver-free routes first (row 84 …; `L21cc6506` is loose at four, row 81); 7 minimal lattices …" | "**Does ℚ(√167)² need five? Yes, at [hand] through MR, by two routes (row 123)** — the question is answered, and six is what is left (row 125). The finite routes stood so: …" | 123, 125 |
| 16 | Paths forward rank 1, FS-59, bearing | "predicted ≥ 6 against a proven 4, … a five confirms and cannot falsify (FS-64); its ≥ 6 is archimedean modulo MR and PL; **≥ 5 by two routes (row 123)**;" | "predicted ≥ 6 against a proven 5 at [hand] (4 in the kernel, row 119), … the five confirms and cannot falsify (FS-64); its ≥ 6 is archimedean modulo PL, MR being held (row 120);" | 119, 120, 123 |
| 17 | Paths forward rank 2, FS-90, bearing | "a yes on the third is Soifer 55.1" | "…Soifer 55.1 as posed (its existence half answered, row 121)" | 121 |
| 18 | Paths forward rank 5, FS-75, bearing | "none; the falsification field's best bound is now the kernel's" | "none; the falsification field's kernel bound (four; five at [hand], row 123)" | 119, 123 |
| 19 | Paths forward rank 6, FS-80, bearing | "speculative; the only solver-free route to five at ℚ(√167) the competition left standing" | "…route to a certificate of five at ℚ(√167) … — five there is now held at [hand] by measure rigidity (row 123)" | 123 |
| 20 | Paths forward rank 12, FS-64 | "the `E`-form open over T-C(A)'s class (rows 116–117), moot at ℚ(√47) (row 121)" | "the `E`-form moot over T-C(A)'s class through MR (rows 116–117, 123)" | 117, 123 |
| 21 | Paths forward rank 16, FS-48 | "with MR, every entry" | "through MR (row 120, [hand]), every entry" | 120 |
| 22 | Paths forward rank 20, FS-72 | "(row 123, given MR)"; bearing "the conjecture's last cheap prediction's last object …" | "(row 123, [hand], through MR)"; "the prediction it served, five over ℚ(√3,√5), is met (row 123), and the lattice would be its explicit object …" | 123 |
| 23 | G15, killing test | "a χ ≥ 5 argument that does not factor, never yet met." | "a χ ≥ 5 argument on a finite graph that does not factor, never yet met." (scope: row 121's argument names no graph, so it neither meets nor tests universality) | 121 |
| 24 | G48, the conjecture | "— attained at all six fields where χ is known —" | "— attained wherever χ is known —" (every real `L ≤ 5` field, rows 99, 123) | 99, 123 |
| 25 | G48, Do | "at L ≤ 5 outside it the milestone is a test of the conjecture" | "outside it (now `L ≥ 6`) the milestone is a test of the conjecture" | 123 |
| 26 | G48, falsifiers | "a wall-broken, 5-sealed field whose plane is 4-colourable by a colouring local at no prime;" | "…(none at `L = 5` through MR, row 123);" | 123 |
| 27 | G55, consequences | "but at the descent: nothing gives four-colourings an ideal period." | "…period; five came by measure rigidity instead (row 123)." | 123 |
| 28 | G55, killing test | "…failing to replicate, on which the five-colour consequences over K rest." | "…on which the chain's route to the five-colour consequences over K rests (row 123 reaches them through MR)." | 123 |
| 29 | G56 | "A six-chromatic number field, if one exists, contains no √11 and none of the known five-forcers, and its five-chromaticity is itself open." | "…none of the known five-forcers; every field with local bound ≥ 6 needs five through MR (row 123, [hand])." | 123 |
| 30 | G59, what the conjecture makes of it | "if the wall holds, the main clause says nothing above five —" | "if the wall holds, the main clause (held through five, row 123) says nothing above five —" | 123 |
| 31 | G59, ℚ(√167) | "…whichever way the wall goes (…), against a proven 4 (row 79)," | "…against a proven 5 (row 123, [hand]; 4 in the kernel, row 119)," | 119, 123 |
| 32 | G59, killing tests | "(the conjecture above five; five there is FS-59's next question)" | "(the conjecture above five; five there is held, row 123)" | 123 |
| 33 | G64, aiming statement | "it hides only in the gap between `L(F)` and `χ(F²)`," | "…between `L(F)` and `χ(F²)` at `L(F) ≥ 6`, where `χ(F²) ≥ 5` through MR (row 123)," | 123 |
| 34 | G66 | "and ℚ(√47)'s bracket cannot close from above by residues (`CLOSED-QUESTIONS.md` §1.7)." | "…could not close from above by residues (`CLOSED-QUESTIONS.md` §1.7; it closed at five, row 121)." | 121 |

**ALLOW line added (reviewed):** `"K0's"` — item 12's "five at K0's grade (row 121)", a superseded pointer rewritten to its grade and
address; K0 stays in rows 117, 121 and 123.

Already current when I arrived (rewritten by X30F/X31C, verified, not touched): item 10, item 29's body, the Last-updated line's stage-5
entries, § The novel-results ledger's range, FS-100/FS-101/FS-97/FS-98 rows, G54's four-colour clause, G57's 55.1 clause, G60's `J₀`
clause, G76's measure half and demotion, G79's instances, G80.

Gates after stage 3: fact audit PASS (one ALLOW, above); `--self-test` PASS; `--dupes` 10; ledger-§B strict PASS; bib PASS; architecture
PASS. `CLAUDE.md` 298,719 bytes — 1,281 under the budget; the remaining room is too small for further additions, so later stages
rewrite in place or point.

## Stage 4 — SAVED

The sweep of `LEDGER.md` rows 1–127 and `CLOSED-QUESTIONS.md`. Method: every row's text grepped for MR, `given MR`, `4 ≤ χ`, the three exposed
fields' values, FS-59/FS-84, 55.1, "exposed", "predicted", "not landed", "open"; the brief's named rows (92, 96, 101, 110, 113, 116, 117, 118)
read in their hits; `CLOSED-QUESTIONS.md` grepped the same way and §2.6, §3, §4 read in full. Rows keep their own result and scope; where a
row's status clause is now stale, a pointer to the row that changed it is added at that row's grade.

| file | location | old claim (quoted) | new claim | row |
|---|---|---|---|---|
| `LEDGER.md` | claim list, end | "…(rows 123–125) — … unread;" (rows 126–127 missing) | adds "TR-ROT's equivalence with Q-μ and its spectral closure on `E` (row 126; prior art not searched); the kernel form of the main clause through five over named hypotheses, with `χ(ℚ(√47)²) ≤ 5` unconditional (row 127; the upper half is row 52's colouring)." | 126, 127 |
| `LEDGER.md` | row 74 | "`4 ≤ χ ≤ 5` at **`d = 143, 311, 335`** —" | "…(five at all three since row 123, [hand], through MR) —" | 123 |
| `LEDGER.md` | row 76, title | "**Five colours over ℚ(√3,√5): not landed — and where a forcer cannot live, by theorem**" | "**Five colours over ℚ(√3,√5): not landed by a forcer (the value landed at row 123, [hand], through MR) — and …**" | 123 |
| `LEDGER.md` | row 79, Not claimed | "`χ(ℚ(√167)²) ≥ 5`;" | "`χ(ℚ(√167)²) ≥ 5` (row 123's);" | 123 |
| `LEDGER.md` | row 82, consequences | "and `4 ≤ χ ≤ 5` where L = 5;" | "…where L = 5 (five there since row 123, [hand], through MR);" | 123 |
| `LEDGER.md` | row 86, Not claimed | "any member of `𝒰^tf` with `F₄ ≠ 0` (that is Soifer 55.1, open);" | "…(at least Soifer 55.1, whose existence half row 121 answers, [hand]);" (row 86's own "at least 55.1") | 121 |
| `LEDGER.md` | row 92, Not claimed | "so FS-59's and FS-64's five-colour questions at ℚ(√167) are untouched;" | "…are untouched here (five there is row 123's);" | 123 |
| `LEDGER.md` | row 96, Not claimed | "`χ(ℚ(√47)²) = 5` or `χ(ℚ(√167)²) ≥ 6`;" | "`χ(ℚ(√47)²) = 5` (row 121's, by another route) or `χ(ℚ(√167)²) ≥ 6`;" | 121 |
| `LEDGER.md` | row 99, Fischer's question | "answered here at `χ ≤ 3` and at `L ≤ 4` —" | "…and at `L ≤ 4` (at `L = 5` through MR, row 123) —" | 123 |
| `LEDGER.md` | row 101, Not claimed | "`χ(ℚ(√167)²)` (`4 ≤ χ ≤ 7`)" | "`χ(ℚ(√167)²)` (`5 ≤ χ ≤ 7` since row 123, [hand])" | 123 |
| `LEDGER.md` | row 113 | "**It does not decide `χ(ℚ(√47)²)`** (`4 ≤ χ ≤ 5` stands; FS-84)." | "**It does not decide `χ(ℚ(√47)²)`**; row 121 does (`= 5`, [hand], through MR)." | 121 |
| `LEDGER.md` | row 116, Not claimed | "anything at ℚ(√47) beyond the equivalence;" | "…beyond the equivalence (moot since row 121: no four-colouring exists there);" | 121 |
| `LEDGER.md` | row 119 | "The conjecture's widest gap now has its lower end in the kernel (four proven, at least six predicted; G59)." | "The conjecture's widest gap has its kernel lower end here (four; five at [hand], row 123; at least six predicted; G59)." | 123 |
| `LEDGER.md` | row 121, grade | "The consequences: row 123's grade; not kernel — X11K's lane has begun" | "…row 123's grade; in the kernel only over named hypotheses, row 127" | 127 |
| `LEDGER.md` | row 123, Not claimed | "a kernel proof (X11K2's lane, FS-101)." | "a kernel proof (row 127 holds the composition over named hypotheses; FS-101)." | 127 |
| `CLOSED-QUESTIONS.md` | §2.6 heading | "— **a candidate, not fired**: … and at `L(F) = 5` given MR (row 123), …" | "— **a candidate; the rule half fires** (Kooshi, 2026-09-26, `CLAUDE.md` § Publication): … and at `L(F) = 5` at [hand], through MR (rows 120, 123), …" | 120, 123; Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §2.6 body | "**Why a candidate, not fired:**" | "**Why still a candidate:**" | Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §1.7 body | "given MR there is none (row 121)" | "through MR there is none (row 121, [hand])" | 121 |
| `CLOSED-QUESTIONS.md` | §3 intro | "*Questions others posed in writing that we have not answered but are unusually well placed to.*" | "*…that we have not answered — or have answered only at [hand], or in part, as each entry marks — but …*" | 121, 123 |
| `CLOSED-QUESTIONS.md` | §3, smallest field | "- **The smallest field whose plane needs five colours.**" (body already said "answered by degree and then by `d`") | "…five colours** — **answered at [hand], through MR** (rows 121, 123), and held here by §1.7's rule until `[Johnson2000]` and `[Johnson2006]` are read." | 121, 123 |
| `CLOSED-QUESTIONS.md` | §4 | "— which has fired once, for §1.1." | "— which half fires for `LEDGER.md` rows 121–123 (Kooshi, 2026-09-26: … the fallback while the project pushes on toward six; `CLAUDE.md` § Publication), and appeared to fire once before, for §1.1, whose value `[Fischer1994]` had in print." | Kooshi's ruling; `CLAUDE.md` § Publication |

Left as they are, on purpose: § B lines FS58-T8 and FS61-T1 (`4 ≤ χ ≤ 5` at 47, 143, 311, 335) — theorem statements of what those tools
certified, true as stated; § B's `given MR` lines (FS100-X22, X27D-EQ/E/FL) — conditional theorem statements, MR's home being row 120;
row 117's "MR(F) ⟹ `χ(F²) ≥ 5`" — an implication, and its Not-claimed already points at rows 120 and 123; rows 71 and 73's "not landed …
(FS-59)" — the scope of those rows' own attempts. Section moves in `CLOSED-QUESTIONS.md` (the smallest-field entry and 55.1's existence
half from §3 to §2) were not made: other files cite "§3" for both.

Gates after stage 4: fact audit `--base 9b3ec6ab` PASS (no ALLOW added this stage); `--dupes` 10; ledger-§B strict PASS; bib PASS;
architecture PASS. Bytes: `CLAUDE.md` 298,719, `LEDGER.md` 404,741, `CLOSED-QUESTIONS.md` 57,564.
