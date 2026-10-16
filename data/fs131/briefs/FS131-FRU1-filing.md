# Brief FS131-FRU1 — file the ring of unit vectors' drafts, with the prior-art line held for it

*Written 2026-10-16 23:37 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FRU1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for the filing of a landing that is already merged: its drafts for the front files, each at the slot it names
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; no other agent is running
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/FS131-FRU1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FRU1.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fru1` at `e3208c425`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (rows 100 and 105, and a new row 168), `ROADMAP.md` (§ 3 only), `LEAN.md`, `plans/POROS-2026-10-13-number-field-findings.md` (§ 3.3 only), `plans/FS131-KCS1-class-plan.md` (§ 2.6's banner only); your script `data/fs131/fcs1/file-fru1.py` and its outputs beside it; `data/fs131/reports/FS131-FRU1.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. The ring of unit vectors landed on `main` a few minutes ago; this filing brings the front files to what the
kernel now holds. The last filing of this kind (FS131-FIF1) is a good model: its script is `data/fs131/fcs1/file-fif1.py`.

## Why this job

The landing, with my rulings on what is filed, by whom, and where the new row goes:

> 1068. **FS131-IRU2 handed back DONE; the ring of unit vectors lands on `main` (logged 2026-10-16 23:37 UTC; about 370k by the harness's count; record `plans/FS131-IRU2-ring.md`, report `data/fs131/reports/FS131-IRU2.md`).** `main` (`2b53bc133`) merged into `fs131-kru1` as `407d720ac`, two gate-input conflicts resolved keeping both sides, no proof or statement conflict; the full gate green on `b261d0f12`: audit 11,743 records (11,043 clean, 575 axiom-free, 120 imported, 5 purchases), vacuity `declarations=22728 refutations-skipped=246 sites=1465`, assumptions' nine counts unchanged (`rests=168`); the merged statement print the union of both gated prints line for line, every record's axioms equal (plants fired). **My receipts:** I printed the axioms of the 13 head statements, the ruled drop and the five models from the gated build myself (`data/fs131/iru2-review/Ax.lean`): all 19 on `[propext, Classical.choice, Quot.sound]`; `main`'s commits after `2b53bc133` touch no gate input (`git diff --stat` over `Proofs/`, `Proofs.lean`, `scripts/` and the package files: empty); the guard over every message and every new blob of `main..fs131-kru1` (26 commits, 241 blobs, gzip decompressed): 0 refusals. **Announcement rule (item 1006/1023's form): met** — merged as `302a57356`, `main` equal to `b261d0f12` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the gated build moved into the main tree (the old one deleted), `build.sh`: all 2186 modules up to date. **Ruling, four parts, on the history rewrite:** *Choice:* no rewrite. *Alternative:* the filter over `main..fs131-kru1`, as the handoff said. *Why:* the branch was cut at `63d88d855` (item 1035, after the 18:30 rewrite), so it carries no pre-rewrite commit; all 26 commits are signed and the guard refuses nothing in the range, so the filter would only have stripped the signatures. *Confidence:* high. **Slips (the coordinator's):** the handoff said this branch "carries pre-rewrite commits" — it never did; and the FS131-IRU2 brief's `touches:` named the build as "the predecessor's gated build of `e849029c3`" (copied from the FS131-IFR2 generator) where it was FS131-IRU1's of `ddb765bac` — caught by the job, nothing depended on it. Its own slip: a short list written to `/tmp` and deleted in the same command (standing rule 2). **Ruling, four parts, on D5:** *Choice:* a new row, **168**, for the components dichotomy, the stable prime's consequence and `L(F) < ∞`. *Alternative:* the same text appended to row 105. *Why:* row 105 is a character lemma; the components clause is a statement about the plane's graph with its own prior-art status ("not yet searched" for the dichotomy), and a row of its own keeps one home for it. *Confidence:* medium. **Filing next, by a Clerk:** from `plans/FS131-IRU2-ring.md` § Stage 4, D1, D2, D3 (with FS131-PAS1 § 5.4 item 1 in row 100's prior-art field), D4, D5 as row 168, D6, D8 (both halves; the density entry's full text to the top of `plans/FILINGS.md`), D9, D10, D11 and the `LEAN.md` § Building line, with one substitution, "<landing>" → "FS131-IRU1". Not D7 (the Proof Atlas rebuild is owed, handoff § 5). **Mine after its merge:** the README row and its section, with FS131-PAS1's § 5.4 item 2 and § 6.4 item 2 (the public-page lines); `RESULTS.md`'s section; `CLAUDE.md`'s "In short:" clause. **Credited:** FS131-IRU2's restricted build copy (`main`'s cone minus the branch's: an unrestricted copy would have put six stale builds over correct ones), its prediction of the 17 rebuilt modules, met exactly, and its catch of my brief's wrong build address. Running: none.
> — source: plans/FS131-close-inventory.md

## What to file

From `plans/FS131-IRU2-ring.md` § Stage 4 — SAVED: the drafts' counts (§ Drafts for the front page, and the `LEAN.md` § Building draft after
it): **D1, D2, D3, D4, D5, D6, D8, D9, D10, D11, and the `LEAN.md` § Building line**, verbatim, each at the slot it names.
Then from `plans/FS131-PAS1-prior-art.md` § 5.4: **item 1**, verbatim, in row 100's **Prior art** field, as D3's last bullet says.

- **Substitutions, inside the filed text only:** "<landing>" → "FS131-IRU1" (in D3 and D4); and in D5, "| FS-131 |" at the
  row's end → "| FS-131 (2026-10-16) |", the ledger's form for its last column.
- **D5** is the new row **168**: its text without the outer quotation marks, prefixed by "| 168 | ", as a new line directly
  after row 167 (the line beginning "| 167 |"), before the blank line and § B.
- **D8** has two halves. The first replaces `CLAUDE.md`'s "Last filed" entry as drafted; the entry it replaces (the density
  form's, from "**the density form of the collapse** (FS131-KFR1, FS131-IFR1, FS131-IFR2, 2026-10-16:" to "no value of
  `χ(ℝ²)` moved.)") goes, in full, to the top of `plans/FILINGS.md` in that file's own form, as its header says and as
  FS131-FIF1 did for the five-colour entry. The second half is the insertion into `plans/KERNEL-HOLDS.md` after the slot it
  names. **Do not** add a clause to `CLAUDE.md`'s "In short:" list: I write that one.
- **Do not file** D7 (the Proof Atlas), FS131-PAS1's § 5.4 item 2 or § 6.4 item 2 (the public-page lines: I write those with
  the README row), or anything in `BIBLIOGRAPHY.md` (its rows are already filed).

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fcs1/file-fru1.py`): every slot found exactly once (whitespace-insensitive) before anything
   is written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/check_architecture.py` (its last line); the fact audit,
   `python3 tools/claude_md_fact_audit.py --base main --also .claude/skills/grokkings/SKILL.md plans/GROKKINGS-RETIRED.md RUNNING.md plans/CLAUDE-MD-HISTORY.md LEAN.md plans/WHERE-THE-PROBLEM-STANDS.md plans/HISTORY-WORKFLOW-3.0.md plans/KERNEL-HOLDS.md plans/FILINGS.md`
   — report every `FAIL` line; superseded counts replaced by the drafts' new counts are expected, anything else is a finding;
   `CLAUDE.md`'s size from the audit's `size:` line; and `--dupes` (its exit status).
3. **The report**, in the standing rules' form: each item filed with its file and line after filing, each substitution
   made (where), any slot that did not match, and the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft. Where you would have to
guess, write a `CHECK:` line in the report instead.
