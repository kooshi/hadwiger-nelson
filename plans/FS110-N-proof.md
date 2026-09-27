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
| N2-S1 | at a non-vertex seam point `w₀` on a unit arc of `ω(u)` (the (S1) seam), with `(u, v)` a disjoint (3,3) covering pair, `\|u − v\| ∉ {1, √3}`, and `ω(v)` free of `Γ`-arcs at `σ_v^{±1}w₀`: `v`'s ring changes freely at `w₀`, and both hexagon neighbours `σ_v^{±1}w₀` carry `u`'s bowtie colour `γ` on both sides along `ω(v)` | [hand, one mind; the exceptional distances located numerically, §5.1] | stage 5, §5.1 |
| N2-TRANS | along an edge `uu′` (common colours `a, b`) of an Act-One-free map without unit arcs, `W(u)` on the ring oriented `(d, e, f)` equals `W(u′)` on `(c, e, f)` — `u′`'s third colour `d` replaced by `u`'s third colour `c` | [hand, one mind, a sketch at the nerve step] | stage 6, §6.1 |
| N2-FLIP | around a tile the transported ring orientation returns reversed iff an odd number of consecutive boundary vertices share a type; such a tile forces `W = 0`, hence Act One (N2-RING, N2-SWAP), under Condition 5 | [hand, one mind; parity checked on five named faces, `tools/fs110_n_face.py`] | §6.2 |

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

## Stage 5 — SAVED: (S1) at the seam point, the vertex case with unit arcs, and the global claims

### 5.1 N2-S1: what an (S1) seam forces on the partner's circle [hand, one mind]

*Setting.* `(u, v)` a covering pair with `P_cl(u) = {α, β, γ}`, `P_cl(v) = {δ, ε, ζ}` (disjoint), `|u − v| < 2`; `w₀` a common unit point on the
interior of an arc `A ⊂ ω(u) ∩ Γ` (N-SEAM (c)); `α` the inner side colour of `A`, `β` the outer, `γ` filling both side cones at `u` (N-SEAM (d); a
bowtie of degree 4 at `u`). `σ_v` is the rotation by 60° about `v`.

**N2-S1.** *If `|u − v| ∉ {1, √3}` and `ω(v)` carries no arc of `Γ` at `σ_v^{±1}w₀`, then along `ω(v)` both sides of `σ_v w₀` and of `σ_v⁻¹w₀` are
coloured `γ`.* *Proof.* `ω(v)` crosses `A` transversally at `w₀`, so `w₀` is a change point of `v`'s ring (colours `t(v)^c = {α, β, γ}`) with
`{p, q} = {α, β}` and third colour `r = γ`. Apply N2-ROT's four conditions. (A+) would put the `q`-tile at `w₀` in `B̄(σ_v w₀, 1)`; but at the non-vertex
`w₀` the `q`-tile is a half-disc bounded by `A`, which lies in a disc through `w₀` only if that disc's circle is tangent to `ω(u)` at `w₀`, i.e.
`σ_v w₀ − w₀ = ±(u − w₀)`. In the triangle `u w₀ v` the angle at `w₀` is `π − 2ψ` (`|u − v| = 2cos ψ`), so this happens only at `ψ = π/3` (`σ_v w₀ = u`,
`|u − v| = 1`) or `ψ = π/6` (`σ_v^{∓1}w₀ = 2w₀ − u`, `|u − v| = √3`) — located numerically as the zeros of the cross product (a spot check, not a
proof; the angle count is the proof). The same holds for (B+), (A−), (B−). With none of the four, N-E0 leaves only `r` at `σ_v^{±1}w₀±`. ∎

*What it says.* An (S1) seam is not free: the bowtie colour `γ` of the centre must reappear at the two points of the partner's circle 60° from `w₀`
(each at distance 1 from `w₀` and from `v`). If `w₀′` (the mirror seam point) is also (S1) centred at `u`, the same at `σ_v^{±1}w₀′`; an (S1) seam
centred at `v` gives `v`'s bowtie colour on `u`'s circle. *Where six is spent:* "`r` is unique" — with seven colours `t(v)^c` has four colours and the
conclusion weakens to "one of two colours", as required. *Townsend's ⅔π sector:* TS-U's own control; N2-S1 reads the sector from the partner's side and
adds no new use of six. *Not derived:* whether the `γ` points at `σ_v^{±1}w₀` force a further covering pair (they lie at distance `2 sin|60° − ψ|` from
`u`, not 1, so N-E2 does not reach them): the next link of the (S1) cascade is a GAP.

### 5.2 The vertex case (S2) with unit arcs at `w₀`: a reduction, not a verdict [hand, one mind]

At a vertex `w₀`, each of the four unit tangents (`τ_u^±` of `ω(u)`, `τ_v^±` of `ω(v)`, alternating) either starts an arc of that unit circle in `Γ`, or is
straddled by a tile whose colour belongs only to the other point (N-SEAM (b) and the curvature-slot argument of N2-SWAP). Sixteen patterns, up to the
symmetries `u ↔ v` and reflection: **no arcs** is N-X (four colours at `w₀`, pattern `v, u, v, u`); **both `τ_u^±` arcs, no `τ_v` arcs** is (S1) at a
vertex — the two `u`-colour straddlers of `τ_v^±` lie on opposite sides of `ω(u)` and differ (N-X (b)'s argument), so `w₀` has at least two `u`-colours
and the arc of `ω(u)` through `w₀` is an (S1) arc; **all four arcs** is `ω(u)` and `ω(v)` both in `Γ` through `w₀`, the four quadrants each on fixed
sides of both circles, with no colour of `u` (resp. `v`) on both sides of `ω(u)` (resp. `ω(v)`) — consistent as far as I derived; **one arc** patterns
mix N-X with (S1). Each pattern's kill is open; the useful fact is that no new seam kind appears: every (S2) vertex is N-X, (S1) at a vertex, or a
crossing of two seam arcs. **Verdict: GAP** at every pattern but N-X's (which N held).

### 5.3 The global claims

- **C-T2 (ii): GAP; N's registered bet (FALSE at every `K`) stands, unproved.** What I add: N2-SWAP shows every swap on a winding-zero ring near a T2
  rhombus demands another unit arc or a covering pair, and N2-S1 shows each non-vertex unit-arc seam demands its centre's bowtie colour at two further
  points; neither closes the cascade. The step named: **a finiteness count** — at bounded `K` the number of unit arcs per unit disc is bounded, and the
  cascade must be shown to demand more.
- **C-BOW-K (ii): GAP.** N2-S1 is the first "forced partner" fact for a bowtie seam (the brief's third route: "forcing a non-escaping partner"), but the
  forced `γ` points are not yet shown to create a covering pair without an escape. The step named: **does a `γ` point at `σ_v w₀` form, with a vertex of
  type `t(u)^c ∪ …`, a covering pair saved by no escape?**
- **C-ACT1: GAP** (stage 4): Act One proved at four-colour vertices and at rings with a swap; open for maps whose every trivalent ring winds.

### 5.4 Registered (G21 instruments, scored at the close)

| id | prediction | probability |
|---|---|---|
| N2-P1 | the winding case of Act One (§4.4) is not killed by any argument local to one vertex and its circle | 0.8 |
| N2-P2 | C-ACT1 is TRUE for tight six-maps in `𝓜_K` without unit arcs | 0.6 |
| N2-P3 | a local fragment realising (S1) with N2-S1's `γ` points exists (the construction side's (S1) fragment will meet N2-S1) | 0.7 |

## Stage 5 — SAVED

## Stage 6 — SAVED: the winding is transported along edges (Act One's GAP, sharpened)

*Standing assumption of this stage (for contradiction):* a tight six-map in `𝓜_K` with no arc of radius 1 in `Γ` (Condition 5) and **no close covering pair**
(Act One fails). By N2-V4 and N2-RING/SWAP: every vertex has at most three colours, every trivalent ring is swap-free, `|W| ≥ 2`.

### 6.1 N2-TRANS [hand, one mind; the nerve step a sketch]

Let `u, u′` be trivalent vertices joined by an edge `e` of `Γ` between an `a`-tile and a `b`-tile: `t(u) = {a, b, c}`, `t(u′) = {a, b, d}`. For `z` on `e`,
`P_cl(z) ⊇ {a, b}`, so by N-E1 every point of `ω(z)` in a tile has a colour in `{c, d, e, f}`. The map `(s, θ) ↦ z_s + e_θ` pulls the colouring back to a
cylinder whose ends are the rings of `u` and `u′`. Three colours meet at a point of the cylinder only over a vertex of `Γ` with those colours in its
type; such a vertex lies within distance `≤ 1 + |z_s − u| ≤ 2` of `u` and of `u′` (both in the closure of the `a`-tile, diameter `≤ 1`), so off the
`d = 2` configuration its type meets `t(u)` and `t(u′)`: being inside `{c, d, e, f}`, it contains `c` and `d`. So the nerve of the pulled-back colouring
lies in `X` = the complete graph on `{c, d, e, f}` with the two faces `cde`, `cdf` (no four-colour vertices, N2-V4). The two ring loops are homotopic in
the cylinder, hence homologous in `X`, where `[def] = [cef] − [cdf] + [cde] ≡ [cef]` (exact identity of 1-cycles, written out in §6.1 of my working:
`ce + ec = 0`, `−df = fd`). Hence **`W(u)` read on `(d, e, f)` equals `W(u′)` read on `(c, e, f)`.** Same-type edges (`c = d`) transport the
orientation unchanged. *Six is spent* at "a band vertex's type contains `c` and `d`": with seven colours the band has five colours and the faces do
not pin `H₁`.

### 6.2 N2-FLIP: odd tiles kill the winding [hand, one mind]

Around a tile of colour `a` with neighbours `b_0, …, b_{m−1}` (boundary vertices `v_i` of type `{a, b_{i−1}, b_i}`, all trivalent), N2-TRANS moves a
label from colour `b_{i+1}` to `b_{i−1}`. Extend the labels to all five colours of `[6] ∖ {a}` (the two colours `b_{i−1}, b_i` outside the ring
carry labels 4, 5): each step is the transposition `(b_{i−1} b_{i+1})` of labels, trivial exactly at a same-type step (`b_{i−1} = b_{i+1}`). After a full
turn the total parity is `(−1)^{m−k}` (`k` same-type steps); the two outside labels leapfrog one index per step and return swapped iff `m` is odd,
parity `(−1)^m`; so the ring's own permutation has parity `(−1)^k`. **An odd `k` returns the ring orientation reversed, so `W(v_0) = −W(v_0) = 0`,
against `|W| ≥ 2`: such a tile forces a swap, hence Act One** (N2-RING, N2-SWAP). `tools/fs110_n_face.py` checks the parity on five named faces
(planted fault: overwriting a fixed slot; it fires on four of the five, and cannot reach the hexagon `2, 3, 4, 2, 3, 4`, whose steps all move one
slot — noted, G21).

### 6.3 C-ACT1 after stage 6: GAP, the step narrowed

**Proved (Condition 5, one mind):** Act One holds in every tight six-map having a four-colour vertex, a trivalent ring with a swap (in particular
`W = 0`), or a tile with an odd number of same-type boundary steps (all boundary vertices trivalent). **The GAP:** maps in which every vertex has
at most three colours, every tile has an even number of same-type steps (the generic case: neighbours of distinct colours give `k = 0`), and the
winding `|W| ≥ 2` is carried consistently along every edge by N2-TRANS. The next move, for the successor: N2-TRANS is a flat structure on the map; its
global form (a section over the whole plane) must meet something the winding cannot carry — candidates are the bichromatic vertices of degree
`≥ 4` (where the ring has four colours and no winding), N2-HEX's rigidity at rotation points, and a count of ring changes (`≥ 3|W|` per vertex) against
edge length per unit area at bounded `K`.

## Stage 6 — SAVED

## § Continuation — FS110-N3

*Job FS110-N3, de Bruijn (Opus 5.5), 2026-09-27. Briefs: `data/fs110/briefs/N3-110-round3.md` (wins where the two differ) and
`data/fs110/briefs/N110-proof.md`, with `STANDING-RULES.md`. Round 3, the winding question W-3 (`data/fs110/claims.md` §7, §7.1). I continue this
record and rewrite none of its verdicts. Object LIM unless marked. Working files: `data/fs110/fs110-n/`; scratch `scratchpad/fs110-n3/`.*

### N3: the pre-round answer (sent to "main" and to FS110-A5 before stage 1 was saved; retractions counted from here)

"Expected failing step: the construction's vertex at which one colour holds two non-adjacent sectors (a trichromatic "bowtie" of degree ≥ 4, or a
bichromatic vertex of degree ≥ 4) used as ESSENTIAL — i.e. to escape S–V's cubic argument (a cubic Condition-5 map is killed by S–V's own chain,
FS106-V's repaired Cor. 1, one mind, bar d = 2; the six-arc rotating ring at a cubic vertex is S–V Prop. 17's kill under Condition 5). I expect every
such vertex whose repeated colour has sectors of POSITIVE angle to be removable by an almost-everywhere form of Woodall 1973's step 3 (merge the two
sectors across the gap lying inside the colour's allowed cone), so it buys nothing over a cubic map. What would show me wrong: (1) a winding map given
by formula, checked exactly, whose repeated-colour sectors at such a vertex are cusp horns tangent to a boundary direction of that colour's allowed
cone at the vertex (Woodall's "cone", which his step 5 excludes only at five colours); (2) one realising S–V's d = 2 configuration (two same-type
trichromatic points antipodal on a trivalent vertex's unit circle); (3) a merge that lands a recoloured point at distance exactly 1 from a same-colour
tile."

### N3: theorems this continuation proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N3-CONF | at a point `v`, for a colour `c ∈ P_cl(v)`: every contact `w ∈ cl(C_c°) ∩ ω(v)` (finitely many, Condition 5) has all its `c`-tiles on one side of `ω(v)` (in-type or out-type), and every `c`-sector at `v` has its directions in `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}` | [hand, one mind] | stage 2, §2.1 |
| N3-CLEAR | for every compact set `Λ` of directions in `int D_c(v)` there is `ρ > 0` with `{v + rd : d ∈ Λ, 0 < r < ρ}` at distance `≠ 1` from every `c`-tile point | [hand, one mind] | §2.1 |
| N3-UP | at a tangent contact (`e_w ⊥ a`), in-type at `v + n` and out-type at `v − n` are both upward closed near `v`: a point clear of them stays clear when moved in the `+n` direction (lens `\|p\|² ≤ 2p_y`, lune `p_y ≤ −1/2`) | [hand, one mind; exact check `tools/fs110_n_merge.py` C1–C2] | §2.1 |
| W-MERGE | Woodall's step 3, almost everywhere, for curved arcs: if `int D_c(v) ≠ ∅`, any two non-adjacent `c`-sectors at `v` (positive angle or cusp horns) are joined by recolouring with `c` the sectors of the gap between them inside `D_c(v)`, within `B(v, ρ)`; the result is a full a.e.-proper colouring by a map with Condition 5, types only shrink, new vertices are cubic with distinct colours, and no other vertex's `D_c` changes | [hand, one mind] | §2.2 |
| N3-DEG | `int D_c(v) = ∅` only in **Woodall's cone**: `c` has out-type contacts at both `v ± n` (`n ⊥ a`), and every `c`-sector at `v` is a cusp horn along `±a` with bounding curvatures in `(−1, 1)` (strict by Condition 5) | [hand, one mind] | §2.3 |
| N3-P17 | under Condition 5 (and NB-4), no vertex with exactly three sectors has a purely rotating ring (six 60° arcs): the outward cone at a rotation point is bounded by an arc of `ω(σx)` lying in `Γ` | [hand, two derivations: `[SokolovVoronov2025]` Prop. 17 as repaired by FS106-V; this job through N2-ROT, N2-HEX and N-E2; exact geometry C5] | §2.4 |
| N3-RED | a tight six-map in `𝓜_K` under Condition 5 has, in every disc of radius 3, a hard Woodall-cone vertex or (after W-MERGE) S–V's `d = 2` configuration — given FS106-V's repaired S–V Cor. 1 (cubic maps, Condition 5; one mind, a sketch at Lemma 3 for `√3 ≤ d < 2`) | [hand, one mind, over FS106-V's one mind] | §2.5 |

### N3: would-have-searched-here log

| move I would have made by search | what I did instead |
|---|---|
| enumerate contact configurations (in/out types at points of `ω(v)`) to find which block a merge | derived the allowed cone `D_c(v)` and its degenerate case (N3-DEG) |
| sample horn curvatures and circles numerically to see which gaps are shadowed | derived the upward-closedness (N3-UP) and the envelope (C4) exactly |

### N3: fence log

1. `ls data/fs110/` (stage 0, to find my working directory) printed the **directory names** `fs110-a/ … fs110-a4/`, `fs110-nb/`, `fs110-y/`,
   `fs110-yb/`, `reports/`, and the file name `owner-notes-round2.md`. Names only; nothing in a fenced directory was listed, opened or grepped. I did
   not open `owner-notes-round2.md` (not fenced by name, not in my reading list).
2. The harness's start-up git status (in my context, not a command of mine) names untracked `data/fs110/fs110-yb/` and `tools/fs110_yb_*.py`. Names
   only; not opened.
3. `git log`: only the start-up snapshot's five subjects seen. Read, not fenced: `plans/FS110-PA-prior-art.md` (open to me by the brief),
   `plans/FS106-V-verification.md` (FS-106's record), `LEDGER.md` rows 131–133, `[SokolovVoronov2025]` (held PDF, my extraction
   `scratchpad/fs110-n3/sv.txt`).

## Stage N3-1 — SAVED: quotation check, Condition 5, reading

**Quotation check (standing rule 5).**

| quotation in my brief | source | result |
|---|---|---|
| Condition 5: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden." | `[SokolovVoronov2025]` p. 4 (held PDF, text l. 148–150) | verbatim; the print prefixes the label "(fa = “forbidden arcs”)" |
| the claim list's gloss "no boundary arc of radius 1" | `data/fs110/claims.md` §7 ("Under Condition 5 (no boundary arc of radius 1)") | verbatim, inside A4's quoted frame |
| NB-4 "under Condition 5, no vertex of a tight six-map in `𝓜_K` has four colours"; NB-5 "so under Condition 5 no tight six-map has a close covering pair" | `data/fs110/claims.md` §7 | verbatim from the claim list; their sources (NB's and A4's records) are fenced — not checkable by me. NB-4 is also `[SokolovVoronov2025]` Lemma 2 in print ("Under Condition 5, no point in a valid 6-coloring can have chromaticity k ≥ 4", p. 8, read) |
| the advisor's tool list "N2-TRANS as a flat structure over the plane; N2-HEX's rigidity; A4-BAND's same-type spacing with a transposed swap; a count of ring changes (`≥ 3\|W\|` per vertex) against edge length at bounded `K`" | A4 § A4-2.4 (fenced) | not checkable; three of its four items are this record's own §6.3 closing sentence, which matches in substance. "A4-BAND" is undefined for me (the owner's §7.1: not part of W-3); I do not use it |
| W-3's terms (ring, `W`, swap point, N2-TRANS, even/odd tile) | `data/fs110/claims.md` §7.1, quoting this record §4.3, §6.1–6.2 | verbatim against this record |
| Q-full, the question in print (Question 2) | `data/fs110/claims.md` §1; `[SokolovVoronov2025]` p. 26 | checked by FS110-N at stage 1; Question 2 re-read in my extraction (text l. 1016) |

**Which Condition 5 I use.** The print's form: every boundary meets every unit circle in a finite set. **In `𝓜_K` the two forms coincide [hand,
trivial]:** every arc of `Γ` is a straight segment or a circular arc of radius `≥ 1/K`; a unit circle `ω` meets a segment, or a circle of radius
`≠ 1`, in at most two points, and a circle of radius 1 in at most two points unless the two circles are equal; `ω` is compact and meets finitely many
arcs (at most `K` per unit disc). So `Γ ∩ ω` is finite for every unit circle iff no arc of `Γ` has radius exactly 1. (Outside `𝓜_K` the print's
form is strictly stronger, `[FS110-PA]` stage 1.)

**Reading done for this round (G50, per section).** `[SokolovVoronov2025]`: §5 (Props. 6, Lemma 2), §6 (Props. 9–10, Cor. 2, Prop. 11, Cor. 3),
§7 (Lemma 5, Props. 14–19, Lemma 6), Lemma 4's statement and Appendix proof, §9 — read first-hand in my extraction. `plans/FS106-V-verification.md`:
the S–V rows (SV-L3, SV-L4, Props. 14–19, Lemma 6, SV-1, SV-2), Townsend's (c), Woodall's step 3 and "A tool for SV-1's open step" (l. 530–534), the
`d = 2` stretch. `plans/FS110-PA-prior-art.md` in full.

## Stage N3-1 — SAVED

## Stage N3-2 — SAVED: the merge lemma, the cone, and the reduction of W-3 to two named steps

*Frame at a point `v`: `a` a direction, `n ⊥ a`, `N = v + n`, `S′ = v − n`; local coordinates `x` along `a`, `y` along `n`. A cusp horn along
`a` is `{κ₁x²/2 < y < κ₂x²/2, x > 0}` to second order, `κ₁ < κ₂` (N-TYPE). "Clear" (for colour `c`) means at distance `≠ 1` from every point of
every `c`-tile. The map is a full a.e.-proper six-colouring in `𝓜_K` under Condition 5; tightness is never used in this stage.*

### 2.1 Contacts, the allowed cone, clearance

**N3-CONF.** `C_c° ∩ ω(v) = ∅` (N-E1), so `W_c(v) = cl(C_c°) ∩ ω(v) ⊆ Γ ∩ ω(v)`, finite by Condition 5. A `c`-tile `T′` at `w ∈ W_c(v)` misses
`ω(v)` and is connected, so it lies in `B(v, 1)` (in-type) or outside `B̄(v, 1)` (out-type). *Both types at one `w` are impossible:* for a `c`-tile
`X` at `v`, N-E2 gives `X ⊆ B̄(w, 1)` against the in-type tile and `X ∩ B(w, 1) = ∅` against the out-type tile, so `X ⊆ ω(w)`. So each contact has a
type, and N-E2 puts every `c`-sector at `v` in `B̄(w, 1)` (in) or outside `B(w, 1)` (out): its directions satisfy `d·e_w ≥ 0` or `≤ 0`. ∎

**N3-CLEAR.** `c`-tiles whose closures miss `ω(v)` have compact closures (diameter `≤ 1`) at distances from `v` bounded away from 1, so a
neighbourhood of `v` is clear of them. For an in-type tile `T′` touching at `w`, `z = v + rd` with `d·e_w ≥ µ > 0`:
`|z − p|² = |p − v|² − 2r d·(p − v) + r² < 1` for `p ∈ T′` near `w` once `r < µ/2`, and `|p − v| ≤ 1 − η` elsewhere on `cl T′`; out-type
symmetric. Finitely many tiles meet a neighbourhood of `ω(v)`. ∎

**N3-UP.** An in-type `c`-tile at `N` lies in the lens `B(v,1) ∩ B̄(N,1)`, where `|p|² ≤ 2p_y` (C1): its points with `p_y ≤ 1/4` are within
`√(1/2) + r < 1` of any `z ∈ B(v, r)`, and for the rest `|z + te_y − p|² < |z − p|²` when `0 < t < 2(p_y − z_y)`. An out-type `c`-tile at `S′`
lies in the lune `B̄(S′,1) ∖ B(v,1)`, where `p_y ≤ −1/2` (C2), so moving `z` in the `+y` direction increases every distance to it. So both are
upward closed: a clear point stays clear when pushed toward `+n`. ∎ (These are exactly the two contact kinds that bound `D_c(v)` at `a` with its
interior on the `+n` side.)

### 2.2 W-MERGE (Woodall's step 3, almost everywhere, curved arcs)

*Let `int D_c(v) ≠ ∅`, and `S₁, S₂` two `c`-sectors at `v` consecutive along the arc `D_c(v)` of directions (so not the same sector); let `G` be the
union of the sectors strictly between them inside `D_c(v)`. Recolour `R = G ∩ B(v, ρ)` with `c`. For small `ρ` the result is a full a.e.-proper
six-colouring by a map (new boundary arcs of radius `ρ < 1`, so Condition 5 and local finiteness hold); every old point's `P_cl` shrinks or is
unchanged; the new points on `∂B(v, ρ)` are corners `{c, g}` or cubic vertices `{c, g_i, g_{i+1}}` of positive angles; `c` has one sector fewer at
`v`; and for every other vertex `v′`, `D_c(v′)` is unchanged.*

*Proof.* Directions of `G` lie in `D_c(v)` between those of `S₁` and `S₂`. Where an end of `cl G` is interior to `D_c(v)`, N3-CLEAR clears a
neighbourhood of it. An end can lie on `∂D_c(v)` only if the adjacent `c`-sector is a cusp horn along the extreme direction `a`, and then the
contacts bounding `D_c` at `a` are tangent ones at `N` or `S′` of the two kinds of N3-UP (interior of `D_c` on the `G` side): every point of `G`
near `a` lies directly `+n`-above a point of that horn, which is a `c`-tile and so clear, hence clear by N3-UP; the other contacts are cleared
there by N3-CLEAR, since `a` is interior to their half-planes. (A contact of the opposite kind at `a` would make `int D_c = ∅`.) So `R` is clear
for `c`, and `R` has diameter `< 2ρ < 1`: the new colouring has no same-colour unit pair between tile points (N-E0), hence is a.e.-proper; other
colours only lost points. For `v′`: the new colouring is a.e.-proper, so `R ∩ ω(v′) = ∅` when `c ∈ P_cl(v′)`, and `cl R ∩ ω(v′) ⊆ {v}`, already a
contact of `c` at `v′` with the side the merged tile keeps (the `c`-tiles at `v` all lie on one side of `ω(v′)`, N3-CONF read at `v′`). ∎

*Iteration.* In any bounded region, merge while some colour has two non-adjacent sectors at a vertex with `int D_c ≠ ∅`. Each step lowers
`Σ_v Σ_c (#c-sectors at v − 1)` by one, creates no repeated colour at a new point, and changes no other `D_c`; it stops. Where it stops, every
vertex either is cubic (each colour one sector; at most three colours, NB-4 / S–V Lemma 2) or holds a colour in Woodall's cone (§2.3).

*Scope and a precision for A5's card 5.* `[SokolovVoronov2025]` Props. 7–8 (FS106-V: TRUE, two repairs, polygons) reduce a vertex's degree by filling
the tip of a sector flanked by one colour. W-MERGE is that reduction for maps whose arcs are circular of radius `≠ 1` or straight, with a different
proof (the allowed cone, not a triangle); it needs no tightness and holds whether or not the colouring is tight. It is also Townsend's simplification
(c) filled, outside the cone, as FS106-V3 read Woodall's step 3 (l. 530–534): now with a proof in the a.e. map setting.

### 2.3 N3-DEG: where merging can fail — Woodall's cone

`D_c(v)` is an intersection of closed half-planes through `v`; `int D_c(v) = ∅` makes it a line or a ray (not `{v}`: `c ∈ P_cl(v)` has a sector).
Then two contacts bound it from opposite sides at one line `±a`, i.e. at `N` and `S′`: (in at `N` or out at `S′`) and (out at `N` or in at `S′`).
In and out at one point: impossible (N3-CONF). In at `N` and in at `S′`: every `c`-sector lies in `B̄(N,1) ∩ B̄(S′,1)`, whose only point near `v` is
`v`: impossible. So **out at `N` and out at `S′`** — `c`-tiles outside `B(v, 1)` tangent to `ω(v)` at both `v ± n` — and every `c`-sector at `v` lies
outside `B(N,1) ∪ B(S′,1)`, the double horn `|y| ≤ x²/2`: cusp horns along `±a` with `−1 ≤ κ₁ < κ₂ ≤ 1`, and **strictly** `−1 < κ₁`, `κ₂ < 1` by
Condition 5 (an arc of curvature exactly `±1` tangent to `a` at `v` lies on `ω(N)` or `ω(S′)`). This is `[Woodall1973]` step 3's "cone" ("unless X
and Y are completely contained within the “cone” outside two unit discs touching each other at P", as FS106-V3 quotes it), now derived as the only
exception.

*Inside the cone, partial [hand, one mind, a sketch]:* (i) two `c`-horns along the **same** ray `a`, with other colours' horns between them, merge:
a unit circle through a point `t` of the middle horns either crosses the stack transversally or is tangent to `a` at curvature `±1`, outside the
horns' `(−1, 1)`, and then passes above or below `v` and crosses a `c`-horn — so `t` is clear (the flank argument of S–V Prop. 7). (ii) A horn flanked
on both sides by one colour `b` is shaved into `b` by the same argument. **What survives:** `c`-horns along both `+a` and `−a`, the two gaps between
them half-planes (angle `π`, where Prop. 7's triangle does not exist), each shadowed near `v` by the out-type `c`-tile at `N` or `S′` (the circles
`ω(p)`, `p ∈ T_±`, sweep the gap: `y = h + (x − X)²/2` for `p = N + (X, h)`). The `+a` horn's own circles force the tile at `N` above
`y = 1 + κ₂X²/(2(1 − κ₂))` on `X > 0` (C4) — a constraint, not a contradiction.

### 2.4 N3-P17: the purely rotating ring dies under Condition 5 — a correction to N2-HEX's closing remark

N2-HEX (stage 4) proved that a purely rotating ring forces `u` regular (three sectors of 120°) and remarked "the pure rotating ring is locally
consistent". **Under Condition 5 that remark is false** (it stands without Condition 5). *Proof, through this record's tools.* Let `x₁, x₂` be
consecutive rotation points served by one sector of `u`, colour `g` (N2-HEX's count). By N2-ROT and NB-4, `P_cl(x₁) = {p, q, g}` and `g` fills the
outward cone at `x₁`, bounded by the tangents of `ω(x₂)` and `ω(x₆)` at `±30°` (C5). The cone's `g`-tile is outer to `x₂`'s `g`-tile (N-E2: it has
points outside `B̄(x₂, 1)`), and then **every** `g`-tile at `x₁` is (one Siamese and one outer would put `x₂`'s tile on `ω(x₁)`). So the sector across
the `ω(x₂)`-tangent ray is not `g`, not `p` (its allowed directions are `[150°, 330°]`), not `r`: it is `q`, confined to `B̄(x₂, 1)`. The arc of `Γ`
between them leaves `x₁` tangent to `ω(x₂)` with curvature `≠ 1`: bending into `B(x₂, 1)` it puts `g` points there; bending out (or straight) it puts
`q` points outside `B̄(x₂, 1)`; a `q`-horn instead would need curvatures `> 1` and again bend the `g` side in. Contradiction in every case. ∎ This is
`[SokolovVoronov2025]` Prop. 17 (FS106-V: "TRUE after two repairs"), re-derived; two derivations. It needs three sectors at `u` (N2-HEX's count);
at a bowtie `u` it is open — but a bowtie with `int D_c ≠ ∅` is merged first (W-MERGE).

### 2.5 N3-RED and the verdict on W-3

**N3-RED.** Let a tight six-map in `𝓜_K` satisfy Condition 5, and let `U` be a disc of radius 3. Run W-MERGE at every vertex within distance 1 of
`U`. If no vertex there is left in Woodall's cone, the result is a valid (full, a.e.-proper) six-colouring of `U` by a **cubic** map satisfying
Condition 5 — exactly the hypothesis of `[SokolovVoronov2025]` Cor. 1 (`χ_{map+fa+cubic}`), which FS106-V found "stands repaired at the same grade
with the same edge case" (one mind; the edge case: two same-multicolour points of Lemma 4 antipodal on `ω(u)`, `d = 2`; Lemma 3 at `√3 ≤ d < 2` a
sketch; every step region-only, row 132). Its Lemma 4 is local to a disc of radius 3 ("all reasoning remains valid if we consider the interior of a
circle of radius 3", p. 26). **So every disc of radius 3 of such a map contains a hard Woodall-cone vertex, or the merged map realises S–V's
`d = 2` configuration there.** ∎ Neither windings, N2-TRANS nor N2-FLIP is used: they are consequences, and the reduction bypasses them.
*Where six is spent:* S–V's count of multicolours (ten of `C(6,3)/2`, plus one) and Lemma 2; W-MERGE spends nothing. *Seven-colour control:* the
tight hexagonal seven-colouring is cubic, satisfies Condition 5, and W-MERGE leaves it unchanged; there a trivalent vertex's circle carries four
colours, so S–V's three-colour ring analysis (Lemma 5 onward) and its multicolour count do not start, as required. *Townsend's ⅔π sector:* it lives on a unit arc, outside Condition 5.

**Verdict on W-3 (does a winding map exist?): GAP, at two named steps; NO given both.**
- **G-CONE:** a tight six-map under Condition 5 with a vertex `v` where a colour `c` has cusp horns along both `+a` and `−a`, `c`-tiles tangent to
  `ω(v)` from outside at both `v ± n`, horn curvatures in `(−1, 1)`, and neither gap clear — not excluded. (Same-ray stacks and one-colour-flanked horns
  are removable, §2.3.)
- **G-d2:** S–V's own edge case for cubic maps (FS106-V, open since FS-106).
- Grade of the NO given G-CONE and G-d2: [hand, one mind for W-MERGE and N3-DEG] over FS106-V's [hand, one mind] repair of S–V's cubic chain.
- A NO would answer the Condition-5 half of S–V Question 2 almost everywhere at bounded `K` — partial, as the brief says.

**What the construction side must do, read from this (a prediction, not a hint of route):** any winding map it builds has a hard Woodall cone in
every disc of radius 3, or realises `d = 2` after merging.

### 2.6 Registered (G21 instruments, scored at the close)

| id | prediction | probability |
|---|---|---|
| N3-P1 | G-CONE closes: no tight six-map under Condition 5 has a hard Woodall-cone vertex | 0.65 |
| N3-P2 | G-d2 closes for tight six-maps under Condition 5 | 0.6 |
| N3-P3 | no winding map given by formula is produced this round | 0.95 |
| N3-P4 | a blind verifier of W-MERGE finds it TRUE, possibly with a repair at the cusp-end clearance (N3-UP) | 0.75 |

## Stage N3-2 — SAVED

## § Continuation — FS110-N4

*Job FS110-N4, de Bruijn (Opus 5.5), 2026-09-27. Briefs: `data/fs110/briefs/N4-110-round4.md` (wins where the two differ) and
`data/fs110/briefs/N110-proof.md`, with `STANDING-RULES.md`. Round 4, the `d = 2` seam W-4 (`data/fs110/claims.md` §8 with its update). I continue this
record and rewrite none of its verdicts. Object LIM unless marked. Working files `data/fs110/fs110-n/`; scratch `scratchpad/fs110-n4/` (the brief says
`fs110-n3/`, a carried name; mine is a fresh session scratchpad).*

### N4: the pre-round answer (sent to "main" before stage N4-1 was saved; retractions counted from here)

"Expected failing step: "the cone survives every local reduction". I expect the construction side can build a Woodall-cone vertex that is hard in
N3's sense (neither gap clear for a merge) — that is cheap — but not an irreducible one. I expect every cone vertex given by formula to lose its
repeated colour by recolouring one horn tip near the vertex with a flank colour, unless both flank colours carry tangent horns at the antipodes
v ± n; and then those antipodes must themselves be cone vertices, so the obstruction propagates along the normal line through v, where I expect it
cannot close up. What would show me wrong: a fragment given by formula and checked exactly with a cone vertex v at which every point of both
c-horn tips lies at unit distance from tiles of BOTH flank colours, while an antipode v ± n is not itself a cone vertex (its repeated colour
mergeable), or the chain along the normal line closes at finite length. G-d2: no firm expectation yet. I expect it to sit in the same contact
calculus at the antipodes (contact types (in, out) where G-CONE has (out, out)) but to need a different argument; I register nothing on it now."

### N4: theorems this continuation proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N4-SHADOW | the shadow at `v` (on the `+a` side, near `v`) of a tile at `N = v + n` lying beyond an arc tangent to `a` at `N` with centre `C` on the normal line is exactly the `N`-side of the circle through `v` centred at `C`; concentric curvature `f(λ) = λ/(1+λ)` going down, `f̃(υ) = υ/(1−υ)` going up | [hand, one mind; exact check C1–C2, `tools/fs110_n_shadow.py`] | stage N4-2, §2.1 |
| N4-FLANK | a horn of `c` along `a` at `v` with flanks `g` (above), `h` (below) is shadowed by a flank colour only through out-type `g`-tiles at `S′` tangent to `a` (shadow below `σ_g`) and out-type `h`-tiles at `N` tangent to `a` (shadow above `σ_h`) | [hand, one mind] | §2.2 |
| N4-SHAVE | the horn tip can be recoloured by its flanks (valid, Condition 5, `Φ(v)` down by one) unless `σ_h < σ_g` with both inside the horn (doubly shadowed); `g = h` never blocks | [hand, one mind] | §2.2 |
| N4-RAY | two `c`-horns on one ray at `v` merge (the horns between them are `c`-clear near `v`) | [hand, one mind; N3 §2.3 (i) completed; the escape bound in the second-order model] | §2.3 |
| N4-STUCK | at a vertex admitting no MERGE, MERGE-RAY or SHAVE, a colour `c` with two sectors has exactly two horns `±a`, the vertex has degree 4 (`g` above, `h` below), `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}`, and `h` has two sectors at `N`, `g` two at `S′` | [hand, one mind] | §2.4 |
| N4-PROP | in a terminal map a stuck vertex `P_0` forces stuck vertices `P_k = P_0 + kn` for all `k ∈ ℤ`, cone colours `a_k`, type `{a_{k−1}, a_k, a_{k+1}}` | [hand, one mind] | §2.5 |
| N4-FIN | no bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`: upward at most `1/υ` steps when `υ > 0`, downward at most `1/\|λ\|` when `λ < 0` | [hand, one mind; exact check C3] | §2.6 |
| N4-TERM | every valid map has a terminal valid modification (all vertices, whole plane; each point changed finitely often) | [hand, one mind] | §2.7 |
| N4-CONE | **in a terminal valid map no colour has two sectors at any vertex: every vertex is cubic (sectors possibly cusp horns). G-CONE is closed.** | [hand, one mind, over NB-4 (two minds, one blind), W-MERGE (two, one blind), N3-DEG (one)] | §2.8 |
| N4-HEX | in S–V's `d = 2` configuration (antipodes `p_±` of a trivalent `u`, one type `{α, β, i}`): of `σp_+, σ²p_+` (and of `σ⁻¹p_+, σ⁻²p_+`) not both are tile points; if both antipodes are ring change points, all four are, the antipodes change the same way, and each side carries pattern R or R′; R–R dies (N2-HEX, N3-P17), R′–R′ dies ((in, in)); mixed and non-change antipodes undecided | [hand, one mind; over N2-SWAP, NB-5] | stage N4-3 |
| N4-RED | every tight six-map in `𝓜_K` under Condition 5 has a valid cubic modification on the whole plane; N3-RED's residue is G-d2 alone, and the base must hold for cubic maps whose sectors may be cusp horns | [hand, one mind, over FS106-V's repaired S–V Cor. 1] | §2.8 |

### N4: would-have-searched-here log

| move I would have made by search | what I did instead |
|---|---|
| enumerate horn stacks at `v`, `N`, `S′` (curvatures, colours) to see which cones survive every local recolouring | derived the shadow rule (concentric circles), the stuck structure and the chain; checked the identities at named values (C1–C3) |
| sample chains of curvatures along the normal line to find a long consistent one | proved N4-FIN by the reciprocal recursions `1/f̃(x) = 1/x − 1`, `1/f(x) = 1/x + 1` |

### N4: fence log

1. My first command, run before reading the brief, was `ls data/fs110/briefs/ data/fs110/reports/`: it printed the **file names** of every brief and
   every report. Names only; no fenced file opened, read or grepped. (`data/fs110/reports/` is fenced by the original brief; round 4 names my report
   path inside it, so I write `FS110-N4.md` there and open nothing else.)
2. `git log --oneline -3` (run at the quotation check) printed three subjects **newer than the start-up snapshot**: `70ad1ea1` "FS-110: inventory",
   `24974367` "FS-110: inventory time", `38bf7ef1` "Ranking pass brief; Kooshi's approvals logged". Subjects only; nothing opened.
3. `git status --short` printed untracked **names** under `data/fs110/fs110-cd/`, `data/fs110/fs110-y/` (files `y4_cone_*.out`), `tools/fs110_cd_checks.py`,
   `tools/fs110_y_cone.py`, and a modified `plans/FS110-CD-verification.md`. Names only; not opened. (The names say the construction side is working a
   cone; nothing of its content reached me.)
4. Read, not fenced: `plans/FS110-PA-prior-art.md` l. 84–92 (open to me by the brief); `plans/FS106-V-verification.md` l. 252, 256, 525–556 (FS-106's
   record: SV-L4, SV-2, Woodall's step 3, the `d = 2` stretch); `[SokolovVoronov2025]` (held PDF; my extraction `scratchpad/fs110-n4/sv.txt`, §7, §8,
   Appendix proof of Lemma 4).

## Stage N4-1 — SAVED: quotation check, Condition 5, reading

**Quotation check (standing rule 5).**

| quotation in my brief | source | result |
|---|---|---|
| Condition 5, "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden." | `[SokolovVoronov2025]` p. 4 (my extraction l. 148–150) | verbatim; the print prefixes the label "(fa = “forbidden arcs”)" |
| the claim list's gloss "no boundary arc of radius 1" | `data/fs110/claims.md` §7 ("Under Condition 5 (no boundary arc of radius 1)") | verbatim |
| N3-DEG and N3-RED as quoted in claims §8 | this record, § Continuation — FS110-N3, theorem table | verbatim, both rows |
| W-4 (brief, in bold, unquoted): "can a hard Woodall cone, or the `d = 2` configuration, occur in a tight six-map in `𝓜_K` under Condition 5?" | claims §8: "In a tight six-map in `𝓜_K` under Condition 5, can a hard Woodall-cone vertex (G-CONE), or S–V's `d = 2` configuration (G-d2), occur? Are the two one configuration, decided by one argument?" | the brief's is a paraphrase, same content; I work the claim list's |
| "hunch: one" (brief, "the card in §8") | claims §8 | **not in §8 as filed**; §8 asks the question ("Are the two one configuration …?"); the phrase is not checkable (the card is the advisor's, fenced) |
| CB's three theorem lines (claims §8 update) | `plans/FS110-CB-verification.md` | fenced; not checkable; used only as quoted |
| "Condition 5 without Condition 6 unsettled, unstated and unasked in print" (brief, on FS110-PA) | `plans/FS110-PA-prior-art.md` l. 88–89: "S–V **state no result and ask no question about Condition 5 without Condition 6.** … the Condition-5-only case is its sub-case, unasked." | the brief's summary; matches in substance |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim (checked by FS110-N) |

**Which Condition 5 I use.** The print's form. In `𝓜_K` it coincides with the gloss (N3-1, this record: a unit circle meets a straight or circular
arc of radius `≠ 1` in at most two points, and meets finitely many arcs). **The same proof covers every map I build below** (locally finite, arcs
circular or straight): my modifications add circular arcs of radius `ρ < 1` or of radius `|C| ≠ 1` (§N4-2), never radius 1, so the print's
Condition 5 holds for them. They may leave `𝓜_K` in one respect only — new arcs of small radius `ρ < 1/K` — which no statement below and no step
of S–V's chain uses (S–V's hypotheses are Conditions 4–7; no radius bound).

**Reading done for this round (G50, per section).** `[SokolovVoronov2025]`: Cor. 1 and Theorem 1 (§3), Lemma 3 (§6, statement and proof),
Lemma 4 (§7 statement; Appendix proof), §7.1 (Props. 14–17, Lemma 5, Lemma 6 statements), §8, §9 — read first-hand. `plans/FS106-V-verification.md`:
SV-L4 row (the `d = 2` residual, item (c)), SV-2 row, "A tool for SV-1's open step" (Woodall's step 3 and the cone), the `d = 2` stretch.
`plans/FS110-PA-prior-art.md` §S–V finding (l. 84–92). Woodall 1973 §3 not re-read this round (N3 quotes FS106-V3's reading of the cone).

## Stage N4-1 — SAVED

## Stage N4-2 — SAVED: G-CONE closed — the shave, the stuck vertex, the chain along the normal line, a terminal map

*Setting of this stage.* A **valid map**: a full a.e.-proper six-colouring by a locally finite map whose arcs are straight or circular with one-sided
tangents, and the print's Condition 5 (no arc of radius exactly 1; N4-1). Every `𝓜_K` map is valid; every operation below keeps a map valid. WLOG every
arc separates two different colours (an arc with one colour on both sides is deleted; the colouring is unchanged). NB-4 (`≤ 3` colours at every
point; two minds, one blind; `[SokolovVoronov2025]` Lemma 2) holds for every valid map. **Tightness is never used.** At a vertex `v`: `s_c(v)` is the
number of `c`-sectors, `Φ(v) = Σ_c (s_c(v) − 1)⁺`. Frame: `n` a unit vector, `a ⊥ n`, `P_k = v + kn` (`N = P_1`, `S′ = P_{−1}`); an arc tangent to
`a` at `P_j` is a circle (or line) with centre `v + Cn` on the normal line, of **upward curvature** `1/(C − j)` at `P_j` (positive: bending toward
`+n`). The **shadow** of a tile `T` is `Sh(T) = {z : ω(z) ∩ T ≠ ∅} = {z : dist(z, T) < 1 < sup_{p∈T} |z − p|}`; N-E0 says a tile never meets the
shadow of a tile of its own colour.

### 2.1 N4-SHADOW: the shadow of a tangent tile is a concentric circle [hand, one mind]

*Let `T` be a tile with `N ∈ cl T`, `T ∩ B̄(v, 1) = ∅`, whose boundary near `N` on the `+a` side contains an arc `A` tangent to `a` at `N`, with
`T` on the far side of `A` (away from `v`); let `v + Cn` be `A`'s centre (`C = ∞` if `A` is straight). Then for `z` in a small neighbourhood of `v` with
`(z − v)·a > 0`, the part of `T` near `N` shadows `z` iff `z` lies strictly on the `N`-side of the circle `Σ(C)` through `v` centred at `v + Cn`.*

*Proof.* Out-type forces `A`'s upward curvature at `N` above `−1` (the curvature of `ω(v)` there; `≠ −1` by Condition 5), so `C > 1` or `C < 0`
(`C = 0` is an arc of radius 1: excluded). If `C > 1`, the far side of `A` is inside `A`'s circle (radius `C − 1`), `z` is outside it, and the distance
from `z` to the far side is `|z − (v + Cn)| − (C − 1)`: it is `< 1` iff `|z − (v + Cn)| < C = |Σ(C)|`'s radius, i.e. `z` inside `Σ(C)`, which near `v` is the
`N`-side. If `C < 0`, the far side is outside `A`'s circle (radius `1 − C`), `z` is inside, the distance is `(1 − C) − |z − (v + Cn)|`, `< 1` iff `z` is
outside `Σ(C)` (radius `−C`): again the `N`-side. `C = ∞`: the distance is `1 − (z − v)·n`. In every case the nearest point lies on `A`'s circle on the ray
from the centre through `z`, at positive `a`-coordinate (C1 checks this at named points), so on `A` itself, where `T` lies on the far side; and
`sup |z − p| > 1` since `T` has points beyond `ω(v)`. ∎ The same holds reflected (`S′`, below) and shifted (`P_{j+1}` over `P_j`). **Curvature bookkeeping
(C2):** an arc at `P_{k+1}` of upward curvature `λ` gives at `P_k` the concentric circle of curvature `f(λ) = λ/(1+λ)`; an arc at `P_{k−1}` of curvature
`υ` gives at `P_k` curvature `f̃(υ) = υ/(1−υ)`; `f̃ = f⁻¹`; `1/f(x) = 1/x + 1`, `1/f̃(x) = 1/x − 1` (the centre stays put; the radius changes by 1).
*A tile at `N` whose directions at `N` stay an angle `θ₀ > 0` away from `±a` shadows near `v` only points with `|z − S′| < 1`... reflected: only points
inside `B(N, 1)`* — for `p − N = r e_φ` with such `φ`, `(p − N)·(z − N) < 0` for `z` near `v`, so `|z − p| > |z − N|`.

### 2.2 N4-FLANK and N4-SHAVE [hand, one mind]

*Setting.* `c` has a horn `H` along `+a` at `v`, between arcs of upward curvatures `κ_− < κ_+`, `−1 < κ_− < κ_+ < 1`; the tile directly above `H`
has colour `g`, directly below `h`; `g, h ≠ c`.

**N4-FLANK.** *For `k ∈ {g, h}`, the points of `H` near `v` in `Sh(C_k°)` are: for `g`, the points below `Σ(C)` for the out-type `g`-tiles at `S′`
tangent to `a` on the `+a` side (their union: below the circle of largest curvature `σ_g`); for `h`, the points above `Σ(C)` for the out-type `h`-tiles
at `N` tangent to `a` on the `+a` side (above the circle of least curvature `σ_h`); and `σ_g ≤ κ_+`, `σ_h ≥ κ_−`.*
*Proof.* A `k`-tile whose shadow reaches points arbitrarily near `v` has `dist(v, T) ≤ 1 ≤ sup|v − p|`; equality on both sides fails (else `T` would
cross `ω(v)`, against N-E1, `k ∈ P_cl(v)`), so `T` touches `ω(v)` at a contact `w` (N3-CONF: in- or out-type). `+a ∈ D_k(v)` (the flank sector has `+a`
in its closure), so for `w ≠ N, S′` the direction `+a` is interior to `w`'s half-plane and N3-CLEAR clears a neighbourhood of `H`'s tip. At `N` and `S′`:
in-type `g` at `N` or at `S′` would be Siamese with the flank sector (N-E2), which has points just above `κ_+ ∈ (−1, 1)`, outside both `B̄(N, 1)` and
`B̄(S′, 1)`: impossible. Out-type `g` at `N` shadows an upward-closed set (N3-UP reflected) that must miss the flank sector, hence misses `H`. Out-type
`g` at `S′`: by §2.1 its shadow near `v` is below a concentric circle if it is tangent to `+a` there, and inside `B(S′, 1)` (missing `H`, whose points
satisfy `|z − S′| > 1`) otherwise; missing the flank sector gives `σ_g ≤ κ_+`. `h` is the mirror image. ∎

**N4-SHAVE.** *If `g = h`, or `σ_g ≤ σ_h` (an absent shadow read as `σ_g = κ_−`, `σ_h = κ_+`), the tip `H ∩ B(v, ρ)` (small `ρ`) is recoloured: below
the circle `Σ` of curvature `σ_h` by `h`, above it by `g` (all by `g` if `g = h`). The result is valid, `s_c(v)` drops by one, no sector is added at `v`,
and the new points on `∂B(v, ρ)` are corners or a cubic vertex `{c, g, h}` of positive angles.* *Proof.* The lower part lies outside every `h`-shadow
(N4-FLANK: those are above `σ_h`), the upper part outside every `g`-shadow (below `σ_g ≤ σ_h`); for `g = h`, `σ_g ≤ κ_−` and `σ_h ≥ κ_+` (the flank on the
other side), so `H` is clear. New arcs: `Σ` (radius `|C_h| ≠ 1`, since `σ_h ∈ (−1, 1)`) and `∂B(v, ρ)` (radius `ρ < 1`); Condition 5 holds. ∎
**Doubly shadowed:** `σ_h < σ_g` with `σ_h ∈ [κ_−, κ_+)`, `σ_g ∈ (κ_−, κ_+]`. Then every point of `H` between the two circles is in the shadows of `g`,
of `h` and of every ring colour (ring tiles cross `ω(v)`, so a neighbourhood of `v` is in their shadows): no recolouring near `v` removes `c` there.

### 2.3 N4-RAY: two `c`-horns on one ray merge [hand, one mind; N3 §2.3 (i) completed]

*If `c` has two horns along `+a` at `v`, the region `M` between them (other colours' horns) is `c`-clear near `v`; recolouring `M ∩ B(v, r)` with `c`
merges them.* *Proof.* Let `t ∈ M`, `|t − v| < r`, and `ω(p)` a unit circle through `t`. Follow `ω(p)` from `t`. It cannot stay in the stack of horns
out to `∂B(v, ρ)` when `r ≪ ρ`: in the second-order model the stack is `κ_1x²/2 < y < κ_4x²/2` with `−1 < κ_1 < κ_4 < 1`, and a curve of curvature
`±1` through a point at `x_t ≪ ρ` inside it leaves it before `x = ρ` (at `x = ρ` it is `≈ ±ρ²/2` off its tangent line, outside `[κ_1, κ_4]ρ²/2`
unless its lowest or highest point lies at `x ≍ ρ`, where it is already below `κ_1x²/2` or above `κ_4x²/2`). It cannot leave `M` through `v` (a curve
through `v` from inside the stack would be tangent to `a` with curvature `±1`, outside the stack near `v`). So it leaves `M` through a boundary arc of `M`
at a point `q ≠ v`; there it crosses into the adjacent `c`-horn, because a circle and an arc of different curvature that are tangent at `q` do not
cross there. So `ω(p)` meets a `c`-tile and `p` is not in one: `t` is clear. ∎ `Φ(v)` drops; new points are corners or cubic of distinct colours.

### 2.4 N4-STUCK: the structure of a vertex no operation reduces [hand, one mind]

*Let `v` be a vertex of a valid map at which none of MERGE (W-MERGE), MERGE-RAY, SHAVE applies, and let some colour `c` have `s_c(v) ≥ 2`. Then:*
- *(i) `int D_c(v) = ∅` (no MERGE), so N3-DEG: out-type `c`-contacts at `N`, `S′`, all `c`-sectors horns along `±a` with curvatures in `(−1, 1)`;
  one per ray (no MERGE-RAY); each doubly shadowed (no SHAVE), with flanks `g_±` above, `h_±` below, `g_± ≠ h_±`.*
- *(ii) `g_+ = g_− =: g`, `h_+ = h_− =: h`, `P_cl(v) = {c, g, h}`, and `v` has degree 4: `H_+`, one `g`-sector filling the side `(z − v)·n > 0`, `H_−`,
  one `h`-sector filling the other side.*
- *(iii) `g`'s only contacts on `ω(v)` are out-type at `S′`; `h`'s only out-type at `N`; `c`'s out-type at `N` and `S′`.*
- *(iv) `P_cl(N) = {c, h, r}` with `r` one colour outside `P_cl(v)`; every tile at `N` meeting `B̄(v, 1)` has colour `r`; and `h` has at least two sectors
  at `N`, one tangent to `+a`, one to `−a`. Mirror: `P_cl(S′) = {c, g, r′}`, `g` has two sectors at `S′`.*

*Proof.* (ii) Doubly shadowed gives an out-type `h_±`-tile at `N` and an out-type `g_±`-tile at `S′` (N4-FLANK), so by N3-CONF all `h_±`-sectors lie in
`{d·n ≤ 0}` and all `g_±`-sectors in `{d·n ≥ 0}`. NB-4: `P_cl(v) = {c, g_+, h_+} = {c, g_−, h_−}`. If `g_− = h_+`, that colour has contacts of both kinds
(out at `N`, out at `S′`), so its sectors are horns along `±a`; then `h_+ = g_−` has no sector of positive angle, `c` neither, and `g_+` would fill both
open half-planes of directions, against `{d·n ≥ 0}`. So `g_− = g_+`, `h_− = h_+`. Every direction with `d·n > 0` lies in a sector of `g` (not `c`, not
`h`); above `H_+` in the stack there is no `h` (it would be in `h`'s shadow, above `σ_h < κ_+`) and no second `c`; so all of it is `g`, one sector; the
same below with `h`. (iii) `D_g(v)` contains the open half-plane `{d·n > 0}`, so each `g`-contact's half-plane is `{d·n ≥ 0}`: in-type at `N` (Siamese
with the `g`-sector, which is not in `B̄(N, 1)`: impossible) or out-type at `S′`. `c`: `D_c(v)` is the line `±a`. (iv) A tile at `N` of colour `g`
would be a `g`-contact at `N`: excluded by (iii). `h` and `c` at `N` are out-type only (iii). A tile at `N` meeting `B̄(v, 1)` is in-type or crosses `ω(v)`:
its colour is outside `P_cl(v)` (N-E1). The two arcs of `ω(v)` leaving `N` lie in tiles at `N` (Condition 5: `Γ ∩ ω(v)` is finite), so some ring colour
`r` is at `N`; with `c` and `h` (the tangent out-type `h`-tiles `Q_±` shadowing `H_±`), NB-4 gives `P_cl(N) = {c, h, r}`. Order the sectors at `N`
counter-clockwise: the side `(z − N)·n < 0` and the slots of the `±a` stacks at or below `ω(v)` are `r`; `Q_+` sits in the `+a` stack, `Q_−` in the
`−a` stack. Every `c`-sector at `N` lies in `{d·n ≥ 0}` (the horns `H_±` are an out-type `c`-contact of `N` at `v`), and one in the `+a` stack below
`Q_+`'s lower arc would shadow `H_+` above `f(·) < σ_h < κ_+` (§2.1), against N-E0; likewise on `−a`. So going from `Q_+` to `Q_−` over the top one meets
`c`, and going back under the bottom one meets `r`: `Q_+` and `Q_−` are different `h`-sectors. ∎

### 2.5 N4-PROP: a stuck vertex forces a stuck chain along the normal line [hand, one mind]

*Call a valid map **terminal** if no MERGE, MERGE-RAY or SHAVE applies at any vertex. In a terminal map, if `P_0 = v` is as in N4-STUCK (cone colour
`a_0 = c`, `a_{−1} = g` above, `a_1 = h` below), then for every `k ∈ ℤ` the point `P_k` is a vertex as in N4-STUCK with cone colour `a_k`, the colour
`a_{k−1}` filling its `+n` side, `a_{k+1}` its `−n` side, horns along `±a`.*
*Proof (step `k = 0 → 1`; the rest is induction and the mirror).* By N4-STUCK (iv), `h` has two sectors at `N`; terminal gives no MERGE there, so
`int D_h(N) = ∅` and N3-DEG applies at `N`. `v` is an out-type `h`-contact of `N` (the `h`-sector below `v` lies outside `B̄(N, 1)`), so the degenerate
`D_h(N)`, a line inside `{d·n ≥ 0}`, is `±a`: the cone at `N` has the same axis. Terminal gives no MERGE-RAY and no SHAVE at `N`, so N4-STUCK holds at `N`
with cone colour `h`; its `−n` side at `N` is the colour of the tiles at `N` meeting `B(v, 1)`, i.e. `r`, and its `+n` side is the remaining colour of
`P_cl(N) = {c, h, r}`, i.e. `c`. So `a_1 = h` with `a_0 = c` above and `a_2 = r` below. ∎ (The types `{a_{k−1}, a_k, a_{k+1}}` have any four consecutive
colours distinct, by N-E1 at `P_k` and the ring colour at `P_{k+1}`.)

### 2.6 N4-FIN: the chain cannot be bi-infinite [hand, one mind; exact check C3]

Let `λ_k < υ_k` be the upward curvatures at `P_k` of the lower and upper arcs of the `+a` horn of `a_k`; `−1 < λ_k < υ_k < 1` (N3-DEG). Two
inequalities hold along the chain:
- `λ_k ≤ f(λ_{k+1})`: the `a_{k+1}`-horn at `P_{k+1}` is out-type relative to `P_k` (its curvatures exceed `−1`, that of `ω(P_k)` there), so by §2.1 it
  shadows at `P_k` everything above the circle of curvature `f(λ_{k+1})`; the `a_{k+1}`-sector on the `−n` side of `P_k` reaches up to the arc `λ_k`, and
  N-E0 keeps it out of that shadow.
- `f̃(υ_{k−1}) ≤ υ_k`: the mirror — the `a_{k−1}`-horn at `P_{k−1}` shadows at `P_k` everything below curvature `f̃(υ_{k−1})`; the `a_{k−1}`-sector on the
  `+n` side of `P_k` reaches down to the arc `υ_k`.

**N4-FIN.** *No sequence indexed by `ℤ` satisfies these.* If some `υ_m > 0`, then `υ_{m+1} ≥ f̃(υ_m) > 0` and `1/υ_{m+1} ≤ 1/υ_m − 1`; after more than
`1/υ_m − 1` steps `υ > 1`: impossible. So every `υ_k ≤ 0`, hence every `λ_k < 0`, and then `λ_{k−1} ≤ f(λ_k) < 0` gives `1/λ_{k−1} ≥ 1/λ_k + 1`;
after more than `−1/λ_m − 1` steps down `λ ≤ −1`: impossible. ∎ (Upward the chain has at most `⌈1/υ⌉` steps when `υ > 0`; downward at most `⌈1/|λ|⌉`
when `λ < 0`; C3 runs the extremal recursions at named values.)

### 2.7 N4-TERM: every valid map has a terminal modification [hand, one mind]

Each operation at `v` (MERGE, MERGE-RAY, SHAVE) is supported in `B(v, ρ)`, with `ρ < 1` below a third of the distance from `v` to every other vertex
of the current map (and below the operation's own clearance radius); it lowers `Φ(v)` by at least one, changes no sector at any other existing vertex,
and creates only corners and cubic vertices with distinct colours (`Φ = 0`), which no operation ever touches (later supports shrink by a factor 3). So
`v` is operated on at most `Φ_0(v)` times, whatever else happens. Enumerate the vertices of the original map `v_1, v_2, …`; at each stage apply an available
operation at the least-index vertex that has one. Each point of the plane lies in the support of finitely many operations (local finiteness), so the
colourings converge pointwise to a map `M*` that agrees on every bounded set with a finite stage — hence is valid, locally finite, circular or straight,
Condition 5. `M*` is terminal: whether an operation is available at `v_i` depends on the map in `B(v_i, 3)` only (sectors at `v_i`, contacts on
`ω(v_i)`, the tiles at `P_{±1}`); that ball is frozen after a finite stage `n_0`; if an operation were available at `v_i` in `M*`, it would be available at
every stage after `n_0`; the vertices `v_1, …, v_{i−1}` are chosen only finitely often, so `v_i` would be chosen infinitely often — more than `Φ_0(v_i)`
times. ∎

### 2.8 The verdict on G-CONE, and what it does to N3-RED

**N4-CONE.** *In a terminal valid map no colour has two sectors at any vertex; with NB-4, every vertex is cubic (three colours, one sector each; a sector
may be a cusp horn) or a corner.* *Proof:* a vertex with a repeated colour is as in N4-STUCK; N4-PROP gives a chain over all of `ℤ`; N4-FIN forbids it. ∎

**G-CONE: CLOSED (NO) [hand, one mind]**, in the form N3-RED needs: a hard Woodall-cone vertex may occur in a given map, but it is never an obstruction —
N4-TERM removes every repeated colour on the whole plane. **N4-RED:** every tight six-map in `𝓜_K` under Condition 5 (indeed every valid map) has a valid
modification `M*` that is cubic at every vertex and satisfies the print's Condition 5 and local finiteness (arcs may have radius below `1/K`; no step of S–V
uses a radius bound). So `[SokolovVoronov2025]` Cor. 1 applies to `M*` in every disc of radius 3, and N3-RED's residue is **G-d2 alone** (reported possibly
vacuous by FS110-CB, one mind). **Scope condition carried to the base, named:** `M*` may keep cusp horns at cubic vertices (a single horn whose flanks both
shadow it); N3-RED's own hand-off had the same property. FS106-V's repaired Cor. 1 and CB's AE Cor. 1 must be read for cubic maps with cusp sectors
(S–V's Prop. 9 side criterion counts boundary directions, which coincide at a cusp). *A partial remedy, sketch:* a single `c`-horn at a cubic vertex with
`D_c(v)` a half-plane opens into a positive-angle sector by recolouring a thin wedge on the interior side (N3-CLEAR, N3-UP); only a single horn with
out-type `c`-contacts at both `N` and `S′` cannot be opened this way.

**Where six is spent:** NB-4 at `v` and at `N` (`P_cl = {c, g, h}`, `{c, h, r}`), and N-E1 (tiles at `N` meeting `B̄(v, 1)` carry ring colours).
N4-SHADOW, N4-SHAVE's clearness and N4-FIN spend nothing (geometry of one circle family). *Seven-colour control:* the tight hexagonal seven-colouring is
cubic with positive angles; no operation applies; N4 is silent, as required. *Townsend's ⅔π sector:* the shadow circle `Σ(C)` degenerates exactly at
`C = 0`, an arc of radius 1 at `N` (C4) — the unit arc Condition 5 forbids, where Townsend's sector lives. **Killing tests of §4:** the strip, pinhole and
Parts tests bind area arguments; N4 is not one. Killing test 3 (seven colours): above.

**G-CONE and G-d2: one configuration? NO — one calculus, two configurations, two arguments [hand, one mind].** Both put a colour of a vertex at both
antipodes of its unit circle, distance exactly 2 apart. The contact types at the antipodes classify them: **(out, out)** is G-CONE (`D_c(v)` a line, all
`c`-sectors horns); **(in, out)** is G-d2's orientation (FS106-V's stretch: `R_i` in a closed half-plane, `Rʲ` toward `u`, `Rᵏ` away); **(in, in)** is
impossible (every `c`-sector would lie in `B̄(N, 1) ∩ B̄(S′, 1) = {v}` near `v`, N3 §2.3). G-CONE is a singularity of the map and dies by surgery plus the
chain; G-d2 sits at a non-degenerate cubic vertex (`D_i(u)` has interior), where nothing merges and nothing forces a repeat at the antipodes, so N4
cannot touch it: it is a coincidence of S–V's count, and survives N4-TERM unchanged.

**Registered (G21 instruments, scored at the close).**

| id | prediction | probability |
|---|---|---|
| N4-P1 | a blind verifier finds N4-CONE TRUE, possibly with repairs at N4-RAY's escape bound or N4-TERM's limit | 0.75 |
| N4-P2 | any hard cone fragment the construction side gives by formula admits a SHAVE at one of its horns, or has an antipode that is not a cone vertex | 0.9 |
| N4-P3 | cusp horns at cubic vertices do not break FS106-V's / CB's Cor. 1 (the base extends to them) | 0.6 |

**Scoring N3's G-CONE prediction early (for the close):** N3-P1 ("G-CONE closes: no tight six-map under Condition 5 has a hard Woodall-cone vertex",
0.65) is met in the form N3-RED uses (hard cones are removable), not in the letter (N4 does not show hard cones absent from the original map).

## Stage N4-2 — SAVED

## Stage N4-3 — SAVED: G-d2, a partial constraint; one correction to stage N4-2

**Correction (free; counted as retraction 1 of round 4).** §2.1's closing sentence is garbled ("shadows near `v` only points with `|z − S′| < 1`...
reflected: only points inside `B(N, 1)`"). It should read: *a tile at `N` whose directions at `N` stay an angle `θ₀ > 0` away from `±a` shadows near `v`
only points inside `B(N, 1)`* (the proof as written: `|z − p| > |z − N|`). N4-FLANK uses exactly this (and its mirror at `S′`); no verdict changes.

*Setting (FS106-V's stretch, this record's ring terms §4.3).* `u` a vertex with `P_cl(u) = {4, 5, 6}`, `ω(u)` carrying no arc of `Γ` (Condition 5);
`p_+ = u + e`, `p_− = u − e` with `P_cl(p_±) = {α, β, i}`, `{α, β, γ} = {1, 2, 3}` the ring colours, `i ∈ {4, 5, 6}`. `σ` is the rotation by `60°` about
`u`; `A_1 = σp_+`, `A_2 = σ²p_+ = σ⁻¹p_−`, `B_1 = σ⁻¹p_+`, `B_2 = σ⁻²p_+ = σp_−`. Ring colours `c(x±)` just after/before `x` (tile points).

**N4-HEX. [hand, one mind; over N2-SWAP (one mind) and NB-5 (two, one blind).]**
- *(a) `A_1` and `A_2` are not both tile points; nor `B_1` and `B_2`.* A tile point of `ω(u) ∩ ω(p_+)` has a colour outside `{4, 5, 6} ∪ {α, β, i}`
  (N-E1 at `u` and at `p_+`), i.e. `γ`; so does one of `ω(u) ∩ ω(p_−)`; `|A_1 − A_2| = 1`, so two tile points would be a `γ`-pair at unit distance (N-E0).
  *Six is spent* in "the only colour left is `γ`"; with seven colours two are left and (a) fails, as required.
- *(b) If both antipodes are ring change points, say `(c(p_+−), c(p_+ +)) = (α, β)`: then `(c(p_−−), c(p_− +)) = (α, β)` as well, all four of `A_1, A_2,
  B_1, B_2` are change points, and each side reads one of two patterns: **R** `A_1 = (β, γ)`, `A_2 = (γ, α)` or **R′** `A_1 = (γ, α)`, `A_2 = (β, γ)` (and
  mirror on the `B` side).* Proof: a finite case table over the 60° rule (`c(x±) ≠ c(σx±)` at tile points), the tile-point rule (a tile point of `A_1`
  or `A_2` is `γ` on both sides) and "no swap" (a swap forces a covering pair at distance 1 under Condition 5, N2-SWAP, against NB-5). Every branch
  with a tile point among `A_1, A_2` ends in a swap with `p_+` or `p_−`; the orientation `(β, α)` at `p_−` leaves no admissible pair `(A_1, A_2)`; with
  `(α, β)` at `p_−` exactly R and R′ survive.
- *(c) R on both sides is dead*: every hexagon point is then `(A+, A−)` in N2-ROT's table — a rotating hexagon, which N2-HEX pins to a regular `u` and
  N3-P17 (two derivations, one of them `[SokolovVoronov2025]` Prop. 17 as repaired) kills under Condition 5. *R′ on both sides is dead*: every point is
  `(B+, B−)`, so N2-ROT puts the inward cone at `p_±` in a colour of `u`'s type, necessarily `i`, in-type at both antipodes — the impossible **(in, in)**
  (§2.8).
- **Undecided (the named GAP of G-d2 on this route):** the mixed patterns (R on one side, R′ on the other: `p_+` reads `(A+, B−)`, `p_−` reads
  `(B+, A−)`, which N2-ROT leaves free), and antipodes that are not ring change points (a colour of `{α, β}` present at `p_±` only on one side of `ω(u)`).

**Verdict on G-d2 in this job: GAP**, at the mixed patterns and the non-change antipodes. N4 neither shows it vacuous nor needs it vacuous; CB's reduction
(blind second mind running) is the route that may make it not arise. N4-HEX is offered to that check as an independent constraint: any surviving `d = 2`
pair has a ring change point of `u` at `60°` from an antipode on each side.

**Registered.** N4-P4: the mixed patterns of N4-HEX die by N2-ROT's side conditions at `A_1, A_2` together with the `i`-sector orientation (FS106-V's
(in, out)) — 0.55.

## Stage N4-3 — SAVED
