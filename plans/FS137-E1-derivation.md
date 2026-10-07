# FS137-E1 — what a ring can afford at six: the opening, and the six first claims (the deriver's record)

*Job FS137-E1 (Ephodos; brief `data/fs137/briefs/FS137-E1-opening.md`; plan `plans/FS137-the-ring-budget.md`; scripts and
outputs `data/fs137/e1/`). Opened 2026-10-07 (UTC). **Every statement in this record is about weak colourings that already
have labelled corners at named points; no weak six-colouring is known to have one, and nothing here fixes or bears on the
value of χ(ℝ²).** Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS137-E1-derivation.md`, from `plans/`.*

## Theorems this phase proved

*(Each line: the entry, its verdict and grade, its address below. One mind each; kernel pending.)*

- Stages 0–2: none (readback; the opening; recognition).
- **C137-BUDGET** — derived, [hand] — Stage 3, § Argument — two corners cross.
- **C137-THREE** — derived, [derived] from C136-CLASS (inherited) — Stage 4, § Argument — at most 2 − s corners cross.
- **C137-SIXTY** — derived, [derived] from C136-FORCED and C124-SHADOW-OPEN (inherited) — Stage 5, § Argument — two forced sides 60° apart.
- **C137-OWN** — derived, [derived] from C136-FORCED and C136-TABLE (inherited) — Stage 6, § Argument — a forced side along a connected set.
- **C137-MEET** — derived, [derived] from C136-TABLE (inherited); a rewording — Stage 7, § Argument — the table, cell by cell.
- **C137-RING** — **no verdict**: stopped before its stage (§ Stopped at).

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

## Stage 4 — SAVED: claim 2, C137-THREE — derived

**Verdict: derived, as plane geometry at any number of corners.** *Is it the held statement and no more?* For three
corners it is the geometric step of C124-BOTH's second sentence and of FS112-N3-COR3 — "separates ⟹ an edge along the
far circle" — and no more than that step; those entries add a count that makes both members separate, which this
entry does not re-derive (C124-BOTH's argument was not read). *What is new*: the step stated alone, for any number of
corners, with the number `s` of edges along the far circle as an explicit term (crossing corners ≤ `2 − s`); and the
escape it names — three labels on **four** corners separate on open sets of directions with no unit arc (`budget-repeat`,
first line: two pure labels on some arcs). *Class*: plane geometry; corners bounded by rays and circular arcs. *Reads*
kept corners; *forces* nothing; *excludes* nothing by itself. **Consequence for C136-COVER, by the definition of
"separates"**: a member whose family is the parts of three corners filling a neighbourhood separates at `w` only if one
of its edges lies along `S(w)`. **R7 is silent**: it has no three-corner vertex. **The card's control, said exactly**: the
strip's 17 pairs were not read pair by pair; every direction at every three-corner vertex of the strip was (40
vertices, 480 directions), which contains them.

derivation: C137-THREE
  statement: Plane geometry; no colouring. Let F be a finite set of labelled corners at x that fills a neighbourhood of x, θ a direction, w = x + e(θ), and s the number of the two branches of S(w) at x that are edges of F. Then at most 2 − s corners of F are crossing at θ. If s = 0 and F has a corner inner at θ and a corner outer at θ, then two corners of F are crossing at θ and F has at least four corners. So if F has three corners, and one label of F is inner-pure at θ and another outer-pure at θ, an edge of F lies along S(w).
  uses only: C136-CLASS (`plans/FS136-derivation.md` § 2; [hand], one mind, typed and not proved in the kernel — inherited; its statement read, its argument not) — a corner is inner at w when it lies between the branches β₋ and β₊ of S(w) in the cyclic order of curves at x by direction and then signed curvature, outer when it lies between β₊ and β₋; that the corners of a set filling a neighbourhood are the intervals between cyclically consecutive edges in that order; that a branch which is not an edge lies strictly inside one such interval. Not consumed: any colouring; the labels, but for the last sentence
  not claimed: anything about a colouring; that an edge along S(w) gives an inner-pure and an outer-pure label (it makes no corner beside it crossing; the labels beside it may recur at other corners); the case of three labels on four corners — a, c, b, c in cyclic order, the two c's holding the tangent directions, has a inner-pure and b outer-pure on an open set of directions and no edge along any unit circle; anything for edges that are not rays or circular arcs; that C124-BOTH or FS112-N3-COR3 follows from this alone (each also needs a count that makes both members separate)
  argument: § Argument — at most 2 − s corners cross
  verdict: derived
  grade: derived from: C136-CLASS
  minds: 1
  model: FS-112's strip — at each of its 40 three-corner vertices exactly two directions have an inner-pure and an outer-pure label, and at each of those 80 an edge of the vertex lies along the far unit circle; the disk (25 vertices, 30 such directions), FS116-Y2-SIXFRAG (6, 6), FS114-Y2-BOWTIE (4, 4) — control `three-held`
  prior art: partly: C124-BOTH's second sentence ("each has an edge that contains an arc of S(w) with an end at the member"; `plans/FS124-derivation.md` l. 429; one mind; its argument not read by me) and for maps FS112-N3-COR3 (ledger row 135; two minds) hold the case of a close complementary pair of three-piece points with its count; the step alone, at any number of corners: here; print: as C137-BUDGET — not found
  handoff: de Bruijn — only with C136-CLASS in the kernel (it is typed there, not proved); then three lines on a cyclic order. Read "lies along S(w)" back against "is equal, as a curve from x, to a branch of S(w)"

control: three-held
  of: C137-THREE — every three-corner vertex of the four held six-coloured objects (the strip 40, the disk 25, FS116-Y2-SIXFRAG 6, FS114-Y2-BOWTIE 4), every direction (one per open arc between critical directions, and each critical direction), exact classes: crossing>2-s counts directions with more crossing corners than the bound; WITHOUT counts directions with an inner-pure and an outer-pure label and no edge along the far circle (the edge test reads the arc's centre and radius, not the classifier). R7 has no three-corner vertex. The fault is the engine's `bend` (curves ordered by direction only): a straight edge on the tangent then separates
  run: python3 ../data/fs137/e1/budget.py three
  expect: strip: three-corner vertices=40 directions read=480 crossing>2-s:0 | directions with an inner-pure and an outer-pure label=80, with an edge along the far circle=80, WITHOUT=0 | fl=1440 mismatches=0
    disk: three-corner vertices=25 directions read=300 crossing>2-s:0 | directions with an inner-pure and an outer-pure label=30, with an edge along the far circle=30, WITHOUT=0 | fl=2340 mismatches=0
    flower: three-corner vertices=6 directions read=48 crossing>2-s:0 | directions with an inner-pure and an outer-pure label=6, with an edge along the far circle=6, WITHOUT=0 | fl=2484 mismatches=0
    bowtie: three-corner vertices=4 directions read=32 crossing>2-s:0 | directions with an inner-pure and an outer-pure label=4, with an edge along the far circle=4, WITHOUT=0 | fl=2580 mismatches=0
    r7: no three-corner vertex (every lattice point has six corners) - silent
  fault: python3 ../data/fs137/e1/budget.py three --fault=bend

### Argument — at most 2 − s corners cross

Order the curves from `x` cyclically as in C136-CLASS. The edges of `F` are `c` distinct curves, and since `F` fills a
neighbourhood its corners are the `c` open intervals between cyclically consecutive edges. The branches `β₋`, `β₊` of
`S(w)` at `x` are two more curves; each is an edge of `F` or lies strictly inside exactly one corner's interval. The two
branches cut the cyclic order into the closed intervals `[β₋, β₊]` and `[β₊, β₋]`, and by C136-CLASS a corner inside the
first is inner at `w`, one inside the second outer. A corner with no branch strictly inside it lies in one of the two,
so it is inner or outer; hence the crossing corners are among those with a branch strictly inside, at most `2 − s`.

Let `s = 0`. If one corner held both branches strictly inside, its interval would contain `[β₋, β₊]` or `[β₊, β₋]`, and
every other corner would lie in the other: all outer, or all inner. So if some corner is inner and another outer, the
branches lie in two different corners, both crossing (each has curves on both sides of a branch strictly inside it),
and with the inner and the outer one `F` has at least four corners.

Let `F` have three corners, one label inner-pure and another outer-pure at `θ`. Each label has a corner, so `F` has an
inner and an outer corner; by the last paragraph `s ≥ 1`: a branch of `S(w)` is an edge of `F`. ∎

**Theorems this stage proved**: C137-THREE — derived from C136-CLASS (inherited, one mind), one mind; kernel pending.

## Stage 4 — SAVED

## Stage 5 — SAVED: claim 3, C137-SIXTY — derived, stronger than posed

**Verdict: derived.** Against the card: (i) at single directions, not interiors; (ii) for either side at either point —
inside at `θ` and outside at `θ + 60°` is excluded too; (iii) for any label `ℓ`, absent or the point's own; (iv) hence
with the whole ring in the domain the forced set has total length at most **120°**, not 180°. *What is new beyond
FS116-N2-FIVERING's second clause* (read whole: "If r(θ) and r(θ + 60°) were both such points, r(θ + 60°) would carry X
while N-E1 … or FS116-N1's L1 … excludes X there"): the class (no map, no disc about the point; the hypothesis is a
palette of one label, read direction by direction) and the bound 120°; **what is less**: the map entry concludes that
arcs of the boundary lie along the ring over at least 180°, which nothing here gives — where the palette holds an own
label, no statement says the label is there. *Reads* kept corners; *excludes* vertex figures: a point lacking one label,
its whole ring in the domain, has no two adjacent corners spanning more than 240°. *Side*: both. **Tight on the held
object**: at each of the bowtie fragment's four five-label points the forced arc is exactly 60°, its two end directions
are not in the set, and both end points are in the fragment — the control passes with nothing to spare.

derivation: C137-SIXTY
  statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, and ℓ a label. Let N_in be the set of directions θ at which every label other than ℓ is the label of a corner of F that is not inner at θ, and N_out the same set with "outer" for "inner". If θ and θ + 60° both lie in N_in ∪ N_out, then U does not contain both x + e(θ) and x + e(θ + 60°). Hence, if U contains S(x): an arc of directions contained in N_in, or in N_out, has length at most 60°; N_in has total length at most 120°, and so has N_out; and if F fills a neighbourhood of x and its labels are all the labels but ℓ, the cones of any two adjacent corners of F span at most 240° together.
  uses only: C136-FORCED (`plans/FS136-derivation.md` § 2; [hand], one mind; its label half kernel-checked on a branch — inherited, read whole) with the one member x at each of the two points; C124-SHADOW-OPEN (`plans/FS124-derivation.md` § 2; [hand], one mind — inherited, read at its statement); that for every choice of sides and every η > 0 the one-sided parts of B(x + e(θ), η) and B(x + e(θ + 60°), η) hold two points at distance 1 (an implicit function at a transversal zero); for the lengths, C137-BUDGET's first step for one corner (a corner inner at θ has its cone in the closed half-turn about θ; off finitely many directions it is inner at θ when it is outer at θ + 180°). Not consumed: the number of labels; that F fills a neighbourhood, but for the last clause; that ℓ is absent at x
  not claimed: that a weak colouring has such corners; that a label of a palette is present anywhere; anything for two directions 60° apart at which different labels are forced (FS116-Y2-SIXFRAG's centre: six directions 60° apart, six labels); anything when U misses one of the two points — at FS114-Y2-BOWTIE's five-label points the arcs are exactly 60° and their end directions are not in N_in; that N_in is non-empty for a given F; that 120° is attained (no object held attains it; the card's 180° is not the best); the map entry FS116-N2-FIVERING's conclusion, which is about arcs of the boundary on the ring and says more for maps
  argument: § Argument — two forced sides 60° apart
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: FS114-Y2-BOWTIE, a weak six-colouring of its disc that has the five corners at q₂ = (√3/2, −1/2): for ℓ = 4, N_in is the open arc (150°, 210°) and N_out the open arc (330°, 30°), each exactly 60°; no two of their directions are 60° apart, the end points (0, 0) and (0, −1) of the first arc are both in the fragment, and the end directions are in neither set; the same at its three other five-label points (control `sixty-forced`)
  prior art: partly: for maps FS116-N2-FIVERING, second clause (`plans/FS116-derivation.md` l. 655, `plans/FS116-N2-proof.md` § 2.1; [hand], one mind, Siamese pairs allowed) — the same step, with "not on a (Q) arc" where this has "the palette is one label", and total length 180° where this has 120°; the asking lane's H-a (`plans/POROS-2026-10-07-fs136-derived.md` § 0.3) is the first clause for interiors of arcs; print: as C136-FORCED's line and plan §PA item 2 — not found
  handoff: de Bruijn — the first sentence on cells: at each point the label half of C136-FORCED (kernel-checked on a branch) with one member, then one use of the open-set lemma and one explicit unit pair; the lengths only with a consumer

control: sixty-forced
  of: C137-SIXTY — the sets N_in and N_out of every label, exact, at every vertex carrying at least k − 1 labels: FS114-Y2-BOWTIE's four five-label points, FS116-Y2-SIXFRAG's centre, an R7 lattice point (and, to show they are empty, the four-label vertices of the strip and the disk). Printed: the longest arc and the largest total of one set; the number of pairs of its components 60° apart, exactly (a component rotated by 60° against every component, by exact comparison of directions), and how many have both ring points in the object; the object's own colour at float samples beside each arc. Tight: the fragment's arcs are exactly 60° — the count of pairs must be 0 with open arcs touching. The fault is the engine's planted bar (the first corner read as crossing wherever it is inner)
  run: python3 ../data/fs137/e1/budget.py forced
  expect: bowtie: k=6 vertices read=4 (labels>=5) | longest arc of one N=60.0000 largest total of one N=60.0000 | pairs of N-directions 60 apart (one label)=0, with both ring points in the object=0 | own-label: arcs=0 single directions=0 | the object has the forced label at 236 of 236 samples beside the arcs | fl=400 mismatches=0
    flower: k=6 vertices read=1 (labels>=6) | longest arc of one N=0.0000 largest total of one N=0.0000 | pairs of N-directions 60 apart (one label)=0, with both ring points in the object=0 | own-label: arcs=0 single directions=6 | the object has the forced label at 0 of 0 samples beside the arcs | fl=472 mismatches=0
    r7: k=7 vertices read=1 (labels>=6) | longest arc of one N=0.0000 largest total of one N=0.0000 | pairs of N-directions 60 apart (one label)=0, with both ring points in the object=0 | own-label: arcs=0 single directions=0 | the object has the forced label at 0 of 0 samples beside the arcs | fl=544 mismatches=0
    strip: k=6 vertices read=10 (labels>=4) | longest arc of one N=0.0000 largest total of one N=0.0000 | pairs of N-directions 60 apart (one label)=0, with both ring points in the object=0 | own-label: arcs=0 single directions=0 | the object has the forced label at 0 of 0 samples beside the arcs | fl=864 mismatches=0
    disk: k=6 vertices read=5 (labels>=4) | longest arc of one N=0.0000 largest total of one N=0.0000 | pairs of N-directions 60 apart (one label)=0, with both ring points in the object=0 | own-label: arcs=0 single directions=0 | the object has the forced label at 0 of 0 samples beside the arcs | fl=1184 mismatches=0
  fault: python3 ../data/fs137/e1/budget.py forced --fault=bar

### Argument — two forced sides 60° apart

1. *A unit pair between any two one-sided neighbourhoods.* Let `w₁ = x + e(θ)`, `w₂ = x + e(θ + 60°)`, `ε₁, ε₂ ∈ {−1, 1}`
   and `η > 0`. Put `z₁ = x + (1 + ε₁s)·e(θ)`, `z₂ = x + (1 + ε₂s)·e(θ + 60° + δ)`. Then `f(s, δ) = |z₁ − z₂|² = r₁² + r₂² −
   2r₁r₂·cos(60° + δ)` with `r_i = 1 + ε_i s`, `f(0, 0) = 1` and `∂f/∂δ(0, 0) = 2 sin 60° ≠ 0`; so there is `δ(s) → 0`
   with `f(s, δ(s)) = 1`, and for small `s > 0` the points `z_i` lie within `η` of `w_i`, inside `S(x)` if `ε_i = −1` and
   outside if `ε_i = 1`.
2. *A forced side.* Let `θ₁` be in `N_in` and `w₁ = x + e(θ₁)` in `U`. C136-FORCED at `w₁`, with the one member `x`, the
   parts of the corners of `F` that `c` has as its family, and the corner at `w₁` inside `S(x)`: its hypothesis is the
   definition of `N_in`. So there is `η₁ > 0` such that `D₁`, the part of `B(w₁, η₁)` inside `S(x)`, is an open subset
   of `U` almost every point of which has the label `ℓ`. For `N_out`, the part outside.
3. *The collision.* Let `θ` and `θ + 60°` lie in `N_in ∪ N_out` and both points lie in `U`; let `D₁`, `D₂` be as in step
   2, each on its side. By step 1 there are `z₁` in `D₁` and `z₂` in `D₂` with `|z₁ − z₂| = 1`. By C124-SHADOW-OPEN with
   `W = D₂`, the set of points of `U` at distance exactly 1 from a point of `D₂` is open and almost every point of it has
   a label other than `ℓ`; it contains `z₁`, so it meets `D₁` in a non-empty open set, almost every point of which has
   the label `ℓ`. A contradiction: `U` does not contain both points.
4. *The lengths, when `U ⊃ S(x)`.* An arc in `N_in` longer than 60° holds some `θ` and `θ + 60°`. For the total: off the
   finitely many directions at which a tangent direction is the direction of an edge of a corner of `F`, a corner is
   inner at `θ` when it is outer at `θ + 180°` (C137-BUDGET's argument, steps 1 and 3, for one corner), so `N_out` is
   `N_in + 180°` up to finitely many directions. If `θ` and `θ − 120°` are both in `N_in`, then `θ + 60°` is in `N_out`
   (off a finite set), and step 3 excludes it; so `N_in` meets `N_in + 120°`, and likewise `N_in + 240°`, in a finite
   set. `N_in` is a finite union of arcs and points, so three rotated copies with finite overlaps fit in the circle:
   its length is at most 120°.
5. *Adjacent corners.* Let `F` fill a neighbourhood with labels all but `ℓ`, and let two adjacent corners have cones
   `[d₀, d₁]`, `[d₁, d₂]` with `σ = d₂ − d₀ > 180°`. For `θ` in the open arc `(d₀ + 90°, d₂ − 90°)`, of length `σ − 180°`,
   the closed half-turn `[θ − 90°, θ + 90°]` lies in `(d₀, d₂)`; it contains neither of the two cones (each has an end
   outside it) and meets no other. A corner inner at `θ` has its cone in that closed half-turn (C137-BUDGET's argument,
   step 1), so no corner of `F` is inner at `θ`, and every label other than `ℓ` is the label of one: `θ` is in `N_in`.
   So `σ − 180° ≤ 60°`. ∎

**Theorems this stage proved**: C137-SIXTY — derived from C136-FORCED and C124-SHADOW-OPEN (inherited, one mind each),
one mind; kernel pending.

## Stage 5 — SAVED

## Stage 6 — SAVED: claim 4, C137-OWN — derived

**Verdict: derived, as posed, at the form the kernel lane's finding 6 allows (any connected subset of the circle), with
one clause added: along such a set the label's own corners are inner.** *About colourings nobody holds an example of*:
**no held object has such a set of more than one point with `ℓ` a label of the point** — the only held vertex carrying
all six labels is FS116-Y2-SIXFRAG's centre, where each of the six labels is forced at one direction (30° + 60°·j) and
on no arc; R7's lattice points and the bowtie fragment's five-label points carry all labels but one (their arcs are
C136-COLLAR's). *What is new beyond the held entries*: C136-COLLAR is its case "ℓ absent"; for maps FS116-N2-SIXRING
says more (the inner tile along the arc is the vertex's own tile, in the non-Siamese class). New is only the class of
the hypothesis — the argument never reads that `ℓ` is absent. *Reads* kept corners; *forces* a region with length and
no width. **On G100**: its sentence "Extent is forced in one way" is narrower than the entry it rests on; a second way
is derived (a point of all `k` labels, along a set on whose side exactly one of its labels is pure), with no instance
held. A rewrite is drafted for the record job (report, INVENTORY).

derivation: C137-OWN
  statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, ℓ a label, and A a connected subset of S(x) ∩ U such that at every point w of A every label other than ℓ is the label of a corner of F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V; and every corner of F with the label ℓ is inner at every point of A. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x), and every corner of F with the label ℓ is outer at every point of A.
  uses only: C136-FORCED (`plans/FS136-derivation.md` § 2; [hand], one mind — inherited, read whole) with the one member x at each point of A; C136-TABLE (the same file, § 1; [hand], one mind; kernel-checked on a branch — inherited, read whole) with the one member x, for the clause on the corners of ℓ; that an open set covered by open sets is covered by countably many of them; that the part of a disc inside a circle through its centre is convex, and its part outside is connected for a small radius; that A is connected. Not consumed: the number of labels; that ℓ is absent at x (C136-COLLAR's hypothesis); that A is an arc or open in S(x) (the kernel lane's finding 6); that F fills a neighbourhood
  not claimed: that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing; anything at a point of the closure of A that is not in A; **that a set A of more than one point exists on any held object when ℓ is a label of F — none is held** (FS116-Y2-SIXFRAG's centre gives six single points, R7's lattice points none; the arcs of FS114-Y2-BOWTIE are C136-COLLAR's, with ℓ absent); that V and the corner of F with the label ℓ belong to one piece (the map entry FS116-N2-SIXRING says so, in the non-Siamese class); what V bars one unit further on
  argument: § Argument — a forced side along a connected set
  verdict: derived
  grade: derived from: C136-FORCED
  minds: 1
  model: FS116-Y2-SIXFRAG at its centre, with A the single point e(30°) and ℓ the label 0 of the sector about that direction: every other label has its corner not inner there, the sector's corner is inner, and the fragment has the label 0 just inside (the engine's closure of this seed forces the six corners, "all six the fragment's colours": `data/fs136/e2/out/flower0.txt`); with ℓ absent, FS114-Y2-BOWTIE's eight arcs at its four five-label points (236 of 236 samples). No model with ℓ a label of F and A of more than one point is held
  prior art: partly: C136-COLLAR (`plans/FS136-derivation.md` § 2; one mind) is the case of ℓ absent and A an open arc; the asking lane's H-b and the card's claim 4 posed this form (`plans/POROS-2026-10-07-fs136-derived.md` § 0.3); for maps FS116-N2-SIXRING ("every ring arc is a (Q) arc"; `plans/FS116-derivation.md` l. 635; one mind, non-Siamese; argument read); the kernel planner's finding 6 is the form for any connected subset; print: as C136-FORCED's line — not found
  handoff: de Bruijn — with C136-COLLAR, as one statement: `ae_onSide_of_label` at the one member for each point of A, a countable subcover, the connectedness of a union of one-sided discs along a connected set, and one more use of the table for the corners of ℓ

control: own-forced
  of: C137-OWN — the directions at which a label of the point itself is the one label left on a side, exact, at every held vertex carrying at least k − 1 labels (the lines of `sixty-forced`'s scan for a label the point has): FS116-Y2-SIXFRAG's centre gives six single directions, 30° + 60°·j, one for each of its six labels, and no arc; no other held vertex gives any. The fault is the engine's planted bar: arcs then appear
  run: python3 ../data/fs137/e1/budget.py forced --list | grep "(own)"
  expect:    flower at (0.00000,0.00000) labels=6 label 0 (own) inner: [30.0]
       flower at (0.00000,0.00000) labels=6 label 1 (own) inner: [90.0]
       flower at (0.00000,0.00000) labels=6 label 2 (own) inner: [150.0]
       flower at (0.00000,0.00000) labels=6 label 3 (own) inner: [210.0]
       flower at (0.00000,0.00000) labels=6 label 4 (own) inner: [270.0]
       flower at (0.00000,0.00000) labels=6 label 5 (own) inner: [330.0]
  fault: python3 ../data/fs137/e1/budget.py forced --list --fault=bar | grep "(own)"

### Argument — a forced side along a connected set

For each `w` in `A`, C136-FORCED at `w` with the one member `x`, the parts of the corners of `F` that `c` has, and the
corner at `w` inside `S(x)`: its hypothesis is the hypothesis on `A`. So there is `η_w > 0` such that `D_w`, the part of
`B(w, η_w)` inside `S(x)`, is an open subset of `U` almost every point of which has the label `ℓ`; `D_w` is convex. Let
`V` be the union of the `D_w`. It is open, inside `S(x)`, and the union of countably many `D_w`, so almost every point of
it has the label `ℓ`. It is connected: for `w′` in `A` within `η_w` of `w`, the points just inside `S(x)` near `w′` lie
in both `D_w` and `D_{w′}`, so the set of points of `A` whose `D` lies in the component of `V` containing `D_w` is open
in `A`; these sets partition the connected set `A`, so there is one. Every `w` of `A` has `D_w` in `V`.

*The corners of `ℓ`.* By C136-TABLE at `w` with the one member `x`, almost every point `z` of a small ball about `w`
has a label `a` that, if it is a label of `F`, is inner-pure at `w` when `|z − x| < 1`. Almost every point of `D_w`, a
set of positive measure inside `S(x)`, has the label `ℓ`; so if `ℓ` is a label of `F` it is inner-pure at `w`. Outside:
the same with the part of `B(w, η_w)` outside `S(x)`, connected for small `η_w`. ∎

**Theorems this stage proved**: C137-OWN — derived from C136-FORCED and C136-TABLE (inherited, one mind each), one
mind; kernel pending.

## Stage 6 — SAVED

## Stage 7 — SAVED: claim 5, C137-MEET — derived; a rewording of C136-TABLE

**Verdict: derived — and it is C136-TABLE in the card's words, no more.** Nothing is new but the wording and the
read-out below. *Reads* kept corners; *forces* nothing; *excludes* only what the table excludes. **On R7, cell by cell**
(the card's control, run): at the 108 common unit points of the 54 pairs of lattice points less than 2 apart, each
member lacking one label and the two lacking different ones, all 432 cells keep a label, and every cell is saved by
one of the three alternatives — the label the first lacks pure for the second in 45 cells alone, the label the second
lacks pure for the first in 63 alone, one label pure for both in 108 alone, and by two or three of them in the other
216. **On the held stop**: at `(√3, 0)` the cell outside both circles of `q₂` and `q₁` is empty and the three others
keep `4`, `2, 3, 4` and `2`; at the origin the cell inside both keeps the one label `1`, pure for both (the tile both
carry) — the card's reading, confirmed exactly. The card's further sentence, that neither outer arc lies whole in any
domain, is C136-STOP-GERMS-RADIUS's and is not re-derived.

derivation: C137-MEET
  statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_n (n ≥ 1) distinct points with |x_i − w| = 1, F_i a finite set of labelled corners at x_i that c has, and σ_i a side of S(x_i), inside or outside. Let Π_i be the set of the labels that are labels of no corner of F_i, together with the labels of F_i that are inner-pure at w if σ_i is inside and outer-pure at w if σ_i is outside. Then there is η > 0 such that almost every point of B(w, η) lying on the side σ_i of S(x_i) for every i has a label in Π_1 ∩ … ∩ Π_n. So if n = 2, the labels of F_1 are all the labels but a, those of F_2 all the labels but b, a ≠ b, and for every η > 0 some point of B(w, η) lies on the side σ_1 of S(x_1) and on the side σ_2 of S(x_2), then a is in Π_2, or b is in Π_1, or some label of both F_1 and F_2 is in Π_1 and in Π_2.
  uses only: C136-TABLE (`plans/FS136-derivation.md` § 1; [hand], one mind; kernel-checked on a branch — inherited, read whole) for the members x_i with the parts of the corners of F_i as their families; that a non-empty open set has positive measure; that a ≠ b
  not claimed: anything beyond C136-TABLE, of which this is a rewording in the words of the card — no new mathematics; that a label of Π_1 ∩ … ∩ Π_n is present; that a non-empty intersection gives a colouring; that the three alternatives exclude one another; the card's reading that "neither outer arc lies whole in any domain" (it is C136-STOP-GERMS-RADIUS's, not re-derived here)
  argument: § Argument — the table, cell by cell
  verdict: derived
  grade: derived from: C136-TABLE
  minds: 1
  model: R7 at seven, any two lattice points less than 2 apart and either of their common unit points: each lacks one label, the two lack different labels, and each of the four cells keeps a label by one of the three alternatives (control `meet-r7`: 432 cells, none empty, none without an alternative)
  prior art: known: C136-TABLE (one mind; for maps FS110-N-SEAM (b), by that entry's line) — this is its conclusion read on a cell, in the card's words; the second sentence is set algebra
  handoff: none — subsumed by C136-TABLE, which crosses; the kernel lane's cell form of C136-FORCED ("for the set C of points on the chosen side of each S(x_i)") is this statement's first sentence already

control: meet-r7
  of: C137-MEET — at seven, on R7, exact: the 54 pairs of lattice points less than 2 apart in a window, their 108 common unit points, the 432 cells; each member lacks one label and the two lack different labels (asserted); for each cell, which of the three alternatives leaves it a label — the first's missing label pure for the second (a-pure-for-y), the second's for the first (b-pure-for-x), one label pure for both — with none = cells that keep a label by no alternative. Then the held stop in the same words: FS114-Y2-BOWTIE's q₂ and q₁ at (√3, 0) and at the origin. The fault is the engine's planted bar
  run: python3 ../data/fs137/e1/budget.py meet
  expect: r7 cells: pairs=54 points=108 cells=432 empty=0 none=0 | saved by: a-pure-for-y=45 a-pure-for-y+b-pure-for-x+one-label-pure-for-both=108 a-pure-for-y+one-label-pure-for-both=63 b-pure-for-x=63 b-pure-for-x+one-label-pure-for-both=45 one-label-pure-for-both=108
    bowtie at (sqrt3,0) (q2 lacks [4], q1 lacks [2]; sides q2/q1): out/in=4:a-pure-for-y in/in=2:b-pure-for-x,3:both,4:a-pure-for-y in/out=2:b-pure-for-x out/out=EMPTY
    bowtie at origin (q2 lacks [4], q1 lacks [2]; sides q2/q1): out/in=2:b-pure-for-x out/out=2:b-pure-for-x,3:both,4:a-pure-for-y in/out=4:a-pure-for-y in/in=1:both
  fault: python3 ../data/fs137/e1/budget.py meet --fault=bar

### Argument — the table, cell by cell

C136-TABLE for the members `x_1, …, x_n`, the family at `x_i` being the parts of the corners of `F_i` that `c` has, gives
`η > 0` such that almost every point `z` of `B(w, η)` has a label `a` with: for every `i` such that `a` is a label of
`F_i`, `a` is inner-pure at `w` for `F_i` if `|z − x_i| < 1` and outer-pure if `|z − x_i| > 1`. If `z` is on the side `σ_i`
of `S(x_i)`, that says `a` is in `Π_i`, for every `i`. For `n = 2`: the set of points of `B(w, η)` on the two sides is
open and by hypothesis not empty, so some label lies in `Π_1 ∩ Π_2`. `Π_1` is `a` together with labels of `F_1`; an
element of `Π_1 ∩ Π_2` is `a` (then `a` is in `Π_2`), or it is `b` (then `b` is in `Π_1`), or it is a label of `F_1`
other than `b`, in `Π_2`, hence a label of `F_2` pure on its side there. ∎

**Theorems this stage proved**: C137-MEET — derived from C136-TABLE (inherited), one mind; no new mathematics.

## Stage 7 — SAVED

## Stopped at — 2026-10-07, 20:55 UTC (the coordinator's wind-down: the budget, not the work)

**Saved through Stage 7. Five of the six claims have a verdict; the sixth has none.** Gate on this record at the stop:
`GATE: PASS (0 failures, 4 warnings)` (`data/fs137/e1/gate-stage7.txt`; the four warnings are "derived from an entry of
another file" — C136-CLASS, C136-FORCED twice, C136-TABLE). Nothing this record cites lives outside the repository.

| claim | verdict | where |
|---|---|---|
| C137-BUDGET | **derived** ([hand], one mind) — pointwise; two sentences of the card corrected | Stage 3 |
| C137-THREE | **derived** (from C136-CLASS, inherited; one mind) — the geometric step of the held statement, at any number of corners | Stage 4 |
| C137-SIXTY | **derived**, stronger than posed (from C136-FORCED, C124-SHADOW-OPEN; one mind) — 120°, either side | Stage 5 |
| C137-OWN | **derived** (from C136-FORCED, C136-TABLE; one mind) — no instance held with more than one point | Stage 6 |
| C137-MEET | **derived** (from C136-TABLE; one mind) — a rewording, no new mathematics | Stage 7 |
| C137-RING | **no verdict** — not started as a stage; statement fixed (§ 1.3); its control written and run | below |

### What is known about C137-RING (one mind; **not an entry, no verdict**; a successor starts here, not cold)

**The statement** is fixed in § 1.3 and was sent to the coordinator. **The argument I would write** (three steps; I
believe each, none is gated):

1. *A crossing corner's label is absent across.* Let `C` be a corner of `F` crossing at `y`, with label `a`. At every
   radius `C` has a non-empty open set of points strictly inside `S(y)` and one strictly outside (not inner, not
   outer). C136-TABLE at the point `x` (which is in `U`) with the one member `y` and the parts of the corners of `G` as
   its family: almost every point `z` near `x` has a label which, if it is a label of `G`, is inner-pure at `x` for `G`
   when `|z − y| < 1` and outer-pure when `|z − y| > 1`. Almost every point of `C` near `x` has the label `a`, on both
   sides; so if `a` were a label of `G`, every corner of `G` with the label `a` would be inner and outer at `x`, i.e. its
   small parts would lie on `S(x)` — impossible for a non-empty open set.
2. *The count at one point.* By C137-THREE the crossing corners number at most `2 − s`; if every corner of `F` has
   angle less than 180° no corner holds both branches strictly (it would hold both tangent directions), so they number
   exactly `2 − s` (each branch that is not an edge is strictly inside one corner, and the two are different). With one
   corner for each label their labels are `2 − s` distinct labels of `F`, none a label of `G`: `|L(G)| ≤ k − 2 + s`.
3. *The sum.* Add over `y_1, …, y_n`. A branch of `S(y_j)` at `x` that is an edge of `F` is a unit arc from `x` centred
   `y_j`: an edge of `F` is such a branch for at most one `j` and one branch. So `Σ s_j = a ≤` the number of edges `= m`.

**Its control is written and was run** (`python3 data/fs137/e1/budget.py ring`, 13 s, exact classes; output
`data/fs137/e1/out/ring.txt`; fault `--fault=cross`, which gives 21 label violations on R7 and 80 on the strip):

- **No violation on R7 or on any point a held object holds** — so no defect: crossing corners with a label of the far
  point: 0 of 66 (R7), 0 of 580 (the strip), 0 of 140 (the disk), 0 of 84 (FS116-Y2-SIXFRAG), 0 of 72
  (FS114-Y2-BOWTIE), over every unit pair of cornered vertices with the first full.
- **R7 meets the count with equality at seven, everywhere**: all 66 lattice pairs have `k − 2 + s − |L(G)| = 0`
  (`s = 1`, six labels across), and round a full ring `36 = 5·6 + 6`.
- At six the least slack per pair is 0 on the strip (16 pairs), the flower (6) and the bowtie fragment (10), 1 on the
  disk; the least ring slack is 8, 1, 6, 6 (the object's vertices at unit distance from a vertex, not a full ring).

**What it says about the card's ask, as far as I got** (to be written as the entry's prose, and attacked first):

- It is **a count every colouring with these corners satisfies, tight on R7 at seven** — the relation "between the
  numbers of labels at a point and at the points of its ring" the structural form asks for.
- It is **not the card's inequality**: at six many assignments meet it. *By hand, not run*: seven points on straight
  two-label edges, the centre with labels `{1, 2}` and the ring alternating `{3, 4}`, `{5, 6}`, meet it with room and
  leave every cell at the nineteen lattice points a label — so "corners at all seven and no empty cell" excludes
  nothing; a successor should make this a control before saying it.
- **What it does exclude at six**: R7's pattern — a centre with five labels on five corners (angles under 180°) and six
  points of its ring with five labels each (`30 > 4·6 + 5`); in general every cornered ring point with `k − 1` labels
  costs the centre one edge along that point's unit circle, and one with `k` labels two. *By hand*: on a unit
  triangular lattice of such vertices with one common number `μ` of labels, `μ ≤ 6(k − 2)/5` — 6 at seven (R7), 4.8 at
  six.
- **Held for maps, to cite, not to claim**: step 1 at the hubs of a four-colour vertex is FS116-N2-STAR / -ANTI ("the
  tile holding δ has its colour missing at both points of ω(p) at δ ± 90°"); a ring of four-label points with no edge
  along a neighbour's unit circle dies as FS116-N2-HEX6 does (three tangent lines would need three disjoint pairs of
  the centre's four labels). The sum with the unit-arc term was not found held.
- **So the card's third branch is the one the count supports**: a rich ring fits only with unit-arc edges, one per rich
  ring point. Whether such a ring exists at first order is a choice among assignments — `search request`s for lines 15
  and 21, with three screens: C137-RING per pair (`|L(u) ∖ L(v)| ≥ 2 − s`), `Σ s ≤` edges, and C137-SIXTY.

**What a successor does, in order**: (1) write Stage 8: the entry `derivation: C137-RING` with the statement of § 1.3
verbatim, the argument above checked line by line, the control `ring-held` (`run:` as above, `expect:` the five lines
of `data/fs137/e1/out/ring.txt`, `fault: … ring --fault=cross`), and the prose of the list above; (2) a control for the
slack assignment; (3) run the gate; (4) score the predictions (plan: P1–P4 are met as far as run — the scan read 720°
and 540° at all four five-label points; 120° derived; no own-label arc held; P5's control half is met, its verdict
half is open; P6 unscored); (5) the sweeps and the report in standing rule 11's form.

**Found on the way, for the coordinator** (each also in the report): the bowtie fragment's two unscanned five-label
points have collar arcs too (eight arcs of exactly 60° at four points; sent at once); G100's "extent is forced in one
way" is narrower than C137-OWN (a rewrite is the record job's to draft); the card's "whatever the corners" and "one
label fewer on every side" are corrected under C137-BUDGET.
