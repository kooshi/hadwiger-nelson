# Brief FS132-F1 — the front page after an outside proof of six became this project's literature: file the lanes' drafts, verbatim, on a branch

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-F1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; this job makes you Keryx's pen for the front page, verbatim, from named drafts
  role: the one front-page filing that follows the outside release `[OAIMath2026]`: four lanes' drafts filed into the files Keryx alone writes, verbatim, on a branch of your own, with the filing's gates
  launch: now; every job whose drafts you file has reported and the coordinator has reviewed each; no landing is in flight
  mission: § Why this job
  statements: none — a filing job; every text it files is a draft named by address in § The manifest, and nothing else is written but the ruled merges listed there
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage with any question mid-flight — and before writing any word the manifest does not give you; the report goes to `data/fs132/reports/FS132-F1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs132/f1/README.md`
  touches: in the worktree `.claude/worktrees/fs132-filing` on branch `fs132-filing` only — `data/fs132/f1/`, `data/fs132/reports/FS132-F1.md`, and the targets of § The manifest: `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `.claude/skills/grokkings/SKILL.md`, `plans/GROKKING-INSTANCES.md`, `plans/FRONTIER-STUBS.md`, `plans/STUB-*.md` (banners, three bearing lines and two title names, as listed), `tools/viz_proof_atlas_facts.py` and `visualizations/proof-atlas/` (re-pointed quotations and the rebuilt page only); **nothing in the main tree, nothing under `/home/kooshi/source/math`, nothing outside this machine**
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Two days ago an outside organisation published a proof, with a Lean formalization, that the plane is not five-colourable.
This project built and audited that Lean, read the manuscript in full, swept the release's other 371 result families, and re-ranked
its whole frontier on it — four jobs, each of which drafted the sentences the front page should now carry. The front page still says
the problem is five, six or seven. Kooshi has made the release literature of this project, and he answered "indeed" when asked whether
the front page should say six or seven and drop "given MR" from the statement that the plane's number is a measurable one. The front
page has one writer, Keryx, who files the lanes' drafts verbatim and authors nothing; this filing is large, so you are the pen, under
the same rule. Your worked example is the last filing of this kind: its brief `data/fs129/briefs/FS129-F1-front-page.md` (with the
amendment at its end, which shows how your stops were ruled then).

## Why this job

Every agent launched from here reads these files to learn where the problem stands, and three of them are about to open milestones
that stand on the release. A front page that contradicts what they are briefed costs each of them a round of doubt. Kooshi's words
(`data/external/EXT-OAI1-request.md`, read whole — it gives the five questions his second message answers; answer 2, "indeed", is
this filing):

> > You may use their proof as any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem.
> — source: data/external/EXT-OAI1-request.md

> > 1. port or import: let's import and adopt parts piecemeal if needed. 2. indeed 3. definitely build on it... write the stub 4. not sure, probably allow, but audit what it does 5. pause the backlog, lets come to a stopping point, collect ourselves and have poros rerank.
> — source: data/external/EXT-OAI1-request.md


Keryx's workflow (`.claude/output-styles/keryx.md` § The filing): "Every draft is written by a lane, and you file it verbatim, so
that you coordinate and do not author." and "When the filing is large, the Clerk is your pen, verbatim, on its own branch in its own
worktree, and its stage commits are merged as one commit (`--no-ff`)." The coordinator's reviews of the four source jobs and its
rulings on them are `plans/FS131-close-inventory.md` items 619, 620, 625, 627 and 628: read those five whole.

**One thing to hold while you file.** The release's two theorems are being imported into this library by another job, and that
import has not landed. So every sentence you file says what is true today: the theorems are the release's, kernel-checked in its own
library and audited here, and **not in this library**. The drafts are written that way. A draft sentence that says otherwise — that
this library holds `6 ≤ χ(ℝ²)`, or names a declaration under `Outside.OAI158` as held — is the import's, not yours: do not file it,
and tell me you saw it.

## Where you work

Create a worktree from `main` and work only there, committing each stage on its branch by explicit path and pushing the branch:
`git -C /home/kooshi/source/lean-dir worktree add -b fs132-filing /home/kooshi/source/lean-dir/.claude/worktrees/fs132-filing main`. If it already exists,
you are resuming: read your record there. No Lean build is needed, so the worktree needs no build directory. Run a tool from the
worktree's root without changing directory in a compound command: `env -C /home/kooshi/source/lean-dir/.claude/worktrees/fs132-filing python3 tools/…`. The
main tree stays untouched; at the end Keryx merges your branch into `main` as one commit. Other jobs are committing to `main` under
`plans/` and `data/` while you work; you do not need their commits, and you do not merge `main` into your branch.

## The manifest

**The sources** (each unit there names its slot — the file, the section, and the exact words it replaces or follows):
- **R** — the manuscript's reading: `plans/EXT-OAI2-reading.md` § 5.1 (drafts for `CLAUDE.md`, `LEDGER.md`, three grokkings and
  eight instances) and § 5.5 (the bibliography).
- **A** — the Lean audit: `plans/EXT-OAI1-audit.md`, Stage 7, unit (c) only (one sentence for `LEDGER.md` row 33). **Not** its Stage
  8's sentences for rows 33 and 130: they are written for after the import lands.
- **P** — the asking lane: `plans/POROS-2026-10-07-after-release.md` § Draft re-rank, § 4.2 (one line per ranked stub) and § 4.3
  (fourteen banners).
- **S** — the sweep of the release's other families: `plans/EXT-OAI3-review.md` § 5.1, drafts D1–D5, D7 and D9. **Not** D6 (declined
  until a later job takes what it is conditional on) and not D8 (it files nothing).

1. **`CLAUDE.md`.**
   (a) R's § 5.1 units 1–10 under its heading for this file, each at its slot. **Not unit 11**: the asking lane's top three replace
   it (R says so itself: "Re-ranking is Poros's").
   (b) P's table "The top three, as `CLAUDE.md` § Paths forward should carry them", in place of the three ranked rows of § Paths
   forward's table.
   (c) P's open-milestones paragraph (under "Open milestones, in order"), in place of the sentences of § Paths forward's
   "**Open milestones.**" paragraph that run from "**Next, in Kooshi's order**" up to, and not including, the sentence that begins
   "**M63**" — with merges M7 and M8 below.
   (d) The ruled merges M1–M6 and M9–M11 below.
2. **`LEDGER.md`.** R's § 5.1 units under its heading for this file: rows 33, 107, 120, 125, 128 (two edits), 129, 130 (a
   replacement and an addition), 131, 132, 140, 154, and the two additions to § The claim list. **Row 33**: A's unit (c) sentence,
   with its italics as drafted, added at the end of the row's result cell (the cell that ends "The colouring is classical; ours is
   the certificate."), and then R's sentence appended to it. No new row; no row renumbered.
3. **`.claude/skills/grokkings/SKILL.md`.** R's three proposed entries G93, G94, G95, after G92, in the form drafted — with merge
   M12 in G95, and M13 in the front matter.
4. **`plans/GROKKING-INSTANCES.md`.** R's eight "Instances and amendments to existing entries" (G25, G60, G64, G80, G81, G82, G86,
   G91) — each as an instance under its entry's heading, in the form of the instances already in that file, opening
   "EXT-OAI2 (2026-10-07):", carrying the draft's words after its dash verbatim, and closing with its source,
   "`plans/EXT-OAI2-reading.md` § 5.1". Where the file has no heading for an entry yet, add one in the form of its neighbours, with
   the entry's title copied from the grokkings file. Then S's D9 under G92, as drafted.
5. **`BIBLIOGRAPHY.md`.**
   (a) § A, the row `[OAIMath2026]` (its cells by the table's column headings, not by number): merges M14–M16 below, which place
   R's § 5.5 sentences and S's D1 and D2.
   (b) § C: R's § 5.5 table "Not held (sixteen)" as rows of § C's table, **one row per key** — sixteen rows from its nine lines. In
   § C's two-column form, as `[GreenfeldTao2024]`'s row there: the item cell is the key in bold, then the work as drafted; the
   verdict cell opens "Cited by `[OAIMath2026]` family 158; **not held, not read.**", then the draft's "what theirs rests on it"
   cell, then, where the draft gives one, "Fetch: " and its fetch cell. Where one draft line holds several keys and one shared cell,
   each key's row carries the part of the work cell that is its own and the shared cells whole.
   (c) § C, the row `[GreenfeldTao2024]`: S's D3.
6. **`plans/FRONTIER-STUBS.md`.**
   (a) § Open milestones, in order: P's open-milestones paragraph, in place of the sentences from "**Next, in Kooshi's order**" to
   the end of that paragraph (but not a sentence beginning "**M63**", if it has one) — with merges M7 and M8.
   (b) § Ranked stubs: P's ranked table. Rank 1 is a new row, as drafted. For ranks 2–12, each row is the row as filed, moved to
   its new rank, with: the bearing cell replaced by P's bearing cell in full; the status cell replaced by P's; and the question cell
   treated as P's cell says — "*as filed*": unchanged; "*as filed, adding:* …": the quoted words appended; "*replaces the first
   sentence:* …": that replacement; a full new question (rank 10): replaced, with the row's name as P gives it. **Ranks 7 and 11**,
   where P's cell says the row is "as filed" with clauses struck: you strike nothing — the question cell stays as filed and gains,
   appended, "2026-10-07 (FS132-P1): " and that stub's verdict and reason from P's § 4.2, verbatim (merge M17). Cost and solver
   cells: as filed unless P's cell gives words.
   (c) Below rank 12: P's order ("Below rank 12, in order"), each row's text as filed. A row whose verdict in P's § 4.2 is anything
   but "unchanged" gains, appended to its status cell, "2026-10-07 (FS132-P1): " and that verdict and reason, verbatim.
   (d) § Closed, absorbed and demoted: FS-44, FS-49 and FS-108 leave the ranked table and enter this list, each as one entry in the
   list's form — the stub's name and path as the ranked row had them, then its banner from P's § 4.3, verbatim.
   Then count: the ranked table holds 72 rows, and every FS number that was in the file is in it once.
7. **Stubs.** P's § 4.3: fourteen banners, each under the title of the stub it names, in the form of the banners already at the
   heads of those files (a block quote opening with the date), verbatim. S's D4, D5 and D7: three bearing lines, each at the slot
   its draft names. And merge M18 (two title names).
8. **The Proof Atlas** (`visualizations/proof-atlas/README.md`, § Updating at a close and § Build, check, publish — **the build
   and the check only; nothing is published**, by Kooshi's standing word). No lane drafted a new node, so you add none. Run its
   checker on your branch after items 1–7: for each quotation that no longer matches because a filed draft changed the sentence it
   quotes, re-point it to the current words of the same fact at its current address, verbatim, and list each change in your record;
   a node whose label, grade or plain text now disagrees with what you filed (row 33's and row 130's nodes, FS-104's, any that says
   five, six or seven) is a `CHECK:` line in your report, not an edit. Set the facts writer's meta to built="2026-10-07",
   job="FS132-F1", as_of="the outside release as literature; FS132-P1's re-rank". Rebuild the page and commit it.

**The merges Keryx has ruled — the only words you may add.** Each is my sentence, about the state of the project or its rules;
none is a statement of mathematics that a lane did not draft.

- **M1** — `CLAUDE.md` § The mission, first paragraph: after "that is not 4-colourable." add " `[OAIMath2026]` (2026) ruled out 5
  (row D below)."
- **M2** — `CLAUDE.md` § The mission, the table's row "**The upper end**": "and a five-colour avoider IS the open upper-bound
  problem" reads "and a six-colour avoider IS the open upper-bound problem (five is excluded: row D)".
- **M3** — `CLAUDE.md` § The standard of evidence above rung B, its first paragraph: "**χ(ℝ²) ≥ 6 would be new mathematics, and a
  reader's default is to disbelieve it**" reads "χ(ℝ²) ≥ 6 is `[OAIMath2026]`'s (2026), kernel-checked in its own library and
  audited here. **Anything this project adds above rung B — seven, a six-colouring, a field's value — would be new mathematics, and
  a reader's default is to disbelieve it**". The words before and after stay.
- **M4** — `CLAUDE.md` § Frontier, the "Last updated" line: "*Last updated: 2026-10-03 — " reads "*Last updated: 2026-10-07 — ";
  and "Last filed: **FS-129, the cross-application audit**, Derived" reads "Last filed: **the outside release `[OAIMath2026]`,
  taken as literature** (Kooshi, 2026-10-07; `plans/EXT-OAI1-audit.md`, `plans/EXT-OAI2-reading.md`; no new row), with FS132-P1's
  re-rank; before it **FS-129, the cross-application audit**, Derived". In the same line "; before it **FS-116, the local
  exclusion**" reads ", and **FS-116, the local exclusion**". The rest of the line stays.
- **M5** — `CLAUDE.md` § Notation, the "**Grades.**" line: after "**[external]** (claimed in the literature, unchecked here);" add
  " **[kernel, outside]** (kernel-checked in an outside library at its own pin, built and audited here; it enters this library as
  a declared outside theorem);" (inventory item 620, ruling (b)).
- **M6** — `CLAUDE.md` § The aim, the paragraph beginning "**The program**": "**FS-128, the top colour, at five and six**" reads
  "**FS-128, the top colour, at six**"; "**FS-120, the pinch at a junction, and the cover route at five**" reads "**FS-120, the
  pinch at a junction**"; and after "**FS-122, the forced pair**;" add " on `[OAIMath2026]`, **FS-132, six by the nerve**, and
  **FS-133, the one-class transfer**;".
- **M7** — in P's open-milestones paragraph, in both files: "**Next: FS-133, the one-class transfer**" reads "**Opened
  2026-10-07: FS-133, the one-class transfer**" (it opened today: `plans/FS133-close-inventory.md`).
- **M8** — in P's open-milestones paragraph, in both files, its last sentence — from "**The Lean backlog (FS-131)** resumes by the
  table" to "wave 10 waits." — reads: "**The Lean backlog (FS-131**, `plans/STUB-lean-backlog.md`; its input
  `plans/LEAN-BACKLOG.md`**)** is paused at Kooshi's word (2026-10-07) and restarts on his word; the asking lane's recommendation
  is the table of `plans/POROS-2026-10-07-after-release.md` § 4.4: the import first, then wave 7, wave 9 restated over the import,
  wave 6's in-flight jobs; wave 10 waits." (The asking lane recommends; Kooshi has not yet said.)
- **M9** — `CLAUDE.md` § Paths forward's table: the row "| 4–74 | 71 more open stubs, in rank order in
  `plans/FRONTIER-STUBS.md` | … | … |" reads "| 4–72 | 69 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |".
- **M10** — `CLAUDE.md` § The aim, link 6, in R's unit 6 as you file it: "that are false under slack at seven" reads "that are
  false under local slack at seven" (inventory item 625: "slack" names two things on these pages).
- **M11** — `CLAUDE.md`: any "G1–G92" that names the grokkings' range reads "G1–G95".
- **M12** — in G95 as you file it: its title's "are false under slack." reads "are false under local slack."; "can be true only
  where no colouring has slack" reads "can be true only where no colouring has local slack"; "plant slack in the hexagonal
  seven-colouring" reads "plant local slack in the hexagonal seven-colouring"; and directly before its "*Do:" add "(*Local slack*
  is freedom to recolour near one vertex; row 132's slack is a forbidden interval of distances everywhere, `[Voronov2023]` Thm 1.1
  — FS132-P1.) ".
- **M13** — the grokkings file's front matter: "entries G1 to G92" reads "entries G1 to G95".
- **M14** — `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s "what of ours rests on it" cell: its last sentence, "The front page's sentences
  change at the filing after wave 8's landing; FS-132 opens on it", is replaced by R's § 5.5 sentence for that cell ("On it rest,
  if filed: …") with the words "if filed" removed, and then S's D2.
- **M15** — the same row's "read" cell: its bold lead "**Family 158: built and audited here; its first half read in full**" reads
  "**Family 158: built and audited here; its manuscript read in full**"; after "(`data/external/oai1/keryx/`)." add "The cone's 70
  modules replayed through `leanchecker` module by module, 70 of 70." (the audit's Stage 8, its first bullet under
  "`BIBLIOGRAPHY.md` and `LEDGER.md`, for filing"); and the sentence that begins "*The manuscript* (EXT-OAI2," and ends "being
  read." is replaced by R's § 5.5 read-status words, from "**Manuscript: read in full**" to
  "(`data/external/oai2/moser_certificate_check.py`)."
- **M16** — the same cell's closing sentence: S's D1, as D1 says.
- **M17** — the appended words of manifest item 6 (b) and (c): the prefix "2026-10-07 (FS132-P1): " before P's own words.
- **M18** — two stub title lines, the name between "— " and ":" only: in `plans/STUB-top-colour.md`, "the top colour, at five and
  six" reads "the top colour, at six"; in `plans/STUB-pinch-at-junction.md`, "the pinch at a junction, and the cover route at
  five" reads "the pinch at a junction". The rest of each title line stays. No other title changes (FS-104's stays; its banner
  carries the change).

Anything else that seems to need a word of yours — a draft whose "replaces" words are not in the target (line breaks apart), two
drafts that land on one sentence, a cell the target's form needs and no draft gives, a "first sentence" whose end is not plain —
**stop on that unit, go on with the others, and send me the list**. A stop is the job working: at the last filing three stops were
each a ruling I owed.

## What is not in this filing (so nobody reads it as forgotten)

The Lean backlog's own drafts — every landed wave's ledger regrades, errata and `LEAN.md` notes, wave 8's among them
(`plans/FS131-L8A-landing.md`, drafts 6, 7 and 10–12) — are a second filing (inventory item 628, ruling (a)). The import's sentences
(the audit's Stage 8; the trust ledger's counts) are filed when it lands. No atlas node for the release or the two new milestones:
no lane has drafted one. `LEAN.md`, `RUNNING.md`, `plans/STANDING-RULES.md`, `plans/SEARCH-QUEUE.md` and the inventories are not
touched.

## Done means

- Every manifest item filed on the branch, each listed in your record with its source address and its target, every ruled merge
  listed where it was used, and every stop listed with the unit left unfiled.
- **The gates, each run in the worktree and read by its own exit status** (standing rule 9), outputs saved under `data/fs132/f1/`:
  - `python3 tools/claude_md_fact_audit.py --base f40d6bda` (the last commit that changed `CLAUDE.md`) and `--dupes`. On `main`
    today both exit 0. A token it reports lost because a filed draft replaced the sentence that held it is **not** allow-listed
    by you: list each with the draft unit that removed it and whether the token still lives in a file the audit does not join
    (your own `rg`), and send me the list — the allow table is mine to rule.
  - `wc -c CLAUDE.md` under 80,000 (it is 52,599 today) and `wc -c .claude/skills/grokkings/SKILL.md` under 200,000 (170,280).
  - `python3 tools/bib_audit.py`. On `main` today it exits 1 with sixteen unlogged keys, fourteen of them the works your § C rows
    add. After your rows, list what is left; I expect `[Author2024]` (a placeholder word in an inventory line, not a citation) and
    any key the reading's body spells differently from its § 5.5 — report those, and add no alias row on your own.
  - `python3 tools/check_architecture.py` and `python3 scripts/identities.py check`: both exit 0 today.
  - the atlas's checker, its self-test and its build, by its README.
  - **Not run**: `data/rerank-2026-09-27/rk_mirror_check.py` (retired; it says so itself).
- A last read of your own diff against this manifest: every hunk is a draft unit or a merge M1–M18.
- The report, in the standing rules' form, naming the branch's last commit, with your `CHECK:` lines first.

## What is yours to decide

The order of the stages; how to apply each draft exactly (a script that asserts each "replaces" string occurs once is better than
hand edits, and its assertions are your evidence); the form of each § C row, each instance and each closed-list entry within the
form their neighbours have. If a draft is wrong — a quotation that does not match its source, a row number that names another
row, a sentence that contradicts the one filed beside it — say so rather than file it: that is a finding, not a refusal, and it
is the part of this job a script cannot do.

## Stages (save each in your record, and commit it on the branch by explicit path; standing rule 2)

1. The readback: the five inventory items, the four sources at their addresses, the worktree; the manifest turned into a table in
   your record (target, unit, source address, merge), with any unit you already see will stop.
2. `CLAUDE.md` and `LEDGER.md` (items 1–2), with the sizes and the fact audit.
3. The grokkings, the instances and the bibliography (items 3–5), with the bibliography audit.
4. `plans/FRONTIER-STUBS.md` and the stubs (items 6–7), with the count of ranked rows.
5. The atlas (item 8).
6. Every gate once more on the branch's last commit, the diff read against the manifest, and the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: delegation is one level deep, because staffing is Kooshi's budget
and the coordinator can review only work it knows exists). Thank you — this is the filing that makes the last two days real for
every mind that comes after.

## Amendment, 2026-10-07 — the coordinator's rulings on your CHECKs (the only further words you may add)

Thank you: every stop was the right one, and the table of lost tokens with where each still lives is what a ruling needs.
`touches:` now also includes `tools/claude_md_fact_audit.py` (its ALLOW table only), `tools/bib_audit.py` (its `NOT_KEYS`
table only) and `BIBLIOGRAPHY.md` § A′. Standing rules unchanged — start no agent of your own (rule 1's reason: staffing is
Kooshi's, and the coordinator reviews only work it knows exists). Work on the same branch, in the same worktree.

**R1 — the fact audit's 21 tokens.** Each was removed by a filed draft or a ruled merge and, by your own `rg`, still lives in
a file the audit does not join. Add one ALLOW entry per token, under a comment line "FS132-F1 (2026-10-07, the coordinator's
amendment R1)", each reason naming the one file your `rg` found that most plainly holds the fact:
- your group (a): "FS132-F1 (M8) replaced the open-milestones sentence; the fact stays in `plans/LEAN-BACKLOG.md`";
- (b): "`[OAIMath2026]` Thm 1.3 replaced link 1's grade for the plane's equality (FS132-F1); the fact stays in
  `plans/STUB-regularity-wall.md`";
- (c): "the group row reads 4–72 since FS132-P1's re-rank (72 ranked rows)";
- (d) and (e): "FS-49 left the ranked table for the closed list (FS132-P1); the fact stays in `<the file>`", and the same with
  FS-108 — but `25's` where it fell with FS-126's bearing takes (f)'s form;
- (f) and (g): "FS132-P1 re-drafted the ranked row; the fact stays in `<the file>`".
A token you find in no file outside the audit's join is not allowed: stop and report it. Re-run the audit and `--dupes`: both
must exit 0.

**R2 — the three stops.**
1. Rank 3, FS-123's solver cell: the filed cell gains, appended, "2026-10-07 (FS132-P1): the placement is the Searcher's."
2. The status-cell appends: make them for **FS-101, FS-96, FS-78, FS-42 and FS-43**, each with its § 4.2 verdict and reason
   verbatim (for a row that shares a line of § 4.2 with others, that line's verdict and reason whole); make none for FS-67,
   FS-64 and FS-63, whose line says nothing of them but "unchanged, given MR".
3. Ranks 7 and 11: the name cells read as the asking lane's table prints them — "**FS-128 the top colour, at six**" and
   "**FS-120 the pinch at a junction**" — keeping whatever follows the name in the filed cell (the stub's path, its
   parenthesis). My manifest's "the row as filed" was too coarse there.

Your judgement calls inside units (FS-80's append; the " — " joins; row 130's placement; the claim list's last item; M14's
comma; the § C rows' place; the split work cells) all stand as you made them.

**R3 — the bibliography audit's four keys.**
- `BIBLIOGRAPHY.md` § A′ (Retired and alternate keys), three lines in that section's form: `[Bekka2008]` is
  `[BekkaHarpeValette2008]` and `[TaoDisintegration2008]` is `[Tao2008ergodicity]`, each "as spelled in the body of
  `plans/EXT-OAI2-reading.md`"; and "arXiv:2008.07987 is `[GwynStavrianos2022]` — its arXiv numbering, which `[OAIMath2026]`
  cites: 'Lemma 2.10 and Theorem 2.11' there are the journal's Lemma 2 and Theorem 2 (`plans/EXT-OAI2-reading.md` § 5.5; the
  two numberings not matched line by line)".
- `tools/bib_audit.py`, `NOT_KEYS`: add `"Author2024": "a placeholder word in an inventory line and in FS132-F1's brief, not a
  citation"`.
Re-run the audit: it must exit 0. If it does not, report what is left and change nothing more.

**R4 — the grade words.** Nothing changes: G93 and G94 keep their brackets as drafted. The new word of § Notation is used by
the two open milestones' claim lists and by the import's rows when it lands.

**R5 — the atlas.** Nothing more from you: the node edits you list are owed to a later job, and your list is its input.

**R6 — the close.** One commit for this amendment, by explicit path, pushed; every gate of § Done means once more on that
commit. Your final message: the commit's hash and each gate's exit status, and anything R1–R3 could not do — nothing else is
needed.

