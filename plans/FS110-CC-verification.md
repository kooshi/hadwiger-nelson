# FS110-CC — a second mind on FS110-CB's route at cubic vertices with a cusp sector

*Coxeter (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/CC110-cusp-scope.md`, with `data/fs110/briefs/STANDING-RULES.md`. Fences kept:
the competition advisors' records (`plans/POROS-2026-09-27-fs110-competition.md`, `data/fs110/fs110-a*/` except the one tool the brief opens,
`a6_c2_single_horn.py`, which I ran myself and did not read the `.out` beside it), FS110-CD's record, FS110-NB4's and FS110-YB4's records,
the session transcripts, `chats-bak/`, and scratchpad files I did not create. Sources read: `plans/FS110-CB-verification.md` in full;
`[SokolovVoronov2025]` §6 Props. 9–11, Cor. 2–3 and Prop. 17 (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, text layer);
`data/fs110/briefs/CB110-cor1-blind.md` (CB's setting); `tools/fs110_y_cone.py`'s docstring (the fragments the a6 tool builds on).
`CLAUDE.md` § The aim and § Counter-priors were read first (rule 0).*

## Theorems this phase proved

- **C1** S–V Prop. 2 AE holds with a horn tile beside the arc; at the far end the path must hug the arc within an `O(δ²)` margin — [hand], one mind — §C1.
- **C2** along a cusp's normal `±n`, `|u ± n − x(m)|² − 1 = 4R(R ∓ 1)m²/(1+m²)` on every boundary circle of signed radius R tangent at u: sign `1 ∓ κ`
  at every δ, never 0 under Condition 5; in every other direction all small δ work (Condition 5 alone) — [hand + tools] — §C2, `tools/fs110_cc_cusp.py`.
- **C3** any two of u's three arcs border all three colours of `c(u)`, at a cusp and a double cusp — [hand] — §C3.
- **Cusp corollary** CB's D2 strip, its γ-curves, Cor. 3 AE and the pseudo-colouring's properties hold at cusp and double-cusp centres — [hand],
  one mind on the cusp case (CB's uniform derivation is the other, not aimed at cusps) — §C1–C3.
- **C4** a horn at the centre u obeys CB's D5 item 5 cone condition (`⟨τ, e_i⟩ ≤ 0`); along the normal the exact condition is second order (met iff
  the larger curvature exceeds 1) — [hand + tools] — §C4.
- **C5** no hexagon vertex `x_i` of D5 item 5 can be a cusp or a double cusp, and the inner-q case CB leaves unwritten is impossible — [hand + tools
  (exhaustion of the twelve-position image)] — §C5.
- **C6** D1's (P′) holds at cusp vertices — [hand] — §C6.

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

## Stage 2 — SAVED (the derivations, and their exact checks)

Frame of §1.2: cusp vertex u = 0, `c(u) = {4,5,6}`, horn of colour 4 along `τ = (1,0)` between arcs 45 and 46 (signed curvatures `κ45 ≠ κ46`
toward `n = (0,1)`, each `≠ ±1`), arc 56 with tangent `τ56`. `x_ij(δ)`: the point of arc ij at distance δ from u, unique for `δ < δ0`, where
`δ0` is so small that `B(u, δ0)` meets no boundary but the three arcs and each arc meets every circle `∂B(u, r)`, `r ≤ δ0`, once (local
finiteness; circle arcs through u are radially monotone near u). Then `B(u, δ0)` minus the arcs has exactly three components, one per sector,
the horn component being `{points between arcs 45 and 46}`, of angular width `w(r) = |arcsin(κ45 r/2) − arcsin(κ46 r/2)| > 0` at radius r.

### C1 — S–V Prop. 2, AE, with a horn tile (item (b))

**Claim.** If `sign(|z − u| − 1) = −sign(|z − x_ij(δ)| − 1) ≠ 0` for some `δ < δ0`, then `i, j ∉ c(z)`.
*Proof.* For each tile T ∈ {the i-tile, the j-tile} along arc ij near u there is a path P ⊂ T from a point p with `|p − u| < ||z−u| − 1|` to
a point p′ with `|p′ − x_ij(δ)| < ||z − x_ij(δ)| − 1|`: T's component of `B(u, δ0)` minus the arcs has the whole arc ij in its closure, so
take P = the arc pushed into T by an angular offset `ε(r) < w(r)` (horn) or `< ` the sector's width (flank), for r from `|p|` to δ, ending
within the required distance of `x_ij(δ)`. Then p and p′ lie on opposite sides of `ω(z)`, P crosses `ω(z)` at an interior point of T, and
(P) sweep (CB D1) gives `colour(T) ∉ c(z)`. ∎
**The one care a horn needs.** Along the normal the margin at the far end is second order: by C2, `||u + n − x_ij(δ)| − 1| ≈ |1 − κ_ij| δ²/2`,
the same order as the horn's width there, `≈ |κ45 − κ46| δ²/2`. So the path cannot run down the horn's middle to its end; it must hug the arc
within that margin at the far end. It can, because `x_ij(δ)` is a boundary point of the horn, so horn points lie within any distance of it.
**(b) is TRUE.**

### C2 — the sign along a cusp's normal, exactly (item (a))

A circle arc of signed radius R (curvature `κ = 1/R` toward n) tangent to τ at u, `x(m) = (2Rm/(1+m²), 2Rm²/(1+m²))`, satisfies
**`|u + n − x(m)|² − 1 = 4R(R−1)m²/(1+m²)`** and **`|u − n − x(m)|² − 1 = 4R(R+1)m²/(1+m²)`**; a segment along τ gives `s²`. So along `±n` every
number has the sign of `1 ∓ κ` **at every point of the arc, for every δ**, and is never 0, since `|κ| ≠ 1` (Condition 5). For every other
direction e, and for any arcs at all (curved Jordan arcs included): each arc from u meets `ω(u+e)` in finitely many points (Condition 5), u
among them, so there is `δ_e > 0` with `x_ij(δ) ∉ ω(u+e)` for every `δ ∈ (0, δ_e)` and all three arcs; `N_e` then comes from continuity.
**(a) is TRUE, in a stronger form than CB states:** not "a suitable δ" but every small δ, and exactly along the normal. What the cusp changes is
only the sign pattern there: the two horn arcs may disagree along `+n` (one curvature above 1, one below; checked instance `κ = 3, 1/2`: signs
`(−, +)`), and then the third arc fixes the majority and hence the strip's side; at a double cusp all three signs are curvature-set.
Checked: `tools/fs110_cc_cusp.py` C2 (sympy identities; the a6 horn `κ = ±1/2` with the segment, all `+` along `±n`; the straddling horn).

### C3 — any two arcs border all of {4,5,6} (item (c))

The three arcs carry the labels 45, 46, 56 at a cusp exactly as at an ordinary vertex (the horn 4 lies between 45 and 46, flank 5 between 45
and 56, flank 6 between 46 and 56; at a double cusp the same labels, two horns and one 360° sector), and any two of `{45, 46, 56}` have label
union `{4,5,6}`. **(c) is TRUE.** With C1–C3, CB's strip goes through word for word: on side `σ_e`, at least two arcs have
`sign(|z − x_ij| − 1) = −sign(|z−u| − 1)`, C1 removes their four labels, C3 says those are all of `{4,5,6}`.

**Instance, read off the a6 fragment** (its frame has `c(v) = {1,2,3}`, horn 1 along `+a`, `κ = ±1/2`, the 2|3 segment along `−a`): along
`+n` all three signs are `+`, so the strip lies **inside** `ω(v)` at `N = v + n`. The fragment puts its colour-1 out-tile and its colour-3
sector **outside** `ω(v)` at N and the ring colour 4 inside: exactly the side C2 predicts, and `c(N) = {1,3,4}` with pseudo-colour `{4}`.

### C4 — D5 item 5 with a horn at the centre u

CB's step "by (P) at u (z = x_i + t e_i reaches u's q_i-sector at radius ≈ t/⟨d, e_i⟩) u's q_i-sector lies in `{⟨d, e_i⟩ ≤ 0}`" needs, for
a horn of colour `q = q_i` along τ: **if `⟨τ, e_i⟩ > 0`, then `ω(u + (1+t)e_i)` meets the horn's interior for all small t > 0.** *Proof:*
`|u − z| = 1 + t > 1` while `|x_45(δ0) − z|² = 1 + 2t − 2δ0⟨e_i, τ⟩ + O(δ0², tδ0) < 1` once `t ≪ δ0⟨e_i, τ⟩`; so arc 45 crosses `ω(z)`, at
radius `≈ t/⟨τ, e_i⟩`, transversally (its tangent ≈ τ is not ⊥ `e_i`), and on one side of arc 45 there lies the horn. ∎ So the horn's one
direction τ obeys CB's cone condition, and the count closes as CB wrote it: sector angles still sum to 360° (0 for the horn), each colour class of
the q's has exactly two members with a cone of 60° or 0° (a 0° cone is the line `⟨d, e_i⟩ = 0`, which holds a horn and no sector of positive
angle), a class of three leaves the cone `{0}`, which holds no horn either; the other two sectors need 360° from cones totalling ≤ 120°. A double
cusp (one sector of 360°) fails the same count. Along the normal (`⟨τ, e_i⟩ = 0`) the first-order condition is void and the exact truth is second
order: `ω((0, 1+t))` meets a boundary circle of curvature κ tangent to τ at u, near u, **iff κ > 1** (intersection `y = t(2+t)κ/(2(κ(1+t)−1))`,
`x² = y(2/κ − y)`), so there the horn is met iff its larger curvature exceeds 1 — an extra constraint CB does not need.
Checked: C4 (an exact certificate on the a6 horn with `e = (3/5, 4/5)`: a vertical segment strictly inside the horn on which `|p − z|² − 1` changes
sign) and C4′ (κ ∈ {3, 2, 3/2, 11/10, 9/10, 1/2, −1/2, −3}, t ∈ {1/100, 1/10⁴}).

### C5 — D5 item 5: no hexagon vertex is a cusp; and the case CB's "interval structure" leaves unwritten

At a hexagon vertex `x_i` (outward normal 0°; Ω's tangent ±90°), with `c(x_i) = {c_{i−1}, c_i, q_i}`, `q_i ∈ {4,5,6}`, six branch constraints hold:
(Ω+) Ω's branch at 90° lies in the `c_i`-tile and (Ω−) its branch at 270° in the `c_{i−1}`-tile (pseudo-colours; (P) from u keeps the q-tile off
Ω); (B1) `ω(x_{i+1})`'s branches at 30°, 210° lie in `c_{i−1}`- or q-tiles; (B2) `ω(x_{i−1})`'s at 150°, 330° in `c_i`- or q-tiles ((P) from
`x_{i±1}`). A branch lies in the tile whose sector holds its tangent; at a boundary tangent (a horn's included) in some tile adjacent there,
decided by curvature (never along the boundary: Condition 5).
**Claim.** Every placement of the three sectors satisfying the six constraints has no sector of zero width (**no cusp, no double cusp at `x_i`**),
has 0° strictly inside the q-sector, and sends both ±30° branches into the q-tile.
*Proof, by hand.* **(q a horn.)** A horn holds at most one of the four branch tangents and neither Ω branch; if the 30° branch is not in it, it
is in `c_{i−1}`, so `c_i` — an arc of directions ending at τ and at the third tangent b, holding 90° and neither 30° nor 270° — lies in
[30°, 270°]; then 330° must be the horn's τ, an endpoint of `c_i` outside [30°, 270°]; contradiction; symmetric if the 330° branch is not in it.
**(`c_{i−1}` a horn.)** It must hold the 270° Ω branch, so τ = 270°; then 30° and 210° lie in q, a flank whose endpoints are 270° and b; an arc
of directions holding 30° and 210° holds 90° or 270° inside it, and neither is possible. **(`c_i` a horn):** mirror. **(No horn, q inner,
i.e. q ⊂ [90°, 270°]):** then 30° ∈ `c_{i−1}` and 330° ∈ `c_i`, so the outer boundary b0 between `c_i` (counter-clockwise of it, holding 90°)
and `c_{i−1}` must satisfy b0 < −30° and b0 > 30°. **(No horn, q outer):** 150° ∈ `c_i`, 210° ∈ `c_{i−1}`, and 30°, 330° ∈ q as CB says. ∎
The fourth case is not in CB's text ("the interval structure of the three sectors forces the q_i-sector to contain [−30°, 30°]"): **CB's claim is
true, and the inner-q case closes by the same four branch constraints**; that is a completion, not a gap.
Checked: C5, an exhaustion of all placements of three tangents on the twelve positions {0°, 30°, …, 330°} (odd = exactly a branch tangent,
where the branch may enter any sector adjacent there; even = an open cell, which holds no branch, so the image is every real placement), all six
colour orders: 27 admissible, 0 violations.

### C6 — D1's (P′) at a cusp vertex

(P′)'s proof uses only that the boundary arcs through x meet `ω(y)` finitely, so that the two punctured branches of `ω(y)` near x each lie in one
tile. At a cusp x a branch tangent to τ lies in the horn or a flank (its curvature 1 differs from both horn curvatures), still one tile; at a
double cusp likewise. **TRUE; nothing in it depends on tangents.** Instance: in the a6 fragment `|v − N| = 1`, `c(N) = {1,3,4} ⊄ c(v) = {1,2,3}`
and `c(v) ⊄ c(N)`.

### Plants (standing rule 7), each fired for its named reason

- `--plant kappa1` (C2 at κ = 1): the normal's number is **0** on the whole arc (`[0, 1, 1]`): the arc lies on `ω(u + n)`, which Condition 5 forbids.
  `data/fs110/fs110-cc/cusp-check-plant-kappa1.out`.
- `--plant noOmega` (C5 without (Ω±)): 500 admissible placements, 374 violations, the first a **double cusp at 0° with q the 360° sector** — a
  q-tile meeting Ω, exactly what the dropped constraint forbids. `data/fs110/fs110-cc/cusp-check-plant-noOmega.out`.
- Unplanted: `data/fs110/fs110-cc/cusp-check.out`, "ALL AS PREDICTED", exit 0.

### Would have searched here

- C5: I would have swept random tangent triples and curvatures numerically for a cusp hexagon vertex; instead derived the four-case exclusion and
  checked it by exhausting the twelve-position image (a finite check of a derived claim, not a witness search).
- C4: I would have sampled circles `ω(z)` numerically near the horn; instead wrote an exact rational sign-change certificate on a segment inside it.

## Stage 3 — SAVED (verdicts)

| # | step at a cusp vertex | verdict | grade, minds |
|---|---|---|---|
| D2 (a) | the three numbers `\|u + e − x_ij(δ)\| − 1` nonzero for a suitable δ, including along the cusp's normal | **TRUE, stronger**: for each e every δ below some `δ_e` works (Condition 5: the arc meets the fixed circle `ω(u+e)` finitely, u among the points); along `±n` the sign is exactly `sign(1 ∓ κ)` for every δ. The cusp changes only the sign pattern: the two horn arcs may disagree along `+n`, and then the third arc sets the side | [hand + tools], one mind on cusps |
| D2 (b) | a horn tile holds "a curve beside the arc" | **TRUE**, with one care: along the normal the margin at the path's far end is `≈ \|1−κ\|δ²/2`, the order of the horn's width, so the path hugs the arc at its end rather than running down the horn's middle | [hand], one mind |
| D2 (c) | any two arcs border all of `{4,5,6}` | **TRUE** (labels unchanged at a cusp and a double cusp); the step is implicit in CB l. 108–110 | [hand], one mind |
| D2 at every centre it serves | u; the Lemma 3 endpoints (D4); the Cor. 3 pair | **TRUE**: none of these uses u's sector angles, only (a)–(c); the cusp enters nowhere else in D2 | [hand], one mind on cusps |
| D5 item 5 | Prop. 17 AE with a cusp | **TRUE.** A horn at the centre u obeys the cone condition (C4) and the count closes (a horn fits a 0° or 60° cone; the other two sectors still need 360°; a double cusp fails the same count). No hexagon vertex can be a cusp (C5). **Completion owed to CB's text:** "the interval structure … forces the q_i-sector to contain [−30°, 30°]" leaves the inner-q case unwritten; it is impossible by the same four branch constraints (C5) — a completion, not a gap | [hand + tools], one mind |
| D1 (P′) | unit pairs never nest, at a cusp | **TRUE**; the proof never uses tangents (C6) | [hand], one mind |

**No step fails at cusps, so no local repair is needed.** Nothing I found makes CB's D2 or D5 item 5 depend on distinct tangents: CB's route covers
cusp vertices, and double cusps, as written, with the two additions above ((b)'s margin; D5 item 5's inner-q case, which is not about cusps).

**Registered expectation, scored** (formed after one pass in my head, so a weak test): (a) TRUE 0.85 — met, with the exact normal formula; (b) TRUE
with an `O(δ²)` margin 0.8 — met; (c) 0.95 — met; D5 item 5 TRUE, no cusp at `x_i` 0.7 — met, plus the unwritten inner-q case; (P′) 0.95 — met.

**Selection audit (G21).** The flattering outcome is "CB's route covers cusps". Tried against it: a horn straddling curvature 1 (the horn arcs'
signs disagree along the normal: the majority still exists, C2's instance); a double cusp (all three signs curvature-set; D5's count still fails);
a cusp at a hexagon vertex (excluded in all 27 admissible placements, and the exclusion is lost exactly when the Ω constraint is dropped, plant
noOmega); a horn tangent to a branch direction (the odd positions of C5's image); the far-end margin of the horn path (C1). **Not checked, not asked:**
D4's bicycle and D5 items 1–4, 6 at cusps. On one reading each uses no sector angle at a centre beyond D2 (item 6's a-side curve at a horn endpoint
runs inside the horn, as in C1), but I did not derive them.

**Aside, outside the brief, not checked:** S–V's printed Prop. 17 (the proof FS110-CD takes from print) argues by the three sector angles; at a horn
the smallest angle tends to 0, so it runs in its "angles not equal" case with an arc of length tending to π, and rests on Prop. 16 there. I did not
check Prop. 16 at a horn.

**Proposed edits (for the close; I edit none of these files).** Wherever FS110-CB's D2 and D5 item 5 are filed (`LEDGER.md` § B, the FS-110
derivation file): "cusp and double-cusp vertices included (FS110-CC C1–C6)"; D2's item (a) in the stronger form of C2; D5 item 5's proof completed by
C5's inner-q case. No `BIBLIOGRAPHY.md` change: `[SokolovVoronov2025]` §6 (Props. 9–11, Cor. 2–3, Prop. 17) read again, no new section.
