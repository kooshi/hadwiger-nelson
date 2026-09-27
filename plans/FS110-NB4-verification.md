# FS110-NB4 — blind verification of FS110-N4 (round 4, the proof side: G-CONE)

*Job FS110-NB4, Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/NB110-verify-proof.md` with the instance block
`data/fs110/briefs/NB4-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Blind: FS110-N4's record, tools and directory, the
construction side's record, every other verifier's record, the plan, the advisors' records, the close inventory, the reports and the other
briefs stay unopened until Stage 3 is committed. Work files: `data/fs110/fs110-nb4/`; tools `tools/fs110_nb4_*.py`.*

## Theorems this phase proved

*(filled at Stage 2; one line each, grade and address)*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| `[SokolovVoronov2025]` Question 2, Condition 5, Condition 6 (claims §1) | held PDF `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, pdftotext l. 148–153, 1016–1018 | verbatim ✓ |
| Kooshi's counter-priors sentence (standing rule 0) | `CLAUDE.md` § Counter-priors, on disk | verbatim ✓ |
| The theorem table of FS110-N4 (instance block) | `plans/FS110-N-proof.md` § Continuation — FS110-N4 | **fenced until Stage 3**; checked at Stage 4 |
| N3-DEG, N3-RED (claims §8) | `plans/FS110-N-proof.md` § Continuation — FS110-N3 | **fenced until Stage 3**; checked at Stage 4 |
| FS110-Y4 §11.3–§11.4 fragments (instance block) | `plans/FS110-Y-construction.md` | **fenced (the other side)**; not opened by this job; used as given |
| CB's three theorem lines (claims §8, first update) | `plans/FS110-CB-verification.md` | fenced (a verifier's record); used as quoted |

### 1.2 The statements against the claim list's definitions

- **Types.** Every type in the N4 table is a closure type (`P_cl`): N4-STUCK writes `P_cl(N)`, `P_cl(S′)`; N4-HEX's "type `{α, β, i}`" and
  N4-PROP's "type `{a_{k−1}, a_k, a_{k+1}}`" are closure types by context (a cone colour is a cusp colour, so it is in `P_cl` and not in `P_ess`).
  Consistent with claims §0 (`P_ess ⊆ P_cl`, equal off cusps).
- **Covering pairs** do not occur in N4: its route is a modification to a cubic map plus the base, not C-T-TAN. C-SEAMLIST is not used.
- **`𝓜_K`** (claims §0) is used by N4-RED; the modified map must stay in `𝓜_{K′}` with `K′ = O(K)` (checked at N4-TERM, Stage 2).
- **Terms the claim list does not define, and the definitions this job uses** (to be compared with N4's at Stage 4):
  - *valid*: a full map (open tiles, null boundaries) coloured with six colours such that no two interior points of one colour are at
    distance exactly 1 (A-EXACT's hypothesis). By K-TIGHT every valid six-map is tight, so NB-4 applies to every valid six-map in `𝓜_{K′}`
    under Condition 5.
  - *sector* of colour `c` at `v`: a germ at `v` of a `c`-tile, of positive angle or a cusp horn (angle 0, two boundary arcs tangent at `v`).
  - *shadow* of a tile `A` near `v`: `{p ∈ B(v, t) : ω(p) ∩ A ≠ ∅}` (open). A point in the shadow of a `j`-tile cannot take colour `j`.
  - *`D_c(v)`* (N3's own definition is fenced): the set of directions at `v` along which `c` can lie without meeting the shadow of any
    `c`-tile touching `ω(v)`. It is `S¹` minus one open half-circle per contact (out-type at `v + e`: the half-circle about `e`; in-type:
    about `−e`).
  - *`Φ(v)`*: `Σ_c (#c-sectors at v − 1)⁺`. *Cubic*: `Φ ≡ 0`; with NB-4 every vertex then has degree `|P_cl| ≤ 3`.
  - *MERGE*: recolour, inside `B(v, t₀)`, the sectors lying between two `c`-sectors on the side inside `D_c(v)`, to `c`. *MERGE-RAY*: the
    same for two `c`-horns on one ray. *SHAVE*: recolour the tip `h⁺ ∩ B(v, t₀)` of a `c`-horn by its flanks, split along one curve.
    *Stuck*: no MERGE, MERGE-RAY or SHAVE applies at `v`. *Terminal*: no move applies at any vertex.

### 1.3 Restatements, in my words

- **SHADOW.** A tile touching `ω(v)` from outside at `N = v + n`, whose boundary there is an arc tangent to `a` with centre `C` on the line
  `vN`, casts near `v` exactly the side of the circle through `v` centred at `C` that contains `N`; with signed curvature `λ` of the arc (away
  from `v` positive), that circle has curvature `f(λ) = λ/(1+λ)` at `v`; from `S′ = v − n` the analogue is `f̃(υ) = υ/(1−υ)`.
- **FLANK.** Near the tip of a `c`-horn along `+a` at `v`, with `g` the sector above and `h` below, a `g`-tile can shadow tip points only if it
  touches `ω(v)` at `S′` from outside with its boundary tangent to `a` (shadow below a curve `σ_g`), and an `h`-tile only at `N` likewise
  (shadow above `σ_h`).
- **SHAVE.** The tip can be recoloured, `g` above a dividing curve and `h` below, validly, keeping Condition 5 and lowering `Φ(v)` by one,
  unless `σ_h` lies strictly below `σ_g` inside the horn; if `g = h` it is never blocked.
- **RAY.** Two `c`-horns on the same ray at `v` can be merged: everything between them near `v` is out of every `c`-shadow.
- **STUCK.** At a vertex where no move applies and `c` has two sectors: `c` has exactly one horn on `+a` and one on `−a`; `v` has degree 4,
  `g` filling the upper half and `h` the lower; `N` has closure type `{c, h, r}` and `S′` has `{c, g, r′}`; `h` has two sectors at `N` and
  `g` two at `S′`.
- **PROP.** In a terminal map a stuck vertex starts a chain of stuck vertices `P_k = P_0 + kn`, `k ∈ ℤ`, with cone colours `a_k` and closure
  types `{a_{k−1}, a_k, a_{k+1}}`.
- **FIN.** There is no bi-infinite sequence of pairs `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`.
- **TERM.** Every valid map can be modified by moves into a valid map where no move applies anywhere, each point recoloured finitely often.
- **CONE.** In a terminal valid map no colour has two sectors at a vertex; every vertex is cubic, possibly with cusp horns.
- **RED.** Every tight six-map in `𝓜_K` under Condition 5 has a valid cubic modification; the base (S–V Cor. 1 a.e.) must then hold for
  cubic maps with cusp horns.
- **HEX.** A partial result on S–V's `d = 2` configuration; moot for W-4 now that G-d2 does not arise (claims §8, second update).

### 1.4 Registered expectations (before any derivation is written; both outcomes named reachable)

| claim | expected | P | what the other outcome would look like (reachable) |
|---|---|---|---|
| SHADOW | TRUE | 0.95 | FALSE: a contact tile whose shadow boundary at `v` is not the concentric circle (e.g. a centre off the normal line) |
| FLANK | TRUE, possibly MISSTATED for omitting "flanks of positive angle" | 0.55 TRUE as stated | FALSE: a flank shadowed through a contact not at `S′`/`N`, e.g. an in-type contact, or a flank that is itself a horn |
| SHAVE | TRUE | 0.85 | GAP: a tip that is not doubly shadowed yet cannot be split validly |
| RAY | TRUE | 0.8 | FALSE: a `c`-shadow entering between two valid `c`-horns on one ray |
| STUCK | TRUE over NB-4, W-MERGE, N3-DEG | 0.75 | GAP at "degree 4" or at "`h` has two sectors at `N`" |
| PROP | TRUE given STUCK | 0.85 | GAP: `N` stuck but with its horns off `±a`, or its cone colour not `h` |
| FIN | TRUE | 0.95 | FALSE: a bi-infinite solution (one exists if `λ_k = υ_k` were allowed: the constant 0) |
| TERM | TRUE | 0.7 | GAP: a move raising `Φ` elsewhere, or a limit that is not terminal |
| CONE | TRUE over its inputs | 0.7 | GAP inherited from the above |
| RED ⟹ W-4 NO | the modification TRUE; **W-4 NO a GAP at the base's scope (cusp horns)** unless the base covers them | 0.6 | TRUE outright if the base's proof is blind to cusps |
| WCH (control) | `v` stuck (SHAVE blocked, doubly shadowed); `N` not stuck | 0.8 | SHAVE applies at `v` (then the tip-hard claim measures single-colour moves only) |
| WC1H (control) | `v` is already cubic with a cusp sector, not a two-sector cone; SHAVE applies | 0.7 | SHAVE blocked (`σ_h < σ_g`) |

### 1.5 "Would have searched here" log

- none yet.
