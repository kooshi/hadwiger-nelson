# FS-128 — the top colour, at six: can the top colour of a Grundy six-colouring be bound, and does NO-PAR hold under Condition 5? (stub)

> 2026-10-07: the five-colour half is answered by citation (no measurable five-colouring exists, `[OAIMath2026]` Thm 1.4; row 154's two sides are both true). TOP₆ stands, with no 'given MR'. Whether a saturated normal form is on the road at all waits on FS-132's cards 1 and 2.

*Minted 2026-10-03 by FS-121's close (FS121-Z1, stage 5). It holds FS-121's two rungs that are at six by nature: honest saturation's upper colour
(TOP₆, the honest route) and the cover route's own NO (C121-NOPAR-C5), parked behind FS-116 (inventory items 51, 63). **Solver column: in-ban.**
Read first: `plans/FS121-derivation.md` rounds 2–3; `plans/FS121-D3-proof.md` §§ 3.1–3.5; `plans/FS121-C1-proof.md` §§ 1.2, 2.5–2.6.*

## The question, in plain language

Honesty is free: every a.e.-proper `k`-colouring becomes, without raising any point's colour index, a measurable Grundy colouring, in which every
boundary point is bound (has a point at distance exactly 1) for every colour present there except the largest (FS121-D3-GRUNDY, held). **TOP₆:** can
some Grundy six-colouring, obtained from a tight one, have its largest colour bound too? That is honest saturation at six (C121-SAT6). On the cover
route, the map such a colouring would be is in the class `𝒫_6` (FS121-C1-GMAP, held), and **C121-NOPAR** says `𝒫_6` is empty; its part under Condition 5
(every boundary meets every unit circle in finitely many points) is **C121-NOPAR-C5**, where row 134's chain stops at the vertex data and at N4-FIN's
strictness, which smooth horns lack (FS121-C1-FLAT, held).

## What FS-121 established

- C121-SAT6 is implied by seven and its failure is `χ(ℝ²) ≤ 6` with no MR; given a NO for every honest saturated colouring with at most six colours it
  *is* the answer (FS121-D3-EQ, one mind). TOP₆ implies it; three attempts stalled (variational, idomatic, re-maximising), and the idomatic reading is
  strictly stronger (FS121-D3-SWAP1D).
- The cover route in Grundy form: G-FIN₆ ∧ C121-NOPAR ⟹ seven (FS121-C1-GMAP, held); C121-NOPAR contains the honest route's saturated segment-and-arc NO
  (FS121-C1-SAT, held), so it contains FS-116's NO-SAT (`data/fs116/claims.md` § 4; C1's commentary, one mind).

## Bearing on the answer

**At six, and next to the answer.** TOP₆ is not a rung below the answer once a NO for honest saturated colourings is held (FS121-D3-EQ); its value is
a procedure that spends six. NOPAR-C5 is a new NO for a class of maps, smaller than the answer, decided at six by nature; it un-parks the cover route
when FS-116's NO-SAT lands or a jet argument at N4 appears. Kooshi may overturn the parking.

**At FS-116's close (2026-10-03, FS116-Z2).** FS-116 did not land NO-SAT, so the parking stands. What it holds in the saturated class: every edge at a four-colour vertex
of a saturated fragment is split (a unit arc about a ring point carrying both side colours) or tangent (FS116-O1-SATPIN, held); the straight right-angled
cross whose ring carries no (Q) arc dies at `R = 2` in the non-Siamese class (FS116-S1-QF — two derivations, the second told the verdict, not held; a blind
second mind owed). NO-SAT is FS-125's (`plans/STUB-saturated-local.md`).

## Owed second minds

FS121-D3-EQ, -SWAP1D; FS121-NOPAR and -NOPAR-C5's GAP locations; C1's containment commentary.

## Registered expectations (provisional)

- NOPAR-C5 decided at one mind: 0.15. TOP₆ reduced to a statement strictly smaller than C121-SAT6: 0.2.

## Failure clauses

- A sentence reading TOP₆ or G-FIN₆ as progress toward seven without its NO is a statement defect (the answer restated).
- A proof of NOPAR-C5 that reads only germs at the chain's points fails on FS121-C1-FLAT.

## Provisional bearings

G89 (drafted: honesty is free, binding the top colour is the content), G13 (binding is coverage; FS-121's §G miss), G82, G24/G60. Stubs: FS-116,
FS-126, FS-127; FS-104 (`χ_CP(ℝ²)` at six).

*Since FS-132 (FS132-Z2, 2026-10-07) — with FS-127, this stub now carries the existence question FS-132 gave up.* By Kooshi's
word of 2026-10-07 (`data/external/EXT-OAI1-request.md` § Kooshi's sixth word; the coordinator's reading there: it "stays with
FS-127 and FS-128"; `plans/FS132-close-inventory.md` item 32 (a)), whether every weak measurable six-colouring has a point with
usable data on its unit circle is no longer FS-132's question. How the head's line of 2026-10-07 ("Whether a saturated normal
form is on the road at all waits on FS-132's cards 1 and 2") resolved: **for the exclusions no normal form is read** — on the
side where no boundary is a unit arc about a ring point they run for every weak measurable colouring (`plans/FS132-derivation.md` § 12) — **and for
existence the normal form is undecided.** What FS-132 found about honesty as that normal form (its §§ 7–8; [hand], one mind):

- the Grundy test's first clause tests nothing: for no order of the labels is the hexagonal seven-colouring at circumradius
  2/5, or either slack colouring planted in it, a Grundy colouring (C132-GRUNDY7-NOT, whose *not claimed* line reads "that this
  tells the slack colourings from the hexagonal one — it does not, and that is the finding");
- for a suitable order *some* output of the Grundy construction is one label on the whole slack ball (C132-GRUNDY7-LOCAL); "the
  Grundy-ization" is not one output, so C132-GRUNDY7's second clause is withdrawn as posed, and its two readings are open —
  (G1) some output, (G2) every honest seven-colouring (`plans/FS132-E5-derivation.md` § What the second clause is, and what is
  left of it);
- the statement honesty would have to supply: on the unit circle about a point with a witnessed triangle, the three outside
  labels change finitely often (C132-RING-TAME's first clause, a stall: "for three labels on a strip no rigidity is held, by the
  release or here"; false wherever local slack exists along the strip, G95). FS132-E2's form "three labels on a strip" was
  declined as a stub by the asking lane on the night, pending C132-GRUNDY7 (`plans/POROS-2026-10-07-fs132-night.md` § The
  debts), which did not decide the class; it is placed here and at FS-125. FS132-E5's calibration for it, a reading with its
  killing test: a Grundy seven-colouring with a banded pair of facing unit arcs, or its exclusion (leaning on G84).

Grokkings: G89, G95, G84.

## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)

question: is-top-six-a-coverage-question
  evidence: `plans/FS121-Z1-close.md` § 4.1: G13 "should have borne and was not used"; "TOP₆ (binding the top colour) is a coverage question about the
    circles of the top colour's boundary points. D3's three attempts (§§ 3.2–3.4) worked by moves and selections and never asked the coverage question G13
    names"; `plans/FS116-Z2-close.md` § 2.1: G13 "paid, unnamed" in FS116-V6-TIP; FS121-O1-ABOVE7 (one mind): at `k = 7` the tight hexagonal colouring
    lies below no honest saturated one, so binding the top colour must spend six
  expected: that TOP₆'s three stalls (variational, idomatic, re-maximising) had exhausted its routes
  ask: In a Grundy six-colouring, is the top colour's binding at a boundary point the failure of a coverage — that point's unit circle covered by the five lower colours — so that G13's fan ladder at level five decides TOP₆?
  if it is: FS-128 opens on coverage at the top colour's boundary circles, with the kernel's `fan_iff_coverage` as the finite model, and TOP₆ gets a named step smaller than C121-SAT6
  if it is not: the step where coverage cannot spend six is named; TOP₆ stays the answer restated given NO-SAT, and FS-128's cover-route rung (NOPAR-C5) is its only smaller question
  answered by: derivation — Ephodos, FS-128's opening, reading FS121-D3 §§ 3.2–3.4 against G13
  cost: under a round
  rank: 4

*Dated correction (Poros, FS129-P1, 2026-10-03; the card above stands as written).* The ask's "that point's unit circle covered by the five lower
colours" is exact only where `max P(x)` is the sixth colour. At a boundary point `x` with `m = max P(x) < 6`, colours above `m` may lie on `T₁(x)`, being
absent only near `x`; so `m` is free at `x` iff `T₁(x)` misses `F_m`, that is, iff `T₁(x)` is covered by the other five colours, higher ones included
(`plans/FS129-OA1-audit.md` § 2.1; FS-129 inventory item 43). The card was answered on its "if it is not" branch, as a reading with three receipts: coverage at
the top colour restates TOP₆ and cannot spend six (OA1 § 2.1).

## The question, at five as well (Poros, 2026-10-03)

*FS129-P1 re-aims this stub to carry the map step at five's top colour (`plans/POROS-2026-10-03-fs129-rerank.md` § 3.1; FS-129 inventory item 26).*
**TOP₅**: can the largest colour of a Grundy five-colouring obtained from a tight one be bound too? Given REG-J′₅ (FS-127 at five), the honest existence
form at five holds if and only if `χ_m⁰(ℝ²) ≥ 6` (FS129-OR1-TOP5, row 154), and at five no NO is needed: FS106-AE-MAP6 excludes every a.e.-proper
map-type five-colouring outright (FS129-OR1 § J10, note 3). The obstacle is the one TOP₆ names: regularity where the top colour is unbound, FS111-M-PINCH
needing both colours bound. Binding spends the colour count (FS121-O1-ABOVE7), so a proof of TOP₅ must read five. **Bearing**: decisive at five both ways
given REG-J′₅ — a binding gives `χ(ℝ²) ≥ 6` given MR, and a tight five-colouring whose top colour no modification binds gives `χ(ℝ²) ≤ 5` with no MR — which
is FS-104's question in route M's Grundy form.
