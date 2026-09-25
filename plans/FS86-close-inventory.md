# FS-86 close inventory: four-colour rigidity over ℚ(√59) and ℚ(√83)

*Opened 2026-09-25, when FS-86 was chosen and before the plan exists (WORKFLOW step 5). Every item the close will need is logged the
moment it comes up, so nothing lives only in the coordinator's context or in a scratch directory.*
- **Writer:** the coordinator (product owner) is the only writer until the close. Agents send their items to the coordinator.
- **At the close:** the close planner ticks each item "done" or "declined, with the reason", and reads every number from the item's source.
- **What stays out:** agent ids, and anything a competitor must not read. Held items are listed by label only. **During a competition,
  competitor progress also stays out:** it goes to an owner-held scratch copy, and this file gets a label-only line (FS-85's lesson,
  `plans/FS85-close-inventory.md` items 49 and 59).

Templates: `plans/FS85-close-inventory.md` (86 items) and `plans/FS81-close-inventory.md`.

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | ruling (Kooshi) | **FS-86 chosen** on 2026-09-25: "I agree with FS-86." It was the owner's recommendation, at medium confidence, for the rest of the finite-witness-free week, above FS-59 (the table's rank 1) and FS-83. | Kooshi's message; FS-85's final report | settled |
| 2 | ruling (Kooshi, carried) | **The finite-witness-free week runs to 2026-10-01** (`CLAUDE.md` § Toolchain). The stub's routes 1–3 are in scope. Route 4 (composite quotients, a quotient-colouring search) waits for the week's end. Every brief carries the "would have searched here" log. | `CLAUDE.md` § Toolchain | open |
| 3 | ruling (Kooshi, carried) | **"All novel knowledge is a success"** (2026-09-24), and no-gos count ("yes"). A proven "no" in type (B) fields is a result in its own right. | FS-85 inventory items 31, 36 | settled |
| 4 | prediction | **Registered in the stub, before any run.** No: the tower forces nothing on some rich lattice, or some target gives a gapped colouring. Yes, `P₄ ≠ 0`. Yes, `F₄ ≠ 0`, which is Soifer-strength by FS85-dB4. The planner registers probabilities at §P. Coxeter's R2.6 reading predicts no, and G75's killing test is this milestone's yes. | the stub § Outcomes | open |
| 5 | prior art | **Reading owed at the opening:** Soifer ch. 55's posing citation "[Soi46]" and its citation graph; `[deGrey2026]` and `[Haugstrup2026]` (author's summaries only so far); T721 (not held). Carried from FS-85 items 6 and 25. | FS-85 inventory items 6, 25 | open |
| 6 | carried | **The Johnson papers** (`[Johnson2000]`, `[Johnson2006]`; Kooshi obtaining). Nothing about row 82 is claimed new until they are read. | FS-81 items 10, 33 | open |
| 7 | bookkeeping | **The choice recorded:** `CLAUDE.md` § Paths forward's next-milestone sentence, `plans/FRONTIER-STUBS.md`'s open-milestones paragraph, and the stub's banner. **The next close's fact-audit base is this commit** (find it with `git log --oneline -- plans/FS86-close-inventory.md`, the first entry). | this row | settled |
| 8 | ruling (Kooshi) | **FS-86 runs as a competition** (2026-09-25, at stage A's launch): "you should make this one a competition too. It works well for derivations." Two competitors plus a competition-phase advisor, the protocol's design. It replaces the handoff's open choice for stage C (competition, or one agent with a blind verifier). The planner decides where routes 1–2 (exact computer algebra) sit relative to it, within the three-agent cap. From the first competitive commit on, competitor progress stays out of `plans/`, `data/` and commit subjects (the protocol, rule 1). | Kooshi's message during stage A's launch | settled |
| 9 | staffing | **Stage A launched** (2026-09-25): a fresh de Bruijn planner and a fresh plan-phase Poros, both Opus 5.5. Briefs: `data/fs86/briefs/A-planner-brief.md`, `data/fs86/briefs/A-poros-plan-brief.md`. Budgets about 350k and 300k. Changes from FS-85's stage-A briefs: Kooshi's competition ruling (item 8); frame-level items go to the planner during the plan, not into holding (FS-85's H5 and H6 reached no plan); every reachable outcome assigned a verdict and the killing test checked able to fire (FS-85 items 12, 22); "rich" to be defined exactly; FS-85's known negatives corrected in the owner's own draft before launch (the type-A lattices are not all known loose; only `L21cc6506` is, row 81). | the briefs | open |
