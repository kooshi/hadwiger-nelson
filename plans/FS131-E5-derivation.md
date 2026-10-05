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

*Stage 3 (2026-10-04) replaced `e5-two-g-sectors` and `e5-cv-separation` in place by their derived entries (the loop's legal move); their Stage 1 form is in git (`68ef4e85`).*

derivation: e5-two-g-sectors
  statement: in n3_end_of_not_inType's setting, with a = e α, n = e(α + π/2) and S′ = v − n, the colour g of the upper flank has at least two sectors at S′ for every small radius
  uses only: e5-sep; the stuck structure at v (stuck_flanks_ua, horn_bounds_of_noMerge); the g-shadow witnesses on both horns localized at S′ (NB3-END item 2's first sentences, I5e's localization); c ∈ P_cl(S′) (N3-DEG) and U1 on H's lower arc; the local structure at S′
  not claimed: NB3-END items 3–5, re-derived nowhere here; that the two g-sectors are horns (item 3's terminality step)
  argument: § 3.4 NB3-END item 2, derived
  verdict: derived
  grade: derived from: e5-sep
  minds: 1
  model: none expected — a step inside a refutation-shaped row (the Lean docstring's words); item 305's configuration is the case it refutes
  prior art: partly: NB3-END item 2 and N3-END item 1 assert it (this project) without the separation step; not found in print
  handoff: de Bruijn — n3_end_of_not_inType's repeated colour at S′, statement unchanged; the Terminal implementer formalizes e5-sh and e5-sep first

derivation: e5-cv-separation
  statement: in cv_class's setting, when no in-type tile of the upper flank colour g sits at E + n and none of the lower flank colour h at E − n, h has at least two sectors at E + n and g at least two at E − n, for every small radius
  uses only: e5-sep and its mirror in the line through E along a; FLANK at E with its witnesses at E ± n (FS114-CVB § 1.4 item 4); c ∈ P_cl(E ± n) (N3-DEG); U1 at a bound ±1; the local structure at E ± n
  not claimed: the other clauses of cv_class's second disjunct (each neighbour stuck or with at least four colours, N2-TERM item 2); CVB's ring tiles below, not needed
  argument: § 3.5 FS114-CVB § 1.4 item 5, and `cv_class`'s "None" case, derived
  verdict: derived
  grade: derived from: e5-sep
  minds: 1
  model: none exhibited — cv_class's model is the bowtie, which lies in the other disjunct
  prior art: partly: FS114-CVB § 1.4 item 5 and § 1.7 assert it (this project) in one line; not found in print
  handoff: de Bruijn — cv_class's second disjunct, its first two clauses, statement unchanged

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

## Stage 3 — SAVED: Q1 derived — the shadow of a horn at its antipode (SH), the separation (SEP), NB3-END item 2 and FS114-CVB § 1.4 item 5

**Frame and words.** As the Lean definitions read them (`ValidMap/Basic.lean`): at `v`, `a = e α`, `n = e(α + π/2)`, `X = frameX v α`, `Y = frameY v α`,
`N = v + n`, `S′ = v − n`; `tanHeight μ x y = y − μ(x² + y²)/2`, and `TanAbove w α μ`, `TanBelow w α μ` read it in the frame at `w` with the same axes
(`frameX S′ α = X`, `frameY S′ α = Y + 1`). A circle through `w` tangent to `a` with **upward curvature** `μ` is `{tanHeight_w μ = 0}`; `μ = 1` at `w = S′`
is `ω(v)`, `μ = −1` at `w = v` is `ω(S′)`. For `σ ∈ {+1, −1}` and `−1 ≤ ν < ν′ ≤ 1`, the horn **on side `σ`** is
`H^σ_r(ν, ν′) = {z : |z − v| < r, σX(z) > 0, tanHeight_v ν (z) > 0, tanHeight_v ν′ (z) < 0}`: `hornSet v α ν ν′ r` for `σ = +1`, and
`hornSet v (α + π) κ₃ κ₄ r = H^{−1}_r(−κ₄, −κ₃)` for `σ = −1` (turning the frame by `π` negates `x`, `y` and so the upward curvature; `tanHeight` is even in
`x`). Its **`S′`-side bound** is `ν`. The **curvature map** `f(ν) = ν/(1 + ν)` (`curvDown`) for `ν ∈ (−1, 1)`. A **unit partner** of `y` in `T` is a
`z ∈ T` with `|z − y| = 1`; `y` is in the **shadow** of `T` when it has one (`shadow` in `Basic.lean`).

### 3.1 Lemma SH — the shadow of a horn at its antipode is bounded by the concentric circle of curvature `f(ν)` [hand, one mind; SH-ID, SH-SAMPLE exact]

*Statement.* Let `H = H^σ_r(ν, ν′)` with `−1 < ν < ν′ ≤ 1`, `0 < r < 1/2`, and `μ = f(ν)`.
- **(SH1)** Every `y` with `|y − S′| < 1/2` that has a unit partner in `H` satisfies `TanAbove S′ α μ y`.
- **(SH2)** There is `ρ > 0` such that every `y` with `|y − S′| < ρ`, `σX(y) > 0` and `TanAbove S′ α μ y` has a unit partner in `H`.

*Argument.* Let `C = {tanHeight_v ν = 0}` (centre `O = v + n/ν`, radius `1/|ν|`; the line `Y = 0` at `ν = 0`); `H`'s `S′`-side boundary is the arc
`A_H = C ∩ {σX > 0} ∩ B(v, r)`.
- **(D) the vertical drop.** If `|z − y| < 1` and `q = (z − y)·n > 0`, then `|z − tn − y| < 1` for `0 < t < 2q`: `|(p, q − t)|² − |(p, q)|² = t(t − 2q) < 0`
  (SH-ID, second identity).
- **(O) the offset identity.** For `y = S′ + (X, Y′)` and `ν ∉ {0, −1}`: `|y − O|² − (1/ν + 1)² = −(2/μ)·tanHeight μ X Y′` (SH-ID, first identity; it
  fails for `μ = ν/(1 − ν)`, the planted fault). For `y` near `S′`: if `ν > 0`, `y` lies outside `C`, `dist(y, C) = |y − O| − 1/ν`, and `dist(y, C) < 1 ⟺
  |y − O|² < (1/ν + 1)² ⟺ tanHeight μ X Y′ > 0` (as `−2/μ < 0`); if `ν ∈ (−1, 0)`, `y` lies inside `C`, `dist(y, C) = 1/|ν| − |y − O|`, and the same
  equivalence holds (`1/|ν| − 1 = (1 + ν)/|ν|` squares to `(1/ν + 1)²`, and `−2/μ > 0`); if `ν = 0`, `dist(y, C) = 1 − Y′`. So, near `S′`,
  **`dist(y, C) < 1 ⟺ TanAbove S′ α μ y`.**
- **(SH1).** A unit partner `z ∈ H` (open) gives `z′ ∈ H` with `|z′ − y| < 1`; `q = (z′ − y)·n > 1/2`, and `z′` lies above `C` by less than `2q`, so (D) drops
  it to a point of `C` within distance `< 1` of `y`: `dist(y, C) < 1`, and (O).
- **(SH2).** Given such `y`, its nearest point `p` on `C` lies on the ray from `O` through `y` (`p = (X(y), 0)` at `ν = 0`), so `σX(p) > 0`, and `|p − v| → 0`
  as `y → S′`; for `ρ` small, `p ∈ A_H` and `|p − y| = dist(y, C) < 1` by (O). The points `p + tn`, small `t > 0`, lie in `H` (above `C`; below the `ν′`-circle
  since `tanHeight ν′ (p) = (ν − ν′)|p − v|²/2 < 0`; `σX > 0`; inside `B(v, r)`) and within `< 1` of `y`. The point `z₀` of the circle of upward curvature
  `(ν + ν′)/2` with `|z₀ − v| = r/2` on side `σ` lies in `H`, and `|z₀ − y|² − 1 = |z₀ − S′|² − 1 − 2(y − S′)·(z₀ − S′) + |y − S′|² ≥ (r²/4)(1 + (ν + ν′)/2)
  − 3ρ > 0` for `ρ` small (`|z₀ − S′|² − 1 = 2·tanHeight_v(−1)(z₀) = (1 + (ν+ν′)/2)|z₀ − v|²`). `H` is connected, so it holds a unit partner of `y`. ∎

*Not claimed:* (SH2) on the far side of the normal line — for `σX(y) ≤ 0` the nearest point of `A_H` is its end `v`, and the shadow near `S′` is `B(v, 1)`
(the SH-SAMPLE variant that drops this clause fails 14 of 150); and the case `ν = −1`, where `C = ω(S′)` and U1 (§ 3.2 (F5)) takes its place.
*Recognition:* (O) is FS110-N4-SHADOW's `f`, the curvature of the parallel curve at distance 1 (§ 2.3); what is new is its use between two sectors of one point.

### 3.2 The inputs at a stuck vertex, each with its address or its derivation

In `n3_end_of_not_inType`'s setting (`hF`, `hP`, `hT`, `hst`, `h3`, `hc2`, `hH : IsHorn v α (−1) κ₂ c`, `hno`):
- **(F1) The stuck structure.** `P_cl(v) = {c, g, h}`; four sectors at `v`: `H = hornSet v α (−1) κ₂` (`c`), the upper `g`-sector filling the directions
  `(α, α + π)` above both horns, `H₋ = hornSet v (α + π) κ₃ κ₄` (`c`), the lower `h`-sector; bounds in `[−1, 1]` — I5d's `stuck_flanks_ua`,
  `horn_bounds_of_noMerge` (kernel, `fs131-w5`). So `H₋ = H^{−1}(ν₄, −κ₃)` with **`ν₄ = −κ₄ ∈ [−1, 1)`**.
- **(F2) `g` near `S′` lies outside `B̄(v, 1)`.** Let `y` be a `g`-point near `S′`. If `|y − v| < 1`, `t ↦ |v + tn − y|` is increasing near `0` and passes `1`
  at some small `t₀ > 0`; `v + t₀n` lies in the upper `g`-sector: a `g`-pair at distance 1. If `|y − v| = 1`, `y ≠ S′`, the unit vector `u = v − y` is tilted
  from `n` by `β ≠ 0`, and the upper `g`-sector holds points `v + s e(φ)` with `0 < φ < β` (or `π + β < φ < π`) inside `B(y, 1)` and the point `v + (r/2)n`
  outside it: by connectedness a `g`-pair at distance 1. So every `g`-sector at `S′` lies in `TanBelow S′ α 1` near `S′`, its cone in `[α + π, α + 2π]`.
  (The mirror: every `h`-sector at `N` lies outside `B̄(v, 1)`, its cone in `[α, α + π]`.)
- **(F3) The witnesses.** No SHAVE at `v` with `σ = −1` (all of `H` above it) needs `g`-shadow on `H`, and with `σ = κ₄` in `H₋`'s frame `g`-shadow on `H₋`:
  `z_k → v` in the horn, `y_k ∈ region g`, `|z_k − y_k| = 1` (`ShaveAvailable`'s negation). Their limits lie on `ω(v) ∩ cl(region g)`, and `y_k → S′`: other
  contacts are cleared (N3-CLEAR), and `N ∉ cl(region g)` — a `g`-tile at `N` is in-type (a `g`-point near `N` outside or on `ω(v)` crosses the upper
  sector, as in (F2); a `g`-tile at `N` leaving `B(v, 1)` crosses `ω(v)` at a point other than `N`, `S′`, and that point crosses the upper sector), which
  `hno` excludes. NB3-END item 2's first sentences; I5e's localization lemmas (`horn_shadow_near_S`, `shadow_source_near_poles`, `srcG_of_shadow`, § 20.2).
- **(F4) Their directions.** Write `y_k = S′ + s e(α + t)`. For `H`: `|y_k − v| > 1` (F2) gives `sin t < s/2`, and `|z_k − y_k| = 1` with
  `|z_k − S′|² − 1 = 2·tanHeight_v(−1)(z_k) > 0` gives `(z_k − S′)·e(α + t) > s/2`; these force `t → 0` (I5e § 20.2, re-derived: `t` near `π` would need
  `X(z_k) < Y(z_k)s/2`, against `Y ≤ κ₂(X² + Y²)/2`). For `H₋`, the same with `|z − S′|² − 1 = 2Y(z) + |z − v|² > (1 + ν₄)|z − v|² ≥ 0` on `H₋` (it lies above the
  `ν₄`-circle) and `X(z) < 0`: `t → π`. So infinitely many `H`-witnesses lie in one `g`-sector `G₊` at `S′` whose cone holds `α`, and infinitely many `H₋`-witnesses
  in one `G₋` whose cone holds `α + π`, with `X > 0`, resp. `X < 0`, eventually.
- **(F5) `c` at `S′`.** `c ∈ P_cl(S′)` (N3-DEG at `v`, two minds; the out-type contact at `S′`). **U1, exact:** a `c`-point `y = S′ + s e(α + θ)` with
  `cos(θ − w) > s/2` for some `w ∈ (π/2 − ℓ_r, π/2)` (the directions `α + w` of `H`'s lower arc `A₁ ⊂ ω(S′)` inside `B(v, r)`, seen from `S′`) is within `< 1` of the
  points `S′ + (1 + ε)e(α + w)` of `H` and, for `y` near `S′`, farther than 1 from `H`'s points on its middle curve far along it
  (`|z − S′|² − 1 = (1 + (κ₂ − 1)/2)|z − v|²` there): a `c`-pair at distance 1.
  So every `c`-sector at `S′` has its cone in `[α + π, α + 2π − ℓ_r] ⊂ [α + π, α + 2π)`. With `κ₄ = 1` the same on `H₋`'s lower arc removes `α + π` too.
- **(F6) The local structure at `S′`** (`S′ ∈ dom = ℂ`): finitely many arcs meet a small disc about `S′`; the sectors at `S′` are the regions between
  consecutive half-arcs from `S′`; a half-arc with direction `α` or `α + π` is, near `S′` on its side, `{tanHeight_{S′} μ = 0}` for one `μ ∈ ℝ` (a circle or
  segment tangent to `a`); distinct ones have distinct `μ`, ordered from the `−n` side up.

### 3.3 Lemma SEP — a sector that meets the shadow pushes every same-colour horn above it into the shadow [hand, one mind; SEP-ORDER exact]

*Statement.* Valid `F`; `H = H^σ_r(ν, ν′)` a `c`-horn at `v` (a `c`-sector for all small `r`) with `ν ∈ (−1, 1)`; `G` a sector at `S′` one of whose
boundary half-arcs `γ` has direction `α` (`σ = +1`) or `α + π` (`σ = −1`), with `G` on `γ`'s `−n` side, i.e. `G ∩ {σX > 0} ⊆ TanBelow S′ α μ_γ` near `S′`;
and points `y_k ∈ G`, `y_k → S′`, `σX(y_k) > 0`, each with a unit partner in `H`. Then **no `c`-sector at `S′` with cone `{α}` (`σ = +1`), resp. `{α + π}`,
lies on `γ`'s `+n` side.**

*Argument.* By (SH1) `y_k ∈ TanAbove S′ α f(ν) ∩ TanBelow S′ α μ_γ`. Since `tanHeight μ₁ − tanHeight μ₂ = (μ₂ − μ₁)ρ²/2` identically (SEP-ORDER),
`TanAbove μ₁ ∩ TanBelow μ₂ = ∅` whenever `μ₂ ≤ μ₁`; so **`μ_γ > f(ν)`**. A `c`-sector `K` at `S′` with cone `{σ-direction}` on `γ`'s `+n` side is the region
between two half-arcs of that direction (F6), the lower of upward curvature `μ_K ≥ μ_γ`; so `K ∩ {σX > 0} ⊆ TanAbove S′ α μ_K ⊆ TanAbove S′ α f(ν)` near `S′`
(the identity again, `μ_K > f(ν)`). `K` holds points `y` arbitrarily near `S′` with `σX(y) > 0`; by (SH2) such a `y` has a unit partner `z ∈ H`. Both are
interior points of colour `c` at distance 1: `F` is not valid. ∎ *At `ν = −1`* the conclusion is (F5)'s: no `c`-sector at `S′` has the `σ`-direction at all.

### 3.4 NB3-END item 2, derived

*Claim (the conjecture `e5-two-g-sectors`).* In `n3_end_of_not_inType`'s setting `g` has at least two sectors at `S′` for every small radius.

*Argument.* (F3)–(F4) give `G₊` (cone `∋ α`) and `G₋` (cone `∋ α + π`). Suppose `G₊ = G₋ =: G`. By (F2) its cone lies in `[α + π, α + 2π]` and holds both
ends, so it **is** `[α + π, α + 2π]`: `G` fills the lower half of a small disc about `S′` between two half-arcs `γ₊`, `γ₋` with directions `α`, `α + π`, and
holds no arc. By (F5) and (F6) every `c`-sector at `S′` has its cone in `[α + π, α + 2π)` with interior disjoint from `G`'s, hence equal to `{α + π}`: a
`c`-horn `K` along `−a`, on `γ₋`'s `+n` side (a half-arc of direction `α + π` on `γ₋`'s `−n` side would lie inside `G`). If `κ₄ = 1`, (F5) removes `α + π`
as well, and `c ∉ P_cl(S′)`, against (F5). If `κ₄ < 1`, SEP with `σ = −1`, `H = H₋`, `ν = ν₄ = −κ₄`, `γ = γ₋` and the `H₋`-witnesses in `G` (with `X < 0`) leaves
`K` nowhere: contradiction. So `G₊ ≠ G₋`: two `g`-sectors at `S′`, stable for small radii by (F6); **`HasRepeatedColour (v − n)`, the colour `g`.** ∎

*Item 305's configuration* — one `g`-sector with cone `[α+π, α+2π]`, `c` only as a `c`-horn along `−a` on its `+n` side, `κ₄ < 1` — is exactly the case
refuted, **by validity alone**: the horn `K` lies above `γ₋`, `γ₋` above the circle of curvature `f(−κ₄)` (the `H₋`-witnesses are in `G`), so `K` is in the
shadow of `H₋`. I5e's leading-order bound `θ/s > τ(κ₄) = −κ₄/(2(1 − κ₄))` is `TanAbove S′ α f(−κ₄)` to first order, and the "closure property" it named
is (D). Terminality at `S′` is not used.

### 3.5 FS114-CVB § 1.4 item 5, and `cv_class`'s "None" case, derived

*The mirror.* Reflecting in the line through `v` along `a` (`Y ↦ −Y`) exchanges `N` and `S′`, sends upward curvature `μ` to `−μ`, a horn's `N`-side bound
`υ` to an `S′`-side bound `−υ`, and `TanAbove S′ α μ` to `TanBelow N α (−μ)`. So **the shadow near `N` of a horn on side `σ` with `N`-side bound `υ ∈ (−1, 1)`
is `TanBelow N α f̃(υ)` on side `σ`**, `f̃(υ) = −f(−υ) = υ/(1 − υ)` (`curvUp`, N4-SHADOW read upward), and SEP mirrored reads: *a sector at `N` meeting that
shadow, with a boundary half-arc `γ` of the `σ`-direction and lying on `γ`'s `+n` side, leaves no `c`-sector of the `σ`-direction on `γ`'s `−n` side.*

*CVB § 1.4 item 5's exclusion* — "`c`'s sectors at `N` … not in the `±a` stacks below `Q±` (such a sector would shadow part of `H±`, against N-E0)" — is
this mirrored SEP, applied with `Q₊` (the out-type `h`-sector at `N` holding `H₊`'s `h`-witnesses, CVB item 4) and `H₊` (bound `υ₊ = κ₂` in `cv_class`'s
names), and with `Q₋`, `H₋` (`υ₋ = −κ₃`); where a bound is `1`, U1 at `N` excludes that direction from `c` outright. **Derived**, for every `υ±`.

*The two sectors.* In `cv_class`'s "None" case (no in-type `g`-tile at `E + n`, none of `h` at `E − n`; FLANK then holds at `E`, CVB § 1.4 item 4):
`c ∈ P_cl(N)` (N3-DEG), and `c`'s sectors at `N` have cones in `[α, α + π]` (a `c`-point near `N` inside or on `ω(E)` crosses `H₊`: `E` lies in its unit disc
and `H₊`'s points along its lower arc, far enough out, do not, since its lower bound is `< 1`); `h`'s sectors at `N` likewise (F2 mirrored). If `Q₊ = Q₋`,
its cone is `[α, α + π]` and every `c`-sector at `N` is a horn along `+a` or `−a` on the `−n` side of `Q`'s half-arc of that direction — excluded above. So
**`h` has two sectors at `E + n`**, and by § 3.4's argument with `cv_class`'s bounds (`λ₊ = κ₁`, `λ₋ = −κ₄`; U1 on whichever lower arc is `ω(S′)`) **`g` has
two at `E − n`**. "Both lower bounds `−1`" or "both upper `1`" are CV-HD's conditions, outside "None"; one bound `±1` is handled by U1. CVB's further words —
"going from `Q₊` to `Q₋` over the top meets `c`, under the bottom `r`" — are not needed for the two sectors. ∎

### 3.6 Entries

derivation: e5-sh
  statement: for a horn H = H^σ_r(ν, ν′) at v with −1 < ν < ν′ ≤ 1 and 0 < r < 1/2, and μ = ν/(1 + ν): every y with |y − S′| < 1/2 that has a unit partner in H satisfies TanAbove S′ α μ y; and for some ρ > 0 every y with |y − S′| < ρ, σ·frameX v α y > 0 and TanAbove S′ α μ y has a unit partner in H
  uses only: the offset identity of a circle at distance 1, the vertical drop inside a unit disc, and the connectedness of the horn
  not claimed: the second half on the far side of the normal line, where the shadow near S′ is B(v, 1); the case ν = −1
  argument: § 3.1 Lemma SH — the shadow of a horn at its antipode is bounded by the concentric circle of curvature `f(ν)` [hand, one mind; SH-ID, SH-SAMPLE exact]
  verdict: derived
  grade: hand
  minds: 1
  model: ν = 1/3, ν′ = 2/3, r = 1/5, σ = −1 — SH-SAMPLE's fourth horn; prediction and truth agree at all 30 points placed about its boundary
  prior art: partly: FS110-N4-SHADOW's curvature map (this project, two minds); the curvature of a parallel curve is classical (recalled, not read)
  handoff: de Bruijn — two lemmas beside wave 5's horn geometry (statements as here, in hornSet, tanHeight and shadow)

control: e5-sh-identities
  of: e5-sh — the offset identity and the vertical drop, symbolically
  run: python3 ../tools/fs131_e5_checks.py sh-id
  expect: SH-ID identities zero: 2 of 2
  fault: python3 ../tools/fs131_e5_checks.py sh-id --plant

control: e5-sh-sampled
  of: e5-sh — prediction against an independent minimum-distance computation, five rational horns, 150 points on both sides of both boundaries
  run: python3 ../tools/fs131_e5_checks.py sh-sample
  expect: SH-SAMPLE agree 150 of 150
  fault: python3 ../tools/fs131_e5_checks.py sh-sample --plant

derivation: e5-sep
  statement: in a valid map, let H be a c-horn at v on side σ with S′-side bound ν ∈ (−1, 1), and G a sector at S′ with a boundary half-arc γ of the σ-direction, lying on γ's −n side, that holds points tending to S′ on side σ each with a unit partner in H; then no c-sector at S′ whose cone is the σ-direction alone lies on γ's +n side
  uses only: e5-sh, the identity tanHeight μ₁ − tanHeight μ₂ = (μ₂ − μ₁)ρ²/2, the local structure of sectors at S′, and validity
  not claimed: anything about c-sectors at S′ of other directions; the case ν = −1, which U1 settles outright
  argument: § 3.3 Lemma SEP — a sector that meets the shadow pushes every same-colour horn above it into the shadow [hand, one mind; SEP-ORDER exact]
  verdict: derived
  grade: derived from: e5-sh
  minds: 1
  model: none expected — its conclusion excludes a configuration; the hypotheses without a c-horn on γ's +n side are met by any horn whose antipodal sector meets its shadow
  prior art: partly: FS110-N4-SHADOW (this project); not found in print
  handoff: de Bruijn — one lemma, used twice in Terminal (n3_end_of_not_inType at S′; cv_class at E + n and E − n, mirrored)

control: e5-sep-order
  of: e5-sep — the order of circles tangent at one point
  run: python3 ../tools/fs131_e5_checks.py sep-order
  expect: SEP-ORDER identity zero: True
  fault: python3 ../tools/fs131_e5_checks.py sep-order --plant

## Stage 3 — SAVED
