# WORKFLOW3-X2 — the front page: the closes of FS-116 and FS-121, filed verbatim

*Job X2, the Clerk as Keryx's pen. Brief: `data/workflow3/briefs/X2-front-page.md`. Branch `close-2026-10-03` in the worktree `/home/kooshi/source/lean-dir-close`
(from `main` at de179dd3). Scripts and gate outputs: `data/workflow3/x2/`.*

## Theorems this phase proved

None. A filing job; it proves nothing.

## Would-have-searched-here log (standing rule 5)

None: no search was a candidate move in a filing.

## Fence log (standing rule 8)

No fences in the brief; no touch.

## Stage 1 — SAVED: the readback, the worktree, the manifest

**Readback.** The brief's one quotation (Kooshi, § Why this job, "Please revive your agents with messages, and continue with the milestone.", source
`plans/FS116-close-inventory.md` row 74) occurs once in that file, in row 74, verbatim. The brief's other statements checked against their files: the draft
sections exist at the named addresses (`plans/FS121-Z1-close.md` D1–D11; `plans/FS116-Z2-close.md` D1–D10; `plans/POROS-2026-10-03-close-reread.md` §
Draft re-rank and § Draft for CLAUDE.md § Paths forward); the inventory rulings are items 152–154. The worktree did not exist; created from `main`.

**The manifest, as a table** (merge column: M1 = the placeholders `‹R121-a›…‹R116-d›` to 142–148; M2 = "parked behind FS-125's NO-SAT"; M3 = cards' heading; M4 = escaped pipes).

| # | target | unit | source address | merges |
|---|---|---|---|---|
| 1 | `LEDGER.md` § A | rows 142–144 | `plans/FS121-Z1-close.md` D1 | M1 |
| 1 | `LEDGER.md` § A | rows 145–148 | `plans/FS116-Z2-close.md` D1 | M1 |
| 1 | `LEDGER.md` row 137 | prior-art clause | `plans/FS116-Z2-close.md` D1 "Row 137's prior-art clause" | |
| 2 | `LEDGER.md` § B | 65 lines | `data/fs121/fs121-z1/ledger-b-draft.md` | M1 |
| 2 | `LEDGER.md` § B | 91 lines | `data/fs116/fs116-z2/ledger-b-draft.md` | M1 |
| 2 | `LEDGER.md` § B | FS114-N7-HUB new, FS114-N7-3T replaced | `data/fs116/fs116-z2/ledger-b-fs114.md` | |
| 3 | `CLAUDE.md` | units 1–4, theory clause, theory FS-121 clause, aim link 5 | `plans/FS116-Z2-close.md` D2 | M1, M2 |
| 3 | `CLAUDE.md` | § Paths forward table rows 1–10 + group row; "Next:" clause | `plans/POROS-2026-10-03-close-reread.md` § Draft for CLAUDE.md § Paths forward | M1 |
| 3 | `CLAUDE.md` | "Rows 1–141" → "Rows 1–148" | brief item 3 | |
| 4 | `.claude/skills/grokkings/SKILL.md` | G85 last sentence, G88–G90, G91 | `plans/FS121-Z1-close.md` D4; `plans/FS116-Z2-close.md` D3 | |
| 5 | `plans/GROKKING-INSTANCES.md` | FS-121's and FS-116's instances | D4 / D3 | |
| 6 | `BIBLIOGRAPHY.md` | two rows (FS-121); none (FS-116) | `plans/FS121-Z1-close.md` D5; `plans/FS116-Z2-close.md` D4 | |
| 7 | `data/fs121/claims.md`, `data/fs116/claims.md` | dated sections | D6 / D5 | |
| 8 | five stubs + four cards | banners, bearing lines, cards | D7 / D6, Poros § Draft re-rank items 5–6, § 2.5 | M1, M2, M3 |
| 9 | `plans/FS111-derivation.md` | erratum | `plans/FS121-Z1-close.md` D3 | |
| 10 | `plans/FRONTIER-STUBS.md` | Poros's re-rank, items 1–6 | `plans/POROS-2026-10-03-close-reread.md` § Draft re-rank | M1, M2, M4 |
| 11 | the two close inventories | ticks | `data/fs121/fs121-z1/ticks.md`; `data/fs116/fs116-z1/ticks.md` | |
| 12 | `tools/viz_proof_atlas_facts.py` | nodes | D9 / D8 | M1 |
| 13 | none | search ban untouched | | |

## Stage 2 — SAVED: `LEDGER.md` (items 1–2)

Script `data/workflow3/x2/apply_ledger.py` (each source row found exactly once, each old string found exactly once, else it stops). Filed: rows 142–148 after
row 141 (the rows carried their `‹R…›` placeholders as the first cell, replaced by 142–148, M1 used for each); row 137's prior-art clause (the drafted text's
source line breaks joined to spaces); in § B, FS114-N7-3T's line replaced, FS114-N7-HUB's inserted after FS114-N7-QOPP's, then 65 FS-121 and 91 FS-116 lines
appended after the TC1 lines (M1 used in all of them). FS-121's D1 owes no correction to an existing row. Gate: `python3 tools/fs71_ledger_b_check.py --strict`
exit 0, RESULT: PASS, 1295 theorems, 1295 rows, 0 placeholders (`data/workflow3/x2/ledger-b-check.out`). No `‹` remains in `LEDGER.md`.

## Stage 3 — SAVED: `CLAUDE.md` (item 3)

Script `data/workflow3/x2/apply_claude.py` (each old text found exactly once). Filed: `plans/FS116-Z2-close.md` D2 units 1–4, the theory clause, the
theory FS-121 clause and § The aim's link 5 (7 blocks, each replaced whole; M1 used in all; the drafts' byte counts differ from the live text by 1–2 bytes at
three blocks, trailing newlines; the old text matched exactly once each); M2 used in unit 2 ("parked behind FS-125's NO-SAT"). **Ruling by "main"
(message, this stage):** FS-121's D2 programme-line replacement (`plans/FS121-Z1-close.md` D2, third bullet) is filed on top of FS-116's unit 3, which had not placed it:
"**FS-121, the map step**" → "**FS-121, the map step — closed** (rows 142–144); its successors **FS-126, curved pencils**, **FS-127, lateral extent**,
**FS-128, the six-colour rungs**", so the line now reads "…, **FS-120, the pinch at a junction**, **FS-121, the map step — closed** (rows 142–144); its successors … **FS-128, the six-colour rungs**, **FS-122, the forced pair**…" (the placement the drafts' order gives; the comma after the inserted clause is the only join). Poros's "Next:" clause (`plans/POROS-2026-10-03-close-reread.md`
§ Draft for CLAUDE.md § Paths forward) replaced FS-116's "**Next:** Poros's re-rank (`plans/FRONTIER-STUBS.md`);"; Poros's table rows 1–10 and the group row (11–73) replaced the table's rows 1–10 and the group row; "Rows 1–141" → "Rows 1–148". Size: 72,905 bytes (< 80,000). No `‹` remains.
Fact audit (`--base de616ed9`, `data/workflow3/x2/fact-audit-stage3.out`): exit 1 with 4 failures, all expected before stage 4: `lost chunk token '1–141'` (the
"Rows 1–141" → "Rows 1–148" change the brief orders; to be explained in the final audit) and G88, G90, G91 cited and not yet filed.

## Stage 4 — SAVED: items 4–10

Scripts (each old text found exactly once; each source extracted by pattern from its record): `data/workflow3/x2/apply_g.py` (items 4–5), `apply_stubs.py`
(items 7–9, and the banners, bearing lines and cards of item 8), `apply_frontier.py` (item 10); the bibliography rows by an inline script (below).

- **Item 4**, `.claude/skills/grokkings/SKILL.md`: G85's last sentence rewritten (`plans/FS121-Z1-close.md` D4, "A rewrite of G85's last sentence"); G88, G89, G90 (FS-121's D4)
  and G91 (FS-116's D3), inserted after G87's entry and before the G51 pointer line, the file's last line, in numeric order. Text verbatim, line wraps as drafted. Size 168,727 bytes.
- **Item 5**, `plans/GROKKING-INSTANCES.md`: FS-121's two instances appended to the end of the G21 and G67 sections (a `*FS121-Z1, … :*` source line above each, my only added words;
  the draft's section tag moved into it); FS-116's G21 instance in G21's section; new sections G82, G83, G84, G87 (after G79's, before the `CLAUDE.md` sections, headings from the grokkings' own titles)
  and `` `CLAUDE.md` § Counter-priors `` (before § Delegation, its order in `CLAUDE.md`); the drafts' "(a new section; …)" parentheticals became the source line. Bullet line wraps joined to spaces.
- **Item 6**, `BIBLIOGRAPHY.md`: `[FukunagaTakahashi2014]` and `[FejesToth1973]` as § C rows after `[Federer1969]` (the drafts' form turned into the table's two cells, text verbatim).
  FS-121's third bullet ("not identified … recorded, not read; no row until it is identified") gets no row, as drafted. FS-116's D4: no row. `tools/bib_audit.py` exit 0 (`data/workflow3/x2/bib-audit-stage4.out`).
- **Item 7**: `data/fs121/claims.md` and `data/fs116/claims.md` each gained a section "Notes at the close (2026-10-03; filed by X2 from … D6 / D5; no statement above is edited)" with the draft's bullets verbatim (M1 none needed).
- **Item 8**: banners under the title lines of `plans/STUB-map-step.md` and `plans/STUB-local-exclusion.md` (M1 used); in the map-step banner, **the parking clause there reads "the cover route is parked behind FS-116 (Kooshi's to overturn)", not the
  brief's exact phrase; I read the ruling (inventory item 152) as covering the parking clause wherever filed and wrote "parked behind FS-125's NO-SAT" — see CHECK in the report**; R2's banner under the title of `plans/STUB-stuck-ray.md` (above the R1 banner already there); R2's three bearing lines at the end of § Bearing on the answer of
  `plans/STUB-qfree-ring.md`, `plans/STUB-saturated-local.md`, `plans/STUB-curved-pencils.md` (line wraps joined); the four cards at the end of `STUB-qfree-ring.md` (card 1), `STUB-q-ring.md` (card 2 with its ranking paragraph and table, through "(`plans/STUB-forced-pair.md` l. 42)."),
  `STUB-curved-pencils.md` (card 3), `STUB-top-colour.md` (card 4), each under the ruled heading (M3). FS-121's D8 bearing lines are already in `plans/STUB-local-exclusion.md` and `plans/STUB-route-t-count.md` (written by the close), so owed nothing.
- **Item 9**: the erratum paragraph under FS111-W-NOREP's "Rests on it:" line in `plans/FS111-derivation.md`, original text standing above.
- **Item 10**, `plans/FRONTIER-STUBS.md`: Poros's re-rank paragraph (first paragraph under `## Ranked stubs`; the R1 paragraph stays below it); the open-milestones paragraph (replacing line 28; FS-129 placed after the workflow refinement, unranked, as the draft has it); the 73-row table (equal, row for row, to `data/workflow3/r2/ranked-table.md`; it carries the escaped pipes of FS-41 and FS-65, M4); the closed-list entries for FS-116 and FS-121 above FS-114's (M1, M2); banners as above. Poros's item 7 (the solver column reading) is not in the manifest and is not filed.
- **Gates run at this stage**: `tools/bib_audit.py` exit 0; `python3 tools/claude_md_fact_audit.py --base de616ed9` exit 1 (`fact-audit-stage4.out`): five lost tokens, each explained:
  `1–141` (the ordered "Rows 1–148"); `N7-HUB's`, `R-E2/E2`, `S6` (words of the retired FS-116 row 1 of the ranked table, replaced by its closed-list entry; the row stands in git at de616ed9); `−|S|/(k−1)` (FS-67's row, whose unescaped pipes the brief orders escaped).
  Dangling-pointer failures G88–G91 are gone. `--dupes` exit 0. `python3 data/rerank-2026-09-27/rk_mirror_check.py` exit 1 with the same three failures **on `main` before this filing** (it still expects 29 single rows and a 30–N group row; CLAUDE.md shows 10 and a group row) — a stale check, not caused by this filing; outputs `rk-mirror-stage4.out`.

## Stage 5 — SAVED: items 11–13

- **Item 11**, the close inventories (`data/workflow3/x2/apply_ticks.py`; only rows whose status began "open" changed): `plans/FS121-close-inventory.md` 43 rows ticked from `data/fs121/fs121-z1/ticks.md`,
  items 88 and 89 added (88: this filing; 89: carried by R2, FS-116 inventory items 149–150), 87 left open (Kooshi's); `plans/FS116-close-inventory.md` 69 rows ticked from `data/fs116/fs116-z1/ticks.md`,
  each "part 2" row with its place from `plans/FS116-Z2-close.md` (§ 3.2, § 1.6, § 1.4, D1, D7, D9; the dictionary is in the script), items 131, 135, 136, 140, 142 and 154 with where; **left open:** 129 (Kooshi's: the ban, O7),
  145 (FS-123's opening answers the bends question), 153 (Kooshi). Item 105's "‹R116-…›" became "145–148" (M1).
- **Item 12**, the Proof Atlas (`tools/viz_proof_atlas_facts.py` via `data/workflow3/x2/patch_atlas.py`, layout by `atlas_layout.py`, positions in `atlas_positions.json`): FS-121's D9 (node FS121's text; nodes FS126, FS127, FS128; four edges) and FS-116's D8
  (node LOCALF replaced; nodes GFREE, RINGRULE, YESLIM, FS123, FS124, FS125; six edges); wall7's links; meta built="2026-10-03", job="X2", as_of="FS-116's and FS-121's closes". Edits the drafts did not give, all mechanical and needed to pass the checker:
  (a) FS-121's D9 gives FS126–FS128 as four-argument calls (no source, quote, grade, position): I completed each with the stub's own title question as quote and a phrase of its § Bearing on the answer as grade;
  (b) four D9 edge quotes were not found at their stubs ("curved tangent interfaces", "REG-J′ at LAT", "TOP₆ and NO-PAR-C5", "a fall colouring with a Cantor pinch refutes REG-J′"); replaced by verbatim phrases at the same stubs;
  (c) the re-rank moved ranks and wording: FS-80, FS-59 and FS-44 addresses to `plans/FRONTIER-STUBS.md` rows 14, 20, 13 (CLAUDE.md keeps ten rows) with quotes re-read there, the BASE-V quote ("BASE-V stands beside them …"), FS-115's row 6 → 18 ("stay local positives");
  (d) positions of the nine new nodes by a fixed-seed search on the lint (24 overlaps before, 0 after; FS128 sits near the centre, at r = 167, a lint artefact the owner may wish to move). Not done: the README's step 6 (a stage record in `DESIGN.md`), which is not in the manifest.
  Checker: `checked 206, failed 0, errors 0` (from 187 checked, 8 failed after the re-rank); self-test PASSED; palette review 0 failed; build wrote `visualizations/proof-atlas/index.html` (173,733 bytes). **Keryx republishes the page.**
- **Item 13**: `plans/STANDING-RULES.md` and `CLAUDE.md` § Toolchain untouched (checked: no diff).

## Stage 6 — SAVED: the gates (outputs in `data/workflow3/x2/final-*.out`)

| gate | exit |
|---|---|
| `tools/fs71_ledger_b_check.py --strict` | 0 (1295 rows, PASS) |
| `tools/bib_audit.py` | 0 |
| `tools/claude_md_fact_audit.py --base de616ed9` | **1**: six lost tokens, each explained: `1–141` (the ordered "Rows 1–148"); `N7-HUB's`, `R-E2/E2`, `S6`, `R-E2` (words of the retired FS-116 row 1 in the ranked table, now a closed-list entry; stands in git at de616ed9); `−|S|/(k−1)` (FS-67's row, pipes escaped as the brief orders). No dangling pointers. |
| `tools/claude_md_fact_audit.py --dupes` | 0 |
| `wc -c CLAUDE.md` / grokkings | 72,905 / 168,727 (under 80,000 / 200,000) |
| `data/rerank-2026-09-27/rk_mirror_check.py` | **1**, the same three failures as on `main` before this filing (the check still expects 29 single rows and a "30–N" group row; CLAUDE.md shows ten and a "11–73" row): a stale check, not this filing |
| `tools/check_architecture.py`, `scripts/identities.py check` | 0, 0 |
| `derive_gate.py all` on FS121, FS116, FS114, FS111 derivation files | 0 (PASS, 30 warnings, 25 controls fired) |
| atlas checker / self-test / palette review / build | 0 / 0 / 0 / 0 |
