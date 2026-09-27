# FS110-N — the proof side of FS-110 (the tangency seam): the NO

*Job FS110-N, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/N110-proof.md` with `STANDING-RULES.md`. Claim list:
`data/fs110/claims.md` (quoted, never paraphrased). Object throughout: LIM (a full tight a.e.-proper six-colouring by a map) unless marked.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N-E0 | A-EXACT, sight form: `S(z) ∌ colour(z)` for `z` in a tile, `{z : j ∈ S(z)}` open, so `S(z) ≠ [6]` for every `z ∈ ℝ²`; the consequence holds for every family of vertices whose closure types have union `[6]` (disjointness unused) | [hand, trivial; two minds with FS110-A] | stage 1, §1.4 |
| N-E1 | A-CIRC, closure form: `u ∈ cl(T)`, `T` of colour `j` ⟹ `ω(u) ∩ C_j° = ∅`; holds for a cusp colour | [hand, trivial; two minds, different route from FS110-A's] | §1.4 |
| N-E2 | contact lemma: two same-colour tiles touching `u`, `u′` with `\|u − u′\| = 1` are Siamese (`T ⊆ B̄(u′,1)`, `T′ ⊆ B̄(u,1)`) or outer (`T ∩ B(u′,1) = ∅ = T′ ∩ B(u,1)`) — exact, whole tiles | [hand, one mind] | §1.4 |
| N-SEAM | seam-point lemma: for `P_cl(u) ∪ P_cl(v) = [6]`, `\|u − v\| < 2`, each common unit point `w₀` lies on `Γ`; every tile at `w₀` lies on one side of `ω(x)` for each `x ∈ {u, v}` holding its colour; if `w₀` is not a vertex, the arc through it is an arc of `ω(x)` for one `x`, both side colours are `x`'s, and colours of `x`'s type other than those two fill both side cones (TS-U) — one colour in two sectors (a strong escape) when `\|P_cl(x)\| = 3`, possibly two colours when `\|P_cl(x)\| ≥ 4` (corrected stage 3) | [hand, one mind] | §1.4 |
| N-TYPE | D-TYPE: `P_ess(u)` = colours owning a sector of positive angle at `u`, `P_cl(u)` = colours owning a sector; they differ iff some colour's sectors at `u` are all cusps | [hand, one mind] | §1.4 |
| N-SIX | A-SIX: C-T-TAN's proof uses the types only through "all six classes are in `P(u) ∪ P(v)`" — sizes and disjointness unused | [read + hand; two minds with FS110-A] | §1.4 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| (none yet) | |

## Fence log (standing rule 13; brief § Fences)

1. **Fence touch, disclosed (names only, no contents).** My first command, run before I had read the brief, was `ls -la data/fs110/briefs/ data/fs110/`:
   it listed the file names of the other briefs in `data/fs110/briefs/` and the directory names `fs110-a/`, `reports/` in `data/fs110/`. No fenced file
   was opened, read or grepped.
2. `git log --oneline -8` at start-up showed three commit subjects older than the start-up snapshot's five (`ae8e100f`, `ac96521a`, `72b8a0de`:
   "FS110-A: stage 3", "FS110-P: stage 4b", "FS110-P: stage 4"). Older, subjects only; disclosed.

## Stage 1 — SAVED: quotation check, the local calculus (§1b)

### 1.1 Files read from disk (this order)

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim, § Counter-priors, G82, G13, G15 from disk (G21, G46, G71, G79 from the loaded copy, with
G79 checked on disk); `LEDGER.md` rows 131–133; `data/fs110/claims.md` in full; `plans/FS110-tangency-seam.md` §G part 3, §PA, §IQ;
`plans/STUB-tangency-seam.md`; `plans/FS107-derivation.md`; `plans/FS106-TS-derivation.md` §2.2 (TS-U) and stages 4–5 (C-T-TAN, C-T-BIKE, C-T-CHR4,
C-T-IND, C-T-KILL); `plans/FS107-V-verification.md` §4.3; `plans/FS107-VW-verification.md` §2b.4, stage 4; `plans/FS107-W-near-colourings.md` §2.5,
§4.2; `plans/FS107-R-stability.md` §3.2–3.6; `plans/FS106-V-verification.md` l. 355–380. Papers: S–V Question 2 located (`pdftotext`, l. 877 of the
text). **Reading status of the papers, honestly (G50):** S–V — Question 2 read; Conditions 5–7, Cor. 2, Props. 5, 10, 12, 17, Lemma 3 **not yet read
by me** (known through TS's and SB's records only); Townsend's manuscript, Woodall §3, Coulson, Voronov Prop. 2.2 / Lemma 6.1 — **not yet read by me**
(known through FS106-V's and TS's records). Nothing below rests on an unread section except where TS-U or C-T-TAN is cited, both at their recorded
grades.

### 1.2 Quotation check (standing rule 5)

| quotation in my brief | source | result |
|---|---|---|
| Kooshi: "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | matches (a prefix; the source continues "(Anything we do …") |
| Kooshi: "Let's see some ambition. I know we can do it." | § Counter-priors | matches (a prefix) |
| Q-full, "Does a full tight a.e.-proper six-colouring … exist?" | `plans/STUB-tangency-seam.md` § The question | verbatim |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| Q-rule as glossed in the brief ("every close covering pair … must be a tangent pair (T1 or T2), a bowtie or strong escape, or a cusp") | — | **not a quotation**; the brief's gloss. It widens A2 §5.1's "complementary-type vertex pairs" to "covering pairs"; noted, and §1.4 (N-E0) shows the widening is right and can go further (union `[6]`, overlap allowed) |
| hand-back line: brief "FS110-N idle; no content in this hand-back; my reports go to the owner by SendMessage"; the owner's launch message "FS110-N idle; report sent to the owner by SendMessage" | brief l. 93–99; the launch message | **the two differ**; both are content-free. I use the owner's (the later instruction). Budget: brief "about 260k" own count, launch message "about 250k"; I use 250k |

The claim list's quotations that I opened sources for: C-T-TAN (TS stage 4, verbatim), K-KILL second half (TS l. 275, verbatim), C-T-BIKE (verbatim),
FS107-V-C5 (the derivation file, verbatim), W-TAN (verbatim), the cusp definition (VW stage 4 item 4, verbatim), V5 (VW §2b.4, verbatim), R's (A″) and
§3.6 (verbatim), Townsend ⅔π (FS106-V, verbatim), C-ACT1 (W §2.5, verbatim), TS-U (TS l. 15, verbatim prefix), FS106-AE-Q2 [G2]/[G4] and FS106-IND-X
(`plans/FS106-derivation.md` l. 129, l. 172, verbatim), S–V Question 2 (held PDF, verbatim). **Not checkable by me (fenced source):** A-EXACT, A-CIRC,
A-SIX, the advisor's precise type forms, C-TAN-POS, C-TAN-K, C-BOW-K, the cusp hunch — all quoted from `plans/POROS-2026-09-27-fs110-tangency-seam.md`
or FS110-A's messages. I work them as the claim list states them.

### 1.3 Setting and notation (mine; stated before first use)

- **The map.** `Γ ⊂ ℝ²` a locally finite union of arcs, C¹ with one-sided tangents at their endpoints (in `𝓜_K`: circular or straight, radius
  `≥ 1/K`); `Γ` is null. **Tiles** are the components of `ℝ² ∖ Γ`: open, connected, each of one colour. `C_j°` is the union of the colour-`j` tiles.
  **Full tight a.e.-proper**: every tile coloured, and the same-colour unit pairs form a `Leb ⊗ σ`-null set.
- `P_cl(x)`: colours of the tiles whose closure contains `x`; `P_ess(x)`: colours of positive upper density at `x` (the claim list's §0).
- **Sight** of a point `z`: `S(z) = {j : ω(z) ∩ C_j° ≠ ∅}` (`ω(z)` the unit circle about `z`). This is the map form of FS107-R-SAT's "six-sighted set"
  and of G13's coverage: a kill is a point `z` with `S(z) = [6]`, and the escaping colour at `z` is a colour outside `S(z)`.
- **Sectors.** Near any point `x`, a small disc minus `Γ` is a finite union of curvilinear sectors bounded by consecutive arcs leaving `x`; each lies in
  one tile. A sector of angle 0 (two arcs leaving `x` with one tangent) is a **cusp horn**.
- A **covering pair**: two points `u, v` with `P_cl(u) ∪ P_cl(v) = [6]` — **I do not require disjointness** (the claim list's §0 does; §1.4 shows no
  statement used below needs it). A **covering family**: finitely many points whose closure types have union `[6]`.

### 1.4 The local calculus: A-EXACT, A-CIRC, A-SIX, C-TAN-POS, D-TYPE

**N-E0 (A-EXACT). TRUE [hand, trivial; two minds: FS110-A, this job].** If `x ∈ T`, `x′ ∈ T′`, tiles of one colour, then `|x − x′| ≠ 1`: otherwise
`B(x, δ) ⊂ T`, `B(x′, δ) ⊂ T′`, and the pairs `(y, θ)` with `y ∈ B(x, δ/2)`, `y + e_θ ∈ B(x′, δ)` have positive `Leb ⊗ σ` measure. Hence
`B_u(s)` (the claim list's set) is open (a finite intersection over `j ∈ P_cl(u)` of unions over `j`-tiles `T` of the open conditions "`ω(z)` meets the
open set `T ∩ B(u, s)`") and its points in tiles are coloured outside `P_cl(u)`. **Consequence, as stated: TRUE, and stronger than stated.** For any
covering pair — `P_cl(u) ∪ P_cl(v) = [6]`, overlap allowed — `B_u(s) ∩ B_v(s)` is open and meets no tile, so it is empty (`Γ` is null); likewise
`⋂_i B_{u_i}(s) = ∅` for a covering family. **The sight form** (what every kill below uses): for `z` in a colour-`j` tile, `j ∉ S(z)`; each
`{z : j ∈ S(z)}` is open (a circle meeting an open set keeps meeting it under small moves); so a point `z` on `Γ` with `S(z) = [6]` would have a tile
point nearby with `S = [6]`. **So `S(z) ≠ [6]` for every `z ∈ ℝ²`**: every unit circle misses some colour's open set entirely. *Where six is spent:*
`|S(z)| ≤ 5` is the six-colour statement; with seven colours a circle may meet six classes, and the step is silent. *Control:* in the tight hexagonal
seven-colouring, circles meeting six colours exist (a circle about a tile point meets the six other colours); no contradiction arises, as required.

**N-E1 (A-CIRC). TRUE, in the closure form and at a cusp colour [hand, trivial; two minds, different routes: FS110-A's distance-map sketch; this
job's].** *Statement:* if `u ∈ cl(T)` for a tile `T` of colour `j`, then `ω(u) ∩ C_j° = ∅`. *Proof:* let `x ∈ ω(u)` lie in a colour-`j` tile `T′`,
`B(x, δ) ⊂ T′`; take `y ∈ T` with `|y − u| < δ/2`; the point `y + (x − y)/|x − y|` of `ω(y)` is within `δ/2` of `x`, so in `T′`, at distance 1 from
`y ∈ T` — against N-E0. ∎ The proof reads only `u ∈ cl(T)`, never an angle or a density, so it holds verbatim when `T`'s sector at `u` is a cusp horn:
**the cusp check passes**. In particular `S(u) ∩ P_cl(u) = ∅` for every point `u`: a vertex's own unit circle sees only colours outside its closure type.
(The claim list's "every tile-interior point of `ω(u)` has a colour outside `P_cl(u)`" is the same statement.)

**N-E2 (contact lemma). [hand, one mind.]** Let `T, T′` be tiles of one colour, `u ∈ cl(T)`, `u′ ∈ cl(T′)`, `|u − u′| = 1`. Then either **(Siamese)**
`T ⊆ B̄(u′, 1)` and `T′ ⊆ B̄(u, 1)`, or **(outer)** `T ∩ B(u′, 1) = ∅` and `T′ ∩ B(u, 1) = ∅`. *Proof:* the distances `|x − x′|`, `(x, x′) ∈ T × T′`,
fill an interval (connected domain), open where `x ≠ x′`; it avoids 1 (N-E0) and has 1 in its closure (points near `u`, `u′`); so all cross distances
are `< 1` or all `> 1`. Passing to the closures (`u′ ∈ cl T′`) gives the inclusions. `T = T′` is the Siamese case (then `diam T ≤ 1`, TS-C). ∎ It is
exact — whole tiles, not blow-ups — and it is symmetric in the two points.

**N-SEAM (the seam-point lemma). [hand, one mind; new — not found in the records read.]** *Let `P_cl(u) ∪ P_cl(v) = [6]`, `|u − v| < 2`, and let
`w₀` satisfy `|w₀ − u| = |w₀ − v| = 1`. Then:*
- *(a) `w₀ ∈ Γ`: `w₀` is in no tile.*
- *(b) every tile `T` with `w₀ ∈ cl(T)` has its colour in `P_cl(x)` for some `x ∈ {u, v}`, and for each such `x`, `T ⊆ B̄(x, 1)` or `T ∩ B(x, 1) = ∅`.*
- *(c) if `w₀` is not a vertex (it is interior to one arc `A` of `Γ`), then both tiles at `w₀` have colours in `P_cl(x)` for one `x ∈ {u, v}`, lie on
  opposite sides of `ω(x)`, and `A` coincides with `ω(x)` near `w₀`: **a unit-arc seam centred at `x`**.*
- *(d) in case (c), by TS-U at `x` (row 132: two minds, one blind), neither side colour of `A` lies in `x`'s two side cones (open cones of angle equal to
  `A`'s angular length seen from `x`, about the two directions tangent to `ω(w₀)` at `x`); so colours of `x`'s type other than the two side colours fill
  **both** side cones. When `|P_cl(x)| = 3` that is one colour in two sectors straddling the tangent line at `x` with margin — the claim list's **strong
  escape**; when `|P_cl(x)| ≥ 4` the two side cones may hold two different colours (corrected at stage 3, after A2's card 1, point 2: a retraction).*

*Proof.* (a) If `w₀` lay in a tile of colour `k`, then `k ∈ P_cl(x)` for some `x ∈ {u, v}` (six is spent here: the pair covers the palette), and
`w₀ ∈ ω(x) ∩ C_k°`, against N-E1 at `x`. (b) N-E2 with `u′ = w₀`. (c) Let `T₁, T₂` be the tiles on the two sides of `A` at `w₀`. If `T₁`'s colour is `u`'s
and `T₂`'s is `v`'s only, (b) puts `T₁` on one side of `ω(u)` and `T₂` on one side of `ω(v)`; since `T₁ ∪ T₂ ∪ A` is a neighbourhood of `w₀`, `A` would be
tangent at `w₀` to both `ω(u)` and `ω(v)`, which cross transversally there (`|u − v| < 2`, so `e_u = w₀ − u`, `e_v = w₀ − v` are not parallel).
So both colours are some `x`'s. Both tiles cannot lie on one side of `ω(x)` (a punctured neighbourhood of `w₀ ∈ ω(x)` meets both sides), so one lies in
`B̄(x, 1)` and the other outside `B(x, 1)`: their common boundary near `w₀` is `ω(x)`. (d) TS-U's statement, with its colours `c | c′` the two side
colours. ∎

*Where six is spent:* in (a), "every colour at `w₀` is at `u` or `v`". *Seven-colour control:* with seven colours two triples cover six, and `w₀` may lie
inside a tile of the seventh colour — (a) fails, as it must (tight hexagonal seven-colouring: the pair's union misses one colour). *Townsend's ⅔π
sector* is TS-U's own control (TS §2.2, K2); (c)–(d) are TS-U at a covering pair, so they inherit it. *The case (c)–(d) is the geometry of TS-C5*
("configuration C5 with a colour in the side cones at y", FS106-IND-X): the covering pair lands exactly on the configuration where S–V's Prop. 5
fails and where the index swaps.

**What N-SEAM changes (for the plan and the other claims).** C-T-TAN, read on a map, is a statement about the **seam point** `w₀`, not about `u` and `v`:
a covering pair survives at `w₀` exactly when every tile at `w₀` is Siamese or outer with every tile of its colour at `u` or `v` (N-E2); the kill is
a point `z` near `w₀` with `S(z) = [6]`, and the escaping colour is always the colour of `z`'s own tile (G13's coverage failure at `w₀`, X1). Blocking
at `u` and at `v` (C-T-TAN's `T_u`, `T_v`) is the first-order shadow of these contacts; N-SEAM is exact, needs no blow-up and no scale, and has no
exceptional set of its own.

**N-TYPE (D-TYPE). TRUE [hand, one mind].** For a map whose arcs have one-sided tangents at `x`: a sector of positive angle `α` has density `α/2π` at `x`
(its blow-up is the cone); a cusp horn has density 0 (width `o(r)` at radius `r`; in `𝓜_K`, `≍ |κ₁ − κ₂| r²` with `κ₁ ≠ κ₂`, since two circular or
straight arcs leaving `x` with one tangent and one curvature coincide). So `P_ess(x)` = colours owning a sector of positive angle, `P_cl(x)` = colours
owning a sector, and **`P_cl(x) ∖ P_ess(x)` is the set of colours all of whose sectors at `x` are cusp horns**: the types differ only at vertices with a
cusp, and there exactly when some colour's sectors there are all cusps (a cusp whose colour also owns a positive sector at `x` changes nothing). The
advisor's form ("`P_ess ⊆ P_cl`, with equality except at zero-angle tiles") is TRUE with that precision.

**N-SIX (A-SIX). TRUE, and more [read + hand; two minds: FS110-A, this job].** In C-T-TAN's proof (TS stage 4, read), the types enter at exactly two
places: the definition of `T_u` ("for every `j ∈ P(u)`") and "Some class `j` fills at least `|Π|/6` of `w₀ + r_nΠ` (all six classes are in `P(u) ∪
P(v)`); say `j ∈ P(u)`." Neither uses `|P(u)| = 3` nor `P(u) ∩ P(v) = ∅`. So C-T-TAN holds for disjoint types of sizes (2, 4), and for overlapping
covering pairs as well. (N-SEAM makes the same point exactly: its (a) uses only the union.)

**C-TAN-POS: "at positive scale a complementary pair survives at w₀ only by a strong escape on one side or a double unit-arc seam". Verdict: split.**
- **Case `w₀` not a vertex: TRUE, sharper and exact [hand, one mind; N-SEAM (c)–(d)].** The pair survives only if `w₀` lies on a unit arc of `Γ`
  centred at `u` or `v`, and that centre's other colours fill both side cones — a strong escape when the centre's type has three colours, possibly two
  distinct colours when it has four or more (corrected at stage 3). The escape comes **with** a unit arc at `w₀`; no scale enters. *Scope:* any closure
  types at `u`, `v` with union `[6]` (overlap allowed), `|u − v| < 2`, `w₀` a non-vertex; it rests on N-E1 and N-E2 (necessary conditions), and on TS-U
  for the side cones.
- **Case `w₀` a vertex: GAP**, at the step "the tiles at `w₀`, each on one side of `ω(u)` or `ω(v)` (N-SEAM (b)), force a double unit-arc seam". What is
  held: at `w₀`, each of the four unit directions (the tangents of `ω(u)` and `ω(v)`) is either an arc of `Γ` along that unit circle or interior to a
  tile carrying a colour of the other point only. Not yet derived: which such vertex figures are consistent with the matching contacts at `u` and `v`.
- "at positive scale" is not needed: N-SEAM is a statement on LIM with no blow-up.

**D-TYPE: TRUE (N-TYPE). A-EXACT: TRUE (N-E0). A-CIRC: TRUE, cusp check passed (N-E1). A-SIX: TRUE (N-SIX).**

## Stage 1 — SAVED

## Stage 2 — SAVED: C-CUSP-K, C-SEAMLIST, and the vertex case of the seam point

*All statements on LIM, exact, for one map: no blow-up and no uniform scale enters, so X14's `s(K)` does not bite here and none of this is FS-111's
(failure clause 5). The scale enters only when a statement is carried to SEQ, which this stage does not do.*

### 2.1 N-HORN: a cusp horn is seen like a ray [hand, one mind]

*Setting:* `u` a vertex, `w₀` a unit point of `u`, `e = w₀ − u`. A cusp horn of colour `c` at `u` leaves `u` in direction `ψ` between two arcs with
curvatures `κ₁ < κ₂` (measured toward `+e`; `κ₁ ≠ κ₂` in `𝓜_K`, N-TYPE). For `z` near `w₀` write `t = |z − u| − 1`; near `u`, `ω(z)` is the circle of
curvature 1 bending toward `z` at distance `|t|` from `u` (R §3.2, Claim 1's ray–circle quadratic, exactly).
- **(i) transversal horn** (`e_ψ · e ≠ 0`): every `ω(z)` with `sign t = sign(e_ψ · e)`, `|t|` small, crosses the direction `ψ` transversally at radius
  `ρ ≍ |t|` (Claim 1's formula), where the horn has width `≍ (κ₂ − κ₁)ρ² > 0`; it enters the horn. So in R's blocking condition a horn counts as a
  zero-length arc `I_c = {ψ}`, and Claim 1 (hence R-CP's Claim 2 and C-T-TAN's cone kill, in the sight form N-E0) holds with closure types.
- **(ii) tangent horn** (`ψ ⊥ e`): in the frame `x = ` tangential coordinate, the horn is `κ₁x²/2 < y < κ₂x²/2` (`x > 0`, to second order) and
  `ω(z)` is `y = t + x²/2` (tilt `α` adds `αx`). A `t > 0` circle enters the horn iff `κ₂ > 1` (at `x ≍ √(t/(κ₂ − 1))`, with tilt tolerance
  `≍ (κ₂ − 1)·(horn length)`); a `t < 0` circle enters it iff `κ₁ < 1`. **Missed from both sides iff `κ₂ ≤ 1 ≤ κ₁`, which `κ₁ < κ₂` forbids.**
- *Where six is not spent:* nowhere — N-HORN is geometry of one circle and one horn.

### 2.2 C-CUSP-K: "in `𝓜_K`, no close pair of complementary closure types is saved by a cusp." **TRUE [hand, one mind].**

Two routes, each sufficient:
1. **Exact route (N-SEAM).** N-SEAM is stated with closure types and reads no angle or density: its conditions at `w₀` — `w₀ ∈ Γ`, each tile at `w₀`
   on one side of `ω(u)` or `ω(v)`, and (at a non-vertex `w₀`) a unit arc with a strong escape at its centre — hold whether or not `u` or `v` carries a
   cusp. A cusp at `u` or `v` enters only as one more tile whose contact with the tiles at `w₀` must hold (N-E2). So there is **no cusp exception** in the
   exact survival conditions: a pair survives with a cusp only where it would survive by the same conditions without it.
2. **Blocking route (C-T-TAN's own frame).** By N-HORN (i), a transversal horn blocks on its side exactly as a sector does; by N-HORN (ii), a tangent
   horn is met from at least one side. So a cusp colour never escapes both sides of `w₀`, and a pair saved at `w₀` is saved by its other colours
   (tangent interfaces or bowties). **The advisor's hunch** ("with closure types, a cusp vertex's blocking set near `w₀` is nonempty, so the cusp seam
   reduces to the tangent seam") **is TRUE**, with "tangent" read as "tangent or bowtie"; its falsifier ("a cusp vertex with a blocking partner whose
   blocking set near `w₀` is empty") is excluded by N-HORN (ii).

*What this does to W-TAN's GAP at cusps* (VW stage 4 item 4): closed on the proof side — W-TAN's first clause, read with closure types and covering pairs,
holds at cusp vertices; the escape VW named ("the cusp colour escapes C-T-TAN's pigeonhole at `w₀`") is an escape of the **density** argument only.
The sight argument (N-E0) sees a horn, because a horn is an open set and a circle crossing it transversally meets it.

### 2.3 C-SEAMLIST: **MISSTATED; corrected statement proved complete (not item by item) [hand, one mind].**

*As stated* ("the ways C-T-TAN's hypothesis can fail … are exactly: a tangent interface (T1 or T2), a bowtie or strong escape, a cusp, a sliver, a type
with fewer than three essential colours or with four (V5), and `d = 2`") it lists the failures of C-T-TAN's **density hypotheses**, several of which are
not failures of the map's survival: cusps (§2.2), types of two or four essential colours (N-SIX: C-T-TAN and N-SEAM need only the union), and slivers
(N-SEAM needs no margin, so a sliver is not an escape of its own). **Corrected statement (the necessary list, at the seam point; "only if", not "iff").** Let `u, v` be a covering
pair (closure types, union `[6]`, any sizes, overlap allowed) in a map of `𝓜_K`, `|u − v| < 2`. The pair survives at a common unit point `w₀` only if
`w₀ ∈ Γ` and one of:
- **(S1) `w₀` is not a vertex:** the arc through `w₀` is an arc of `ω(x)` for one `x ∈ {u, v}`, both its side colours are `x`'s, and `x`'s other
  colours fill both side cones (one colour in two sectors when `|P_cl(x)| = 3`; possibly two colours when `≥ 4`) — a unit-arc seam with an escape at
  its centre (N-SEAM (c)–(d));
- **(S2) `w₀` is a vertex:** each tile at `w₀` lies on one side of `ω(x)` for every `x ∈ {u, v}` holding its colour (N-SEAM (b)); in particular each of
  the four unit directions at `w₀` (the tangents of `ω(u)` and `ω(v)`) is either the start of an arc of `Γ` or lies in the interior of a tile whose
  colour belongs only to the other point.
And `|u − v| = 2` (the collinear configuration, `e_u ∥ e_v`) is separate. *Completeness* is by proof: (S1)/(S2) is the dichotomy "vertex or not" at
`w₀`, and N-SEAM (a) excludes `w₀` in a tile. No item is added by enumeration (G21: the list is derived, not collected). *Killing test 12* ("a close
complementary (or V5) pair … where C-T-TAN's conclusion fails and none of the listed failures occurs") now reads: a surviving covering pair whose
seam point is in a tile — N-SEAM (a) forbids it.

### 2.4 The vertex case, one sub-case decided (N-X) [hand, one mind]

**N-X.** *In (S2), suppose none of the four unit directions at `w₀` starts an arc of `Γ` (no unit-arc seam at `w₀`), and the types are disjoint. Then:*
- *(a) `w₀` carries at least four colours: at least two of `u`'s and two of `v`'s, in the pattern `v, u, v, u` around `w₀` (a tile of `v`'s colour
  around each tangent of `ω(u)`, and of `u`'s around each tangent of `ω(v)`);*
- *(b) the two `u`-colours `a, b` around the tangents of `ω(v)` lie on opposite sides of `ω(u)` and are distinct, and at `u` their tiles lie on opposite
  sides of `ω(w₀)`; likewise for `v`;*
- *(c) if `|P_cl(u)| = 3` and exactly two of `u`'s colours are at `w₀`, then at `u` each tangent direction of `ω(w₀)` either starts an arc of `ω(w₀)` in `Γ` or lies inside
  a tile of `u`'s third colour `a′`; if no arc of `ω(w₀)` leaves `u`, then `a′` owns two sectors at `u` straddling the tangent line of `ω(w₀)` — a strong
  escape (a bowtie in `a′`) at `u`; likewise at `v` with its third colour `c′`;*
- *(d) `ω(w₀)` meets tiles of at most the two colours outside `P_cl(w₀)`; with `|P_cl(w₀)| = 4` these are `a′` and `c′`, alternating along
  `ω(w₀)` in arcs whose interior points `60°` apart differ (N-E0), and every point `y ∈ ω(w₀)` in the closure of both an `a′`-tile and a `c′`-tile makes
  `(w₀, y)` a covering pair at distance 1 — the cascade.*

*Proof.* (a) A tangent direction `r` of `ω(u)` at `w₀` interior to a tile `T`: `T` straddles `ω(u)` near `w₀`, so by N-SEAM (b) its colour is not `u`'s;
it is `v`'s, and `T` lies on one side of `ω(v)`, so its sector ends at or before the two tangents of `ω(v)`. The four tangents alternate (`ω(u)`, `ω(v)`
cross transversally), so the tiles around them alternate `v, u, v, u`. (b) The two `u`-colour tiles around the two tangents of `ω(v)` lie in opposite
halves cut by `ω(u)`. If they had one colour `k`, then against `u`'s `k`-tile `T′` one would be Siamese (`T′ ⊆ B̄(w₀, 1)`) and the other outer
(`T′ ∩ B(w₀, 1) = ∅`) — impossible for a non-empty open `T′` (N-E2). The sides at `u` are N-E2's symmetric half. (c) N-E1 at `w₀`: `ω(w₀)` meets no tile
of a colour in `P_cl(w₀)`. Near `u`, `ω(w₀)` runs in the two tangent directions of `ω(w₀)` at `u`; each is either an arc of `ω(w₀)` in `Γ` or enters a
tile (a boundary arc of curvature `≠ 1` along the direction lets `ω(w₀)` into one side), which must then be `a′`. With `a` on one side of `ω(w₀)` and `b`
on the other (b), one `a′`-sector cannot hold both tangent directions (it would contain a closed half of the directions and leave `a` or `b` no room on
its side), so `a′` owns two sectors, one about each tangent direction. (d) N-E1 at `w₀`, N-E0 on the circle, and `P_cl(w₀) ∪ P_cl(y) ⊇ [6]`. ∎

*What N-X shows.* Without a unit arc at `w₀`, a surviving covering pair forces a **four-colour vertex** at `w₀` (the claim list's V5, second kind) and
**bowties at both `u` and `v`** (or unit arcs of `ω(w₀)` at them), and it spawns new covering pairs `(w₀, y)` along `ω(w₀)` at distance exactly 1. So
the advisor's warning "A four-colour vertex in a bowtie direction is an escape the stub does not list" is realised by the geometry, not only allowed by
it: the X-vertex at `w₀` is where a pair without unit arcs must put its four-colour vertex. **Not derived:** the sub-cases of (S2) with some unit arcs at
`w₀` (the double unit-arc seam T2 among them), and whether N-X's cascade closes at bounded `K`. Both are GAP here.

### 2.5 Where each verdict spends six, and the controls

| result | the line where six is spent | seven-colour control |
|---|---|---|
| N-E0 (sight) | `\|S(z)\| ≤ 5` | hexagonal seven-colouring: circles about tile points meet six classes; no contradiction, as required |
| N-SEAM (a) | "every colour at `w₀` is `u`'s or `v`'s" | two disjoint triples miss the seventh colour; `w₀` may lie in its tile |
| N-SEAM (c)–(d), N-X | through (a) | as (a); (c)–(d) is TS-U, whose control is Townsend's ⅔π sector (TS §2.2, K2) |
| N-HORN, C-CUSP-K route 2 | nowhere (N-HORN is one circle and one horn); route 2 spends six through N-E0 | — |

*Killing tests of §4 on these shapes.* None of these is an area argument, so the strip, pinhole and Parts tests (§4 items 4–5) do not apply; they bind
only when a statement here is carried to SEQ and priced (N-SEAM (a) carried to SEQ would be R-CP's disc, whose tests FS-107 ran). Killing test 3 (the
seven-colour control): table above. Killing test 12: §2.3. Killing test 9 (C-TAN-POS's falsifier, "a tight 𝓜_K map with a ring junction against a
partner that blocks with margin"): N-SEAM says such a pair survives only through (S1) or (S2) at `w₀`; a ring junction with no unit arc at `w₀` must
meet N-X — the falsifier, if it exists, has a four-colour vertex at `w₀` and bowties at both junctions.

### 2.6 Not worked (left for the close and for a successor)

C-TAN-K (T1) beyond what (S1)/(S2) say; C-T2 (i) and (ii); C-BOW-K (i) and (ii); C-V5-K; SEAM-S (the bicycle, C-T-BIKE, K-KILL's second half);
C-ACT1 (Act One). **C-ACT1 is the step the NO most needs (X2: a list of kills with no Act One decides nothing)**, and none of the above touches it.
One observation for it [hand, one mind]: for any vertex `u` with `|P_cl(u)| = 4`, `ω(u)` meets at most two colours (N-E1), and any point of `ω(u)` where
those two meet makes a covering pair at distance 1 with `u`; so Act One holds in every tight six-map that has a four-colour vertex whose circle is not
one colour off `Γ`. The trivalent case — three colours at every vertex — is untouched.

## Stage 2 — SAVED

## Stage 3 — SAVED: retraction after A2's card 1 (free; counted)

**Retraction 1 (A2 card 1, point 2).** N-SEAM (d), C-TAN-POS's non-vertex case, (S1) and N-X (c) concluded "a colour in two sectors" (a strong escape)
at the centre `x`. That holds only when `|P_cl(x)| = 3`: TS-U empties the side cones of the two arc colours, and the side cones are then filled by `x`'s
remaining colours — one colour if one remains, possibly two different colours if `|P_cl(x)| ≥ 4` (A2's example: four sectors of four colours, each below
180°). Corrected in place above; every statement now carries the type-size condition. **Card 1, point 3:** §2.3's heading said "the exact list"; the list
is necessary conditions ("only if"), and the heading now says so. **Points 1 and 4, no change:** N-E0, N-SEAM (a)–(c), N-HORN and C-CUSP-K use only the
union `P_cl(u) ∪ P_cl(v) = [6]` (overlap allowed; N-E0 and N-SEAM (a) extend to covering families concyclic on `ω(w₀)`); N-X uses disjointness and says
so. C-TAN-POS's scope line is in its verdict above.

## § Continuation — FS110-N2

*Job FS110-N2, de Bruijn (Opus 5.5), 2026-09-27. Briefs: `data/fs110/briefs/N2-110-proof-continued.md` (wins where the two differ) and
`data/fs110/briefs/N110-proof.md`, with `STANDING-RULES.md`. I continue FS110-N's record here and rewrite none of its verdicts. Object LIM unless marked.
**Unit-arc proviso**, used throughout: "`ω(p)` carries no arc of `Γ`" means `Γ ∩ ω(p)` is finite; in `𝓜_K` S–V's Condition 5 ("If any boundary
intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden") is the same as: no arc of `Γ` has
radius exactly 1.*

### N2: theorems this continuation proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N2-V4 | a vertex `v` with `ω(v)` carrying no arc of `Γ` has `\|P_cl(v)\| ≤ 4`, and at `\|P_cl(v)\| = 4` some `y ∈ ω(v)` makes `(v, y)` a covering pair at distance 1; with arcs of `Γ` on `ω(v)` both steps are a GAP | [hand, trivial; A2-V56 and N's stage-2 note, checked here; the proviso mine, reached independently of A3's card 2] | stage 4, §4.2 |
| N2-RING | ring winding: at a vertex `u`, `\|P_cl(u)\| = 3`, `ω(u)` carrying no arc of `Γ`, the ring colouring by `P_cl(u)^c` has a winding number `W(u)`; if it has no swap point then `\|W(u)\| ≥ 2`; so `W(u) = 0` ⟹ a swap | [hand, one mind; exact check on five named rings, `tools/fs110_n_ring.py`] | §4.3 |
| N2-SWAP | at a swap point `x ∈ ω(u)`: a covering pair at distance 1 (`(u, x)`, or `(x, y)` with `y ∈ ω(x)`), unless `Γ` carries an arc of `ω(σx)` at `x` or an arc of `ω(x)` | [hand, one mind] | §4.3 |
| N2-ACT1-W0 | Act One holds in every tight six-map having a vertex of four colours or a trivalent vertex with a swap (in particular with `W = 0`), bar the named unit arcs; under Condition 5 unconditionally | [hand, one mind] | §4.4 |
| N2-ROT | at a ring change point with pattern (A+, A−) one colour `g ∈ P_cl(u)` fills the outward 60° cone at `x`, and `u`'s `g`-sector lies in the closed half-plane away from `x`; with (B+, B−) the inward cone and the half-plane toward `x`; no other pattern forces a colour at `x` | [hand, one mind; table checked on named rings] | §4.3 |
| N2-HEX | a purely rotating ring (six 60° arcs, `W = ±2`) forces `u` regular: three sectors of exactly 120°, each facing away from two consecutive rotation points | [hand, one mind] | §4.4 |

### N2: would-have-searched-here log

| move I would have made by search | what I did instead |
|---|---|
| enumerate ring colourings of `ω(u)` by three colours with the 60° rule, to see which are swap-free | derived the band argument (N2-RING); checked five rings given by formula |
| enumerate sector-angle triples at `u` against a rotating ring | derived the serving count (window `180° − α`) by hand (N2-HEX) |

### N2: fence log

1. Start-up `git log --oneline -3`: subjects `aad1d747`, `31c74057`, `380e3d17` — the snapshot's own; nothing beyond it opened.
2. I read `data/fs110/reports/FS110-N.md` (my brief names it: "its report is `data/fs110/reports/FS110-N.md`") and no other file in `data/fs110/reports/`;
   I did not list the directory.
3. A tool-output file was written by the harness under `~/.claude/projects/…/tool-results/` when I printed N's record; I did not open it and read the
   record from `plans/` instead. No fenced path opened, listed or grepped.

## Stage 4 — SAVED: card 1, the four-colour frame fact, and Act One on rings

### 4.1 Card 1 (A2), resent to me verbatim

FS110-N's stage 3 answered all four points (retraction 1 on point 2; heading fixed on point 3; points 1 and 4 unchanged). I checked each against N's
statements and add one precision, which is also my answer to A3's card 2: **N's stage-2 observation** ("for any vertex `u` with `|P_cl(u)| = 4`, `ω(u)`
meets at most two colours (N-E1), and any point of `ω(u)` where those two meet makes a covering pair at distance 1") **needs "where those two meet" to
exist, which fails when arcs of `Γ` on `ω(u)` separate them** — scoped in N2-V4 below (a precision, not a change of verdict; counted as retraction 2,
free).

### 4.2 N2-V4: the four-colour frame fact, checked

*Statement (A2-V56, verbatim):* "In a full tight a.e.-proper map, every vertex has |P_cl(v)| ≤ 4." *Its step:* "One colour cannot fill a unit circle,
because two of its points 60° apart are at distance 1 (A-EXACT)." *The owner's combination (the advisor's record, verbatim as relayed):* "every tight
six-map with a four-colour vertex has a covering pair at distance 1".

**Verdict: TRUE when `ω(v)` carries no arc of `Γ`; GAP otherwise [hand, trivial].** If `Γ ∩ ω(v)` is finite, `ω(v)° = ω(v) ∖ Γ` is cofinite in the
circle, so it holds pairs 60° apart; by N-E1 its colours avoid `P_cl(v)`, and by N-E0 two points 60° apart differ, so `ω(v)°` carries at least two
colours outside `P_cl(v)`: `|P_cl(v)| ≤ 4`. At `|P_cl(v)| = 4` the two outside colours `e, f` both occur on `ω(v)°`, which is a finite union of open arcs
separated by points; walking round, some separating point `y` has an `e`-arc on one side and an `f`-arc on the other, so `P_cl(y) ⊇ {e, f}` and
`P_cl(v) ∪ P_cl(y) = [6]`, `|v − y| = 1`. *Where it fails:* if `ω(v)` carries arcs of `Γ` (unit arcs centred at `v`), an `e`-arc and an `f`-arc may be
separated only by such arcs; an endpoint `y` of one has `P_cl(y)` = the adjacent outside colour plus the arc's two side colours, which lie in `P_cl(v)`
by TS-U — no covering pair. And `|P_cl(v)| = 5` needs `ω(v)°` to hold no two points 60° apart, i.e. arcs of `Γ` on `ω(v)` of total length at least half
the circle (each hexagon inscribed in `ω(v)` has at most three points in `ω(v)°`, alternate ones). **So the frame fact holds with the proviso, and the
vertices it leaves are centres of unit arcs of `Γ`** — the (S1) kind, centred at `v`. *Six is spent* at "the two outside colours `e, f`": with seven
colours a four-colour vertex leaves three outside colours and `(v, y)` covers six of seven.

### 4.3 The ring of a trivalent vertex

*Setting.* `u` a vertex, `t = P_cl(u)`, `|t| = 3`, `ω(u)` carrying no arc of `Γ`. By N-E1, `ω(u)°` is coloured by `t^c`; by N-E0, `c(θ) ≠ c(θ + 60°)`.
Identify `t^c` with `ℤ/3`; lift `c` to `c̃` along the circle, changing by `+1` or `−1` at each colour change (a point of `Γ ∩ ω(u)` with the same colour on
both sides changes nothing). `W(u) = (c̃(θ + 360°) − c̃(θ))/3 ∈ ℤ` (its sign depends on the identification). `σ` is the rotation by `+60°` about `u`;
`c(x±)` are the colours just after and just before `x` in the positive sense. A **swap point** is a change point `x` with `c(σx−) = c(x+)` and
`c(σx+) = c(x−)` (or the same with `σ⁻¹`).

**N2-RING. [hand, one mind.]** *If `ω(u)` has no swap point then `|W(u)| ≥ 2`; hence `W(u) = 0` forces a swap point.* *Proof.* `D(θ) = c̃(θ+60°) − c̃(θ)` is
locally constant and never `≡ 0 (mod 3)` (N-E0). It jumps only where `θ` or `θ + 60°` is a change, by `Δ(θ+60°) − Δ(θ) ∈ {0, ±1, ±2}` (`Δ` the step
there). To leave a band `{3m+1, 3m+2}` it must jump over `3m` or `3m+3`, i.e. by `−2` from `3m+1` or `+2` from `3m+2`; that needs `Δ(θ) = ±1`,
`Δ(θ+60°) = ∓1`, and then `c(θ+60°−) = c(θ−) + D ≡ c(θ+)` and `c(θ+60°+) = c(θ−)` — a swap. With no swap, `D` keeps one band and
`3W = Σ_{k=0}^{5} D(θ + 60k°) ∈ [18m + 6, 18m + 12]`, so `W ∈ [6m+2, 6m+4]`, never in `{−1, 0, 1}`. ∎ A two-coloured ring (S–V Lemma 2's ring) has
`W = 0`, so it always has swaps.

**N2-SWAP. [hand, one mind.]** *Let `x` be a swap point, `p = c(x−)`, `q = c(x+)`, `r` the third colour of `t^c`. Then (i) `Γ` carries an arc of `ω(σx)` at
`x`, or (ii) `r ∈ P_cl(x)` and `(u, x)` is a covering pair at distance 1, or (iii) `P_cl(x) = {p, q, g_in, g_out}` with `g_in ≠ g_out` in `t`, and then
N2-V4 at `x` gives a covering pair at distance 1 unless `ω(x)` carries an arc of `Γ`.* *Proof.* The `p`-tile at `σx` holding the arc just after `σx` has
points at distance `> 1` from `x`, so by N-E2 every `p`-tile at `x` is outer to it: `S ∩ B(σx, 1) = ∅`. The `q`-tile at `σx` holding the arc just before
`σx` has points at distance `< 1` from `x`, so every `q`-tile at `x` is Siamese: `S ⊆ B̄(σx, 1)`. At `x`, `ω(σx)` has two tangent directions, `τ_in`
into `B(u, 1)` and `τ_out` out of it (they make 60° with `ω(u)`'s tangent). Suppose no arc of `ω(σx)` leaves `x` along `τ`. If `τ` is interior to a
sector, that tile has points on both sides of `ω(σx)`; if `τ` is a boundary ray, the arcs leaving along `τ` have curvatures `≠ 1` against `ω(σx)` (in
`𝓜_K` a circular arc tangent to `ω(σx)` with curvature 1 on the same side coincides with it), and the sector (full or cusp horn) that holds the
curvature-1 slot between them straddles `ω(σx)`. Either way a tile at `x` straddles `ω(σx)` near `τ`, so its colour is neither `p` nor `q`. If it is `r`,
(ii). Otherwise it is in `t`, so by N-E1 at `u` its tile misses `ω(u)`: the straddler at `τ_in` lies in `B(u, 1)`, the one at `τ_out` outside `B̄(u, 1)`.
One colour `g` at both is impossible: against a `g`-tile `T_g` at `u`, N-E2 for `(u, x)` makes `T_g ⊆ B̄(x, 1)` (inner straddler, Siamese) and
`T_g ∩ B(x, 1) = ∅` (outer straddler, outer), so `T_g ⊆ ω(x)`, absurd. So `g_in ≠ g_out`, (iii). ∎ *Where six is spent:* "`r ∈ P_cl(x)` ⟹ covering",
and in N2-V4. *Seven-colour control:* in the tight hexagonal seven-colouring the ring of a vertex sees four colours, so `W` is not defined and the
lemma is silent, as required. *Townsend's ⅔π sector:* the exception (i) is a unit arc of `ω(σx)` separating `p` (outer) from `q` (Siamese) — S–V
Prop. 5's own exception ("Since the arc of ω(y) is not a boundary"), which Townsend's sector realises.

**N2-ROT (the neighbour table). [hand, one mind.]** At a change point `x` (`p` before, `q` after), write (A+) for `c(σx−) = q`, (B+) for `c(σx+) = p`,
(A−) for `c(σ⁻¹x+) = p`, (B−) for `c(σ⁻¹x−) = q`. By N-E2 as above: (A+) puts every `q`-tile at `x` in `B̄(σx, 1)` (directions `[30°, 210°]` from the
outward radial at `x`, counterclockwise positive); (B+) puts every `p`-tile outside `B(σx, 1)` (`[210°, 390°]`); (A−) puts `p` in `B̄(σ⁻¹x, 1)`
(`[150°, 330°]`); (B−) puts `q` outside `B(σ⁻¹x, 1)` (`[−30°, 150°]`); no `r`-tile is at `x` (else (ii)). Hence: (A+, B+) or (A−, B−) is a swap
(N2-SWAP); **(A+, A−)** leaves the **outward cone** `(−30°, 30°)` to a colour `g ∉ {p, q, r}`, so `g ∈ t`, its tile outside `B̄(u, 1)`, and by N-E2
`u`'s `g`-sector lies in the closed half-plane away from `x`; **(B+, B−)** leaves the **inward cone** `(150°, 210°)`, `g ∈ t` inside `B(u, 1)`, `u`'s
`g`-sector in the closed half-plane toward `x`; every other pattern forces nothing at `x` (each colour's allowed set leaves no open gap). A single
change (`σ^{±1}x` inside `r`-tiles) is free. `tools/fs110_n_ring.py` reproduces the table on the named rings: the rotating ring's six changes are all
(A+, A−); the twelve-arc ring's (`W = 4`) all (B+, B−); the nine-arc ring's (`W = 3`) all free.

### 4.4 Act One: what is proved, and the GAP

**N2-ACT1-W0. [hand, one mind.]** *A tight six-map has a close covering pair (at distance 1) if it has (a) a vertex with four colours whose circle carries
no arc of `Γ` (N2-V4), or (b) a vertex with three colours whose circle carries no arc of `Γ` and whose ring has a swap point — in particular a ring with
`W = 0` (N2-RING) — unless `Γ` carries the unit arc N2-SWAP (i) or (iii) names.* Under Condition 5 (no arc of radius 1 in `Γ`) the proviso is empty.
**So an Act-One counterexample with no unit arcs has: every vertex of at most three colours (bichromatic vertices of degree `≥ 4` allowed), and every
trivalent ring swap-free, hence winding `|W| ≥ 2`, its changes free or rotation points.** That is the **example invariant** (G79) every such map must
carry at every trivalent vertex: *the complementary ring winds at least twice.*

**N2-HEX. [hand, one mind.]** *A purely rotating ring (`W = ±2`, six arcs of 60°) forces `u` regular.* Every change `x_k` is (A+, A−), so some sector of
`u` fits in the closed half-plane away from `x_k`, for each `k`. A sector of angle `α` centred at `β` fits away from `x_k` iff `|β − (dir x_k + 180°)| ≤
90° − α/2`: it serves at most `⌊(180° − α)/60°⌋ + 1` of the six points, none if `α > 180°`. The three sectors are contiguous with angles summing to 360°;
the only way to serve all six is `(120°, 120°, 120°)`, each sector centred exactly between the antipodes of two consecutive `x_k` (the other counts that
reach six, `(60°, 120°, 180°)` and `(60°, 60°, 240°)`, fail contiguity: checked by hand, §4.4 of my working). This is the hexagonal tiling's vertex;
the pure rotating ring is locally consistent (the hexagonal picture: consecutive outward straddlers at `x_k, x_{k+1}` are outer to each other, checked).

**C-ACT1: GAP**, at the step **"a tight six-map (no unit arcs) whose every trivalent ring winds"**. Proved: Act One at four-colour vertices and at every
ring with a swap. Not proved: rings with `|W| ≥ 2` — locally consistent (the rotating ring with a regular `u`; the nine-arc ring with free changes), so
the kill is not local at one vertex: it must read how windings of adjacent vertices fit (two vertices on one edge share two colours, and their rings
live in triples that share one colour). Unit-arc maps are the second branch (the swap's exceptions are the T2/S1 seams' unit arcs).

## Stage 4 — SAVED
