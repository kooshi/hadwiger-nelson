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

## Stage 2, batch 1 — SAVED (C1 + C2: the paths-forward table)

- Rows 1, 2, 4–8, 10–12, 14, 15, 22, 27, 43–45 cut to the question's first clause, the live status and the bearing's first clause;
  the "Ranked stubs" intro's re-rank narrative (history) replaced by a pointer. Rows 3, 9, 13, 16–21, 23–26, 28–42, 46–59 untouched.
- Every dropped clause was checked against its `plans/FRONTIER-STUBS.md` row (grep, phrase by phrase): present, except FS-59's
  "robust to every level of the tower at 23 (row 75)", which therefore stays in `CLAUDE.md`'s row. FS-17's "ceiling 8" is the
  authoritative row's "χ ∈ {6, 7, 8} (eight in the kernel)". The first trial lost one token, `M1–M3`; it now names the crunch's three
  milestones in the open-milestones paragraph.
- Verdicts: `claude_md_fact_audit.py --base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **13**, exit 0;
  `bib_audit.py` exit 0 ("every cited work resolves"). `LEDGER.md` untouched. ALLOW lines added: none.
- Bytes: 296,413 → **291,789** (−4,624).

## Stage 2, batch 2 — SAVED (C3 + part of C6: the close log, open milestones, one retold run)

- The Last-updated line keeps each close's date, verdict, rows and §R-close address, and points to the Frontier item that states its
  results (items 24–28, § What the kernel holds) instead of retelling them; the per-close lists of grokkings edited (history) are gone
  (git holds them). The open-milestones paragraph keeps FS-84 (open), Next, M63/M62, and for each recent close only the addresses the
  Last-updated line lacks (derivation files, stub banners, the crunch index), with a pointer for the rest.
- G35's gate sentence retold row 57's gap in the words `LEDGER.md` row 57 uses (a `--dupes` run); it now names the gap and points.
  The *Do* line after it is untouched.
- First trial lost `111–115` (split into two ranges); restored as the close's row range.
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **12** (was 13), exit 0; `bib_audit.py` exit 0.
  ALLOW lines added: none.
- Bytes: 291,789 → **290,478** (−1,311; total −5,935).

## Stage 2, batch 3 — SAVED (C4 + C6: Frontier items that retold rows and grokkings)

- Items 1, 3, 8, 11, 14, 15, 17, 18, 24, 26, 27 keep their claim and pointers; the retold mechanism now lives only in its home. Each
  dropped clause was checked in its home: item 8's "`n = 3` the Moser twist, `n = 4` the record … the two below it die by Theorem B" in
  G7 and row 64; item 18's gap-frees-every-pair and prime-by-prime clauses in G68/G69, "refusing targets at 5, 7, 11, 13" in G69, the
  split-prime tower at 2 in row 76 (and FS70-T7), L3 and KR6 in row 78 and FS-77's row; item 24's list of excluded constructions in rows
  91–92 and G76, its two named steps in FS-98's row; item 26's 8/17/22 in G64; item 27's R2 in row 108 and G78, the 43 and real-place
  window facts in row 110; items 11, 15 in G56, G64; item 14's ℚ(√47) bracket in item 10. Item 14's "the conjecture's L ≤ 4 clause
  holds for real quadratic fields" is superseded by item 10's "every real number field" (row 99) and is gone.
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **9** (was 12), exit 0. ALLOW lines: none.
- Bytes: 290,478 → **288,586** (−1,892; total −7,827).

## Stage 2, batch 4 — SAVED (C5, C9, table rows 16–36 second pass, items 4 and 10)

- The exposed predictions have one home, the target paragraph (§ The mission (2)); item 10 keeps the proved range, the ℚ(√11)/ℚ(√23)
  and ℚ(√47) facts and points there; the target's "(2)" points to item 10 for the proved range. Kooshi's quotation and (1), (3) untouched.
- Item 4 points at G31 for the 1581's arity facts and Heule-510's kernel emptiness (G31 states both, with rows 43 and 66).
- Grokkings intro: "each ends with what it makes you do and what would kill it (G67)" → "each ending in G67's form" (a `--dupes` run);
  the FS-70 instance stays (its names G16/G32's, G40's are in no other corpus text — the first trial lost them and was reverted).
- Table rows 16, 23, 29, 31, 34, 36: provenance and restated-bearing clauses dropped; each is in its `plans/FRONTIER-STUBS.md` row.
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **8**, exit 0; `bib_audit.py` exit 0.
  ALLOW lines: none.
- Bytes: 288,586 → **287,833** (−753; total −8,580).

## Stage 2, batch 5 — SAVED (C7: G72's count; items 12, 13, 16, 20, 21, 28)

- G72's count: the running totals ("four of four" … "ten of ten") are superseded by the current one; the count is now one list headed
  "eleven of eleven", every close's verdict, address and Kooshi's ruling ("yes", no-gos count, 2026-09-24) kept word for word where they
  were facts. The ordinal labels Tenth and Eleventh are kept as labels (the first trial dropped them and failed on two name tokens).
  G72's *Do* and killing test untouched.
- Items 12, 13, 16, 20, 21, 28 keep claim and pointers; checked in their homes: item 12's escape through an integrality gap in G59/G43;
  item 13's blow-up and `G27` in G60 and row 71; item 16's discriminant form and commensurate-periodic step in G62; item 20's polytope and
  density in G71; item 21's four formats in G73; item 28's criterion (`E_k(G)`, the improper part of `K_k^G`) in row 114 and its mixing
  half in G54.
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **8**, exit 0; `bib_audit.py` exit 0.
  ALLOW lines: none.
- Bytes: 287,833 → **286,556** (−1,277; total −9,857).

## Stage 2, batch 6 — SAVED (the prior-art position's Ours list moved to `LEDGER.md`; two retold clauses)

- **Moved, verbatim:** the prior-art position's **Ours** list after Theorems A and B (2,407 bytes: the sieve … Theorem C over the real S2
  fields and its ℚ(√47) form, rows 66–115, with its two unread-prior-art caveats) to a new `LEDGER.md` section before § A, "The claim list —
  what is ours beyond Theorems A and B (moved from `CLAUDE.md` § The prior-art position, 2026-09-26)". `CLAUDE.md` keeps the lineage
  sentence, Theorem A's form, Theorem B's kernel proof with `[Fischer1994]`'s value and the five questions, every kernel certificate, a
  pointer, and the whole **Not ours** list (kept in context against misclaims). *Reason for the home:* `LEDGER.md`'s own header puts
  "numbers, certificates, names and addresses HERE"; the list names results by row. *Held for the owner:* the brief's touch list says
  `LEDGER.md` receives "moved mechanism text"; this is a claim list, not mechanism — one commit to revert if the owner wants it back.
- § Publication's parenthetical retold G49's account of why `[Fischer1994]` hid (G49 holds it); now "G49's mechanism once more".
  FS-69's row: "FS-66's instrument is priced at 84 GPU-days there" is G66's (which holds the 84 GPU-days); now "a smaller relaxation than FS-66's".
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **8**, exit 0; `bib_audit.py` exit 0;
  `fs71_ledger_b_check.py --strict` **RESULT: PASS**, exit 0. ALLOW lines: none.
- Bytes: `CLAUDE.md` 286,556 → **284,055** (−2,501; total −12,358); `LEDGER.md` 357,110 → 359,928.

## Stage 2, batch 7 — SAVED (triple-told census; item 2; the theory paragraph's retold G48 clause)

- `L21cc6506`'s 4,490-orbit census was told three times (G21, G68, G73); G21 keeps it (its method home), G68 and G73 point.
- Item 2: the spectral refusal from 59 and the certificate at 83 point at G44/G56 and row 68 instead of restating their mechanism.
- The theory paragraph's "where no residue plane is five-colourable" (a `--dupes` run with G48) now points at G48.
- Verdicts: fact audit `--base 2802fd78` **AUDIT PASSED (0 failure(s))**, exit 0; `--dupes` **7**, exit 0; `bib_audit.py` exit 0.
  ALLOW lines: none.
- Bytes: 284,055 → **283,826** (−229; total −12,587).

## Stage 3 — SAVED (the close)

**Final:** `CLAUDE.md` 296,413 → **283,826 bytes** (−12,587, −4.2 %; 16,174 under the 300,000 budget). `LEDGER.md` 357,110 → 359,928
(+2,818, the moved claim list). **The 15,000 floor is not landed**: 12,587 freed. Fact audit `--base 2802fd78`: **AUDIT PASSED (0
failure(s))**, every class LOST 0, PROTECTED regions byte-identical, no dangling pointer. `--dupes` 13 → **7** (the seven left: three in
`LEDGER.md` § B/rows, which this job only receives into; G60's reading and its killing test; G60 vs row 71 and G54 vs row 67, the row
retelling the grokking; the mission's failure rule stated twice by Kooshi's target paragraph). `bib_audit.py` pass; `fs71_ledger_b_check.py
--strict` PASS. **ALLOW lines added: none.** Commits: `1e924220` (stage 1), `179c6c5b`, `7b99ec62`, `2ed5750f`, `c62359f9`, `13b33932`,
`b6d96724`, `17a8602e` (batches 1–7).

**Why the floor was not reached.** The no-loss pool that touches no reasoning measured ~12.6 KB: the paths-forward table (−5,405), the
Frontier items and close log (−6,187), G72's count (−~400), the Ours list's move (−2,501, net of its pointer), a few retold clauses. Every
further candidate surveyed either holds tokens found nowhere else in the corpus (so it needs an ALLOW line the brief does not admit) or
is reasoning or a scar: the method-instance lists in G21, G49, G50 are already one sharp lesson per instance; § Building and § "Make the
gate fail" carry unique pids, counts and file names in every narrative; the grokkings' measured numbers (G31, G56's named fields, G59's
`c` values, G65, G66) are in no ledger row, so the grokking is their only home.

**Options for the remaining ~2,400 bytes (the owner's call):** (a) move G56's named fields (FS-54's enumeration, ~1 KB) and G31's arena
counts (~300 B) into ledger rows, as `LEDGER.md`'s header rule says numbers and names belong there — it thins what the re-grokking reads
in context; (b) compress the incident narratives of § Building's kill-by-PID paragraph and § "Make the gate fail" (~1.5 KB) — scars the
budget rule protects; (c) accept 283,826 (16 KB of headroom, about three closes at their recent size).

**What moved where:**
| from `CLAUDE.md` | to |
|---|---|
| paths-forward rows' detail (rows 1–15, 16, 22, 23, 27, 29, 31, 34–36, 43–45) and the re-rank narrative | already in `plans/FRONTIER-STUBS.md`'s rows (checked phrase by phrase; FS-59's "robust to every level of the tower at 23" kept in `CLAUDE.md`) |
| the Frontier items' retold mechanism (items 1–4, 8, 10–18, 20, 21, 24, 26–28) | the rows and grokkings each item points to (checked clause by clause, batches 3–5) |
| the close log's per-close result summaries; the open-milestones paragraph's retold closes | Frontier items 24–28, § What the kernel holds; the Last-updated line |
| the exposed-prediction list's second telling (item 10) | § The mission, the target paragraph (2) |
| G72's running totals | one "eleven of eleven" list in G72 |
| the prior-art position's **Ours** list after Theorems A and B | `LEDGER.md` § "The claim list", verbatim |

**How to find what moved (five lines):**
1. A paths-forward row's lost detail: its row in `plans/FRONTIER-STUBS.md` (authoritative), then the stub file the row names.
2. A Frontier item's lost mechanism: the rows and G-entries in the item's own parenthesis.
3. A close's results: the Last-updated line names the item (24–28) and the §R-close; the item names the rows.
4. What is ours, row by row: `LEDGER.md` § "The claim list" (before § A); what is not ours stays in `CLAUDE.md`'s prior-art position.
5. Anything else: `git log -p -- CLAUDE.md` from `2802fd78`; this record lists every batch's edits.

**Held for the owner:** the Ours-list move (the brief's touch list says `LEDGER.md` receives "moved mechanism text"; revert `b6d96724` to
undo it); the header's "with a compression pass to follow" is now stale (Kooshi's parenthetical, left for the owner); § Delegation says
"at most three agents at once" while the owner's memory index records Kooshi's 2026-09-25 "Max 4 subagents for now" (not verified here).
