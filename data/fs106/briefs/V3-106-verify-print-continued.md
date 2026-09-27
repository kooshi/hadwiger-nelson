*Brief for job **FS106-V3**. It finishes the sighted verification begun by FS106-V and FS106-V2: the readings, the comparison with the blind
verifier, and one edge case. Opus 5.5, 2026-09-27. Written by the product owner. **Sized for about 250k harness tokens; hand back by 350k.** Not
blind.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief;
rule 0 first.** You continue FS106-V and FS106-V2. Their briefs are `data/fs106/briefs/V106-verify-print.md` and
`V2-106-verify-print-continued.md`; read both. Their record is `plans/FS106-V-verification.md`; read it in full. You extend it in a new section
"§ Continuation — FS106-V3" and never rewrite an earlier verdict. Where you disagree with one, record the disagreement in your section.

## What is left, in this order

The order puts first what a job running beside you needs soonest.

1. **The map-six and nice-map readings.** FS106-TS, the structural job, uses them for its claims C-AE-MAP6 and C-AE-NICE. Commit them as their own
   stage as soon as each is done.
   - **Townsend's proof that maps need six**, the author's 1979 manuscript:
     `~/source/library/pdf/townsend-colouring-plane-no-monochrome-units-author-manuscript-1979-posted-2024.pdf`. It has the same title as
     `[Townsend2005]` (Geombinatorics XIV(4) 184–193); whether its text matches the published one is unchecked, so say in the record that you read
     the manuscript.
     - Verify the proof step by step.
     - Mark every step that uses the colour of a boundary point, or a region's topology. Say whether each survives when the colouring is required to
       be proper only almost everywhere.
     - Settle claim TW-81 against `[Townsend1981]` (`~/source/library/papers/townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.pdf`),
       and check the ⅔π counterexample to Woodall.
   - **`[Thomassen1999]`**, held as text: `~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`. Record:
     - its definition of a nice map, quoted verbatim;
     - its theorem, quoted verbatim;
     - its proof, verified;
     - every step that uses niceness, with whether that step survives almost everywhere.
2. **The other readings** (V106's brief, item 3), each quoted verbatim into the record, with a reading status per section and the claims TW-05, CO-04,
   WO-73, TH-99, PR-98, PA-20:
   - `[Coulson2004]` and `[Woodall1973]`: the paths are in V106's brief;
   - `[Pritikin1998]`: `~/source/library/pdf/1-s2.0-S0095895698918196-main.pdf`. Say what "almost all the plane" means there, and what regularity
     his classes have. The later pathology job needs this.
   - `[Parts2020c]`: `~/source/library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`. Record the constructions and their
     regularity.

   Propose `BIBLIOGRAPHY.md` rows; do not edit that file.
3. **Compare with the blind verifier.** Open `plans/FS106-VB-verification.md` and `data/fs106/fs106-vb/`, which are allowed to you now.
   - For every Sokolov–Voronov claim both records judged (SV-L3, SV-L4, Obs. 1, Prop. 8, SV-1, SV-2, and the rest), record every divergence, of truth
     and of route.
   - **The one that matters most:** VB gives a local counter-configuration to Observation 1, and V2 says every use of Obs. 1 has a region-only
     replacement. Does V2's replacement handle VB's configuration? If it does, SV-2's repair stands at two minds, one of them blind to it. If it does
     not, SV-2 is a GAP again, and name the step.
   - The advisor's comparison (`plans/POROS-2026-09-26-fs106-regular-half.md` stage 4) compared FS106-V's stages 1–3 with VB. Do not repeat it;
     extend it to V2's verdicts.
   - Skip stage 6's quote-check. The advisor did it (I-D1, I-D2 and I-CE verbatim; I-D4 verbatim apart from an ellipsis that drops the definition
     of `supp S_j`).
4. **Stretch, if the budget allows: SV-2's `d = 2` edge case.** Two same-multicolour points antipodal on ω, at distance exactly 2. V2 named it the
   one open step of its repair. Try to close it (rule 0: aim at repair) and say at what grade. FS106-TS has been told this edge case is yours.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Touch only** `plans/FS106-V-verification.md` (your new section only), `data/fs106/fs106-v/` and `tools/fs106_v_*.py`.
- Do not open FS106-TS's or FS106-TQ's files (`plans/FS106-TS-derivation.md`, `plans/FS106-TQ-derivation.md`, `data/fs106/fs106-ts/`,
  `data/fs106/fs106-tq/`). Standing rule 13's list applies too: the session transcripts, `chats-bak/`, and every scratchpad file you did not create.
- Commit by explicit path, with subjects "FS106-V3: stage n", and push. Never amend or force-push.
- Report under standing rule 9 to `data/fs106/reports/FS106-V3.md`, and by SendMessage to "main". Your final turn's text: "FS106-V3 idle; report sent to
  the owner by SendMessage".

Thank you.
