# Brief FS131-FPA2 — file the prior-art job's drafts that are ruled for now, and the owed bibliography pass

*Written 2026-10-17 00:37 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FPA2
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for one filing — a prior-art job's drafts ruled for now, each at the slot it names, word for word — and a bibliography pass that files what the records already say
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you one kernel planner in another worktree, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft or a rule here is unclear; the report goes to `data/fs131/reports/FS131-FPA2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FPA2.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fpa2` at `d4c2e8b0a`; no Lean build): `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` (§ 1.6 only), `LEDGER.md` (row 71 only); your script `data/fs131/fpa2/file.py` and its outputs beside it; `data/fs131/reports/FS131-FPA2.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. A prior-art search finished an hour ago and drafted the lines that bring the bibliography and two entries up to
what it read. You file the ones ruled for now, exactly as written, and close a small bibliography debt from yesterday.
The last filing of this kind (FS131-FPA1) is a good model: its script is `data/fs131/fpa1/file.py`.

## Why this job

The search's hand-back and my ruling on what is filed now and what waits:

> 1080. **FS131-PAS2 handed back DONE (logged 2026-10-17 00:36 UTC; about 549k by the harness's count — not to be resumed; record `plans/FS131-PAS2-prior-art.md`, report `data/fs131/reports/FS131-PAS2.md`; branch `fs131-pas2` merged).** **C7:** pending `[KubickiLehelMorayne2002]` — not found in print among everything read (124 logged queries); `[Johnson2010]` p. 169 poses it again in 2011 with C7's answer as a guess; `[BauJohnsonNoble2021]` Thm 3.3 is C7's similarity step (fetched and read); drafts in two forms, (A) not in print, (B) in print in part (§ 2.4). **C14:** not found in print (§ 4.3): the upper bound `[Fischer1994]`'s, the lower bound's graph and blow-up `[MatolcsiEtAl2025]`'s read inside the field, and at the Moser ring `sup χ_gf = 4` is `[Ducz2026]` Thm 3.1 with its p. 4 ring remark. **Off-brief:** row 129's plane clause is `[LiSu2026]`'s (filed and pushed, items 1077, 1079). **My receipt:** `[Ducz2026]`'s abstract ("We show that this bound is tight for graphs in the Moser lattice … The same colorings also extend to the entire Moser ring") and Theorem 3.1 read in the held PDF (`~/source/library/pdf/arXiv-2606.12325.pdf`), as the record quotes them. My two leads, checked by it: arXiv:2602.17943 is Istrate–Zara, no bearing; the Haifa record is `[Zaks1989]`. My key `[Johnson2011]` in item 1075 was wrong — the work is `[Johnson2010]` (the 2011 volume's chapter); corrected in place. **Ruling, four parts, on what is filed now:** *Choice:* a Clerk (FS131-FPA2) files § 4.4 items 1–3 (`CLOSED-QUESTIONS.md` § 1.6, row 71, the bibliography lines) and § 2.4 item 4 (C7's bibliography rows, the same in both forms), with item 1054's owed bibliography items, `[Neukirch1999]` and § C rows for the arXiv ids `tools/bib_audit.py` lists. *Held:* § 2.4 items 1–3 (C7's novelty in form A or B, and the period question of draft 2, whose attribution may move with the 2002 paper) until `[KubickiLehelMorayne2002]` is read; C14's novelty line until its module lands. *Alternative:* file C7's form (A) now and correct it later. *Why:* a public "not found in print" that a held lead may overturn is the error items 1076–1079 just corrected. *Confidence:* high. **Routed:** its generalization — every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4` ([derived], one mind, from FS56-T2 and Theorem B; record § 4.2), which carries `[Ducz2026]`'s ring bound to the field — goes into FS131-KFS1's implementer brief (the planner is near its line). **Owed (prior-art debts, title only, for the asking lane or a later search):** Didin–Voronov 2026 (dense colour classes); `[Davies2026]`'s conditional transfer giving `χ(ℝ³) ≥ 7`; `[Zaks1989]` (closed access; `[Johnson2010]` p. 174 names it as where the `ℚ⁴` key "might be found"); C133-CHIF in print (what separates `[LiSu2026]` from `[MatolcsiEtAl2025]` § 2's question). **Credited:** FS131-PAS2, for the Li–Su find, the phrase probes of a withheld summary with a nonsense and a visible-text control, and the two printed questions it answered in passing (held with C7). Running: FS131-KFS1 — 1 slot.
> — source: plans/FS131-close-inventory.md

The bibliography debt it names, from yesterday's filing:

> 1054. **FS131-FPA1 handed back DONE; the prior-art job's ruled drafts filed (logged 2026-10-16 21:24 UTC; about 60k by the harness's count; branch `fs131-fpa1`, merged as `baee3c88d`; report `data/fs131/reports/FS131-FPA1.md`, script `data/fs131/fpa1/file.py`).** Every ruled item filed verbatim at its slot, the script all-or-nothing with a plant seen to fail; row 79, the README's and `RESULTS.md`'s three-colour prior-art lines, `CLOSED-QUESTIONS.md` § 2.4, the FS100-CLS erratum, and `BIBLIOGRAPHY.md`'s updates and seven new rows; `tools/bib_audit.py`: "UNLOGGED PRIOR ART: 6" (16 before), the six being arXiv ids cited only in the job's record. **Its CHECK lines, each settled:** (1) `[Davidson2026]` has a § C row already, read further on 2026-10-13 than the draft says — *kept*, the draft's row not added; owed: its copy path checked against the library's file. (2) `[deGrey2026]` and `[Haugstrup2026]` sit in § R.4 (the paywall list, no copy column); their status cells now read as drafted; owed: moving both rows out of § R.4 now that the issue is held. (3) `[Shimura1964]` has two rows (§ R.4 #17 and § A) — owed: one merged row, at the next bibliography pass. (4)–(5) `[KrebsSankar2024]` and `[Payan1992]` appended as the Clerk did — *kept*. (6) No § B rows for the newly held files — owed with (2) and (3). The FS100-CLS erratum and `[Nagell1969]`'s row point at held lines (row 123, route E) that land with FS131-ICS1 and FS131-IRU1. **Owed, one bibliography pass:** items (1), (2), (3), (6) and the six unlogged arXiv ids.
> — source: plans/FS131-close-inventory.md

## What to file

**Part 1 — the search's drafts, verbatim**, all in `plans/FS131-PAS2-prior-art.md`:
- **§ 4.4, items 1, 2 and 3**: `CLOSED-QUESTIONS.md` § 1.6 (the insertion after its last sentence), `LEDGER.md` row 71 (the
  insertion after the words it names), and the `BIBLIOGRAPHY.md` lines (three status-cell appends and one § C listing row).
- **§ 2.4, item 4**: the `BIBLIOGRAPHY.md` rows and status lines (the same in both of its forms).
- **Do not file** § 2.4 items 1, 2 or 3, § 4.4's "C14's novelty line", or anything in § 3.2 (filed already).

**Part 2 — the bibliography pass.** Each line below is my ruling; file what the named record already says, no more.
1. **`[Davidson2026]`**: check its copy path against the library (`ls ~/source/library/pdf/ | grep -i davidson`); if the
   row's path is wrong or missing, write the file's path; if no file is held, say so in a `CHECK:` line.
2. **`[deGrey2026]` and `[Haugstrup2026]`** (rows 8 and 9 of § R.4, the paywall list): the issue is held, so each moves to
   § A. Write each § A row in § A's columns (key | work | what of ours rests on it | copy | read) from the § R.4 row's own
   cells: the citation as the work; for "what of ours rests on it", the `CLOSED-QUESTIONS.md` entry and the README § 5 line
   that cite it (find them by `grep`); the copy, the held file's path (`ls`); the read status, the § R.4 row's status cell.
   Append both at the end of § A's table, then delete the two § R.4 rows (do not renumber the others).
3. **`[Shimura1964]`**: it has two rows, § R.4 #17 (a request) and § A (the citation). Keep both, so that the request
   stays visible; in the § R.4 row, write the key as a plain reference (`` `[Shimura1964]` ``, not bold), so that the § A row is
   the key's one definition. If `BIBLIOGRAPHY.md` § D gives a different rule for a key both requested and cited, follow § D
   and say so.
4. **§ B rows for newly held files**: for every file in `~/source/library/pdf/` modified on or after 2026-10-16
   (`find -newermt 2026-10-16`) that has no § B row, add one in § B's form (path | key | read status), the key and status taken from
   its § A or § C row; a file with no row anywhere goes in a `CHECK:` line, not into the table.
5. **The keys and arXiv ids `tools/bib_audit.py` lists as unlogged**: for each, a row from what the citing record says
   about it — an arXiv id cited in `plans/FS131-PAS1-prior-art.md` or `plans/FS131-PAS2-prior-art.md` gets a § C listing row (its title and the record's verdict, by that
   record's words); `[Neukirch1999]`, cited in `plans/FS131-KRU1-ring-plan.md`, gets a § A row with what the plan uses it for
   and "not held; cited by the planner, not read here"; arXiv:2602.17943 gets a § C row with FS131-PAS2's verdict
   (Istrate–Zara, no bearing). Any id or key whose record says nothing you could file: a `CHECK:` line.

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fpa2/file.py`): every part-1 slot found exactly once (whitespace-insensitive) before
   anything is written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/bib_audit.py` (every cited key resolves; read its last line — the goal is
   no unlogged prior art); every new row's library path exists (`ls`).
3. **The report**, in the standing rules' form: each item filed with its file and line after filing; each part-2 ruling
   carried out, with what you wrote; any slot that did not match; the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot and where in a table a row goes when this brief does not say. Do not
reword, merge, shorten or reorder a draft. Where you would have to guess, write a `CHECK:` line instead.
