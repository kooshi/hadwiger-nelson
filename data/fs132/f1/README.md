# FS132-F1 — record (the Clerk, Keryx's pen for the front page after the outside release)

Branch `fs132-filing`, worktree `.claude/worktrees/fs132-filing`, from `main` at `c8988444`. Brief `data/fs132/briefs/FS132-F1-front-page.md`.

## Theorems this phase proved

None — a filing job. Every text filed is a lane's draft (sources R, A, P, S) or one of the ruled merges M1–M18; nothing is authored here.

## Stage 1 — SAVED: the readback and the manifest as a table

**Readback.** The brief's quotations checked against their sources: Kooshi's two words (`data/external/EXT-OAI1-request.md`) 2 of 2 present;
Keryx's two workflow sentences (`.claude/output-styles/keryx.md`) 2 of 2 present. Read whole: the brief, `plans/STANDING-RULES.md`, inventory items
619, 620, 625, 627, 628, R § 5.1 and § 5.5, A Stage 7 and Stage 8's filing bullets, P § 4.2, § 4.3, § Draft re-rank, S § 5.1. Worktree created from `main`
(`c8988444`). Reading size: the sources are 116 + 67 + 73 + 59 KB; read by section, the inventory by item, within budget.

**The manifest (target, unit, source address, merge).**

| # | target | unit | source address | merge |
|---|---|---|---|---|
| 1a | `CLAUDE.md` | units 1–10 (row D; links 1, 3, 4, 5, 6; Frontier ¶1 twice; item 31; theory ¶ twice; LG paragraph) | R `plans/EXT-OAI2-reading.md` § 5.1 units 1–10 | M10 in unit 6 |
| 1b | `CLAUDE.md` | § Paths forward table, three ranked rows | P § Draft re-rank, "The top three, as `CLAUDE.md` § Paths forward should carry them" | M9 |
| 1c | `CLAUDE.md` | § Paths forward "Open milestones" paragraph, "Next, in Kooshi's order" … up to "M63" | P § Draft re-rank, "Open milestones, in order" | M7, M8 |
| 1d | `CLAUDE.md` | mission ¶1; row "The upper end"; standard-of-evidence ¶1; Last-updated line; Grades line; "The program" ¶; "G1–G92" | — | M1, M2, M3, M4, M5, M6, M11 |
| 2 | `LEDGER.md` | rows 33 (A (c) then R), 107, 120, 125, 128 (two), 129, 130 (replacement, addition), 131, 132, 140, 154; claim list "Ours", "Not ours" | A Stage 7 (c); R § 5.1 `LEDGER.md` units | — |
| 3 | grokkings `SKILL.md` | G93, G94, G95 after G92; front matter | R § 5.1 "Proposed grokkings" | M12, M13 |
| 4 | `plans/GROKKING-INSTANCES.md` | instances G25, G60, G64, G80, G81, G82, G86, G91; D9 under G92 | R § 5.1 "Instances and amendments"; S D9 | — |
| 5a | `BIBLIOGRAPHY.md` § A | `[OAIMath2026]` cells 3 and 5 | R § 5.5; S D1, D2 | M14, M15, M16 |
| 5b | `BIBLIOGRAPHY.md` § C | sixteen rows from R § 5.5's nine lines | R § 5.5 table "Not held (sixteen)" | — |
| 5c | `BIBLIOGRAPHY.md` § C | `[GreenfeldTao2024]` | S D3 | — |
| 6a | `plans/FRONTIER-STUBS.md` | Open milestones paragraph | P "Open milestones, in order" | M7, M8 |
| 6b | `plans/FRONTIER-STUBS.md` | ranked table ranks 1–12 | P "The ranked table" | M17 |
| 6c | `plans/FRONTIER-STUBS.md` | below rank 12, in P's order; verdict appends | P "Below rank 12"; § 4.2 | M17 |
| 6d | `plans/FRONTIER-STUBS.md` | closed list: FS-44, FS-49, FS-108 | P § 4.3 banners | — |
| 7 | `plans/STUB-*.md` | fourteen banners; D4, D5, D7; two title names | P § 4.3; S D4, D5, D7 | M18 |
| 8 | proof atlas | check, re-point, rebuild | `visualizations/proof-atlas/README.md` | — |

**Units seen to stop already (listed, left unfiled or filed as stated):** see the stops list in the report; first sightings are recorded in each stage below.

## Stage 2 — SAVED: `CLAUDE.md` and `LEDGER.md` (items 1–2)

Script `data/fs132/f1/stage2_claude_ledger.py` (helpers `flib.py`: every old string asserted to occur exactly once, whitespace-tolerant; every draft
extracted from its source by script, nothing retyped); its assertion log `data/fs132/f1/stage2-log.txt`. The assembled open-milestones paragraph
(M7, M8 applied) is `data/fs132/f1/open-milestones-paragraph.txt`, shared by stage 4.

**`CLAUDE.md`** (R `plans/EXT-OAI2-reading.md` § 5.1): units 1 (row D), 2 (link 1, span), 3 (link 3, after "never only how large each is."), 4 (link 4),
5 (link 5, span), 6 (link 6, after its first sentence, with **M10**), 7 (Frontier ¶1, both replacements), 8 (item 31, prefix), 9 (theory ¶, both
replacements), 10 (local–global). **Unit 11 not filed** (as ruled). 1b: P's top-three rows replace the three ranked rows (P `plans/POROS-2026-10-07-after-release.md`
§ Draft re-rank, "The top three …") with **M9** (4–72 | 69). 1c: P's open-milestones paragraph replaces "**Next, in Kooshi's order**" up to "**M63**", with
**M7**, **M8**. Merges used: **M1** (mission ¶1), **M2** (upper-end row), **M3** (standard of evidence ¶1), **M4** (three edits to the Last-updated line),
**M5** (Grades line), **M6** (three edits in "The program"), **M10**, **M9**, **M7**, **M8**. **M11**: the pattern `G1 – G92` (any dash or "to") occurs 0 times in
`CLAUDE.md`, so nothing was changed (the grokkings' "G1 to G92" is in the skill's front matter: M13, stage 3).

**`LEDGER.md`** (R § 5.1; A `plans/EXT-OAI1-audit.md` Stage 7 (c)): row 33 (A's sentence with its italics, then R's sentence, appended at the end of the result cell
after "The colouring is classical; ours is the certificate."); rows 107, 120, 125, 129, 131, 132, 140, 154 (appended at the end of the result cell); row 128
(R's sentence inserted before "**Not claimed:**"; "not found in print (FS103-G:" replaced by the draft's words, the rest of that parenthesis unchanged); row 130
(replacement; the addition placed at the end of the Prior-art sentences, before "**Naming:**"); claim list "Ours" (after "(rows 123–125)") and "Not ours"
(appended as the list's last item, the closing full stop of the previous item turned into "; "). No row added, none renumbered.

**Sizes.** `CLAUDE.md` 52,599 → 55,413 bytes (limit 80,000); grokkings file 170,280 (stage 3 will change it).

**Gates on this stage's tree.** `tools/claude_md_fact_audit.py --base f40d6bda`: exit 1, five lost tokens, saved `data/fs132/f1/audit-stage2.txt` — listed below, **not
allow-listed**. `--dupes`: exit 0 (`data/fs132/f1/dupes-stage2.txt`).

| lost token | the draft unit that removed it | lives elsewhere (own `rg`, outside the audit's join) |
|---|---|---|
| `data/fs129/index/lean-order-corrected.md`, chunk `FS129-L1` | 1c: P's open-milestones paragraph replaces the "Next, in Kooshi's order" sentence that held "from the input FS129-L1 writes (`plans/LEAN-BACKLOG.md`, on `data/fs129/index/lean-order-corrected.md`)" | yes: `plans/LEAN-BACKLOG.md`, `plans/STUB-lean-backlog.md`, `plans/FS129-close-inventory.md`, `plans/FS129-Z2-record.md`, `tools/fs129_l1_backlog.py`, `data/fs129/l1/README.md`, `data/fs129/reports/FS129-L1.md`; `plans/LEAN-BACKLOG.md` is still named by M8's sentence |
| tag `[hand, two minds each]` | R unit 2 (link 1 replaced as a whole item) | yes: `plans/STUB-regularity-wall.md`; the link's new text carries `[hand, two minds]` (row 128) |
| chunk `4–74` | M9 (the table row "4–74 | 71 more" reads "4–72 | 69 more") | yes in unrelated contexts only (`BIBLIOGRAPHY.md`, `plans/FS129-close-inventory.md`, `plans/FS131-E6-derivation.md`); no other file holds this table row |

**Stops so far:** none in `CLAUDE.md` or `LEDGER.md`. **Observations for the coordinator** (not edits): (i) row 130's "Prior art" addition is placed before
"**Naming:**" (the draft says "append to its Prior art"; the cell's last sentence is the Naming one); (ii) R's G93 and unit texts use the grade "[external: …]" while M5
adds "[kernel, outside]" to § Notation — no filed text uses the new word yet; (iii) unit 9's second replacement leaves "…, and given MR χ(F²) = χ(ℝ²), the least k
with a measurable k-colouring …" — the clause "the least k" now follows "χ(F²) = χ(ℝ²)" (filed as drafted).
