# FS131-KN4 — three and four colours over real number fields: the leaf list, the statements, the skeleton, a plan per leaf

*The kernel lane's planner (de Bruijn), 2026-10-13, on branch `fs131-wr2`. Brief: `data/fs131/briefs/FS131-KN4-three-four-colours-plan.md`.
Claim list: `data/fs131/claims-NF4.md`. Working files: `data/fs131/kn4/`. Nothing here is blind (the brief's `fences: none`).*

## Theorems this phase proved

None in the kernel: this is a planning job, and every leaf of its three modules is `sorry`. Three **routes** are this job's and are
findings, each at [hand, one mind, the planner; unchecked by a second]:

- **R-1, the rational layer with no cell list** (§ 2.3): FS81-T3's dichotomy from two integer relations and the bound `6·(1/6) = 1`.
  Checked by exact arithmetic on the four corners and on the bound's tightness (`data/fs131/kn4/layer_check.py`, two plants).
- **R-2, the three-part and the two-part with no Teichmüller section and no weak approximation** (§ 2.5): compose the functional
  with a power of Frobenius; it then lives on the reduced quotient, and the Hilbert-90 set is carried to itself.
- **R-3, Weil's bound covers every residue field from 27 up** (§ 2.5): `TargetFloor 4 Q` for `Q ≡ 3 (mod 4)`, `Q ≥ 14`, by the ten
  lines of `WeilKloosterman.targetFloor_six_of_kloosterman`; the exact checks at 27 and 243 are not needed.

## Stage 1 — SAVED: the readback

### 1.1 The eleven quotations

`data/fs131/kn4/check_quotes.py`: the brief's eleven quoted lines against `data/fs131/claims-NF4.md`, byte for byte — **11 MATCH, 0
mismatches, no claim line unquoted** (exit 0). Control: `--plant` changes `m ≡ 11 (mod 12)` to `(mod 24)` in the claim text in memory;
the check reports `mismatches=1` on NF4-THEOREM and exits 1.

### 1.2 The three clauses, every symbol resolved

| the claim's symbol | the library's declaration | where |
|---|---|---|
| a subfield `F ⊆ ℝ` | `F : Subfield ℝ` | — |
| `F²`, the plane over `F` | `planeOver F : Set ℂ` (`z.re ∈ F ∧ z.im ∈ F`) | `SquareClass.lean:63` |
| `χ(F²)` | `((unitDistance ℂ).induce (planeOver F)).chromaticNumber : ℕ∞` | `UnitDistance.lean:40` |
| `F²` bipartite / has an odd cycle | `((unitDistance ℂ).induce (planeOver F)).Colorable 2` / its negation | Mathlib |
| a unit vector | `SpectralChain.unitVectors F` (`u ∈ planeOver F ∧ ‖u‖ = 1`) | `SpectralChain.lean:62` |
| `ℤ[U_F]`, "integer combinations of unit vectors" | `SpectralChain.unitRing F = UnitRing.unitRingOver F : Subring ℂ`; additive span by `UnitRing.exists_sum_eq_of_mem_unitRingOver` | `UnitRing.lean:151, 201` |
| `1/3 ∈ ℤ[U_F]` | `(3 : ℂ)⁻¹ ∈ unitRing F` | — |
| `ℚ(√m)` | `fieldOfRadicands {m} : Subfield ℝ`, `sqrt_mem_fieldOfRadicands` | `SquareClass.lean:306` |
| a real number field | `F : Subfield ℝ` with `[NumberField F]` | Mathlib |
| "some prime of `F` above 3 has residue field `𝔽₃`" | `∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3` — the form `fs131-wnf`'s `QuadraticPrime.exists_maximal_card_eq` concludes | Mathlib; **no declaration on `main` relates such a prime to `ℤ[U_F]`** |
| `Θ₃(R_F)`, characters with `θ(U_F) ⊆ [1/3, 2/3]` | `CharacterColouring.fieldBandSet F (band 3)` | `Arith/CharacterColouring.lean:57, 84, 248` |
| `T₆`, characters killed by 6 | `CharacterColouring.torsionBy (unitRing F) 6` | `Arith/CharacterColouring.lean:60` |
| a winding | `ThreeColour.Winding s`, from `ThreeColour.nonempty_winding` | `ThreeColour.lean:59, 257` |
| a stable prime; its target; `L(F)` | `SpectralChain.StablePrime F`, `levelTarget P 1`, `localBound F` | `SpectralChain.lean:279–301` |
| the residue target of a finite field | `StandingFive.normOneCayley k σ`, `StandingFive.TargetFloor n Q` | `Arith/StandingFive.lean:1202` |
| Weil's bound | the axiom `StandingFive.kloosterman_bound`; `normOne_charSum_ge`, `targetFloor_of_charSum` | `Arith/WeilKloosterman.lean:51`, `FloorPlanes.lean:374`, `NormOneTarget.lean:117` |

**Missing on `main`, each a leaf below:** the character of a three-colouring (NF4-S6); the layer dichotomy and the torsion extraction
(NF4-S7); a two-colouring as a character with value `1/2`; conjugation on `ℤ[U_F]`, its prime ideals, its finite quotients; and the
dictionary from a maximal ideal of `ℤ[U_F]` to a prime of `𝓞 F` — which needs `fs131-wnf`'s `UpperHalf.exists_stablePrime_of_valuationSubring`
and `StablePrime.residue`, so it is planned in the joining file and not compiled here.

### 1.3 The entries, read where they stand, beside the clause each is cited for

| clause | cited entry | what the entry proves | verdict |
|---|---|---|---|
| (c) | `plans/FS81-derivation.md` T1–T5 (:29–:99) | T5's corollary F-T4: "every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite has `χ(F²) ≥ 4`" | the clause is the entry. T2 and T4 two derivations, T3 two with a computed cell list, T1 one line |
| (a), the lower bound | T5, same corollary: "`χ(ℚ(√d)²) ≥ 4` for every squarefree `d ≡ 11 (mod 12)`" | the clause is the entry; **squarefreeness is not used** (§ 1.4, G-1) | — |
| (a), the values 2 and 3 | not T1–T7: the values are "printed" (`[Fischer1990]`, `[Johnson2000]`); the lower bound `3` at `m ≡ 3 (mod 4)` is the odd closed walk from `1 = 2n − nv − nv̄` (T4's relation) | elementary; a leaf here (`not_colorable_two_of_sqrt_mem`) | — |
| (a), "= 4 … outside the classes 47, 143, 167 (mod 168)" | the upper bounds are `fs131-wnf`'s: at `m ≡ 11 (mod 24)` the dyadic prime is inert in `F(i)/F` with target `Cay(𝔽₄, μ₃) = K₄` (a **stable** prime, NF1-S1B, not a usable one); at `m ≡ 23 (mod 24)` a prime with residue field `𝔽₇` when `m` is a square mod 7 or `7 ∣ m` | the three excluded classes are exactly `m ≡ 23 (mod 24)`, `m ≡ 3, 5, 6 (mod 7)`: checked (`47 ≡ 5`, `143 ≡ 3`, `167 ≡ 6 (mod 7)`) | consistent |
| (b) | `plans/FS91-derivation.md` FS91-J02-T2 (:214), J02-T3 (:244), J09-J4 (:192) | J02-T2 = S1: "`χ(F²) ≤ 3 ⟺ … ⟺` (the two prime types) `⟺ L(F) ≤ 3`, every real number field"; its alias J09's J4-C: "`χ(F²) = 3 ⟺` non-bipartite and a prime above 3 of residue field `𝔽₃`" | the clause is J4-C. J02-T3 (S2) is wider than the clause (it is row 99's `χ = L` at `L ≤ 4`) and J09-J4 (the classification of all of `Θ₃`) is not needed for it |

**T5 carries a correction owed** (`plans/FS81-derivation.md:101`, to `plans/FS91-S0FV-three-colours-blind.md` §2.5, J4-T6): it concerns
T6's open item (additive three-colourings are Fischer's), not T5's statement; nothing in the clauses moves.

### 1.4 Findings of the readback (sent to "main" mid-job)

- **G-1, generalization of (a).** The lower bound needs neither squarefreeness nor that `F` is the quadratic field: **every subfield
  `F ⊆ ℝ` holding `√d` for a natural `d ≡ 11 (mod 12)` has `χ(F²) ≥ 4`** — `1/n = 2 − v − v̄` with `d + 1 = 4n`, `v = ((2n−1) + i√d)/(2n)`,
  and `3 ∣ n`. It is (c) at once, in the shape row 73's `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem` already has at 11.
  Likewise `χ(F²) ≥ 3` for every `F ∋ √d`, `d ≡ 3 (mod 4)`.
- **G-2, the strongest form of (c).** `1/3 ∈ ℤ[U_F]` gives `Colorable 3 → Colorable 2`: **`χ(F²) ≠ 3`**. The claim's "(c)" is this with
  the hypothesis "not bipartite" moved across.
- **G-3, (b) does not need the two-colour classification.** In the ⟹ direction the case "the dyadic part" ends in a character with value
  `1/2` on every unit vector, which *is* a two-colouring; the hypothesis "not bipartite" closes it with no prime above 2 named. The
  outside model's two-colour theorem (GPT Astra's Thm 2.1) is needed only for the form row 127 takes (`localBound F ≤ 4 → localBound F ≤ χ`),
  planned separately (§ 2.6).
- **S-1, Weil.** NF4-RESTS's "row 99's route uses Weil's bound, row 82's uses none" is confirmed from the entries (J02-L4(a) is the one
  use; FS81 T1–T5 use none). The map's "exact at 27, 243" is not needed: R-3.
- **S-2, T3's computed input is not needed**: R-1.
- No clause is wider than its entry. No statement defect found in the claim list.

## Stage 2 — SAVED: the leaf list

Dependency order, from the kernel's present theorems to each clause. `L1.n` are leaves of `Arith/ThreeColourCharacter`, `L2.n` of
`Arith/TorsionExtraction`, `L3.n` of `Arith/ThreeColourCriterion`, `DQ.n` of `Arith/DyadicQuadratic`, `J.n` of the joining module.

```
kernel today: ThreeColour.nonempty_winding · CharacterColouring.{bandSet, band, torsionBy, fieldBandSet, unitSet, inv_five_mem_Qring}
              UnitRing.exists_sum_eq_of_mem_unitRingOver · StandingFive.{kloosterman_bound, normOne_charSum_ge, targetFloor_of_charSum,
              involution_eq_pow, card_normOne, normOneCayley, TargetFloor} · SquareClass.fieldOfRadicands

NF4-S6   L1.1 exists_box_point → L1.2 exists_character_of_box_point → L1.3 exists_character_of_properAlong
         L1.4 isClosed_band, L1.5 bandSet_nonempty_of_finite → L1.6 bandSet_three_nonempty_of_proper
         → L1.7 fieldBandSet_three_nonempty_of_colorable                         (FS73-T22 ⟹, FS81-T2: plans/FS81-derivation.md:39)
NF4-S7   L2.1 layer_step → L2.2 layer_dichotomy → L2.3 tendsto_layer            (FS81-T3 :50, by route R-1)
         → L2.4 exists_torsion_mem_fieldBandSet                                 (FS81-T4 :66; FS91-J02-L1, plans/FS91-derivation.md:171)
(c)      L2.5 colorable_two_iff_fieldBandSet_two_nonempty, L2.6 mem_fieldBandSet_two_of_inv_three_mem
         → colorable_two_of_inv_three_mem → four_le_…_of_inv_three_mem, …_ne_three_…      [compositions, proved]   (FS81-T5 :82)
(a) ≥    L2.7 inv_natCast_mem_unitRing_of_sqrt_mem → L2.8 inv_three_mem_unitRing_of_sqrt_mem; L2.9 not_colorable_two_of_sqrt_mem (over L2.5)
         → three_le_…_of_sqrt_mem, four_le_…_of_sqrt_mem, four_le_…_fieldOfRadicands        [compositions, proved]
(b) ⟹   L3.1 targetFloor_four_weil (Weil) → L3.2 exists_maximal_card_nine              (FS91-J02-L3 :154, L4(a) :175, T1 step 4 :188)
         L3.3 exists_maximal_conj_trivial                                               (FS91-J02-L4(b), T1 step 5)
         L3.4 conj_mem_unitRing (def conjR) · L3.5 exists_unit_mul_conj_eq · L3.6 comap_conjR_eq (FS91-J02-L2(b) :144)
         L3.7 finite_quotient_span_natCast (FS91-J02-L2(a))
         → L3.8 exists_maximal_of_torsion (FS91-J02-T1 ⟹) ; L3.9 fieldBandSet_two_nonempty_of_conj_trivial
         → exists_maximal_card_nine_of_colorable_three                                    [composition, proved]
         L3.10 exists_maximal_conj_trivial_of_colorable_two (GPT Astra Thm 2.1 ⟹; FS91-J02-A21p :266) — for row 99's form only
dyadic   DQ.1 colorable_of_ringHom → DQ.2 colorable_two_planeOver_sqrt, DQ.3 colorable_four_planeOver_sqrt        (Amendment 1)
join     J.1 exists_stablePrime_of_maximal (over fs131-wnf's exists_stablePrime_of_valuationSubring) → J.2 exists_unitSet_residue_eq (NF4-S9 at level one)
         → J.3 exists_maximal_card_three_of_card_nine, J.4 exists_stablePrime_conj_trivial
(b)      J.5 colorable_three_iff (FS91-J02-T2 (1)⟺(4)) → J.6 chromaticNumber_planeOver_eq_three_iff
row 99   J.7 localBound_le_chromaticNumber_or_four_le → localBound_le_chromaticNumber_of_le_four   [proved over J.7]  (FS91-J02-T3 :244)
(a) =    J.8 …_sqrt_eq_three, J.9 …_sqrt_eq_four_of_seven; …_eq_four_of_dyadic, …_sqrt_eq_two      [proved over DQ.2, DQ.3]
         J.10 exists_stablePrime_card_four_sqrt; exists_stablePrime_ramified_sqrt [proved over L3.10, J.4]   (NF4-DYADIC-FOUR, -TWO as worded)
```

**The three shared leaves, placed.** NF4-S6 = L1.1–L1.7 (the claim's "winding gives a character" is L1.1 with L1.2 for finitely many
generators, the only windings the kernel has; all of `U_F` is by L1.5 from the colouring). NF4-S7 = L2.4, as claimed, every `F ⊆ ℝ`.
NF4-S9, corrected by the claim list's dated line to level one = J.2; at higher levels nothing here reads it.

**Already in the library under another name** (searched by shape; what was searched): `band`, `bandSet`, `fieldBandSet`, `torsionBy`
(`Arith/CharacterColouring`; `rg "def bandSet|def band|torsionBy"`) — so `Θ₃`, `Θ₂ = fieldBandSet F (band 2)` and `T₆` need no new
definition; `inv_five_mem_Qring` (the `1/5` of the layer); the Weil floor's ten lines (`targetFloor_six_of_kloosterman`;
`rg "TargetFloor"`); `involution_eq_pow`, `card_normOne` (Hilbert 90's inputs); `fieldOfRadicands`, `sqrt_mem_fieldOfRadicands`;
`finitePlane3_colorable_three`, `finitePlane7_colorable_four`; on `fs131-wnf`: `exists_stablePrime_of_valuationSubring`,
`StablePrime.residue`, `residue_div`, `residue_conj`, `two_mem_of_conj_trivial`, `colorable_planeOver_of_finitePlane`,
`exists_maximal_card_eq_sqrt`, `exists_maximal_card_eq_of_ramified`, `two_le_chromaticNumber_planeOver`. **Not found** (`rg` over
`Proofs/` for `Colorable 2` at a field, `IsUnit.*unitRing`, `conj.*unitRing`, `nilradical`, `quotNilradical`): a two-colouring as a
character; conjugation on `ℤ[U_F]`; anything about its ideals. Mathlib by shape: `geometric_hahn_banach_closed_point`,
`IsCompact.nonempty_iInter_of_directed_nonempty_isCompact_isClosed`, `Module.Baer.of_divisible`, `IsArtinianRing.quotNilradicalEquivPi`,
`Ideal.image_subset_nonunits_valuationSubring` — each `#check`ed under the modules' own imports (`data/fs131/kn4/lean/NameCheck.lean`,
69 names, exit 0, log `data/fs131/kn4/logs/NameCheck.out`).

**Which clause is further.** (c) with (a)'s lower bound: 16 leaves, no outside theorem, no number field — build first; its headline is
the family `[Johnson2000]` p. 176 poses. (b): 10 more in the ring and 6 in the joining module, on Weil's bound, and its last step
waits for `fs131-wnf` on `main`. Row 99's form: one leaf more (J.7) once (b) is in. The dyadic rows (Amendment 1): 3 leaves, the
least derived of the list (§ 4.5).

## Stage 3 — SAVED: the statements typed, read back; the skeleton

**Modules** (each elaborates with `-DautoImplicit=false -DrelaxedAutoImplicit=false`; logs `data/fs131/kn4/logs/<Module>.out`):

| module | leaves (`sorry`) | proved compositions | imports |
|---|---|---|---|
| `Arith/ThreeColourCharacter` | 7 | `exists_character_one_two` | `ThreeColour`, `Arith/CharacterColouring` |
| `Arith/TorsionExtraction` | 9 | `colorable_two_of_inv_three_mem`, `four_le_…_of_inv_three_mem`, `…_ne_three_…`, `three_le_…_of_sqrt_mem`, `four_le_…_of_sqrt_mem`, `four_le_…_fieldOfRadicands` | `Arith/ThreeColourCharacter` |
| `Arith/ThreeColourCriterion` | 10 | `exists_maximal_card_nine_of_colorable_three`; def `conjR` | `Arith/TorsionExtraction`, `Arith/WeilKloosterman` |
| `Arith/DyadicQuadratic` | 3 | — | `Arith/TorsionExtraction` |
| joining text `data/fs131/kn4/lean/ThreeFourColours.lean` (planned; becomes `Arith/ThreeFourColours`) | 10 | `colorable_three_of_card_three`, `localBound_le_chromaticNumber_of_le_four`, `…_eq_four_of_dyadic`, `…_sqrt_eq_two`, `exists_stablePrime_ramified_sqrt` | both lines |

29 leaves in this tree, 10 in the joining text. Rows in `Proofs.lean` and `ARCHITECTURE.md` (`tools/check_architecture.py`: PASS).
**The joining text is elaborated against both lines' skeletons** by `data/fs131/kn4/join_check.sh` (a scratch farm on `fs131-wnf`'s
built library, this line's four modules compiled into it; it writes in neither tree): exit 0, 10 `sorry`.

**The full build.** `scripts/build.sh` was queued under the slot at the skeleton's first elaboration and had not been admitted when
this stage was saved (other lines' builds held the machine: `data/fs131/kn4/logs/build1.err` is the slot's waiting lines). Per-file
elaboration is not the build (`LEAN.md`): the docstring and long-line linters are unread. **Held for the coordinator.**

**Read back aloud, each headline against its claim.**

| claim | Lean | Lean has, claim lacks | claim has, Lean does not need |
|---|---|---|---|
| (c) | `four_le_chromaticNumber_planeOver_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) (hnb : ¬ Colorable 2) : 4 ≤ χ` | nothing. "Integer combination of unit vectors" is read as membership in the subring they generate (equal, `exists_sum_eq_of_mem_unitRingOver`); "has an odd cycle" as `¬ Colorable 2` (the equivalence is König's and is not stated) | — |
| (a) ≥ | `four_le_chromaticNumber_planeOver_fieldOfRadicands (hd : d % 12 = 11) : 4 ≤ χ(ℚ(√d)²)` | nothing | "squarefree" |
| (a) table | four theorems, one per row (joining text) | `Squarefree m` at the rows 2, 3 and 4-through-7 (used: `m ≢ 3 (mod 4)` at `m = 12` is `ℚ(√3)`; `9 ∤ m`, `49 ∤ m` at the ramified clauses); none at the dyadic row. "At least 4 in the classes 47, 143, 167 (mod 168)" is (a) ≥ | the table is not one theorem: each row names the upper half it reads |
| (b) | `chromaticNumber_planeOver_eq_three_iff (F) [NumberField F] (hnb : ¬ Colorable 2) : χ = 3 ↔ ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3` | nothing ("above 3" is implied by three elements) | — |
| NF4-S6 | `fieldBandSet_three_nonempty_of_colorable (F) (h : Colorable 3) : (fieldBandSet F (band 3)).Nonempty` | it starts from the colouring; the winding form is `exists_box_point` for finitely many generators | — |
| NF4-S7 | `exists_torsion_mem_fieldBandSet (F) (h : (fieldBandSet F (band 3)).Nonempty) : ∃ τ ∈ fieldBandSet F (band 3), τ ∈ torsionBy (unitRing F) 6` | nothing | — |
| NF4-S9 (level one) | `exists_unitSet_residue_eq (P) (hle) (ht : t * t̄ = 1) : ∃ u ∈ unitSet F, P.residue 1 ⟨u, _⟩ = t` | `hle`: the ring lies in `𝓞_P` (true at every stable prime; carried so the residue is typed) | — |
| NF4-DYADIC-TWO | `colorable_two_planeOver_sqrt (hm : Squarefree m) (h4 : m % 4 ≠ 3) : Colorable 2`; as worded `exists_stablePrime_ramified_sqrt` | — | — |
| NF4-DYADIC-FOUR | `colorable_four_planeOver_sqrt (h8 : m % 8 = 3) : Colorable 4`; as worded `exists_stablePrime_card_four_sqrt` | wider than "`m ≡ 11 (mod 24)`": every `m ≡ 3 (mod 8)` | — |

**Attribution, in the statements' docstrings** (the words of `LEDGER.md` § The claim list and § B): the lower bound at four and the
three-colour criterion over every real number field — this project's, `[hand]`, "not found in print"; the vector `v` and `1/3 ∈ ℤ[U]`
at `N ≡ −1 (mod 24)` — `[Fischer1990]` Thm 10(ii), Ex. 4; the values 2 and 3 and every upper bound — `[Fischer1990]`, `[Johnson2000]`;
the two-colour classification and `exists_maximal_conj_trivial_of_colorable_two` — an outside model's (GPT Astra), not claimed.

**Models.** Every theorem whose hypothesis is a set or a structure names its inhabitant in its module's docstring; three are named
objects no declaration on this line exhibits (`Θ₃(R_F) ≠ ∅` at `ℚ(√3)`; a three-chromatic number field; `Θ₂` at `ℚ`) and say so —
the landing after the join can exhibit each (`ℚ(√3)` through NF1-S2 at 3 and J.5).

**Modeling passes.** The domain, obligation and experience passes were not run as fresh skill invocations: the budget went to
Amendment 1. What they would have checked was applied by hand at typing: `Θ₂` is `fieldBandSet F (band 2)`, not a new predicate;
finite rings are `{A : Type}` because `TargetFloor` quantifies over `Type`; `conjR` is a `def` over a stated lemma, not a structure;
the abstract theorems carry no field. **Held for the coordinator**: a pass before the implementers start costs one short job.

## Stage 4 — SAVED: a plan per leaf

For an implementer with none of this context. A leaf's size is a guess from its route, not a price (`LEAN.md`: re-price from the
first two leaves). Every name below is in `data/fs131/kn4/lean/NameCheck.lean` unless marked (wnf).

### 4.1 `Arith/ThreeColourCharacter` (implementer A)

- **L1.1 `exists_box_point`** — the one hard leaf here (150–250 lines). (i) `K = (relMap s).ker` is finitely generated
  (`IsNoetherian ℤ (Fin m → ℤ)`, `AddSubgroup.toIntSubmodule`, `Submodule.fg_iff_exists_fin_generating_family`): generators
  `r₁ … r_n`. (ii) `T : (Fin m → ℝ) → (Fin n → ℝ)`, `T x i = Σ_j r_i j · x j − W r_i`; the box is compact convex (`isCompact_univ_pi`,
  `isCompact_Icc`), so is `S = T '' box` (`IsCompact.image`, `Convex.is_linear_image` and a translation). (iii) If `0 ∈ S`: that `x`
  satisfies the generators, hence all of `K` (both sides additive in `r`). (iv) If `0 ∉ S`: `geometric_hahn_banach_closed_point`
  gives `c : Fin n → ℝ` (`LinearMap.pi_apply_eq_sum_univ`) with `Σ_i c_i (r_i · x − W r_i) < 0` on the box. (v) It suffices on the
  `2^m` vertices `x ∈ {1/3, 2/3}^m`; finitely many strict inequalities have slack `ε`, so rationals `q_i` near `c_i`
  (`exists_rat_btwn`) keep them; clear denominators: `r = Σ N_i r_i ∈ K` with `r · x < W r` at every vertex. (vi) `W.minRise_le`
  at `−r`: `3 W r ≤ Σ_j max(r_j, 2 r_j) = 3 (r · x*)` for the vertex `x*_j = 2/3` if `r_j ≥ 0`, else `1/3`. Contradiction.
  *Hard:* the passage ℤ → ℚ → ℝ; keep `c`, `q`, `N` as explicit functions and state step (v) as its own lemma.
- **L1.2 `exists_character_of_box_point`** — `ψ : (Fin m → ℤ) →+ UnitAddCircle`, `r ↦ ↑(Σ r_j x_j)`; `hx` gives
  `(relMap s).ker ≤ ψ.ker` (`AddCircle.coe_eq_zero_iff`); `QuotientAddGroup.lift` with `QuotientAddGroup.quotientKerEquivRange`
  gives the character on `(relMap s).range`; extend to `A` by `Module.Baer.extension_property_addMonoidHom (Module.Baer.of_divisible _)`
  (the instance `DivisibleBy UnitAddCircle ℤ` exists; `CharacterColouring.exists_ratLinear_extension` is the house pattern).
- **L1.3** — `nonempty_winding s hc`, L1.1, L1.2 with `n := W.toHom r`; `band 3` is the image of `Icc (1/3) (1 − 1/3)`.
- **L1.4 `isClosed_band`** — `(isCompact_Icc.image (AddCircle.continuous_mk' 1)).isClosed`.
- **L1.5 `bandSet_nonempty_of_finite`** — in the compact space `M → UnitAddCircle`, for `S : {S : Finset M // ↑S ⊆ U}` the set
  `K_S = {φ | (∀ a b, φ (a + b) = φ a + φ b) ∧ ∀ u ∈ S, φ u ∈ B}` is closed (`isClosed_iInter`, `isClosed_eq`, `continuous_apply`,
  `hB.preimage`), nonempty by `h`, directed downward under union; `IsCompact.nonempty_iInter_of_directed_nonempty_isCompact_isClosed`;
  `AddMonoidHom.mk'`.
- **L1.6** — L1.5 at `band 3` (L1.4); a finite `S ⊆ U` is `s : Fin m → A` by `S.equivFin`; L1.3.
- **L1.7** — `c x := (C ⟨x, _⟩ : Fin 3)` read in `ZMod 3`; for a unit vector `u`, `dist (a + u) a = 1`, so `C.valid` separates.

### 4.2 `Arith/TorsionExtraction` (implementer B; reads L1.7 as stated)

- **L2.1 `layer_step`** — the integers `n₁, n₂` have `|n| ≤ 1` (`abs_le`, `linarith`, then `interval_cases` on the integer). Both
  zero: the rotation, by `linarith` twice. Otherwise each of the four reals is forced to `±1/6` by `linarith` (the bound `6·(1/6)`
  is attained). Eight small cases; `linarith` only (`LEAN.md` on `nlinarith`). Arithmetic checked: `data/fs131/kn4/layer_check.py`.
- **L2.2 `layer_dichotomy`** — if some step `m₀` is not a rotation, L2.1 puts `m₀`, `m₀ + 1` at corners. *Corner forward*: at a
  corner, a rotation step would give a coordinate `7/30` at `m + 1` (four sign cases, `linarith` against `ha (m+1)`, `hb (m+1)`), so
  the step is a corner step. *Corner backward*: from the rotation equations at `m`, `a m = (3a' − 4b')/5`, `b m = (4a' + 3b')/5`,
  again `7/30`. `Int.induction_on` shifted to `m₀`.
- **L2.3 `tendsto_layer`** (150–200 lines). In `unitRing F`: `W = ⟨⟨3/5, 4/5⟩, _⟩` as a unit with inverse its conjugate,
  `I' = ⟨Complex.I, _⟩`; identities `(2 − I') W = 2 + I'`, `inv5 F = W + W⁻¹ − 1`. `g m = W^m · b`, `I' g m` are unit vectors.
  Lifts `a m`, `bb m ∈ [−1/6, 1/6]` of `θ(g m) − 1/2`, `θ(I' g m) − 1/2` (`Classical.choose` on `band 3`). `θ` of the identity
  times `g m`, and of `I'` times it, give `h1`, `h2` of L2.2. *Rotation:* by induction on `k`, `θ(inv5^k g m) = ↑(1/2 + a m / 5^k)`
  (from `inv5 · g m = g (m+1) + g (m−1) − g m` and `a (m+1) + a (m−1) − a m = a m / 5`); so the limit is `↑(1/2)`
  (`tendsto_pow_atTop_nhds_zero_of_lt_one`, `AddCircle.continuous_mk'`). *Corners:* `3 • θ(inv5^k g m) = 0` by the same induction;
  `inv5^(2n) b − inv5^(2n+2) b = 24 · inv5^(2n+2) b`, so the sequence is constant at `θ b ∈ {↑(1/3), ↑(2/3)}`.
- **L2.4** — the set of `x` along which `θ(inv5^(2n) x)` converges is an additive subgroup holding the unit vectors (L2.3), hence
  everything (`UnitRing.exists_sum_eq_of_mem_unitRingOver`); `τ` is the limit (`tendsto_nhds_unique`, `Filter.Tendsto.add`); its
  values on unit vectors are `1/2, 1/3, 2/3`, in `band 3` and killed by 6.
- **L2.5** (120–180 lines) — ⟸: colour `z` by `τ(z − rep z)`, `rep` a representative of the coset of `ℤ[U_F]` in `ℂ`
  (`Quotient.out`); adjacent points share a coset and differ by `1/2`. ⟹: `f x = C x − C 0` in `ZMod 2` satisfies
  `f (x + u) = f x + 1`, so is additive (induct on a representation `y = Σ u_j`); compose with `ZMod 2 →+ UnitAddCircle`, `1 ↦ ↑(1/2)`.
- **L2.6** — `u = 3 • (⟨3⁻¹, h3⟩ * u)`, so `2 • τ u = 6 • τ (…) = 0`; `τ u = ↑t`, `t ∈ [1/3, 2/3]`, `2t ∈ ℤ`, so `t = 1/2`.
- **L2.7** — mirror `UnitRing.lean:261–272`: `v = ⟨(2n−1)/(2n), √d/(2n)⟩` and its conjugate are unit vectors of `F²`
  (`Real.sq_sqrt`, `d = 4n − 1` cast), `(n : ℂ)⁻¹ = 2 − v − v̄` (`Complex.ext`). State the identity as its own lemma: L2.9 reads it.
- **L2.8** — `d % 12 = 11` gives `n = 3k`; `(3 : ℂ)⁻¹ = k · (n : ℂ)⁻¹`.
- **L2.9** — L2.5 ⟹ gives `τ = ↑(1/2)` on unit vectors; `τ` of `1 = 2n·1 − n·v − n·v̄` reads `↑(1/2) = 0`.

### 4.3 `Arith/ThreeColourCriterion` (implementer C; reads L1.7, L2.4, L2.5 as stated)

- **L3.1 `targetFloor_four_weil`** — `WeilKloosterman.lean:138–154` with `6 → 4`: `Real.sqrt Q < (Q + 1)/4` from `14 ≤ Q`
  (`(Q+1)² − 16Q = Q² − 14Q + 1 > 0`), `targetFloor_of_charSum 4 Q (m := 2 * Real.sqrt Q)`, `normOne_charSum_ge`,
  `kloostermanBound_of_ringChar_ne_two`, `ringChar_ne_two_of_card_mod_four`.
- **L3.2 `exists_maximal_card_nine`** — the module's hard leaf (250–400 lines; share (a)–(d) with L3.3 as helper lemmas).
  (a) Some `e = 3^M` has `x^e = 0` on the nilradical (`IsArtinianRing.isNilpotent_nilradical`); `x ↦ x^e` is a ring endomorphism
  (`iterateFrobenius`), so `l' = l ∘ (·)^e` descends to `A ⧸ nilradical A`. (b) Units of the quotient lift to units
  (`IsNilpotent.isUnit_quotient_mk_iff`); `c` descends; `(x · c x⁻¹)^e` is again of that form, so `l'` never vanishes on
  `{x̄ · c̄ x̄⁻¹}`. (c) `IsArtinianRing.quotNilradicalEquivPi`: the quotient is `∀ 𝔪, A ⧸ 𝔪`; `c` acts factor by factor (`hmax`,
  `Ideal.quotientMap`); `l' = Σ_𝔪 λ_𝔪`. (d) In a factor `k` with `c̄ ≠ id`: `Nat.card k = Q²` for some `Q` (the argument inside
  `involution_eq_pow`; `FloorPlanes.exists_ringHom_pow` is the converse — check `Arith/StandingFive.lean:1164` for a lemma that
  already produces `Q`), `c̄ = (·)^Q`, and every `t` with `t · c̄ t = 1` is `y · c̄ y⁻¹` (cyclic `kˣ`, order `(Q−1)(Q+1)`). Here every
  factor has `c̄ ≠ id`: `ῑ ≠ −ῑ` in characteristic 3. (e) If every factor had a norm-one zero of `λ_𝔪`, the tuple would be a zero of
  `l'`: so some `λ_𝔪₀` never vanishes on norm-one elements — a proper colouring `x ↦ λ_𝔪₀ x` of `normOneCayley k c̄` with 3 colours.
  (f) `Q % 4 = 3`: `ῑ^Q = −ῑ`, so `ῑ^(Q−1) = −1` with `ῑ` of order 4. `Q ≥ 14` contradicts L3.1; `Q < 14`, `Q % 4 = 3`, `3 ∣ Q`
  leave `Q = 3`. *Hard:* (c)–(d), the bookkeeping of the product of fields; no step is deep.
- **L3.3 `exists_maximal_conj_trivial`** — (a)–(d) at `p = 2`. If every factor had `c̄ ≠ id`: `l' = 1` on the product of norm-one
  groups makes each `λ_𝔪` constant `e_𝔪` on its group `μ_{Q+1}`, which sums to `0` (`FiniteField.sum_subgroup_units_eq_zero`) and
  has odd order, so `e_𝔪 = 0` for all `𝔪` and `l' 1 = 0 ≠ 1`.
- **L3.4** — `Subring.closure_le`: the generators' conjugates are generators. **L3.5** — `u = a/ā`, a unit vector;
  `div_mul_cancel₀`. **L3.6** — for `a ∈ 𝔮`, `a = u · ā` with `u` a unit of the ring, so `ā ∈ 𝔮` (`Ideal.IsPrime.mem_or_mem`,
  `Ideal.eq_top_of_isUnit_mem`); the other inclusion by `conjR ∘ conjR = id`.
- **L3.7 `finite_quotient_span_natCast`** (80–150 lines) — any `N^d + 1` elements of the ring, `d = finrank ℚ (fieldI F)`, span a
  finitely generated torsion-free group `G`, free of rank `≤ d` (`LinearIndependent.iff_fractionRing`); two of them agree in
  `G/NG`, so in the quotient. The fiddliest routine leaf; an implementer who finds a Mathlib lemma for "finite rank, so `M/NM`
  finite" should use it.
- **L3.8 `exists_maximal_of_torsion`** (200–300 lines) — `τ₂ = 3 • τ`, `τ₃ = 4 • τ`; `A₂ = R ⧸ (2)`, `A₃ = R ⧸ (3)` finite (L3.7)
  with conjugation (`Ideal.quotientMap`) fixing maximal ideals (L3.6); `l₂ : A₂ →+ ZMod 2`, `l₃ : A₃ →+ ZMod 3` from `τ₂`, `τ₃`
  (a helper: a character killed by `p` is a `ZMod p`-valued map followed by `ZMod p ↪ UnitAddCircle`). For units `x₂`, `x₃` the
  lift `a = 3a₂ − 2a₃` and `u` of L3.5 give a unit vector reducing to `(x₂ c̄ x₂⁻¹, x₃ c̄ x₃⁻¹)`; on it `(τ₂, τ₃)` is `(1/2, 0)` or
  `(0, ±1/3)`. Pair with `x₂ = 1`: if `l₂ 1 = 0`, `l₃` never vanishes on `{x c̄ x⁻¹}` — L3.2 at `A₃` (`ι` the image of `i`), and the
  ideal pulls back with the same quotient; if `l₂ 1 = 1`, pair with `x₃ = 1` — L3.3 at `A₂`. Trivial quotients: both cannot be
  (`τ 1 = 6 τ (1/6) = 0` is not in the band); a trivial one sends its `l` to `0`, which selects the other case.
- **L3.9** — `conjR I' − I' = −2I'`, so `2 ∈ 𝔪`; `u · ū = 1` and `ū ≡ u` give `(u − 1)² ≡ 0`, `u ≡ 1`; a `ZMod 2`-linear functional
  on `R ⧸ 𝔪` with value 1 at 1 (`LinearMap.exists_leftInverse_of_injective`), then `1 ↦ ↑(1/2)`.
- **L3.10** — L2.5 ⟹ gives `τ`; `A₂` is nontrivial (`τ 1 = ↑(1/2)` is not twice a value in `{0, ↑(1/2)}`); `l₂` from `τ`;
  L3.3; pull back.

### 4.4 The joining module (implementer D, after both lines are on `main`)

- **J.1** — `Ideal.image_subset_nonunits_valuationSubring` (its conclusion: `A ≤ B.toSubring ∧ A.subtype '' I ⊆ B.nonunits`) at
  `ℤ[U_F]` as a subring of `fieldI F` and `I = 𝔪`; `B` holds the unit vectors, so is conjugation-stable
  (`UnitRing.normOne_subset_iff_stable`); `B ≠ ⊤` by `hne`; (wnf) `exists_stablePrime_of_valuationSubring`. The kernel of the
  residue on the ring is a proper ideal over `𝔪`, so it is `𝔪`. **`hne` is needed**: were `ℤ[U_F]` a field the statement fails.
- **J.2** — if conjugation is not the identity on `κ = 𝓞 ⧸ P`: `t = y/ȳ` (L3.2(d)), `y = mk a`, `u = a/ā`, (wnf) `residue_div`,
  `residue_conj`. If it is: `t² = 1`, `2 ∈ P` ((wnf) `two_mem_of_conj_trivial`), `t = 1`, `u = 1`.
- **J.3** — `3 ∈ 𝔪`, so `hne`; J.1; `R ⧸ 𝔪 ↪ κ`; by J.2 the `Q + 1` norm-one elements of `κ` (`card_normOne`; `ī ≠ i` in
  characteristic 3) lie in a 9-element subfield, so `Q = 3`; `𝔭 = P ∩ 𝓞 F` is maximal (`Ideal.isMaximal_comap_of_isIntegral_of_isMaximal`)
  and `𝓞 F ⧸ 𝔭` lands in the fixed field of conjugation: three elements.
- **J.4** — `2 ∈ 𝔪`; J.1; if conjugation moved some `y ∈ κ`, `t = y/ȳ ≠ 1` would be the residue of a unit vector (J.2), which is
  `1` modulo `𝔪` (L3.9's step).
- **J.5, J.6** — compositions: `exists_maximal_card_nine_of_colorable_three`, J.3, `colorable_three_of_card_three`.
- **J.7** — not three-colourable: `4 ≤ χ`. Two-colourable: L3.10, J.4; `levelTarget P 1` is a matching (`x − y = 1`), two-coloured
  by a functional; `2 ≤ χ` (wnf). Three and not two: the prime of J.3 has `κ` of nine elements; an additive `κ → ZMod 3` with
  `1, ῑ ↦ 1` never vanishes on `{±1, ±ῑ}`: `levelTarget P 1` is three-colourable.
- **J.8, J.9** — (wnf) `exists_maximal_card_eq_sqrt` at `p = 3` (`m ≡ 1`) and `p = 7` (`m ≡ 1, 2, 4`: `1², 3², 2²`),
  `exists_maximal_card_eq_of_ramified ∅ m` at `3 ∣ m`, `7 ∣ m` (squarefree gives `p² ∤ m`); lower halves from § 4.2.
- **J.10** — the ring homomorphism of DQ.3 kills 2, so `1/2 ∉ ℤ[U_F]`; (wnf) `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`
  gives a stable `P ∋ 2`; `𝓞 ⧸ (1+i) ≅ (1+i)𝓞 ⧸ 2𝓞` and `|𝓞 ⧸ 2𝓞| = 16` give `|𝓞 ⧸ P| ≤ 4`; two elements would make conjugation
  trivial and the plane two-colourable, against L2.9.

### 4.5 `Arith/DyadicQuadratic` (Amendment 1) — the least derived leaves; **a route, one mind, sketched**

- **DQ.1 `colorable_of_ringHom`** — L2.5 ⟸'s coset colouring with `φ` for `τ`: a unit vector is a unit of the ring, so `φ u ≠ 0`.
- **DQ.2, DQ.3** — the docstring's route: an order `𝓞' ⊂ F(i)` stable under conjugation holding `π = 1 + i` (`π̄ = −iπ`,
  `π² = 2i`), a conjugation-stable prime `𝔮 ∋ π` at which `π` is a uniformizer; then every unit vector lies in the localization at
  `𝔮`, which maps onto the finite field `𝓞'/𝔮`. By class: `m ≡ 3 (mod 8)`: `𝓞' = ℤ[i, ρ]`, `ρ = (1 + i√m)/2`,
  `𝓞'/π = 𝔽₂[X]/(X² + X + 1)`, four elements (DQ.3; non-squarefree `m` only changes `ρ`'s constant term's parity argument: use
  `(1 + m)/4` odd). `m ≡ 1 (mod 4)`: `𝓞' = ℤ[i, (1 + √m)/2]`, `𝓞'/π = 𝓞_F/2` is reduced and conjugation is the identity on it, so
  unit vectors map to `1`. `m ≡ 2 (mod 4)`: `ℤ[i, √m]` is not enough — `η = √m(1 + i)/2` is integral — and the uniformizer is
  `η − 1` (`(η − 1)(η + 1) = η² − 1`, `η² = (m/2) i`); **this case is sketched only**. *Not checked beyond these lines; no second
  mind.* **Recommendation:** a deriver's page on the three classes (or a planner's second pass) before an implementer starts; the
  statements themselves are prior art and are not in doubt. If the order's bookkeeping proves long, the fallback is (wnf)'s
  `StablePrime` built from a ring homomorphism `𝓞 (fieldI F) → 𝔽₄` or `→ ZMod 2`.

### 4.6 The split, and what the landing needs

- **Four implementers, no shared file**: A (`ThreeColourCharacter`), B (`TorsionExtraction`), C (`ThreeColourCriterion`),
  and DQ's (`DyadicQuadratic`) — each reads upstream leaves as stated. With two: A then C; B then DQ. D (the joining module)
  starts when both lines are on `main`; it copies `data/fs131/kn4/lean/ThreeFourColours.lean` to
  `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean`.
- **The landing**, after them: the full build; `scripts/Axioms.lean` — CLEAN records for every theorem of `ThreeColourCharacter`,
  `TorsionExtraction`, `DyadicQuadratic` and for `exists_maximal_conj_trivial`, `fieldBandSet_two_nonempty_of_conj_trivial`,
  `exists_maximal_conj_trivial_of_colorable_two`; **IMPORTED** (on `StandingFive.kloosterman_bound`) for `targetFloor_four_weil`,
  `exists_maximal_card_nine`, `exists_maximal_of_torsion`, `exists_maximal_card_nine_of_colorable_three`, and in the joining module
  J.3 (no: J.3 is clean), J.5, J.6, J.7 and the row at 3 if it is proved through J.5 (it need not be); `ARCHITECTURE.md` § Trust's
  consumer list for the import; `dupnames.sh` on the joined tree (`unitRing`-named lemmas exist in `UnitRing`, `SpectralChain`,
  `CharacterColouring`: every new name here was chosen against `rg`); the vacuity scan (these modules' hypotheses are sets and maps
  under predicates it does not track: name the models of § Stage 3 in the landing's record); `assumptions.sh` — **no new
  hypothesis former**; after J.7, `inline:Row99` of `SpectralChain.min_localBound_five_le_chromaticNumber` is discharged by
  `localBound_le_chromaticNumber_of_le_four` and its sites leave the ledger; a statement dump before the first rebuild and after
  the last (`LEAN.md`, FS124-L2's pattern).

### 4.7 Outside statements

One: **Weil's bound for Kloosterman sums**, `[Weil1948]` p. 207, already declared (`StandingFive.kloosterman_bound`), read by L3.1
alone, so by clause (b)'s direction toward the prime and by row 99's form; clause (c), clause (a), NF4-S6, NF4-S7 and the dyadic rows
read none. The entries' exact checks at `q = 27, 243` are not needed (R-3). No other printed statement is read by a leaf; Chevalley's
domination is Mathlib's.

### 4.8 Drafts for files this job does not write

- **`LEDGER.md` row 82**, when § 4.1–4.2 land: regrade `[hand, two independent derivations]` to kernel-checked on the standard
  three axioms, address `TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`,
  `four_le_chromaticNumber_planeOver_of_sqrt_mem`; add: "every subfield of `ℝ` holding `√d`, `d ≡ 11 (mod 12)`; where
  `1/3 ∈ ℤ[U_F]`, `χ(F²) ≠ 3`".
- **Row 79**: its ⟹ in character form becomes kernel-checked (`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`).
- **Row 99**, after the join: "`χ(F²) = 3` iff not bipartite and a prime of residue field `𝔽₃`" and "`L(F) ≤ 4 ⟹ L(F) ≤ χ(F²)`"
  kernel-checked on one declared outside theorem (Weil); `inline:Row99` discharged. **Row 73**: `χ(ℚ(√11)²) = 4` is then also the
  dyadic row at `m = 11`.
- **The sentence a reader of the repository would be told**: "For a real quadratic field `ℚ(√m)`, `m` squarefree, the plane needs
  2 colours when `m ≢ 3 (mod 4)`, 3 when `m ≡ 3, 7 (mod 12)`, and 4 when `m ≡ 11 (mod 12)` unless `m ≡ 47, 143, 167 (mod 168)`,
  where it needs at least 4; and a real number field's plane needs exactly three colours iff it is not bipartite and some prime
  of the field has residue field `𝔽₃` — kernel-checked, the second on Weil's bound. The values 2 and 3 and every upper bound are
  Fischer's and Johnson's; the lower bound at four and the three-colour criterion are this project's."
- **`LEAN.md` § Searching — Lean**: "`lean -o` wants its input under the working directory: a farm that compiles one tree's module
  against another tree's library takes its `LEAN_PATH` from the library's tree and runs from the module's
  (`data/fs131/kn4/join_check.sh`)."
