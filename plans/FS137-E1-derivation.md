# FS137-E1 — what a ring can afford at six: the opening, and the six first claims (the deriver's record)

*Job FS137-E1 (Ephodos; brief `data/fs137/briefs/FS137-E1-opening.md`; plan `plans/FS137-the-ring-budget.md`; scripts and
outputs `data/fs137/e1/`). Opened 2026-10-07 (UTC). **Every statement in this record is about weak colourings that already
have labelled corners at named points; no weak six-colouring is known to have one, and nothing here fixes or bears on the
value of χ(ℝ²).** Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS137-E1-derivation.md`, from `plans/`.*

## Theorems this phase proved

*(Filled stage by stage; each line: the entry, its verdict and grade, its address below.)*

- Stage 0, Stage 1: none (readback; the opening).

## Stage 0 — SAVED: the readback, and the kernel lane's relay

### 0.1 The brief's quotations

`data/fs137/e1/quote_check.py` (copied from `data/fs136/e2/quote_check.py`, the brief's path changed): every line of every
quotation in the brief is found verbatim in the file its source line names — `quotations=15 mismatches=0`
(`data/fs137/e1/quote_check.out`); with one character of the first quotation altered it exits 1
(`quote_check.fault.out`: `mismatches=1`). No mismatch: no finding about the brief.

### 0.2 What was read, and how far

| source | read |
|---|---|
| the brief; `plans/STANDING-RULES.md` | whole |
| `plans/STUB-collars.md` | whole (the card, both forms, the six first claims, the registered numbers, the stop) |
| `data/fs137/claims.md`; `plans/FS137-close-inventory.md` | whole |
| `plans/FS136-derivation.md` | head; §§ 1–2 whole (C136-TABLE, -COVER, -ONE, -CORNERS, -CLASS, -FORCED, -CLOSE, -COLLAR and their controls); § 4 whole (the stops); §§ 3, 5–7 not read beyond their headings |
| `data/fs136/e2/closure.py` | whole — the engine; copied unchanged to `data/fs137/e1/engine.py` (`cmp` identical) and imported from there |
| `data/fs136/e2/out/bowtie12.txt` | the seed lines and the scan of both unit circles |
| `plans/POROS-2026-10-07-fs136-derived.md` | § 0.3 (the hunches H-a … H-d), § 0.4 (its expectations), §§ 2.1–2.3 (the reframe, the choice, the stop); the rest by headings |
| `plans/FS116-derivation.md` ll. 635–671 and `plans/FS116-N2-proof.md` § 2.1–2.3 | FS116-N2-SIXRING and FS116-N2-FIVERING: statements, *uses only*, and **both arguments whole**; -N2-STAR, -N2-RECIP, -N2-ANTI: arguments read |
| `plans/FS124-derivation.md` C124-BOTH | statement, *uses only*, *not claimed*, prior art; its argument in `FS124-E2-derivation.md` **not read** |
| `plans/FS112-derivation.md` FS112-N3-COR3 | statement only |
| `plans/FS114-derivation.md` (route T) | FS114-N2-ENDS and -N2-FIVE statements; `plans/STUB-route-t-count.md` by its frontier line only |
| `plans/SEARCH-QUEUE.md` | lines 15–21 |

### 0.3 The relay from the kernel lane (FS136-K1, by the coordinator, mid-stage) — how it changes this job

Received while reading; addressed before anything else was written. The four statements this job stands on (C136-TABLE,
the two counts, the label half of C136-FORCED) are kernel-checked on a branch by routes found blind; C136-CLASS, the
collar and the rest of C136-CORNERS are typed, not proved. Its findings 5–8, and what each does here:

- **Finding 8 — "Purity at w is necessary for a label to be present on a side, not sufficient."** Accepted, and it is how
  every claim below is to be read: a **palette is an upper bound** — the labels the table leaves possible on a side at
  `w` — and says of no label that it is present. The only lower bound available anywhere in this job is the trivial
  one: almost every point has *some* label, so a side whose palette is one label has it (C136-FORCED) and a side whose
  palette is empty is in no domain. Every count below is therefore of the form "what is present ⊂ what a palette
  allows" plus "something is present"; **no statement here says a label of a palette occurs.** Each *not claimed* line
  says so. The two-discs example is the tangent case, where a class is decided by curvature: it sits at the end points
  of windows, a finite set of directions, so the lengths in C137-BUDGET are unaffected, and C137-SIXTY and C137-OWN are
  stated at single directions through C136-FORCED, which reads the table at `w` only.
- **Finding 6** (the collar holds for any connected subset of `S(x) ∩ U`): C137-OWN is stated at that form.
- **Finding 5** (the second sentence of the forward step on the open set `T`) and **finding 7** (`ρ ≤ ρ₀` is
  load-bearing in C136-CORNERS): no claim of this job reads either; C137-MEET is stated on the cell (the set of points
  on chosen sides), which needs no connectedness.
- Nothing in the relay changes the claim list or the order of work.

### 0.4 Two things seen in the readback, before any derivation (each is taken up at its claim)

1. **The card's count has a pointwise form.** For corners filling a neighbourhood of `x` and a direction `θ` whose
   tangent directions `θ ± 90°` are not edge directions, the tangent line at `x` to `S(x + e(θ))` passes through exactly
   two corners (one, if a corner is reflex); every other corner is inner or outer. So the number of pure labels is
   `m − 2` at **every** such direction, not on average — the saved scan of `q₂` reads 3 = 5 − 2 on each of its ten arcs
   (`data/fs136/e2/out/bowtie12.txt`: inner 2,1,2,1,0,1,2,1,2,3 and outer 1,2,1,2,3,2,1,2,1,0 own labels). Claim 1 is taken
   at that form.
2. **"Whatever the corners" fails for a label with two corners.** The card's bound is by the number of corners `c`; by
   the number of labels `m` it is false when a label repeats at the point (`a, c, b, c` in cyclic order: both `a` and `b`
   pure on open sets of directions, windows summing to more than `180°·(m − 2)`). The mean `k − 1 − m/2` is for
   one-corner labels only. Claim 1's statement says which.

## Stage 0 — SAVED

## Stage 1 — SAVED: the opening, and the six statements as the verdicts will be about them

### 1.1 The opening

The plan is `plans/FS137-the-ring-budget.md`: §G (thirteen entries bear, two are falsifiable here and registered; the
silent list; what the walk changed), §PA (each claim's held map entry read at its source; nine derivation files grepped
for the count under other words; zbMATH in two disciplines' words — not found), §IQ (both forms verbatim; the
invariant: *exactly two corners cross, and a crossing corner's label is absent across*), the routes, the stages, the
failure clauses and six registered predictions. One finding of §PA changes a *restates* line of the card: **the
one-corner step of claim 1 is held for maps as the cone lemma** (`plans/FS116-derivation.md` l. 891; ledger row 138's
cone form) — what is not held is the count over directions.

### 1.2 Notation, stated once (for the claim list)

*Beside the definitions of `data/fs136/claims.md` (a corner; a labelled corner; a colouring *has* one; inner, outer and
crossing at a point one unit away; inner-pure and outer-pure).*

- `e(θ)` is the unit vector of direction `θ`. The **cone** of a corner `(x; γ₁, γ₂)` is the closed arc of directions
  swept counter-clockwise from the direction of `γ₁` at `x` to that of `γ₂`: one direction if the two agree and `γ₁`
  comes before `γ₂` in the order by signed curvature (a *cusp*), every direction if they agree and `γ₂` comes first. Its
  **angle** is the length of its cone, from 0° to 360°.
- A finite set `F` of labelled corners at `x` **fills a neighbourhood of `x`** if it has at least two corners and, for
  some `ρ > 0`, the parts of its corners within `ρ` of `x` are pairwise disjoint and cover `B(x, ρ)` but for `x` and the
  corners' curves. Those curves are the **edges** of `F`; there are as many as corners. (The engine's `full`.)
- A corner at `x` is **inner**, **outer** or **crossing at the direction `θ`** if it is so at the point `x + e(θ)`; a
  label of `F` is **inner-pure** (**outer-pure**) **at `θ`** if every corner of `F` with that label is inner (outer) at `θ`.
- `θ` is **generic for `F`** if neither `θ + 90°` nor `θ − 90°` is the direction at `x` of an edge of `F`.
- For `|w − x| = 1`, an edge of `F` **lies along `S(w)`** if near `x` it is an arc of the unit circle about `w`: in
  C136-CLASS's order it is equal to one of the two branches of `S(w)` at `x`.

### 1.3 The six statements, verbatim, each with its *not claimed* line (sent to the coordinator from here)

**C137-BUDGET.** *Statement:* Plane geometry; no colouring. Let F be a finite set of labelled corners at x that fills a neighbourhood of x, c its number of corners, m its number of labels, and θ a direction generic for F. If one cone of F contains both θ + 90° and θ − 90°, that corner is crossing at θ and the other corners of F are all inner at θ or all outer at θ. Otherwise two corners of F are crossing at θ — those whose cones contain θ + 90° and θ − 90° — and each of the other c − 2 is inner at θ or outer at θ. The corners of F inner at θ are the corners of F outer at θ + 180°. Hence, if every corner of F has angle at most 180°: at every generic θ the number of labels inner-pure at θ plus the number outer-pure at θ is at most c − 2, and it is m − 2 if F has one corner for each label; the sets of directions at which the labels of F are inner-pure have lengths that sum to at most 180°·(c − 2), and to 180°·(m − 2) if F has one corner for each label; and then, among k labels in all, the number of labels that are labels of no corner of F or inner-pure at θ has mean k − 1 − m/2 over θ.
*Not claimed:* anything about a colouring; that a label counted here is present on that side in any colouring (a palette is an upper bound: the kernel lane's finding 8); the bound by the number of labels when a label has two corners — with corners a, c, b, c in cyclic order of angles 10°, 170°, 10°, 170° the labels a and b are both pure wherever the two c's hold the tangent directions, and the three labels' sets of directions sum to 340°, more than 180°·(3 − 2); the classes at the finitely many directions that are not generic (curvature decides them: C136-CLASS), so nothing about which end points a set of directions contains; that the card's "one label fewer at six than at seven" is more than the identity that the same corners leave k − m labels absent.

**C137-THREE.** *Statement:* Plane geometry; no colouring. Let F be a finite set of labelled corners at x that fills a neighbourhood of x, θ a direction, w = x + e(θ), and s the number of the two branches of S(w) at x that are edges of F. Then at most 2 − s corners of F are crossing at θ. If s = 0 and F has a corner inner at θ and a corner outer at θ, then two corners of F are crossing at θ and F has at least four corners. So if F has three corners, and one label of F is inner-pure at θ and another outer-pure at θ, an edge of F lies along S(w).
*Not claimed:* anything about a colouring; that an edge along S(w) gives an inner-pure and an outer-pure label (it makes no corner beside it crossing; the labels beside it may recur at other corners); the case of three labels on four corners — a, c, b, c in cyclic order, the two c's holding the tangent directions, has a inner-pure and b outer-pure on an open set of directions and no edge along any unit circle; anything for edges that are not rays or circular arcs; that C124-BOTH or FS112-N3-COR3 follows from this alone (each also needs a count that makes both members separate).

**C137-SIXTY.** *Statement:* About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, and ℓ a label. Let N_in be the set of directions θ at which every label other than ℓ is the label of a corner of F that is not inner at θ, and N_out the same set with "outer" for "inner". If θ and θ + 60° both lie in N_in ∪ N_out, then U does not contain both x + e(θ) and x + e(θ + 60°). Hence, if U contains S(x): an arc of directions contained in N_in, or in N_out, has length at most 60°; N_in has total length at most 120°, and so has N_out; and if F fills a neighbourhood of x and its labels are all the labels but ℓ, the cones of any two adjacent corners of F span at most 240° together.
*Not claimed:* that a weak colouring has such corners; that a label of a palette is present anywhere; anything for two directions 60° apart at which different labels are forced (FS116-Y2-SIXFRAG's centre: six directions 60° apart, six labels); anything when U misses one of the two points — at FS114-Y2-BOWTIE's five-label points the arcs are exactly 60° and their end directions are not in N_in; that N_in is non-empty for a given F; that 120° is attained (no object held attains it; the card's 180° is not the best); the map entry FS116-N2-FIVERING's conclusion, which is about arcs of the boundary on the ring and says more for maps.

**C137-OWN.** *Statement:* About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, ℓ a label, and A a connected subset of S(x) ∩ U such that at every point w of A every label other than ℓ is the label of a corner of F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V; and every corner of F with the label ℓ is inner at every point of A. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x), and every corner of F with the label ℓ is outer at every point of A.
*Not claimed:* that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing; anything at a point of the closure of A that is not in A; **that a set A of more than one point exists on any held object when ℓ is a label of F — none is held** (FS116-Y2-SIXFRAG's centre gives six single points, R7's lattice points none; the arcs of FS114-Y2-BOWTIE are C136-COLLAR's, with ℓ absent); that V and the corner of F with the label ℓ belong to one piece (the map entry FS116-N2-SIXRING says so, in the non-Siamese class); what V bars one unit further on.

**C137-MEET.** *Statement:* About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_n (n ≥ 1) distinct points with |x_i − w| = 1, F_i a finite set of labelled corners at x_i that c has, and σ_i a side of S(x_i), inside or outside. Let Π_i be the set of the labels that are labels of no corner of F_i, together with the labels of F_i that are inner-pure at w if σ_i is inside and outer-pure at w if σ_i is outside. Then there is η > 0 such that almost every point of B(w, η) lying on the side σ_i of S(x_i) for every i has a label in Π_1 ∩ … ∩ Π_n. So if n = 2, the labels of F_1 are all the labels but a, those of F_2 all the labels but b, a ≠ b, and for every η > 0 some point of B(w, η) lies on the side σ_1 of S(x_1) and on the side σ_2 of S(x_2), then a is in Π_2, or b is in Π_1, or some label of both F_1 and F_2 is in Π_1 and in Π_2.
*Not claimed:* anything beyond C136-TABLE, of which this is a rewording in the words of the card — no new mathematics; that a label of Π_1 ∩ … ∩ Π_n is present; that a non-empty intersection gives a colouring; that the three alternatives exclude one another; the card's reading that "neither outer arc lies whole in any domain" (it is C136-STOP-GERMS-RADIUS's, not re-derived here).

**C137-RING.** *Statement:* About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point of U, F a finite set of labelled corners at x that c has and that fills a neighbourhood of x, y a point with |y − x| = 1, and G a finite set of labelled corners at y that c has. Then no corner of F that is crossing at y has the label of a corner of G. Hence, if F has one corner for each of its labels and every corner of F has angle less than 180°: G has at most k − 2 + s labels, s being the number of the two branches of S(y) at x that are edges of F; and for distinct points y_1, …, y_n of S(x) and finite sets G_j of labelled corners at y_j that c has, the numbers of labels of the G_j sum to at most (k − 2)·n + a, where a is the number of edges of F that lie along the unit circle about one of the y_j, and a is at most the number of labels of F.
*Not claimed:* that a weak colouring has corners anywhere; **an exclusion of every labelled ring at six — the count is met at six by many assignments (seven points on straight two-label edges meet it with room), so it is not the inequality "no assignment meets at six" that the card asks for**; that a ring meeting the count exists as a colouring, or fits at first order; the count for a label with two corners at x (the bound is then by the distinct labels of the crossing corners, at least one); anything at a point of the ring where the colouring has no corners; the sum over the points of a lattice patch beyond the centre's own ring; a value of the chromatic number of the plane — with it, the announcement rule's sentence: it would bear on seven only with a statement that every weak six-colouring has such points, which nobody holds.

## Stage 1 — SAVED

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh) on the six claims

**The stall read.** None of the six is stalled; the dispatch conditions that apply are two: *a result proved only at
instances* (the card's count was checked by hand at two vertex figures) and *a known theorem that almost applies* (each
claim has a map entry beside it). So the work is the cut — what determines, what accompanies — and the home.

**For a stranger** (a convex geometer; nothing of this project's words). *At a point `x` of the plane finitely many
sectors meet, each bounded by two curves leaving `x` (rays or circular arcs) and each carrying a label; together they
fill a neighbourhood of `x`. For a unit vector `e`, call a sector* near *if its part close to `x` lies in the closed
unit disc about `x + e`,* far *if it misses the open disc,* cut *otherwise. Unknown: for each `e`, how many sectors are
near, far and cut; what the sets of directions in which a sector is near add up to; and, when sectors also meet at
`y = x + e` and two points at distance exactly 1 almost never share a label, a relation between the labels at `x` and at
`y`.* A reader stops at no word but "label"; struck: palettes, windows, collars, rings, pay.

**This is a** complete fan of cones in the plane, and "near in the direction `e`" is, off finitely many directions,
"`e` lies in the cone's dual". The disc about `x + e` enters only through its tangent line at `x`; a cone `C` lies in the
half-plane `{d : d·e ≥ 0}` exactly for `e` in the dual cone `C* = {e : d·e ≥ 0 for every d in C}`, of angle `180° −` the
angle of `C`. What the home holds, each elementary and proved in the argument below rather than cited: a line through
the apex of a complete fan meets the interiors of exactly two cones unless a cone is reflex; the duals of the cones of a
complete fan with `c` cones, none reflex, have angles summing to `180°·(c − 2)` — **the interior-angle sum of the convex
`c`-gon whose normal fan the vertex figure is**; the dual of a union of cones is the dual of their convex hull.

**The features, sorted, each with its receipt.**

| feature | sort | receipt |
|---|---|---|
| the number `k` of labels | accompanies claims 1, 2; enters only as `k − m` labels absent | the argument of claim 1 never reads `k`; control `budget-scan` prints the same pure counts at seven (R7) and at six (the bowtie fragment) — `m − 2` on every arc |
| one corner for each label | **determines** the count by labels (split: what is consumed is "the corners that are not crossing carry distinct labels with no other corner") | the fan `a, c, b, c` of angles 10°, 170°, 10°, 170°: 340° against `180°·(3 − 2)` (control `budget-repeat`) |
| every angle at most 180° | **determines** "two cross" | a reflex cone holds both tangent directions: one crossing corner (control `budget-repeat`, its second line) |
| the fan fills a neighbourhood | determines claims 1, 2 and 6's count; accompanies claim 3's first sentence, 4 and 5 | their arguments apply C136-FORCED or C136-TABLE to the corners that are there |
| the far circle has radius 1 | accompanies claim 1 (only its tangent line is read); **determines** claim 3 (60° is one unit) and claim 6 (an edge along a unit circle has one centre) | claim 1's argument; in claim 6 the step "each edge is counted once" |
| edges are rays or circular arcs (curvature) | accompanies every length in claim 1; determines the class at the two tangent directions (claim 2's "lies along") | C136-CLASS; the engine's fault `bend` |
| the forced label is absent at `x` (C136-COLLAR) | accompanies | C136-FORCED's hypothesis never asks it (claim 4) |
| the arc is open, is an arc | accompanies | the kernel lane's finding 6; claim 4's argument |
| the corners at the far point fill a neighbourhood | accompanies claim 6 | only "a corner of `G` has that label" is read |
| `x` lies in the domain | **determines** claim 6's first sentence | it is the table at the point `x` |
| the ring points are 60° apart (the lattice family) | accompanies claim 6's count (any finite set of ring points); determines only what two ring points one unit apart, or two antipodal ones, add | the sum's argument reads no angle between the `y_j` |

**Homes, each with its dictionary and its test.**

1. *Convex geometry: dual cones of a complete planar fan* — adopted for claims 1 and 2. Dictionary: corner ↔ cone;
   inner at `θ` ↔ `e(θ)` in the interior of the dual; window ↔ dual cone; a label with several corners ↔ the convex hull
   of its cones; the windows' sum ↔ the interior-angle sum of the polygon with that normal fan. *Tests*: the proofs
   apply at once (one line each); the exception vanishes (the card's "at most … with equality exactly when" becomes one
   identity for hulls: a label's window has length `max(0, 180° − h)`, `h` the angle of the hull of its cones — one
   mind's remark, **not an entry**); it predicts a neighbour, checkable: at a generic direction the two crossing corners
   are the two holding the tangent directions, so the pure count is `m − 2` on **every** arc of a scan, not on average —
   read on ten of ten arcs at `q₂` before any argument (Stage 0.4). One step changes: at the two tangent directions the
   dual is decided by curvature, not by the fan (C136-CLASS).
2. *This project's ring calculus for maps* (FS116-N2-STAR, -ANTI; N-E1) — adopted for claim 6's first sentence.
   Dictionary: tile of `p` ↔ corner of `F`; "cone holds `ψ ± 90°` in its interior" ↔ crossing at a generic direction;
   "its colour is in `A(y)`" ↔ the label of no corner of `G`; a hub ↔ any cornered point of the ring; N-E1 ↔ C136-TABLE
   at the point `x` with the member `y`. *Changed step*: STAR's "one tile per colour at `y`" (non-Siamese) is not
   available and not needed; the sum over the ring, with one unit-arc edge charged to its centre, is not in the map
   entries.
3. *List colouring of the ring's 60° graph* (the asking lane's recognition) — **killed for derivation** at one line of
   its dictionary: "a colour of the list may be used" has no counterpart — a palette is an upper bound (the kernel
   lane's finding 8), so a list colouring of the ring is a design, never a colouring. It stays the frame of the search
   lane's line 21.
4. *Counting tiles by Euler's formula* (route T, FS114-N2-ENDS) — **killed** for this count: its dictionary has no line
   for a direction at a point or for a point of a ring, and it needs a map (G86).

**The class.** Claims 1–2: complete fans of corners at a point, any number of corners and labels; no colouring. Claims
3–5: every weak `k`-colouring with the named corners, any `k`. Claim 6: the same, any finite set of cornered points on
the ring. **Recognition does not differ from the plan's route A**; it adds the name (dual cones; the polygon's angle
sum), which is why the count is exact pointwise and why a repeated label breaks it.

## Stage 2 — SAVED

## Stage 3 — SAVED: claim 1, C137-BUDGET — derived

**Verdict: derived, at a pointwise form; two of the card's sentences corrected.** *What is new beyond the held entry*:
the one-corner step is the map class's cone lemma (plan §PA); the count — exactly two corners cross at every generic
direction, hence `m − 2` pure labels there and `180°·(c − 2)` in all — was not found held or in print. *Class*: plane
geometry, any fan of corners. *Reads* corners somebody keeps; *forces* nothing; *excludes* nothing. *Side*: neither.
**Corrections to the card**: (i) "whatever the corners" — the bound by labels fails when a label has two corners at the
point (control `budget-repeat`: 314.76° against 180°); (ii) "one label fewer on every side of every ring" is the identity
that the same corners leave `k − m` labels absent, and no more.

derivation: C137-BUDGET
  statement: Plane geometry; no colouring. Let F be a finite set of labelled corners at x that fills a neighbourhood of x, c its number of corners, m its number of labels, and θ a direction generic for F. If one cone of F contains both θ + 90° and θ − 90°, that corner is crossing at θ and the other corners of F are all inner at θ or all outer at θ. Otherwise two corners of F are crossing at θ — those whose cones contain θ + 90° and θ − 90° — and each of the other c − 2 is inner at θ or outer at θ. The corners of F inner at θ are the corners of F outer at θ + 180°. Hence, if every corner of F has angle at most 180°: at every generic θ the number of labels inner-pure at θ plus the number outer-pure at θ is at most c − 2, and it is m − 2 if F has one corner for each label; the sets of directions at which the labels of F are inner-pure have lengths that sum to at most 180°·(c − 2), and to 180°·(m − 2) if F has one corner for each label; and then, among k labels in all, the number of labels that are labels of no corner of F or inner-pure at θ has mean k − 1 − m/2 over θ.
  uses only: that a point of a curve from x of direction d at distance t from x is x + t·d + O(t²), so its squared distance from x + e(θ) is 1 − 2t·(d·e(θ)) + O(t²); that the cones of a set of corners filling a neighbourhood cover the circle of directions with disjoint interiors; that an arc of directions containing neither θ + 90° nor θ − 90° lies in one of the two open half-turns they bound; that an arc containing both in its interior is longer than 180° and its complement lies in one open half-turn. Not consumed: any colouring; the number of labels (it enters the last clause as k − m labels of no corner); the radius of the far circle (only its tangent line at x); the curvature of any edge (it decides the classes at the finitely many directions that are not generic and nothing else)
  not claimed: anything about a colouring; that a label counted here is present on that side in any colouring (a palette is an upper bound: the kernel lane's finding 8); the bound by the number of labels when a label has two corners — with corners a, c, b, c in cyclic order of angles 10°, 170°, 10°, 170° the labels a and b are both pure wherever the two c's hold the tangent directions, and the three labels' sets of directions sum to 340°, more than 180°·(3 − 2); the classes at the finitely many directions that are not generic (curvature decides them: C136-CLASS), so nothing about which end points a set of directions contains; that the card's "one label fewer at six than at seven" is more than the identity that the same corners leave k − m labels absent
  argument: § Argument — two corners cross
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point — six corners (three of 120°, three cusps), six of seven labels: on each of the six arcs between critical directions two corners cross and four labels are pure, the windows sum to 720° = 180°·4 and the mean is 3; FS114-Y2-BOWTIE at q₂ — cones 30°, 120°, 120°, 6.9°, 83.1°: 150° + 60° + 60° + 173.1° + 96.9° = 540° = 180°·3, mean 2.5 (control `budget-scan`: those two, the fragment's three other five-label points, the flower's centre and every vertex of the strip and the disk with three labels or more — 522 arcs, the pure labels m − 2 on each)
  prior art: partly: for one corner it is the map class's cone lemma ("that a tile of p in B̄(y, 1), or missing B(y, 1), has its cone in the closed half-plane facing y", `plans/FS116-derivation.md` l. 891; ledger row 138's cone form) and at a hub it is inside FS116-N2-STAR (one mind); the count over directions: not found in nine derivation files (plan §PA item 1: "half-plane" 19 hits, none a count; "angle sum" 0; "sum of the angles" 0) nor in print — zbMATH "ab:"chromatic number of the plane" & ab:vert* & (ab:angle* | ab:"angle sum")" (1, a general introduction), "ab:discharging & (ab:"unit distance" | ab:"chromatic number of the plane")" (1, another object); as plane geometry it is elementary (the duals of the cones of a complete fan; the interior angles of a convex polygon sum to 180°·(c − 2)), no source read and nothing rests on one
  handoff: de Bruijn — the first three sentences, for corners bounded by rays (cones of directions; the kernel needs no curvature for generic θ); the count as a corollary. Read "generic" back against "neither tangent direction is an edge direction", and the lengths' clause against "one corner for each label"

control: budget-scan
  of: C137-BUDGET — the scan of whole unit circles, summed, exact classes: R7 at one lattice point; FS114-Y2-BOWTIE at its four five-label points; FS116-Y2-SIXFRAG's centre; every vertex with three labels or more of FS-112's strip (50) and of the disk (30). One exact direction per open arc between critical directions. violations = arcs on which the crossing corners are not two, or the pure labels exceed c − 2, or differ from m − 2 with one corner per label; antipode-mismatches = corners inner at θ and not outer at θ + 180°; the windows' sum against 180°·(c − 2) (lengths in floats); fl = every class re-read by sampling. Tight: R7 and the fragment have no margin. The fault reads the first corner at each vertex as crossing wherever it is inner
  run: python3 ../data/fs137/e1/budget.py scan
  expect: r7: k=7 vertices=1 (labels>=1) arcs=6 violations=0 antipode-mismatches=0 | one-corner-per-label=1 pure-per-arc-minus-(m-2)=[0] | windows-sum-minus-180(c-2)=[0.0] | windows-sums=[720.0] mean-palette(one-corner)=[3.0] | fl=72 mismatches=0
    bowtie: k=6 vertices=4 (labels>=5) arcs=40 violations=0 antipode-mismatches=0 | one-corner-per-label=4 pure-per-arc-minus-(m-2)=[0] | windows-sum-minus-180(c-2)=[0.0] | windows-sums=[540.0] mean-palette(one-corner)=[2.5] | fl=472 mismatches=0
    flower: k=6 vertices=1 (labels>=6) arcs=6 violations=0 antipode-mismatches=0 | one-corner-per-label=1 pure-per-arc-minus-(m-2)=[0] | windows-sum-minus-180(c-2)=[0.0] | windows-sums=[720.0] mean-palette(one-corner)=[2.0] | fl=544 mismatches=0
    strip: k=6 vertices=50 (labels>=3) arcs=280 violations=0 antipode-mismatches=0 | one-corner-per-label=50 pure-per-arc-minus-(m-2)=[0] | windows-sum-minus-180(c-2)=[0.0] | windows-sums=[180.0, 360.0] mean-palette(one-corner)=[3.0, 3.5] | fl=2304 mismatches=0
    disk: k=6 vertices=30 (labels>=3) arcs=190 violations=0 antipode-mismatches=0 | one-corner-per-label=30 pure-per-arc-minus-(m-2)=[0] | windows-sum-minus-180(c-2)=[0.0] | windows-sums=[180.0, 360.0] mean-palette(one-corner)=[3.0, 3.5] | fl=3524 mismatches=0
  fault: python3 ../data/fs137/e1/budget.py scan --fault=cross

control: budget-repeat
  of: C137-BUDGET — what the statement does not claim, on fans by formula (straight sectors on rational rays): a, c, b, c with c twice — the windows sum to 314.76°, above 180°·(m − 2) = 180° and below 180°·(c − 2) = 360°; a reflex corner of 270° — 270°, above 180°·(c − 2), with one crossing corner on some arcs; and the same four rays with four labels — exactly 360°, two pure labels on every arc. The fault reads the first corner as crossing wherever it is inner
  run: python3 ../data/fs137/e1/budget.py repeat
  expect: a,c,b,c (c twice): corners=4 labels=3 all-angles<=180=True windows-sum=314.7603 180(c-2)=360 180(m-2)=180 pure-per-arc=[0, 2] violations=0
    reflex (270, 45, 45 degrees): corners=3 labels=3 all-angles<=180=False windows-sum=270.0000 180(c-2)=180 180(m-2)=180 pure-per-arc=[1, 2] violations=0
    control: four labels, the same four rays: corners=4 labels=4 all-angles<=180=True windows-sum=360.0000 180(c-2)=360 180(m-2)=360 pure-per-arc=[2] violations=0
  fault: python3 ../data/fs137/e1/budget.py repeat --fault=cross

### Argument — two corners cross

Let `C` be a corner at `x` with cone `K`, `θ` a direction, `w = x + e(θ)`, and `H = {d : d·e(θ) > 0}` the open half-turn
about `θ`; its two ends are the tangent directions `θ ± 90°`.

1. *One corner.* A point of a curve from `x` of direction `d`, at distance `t`, is `x + t·d + O(t²)`, at squared distance
   `1 − 2t·(d·e(θ)) + O(t²)` from `w`. Every point of `C` within `ρ` of `x` lies between its two curves, so its direction
   from `x` is within `o(1)` of `K` as `ρ → 0`. Hence: if `K ⊂ H`, the points of `C` near `x` are strictly inside `S(w)`
   and `C` is inner at `θ`; if `K ⊂ −H`, `C` is outer; and if `K` has a direction `d` with `d·e(θ) < 0` and one with
   `d·e(θ) > 0`, `C` has points strictly outside and strictly inside `S(w)` at every radius and is crossing. When
   neither tangent direction is the direction of an edge of `C`, one of the three holds: an arc with neither end at a
   tangent direction lies in `H`, lies in `−H`, or has a tangent direction in its interior.
2. *The fan.* The cones of `F` cover the circle and have disjoint interiors (the parts of the corners near `x` are
   disjoint and cover a punctured disc but for the edges). Let `θ` be generic. Each tangent direction is then interior
   to exactly one cone. If one cone holds both, it is longer than 180° and its complement is an arc inside `H` or inside
   `−H`; every other cone lies in that complement, so by step 1 the other corners are all inner or all outer, and the
   one is crossing. Otherwise the two cones holding the tangent directions are crossing, and each other cone, an arc
   holding neither, lies in `H` or in `−H`: `c − 2` corners, each inner or outer.
3. *The antipode.* `K ⊂ H` for `θ` is `K ⊂ −H` for `θ + 180°`, which is generic when `θ` is: the corners inner at `θ` are
   the corners outer at `θ + 180°`.
4. *The counts.* Let every angle be at most 180°. A cone holding both tangent directions in its interior is longer than
   180°, so at a generic `θ` exactly `c − 2` corners are inner or outer. A label is pure only if all its corners are on
   one side, so distinct pure labels use distinct corners among those `c − 2`: at most `c − 2` pure labels; with one
   corner for each label, the pure labels are the labels of those `c − 2 = m − 2` corners. The non-generic directions
   are finitely many. So `Σ_ℓ |{θ : ℓ inner-pure}| = ∫ #inner-pure = ∫ #outer-pure` (step 3) `= ½ ∫ (#inner-pure +
   #outer-pure) ≤ 180°·(c − 2)`, with equality for one corner per label; the mean of `(k − m) + #inner-pure` is then
   `k − m + (m − 2)/2 = k − 1 − m/2`. ∎

*Read in the home's words (Stage 2)*: the set of directions at which one corner of angle `α ≤ 180°` is inner is the dual
of its cone, an arc of `180° − α` about its bisector, and `Σ (180° − α_i) = 180°·c − 360°`. *A remark, one mind, not an
entry*: a label with several corners is inner-pure where the half-turn holds the hull of its cones, so its set of
directions has length `max(0, 180° − h)`, `h` the hull's angle; `budget-repeat`'s first line is `h = 337.4°` for `c`.

**Theorems this stage proved**: C137-BUDGET — derived, [hand], one mind; kernel pending.

## Stage 3 — SAVED
