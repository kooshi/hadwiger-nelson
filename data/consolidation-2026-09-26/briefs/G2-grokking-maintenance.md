*Brief for job **G2**: G30's tally, taken now and made self-maintaining; draft *Do* lines for G21, G30 and G46. Opus 5.5, 2026-09-26. Written
by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. Read from disk `CLAUDE.md` (§ Grokkings' preamble; G21, G30, G46,
G67 above all), `WORKFLOW.md`, `DEBRUIJN.md`, `data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of this brief), and F1's report
and record (`data/consolidation-2026-09-26/reports/F1.md`, `F1-record.md`), which restored G30's evidence and tally on 2026-09-26.

## Kooshi's words (2026-09-26, verbatim)

> "may as well tally it now, then generalize the comment on it so we don't need to keep up with it."

> "yes" — to: "Draft 'what to do / what would kill it' lines for three principles that lack them: searches measure their own method, measurement
> versus derivation, recognise the classical theory first" (G21, G30, G46), **for his approval**.

## 1. G30's tally — take it now, then make the text need no upkeep

G30 ("Measurement generates; derivation kills") carries, since F1's restoration, a tally (its evidence, "8-for-8 against 0-for-10" or as the
restored text states it) and a sentence saying the tally "should be re-sorted at every tenth milestone". Do this:

- **Tally it now** across every milestone and crunch job since the tally's last date: for each result that moved a question, did it come from a
  derivation or a pre-registered replication (G30's "kills"), or from a measurement (a candidate)? Sources: `LEDGER.md` rows since the tally's
  date (their grades), the § B lines, the §R-close sections of each milestone plan since then, and the two crunches' indexes
  (`plans/CRUNCH-2026-09-25-INDEX.md`, `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`). State your counting rule before you count, and put the table in
  your record.
- **Rewrite G30's tally sentence as a general statement** that stays true without upkeep (Kooshi: "so we don't need to keep up with it") — for
  example the law the counts support and the date range they were taken over, with the count table's address — and **remove the "re-sort every
  tenth milestone" obligation**. The table itself goes to `plans/GROKKING-INSTANCES.md` §G30 (the WORKFLOW step 9 rule: instances out of
  `CLAUDE.md`). Keep G30's reasoning and killing test word for word.

## 2. Draft *Do* lines for G21, G30, G46 — do not apply

G67's form: `*Do: <trigger> … Killing test: …*` — a reading or measurement names its falsifier; a theorem names what it forbids. Write one draft
per entry, each opening with its trigger ("when a search returns a zero …", "when a measurement suggests a law …", "when a new object appears …"),
drawn from the entry's own body (quote the phrases you build on), in `data/consolidation-2026-09-26/G2-do-lines.md`, with a one-line reason for
each choice and one alternative wording. Kooshi approves before anything goes into `CLAUDE.md`.

## Gates (exit statuses read directly)

`python3 tools/claude_md_fact_audit.py --base <HEAD at launch>` PASS (the tally's numbers leave `CLAUDE.md` for `plans/GROKKING-INSTANCES.md`,
which the audit counts as a home); `--dupes` not above 10; `python3 tools/fs71_ledger_b_check.py --strict`, `python3 tools/bib_audit.py`,
`python3 tools/check_architecture.py` PASS; `CLAUDE.md` under 300,000 bytes.

## Rules

- **Touch only** `CLAUDE.md` (G30's tally sentence only), `plans/GROKKING-INSTANCES.md` (§G30), your record `data/consolidation-2026-09-26/G2-record.md`,
  and `data/consolidation-2026-09-26/G2-do-lines.md`. A re-rank job may edit `CLAUDE.md`'s paths-forward table later today; you touch only G30.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Budget:** about 150k by the harness's count; hand back by 220k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/G2.md`, with the three drafts quoted in full.

Thank you.
