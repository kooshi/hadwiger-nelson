*Brief for job **C3a**: bring every claim in the front-page files up to date with the new evidence. Opus 5.5, 2026-09-26. Written by the
product owner. A later job, C3b, does the same for `plans/FRONTIER-STUBS.md` and the stub files after you.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the front-page editor, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (all of it — its header
rules, current-state-only and one-home-per-fact above all), `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/consolidation-2026-09-26/briefs/STANDING-RULES.md`
is part of this brief.**

## Kooshi's words (2026-09-26, verbatim)

> "Now, next, I want to do a documentation consolidation. Let's audit our main files and just make sure that our citations are clean, all
> findings are wired in, all files in /tmp that can't be regenerated are rescued, and all claims are brought up to date with our new evidence."

> "the 300kB limit returns, and we'll likely need to find a way to extract what's not necessary, treat the grokkings there as a cache for a
> dedicated grokking file, or merge things to reduce it from here on out. There's just too much new knowledge to carry in every session."

> "The publication rule half fires. This is 100% worthy of a writeup, but I want to be greedy and push to see how far we can get on our own.
> We have now reduced hadwiger-nelson to 5,6,7 *algebraically* rather than by a witness object. That is far more valuable than de Grey's 2018
> graph IMHO."

> "We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be fascinating) and potentially answer the
> HN problem definitively."

> "So writing this up will be our fallback if we feel like we can't progress, but the fact is, progress has been incredibly steady. Now, we got
> lucky that we grazed another hard open problem and got through unscathed by the grace of the infinite primes special case. If we end up at a
> wall which collapses HN to another known open problem, that in itself would be a writeup."

> "I'm not interested in taking the time to find a triangle free graph. That's incidental to the goal."

## The new evidence (read the rows, not this summary)

`LEDGER.md` rows 116–127 and their § B lines; `plans/FS100-derivation.md` §2–§5; the §R-close sections of `plans/FS100-three-field-lemma.md`
(waves 1–2, 3, 3b); `plans/FS100-K-kernel-47.md` (the Lean lane). In one line, at its grade: given MR — now held at [hand] grade for every real
number field — `χ(F²) = L(F)` whenever `L(F) ≤ 5`, for every real number field (rows 120–125); `χ(ℚ(√47)²) = 5`; `5 ≤ χ(ℚ(√167)²) ≤ 7`; the
type-(B) measure half reduced to NA₀ (row 126); the Lean every-real headline over named hypotheses (row 127).

## What to do

1. **The header, first:** restore the byte budget — "keep this file under 300,000 bytes", with Kooshi's words and date in the header's history
   parenthesis (the 2026-09-26 ×2×3 crunch's "none" ended; quote his second paragraph above). Run the fact audit after this one edit and commit.
2. **§ Publication:** record Kooshi's ruling — the rule **half fires**: the result is worthy of a write-up, which is the fallback; the project
   pushes on toward six first. Quote him. Keep FS-20's line consistent.
3. **Kooshi's reading as current state**, in "Where the problem stands" or the mission's target paragraph, at its grade: the lower bound
   `χ(ℝ²) ≥ 5` now also follows **algebraically**, with no witness object, from `χ(ℚ(√47)²) = 5` (a subfield's plane is a subgraph of ℝ²'s) — at
   [hand] grade, over MR and Einsiedler–Lindenstrauss 2021 Thm 1.2 and Einsiedler–Fish's method, not in the kernel (de Grey's graph is in the
   kernel: rows 33, B). Say both, exactly. The target line: six, or a proof that no field's plane is six-chromatic (Kooshi's words).
4. **FS-84 closed**, not re-aimed (Kooshi: the triangle-free graph is "incidental to the goal"): its paths-forward row, "Open milestones", and
   `CLOSED-QUESTIONS.md` §3's 55.1 line (the constructive half stays open, and is not a project goal). The stub file's banner is C3b's.
5. **The claims sweep — the main work.** Walk `CLAUDE.md` top to bottom (mission, target, "What the kernel holds", every "What the hunt has
   established" item, the prior-art position, paths forward, and every grokking's body and Do line) and `LEDGER.md` rows 1–127, and
   `CLOSED-QUESTIONS.md`. For each claim the new evidence changes — a statement conditional on MR that MR now makes unconditional-at-[hand]
   (rows 113, 116, 117, 118, 110, 96, 101, 92 and their grokkings G48, G55, G56, G59, G64, G76, G77, G79; items 10, 12, 14, 15, 18, 22, 24–29; the
   exposed predictions in § The mission; the Frontier's "proved range"), a range now wider, a prediction now met — **rewrite it in place to
   current state** (header rule), at the new result's grade, with the row as its address. Keep a table in your record: file, location, old
   claim (quoted), new claim, the row that justifies it.
   - **One home per fact:** a result's statement lives in its ledger row; elsewhere, point.
   - **Do not upgrade grades.** "given MR" becomes "given MR (row 120, [hand])" or the row pointer — never a bare unconditional.
6. **The byte budget:** the file stands at 296,094 against 300,000. Rewrites in place are roughly neutral; if your edits would cross 300,000,
   **stop and report** — the grokkings-file restructure Kooshi described is a separate decision, not yours. Compress nothing to make room.

## Gates (each exit status read directly, at every commit)

`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS — every ALLOW line you add reviewed and stated in your report with
its reason (a superseded claim is the usual reason); `--dupes` at 10 or fewer; `python3 tools/fs71_ledger_b_check.py --strict` PASS;
`python3 tools/bib_audit.py` PASS (C2 may be adding rows; if it fails on a key C2 is adding, wait and re-run); `python3 tools/check_architecture.py`
PASS.

## Stages

1. The header and § Publication (items 1–2). Save; commit.
2. Kooshi's reading and FS-84 (items 3–4). Save; commit.
3. The sweep of `CLAUDE.md` (item 5), in two or three commits. Save.
4. The sweep of `LEDGER.md` and `CLOSED-QUESTIONS.md`. Save.
5. The report, with the table and every gate.

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`, the fact audit's ALLOW table (reviewed lines only), and your record
  `data/consolidation-2026-09-26/C3a-record.md`. Never `BIBLIOGRAPHY.md` (C2's), `plans/FRONTIER-STUBS.md` or stub files (C3b's), Lean files,
  `scripts/`, frozen tools. List anything owed there in your report.
- **Budget:** about 300k by the harness's count; hand back by 400k (the file is large; that is expected).
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/C3a.md`, with `CLAUDE.md`'s byte count.

Thank you.
