# FS131-RDM1 — the README rewritten for a reader coming to it blind

*Job record of Ephodos (the deriver lane, here as the page's writer), brief `data/fs131/briefs/FS131-RDM1-readme.md` (on `main`
at `d6c07a22c`; written 2026-10-16 18:56 UTC by Keryx). Worktree `/home/kooshi/source/lean-dir/.claude/worktrees/rdm1`, branch
`fs131-rdm1`, cut from `main` at `80629caf3`; `main` has moved two commits since (the brief, its generator script and one
inventory line — no Lean file and no source this page reads changed: `git diff --stat 80629caf3 main`).*

## Theorems this phase proved

None. This is a writing job: it derives nothing and re-grades nothing. Every result on the page is copied at the grade its
sources give it, and a grade a source states wrongly is reported as a finding, not repaired here.

## Stage 1 — SAVED: the readback

### 1.1 The quotations in the brief, checked against their sources

Checked by script (exact substring match of each quoted line against its named source):

| quotation | source | result |
|---|---|---|
| W21, "(2026-10-16) I'd also like a complete rewrite of the readme. …" | `data/fs131/REQUEST-2026-10-16.md` | verbatim |
| "**W21, read by Keryx (2026-10-16), labelled as mine.** …" | `data/fs131/REQUEST-2026-10-16.md` | verbatim |
| W2, "(2026-10-13, answering the choice between the two publishable forms) I choose the second form. …" | `data/fs131/REQUEST-2026-10-13.md` l. 4 | verbatim |

No mismatch.

### 1.2 What the page must do, in my words

The front page is read first by a mathematician who knows nothing of this project and decides within a minute whether it is
worth more of their time. So it must tell them, in this order:

1. **What the problem is**, in one paragraph, with the current state of knowledge and whose it is (χ(ℝ²) ∈ {6, 7} is other
   people's work: de Grey for five, `[OAIMath2026]` for six).
2. **What this project proved that is its own**, as a table at the top: one short formula per row, a status per row, nothing
   wider than a phone. Status is one of two kinds and says which: *checked by Lean's kernel* — on Lean's three standard axioms
   alone, or also on named outside theorems (Weil's bound, Einsiedler–Lindenstrauss Thm 1.3, `[OAIMath2026]`'s
   no-five-colouring theorem) — or *proved by hand, not yet formalized*, with the ledger's grade. Only `main` counts: the four
   modules in flight (the `p`-adic bound, the lattice three-colour criterion, the density form of the collapse, the five-colour
   fields by class) are not held.
3. **Under the table, one short section per row**: what it says in words, why anyone would care (which published question it
   answers), what it rests on, and what it does not claim.
4. **Other people's results that the library also checks**, credited exactly as `LEDGER.md` credits them, as context and never as
   ours; where the value is prior art and the kernel proof is ours, that sentence exactly.
5. **The rest** — what the library assumes, how to check it, the layout, how it was made, the licence — kept, rewritten for the
   same reader, shorter. Detail the front page no longer carries (every Lean name, every axiom list, the full results table)
   moves to one reference file at the root, linked. Nothing lost.

Wording rules: every symbol defined at or before its first use; no row numbers, milestone ids or coined terms as nouns (an
address in parentheses or a link is fine); `BIBLIOGRAPHY.md` § E's words for the literature's objects; novelty as "prior art: not
found in print", never "first", "new" or "not new"; where a search was not run, say so. The repository is public: nothing private,
no path outside it, no other project.

### 1.3 The results I intend to put in the table, with their sources

Order: this project's results first, by what a reader would look for (the asking lane's ranking,
`plans/POROS-2026-10-13-number-field-findings.md` § 3.2–3.3, plus the plane's results named apart in its § 3.6). "Status" is as
the sources state it before Stage 2's prints; Stage 2 re-prints every axiom list.

**This project's, kernel-checked on `main`:**

| # | result | source | status, as the sources state it | attribution, as the sources state it |
|---|---|---|---|---|
| 1 | `χ(ℚ(√47)²) = 5`; also `= 5` at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5); `χ(ℚ(√167)²) ≥ 5` | `LEDGER.md` rows 121, 123; `CLAUDE.md` § Where the problem stands | [kernel] since FS131-LGT1, on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3; `χ ≤ 5` alone on the standard three | lower half: prior art not found in print (row 121's gate); upper half prior art (the plane at 11, row 52); answers `[Moorhouse2010slides]`'s "What about χ(ℚ(√47)²)?", the existence half of `[Soifer2024]` Open Problem 55.1; posed again as open by `[Davies2026]` p. 5; no graph exhibited |
| 2 | `χ(F²) = L(F)` whenever `L(F) ≤ 5`, every real number field; with no hypothesis `min(χ(F²), 5) = min(L(F), 5)` | row 123; `CLAUDE.md` § Where the problem stands | [kernel] (FS131-LGT1, FS131-IL5), on Weil's bound and EL Thm 1.3 | conjecture `χ(F²) = L(F)` this project's (G48); question `[Fischer1990]` § 1 and `[Johnson2000]` Problem 4.4; the upper half prior art (`[Moorhouse2010]`, `[Manturov2012]`, `[Madore2015]`, row 52); the lower half and MR: not found in print |
| 3 | three colours: a non-bipartite `F²` is three-colourable exactly when some prime of `F` has residue field `𝔽₃`; `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`; `χ(F²) = L(F)` whenever `L(F) ≤ 4` | row 99 | [kernel] since FS131-LJ1, on Weil's bound | question `[Fischer1990]` § 1 / `[Johnson2000]` Problem 4.4; answer at this range not found in print; the two-colour classification and the three-colour one over fields with √3 are GPT Astra's (row 99, G55; `LEDGER.md` § B) |
| 4 | four colours: `χ(F²) ≥ 4` for every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite; so `χ(ℚ(√m)²) ≥ 4` for `m ≡ 11 (mod 12)`, the table for `ℚ(√m)`, and `χ(ℚ(√11)²) = 4` | rows 73, 82; `CLAUDE.md` § Where the problem stands | [kernel] since FS131-LJ1 (and row 73 since FS131-LU1), the standard three | lower bound four: prior art not found in print; `[Johnson2006]` p. 214 asks whether any `m` needs four; values 2, 3 and every upper bound `[Fischer1990]` Thms 8, 9, 10(i); the relation and `1/3 ∈ C₀` are `[Fischer1990]` Thm 10(ii), additive colourings only |
| 5 | the collapse: `χ(F²) = χ(ℝ²)` at every real number field uniformly `c`-thick, `c < 1/5`; at ℚ(√635087) and ℚ(√3,√5,√7,√11) with no hypothesis; `6 ≤ χ(ℚ(√635087)²) ≤ 7` | row 128 | [kernel] since FS131-ICO2: general form on EL; the two fields also on Weil's bound; the corollary also on `[OAIMath2026]`'s five-colour theorem | field equality: prior art not found in print; the plane equality `χ(ℝ²) = χ_m⁰(ℝ²)` is `[OAIMath2026]`'s; `[Davies2026]` Thm 1.1 is the analogue for `d ≥ 4` and suspects the plane needs "a more complicated extension" |
| 6 | the density equality: `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` | row 129 | [kernel] since FS133-LD1, the standard three (through `[OAIMath2026]`'s rigidity step, ported) | for the plane: prior art not found in print; `[Davies2026]` Thm 1.1 proves it for `d ≥ 4`; answers `[DuczVarga2026]` Conj. 1 first clause, `[MatolcsiEtAl2025]` § 2, `[Johnson1996fcn]` Questions 1, 3, `[Johnson2000surprises]` Problems 3, 4 |
| 7 | six against seven as stability: `7 ≤ χ(ℝ²) ⟺ sup_{ε>0} µ₆(ε) < 1` | row 131 | [kernel] (FS132-L1); the row says "on … the declared outside theorem `Outside.OAI158.proper_to_borel_weak` alone", `CLAUDE.md` and `LEAN.md` say that theorem is ported since FS131-LP1 — **Stage 2 decides** | not found in print as an equivalence; the conditional is `[SokolovVoronov2025]` § 9 |
| 8 | the disc criterion: `7 ≤ χ(ℝ²)` exactly when some open disc has no weak measurable six-colouring | row 161 | [kernel] (FS124-L1); the row again names the transfer as a declared outside theorem — **Stage 2 decides** | partly prior art (`[GwynStavrianos2022]` Lemma 2; Kruskal 2008; the direction toward seven is `[OAIMath2026]`'s transfer restricted); the disc form for weak colourings not found in print |

**This project's, proved by hand, not yet formalized (each now in a Lean module in flight, not held):**

| # | result | source | status | attribution |
|---|---|---|---|---|
| 9 | `χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)` for every `p ≡ 3 (mod 4)`, so no bound uniform in `p`; `χ_Bor = 4, 5, 5` at 7, 11, 19; `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` | row 75; `CLOSED-QUESTIONS.md` § 1.8 | [hand] for the bound (no second derivation filed, `plans/POROS-2026-10-13-number-field-findings.md` § 3.3 rank 4); values [cert] (exact certificates, standalone checker) + six hand links; level two at 11 [kernel] | answers `[BardestaniMallahiKarai2017]` Question 1 (no); the chain is `[Madore2015]` Prop. 3.8, the spectral bound theirs (Thm 2.5, after BDOV); ours the bound at levels ≥ 2, the certificates, the values. Not searched: MathSciNet, Russian literature |
| 10 | `Cay(Λ, S)`, `Λ` f.g. torsion-free abelian: three-colourable ⟺ a character puts `S` in `[1/3, 2/3]` ⟺ a periodic three-colouring exists; periodic three-colourings dense | row 79; `CLOSED-QUESTIONS.md` § 2.4 | [hand], two independent derivations; the ⟹ [kernel] (FS131-LJ1) | questions `[Ellenberg2018]` (MathOverflow), Gibbs and Mixon (Polymath16), `[CGHO2025bg]` Question 6.2, `[AbrishamiEtAl2025]` Problem 4.6 at `χ = 3`; the height lift Chandgotia's; density at standard generators expected folklore, not claimed |

**Named in prose, not as table rows:** the hand work on six against seven for measurable colourings (rows 132–167, mostly
[hand], one mind each), pointed to `ROADMAP.md`; the hand results whose modules are in flight (row 123's quadratic family, row
129's field clause, row 100's ring lemma) in the explanations of rows 1 and 5.

**Other people's results the library checks (context table):** `4 ≤ χ(ℝ²)` (classical, the Moser spindle); `5 ≤ χ(ℝ²) ≤ 7`
(de Grey 2018, Heule; the seven-colouring classical; "ours is the certificate", row 33); `6 ≤ χ(ℝ²) ≤ 7` (`[OAIMath2026]`, on its
axiom); `χ(ℝ²) = χ_m⁰(ℝ²)` (`[OAIMath2026]` Thm 1.3, its transfer ported; the other direction's argument `[GwynStavrianos2022]`);
`χ(ℝ²) = χ_m(ℝ²)` (`[Davies2026]` Lemma B.1 composed with the transfer); `m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]` Thm 1; the route
ours); `χ(ℚ(√3,√11)²) = 4` (`[Fischer1994]`; the kernel proof and its 𝔽₄ colouring ours); `χ(F²) ≤ L(F)` (Moorhouse, Manturov,
Madore); `χ(ℚ²) = 2` (Woodall); `χ(F(t)²) = χ(F²)` (`[Fischer1990]` Thm 6).

### 1.4 Findings so far, to be settled by Stage 2's prints

- **F1.** `LEDGER.md` rows 130, 131 and 161 call `Outside.OAI158.proper_to_borel_weak` a declared outside theorem ("imported as the
  outside theorem", "on … the declared outside theorem … alone", "on those three and the declared outside theorem"); `LEAN.md` §
  Trust ledger, Ported outside proofs, and `CLAUDE.md` § Where the problem stands say its proof was ported at FS131-LP1 and "the
  twelve records that rested on it are clean". The kernel's print decides (`ROADMAP.md`: "Where the ledger and the kernel disagree,
  the kernel's print is the authority").
- **F2.** `README.md` § What the library assumes says "33 hypotheses, taken in 108 (hypothesis, theorem) pairs"; `CLAUDE.md` §
  Trust ledger says 109, and `scripts/assumptions-ledger.txt` holds 109 `TAKES` lines.
- **F3.** `README.md`'s audit counts (11,284 records at 2026-10-15) are older than `CLAUDE.md` § Trust ledger's (11,398 records,
  10,747 clean, 77 imported, 5 purchases, 569 axiom-free, at FS131-ICO2 on 2026-10-16).
- **F4.** `LEDGER.md` row 104's *Not claimed* says "`χ(ℚ(L)²) = 2` needs `χ(ℚ²) = 2` in the kernel, row 63's missing instance";
  row 63 holds `χ(ℚ²) = 2` in the kernel since FS131-LU1. A stale clause; a correction owed to the ledger.

## Stage 2 — SAVED: the facts, checked

### 2.1 How the prints were made

Three scratch files, run from the main tree (`/home/kooshi/source/lean-dir`, whose build is current for `main`) with
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 8 --cpus 2 -- lake env lean data/fs131/rdm1/<file>`; each
exited 0 with no error. The files and their outputs are copied here, under `data/fs131/rdm1/`:

| file | what it prints | output |
|---|---|---|
| `Prints.lean` | `#check @` and `#print axioms` for the 61 names the page or the reference file cites (main at `d6c07a22c`; no Lean file changed between `80629caf3` and it) | `prints-raw.txt` |
| `Defs.lean` | `#print` of the 27 definitions those statements use (`localBound`, `levelTarget`, `StablePrime`, `planeOver`, `Thick`, `ThickAt`, `Plane.mu`, `Plane.mOne`, `Plane.chiM0`, `Plane.chiLebesgue`, `IsWeakColouringOn`, `Spectral.E`, …) | `defs-raw.txt` |
| `Padic.lean` | the same for the `p`-adic plane's nine theorems and two definitions, after they landed on `main` during this job (`785a46e77`; the main tree at `cf2d262e7`, its build holding `PadicPlane/*.olean`) | `padic-raw.txt` |

### 2.2 The axiom lists, as printed

*std3* = `[propext, Classical.choice, Quot.sound]`; **W** = `StandingFive.kloosterman_bound` (Weil's bound); **EL** =
`Rigidity.positive_entropy_rigidity` (Einsiedler–Lindenstrauss Thm 1.3); **O5** = `Outside.OAI158.no_proper_five_coloring`.
Every name is under `HadwigerNelson`.

| statement (short) | Lean name | printed |
|---|---|---|
| `4 ≤ χ(ℝ²)` | `four_le_chromaticNumber_plane` | std3 |
| `5 ≤ χ(ℝ²)` (three graphs) | `chromaticNumber_plane_ge_five`, `…_510`, `…_553` | std3 |
| `5 ≤ χ(ℝ²) ≤ 7` | `chromaticNumber_plane_interval` | std3 |
| `6 ≤ χ(ℝ²) ≤ 7` | `Outside.OAI158.chromaticNumber_plane_six_or_seven` | std3 + O5 |
| `6 ≤ χ_m⁰`, `6 ≤ χ_m⁰ ≤ 7` | `Outside.OAI158.six_le_chiM0`, `…chiM0_six_or_seven` | std3 + O5 |
| `χ(ℝ²) = χ_m⁰(ℝ²)` | `Outside.OAI158.chromaticNumber_plane_eq_chiM0` | std3 |
| `χ(ℝ²) = χ_m(ℝ²)`, `χ_m⁰ = χ_m` | `Plane.chromaticNumber_plane_eq_chiLebesgue`, `Plane.chiM0_eq_chiLebesgue` | std3 |
| `7 ≤ χ ⟺ ⨆_{ε>0} µ₆(ε) < 1` | `Outside.OAI158.seven_le_chromaticNumber_plane_iff` | std3 |
| the disc criterion and its two halves | `Plane.seven_le_chromaticNumber_plane_iff_exists_ball`, `Plane.colorable_iff_forall_ball`, `Plane.exists_radius_of_not_colorable` | std3 |
| the density equality (six statements) | `OneClass.finIndepRatio_plane_eq_mOne`, `…_algPlane_eq_mOne`, `fractionalChromaticNumber_plane`, `…_algPlane`, `iSup_fractionalChromaticNumber_plane`, `tendsto_minIndepNum_div` | std3 |
| `m₁ ≤ 0.2470`, `m₁ < 1/4` | `Plane.oneAvoidingDensityBound`, `Plane.mOne_le_0_2470`, `Plane.mOne_lt_one_quarter` | std3 |
| `χ(ℚ(√3,√11)²) = 4` | `chromaticNumber_seamPlane` | std3 |
| `χ(F²) ≤ L(F)`; `≤ χ(𝔽_p²)` | `UpperHalf.chromaticNumber_planeOver_le_localBound`, `…_le_finitePlane` | std3 |
| `χ(ℚ²) = 2`, `χ(ℚ(√11)²) = 4` | `UpperHalf.chromaticNumber_planeOver_rat`, `…_eleven` | std3 |
| `4 ≤ χ(ℚ(√11)²)` (witness) | `four_le_chromaticNumber_planeOver_eleven` | std3 |
| the quadratic table | `ThreeFourColours.chromaticNumber_planeOver_sqrt_table` | std3 |
| four colours from `1/3` | `TorsionExtraction.four_le_…_of_inv_three_mem`, `…_ne_three_of_inv_three_mem`, `four_le_…_fieldOfRadicands`, `four_le_…_of_sqrt_mem` | std3 |
| the three-colour criterion; `χ = L` at `L ≤ 4` | `ThreeFourColours.chromaticNumber_planeOver_eq_three_iff`, `…_le_three_iff`, `…_eq_localBound_of_le_four` | std3 + W |
| the main clause through five (three forms) | `Rigidity.min_localBound_five_le_chromaticNumber`, `…chromaticNumber_planeOver_eq_localBound_of_le_five`, `…min_chromaticNumber_five_eq_min_localBound_five` | std3 + EL + W |
| `χ(ℚ(√47)²) = 5`; `= 5` at 143, 311, 335, ℚ(√3,√5); `≥ 5` at 167 | `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`; `SqrtClassValues.…` (five names) | std3 + EL + W |
| `χ(ℚ(√47)²) ≤ 5` | `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five` | std3 |
| the collapse, general | `Collapse.chromaticNumber_planeOver_eq_plane_of_thick` | std3 + EL |
| the collapse at ℚ(√635087), at ℚ(√3,√5,√7,√11), per place | `Collapse.chromaticNumber_planeOver_sqrt635087`, `…_deGrey`, `…_eq_plane_of_forall_thickAt` | std3 + EL + W |
| `6 ≤ χ(ℚ(√635087)²) ≤ 7` | `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven` | std3 + EL + W + O5 |
| `χ(F(t)²) = χ(F²)` | `RouteC.chromaticNumber_planeOver_adjoin_transcendental_eq` | std3 |
| `χ(UD(ℤ/121, 2)) = 5` | `chromaticNumber_unitQuadrance_zmod121` | std3 |
| three-colouring ⟹ a character in the band | `ThreeColourCharacter.bandSet_three_nonempty_of_proper` | std3 |
| the transfer; the rigidity step (ported) | `Outside.OAI158.proper_to_borel_weak`, `Outside.OAI158.Spectral.residual_fourier` | std3 |
| the `p`-adic bound; no uniform bound | `PadicPlane.one_add_div_le_of_borelColoring`, `…not_exists_bound_borelChromaticNumber_padicPlane`, `…le_borelChromaticNumber_padicPlane` | std3 + W |
| `χ_Bor(ℚ₃²) = 3` | `PadicPlane.borelChromaticNumber_padicPlane_three` | std3 + W |
| `χ_Bor = 4, 5, 5` at 7, 11, 19; `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8` | `PadicPlane.borelChromaticNumber_padicPlane_seven`, `…_eleven`, `…_nineteen`, `five_le_…_twentyThree`, `…_twentyThree_le_eight` | std3 |
| the three declared outside theorems | `Outside.OAI158.no_proper_five_coloring`, `StandingFive.kloosterman_bound`, `Rigidity.positive_entropy_rigidity` | each prints itself (and `propext`) |

Every print agrees with the old README's "rests on" column, and with `CLAUDE.md` § Where the problem stands.

### 2.3 Each result's notation, read against its stored type

The page writes the plane over `F` as `F²` and its chromatic number as `χ(F²)`. The stored form is
`(SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber`, with `planeOver F = {z : ℂ | z.re ∈ F ∧ z.im ∈ F}` and
`unitDistance ℂ` joining points at distance exactly 1 — the unit-distance graph on `F × F`. The readings that needed care:

1. **`L(F)` is level one only.** `localBound F = ⨅ P, (levelTarget P 1).chromaticNumber`, over `StablePrime F` — the maximal ideals
   `P` of the ring of integers of `F(i)` with `conj⁻¹(P) = P` — and `levelTarget P m` is the graph on `𝓞_{F(i)}/P^m` joining `x`, `y`
   when `(x − y)·conj(x − y) = 1`. So the page defines `L(F)` as: the least chromatic number, over the primes of `F(i)` fixed by
   complex conjugation, of the graph on the residue field joining `x` and `y` when `(x − y)` has norm one. The old README's definition
   is this one. The asking lane's reader-facing statement (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3, rank 1, labelled
   "my reading of the kernel's `localBound` (every level `m`, the image of the unit vectors)") is not the kernel's: the kernel reads
   level one and every norm-one residue, not only the images of unit vectors. No consequence for the page, which follows the kernel;
   noted so nobody copies § 3.3's definition onto it. With no stable prime the infimum is `⊤`.
2. **"Some prime of `F` has residue field `𝔽₃`"**: `∃ 𝔭, 𝔭.IsMaximal ∧ Nat.card (𝓞_F ⧸ 𝔭) = 3` — a prime of `F` itself, not of
   `F(i)`; under the hypothesis `¬ Colorable 2`.
3. **The quadratic table**: `m : ℕ` with `Squarefree m`, `ℚ(√m)` as `fieldOfRadicands {m}` = the subfield of `ℝ` generated by `√m`.
   Its four clauses are exactly the old README's. The family clause `four_le_…_fieldOfRadicands` takes `d % 12 = 11` with no
   squarefreeness; `four_le_…_of_sqrt_mem` takes any subfield of `ℝ` holding `√d`.
4. **`1/3 ∈ ℤ[U_F]`**: `3⁻¹ ∈ unitRing F`, the subring of `ℂ` generated by `{z ∈ planeOver F | ‖z‖ = 1}`.
5. **Thickness**: `Thick F c` = for every stable prime `P`, every `m ≥ 1` and every non-trivial additive character `ψ` of `𝓞/P^m`,
   `‖Σ_{s ∈ normOneQ P m} ψ(s)‖ ≤ c · |normOneQ P m|`, where `normOneQ P m = {x | x · conj x = 1}`. The theorem also asks `0 ≤ c`
   and `c < 1/5`. The old README's sentence matches.
6. **`µ₆(ε)`**: `Plane.mu 6 ε` = the supremum, over six measurable pairwise-disjoint sets each of whose pairs at distances in
   `[1 − ε, 1 + ε]` form a null set of `ℂ × ℂ`, of the upper density (about the origin) of their union. It increases as `ε`
   decreases, so the stored `⨆_{ε > 0} µ₆(ε) < 1` is `lim_{ε→0} µ₆(ε) < 1`.
7. **The disc criterion**: `∃ R > 0, ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball 0 R) c`, where a weak colouring on `U` is a Borel map
   whose monochromatic unit pairs inside `U` are null for area × arc length.
8. **`m₁(ℝ²)`** = `⨆` of `upperDensity A` (about the origin) over measurable `A ⊆ ℂ` independent in the unit-distance graph;
   **`α₁`** = `finIndepRatio` = `⨅` over non-empty finite `S` of `α(G[S]) / |S|`; **`f(n)`** = `minIndepNum n` = the least independence
   number over `n`-point sets; **`𝒜²`** = `unitDistance` on `algebraicClosure ℚ ℂ`, the points with algebraic coordinates.
9. **`χ_m⁰`** = `Plane.chiM0`: least `k` with a Borel `ℂ → Fin k` each of whose classes has null unit pairs; **`χ_m`** =
   `Plane.chiLebesgue`: least `k` with a Lebesgue-measurable (null-measurable) `f` that is proper at every unit pair.
10. **The `p`-adic plane**: `padicPlane p = unitQuadrance ℚ_[p]`, the graph on `ℚ_p × ℚ_p` joining `x`, `y` with
    `(x₁ − y₁)² + (x₂ − y₂)² = 1`; `borelChromaticNumber` = least `k` with a colouring all of whose classes are measurable sets. The
    bound is stated for every prime `p ≡ 3 (mod 4)` and every such `k`-colouring: `1 + (p + 1)/(2√p) ≤ k`.
11. **The finite-plane bound** takes a prime `𝔭` of `F` with `|𝓞_F/𝔭| = p` prime and `≡ 3 (mod 4)`.

No statement the page summarizes differs from the page's notation in scope.

### 2.4 Findings

- **F1, confirmed — a correction owed to `LEDGER.md`.** `Outside.OAI158.seven_le_chromaticNumber_plane_iff`,
  `Plane.seven_le_chromaticNumber_plane_iff_exists_ball`, `Plane.colorable_iff_forall_ball` and
  `Plane.chromaticNumber_plane_eq_chiLebesgue` print std3: the transfer they use, `Outside.OAI158.proper_to_borel_weak`, prints std3
  (its proof was ported, `LEAN.md` § Ported outside proofs). Rows 130, 131 and 161 still call it a declared outside theorem (row 130:
  "imported as the outside theorem … holds on the import of that one theorem" and "on the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak`"; row 131: "the declared outside theorem `Outside.OAI158.proper_to_borel_weak` alone"; row
  161: "-DOWN `radius_down` and the two forms of the criterion … each on those three and the declared outside theorem"). The page
  follows the print. Messaged to the coordinator with this stage.
- **F2, F3** (stale counts in the old README) stand as Stage 1 wrote them; the page uses `CLAUDE.md` § Trust ledger's counts.
- **F4** (row 104's stale *Not claimed* clause) stands.
- **F5.** `plans/POROS-2026-10-13-number-field-findings.md` § 3.3's `L(F)` (every level, images of unit vectors) is not the kernel's
  `localBound` (level one, every norm-one residue); § 2.3 item 1. The page uses the kernel's.
- **F6.** `LEDGER.md` row 75, as I read it before the `p`-adic landing, gave `χ_Bor(ℚ₂₃²) ≥ 6` at [cert]; the kernel holds `≥ 5`
  (`five_le_borelChromaticNumber_padicPlane_twentyThree`). The page states the kernel's and names the certificate's `6` as held
  outside the kernel only if the row as now filed still carries it (checked at Stage 3 after the merge).
