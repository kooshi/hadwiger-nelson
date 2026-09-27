# FS112-N — FS-112's proof side (the NO): the chain walk under unit arcs, the seams, the unit-arc centre

*Job FS112-N, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `799131a2`. Brief: `data/fs112/briefs/N112-proof.md` with
`data/fs112/briefs/STANDING-RULES.md`. Claim list: `data/fs112/claims.md` (quoted, never paraphrased). Working files: `data/fs112/fs112-n/`;
exact checks: `tools/fs112_n_*.py`. Notation is FS-110's (`plans/FS110-N-proof.md` §1.3): `Γ` the boundary set, tiles the components of `ℝ² ∖ Γ`,
`P_cl(x)` the colours of tiles whose closure contains `x`, `ω(x)` the unit circle about `x`, N-E0 (no same-colour tile points at distance 1),
N-E1 (`ω(u)` meets no tile of a colour of `P_cl(u)`), N-E2 (two same-colour tiles touching points at distance 1 are Siamese or outer). A **valid**
map is a full a.e.-proper six-colouring by a locally finite map bounded by segments and circular arcs, **arcs of radius 1 allowed** (Condition 5
dropped). `𝒫` is the set of **unit-arc centres** (centres of boundary arcs of radius 1); it is locally finite (a unit arc centred in a bounded set
`D` lies within 1 of `D`, and finitely many arcs meet a bounded set).*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N112-U1 | At a unit arc `α ⊂ ω(P)` of angular length `ℓ`: an inner side colour in `P_cl(P)` has all its sectors at `P` in the closed cone of angle `π − ℓ` facing `α`; an outer one, in the cone facing away; the outer tile's shadow near `P` is, to first order, the open cone of angle `π + ℓ` facing `α` (a wedge, not a circle side) | hand, one mind (TS-U's content re-derived as a shadow statement) | stage 1, §1.3 |
| N112-SIX | A vertex with `\|P_cl(v)\| = 5` has unit arcs centred at `v` of total length `≥ 180°`; with `\|P_cl(v)\| = 6`, `ω(v) ⊆ Γ` | hand, one mind | §1.3 |
| N112-NB4 | NB-4's general form, corrected: at a four-colour vertex `v`, if in one `σ_v`-orbit `y₀,…,y₅` of change points no arc of `Γ` on `ω(y_{k±1})` passes through `y_k`, contradiction; the bound `\|P_cl(y_k)\| ≤ 4` is not needed (derived from the alternation) | hand, one mind (NB's route, one hypothesis removed) | §1.2, §1.4 row 1 |
| N112-A4SIX | A4-SIX-ARCS is TRUE (a second mind) | hand, two minds: A4; this job | §1.4 row 1 |
| N112-END | In a stuck chain (N4-STUCK's structure at every `P_k`) the horn curvatures cannot reach the closed ends: `λ_{k+1} = −1` or `υ_{k−1} = 1` contradicts N112-U1 at `P_k` | hand, one mind | §1.4 row 9 |

## Would-have-searched-here log (standing rule 3)

- The chain walk's exceptions could be "tested" by enumerating vertex figures with unit arcs at each step: not done; each exception is derived from
  the step's proof and named by the circle it reads.
- Whether a purely rotating ring is realisable with unit arcs (C-CHAIN-12's exception): not searched for; named, and left to a formula fragment.

## Fence log (standing rule 13; brief § Fences)

1. At start-up, `ls data/fs112/` (checking whether my record existed) printed the **names** `fs112-a` and `reports` (fenced directories); nothing in
   them was listed or opened.
2. `ls data/fs112/briefs/` and one `wc -c data/fs112/briefs/*.md` printed the **names and byte counts** of the other jobs' briefs; none was opened
   or read.
3. `ls plans/FS112*` printed the **name** `plans/FS112-close-inventory.md`; not opened.
4. A heading listing of `plans/FS112-unit-arc-half.md` (`grep -n "^#"`) printed §5.3's **heading line**, which names "E1–E4, E10, E17 guess where the
   break sits"; §5.3's body was not read.
5. One `git log --oneline -1` (to check the tree before committing) printed the newest commit subject beyond the start-up snapshot
   ("FS-112 inventory: items 18-19"). No further `git log`.

## Stage 1 — SAVED: quotation check, the chain walk

### 1.1 Files read from disk (this order)

`data/fs112/briefs/STANDING-RULES.md`; `data/fs112/briefs/N112-proof.md`; `CLAUDE.md` § The aim, § Counter-priors, G82, G79, G71, G13, G15 from disk
(G21, G24, G46 as loaded; unchanged on a spot check); `LEDGER.md` rows 131–134; `data/fs112/claims.md` in full; `plans/FS112-unit-arc-half.md` §1.3,
§G part 3, §PA, §IQ, §5.1, §5.2, §5.4 (not §5.3); `plans/FS112-PA-reading.md` in full (the extracts file by pointer only so far);
`plans/FS110-derivation.md` in full; `data/fs110/claims.md` §§0–3, §9; `plans/FS110-N-proof.md` §1.3–1.4, §2, §4–5, N3 §2.1–2.5, N4 §2.1–2.8;
`plans/FS110-NB-verification.md` §2.3–2.6; `plans/FS110-CB-verification.md` §1.2, D1–D6; the T2 fragment's formula (`tools/fs110_y_fragments.py`,
read, not run).

### 1.2 Quotation check (standing rule 5)

| quotation (brief) | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | exact (whitespace across a line break) |
| "Let's see some ambition. I know we can do it." | § Counter-priors | exact |
| Q-full: "a locally finite map bounded by segments and circular arcs, arcs of radius 1 allowed, carrying a six-colouring in which no two interior points of one colour are at distance exactly 1." | `plans/STUB-unit-arc-half.md` § The question | exact |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Toolchain (via the plan) | exact |
| standing rules' "From here on out, you may doubt …", "to eliminate the crutch …", "A proven theorem about why its impossible is also valid. All novel knowledge is a success", "It's ok if jobs overrun a bit. …" | `CLAUDE.md`; `plans/CONSOLIDATION-2026-09-27.md` | exact, all four |
| C-CHAIN-1…18's statements | `plans/FS110-derivation.md` | exact on the rows used below (each row's statement matches the FS110 heading of the same id) |

**NB-4's source form, l. 164, checked against NB §2.3 as the claim list asks.** Verbatim: "if in one `σ_v`-orbit `y₀, …, y₅` of change points no
`Γ`-arc of `ω(y_k)` or `ω(y_{k±1})` passes through `y_k`, then `|P_cl(v)| = 4` is impossible." **MISSTATED, confirmed** — `ω(y_k)` does not contain
`y_k`, so that clause is empty. It is not a slip for `ω(v)` either: an arc of `ω(v)` through `y_k` is already excluded by `y_k` being a change point
(an `e`-arc and an `f`-arc of `ω(v) ∖ Γ` meeting at `y_k`). The proof's one use of `y_k`'s own circle is "`|P_cl(y_k)| ≤ 4` (first step at `y_k`)", which
needs `ω(y_k)` to be mostly off `Γ`; the intended hypothesis was probably "no `Γ`-arc lies on `ω(y_k)`, and none of `ω(y_{k±1})` passes through `y_k`".
**That bound is not needed** (N112-NB4): at `y_k` the four tangent directions of `ω(y_{k±1})` are straddled (no arc along them) by tiles whose colours
lie in `P_cl(v)` and avoid `P_cl(y_{k±1}) ⊇ {e, f}`; an inner and an outer straddler never share a colour (N-E2 against `v`'s tile); so the straddler
pair `Q⁺_k` of `ω(y_{k+1})` and the pair `Q⁻_{k+1}` of `ω(y_k)` at `y_{k+1}` are disjoint 2-subsets of the 4-set `P_cl(v)`, hence complementary; the
same at `y_{k+1}` for `Q⁺_{k+1}`; so `Q⁺_{k+1} = Q⁻_{k+1}`, one inner and one outer colour per point, alternating `{A, B}`, `{C, D}`, and NB's
half-plane count (each colour `≤ 60°` at `v`) finishes. **Corrected statement:** *if in one `σ_v`-orbit of change points no arc of `Γ` on `ω(y_{k±1})`
passes through `y_k`, then `|P_cl(v)| = 4` is impossible* [hand, one mind]. The derivation file's general form ("an arc of `Γ` of `ω(y)` or
`ω(σ_v^{±1}y)` through a change point of every orbit") reads correctly once "`ω(y)` or" is deleted.

### 1.3 Three facts used throughout the walk (derived here)

**N112-U1 (the unit-arc centre's wedges).** Let `α ⊂ ω(P) ∩ Γ` be a unit arc of angular length `ℓ < π` with inner tile `T_in` (colour `s_in`) and
outer tile `T_out` (`s_out`). For `z` near `P`, `|z − w|² = 1 − 2(z − P)·e_w + |z − P|²` for `w = P + e_w ∈ α`. So `T_out` (which reaches just beyond
`α`) is within distance `< 1` of `z` iff `max_{w∈α} (z − P)·e_w > |z − P|²/2`: its shadow near `P` contains, to first order, **the open cone of
directions making an acute angle with some point of `α`** — angle `π + ℓ`, facing `α`. `T_in` (inside `B(P, 1)` near `α`) has points farther than 1
iff `min_w (z − P)·e_w < |z − P|²/2`: its shadow contains the cone of angle `π + ℓ` facing away. By N-E0: **`s_out`'s sectors at `P` lie in the closed
cone of angle `π − ℓ` facing away from `α`, and `s_in`'s in the cone of angle `π − ℓ` facing `α`; both side cones (angle `ℓ` each) hold neither.**
This is TS-U read conditionally (A4-TSU) and made a shadow statement: the concentric-circle shadow of FS-110's N4-SHADOW **degenerates to a wedge at a
unit arc centred at the reading point** (its `C = 0`). *Where six is spent:* nowhere (one tile and one circle family).

**N112-SIX.** At `|P_cl(v)| = 5` the set `S = ω(v) ∖ Γ` has one colour (N-E1), so `S ∩ (S + 60°) = ∅` (N-E0) and `|S| ≤ 180°`: unit arcs centred at
`v` of total `≥ 180°`. At `|P_cl(v)| = 6`, `S = ∅`: **`ω(v) ⊆ Γ`, a whole unit circle of boundary about `v`**, and every arc of it has both side colours
in `P_cl(v)` (the **both** kind, N112-U1 on each arc). *Six is spent* at "`|P_cl(v)| = 6` leaves no colour for `S`". This is the first half of
de Grey's C-V56 picture ("those six tiles must jointly cover a disk of radius 1 centred on V"): the boundary circle is forced; the covering by the six
tiles at `V` is not derived here.

**Reading scope.** Two distinct unit circles meet in at most two points, so a unit arc centred at `P` makes `Γ ∩ ω(x)` infinite only for `x = P`, and
lets a boundary arc through a point be tangent to `ω(x)` with curvature 1 only for `x = P`. Every Condition-5 use in the chain is one of these two, at
a named `x`; so **each step survives wherever none of the points whose circles it reads is a unit-arc centre with an arc at the place read**, and the
walk names those points.

### 1.4 The walk (every C-CHAIN step; verdicts (a) holds as written, (b) holds off a named exception, (c) fails)

| id | circles the step reads (relative to its vertex `v`) | verdict under unit arcs | the exception, by contact kind at its centre, and why |
|---|---|---|---|
| 1 NB-4 | `ω(v)` (the ring; the five-colour count); `ω(y′)` for ring points `y′ ∈ ω(v)` near the change points (the straddlers) | **(b)** | (E1) arcs of `Γ` on `ω(v)`: `v ∈ 𝒫`. On the branch with no covering pair `(v, y)`, `y ∈ ω(v)`, the arcs centred at `v` total `≥ 60°` or number `≥ 6`, one inside each of six consecutive `60°` windows — **A4-SIX-ARCS, TRUE, second mind** (choose `θ₀` with no window end on an arc, possible when the total is `< 60°`; each point `θ₀ + 60k` must change colour across its window, and a change between an `e`-arc and an `f`-arc at a single point is a covering pair, so each window holds a whole arc). (E2) an arc of `ω(y_{k±1})` through a change point `y_k`, in one change point of every `σ_v`-orbit (N112-NB4); when `y_k` is interior to that arc its sides are the ring colours `e, f`, both in `P_cl(y_{k±1})`: **both** kind at `y_{k±1}` (a ring point at distance 1 from `v`). Five colours: (E1) with `≥ 180°`; six: `ω(v) ⊆ Γ` (N112-SIX). **Not refuted by a held fragment:** FS-110's T2 has a four-colour `w` (quadrants `1, 4, 3, 5`) that is an (E1) centre (arcs of `ω(w)` at `u` and `v`, in-kind for colour 3, out for colour 1), but its flowers cover `ω(w)` only near `u, v` — BB, all straight, also carries four-colour `w, w′`, which NB-4 forbids under Condition 5: **FS-110's fragments are below NB-4's reading radius and cannot test it** |
| 2 NB-5 | `ω(u)`, `ω(v)` at `w₀` (N-SEAM (c)); `ω(w₀)` and the circles NB-4 reads at `w₀` | **(b)** | N-SEAM (c): a non-vertex seam point lies on an arc of `ω(x)`, `x ∈ {u, v}`, both side colours `x`'s: **both** kind at `x` — (S1). (S2) with arcs of `ω(u)` or `ω(v)` at `w₀`: the (S1)-at-a-vertex, crossing and one-arc patterns (FS110-N §5.2). With no arc at `w₀`: N-X, then NB-4 at `w₀` and its (E1)/(E2) at `w₀`. The fragments S1, T2, MX realise the first two exceptions locally (exact, two checkers) but, as in row 1, not at `w₀`'s ring |
| 3 N3-CONF | `ω(v)` | **(a)** | Its one Condition-5 use, "`W_c(v) ⊆ Γ ∩ ω(v)`, finite", becomes **compact**; N3-CLEAR's clearance and N3-UP's lens need only compactness and tile diameter `≤ 1` (checked: for an in-type tile along a contact arc, `d·(p − v) ≥ µ′ > 0` on a neighbourhood of the arc by compactness, so `\|z − p\| < 1` for `z = v + rd`, `r < 2µ′`). Contacts along an arc give TS-U's cones (N112-U1) |
| 4 W-MERGE | `ω(v)` (clearance), `ω(v′)` for `\|v′ − v\|` near 1 (types only shrink), `ω(z)` for `z` in the recoloured set (sight) | **(a)**, "Condition 5 kept" read as "no unit arc created" | New arcs have radius `ρ < 1`; unit arcs inside the recoloured gap are deleted. A contact arc of `ω(v)` ending at `N` leaves the cusp-end step intact: the tile at `N` is one tile, N3-UP applies to it whole |
| 5 N3-DEG | `ω(v)` (contacts at `N`, `S′`), `ω(N)`, `ω(S′)` (curvature bounds) | **(b)** | Empty interior still needs two antipodal contacts (a compact contact set in a closed half-circle and in no open one holds both its ends), so out at `N` and at `S′`, horns along `±a`, curvatures in **`[−1, 1]`**, with `κ₂ = 1` exactly when the horn's upper arc is an arc of `ω(N)` (`κ₁ = −1`: of `ω(S′)`); the horn's colour is then the outer side colour and lies in `P_cl(N)`: **out** kind at `N` (both, if the flank's colour is at `N` too — row 7) |
| 6 N4-SHADOW | `ω(v)` (the degenerate `C = 0`), the arcs at `N` | **(b)** | `C = 0` — the shadowing tile's arc at `N` is an arc of `ω(v)`: the shadow is N112-U1's wedge, not a circle side; for a contact arc ending at `N` the `+a`-side shadow is `B(N, 1)` (it misses the horn). `C = 2` (an arc of `ω(v + 2n)`) is harmless: `f(1) = 1/2`. The shadowing tile is outer with colour in `P_cl(v)`: **out** kind at `v` |
| 7 N4-SHAVE (with FLANK, RAY) | `ω(v)`, `ω(N)`, `ω(S′)` | **(b)** | N4-RAY **(a)**: the middle region's boundary curvatures lie strictly inside `(−1, 1)` even when the outermost are `±1`, so its proof stands. N4-FLANK **fails at `κ₊ = 1`** (resp. `κ₋ = −1`): the `g`-flank then lies inside `B(N, 1)`, so an **in-type** `g`-tile at `N` is possible (Siamese with the flank), and it shadows a band of the horn along the arc — a shadow of a kind FLANK does not list. When such a tile exists, the arc at `N` has `s_in = g`, `s_out = c`, both in `P_cl(N)`: **both** kind (self when the flank tile itself reaches `N`, the strip's kind). SHAVE's criterion `σ_h < σ_g` is then incomplete (the new band blocks `g`); SHAVE creates no unit arc (its circle `Σ` has curvature `σ_h ∈ [κ₋, κ₊)`, and `σ_h = −1` forces `Σ` onto the existing lower arc) |
| 8 N4-STUCK (with PROP) | `ω(v)`, `ω(N)`, `ω(S′)`, NB-4's circles at `v` and `N` | **(b)** | Inherits rows 1, 5, 7. Its own use, "(iv) the two arcs of `ω(v)` leaving `N` lie in tiles at `N`", fails when `v ∈ 𝒫` with an arc of `ω(v)` through `N`; the `c`-contact at `N` must then be an isolated tangent contact (a contact arc through `N`, or ending there, removes `−a` or `+a` from `D_c(v)`, against two horns), and the ring colour `r` at `N` may not exist. N4-PROP inherits (iv) and NB-4 at `N` |
| 9 N4-FIN | none (an inequality on sequences) | **(a)**; its application also survives | As a statement it is about the open interval. Under unit arcs N3-DEG gives `[−1, 1]`; the ends are excluded along a stuck chain by N112-END: if `λ_{k+1} = −1` the lower arc of the `a_{k+1}`-horn at `P_{k+1}` is an arc of `ω(P_k)` with `a_{k+1}` outside, an **out** contact at `P_k`, so by N112-U1 `a_{k+1}`'s sectors at `P_k` lie in the cone facing away from the arc, of angle `< π`; but N4-STUCK (ii) makes `a_{k+1}` fill the whole `−n` half-plane at `P_k`. Same for `υ_{k−1} = 1` |
| 10 N4-TERM | as its moves | first half **(a)**; N4-CONE **(b)** | A terminal modification exists (the moves are local, valid, lower `Φ`, create no unit arc). "Every vertex is cubic" inherits row 1 (four-colour vertices survive on (E1)/(E2)) and rows 7–8 (stuck vertices whose chain breaks at an in-type flank or at `v ∈ 𝒫`) |
| 11 NB4-CS | as rows 7–8 | **(b)** | "Doubly shadowed" gains row 7's band; the residue's description needs re-deriving at `κ₊ = 1` — GAP, named |
| 12 P17 | `ω(u)` (the ring), `ω(x_{i±1})` at `x_i` | **(b)** | The proof's contradiction is "the arc of `Γ` between `g` and `q` leaves `x₁` tangent to `ω(x₂)` with curvature `≠ 1`". An arc of `ω(x₂)` through `x₁` separates `g` (outer to `x₂`) from `q` (inside `B̄(x₂, 1)`) with no contradiction. At `x₂`: `s_in = q ∈ P_cl(x₂)` (N2-ROT's (A+): `q` just before `x₂`): **in** kind; `s_out = g ∈ P_cl(x₂)` in P17's own setting (the proof uses `x₂`'s `g`-tile), so **both** there — Polymath's tactic, at the ring points. N2-HEX's remark "the pure rotating ring is locally consistent" is thus live again with unit arcs; no fragment by formula is held |
| 13 COR1-NOD2 | `ω(u)` (the pseudo-colouring), `ω(u + e)` for arcs leaving `u` (D2's strip), `ω(y)` for every pair `(x, y)` at distance 1 the chain uses ((P′), (i), (ii)) | **(b)** | (B1) arcs of `ω(u)`: an arc with both sides outside `c(u)` (**inert** at `u`) gives `\|c′\| = 2` along an arc, breaking "finitely many points with `\|c′\| = 2`"; an in- or out-arc leaves `\|c′\| = 1` there. (B2) an arc leaving `u` that lies on `ω(u + e)`, `e ∈ ω(u)`: D2's "six directions move with `δ`" fails. (B3) `y ∈ 𝒫` with an arc of `ω(y)` through the partner `x`: (P′) fails when both side colours at `x` lie in `c(y)` (**both** kind at `y`; nesting `c(x) ⊆ c(y)` becomes possible), and (i)/(ii) lose the tile points of `ω(y)` in the strip. Whether each exception is fatal or repairable: GAP, not derived here |
| 14 CB-LEMMA3 | `ω(u₁)`, `ω(u₂)` (finitely many changes), `ω(x(t))`, `ω(y(t))` ((i), (ii)) | **(b)** | (B1) at `u₁`, `u₂`; (B3) along the bicycle's pairs |
| 15 CE5 | D2's strip at `u` (so `ω(u ± e)`), a horn's normal | **(b)** | (B2) at `u` |
| 16 CE6 | as rows 13, 15 | **(b)** | (B1)–(B3) |
| 17 CUSP-BASE | as row 13, at cusp vertices | **(b)** | (B1)–(B3); and row 5's closed curvature range at the horn |
| 18 the headline | all of the above | **(c)** as a proof | The chain first breaks at row 1: NB-4 holds only off (E1)/(E2). Nothing here refutes the headline with unit arcs (Q-full is open); the chain as written does not prove it |

**The first break in chain order is C-CHAIN-1 (NB-4)**, and every later exception is a unit-arc centre at a point the step reads: `v` itself (E1, B1,
row 6's `C = 0`, row 8), a point of `ω(v)` (E2, row 12, B3), or `N`/`S′` (rows 5, 7). **Kinds met:** both (E2, (S1), row 7, row 12, B3), out (rows 5, 6,
9), inert (B1's pseudo-colour break); **self** only inside row 7's both. **Steps that survive as written:** N3-CONF, W-MERGE, N4-RAY, N4-FIN (with its
application, N112-END), the first half of N4-TERM. So Woodall's merge and the propagation's finiteness carry over to unit arcs; what breaks is the
colour count at a vertex (NB-4), the flank shadows (FLANK at `κ = ±1`) and the base's reading of its circles.

*Where six is spent in the walk:* NB-4 (four colours of `P_cl(v)`, two outside), N112-SIX; N112-U1, N3-CONF, W-MERGE, N4-RAY, N4-FIN spend nothing.
*Seven-colour control:* the tight hexagonal seven-colouring has no unit arc, so every exception above is empty there and each step reads as under
Condition 5 (where FS-110 checked its controls); N112-SIX with seven colours leaves a colour for `ω(v) ∖ Γ`, as required. *Townsend's ⅔π sector:* it
lives on a unit arc (FS106-V), the configuration of row 6's `C = 0`; its detailed relation to N112-U1 is not derived here.

## Stage 1 — SAVED
