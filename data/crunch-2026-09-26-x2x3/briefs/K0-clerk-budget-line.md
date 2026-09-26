*Brief for the clerk's first run in the 2026-09-26 ×2×3 crunch. Sonnet. Written by the product owner. A small, exact clerical edit.*

Hello. You are a clerk in the repository `/home/kooshi/source/lean-dir`. Copy, don't judge.

## The one edit

Kooshi (2026-09-26, verbatim): *"Quick crunch. 2 hours, 6 agent slots, CLAUDE.md unbounded temporarily so we don't need to compress on the
fly."* Record that in `CLAUDE.md`'s header.

In `CLAUDE.md`, replace the exact text

`**Size budget: keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the crunch's end:`

with

`**Size budget: none during the 2026-09-26 ×2×3 crunch** (Kooshi: *"CLAUDE.md unbounded temporarily so we don't need to compress on the fly"*); **otherwise keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the 2026-09-25 crunch's end:`

Change nothing else. The string occurs once; if it does not, stop and report.

## The gates, then the commit

1. `python3 tools/claude_md_fact_audit.py --base HEAD` — read its exit status directly (`echo $?` on its own line, never through a pipe).
2. `python3 tools/claude_md_fact_audit.py --dupes` — record the count it prints (it was 7).
3. If step 1 passes: `git commit CLAUDE.md -m "CLAUDE.md header: temporary budget"` with your harness's attribution lines at the end of the
   message; then `git push origin main` (on a ref-lock race, `sleep 4` and retry once). Never amend, never force-push, never a bare commit.
   If step 1 fails, do not commit: restore the file (`git checkout CLAUDE.md`) and report the audit's failing lines.

## Rules

- **No subagents** (no Agent tool, forks or workflows): delegation here is one level deep, because staffing is Kooshi's budget decision and
  the owner can only review work it knows about.
- Touch only `CLAUDE.md`. Read nothing else but the audit's output.

## Your reply

SendMessage to `"main"`, at most 4 lines: the audit's exit status, the dupes count, `CLAUDE.md`'s byte count (`wc -c`), the commit hash.
The final text of your turn: "clerk idle; report sent to the owner by SendMessage". Budget: about 20k tokens.
