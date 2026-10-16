# Brief FS131-FPA1 — file the prior-art job's drafts that are ruled for filing now, verbatim

*Written 2026-10-16 21:19 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FPA1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for one filing: the prior-art job's drafts listed below, each at the slot it names, word for word
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you two implementers in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/FS131-FPA1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FPA1.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fpa1` at `a60f9d7c1`; no Lean build): `LEDGER.md` (row 79 only), `README.md`, `RESULTS.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`, `plans/FS100-derivation.md` (one erratum entry under FS100-CLS); your script under `data/fs131/fpa1/`; `data/fs131/reports/FS131-FPA1.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 120k by the harness's count, as guidance; hand back before about 200k

Hello. A prior-art search job finished today, and its record drafts the lines that bring the front files up to what it
found. You file the ones that are ruled for now, exactly as written.

## Why this job

My ruling on which drafts are filed now and which wait:

> 1052. **FS131-PAS1 handed back DONE: the five prior-art searches (logged 2026-10-16 21:19 UTC; about 240k by the harness's count; branch `fs131-pas1`, merged as `b3f73de52`; record `plans/FS131-PAS1-prior-art.md`, report `data/fs131/reports/FS131-PAS1.md`, 144 queries with every hit in `data/fs131/pas1/queries.jsonl`).** S1, the three-colour criterion past row 79's class: not found in print (45 queries); `[Payan1992]` and `[KrebsSankar2024]` Thm 1.2's nontrivial half are corollaries of it. S2, the finite triangle-free six-chromatic unit-distance graph: not found (25 queries); it answers `[deGrey2026]` p. 116 and `[Haugstrup2026]`'s closing question, against de Grey's speculation for ℝ³; the fractional forms not found. S3, CLS: not found as a classification (36 queries); its quadratic "if" half is `[Moorhouse2010]` Thm 8.1 with `[Fischer1990]` Thm 10(i). S4, Lemma C′: not found in general (23 queries); quadratic and multiquadratic cases `[Fischer1990b]`'s, the residue-field piece `[MinacNguyenTan2026]` Thm 3.16; `[Shimura1964]` not read. S5: found, item 1051. Its generalization, graded [derived], one mind: some finite triangle-free unit-distance graph has chromatic number exactly `χ(ℝ²)` (row 128 at ℚ(√635087), which holds no `√3`). **The filing, ruled, four parts.** *Choice:* a Clerk files now §§ 2.4 (all five items), 3.4 item 4, 4.4 items 2 and 4, 5.4 item 3 and 6.4 item 3 — the three-colour criterion's lines (landed, item 1043), every bibliography row and correction, and the FS100-CLS erratum; the rest (§ 3.4 items 1–3, § 4.4 items 1 and 3, § 5.4 items 1–2, § 6.4 items 1–2) is held and filed with the landing whose row it edits (FS131-IFR2, FS131-ICS1, FS131-IRU1). *Alternative weighed:* file everything now — declined: rows 100, 105, 123 and 129 are rewritten by those landings' drafts, written before these verdicts, and one row edited twice in a day invites a lost line. *Why:* one writer per slot, in order. *Confidence:* medium-high. **Logged:** a question for the asking lane — `[Davidson2026]` conjectures three colours for monomial unit-distance Cayley graphs on `ℤ[α]`, `α` algebraic non-integer, which row 79's criterion reduces to one character (its record § 2.2); prior-art debts left: `[Shimura1964]`, `[Nagell1951]` Thm 97's proof, Payan's paper, Rubanov's 2007 and 2013 claims. **Credited:** the job found two published corollaries of our criterion, two published questions our graph answers, and the one statement that was classical.
> — source: plans/FS131-close-inventory.md

## What to file, all in `plans/FS131-PAS1-prior-art.md`

File these, verbatim, each at the slot it names:
- **§ 2.4, items 1–5** (all of it): `LEDGER.md` row 79; `README.md`'s three-colour section, its Prior art bullet; `RESULTS.md`
  § 10, its Whose bullet; `CLOSED-QUESTIONS.md` § 2.4; and its `BIBLIOGRAPHY.md` updates and new rows.
- **§ 3.4, item 4** — the `BIBLIOGRAPHY.md` items only.
- **§ 4.4, item 2** (the erratum entry under FS100-CLS in `plans/FS100-derivation.md`, the original text left standing) and
  **item 4** (`BIBLIOGRAPHY.md`).
- **§ 5.4, item 3** — `BIBLIOGRAPHY.md`.
- **§ 6.4, item 3** — `BIBLIOGRAPHY.md`.

Do **not** file § 3.4 items 1–3, § 4.4 items 1 and 3, § 5.4 items 1–2 or § 6.4 items 1–2: they wait for the landings that
rewrite those rows. If a filed item mentions one of them, file it as written and name the mention in your report.

The README and `RESULTS.md` changed since the drafts were written for the three-colour section: its Prior art bullet now
ends "for the wider class the Lean proof covers, prior art not yet searched." and `RESULTS.md` § 10's Whose bullet ends "the
wider class the kernel proves: prior art not yet searched. The kernel proof is this project's." — the drafts' slot texts.
Where a slot text differs from the file by line wrapping only, match ignoring whitespace; where it differs in words, stop
and message me.

## Done means

1. **The script** (`data/fs131/fpa1/file.py`): each draft's slot found exactly once (whitespace-insensitive), the
   replacement or insertion made, and a plant — one slot text changed by a character — seen to fail before the real run.
2. **The checks after filing:** `python3 tools/bib_audit.py` (every cited key resolves; read its last line); every
   new `BIBLIOGRAPHY.md` row's library path exists (`ls`); the guard runs through the commit hook.
3. **The report**, in the standing rules' form: each item filed with its slot and its file's line number after filing; any
   slot that did not match and what you did; the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft.
