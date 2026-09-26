# E2 — record: did E1's extraction remove only incidentals?

*Job E2 of the 2026-09-26 documentation consolidation; brief `data/consolidation-2026-09-26/briefs/E2-intrinsics-check.md`. Opus 5.5,
verifier (Coxeter). The range checked is E1's: base `230ea964` (HEAD before its first edit) to `aeef4e58` (its last commit), on
`CLAUDE.md`. The standard is E1's brief's definitions of intrinsic and incidental.*

## Stage 1 — SAVED: the mechanical check

**The tool:** `tools/e2_moved_check.py`. It never reads E1's move list. It aligns the two `CLAUDE.md`s line by line, then word by word
inside each changed hunk, and calls each run of deleted old words a removed **span** (spans closer than 6 matched tokens are merged, so a
pointer that happens to contain "the" cannot split one moved passage). Then:
- **landed:** each span must be found **verbatim**, newlines included, in `plans/GROKKING-INSTANCES.md`, `LEDGER.md`,
  `plans/FRONTIER-STUBS.md` or the current `CLAUDE.md` (a restored passage). A span not found whole is reported line by line.
- **paths-forward rows** (E1's M10 copied nothing: its brief sent ranks ≥ 30 to the rows `plans/FRONTIER-STUBS.md` already holds):
  each removed row must have a FRONTIER-STUBS row for each stub it names, holding every fact token of the removed row. A token that is
  not there fails, unless it is in the tool's `ROW_ALLOW` table with a reviewed reason (the table below).
- **pointer:** each hunk whose text landed elsewhere must name that file, and for `GROKKING-INSTANCES.md` the section.
- **completeness:** every word that left `CLAUDE.md` must lie inside a reported span, so the word alignment cannot hide a removal.
- **rewrites** (spans under 24 visible characters) are listed for reading, not scored: there was one, "both" → "the three" in the
  header's audit sentence.

**Result on E1's range** (`python3 tools/e2_moved_check.py --homes-rev aeef4e58`, exit 0; the same on the working tree): 11 spans —
10 moved, 1 rewrite; 2,668 lost words, all inside spans.

| span | old line | bytes | landed | pointer |
|---|---:|---:|---|---|
| E1's M9, "Not ours" (from "band rigidity") | 254 | 4,626 | verbatim in `LEDGER.md` | "`LEDGER.md` § The claim list" |
| E1's M10, paths-forward ranks 30–59 (15 rows) | 309– | 4,843 | by tokens in each row's own FRONTIER-STUBS row; not verbatim (by design) | the "30–59 … `plans/FRONTIER-STUBS.md`'s alone" row |
| E1's M1, G21 "periodic search … period cap" | 528 | 348 | verbatim in §G21 | §G21 (the one pointer, "the third, and the rest") |
| E1's M2, G21 "one-period census" | 528 | 451 | verbatim in §G21 (ends trimmed: "P3b", which stayed) | §G21 |
| E1's M3, G21 from "a finite configuration" to "(row 126)" | 528 | 2,154 | verbatim in §G21 | §G21 |
| E1's M5, G49 from "FS-79's instance" | 826 | 1,328 | verbatim in §G49 | §G49 |
| E1's M6, G50 from "FS-79's instances" | 836 | 1,525 | verbatim in §G50 | §G50 |
| E1's M7, G50 "FS-100 stage 5's" | 836 | 368 | verbatim in §G50 | §G50 |
| E1's M8, G72's per-milestone count | 1400 | 2,388 | verbatim in §G72 | §G72 |
| E1's M11, § Building "(b) The repair attempt" | 1815 | 342 | verbatim in § Building | "§ Building" |

**Reviewed allowances for the row check** (`ROW_ALLOW`; each is a token the removed `CLAUDE.md` row carried and its FRONTIER-STUBS row
does not):

| row | token | why it may be absent |
|---|---|---|
| FS-65 (34) | G64 | a cross-reference; FRONTIER-STUBS's row states the consequence, and G56/G59/G64 hold the wall's meaning |
| FS-65 (34) | `α(Γ_q)` | notation: FRONTIER-STUBS writes `α(UD(𝔽_q,2))`, and Γ_q := UD(𝔽_q, 2) (§ Notation) |
| FS-41 … FS-52 (38–42) | row 66 | FS-42's row says "Row 66 leaves exactly one constructive residue route" (capital R) |
| FS-20, FS-17, FS-2 (43–45) | 97, FS-66 | **FRONTIER-STUBS's FS-17 row is stale**: it reads α ≤ 105 (FS-56); the CLAUDE.md row had α ≤ 97 by FS-66's certificate. The fact itself stays in `CLAUDE.md` (Frontier item 17: "`α(Γ₂₃) ≤ 97`"), so nothing is lost from the corpus, but the stub's own row is now the only stub-table text and it is out of date. FS-65's row ("certificate ≤ 105") likewise. Owed to FRONTIER-STUBS, outside E2's touch list: held for the owner |
| FS-20, FS-17, FS-2 (43–45) | row 71 | FS-17's row states five refused at 23 (FS-56's certificate) without the row number |
| FS-13 … FS-37 (46–49) | FS-47 | the FS-37 ↔ FS-47 link stays in `CLAUDE.md` from the other side (rank 27's FS-47 row, "with FS-37"; G35's gate) |
| FS-9, FS-10, FS-5 (57–59) | row 80 | FS-9's row cites row 80's derivation (`plans/FS79-derivation.md` T26); G30 and G73 carry row 80 |

**Planted faults** (`--self-test`, each on copies of the homes at `aeef4e58`, never in the tree), exit 0:

| plant | must | result |
|---|---|---|
| partner: homes as E1 left them | pass | 0 failures |
| 1: one moved line of M1 deleted from `GROKKING-INSTANCES.md` | fail for that line only | 1 failure: `LOST line … L3e1c94c6 …` |
| 2: one "Not ours" line deleted from `LEDGER.md` | fail for that line only | 1 failure: `LOST line … Sokolov–Voronov …` |
| 3: `` `struction` `` dropped from FS-65's FRONTIER-STUBS row | fail for that row | 1 failure: `LOST tokens of row ['FS-65']` |
| 4: the §G49 pointer dropped from `CLAUDE.md` | fail for that pointer | 1 failure: `NO POINTER in hunk 11 to §G49` |
| partner 5: M11 restored to `CLAUDE.md` and gone from its home | pass | 0 failures |
| 6: one removed span hidden from the checks | completeness fails | 1 failure: `UNCOVERED words …` |

**Mechanical verdict: every passage landed, and every hunk keeps a pointer.** Two weaknesses the tool passes and a reader should know:
the §G21 pointer ("the third, and the rest") sits after FS-81's items, so it does not visibly cover M1 and M2, which were cut from
earlier in the paragraph; and G68 ("row 81; G21") and G73 ("G21's one-period census") address M2 by its old place (stage 2).

Would-have-searched log: none.

## Stage 2 — SAVED: the judgement, passage by passage

**The test** (E1's brief's standard): a removed passage is **intrinsic** if it carried a rule's only statement, a *why*, a condition, a
*Do* line, a killing test, a demotion record, the rule's only example (the one that best shows the failure), or a current-state fact
the Frontier or a grokking reasons from; otherwise, if its lesson is stated elsewhere in `CLAUDE.md` (or in `WORKFLOW.md`, which
`CLAUDE.md` imports), it is a second or later instance — **incidental**. When unsure, intrinsic. `[PROTECTED]` text: none touched (the
fact audit's byte-identity check of both PROTECTED regions passes at `aeef4e58`, and no span lies in them).

### What E1 removed

| passage (E1's id) | bytes | verdict | reason |
|---|---:|---|---|
| G21, "**And a periodic search measures its period cap**" … `N ≤ 120`. (M1) | 349 | **INTRINSIC — restore** | a bold rule statement found nowhere else in `CLAUDE.md` (G68's "an UNSAT … at one `N` proves nothing" is the one-period screen, not a search stopped at a cap), and it is the **failure** the next, kept sentence answers: "Read a solver's colouring before searching its periods" names the period 23 that this search, stopped at `N = 20`, missed. Without it the kept rule keeps its remedy and loses the failure it prevents. E1's reason ("a second instance of G21's own rule") would move FS-81's relation tree too, which E1 kept as a rule's only statement; the two have the same form |
| G21, "**And a one-period census measures its period**" … measures that point. (M2) | 452 | **INTRINSIC — restore** | it carries a *why* stated nowhere else — "a finite set of periodic colourings can only ever pin a full-rank group", which is why a one-period census cannot show rigidity — and its rule's only failure example (4,490 Kempe-rigid orbits read as rigid; `P = F = 0`). Two grokkings address it by its place: G73 "(row 81; G21's one-period census)" and G68 "(row 81; G21; …)". G73's *Do* keeps the remedy (compute `Θ_k` cells), not the why |
| G21, "; and **a finite configuration measures its depth**" … "(row 126)." (M3) | 2,160 | incidental | every lesson in it is stated elsewhere: the finite configuration and FS81-T8 in G74's *Do* ("a finite configuration holds points the field does not (FS81-T8 …)") and G61's *Do* (`d < 21·5^{K−1}`); the rank-1 scan and the proof "checked by its points" are G21's head sentence (a check measures the check); plants that could not fire, a wrong-reason red, a positive control of the wrong shape — "Make the gate fail"; "quote a statement verbatim in a brief" — G51's standing rules; FS-89's blind verifier — G51's "Its runs" (the same event, "a verifier checks a fixed statement"); existence paraphrased as classification — G77. No demotion record: "Wave 3b's" is an owner slip whose result is row 126 |
| G49, "**FS-79's instance, the question itself:**" … "the day it was needed." (M5) | 1,329 | incidental | instances of G49's head ("for the question as well as the method"; "in the discipline's words") and *Do* ("a held paper is prior art for questions it was not read for"), whose kept example is FS-71's six re-attributions; the question rule's example stays in G49's opening (Theorem B's value in print since 1994) and in `WORKFLOW.md` 3.2 item 3. The attributions it names (`[Ellenberg2018]`, `[KlotzSander2017]` Thm 4.2, GRR 2017) are in the "Not ours" list and item 20 |
| G50, "**FS-79's instances:**" … "went unsearched." (M6) | 1,526 | incidental | instances of G50's rule; the kept examples are FS-100's (the *Do*'s: "none held" written for held papers; "one read by its summary") and the EL2021 debt, and `WORKFLOW.md` 3.2 item 6 has "an abstract is not a reading" with its own example. The one current-state debt in it, Nešetřil–Rödl "still unchecked", is tracked in `BIBLIOGRAPHY.md` (line 772, "unchecked"); Puzynina "not held" is a bibliography status, and G75 keeps Puzynina's role |
| G50, "**FS-100 stage 5's:**" … polynomial growth"). (M7) | 369 | incidental | its mathematics is two *Do* lines on disk — G76's "run Einsiedler–Fish's pigeonhole with the product formula before calling a measure question ×2×3-hard" and the next grokking's "count the group's elements by height before calling it ×2×3-hard"; its method lessons are G49's head (discipline's words) and G21's (a zero is not support). "MR is ×2×3-hard" was never a grokking's claim, so no demotion record is owed. Its last sentence (EL2021 fetched a third time; §2 unread) stayed, now under FS-100's, where it reads true |
| G72, the per-milestone count (M8) | 2,389 | incidental | the killing test's data; its state ("twelve of thirteen") and the one exception (the thirteenth) stay. The owner ruling inside it ("Kooshi declined: 'yes', no-gos count", 2026-09-24) is Frontier item 23's, verbatim in substance ("no-gos count") |
| Frontier, "**Not ours:**" list (M9) | 4,640 | incidental — the owner's named incidental | E1's brief names it. `LEDGER.md`'s preamble said it "stays in context against misclaims" (J05): a *why* for keeping it loaded. E1 kept that why as an instruction in the pointer ("read it before calling anything ours"). Verdict: the design is the owner's; the why survives as a *Do*. E1's held item (1) stands for the owner |
| Frontier, paths-forward ranks 30–59 (M10) | 4,843 | incidental — the owner's named incidental | every row is in `plans/FRONTIER-STUBS.md` with every fact token (stage 1) except the reviewed allowances. **One finding:** FRONTIER-STUBS's FS-17 (rank 44) and FS-65 (rank 34) rows still read `α(Γ₂₃) ≤ 105`; the removed `CLAUDE.md` row had `≤ 97` (FS-66's certificate). The fact stays in `CLAUDE.md` (Frontier item 17), so nothing is lost, but the stubs' rows are stale — owed to FRONTIER-STUBS |
| § Building, "(b) The repair attempt …" (M11) | 343 | incidental | the rule it illustrates, "never through a pattern that can match the killing shell", keeps its example in the next sentences (the `/proc/*/cmdline` scan "matched its own pattern … and killed its own process group") and in "Make the gate fail" ("a `grep` that killed its own shell"). Side effect: "Make the gate fail" still says "the self-match rule is on this page with eight instances"; one is now a pointer (a count of history; not restored) |
| header, "(nothing lost, across both files)" → "across the three files" | 4 | a rewrite, current state | correct: the audit now reads three files |
| glue g1, "P3b typed" → "P3b (FS-79) typed" | +8 | revert with M2 | E1 added the milestone because M2's cut removed "(FS-79, row 81)" from the sentence before; restoring M2 restores the original words |

**Restorations owed: M1 and M2** (801 bytes of text, with g1 reverted: `CLAUDE.md` +793 bytes net), back into G21 at their original
place, word for word from `230ea964`, and their two blocks removed from `plans/GROKKING-INSTANCES.md` §G21, where they would otherwise
be duplicates.

### What E1 kept — the other direction (reported, not acted on: E2 restores, it does not move)

| kept passage | E1's reason | E2's verdict |
|---|---|---|
| G21: M63 phase G's four defects; "the mechanism is selection" | the rule's example and reasoning | agree — intrinsic |
| G21: FS-71's census, "a conclusion with no chain is the shape to re-derive first" | only statement | agree |
| G21: "Read a solver's colouring before searching its periods" + the Fourier example | only statement | agree (and see M1) |
| G21: P3b, "a control at the scale of the question" | a condition on "point every instrument at a known positive" | agree — the condition is stated nowhere else |
| G21: FS-81's relation tree ("the screen runs first … UNDECIDED, never NONEMPTY") | only statement | agree |
| G21: FS-81's **contended times** ("re-asked alone"), 181 B | only statement | **disagree — over-kept.** Its rule is stated twice already: § Two machines ("Measure in CPU seconds (user + sys), minimum of three runs") and "Make the gate fail" ("a contended-wall timing used as a quiet-CPU cost (1.59×)"); its number (463 s quiet) is G65's. A second instance |
| G49: two-database zero; FS-73's held Polymath16 text; `ab:` limit | sub-rules with their only example | agree |
| G49: row 88's first half, "C14.2 (c) is `[BardestaniMallahiKarai2017]` §3.2 … never carried to the lemma", 130 B | kept with the `ab:` half | **disagree — over-kept.** An instance of the *Do*'s "a held paper is prior art for questions it was not read for", whose kept example is FS-71's six re-attributions; only its `ab:` half is a sub-rule |
| G50: FS-100's example and the EL2021 debt | the *Do*'s example; a current debt | agree |
| G72: "twelve of thirteen" and the thirteenth | the killing test's state and its one exception | agree |
| G79: the killing-test record ("First test: … row 126"), ≈ 870 B | inside the *Killing test* span | **defensible, inconsistent with M8.** It is the same kind of text as G72's per-milestone list, which moved; but G79 has no summary tally, so the record is the only statement of its killing test's state. Moving it needs a one-line tally first (owner's call) |
| G67's first data points; G71's, G74's killing-test status | inside the *Do* span | agree — the status of a falsifier is state |
| G51's "Its runs" | readings and the standing rules they left | agree; its per-run counts ("de Bruijn 2, Coxeter 1, Poros 0") are small history |
| § Building: Sixth instance; `$!`'s shell; (a) the wrong pgid; `/proc` scan; pipes; script edits | each its sub-rule's only example | agree |
| § Building: Ninth instance (`flock` wrapper) | only example | borderline: its mechanism is `$!`'s (killing a parent leaves the child), but "verify … the lock free" is a condition stated nowhere else — keep |
| "Make the gate fail": every paragraph | each a distinct rule with its only example | agree, walked paragraph by paragraph; two carry more than one example ("carry what it MEASURES", three rulings; "exactly ONE thing may differ", two) — kept, since each list is the evidence its head sentence counts |
| § What compute actually helps: M2's and FS-75's re-pricings | a condition | agree — M2's adds "grep Mathlib by the statement's shape", FS-75's that even the two-leaf re-price ran high |

## Stage 3 — SAVED: the restoration (one batch)

M1 and M2 are back in G21 at their original place, word for word from `230ea964`, and E1's glue g1 ("P3b (FS-79) typed") is reverted
to the original "P3b typed" with them. Checked exactly: G21 now equals its `230ea964` text with only M3 replaced by E1's pointer
(`True`). Their two blocks (with their "*M1, from G21, …*" / "*M2, …*" labels) are removed from `plans/GROKKING-INSTANCES.md` §G21,
which now holds M3 alone.

| file | before | after |
|---|---:|---:|
| `CLAUDE.md` | 282,481 | **283,274** (+793: 801 bytes restored, 8 bytes of glue reverted) |
| `plans/GROKKING-INSTANCES.md` | 10,542 | 9,599 (−943: the two passages and their labels) |

Gates at this commit (exit statuses read directly): `claude_md_fact_audit.py --base 230ea964` PASS (0 failures); `--dupes` 10 (628 B,
unchanged); `fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` PASS; `check_architecture.py` PASS; `e2_moved_check.py` PASS (M1 and
M2 now read "in CLAUDE.md (restored)").

Not edited, reported: the header's budget parenthesis still says "E1's pass took the file from 299,491 to 282,481 bytes", which is
true of E1's pass; the file is now 283,274 (E2's touch list is restorations only).
