# FS110-N — the proof side of FS-110 (the tangency seam): the NO

*Job FS110-N, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/N110-proof.md` with `STANDING-RULES.md`. Claim list:
`data/fs110/claims.md` (quoted, never paraphrased). Object throughout: LIM (a full tight a.e.-proper six-colouring by a map) unless marked.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N-E0 | A-EXACT, sight form: `S(z) ∌ colour(z)` for `z` in a tile, `{z : j ∈ S(z)}` open, so `S(z) ≠ [6]` for every `z ∈ ℝ²`; the consequence holds for every family of vertices whose closure types have union `[6]` (disjointness unused) | [hand, trivial; two minds with FS110-A] | stage 1, §1.4 |
| N-E1 | A-CIRC, closure form: `u ∈ cl(T)`, `T` of colour `j` ⟹ `ω(u) ∩ C_j° = ∅`; holds for a cusp colour | [hand, trivial; two minds, different route from FS110-A's] | §1.4 |
| N-E2 | contact lemma: two same-colour tiles touching `u`, `u′` with `\|u − u′\| = 1` are Siamese (`T ⊆ B̄(u′,1)`, `T′ ⊆ B̄(u,1)`) or outer (`T ∩ B(u′,1) = ∅ = T′ ∩ B(u,1)`) — exact, whole tiles | [hand, one mind] | §1.4 |
| N-SEAM | seam-point lemma: for `P_cl(u) ∪ P_cl(v) = [6]`, `\|u − v\| < 2`, each common unit point `w₀` lies on `Γ`; every tile at `w₀` lies on one side of `ω(x)` for each `x ∈ {u, v}` holding its colour; if `w₀` is not a vertex, the arc through it is an arc of `ω(x)` for one `x`, both side colours are `x`'s, and `x` has a colour of its type in both side cones (TS-U) | [hand, one mind] | §1.4 |
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
  `A`'s angular length seen from `x`, about the two directions tangent to `ω(w₀)` at `x`); so `x`'s type has a further colour in **both** side cones — a
  colour in two sectors straddling the tangent line at `x` with margin: the claim list's **strong escape**.*

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
  centred at `u` or `v`, and that centre has a strong escape (a colour of its type in both side cones). The strong escape comes **with** a unit arc at
  `w₀`; no scale enters.
- **Case `w₀` a vertex: GAP**, at the step "the tiles at `w₀`, each on one side of `ω(u)` or `ω(v)` (N-SEAM (b)), force a double unit-arc seam". What is
  held: at `w₀`, each of the four unit directions (the tangents of `ω(u)` and `ω(v)`) is either an arc of `Γ` along that unit circle or interior to a
  tile carrying a colour of the other point only. Not yet derived: which such vertex figures are consistent with the matching contacts at `u` and `v`.
- "at positive scale" is not needed: N-SEAM is a statement on LIM with no blow-up.

**D-TYPE: TRUE (N-TYPE). A-EXACT: TRUE (N-E0). A-CIRC: TRUE, cusp check passed (N-E1). A-SIX: TRUE (N-SIX).**

## Stage 1 — SAVED
