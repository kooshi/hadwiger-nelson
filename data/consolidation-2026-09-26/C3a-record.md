# C3a — claims front page: record

*Job C3a of the 2026-09-26 documentation consolidation (brief `data/consolidation-2026-09-26/briefs/C3a-claims-front-page.md`,
standing rules beside it). de Bruijn, Opus 5.5. HEAD at launch: `9b3ec6ab`. `CLAUDE.md` at launch: 296,094 bytes.*

## Stage 1 — SAVED

Items 1–2 of the brief.

| file | location | old claim (quoted) | new claim | justified by |
|---|---|---|---|---|
| `CLAUDE.md` | header, size budget | "**Size budget: none during the 2026-09-26 ×2×3 crunch** (Kooshi: *\"CLAUDE.md unbounded temporarily so we don't need to compress on the fly\"*); **otherwise keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the 2026-09-25 crunch's end: …" | "**Size budget: keep this file under 300,000 bytes** (Kooshi, 2026-09-26, at the ×2×3 crunch's end, after it ran unbounded: *\"the 300kB limit returns, …\"* (his second paragraph, verbatim); at the 2026-09-25 crunch's end: …" | Kooshi's words, brief §"Kooshi's words" ¶2 |
| `CLAUDE.md` | § Publication, third bullet | "**It has not fired.** **A candidate:** `χ(ℚ(√47)²) = 5` (row 121) answers … whether the rule fires is Kooshi's call, after the value's prior-art gate (pending, X24R). It appeared to have, once, for Theorem B" | "**It half fires** (Kooshi, 2026-09-26): … [hand], over MR (row 120) and an external theorem, in the kernel only in row 127's conditional form; its prior-art gate found nothing in print (X24R, row 121). His ruling: (three quotes verbatim) … The write-up is the fallback … the project pushes on toward six first … The rule appeared to fire once before, for Theorem B" | Kooshi's ruling (brief ¶3, ¶5); row 121 (X24R gate done: "not found in print") |
| `CLAUDE.md` | § Publication, FS-20 line | "**The paper is FS-20** (`plans/STUB-theorem-B-writeup.md`; re-scoped 2026-09-22 — whether it is still worth writing is Kooshi's call)" | "**The Theorem B paper is FS-20** (…; whether it is still worth writing is Kooshi's call; the fallback write-up above has no stub of its own)" | consistency: FS-20 is the Theorem B paper; the half-firing result is a different write-up |

Gates after stage 1: fact audit `--base 9b3ec6ab` PASS (0 failures; no ALLOW line added); `--dupes` 10 (unchanged from launch);
`fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` PASS; `check_architecture.py` PASS. `CLAUDE.md` 296,855 bytes.

Owed elsewhere (not mine to touch): a stub for the fallback write-up of rows 120–123 (Kooshi's call whether to mint it; C3b or the owner).

## Stage 2 — SAVED

Items 3–4 of the brief.

| file | location | old claim (quoted) | new claim | justified by |
|---|---|---|---|---|
| `CLAUDE.md` | Frontier, "The problem." | "This repository kernel-certifies the whole classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on the standard three axioms." | the same, "its lower end through de Grey's graph (rung B)", then "**The lower end now also follows algebraically, with no witness object:** a subfield's plane is a subgraph of ℝ²'s, so `χ(ℚ(√47)²) = 5` (row 121) gives χ(ℝ²) ≥ 5 — at [hand] grade, over MR (row 120: EL2021 Thm 1.2 by statement and Einsiedler–Fish's method transferred), not in the kernel, where row 127 holds it only over named hypotheses", then Kooshi's reading verbatim | rows 120, 121, 127, 33 |
| `CLAUDE.md` | § The mission, rung table, row B | "…our foundation, not our product" | "…our foundation, not our product. Also derived with no witness object, at [hand] (§ Where the problem stands)" | pointer (one home per fact) |
| `CLAUDE.md` | § The mission, target | "**The target, as of 2026-09-17: seven** (Kooshi, on reading G64 — …)" | "**The target, as of 2026-09-26: six, or a proof that no field's plane is six-chromatic** (G64's S) — Kooshi: (verbatim) … Beyond it, seven (2026-09-17, on reading G64 — …)" | Kooshi's words (brief ¶4); G64's statement S |
| `CLAUDE.md` | Paths forward, Open milestones | "**One is open: FS-84** … its remaining stages (S2 onward, from 2026-10-01) are re-aimed toward Soifer 55.1 as posed (the table's rank 4)." | "**None is open.** FS-84 … is **closed**: FS-100 stage 5 answered its question (row 121), and its remaining stages, an explicit triangle-free graph, are not pursued — Kooshi, 2026-09-26: (verbatim). S1 … and S1V … stand" | row 121; Kooshi's ruling (brief ¶6) |
| `CLAUDE.md` | Paths forward, rank 4 | "**FS-84 ℚ(√47): five colours** … S2 onward (post-ban) re-aimed to an explicit triangle-free five-chromatic graph … the owner's ruling, Kooshi may close it instead. Before the answer, …" | "**FS-84 ℚ(√47): five colours — closed (2026-09-26)** … answered by FS-100 stage 5 (row 121); the explicit triangle-free graph (Soifer 55.1 as posed) not pursued, Kooshi's ruling (Open milestones); its rank held so the table's numbering stands" (FS-97's precedent at rank 13) | row 121; Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry | "…so 55.1's \"construct\" and 55.2 stay open. FS-84 (post-ban) carries the explicit graph." | "…stay open. **The constructive half is not a project goal:** FS-84, which would have built the explicit graph, is closed (Kooshi, verbatim)." | Kooshi's ruling |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry | "…the yes side is untouched. **Still open.**" | "…the yes side is untouched; the rigidity question stays open." (55.1's existence half is no longer open, row 121) | row 121 |
| `CLOSED-QUESTIONS.md` | §3, 55.1 entry, last sentence | "…55.1 as posed (construct one) and 55.2 stay open (FS-84's re-aim)." | "…stay open, and are not pursued here." | Kooshi's ruling |

Gates after stage 2: fact audit `--base 9b3ec6ab` PASS (no ALLOW added); `--dupes` 10 (one new run, FS-97's "kept at its rank so the
numbering stands | — |", caught and reworded); ledger-§B strict PASS; bib PASS; architecture PASS. `CLAUDE.md` 297,506 bytes.

Owed to C3b: `plans/STUB-five-colours-47.md`'s banner (closed, not re-aimed) and `plans/FRONTIER-STUBS.md`'s rank-4 row and closed list.
