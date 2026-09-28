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
| N112-L60 | A boundary arc of radius 1 with constant sides has angular length `< 60°` (its outer tile would have diameter `> 1`); along `ω(P)` neither side colour recurs `60°` apart | hand, one mind; tools exact at named values (`tools/fs112_n_arcs.py` L60) | stage 2, §2.2 |
| N112-LOCK | For `w` interior to a unit arc `α ⊂ ω(P)`, a tile of either side colour touches `ω(w)` only at `P` (inner colour: facing cone; outer: away cone) or, for the inner colour only, at `P + 2e_w` from outside `B(P, 2)` | hand, one mind; the outer colour's exclusion at radius 2 tools exact (R2) | §2.2 |
| N112-BEND | Off its end vertices, a unit arc can be bent off radius 1, keeping validity and creating no unit arc: toward `P` unless its outer colour is at `P`; away from `P` unless its inner colour is at `P` or lies along the radius-2 circle | hand, one mind; GAP at the end vertices | §2.2 |
| N112-RED | Every valid map has a valid modification (merges, bends) in which every unit arc is (Q) centred at a vertex with `≥ 4` colours carrying both its side colours, or (R2) out-contact with the inner colour along the radius-2 circle | hand, one mind; GAP at end vertices and at termination's bookkeeping | §2.3 |
| N112-NB4′ | N112-NB4 as corrected at stage 2 (W1): the six orbit points need `{e, f} ⊆ P_cl(y_k)`, which fails only at an arc of `ω(v)` containing an orbit point in its closure; "passes through `y_k`" read as "has `y_k` in its closure" | hand, one mind | §2.1 W1 |

## Would-have-searched-here log (standing rule 3)

- The chain walk's exceptions could be "tested" by enumerating vertex figures with unit arcs at each step: not done; each exception is derived from
  the step's proof and named by the circle it reads.
- Whether a purely rotating ring is realisable with unit arcs (C-CHAIN-12's exception): not searched for; named, and left to a formula fragment.
- N112-RED's termination and end-vertex cases could be probed by enumerating vertex figures at an arc's end: not done; named as a GAP.
- Whether CAL-STRIP's and CAL-DISK's arcs are all of type (Q): not fitted to any figure; read from the printed words only (§2.4) and registered.

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

## Stage 2 — SAVED: card W answered; the unit-arc centre (§6); the reduction to four-colour centres

*A2's card W arrived after stage 1 was committed (its W1–W6, quoted in my answers by number only). The owner lifted the fence on the plan's §5.3
after both stage-1 commits; §5.3 was read after this stage's derivations were formed (its E1–E17 are not used below). Retractions counted from
stage 1: one (W1 (i), a precision of N112-NB4).*

### 2.1 Card W

**W1 (i) — an arc of `ω(v)` that ends at an orbit point must be named; retraction 1.** NB-4's argument uses, at each of the six orbit points,
`{e, f} ⊆ P_cl(y_k)` (so that the straddlers of `ω(y_{k±1})` at `y_k` avoid `e, f`). Starting from a change point `y₀` (an `e`-arc and an `f`-arc
of `ω(v) ∖ Γ` meeting at `y₀`), this propagates round the orbit by `c(θ + 60°) ≠ c(θ)` as long as each orbit point has both sides off `Γ`; it fails
exactly at an orbit point lying on an arc of `Γ` on `ω(v)` **or at an end of one** (then one side of the orbit point on `ω(v)` is boundary, and
`f` need not be at it). Likewise, NB-4's straddler count needs all four tangent directions at `y_k` straddled, so an arc of `ω(y_{k±1})` that merely
**ends** at `y_k` also breaks it. **N112-NB4′ (corrected):** *let `(v, y₀)` be a covering pair at a change point of the four-colour vertex `v`; if
no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its closure
(`k = 0, …, 5`), contradiction.* Both exceptions sit in the same orbit, the covering pair's. [hand, one mind]
**W1 (ii) — no; the alternation does not use `|P_cl(y_k)| ≤ 4`, and the two inner half-arcs carry one colour.** Write `Q⁺_k` (`Q⁻_k`) for the two
straddler colours of `ω(y_{k+1})` (`ω(y_{k−1})`) at `y_k`, one inner (its tile in `B(v, 1)`), one outer. (1) Straddlers lie in `P_cl(v)` and avoid
the other circle's centre's type (N-E1): `Q⁺_k ∩ P_cl(y_{k+1}) = ∅`. (2) `Q^±_{k+1} ⊆ P_cl(y_{k+1})`. (3) At one point an inner and an outer
straddler never share a colour (N-E2 against `v`'s tile of that colour). By (1)–(2), `P_cl(y_{k+1}) ∩ P_cl(v)` lies in the 2-set
`P_cl(v) ∖ Q⁺_k` and contains the 2-sets `Q⁻_{k+1}`, `Q⁺_{k+1}`: so `Q⁻_{k+1} = Q⁺_{k+1}`, and by (3) the inner colours agree and the outer colours
agree. So the inner half-arcs of `ω(y_{k+1})` and `ω(y_{k−1})` at `y_k` lie in **one** colour `i_k` whether or not `ω(y_k)` carries arcs of `Γ`;
`|P_cl(y_k)| ≤ 4` follows (it is `{e, f} ∪ Q_k`), it is not an input. `ω(y_k)` is read nowhere. [hand, one mind]

**W2 — the clause holds; the configuration is empty.** Let `c ∈ P_cl(v′)` and `v` lie on a unit arc `A` of `ω(v′)`; put `n = v′ − v`, `a ⊥ n`. Then
`v′` is a `c`-contact of `v`, so `D_c(v)` lies in `{d·n ≥ 0}` (in-type) or `{d·n ≤ 0}` (out-type), and `A`'s tangent `±a` is on `∂D_c(v)`.
- An arc between two gap sectors cannot have its tangent on `∂D_c(v)` (one of its two sectors would leave the convex cone `D_c(v)`).
- So `A` could only bound the gap at its end, beside the `c`-sector `S₁`, which W-MERGE's proof makes a horn along `a`. In-type at `v′`: `v`'s
  `c`-sectors are Siamese to `v′`'s `c`-tile (N-E2), so inside `B̄(v′, 1)`, above `A` (`y ≥ x²/2`); the horn is then above `A` and `A` bounds the horn,
  not the gap. Out-type: the `c`-sectors are outer, below `A`; the gap, inside `D_c(v) ⊆ {d·n ≤ 0}`, is below the horn, and again `A` (above the horn)
  does not bound it.
- Hence `cl R ∩ ω(v′) ⊆ {v}` and `D_c(v′)` is unchanged. **W-MERGE stays (a)** [hand, one mind]. (The other walk's worry is real in one sense: had
  `A` bounded a gap sector, the merge would put `c` interior to `ω(v′)` and break N-E1 at `v′` — so W-MERGE's clearness proof would have failed there;
  the derivation shows it cannot arise.)

**W3 — N4-RAY reads only the middle region's two boundary arcs and `v`; its step (1), as written, reads the stack.** RAY needs: a unit circle through
`t ∈ M` leaves `M` (not the stack) through a boundary arc of `M`, crossing into a `c`-horn. `M`'s boundary arcs are the inner arcs of the two
`c`-horns, with curvatures `κ₂, κ₃` strictly inside `(−1, 1)` whenever the `c`-horns have positive width (`κ₁ < κ₂`, `κ₃ < κ₄`, `κ₁ ≥ −1`, `κ₄ ≤ 1`),
and a unit arc tangent to `a` at `v` has curvature `±1`, so neither is a unit arc. Step (1) as printed ("the stack is `κ₁x²/2 < y < κ₄x²/2` with
`−1 < κ₁ < κ₄ < 1` … leaves it before `x = ρ`") **fails at `κ₄ = 1`**: a unit circle about `N + (X, h)`, `X, h` small, runs inside the stack along the
top arc. It is not needed: with `M` in place of the stack the same curvature comparison holds. **RAY stays (a), step (1) restated for `M`** [hand,
one mind].

**W4 — every circle the base reads (CB's lines).**

| CB line | step | circle read | unit-arc exception |
|---|---|---|---|
| 91–93 | (P) sweep | `ω(y)`, at an interior point of a tile | none (N-E1's content; no Condition 5) |
| 94–97 | (P′) | `ω(y)` near `x`, `\|x − y\| = 1` ("each meets `ω(y)` finitely (Condition 5)") | `y ∈ 𝒫`, an arc of `ω(y)` with `x` in its closure; nesting possible when both its side colours lie in `c(y)` (both kind) |
| 100–101 | transversal form | `ω(y)` crossing `Ω = ω(u)` at `x` | `ω(y)` along `Γ` at `x` (same as (P′)) |
| 105–112 | D2's strip | `ω(u + e)`, `e ∈ Ω` ("no arc from u lies on a unit circle (Condition 5)") | an arc leaving `u` that lies on `ω(u + e)` |
| 115 | pseudo-colouring | `Ω = ω(u)` ("finitely many points with `\|c′\| = 2` (Conditions 3, 5)") | an arc of `Ω` with both sides outside `c(u)` (inert at `u`) |
| 118–120 | (i)/(ii) | `ω(y)` for `y` on the partner circle, entering the strip beside `x` | as (P′); plus D2's exception at `u₁` |
| 126 | D3 | `ω(x) ∩ ω(u₁)` (geometry only) | none |
| 138–156 | D4 bicycle | `Ω₁ = ω(u₁)`, `Ω₂ = ω(u₂)` (finitely many special times), `ω(x(t))` (bands via (i), (ii)) | as lines 115, 118 |
| 159–193 | D5 (items 1, 3, 5, 6) | `Ω`, `ω(w)` for `w = x ± 60°` (item 3), `ω(x_{i±1})` (item 5, via (P′)), (P′) at item 1 and 6 | as (P′) and line 115 |

**W5 — both.** At `x₁` the arc of `ω(x₂)` separates `q` (inside `B̄(x₂, 1)`) from `g` (outer). `q ∈ P_cl(x₂)`: N2-ROT's (A+) is `c(σx₁−) = q`, the
colour just before `x₂` on the ring — **in-contact**. `g ∈ P_cl(x₂)` in P17's own setting (its proof uses "`x₂`'s `g`-tile") — **out-contact**. So
**both**; "out-contact for `g`" is the half of it that names `g`.

**W6 — the held positives at each (b)/(c) step's reading radius.**
- **FS-110's fragments** (flowers of radius `1/4` and `1/10` about the four points of a unit rhombus) reach no step that reads a whole unit circle:
  rows 1, 2, 8, 12–17 are out of their reach. They reach rows 5–7 only at `N`'s flower (radius `1/10`), below a horn's scale. T2's `w` is an (E1)
  centre (arcs of `ω(w)` at `u`, `v`); BB's `w`, a four-colour vertex with no unit arc, shows the flowers cannot test NB-4 (it is forbidden in a full
  map under Condition 5).
- **CAL-STRIP**, from its printed words ("The curved lines are arcs at constant radius 1 from the opposite corner, so each vertex down the middle
  mandates four such curved edges", thread 7, `[07.10]`): its middle vertices are centres of four unit arcs. Its half-height `(√15/2 + √3)/2 ≈ 1.834`
  holds `ω(v)` whole for vertices within `0.834` of the midline, so row 1's (E1) and A4-SIX-ARCS are within its reach; row 1's (E2) (radius 2) and the
  base (radius up to 2 about `u`) are not wholly.
- **CAL-DISK**, from its printed words (Sirgedas, `[16.346]`: "In the dual graphs, they both have quads on the interior, and triangles on the
  exterior. Arrows in the dual graph correspond to curved edges in the tile graph. Each quad in the dual graph “emits” four arrows."; de Grey,
  `[16.106]`: a `{1,3,5,6}` junction on the central tile): radius `2.12426` holds `ω(v)` whole for vertices within `1.124` of the centre, so the
  `{1,3,5,6}` junction's ring (row 1's (E1)) is in reach, its (E2) circles not wholly.
- **The recognition (§2.4):** "each quad emits four arrows" is row 1's (E1) at every interior degree-4 vertex, and N112-RED's type (Q).

### 2.2 Three facts about one unit arc

**N112-L60.** Let `α ⊂ ω(P)` be an arc of `Γ` with one tile `T_out` outside and one `T_in` inside along it, angular length `ℓ`. `T_out` contains points
`(1 + ε)e` beside each end direction `e`; two such points are `(1 + ε)|e₁ − e₂|` apart. At `ℓ = 60°` that is `1 + ε > 1`, against a tile's diameter
`≤ 1` (TS-C); so **`ℓ < 60°`**. For two tiles of one colour beside the arc `60°` apart, N-E1 at the first point is broken by the second (its unit
circle crosses `ω(P)` transversally there, into the tile). [hand, one mind; `tools/fs112_n_arcs.py` L60, exact at `60°` and `50°`]

**N112-LOCK.** Let `w` be interior to `α`, and `X` a tile of a side colour with a contact `Q ∈ ω(w) ∩ cl X`, `e = Q − w`. For `z` near `w`, `ω(z)`
near `Q` is to first order the line `{x : x·e = (z − w)·e}`; `X`'s cone at `Q` (or its horn, by N-HORN) is met for all small `(z − w)·e` of one sign.
So `X`'s shadow near `w` contains a half-plane bounded by the line through `w` normal to `e`. That half-plane meets both open half-discs of `w`
(`T_in`'s and `T_out`'s) unless `e ∥ e_w`, and it meets the tile beside `w` of `X`'s own colour — against N-E0. Hence **`e = ±e_w`: `Q = P` or
`Q = P + 2e_w`.** At `Q = P`: the inner colour faces `α`, the outer faces away (N112-U1). At `Q = P + 2e_w`: an outer-colour tile inside `B(P, 2)`
has, against `T_out`, cross-distances on both sides of 1 (N-E2 forbids it; exact at named points, R2); an inner-colour tile outside `B(P, 2)` is
farther than 1 from all of `B̄(P, 1)` (triangle inequality; the plant `r2_outside` checks the twin). **So along a unit arc's interior the only
contacts of its side colours are its centre's tiles and inner-colour tiles along the concentric circle of radius 2.** [hand, one mind]
*Consequence for ARC-INERT (E9):* its "finitely many isolated contact points" do not exist in the arc's interior.

**N112-BEND.** Bending `α`'s interior toward `P` recolours a thin lens inside `B(P, 1)` by the outer colour; the lens is clear unless some outer-colour
tile has a contact on `ω(w)`, `w ∈ α`, that bounds the shadow on the lens's side — by LOCK, only an outer-colour tile at `P` (an out-contact). Bending
away recolours a lens outside by the inner colour, blocked only by an in-contact at `P` or an inner-colour tile along the radius-2 circle (call it
**R2**). The new arc has radius `≠ 1`; types only shrink except at points of the new arc (chosen to avoid the finitely many unit-arc centres
nearby). **At the end vertices** the lens tapers into a thin sector at `A`, clear by N3-CLEAR when its directions stay strictly inside every
side-colour contact half-plane of `ω(A)`; a contact with `e ⊥ τ_A` is again at `P` or `P + 2e_A` — sketched, not written out: **GAP at the end
vertices**. [hand, one mind]

### 2.3 The reduction, and the §6 claims

**N112-RED.** *Every valid map has a valid modification, by W-MERGE (row 4, which survives) and N112-BEND, creating no unit arc, in which every unit
arc `α ⊂ ω(P)` is of one of two kinds: **(Q)** `P` carries both side colours and at least four colours; **(R2)** `P` carries the outer side colour, not
the inner, and an inner-colour tile runs along the radius-2 circle about `P` over all of `α`.*
*Proof.* A unit arc with no out-contact bends toward `P`; one with an out-contact but no in-contact bends away wherever R2 fails (R2 on a sub-arc
leaves that sub-arc, an (R2) arc). There remains the **both** kind. At a both-centre `P` the inner colour is in the facing cone, the outer in the away
cone, and each side cone (angle `ℓ > 0`) is covered by positive-angle sectors of other colours (N112-U1). If one colour `γ` covers both side cones, it
has two positive-angle sectors, so `int D_γ(P) ≠ ∅` and the convex cone `D_γ(P)` holds the facing gap or the away gap; W-MERGE recolours that gap near
`P` by `γ`, removing the inner or the outer side colour from `P`, and the arc then bends. Otherwise the two side cones carry different colours: `P`
carries `≥ 4` colours, type (Q). Each move is local, lowers (unit-arc pieces, `Φ`) and creates no unit arc; the terminal modification exists as in
N4-TERM. ∎ [hand, one mind; GAP at N112-BEND's end vertices and at the bookkeeping that a bend never creates a new contact at another arc's centre
(argued: types only shrink off the new arc, which avoids the centres)]
*Where six is spent:* nowhere in the reduction (it is geometry of contacts); six enters when (Q)'s four colours meet NB-4. *Seven-colour control:* the
hexagonal seven-colouring has no unit arc; nothing to reduce, as required.

**What it does to the question.** After N112-RED, unit arcs live only at **four-colour (or more) vertices that carry both side colours** — Polymath's
tactic at a vertex of degree `≥ 4` — or at the radius-2 configuration; and by N112-NB4′ every four-colour vertex is itself a unit-arc centre (E1) or has
a covering pair whose orbit meets an arc through a ring point (E2). So in the reduced map, **unit arcs and four-colour vertices come together**:
the unit-arc half of Question 2 is a question about **four-colour vertices that are unit-arc centres**, plus R2.

| claim | verdict | grade, minds |
|---|---|---|
| **C-UA-WEDGE** | **MISSTATED.** "the `c`-tiles at `P` face the arc" holds for the **inner** side colour only; the outer side colour's tiles face **away**. Corrected (N112-U1): *an inner side colour at `P` has its sectors in the closed cone of angle `π − ℓ` facing the arc, an outer one in the cone facing away; neither meets the open side cones.* TRUE as corrected; its killing test (a side colour in a side cone) cannot fire | hand; TS-U's content (row 132, two minds, one blind) re-derived as a shadow statement, this job one mind |
| **C-UA-BUDGET**, first branch | **TRUE** (A4-SIX-ARCS) | hand, two minds: A4; this job (stage 1 row 1) |
| **C-UA-BUDGET**, second branch | **MISSTATED.** Not "the arcs sit on `ω(σ_v^{±1}y)` through `y`" for the given `y`: by N112-NB4′, in `y`'s `σ_v`-orbit some point has an arc of `ω(y_{k±1})` in its closure, **or** some orbit point lies in the closure of an arc of `ω(v)` (centred at `v`). Corrected statement TRUE | hand, one mind |
| **ARC-INERT** | **TRUE, stronger, off the end vertices**: an inert arc bends toward its centre everywhere in its interior; the isolated tight contact points it names do not occur there (N112-LOCK). **GAP at the end vertices** | hand, one mind |
| **C-UA-INC** | **Local:** all four kinds are consistent with N112-U1 (both: FS-110's S1, exact; self in-: CAL-STRIP by its words; out: `[Parts2021]` by its words; inert: any arc whose centre lies inside a third colour's tile). **Up to N112-RED:** only **both** at a `≥ 4`-colour centre (Q), and **out** with R2, survive; in-only, out-only (without R2), inert and three-colour both-centres are removable | hand, one mind; the global question is Q-full |
| **C-SEAMS-TWO** | **MISSTATED.** (S1)'s centre in its three-colour form is a bowtie both-centre, **removable** by N112-RED (the bowtie colour merges through a gap, then the arc bends). Up to reduction the seams are **one species** — a `≥ 4`-colour vertex carrying both side colours of its unit arcs (T2's `w`, `P_cl(w) = {1, 3, 4, 5}`, is one) — plus R2 | hand, one mind |
| **C-UA-CHAIN** | **GAP** at "each unit arc forces a further unit arc". Reduced form: a (Q) centre is a four-colour vertex; on N112-NB4′'s (E2) branch it forces a both-kind arc centred at a ring point at distance 1, whose centre is then (Q) — a unit-distance chain of four-colour vertices; on the (E1) branch no further vertex is forced by this route. The print's version is Sirgedas's `[16.347]` for the strip ("A quad can’t be added because each new vertex will emit a conflicting arrow") | hand, one mind |
| **C-V56** | N112-SIX: a six-colour vertex has `ω(v) ⊆ Γ`, every arc of it both-kind; a five-colour vertex `≥ 180°` of centred arcs. De Grey's "those six tiles must jointly cover a disk of radius 1": **GAP** (not derived) | hand, one mind |

### 2.4 The held positives read against N112-RED (a recognition, and a registered prediction)

Sirgedas's rule (`[16.346]`) — at every interior degree-4 vertex (a quad of the dual graph) four curved edges — and de Grey's (`[07.10]`) — four arcs
of radius 1 centred at each vertex down the strip's middle — describe, in the prints' own words, **type (Q)**: four-colour vertices each the centre of
unit arcs whose side colours are the vertex's own (a tile's arc centred at its own opposite corner, the neighbour across it of the colour diagonal at
that corner: Polymath's tactic, self and out at once). So the only two held six-coloured regions beyond radius 1.8 are built entirely from what
N112-RED says a tight map must be built from, and no (R2) arc is described in either. **Registered (G21 instruments, scored at the close):**

| id | prediction | p | both outcomes reachable |
|---|---|---|---|
| N112-P1 | CAL-STRIP's rebuild: every unit arc is (Q) — its centre is a vertex of `≥ 4` colours carrying both its side colours (self and out); none is (R2) | 0.8 | the rebuild reads each arc's centre type exactly; an arc of another kind that does not bend is a counterexample to N112-BEND |
| N112-P2 | every four-colour vertex of CAL-STRIP within `0.834` of the midline with no covering pair on its ring has centred arcs of total `≥ 60°` (four arcs, each `< 60°`) | 0.85 | A4-SIX-ARCS predicts it; a rebuild with less is a counterexample to a two-mind theorem |
| N112-P3 | CAL-DISK's `{1,3,5,6}` junction is a (Q) centre | 0.7 | as P1, once the disk is rebuilt |

### 2.5 C-BEYOND and C-LOCAL for this programme

The programme so far is a **reduction**, not a refutation: N112-RED, N112-NB4′ and the chain walk are local (each reads a disc of radius 2 about a
point) and **all hold on CAL-STRIP and CAL-DISK**, which are valid; so none of them can be the step that decides Q-full. **C-BEYOND's step, named:**
the exclusion of a map whose unit arcs are all (Q) or (R2) and whose four-colour vertices meet N112-NB4′ — the step Sirgedas's `[16.347]` performs for
the strip in words ("the 6-color strip can’t be extended") and which must read beyond radius `2.12426` (the disk realises (Q) that far). Not derived.
**C-LOCAL: GAP** — no explicit `R` from this programme; its only candidate global step is C-UA-CHAIN's (E2) chain.

### 2.6 Where six is spent, controls

N112-L60, LOCK, BEND, RED spend nothing (contacts and shadows of one colour); six enters at N112-NB4′ (two ring colours outside a four-set) and N112-SIX.
Seven-colour control: no unit arc in the hexagonal seven-colouring, so every statement here is vacuous there, and NB4′ with seven colours leaves three
ring colours (its alternation fails), as required.

## Stage 2 — SAVED

## § Continuation — FS112-N2

*Job FS112-N2, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `c1dfac5d`. Briefs: `data/fs112/briefs/N2-112-proof-continued.md` (wins where the two
differ) and `data/fs112/briefs/N112-proof.md`, with `data/fs112/briefs/STANDING-RULES.md`. Working files `data/fs112/fs112-n/`; new exact checks
`tools/fs112_n2_*.py` (the frozen `tools/fs112_n_*.py` untouched). Earlier verdicts in this record are not rewritten; where I disagree I say so here.
Notation as §1.3 of this record and FS110-N4's frame (`plans/FS110-N-proof.md` §N4-2): `n` a unit vector, `a ⊥ n`, upward curvature, `Sh(T)` the shadow.*

### N2: theorems this continuation proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N2-SIGN | every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it (near / far tiles) | hand, one mind | stage N2-3 |
| N2-ENV | a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` (toward lens) or near `R₂(α)` (away lens), within `r(ψ) → 0` | hand, one mind; identities tools exact (`ENVT`, `ENVA`) | N2-3 |
| N2-TOWARD | `s_out ∉ P_cl(P)` ⟹ the whole unit arc, end vertices included, bends toward `P` (no stub) | hand, one mind | N2-3 |
| N2-AWAY | `s_in ∉ P_cl(P)` and no `s_in` tile touching `R₂(α)` (ends included) ⟹ the whole arc bends away; the end vertex's only blocker is R2 at the end | hand, one mind | N2-3 |
| N2-TAN | isolated R2 contacts (and ends of R2 sub-arcs) are cleared by a tangent bend; only R2 along an arc blocks (NB-ISO closed) | hand, one mind (NB's sketch completed); `TAN` exact | N2-3 |
| N2-RED | N112-RED with its end-vertex and isolated-contact GAPs closed, and its termination (no stubs) | hand, one mind | N2-3 |
| N2-FLANK-Q | a horn bound `±1` sits on a (Q) arc (FLANK's in-type exception, then two-sided) or an (R2) arc (FLANK's out-type tile along the radius-2 circle) | hand, one mind | N2-4 |
| N2-RAY | N4-FIN's application fails at a chain's end; a one-sided stuck chain (`λ_k = −1/(k+1)`, `υ_k = 0`) is consistent with N4-FIN; N4-CONE is a GAP under unit arcs | hand, one mind | N2-4 |
| N2-TERM | the terminal map: arcs (Q)/(R2); vertices cubic, NB4′ exceptions, or stuck on chains ending near (Q)/(R2)/NB4′ or running to infinity (GAP) | hand, one mind | N2-4 |
| N2-DENSE | in `M*`, every trichromatic cubic vertex has a unit-arc centre within 4 or a stuck vertex within 3; every disc of radius 5 contains one | hand, one mind, over the base (row 134's grade), NB4′ (two), N2-TERM (one) | N2-5 |

### N2: would-have-searched-here log

- End-vertex contact configurations (enumerate sector orders at an arc's end): derived from the two contact half-planes through `τ_A` (N2-3).
- The tangent bend's curvature `κ` (a scan): derived as `1 − κ ≪ 1 − 2κ_Y` (N2-3).
- The stuck ray's realisability (a family of horn lines): not built; named GAP (N2-4, N2-5).
- The strip's end vertices (read coordinates off a rebuild): not rebuilt by me; a prediction stated for the construction side's exact object (N2-5 §5.5).

### N2: fence log

1. `git log --oneline -1` (checking the tree before the first commit) printed one subject beyond the start-up snapshot: "FS-112 inventory: A3 launched".
   No further `git log`.
2. `ls data/fs112/` printed the names of fenced directories (`fs112-a`, `fs112-a2`, `fs112-y`, `fs112-yb`, `reports`); nothing inside them listed or
   opened. `ls data/fs112/briefs/` printed the other jobs' brief names; none opened.
3. Read, not fenced for me: `plans/FS112-unit-arc-half.md` §5.3 (the owner lifted it for the proof side after N's stage 1; N2's brief does not re-fence it).
4. Card X arrived by message from FS112-A3; its file copy `data/fs112/fs112-a3/card-X.md` was not opened (the message carried the text).

## Stage N2-1 — SAVED: quotation check; what N2 inherits

**Files read from disk (this order):** `STANDING-RULES.md`; the N2 brief; the N brief; `CLAUDE.md` § The aim and § Counter-priors (disk copy equals my
loaded one on those lines); this record in full; `plans/FS112-NB-verification.md` in full; both reports; `data/fs112/claims.md` in full;
`plans/FS112-unit-arc-half.md` §1.3, §G part 3, §IQ, §5.1–5.4; `plans/FS110-N-proof.md` stages N3-2 and N4-2 to N4-4; `tools/fs112_n_arcs.py` and its
output; `tools/fs112_nb_checks.py`.

**Quotation check (standing rule 5).**

| quotation in the N2 brief | source | verdict |
|---|---|---|
| A2's §3.5 (the choice, alternative, why, confidence, default) | `plans/POROS-2026-09-27-fs112-competition.md` §3.5 | **not checkable**: the record is fenced from me; taken as the owner quotes it |
| "N112-END assumes N4-STUCK's structure, which FLANK's failure removes at horn bound ±1" (the brief's summary of NB) | NB §2.2 ("NB-END (a conditional on that structure) does not reach it"), §2.3 #1 | faithful to NB's text (the brief's own words, not in quotation marks) |
| N's l. 231, "do not exist in the arc's interior" | this record l. 231 | exact |
| C-UA-CHAIN's "each unit arc forces a further unit arc … at its end vertices" | `data/fs112/claims.md` §6: "each unit arc forces a further unit arc (at its end vertices, or on the unit circles of its centre's partners)" | exact as an ellipsis quotation; the elided parenthesis also names the partners' circles |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Toolchain (via claims §5.4) | exact |

**What N2 inherits, fixed (two minds where NB agreed):** N112-U1 (with NB's precision: the outer tile's first-order shadow *contains* the open facing
cone of width `π + ℓ`, equality when `cl T_out ∩ ω(P) = ᾱ`), SIX, NB4′, L60, LOCK, the three-colour merge (NB-MERGE3), BEND on compact sub-arcs of
`int α`. **Open, and N2's aim (A2 §3.5 item 1):** RED at the end vertices; NB-ISO's isolated inner contacts at `P + 2e_{w₀}` (N's l. 231 is FALSE as
NB shows; I concede it: an inner-colour tile touching `B̄(P, 2)` only at a corner `P + 2e_{w₀}` is at distance `> 1` from `T_in` and satisfies N-E0);
RED's termination with stub accumulation; FLANK's `κ = ±1` exception and END's scope (divergence 1′).

## Stage N2-1 — SAVED

## Stage N2-2 — SAVED: the tool first — red plants at R2, END and L60 (divergence 15)

`tools/fs112_n2_checks.py` (new; `tools/fs112_n_arcs.py` untouched). Every check returns a verdict **and a reason code**; a plant must turn **exactly its
own** check red **with its own reason**, and the self-test calls anything else a DEFECT. Outputs committed in `data/fs112/fs112-n/n2-checks*.out`.

| check | derived claim (record address) | green reason (faithful) | plant | red reason under the plant |
|---|---|---|---|---|
| R2OUT | N112-LOCK, outer colour at `Q = P + 2e_w`: `T_out` straddles `ω(Q)` near `w`, so N-E2 forbids **any** `s_out` tile at `Q` (NB's route) | STRADDLE (`0.99998…`, `1.00018…`) | `r2_inner`: `T_in`'s points in place of `T_out`'s | NO_STRADDLE (both `> 1`): the inner colour **can** sit at `Q`, outside |
| R2IN | N112-LOCK, inner colour near `Q`: a point `Y ∈ B(P, 2)` near `Q` is shadowed by `T_in` | STRADDLE | `r2in_outside`: `Y` beyond radius 2 | UNSHADOWED, by the exact bound `\|Y\| − 1 > 1` |
| END | N112-END's contradiction: with `λ_{k+1} = −1` a point of the `−n` half-plane `5.7°` below `+a` is shadowed by the `a_{k+1}`-horn (U1's facing cone) | STRADDLE (`1.00206`, `0.99810`) | `end_half`: `λ_{k+1} = −1/2`, same `z` | UNSHADOWED, by the exact bound `R − \|z − c\| > 1` (`z` below the shadow circle of curvature `f(−1/2) = −1`) |
| L60 | N112-L60: at `ℓ = 60°` the outer tile's end points are `1 + ε` apart (TS-C broken) | DIAM_OVER (`10201/10000`) | `l60_fifty`: `ℓ = 50°` | DIAM_OK |

**Self-test:** four plants FIRE, faithful run PASS, exit 0 (`n2-checks-selftest.out`). **The DEFECT path is reachable, seen:** the first draft's END
witness `z = (1/10, −1/100)` lay at `β = 5.7°` below `+a` but `\|z\| = 0.1`, where the `11°` arc point is not near enough; the faithful run read END red
and the self-test named three plants DEFECT (they reddened END as well). Fixed by the scale (`\|z\| = 1/100`), not by loosening the assertion. A second
draft's R2 points `(1 ± t, s)` left the claimed side of `α`; the side assertion caught it before any verdict.
*Scope of END's check:* it certifies the contradiction **given** N4-STUCK's structure at `P_k` (the `a_{k+1}`-sector filling the `−n` half-plane);
divergence 1′ (FLANK) is about whether that structure holds, and is stage N2-4's.

## Stage N2-2 — SAVED

## Stage N2-3 — SAVED: the end vertices closed; NB-ISO closed by the tangent bend; RED's termination

*Card X from FS112-A3 (A2's successor) arrived while this stage was being written: A2's §3.5 clause has fired (N112-P1 met exactly on the
rebuilt strip; P2's conclusion holds), so item 3 is now the round's whole aim and items 1–2 are lemmas carried as far as item 3 needs. This
stage was already derived; it is saved as that lemma. Frame: `α ⊂ ω(P)` a unit arc with constant sides `s_in | s_out`, closure `ᾱ = [A, B]`,
angular length `ℓ < 60°` (N112-L60); `R₂(α) = {P + 2e_w : w ∈ ᾱ}`; `Δ(w)` the angular distance from `w` to the nearer end.*

**N2-SIGN [hand, one mind].** *For every point `p ≠ P` of a tile of colour `s_in` or `s_out`, `|p − w| − 1` has one strict sign on all of `int α`.*
If `ω(p)` crossed `α` transversally at an interior `w` it would enter both side tiles, one of which has `p`'s colour (N-E0). A tangency at interior
`w` puts `p ∈ {P, P + 2e_w}` (LOCK exact); at `P + 2e_w`, `ω(p)` runs just outside `α` into `T_out` (fatal for `s_out`), and for `s_in` the tile's
points `P + (2 − ε)e_w` near `p` cross `α` transversally. So each side-colour tile is **near** (inside `I = B̄(A, 1) ∩ B̄(B, 1)`, the set within 1 of
all of `ᾱ`) or **far** (outside `⋃_{w ∈ int α} B(w, 1)`), by connectedness. `T_in`, `T_out` are near.

**N2-ENV [hand, one mind; the identities tools exact, `ENVT`/`ENVA`].** For `z = P + (1 ∓ s)e_{φ₀}` (toward / away lens point) and
`p = P + ρe_ψ` beyond the end `A` by the angle `η` on `ω(A)` (`ρ = 2cos η`), with `Δ` the angle from `A` to `φ₀`:
`|p − z|² − 1 = 8cos η·sin(η + Δ/2)·sin(Δ/2) ± s(4cos η·cos(η + Δ) − 2) + s²`, and `|p − z|` increases with `ρ` beyond `2cos η`. With a lens
**profile** `s ≤ ψ·Δ(w)` (corner angle `ψ`; `sin(Δ/2) ≥ Δ/π` since `Δ < 60°`) this gives, for the uncovered part of the lens point's disc:
- *toward:* `B̄(z, 1) ∖ ⋃_{w ∈ ᾱ} B(w, 1) ⊆ B(P, r(ψ))`, `r(ψ) → 0`. (Within the arc's directions it is empty: `B̄(z, 1) ⊆ B̄(P, 2 − s)`. Beyond an
  end, the first term dominates unless `cos η ≲ πψ/2`, i.e. `p` near `P`; near `q_A = P + 2e_A` the `−2s` term has the wrong sign to help.)
- *away:* `B̄(z, 1) ∖ ⋃_{w ∈ ᾱ} B(w, 1) ⊆ N(R₂(α), r(ψ))`: within the directions a cap of radial height `≤ s` and angular half-width `≍ √s` about
  `P + 2e_{φ₀}` (`TAN` exact); beyond an end, only near `q_A` (small `η`).
- *near tiles:* for the toward lens every `p ∈ I` has `|p − z| < 1` (on `∂I`'s arcs of `ω(A)`, `ω(B)` the margin is `≳ Δ·sin ℓ − s`, at the corner
  `P` it is `s`); for the away lens the same off `B(P, r(ψ))` (at `P`, `|P − z| = 1 + s`).

**N2-TOWARD — the end-vertex GAP of the toward bend is closed [hand, one mind].** *If `s_out ∉ P_cl(P)`, recolouring the lens between `α` and a chain
`β` of circular arcs of radius `≠ 1` from `A` to `B` (inside `T_in`'s sectors at `A`, `B`: a corner of angle `ψ`, or a tangent start of curvature in
`(κ_σ, 1)` where `T_in`'s sector is a horn bounded by `σ`) with `s_out` is valid, removes `α` entirely, and creates no unit arc.* Proof: near tiles
never reach distance 1 from a lens point (N2-ENV); far `s_out` tiles meet `B̄(z, 1)` only inside `B(P, r(ψ))`, and no `s_out` tile's closure contains
`P`, so `ψ` below the distance from `P` to them clears the lens. `T_out ∪ L` has diameter `< 1` inside itself (the lens lies in `B̄(A, 1) ∩ B̄(B, 1)`).
**What the brief's worry reduces to:** at `A` the direction `τ_A` lies on a contact half-plane's boundary only for contacts at `P` or `q_A`; a Siamese
`s_out` tile at `q_A` would need `ᾱ ⊆ B̄(q_A, 1)`, false for `ℓ > 0`, and an outer one contains the lens's directions. So nothing at the end vertex
blocks the toward bend. (N112-BEND's and NB's "a contact arc of `ω(E)` ending at `P`" puts `P` in the closure of an `s_out` tile: excluded by hypothesis.)

**N2-AWAY [hand, one mind].** *If `s_in ∉ P_cl(P)` and no `s_in` tile has a point of `R₂(α)` in its closure (ends included), the away lens (recoloured
`s_in`, inside `T_out`, same profile) removes `α` entirely.* Near `s_in` tiles are at positive distance from `P`; far ones from `R₂(α)`.
**The end vertex's own blocker is exactly R2 at the end:** at `A`, the away bend is blocked at first order by an `s_in` tile touching `q_A` (out-type
relative to `A`, half-plane `{d·e_A ≤ 0}`), and by nothing else.

**N2-TAN — NB-ISO closed [hand, one mind; NB's sketch completed; `TAN` exact].** Let `C₂(α) = {w ∈ ᾱ : P + 2e_w ∈ cl Z, Z an s_in tile}` — closed, a
finite union of points and closed arcs (a far tile's closure meets the radius-2 circle only along its own boundary arcs or at points). At an
**isolated** point `w₀` of `C₂` (interior, or an end of `α`), or on the non-R2 side of an end of an arc component, bend with an arc tangent to `α` at
`w₀` of curvature `κ ∈ (κ*, 1)`: the lens has height `h ≤ (1 − κ)δ²/2` at offset `δ`, and the part of `B̄(z, 1)` beyond radius 2 is the cap of height
`h`, half-width `≍ √h`. A tile `Y ∋ q₀ = P + 2e_{w₀}` lies outside the radius-2 circle near `q₀` (N2-SIGN); on each side its points at angular offset
`δ` rise **linearly** (a sector not tangent to the circle) or **quadratically** (a boundary arc tangent at `q₀` of curvature `κ_Y < 1/2`: height
`≥ (1 − 2κ_Y)δ²`), and `κ_Y = 1/2` means the boundary **is** the radius-2 circle on that side — an arc component of `C₂`, not an isolated point. With
`1 − κ` small against `1 − 2κ_Y` the cap misses `Y`. The pair `(w₀, q₀)` stays outer (`|z − q₀|² ≈ 1 − 2h + 2δ² > 1`). **So N's l. 231 is false (NB
right, conceded), and the GAP it hid is closed: isolated R2 contacts do not block; only R2 along an arc does.**

**N2-RED — N112-RED with both GAPs closed [hand, one mind].** *Every valid map has a valid modification, by W-MERGE, N2-TOWARD, N2-AWAY and N2-TAN,
creating no unit arc, in which every unit arc is **(Q)** (both side colours at the centre; by U1 the side cones hold neither, and no colour holds both
side cones, else W-MERGE applies: `≥ 4` colours) or **(R2)** (outer colour at the centre, not the inner; an inner-colour tile along the radius-2 circle
over all of `ᾱ`).* **Termination.** The moves never add a colour to a unit-arc centre (new arcs avoid the finitely many centres nearby; W-MERGE's
radius avoids them); a bend removes colours only at points of `int α`, which carry two colours and so are never (Q) centres; the witness of an (R2)
arc is cut only by a W-MERGE near it (a bend's lens meets another arc's witness arc at most at a point: radius 1 against radius 2). Each W-MERGE
lowers `Φ` at one vertex and new vertices have `Φ = 0`, so a bounded region sees finitely many; each bend removes an arc (or replaces it by (R2)
pieces) and is re-enabled only by a W-MERGE or by a colour lost at its centre (then it is removed for good). The enumeration of N4-TERM then gives a
terminal modification on the whole plane; **no stubs arise**, because every bend reaches the end vertices. *Six:* nowhere (geometry of contacts).
*Seven-colour control:* no unit arc, nothing to do.

| NB divergence | status after this stage |
|---|---|
| #4 (N's l. 231; RED's GAP at isolated contacts) | l. 231 FALSE, conceded (two minds: NB, and I on re-reading); the GAP it hid is closed by N2-TAN (one mind) |
| #5 (end vertices; stub accumulation) | closed by N2-TOWARD, N2-AWAY (one mind): the bends reach the ends, so no stubs |
| #7 (C-UA-CHAIN's (E2) "both kind") | unchanged; item 3's business |

**Would have searched here:** the end-vertex contact configurations (enumerate sector orders at `A`) — derived instead from the two boundary
half-planes through `τ_A`; the tangent bend's `κ` (a scan) — derived as `1 − κ ≪ 1 − 2κ_Y`.

## Stage N2-3 — SAVED

## Stage N2-4 — SAVED: the terminal map (item 2) — FLANK's exception placed; divergence 1′ named, with a new object (the stuck ray)

*Frame of FS110-N4 §N4-2: a colour `c` with a horn `H₊` along `+a` at `v`, arcs of upward curvature `κ₋ < κ₊` in `[−1, 1]` (N3-DEG with unit arcs, row 5),
flanks `g` above, `h` below; `N = v + n`, `S′ = v − n`; chains `P_k = v + kn` with curvatures `λ_k < υ_k` as in N4-FIN.*

**N2-FLANK-Q — FLANK's exception is a (Q) centre, and its non-exception at bound `±1` is an (R2) arc [hand, one mind; the failure itself two minds:
N, NB].** Let `κ₊ = 1`, so `H₊`'s upper arc `α_N` lies on `ω(N)`, with `s_in(α_N) = g` (the flank, inside `B(N, 1)`) and `s_out(α_N) = c`. At a vertex
with `int D_c(v) = ∅` (the only place FLANK is used), N3-DEG gives an out-type `c`-tile at `N`: `c ∈ P_cl(N)`, an out-contact of `α_N`.
- *FLANK's exception* (an in-type `g`-tile at `N`, Siamese with the flank) puts `g ∈ P_cl(N)`: `α_N` is **both** kind at `N`. In a terminal map
  (N2-RED plus W-MERGE, RAY, SHAVE with the corrected shadows) a both arc is (Q): **`N` carries at least four colours.** Moreover the flank tile is then
  inside `B̄(N, 1)`, and once N4-STUCK (ii) makes `g` one sector filling the `+n` side, **both** horns' upper arcs lie on `ω(N)`: the exception is one
  unit arc of `ω(N)` through `v`, never one-sided.
- *No exception:* `g ∉ P_cl(N)` (an out-type `g` at `N` would put the flank's directions in `{d·n ≤ 0}`), so `α_N` is out-only and, terminal, **(R2)**: a
  `g`-tile along the radius-2 circle about `N`, which passes through `S′` tangent to `a` with upward curvature `1/2`. That tile is exactly FLANK's
  out-type `g`-tile at `S′`, and `f̃(1/2) = 1` = `κ₊`: it shadows all of `H₊` (`σ_g = κ₊`). Mirror at `κ₋ = −1`: (Q) at `S′`, or (R2) through `N` with
  `f(−1/2) = −1` (NB's FLAT, exact).
So **every horn bound `±1` sits on a (Q) or an (R2) unit arc** — divergence 1′'s first half placed as A2 asked.

**N4-STUCK under unit arcs [hand, one mind].** (i) holds with bounds in `[−1, 1]`. (ii) holds: the in-type `g`-contact at `N` gives the same half-plane
`{d·n ≥ 0}` as the out-type one at `S′`, and "`g₋ = h₊` has in- and out-contacts at one point" is still impossible (N3-CONF). (iii)–(iv) change only at
the exceptions: an in-type `g` at `N` (then `N` is (Q), `|P_cl(N)| ≥ 4`), an arc of `ω(v)` through `N` (row 8's), or NB4′ at `N`. **So N4-PROP runs
along the normal line until it meets a point that is a (Q) or (R2) centre or an NB4′ exception, within distance 1 of a unit arc.**

**N2-RAY — divergence 1′'s second half: N4-FIN's application fails at a chain's end, and a one-sided chain is consistent [hand, one mind].** N112-END
(and NB-END) exclude `λ_{k+1} = −1` or `υ_{k−1} = 1` only when the arc's centre `P_k` itself carries the stuck structure. At a chain's **end** the centre
is not stuck, so a finite chain may end with its outermost bound exactly `±1` (the arc (Q) or (R2) at the next point). N4-FIN forbids only bi-infinite
chains, and **the other direction may run to infinity**: from `λ_0 = −1` the recursion `λ_k ≤ f(λ_{k+1})` is met with equality by `λ_k = −1/(k + 1)`,
`υ_k = 0` (straight upper arcs), `k ≥ 0` — N4-FIN's upward bound (`υ > 0` dies in `1/υ` steps) never fires. N's row 9 ("its application also
survives") is overstated on this second count as well as on NB's. **So N4-CONE ("no colour has two sectors at any vertex of a terminal map") is a GAP
under unit arcs**, at: (a) finite stuck chains between two exceptions; (b) the **stuck ray** — a one-sided infinite chain of degree-4 vertices at unit
spacing from a (Q)/(R2)/NB4′ exception, horn curvatures tending to 0. Neither is refuted or realised here; realisation is a whole-line object, not a
local fragment.

**N2-TERM — the terminal-map statement (item 2) [hand, one mind; over N2-RED, N4-TERM's enumeration, NB4′].** *Every valid map has a valid
modification `M*`, creating no unit arc, in which:*
1. *every unit arc is (Q) (both side colours at its centre, `≥ 4` colours there, the two side cones covered by distinct other colours) or (R2);*
2. *every vertex is cubic (`≤ 3` colours, one sector each; sectors possibly horns), or an **NB4′ exception** (`≥ 4` colours: on the (E1) branch a
   unit-arc centre with `≥ 60°` or `≥ 6` centred arcs, on the (E2) branch a vertex whose ring point lies in the closure of an arc centred at a ring
   point), or **stuck**;*
3. *every stuck vertex lies on a stuck chain along its normal line; the chain is not bi-infinite; each end that is not at infinity is within distance
   1 of a (Q) or (R2) arc or an NB4′ exception, and every horn bound `±1` on it is a (Q) or (R2) arc (N2-FLANK-Q). One-sided infinite chains: GAP.*
*Six is spent* in NB4′ (the ring's two colours) and in N4-STUCK (NB-4 at `N`); N2-RED, N2-FLANK-Q, N2-RAY spend nothing. *Seven-colour control:* the
hexagonal seven-colouring is terminal, cubic, with no unit arc and no stuck vertex. *The strip (card X):* all its arcs are (Q) (X1), so N2-RED does
nothing there; its midline vertices are NB4′'s (E1) exceptions (four arcs, `62.09°`); no step of this stage forbids it.

## Stage N2-4 — SAVED

## Stage N2-5 — SAVED: item 3, the first global step (route B); card X answered

### 5.1 The route, a decision in four parts

- **The choice.** Route B: S–V Cor. 1 almost everywhere (row 134's base: CB, CD, CE, CUSP-BASE), run on the terminal map `M*` of N2-TERM, first in its
  **avoidance form** (the base applied where no unit-arc centre or stuck vertex is within its reading radius), then with (Q) centres admitted.
- **The alternative weighed.** Route A, the (E2)/end-vertex chain (C-UA-CHAIN): each (Q) centre on NB4′'s (E2) branch forces a both-kind arc centred at
  a ring point, a unit-distance chain of four-colour vertices.
- **Why B won.** Card X1: every midline vertex of the rebuilt strip is a (Q) centre on the **(E1)** branch (four centred arcs, `62.09°`), and on (E1)
  route A forces no further vertex; so route A has no step that fires on the one held valid object beyond radius 1.8, and could decide nothing about
  maps built like it. Route B's base reads a disc of radius 3 around a trichromatic vertex — beyond the strip's half-height `1.834` — and its unit-arc
  exceptions are named (B1–B3, the chain walk, two minds).
- **Confidence: medium.** What would change it: a reading of the base in which a (Q) centre's (P′)-failure (below) is needed by Lemma 4's pigeonhole
  at every trichromatic vertex near it — then route B's second step is as hard as the whole question, and route A's chain would be worth a second look
  on the (E2) branch.

### 5.2 What the base's exceptions become in `M*` [hand, one mind]

The chain walk (rows 13–17; N and NB agree letter for letter) puts every Condition-5 use of the base at one of three exceptions. In `M*`:
- **(B1) is empty.** (B1) is an arc of `Ω = ω(u)` **inert** at `u` (both sides outside `c(u)`); `M*` has no inert arc (N2-TERM 1). An (R2) arc on `Ω`
  has `s_out ∈ c(u)`, so `|c′| = |{s_in}| = 1` along it: CB's "finitely many points with `|c′| = 2`" survives.
- **(B3) is (P′) failing exactly at (Q) arcs.** (P′) ("unit pairs never nest", CB D1) fails for `x` interior to a unit arc centred at `y` precisely
  when both side colours lie in `c(y)`: then `c(x) = {s_in, s_out} ⊆ c(y)`. In `M*` that is a (Q) arc (an (R2) arc has `s_in ∉ c(y)`, so (P′) holds).
- **(B2)** (an arc leaving `u` on `ω(u + e)`, `e ∈ Ω`) is an arc centred at a point of `Ω`; in `M*` it is (Q) or (R2) there.
- **The end vertex of a (Q) arc** (the joint A2 named): if `E` ends a (Q) arc `α ⊂ ω(y)`, the circle `ω(y)` leaves `E` beyond `α` either along another
  unit arc centred at `y` or through a tile whose colour is outside `c(y)` (N-E1 at `y`) — a ring colour of `y`. So `c(E)` contains a colour outside
  `c(y)` unless two consecutive arcs of `ω(y)` meet at `E`: a trichromatic end vertex nests into its centre only at a junction of two centred arcs.

### 5.3 N2-DENSE — the first global step [hand, one mind for the assembly; over the base at row 134's grade, NB4′ (two minds), N2-TERM (one mind)]

*Let `M*` be the terminal modification of a valid map (N2-TERM) and `u` a trichromatic cubic vertex of `M*`. Then `B̄(u, 4)` contains a unit-arc
centre, or `B̄(u, 3)` contains a stuck vertex.*

*Proof.* Suppose neither. (1) A unit arc meeting `B̄(u, 3)` has its centre in `B̄(u, 4)`; so `Γ ∩ B̄(u, 3)` has no unit arc and every unit circle meets it
finitely: Condition 5 holds inside `B̄(u, 3)`. (2) Every vertex `w ∈ B̄(u, 3)` has `≤ 3` colours: NB4′'s exceptions need an arc centred at `w` or at a
point of `ω(w)`, a centre in `B̄(u, 4)`; NB-SIX's likewise. (3) No vertex in `B̄(u, 3)` repeats a colour (N2-TERM 2: it would be stuck). So `M*` is cubic on
`B̄(u, 3)` (sectors possibly horns; CUSP-BASE's unit-arc exception is a centre at `w ± n`, in `B̄(u, 4)`). (4) The base at `u` reads: the closed unit
disc about `u` (Lemma 4's eleven pigeonhole points and the boundary paths followed inward), pairs `u₁, u₂` there at distance `< 2` (Lemma 3's bicycle,
Cor. 3), the circles `ω(u_i)`, `ω(x(t))`, `ω(y(t))` with `x(t), y(t)` on them (centres in `B̄(u, 2)`, points in `B̄(u, 3)`), CE's Antipodal Lemma and
CUSP-BASE at `u ± e`, and the hole-filling of `u`'s `{4,5,6}`-component (CB D5 item 6; it survives unit arcs by the same generic move of the outside
centre within its tile, which also avoids the finitely many centres). Its exceptions (B1)–(B3) are unit-arc centres at points it reads, all in
`B̄(u, 4)`. So the base applies unchanged and refutes the colouring of `B̄(u, 3)`. ∎

**Corollary (every disc of radius 5).** Every disc of radius 1 contains a vertex of `M*` (a tile has diameter `≤ 1`; a tile with a single neighbour
is surrounded by it, and nested surrounding tiles all lie within `B(x, 1)`, finitely many by local finiteness — a sketch). A vertex is cubic, an NB4′
exception (a centre within distance 1), or stuck. So **every disc of radius 5 of `M*` contains a unit-arc centre or a stuck vertex.** Bends and
merges create no unit arc, so the centres are the original map's: *in every valid six-map with unit arcs, every disc of radius 5 contains a unit-arc
centre, or a stuck vertex of its terminal modification.* Under Condition 5 on the whole plane there are neither (N4-CONE), which is row 134.

**What it says, and what it does not.** Q-full's YES must carry unit-arc centres (or stuck chains, which end at them or run to infinity) at every
scale-5 window of the plane: a C5 region of radius 5 is impossible. It is **not** an exclusion. *Where six is spent:* in the base (S–V's ten-plus-one
count) and in NB4′. *Seven-colour control:* the hexagonal seven-colouring has no unit-arc centre and no stuck vertex, and is valid: the base does not
start there (four ring colours), as required. **Killing test 8 (the strip):** every trichromatic vertex of the strip is within `1.834` of a midline
(Q) centre, so N2-DENSE holds on it; the step reads outside the strip only around a vertex farther than 4 from every centre, which the strip has none
of. **C-LOCAL:** N2-DENSE is local (radius 5, explicit), but it is not a NO; the named next step is.

### 5.4 The next step, named (C-BEYOND's step for route B)

**GAP — the base at a trichromatic vertex within distance 4 of a (Q) or (R2) centre.** In `M*` the base's remaining exceptions are (B2) and (B3) at
(Q)/(R2) centres, and the stuck chains. The step: rerun Lemma 4's pigeonhole at `u` and show that a (P′)-nesting pair `(x, y)` (`x` on a (Q) arc
centred at `y`) cannot be one the pigeonhole hands to Lemma 3 or Cor. 3, or name the configuration where it is. By 5.2 last item, a trichromatic
pigeonhole point nests into a (Q) centre only at a junction of two consecutive arcs of that centre's circle, which is where the next derivation
should start. Separately, **the stuck ray** (N2-RAY) must be excluded or realised: it is a whole-line object that no disc-local argument can see.

### 5.5 Card X (FS112-A3) answered

- **X1 / part 2:** noted; N112-P1 met exactly and P2's conclusion held — my predecessor's registrations score in their favour. Item 3 taken as the
  round's aim (stages N2-3, N2-4 were carried to the depth item 3 consumes).
- **X2 (the strip at each step's reading radius):** N2-TOWARD, N2-AWAY, N2-TAN read up to the radius-2 circle about a centre; on the strip every arc
  is (Q), so their hypotheses fail and they do nothing — consistent; the strip's own radius-2 points over vertical arcs lie outside it, so it cannot
  test (R2). N2-FLANK-Q and N2-RAY need a stuck vertex; the strip has none. N2-TERM describes the strip exactly (midline (E1) exceptions, the rest
  cubic). N2-DENSE: 5.3. **The end vertices of the strip's arcs:** 5.2's last item predicts, checkable on the exact rebuild, that `ω(P)` leaves each end
  vertex through a tile of one of `P`'s two ring colours or along the next arc centred at `P`.
- **X3:** no action (as the card says). **X4:** not worked this round.

**Would have searched here:** whether the stuck ray is realisable (a line of horn pairs; a parameter family by formula with an exact check would be
in-ban, but its free parameters were not derived) — named as a GAP instead.

## Stage N2-5 — SAVED

## § Continuation — FS112-N3

*Job FS112-N3, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `4609152f`. Briefs: `data/fs112/briefs/N3-112-proof-round3.md` (wins where they differ),
`data/fs112/briefs/N2-112-proof-continued.md`, `data/fs112/briefs/N112-proof.md`, with `data/fs112/briefs/STANDING-RULES.md`. Working files
`data/fs112/fs112-n/`; new exact checks `tools/fs112_n3_*.py` (earlier tools run, never edited). Earlier verdicts in this record are not rewritten; where I
disagree I say so here. Notation as §1.3 and N2's frame; `M*` a terminal valid modification (N2-TERM / NB2-TERM); a **chain** is N4-PROP's sequence
`P_k = v + kn` of stuck vertices with `λ_k < υ_k` the upward curvatures at `P_k` of the lower and upper arcs of the `+a` horn of `a_k`; `f(λ) = λ/(1+λ)`,
`f̃(υ) = υ/(1−υ)`.*

### N3: theorems this continuation proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| N3-STEP | along a stuck chain neither `λ` nor `υ` decreases and one of them strictly increases at every step | hand, one mind; tools exact (STEP, MONO) | stage N3-2 |
| N3-LEN | with every horn curvature in a finite set `K`, a chain has at most `2\|K\| − 1` vertices; a one-sided infinite chain carries infinitely many curvatures | hand, one mind | N3-2 |
| N3-RAYR | on an upward-infinite chain `−1/(k+1) ≤ λ_k < 0`: the horn at `P_k` needs a boundary arc of radius `≥ k+1` (mirror downward) | hand, one mind; tools exact (RAY) | N3-2 |
| N3-PER | a doubly periodic valid map has a periodic terminal modification (so finitely many arc classes) | hand, one mind | N3-2 |
| R1 (card R) | TRUE as corrected: the premise is on the terminal map; periodic maps have no stuck ray and bounded chains; aperiodic finite-alphabet maps: GAP N3-ALPH | hand, one mind | N3-2 |
| N3-NOBOTH | a both-centre is a vertex with `≥ 4` colours or a repeated colour | hand, one mind, over N112-U1 (two) | N3-3 |
| N3-FAIL | the strip at `q ∈ ω(u)` fails only at a leaving centre; there `C` allows only the unit arcs' inner colours inside, outer outside | hand, one mind; tools exact (VOTES) | N3-3, N3-4 precision 1 |
| N3-ANTI | CE5 (the Antipodal Lemma) survives unit arcs, by counting in-votes | hand, one mind; tools exact (ANTI) | N3-3 |
| N3-COR3 | a close complementary pair of cubic trichromatic vertices sits on a unit rhombus whose other corners are four-colour double leaving centres | hand, one mind | N3-3 |
| N3-I / N3-II / N3-P′ | (i) never fails; (ii) fails only at a four-colour or repeated-colour vertex; same-multicolour cubic trichromatic vertices are never at distance 1 | hand, one mind | N3-3 |
| N3-BASE | the base refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)` holds a vertex of `≥ 4` colours or a repeated colour | hand, one mind, over row 134's base | N3-3 (table), N3-4 precision 2 |
| N3-DENSE3 | every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a repeated colour | hand, one mind | N3-3 |
| N3-END | a stuck chain's end with horn bound `−1` has a four-colour, repeated-colour vertex one step beyond and a both-kind unit arc centred two steps beyond (or is the doubly bounded one-vertex chain) | hand, one mind | N3-4 |

### N3: would-have-searched-here log

- The longest chain over a named finite curvature set (a DP): replaced by the rank count (N3-LEN).
- Vertex figures at a leaving centre (an enumeration): replaced by the finite vote table (VOTES).
- Arc curvatures against the antipodal votes (a scan): replaced by the second-order formula and named exact values (ANTI).
- End configurations at `P_{−1}` (sector orders): derived from FLANK, N3-DEG and N112-U1's side cone (N3-END).

### N3: fence log

1. `ls data/fs112/fs112-n/ data/fs112/reports/` (checking whether my record's working files existed) printed the **names** of the reports directory's
   files, fenced ones among them (`FS112-A3.md`, `FS112-A.md`, `FS112-P.md`, `FS112-PA.md`, `FS112-Y2.md`, `FS112-YB.md`, `FS112-Y.md`); none was opened.
2. `ls data/fs112/briefs/` and one `wc -c data/fs112/briefs/*` printed the other jobs' brief **names and byte counts**; none was opened.
3. Card R's source (`data/fs112/fs112-a3/card-R.md`) and A3's record (`plans/POROS-2026-09-27-fs112-competition.md`) are fenced: not opened.
4. `git log --oneline -3` printed three subjects, all inside the start-up snapshot. No further `git log`.
5. For the report, one path-restricted `git log -n 6 --format='%h %s' -- plans/FS112-N-proof.md tools/fs112_n3_checks.py` printed my five commit subjects and N2's
   last (`3078a6d8 FS112-N2: stage 5`); nothing of any other job.

## Stage N3-1 — SAVED: quotation check; what N3 inherits

**Files read from disk (this order):** `STANDING-RULES.md`; the N, N2 and N3 briefs; `CLAUDE.md` § The aim and § Counter-priors (disk; link 2 now carries
two printed sources, nothing here rests on it); this record in full; N2's and NB2's reports; `plans/FS112-NB2-verification.md` in full;
`data/fs112/claims.md` rows C-CHAIN-6 to 9; `plans/FS110-N-proof.md` stages N3-2 and N4-2 to N4-4 (the frame, SHADOW, FLANK, SHAVE, RAY, STUCK, PROP, FIN,
TERM, CONE).

**Quotation check (standing rule 5).**

| quotation in the N3 brief | source | verdict |
|---|---|---|
| card R part 1, "verbatim from `data/fs112/fs112-a3/card-R.md`" | fenced from me | **not checkable**; taken as the owner quotes it |
| inside R1: C-CHAIN-9's recursion "`λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`" | `data/fs112/claims.md` l. 142 (FS110-N4-FIN) | exact (`grep -F`) |
| A3-3.4 (choice, alternative, why, confidence, default) | `plans/POROS-2026-09-27-fs112-competition.md` §A3-3.4 | **not checkable** (fenced); one reason withheld by the advisor, as the brief says |
| inside A3-3.4: N2's recommendation "the one whole-line object no disc-local argument sees" | `data/fs112/reports/FS112-N2.md` | exact |
| the brief's gloss of NB2's DENSE (not in quotation marks) | `data/fs112/reports/FS112-NB2.md`, `plans/FS112-NB2-verification.md` NB2-DENSE | faithful |
| the brief's gloss of NB2-END: "(a sketch, one mind): a chain's end may force a unit arc one step beyond it" | NB2's report: "NB2-END (sketch, one mind, **conditional**): a chain's end may force a unit arc one step beyond it" | **drops "conditional"** — and NB2's own divergences 2 and 4 say its premise ("two `g`-sectors at `P_{−1}`") is exactly what FLANK's exception can remove. Carried into stage N3-4 |
| Kooshi's four standing-rule quotations; "My goal is to fully solve …"; "Let's see some ambition …"; "search for a finite graph is out …"; "It's ok if jobs overrun a bit …" | `CLAUDE.md`; `plans/CONSOLIDATION-2026-09-27.md` | exact (two across a line break) |

**What N3 inherits (grades as filed by the two verifiers).** Two minds, one blind: N112-U1, SIX, NB4′, L60, LOCK, the three-colour merge; N2-SIGN, ENV,
TOWARD (different routes), AWAY, TAN, RED, TERM, FLANK-Q, RAY. N2-DENSE in NB2's form (the owner's ruling): *in every valid map each trichromatic cubic
vertex has a repeated-colour vertex within 2 or a unit-arc centre within 3; every closed disc of radius 4 holds one* [NB2, one mind for this form; N2's
weaker form two minds]. Open and mine: R1 (card R), then (a) the base near a (Q)/(R2) centre, then (b)'s aperiodic case with R2 (card R) and NB2-END.

## Stage N3-1 — SAVED

## Stage N3-2 — SAVED: R1 (card R) — TRUE as corrected, with a sharper form; (b) closed for periodic maps

*Frame: FS110-N4 §2.6. In a terminal valid map (unit arcs allowed), let `P_0, …, P_L` be consecutive stuck vertices of one chain. The two recursions of
C-CHAIN-9 hold between consecutive stuck vertices: at stuck `P_k`, N112-END gives `λ_{k+1} > −1`, so the `a_{k+1}`-horn at `P_{k+1}` is out-type relative
to `P_k` with a shadow circle of curvature `f(λ_{k+1})` (N4-SHADOW, `C ≠ 0`), and N4-STUCK (ii) at `P_k` (which survives unit arcs: N2-4, NB2 divergence 2)
puts `a_{k+1}`'s sector just below the arc `λ_k`; N-E0 gives `λ_k ≤ f(λ_{k+1})`. Mirror: at stuck `P_{k+1}`, `υ_k < 1` and `f̃(υ_k) ≤ υ_{k+1}`. So for
`0 ≤ k < L`: `λ_{k+1} ∈ (−1, 1)`, `υ_k ∈ (−1, 1)`, and only the chain's two outer bounds `λ_0 ∈ [−1, 1)`, `υ_L ∈ (−1, 1]` may reach `∓1`.*

**N3-STEP (the step lemma) [hand, one mind; tools exact, STEP].** *At every step `k → k + 1` of a chain, neither `λ` nor `υ` decreases and at least one of
them strictly increases.* Exact identities (MONO): `f(x) − x = −x²/(1+x)`, `f̃(x) − x = x²/(1−x)`. If `λ_{k+1} ≠ 0`, `λ_k ≤ f(λ_{k+1}) < λ_{k+1}`; if
`λ_{k+1} = 0`, `λ_k ≤ f(0) = 0`. If `υ_k ≠ 0`, `υ_{k+1} ≥ f̃(υ_k) > υ_k`; if `υ_k = 0`, `υ_{k+1} ≥ 0`. So `λ` and `υ` are non-decreasing, and `λ_k = λ_{k+1}`
forces `λ_{k+1} = 0`, hence `υ_{k+1} > λ_{k+1} = 0`, and `υ_k = υ_{k+1}` would force `υ_{k+1} = 0`: one of them moves. ∎ Card R's "each sequence is strictly
increasing in `k` wherever it is nonzero" is TRUE read as "`λ_k < λ_{k+1}` when `λ_{k+1} ≠ 0`; `υ_k < υ_{k+1}` when `υ_k ≠ 0`"; the step lemma is the line its
next sentence needs (both sequences could otherwise sit still where one of them is 0).

**N3-LEN [hand, one mind].** *If every `λ_k`, `υ_k` lies in a finite set `K ⊂ [−1, 1]`, the chain has at most `2|K| − 1` vertices; a one-sided infinite chain
carries infinitely many distinct values among its `λ_k, υ_k`.* The rank of `λ_k` plus the rank of `υ_k` in `K` rises by at least one per step (N3-STEP). ∎
`λ_k, υ_k` are upward curvatures of boundary arcs of the terminal map through `P_k` tangent to `a`, so `K` may be taken as `{±1/r : r a radius of an arc of
the terminal map} ∪ {0}`, cut to `[−1, 1]`.

**N3-RAYR (the ray needs unbounded radii) [hand, one mind; tools exact, RAY].** *On an upward-infinite chain (`k ≥ 0`), `−1/(k+1) ≤ λ_k < 0` and `λ_k < υ_k ≤ 0`
for every `k`: the lower arc of the horn at `P_k` has radius at least `k + 1`. Mirror, downward (`k ≤ 0`): `0 ≤ λ_k < υ_k ≤ 1/(|k|+1)`, `υ_k > 0`.* FIN's upward
count forces `υ_k ≤ 0` (if `υ_m > 0`, `1/υ` drops by 1 per step up and `υ` passes 1), so `λ_k < 0`. `f̃` is increasing on `[−1, 1)`, so `λ_k ≤ f(λ_{k+1})` gives
`λ_{k+1} ≥ f̃(λ_k)`, hence `λ_k ≥ f̃^k(λ_0) = λ_0/(1 − kλ_0)`, and `λ_0/(1 − kλ_0) + 1/(k+1) = (λ_0 + 1)/((1 − kλ_0)(k+1)) ≥ 0` for `λ_0 ≥ −1` (RAY, exact for
`k ≤ 20`; the closed form by induction). Equality throughout is NB2's pencil: `λ_0 = −1` and every lower arc the circle of radius `k+1` about `P_{−1}`. ∎ **So a
stuck ray needs boundary arcs of every large radius, at unit spacing along one line** — sharper than card R's "infinitely many distinct boundary curvatures",
and the same object NB2 recognised, now as the only way down to 0.

**N3-PER (a periodic map has a periodic terminal modification) [hand, one mind].** *Let a valid map `M` be invariant under a rank-2 lattice `Λ` of translations
(colours kept). Then the terminal modification (N2-RED's bends with N4-TERM's merges, ray merges and shaves) can be chosen `Λ`-invariant; it has finitely many
arcs up to translation, so a finite `K`.*
1. No `t ∈ Λ` has `|t| = 1` (else almost every `x` and `x + t` are a same-colour unit pair); `Λ` is discrete, so `d₀ = min{ ||t| − 1| : t ∈ Λ ∖ 0 } > 0`.
2. Perform each operation at all translates of its site at once. The new colouring can fail only at a pair `z ∈ S`, `z′ ∈ S + t` (`t ≠ 0`, `S` the recoloured
   set) given one colour at distance 1; every other pair is a pair of the single operation at `S + t`, valid by translation, and colours only lost create no pair.
   (i) MERGE, MERGE-RAY and SHAVE recolour sets inside `B(v, ρ)` with `ρ` free below a clearance radius (FS110-N4 §2.7): take `ρ < d₀/4`, so `||z − z′| − |t|| <
   d₀/2` and `|z − z′| ≠ 1`. (ii) A bend's lens lies inside one tile (`T_in` toward, `T_out` away; N2-TOWARD's lens stays in `T_in`'s sectors at the ends), so
   `z, z′` had one colour before, and `|z − z′| ≠ 1` by N-E0.
3. Each operation's local properties (a lower `Φ`, no unit arc created, the types of its new vertices, its lens avoiding the nearby centres) hold at each
   translate. Run N2-RED's and N4-TERM's procedure on orbits: one fundamental domain carries finitely many vertices and unit arcs, each orbit operation lowers
   N2-RED's count there, so it stops, and the result is `Λ`-invariant and terminal (an operation available at a site is available at every translate). ∎

**Verdict on R1 (card R): TRUE, as corrected** [hand, one mind, over N4-FIN, N4-SHADOW, N4-STUCK (ii) as surviving unit arcs (two minds), N112-END (two)]:
- **The correction:** a stuck chain lives in the **terminal** map, so the finiteness premise is on the terminal map's arcs. For a periodic map this costs nothing
  (N3-PER). For a map with finitely many arc classes that is not periodic, whether the terminal map keeps finitely many classes is **not derived**: SHAVE's
  circle has the exact curvature `σ_h` of a shadow (`f` or `f̃` of an arc's), and a bend's tangent start at an end vertex has a curvature chosen in an interval,
  so iterated operations may create new classes. Named **GAP N3-ALPH**.
- **What holds:** (i) a one-sided infinite chain needs boundary arcs of radius `≥ k + 1` at its `k`-th vertex (N3-RAYR); (ii) with finitely many arc classes in
  the terminal map, every chain has at most `2|K| − 1` vertices (N3-LEN); (iii) so **a periodic valid map has no stuck ray, and every stuck vertex of its periodic
  terminal map lies within `2|K| − 2` of a chain end** — within `2|K|` of a unit-arc centre (a chain's end is within 1 of a (Q)/(R2) arc of `ω(P_{L+1})` or
  `ω(P_L)`, or of a `≥ 4`-colour vertex, which has a unit-arc centre within 1: NB2-TERM, NB2-DENSE step 2).
- **(b), as A3 asks it:** closed for periodic maps and for every map whose terminal modification has arcs of bounded radius; the **aperiodic case is the named
  GAP**, now sharpened to rays whose horns flatten at rate `≥ 1/(k+1)` (N3-RAYR), with NB2-END as its route (stage N3-4).
- **With NB2-DENSE (applied to `M*`, itself valid):** in a periodic map, every closed disc of radius `4 + 2|K|` contains a unit-arc centre of `M*` (a subset of the
  original map's). Periodicity alone gives some radius (the centres form a periodic set, non-empty by row 134); N3-LEN's radius depends only on the alphabet.

*Where six is spent:* nowhere in N3-STEP, N3-LEN, N3-RAYR, N3-PER (curvature algebra and translation); inherited through N4-STUCK (NB-4 at `P_k`). *Seven-colour
control:* the hexagonal seven-colouring has no stuck vertex; R1 is vacuous there, as required. *The strip (card R's R3 aim):* no stuck vertex (card X; N2-5), so R1
does nothing there.

**Would have searched here:** the longest chain over a named finite `K` (a DP over curvature sequences) — replaced by the rank count; STEP's grid check verifies the
step lemma at named values, not the bound.

**Tool.** `tools/fs112_n3_checks.py --self-test` → `data/fs112/fs112-n/n3-checks-selftest.out`, exit 0: MONO, STEP, RAY green; plants `mono_swap` (`f̃` in place of `f`:
NOT_BELOW), `step_identity` (recursions replaced by plain monotonicity: a quadruple `(−5/6, −5/6, −2/3, −2/3)` with no strict step, NO_STRICT_STEP), `ray_below`
(`λ_0 = −11/10`: BELOW_BOUND) each fire alone, for their own reason.

## Stage N3-2 — SAVED

## Stage N3-3 — SAVED: (a) — the base with unit arcs: every failure is a vertex of four colours or a repeated colour within 2

*Frame. A valid map (unit arcs allowed). A **cubic trichromatic** vertex `u`: three colours, one sector each (cusp sectors allowed), `c(u) = C = {4,5,6}`,
the arcs `τ_45, τ_46, τ_56` leaving `u`, `Ω = ω(u)`. A **leaving centre** of `u`: a point `q ∈ Ω` that is the centre of a unit arc with endpoint `u` (an arc
leaving `u` lies on at most one unit circle, so `u` has at most three). A **both-centre**: the centre of a both-kind unit arc. **Votes** (S–V Prop. 9):
at `q ∈ Ω` a non-unit arc `τ` from `u` votes *in* when `|q − x_τ(δ)| > 1` for small `δ` (then its two colours are absent inside `Ω` near `q`, S–V Prop. 2)
and *out* when `< 1`; the sign is eventually constant unless `τ ⊂ ω(q)`. The **strip holds at `q`** when one side of `Ω` near `q` has only colours
outside `C` (two arcs voting the same way); the base's `γ(u)` is built from it.*

**N3-NOBOTH [hand, one mind; over N112-U1 (two minds)].** *A both-centre `P` is a vertex with at least four colours or a repeated colour.* At `P` the
inner colour's sectors lie in the closed facing cone, the outer colour's in the closed away cone, and the two open side cones (angle `ℓ > 0`) meet neither
(N112-U1), so each side cone contains directions interior to sectors of other colours. One sector (an open angular interval) meeting both side cones
contains the whole facing or the whole away cone, hence the direction of an inner- or outer-colour sector (a cusp horn included): impossible. So the two
side cones carry two further colours, or one colour twice. (A point on an arc, or interior to a tile, has at most two colours: never a both-centre.) ∎
*Consequence:* no both-kind unit arc is centred at a cubic trichromatic vertex — the three-colour (S1) needs a bowtie (C-SEAMS-TWO's centre), and N112-RED's
case split holds with no merge.

**N3-FAIL (the strip at a leaving centre) [hand, one mind; tools exact, VOTES].** *The strip at `q ∈ Ω` fails only if `q` is a leaving centre of `u` (S–V
Prop. 10's proof, by local finiteness). When it fails, the colours of `C` allowed inside `Ω` near `q` are exactly the inner colours of the unit arcs of `ω(q)`
leaving `u`, and outside exactly their outer colours; the third colour is excluded on both sides.* The unit arc `τ ⊂ ω(q)` from `u` has its outer tile's
shadow containing every point of `B(u, 1)` near `q` (points within `< 1` of the arc's endpoint `u`; N112-U1) and its inner tile's shadow containing every
point of the outside near `q` on a curve transversal to `Ω` there. The finite table (`τ_ij` unit, `τ_ik`, `τ_jk` voting; and **DEG2**, `τ_ij`, `τ_ik` both
on `ω(q)`): the strip fails exactly when the two voting arcs vote opposite ways and `τ`'s outer colour is the colour it shares with the arc voting in (DEG2:
when `τ_jk` votes on the side of the arcs' inner colours), and then inside allows only the inner colours, outside only the outer ones (VOTES, 12 rows; the
plant `votes_noshadow` breaks the law for its own reason).

**N3-ANTI (CE5, the Antipodal Lemma, survives unit arcs) [hand, one mind; tools exact, ANTI].** *At a cubic trichromatic `u` no two points of `Ω` at distance
2 are both M-in.* An M-in point admits at most one in-vote (two arcs voting in exclude all of `C` inside). An arc `x(δ) = δt + (δ²/2)κn + O(δ³)` gives
`|x ∓ e|² − 1 = ∓2δ(e·t) ∓ δ²κ(e·n) + δ² + O(δ³)`: for `e·t ≠ 0` it votes in at one antipode and out at the other; for `e·t = 0` it votes in at `+e` unless
`κ(e·n) ≥ 1` and at `−e` unless `κ(e·n) ≤ −1` — never neither; a unit arc on `ω(u ± e)` votes 0 there and in at the other. So each of the three arcs casts
an in-vote at `u + e` or `u − e`: three in-votes against a budget of two. ∎ CE5's step "at an M-in point the strip's majority side is outside" is not
needed; the count of in-votes carries it, cusps and unit arcs included.

**N3-COR3 (Cor. 3 with unit arcs: the unit rhombus) [hand, one mind].** *Let `u`, `u′` be cubic trichromatic vertices with disjoint multicolours at distance
`d < 2`. Then each of their two common unit points `q` is a leaving centre of `u` **and** of `u′`, and a vertex with at least four colours, two from each
triple; a unit arc of `ω(q)` leaving `u` is both-kind at `q` (in DEG2, one of the two).* So `u, q₊, u′, q₋` is a **unit rhombus whose other two corners
are four-colour vertices** — FS-110's T2, now forced.
*Proof.* If `u′`'s strip holds at `q`, a side `S′` of `ω(u′)` near `q` has only colours of `C` (the complement of `c(u′)`). `Ω` crosses `ω(u′)` transversally
at `q` (`0 < d < 2`) and meets no tile of a colour of `C` (N-E1 at `u`), so its half in `S′` lies in `Γ`: an arc of `Γ` on `Ω` whose two sides have colours in
`C` — both-kind at `u`, against N3-NOBOTH. So `u′`'s strip fails at `q` (a leaving centre of `u′`, N3-FAIL), and likewise `u`'s. Now the half `h₁` of `ω(u′)`
inside `Ω` near `q` meets only tiles of colours in `C` (N-E1 at `u′`) allowed inside (N3-FAIL: the inner colours `s_in` of `u`'s unit arcs at `q`): so either
an `s_in`-tile has `q` in its closure, or `h₁` is an arc of `Γ` on `ω(u′)` whose sides are not both in `c(u′)` (N3-NOBOTH at `u′`), hence one side is an `s_in`
colour — `s_in ∈ c(q)` either way. The outside half `h₂` (transversal, so inside the inner tile's shadow) gives an outer colour. Symmetric for `u′`. ∎

**N3-I ((i) never fails) [hand, one mind].** *For unit pairs `x ∈ ω(u₁)`, `y ∈ ω(u₂)` (the base's circles, `u_k` cubic trichromatic), `c′(x) = c′(y) = {a}` is
impossible.* Where the strip holds at `x`, CB's proof stands (the half of `ω(y)` on the strip side meets an `a`-tile: after merging, no `a|a` arc exists). The
strip fails at no more than three points of `ω(u₁)`; `c′` is locally constant at singletons (`{p : a ∈ c′(p)}` is closed and `c′ ≠ ∅`), so a failure at
`(x, y)` would recur at nearby unit pairs `(x′, y′)` with `x′` not a leaving centre. ∎

**N3-II ((ii) fails only at four-colour or repeated-colour vertices) [hand, one mind].** *Let `x ∈ ω(u₁)`, `y ∈ ω(u₂)`, `|x − y| = 1`, `c′(x) = c′(y) = {a, b}`,
`ω(y)` transversal to `ω(u₁)` at `x`. Then `x` has at least four colours, or `y` has at least four colours or a repeated colour.* Strip holds at `x`, side `σ`:
near `x` on `σ` only `a`, `b` occur; the half of `ω(y)` on `σ` avoids both (`⊆ c(y)`), so it lies in `Γ`: an arc of `ω(y)` with sides `a | b` — both-kind at
`y`, so N3-NOBOTH. Strip fails at `x` (a leaving centre of `u₁`): by N3-FAIL the halves of `ω(y)` at `x` meet, inside, only `a`, `b` and the inner colours,
outside only `a`, `b` and the outer colours; avoiding `a, b` they give an inner and an outer colour to `c(x)`, unless a half is a `Γ`-arc of `ω(y)` with sides
`a | b` (both-kind at `y`). So `c(x) ⊇ {a, b, s_in, s_out}` or `y` is a both-centre. ∎ With `u₁ = u₂ = u` this is (ii) on `Ω` at pairs `60°` apart.

**N3-P′ [hand, one mind].** *Two cubic trichromatic vertices with one multicolour are never at distance 1.* A failure of (P′) at `(p, p′)` needs `ω(p′)` along `Γ`
on both sides of `p`, with side colours in `c(p) = c(p′)`: both-kind at `p′`, against N3-NOBOTH. ∎ Pigeonhole points of distinct multicolours never nest
(same size, distinct). **So no (P′)-nesting pair is ever handed to Lemma 3 or Cor. 3** — A3's question, answered; and N2's "trichromatic end vertex nests
into its centre only at a junction of two centred arcs" never fires at a pigeonhole pair (the centre would be a both-centre with three colours).

**The pseudo-colouring of `ω(p)`, `p` cubic trichromatic [hand, one mind].** `c′ ≠ ∅`: a point of `ω(p)` with no colour outside `c(p)` has `ω(p)` in `Γ` on both
sides, with sides in `c(p)` (N-E1) — both-kind at `p`. `|c′| ≤ 2`: a point `x` with `c′(x) ⊇` the whole complement is cubic trichromatic and complementary to `p` at
distance 1 (then N3-COR3 puts four-colour vertices at `p ± 60°` on `ω(p)`), or itself has four colours or a repeated colour. Finitely many two-colour points:
an **inert** unit arc of `ω(p)` (both sides outside `c(p)`) bends toward `p` (N2-TOWARD, two minds), a valid modification in which no point gains a colour or a
sector; the base is run on it.

**The eleventh point [hand, one mind].** Let `R` be the component containing `u` of the interior of the union of closures of `C`-tiles (connected through shared
arcs). `R` is open and cannot meet `Ω`: a point of `Ω` in `R` has a neighbourhood whose tile points are `C`-coloured, so `Ω` there lies in `Γ` with `C` on both
sides — both-kind at `u`. So `R ⊂ B(u, 1)` with no use of `γ(u)`, and the eleventh point on `∂R` is within `1` of `u`.

**N3-BASE (the base at a cubic trichromatic vertex, unit arcs allowed) [hand, one mind; over row 134's base: CB's route with CE's repairs, CUSP-BASE, Prop. 17
on its printed route (FS110-P17; its unit-arc exception is row 12's both-kind arc)].** *In a valid map, if `B̄(u, 2)` contains no vertex with four or more
colours and no vertex with a repeated colour, the base refutes the map near `u`.*

| the base's step (CB / CE) | Condition 5 used for | with unit arcs | where the exception lives |
|---|---|---|---|
| (P) sweep | — | holds | — |
| (P′) for the pigeonhole's same-multicolour pairs | `ω(p′)` meets `Γ` finitely at `p` | N3-P′ | nowhere (cubic) |
| D2 strip, `γ(u)` | Prop. 10 | fails only at `≤ 3` leaving centres per vertex (N3-FAIL) | used only through the rows below |
| `c′ ≠ ∅`, `|c′| ≤ 2`, finiteness | the strip; Cor. 3; Condition 5 | above | a four-colour vertex on `ω(p)` or at `p ± 60°` |
| (i) | transversal circle meets a tile | N3-I | nowhere |
| (ii), Lemma 3's swaps and endpoints, CE7, Lemma 5, Prop. 18 | (ii) | N3-II | `x` or `y`, points of `ω(p)`, `p ∈ B̄(u, 1)`: within 2 |
| Cor. 3 (disjoint pigeonhole pairs) | `γ(u)`, `γ(u′)` | N3-COR3 | the rhombus corners, within 2 |
| CE5 (distance 2) | the strip's majority | N3-ANTI | nowhere |
| Prop. 17 | the arc between `g` and `q` at `x₁` not on `ω(x₂)` | row 12: both-kind at `x₂` | `x₂ ∈ Ω` |
| D5's reduction (R1–R4), 10+1 count, hole-filling | (P′), (i), generic centres | as above; centres moved off the finitely many unit-arc centres | as above |
| the eleventh point | `R` inside `γ(u)` | `R ⊂ B(u, 1)` by N-E1 | nowhere |

**N3-DENSE3 [hand, one mind, over N3-BASE, NB2-DISC1 (two minds) and N2-TOWARD (two)].** *In every valid map, every closed disc of radius 3 contains a vertex
with at least four colours or a vertex with a repeated colour.* A closed disc of radius 1 holds a vertex `w` of degree `≥ 3` (NB2-DISC1); if `w` is cubic
trichromatic, N3-BASE puts one within 2 of it. (Moves never add a colour or a sector to an existing point, so the modification's witnesses are the map's.)

**What it does to the question.** NB2-DENSE's alternative "a unit-arc centre within 3" is now **"a vertex of four or more colours within 2"**: a unit arc saves
the base only through a vertex where four colours meet. **(R2) centres never save it**, nor does any unit arc whose centre carries three colours; after
N2-RED the (Q) centres are exactly the four-colour vertices that do. So a YES of Q-full is a map whose four-colour (or repeated-colour) vertices come within 3 of
every point, and a NO is the exclusion of such maps: **the unit-arc half of Question 2 is a question about four-colour vertices**, with NB4′ describing each one
((E1): `≥ 60°` of centred arcs; (E2)) and N3-COR3 describing how pairs of them hold a close complementary pair.
*Where six is spent:* N3-COR3 ("the complement of `c(u′)` is `c(u)`"; with seven colours `u′`'s strip leaves a fourth colour and the argument stops), the base's
count and NB4′; N3-NOBOTH, N3-FAIL, N3-ANTI, N3-I spend nothing. *Seven-colour control:* the hexagonal seven-colouring has no four-colour vertex and no unit arc,
and is valid; N3-BASE does not start there (four ring colours), as required. **The strip (killing test 8):** N3-BASE reads `B̄(u, 2)`, and no trichromatic vertex of
a strip of half-height `1.834` has that disc inside it; the strip cannot test N3-BASE, and its midline four-colour vertices are within `1.834` of all its points,
as N3-DENSE3 asks. N3-COR3 is local (it reads `u, u′`, the rhombus and small discs about its corners) and **is** testable on the strip (registered below).
**C-LOCAL:** N3-DENSE3 is local and explicit (radius 3); not a NO.

**Registered (G21 instruments, scored at the close).**

| id | prediction | p | both outcomes reachable |
|---|---|---|---|
| N3-P1 | on the exact strip, every pair of trichromatic vertices with disjoint multicolours at distance `< 2` whose rhombus lies inside the strip has both rhombus corners at four-colour (midline) vertices, each the centre of arcs leaving both | 0.9 | the rebuild reads every such pair; a pair with a three-colour corner refutes N3-COR3 |
| N3-P2 | a blind second mind finds N3-BASE TRUE, possibly with a repair in a row of its table | 0.6 | a step of the base whose unit-arc exception is not a four-colour or repeated-colour vertex refutes it |
| N3-P3 | the (R2) centres of any held positive with unit arcs are at distance `≤ 2` from a four-colour vertex wherever the base's disc fits | 0.8 | an (R2) centre far from every four-colour vertex in a region where N3-BASE's disc fits refutes N3-BASE |

**Would have searched here:** vertex figures at a leaving centre (an enumeration) — replaced by the finite vote table VOTES; arcs' curvatures against the
antipodal votes (a scan) — replaced by the second-order formula and named exact values (ANTI).

## Stage N3-3 — SAVED

## Stage N3-4 — SAVED: R2 (card R) — the chain's end is anchored at four-colour vertices; R3 read on the held positives; precisions to stage N3-3

**Precisions to stage N3-3 (written after its commit; no verdict changes).**
1. N3-FAIL's shadows need no first-order cone: the unit arc `τ ⊂ ω(q)` leaving `u` has `u` in the closure of both its side tiles, so for `z` near `q`,
   `|z − u| < 1` puts points of `T_out` within `< 1` of `z` (and `T_out` has points beyond `1 + η₀` from `q`), and `|z − u| > 1` puts points of `T_in` beyond 1
   (and `T_in` has points within `1 − η₀` of `q`). So `s_out` is absent from **all** of `B(u, 1)` near `q` and `s_in` from **all** of the outside near `q`; the
   word "transversal" in N3-FAIL and N3-COR3 is not needed.
2. Prop. 17 in N3-BASE's table is taken on N3-P17's route (FS110-P17); row 12 of the walk names its one Condition-5 use. The ring lemmas it rests on (FS110
   N2-ROT, N2-HEX) were not walked separately in this job or in N's walk: **a named check for the verifier.** CB's own route (D5 item 5) reads the directions of
   the branches of `ω(x_{i±1})` at `x_i`; with a unit arc of `ω(x_{i+1})` through `x_i` that is not both-kind, its sector constraint weakens, so that route is not
   used here.

### R2 — "a stuck chain whose end carries a horn bound of exactly ±1": not excluded; what it forces [hand, one mind]

*Frame: FS110-N4 §2.5 (at `P_k` the cone colour is `a_k`, `a_{k−1}` fills the `+n` side, `a_{k+1}` the `−n` side). A chain `P_0, …, P_L` of stuck vertices of a
terminal map with `λ_0 = −1`: the lower arc `α` of `P_0`'s `+a` horn `H₊` (colour `c = a_0`) is a unit arc of `ω(P_{−1})` leaving `P_0`, with `s_out = c`, `s_in = h = a_1`;
`g = a_{−1}`; stuck `P_0` has `P_cl(P_0) = {c, g, h}`.*

**N3-END.** *Either `υ_0 = 1` too — both of `P_0`'s horns lie between `ω(P_{−1})` and `ω(P_1)`, `P_0` is a one-vertex chain, and the in-type `g` at `P_1` and `h` at
`P_{−1}` make both neighbours unit-arc centres — or:*
1. *`P_{−1}` carries `c` (N3-DEG at `P_0`) and two `g`-sectors, tangent to `+a` and to `−a` from below (FLANK for the upper flank `g`, which `λ_0 = −1` does not touch; an
   in-type `g` at `P_1` would force `υ_0 = 1`, N2-FLANK-Q), separated by `c` below and by `r′` or `h` above;*
2. *terminality forces `int D_g(P_{−1}) = ∅` (else W-MERGE), so an out-type `g`-tile at `P_{−2}` and `g`'s two sectors are horns `G_±` along `±a` (N3-DEG);*
3. *the colour `y` just below `G₊` lies in `α`'s side cone `(−ℓ, 0)` at `P_{−1}`, so `y ∉ {c, h}` (N112-U1), `y ≠ g`, and `y ≠` `G₊`'s upper flank (else SHAVE); so
   **`P_{−1}` has at least four colours and a repeated colour**;*
4. *`G₊` is not shaveable (terminal), so its lower flank `y` shadows it; FLANK's list admits only `y`-tiles at `P_0` (absent: `y ∉ P_cl(P_0)`) or, at lower bound `−1`,
   an in-type `y`-tile at `P_{−2}`: so **`G₊`'s lower arc `β` is a unit arc of `ω(P_{−2})` through `P_{−1}`, with `s_out = g`, `s_in = y`, both at `P_{−2}`** — both-kind, so
   `P_{−2}` has four or more colours or a repeated colour (N3-NOBOTH).*
*Proof:* items 1–4 as stated; the SHAVE of item 4 with an absent `y`-shadow is valid (FLANK's list is complete when no in-type `y` sits at `P_{−2}`; the new circle
has curvature `κ₊ ∈ (−1, 1)`). ∎ The mirror holds at an upper end `υ_L = 1`.

**The step that fails, named.** N112-END would exclude the end if `P_{−1}` were stuck; `P_{−1}` does carry a repeated colour with horns along `±a` (item 2), but
N4-STUCK (ii) — the step END uses ("`c` fills the whole `−n` half-plane") — needs **three colours at `P_{−1}`**, and item 3 gives four. So **R2's object is not
excluded by the local calculus; it is anchored**: its end puts a four-colour vertex with a repeated colour one step beyond it and a both-kind unit arc centred two
steps beyond it. This is **NB2-END made unconditional** (its premise, two `g`-sectors at `P_{−1}`, fails only in the doubly bounded one-vertex case, `υ_0 = 1`), and
it is C-UA-CHAIN's shape: *a chain's end forces a further unit arc one step beyond it*.
*Where six is spent:* item 3 (the four colours at `P_{−1}` are counted among six only through `P_cl(P_0) = {c, g, h}`, NB-4 at `P_0`). *Seven-colour control:* no
stuck vertex; vacuous.

**(b), after R1 and N3-END.** A stuck ray's end is anchored at four-colour vertices (N3-END); its vertices are repeated-colour vertices, so it is consistent with
N3-DENSE3 along its line; its horns flatten at rate `≥ 1/(k+1)` (N3-RAYR). **GAP (b′), named:** whether a stuck ray can live in a valid map of the plane — a
whole-line object; for periodic maps it cannot (N3-PER, N3-LEN).

### R3 — the held positives' close complementary pairs, at both common unit points [a reading of held text and held formulas; N3-COR3 applied]

| held positive | close complementary pair(s) | saved at the first common unit point by | at the second by | reading grade |
|---|---|---|---|---|
| FS-110 **T2** (`tools/fs110_y_fragments.py` header: "u on a full arc of omega(w) plus a ray along omega(w′); v its point reflection; w, w′ four-colour vertices") | `(u, v)`, `d = 1`, cubic | `w`: a four-colour vertex, centre of arcs leaving `u` (two, through `u`: DEG2) and leaving `v` | `w′`: the same, one arc each | the fragment's formula, as its header states it — **N3-COR3's rhombus exactly** |
| FS-110 **S1** ("a bowtie u whose unit circle carries two boundary arcs … through w and w′") | `(u, v)`, `u` a bowtie | an arc of `ω(u)` through `w`, both-kind at `u` — a **repeated colour** at `u` (N3-NOBOTH's other branch) | the same at `w′` | header |
| FS-110 **BB** ("u and v bowties escaping at both w and w′ (all straight)") | `(u, v)`, both bowties | the bowties' repeated colours (no unit arc); `w` four-colour | the same at `w′` | header |
| FS-110 **MX** ("u a bowtie lying on a full arc of omega(w) (T2 at w, escape at w′)") | `(u, v)` | `w`: T2's four-colour double centre | `w′`: `u`'s bowtie | header |
| **CAL-STRIP** (`[AxenovichEtAl2014]` p. 8: "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile"; `[07.10]`: "each vertex down the middle mandates four such curved edges") | not in the printed words (the colours are in the figure) | — | — | the words fix only that every unit arc is centred at a tile corner opposite it, the midline corners each centring four |

**What N3-COR3 says of the strip, from its words and card X's midline fact (my record, N2-4):** every close complementary pair of cubic trichromatic vertices whose
rhombus lies inside the strip is saved at **both** common unit points, and only by four-colour vertices that are centres of arcs leaving both; if the strip's only
four-colour vertices are its midline vertices, both rhombus corners lie on the midline, so **the pair is a mirror pair across the midline** (a rhombus's diagonals
bisect each other at right angles). Every held positive saves each of its close complementary pairs at both common unit points by a four-colour vertex or a repeated
colour — never by a three-colour unit-arc centre.

**Registered (G21 instruments).**

| id | prediction | p | both outcomes reachable |
|---|---|---|---|
| N3-P4 | on the exact strip, every close complementary pair of cubic trichromatic vertices inside it is a mirror pair across the midline, both common unit points midline vertices | 0.75 | a pair with a corner off the midline (a four-colour vertex elsewhere, or a refutation of N3-COR3 if that corner has three colours) |
| N3-P5 | a construction of R2's object by formula (a finite chain with `λ_0 = −1`) has four or more colours at `P_{−1}` and a unit arc of `ω(P_{−2})` through `P_{−1}` | 0.85 | a checked fragment with three colours at `P_{−1}`, or no arc at `P_{−2}`, refutes N3-END |

**Would have searched here:** end configurations at `P_{−1}` (sector orders; an enumeration) — derived from FLANK, N3-DEG and N112-U1's side cone instead.

## Stage N3-4 — SAVED
