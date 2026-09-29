# TP1 — the theory in one paragraph: checked clause by clause, and its replacement drafted

*Ephodos, 2026-09-28. Brief: `data/workflow3/briefs/TP1-theory-paragraph.md` (with `plans/STANDING-RULES.md`). A drafting job for the
front page; not blind, no fences. This record is the job's only working file; `CLAUDE.md` is not edited here (Keryx files the draft).*

## Theorems this phase proved

None. This job checks a summary paragraph against its sources and drafts its replacement; it derives nothing new.

## Would have searched here

Nothing. The job reads text and greps it; no move of it is a search for a finite witness.

## Stage 1 — SAVED: the readback

Each quotation in the brief, checked against its source by a script (whitespace normalised; `CLAUDE.md` read from disk, not from the
launch snapshot):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi: "Let's say 80kB for CLAUDE.md, and 200kB for grokkings. Also, in CLAUDE, we still call grokkings "the working theory of the 5th colour". That feels a bit out of date. Make sure that the "theory in one paragraph" is also valid." | `plans/WORKFLOW-AUDIT-2026-09-28.md` § 9 (line 128) | verbatim |
| the paragraph, "**The theory in one paragraph.** The 4/5 wall is arithmetic. … the field's number is the plane's (G81)." | `CLAUDE.md` § Grokkings — the working theory of Hadwiger–Nelson (disk, line 396) | verbatim; 13 lines |
| "`CLAUDE.md` is at 68,853 of its 80,000-byte budget" | `wc -c CLAUDE.md` | 68853 — matches |

No mismatch. One note on the brief's framing, not a mismatch: the section heading on disk is already renamed ("Grokkings — the working
theory of Hadwiger–Nelson", commit `42c67943`), so of Kooshi's two points only the paragraph is left, which is this job.

**The claims I hold, restated beside the quotations.** (1) A table, one row per clause of the quoted paragraph: the clause, its source
read by body (a `GN` in `.claude/skills/grokkings/SKILL.md` or a row of `LEDGER.md`), and a verdict — holds, stale (superseded, by
what), false (what shows it), unsupported. (2) A replacement, at most about 3,000 bytes, every clause sourced inline and graded where
it rests on less than the kernel, claiming nothing past its sources. (3) A resolution check that every cited `GN` and row exists, with
the command and its output. (4) The report in the standing rules' form.
