# FS-85 close inventory: can four-colour rigidity exist without triangles?

*Opened 2026-09-24 at minting, before the plan, under WORKFLOW step 5: every item the close will need is logged the moment it comes up,
so nothing lives only in the coordinator's context or in a scratch directory.*
- **Writer:** the coordinator (product owner) is the only writer until the close. Agents send items to the coordinator.
- **At the close:** the close planner ticks each item "done" or "declined, with the reason", and reads every number from the item's
  source.
- **What stays out:** agent ids, and anything a competitor must not read (held items by label only).

Templates: `plans/FS81-close-inventory.md` (94 items) and `plans/FS79-close-inventory.md` (106).

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | ruling (Kooshi) | **FS-85 chosen** on 2026-09-24: "I agree with the advisor's rank 1 recommendation, with rank 2 as a fallback. the rank 3 one isn't really worth anything at this point imo. Rank 1 as the next milestone." Rank 1 is this stub; rank 2 is FS-83 (character colourings at four and five colours), the fallback; rank 3 (the three-colour classification of every real number field, FS-82) is dropped from the week. | Kooshi's message; `plans/POROS-2026-09-24-algebra-week.md` §6.3 | settled |
| 2 | ruling (Kooshi) | **The finite-witness-free week, 2026-09-24 to 2026-10-01**, with the advisor's scope: no SAT, MaxSAT or #SAT; no MILP/CP or local-search colourers; no Θ relation trees or float finders; no quotient-colouring searches or survivor sweeps. Allowed: hand derivation, computer algebra, formula colourings, the Lean kernel, existing checkers on existing certificates, and exact LPs only when a derivation fixes their shape first. Kooshi: "I agree with the advisor on the scope as well." Recorded in `CLAUDE.md` § Toolchain. | Kooshi's messages; the advisor's §6.4 | settled |
| 3 | method | **The "would have searched here" log**: every brief carries it (one line per move an agent would have made by search, and what it did instead). At the close, count the lines and read what replaced them; zero lines means the ban constrained nothing. | the advisor's §6.5 | open |
| 4 | prediction | **The experiment's verdicts, registered before it starts**: Paid (a four-colour result about every colouring or every character colouring, outside K, at two independent derivations or better), Draw (only three-colour results), Null (nothing at four colours). Score at the close, with P-W3 (0.35), P-W4 (0.05), P-W5 (0.55); P-W1 and P-W2 concern the fallback FS-83. | the advisor's §6.5 | open |
| 5 | method | **The killing test**: after the competition's first round (about day 2), if neither competitor has proved that every four-colouring of de Grey's lattice restricts to stripes, nor stated with a proof what a triangle-free rigidity would require, stop and run FS-83. | the stub; the advisor's §6.3 | open |
| 6 | prior art | **Reading owed**: Hubai's 2018 comments (held threads); de Grey 2026 (ℝ³, 61 vertices, triangle-free five-chromatic); Haugstrup's pseudo-edge constructions (ℝ⁴, Polymath16, 2025–26); Heule's T721 (not held); `[CGHO2025coh]` Thm 5.8; `[MooreNewman2000]`; the Kempe-invariant literature carried from FS-79. | the stub § Reading; FS-81 inventory items 89–90 | open |
| 7 | carried (FS-81) | **Carried open from FS-81**: the Johnson papers (Kooshi obtaining; nothing claimed new until read), and the advisor's proposal to count target-moving results apart from no-gos in G72's killing test (Kooshi's call). | `plans/FS81-close-inventory.md` items 7, 10, 33 | open |
| 8 | bookkeeping | **FS-74 absorbed** as FS-85's step 1 (banner on its stub); FS-85's row in `plans/FRONTIER-STUBS.md`'s open-milestones table; `CLAUDE.md` § Paths forward's next-milestone sentence. | this row | settled |
| 9 | question (the advisor's) | **Soifer's Open Problem 55.1** (triangle-free five-chromatic unit-distance graph; 55.2 the smallest) is this milestone's question in print, recorded at FS-81's close in `CLOSED-QUESTIONS.md` §3. A yes realised over a wall-broken triangle-free field answers it; record the outcome against §3 at the close. | `CLOSED-QUESTIONS.md` §3 | open |
