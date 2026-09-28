# FS111-M4 — route M, round 4: the cascade (a pinch in a partition, and where it goes)

*Job FS111-M4 (de Bruijn, Opus 5.5), opened 2026-09-28. Brief: `data/fs111/briefs/M4-111-cascade.md`, which points to FS111-M's brief
`data/fs111/briefs/M-111-regularity.md` and to `data/fs111/briefs/STANDING-RULES.md` (rule 0 read first); where they differ the round-4 brief wins.
Working files: `data/fs111/fs111-m4/`; tools `tools/fs111_m4_*.py`. Saved in stages; each stage's section is headed "Stage n — SAVED" and committed
before the next begins. Notation: M3's (`plans/FS111-M3-finiteness.md` header and §1.6: HC, the edge frame, `g`, `ℓ`, `U`, `Λ_e`, the slivers) and
round 1's (`plans/FS111-M-regularity.md` §3: saturated, (H1), (H2), M-PINCH's (split) and (tangent) cases, M-C11). This record adds, for a closed set
`X` and `n > 0`, the **upper and lower `n`-parallels** of a graph `t = β(s)`: `β^{+n}(s) = sup{p_t + (n² − (s − p_s)²)^{1/2} : p ∈ graph β, |s − p_s| ≤ n}`
and `β^{−n}(s) = inf{p_t − (n² − (s − p_s)²)^{1/2} : …}` — the upper and lower boundaries of the `n`-neighbourhood of the graph (so `(β^{+1})^{+1} =
β^{+2}`, dilations composing).*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address)*

*(filled as stages land)*

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.

## Fence log (standing rule 13)

- Stage 1: the start-up git status printed the names of four untracked W files (`data/fs111/fs111-w/blocks.out`, `hex7_free.out`, `hx_pairs.out`)
  and one FS-114 file name (`data/fs114/fs114-yb4/yb3-calib-rerun.out`), and `git log` printed FS-114 commit subjects: names and subjects only, nothing
  opened. No transcript, `chats-bak/` file, foreign scratchpad file, close inventory, other brief or FS-114 file was opened.

## Stage 1 — SAVED: resuming check; quotation check; the object named

### 1.0 Resuming check

`plans/FS111-M4-cascade.md` and `data/fs111/fs111-m4/` did not exist at start: fresh start at stage 1.

### 1.1 Files read, in order

The round-4 brief; `data/fs111/briefs/STANDING-RULES.md`; FS111-M's brief; `CLAUDE.md` § The aim and § Counter-priors (in context);
`plans/FS111-M3-finiteness.md` in full; `plans/FS111-M2-regularity.md` §1.4–§1.6 (M2-COV, M2-ZERO, M2-INT, M2-FIX, DISC7), §3.1–§3.3 (M2-SELCOMP,
M2-REDUCE-C), §4.1–§4.3 (M2-INTRAD, M2-DISCK7); `plans/FS111-M-regularity.md` §2 (M-SATC, R7, M-DEADLOCK) and §3.1–§3.5 (M-PINCH, M-C11, M-EXTREME,
controls); `plans/FS111-VM2-verification.md` (its REDUCE-C and D3 rows, by grep).

### 1.2 Quotation check (standing rule 5)

The round-4 brief puts no statement in quotation marks; its summaries of round 3 are paraphrases, checked against their sources:

| # | the brief's summary | source | verdict |
|---|---|---|---|
| 1 | HC_K: "a regular maximal unit-avoiding set whose bands pinch on a Cantor set, with infinitely many interior components per period" | M3 theorem line M3-HC: "infinitely many components of the interior in every disc of radius 3 about a face centre" | faithful (every period contains a face centre's disc of radius 3) |
| 2 | "MUA-FIN-U is FALSE, and local finiteness is not free" | M3-FIN-U | faithful |
| 3 | M3-MOVE: "one class alone can be moved, arbitrarily little, to remove its pinches" | M3-MOVE (1)–(3) | faithful |
| 4 | M3-COVER: "the move keeps it maximal exactly when the removed sliver is covered by other classes" | M3-COVER: "iff `L_τ ⊆ ⋃_{b ≠ j} F_b` a.e." | faithful |
| 5 | M3-CASCADE: "the class that absorbs the removed sliver must give up its own material at distance 1 from it, and so on" | M3-CASCADE: "every such `b` loses (a.e.) all of `F_b ∩ {φ_{G_b} > 0}`", `G_b = F′_b ∖ F_b` | faithful with one nuance: the source's gainer takes `G_b`, a positive-measure part of what was lost, not necessarily the whole sliver |
| 6 | "No partition containing an HC-type class is held" | M3 §3.3: "I have no regular maximal partition with an HC-type class" | faithful |
| 7 | "by M2-REDUCE-C (two minds) any statement at `k = 5` that yields a locally finite regular maximal five-cover is equivalent to `χ_m⁰ ≥ 6`" | VM2 §3 row 1 ("an equivalence at five given AE-MAP6 (both minds say so)"; VM2-EQ5) and M3 §3.1 | faithful, read as the conditional form ("if a maximal five-cover exists, a regular locally finite one exists"), over FS106-AE-MAP6's grade; VM2's D3 clause ("meeting only at endpoints") is part of "locally finite" |
| 8 | standing rules' quotations of Kooshi | `CLAUDE.md` § Counter-priors, § Toolchain, § Publication | verbatim (checked by M3 at its stage 1; the file is unchanged in those sections) |

### 1.3 The object of this round, named

A **regular maximal partition** is a `k`-tuple of regular MUA sets `F_1, …, F_k` with pairwise null overlaps and full union: a measurable fall colouring
(M2-ZERO's reading), and **saturated** (M2-SELCOMP (d)): every essential boundary point of a class is at distance exactly 1 from that class's support.
An **HC-type class** is one containing a **pinched layer**: over an interval `I` of a line, a region `{0 < t < β(s)}` (in coordinates with the line as
`t = 0`) of the class, bounded below by the flat segment and above by a graph `β ≥ 0` vanishing exactly on a closed null set `Z` with infinitely many
gaps. The brief's two questions are about how such a layer sits among the other classes. The instrument this round uses is round 1's M-PINCH: at a
saturated two-colour interface point it puts the two colours' contacts at distance 1 along the normal, one on each side, and the material near each
contact beyond the unit parallel. Applied to a pinched layer it gives a **ladder**: the pinch at distance 1 above and below, in the neighbouring
classes (stage 2), and a bound on how far the ladder can run before it meets the singular set (stage 3).

## Stage 1 — SAVED

## Stage 2 — SAVED: M4-LADDER — in a saturated partition a pinched layer pinches both neighbouring classes, one unit away, on the same set

### 2.1 Statement

**Setting.** `f` is an honest a.e.-proper colouring that is **saturated** (every essential boundary point of `S_j` is at distance exactly 1 from
`supp S_j`); every regular maximal partition is one (M2-SELCOMP (d)). In coordinates `(s, t)`: `I` an open interval; `β : I → [0, 1/2)` continuous;
`G = {β > 0}` (its components are the **gaps** `J`), `Z = I ∖ G` closed with empty interior; on `G`, `β` is `C²` with curvature `|κ_β| < 1`;
**(R)** within `I × (−2, 2)` the regions `{t > β(s)}` and `{t < β(s)}` are unions of open unit discs. Colours `a ∉ {b, c}` (`b = c` allowed). The
layer is `Λ = {s ∈ I : 0 < t < β(s)}`. Parallels `β^{±1}` as in the header.

**Hypotheses, at every `s ∈ G`.** (A) a ball about `(s, 0)` in which `S_a = {t > 0}` and `S_b = {t < 0}` a.e., and a ball about `(s, β(s))` in which
`S_a = {t < β}` and `S_c = {t > β}` a.e. (B) (H1) and (H2) (round 1 §3) at `(s, 1)`, `(s, −1)` and at the points of the curves `t = β^{+1}`,
`t = β^{−1}` over `s`.

**M4-LADDER** [hand, one mind; over M-PINCH and M-C11 (round 1, one mind each)]. *For every gap `J`:*
1. *(Contacts.) Every interface point of `Λ_J` is of type (tangent). On the flat side `(s, 0)`: the `a`-contact is `(s, −1)`, the `b`-contact
   `(s, 1)`. On the curved side `x = (s, β(s))`, with `n(x)` the upward unit normal: the `a`-contact is `x + n(x)`, the `c`-contact `x − n(x)`.*
2. *(The rungs.) `W⁺_J = {s ∈ J : 1 < t < β^{+1}(s)}` and `W⁻_J = {s ∈ J : −1 < t < β^{−1}(s)}` are `a`-free (`|W^±_J ∩ S_a| = 0`); their
   thicknesses `β^{+1} − 1` and `β^{−1} + 1` are positive on `J` and vanish on `Z`.*
3. *(Who is there.) Near every `(s, 1)`, `s ∈ J`: `S_b = {t > 1}` and `S_d = {t < 1}` for one colour `d = d(s) ∉ {a, b}`; near every point of
   `β^{+1}` over `J`: `S_a = {t > β^{+1}}`. Symmetrically near every `(s, −1)`: `S_a = {t < −1}`; near every point of `β^{−1}` over `J`:
   `S_c = {t < β^{−1}}`, and the colour above is not `a` or `c`.*
4. *(The pinch propagates.) `int F_b` has at least one component inside each `W⁺_J` and none crossing its boundary; `int F_c` likewise in each
   `W⁻_J`. So if `G` has infinitely many gaps in a bounded set, **`b` and `c` are pinched on the same `Z`**: infinitely many interior components
   accumulating at `Z × {1}` (for `b`) and `Z × {−1}` (for `c`), each class's boundary arcs meeting on that infinite set (VM2's D3 fails for them).*

### 2.2 Proof

(1) At `x = (s, 0)`, `s ∈ J`: (A) gives (H1) and (H2) (two colours in a ball, each a.e. an open half-ball, connected, `x` in both closures); `x` is an
essential boundary point of `a` and of `b`, hence saturated for both. M-PINCH gives (split) or (tangent). (split) makes the interface near `x` an arc
of a unit circle (M-C11 (iii)); the interface is the segment `t = 0`, curvature 0. So (tangent): two open unit discs tangent at `x` from opposite
sides, `B(y_a, 1) ∩ N ⊆ S_b` and `B(y_b, 1) ∩ N ⊆ S_a`; `b` is below, so `y_a = (s, −1)` and `y_b = (s, 1)`. At `x = (s, β(s))` the same, the
curvature being `|κ_β| < 1`: `y_a = x + n(x)` (its disc lies on `c`'s side, above), `y_c = x − n(x)`.

(2) *`a`-freeness.* Let `z = (σ, t) ∈ W⁺_J`. By (R) the upper boundary `β^{+1}` near `σ` is the image of the normal map `x ↦ x + n(x)` (every point
of `{t > β}` near the graph lies in an open unit disc above the graph, so each point of `β^{+1}` has a unique nearest graph point, reached along its
normal; `|κ| < 1` makes the map a local diffeomorphism), so `z` below `β^{+1}` has `dist(z, graph β) < 1`, the nearest point at a graph point over
`J`; and `|z − (σ, 0)| = t > 1`. On the open connected set `Λ_J` the distance to `z` therefore takes values below 1 (just under the nearest graph
point) and above 1 (just above `(σ, 0)`), so `T₁(z) ∩ Λ_J` contains an open arc: `φ_{S_a}(z) > 0`. As `f` is a.e.-proper, `φ_{S_a} = 0` at almost
every point of `S_a`; so `|W⁺_J ∩ S_a| = 0`. For `z = (σ, t) ∈ W⁻_J`: `|z − (σ, 0)| = |t| < 1`, and `z` below `β^{−1}` has every graph point at
distance `> 1`, so points of `Λ_J` just under the graph near `(σ, β(σ))` are at distance `> 1`: again an open arc of `T₁(z)` in `Λ_J`.
*Thicknesses.* For `s ∈ J`, `β^{+1}(s) ≥ β(s) + 1 > 1` and `β^{−1}(s) > −1` (the infimum over the compact piece of graph within 1 is attained, and
`p_t − (1 − (s − p_s)²)^{1/2} = −1` only at `p = (s, 0)`, i.e. `s ∈ Z`). For `z ∈ Z`: `β^{−1}(z) ≤ β(z) − 1 = −1 ≤ β^{−1}(z)`. And `β^{+1}(z) = 1`
iff the open disc `B((z, 1), 1)` misses the graph; by (R) the points `(z, ε)` lie in open unit discs above the graph, whose limit as `ε → 0` is a
closed unit disc through `(z, 0)` with interior in `{t > β} ⊆ {t > 0}`, i.e. `B̄((z, 1), 1)`: so `β^{+1}(z) = 1`.

(3) *At `(s, 1)`.* `(s, 1) ∈ supp S_b` (the `b`-contact). A point `z = (σ, 1 − ε)` near it is at distance `≈ 1 − ε < 1` from `(σ, 0⁻)` and
`≈ 1 − ε + η > 1` from `(σ, −η)`, both in `b`'s half-ball at `(σ, 0)` for small `ε < η`: an open arc of `T₁(z)` in `S_b`, so `z` is a.e. not in
`S_b`. Hence `b` has positive measure in `{t > 1} ∩ B((s, 1), r)` for every `r`. By (H1) at `(s, 1)` exactly two colours are present there, `b` and
some `d`; `d ≠ a` because `a`-points just under `(s, 1)` and `a`-points of `Λ` at `(σ′, t′)`, `t′ ∈ (0, β)`, would be at distance exactly 1 on a
set of positive pair measure (for `(σ, 1 − ε)` and `t′` small the circle `T₁((σ, 1 − ε))` crosses `Λ` in an arc near `(σ ± (2(ε + t′))^{1/2}, t′)`),
and `d ≠ b` below `t = 1` as shown. By (H2), `S_d` in the ball is a.e. a connected open set `P_d` that contains `{t < 1}` (all of it: `b`-free and
`a`-free there, and only `b`, `d` present). If `P_d` also had points above `t = 1`, a path in `P_d` would cross the line `t = 1` at a point of
`J × {1}` (the ball is small), which lies in the open set `P_d` (a.e. `d`) and in `supp S_b` — impossible. So `S_d = {t < 1}`, `S_b = {t > 1}` in the
ball. *At a point `y = x + n(x)` of `β^{+1}`.* `y ∈ supp S_a` (the `a`-contact) and the points just under `y` lie in `W⁺`, `a`-free; with (H1), (H2)
at `y` and the same path argument (every point of `β^{+1}` over `J` is an `a`-contact, by (R) and the normal map), `S_a = {t > β^{+1}}` in the
ball. The lower side is the mirror: `(s, −1)` is the `a`-contact of the flat side, and `a`-material near it lies below (points just above are
`a`-free, being in `W⁻`), so `S_a = {t < −1}` in the ball; `y = x − n(x) ∈ β^{−1}` is the `c`-contact, and points just above it (toward `c`'s piece
above `β`) are within `< 1` and `> 1` of that piece, hence `c`-free; so `S_c = {t < β^{−1}}` in the ball, and the colour above is neither `c` nor
`a` (`a`-points there would pair with `Λ` at distance 1 as before).

(4) The set `B(s) = B((s, 1), r_s) ∩ {t > 1}` is open and a.e. in `S_b`, so it lies in `int F_b` (the interior of the density set, M2 §1.5), and
`B(s) ⊆ W⁺_J` (the ball cannot reach above `β^{+1}`, where `a` has positive density at every point). A component `K` of `int F_b` meeting `W⁺_J`
cannot leave `cl W⁺_J`: points of `J × {1}` have `d` below in every neighbourhood, points of `β^{+1}` over `J` have `a` above, and the two end points
`(z, 1)`, `z ∈ ∂J ⊆ Z`, are limits of the points `(σ, 1 − ε)`, `σ ∈ J`, which lie in `S_d`. So `K ⊆ W⁺_J`. The sets `W⁺_J` for distinct gaps are
disjoint; so each gap carries its own components of `int F_b`, and infinitely many gaps in a bounded set give infinitely many components accumulating
at `Z × {1}`. The same for `c` in `W⁻_J`. ∎

*Grade and minds:* [hand, one mind], over M-PINCH and M-C11 (round 1, one mind each; M2-HULLC on covers two minds). (R), (A), (B) are hypotheses;
(A) and (B) are local and hold at every point of a locally finite segment-and-arc map off its vertices, so they are the weakest form of "the
interfaces near the pinch are ordinary".

### 2.3 What it says

- **The pinch forces both neighbouring classes to be pinched, at distance exactly 1, on the same set.** The class under the flat side (`b`) is pinched
  one unit above the flat side; the class over the curved side (`c`) is pinched one unit below it; each new layer has a flat side (the lines `t = ±1`)
  and a curved side (the unit parallels of `β`), so it is again a pinched layer of the same kind (stage 3 iterates it).
- **This is the cascade of M3-CASCADE made geometric.** The unit-distance relation that M3-CASCADE uses in measure (`φ_{G_b} > 0`) is, in a saturated
  partition with ordinary interfaces, the normal map `x ↦ x ± n(x)`: every piece of interface carries a partner piece of each of its two colours one
  unit away along the normal (row 134's shadow map read in a partition, M2-INTRAD (1) without its local-finiteness hypothesis).

### 2.4 The HC instance

In M3's edge frame (shift `t` by 1: the flat side is `σ_e` at `t = 1`, `β = ℓ − 1`), a regular maximal partition containing HC_K as class `j` and
satisfying (A), (B) at the band's gaps has:
- **`b` (the class under the band) owns the slivers of the up triangle**: `W⁺ = {2 < t < ℓ^{+1}(s)}` and `ℓ^{+1} = 2 + g` exactly — `ℓ` is the lower
  unit parallel of `U`'s bottom `t = 2 + g`, and `U`'s bottom has exterior discs of radius `5/4` from below (Lemma NL), so its region below is a union
  of unit discs and the upper parallel of its lower parallel is itself. The slivers `{2 ≤ t < 2 + g(s)}` that `U` lacks (M3 G2) are exactly `W⁺`: in
  HC they are excluded through the band (Lemma NL); in a partition they are forced into the class under the band.
- **`c` (the class over the band) owns a layer on the down triangle's side**: `W⁻ = {0 < t < m(s)}`, `m = ℓ^{−1}`, pinched on `Z`.
- (R) holds for `β = ℓ − 1`: `{t > ℓ}` near the band is `{d_U < 1}`, a union of unit discs centred in `U`; `{t < ℓ}` contains the half-plane
  `{t < 1}`, and every point of the band lies in a unit disc under `ℓ` (`ℓ ≥ 1`, curvature `≤ 1/2`, bump heights `≤ 1/64`).
- **So M3's reading "three spare classes absorb the slivers" is superseded in partitions**: no spare colour is involved — the slivers already belong
  to the class under the band, and M3-MOVE's lost sliver `L_τ` lies in `b`'s rung (stage 4).

*Would kill M4-LADDER:* a saturated colouring satisfying (R), (A), (B) at a gap in which `W⁺_J` carries positive `a`-measure, or in which `b` is absent
from `{t > 1}` near some `(s, 1)` (a defect in M-PINCH's (tangent) partners or in the path argument).

## Stage 2 — SAVED
