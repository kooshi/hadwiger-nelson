# Rulings quoted by script (FS131-K3b stage 1)

From `plans/FS131-close-inventory.md` items 26-28 and `plans/LEAN-BACKLOG.md` § C137 (main tree at `da5303b4`, merged into `fs131-w3` at `4b363881`).

> 26. **Generalizations** (K3, "For stage 3"): FS116-N1-GERM-R in every valid map (its covering hypothesis idle); FS116-V4-TWIST without the covering
>     hypothesis and "when p is a vertex"; FS116-N1-TWIST-D at any point; FS116-N1-GERM-S, -RING-Q-PRIME-S, FS129-SR2-TOUCHW, FS116-N1-QFREE4,
>     FS116-N2-FIVERING at any k for their count of absent colours (the arguments read the count, not six); FS116-N1-ECHO with radius 2, essential boundary
>     and density idle; FS129-OR1-WHOLE's R₂ clause for any arc whose inner side is one tile; FS116-S1-EXIT on the left derivative at `t_e` alone;
>     FS116-Y4-FLANK's edge clause for any tiles bordering the two edges. For the record job's errata.

> 27. **Ruling — wave 3 takes the local-structure lemmas forward from wave 4** (K3's held decision): finitely many tiles meet a small disc about any point;
>     the germ dichotomy; in a simple map each tile's cone at a point is one closed interval — as `Plane/LocalStructure` on `fs131-w3`. Alternative weighed:
>     state the tile-literal conclusions only after wave 4, leaving FS116-V5-U1's last clause and FS129-OR1-WHOLE's covering clause unstated in wave 3. Why:
>     the lemmas are the local foundation both waves read, wave 4 follows wave 3 in the order, and a row stated in two halves across waves is a seam a
>     later reader can miss. Wave 4's planner is told its foundation list shrinks by these three. Confidence: high.

> 28. **Slip, the coordinator's** (found by K3): FS131-K3's brief named four rows merging into wave 3; there are six — FS112-SIX into FS116-N2-FIVERING and
>     FS129-SR1-SIXQ, and FS116-RING-TRANSFER-C into FS116-N2-FIVERING and -N2-SIXRING were missed, because Keryx's script matched `merged_into` by exact
>     equality and both have two targets. K3 carried both. Rule for later briefs: split `merged_into` on `;` (the check is now run that way, this commit's
>     session). FS131-K2's brief was built by the same script; its wave's merges re-checked with the split: none missed.

> 137. **Wording defects for the Lean list** (Z1): FS129-SR1-BENDLE3 omits FS129-OR1-BEND3's tile clause (BENDANY carries it); FS129-SR1-RINGBAND
>      omits FS129-OA1-RINGWIND's periodicity clauses; no merged form drops a hypothesis its source needed. For FS129-L1, with items 116, 126, 131.
