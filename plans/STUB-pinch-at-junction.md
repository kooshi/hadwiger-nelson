# FS-120 — the pinch at a junction, and the cover route at five: can a pinch in a measurable fall colouring of the plane be removed locally, or does its cascade reach a junction and stop there? (stub)

*Minted 2026-09-28 by the close job FS111-C at FS-111's close (`plans/FS111-close-inventory.md` items 34, 37, 38; `plans/FS111-C-close.md` § Stage 5).
Kooshi's ruling for FS-111 (item 38): the next step FS111-M4 named — the pinch at a junction — "goes to a stub, not run". FS-111's successor on route M's
colour-generic rung; its siblings are FS-121 (the map step, the top rung) and FS-122 (the forced pair, route R). **Solver column: in-ban** — derivation,
reading, and exact checks of objects given by formula; post-ban, a finder over periodic partitions would be a dial, never a proof. Written for a session
with no memory of FS-111: read `CLAUDE.md` § The aim (links 5–6) and § Counter-priors first, then `plans/FS111-derivation.md` (Round 2 and Rounds 3–4),
`plans/FS111-M3-finiteness.md` and `plans/FS111-M4-cascade.md` in full, and `data/fs111/claims.md` §0.*

## The question

**The objects, in plain words.** A *unit-avoiding* set of the plane is a measurable set with (almost) no two points at distance exactly 1; it is
*maximal* (a **MUA set**) if no set of positive measure can be added to it, and *regular* if it equals the closure of its interior up to a null set and
its boundary has measure zero. A **measurable fall colouring** (a *regular maximal partition*) is a partition of the plane into finitely many regular MUA
sets — graph theory's *fall colouring* (a partition into independent dominating sets) for the unit-distance graph, taken measurably. FS-111 showed that
every tight colouring of the plane lies below a maximal cover (`FS111-M-SATC`, Zorn), that a maximal cover's classes are MUA sets (`FS111-M2-COV`), that a
regular MUA set satisfies the **shadow identity** `int F = ℝ² ∖ (F + S¹)` (`FS111-M2-FIX`, two minds: its interior is exactly the set of points whose unit
circle misses it), and that a regular maximal partition is saturated (`FS111-M2-SELCOMP`, two minds).

**The pinch.** A regular MUA set can have infinitely many interior components in a bounded set: FS111-M3's honeycomb class HC_K (unit triangles on a
honeycomb of edge `2 + √3/3`, bands of length 1 whose thickness vanishes on a Cantor set, discs of radius `1/2` at the face centres; exact in ℚ(√3),
`FS111-M3-HC`, one mind). A small move of the class alone removes the pinch (`FS111-M3-MOVE`), and inside a cover the move survives iff the sliver it
loses is covered by other classes (`FS111-M3-COVER`). **Inside a partition the move cascades:** a pinched layer pinches both neighbouring classes one unit
away on the same set (`FS111-M4-LADDER`); the rungs of this ladder of unit parallels stop being ordinary within a bounded number — `≤ 1/(2c)` up, and down
`≲ w²/(8h)` when "ordinary" includes rolling of unit discs from below (`FS111-M4-CUT`, its downward half conditional); a pinch-removing move runs along
the ladder one rung per step with every class forced and no spare colour at any `k` (`FS111-M4-MOVE`). All one mind.

**The question: where the ladder ends — at a junction of three or more colours, at a class with disconnected local parts, or at an irregular class —
is the cascade absorbed?** Three questions, in order:

1. **Does a regular maximal partition with a pinched class exist?** At any `k`, seven first. FS111-M3 exhibited none ("no maximal seven-cover with a
   pinched class"), and HC_K itself fits no partition whose ladder over its first gap is ordinary through three rungs (`FS111-M4-HC`, exact). A
   derivation that none exists is a **positive result for the rung** (MUA-FIN-L holds vacuously in partitions); a construction by formula, checked
   exactly, is the object the next two questions need.
2. **At a saturated junction, what does an arriving ladder do?** FS-111 holds the sector structure there — no colour takes a reflex angle at a saturated
   point (`FS111-M-HALF`), each piece's blow-up lies in a convex polar cone (`FS111-M-POLAR`), and on maps without cusps no colour occupies two sectors
   (`FS111-W-NOREP`). Is the change absorbed by moving the junction, or passed into the junction's other ladders?
3. **(F1) for irregular MUA sets:** does every component of the interior of a MUA set's density set lie inside or outside each unit disc about its
   support? (M4's reading: an irregular class is the only junction-free escape from the cut; a proof of (F1) in general removes it.)

## Bearing on the answer

**None alone; it is a colour-generic rung of route M, smaller than the answer.** Its positive answer is the local form of MUA-FIN in partitions, which
both top rungs of route M need: at five, the cover statement REG-J′-C₅ (which, given the held "maps need six", FS106-AE-MAP6, is equivalent to
`χ_m⁰(ℝ²) ≥ 6` — a reformulation, `FS111-VM2-EQ5`), and at six the regularity step REG-A₆ (equivalent to seven given FS-114's NO, `FS111-C-REG-EQ`). Its
negative answer — a pinch no local move removes — would say that route M's finiteness must be global, not local. It decides no value, and it moves no
value by itself. (What it is not: a step toward six or seven on its own. Its honesty rule is FS-111's: state every result colour-generically, and say
where a colour count would enter — M4 reads that it can enter only at the junction, which is this stub's second question.)

**At FS-121's close (2026-10-03, FS121-Z1).** Every measurable idomatic partition (fall colouring) is honest saturated (FS121-D3-FALLSAT, held), so
C121-REGJ restricts to fall colourings, and **a fall colouring with a non-locally-finite singular set — a Cantor pinch of FS111-M3-HC's type — refutes
C121-REGJ** at any `k` (FS121-D4-FALL, one mind). This stub's pinch question now bears on FS-127 (lateral extent): a pinch no move removes would be
FS-127's counterexample.

**At FS-116's close (2026-10-03, FS116-Z2).** FS116-S1-RUNG (held, Siamese pairs allowed): a saturated straight edge's first rung tile reaches no farther than 1 from
the rung's points (FS116-Y1-STRIPCEIL is its case at `r(120°)`); at a four-colour vertex the rung collides with the ring's contact inside radius 2
(FS116-S1's recognition; FS116-S1-QF). A rung is a ladder's first step, so the saturated cross is this stub's pinch read at a junction of four colours, on a
fragment rather than a measurable fall colouring; FS-125 carries it.

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).* FS111-M2-INT's GAP ("the same for the interior of
the support F of a set with null unit pairs (a GAP under the topological reading of 'regular', VM2 (O2))") is open, and FS111-M3-IRREG does not refute
it: the set maximality must add is nowhere dense, so it adds nothing to the interior of the support (`plans/FS129-SR3-audit.md` § 4.1); its maximal-set
form is this stub's question 3. The map step at five's MUA-FIN is this stub's (`plans/FS129-OR1-audit.md` § J10), so FS129-OR1-TOP5 — with REG-J′₅,
the honest existence form of C-SAT-T at five holds if and only if `χ_m⁰(ℝ²) ≥ 6` — bears on its rungs, as does FS129-SR2-HULLSET (FS111-C-HULL for one
measurable set with null unit pairs, so FS111-M-PINCH and FS111-M-HULL2 need no colouring for that step; `plans/FS129-SR2-audit.md` § 2.1, row 24). No
held result closes the pinch (`plans/FS129-OR1-audit.md` § J11).

## The question, the cover route at five (Poros, 2026-10-03)

*FS129-P1 adds the cover route at five's other rung to this stub (`plans/POROS-2026-10-03-fs129-rerank.md` § 3.1; FS-129 inventory item 26).*
**4. MUA-REG-P**: can a maximal cover be modified into one with regular classes (FS111-REG-JP-C5's first rung; MUA-REG-U is false, FS111-M3-IRREG)? With
MUA-FIN (this stub's) it is the cover route at five (FS111-M2-REDUCE-C), which with held FS106-AE-MAP6 gives `χ(ℝ²) ≥ 6` given MR and needs no NO
(FS129-OR1 § J10). **First**, card 2 of that record, an invention-signal item for Ephodos: does either rung have a tight `k`-colouring, `k ≥ 7`, that
defeats every local modification, as FS121-O1-ABOVE7 defeats the top colour? If neither has one, six given MR reduces to these two colour-generic rungs and
this stub rises to FS-104's rank; if one has one, that colouring is the product — for MUA-FIN it is question 1's pinched partition — and the cover route at
five is a restatement (FS111-VM2-EQ5), its reason recorded.

## The room and the prior art

The unit-distance graph's **fall colourings** (Dunbar et al. 2000, Zbl 0962.05020, finite graphs; held under FS-67) and measurable **maximal independent
sets** (descriptive combinatorics); **mathematical morphology** — closing and opening by discs (Matheron, Serra; classical, not held, not read), which is
the identity M4-CUT's downward half uses; the planar regularity of `r`-convex and positive-reach boundaries (`[RatajZajicek2017]`, `[RatajZajicek2025]`)
and the two-sided rolling ball (`[Walther1999]`, listing seen); the shape (never the theorems) of the variational paradigm — junctions of minimising
planar clusters (`[Morgan1994]`, review read): FS-111's classes minimise nothing (FS111-P §PA, PA-6). zbMATH at FS-111: *"unit distance & maximal &
measurable"* 1 hit, *"distance & measurable & maximal independent"* 0, *"independent dominating & (measurable | Borel)"* 0 — maximal unit-avoiding sets by
inclusion and measurable fall colourings of the plane not found in print.

## Registered expectations (instruments for G21, never caps — `CLAUDE.md` § Counter-priors rule 2)

- Question 1 decided either way (a partition with a pinched class built by formula and checked exactly, or excluded by derivation), one mind: **0.3**.
- The junction's absorption (question 2) decided at one mind: **0.15**.
- (F1) for irregular MUA sets decided: **0.25**.
- Both outcomes reachable for each: a formula object refutes "none exists"; a derivation refutes the construction's possibility.

## Failure clauses

- A construction that is only sampled, not checked exactly on the infinite periodic object, decides nothing (G21: the generator image and the check
  must be the object the record specifies — FS111-M2's DISCK7 tool built a hexagon rotated 30° from its record's lattice, `FS111-M2-DISCK7-AS-PLACED`).
- A result stated at `k = 5` alone, or read as progress toward six, is misfiled: every statement here is colour-generic (G24; the ruling at FS-111's
  inventory item 31).
- The downward half of M4-CUT is conditional; a proof that uses it names its hypothesis.

## Deliverables

Each result as an entry in the Ephodos grammar in the milestone's derivation file; exact checkers with planted faults (run from `plans/` — FS111-M3's and
FS111-M4's tools write to root-relative paths and crash elsewhere after "ALL PASS", `plans/FS111-C-close.md` § Stage 3); a picture of a ladder ending at a
junction, if one is built (the Proof Atlas's node for this stub).

## Provisional bearings (replaced by the re-grokking at the opening)

G84 and G85 (drafted at FS-111's close: contact pins interfaces; saturated interfaces have integer radii), G83 (four-colour vertices: where M4 reads the
count as entering), G82 (stability: a regular refutation, a wild limit), G79 (the example invariant: what every fall colouring carries at a junction), G54
(fall colourings — the entry FS-111's §G walked as silent and should have read; `plans/FS111-C-close.md` §4.1), G24/G60 (no count one class at a time).
Rows 131–136. Stubs: FS-121 (its top rungs need this), FS-115 (large-radius accumulation, the other obstruction to finiteness on the honest route),
FS-114.

*Would have searched here:* a local search over periodic partitions for a pinched class — post-ban, as a dial on question 1, never as its answer.

*At FS-129's audit (FS129-Z2, 2026-10-03):* FS129-SR2-HULLSET,
-CLOSURE (FS106-DIAM (iii), FS111-V0-CLOSE and FS116-V5-NE1's first clause, one lemma), FS129-OR1-TOP5.
