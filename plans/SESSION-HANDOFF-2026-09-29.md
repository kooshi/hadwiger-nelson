# Session handoff — 2026-09-29, night: FS-116 and FS-121 open, round 1 running

*Written 2026-09-29 05:47 UTC by Keryx for a successor arriving with nothing (a compaction, a crash, or the morning). Current state only; rewritten in place.*

## Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow`. Agent types `poros`, `ephodos`, `ephodos-verifier`,
   `debruijn`, `clerk` must be listed.
2. **The two inventories are the state**: `plans/FS116-close-inventory.md` (items, the announcement rule, the W-table of workflow frictions,
   the O-table of lane items outside the milestone) and `plans/FS121-close-inventory.md`. Every ruling tonight is a row there.
3. **Kooshi's words tonight**, verbatim in `plans/FS116-close-inventory.md` items 4 and 7: FS-121 opens beside FS-116; the formalization lane
   stays idle; the proposed lane-file edits (`plans/WORKFLOW3-lane-edits-proposed.md`) are **deferred to 2026-09-29 (morning)** — "watch for
   instances or additions throughout this session"; § G of that file is the running list.

## What is running (round 2; updated as jobs finish — the inventories are authoritative)

| job | kind | brief | record | blind? |
|---|---|---|---|---|
| FS116-N1 (successor) | Ephodos, stage 4: SAT-STRIP, SAT-QFREE | `data/fs116/briefs/FS116-N1-ring.md` amendment 1 | `plans/FS116-N1-proof.md` | no |
| FS116-Y1 | Ephodos, construction | `data/fs116/briefs/FS116-Y1-construction.md` | `plans/FS116-Y1-construction.md` | no |
| FS116-V2 | ephodos-verifier | `data/fs116/briefs/FS116-V2-verify.md` | `plans/FS116-V2-verification.md` | yes: fence in its brief |
| FS121-D2 | Ephodos, C121-NOLRA | `data/fs121/briefs/FS121-D2-nolra.md` | `plans/FS121-D2-proof.md` | no |
| FS121-D3 | Ephodos, C121-SAT6 | `data/fs121/briefs/FS121-D3-sat6.md` | `plans/FS121-D3-proof.md` | no |
| FS121-V2 | ephodos-verifier | `data/fs121/briefs/FS121-V2-verify.md` | `plans/FS121-V2-verification.md` | yes: fence in its brief |

Done tonight: FS116-P1, TC1, FS116-O1, FS121-O1, FS116-V1, FS121-D1, FS121-DB1, FS116-N1 (stages 1–3), CL1, CL2 — each logged in an inventory.

Agent ids are in the coordinator's scratch only. A halted job resumes from its record's last SAVED stage (standing rule 2), with a fresh agent
on the same brief if the old one is gone or past ~500k.

## Rules in force

- Commit subjects stay neutral while the two verifiers run.
- The announcement rule (both inventories, top): held = frozen list + two minds, the second blind with its verdict committed first.
- Claim lists frozen: `data/fs116/claims.md`, `data/fs121/claims.md` (blindness edits only, recorded in their headers).
- Shared step: FS-116's `what-do-q-rings-force` (RING-Q) is FS-116's; FS-121 takes it as input (`plans/FS121-close-inventory.md` item 8).

## Next

When round 1 reports: review by artifact, log, route (a refutation to its deriver; RING-Q's answer to FS-121); P1–P3 of each milestone choose
round 2 (`plans/FS116-local-exclusion.md` § 4.4–4.5, `plans/FS121-map-step.md` § 4.2–4.4). The morning report to Kooshi covers tonight in his
house format (`.claude/output-styles/keryx.md` § Reporting to Kooshi), including the lane-edit review.
