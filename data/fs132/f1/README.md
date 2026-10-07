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

## Stage 3 — SAVED: the grokkings, the instances and the bibliography (items 3–5)

Script `data/fs132/f1/stage3_grok_bib.py`, log `data/fs132/f1/stage3-log.txt`; every old string asserted once; every draft extracted by script.

- **Grokkings** (R § 5.1 "Proposed grokkings"): G93, G94, G95 inserted after G92 and before the retired G51 pointer, verbatim; **M12** (four edits in G95: title,
  "can be true only where no colouring has local slack", "plant local slack", and the parenthesis before "*Do:"); **M13** (front matter, G1 to G95).
- **Instances** (R § 5.1 "Instances and amendments", S D9): under existing headings G60, G64, G82 (appended); new headings G25 (before G30), G80 and G81 (before G82),
  G86 (before G87), G91 and G92 (before the `CLAUDE.md` sections), titles copied from the grokkings file and cut as the neighbours' are (at the first colon / comma-and);
  each instance reads "EXT-OAI2 (2026-10-07): <the draft's words after its dash> Source: `plans/EXT-OAI2-reading.md` § 5.1." (D9 as drafted, under G92, with its own source
  words). The form "Source: …" follows D9's own draft.
- **`BIBLIOGRAPHY.md` § A** `[OAIMath2026]`: cell "what of ours rests on it" — **M14** (the last sentence replaced by R § 5.5's "On it rest: …" — the words "if filed"
  removed together with their comma — then D2); cell "read" — **M15** (bold lead; the leanchecker sentence after "(`data/external/oai1/keryx/`)."; the "*The manuscript* (EXT-OAI2, …
  being read." sentence replaced by R § 5.5's "**Manuscript: read in full** … (`data/external/oai2/moser_certificate_check.py`).") and **M16** (D1 replaces the closing
  sentence). **§ C**: `[GreenfeldTao2024]` (D3); sixteen new rows from R § 5.5's nine lines, appended after `[FejesToth1973]` (the end of § C's last table), each
  "Cited by `[OAIMath2026]` family 158; **not held, not read.** <rests cell>. Fetch: <fetch cell>"; a full stop added after a rests cell that had none, before "Fetch:".
  Shared cells whole. Work cells split for the shared lines: Crum / Gneiting–Sasvári and the five at the end at their "; "; Zimmer's two titles and Jamneshan's two
  entries by the draft's own words only (`[Jamneshan2026corr]`'s work cell reads "A. Jamneshan, *An uncountable Furstenberg–Zimmer structure theory*, its Corrigendum (2026)");
  the split of the two titles was checked by script (every italic title and number of the new work cells occurs in the draft's work cell).

**Gates.** Fact audit `--base f40d6bda`: exit 1, the same five lost tokens as stage 2 (table there), nothing new from this stage (`audit-stage3.txt`); `--dupes` exit 0;
`CLAUDE.md` 55,413 bytes; grokkings file 173,804 (limit 200,000). `tools/bib_audit.py`: exit 1 (`bib-audit-stage3.txt`); left unlogged after the sixteen rows:
`arXiv:2008.07987` (R § 5.5 names it as `[GwynStavrianos2022]`, held under the other key; first seen in `plans/EXT-OAI2-reading.md`), `[Author2024]` (a placeholder in this
brief, as expected), `[Bekka2008]` and `[TaoDisintegration2008]` (the reading's body spells the keys differently from its § 5.5's `[BekkaHarpeValette2008]` and
`[Tao2008ergodicity]`). No alias row added. "UNLOGGED PRIOR ART: 4" is the count of these four.

**Stops so far:** none in items 3–5. **Observations:** G93's and G94's status brackets read "[external: …]" (as drafted), not the new "[kernel, outside]".

## Stage 4 — SAVED: `plans/FRONTIER-STUBS.md` and the stubs (items 6–7)

Script `data/fs132/f1/stage4_frontier_stubs.py`, log and stops `data/fs132/f1/stage4-log.txt`; every old string asserted once; every draft extracted by script.

- **6a** open-milestones: P's paragraph (M7, M8 applied; the same text as in `CLAUDE.md`, `data/fs132/f1/open-milestones-paragraph.txt`) replaces "**Next, in Kooshi's order**" up to "**M63**".
- **6b** ranked table: rank 1 FS-132 as drafted; ranks 2–12 are the old rows moved, with P's bearing cell and status cell in full; the question cell as P's cell says — rank 2, 3, 5, 9
  "as filed, adding" (the quoted words appended; a full stop added first where the filed cell had none); rank 4, 8, 12 "as filed"; rank 6 the first sentence ("is the singular set of every
  honest saturated colouring of the plane locally finite (C121-REGJ)?") replaced; rank 10 (FS-104) the full new question, the name replaced by P's name (path and minted note kept as filed),
  cost "unpriced" and solver "none" (P's words); ranks 7 and 11 **M17** — nothing struck, "2026-10-07 (FS132-P1): " + P § 4.2's verdict and reason joined by " — " appended to the question cell.
- **6c** below rank 12 in P's order (13–35) and old ranks 38–74 as 36–72; **M17** appended to the status cell for FS-62, FS-39, FS-113, FS-80 (verdict "its five target answered; unchanged
  otherwise", treated as not "unchanged"), FS-59, FS-102 — verdict and reason joined by " — ".
- **6d** FS-44, FS-49, FS-108 entered the closed list (at its head), each "name — path. banner" (P § 4.3, verbatim). **Count: the ranked table holds 72 rows; the set of FS numbers equals the old 74 minus the three plus FS-132; none twice** (asserted by the script).
- **7** fourteen banners, each a block quote directly under the stub's title line (newest first), verbatim; **M18** (two title names); D4 after the paragraph "Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3)" in `STUB-four-colour-inheritance.md`; D5 after the first paragraph of § Provisional bearings in `STUB-mr-in-lean.md`; D7 after the paragraph "Provisional bearings (Poros, 2026-10-07; …)" (the file's lines 8–9) in `STUB-six-by-the-nerve.md`.

**Units left as stated (stops; the unit named, the rest filed).**
1. Rank 3 FS-123, solver cell: P's cell reads "the placement is the Searcher's; otherwise as filed" — a cell that is words plus "as filed"; left as filed.
2. Status-cell appends (M17, "anything but unchanged") **not made** for eight rows whose § 4.2 verdict carries a clause beside "unchanged": FS-101 ("**unchanged** (field rows, given MR); its collapse slot is
   discharged for the plane by the import"), FS-67, FS-96, FS-64, FS-63 ("**unchanged**, given MR", reason "field-level; FS-96's outcome …"), FS-78, FS-42, FS-43 ("**unchanged; consumer closed**", reason
   "each bore …"). The rows are moved to their ranks as filed. Coordinator's call whether they gain the append.
3. Rank 7 FS-128 and rank 11 FS-120: the ranked rows' name cells stay as filed ("at five and six"; "and the cover route at five") — the brief changes only rank 10's name — while M18 shortens the two stub
   titles and P's table prints the shortened names. The rows and the stub titles now disagree.

**Gates.** Fact audit `--base f40d6bda`: exit 1, 21 failures (`audit-stage4.txt`); the five of stage 2 and sixteen more, from this stage's replaced and removed cells, **not allow-listed**:

| lost token(s) | removed by (draft unit) | still lives, by own `rg` outside the audit's join |
|---|---|---|
| `six-colour-research-directions.md`, `six_le_chromaticNumber_plane_of_separated_two`, `μ(2)` | 6d: FS-49's row leaves the ranked table (name, path, banner kept) | yes: `plans/STUB-distance-two-gadget.md`, `plans/POROS-2026-10-03-close-reread.md`, `plans/STUB-chain-theorem.md` and others |
| `J23`, `§ J23`, `Theorem 5`, `FS106-V3's`, `FS114-N2-AVG's`, `25's` (also from FS-126's bearing, rank 12) | 6d: FS-108's row leaves the ranked table (and, for `25's`, P's rank-12 bearing replaces FS-126's) | `§ J23`: only `plans/POROS-2026-10-03-fs129-rerank.md`; `FS106-V3's`, `FS114-N2-AVG's`, `Theorem 5`: `plans/FS110-*`, `plans/FS114-*`, `plans/FS106-*`, `BIBLIOGRAPHY.md`, `plans/FS129-OR1-audit.md`; `J23` and `25's` remain elsewhere in this file's other rows and in `LEDGER.md`, `BIBLIOGRAPHY.md` |
| `62.14`, `j/5`, `m₄(ℝ²)`, `χ_g(H)`, and "external home … lacks chunk token `80's`" (`FS-80's route`) | rank 10: P's full new question and bearing replace FS-104's | yes: `plans/STUB-cp-plane-six.md`, `plans/POROS-2026-10-03-close-reread.md`, `plans/FS129-OR1-audit.md`, `CLOSED-QUESTIONS.md`, `plans/FS103-M-derivation.md` and others |
| `FS112-N3-COR3's` | rank 5: P's bearing replaces FS-122's | yes: `plans/FS114-NB5-verification.md`, `plans/FS112-unit-arc-half.md`, `plans/POROS-2026-10-03-fs129-rerank.md`, `plans/FS131-I5-implementation.md` |

`--dupes` exit 0; `tools/check_architecture.py` exit 0 (`arch-stage4.txt`); `scripts/identities.py check` exit 0 (`identities-stage4.txt`).

## Stage 5 — SAVED: the Proof Atlas (item 8) — checked, re-pointed, rebuilt; nothing published

Run by the README's commands, in the worktree. **Before** (after items 1–7): `tools/viz_proof_atlas_check.py` exit 1, **30 failures** (`atlas-check-before.txt`); of them **two are not
caused by this filing** — MAPS6's node and its edge MAPS6→FS44 fail on `main` too (LEDGER.md row 132's wording changed at FS131-E1; `main`: "checked 212, failed 2").
**Re-pointed** (script `stage5_atlas_repoint.py`, log `stage5-repoint-log.txt`; quote strings, quote addresses and the meta only — no label, plain text, grade fold, route or credence touched):

| node / edge | old quote (address) | new quote (address) |
|---|---|---|
| A7, A6, A5 and the six "half" edges | `χ(ℝ²) ∈ {5, 6, 7}` (CLAUDE.md § Where the problem stands) | `χ(ℝ²) ∈ {6, 7}` (same) |
| LB7; edges R128→LB7, M7→LB7 | `gives χ_m⁰(ℝ²) = 7, hence χ(ℝ²) = 7 given MR` (CLAUDE.md § The aim) | `gives χ(ℝ²) = 7` (same, link 5) |
| M7 | `No — … gives χ_m⁰(ℝ²) = 7` (§ The aim) | `No — … gives χ(ℝ²) = 7` |
| UB6 | `Yes — such a sequence, with six or five colours — gives χ(ℝ²) ≤ 6, or = 5, with no MR` | `Yes — such a sequence with six colours — gives χ(ℝ²) = 6` |
| UB5 | the same old string | `At five the answer is in: the holes stay of density bounded below` (link 5) |
| R130; edge R130→LB7 | `Given MR (row 128): χ(ℝ²) = χ_m⁰(ℝ²)` (LEDGER.md row 130) | `With no hypothesis ([OAIMath2026] Thm 1.3; χ_m⁰ ≤ χ kernel-checked there and audited here, EXT-OAI1): χ(ℝ²) = χ_m⁰(ℝ²)` |
| FS120 | the stub's old title words (`…, and the cover route at five: can a pinch …`) | `the pinch at a junction: can a pinch …` (the stub's title after M18) |
| FS104 node; edges FS104→LB6, R128→LB6 | `is χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6 (row 130)?`, `a YES gives χ(ℝ²) ≥ 6 given MR (row 128)` (CLAUDE.md ranked row 3, which left the top three) | `Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (`plans/STUB-cp-plane-six.md`, its banner) |
| edge FS104→FS44; FS44 node; edge FS44→UB5 | `a NO (a CP five-colouring) gives …`, `the shape of a CP five-colouring …`, `a CP five-colouring of the plane gives χ(ℝ²) = 5 …` (CLAUDE.md row 3; FRONTIER-STUBS item 13, now FS-62) | `a CP five-colouring of the plane does not exist` (`plans/STUB-fifth-colour-structure.md`, its banner) |
| FS44 `words` | `the conjecture's bold form predicts no (G48)` at FRONTIER-STUBS item 13 | the same words at `plans/RERANK-2026-09-27.md` (the ranked row left the table; found by `rg -F`) |
| FS80 (node, `words`, edge FS80→FS104) | FRONTIER-STUBS ranked item 14 | item 19 (the row moved) |
| edge BOWTIE→TSMYES | FRONTIER-STUBS item 19 | item 16 (FS-115 moved) |
| note belief | `…the value-skipping that motivates the belief is itself compatible with five (G64).` | `…the value-skipping that motivated the belief was compatible with five until [OAIMath2026]` (CLAUDE.md § The local–global conjecture) |
| MAPS6 node, edge MAPS6→FS44 (**pre-existing**) | `maps need six modulo Townsend's simplification (c), which …` (LEDGER.md row 132) | `maps need six for arc maps (segments and circular arcs), by [Woodall1973]'s steps 1–6, step 6 repaired by Townsend's lemma`; edge: `maps need six for arc maps (segments and circular arcs)` |
| MAPS6 grade words (**pre-existing**) | `maps-six, Townsend's manuscript and Woodall one mind, the fill in outline` | `maps-six for arc maps one mind (FS131-E1), Woodall's steps 1–3 in outline` (row 132) |

Facts writer's meta set to built="2026-10-07", job="FS132-F1", as_of="the outside release as literature; FS132-P1's re-rank". **After:** `viz_proof_atlas_facts.py` exit 0 ("89 nodes, 106 edges,
9 routes", "layout lint: 0 overlaps"); `viz_proof_atlas_check.py` exit 0 ("checked 212, failed 0, errors 0"); its `--self-test` exit 0 (SELF-TEST PASSED); `viz_proof_atlas_contrast.py` exit 0
("palette review: 0 failed") and its `--self-test` exit 0; `build.py` exit 0 (wrote `visualizations/proof-atlas/index.html`, 175,780 bytes). **Nothing published** (Kooshi's standing word).

**Nodes whose label, grade or plain text now disagrees with what was filed (CHECK, not edited):** A5 (the answer "χ(ℝ²) = 5" stands as a possible answer), LB6 (still the open "$1,000 question",
grade "the exact value inside it remains open"), LB7 and M7 (plain text "given measure rigidity"/"Given MR"), UB5 ("Five colours suffice"), R130 (plain "Given MR, that is Hadwiger–Nelson itself"),
R128, R132, MAPS6 (plain "each repairing the other"; its grade is now one mind), FS104 (a question node still open, with "No held result decides it"), FS44 (a question node "Decisive if it lands"), FS120 (label "… and the cover route at five"),
FS128 (label "at five and six"), FS59 (plain "gives χ(ℝ²) ≥ 6"); routes `five`, `alg5` (a route to five), `cp6`, `win6`, `q167`, `wall7` (their link texts and distances, whose credences were registered before the release) and the credence table.
The page therefore still draws five as a live answer; it is a node edit, owed.
