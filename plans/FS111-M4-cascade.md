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

- **M4-LADDER** — in a saturated colouring (every regular maximal partition), a layer of class `a` over an interval, flat below (class `b`) and bounded
  above by a graph `β ≥ 0` (class `c`) vanishing exactly on a closed set `Z` with empty interior, with ordinary interfaces near the four unit-parallel
  curves ((R), (A), (B)): every interface point is of M-PINCH's (tangent) type with its contacts one unit along the normal; the regions `W⁺` (between
  `t = 1` and `β^{+1}`) and `W⁻` (between `t = −1` and `β^{−1}`) are `a`-free, vanish exactly on `Z`, and carry `b` along `W⁺`'s flat side and `c` along
  `W⁻`'s curved side; so **`b` and `c` are pinched on the same `Z`** (one interior component per gap) — [hand, one mind; over M-PINCH, M-C11] §2.1–§2.2.
  Instance: in a partition containing HC_K the class under the band owns the up triangles' slivers (§2.4). Unpinched inhabitant: SQ9 (nine colours).
- **M4-CUT** — in a regular maximal partition, the ladder of rungs (iterated `W^±`) is ordinary for `n` rungs upward only if
  `β(u) ≤ n − (n² − (u − z)²)^{1/2}` (`u ∈ I`, `z ∈ Z`), so `n ≤ 1/(2c)` at a gap end where `β ≥ c(u − z)²`; and downward, when ordinary includes
  (R)'s lower half, only if the region under `β` is a union of open `n`-discs, so a gap of width `w`, height `h` needs `h ≤ n − (n² − w²/4)^{1/2}`
  (`≈ w²/(8n)`) — [hand, one mind; the upward half over M2-FIX (F1); the downward half conditional on (R)'s lower half (audit correction, §3.2)] §3.1–§3.3.
- **M4-HC** — HC_K lies in no regular maximal partition whose ladder over the band's first gap is ordinary through three rungs up or down (rung `±4`
  lands inside a face-centre disc of the class itself), whatever the gap function; and HC's discs (curvature 2) have no ordinary boundary point in any
  saturated colouring (M-C11) — [hand + tools exact (`tools/fs111_m4_rungs.py`, four checks, four plants), one mind] §3.4–§3.5.
- **M4-MOVE** — for a move of the curved side (M3-MOVE), in two regular maximal partitions ordinary through the same rungs: the classes at every rung
  are forced (no spare colour; M3-MOVE's lost sliver is absorbed by the class under the band), and every downward rung's curved side moves; the cascade
  runs through every ordinary rung and ends only where the ladder stops being ordinary — [hand, one mind; downward over M4-CUT (2)'s hypothesis] §4.1.
- **Readings** (not theorems): the count enters only at the junction where a ladder ends (§4.2); an irregular class is the only junction-free escape
  from M4-CUT (§4.3); a fold of a downward rung's normal map is a singular point (§3.3).

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.
- Stage 2: would have searched for a fall colouring of HC_K's complement (to see the classes around the band) → instead applied M-PINCH to the
  band's interfaces and derived which classes the neighbourhood forces (M4-LADDER).
- Stage 3: would have searched for a partition with a long ladder over a pinch → instead derived the bounds from (F1) and the dilation identities, and
  checked HC's collision exactly (K1–K4; seconds, by formula).
- Stage 4: would have searched for the cascade's end state (a partition after M3-MOVE) → did not; derived that it is carried by the ladder and named the
  singular set as the open step.

## Fence log (standing rule 13)

- Stage 1: the start-up git status printed the names of four untracked W files (`data/fs111/fs111-w/blocks.out`, `hex7_free.out`, `hx_pairs.out`)
  and one FS-114 file name (`data/fs114/fs114-yb4/yb3-calib-rerun.out`), and `git log` printed FS-114 commit subjects: names and subjects only, nothing
  opened. No transcript, `chats-bak/` file, foreign scratchpad file, close inventory, other brief or FS-114 file was opened.
- Stages 2–4: `git push` printed only commit ranges; no fenced file opened. Harness notices reported two files changed on disk (my own record
  after my own edits, my own tool after my own `sed`): nothing foreign.

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

## Stage 3 — SAVED: M4-CUT — the ladder cannot run on: within a bounded number of rungs it must meet the singular set

### 3.1 The ladder, and the statement

Iterate M4-LADDER. **Rung 0** is the layer `Λ` (class `x_0 = a`, flat side `t = 0`, curved side `β`). **Rung `k + 1`** is `W⁺` of rung `k` and
**rung `−(k + 1)`** is `W⁻` of rung `−k`. By M4-LADDER (3) and the composition of dilations, rung `k` has flat side `t = k` and curved side
`β^{+k}` for `k ≥ 0`, and flat side `t = k` and curved side `β^{−|k|}` for `k ≤ 0`; its class `x_{k+1}` is the class under rung `k`'s flat side
(`k ≥ 0`), and `x_{−(k+1)}` is the class over rung `−k`'s curved side. The ladder is **ordinary through rung `k`** over a gap `J` when (R), (A) and (B)
of §2.1 hold for rungs `0, …, k` (resp. `0, …, −k`) at every point over `J` (each for the rung's own curved side, with `|κ| < 1` there) — each rung a
single class between its two sides, with ordinary interfaces. *Which half of (R) is a real hypothesis* (found on audit, §3.2 (2)): the upper half
(the region over a rung's curved side is a union of open unit discs) follows from (F1) as in (1)'s first step, the discs `B(x + n(x), 1)` missing the
rung's layer and everything under its flat side; the lower half does not follow, and (2) uses it.

**M4-CUT** [hand, one mind; over M4-LADDER and M2-FIX (F1); (2) conditional on (R)'s lower half at the downward rungs]. *Let `f` be a regular maximal partition (so every class satisfies M2-FIX), with the
setting of §2.1 over `I`, and `n ≥ 1`.*
1. *(Upward.) If the ladder is ordinary through rung `n − 1` over every gap of `I`, then `β(u) ≤ n − (n² − (u − z)²)^{1/2}` for all `u ∈ I`,
   `z ∈ Z`, `|u − z| ≤ n` — **(C_n)**. In particular, at an end `z` of a gap where `β(u) ≥ c (u − z)²`, `n ≤ 1/(2c)`.*
2. *(Downward.) If the ladder is ordinary through rung `−(n − 1)` over every gap of `I`, then `(β^{−n})^{+n} = β` on `I`: the region under the graph
   is a union of open discs of radius `n`; so every gap `J` with `|J| < n` and `dist(J, ∂I) > n` has `max_J β ≤ n − (n² − |J|²/4)^{1/2}`.*

### 3.2 Proof

*(1)* Fix `k ≤ n − 1` and `z ∈ Z`. The `x_k`-contacts of rung `k`'s curved side, `x + n(x)` (M4-LADDER (1) at rung `k`), accumulate at
`y = (z, k + 1)` as `x → (z, k)` (`Z` has empty interior), so `y ∈ F_{x_k}` (closed). By M2-FIX (F1), every component of `int F_{x_k}` lies in
`B(y, 1)` or outside `B̄(y, 1)`. The components of rung `k`'s layer are one per gap `J′` (M4-LADDER (4) at rung `k`), and each has points
`(u, t)` with `u` near an end `z′ ≠ z` of `J′` and `t − k` as small as we like, while the open disc `B(y, 1)` lies in `{t > k + 1 − (1 − (u −
z)²)^{1/2}}`; so every component lies outside `B(y, 1)`: `B(y, 1)` misses `{k < t < β^{+k}}`. Now let `p` be a point with `0 < p_t < β(p_s)` and
`|p − (z, n)| < n`, and take `k = n − 1`: the point `p′` on the segment from `p` to `(z, n)` at distance `< 1` from `(z, n)` is within distance
`n − 1` of `p`, so it lies under `β^{+(n−1)}` (dilation), and above `t = n − 1` (the open unit disc about `(z, n)` lies in `{t > n − 1}`): a point of
rung `n − 1`'s layer in `B((z, n), 1)`. Contradiction; so `B((z, n), n)` misses the region under the graph, which is (C_n). With
`β ≥ c(u − z)²` and `n − (n² − x²)^{1/2} = x²/(2n) + O(x⁴)`, (C_n) gives `c ≤ 1/(2n)`.

*(2)* For every graph, `(β^{−(k+1)})^{+1} ≤ β^{−k}`: the region under `(β^{−(k+1)})^{+1}` is the opening (by unit discs) of the region under
`β^{−k}`, the union of the open unit discs it contains. Equality holds iff the region under `β^{−k}` is itself a union of open unit discs — (R)'s lower
half at rung `−k`, part of "ordinary". *(Audit record: the first draft derived the equality from (F1) applied to the class over rung `−k`; that
argument yields only the inequality above, which holds for every graph. The lower half of (R) is therefore a hypothesis, not a consequence.)* So under
(R) at rungs `0, …, −(n − 1)`, `(β^{−(k+1)})^{+1} = β^{−k}` for `k = 0, …, n − 1`, and composing, `(β^{−n})^{+n} = β`: the open region under the graph is the union of the open
discs `B(q, n)`, `q` under `β^{−n}`. Take a gap `J = (z₁, z₂)`, `w = |J| < n`, its highest point `(u*, h)`, and `ε > 0`: some `B(q, n)` under the graph
contains `(u*, h − ε)`. Its upper arc `A` is concave, `A(z_i) ≤ β(z_i) = 0` wherever the disc reaches the vertical through `z_i`, and the disc
(width `2n > w`) reaches at least one of them. If it reaches both, `A(u*) ≤ n − (n² − w²/4)^{1/2}` (the sagitta over a chord of length `w`). If it
reaches only `z₁`, its centre is left of `z₂ − n < z₁`, so `A` decreases on `[z₁, u*]` and `A(u*) ≤ 0 < h − ε`; likewise for `z₂`. So
`h ≤ n − (n² − w²/4)^{1/2}`. ∎

### 3.3 Reading

- **The pinch's ladder is finite.** Near a gap of width `w`, an ordinary ladder has at most about `1/(2c)` rungs above (`c` the curvature scale at the
  gap's end) and at most about `w²/(8h)` below (`h` the gap's bump height); past them, (A), (B) or `|κ| < 1` fails at some rung over the gap (a point
  with three colours, a class whose local part is disconnected, a rung that is not one class — the sub-layers of §2.2 (3) — or a curvature above 1,
  which M-C11 forbids at ordinary points) or, downward, (R)'s lower half fails: the rung's curved side stops being rolled from below by unit discs, and
  the next rung's curved side is reached from two points of it (a fold of the normal map). *That such a fold is a singular point is a reading, not
  proved (GAP).* **The cascade does not run to
  infinity through ordinary interfaces; it ends at the singular set.** As `w → 0` both bounds grow, so small gaps allow long ladders; the large gaps pin
  singular points near the pinch.
- **The mechanism is the shadow map's curvature transport** (row 134, M2-INTRAD (2)): going up, the parallels of the bump's convex ends sharpen until
  the disc about `(z, n)` no longer fits over the bump; going down, the bump must be a union of `n`-discs, which a bump of height `h` over a gap of width
  `w` is not once `n > w²/(8h)`. Flat layers (`Z = ∅`) are never cut: SQ9's and the strip's ladders run forever (control below).
- **Controls.** *SQ9* (nine colours; the unpinched form, `β ≡ 1/2`, `Z = ∅`): the class two rows above a square is the class of the row below it,
  and two rows below the class of the row above — M4-LADDER (3) — and the ladder is ordinary forever; (C_n) and the bump bound are vacuous (no `Z`).
  Checked (K4). *R7* (seven): no flat or (tangent) interface — every interface is a unit arc of kind both, M-PINCH's (split) case — so M4-LADDER is
  vacuous there; **no seven-colour regular maximal partition with a (tangent) interface is held**, so the vacuity rule's `k = 7` inhabitant is met only
  in the unpinched form and at nine. *The strip and the disk* (row 136): their vertical segments are (tangent) interfaces with straight partners at
  distance 1 on both sides (round 1 §3.5), the unpinched ladder; no pinch, nothing cut.

### 3.4 HC_K: the ladder over its first gap collides within three rungs

In the edge frame (flat side `σ_e` at `t = 1`, so rung `k`'s flat side is `t = 1 + k`), every rung is at most as thick as the band (`β^{−n} + n ≤
β` and `β^{+n} − n ≤ max β ≤ 1/64`). Over the first gap `|s| < 1/6`:
- **rung `−4`** lies in `{−3 < t ≤ −3 + 1/64}` and **rung `+4`** in `{5 < t ≤ 5 + 1/64}`: inside the open discs of radius `1/2` about the face centres
  `O₋ = (0, −2 − √3/2)` and `O₊ = (0, 4 + √3/2)`, each at distance 2 beyond its triangle's apex (K1, exact). Those discs are open sets of class `j`. M4-LADDER (3) at
  rung `−3` puts `x_{−3}` below `t = −3` and a different colour `x_{−4}` just above, near every `(s, −3)`; inside the disc both are `j`. Contradiction;
  likewise at rung `+3` with `t = 5`.
- **rungs `±1, ±2, ±3`** have their flat sides on `t = 0, −1, −2` and `2, 3, 4`, which miss both discs and both triangles' interiors (`t = 0` and `t = 2`
  are the triangles' own sides, as the ladder requires: rung `−1`'s lower class is `j` = `T_down`, rung `+1`'s upper class is `j` = `U`) (K1).

**M4-HC** [hand + tools exact, one mind]. *In no regular maximal partition containing HC_K as a class is the ladder of the band's first gap ordinary
through rung `3` upward or through rung `−3` downward.* Independently, **HC's face-centre discs** (curvature 2) **have no ordinary boundary point in
any saturated colouring**: at a point satisfying (H1), (H2), M-C11 bounds the interface's curvature by 1. So HC_K itself sits in a regular maximal
partition only with singular points on every disc boundary point and within three rungs of its first gap. The generic bounds (K2, K3) at the first gap
(`w = 1/3`, bump height `h = w⁴/64 = 1/5184` exactly — `ℓ(0) = 1 + g(0)` by Lemma NL's exterior disc) are 72 rungs down and 19 up: the collision is
what cuts HC_K, the bounds are what cut any pinch.

### 3.5 The exact check, `tools/fs111_m4_rungs.py`

sympy, exact; output `data/fs111/fs111-m4/rungs.out`, exit 0 (all as expected).
- **K1** rung `∓4` layers over `|s| ≤ 1/6` inside the discs about `O∓` (the four corners of each thin box, the disc being convex); flat sides
  `t = −2, −1, 3, 4` clear of both discs and both apexes. **PASS.**
- **K2** `g`'s maximum on a gap of width `w` is `w⁴/64` at the midpoint; the largest `n` with `1/5184 ≤ n − (n² − 1/36)^{1/2}` is **72**. **PASS.**
- **K3** `min_y [c y² + (x − y)²/2] = x² c/(2c + 1)`; with `c = w²/4` the upward bound is `1 + 2/w²`, **19** at `w = 1/3`. **PASS.**
- **K4** SQ9's rung classes (control). **PASS.**
- **Plants, each firing for its own reason and only there:** `far` (face centres 3 from the apexes; at `21/10` and `5/2` the collision still happens —
  the disc is roomy, a plant that could not fire, found and replaced) → K1; `gdbl` (`g` doubled: bound 36) → K2; `c2` (`c = w²/2`: bound 10) → K3;
  `sq4` (squares coloured mod 4) → K4.

## Stage 3 — SAVED

## Stage 4 — SAVED: the cascade answered in partitions; where the colour count enters; MUA-REG in partitions

### 4.1 M4-MOVE — the cascade of a move is the ladder, and it is forced

**M4-MOVE** [hand, one mind; over M4-LADDER, M4-CUT]. *Let `f` and `f′` be regular maximal partitions that agree outside the ladder region of a gap
`J` and differ there by replacing `β` with `β′ ≠ β` (e.g. M3-MOVE's `g_K → g_τ`), both ordinary through rungs `−N, …, N` over `J`. Then:*
1. *The classes are the same at every rung (`x_k` depends only on the classes around rung 0, by M4-LADDER (3)), so **no class outside the ladder's
   classes changes and no spare colour enters**: the class that absorbs M3-MOVE's lost sliver `L_τ` is forced — it is `x_1`, the class under the band,
   because `L_τ ⊆ W⁺_τ` (rung 1 of `f′`) and `W⁺_τ` is `x_1`'s.*
2. *At every downward rung `−k`, `1 ≤ k ≤ N`, the curved side moves (`β^{−k} ≠ β′^{−k}`): by M4-CUT (2), `β = (β^{−k})^{+k}` and `β′ = (β′^{−k})^{+k}`,
   so equal parallels would give `β = β′`. The class `x_{−k}` gains or loses the region between `β^{−k}` and `β′^{−k}`, and the class over it the
   complement. At rung `+1` the curved side moves by `L_τ`'s shape (`β^{+1} = 2 + g` in HC's frame).*
3. *So **the cascade runs one unit per step along the ladder, through every ordinary rung, and does not close there**; it can end only where the ladder
   stops being ordinary — by M4-CUT within `1 + 2/w²` rungs up and (under (R)'s lower half) `w²/(8h)` down over a gap of width `w` and height `h`, and for HC's skeleton within
   three rungs (M4-HC, whatever `g`: the collision K1 uses only the skeleton).*

*What it answers* (the brief's item 2): the cascade of a pinch-removing move in a regular maximal partition **neither closes in the ordinary region nor
runs to infinity**: it is carried by the ladder's finitely many ordinary rungs to the singular set. Whether it can be absorbed there — a junction (three
or more colours), a class with disconnected local parts, a rung that is not one class — is the open step: **GAP at the singular set**. M3-CASCADE's
measure statement ("the gainer loses its old material at distance 1 from what it gained") is, in the ordinary region, exactly M4-MOVE (2)'s moving
curved sides (the lost material is the thin region between old and new parallels at the next rung).

### 4.2 Where the colour count enters

- **Not in the ladder.** The ladder's classes are determined by the classes around rung 0 (M4-MOVE (1)); the absorption needs no spare colour at any
  `k`, and M3's reading (three spare HC translates absorbing the slivers, a construction at `k + 3`) does not arise in partitions: the slivers are the
  class under the band's already (M4-LADDER, §2.4). **So the answer to "at which `k` is a spare colour available" is: none is needed along the ladder;
  the count can enter only where the ladder ends, at a junction.**
- **At the junction, a reading.** A ladder ends at a point where (A) or (B) fails; the generic such point is a junction of three or more classes, and
  saturated junctions are where the count lives (round 1 §4: M-HALF's sector structure; row 135: four-colour vertices). A pinch's ladder ending at a
  junction within `N` rungs means **every large gap of a pinch brings a junction within distance about `N`** — the pinch is tied to the junction
  structure, and a count argument would have to see the junctions, not the pinch. *Killing test:* a regular maximal partition with a Cantor pinch whose
  ladders end at points of only two colours (a class with disconnected local parts, or a sub-layer) with no junction within `N` rungs.
- *A registered observation, not a theorem:* near a pinch the region between rung `k`'s curved side and rung `k + 1`'s flat side has height tending
  to 1, so if it were one class it would contain unit pairs in positive measure once its width exceeds about `(2β)^{1/2}`; so the ladder's gaps between
  rungs are not single classes over any interval near a pinch point, and ordinary ladders near a pinch carry interior interfaces with their own ladders
  (the colour sequence along a vertical near the pinch is 1-periodic in its jumps, `c(h + 1 + 0) = c(h − 0)` at every ordinary jump `h`). Not pursued.

### 4.3 MUA-REG in partitions (the brief's item 3)

- **M3-IRREG transfers verbatim**: a class of any maximal partition is a maximal unit-avoiding set, so a class containing M3-IRREG's `A_f` (HC with a
  fat pinch set) is irregular (M3-IRREG (3)); whether a partition containing `A_f` exists is open for the same reason as HC_K's (§3.4).
- **M4-CUT needs regularity** exactly at (F1) (M2-FIX), which holds for regular classes. A class whose support carries a positive-measure boundary
  (M3-IRREG's dust) escapes the step "every component lies inside or outside `B(y, 1)`" through its nowhere dense part. *Reading:* **an irregular class is
  the one way a pinch's ladder could run on without junctions** — the cut forces either junctions or irregularity near every large gap. *Killing test:*
  a proof that (F1)'s conclusion holds for every MUA set's interior components (then irregularity does not help the ladder). Not decided.
- So MUA-REG-P in partitions is **GAP**; this round adds only the reading above.

### 4.4 Verdict on the brief

| item | answer | grade, minds |
|---|---|---|
| 1. a partition with an HC-type class, or the obstruction "the pinch forces a neighbouring class to be pinched, and so on without end" | **Not built.** The obstruction's first half is **TRUE** (M4-LADDER: both neighbouring classes are pinched, one unit away, on the same set); its second half is **FALSE** in ordinary form (M4-CUT: the ladder must stop being ordinary within finitely many rungs — upward given (A), (B) and `|κ| < 1` per rung; downward when ordinary includes (R)'s lower half); HC_K itself fits no regular maximal partition with an ordinary ladder through three rungs over its first gap, or with an ordinary disc boundary point (M4-HC). **Whether MUA-FIN-L can fail in partitions: GAP at the singular set** — a pinch in a regular maximal partition must bring singular points (or irregularity) near its large gaps | [hand; hand + tools exact], one mind |
| 2. the cascade | runs one rung per step through the ordinary ladder, never closing there, with forced absorbing classes; ends at the singular set within the M4-CUT bounds; its fate there is open | [hand], one mind |
| where a spare colour enters | nowhere along the ladder, at any `k`; only possibly at the junction where the ladder ends (reading) | [hand; reading], one mind |
| 3. MUA-REG in partitions | M3-IRREG transfers (a class containing `A_f` is irregular); M4-CUT's use of (F1) makes irregularity the only junction-free escape (reading); GAP | [hand; reading], one mind |

*Honesty rule:* nothing here is stated at `k = 5` alone; every statement is colour-generic, and none decides a colour count (G24). The existence of a
regular maximal five-cover satisfying MUA-FIN + D3 remains equivalent to `χ_m⁰ ≥ 6` (M2-REDUCE-C, VM2-EQ5), untouched.

### 4.5 Proposed for the close (I edit none of these files)

- **`data/fs111/claims.md` §3:** MUA-FIN-L in partitions — M4-LADDER (a pinch propagates to both neighbours at distance 1, same zero set), M4-CUT
  (ordinary ladders are finite: `≤ 1 + 2/w²` up, `≤ w²/(8h)` down), M4-HC (HC_K: three rungs; discs never ordinary), M4-MOVE (the cascade is the ladder;
  no spare colour); the open step is the singular set.
- **`LEDGER.md`, FS-111's row:** M4-LADDER, M4-CUT [hand, one mind], M4-HC [hand + tools exact, one mind]; "it moves no value: it turns M3-CASCADE's
  measure statement into the unit-parallel ladder and shows the ladder must end at a junction or an irregular class within a bounded number of rungs".
- **Grokking draft (to merge with M3's G84′ draft), G67's form:** *A pinch climbs a ladder of unit parallels, and the ladder is short. [hand, one mind]*
  In a saturated partition every ordinary interface has partners of both its colours one unit away along the normal; a pinched layer's partners are
  pinched layers of the two neighbouring classes on the same set, and so on, but the curved side's parallels sharpen upward and its bumps stop being
  unions of `n`-discs downward, so within about `1/(2c)` rungs up and `w²/(8h)` down the ladder must meet a junction (or an irregular class). *Do: when a
  pinch or any curved interface is proposed in a partition, draw its ladder of unit parallels first and find where it must end — the junction is where the
  argument lives. Killing test: a regular maximal partition with a pinch whose ladder is ordinary for more rungs than M4-CUT allows (a defect in the cut),
  or one whose ladders end with no junction and no irregular class within the bound (the reading).*
- **Stubs:** (a) *the pinch at a junction* — what a saturated junction does with a ladder that ends at it (does the change of M4-MOVE get absorbed?);
  provisional bearings G83 (four-colour vertices), G82, G79, row 135. (b) *(F1) for irregular MUA sets* — does every component of the interior of a MUA
  set's density set lie inside or outside each unit disc about its support? (the step irregular classes could evade). (c) retire M3's stub (b) (the
  spare-colour absorption): superseded by M4-MOVE (1).
- **`BIBLIOGRAPHY.md`:** nothing new read this round. The closing/opening identities used (a set equals its closing by a disc iff its complement is a
  union of such discs) are classical mathematical morphology (Matheron, Serra); **not held, not read** — nothing rests on a citation, the step is proved
  in place.
- **Corrections owed:** M3 §3.3's reading "three spare classes (HC translates) would absorb the slivers" — superseded in partitions (M4-MOVE (1)); M3's
  stub (b) likewise.

## Stage 4 — SAVED
