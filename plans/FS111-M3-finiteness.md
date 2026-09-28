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
