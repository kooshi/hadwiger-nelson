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

*(filled stage by stage; one line each, grade and address)*

### N2: would-have-searched-here log

- (none yet)

### N2: fence log

1. `git log --oneline -1` (checking the tree before the first commit) printed one subject beyond the start-up snapshot: "FS-112 inventory: A3 launched".
   No further `git log`.
2. `ls data/fs112/` printed the names of fenced directories (`fs112-a`, `fs112-a2`, `fs112-y`, `fs112-yb`, `reports`); nothing inside them listed or
   opened. `ls data/fs112/briefs/` printed the other jobs' brief names; none opened.
3. Read, not fenced for me: `plans/FS112-unit-arc-half.md` §5.3 (the owner lifted it for the proof side after N's stage 1; N2's brief does not re-fence it).

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
