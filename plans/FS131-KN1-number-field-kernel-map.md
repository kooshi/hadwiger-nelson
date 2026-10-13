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

## Stage 4 — SAVED: the map, part III — the chain to five and what stands on it (rows 108–130, the standing field)

**Rows 108–110 — rank-one four-colour inheritance; the mixing selection; windows at five over `ℚ(√167)`.** `[hand]`. K:
none. Missing: `plans/M3-derivation.md` and the M3 records the rows name. Row 109's selection is the tool rows 128–129 use
in its cut-and-project form (FS103-SEL). Not sized.

**Rows 111–113 — four-colour rigidity as invariant measures plus transience; Theorem C over the real S2 fields; at `ℚ(√47)`
no invariant random four-colouring reads finitely many places (R88-TCA).** `[hand]`, two derivations at `ℚ(√47)`.
- K: none of the theorems. Under R88-TCA's count the kernel holds, at a wider class and with no hypothesis,
  `StationaryRatio.ratio_prod_le` (X25B-PZ), `StationaryRatio.ratio_prod_le_iSup_levels` (X25B-L1),
  `StationaryRatio.StationarySet.prob_le_ratio_mul` (X25B-P), and Hoffman's bound `RatioBound.le_chromaticNumber_of_charSum`,
  `RatioBound.card_mul_le_of_indep` (std3).
- Missing: row 113 at `S = ∅` is leaf C3 of the chain below; rows 111–112 at `S ≠ ∅` add C14.2 (c) at the dyadic place
  (R88-J28V-6, `plans/R88-derivation.md:174`) and the split-place set `E` that the chain itself no longer needs (X6).

**Rows 114–115** are outside the line (finite product colourings); **rows 116–118** (Kronecker selection refuted and
reduced; T-C(A)'s class among real quadratic fields; rank one) are `[hand]`, K: none; row 117's class statement is FS100-T1
(`plans/FS100-derivation.md:116`), an instance leaf of the chain (C6).

**Row 119 — `χ(ℚ(√167)²) ≥ 4` with no finite graph.** Kernel-checked. K: `four_le_chromaticNumber_planeOver_sqrt167`,
`four_le_chromaticNumber_planeOver_of_sqrt167_mem`, `Sqrt167.cert_check`, `ThetaPlane.four_le_chromaticNumber_of_cert`
(std3). Nothing owed. (Upper end: `χ(ℚ(√167)²) ≤ 8` would follow from `[S1a]`, `[S2]` at 23 and
`CayleyCert.colorable_finitePlane23_eight`; not stated.)

### The chain: rows 120, 121, 123, 127 — MR(F); `χ(ℚ(√47)²) = 5`; the main clause through five; its kernel form

**Claims.** Row 120: for every real number field `F` with no ramified stable dyadic place, every `U_F`-invariant finite
measure on the dual of `ℤ[U_F]` null on `E` is a multiple of Haar measure — `[hand]`. Row 121: `χ(ℚ(√47)²) = 5` — `[hand]`,
the lower half through row 120. Row 123: `χ(F²) ≥ min(L(F), 5)` for every real number field, so `χ(F²) = L(F)` whenever
`L(F) ≤ 5` — `[hand + tools exact]`. Row 127: the same composition kernel-checked over named hypotheses — `[kernel]`.

**K (all std3).**
- `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five` — no hypothesis. **The upper half of row 121 is unconditional.**
- `SpectralChain.min_localBound_five_le_chromaticNumber` — takes, outside: `SpectralChain.BochnerHerglotz`,
  `SpectralChain.InvariantMeasureOnClosed`; ours: `Interface.Count` (twice: totally real, and with a complex place),
  `Interface.APlusOfR88`, `Interface.RU`, `Interface.PE2`, `Interface.EFPlus`, `inline:CLS`, `inline:Row99`.
  `…_of_totallyReal` the same; `SpectralChain.chromaticNumber_eq_localBound` adds `inline:UpperHalf` (ours).
- `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain` — takes `BochnerHerglotz`,
  `InvariantMeasureOnClosed`; `Interface.APlus0`, `.RU`, `.PE2`, `.EFPlus`.
- Proved links: `Interface.mr_of_pe2_efPlus`, `Interface.x4_eq_empty`, `Interface.five_le_chromaticNumber`, `posDef_corr`,
  `rotInv_of_isTraceSpectral` (over `BochnerHerglotz`), `exists_invariantColouring` (over `InvariantMeasureOnClosed`).
- Under A⁺ (FS-131 wave 10, later than rows 121 and 127 were written): J45-N2's factor half
  (`SpectralInputs.measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`), its spectral half `SpectralInputs.spectral_carried_iff`
  (takes `SpectralInputs.BochnerOn`, outside), J45-N1 (c) `SpectralInputs.contChars_haar_null` (over `BochnerHerglotz`),
  J45-SI-4 `SpectralInputs.si4` and `FactorAction.si4_equivariant_factorSigma`, J45-SP-oi `SpectralInputs.sp_only_if`,
  J45-SP-if `SpectralInputs.sp_if` (takes `BochnerHerglotz`, `Interface.MulStable`, `Interface.NegCircle`, the last two
  ours), J45-SI-J `ProductFactor.contVec_prod_eq`, J45-SI-C's finite facts (`Arith/GapSeven`), FS131-E8-SI5C
  `MajorityVote.ae_eq_measurable_of_majority`.
- Under CLS: `StandingFive.targetFloor_six_weil`, `targetFloor_seven_weil` (IMPORTED, Weil); `Floor128.targetFloor_eight_128`
  (std3, no import); `NormOneTarget.targetFloor_of_charSum`, `NormOneTarget.card_normOne` (std3).

**What the kernel form is, read as the kernel has it — weaker in form than rows 123 and 127 say.** The headline quantifies
over an arbitrary `Interface F`: a set `E`, a set `TA`, and a function `h : Measure (Dual F) → unitVectors F → ENNReal`, all
free data (SpectralChain.lean:130–144). `PE2` and `EFPlus` are sentences about that arbitrary `h`, not about entropy; `RU`,
`MR` are sentences about that arbitrary `E`. The theorem is true and not vacuous, and the derivation's objects satisfy the
hypotheses by hand; but **no Lean term names `E`, `T + A` or entropy for a field**, so today no hypothesis of the headline
is a closed statement about `F`, and none can be proved or declared. Every leaf below begins by naming those objects.

**The chain's leaves, in dependency order.** Addresses: `D` = `plans/FS100-derivation.md`, `J45` =
`plans/FS84-SI-D-derivation.md`, `R88` = `plans/R88-derivation.md`, `X01D` = `plans/FS100-X01D-derivation.md`, `X02D` =
`plans/FS100-X02D-derivation.md`, `FS105` = `plans/FS105-derivation.md`. Statements quoted in
`data/fs131/kn1/leaf-statements-123.txt`.

*C0 — name the objects (no mathematics; new declarations beside the gated ones, no gated statement changed).*
1. `T + A` as a set of `SpectralChain.Dual F` — the torsion characters plus the characters with an additive real lift
   (`CharacterColouring.torsionBy`, `.archimedean` are the same sets in the model `M →+ ℝ/ℤ`; one bridge between the two
   models of a character). Its stability under `rot u`, and its measurability: `T` is countable because `R/NR` is finite
   (X02D:100, Lemma F: "A torsion-free abelian group `A` of rank `n` has `|A/mA| ≤ mⁿ`"), and `A` is the image of a
   finite-dimensional real space.
2. The chain run at the interface `E := TA := T + A`: one closed sentence, **MR⁺(F)** — every finite rotation-invariant
   measure on `Dual F` null on `T + A` has every Fourier coefficient off `0` equal to `0` — and SP-Cor from `BochnerHerglotz`,
   `InvariantMeasureOnClosed`, `APlus0` and MR⁺ (an instance of `Interface.x4_eq_empty`, whose `hRU` is then `τ(∅) = 0`).
   **R-U leaves the path** (X6).

*C1 — the two classical inputs of the composition.*
3. Herglotz–Bochner on a countable discrete abelian group, with uniqueness — discharges `BochnerHerglotz` (13 takers).
   Printed: `[Rudin1962]` 1.4.3 and 1.3.6; the hypothesis's docstring says "not quoted from a held copy"; the read-back is
   owed (`ARCHITECTURE.md` § Trust: "the page not read"). Mathlib at the pin: no positive-definite functions on groups, no
   Bochner (searched "positive.definite function", "PositiveDefinite", "herglotz", "bochner's theorem": only Poisson and
   Jensen files); it holds `Topology/Algebra/PontryaginDual.lean` and Riesz–Markov–Kakutani
   (`MeasureTheory/Integral/RieszMarkovKakutani/`). My call: **formalize**, as a planner-and-implementer job of its own —
   more than an hour, a classical theorem with a self-contained proof, and thirteen statements wait on it. Size unknown.
4. Markov–Kakutani, twice — discharges `InvariantMeasureOnClosed` (7 takers). Printed: `[Kakutani1938]`; `BIBLIOGRAPHY.md`:
   not held; the docstring: "not read". Mathlib: no fixed-point theorem for commuting affine maps, no invariant measure for
   an amenable action (searched "markov.?kakutani", "amenab": Følner filters, Riesz–Markov–Kakutani and
   `MeasureTheory/Measure/Prokhorov.lean` only). My call: **formalize**, its own job; the fixed-point theorem is a page and
   compactness of the probability measures is Prokhorov's file. Size unknown.

*C2 — the arithmetic of the places (ours; no outside theorem but Weil's, held).*
5. `[S1b]` the upper half — discharges `inline:UpperHalf`.
6. Row 99's leaves (its entry) — discharge `inline:Row99`.
7. `[S9]` at a stable prime the image of `U` in `𝓞/P^m` is every norm-one element (the caveat carried from X11K2:
   "`levelTarget` uses the norm-one elements of `𝓞/P^m`; the derivation's `S_m` is the image of `U`. They agree by
   smoothness of the norm-one torus — [hand], not in the kernel", `plans/STUB-main-clause-five-kernel.md`); FS91-J07-5
   (`plans/FS91-derivation.md:159`) is the joint form.
8. CLS, D:285 — discharges `inline:CLS` (`5 ≤ localBound F → TCA F`). Its parts: `[S3]`; the ratio bound with Weil on the
   odd stable places from the Weil range up (kernel: `RatioBound`, `NormOneTarget`, `FloorPlanes`); the finite list below
   it — the planes at 11, 19, 23, 27, 31, 43, 47 by exact spectra or certificates (D:289, FS100-G27, is the one at 27);
   the all-levels bound up a stable tower (X26B-L1, `plans/FS100-X26B-derivation.md` § 2; D:287, FS100-DLP, at an inert
   dyadic tower) with `[S5]` at 11 and 19; the dyadic inert targets `U_Q`, `Q ≤ 32` four-colourable by formula (X26B),
   and `Q ≥ 64`. **To check before anything is promised:** which bound the derivation uses on `U_Q` at `Q = 2^f ≥ 64`. The
   held import is Weil's page "of characteristic not 2", and the kernel's one dyadic floor is an exact computation at 128;
   if CLS reads a Kloosterman bound in characteristic 2 it is a second printed statement, not yet declared. Unread by me.

*C3 — R88-TCA at `S = ∅` from the class (`Interface.Count`; D:291, R88:161).*
9. `m₁(ℝ²) < 1/4`: `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.246989`. Outside, computer-assisted. Before it can be declared
   the library needs `m₁` — the supremum of upper densities of Lebesgue-measurable planar sets with no two points at
   distance 1 — which Mathlib's measure theory can state. My call: **import**. Four items all owed; the page's reading
   status I did not check beyond the bibliography's row.
10. The extension of a colouring measure with spectrum on `T + A` to the compact group `G_∅` (R88:114, R88-TC-ext),
    regularisation (R88:123, :130), the factor at the non-thick places (R88:135, :140, :152), the stationary count
    (R88:144; kernel at a wider class: `StationaryRatio`), the archimedean factor at `n` real places (D:291: C14.3's
    induction), and at a complex place the restriction to the compact real form (D:293, FS100-CX). Uses weak approximation
    (row 99's entry) and `[S9]`. Not sized; this is the largest block of the chain that is ours and not entropy.

*C4 — A⁺ at `S = ∅` from R88-TCA (`Interface.APlusOfR88`; J45 § 3, remark (ii)).*
11. J45-N1 (a) at `S = ∅`: the characters continuous for the profinite-plus-archimedean topology on `ℤ[U_F]` are exactly
    `T + A` (J45 § 1.2, § 5.4; `plans/FS131-w10-kernel-plan.md` § 3.3: "not stated"). With it `SpectralInputs.spectral_carried_iff`
    reads at `T + A`, over `BochnerOn` — Bochner for a topology induced from a locally compact group, the same `[Rudin1962]`
    1.4.3 (leaf 3's job should prove this form too).
12. SI-1 / SI-3 (J45 § 2.2, :140): the spectral identity for the part of `σ_μ` off `T + A` in terms of conditional
    probabilities on the factor; then with SI-4 (kernel) and leaf 10, A⁺.

*C5 — the two deductions under MR⁺ (ours; lifted from hold by Amendment 2).* **Before any printed statement here can be
declared the library needs three definitions it lacks:**
13. **Kolmogorov–Sinai entropy** `h_μ(T)` of a measure-preserving map for an invariant probability measure, with the
    conditional form `h_ρ(γ | 𝒜)` on an invariant sub-σ-algebra. Mathlib at the pin has none (searched "kolmogorov.?sinai",
    "measure.theoretic entropy", "metric entropy"; found `Dynamics/TopologicalEntropy/`, `SpecialFunctions/BinaryEntropy`,
    `Log/NegMulLog`). Every printed input below is a sentence about it. `plans/STUB-mr-in-lean.md` notes that
    `[OAIMath2026]` family 015 has conditional entropy for countable partitions in Lean at another pin, headers only read:
    a port candidate, to be read before this is typed from scratch.
14. **The pieces**: for `Γ = ⟨u, w⟩ ⊂ U` and a finitely generated `ℤ[Γ]`-submodule `M ⊆ ℤ[U_F]` with `ℚM = F(i)`, the dual
    `M̂` with the action of `Γ ≅ ℤ²`, and the predicates of the printed theorem on a `ℤ^d`-action by automorphisms of a
    compact abelian group: solenoid, totally irreducible, virtually cyclic. Mathlib: none (searched "solenoid").
15. **Haar measure on the dual in the page's own form.** `SpectralChain.Dual` carries a σ-algebra and no topology; the chain
    reads Haar only through Fourier coefficients (`SpectralInputs.IsHaarFourier`). To declare a statement that says
    "`µ = m_X`" term for term, state it over Mathlib's `PontryaginDual` of the discrete `M` and derive the Fourier form.

    Then the printed inputs, each declared or formalized on those definitions:
16. `[EinsiedlerLindenstrauss2022]` Thm 1.2 (p. 2) — the import the chain reads (X7).
17. T1, ergodic decomposition for a countable group acting on a compact metrizable space; T2, `h_ρ(γ) = lim_k h_ρ(γ | 𝒜_k)`
    along increasing invariant σ-algebras; T3, Jacobs's formula; T4, Fourier uniqueness (leaf 3). X02D § Stage 3: "T1–T4
    textbook; exact theorem numbers not checked here" — **a prior-art debt: no page is cited for T1–T3**, so none can be
    read back yet. Mathlib: no ergodic decomposition (searched). My call: unknown until leaf 13 is typed; T2 and T3 are
    candidates to formalize, T1 to import.
18. Shannon–McMillan–Breiman, for EF_F⁺'s Lemma 3.1′ (X11K's node M2: "X-SMB"). Mathlib: none (searched "shannon",
    "mcmillan"). Whether Lemma 3.1′ needs the theorem or only the definition of entropy, I did not read.
19. Chebotarev's density theorem, for Lemma W at a general field (X02D:156). Mathlib: none (searched "chebotarev"). At a
    biquadratic `F(i)` Dirichlet suffices and is in Mathlib (`Nat.infinite_setOf_prime_and_eq_mod`,
    `NumberTheory/LSeries/PrimesInAP.lean:475`; X11K's note at node M1c). My call: import for the general statement;
    none needed for `ℚ(√47)`.

    Then ours:
20. PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156);
    Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
21. EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the
    product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place
    (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers
    (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves
    (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
22. MR⁺(F) from 20 and 21 — the kernel's `Interface.mr_of_pe2_efPlus` at `E := T + A`, where its unused clause `hHE`
    (Haar-null `E`) is not needed at all.

*C6 — the instances.*
23. `NumberField` for `ℚ(√47)`'s `Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of `ℚ(√47, i)` and its target
    (D:116, FS100-T1: the class among real quadratic fields is `d ≡ 47, 143, 167 (mod 168)`). Then `ℚ(√143)`, `ℚ(√311)`,
    `ℚ(√335)` (D:275), `ℚ(√3,√5)` (D:301), `ℚ(√167) ≥ 5` (D:279).

**None of leaves 8–23 is sized: I typed none and read no proof among them in full.** Leaves 1–2 are read off a kernel proof
and are small by that reading.

**Outside statements the finished chain rests on:** Weil (held); Artin–Lang is not on this chain; `[AmbrusEtAl2023]` Thm 1;
`[EinsiedlerLindenstrauss2022]` Thm 1.2; T1 (and T2, T3, Shannon–McMillan–Breiman, Chebotarev where not formalized).
Herglotz–Bochner and Markov–Kakutani by my call are formalized, not imported.

**Reader today:** "`χ(ℚ(√47)²) ≤ 5` is kernel-checked with no hypothesis. `χ(F²) ≥ min(L(F), 5)` is kernel-checked as an
implication from nine hypotheses, seven of them this project's own unformalized results stated over an abstract interface."
**After C0–C4 and C6:** "…from one hypothesis, MR⁺(F), this project's hand result, stated in full, and three printed
theorems." **After C5:** "`χ(ℚ(√47)²) = 5` and the main clause through five, kernel-checked on the standard three axioms and
declared theorems of the literature."

### What stands on the chain

**TC1-STANDING-FIVE (no ledger row of its own; `plans/TC1-derivation.md`) — `F = K·E₇`, totally real of degree 28, has no
usable residue field below 347, so `L(F) ≥ 7`, and given MR `χ(F²) ≥ 5`.** `derived`, one mind.
- K: `StandingFive.numberField_standingField`, `finrank_standingField`, `isTotallyReal_standingField`, `usable_card_ge`,
  `no_small_usable`, `exists_stablePrime_two` (std3); **`StandingFive.seven_le_localBound_weil` (IMPORTED: Weil only)** —
  `7 ≤ L(K·E₇)` is in the kernel on one declared outside theorem; `StandingFive.five_le_chromaticNumber_weil` (IMPORTED;
  takes `inline:Row123Chain`, ours).
- Missing: the chain. Reader today: "`L(K·E₇) ≥ 7`, kernel-checked on Weil's bound."

**Row 122, rows 124–126 — where the other routes to MR stop; the type-(B) fields given MR; six at `ℚ(√167)` as a question
about the real plane; TR-ROT.** `[hand]`. K: none. Missing: the chain, then `plans/FS100-derivation.md` § 5 and D:281–283,
:309, :346–356. Not sized.

**Row 128 — the collapse: given MR, for a totally real `F` whose stable places are all 6-thick, `χ(F²) = χ(ℝ²)`;
`ℚ(√635087)`, de Grey's field.** `[hand, two blind minds]`.
- K: none for the field statement. The plane's side changed under the row: `χ(ℝ²) = χ_m⁰(ℝ²)` is in the library on the
  declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`Outside.OAI158.chromaticNumber_plane_eq_chiM0`).
- Missing: the chain's C0, C1, C5; `plans/FS103-derivation.md:38` (FS103-LB, the load-bearing step, "with no MR"), :40
  (FS103-SEL), :42 (FS103-F1), :44 (FS103-CX), :46 (FS103-CPUP), :48 (FS103-635, the place computation at `ℚ(√635087)`).
- Reader after: "given nothing but printed theorems, `χ(ℚ(√635087)²) = χ(ℝ²)`."

**Row 129 — row 123's five is `⌈1/α_loc⌉`; given MR the fractional local–global principle; `α₁(ℝ²) = m₁(ℝ²)`.** `[hand]`;
the plane clause with no MR over `[OAIMath2026]`'s rigidity theorem (FS-133, Derived, one mind). K: none. Missing: the
chain, then `plans/FS103-derivation.md:68–88`; FS-133's own module is `plans/FS133-E1-derivation.md`'s. Not sized.

**Row 130 — `χ_CP(ℝ²) = χ_m⁰(ℝ²)`.** `[hand]`. K: `Plane.chiM0_le_iff_chiCP_le` (std3; takes `Plane.Row130M1`, ours); the
equality `χ = χ_m⁰` by import. This is the real plane's row; listed because row 128 reads it. Missing:
`plans/FS103-derivation.md:100` (FS103-M1).

## Stage 5 — SAVED: the cross-cuts, the order, and what phase 2 inherits

### X1. The shared leaves, defined once

| tag | the leaf, exact enough to type | rows that wait on it | what I can say of its size |
|---|---|---|---|
| `[S1a]` | For a real number field `F` and `𝔭` with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime. | 52, 53, 73, 94, 119 (upper end), every instance field | a corollary of `Arith.exists_placeHom` at `n = 0` (`pureTranscendental_zero`) and `Arith.exists_hom_finitePlane_of_card`; statements read, a few lines by that reading |
| `[S1b]` | For a real number field `F` and `P : SpectralChain.StablePrime F`: a graph homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F) ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime. | 57, 63, 99, 103 (upper end), 105, 123, 127 (`inline:UpperHalf`) | the usable-prime analogue is `Arith/PlaceHom.lean:96–360` (about 260 lines: `exists_valuationSubring_localization`, `exists_residue_localization`, `placeHom_base`, `exists_hom_of_isPlaceHom`); those two localization lemmas are stated for `F : Subfield ℝ` and must be restated for a number field given as `fieldI F : Subfield ℂ`. Proofs not read in full: unknown |
| `[S2]` | For squarefree `d > 1`, `F = ℚ(√d) ⊂ ℝ` with its `NumberField` instance, and an odd prime `p` with `d ≡ s² ≢ 0 (mod p)`: a maximal ideal `𝔭` of `𝓞 F` with `Nat.card (𝓞 F ⧸ 𝔭) = p`. The same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`). | 52, 53, 73, 119 (upper end), 121 (a control: the result is already held another way), 123's instances | `Instances/SqrtFortySeven.lean` reaches the same end at `(47, 11)` with no `𝓞 F` in 431 lines (measured), and stays as the fallback and the control. By ideals: unknown |
| `[S3]` | For a finite field `k` of `Q ≡ 3 (mod 4)` elements, a graph isomorphism between the norm-one Cayley graph of the quadratic extension (`StandingFive.normOneCayley`, the object of `TargetFloor n Q`) and `unitQuadrance k`. | 53, 68–71 (as readings of the floors), 101, 123 (CLS) | unknown |
| `[S4]` | Each independence-number certificate as a kernel check: `α(Γ₂₃) ≤ 105`, `α(Γ₈₃) ≤ 1148`, then 27, 43, 47, 59, 67, 79. | 68–71; discharges `inline:Alpha23`, `inline:Alpha83` | unknown; to be measured at 23 first |
| `[S5]` | The all-levels independence ratios of the towers at 11 and 19 (FS-66's fibre-share certificates). | 75, 89, 123 (CLS) | unknown |
| `[S6]` | A winding on the relation lattice of `Cay(R_F, U_F)` gives a character `θ` of `R_F` with `θ(U_F) ⊆ [1/3, 2/3]` (`plans/FS73-derivation.md` T22; `plans/FS81-derivation.md:39`). | 79, 82, 99 | unknown |
| `[S7]` | Torsion extraction, FS91-J02-L1 (`plans/FS91-derivation.md:171`). | 82, 99 | unknown |
| `[S8]` | `SevenConditional.G4`: a refutation certificate for the 588-vertex core at four colours. | 103 | needs a proof log: a search request |
| `[S9]` | At a stable prime the image of `U_F` in `𝓞/P^m` is every norm-one element. | 99 (its step 5), 123 (count, CLS) | unknown |

**These go first whatever the ranking says**: `[S1a]`, `[S1b]`, `[S2]` — eleven rows wait on them between them, they import
nothing, and with them two exact values close at once (X8).

### X2. Hypotheses that more than one statement takes (`scripts/assumptions-ledger.txt`)

Of kind `ours`: `Interface.RU`, `Interface.PE2`, `Interface.EFPlus` (6 statements each); `Interface.APlus0`,
`Interface.APlusOfR88`, `Interface.Count`, `inline:Row99`, `inline:CLS` (3 each); `inline:Row123Chain`,
`CharacterColouring.OrderBound` (2 each). Every one of the first eight is on the chain to five and nowhere else: **the chain
is the only place where hypotheses of ours are shared.** Of kind `outside`: `SpectralChain.BochnerHerglotz` (13),
`StandingFive.KloostermanBound` (9; proved from the import at characteristic not 2), `SpectralChain.InvariantMeasureOnClosed`
(7), `Bridge.RealAlgebraicDescent` (6).

### X3. Where the kernel's form and the ledger's row differ

- **Stronger than the row — corrections owed to `LEDGER.md` (drafts in X9):** row 52 (the bound is kernel-checked at every
  usable prime, FS-131 wave 2; the row says `[hand + tools]`); row 57's "Not proved" clause (closed at usable primes of `F`);
  row 53's Kloosterman clause (floors on Weil's import, for the norm-one targets); row 121's and row 127's "every link it
  names is [hand] and stays so" (eight of J45's inputs have kernel forms since wave 10: the chain entry's K).
- **Weaker in form than the row:** row 127 and row 123's "kernel … over named hypotheses": the hypotheses are sentences
  about an abstract `Interface` whose `E`, `TA` and entropy `h` are free data (the chain entry). Not a defect of truth; a
  defect of what a reader is told. **Not a statement defect in the gate's sense**: I change no gated statement.
- No row inside the line claims a kernel theorem that is absent.

### X4. Statements that a declared outside theorem already in the library now implies

- **Some real number field's plane needs six colours.** `Bridge.exists_numberField_chromaticNumber_eq_plane_of_descent`
  (takes Artin–Lang as `RealAlgebraicDescent`) with `Outside.OAI158.six_le_chromaticNumber_plane` (on
  `no_proper_five_coloring`) gives `∃ F : Subfield ℝ, NumberField F ∧ 6 ≤ χ(planeOver F)`. Two lines; stated nowhere in
  `Proofs/` (searched `Bridge.lean`, `Outside/OAI158.lean`, `Plane/RadiusOutside.lean`). It is the one number-field sentence
  above five the library can hold today, on one import and one named outside hypothesis.
- Weil's import proves `StandingFive.KloostermanBound` wherever the characteristic is not 2, so each of its nine takers has
  an unconditional twin on the import; the twins exist for the floors (`…_weil`) and for no other taker
  (`circle_sum_le_of_ne`, `normOne_charSum_ge`, `kloosterman_page_of_kloostermanBound` keep the hypothesis form by design).
- Row 128: its plane side (`χ(ℝ²) = χ_m⁰(ℝ²)`) is now an import's theorem, so the collapse needs only its field half.
- Outside the line and already recorded: the six-target hypotheses given `no_proper_five_coloring` (`CLAUDE.md` § The gate).

### X5. The outside theorems, one table

| statement | printed | our copy read against the page? | Mathlib at the pin (what I searched) | call | four items |
|---|---|---|---|---|---|
| Weil's bound for Kloosterman sums, characteristic not 2 | `[Weil1948]` p. 207 | yes, two readers (`CLAUDE.md` § Trust ledger) | none ("kloosterman") | imported | held |
| Artin–Lang | `[Lang1953]`; `[GoelPatilVerma2022]` Thm 3.11 | `[Lang1953]` not held; Thm 3.11 read | none ("artin.?lang", "tarski.?seidenberg", "quantifier elimination") | import, in Thm 3.11's form | 1, 2, 4 owed; 3 held in part |
| Herglotz–Bochner with uniqueness | `[Rudin1962]` 1.4.3, 1.3.6 | no ("not quoted from a held copy") | none; has `PontryaginDual`, Riesz–Markov–Kakutani | formalize, own job | none while a hypothesis |
| Markov–Kakutani | `[Kakutani1938]` | not held, not read | none ("markov.?kakutani", "amenab"); has `Measure/Prokhorov.lean` | formalize, own job | none while a hypothesis |
| `m₁(ℝ²) ≤ 0.246989` | `[AmbrusEtAl2023]` Thm 1 | not checked by me | `m₁` undefined; statable | import | all owed |
| the positive-entropy dichotomy on solenoids | `[EinsiedlerLindenstrauss2022]` Thm 1.2, p. 2 | §§ 1, 2, 4 read (row 120) | no entropy, no solenoid | import, after leaves 13–15 | all owed |
| ergodic decomposition; entropy along increasing σ-algebras; Jacobs; Shannon–McMillan–Breiman | **no page cited** (X02D: "exact theorem numbers not checked") | — | none ("ergodic decomposition", "shannon", "mcmillan") | decide after leaf 13 | a prior-art debt first |
| Chebotarev | not cited by page | — | none ("chebotarev"); Dirichlet held | import for general `F`; not needed at `ℚ(√47)` | all owed |
| a Kloosterman bound in characteristic 2 | **only if CLS reads one at `U_Q`, `Q ≥ 64`** | — | none | to check (chain leaf 8) | — |

### X6. The interface, now that what is under it will be proved

Keep `E := T + A`. Read off the kernel's own proofs: `Interface.mr_of_pe2_efPlus` uses `E` only through `TA ⊆ E`, and binds
the Haar-null clause `hHE` without using it; `Interface.x4_eq_empty` uses `E` only as a measurable rotation-stable set
holding `TA`, in `hMR`, and in `hRU`. EF_F⁺'s conclusion is already "carried by `T + A`" (D:162). So at `E := T + A` the
chain needs PE-2, EF_F⁺ and A⁺ at `S = ∅`, and **R-U (J45 § 5.4; D:176, FS100-EFZ), the split-place set `Fin_S`, the
topology `τ′_S` at `S ≠ ∅`, and "Haar(`E`) = 0" are not leaves of rows 121 and 123.** They stay inputs of rows 112 and
116–118. X11K's table carried R-U as "months (needs N1)". Mine, one mind, read off Lean and the entries' statements — **a
deriver should confirm that A⁺ at `S = ∅` (SI-3, SI-4, N2 at `S = ∅`) reads `E` nowhere beyond `T + A`** before a skeleton
is built on it. Sent to Keryx mid-job.

### X7. Seen in passing about the printed Einsiedler–Lindenstrauss theorem (not looked for)

The chain reads **Thm 1.2** (X02D § Stage 3, input E1), whose statement needs leaves 13–15 and no notion of "factor". Row 120
says its proof in print is an outline (EL2003 § 6) and that it follows from Thm 1.3 by a deduction the paper does not write,
which is ours (FS105-DED, `plans/FS105-derivation.md:24`). FS105-VC (:35) records that Thm 1.3's hypothesis "no virtually
cyclic factors", read literally, is met by no action — the trivial factor is virtually cyclic — so an axiom copying Thm 1.3
term for term would be empty unless the reading is written into it. Importing Thm 1.2 avoids that; it leaves FS105-DED off
the library's path. Whether "any finding of ours must be formalized" then still asks for FS105-DED is Keryx's and Kooshi's
ruling.

### X8. Nearest and furthest, and the first module on the kernel's evidence alone

**Nearest the kernel.** (i) Row 52's bound as an inequality: one corollary. (ii) **`χ(ℚ(√11)²) = 4` exactly** (row 73):
`[S1a]` and `[S2]` at `(11, 7)`; the lower half and the colouring of `Γ₇` are held. (iii) `χ(K(√5)²) = 5` (row 52): `[S2]`
at `K(√5)`, 11; both ends' certificates are held. (iv) `χ(F²) ≤ L(F)` for every real number field (`[S1b]`), which also
gives the two-colour theorem its first real instance. (v) "some real number field's plane needs six" (X4): two lines.
(vi) `χ(K(√7)²) ≥ 5` (row 103): one certificate from the search lane.
**In the middle.** Row 99 (`χ = L` for `L ≤ 4`) and row 82: no entropy, no measure theory beyond characters; `[S6]`,
`[S7]`, `[S9]` and the finite ring `R/6R`. Unsized.
**Furthest.** Rows 121 and 123 (23 leaves, three definitions the library lacks, four to seven printed statements), rows
128–129 on top of them, and the character cluster 95–102 (band rigidity).

**The first module I would start with, whatever the ranking:** the residue upper half — `[S1a]` and `[S1b]` in one new
module (`Arith/UpperHalf`, importing `Arith/PlaceHom` and `SpectralChain`), `[S2]` for real quadratic fields in a second
(`Arith/QuadraticPrime`), and the values they close in a third (`Instances/…`: `χ(ℚ(√11)²) = 4`, `χ(ℚ²) = 2`,
`χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` again as the control against `SqrtFortySeven`). Reasons: eleven rows wait on it; it
discharges one hypothesis of the headline (`inline:UpperHalf`) and is leaf 1 of row 99; it imports nothing; and the result
everyone expects first, `χ(ℚ(√47)²) = 5`, is not reachable without the whole chain, of which this is also a leaf. Two
implementers could run at once with no shared file: one on `Arith/UpperHalf`, one on `Arith/QuadraticPrime`; the instances
file follows both. In parallel and independent of both, the chain's own first leaf is C0 (naming `T + A`) and then leaf 13
(entropy): a third tree.

### X9. Drafts for files this job does not write (Keryx's)

- `LEDGER.md` row 52, after "…(G43)." insert: "**In the kernel since FS-131 wave 2:** the residue homomorphism at a usable
  prime of any real number field — `Arith.exists_placeHom`, `Arith.exists_hom_finitePlane_of_card` (standard three axioms);
  the two values are still [hand] at the fields' primes." and change the grade to "[kernel for the homomorphism; hand +
  tools for the instances]".
- `LEDGER.md` row 57, after "**Not proved:** … of size N(𝔭).": "Proved since at a usable prime of `F`
  (`Arith.placeHom_base`); open at a conjugation-fixed prime of `F(i)`."
- `LEDGER.md` row 127, replace "every link it names is [hand] and stays so" by "the hypotheses are stated over an abstract
  interface (a set `E`, a set `TA`, a function `h`); of the links they stand for, J45's N2, N1 (c), SI-4, SP-oi, SP-if,
  SI-J and SI-C's finite facts have kernel forms since FS-131 wave 10 (`Arith/SpectralInputs`, `ProductFactor`, `GapSeven`)".
- `BIBLIOGRAPHY.md`: no new row. Debts to record: page citations for the four textbook inputs of PE-2 (X5).

### What phase 2 inherits

The amendment naming the asking lane's order had not come when this stage was saved (Amendments 1 and 2 were about the
target). A successor, or this job resumed, starts phase 2 at X8's module unless the ranking says otherwise: type `[S1a]`
and `[S1b]`'s statements against `Arith/PlaceHom.lean` and `SpectralChain.lean:274–301`, read them back against row 52 and
row 123's "upper half" sentence, and build the skeleton under the brief's slot line. **No build and no `lake env lean` run
was made in phase 1, so there is no measurement of this machine to report.**
