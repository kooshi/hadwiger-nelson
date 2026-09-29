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
