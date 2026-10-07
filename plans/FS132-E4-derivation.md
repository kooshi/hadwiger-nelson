# FS132-E4 — the ring card: two triangle centres, the ring's change points, and the turning ring

*Job FS132-E4 (Ephodos, a derivation job in the opened milestone FS-132, second round). Brief:
`data/fs132/briefs/FS132-E4-ring-card.md`. Record of one mind; nothing here is blind; the kernel is the second check. Every
script and its output: `data/fs132/e4/`. Entries are in the identity's grammar and are read by
`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS132-E4-derivation.md`.*

## Theorems this phase proved

*(One line per theorem, with its grade and address; filled at each saved stage.)*

- Stage 1: none (readback, predictions, recognition, statements).
- Stage 2: **C132-CROSS** [hand, one mind] — the covering count at a transversal crossing of two unit circles; **C132-COMP-SHARP**
  [derived from C132-CROSS, one mind] — complementary witnessed triangles less than 2 apart need an edge set on the unit
  circle about each common unit point in the open set; **C132-COMP** [derived, one mind] — the stub's statement, as posed;
  **C132-WITNESS** [hand, one mind] — a connected open region of one label witnesses that label. All in § Stage 2.
- Stage 3: **C132-PLACE** [hand, one mind] — on the pure side near a ring point the label is in `N` and outside the palettes
  of the point's two ring neighbours; **C132-ALT** [hand, one mind] — no alternating step orbit has two adjacent ring
  points with pure sides; **C132-TURN-EDGE** [hand, one mind] — at a turning step with outer-pure neighbours the two ring
  labels are never a witnessed edge at the ring point. **C132-TURN: not proved — stalls** (§ Where C132-TURN stalls). All
  in § Stage 3.

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

## Stage 2 — SAVED: C132-COMP, at the class its argument reads

*The asking lane's two-line composition holds, and holds for more than it was posed for. It reads no properness, no palette,
and of each centre only this: which of its edge sets have a point strictly inside, or strictly outside, the unit circle
about the crossing point. The side that is pure accompanies. The one escape is an edge set that lies on that unit circle.*

### The entries

derivation: C132-CROSS
  statement: let L be a finite set of labels, U an open set of the plane, c a measurable map from U to L, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, w a point of U with |w − x| = |w − y| = 1, and 𝒦_x, 𝒦_y two finite families of pairs (K, E) of a compact set K and a set E of labels with H_i ∩ Δ(K) = ∅ for every i in E, where Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1, with x ∈ K for the pairs of 𝒦_x and y ∈ K for the pairs of 𝒦_y; let E_x^out be the union of the sets E over the pairs of 𝒦_x whose K has a point q with |w − q| < 1, E_x^in the union over the pairs of 𝒦_x whose K has a point q with |w − q| > 1, E_y^out the union over the pairs of 𝒦_y whose K has a point q with |w − q| < 1, and E_y^in the union over the pairs of 𝒦_y whose K has a point q with |w − q| > 1; then none of the four sets E_x^out ∪ E_y^out, E_x^out ∪ E_y^in, E_x^in ∪ E_y^out, E_x^in ∪ E_y^in is all of L
  uses only: the definition of Δ(K) with two of its points (x and q); that a point outside H_i has a neighbourhood meeting the class of i in a null set; that z ↦ (|z − x|, |z − y|) is a local diffeomorphism at w when x, y, w are not collinear, which 0 < |x − y| < 2 gives; that a set of positive measure in U has a label almost everywhere. It reads no properness, no palette, no limiting direction, no connectedness of the sets K, and of a set K two of its points
  not claimed: anything at |x − y| = 2 (the circles are tangent and one quadrant is empty: the fault of control `crossing`) or at x = y; anything about a set K all of whose points are at distance 1 from w — such a pair enters none of the four unions; that the exclusions hold for any colouring (they are hypotheses here: at an extracted centre they are clause (3) of C132-EXT-DISC, in a map the edge exclusion, C132-WITNESS below); any area or scale (the quantified form with holes is FS107-R-CP, row 133)
  argument: § Argument — the covering count
  verdict: derived
  grade: hand
  minds: 1
  model: seven labels, the hexagonal seven-colouring with circumradius 2/5, x and y two of its vertices less than 2 apart with their three edges each: every edge is blocked on a side, the four unions are the six labels of the two vertices at most, and the label seen near w is outside both (control `hex7-crossings`)
  prior art: partly: for maps it is the composition behind row 133's FS107-W-TAN (over C-T-TAN, `plans/FS107-W-near-colourings.md` § 2.5) and FS110-N-SEAM's "every tile there lies on one side of the unit circles"; its regular form is `[Voronov2023]` Prop. 2.2 by this project's record FS106-TAN (the paper not read by this job); for a measurable labelling with exclusion sets it was not found by the milestone's gate (`plans/FS132-six-by-the-nerve.md` §PA), which this job did not extend
  handoff: de Bruijn — the statement as written: no colouring theory in it; a local diffeomorphism at w, four non-empty open quadrants, finitely many excluded label sets on each. Its first step (an edge set with a point strictly inside or outside the unit circle about w excludes its labels on one side of the centre's unit circle near w) is the strips clause of the witness card's C132-WIT, whose entry is the one that crosses (the coordinator's ruling, 2026-10-07)

derivation: C132-COMP-SHARP
  statement: let U be an open set of the plane, c a measurable map from U to a set of six labels, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, t_0, t_1, t_2 and t′_0, t′_1, t′_2 the six labels, K_0, K_1, K_2 compact sets containing x with H_{t_j} ∩ Δ(K_j) = ∅ and H_{t_{j+1}} ∩ Δ(K_j) = ∅ for each j modulo 3, K′_0, K′_1, K′_2 compact sets containing y with H_{t′_j} ∩ Δ(K′_j) = ∅ and H_{t′_{j+1}} ∩ Δ(K′_j) = ∅ for each j modulo 3, and w a point of U with |w − x| = |w − y| = 1; then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w
  uses only: C132-CROSS with the three pairs (K_j, {t_j, t_{j+1}}) at x and the three pairs (K′_j, {t′_j, t′_{j+1}}) at y; that three sets each blocked on one of two sides have two blocked on one side; that two edges of a triangle have all three of its labels among their endpoints; that two disjoint triples of six labels are all the labels
  not claimed: which of the six sets it is, or that it is one of x's; anything with seven labels or more (two triangles then leave a label outside both, and the honeycomb is the model of that); anything at a point with three labels and only two witnessed pairs (a bowtie: sectors a, b, a, c have no edge b–c, and fragments S1, BB and MX of FS110-FRAGS are valid with one); that a configuration with a set on the unit circle about w is impossible — fragment T2 is one, on small neighbourhoods of four points
  argument: § Argument — complementary triangles
  verdict: derived
  grade: derived from: C132-CROSS
  minds: 1
  model: fragment T2 of FS110-FRAGS (`tools/fs110_y_fragments.py`): x = (0, 0) with labels 1, 2, 3, y = (1, 0) with labels 4, 5, 6, w = (1/2, √3/2), a valid six-coloured fragment on neighbourhoods of the four points; its tiles are connected, so its edges carry the exclusion (C132-WITNESS), and three of the six edge sets lie on the unit circle about w — two of x's and one of y's (control `seam-fragments`)
  prior art: partly: as C132-CROSS; in the map class the statement with its exception read as "tangent pair or bowtie" is FS107-W-TAN (row 133) and, with no unit arcs, FS110-NB-5 (row 134); the exception as "an edge set on the unit circle about the common unit point" is in this project's files only as fragment T2 and its planted fault `t2_flat`; not searched in print by this job — owed
  handoff: de Bruijn — a corollary of C132-CROSS by one pigeonhole; the formal statement to read back is "one of the six sets is contained in the unit circle about w"

derivation: C132-COMP
  statement: No weak measurable six-colouring of an open set containing the closed unit discs about two points `x ≠ y` with `|x − y| < 2` has at `x` and at `y` the data of C132-TRI-STRIP (clauses (1)–(3) with `ℓ = 3`) with disjoint label triples, provided one of the two crossing points of the unit circles lies, for `x` and for `y`, in a direction perpendicular to none of that centre's three limiting directions
  uses only: C132-COMP-SHARP at the crossing point of the proviso; of clause (2), that a set K_j with points x + s_m w_m, s_m → 0, w_m → v_j, has a point off the unit circle about x + e whenever e·v_j ≠ 0 (the identity |x + e − q|² = 1 + s² − 2s e·w); of clause (1), x ∈ K_j; clause (3). Properness is not consumed; nothing is read of the second crossing point, of connectedness, of clauses (4) and (5), or of which side is pure
  not claimed: that the data exist at any point of any six-colouring; the statement without the proviso (fragment T2 has the data at both points, at distance 1, and fails the proviso at both crossing points — two of its edges at x are arcs of the unit circle about w, with limiting directions perpendicular to w − x); any bound on the number of triangle types in a disc (the regular chain's count is unposed for weak colourings)
  argument: § Argument — the posed form
  verdict: derived
  grade: derived from: C132-COMP-SHARP
  minds: 1
  model: none can exist (a non-existence); the hypotheses other than the proviso are met by fragment T2 (the model of C132-COMP-SHARP), and at seven labels two triples are never all the labels (control `hex7-crossings`: least-shared-outside=1)
  prior art: partly: as C132-COMP-SHARP
  handoff: none — subsumed by C132-COMP-SHARP, which crosses

derivation: C132-WITNESS
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and R a connected open subset of U almost every point of which has the label i; then the closed essential support of the class of i is disjoint from Δ(K) for every compact set K contained in the closure of R
  uses only: that a connected open set is path-connected; the intermediate value theorem for the distance to a point along a path; Fubini for the map (z, u) ↦ z + u; weak properness in its measure form
  not claimed: that the regions of a weak colouring are open, connected or of one label — a weak colouring need have no such region; that an edge of a transition graph is witnessed (the relation between the two is not derived here, and is where C132-TURN stalls in Stage 3); anything for a region that is not connected
  argument: § Argument — a region witnesses its label
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, R the interior of a tile and K one of its edges: a point of the tile's label lies in that tile, within 4/5 of every point of K, or in another tile of that label, farther than 1 from every point of the first tile (the two are at least 1.033 apart) — in neither case in Δ(K)
  prior art: known: the edge exclusion of a map colouring — `[SokolovVoronov2025]` Props. 1–2 by this project's row 134 (not read by this job) and `[OAIMath2026]` (7.1) with Proposition 7.1 (3) for continua; the statement for a region of a weak colouring is that argument
  handoff: de Bruijn — only with a consumer (C132-TURN-EDGE reads a witnessed edge and does not derive one); a path, the intermediate value theorem and Fubini

control: crossing
  of: C132-CROSS — step B2: the squared Jacobian of z ↦ (|z − x|, |z − y|) at the common unit point, |x − y|² (1 − |x − y|²/4), for |x − y| = 1/10, 1/2, 1, 3/2, 19/10, and all four quadrants seen on a grid about it
  run: python3 ../data/fs132/e4/ring_card_checks.py crossing
  expect: least-squared-jacobian=399/40000 all-four-quadrants=True
  fault: python3 ../data/fs132/e4/ring_card_checks.py crossing --fault

control: hex7-crossings
  of: C132-CROSS — at seven: every two vertices of the hexagonal seven-colouring less than 2 apart, both common unit points: no label of either vertex near them, and a label outside both triangles always exists
  run: python3 ../data/fs132/e4/ring_card_checks.py hex7
  expect: vertex-pairs=342 crossings=684 least-shared-outside=1 own-label-near-crossing=0
  fault: python3 ../data/fs132/e4/ring_card_checks.py hex7 --fault

*Dated line (2026-10-07, filed by FS132-Z1, the record job; source: `plans/FS132-E6-derivation.md` Stage 2, § The two riding controls, with its controls `hex-half-crossings` and `hex-half-sides`; `plans/FS132-close-inventory.md` item 28 (d)):* the control `hex7-crossings` above, at circumradius 2/5, is a control of the margin case. Re-run on the honeycomb at circumradius 1/2, where every tile has diameter exactly 1, its fourth count moves — own-label-near-crossing 0 → 36 of 432 crossings (216 vertex pairs) — and every one of the 5,760 such samples lies inside that vertex's unit circle, as the blocking rule requires. C132-CROSS is untouched; "the zero at 2/5 was the margin". The control stands as run.

control: seam-fragments
  of: C132-COMP-SHARP — the four held seam fragments of FS110-FRAGS, both common unit points: the labels the blocking rule excludes, read off each fragment's own edges at its two centres, against the labels found near the points; FS110-Y's checker beside it; in T2, the edge sets on the unit circle about w
  run: python3 ../data/fs132/e4/ring_card_checks.py fragments
  expect: excluded-labels-seen-near-the-common-unit-points:S1=0,T2=0,BB=0,MX=0 checker=ACCEPT,ACCEPT,ACCEPT,ACCEPT sets-of-T2-on-the-unit-circle-about-w=3
  fault: python3 ../data/fs132/e4/ring_card_checks.py fragments --fault

### Argument — the covering count

**B1. A blocked set gives a one-sided strip.** Let `(K, E)` be a pair of `𝒦_x` and `q ∈ K` with `|w − q| < 1`. The set
`V = {z : |z − q| < 1 < |z − x|}` is open, and it lies in `Δ(K)`, because `x` and `q` are points of `K`, one farther than 1
from `z` and one nearer. So `V` misses `H_i` for `i ∈ E`; every point of `V ∩ U` has a neighbourhood in which the class of
`i` is null, and by a countable cover almost every point of `V ∩ U` has its label outside `E`. Since `|w − q| < 1` is an
open condition there is `η > 0` with `{z ∈ B(w, η) : |z − x| > 1} ⊂ V`: **the outer side of the unit circle about `x`,
near `w`, carries no label of `E`.** With `|w − q| > 1` the same holds for `{z : |z − x| < 1 < |z − q|}` and the inner
side. *(This is the argument of C132-TRI-STRIP — `plans/FS132-E2-derivation.md` § Argument — one-sided pure strips — with
its point `q = x + s w` held fixed instead of sent to `x`: `|x + rf − q|² = r² + s² − 2rs f·w`. With points
`q_m = x + s_m w_m` of `K`, `s_m → 0`, `w_m → v`, and `e = w − x`: `|w − q_m|² − 1 = s_m (s_m − 2 e·w_m)` is negative for
large `m` if `e·v > 0` and positive if `e·v < 0`. So an edge whose limiting direction is not perpendicular to `e` is
blocked, on the side of the sign.)*

**B2. Four quadrants.** Put `F(z) = (|z − x|, |z − y|)`. At `w` its Jacobian has rows `w − x` and `w − y`, two unit
vectors, and determinant their cross product; with `D = |x − y|` its square is `D²(1 − D²/4)`, not zero for `0 < D < 2`
(control `crossing`). So `F` is a diffeomorphism of a neighbourhood of `w` onto a neighbourhood of `(1, 1)`, and for every
`η > 0` each of the four sets `Q^{στ}_η = {z ∈ B(w, η) : σ(|z − x| − 1) > 0, τ(|z − y| − 1) > 0}`, `σ, τ = ±`, is open and
non-empty.

**B3. The count.** Take `η` so small that `B(w, η) ⊂ U` and B1's inclusion holds for each of the finitely many blocked
pairs of both families. On `Q^{στ}_η` almost every point has its label outside `E_x^σ ∪ E_y^τ`. The set has positive
measure and every point of it has a label. So `E_x^σ ∪ E_y^τ ≠ L`. ∎

### Argument — complementary triangles

Suppose none of the six sets lies on the unit circle about `w`. Then each has a point `q` with `|w − q| ≠ 1`, so each of
the three pairs `(K_j, {t_j, t_{j+1}})` is counted in `E_x^out` or in `E_x^in`; two of the three are counted on one side
`σ`, and two edges of a triangle have all three labels among their endpoints: `E_x^σ ⊇ {t_0, t_1, t_2}`. In the same way
`E_y^τ ⊇ {t′_0, t′_1, t′_2}` for a side `τ`. The six labels are these two triples, so `E_x^σ ∪ E_y^τ` is all of them,
against C132-CROSS. ∎

**Read off it, not entered.** (i) *Both crossing points.* If `U` holds both common unit points `w₊`, `w₋`, a set lies on
the unit circle about each. A set on both lies in their intersection `{x, y}`. So with connected sets of more than one
point (the extraction's continua) **two different sets are arcs of unit circles, one about each crossing point** — T2's
shape exactly: "u on a full arc of ω(w)", and "v its point reflection". (ii) *With no unit arcs.* If no edge set of
either point lies on a unit circle about a common unit point, no two points less than 2 apart carry witnessed triangles on
complementary triples: FS110-NB-5's statement (row 134, under Condition 5), with no map. (iii) *The same count with other
triples.* If `x` and `y` both have a pure side at `w` (two edges blocked on one side), the quadrant on which both are pure
carries only the labels outside both triangles: none when the triples are complementary; **one label, almost everywhere,
when the triangles share exactly one label**; two when they share an edge. Not entered: it is C132-CROSS read aloud.

### Argument — the posed form

Let `w` be the crossing point of the proviso, `e = w − x`. The open set contains `w`. By the bracket of B1, for each `j`
the set `K_j` of `x` (clauses (1), (2): it contains `x` and points `x + s_m w_m` with `s_m → 0`, `w_m → v_j`, and
`e·v_j ≠ 0`) has a point off the unit circle about `w`; the same at `y`. Clause (3) is the exclusion. C132-COMP-SHARP
then gives a set on that circle: a contradiction. ∎

### Argument — a region witnesses its label

Let `z ∈ H_i ∩ Δ(K)`, `K ⊂ cl R`. There are `q₁, q₂ ∈ K` with `|z − q₁| < 1 < |z − q₂|`, hence `r₁, r₂ ∈ R` with
`|z − r₁| < 1 < |z − r₂|`. `R` is open and connected, so a path in `R` joins them, and on it some `r ∈ R` has
`|z − r| = 1`. Take `η > 0` with `B(r, 2η) ⊂ R`. The class `A_i` has positive measure in `B(z, η)`. For `z′ ∈ B(z, η)`
the point `z′ + (r − z)` is within `η` of `r`, so the unit vectors `u` with `z′ + u ∈ B(r, 2η)` contain an arc about
`r − z` of length bounded below. The pairs `(z′, u)` with `z′ ∈ A_i ∩ B(z, η)` and `z′ + u ∈ B(r, 2η)` thus have positive
measure, and for almost every one of them `z′ + u` has the label `i` (for each fixed `u` the exceptional `z′` are a
translate of a null set). That is a positive measure of unit pairs of one label, against weak properness. ∎

### The three controls the brief names

- **Seven.** With seven labels two triangles leave at least one label outside both, so C132-CROSS forbids no pair of
  triangle centres by count, and C132-COMP-SHARP has no seven-label form. Measured on the honeycomb (control
  `hex7-crossings`): 342 ordered pairs of vertices less than 2 apart, 684 common unit points, the label near each outside
  both triangles; with the planted fault (circles of radius 7/10) 288 of 360 crossings show a vertex's own label.
- **The held six-coloured fragments with complementary pairs.** *HX* (rows 133, 139; the erratum in
  `plans/FS107-derivation.md` § 5): "HX carries complementary pairs of fat junctions at distance `√7·R`, blocking toward
  points that lie inside its voids" — the common unit point is where HX assigns no label, so it is not in `U`: **outside
  the claim by its first hypothesis**, and C132-CROSS says why the void must be there (FS107-R-CP is that statement with
  the void's area). *S1, T2, BB, MX* (FS110-FRAGS; row 134): each is a valid fragment about a complementary pair at
  distance 1 with both common unit points inside it. Control `seam-fragments` reads the blocking rule off each fragment's
  own edges and finds no excluded label near either point, on all four. **T2 falls outside by the proviso, in the sharp
  form: three of its six edge sets lie on the unit circle about `w`.** **S1, BB and MX fall outside by the hypothesis: a
  bowtie has three labels in four sectors `a, b, a, c` and no edge between `b` and `c`**, so its blocked edges need not
  cover its three labels on either side — and C132-CROSS still holds of it, as the control checks.
- **The tangent pair and the bowtie** (W-TAN's two exceptions). *The bowtie*: accounted for above — it is not a witnessed
  triangle. *The tangent pair*: "at `u` or at `v`, a boundary ray perpendicular to `w₀ − u`"
  (`plans/FS107-W-near-colourings.md` § 2.5). In the exact class a tangent edge is no exception unless it lies on the
  unit circle about `w₀`: a straight ray from `u` perpendicular to `w₀ − u` has every other point farther than 1 from
  `w₀` and is inner-blocked. The cone lemma could not see this because a blow-up keeps only the tangent. **The planted
  fault of `seam-fragments` is this statement run on a held object**: T2 with `u`'s two arcs of the unit circle about `w`
  replaced by their chords — tangent no longer, but that is not what kills it: the chords are outer-blocked, `u` gains a
  pure outer side at `w`, and 12 of the sampled points near `w` carry a label `u` excludes; FS110-Y's checker rejects
  the same fragment for its own reason. **So W-TAN's exception shrinks: "tangent pair" may be read "an edge that is an
  arc of the unit circle about the common unit point".** A correction owed to row 133's wording is drafted in the
  report; the row's statement is true as it stands (it lists a superset of the exceptions).

### What this does to the road (for the coordinator; nothing here moves a value)

Step 3e of the asking lane's table ("no two triangle centres with disjoint triples are closer than 2") is derived for
every measurable labelling with witnessed triangles, with one exception that is a (Q)-kind object: an edge set on the
unit circle about the crossing point. It is where every later claim on this card ends — and Stage 3 meets the exception
at once: the triangle a turning ring places at a ring point has two of its edges on the unit circles about the two ring
points 60° away, which are the crossing points.

## Stage 2 — SAVED

## Stage 3 — SAVED: C132-PLACE, the alternating orbit, the turning orbit, and where C132-TURN stalls

*Setting for the whole stage.* `U` is an open set containing the closed unit disc about `x`; `c` is a weak colouring of `U`
with six labels; `T` is a set of three labels with a witnessed triangle at `x` (sets `K_0, K_1, K_2`); `N = {a, b, n}` is
the set of the other three. Translate so `x = 0`. `Z(α, d) = e(α) + e(α − 2π/3 − d)` is FS132-E3's chart (its M2): a
diffeomorphism of `(ℝ/2π) × (−d_0, d_0)` onto an annulus about the unit circle, with `|Z| < 1` when `d > 0` and `|Z| > 1`
when `d < 0`, and `e(α)`, `e(α − 2π/3 − d)` the two ring points at distance 1 from `Z(α, d)` — its **forward** and
**backward neighbours**. For an angle `ψ` write `ψ_k = ψ + kπ/3`, `y_k = e(ψ_k)` (the **ring points** of the orbit of `ψ`).
A point near `y_0` is `Z(ψ_1 + θ, d)`: its forward neighbour is at `ψ_1 + θ`, its backward neighbour at `ψ_{−1} + θ − d`.
Because the arc of the ring inside the unit disc about `Z` is the arc between its two neighbours,

> (W) `Z(ψ_1 + θ, d)` is inside the unit circle about `y_1` when `θ > 0` and outside it when `θ < 0`; inside the unit
> circle about `y_{−1}` when `θ − d < 0` and outside it when `θ − d > 0`

(control `chart-wedges`: 1,681 samples, no mismatch). So the unit circles about `y_1` and `y_{−1}`, which cross at `y_0` and
at `x`, cut a neighbourhood of `y_0` into four wedges: **far** (`θ < 0 < θ − d`: outside both, a 60° wedge outside the
ring), **lens** (`θ − d < 0 < θ`: inside both, a 60° wedge inside the ring), **cw** (`θ < 0`, `θ − d < 0`) and **ccw**
(`θ > 0`, `θ − d > 0`), the last two cut by the ring into an outer and an inner part.

### The entries

derivation: C132-PLACE
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, N the set of the three other labels, and ψ an angle such that at least two of the sets K_j have a point q with |x + e(ψ) − q| < 1; then there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and −κ < d < 0 the label of the point x + e(α) + e(α − 2π/3 − d) lies in N and in neither of the palettes P_x(e(α)) and P_x(e(α − 2π/3 − d)); and if at least two of the sets K_j have a point q with |x + e(ψ) − q| > 1, there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and 0 < d < κ the label of that point lies in N and in neither of those two palettes
  uses only: `[OAIMath2026]` Lemma 5.2 assertion (1) read locally (`palettes.tex:111–203`, read with its proof: label by label, no count, and local to the pairs whose sums stay in U — FS132-E3's reading T2, which I re-read against the source); the chart Z (FS132-E3's M2) and that it carries null sets to null sets; step B1 of C132-CROSS (a set with a point strictly inside, or outside, the unit circle about the ring point excludes its two labels on the outer, or inner, side near it); that two edges of a triangle have its three labels among their endpoints. It reads nothing of the limiting directions, of connectedness, of the transition graph, or of the other side of the ring
  not claimed: anything on the side that is not pure — there the label lies outside the two palettes and may be a label of T; anything at a ring point with no pure side (then one of the sets K_j lies on the unit circle about the ring point, by the pigeonhole of C132-COMP-SHARP); that the two palettes are singletons, or that the outside state is a step; that the ring point is a cyclic centre
  argument: § Argument — the transfer on the pure side
  verdict: derived
  grade: hand
  minds: 1
  model: seven labels, the hexagonal seven-colouring at the vertex (0, 2/5), where both sides are pure at every direction (FS132-E2's control `hex7-relation`): the label at a point near the ring is outside the labels at its two ring neighbours — properness of the honeycomb at distance 1; no six-colouring is known, and at six the list under the argument is checked on the two six-sector rings as patterns (control `chart-wedges`)
  prior art: partly: `[OAIMath2026]` Lemma 5.2 and Lemma 8.1 are the two inputs, and its lemma "Polynomial three-label region" (`angular.tex:484–524`, the eighth numbered statement of its § 8) is this statement at five labels for two outside labels and both neighbours inside sectors; in the map class it is this project's ring calculus (G91; FS116-V6's V6-GERM, as FS132-E3's M2 restates it); the three-label form on a pure side not found by the milestone's gate, which this job did not extend
  handoff: de Bruijn — over the release's `palette_transport_param` at `Fin 6` and the strips clause of C132-WIT: the statement as written, two cases by the side

derivation: C132-ALT
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a and b two labels outside T, ψ an angle and δ > 0 such that for every integer k the palette P_x(e(θ)) contains a for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is even and for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is odd, and contains b for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is even and for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is odd; then there is no integer k such that, for both m = k and m = k + 1, at least two of the sets K_j have a point strictly inside the unit circle about x + e(ψ + mπ/3) or at least two of them have a point strictly outside it
  uses only: C132-PLACE at two adjacent ring points; the unit-pair relation between points near two ring points π/3 apart, FS132-E3's M7, with its shift ε = d d′ h(d, d′), h smooth and h(0, 0) = 2/√3, read for both signs of d and of d′ (the derivation there does not use the signs; control `unit-shift`); weak properness; six labels, as "three outside T"
  not claimed: the statement for a ring that alternates near the orbit without being a step (palettes that hold a or b almost everywhere near the six points, each on a set of positive measure near ψ): for two adjacent ring points with pure inner sides it follows, because FS132-E3's Lemma S makes such a state a step; for the three other patterns of sides it needs a shift lemma of that kind for three other arrangements of the two gaps, which is sketched under the argument and not entered; anything at an orbit none of whose adjacent pairs has two pure sides — then three of the six ring points, alternate ones, each have one of the three sets K_j on their unit circle; anything at seven labels
  argument: § Argument — the alternating orbit
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence); as a pattern, the six-sector ring a, b, a, b, a, b: at each ring point the far wedge and the lens are left the third outside label (control `chart-wedges`), and between two adjacent ring points the forced regions hold unit pairs for three of the four patterns of sides and none for two inner sides, where the argument takes its second step (control `forced-pairs`: 36, 129, 93, 0)
  prior art: partly: at five labels the ring of a triangle centre is this alternating ring and the release kills it by rigidity and a Moser spindle in the region its lemma "Polynomial three-label region" leaves to the triangle's labels (`angular.tex:476–607`); the mechanism here is FS132-E3's M7–M9 (C132-M-ORBIT) with the third outside label in the place of the tip; the six-label statement not found by the milestone's gate, which this job did not extend
  handoff: de Bruijn — after C132-M-ORBIT's module, which holds the chart, the unit-pair relation and the kill; here four cases by the sides, three of them one open set of unit pairs each

derivation: C132-TURN-EDGE
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a, b, n the three labels outside T, ψ an angle and δ > 0 such that the palette P_x(e(θ)) contains a for almost every θ in (ψ − δ, ψ), contains b for almost every θ in (ψ, ψ + δ), and contains n for almost every θ in (ψ + 2π/3 − δ, ψ + 2π/3) and for almost every θ in (ψ − 2π/3, ψ − 2π/3 + δ), and suppose that at least two of the sets K_j have a point strictly inside the unit circle about x + e(ψ + π/3) and at least two of them have a point strictly inside the unit circle about x + e(ψ − π/3); then there is no compact set K containing x + e(ψ) and another point such that Δ(K) is disjoint from the closed essential supports of a and of b
  uses only: C132-PLACE on the outer side at the two ring points x + e(ψ ± π/3); the first clause of C132-CONFINE (a support point outside Δ(K) has all of K within 1 or none of K nearer than 1); that the unit circles about x + e(ψ + π/3) and x + e(ψ − π/3) meet at x and at x + e(ψ) and nowhere else (control `turning-edge`)
  not claimed: that the ring point is a cyclic centre, or carries any witnessed edge; that the pair {a, b} is an edge of its transition graph; anything when one of the two neighbouring ring points has only a pure inner side (the third label is then forced in no region the argument can read); anything for a state that is not a step at ψ; that a colouring with these hypotheses exists
  argument: § Argument — no witness between the two ring labels
  verdict: derived
  grade: hand
  minds: 1
  model: none at six — no six-colouring is known; the hypotheses on the ring are those of the six-sector ring a, b, n, a, b, n at any of its six ring points, and the regions the argument reads lie where it says (control `turning-edge`); at seven the honeycomb's ring at a vertex has no step whose neighbours 2π/3 away agree on a third label out of three (its ring carries four labels)
  prior art: owed — the statement is this job's; its mechanism is C132-CONFINE (FS132-E1) read at two points of the unit circle about the ring point
  handoff: de Bruijn — only with a consumer; from C132-PLACE and C132-CONFINE, two confinements and one intersection of circles

derivation: C132-TURN
  statement: In a weak measurable six-colouring of a closed disc of radius above 2 about a triangle centre `x`, every cyclic centre of which carries a witnessed triangle and no longer witnessed cycle, `W_x = 3` almost everywhere and no two essential changes of the outside label are `π/3` apart
  uses only: nothing is carried to the statement. Derived on the way: C132-ALT (two changes π/3 apart of the alternating kind, for a step and two adjacent ring points with pure sides) and C132-TURN-EDGE (at a step of the turning kind whose two neighbours have pure outer sides the two ring labels are never a witnessed edge at the ring point)
  not claimed: its truth or its falsity; that a ring by formula survives — none was built, and § What a colouring by formula would need says why none is in reach without a search; anything for an outside state that is only measurable near the orbit
  argument: § Where C132-TURN stalls
  verdict: stalls at: the step from the card's hypothesis to a witness at the ring point of a turning orbit — that the ring point is a cyclic centre (the side of the ring that is not pure is left free by the transfer), and that the witnessed triangle the hypothesis then gives it contains the pair of the two ring labels, as it would if a witnessed cycle had to lie in the point's own transition graph (the relation of C132-EXT-DISC's clause (5), one mind, against a sentence of the manuscript); with that pair witnessed C132-TURN-EDGE is a contradiction
  grade: hand
  minds: 1
  model: none — no six-colouring is known; at seven the statement has no analogue (four outside labels carry no orbit index, and the honeycomb's rings have no two changes π/3 apart: FS132-E2's control `hex7-relation`)
  prior art: partly: in the map classes "no two changes π/3 apart" is Sokolov–Voronov's transversality (by `plans/FS110-CB-verification.md` § D5, as FS132-E2's entry C132-RING-TAME cites it; not read by this job); for weak colourings not found by the milestone's gate
  handoff: Poros — not derived; stalls at a witness at the ring point; the smallest open forms are § Where C132-TURN stalls, items (i)–(iii)

*Dated correction (2026-10-07, filed by FS132-Z1, the record job; sources: `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–76; `plans/FS132-close-inventory.md` item 21; `data/fs132/claims.md`, the dated correction of item 21):* the verdict line of the entry C132-TURN above calls the stalled step "the relation of C132-EXT-DISC's clause (5)". That reads the clause more widely than its entry: clause (5) is derived for the extraction's own continua and says nothing of whatever witnesses a hypothesis hands a point, and for those the relation is false in general (FS132-E5's anchored witnessed triangle at a point whose transition graph is a path: hand, one mind, no control, at seven). The claim list's wording: "C132-TURN's stall is: that a witnessed triangle given at a point lies in that point's own transition graph — a statement no entry of this list asserts." And the statement as posed carries the defect its poser names — it "attaches data of a unit circle to a point defined by its small balls, with nothing joining them"; it stands as stalled and is not re-posed in that form. The entry is left as filed.

control: chart-wedges
  of: C132-PLACE — the chart's three signs (inside the ring; inside the unit circle about the forward neighbour's ring point; inside the one about the backward neighbour's) on 1,681 points, and the label sets the transfer leaves in the four wedges for the two six-sector rings
  run: python3 ../data/fs132/e4/ring_card_checks.py wedges
  expect: chart-samples=1681 sign-mismatches=0 turning:far=c lens=ab cw=a ccw=b alternating:far=c lens=c cw=ac ccw=bc
  fault: python3 ../data/fs132/e4/ring_card_checks.py wedges --fault

control: unit-shift
  of: C132-ALT — the shift ε(d, d′) of the unit-pair relation in all four sign quadrants: its ratio to d d′ and the bounds the argument uses (the sign of d d′; at most min(|d|, |d′|)/16)
  run: python3 ../data/fs132/e4/ring_card_checks.py shift
  expect: ratio-min=1.114 ratio-max=1.199 limit=1.1547 sign-or-size-violations=0
  fault: python3 ../data/fs132/e4/ring_card_checks.py shift --fault

control: forced-pairs
  of: C132-ALT — sampled unit pairs between two adjacent ring points whose two labels the transfer forces to one label, for the four patterns of pure sides (O outer, I inner), on the alternating and on the turning six-sector ring
  run: python3 ../data/fs132/e4/ring_card_checks.py pairs
  expect: alternating:OO=36,OI=129,IO=93,II=0 turning:OO=0,OI=0,IO=0,II=0
  fault: python3 ../data/fs132/e4/ring_card_checks.py pairs --fault

control: turning-edge
  of: C132-TURN-EDGE — the unit circles about the two neighbouring ring points meet at x and at the ring point; the four regions read lie outside the ring and on the stated side of the unit circle about the ring point
  run: python3 ../data/fs132/e4/ring_card_checks.py edge
  expect: circles-meet-at-x-and-y=True region-samples=576 side-mismatches=0
  fault: python3 ../data/fs132/e4/ring_card_checks.py edge --fault

### Argument — the transfer on the pure side

**P1.** By Lemma 5.2 (1), for almost every pair of unit vectors `(e, v)` with `e + v ∈ U`: `c(e + v) ∉ P_0(e) ∪ P_0(v)`.
On the non-parallel pairs `(e(α), e(α − 2π/3 − d))` the sum map is the chart `Z`, a diffeomorphism, so for almost every
`(α, d)` with `|d| < d_0`: `c(Z(α, d)) ∉ P_0(e(α)) ∪ P_0(e(α − 2π/3 − d))`. *(FS132-E3's (⋆), which is label-free.)*
**P2.** If two of the `K_j` have a point strictly inside the unit circle about `y = e(ψ)`, then by step B1 of C132-CROSS
the outer side of the ring near `y` carries, almost everywhere, no endpoint of either edge, so only `N`. The points
`Z(α, d)` with `α` near `ψ + π/3` and `d < 0` small are the points near `y` outside the ring. **P3.** Intersect. The inner
case is the same with "outside" for "inside" and `d > 0`. ∎

**The list** (what P1–P3 force near a ring point `y_0 = e(ψ)` with a pure side, by the germs of the outside state
`s(θ) = P_0(e(θ)) ∩ N` at `ψ ± π/3`; "germ" = `s` almost everywhere near the point; each line derived unless marked).

- **L1 — both germs one singleton `{a′}` (the tame case).** The pure side near `y_0` is almost everywhere in the two other
  labels of `N`. Nothing chooses between them: a change of `s` at `ψ` between those two is consistent with P1–P3.
- **L2 — two different singletons `{a′}` at `ψ + π/3`, `{b′}` at `ψ − π/3`.** The pure side near `y_0` is almost everywhere
  the third label. So `s` is that label near `ψ`: **no essential change at `ψ`**.
- **L3 — steps: `f⁻ | f⁺` at `ψ + π/3` and `g⁻ | g⁺` at `ψ − π/3`** (singletons; `u | v` = `u` just before, `v` just after).
  By (W), on the pure side: **far ⊂ `N ∖ {f⁻, g⁺}`, lens ⊂ `N ∖ {f⁺, g⁻}`, cw ⊂ `N ∖ {f⁻, g⁻}`, ccw ⊂ `N ∖ {f⁺, g⁺}`**.
  When `s` is `a | b` at `ψ`, Corollary 5.4 leaves `f⁻, g⁻ ∈ {b, n}` and `f⁺, g⁺ ∈ {a, n}`: sixteen patterns, of which
  L1 is `n | n`, `n | n`.
- **L4 — the six-sector ring `a, b, n, a, b, n`** (`a | b` at `ψ`, `b | n` at `ψ + π/3`, `n | a` at `ψ − π/3`; control
  `chart-wedges`, which prints the third label as `c`). **far = `n`**, lens ⊂ `{a, b}`, cw = `a`, ccw = `b`. *At a ring point with a pure outer side all three
  outside labels meet*: outside the ring three 60° wedges `a`, `n`, `b`, the `n`-wedge between arcs of the unit circles
  about `y_1` and `y_{−1}`; by C132-WITNESS the pairs `{a, n}` and `{n, b}` are witnessed edges at `y_0`, with sets on
  those two circles — the escape of C132-COMP-SHARP, should `y_0` carry the triangle `N`. *At a ring point with a pure
  inner side*: inside the ring only `a` and `b`, `a` on the cw part and `b` on the ccw part; the third label is forced
  nowhere. The asking lane's hunch (`the-turning-ring-places-a-fourth-label`) is **confirmed on outer-pure ring points
  and not on inner-pure ones**; for the mirror-image ring the same; for a twelve-sector ring `a, n, b, …` of 30° sectors
  (also of orbit index 2) L3 gives lens = third label and far ⊂ two labels, so there the sides exchange roles.
- **L5 — the six-sector ring `a, b, a, b, a, b`.** **far = `n` and lens = `n`**; cw ⊂ `{a, n}`, ccw ⊂ `{b, n}`. The forced
  label is the same at every ring point: C132-ALT.
- **L6 — open: the side that is not pure.** There P1 alone holds: the label avoids the two palettes and may be the one
  label of `T` the strips allow on that side (any label of `T`, when all three edges are blocked on the pure side only).
  Whether `y_0` is a cyclic centre, and with which labels, is decided there.
- **L7 — open: germs that are only measurable.** Only P1–P3. A point whose two ring neighbours carry different single
  labels has the third; where they carry one label, two remain.
- **L8 — the other patterns of L3** (one germ constant and one a step; a swap `b | a` on one side only) are lines of its
  table with no consequence drawn here. One is worth its sentence: forward germ `b | a`, backward germ `n | n` gives far
  and cw = `a`, lens and ccw = `b` — the change at `ψ` continues off the ring along the unit circle about `y_1`, on both
  sides if both are pure: an interface that is an arc of a unit circle about a ring point.

### Argument — the alternating orbit

Suppose `k` exists; replace `ψ` by `ψ + kπ/3`, exchanging the names `a` and `b` if `k` is odd, so that `k = 0` and the
hypothesis reads: the palettes hold `a` just before `ψ_0`, `ψ_{±2}` and just after `ψ_{±1}`, and `b` on the other sides. Each of
`y_0`, `y_1` has a pure side; write O for outer, I for inner. A point near `y_0` is `z = Z(ψ_1 + θ, d)`, and by C132-PLACE
on the pure side of `y_0` (the sign of `d`) its label is in `N` and outside the palettes of its neighbours, at `ψ_1 + θ`
and `ψ_{−1} + θ − d`. So, almost everywhere on that side:

> lens₀ (`0 < θ < d`) and far₀ (`d < θ < 0`): the neighbours' palettes hold `a` and `b` — **the label is `n`**;
> cw₀ (`θ < 0`, `θ < d`): they both hold `b` — the label is `a` or `n`.

A point near `y_1` is `z′ = Z(ψ_2 + θ′, d′)`, with neighbours at `ψ_2 + θ′` and `ψ_0 + θ′ − d′`; on the pure side of `y_1`:

> lens₁ (`θ′ − d′ < 0 < θ′`) and far₁ (`θ′ < 0 < θ′ − d′`): **the label is `n`**; ccw₁ (`θ′ > 0`, `θ′ − d′ > 0`): `a` or `n`.

*The unit pairs.* By FS132-E3's M7, for small `d, d′` the points `z` and `z′` are at distance 1 when
`θ′ = θ + d′ + ε(d, d′)`, where `ε = d d′ h(d, d′)` with `h` smooth and `h(0, 0) = 2/√3`: the derivation there (the
implicit function `G`, and `ε = 0` on both axes) does not use the signs of `d` and `d′`. So there is `κ_1` with
`0 < |ε| ≤ min(|d|, |d′|)/16` and `ε` of the sign of `d d′` for `0 < |d|, |d′| < κ_1` (control `unit-shift`), and
`(θ, d, d′) ↦ (z, z′ − z)` is a local diffeomorphism into the unit pairs, so sets of positive measure correspond.
Then `θ′ − d′ = θ + ε`, and:

- **O, O** (`d, d′ < 0`, `ε > 0`). far₀ is `d < θ < 0`; far₁ is `θ + d′ + ε < 0 < θ + ε`. Both hold on the non-empty open
  set `max(d, −ε) < θ < 0`: a positive measure of unit pairs with both labels `n`.
- **O, I** (`d < 0 < d′`, `ε < 0`). far₀ is `d < θ < 0`; lens₁ is `θ + ε < 0 < θ + d′ + ε`. Both hold on
  `max(d, |ε| − d′) < θ < 0`: again both labels `n`.
- **I, O** (`d′ < 0 < d`, `ε < 0`). lens₀ is `0 < θ < d`; far₁ is `θ + d′ + ε < 0 < θ + ε`. Both hold on
  `|ε| < θ < min(d, |d′| + |ε|)`, non-empty because `|ε| < d/16`: both labels `n`.
- **I, I** (`d, d′ > 0`, `ε > 0`). lens₀ and lens₁ hold no unit pair (`θ > 0` and `θ + ε < 0`), and the argument is
  FS132-E3's M9. (1) *`n` is null on the inner part of cw₀* (`θ < 0`, `d > 0`): for such a point and every
  `d′ ∈ (|θ|, 16|θ|)`, `ε ≤ d′/16 < |θ| < d′ + ε`, so `θ + ε < 0 < θ + d′ + ε` and the partner is in lens₁, almost
  everywhere of label `n`; a positive measure of label `n` there would give a positive measure of unit pairs of label
  `n`. So that part is almost everywhere `a`. (2) *`n` is null on the inner part of ccw₁* (`θ + ε > 0`, `d′ > 0`): with
  `h′ = θ + ε` and any `d ∈ (h′, 16h′)`, `θ = h′ − ε(d, d′) ∈ (0, h′) ⊂ (0, d)`, so the partner is in lens₀. So that part
  is almost everywhere `a`. (3) On the non-empty open set `−ε < θ < 0`, `d, d′ > 0`, the point `z` is in the inner part
  of cw₀ and `z′` (`θ + ε > 0`, `θ′ > 0`) in the inner part of ccw₁: a positive measure of unit pairs with both labels `a`.

Each case contradicts weak properness. ∎ (Control `forced-pairs`: on the pattern, sampled unit pairs with both labels
forced equal — 36, 129, 93 for O O, O I, I O, and 0 for I I, where the argument needs its steps (1) and (2).)

**Read off it, not entered.** (i) *When no adjacent pair has two pure sides.* A ring point with no pure side has one of
the `K_j` on its unit circle (the pigeonhole of C132-COMP-SHARP). So an alternating step orbit survives only if of every
two adjacent ring points one has an edge set of `x` on its unit circle: three sets, a hexagon — **the three edge sets of
`x` lie on the unit circles about three alternate ring points**. With connected sets these are three unit arcs through
`x`, 120° apart: a (Q)-kind configuration, the one residue. (ii) *The measurable form.* With "the palettes near the six
points hold `a` or `b`, each on a set of positive measure near `ψ`" in place of the step: for I, I the relation (†) of
FS132-E3's M8 holds as there and its Lemma S makes the state a step, so the entry applies ([hand], one mind, over that
lemma). For the three other patterns the relation is "not both `s` changes across a gap `p` above `α` and across a gap
`r`" at `α ± ε`, with the gaps arranged differently; a density argument of Lemma S's kind (a thick interval of one
value just below a density point of the other, the shift at most an eighth of the interval) gives a positive measure of
violations for O, I and I, O, and for O, O after a case split on whether the lower value recurs below. **Sketched, not
checked line by line, not entered.** (iii) *The readings deriver's paragraph* (`plans/FS132-E3-derivation.md` Stage 4,
§ The coordinator's question: "near two ring points 60° apart the forced labels are in general *different* … so
properness between the two regions says nothing"): **the same statement from the other side, no disagreement.** On an
alternating orbit the forced labels at adjacent ring points coincide (both `n`), and there the mechanism runs; on a
turning orbit they are `n`, `a`, `b` in turn, and control `forced-pairs` finds no forced pair in any pattern of sides.

### Argument — no witness between the two ring labels

Put `y = e(ψ)`, `y_± = e(ψ ± π/3)`, and suppose `K` exists. *Near `y_+`.* A point near `y_+` is `Z(ψ + 2π/3 + θ, d)`, with
neighbours at `ψ + 2π/3 + θ` and `ψ + θ − d`. On the outer side (`d < 0`), by C132-PLACE: where `d < θ < 0` the
neighbours' palettes hold `n` and `b`, so **the label is `a`**, and by (W) read at `y_+` (whose backward ring point is
`y`) these points are outside the unit circle about `y`; where `θ < d` the palettes hold `n` and `a`, so **the label is
`b`**, and these points are inside it. Both regions are non-empty and open, in every neighbourhood of `y_+` (control
`turning-edge`). So there are points of `H_b` arbitrarily near `y_+` and nearer than 1 to `y`: each is outside `Δ(K)` and
has the point `y` of `K` within 1, hence all of `K` within 1 (C132-CONFINE); in the limit `K ⊂ B̄(y_+, 1)`. And there are
points of `H_a` arbitrarily near `y_+` farther than 1 from `y`: each has no point of `K` nearer than 1; in the limit
`K ∩ B(y_+, 1) = ∅`. So **`K` lies on the unit circle about `y_+`**. *Near `y_−`.* A point is `Z(ψ + θ, d)`, neighbours
at `ψ + θ` and `ψ − 2π/3 + θ − d`; outside the ring: where `d < θ < 0` the palettes hold `a` and `n`, the label is `b`,
outside the unit circle about `y`; where `θ > 0` they hold `b` and `n`, the label is `a`, inside it. As before, **`K`
lies on the unit circle about `y_−`**. *The end.* Those two circles meet at `x` and at `y` only, so `K = {x, y}`. But the
points just found near `y_−` with label `a` are farther than 1 from `x` and nearer than 1 to `y`: they are in
`Δ({x, y}) ∩ H_a`. ∎

**What it is, in the witness card's words** (FS132-E5's recognition, relayed 2026-10-07: "a 'witnessed cycle at p' is a
property of the unit circle about p, not of p"). That is how this argument reads the ring point: `y_+` and `y_−` are two
points of the unit circle about `y` near each of which both `a` and `b` occur, one inside that circle and one outside, so
no straddle set of a set through `y` can miss both supports. **It does not change the statement.** It changes how the
stall below should be heard: the question is not whether the pair `{a, b}` *is* witnessed at the ring point — under these
hypotheses it never is — but whether the card's hypothesis *requires* it to be.

### Where C132-TURN stalls

*The statement's two conclusions, against what is derived.* "No two essential changes π/3 apart": for a step ring the
changes π/3 apart are the lines of L3 other than L1. The alternating kind is excluded by C132-ALT wherever two adjacent
ring points have pure sides. The turning kind has orbit index 2 or 4 (`W_x ≠ 3`), is consistent with everything the
centre `x` supplies near the ring (L4; control `forced-pairs`: no forced pair in any pattern of sides), and **stalls**:

- **(i) The witness at the ring point.** C132-TURN-EDGE: at a ring point `y` of a turning step orbit whose two
  neighbours have pure outer sides, `{a, b}` is not a witnessed edge. Every pattern of sides has such a point when all
  six ring points have a pure side: the side is opposite at antipodes, so the six read O O O I I I (take the middle O) or
  O I O I O I (take any I). The card's hypothesis gives a witnessed triangle to every *cyclic centre*. So the turning
  orbit is excluded as soon as (1) `y` is a cyclic centre and (2) the triangle it then carries contains the pair
  `{a, b}`. For (1): at an outer-pure `y` the labels `a`, `n`, `b` meet outside the ring, and the inside is L6's open
  line; at an inner-pure `y` the inside holds `a` and `b` only and the outside is L6's. For (2): it holds if a witnessed
  cycle must be a cycle of the point's own transition graph and every cycle of that graph at `y` passes through `a`–`b` —
  the first is the relation of C132-EXT-DISC's clause (5) (one mind; the manuscript: "The extracted cycle need not
  consist of edges of Γ_x"), the second is not derived. **Smallest open form:** *in a weak six-colouring, at a point `y`
  near which one side of a unit circle through `y` carries `a` and then `b` along the circle and nothing else, does every
  set of witnessed edges closing a cycle at `y` contain the pair `{a, b}`?*

  *Dated line (2026-10-07, filed by FS132-Z1, the record job; the text between the quotation marks is FS132-E6's draft, verbatim), on the sentence above "Every pattern of sides has such a point when all six ring points have a pure side: the side is opposite at antipodes, so the six read O O O I I I (take the middle O) or O I O I O I (take any I).":* "2026-10-07, FS132-E6: true when each of the three sets has a point strictly inside three of the six unit circles about the ring points and strictly outside the other three (so when each has a limiting direction at `x` perpendicular to no ring direction); false as written — sets `{x, q_j}` with `|q_j − x| > 2` make all six sides inner-pure and none outer-pure. The entry C132-TURN-EDGE does not use the sentence. And by C132-LENS-SIDE the pattern O I O I O I does not occur at all. Source: `plans/FS132-E6-derivation.md` Stage 2, § The gap in clause (ii)." *And on "the first is the relation of C132-EXT-DISC's clause (5)" in the same item: the dated correction under the entry C132-TURN in this record applies — the clause is read there more widely than its entry.*

- **(ii) The measurable turning orbit.** For an outside state with orbit index 2 or 4 that is not a step near the orbit,
  only L7. No derived form.
- **(iii) Ring points with no pure side.** Every statement of this stage is void at a ring point on whose unit circle an
  edge set of `x` lies. That is the same exception as C132-COMP-SHARP's, and the same kind of object as the (Q) arcs on
  which every held positive of the map class lives (rows 136, 138).

*The card's three branches.* It is the third — "all three outside labels are forced at the ring point but no cycle is
witnessed there: the stall has moved from the ring to which points carry witnesses" — sharpened in two ways: the third
label is forced only on outer-pure ring points (L4), and the witness that would kill is one edge, between the two ring
labels, which is provably absent. So the witness card's answer decides this one; **what to ask it is form (i)**.

### What a colouring by formula would need (not built)

An open line realized by formula would be a weak six-colouring near the closed unit disc about a point with a witnessed
triangle whose ring is `a, b, n, a, b, n`. Locally it must be, at each outer-pure ring point `y`, three 60° wedges of the
outside labels with interfaces along the unit circles about the two neighbouring ring points (L4), and those neighbours
are again ring points of the same kind. The one held object of this shape is fragment T2 (two complementary triangle
points at distance 1, each with arcs on the unit circles about the common unit points) — and in T2 the common unit points
are *four-colour vertices*, not triangle points. A triangles-only version needs the six ring points to carry each other's
arcs consistently around the hexagon, with the impure sides filled; I found no formula for it and no reason it cannot
exist beyond C132-TURN-EDGE. Deciding it by enumeration of local fillings is a search (a `search request` in the report),
not a derivation. **Radius reached: none; nothing was built.**

### Predictions scored

- **P1** (C132-COMP derived in a sharper form, 0.93): **met** — derived as posed and as C132-COMP-SHARP.
- **P2** (the list derived for constant and step germs, only the formula for measurable ones, 0.85; a formula built,
  0.05): **met**; nothing built.
- **P3** (C132-TURN stalls at a witness at the ring point, 0.80; the alternating half derived, 0.80): **met in outcome**;
  the mechanism I expected for the stall was half wrong — I expected "is the edge witnessed" to be the open question, and
  the derivation shows it is not witnessed; what is open is whether the hypothesis requires it.
- The asking lane's registered expectations (the stub): C132-COMP derived at the first attempt (0.85) — met; C132-PLACE's
  list with the third label forced in the differing case (0.60) — met on the pure side; C132-TURN "stalls at 'the ring
  point carries a witnessed cycle'" (0.40) — the branch that occurred.

## Stage 3 — SAVED
