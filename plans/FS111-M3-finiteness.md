# FS111-M3 — route M, round 3: the finiteness rung (the Cantor pinch, MUA-FIN-P, MUA-REG)

*Job FS111-M3 (de Bruijn, Opus 5.5), opened 2026-09-28. Brief: `data/fs111/briefs/M3-111-finiteness.md`, which points to FS111-M's brief
`data/fs111/briefs/M-111-regularity.md` and to `data/fs111/briefs/STANDING-RULES.md` (rule 0 read first); where they differ the round-3 brief wins.
Working files: `data/fs111/fs111-m3/`; tools `tools/fs111_m3_*.py`. Saved in stages; each stage's section is headed "Stage n — SAVED" and committed
before the next begins. Notation: M2's (`plans/FS111-M2-regularity.md` §1.4–§1.5): unit-avoiding (UA), maximal unit-avoiding (MUA), `φ_A`, regular
(`|F ∖ A| = 0`, `|∂F| = 0`, `F = supp A`), `F + S¹ = {z : T₁(z) ∩ F ≠ ∅}`, M2-FIX (`int F = ℝ² ∖ (F + S¹)`); this record adds, for a closed set `B`,
`d_B(z) = dist(z, B)`, `D_B(z) = sup_{b ∈ B} |z − b|`, and the **exclusion set** `E_B = {z : d_B(z) ≤ 1 ≤ D_B(z)}` (for connected `B`,
`E_B = B + S¹` exactly).*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address)*

- **M3-VAC** — M2-PINCH-C's hypothesis is unsatisfiable: no regular MUA set contains `P ∪ P′` and has every point within `11/10` of `W` in
  `P ∪ P′ ∪ W` (a point just beside `W` inside the lens band is neither in `F` nor on a unit circle about `F`). The lemma is vacuously true; the
  configuration it names needs material within `11/10` of `W` to cut the lens band off — [hand, one mind] §1.4.

## Would-have-searched-here log (standing rule 3)

- Stage 1: would have searched (a colourer or optimiser over pixel sets) for a periodic MUA set containing a Cantor pinch → instead designed one by
  hand from the structure of the configuration (§1.5: the lens band must be cut off by its own shadow, which needs its length to be exactly 1), and
  evaluated the hand-given candidate's free region once in floats to see its shape (an evaluation of one formula, not a search; no parameter varied).

## Fence log (standing rule 13)

- Stage 1: the start-up git status printed the names `data/fs111/fs111-w/blocks.out`, `hex7_free.out`, `hx_pairs.out` (W's files; open to me —
  the round-3 brief fences only FS-114's files, transcripts, `chats-bak/`, other scratchpads, the close inventory and other briefs); `git log` printed
  FS-114 commit subjects ("FS-114: the Reuleaux bowtie family closed …", "FS114-N6: stage 4", "FS114-Y5: stage 2"): subjects only, nothing of
  FS-114 opened. No transcript, `chats-bak/` file, foreign scratchpad file, close inventory or other brief was opened.

## Stage 1 — SAVED: quotation check; M2-PINCH-C's hypothesis is vacuous; the completion's design

### 1.0 Resuming check

`plans/FS111-M3-finiteness.md` and `data/fs111/fs111-m3/` did not exist at start: fresh start at stage 1.

### 1.1 Files read, in order

The round-3 brief; `data/fs111/briefs/STANDING-RULES.md`; FS111-M's brief; `CLAUDE.md` § The aim and § Counter-priors (in context and on disk);
`plans/FS111-M2-regularity.md` in full; `plans/FS111-VM2-verification.md` in full; `data/fs111/claims.md` in full; `plans/FS111-M-regularity.md`
§1.5 (M-HULL1/2) and §2 (M-SATC, M-SLACKFREE, R7, M-DEADLOCK); `plans/FS111-W-wild.md` §2.7 (the self-sustaining ring reading);
`tools/fs111_m2_covers.py` (header and SQ9's definition: squares of side `1/2` at period `3/2`).

### 1.2 Quotation check (standing rule 5)

*Exact substring search on whitespace-joined text.*

| # | quotation in the round-3 brief | source | verdict |
|---|---|---|---|
| 1 | "every regular maximal cover can be modified, keeping it a maximal cover, into one satisfying MUA-FIN" | M2 §2.3, MUA-FIN-P row | verbatim |
| 2 | "`⋃_j ∂F_j` is, in every bounded set, a finite union of Jordan arcs" | M2 §2.3, REG-J′-C_k | verbatim |
| 3 | "meeting only at endpoints" (VM2's clause D3) | VM2 §2.3 D3 | verbatim |
| 4 | "MUA-FIN-U: every regular MUA set has locally finitely many components" | M2 §2.3 table | verbatim |
| 5 | "a regular MUA set by formula containing the configuration, or a proof that M2-FIX forbids it globally" | M2 §2.3 table | verbatim |
| 6 | "M2-REDUCE-C, TRUE at two minds"; "At five this is an equivalence" | VM2 §2.5 item 1; VM2-EQ5 | faithful |
| 7 | "MUA-REG-U's one-dimensional analogue is FALSE (M2 §1.5)" | M2 §2.3 row MUA-REG-U: "its one-dimensional analogue is FALSE (§1.5)" | faithful |
| 8 | rule 0's and rule 3's quotations of Kooshi ("From here on out …", "to eliminate the crutch …", "search for a finite graph is out …") | `CLAUDE.md` § Counter-priors, § Toolchain, § Publication | verbatim |

### 1.3 The object of this round, named

A **regular MUA set** `F` (M2 §1.5) is a closed set with `F = cl int F`, `|∂F| = 0`, whose interior `A = int F` is unit-avoiding and maximal. By
M2-ZERO it is a measurable independent dominating set of the unit-distance graph; by M2-FIX, `int F = ℝ² ∖ (F + S¹)`. The rungs:
- **MUA-FIN-U** (M2): every regular MUA set has locally finitely many components (of `int F`).
- **MUA-FIN** (M2's words) and **MUA-FIN + D3** (VM2's plane-graph clause): the class boundaries are, in every bounded set, a finite union of Jordan
  arcs (meeting only at endpoints).
- **MUA-FIN-P**: every regular maximal cover can be modified, keeping it a maximal cover, into one satisfying MUA-FIN (+ D3).

These are statements about one MUA set, or a cover of `k` of them, class by class (G24's rule: none decides a colour count; M2-COV).

### 1.4 M3-VAC — M2-PINCH-C's hypothesis cannot be met [hand, one mind]

*M2-PINCH-C* (M2 §2.3, verbatim): "*If* a regular MUA set `F` contains `P ∪ P′` and every point of `F` within `11/10` of the strip
`W = [−1/8, 1/8] × [9/10, 11/10]` lies in `P ∪ P′ ∪ W`, then `int F ∩ W` has infinitely many components, accumulating at every point of `Z × {1}`."
Here `P = [−1/4, 1/4] × [−1/2, 0]`, `P′ = {(s, t) : |s| ≤ 1/4, 2 + g(s) ≤ t ≤ 5/2}`, `g ≥ 0` zero exactly on a Cantor set `Z ⊂ (−1/8, 1/8)`.

**Claim: no regular MUA set satisfies the hypothesis.** Let `ℓ(s) = inf{t : d_{P′}(s, t) ≤ 1}` for `|s| ≤ 1/4` (the lower unit parallel of `P′`; since
`P′ ⊆ {t ≥ 2}`, `d_{P′}(s, ·)` decreases on `t < 2`). `ℓ(s) = 1` iff `(s, 2) ∈ P′` iff `g(s) = 0` (a point `u ∈ P′` has `u_t − √(1 − (s − u_s)²) ≥ 1`
with equality iff `u_t = 2`, `u_s = s`); so `ℓ(s) > 1` for `s ∉ Z`. Take `s₀ = 1/8 + α`, `0 < α < 1/10`, and `1 < t₀ < ℓ(s₀)`; put `z = (s₀, t₀)`.
- `z ∉ F`: `z` is within `α < 11/10` of `W` and lies in none of `W` (`s₀ > 1/8`), `P` (`t₀ > 0`), `P′` (`t₀ < 2`).
- By M2-FIX some `y ∈ F` has `|y − z| = 1`. Then `dist(y, W) ≤ 1 + α < 11/10`, so `y ∈ P ∪ P′ ∪ W`. But `y ∈ P` gives `|y − z| ≥ t₀ > 1`; `y ∈ P′` gives
  `|y − z| ≥ d_{P′}(z) > 1` (`t₀ < ℓ(s₀)`); `y ∈ W` gives `|y − z| ≤ ((1/4 + α)² + (1/5)²)^{1/2} < 1`. Contradiction. ∎

So M2-PINCH-C is **vacuously true** as stated, and the killing test's first half cannot be met by the literal configuration: the lens band
`{1 < t < ℓ(s)}` does not stop at `W`'s sides (it continues wherever `g > 0`, and `g > 0` off `Z`), and M2's own "what is not done" names the missing
piece — "the horizontal cut-off of the rung by other material of the class" — which the hypothesis forbids within `11/10`. **The corrected question**
(the one the brief asks): *does some regular MUA set contain a Cantor pinch — two blocks at distance 2 whose facing boundaries are a flat segment and
a graph touching its unit parallel exactly on a Cantor set, with the lens band between them in `int F`?*

### 1.5 The design: what the cut-off must be (hand, from the configuration's own structure)

Three facts fix the shape of any completion.
1. **A flat side needs a band at distance 1.** Let a block `B` (a set of diameter `≤ 1`) have a flat side `σ₀` of length `2a > 0`. A point `z` just
   outside the middle of `σ₀` has `D_B(z) < 1` (a point `p ∈ B` with `|p − m| ≥ 1` at the midpoint `m` would have `|p − e₊|² + |p − e₋|² =
   2|p − m|² + 2a² > 2` at the side's endpoints `e±`, against diameter `≤ 1`), so `B` does not exclude `z`; and (M2 §1.5's computation, redone) any
   point `q` of the class at distance exactly 1 from `z` must be far from `B` (the same identity forbids `|q − b| < 1` for all `b ∈ B` as `z → m`),
   so, letting `z → m`, `q` tends to the arc `{m + (sin θ, cos θ) : |sin θ| ≤ a/2}`: at distance 1 from the midpoint, over the side's middle half.
   So **every flat side of a small block carries material of the class at distance exactly 1 over its middle** — the lens band is forced, not optional.
2. **The band must be cut off by its own shadow.** A band parallel to a side of length `λ` sits over the side and, beyond its ends, the free region
   opens into two horns (between the unit arcs about the two blocks' corners). A horn point at distance `u` past the right end has its unit circle
   pass (its leftmost point) through the band at distance `u` from the band's **left** end — so the band excludes its own horns out to `u < λ`, and
   its own interior is unit-free only if `λ ≤ 1`. **Length exactly 1 is the case in which the band cuts itself off**, with the band thinning to 0 at
   both ends so that its own diameter stays `≤ 1`.
3. **A side of length 1 with its band at distance 1 is excluded exactly by an apex at distance `√3/2`**: the band's two end circles leave free the
   vesica `B(e₋, 1) ∩ B(e₊, 1)` about the band, whose lowest point lies `1 − √3/2` above the side; the block excludes it iff it reaches distance
   `√3/2` below the side's midpoint — an **equilateral triangle of side 1**, tight at exactly one point.

These three facts assemble into one periodic object (§1.6), the honeycomb class **HC**; stage 2 proves it is a regular MUA set, and with one family
of bands pinched on a Cantor set it answers the corrected question and MUA-FIN-U.

### 1.6 The object HC, by formula

*The skeleton.* `L = 2 + √3/3` (twice the inradius `√3/6` plus 2). Let `𝒪` be the triangular lattice spanned by `L(3/2, √3/2)` and `L(0, √3)`
(spacing `L√3 = 2√3 + 1`), the **face centres**; the honeycomb of edge `L` has its vertices (the **centroids**) at `O + L(cos 60°k, sin 60°k)`, `O ∈ 𝒪`.
- **Triangles.** At each centroid `C`, the closed equilateral triangle `T_C` of side 1 (circumradius `1/√3`) with its three vertices pointing at the
  three face centres around `C`; so each vertex is at distance `L − 1/√3 = 2` from its face centre, and across each honeycomb edge two triangles face
  each other with parallel sides at distance `L − 2·√3/6 = 2`. The triangles are **down** or **up** alternately (bipartite honeycomb).
- **Segments.** On each honeycomb edge `e`, the segment `σ_e` of length 1 lying midway between the two facing sides (at distance 1 from each),
  perpendicular to `e`, centred at `e`'s midpoint; it lies on the ray from each adjacent face centre, from distance `√3` to `√3 + 1`.
- **Discs.** At each face centre `O`, the closed disc `B̄(O, 1/2)`.

*The edge frame.* For an edge `e`, coordinates `(s, t)` with the down triangle's facing side `[−1/2, 1/2] × {0}` (its apex at `(0, −√3/2)`), `σ_e =
[−1/2, 1/2] × {1}`, the up triangle's facing side `[−1/2, 1/2] × {2}` (its apex at `(0, 2 + √3/2)`).

*The modification.* Fix a closed `Z ⊆ [−1/2, 1/2]` with `±1/2 ∈ Z` and `|Z| = 0`, and put `g(s) = (1/4) Σ_J (s − a_J)²(b_J − s)²·1_J(s)`, the sum over
the component intervals `J = (a_J, b_J)` of `[−1/2, 1/2] ∖ Z`. In every edge frame the up triangle's side is replaced by the graph `t = 2 + g(s)`:
**`U = {z ∈ T_up : t ≥ 2 + g_e(s)` in each of its three edge frames`}`** (the down triangles are unchanged). The **band** of `e`:
`Λ_e = {(s, t) : |s| < 1/2, 1 < t < ℓ(s)}`, `ℓ(s) = inf{t : d_U(s, t) ≤ 1}`.

**HC** `= ⋃ T_down ∪ ⋃ U ∪ ⋃ cl Λ_e ∪ ⋃ B̄(O, 1/2)`.

*Two instances:* **HC₀** — `Z = {−1/2, 1/2}` (every band one lens, thinning to 0 at its ends); **HC_K** — `Z` the middle-thirds Cantor set on
`[−1/2, 1/2]` (so `(−1/6, 1/6)` is the first gap): every band pinched on `Z`, with infinitely many components.

*The claims stage 2 proves:* (i) HC is a regular MUA set for every such `Z`; (ii) the components of `int HC_K` in a bounded set are infinitely many
(one per gap of `Z` in each band met); (iii) its class boundary in a bounded set is a finite union of Jordan arcs that meet on the infinite set
`Z × {1}` — MUA-FIN in M2's words holds, MUA-FIN with D3's clause fails.

*Float view (evaluation of the formula, not a search).* The segment skeleton (bands as segments, `g = 0`) evaluated on a `261 × 261` grid over
`[−2.6, 2.6]²` about a face centre: 0 points free (neither interior nor on a unit circle about a block); the only "interior and excluded" readings are
grid points on triangle sides at distance exactly 1 from their bands (boundary artefacts). No parameter was varied.

## Stage 1 — SAVED

## Stage 2 — SAVED: M3-HC — the honeycomb class is a regular MUA set; with a Cantor band it has infinitely many components (MUA-FIN-U FALSE)

### 2.1 Statement

**M3-HC** [hand + tools exact, one mind]. *Let `Z ⊆ [−1/2, 1/2]` be closed and null with `±1/2 ∈ Z`, and HC the set of §1.6. Then HC is a regular MUA
set: `A = int HC = ⋃ int T_down ∪ ⋃ int U ∪ ⋃_e Λ_e ∪ ⋃ B(O, 1/2)` has no two points at distance 1, `φ_A > 0` almost everywhere off `A`, and
`HC = supp A`, `|∂HC| = 0`; M2-FIX holds: `int HC = ℝ² ∖ (HC + S¹)`. The components of `Λ_e` are exactly `{(s, t) : s ∈ J, 1 < t < ℓ(s)}`, one for
each component interval `J` of `(−1/2, 1/2) ∖ Z`.* In particular **HC_K** (`Z` the middle-thirds Cantor set) has infinitely many components of its
interior in every ball of radius 3 about a face centre — **MUA-FIN-U is FALSE**.

### 2.2 The function `g` and the band

**(G1)** On a gap `J = (a, b)`, `w = b − a ≤ 1`, `x = s − a`, `y = b − s`: `g = x²y²/4`, `g′ = xy(y − x)/2`, `g″ = (x² − 4xy + y²)/2`. So (checked
symbolically, H4) `0 ≤ g(s) ≤ dist(s, Z)²/4`, `|g′(s)| ≤ dist(s, Z)/2`, `|g″| ≤ 1/2`, `g ≤ 1/64 =: G`, `|g′| ≤ 1/8`. With `g(z) = g′(z) = 0` on `Z` and
the bound `|g′| ≤ dist(·, Z)/2`, `g′` is continuous on `[−1/2, 1/2]` and `1/2`-Lipschitz across gaps (for `s < z < s′`, `z ∈ Z`: `|g′(s′) − g′(s)| ≤
(s′ − z)/2 + (z − s)/2`). So `g(s) ≥ g(σ) + g′(σ)(s − σ) − (s − σ)²/4` for all `s, σ ∈ [−1/2, 1/2]`.

**(G2) The three slivers of an up triangle are disjoint and miss the other sides' curves.** A point of side `e`'s sliver, `(s, 2 + τ)` with
`0 ≤ τ < g(s) ≤ (1/2 − |s|)²/4`, is at distance `≥ (1/2 − |s|)(√3/2 − (1/2 − |s|)/8) ≥ 0.8 (1/2 − |s|)` from the line of the adjacent side at the near
corner, while that side's sliver near the foot of the perpendicular (within `0.51 (1/2 − |s|)` of the corner) is at most `0.07 (1/2 − |s|)²` thick. So
`U = T_up ∖ (three disjoint open slivers)`, `U = cl int U`, the graph `{(s, 2 + g(s)) : |s| ≤ 1/2}` lies in `U`, and `U ⊆ {|s| ≤ 1/2, t ≥ 2 + g(s)}` in
each of its edge frames.

**(G3) The band.** For `|s| ≤ 1/2` and `t < 2`, `d_U(s, t)` is continuous and strictly decreasing in `t` (every `u ∈ U` has `u_t ≥ 2`), so
`{d_U > 1} ∩ {|s| ≤ 1/2, t < 2} = {t < ℓ(s)}` with `ℓ` continuous; `1 ≤ ℓ(s) ≤ 1 + g(s)` (`(s, 2 + g(s)) ∈ U`), and `ℓ(s) = 1` iff `g(s) = 0` iff
`s ∈ Z` (`u_t − √(1 − (s − u_s)²) ≥ 1` with equality iff `u = (s, 2)`). Hence `Λ_e = {|s| < 1/2, 1 < t < ℓ(s)}` is open; over each gap `J` it is
connected (vertical fibres are intervals over a connected base) and different gaps are separated by empty fibres: **its components are the gaps**. Its
closure is `{|s| ≤ 1/2, 1 ≤ t ≤ ℓ(s)}` and contains `σ_e` (`Z` has empty interior). Its boundary is the segment `σ_e` and the graph of `ℓ`: two Jordan
arcs meeting exactly on `Z × {1}`.

### 2.3 Unit-avoiding: no two points of `A` at distance 1

- **Blocks are far apart** (H1, exact on a patch; the skeleton is periodic): two triangles `≥ 2`; a triangle and a segment it does not flank
  `≥ √7`; two segments `≥ √3`; a disc and a triangle `≥ 3/2`; a disc and a segment `≥ √3 − 1/2`; a triangle and each segment it flanks: exactly 1.
  `Λ_e` lies within `G = 1/64` of `σ_e`, so a band is more than `√7 − G > 1` from every non-flanking triangle and more than 1 from every other band and
  disc. Against its flanking triangles: `Λ_e ⊆ {t > 1}` and `T_down ⊆ {t ≤ 0}` (distance `> 1`); `d_U > 1` on `Λ_e` (G3).
- **Inside each block:** triangles, `U ⊆ T_up` and discs have diameter 1, attained only at boundary pairs, so interior pairs are at distance `< 1`.
  **The band:** for `(s₁, t₁), (s₂, t₂) ∈ Λ_e`, `s₁ < s₂`, put `u₁ = s₁ + 1/2`, `u₂ = 1/2 − s₂`. Then `(s₂ − s₁)² < (1 − u₁ − u₂)²` and
  `|t₂ − t₁| < max_i (ℓ(s_i) − 1) ≤ max_i g(s_i) ≤ max_i dist(s_i, Z)²/4`, whose square is `< max(u₁, u₂)⁴ ≤ u₁ + u₂`
  (`±1/2 ∈ Z`); and `1 − (1 − u₁ − u₂)² ≥ u₁ + u₂` (as `u₁ + u₂ ≤ 1`). So `|z₁ − z₂| < 1`. **The band has diameter `≤ 1` because it thins to 0
  quadratically at both ends** — §1.5's fact 2.

So no two points of `A` are at distance 1; since `HC = cl A` (every block is the closure of its interior) and `A` is open, no point of `A` is at distance 1
from a point of `HC` (a pair `p ∈ A`, `q ∈ HC` at distance 1 perturbs to a pair in `A`): `A ∩ (HC + S¹) = ∅`.

### 2.4 Maximality: every point outside `A` is on a unit circle about HC, and almost every one about `A`

*Exclusion sets.* For a block `B` put `E_B = {d_B ≤ 1 ≤ D_B}` and `E°_B = {d_B < 1 < D_B}`. For `B` a triangle, `U` or a disc (closures of connected open
sets with the same `d`, `D`), `z ∈ E°_B ⟹ T₁(z) ∩ int B ≠ ∅` (the distance from `z` takes every value in `(d_B, D_B)` on `int B`). For a segment:
`E_{σ} = (σ + B̄₁) ∖ V_e`, where **`V_e = B(e₋, 1) ∩ B(e₊, 1)`, the open vesica of `σ_e`'s endpoints** (`D_σ < 1` iff `z ∈ V_e`); and
`z ∈ E°_σ ∖ N_e ⟹ T₁(z) ∩ Λ_e ≠ ∅`, with `N_e = (Z × {1} + S¹) ∪ T₁(e₋) ∪ T₁(e₊)` in the frame of `e` — *proof:* `d_σ(z) < 1` makes `T₁(z)` a
secant of `σ`'s line, meeting it at two points of which one lies in `σ` (connectedness); off `N_e` that point is `(s′, 1)` with `|s′| < 1/2`, `s′ ∉ Z`,
and the secant crosses into `t > 1`, where near `(s′, 1)` it lies below `ℓ` (continuity, `ℓ(s′) > 1`): a point of `Λ_e`. `N_e` is null (`Z` is null and
`(c, θ) ↦ (c + cos θ, 1 + sin θ)` is Lipschitz).

**B1 — the sausage cover (flat skeleton).** `ℝ² = ⋃_T (T + B̄₁) ∪ ⋃_e (σ_e + B̄₁) ∪ ⋃_O B̄(O, 3/2)`, `T` over the flat triangles. *Proof.* The skeleton
has the honeycomb's full symmetry (a rotation by 60° about `O` carries a triangle pointing at `O` to the next one), so it suffices to cover the
fundamental triangle `Δ = O C M` (`O = (0, 0)`, `C = (L, 0)`, `M` the midpoint of the edge at angle 30°). Let `v = (2, 0)` (the vertex of `T_C` at `O`),
`e = √3 u(30°)` (the inner end of `σ` on the 30° ray), and `τ(z) = ⟨z − v, u(30°)⟩` (position along `T_C`'s side from `v`). `M` projects to `τ = 1/2`
and `CM ⊥ u(30°)`, so `Δ ⊆ {τ ≤ 1/2}`. (i) Points of `Δ` below the side's line lie in `T_C` (they are on `C`'s side of all three side lines). (ii) Points
of `Δ` above it with `0 ≤ τ ≤ 1/2` lie between the side's line and the 30° ray, which are parallel at distance 1, and project into the side: within 1 of
`T_C`. (iii) `Δ ∩ {τ ≤ 0}` is the triangle `O v e`; its part with `|z| ≥ 3/2` lies in the quadrilateral `Q = conv{(3/2, 0), v, e, (3/2)u(30°)}`, and
**`Q ⊆ B̄(v, 1) ∪ B̄(e, 1)`** (H3, exact: split by the perpendicular bisector of `v, e`, every vertex of each half within `0.62` of its centre; without
`B̄(e, 1)` the vertex `(3/2)u(30°)` is `1.026` from `v` — the plant `nosigma`). ∎

**B2 — the classification.** Let `z ∉ A`. In an edge frame write `z = (s, t)`; `f(s) = 1 + √3/2 − √(1 − (1/2 + |s|)²) − √(1 − s²)`.

**(C0) `f ≥ 0` on `[−1/2, 1/2]`, zero only at `s = 0`** [hand; `f(0) = 0` exact, H2]: both square roots decrease in `|s|`, so `f` increases in `|s|`,
and `f(0) = √3/2 − √(3/4) = 0`. *Meaning:* the vesica's lower boundary `t = 1 − √(1 − (1/2 + |s|)²)` lies on or above `t = √(1 − s²) − √3/2`, where
the down triangle's apex `(0, −√3/2)` starts to exclude (`D ≥ 1`); by the mirror, the vesica's upper boundary lies on or below the up apex's zone. The
two touch at one point, `(0, 1 − √3/2)` (and its mirror): **the apex excludes the band's vesica exactly, tight at one point.**

By B1, `z` lies in one of:
1. **`B̄(O, 3/2)`:** `z ∉ A` forces `|z − O| ≥ 1/2`: `z ∈ E_{disc}`.
2. **`σ_e + B̄₁` off `V_e`:** `z ∈ E_σ`, and `σ_e ⊆ cl Λ_e ⊆ HC`.
3. **`V_e`** (`V_e ⊆ {|s| < 1/2, 1 − √3/2 ≤ t ≤ 1 + √3/2}`): if `t < 1`, `d_{T_down}(z) = t ≤ 1` and `D_{T_down}(z) ≥ |z − (0, −√3/2)| ≥ 1` by (C0):
   `z ∈ E_{T_down}`. If `t = 1`: `d_{T_down} = 1`, `z ∈ E_{T_down}`. If `1 < t < ℓ(s)`: `z ∈ Λ_e ⊆ A` — excluded by hypothesis. If `t ≥ ℓ(s)`: `d_U ≤ 1`
   (G3) and `D_U = D_{T_up} ≥ |z − (0, 2 + √3/2)| ≥ 1` by (C0)'s mirror (`U` has `T_up`'s vertices and lies in their convex hull, so `D_U = D_{T_up}`):
   `z ∈ E_U`.
4. **`T + B̄₁` for a flat triangle `T`, `z ∉ int T`, `D_T(z) < 1`** (`z` in the bulge `Reuleaux(T) ∖ T` across a side `e`): in `e`'s frame the bulge of
   `T_down` is `{t > 0, s² + (t + √3/2)² < 1} ⊆ {|s| < 1/2, 0 < t ≤ 1 − √3/2}`, within 1 of `σ_e`, and off `V_e` by (C0): case 2. The same by the mirror
   for `T_up`'s flat bulge (`1 + √3/2 ≤ t < 2`).
5. **`T + B̄₁`, `z ∉ int T`, `D_T(z) ≥ 1`:** for `T = T_down`, `z ∈ E_T`. For `T = T_up`: `D_U = D_T ≥ 1`; if `z`'s nearest point of `T_up` is a vertex (a
   vertex of `U`), `d_U = d_T ≤ 1`: `z ∈ E_U`; if it lies on side `e` (then `|s| ≤ 1/2` and `d_T = 2 − t ≤ 1`, so `1 ≤ t ≤ 2`): `t = 1` gives case 3's
   `E_{T_down}`; `1 < t < ℓ(s)` gives `z ∈ A`; `ℓ(s) ≤ t < 2` gives `d_U ≤ 1`, `z ∈ E_U`; `t = 2` with `g(s) = 0` gives `z ∈ ∂U` with `d_σ = 1`, `D_σ ≥ 1`:
   `z ∈ E_σ`; `t = 2` with `g(s) > 0` is case 6.
6. **`z ∈ T_up ∖ int U`, in the sliver of side `e`** (`2 ≤ t ≤ 2 + g(s)`, `g(s) > 0`): **Lemma NL** below gives a point of `cl Λ_e` on `T₁(z)`, and a
   point of `Λ_e` when `2 < t < 2 + g(s)`.

So every `z ∉ A` lies in some `E_B` (`B` a block, or `σ_e ⊆ HC`) or on a unit circle through `cl Λ_e`: **`ℝ² ∖ A ⊆ HC + S¹`**. With §2.3, M2-FIX holds.
*Almost every `z ∉ HC`:* in cases 1–5 the inequalities are strict off the level sets `{|z − O| = 1/2, 3/2}`, `{d_B = 1}`, `{D_B = 1}` (null: distance
functions have `|∇| = 1` a.e. off their sets, so each level set is null, and locally finitely many occur), off `N_e`, and off the one-point
tangencies of (C0); then `T₁(z)` meets `A` (by the `E°` facts above), in an open arc. In case 6 with `t > 2` it meets `Λ_e`. So `φ_A > 0` a.e. off `A`,
and `A` is MUA by M2-ZERO; `HC = cl A = supp A`, `|∂HC| = 0` (segments, circles, and graphs of continuous functions, locally finitely many):
**regular**. ∎

**Lemma NL (the sliver is excluded through the band)** [hand, one mind; constants H4, H5]. *In an edge frame let `z = (s, t)`, `|s| < 1/2`,
`2 < t < 2 + g(s)`. Then `T₁(z) ∩ Λ_e ≠ ∅`; for `t = 2 + g(s) > 2` (a point of `∂U`), `T₁(z) ∩ cl Λ_e ≠ ∅`.* *Proof.* `δ = d_U(z) ≤ 2 + g(s) − t <
g(s) ≤ (1/2 − |s|)²/4`, while the other sides of `U` are `≥ 0.8(1/2 − |s|) − (1/2 − |s|)² > δ` away (as in G2); so the nearest point `u* = (σ, 2 + g(σ))`
lies on the bottom graph, `|σ| < 1/2`, and `z = u* + δν` with `ν = (g′(σ), −1)/√(1 + g′(σ)²)`, the downward unit normal. Put `p = u* + (1 + δ)ν`, so
`|p − z| = 1`.
- *`p_t > 1`:* `t > 2` gives `2 + g(σ) > 2 + δ/√(1 + g′²)`, so `p_t = 2 + g(σ) − (1 + δ)/√(1 + g′²) > 2 − 1/√(1 + g′²) ≥ 1`. And `p_t < 2`.
- *`|p_s| < 1/2`:* `|p_s − σ| ≤ (1 + δ)|g′(σ)| ≤ (65/64)(1/2)(1/2 − |σ|) < 1/2 − |σ|` (G1, `±1/2 ∈ Z`).
- *`d_U(p) > 1`, by an exterior disc of radius `R = 5/4`:* let `c = u* + Rν`. For `w` in the open disc `B(c, R)`, write `w − u* = x m + y n` (`m` the unit
  tangent, `n = −ν`); then `y < −R + √(R² − x²) ≤ −x²/(2R) = −(2/5)x²` and `y ≥ −2R`. The vertical line through `w` meets the tangent line
  `ℒ(s) = 2 + g(σ) + g′(σ)(s − σ)` at height `ℒ(w_s) = w_t + λ`, `λ = −y/⟨e₂, n⟩ ≥ −y ≥ max((2/5)x², |y|)`; and `h = w_s − σ` has `|h| ≤ |x| + |y||g′| ≤
  |x| + |y|/8`, so `h²/4 ≤ (5/16)x² + (5/256)y²` (`(a + b)² ≤ (5/4)a² + 5b²`). By H5, `max((2/5)x², |y|) > (5/16)x² + (5/256)y²` for `|x|, |y| ≤ 5/2`,
  `(x, y) ≠ 0`. So `w_t < ℒ(w_s) − h²/4 ≤ 2 + g(w_s)` (G1) whenever `|w_s| ≤ 1/2`: `B(c, R)` misses `{|s| ≤ 1/2, t ≥ 2 + g(s)} ⊇ U` (G2). Since
  `1 + δ < R` and the discs `B(p, 1 + δ)` and `B(c, R)` are internally tangent at `u*`, `B̄(p, 1) ⊆ B(p, 1 + δ) ⊆ B(c, R)`, so `d_U(p) > 1`.

With G3, `p ∈ Λ_e`. For `z ∈ ∂U` (`δ = 0`), `p = u* + ν` has `d_U(p) = 1`, `p_t ≥ 1`: `p ∈ cl Λ_e`. ∎

### 2.5 The exact check, `tools/fs111_m3_honey.py`

Arithmetic in `ℚ(√3)` (a class `Q3`, signs decided by comparing squares; no floats in a verdict). Output `data/fs111/fs111-m3/honey.out`, exit 0:
- **H1** (block distances, a patch of 12 triangles, 18 segments, 7 discs within 6 of a face centre): minima triangle–triangle 2, triangle–segment
  (non-flanking) `√7 ≈ 2.6458`, segment–segment `√3`, disc-centre–triangle 2, disc-centre–segment `√3`; every flanking triangle–segment pair at distance
  exactly 1. **PASS.**
- **H2** `f(0) = 0` exactly. **H3** `Q ⊆ B̄(v, 1) ∪ B̄(e, 1)` (worst vertex `0.6197` from its centre). **H4** the gap polynomial's identities and bounds
  (sympy). **H5** the constants `425/1280 < 2/5`, `425/512 < 1`. **All PASS.**
- **H7** (a control, not the proof): the flat skeleton with the bands as segments at 731 exact grid points within `5/2` of a face centre: none free,
  none interior and on a unit circle about the skeleton. **PASS.**
- **Plants, each firing:** `side19` (triangles of side `19/20`): H1 (flanking distance `≠ 1`), H2 (`f(0) < 0`), H7 (30 free points, on the segments —
  the gap exceeds 2 and the band's region is free); `closer` (`L − 1/10`): H1 (triangles within 2, segments within 1 of their flankers), H7 (interior
  points on unit circles); `nosigma`: H3; `eps1/2` (`g` doubled): H4; `R2` (exterior radius 2): H5.

### 2.6 What M3-HC decides

| rung | verdict | grade, minds |
|---|---|---|
| **M2-PINCH-C** as stated | **vacuously TRUE** (M3-VAC: its hypothesis is unsatisfiable) — MISSTATED | [hand], one mind |
| **M2-PINCH-C** corrected ("some regular MUA set contains a Cantor pinch") | **TRUE**: HC_K, in every band (two blocks at distance 2, flat side against a graph touching its unit parallel exactly on the Cantor set, the band in `int F`) | [hand + tools exact], one mind |
| **MUA-FIN-U** ("every regular MUA set has locally finitely many components") | **FALSE**: HC_K | [hand + tools exact], one mind |
| **MUA-FIN** in M2's words (a finite union of Jordan arcs per bounded set) | **holds for HC_K** — each band's boundary is two arcs | [hand] |
| **MUA-FIN with D3's clause** (arcs meeting only at endpoints) | **fails for HC_K** — the two arcs of each band meet on `Z × {1}`, infinitely often. VM2's D3 is the clause that makes the difference, and it is what M2-REDUCE-C uses | [hand], one mind |

*What it says.* Local finiteness is not a consequence of maximality one class at a time: a maximal unit-avoiding set can carry, inside every period,
infinitely many components of its interior, pinched on a Cantor set, and it is regular. The mechanism is §1.5's: a flat side of length 1 forces a band
at distance 1, the band cuts itself off at length exactly 1, and the band's thickness is the gap's excess over 2 — free to vanish on any closed null
set. **Any closed null `Z` works**, countable included (`Z = {0, ±1/2} ∪ {±1/2^n}` gives components accumulating at points). HC₀ (no pinch) is a regular
MUA set with finitely many components per bounded set, of four shapes (triangles, curved triangles, bands, discs).

*Would kill it:* a point of the plane outside `A` on no unit circle about HC (a defect in B1, B2 or Lemma NL), or two points of `A` at distance 1 (a
defect in §2.3). *Controls:* R7's ups (Reuleaux triangles of width 1) are the same mechanism with no flat side, hence no band; SQ9's squares have flat sides
of length `1/2` facing flat sides at distance exactly 1 (W's ladder), where no band is needed because the facing square excludes the gap directly.
