# FS110-Y — the construction side of FS-110 (the tangency seam)

*Job FS110-Y (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/Y110-construction.md` with `data/fs110/briefs/STANDING-RULES.md`.
Claim list: `data/fs110/claims.md` (quoted, never paraphrased). Blind to the proof side (FS110-N) until hand-back. Working files:
`data/fs110/fs110-y/`; tools `tools/fs110_y_*.py`.*

## Theorems this phase proved

*(one line each; grade; address)*
- **Y-AEX** — A-EXACT TRUE with "meets a tile" read as "meets the interior of a tile" (false for the closure reading exactly at cusps and
  transversal passes through `u`); its consequence, disjointness of `B_u(s)`, `B_v(s)` for a covering pair, TRUE — [hand, one mind here; two with
  FS110-A's], §1.3.
- **Y-CIRC** — A-CIRC TRUE for every colour of `P_cl(u)`, cusp colours included (the argument needs only interior points of the tile accumulating
  at `u`, never an angle) — [hand, one mind here; two with FS110-A's], §1.3.
- **Y-SIX** — A-SIX TRUE: C-T-TAN's proof uses the type sizes only through "all six classes are in `P(u) ∪ P(v)`"; the sizes enter only its
  failure-set analysis, which I redo for sizes 2 and 4 — [read + hand, one mind here; two with FS110-A's], §1.3.
- **Y-TYPE** — D-TYPE TRUE for `𝓜_K` maps (and any locally finite map whose boundary arcs have one-sided tangents at `u`): `P_cl(u) ∖ P_ess(u)` is
  exactly the set of colours all of whose corners at `u` have angle 0 — [hand, one mind, trivial], §1.3.
- **Y-BLOCK** — the blocking set `B_u(s) ∩ B(w₀, c)` of a trivalent or bowtie `𝓜_K` vertex has exactly five shapes (slab, one-sided band of depth
  `≍ |1 − κ|s²/2` or `≍ s·|τ·e_u|`, thin double wedge of angle `≍ s` about the tangent line of `ω(u)` at `w₀`, empty); hence C-TAN-POS TRUE at the
  level of A-EXACT's disjointness test — [hand, one mind], §1.4.

## Fence log (standing rule 13)

- **Touch 1 (09:25 UTC, disclosed):** my first command, `ls -la` on `data/fs110/` and its subdirectories, listed the **file names** in
  `data/fs110/reports/` (`FS110-A.md`, `FS110-P.md`) and `data/fs110/briefs/` (the other briefs' names). No file there was opened or read; no
  content seen. The listing of `data/fs110/` also showed the directory name `fs110-a` (not listed inside).
- Nothing else fenced opened, listed or grepped. `git log` read only at start-up (`git log --oneline -3`).

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Stage 1 — SAVED: quotation check; the local calculus of §1b

### 1.1 Files read from disk (this order)

`data/fs110/briefs/Y110-construction.md`, `data/fs110/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim (l. 74–113), § Counter-priors (l. 115–137),
G82 (l. 1591); G79, G71, G21, G15, G13, G46 from the loaded copy (G79 checked on disk, l. 1582); `LEDGER.md` rows 131–133; `data/fs110/claims.md` in
full; `plans/FS110-tangency-seam.md` §G part 3, §PA, §IQ (l. 328–414); `plans/STUB-tangency-seam.md`; `plans/FS107-derivation.md` in full;
`plans/FS106-TS-derivation.md` l. 11–37, §2.2–2.6 (l. 114–224), l. 246–279; `plans/FS107-V-verification.md` §4.3; `plans/FS107-VW-verification.md`
§2b.4, stage 4; `plans/FS107-W-near-colourings.md` §2.1–2.6, §4.2–4.4; `plans/FS107-R-stability.md` §3.2–3.6; `plans/FS106-V-verification.md`
l. 360–378; `[SokolovVoronov2025]` (held PDF, text extracted to my scratch) l. 140–160 (Conditions 5–8), Prop. 5, Lemma 3, Question 2.
Not yet read: Townsend's manuscript, Woodall §3, Coulson, Voronov Prop. 2.2 and Lemma 6.1 (for the bicycle stage, if reached).

### 1.2 Quotation check (standing rule 5)

| quotation (in the brief or the claim list) | source | result |
|---|---|---|
| Kooshi: "My goal is to fully solve, and then verify in Lean, HN. Then we publish." / "Let's see some ambition. I know we can do it." | `CLAUDE.md` l. 76, l. 120 | match |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | match |
| Q-full, "Does a full tight a.e.-proper six-colouring …" | `plans/STUB-tangency-seam.md` § The question | match |
| S–V Question 2; Conditions 5, 6 | held PDF, text l. 148–153, l. 1016–1018 | match (line breaks only) |
| `𝓜_K` definition | `plans/FS107-derivation.md` header | match |
| C-T-TAN, "Let `k = 6` … does not occur." | `plans/FS106-TS-derivation.md` l. 258 | match |
| TS-U | `plans/FS106-TS-derivation.md` l. 15–16 | match |
| C-T-BIKE; K-KILL's second half | TS l. 257, l. 275 | match |
| V-C5 and its killing test | `plans/FS107-derivation.md` §1; `plans/FS107-V-verification.md` §4.3 | match |
| W-TAN; R-CP; RR; W-EQ-K; W-POLY; W-RATE; R-SW; R-OB2; HX-STALL; K-C6; K-BICH | `plans/FS107-derivation.md` | match |
| VW §2b.4 ("But a bichromatic vertex …"); VW §4 item 4 (cusp) | `plans/FS107-VW-verification.md` | match |
| R §3.6 ("pure `π/3`-arc ansatz fails narrowly there"; "general tight 2-colourings …"); R §3.4 (A″) | `plans/FS107-R-stability.md` | match |
| W §2.5 (Act One) | `plans/FS107-W-near-colourings.md` l. 219–222 | match |
| Townsend ⅔π ("So the counterexample is right, and **sharp at `2π/3`**…") | `plans/FS106-V-verification.md` l. 373–374 | match |
| A-EXACT, A-CIRC, A-SIX, C-TAN-POS, C-BOW-K, `P_ess`/`P_cl`, the §1.7 hunch | the advisor's record and messages | **not checkable: fenced** (logged, not a failure) |
| "Siamese and outer" (`plans/FS107-stability.md` l. 348) | not opened | unchecked (not needed at stage 1) |

### 1.3 The local calculus — verdicts

Setting throughout: a full tight a.e.-proper six-colouring by a locally finite map (tiles closures of open sets with connected interiors,
boundaries finitely many arcs with one-sided tangents at the vertices, null); `ω(z)` the unit circle about `z`.

**A-EXACT — TRUE with one reading fixed; the consequence TRUE.** [hand; one mind here; two with FS110-A's]
- *First clause.* If `z ∈ int τ`, `z′ ∈ int τ′`, one colour, `|z − z′| = 1`: discs `B(z, r) ⊂ τ`, `B(z′, r) ⊂ τ′`; for each `p ∈ B(z, r/2)`,
  `ω(p) ∩ B(z′, r)` is an arc of length `≳ r`, so the monochromatic unit pairs have positive `Leb ⊗ σ` measure. Contradiction. (W-EQ-K's step 4.)
- *The set `B_u(s)`.* "`ω(z)` meets a tile of every colour of `P_cl(u)` inside `B(u, s)`" must be read **"meets the interior of such a tile"**. Then
  `B_u(s)` is a finite intersection of sets `{z : ω(z) ∩ U ≠ ∅}` with `U` open, hence open; a tile-interior point of `B_u(s)` of a colour `j ∈
  P_cl(u)` has an interior point of a colour-`j` tile at distance 1 — excluded by the first clause. Since boundaries are nowhere dense, `B_u(s)` is
  coloured outside `P_cl(u)` off the null boundary set.
- *The closure reading is false exactly where it matters:* a point `z` with `|z − u| = 1` has `ω(z)` through `u`, so meeting the closure of every
  tile at `u`; with a cusp colour `j` at `u` whose horn is transversal to `ω(z)`, `ω(z)` meets no interior point of the horn near `u`, and `z` may
  carry colour `j`. So the interior reading is the statement.
- *Consequence.* For a covering pair (`P_cl(u) ∩ P_cl(v) = ∅`, union all six), an interior point of `B_u(s) ∩ B_v(s)` would carry a colour outside
  all six. So `B_u(s) ∩ B_v(s) = ∅` for every `s`. TRUE.

**A-CIRC — TRUE, cusp colours included.** [hand; one mind here; two with FS110-A's] Let `x ∈ ω(u)` be interior to a tile `τ` of colour `c`, and
`σ` a tile of colour `c` with `u ∈ cl σ`. Let `D` be a disc about `x` in `int τ` and `Σ` a component of `int σ ∩ B(u, r)` whose closure contains `u`
(for a cusp tile: the horn). `D × Σ` is connected; `f(p, q) = |p − q|` is continuous on it. With `e = x − u`: `f(x + δe, q) → 1 + δ` and
`f(x − δe, q) → 1 − δ` as `q → u` in `Σ`. So `f` takes 1 on `D × Σ`: an interior monochromatic unit pair. Contradiction. **No angle of `Σ` is
used, only interior points of `σ` accumulating at `u`**; a zero-angle tile has them. So every tile-interior point of `ω(u)` has a colour outside
`P_cl(u)`.

**A-SIX — TRUE.** [read + hand; one mind here; two with FS110-A's] In TS l. 258's proof the sizes appear nowhere: `T_u`, `T_v` are defined for any
types; `Π` needs only `e_u ∦ e_v`; "some class `j` fills at least `|Π|/6`" holds for any six classes; "say `j ∈ P(u)`" needs exactly `j ∈ P(u) ∪
P(v)` for every `j`. So the non-occurrence holds for every covering pair. **The failure set does depend on the sizes** (TS's analysis is for three
sectors); redone for cone blow-ups of any size: `T_u` is null iff two classes of `P(u)` lie in opposite closed half-planes of `e_u^⊥`. For
`|P(u)| = 2` with degree `≥ 4` (`a, b, a, b`): null only if every `a`-sector lies on one closed side of `e_u^⊥` and every `b`-sector on the other —
impossible when the sectors alternate around `u` with positive angles (an `a`-sector lies between two `b`-sectors on each side), so **a bichromatic
vertex of degree `≥ 4` blocks every direction at the blow-up level**. For `|P(u)| = 4` (sectors `a, b, c, d` in order): `a` and `c` are
separated by every line through `u` whose two rays lie in `b` and `d` — an **open** set of directions whenever `b` and `d` contain opposite rays:
the four-colour vertex escapes on an open set, like a bowtie (the advisor's "A four-colour vertex in a bowtie direction is an escape the stub does
not list" — derived here).

**D-TYPE — TRUE for `𝓜_K` maps.** [hand, one mind, trivial] Near `u` each tile `σ` with `u ∈ cl σ` is a finite union of corners, each between two
arcs from `u` with one-sided tangents `θ₁, θ₂`. A corner of angle `> 0` contains a truncated cone: positive density. A corner of angle 0 lies
between two arcs with one tangent, `|f₁ − f₂| = o(x)`, area `o(r²)` in `B(u, r)` (`O(r³)` for circular arcs): density 0. So `P_cl(u) ∖ P_ess(u)` is
exactly the set of colours **all** of whose corners at `u` are cusps (a colour with one cusp corner and one fat corner, two Siamese tiles touching
at `u`, is essential). "They differ exactly at cusps": TRUE in this form.

### 1.4 C-TAN-POS — the blocking sets at `w₀`, derived (Y-BLOCK)

Coordinates: `u = 0`, `e_u = (0, 1)`, `w₀ = e_u`, `z = w₀ + ζ`. Near `u`, `ω(z) = ω(w₀) + ζ`, i.e. `y = ζ_y + (x − ζ_x)²/2 + O(|x|³)`; `ω(w₀)` is
`y = x²/2`. Let `u` be a vertex of `𝓜_K` with closure type `{1, 2, 3}`, scale `s` (tiles within `O(Ks²)` of their cones in `B(u, s)`). The set
`B_u(s) ∩ B(w₀, c)`, `c ≪ s`, has one of five shapes:

| `u` at `w₀` | `B_u(s)` near `w₀` | why |
|---|---|---|
| **fat** (all three sectors meet both open half-planes of `e_u^⊥`) | contains the whole ball `B(w₀, c s·margin)` (a slab `\|ζ·e_u\| < c s`) | a near-line at offset `\|h\| ≪ s` crosses all three sectors |
| **T1, κ ≠ 1** (the `1\|2` interface tangent at `u`, curvature `κ` against `ω(w₀)`'s 1) | a **one-sided band** `ζ·e_u ∈ (−\|1 − κ\|s²/2, 0)` (side by the sign of `1 − κ`) | V-C5's mechanism: the shifted circle dips across the interface and recrosses within `B(u, s)` |
| **cusp** (colour 3 a horn of tangent `τ`) | a one-sided band of depth `≍ s\|τ·e_u\|`, or `≍ \|κ₁ − κ₂\|s²/2` when `τ ⊥ e_u` | `ω(z)` meets the horn only on one side of the slab (VW §4 item 4) |
| **T2** (the `1\|2` interface **is** an arc of `ω(w₀)`, either side) | a **thin double wedge** about the line `w₀ + ℝe_u^⊥`, half-angle `≍ s` (the arc's angular width seen from `w₀`), vertex `w₀` excluded | `ω(z)` crosses `ω(w₀)` near `u` only when `ζ` is within angle `≍ s` of `e_u^⊥`; this set is `(arc ⊕ S¹)` near `w₀` |
| **strong escape** (bowtie `4,5,4,6`, or a four-colour vertex, whose repeated or extra colour holds two sectors straddling every line of tilt `< µ` from `e_u^⊥`) | **empty** in `B(w₀, c)` | every near-line through the straddling sectors misses one of the other two colours (C-BOW-K (i): TRUE here, one mind) |

**Pairs** (A-EXACT: `B_u ∩ B_v = ∅`; `e_u, e_v` at angle `ψ = 2 arcsin(d/2)`, `d = |u − v| ∈ (0, 2)`):
- fat vs anything non-empty near `w₀`: fails (the ball meets it).
- one-sided band vs one-sided band: the quadrant `{σζ·e_u ∈ (−a, 0), σ′ζ·e_v ∈ (−b, 0)}` is a non-empty open cone at `w₀`: fails.
- band vs thin wedge: the wedge's line `e_v^⊥` is transversal to `e_u^⊥` (`ψ ≠ 0`), so it enters the band at distance `< a/sin ψ`, on the side the
  band lies (the wedge is two-sided): fails, **for every positive band depth** (so near-T2, `κ = 1 ± η`, fails too).
- thin wedge vs thin wedge: disjoint in `B(w₀, c)` when both half-angles are `< ψ/2`: **survives**.
- empty vs anything: survives.

**Verdict: C-TAN-POS TRUE** at the level of A-EXACT's disjointness test, for pairs of trivalent, bowtie, four-colour and cusp vertices of `𝓜_K`:
at `w₀` the pair survives only if one side is a strong escape or **both** are T2 (both `u` and `v` emit arcs of `ω(w₀)`). [hand, one mind; the
claim is the advisor's] Consequences for the seams: **C-TAN-K (T1 closed) TRUE at the pair level; C-CUSP-K TRUE at the pair level** (the advisor's
hunch "the cusp seam reduces to the tangent seam" holds, and the reduction goes further: to T2 or a strong escape). This is a necessary condition
only: T2–T2 and strong escapes **pass** it, so they are the construction side's live seams (C-T2, C-BOW-K). Grade note: `B_u` is computed from the
cone plus curvature at scale `s`; the error `O(Ks²)` is below every quantity used except the band depth `|1 − κ|s²/2` in the T1 row, where it is the
same order — so the T1 row needs `|1 − κ|` against `K`-dependent constants (a GAP only in constants, which the two-sided fail argument does not use:
any positive depth fails against a wedge, and for T1 vs T1 the quadrant is non-empty at every depth).

### 1.5 What every T2 realisation carries (X13, G79's flip)

A pair `(u, v)` saved at both unit points by T2 carries the **spindle's rhombus of vertices** `u w₀ v w₀′` (as the claim list says), and more:
- `u` emits two unit arcs, of `ω(w₀)` and of `ω(w₀′)`; so does `v`. Four unit arcs meet `{u, v}`.
- By TS-U at `w₀` for `u`'s arc (colours `a | b ⊂ P(u)`): the side cones at `w₀` — about the directions `±e_u^⊥`, **along `ω(u)`'s tangent at
  `w₀`** — hold neither `a` nor `b`; likewise for `v`'s arc along `ω(v)`'s tangent.
- By A-CIRC, interior points of `ω(u)` near `w₀` carry `P(v)`'s colours and interior points of `ω(v)` near `w₀` carry `P(u)`'s colours; `ω(u)`,
  `ω(v)` cross at `w₀` at angle `ψ`. So **`w₀` is a vertex whose closure type meets both `P(u)` and `P(v)`**, unless `ω(u)` (or `ω(v)`) runs along
  a boundary near `w₀` — a unit arc centred at `u` through `w₀`, the reciprocal arc.
- So T2 cascades: `w₀`, `w₀′` are vertices with mixed types at distance `√(4 − d²)` from each other, and their own close pairs must be seams.

## Stage 1 — SAVED
