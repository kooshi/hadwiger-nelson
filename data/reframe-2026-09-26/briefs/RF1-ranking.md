*Brief for job **RF1**: put the new program at the top of the ranking. Opus 5.5, 2026-09-26. Written by the product owner. **Sized for about
150k harness tokens; hand back by 220k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), the front-page editor, in `/home/kooshi/source/lean-dir`. **`data/fs105/briefs/STANDING-RULES.md` is
part of this brief** (read "FS-105" as "this job"; paths under `data/reframe-2026-09-26/`). Read from disk `CLAUDE.md` § The aim and
§ Counter-priors (rewritten today by the owner, from Kooshi's rulings), the new stub **`plans/STUB-regularity-wall.md`**, `plans/FRONTIER-STUBS.md`,
and FS-104's stub `plans/STUB-cp-plane-six.md`.

## The job

1. **`plans/FRONTIER-STUBS.md`** (authoritative):
   - add **FS-106, the regular half** at rank 1 and **FS-107, regularity against pathology** at rank 2, both pointing at
     `plans/STUB-regularity-wall.md` (its sections), with question and bearing in the stub's words;
   - FS-104 to rank 3, its row noting that its null-set step (C-FMT (d)) is now one sub-question of FS-107;
   - renumber every later rank; keep every FS number present; add a one-line re-rank note citing Kooshi's adoption of the program
     (`CLAUDE.md` § The aim).
2. **FS-104's stub**: a banner in the house form (re-aimed, not demoted): its null-set step folds into FS-107, and its other items stand.
3. **`CLAUDE.md` § Paths forward, ranked:** mirror the table — the two new rows, FS-104 at 3, the renumbering, and the group row. The table
   intro's "bearing on χ ≥ 6" may read "bearing on the answer" to match § The aim. Touch nothing else in `CLAUDE.md`: the aim, the
   counter-priors, "Last updated" and "Open milestones" are already written.
4. **The fact audit:** renumbered rank labels and any token that leaves the table get `EXTERNAL_HOMES` or `ALLOW` lines in
   `tools/claude_md_fact_audit.py`, each with its reason (FS105-X's lines are the precedent).

## Gates (exit statuses read directly)

`python3 tools/claude_md_fact_audit.py --base 9ff8cc4a` PASS; `--dupes` not above 10; `python3 tools/fs71_ledger_b_check.py --strict`,
`python3 tools/bib_audit.py`, `python3 tools/check_architecture.py` PASS. **The 300,000-byte budget is suspended for this reframe** (Kooshi);
report `CLAUDE.md`'s byte count.

## Rules

- **Touch only** `plans/FRONTIER-STUBS.md`, `plans/STUB-cp-plane-six.md`, `CLAUDE.md` (the paths-forward table and its intro sentence),
  `tools/claude_md_fact_audit.py` (table lines only), and your record `data/reframe-2026-09-26/rf1-record.md`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- Commits by explicit path, subjects "RF1: stage n"; push; never amend or force-push.
- Report (standing rule 9) to `data/reframe-2026-09-26/reports/RF1.md` and by SendMessage to "main". Final turn text: "RF1 idle; report
  sent to the owner by SendMessage".

Thank you.
