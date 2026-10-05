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

## Stage 2 — SAVED: recognition, run on each claim (`ephodos-recognition`, invoked fresh)

### 2.1 Q1 — the stall read, and the stranger

**The stall.** A step asserted by both minds and derived by neither: N3's "two `g`-sectors … separated by `c` below and by `r′` or `h` above"
(`plans/FS112-N-proof.md` l. 860–861) and NB3's "`c ∈ P_cl(S′)` …, its sectors in `α`'s away cone (U1), below: the two `g`-tiles are **two sectors**"
(`plans/FS112-NB3-verification.md` l. 236–237); CVB's "not in the `±a` stacks below `Q±` (such a sector would shadow part of `H±`, against N-E0)"
(`plans/FS114-CVB-verification.md` l. 100). I5e's leading-order repair names the missing property: a monotonicity ("closed upward") of a shadow near `S′`.
Shape of the stall: *an answer found (to leading order) and not derived* — the property is a fact about one circle family, said in the costume of tiles.

**For a stranger — a differential geometer.** *Let `C` be a circle (or line) through the origin `v`, tangent there to the `x`-axis, of signed curvature `ν ∈
(−1, 1)` (positive when its centre lies on the `+y` side), and let `A` be a short open arc of `C` with one end at `v`, on the side `x < 0`. Let `S′ = (0, −1)`.
Describe, near `S′`, the set of points `y` with `dist(y, A) < 1`.* This is **the 1-neighbourhood of a circular arc, i.e. a parallel (offset) curve**: away
from the arc's endpoints it is bounded by the concentric circle at distance 1, whose curvature is `ν/(1 + ν)` — the classical curvature of a parallel curve at
distance `d`, `κ/(1 + dκ)` (recalled, not read; re-derived exactly below) — and beyond the endpoint `v` by the unit circle about `v`. In this project's own
words it is **FS110-N4-SHADOW's curvature map `f(λ) = λ/(1 + λ)`** ("an arc at `P_{k+1}` of upward curvature `λ` shadows at `P_k` along the concentric circle of
curvature `f(λ)`", `curvDown` in `ValidMap/Basic.lean`) — held, two minds, one blind — used so far only along a stuck chain, never at a chain's end between
two sectors of one point.

### 2.2 Q1 — the features, sorted (receipts: the argument of § 3, and the controls of `tools/fs131_e5_checks.py`)

| feature | sort | receipt |
|---|---|---|
| validity (N-E0: no `c`-point at distance 1 from `H₋`) | determines | consumed at the last step; the planted fault in SEP-SAMPLE (a `c`-point allowed in the shadow) is the configuration of item 305 |
| `H₋`'s bound on the `S′` side, `κ₄`, through `ν₄ = −κ₄` | determines | the shadow's curvature is `f(ν₄)`; at `κ₄ = 1` the shadow is a full one-sided neighbourhood (U1 instead) |
| the `H₋`-witnesses lying in the `g`-sector `G` at `S′` | determines | consumed as "`G` meets the shadow", hence `μ_G > f(ν₄)` |
| one `g`-sector with cone `[α+π, α+2π]` (item 305's case) | consumed only through "every other sector along `−a` lies on `G`'s `+n` side" | the order of circles tangent at `S′` (exact) |
| `c ∈ P_cl(S′)`, its cone in the closed lower half-plane | determines | the `c`-horn `K` exists and is tangent to `±a`; N3-DEG and U1 |
| terminality at `S′`, six colours, Condition 5 | accompany | the argument runs without them |
| `H`'s lower bound `κ₁ = −1` | accompanies the separation; determines only which side `c` can sit on | with `κ₁ > −1` the same lemma applied to `H` excludes a `c`-horn along `+a` (§ 3.4, the CVB use) |
| `hno` (no in-type `g` at `N`) | determines the localization of the witnesses at `S′` | a `g`-tile at `N` would be in-type (§ 3.2) |
| the stuck structure at `v` (flanks filling the half-discs) | determines "`g` near `S′` lies outside `B̄(v, 1)`" | § 3.2 |

### 2.3 Q1 — homes, tested

1. **This project's own: FS110-N4-SHADOW** (the curvature map `f`). *Old proofs apply at once:* the shadow of a circle-bounded set is the offset of its
   boundary circle — nothing changes but the reading point (`S′`, a chain's end). *Exceptions vanish:* `κ₄ = 1` is `f(−1) = −∞`, the limit (U1); the
   CVB mirror at `N` is `f̃(υ) = υ/(1 − υ)` (`curvUp`), the same map read upward. *Predicts a neighbour:* at `N` the shadow of `H₊` is
   `TanBelow N α f̃(υ₊)` — CVB's item 5 with no new idea (checked in § 3.4). **Adopted.**
2. **Classical differential geometry: parallel curves.** The same object, with no tiles; supplies the formula and its exact form (concentric circles).
   Merged with 1: one dictionary (`upward curvature ν` ↔ signed curvature; `shadow near S′` ↔ `1-neighbourhood seen from the far side`).
3. **Mathematical morphology (dilation by the unit disc).** The shadow of `H₋` is `(H₋ ⊕ B) ∖ (complement)`-type: `{y : dist(y, H₋) < 1}` minus the points
   whose unit disc swallows `H₋`. Tested: it explains why only the **boundary arc** nearest `S′` matters (the vertical drop, § 3.1 (D)), and predicts nothing
   more. Kept as the reason for step (D), not as a home.

**The transfer, its one changed step named.** N4-SHADOW's use compared a horn at `P_{k+1}` with the sector at `P_k` that shadows it. Here the comparison is
**between two sectors of one point `S′`** (the shadowing `g`-sector `G` and the `c`-horn `K`), through the strict order of circles tangent at `S′`. And the
arc has an **endpoint at `v`**, so the identity "shadow = above the concentric circle" holds only on the horn's side of the normal line (`frameX < 0` for
`H₋`); that is the half (E2) needs, and (E1) needs none.

### 2.4 Q2 — the stall read, and the stranger

**The stall.** I4n's reading (`fs131-w4ba`, record l. 1532–1535): "at an end of the arc the uncovered region near `q_A` is bounded by `ω(A)` (curvature `1`,
tangent to the radius-2 circle at `q_A`) on the far side, so a class hugging `ω(A)` from outside is not covered by (4)'s curvature `< 1/2` analysis". Shape:
*a known theorem that almost applies* (N2-TAN), one hypothesis (the radius-2 comparison) failing beyond the end.

**For a stranger — a plane geometer.** *Two unit circles `ω(A)`, `ω(z)` with centres a small distance apart; where does the disc `B̄(z, 1)` stick out of
`B(A, 1)`?* This is **the radical axis**: for two circles of equal radius it is the perpendicular bisector of the centres, and `B̄(z, 1) ∖ B(A, 1)` lies in the
closed half-plane on `z`'s side of it — exactly, `2p·(z − A) ≥ |z|² − |A|²` (with `P = 0`). For `z` on `P`'s side of the tangent line to `ω(P)` at `A`, that
half-plane misses the quadrant beyond the arc's end on `A`'s side of `P` (§ 4.1, Claim E).

### 2.5 Q2 — the features, sorted

| feature | sort | receipt |
|---|---|---|
| the lens lies on `P`'s side of the tangent line at `A` (tangent start of curvature `κ > 0`) | determines | Claim E's hypothesis; the planted fault (a corner lens, height `≍ ψδ`) reaches beyond the end — NB2's "blocks a wedge lens" |
| the far tile's boundary beyond the end (hugging `ω(A)` or not) | **accompanies** | Claim E holds for every point beyond the end outside `B(A, 1)`, whatever its tile; I4n's worry is about this feature |
| the far tile's boundary on the arc side, curvature `κ_Y < 1/2` against the radius-2 circle | determines | N2-TAN's cap comparison, one-sided (§ 4.2) |
| `hdom` | determines | `C₂` a finite union of points and closed intervals; the sector structure at `q_A` |
| `A` a vertex, or an interior point of a longer arc of `Γ` on `ω(P)` (`IsRingArc` does not ask maximality) | accompanies | Claim E reads no arc beyond `A` |
| the inner/outer tiles' sectors at `A` (a horn of `T_out` bounded by `σ`) | determines the admissible `κ` interval `(max(0, κ_σ, κ*), 1)` | nonempty since `κ_σ < 1` |

**Home:** N2-TAN itself (two minds), with the radical axis supplying the one changed step — at an end, the beyond side is not compared with the radius-2
circle at all; it is empty for the tangent-start lens.

**Prior art for both:** the parallel-curve curvature and the radical axis are classical (recalled, not read); their use here is internal to this project's
calculus of valid arc maps, whose lemmas are not found in print (`plans/FS112-derivation.md` marks every FS112 lemma so). No search run for these
two local lemmas beyond that; the entries say "partly".

## Stage 2 — SAVED
