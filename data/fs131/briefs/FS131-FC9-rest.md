# Brief FS131-FC9 — the rest of the second filing: the rows the last clerk's budget left, by my rulings

*Written 2026-10-16 04:12 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC9
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for the rest of one filing
  role: the pen for the rows of the second filing that the previous clerk located but did not file — a short list, each with its draft found and my ruling on where it goes
  launch: now, in the worktree the previous clerk used, on a fresh branch; beside you two kernel planners in other worktrees, writing none of these files
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a slot is not found exactly once or a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC9.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FC9.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fc9`, cut from `main` at `e321ec5e3`; no Lean build): `BIBLIOGRAPHY.md`, `LEAN.md`, `ARCHITECTURE.md`, `plans/FS84-SI-D-derivation.md`, `plans/FS100-derivation.md`, `plans/FS136-derivation.md` — each only at the rows named below; your scripts and outputs under `data/fs131/fc9/`; `data/fs131/reports/FS131-FC9.md`. Commit on your branch by explicit path; the coordinator merges it; never push
  budget: about 150k by the harness's count, as guidance; save a stage after the readback, after the filing, and after the checks; hand back at a saved stage before about 250k

Hello. The clerk before you built a table of 109 owed items and filed 53 of them word for word before its budget ran
out; I merged its work. What is left is small and every row of it is already located. You finish it.

## Why this job

The repository is public, and its front files should carry what the lanes drafted. The previous job is logged as item 983
of the inventory, quoted in the next section.

## What is filed

The previous job, as I logged it:

> 983. **FS131-FC8 handed back at stage 4: 53 ready rows filed; merged (logged 2026-10-16 04:11 UTC; "JOB FS131-FC8 — STAGE 4 SAVED"; about 350k by the harness's count — at its line, not to be resumed; branch `fs131-fc8` at `d6b2e925d`; report `data/fs131/reports/FS131-FC8.md`).** Filed word for word by `data/fs131/fc8/file_owed.py`: FS131-PR1's D1–D4, D6, D7, D8; FS131-ER1 § 9.2's `[Davies2026]` cell, the DeCorte line, and the prior-art clauses of rows 121, 123, 128, 129 and row 130's older sentence; row 121's source cell (EN1 § 8.3), row 127 (KN1), the claim list's "Not ours" phrase; `CLOSED-QUESTIONS.md` § 1.7 and § 3; 131 `LEAN.md` bullets from 36 records. It handed back before Amendment 1 reached it (I had not sent the message): the amendment's rows, the 13 bibliography appends and `[Tate1950]`/`[Weil1967]` are left. Its findings: PN1's "Not ours" draft cites ASTRA T2–T5 against its own quoted T3 and T4 (filed as drafted — a statement defect for the asking lane's record, `plans/POROS-2026-10-13-number-field-findings.md` § 2.1 item 6); D3's status (answered: W14 removed it). **My receipts:** the two commits exist; `git merge-tree` clean; the publication guard over all 24 changed files and both messages: 0 refusals; D1 and D2 read in `CLAUDE.md` as PR1 drafted them (D1 keeps the draft's "—;"); one `LEAN.md` bullet traced verbatim to `plans/FS131-KPD1-pontryagin.md`. Merged as `ef39583b2` (`--no-ff`). **Ruling, four parts, on the one fact-audit failure** ("FS100-Q47's" lost from row 121's source cell): *choice* — allow it in `tools/claude_md_fact_audit.py`'s ALLOW with its reason; *alternative* — revert row 121's cell to its old wording — declined: EN1 § 8.3 corrects that wording (four of the eight entries are not inputs of SP-Cor's proof), and `FS100-Q47` is still named twice in the ledger; *why* — a possessive form of a token that survives, superseded by a correction; *confidence* — high. After it: the fact audit against `5af212aca` and against `3c854fc0d` "AUDIT PASSED (0 failure(s))", `--dupes` exit 0, the bibliography audit clean, `CLAUDE.md` 79,411 of 80,000 bytes. **My slip, logged:** I wrote Amendment 1 to disk and did not send its one-line message before the job handed back. **Credited:** the Clerk asked rather than guessed on every one of the 15, and its table is the map of the remainder.
> — source: plans/FS131-close-inventory.md

The table is `data/fs131/fc8/owed.md` (each row's id, draft address and slot), built by `data/fs131/fc8/rows.py`; the
previous clerk's filing script is `data/fs131/fc8/file_owed.py`, and its report `data/fs131/reports/FS131-FC8.md`. My
rulings are the section "Amendment 1" at the end of `data/fs131/briefs/FS131-FC8-second-filing.md`: read it in full;
it is part of this brief. The rows to file, by the table's ids:

1. The amendment's "File" list: **AXIOMS-ARCH** (probe first, then file or report it filed), **LEAN-KN7-A**,
   **ERR-FS84-N1**, **ERR-FS100-Q47**, **FS136-NOTE**.
2. The 13 bibliography reading-status appends the table marks ready (the rows from **BIB-EL-KN7** through
   **BIB-K12A-Ambrus**), each appended to the cell its draft names, word for word.
3. **BIB-Tate-Weil**: one row each for `[Tate1950]` and `[Weil1967]` from KN9's draft (the later of the two drafts),
   placed beside the other rows marked "not held, not read"; the columns the draft leaves empty say "—".

Every other row of the table stays as it is: filed, declined by the amendment, or "no draft".

## Done means

1. **Stage 1 — the readback.** Check the quotation above against its source; restate the rows you will file and, for
   each, its draft's address and its slot as you find it on `main`.
2. **Stage 2 — the filing, by a script** (`data/fs131/fc9/file_rest.py`): it asserts every slot exactly once before it
   writes anything, puts each draft's words in exactly, and prints what it did per row. (A saved stage.)
3. **Stage 3 — the checks**, each with its output under `data/fs131/fc9/`: `python3 tools/claude_md_fact_audit.py --base e321ec5e3`
   (a token reported lost is never allow-listed by you: list it as a `CHECK:`), the same with `--dupes`, and
   `python3 tools/bib_audit.py`.
4. **The report**, in the standing rules' form: per row filed or `CHECK:` with its reason; each check's last lines.

## What is yours to decide

How your script matches a slot and joins a draft to the file's wrapping. Where a draft would make a statement false
against the ledger or the kernel's print, or two drafts touch the same words, write a `CHECK:` and do not choose.
