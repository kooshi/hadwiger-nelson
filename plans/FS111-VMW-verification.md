# FS111-VMW — the blind verifier of FS-111's round 1 (competitors M and W together)

*Job FS111-VMW (de Bruijn, Opus 5.5), opened 2026-09-28 07:42 UTC. Brief: `data/fs111/briefs/VMW-111-verify.md`, with
`data/fs111/briefs/STANDING-RULES.md`. Blind to both competitors' records, directories and tools, and to `data/fs111/reports/`, until stage 1
is committed. Working files: `data/fs111/fs111-vmw/`. Tools: `tools/fs111_vmw_*.py`.*

## Theorems this phase proved

*(every line: statement, grade, count of minds, address; "one mind" = this verifier, blind)*

- **VMW-R7-PROPER** — R7 (Reuleaux triangles of width 1 on the up triangles, coloured by `Λ/2Λ`; the cusped down triangles, i.e. the curvilinear
  triangles between three pairwise tangent unit circles, coloured by `Λ/M`) tiles the plane and is a.e.-proper and tight. [hand + tools exact, one mind] §1.5
- **VMW-R7-SAT** — R7 is saturated in the claim list's sense: every `x ∈ ∂_e S_j` is a `j`-contact point, and `|S̃_j ∩ A_η(x)| > 0` for every
  `η > 0`. [hand + exact certificates, one mind] §1.5
- **VMW-R7-MAX** — R7 is saturated in the strongest reading too: for every point `x` and every colour `j` with `x ∉ S̃_j`, some point of `cl S̃_j` is at
  distance exactly 1 from `x`; so no fill move of any colour at any point keeps it a.e.-proper. [hand, one mind; exact grid of 144 points, 0 exceptions] §1.5
- **VMW-R7-P+** — R7 is **not** saturated if contact partners must have positive density: at the named point `x = (1, √3 − 1)` (exact) and at all 69
  exact relative-interior points sampled on a down tile's arcs, the only same-colour closure point at distance 1 is the cusp of the neighbouring
  same-colour down tile (density 0); partner of the named point `(1, √3)`. [hand (cone lemma) + exact, one mind; "every relative-interior point" is
  sampled, not proved] §1.5, §2.2 (`tools/fs111_vmw_pplus.py`, scope corrected at stage 2)
- **VMW-R7-COVER** (stage 2) — by VMW-R7-MAX, R7's seven classes form a **maximal admissible cover** in M-SATC's sense with disjoint classes: the cover
  form and the honest form of saturation coincide at R7 (M left the down classes' maximality open). [hand, one mind] §2.3
- **VMW-SQ9, VMW-HEX9** — squares of side `1/2` coloured `(i mod 3, j mod 3)` and hexagons of width `1/2` coloured by `Λ′/3Λ′` are a.e.-proper, tight
  and saturated, in the literal reading and with positive-density partners (every edge faces a same-colour edge at distance exactly 1). [exact
  certificates + hand, one mind] §1.8
- **VMW-DECO** — the hexagonal seven-colouring with two squares of side `1/100` per hexagon (colour `a ± 1` hugging the `a ± 1` neighbour) is tight and
  a.e.-proper, and no class has tight block structure. [exact + hand, one mind] §1.6
- **VMW-BLOCK-EQ** — for a colour class that is a union of open connected components, a.e.-proper: every two components are linked (all cross
  distances `< 1`) or apart (all `> 1`), and tight block structure ⟺ Cohen–Mani block structure ⟺ "linked" is transitive. [hand, one mind] §1.6
- **VMW-HULL (the common form of C-HULL-REG)** — two-colour saturated interfaces with one-sided partners are `C^{1,1}` with `|κ| ≤ 1`, sandwiched
  between tangent unit discs about the partners; (in, in) impossible; (in, out) forces a unit arc about a common partner. [hand, one mind] §1.7
- **VMW-NEG** — FS111-W-NEG's first two clauses TRUE; "A-ALL failing ⟹ `χ_m⁰ ≤ 6`" TRUE over row 131's disc form; "B-RR failing ⟹ `χ_m⁰ ≤ 6`"
  MISSTATED (true of the joint statement with `R, δ` free, not at A-ALL's fixed `R, δ`). [derived, one mind] §1.9

## Would-have-searched-here log (standing rule 3)

- Stage 1: would have run a colouring finder on R7's tiles to test properness — proved it by the slab and cone lemmas and checked every same-colour
  pair near one tile of each type exactly (`tools/fs111_vmw_exact.py`), with an independent float Monte Carlo as a guard (`tools/fs111_vmw_floatx.py`).
- Stage 1: would have searched for a free point of R7 numerically — derived saturation by certificates (arc centres are same-colour cusps or corners),
  then proved the strongest reading by a covering argument; the exact 144-point grid is a check, not the proof.
- Stage 1: would have searched for W's decorated colouring — built one by formula (VMW-DECO) and checked it exactly.
- Stage 1: would have searched for a saturated seven-colouring with positive-density partners (the reading under which R7 fails) — did not; recorded it
  open (§1.5 (e)).

## Fence log (standing rule 13)

- Before any fenced read: `git log --oneline -8` at start-up showed one commit beyond the start-up snapshot (`817bf13b`, subject "FS-111: round 1
  compared; blind verifier on the saturated seven-colouring"); subject only, nothing opened.
- `ls tools/ | grep fs111` displayed the **names** of fenced tool files (`fs111_m_reuleaux7.py`, `fs111_w_blocks.py`, `fs111_w_check.py`,
  `fs111_w_hex7_free.py`, `fs111_w_hx_pairs.py`); none opened. The start-up git status had shown untracked names under `data/fs111/fs111-w/`; none opened.
- No fenced record, directory content, report, transcript, `chats-bak/` file or foreign scratchpad file was opened before stage 1's commit.
- Stage 1's commit step: `git status --short` printed the **names** of FS-114 files (`plans/FS114-N4-proof.md`, `data/fs114/fs114-n4/*.out`,
  `tools/fs114_n4_bowtie.py`), fenced always; none opened.
- Stage 2 (after `3ea1d5ab`, pushed): read `plans/FS111-M-regularity.md` and `plans/FS111-W-wild.md` in full, `data/fs111/reports/FS111-M.md` and
  `FS111-W.md`, `data/fs111/fs111-w/blocks.out` and the docstring and `build` of `tools/fs111_w_blocks.py` (ll. 1–40), and listed
  `data/fs111/fs111-m/`, `data/fs111/fs111-w/`, `data/fs111/reports/`. Not opened: the other competitor tools and outputs, the P and V0 reports, and
  everything fenced always.

## Stage 1 — SAVED: blind verdicts on items 1–6

### 1.1 Files read, in order

The brief; `STANDING-RULES.md`; `CLAUDE.md` § The aim, § Counter-priors, G20, G82 (from disk; G21 as loaded); `data/fs111/claims.md` in full;
`data/fs106/claims.md` §0–§1, §5 and its corrections; `plans/FS107-derivation.md` §1–§2 (and its header); `plans/FS111-V0-verification.md` in full;
`~/source/library/notes/polymath16-threads-1-18-text.txt`, thread 4 (line 16 of the held text), the passages containing "Reuleaux" and "fattened".

### 1.2 Quotation check (standing rule 5)

| # | quotation in the brief | source | result |
|---|---|---|---|
| 1 | C-SAT-T's conclusion, "a colouring is **saturated** if, in D-NF, no `x ∈ ∂_e S_j` is `j`-free, for every `j`" | `data/fs111/claims.md` §3, C-SAT-T | **first half verbatim; the second half dropped**: the source continues "; so every essential boundary point is a `j`-contact point for every `j ∈ P(x)`" — the clause that fixes the reading of "for every `j`" (§1.3). Not an emptying, but it removes the text that settles item 1 |
| 2 | "saturation at every essential boundary point, the Reuleaux corners and the down triangles' cusps included" | the brief's own instruction | n/a |
| 3 | the definitions D-NF, `j`-free, `j`-contact, `∂_e S_j` used in the brief | `data/fs111/claims.md` §0; D-NF also `data/fs106/claims.md` §0 | verbatim (D-NF a prefix of FS-106's) |
| 4 | the names REG-A_k, REG-I_k, REG-J_k, REG-B_k, A-ALL, B-RR, C-HULL-REG, C-SAT-T | `data/fs111/claims.md` §3–§4 | present, statements read there |
| 5 | prior art, "`[Polymath16threads]` thread 4, de Grey, 5 May 2018" | the held threads, line 16 (thread 4, posted 5 May 2018); comment "ag24ag24 says: May 5, 2018 at 4:37 pm": "if all the triangles in one of the orientations are “fattened” into Reuleaux triangles then they still need only four colours but the other (concave) triangles now only need three." `ag24ag24` is de Grey (line 55: "Aubrey, could you do an independent check? Reply ag24ag24") | **verified**; the comment gives the counts 4 + 3, not the coset rule — the rule `Λ/2Λ`, `Λ/M` is the brief's, and it is the right one (M is the unique index-3 sublattice with no unit vector, §1.5) |
| 6 | M-R7; W-P1 "no saturated 7-colouring exists" at 0.65; "C-SAT-T a GAP at `k = 7, 8`"; W-SQ9, W-HEX9; W-DECO-B; REG-B "TRUE for 7 or more colours (checked exactly)"; M-BLOCK-EQ; M-PINCH/M-C11; W-C11/NOBEND/NOREP; W-NEG; M-REDUCE-I | the competitors' records (fenced) | **deferred to stage 2**; every verdict below is on the statement as the brief gives it |
| 7 | `CLAUDE.md` G20, G21, G82, § The aim, § Counter-priors | `CLAUDE.md` on disk | read; nothing in the brief quotes them |

### 1.3 The readings of "saturated", fixed before any check

In D-NF, `A*_j = {d̄_j > 0}`, `∂_e S_j = A*_j ∖ S̃_j`; `x ∈ A*_j` is `j`-free if `|S̃_j ∩ A_η(x)| = 0` for some `η > 0`. Since `supp S_j := cl S̃_j` is closed
and `S(x, 1)` compact, **`x` is `j`-free ⟺ `S(x, 1) ∩ cl S̃_j = ∅`** (a point `y ∈ cl S̃_j` on `S(x, 1)` gives `A_η(x) ⊇ B(y, η)`, an open set containing a
density point of `S_j`, hence meeting `S_j`, and so `S̃_j`, in positive measure; conversely `dist(S(x,1), cl S̃_j) > 0` gives an annulus missing `S̃_j`). So
`j`-free ⟺ not a `j`-contact point.
- **(L) literal:** no `x ∈ ∂_e S_j` is `j`-free — `x` ranges over `∂_e S_j ⊆ A*_j`, so only `j ∈ P(x)`; the claim list's own gloss "for every `j ∈ P(x)`".
- **(B) boundary, every colour:** every essential boundary point is a `j`-contact point for every colour `j`.
- **(A) everywhere:** every `x` and every `j` with `x ∉ S̃_j` has `S(x,1) ∩ cl S̃_j ≠ ∅` — equivalently, no fill move of any colour at any point keeps the
  colouring a.e.-proper (C-FILL's converse holds: a contact `y` makes the filled disc's unit pairs to `S̃_j` non-null).
- **(P+) positive-density partner:** as (L), but the contact point `y` must have `d̄_j(y) > 0`. Not the claim list's definition (its `j`-contact allows any
  `y ∈ cl S̃_j`, and its `j`-free is a measure condition, which a density-0 partner fails to meet); recorded because it is the one reading under which R7
  fails.

(A) ⟹ (B) ⟹ (L); (P+) ⟹ (L).

### 1.4 The tools (exact; each with a planted fault beside a faithful twin; calibrated on HEX7)

- `tools/fs111_vmw_exact.py` — `ℚ(√3)` arithmetic (signs by squaring), unit arcs and segments, the extrema of `|x − y|` between two pieces by
  critical-point candidates (all of the form `±√q + k`, compared with 1 by squaring), `pair_range` (is `1 ∈ (dmin, dmax)`; is `dmin` or `dmax` exactly 1),
  `point_contact` (`dmin(x,T) ≤ 1 ≤ dmax(x,T)`), and certificates for whole boundary pieces: an arc whose centre lies in a closed same-colour tile, or a
  segment whose unit translate lies in one. For two connected closed tiles with interiors, "no two interior points at distance 1" ⟺ `1 ∉ (dmin, dmax)`
  (the product of interiors is connected, `|x − y|` is open off the diagonal).
- `tools/fs111_vmw_tilings.py` — HEX7, R7, SQ9, HEX9 by formula; output `data/fs111/fs111-vmw/tilings.out`.
  - **Calibration (HEX7, circumradius 1/2):** proper; tight (`dmax = 1` inside each hexagon); **not saturated** — all six edges uncertified, every edge
    midpoint free for its own colour (and for one neighbour colour), every vertex not free, as V0 found.
  - **Plants:** R7-P1 (down triangles by `⟨3e1, e2⟩`, which holds a unit vector) → improper pairs `D0,0`–`D0,±1` named; R7-P2 (Reuleaux by `⟨4e1, e2⟩`) →
    improper `R0,0`–`R0,±1`; CERT-P (the tile holding a down arc's centre removed) → the arc loses its certificate. Faithful twins pass.
- `tools/fs111_vmw_strong.py` — the readings (L), (B), (A) at exact sample points (rational-Pythagorean points of each arc, rational points of each
  segment, named interior points); `--grid`: reading (A) on R7 over an exact `12 × 12` grid of one lattice cell. Outputs `strong.out`, `strong_grid.out`.
  **Plant:** R8 (down triangles coloured by `Λ/2Λ`, eight colours, proper) → 69 of 75 down-arc samples free for their own colour; the faithful R7 → 0.
  **Tool defect found and fixed in the first grid run:** curved tiles had boundary-only membership, so points inside a Reuleaux tile read as free for its
  own colour (12 false alarms, all on the edge `[0, e2]` of `R0,0`); an exact member test was added. The defect pointed *against* the result (it made
  R7 look non-maximal), and fixing it changed only the own-colour attribution.
- `tools/fs111_vmw_deco.py` — VMW-DECO; plant: squares at offsets `6/100–7/100` → the `E`–`W` pair straddles 1, named. Output `deco.out`.
- `tools/fs111_vmw_floatx.py` — an independent **float** Monte Carlo of R7's properness from the tiles' defining inequalities (not the exact engine's
  piece model): faithful 0 flagged pairs, plant 22. A guard on the engine's candidate sets, not a verdict. Output `floatx.out`.

### 1.5 Item 1 — M-R7: **TRUE** under the claim list's definition (and under every stronger reading); FALSE only under (P+)

**The object.** `Λ = ℤe1 + ℤe2`, `e1 = (1, 0)`, `e2 = (1/2, √3/2)`. Up tile `R_p = ⋂_{v ∈ {p, p+e1, p+e2}} B̄(v, 1)`, colour `p mod 2Λ` (4 colours). Down
tile `D_q = U_q ∩ ⋂_{c ∈ {q, q+2e1, q+2e2}} {|x − c| ≥ 1}`, `U_q` the down triangle `q+e1, q+e2, q+e1+e2`; the three circles are pairwise tangent at the
cusps `q+e1, q+e2, q+e1+e2` (centres 2 apart). Colour `q mod M`, `M = ⟨(0, √3), (3/2, √3/2)⟩ = ⟨−e1+2e2, e1+e2⟩ = {ae1 + be2 : a ≡ b (3)}` (3 colours). The
index-3 sublattices of `Λ` are `⟨3e1, e2⟩`, `⟨3e1, e1+e2⟩ = M`, `⟨3e1, 2e1+e2⟩ ∋ e2 − e1` and `⟨e1, 3e2⟩`: M is the only one without a unit vector.
*Tiling:* `R_p` is `T_p` plus three circular segments, each over an edge inside the down triangle across it; the three segments inside `U_q` are
disjoint (tangent discs) and `U_q` minus them is `D_q`. Every lattice point is a Reuleaux corner of three tiles (`120°` each, colours `v, v−e1, v−e2 mod 2Λ`,
distinct) and a cusp of three down tiles.

**(a) a.e.-proper [hand + tools exact].**
- *Inside a tile:* `R_p` has constant width 1; `D_q ⊂ U_q` has diameter 1 (cusp to cusp); interior pairs are `< 1` (move a point of a pair inward).
- *Reuleaux pairs:* `t = p′ − p ∈ 2Λ∖{0}`. `|t| = 2`: the rotation by `120°` about `T_p`'s centroid preserves `Λ`, `2Λ` and the up tiles, so with the swap
  `t ↔ −t`, WLOG `t = 2e1`. The arcs' maxima of `x₁` show `R_p ⊂ {x₁ ≤ p₁ + 1}` meeting the line only at `p + e1`, and `R_{p+2e1} ⊂ {x₁ ≥ p₁ + 2}` meeting
  it only at `p + 2e1` (**slab lemma**): `|x − y| ≥ 1`, equality only at those two corners. `|t| ≥ 2√3`: each tile lies within `1/√3` of its centroid,
  distance `≥ 4/√3 > 1`.
- *Down pairs:* `m ∈ M∖{0}`. `|m| = √3`: WLOG `m = −e1 + 2e2 = (0, √3)` (the rotation about `U_q`'s centroid preserves `M`). Then `c := q + 2e2` is the
  centre of `D_q`'s top arc and the bottom cusp of `D_{q+m}`. `D_q ⊂ {c + ru : r ≥ 1, arg u ∈ [−120°, −60°]}` and `D_{q+m} ⊂ {c + v : arg v ∈ [60°, 120°]}`
  ∪ `{c}`; the angle between `u` and `v` is `≥ 120°`, so `|ru − v|² ≥ r² + r|v| + |v|² ≥ 1`, equality iff `r = 1`, `v = 0` (**cone lemma**): distance
  `≥ 1`, equality only between the arc and the cusp `c`. `|m| ≥ 3`: distance `≥ 3 − 2/√3 > 1`.
- Reuleaux and down colours are disjoint sets of colours. *Exact:* every same-colour pair within centre distance 3.2 of four Reuleaux tiles and three down
  tiles (all colours; by `Λ`-equivariance, which permutes colours, enough): 0 improper, 49 contacts at exactly 1 (`tilings.out`).

**(b) tight** — a corner and the opposite arc of one Reuleaux tile are at distance exactly 1; pairs near them fill `(1 − ε, 1)` in positive measure.

**(c) saturated, reading (L) — TRUE [hand + exact certificates].** Essential boundary points: Reuleaux arcs (density `1/2`: the Reuleaux colour and a down
colour), lattice points (three Reuleaux colours, `1/3` each). The cusps have down-colour density 0 (the horn has area `O(r³)` in `B(x, r)`), so they lie in
no down colour's `A*`: nothing is asked of them for a down colour.
- Reuleaux arc point, its Reuleaux colour: the arc's centre is the tile's own opposite corner, at distance exactly 1.
- Lattice point (a Reuleaux corner), each of its three colours: the opposite arc of that tile, at distance exactly 1.
- Reuleaux arc point = down arc point, the down colour `j` of `D_q`: the arc's centre `c ∈ {q, q+2e1, q+2e2}` is a cusp of a colour-`j` down tile —
  `q` is a cusp of `D_{q−e1−e2}`, `q+2e1` of `D_{q+2e1−e2}`, `q+2e2` of `D_{q−e1+2e2}`, and `−e1−e2, 2e1−e2, −e1+2e2 ∈ M`. So `|x − c| = 1` on the whole arc,
  `c ∈ cl S̃_j`, and `A_η(x)` contains a neighbourhood of `c`, which meets the open horn: `|S̃_j ∩ A_η(x)| > 0` for every `η`. Not free.
- *Exact:* every boundary piece of the seven focus tiles certified (`tilings.out`, lines `cert …`); 150 exact sample points, 0 free (`strong.out`).

**(d) saturated, reading (A) — TRUE [hand; exact grid].** For every `x` and colour `j` with `x ∉ S̃_j`, `S(x, 1)` meets `K_j := cl S̃_j` (the union of the
closed colour-`j` tiles).
- *Reuleaux colour `j`:* the centroids of colour-`j` tiles form a translate of `2Λ`, covering radius `2/√3`; a Reuleaux tile contains the disc of radius
  `1 − 1/√3` about its centroid; so some colour-`j` tile `R` has `dist(x, R) ≤ √3 − 1 < 1`. A set of constant width 1 is `⋂_{t ∈ R} B̄(t, 1)`, so `x ∉ int R`
  gives `dmax(x, R) ≥ 1`; `R` is connected, so it meets `S(x, 1)`.
- *Down colour `j`:* every lattice point `w` is a cusp of exactly one colour-`j` down tile (the three down tiles at `w`, `D_{w−e1}`, `D_{w−e2}`,
  `D_{w−e1−e2}`, have residues `a − b ≡ r(w) − 1, r(w) + 1, r(w)`). Suppose `S(x, 1) ∩ K_j = ∅`; each colour-`j` tile (connected) lies in `B(x, 1)` or
  outside `B̄(x, 1)`. A lattice point `w` with `|x − w| ≤ 1/√3` puts its colour-`j` tile `D` inside `B(x, 1)`, so `x` is within `< 1` of `D`'s three cusps.
  With `x ∉ int D`, `x` lies in `⋃_i B̄(a_i, 1)`, `a_i` the three centres of `D`'s arcs (`U ∖ int D ⊂ ⋃ B̄(a_i, 1)` by definition and the edges; the lens of
  `⋂ B(cusps, 1)` beyond an edge lies in the up triangle `T_i` across it — the arc leaves each end at `30°` to the edge, `T_i`'s angle is `60°` — and
  `T_i ⊂ B̄(a_i, 1)`). If `|x − a_i| = 1`, the lattice point `a_i ∈ K_j` is on `S(x, 1)`. If `< 1`, the colour-`j` tile `D′ ∋ a_i` (not `D`: `a_i` is no vertex
  of `U`) lies in `B(x, 1)` too; but `D′ = D + m`, `|m| ≥ √3`, and `U ∪ (U + m)` has extent `≥ √3 + √3/2 > 2` along `m`. Contradiction. ∎
- *Exact:* 144 grid points of one lattice cell, every colour: 0 points free for a foreign colour (`strong_grid.out`); by `Λ`-equivariance one cell suffices.

**(e) reading (P+) — R7 NOT saturated [hand + exact].** A relative-interior point `x` of a down arc of `D_q` (centre `c`) has, among colour-`j` points, only `c`
at distance 1 in `D_{q′}` (cone lemma: equality only at the cusp), and no other colour-`j` tile meets `S(x, 1)` at the exact points checked. Named free point:
`x = (1, √3 − 1)`, the midpoint of `D_{0,0}`'s top arc; its only colour-`D0` contact is the cusp `(1, √3)` of `D_{−1,2}` (`dmin = 1`, exact), density 0. The
Reuleaux side is (P+)-saturated (partners of density `1/3` and `1/2`). *Why it must be so:* by §1.7, a unit-arc interface of kind both has one partner, the
centre, for both colours; at R7's lattice points three `120°` Reuleaux corners fill every direction, so the down colour's density there is 0. Whether a
(P+)-saturated tight seven-colouring exists is **open here**.

**Verdicts.** M-R7 "a.e.-proper, tight and saturated": **TRUE** [hand + exact, one mind], in readings (L), (B), (A). **W-P1** "no saturated
7-colouring exists": **FALSE** under the claim list's definition (R7), and under (B) and (A); **not settled** under (P+). **C-SAT-T at `k = 7`:** its
existence form ("if a tight a.e.-proper `k`-colouring exists, a saturated one exists") **TRUE at every `k ≥ 7`** (R7, unused colours allowed; the text asks
for `k` colours available, not used); its procedural form ("every tight colouring can be modified by fill moves into a saturated one") a **GAP** at the limit:
a fill with colour `j` takes measure from the other classes, so no monotone potential exists, and a colour-by-colour Zorn scheme (fill `j` only on
`B(x, η/2) ∖ (S₁ ∪ … ∪ S_{j−1})`) ends with interface points `x ∈ ∂_e S_j` that are `j`-free but covered by an earlier, saturated class. At `k ≤ 6` both forms open
(vacuous if `χ_m⁰ ≥ 7`).

### 1.6 Item 3 — FS111-W-DECO-B against M's REG-B: **two different statements, both TRUE; no divergence of truth**

- **REG-B_k** (claim list, verbatim: "if a tight a.e.-proper `k`-colouring exists, then one exists each of whose classes has tight block structure") is an
  *existence* statement; at every `k ≥ 7` it is TRUE, witnessed by HEX7 (classes: hexagons of diameter 1, same-colour gaps `> 1.29`) and by R7 (Reuleaux tiles
  of diameter 1 at distance `≥ 1`; down tiles likewise).
- **W-DECO-B** refutes the *universal* form "every tight a.e.-proper 7-colouring has classes with tight block structure". **VMW-DECO** (my reading of "hex7
  decorated with two squares per hexagon", built blind): in `H_{m,n}` (colour `a`) recolour `E = z + [√3/4 − 9/100, √3/4 − 8/100] × [−1/200, 1/200]` to `a + 1` and
  `W = z + [−√3/4 + 8/100, −√3/4 + 9/100] × [−1/200, 1/200]` to `a − 1`. Exact (`deco.out`): every square against every same-colour tile, 0 improper; tight (hexagon
  diameters); for each colour `j`, `E_{j−1,0}` and `W_{j+1,0}` each have `dmax < 1` to `H_{j,0}` and `dmin(E, W) = √3/2 + 16/100 > 1`. So the block holding
  `H_{j,0}` holds both squares and has diameter `> 1`: **no class has tight block structure**. TRUE [exact + hand, one mind].
- **M-BLOCK-EQ — TRUE** for classes that are unions of open connected components (map-type colourings, tilings) [hand, one mind]: for components `C, C′`, the
  cross-distance set of `C × C′` is an interval (connected), open, and avoids 1 (a.e.-proper on open sets means no pair at all), so all `< 1` (linked) or all
  `> 1` (apart); a component's own distances are `< 1`. A partition into blocks with `dist ≥ 1` must keep linked components together (and components whole), and
  a block of diameter `≤ 1` cannot hold two apart components; so tight block structure ⟺ Cohen–Mani block structure ⟺ "linked" is transitive. For a general
  D-NF class (density-open, components undefined) the equivalence needs a definition of components: a GAP of statement, not of truth. VMW-DECO is its
  instance: `E ~ H ~ W`, `E` apart from `W`.
- **"One statement in two forms?"** No: REG-B_k (existence) and the universal form are different statements; the first is TRUE at `k ≥ 7`, the second FALSE
  at `k = 7`. Whether M's "REG-B TRUE for 7 or more colours" is the existence form is checked at stage 2.

### 1.7 Item 4 — C-HULL-REG: the common form [hand, one mind]

**Setting.** A saturated (L) colouring in D-NF, `x₀` with `P(x₀) = {a, b}`, and a neighbourhood `U` with:
- **(H1)** `S_a ∪ S_b` has full measure in `U`;
- **(H2′) one-sidedness:** for every `x ∈ Γ := ∂_e S_a ∩ U` and each partner `y_c` of `x` for `c ∈ {a, b}` (`y_c ∈ cl S̃_c`, `|x − y_c| = 1`), the part
  `S̃_c ∩ U` lies on one side of `S(y_c, 1)`.

(H2′) holds when (H2) each `S̃_c ∩ U` is connected **and** the partner has positive density (I-D1: `S̃_c` avoids `S(y_c, 1)`); it also holds at a density-0
partner (a cusp) whose horn meets `S(y_c, 1)` transversally (the circles about the horn points sweep a one-sided band). At a cusp partner with a horn tangent
to the circle, (H2) does not give (H2′): this is the one step where a partner of density 0 needs its own argument.

**The case analysis at `x ∈ Γ`** (sides: "in" = `S̃_c ⊂ B(y_c, 1)` near `x`, "out" = outside `B̄(y_c, 1)`; (H1) says the two sides cover a neighbourhood a.e.):
- **(in, in) impossible:** two unit discs with `x` on both boundaries leave a set of positive measure near `x` uncovered (a wedge, a half-disc, or two horns).
- **(in, out), a in:** `B(y_b, 1) ⊂ B(y_a, 1)` near `x` with `x` on both circles forces `y_a = y_b =: y`; then `Γ = S(y, 1)` near `x` — **a unit arc about a
  common partner `y ∈ cl S̃_a ∩ cl S̃_b` ("kind both")**.
- **(out, out):** `B(y_a, 1) ∩ B(y_b, 1)` null near `x` forces `y_b = 2x − y_a` (externally tangent discs); `B(y_a, 1) ⊂ S_b`, `B(y_b, 1) ⊂ S_a` near `x`.

In every case `Γ` has, at every point, unit discs on both sides touching it there (in (in, out) the outer side contains `B(2x − y, 1)`); so **`Γ` is
`C^{1,1}` with `|κ| ≤ 1`**, and the partners lie on its unit-parallels (they are the centres of the touching discs). Bends (corners at two-colour points)
are impossible.

**Against the two forms** (as the brief states them):
- **M-PINCH/M-C11** — TRUE as the common form with (H2) + positive-density or transversal partners [hand, one mind]; if M's (H2) is used at a density-0
  partner without transversality, GAP at that step (stage 2 reads M's proof). "Curvature in `[−1, 1]`", "two-sided tangent unit discs", "unit-parallel
  partners", "(in, in) impossible" all as derived.
- **FS111-W-C11 and NOBEND** — TRUE on maps without cusps: away from vertices a map satisfies (H1) and (H2), and without cusps every closure point of a region
  has positive density, so (H2′) holds [derived, one mind]. **NOREP** ("at a cone vertex no colour occupies two sectors") — **not derived here**: the partner
  of a vertex constrains only the two sectors' sides of one circle, and the tangent discs at nearby interface points are half-planes at the scale of the cone,
  so no contradiction follows from the common form; GAP until W's proof is read (stage 2).
- **Checks.** R7 (saturated): at a Reuleaux arc point (H1), (H2) hold, the Reuleaux partner is the corner (density `1/3`), the down partner the same point as a
  cusp (density 0, horn transverse at `≥ 60°`): case (in, out), a unit arc of kind both — M's form holds. W's forms do not apply (R7 has cusps); their
  conclusions hold anyway (unit arcs; no bends; at lattice points three distinct Reuleaux colours and three distinct cusp colours). SQ9: edge points
  (out, out), partners `(x ± 1, y)` on the unit-parallel lines, `κ = 0`; vertices carry four distinct colours — both forms hold.

### 1.8 Item 2 — FS111-W-SQ9 and W-HEX9: **TRUE** [exact + hand, one mind]

SQ9: same-colour squares at offsets `(3a/2, 3b/2)`; the nearest face each other across a gap of exactly 1. HEX9: centres `(1/2)Λ`, colour `Λ′/3Λ′`; nearest
same-colour hexagons (offset `3/2`) face each other flat-to-flat across exactly 1. Exact (`tilings.out`): proper, tight (`dmin = 1`), every edge certified by
its unit translate lying in the facing same-colour tile — so saturated in (L) and in (P+) (partners are edge points, density `1/2` or `1/4`); `strong.out`: 0
free points at 48 and 72 samples in every reading. Tile diameters `√2/2` and `1/√3` are `< 1`: tightness is between tiles only.

### 1.9 Item 5 — FS111-W-NEG: **TRUE in two clauses, MISSTATED in the third's second half** [derived, one mind]

- "every existence rung of route M (REG-A_k, REG-I_k, REG-J_k, REG-B_k) is TRUE at every `k ≥ 7`": each rung's conclusion is witnessed by HEX7 (a map, S–V
  Conditions 2–4, segments; vertices of degree 3, three `120°` sectors; tight block structure), used as a `k`-colouring. TRUE.
- "a rung failing at `k ≤ 6` means `χ_m⁰ ≤ k`": a failing implication has a true antecedent, a tight `k`-colouring. TRUE.
- "A-ALL failing means `χ_m⁰ ≤ 6`": TRUE with (A)'s `δ` quantified with `R, η, µ` (the only reading under which (A) can hold): failure gives, for every `R` and
  `δ`, a band-proper partial six-colouring with holes `< δ` in `U_R`, which is `χ_m⁰ ≤ 6` by row 131's disc form ("the exact equivalent is the same statement
  'for some radius `R`'", `data/fs106/claims.md` corrections, C-Q-STAB).
- "B-RR failing means `χ_m⁰ ≤ 6`": **MISSTATED.** B-RR is "(B) as posed, for the pair A-ALL supplies", at A-ALL's `R, δ`. Its failure gives colourings with
  holes `< δ` in one fixed `U_R` whose pairs have small scale — not vanishing holes, not every `R`; with `χ_m⁰ ≥ 7` this is consistent (row 131 bounds holes
  only below some `δ₀(R)` at large `R`). Corrected: "(A ∧ B), read `∃ R, η, µ, δ, s₀ ∀` colourings with holes `< δ` in `U_R` `∃` a pair of scale `≥ s₀`,
  failing means `χ_m⁰ ≤ 6`" — TRUE by the same disc form.

### 1.10 Item 6 — M-REDUCE-I: **GAP at one named step; TRUE with it** [derived, one mind]

The chain: `χ_m⁰ ≤ 5` ⟹ a tight a.e.-proper five-colouring (V0-RESCALE) ⟹ a saturated one (honest saturation, the existence form at `k = 5`) ⟹ off `Σ`,
interfaces `C^{1,1}` (§1.7) ⟹ a map-type colouring (S–V Conditions 2–4) ⟹ contradiction with FS106-AE-MAP6 ⟹ `χ_m⁰ ≥ 6`, and given MR `χ(ℝ²) ≥ 6` (row 130).
- **The named step:** "`Σ` locally finite" does not give Condition 3 (local finiteness of boundaries) at a point of `Σ`: infinitely many `C^{1,1}` interface
  curves may end at one point of `Σ` (thin sectors accumulating), with every other point regular. Needed: **finitely many interface arcs at each point of
  `Σ`** (REG-J's "finitely many closed sectors"). With it: vertex-free interface loops are islands, filled as in V0-CLEAN (a.e.-properness kept); degree-2
  points are regular by §1.7 (no bends); so Conditions 2–4 hold and FS106-AE-MAP6 applies.
- Also needed, and definitional: `Σ` must contain every point without (H1) and (H2′) — in particular interface points whose only partners are tangential cusps.
- Grade of the conclusion: over FS106-AE-MAP6 ("modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5" [hand; one mind per link]) and over
  the existence of honest saturation at `k = 5` (open).

### 1.11 Verdict table (blind)

| item | claim | verdict | grade, minds |
|---|---|---|---|
| 1 | M-R7 "a.e.-proper, tight and saturated" | **TRUE** (readings (L), (B), (A)); FALSE only under (P+), free point `(1, √3 − 1)` | [hand + exact], one mind |
| 1 | W-P1 "no saturated 7-colouring exists" | **FALSE** under the claim list's definition; not settled under (P+) | [hand + exact], one mind |
| 1 | C-SAT-T at `k = 7` | existence form TRUE at every `k ≥ 7`; procedural form GAP at the limit of fill moves | [hand], one mind |
| 3 | W-DECO-B | TRUE (VMW-DECO, my reading of the object) | [exact + hand], one mind |
| 3 | REG-B_k at `k ≥ 7` (existence) | TRUE (HEX7, R7) | [hand], one mind |
| 3 | M-BLOCK-EQ | TRUE for classes that are unions of open connected components | [hand], one mind |
| 3 | DECO-B vs REG-B | different statements (universal vs existence); no divergence of truth | [derived], one mind |
| 4 | common form | VMW-HULL | [hand], one mind |
| 4 | M-PINCH/M-C11 | TRUE with positive-density or transversal partners; GAP at tangential cusp partners | [hand], one mind |
| 4 | W-C11, W-NOBEND | TRUE on maps without cusps | [derived], one mind |
| 4 | W-NOREP | not derived: GAP until read | — |
| 2 | W-SQ9, W-HEX9 | TRUE (also with positive-density partners) | [exact + hand], one mind |
| 5 | W-NEG | clauses 1–2 TRUE; A-ALL half TRUE; B-RR half MISSTATED | [derived], one mind |
| 6 | M-REDUCE-I | GAP at "finitely many interface arcs at each point of `Σ`"; TRUE with it, over FS106-AE-MAP6 | [derived], one mind |

## Stage 1 — SAVED

## Stage 2 — SAVED: reconciliation with M (`plans/FS111-M-regularity.md`) and W (`plans/FS111-W-wild.md`), read only after `3ea1d5ab`

### 2.1 The deferred quotations (standing rule 5)

| # | brief | source | result |
|---|---|---|---|
| 1 | M-R7, "the Reuleaux seven-colouring (…) is a.e.-proper, tight and **saturated**" | M, "Theorems this phase proved", M-R7 | verbatim prefix (the source continues "(every essential boundary point is a contact point for each of its colours); every boundary is a unit arc …") |
| 2 | W-P1, "no saturated 7-colouring exists" at 0.65 | W §2.8: "**W-P1:** no saturated a.e.-proper 7-colouring exists (0.65)" | "a.e.-proper" dropped (harmless: saturation is defined for a.e.-proper colourings) |
| 3 | W "calls C-SAT-T a GAP at `k = 7, 8`" | W §2.6: "**TRUE at `k ≥ 9`; GAP at `k = 7, 8`**" | verbatim |
| 4 | FS111-W-SQ9, W-HEX9 | W, theorem lines | consistent paraphrase |
| 5 | W-DECO-B, "hex7 decorated with two squares per hexagon: tight, a.e.-proper, no class with tight block structure" | W, theorem line | verbatim |
| 6 | M's REG-B "TRUE for 7 or more colours (checked exactly)" | M §5.4: "TRUE at `k ≥ 7` (R7, exact), GAP at `k = 5, 6`" | **not in M's record verbatim**; a faithful paraphrase |
| 7 | M-BLOCK-EQ, "block structure holds exactly when 'all cross distances < 1' is transitive among one colour's components" | M: "tight block structure holds iff 'near' is transitive" | faithful paraphrase |
| 8 | M-PINCH/M-C11 | M §3.1–§3.2 | faithful; M's (H2) also requires `x ∈ cl P_a ∩ cl P_b`, and "No thickness of the partner is needed" (the brief omits it — it bears on §2.2 D2) |
| 9 | W-C11 / NOBEND / NOREP, "on every saturated map without cusps …" | W §2.2–§2.3, §2.6 | faithful for maps without cusps; W-C11's general statement carries **H-DEN** (partners of positive density), which the brief's "without cusps" implies |
| 10 | W-NEG, "… A-ALL or B-RR failing means `χ_m⁰ ≤ 6`" | W §1.4 (iv): "If `χ_m⁰(ℝ²) ≥ 7`, A-ALL and B-RR hold (vacuously for large `R` and small `δ`); the negation of A-ALL implies `χ_m⁰(ℝ²) ≤ 6`" | **strengthened**: W states B-RR's side as "seven ⟹ B-RR for large `R`, small `δ`", not "B-RR failing (at A-ALL's `R, δ`) ⟹ six" (§2.2 D5) |
| 11 | M-REDUCE-I, "honest saturation plus a locally finite singular set Σ at five colours …" | M §5.1: "(ii) singular set Σ is locally finite **with finitely many interface arcs at each of its points** (REG-J′_k)" | **a clause dropped** — exactly the clause my blind stage 1 named as the missing step (§2.2 D4) |

### 2.2 Divergences, with addresses

| # | claim | M | W | VMW (blind, stage 1) | kind | settled |
|---|---|---|---|---|---|---|
| D1 | is there a saturated seven-colouring? (C-SAT-T at `k = 7, 8`; W-P1; W-P2) | yes: R7 (§2.4, exact, two engines) | no known; C-SAT-T "GAP at `k = 7, 8`"; W-P1 at 0.65, W-P2 "least `k` is 9" at 0.3 (§2.6, §2.8) | R7 saturated in (L), (B), (A) — hand proofs + exact certificates (§1.5) | **truth** | **M right; W-P1 FALSE; W-P2 FALSE** (the least `k` with a saturated a.e.-proper `k`-colouring is `≤ 7`). One definition, read one way: W's own (§2.0, "in D-NF, no `x ∈ ∂_e S_j` is `j`-free, for every `j`"; §1.3's gloss "every essential boundary point a contact for each colour of its multicolour") is (L), and R7 meets it. R7 even meets every necessary condition W listed for a saturated seven-colouring (`C^{1,1}`, no bend, rainbow vertices, kind-both arcs with the inner sector toward the arc): **the miss is W's generator image** — its searches ranged over recolourings of polygonal tilings (hex7, brick; LADDER, HEXSAT), and R7 has no flat edge. Grade: [hand + exact], three minds on R7's saturation (M exact; VMW blind, hand + exact; W's structure consistent) |
| D2 | the hypotheses of the two-colour regularity lemma | M-PINCH: (H1), (H2) only; Step 1 applies M-HULL1 at density points `q_n → y_a`, so "no thickness of the partner is needed" | W-C11: adds **H-DEN** (partners of positive density), applying C-HULL at `y_a` itself | assumed one-sidedness (H2′) and flagged tangential cusp partners as a GAP for M | statement | **M's form is the common form**: Step 1 checked (M-HULL1 at `q_n ∈ S̃_a ⊆ A*_a`, then the closed-disc limit) — valid with no density at the partner. My stage-1 GAP flag on M-PINCH is **withdrawn**; W's H-DEN is removable. R7 is the instance that needs this: its down side's partners are cusps (H-DEN fails), and the conclusion holds. Case analysis: three minds (M; W with H-DEN; VMW blind with (H2′)) |
| D3 | W-CURV, "curvature is at most 1, equal to 1 exactly on arcs of kind both" | — (M-C11: `\|κ\| ≤ 1`; (split) ⟹ unit arc) | as quoted | — | statement | **the "only if" half is not derived**: C11's case (i) (outer–outer) allows the interface to coincide with one tangent circle — a unit arc about an `a`-contact `z` with `b` inside and `b`'s partners on the radius-2 arc about `z`, `z` not a `b`-contact; locally consistent (the `a`-sector at `z` must point away from the arc). Corrected: "curvature at most 1; arcs of kind both have curvature 1". [hand, one mind; no saturated colouring realising a case-(i) unit arc was built] |
| D4 | M-REDUCE-I | includes "finitely many interface arcs at each point of Σ"; loops excluded by M-EXTREME | — | GAP at exactly that clause (the brief's paraphrase dropped it); loops by V0-CLEAN's island fill | statement (a quotation slip) | **TRUE as M states it** [derived, two minds: M; VMW blind on the step], over honest saturation at `k = 5` (open), REG-J′₅ (open) and FS106-AE-MAP6's grade. M-EXTREME read and checked: a region's extreme points on its minimal enclosing circle (radius `< 1`) cannot carry the unit disc M-PINCH puts on the region's side |
| D5 | W-NEG, B-RR's clause | — | "seven ⟹ A-ALL and B-RR, vacuously for large `R`, small `δ`"; A-ALL's negation ⟹ six by periodising the inscribed square | "B-RR failing ⟹ six" MISSTATED at A-ALL's fixed `R, δ`; TRUE for the joint statement with `R, δ` free | statement | **agree**: W's statement is my corrected form; the brief's "B-RR failing means `χ_m⁰ ≤ 6`" is the misstatement. A-ALL: two minds, two routes (W periodises; VMW cites row 131's disc form) |
| D6 | REG-B | existence form TRUE at `k ≥ 7` (R7, exact); M-BLOCK-EQ | existence TRUE at `k ≥ 7` (hex7); universal form FALSE at `k = 7` (DECO-B, exact) | the same, VMW-DECO built blind; M-BLOCK-EQ re-derived | none of truth | **two statements, both settled**: REG-B_k (existence) TRUE at `k ≥ 7`; the universal form FALSE at `k = 7`. W's own object re-checked with this verifier's engine (`tools/fs111_vmw_decow.py`, `decow.out`): 14 squares, 0 improper, every colour's triple `S1 ~ H ~ S2` with `dmin(S1, S2) = 1` exactly, `dmax > 1`; W's `bigsq` plant fires. DECO-B: two minds, two objects (W's squares `[1/2, 13/25] × [−1/50, 1/50]`, dmin exactly 1; mine at offsets `8/100–9/100`, dmin `√3/2 + 16/100`), three engines agreeing on W's object |
| D7 | are R7's down classes maximal? | open (M-SATC: "not decided here (not needed)") | — | yes: VMW-R7-MAX (reading (A)) | open item closed | **R7 is a maximal admissible cover with disjoint classes** (VMW-R7-COVER): (A) is exactly M-SATC (ii)'s condition `ℝ² = int F_j ∪ (F_j + S¹)` for every `j`. So at `k = 7` the cover form and the honest form coincide on one object |
| D8 | W-NOREP | — (M-HALF, M-POLAR: no reflex sector at a saturated point) | TRUE at cone points of saturated colourings with H-DEN | not derived | proof, read sighted | **TRUE on saturated maps without cusps**; as stated for general saturated colourings, a **GAP**: the proof applies C11 at the partner points `y_a(p)` (§2.3 case (i)), where H2 is not among its hypotheses; on a map, `y_a(p)` is an essential boundary point (it is not in `S̃_a` by I-D1) sweeping a curve that meets finitely many vertices, so H2 holds there for all but finitely many `p`. [one mind (W), checked sighted] |
| D9 | C-HULL-REG as stated | MISSTATED: GAP at (H1), (H2) | TRUE on saturated maps without cusps (C11 + NOBEND + NOREP) | common form under (H1), one-sidedness | scope | **consistent**: W's class (maps, no cusps) is where (H1), (H2) hold at bichromatic points once NOREP removes repeated-colour vertices; M's GAP is for general colourings. M's stub (d) (a saturated colouring with a bichromatic vertex of degree `≥ 4`) is excluded among maps without cusps by W-NOREP, over D8's grade |
| D10 | the hexagonal seven-colouring | M-DEADLOCK: no local modification binds an edge | HEXSAT (2), HEX7-RIGID, FILL-FREE | calibration: every edge midpoint free for its own colour and one neighbour's | none | agree, three minds, three instruments |
| D11 | C-SAT-T's forms | cover form TRUE (Zorn); honest existence form TRUE at `k ≥ 7`, GAP at `k = 5, 6`; process form undecided | "TRUE at `k ≥ 9`, GAP at 7, 8"; FILL-FREE | existence form TRUE at `k ≥ 7`; procedural form GAP (no monotone potential; colour-by-colour Zorn stalls at interfaces) | truth at `k = 7, 8` (D1); otherwise agree | **existence form TRUE at `k ≥ 7`** (R7), GAP at `k = 5, 6`; M's cover form is the right repair of the procedural gap (Zorn works for covers) — two minds on the gap's location (M; VMW blind) |

### 2.3 Corrections to my stage 1 (made here, not in §1)

- **M-PINCH:** my "GAP at tangential cusp partners" is withdrawn (D2): (H2) alone gives one-sidedness, by M's Step 1. The common form is M-PINCH/M-C11.
- **M-REDUCE-I:** my GAP was against the brief's paraphrase; M's statement contains the clause (D4). Verdict: TRUE as M states it.
- **W-NOREP:** "not derived" becomes: TRUE on saturated maps without cusps, GAP for general colourings at H2 at the partners (D8).
- **VMW-R7-P+:** its theorem line claimed "every relative-interior point"; the proof covers the named point exactly and 69 sampled exact points
  (`tools/fs111_vmw_pplus.py`, `pplus.out`; control: 0 of 69 Reuleaux-arc points are (P+)-free). Line corrected.
- **VMW-R7-COVER** added (D7).

### 2.4 Registrations scored

- **W-P1** (0.65), "no saturated a.e.-proper 7-colouring exists": **FALSE** (R7).
- **W-P2** (0.3), "the least `k` with a saturated a.e.-proper `k`-colouring is 9": **FALSE** (it is `≤ 7`; it equals `χ_m⁰(ℝ²)` exactly when C-SAT-T's
  existence form holds at `χ_m⁰(ℝ²)`, and is 7 if `χ_m⁰(ℝ²) = 7`).
- W's proposed stub "the saturated chromatic number (between 7 and 9)" collapses: that number lies in `[χ_m⁰(ℝ²), 7]`, and deciding it below 7 is
  C-SAT-T at `k = 5, 6` — M's stub (a), honest saturation.

### 2.5 Proposed for the close (I edit none of these files)

- **`data/fs111/claims.md`, C-SAT-T:** "existence form TRUE at every `k ≥ 7` (R7: M exact, VMW blind hand + exact); GAP at `k = 5, 6`; cover form TRUE
  (M-SATC); W's 'GAP at `k = 7, 8`' corrected". The brief-level wording "saturated if … no `x ∈ ∂_e S_j` is `j`-free, for every `j`" should always carry
  its second half "for every `j ∈ P(x)`".
- **`LEDGER.md` (FS-111's row):** R7 saturated in the strongest sense (VMW-R7-MAX) and a maximal cover (VMW-R7-COVER) [hand, one mind; exact checks];
  VMW-DECO (a second DECO-B object); VMW-BLOCK-EQ as a second mind on M-BLOCK-EQ.
- **M's draft G84** ("saturation pins interfaces between unit circles"): support, with two additions — "no thickness of the partner is needed" (the
  step that makes it hold at cusp partners, R7's down sides), and R7 as the inhabitant in which every interface is of the (split) type.
- **`plans/GROKKING-INSTANCES.md` §G21 (generator image):** W-P1 registered at 0.65 from recolourings of polygonal tilings, while W's own necessary
  conditions admitted an all-arc tiling (R7) that the generator could not produce.
- **W-CURV:** drop "exactly" (D3). **W-NOREP:** scope "on saturated maps" (D8).
- **Open, minor, not proposed as a stub:** a saturated tight seven-colouring whose contact partners all have positive density ((P+); R7 fails it at its
  down arcs). Since M-PINCH needs no partner density, (P+) bears on nothing downstream that I can find.
- **`BIBLIOGRAPHY.md`:** with M's proposal, `[Polymath16threads]` thread 4, ag24ag24 (de Grey), 5 May 2018, 4:37 pm — the 4 + 3 Reuleaux colouring,
  verified here in the held text (line 16; `ag24ag24` = de Grey by line 55); the classical two-sided rolling-ball theorem remains a debt (M, W and here).

## Stage 2 — SAVED
