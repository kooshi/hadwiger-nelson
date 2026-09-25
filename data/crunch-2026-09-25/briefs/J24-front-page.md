*Brief for crunch job **J24**: the front page — M1, M2 and M3's closes applied to the four front-page files at once (WORKFLOW step 9's
last act). Opus 5.5, 2026-09-25. Written by the product owner from `plans/CRUNCH-2026-09-25-queue.md` §4.4, in the form of the FS-89 close
briefs' front-page sections (`data/fs89/briefs/CL-close-planner-brief.md`, `data/fs89/briefs/CL2-close-planner-brief.md`).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page lane**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md` in full (its header rules: current state only, one home per fact, the 300,000-byte budget, `[PROTECTED]` paragraphs),
`WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the
product owner. **Kooshi's close rules:** *"close out with the findings"*; *"I don't want to lose anything from before"*; *"All novel
knowledge is a success."*

**If your record already exists, you are resuming:** read it and this brief; check the last SAVED stage against
`git log -- data/crunch-2026-09-25/j24-record.md`; continue at the first stage not SAVED. **A successor is expected** if the work outgrows
one context.

## What you apply

Three milestones closed their mathematics; each wrote **drafts** in its plan's §R-close (stage 4) for you to apply:
- **M1 = FS-91** — `plans/FS91-character-local-global.md` §R-close; derivation `plans/FS91-derivation.md`; inventory `plans/FS91-close-inventory.md`;
  prior art `plans/FS91-PA-close.md`.
- **M2 = the kernel lane** — `plans/M2-kernel-lane.md` §R-close; kernel register `plans/M2-derivation.md`; inventory `plans/M2-close-inventory.md`.
- **M3 = colourings no character gives** — `plans/M3-exotic-colourings.md` §R-close; `plans/M3-derivation.md`; inventory
  `plans/M3-close-inventory.md`; prior art `plans/M3-PA-mixing.md`.
Plus the crunch-wide items marked "crunch-wide" in `plans/FS91-close-inventory.md`, the audit `plans/PA-ambrus2023-audit.md` (J26), the
index's §5.1 proposals not yet applied (`plans/CRUNCH-2026-09-25-INDEX.md`; J24a applied C2, F1–F3, L1, B1–B8), and J29's proposed edits
(`plans/FS84-five-colours-47.md` "Proposed edits").

**Apply, into the four front-page files** — `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md` — and the stub files and
`CLOSED-QUESTIONS.md`:
1. **`LEDGER.md` rows.** The closes drafted rows numbered "next": assign numbers from 98 upward in the order M1, M2, M3 (never renumber or
   reuse an existing row), and every § B line (`tools/fs71_ledger_b_check.py --strict` must pass). Corrections to existing rows (95, 92,
   96, 82, 57 …) are rewritten in place (current state; the story goes in the commit message).
2. **`CLAUDE.md`:** each milestone's drafted lines, **at most 4,000 bytes net per milestone** and the file **under 300,000 bytes** (it stands
   near 275,600). The "Open milestones" line: M1–M3 closed (the crunch pointer stays for the index). Every correction owed (FS89-CL2's
   "archimedean" = `Hom_ℚ(F(i), ℝ) mod 1`; row 95 and item 25's prior art must cite `[Manners2015]` Lemma 5.3; **CLG at its exact scope — an
   existence statement, never "every character colouring is local at one place"**, except at three colours via J09's J4; the `L ≤ 4` range
   now "every real number field"; the trust and gate counts from J23b's stage 0). Grokking edits keep every status tag, *Do* line and
   killing test; **never touch a `[PROTECTED …]` paragraph**. If the budget binds, compress without loss elsewhere (current-state rule)
   before cutting anything a close drafted, and say what you compressed.
3. **`plans/FRONTIER-STUBS.md`** re-ranked as the closes drafted, one rank per row; the table in `CLAUDE.md` § Paths forward mirrors its top.
   Stub banners and re-aims written into the stub files; new stubs the closes minted are already files — index them.
4. **`BIBLIOGRAPHY.md`:** every proposed row and read-status update (J23p §C.3, J23cpa Stage 6, J26 §4.4 including the `[AmbrusEtAl*]`
   merge, J29 §3.1, J17K2's Snyder check); honest read status from the record that read each paper. `tools/bib_audit.py` must pass.
5. **`CLOSED-QUESTIONS.md`:** the candidate "Fischer 1990 §1's general question, answered at χ ≤ 3 and L ≤ 4 for every real number field"
   goes in **as a candidate, gated on `[Johnson2000]`/`[Johnson2006]` being unread** — never as fired.
6. **Forward propagation (WORKFLOW 9):** every grokking the closes minted or rewrote, carried to the open stubs it bears on (their
   provisional-bearings lines).
7. **Each close inventory:** tick every item the front page discharges ("done at <hash>"), and mark the milestone closed at the head.

## Gates, before each commit that touches `CLAUDE.md`, and at the end

- `python3 tools/claude_md_fact_audit.py --base 543b51d5` (J24a's last `CLAUDE.md` commit; nothing lost) must pass, and `--dupes` must
  read 11 (or say exactly what changed and why). Quote each verdict in your record.
- `tools/bib_audit.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/check_architecture.py` — pass. Read every exit status from the
  tool itself, never through a pipe.
- No Lean build is needed (you edit no Lean file); do not run one.

## Stages (each saved and committed, headed `Stage n — SAVED` in your record)

1. Read the three §R-close drafts and the inventories; list every edit you will make, file by file, with its source address (≈ 80k).
2. `LEDGER.md` and § B (≈ 60k). 3. `CLAUDE.md` (≈ 80k). 4. `FRONTIER-STUBS.md`, stubs, `CLOSED-QUESTIONS.md` (≈ 50k).
5. `BIBLIOGRAPHY.md`, the inventories' ticks, the gates (≈ 40k). Report.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. Stop at a saved stage if the work outgrows you.
- **You are the only writer** of the four front-page files, the stubs and `CLOSED-QUESTIONS.md` while you run, and of the three close
  inventories. Never edit a job record, a derivation file, the index, or a Lean file.
- **Never judge a verdict** the closes reached; apply their drafts, correcting only what a gate or a source contradicts — and then say so
  in your record, with both addresses.
- **Commits by explicit path** (`git diff -- <path>` first; `git commit <paths> -m …`, never a bare `git commit`), subjects "J24: stage n —
  <file>"; the commit message carries the story of any correction (the file holds current state only). End commit messages with your
  harness's attribution lines. Push after each stage; never force-push.
- **Budget:** about 350k by the harness's count; hand back with the stage saved by 420k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J24.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J24 idle; report sent to the owner by SendMessage".

Thank you. This is where the day's findings become the project's.
