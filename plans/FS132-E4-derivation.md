# FS132-E4 — the ring card: two triangle centres, the ring's change points, and the turning ring

*Job FS132-E4 (Ephodos, a derivation job in the opened milestone FS-132, second round). Brief:
`data/fs132/briefs/FS132-E4-ring-card.md`. Record of one mind; nothing here is blind; the kernel is the second check. Every
script and its output: `data/fs132/e4/`. Entries are in the identity's grammar and are read by
`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS132-E4-derivation.md`.*

## Theorems this phase proved

*(One line per theorem, with its grade and address; filled at each saved stage.)*

- Stage 1: none (readback, predictions, recognition, statements).

## Stage 1 — SAVED: the readback, what I expect, recognition, and the claims stated

### 1.1 Readback

`data/fs132/e4/readback.py` checks each quotation of the brief as an exact substring of its source: **19 quotations, 19
matched, 0 mismatched** (exit 0). No finding about the brief's quotations.

Read whole, in this order: the brief; `plans/STANDING-RULES.md`; `data/fs132/claims.md` with every dated line; the stub's
section "The question, re-posed after the first night" (the cards, both forms, the six posed claims, the outcome table, the
registered expectations); `plans/POROS-2026-10-07-fs132-night.md` Stages 1 and 2; `plans/FS132-E2-derivation.md` Stage 2's
recognition and claims and Stage 3's entries, the arguments for the winding, the orbit index and the strips, "Where the
forcing statement stalls", "The stalled step, as a statement of its own" and the YES side's sketch;
`plans/FS132-E3-derivation.md` Stage 3 (entries; M0–M9 whole) and Stage 4's two-diagonal argument and the coordinator's
paragraph; `plans/FS132-E1-derivation.md` Stage 3 (entries, confinement, the list E0–E5, the relation, the two controls at
seven, card 2); the plan's §G, §PA and §IQ (`plans/FS132-six-by-the-nerve.md`); `plans/FS107-derivation.md` for FS107-R-CP,
FS107-W-TAN and the erratum on HX; `plans/FS107-W-near-colourings.md` § 2.5; `plans/FS110-derivation.md` for NB-5, N-SEAM,
N-X and FRAGS; `tools/fs110_y_fragments.py`'s header (the four seam fragments); `LEDGER.md` rows 133, 134, 139;
`plans/FS132-close-inventory.md` item 7. **The manuscript**, under
`/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`:
`palettes.tex` ll. 1–330 (Definition 5.1, Lemma 5.2 with its proof, Remark, Corollary 5.4, the opening of the binary
centres) and `angular.tex` ll. 1–136 and 328–617 (Lemma 8.1 with its proof, the five-cycle, the triangle: binary rigidity,
the one orbit, the three-label region, the placement). Not read: `angular.tex` ll. 137–327 (the four-cycle),
`interfaces.tex`, `transitions.tex` (so Definition 6.1 is used here only through C132-EXT-DISC's statement), the
inventory's items 3, 6 and 9 beyond the claim list's dated lines for them.

**The two cautions of the brief, carried.** (1) Clause (5) of C132-EXT-DISC (each edge of the returned cycle is an edge of
the centre's own transition graph; one mind, against a sentence of the manuscript): **no step of this record uses it.**
(2) Nothing supplies, for an arbitrary six-colouring, the hypothesis under which the extraction returns its data at a
centre: **every statement below says what is assumed at the point it is about** — a point with three labels and one
compact set per pair of them carrying the two-label exclusion — and none says such a point exists.

### 1.2 What I expect (registered before the recognition was written and before any entry; not blind)

*Registered after the reading above. The reading is not neutral: the asking lane's two-line composition for C132-COMP was
checked in my head while I read row 133 and FS-110's fragments, and the alternating ring was worked on scratch paper
against M7–M9. So these are calibration instruments, not blind forecasts; each names the decision it steers.*

- **P1 — C132-COMP: derived, in a form sharper than posed, 0.93** (the proviso weakened to "no interface set of either
  centre lies on the unit circle about the crossing point", and properness not consumed by the composition). Refuted by a
  held fragment: 0.02. *Decides:* whether Stage 2 is one stage and whether later claims may end in it.
- **P2 — C132-PLACE: the list derived for germs that are constant or steps, and only the transfer formula for germs that
  are merely measurable, 0.85.** A colouring by formula realizing an open line, built here: 0.05. *Decides:* whether
  C132-TURN is attempted in the measurable class or on the two test rings.
- **P3 — C132-TURN: stalls, 0.80** (at a witness at the ring point); its alternating half derived on the way: 0.80; the
  whole derived: 0.05; refuted by a colouring by formula: 0.03. *Decides:* which card takes the next slot.

### 1.3 Recognition (`ephodos-recognition`, invoked fresh)

**The stall, read.** Two of its shapes. *A known theorem that almost applies*: row 133's W-TAN (complementary vertices
closer than 2 are tangent pairs or bowties) and C132-M-ORBIT's mechanism (a forced label near two ring points 60° apart)
each almost apply at a triangle centre. *A wall that describes a counterexample*: C132-RING-TAME's second clause, posed as
a hypothesis ("no two changes π/3 apart").

**For the stranger, three times.**
- *A combinatorial geometer who works on map colourings.* Two points `x`, `y` less than 2 apart; near a common unit point
  `w` each forbids three of six colours on one side of its own unit circle, and the two triples are complementary.
  *This is Voronov's contradiction* (in this project's records `[Voronov2023]` Prop. 2.2's tangent form, FS106-TAN; row
  133), and in the exact class it is a covering count: two unit circles about centres less than 2 apart cross
  transversally, so each of the four quadrants at `w` is a non-empty open set, and a quadrant on which six colours are
  forbidden cannot be coloured. Nothing about distances between coloured points enters. The field's own exceptions are in
  this project's files by formula: fragment T2 of FS110-FRAGS escapes with "u on a full arc of ω(w)" — an interface that
  is an arc of the unit circle about the crossing point — and is rejected when the arc is replaced by its chord (its
  planted fault `t2_flat`).
- *Someone who works on colourings as graph homomorphisms.* A measurable map `s` from the circle to the non-empty proper
  subsets of a three-element set `N`, with `s(θ) ∩ s(θ + π/3) = ∅`; and a colouring of a neighbourhood of the circle such
  that a point with ring neighbours `θ₁`, `θ₂` (the two ring points at distance 1 from it, about 120° apart) avoids
  `s(θ₁) ∪ s(θ₂)` and, on one side of the circle, uses `N` only. *This is the ring calculus of a vertex of a six-coloured
  map* (this project's G91: the unit circle about a vertex is a twisted colouring of its 60° hexagons, and its change
  points place vertices), which FS132-E3's M0–M2 restated in measure at a four-cycle centre. At a triangle centre the
  outside labels are three, so a point whose two ring neighbours carry different single labels is forced to the third:
  a triangle's vertex opposite an edge.
- *An analyst.* A two-valued measurable `s` on an interval, and for almost every `(α, p, r)` not both `s` differs across
  a gap `p` at `α` and across a gap `r` at `α ± ε(p, r)`, `ε` positive and of second order. *This is a density-point
  argument* (Lebesgue), of which FS132-E3's Lemma S is one instance.

**The sentences.** *C132-COMP is a covering count at a transversal crossing of two unit circles; C132-PLACE is the
third-label rule of a three-coloured ring, read on the side the strips make pure; "two changes π/3 apart" is two objects —
an orbit on which the forced third label is the same at adjacent ring points (alternating), where C132-M-ORBIT's
mechanism applies with the third outside label as its tip, and an orbit on which it differs (turning), where the centre's
own data are consistent and a kill must read the ring point as a point with data of its own.*

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| the limiting directions `v_j`; "perpendicular to none" | **splits** | consumed only as "some point of `K_j` is strictly inside, or strictly outside, the unit circle about the ring point" (the identity `\|x + rf − q\|² = r² + s² − 2rs f·w` at a fixed `s`); the direction accompanies. Without the consequence the statement fails: T2's unit arcs about the crossing point (control `t2-seam`, Stage 2) |
| which side of a centre's unit circle is pure | **accompanies** C132-COMP | all four quadrants at a transversal crossing are non-empty (control `crossing`, Stage 2) |
| weak properness | **accompanies** C132-COMP; **determines** PLACE and the ring | the covering count runs on the exclusions alone; the transfer (Lemma 5.2) is properness |
| six labels | **determines** | consumed as: two disjoint triples exhaust the labels (COMP); three labels outside a triangle (the third-label rule). At seven the outside sets of two triangles always share a label (control `hex7-crossings`, Stage 2) |
| `\|x − y\| < 2` | **determines** | consumed as transversality; at 2 the circles are tangent and one quadrant is empty (control `crossing`, its fault) |
| connectedness of the sets `K_j` | **accompanies** | no step reads it; it sharpens one corollary (a connected set lies on one unit circle through `x` at most, off two points) |
| the ring's state being a step near the orbit | **unsorted** for the turning orbit | the alternating orbit does not need it (Stage 3's shift lemma); the turning statement derived is for steps |
| the label the strips allow on the impure side | **determines the stall** | the transfer leaves it free there, and it is what stands between "three labels meet at the ring point" and a cycle at it |

**The homes.**
1. *This project's seam calculus* (FS-107's W-TAN and R-CP, FS-110's N-SEAM, NB-5 and FRAGS; rows 133–134). Name there:
   a close covering pair. Its theorem: tangent pair or bowtie; none under Condition 5. *Tests:* the old proof applies at
   once (it is the covering count); the exceptions do not vanish, they sharpen to one — an interface set on the unit
   circle about the crossing point (a bowtie has no third edge and is outside the hypothesis; a tangent straight edge is
   blocked); it predicts a neighbour — T2's fault is rejected, and NB-5 follows with no map. **Adopted for C132-COMP.**
2. *The release's strips and palette transfer* (`[OAIMath2026]` Lemma 8.1, Lemma 5.2, Corollary 5.4; read). Supplies
   every input. **Adopted as the toolkit**, at six labels, each taken at its proof (no count in the three proofs read).
3. *The ring calculus in measure* (G91; FS132-E3's M0–M9). **Adopted for C132-PLACE and for the alternating orbit**, with
   one changed step named: M2's last line, "a label that is neither `X` nor `Y` is one of four", becomes "on the pure
   side, a label of `N` that is neither of two different labels of `N` is the third" — so the tip needs no confinement
   and no count of axes (M4–M6 drop out), and the side must be pure (which they did not need).
4. *Heights* (G71; C132-INDEX, C132-ORBIT). Kept to say what a turning orbit is (orbit index 2 or 4). Supplies no kill.

**A recognition that differs from the card's, in two places (a finding for the coordinator).** (a) For C132-COMP the
card says "the proviso … and which side is pure at each centre are where to look": the side accompanies, and the proviso
is an instance of the determiner "no interface set on the unit circle about the crossing point". (b) The card treats
"two changes π/3 apart" as one object and expects one answer; FS132-E3's paragraph says the M7–M8 mechanism has "no form
… for the three-label ring as posed". Both are right of the turning orbit and neither of the alternating one, which has
the form. No `ephodos-invention` stage: no home was killed on a premise the others share.

### 1.4 The claims, as the verdicts will be about them (sent to the coordinator)

*Terms, used in every statement below.* `U` an open set of the plane and `c` a measurable map from `U` to a finite set of
labels; `c` is a **weak colouring** of `U` if `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit
vector `u` with `z + u` in `U` (`[OAIMath2026]` Definition 1.2 read on an open set, as C132-M-ORBIT's statement has it,
`plans/FS132-E3-derivation.md` Stage 3). `H_i` is the closed essential support of the class of `i`; `Δ(K)` is the set of
`z` with `min_{q ∈ K} |z − q| < 1 < max_{q ∈ K} |z − q|` (C132-EXT-DISC's statement, `plans/FS132-E1-derivation.md`
Stage 3). `P_x(e)` is the palette (`[OAIMath2026]` Definition 5.1, `palettes.tex:47–68`, read at the centre `x` with
samplings inside `U`); `e(θ)` the unit vector at angle `θ`; `R` the rotation by `π/3`.
A **witnessed edge** `{i, j}` at a point `x` is a compact set `K` containing `x` and another point with
`H_i ∩ Δ(K) = H_j ∩ Δ(K) = ∅`. A **witnessed triangle** at `x` on three labels `T` is one witnessed edge for each of the
three pairs of labels of `T`, with sets `K_0, K_1, K_2` (clauses (1) and (3) of C132-EXT-DISC with `ℓ = 3` give one; the
asking lane's "witnessed cycle", `plans/POROS-2026-10-07-fs132-night.md` § 2.1). For a point `w` with `|w − x| = 1`, an
edge with set `K` is **outer-blocked at `w`** if some `q ∈ K` has `|w − q| < 1` and **inner-blocked at `w`** if some
`q ∈ K` has `|w − q| > 1`; `x` has a **pure outer side at `w`** if at least two of its three edges are outer-blocked at
`w`, a **pure inner side** if at least two are inner-blocked. (If `e = w − x` is perpendicular to no limiting direction
`v_j` of C132-TRI-STRIP then every edge is blocked on the side of the sign of `e·v_j`, so `x` has a pure side at `w`:
Stage 2, step B1.) `N` is the set of labels outside `T`, and `s(θ) = P_x(e(θ)) ∩ N` the **outside state**.

- **C132-COMP**, the stub's statement, verbatim (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes).
  Verdict expected on it as posed, through two wider statements:
  - **C132-CROSS** (the covering count; no properness): for a measurable labelling of an open set containing a common unit
    point `w` of two points less than 2 apart, the labels that the blocked sets of the two points exclude on any one of
    the four quadrants at `w` are not all the labels.
  - **C132-COMP-SHARP**: with six labels and witnessed triangles on disjoint triples at `x` and `y`, `0 < |x − y| < 2`,
    for every common unit point `w` in the open set one of the six sets lies on the unit circle about `w`.
- **C132-PLACE**, as one statement and a list under it: with a witnessed triangle at `x` and a pure side at the ring
  point `x + e(ψ)`, almost every point `x + e(α) + e(α − 2π/3 − d)` near it on that side has its label in `N` and in
  neither `s(α)` nor `s(α − 2π/3 − d)`. The list (Stage 3): the patterns of the germs of `s` at `ψ ± π/3`, the two
  six-sector rings, each line derived or marked open. Beside it, a relay-result **C132-WITNESS**: a connected open set
  that is almost everywhere of one label witnesses that label on every compact subset of its closure.
- **C132-TURN**, the stub's statement, verbatim. Expected verdict: a stall, with two entries on the way —
  **C132-ALT** (no orbit of ring points on which the outside state alternates essentially between two labels of `N` has
  two adjacent points at which `x` has a pure side) and **C132-TURN-EDGE** (at a step `a | b` of the outside state with
  the third label `c` on the near sides of `ψ ± 2π/3` and pure outer sides at `ψ ± π/3`, the ring point `x + e(ψ)`
  carries no witnessed edge `{a, b}`).

Each entry carries its statement in full in the stage that derives it; the coordinator fixes the list from those.

*The gate at this stage*: `derive_gate.py all` reports one failure, "no derivation entry" — nothing is entered
yet; it is green from Stage 2 on.

## Stage 1 — SAVED
