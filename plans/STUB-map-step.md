# FS-121 — the map step: can a tight colouring of the plane be replaced by a map — at five colours by any map, at six by one bounded by segments and circular arcs? (stub)

*Minted 2026-09-28 by the close job FS111-C at FS-111's close, merging the planner's draft `data/fs111/fs111-p/STUB-DRAFT-map-step.md` with what rounds 1–4
found (`plans/FS111-close-inventory.md` items 5, 17, 27, 28; `plans/FS111-C-close.md` § Stage 5). FS-111's successor on route M's top rung; its siblings
are FS-120 (the pinch at a junction, the colour-generic rung this one needs) and FS-122 (the forced pair, route R). **Solver column: in-ban** —
derivation and reading. Written for a session with no memory of FS-111: read `CLAUDE.md` § The aim (links 5–6) and § Counter-priors first, then
`plans/FS111-derivation.md` in full, `plans/FS111-M-regularity.md` §5, `plans/FS111-M2-regularity.md` §4, and `LEDGER.md` rows 130–136.*

## The question

**The frame (FS-111's card 1, two minds, one blind).** Seven, `χ_m⁰(ℝ²) ≥ 7` (so `χ(ℝ²) = 7` given MR), is the map NO — row 134 with FS-114's NO — made
uniform in the complexity bound (`FS111-C1-UNIF`); the map NO alone bounds holes at each complexity only (`FS111-C1-PW`). So the map NO reaches seven only
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

## Bearing on the answer

**Decisive at its top, and at its top the answer restated.** At six: the map step with FS-114's NO is `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR; its
failure is a tight six-colouring, `χ_m⁰(ℝ²) ≤ 6`, so `χ(ℝ²) ≤ 6` with no MR (link 2). At five: the map step with AE-MAP6 is `χ_m⁰(ℝ²) ≥ 6`, so
`χ(ℝ²) ≥ 6` given MR — FS-104's statement by another route; its failure is `χ(ℝ²) = 5` with no MR. Each top rung is equivalent to its conclusion given its
NO, so this stub's progress is measured by its **smaller rungs**: NO-PAR (a new NO, genuinely smaller than seven: a NO for a class of maps), interface
maximality, MUA-REG-P, and FS-120's finiteness rung. Rank it by the NO it would add, not by the equivalence. The same equivalence holds of FS-116's NO given this stub's top rung: route M's two halves are each necessary for seven and each equivalent to it given the other (R1, F2).

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

G84, G85 (drafted at FS-111's close), G82, G83, G22 (the target class contains arcs), G24/G60, G21; rows 130–136 (row 134's N4 step above all). Stubs:
FS-120 (its finiteness rung), FS-114 (the NO), FS-115 (LRA), FS-104 (the five-colour top rung is its statement given MR), FS-108 (Townsend's (c) under
AE-MAP6), FS-113/FS-101 (the measurable chain in Lean, which the route-M lemmas queue behind).

*Would have searched here:* a saturated six-colouring or a chain of radius 2 — out (by W-NEG such an object would be `χ_m⁰ ≤ 6`, and search is banned
to 2026-10-01).
