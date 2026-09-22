# M41 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M41-k5-gradient.md` read in full (§0a
D1–D6 protocol design, §R results). Grades are `CLAUDE.md` § Notation's. This milestone is the seed's G24 target:
the exactly certified fractional chromatic numbers at M40's three cores, missing from row 38's compressed text.*

## The theorems

**M41-T1 — The exact fractional chromatic numbers of M40's three autopsy cores. [cert; the M41 implementer, LP
certificates re-verified in exact `Fraction` arithmetic]** For the 23-vertex `G*` core (row 37/M40, refuses six
colours, `χ = 7`), the 53-vertex deep-pocket core (refuses seven, `χ = 8`), and the 117-vertex `ω = 3` centre-free
core (refuses six, `χ = 7`): **`χ_f(\text{23-core}) = 130/23` exactly** (integrality gap `31/23`), **`χ_f(\text{53-
core}) = 501/74` exactly** (integrality gap `2.16`, ratio `1.45` — "the most extreme measured anywhere in this
programme"), and **`χ_f(\text{117-core}) ≈ 4.83796`** (a certified bracket, tight to 12 decimals, from an LP over
235,154 maximal independent sets — not claimed exact). *Proof:* `plans/M41-k5-gradient.md` §0a D1(b) (protocol: a
primal fractional colouring and a dual fractional clique, each re-verified in `Fraction` arithmetic before any
number is quoted — floats only propose, never certify) and §R ("The autopsy, COMPLETE — ALL FIVE cores FACTORED",
the 23-core and 53-core/117-core paragraphs); artifact `build/m41-gradient.json`. *Proof verdict:* closes (an exact
LP duality certificate — primal and dual values coinciding in exact rational arithmetic — is a complete proof of
the fractional chromatic number at the 23-core and 53-core; the 117-core's bracket is reported honestly as a
bracket, not claimed exact). *Rests on it:* row 37/38's own narrative ("the step to seven is integrality, not a low
relaxation" — G24 in `CLAUDE.md`, which names all three values); the comparison against `hexShell_pigeonhole`'s Act
One and the fine-tail/gap-kernel work (M42, M43) that treats these cores as the finite lab's calibration objects.
*Prior art:* the *method* — LP duality giving an exact fractional chromatic number, verified via a primal/dual
certificate pair — is standard fractional graph theory (`[ScheinermanUllman1997]`, seen in the zbMATH reference
list below, not separately held here); the specific numeric values, for these project-specific finite graphs, are
not citable elsewhere. zbMATH: `ab:"fractional chromatic number" & ab:"unit distance"` (6 hits, 2026-09-22 — none
on point: `[MatolcsiEtAl2023/2025]`'s plane-level bound (already held, `BIBLIOGRAPHY.md`), a note on the Moser
lattice's geometric colourings, an independence-ratio paper, circular colouring of the plane, and a Mathematics
Magazine survey — none computes a fractional chromatic number of any object from this milestone), `ti:"integrality
gap" & ab:"chromatic number" & ab:"clique"` (0 hits). Nearest held key: `[MatolcsiEtAl2025]` (fractional colourings
of the plane, a different object; row 71's own route). *Kernel:* declined — no module carries an exact rational LP
certificate for any of the three cores; the χ values themselves (7, 8, 7) are [tools] SAT facts, separately
correct and not restated here.

## Readings and measurements that were called theorems

- **The five-of-five factorization** (G15's universality, "all five cores FACTORED", the 23/28/53/66/117-vertex
  cores): [tools] measurement — five independent SAT-based confirmations that a small non-edge class carries Act
  One and a kill web finishes; already correctly captured by row 38 ("all five clique-free cell cores factor as
  pigeonhole × kill (G15, five of five in the finite lab)").
- **The Galois orbit** (the field automorphism negating `√3,√5,√11` fixing `√7` maps the 1581 to itself; a Klein
  four-group of non-geometric automorphisms; three new 5-chromatic witnesses `W^[3], W^[5], W^[3,5]`; `τ`'s 29
  fixed points and 776 two-cycles; the equivariance queries): [tools] measurement (exact isometry search plus
  independent isomorphism verification, all finite computations); already correctly captured by row 38 ("a
  non-geometric Klein four-group of automorphisms of the 1581 yields three new 5-chromatic witnesses (G27)").
- **The m0/m1 moment ladder across eight homo-unions and three hetero-dimers, the gen-2 closure's whole-object
  five-colouring, and the forty targeted gadget asks** (all 0 forced-equal / 0 virtual edges; two single-sample
  solver-effort signals): [tools] measurement; already correctly captured by row 38 ("no pair compulsion at five
  colours on twelve composed objects (complete sweeps), and 0 of 40 targeted asks at exact √3/2 pairs on the gen-2
  closure... the only nonzero readings anywhere were two solver-effort signals (single-sample)").

## Conjectures surfaced, not claimed

- **The "one gadget suffices" remark, found in error on re-reading (a gap, not merely imprecise).** §R's 23-core
  paragraph and `plans/SHAPES-OF-SIX.md` §3½ both assert, as a definite consequence: *"the plane-side reduction
  this sharpens: a 6-forcer needs exactly one k = 5 forced-distinct gadget at √3 or 2 — the kernel
  `hexShell_pigeonhole` already supplies Act One at k = 5 ... so nine gadget copies on the shell close
  χ(ℝ²) ≥ 6."* No proof beyond this one sentence is recorded anywhere. **Read aloud against the later, fully
  kernel-proven form, this appears to be an error, not a rounding**: `hexShell_plane`'s Act One gives only a
  *disjunctive* compulsion — some pair among the shell's 21 is monochromatic at distance `√3` **or** `2` (never
  `1`, since a unit-distance colouring already properly colours the norm-1 pairs) — in every colouring with fewer
  than seven colours. Turning that disjunction into a refusal needs BOTH distances ruled out (a virtual edge at
  `√3` **and** one at `2`), which `CLAUDE.md` G26 states explicitly, with the citation "row 43": *"χ(ℝ²) ≥ k + 1
  follows from k-colour virtual edges at √3 AND at 2 — never either alone."* The one exception — a single gadget
  sufficing — is row 61's, and only over the *restricted* `{1, 2}` distance graph (`six_le_chromaticNumber_
  oneTwo_of_forced_sqrt3`), not on the unrestricted hex-shell host M41 describes. So M41's "or", on the plane
  itself, is not the theorem the corpus went on to prove; it is recorded here as a demoted claim, not filed. No
  later milestone attempted the "nine copies" construction it proposes — the direction was superseded, not
  corrected, by the two-gadget route (G26, row 43, row 61) that the programme actually pursued.

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M41-T1 | declined — no Lean module carries an exact LP certificate for any of the three cores |
