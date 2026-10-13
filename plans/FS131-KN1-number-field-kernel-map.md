# FS131-KN1 — the results about planes over number fields: what each rests on in the Lean library, and the plan of the first module

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-KN1-number-field-kernel-map.md`; branch `fs131-wnf`, cut from `main` at
`151c4a27`. Opened 2026-10-13. Working files: `data/fs131/kn1/`. The stages below are saved in order; a successor resumes at the
first stage not marked SAVED.*

## Theorems this phase proved

None. Phase 1 is a map: it reads the ledger, the gate's receipts and the modules, and proves nothing. (Phase 2, if it is run from
this record, types statements and leaves `sorry` at every leaf; it proves nothing either.)

## Stage 1 — SAVED: the readback

**The two quotations** (`W1`, `H1` in the brief's § The request) against `data/fs131/REQUEST-2026-10-13.md`, compared character
for character by script with a planted one-word change as the control: `W1 IDENTICAL` (631 characters), `H1 IDENTICAL` (259),
control `DIFFERS`. No mismatch.

**What is asked.** Kooshi is winding the project down and publishing the repository; what he wants in it first is Lean proofs of
the findings about planes over number fields. This job says, result by result, what the library holds, what it assumes, and what
stands between each result and *kernel-checked on the standard three axioms and declared theorems of the literature*; then, when
the asking lane's ranking arrives as an amendment to the brief, it plans the first module. Measure rigidity at a number field is
not to be formalized or priced here: it enters as a declared outside theorem, and the single most useful thing the map can say
about a result that leans on it is **where the printed statement ends and this project's own deduction begins**.

**The target grade, as I read it** (the brief's § The request, third paragraph): for each result, every hypothesis of kind `ours`
is discharged — proved in the kernel — and what is left is the standard three axioms plus one or more printed statements, each
declared term for term against its page with `LEAN.md` § Assumptions' four items.

**Where I draw the line around "results about planes over number fields".** Inside:

1. the chromatic number of the plane over a real field given by algebra — values, families, lower and upper bounds (rows 52, 53,
   57, 63, 72–74, 76, 82–83, 99, 103–105, 119, 121, 123, 127);
2. the finite residue planes `Γ_q`, their towers and the 2-adic tower, with what they bound (rows 53–56, 60, 66–71, 75);
3. the two theorems on residue colourings (A and B) and their consumers (rows 57, 59, 63, 72);
4. the local–global conjecture's proved range and the machinery under it: band rigidity, the class theorem for character
   colourings, the spectral chain, measure rigidity for the unit-vector group (rows 95–102, 111–113, 116–118, 120–127);
5. the four-colour rigidity results on lattices and field planes (rows 78–81, 84–94, 108–110), which are statements about
   `Cay(Λ, U)` and about planes over named fields;
6. the fractional, character, Borel and `p`-adic statements from the same machinery (rows 71, 75, 100–101, 109–110, 129);
7. the bridge between the fields and the real plane (rows 104, 107, 128, 130's field clause).

Outside, with the reason: rows 1–25 (the seam-field closures: unit-distance graphs on circles drawn over `K`, kernel-checked
already, statements about finite or two-circle objects and not about a field's plane — listed once as a group so a reader can see
they need nothing); rows 26–51 (anatomy, cell family, compulsion toolkit: graph theory of the real plane; rows 50–51, additive
colourings, are the kernel base of Theorem A and are listed under it); rows 58, 61–62, 64–65 (design targets and the Parts
reduction: witness objects, not field statements — row 64's five-chromatic object over `K(√7)` is noted under item 1); rows
114–115 (product colourings: finite graph theory, used by rows 109–110); rows 131–167 (the regularity wall: analysis in `ℝ²`).
Rows 77 (an audit) and 106 (the stripe lemma, kernel, a lattice statement) are listed for completeness only.

**How entries are grouped.** One entry per ledger row inside the line, in ledger order, except that rows held entirely by hand
within one derivation file and with no kernel form are grouped where they share every leaf (88–94; 108–110; 111–113; 116–118;
124–126). The cross-cuts follow the entries.

**Sources read at this stage, and how.** The brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the
gate fail, in full. `scripts/assumptions-ledger.txt` in full (129 rows). The last gate's assumptions receipt
(`data/fs124/l2/gate/receipt-assumptions-final.log`): every `ASSUMPTION`, `PRODUCES`, `SILENT`, `DERIVED` and totals line.
`ARCHITECTURE.md` § 3.6 and § 5 (Imported outside theorems; Assumed as hypotheses). `LEDGER.md` § The claim list in full; rows
52–63 and 119–123, 127 in full or near it; rows 64–118, 122, 124–126, 128–130 by head and tail
(`data/fs131/kn1/rowdigest.py`), each to be read in full where its entry needs more.

## The brief's amendments, as taken

- **Amendment 1 (16:07 UTC)** accepted my correction: measure rigidity at a number field, MR(F), is this project's hand result
  (the gate's receipt files `SpectralChain.Interface.MR`, `.PE2`, `.EFPlus` each `kind=ours`; row 120's prior-art clause: "MR
  not found under its discipline's names"), so it cannot be declared as an outside theorem.
- **Amendment 2 (16:12 UTC)**, Kooshi's word `W2` (`data/fs131/REQUEST-2026-10-13.md`): "I choose the second form. Any finding
  of ours must be formalized." The target for every entry below is therefore: **every hypothesis of kind `ours` discharged, the
  two deductions under MR(F) included; what is left is the standard three axioms and printed statements declared term for
  term.** Pricing the printed Einsiedler–Lindenstrauss theorem's own formalization is not asked; what I saw of it in passing is
  in § The cross-cuts, X7.

## How to read an entry

`K:` what the kernel holds — theorem names as the gate's axiom receipt prints them (`data/fs124/l2/gate/receipt-axioms-final.log`),
without the leading `HadwigerNelson.`; **std3** means the record's axioms are a subset of `[propext, Classical.choice,
Quot.sound]`; a hypothesis is given with the assumptions ledger's kind (`outside`, `ours`, `open`). The lookups are
`data/fs131/kn1/lookup.py` (self-test: a planted absent name reads NOT-FOUND, a record on an import reads IMPORTED), its
output for rows 52–130 `data/fs131/kn1/rows-records.txt`. `Missing:` leaves in dependency order, each with the derivation
entry it comes from, quoted by `data/fs131/kn1/quote.py` into `data/fs131/kn1/leaf-statements-*.txt` where the entry is cited
by id. `Reader:` what the published repository can say today, and after the leaves. **No size is given unless I typed the leaf
or read the proof; "unknown" is the honest entry elsewhere.** Shared leaves carry a tag `[S1]`–`[S9]` and are defined once, in
§ The cross-cuts.

**No ledger row inside the line cites a kernel theorem the library lacks**: of the backticked names in rows 52–130, every one
that is not mathematical notation, a Mathlib name or the outside release's name resolves to a declaration in `Proofs/`
(30 unresolved tokens, each read: `P_m`, `U_F`, `R_S`, …; `Finset.rado_selection`, `Polynomial.flt_catalan`,
`Ideal.image_subset_nonunits_valuationSubring`; `wild_fourier`).

## Stage 2 — SAVED: the map, part I — the residue planes, Theorems A and B, the field sieve (rows 52–77)

**Rows 1–25, 28, 50–51 (outside the line, listed once).** The seam-field closures, the square-root independence lemmas and
Fischer's additive colourings: kernel-checked, std3, nothing owed. They are the base Theorems A and B stand on.

**Row 52 — the finite-plane bound: a real number field with a prime of residue field `𝔽_q`, `q ≡ 3 (mod 4)`, has
`χ(F²) ≤ χ(Γ_q)`; `χ(K(√5)²) = χ(K(√247)²) = 5`.** Filed `[hand + tools]`; the bound is prior art (`[Moorhouse2010]` §8.2,
`[Manturov2012]`, `[Madore2015]` Cor. 3.4).
- K: **the bound itself is in the kernel, and the row does not say so.** `Arith.exists_placeHom` (std3; FS-131 wave 2): for a
  real number field `F`, a usable prime `𝔭` of `𝓞 F` (`Arith.IsUsablePrime`: maximal, `Nat.card (𝓞 F ⧸ 𝔭) % 4 = 3`) and
  `t₁ … t_n` algebraically independent over `F`, a graph homomorphism from the unit-distance graph on `F(t)²` into
  `unitQuadrance (𝓞 F ⧸ 𝔭)`; `Arith.exists_hom_finitePlane_of_card` (std3) into `finitePlane p` when the residue field has
  prime order `p`. Under them `Arith.exists_valuationSubring_localization`, `Arith.exists_residue_localization`,
  `Arith.placeHom_base` (std3). `chromaticNumber_finitePlane11` (= 5, std3).
- Missing: (1) `[S1a]` the bound as an inequality of chromatic numbers — a corollary of `exists_placeHom` at `n = 0`, not
  stated anywhere. (2) `[S2]` at each named field, a usable prime with its residue field: for `K(√5)` and `K(√247)` a
  maximal ideal of `𝓞 F` with quotient of 11 elements. (3) the lower ends: `K(√5)` is Heule's field, and
  `UDCert.chromaticNumber_le_planeOver_of_sevenFree` with `chromaticNumber_heule510` (both std3) is the route
  `five_le_chromaticNumber_planeOver_fourteen_sup_seventy` already takes; the lower end at `K(√247)` I did not trace to a
  certificate — unknown.
- Outside: none. Reader today: "the residue homomorphism at a usable prime is kernel-checked for every real number field; the
  two values are held by hand." After: "`χ(K(√5)²) = 5`, kernel-checked."

**Row 53 — the field sieve: `unitQuadrance`, functoriality, `χ(Γ₁₁) = 5`, `χ(Heule-510) = 5`; [derived] every plane at
`p ≡ 3 (mod 4)` from 59 up refuses five, and the 6-open criterion with its instances.** Kernel-checked for the named theorems;
the Kloosterman clause `[derived]`.
- K: `UDCert.drawing_adj`, `chromaticNumber_finitePlane11`, `chromaticNumber_heule510` (std3). For the Kloosterman clause the
  kernel now holds more than the row: `StandingFive.targetFloor_six_weil` (`Q ≥ 62`) and `targetFloor_seven_weil` (`Q ≥ 98`),
  each IMPORTED on `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, four items held, `ARCHITECTURE.md` § Trust) — but
  about the norm-one target `StandingFive.TargetFloor n Q` of `𝔽_{Q²}`, not about `finitePlane Q`.
- Missing: `[S3]` the isomorphism between the norm-one Cayley graph of `𝔽_{Q²}` and the plane `unitQuadrance 𝔽_Q` for
  `Q ≡ 3 (mod 4)` (`ARCHITECTURE.md` on `Arith/FloorPlanes`: "once the target is linked to the plane `Γ_Q`, which no
  declaration does yet"). The 6-open criterion over multiquadratic `F ⊇ K` and its instance list (first usable primes 131,
  479, 83, …): each instance is `[S2]` at that field plus `[S3]`.
- Reader today: "six and seven are refused on the norm-one targets from 62 and 98 up, on Weil's bound." After `[S3]`: "every
  finite plane `Γ_Q`, `Q ≡ 3 (mod 4)`, `Q ≥ 98`, needs seven colours, on Weil's bound."

**Rows 54–56, 59–60 — the lift, the residue obstruction, local–global tightness, the 2-adic law over `K`, plane freedom.**
Kernel-checked. K: every named theorem std3 (`rows-records.txt`). The `[tools]` clauses (hub scans, ϑ tables) are measurements,
not theorems. Nothing owed. Reader: as filed.

**Row 57 — Theorems A and B: `χ(ℚ(√3,√11)²) = 4`; a graph drawn in an abelian group with edge differences nonzero under a
homomorphism into `G` is `|G|`-colourable.** Kernel-checked; the value is `[Fischer1994]`'s.
- K: `chromaticNumber_seamPlane`, `not_forces_five_of_subset_seamPlane`, `colorable_of_residue`,
  `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`, `normOneColoring` (std3).
- The row's "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue
  field of size N(𝔭)" is **half closed since the row was written**: at a usable prime of `F` it is `Arith.placeHom_base`
  (row 52 above). What is still missing is the form at a conjugation-fixed prime of `F(i)` — dyadic primes and the level
  targets `SpectralChain.levelTarget` — which is `[S1b]`.
- Reader today: as filed. After `[S1b]`: Theorem A reaches every stable prime of every real number field, in the kernel.

**Row 63 — two colours from inertia, and the 2-adic splitting of real multiquadratic fields; two test-passing fields whose
compositum needs five.** Kernel-checked.
- K: `colorable_two_unitDistance_induce_of_valuationSubring`, `SquareClass.fieldOfRadicands_le_sup`,
  `SquareClass.multiquadratic_decomposition`, `five_le_chromaticNumber_planeOver_fourteen_sup_seventy` (std3).
- Missing: the row's own gap, "no instance over a real field yet": the two-colour theorem at a real number field with a
  dyadic prime ramified in `F(i)/F` — `[S1b]` at such a prime, then one instance (`ℚ` itself: `χ(ℚ²) = 2`, Woodall's value).
- Reader after: "`χ(F²) = 2` at every real number field with a stable dyadic prime ramified in `F(i)`, kernel-checked."

**Rows 66–67 — the fan gap and the compulsion structure over sealed fields; the 2-adic tower of `K(i)` stabilises at level
4.** Kernel-checked for the graph statements; `[hand]` that `twoAdicPlane m` is `Cay(O/𝔓^m, S_m)`.
- K: row 66's twenty named theorems and row 67's six, std3.
- Missing: the identification of `TwoAdicTower.twoAdicPlane m` with `SpectralChain.levelTarget P m` at `K`'s dyadic prime
  (`ARCHITECTURE.md`: "a hand step recorded in the module doc"); derivation `plans/FS38-derivation.md`. Unknown size. It is
  on no headline's path; it would let row 67 be read as a statement about `K`.

**Rows 68–71 — six refused at 83; the window `q ∈ {23, 27, 31, 43, 47}`; five refused at 27 and at 23; `χ_f(K²) = 4`.** Each
`[cert]` or `[exact-rational]` (independence-number certificates checked by standalone checkers), `χ_f(K²) = 4` `[hand]`.
- K: the consumers only, each over the certificate as a hypothesis of kind `ours`:
  `seven_le_chromaticNumber_finitePlane83_of_indepNum_le` (std3; takes `inline:Alpha83`),
  `six_le_chromaticNumber_finitePlane23_of_indepNum_le` (std3; takes `inline:Alpha23`),
  `five_le_chromaticNumber_finitePlane11_of_indepNum_le` (std3; takes `inline:Alpha11`, its conclusion kernel-checked by
  another route); `CayleyCert.colorable_finitePlane23_eight` (std3). For the planes from 98 up, row 53's entry.
- Missing: `[S4]` each certificate as a kernel check — `α(Γ₈₃) ≤ 1148`, `α(Γ₂₃) ≤ 105`, and with no consumer yet
  `α(Γ₂₇) ≤ 141`, `α(Γ₅₉), α(Γ₆₇), α(Γ₇₉)`, `α(Γ₄₃) ≤ 365`, `α(Γ₄₇) ≤ 371`. These are exact rational semidefinite duals
  (`data/fs50/`, `data/fs54/`, `tools/fplane_cert_check.py`, `tools/fs54_l3_cert_check.py`); whether the kernel can afford
  them is a measurement nobody has made — unknown, and to be measured on the smallest (23) before any is promised.
  `χ_f(K²) = 4`: `plans/FS56-field-blowup.md`; no Lean object for a field plane's fractional chromatic number exists
  (`Fractional.lean` is finite) — unknown.
- Reader today: "certified outside the kernel; the kernel holds the implication." After: per certificate that lands.

**Row 72 — the 3-adic barrier.** Kernel-checked. K: `ThreeAdicBarrier.colorable_three_integralDirectionPlane` (std3). Nothing
owed.

**Row 73 — `χ(ℚ(√11)²) ≥ 4`; with the plane at 7, `= 4`; five more fields `≥ 4` by certificate.** The lower bound
kernel-checked; the others `[certified, tools]`.
- K: `four_le_chromaticNumber_planeOver_eleven`, `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem` (std3).
  `ARCHITECTURE.md`: "The upper bound χ ≤ 4 is `[Fischer1990]`'s and is not in the kernel."
- Missing: **the exact value is two short leaves away.** `[S1a]`, and `[S2]` at `ℚ(√11)`, 7 (`11 ≡ 2² (mod 7)`); the
  four-colouring of `Γ₇` is already in the kernel (`finitePlane7_colorable_four`, `Instances/PlaneFreedom.lean:61`; also
  `GapSeven.gamma_proper`, by `decide +kernel`).
- Reader after: "`χ(ℚ(√11)²) = 4`, kernel-checked, both halves" — the first exact value of a real quadratic field's plane in
  the kernel beside none today.

**Row 74 — the census: 14 real quadratic planes certified to need four.** `[certified, tools]`. K: only rows 73 and 119's two
fields. Missing: superseded as a target by row 82's theorem (every squarefree `d ≡ 11 (mod 12)`); see there.

**Row 75 — the residue ceiling does not drop up the tower at 7, 11, 19, 23.** `χ(UD(ℤ/121, 2)) = 5` kernel-checked; the
all-levels statements `[cert]`.
- K: `chromaticNumber_unitQuadrance_zmod121`, `unitQuadrance_colorable_of_ringHom`,
  `chromaticNumber_unitQuadrance_zmod_le_of_dvd`, `unitPairNat_eq_true_iff` (std3).
- Missing: `[S5]` the all-levels independence ratios at 11 and 19 (the fibre-share inequality and its certificates,
  `plans/FS66-derivation.md`, `data/fs66/`); they are inputs of row 123's count (X3 below). Unknown size.

**Row 76 — five colours over `ℚ(√3,√5)`: not landed by a forcer.** A typed null; the value is row 123's. K:
`Instances/ThreeFive` holds the subring only. Nothing owed here.

**Row 77** is an audit; no theorem.

## Stage 3 — SAVED: the map, part II — lattices, rigidity, characters, the kernel lane (rows 78–107)

**Row 78 — four colours on de Grey's lattice: `F = P = 8Λ`; the Kempe layer and the inheritance question in subgroup form.**
The Kempe layer kernel-checked; `F = P = 8Λ` `[cert]`.
- K: `kempeSwap`, `not_forces_of_kempeClosed`, `forces_iff_exists_finite`, `not_forces_of_voltageEscape`,
  `forces_iff_of_quotient_fanGap`, `not_forces_of_additiveKempe`, `exists_finiteIndex_between_notMem`,
  `notMem_periodicForcedSubgroup_of_voltageEscape`, `inheritanceQuestion_iff`, `voltageEscapeZ` (std3). The lattice
  statement is taken as `inline:Row78` (ours) by `Arith.falconerFan_five_mem_eight`.
- Missing: the refusal certificate behind `F ⊇ 8Λ`-periodicity as a kernel check (`data/fs73/cert/`, checker
  `tools/fs73_cert_check.py`), or row 85's derivation from Parts's trees (`plans/FS85-derivation.md`), each over
  `plans/FS73-derivation.md` T1–T20. Unknown size.
- Reader today: "the forcing calculus is kernel-checked; the lattice's rigidity is certified outside the kernel."

**Row 79 — three colours are linear: a Cayley graph of a finitely generated torsion-free abelian group is 3-colourable iff a
character puts every generator in `[1/3, 2/3]`; periodic 3-colourings are dense.** `[hand; two independent derivations]`.
- K: the ⟹ direction in winding form — `ThreeColour.nonempty_winding`, `nonempty_winding_of_colorable`,
  `ThetaCert.Cert.isEmpty_winding`, `Cert.not_properAlong`, `ThetaPlane.four_le_chromaticNumber_of_cert` (std3).
- Missing, in order: (1) `[S6]` the character form of ⟹: a winding gives `θ` with `θ(s) ∈ [1/3, 2/3]` on the generators
  (`plans/FS73-derivation.md` T22; over fields `plans/FS81-derivation.md:39`, T2 "L1 as an inverse limit"); (2) ⟸, the
  colouring `x ↦ ⌊3θ(x)⌋` (T21); (3) density of periodic colourings and the forced-pair clause (T23–T30). Unknown sizes;
  (2) is a formula and should be short.
- Reader after (1)–(2): the criterion as an equivalence in the kernel.

**Rows 80–81, 84–87 — four colours cell by cell; `ℚ(√167)`'s lattice `L21cc6506` four-colourable and loose; the forcing graph
on de Grey's lattice; the derivation of `F = P = 8Λ` and the 9,120 colourings; triangle-free rigidity; what does not reach
`8Λ`.** `[hand]`, `[cert]`, `[hand + tools exact]`. K: none (row 81's lower bound is row 119). Missing: every theorem;
`plans/FS79-derivation.md`, `plans/FS81-derivation.md` T20–T25, `plans/FS85-derivation.md`. These are statements about one
lattice or about formats of certificate; none is on a field value's path. Not sized.

**Row 82 — `χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` and `F²` is not bipartite; so `χ(ℚ(√d)²) ≥ 4` for every squarefree
`d ≡ 11 (mod 12)`.** `[hand, two independent derivations]`.
- K: the surrounding facts — prime inversion `UnitRing.inv_natCast_mem_unitRingOver_iff`, the chain theorem in ring form
  `UnitRing.add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver`, the winding (row 79) — std3. The theorem: none.
- Missing: `plans/FS81-derivation.md` T1 (:29), T2 (:39), T3 (:50), T4 (:66: "`1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²`
  bipartite"), T5 (:82), then the family clause (`d ≡ 11 (mod 12)` gives `1/3 ∈ ℤ[U]`, by prime inversion, kernel).
  T2 is `[S6]`; T3–T4 are `[S7]` (torsion extraction). Unknown size.
- Reader after: "every real quadratic field `ℚ(√d)`, `d ≡ 11 (mod 12)` squarefree, has a plane needing four colours,
  kernel-checked with no finite graph" — the family `[Johnson2000]` p. 176 poses as open.

**Row 83 — the census completed: 40 fields with certified witnesses.** `[cert + hand]`. Subsumed as a target by row 82.

**Rows 88–94 — the type-(B) frame over `ℚ(√59)`, `ℚ(√83)`, `ℚ(√131)`; every four-colouring of `K²` is a pullback from
`P₄` on each coset; the plane over `ℚ₂(√3)` is four-colour rigid; the no-go family; measurable windows; dyadic towers; an
explicit non-periodic four-colouring of `ℚ(√11)`'s plane.** `[hand]`, several with certificates as inputs (rows 78, 75).
- K: none of the theorems; `inline:Row88` (ours) is taken by `Arith.falconerFan_five_mem_P`.
- Missing: `plans/FS86-derivation.md` whole. Row 89 (`F(R_K) = P(R_K) = 4R_K`) rests on row 78's certificate and FS-66's at
  11 (`[S5]`). Row 94's colouring of `ℚ(√11)`'s plane (FS86-Cx-C9) is a formula — the one item here I would expect to be
  short: its proof that `⌊4θ⌋` is proper is `GapSeven.gamma_proper` plus `[S1a]` at 7. Otherwise not sized.

**Rows 95–98 — rational band rigidity (`RQ₄`, `RQ₅`), its consequences at the exposed fields, one prime's failure, and band
rigidity at every band.** `[hand]` with exact tools.
- K: the gluing only — `CharacterColouring.gluing`, `gluing_field`, `gluing_iff_uniform`, `mem_archimedean_unitRing_iff`
  (std3); `CharacterColouring.gluing_iff_of_orderBound` (std3; takes `CharacterColouring.OrderBound`, ours, FS89-S0A-3);
  `CharacterColouring.cl2` (std3; takes `OrderBound`, `inline:RQ4`, `inline:RQ5`, each ours).
- Missing: `RQ₄` (FS89-D2-T1), `RQ₅` (FS89-D5-T2), the order bounds (FS89-S0A-3 at 4, on Weil; FS91-J08-11 at 5, J08-10 at
  6), then band rigidity at every band (`plans/FS91-derivation.md:65–110`, J01-1 to J01-8: Berend's method carried to
  `ℤ[i][1/p]`, the sweep lemma SW-m). The last planner to read these proofs wrote "a milestone's worth"
  (`plans/FS131-w10-kernel-plan.md` § 5.5); I have not read them and give no size.
- Outside: `[Berend1984]` as method, not as an imported statement; Weil's bound (held).
- Reader today: "the gluing from `ℚ` to every real field is kernel-checked; rigidity over `ℚ` is by hand."

**Row 99 — three colours obey the local–global conjecture over every real number field: `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`, and
`χ(F²) = L(F)` whenever `L(F) ≤ 4`; `χ(ℚ(α,√7)²) = 4`.** `[hand (+ Weil, tools exact)]`; S1 three derivations, S2 two.
- K: none of the theorem. It is the hypothesis `inline:Row99` (ours) of row 127's headline, in the form
  `localBound F ≤ 4 → localBound F ≤ χ(F²)`.
- Missing, in order (statements quoted in `data/fs131/kn1/leaf-statements-99.txt`):
  1. `[S1b]` the upper half at every stable prime (gives `χ ≤ L`).
  2. the two-colour end: `F²` bipartite ⟹ a stable dyadic prime ramified in `F(i)/F` (GPT Astra's Thm 2.1, second
     derivation FS91-J02-A21p, `plans/FS91-derivation.md:266`); with (1) this is `L = 3 ⟹ χ ≥ 3`.
  3. `[S6]` a three-colouring gives `θ ∈ Θ₃(R_F)`.
  4. `[S7]` torsion extraction, FS91-J02-L1 (:171).
  5. the finite ring `R/6R` and the joint image of the unit vectors: FS91-J02-L2 (:144), J02-L3 (:154), J07-5 (:159), with
     weak approximation on the norm-one torus, FS91-J10-L2 (:165).
  6. norm-one functionals, FS91-J02-L4 (:175): at `q = 3^f` only `q = 3` (Weil above 243 — held as an import, at
     characteristic not 2 — and exact at 27, 243); at `Q = 2^f` none.
  7. FS91-J02-T1 (:188), the torsion local–global theorem; FS91-J09-J4 (:192), no mixing.
  8. FS91-J02-T2 (:214), S1; FS91-J02-T3 (:244), S2 — compositions.
- Outside: Weil (held). Weak approximation: Mathlib at the pin has it for absolute values
  (`Mathlib/Analysis/AbsoluteValue/Equivalence.lean`, `NumberTheory/NumberField/InfinitePlace/Basic.lean` — found by
  searching "weak approximation"); the form on the norm-one torus at finite places is ours to derive from it. Not sized.
- Reader today: "held by hand, three derivations." After: "`χ(F²) = L(F)` for every real number field with `L(F) ≤ 4`,
  kernel-checked on Weil's bound" — `[Fischer1990]` §1's question answered at three colours.

**Rows 100–102 — the class theorem for character colourings; the character chromatic numbers of the window's planes and the
exposed fields; one prime fails three ways.** `[hand]`, given band rigidity (row 98).
- K: none beyond rows 95–98's gluing. Missing: `plans/FS91-derivation.md:282–455` (J07-1 to J07-15, J08-1 to J08-10,
  J10, J11), over rows 95–98. Row 101's finite clauses (`χ_char(Γ₂₃) = 8`, `χ_char(Γ₁₁) = 6`, band lists) are exact finite
  computations a `decide +kernel` could carry once `[S3]` names the characters; not measured.

**Row 103 — the chain theorem; `χ(ℚ(√2,√3)²) ≥ 4`; `G4 → χ(K(√7)²) ≥ 5`.** Kernel-checked.
- K: `Chain.not_colorable_chain`, `Chain.add_one_le_chromaticNumber_planeOver_of_chain`,
  `SqrtTwoThree.four_le_chromaticNumber_planeOver_two_three`, `SqrtTwoThree.eighteen_not_colorable_three` (std3);
  `SevenConditional.five_le_chromaticNumber_planeOver_seven_of_G4` (std3; takes `SevenConditional.G4`, ours: "row 103 (the
  8/3 forcer: M56's 588-vertex core, one solver refusal with no proof log)").
- Missing: `[S8]` `G4` — a refutation certificate for the 588-vertex core at four colours, checked by the library's LRAT
  checker (the machinery of rung B). It needs a proof log from a solver, which is the Searcher's lane: a search request.
  Also the upper end `χ(ℚ(√2,√3)²) ≤ 4`, "not in the kernel" (`ARCHITECTURE.md`): a residue map at a stable dyadic prime,
  `[S1b]`.
- Reader today: "`χ(K(√7)²) ≥ 5` if the 8/3 forcer refuses four colours." After `[S8]`: "`χ(ℚ(√3,√7,√11)²) ≥ 5`,
  kernel-checked" — a lower bound at a field the conjecture puts at seven, by Parts's forcer (prior art) chained.

**Rows 104–106 — transcendence is free; prime inversion in valuation form and the wall broken over `K(√7)`; the stripe
lemma.** Kernel-checked. K: `RouteC.chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero`,
`RouteC.chromaticNumber_planeOver_adjoin_transcendental_eq`, `RouteC.chromaticNumber_planeOver_liouville`;
`UnitRing.inv_natCast_mem_unitRing_iff`, `UnitRing.inv_natCast_mem_unitRingOver_iff`, `SevenUnitRing.wall_broken_seven`,
`SevenUnitRing.inv_two_mem_unitRingOver_seven`; `Stripe.striped_of_proper_nt0` (std3). Row 105's reading of "σ-stable
valuation subring with `n` a non-unit" as "conjugation-stable prime above `n`" is `[S1b]`'s converse half (every
conjugation-stable valuation subring of a number field `F(i)` other than the field is the localization at a stable prime).
Nothing else owed.

**Row 107 — the bridge `χ(ℝ²) = sup_F χ(F²)` over real number fields, attained.** Kernel-checked over one named outside
hypothesis.
- K: `Bridge.chromaticNumber_plane_eq_iSup_numberField_of_descent` and four more (std3; each takes
  `Bridge.RealAlgebraicDescent`, outside, `[Lang1953]`); `Bridge.iSup_numberField_le_chromaticNumber_plane`,
  `Real.isRealClosed`, `algebraicClosure.isRealClosed`, `NoParam.not_isSquare_cube_sub_self` (std3, no hypothesis).
- Outside: **Artin–Lang** (a finite system of rational polynomial equations with a real solution has a real algebraic
  one). As printed: `[Lang1953]`, *The theory of real places*, Ann. of Math. 57, 378–391 — `BIBLIOGRAPHY.md`: "not held;
  not read; cited through `[GoelPatilVerma2022]`" (Thm 3.11 there, read). Mathlib: none (searched "artin.?lang",
  "tarski.?seidenberg", "quantifier elimination": only Presburger arithmetic). My call: **import**, as an `axiom` in the
  form of `[GoelPatilVerma2022]` Thm 3.11 (the held, read statement), deriving `RealAlgebraicDescent` from it in the
  kernel; real quantifier elimination or the Artin–Lang homomorphism theorem is far beyond an hour. Four items: (1) key and
  page — owed; (2) read-back — owed, against the held paper; (3) model — held in part (`Bridge.realAlgebraicDescent_one`,
  the one-variable case; `Bridge.not_rationalDescent`, the refuted rational twin); (4) § Trust line — owed.
- The row's second route to the chromatic-number half with no Tarski (through `[OAIMath2026]`'s transfer read on the
  algebraic plane, one mind's reading) would need an import the library does not hold; not pursued here.
- Reader today: "conditional on Artin–Lang, a named hypothesis." After the import: "on one declared outside theorem."
