*Instance sheet for job **FS106-SB**: the blind second mind on FS106-TS. The brief is `data/fs106/briefs/B106-blind-second.md`; this sheet
fills in what the planner left to the owner. Written by the product owner, 2026-09-27.*

- **Your job id:** FS106-SB.
- **Your record:** `plans/FS106-SB-verification.md`.
- **Your working directory:** `data/fs106/fs106-sb/`.
- **Your tools:** `tools/fs106_sb_*.py`.
- **Budget:** about 250k tokens by the harness's count. Hand back by 350k.

## The claims assigned to you, in priority order

For each claim, derive it blind: a proof, a counterexample, or the step where it stops. The first three come from `data/fs106/claims.md`; read
them there. The rest are quoted verbatim below from the deriver's list of theorems, and their wording is the deriver's. Definitions are in
`data/fs106/claims.md`: D-AEMAP, D-SV, D-NF, and the related ones.

1. **C-AE-POLY** (`data/fs106/claims.md` l. 119): "No polygonal colouring (D-SV Condition 8) with 6 colours is a.e.-proper (D-AEMAP)."
   `[SokolovVoronov2025]` (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`) is open to you. Use it, but verify every step of it you rely on.
2. **C-AE-CONV**: seven colours for locally finite convex tilings, almost everywhere. Its statement is in `data/fs106/claims.md` (l. 127, the entry
   for C-AE-NICE and C-AE-CONV).
3. **C-T-IND**, in this corrected form: "an index exists iff the traces change colour finitely often; K3 gives traces with no index on an open
   family of curves; with finitely many changes and C-T-L1 at the swaps, `|Ind γ₁ − Ind γ₂| ≤ 1`". Here K3 is a colour class whose boundary is a
   fat Cantor set. The original wording is `data/fs106/claims.md` l. 146.
4. **TS-C:** "a chain of same-colour regions whose closures meet has diameter `≤ 1` (any map, a.e.-proper)".
5. **TS-T:** "a point of chromaticity `≥ 3` within 1 of every point (any a.e.-proper map); with Conditions 5, 6 it is trichromatic, closing SV-L4 (a)".
   Here "SV-L4 (a)" is step (a) of `[SokolovVoronov2025]` Lemma 4.
6. **TS-U**, the unit-arc lemma: "a unit-arc boundary with colours `c | c′` puts `c` in the wedge facing it and `c′` in the wedge facing away at its
   centre, and neither in the two side cones".
7. **TS-L1:** "S–V Lemma 1 for a.e.-proper maps with no Condition 5 and no Condition 6".
8. **C5**, claimed as a counterexample: "a local configuration satisfying Prop. 5's hypothesis and every pairwise constraint, where Prop. 5's
   conclusion fails (unit arcs allowed)". This refers to `[SokolovVoronov2025]` Prop. 5. Build your own configuration, or show that none exists.

## Fences, beyond the brief's list

Do not open any of these until your stage 3 is committed:
- `plans/FS106-TS-derivation.md` and `data/fs106/fs106-ts/`;
- `plans/FS106-TQ-derivation.md` and `data/fs106/fs106-tq/`;
- `plans/FS106-V-verification.md` and `plans/FS106-VB-verification.md`;
- `data/fs106/reports/`;
- `plans/FS106-close-inventory.md`.

**Stage 4:** read the TS record only, and record every divergence, of truth and of route.
