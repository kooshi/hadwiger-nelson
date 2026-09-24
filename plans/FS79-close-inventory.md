# FS-79 close inventory: the invariant question at four colours

*Opened 2026-09-23, when FS-79 was minted and before its plan, under WORKFLOW step 5's rule: log every item the close will need the
moment it comes up, so nothing lives only in the coordinator's context or in a scratch directory.*
- **Writer:** the coordinator (product owner) is the only writer until the close. Agents send items to the coordinator.
- **At the close:** the close planner ticks each item "done" or "declined, with the reason", and reads every number from the item's
  source.
- **What stays out of this file:** agent ids, and the owner's held items (`~/source/lean-dir-owner/FS79-held-items.md`). This file is
  in the repository, and the competitors read the repository.

Template and precedent: `plans/FS73-close-inventory.md`.

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | method | **G72's first count.** At the close, record whether FS-79's result came through the structural question (§IQ item 2) or from elsewhere. This is G72's killing test (WORKFLOW 9's §IQ re-read). | `CLAUDE.md` G72; WORKFLOW 3.3 | open |
| 2 | ruling | FS-79 was minted as a standalone milestone, not folded into FS-76 (Kooshi, 2026-09-23: "I'd like to run it as its own standalone milestone"). FS-76 keeps the extension question (C3-inherit at four colours) and its rank-1 scan; FS-79's outcomes answer FS-76's questions 2–3. **At the close, re-aim FS-76's stub by FS-79's outcome.** | `plans/STUB-invariant-question-four-colours.md`; `plans/STUB-four-colour-inheritance.md` | open |
| 3 | file to move | **The owner's held items** (H-A, the flux one dimension up; H-B, a triangle-free universal target) go into `data/fs79/briefs/` **after the competition ends**. Until then they stay outside the repository. | `~/source/lean-dir-owner/FS79-held-items.md` | open |
| 4 | file to move | Every brief (planner, plan-phase Poros, phase-0 implementer, competitors, competition Poros) goes into `data/fs79/briefs/` when it is sent. Competitor and advisor briefs may be committed only after the competition ends. | the owner's scratch directory | open |
| 5 | stub | **FS-59** (five over ℚ(√167)) takes FS-79's phase-0 screen and its outcome. Rewrite its stub at the close. | `plans/STUB-four-colours-167.md` | open |
| 6 | stub | **FS-77 (KR6), FS-72's rank-8 lattice, FS-74's known positive (de Grey's lattice) and FS-76's rank-1 walls** are the open instances §IQ item 5 names. At the close, record FS-79's verdict on each, or "not reached". | the FS-79 stub, §IQ draft item 5 | open |
| 7 | prior art | **Unchecked citation in the owner's held item H-B:** "every triangle-free planar graph maps to the Clebsch graph (Naserasr, JCTB 2007)". Check it before anyone relies on it. | held items H-B | open |
| 8 | prior art | **Carried from FS-73 (still owed):** Liu's 2008 survey (Zbl 1168.05310, zbMATH summary withheld), on the rank-1 case of the three-colour criterion. It must be read before any write-up of row 79. | `plans/FS73-close-inventory.md` §7; FS-73 §R-close.10 | open |
| 9 | process | Kooshi, 2026-09-23: the close inventory is a WORKFLOW rule (step 5), not a memory. The owner removed the memory note and wrote the rule. FS-79 is its first milestone. | `WORKFLOW.md` step 5 | done |
