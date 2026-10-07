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

An outside proof, this project's literature since 2026-10-07 (`[OAIMath2026]`, family 158;
`data/external/EXT-OAI1-request.md`), gave `χ(ℝ²) ≥ 6` and
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

derivation: C132-M-ORBIT
  statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
  uses only: weak properness in its measure form; Definition 5.1 (every trace's positive coordinates lie in the palette); Lemma 5.2 assertion (1) read locally (for almost every pair of unit vectors (e, v) with p + e + v in U, c(p + e + v) ∉ P_p(e) ∪ P_p(v)) and Cor. 5.4 (P_p(f) ∩ P_p(Rf) = ∅ for almost every f) — both read in `M/palettes.tex` ll. 118–308 and taken at six labels on the reading's word that their proofs spend no count (`plans/EXT-OAI2-reading.md` § 4.2 rows 2–3; I read both proofs and found no count in them; one mind); of the sets K_j only that p ∈ K_j, K_j ≠ {p}, and the exclusion — E0 as a point, E1 as four labels in a cycle, clause (1) as "K_j is not {p}", clause (3) in C132-CONFINE's first form; the parallelogram law; e(ψ) + e(ψ + 2π/3) = e(ψ + π/3); the unit-pair relation between points near two ring points π/3 apart (M7); Lebesgue density on the line (M8); six labels, at M2 and at M9. It reads nothing of clause (2) (limiting directions), clause (4), clause (5), connectedness of the K_j, isolation of p among cyclic centres, Lemma 6.2, Lemma 8.1, or any tile, sector, arc or finiteness
  not claimed: anything when the palettes near one of the six directions ψ + kπ/3 hold no outside label on a set of positive measure (rings with (Q) arcs at the orbit: FS-124); that a six-colouring with hypothesis (a) exists; that a point whose transition graph contains a four-cycle carries the sets K_j (that is the extraction's, under its hypothesis on the centres); anything at seven labels or more (M2 and M9 spend six); anything about a cycle of three, five or six labels; any value of χ(ℝ²); that a map's four-colour vertex carries the sets K_j (the edge exclusion for maps is row 134's base, not re-derived here)
  argument: FS132-E3-derivation.md § Argument — the orbit form
  verdict: derived
  grade: hand
  minds: 1 — one derivation (FS132-E3). A second mind, the kernel lane's planner (FS132-K1), kept from the derivers' records until its commit 1eb4b94b, reached blind the state, the chart, a forced label at each hub by another route, the unit-pair relation on its diagonal and the kill for a clean change, and stopped at the step lemma (M8); with the fence lifted it read M4 to M9 line by line and found no gap. FS132-E5 reworked M1 to M6 from the argument and read M7 to M9. The number is 1 because M6 and M8 have one derivation and readings made with the argument open, and the weakest step governs; the table under the entry says who did what
  model: none can exist (a non-existence). The hypotheses other than (i)–(ii) are met, as maps, at the held fragments' four-colour vertices (the strip's P0 and P1, the Y2 bowtie's centre: four tiles in cyclic order whose common edges carry the two-colour exclusion — taken from row 134's base and `[SokolovVoronov2025]` Props. 1–2, not re-derived); there (i) fails at every change point: at least two of its four germs at ±60° lie on (Q) arcs (control `positives-escape`). At nine labels SQ9's lattice vertex meets every hypothesis but the count (FS116-V6's control `v6-sq9`, not rerun)
  prior art: partly: the palette calculus is `[OAIMath2026]` §§ 5.1–5.3; steps M1–M5 and M9 are FS116-V6's V6-RING, -GERM, -TIP, -DIAM, -ANTI and -HUG restated in measure (in-house; row 148); M6 and M8 and the statement are not in the release (its § 8 treats the four-cycle only with one outside label); the search for them in print is owed — the plan's §PA of 2026-10-07 found no six-colour form of the release's §§ 5–8, and this job's two queries failed (§ Prior art, this job)
  handoff: de Bruijn — the statement as written, over the release's palettes at `Fin 6` (`Palettes.lean`, `palette_transport_param`, `palette_sixty_disjoint`, each already at every k): hypotheses a weak colouring on an open set containing the closed unit disc, four compact sets through p with the support exclusion, the two-clause ring hypothesis; conclusion False. Leaves in the order of the argument: the chart Z and (⋆); tips exist; confinement; one tip per hub; the three-axes count (finite, 64 cases); the unit-pair relation with its sign; the step lemma; the kill. Read the formal statement back against this one, clause (ii) above all

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

control: hug-shift
  of: C132-M-ORBIT — step M7: the unit-pair relation between points near two ring points 60° apart, the sign of its shift, and the pairs step M9 uses
  run: python3 ../data/fs132/e3/hug_shift.py
  expect: ratio-min=1.1614 ratio-max=1.2411 limit=1.1547 nonpositive=0 bad-pairs=0 axis-below-1e-30=True
  fault: python3 ../data/fs132/e3/hug_shift.py --fault

control: three-axes
  of: C132-M-ORBIT — step M6: every tip pattern on six hubs that is consistent with the three axes has two adjacent hubs of equal tip
  run: python3 ../data/fs132/e3/tau_count.py
  expect: sign-consistent=36 of 64; kind-A=12 kind-B=24; with no adjacent equal tips=0
  fault: python3 ../data/fs132/e3/tau_count.py --fault

control: positives-escape
  of: C132-M-ORBIT — the positives: at every change point of the held fragments' four-colour vertices a germ of the orbit lies on a (Q) arc, so hypothesis (i) fails there
  run: python3 ../data/fs132/e3/positives_check.py
  expect: rings=4 change-points=8 all-four-germs-off-Q=0 least-germs-on-Q=2
  fault: python3 ../data/fs132/e3/positives_check.py --fault

derivation: C132-WIT-ORBIT
  statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let q_j be a point other than p with H_{a_j} ∩ Δ({p, q_j}) = ∅ and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
  uses only: C132-M-ORBIT (`plans/FS132-E3-derivation.md` Stage 3) at K_j = {p, q_j}, a compact set containing p and a point other than p; nothing else. Read against its argument step by step (§ The exclusion, step by step): of the sets it reads, for each j, that p is in the set, one point q_j of it other than p, and the two-label exclusion for the pair {p, q_j}
  not claimed: more than C132-M-ORBIT — this is that theorem, not a wider one: C132-M-ORBIT follows from it by taking any q_j in K_j other than p, since Δ({p, q_j}) ⊂ Δ(K_j) (control `delta-monotone`); what C132-M-ORBIT does not claim; that the labels a_j are present at p or anywhere near it (nothing in the hypotheses says so, and nothing in the argument uses it); a second reading of M7 to M9, which I read and did not rework
  argument: FS132-E5-derivation.md § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-M-ORBIT
  minds: 1
  model: none can exist (a non-existence). The hypotheses on the q_j alone are met with room at every point p within 0.01 of a vertex of the hexagonal seven-colouring, for the vertex's three labels and every q_j within 0.012 of p (control `margin-witness`, Stage 3) — at seven labels, where the statement does not apply
  prior art: partly: as C132-M-ORBIT's own line (`plans/FS132-E3-derivation.md` Stage 3); the restatement is this project's; owed — three zbMATH queries on 2026-10-07 05:26 UTC answered 503 (§ Prior art, this job)
  handoff: none — subsumed by C132-M-ORBIT, which crosses; what the kernel lane should take from this entry is that its hypothesis may be stated with four points q_j in place of four compact sets, losing nothing

**The four-point wording — the form to formalize.** The kernel planner makes it the leaf, at the whole plane
(`SixRing.no_outside_orbit_points`), and proves the compact-set wording from it in its skeleton ("the compact-set form
asks more of the hypothesis, so it is the weaker theorem … Compactness of the `K j` is not used at all", K1 § 3.4). Its
`grade:` line reads "derived from: C132-M-ORBIT" because the argument is written there; the other direction is one line.
**Side:** as C132-M-ORBIT. **A correction on record:** the asking lane's `generalization` item for this form
(`plans/POROS-2026-10-07-fs132-night.md` § 1.3, finding A; item 11) "is therefore a restatement, not a generalization"
(E5, the same section) — drafted for that record in `plans/FS132-Z1-record.md` § 5.

control: delta-monotone
  of: C132-WIT-ORBIT — the two-point hypothesis is the weaker one: the straddle set of {p, q} lies in the straddle set of every finite K containing p and q (100,000 fixed samples)
  run: python3 ../data/fs132/e5/wit_check.py mono
  expect: in-the-smaller=28434 violations=0
  fault: python3 ../data/fs132/e5/wit_check.py mono --fault

derivation: C132-M-EXCL
  statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
  uses only: C132-M-ORBIT; Cor. 5.4 once more, to see that a ring whose palettes almost everywhere hold an outside label has an essential change point
  not claimed: what C132-M-ORBIT does not claim; that the centre is binary for no pair at all (only for the pair outside the cycle)
  argument: FS132-E3-derivation.md § Argument — the ring form
  verdict: derived
  grade: derived from: C132-M-ORBIT
  minds: 1
  model: none can exist (a non-existence); the model line of C132-M-ORBIT
  prior art: partly: as C132-M-ORBIT; in the map class and for non-Siamese fragments this is row 149's statement (FS129-SR3-QFREE-NS), proved there through FS-112's bends
  handoff: de Bruijn — as C132-M-ORBIT's corollary; the formal statement to read back is this one

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

derivation: C132-WIT-EXCL
  statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the points q_0, q_1, q_2, q_3 be as in C132-WIT-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
  uses only: C132-M-EXCL at K_j = {p, q_j}
  not claimed: more than C132-M-EXCL (it follows from this entry as C132-M-ORBIT does from C132-WIT-ORBIT); what C132-M-EXCL does not claim
  argument: FS132-E5-derivation.md § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-M-EXCL
  minds: 1
  model: none can exist (a non-existence); the model line of C132-WIT-ORBIT. An instance worth its sentence: no weak measurable six-colouring of an open set containing a closed unit disc carries only two labels, almost everywhere, on an annulus about the unit circle — the four absent labels are witnessed at the centre by every nearby point
  prior art: partly: as C132-WIT-ORBIT
  handoff: none — subsumed by C132-M-EXCL, which crosses

The ring form with four points: C132-M-EXCL itself. **Side:** as C132-M-EXCL.

derivation: C132-DIAG-WIDE
  statement: let U be an open set of the plane containing the closed unit disc about a point p, c a weak measurable six-colouring of U, and D, D′ two disjoint pairs of labels; then there is no measurable map w from the unit circle to {D, D′} with w(e) ⊂ P_p(e) and w(Re) ≠ w(e) for almost every unit vector e, R the rotation by π/3
  uses only: `[OAIMath2026]` Lemma 5.2 assertion (2) (at an angular density-one direction e of the set of directions whose palette holds i, the class of i has density zero at p + e + v for every v not parallel to e), Lemma 4.3 (two density-one points of one class are not at distance 1) and the argument of Lemma 6.4 (`M/transitions.tex:228–272`) with its one count read as "the labels outside D ∪ D′ are two"; that cos γ = 5/6 makes γ/π irrational; that the three points p + e(t + 2jπ/3)(1 − e(γ)) are pairwise 1 apart at distance 1/√3 from p
  not claimed: anything about a ring that takes a third state (a palette holding an outside label) on a set of positive measure — the mixed rings of FS-124; anything at seven labels or more (three labels outside leave the triangle properly colourable)
  argument: FS132-E3-derivation.md § Argument — the two-diagonal ring
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence); at five labels the same argument is the release's Lemma 6.4, with one label and one pair
  prior art: known: `[OAIMath2026]` Lemma 6.4, whose Lean form `two_state_impossible {k}` carries the count as the hypothesis that at most two labels lie outside (`plans/EXT-OAI2-reading.md` § 4.2 row 8; the Lean not read by this job) — this entry is its instance at six labels with two pairs, read from the manuscript's proof
  handoff: de Bruijn — the instance of the release's `two_state_impossible` at `Fin 6` with `J`, `K` the two pairs; read `RealState` first (unread by the reading and by this job)

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

derivation: C132-WIT-SIDE
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels, H_i the closed essential support of the class of i, E a set of labels, x and q two distinct points with H_i ∩ Δ({x, q}) = ∅ for every i in E, and w a point of U with |w − x| = 1 and |w − q| ≠ 1; then there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has its label outside E if |w − q| < 1, and almost every point z of B(w, η) with |z − x| < 1 has its label outside E if |w − q| > 1
  uses only: that {z : |z − q| < 1 < |z − x|} and {z : |z − x| < 1 < |z − q|} are open and lie in Δ({x, q}); that an open subset of U missing H_i meets the class of i in a null set. No properness, no palette, one witness
  not claimed: anything when |w − q| = 1; anything about the other side of the unit circle about x; that the labels of E are present anywhere
  argument: FS132-E5-derivation.md § Argument — one side of a unit circle
  verdict: derived
  grade: hand
  minds: 1
  model: the model of C132-WIT-STRIP, edge by edge
  prior art: partly: it is step B1 of the ring card's C132-CROSS (`plans/FS132-E4-derivation.md` Stage 2, derived the same night by another mind) and the first paragraph of C132-TRI-STRIP's argument with its point held fixed; in print, the mechanism of `[OAIMath2026]` Lemma 8.1 for continua; this form owed
  handoff: de Bruijn — the statement as written; it is the leaf under C132-WIT-STRIP, C132-TRI-STRIP and C132-CROSS, and by the coordinator's ruling the entry that crosses for the strips

**The strips' leaf, and the entry that crosses for them** (items 18 (c), 24). One witness, one side of one unit circle,
any measurable labelling — no properness. It carries the strip clauses of C132-WIT-STRIP (three witnesses and the
majority rule) and of C132-TRI-STRIP (a witness chosen on each continuum, close to `x`), and it is step B1 of C132-CROSS —
derived the same night by another mind in the ring card's record, in the same form ("nothing of either record is wrong",
item 18). **Side: arc-free (β), edge by edge** — it is silent when `|w − q| = 1`: an edge set lying on the unit circle
about the ring point `w` has no witness off that circle.

Rests on it: C132-WIT-STRIP, C132-TRI-STRIP, C132-CROSS, C132-PLACE, C132-LENS-SIDE.

derivation: C132-WIT-STRIP
  statement: let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable k-colouring of U, i_0, i_1, i_2 three distinct labels, N the set of the other k − 3 labels, and for each j modulo 3 let q_j be a point other than x with H_{i_j} ∩ Δ({x, q_j}) = ∅ and H_{i_{j+1}} ∩ Δ({x, q_j}) = ∅; then for every unit vector e with |x + e − q_j| ≠ 1 for j = 0, 1, 2 there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if |x + e − q_j| < 1 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if |x + e − q_j| > 1 for at least two j; the unit vectors f with |x + f − q_j| = 1 for some j are those with 2 f·(q_j − x) = |q_j − x|², at most six; and P_x(e), read with samplings inside U, meets N for almost every e
  uses only: that an open set missing H_i meets the class of i in a null set; |x + r f − q|² = r² + |q − x|² − 2 r f·(q − x) and its continuity in (r, f); that two edges of a triangle have all three vertices among their endpoints; for the last clause the end of the proof of `[OAIMath2026]` Lemma 8.1 (`M/angular.tex:71–88`, read: radii tending to 1 from the pure side through typical samplings at the centre x; no count of labels), taken for a colouring of U on the first night's local reading of the palettes (one mind, `plans/FS132-E3-derivation.md` M0)
  not claimed: purity of both sides at one direction; that P_x(e) lies inside N; anything at the at most six excluded directions; that the labels i_j are present at x; that a point x with such q_j is a cyclic centre (it need not be: control `margin-witness`, Stage 3); anything for a cycle of four or more labels; that the class is inhabited at six
  argument: FS132-E5-derivation.md § The strips, with one witness per edge
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5, x the vertex (0, 2/5) with labels 0, 3, 2, and q_j the point of each of its three edges at distance 0.3 from x: |q_j − x|² = 0.09, so the side changes where f·(q_j − x)/|q_j − x| = 0.15, about 8.6° from the perpendiculars, and N = {1, 4, 5, 6}; there both sides are in fact pure at every direction (the three labels keep off the annulus 0.97 ≤ |z − x| ≤ 1.03), so the model satisfies the statement with room and does not test the side rule — the control `strip-sides` does
  prior art: partly: `[OAIMath2026]` Lemma 8.1 is the strip statement at five labels for continua with limiting directions; C132-TRI-STRIP (`plans/FS132-E2-derivation.md` Stage 3) is its form at every k for a triangle; the form with one witness per edge and the side rule |x + e − q_j| ≷ 1 not found — owed (§ Prior art, this job)
  handoff: de Bruijn — as C132-TRI-STRIP's general form: three points in place of three continua with limiting directions; the leaf is one inequality on |x + r f − q| and a case split on three signs. C132-TRI-STRIP then follows by choosing, for each direction, a witness close enough to x (§ The strips, last paragraph)

**The strips with one witness per edge.** Wider than C132-TRI-STRIP, which is its corollary: the limiting direction "was
only a way to find a witness on the wanted side" (item 18). Its last clause — every palette meets the outside labels — is
the one place the strips read properness and the release's Lemma 8.1 (the end of its proof, read by E5; one mind).
**Side: arc-free (β)** — the at most six directions it excludes are those at which a witness is at distance 1 from the
ring point.

control: strip-sides
  of: C132-WIT-STRIP — the side rule: just outside the unit circle about x in direction f a point lies in the straddle set of {x, q} exactly when |x + f − q| < 1, just inside exactly when |x + f − q| > 1 (200,000 fixed samples, |q − x| between 0.05 and 2.5); the fault predicts the side by the sign of f·(q − x), the rule for a limiting direction
  run: python3 ../data/fs132/e5/wit_check.py sides
  expect: samples=200000 outer=50147 inner=149853 disagreements=0
  fault: python3 ../data/fs132/e5/wit_check.py sides --fault

derivation: C132-TRI-STRIP
  statement: Let k ≥ 3, c a weak measurable k-colouring of the plane, and x, ρ, labels i_0, i_1, i_2, continua K_j and directions v_j satisfying clauses (1), (2), (3) of C132-EXT-DISC with ℓ = 3; let N be the set of the other k − 3 labels; then for every unit vector e perpendicular to none of the v_j there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if e·v_j > 0 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if e·v_j < 0 for at least two j; and P_x(e) meets N for almost every e
  uses only: clause (3) and x ∈ K_j; the points of K_j tending to x with directions tending to v_j; that a set missing H_i meets the class of label i in a null set; that two edges of a triangle have all three vertices among their endpoints; for the last clause the one-sided traces of `[OAIMath2026]` Lemma 8.1 (`M/angular.tex:73–95`, read with its proof, which reads no count of labels)
  not claimed: purity of both sides at one direction; that P_x(e) lies inside N; anything at the at most six directions perpendicular to a v_j; anything for ℓ ≥ 4 (a four-cycle has four of its sixteen sign patterns with no pure side: the fault of control `tri-strips`); that the class is inhabited at six
  argument: FS132-E2-derivation.md § Argument — one-sided pure strips
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring at the vertex (0, 2/5) with its three edges: N = {1, 4, 5, 6}, and there both sides are pure at every direction (control `hex7-relation`: own-on-rings empty at radii 0.98, 1, 1.02)
  prior art: partly: `[OAIMath2026]` Lemma 8.1 is the strip statement for the sets O(e), I(e) at five labels; its use at a triangle is the opening of its Proposition 8.10 (by `plans/EXT-OAI2-reading.md` § 3.1; `M/angular.tex` past line 125 not read by this job); the statement at every k with the majority rule not found in print by the milestone's gate
  handoff: de Bruijn — from the release's strip lemma (`AngularBoundary.lean`, `BoundaryTrace.lean`, typed at every k by the reading § 4.2 row 14) with a case split on three signs

**The strips as first derived**, for the extraction's continua with limiting directions; a corollary of C132-WIT-STRIP
(E5 § The strips, with one witness per edge, last paragraph). Kept as an entry because C132-RING-TAME, C132-LONG, C132-COMP
and C132-TURN are stated over its data. **Side: arc-free (β)** — silent at the directions perpendicular to a limiting
direction, which is where a continuum can run along the unit circle about the ring point.

control: tri-strips
  of: C132-TRI-STRIP — the eight sign patterns of a triangle's three edges: in none do both sides keep a label of the triangle
  run: python3 ../data/fs132/e2/ring_checks.py strips
  expect: cycle-length=3 patterns=8 neither-side-pure=0
  fault: python3 ../data/fs132/e2/ring_checks.py strips --fault

derivation: C132-SHADOW
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, p and p′ two points of U with |p − p′| = 1, v a unit vector with v·(p′ − p) ≠ 0, r > 0, and W an open subset of U that contains the points p′ + sv for 0 < s < r and almost every point of which has the label i; then there is η > 0 such that, if v·(p′ − p) > 0, almost every point z of B(p, η) with |z − p′| < 1 has a label other than i, and, if v·(p′ − p) < 0, almost every point z of B(p, η) with |z − p′| > 1 has a label other than i
  uses only: the intermediate value theorem for s ↦ |p′ + sv − z| on (0, r); that W is open; Fubini for (z, u) ↦ z + u; weak properness in its measure form. It reads no palette, no chart, no exclusion set, no connectedness of W, and nothing of the number of labels
  not claimed: anything when v is tangent at p′ to the unit circle about p — then only the points whose unit circle crosses that circle inside W are reached, a sub-wedge whose opening shrinks with the size of W (control `seeing`: 0.194, 0.083, 0.000); anything for a set W that is not open (a set of positive density reaching p′ gives the statement for the points whose unit circles meet it in positive length, which need not be almost all points of a side); anything about the other side of the unit circle about p′
  argument: FS132-E6-derivation.md § Argument — the shadow of an open piece
  verdict: derived
  grade: hand
  minds: 1
  model: the search's kept four-label fragment (`data/search/2026-10-07/KEEP-turning-4label-arcs.json`, [cert]): p = y_0, p′ = y_1, W its wedge O_far at y_1 (a label of x), v radial — the wedges at y_0 inside the unit circle about y_1 carry b, b, b; over its six adjacent pairs of ring points, all 108 pairs of wedges on matching sides carry different labels (control `kept-model`)
  prior art: partly: in this project it is C132-WITNESS (`plans/FS132-E4-derivation.md` Stage 2) followed by C132-WIT-SIDE (`plans/FS132-E5-derivation.md`) with the centre at p′ and a segment of W as the set, and G84's shadow identity read for an open piece; in the map class it is the ring calculus's "a tile of p′ tips p" (G91); in print the mechanism is `[OAIMath2026]` Lemma 8.1 by FS132-E5's reading (not read by me); this form not searched for in print by this job — owed
  handoff: de Bruijn — the statement as written: one intermediate value, one open set, one Fubini; no colouring theory beyond weak properness. It gives the strips their second half (from an open piece instead of an exclusion set) and is the only tool C132-LENS adds to C132-PLACE

**The side rule for an open one-label piece** — "the stub's 'side rule for open pieces', which no entry stated" (item
28): the strips' other half, from a piece of the colouring in place of an exclusion set, at every number of labels. In
this project's terms it is C132-WITNESS followed by C132-WIT-SIDE with the centre moved to the ring point (its prior-art
line); E6 derives it directly, with no connectedness of the piece. **Side: no side** — "it reads open sets and no edge
set" (E6 § The two things the brief asks to carry visibly). What it does not reach is a piece meeting the point
tangentially to the unit circle (its *not claimed* line; control `seeing`) — which is where the search's hand argument
fails for germs only measurable (§ 6).

Rests on it: C132-LENS and what follows it (§ 5). **Read off, not entered** (E6 § The list): it gives C132-ALT's cases
O, I and I, O by a second route with no unit-pair shift.

control: seeing
  of: C132-SHADOW — which wedges at y_0 have every point's unit circle through which wedges at y_1, and back; and, for the two pairs of the search's steps 3 and 4, the fraction of the looking wedge that sees the other, at sizes 0.2, 0.05, 0.0125 of the wedge seen
  run: python3 ../data/fs132/e6/lens_checks.py seeing
  expect: full-pairs=18 [I_ccw+I_lens+O_ccw]x[I_ccw+O_ccw+O_far] and [I_cw+O_cw+O_far]x[I_cw+I_lens+O_cw] product=True same-pairs-back=True lens1-seeing-Occw0=0.194,0.083,0.000 far1-seeing-far0=0.167,0.083,0.000
  fault: python3 ../data/fs132/e6/lens_checks.py seeing --fault

control: kept-model
  of: C132-SHADOW — the search's kept four-label fragment: its 108 pairs of wedges on matching sides at adjacent ring points, its labels at each ring point, where its lens carries a label of x, its interfaces at x and its sides
  run: python3 ../data/fs132/e6/lens_checks.py model
  expect: first-order-pairs=108 equal-labels=0 labels=012,1234,012,0145,012,0235 lens-in-T-at=[1, 3, 5] points-with-a-b-n-and-one-of-T=[] interfaces-of-x=3 on-unit-circles-about=[1, 3, 5] sides=I-I-I- points-with-both-neighbours-outer-pure=[]
  fault: python3 ../data/fs132/e6/lens_checks.py model --fault

derivation: C132-WITNESS
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and R a connected open subset of U almost every point of which has the label i; then the closed essential support of the class of i is disjoint from Δ(K) for every compact set K contained in the closure of R
  uses only: that a connected open set is path-connected; the intermediate value theorem for the distance to a point along a path; Fubini for the map (z, u) ↦ z + u; weak properness in its measure form
  not claimed: that the regions of a weak colouring are open, connected or of one label — a weak colouring need have no such region; that an edge of a transition graph is witnessed (the relation between the two is not derived here, and is where C132-TURN stalls in Stage 3); anything for a region that is not connected
  argument: FS132-E4-derivation.md § Argument — a region witnesses its label
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, R the interior of a tile and K one of its edges: a point of the tile's label lies in that tile, within 4/5 of every point of K, or in another tile of that label, farther than 1 from every point of the first tile (the two are at least 1.033 apart) — in neither case in Δ(K)
  prior art: known: the edge exclusion of a map colouring — `[SokolovVoronov2025]` Props. 1–2 by this project's row 134 (not read by this job) and `[OAIMath2026]` (7.1) with Proposition 7.1 (3) for continua; the statement for a region of a weak colouring is that argument
  handoff: de Bruijn — only with a consumer (C132-TURN-EDGE reads a witnessed edge and does not derive one); a path, the intermediate value theorem and Fubini

A relay-result: a map's edges are witnessed edges. Nothing says a weak colouring has such a region. **Side: no side.**
Used by C132-COMP-SHARP's model (fragment T2) and by C132-PLACED's line PL5; "read, not reworked" by its user (E6's
report).

derivation: C132-CONFINE
  statement: let K be a compact connected set and H a set with H ∩ Δ(K) = ∅; then for every z ∈ H, either K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅; in particular, if x ∈ K and z ∈ H with |z − x| < 1 then K ⊂ B̄(z, 1), and if x ∈ K, z ∈ H, |z − x| = 1 and (q_m) is a sequence in K ∖ {x} tending to x with (q_m − x)/|q_m − x| → v, then v·(z − x) ≥ 0 when K ⊂ B̄(z, 1) and v·(z − x) ≤ 0 when K ∩ B(z, 1) = ∅
  uses only: the definition of Δ(K); for the last clause, |q − z|² = 1 − 2 (q − x)·(z − x) + |q − x|² when |z − x| = 1. Connectedness of K is not used
  not claimed: which of the two cases occurs; that the two cases exclude each other when |z − x| = 1 (K = {x} satisfies both); anything about labels — the statement has no colouring in it
  argument: FS132-E1-derivation.md § Argument — confinement
  verdict: derived
  grade: hand
  minds: 1
  model: K the segment from (0, 0) to (0.3, 0) and H = {(0.15, 0.9)} — the largest distance from that point to K is √(0.15² + 0.81) ≈ 0.912 < 1, so it is outside Δ(K) and K ⊂ B̄(z, 1); checked on the hexagonal model by control `hex7-model`, whose zero count is this statement's contrapositive for the supports of the two edge labels
  prior art: known: the contrapositive of the manuscript's definition (7.1) of the straddling region; the sign form is the mechanism of its Lemma 8.1 (read at its statement in `plans/EXT-OAI2-reading.md` § 3.1, not in `M/angular.tex`)
  handoff: none — a relay-result for the readings (the dictionary's replacement for "the same tile")

**The dictionary's replacement for "the same tile".** **Wider, by the kernel planner, blind** (K1 § 2.3): "`K` any set
(no compactness, no connectedness); the direction clauses use neither `H` nor `x ∈ K`" — proved in Lean on branch
`fs132-wk1` (`Plane/SixRing/Confine.lean`: `SixRing.confine_of_disjoint`, `subset_closedBall_of_dist_lt`,
`inner_nonneg_of_subset_closedBall`, `inner_nonpos_of_disjoint_ball`; "proved, built"), not landed on `main`. So: [hand],
one mind, in E1's words above; a second derivation, blind, and a kernel proof of the wider form on an unmerged branch
(item 30; the claim list's dated line (iv)). The entry keeps `minds: 1` and its source's statement; the wider form is the
one to land, and the count is the coordinator's to rule when it does. **Side: no side** — no colouring in it.

Rests on it: M4 of C132-M-ORBIT; C132-TURN-EDGE. "Not verified" by E6 where it inherits it through C132-TURN-EDGE (its
report).

derivation: C132-WIT-MARGIN
  statement: let c be a measurable map from the plane to a finite set of labels, H_i the closed essential support of the class of i, p a point, η > 0, and I a set of labels each of whose supports H_i misses the open annulus of the points z with 1 − η < |z − p| < 1 + η; then H_i ∩ Δ({p, q}) = ∅ for every i in I and every point q with 0 < |q − p| ≤ η; so if I has at least three labels, every cyclic order of three or more of them, with any such points q_j, satisfies the conclusion of C132-WIT-EX at p
  uses only: the triangle inequality — a point z with one of |z − p|, |z − q| below 1 and the other above 1 has | |z − p| − 1 | < |q − p|
  not claimed: that p is a cyclic centre, or that any label of I is present at p (control `margin-witness`: thirteen points about a vertex, twelve of them no centres); that every weak colouring has such a point; the anchored form
  argument: FS132-E5-derivation.md § Argument — witnesses by margin
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, and the island and the stripe colourings built on it at a vertex v: every p within 0.01 of v, I the three labels of v, η = 0.012 (control `margin-witness`); in the plain colouring the same at every vertex
  prior art: owed — elementary; the statement is this project's
  handoff: none — a relay-result: it says where C132-WIT-EX is free, and that a witnessed cycle does not locate a centre

**Where the data exist for free: at every point with a margin for three labels — points that are no centres.** It is
why "a witnessed cycle at `p` is a property of the unit circle about `p`, not of `p`" (item 14), and why existence "as
posed is free wherever a colouring has such a margin". **Side: the margin case** — the far end of the arc-free side: its
hypothesis keeps the labels off an annulus about the unit circle. **The control, re-run** (E6 § The two riding controls):
at circumradius 1/2 the hypothesis fails — the vertex's labels on the annulus go from 0 to 6,672 samples, "at 1/2 no
witness comes from a margin"; the entry is untouched. A dated line is under the control in E5's record.

control: margin-witness
  of: C132-WIT-MARGIN — the plain, island and stripe colourings at seven: thirteen points within 0.01 of the vertex X = (0, 2/5), the annulus 0.988 ≤ |z − p| ≤ 1.012 about each (7 radii × 3600 angles): no sample carries a label of X, and the four other labels are all seen; the fault takes the thirteen points about a hexagon's centre
  run: python3 ../data/fs132/e5/margin_check.py witness
  expect: colourings=3 points=13 samples=982800 vertex-labels-on-annulus=0 labels-seen=1456
  fault: python3 ../data/fs132/e5/margin_check.py witness --fault

derivation: C132-WIT-CROSSED
  statement: let H be a set of the plane, p a point and f_1, f_2, f_3 three distinct unit vectors such that each point p + f_m is a limit of points of H nearer than 1 to p and a limit of points of H farther than 1 from p; then no point q other than p has H ∩ Δ({p, q}) = ∅
  uses only: the definition of Δ; that two distinct points have at most two points at distance 1 from both
  not claimed: anything when H approaches the unit circle about p from both sides at two points only — then the one candidate is q = p + f_1 + f_2; anything for a set that touches the circle from one side
  argument: FS132-E5-derivation.md § Argument — a label that crosses the circle has no witness
  verdict: derived
  grade: hand
  minds: 1
  model: H a hexagon of label 3 of the hexagonal seven-colouring and p the centre of the neighbouring hexagon of label 0: H crosses the unit circle about p along an arc (the fault of control `margin-witness`: with the thirteen points taken about a hexagon's centre, 327,600 samples of the annulus carry a vertex label)
  prior art: owed — elementary
  handoff: none — a relay-result: with C132-WIT-MARGIN it says which labels can be witnessed at a point, from the trace of their supports near its unit circle

Which labels have no witness at a point. **A correction on record** (E5 § The two controls at seven; item 19): at the
stripe colouring's centre "two of the three hexagons at `v`" are crossed by its unit circle "along arcs, and those two
labels have no witness at `x` at all … with the stripes or without" — so the stripe colouring is not a witnessed triangle
with a wild ring; it stays a control for a three-label palette only. **Side: no side.**

derivation: C132-WIT-SUPER
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane, i a label, p_i^ε(z) the proportion of the disc of radius ε about z lying in the class of i, α > 0, (ε_n) a sequence of positive numbers tending to 0, C_n connected sets with p_i^{ε_n} > α at every point of C_n, and K the set of the limits of convergent sequences (z_n) with z_n in C_n; then no point of the closed essential support H_i has one point of K nearer than 1 and another farther than 1
  uses only: weak properness in the form |A_i ∩ (A_i − u)| = 0 for every unit vector u (from almost every u by continuity of translation in L¹), which gives p_i^ε(y) + p_i^ε(z) ≤ 1 at every unit pair (y, z); that a connected set with a point nearer than 1 to z and a point farther than 1 has a point at distance 1; p_i^ε → 1 on the class and 0 off it in L¹ on bounded sets. One label; no second label, no map to a graph, no hole, no cyclic centre, no isolation, no count of labels
  not claimed: that K has more than one point for any choice of the C_n — where a class is dust near a point every such K through it is that point (§ The stall); anything for sets C_n that are connected only after holes are filled
  argument: FS132-E5-derivation.md § Argument — connected pieces of a smoothed class carry the exclusion
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, label 0, α = 1/4, C_n the closed hexagon of centre (0, 0) for every n (the proportion is at least 1/3 at each of its points once ε_n < 0.3): K is that hexagon, and the conclusion is its margin — diameter 0.8, every other hexagon of label 0 more than 1.03 away
  prior art: partly: it is the proof of clause (3) of `[OAIMath2026]` Proposition 7.1 as the first deriver reworked it (`plans/FS132-E1-derivation.md` S2, S7, S9; `M/interfaces.tex` not opened by this job), with the fibre of the graph map replaced by any connected subset of one superlevel set, which removes the holes and with them every use of the centres; that form owed
  handoff: de Bruijn — beside the release's `continuum_limit_support_exclusion` and `diskAverage_unit_pair` (named by the first deriver as general in the label type): the same proof with the hypothesis "connected, inside one superlevel set"; read the formal statement back against this one

**The exclusion clause from any connected subset of one smoothed class's superlevel set**: "no hole, no exceptional set,
no centre, no isolation, one label at a time. So the exclusion's proof is not where isolation is read; the step before it
is" (item 18). It takes the extraction's place in the kernel lane's queue (item 24). **Side: no side.**

Rests on it: the statement of where C132-WIT-EX stalls (§ 8).

## 3. Centres exist; the extraction; the filled target

derivation: C132-EXT-DISC
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane (`[OAIMath2026]` Definition 1.2), 𝓛 the set of its cyclic centres (the points x whose transition graph Γ_x, Definition 6.1 read with k labels, contains a cycle), and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite; then there are a point x of 𝓛 in the interior of D, an integer ℓ with 3 ≤ ℓ ≤ k, distinct labels i_0, …, i_{ℓ−1}, a radius ρ > 0 with B̄(x, ρ) ⊂ D and 𝓛 ∩ B̄(x, ρ) = {x}, and for each j modulo ℓ a compact connected set K_j ⊂ B̄(x, ρ), a unit vector v_j and points q_{j,m} of K_j other than x, such that (1) x ∈ K_j and K_j meets the circle ∂B(x, ρ); (2) q_{j,m} → x and (q_{j,m} − x)/|q_{j,m} − x| → v_j as m → ∞; (3) H_{i_j} ∩ Δ(K_j) = ∅ and H_{i_{j+1}} ∩ Δ(K_j) = ∅, where H_i is the closed essential support of the class of label i and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; (4) K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}; (5) i_j i_{j+1} is an edge of Γ_x
  uses only: Definition 1.2 and Lemma 4.3 at k (density points of a class hold no unit pair); Definition 6.1 and that each edge-presence locus is closed; Lemmas 7.2 and 7.3 (which read two labels at a time); the threshold map with 0 < α < 1/k; that a clique in a forest has at most two vertices; trees are contractible; Lemma 7.5's argument on a disc of radius above the mesh (Brouwer); Lemmas 7.7 and 7.8 for a finite connected simple graph (or `annulus_forest_extension`, any finite vertex type); Hausdorff limits of continua; finitely many simple cycles in the complete graph on k labels. Of the centres it reads finiteness of 𝓛 ∩ D at three places: (i) Lemma 7.4 — the core discs' total radius |𝓛 ∩ D|·δ → 0 and one core disc per centre (`M/interfaces.tex:265–287`), consumed as |E_n| → 0 in the mesh bound and in clause (3); (ii) the pigeonhole "pass to a subsequence with a fixed x" (`:579–581`); (iii) **isolation of that x in 𝓛**, at "Choose ρ > 0 so small that B̄(x, ρ) … contains no other point of L_0 … The map g_n is therefore defined on the closed annulus" (`:581–590`) and at Lemma 7.8's use of the annulus's fundamental group ℤ (`:515–520`, `:568–571`): the continuum must cross an annulus about x that holds no other centre. It reads nothing of § 5, of Lemma 6.2 or of the state lemmas (control `sec7-cites`)
  not claimed: the conclusion when 𝓛 ∩ D is infinite — closed and totally disconnected does not let this argument run (§ Card 2); that a point whose transition graph contains a cycle of length ℓ carries this data with a cycle of length ℓ (the argument selects a centre by an essential loop of the nerve map; the converse of clause (5) is open, § The relation asked for); that the hypothesis holds for any six-colouring; that ℓ ≥ 4 at any centre; any value of χ(ℝ²); sharpness of the radius 1
  argument: FS132-E1-derivation.md § Argument — the extraction on a disc
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 and any closed disc of radius above 1 — its cyclic centres are the honeycomb's vertices (18 of them in the disc of control `hex7-islands`), and at the vertex (0, 2/5) the data is the triangle of labels 0, 3, 2 with the three edges cut at ρ = 0.3 (control `hex7-model`); for k ≤ 5 no weak measurable k-colouring exists (`[OAIMath2026]` Theorem 1.4) and the statement is vacuous; at k = 6 the class is not known to be inhabited
  prior art: partly: `[OAIMath2026]` Proposition 7.1 with Lemmas 7.2–7.8 is this argument at five labels on a square of side ten, with clauses (1)–(3) and the sentence "The extracted cycle need not consist of edges of Γ_x"; the statement at every k, the disc, the hypothesis read, and clauses (4) and (5) not found in print — two web queries and the arXiv listing "chromatic number of the plane" newest first (nothing dated from 2026-10-06 on); zbMATH owed (its API returned 503 three times on 2026-10-07)
  handoff: de Bruijn — the statement at `Fin k` with the release's own constants (cores finite in `closedBall 0 8`, the map on `closedBall 0 5`): some core x at which the graph of common interfaces contains a cycle; by the release's skeleton with `commonInterface_graph_acyclic` (five-only) turned into a hypothesis and contraposed. Already general in `L`: `annulus_forest_extension`, `graph_forest_patch`, `forest_disk_extension`, `simplex_mem_forest`, `continuum_limit_support_exclusion`, `compact_open_cover_impossible`, `diskAverage_unit_pair`, `missing_edge_disk_cover`. Typed `Fin 5`, reading five only as α < 1/5: `thresholdMap`, `forest_chart`, `small_hole_map`, `HoleApprox`, `FullApprox`, `no_large_positive_sequence`, `CommonInterface`, `eventually_forest_of_bridges`. The disc of radius above 1 and clauses (4), (5) have no Lean counterpart; read the formal statement back against this one

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
21, withdrawing ruling 16 (c); the claim list's dated correction). The whiff stays on record with no side picked (the
asking lane's, item 12; E4's report).

**Read by one mind only** besides S11: S5's merging bookkeeping and S8 (the release's Lemmas 7.7, 7.8, read in full, not
reworked). **Receipts** (item 3): S6 redone by the coordinator, S7's mesh bound followed step by step.

**The hypothesis nobody supplies at six** is finitely many centres in the disc (the road's step 2; item 12). What the
argument reads of it is zero length of the centres and isolation of the one essential centre (E1 § Card 2); at the island
colouring's accumulation centre the conclusion with clause (4) is false, and true at the isolated ones (control
`hex7-islands`). **Side: no side.**

Rests on it: C132-CORES-FREE, C132-EXT, C132-WIT-EX-FIN; steps S4–S5 and S7 inside C132-FILL; the data over which
C132-TRI-STRIP, C132-RING-TAME, C132-LONG and C132-COMP are stated. For the kernel lane it waits: its right form is
C132-WIT-SUPER's question (items 12 (b), 24).

control: hex7-model
  of: C132-EXT-DISC — clauses (3) and (4) on the model: the hexagonal seven-colouring at the vertex (0, 2/5), three edges cut at ρ = 0.3, clause (3) on 8,963 grid points of the three straddle sets
  run: python3 ../data/fs132/e1/hex7_check.py model
  expect: vertex-labels=3 edges=3 delta-samples=8963 violations=0 clause4=True
  fault: python3 ../data/fs132/e1/hex7_check.py model --fault

control: hex7-islands
  of: C132-EXT-DISC — where its hypothesis fails: the island colouring; a disc of radius 1.05 with finitely many centres; clause (4) for the straight edge at the accumulation centre v; clauses (3), (4) at the isolated centre of island 6
  run: python3 ../data/fs132/e1/hex7_check.py islands
  expect: island-free-disc=True vertices-in-disc=18 clause4-at-v=False clause3-at-b=0 clause4-at-b=True
  fault: python3 ../data/fs132/e1/hex7_check.py islands --fault

control: sec7-cites
  of: C132-EXT-DISC — its uses only: the labels the manuscript's § 7 cites from outside itself
  run: python3 ../data/fs132/e1/refs_outside.py interfaces.tex
  expect: eq:source-14 sec:transitions thm:cyclic-local-finiteness
  fault: python3 ../data/fs132/e1/refs_outside.py transitions.tex

control: reduced-words
  of: C132-EXT-DISC — step S8's count: every cyclically reduced closed edge word of length at most 7 in the complete graph on 3 to 6 labels contains a simple cycle
  run: python3 ../data/fs132/e1/words_check.py
  expect: 0
  fault: python3 ../data/fs132/e1/words_check.py --fault

derivation: C132-CORES-FREE
  statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed disc of radius greater than 1 contains a cyclic centre
  uses only: C132-EXT-DISC in the case 𝓛 ∩ D = ∅, where its steps S5–S7 run with no core disc at all — nothing is read of the centres
  not claimed: that a closed disc of radius 1 or less contains one (in the model every disc of radius 2/5 does; the constant here is the mesh bound of Lemma 7.6, not a sharp one); that the centre found carries any continuum; anything about a colouring defined only on a disc
  argument: FS132-E1-derivation.md § Argument — cores exist
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 — every closed disc of radius 2/5 holds a vertex; and the island colouring `EXT-OAI2-SLACK7-L`, where the statement holds with infinitely many centres in every disc about v
  prior art: partly: `[OAIMath2026]` Lemma 7.6, last sentence ("This argument also rules out the possibility of having no core disks in Q"), at five labels and under Theorem 6.5; the statement with no hypothesis on the centres and at every k not found in print (searches as for C132-EXT-DISC)
  handoff: de Bruijn — at `Fin k` with the release's constants: `(Metric.closedBall 0 8 ∩ CyclicCore c).Nonempty`; it is `fullApprox_exists_of_finite_core` with `L = ∅` at `Fin k` against `no_large_positive_sequence` and `compact_open_cover_impossible`

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
S5 and S7 of C132-EXT-DISC carry over from a disc to a square, the statement follows, C132-CORES-FREE is its corollary,
and the release's cover lemma need not be ported (item 25). Whether those steps read the disc's shape is the comparison,
one short stage, that nobody has done. **Side: no side.**

derivation: C132-WIT-EX-FIN
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane and D a closed disc of radius greater than 1 containing finitely many cyclic centres of c; then there are a cyclic centre p in the interior of D, an integer ℓ with 3 ≤ ℓ ≤ k, distinct labels i_0, …, i_{ℓ−1} forming a cycle of the transition graph of p, and points q_0, …, q_{ℓ−1} other than p such that for each j modulo ℓ the supports H_{i_j} and H_{i_{j+1}} both miss Δ({p, q_j}) and both contain p and q_j
  uses only: C132-EXT-DISC (`plans/FS132-E1-derivation.md` Stage 3) — its clause (1) for a point q_j of K_j on the circle of radius ρ about p, clause (3) with Δ({p, q_j}) ⊂ Δ(K_j), clause (4) for the two anchors, clause (5) for the cycle
  not claimed: anything on a disc with infinitely many cyclic centres; that ℓ ≥ 4
  argument: FS132-E5-derivation.md § Argument — where the centres are finite
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: the model of C132-EXT-DISC — the hexagonal seven-colouring at the vertex (0, 2/5) with q_j the points of its three edges at distance 0.3
  prior art: partly: as C132-EXT-DISC
  handoff: none — subsumed by C132-EXT-DISC, which crosses

The anchored witnessed cycle on a disc with finitely many centres: a corollary of the extraction, and one of clause (5)'s
two consumers (the words "forming a cycle of the transition graph"). **Side: no side.**

derivation: C132-FILL
  statement: Let k ≥ 3 be an integer, X_k the union of 𝒢 with all its filled triangles, c a weak measurable k-colouring of the plane and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite; then for every large n there is a continuous map from D₁ to X_k that equals g_n off the core discs and equals q^{ε_n} off the holes, and the connected components of the sets on which one of its coordinates is positive form an open cover of D₁ of multiplicity at most three whose mesh is at most 1 + o(1) as n → ∞
  uses only: the construction of C132-EXT-DISC's argument, steps S4–S5 (the threshold map, the holes, one core disc per centre, the map g_n); that the 2-skeleton of a simplex is simply connected; the mesh argument of its step S7, which reads of the map only that it equals q^{ε_n} off the holes and of the holes only that their total radius tends to 0
  not claimed: that the disc averages themselves fill a core disc inside X_k (four or more labels may exceed the threshold there); that the members of the cover avoid the unit distance (two points 1 apart may both carry a label above the threshold α); any obstruction — the statement is that this map exists whenever the colouring does, at every k, so no covering theorem of order three forbids it
  argument: FS132-E2-derivation.md § Argument — the filled target
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 — near a vertex only its three labels are present, so q^ε itself maps into X_7 and is the filling; the cover is the honeycomb's tiles thickened by O(ε)
  prior art: partly: the map into the graph is `[OAIMath2026]` Lemma 7.4; the classical order-three statement is Lebesgue's covering theorem (`[HurewiczWallman1948]` Thm IV 2, held); the filled form for a weak measurable colouring not found in print by the milestone's gate (`plans/FS132-six-by-the-nerve.md` §PA), which this job did not extend
  handoff: de Bruijn — with C132-EXT-DISC's module: the extension of each core loop over its disc into the 2-skeleton, from simple connectivity of the 2-skeleton of a simplex; the cover's mesh bound is the release's argument for `no_large_positive_sequence` read with a 2-complex target

derivation: C132-NOESS
  statement: For k ≥ 4 every loop of 𝒢 is null-homotopic in X_k; and for a set 𝒯 of triangles of 𝒢 the simple four-cycle on the labels 0, 1, 2, 3 is null-homotopic in 𝒢 ∪ 𝒯 when 𝒯 holds the triangles 012 and 023, and is not null-homologous when 𝒯 holds the triangle 012 alone
  uses only: that the fundamental group of a complex is that of its 2-skeleton and a simplex is contractible; that a four-cycle is the composite of two triangles sharing a diagonal; that the boundary of the one triangle 012 has coefficient 0 on the edge 23
  not claimed: a criterion for a general 𝒯; anything metric; that a centre with a long cycle is ever essential or ever inessential in the complex whose triangles are the ones a given colouring realizes — that depends on the triangles realized at other centres, and no statement here controls them
  argument: FS132-E2-derivation.md § Argument — nothing stays essential
  verdict: derived
  grade: hand
  minds: 1
  model: k = 6 and 𝒯 the twenty triangles — the first homology of X_6 has rank 0 (control `two-skeleton`)
  prior art: known: textbook (cellular approximation; `[Hatcher2002]` § 1.2 and Proposition 1.26, recalled, not read)
  handoff: none — a relay-result; its first clause is step F1 of C132-FILL, which crosses

**Card 3's first branch has an empty answer.** With every triangle filled every loop bounds, so "the essential centres
are the cycles of length four to six" does not hold and the obstruction is not in the filled target (items 5, 7); the
asking lane's collision is read, both sides true of two targets, no invention needed (E2's report). C132-FILL, C132-REL
and C132-TRI-STRIP hold at every number of colours. **Side: no side** (both entries).

control: two-skeleton
  of: C132-NOESS — the homological shadow: the first homology of 𝒢 with all triangles filled has rank 0 for k = 4, …, 7; the four-cycle 0-1-2-3 bounds with the triangles 012, 023 and not with 012 alone
  run: python3 ../data/fs132/e2/ring_checks.py skeleton
  expect: k=4:H1=0 k=5:H1=0 k=6:H1=0 k=7:H1=0 4cycle-in-K6+012+023=True 4cycle-in-K6+012=False
  fault: python3 ../data/fs132/e2/ring_checks.py skeleton --fault

derivation: C132-REL
  statement: In the setting of C132-FILL, for a circle C in the interior of D₁ that misses 𝓛, bounding the open disc U, and every large n, the class of g_n on C in the first integral homology of 𝒢 is the sum over the points x of 𝓛 in U of the classes of g_n on ∂B_{n,x}, all circles counterclockwise
  uses only: that g_n is continuous on D₁ minus the open core discs (step S5); that the core discs shrink to their centres; that the boundary of a compact planar domain is null-homologous in it
  not claimed: the relation in the fundamental group (a product of conjugates along paths this statement does not fix); that either side is independent of n; that a core's class is non-zero; anything when 𝓛 ∩ D is infinite
  argument: FS132-E2-derivation.md § Argument — the relation a disc imposes
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring, C the unit circle about the vertex (0, 2/5): the circle's walk of labels 6, 5, 4, 1, 6, 4, 5, 1, 4 as an integral 1-chain is the sum of the triangle chains of the thirteen vertices inside it (control `hex7-relation`)
  prior art: known: Stokes' theorem for a map of a planar domain to a graph; `[OAIMath2026]` uses it in free-homotopy form in Lemma 7.8 (by the first deriver's step S8)
  handoff: de Bruijn — as a statement about signed edge-crossing counts of g_n along C and along the core circles; the planner chooses between homology and a winding-count form

The classes of the centres inside a circle add up to the circle's. **Side: no side.** **The control, re-run** (E6): at
circumradius 1/2 the unit circle about a vertex passes through three vertices, outside this entry's hypothesis; E2's
script compares distances strictly in floating point there and reads 11 where the count with those vertices inside is 13
(a tool defect, E6's report; the script is not edited).

control: hex7-relation
  of: C132-REL — at seven, on the hexagonal colouring: the unit circle about a vertex, its labels, its walk, its changes, and the sum of the triangle chains of the vertices inside it
  run: python3 ../data/fs132/e2/ring_checks.py hexrel
  expect: own-labels=[0, 2, 3] ring-labels=[1, 4, 5, 6] own-on-rings=[[], [], []] crossings=9 ring-walk=654164514 two-jumps-60-apart=False vertices-inside=13 relation-holds=True
  fault: python3 ../data/fs132/e2/ring_checks.py hexrel --fault

## 4. A triangle point's ring

derivation: C132-INDEX
  statement: Let a, b, c be three labels, Θ the union of the edges ab, bc, ca of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6
  uses only: continuity of φ and its lift to the line; that six rotations by π/3 compose to the identity; that a point of Θ whose support is disjoint from the support of a vertex lies on the closed opposite edge, and from the support of an interior point of an edge is the opposite vertex
  not claimed: anything for a ring that is only measurable; for a loop whose changes at e and at Re may coincide (six sectors a, b, c, a, b, c of angle π/3 have degree 2, and a, b, a, b, a, b degree 0: the control's fault); for four labels (the target is then a graph of rank three, with no degree); that the ring of any colouring satisfies the hypothesis
  argument: FS132-E2-derivation.md § Argument — the degree of a three-labelled ring
  verdict: derived
  grade: hand
  minds: 1
  model: nine arcs of 2π/9 labelled a, b, c, a, b, c, a, b, c, joined linearly on short intervals about the nine boundaries — degree 3; in the control's discretization the sequence 0, 0, 1, 1, 2, 2 three times on 18 positions
  prior art: partly: the index of a three-coloured circle and its nine bichromatic points are `[Voronov2023]`'s and `[SokolovVoronov2025]`'s (by this project's records `plans/FS106-V-verification.md` row V-1.2 and `plans/FS110-CB-verification.md` § D5; neither paper read by this job); that a three-colouring's slope lies between one third and two thirds is this project's G71 (FS73-T22); the congruence modulo 6 in this form not searched
  handoff: de Bruijn — a lemma about continuous maps of the circle with no colouring in it: the lift, the six-step sum, the two excluded ends

**The invariant that tells six from seven.** Three labels outside a triangle wind — degree 3 modulo 6, so at least nine
changes; four labels have no winding number; two are rigid. No colouring in it. **A second derivation exists, blind**: the
kernel planner's (K1 § 2.3), from the statement alone, by the same six-step sum, with models of its own
(`plans/FS132-Z1-record.md` § 2.5 compares the two: the statements are the same). The field keeps `minds: 1`: the
planner's is a paragraph by hand whose Lean leaves are unproved, and it has not read this entry (its § 3.7 item 2); the
count is held for the coordinator. The coordinator's hand check of the argument (item 7) is a receipt. **Side: no side.**
It has no consumer until a tame ring is supplied (C132-RING-TAME, § 8).

control: ring-degree
  of: C132-INDEX — every piecewise-linear loop on 18, 24 and 30 positions with supports disjoint under the rotation, enumerated: its degree modulo 6
  run: python3 ../data/fs132/e2/ring_checks.py index3
  expect: N=18:sequences=12,d-mod-6=[3] N=24:sequences=480,d-mod-6=[3] N=30:sequences=11520,d-mod-6=[3]
  fault: python3 ../data/fs132/e2/ring_checks.py index3 --fault

derivation: C132-RING-WIND
  statement: let N be a set of three labels, Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e, and J the set of the directions e having no arc about e on which Π is almost everywhere equal to one set; if J is finite and no two of its points are at angle π/3, then on each arc of S ∖ J the function Π is almost everywhere one singleton or one pair, two consecutive arcs carry subsets of one pair, and the closed walk they make around the triangle on N has winding number congruent to 3 modulo 6
  uses only: C132-INDEX, applied to the loop that sits at a vertex on a singleton arc, at an edge's midpoint on a pair arc, and moves along one edge across each point of J; the disjointness under R on sets of positive measure; finiteness of J and J ∩ R(J) = ∅, both used to make the loop's supports disjoint under R
  not claimed: the conclusion when two points of J are π/3 apart (the fault of control `ring-degree`); when J is infinite; for a set N of four labels; that the pure-side palette of any colouring has a finite J
  argument: FS132-E2-derivation.md § Argument — the winding of a tame ring
  verdict: derived
  grade: derived from: C132-INDEX
  minds: 1
  model: N = {a, b, c}, Π the singleton a, b, c, a, b, c, a, b, c on nine arcs of 2π/9 — J is the nine boundaries, J + π/3 falls on the arcs' midpoints, the winding number is 3
  prior art: partly: as C132-INDEX
  handoff: de Bruijn — with C132-INDEX, as its form for step functions

The same for a step function with finitely many changes, no two 60° apart. Here it stands as E2 derived it, from
C132-INDEX. **A second route, blind** (K1 § 2.3): "RING-WIND does not use INDEX" — the six-step sum applied to the step
lift directly (each jump at most 1, no jump matched at `π/3`, the intervals 2 apart). **Side: no side.**

derivation: C132-ORBIT
  statement: let N be a set of three labels and Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e; then for almost every e each of the six sets Π(e), Π(Re), …, Π(R⁵e) is a singleton or a pair, no two consecutive ones are pairs, and with a vertex of the triangle on N at coordinates 0, 2, 4 modulo 6 and a pair at the midpoint between its two vertices, the six steps from each set to the next, each taken in the interval [2, 4], add up to 12, 18 or 24
  uses only: that two disjoint non-empty subsets of a three-element set are two distinct singletons or a singleton and the pair of the other two; that the six steps add up to a multiple of 6
  not claimed: that the sum is the same for almost every e; that it is 18; anything for four labels, where two disjoint pairs exist and no step is defined
  argument: FS132-E2-derivation.md § Argument — the orbit index
  verdict: derived
  grade: hand
  minds: 1
  model: the six sectors a, b, c, a, b, c of angle π/3 — every step is 2 and the sum is 12; the nine arcs of C132-RING-WIND's model — three steps of 2 and three of 4, sum 18
  prior art: owed
  handoff: none — a relay-result: the measurable shadow of the winding number, used to state C132-RING-TAME's alternatives; it crosses only if C132-RING-TAME is taken up

The measurable shadow of the winding number: an orbit index in {2, 3, 4} at almost every direction, with no tameness.
Applied to a colouring it rests on the release's Corollary 5.4, taken at its statement by E2; that proof was read by E3
(M0), one mind (item 8 (ii)). **Side: no side.**

derivation: C132-SEP
  statement: the angle Φ(r, s) = arccos((r² + s² − 1)/(2rs)) at the common centre between a point of the circle of radius r and a point of the circle of radius s at distance 1 from it has mixed second derivative 8/(3√3) at r = s = 1, so on no neighbourhood of (1, 1) is Φ the sum of a function of r and a function of s
  uses only: differentiation; that a sum f(r) + g(s) of twice differentiable functions has mixed derivative 0, and for arbitrary f, g that Φ(r, s) − Φ(r, s′) − Φ(r′, s) + Φ(r′, s′) would vanish identically, which the non-zero mixed derivative forbids
  not claimed: any statement about colourings — in particular not that two changes of colour π/3 apart are impossible in a strip of positive width; that follows from this only for changes along two curves that cross the whole strip and are matched in both directions, a regularity no weak measurable colouring is known to have
  argument: FS132-E2-derivation.md § Argument — the unit chord's angle is not separable
  verdict: derived
  grade: hand
  minds: 1
  model: r = s = 1 gives Φ = π/3, the angle of the equilateral triangle; the first derivatives there are −1/√3 each (control `chord-angle`)
  prior art: owed
  handoff: none — a relay-result for the YES side's sketch; one computation

One computation, used only in the YES side's sketch. **Side: no side.**

control: chord-angle
  of: C132-SEP — the mixed second derivative of the unit chord's angle at r = s = 1, exactly
  run: python3 ../data/fs132/e2/ring_checks.py mixed
  expect: mixed-derivative-at-(1,1)=8*sqrt(3)/9 first-derivatives=-sqrt(3)/3
  fault: python3 ../data/fs132/e2/ring_checks.py mixed --fault

derivation: C132-CROSS
  statement: let L be a finite set of labels, U an open set of the plane, c a measurable map from U to L, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, w a point of U with |w − x| = |w − y| = 1, and 𝒦_x, 𝒦_y two finite families of pairs (K, E) of a compact set K and a set E of labels with H_i ∩ Δ(K) = ∅ for every i in E, where Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1, with x ∈ K for the pairs of 𝒦_x and y ∈ K for the pairs of 𝒦_y; let E_x^out be the union of the sets E over the pairs of 𝒦_x whose K has a point q with |w − q| < 1, E_x^in the union over the pairs of 𝒦_x whose K has a point q with |w − q| > 1, E_y^out the union over the pairs of 𝒦_y whose K has a point q with |w − q| < 1, and E_y^in the union over the pairs of 𝒦_y whose K has a point q with |w − q| > 1; then none of the four sets E_x^out ∪ E_y^out, E_x^out ∪ E_y^in, E_x^in ∪ E_y^out, E_x^in ∪ E_y^in is all of L
  uses only: the definition of Δ(K) with two of its points (x and q); that a point outside H_i has a neighbourhood meeting the class of i in a null set; that z ↦ (|z − x|, |z − y|) is a local diffeomorphism at w when x, y, w are not collinear, which 0 < |x − y| < 2 gives; that a set of positive measure in U has a label almost everywhere. It reads no properness, no palette, no limiting direction, no connectedness of the sets K, and of a set K two of its points
  not claimed: anything at |x − y| = 2 (the circles are tangent and one quadrant is empty: the fault of control `crossing`) or at x = y; anything about a set K all of whose points are at distance 1 from w — such a pair enters none of the four unions; that the exclusions hold for any colouring (they are hypotheses here: at an extracted centre they are clause (3) of C132-EXT-DISC, in a map the edge exclusion, C132-WITNESS below); any area or scale (the quantified form with holes is FS107-R-CP, row 133)
  argument: FS132-E4-derivation.md § Argument — the covering count
  verdict: derived
  grade: hand
  minds: 1
  model: seven labels, the hexagonal seven-colouring with circumradius 2/5, x and y two of its vertices less than 2 apart with their three edges each: every edge is blocked on a side, the four unions are the six labels of the two vertices at most, and the label seen near w is outside both (control `hex7-crossings`)
  prior art: partly: for maps it is the composition behind row 133's FS107-W-TAN (over C-T-TAN, `plans/FS107-W-near-colourings.md` § 2.5) and FS110-N-SEAM's "every tile there lies on one side of the unit circles"; its regular form is `[Voronov2023]` Prop. 2.2 by this project's record FS106-TAN (the paper not read by this job); for a measurable labelling with exclusion sets it was not found by the milestone's gate (`plans/FS132-six-by-the-nerve.md` §PA), which this job did not extend
  handoff: de Bruijn — the statement as written: no colouring theory in it; a local diffeomorphism at w, four non-empty open quadrants, finitely many excluded label sets on each. Its first step (an edge set with a point strictly inside or outside the unit circle about w excludes its labels on one side of the centre's unit circle near w) is the strips clause of the witness card's C132-WIT, whose entry is the one that crosses (the coordinator's ruling, 2026-10-07)

**The covering count: it reads no properness.** Its first step, B1, is C132-WIT-SIDE (§ 2). **Side: arc-free (β)** — "a
set K all of whose points are at distance 1 from w … enters none of the four unions". **The control, re-run** (E6 § The
two riding controls): on the honeycomb at circumradius 1/2, `hex7-crossings` reads own labels near a crossing point at 36
of 432 where it read 0 at 2/5, every such sample inside that vertex's unit circle, "as the blocking rule requires. The
entry is untouched; the zero at 2/5 was the margin". A dated line is under the control in E4's record.

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

derivation: C132-COMP-SHARP
  statement: let U be an open set of the plane, c a measurable map from U to a set of six labels, H_i the closed essential support of the class of i, x and y two points with 0 < |x − y| < 2, t_0, t_1, t_2 and t′_0, t′_1, t′_2 the six labels, K_0, K_1, K_2 compact sets containing x with H_{t_j} ∩ Δ(K_j) = ∅ and H_{t_{j+1}} ∩ Δ(K_j) = ∅ for each j modulo 3, K′_0, K′_1, K′_2 compact sets containing y with H_{t′_j} ∩ Δ(K′_j) = ∅ and H_{t′_{j+1}} ∩ Δ(K′_j) = ∅ for each j modulo 3, and w a point of U with |w − x| = |w − y| = 1; then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w
  uses only: C132-CROSS with the three pairs (K_j, {t_j, t_{j+1}}) at x and the three pairs (K′_j, {t′_j, t′_{j+1}}) at y; that three sets each blocked on one of two sides have two blocked on one side; that two edges of a triangle have all three of its labels among their endpoints; that two disjoint triples of six labels are all the labels
  not claimed: which of the six sets it is, or that it is one of x's; anything with seven labels or more (two triangles then leave a label outside both, and the honeycomb is the model of that); anything at a point with three labels and only two witnessed pairs (a bowtie: sectors a, b, a, c have no edge b–c, and fragments S1, BB and MX of FS110-FRAGS are valid with one); that a configuration with a set on the unit circle about w is impossible — fragment T2 is one, on small neighbourhoods of four points
  argument: FS132-E4-derivation.md § Argument — complementary triangles
  verdict: derived
  grade: derived from: C132-CROSS
  minds: 1
  model: fragment T2 of FS110-FRAGS (`tools/fs110_y_fragments.py`): x = (0, 0) with labels 1, 2, 3, y = (1, 0) with labels 4, 5, 6, w = (1/2, √3/2), a valid six-coloured fragment on neighbourhoods of the four points; its tiles are connected, so its edges carry the exclusion (C132-WITNESS), and three of the six edge sets lie on the unit circle about w — two of x's and one of y's (control `seam-fragments`)
  prior art: partly: as C132-CROSS; in the map class the statement with its exception read as "tangent pair or bowtie" is FS107-W-TAN (row 133) and, with no unit arcs, FS110-NB-5 (row 134); the exception as "an edge set on the unit circle about the common unit point" is in this project's files only as fragment T2 and its planted fault `t2_flat`; not searched in print by this job — owed
  handoff: de Bruijn — a corollary of C132-CROSS by one pigeonhole; the formal statement to read back is "one of the six sets is contained in the unit circle about w"

**The regular chain's last line in the exact class** (the road's step 3e; item 15 (b)): two points less than 2 apart
carrying witnessed triangles on disjoint triples of six labels force one of the six edge sets onto the unit circle about
each of their common unit points in the open set. **Side.** Read as an exclusion — no complementary pair under 2 apart —
it is **arc-free (β)**. Read as stated, **its conclusion is the hard case**: fragment T2 realizes it, with three of its
six edge sets arcs of the unit circle about the crossing point (control `seam-fragments`). It carries C132-COMP (§ 10).
The sharpening it gives `LEDGER.md` row 133 is drafted from E4's report in `plans/FS132-Z1-record.md` § 5.

control: seam-fragments
  of: C132-COMP-SHARP — the four held seam fragments of FS110-FRAGS, both common unit points: the labels the blocking rule excludes, read off each fragment's own edges at its two centres, against the labels found near the points; FS110-Y's checker beside it; in T2, the edge sets on the unit circle about w
  run: python3 ../data/fs132/e4/ring_card_checks.py fragments
  expect: excluded-labels-seen-near-the-common-unit-points:S1=0,T2=0,BB=0,MX=0 checker=ACCEPT,ACCEPT,ACCEPT,ACCEPT sets-of-T2-on-the-unit-circle-about-w=3
  fault: python3 ../data/fs132/e4/ring_card_checks.py fragments --fault

derivation: C132-PLACE
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, N the set of the three other labels, and ψ an angle such that at least two of the sets K_j have a point q with |x + e(ψ) − q| < 1; then there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and −κ < d < 0 the label of the point x + e(α) + e(α − 2π/3 − d) lies in N and in neither of the palettes P_x(e(α)) and P_x(e(α − 2π/3 − d)); and if at least two of the sets K_j have a point q with |x + e(ψ) − q| > 1, there is κ > 0 such that for almost every (α, d) with |α − ψ − π/3| < κ and 0 < d < κ the label of that point lies in N and in neither of those two palettes
  uses only: `[OAIMath2026]` Lemma 5.2 assertion (1) read locally (`palettes.tex:111–203`, read with its proof: label by label, no count, and local to the pairs whose sums stay in U — FS132-E3's reading T2, which I re-read against the source); the chart Z (FS132-E3's M2) and that it carries null sets to null sets; step B1 of C132-CROSS (a set with a point strictly inside, or outside, the unit circle about the ring point excludes its two labels on the outer, or inner, side near it); that two edges of a triangle have its three labels among their endpoints. It reads nothing of the limiting directions, of connectedness, of the transition graph, or of the other side of the ring
  not claimed: anything on the side that is not pure — there the label lies outside the two palettes and may be a label of T; anything at a ring point with no pure side (then one of the sets K_j lies on the unit circle about the ring point, by the pigeonhole of C132-COMP-SHARP); that the two palettes are singletons, or that the outside state is a step; that the ring point is a cyclic centre
  argument: FS132-E4-derivation.md § Argument — the transfer on the pure side
  verdict: derived
  grade: hand
  minds: 1
  model: seven labels, the hexagonal seven-colouring at the vertex (0, 2/5), where both sides are pure at every direction (FS132-E2's control `hex7-relation`): the label at a point near the ring is outside the labels at its two ring neighbours — properness of the honeycomb at distance 1; no six-colouring is known, and at six the list under the argument is checked on the two six-sector rings as patterns (control `chart-wedges`)
  prior art: partly: `[OAIMath2026]` Lemma 5.2 and Lemma 8.1 are the two inputs, and its lemma "Polynomial three-label region" (`angular.tex:484–524`, the eighth numbered statement of its § 8) is this statement at five labels for two outside labels and both neighbours inside sectors; in the map class it is this project's ring calculus (G91; FS116-V6's V6-GERM, as FS132-E3's M2 restates it); the three-label form on a pure side not found by the milestone's gate, which this job did not extend
  handoff: de Bruijn — over the release's `palette_transport_param` at `Fin 6` and the strips clause of C132-WIT: the statement as written, two cases by the side

**What the transfer forces near a ring point, on a pure side.** Under its argument E4 has a list by the germs of the
outside state 60° to either side, derived for constant and step germs, two lines open (the side that is not pure; germs
only measurable). On the six-sector turning ring: at an outer-pure ring point all three outside labels meet; at an
inner-pure one nothing is placed — the asking lane's hunch holds on outer-pure points only (item 16). **Side: arc-free
(β) at the ring point, up to one edge** — it needs two of the three sets with a point strictly on one side of the unit
circle about the ring point, so it holds with the third set on that circle and says nothing at a ring point with no pure
side. One input is unverified by a later user: "the proof of the release's Lemma 5.2 (inside C132-PLACE)" (E6's report).

Rests on it: C132-ALT, C132-TURN-EDGE, C132-LENS, C132-LENS-FOUR, C132-PLACED-RING.

control: chart-wedges
  of: C132-PLACE — the chart's three signs (inside the ring; inside the unit circle about the forward neighbour's ring point; inside the one about the backward neighbour's) on 1,681 points, and the label sets the transfer leaves in the four wedges for the two six-sector rings
  run: python3 ../data/fs132/e4/ring_card_checks.py wedges
  expect: chart-samples=1681 sign-mismatches=0 turning:far=c lens=ab cw=a ccw=b alternating:far=c lens=c cw=ac ccw=bc
  fault: python3 ../data/fs132/e4/ring_card_checks.py wedges --fault

derivation: C132-ALT
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a and b two labels outside T, ψ an angle and δ > 0 such that for every integer k the palette P_x(e(θ)) contains a for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is even and for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is odd, and contains b for almost every θ in (ψ + kπ/3, ψ + kπ/3 + δ) when k is even and for almost every θ in (ψ + kπ/3 − δ, ψ + kπ/3) when k is odd; then there is no integer k such that, for both m = k and m = k + 1, at least two of the sets K_j have a point strictly inside the unit circle about x + e(ψ + mπ/3) or at least two of them have a point strictly outside it
  uses only: C132-PLACE at two adjacent ring points; the unit-pair relation between points near two ring points π/3 apart, FS132-E3's M7, with its shift ε = d d′ h(d, d′), h smooth and h(0, 0) = 2/√3, read for both signs of d and of d′ (the derivation there does not use the signs; control `unit-shift`); weak properness; six labels, as "three outside T"
  not claimed: the statement for a ring that alternates near the orbit without being a step (palettes that hold a or b almost everywhere near the six points, each on a set of positive measure near ψ): for two adjacent ring points with pure inner sides it follows, because FS132-E3's Lemma S makes such a state a step; for the three other patterns of sides it needs a shift lemma of that kind for three other arrangements of the two gaps, which is sketched under the argument and not entered; anything at an orbit none of whose adjacent pairs has two pure sides — then three of the six ring points, alternate ones, each have one of the three sets K_j on their unit circle; anything at seven labels
  argument: FS132-E4-derivation.md § Argument — the alternating orbit
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence); as a pattern, the six-sector ring a, b, a, b, a, b: at each ring point the far wedge and the lens are left the third outside label (control `chart-wedges`), and between two adjacent ring points the forced regions hold unit pairs for three of the four patterns of sides and none for two inner sides, where the argument takes its second step (control `forced-pairs`: 36, 129, 93, 0)
  prior art: partly: at five labels the ring of a triangle centre is this alternating ring and the release kills it by rigidity and a Moser spindle in the region its lemma "Polynomial three-label region" leaves to the triangle's labels (`angular.tex:476–607`); the mechanism here is FS132-E3's M7–M9 (C132-M-ORBIT) with the third outside label in the place of the tip; the six-label statement not found by the milestone's gate, which this job did not extend
  handoff: de Bruijn — after C132-M-ORBIT's module, which holds the chart, the unit-pair relation and the kill; here four cases by the sides, three of them one open set of unit pairs each

**The alternating ring is excluded in step form** wherever two adjacent ring points each have a pure side — "the binary
ring of the YES sketch is gone in step form" (item 16). For a ring that is only measurable it is derived for two adjacent
inner-pure points (over Lemma S, M8 of C132-M-ORBIT); the three other patterns need three shift lemmas of that kind,
"sketched … and not entered". **Side: arc-free (β), with one residue named** — an orbit none of whose adjacent pairs has
two pure sides: three alternate ring points, each with one of the three sets on its unit circle. **In a finite family,
[cert]:** SEARCH-1007-ALT (§ 6). **A second route for two of its four cases**, read off, not entered: C132-SHADOW (§ 2).

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

derivation: C132-TURN-EDGE
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a, b, n the three labels outside T, ψ an angle and δ > 0 such that the palette P_x(e(θ)) contains a for almost every θ in (ψ − δ, ψ), contains b for almost every θ in (ψ, ψ + δ), and contains n for almost every θ in (ψ + 2π/3 − δ, ψ + 2π/3) and for almost every θ in (ψ − 2π/3, ψ − 2π/3 + δ), and suppose that at least two of the sets K_j have a point strictly inside the unit circle about x + e(ψ + π/3) and at least two of them have a point strictly inside the unit circle about x + e(ψ − π/3); then there is no compact set K containing x + e(ψ) and another point such that Δ(K) is disjoint from the closed essential supports of a and of b
  uses only: C132-PLACE on the outer side at the two ring points x + e(ψ ± π/3); the first clause of C132-CONFINE (a support point outside Δ(K) has all of K within 1 or none of K nearer than 1); that the unit circles about x + e(ψ + π/3) and x + e(ψ − π/3) meet at x and at x + e(ψ) and nowhere else (control `turning-edge`)
  not claimed: that the ring point is a cyclic centre, or carries any witnessed edge; that the pair {a, b} is an edge of its transition graph; anything when one of the two neighbouring ring points has only a pure inner side (the third label is then forced in no region the argument can read); anything for a state that is not a step at ψ; that a colouring with these hypotheses exists
  argument: FS132-E4-derivation.md § Argument — no witness between the two ring labels
  verdict: derived
  grade: hand
  minds: 1
  model: none at six — no six-colouring is known; the hypotheses on the ring are those of the six-sector ring a, b, n, a, b, n at any of its six ring points, and the regions the argument reads lie where it says (control `turning-edge`); at seven the honeycomb's ring at a vertex has no step whose neighbours 2π/3 away agree on a third label out of three (its ring carries four labels)
  prior art: owed — the statement is this job's; its mechanism is C132-CONFINE (FS132-E1) read at two points of the unit circle about the ring point
  handoff: de Bruijn — only with a consumer; from C132-PLACE and C132-CONFINE, two confinements and one intersection of circles

At a step of a turning ring whose two neighbours are outer-pure, the two ring labels are never a witnessed edge at the
ring point: "the pair is provably NOT witnessed there" (item 16). **Side: arc-free (β) at the two neighbours**; no
hypothesis at the ring point itself. **A correction on record.** The sentence beside it in E4's record — "Every pattern
of sides has such a point when all six ring points have a pure side: the side is opposite at antipodes, so the six read
O O O I I I (take the middle O) or O I O I O I (take any I)" — is true one way only; the dated line E6 drafted is appended
there (`plans/FS132-E4-derivation.md` § Where C132-TURN stalls, under item (i)). "The entry C132-TURN-EDGE does not use the
sentence."

Rests on it: C132-PLACED's line PL5 (E6: inherited, "its argument read and not reworked"); the statement of where
C132-TURN stalls (§ 8).

control: turning-edge
  of: C132-TURN-EDGE — the unit circles about the two neighbouring ring points meet at x and at the ring point; the four regions read lie outside the ring and on the stated side of the unit circle about the ring point
  run: python3 ../data/fs132/e4/ring_card_checks.py edge
  expect: circles-meet-at-x-and-y=True region-samples=576 side-mismatches=0
  fault: python3 ../data/fs132/e4/ring_card_checks.py edge --fault

## 5. The seed: what a point's unit circle forces in the balls about its ring points

*A seed is a point with data on its unit circle, however it came by them (the asking lane's re-cut of the object, item
23). Every entry here is E6's, [hand] or derived from it over the inherited C132-PLACE; one mind.*

derivation: C132-LENS
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a, b, n the three labels outside T, ψ an angle such that for almost every θ the palette P_x(e(θ)) contains a if θ lies in (ψ − π/3, ψ) or in (ψ + 2π/3, ψ + π), b if θ lies in (ψ, ψ + π/3) or in (ψ + π, ψ + 4π/3), and n if θ lies in (ψ + π/3, ψ + 2π/3) or in (ψ + 4π/3, ψ + 5π/3), and y_k = x + e(ψ + kπ/3); if at least two of the sets K_j have a point strictly inside the unit circle about y_1, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 has its label outside {a, n}; if at least two of the sets K_j have a point strictly inside the unit circle about y_{−1}, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_{−1}| < 1 has its label outside {b, n}; and if both hold, there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 and |z − y_{−1}| < 1 has its label in T
  uses only: C132-PLACE on the outer side at y_1 and at y_{−1} (inherited: `plans/FS132-E4-derivation.md` Stage 3, [hand], one mind), which is where the palettes, the witnessed triangle and the six labels are consumed; of the palettes, their values just before and just after ψ, ψ + 2π/3 and ψ − 2π/3 — nothing at ψ ± π/3; the statement (W) of that record at y_1 and y_{−1} (re-checked: control `lens-shadow`, 1,681 samples); C132-SHADOW four times; four inner products of unit vectors. It reads nothing at y_0: no side there, no palette there, no witness there
  not claimed: anything when y_1 or y_{−1} has only a pure inner side, or no pure side (an edge set of x on its unit circle and the two others blocked on opposite sides — the kept model's case at its three four-label points); that any label of T is the one in the lens, or that the lens is of one label; that y_0 is a cyclic centre, or carries any witnessed edge; anything for an outside state that is not a step at ψ and ψ ± 2π/3; that a six-sector turning seed exists
  argument: FS132-E6-derivation.md § Argument — the lens
  verdict: derived
  grade: derived from: C132-SHADOW
  minds: 1
  model: none satisfying every hypothesis is known — no weak six-colouring with a turning seed is held, and the kept fragment has no ring point with a pure outer side (control `kept-model`: sides I-I-I-). What is exhibited: the geometry (control `lens-shadow`: of 600 lens points none whose unit circle misses either far wedge), and the mechanism without the hypothesis — at the kept fragment's point y_1 the outer wedges of both neighbours carry the labels C132-PLACE would force there (n, b, a at y_2 and a, n, b at y_0, in the order O_cw, O_far, O_ccw) and its lens carries a label of x
  prior art: partly: its composition was posed by the asking lane (`plans/POROS-2026-10-07-fs132-round2.md` § 1.3 E, through a chart and the transfer); the search's hand argument has its three pair rules as rows of an exact table in the wedge family (`plans/SEARCH-2026-10-07.md` § 1.5, steps 1–3); in the map class the statement is the ring calculus at a hub (G91; FS116-RING-TWIST-C); at five labels the release's lemma "Polynomial three-label region" is the neighbouring statement (by FS132-E4's reading, not mine); for a weak six-colouring not searched in print by this job — owed
  handoff: de Bruijn — after C132-PLACE's module: two charts read at y_1 and y_{−1}, then C132-SHADOW with the four segments the argument names

**On a turning seed, the lens at a ring point between two outer-pure neighbours carries only the centre's own labels.**
"It reads nothing at `y_0`: no side there, no palette there, no witness there." The card's falsifier was computed and is
empty (control `lens-shadow`). Its `grade:` line names C132-SHADOW; C132-PLACE (E4, [hand], one mind) is in its `uses
only:` and governs it equally. **Side: reaches the hard case** — its hypotheses sit at the two neighbours and none at
`y_0`, so it holds at a ring point on whose unit circle an edge set of `x` lies: "the first conclusion of this milestone
at a ring point of the hard kind, reached from neighbours of the easy kind" (E6 § The two things the brief asks to carry
visibly). The neighbours are on the arc-free side: each needs two edge sets with a point strictly inside its unit circle.

control: lens-shadow
  of: C132-LENS — the card's falsifier, computed: on a polar grid in B(y_0, 0.02), the points of the lens (and all points inside the unit circle about either neighbour) whose unit circle meets the far wedge at that neighbour, within radius 0.2, in zero length; and (W) at y_1 against distances
  run: python3 ../data/fs132/e6/lens_checks.py shadow
  expect: lens-points=600 missing-the-wedge-at-y1=0 missing-the-wedge-at-y-1=0 points-inside-y1=1800 missing=0 points-inside-y-1=1800 missing=0 least-arc-over-depth=11 chart-samples=1681 chart-mismatches=0
  fault: python3 ../data/fs132/e6/lens_checks.py shadow --fault

derivation: C132-LENS-SIDE
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that at least two of the sets K_j have a point strictly inside the unit circle about y_1 and at least two of them have a point strictly inside the unit circle about y_{−1}; then it is not the case that at least two of the sets K_j have a point strictly outside the unit circle about y_0
  uses only: C132-LENS; C132-WIT-SIDE at w = y_0 for two of the sets (inherited: `plans/FS132-E5-derivation.md`, [hand], one mind — its argument is four lines and I re-derived it); that two edges of a triangle have its three labels among their endpoints; that the lens at y_0 is a non-empty open set inside the unit circle about x
  not claimed: that y_0 has a pure outer side; anything at a ring point one of whose neighbours has no pure outer side
  argument: FS132-E6-derivation.md § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS
  minds: 1
  model: none can exist (a non-existence); the count it rests on, as a pattern: among 46,656 triples of witness points at distance 1/10 from x the sides read O I O I O I in 2,592, and in each of those the statement applies at every inner-pure point (control `side-patterns`)
  prior art: partly: as C132-LENS; the statement is the asking lane's clause (i)
  handoff: de Bruijn — a corollary of C132-LENS and the strips' entry by one open set of positive measure

The card's clause (i): between two outer-pure ring points, no pure inner side. **Side:** as C132-LENS. With it the ring
card's sentence "at an inner-pure `y` the inside holds `a` and `b` only" (E4 § Where C132-TURN stalls, (i)) and C132-LENS
are not in conflict: together they are this entry.

derivation: C132-LENS-FOUR
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and k an integer such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m; then y_k lies in the closed essential supports of a, of b, of n and of a label of T, and there is η > 0 such that almost every point of B(y_k, η) outside the unit circle about x has its label in {a, b, n} and almost every point of B(y_k, η) inside the unit circles about y_{k−1} and y_{k+1} has its label in T
  uses only: C132-LENS at y_k, after turning the seed by kπ/3 (which carries its hypotheses to themselves with a, b, n permuted cyclically); C132-PLACE on the outer side at y_k and list line L4 of that record (the three outer wedges carry the three outside labels, one each); that the lens and the three outer wedges meet every ball about y_k in a non-empty open set
  not claimed: which label of T is present, or that only one is; that the inner wedges beside the lens carry any label of T; that y_k is a cyclic centre in the release's sense (its transition graph is not computed); anything when k − 1, k, k + 1 are not all outer-pure
  argument: FS132-E6-derivation.md § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS
  minds: 1
  model: none is known (as C132-LENS); the kept fragment has no ring point with the labels a, b, n and one label of T — its four-label points carry two labels of x and two of the ring (control `kept-model`)
  prior art: partly: as C132-LENS; the conclusion "a four-label point is placed" is the asking lane's clause (ii) at the pattern O O O
  handoff: de Bruijn — a corollary of C132-LENS and C132-PLACE; the formal statement to read back is "four closed essential supports contain y_k"

**Three consecutive outer-pure ring points: the middle one has four labels present** — "the existence side's first
forcing statement in measure — and it is on the arc-free side" (item 28 (b)). **Side: arc-free (β)** at all three ring
points (each has two edge sets with a point strictly inside its unit circle).

derivation: C132-LENS-GERM
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that each of the sets K_0, K_1, K_2 has a point that lies strictly inside the unit circles about three of the six points y_0, …, y_5 and strictly outside the unit circles about the other three; then there is an integer k such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m
  uses only: that a point strictly inside the unit circle about y is strictly outside the unit circle about 2x − y; a count of three three-element sets over three antipodal pairs; C132-LENS-SIDE at a ring point between two outer-pure ones, to exclude the alternating pattern
  not claimed: anything for sets whose points off the six circles are all outside four or more of them — sets that witness from far away (the card's clause (ii) is open there: C132-LENS-II); that the hypothesis holds for the continua of an extraction — it does when each has a limiting direction at x perpendicular to none of the six directions e(ψ + kπ/3), and fails when a set lies on the unit circle about a ring point
  argument: FS132-E6-derivation.md § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS-SIDE
  minds: 1
  model: none is known (as C132-LENS); the count as a pattern: 46,656 triples of witness points at distance 1/10 from x give three outer-pure points in a row in 44,064 and the alternating pattern in 2,592, nothing else (control `side-patterns`)
  prior art: partly: the count is the ring card's (`plans/FS132-E4-derivation.md` l. 578), there without the hypothesis it needs
  handoff: de Bruijn — a finite count on ℤ/6 and one inequality; with C132-LENS-FOUR it is the card's clause (ii) at the hypothesis the argument reads

When three such ring points exist: when every edge set has a point strictly inside three of the six unit circles and
strictly outside the other three — as the extraction's continua do when each has a limiting direction perpendicular to no
ring direction. **Side: arc-free (β)** — "its hypothesis fails for a set lying on a unit circle about a ring point" (E6).

control: side-patterns
  of: C132-LENS-GERM — the patterns of sides for three witness points at distance 1/10 from x on a grid of directions, for three witness points at distance 3, for one outer-pure point, and the number of sets of outer-pure points the card's clause (ii) leaves open
  run: python3 ../data/fs132/e6/lens_checks.py sides
  expect: near-witness-triples=46656 three-in-a-row=44064 alternating=2592 other=0 far-witnesses=IIIIII one-outer=OIIIII outer-sets-left-open=16
  fault: python3 ../data/fs132/e6/lens_checks.py sides --fault

derivation: C132-PLACED-RING
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that at least two of the sets K_j have a point strictly inside the unit circle about y_1 and at least two of them have a point strictly inside the unit circle about y_{−1}; then there is κ > 0 such that almost every point w of B(y_1, κ) with |w − x| > 1 and |w − y_2| > 1 has the label b when |w − y_0| < 1 and the label a when |w − y_0| > 1, and almost every point w of B(y_{−1}, κ) with |w − x| > 1 and |w − y_{−2}| > 1 has the label a when |w − y_0| < 1 and the label b when |w − y_0| > 1; and if U contains the unit circle about y_0, then for almost every θ in (ψ + 2π/3 − κ, ψ + 2π/3) and almost every θ in (ψ − 2π/3, ψ − 2π/3 + κ) the palette P_{y_0}(e(θ)) is contained in {a, b}
  uses only: C132-PLACE on the outer side at y_1 and y_{−1} with (W) (as in C132-LENS's argument); that the points y_0 + e(θ) of the two arcs lie in the two open regions named (control `placed-arcs`); the release's definition of a typical point (density one of its own label, `palettes.tex` l. 20) and of the palette (Definition 5.1, ll. 47–68), read by me
  not claimed: that the two palettes contain both a and b (each is present on one side of the arc, which gives it for samplings from that side; not written out); anything on the rest of the unit circle about y_0 — in particular at x, at y_0 + e(ψ ± π/3) and at y_0 + e(ψ); that y_0 has a pure outer side (with one, a and b are present at y_0 by C132-LENS-FOUR, and the two arcs then carry both their side labels at their centre)
  argument: FS132-E6-derivation.md § Argument — the placed point's ring at its two neighbours
  verdict: derived
  grade: hand
  minds: 1
  model: none is known (as C132-LENS); the geometry is exhibited — 400 points of the two arcs, none outside its region, with O_cw and O_far of y_1 on the two sides of the unit circle about y_0, and O_ccw and O_far of y_{−1} (control `placed-arcs`)
  prior art: partly: in the map class this is row 135's unit arc "centred at a vertex of at least four colours carrying both its side colours" with the vertex placed by the ring (G91), read by me only as `plans/STUB-six-by-the-nerve.md` and the asking lane's record quote it; the two regions are the ring card's list line L4 at y_{±1}; for a weak colouring not searched in print — owed
  handoff: de Bruijn — only with a consumer; two charts and the definition of the palette

**The placed point's own ring, at its two neighbours.** Its unit circle runs along an interface between the two ring
labels there, oppositely oriented at the two — "so the first night's exclusion says nothing on the orbit through `x`"
(item 29). For FS-124: "the placed point is the centre of two unit arcs carrying both their side labels, of opposite
orientation" — a measurable instance of that stub's first question with every hypothesis derived (E6's report). **Side:**
its hypotheses are at the two neighbours, on the arc-free side; **its conclusion produces the hard object, of kind (α), at
the placed point.**

Rests on it: C132-PLACED's list (§ 8).

control: placed-arcs
  of: C132-PLACED-RING — the points y_0 + e(θ) just before the direction of y_1 and just after that of y_{−1}: outside the unit circle about x and about y_2 (y_{−2}), and the wedges at y_{±1} just inside and just outside the unit circle about y_0 there
  run: python3 ../data/fs132/e6/lens_checks.py ringarc
  expect: arc-points=400 outside-the-region=0 wedges=[(-1, 'in', 'O_ccw'), (-1, 'out', 'O_far'), (1, 'in', 'O_cw'), (1, 'out', 'O_far')]
  fault: python3 ../data/fs132/e6/lens_checks.py ringarc --fault

**The second round's seven-label controls, re-run at circumradius 1/2** (E6 § The two riding controls; the four controls
below). "Two counts move, none against an entry": `hex7-crossings`' own-label count 0 → 36 of 432, and `margin-witness`'
0 → 6,672 with all seven labels on the annulus; "at 1/2 the second round's exclusions still hold, and what the 2/5
controls' zeros recorded beyond them was the margin." **The second round's seven-colour controls are controls of the
margin case only** (item 28 (d)); the dated lines are under the two controls in E4's and E5's records. And **the search's
kept four-label model is the hard case, and no statement of this section applies to it** — its sides read `I - I - I -`,
no ring point is outer-pure (control `kept-model`, § 2).

control: hex-half-crossings
  of: C132-LENS — riding: the ring card's control `hex7-crossings` on the honeycomb at circumradius 1/2 (the fault is the original radius 2/5, whose line must be the second round's)
  run: python3 ../data/fs132/e6/hex_half.py hex7
  expect: radius=0.5 vertex-pairs=216 crossings=432 least-shared-outside=1 own-label-near-crossing=36
  fault: python3 ../data/fs132/e6/hex_half.py hex7 --radius 0.4

control: hex-half-sides
  of: C132-LENS — riding: at circumradius 1/2, every sample near a common unit point that carries a label of one of the two vertices lies inside that vertex's unit circle (the fault is circumradius 0.45, where no such sample exists)
  run: python3 ../data/fs132/e6/lens_checks.py hexcross
  expect: radius=0.5 crossings=432 crossings-with-an-own-label=36 own-label-samples=5760 own-label-samples-outside-the-vertex's-unit-circle=0
  fault: python3 ../data/fs132/e6/lens_checks.py hexcross --fault

control: hex-half-margin
  of: C132-LENS — riding: the witness card's control `margin-witness` at circumradius 1/2 (the fault is the original radius)
  run: python3 ../data/fs132/e6/hex_half.py witness
  expect: radius=0.5 colourings=3 points=13 samples=982800 vertex-labels-on-annulus=6672 labels-seen=0123456
  fault: python3 ../data/fs132/e6/hex_half.py witness --radius 0.4

control: hex-half-relation
  of: C132-LENS — riding: the first round's control `hex7-relation` at circumradius 1/2, the three vertices on the unit circle counted inside it (the fault is the original radius)
  run: python3 ../data/fs132/e6/hex_half.py hexrel --closed
  expect: radius=0.5 own-labels=[0, 2, 3] ring-labels=[1, 4, 5, 6] own-on-rings=[[0, 2, 3], [], []] crossings=9 ring-walk=654164514 two-jumps-60-apart=False vertices-inside=13 relation-holds=True
  fault: python3 ../data/fs132/e6/hex_half.py hexrel --closed --radius 0.4

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

derivation: C132-GRUNDY7-NOT
  statement: for no order of the seven labels is the hexagonal seven-colouring with circumradius 2/5, the island colouring (EXT-OAI2-SLACK7-L) or the stripe colouring (EXT-OAI2-SLACK7-P) a Grundy colouring in the sense of FS121-D3-GRUNDY, in which the class first in the order is maximal, up to null sets, among measurable sets with null unit pairs and each later class is maximal among such sets inside the complement of the earlier classes
  uses only: the two margins of the hexagonal colouring (two points of one hexagon at most 0.8 apart; distinct hexagons of one label more than 1.033 apart) and that the slack colourings differ from it only inside the ball of radius 0.03 about v, by labels of v; for the second reason FS121-D3-GRUNDY's step (b), which follows from the definition alone (a positive-measure set of points of a later class whose unit circles meet an earlier class in zero length could be added to the earlier class)
  not claimed: that this tells the slack colourings from the hexagonal one — it does not, and that is the finding; anything about the hexagonal colouring at circumradius 1/2, or about this project's seven-colouring R7, which FS121-D3-GRUNDY's model line says is Grundy in every order
  argument: FS132-E5-derivation.md § Argument — neither is honest, and neither is the colouring they were planted in
  verdict: derived
  grade: hand
  minds: 1
  model: the three colourings themselves; control `grundy-margins` — the hexagons of one label thickened by 0.016 hold no unit pair with 60 points just outside one of them, and the unit circles about a point of an island and about a point of a hexagon near v carry only the four labels that are not labels of v
  prior art: partly: Grundy and fall colourings of finite graphs are classical (row 143's line: Dunbar et al. 2000, by that row; not read by this job); that a colouring with a margin is not Grundy is immediate from FS121-D3-GRUNDY; owed beyond that
  handoff: none — a calibration for the asking lane's ruling on the class of C132-RING-TAME; nothing here is for the kernel

**The first clause of the Grundy test tests nothing**: no order makes any of the three seven-colourings a Grundy
colouring, "true already of the unmodified hexagonal colouring" (item 19). **Side: the margin case** — all three have a
margin.

control: grundy-margins
  of: C132-GRUNDY7-NOT — (a) the hexagons of label 0 thickened by 0.016 against 60 points 0.008 outside the hexagon of centre (0, 0): no unit pair on 3600 angles each, and both margins hold; (b) in the island colouring the unit circles about a point of island 6 and about a point of the label-3 hexagon near the vertex carry only the labels 1, 4, 5, 6; the fault thickens by 0.1
  run: python3 ../data/fs132/e5/margin_check.py grundy
  expect: thickened-unit-pairs=0 margins=True,True ring-labels-at-island-point=1456 ring-labels-at-tile-point=1456
  fault: python3 ../data/fs132/e5/margin_check.py grundy --fault

derivation: C132-GRUNDY7-LOCAL
  statement: for each of the island colouring and the stripe colouring, and each order of the seven labels beginning with one of the three labels of the vertex v, some output (A_1, …, A_7) of FS121-D3-GRUNDY's construction on that colouring in that order has the first class A_1 containing almost every point of the ball of radius 0.03 about v; in such an output no point of that open ball is a cyclic centre, and for the stripe colouring's point x the palette P_x(e) is the single first label for almost every direction e with x + e in that ball
  uses only: that the class of a label a of v together with B(v, 0.03) holds no unit pair (two points of the ball are less than 0.06 apart; a point of the ball and a point of the hexagon of a at v at most 0.83; a point of the ball and a point of another hexagon of a more than 1.003); that the construction's family at its first step contains every measurable set with null unit pairs that contains the class, and that every member lies below a maximal one (its own chain argument, FS111-M-SATC (i) by that record, not re-read); that a ball carrying one label almost everywhere has no transition between two classes, and every circle sample through it has that label's coordinate equal to 1 there
  not claimed: anything about the output outside B(v, 0.03) — the maximal extension is a choice there, and nothing bounds what it does; that every output in such an order contains the ball; anything for an order beginning with one of the four other labels; that any output has finitely many cyclic centres in every disc or finitely many changes on every ring
  argument: FS132-E5-derivation.md § Argument — some honest output erases the planted slack
  verdict: derived
  grade: hand
  minds: 1
  model: the order 3, 1, 2, 4, 5, 6, 7 on the island colouring: the first class starts from the hexagons of label 3 with the islands and is extended over B(v, 0.03), swallowing the 1–2 edge near v
  prior art: owed — the statement is this project's
  handoff: none — a calibration

For a suitable order some output of the Grundy construction is one label on the whole slack ball. **Side: the margin
case.** Neither entry decides the class of C132-RING-TAME's first clause (the claim list's dated line of item 19).

## 8. Stalls and gaps — each a result, with its step and its smallest open form

*Nine entries here and one in § 3 (C132-CORES-SQUARE). Each keeps its source's block; the address of its smallest open
form is in its `handoff:` line. "Left this milestone" means the asking lane's stops, adopted at item 23 (b): whether, in
the class of all weak colourings, a point with usable data must exist goes to FS-127 and FS-128.*

derivation: C132-RUN-EMPTY
  statement: each step of the route FS116-V6 § 2.2 (`plans/FS116-V6-verification.md`: V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-HUBS, V6-ANTI, V6-HUG, V6-COUNT, read with FS129-SR3-EMPTY-NS's sector form of the last) has a restatement under the dictionary, true of every weak measurable six-colouring of an open set containing a closed disc of radius above 1 about an extracted centre `p` with `ℓ = 4` whose palettes almost everywhere contain a label outside the cycle, derived from the data, the toolkit and that ring hypothesis alone; and the restated steps end in a contradiction — so that no such colouring exists (**C132-M-EMPTY**, the existence form's NO, named here so that it can be derived by another route)
  uses only: § The route, step by step — V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-ANTI and V6-HUG each have a restatement derived inside C132-M-ORBIT's argument; V6-HUBS has none; V6-COUNT's count consumes V6-HUBS and has none, its last step has one
  not claimed: that C132-M-EMPTY is open or false — it is derived (the entry above), by the nine restated steps with M6 in place of V6-HUBS and of the count; that no restatement of V6-HUBS could ever be derived on its own (after C132-M-EMPTY every statement about the class holds vacuously; the stall is of V6-HUBS's argument, which reads a tile)
  argument: FS132-E3-derivation.md § The route, step by step
  verdict: stalls at: V6-HUBS — "a tile of p tips at most two [change points], and two only if consecutive", whose argument is "a tile's tipped change points are pairwise within distance 1 (V6-DIAM)": the dictionary's left-hand term is the tile as one connected piece of diameter at most 1 holding two hubs in its closure ("the same tile"); the data confine a label's exclusion sets, not the label
  grade: hand
  minds: 1
  model: the configuration the data leave where V6-HUBS stood — a label that is the tip at three consecutive hubs (pattern A of M6) — is not excluded by confinement alone: its two exclusion sets lie within 30° of the middle hub's direction, inside all three closed unit discs
  prior art: owed — the reading is this project's; nothing to search
  handoff: none — a reading; what crosses is C132-M-EXCL

**A reading that stalls at a step that is not needed.** Nine of the route's eleven steps restate; V6-HUBS reads a tile as
one connected piece and has no restatement; its place and the count's are taken by M6. The statement the reading was for,
C132-M-EMPTY, is derived (§ 10). **A correction on record:** the plan's dictionary term for a tip is too wide (this
entry's own step table, row V6-TIP); the dated line is appended to `plans/FS132-six-by-the-nerve.md` § The readings, stated.

derivation: C132-RUN-CV
  statement: each input of the route to FS114-CV-EXISTS (`plans/FS114-CVB-verification.md` § 1.4, by the entry's `uses only:` — FS112-N3-DENSE3, FS112-N2-TERM with its terminal modification `M*`, N4-FIN, and "a modification creating no unit arc keeps a four-colour vertex's colours at the vertex") has a restatement under the dictionary, true of every weak measurable six-colouring of the plane whose cyclic centres are finite in every closed disc, derived from the data and the toolkit alone; and the restated steps give an extracted centre with `ℓ ≥ 4` (**C132-M-CV**, [G₆] in the measurable class under C132-EXT's hypothesis)
  uses only: § The existence route, input by input — the reading of the four inputs against C132-EXT-DISC
  not claimed: that C132-M-CV is false (a stall of the reading says nothing of the statement); that the measurable side needs the three inputs FS112-N2-TERM, N4-FIN and the colour-keeping of the moves at all — it does not (the extraction stands where they stood); what the proof of FS112-N3-DENSE3 reads of a cubic map (unread here)
  argument: FS132-E3-derivation.md § The existence route, input by input
  verdict: stalls at: FS112-N3-DENSE3 — "every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a repeated colour": its second alternative reads the cyclic order of tiles at a point (no counterpart), and with that alternative gone its restatement is C132-M-CV itself; its proof is row 134's base (`[SokolovVoronov2025]` Cor. 1 for curved cubic maps), which no statement of the data or the toolkit replaces at six
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring — every extracted centre is a triangle (the first deriver's control `hex7-model`), so at seven the restated input is false, as FS112-N3-DENSE3 is false for it (CVB § 1.4, "Seven-colour control")
  prior art: owed — the reading is this project's; nothing to search
  handoff: none — a reading; its hand-over line is below

**The existence reading stalls at its first input.** With its repeated-colour alternative gone the restated input is
C132-M-CV itself; the route's other three inputs dissolve (the nerve normalizes with no modification). C132-M-CV — an
extracted centre with a cycle of length at least four — is **open**: it "holds exactly when the measurable side can
refute 'every extracted centre is a triangle'" (item 9), and stalls by the other route at C132-RING-TAME. E3's hand-over:
put to row 134's base the question it put to this project's exclusion (unread by it: the base's verification, the proof
of the stalled input).

derivation: C132-RING-TAME
  statement: for every weak measurable six-colouring of the plane and every x, ρ, labels i_0, i_1, i_2, continua K_j and directions v_j satisfying clauses (1), (2), (3) of C132-EXT-DISC with ℓ = 3, with N the set of the three other labels and Π_x(e) ⊂ N the set of the labels of positive weight, at the direction e, in the weak-* limits of the colouring's samples on circles about x whose radii tend to 1 from the side on which C132-TRI-STRIP's strip at e carries only N, the set J_x of the directions e having no arc about e on which Π_x is almost everywhere equal to one set is finite, and no two of its points are at angle π/3
  uses only: nothing — it is posed, as the hypothesis under which C132-RING-WIND gives the ring of a triangle centre a winding number congruent to 3 modulo 6
  not claimed: that it holds — for a class containing a six-colouring with local slack along such a ring it fails (G95's stripes, planted in the labels of N, make J_x infinite), so the class in which it can be true is a normal form, which is not chosen here; that it suffices for C132-LONG (the count of centres inside the unit circle needs the smoothed colouring on the circle itself, and the two last steps of the regular chain are beyond it); that its second clause can hold at a centre whose three directions v_j make angles of 2π/3, where the six directions at which the pure side changes are π/3 apart
  argument: FS132-E2-derivation.md § The stalled step, as a statement of its own
  verdict: stalls at: the first clause, finiteness of J_x — the release's strip rigidity (its Lemma 8.6) is for two labels on a strip and makes a binary ring locally constant off six directions; for three labels on a strip no rigidity is held, by the release or here, and two of them may alternate at every scale
  grade: hand
  minds: 1
  model: none at six — no six-colouring is known; at seven the hexagonal colouring's ring at a vertex has J_x of nine points, no two π/3 apart, with Π_x valued in a set of four labels (control `hex7-relation`), so it satisfies both clauses and lies outside the statement only by its count of labels
  prior art: partly: in the map classes the first clause is the definition of a map and the second is Sokolov–Voronov's transversality (`plans/FS110-CB-verification.md` § D5, "(i)/(ii) under transversality"); for weak measurable colourings the two-label form is `[OAIMath2026]` Lemmas 8.6–8.7; the three-label form not found by the milestone's gate
  handoff: Poros — not derived; stalls at the finiteness of the changes of a three-labelled ring; the smallest open form is § The stalled step, as a statement of its own, items (a)–(c)

**The stalled step as a statement of its own, about one circle at one centre.** Its "first clause is false wherever
local slack exists along the strip, so it is a statement for a normal form or false at six" (item 7). The asking lane
split its class (item 11): the second clause as a conclusion for every weak colouring living on triangles alone — the
ring card, where C132-ALT and C132-TURN-EDGE are what was derived and C132-TURN stalls; the first clause for honest
colourings, untested — C132-GRUNDY7 did not decide it — and, for all weak colourings, left this milestone.

derivation: C132-LONG
  statement: There is a radius R₀ > 1 such that, for every weak measurable six-colouring of the plane and every closed disc D of radius R₀ in which its cyclic centres are finitely many, the conclusion of C132-EXT-DISC holds at some point of D with ℓ ≥ 4
  uses only: nothing is carried; the route attempted is the regular classes' cubic theorem, read step by step against the weak class in § Where the forcing statement stalls
  not claimed: its truth or its falsity; any value of the chromatic number of the plane; anything when the centres are infinite in every such disc; that a centre whose transition graph holds a cycle of length four or more is returned by the extraction with such a cycle (the converse of C132-EXT-DISC's clause (5), open in the first deriver's record)
  argument: FS132-E2-derivation.md § Where the forcing statement stalls
  verdict: stalls at: the winding number of the three outside labels on the unit circle about an extracted triangle centre — C132-RING-TAME, whose first clause no held statement gives a weak measurable colouring; behind it two further steps of the regular chain have no weak form (two centres of one type at distance between 1 and 2, and the bicycle)
  grade: hand
  minds: 1
  model: none — at six no colouring is known; at seven the statement's analogue is false (the hexagonal colouring has triangle centres only), and at five its class is empty (`[OAIMath2026]` Theorem 1.4)
  prior art: partly: in the regular classes it is `[SokolovVoronov2025]` Corollary 1 (held almost everywhere for curved maps, row 134), `[Voronov2023]` Theorems 1.1–1.3 (row 132) and this project's FS114-CV-EXISTS (row 137); for weak measurable colourings `[OAIMath2026]` says "The remaining alternatives six and seven are unresolved." (`M/introduction.tex:70`, as the stub quotes it)
  handoff: Poros — not derived; stalls at C132-RING-TAME; C132-M-CV stalls with it

**The forcing statement — the disc form of C132-M-CV — stalls at C132-RING-TAME**, and behind it two steps of the regular
chain have no weak form (eleven vertices against ten types; the bicycle). Of the regular proof's steps: R1 held; R2
derived, one side (C132-TRI-STRIP); R3's lemmas derived (C132-INDEX, C132-RING-WIND), their hypothesis the stall; R4's
relation derived (C132-REL), its use unposed; the regular chain's last line derived in the exact class the next round
(C132-COMP-SHARP) (item 7; item 12's table).

derivation: C132-TURN
  statement: In a weak measurable six-colouring of a closed disc of radius above 2 about a triangle centre `x`, every cyclic centre of which carries a witnessed triangle and no longer witnessed cycle, `W_x = 3` almost everywhere and no two essential changes of the outside label are `π/3` apart
  uses only: nothing is carried to the statement. Derived on the way: C132-ALT (two changes π/3 apart of the alternating kind, for a step and two adjacent ring points with pure sides) and C132-TURN-EDGE (at a step of the turning kind whose two neighbours have pure outer sides the two ring labels are never a witnessed edge at the ring point)
  not claimed: its truth or its falsity; that a ring by formula survives — none was built, and § What a colouring by formula would need says why none is in reach without a search; anything for an outside state that is only measurable near the orbit
  argument: FS132-E4-derivation.md § Where C132-TURN stalls
  verdict: stalls at: the step from the card's hypothesis to a witness at the ring point of a turning orbit — that the ring point is a cyclic centre (the side of the ring that is not pure is left free by the transfer), and that the witnessed triangle the hypothesis then gives it contains the pair of the two ring labels, as it would if a witnessed cycle had to lie in the point's own transition graph (the relation of C132-EXT-DISC's clause (5), one mind, against a sentence of the manuscript); with that pair witnessed C132-TURN-EDGE is a contradiction
  grade: hand
  minds: 1
  model: none — no six-colouring is known; at seven the statement has no analogue (four outside labels carry no orbit index, and the honeycomb's rings have no two changes π/3 apart: FS132-E2's control `hex7-relation`)
  prior art: partly: in the map classes "no two changes π/3 apart" is Sokolov–Voronov's transversality (by `plans/FS110-CB-verification.md` § D5, as FS132-E2's entry C132-RING-TAME cites it; not read by this job); for weak colourings not found by the milestone's gate
  handoff: Poros — not derived; stalls at a witness at the ring point; the smallest open forms are § Where C132-TURN stalls, items (i)–(iii)

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

derivation: C132-WIT-EX
  statement: for every integer k ≥ 1, every weak measurable k-colouring of the plane and every closed disc D of radius greater than 1, there are a point p of D, an integer ℓ ≥ 3, distinct labels i_0, …, i_{ℓ−1} and points q_0, …, q_{ℓ−1} other than p such that for each j modulo ℓ the closed essential supports H_{i_j} and H_{i_{j+1}} both miss Δ({p, q_j})
  uses only: what is derived towards it — C132-WIT-MARGIN (it holds at every point with a margin for three labels), C132-WIT-EX-FIN (it holds on every disc with finitely many cyclic centres), C132-WIT-SUPER (it holds at every point through which, for each edge of some cycle, connected pieces of both smoothed classes pass and reach a common second point) — and nothing that covers a colouring with none of the three
  not claimed: that it is false — no colouring is offered against it, and none this record can write by formula could be one (§ The stall, last paragraph); the anchored form beyond C132-WIT-EX-FIN
  argument: FS132-E5-derivation.md § The stall
  verdict: stalls at: the selection of a point through which connected pieces of two smoothed classes pass and reach a common second point — the extraction's step S8 (`plans/FS132-E1-derivation.md`; the manuscript's `M/interfaces.tex:581–590` by that record), where an annulus about an isolated centre makes each fibre of the graph map cross from the centre's core to a fixed circle; with a second cyclic centre in every ball about the first there is no map on any annulus, and Lebesgue's covering theorem, which still gives a point of multiplicity three at every scale, bounds no diameter of a pairwise overlap from below
  grade: hand
  minds: 1
  model: where the statement is known to hold: every colouring with a margin (C132-WIT-MARGIN's model) and every disc with finitely many centres (C132-WIT-EX-FIN's). No model of its failure is known
  prior art: owed — the statement is the asking lane's; nothing to search beyond the milestone's gate, which this job did not extend (§ Prior art, this job)
  handoff: Poros — not derived; stalls at the step named; the smallest open form is § The stall, (O)

**Existence of the data with no hypothesis on the centres stalls at the extraction's selection step.** As posed it "is
met at points where none of the cycle's labels is present" and is free wherever there is a margin (C132-WIT-MARGIN). Its
smallest open form (O): "a weak colouring and a disc of radius above 1 in which, at every point, the graph of witnessed
label pairs is a forest". Left this milestone.

derivation: C132-GRUNDY7
  statement: For no order of the seven labels is the island colouring or the stripe colouring (`plans/EXT-OAI2-reading.md` § 5.6) a Grundy colouring, and the Grundy-ization of each (FS121-D3-GRUNDY's construction) has finitely many cyclic centres in every disc and finitely many changes on every ring
  uses only: for its first clause C132-GRUNDY7-NOT; for its second, what is derived of the family the construction defines — C132-GRUNDY7-LOCAL
  not claimed: that the second clause is false in either reading — no honest seven-colouring with accumulating centres or a ring that changes infinitely often is exhibited; that it is true in either
  argument: FS132-E5-derivation.md § What the second clause is, and what is left of it
  verdict: stalls at: the second clause, at the words "the Grundy-ization of each" — FS121-D3-GRUNDY's construction lets A_m be any maximal element of a family, after an order is chosen, and its own entry does not claim uniqueness; read as "some output" the clause is derived only inside the slack ball (C132-GRUNDY7-LOCAL), read as "every output" not at all: no statement held here bounds the complexity of a relatively maximal set with null unit pairs
  grade: hand
  minds: 1
  model: what the first clause holds of — the three colourings of C132-GRUNDY7-NOT; for the second clause read as "some output", the output of C132-GRUNDY7-LOCAL inside the ball
  prior art: owed — the claim is the asking lane's
  handoff: Poros — not derived; stalls at the step named; the smallest open forms are § What the second clause is, and what is left of it, (G1) and (G2)

**Stalls at its second clause, which is not one statement**; that clause is withdrawn as posed (item 19 (a)); its two
readings, (G1) "some output" and (G2) "every honest seven-colouring", are open and left this milestone.

derivation: C132-LENS-II
  statement: On a six-sector turning seed, if each of the six ring points has a pure side, some ring point has four labels present: `a`, `b`, `n` and a label of `T`
  uses only: nothing is carried to the statement as posed. Derived of it: C132-LENS-FOUR (wherever three consecutive ring points have pure outer sides) and C132-LENS-GERM (which gives those three when every edge set has a point inside three of the six circles and outside three)
  not claimed: its truth or its falsity for the sixteen patterns of sides § The gap in clause (ii) lists; no seed with such sides was built, and none was excluded
  argument: FS132-E6-derivation.md § The gap in clause (ii)
  verdict: gap: the step "pure sides are opposite at antipodes, so the six read O O O I I I or O I O I O I" — a point of a set strictly inside the unit circle about y is strictly outside the one about 2x − y, and not conversely; three sets {x, q_j} with |q_j − x| = 3 give six pure inner sides and no pure outer side (control `side-patterns`: IIIIII)
  grade: hand
  minds: 1
  model: the hypothesis alone is met by the three two-point sets of the gap, as a pattern of sides and not as a colouring
  prior art: partly: the sentence is the asking lane's (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes, C132-LENS (ii)); the step is the ring card's l. 578
  handoff: Poros — not derived as posed; gap at the antipodal step; the smallest open form is the last paragraph of § The gap in clause (ii)

**The card's clause (ii), verbatim, is a gap at "pure sides are opposite at antipodes"** — true one way only. Derived of
it: C132-LENS-FOUR and C132-LENS-GERM. Open: sixteen patterns of sides, "all of them seeds whose sets witness from far
away". It stands as a gap and is not re-posed (item 29 (a)).

derivation: C132-PLACED
  statement: At the four-label ring point `y` of C132-LENS (ii): in the grammar of C132-PLACE's list, the labels present in each of the six wedges at `y` cut by the unit circles about `x`, `y_1` and `y_{−1}`, and which labels of `T` the sides at `y` allow in the lens; then, using C132-WITNESS only on wedges the list forces to be of one label, which pairs of the four labels are witnessed edges at `y`, whether they close a four-cycle, and — if they do — what the first night's exclusion (C132-M-ORBIT in C132-WIT's four-point form) says on the orbit of `y`'s ring through `x`. Each line derived or marked open
  uses only: for the lines derived — C132-LENS and C132-LENS-FOUR; C132-WIT-SIDE at y; C132-WITNESS on the three outer wedges (inherited); C132-TURN-EDGE (inherited, [hand], one mind, its argument read and not reworked); C132-PLACED-RING
  not claimed: that the witnessed edges at y close a four-cycle, or that they do not; which labels fill the two inner wedges beside the lens; anything on an orbit of y's ring other than the one through x
  argument: FS132-E6-derivation.md § The list
  verdict: gap: whether any pair containing a label of T is a witnessed edge at y — the two inner wedges beside the lens are not forced to one label, and the closure of the lens meets the closures of the three outer wedges at y alone, so C132-WITNESS gives the path a – n – b and nothing through T
  grade: hand
  minds: 1
  model: none is known (as C132-LENS)
  prior art: partly: the sentence is the asking lane's (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes)
  handoff: Poros — the list with its open line; the branch of the card's table that occurred is "a mixed ring"; the smallest open forms are under § The list

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

derivation: C132-EXT
  statement: For every `k` and every measurable `c : ℝ² → {1, …, k}` proper at almost every unit pair whose cyclic centres (the manuscript's Definition 6.1 with `k` labels) are finite in the closed disc of radius 8: there are a cyclic centre `x`, a simple cycle of labels of length `ℓ ∈ {3, …, k}`, and `ℓ` compact connected sets through `x` with limiting directions, each excluding the essential supports of both its labels from its straddle set — the manuscript's Proposition 7.1 with `k` in place of five
  uses only: C132-EXT-DISC with D the closed disc of radius 8
  not claimed: what C132-EXT-DISC does not claim; that radius 8 is needed (any radius above 1 serves)
  argument: FS132-E1-derivation.md § Argument — the posed forms
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: the model of C132-EXT-DISC, with the disc of radius 8 about any point
  prior art: partly: as C132-EXT-DISC
  handoff: de Bruijn — as the instance of C132-EXT-DISC that fits the release's Lean constants; the formal statement to read back is this one

derivation: C132-CORES
  statement: for every `k`, such a colouring has a cyclic centre in every closed disc of radius 8
  uses only: C132-CORES-FREE; the finiteness hypothesis carried by "such a colouring" is not used
  not claimed: what C132-CORES-FREE does not claim
  argument: FS132-E1-derivation.md § Argument — the posed forms
  verdict: derived
  grade: derived from: C132-CORES-FREE
  minds: 1
  model: the model of C132-CORES-FREE
  prior art: partly: as C132-CORES-FREE
  handoff: none — subsumed by C132-CORES-FREE, which crosses

derivation: C132-M-EMPTY
  statement: no weak measurable six-colouring of an open set containing a closed disc of radius above 1 about a point p has, at p, the data of an extracted centre with a cycle of four labels (C132-EXT-DISC's conclusion at p with ℓ = 4: the labels i_0, i_1, i_2, i_3 and the sets K_0, K_1, K_2, K_3 with its clauses (1) to (5)) together with palettes P_p(e) that for almost every unit vector e contain a label outside the cycle
  uses only: C132-M-EXCL with a_j = i_j; of the data, clauses (1) and (3)
  not claimed: what C132-M-EXCL does not claim; that the extraction ever returns ℓ = 4; anything at a centre whose ring is not of that kind
  argument: FS132-E3-derivation.md § Argument — the fixed form
  verdict: derived
  grade: derived from: C132-M-EXCL
  minds: 1
  model: none can exist (a non-existence); the model line of C132-M-ORBIT
  prior art: partly: as C132-M-EXCL
  handoff: none — subsumed by C132-M-EXCL, which crosses

derivation: C132-DIAG
  statement: in a measurable six-colouring no four-cycle centre has a ring alternating, almost everywhere under the 60° rotation, between the two diagonals of its cycle
  uses only: C132-DIAG-WIDE with D, D′ the two diagonals {i_0, i_2}, {i_1, i_3} of the cycle; "a ring alternating between the two diagonals" read as: almost every palette at the centre contains one of the two diagonals, chosen measurably, and the choice changes under the rotation
  not claimed: what C132-DIAG-WIDE does not claim; that the centre is a four-cycle centre is not used
  argument: FS132-E3-derivation.md § Argument — the two-diagonal ring
  verdict: derived
  grade: derived from: C132-DIAG-WIDE
  minds: 1
  model: none can exist (a non-existence)
  prior art: known: as C132-DIAG-WIDE
  handoff: none — subsumed by C132-DIAG-WIDE, which crosses

derivation: C132-COMP
  statement: No weak measurable six-colouring of an open set containing the closed unit discs about two points `x ≠ y` with `|x − y| < 2` has at `x` and at `y` the data of C132-TRI-STRIP (clauses (1)–(3) with `ℓ = 3`) with disjoint label triples, provided one of the two crossing points of the unit circles lies, for `x` and for `y`, in a direction perpendicular to none of that centre's three limiting directions
  uses only: C132-COMP-SHARP at the crossing point of the proviso; of clause (2), that a set K_j with points x + s_m w_m, s_m → 0, w_m → v_j, has a point off the unit circle about x + e whenever e·v_j ≠ 0 (the identity |x + e − q|² = 1 + s² − 2s e·w); of clause (1), x ∈ K_j; clause (3). Properness is not consumed; nothing is read of the second crossing point, of connectedness, of clauses (4) and (5), or of which side is pure
  not claimed: that the data exist at any point of any six-colouring; the statement without the proviso (fragment T2 has the data at both points, at distance 1, and fails the proviso at both crossing points — two of its edges at x are arcs of the unit circle about w, with limiting directions perpendicular to w − x); any bound on the number of triangle types in a disc (the regular chain's count is unposed for weak colourings)
  argument: FS132-E4-derivation.md § Argument — the posed form
  verdict: derived
  grade: derived from: C132-COMP-SHARP
  minds: 1
  model: none can exist (a non-existence); the hypotheses other than the proviso are met by fragment T2 (the model of C132-COMP-SHARP), and at seven labels two triples are never all the labels (control `hex7-crossings`: least-shared-outside=1)
  prior art: partly: as C132-COMP-SHARP
  handoff: none — subsumed by C132-COMP-SHARP, which crosses

derivation: C132-WIT
  statement: C132-M-ORBIT, C132-M-EXCL and C132-TRI-STRIP with each set `K_j` replaced by a two-point set `{p, q_j}` — for the strips, with the changes of side at the directions `f` with `2 f·(q_j − x) = |q_j − x|²`
  uses only: C132-WIT-ORBIT, C132-WIT-EXCL and C132-WIT-STRIP, which are the three restatements written out
  not claimed: that the restated exclusions are wider than the originals (they are the same theorems); what each of the three does not claim
  argument: FS132-E5-derivation.md § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-WIT-ORBIT, C132-WIT-EXCL, C132-WIT-STRIP
  minds: 1
  model: the model lines of the three
  prior art: partly: as the three
  handoff: none — the three entries carry what crosses

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
