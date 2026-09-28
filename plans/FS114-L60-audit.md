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
