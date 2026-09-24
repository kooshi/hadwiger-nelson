# FS-81 close inventory: four colours over real quadratic fields

*Opened 2026-09-24 at minting, before the plan, under WORKFLOW step 5: every item the close will need is logged the moment it comes up,
so nothing lives only in the coordinator's context or in a scratch directory.*
- **Writer:** the coordinator (product owner) is the only writer until the close. Agents send items to the coordinator.
- **At the close:** the close planner ticks each item "done" or "declined, with the reason", and reads every number from the item's
  source.
- **What stays out:** agent ids, and anything a competitor must not read.

Template and precedent: `plans/FS79-close-inventory.md` (106 items).

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | method | **G72's second count.** At the close, record whether FS-81's result came through the structural question (for which d is `Θ₃` empty?) or from elsewhere. **Count target-moving results separately from no-gos**, if Kooshi adopts the advisor's proposal (item 7). | `CLAUDE.md` G72; WORKFLOW 3.3 | open |
| 2 | correction | **Frontier item 10:** "four or five for ℚ(√47) … are met" is stale. L(ℚ(√47)) = 5 (3 and 7 unusable, 11 usable; the same at every tower level, FS-66, row 75), so the conjecture predicts exactly five against a proven four. The owner checked the usability arithmetic on 2026-09-24. **Fix at the opening.** | `CLAUDE.md` l. ~187; `plans/POROS-2026-09-24-next-direction.md` §5 | open |
| 3 | correction | **The target paragraph's "one cheap exposed prediction left" (ℚ(√167))** omits ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5), where the conjecture predicts exactly five against a proven four. **G48's "so next ℚ(√167)"** skips ℚ(√47) the same way. **Fix at the opening.** | `CLAUDE.md` § The mission, G48; the advisor's record | open |
| 4 | correction | **FS-59 is no longer a falsification target.** Five over ℚ(√167) is consistent with the prediction of at least six and cannot falsify it. A falsification there needs a whole-plane colouring with five or fewer colours that is local at no prime, and only FS-64 aims at one. Reword FS-59's row in `CLAUDE.md` and `plans/FRONTIER-STUBS.md` and its stub. **Fix at the opening.** | the advisor's record §5 | open |
| 5 | reading | **The advisor's six-arena reading, to record:** ℚ(√167) is the smallest 6-open real field and every lattice over it has rank ≤ 4, so the conjecture predicts a six-chromatic unit-distance graph inside a Cayley graph of ℤ⁴ there: the cheapest arena for six by rank. The record never says this. | the advisor's record §5 | open |
| 6 | prediction | **P-G54** (FS-79, unscored at its close): step 0 of FS-79's phase 0 (Γ₂₃'s tight/slack sign at four colours) was never reported. A character sum taking seconds; score it at the opening. | `plans/FS79-invariant-question.md` §P; FS-79 §R-close errata | open |
| 7 | proposal (Kooshi's) | **G72's killing test, the advisor's proposal:** count target-moving results separately from no-gos. On that count the method is one for two (FS-73 moved a target; FS-79 produced no-gos). G72 is Kooshi's method, so this is his call. | the advisor's record §5 | open (Kooshi) |
| 8 | bookkeeping | **The stub table's rank column** repeats below rank 1 (rank 2 ×4, 3 ×6, 4 ×4, 8 ×3), so it no longer orders anything. Re-rank properly at the opening or at FS-81's close. | the advisor's record §5; `plans/FRONTIER-STUBS.md` | open |
| 9 | bookkeeping | **`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5's order of work** has been closed out since 2026-09-07. Rewrite or retire it. | the advisor's record §5 | open |
| 10 | prior art | **`[Johnson2000]` and `[Johnson2006]` are unread.** `CLOSED-QUESTIONS.md` §1.7 names them as the likeliest prior art on quadratic field planes. Read them in §PA, before any T4 claim. | `CLOSED-QUESTIONS.md` §1.7 | open |
| 11 | prior art | **"Circular coloring the plane", SIAM J. Discrete Math. 21 (2007) 461–465**: a zbMATH hit (`ab:"circular chromatic number" & ab:"unit distance"`) missing from `BIBLIOGRAPHY.md`. Every `Θ_k` point is a circular colouring, so it bears on FS-80 and FS-64 and possibly on this milestone. Add the entry with its read status. | the advisor's record §5 item 5 | open |
| 12 | question | **The advisor's open question for FS-64:** can one character of the unit-vector ring put every unit vector of a whole field in `[1/k, 1 − 1/k]`? By compactness that holds iff every lattice in the chain has a `Θ_k` point. A yes at k = 5 over ℚ(√167) falsifies the conjecture; a yes at k = 4 over ℚ(√47) falsifies its five-clause. The advisor's guess is no (a finite image reduces to `[Fischer1990]`'s additive colourings, none with few colours there), but its sketch breaks at one step. **Route it to FS-64's stub.** | the advisor's record §5 item 6 | open |
| 13 | ruling (Kooshi) | **Kooshi chose FS-81** on 2026-09-24 ("I agree"), on the advisor's "prove first", with the owner concurring. Stage design as FS-79's (a planner and a plan-phase advisor; phase 0 can start early). | this row | settled |
| 14 | process | **The push.** FS-79's work (about 60 local commits since `bdb7e133`) was not pushed at FS-81's minting. Kooshi's "I agree" was not taken as the separate word a push needs. | this row | open (Kooshi) |
