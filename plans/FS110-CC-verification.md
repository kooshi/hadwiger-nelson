# FS110-CC — a second mind on FS110-CB's route at cubic vertices with a cusp sector

*Coxeter (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/CC110-cusp-scope.md`, with `data/fs110/briefs/STANDING-RULES.md`. Fences kept:
the competition advisors' records (`plans/POROS-2026-09-27-fs110-competition.md`, `data/fs110/fs110-a*/` except the one tool the brief opens,
`a6_c2_single_horn.py`, which I ran myself and did not read the `.out` beside it), FS110-CD's record, FS110-NB4's and FS110-YB4's records,
the session transcripts, `chats-bak/`, and scratchpad files I did not create. Sources read: `plans/FS110-CB-verification.md` in full;
`[SokolovVoronov2025]` §6 Props. 9–11, Cor. 2–3 and Prop. 17 (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, text layer);
`data/fs110/briefs/CB110-cor1-blind.md` (CB's setting); `tools/fs110_y_cone.py`'s docstring (the fragments the a6 tool builds on).
`CLAUDE.md` § The aim and § Counter-priors were read first (rule 0).*

## Theorems this phase proved

(filled at stage 3)

## Stage 1 — SAVED

### 1.1 The quotation and address check (standing rule 5)

| brief says | source | verdict |
|---|---|---|
| "a curve beside the arc" (item (b)) | CB l. 106: "a curve in the i-tile beside the arc from u to `x_ij` meets `ω(z)` when `\|z−u\| < 1 < \|z−x_ij\|`" | **matches** |
| "`\|u + e − x_ij(δ)\| − 1`" (item (a)) | CB l. 107: "the three numbers `\|u + e − x_ij(δ)\| − 1` are nonzero unless `ω(u+e)` passes through some `x_ij(δ)`" | **matches** |
| "Any two arcs still border all of `{4, 5, 6}`" (item (c)) | not in CB's text; it is the unstated step behind CB l. 108–110, "a side σ_e (the side named by the majority sign) such that every tile point of `N_e` strictly on side σ_e of Ω has colour in {1,2,3}" (a majority is two arcs, and the conclusion needs their colours to cover `{4,5,6}`) | **the brief's reconstruction of an implicit step; correct as a reconstruction** |
| "The main step is CB's D2 strip, lines 104–112" | D2 heading l. 103; the strip claim l. 105–112 | **matches** |
| "the pigeonhole endpoints handed to Lemma 3 (D4, lines 135–158)" | D4 l. 135–157 | **matches** |
| "those handed to Cor. 3 (lines 111–112)" | l. 110–112 build γ(u); **Cor. 3 AE itself is l. 113–114** | **off by two lines; harmless** |
| "D5 item 5 (lines 180–185)" | item 5 is l. 178–185; its Prop. 17 part l. 179–185 | **matches** |
| "D1's (P′) (lines 94–97)" | l. 94–98 | **matches** |
| the cusp vertex "exists locally; it has been checked exactly (`a6_c2_single_horn.py`)" | reran it: "ALL AS PREDICTED", exit 0, 14.1 s user (`data/fs110/fs110-cc/a6_c2_single_horn.rerun.out`). Its vertex v (from `tools/fs110_y_cone.py`'s docstring, fragment WC1/WC1H): "the single horn … the 2\|3 boundary along −a (a trichromatic vertex of degree 3)"; horn of colour 1 along `+a` with "upper boundary on the circle of radius 2 centred (0,2), curvature +1/2; lower on the circle of radius 2 centred (0,−2), curvature −1/2"; A6-C2's docstring: "At v every colour has ONE sector (horn 1, flanks 2, 3)" | **matches** |

CB's setting (from its brief, `CB110-cor1-blind.md` statement 1): "A locally finite map of the plane whose tiles are bounded by finitely many circular
arcs and segments, none an arc of radius 1, with exactly three tiles at every vertex". So every boundary arc at a cusp is a circle arc of signed
curvature κ with `|κ| ≠ 1`, or a segment (κ = 0); two arcs bounding one cusp have one tangent and **different** curvatures (equal curvature and
tangent would make them one circle and the horn empty). §2 also notes what survives for general arcs under Condition 5 alone.

### 1.2 The configuration, as I use it

A **cusp vertex** u: a trichromatic cubic vertex, `c(u) = {4,5,6}` (in D2's frame), whose arcs leave with tangents `τ45 = τ46 = τ` (the colour-4
sector is a **horn** between arcs 45 and 46, of curvatures `κ45 ≠ κ46` measured toward the normal n ⊥ τ) and `τ56` arbitrary. A **double cusp**
(all three tangents equal: two horns, the third sector of angle 360°) is also allowed by the setting and is carried along. Frame: `u = 0`,
`τ = (1,0)`, `n = (0,1)`.

### 1.3 Registered expectation (formed after one pass through CB's D1–D5 in my head, before any written derivation or check)

| item | expectation | what would move me |
|---|---|---|
| D2 (a) | TRUE: for each e the arcs meet `ω(u+e)` finitely (Cond. 5) and u is one of the meeting points, so all small δ work; along ±n the sign is `sign(1 ∓ κ)` exactly, 0.85 | an exact sign formula along n that vanishes for some `κ ≠ ±1` |
| D2 (b) | TRUE, but the far end of the horn curve must sit within an `O(δ²)` margin of `x_ij`, not down the horn's middle, 0.8 | a margin smaller than any horn point near `x_ij` can meet |
| D2 (c) | TRUE (combinatorics of three arcs), 0.95 | none |
| D5 item 5 | TRUE at a cusp u (a horn is a sector of angle 0 and sits in a 0° cone); no hexagon vertex `x_i` can be a cusp, 0.7 | a hexagon vertex with a cusp sector satisfying the four branch constraints; or a horn direction with `⟨τ,e_i⟩ > 0` whose `ω(z)` misses the horn |
| D1 (P′) | TRUE (the proof never uses tangents), 0.95 | none |

### Would have searched here (standing rule 3)

- (none yet)
