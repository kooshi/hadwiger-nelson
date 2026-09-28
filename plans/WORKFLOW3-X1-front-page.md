# X1 — the front page: the closes of FS-114 and FS-111 filed verbatim (de Bruijn, front-page lane, 2026-09-28)

*Brief: `data/workflow3/briefs/X1-front-page.md` (commit 0dc62ab0), with `plans/STANDING-RULES.md`. Worktree `/home/kooshi/source/lean-dir-close`,
branch `close-2026-09-28`, created from `main` at 0dc62ab0. Every filing is done by a script under `data/workflow3/x1/` that extracts each draft from
its source by exact text, applies the named corrections and ruled merges as exact replacements (each asserted to occur exactly once), and writes the
target; the scripts are the record of what was changed.*

## Theorems this phase proved

None: this is a filing job. It proves nothing.

## Would-have-searched-here log (standing rule 5)

- Stages 1–5: none. The one scan run (stage 5) placed atlas labels by the lint's overlap count — page layout, not a search for a mathematical object.

## Fence log (standing rule 8)

- None: the brief fences nothing, and no fenced text was met.

## Stage 1 — SAVED: the readback, the worktree, the manifest

### 1.1 Read in full, in order

The brief; `plans/STANDING-RULES.md`; `.claude/output-styles/keryx.md` § A milestone, end to end (step 7); `plans/FS114-C-close.md` § Drafts for the
front page; `plans/FS111-C-close.md` § Drafts for the front page (D1–D10); `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank and § Draft for
CLAUDE.md § Paths forward; `data/workflow3/r1/assemble.py`, `open-unit.md`; `data/fs114/fs114-c/claude_md_units.py`; the two ticks files (heads);
the targets' structure (`LEDGER.md` §§ A–B, `BIBLIOGRAPHY.md` §§ A, A′, C, G, `plans/GROKKING-INSTANCES.md`, `plans/FRONTIER-STUBS.md`, the two
claim lists, the two close inventories, the stubs D8, F2 and F3 edit, `visualizations/proof-atlas/README.md`).

### 1.2 The brief's quotations, checked against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old." | `plans/WORKFLOW3-test-drive.md` row K2 (l. 12) | MATCH, verbatim |
| "a radius uniform in `K` exists iff C-LOCAL holds" | `plans/FS114-derivation.md` l. 289, the statement of FS114-N114-COMPACT ("C114-COMPACT: TRUE at every `K`; a radius uniform in `K` exists iff C-LOCAL holds, and then …") | MATCH, a verbatim substring |

The brief's other statements, checked: Poros's corrections are its § Draft re-rank item 6 (F1, F9, F3, F2, F6) — MATCH; FS-111's § B block has 85 lines —
MATCH (85 lines `| FS111-…` in D1); FS-114's § B block is `data/fs114/fs114-c/ledger-b-draft.md` — 46 lines (the draft's heading says "49 lines", its text
"46 entries"; the file has 46: **a slip in the draft's heading**, nothing to file); FS-114's corrections to rows 134, 135 and FS-111's to rows 130,
131, 133, 136 — MATCH; FS-111's inventory items 38–42 exist, and item 43 (R1 DONE) is "any after"; FS-114's inventory has item 126 (R1 DONE) after 121–125.

### 1.3 The manifest as a table

| # | target | unit | source address | corrections and merges applied |
|---|---|---|---|---|
| 1a | `LEDGER.md` § A | rows 137, 138 (after row 136) | `plans/FS114-C-close.md` § `LEDGER.md` — § A, rows 137–138 | F1 (row 137's bold opening; its "So S–V's Question 2 …" sentence) |
| 1b | `LEDGER.md` § A | rows 139, 140, 141 | `plans/FS111-C-close.md` §D1 § A, three rows | `‹R111-a/b/c›` → 139/140/141 (ruling 3); F9 does not touch row 139 ("‹R111-a›'s own sentence … can stand") |
| 1c | `LEDGER.md` § A | rows 134, 135 corrected | `plans/FS114-C-close.md` § corrections owed, bullets 1–2 | — |
| 1d | `LEDGER.md` § A | rows 130, 131, 133, 136 corrected | `plans/FS111-C-close.md` §D1 "Corrections to existing rows" | ruling 3 in row 133's new text |
| 2a | `LEDGER.md` § B | FS-114's 46 lines after FS-112's | `data/fs114/fs114-c/ledger-b-draft.md` | — |
| 2b | `LEDGER.md` § B | FS-111's 85 lines after FS-114's | `plans/FS111-C-close.md` §D1 § B | ruling 3 |
| 2c | `LEDGER.md` § B | FS112-L60, -N3-BASE, -C-ENDS, -C-PARTNERS, -C-DOUBLE; 29 kernel cells "stub (FS-114)" → "stub (FS-116)" | `plans/FS114-C-close.md` § corrections owed, bullets 3–7 | — |
| 3a | `CLAUDE.md` | units last, prog, i31, g83 (+ G86), g72, rows | `plans/FS114-C-close.md` § `CLAUDE.md` (and `data/fs114/fs114-c/claude_md_units.py --emit`) | F1 (last, prog, i31 ×2, G83); F6 (g72); `‹last›` = 141 |
| 3b | `CLAUDE.md` | FS-111's four clauses at `‹FS-111›` | `plans/FS111-C-close.md` §D2 items 1–4 | F9 (item 4); rulings 1, 2 (full stop; semicolon), ruling "item 31's heading parenthesis", ruling 3 |
| 3c | `CLAUDE.md` | G84, G85 between G83 and G86 | `plans/FS111-C-close.md` §D4 | ruling 3 |
| 3d | `CLAUDE.md` § Paths forward | the ranked rows (29 + the group row) | `plans/POROS-2026-09-28-close-reread.md` § Draft for CLAUDE.md § Paths forward = `data/workflow3/r1/claude-paths-forward.md` (re-assembled and compared) | ruling 3 where present |
| 3e | `CLAUDE.md` | the open-milestones unit (Poros's whole unit) | same § "The 'Open milestones' unit" = `data/workflow3/r1/open-unit.md` | ruling 3 |
| 4 | `plans/GROKKING-INSTANCES.md` | instances under §G21, §G30, §G51, §G67 (new), §G72, §G79, § Make the gate fail | FS-114: § `plans/GROKKING-INSTANCES.md`; FS-111: §D4 "Instances" | — |
| 5 | `BIBLIOGRAPHY.md` | § A rows, § A′ alias, row edits (FS-114); § A amendments and rows, § C rows (FS-111 D5) | FS-114: § `BIBLIOGRAPHY.md`; FS-111: §D5 | — |
| 6a | `data/fs114/claims.md` | § 9 | FS-114: § `data/fs114/claims.md` | F1 (the C114-LOCAL-FR line) |
| 6b | `data/fs111/claims.md` | a dated section at the end | FS-111: §D3 | — |
| 7a | `plans/STUB-global-step.md` | the closed banner under the title | FS-114: § `plans/STUB-global-step.md` | F1 (the banner) |
| 7b | `plans/STUB-reg-scale.md` | the closed banner under the title | FS-111: §D7 | ruling 3 |
| 7c | stubs FS-114, FS-115, FS-104, FS-108, FS-109, FS-113, FS-101 | D8 bearing lines | FS-111: §D8 | — |
| 7d | `plans/STUB-local-exclusion.md`, `plans/STUB-map-step.md` | F3, F2 | Poros § Draft re-rank item 6 | — |
| 8 | `plans/FRONTIER-STUBS.md` | the re-rank paragraph; the ranked table; the open-milestones sentences; two closed-list lines; the FS-115 banner | Poros § Draft re-rank blocks 1–5 (the table = `data/workflow3/r1/ranked-table.md`, re-assembled and compared) | ruling 3 |
| 9 | `plans/FS114-close-inventory.md`, `plans/FS111-close-inventory.md` | the proposed ticks; items 121–126 and 38–43 given their where | `data/fs114/fs114-c/ticks.md`, `data/fs111/fs111-c/ticks.md` | — |
| 10 | `tools/viz_proof_atlas_facts.py` | FS-114's entries and node edits; FS-111's D9 | FS-114: § `tools/viz_proof_atlas_facts.py`; FS-111: §D9 | F1 (LOCALF and its edges), F9 (FS111's text) |
| 11 | `tools/fs111_m3_honey.py`, `tools/fs111_m4_rungs.py`, `tools/fs111_m2_disck7.py` | the output path; the one-line banner | the brief § The manifest item 11 | — |

### 1.4 Held for the coordinator before filing (sent to "main", 22:55 UTC)

The questions are in the message; their answers are logged in stage 2 below as they arrive.
Nine items: Q1 F6's G72 wording; Q2 row 133's kept parenthesis; Q3 D8's STUB-global-step fit; Q4 D8's "add" slots and form; Q5 FS-111's § B
milestone column ("139" or "row 139"); Q6 the bibliography's fit issues (a duplicate key `[AxenovichLiuSagdeev2025]`, a no-op `[Oostema2020]` edit,
prose edits' forms, `[Sirgedas2021]` and the group row's read cells, the § A′ form); Q7 the instances' headers, the G67 section, "Twenty-first";
Q8 the claim-list headings; Q9 findings (F1's conflation in two unlisted texts; LOCALF's own quote; DESIGN.md not in the manifest).

### 1.5 The coordinator's rulings (Amendment 1 to the brief, 2026-09-28 22:53 UTC, `data/workflow3/briefs/X1-front-page.md` on `main`, 7a35a0c8)

Q1: G72's unit filed exactly as the amendment gives it. Q2: option (a), the FS-110 parenthesis kept right after "route M, the map NO (FS-110's
question, then FS-114's)". Q3: my proposal (words moved, none added). Q4: "*At FS-111's close:* …" at the sections I named; FS-104's "## Bearing on
χ ≥ 6". Q5: "row 139" etc. Q6: (a) no § A row for `[AxenovichLiuSagdeev2025]`; (b) the `[Oostema2020]` edit a no-op (its § C row already reads
"373–389"); (c) my separators; (d) `[Sirgedas2021]`'s read cell = the draft's text; the group row "**Held, unread**" → "**Held, partly read**" + the
draft's text; (e) the alias in backtick form. Q7: my header for FS-111's instances; G67's section between G65 and G72; FS-111's G72 instance opens
"Twenty-first, FS-111:". Q8: my headings. Q9: F1's substitution applied to the stub's "At FS-114's close" paragraph ("is the whole NO" → "suffices for
the whole NO") and to the atlas node CVEXISTS; LOCALF re-quoted from the corrected row 137; the README's step 6 skipped and listed as owed.

## Stage 2 — SAVED: `LEDGER.md` (manifest items 1–2)

Script: `data/workflow3/x1/file_ledger.py` (helpers `data/workflow3/x1/common.py`), run once; every text taken from its source by anchors, every
replacement asserted once.

| item | filed | source | corrections / merges used |
|---|---|---|---|
| 1a | rows 137, 138 after row 136 | `plans/FS114-C-close.md` § `LEDGER.md` — § A | F1 pairs 1–2 (row 137's opening, its "So S–V's Question 2" sentence) |
| 1b | rows 139, 140, 141 | `plans/FS111-C-close.md` §D1 § A | ruling 3 (`‹R111-a/b/c›` → 139/140/141) |
| 1c | row 134: the BASE-V clause before its bracket's "]**"; row 135: four replacements and the Not-claimed deletion ("; a chain end at a unit arc bounding one horn only") | FS-114 § corrections, bullets 1–2 | — |
| 1d | rows 130, 131 (Prior art); row 133 (the sentence, Q2 (a)); row 136 (the clause appended to its Not claimed list, "; " before ". **Prior art:**") | FS-111 §D1 "Corrections to existing rows" | ruling 3 in row 133; Amendment 1 Q2 |
| 2a | FS-114's 46 § B lines after FS-112's | `data/fs114/fs114-c/ledger-b-draft.md` | — |
| 2b | FS-111's 85 § B lines after FS-114's | FS-111 §D1 § B | ruling 3; Amendment 1 Q5 ("row 139" …) |
| 2c | FS112-L60 (statement, grade), -N3-BASE (grade), -C-ENDS (statement, grade), -C-PARTNERS, -C-DOUBLE (grades); 29 kernel cells "stub (FS-114)" → "stub (FS-116)", every one an FS-112 line | FS-114 § corrections, bullets 3–7 | — |

**The census:** `python3 tools/fs71_ledger_b_check.py --strict` → **exit 0, "RESULT: PASS", "LEDGER § B rows: 1134 | placeholders: 0"** (1,134 theorems
in 74 files; FS111=85, FS114=46; `data/workflow3/x1/stage2-ledger-check-strict.out`). **Negative control:** FS111-M4-CUT's line removed from a copy
→ exit 1, "FAIL: entry FS111-M4-CUT has no LEDGER.md § B row", "RESULT: FAIL (1)" (`stage2-ledger-check-plant.out`); restored (sha256 identical,
2581…), re-run exit 0. `LEDGER.md`: 493,844 → 541,387 bytes.

## Stage 3 — SAVED: `CLAUDE.md` (manifest item 3)

Script: `data/workflow3/x1/file_claude.py`, run once. FS-114's seven units are read from the close record's `#### <unit>: replace` blocks and
asserted equal to `data/fs114/fs114-c/claude_md_units.py`'s `old`/`new` (they are); each old unit found exactly once. Poros's tables were re-assembled
first in the worktree: `python3 data/workflow3/r1/assemble.py` exit 0 ("ranked rows: 69 (source 66)"; "CLAUDE.md table: 11894 -> 11247 bytes, net -647"),
the outputs byte-identical to the committed `data/workflow3/r1/` files (git shows no change), `--self-test` PASS (both plants refused); the record's
two inline tables equal the two files row for row, and its open unit equals `open-unit.md`.

| unit | filed | corrections and merges used |
|---|---|---|
| last | FS-114's unit | F1 pair 3; FS-111's clause 1 at `‹FS-111›`, ended by a full stop (ruling 1); ruling 3 |
| open | Poros's whole unit (`data/workflow3/r1/open-unit.md`), replacing FS-114's drafted one | ruling 3 |
| prog | FS-114's unit | F1 pair 4; FS-111's clause 3 at `‹FS-111›`, ended by a semicolon (ruling 2); ruling 3 |
| i31 | FS-114's unit | F1 pair 5 (matched across the unit's line break, the break kept) and pair 6; the heading parenthesis as ruled, "(§ The aim; rows 131–141; FS-116, FS-117, FS-120–FS-122)" (its line break kept); FS-111's clause 4 with F9 at the second `‹FS-111›`; ruling 3 |
| g83 | FS-114's unit (G83, G86) | F1 pair 7 on G83; G84 and G85 (FS-111 §D4) between G83 and G86; ruling 3 |
| g72 | the coordinator's line (Amendment 1, Q1), read from `main:data/workflow3/briefs/X1-front-page.md` | F6 as ruled |
| rows | "**Rows 1–141 live in `LEDGER.md`**" | `‹last›` = 141 |
| § Paths forward | Poros's 29 rows and the group row "30–69" (`data/workflow3/r1/claude-paths-forward.md`, CAMEND applied by the script) | — (no placeholder in it) |

**Size:** `wc -c CLAUDE.md` = **293,055** (was 288,911; net +4,144), under 300,000.

**Fact audit** (`python3 tools/claude_md_fact_audit.py --base a9410925`, FS-112's close; `data/workflow3/x1/stage3-fact-audit-a9410925.out`): exit 1,
12 flags, every one caused by the filed drafts, none by the morning's refactor (its three moved tokens print as registered explanations):
- `plans/POROS-2026-09-27-night-aim.md` (code and chunk tokens) and `plans/STUB-unit-arc-half.md`: both lived only in the old open-milestones unit, which
  Poros's unit replaces (NIGHT-A's pointer was FS-115's "waits for FS-114's plan"; FS-112's stub is on the closed list in `plans/FRONTIER-STUBS.md`).
- `plans/STUB-chain-theorem.md`, "588-core's", "D1–D3": FS-45's detailed row, which leaves `CLAUDE.md`'s table for the group row (Poros: "FS-43, FS-45 and
  FS-39 leave the detailed rows for the group row"); the row stands in `plans/FRONTIER-STUBS.md`.
- "Handles": FS-114's old rank-1 row ("Handles: the pinned corner …"), gone with FS-114's close.
- "131–136", "1–136", "30–66": ranges extended by the close (item 31's rows 131–141, the ledger pointer 1–141, the group row 30–69) — the tool's own
  precedents for each.
- G83's status tag "(rows 135–136)" → "(rows 135–138)" (two flags: the lost tag token and the tag change): FS-114's drafted G83.
**Duplicates** (`--dupes`, `stage3-fact-audit-dupes.out`): exit 0; 17 repeated runs against 10 on `main` — the 7 new ones all inside filed drafts:
row 137 retells row 135's map definition; row 139 and FS111-W-HX-PAIRS, row 141 and FS111-M4-LADDER, FS111-W-SQ9 and -W-HEX9, FS111-M2-DISC7 and
-M2-DISCK7 share runs (a row and its § B index line, or two § B lines' grade cells); row 138 and G83 share "two tiles of one colour forced along two unit
circles to come within"; FS112-L60's corrected line and FS114-L60-LE share "a unit arc with constant sides is at most 60°". Filed as drafted; the
retellings are the lanes' to trim, not mine.

## Stage 4 — SAVED: items 4–8

Script: `data/workflow3/x1/file_stage4.py` (its output `stage4-file.out`), run on the untouched targets (a first run was reverted with `git checkout`
and re-run after two formatting fixes: Poros's re-rank paragraph and open-milestones text joined to one line each, the form of every paragraph around
them; no word changed).

| item | target | filed | source | merges / rulings |
|---|---|---|---|---|
| 4 | `plans/GROKKING-INSTANCES.md` | FS-114's four (§G21, §G51, §G72, §G79), each its italic header line, a blank line, its body; FS-111's eight (§G21 ×2, §G30, §G51, §G67, §G72, §G79, § Make the gate fail), each under the header "*FS111-C, FS-111's close (`plans/FS111-C-close.md` §D4):*", the italic paragraph as it stands; the new section "## G67 — A grokking is grokked by its form" between G65 and G72 | FS-114 § `plans/GROKKING-INSTANCES.md`; FS-111 §D4 "Instances" | Amendment 1 Q7 ("Twenty-first, FS-111:"). Placement: each at its section's end, FS-114's before FS-111's; the §G30 one at the end of the section proper, before its "### The tally" subsection; FS-114's §G79 "after FS-110's" lands after FS-112's, which already follows FS-110's |
| 5 | `BIBLIOGRAPHY.md` | § A: FS-114's six rows (`[AxenovichLiuSagdeev2025]` not added, Q6 (a)), then FS-111's three; § A′: `[AHNR2018]` in backtick form (Q6 (e)); § C: FS-111's seven at the table's end; edits: `[Thomassen1999]` read + "; page images not held, OCR only (FS114-CVB)"; `[Polymath16threads]` role + " **FS-114:** …" + ". **FS-111:** …"; `[Bukh2008]` work + "; arXiv:math/0703856v2; Zbl 1169.52005", role + ". **FS-111:** …", copy and read replaced; `[Sirgedas2021]` read = "read: pp. 1–11 and 13 (FS114-Y); its stitch is a seven-colour device"; the group row "**Held, unread**" → "**Held, partly read**" + ". **FS-114:** " + the draft's text | FS-114 § `BIBLIOGRAPHY.md`; FS-111 §D5 | Q6 (a)–(e). `[Oostema2020]`'s edit is a **no-op**: its § C row already reads "373–389" |
| 6a | `data/fs114/claims.md` | "## 9. Corrections at the close (FS114-C, 2026-09-28; `plans/FS114-C-close.md`)" + the draft's bullets | FS-114 § `data/fs114/claims.md` | F1 pair 9 read as its parenthesis: "(C114-LOCAL-F alone is the NO)" → "(C114-LOCAL-F alone suffices)" (the draft's line carries bold, so F1's old string, which has none, matches only in its parenthesis); Q8 |
| 6b | `data/fs111/claims.md` | "## 6. Corrections at the close (FS111-C, 2026-09-28; `plans/FS111-C-close.md` §D3)" + D3's bullets | FS-111 §D3 | Q8 |
| 7a | `plans/STUB-global-step.md` | the closed banner under the title; D8's bearing (Q3: words moved, none added); "(C114-LOCAL-F) is the whole NO" → "(C114-LOCAL-F) suffices for the whole NO" (Q9) | FS-114 § the closed banner; FS-111 §D8 bullet 1 | F1 pair 8; Q3; Q9 |
| 7b | `plans/STUB-reg-scale.md` | D7's banner under the title | FS-111 §D7 | ruling 3 |
| 7c | FS-115, FS-104, FS-108, FS-109, FS-113, FS-101 stubs | "*At FS-111's close:* <D8's text>": inline at the end of the **Provisional bearings** paragraph (FS-115, FS-101); a new last paragraph of "## Bearing on χ ≥ 6" (FS-104), "## Bearing on the answer" (FS-108), "## Provisional bearings" (FS-109, FS-113). D8's last bullet ("Any stub a new grokking bears on") files nothing: it says both are in the lines above | FS-111 §D8 | Q4 |
| 7d | `plans/STUB-local-exclusion.md`, `plans/STUB-map-step.md` | F3's two replacements; F2's sentence after "Rank it by the NO it would add, not by the equivalence." | Poros § Draft re-rank item 6 | F3, F2 |
| 8 | `plans/FRONTIER-STUBS.md` | block 1, the re-rank paragraph, first under "## Ranked stubs"; block 2, the 69 rows under the unchanged header (Poros's header asserted equal to the file's; rows = `data/workflow3/r1/ranked-table.md` = the record's table); block 3, "**None is open.** …(§ Toolchain)." replaced; block 4, the two closed-list lines at its head (one line each); block 5, FS-115's banner under its title (`plans/STUB-stuck-ray.md`) | Poros § Draft re-rank blocks 1–5 | ruling 3 (in blocks 3–4) |

**Gates at this stage:** `python3 tools/bib_audit.py` → **exit 0**, "arXiv ids cited but NOT in the bibliography: 0", "bracketed keys cited but neither
defined nor aliased: 0" (before the filing: exit 1, 8 arXiv ids and 17 keys, all FS-114's and FS-111's); `--self-test` exit 0, "3 controls, ALL FIRED".
`python3 data/rerank-2026-09-27/rk_mirror_check.py` → **exit 0**, "checked 69 ranked stubs; CLAUDE.md single rows 29, group row 30–69", "RESULT: PASS";
`--self-test` exit 0, "SELF-TEST PASS" (every plant fired). Outputs `data/workflow3/x1/stage4-*.out`.

### 1.6 The coordinator's rulings on the atlas (Amendment 2, 23:09 UTC, on `main`)

A1 FS111 graded from its stub's title line; A2 MEET from FS111-C1-UNIF's grade; B GSTEP's and TSMYES's scored registrations dropped; C N3BASE's whole
note = the draft's sentence; D SRAY's words dropped, the three texts left, "bearing reduced to the density form (row 137)" owed to the atlas keeper;
E1–E6 re-quoted as proposed and R134's verifying ring removed; F only the drafted nodes moved; F9's substitution also in `plans/STUB-reg-scale.md`
§ Bearing.

### 1.7 Amendment 3 (23:15 UTC, on `main`)

The atlas self-test's plant "wrong registered p (0.03 → 0.3)" on TSMYES (dropped by ruling B) repointed at SRAY's registered block, "(0.35 → 0.5)";
standing rule 7 lifted for that line only. My 18:08 run of `tools/viz_proof_atlas_facts.py` in the main tree (it rewrote main's
`data/viz/proof-atlas/facts.json`, line numbers only), restored by `git checkout` at 18:09, logged as a disclosed slip.

## Stage 5 — SAVED: items 9–11

**Item 9, the inventories** (`data/workflow3/x1/file_inventories.py`): every item of each ticks file applied as "<tick> (<close job>, `<ticks file>`)",
FS-112's form ("done (FS112-C, ticks.md)"); item 4 of FS-114's, whose status carried a detail, keeps it with the tick after "; ". FS-114: 122 proposed
ticks (items 1–122, incl. the coordinator's 121–122) and items 123–126 given their where; FS-111: 39 (items 1–39, incl. 38–39) and items 40–43 given
their where (40, 123: the prefixed ids and the census at stage 2; 41, 124: TB1 §2.2 and the census re-run; 42, 125: filed at this close, stages 2–5;
43, 126: filed at this close with F1, F9, F3, F2, F6). Every item of both inventories now reads done, declined or carried with its where.

**Item 10, the Proof Atlas** (`file_atlas.py`, `file_atlas2.py`, `file_atlas_layout.py`, `atlas_layout_search.py`):
- Filed: FS-114's block (CVEXISTS, LOCALF, BOWSQ3, PINW, ROUTET, CAPSTRIP and seven edges) with F1 (LOCALF's text; LOCALF's quote and the edge
  CVEXISTS→LOCALF re-quoted from the corrected row 137: "its NO follows from an explicit radius, uniform in the complexity, about a vertex of at least
  four colours within which no such map fragment exists"; the edge LOCALF→UANO: "So one local statement suffices for S–V's Question 2 with unit arcs")
  and Q9 (CVEXISTS's text); FS-114's node edits (GSTEP's text, N3BASE's note and quotes, TSMYES's text); D9 (FS111 and MEET replaced, F9 in FS111's
  text; FS121, FS120, FS122; four edges deleted, six added; route wall7's links and its last two sentences, the text before "the global step (FS-114)"
  kept); Amendment 2's A1, A2, B, C, D, E1–E6; the re-rank's renumbering PF(8)→PF(11), PF(13)→PF(16), PF(7)→PF(10).
- **Layout:** the drafted positions gave 27 lint overlaps; a nearest-first scan over θ ± 30°, r ± 160 inside each node's sector (a label-placement scan,
  not a finite-witness search) moved ten drafted nodes to the nearest overlap-free place: CVEXISTS (20, 560) → (14, 570), LOCALF (22, 525) → (26, 465),
  PINW (48, 575) → (49, 555), ROUTET (62, 560) → (61, 525), CAPSTRIP (119, 440) → (123, 465), FS111 (64, 262) → (65, 262), MEET (38, 240) → (41, 230),
  FS121 (52, 250) → (57, 270), FS120 (70, 280) → (65, 330), FS122 (28, 250) → (29, 275); BOWSQ3 stays at (34, 575). No existing node moved.
- **Results:** `python3 tools/viz_proof_atlas_facts.py` exit 0, "77 nodes, 93 edges, 9 routes", "layout lint: 0 overlaps"; `tools/viz_proof_atlas_check.py`
  exit 0, **"checked 187, failed 0, errors 0"** (before any atlas edit, on the filed tree: 169 checked, 23 failed; on `main`: 2 failed, UNB); `--self-test`
  exit 0, "SELF-TEST PASSED", **all 8 plants "FIRED once"** and the fence control (after Amendment 3's repointed plant); `tools/viz_proof_atlas_contrast.py`
  "palette review: 0 failed", its `--self-test` PASSED; `visualizations/proof-atlas/build.py` exit 0, "wrote visualizations/proof-atlas/index.html,
  164,733 bytes". Headless screenshots (google-chrome, a scratch profile, network refused) in light and dark render; the page header still reads
  "2026-09-27, AFTER FS-112'S CLOSE" (the facts writer's meta) — asked of the coordinator.
- **Owed to the atlas keeper:** the README's step 6 (a DESIGN.md stage record), skipped by ruling; FOURC, SRAY, CHAINB's "bearing reduced to the
  density form (row 137)" (Amendment 2, D). Keryx republishes the page.

**Item 11, the three tool repairs** (standing rule 7 lifted for these by the brief): `tools/fs111_m3_honey.py` and `tools/fs111_m4_rungs.py` now resolve
`OUT` from the file's own location (`import pathlib`; `OUT = str(pathlib.Path(__file__).resolve().parents[1] / "<the same relative path>")`), nothing else
changed. **Before:** from the root exit 0 ("ALL PASS"; "ALL AS EXPECTED"); from `plans/` exit 1, `FileNotFoundError: … 'data/fs111/fs111-m3/honey.out'`
(and `…/rungs.out`) after printing the pass. **After:** exit 0 from the root and from `plans/`, the outputs written at the root path (mtimes 18:04:56,
18:04:58) and byte-identical to the committed ones (git shows no change). `tools/fs111_m2_disck7.py` gains one comment line under the shebang: "# NOTE (X1,
2026-09-28): its HEX check builds a hexagon rotated 30° from its record's lattice; tools/fs111_vm2_disc7.py holds both orientations."; it still exits 0
("ALL PASS"). Outputs `data/workflow3/x1/stage5-fs111_*-{before,after}-{root,plans}.out`.

**Also this stage:** F9's substitution in `plans/STUB-reg-scale.md` § Bearing (Amendment 2). **Slip, disclosed (§1.7):** one run of the facts writer in the
main tree, restored.

### 5.1 Amendment 4 (23:17 UTC): the atlas header

The facts writer's meta now reads built="2026-09-28", job="X1", as_of="FS-114's and FS-111's closes". The page's header line is not read from the meta
but hard-coded in `visualizations/proof-atlas/page.tmpl.html` l. 283, so the ruling's purpose ("a republished page must not say it's current as of
FS-112's close") needed that line too: "the hunt's logic, 2026-09-27, after FS-112's close" → "the hunt's logic, 2026-09-28, after FS-114's and FS-111's
closes" (the ruled words; reported to the coordinator). Rebuilt: facts exit 0 (lint 0), checker "checked 187, failed 0, errors 0", self-test PASSED (8
plants fired once), `build.py` exit 0, index.html 164,752 bytes; "after FS-112's close" no longer appears in it. The About tab's sentence "FS-112's close
answered none: it reduced Sokolov–Voronov's Question 2 with unit arcs to the global step." (l. 987) is left: a statement about FS-112, not a date.

## Stage 6 — SAVED: every gate on the final tree, and the report

Each run in the worktree, its exit status read directly, its output saved as `data/workflow3/x1/stage6-<gate>.out`.

| gate | exit | reads | negative control (this job) |
|---|---|---|---|
| `python3 tools/fs71_ledger_b_check.py --strict` | 0 | "LEDGER § B rows: 1134 \| placeholders: 0", "RESULT: PASS" | stage 2: one FS-111 line removed → exit 1, "RESULT: FAIL (1)" naming it; restored |
| `python3 tools/bib_audit.py` | 0 | 0 arXiv ids and 0 keys unresolved | `--self-test` exit 0, "3 controls, ALL FIRED" (stage 4) |
| `python3 tools/claude_md_fact_audit.py --base a9410925` | 1 | 12 flags, the same 12 as at stage 3, every one explained there (§ Stage 3) | `--self-test` exit 0, "SELF-TEST PASSED" |
| `… --base 6f77a0ed` | 1 | the same 12 flags (the refactor's moved tokens print as registered explanations) | — |
| `… --dupes` | 0 | 17 repeated runs (10 on `main`); the 7 new ones inside filed drafts (§ Stage 3) | the self-test's dupes plant fired (17 → 18) |
| `wc -c CLAUDE.md` | — | **293,055** < 300,000 | — |
| `python3 data/rerank-2026-09-27/rk_mirror_check.py` | 0 | "checked 69 ranked stubs; CLAUDE.md single rows 29, group row 30–69", "RESULT: PASS" | `--self-test` exit 0, "SELF-TEST PASS" (stage 4) |
| `python3 tools/check_architecture.py` | 0 | "RESULT: PASS" | a copy of `ARCHITECTURE.md` with one module row removed → exit 1, "FAIL module coverage" (a first plant, on prose, could not fire and was replaced) |
| `python3 scripts/identities.py check` | 0 | "IDENTITIES: PASS" | `--self-test` exit 0, both plants fail as they must |
| `derive_gate.py all plans/FS114-derivation.md` | 0 | "GATE: PASS (0 failures, 0 warnings)" | `example-dirty.md` exit 1, "GATE: FAIL (49 failures, 9 warnings)"; `example-clean.md` exit 0 |
| `derive_gate.py all plans/FS111-derivation.md` | 0 | "GATE: PASS (0 failures, 1 warning)" — the warning FS-111's own ("FS111-V0-CLOSE: prior art owed — novelty unmeasured; a standing finding") | as above |
| the atlas: facts, checker, build | 0, 0, 0 | lint 0 overlaps; "checked 187, failed 0, errors 0"; index.html 164,752 bytes (the regenerated facts and page byte-identical to the committed ones) | `--self-test` exit 0, 8 plants fired once each, the fence control held; palette `--self-test` PASSED |
