# FS111-V0 — a blind second mind on card 1 of FS-111 (the cone scale)

*Job FS111-V0 (de Bruijn, Opus 5.5), opened 2026-09-28 04:25 UTC. Brief: `data/fs111/briefs/V0-111-card1-verify.md`, with
`data/fs111/briefs/STANDING-RULES.md`. Blind to `plans/FS111-cone-scale.md` until stage 2 is committed. Working files: `data/fs111/fs111-v0/`.*

## Theorems this phase proved

*(every line: statement, grade, count of minds, address)*

- **V0-ID1** — I-D1 re-derived for every a.e.-proper measurable colouring. [hand; one mind here, two with FS-103's D1] §2.1
- **V0-RESCALE** — an a.e.-proper measurable `k`-colouring exists ⟹ a tight one exists; so "a tight `k`-colouring exists iff `χ_m⁰(ℝ²) ≤ k`". [hand, one mind] §2.1
- **V0-CLOSE** — in a D-AEMAP-proper map, closure points of a colour-`j` region are never at distance 1 from open colour-`j` points. [hand, one mind] §2.1
- **V0-CLEAN** — W-EQ-K's limit tiling cleans to an S–V map-type segment-and-arc colouring, a.e.-proper, `≤ 6` colours. [hand, one mind] §2.1
- **V0-WIGGLE** — notching raises the complexity of a band-proper design without bound at fixed slack, junction cones, and `O(α²)` hole cost. [hand, one mind] §2.1
- **V0-WIG7** — the tight hexagonal seven-colouring with wiggled edges: fat junctions, arbitrary smooth interfaces. [hand, one mind] §2.1
- **FS111-C1-UNIF** re-derived, both inequalities, the pixelation checked on closed cells. [hand; one mind here, blind] §2.2
- **FS111-C1-PW** re-derived with V0-CLEAN. [derived, one mind here] §2.3
- **V0-FLIT** — the card's falsifier as written ⟺ no hole-vanishing family keeps cone scale `≥ s₀`. [hand, one mind; over V0-WIGGLE] §2.4
- **V0-BRIDGE** — Q-NO ∧ B_fam ∧ F′ ⟹ seven, and seven ⟹ F′. [derived, one mind] §2.4
- **C-SEVEN-M, C-SIX-M, C-REG-EQ** TRUE; **C-FILL** TRUE. [derived / hand, one mind] §2.8
- **V0-HULL-CX** — C-HULL's "so" is FALSE at the tight hexagonal seven-colouring of circumradius `1/2`. [hand + exact, one mind] §2.8, `tools/fs111_v0_hex.py`
- *Reading (not a theorem):* Q-NO bears on seven only through a statement of F′'s kind; killing test in §2.4 item 6.
- Stage 3: no new theorem; the reconciliation settles D1–D10 by the lemmas above (§3).

## Would-have-searched-here log (standing rule 3)

- Stage 2: would have searched for a hole-vanishing six-family with fat junctions at bounded complexity (a witness for F′ or against it) — derived the
  logical position of F′ instead (§2.4).
- Stage 2: would have asked a colouring finder whether the hexagonal seven-colouring at circumradius `1/2` is proper — checked it in closed form, exact
  (`tools/fs111_v0_hex.py`).
- Stage 2: would have searched numerically for a tight seven-colouring with a non-circular interface — built one by formula (V0-WIG7), by hand.

## Fence log (standing rule 13)

- Stage 1: to check the brief's two quotations of card 1, I ran `grep -nF` for the two quoted strings on `plans/POROS-2026-09-27-night-aim.md`,
  printing only the matching lines (107 and 114). Nothing else of that file was displayed. No other fenced path was opened, listed or grepped.
- Stage 3 (after `08c4d8f3`): read `plans/FS111-cone-scale.md` stages 2, 3b and 5 as the brief directs (and its heading list to find them); nothing
  else of it, and nothing else fenced.

## Stage 1 — SAVED: quotation check; what each held statement quantifies over

### 1.1 Files read, in order

`data/fs111/briefs/V0-111-card1-verify.md`; `data/fs111/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim, § Counter-priors, G82, G21 (from disk where
quoted below); `LEDGER.md` rows 130–135; `plans/FS107-derivation.md` in full; `plans/FS107-W-near-colourings.md` §2.1–§2.6; `plans/FS107-R-stability.md`
§3.2, §3.4; `plans/STUB-global-step.md`; `data/fs106/claims.md` §0–§1; `data/fs111/claims.md` in full; `data/fs107/claims.md` §0–§1 (the source of H-EQ's
quotation); `plans/FS106-QB-verification.md` §1.2 and §2.6 (the source of `µ₆^per` and the pixelation step C1-UNIF needs).

### 1.2 Quotation check (standing rule 5)

| # | quotation in the brief or in `data/fs111/claims.md` | source | result |
|---|---|---|---|
| 1 | *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."* | `CLAUDE.md` § The aim, l. 76–77 | verbatim (the quote's first two sentences; the source continues "(Anything we do …)") |
| 2 | "with FS-114's NO" … "the route to `χ_m⁰(ℝ²) = 7`" | `CLAUDE.md` l. 359 (rank 2 row): "with FS-114's NO it is the route to `χ_m⁰(ℝ²) = 7` (so `χ(ℝ²) = 7` given MR)" | verbatim fragments |
| 3 | card 1's ask, *"Does FS-114's NO at every complexity bound plus FS-111's cone-scale bound give seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K, or a NO for the boundaries a limit produces?"* | `plans/POROS-2026-09-27-night-aim.md` l. 107 (grep of the string only) | verbatim |
| 4 | the falsifier, *"a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a segment-and-arc map"* | same file, l. 114 (grep of the string only) | verbatim |
| 5 | standing rules 0, 3, 4, 10: Kooshi's counter-prior, the ban's intent, "search for a finite graph is out …", "A proven theorem about why its impossible is also valid. All novel knowledge is a success.", "It's ok if jobs overrun a bit. …" | `CLAUDE.md` § Counter-priors, § Toolchain, § Where the problem stands item 23; `plans/CONSOLIDATION-2026-09-27.md` l. 75 | verbatim |
| 6 | claims §0, **`𝓜_K`** | `plans/FS107-W-near-colourings.md` §2.1 step 1 | verbatim |
| 7 | claims §0, *band-proper at slack `ε`*: "no monochromatic pair at any distance in `[1 − ε, 1 + ε]`", attributed to "`data/fs107/claims.md` §0, SEQ" | the phrase is in `data/fs107/claims.md` **§1**, l. 58–59 (W — TQ-EQ (e)); §0 has no SEQ entry and §1's SEQ line (l. 11) does not contain it | **wording verbatim, address wrong** (a correction owed to the claim list; harmless to meaning) |
| 8 | claims §0, D-NF, D-SLACK (with its ellipsis), D-AEMAP | `data/fs106/claims.md` §0 | verbatim |
| 9 | claims §0, Q-NO's quotation of row 134 | `LEDGER.md` row 134, bold text | verbatim |
| 10 | claims §1, H-EQ | `data/fs107/claims.md` §1, l. 37–39 (itself FS106-EQ) | verbatim (a prefix of the source, which continues "At k = 6: …") |
| 11 | claims §1, row 130's "Given MR (row 128): `χ(ℝ²) = χ_m⁰(ℝ²)`" | `LEDGER.md` row 130 | verbatim |
| 12 | claims §1, I-D1 | `data/fs106/claims.md` §1 | verbatim |
| 13 | claims §1, W-EQ-K; FS107-RR (A), (B); FS107-R-SAT | `plans/FS107-derivation.md` §2, §1 | verbatim |
| 14 | claims §1, FS106-AE-MAP6 | `plans/FS106-derivation.md` l. 121 | verbatim (a prefix; the source continues "; no step uses 'boundaries of measure 0' …") |
| 15 | claims §3, PER's quotation of link 6 | `CLAUDE.md` § The aim, link 6 | verbatim |

Not checked (not used by any claim I work): `[Voronov2023]` Prop. 2.1, `[Bukh2008]`, Cohen–Mani (external; routes of §3–§4 outside my list).

### 1.3 What each held statement quantifies over (my words beside the quotations)

| statement | object | complexity | boundary class | shape |
|---|---|---|---|---|
| **Q-NO** (row 134 ∧ FS-114's NO) | full map-type colourings (S–V Conditions 2–4), coloured on open regions only, a.e.-proper in D-AEMAP's sense; periodic or not | locally finite only — no uniform bound on arcs per disc, no lower bound on arc radius | finite unions of segments and circular arcs; row 134 every radius but 1, FS-114 radius 1 allowed, so together every radius | universal negative: no such map exists. **FS-114's half is open.** |
| **FS107-RR's (A)** | every band-proper partial six-colouring (slack `ε > 0`, holes allowed, measurable) whose holes in `U_R` are `< δ` | every complexity (no restriction; this is already A-ALL) | any | `∃ R, η, µ` `∀` colouring `∃` a complementary pair of fat junctions in `U_R`, at distance in `[η, 2 − η]`, blocking toward a common unit point |
| **FS107-RR's (B)** | the pairs (A) supplies, in the same colourings | every | any | the pair's cone scale `s ≥ s₀`, voids small relative to `min(s, µη²/100)`; a statement about junctions only, nothing about interfaces |
| **W-EQ-K** | on one side periodic designs in `𝓜_K` (closed tiles, `≤ K` arcs or segments per tile, arc radius `≥ 1/K`, `≤ K` tiles per unit disc); on the other full tight a.e.-proper six-colourings by tiles of complexity `≤ K` (not necessarily periodic) | fixed `K`; ⟸ at `O(K)` | segments and circular arcs of radius `≥ 1/K` | equivalence: hole-vanishing families inside `𝓜_K` ⟺ a full tight map of complexity `≤ K` |
| **H-EQ** | measurable (null-form) families, CP colourings, a.e.-proper measurable colourings, and periodic grid-square partial colourings | unrestricted (grid mesh `→ 0`) | arbitrary measurable; staircase grids in form (e) | a chain of equivalences at every `k`; at `k = 6`, seven ⟺ `lim µ₆(ε) < 1` |

**The mismatch the card is about, read off the table:** Q-NO and W-EQ-K live at uniformly bounded complexity with segment-and-arc boundaries; H-EQ's
families have unbounded complexity and arbitrary boundaries; RR's (A) and (B) are complexity-free but (B) speaks only of junctions. Nothing in the
table speaks of interfaces at unbounded complexity.

## Stage 1 — SAVED

## Stage 2 — SAVED: verdicts, blind (FS111-P's record unread)

Notation of `data/fs111/claims.md`. **Seven** abbreviates `χ_m⁰(ℝ²) ≥ 7`. **𝓕** is the set of hole-vanishing families: sequences of band-proper partial
six-colourings (periodic, by closed tiles or grid squares) with slack `ε_n → 0` and uncovered density `δ_n → 0`; by H-EQ (e) and 2.2 below, `𝓕 ≠ ∅` ⟺
`χ_m⁰(ℝ²) ≤ 6`. **𝓕_{s₀}**: the families in 𝓕 whose members keep cone scale `≥ s₀` (whichever reading of the cone scale). Every result below is one mind
(FS111-V0), blind to FS111-P's derivations.

### 2.1 Five lemmas used below (my derivations)

**V0-ID1 (I-D1, re-derived).** "If `y ∈ S̃_j` and `d̄_j(x) = θ > 0`, then `|x − y| ≠ 1`" holds for every measurable colouring proper at `Leb ⊗ σ`-a.e. edge.
*Proof.* Suppose `|x − y| = 1`. Along `r → 0` with `|S_j ∩ B(x, r)| ≥ θπr²/2`: for `x′ ∈ B(x, r)` the circle `T₁(x′)` passes within `r` of `y`, so
`σ{w : x′ + w ∈ B(y, 2r)} ≥ r/π`; the pairs landing in `N = B(y, 2r) ∖ S_j` have measure `∫ |(B(x, r) + w) ∩ N| dσ(w) ≤ (4r)·|N| = o(r³)` (only `w`
within angle `≈ 3r` of `y − x` contribute, and `|N| = o(r²)` because `y` is a density point). So monochromatic unit pairs have measure
`≥ θr³/2 − o(r³) > 0`. ∎ [hand, one mind; with FS-103's D1, two]

**V0-RESCALE — if an a.e.-proper measurable `k`-colouring exists, a tight one exists.** So the claim list's "A tight D-NF `k`-colouring exists iff
`χ_m⁰(ℝ²) ≤ k` (this list's reading of the definition D-M)" is a theorem, not a reading: a colouring with slack witnesses `χ_m⁰ ≤ k` without being tight.
*Proof.* (i) *Continuity:* for a class `S` and a bounded window `B`, `φ(d) = (Leb ⊗ σ){(x, w) : x ∈ S ∩ B, x + dw ∈ S} = ∫ g(dw) dσ(w)` with
`g(v) = |(S ∩ B) ∩ (S − v)|` continuous (translation is continuous in `L¹`), so `φ` is continuous; and form (a) on `[α, β]` is `∫_α^β 2πd·φ(d) dd = 0`,
so form (a) null on a closed band gives form (b) at every distance in it. (ii) Let `ε* = sup{ε : f has slack ε in form (a)}`; `ε* < 1`, since a class of
positive measure has non-null pairs at every small distance near a density point. Slack holds at `ε*` itself (the two boundary circles are
`Leb ⊗ Leb`-null). If `ε* = 0`, `f` is tight. Otherwise, for every `η > 0` the pairs in `[1 − ε* − η, 1 − ε*) ∪ (1 + ε*, 1 + ε* + η]` are non-null, so
one side, say the upper, is non-null for every `η` (each side's set of such `η` is upward closed). Put `g(x) = f((1 + ε*)x)`: its monochromatic pairs are
null on `[(1 − ε*)/(1 + ε*), 1]`, hence (by (i)) `g` is proper at `Leb ⊗ σ`-a.e. unit edge, and non-null in `(1, 1 + η]` for every `η`: `g` is tight. (The
lower side: scale by `1 − ε*`.) ∎ [hand, one mind]

**V0-CLOSE.** In a map-type colouring a.e.-proper in D-AEMAP's sense, a point `y` in the closure of an open region `R` of colour `j` is at distance
`≠ 1` from every point `z` of an open region `R′` of colour `j`. *Proof.* If `|y − z| = 1`, take `B(z, ρ) ⊆ R′`, `y′ ∈ R` with `|y′ − y| < ρ`, and
`z′ = z + (y′ − y) ∈ R′`: `|y′ − z′| = 1`. ∎ [hand, one mind] (The same translation, with `y′` chosen off a null set, works when `z` lies in the interior of
a union of closed tiles of colour `j`.)

**V0-CLEAN — W-EQ-K's limit object is a map in S–V's sense.** A covering of the plane by closed tiles, each bounded by at most `K` segments or circular
arcs, at most `K` meeting any unit disc, coloured from six colours with no two interior points of one colour at distance 1, can be modified into a
map-type colouring (S–V Conditions 2–4) whose boundaries are finite unions of segments and circular arcs, a.e.-proper (D-AEMAP), with at most six
colours. *Proof.* Replace each tile by the closure of its interior. Let `U_j` be the interior of the union of the colour-`j` tiles: by V0-CLOSE's
remark no two points of `U_j` are at distance 1 (so shared boundaries of equal-coloured tiles and slits are absorbed). Regions are the components of
the `U_j`; each has diameter `≤ 1` (a connected open set avoiding the distance 1). The rest, `Z`, is a locally finite union of arcs, and every point of
`Z` lies in the closure of regions of two different colours (else a neighbourhood lies in the tiles of one colour, i.e. in some `U_j`). So `Z` has no
isolated points and no vertices of degree 1; erase degree-2 vertices. A component of `Z` that is a closed curve with no vertex (an island) is removed
by recolouring its inside with its outside colour `b`: for `q` in another region of colour `b`, the distances from `q` to the closure of the outer region
`B` form an interval avoiding 1 (V0-CLOSE), and the inside's distances to `q` lie between the extremes on the loop, so they avoid 1 too; the new region's
closure has diameter `diam(cl B) ≤ 1`; fills of disjoint loops are made one at a time, and properness is a pairwise condition. Every boundary lies in
the closure of a region, so it is bounded and a finite union of arcs. ∎ [hand, one mind] (If Q-NO's "six-colouring" is read as using exactly six
colours, a map using fewer is excluded by FS106-AE-MAP6 at five, over its own grade.)

**V0-WIGGLE — complexity is not a property a family keeps.** Let `P` be a band-proper partial six-colouring at slack `ε` by closed tiles, periodic, and
let `α > 0`. Cut from one tile per period a notch: a disc of radius `α` centred on its boundary, placed at positive distance from the (slightly
shrunken, compact) cones of its fat junctions. The result `P′` is band-proper at the same slack `ε` (points were only removed), its holes grow by
`≤ πα²/2` per period, every fat junction of `P` (cones shrunk by a factor `1 − β`) is a fat junction of `P′`, blocking margins change by at most `β`,
and `P′ ∉ 𝓜_K` for `K < 1/α`. So along any family, notches with `α_n → 0` raise complexity without bound at no cost in slack, holes or cone scale.
∎ [hand, one mind] The same with smooth wiggles on a two-colour interface of amplitude `< ε/8` (slack halves).

**V0-WIG7 — at `k = 7` a tight map with fat junctions need not have segment-and-arc interfaces.** The hexagonal seven-colouring of side `1/2` (2.8) with
every edge replaced by a smooth curve within `min(α₀, t/4)` of it (`t` the distance to the nearer end) is a.e.-proper and tight: the only tight contacts
are opposite vertex pairs of one hexagon, near which the wiggles vanish (the vertex wedges' half-angles stay below `75°`, so pairs near opposite
vertices stay below 1: `|p − q| ≤ 1 − 0.26(s + s′) + O((s + s′)²)` for points at distances `s, s′` from the two vertices); pairs of one hexagon with
`s + s′ ≥ s₁` have slack `c(s₁) > 0`, kept for `α₀ < c(s₁)/2`; pairs across two hexagons of one colour keep slack `≥ 0.09` for `α₀ < 0.1`. Its junctions
are fat sectors (at least `120° − 29°`); its interfaces are arbitrary smooth curves. ∎ [hand, one mind] So "fat junctions ⟹ segment-and-arc interfaces" fails on tight colourings wherever they are inhabited.

### 2.2 FS111-C1-UNIF — **TRUE** [hand, one mind here; blind to FS111-P]

*Statement* (verbatim): "`1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K)`. Hence (H-EQ at `k = 6`): **`χ_m⁰(ℝ²) ≥ 7` ⟺ `inf_K δ₀(K) > 0`.**"

*Monotonicity.* `f_K(ε)` is non-decreasing in `ε` (slack `ε` implies slack `ε′ < ε`) and non-increasing in `K` (`𝓜_K ⊆ 𝓜_{K′}` for `K ≤ K′`), so
`δ₀(K) = lim_{ε→0} f_K(ε)` and `inf_K δ₀(K) = lim_K δ₀(K)`; `µ₆(ε)` is non-increasing, so `L := lim µ₆(ε) = sup_ε µ₆(ε)`.

*(≥).* A member of `𝓜_K` band-proper at slack `ε`, its tile boundaries removed, is a family of disjoint measurable classes with **no** pair in the band;
its covered density (it is periodic) is at most `µ₆(ε)`. So `f_K(ε) ≥ 1 − µ₆(ε)`, `δ₀(K) = inf_ε f_K(ε) ≥ 1 − L`, for every `K`.

*(≤) — the rasterisation step, checked.* Fix `ε`, `η > 0`. Row 131's `µ₆^per(ε) = µ₆(ε)` (QB §2.6 (ii)): an `ε`-slack family, band-null, periodic
with period `L + 2`, of density `≥ µ₆(ε) − η`. Pixelate on the grid `hℤ²`, `h | L + 2` (QB §2.6 (iii)): colour a cell `Q` by `min{j : |C_j ∩ Q| > 0}`.
If two cells `Q, Q′` of colour `j` held points at distance `d ∈ [1 − ε + 2√2h, 1 + ε − 2√2h]`, every cross distance would lie in `[1 − ε, 1 + ε]` (the
distance set of two squares is an interval of length `≤ 2√2h`), and `(C_j ∩ Q) × (C_j ∩ Q′)` has positive measure: contradiction with band-nullness.
I checked it with **closed** cells too (their distance sets are the closures): no pair in `[1 − ε + 3h, 1 + ε − 3h]`. The cells cover `⋃ C_j` up to a null
set, and the colouring is periodic. My own variant (majority rule, cell coloured `j` iff `|C_j ∩ Q| > |Q|/2`, loss `≤ 2Σ‖1_{C_j} − E_h 1_{C_j}‖₁ → 0`)
gives the same. A grid of mesh `h` is in `𝓜_{K(h)}`, `K(h) = ⌈(2/h + 2)²⌉` (four segments per tile). So `f_{K(h)}(ε − 3h) ≤ 1 − µ₆(ε) + η ≤ 1 − L + η`,
hence `δ₀(K(h)) ≤ 1 − L + η` and `inf_K δ₀(K) ≤ 1 − L`.

*"Hence."* Needs only (≥) and H-EQ (e), not `µ^per`: H-EQ at 6 says `χ_m⁰ ≤ 6` ⟺ `L = 1` ⟺ grid families with vanishing holes, which lie in `𝓜_{K(h)}`.
TRUE. **Audit:** the one place a FALSE could hide is band-nullness versus strict band-properness (`µ` counts null-form families, `𝓜_K` demands no pair
at all); the pixelation turns the first into the second at a slack loss `O(h)`, so the two infima agree.

### 2.3 FS111-C1-PW — **TRUE** [derived, one mind here; over W-EQ-K (⟹), Q-NO and V0-CLEAN]

If `δ₀(K) = 0`, then `f_K(ε) → 0`, so there are `P_n ∈ 𝓜_K` with `ε_n → 0` (a design with slack `ε` has every smaller slack) and `δ_n → 0`; W-EQ-K (⟹)
gives a full a.e.-proper six-colouring by tiles of complexity `≤ K`; **V0-CLEAN** makes it a locally finite segment-and-arc map, a.e.-proper, which
Q-NO forbids. The cleaning step is the one W-EQ-K's statement leaves implicit ("by tiles" is not "a map-type colouring"); it holds. *Note:* the converse
is weaker — `δ₀(K) > 0 ∀K` does not give Q-NO, which also covers maps with no uniform bound on arcs per disc or on `1/radius`.

### 2.4 The card, worked: does Q-NO at every complexity bound plus a cone-scale bound give `lim µ₆(ε) < 1`?

**No derivation exists among the statements held; the composition is exactly one missing statement away, and I can name it.**

1. *What Q-NO buys.* By C1-PW, `δ₀(K) > 0` for every `K`; by C1-UNIF, seven is `inf_K δ₀(K) > 0`. So Q-NO is the pointwise statement and seven the
   uniform one; the card's "a hole bound uniform in K" **is seven itself**, not a third statement.
2. *The card's falsifier, read literally, cannot be a bridge.* By **V0-WIGGLE**, if any family in `𝓕_{s₀}` exists, notching it gives one in `𝓕_{s₀}`
   with no subsequence of bounded complexity (and grid families already have complexity `≍ h⁻² → ∞`). So the falsifier as written, "every family with
   holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a segment-and-arc map", is **equivalent to `𝓕_{s₀} = ∅`**. With
   the cone-scale bound read for families ("if holes can vanish, they can vanish keeping cone scale `≥ s₀`", call it **B_fam**), that is seven itself.
3. *The bridge, modification-invariant.* **F′(s₀): if `𝓕_{s₀} ≠ ∅`, then `δ₀(K) = 0` for some `K`** (equivalently, by W-EQ-K ⟸, a full tight map of
   uniformly bounded segment-and-arc complexity exists). Then **Q-NO ∧ B_fam ∧ F′ ⟹ seven** (C1-PW makes F′'s conclusion false, so `𝓕_{s₀} = ∅`, so
   `𝓕 = ∅` by B_fam, which is seven by H-EQ), and **seven ⟹ F′** (vacuously). So "Q-NO ∧ B_fam ⟹ seven" holds exactly when "Q-NO ∧ B_fam ⟹ F′" does,
   and no derivation of F′ is known. [derived, one mind]
4. *Why the cone scale does not give F′.* F′ needs two things the cone scale does not touch: interfaces with uniformly finitely many arcs per unit disc,
   and interfaces that are segments and circular arcs at all. V0-WIGGLE kills any route from junction data to the first on the sequence, and V0-WIG7 to
   the second on the limit: a tight colouring with fat junctions can have arbitrary smooth interfaces (inhabited at `k = 7`).
5. *The card's three candidates.*
   - **R's (A) at unbounded complexity** — sufficient with (B) and FS107-R-CP (FS107-RR), and then Q-NO is idle. Measured literally, "(A) at unbounded
     complexity" already implies (A) at every complexity: notch a bounded member (V0-WIGGLE), apply (A); notching only removes points, so every fat
     junction pair of the notched member is one of the original (holes change by `O(α²)`). So Q-NO can shorten route R only if complexity is measured
     modulo modification.
   - **A hole bound uniform in K** — seven itself (C1-UNIF).
   - **A NO for the boundaries a limit produces** — for all limits, seven itself (V0-RESCALE and H-EQ: every tight six-colouring's existence is seven's
     failure). Restricted by the cone scale to limits with fat junctions, a genuine third statement; it contains the fat-junction part of Q-NO, so Q-NO
     is idle unless that NO is proved by reducing to segment-and-arc maps of bounded complexity — which is F′.
6. *Reading, with its killing test:* **Q-NO bears on seven only through a statement of F′'s kind** — one that turns a hole-vanishing family, or its
   limit, into a segment-and-arc map of bounded complexity; every other completion makes Q-NO idle. Killing test: a derivation of seven that uses Q-NO and
   produces no segment-and-arc map from a hypothetical six-colouring.
7. *What F′ would take (counter-priors rule 3).* (i) Pass `𝓕_{s₀}` to its limit (H-EQ's compactness; fat cones survive as density-1 sets). (ii) REG-J with
   uniform constants — needs a lower bound on the cones' angular widths, which FS107-RR's fatness does not contain. (iii) Saturation (C-SAT-T) and the
   semiconcavity of two-colour interfaces (C-HULL-REG). (iv) The step no cone scale reaches: a tight six-map's interfaces are envelopes of unit circles
   about same-colour contact partners — a unit arc where the partner is a point, a parallel curve where the partner moves along another interface —
   so (iv) is a finiteness statement for the partner structure, or a straightening of parallel curve pairs into arcs. The alternative to (iv) is to
   extend the NO itself to the interfaces (iii) produces (NO-C2's kind); row 134's chain "No step uses the complexity bound", so its N4 step (curvature
   monotonicity) is where that extension would be decided.

### 2.5 FS111-C1-GAP — **MISSTATED**; corrected statement [derived, one mind]

*Statement* (verbatim): "Q-NO ∧ (B), in any of the three readings, implies seven only together with a third statement covering, respectively, `𝒩` at
unbounded complexity (the first two readings) or the interfaces of the limit (the third)."

*What is TRUE:* the location of the gap. Q-NO excludes hole-vanishing families of bounded complexity (C1-PW); (B) with FS107-R-CP excludes, in discs with
small holes, complementary blocking pairs of fat junctions; what neither touches is `𝒩` beyond bounded complexity (readings 1–2), and with REG-J the
limit's interfaces (reading 3). *What is MISSTATED:* "only together with" asserts a non-implication, which no argument here can establish — seven implies
every candidate third statement (vacuously), so "is a third statement needed" is the open question of whether Q-NO ∧ (B) implies it.

**Corrected.** For each reading `r` there is a statement `T_r` with Q-NO ∧ (B) ∧ `T_r` ⟹ seven and seven ⟹ `T_r`, so the composition holds iff
Q-NO ∧ (B) ⟹ `T_r`, and no derivation of `T_r` is known:
- `T₁ = T₂`: no family in 𝓕 has its members eventually in `𝒩`, where, **given Q-NO, only families of unbounded complexity measured modulo modification
  need excluding**. Measured literally, "unbounded complexity" is no restriction (V0-WIGGLE), and `T` is (A) itself with Q-NO idle.
- `T₃`: the limit's interfaces — REG-I and REG-A given REG-J (with uniform constants), or a NO covering the interfaces a limit with REG-J junctions has
  (then Q-NO is idle for fat-junction maps). V0-WIG7 shows REG-J alone leaves arbitrary interfaces.
- *A caution on reading 2, conditional on its definition in the planner's table (fenced from me):* B-NONABS's "cone scale `≥ s₀(δ) > 0`" excludes a
  pair through FS107-R-CP only if `s₀(δ)²` is not `o(δ)` (the forced area is `≍ s₀² sin²(µ/2)/9`); with `s₀(δ) → 0` permitted, the residual also holds
  families with pairs.

### 2.6 FS111-C1-FALS — **MISSTATED** (its reason TRUE and strengthened); corrected statement [hand, one mind]

*Statement* (this list's wording): the falsifier "does not follow from (B) in any reading: its first half needs 'cone scale `≥ s₀` ⟹ bounded
complexity', and complexity also counts interfaces, which no reading of (B) constrains."

*TRUE:* "cone scale `≥ s₀` ⟹ bounded complexity" is **FALSE** on band-proper partial six-colourings in every reading (V0-WIGGLE: notches or wiggles
raise complexity without bound at fixed slack, fixed junction cones and vanishing hole cost); and on the limit side "fat junctions ⟹ segment-and-arc
interfaces" is FALSE where tight colourings are inhabited (V0-WIG7, `k = 7`). *MISSTATED:* "does not follow from (B)" cannot be established as a
non-implication (seven implies the falsifier), and the literal falsifier is not the right target: it is **equivalent to `𝓕_{s₀} = ∅`** (2.4 item 2).

**Corrected.** (i) No derivation that uses only (B)'s content about junctions plus band-properness gives bounded complexity or segment-and-arc limits
(V0-WIGGLE, V0-WIG7). (ii) The falsifier as written is equivalent to "no hole-vanishing family keeps cone scale `≥ s₀`"; with B_fam this is seven.
(iii) Its modification-invariant form is F′ (2.4 item 3), the exact bridge from Q-NO ∧ B_fam to seven; whether Q-NO ∧ B_fam (with `δ → 0` and
tightness used) implies F′ is open.

### 2.7 FS111-C1-ROUTES — **TRUE** as a summary, with two additions [derived, one mind]

(R): FS107-RR (given FS107-R-CP; two minds after repairs) gives C-Q-STAB's disc form, which gives `lim µ₆ < 1` (pixelation 2.2 turns the disc form's
strict condition into D-MU's null form; average over translates), which is seven by H-EQ; Q-NO is not used. "(A) at every complexity" is FS107-RR's (A)
as posed (A-ALL). (M): Q-NO ∧ REG-A₆ ⟹ seven is C-SEVEN-M (2.8). The front page's composition is (M) with REG-I and REG-A missing, or (R) with (A)
missing: TRUE. *Additions:* (1) (M)'s missing rungs have a sequence form, F′; (2) by V0-WIGGLE, restricting (A) to "unbounded complexity" gives Q-NO
nothing to do unless complexity is measured modulo modification.

### 2.8 The ARG claims of §3, and C-HULL, C-FILL

- **C-SEVEN-M — TRUE** [derived, one mind]. If `χ_m⁰ ≤ 6`, V0-RESCALE gives a tight a.e.-proper six-colouring; REG-A₆ gives a segment-and-arc map
  carrying an a.e.-proper six-colouring; Q-NO forbids it. Without V0-RESCALE this step rested on the list's unproved "reading of the definition".
- **C-SIX-M — TRUE** [derived, one mind]. The same at five with REG-I₅ and FS106-AE-MAP6 (over its grade, modulo Townsend's (c)); given MR, row 130's
  `χ(ℝ²) = χ_m⁰(ℝ²)` gives `χ(ℝ²) ≥ 6` (MR is needed: I-EASY runs the other way).
- **C-REG-EQ — TRUE** [derived, one mind]. ⟹ is C-SEVEN-M (C-SIX-M); ⟸ by vacuity (with seven, no a.e.-proper six-colouring exists, tight or not). So,
  given Q-NO, REG-A₆ is exactly as strong as the answer; its rungs REG-J₆, REG-I₆ are implied by the answer (vacuously) and do not imply it alone.
- **C-HULL — MISSTATED: the first clause TRUE, the "so" FALSE** [hand, one mind; exact check `tools/fs111_v0_hex.py`, output
  `data/fs111/fs111-v0/hex_check.out`, three plants each failing at its own assertion].
  - *First clause, TRUE.* For `c ∈ C ⊆ S̃_j` and `x ∈ A*_j`, V0-ID1 gives `|x − c| ≠ 1`; `C` is path-connected, so `{|x − c| : c ∈ C}` is an interval
    avoiding 1: `C ⊆ B(x, 1)` or `C ∩ B̄(x, 1) = ∅`.
  - *The "so", FALSE.* The hexagonal seven-colouring by regular hexagons of circumradius `1/2`, coloured `(m + 3n) mod 7`, is a.e.-proper (same-colour
    centres `≥ √21/2` apart, gaps `> 1.29`) and tight (each hexagon's diameter is exactly 1). Take `x = v₀` a vertex of a hexagon `H` of colour `j`
    (`d̄_j(v₀) = 1/3`, so `x ∈ A*_j`) and `C = int H`: then `sup_{c ∈ C} |x − c| = 1`, attained only at the opposite vertex `v₃ ∉ C`, and
    `dist(x, C) = 0`; `x` lies in neither set of the union. This is the claim list's own `k = 7` control.
  - *Corrected:* `A*_j ⊆ {x : |x − c| < 1 ∀c ∈ C} ∪ {x : |x − c| > 1 ∀c ∈ C}`; the sup/dist form holds when `C` is compact; in general only
    `A*_j ⊆ {sup ≤ 1} ∪ {dist ≥ 1}`. Inhabitant at `k = 7`: the same colouring.
- **C-FILL — TRUE** [hand, one mind]. `x ∈ A*_j` forces `η < 1` (for `η ≥ 1`, `A_η(x)` contains a neighbourhood of `x`, where `S̃_j` has positive measure),
  so `B = B(x, η/2)` has diameter `η < 1`: no new unit pair inside `B`. A unit pair from `b ∈ B` to `y ∈ S_j ∖ B` has `||y − x| − 1| ≤ η/2`, so `y ∈ N =
  S_j ∩ A_η(x)`, which is null (`S̃_j ∩ A_η(x)` null and `S_j ∖ S̃_j` null); `(Leb ⊗ σ){(b, w) : b + w ∈ N} ≤ |N| = 0`. Other classes only lose points.
  *Inhabitant at `k = 7`:* the tight hexagonal colouring above at an edge midpoint (own hexagon's farthest point at `√13/4 ≈ 0.901`, other colour-`j`
  hexagons beyond `1.29`), `η < 0.098`; its vertices are not free, as the tightness requires.

### 2.9 Verdict table

| claim | verdict | grade, minds |
|---|---|---|
| FS111-C1-UNIF | TRUE (the rasterisation step checked, with closed cells) | [hand], one mind here, blind |
| FS111-C1-PW | TRUE, with the cleaning step V0-CLEAN named | [derived], one mind here |
| FS111-C1-GAP | MISSTATED — the gap's location TRUE; "only together with" not establishable; corrected in 2.5 (`T_r`, complexity modulo modification) | [derived], one mind |
| FS111-C1-FALS | MISSTATED — its reason TRUE and strengthened (V0-WIGGLE, V0-WIG7); the literal falsifier ⟺ `𝓕_{s₀} = ∅`; corrected in 2.6 | [hand], one mind |
| FS111-C1-ROUTES | TRUE as a summary; two additions (F′; complexity modulo modification) | [derived], one mind |
| C-SEVEN-M | TRUE (with V0-RESCALE) | [derived], one mind |
| C-SIX-M | TRUE (with V0-RESCALE) | [derived], one mind |
| C-REG-EQ | TRUE (⟸ by vacuity) | [derived], one mind |
| C-HULL | MISSTATED — first clause TRUE; "so" FALSE (the tight hexagonal seven-colouring) | [hand] + exact check, one mind |
| C-FILL | TRUE | [hand], one mind |
| **card 1** | a third statement is needed in the only sense available: the composition holds iff Q-NO ∧ (B) ⟹ F′ (or `T_r`), which is open; "a hole bound uniform in K" is seven itself | [derived], one mind |

### 2.10 A proposed correction to the front page (for the close; I edit nothing)

`CLAUDE.md` rank-2 row, "with FS-114's NO it is the route to `χ_m⁰(ℝ²) = 7`": replace by *"with FS-114's NO it gives `χ_m⁰(ℝ²) = 7` only with a third
step — F′, turning a hole-vanishing family that keeps its cone scale into one of bounded segment-and-arc complexity, or a NO for the interfaces such
limits have, or R's (A) (then FS-114's NO is idle); a hole bound uniform in the complexity is seven itself (FS111-C1-UNIF)"* — over the reconciliation
of stage 3.

## Stage 2 — SAVED

## Stage 3 — SAVED: reconciliation with `plans/FS111-cone-scale.md` stages 2, 3b and 5 (read only after stage 2 was committed at `08c4d8f3`)

**Agreement first.** On the card's answer we agree: a third statement is needed, "a hole bound uniform in K" is seven itself, route R leaves Q-NO idle,
route M's top rung is as strong as the answer, and the gap sits where neither premise speaks (`𝒩` beyond bounded complexity; the limit's interfaces).
C1-UNIF, C1-PW, C1-ROUTES, C-SEVEN-M, C-SIX-M, C-REG-EQ and C-FILL are TRUE on both records: **two minds, one blind**.

| # | claim | FS111-P | FS111-V0 (blind) | kind | settled |
|---|---|---|---|---|---|
| D1 | C1-UNIF, direction (≤) | stage 2 applied H-EQ's limit clause at a level and cited FS-106-SUP for grids; stage 3b corrects: SUP gives periodic families, a density-threshold rasterisation gives grids | the same route, independently (QB §2.6 (iii)'s pixelation, or a majority rule; checked with closed cells, slack loss `3h`) | proof | **agree after 3b's correction**; both note the equivalence needs only H-EQ |
| D2 | C1-PW | "W-EQ-K gives … a locally finite map"; row 134 and FS-114 exclude it | the output is a tiling by closed tiles, not yet an S–V map; **V0-CLEAN** (merge equal colours, erase slits and degree-2 vertices, fill islands) makes it one | proof, a routine step made explicit | TRUE by V0-CLEAN [hand, one mind] |
| D3 | C1-GAP | TRUE, "*Proof:* the three rows above; … neither premise mentions that part" | MISSTATED: the gap's location is TRUE, but "only together with" is a non-implication no argument can establish — seven implies every candidate third statement vacuously | **statement** | settled by derivation (§2.5): the composition holds iff Q-NO ∧ (B) ⟹ `T_r`, open. "Neither premise mentions it" shows no *known* derivation, not that none exists |
| D4 | C1-GAP, reading 1–2's "`𝒩` at unbounded complexity" | complexity of a colouring | complexity of a single colouring is not a family invariant (**V0-WIGGLE**: notches raise it without bound for free); the restriction has content only modulo modification, and measured literally "(A) at unbounded complexity" already implies (A) at every complexity | **statement** | settled by V0-WIGGLE [hand, one mind] |
| D5 | stage 2's "The cone scale supplies uniformity **only through CP**" | stated as the frame of C1-GAP | overstated: reading 3's own row (REG-J) supplies junction separation, not CP, and F′ would supply uniformity by regularisation | statement | settled: true of readings 1–2 only |
| D6 | C1-FALS | "fails at the level of the notions … **Not fired.**" | the reason is TRUE and exact (V0-WIGGLE on the sequence, V0-WIG7 on the limit); **the falsifier as literally written is equivalent to "no hole-vanishing family keeps cone scale `≥ s₀`"**, so it is vacuous or false and could never fire as a bridge; its right form is F′ | **statement** | settled by V0-WIGGLE; F′ is the named bridge (V0-BRIDGE: Q-NO ∧ B_fam ∧ F′ ⟹ seven ⟹ F′) |
| D7 | C1-ROUTES, route M's step "a tight D-NF colouring exists iff `χ_m⁰(ℝ²) ≤ 6`, row 130" | cited to row 130 and "this list's reading of the definition D-M" | row 130 does not state it, and a colouring with slack witnesses `χ_m⁰ ≤ 6` without being tight; **V0-RESCALE** proves it (rescale by `1 ± ε*`) | proof: an unsupported step | TRUE by V0-RESCALE [hand, one mind]; the same step closes C-SEVEN-M, C-SIX-M and C-REG-EQ's ⟹ |
| D8 | C-HULL | TRUE (stage 5: "the image is an interval missing 1") — which proves the first clause only | first clause TRUE; **the "so" (`sup < 1` or `dist > 1`) FALSE** at the tight hexagonal seven-colouring of circumradius `1/2`, `x` a vertex, `C` the open hexagon (`tools/fs111_v0_hex.py`) | **truth** | settled by an exact counterexample; corrected form in §2.8 |
| D9 | C-FILL | "pairs inside the disc are shorter than 1 for `η ≤ 1`" | `η < 1` is forced by `x ∈ A*_j` | none of truth | agree TRUE |
| D10 | the front page's correction | "with FS-114's NO **and REG** (route M), or with **(A) at every complexity** in place of the NO (route R)" | "only with a third step — F′, a NO for the interfaces such limits have, or R's (A)" | statement | merged below; REG-A₆ (P) and F′ (V0) are two different third statements, each equivalent to seven given Q-NO (and, for F′, B_fam) |

**Open, named (not settled by either record):** whether Q-NO ∧ (B) implies F′, REG-A₆ or `T_r` — the card's real question, now exactly posed; whether the
cone scale's fatness can be given an angular-width lower bound (REG-J with uniform constants needs one; FS107-RR's fatness has none); whether row 134's
N4 step survives curved (non-circular) interfaces (NO-C2's decisive step, since V0-WIG7 shows tight limits can carry them).

**P's reading that agrees with V0-WIG7.** Stage 2 §2.5: "'every tight colouring is regular' is not expected, since a tight colouring can carry local
slack where its boundaries are free" — V0-WIG7 is an instance at `k = 7`.

**Merged proposal for `CLAUDE.md` rank-2 row (the close writes it):** *"with FS-114's NO it gives `χ_m⁰(ℝ²) = 7` only with a third statement — REG (the
tight limit is, or can be replaced by, a segment-and-arc map; in sequence form F′: a hole-vanishing family keeping its cone scale can be replaced by one
of bounded segment-and-arc complexity) or R's (A) at every complexity (then FS-114's NO is idle); a hole bound uniform in the complexity is seven itself
(FS111-C1-UNIF); two minds, one blind (FS111-P, FS111-V0)."*

**Corrections owed to `data/fs111/claims.md` (for the close):** C-HULL's "so" (§2.8's corrected form); C1-GAP and C1-FALS as corrected in §2.5–§2.6;
the band-proper phrase's address (`data/fs107/claims.md` §1, l. 58–59, not §0 SEQ; the same slip in the planner's stage 2 §2.1); the parenthesis
"(this list's reading of the definition D-M)" after row 130 becomes a theorem, V0-RESCALE.

## Stage 3 — SAVED
