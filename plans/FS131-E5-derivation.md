# FS131-E5 — two steps the kernel could not take: NB3-END item 2 (`n3_end`'s first case) and `bend_away`'s end case

*Ephodos (the deriver), job FS131-E5, brief `data/fs131/briefs/FS131-E5-two-steps.md`, claim list `data/fs131/claims-E5.md`. Main tree, branch `main`.
Started 2026-10-05 03:07 UTC (the brief's 2026-10-05 is UTC). No fences (inventory ruling 1).*

## Theorems this phase proved

*(Filled at each stage.)* None at Stage 1.

## Fence log

Nothing in this job is fenced. No fenced text met.

## Stage 1 — SAVED: readback, the questions restated, predictions registered

### 1.1 Quotation check (standing rule 3)

`tools/fs131_e5_readback.py` checks, after collapsing whitespace: the claim list's five Lean blocks against `a804de21` (`Terminal.lean`: `n3_end`,
`n3_end_of_not_inType`, `cv_class`) and `71cca146` (`UnitArc.lean`: `bend_away`, `r2Contacts`); its NB3-END excerpt against
`plans/FS112-NB3-verification.md`; its two FS114-CVB excerpts against `plans/FS114-CVB-verification.md`; the brief's two question quotations against the claim
list; the brief's three inventory quotations (items 305, 296, 306) against `plans/FS131-close-inventory.md`. **18 of 18 exact**, exit 0
(`data/fs131/e5/readback.out`). Control: `--plant` changes one character of the first quotation; the run reports 1 failure and exits 1 — it fires.
One oddity, not a mismatch: the claim list's NB3 excerpt carries the next heading of its source, "### 1.5 Summary of stage 1", as a trailing line.

### 1.2 Read, in this order

`plans/STANDING-RULES.md`; the claim list in full; inventory items 288–291, 296, 305–307, 310–311, 313, 315; NB3 stage 1 and stage 2
(`plans/FS112-NB3-verification.md` l. 53–331); `plans/FS112-N-proof.md` l. 82–137 (the walk's three facts and its table), l. 387–455 (N2-3: N2-SIGN, ENV,
TOWARD, AWAY, TAN, RED), l. 852–882 (N3-END); `plans/FS112-derivation.md` l. 70–115 and 186–250 (FS112-N2-BENDS, LOCK, ISO, FLANK, END, N2-FLANK-Q, N3-END,
C-ENDS, C-HORNEND, C-DOUBLE); `plans/FS112-NB2-verification.md` l. 150–188 (NB2's TOWARD, AWAY, TAN); `plans/FS114-CVB-verification.md` l. 60–205
(frame, § 1.4–1.8); I5d's Stage 18 and I5e's § 20.2 in `.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md` (at `58a03d6e`); I4n's Stages 41 and 43
(`git show fs131-w4ba:plans/FS131-I4-implementation.md`, l. 1396–1441, 1484–1560); the Lean definitions `IsHorn`, `hornSet`, `tanHeight`, `IsFlankAbove/Below`,
`IsContact`, `InType`, `OutType`, `ShaveAvailable`, `IsStuck`, `HasSectors`, `HasRepeatedColour`, `BothKind`, `radiusTwoArc` (`ValidMap/Basic.lean` on
`fs131-w5`), `ArcMap`, `Valid` (`ArcMap.lean`), `IsRingArc`, `OnRingArc`, `ringArc` (`LocalMap.lean`), `AgreesOff`, `RingArcsWithin` (`ValidMap/Basic.lean`).

### 1.3 The questions, verbatim (`data/fs131/claims-E5.md` § The questions)

> **Q1 — NB3-END item 2.** In `n3_end_of_not_inType`'s setting, does "the two `g`-tiles are two sectors of `g` at `S′`" hold — in particular in item 305's configuration (one `g`-sector at `S′` with cone `[α+π, α+2π]`, `c` carried at `S′` only by a `c`-horn along `−a` on the `+n` side of it, possible only when `κ₄ < 1`)? Answer with a derivation of the step (I5e's leading-order repair, made exact with the closure property it names, or another), or that configuration exhibited exactly, or a repaired statement of `n3_end_of_not_inType` and `n3_end` with what changes in FS112-N3-END and in row 135. The same exclusion is FS114-CVB § 1.4 item 5's "not in the `±a` stacks below `Q±` (such a sector would shadow part of `H±`, against N-E0)", stated there in one line, which `cv_class`'s second disjunct reads through § 1.7's "None" case (item 307): answer for it too — derived, or `cv_class` repaired, with what changes in FS114-CV-HD and row 137.
> 
> **Q2 — `bend_away`'s end case.** In `bend_away`'s setting, at the arc's end `q_A`, where `ω(A)` (curvature 1) bounds the uncovered region beyond the arc's end (item 296's fourth piece), does the tangent bend go through? Answer with a derivation of the end case, or a configuration exhibited exactly, or a repaired statement of `bend_away`, with what changes in FS112-N2-BENDS (N2-TAN) and in row 135.
### 1.4 The targets, and the registered predictions (before any written derivation)

*Disclosure:* registered after the reading above, in which both routes were sketched in my head; so these are informed, not blind, and are scored at the end.

| id | prediction | p | what it decides |
|---|---|---|---|
| E5-P1 | Q1, NB3-END item 2: **derived exactly** — in `n3_end_of_not_inType`'s setting `g` has two sectors at `S′`; item 305's configuration is refuted by validity alone (a `c`-point of the `−a` horn at `S′` meets `H₋` at distance 1); no statement changes | 0.85 | whether the `Terminal` implementer proceeds on the statements as they stand, or a repair is drafted |
| E5-P2 | Q1, FS114-CVB § 1.4 item 5: **derived by the same lemma**, both its exclusion and the two sectors at `N` (and at `S′`) in `cv_class`'s "None" case; `cv_class` unchanged | 0.80 | whether `cv_class`'s second disjunct needs a repair |
| E5-P3 | Q2, `bend_away`'s end case: **derived** — a tangent start at `A` of curvature in `(0, 1)` keeps every lens point's unit disc off the region beyond the arc's end that `ω(A)` bounds, so only the arc side meets `N2-TAN`'s comparison with the radius-2 circle; `bend_away` unchanged (with `hdom`) | 0.75 | whether `bend_away`'s job starts on the repaired statement, or a second repair is drafted |

Each is scored in the last stage. A "no" on any of them is a result of the same standing (standing rule 4).

### 1.5 The targets, stated as conjectures (to be replaced in place by derived entries, or by stated stalls)

derivation: e5-two-g-sectors
  statement: in n3_end_of_not_inType's setting, with a = e α, n = e(α + π/2) and S′ = v − n, the colour g of the upper flank has at least two sectors at S′ for every small radius
  uses only: not yet derived
  not claimed: anything about items 3–5 of NB3-END
  argument: § 1.4 The targets
  verdict: gap: not yet derived — Stage 2
  grade: hand
  minds: 1
  model: not yet exhibited
  prior art: owed
  handoff: none — a conjecture

derivation: e5-cv-separation
  statement: in cv_class's setting, when no in-type tile of the upper flank colour g sits at E + n and none of the lower flank colour h at E − n, h has at least two sectors at E + n and g at least two at E − n, for every small radius
  uses only: not yet derived
  not claimed: the other clauses of cv_class's second disjunct
  argument: § 1.4 The targets
  verdict: gap: not yet derived — Stage 2
  grade: hand
  minds: 1
  model: not yet exhibited
  prior art: owed
  handoff: none — a conjecture

derivation: e5-bend-end
  statement: in bend_away's setting, at an end A = P + e θ₁ of the arc with θ₁ ∈ C₂ (the r2Contacts set), an away lens bounded near A by a circle tangent to ω(P) at A of curvature κ ∈ (0, 1) close enough to 1 is clear for the inner colour c near A
  uses only: not yet derived
  not claimed: the interior of the arc, which N2-TAN covers
  argument: § 1.4 The targets
  verdict: gap: not yet derived — Stage 3
  grade: hand
  minds: 1
  model: not yet exhibited
  prior art: owed
  handoff: none — a conjecture

## Stage 1 — SAVED
