JOB TC1 — DONE   harness≈350k (own≈not counted)
RESULT: text 1, G35's "(norm 2 or 4)" — TOO WIDE: right for multiquadratic F, false in general (ℚ(ζ₇)⁺'s prime of F(i) above 2 has norm 8; ℚ(√3)·ℚ(ζ₇)⁺'s has norm 64) [hand + tools exact, one mind]; TP1 right
RESULT: text 2, G56's Do — WRONG twice: its U₆₄ branch ("inert of norm 64, and the wall is broken") can never be met under G56's own definition; "over any F ⊇ K it is 5 or ≥ 7" is false at K (L = 4). Corrected: over F ⊇ K, L ∈ {4, 5, ≥ 7} [hand, one mind]; TP1 right on the first, the second is new
RESULT: text 3, CLAUDE.md item 1 — TOO WIDE, and FALSE in general given MR: K·E₇ (E₇ the septic subfield of ℚ(ζ₂₉)) contains K, keeps its wall standing (two places above 2, inert of norm 128), has L ≥ 7, and given MR needs five; true over multiquadratic fields and below degree 12 [hand, one mind, given MR]; TP1's "true over fields containing K" is WRONG
RESULT: text 4, row 139's "the map NO made uniform in the complexity bound" — WRONG as conveyed (the formula is right): C1-PW's not-claimed rules out a uniform bound; replace with "the NO's hole bound made uniform in the complexity bound" [derived from FS111-C1-UNIF, C1-PW]
RESULT: TC1-SQRT3-DYADIC — with √3 ∈ F, no place above 2 ramifies in F(i), and a place splits iff its residue degree is even; so its norm is never 64 [hand, one mind]
RESULT: TC1-DEGREE-BELOW-12 [hand] and TC1-STANDING-FOUR [derived] — a standing wall four-colours every multiquadratic field and every field of degree ≤ 11; TC1-STANDING-FIVE [derived, PARI exact, given MR] — K·E₇ above
RECORD: plans/WORKFLOW3-TC1-theory-corrections.md   COMMITS: 26e2d3ce, c46f7213, 09960627, and this report's
INVENTORY: correction owed — T1 G35's second clause: scope "(norm 2 or 4)" to multiquadratic F, add the dyadic bounds and K·E₇, with a demotion record — record § Stage 2 T1
INVENTORY: correction owed — T2 G56's Do: condition "no place above 2 ramified in F(i) or inert of norm ≤ 32"; over F ⊇ K, L is 4, 5 or ≥ 7 — record § Stage 2 T2
INVENTORY: correction owed — T3 CLAUDE.md item 1: multiquadratic or degree ≤ 11 scope, plus row 123's general condition — record § Stage 2 T3
INVENTORY: correction owed — T4 LEDGER row 139: "the map NO made uniform" → "the NO's hole bound made uniform" — record § Stage 2 T4
INVENTORY: correction owed — S1 G35's Do: call the null free only through a ramified place or one inert of norm ≤ 32 — record § Stage 2 S1
INVENTORY: correction owed — S2 G1's fourth sentence: the wall criterion scoped to multiquadratic or degree ≤ 11 — record § Stage 2 S2
INVENTORY: correction owed — S3 G1's Do: square classes only over a multiquadratic field; "Theorem B's, over K" — record § Stage 2 S3
INVENTORY: correction owed — S4 G43: "For multiquadratic F ⊇ K, 6-open ⟺ …" (K·E₇ is 6-open with its wall standing) — record § Stage 2 S4
INVENTORY: correction owed — S5 G56's exclusion: "its local bound is 4, 5 or ≥ 7", with no dyadic norm 64 over √3-fields — record § Stage 2 S5
INVENTORY: correction owed — S6 G56's enumeration clause: a standing wall four-colours below degree 12, every field FS-54 enumerated — record § Stage 2 S6
INVENTORY: correction owed — S7 CLAUDE.md § Notation, 6-open's gloss restated generally, with the multiquadratic form — record § Stage 2 S7
INVENTORY: correction owed — S8 CLAUDE.md item 2: "For multiquadratic F ⊇ K" — record § Stage 2 S8
INVENTORY: correction owed — S9 LEDGER row 53: "over multiquadratic F ⊇ K, 6-open ⟺ …" — record § Stage 2 S9
INVENTORY: correction owed — S10 LEDGER row 57: "the same algebra whose ramification set is the 2-adic wall" contradicts G35's 2026-09-22 demotion; reworded — record § Stage 2 S10
INVENTORY: correction owed — S11 LEDGER § B M58-T2: "for multiquadratic F ⊇ K" — record § Stage 2 S11
INVENTORY: correction owed — S12 LEDGER § B ASTRA-2026-09-14-T7: "not only necessary" scoped to multiquadratic F ⊇ K — record § Stage 2 S12
INVENTORY: result — TC1-SQRT3-DYADIC, TC1-DEGREE-BELOW-12, TC1-STANDING-FOUR, TC1-STANDING-FIVE, each one mind; § B lines drafted — record § Stage 1, § Stage 2 (Proposed § B index lines)
INVENTORY: prior-art debt — TC1-SQRT3-DYADIC and TC1-STANDING-FIVE: prior art owed (the gate's two warnings) — record § Stage 1
INVENTORY: statement defect — the brief frames text 4 as "corrected everywhere else" by Poros; Poros's F9 ruled row 139's own sentence "can stand". The correction is Keryx's ruling over Poros's; my verdict sides with Keryx (TP1 copied the phrase) — record § Stage 1, The readback
INVENTORY: tool defect — tools/claude_md_fact_audit.py: copies passed through --ledger/--also are read at HEAD under the same paths for the old side, so the run fails spuriously ("G21 status tag changed"); I checked the full corpus in a local clone instead — record § Stage 3
INVENTORY: slip — my first full-corpus audit ran that way and failed for that reason; I caught it and replaced it, and no verdict rests on it — record § Stage 3
INVENTORY: question for another lane — G56's "A six-chromatic number field, if one exists, contains no √11" looks unsupported (G57: 43 serves √11 without √3); flagged, not drafted — record § Stage 2, The sweep
INVENTORY: result — the first act: the grokkings skill block was in context at launch ("Base directory for this skill: /home/kooshi/source/lean-dir/.claude/skills/grokkings"; G87 opens "G87 — The invention signal: two truths that contradict,"). The preload works — record § Stage 1
HELD FOR THE COORDINATOR: whether to index the four TC1 theorems in LEDGER § B (lines drafted; TC1 is not a milestone)
HELD FOR THE COORDINATOR: filing aid — `python3 data/workflow3/tc1/tc1_apply.py` holds all sixteen (old, new) pairs and refuses unless each old text occurs once; it writes scratch copies only
HELD FOR THE COORDINATOR: the drafts cite this record for the lemma and K·E₇ until they get a ledger or § B home; K·E₇'s grokking home is G35 (T1)
