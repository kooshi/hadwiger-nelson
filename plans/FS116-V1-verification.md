# FS116-V1 — a blind second mind on FS116-O1-YESLIM, FS116-O1-SATPIN and FS114-N7-3T

*Job FS116-V1 (Ephodos, verification form; Opus 5.5), brief `data/fs116/briefs/FS116-V1-verify.md`, launched 2026-09-29 05:44 UTC.
The standing rules (`plans/STANDING-RULES.md`) are part of the brief. Verdicts in the project's words: TRUE, FALSE with the
counterexample, GAP at a step, MISSTATED with the corrected statement; in the gate's grammar `derived`, `refuted:`, `gap:` /
`stalls at:`.*

## Theorems this phase proved

*(filled at each stage)* Stage 1 proves nothing.

## Would-have-searched-here log (standing rule 5)

- *(none yet)*

## Fence log (standing rule 8)

- No fenced path read. The commit subjects shown at launch ("FS116-O1: report", "FS116-O1: report hashes", "FS-116: claim list
  frozen", "FS-116, FS-121: round 1 briefs", and FS-121's) carry no verdict.

## Stage 1 — SAVED: the readback, what was given, and the registered expectations

### 1.1 Quotation check (standing rule 3)

`tools/fs116_v1_quotes.py` extracts each statement block the brief quotes (from `> - **NAME**` to its `> — source` line) and looks
for it, whitespace-normalised, in `data/fs116/claims.md`. Output (2026-09-29 05:47 UTC):

```
ok   FS116-O1-YESLIM  (550 chars)
ok   FS116-O1-SATPIN  (954 chars)
ok   FS114-N7-3T  (1306 chars)
blocks: 3  mismatches: 0
```

With `--plant` (one character deleted from each quotation) it prints `MISS` three times and exits 1: the check fires. The brief's
three quotations are the frozen list's, verbatim. **Not checkable by me:** FS114-N7-3T's own source, `plans/FS114-derivation.md` § 3,
is fenced; the frozen list's quotation of it is taken as the statement.

### 1.2 The statements, restated verbatim

- **FS116-O1-YESLIM** (`data/fs116/claims.md` § 3): "for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid
  k-coloured fragment (a map of an open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at
  distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR". *Not claimed:* the converse; that the limit colouring is a map, saturated or
  regular; anything about the fragments' centres; anything from fragments on discs of one bounded radius.
- **FS116-O1-SATPIN** (`data/fs116/claims.md` § 3): "let p be a vertex of at least four colours of a valid k-coloured fragment saturated
  on a disc about p, every tile at p with a cone of positive angle; each edge e at p, with side colours a (clockwise) and b (counter-clockwise) and unit normal
  ν pointing to b's side, is near p of exactly one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support,
  a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the
  closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is
  carried on ω(p)". *Not claimed:* anything at a cusp at `p`; that the split centre has four colours; that any saturated valid six-coloured fragment about a
  four-colour vertex exists; SAT-STRIP.
- **FS114-N7-3T** (`data/fs116/claims.md` § 8, quoting `plans/FS114-derivation.md` § 3): "**Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius
  `1 + ε`**, except the open-cap family **OC** (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses
  do not border the caps): the `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a
  four-colour vertex, non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours:
  the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}`
  by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)". *Not claimed* (the entry's own line,
  verbatim): "rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC (its
  forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the construction
  side's E2 is not settled, `plans/FS114-C-close.md` stage 2 §2.5)".

### 1.3 What was given (recorded as it was seen, 2026-09-29 05:44–05:58 UTC)

Before any verdict I have read, in this order: the brief; `plans/STANDING-RULES.md`; the head of `.claude/agents/ephodos-verifier.md`
(the identity) and its § A derivation job (the verdict mapping); `data/fs116/claims.md` in full; `data/fs114/claims.md` in full;
`data/fs111/claims.md` lines 1–60 (§ 0 definitions, § 1's first held inputs); `plans/FS111-M-regularity.md` §§ 2.1–3.1 in full —
**this includes M-PINCH's statement and proof** (the pinching lemma, a held input FS111-M-PINCH of the frozen list, and the
lemma most likely under SATPIN's first derivation), M-SATC, M-SLACKFREE, R7 and M-R7-FORCE, M-DEADLOCK; `LEDGER.md` rows 134–141
and the § B lines of the FS-114 entries (which include N7-3T's one-line summary "three or more tactic edges at a degree-4 vertex
with a (Q)-free ring are excluded at radius `1 + ε`, except the open-cap family OC; the ring's six change points are four-colour
vertices | hand; one mind: N7; tools exact at named values", and the one-line summaries of N3-LOCAL, N3-DR, N4-*, N5-GRING,
N6-NOQ, Y5-PINALL, Y6-E1CAP, Y6-E2RED, Y6-HALF, N7-QOPP and FS114-K1); `CLAUDE.md` and the grokkings (preloaded; G83–G86 describe
saturation, the pinch lemma, integer radii and the four-colour vertex); the gate's verification lint and the shipped example.
Also brought, from my own training: the weak-* compactness argument for measurable colourings and the Rajchman property of the
circle measure (`σ̂(ξ) = J₀(2π|ξ|) → 0`); de Bruijn–Erdős. **I have not read** any FS-116 or FS-114 record, plan, stub, brief,
report or tool; no transcript.

**The consequence for the count.** On YESLIM nothing of the first derivation was given: blind. On SATPIN the held pinch lemma's proof
was read before deriving, so my route is blind to SATPIN's first derivation but not to the lemma's method — the minds line says so.
On N7-3T its terms are defined only in fenced records; I asked for the definitions (1.4).

### 1.4 Reading questions sent to "main" (2026-09-29 05:57 UTC), verbatim in substance

- **SATPIN (S1)**: is `a ≠ b` part of "edge … with side colours a and b"? The definitions let two tiles of one colour share an edge
  (a spurious segment ending at `p`); its points are not essential boundary points, saturation is silent there, and such an edge is
  neither type. Literal reading: FALSE by that object; reading `a ≠ b`: no such object.
- **SATPIN (S2)**: does "exactly one of two types" assert that no edge meets both descriptions? A unit arc about `y` with
  `y ∈ supp a ∩ supp b` whose inner colour also has `2x − y` in its closure for `x` near `p` meets both.
- **N7-3T (N1–N7)**: the definitions, verbatim with addresses and with no argument, of: a tactic edge's sign and the order in
  `+−+`, `++−`, `−++`; Reuleaux lens, non-Reuleaux lens, 60° anti-lens, cap, the family OC and its members, the Reuleaux bowtie
  whose lenses do not border the caps; what `(2, 1, 1, 0)` counts; the pinwheel and `γ`; "die in every member"; "excluded at radius
  `1 + ε`" (for some or every `ε`, containing a neighbourhood of `B̄(p, 1)`?) and whether "non-Siamese and simple" is a hypothesis of
  the headline or only of N7-HUB; "(Q)-free after the bends"; "four-colour vertex"; "tip"; "`p`-tiles face away".

Until an answer comes I read S1 as `a ≠ b` provisionally and report both readings.

### 1.5 Registered expectations (before any written derivation)

*Written 2026-09-29 05:59 UTC. Honest timing: for YESLIM and SATPIN these were formed after about fifteen minutes of reading the
definitions and the held pinch lemma and thinking about both statements — informed, not naive. For N7-3T, before any derivation.*

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| YESLIM | derived | 0.90 | the passage from fragments on growing discs to one measurable colouring of the whole plane: a weak-* limit does not keep products unless the circle measure's decay is used; second, whether "map" fixes a null boundary |
| SATPIN | derived | 0.50 | "exactly one of two types" — the two descriptions can overlap on a unit arc — and edges with equal side colours; otherwise gap at exclusivity (0.35) or refuted by an edge of neither type (0.15) |
| N7-3T | gap | 0.60 | the headline carries no "non-Siamese and simple" while its N7-HUB clause does; the pattern cases turn on terms defined only in fenced records; derived 0.20, refuted or MISSTATED 0.20 |

### 1.6 The author's answers on SATPIN (relayed verbatim by Keryx, received 2026-09-29 06:03 UTC, after 1.5 was written)

"(S1) The reading a ≠ b is meant. An "edge" in the statement is a boundary arc between tiles of two different colours. A boundary
arc between two tiles of one colour is not an edge in the statement's sense.

(S2) The reading "one of" is meant: every edge is at least one of the two types. "Exactly one" is not meant to assert that no edge
satisfies both descriptions as written."

SATPIN is worked under these readings; the literal wording is reported beside them. N7-3T's definitions (N1–N7) are being copied
from FS-114's records into a file outside the fence, to be named in a dated amendment to the brief.

### 1.7 The gate at this stage

`derive_gate.py all` on this record fails once, "no derivation entry", because no `verification:` block can be written before a
verdict exists; the record passes from stage 2 on.

## Stage 2 — SAVED: FS116-O1-YESLIM and FS116-O1-SATPIN — derivations, attacks, verdicts

### 2.0 Correction to stage 1's times (2026-09-29 05:58 UTC)

Stage 1's clock times after 00:47 were written without reading the clock and run ahead of it. From `date` and the commit: the
questions went to "main" at about 00:50, § 1.5's expectations were written at about 00:51, the author's answers (§ 1.6) arrived at
about 00:52, and stage 1 was committed at 00:53:29 (`5b0b64cc`). The order stands as recorded: the expectations were written before
the answers arrived and before any written derivation. Stage 1's text is left as committed.

### 2.1 YESLIM — the derivation (my route)

*Reading.* A valid `k`-coloured fragment is as the statement's parenthesis says; its boundary `Γ` is "a locally finite union of arcs
… `Γ` is null" (the list's § 0, quoting `plans/FS110-N-proof.md` § 1.3), its tiles the components of the complement, open. "`k`-coloured"
means colours from `{1, …, k}`. `χ_m⁰(ℝ²) ≤ k` means: some Lebesgue-measurable `f : ℝ² → [k]` has
`(Leb ⊗ σ){(x, u) : f(x) = f(x + u)} = 0`, `σ` the normalised arc-length measure on the unit circle `S¹`.

**Step 1 (the fragments, in integral form).** For each `n ≥ 1` take a valid `k`-coloured fragment on `B̄(c_n, n)` and translate it
so that `c_n = 0` (translation keeps validity). Let `S_j^n` be the union of its open tiles of colour `j`, and `g_n^j = 1_{S_j^n ∩ B(0,n)}`.
For `R + 1 < n`: `∫_{B(0,R)} ∫_{S¹} g_n^j(x) g_n^j(x + u) dσ(u) dx = 0`, because the integrand is **identically** zero: `x` and `x + u`
in `S_j^n` are two interior points of colour `j` at distance exactly 1, which validity forbids.

**Step 2 (a limit).** `L^∞(ℝ²) = L¹(ℝ²)*` with `L¹` separable, so a subsequence has `g_n^j ⇀* φ_j` for every `j`, `0 ≤ φ_j ≤ 1`.
`Σ_j g_n^j = 1` a.e. on `B(0, n)` (`Γ_n` is null), so `Σ_j φ_j = 1` a.e. (test against `L¹` functions of compact support, then all
of `L¹`).

**Step 3 (the circle form survives the limit — the one step with content).** Fix `R`. Put `h_n = g_n^j 1_{B(0,R+1)}`, so
`h_n ⇀ h := φ_j 1_{B(0,R+1)}` weakly in `L²`, and `T v = 1_{B(0,R)} (σ ∗ v)`, `(σ ∗ v)(x) = ∫ v(x + u) dσ(u)`, on `L²(B(0, R+1))`.
`T` is compact: `σ ∗ ·` is the Fourier multiplier `σ̂(ξ) = J₀(2π|ξ|)`, bounded by 1 and tending to 0 at infinity (the circle
measure is Rajchman; `J₀(s) = O(s^{−1/2})`). Split `σ̂ = m_N + r_N`, `m_N = σ̂ 1_{|ξ| ≤ N}`: the `m_N` part, cut by the two
indicators, has kernel `1_{B(0,R)}(x) m̌_N(x − y) 1_{B(0,R+1)}(y)` with `m̌_N ∈ L²` (Plancherel), hence is Hilbert–Schmidt
(`‖K‖₂² ≤ |B(0,R)| ‖m̌_N‖₂²`); the `r_N` part has norm `≤ sup |r_N| → 0`. A norm limit of compact operators is compact. So
`T h_n → T h` in norm, and `⟨h_n, T h_n⟩ − ⟨h, T h⟩ = ⟨h_n − h, T h⟩ + ⟨h_n, T h_n − T h⟩ → 0`. Since `⟨h_n, T h_n⟩` is Step 1's
integral (for `x ∈ B(0,R)`, `x + u ∈ B(0,R+1)`), it is 0 for large `n`, so **`∫_{B(0,R)} φ_j(x) ∫ φ_j(x + u) dσ(u) dx = 0`** for every
`R` and `j`.

**Step 4 (round).** Let `f(x) = min{j : φ_j(x) ≥ 1/k}` where `Σ φ_j = 1` (a.e.; `f = 1` on the null rest): measurable, and
`S_j := f⁻¹(j) ⊆ {φ_j ≥ 1/k}`, so `1_{S_j} ≤ k φ_j` and `∫_{B(0,R)} ∫ 1_{S_j}(x) 1_{S_j}(x + u) dσ dx ≤ k² · 0`. Over `R` and `j`,
`f`'s monochromatic unit pairs are `Leb ⊗ σ`-null: **`χ_m⁰(ℝ²) ≤ k`**.

**Step 5 (`χ(ℝ²) ≤ k`, no MR) — two routes.** (A), straight from the fragments: a finite unit-distance graph `G` with vertices in
`B̄(0, ρ)` is placed in a fragment on a disc of radius `ρ + 1` by a translation `t ∈ B(0,1)` avoiding the null set
`⋃_i (Γ − c − v_i)`; every vertex is then an interior point of a tile, and colouring each vertex by its tile is proper, since an edge
is a pair at distance exactly 1. So every finite unit-distance graph is `k`-colourable, and de Bruijn–Erdős (ZFC; choice) gives
`χ(ℝ²) ≤ k`. (B) `χ(ℝ²) ≤ χ_m⁰(ℝ²)` (`CLAUDE.md` § The aim link 2, held [hand, two minds]; its argument, a random rigid motion puts
each edge's pair in a law absolutely continuous to `Leb ⊗ σ`, then de Bruijn–Erdős) with Step 4. Neither route uses MR; both use
choice through de Bruijn–Erdős. At `k = 6`: `χ(ℝ²) ≤ 6`.

*Uses only:* validity on tile interiors (Step 1), `Γ` null (Step 2), the decay of `σ̂` (Step 3), de Bruijn–Erdős (Step 5); not the
segments and arcs, not local finiteness beyond the null boundary, not the centres. *The model:* at `k = 7` the hexagonal seven-colouring
of circumradius `1/2` restricted to any disc is a valid 7-coloured fragment (`hex7-valid` below: same-colour centres at squared
distance `21/4 > 4`, so same-colour hexagons are more than 1 apart; each hexagon has diameter 1) — the hypothesis class is not empty
at `k = 7`, and the conclusion `χ_m⁰(ℝ²) ≤ 7` is known. At `k = 6` the hypothesis is the open question itself.

control: hex7-valid
  of: FS116-O1-YESLIM — the model at k = 7: the hexagonal seven-colouring is a valid 7-coloured fragment on every disc
  run: python3 ../tools/fs116_v1_hex7.py
  expect: least same-colour centre distance^2 = 21/4; valid: True
  fault: python3 ../tools/fs116_v1_hex7.py --plant-mod6

### 2.2 Attack on YESLIM

- **Small `k`.** At `k ≤ 4` the hypothesis fails (Step 5 (A) would give `χ(ℝ²) ≤ 4`, against rung B), so the implication holds
  vacuously. At `k = 5` and `k = 6` the hypothesis is open (it would give `χ(ℝ²) ≤ k`): a true implication with an undecided
  antecedent. Nothing breaks.
- **One bounded radius (the not-claimed line), attacked.** With "for every `R`" replaced by one radius the implication is false: a
  disc of radius `< 1/2` has diameter `< 1` and carries a valid 1-coloured fragment, while `χ_m⁰(ℝ²) > 1`. So the growth of the discs
  is used, and the not-claimed line is the nearest false statement. **Where the attack succeeds:** here.
- **Each hypothesis removed.** Validity: without it Step 1 fails (a 1-colouring of every disc). "Every `R`": above. Segments and circular
  arcs, local finiteness: **idle** — Steps 1–4 hold for any measurable `k`-colourings of discs `B(c_n, n)` whose monochromatic unit pairs
  are `Leb ⊗ σ`-null and whose uncoloured parts are null (Step 1 then holds a.e. instead of identically). The true class is wider:
  **a thin truth** (reported, not a flaw).
- **"with no MR".** MR (row 128's hypothesis) appears nowhere in Steps 1–5. What is used instead of it is choice (de Bruijn–Erdős).
- **"at `k = 6`".** Step 5 gives `χ(ℝ²) ≤ k` for every `k`; the `k = 6` clause is the instance the programme needs.
- **The converse (not claimed).** `χ_m⁰(ℝ²) ≤ k` gives a measurable colouring, not a map; nothing here makes fragments from it.

verification: FS116-O1-YESLIM
  statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment (a map of an
    open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at
    distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR
  given: the statement, its not-claimed line and the frozen lists' definitions only; nothing of its first derivation (plan § 3.4–4.1a
    fenced and unread); held context read before deriving is § 1.3's (CLAUDE.md's link 2, the FS-111 records' R7 and pinch lemma, LEDGER
    rows 134–141); the weak-* and Rajchman argument brought from my own training
  committed: 2026-09-29
  predicted: derived — 0.90 — likeliest break: the weak-* limit of products (needs the circle measure's decay)
  verdict: derived
  method: weak-* limit of the colour indicators, the circle form carried to the limit by compactness of the Rajchman convolution, then
    rounding at 1/k; the k = 6 clause also straight from the fragments by translation and de Bruijn–Erdős; the first derivation's route
    unknown to me until the comparison
  attack: § 2.2 Attack on YESLIM
  divergences: none — the first derivation stays fenced until these verdicts are committed; the table is § 4
  counterexamples: thin truth: any measurable k-colourings of growing discs with null monochromatic unit pairs and null holes give the
    same conclusion — the segments, arcs and local finiteness are idle beyond a null boundary (Steps 1–2)
  minds: 1 — this mind alone until the comparison, blind to the first derivation, the same model as its author (Opus 5.5)
  grade: hand

### 2.3 SATPIN — the derivation (my route), under the author's readings S1 (`a ≠ b`) and S2 ("one of")

*Setting.* A valid `k`-coloured fragment on an open `U ⊇ B̄(p, R)`, `R > 1`, saturated on `B̄(p, R − 1)` (the list's § 0: every essential
boundary point there is at distance exactly 1 from the support of each colour of its essential multicolour). For a map,
`supp S_c = cl S̃_c` is the closure of the union of the `c`-tiles, which is what "the closure of colour `c`" and "carries `c`" mean.

**L1 (one side of each contact circle).** Let `x` be a smooth point of `Γ` (near `x`, `Γ` is one segment or circular arc through `x`)
with tile `A` of colour `a` on one side, `n_A` the unit normal at `x` into `A`, and let `y ∈ cl(colour a)` with `|x − y| = 1`. Then
either (in) `y = x + n_A` and `A ∩ B(x, δ) ⊆ B̄(y, 1)`, or (out) `y = x − n_A` and `A ∩ B(x, δ) ∩ B(y, 1) = ∅`, for small `δ`.
*Proof.* By local finiteness `y` is in the closure of an `a`-tile `T`, and for small `δ` `T ∩ B(y, δ)` contains a sector `C`, connected
and open, with `y ∈ cl C`; `A_δ = A ∩ B(x, δ)` is connected and open with `x ∈ cl A_δ`. On the connected set `C × A_δ` the distance
`|z − w|` takes an interval of values; validity removes 1 from it (both points interior, colour `a`); `(y, x)` is a limit with distance 1.
So all values are `< 1` or all `> 1`. If `< 1`, letting `z → y`, `A_δ ⊆ B̄(y, 1)`; if `> 1`, `A_δ ∩ B(y, 1) = ∅`. `A_δ` contains
`x + tu` for every `u` with `u · n_A > 0` and small `t > 0`, and `|x + tu − y|² = 1 − 2t u·(y − x) + t²`: containment in `B̄(y, 1)`
for all such `u` forces `y − x = n_A`, disjointness from `B(y, 1)` forces `y − x = −n_A`. ∎

**L2 (the pointwise dichotomy).** Let `x` be a smooth point of an edge with side tiles `A` (colour `a`) and `B` (colour `b ≠ a`), `ν`
the normal into `B`, `x ∈ B̄(p, R − 1)`. Then `x` is an essential boundary point with `P(x) = {a, b}` (density `1/2` each), so
saturation gives `y_a ∈ cl(colour a)`, `y_b ∈ cl(colour b)` at distance 1, and L1 (with `n_A = −ν`, `n_B = ν`) leaves four cases:
- *(in, in)*: `A ⊆ B̄(x − ν, 1)`, `B ⊆ B̄(x + ν, 1)` near `x`. The two closed discs are tangent at `x` from opposite sides, and every
  neighbourhood of `x` holds a non-empty open set outside both (about `x + tτ`, `τ` the tangent, small `t ≠ 0`); it would lie in `Γ`,
  which has empty interior. Impossible.
- *(in, out)* and *(out, in)*: `y_a = y_b =: y`, and one side lies in `B̄(y, 1)`, the other misses `B(y, 1)`: the arc through `x` is
  tangent to `T₁(y)` with curvature at least 1 toward `y` (the first) and at most 1 (the second), so near `x` the edge **is** `T₁(y)`,
  and `y ∈ cl(colour a) ∩ cl(colour b)` — **split at `x`**.
- *(out, out)*: `y_a = x + ν`, `y_b = x − ν`, and neither side meets the open unit disc on the other side: the arc through `x` enters
  neither `B(x + ν, 1)` nor `B(x − ν, 1)`, so it is a segment or has radius at least 1 — **tangent at `x`**, `x + ν ∈ cl(colour a)`,
  `x − ν ∈ cl(colour b)`.

**L3 (from points to the edge).** Near `p` an edge `e` at `p` is one segment or circular arc (local finiteness), all its points other
than `p` smooth, with the same side tiles `A`, `B`. If some `x ∈ e` is split, `e` is an arc of `T₁(y)`, `y` its centre, and since
`p ∈ cl e`, `|p − y| = 1`: `y ∈ ω(p)` carries `a` and `b` — **(split)**, a unit arc of kind both, and every point of `e` near `p` is
split. If none is, every `x ∈ e ∖ {p}` near `p` is tangent: `e` is a segment or an arc of radius at least 1 with `x ± ν(x)` as stated —
**(tangent)**; and since the closures are closed and `ν(x) → ν(p)` (the one-sided normal), `p + ν(p) ∈ cl(colour a)`,
`p − ν(p) ∈ cl(colour b)`: two antipodal points of `ω(p)` on the normal to `e` at `p`. So every edge at `p` is at least one of the two
types.

**L4 (every colour of `p` on `ω(p)`).** Let `c` be a colour of `p`. Going round `p`, the tiles of colour `c` at `p` fall into maximal
runs of consecutive tiles of colour `c`; `p` has at least two colours, so a run ends at an edge (S1's sense) with `c` on one side. By L3,
`c` is carried at that edge's centre `y ∈ ω(p)` or at `p ± ν(p) ∈ ω(p)`. ∎

*Uses only:* validity (L1), saturation at the smooth points of the edges at `p` (L2), local finiteness (L1, L3), `a ≠ b` (L2's
`P(x) = {a, b}`; without it nothing binds the edge). **Not used:** that `p` has four colours (two suffice for L4, none for L3), and that
every tile at `p` has a cone of positive angle — L2 and L3 read only points `x ≠ p`, and L4 needs only that a tile at `p` is bounded near
`p` by two pieces of `Γ`, cusps included.

**The statement as it should read (under S1, S2), reported for the author:** "… each edge e at p (a boundary arc between tiles of two
different colours), with side colours a … is near p of at least one of two types — (split) … or (tangent) …". As written, "exactly one"
claims more than the derivation carries, and the author has said it is not meant (§ 1.6).

control: sq9-satpin-model
  of: FS116-O1-SATPIN — the model at k = 9 (FS111-W-SQ9): valid, saturated on B̄(p, 1), and the conclusion at a degree-4 four-colour vertex
    p = (1/2, 1/2): four tangent edges, every colour of p on ω(p); the spurious diagonal edge (monster) of neither type
  run: python3 ../tools/fs116_v1_sq9.py
  expect: V: 0 bad of 2080 same-colour pairs; S: 0 bad of 149 boundary points; C: 0 bad; M: spurious edge fails tangent at 4 of
    4 points
  fault: python3 ../tools/fs116_v1_sq9.py --plant-sign

control: sq9-valid-plant
  of: FS116-O1-SATPIN — the same model's validity check fires on a colouring with same-colour squares at distance below 1
  run: python3 ../tools/fs116_v1_sq9.py
  expect: V: 0 bad of 2080 same-colour pairs; S: 0 bad of 149 boundary points; C: 0 bad; M: spurious edge fails tangent at 4 of
    4 points
  fault: python3 ../tools/fs116_v1_sq9.py --plant-colour

### 2.4 Attack on SATPIN

- **The model.** SQ9 (`sq9-satpin-model`): `p = (1/2, 1/2)` is a degree-4 vertex of four colours, all cones `90°`, saturated on
  `B̄(p, 1)` (exact at 149 boundary points of a rational grid, and symbolically: on the line `x = m/2` the points `x ± e₁` lie on the
  lines `x = (m ± 2)/2`, on the boundaries of squares of the side colours); every edge at `p` is (tangent). No split edge occurs in it.
- **Remove saturation.** The capped strip's midline vertex (row 136; FS111-VM2-STRIP-MID, held: "at the midpoint of every edge `A_j | B_j`
  both side colours are free") has segment edges of neither type: saturation is used.
- **Remove `a ≠ b` (S1) — the attack succeeds here, on the literal wording.** SQ9 with a spurious segment from `p` into `S(0,0)`: the colour
  classes and hence validity, the essential boundary and saturation are unchanged, `p` keeps its four colours and all cones positive, and
  the new edge (both sides colour `(0,0)`) is not a unit arc and fails the tangent condition (`sq9-satpin-model`, part M). Under the
  literal reading this refutes "each edge … is of one of two types"; under the author's reading `a ≠ b` it is not an edge. **A monster:**
  the term "edge" was not fixed; the author fixed it (§ 1.6).
- **"exactly one" (S2).** The two descriptions meet on a unit arc about `y ∈ cl a ∩ cl b` whose inner colour also has `2x − y` in its closure
  for `x` near `p` (then with the outer colour `b`, `x − ν(x) = y ∈ cl b` and `x + ν(x) = 2x − y ∈ cl a`). I have no saturated fragment with
  such an edge, so the literal exclusivity is neither refuted nor carried: the author withdraws it. **Wording.**
- **Remove "at least four colours" and "cone of positive angle".** Both idle (2.3's *not used*). R7 (FS111-M-R7, held [tools exact]; its (S):
  "every arc … is centred at a lattice point where both its side colours occur") is a saturated map whose every vertex is a lattice point with
  three cusps, and there every edge is (split) and all six colours of the vertex are carried on its unit circle — the conclusion at a cusp,
  which the not-claimed line sets aside. **A thin truth:** the statement holds at every vertex `p` with at least two colours in the saturated
  disc, cusps allowed.
- **The degenerate cases.** An edge at `p` that is a unit arc about `y` with only one side colour at `y`: then it is not split, and by L2 it
  is tangent, which is consistent — `(R2)`'s form ("an inner-colour tile along the radius-2 circle over the whole arc"). A tangent edge of
  radius exactly 1 exists in the classification; nothing breaks.

verification: FS116-O1-SATPIN
  statement: let p be a vertex of at least four colours of a valid k-coloured fragment saturated on a disc about p, every tile at p
    with a cone of positive angle; each edge e at p, with side colours a (clockwise) and b (counter-clockwise) and unit normal ν
    pointing to b's side, is near p of exactly one of two types — (split) an arc of the unit circle about a point y of ω(p) at which
    both a and b have support, a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has
    x + ν(x) in the closure of colour a and x − ν(x) in the closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two
    antipodal points of ω(p) on the normal to e at p; and every colour of p is carried on ω(p)
  given: the statement, its not-claimed line, the frozen lists' definitions and the author's two readings (S1 a ≠ b, S2 "one of"); not
    SATPIN's first derivation (fenced, unread); but the held pinch lemma FS111-M-PINCH with its proof (plans/FS111-M-regularity.md § 3.1)
    was read before deriving, and L1–L2 are its method made local to a map
  committed: 2026-09-29
  predicted: derived — 0.50 — likeliest break: exactly one of two types, and edges with equal side colours
  verdict: derived
  method: a connected-product interval argument for each contact (L1), four in/out cases at a smooth edge point (L2), then from points
    to the edge through the edge being one circular arc near p (L3), and colour runs round p (L4); the same case split as the held pinch
    lemma, not independent of it
  attack: § 2.4 Attack on SATPIN
  divergences: none — the first derivation stays fenced until these verdicts are committed; the table is § 4
  counterexamples: monster: SQ9 with a spurious segment from p into one square, an edge with a = b of neither type — the term edge,
    fixed by the author as a ≠ b (§ 1.6); thin truth: R7's lattice points, cusped and six-coloured, where every edge is split and every
    colour is carried on ω(p) — the four-colour and positive-cone hypotheses are idle (L2–L4 read only points x ≠ p)
  minds: 1 — this mind alone until the comparison, blind to SATPIN's first derivation but not to the held pinch lemma's method, the
    same model as its author (Opus 5.5)
  grade: hand

### 2.5 Verdicts (stage 2)

| statement | verdict | the project's words | grade, minds |
|---|---|---|---|
| FS116-O1-YESLIM | derived | **TRUE**; a thin truth (the map structure is idle beyond a null boundary); the `k = 6` clause holds for every `k`, straight from the fragments | [hand], one mind here, blind |
| FS116-O1-SATPIN | derived under S1, S2 | **TRUE as the author means it**; as written **MISSTATED** in two words: "edge" needs `a ≠ b` (else FALSE by the spurious edge, a monster) and "exactly one" should read "at least one"; a thin truth (four colours and positive cones idle; the cusp case holds, R7) | [hand], one mind here, blind to the first derivation, not to the pinch lemma's method |

Expectations scored: YESLIM derived at 0.90 — met; SATPIN derived at 0.50 — met, with the break where it was registered (the
two words).

## Theorems this phase proved (stage 2)

- **V1-YESLIM** — FS116-O1-YESLIM's implication, by weak-* limit and the circle measure's decay; the `k = 6` clause for every `k`,
  straight from the fragments [hand, one mind] — § 2.1.
- **V1-SATPIN** — SATPIN under `a ≠ b` and "at least one", at every vertex of at least two colours in the saturated disc, cusps
  allowed [hand, one mind; the pinch lemma's method] — § 2.3.
- **V1-L1** — one side of each contact circle at a smooth boundary point of a valid map [hand, one mind] — § 2.3.
