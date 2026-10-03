# FS-129 — the demand list, judged half (Poros, job FS129-Q1, 2026-10-03)

*Written by Poros, the asker, for the pass-1 readers FS129-OA1 (lane A: held results through FS-103) and FS129-OR1 (lane R: FS-104 on). Built
by `data/fs129/q1/build_demand.py` from `data/fs129/q1/demand-template.md`: every quotation below is copied by the script from the line range
named beside it and checked as an exact substring of its source (standing rule 3). Record: `plans/POROS-2026-10-03-fs129-card.md`.*

## How to read this list

**What it is.** The open steps that stand between this project and the answer, ranked by their bearing on it, each stated as a step to close.
Work them in this order. For each step, ask which held result — in your era, under any name — closes it, shortens it, or reduces it to another
step, and record a null where none does, with what you read.

**Before you scan any statements for a step, write one line: what kind of input must every argument that closes it read?** (Points and
distances; contact at distance exactly 1; coverage of a unit circle; a count; a density or measure; a spectrum or correlation; an invariant of a
colouring of a circle or a lattice; a modification lemma; compactness or symmetry.) Then check that kind against the held no-gos that exclude
kinds (listed in § 2), and look for held results that deliver an admissible kind. This is FS-129's question card (`plans/STUB-cross-application-audit.md`
§ The question). Each step below carries my reading of its kind, as a hunch; replace it where you read better.

**The ranking** (mine; Kooshi may override): by bearing on the answer (`CLAUDE.md` § The aim; § Counter-priors rule 1), never by difficulty.
Within that, a step whose failure is itself an answer-level object (a family of valid fragments on discs of every radius is `χ(ℝ²) ≤ 6` with no
MR, FS116-O1-YESLIM) ranks above one whose failure is only a reformulation; a step shared by two routes or two bounds ranks above one that serves
one; and a step at a deep root carries its chain (Kooshi, 2026-10-03, `plans/FS129-cross-application-audit.md` § 1: *"not only are "hubs"
important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot"*).

**Labels.** *Step*: verbatim from its stub, with the address; where no stub states it, "Poros's words". *Read first*: my hunch about which held
results to open first, tagged by lane (A or R); hunches are scored at FS-129's close, never taken as findings. *Absorbs*: the entries of the
Clerk's mechanical list (`data/fs129/index/open-steps.md` § 1) that the step covers; § 4 places all thirty.

## 1. Words that mean two things here

*Readers who have not loaded the grokkings: these homonyms are where a scan by word will match the wrong result, or miss the right one (G49:
in-house names hid prior art, and can hide a result from its own neighbours).*

- **tight.** (i) *Hoffman-tight*, `λ_min = −d/(k−1)` (G54): every `k`-colouring of such a target is balanced and gap-free. (ii) A *tight* colouring
  or *tight six-map* in the regularity era: a.e.-proper with no slack in the distance (rows 131, 133). (iii) Csernák's "tight" is a fall
  colouring (G54). Sense (i) makes every colouring gap-free; sense (ii) does not — the tight hexagonal seven-colouring lies below no honest
  saturated one (FS121-O1-ABOVE7).
- **gap, gap-free, fall, saturated, idomatic, Grundy-bound.** One family. A *gap* (row 66, G13, G68) is a vertex whose closed neighbourhood misses a
  colour; *gap-free* = *fall colouring* = *idomatic partition* (a partition into independent dominating sets). In the plane: *saturated* (G84) —
  every boundary point at distance exactly 1 from each colour present there; a *regular maximal partition* is a measurable fall colouring
  (FS-120's stub); *Grundy-bound* is bound for every colour but the largest (G89). Row 66's "one gap frees every pair above it" is the finite face
  of "an unsaturated class can grow".
- **forced pair.** (i) `Forces G k u v` (row 42): every proper `k`-colouring gives `u`, `v` one colour. (ii) Route R's forced *complementary pair
  of fat junctions* (row 133, FS-122): a structure every near-colouring must contain — not a colour equality.
- **ring.** (i) FS-116's ring `ω(p)`, the unit circle about a vertex `p` (G91). (ii) The unit-vector ring `ℤ[U_F]` (G55). (iii) G2's rings of
  vertices about a rotation centre.
- **window.** (i) The window members `q ∈ {23, 27, 31, 43, 47}` and `U₆₄` (G56, G59). (ii) A pencil's window `ℓ` (FS121-D1-PENCILWIN). (iii) Window
  frequencies (G73, FS-80). (iv) FS-64's adelic window colourings. (v) RING-TWIST-C's qualifying window, a 120° arc.
- **slack.** (i) Hoffman slack (G54). (ii) A colouring *with slack*: proper with a margin in distance (row 132; `[Voronov2023]` Thm 1.1).
- **ladder, fan, cone, wall.** G7's ladder (the spindle family) and G84's ladder of unit parallels; G13's fan (confinement at a centre) and REG-J′'s
  fan (finitely many arcs at a point of Σ); Woodall's cone (row 134), the cone lemma (FS107-R-CP) and FS-116's cone calculus at the unit rhombus;
  the 2-adic wall (G35), the wall at six (G59) and the regularity wall (`CLAUDE.md` § The aim).
- **height, index.** G71's height of a three-colouring and row 132's index of density traces are one object, the second on a curve (G71).
- **Kneser graphs.** `KG(4, 2)` and `KG(6, 2)` appear in G73 (the `V₄` structure of `K₄`'s three perfect matchings; edge-local heights) and in
  FS116-N2's reading of the transfer at a hub (`plans/STUB-q-ring.md` case 5): the same graphs.
- **(Q), (R2).** FS-112's two kinds of unit arc; `plans/FS114-NB6-verification.md` ll. 109–111 records two readings of "(Q)", and the stubs use
  FS-112's (an arc whose centre carries both its side colours).

## 2. The no-gos that exclude kinds of input (read these before any step)

- **G86** (FS114-N2-REFINE): a tile count is blind to Siamese pairs — a count reaches the non-Siamese part only.
- **Row 129 / G60**: one colour class at a time caps below 4.37 — no density bound on single classes gives six.
- **Row 131's two**: counting holes met by unit circles or bicycles caps at `O(ε)`; trichromatic points vanish from partial colourings.
- **G73**: at four colours no cell-local topological certificate (edge height, loop winding, face flux, coindex) on a lattice graph.
- **Row 91 / G75's note**: pair correlations provably cannot pin the spectrum on a real field.
- **FS121-D4-TINY16**: regions can be as small as wished at sixteen colours — no count per region bounds the singular set.
- **FS121-C1-FLAT**: row 134's N4 step does not transfer to smooth boundaries — a proof reading only germs at the chain's points fails.
- **FS111-M2-NOSEL, FS111-M-DEADLOCK**: selection from a cover and local fills do not give honest saturation.

## 3. The steps, ranked

### J1 — FS-123, question 1: the bends, on a fragment
- **Step** ({{A plans/STUB-qfree-ring.md 29 31}}): "{{Q plans/STUB-qfree-ring.md 29 31}}"
- **Bearing.** Side 1 of the bends signal names no ring type, so a yes reaches every ring: it closes FS-123's half at `1 + ε` in the non-Siamese
  simple class with FS116-Y4-EMPTY (held), and deletes from FS-124's case list every change point that ends a non-(Q) arc. Both sides of the
  question are held statements about maps; the step is whether they hold on a fragment — the audit's purest instance.
- **Kind of input** (hunch): a modification lemma — FS-112's moves preserve validity, non-Siamese, simplicity and `p`'s colours on a fragment.
- **Read first** (hunch, R): FS112-N2-RED, -N2-AWAY, -N2-TOWARD, -N2-TAN; FS114-N5-BEND, -N5-BENDG; `plans/FS114-NB5-verification.md` § 1b.3 and
  `plans/FS114-NB6-verification.md` § 1b.0, which are verifiers' remarks, not entries.
- **Absorbs**: FS116-C114-LOCAL-F (its first ring type), FS114-GSD in part.

### J2 — FS-124, case 1: SEMI-PAR3
- **Step** ({{A plans/STUB-q-ring.md 25 29}}): "{{Q plans/STUB-q-ring.md 25 29}}"
- **Bearing.** The placing rule's only exception (FS116-N3-SEMI held, RING-TRANSFER-QC one mind): closed, four-colour vertices propagate at every
  semi-hub, which is the engine of the recurrence (J17); needed in the saturated class too (J3).
- **Kind of input** (hunch): an invariant of a three-colouring of `y`'s ring. Points 60° apart on `ω(y)` are 1 apart, so with three absent colours
  each 60°-hexagon of `ω(y)` is properly three-coloured — no parity, as the step says, but a three-colouring of a cycle has a height (G71), and its
  winding round each hexagon is an integer in `{−2, 0, 2}` that can change only at change points.
- **Read first** (hunch, A): G71 (three colours have a height; prior art Chandgotia), with row 132's index of density traces as the same height
  on a curve. (R): FS116-V6-HUG on the unit pair `{y, σy}` at a shared tip; FS114-Y2-BOWTIE with `t2` removed as the model; FS112-N3-NOBOTH.
- **Absorbs**: FS116-SEMI-PAR3, FS116-RING-TRANSFER-Q (its first place).

### J3 — FS-125: NO-SAT, through its cases
- **Step** ({{A plans/STUB-saturated-local.md 21 22}}): "{{Q plans/STUB-saturated-local.md 21 22}}"
- **Its cases, in the stub's order** ({{A plans/STUB-saturated-local.md 48 52}}): "{{Q plans/STUB-saturated-local.md 48 52}}"
- **Bearing.** NO-SAT is all route M's honest branch needs (FS111-M2-REDUCE-A): weaker than C114-LOCAL-F, the same bearing on seven, and its
  failure — saturated fragments on discs of every radius — is `χ(ℝ²) ≤ 6` with no MR (YESLIM). Every case of J2, J5, J6 has a saturated twin here,
  where FS116-O1-SATPIN pins every edge (split or tangent): ask each held result against the twin as well as the general case.
- **Kind of input** (hunch): contact at distance exactly 1 (SATPIN, G84) against a straddle (G83); for G3, how the rung-and-contact collision's
  margin varies with the tilt angle.
- **Read first** (hunch, R): FS116-S1-QF, -S1-RUNG, -S1-KAPPA, -N1-TOUCH, -N1-ECHO; FS111-M-PINCH; FS111-M4-LADDER (a rung is a ladder's first
  step). (A): none expected.
- **Absorbs**: FS116-SAT-STRIP, FS116-SAT-QFREE, FS121-NOPAR (its unit-arc members), FS111-REG-A6 (its NO).

### J4 — FS-128: TOP₆, a smaller form
- **Step** ({{A plans/STUB-top-colour.md 10 11}}): "{{Q plans/STUB-top-colour.md 10 11}}"
- **Bearing.** Given NO-SAT, FS-126 and FS-127, TOP₆ is the answer (FS121-D3-EQ, one mind): the last statement of route M's honest branch. The
  audit's realistic product is a named step strictly smaller than C121-SAT6; a sentence calling TOP₆ progress without its NO is a statement
  defect (the stub's failure clause).
- **Kind of input** (hunch): coverage — whether a top-colour boundary point's unit circle is covered by the five lower colours, which is a fan gap's
  absence (G13). The arithmetic era built this: it is decision 4's most concrete site.
- **Read first** (hunch, A): G13 and the kernel's `fan_iff_coverage`, `exists_fanGap_iff_not_coverAtLeast`; row 66 (a gap frees every pair above
  it); G54 (Hoffman-tight targets have only gap-free colourings); FS-67's gap-free pullbacks (rows 114–115). In print: the fall-colouring and
  b-colouring literature (FS-121's recognition named idomatic partitions). (R): FS121-D3 §§ 3.2–3.4, the three stalled attempts; FS121-O1-ABOVE7.
- **Absorbs**: FS121-SAT6, FS111-C-SAT-T-HONEST.

### J5 — FS-124, case 4: the five- and six-colour vertices
- **Step** ({{A plans/STUB-q-ring.md 36 39}}): "{{Q plans/STUB-q-ring.md 36 39}}"
- **Bearing.** A necessary piece of C114-LOCAL-F and of NO-SAT (these rings are wholly or mostly (Q) arcs, split in the saturated class). Any
  exclusion reads past `3/2` (SIXFRAG), and the configuration is one print left open.
- **Kind of input** (hunch): distances between outer tiles at (Q)-arc ends 60° apart — the identity of FS116-V6-HUG on the pair `{p, y}`.
- **Read first** (hunch, R): FS116-N2-FIVERING, -N2-SIXRING, -Y2-SIXOFF, -Y2-SIXFRAG; V6-HUG, which is the three-step closure
  `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)` for unit complex numbers (`plans/POROS-2026-10-03-close-reread.md` § 2.3 C5, numerically checked,
  not derived).
- **Absorbs**: FS116-C114-LOCAL-F (its many-colour rows).

### J6 — FS-124, case 2: the disk's corner
- **Step** ({{A plans/STUB-q-ring.md 30 33}}): "{{Q plans/STUB-q-ring.md 30 33}}"
- **Bearing.** The YES side's home: row 136's printed disk is this configuration. Excluded on `B̄(p, 2)`, a piece of the NO; held by a fragment
  by formula past radius 2, RING-Q is false in its class.
- **Kind of input** (hunch): points and distances on `p`'s far side, in DCREAD's directions.
- **Read first** (hunch, R): FS116-N1-QDISK, -Y2-DCREAD, -RING-GERM; FS112-CAL-DISK, -DISK-RIM (row 136).
- **Absorbs**: FS116-RING-Q, FS116-RING-TRANSFER-Q (its second place).

### J7 — FS-123 question 3 with FS-124 case 7: the Siamese and non-simple classes (one step, stated twice)
- **Step** ({{A plans/STUB-qfree-ring.md 35 37}}): "{{Q plans/STUB-qfree-ring.md 35 37}}"
- **And** ({{A plans/STUB-q-ring.md 46 46}}): "{{Q plans/STUB-q-ring.md 46 46}}"
- **Bearing.** C114-LOCAL-F and NO-SAT allow Siamese pairs; until this lands every exclusion above is a non-Siamese piece.
- **Kind of input** (hunch): points and distances only — never a count (G86).
- **Read first** (hunch, R): FS116-Y4-FLANK (colour-free, Siamese allowed, one mind), FS116-N1-GERM-S, -RING-Q-PRIME-S; FS116-V6's use of
  non-Siamese "only for the uniqueness of `R⁻`, `R⁺` and of the tip".
- **Absorbs**: FS116-C114-LOCAL-F (its Siamese rows).

### J8 — FS-126: a curved tangent-type interface, at any number of colours
- **Step** ({{A plans/STUB-curved-pencils.md 14 15}}): "{{Q plans/STUB-curved-pencils.md 14 15}}"
- **Bearing.** Decides three of FS-121's open claims at every `k`; a NO removes (R2) arcs from route M's class (FS121-Z1-NOCURVED, one mind) —
  J1's reach, in the saturated class — and gives ¬LRA (FS-115's measurable form lives here). A YES by formula at `k ≥ 7` refutes nothing at six.
- **Kind of input** (hunch): a construction meeting FS121-D1's constraints (PENCILWIN, DOUBLE, VT), or an obstruction; an inhabitant is aperiodic
  (FS121-V5-SYM-CPT), so the kind is "aperiodic structure", not a quotient.
- **Read first** (hunch, R): FS121-D1-PENCILWIN, -DOUBLE, -VT; FS121-D2-THIN, -INCURVED, -SYM. (A, low confidence): G62 (two interleaved pencils
  read as a bilayer); G78 and FS-76's aperiodic-colouring vocabulary.
- **Absorbs**: FS121-CURVED, FS121-R2-FOUR, FS121-NOLRA, FS121-O1-CARD.

### J9 — FS-127: LAT
- **Step** ({{A plans/STUB-lateral-extent.md 12 13}}): "{{Q plans/STUB-lateral-extent.md 12 13}}"
- **Bearing.** REG-J′ is one of the honest route's three conditions for the map step at six; colour-generic; a wild singular set by formula at
  `k ≥ 7` would refute it.
- **Kind of input** (hunch): distance-exactly-1 facts at an accumulation point — the sagitta of the unit circle (G90).
- **Read first** (hunch, R): FS121-D4-FACE, -GRID, -FALL, -HOLE; FS121-V5-FACE-SHARP; FS111-M3-HC, -M4-CUT. (A): none expected.
- **Absorbs**: FS121-REGJ.

### J10 — The map step at five: no open stub carries it
- **Step** ({{A plans/FS111-derivation.md 1350 1350}}, entry FS111-REG-JP-C5): "{{Q plans/FS111-derivation.md 1350 1350}}"
- **Its gap** ({{A plans/FS111-derivation.md 1352 1353}}): "{{Q plans/FS111-derivation.md 1352 1353}}"
- **Bearing.** With held FS106-AE-MAP6 (modulo Townsend's (c), J23) it gives `χ_m⁰(ℝ²) ≥ 6`, so `χ(ℝ²) ≥ 6` given MR — FS-104's YES by route M at
  five. The statement itself is equivalent to that YES (FS111-VM2-EQ5); its rungs MUA-REG-P and MUA-FIN are smaller. **No open stub carries it**:
  `MUA-REG-P` appears in no `plans/STUB-*.md` but the closed FS-121's, FS-121's derivation worked nothing at five (`plans/FS121-derivation.md`
  l. 115: "not claimed: anything about modifications that may lower a class; anything at five or six"), and FS-104's stub names it once, l. 97, as "a reformulation, carried in FS-121". Its
  MUA-FIN shares FS-120's pinch (J11) with the six-colour route.
- **Kind of input** (hunch): regularity of maximal covers — modification lemmas that keep maximality.
- **Read first** (hunch, R): FS111-M2-REDUCE-C, -M2-COV, -M2-FIX, -M2-HULLC, -M3-IRREG, -M3-FIN-U, -M3-MOVE, -M3-COVER; FS106-AE-MAP6.
- **Absorbs**: FS111-REG-JP-C5, FS111-MUA-FIN-L (with J11).

### J11 — FS-120: the pinch at a junction
- **Step** ({{A plans/STUB-pinch-at-junction.md 28 29}}): "{{Q plans/STUB-pinch-at-junction.md 28 29}}"
- **Bearing.** The one finiteness step on both bounds' paths: REG-J′-C₅ at five (J10, toward six) and REG-J′ at six (J9, toward seven); a fall
  colouring with a pinch no move removes refutes C121-REGJ (FS121-D4-FALL, one mind).
- **Kind of input** (hunch): a modification lemma along the ladder of unit parallels, ending at a junction.
- **Read first** (hunch, R): FS111-M4-LADDER, -M4-CUT, -M4-MOVE, -M3-CASCADE; FS121-D4-FALL.
- **Absorbs**: FS111-MUA-FIN-L (with J10).

### J12 — FS-104 route (c): correlation constraints on stationary colourings
- **Step** ({{A plans/STUB-cp-plane-six.md 67 69}}): "{{Q plans/STUB-cp-plane-six.md 67 69}}"
- **Bearing.** FS-104's YES is `χ(ℝ²) ≥ 6` given MR; its NO, a CP five-colouring, is `χ(ℝ²) = 5` with no MR. By row 129 a certificate of six must
  read how classes fit together, and correlations are that shape.
- **Kind of input** (hunch): a spectrum or a multi-point correlation of an invariant random colouring.
- **Read first** (hunch, A — decision 4's second site): rows 111–113 and 124 (invariant random colourings; spectra on `T + A`; SEL-k: given MR,
  `F²` is `k`-colourable iff it has a rotation- and translation-invariant random `k`-colouring with spectrum on `T + A`); G73 and G75 (averaged
  certificates; the eigen-equation of a forbidden pattern on the tetrahedral embedding); G76; row 91 and G75's note, read first as the no-go on
  pair correlations; FS-80's stub. (R): none expected.
- **Absorbs**: none (no index entry).

### J13 — FS-104 routes (0) and (b): Falconer's mechanism, read as a CP statement
- **Step** ({{A plans/STUB-cp-plane-six.md 59 61}}): "{{Q plans/STUB-cp-plane-six.md 59 61}}"
- **And** ({{A plans/STUB-cp-plane-six.md 66 66}}): "{{Q plans/STUB-cp-plane-six.md 66 66}}"
- **Bearing.** As J12.
- **Kind of input** (hunch): a compulsion — a pair forced equal or apart, at a distance that varies continuously.
- **Read first** (hunch, A): the compulsion toolkit, rows 42–51 (`Forces`, `Separated`, arity floor, critical sets, absorption); G39, G40; G53's
  counting compulsion. Check `BIBLIOGRAPHY.md` for `[Falconer1981]` first; the stub says it is not held.
- **Absorbs**: none.

### J14 — FS-122: B-RR, a cone-scale bound independent of the holes
- **Step** ({{A plans/STUB-forced-pair.md 23 24}}): "{{Q plans/STUB-forced-pair.md 23 24}}"
- **Bearing.** With A-ALL and FS107-R-CP it gives seven with no map NO; A-ALL is the answer restated (FS111-W-NEG), so B-RR is route R's measure of
  progress.
- **Kind of input** (hunch): a feature's scale bounded below (G82 as corrected: price a certificate at its feature's scale, never at `ε`'s).
- **Read first** (hunch, R): FS107-RR, -R-CP, -W-TAN, -R-SW; FS111-W-B-NONABS (refuted: the context), -W-HX-PAIRS.
- **Absorbs**: FS111-W-B-NONABS (its refutation frames the step).

### J15 — Route R's pairs and route M's four-colour vertices, with unit arcs (Poros's words; an invention signal)
- **Step** (Poros's words): with unit arcs — where route M's open steps live — does every close complementary pair of route R meet a vertex of at
  least four colours at its common unit points, so that FS-123's and FS-124's exclusions bear on route R below the answer?
- **The collision, both sides, no side picked.** Side 1, `plans/STUB-forced-pair.md` ll. 35–37: {{Q plans/STUB-forced-pair.md 35 37}} Side 2,
  `LEDGER.md` row 135: "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus with four-colour corners (FS-110's T2,
  forced)"; row 136's mechanism: "every close complementary pair of cubic trichromatic vertices needs four-colour vertices at both common unit
  points (row 135); each positive's design supplies one"; row 133 (W-TAN): "in such a map complementary-type vertices within distance 2 are
  tangent pairs or bowties". Side 1's reason is a Condition-5 fact; route M's open half is where Condition 5 fails.
- **Bearing.** If the routes share an object below the answer, a statement there serves both, and FS-122's bearing line narrows to Condition 5.
- **Kind of input** (hunch): a band-stable form of row 135's rhombus lemma — exact maps have four-colour vertices there; near-colourings have holes
  there (FS107-R-CP), and trichromatic points vanish (row 131).
- **Read first** (hunch, R): FS110-T2, FS112-FORCE, FS107-W-TAN, FS107-R-CP. Addressed to Ephodos as a card (G87).
- **Absorbs**: none.

### J16 — FS-122: a robust count, and whether the kills survive a band
- **Step** ({{A plans/STUB-forced-pair.md 25 27}}): "{{Q plans/STUB-forced-pair.md 25 27}}"
- **And FS-122's carried card** (`plans/STUB-forced-pair.md` l. 68): "Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive as an exclusion for
  band-proper fragments with slack ε and small holes, at a radius and margin independent of ε and the complexity?"
- **Bearing.** Route R's method; a band-stable local kill would also make route M robust.
- **Kind of input** (hunch): a margin bounded below at a feature's scale. FS116-V6-HUG's deficit `8 sin(s/2) sin(t/2) cos((s + t)/2) ≈ 2st` is
  second order in the hug lengths (FS-122's datum, l. 42), so a kill by it survives a band only where the hug lengths are of order `√ε`.
- **Read first** (hunch, A): G53's counting compulsion (`2L > count` refutes, from the base alone) as a model of a count that forces; G15. (R):
  FS114-Y4-RSTOPALL, FS114-Y5-PXKILL, FS107-R-SW, row 132's index.
- **Absorbs**: none.

### J17 — FS-124 cases 3, 5 and 6: crossed reciprocity, the recurrence, FS114-K1's (Q) residues
- **Step** ({{A plans/STUB-q-ring.md 34 35}}): "{{Q plans/STUB-q-ring.md 34 35}}"
- **And** ({{A plans/STUB-q-ring.md 40 42}}): "{{Q plans/STUB-q-ring.md 40 42}}"
- **And** ({{A plans/STUB-q-ring.md 43 45}}): "{{Q plans/STUB-q-ring.md 43 45}}"
- **Bearing.** Pieces of C114-LOCAL-F; the recurrence turns local placements into a skeleton of four-colour vertices (G91).
- **Kind of input** (hunch): a label conserved along placements. A hypothesis, in the hypothetical mood: if a four-colour vertex `p` (absent pair
  `A`) places a four-colour hub `q`, then `q` carries `A` and misses a pair `B` of `p`'s colours (FS116-N2-STAR), so `q`'s absent pair is `B`, and
  `{A, B, C}` (`C` the rest) is a perfect matching of the six colours; with adjacent hubs' missing pairs complementary (FS116-N2's `KG(4, 2)`
  reading) the next hub's absent pair is `C`. So each placement edge would carry one perfect matching of the six colours, the absent pairs along a
  connected skeleton would properly three-colour it by that matching's pairs, and on unit triangles of the skeleton (hubs 60° apart are 1 apart)
  the three-colouring is forced — G71's three-colour linearity on the skeleton. A held fragment is the control: read the absent pairs at the
  printed disk's five pentagon corners and the strip's midline vertices (row 136).
- **Read first** (hunch, A): G73 (`KG(4, 2)`, the `V₄` of `K₄`'s three matchings), G71. (R): FS116-N2-STAR, -N2-RECIP, -N2-ANTI, -N3-CROSS;
  FS114-K1.
- **Absorbs**: FS116-RING-TRANSFER-Q (its third place), FS114-K1.

### J18 — FS-123 question 2: the (R2)-arc ring, directly (only if J1's answer is no)
- **Step** ({{A plans/STUB-qfree-ring.md 32 34}}): "{{Q plans/STUB-qfree-ring.md 32 34}}"
- **Bearing.** The (Q)-free remainder if J1 fails; moot in the saturated class given J8's NO.
- **Read first** (hunch, R): FS116-Y4-FLANK, -S1-KAPPA; FS114-N7-HUB, -N7-3T, -N7-OCTB; V6-HUG at the double tip.
- **Absorbs**: FS114-K1 in part.

### J19 — FS-124 case 8: DISC-F and LOCAL-DENSE
- **Step** ({{A plans/STUB-q-ring.md 47 50}}): "{{Q plans/STUB-q-ring.md 47 50}}"
- **Bearing.** One question with C114-LOCAL-F, in two other forms; a reformulation an exclusion may find easier to state.
- **Read first** (hunch, R): `plans/FS116-local-exclusion.md` § 3.6; FS114-N114-COMPACT; FS112-N3-DENSE3.
- **Absorbs**: FS114-GSD in part.

### J20 — FS-128: C121-NOPAR-C5
- **Step** ({{A plans/STUB-top-colour.md 12 14}}): "{{Q plans/STUB-top-colour.md 12 14}}"
- **Bearing.** A NO for a class of maps, smaller than the answer, at six by nature; it un-parks the cover route.
- **Kind of input** (hunch): jets of boundaries along unit parallels — FS121-C1-FLAT excludes germs at the chain's points alone.
- **Read first** (hunch, R): row 134's chain (FS110-N4-FIN, W-MERGE); FS121-C1-GMAP, -C1-SAT, -C1-FLAT.
- **Absorbs**: FS121-NOPAR-C5, FS121-NOPAR (its Condition-5 members).

### J21 — FS-104 route (a): the density family at `j = 4`
- **Step** ({{A plans/STUB-cp-plane-six.md 62 65}}): "{{Q plans/STUB-cp-plane-six.md 62 65}}"
- **Bearing.** Decisive one way: `m₄(ℝ²) < 4/5` would give `χ_CP(ℝ²) ≥ 6`; the other way it closes the format. My prior is the second (row 129's
  spirit; the advisor: "a non-density (integrality) argument").
- **Read first** (hunch, A): row 129 and its one-class local–global principle; G60; FS-56's field blow-up — ask whether either has a `j`-class form.
- **Absorbs**: none.

### J22 — A root: row 134's base, Lemma 4 at cusps
- **Step** (Poros's words, from the owed-minds lines of every route-M stub, e.g. `plans/STUB-qfree-ring.md` l. 101: "row 134's base, Lemma 4 at
  cusps (BASE-V), before any publication"): derive S–V's Lemma 4 at cusp vertices in the curved, almost-everywhere setting, or locate its failure.
- **Bearing.** A root: rows 134–148 rest on row 134's base, so a failure travels the whole chain and a fill lifts it (Kooshi's note on roots). It
  moves no value alone.
- **Read first** (hunch, R): `plans/BASE-V-verification.md`; FS110-N4-FIN; FS112's cusp lemmas.
- **Absorbs**: none.

### J23 — A root: Townsend's simplification (c), in full
- **Step** (Poros's words, from `plans/STUB-regular-half-residuals.md` l. 7, "what is left is Townsend's (c) in full"): fill Townsend's (c) by a
  derivation, beyond FS106-TW's outline from Woodall's steps 2, 3, 5.
- **Bearing.** FS106-AE-MAP6 ("maps need six") rests on it, and J10's route to six rests on AE-MAP6 (FS-108's bearing line).
- **Read first** (hunch, R): FS106-AE-MAP6, -TW, -V3; `[Woodall1973]` steps 2, 3, 5.
- **Absorbs**: none.

### J24 — FS-117: K2′, GAP-μ and COVER-3 (the non-Siamese NO only)
- **Step** ({{A plans/STUB-route-t-count.md 41 46}}): "{{Q plans/STUB-route-t-count.md 41 46}}"
- **Bearing.** Partial by theorem (G86): the non-Siamese NO at best — de Grey's target, Thomassen's theorem without scalability.
- **Read first** (hunch, R): FS114-N2-ENDS, -N2-AVG, -N3-DR1, -N3-DR2, -N2-ENC3.
- **Absorbs**: FS114-ROUTE-T.

## 4. The mechanical half, placed

All thirty entries of `data/fs129/index/open-steps.md` § 1 (every entry whose verdict class is gap, stalls or refuted) are regularity-era. Placed:

| entry | placed at |
|---|---|
| FS116-C114-LOCAL-F, FS114-GSD | J1, J2, J5–J7, J17–J19 (the ring types) |
| FS116-SEMI-PAR3 | J2 |
| FS116-RING-TRANSFER-Q | J2, J6, J17 (its three places) |
| FS116-RING-Q | J6 |
| FS116-SAT-STRIP, FS116-SAT-QFREE | J3 |
| FS121-NOPAR | J3 (unit-arc members, NO-SAT), J20 (Condition-5 members) |
| FS111-REG-A6 | the answer restated given the NO (FS111-C-REG-EQ); its pieces are J3, J4, J8, J9 |
| FS121-SAT6, FS111-C-SAT-T-HONEST | J4 |
| FS121-CURVED, FS121-R2-FOUR, FS121-NOLRA, FS121-O1-CARD | J8 (one question, FS-126) |
| FS121-REGJ | J9 |
| FS111-REG-JP-C5 | J10 |
| FS111-MUA-FIN-L | J10, J11 |
| FS111-W-B-NONABS | refuted (a result); frames J14 |
| FS114-K1 | J17, J18 |
| FS121-NOPAR-C5 | J20 |
| FS114-ROUTE-T | J24 |
| FS116-Y-SAT | a construction stall; not an audit step (the audit reads, it does not build); its obstruction is J3's |
| FS106-AE-Q2 | `[SokolovVoronov2025]` Question 2 itself — the question J1–J7 and J17–J19 work |
| FS106-STAB | the stability question, i.e. the answer itself (row 131) |
| FS106-SV1, FS106-AE-FA | superseded: S–V Thm 1's fills are answered under Condition 5 with Condition 6 dropped (row 134; `plans/STUB-regular-half-residuals.md` l. 7) |
| FS110-CE4 | repaired in its own entry (R2, R4) |
| FS111-C-HULL-SO, FS111-M2-DISCK7-AS-PLACED | refuted (results, not steps) |

Sections 3 and 4 of that file (790 lines naming a GAP or a gap) are not judged here; the readers take them after this list, in their stubs'
rank order (Keryx's pending ruling, `plans/FS129-close-inventory.md` item 8).

## 5. Considered and left off, with the reason

- FS-115's (b′), (b″), N3-ALPH and the bowtie end: no bearing on the NO since FS114-CV-EXISTS; its measurable form, ¬LRA, is J8's.
- FS-104's items (1)–(3) (`χ_m⁰ = χ_m`, `χ_B`, the ZF + DC audit) and Johnson's choice-number question: none on `χ(ℝ²)` given MR (row 130).
- The owed second minds of every stub, FS-125's question 0 among them: verifications, not steps — except the two roots, J22 and J23.
- The construction targets (G83's killing test, a fragment past `φ²/√2`; OC; Y-SAT): the audit reads, it does not build. A held fragment that
  composes with another into a larger one would be a pass-2 find, and is welcome.
- FS-109 (the hole dial): decides nothing alone. FS-44 (the fifth colour) and FS-62, FS-49, FS-59: reach the answer only through FS-104 (J12,
  J13, J21).
- Ranks 14–73 of `plans/FRONTIER-STUBS.md` (the arithmetic-era stubs and the Lean stubs): their own bearing lines read "none on the answer".
  Lane A reads their held results as supply, not as demand.
