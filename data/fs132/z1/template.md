# FS-132 — six by the nerve: the derivation file

*Filed 2026-10-07 (UTC) by FS132-Z1, the record job's first part (`data/fs132/briefs/FS132-Z1-record.md`; its record
`plans/FS132-Z1-record.md`). This file is FS-132's theorem record: every statement six derivers, one search and one kernel
planner produced in one night, as an entry in the deriver's grammar, gated by
`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS132-derivation.md` from `plans/`. It is assembled by
`data/fs132/z1/assemble.py` from the derivers' records: each block of theirs is copied verbatim, with its `§` addresses
pointed into its record; the one field this job changed is named under its entry (C132-M-ORBIT's `minds:` line, whose
number is unchanged). Six entries are written here and not copied: C132-CORES-SQUARE (the kernel planner's) and the
search's five — each says so. Nothing here is in the kernel: the milestone is Derived when this file is filed and Closed
when its Lean module passes the gate.*

## What FS-132 is

On 2026-10-04 an outside proof, now this project's literature (`[OAIMath2026]`, family 158), gave `χ(ℝ²) ≥ 6` and
`χ(ℝ²) = χ_m⁰(ℝ²)`: the plane's number is that of measurable colourings proper at almost every unit pair ("weak measurable
colourings"). FS-132 asks what that proof and this project's six-colour theory give together (`plans/STUB-six-by-the-nerve.md`;
`plans/FS132-six-by-the-nerve.md`). It ran three rounds in one night:

| round | job | record | what it took |
|---|---|---|---|
| 1 | FS132-E1 | `plans/FS132-E1-derivation.md` | the release's extraction at every number of colours; centres exist |
| 1 | FS132-E2 | `plans/FS132-E2-derivation.md` | card 3: the filled target, the index, the strips, where the forcing statement stalls |
| 1 | FS132-E3 | `plans/FS132-E3-derivation.md` | card 1: this project's exclusion with no map; the two readings; the two-pair ring |
| 2 | FS132-E4 | `plans/FS132-E4-derivation.md` | the ring card: the complementary pair; what a ring is forced to do where it changes |
| 2 | FS132-E5 | `plans/FS132-E5-derivation.md` | the witness card: two-point forms, the margin, the one-side statement, the superlevel form |
| 3 | FS132-E6 | `plans/FS132-E6-derivation.md` | the seed card: the shadow of an open piece; the lens; the placed point |
| — | the Searcher | `plans/SEARCH-2026-10-07.md` | the turning ring in a finite family, by exact enumeration |
| — | FS132-K1 | `plans/FS132-kernel-plan.md` on branch `fs132-wk1` (tip `e3695302`; not merged: it holds unproved skeletons) | the kernel planner: seven statements planned blind, then the exclusion's last steps read open |

The asking lane's two records of the night (`plans/POROS-2026-10-07-fs132-night.md`, `plans/POROS-2026-10-07-fs132-round2.md`)
are cited for readings and for defects they found, never for a grade. The inventory is `plans/FS132-close-inventory.md`
("item n" below); the claim list is `data/fs132/claims.md`.

**No value moved.** `χ(ℝ²) ∈ {6, 7}` as the release left it. Nothing here says a weak measurable six-colouring exists, and
nothing says none does.

## How to read an entry

**Grades and minds.** Every entry is at the grade its source gives it: [hand], or derived from [hand] entries, **one mind,
kernel pending**; the search's are [cert] in a named finite family. `minds:` is the source's field. A reading made with the
argument open is a checking reading and is not counted as a mind (the gate's rule); the coordinator's hand checks are
receipts and are not counted either. Where a second mind worked blind, the prose says exactly what it was kept from and
how far it got — for the first night's exclusion step by step (§ 1), for the index lemmas and the confinement lemma in a
sentence each (§§ 2, 4). No count was raised by this job.

**The line.** Every round ended at one object: a boundary that is an arc of a unit circle whose centre is the other end
of a unit distance. It appears two ways. **(α)** On the centre's own ring: an arc of the unit circle about the centre
whose two sides carry the centre's own labels — the map class's (Q) arc; in measure, palettes that hold no outside label
on a set of positive measure near a ring direction. **(β)** Through the centre: an edge set of the centre lying on the
unit circle about one of its ring points, so that it has no point strictly inside or strictly outside that circle and
blocks neither side there. The asking lane reads the two as one object, the unit arc of rows 135–136 (item 24: "one object
behind five leftovers"; not checked by the coordinator, nor by this job). Under each entry a line **Side** says where it
sits: *no side* — it reads no ring and no edge set; *arc-free* — its hypothesis or proviso excludes (α) or (β), named;
*reaches the hard case* — its hypotheses can hold at a point where such an arc is, and it still concludes. The tally is
§ 12.

**Supersession.** Each statement stands once in its strongest form; the forms it carries are named under it and kept as
entries, with their source's `handoff: none — subsumed by …` line:

| the form to build on | carries | kept in |
|---|---|---|
| C132-M-ORBIT ⟺ C132-WIT-ORBIT (one theorem; the four-point wording is the kernel lane's leaf) | C132-M-EXCL ⟺ C132-WIT-EXCL; C132-M-EMPTY (the claim's fixed form) | §§ 1, 10 |
| C132-WIT-SIDE | the strip clauses of C132-WIT-STRIP and C132-TRI-STRIP; step B1 of C132-CROSS; C132-WIT (the claim as posed) | §§ 2, 10 |
| C132-CROSS | C132-COMP-SHARP; C132-COMP (the claim as posed) | §§ 4, 10 |
| C132-EXT-DISC | C132-EXT (as posed); C132-CORES-FREE, and through it C132-CORES (as posed); C132-WIT-EX-FIN | §§ 3, 10 |
| C132-DIAG-WIDE (the release's theorem, read at six) | C132-DIAG (as posed) | §§ 1, 10 |
| C132-INDEX and C132-RING-WIND (two statements; one six-step lemma under both, by the planner's route) | — | § 4 |

## 1. The first night's exclusion, with no map

@@ENTRY E3 C132-M-ORBIT

**The exclusion at one six-fold orbit of ring directions.** One theorem in two wordings — this one, over four compact
sets, and C132-WIT-ORBIT below, over four points: each is an instance of the other (`plans/FS132-E5-derivation.md` § The
exclusion, step by step; control `delta-monotone`). It carries C132-M-EXCL (the ring form) and C132-M-EMPTY (the claim's
fixed form, § 10). It reads of the extraction's data clauses (1) and (3) only — not clause (5), not the centre's isolation;
"the ring has finitely many change points" is a conclusion (M8), not a hypothesis; there is no Siamese clause.

**Who did what, step by step.** E3 is the deriver (`plans/FS132-E3-derivation.md` § Argument — the orbit form); E5 is the
witness card's deriver, who had the argument (`plans/FS132-E5-derivation.md` § The exclusion, step by step: "'Reworked'
means I re-derived the step from its inputs; 'read' means line by line, not re-derived"); K1 is the kernel planner, whose
phase 1 was blind (its record § 2.3, committed at `1eb4b94b` before the fence was lifted) and whose phase 2 was open
(§§ 3.1–3.2). The last column is the coordinator's own hand check (items 3, 6): **a receipt, not a mind.**

| step | derived | reworked from the argument | reached blind | read line by line, open | coordinator's receipt |
|---|---|---|---|---|---|
| M0, the release's two palette statements, read locally at six labels | E3 read both proofs ("found no count in them; one mind") | — (E5: "read"; E4 re-read the first against its source, for C132-PLACE) | — | — (K1: not read; "the release's Lean states both for every `k`, which settles it for `U = ℂ`") | not checked |
| M1, the state | E3 | E5 | K1 ("one step; theirs is mine") | — | — |
| M2, the chart and (⋆) | E3 | E5 | K1, in another chart (S1) | — | redone |
| M3, every hub has a tip | E3 | E5 | K1, by another route: a forced label inside the ring from strips (S2–S3), on both sides of the ring | — | — |
| M4, confinement | E3 | E5 | (K1's route does not pass through it) | K1 ("checked") | redone |
| M5, one tip at each hub, opposite at antipodes | E3 | E5 | (as M4) | K1 ("checked") | redone |
| M6, three axes: two adjacent hubs with one tip | E3 | E5, with its case list (the 64-pattern control not re-run) | **not reached** — K1's own count (S4) needs limiting directions, "not available for the statement as typed" | K1 ("M6's three cases each close") | all three cases redone |
| M7, the unit-pair relation and its shift | E3 | — (E5: "read"; E4 read it for all four signs, control `unit-shift`) | K1, on the diagonal only (distance `1 − (4/3)t²`; `4/3` is `h(0, 0)²`) | K1: the expansion "re-derived independently", `h(0, 0) = 2/√3`, and an exact identity for the shift | not checked (the control agrees) |
| M8, the step lemma (Lemma S): every essential change point is a clean step | E3 | — (E5: "read; not reworked — its constants … I checked for arithmetic only") | **not reached** ("For a general measurable `s` I have no argument") | K1: "holds on my reading"; the diffeomorphism, the slope bounds, the density points, both window cases and the overlap `(9/16)ρ` checked; two things left implicit, "both fine" (the state is Borel; the shift is bi-Lipschitz) | read in outline, not reworked |
| M9, the kill | E3 | — (E5: "read") | K1, for a clean change (S5) | K1: "(a)–(d) checked with their ranges" | read in outline, not reworked |
| the ring form (C132-M-EXCL) | E3 | E5 | K1 (§ 2.3; in its skeleton from two unproved leaves) | — | — |
| the fixed form (C132-M-EMPTY) | E3 | E5 | — | — | — |

**The count of minds** (this job's one field change; the number is the source's). The planner's own line is "Grade: two
minds on M7–M9 (the deriver; this reading), M8 no longer unread" (K1 § 3.2), and the coordinator's ruling is "derived, two
minds on every step … the second mind is the kernel lane's planner, whose route was blind for all but the step lemma and
who read that lemma open. It is not two blind derivations, and the record says which" (item 30 (a)). This record says
which: the state (M1), the chart (M2), a single forced label at each hub (the content of M3–M5, by another route), the
relation of M7 on its diagonal and the kill of M9 for a clean change were reached by a second mind blind; **M6 has one
derivation, a rework made from the argument (E5) and a check with the argument open (K1); M8 has one derivation and two
readings with the argument open** (E5's, not reworked; K1's, line by line). The field reads `minds: 1` because the gate
counts a reading with the argument open as a checking reading and the weakest step governs.
Whether the headline says "two minds, the second blind but for M6 and M8" is the coordinator's wording to choose; what it
may not say is "two blind derivations".

**What it stands on.** For a colouring of the whole plane: two statements of the release, kernel-checked there at every
number of labels — the transfer of palettes for a pair and the 60° disjointness (K1 § 3.3: `palette_transfer_pair`,
`palette_sixty_disjoint`; "`outer_strip_trace` and `inner_strip_trace` are not needed") — and M1–M9. For a colouring of an
open set containing the closed unit disc, as the statement is written: also E3's reading of those two proofs as local
(M0, one mind). The kernel lane's statement is taken at the whole plane first (item 22 (a); `data/fs132/claims-K1.md`); the
local form is planned second (K1 § 3.6).

**Side: arc-free (α).** Hypothesis (i) asks an outside label in almost every palette near all six orbit directions. It
fails where the centre's own labels fill the ring near one of them: at every change point of the held fragments'
four-colour vertices at least two of the four germs at ±60° lie on (Q) arcs (control `positives-escape`), so nothing held
is excluded. It asks nothing about (β): a tip's sets are confined to the *closed* unit disc about its hub (M4).

**Read off, not entered** (K1 § 3.1, blind, one mind): on the mixed set the label forced *outside* the ring is the
opposite one, `a_{τ(k)+2}` — "something M3–M5 do not state".

Rests on it: C132-M-EXCL, C132-M-EMPTY, C132-WIT-ORBIT, C132-WIT-EXCL, C132-WIT; the chart M2 inside C132-PLACE; M7, and
Lemma S for the measurable inner–inner case, inside C132-ALT; the direction called at item 6 (a), as its name was corrected
at item 12 (a) — measurable, with no map and no normal form, *for the exclusions*.

@@CONTROL E3 hug-shift

@@CONTROL E3 three-axes

@@CONTROL E3 positives-escape

@@ENTRY E5 C132-WIT-ORBIT

**The four-point wording — the form to formalize.** The kernel planner makes it the leaf, at the whole plane
(`SixRing.no_outside_orbit_points`), and proves the compact-set wording from it in its skeleton ("the compact-set form
asks more of the hypothesis, so it is the weaker theorem … Compactness of the `K j` is not used at all", K1 § 3.4). Its
`grade:` line reads "derived from: C132-M-ORBIT" because the argument is written there; the other direction is one line.
**Side:** as C132-M-ORBIT. **A correction on record:** the asking lane's `generalization` item for this form
(`plans/POROS-2026-10-07-fs132-night.md` § 1.3, finding A; item 11) "is therefore a restatement, not a generalization"
(E5, the same section) — drafted for that record in `plans/FS132-Z1-record.md` § 5.

@@CONTROL E5 delta-monotone

@@ENTRY E3 C132-M-EXCL

**The ring form.** The palettes at the centre of a witnessed four-cycle cannot almost everywhere hold one of the two
labels outside the cycle. In the map class, for non-Siamese fragments, this is row 149's statement (FS129-SR3-QFREE-NS),
with row 148's Γ-free case inside it; here there is no map and no Siamese clause. That it *covers* a valid six-coloured
fragment wherever four tiles of four colours meet in a cycle is **given two facts about maps** (E3's report, "neither
derived here"): (1) a map's edge carries the two-colour exclusion — for tiles that are connected open sets this was
derived in the second round as C132-WITNESS (§ 2; [hand], one mind), and nobody has written the composition; (2) a map's
palette is its ring read two-sidedly — derived by nobody. It is noted on those terms under those entries in
`plans/FS116-derivation.md` and `plans/FS129-derivation.md` (dated 2026-10-07). **Side: arc-free (α)** — its hypothesis is a
ring with an outside label in almost every palette: no (Q) arc anywhere on it.

Rests on it: C132-M-EMPTY; C132-WIT-EXCL; the Searcher's queue line 9, whose first consumer it meets (item 10).

@@ENTRY E5 C132-WIT-EXCL

The ring form with four points: C132-M-EXCL itself. **Side:** as C132-M-EXCL.

@@ENTRY E3 C132-DIAG-WIDE

**The release's theorem, read at six — not a result of this milestone.** For a colouring of the whole plane this is an
instance of `OAI.EuclideanFiveColor.two_state_impossible`, which the release proves in Lean at every number of labels under
"at most two labels outside the two sets" (K1 § 2.3: `States.lean:243`; its manuscript states five labels only, Lemma 6.4).
"That generalization is theirs … C132-DIAG-WIDE should be worded as a corollary of `[OAIMath2026]`'s Lean, not as a result
of this night" (the planner, item 25; ruled at 25 (a); the claim list's dated line). The entry's own prior-art line had
said "this entry is its instance at six labels with two pairs", with the Lean unread. **What this milestone adds:** the
reading on an open set containing the closed unit disc — E3's, [hand], one mind, which is the entry's grade. The planner's
own blind derivation "is the release's proof". **Side: no edge set is read.** Applied at a four-cycle centre with its two
diagonals, its ring is of kind (α) throughout — every palette holds two of the centre's own labels: the one statement in
this file about a ring made of the centre's own labels, at its most rigid (two states, alternating), and it is the
release's.

Rests on it: C132-DIAG (§ 10). With C132-M-EXCL it leaves, at a four-cycle centre, "the mixed rings and a diagonal ring
that does not alternate" (item 9) — the mixed ring is where every held positive lives (item 12).

## 2. One side of a unit circle: the strips, the shadow, the witnesses

@@ENTRY E5 C132-WIT-SIDE

**The strips' leaf, and the entry that crosses for them** (items 18 (c), 24). One witness, one side of one unit circle,
any measurable labelling — no properness. It carries the strip clauses of C132-WIT-STRIP (three witnesses and the
majority rule) and of C132-TRI-STRIP (a witness chosen on each continuum, close to `x`), and it is step B1 of C132-CROSS —
derived the same night by another mind in the ring card's record, in the same form ("nothing of either record is wrong",
item 18). **Side: arc-free (β), edge by edge** — it is silent when `|w − q| = 1`: an edge set lying on the unit circle
about the ring point `w` has no witness off that circle.

Rests on it: C132-WIT-STRIP, C132-TRI-STRIP, C132-CROSS, C132-PLACE, C132-LENS-SIDE.

@@ENTRY E5 C132-WIT-STRIP

**The strips with one witness per edge.** Wider than C132-TRI-STRIP, which is its corollary: the limiting direction "was
only a way to find a witness on the wanted side" (item 18). Its last clause — every palette meets the outside labels — is
the one place the strips read properness and the release's Lemma 8.1 (the end of its proof, read by E5; one mind).
**Side: arc-free (β)** — the at most six directions it excludes are those at which a witness is at distance 1 from the
ring point.

@@CONTROL E5 strip-sides

@@ENTRY E2 C132-TRI-STRIP

**The strips as first derived**, for the extraction's continua with limiting directions; a corollary of C132-WIT-STRIP
(E5 § The strips, with one witness per edge, last paragraph). Kept as an entry because C132-RING-TAME, C132-LONG, C132-COMP
and C132-TURN are stated over its data. **Side: arc-free (β)** — silent at the directions perpendicular to a limiting
direction, which is where a continuum can run along the unit circle about the ring point.

@@CONTROL E2 tri-strips

@@ENTRY E6 C132-SHADOW

**The side rule for an open one-label piece** — "the stub's 'side rule for open pieces', which no entry stated" (item
28): the strips' other half, from a piece of the colouring in place of an exclusion set, at every number of labels. In
this project's terms it is C132-WITNESS followed by C132-WIT-SIDE with the centre moved to the ring point (its prior-art
line); E6 derives it directly, with no connectedness of the piece. **Side: no side** — "it reads open sets and no edge
set" (E6 § The two things the brief asks to carry visibly). What it does not reach is a piece meeting the point
tangentially to the unit circle (its *not claimed* line; control `seeing`) — which is where the search's hand argument
fails for germs only measurable (§ 6).

Rests on it: C132-LENS and what follows it (§ 5). **Read off, not entered** (E6 § The list): it gives C132-ALT's cases
O, I and I, O by a second route with no unit-pair shift.

@@CONTROL E6 seeing

@@CONTROL E6 kept-model

@@ENTRY E4 C132-WITNESS

A relay-result: a map's edges are witnessed edges. Nothing says a weak colouring has such a region. **Side: no side.**
Used by C132-COMP-SHARP's model (fragment T2) and by C132-PLACED's line PL5; "read, not reworked" by its user (E6's
report).

@@ENTRY E1 C132-CONFINE

**The dictionary's replacement for "the same tile".** **Wider, by the kernel planner, blind** (K1 § 2.3): "`K` any set
(no compactness, no connectedness); the direction clauses use neither `H` nor `x ∈ K`" — proved in Lean on branch
`fs132-wk1` (`Plane/SixRing/Confine.lean`: `SixRing.confine_of_disjoint`, `subset_closedBall_of_dist_lt`,
`inner_nonneg_of_subset_closedBall`, `inner_nonpos_of_disjoint_ball`; "proved, built"), not landed on `main`. So: [hand],
one mind, in E1's words above; a second derivation, blind, and a kernel proof of the wider form on an unmerged branch
(item 30; the claim list's dated line (iv)). The entry keeps `minds: 1` and its source's statement; the wider form is the
one to land, and the count is the coordinator's to rule when it does. **Side: no side** — no colouring in it.

Rests on it: M4 of C132-M-ORBIT; C132-TURN-EDGE. "Not verified" by E6 where it inherits it through C132-TURN-EDGE (its
report).

@@ENTRY E5 C132-WIT-MARGIN

**Where the data exist for free: at every point with a margin for three labels — points that are no centres.** It is
why "a witnessed cycle at `p` is a property of the unit circle about `p`, not of `p`" (item 14), and why existence "as
posed is free wherever a colouring has such a margin". **Side: the margin case** — the far end of the arc-free side: its
hypothesis keeps the labels off an annulus about the unit circle. **The control, re-run** (E6 § The two riding controls):
at circumradius 1/2 the hypothesis fails — the vertex's labels on the annulus go from 0 to 6,672 samples, "at 1/2 no
witness comes from a margin"; the entry is untouched. A dated line is under the control in E5's record.

@@CONTROL E5 margin-witness

@@ENTRY E5 C132-WIT-CROSSED

Which labels have no witness at a point. **A correction on record** (E5 § The two controls at seven; item 19): at the
stripe colouring's centre "two of the three hexagons at `v`" are crossed by its unit circle "along arcs, and those two
labels have no witness at `x` at all … with the stripes or without" — so the stripe colouring is not a witnessed triangle
with a wild ring; it stays a control for a three-label palette only. **Side: no side.**

@@ENTRY E5 C132-WIT-SUPER

**The exclusion clause from any connected subset of one smoothed class's superlevel set**: "no hole, no exceptional set,
no centre, no isolation, one label at a time. So the exclusion's proof is not where isolation is read; the step before it
is" (item 18). It takes the extraction's place in the kernel lane's queue (item 24). **Side: no side.**

Rests on it: the statement of where C132-WIT-EX stalls (§ 8).

## 3. Centres exist; the extraction; the filled target

@@ENTRY E1 C132-EXT-DISC

**The release's extraction at every number of colours, on any closed disc of radius above 1 with finitely many cyclic
centres** — never the release's theorem: the release proves it at five, on a square of side ten (inventory rule 2 (ii)).

**Two clauses the manuscript does not state**, read off its proof by E1: (4) each continuum lies in both its labels'
supports; (5) each edge of the returned cycle is an edge of the centre's own transition graph. **Clause (5) goes against
the letter of a sentence of the manuscript** — "The extracted cycle need not consist of edges of Γ_x" (`M/interfaces.tex:51`,
by E1's report) — and is one mind's (E1's step S11), unread by a second (item 3). **It has two consumers, both small**:
a closing remark of E3 on mixed rings (the release's Lemma 6.2 acting on the extracted cycle), and the words "forming a
cycle of the transition graph" in C132-WIT-EX-FIN (`plans/POROS-2026-10-07-fs132-round2.md` ll. 73–74; E5's report: "used
once here"). No exclusion in this file reads it. It does **not** bear on C132-TURN's stall: the clause is derived for the
extraction's own continua, and for whatever witnesses a hypothesis hands a point the relation is false in general (item
21, withdrawing ruling 16 (c); the claim list's dated correction). The whiff stays on record with no side picked (E1's
and E4's reports).

**Read by one mind only** besides S11: S5's merging bookkeeping and S8 (the release's Lemmas 7.7, 7.8, read in full, not
reworked). **Receipts** (item 3): S6 redone by the coordinator, S7's mesh bound followed step by step.

**The hypothesis nobody supplies at six** is finitely many centres in the disc (the road's step 2; item 12). What the
argument reads of it is zero length of the centres and isolation of the one essential centre (E1 § Card 2); at the island
colouring's accumulation centre the conclusion with clause (4) is false, and true at the isolated ones (control
`hex7-islands`). **Side: no side.**

Rests on it: C132-CORES-FREE, C132-EXT, C132-WIT-EX-FIN; steps S4–S5 and S7 inside C132-FILL; the data over which
C132-TRI-STRIP, C132-RING-TAME, C132-LONG and C132-COMP are stated. For the kernel lane it waits: its right form is
C132-WIT-SUPER's question (items 12 (b), 24).

@@CONTROL E1 hex7-model

@@CONTROL E1 hex7-islands

@@CONTROL E1 sec7-cites

@@CONTROL E1 reduced-words

@@ENTRY E1 C132-CORES-FREE

**Every closed disc of radius above 1 holds a cyclic centre, at every number of colours, with no hypothesis** — the
road's step 1. It carries C132-CORES (§ 10). **Side: no side.**

derivation: C132-CORES-SQUARE
  statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed axis-parallel square of side greater than 1 contains a cyclic centre; in particular every closed disc of radius greater than 1/√2 does
  uses only: nothing is carried to the statement here. Its poser's route, five lines by hand, blind of the derivers' records: on a compact region with no cyclic centre the release's Lemmas 7.3, 7.4 (with no core disc) and 7.6 give open covers of multiplicity two and mesh 1 + o(1), and a closed square of side above 1 has none, by this library's kernel-checked covering theorem for the square (`HadwigerNelson.LebesgueCovering.lebesgue_covering_square`) after a closed shrinking of a finite subcover
  not claimed: a square of side 1 or less; that 1/√2 is sharp for discs (in the hexagonal model every disc of radius 2/5 contains one); squares that are not axis-parallel (they follow by rotating the colouring; not stated); anything for a colouring of a bounded region
  argument: FS132-Z1-record.md § 3.3 The planner's route for C132-CORES-SQUARE, quoted
  verdict: gap: the route is not written out, and its mesh bound is not derived on a square — the planner read the release's Lemmas 7.3, 7.4 and 7.6 at general k without re-deriving them, and has not compared its route with steps S5 and S7 of C132-EXT-DISC, which derive that bound at every k on a disc; the cover step is an unproved leaf of its skeleton
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5 — every closed disc of radius 2/5 holds a vertex (C132-CORES-FREE's model)
  prior art: partly: Lebesgue's covering theorem for the square is classical (`[HurewiczWallman1948]` Thm IV 2, held; in this library's kernel since the Lean backlog); the rest as C132-CORES-FREE
  handoff: de Bruijn's planner, at its stage 4 — "read `FS132-E1` Stage 3 S5–S7 against 2.3's route for C132-CORES-FREE and 3.5" (its § 3.7 item 1); then to Ephodos if the comparison leaves a step to derive

**Posed by the kernel planner, with a route; written here, not copied from a deriver's record.** The statement and its
*not claimed* line are the planner's, verbatim (its record § 3.5; copied by script into the claim list's dated line of
item 30). The claim list calls it "posed by the planner, [hand], one mind, its route not yet compared with the first
deriver's steps"; the brief calls it "the planner's square, posed". **It is entered as a gap, not as derived**, for three
reasons its own record gives: it heads this route "route:" where it heads its other statements "TRUE"; "What I did not
re-derive: Lemmas 7.3, 7.4, 7.6 at general `k` — read, and I see no use of five beyond `α < 1/5 → α < 1/k`"; and "not
compared with the first deriver's S5–S7 (`FS132-E1` Stage 3): unread" (§§ 2.3, 3.5). Nothing known speaks against it: if
S5 and S7 of C132-EXT-DISC carry over from a disc to a square — they bound a mesh and read no shape — then the statement
follows, C132-CORES-FREE is its corollary, and the release's cover lemma need not be ported (item 25). That comparison is
one short stage and nobody has done it. **Side: no side.**

@@ENTRY E5 C132-WIT-EX-FIN

The anchored witnessed cycle on a disc with finitely many centres: a corollary of the extraction, and one of clause (5)'s
two consumers (the words "forming a cycle of the transition graph"). **Side: no side.**

@@ENTRY E2 C132-FILL

@@ENTRY E2 C132-NOESS

**Card 3's first branch has an empty answer.** With every triangle filled every loop bounds, so "the essential centres
are the cycles of length four to six" does not hold and the obstruction is not in the filled target (items 5, 7); the
asking lane's collision is read, both sides true of two targets, no invention needed (E2's report). C132-FILL, C132-REL
and C132-TRI-STRIP hold at every number of colours. **Side: no side** (both entries).

@@CONTROL E2 two-skeleton

@@ENTRY E2 C132-REL

The classes of the centres inside a circle add up to the circle's. **Side: no side.** **The control, re-run** (E6): at
circumradius 1/2 the unit circle about a vertex passes through three vertices, outside this entry's hypothesis; E2's
script compares distances strictly in floating point there and reads 11 where the count with those vertices inside is 13
(a tool defect, E6's report; the script is not edited).

@@CONTROL E2 hex7-relation

## 4. A triangle point's ring

@@ENTRY E2 C132-INDEX

**The invariant that tells six from seven.** Three labels outside a triangle wind — degree 3 modulo 6, so at least nine
changes; four labels have no winding number; two are rigid. No colouring in it. **A second derivation exists, blind**: the
kernel planner's (K1 § 2.3), from the statement alone, by the same six-step sum, with models of its own
(`plans/FS132-Z1-record.md` § 2.5 compares the two: the statements are the same). The field keeps `minds: 1`: the
planner's is a paragraph by hand whose Lean leaves are unproved, and it has not read this entry (its § 3.7 item 2); the
count is held for the coordinator. The coordinator's hand check of the argument (item 7) is a receipt. **Side: no side.**
It has no consumer until a tame ring is supplied (C132-RING-TAME, § 8).

@@CONTROL E2 ring-degree

@@ENTRY E2 C132-RING-WIND

The same for a step function with finitely many changes, no two 60° apart. Here it stands as E2 derived it, from
C132-INDEX. **A second route, blind** (K1 § 2.3): "RING-WIND does not use INDEX" — the six-step sum applied to the step
lift directly (each jump at most 1, no jump matched at `π/3`, the intervals 2 apart). **Side: no side.**

@@ENTRY E2 C132-ORBIT

The measurable shadow of the winding number: an orbit index in {2, 3, 4} at almost every direction, with no tameness.
Applied to a colouring it rests on the release's Corollary 5.4, taken at its statement by E2; that proof was read by E3
(M0), one mind (item 8 (ii)). **Side: no side.**

@@ENTRY E2 C132-SEP

One computation, used only in the YES side's sketch. **Side: no side.**

@@CONTROL E2 chord-angle

@@ENTRY E4 C132-CROSS

**The covering count: it reads no properness.** Its first step, B1, is C132-WIT-SIDE (§ 2). **Side: arc-free (β)** — "a
set K all of whose points are at distance 1 from w … enters none of the four unions". **The control, re-run** (E6 § The
two riding controls): on the honeycomb at circumradius 1/2, `hex7-crossings` reads own labels near a crossing point at 36
of 432 where it read 0 at 2/5, every such sample inside that vertex's unit circle, "as the blocking rule requires. The
entry is untouched; the zero at 2/5 was the margin". A dated line is under the control in E4's record.

@@CONTROL E4 crossing

@@CONTROL E4 hex7-crossings

@@ENTRY E4 C132-COMP-SHARP

**The regular chain's last line in the exact class** (the road's step 3e; item 15 (b)): two points less than 2 apart
carrying witnessed triangles on disjoint triples of six labels force one of the six edge sets onto the unit circle about
each of their common unit points in the open set. **Side.** Read as an exclusion — no complementary pair under 2 apart —
it is **arc-free (β)**. Read as stated, **its conclusion is the hard case**: fragment T2 realizes it, with three of its
six edge sets arcs of the unit circle about the crossing point (control `seam-fragments`). It carries C132-COMP (§ 10).
The sharpening it gives `LEDGER.md` row 133 is drafted from E4's report in `plans/FS132-Z1-record.md` § 5.

@@CONTROL E4 seam-fragments

@@ENTRY E4 C132-PLACE

**What the transfer forces near a ring point, on a pure side.** Under its argument E4 has a list by the germs of the
outside state 60° to either side, derived for constant and step germs, two lines open (the side that is not pure; germs
only measurable). On the six-sector turning ring: at an outer-pure ring point all three outside labels meet; at an
inner-pure one nothing is placed — the asking lane's hunch holds on outer-pure points only (item 16). **Side: arc-free
(β) at the ring point, up to one edge** — it needs two of the three sets with a point strictly on one side of the unit
circle about the ring point, so it holds with the third set on that circle and says nothing at a ring point with no pure
side. One input is unverified by a later user: "the proof of the release's Lemma 5.2 (inside C132-PLACE)" (E6's report).

Rests on it: C132-ALT, C132-TURN-EDGE, C132-LENS, C132-LENS-FOUR, C132-PLACED-RING.

@@CONTROL E4 chart-wedges

@@ENTRY E4 C132-ALT

**The alternating ring is excluded in step form** wherever two adjacent ring points each have a pure side — "the binary
ring of the YES sketch is gone in step form" (item 16). For a ring that is only measurable it is derived for two adjacent
inner-pure points (over Lemma S, M8 of C132-M-ORBIT); the three other patterns need three shift lemmas of that kind,
"sketched … and not entered". **Side: arc-free (β), with one residue named** — an orbit none of whose adjacent pairs has
two pure sides: three alternate ring points, each with one of the three sets on its unit circle. **In a finite family,
[cert]:** SEARCH-1007-ALT (§ 6). **A second route for two of its four cases**, read off, not entered: C132-SHADOW (§ 2).

@@CONTROL E4 unit-shift

@@CONTROL E4 forced-pairs

@@ENTRY E4 C132-TURN-EDGE

At a step of a turning ring whose two neighbours are outer-pure, the two ring labels are never a witnessed edge at the
ring point: "the pair is provably NOT witnessed there" (item 16). **Side: arc-free (β) at the two neighbours**; no
hypothesis at the ring point itself. **A correction on record.** The sentence beside it in E4's record — "Every pattern
of sides has such a point when all six ring points have a pure side: the side is opposite at antipodes, so the six read
O O O I I I (take the middle O) or O I O I O I (take any I)" — is true one way only; the dated line E6 drafted is appended
there (`plans/FS132-E4-derivation.md` § Where C132-TURN stalls, under item (i)). "The entry C132-TURN-EDGE does not use the
sentence."

Rests on it: C132-PLACED's line PL5 (E6: inherited, "its argument read and not reworked"); the statement of where
C132-TURN stalls (§ 8).

@@CONTROL E4 turning-edge

## 5. The seed: what a point's unit circle forces in the balls about its ring points

*A seed is a point with data on its unit circle, however it came by them (the asking lane's re-cut of the object, item
23). Every entry here is E6's, [hand] or derived from it over the inherited C132-PLACE; one mind.*

@@ENTRY E6 C132-LENS

**On a turning seed, the lens at a ring point between two outer-pure neighbours carries only the centre's own labels.**
"It reads nothing at `y_0`: no side there, no palette there, no witness there." The card's falsifier was computed and is
empty (control `lens-shadow`). Its `grade:` line names C132-SHADOW; C132-PLACE (E4, [hand], one mind) is in its `uses
only:` and governs it equally. **Side: reaches the hard case** — its hypotheses sit at the two neighbours and none at
`y_0`, so it holds at a ring point on whose unit circle an edge set of `x` lies: "the first conclusion of this milestone
at a ring point of the hard kind, reached from neighbours of the easy kind" (E6 § The two things the brief asks to carry
visibly). The neighbours are on the arc-free side: each needs two edge sets with a point strictly inside its unit circle.

@@CONTROL E6 lens-shadow

@@ENTRY E6 C132-LENS-SIDE

The card's clause (i): between two outer-pure ring points, no pure inner side. **Side:** as C132-LENS. With it the ring
card's sentence "at an inner-pure `y` the inside holds `a` and `b` only" (E4 § Where C132-TURN stalls, (i)) and C132-LENS
are not in conflict: together they are this entry.

@@ENTRY E6 C132-LENS-FOUR

**Three consecutive outer-pure ring points: the middle one has four labels present** — "the existence side's first
forcing statement in measure — and it is on the arc-free side" (item 28 (b)). **Side: arc-free (β)** at all three ring
points (each has two edge sets with a point strictly inside its unit circle).

@@ENTRY E6 C132-LENS-GERM

When three such ring points exist: when every edge set has a point strictly inside three of the six unit circles and
strictly outside the other three — as the extraction's continua do when each has a limiting direction perpendicular to no
ring direction. **Side: arc-free (β)** — "its hypothesis fails for a set lying on a unit circle about a ring point" (E6).

@@CONTROL E6 side-patterns

@@ENTRY E6 C132-PLACED-RING

**The placed point's own ring, at its two neighbours.** Its unit circle runs along an interface between the two ring
labels there, oppositely oriented at the two — "so the first night's exclusion says nothing on the orbit through `x`"
(item 29). For FS-124: "the placed point is the centre of two unit arcs carrying both their side labels, of opposite
orientation" — a measurable instance of that stub's first question with every hypothesis derived (E6's report). **Side:**
its hypotheses are at the two neighbours, on the arc-free side; **its conclusion produces the hard object, of kind (α), at
the placed point.**

Rests on it: C132-PLACED's list (§ 8).

@@CONTROL E6 placed-arcs

**The second round's seven-label controls, re-run at circumradius 1/2** (E6 § The two riding controls; the four controls
below). "Two counts move, none against an entry": `hex7-crossings`' own-label count 0 → 36 of 432, and `margin-witness`'
0 → 6,672 with all seven labels on the annulus; "at 1/2 the second round's exclusions still hold, and what the 2/5
controls' zeros recorded beyond them was the margin." **The second round's seven-colour controls are controls of the
margin case only** (item 28 (d)); the dated lines are under the two controls in E4's and E5's records. And **the search's
kept four-label model is the hard case, and no statement of this section applies to it** — its sides read `I - I - I -`,
no ring point is outer-pure (control `kept-model`, § 2).

@@CONTROL E6 hex-half-crossings

@@CONTROL E6 hex-half-sides

@@CONTROL E6 hex-half-margin

@@CONTROL E6 hex-half-relation

## 6. The day's search, in its family

*The Searcher's results (`plans/SEARCH-2026-10-07.md`), entered here by this job: the search's record has no entry
blocks. Each statement field is that record's own sentence, quoted, and quantifies over its family F only — seven
"flowers", the centre and the six ring points, each ring flower the six 60° wedges cut by the three unit circles through
the ring point with one label per wedge, the centre's flower in twelve 30° sub-sectors with straight rays or arcs of unit
circles about ring points (its § 1.3). "What the null is not": a wedge split along another curve, twelve sectors, unequal
sectors, curved sector boundaries, a sector with two outside labels, measurable germs (its Stage 4). The coordinator
re-verified the four refutations of SEARCH-1007-TURN3 with `cake_lpr` (item 20): a receipt. Not checked by anyone but the
Searcher: that the formulas say what F is.*

derivation: SEARCH-1007-TURN3
  statement: in the seven-flower wedge family F (Stage 1), no model has the turning ring `a, b, n, a, b, n` and at most three labels at every ring point
  uses only: four formulas, one for each family of the centre's flower (simple or any sectors; straight rays, or arcs allowed), built by `data/search/2026-10-07/solve.py` from pair tables decided exactly by `tools/fs110_y_check.py` at two radii; an LRAT refutation of each, accepted by `cake_lpr` on its line `s VERIFIED UNSAT`
  not claimed: anything outside F (the list above); that the four formulas say what F is — the encoding and the tables are the Searcher's and were read by no second mind; anything about C132-TURN, whose class is all weak colourings
  argument: SEARCH-2026-10-07.md § Stage 3 — SAVED: the run
  verdict: derived
  grade: certified by: cake_lpr, on the four LRAT proofs of the three-label row, archived in data/search/2026-10-07/proofs.tar.xz
  minds: 1 — one instrument, the Searcher's run and its checker; the coordinator re-ran the checker on the four proofs (a receipt)
  model: none can exist in F (a non-existence); the nearest structure that does exist in F is SEARCH-1007-TURN4's, with four labels at alternate ring points
  prior art: owed — the family is this project's
  handoff: none — a search's certificate in a finite family; it bears on the YES side only as far as the family reaches

**The requested object does not exist in the family.** [cert]. **Side: the family contains both sides** — the centre's
rays may be arcs of unit circles about ring points; the null holds across it.

derivation: SEARCH-1007-TURN3-HAND
  statement: in the family F, with any finite sector structure at `x` in place of its twelve sub-sectors, no model has the turning ring `a, b, n, a, b, n` and at most three labels at every ring point
  uses only: the five steps of the search record's § 1.5: its pair rules for one-label wedges (rows of the exact table) in steps 1 to 4; in step 5 only that a label on a far wedge has its sectors at `x` in the closed half-plane facing away from that ring point
  not claimed: the null for germs that are only measurable — step 3's second rule and step 4 are about one-label wedges and fail there (FS132-E6); anything for a wedge split by a curve; that step 5 was read by a second mind
  argument: SEARCH-2026-10-07.md § 1.5 The argument's shape
  verdict: derived
  grade: hand
  minds: 1 — the Searcher's, "unchecked by a second"; FS132-E6 read steps 1 to 4 for what survives when the wedges are only measurable, and did not check step 5
  model: none can exist (a non-existence); for the family's own sector structures the same null is SEARCH-1007-TURN3, by certificate
  prior art: owed — in-house
  handoff: none — a hand argument inside a finite family; what of it survives in the measurable class is C132-LENS, C132-LENS-FOUR and C132-LENS-GERM

**The same null by hand, and a correction on record.** The statement field is this job's joining of two sentences of the
search record, which has no single one: "the same null by a five-step argument (Stage 1, § The argument's shape), which
reads the x flower only through half-planes and so does not need its rays at multiples of 30°" (its § Theorems) and "the
hand argument extends it to any finite sector structure at `x` [hand, one mind]" (its Stage 4). **For germs that are only
measurable one of its steps fails** (E6 § The two things the brief asks to carry visibly): steps 1–2 hold, "with no wedge
at all: they are the transfer"; step 3's first rule holds and "mirrored at both neighbours, is C132-LENS"; **step 3's
second rule "is the step that fails for germs that are only measurable"** — only a sub-wedge of the lens sees the wedge it
needs (control `seeing`: 0.194, 0.083, 0.000), "enough" for a lens of one label, not for a measurable one or one split by
a curve; step 4 "is of the same kind"; step 5 "Not checked by me". So the coordinator's hope at ruling 20 (d) — the
stalled claim derivable for measurable germs — is answered no for that rule (item 28 (c)), and the null is its family's,
"as it says". The correction is drafted for the search's record in `plans/FS132-Z1-record.md` § 5. **Side:** as
SEARCH-1007-TURN3.

derivation: SEARCH-1007-TURN4
  statement: in F, with four labels allowed at ring points, the turning ring has models
  uses only: the kept models `data/search/2026-10-07/KEEP-turning-4label-arcs.json` and `KEEP-turning-4label-straight.json`, each accepted by `data/search/2026-10-07/cold_check.py`, which reads no table, at two radii
  not claimed: that any of them is a model of what was asked — "They are not the object of the request: three of the ring points are four-label points"; that any extends beyond the seven flowers of radius about 0.25, "Nothing between the flowers is built"; that one extends to the closed unit disc ("not decided here")
  argument: SEARCH-2026-10-07.md § Stage 3 — SAVED: the run
  verdict: derived
  grade: certified by: data/search/2026-10-07/cold_check.py, on the kept models, from a cold start at two radii
  minds: 1 — one instrument
  model: the kept arcs model itself — C132-SHADOW's model line and control `kept-model` read it: labels 012, 1234, 012, 0145, 012, 0235 at the six ring points
  prior art: partly: the shape is fragment T2's (FS110-FRAGS), held
  handoff: none — a held shape, local; whether it extends to the annulus and the closed unit disc is the search's second request, queued as line 11 and not run (item 20 (e))

**With four labels the turning ring exists in F, in a shape this project already holds.** By the search's census (its
Stage 3; a count by enumeration, projected to the wedge labels — not a certificate): with a simple three-sector centre
and arcs allowed, "all 192 models are of one shape, in four classes of 48 by symmetry: the three interfaces at `x` are
120° apart, at the tangent directions, and **each is an arc of the unit circle about a ring point; those three ring points
are alternate ones and are exactly the ring points with four labels**"; and "No model of this family has a three-way point
at two adjacent ring points". **Side: the hard case
(β), in a model** — "the search's kept model is the hard case and no statement of the stage applies to it" (item 28).

derivation: SEARCH-1007-TURN-SS
  statement: with `x` simple and straight F has no turning ring at any number of labels
  uses only: four formulas (three, four, five and six labels allowed at a ring point; the centre simple with straight rays), each with an LRAT refutation accepted by `cake_lpr`; "the refusing set needs both `simple` and `straight` — with either lifted there are models"
  not claimed: anything outside F; anything for a centre with more than three sectors, or with a ray that is a unit arc
  argument: SEARCH-2026-10-07.md § Stage 3 — SAVED: the run
  verdict: derived
  grade: certified by: cake_lpr, on the four LRAT proofs of the column "x simple, straight", archived in data/search/2026-10-07/proofs.tar.xz
  minds: 1 — one instrument
  model: none can exist in F (a non-existence); with either `simple` or `straight` lifted there are models (SEARCH-1007-TURN4)
  prior art: owed — in-house
  handoff: none — a search's certificate in a finite family

The name is the inventory's (item 20); the search's record carries the result as a column of its table and a sentence of
its Stage 4, the statement field. **Side: arc-free (β) by hypothesis** — straight rays at the centre.

derivation: SEARCH-1007-ALT
  statement: in F the alternating ring `a, b, a, b, a, b` has no model at any number of labels per ring point
  uses only: sixteen formulas (four numbers of labels by four families of the centre), each with an LRAT refutation accepted by `cake_lpr`
  not claimed: anything outside F; that this is a second derivation of C132-ALT — it is its positive control in a finite family, and it reads one-label wedges
  argument: SEARCH-2026-10-07.md § Stage 3 — SAVED: the run
  verdict: derived
  grade: certified by: cake_lpr, on sixteen LRAT proofs, archived in data/search/2026-10-07/proofs.tar.xz
  minds: 1 — one instrument
  model: none can exist in F (a non-existence); the formula becomes satisfiable when the four pair classes of C132-ALT's four cases are removed together (the search's Stage 2, by the inventory's item 20; not read by this job)
  prior art: partly: C132-ALT, derived the same night
  handoff: none — a positive control

The brief's positive control — "a search that can decide the one must reject the other" (item 17). **Side:** as
SEARCH-1007-TURN3.

## 7. Two calibrations at seven

@@ENTRY E5 C132-GRUNDY7-NOT

**The first clause of the Grundy test tests nothing**: no order makes any of the three seven-colourings a Grundy
colouring, "true already of the unmodified hexagonal colouring" (item 19). **Side: the margin case** — all three have a
margin.

@@CONTROL E5 grundy-margins

@@ENTRY E5 C132-GRUNDY7-LOCAL

For a suitable order some output of the Grundy construction is one label on the whole slack ball. **Side: the margin
case.** Neither entry decides the class of C132-RING-TAME's first clause (the claim list's dated line of item 19).

## 8. Stalls and gaps — each a result, with its step and its smallest open form

*Nine entries here and one in § 3 (C132-CORES-SQUARE). Each keeps its source's block; the address of its smallest open
form is in its `handoff:` line. "Left this milestone" means the asking lane's stops, adopted at item 23 (b): whether, in
the class of all weak colourings, a point with usable data must exist goes to FS-127 and FS-128.*

@@ENTRY E3 C132-RUN-EMPTY

**A reading that stalls at a step that is not needed.** Nine of the route's eleven steps restate; V6-HUBS reads a tile as
one connected piece and has no restatement; its place and the count's are taken by M6. The statement the reading was for,
C132-M-EMPTY, is derived (§ 10). **A correction on record:** the plan's dictionary term for a tip is too wide (this
entry's own step table, row V6-TIP); the dated line is appended to `plans/FS132-six-by-the-nerve.md` § The readings, stated.

@@ENTRY E3 C132-RUN-CV

**The existence reading stalls at its first input.** With its repeated-colour alternative gone the restated input is
C132-M-CV itself; the route's other three inputs dissolve (the nerve normalizes with no modification). C132-M-CV — an
extracted centre with a cycle of length at least four — is **open**: it "holds exactly when the measurable side can
refute 'every extracted centre is a triangle'" (item 9), and stalls by the other route at C132-RING-TAME. E3's hand-over:
put to row 134's base the question it put to this project's exclusion (unread by it: the base's verification, the proof
of the stalled input).

@@ENTRY E2 C132-RING-TAME

**The stalled step as a statement of its own, about one circle at one centre.** "Its first clause is false wherever
local slack exists along the strip, so it is a statement for a normal form or false at six" (item 7). The asking lane
split its class (item 11): the second clause as a conclusion for every weak colouring living on triangles alone — the
ring card, where C132-ALT and C132-TURN-EDGE are what was derived and C132-TURN stalls; the first clause for honest
colourings, untested — C132-GRUNDY7 did not decide it — and, for all weak colourings, left this milestone.

@@ENTRY E2 C132-LONG

**The forcing statement — the disc form of C132-M-CV — stalls at C132-RING-TAME**, and behind it two steps of the regular
chain have no weak form (eleven vertices against ten types; the bicycle). Of the regular proof's steps: R1 held; R2
derived, one side (C132-TRI-STRIP); R3's lemmas derived (C132-INDEX, C132-RING-WIND), their hypothesis the stall; R4's
relation derived (C132-REL), its use unposed; the regular chain's last line derived in the exact class the next round
(C132-COMP-SHARP) (item 7; item 12's table).

@@ENTRY E4 C132-TURN

**The turning ring survives; the stall is one edge.** **The stall, as corrected** (item 21; the claim list's dated
line): it is *not* "the relation of C132-EXT-DISC's clause (5)", as this entry's verdict line and the coordinator's
ruling 16 (c) had it — "C132-TURN's stall is: that a witnessed triangle given at a point lies in that point's own
transition graph — a statement no entry of this list asserts", and for witnesses in general it is false. The two cards of
the second round stalled at "the two opposite inclusions between two graphs on the labels at a point" — the transition
graph (every small ball) and the witness graph (the unit circle) — not at one place from two sides (item 21 (b)). The
statement itself carries a defect its poser names: it "attaches data of a unit circle to a point defined by its small
balls, with nothing joining them"; it "stands as stalled and is not re-posed in that form". The entry's block is E4's,
unchanged; this paragraph is the correction. In a finite family the three-label turning ring does not exist
(SEARCH-1007-TURN3, § 6).

@@ENTRY E5 C132-WIT-EX

**Existence of the data with no hypothesis on the centres stalls at the extraction's selection step.** As posed it "is
met at points where none of the cycle's labels is present" and is free wherever there is a margin (C132-WIT-MARGIN). Its
smallest open form (O): "a weak colouring and a disc of radius above 1 in which, at every point, the graph of witnessed
label pairs is a forest". Left this milestone.

@@ENTRY E5 C132-GRUNDY7

**Stalls at its second clause, which is not one statement**; that clause is withdrawn as posed (item 19 (a)); its two
readings, (G1) "some output" and (G2) "every honest seven-colouring", are open and left this milestone.

@@ENTRY E6 C132-LENS-II

**The card's clause (ii), verbatim, is a gap at "pure sides are opposite at antipodes"** — true one way only. Derived of
it: C132-LENS-FOUR and C132-LENS-GERM. Open: sixteen patterns of sides, "all of them seeds whose sets witness from far
away". It stands as a gap and is not re-posed (item 29 (a)).

@@ENTRY E6 C132-PLACED

**A list (PL1–PL6) with one line open**: whether any pair containing a label of the centre's triple is a witnessed edge
at the placed four-label point. Nothing derived closes a four-cycle there; in the card's table it is the second row, a
mixed ring. Behind it C132-ARC was not reached (§ 9).

## 9. Posed, and not started

- **C132-RADIUS** (`data/fs132/claims.md` § The claims, item 3; the stub): posed, not started (E3's § Not reached).
- **C132-ARC** (the claim list's dated line of item 23; the stub's third-round card): posed, not started — "no line of
  it worked, its R7 control not run" (E6's report); where a successor starts is E6's last section.
- **C132-M-CV** — an extracted centre with a cycle of length at least four: named in the claim list, never derived or
  refuted; both routes to it stall (C132-RUN-CV, C132-LONG).
- **The REG-J′ side question** (under REG-J′, are a saturated colouring's centres locally finite: E1's foothold 4, "a
  candidate, unchecked"): not started.
- **Card 2 beyond the argument's level**: the extraction for a countable closed set of centres — "a sketch … not a
  claim" (E1 § Card 2); proposed as a job of its own.
- **Three shift lemmas** for C132-ALT's measurable form (outer–outer, outer–inner, inner–outer): sketched in E4, not
  entered.
- **The third-label rigidity at a triangle centre** (E3 § The coordinator's question): "a four-germ relation and a
  rigidity of the third outside label", unproved, "a job of its own".
- **"A map vertex carries the four sets"** — the two standard facts under which C132-M-EXCL covers rows 148–149's
  fragments (E3's report): a short job, not briefed (item 10 (iii)).
- **The search's second request** — extend the kept four-label fragment to the annulus and the closed unit disc: queued,
  not run (item 20 (e)).

## 10. The claims as posed, and the restatements — kept, each carried by an entry above

@@ENTRY E1 C132-EXT

@@ENTRY E1 C132-CORES

@@ENTRY E3 C132-M-EMPTY

@@ENTRY E3 C132-DIAG

@@ENTRY E4 C132-COMP

@@ENTRY E5 C132-WIT

**C132-EXT** and **C132-CORES** are the claims as posed, instances at radius 8 of C132-EXT-DISC and C132-CORES-FREE.
**C132-M-EMPTY** is the first card's existence form answered NO in the measurable class: the instance of C132-M-EXCL at an
extracted centre with a four-cycle. **C132-DIAG** is the release's theorem at a four-cycle's two diagonals (see
C132-DIAG-WIDE). **C132-COMP** is the ring card's first claim as posed: its proviso is an instance of "no edge set on the
unit circle about the crossing point", and it is on the arc-free side by that proviso. **C132-WIT** is the witness card's
first claim as posed: for the two exclusions "not a widening" — the same theorems — and for the strips a widening
(C132-WIT-STRIP).

## 11. The corrections on record, and where each stands

| what | corrected by | where the dated line is |
|---|---|---|
| "pure sides are opposite at antipodes" (the ring card's read-off line; the third card's clause (ii)) | E6 § The gap in clause (ii) | appended in `plans/FS132-E4-derivation.md` § Where C132-TURN stalls, under item (i); C132-LENS-II is the gap |
| the second round's seven-colour controls are controls of the margin case | E6 § The two riding controls | appended under `hex7-crossings` in E4's record and under `margin-witness` in E5's |
| the plan's dictionary term for a tip is too wide | E3's step table, row V6-TIP; its report | appended in `plans/FS132-six-by-the-nerve.md` § The readings, stated |
| the extraction's clause (5): its two consumers; it does not bear on C132-TURN | item 21; the asking lane's record ll. 66–74 | appended under C132-EXT-DISC's entry in E1's record; under C132-TURN's in E4's |
| the two-pair ring is the release's Lean theorem | K1 § 2.3; item 25 | appended under C132-DIAG-WIDE's entry in E3's record |
| the exclusion's second reading, and its four-point form | K1 §§ 3.2, 3.4; E5 | appended under C132-M-ORBIT's entry in E3's record |
| the asking lane's `generalization` is a restatement | E5 § The exclusion, step by step | drafted (that record is not this job's): `plans/FS132-Z1-record.md` § 5 |
| the stripe colouring is not a witnessed triangle with a wild ring | E5 § The two controls at seven | drafted, the same place |
| the search's hand argument: step 3's second rule fails for germs only measurable | E6 § The two things the brief asks to carry visibly | drafted, the same place |
| rows 148–149's exclusion holds for measurable colourings with no Siamese clause, on stated terms | C132-M-EXCL; K1 § 3.2 | appended under FS116-Y4-EMPTY in `plans/FS116-derivation.md` and under FS129-SR3-EMPTY-NS and FS129-SR3-QFREE-NS in `plans/FS129-derivation.md` |

## 12. The line, tallied

| side | entries |
|---|---|
| **no side** — reads no ring and no edge set | C132-EXT-DISC, C132-EXT, C132-CORES-FREE, C132-CORES, C132-CORES-SQUARE (gap), C132-WIT-EX-FIN, C132-FILL, C132-NOESS, C132-REL, C132-INDEX, C132-RING-WIND, C132-ORBIT, C132-SEP, C132-CONFINE, C132-WITNESS, C132-WIT-CROSSED, C132-WIT-SUPER, C132-SHADOW; C132-DIAG-WIDE and C132-DIAG read no edge set (their ring, at a four-cycle's diagonals, is of kind (α): the release's) |
| **arc-free (α)** — the ring carries an outside label almost everywhere near the orbit | C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-WIT-EXCL, C132-M-EMPTY |
| **arc-free (β)** — no edge set of the centre on the unit circle about the ring point read (or at most one, the other two on one side) | C132-WIT-SIDE, C132-WIT-STRIP, C132-TRI-STRIP, C132-CROSS, C132-COMP-SHARP as an exclusion, C132-COMP, C132-PLACE, C132-ALT, C132-TURN-EDGE, C132-LENS-FOUR, C132-LENS-GERM; SEARCH-1007-TURN-SS |
| **the margin case** | C132-WIT-MARGIN, C132-GRUNDY7-NOT, C132-GRUNDY7-LOCAL; the second round's seven-colour controls at circumradius 2/5 |
| **reaches the hard case** | C132-LENS and C132-LENS-SIDE (hypotheses at the two neighbours, none at the ring point); C132-PLACED-RING (its conclusion is an arc of kind (α) at the placed point); C132-COMP-SHARP as stated (its conclusion is (β)); in a finite family, SEARCH-1007-TURN3, -TURN3-HAND, -ALT (the family holds both sides) and SEARCH-1007-TURN4 (a model of (β)) |

Not tallied: the stalls and gaps of § 8; C132-WIT, a conjunction whose three parts are placed above.

**In one sentence**: on the arc-free side the exclusions of centres that are not triangles, the complementary pair and the
alternating ring run with no map and no normal form, at one mind each; three statements of the third round conclude at
or produce the hard object from neighbours on the easy side; and nothing in this file excludes, builds or bounds a
boundary that is a unit arc about a ring point — "FS-124's, the open hard case" (item 29 (c)).
