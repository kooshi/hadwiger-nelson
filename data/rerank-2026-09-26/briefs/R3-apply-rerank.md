*Brief for job **R3**: apply the approved re-rank, mint the three new stubs, and apply the three approved *Do* lines. Opus 5.5, 2026-09-26.
Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the roadmap editor, in `/home/kooshi/source/lean-dir`. Read from disk `CLAUDE.md` (the disk copy),
`WORKFLOW.md` (step 2's stub rule; step 9), `DEBRUIJN.md`, and `data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of this brief).

## Kooshi's words (2026-09-26, verbatim)

> "I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll focus on that as the milestone."

What he approved (my last report to him, in its words):
1. **Adopt the new ranking**, with checking the collapse as the next milestone — R1's proposal, `plans/RERANK-2026-09-26.md` (read it all).
2. **Where R1 and the advisor disagree, the advisor's order**: "six is not a value" (FS-62) above ℚ(√167) (FS-59) — the advisor's record
   `plans/POROS-2026-09-26-rerank.md` (its stage 4) gives its reasons and numbers; FS-63 moves to the product-locality cluster (both agreed).
3. **The three *Do* lines** drafted in `data/consolidation-2026-09-26/G2-do-lines.md`, for G21, G30 and G46, and the G30 killing-test rewording
   already applied (keep it).
Also settled by the owner: FS-69 and FS-57 (multi-hour relaxations) are **post-ban**.

## What to do

1. **Mint the three new stubs**, each to WORKFLOW step 2's stub rule (a fresh session with zero memory must be able to plan it), with Kooshi's
   words where they bear, a provisional-bearings line, and **the grade of everything it rests on**:
   - **FS-103, the collapse** (`plans/STUB-collapse-cp-plane.md`) — **the next milestone**. Its question, quoted verbatim from R1's F1
     (`plans/RERANK-2026-09-26.md`) and the advisor's record: given MR (row 120, [hand]) and T-J39-3, at a real field with no non-thick stable
     place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`, so six at any field is rung D and S implies `χ(ℝ²) ≠ 6`. **It is a candidate composition, not a
     result**: state it as the stub's question, never as held. What the milestone must do: two blind verifiers, the checkable instance first
     (ℚ(√635087): first usable prime 103, `2√103/104 ≈ 0.195 < 1/5`), then de Grey's field ℚ(√3,√5,√7,√11) (the three extra steps the advisor
     names: MR at degree 16, merging 16 real places, its stable-place list); a prior-art gate in the words of measurable / Borel / stationary
     colouring and harmonic analysis (Falconer 1981's measurable chromatic number `χ_m`, not held; `χ_CP ≤ χ_m`; the claim is `χ = χ_CP`, never
     `χ = χ_m`); where `χ_CP` sits relative to `χ_m` and `χ_B`. And its consequence for the target, in Kooshi's words: *"If we end up at a wall
     which collapses HN to another known open problem, that in itself would be a writeup."*
   - **FS-104, `χ_CP(ℝ²)` at six** (`plans/STUB-cp-plane-six.md`): R1's N2 — reading Falconer 1981 first; the advisor's prior (about 0.03) as
     stated in its record.
   - **FS-105, harden MR** (`plans/STUB-harden-mr.md`): R1's N3 — read Einsiedler–Lindenstrauss 2021 Thm 1.2's proof (unread; the headline's
     weakest link per the advisor), and a third blind derivation of EF_F⁺.
2. **Apply the ranking** to `plans/FRONTIER-STUBS.md` (authoritative): every row R1's table moves, with its new rank, its question and bearing in
   today's terms; the closed list gains FS-84 and FS-97; demote with banners, never delete; keep every FS number present. **Read every stub you
   move in full first** (R1 read them only through their rows, for budget), and bring each moved stub's status block and provisional-bearings
   line to current state.
3. **Mirror it in `CLAUDE.md`'s paths-forward table** (ranks 1–29 as rows; 30 and below in the one pointer row), the "Open milestones" line
   (**next: FS-103, the collapse**), and the "Last updated" line — current state only.
4. **Apply the three *Do* lines** to G21, G30 and G46 exactly as drafted in `G2-do-lines.md` (each draft says whether it replaces the entry's
   existing falsifier sentence; do what it says). Quote nothing else from the drafts file.

## Gates (exit statuses read directly, at every commit)

`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS (any ALLOW line reviewed and stated with its reason — prefer the audit's
outside-homes table for a fact that moved to `plans/FRONTIER-STUBS.md`); `--dupes` not above 10; `python3 tools/fs71_ledger_b_check.py --strict`,
`python3 tools/bib_audit.py`, `python3 tools/check_architecture.py` PASS. **`CLAUDE.md` under 300,000 bytes** (it is at about 291,900): if the
work would cross it, move instances to `plans/GROKKING-INSTANCES.md` per WORKFLOW step 9 — never cut an intrinsic — and if that is not enough,
stop and report.

## Rules

- **Touch only** `plans/FRONTIER-STUBS.md`, `plans/STUB-*.md` (the three new ones and the ones the ranking moves), `CLAUDE.md` (the paths-forward
  table, "Open milestones", "Last updated", and G21/G30/G46's *Do* lines), `plans/GROKKING-INSTANCES.md` (if an instance must move),
  `tools/claude_md_fact_audit.py` (reviewed table lines only), and a record section appended to `plans/RERANK-2026-09-26.md` ("§ Application —
  R3"). Never `LEDGER.md`, `BIBLIOGRAPHY.md`, Lean files, `scripts/`, frozen tools.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- Work in stages (stubs; ranking; `CLAUDE.md`; *Do* lines), saving and committing after each.
- **Budget:** about 350k by the harness's count; hand back by 450k.
- Report per standing rule 9 to `data/rerank-2026-09-26/reports/R3.md`, with `CLAUDE.md`'s byte count and every gate.

Thank you.
