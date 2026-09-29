# FS116-V1 — a blind second mind on FS116-O1-YESLIM, FS116-O1-SATPIN and FS114-N7-3T

*Job FS116-V1 (Ephodos, verification form; Opus 5.5), brief `data/fs116/briefs/FS116-V1-verify.md`, launched 2026-09-29 05:44 UTC.
The standing rules (`plans/STANDING-RULES.md`) are part of the brief. Verdicts in the project's words: TRUE, FALSE with the
counterexample, GAP at a step, MISSTATED with the corrected statement; in the gate's grammar `derived`, `refuted:`, `gap:` /
`stalls at:`.*

## Theorems this phase proved

*(each stage adds its own section at its end: stage 2, V1-YESLIM, V1-SATPIN, V1-L1; stage 3, V1-F0, V1-F3, V1-F5, V1-F6, V1-HUB; stage 4, none new)* Stage 1 proves nothing.

## Would-have-searched-here log (standing rule 5)

- None: no move of this job was a search. The frame checks of § 3.2 were done by hand on named configurations, never by program (the list's § 9).

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
  divergences: § 4.1 Divergences on YESLIM
  counterexamples: thin truth: any measurable k-colourings of growing discs with null monochromatic unit pairs and null holes give the
    same conclusion — the segments, arcs and local finiteness are idle beyond a null boundary (Steps 1–2)
  minds: 2 — blind to: the first derivation, until 3daaa05c; the same model as its author (one prior); method: the routes differ at the
    Rajchman step (a compact operator here, dominated convergence of Fourier transforms there) and at the rounding (§ 4.1)
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
  divergences: § 4.2 Divergences on SATPIN
  counterexamples: monster: SQ9 with a spurious segment from p into one square, an edge with a = b of neither type — the term edge,
    fixed by the author as a ≠ b (§ 1.6); thin truth: R7's lattice points, cusped and six-coloured, where every edge is split and every
    colour is carried on ω(p) — the four-colour and positive-cone hypotheses are idle (L2–L4 read only points x ≠ p)
  minds: 2 — blind to: SATPIN's first derivation, until 3daaa05c — not to FS111-M-PINCH's case split, which both routes use; the same model
    as its author (one prior); method: the last clause by a different route (edges here, saturation at p there, § 4.2)
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

## Stage 3 — SAVED: FS114-N7-3T — the frame and N7-HUB derived; the pattern kills not reached (a stall)

### 3.0 What was given for this statement (added to § 1.3)

Brief amendment 1 (2026-09-29 05:59 UTC) and `data/fs116/v1-n7-definitions.md`: definitions only, verbatim from FS-114's records, vetted by
Keryx — the tactic edge and its sign (`+` inner tile counter-clockwise, `−` clockwise), inner counts (anti-lens 0, rotational 1, lens 2),
the lens and `γ = ∠qpq′`, the Reuleaux lens ("`γ = 60°`, cone `120°`, reaching its two centres"), `γ = 0°` ("cone `180°`, one centre"),
the pattern names (`++++` the pinwheel; `+++−`, `++−−` the `(2, 1, 1, 0)` patterns), OC's defining clause in N7's frame
(`D_m = y + 30° + 60m`; `t2 ⊂ Reul(p, y_{a+1}, y_{a+2})`, `t3 = [D_{a+2}, D_{a+3}]`, `t4 ⊂ Reul(p, y_{a+4}, y_{a+5})`, `t1` a tip at `y_a`),
non-Siamese and simple, the bends ("every ring `Γ`-arc but the (Q) arcs is removed"), N7's setting ("a vertex of a non-Siamese valid map
in the simple class carrying exactly four colours (so degree 4)"), the tip, and — added at 01:13 in answer to my scope question — "Up to
rotation and reflection … the sign patterns are `+++`, `++−`, `+−+`, `−++`". The definitions file also shows, as definitions, facts a
derivation would have to reach (the D-frame, "Three tactic edges among four are consecutive"): I read them before deriving, so the frame
below is not blind to its shape, only to its proofs. Also given before: `LEDGER.md` § B's one-line summaries of N3–N7 (§ 1.3).

**Readings worked** (the sources leave them open): "excluded at radius `1 + ε`" = no valid fragment on any open set containing
`B̄(p, 1)` (for every `ε > 0` none on `B̄(p, 1 + ε)`); "four-colour vertex" = exactly four colours — at degree 4 "at least four" is the
same. The headline is worked with `+++` inside it (Keryx, 01:13).

### 3.1 The frame (my route) — setting N

`p = 0` a vertex of degree 4 of a valid six-coloured fragment on an open set containing `B̄(p, 1)`, non-Siamese, simple, tiles
`t1 … t4` of four colours with positive cones, absent colours `A`, `Ā`; the ring `ω(p)` carries no arc of `Γ` (after the bends,
(Q)-free).

- **F0 (the dichotomy).** For two tiles `W₁, W₂` of one colour (equal allowed), `W₁ × W₂` is connected and validity keeps 1 out of its
  distance set, an interval: all distances `< 1` or all `> 1`. So every tile has diameter `≤ 1`, and — non-Siamese — two distinct tiles of
  one colour are far (all distances `> 1`); two tiles of one colour whose closures meet, or which have one pair of points closer than 1,
  are the same tile.
- **F1 (the ring's colours).** A ring point off `Γ` inside a tile of `p`'s colour `c` is at distance 1 from `p ∈ cl t_c`; moving along
  `t_c` near `p` sweeps the distance through 1 inside that tile: invalid. So off `Γ` the ring lies in `A`- and `Ā`-tiles.
- **F2 (the flip).** `z` and `σz` (60° apart) are at distance 1: off `Γ` their colours differ, `r(σz) = r̄(z)`; the change points form a
  finite `σ`-invariant set `C`, with an odd number in every half-open 60° window.
- **F3 (the four regions at a change point `y`).** For `w` near `y` the two ring points at distance 1 from `w` lie near `σy`, `σ⁻¹y`; reading
  their colours through F2 (with `r = A` just clockwise of `y`, `Ā` just counter-clockwise), `w` may be `A` only if `|w − σy| > 1 > |w − σ⁻¹y|`,
  `Ā` only if `|w − σy| < 1 < |w − σ⁻¹y|`. So near `y` the region **I** `= B(σy,1) ∩ B(σ⁻¹y,1)` (the inward `60°` cone) and the region
  **O** outside both discs (the outward `60°` cone) carry only `p`'s colours (six colours in all). Exact to all orders near `y`: the regions
  are cut by the circles `ω(σy)`, `ω(σ⁻¹y)`, which cross at `y` (and at `p`).
- **F4 (tips and outward tiles).** A `c`-tile meeting **I** has a point within 1 of `p ∈ cl t_c`, so by F0 it **is** `t_c`: **I** near `y`
  lies in `p`'s own tiles reaching `y` (tips), and a tile reaching `y` lies in `B̄(p,1) ∩ B̄(y,1)`, cone `⊆ H(ψ_y) = [ψ_y − 90°, ψ_y + 90°]`.
  A `c′`-tile meeting **O** is not `t_{c′}` (its points beyond the ring are more than 1 from `p`), hence far from it: `t_{c′} ∩ B(y, 1) = ∅`,
  cone `⊆ H(ψ_y + 180°)`.
- **F5 (six change points).** Every change point has a tip (F3, F4); a tip reaches only change points pairwise at most 1 apart, all in one
  closed `60°` arc; with `m` (odd) change points per `60°` window a closed `60°` arc holds at most `m + 1`, and four tiles cover at most
  `4(m + 1) < 6m` once `m ≥ 3`. So **`m = 1`: exactly six change points `y_k = y + 60°k`**, ring tiles alternating `A`, `Ā` on six `60°` arcs.
- **F6 (tactic centres are change points; the D-frame).** A tactic edge about `q` has inner tile `x` (a `p`-tile, so `x ⊆ B̄(p,1)` near `q`) and
  a partner of the outer colour at `q` — not the outer `p`-tile itself, which cannot reach `q` (it would lie in `B̄(q, 1)` by F0's diameter bound, yet near `p` it lies outside `B(q, 1)`), so far from it by F0, hence outside `B(p,1)` near `q`. If `q ∉ C`, the ring is one absent
  colour on both sides of `q`; the two ring sectors at `q` are separated by `x` inside and the partner outside, so they are two tiles of one
  colour (a simple tile never touches itself) whose closures meet — close, against non-Siamese. So `q ∈ C`: every tactic centre is a
  change point and every tactic edge leaves `p` at some `D_m = y + 30° + 60°m`, its inner tile a tip there, its outer tile a `p`-tile
  outside `B(q, 1)` whose colour is outward at `q`.
- **F7 (reach).** A `p`-tile reaching two change points reaches two consecutive ones and lies in their Reuleaux triangle with `p`
  (`Reul(p, y_k, y_{k+1})`, cone `⊆ [D_{k−1}, D_{k+1}]`); a tactic edge is at most `60°` long (two inner points near its ends would be `≥ 1`
  apart otherwise, against F0's diameter bound).

**N7-HUB, derived** (my route): each change point `y_k` carries `A` and `Ā` (its two ring sides), the colour `c` of a tip (region **I**) and a
colour `c′` of region **O**; `c ≠ c′`, since the **O**-tile is far from `t_c` while the tip is `t_c` itself, and two `c`-tiles meeting at `y_k`
are one tile (F0). So `y_k` is a vertex of at least four colours; and the tip lies in `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so a tile of its colour at
`y_{k±1}` is within 1 of it and by F0 is the tip's own tile — "carried at `y_{k±1}` by no other tile". Every clause of N7-HUB's parenthesis is
carried. *Uses:* six colours, exactly four at `p`, non-Siamese (F0), the ring free of `Γ`-arcs near `y_k`, `σ^{±1}y_k`. *Not used:* degree 4
beyond one tile per colour; any tactic edge.

### 3.2 The exclusion — where my derivation stops

The frame reduces the headline to a finite list of cone configurations: four cones at `p`, tactic edges only at the `D_m`, each change point
reached by a tip facing it (F4, F7), and for each `k` an outward colour at `y_k` whose tile faces `y_{k+3}` and which is a tip at none of
`y_{k−1}, y_k, y_{k+1}` (by F0: an **O**-tile at `y_k` within 1 of a tip at `y_{k±1}` would be that tip). I checked these colour-level
conditions by hand, not by program (the list's § 9 forbids enumerating ring types by program), on three members:
- **OC** (`a = 0`: `t2` reaching `y1, y2`, `t3 = [150°, 210°]` the tip at `y3`, `t4` reaching `y4, y5`, `t1` the tip at `y0`, `θ_4 ∈ [270°, 330°]`)
  passes every condition (at `k = 4` only through `t2`);
- **the pinwheel** at spacing `(1, 2, 1, 2)` (edges at `D_0, D_1, D_3, D_4`, tiles `[30°, 90°]` reaching `y1, y2`; `[90°, 210°]` reaching `y3`;
  `[210°, 270°]` reaching `y4, y5`; `[270°, 30°]` reaching `y0`) passes them all;
- **`+++`** at `D_0, D_1, D_2` (`t2 = [30°, 90°]` reaching `y1, y2`, `t3 = [90°, 150°]` reaching `y3`, `t4 = [150°, θ_4]` reaching `y4`, `t1`
  forced to reach `y5` and `y0`, `θ_4 ∈ [270°, 330°]`) passes them all; so does the `γ = 0°` lens (`t = H(ψ_m)` with three `60°` tiles).

So **the colour-level frame kills none of these**; the headline rests on geometric kills at radius `1 + ε` — second-order straddles along the
tactic arcs and the ring (row 138's mechanism) — which I did not derive for any pattern. One step toward them is carried: in the `γ = 0°`
lens the two tactic edges are arcs of `ω(y_m)` ending strictly before `y_{m±1}` (the lens cannot reach `y_{m±1}`, its cone not facing them),
so each ends at a vertex inside the ring where a third tile enters; what that tile can be is where I stop. **Stall: the per-pattern kills
(`(2, 1, 1, 0)`, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `+++`, `++−`, `−++`) at radius `1 + ε`.**

### 3.3 Attack on N7-3T

- **The model.** The statement is an exclusion, so its model is the excepted family: OC passes the frame (3.2), and FS114-Y2-BOWTIE (held,
  row 138; a bowtie whose caps are (Q) arcs, so outside the (Q)-free class) is a valid fragment on `B̄(p, 3√3/5)` with four tactic edges —
  the exclusion is not vacuous in shape, but no object with a (Q)-free ring and three tactic edges is held on either side.
- **The headline's hypotheses, removed in turn — the attack succeeds here, on the wording.** The headline reads "Three or more tactic edges
  at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`": it names neither six colours, nor four colours at `p`, nor
  non-Siamese, nor simple, nor the bent map. My frame uses **non-Siamese** at F4, F5, F6 and N7-HUB (tips are `p`'s own tiles; tactic centres
  are change points), **simple** at F6, **four colours** at F1–F3 (two absent colours), **six colours** at F3, and **the ring free of
  `Γ`-arcs** at F3 — the bends remove every ring arc but the (Q) arcs, and "(Q)-free" then leaves none, so "(Q)-free ring" in the headline is
  the bent map's ring. A degree-4 vertex of a Siamese map may carry three colours (a repeated colour at `p` is exactly a Siamese pair,
  F0), and nothing then gives two absent colours or the flip. I have no object refuting the headline without these hypotheses, so this is a
  **statement defect** (the conveyed exceeds what any derivation I can see carries), not a refutation: the headline should carry N7's
  setting. Row 138's not-claimed line already says "every exclusion here is non-Siamese and simple"; the entry's headline does not.
- **The parenthesis is a second claim.** "(with N7-HUB: …)" states a lemma of its own with a sketch inside the statement — a rider. I derived
  it (3.1); it should be its own entry.
- **The enumerated list omits `+++`** (Keryx's answer, 01:13: the record names four three-edge patterns, the list three); a wording gap,
  logged by Keryx. `+++` passes the colour-level frame (3.2), so it needs its own kill.
- **"each of the six change points"** presupposes six; F5 derives it (with non-Siamese), so the presupposition is carried.
- **Where the attack did not succeed:** no configuration outside OC was shown to survive at `1 + ε`, and no member of OC was shown to die.

verification: FS114-N7-3T
  statement: **Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`**, except the open-cap family **OC**
    (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses do not border the caps): the
    `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a four-colour vertex,
    non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions
    toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other
    tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)
  given: the statement and its not-claimed line; the definitions of data/fs116/v1-n7-definitions.md (verbatim FS-114 definitions, vetted, which show
    the D-frame's shape and N7's setting but no argument); Keryx's answer naming +++; LEDGER § B's one-line summaries of N3–N7; nothing of N7's proof
    record or FS-114's derivation file (fenced, unread)
  committed: 2026-09-29
  predicted: gap — 0.60 — likeliest break: the headline carries no non-Siamese and simple while its N7-HUB clause does; the pattern cases
  verdict: stalls at: the per-pattern kills at radius 1 + ε — the frame (six change points, tactic centres at change points, tips, outward
    tiles) and N7-HUB are derived, and the colour-level frame kills none of OC, the (1, 2, 1, 2) pinwheel, +++ or the γ = 0° lens
  method: F0's same-colour dichotomy (connected product, validity, non-Siamese) and the ring's flip under σ, read at a change point as four
    regions cut by ω(σy) and ω(σ⁻¹y); the first derivation's route unknown to me until the comparison
  attack: § 3.3 Attack on N7-3T
  divergences: § 4.3 Divergences on N7-3T
  counterexamples: none — searched by hand over the colour-level frame on OC, the (1, 2, 1, 2) pinwheel, +++ and the γ = 0° lens (none refuted,
    none built); the headline's missing hypotheses are a statement defect with no refuting object (§ 3.3)
  minds: 1 — the pattern kills (not derived here; the +++, b = a + 1 step checked only after reading, a checking reading); N7-HUB (b), (c):
    2, blind to its proof, the same model (§ 4.3)
  grade: hand

### 3.4 Verdict (stage 3)

| statement | verdict | the project's words | grade, minds |
|---|---|---|---|
| FS114-N7-3T | stalls at the per-pattern kills | **GAP** at the pattern kills (not re-derived); **N7-HUB TRUE** (derived here, blind to its proof); the frame (six change points, the D-frame, tips) TRUE; **statement defects:** the headline omits non-Siamese, simple, four colours at `p`, six colours and the bent ring, all used; the N7-HUB parenthesis is a rider; `+++` missing from the list | [hand], one mind here |

Expectation scored: gap at 0.60 — met in the project's words (GAP), recorded by the gate as `stalls at`; the registered break (the headline's
missing non-Siamese and simple) is where the attack succeeded.

## Theorems this phase proved (stage 3)

- **V1-F0** — in a valid fragment two tiles of one colour are close or far; every tile has diameter `≤ 1` [hand, one mind] — § 3.1.
- **V1-F3** — at a change point of a Γ-free ring of a four-colour vertex, six colours: regions I and O carry only `p`'s colours [hand] — § 3.1.
- **V1-F5, V1-F6** — non-Siamese, simple: exactly six change points; every tactic centre is a change point [hand, one mind] — § 3.1.
- **V1-HUB** — N7-HUB [hand, one mind, blind to its proof] — § 3.1.

## Stage 4 — SAVED: the comparison, the divergence tables, retractions

*Opened after the verdicts' commits (`3daaa05c` for YESLIM and SATPIN, `894db2d9` for N7-3T), 2026-09-29 06:15–06:18 UTC, and only these:
`plans/FS116-local-exclusion.md` §§ 3.4–3.5 and 4.1–4.1a; `plans/FS114-N7-proof.md` § Stage 2 (§§ 2.1–2.3); `plans/FS114-derivation.md`'s
FS114-N7-3T entry (ll. 711–728).*

### 4.1 Divergences on YESLIM

| # | item | this route | the first derivation | class | resolution |
|---|---|---|---|---|---|
| 1 | the Rajchman step | `T = 1_{B(0,R)}(σ ∗ ·)` on `L²(B(0,R+1))` is compact (Hilbert–Schmidt cut-off plus a small tail), so `T h_n → T h` | `ĥ^n_j → ĥ_j` pointwise, bounded, dominated convergence on the ball `‖ξ‖ ≤ T`, the supremum of `J₀` beyond `T` on the tail | route | kept both; each is sound |
| 2 | the rounding | `f = min{j : φ_j ≥ 1/k}`, `1_{S_j} ≤ kφ_j` | `F = min{j : g_j > 0}`, `g_j (g_j ∗ σ) = 0` forces `g_j(x + w) = 0` for σ-a.e. `w` | route | kept both |
| 3 | the `k = 6` clause | also straight from the fragments (translate a finite graph into a fragment; de Bruijn–Erdős), no limit | through `χ(ℝ²) ≤ χ_m⁰(ℝ²)` (row 130) | route | kept both; mine shows the clause needs no measure theory |
| 4 | the model at `k = 7` | the hexagonal seven-colouring (`hex7-valid`) | R7 | route | kept both |
| 5 | the class the argument carries | the map structure idle beyond a null boundary; a.e.-properness suffices (a thin truth) | "nothing about the centre, the four-colour vertex, the unit arcs or the complexity" | wording | the same finding; mine states it a little wider — for the author |

Retractions: none. Truth divergences: none.

### 4.2 Divergences on SATPIN

| # | item | this route | the first derivation | class | resolution |
|---|---|---|---|---|---|
| 1 | the pointwise dichotomy | L1 (a connected-product interval) and L2's four cases, curvature read off the single circular arc | FS111-M-PINCH and FS111-M-C11 applied at the edge's interior points | route | kept both; the same case split (in/out), so not independent on method |
| 2 | from points to the edge | near `p` the edge is one circular arc, so one split point makes it `T₁(y)` | split points open (M-C11 (iii)) and closed (a limit argument), so all or none | route | kept both |
| 3 | "every colour of `p` is carried on `ω(p)`" | through the edges (L4), with no use of the cones | saturation at `p` itself, `p` an essential boundary point of each colour (uses the positive cones) | route | kept both; mine carries the clause at cusps too — the thin truth of § 2.4 |
| 4 | "exactly one of two types" | not carried as exclusivity; "at least one" | the classification "all split or none split", read as the type | wording | the author's S2 answer: "one of" is meant; the statement should say "at least one" |
| 5 | "edge" | needs `a ≠ b` (the spurious edge is of neither type) | "`x` is an essential boundary point of both side colours" — `a ≠ b` presupposed | wording | the author's S1 answer: `a ≠ b` is meant; the statement should say so |
| 6 | the grade | [hand], self-contained | derived from FS111-M-PINCH, FS111-M-C11 | route | kept both |

Retractions: none. Truth divergences: none.

### 4.3 Divergences on N7-3T

| # | item | this route | the first derivation | class | resolution |
|---|---|---|---|---|---|
| 1 | the pattern kills at `1 + ε` | stalled; § 3.2 said the colour-level frame kills none of OC, the pinwheel, `+++`, `γ = 0°` | killed pattern by pattern with N7-REACH, N7-TAN (the branch of `ω(y_j)` near `p` lies in a tile whose colour is absent at `y_j`) and N7-TAC | route | **my § 3.2 claim withdrawn in part** (retraction 1 below); the kills stay one mind: I checked the `+++`, `b = a + 1` kill after reading (a checking reading) and found it sound |
| 2 | N7-HUB (b): the tip | region **I** `= B(σy,1) ∩ B(σ⁻¹y,1)` is non-absent by the ring's flip at `σ^{±1}y`; F0 makes it `p`'s own tile | an absent colour there would be within 1 of `R_{k−1}`, `R_k` and by CL be one of them, whose cones miss it | route | kept both; N7-HUB (b) now has a blind second derivation, the check the entry asked for |
| 3 | N7-HUB (c): the outward tile | F0 (close or far) from `p ∈ cl t_{c′}` | N3-FACE at the unit pair `(p, y_k)` | route | kept both |
| 4 | exactly six change points | derived (F5): tips are `p`'s own tiles of diameter `≤ 1`; `4(m + 1) < 6m` for `m ≥ 3` | held: N6-RING60 | route | kept both; F5 is a second route to N6-RING60's count, over non-Siamese |
| 5 | tactic centres are change points | F6: a non-change centre puts two tiles of one absent colour at one point, Siamese | N7-TAC over N3-FLANK and N6-CENT | route | kept both |
| 6 | the headline's hypotheses | the headline omits non-Siamese, simple, four colours at `p`, six colours and the bent ring, all used (§ 3.3) | N7's own statement of N7-3T (record § 2.2) carries them: "At a degree-4 four-colour vertex of a non-Siamese valid map in the simple class whose ring is (Q)-free after the bends …" | wording | the entry's headline should carry the record's setting; the record confirms the defect is the entry's wording, not the argument |
| 7 | `+++` in the list | not in the entry's enumeration | handled first in the record's proof; named in "the sign patterns are `+++`, `++−`, `+−+`, `−++`" | wording | the entry's list should name `+++` (Keryx logged it) |
| 8 | the model | § 3.3 called FS114-Y2-BOWTIE's caps (Q) arcs | the entry's model: "FS114-Y2-BOWTIE's centre, … whose ring carries no (Q) arc" | wording | **my § 3.3 remark withdrawn** (retraction 2): I inferred it from a definitions passage about a bowtie's caps; the bowtie whose lenses do not border its caps has (Q)-free caps, and Y2-BOWTIE is the entry's model of the excepted family |

**Retractions (found by reading, so what they now say was given):**
1. § 3.2's sentences "passes them all" for `+++` and for the `γ = 0°` lens, and "the colour-level frame kills none of these". My frame check
   applied F4's facing condition but not its own consequence that a tip at `y_k` meets `B(y_{k±1}, 1)` while a tactic edge's outer tile misses the
   open unit disc about its centre (F6). With it, my own frame kills the `γ = 0°` lens (its outer tiles miss `B(y_m, 1)`, which holds region **I** at
   `y_{m±1}`, and no other tile faces `y_{m−1}`: no tip there) and forces `+++`, `b = a + 1`, to `θ_4 = D_{a+4}`, where the first derivation's branch
   rule finishes it. The claim for OC stands; for the `(1, 2, 1, 2)` pinwheel another tip assignment meets my conditions, and its kill is N6-NOQ's.
   **The verdict does not change:** the per-pattern kills were not derived blind here.
2. § 3.3's model bullet: "FS114-Y2-BOWTIE (held, row 138; a bowtie whose caps are (Q) arcs, so outside the (Q)-free class)". Withdrawn; see row 8.

Two retractions, both on N7-3T, both on side remarks, none on a verdict. **A question for the coordinator (not resolved here):** the definitions
file quotes `plans/FS114-N6-proof.md` l. 253, "Its caps are (Q) arcs (inner `t1`, outer the colour-3 cap tile)", about a bowtie; the N7-3T entry's
model says Y2-BOWTIE's ring carries no (Q) arc. If both passages describe Y2-BOWTIE, one of them is wrong; if the first is about a bowtie whose lenses
border its caps, they agree. I did not read either source past what was given.

### 4.4 The count (the procedure's four parts)

1. **Information.** Blind to every first derivation until its verdict was committed (`3daaa05c`, `894db2d9`), by the record's § 1.3, § 3.0 and the
   commit order. Given before deriving: the held pinch lemma's proof (SATPIN), the definitions file with the D-frame's shape and N7's setting (N7-3T).
2. **Prior and method.** The same model (Opus 5.5) as every first derivation: one prior on every statement. Methods: YESLIM differs at two steps;
   SATPIN shares the pinch lemma's case split; N7-HUB's routes differ (the flip at `σ^{±1}y` against CL and the ring cones).
3. **The criterion, fixed first.** Statements quoted verbatim (§ 1.2, checked by `tools/fs116_v1_quotes.py`); predictions at § 1.5 before any written
   derivation, informed for YESLIM and SATPIN.
4. **The attack.** §§ 2.2, 2.4, 3.3; it succeeded at SATPIN's two words (a monster and a wording) and at N7-3T's headline (a wording defect the record
   confirms), and found thin truths in YESLIM and SATPIN.

**What no verification here supplies:** whether each statement is the one the milestone needs (a reader of intent).

## Theorems this phase proved (stage 4)

None new; N7-HUB (b), (c) now stand at two minds (blind, the same model) with the first derivation.
