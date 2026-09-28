# FS114-L60 — FS112-L60 at its boundary, and every use of it in FS-112 and FS-114

*Job FS114-L60, de Bruijn (Opus 5.5), launched 2026-09-28 08:33 UTC at HEAD `7b9587bc`. Brief `data/fs114/briefs/L60-114-audit.md` with
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first) and the owner's note (FS114-N4 has reported; its §2.6 and §5.4 are open to me, to be checked
as a claim). Working files `data/fs114/fs114-l60/`; exact checks `tools/fs114_l60_check.py`, `tools/fs114_l60_quotes.py`; scratch
`scratchpad/fs114-l60/`. Resuming check: no record existed at start. Notation: `plans/FS112-N-proof.md` §1.3 (`Γ`, tiles, `P_cl`, `ω(x)`, N-E0, N-E1,
N-E2, TS-C: a tile's closure has diameter at most 1), `e(φ)` the unit vector at angle `φ`. A **unit arc with constant sides** is an arc `α ⊂ ω(P) ∩ Γ`
with one tile `T_in` along it inside `B(P, 1)` and one tile `T_out` outside (side colours `s_in`, `s_out`); `A`, `B` its ends, `ℓ` its angular length.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| L60-QT | every quotation in the brief is found at its source (15 of 15; four are the brief's glosses, compared by hand); the plant fires | [tools] | §1.2; `tools/fs114_l60_quotes.py` |
| **L60-LE** | a unit arc with constant sides has `ℓ ≤ 60°` (its ends lie in the closure of one tile) | [hand; two minds: N4, mine (not blind); the bound is TS-C in one line] | §1.3 |
| **L60-EQ** | at `ℓ = 60°` **both** side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)`: `T_in ⊆ Reul(P, A, B)`, `T_out ⊆ Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`; at each end their sectors lie in the two corner cones (120° and 60°), which fill exactly the closed half-plane facing the other end, so each end is a vertex carrying a third tile | [hand, one mind for the inner clause and the ends; the outer clause two minds: N4, mine; tools exact at named points] | §1.3; `… TILE`, `FRAG` |
| **L60-REAL** | equality is realised, by a valid fragment by formula on a neighbourhood of the closed arc (colours `Reul(P, A, B)`, the Reuleaux cap, two discs of radius `1/4` about the ends), and by any outer tile inside the cap that borders the whole arc — not only the whole cap | [hand + tools exact at named probes; two minds for the cap: N4, mine] | §1.3; `… FRAG` |
| **L60-2** | the second clause, read as NB reads it ("for `w ∈ int α`, no tile of colour `s_in` or `s_out` has `w ± 60°` in its closure"), holds for every `ℓ`; read at the ends ("no side colour at two points of `ᾱ` 60° apart"), it is **false exactly at equality**: `T_in` and `T_out` each hold both ends, and `ω(A)` crosses `ω(P)` at `B` at 60° without entering either | [hand, one mind for the ends reading; the interior reading two minds: NB, mine; tools exact] | §1.3; `… SECOND` |
| **L60-WALK** | no step of FS112-N2-RED, FS112-N3-COR3, FS112-N3-BASE, FS112-N3-DENSE3 or FS114-CV-EXISTS (with CVB-EXISTS) needs the strict bound; each use of "`< 60°`" in their frames needs `0 < ℓ ≤ 60°` or only `0 < ℓ < 180°`, and the equality case passes every step; two remarks outside the chain are false at equality (NB's C-UA-CHAIN aside, N's ends reading of the second clause) and nothing rests on them | [hand, one mind; tools exact: ENV60, COR3 at 55–60°] | §2 |
| L60-D5 | in N3-BASE's setting, the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart: at distance 1 the third tiles at the two ends are forced to one colour (the complement's third) by N-E1 at `u`, and N3-P′ refuses the pair; at a two-colour end, N3-PAIR and N3-NOBOTH refuse it — the step CB states as "`= 1` is (P′)" | [hand, one mind] | §2.3 |
| **L60-PROOFS** | both printed proofs of "`< 60°`" fail at exactly 60°, at different steps: N's radial point `(1 + ε)A` is outside `B̄(B, 1)`; NB's "`t ≫ δ`" is unavailable, since the lens holds `(1 + t)e(δ)` only for `t ≤ 2cos(60° − δ) − 1 < 2√3·tan(δ/2)`, and then the pair is exactly `(2cos 2δ − 1)² ≤ 1` apart. The frozen tools checked the pair's arithmetic, never its premise | [hand, one mind; tools exact] | §1.3; `… RADIAL`, `NBSTEP` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate end-vertex configurations of a 60° arc to see which survive | derived the equality shape (both side tiles in the lens, corner cones at the ends) and checked one fragment by formula exactly |
| scan arc lengths near 60° for where the old proofs break | derived the exact breaking points (`RADIAL`: `(1 + ε)A` against `B̄(B, 1)`; `NBSTEP`: `τ*(δ)` in closed form) and checked named values exactly |

## Fence log (standing rule 13; brief § Rules)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced). Its lines name FS-112's and FS-114's milestone status and standing rules; no proof content. No file under that path was opened by me.
2. The harness's start-up git status printed the untracked **names** `data/fs111/fs111-w/*` (FS-111), `data/fs114/fs114-yb2/*` and
   `tools/fs114_yb2_*.py` (FS-114's construction side), and five commit subjects. Names only.
3. `ls data/fs114/reports/` (checking whether my report existed) printed the names of all FS-114 reports, construction-side ones among them; none opened.
   `ls plans/FS114-* plans/FS112-*` printed the names `plans/FS114-Y*-construction.md`, `plans/FS114-YB*-verification.md`, `plans/FS114-close-inventory.md`,
   `plans/FS114-unit-arc-question.md`; none opened.
4. A `grep` for the L60 statement over `plans/STUB-*.md` scanned `plans/STUB-reg-scale.md` (FS-111's stub) among the others; no line of it matched or was
   printed. The same `grep` over `LEDGER.md` printed three unrelated rows (FS86-A2, FS86-VD-11, FS103-DG) beside FS112-L60's row.
5. `git status --short` printed the untracked name `tools/fs111_m2_covers.py` (FS-111's). Name only.
6. Read and not fenced (FS-112 records): `data/fs112/fs112-c/` by `grep` for `L60` (three lines of `ticks.md`, `ledger-b-draft.md`,
   `reconciliation.md`); `plans/FS110-CB-verification.md` §D5 (row 134's base, which NB3's item 9 cites).

## Stage 1 — SAVED: the quotation check; L60 at the boundary settled

### 1.1 Read from disk (G50), in this order

`data/fs114/briefs/L60-114-audit.md`; `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim, § Counter-priors and G21 (as loaded;
unchanged on disk since `a9410925`, before my launch); `plans/FS112-N-proof.md` in full; `plans/FS114-N4-proof.md` in full; `plans/FS112-derivation.md`
§§1–3 (ll. 1–260); `plans/FS112-NB3-verification.md` §1.4 (NOBOTH, FAIL, ANTI, COR3, PAIRS, BASE); `plans/FS114-CV-verification.md` ll. 1–215 (the lemmas
and CV-EXISTS); `plans/FS114-CVB-verification.md` header, §1.5, §2.2 A-1–A-9; `plans/FS112-NB2-verification.md` N2-RAY, N2-SIGN, N2-ENV and the `ℓ`
lines; `plans/FS112-NB-verification.md` ll. 136–215; `plans/FS114-N3-proof.md` header, table and §2.1–2.3; `plans/FS114-N-proof.md` ll. 196–204,
330–380; `plans/FS110-CB-verification.md` §D5; `plans/STUB-global-step.md` ll. 40–52; the L60 code of `tools/fs112_n_arcs.py`, `tools/fs112_n2_checks.py`,
`tools/fs112_nb_checks.py` and the COR3 code of `tools/fs112_nb3_checks.py` (read, then run unedited).

### 1.2 Quotation check (standing rule 5)

`tools/fs114_l60_quotes.py` (whitespace collapsed, `*`, `**` and backticks removed on both sides, nothing else): **15 of 15 FOUND, each at the line the
brief cites** (`data/fs114/fs114-l60/quotes.out`, exit 0). **Plant:** the L60 quotation with "below 60°" changed to "at most 60°" is NOT FOUND, its
faithful twin FOUND (`quotes-plant.out`, exit 0). By hand:
- The brief's `DIAM_OVER 10201/10000` is printed at `plans/FS112-N-proof.md` l. 376 as "DIAM_OVER (`10201/10000`)": the parentheses and ticks dropped,
  no word changed. Its gloss "planted a case just past the boundary" is fair in substance: the frozen checks' 60° row takes the radial points at radius
  `1 + 1/100`, which is where the premise fails (§1.3 (v)); their plant is the 50° row.
- The owner's note "at most 60°, equality only when the outer tile lies in the Reuleaux cap" drops "with" and the lens formula from N4 §5.4
  ("at most 60°, with equality only when the outer tile lies in `B̄(A, 1) ∩ B̄(B, 1)` (the Reuleaux cap)"); faithful. (§2.6's own wording has "`ℓ ≤ 60°`".)
- "CV-EXISTS says every valid map has a vertex of at least four colours, at two minds": the CV table row says it at one mind (blind); CVB §2.2 A-1 raises it
  to "**Two minds**, both blind to each other". Faithful to the two records together.
- The five Kooshi quotations of the standing rules: exact (`CLAUDE.md`; `plans/CONSOLIDATION-2026-09-27.md` item 20).

### 1.3 L60 at the boundary, settled

*Frame (exact in `tools/fs114_l60_check.py`): `P = 0`, `A = e(0°)`, `B = e(60°)`, `C = A + B`; `L = B̄(A, 1) ∩ B̄(B, 1)` the lens with corners `P`, `C`;
`K_in = Reul(P, A, B) = L ∩ B̄(P, 1)`; `K_out = Reul(A, B, C) ∖ B̄(P, 1)` (the Reuleaux cap).*

**(i) L60-LE: `ℓ ≤ 60°`.** `ᾱ ⊆ cl T_out`, and `cl T_out` has diameter at most 1 (TS-C: an open connected one-colour set with two points more than 1
apart contains two at distance exactly 1). The diameter of the closed arc `ᾱ` is `2 sin(min(ℓ, 180°)/2)`, at most 1 exactly when `ℓ ≤ 60°`. ∎ Both
printed proofs give this much; N4-L60 states it. *Just past:* the plant `past` (`B` at `e(289/500)`, 60.04°) fires CHORD with `|A − B|² = 334084/333521 > 1`.

**(ii) L60-EQ: the shape at equality — both side tiles are pinned, not only the outer one.** Let `ℓ = 60°`. Both `T_in` and `T_out` hold `A` and `B` in
their closures, so both lie in `L`. `L ∩ ω(P) = ᾱ` (a point `e(φ)` is within 1 of `A` iff `|φ| ≤ 60°`, of `B` iff `φ ∈ [0°, 120°]`), and `ᾱ` is boundary
(its ends are vertices), so each open tile lies in one component of `L ∖ ᾱ`: `T_in ⊆ L ∩ B(P, 1) ⊆ K_in`, `T_out ⊆ L ∖ B̄(P, 1)`. And `L ∖ B(P, 1) ⊆ B̄(C, 1)`:
its three boundary arcs lie in `B̄(C, 1)` (on the arc of `ω(P)`, `|e(φ) − C|² = 4 − 2√3 cos(φ − 30°) ≤ 1` for `φ ∈ [0°, 60°]`, equality only at the ends; the
arcs of `ω(A)` and `ω(B)` are sides of `Reul(A, B, C)`), so `T_out ⊆ K_out`. **At each end:** `K_in`'s corner cone at `A` is `[90°, 210°]` (120°) and
`K_out`'s is `[30°, 90°]` (60°); together they are the closed half-plane `{d : d·(B − A) ≥ 0}`, bounded by the tangent of `ω(B)` at `A`. So the sectors of
`T_in` and `T_out` at `A` leave the open half-plane `{d·(B − A) < 0}` to other tiles: **each end of a 60° arc is a vertex whose further tiles lie,
to first order, outside `B̄(B, 1)` (resp. `B̄(A, 1)`)**. [hand, one mind for the inner clause and the ends; the outer clause two minds: N4, mine]
*Tools (TILE, exact):* 13 named points of `K_out` (the corners, the three arc midpoints, points beside `A`, `B`, three points of the `ω(P)`-arc, the centroid)
lie in `B̄(A, 1) ∩ B̄(B, 1) ∩ B̄(C, 1)` and outside `B(P, 1)`; their largest squared distance is 1, attained only at corner pairs and at a corner against the
opposite arc's midpoint; the `ω(P)`-arc meets `ω(C)` only at `A` and `B`. **At the boundary:** the plant `radial` gives the outer tile N112-L60's premise, the
points `(1 + 1/100)A` and `(1 + 1/100)B`; TILE fires `OUTSIDE_LENS` (`|(1 + 1/100)A − B|² = 10101/10000`).

**(iii) L60-REAL: equality is realised.** Colour `int K_in` by 1, `int K_out` by 3, `B(A, 1/4) ∖ (K_in ∪ K_out)` by 4 and `B(B, 1/4) ∖ (K_in ∪ K_out)` by 5.
Two interior points of a Reuleaux triangle of width 1 are less than 1 apart (constant width: a diameter chord has both ends on the boundary), so classes 1
and 3 are clean; classes 4 and 5 have diameter `≤ 1/2`; the classes' closures cover a neighbourhood of `ᾱ` (the two Reuleaux sets cover a neighbourhood of
each interior arc point, the discs the rest near the ends). *Tools (FRAG, exact):* 24 probes at distance `1/8` from `A` and `B` in the twelve directions `30k°`
each fall in exactly one class, in the sector the corner cones predict (asserted off the three cone-boundary directions), and points at radius `99/100`
and `101/100` across the arc's interior fall in classes 1 and 3. The plant `frag_big` (discs of radius `3/5`) fires `SMALL_DIAM_OVER`. **Other
configurations:** any open connected `T_out ⊆ K_out` bordering all of `α` (for instance the cap minus a neighbourhood of `C`, with another tile there) also
realises equality; what equality forces is the containment (ii), not the whole cap. So "equality only by a Reuleaux cap" is true as "the outer tile lies in
the cap" (N4's words), and the inner tile lies in `Reul(P, A, B)` as well.

**(iv) L60-2: the second clause.** Two readings are in the records.
- **NB's** (NB-L60, `plans/FS112-NB-verification.md` l. 155): "for `w ∈ int α`, no tile of colour `s_in` or `s_out` has `w ± 60°` in its closure". **TRUE for
  every `ℓ`, equality included.** `ω(w + 60°)` crosses `ω(P)` transversally at `w` (the crossing angle of two unit circles with centres 1 apart is 60°), so
  both side tiles have points on both sides of `ω(y)` for every `y` near `w + 60°`; a side-colour tile `Y` with `w + 60° ∈ cl Y` has such `y`, and `ω(y)` meets the
  side tile of `Y`'s colour: two points of one colour at distance 1 (N-E0; `Y` may be that side tile itself). The proof reads only the interior point `w`.
  [hand; two minds: NB, mine] *Tools (SECOND):* at `w = e(11.4°), e(22.6°), e(30°)`, `w + 60°` is more than 1 from `A` and `w − 60°` more than 1 from `B`, so both
  lie outside `K_in ∪ K_out` in the equality fragment. The plant `second_end` (the "interior" point taken at `A`) fires `INTERIOR_NOT_CLEAR` (`|B − A|² = 1`).
- **N's** (N112-L60, l. 220: "For two tiles of one colour beside the arc `60°` apart, N-E1 at the first point is broken by the second (its unit circle
  crosses `ω(P)` transversally there, into the tile)"). For `ℓ < 60°` it is vacuous (no two points of `ᾱ` are 60° apart). **At `ℓ = 60°` it is FALSE:**
  `A`, `B` are 60° apart and each lies in `cl T_in ∩ cl T_out`; `ω(A)` does cross `ω(P)` transversally at `B` (at 60°, exact), but runs along the boundary of
  the lens and enters neither side tile, both of which lie in `B̄(A, 1)`. The derivation file's form "along it neither side colour recurs 60° apart" is
  the ends reading and inherits this. [hand, one mind; SECOND exact]

**(v) L60-PROOFS: where each printed proof of "`< 60°`" breaks.**
- *N's* (`plans/FS112-N-proof.md` ll. 218–221): "`T_out` contains points `(1 + ε)e` beside each end direction". At equality `T_out ⊆ K_out ⊆ B̄(B, 1)`, and
  `|(1 + ε)A − B|² = 1 + ε + ε² > 1` (RADIAL, exact at `ε = 1/100` and `10⁻⁶`). The frozen checks (`tools/fs112_n_arcs.py` L60, `tools/fs112_n2_checks.py`
  L60, re-run unedited: exit 0, `data/fs114/fs114-l60/frozen-*.out`) compute `|(1 + ε)A − (1 + ε)B|² = 10201/10000` — right arithmetic on a pair that the
  equality tile does not contain. The plant `radial_in` (`ε = 0`) fires `RADIAL_NOT_OUTSIDE`.
- *NB's* (`plans/FS112-NB-verification.md` l. 153): "if `α` … had `ℓ ≥ 60°`, two points of `int α` would be `60° − δ` apart, and the points `(1 + t)w` of `T_out`
  beyond them (`t ≫ δ`) would be more than 1 apart". At `ℓ = 60°` the lens holds `(1 + t)e(δ)` only for `t ≤ τ*(δ) = 2cos(60° − δ) − 1`, which is below
  `2√3·tan(δ/2)` — so `t ≫ δ` is unavailable — and the pair at `t = τ*` is exactly `(2cos 2δ − 1)² ≤ 1` apart (NBSTEP, exact identity at five named `δ`).
  For `ℓ > 60°` NB's route is sound (two interior points exactly 60° apart, `t` small). The plant `nb_free` (`t = 20 tan(δ/2)`) fires `NB_POINT_OUTSIDE`.
- So the two minds behind "`< 60°`" broke at the same boundary by different steps, and each tool checked a step's arithmetic, not the step's premise:
  **G21's pattern** — a check of a sufficient condition's arithmetic, read as a check of the claim.

**The exact statement, proposed for `plans/FS112-derivation.md` FS112-L60 (the close writes it):** *"A unit arc with constant sides has angular length at
most 60°. At exactly 60° both side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)` of its ends — the inner one in `Reul(P, A, B)`, the outer one in the Reuleaux
cap `Reul(A, B, A + B − P) ∖ B̄(P, 1)` — and each end is a vertex whose further tiles meet the open half-plane facing away from the other end; equality is
realised. For `w` interior to the arc, no tile of either side colour has `w ± 60°` in its closure; at 60° the two ends are 60° apart and each lies in the
closure of both side tiles."* Grade: [hand; the bound two minds (N4; FS114-L60), the equality shape and the second clause one mind each (FS114-L60),
NB's interior reading two minds (NB; FS114-L60); tools exact at named values].

**Tool.** `tools/fs114_l60_check.py --self-test` → `data/fs114/fs114-l60/check-selftest.out`, exit 0: eight checks green (CHORD, TILE, RADIAL, NBSTEP,
SECOND, FRAG, ENV60, COR3 — the last two are used at stage 2), and eight plants each turn exactly their own check red for their own reason, among them
**`radial` at the boundary** (TILE, `OUTSIDE_LENS`) and **`past` just past it** (CHORD, `CHORD_OVER`).

## Stage 1 — SAVED

## Stage 2 — SAVED: every use of L60 in FS-112 and FS-114, walked

*Grepped (`L60`, `below 60`, `< 60°`, `60°`) in `plans/FS112-N-proof.md`, `plans/FS112-NB*-verification.md`, `plans/FS112-derivation.md`,
`plans/FS114-N-proof.md`, `plans/FS114-N3-proof.md`, `plans/FS114-N4-proof.md`, `plans/FS114-CV-verification.md`, `plans/FS114-CVB-verification.md`,
`plans/FS114-NB-verification.md`; and, for other homes of the statement, `LEDGER.md`, `plans/STUB-*.md`, the other FS-112 records and `data/fs112/fs112-c/`.
Each `60°` hit was read in context; those that are the ring's 60° rule (N-E0 on a unit circle), FS112-A4SIX's `≥ 60°` or FS112-SIX's half-circle are listed
once, as not being uses. "Needs strict?" asks whether the step's proof uses `ℓ < 60°`; "equality" says what the 60° arc does to the step.*

### 2.1 The chain the brief names first

| # | step (address) | where "60°" enters | needs strict? | the equality case (a 60° arc with constant sides) | verdict |
|---|---|---|---|---|---|
| 1 | **FS112-N2-RED** with its lemmas N2-SIGN, N2-ENV, N2-TOWARD, N2-AWAY, N2-TAN (`plans/FS112-N-proof.md` stage N2-3; NB2 §1.4) | the frame, l. 392: "angular length `ℓ < 60°` (N112-L60)"; N2-ENV, l. 403: "`sin(Δ/2) ≥ Δ/π` since `Δ < 60°`" | **no.** SIGN, TOWARD, AWAY, TAN and RED's split and termination never read `ℓ`. ENV's `sin(x/2) ≥ x/π` holds on `[0, π]`; its coefficient `4cos η cos(η + Δ) − 2` is `≥ 0` at `η = 0` for `Δ ≤ 60°`, and where it vanishes (`Δ = 60°`) the first term is 2. ENV's near-tile margin on `∂I`, `I = B̄(A, 1) ∩ B̄(B, 1)`, is `≈ Δ sin ℓ − s cos ℓ` at the far corner, positive at `ℓ = 60°` | the toward lens stays in `T_in ⊆ Reul(P, A, B)`; `T_out ∪` lens lies in `I`, whose points are within `< 1` of every lens point (ENV60, exact at four named lens points against the far corner `C`); the away lens symmetrically. The arc bends like any other; (Q)/(R2) uses U1's side cones, positive for `ℓ > 0` | **INTACT**; the frame's citation should read `ℓ ≤ 60°` |
| 2 | **FS112-N3-COR3** (N3 stage N3-3; NB3-COR3) | none in either proof; NB3's tool ran arcs of 5°, 20°, 50° only | **no.** N3's route is N-E1 at `u`, N3-NOBOTH and N3-FAIL, none reading `ℓ`; NB3's route needs `u`'s arc to have one side cone on each side of `ω(u)` at `w`, true for `0 < ℓ < 180°` | a 60° arc of `ω(w)` leaving `u` ends at `σ_u^{±1}(w)` (the equilateral triangle `u, w, E`), a point no step of COR3 reads. NB3's cone model re-run at arcs 55°, 59°, 60° (the frozen functions, imported unedited): 504 strip-holds cases each with an empty probe, 361 both-fail cases each forcing four colours (COR3 exact; NB3's plant `cor3_nou1` fires) | **INTACT**. The derivation file's "*Rests on it:* FS112-N2-RED, FS112-N3-COR3" is nominal |
| 3 | **FS112-N3-BASE** (N3 stage N3-3's table; NB3 steps 1–12) | NB3 step 9, l. 173: "it meets `ω(u)` only at `x` and `x ± 120°`, outside the `< 60°` arc" | **not L60's**: that arc is CB D5 item 1's arc of `Ω` cut off by a circle-to-circle path, "`< 60°`" because the path's ends are `< 1` apart ("the `a`-tile along it has diameter `≤ 1`; `= 1` is (P′)", `plans/FS110-CB-verification.md` D5 item 1). Under N3-BASE's hypothesis H that step holds: L60-D5 (§2.3) | every other row's exception lives at a both-centre (N3-NOBOTH, `ℓ > 0`), at COR3's corners (row 2) or at an inert arc bent first (N2-TOWARD, row 1) | **INTACT** |
| 4 | **FS112-N3-DENSE3** | none | no (over N3-BASE and FS112-DISC1) | — | **INTACT** |
| 5 | **FS114-CV-EXISTS** and **FS114-CVB-EXISTS** | CVB-L0, l. 131: "(`0 < ℓ < 60°`, FS112-L60)"; A-4, l. 287: "with L60 for `ℓ < 60°`" | **no.** CV-L0 / CVB-L0 use only "a closed cone of width `π − ℓ < π`" (`ℓ > 0`); CV-FLANK, CV-P, CV-L4 read no `ℓ`; N2-TERM rests on rows 1 and 2's inputs and on FS112-NB4P, whose exception is stated for closures (a 60° arc of `ω(v)` holding two orbit points at its ends is inside it), and FS112-A4SIX (a single 60° arc meets its `≥ 60°`); N4-FIN is about sequences | at a stuck vertex no unit arc is centred (CV-L0), whatever its length | **INTACT** |

### 2.2 Everything else, by record

| # | where | the use (quoted or named) | needs strict? | verdict |
|---|---|---|---|---|
| 6 | `plans/FS112-N-proof.md` l. 21, ll. 218–221 | N112-L60's row and proof | the statement itself | corrected at stage 1; its proof breaks at the radial point (RADIAL) |
| 7 | same, l. 284, **N112-P2** | "(four arcs, each `< 60°`)" | an application of the strict form to the strip | the strip's four arcs span `[60°, arccos(1/4)]` and mirrors, `15.52°` each (`plans/FS112-Y-construction.md` l. 75): the parenthetical holds on the object, and the prediction's score (vacuous in the union sense, met in the disjoint sense: `plans/POROS-2026-09-27-fs112-competition.md` l. 522) is unchanged. **INTACT** |
| 8 | same, l. 297 | "N112-L60, LOCK, BEND, RED spend nothing" | — | unchanged: the corrected L60 spends no colour either |
| 9 | same, l. 359, l. 647 | N2's and N3's inheritance lists: L60 at two minds | — | grade: the strict form's two minds both broke at the boundary (L60-PROOFS); the corrected form stands at the grades of §1.3 |
| 10 | same, l. 366, l. 376; `tools/fs112_n_arcs.py`, `tools/fs112_n2_checks.py` | "at `ℓ = 60°` the outer tile's end points are `1 + ε` apart (TS-C broken)", DIAM_OVER (`10201/10000`) | — | **tool defect of G21's kind**: the check computes the distance of a pair the equality tile does not contain, and never asks whether the tile contains it. Re-run unedited: exit 0. Superseded by `tools/fs114_l60_check.py` (a plant at and one just past the boundary) |
| 11 | same, ll. 78, 93, 108, 150, 195, 494, 776, 785, 802, 819 | the ring's 60° rule, HP60, SIX's `≥ 180°`, A4SIX's `≥ 60°`, D5's `w = x ± 60°` | — | not uses of L60 |
| 12 | same, N3-END item 3 (l. 863) | "`α`'s side cone `(−ℓ, 0)` at `P_{−1}`" | `ℓ > 0` only | **INTACT** |
| 13 | `plans/FS112-NB-verification.md` l. 15, ll. 153–157, **NB-L60** | first clause "`t ≫ δ`"; second clause "for `w ∈ int α` …" | — | first clause's proof breaks at 60° (NBSTEP); second clause TRUE at every `ℓ` (L60-2) |
| 14 | same, l. 199, C-UA-BUDGET branch 1 | "arcs `< 60°` leave `x` with the six points `x + 60°k` tile points" | reads A4SIX's branch hypothesis (total `< 60°`), not L60 | a 60° arc meets the branch's conclusion (`≥ 60°`) outright. **INTACT** |
| 15 | same, l. 204, **C-UA-CHAIN** | "(and `α` alone, `< 60°` by NB-L60, covers at most one point of an orbit)" | **yes** | **FALSE at equality, both halves**: a 60° arc alone meets A4SIX's `≥ 60°`, so on that branch a (Q) centre with one 60° arc is forced to carry no further arc by this route; and its closure holds two points of an orbit when an end is an orbit point. The aside sits inside a GAP verdict; nothing in FS-112's or FS-114's chain rests on C-UA-CHAIN (route B was chosen over it, N2 §5.1; FS112-STRIP-CHAIN concerns its killing test). Correction owed to the aside only |
| 16 | same, l. 261, divergence row 9 | "scope; both TRUE" (the two readings of the second clause) | — | N's ends reading is FALSE at exactly 60° (L60-2); NB's TRUE. Correction owed to the row's verdict |
| 17 | same, l. 267, divergence row 15 | "no plant targets L60 (its 50° twin is built in)" | — | answered then by N2's `l60_fifty` (a 50° plant, below the boundary); plants at and past the boundary now exist |
| 18 | same, ll. 127, 134, 142 | the ring's 60° rule, HP60 | — | not uses of L60 |
| 19 | `plans/FS112-NB2-verification.md` ll. 105, 113, 231, 235, 285 | "away cone of width `π − ℓ`", "side cone `(−ℓ, 0)`", ENV's "`\|θ\|` up to `φ` or `ℓ − φ`", TOWARD's half-planes through `τ_A` | `ℓ > 0` only | **INTACT** |
| 20 | `plans/FS112-NB3-verification.md` l. 89, **NB3-NOBOTH** | "Let `α ⊂ ω(P)` have length `ℓ ∈ (0°, 60°)`" | uses only "each `S_i` has positive angle" | **INTACT**; the frame should read `(0°, 60°]` |
| 21 | same, l. 173 (step 9) | "outside the `< 60°` arc" | CB D5 item 1's, not L60's | row 3; L60-D5 |
| 22 | `plans/FS112-derivation.md` ll. 66–68 | FS112-L60's entry | — | correction proposed (§1.3 and §3) |
| 23 | same, l. 61 | FS112-A4SIX "at least 60°" | — | not a use |
| 24 | `plans/FS114-N-proof.md` ll. 34, 337–341, **N2-CROWN** | "a chord `≤ 1` means `g_i ≤ 60°` or `g_i ≥ 300°`"; "equality only with consecutive ends 60° apart" | TS-C, with `≤` | not a use of L60; it treats the same boundary correctly, with its own equality clause (the regular hexagon of unit triangles) |
| 25 | same, ll. 202, 373–376 | A4SIX's lower bound; a square configuration's angles | — | not uses |
| 26 | `plans/FS114-N3-proof.md` **N3-SEC** (iii), l. 114 | "`γ ≤ 60°`" (the lens's two centres both in its closure) | TS-C, with `≤` | not a use |
| 27 | same, **N3-DR** (ii), ll. 148–155 | "`T_top ⊂ B̄(a, 1) ∩ B̄(b, 1)` outside `B(p, 1)`. So **the cap arc is tactic** (inner `R1`, centre `p`, partner `R3`)" | — | **the equality case, derived positively**: a 60° arc of `ω(p)` with `R1 = Reul(p, a, b)` inside and `T_top` over it; L60-EQ's outer containment is N3's line, its inner one is `R1` itself. The strict L60 would have forced a middle tile on the cap; N3 did not use it, and N4 §4.2 leaves "whether it borders the whole cap" open, as the corrected statement allows. Consistent |
| 28 | same, N3-ODD, N3-DR0, (iii) | 60° windows of the ring, `s′ ∈ {0°, −60°}` | — | the ring's 60° rule; not uses |
| 29 | `plans/FS114-N4-proof.md` §2.6, §5.4, **N4-L60** | "Corrected: `ℓ ≤ 60°`, with equality only when the outer tile lies in `B̄(A, 1) ∩ B̄(B, 1)`, i.e. in the Reuleaux cap" | — | **TRUE** as a claim (the bound, and the outer tile's containment, necessary; its realisation exact). Sharpened here: the inner tile is pinned too, the ends are vertices with a third tile in the far half-plane, the second clause splits by reading, and NB's proof breaks too (N4 said "For `ℓ > 60°` the statement holds (NB's route …)", which is right; NB's printed route also claimed `= 60°`) |
| 30 | same, ll. 113, 162–168, 177–178, 259–267, 317–322 | N114-FAR, N4-ARC's 60° arcs of `ω(q1)`, N4-A4NB's orbit point, setting G | — | the ring's 60° rule and bowtie geometry; not uses. N4-D item 4's 60° arc of `ω(q1)` from `P90` to `top`, outer side `W` along it: were its inner side constant, L60-EQ would give `W ⊆ B̄(P90, 1) ∩ B̄(top, 1)` — the same containment N4-D derives on its way (`P90 ∈ cl W`); nothing strict is used |
| 31 | `plans/FS114-CV-verification.md`, `plans/FS114-NB-verification.md` | — | — | no use |
| 32 | `plans/FS114-CVB-verification.md` ll. 131, 287 | "(`0 < ℓ < 60°`, FS112-L60)", "with L60 for `ℓ < 60°`" | `ℓ > 0` only | row 5: **INTACT** |

**Other homes of the statement** (not uses; corrections owed, §3): `LEDGER.md` l. 1144 ("a unit arc with constant sides is shorter than 60°");
`plans/STUB-global-step.md` l. 47 ("A unit arc is shorter than 60° (FS112-L60)." — which also drops "with constant sides": FS112-SIX puts a whole unit circle
in `Γ`); `data/fs112/fs112-c/ledger-b-draft.md` l. 6 and `reconciliation.md` l. 52 (FS-112's close records; historical). FS-112's advisor ruled NB's
forms "the precise ones" for L60's second clause (`plans/POROS-2026-09-27-fs112-competition.md` l. 338), which §1.3 (iv) confirms. `data/fs114/claims.md`
was not opened (not named in the brief); if it restates L60, the same correction applies.

### 2.3 L60-D5 — CB D5 item 1's "`= 1` is (P′)" under unit arcs [hand, one mind]

*Setting: N3-BASE's, a cubic trichromatic `u`, `c(u) = M`, `Ω = ω(u)`, hypothesis H (no vertex of `B̄(u, 2)` has four or more colours or a repeated colour). A
circle-to-circle path (CB D5 item 1) is an `{a, b}`-boundary path inside the open disc joining `p₁, p₂ ∈ Ω`, `a, b ∉ M`, one `a`-tile along it.*
**Claim:** `|p₁ − p₂| < 1`. *Proof.* The `a`-tile's closure holds `p₁, p₂`, so `|p₁ − p₂| ≤ 1` (TS-C). Suppose `= 1`. Both ends carry `a` and `b`.
- *An end, say `p₁`, is an edge point* (`c(p₁) = {a, b}`): `p₂` carries `a, b` at distance 1, so the edge through `p₁` is an arc of `ω(p₂)` (N3-PAIR), a unit arc
  with sides `a | b ⊆ c(p₂)`, both-kind at `p₂`; by N3-NOBOTH `p₂` has four colours or a repeat, against H (`p₂ ∈ Ω`).
- *Both ends are vertices*, cubic trichromatic under H: `c(p₁) = {a, b, x}`, `c(p₂) = {a, b, y}`. N-E1 at `p₂` keeps `ω(p₂)` out of `p₁`'s `a`- and `b`-tiles; if
  they lay on opposite sides of `ω(p₂)` near `p₁`, the path between them would run along `ω(p₂)` — both-kind at `p₂`, against H. So both lie in `B̄(p₂, 1)` near `p₁`,
  and `x`'s sector holds the open half-plane `{d·(p₂ − p₁) < 0}`. `u, p₁, p₂` is an equilateral triangle, so that half-plane is centred 60° from `Ω`'s outward normal
  at `p₁` and holds directions on both sides of `Ω`'s tangent: the `x`-tile meets `Ω`, so `x ∉ M` (N-E1 at `u`), and `x ≠ a, b`. So `x` is the third colour of
  the complement of `M`; likewise `y`: `c(p₁) = c(p₂)`, one multicolour at distance 1, against N3-P′. ∎
CB's "`= 1` is (P′)" reaches this conclusion without the step that the third colours coincide; the step is N-E1 at `u`. *Where six is spent:* "the third colour of
the complement of `M`" (a 3-set). *Seven colours:* the complement has four colours and the step fails, as it must.

## Stage 2 — SAVED

## Stage 3 — SAVED: the verdict; proposals for the close

### 3.1 The verdict

**FS112-N3-DENSE3 and FS114-CV-EXISTS are intact.** No step on the path N3-COR3 → N3-BASE → N3-DENSE3 → CV-EXISTS (with FS112-N2-RED and N2-TERM under it) uses
the strict bound; every citation of "`< 60°`" there uses `0 < ℓ ≤ 60°` or only `0 < ℓ < 180°`, and the equality case passes each step (§2.1). **No
configuration escapes**; the owner was therefore not messaged before this stage. The equality case is not new ground for FS-114: it is the Reuleaux bowtie's
cap (N3-DR (ii); N4 §4.2), where the stated L60 would have forced a middle tile that the corrected statement does not. [hand, one mind; tools exact at named
values: ENV60, COR3 at 55–60°, and stage 1's checks]

**What is false, and where nothing rests on it:** FS112-L60 as stated (at exactly 60°; N4, confirmed); its second clause in N's ends reading (at exactly 60°);
NB's C-UA-CHAIN aside "(and `α` alone, `< 60°` by NB-L60, covers at most one point of an orbit)" (at exactly 60°, both halves); the two printed proofs of
"`< 60°`" (at exactly 60°, by different steps).

### 3.2 Selection audit (G21)

The result closes the door the owner hoped closed, so it was pushed against at the rate of one that opens it:
1. **Implicit uses.** Searched the named records for the strict bound under other names — "at most one point of an orbit", "ends … less than 1 apart",
   "chord" (`grep`, §2): found NB's aside (row 15, false at equality, no dependant) and CB D5 item 1's `< 60°` arc (row 3, not L60's; completed as L60-D5).
2. **The equality case's own new features, each against the steps that could read it:** a 60° arc of `ω(w)` leaving a cubic `u` ends on `ω(u)` at
   `σ_u^{±1}(w)` (COR3, FAIL: no step reads that point); both side tiles hold both ends, 1 apart (N3-P′ at the ends: the pair cannot have one multicolour —
   consistent with N3-P′, checked by hand); the lens's far corner `C` (N2-ENV's near-tile clause: exact at four named lens points, ENV60).
3. **The one check whose range excluded equality** — NB3's COR3 cone model (arcs 5°–50°) — re-run at 55°, 59°, 60°, green.
4. **Not done:** a blind second mind on the walk; N2-ENV's formula checked at 60° only at named points against `C`, not over all of `∂I`.

### 3.3 Registered (G21 instruments, for the close to score)

| id | prediction | p | both outcomes reachable |
|---|---|---|---|
| L60-P1 | a blind second mind given the corrected FS112-L60 and the chain (N2-RED, COR3, BASE, DENSE3, CV-EXISTS) finds no step that needs `ℓ < 60°` | 0.85 | a step using the strict bound under another name, or the equality case breaking a step, refutes it |
| L60-P2 | a blind second mind confirms L60-EQ's inner clause (`T_in ⊆ Reul(P, A, B)` at 60°) and L60-2's split | 0.9 | a 60° arc whose inner tile leaves `Reul(P, A, B)`, or a side-colour tile at `w ± 60°` for interior `w` |

### 3.4 Proposed for the close (I edit none of these files)

- **`plans/FS112-derivation.md` FS112-L60** (l. 66–68), replace the statement by §1.3's proposed text; *Proof verdict:* "FALSE at exactly 60° as first stated
  (FS114-N4-L60); both printed proofs break there by different steps (FS114-L60 L60-PROOFS); TRUE as corrected"; *Rests on it:* "nothing needs the strict bound —
  FS112-N2-BENDS, FS112-N2-RED, FS112-N3-NOBOTH, FS112-N3-COR3 and FS114-CV-L0 cite it and use only `0 < ℓ ≤ 60°` (FS114-L60 §2)"; the second clause in NB's reading.
- **`LEDGER.md` l. 1144** (FS112-L60's § B row): "a unit arc with constant sides is shorter than 60°" → "a unit arc with constant sides spans at most 60°; at 60°
  both side tiles lie in the lens of its ends (FS114-N4, FS114-L60)".
- **`plans/STUB-global-step.md` l. 47:** "A unit arc is shorter than 60° (FS112-L60)." → "A unit arc with constant sides spans at most 60°, and at exactly 60°
  its side tiles lie in the Reuleaux triangle and the Reuleaux cap on its ends (FS112-L60, corrected)."
- **FS-114's derivation file:** L60-LE (with FS114-N4-L60, two minds), L60-EQ, L60-REAL, L60-2, L60-PROOFS, L60-WALK, L60-D5, as filed in this record's table.
- **FS-112's derivation file, notes:** NB's C-UA-CHAIN aside is false at exactly 60° (no dependant); NB divergence row 9's "both TRUE" holds for NB's reading only;
  the frames "`ℓ ∈ (0°, 60°)`" (NB3-NOBOTH) and "`0 < ℓ < 60°`" (CVB-L0) read `(0°, 60°]`.
- **`plans/GROKKING-INSTANCES.md` §G21**, one instance: two minds' proofs of "`< 60°`" broke at the same boundary by different steps, and each tool checked a step's
  arithmetic (a pair at `10201/10000`; a crossing slope) and never the premise that put the pair in the tile; the only plant sat at 50°, below the boundary it
  was to test. *Its lesson in one line:* a claim with a boundary gets a plant **at** the boundary, not only one on each side of it.

## Stage 3 — SAVED
