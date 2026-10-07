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
