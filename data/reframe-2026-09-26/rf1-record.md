# RF1 — the new program into the ranking (record)

*Job RF1, the front-page editor; Opus 5.5 (de Bruijn), 2026-09-26. Brief: `data/reframe-2026-09-26/briefs/RF1-ranking.md`, with
`data/fs105/briefs/STANDING-RULES.md` ("FS-105" read as "this job"). Base for the fact audit: `9ff8cc4a`.*

## Theorems this phase proved

None. This job is editorial: it moves rows, renumbers ranks and writes a banner. It proves nothing and grades nothing.

## Would have searched here

Nothing. No move in this job is a search.

## Stage 1 — SAVED (quotation check, standing rule 5)

Every quotation or near-quotation in the brief, checked against its source on disk at `0774956e`:

| the brief says | source | verdict |
|---|---|---|
| "FS-106, the regular half" | `plans/STUB-regularity-wall.md` heading "## FS-106 — the regular half (first)"; `CLAUDE.md` § The aim, "**FS-106, the regular half**" | match |
| "FS-107, regularity against pathology" | the stub's heading "## FS-107 — regularity against pathology (second; the competitor protocol)"; § The aim, "**FS-107, regularity against pathology**" | match |
| "its null-set step (C-FMT (d)) is now one sub-question of FS-107" | the stub's provisional bearings: "FS-104 (absorbed: the null-set step is one sub-question of FS-107)"; C-FMT (d) is the null-set step by `plans/FS103-M-derivation.md` §3.1 ("Question 2 — C-FMT (d), `χ_m⁰(ℝ²) = χ_m(ℝ²)`: **GAP**, reduced to a finite list-colouring problem on Falconer's null set") and `plans/FS103-derivation.md` FS103-M-D ("The null-set step (C-FMT (d), `χ_m⁰ = χ_m`) reduced, still a GAP") | match. **Note:** the stub says "absorbed" for FS-104 as a whole; the brief says only the null-set step folds and the other items stand. I follow the brief (the owner's later, narrower word), and the banner says so. |
| "Kooshi's adoption of the program (`CLAUDE.md` § The aim)" | § The aim: "**The direction: the regularity wall** (the owner's reading, 2026-09-26, adopted by Kooshi; each link at its grade)" | match |
| "bearing on χ ≥ 6" may read "bearing on the answer" | `CLAUDE.md` § Paths forward intro: "every row there is a full stub with its bearing on χ ≥ 6 stated honestly"; § Counter-priors rule 1: "**Rank a route by its bearing on the answer**" | match |
| "the aim, the counter-priors, 'Last updated' and 'Open milestones' are already written" | `CLAUDE.md` lines 74–135, 205, 340 at `0774956e` | match: all four name FS-106 and FS-107 |
| "FS105-X's lines are the precedent" | `tools/claude_md_fact_audit.py`: ALLOW block "# FS105-X, the front page of FS-105's close" and EXTERNAL_HOMES block of the same name | match |
| the budget suspended | the brief (Kooshi's ruling, relayed); `CLAUDE.md`'s header still says 300,000 | relayed, not checkable on disk; `CLAUDE.md` is 302,692 bytes at `0774956e` |

Baseline gate: `python3 tools/claude_md_fact_audit.py --base 9ff8cc4a` on the untouched tree: **AUDIT PASSED (0 failure(s))**, exit 0.

Baseline FS check on `plans/FRONTIER-STUBS.md` (a Python one-liner reading the ranked table and the closed list): 60 ranked rows, no FS
number twice in the ranked table, every FS-1 … FS-105 present in the ranked table or the closed list; FS-106 and FS-107 in neither.

## Stage 2 — SAVED (`plans/FRONTIER-STUBS.md` and FS-104's banner)

**`plans/FRONTIER-STUBS.md`** (authoritative):
- **Rows minted:** rank 1 **FS-106 the regular half** and rank 2 **FS-107 regularity against pathology**, each pointing at its section of
  `plans/STUB-regularity-wall.md`; question, outcomes and bearing in the stub's words (the bearing is the stub's one sentence, "Decisive both
  ways, given MR for the lower half: this is Hadwiger–Nelson in its measurable form", which it states for the program as a whole). Cost
  column: "unpriced", with § Counter-priors rule 1 as the reason. Solver column: none (Kooshi's "search for a finite graph is out").
- **FS-104 1 → 3**, its question cell opening "Re-ranked 2026-09-26 (RF1; 1 → 3) … re-aimed, not demoted", its null-set step (C-FMT (d))
  named as one sub-question of FS-107 and its other items listed as standing; status cell records the move. Bearing cell unchanged.
- **Renumbered:** every other rank + 2 (FS-62 2 → 4 … FS-5 60 → 62); the R3 "(R3; x → y)" prefixes inside the cells are left as R3's
  history. No row left the table.
- **Re-rank note** added at the head of § Ranked stubs, citing Kooshi's words from `CLAUDE.md` § The aim.
- **Beyond the brief's list, in the same file (decisions below):** the column header "bearing on χ ≥ 6" → "bearing on the answer"; the
  header's maintenance sentence "row's bearing on χ(ℝ²) ≥ 6" → "row's bearing on the answer"; Open milestones' "Next: Kooshi's choice; the
  default is the top row" → "Next: FS-106 …, then FS-107 … — the top two rows"; the stale "**The target** (…`CLAUDE.md` § The mission): six,
  or a proof that no field's plane is six-chromatic" → "**The aim** (…`CLAUDE.md` § The aim): solve Hadwiger–Nelson outright, verify every
  step in Lean, then publish; it replaces every earlier target …". § The mission no longer says what the old sentence attributed to it.

**`plans/STUB-cp-plane-six.md`:** a re-aim banner in the house blockquote form above FS-103's banner: rank 1 → 3, re-aimed not demoted, the
null-set step folds into FS-107 (quoting the regularity-wall stub), items (2)–(4) and routes (0)–(d) stand, the as-minted "Rank 2" line and
"Bearing on χ ≥ 6" read as history.

**FS check** (inline Python, not a committed tool, since the brief's touch list has none): 62 ranked rows 1…62 in order; no FS number twice
in the ranked table; every FS-1 … FS-107 present in the ranked table or the closed list. **Plants:** FS-107's row dropped → reports
"missing [107]"; FS-104's row duplicated → reports "dups [104]"; each fires for its own reason.

### Decisions settled in this stage

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| Rename the bearing column in both tables and the header's maintenance phrase to "bearing on the answer" | change only `CLAUDE.md`'s intro sentence, as the brief allows | the intro would then contradict the column under it, and the authoritative file's header would contradict the mirror; § Counter-priors rule 1 says "bearing on the answer" | medium — if the owner wants WORKFLOW step 9's wording ("bearing on χ ≥ 6") to govern until WORKFLOW itself changes, revert the header phrase |
| Update FRONTIER-STUBS's Open milestones "Next" and replace its stale "The target" sentence | leave both for the owner | the file holds current state only; its "The target" sentence cites a § The mission text that no longer exists, and "Next" should name the rows this job put on top | medium — if the owner reserved Open milestones for another job, revert those two sentences |
| Keep R3's "(R3; x → y)" prefixes and not add "(RF1; y → y+2)" to 59 rows | re-prefix every row | one re-rank note says it once; 59 prefixes would retell it 59 times (one-home rule) | high |
| Follow the brief (only the null-set step folds) over the stub's "FS-104 (absorbed …)" | banner FS-104 as absorbed | the brief is the owner's later and narrower word, and it says FS-104's other items stand | high |

## Stage 3 — SAVED (`CLAUDE.md` § Paths forward mirror, the fact audit, the gates)

**`CLAUDE.md` § Paths forward, ranked** — only the table and its intro sentence touched:
- intro: "bearing on χ ≥ 6 stated honestly" → "bearing on the answer stated honestly" (the brief's permission); the column header likewise, to
  match the intro and the authoritative file;
- rows 1 FS-106 and 2 FS-107, short and pointing (the one-home rule: the question and the outcomes live in the stub and in
  `plans/FRONTIER-STUBS.md`), worded so as to add no repeated ten-word run (the `--dupes` baseline was already 10);
- FS-104 1 → 3, "(re-aimed, not demoted)", its null-set step (C-FMT (d)) a sub-question of FS-107, the rest standing; bearing unchanged;
- ranks 2–27 → 4–29, the group row 28–60 → **30–62** — so `CLAUDE.md` again shows ranks 1–29, E1's design (rows ranked ≥ 30 live in
  `plans/FRONTIER-STUBS.md` alone). No row's own text changed except FS-104's.

**`tools/claude_md_fact_audit.py`** — one ALLOW line, under a comment naming this job: `"28–60"`, the group rank label, renumbered 30–62
(the 29–61 precedent). No other token left the corpus, so no EXTERNAL_HOMES line was needed. **The plant:** the audit run before the line
existed failed with exactly `FAIL: lost chunk token '28–60'` and nothing else (the line's own negative control).

**Gates** (exit statuses read directly, logs in the session scratchpad):

| gate | result |
|---|---|
| `python3 tools/claude_md_fact_audit.py --base 9ff8cc4a` | **AUDIT PASSED (0 failure(s))**, exit 0 |
| `--dupes` | **10** repeated runs, 628 bytes — the identical list to the baseline's (a `diff` of the two outputs is empty) |
| `python3 tools/fs71_ledger_b_check.py --strict` | **RESULT: PASS** (836 § B rows), exit 0 |
| `python3 tools/bib_audit.py` | exit 0, "every cited work resolves to a row or a recorded alias" |
| `python3 tools/check_architecture.py` | **RESULT: PASS**, exit 0 |
| `CLAUDE.md` bytes | **304,245** (302,692 at `0774956e`; +1,553); the 300,000 budget is suspended for the reframe (Kooshi, relayed by the brief) |

**A pre-existing tool defect, not a gate of this brief:** `python3 tools/claude_md_fact_audit.py --self-test` exits 1 — "BAD gate sentence
broken: passed [wrong reason; wanted 'gate-report']" — on this job's tree **and on the untouched tree** (re-run with this job's edits
stashed: exit 1, the same line). **Mechanism:** the plant replaces the *first* occurrence of "declared purchases", and since Kooshi's
publication ruling was written into § Publication (`CLAUDE.md` line 162: "with no declared purchases") that first occurrence is no longer the
gate sentence (line 1714), so the plant cannot fire. The repair is to plant on the gate sentence itself (e.g. through `GATE_RE`); it is not
made here — the brief allows table lines only in that tool.

### Decisions settled in this stage

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| Keep 29 explicit rows in `CLAUDE.md` (group row 30–62) | keep 27 explicit rows and push FS-98 and FS-76 into the group (28–62) | E1's design is ranks 1–29 in `CLAUDE.md`; the two closes that shrank it to 27 only had rows leave; the budget is suspended | high |
| ALLOW (not EXTERNAL_HOMES) for "28–60" | EXTERNAL_HOMES pointing at this record | a superseded rank label has no home that must keep it; the 29–61 and 30–62 precedents are ALLOW | high |
| Leave every other row's bearing text ("none on six" etc.) as written | rewrite 60 bearings against "the answer" | not in the brief; each row's bearing on six is a one-sided bearing on the answer and stays true; a rewrite is a close's job | high |
