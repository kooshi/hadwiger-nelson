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
