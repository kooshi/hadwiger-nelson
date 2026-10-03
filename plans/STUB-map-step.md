# FS-121 — the map step: can a tight colouring of the plane be replaced by a map — at five colours by any map, at six by one bounded by segments and circular arcs? (stub)

*Minted 2026-09-28 by the close job FS111-C at FS-111's close, merging the planner's draft `data/fs111/fs111-p/STUB-DRAFT-map-step.md` with what rounds 1–4
found (`plans/FS111-close-inventory.md` items 5, 17, 27, 28; `plans/FS111-C-close.md` § Stage 5). FS-111's successor on route M's top rung; its siblings
are FS-120 (the pinch at a junction, the colour-generic rung this one needs) and FS-122 (the forced pair, route R). **Solver column: in-ban** —
derivation and reading. Written for a session with no memory of FS-111: read `CLAUDE.md` § The aim (links 5–6) and § Counter-priors first, then
`plans/FS111-derivation.md` in full, `plans/FS111-M-regularity.md` §5, `plans/FS111-M2-regularity.md` §4, and `LEDGER.md` rows 130–136.*

## The question

**The frame (FS-111's card 1, two minds, one blind).** Seven, `χ_m⁰(ℝ²) ≥ 7` (so `χ(ℝ²) = 7` given MR), is the map NO's **hole bound**
made uniform in the complexity bound (`FS111-C1-UNIF`: `1 − lim µ₆(ε) = inf_K δ₀(K)`); the map NO — row 134 with FS-114's NO — alone bounds holes at each
complexity only (`FS111-C1-PW`). *(Corrected by Poros, FS116-P1, 2026-09-29: this sentence read "is the map NO … made uniform in the complexity bound",
which says FS-116's uniform radius is seven — an open question; R1's F9.)* So the map NO reaches seven only
through a **third statement**, and on route M that statement is the **map step** REG: *if a tight a.e.-proper `k`-colouring of the plane exists, a map
carries one* — at `k = 5` a map-type colouring (S–V Conditions 2–4; REG-I₅), at `k = 6` a map bounded by segments and circular arcs (REG-A₆). With the held
"maps need six" (FS106-AE-MAP6, one mind per link) REG-I₅ gives `χ_m⁰(ℝ²) ≥ 6`; with FS-114's NO, REG-A₆ gives seven (`FS111-C-SIX-M`, `FS111-C-SEVEN-M`).

**Honesty (two minds each).** Given the NO at `k`, the map step at `k` is **equivalent to the answer at `k`** (`FS111-C-REG-EQ`); in FS-111's cover form at
five it is equivalent to `χ_m⁰(ℝ²) ≥ 6` (`FS111-VM2-EQ5`). It is the answer stated where a proof would live. Its value is its method, and its lower rungs
are genuinely smaller.

**What FS-111 proved toward it** (entries in `plans/FS111-derivation.md`):
- *The contact structure.* In a saturated colouring every two-colour interface point is pinned between unit circles: a unit arc whose centre carries
  both colours, or a `C^{1,1}` curve with `|κ| ≤ 1` between two tangent unit discs, no partner density needed (`FS111-M-PINCH`, `FS111-M-C11`, three
  minds). The Reuleaux 4 + 3 seven-colouring (de Grey, 2018) is saturated and a maximal cover (`FS111-M-R7`, `FS111-VMW-R7-MAX`).
- *On covers.* A maximal cover is `k` MUA sets (`FS111-M2-COV`); regular classes satisfy the shadow identity and are carved by their own unit circles
  (`FS111-M2-FIX`, `FS111-M2-HULLC`, two minds). **At five no honest saturation is needed**: a maximal five-cover with regular classes whose boundaries form a
  locally finite plane graph (finitely many Jordan arcs per bounded set, meeting only at endpoints — REG-J′-C₅) gives `χ_m⁰(ℝ²) ≥ 6` through AE-MAP6
  (`FS111-M2-REDUCE-C`, two minds) — a reformulation, not progress.
- *At six, integer radii.* Off a locally finite singular set Σ with finitely many interface arcs at each point (REG-J′), saturated interfaces have integer
  radii of curvature and are chains of segments and arcs (`FS111-M2-INTRAD`, two minds on its core); so REG-A₆ follows from REG-J′₆ and the absence of
  **large-radius accumulation (LRA) — FS-115's stuck ray in another form** (`FS111-M2-REDUCE-A`).
- *What fails.* Selecting from a cover is no route to honest saturation (`FS111-M2-NOSEL`, DISC7's lens); local fills deadlock (`FS111-M-DEADLOCK`); on
  covers class boundaries need not be arcs (`FS111-M2-DISCK7`, a constant-width body, corrected orientation), so the cover route at six needs a NO larger
  than FS-114's; tight block structure fails universally at seven (`FS111-W-DECO-B`); MUA-FIN-U and MUA-REG-U are false (`FS111-M3-FIN-U`,
  `FS111-M3-IRREG`).

**The questions, by route and colour count:**
1. **At six, the cover route: NO-PAR** — no map whose boundaries lie on unit parallels (outer and far) of their own classes' components carries an
   a.e.-proper six-colouring. Row 134's chain "uses no complexity bound", and its N4 step (curvature monotonicity along the shadow map) is where the
   extension would be decided (V0 §2.4 item 7; M §5.2). With MUA-FIN at six (FS-120's rung), NO-PAR gives seven by the cover route.
2. **At six, the honest route: interface-maximal six-colourings** — does some tight six-colouring admit a modification that is saturated (no class
   extends across an interface) with locally finite Σ (REG-J′₆)? Its seven-colour inhabitant is R7; its known obstruction the lens. With ¬LRA (shared
   with FS-115) and FS-114's NO, this gives seven.
3. **At five, the cover route's two rungs:** MUA-REG-P (a maximal cover modified into one with regular classes; the universal form is false) and MUA-FIN
   with its endpoints clause (FS-120's local question is its partition form).
4. *Named, not first:* honest C-SAT-T at five and six (unneeded at five; one of the honest route's three at six); a saturated colouring with a
   bichromatic vertex of degree ≥ 4 (it would make C-HULL-REG as stated FALSE; excluded on maps without cusps by `FS111-W-NOREP`); Cohen–Mani's
   Question 5.1 (one class: *"Does there exist a set A with block structure and δ(A) = m 1 ?"*, arXiv:2407.05071 §5), a calibration — a positive answer
   there decides nothing about six.

## The question (Poros, 2026-09-29)

*Posed by Poros, job FS116-P1, beside FS-116's (`plans/STUB-local-exclusion.md`), so that one asker keeps the two halves of route M coherent. The
record is `plans/POROS-2026-09-28-fs116-question.md`, stage 4. Ephodos's §IQ quotes the two forms below verbatim.*

### The card

```
question: do-ladders-end-on-q-rings
  evidence: FS111-M2-INTRAD (two minds on its core): off Σ, radii "drop by exactly 1 toward the centre and stop at 1"; FS111-M-PINCH (three minds):
    a saturated interface point lies on "a unit arc whose centre carries both colours" or between two tangent unit discs; FS112-N3-NOBOTH (two
    minds, one blind): "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour"; FS111-W-NOREP (one mind):
    "at a cone vertex of a saturated map without cusps, no colour occupies two sectors"; FS-116's structural form (plans/STUB-local-exclusion.md)
  expected: that this stub's ladders and FS-116's four-colour vertices were separate objects, as the two stubs treated them
  ask: In an honestly saturated six-map without cusps, does every curved interface's ladder of unit parallels end at a (Q) arc about a vertex of at
    least four colours — so that FS-116's rings are where this stub's ladders end?
  if they do: the two milestones share one object; the honest route's remaining rungs are the straight ladders' ends (FS-120), ¬LRA (FS-115) and
    Σ's local finiteness, and FS-116's card what-do-q-rings-force is this stub's first structural step too — the two openings run it once
  if a step fails: the failing link (a cusp, a repeated colour, a ladder stopping above radius 1) names what separates a saturated map's interfaces
    from FS-116's rings, and this milestone opens on that link
  answered by: derivation — Ephodos at FS-121's opening, a check of a four-link composition
  cost: under an hour
  hunch: they do, off cusps (0.7)
  falsifier: a cusp-free honestly saturated fragment by formula with a curved interface whose ladder's last rung is a unit arc about a point of
    at most three colours
  rank: 1
```

**The joint with FS-116** (R1's card 2, re-posed; the record's § 2.4). The honest route hands the NO an **honestly saturated** map
(`FS111-M2-REDUCE-A`: REG-A_k "in an honest saturated k-colouring"). So the honest route needs FS-116's NO only in that class, and FS-116's rank-1 card
asks what saturation pins at a four-colour vertex. The cover route needs NO-PAR instead, a NO for a class whose boundaries need not be arcs, larger
than FS-114's (question 1 below; `FS111-M2-DISCK7`). The complexity half of card 2 dissolves if FS-116's card `the-yes-needs-no-map` holds: FS-116's
radius is then uniform whatever this milestone outputs, and a locally finite map is all it must produce, which M2-INTRAD's form already gives.
**Recommendation** (Kooshi's or the plan's call):
- *The choice:* open on the honest route.
- *The alternative weighed:* the cover route (NO-PAR, with MUA-FIN).
- *Why:* the honest route's NO is the one FS-116 is posing, and the cover route's NO-PAR is a second, larger NO with no one on it.
- *Confidence:* 0.65. The fact that would change it: FS-116's rank-1 card finding that saturation pins nothing new at a four-colour vertex, and NO-PAR
  following from row 134's chain at one named step (question 1's "0.5").
- *Default:* the honest route first.

### Existence form

**Is there a saturated colouring of the plane — with any number of colours — whose singular set is not locally finite, or whose interface radii
accumulate?**

At `k ≥ 7` an inhabitant would refute the universal regularity forms (REG-J′, ¬LRA); the controls R7, SQ9 and HEX9 inhabit their negation. At `k = 6`
an inhabitant would already be `χ_m⁰(ℝ²) ≤ 6` (`FS111-W-NEG`). A NO at every `k`, with honest saturation (question 2 below), gives REG-A₆ by
`FS111-M2-REDUCE-A`, and with FS-116's NO in the saturated class it gives seven.

### Structural form

**In every saturated colouring of the plane, whatever the number of colours, where can the ladder of unit parallels of an interface end — on a unit
arc about a point of at least four colours, at a junction, at the singular set, or nowhere — and what does every end carry that bounds how many ends
meet a bounded set?**

*Why this is the structural form.* REG-J′ (the singular set locally finite, finitely many interface arcs at each point) and ¬LRA (no radius
accumulation) are both statements about where ladders end and how many ends a bounded set holds. Neither can be answered without an invariant carried
at every ladder end. Curved ladders descend to radius 1 (`FS111-M2-INTRAD`), and the card asks whether they then end on FS-116's (Q) rings. Straight
ladders are FS-120's pinch (`FS111-M4-LADDER`, `M4-CUT`). The form is colour-generic, with inhabitants at `k = 7` (R7) and `k = 9` (SQ9, HEX9), so it
is not vacuous under seven, and at six it names the rung that is not the answer restated.

## Bearing on the answer

*Rewritten by Poros (FS116-P1, 2026-09-29).*

**Decisive at its top, and at its top the answer restated.**
- *At six:* the map step with FS-116's NO gives `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR. On the honest route the NO needed is FS-116's in the honestly
  saturated class only (`FS111-M2-REDUCE-A`). Its failure is a tight six-colouring, `χ_m⁰(ℝ²) ≤ 6`, so `χ(ℝ²) ≤ 6` with no MR (link 2).
- *At five:* the map step with AE-MAP6 gives `χ_m⁰(ℝ²) ≥ 6`, so `χ(ℝ²) ≥ 6` given MR — FS-104's statement by another route. Its failure is
  `χ(ℝ²) = 5` with no MR.

Each top rung is equivalent to its conclusion given its NO (`FS111-C-REG-EQ`). So this stub's progress is measured by its **colour-generic rungs**:
- the regularity of every saturated colouring (the existence form: a locally finite singular set, no radius accumulation), which is true or false at
  `k ≥ 7` about real objects;
- honest saturation;
- NO-PAR (a new NO for a class of maps, but larger than FS-116's);
- FS-120's finiteness rung.

Rank it by the rungs it would add, not by the equivalence. The same equivalence holds of FS-116's NO given this stub's top rung: route M's two halves
are each necessary for seven and each equivalent to it given the other (R1, F2). If FS-116's card `the-yes-needs-no-map` holds, each half's failure is
`χ(ℝ²) ≤ 6` on its own. **The two halves may share one object:** this stub's curved ladders end, off cusps, on FS-116's (Q) rings. That is § The card
above, unchecked.

**At FS-121's close (2026-10-03, FS121-Z1; `plans/FS121-Z1-close.md` § 2.6, `plans/FS121-derivation.md`).** Nothing moved a value. Held (two
minds): every curved ladder ends inward at a (Q) or (R2) arc and never outward; periodic honest classes are segments and split (Q) arcs; honesty is
free (Grundy colourings); idomatic partitions are saturated; no cocompactly symmetric colouring has LRA; REG-J′ holds on grids with countable
breakpoints; the five cover-route lemmas. Open (one mind each): C121-R2-FOUR, -CURVED and -NOLRA, which are one question, curved tangent interfaces
(FS-126); C121-REGJ at LAT (FS-127); C121-SAT6 at TOP₆ and C121-NOPAR-C5 (FS-128). **A correction to question 1 (2026-10-03):** NO-PAR read on the map
a maximal cover yields is the wrong target (FS121-C1-COVMAP, held: DISC7's merged map is in no `𝒫_7`); read on Grundy partitions it is right, one-sided,
with G-FIN₆ in place of MUA-FIN (FS121-C1-GMAP), and it contains the honest route's NO (FS121-C1-SAT). Honest saturation at six is the answer given a NO
for honest saturated colourings (FS121-D3-EQ, one mind).

## Registered expectations (instruments, never caps)

- NO-PAR decided at one mind within the milestone: **0.1**; reduced to a named step of row 134's chain: **0.5**.
- Interface-maximal six-colourings reduced to a named step: **0.4**.
- A top rung landed: **0.02** (it is the answer).

## Failure clauses

- A sentence reading a reformulation as progress (REG-J′-C₅ is `χ_m⁰ ≥ 6` restated) is a statement defect.
- A rung stated at six only, with no seven-colour inhabitant or a statement of where six is spent, is misfiled (the claim list's vacuity rule; W-NEG: a
  `k = 7` inhabitant tests only universal forms and procedures).
- Every quotation of a rung carries its clauses in full: FS-111's briefs dropped REG-J′'s "finitely many interface arcs at each point" twice
  (`plans/FS111-close-inventory.md` items 24, 27).

## Provisional bearings (replaced by the re-grokking at the opening)

*Rewritten by Poros (FS116-P1, 2026-09-29).*
- G84, G85 — contact and integer radii: the ladder.
- G83 — the four-colour vertex, where curved ladders may end on (Q) arcs; § The card.
- G82 — a limit of near-colourings is a colouring.
- G22 — the target class contains arcs.
- G24/G60 — integrality.
- G21 — every control here is tight at seven or nine, not six (W-NEG); the strip is unsaturated at its midline, so it is no control for saturation.
- G87 — the invention signal.
- Rows 130–141: row 134's N4 step; row 140's M-PINCH and M2-INTRAD; row 141's ladder.
- Stubs:
  - FS-116 — the NO, in the saturated class for the honest route, whose rank-1 card is this stub's joint;
  - FS-120 — the straight ladders' ends, the pinch at a junction;
  - FS-115 — LRA;
  - FS-104 — the five-colour top rung is its statement given MR;
  - FS-108 — Townsend's (c) under AE-MAP6;
  - FS-113/FS-101 — the measurable chain in Lean, which the route-M lemmas queue behind.

*Would have searched here:* a saturated six-colouring or a chain of radius 2 — out (by W-NEG such an object would be `χ_m⁰ ≤ 6`, and search is banned
to 2026-10-01).
