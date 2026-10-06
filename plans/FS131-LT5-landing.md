# FS131-LT5 — the gate's assumptions step lands

*The record of job FS131-LT5 (de Bruijn, the implementer; a tooling job and a landing). Brief:
`data/fs131/briefs/FS131-LT5-gate-step-land.md`. Worktree `.claude/worktrees/fs131-wlt`, branch `fs131-lt5`, cut from `main` at
`e9a65a86` and fast-forwarded to `dafb23fa` (the commit that carries the brief) before anything else. Everything this record cites
is under `data/fs131/lt5/`.*

## Theorems this phase proved

None. This job merges a tooling branch, edits docstrings, declares what the library assumes and runs the gate; it proves no
theorem, changes no statement, definition or proof, and moves no axiom count.

## Stage 1 — SAVED (FS131-LT5): the readback, what was read, the build as given

**The quotations.** The brief quotes fourteen statements, each as a first line with its source. All fourteen are whole lines of
their sources, verbatim, and each one cited with a section lies under that heading (`tools/fs131_lt5_readback.py`, output
`data/fs131/lt5/readback.out`: `quotations=14 mismatched=0`). The tool's controls (`--self-test`,
`data/fs131/lt5/readback-selftest.out`, four of four as expected): a faithful quotation reads MATCH; the same line with one
character changed, the same line cited under a section it is not in, and the same line cited from a file that does not exist each
read MISMATCH.

**What was read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the step's record on `fs131-t5` (`plans/FS131-T5-assumptions.md`, all six stages, "What is on its way", the eight
drafts) and its report (`data/fs131/reports/FS131-T5.md`); `scripts/Assumptions.lean` on that branch, all 869 lines — the scan and
the declared list, entry by entry; `scripts/assumptions.sh`; inventory items 548, 551 and 562 with its rulings (a)–(h);
`plans/FS131-L10B-landing.md` § Drafts for the front page (its draft 6, the table of hypotheses written for this job, and drafts
7–9) and "Theorems this phase proved, final"; `plans/FS131-L6A-landing.md` § Drafts items 1–6 (item 5, the named hypotheses; item
6, the open gate items). **Read by address, not whole**: the two landings' stage sections; the rest of the inventory.

**What the two landings say they brought, before the step is run** (the expectations the step's output is read against in
stage 3):

| from | what | the landing's reading |
|---|---|---|
| FS131-L10B draft 6 | the axiom `StandingFive.kloosterman_bound` | an outside theorem as an `axiom`, `[Weil1948]` p. 207; eight theorems rest on it |
| FS131-L10B draft 6 | `StandingFive.KloostermanBound` (named former) | the hypothesis form of the same theorem; taken by nine theorems; concluded by `kloostermanBound_of_ringChar_ne_two` over the axiom |
| FS131-L10B draft 6 | `StandingFive.StandingFloor` | discharged over the import (`standingFloor_seven_weil`, `standingFloor_five_weil`); still taken by `seven_le_localBound`, `five_le_chromaticNumber`, `standingFloor_mono` |
| FS131-L10B draft 6 | `five_le_chromaticNumber_weil`, binder `hRow123` | row 123's chain written out in a binder, closed; ours |
| FS131-L10B draft 6 | `sp_if_hypotheses_trivial_bot` | takes `BochnerHerglotz` at `unitRing ⊥` |
| FS131-L10B draft 6 | a hand result written out over a theorem's own variables | "this landing has none" |
| FS131-L10B | `Plane.falconer_lemma2_nonempty` | the axiom is a theorem since FS131-IF1: its four `RESTS` rows are stale |
| FS131-L6A draft 5 | `NoPar 𝒞` (`Plane/Saturated/MapColouring`) | "one named open statement … ours, proved nowhere" (C121-NOPAR at `k = 6`); taken by `gmap_ii`, `sat_noPar` |
| FS131-L6A draft 5 | `c.SingLocallyFinite`, and its local form | "a regularity hypothesis whose truth for every honest saturated colouring is the open claim C121-REGJ"; satisfied by `sq9` |
| FS131-L6A draft 5 | `GFin 𝒞` | "the other named open statement of that row; it stands on one side of `gmap_ii`'s equivalence and is no hypothesis" |

**The records the step resolves against, on this tree**: `BIBLIOGRAPHY.md` holds `**[Rudin1962]**` (l. 113) and
`**[Kakutani1938]**` (l. 114), the two rows the step's first run lacked (ruling 562 (a)), and `**[Lang1953]**` (l. 339).

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0: "All targets
up-to-date (5932 jobs)", "all 1831 modules already up to date, nothing built, 0 module(s) with warnings"
(`data/fs131/lt5/build-stage1.log`). No `sorry` as a term or a tactic under `Proofs/` (the word occurs in seven files' comments);
the axiom audit's `sorryAx` check is the receipt, at the gate.

**Token count at this stage**: I have no reading of the harness's count; my own estimate is about 190k, most of it the context
loaded at launch and this stage's reading.

## Stage 2 — SAVED (FS131-LT5): the merge

`git merge origin/fs131-t5` (tip `4dd69014`), trialled with `--no-commit` first (`data/fs131/lt5/merge-trial.out`: "Automatic
merge went well") and committed as `a95cd1ca`. It brings 35 files — `scripts/Assumptions.lean`, `scripts/assumptions.sh`,
`scripts/assumptions-controls.txt`, `scripts/assumptions-ledger.txt`, a change to `scripts/gate_report.py`, two tools, the step's
record and report, and 26 files under `data/fs131/t5/` — and **no file under `Proofs/`** (`git diff --stat HEAD~1 HEAD -- Proofs`
prints nothing). No conflict: `main` had not touched `scripts/gate_report.py` since the branch was cut at `3bfc7d2e`.

## Stage 3 — SAVED (FS131-LT5): the step on today's `main`, read before anything is declared

**The self-test first**, on the merged tree with the list as it came: `scripts/slot.py --mem 16 --cpus 4 -- ./scripts/assumptions.sh
--self-test`, exit 0, "OK — all 32 checks behaved" (`data/fs131/lt5/runs/selftest-as-merged.out`; the planted copy's scan,
`selftest-as-merged.scan.log`). Its controls plant their own axiom, formers and consumers, so they do not move with the library; the
run counts "the shipped list's own failures: 22" and leaves them to the gate.

**Then the gate**: `scripts/slot.py --mem 16 --cpus 4 -- ./scripts/assumptions.sh`, **exit 1, 22 failures**
(`data/fs131/lt5/runs/gate-as-merged.out`; the scan's full output, `scan-as-merged.log`).
`=== SCANNED === constants=13795 theorems=10173 formers=303 hypotheses=17192 closed=1473 untelescoped=0`;
`=== TOTALS === axioms=1 rests=8 named=18 inline=15 outside=5 ours=24 open=4 takes=87 mentions=1 produces=11 sites=26
conditions=31 declaredClosed=31 established=1433 premises=2 refuted=3 refutes=0 silent=11 derived=1 wrappers=0 cohyp=35 hints=4
unseen=15243 fails=8` (the scan's 8; the shell adds the ledger's 14). Against the step's own run at `3bfc7d2e`: 644 more
constants, 28 more formers, 5 more closed hypotheses, `unseen` 14112 → 15243.

**Every failure, by kind, with what it means.**

| kind | n | the rows | what it means |
|---|---|---|---|
| a consumer of an axiom that is gone (`stale-consumer`) | 4 | `RESTS Plane.falconer_lemma2_nonempty` ← `exists_mem_falconerE`, `falconer_reduction`, `fan_tip_ae_mem`, `le_chiM_of_falconerFan` | Falconer's Lemma 2 (i) is a theorem since FS131-IF1 (landed by FS131-L10B): the four rest on no axiom of the library now. The rows leave the ledger. |
| a theorem resting on an axiom the ledger does not list (`unlisted-consumer`, `RESTS`) | 8 | `RESTS StandingFive.kloosterman_bound` ← `circle_sum_le_weil`, `five_le_chromaticNumber_weil`, `kloostermanBound_of_ringChar_ne_two`, `seven_le_localBound_weil`, `standingFloor_five_weil`, `standingFloor_seven_weil`, `targetFloor_seven_weil`, `targetFloor_six_weil` | Weil's bound is the library's one outside axiom (`ref=bib:Weil1948`, read by the scan from the axiom's docstring). The eight are exactly the eight IMPORTED records of FS131-L10B's draft 6 — the scan reads every theorem of the library, not the audit's records, and finds no ninth. The rows enter the ledger. |
| a theorem taking a declared hypothesis that the ledger does not list (`unlisted-consumer`, `TAKES`) | 2 | `BochnerHerglotz` ← `SpectralInputs.sp_if_hypotheses_trivial_bot`; `StandingFloor` ← `StandingFive.standingFloor_mono` | Both landed with wave 10: the model of `sp_if`'s hypotheses is given Herglotz–Bochner (L10B's table); the monotonicity lemma takes the floor at a variable. |
| a former whose docstring calls it an assumption, undeclared (`undeclared-by-docstring`) | 1 | `StandingFive.KloostermanBound` | its docstring: "a named classical hypothesis … (`[Weil1948]` p. 207 …)". The step asks for it. |
| a closed hypothesis nobody declared (`undeclared-closed-hypothesis`) | 4 | `five_le_chromaticNumber_weil:hRow123`; `standingFloor_seven:hK`, `standingFloor_five:hK`, `seven_le_localBound_of_kloosterman:hK` | `hRow123` is row 123's chain written out, the proposition already declared at `five_le_chromaticNumber` (label `Row123Chain`). `hK` is `∀ F [Field F] …, card F % 4 = 3 → 347 ≤ card F → KloostermanBound F`: Weil's bound at a family of fields, a closed statement. |
| a former no theorem concludes, in neither list (`undeclared-never-concluded`) | 3 | `Plane.GrundyBound` (taken by `gmap_i`), `Plane.H1On` (by `AeColouring.twoColourNhd_of_h1`), `Plane.NoPar` (by `sat_noPar`, `gmap_ii`) | wave 6's first half: each is an assumption or a condition, to be said. |
| a declared hypothesis a theorem now proves (`discharged`) | 0 | — | **the step printed none.** `StandingFloor` is proved at 7 and at 5 (`PRODUCES StandingFloor standingFloor_seven_weil uncond`, `…_five_weil uncond`), not over a variable, and the rule fires only on a former proved in general. Stage 4 says what follows. |

22 = 4 + 8 + 2 + 1 + 4 + 3. **Counted, not failing**: `hints` 3 → 4 (`five_le_chromaticNumber_weil`, whose docstring says "a named
hypothesis from outside the backlog" of `hRow123`, undeclared until stage 4); `cohyp` 34 → 35; `silent=11`, the same eleven; the
digest's two flags — the ledger's header stale (`rests 4 → 8, takes 85 → 87`) and the nine counts absent from `CLAUDE.md`.

**What the step did not need to be told**: `SingLocallyFinite` (FS131-L6A draft 5: "a regularity hypothesis whose truth for every
honest saturated colouring is the open claim C121-REGJ") is concluded by a theorem with no assumption (`sq9_singLocallyFinite`), so
the scan reads it as an ordinary predicate of the theorem's colouring; `GFin` stands under `↔` in `gmap_ii` and is taken by nothing.

**Read against the two landings' tables (stage 1)**: every row of the table is met by a row of the scan — the axiom and its eight;
`KloostermanBound`; `hRow123`, closed, found by the step itself; `sp_if_hypotheses_trivial_bot`; Falconer's four stale rows;
`NoPar`. **The scan found two things the tables do not list**: `GrundyBound` and `H1On`, both conditions by my reading (stage 4);
and one consumer, `standingFloor_mono`. No assumption on `main` that no record names.

**The docstrings read for the words** (the class the step cannot see: a hand result written out over a theorem's own variables).
`tools/fs131_lt5_docwords.py` extracts every doc comment of a module with the declaration that follows it and prints those holding
any of 29 words ("named hypothes", "[hand", "open question", "proved nowhere", "assum", …); it decides nothing, and each hit was
read (`--self-test`, `data/fs131/lt5/docwords-selftest.out`: a docstring with a word, one split across two lines and a module doc
are found; a plain docstring and a `--` comment are not).
- **Wave 6's first half, fourteen modules of `Plane/Saturated/`** (`data/fs131/lt5/docwords-wave6.out`): 579 doc comments, 4
  with a word — `gmap_ii` ("C121-NOPAR and G-FIN₆ are the two named open statements, hypotheses here and proved nowhere"),
  `sat_noPar` ("C121-NOPAR, a named open statement"), `sq9Map_sat_model` (a note on the same), and `SingLocallyFinite`'s
  definition ("C121-REGJ's open question, FS-127"). **No hand result or open question is written out in a binder over a theorem's
  own variables**: the one open statement taken is the named former `NoPar`, which the step found.
- **Wave 10's second half, twelve new modules and three changed** (`docwords-wave10.out`): 437 doc comments, 20 with a word, each
  about `KloostermanBound`, `StandingFloor`, `BochnerHerglotz`, `BochnerOn`, the import, or `hRow123`. None beyond those — as
  FS131-L10B's draft 6 says ("this landing has none").

**Token count at this stage**: no reading of the harness's count; own estimate about 300k.
