# J05 — no-loss compression pass on `CLAUDE.md` (record)

*Brief: `data/crunch-2026-09-25/briefs/J05-claude-md-compression.md` with `STANDING-RULES.md`. Editor: de Bruijn (Opus 5.5).
HEAD at launch: `2802fd78` (every audit below runs `--base 2802fd78`). `CLAUDE.md` at launch: 296,413 bytes; `--dupes` 13.*

## Theorems this phase proved

None (an editing job; no mathematics).

## Would have searched here

None — no step of this job is a search for a finite witness.

## Quotation check (standing rule 5)

| quotation in the brief or standing rules | source | verdict |
|---|---|---|
| "after a rule's reasoning was trimmed to fit and its loss cost hours" | `CLAUDE.md` header (size budget) | verbatim |
| "measured the file's floor at about 228,000 bytes" (brief's paraphrase, not in quotes) | `CLAUDE.md` header: "measured its floor at about 228,000" | matches |
| "The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time." (standing rule 3) | `CLAUDE.md` § Toolchain: *its intent,* "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | core verbatim; the standing rules put the words "The intent of the ban is" inside the quotation marks, where `CLAUDE.md` has them outside (not a change of meaning) |
| "A proven theorem about why its impossible is also valid. All novel knowledge is a success" (standing rule 4) | `CLAUDE.md` item 23 | verbatim |
| "We should also probably start with the CLAUDE.md compression session, back down to 300k." | Kooshi to the owner (conversation) | not checkable from the repository |

## A tension in the brief, and how this pass resolves it

The audit's corpus is `CLAUDE.md` + `LEDGER.md` only; `plans/FRONTIER-STUBS.md`, the protocol and plan files are not in it. So text moved
to those homes whose tokens occur nowhere else in the corpus would need ALLOW lines, and the brief admits ALLOW lines only for superseded
history. **Resolution:** every compression below is chosen so that each fact token it removes still occurs in `CLAUDE.md` or `LEDGER.md`
(verified by the audit, not assumed); detail that leaves the paths-forward table is checked against `plans/FRONTIER-STUBS.md`'s row
(authoritative, a superset) and appended there where it is not. ALLOW lines only for genuinely superseded history, each listed below.

## Stage 1 — SAVED (the survey)

Section sizes at launch (from the audit): Where the problem stands 23,656; Paths forward 23,353; Grokkings 169,409; Toolchain 9,575;
Building 15,214; Make the gate fail 19,800; The mission 8,287. Tools used for the survey (scratch, not of record): a per-block and
per-sentence count of fact tokens that occur nowhere else in the corpus, and a token diff of each paths-forward row against its
`plans/FRONTIER-STUBS.md` row (all 44 rows: the authoritative row holds every fact token of ours but a handful of pointers, listed in batch 1).

| # | candidate | section | bytes now | what moves or shrinks, and where it goes | est. saving | risk |
|---|---|---|---|---|---|---|
| C1 | paths-forward rows 1–15, 22, 27, 29, 30, 43–45 | Paths forward | 12,391 | cut to the question's first clause, the live status and the bearing's first clause; the full rows are `plans/FRONTIER-STUBS.md`'s (authoritative, token-checked superset); any clause missing there is appended to its row | 5,500 | low — summaries of stubs, no reasoning; precedent FS-86's close |
| C2 | the "Ranked stubs" intro | Paths forward | 704 | the re-rank narrative is history (current-state-only); keep the pointer and the solver-column sentence | 450 | low |
| C3 | "Open milestones" + the "Last updated" line | Frontier | 3,936 | the two retell the same closes; the Last-updated line keeps each close's verdict and §R-close; Open milestones keeps FS-84 and the closed milestones' derivation files and stub banners as addresses | 1,000 | low — addresses kept |
| C4 | Frontier items 3, 10–12, 14, 15, 17, 18, 20, 23–28 | Where the problem stands | 9,975 | retellings of ledger rows and grokkings cut to the item's claim and its pointers (header rule: this section orients and points, never retells); each dropped clause checked present in its row or grokking | 4,000 | low-medium — orientation text; checked clause by clause |
| C5 | the target paragraph's exposed-prediction list | The mission | 2,044 | the list retells items 10, 12, 14; keep Kooshi's words verbatim and the three consequences, point for the fields | 450 | medium — Kooshi's statement; his quotation untouched |
| C6 | the 13 retold runs of `--dupes` | Frontier, grokkings | 910 (second tellings) | each fact keeps one home, the other telling points | 500 | low |
| C7 | G72's count tally (first … eleventh) | Grokkings | ~2,100 | the running totals ("four of four", "five of five" …) are superseded by the current total; each count's verdict and address kept in one terse list | 700 | medium — the killing test's data; every verdict kept |
| C8 | G21, G49, G50 instance lists | Grokkings | ~5,000 of 11,900 | older instances cut to their lesson and address, every unique number kept | 1,200 | medium — the brief names these; rules and sharp examples kept |
| C9 | the grokkings intro's bold reframe paragraph | Grokkings | ~1,100 | its FS-70 instance is told in full in `WORKFLOW.md` 3.1 | 350 | medium — kept as the in-context instruction |
|   | **sum** | | **~38,000 touched** | | **~14,150** | |

Not touched, and why: the two `[PROTECTED]` paragraphs; every status tag, *Do* line, killing test and demotion record; the header's
budget history (Kooshi's own text, "the warning"); the prior-art position (the attribution home, which must stay in context against
misclaims — G49); the method sections of § Toolchain, § Building and § "Make the gate fail" (scars whose reasoning the budget rule protects);
the body of every non-method grokking (reasoning; a token-level survey showed most grokking sentences have no unique tokens, which measures
cross-referencing, not redundancy).

**The estimate reaches ~14,000; the 15,000 floor needs C1–C9 all to land near estimate, and 20,000 is out of reach without trimming
reasoning.** Batches in order of risk: C1+C2 (batch 1), C3+C6 (batch 2), C4 (batches 3–4), C5+C7 (batch 5), C8+C9 (batch 6).
