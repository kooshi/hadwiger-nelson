*Brief for job **RK**: the ranking pass, which states every stub's bearing on the answer. Opus 5.5, 2026-09-27. Written by the product owner at
Kooshi's request (*"go ahead and spawn one additional agent for it"*). **Sized for about 250k tokens by the harness's count. Your own count runs at
55–70 % of it, so hand back with your work saved when your own count reaches about 170k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. Read these from disk:
- **`CLAUDE.md` § The aim and § Counter-priors first.** Counter-priors rule 1 is this job's rule: *"Rank a route by its bearing on the answer, never
  by its difficulty, its length or its formalization effort."*
- The rest of `CLAUDE.md`, including the header's byte budget and its one-home-per-fact rule.
- `WORKFLOW.md` step 9's re-rank bullet.
- `LEDGER.md` rows 120–133.

## The task

`plans/FRONTIER-STUBS.md` is the authoritative ranking, and `CLAUDE.md` § Paths forward mirrors its top. Rows 1–3 were re-ranked at the last two
closes, and Kooshi approved them this morning; they stay where they are. Rows 4–64 still state their bearing the way it stood before the 2026-09-26
reframe, in terms of six colours: "bearing on χ ≥ 6", "the push toward six", "none on six".

The aim now is the answer: `χ(ℝ²)` decided, then formalized in Lean. The direction is the regularity wall (`CLAUDE.md` § The aim). Its current
state is `LEDGER.md` rows 131–133:
- the stability form;
- the regular half;
- where the two routes meet, now narrowed at FS-110 to a local configuration at distance 2.

1. **Rewrite each row's "bearing on the answer" cell, rows 4–64, in current-state words.** For each row:
   - say what it would contribute to deciding `χ(ℝ²)`, or to the Lean formalization of whatever decides it;
   - say how it relates to the direction (links 1–6 of § The aim);
   - write "none" plainly where that is the truth.

   Keep each cell's grades and soft-as-to-truth warnings. Do not inflate. A row about ℚ(√167) at six is about a field; say so, and say what it would
   mean for the plane given MR (row 128). Kooshi's standing words hold: *"All novel knowledge is a success"*. A row can bear on the answer weakly and
   still be worth its place.
2. **Re-rank where the honest bearing moves a row**, below rank 3 only, keeping one rank per row. For every move, write its reason in one line. Record
   the moves in a new file, `plans/RERANK-2026-09-27.md`: each row's old rank, new rank and reason, and each rewritten bearing beside the old one. Its
   form is `plans/RERANK-2026-09-26.md`'s, cut down.
3. **Mirror the result into `CLAUDE.md` § Paths forward.** Follow the table's current design: ranks 1–29 as rows, and 30–64 grouped in one row, their
   ids in rank order.
   - **The budget:** `CLAUDE.md` is at 299,438 bytes against its 300,000 limit, so the mirror must not grow the file.
   - Shorten the mirrored cells and point to `plans/FRONTIER-STUBS.md` for the full text. Never cut an intrinsic, and never touch a
     `[PROTECTED …]` paragraph.
   - Report the byte count before and after.
4. **Stub files:** do not rewrite them. Where a stub's own "Bearing on χ ≥ 6" heading is now wrong, list the file in your record, for a later pass.

## Gates

Read every exit status directly, never through a pipe.
- `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`: PASS, with every reviewed ALLOW line stated with its reason.
- `python3 tools/claude_md_fact_audit.py --dupes`: not above 10.
- `python3 tools/bib_audit.py`: PASS.
- `python3 tools/check_architecture.py`: PASS.
- A check, which you write, that `CLAUDE.md`'s table matches `plans/FRONTIER-STUBS.md`'s ranks and order.

## Coordination

The FS-110 competition is running in parallel. Its agents do not touch these files. FS-110's close will edit both files after you, so commit per stage
and push. If a push races, run `git pull --rebase origin main`, then push. Never force-push.

## Rules

- **Touch only** `plans/FRONTIER-STUBS.md`, `CLAUDE.md` (§ Paths forward's table and its introductory lines only), `plans/RERANK-2026-09-27.md`,
  `tools/claude_md_fact_audit.py` (reviewed table lines only) and `data/rerank-2026-09-27/`.
- Commit by explicit path, with subjects "RK: stage n". Never amend.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Never read the FS-110 competitors' or verifiers' working records; you need none of them. The ledger rows are your source.
- Report to `data/rerank-2026-09-27/RK-report.md`, committed, and by SendMessage to `"main"`. Include:
  - the moves;
  - the byte counts;
  - every gate's result;
  - the stub files owed a later pass.

  Your final turn's text: "RK idle; report sent to the owner by SendMessage".

Thank you.
