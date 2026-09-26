# STUB — FS-98: transience over the type-(B) fields — isolation across an ultrametric front, and defect growth (the transience half of row 88)

*Minted 2026-09-25 at the close of the milestone "row 88's question" (crunch job J41, from `plans/FS86-row88-close-inventory.md` row 74 and the
two GAP verdicts). Read first: `plans/R88-derivation.md` §3 and §G; `plans/FS86-R88-D-derivation.md` §Stage 4; `plans/FS86-R88-V-verification.md`
§2.4–§2.5 and §Stage 5 rows V18–V19; `plans/FS86-row88-PA-close.md` §Stage 5. Solver column: **none until 2026-10-01**; after it, a finite shadow
(a ball agreeing with a pullback on a patch) measures balls, never the plane — the questions are derivations.*

## The mission, in plain language

Row 88 asks whether every four-colouring of the plane over ℚ(√59) (and ℚ(√83), ℚ(√131)) is a "pullback" read off the field's tight 2-adic place.
Row 88's milestone split the question into a measure half (FS-97, and row 112 for spectra reading finitely many places) and a **transience half**:
is there a colouring that is not a pullback but looks like one almost everywhere — one every invariant measure on its orbit closure puts on the
pullbacks (row 111; in the literature's words, its orbit closure's *measure centre* lies in the pullbacks)? Two statements would settle this half,
and both minds stopped at the same step of each:
- **T-B1 (isolation):** "Over a type-(B) field, every point of Pull is isolated in `X₄(F)`: for each `p ∈ Pull` there is a finite `B ⊂ R` such that
  every `c ∈ X₄(F)` with `c|_B = p|_B` equals `p`." (plan §S.1)
- **T-B2 (defect propagation):** "Over a type-(B) field, if `c ∈ X₄(F)`, `p ∈ Pull` and `D = {z ∈ R : c(z) ≠ p(z)}` is non-empty, then `D` has
  positive upper Banach density in `R`." (plan §S.1)

T-B1 implies the transience half, which implies T-B2 (R88-TA1); a FALSE for either is a non-pullback and answers row 88 "no" (R88-TA2).

## Where both stopped

- **T-B1: unique continuation from a region that is no archimedean half-space.** Re-centring converging non-pullbacks at a nearest defect closes
  by Theorem H when the defect's norm is archimedean-dominated; when it is split-dominated the re-centred region is `{w : |w + z_n|_v < |z_n|_v}`, an
  ultrametric sphere with empty liminf — "no ultrametric analogue of H is available from a finite set" (J28D). The pinned bootstrap stops at the
  discreteness of `T(O_S)` in `∏_{v∈S} T(F_v) × (S¹)²` (`plans/FS86-C-deBruijn.md` §7.5).
- **T-B2: B2-growth.** Every defect forces defects on 8 of the 24 residue classes of `U` about it (R88-B2-1: every pullback is frozen), but bounded
  chains are thin (R88-B2-2: every archimedean-bounded subset of `R` has upper Banach density 0), a defect set lies in no finite union of cosets of a
  finitely generated subgroup (R88-J28V-8d), and a sparse defect is transient (R88-B2-3) — so no invariant-measure argument reaches T-B2.

## The reading this stub is named for — [reading] (J35 §Stage 5, §6.7)

In Boyle–Lind's language (*expansive subdynamics*), archimedean half-spaces are expansive at Pull and no split-place "half-space" is; for
*algebraic* `ℤ^d`-actions Einsiedler–Lind–Miles decide the expansive subspaces by the logarithmic image (the amoeba) at **all** places, archimedean
and non-archimedean — which is where the split places would enter. `X₄(F)` is not an algebraic shift and `R` is not finitely generated, so **no
theorem transfers; the vocabulary does.** *Killing test (J35):* a type-(B) configuration determined by its restriction to the complement of a
split-place ball (an ultrametric half-space analogue), which the reading says an Einsiedler–Lind–Miles-type directional analysis would rule out.

## The questions

1. Is there an ultrametric unique-continuation lemma for four-colourings of `Cay(R, U)`: agreement with a pullback outside a split-place ball
   forces agreement inside? (Its archimedean form is Theorem H.)
2. Does colour-dependent propagation along unboundedly long chains reach positive upper Banach density (B2-growth), using the rotations at two or more
   primes (row 97: at one prime heteroclinic characters exist — the transient shape any proof must break; row 80's rank-one walls are transient)?
3. Is there a transient non-pullback at all — the "no" of row 88 in its least visible form?

## Registered expectations (to be re-registered at the opening)

The plan's P-TB1 and P-TB2 (GAP 0.75, 0.55) were met. A coherent registration here prices a FALSE for T-B1 or T-B2 at no more than the probability
that row 88 is "no" (R88-TA2; the plan's §P incoherence, recorded at its close).

## Deliverables

A derivation record per question (TRUE / FALSE / GAP at a named step); a prior-art gate in symbolic dynamics and expansive subdynamics, reading
Boyle–Lind 1997 and Einsiedler–Lind–Miles 2001 (free online; J35 §6.4 item 5) first (G50).

## Provisional bearings

G76 (a "no" must disagree with every pullback in every archimedean direction), G13 (gap-freeness drives propagation), G71 (no height at four
colours), G73 (cell-local formats closed), G78 (Kempe moves cannot see a frozen wall — the rank-one analogue of a frozen pullback), row 80 (T35's
transient walls), row 97 (one-prime heteroclinics).
