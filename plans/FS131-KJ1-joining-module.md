# FS131-KJ1 — the joining module of the three-and-four-colours line: the join, the added statements, the attributions, the leaves

*The kernel lane's planner (de Bruijn), who in this job also proves what it states; 2026-10-13, branch `fs131-wj1`, cut from
`fs131-wrc` at `cd657318f` in the worktree `.claude/worktrees/fs131-wrc`. Brief: `data/fs131/briefs/FS131-KJ1-joining-module.md`.
Claim list: `data/fs131/claims-NF4.md`. Working files: `data/fs131/kj1/`. Nothing here is blind (the brief's `fences: none`).*

## Theorems this phase proved

Every line is **[kernel] on branch `fs131-wj1`, not through the gate** (the audit, the scans and the doubled-name check on
the joined tree are the landing's): proved, built by `scripts/build.sh` (the fourth build, exit 0, no warning), and its axioms
printed from the compiled module (`data/fs131/kj1/logs/axioms-final.txt`). Namespace `HadwigerNelson.` before each name.
"std3" is `[propext, Classical.choice, Quot.sound]` or fewer; "Weil" is those and the declared outside theorem
`StandingFive.kloosterman_bound`.

*The ten planned leaves of `Arith/ThreeFourColours`, statements unchanged:*
- `ThreeFourColours.exists_stablePrime_of_maximal` (J.1) — std3
- `ThreeFourColours.exists_unitSet_residue_eq` (J.2; NF4-S9 at level one) — std3
- `ThreeFourColours.exists_maximal_card_three_of_card_nine` (J.3) — std3
- `ThreeFourColours.exists_stablePrime_conj_trivial` (J.4) — std3
- `ThreeFourColours.colorable_three_planeOver_iff` (J.5) — Weil
- `ThreeFourColours.chromaticNumber_planeOver_eq_three_iff` (J.6; NF4-THEOREM (b) as claimed) — Weil
- `ThreeFourColours.localBound_le_chromaticNumber_or_four_le` (J.7; row 99's lower half) — Weil
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three` (J.8) — std3
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven` (J.9) — std3
- `ThreeFourColours.exists_stablePrime_card_four_sqrt` (J.10; NF4-DYADIC-FOUR as worded) — std3

*The planned compositions, now free of the unproved dependency:* `colorable_three_of_card_three`,
`chromaticNumber_planeOver_sqrt_eq_four_of_dyadic`, `chromaticNumber_planeOver_sqrt_eq_two`,
`exists_stablePrime_ramified_sqrt` (NF4-DYADIC-TWO as worded) — std3; `localBound_le_chromaticNumber_of_le_four` — Weil.

*Added in `Arith/ThreeFourColours` (16):* `exists_stablePrime_card_nine`, `exists_maximal_card_three_of_stablePrime_card_nine`,
`levelTarget_colorable_two_of_ramified`, `levelTarget_colorable_three_of_card_nine`, `colorable_three_planeOver_sqrt`,
`chromaticNumber_planeOver_sqrt_eq_three_of_mod`, `colorable_four_planeOver_sqrt_of_seven`,
`chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod`, `chromaticNumber_planeOver_sqrt_eq_four`,
`chromaticNumber_planeOver_sqrt_table` (NF4-THEOREM (a), the whole table), `chromaticNumber_planeOver_sqrt_three`,
`fieldBandSet_three_nonempty_sqrt_three`, `exists_maximal_conj_trivial_sqrt_two` — std3;
`chromaticNumber_planeOver_eq_localBound_of_le_four` (row 99: `χ = L` for `L ≤ 4`),
`chromaticNumber_planeOver_le_three_iff` (row 99: `χ ≤ 3 ⟺ L ≤ 3`), `exists_maximal_card_nine_sqrt_three` — Weil.

*Added in the four proved modules (6), each std3:* `TorsionExtraction.colorable_two_of_fieldBandSet_three_nonempty`,
`TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem`,
`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing`,
`ThreeColourCharacter.bandSet_three_nonempty_zmod_five`, `DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four`,
`DyadicQuadratic.mod_four_of_squarefree`.

*New module `Instances/UpperHalfCorollaries` (4), each std3:* `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two`,
`UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `UpperHalf.chromaticNumber_planeOver_sqrt_247_le_five`,
`UpperHalf.two_notMem_stablePrime_seven`.

*Made kernel theorems of one tree by the join (proved by FS131-IC1, -IT1, -IN1, -ID1 on four branches; this job proved
none of them):* the 55 public records of `Arith/ThreeColourCharacter` (9), `Arith/TorsionExtraction` (18),
`Arith/ThreeColourCriterion` (17) and `Arith/DyadicQuadratic` (11) as they stood — 50 std3, 5 Weil — among them
NF4-THEOREM (c) (`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`,
`chromaticNumber_planeOver_ne_three_of_inv_three_mem`) and clause (a)'s lower bound
(`four_le_chromaticNumber_planeOver_of_sqrt_mem`, `…_fieldOfRadicands`), std3.

Nothing here is new mathematics beyond what the claim list holds at `[hand]`: every value and every upper bound is prior
art (stage 4); what is this project's — the lower bound at four, the three-colour criterion, row 99's lower half — was
derived by hand before this job. The routes of J.7's two colourings and of J.10's count are this job's.

## Stage 1 — SAVED: the readback

### 1.1 The thirteen quotations

`data/fs131/kj1/check_quotes.py` (the last implementer's checker with this brief's path): each run of `> ` lines ending in a
`> — source:` line must occur byte for byte in its source, read from the main checkout. **13 MATCH, 0 bad**
(`data/fs131/kj1/logs/check_quotes.out`: one from `data/fs131/REQUEST-2026-10-13.md`, seven from `data/fs131/claims-NF4.md`, five from
`plans/FS131-close-inventory.md`). Control, `--plant` (one token of each quotation changed in memory): 13 of 13 planted quotations
mismatch (`logs/check_quotes.plant.out`). No finding about the brief.

### 1.2 The public statements of the four modules, each beside what it answers

Read from the four branches' heads as text (`data/fs131/kj1/heads.py`, a reading aid: the head of each public declaration up to its
`:=`); the kernel's reading of each is stage 2's print from the built tree.

| module (branch) | declaration | answers |
|---|---|---|
| `Arith/ThreeColourCharacter` (`fs131-wc1`) | `exists_int_vector_of_forall_neg`, `ThreeColour.Winding.exists_box_point`, `exists_character_of_box_point`, `exists_character_of_properAlong`, `isClosed_band`, `bandSet_nonempty_of_finite`, `bandSet_three_nonempty_of_proper` | NF4-S6's steps (a winding gives a box point gives a character; all of a step set by compactness). The last is the criterion's forward half for **any** abelian group and step set — item 685's second generalization is this statement as typed |
| | `fieldBandSet_three_nonempty_of_colorable (F) (h : Colorable 3) : (fieldBandSet F (band 3)).Nonempty` | NF4-S6 at the plane (FS81-T2); starts from the colouring where the claim starts from a winding |
| `Arith/TorsionExtraction` (`fs131-wr2`) | `layer_step`, `layer_dichotomy`, `tendsto_layer`, `exists_torsion_mem_fieldBandSet` | NF4-S7 (FS91-J02-L1), every subfield of `ℝ` |
| | `exists_zmod_hom_of_mem_torsionBy`, `colorable_two_iff_fieldBandSet_two_nonempty`, `mem_fieldBandSet_two_of_inv_three_mem` | the steps of clause (c) |
| | `colorable_two_of_inv_three_mem`, `four_le_chromaticNumber_planeOver_of_inv_three_mem`, `chromaticNumber_planeOver_ne_three_of_inv_three_mem` | NF4-THEOREM (c), and its dated widening G-2 (`χ(F²) ≠ 3`) |
| | `inv_natCast_mem_unitRing_of_sqrt_mem`, `inv_three_mem_unitRing_of_sqrt_mem`, `not_colorable_two_of_sqrt_mem`, `three_le_…_of_sqrt_mem`, `four_le_…_of_sqrt_mem`, `four_le_…_fieldOfRadicands` | NF4-THEOREM (a)'s lower bounds in the dated widening G-1 (no squarefreeness, any subfield holding `√d`); row 82's family clause |
| `Arith/ThreeColourCriterion` (`fs131-wrc`) | `targetFloor_four_weil`, `exists_mul_conj_inv_eq_of_mul_conj_eq_one`, `exists_normOne_zero_of_card_ne_nine`, `eq_zero_of_forall_normOne_eq`, `exists_maximal_card_nine`, `exists_maximal_conj_trivial` | row 99's missing leaf 6 (norm-one functionals), the three widened by the dated lines of 20:28 and 20:32 as the claim list has them |
| | `conj_mem_unitRing`, `conjR`, `exists_unitSet_mul_conjR_eq`, `comap_conjR_eq`, `finite_quotient_span_natCast` | row 99's missing leaf 5 in the form route R-2 needs (no weak approximation) |
| | `exists_maximal_of_torsion`, `fieldBandSet_two_nonempty_of_conj_trivial`, `exists_maximal_card_nine_of_colorable_three` | NF4-THEOREM (b), from a colouring as far as a maximal ideal of `ℤ[U_F]` with nine elements in its quotient (Weil) |
| | `exists_maximal_conj_trivial_of_colorable_two` | row 99's missing leaf 2 at the ring's level (the outside model's two-colour theorem, toward the prime); not claimed as ours (NF4-NC) |
| `Arith/DyadicQuadratic` (`fs131-wdq`) | `colorable_planeOver_of_addMonoidHom`, `exists_rat_add_mul_sqrt_eq`, `exists_int_solution_of_mem_unitVectors`, the three `dyadic_shape_*`, the three `exists_addMonoidHom_*` | the steps of the two dated statements NF4-DYADIC-TWO, -FOUR |
| | `colorable_two_planeOver_sqrt (hm : Squarefree m) (h4 : m % 4 ≠ 3)`, `colorable_four_planeOver_sqrt (h8 : m % 8 = 3)` | NF4-DYADIC-TWO, NF4-DYADIC-FOUR in their kernel form: the upper halves (prior art, NF4-NC) |

Nothing in the four modules answers a claim line that the table leaves out, and no claim line is without a statement except those
the joining module holds: clause (b) as worded, the table of clause (a) as values, row 99's form, NF4-S9 at level one, and the two
dyadic statements "as worded" (a prime, not a colouring).

### 1.3 The ten joining leaves, read against their plans (KN4 § 4.4 as amended by KN5)

| leaf | statement (the planned text's name) | the plan | read |
|---|---|---|---|
| J.1 | `exists_stablePrime_of_maximal` | Chevalley's domination for `ℤ[U_F] ⊆ F(i)` and the ideal, then `exists_stablePrime_of_valuationSubring` | a proof, not a composition: the ring as a subring of `fieldI F` (the library's `unitRingToFieldI` is additive only), `B ≠ ⊤` from `hne`, stability from the unit vectors, and the kernel of the residue on the ring identified with `𝔪` |
| J.2 | `exists_unitSet_residue_eq` (NF4-S9 at level one) | Hilbert 90 in the residue field, `u = a/ā`, `residue_div`, `residue_conj`; the ramified case by `t² = 1` | a proof: a field structure on `𝓞 ⧸ P ^ 1`, two cases |
| J.3 | `exists_maximal_card_three_of_card_nine` | J.1, J.2, a count (`Q + 1 ≤ 9`), the prime below | a proof, the longest of the four; **it holds a stable prime with nine elements in its quotient and does not state it** |
| J.4 | `exists_stablePrime_conj_trivial` | J.1, J.2, and `u ≡ 1` | a proof, short over J.1 and J.2 |
| J.5 | `colorable_three_planeOver_iff` | composition | composition |
| J.6 | `chromaticNumber_planeOver_eq_three_iff` | composition | composition |
| J.7 | `localBound_le_chromaticNumber_or_four_le` | three cases; two colourings of level targets | **reads what J.3 does not state** (the stable prime of nine elements), and two colourings of a `levelTarget` that no declaration of the library holds (searched: `rg "levelTarget .*Colorable|localBound .* ≤ [0-9]"` over `Proofs/` finds no upper bound on a level target but the rational plane's) |
| J.8 | `chromaticNumber_planeOver_sqrt_eq_three` | the two prime lemmas at 3; the lower half | composition; **squarefreeness is read only at `3 ∣ m`** (`m = 99` is `ℚ(√11)`, value 4) — at `m ≡ 7 (mod 12)` the statement holds for every `m` |
| J.9 | `chromaticNumber_planeOver_sqrt_eq_four_of_seven` | the two prime lemmas at 7 | composition; squarefreeness read only at `7 ∣ m` |
| J.10 | `exists_stablePrime_card_four_sqrt` | `1/2 ∉ ℤ[U_F]` from the additive map; a stable prime over 2; `|𝓞/2𝓞| = 16` | a proof: it needs `[F(i) : ℚ] ≤ 4` for `F = ℚ(√m)`, which no declaration states for a general field (`StandingFive.finrank_fieldI_le` is for one field) |

**Findings of the readback.**

- **K-1 (a statement a call site needs).** J.7's case "three colours and not two" needs a stable prime whose quotient has nine
  elements; J.3 concludes only the prime of `𝓞 F` below it. The stronger statement — a stable prime `P` with
  `Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = 9` — is what J.3's proof builds, so it is stated (stage 3) and J.3 is its corollary.
- **K-2 (the brief's premise, measured against the text).** Four of the ten leaves are compositions (J.5, J.6, J.8, J.9). J.1–J.4
  are proofs of some tens of lines each over the residue module's API; J.7 and J.10 each need a fact the library does not hold
  (two colourings of level targets; a degree bound). The order of work in stage 5 follows from this: the compositions first, then
  J.1, J.2, J.4, J.3, then J.7, J.10 — and a leaf left open is handed back with its plan.
- **K-3 (generalizations of the table's rows).** The row at 3 holds at `m ≡ 7 (mod 12)` with no squarefreeness, and at
  `m ≡ 3 (mod 12)` with `9 ∤ m` in its place; the row at 4 through a prime above 7 likewise (`m` a nonzero square modulo 7: no
  hypothesis; `7 ∣ m`: `49 ∤ m`). Each is typed in the wider form with the planned statement as its corollary (stage 3).
- **K-4 (the table as one sentence).** The claim's "4 for `m ≡ 11 (mod 12)` outside the classes 47, 143, 167 (mod 168)" is two
  planned theorems and no statement in the claim's own words; the excluded classes are exactly `m ≡ 23 (mod 24)` with `m` a
  non-square modulo 7 (`47 ≡ 5`, `143 ≡ 3`, `167 ≡ 6`). One corollary in the claim's words is added (stage 3).
- No statement defect found in the four modules or in the planned text at this reading.

## Stage 2 — SAVED: the join, one build, and the axioms of every declaration from the built tree

**The merges** (branch `fs131-wj1`, each a merge commit):

| merged | commit | result |
|---|---|---|
| `fs131-wr2` at `71f1394a4` | `45a04b917` | clean |
| `fs131-wc1` at `14e65f524` | `f3bbf7896` | clean |
| `fs131-wdq` at `c57e97ba2` | `505003ae2` | clean |
| `main` at `39fee2edb` | `07bc1efef` | **two conflicts**, in `Proofs.lean` and `ARCHITECTURE.md`: each side had appended lines at one place (main's three lines for the residue module, this line's four). Resolved by keeping both, main's first (`data/fs131/kj1/resolve_both.py`, which refuses anything but one both-added hunk per file). Sent to the coordinator at once |

After the four merges: each of the four proved modules is byte-identical to its branch's head and each of the three residue modules
to main's (`git diff --quiet <commit> HEAD -- <file>`, seven times); under `Proofs/` and `scripts/` the tree differs from `39fee2edb`
by the four module files only.

**The joining module** is `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean`, the planned text
(`data/fs131/kn4/lean/ThreeFourColours.lean`) with its module docstring's first paragraph rewritten (it said "PLANNED TEXT — not in
the library") and nothing else changed; one line in `Proofs.lean`, one row in `ARCHITECTURE.md` (`tools/check_architecture.py`:
PASS, 349 modules, `data/fs131/kj1/logs/architecture-1.out`).

**Compiled files copied, not recompiled** (the brief's § What is yours to decide; inventory item 694's condition). Main had changed
`Plane/AeColouring` (docstrings) and added `Plane/LebesgueNumber` since this worktree's build; recompiling what imports them is the
47-minute build. Instead:
- *what was copied, from where*: the whole compiled library `.lake/build` of the worktree `fs131-wnf` (head `f57fc603d`; the tree
  whose gate passed for the residue module at `c2f4e4f54`; its sources under `Proofs/`, `scripts/`, the lakefile, the manifest and
  the toolchain file are identical to this tree's but for this line's four modules, the joining module and the root list) into this
  worktree's `.lake/build`, by `rsync -a --checksum --delete` (`data/fs131/kj1/copy_build.sh`): 380 files copied, 1028 files whose
  content already agreed (attributes only), 32 deleted — the stale artifacts of the four line modules;
- *how compared*: by content — a second `rsync --checksum --dry-run` itemizes nothing (`logs/copy_build.verify.txt`, 0 lines); and
  by Lake's own trace check at the build, which rebuilt six modules and no other.

**The build** (`scripts/build.sh` under the slot, `--mem 12`, `MEMMAX=12G`, `BATCH=8`): exit 0, **249 of 249 batches, 6 modules
rebuilt** (`Arith.DyadicQuadratic` 11 s, `Arith.ThreeColourCharacter` 4.1 s, `Arith.TorsionExtraction` 9.8 s,
`Arith.ThreeColourCriterion` 10 s, `Arith.ThreeFourColours`, `Proofs`), 1 module with warnings — the joining module's ten
`declaration uses sorry` and nothing else — 7 m 0 s (`logs/build1.out`, `build1.done`).

**The axioms of every declaration of the eight files, from the compiled modules** (`data/fs131/kj1/lean/Axioms.lean`, FS131-IN1's
printer over a list of modules; reader `data/fs131/kj1/read_axioms.py`; print `logs/axioms-build1.txt`, verdict
`logs/axioms-build1.out`):

| module | records (public) | standard three | + Weil's bound | unproved dependency |
|---|---|---|---|---|
| `Arith/ThreeColourCharacter` | 11 (9) | 11 | 0 | 0 |
| `Arith/TorsionExtraction` | 28 (18) | 28 | 0 | 0 |
| `Arith/ThreeColourCriterion` | 37 (17) | 31 | 6 (5 public) | 0 |
| `Arith/DyadicQuadratic` | 32 (11) | 32 | 0 | 0 |
| `Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues` | 68 (52) | 68 | 0 | 0 |
| `Arith/ThreeFourColours` | 15 (15) | 3 | 0 | 12: the ten leaves and the two compositions proved over them |

The six on Weil's bound: `targetFloor_four_weil`, `exists_normOne_zero_of_card_ne_nine`, `exists_maximal_card_nine`,
`exists_maximal_of_torsion`, `exists_maximal_card_nine_of_colorable_three`, and the private `exists_maximal_card_nine_of_quotient`.
**The unproved dependency the four reports name is gone from every record of the four modules.** Control: three records planted in
the print's own file — a `sorry`, a use of the import, a clean one — are read as SORRY, WEIL, CLEAN (3 of 3); the reader also fails
if the set of records printing `sorryAx` differs from `sorry-expected-build1.txt` in either direction.

**Item 679's list, emptied by its own check.** `data/fs131/it1/read_axioms.py` on the joined tree's print of its 18 records, with
`data/fs131/it1/sorry-expected.txt` as the torsion implementer left it: exit 1, "with `sorryAx` as listed: 0 of 5 listed; not as
expected: 5" (`logs/it1-check-with-list.out`). The file is now empty; the same check: exit 0, 18 records on the standard three
(`logs/it1-check-emptied.out`); its control: 2 of 2 planted records reported.

## Stage 3 — SAVED: the statements the implementers named, and those the join needed

Each is typed and proved; "read back" is against the claim list's line or the report's sentence it answers. The kernel's side
(axioms, and that no existing statement moved) is stage 5's print from the built tree.

| module | added | read back against |
|---|---|---|
| `Arith/TorsionExtraction` | `colorable_two_of_fieldBandSet_three_nonempty (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) (h : (fieldBandSet F (band 3)).Nonempty) : Colorable 2` | item 679, the first character-form statement: FS81-T4 "in the ledger's own words" (`1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²` bipartite). Says the same |
| | `fieldBandSet_three_eq_empty_of_sqrt_mem (hd : d % 12 = 11) (hF : √d ∈ F) : fieldBandSet F (band 3) = ∅` | item 679, the second: clause (a) in character form. The probe had `¬ Nonempty`; typed as `= ∅`, which is the ledger's "`Θ₃(R_F) = ∅`" |
| `Arith/ThreeColourCharacter` | `fieldBandSet_three_nonempty_of_colorable_unitRing (F) (h : ((unitDistance ℂ).induce (unitRing F : Set ℂ)).Colorable 3) : (fieldBandSet F (band 3)).Nonempty` | item 685's first generalization: the headline read on the ring of unit vectors. Wider than NF4-S6 as claimed (dated line drafted below) |
| | `bandSet_three_nonempty_zmod_five : (bandSet ({1} : Set (ZMod 5)) (band 3)).Nonempty` | item 685's second: the forward half for every abelian group and step set **is the statement as the skeleton typed it** (`bandSet_three_nonempty_of_proper`, `exists_character_of_properAlong`); what was missing is its model at a group with torsion — the 5-cycle, colours `0, 1, 0, 1, 2` |
| | two `example`s (`2/3 ∈ band 3`, `0 ∉ band 3`); the module docstring's "Inhabitants" paragraph replaced, and a paragraph "Wider than the ledger's row 79" | FS131-IC1's drafts D2 and D3 item 5 (item 685 left them to the landing; they are made here because the module is recompiled by this job anyway) |
| `Arith/DyadicQuadratic` | `colorable_two_planeOver_sqrt_of_mod_four (h : m % 4 = 1 ∨ m % 4 = 2) : Colorable 2`, `mod_four_of_squarefree` | item 689: the two-colour statement without squarefreeness (FS131-ID1's probe, moved). **Not** "`m % 4 ≠ 3`" alone: `m = 12` is `ℚ(√3)` |
| | the three `exists_addMonoidHom_*` docstrings and the route paragraph reworded to the one-form subgroup; one `example` (`m = 9`, `18`) | item 689's three docstrings |
| `Arith/ThreeColourCriterion` | docstrings only (stage 4). `data/fs131/lc1/code_only_diff.py cd657318f`: SAME, 38699 characters of code | — |
| `Arith/ThreeFourColours` | `exists_stablePrime_card_nine`, `exists_maximal_card_three_of_stablePrime_card_nine` (J.3 is now their composition) | K-1: what J.7's call site needs. The second holds for every subfield of `ℝ` |
| | `levelTarget_colorable_two_of_ramified`, `levelTarget_colorable_three_of_card_nine` | the two colourings of level targets J.7 needs: the first upper bounds on a `levelTarget`'s chromatic number in the library |
| | `colorable_three_planeOver_sqrt`, `chromaticNumber_planeOver_sqrt_eq_three_of_mod`, `colorable_four_planeOver_sqrt_of_seven`, `chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod` | K-3: the rows at 3 and at 4-through-7 with squarefreeness replaced by what is read (`9 ∤ m` at `3 ∣ m`; `49 ∤ m` at `7 ∣ m`; nothing otherwise). The planned J.8, J.9 are their corollaries, statements unchanged |
| | `chromaticNumber_planeOver_sqrt_eq_four`, `chromaticNumber_planeOver_sqrt_table` | K-4: NF4-THEOREM (a)'s row at 4 in the claim's words, and the whole table as one statement |
| | `chromaticNumber_planeOver_sqrt_three`, `fieldBandSet_three_nonempty_sqrt_three`, `exists_maximal_card_nine_sqrt_three`, `exists_maximal_conj_trivial_sqrt_two`; six `example`s of the table (2 at `√2`, 3 at `√7`, 4 at `√11` and `√23`, `≥ 4` at `√47`, `√167`) | item 698's four model rows: a three-chromatic and a two-colourable plane over a number field, and the hypotheses of J.3 and J.4 inhabited at them |

**No joining leaf was restated**: the ten planned statements are in the module character for character (stage 5's statement
comparison). J.2's call of Hilbert 90 needed no change, as item 698 said.

**Decided not to state**, with the reason:
- *The model of `exists_maximal_card_nine`'s hypotheses on the field of nine elements* (item 698's ruling (a): "if it falls in a few
  lines"). It does not: it needs a nine-element ring with a conjugation as an object. What the kernel holds instead: the clause
  that carries the content, for every nine-element field with an involution moving a square root of `−1` — the private
  `nine_functional_ne_zero` (`−(u + ū) + ι(u − ū) ≠ 0` at a norm-one `u`) — and the conclusion at `ℚ(√3)`
  (`exists_maximal_card_nine_sqrt_three`). The module docstring's sentence stands.
- *The converse of the criterion's forward half for every abelian group* (item 685: "five lines [hand, one mind, the
  implementer; prior art not searched]"): not asked, not searched for prior art, and no statement here reads it.
- *`1/2 ∉ ℤ[U_ℚ]` and `2 ≤ L(ℚ)`* (item 702: kernel-checked terms of a checks file): no call site of this line needed either.
  What J.10 needed, `1/2 ∉ ℤ[U_F]` at `m ≡ 3 (mod 8)`, is inside its proof.

**Dated lines drafted for `data/fs131/claims-NF4.md`** (the coordinator files; each "[kernel] on branch `fs131-wj1`, not
through the gate" until the landing):

> - 2026-10-13 — **Statements of the line that say more than the list, typed by the joining job (FS131-KJ1).** (1) NF4-S6
> holds reading the colouring only on the ring of unit vectors: a three-colouring of the unit-distance graph on `ℤ[U_F]`
> gives the character (`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing`; found by FS131-IC1). (2)
> Clause (a) in character form: `Θ₃(R_F) = ∅` for every subfield `F ∋ √d`, `d ≡ 11 (mod 12)`
> (`TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem`; named by FS131-IT1). (3) The table's rows need less than
> squarefreeness: two colours for every `m ≡ 1, 2 (mod 4)` (found by FS131-ID1); three for `m ≡ 3 (mod 4)` with
> `m ≡ 1 (mod 3)`, or `3 ∣ m` and `9 ∤ m`; four for `m ≡ 11 (mod 12)` with `m ≡ 1, 2, 4 (mod 7)`, or `7 ∣ m` and `49 ∤ m`;
> four for every `m ≡ 11 (mod 24)`. Squarefreeness cannot be dropped whole: `m = 12` is `ℚ(√3)` (three colours, and
> `12 ≢ 3 (mod 4)`), `m = 99` is `ℚ(√11)` (four, and `99 ≡ 3 (mod 12)`). (4) Two upper bounds on level targets, the first
> in the library: a stable prime modulo which conjugation is the identity has a two-colourable target, and one whose
> quotient has nine elements a three-colourable one (`ThreeFourColours.levelTarget_colorable_two_of_ramified`,
> `levelTarget_colorable_three_of_card_nine`). (5) NF4-DYADIC-FOUR as worded holds at every `m ≡ 3 (mod 8)`, not only
> `m ≡ 11 (mod 24)` (`exists_stablePrime_card_four_sqrt`). No statement defect found.

## Stage 4 — SAVED: the attributions, read against `[Fischer1990]`

**What was read.** K. G. Fischer, *Additive k-colorable extensions of the rational plane*, Discrete Math. 82 (1990) 181–195:
the library's copy `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, all fifteen pages in its text layer
(`pdftotext -layout`, page by page, in the session's scratch directory; nothing of the paper is committed). Read for this job:
§1 (pp. 181–182), Theorem 1 with its proof (p. 183), Theorem 7 (p. 189), Theorems 8, 9, 10 with their proofs (pp. 189–194),
Example 4 (p. 194), the references (p. 195). **Not re-read:** `[Johnson2000]`, `[Johnson1987]`, `[Moorhouse2010]`,
`[Madore2015]` — where a docstring names them the bibliography's row is copied.

| kernel statement | the paper | value only, or also the map? |
|---|---|---|
| `DyadicQuadratic.colorable_planeOver_of_addMonoidHom` | Thm 1(i), p. 183: "If `F^d` has an additive k-coloring, then `F^d` can be k-colored" | the same construction (colour `C₀`, copy to its translates). **Credit was missing** |
| `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty` | Thm 1(ii), p. 183: "`F^d` can be 2-colored iff there exists an additive map `v : C₀(F^d) → ℤ/(2)` so that `v(ξ) = [1]` if `‖ξ‖ = 1`" | the same statement, read in `ℝ/ℤ`. **Credit was missing** |
| `ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two`, `fieldBandSet_two_nonempty_of_conj_trivial` | Thm 1(iii), p. 183: "The plane `F²` can be 2-colored iff there exists a non-zero ring homomorphism `v : C₀(F²) → ℤ/(2)`" | the equivalence "in the ring's words"; the docstrings credited only the outside model, whose part is the passage from that homomorphism to a prime of `F(i)`. **Credit was missing** |
| two colours off `3 (mod 4)`: `colorable_two_planeOver_sqrt`, the row at 2 | Thm 8, p. 189 (proof pp. 190–191); the "if" half independently his reference [8] = `[Johnson1987]` | **value and map**: at `N ≡ 2 (mod 4)` his `t = (a₁ + b₁ + 2b₂)/c` is the proof's form exactly; at `N ≡ 1 (mod 4)` his `s = (a₁ + b₁ + a₂ + b₂)/c` differs from the proof's in two signs and is the same map on the group the unit vectors generate. The case analysis modulo 4 and 8 is his |
| at least three on `3 (mod 4)`: `not_colorable_two_of_sqrt_mem`, `three_le_…_of_sqrt_mem` | Thm 8 "only if", p. 190, through Thm 7 (p. 189) | the same unit vector `(b + √N·i)/(2a)` and the same relation; his for squarefree `N` and `ℚ(√N)`, the kernel's for every subfield holding `√d` (the dated widening G-1). The docstring said "Thm 10(ii)'s vector" — true, and Thm 8's first |
| three at `3, 7 (mod 12)`: the row at 3, `colorable_three_planeOver_sqrt` | Thm 9 and the sentence after it, p. 192 (proof pp. 192–193) | **value and map**: his `(a₁ + b₁)/c` (at `3 ∣ N`) and `(a₁ + b₁ + a₂ + b₂)/c` (at `N ≡ 1`) modulo 3 are the residue at a prime above 3 followed by `x + y` on `𝔽₃²`, the colouring `finitePlane3_colorable_three` holds |
| four colours at `3 (mod 8)`: `colorable_four_planeOver_sqrt`, `exists_addMonoidHom_three_mod_eight` | Thm 10(i), p. 193 (proof pp. 193–194) | **value only**: his additive colouring is into `ℤ/(4)` (`2(a₁ + b₁)/c` modulo 4), the kernel's into `𝔽₂ × 𝔽₂`: different quotient groups, different colourings. The docstring said "prior art: the residue colouring at the dyadic prime, `𝔽₄`-valued" — reworded to the value |
| `1/3 ∈ ℤ[U]`, the additive obstruction | Thm 10(ii), pp. 193–194; Ex. 4, p. 194; §1, p. 182 | as the docstrings said; his at `N ≡ −1 (mod 24)`, the kernel's at `d ≡ 11 (mod 12)` by the same vector |
| "`[Fischer1990]` §1 poses the question" (`ThreeColourCriterion`) | p. 182: "whether some algebraic criterion can be found to determine the chromatic number of `F²` where `F` is a subfield of `ℝ`, of finite degree over `ℚ`" | borne out |
| "`χ = 3` at `ℚ(√3)`, Thm 9" (three docstrings) | Thm 9 at `N = 3` | borne out |

**No credit in the line's modules is one the paper fails to bear out.** The docstrings of the four modules and of the joining
module now carry theorem number and page, and say "value and map" or "value only" where it applies. Sent to the coordinator
mid-job.

**Two corrections drafted for files that are not this job's to edit** (docstrings; each recompiles what imports the file):

- `Proofs/HadwigerNelson/Instances/SqrtEleven.lean:29` and `:242` — for "`χ(ℚ(√11)²) ≤ 4` is `[Fischer1990]` Thm 9" read
  "**`[Fischer1990]` Thm 10(i) (p. 193: an additive 4-colouring for `N ≡ 3 (mod 8)`)**". Thm 9 is three colours at
  `N ≢ 2 (mod 3)` and says nothing at 11. Both lines also say the bound "is not in the kernel": since the residue module
  landed it is (`UpperHalf.chromaticNumber_planeOver_eleven`), and again through the dyadic prime
  (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic` at 11).
- `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean:21` — for "upper bound is `[Fischer1990]`'s" read "the upper bound
  is `[Fischer1990]` Thm 10(i), p. 193 — by an additive colouring into `ℤ/(4)`; the proof here is the residue plane at 7
  (`[Moorhouse2010]`, `[Madore2015]`)".

**For `BIBLIOGRAPHY.md`'s row `[Fischer1990]`** (draft; slot: its last cell): "re-read 2026-10-13 by FS131-KJ1 (Thm 1 and its
proof, Thms 7–10 and their proofs, Ex. 4, against the kernel statements of the three-and-four-colours line): Thm 1(i)–(iii)
are three kernel statements; the two-colour and three-colour maps are his; his four-colouring at `N ≡ 3 (mod 8)` is
`ℤ/(4)`-valued and is not the kernel's."


## Stage 5 — SAVED: the ten leaves proved; four builds; the readings from the built tree

**The leaves.** All ten are proved and no statement of the planned text moved. How each went against its plan (KN4 § 4.4):

| leaf | route as built | against the plan |
|---|---|---|
| J.1 | Chevalley's domination for the ring as `UnitRing.unitRing (conjOn …) : Subring (fieldI F)`; stability from `UnitRing.normOne_subset_iff_stable`; the kernel of the residue on the ring (a private ring homomorphism `ringResidue`) is a proper ideal over `𝔪` | as planned; one private lemma more: the level-one residue's kernel is the maximal ideal of `𝓞_P` (`residue_one_eq_zero_iff`) |
| J.2 | two cases on whether conjugation is the identity on `𝓞 ⧸ P`; Hilbert 90 (`ThreeColourCriterion.exists_mul_conj_inv_eq_of_mul_conj_eq_one`), `u = a/ā`, `residue_div` | as planned |
| J.4 | `2 ∈ 𝔪` from `i`; J.1; a moved `y` gives `y/ȳ ≠ 1`, a unit vector's residue by J.2, and unit vectors are `1` modulo `𝔪` | as planned |
| J.3 | through the stronger `exists_stablePrime_card_nine` (K-1): `StandingFive.card_fixed_of_involution` gives `|𝓞 ⧸ P| = Q²`, `Q ≡ 3 (mod 4)`; `involution_eq_pow` and `card_normOne` put `Q + 1` norm-one elements in the nine-element image of the ring; `Q = 7` is excluded by characteristic 3. Then the prime below by a map `𝓞 F → 𝓞 (F(i))` built here (`upO`) and the three-element fixed field | the plan's count; its "`Q = 3`" needed the congruence `Q ≡ 3 (mod 4)`, which the library's lemma supplies |
| J.5, J.6, J.8, J.9 | compositions; J.8 and J.9 over the wider forms of stage 3 | as planned |
| J.7 | three cases. Two colours: `exists_maximal_conj_trivial_of_colorable_two`, J.4, and `levelTarget_colorable_two_of_ramified` (an edge is `x, x + 1`; an `𝔽₂`-linear functional with value 1 at 1, built as FS131-IN1 built its own). Three and not two: `exists_stablePrime_card_nine` and `levelTarget_colorable_three_of_card_nine` | the plan's "an additive `κ → ZMod 3` with `1, ῑ ↦ 1`" needs coordinates on the field of nine elements; **replaced** by the colouring `x ↦ −(x + x̄) + ι(x − x̄)`, which lies in the fixed field and is not `0` at a norm-one `u` — a zero has `u² = −ι`, so `u⁴ = −1`, against `u·ū = u⁴ = 1` (`nine_functional_ne_zero`). No coordinates |
| J.10 | `1/2 ∉ ℤ[U_F]` from the additive map of `exists_addMonoidHom_three_mod_eight` (the ring is an additive span of unit vectors: `UnitRing.exists_sum_eq_of_mem_unitRingOver`); a stable prime over 2; `P ∋ 1 + i`; `absNorm (1 + i)² = absNorm (2) = 2^[F(i):ℚ]` and `[F(i):ℚ] ≤ 4` | the plan's "`𝓞 ⧸ (1+i) ≅ (1+i)𝓞 ⧸ 2𝓞` and `|𝓞 ⧸ 2𝓞| = 16`" **replaced** by the multiplicativity of the absolute norm (`Ideal.absNorm_span_natCast`, `Ideal.absNorm_dvd_absNorm_of_le`); only `[F(i):ℚ] ≤ 4` is needed, from `StandingFive.finrank_closure`, `finrank_simple_le` and the surjection `F × F → F(i)` |

**The builds** (`scripts/build.sh` under the slot; logs `data/fs131/kj1/logs/build{1,2,3,4}.out`):

| build | tree | result |
|---|---|---|
| 1 | the join, the planned text in place | exit 0, 249 of 249 batches, 6 modules rebuilt, 7 m 0 s; warnings: the ten `sorry` (stage 2) |
| 2 | stages 3–4 in the four modules; seven leaves proved | exit 0, 6 modules rebuilt, 7 m 6 s; warnings: four `sorry` in the joining module, nothing from the four modules |
| 3 | the joining module with no `sorry`; `Instances/UpperHalfCorollaries` | exit 0, 3 modules rebuilt, **0 modules with warnings**, 7 m 58 s (`--mem 10`, beside another job's build: at `--mem 12` it had waited nine minutes behind two 12-GiB reservations and was stopped by its PID before its first line) |
| 4 | row 99's two sentences added; the sources are commit `96a293e7d`'s | exit 0, 249 of 249 batches, 2 modules rebuilt (`Arith.ThreeFourColours` 11 s, `Proofs`), **0 modules with warnings**, 8 m 5 s |

**From the fourth build's tree** (`data/fs131/kj1/after_build.sh`; each exit read from its own line of `logs/after_build.out`):

- *Axioms* (`logs/axioms-final.txt`, `.out`): 232 records in the nine files — `ThreeColourCharacter` 13 (11 public),
  `TorsionExtraction` 30 (20), `ThreeColourCriterion` 37 (17), `DyadicQuadratic` 34 (13), the residue module's three files
  68 (52), `ThreeFourColours` 46 (31), `UpperHalfCorollaries` 4 (4). **No record prints an unproved dependency; 219 are on the
  standard three, 13 on those and Weil's bound** (6 in `ThreeColourCriterion`, one of them private; 7 in `ThreeFourColours`).
  Control, the brief's "a planted `sorry` watched showing": the print's own file declares a `sorry`, a use of the import and a
  clean theorem, and the reader fails unless it reads them SORRY, WEIL, CLEAN — 3 of 3; it also fails if any record prints
  `sorryAx` that `sorry-expected-final.txt` (empty) does not list. The same reader at the first build listed twelve.
- *Statements, from the kernel's side* (`logs/statements-final.out`): the 122 named constants of the eight files as the first
  build stored them (kind, name, hash of the stored type, hash of a definition's value) are all in the final dump unchanged;
  **26 added, 0 changed or gone**. The ten planned leaves are among the 122, so none was restated. Control: one type hash
  changed in memory is reported, and only it.
- *Environment linters* (`logs/lint.out`): `lake lint --no-build -- --no-build --trace`, exit 0, "Linting passed for Proofs.",
  14 linters passed. `tools/check_architecture.py`: PASS, 350 modules (`logs/architecture-4.out`).
- *Not run* (the landing's): `scripts/axioms.sh` with the block filed, `dupnames.sh`, `vacuity.sh`, `assumptions.sh`.

**Which headline statements rest on Weil's bound** (for the report to Kooshi; item 698's ruling (c)).

*On the standard three axioms alone:*
- **Clause (a), whole**: the lower bound `χ ≥ 4` at every `m ≡ 11 (mod 12)` (this project's), the values 2, 3 and 4 of the
  table (prior art), the table as one statement (`chromaticNumber_planeOver_sqrt_table`).
- **Clause (c)**: `1/3 ∈ ℤ[U_F]` and not bipartite give `χ ≥ 4`; `χ ≠ 3` there.
- NF4-S6, NF4-S7, NF4-S9 at level one; the two dyadic statements as worded.
- **Clause (b), from the prime to the colouring**: a prime with residue field `𝔽₃` gives three colours
  (`colorable_three_of_card_three`; prior art).
- The dictionary (J.1–J.4): everything a three-colouring gives *once a maximal ideal with nine elements is in hand*.

*On the standard three and Weil's bound:*
- **Clause (b) as claimed** (`chromaticNumber_planeOver_eq_three_iff`) and its form without the hypothesis
  (`colorable_three_planeOver_iff`): the direction from a three-colouring to the prime.
- **Row 99**: `L(F) ≤ χ(F²)` or `χ ≥ 4` (`localBound_le_chromaticNumber_or_four_le`); `L ≤ 4 ⟹ L ≤ χ`; `χ = L` for `L ≤ 4`;
  `χ ≤ 3 ⟺ L ≤ 3`.
- In the ring: `targetFloor_four_weil`, `exists_normOne_zero_of_card_ne_nine`, `exists_maximal_card_nine`,
  `exists_maximal_of_torsion`, `exists_maximal_card_nine_of_colorable_three`; and the model
  `exists_maximal_card_nine_sqrt_three`.

Weil's bound is read at one place, `targetFloor_four_weil` (a residue field of `Q ≥ 27` elements cannot carry the
three-colouring), as both planners said; nothing at two or four colours reads it.

## Stage 6 — SAVED: the residue module's named corollaries

In the new module `Proofs/HadwigerNelson/Instances/UpperHalfCorollaries.lean` (namespace `HadwigerNelson.UpperHalf`; no landed
file was edited), each on the standard three:

| item 702 named | statement | one application? |
|---|---|---|
| "localBound F = 2 → χ(F²) = 2" | `chromaticNumber_planeOver_eq_two_of_localBound_le_two (h : localBound F ≤ 2) : χ = 2` | yes. **Its hypothesis is proved for no field in the library**: no theorem bounds a `localBound` above. `L(ℚ) ≤ 2` is now two applications away (`UpperHalf.exists_stablePrime_rat` with `ThreeFourColours.levelTarget_colorable_two_of_ramified`), and is not stated |
| "row 52's two values (the ramified clause at 11 for K(√5), K(√247))" | `chromaticNumber_planeOver_sqrt_five_le_five`, `chromaticNumber_planeOver_sqrt_247_le_five`: `χ ≤ 5` over `fieldOfRadicands {11, 3, 5}` and `{11, 3, 247}` | **the upper halves are one application each; the values are not.** `χ ≥ 5` over these two fields is stated by no declaration (searched: `rg "five_le\w*planeOver"` finds the compositum of `√14`, `√70` and the conditional at `K(√7)` only). Row 52 stays `[hand + tools]` on its lower side; what it needs is a five-chromatic graph embedded in each plane as a theorem |
| "row 105's reading at K(√7)" | `two_notMem_stablePrime_seven (P : StablePrime F7) : (2 : 𝓞 (fieldI F7)) ∉ P.P` | yes. The kernel holds no stable prime of this field (one exists by Chebotarev), so it does not know the statement is about a non-empty type; the docstring says so |

Upper bounds are prior art and the docstrings say so (the residue bound: `[Moorhouse2010]`, `[Manturov2012]`,
`[Madore2015]`; `χ(𝔽₁₁²) = 5`: Moorhouse's table).

## Stage 7 — SAVED: drafts for the landing and the filing

**D1. Records the landing registers** — `data/fs131/kj1/audit-block.txt` (generated from the final print by
`make_audit.py`): **96 public records of six files, 84 CLEAN and 12 IMPORTED** (on `StandingFive.kloosterman_bound`; the
import is already declared, no new `declareImport`). The implementers' own blocks (`data/fs131/{ic1,it1,in1,id1}/audit-block.txt`)
are subsumed. No native purchase, no new axiom, no hypothesis former.

**D2. `scripts/Assumptions.lean`** — `inline:Row99` (kind `ours`), the hypothesis `hRow99` of
`SpectralChain.min_localBound_five_le_chromaticNumber`, `SpectralChain.chromaticNumber_eq_localBound` and
`UpperHalf.chromaticNumber_eq_localBound_of_chain`, is now a theorem: `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`
— **on Weil's bound**, so the entry does not vanish, it changes kind: what was a hand result of ours is a kernel theorem
resting on a declared outside theorem. The landing retires the entry on its own reading (item 694: the step cannot find a
written-out hypothesis that has been proved) and says in the ledger that the chain's headline, restated without the binder,
would be IMPORTED. Restating the headline is the chain's successor planner's (the brief: not this job's).

**D3. Models, for the landing's record** (the vacuity scan does not track these carriers):

| hypothesis | model | where |
|---|---|---|
| a three-colourable, not two-colourable plane over a number field | `ℚ(√3)` | `ThreeFourColours.chromaticNumber_planeOver_sqrt_three` |
| a two-colourable plane | `ℚ(√2)`, `ℚ(√9)`, `ℚ` | `DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four`; `UpperHalf.chromaticNumber_planeOver_rat` |
| `Θ₃(R_F) ≠ ∅` | `ℚ(√3)` | `ThreeFourColours.fieldBandSet_three_nonempty_sqrt_three` |
| a maximal ideal of `ℤ[U_F]` with nine elements in its quotient (J.3, `exists_stablePrime_card_nine`) | at `ℚ(√3)` | `exists_maximal_card_nine_sqrt_three` (Weil) |
| a maximal ideal with trivial conjugation (J.4) | at `ℚ(√2)` | `exists_maximal_conj_trivial_sqrt_two` |
| a stable prime with nine elements in its quotient (`levelTarget_colorable_three_of_card_nine`, `exists_maximal_card_three_of_stablePrime_card_nine`) | at `ℚ(√3)`: `exists_stablePrime_card_nine` applied to the row above | a composition, **not a declaration** — one line for the landing if it wants it held |
| a stable prime with trivial conjugation (`levelTarget_colorable_two_of_ramified`) | `(1 + i)` at `ℚ` | `UpperHalf.exists_stablePrime_rat` |
| `𝔪 ≠ ⊥` maximal (J.1) | either ideal above (each holds 2 or 3) | — |
| a norm-one residue (J.2) | `t = 1` at any stable prime; with `t ≠ 1`, inside J.4's proof | — |
| a colouring changing along a step set, at a group with torsion | the 5-cycle | `ThreeColourCharacter.bandSet_three_nonempty_zmod_five` |
| `m ≡ 3 (mod 8)` and the table's classes | `m = 3, 11, 35`; the table's six `example`s | the modules' spec sections |

Still named and held by no declaration: the field of `27²` elements for `exists_normOne_zero_of_card_ne_nine` (ruled a
sentence, item 698); a nine-element ring as an object for `exists_maximal_card_nine` (stage 3).

**D4. `ARCHITECTURE.md`** — the rows of `Arith/ThreeFourColours` and `Instances/UpperHalfCorollaries` are written (this
branch). The four older rows still say "a skeleton: … leaves are `sorry`" and are not this job's lines; replace in each
the parenthesis after "FS-131, NF4":
- `Arith/ThreeColourCharacter`: "(statements FS131-KN4's, passes FS131-KN5; the eight leaves' proofs FS131-IC1's; two
  statements added by FS131-KJ1; no `sorry`)", and add `fieldBandSet_three_nonempty_of_colorable_unitRing`,
  `bandSet_three_nonempty_zmod_five`.
- `Arith/TorsionExtraction`: "(…; the ten leaves' proofs FS131-IT1's; two statements added by FS131-KJ1; no `sorry`)", and
  add `colorable_two_of_fieldBandSet_three_nonempty`, `fieldBandSet_three_eq_empty_of_sqrt_mem`.
- `Arith/ThreeColourCriterion`: "(…; the thirteen leaves' proofs FS131-IN1's, three statements widened by ruling; no
  `sorry`; five public records on the import)".
- `Arith/DyadicQuadratic`: "(…; the ten leaves' proofs FS131-ID1's; two statements added by FS131-KJ1; no `sorry`)"; for
  "the lattice and its map by class" read "an integer form by class, read modulo 2 on the subgroup where it has odd
  denominator"; add `colorable_two_planeOver_sqrt_of_mod_four`, `mod_four_of_squarefree`.
- § Trust, the import's consumer list: add the seven public records of `Arith/ThreeFourColours` and the five of
  `Arith/ThreeColourCriterion` (D1's IMPORTED list).

**D5. `LEDGER.md`** (each "[kernel]" only once the line is through the gate):
- **Row 73** — add: "`χ(ℚ(√11)²) = 4` is also the dyadic row at `m = 11`
  (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic`); `χ ≥ 4` at 23, 47, 71, 95 and 191 are instances
  of the family theorem (row 82), no longer `[certified, tools]` only, and the value is exactly 4 at 23, 71, 95 and 191
  (`chromaticNumber_planeOver_sqrt_eq_four`: each is squarefree, `≡ 11 (mod 12)` and none is `47, 143, 167 (mod 168)`)."
  Rests on: the standard three. *(Held as an `example` in the module at 23 only; the other three are the theorem read at
  those `m` by hand — modulo 168 they are 71, 95 and 23, and modulo 7 they are 1, 4 and 2 — and are not kernel-checked instances until someone types them.)*
- **Row 82** — regrade `[hand, two independent derivations]` to `[kernel]`, the standard three:
  `TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`, `chromaticNumber_planeOver_ne_three_of_inv_three_mem`,
  `four_le_chromaticNumber_planeOver_of_sqrt_mem`, `fieldBandSet_three_eq_empty_of_sqrt_mem`; "three-colourability of every
  real quadratic plane is decided exactly" is `ThreeFourColours.chromaticNumber_planeOver_sqrt_table`. Add the widening: every
  subfield of `ℝ` holding `√d`, `d ≡ 11 (mod 12)`, no squarefreeness. Prior art stays as the row has it, with theorem numbers
  from stage 4.
- **Row 79** — its ⟹ in character form: `[kernel]`, the standard three
  (`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`), for every abelian group and step set
  (`bandSet_three_nonempty_of_proper`).
- **Row 99** — regrade its first two sentences and the criterion to `[kernel, on one declared outside theorem (Weil)]`:
  `ThreeFourColours.chromaticNumber_planeOver_le_three_iff` (`χ ≤ 3 ⟺ L ≤ 3`),
  `chromaticNumber_planeOver_eq_localBound_of_le_four` (`χ = L` for `L ≤ 4`), `chromaticNumber_planeOver_eq_three_iff`.
  **Not in the kernel, still [hand]:** "every three-colour band character of such a field is a residue character at one
  such prime (no mixing)" and `χ(ℚ(α,√7)²) = 4` — no statement of this line is either.
- **Row 52** — "the two values stay [hand + tools]" becomes "the upper halves are `[kernel]`
  (`UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `…_sqrt_247_le_five`); the lower halves are stated by no
  declaration". **Row 105** — add the reading at `K(√7)`: `UpperHalf.two_notMem_stablePrime_seven`.
- **§ B**, FS73-T22, FS81-T2, T3, T4, T5, FS91-J02-L1, L2, T1 ⟹, T2, T3: regrade as FS131-IC1's, -IT1's and -IN1's records
  draft, with the joining module's addresses for L2 (b), (c) (`exists_stablePrime_of_maximal`, `exists_unitSet_residue_eq`),
  T2 and T3.

**D6. The front page's sentence** (`CLAUDE.md` § Where the problem stands, "What the kernel holds"): "**three and four
colours over real number fields** — for a real quadratic field `ℚ(√m)`, `m` squarefree, the plane needs 2 colours when
`m ≢ 3 (mod 4)`, 3 when `m ≡ 3, 7 (mod 12)`, and 4 when `m ≡ 11 (mod 12)` unless `m ≡ 47, 143, 167 (mod 168)`, where it
needs at least 4 — on the standard three axioms (`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`); every subfield
of `ℝ` whose unit-vector ring holds `1/3` has a plane that is never exactly three-chromatic (row 82); and over every real
number field `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`, `χ(F²) = L(F)` whenever `L(F) ≤ 4`, and a non-bipartite plane is three-chromatic iff
some prime of `F` has residue field `𝔽₃` — on one declared outside theorem, Weil's bound (row 99). The values 2 and 3 and
every upper bound are Fischer's and Johnson's (`[Fischer1990]` Thms 1, 8, 9, 10(i)); the lower bound at four, the
three-colour criterion and row 99's lower half are this project's." Its counts (records, clean, imported) are the landing's.

**D7. "Not claimed", as the docstrings now have it:** every upper bound and every value of the table (`[Fischer1990]`
Thms 8, 9, 10(i), with page; `[Johnson1987]`; the residue plane: `[Moorhouse2010]`, `[Madore2015]`); the two-colour
criterion in the ring's words (`[Fischer1990]` Thm 1(i)–(iii)) and its reading at a prime (an outside model's, `LEDGER.md`
§ B); the unit vector and `1/3 ∈ ℤ[U]` (`[Fischer1990]` Thm 10(ii), Ex. 4); anything at five colours (the two bounds of
`Instances/UpperHalfCorollaries` are prior art's upper halves); anything over a field that is not a number field in
clause (b) and row 99 (clause (c), clause (a)'s lower bounds, NF4-S6 and NF4-S7 are for every subfield of `ℝ`).

**D8. `LEAN.md` § Searching — Lean** (draft lines):
- "A functional that must not vanish on the norm-one elements of a nine-element field with conjugation needs no coordinates:
  `x ↦ −(x + x̄) + ι(x − x̄)` (`ι² = −1`) is fixed by conjugation, and a zero `u` of norm one has `u² = −ι`, so `u⁴ = −1`
  against `u·ū = u⁴ = 1` — three `linear_combination`s (`ThreeFourColours.nine_functional_ne_zero`, FS131-KJ1)."
- "The size of a residue field at a prime over 2 comes from the absolute norm with no order described:
  `Ideal.absNorm_span_natCast`, `Ideal.absNorm_dvd_absNorm_of_le` and `(1 + i)² = 2i` give `|𝓞 ⧸ P|² ∣ 2^[K:ℚ]`
  (`exists_stablePrime_card_four_sqrt`, FS131-KJ1)."
- "A queued build has read nothing: while `build.sh`'s log is empty the module it compiles last can still be replaced and
  committed; once its first line is printed, later text goes to a copy under `data/` (FS131-KJ1)."
- "A join of branches whose library differs from a gated tree in a few modules need not recompile the rest: `rsync -a
  --checksum --delete` of the gated tree's `.lake/build`, a second dry run that itemizes nothing, and Lake's trace check
  (`data/fs131/kj1/copy_build.sh`, FS131-KJ1; inventory item 694's condition)."

## Slips, mine

1. **A sentence about a prime that I had not checked, written into a docstring and caught before the build**: the first
   text of `Instances/UpperHalfCorollaries` said `K(√7)(i)` has a stable prime "above 3". It does not: the prime of `K(√7)`
   above 3 has residue field of nine elements, where `−1` is a square, so it splits. The docstring now says what is true
   (a stable prime exists by Chebotarev; the kernel holds none).
2. **A planted record that did not elaborate** (`planted_weil`, a universe left open): the first axiom print exited 1 with
   its rows already written; it was re-run after the fix and only the second print is cited.
3. **The module was replaced twice while a build sat in the slot's queue.** Nothing had been read (the build's log was
   empty, checked each time, and the built sources equal commit `96a293e7d`'s by `git diff`), but it is the practice
   `LEAN.md` warns about, made safe here only by the queue; D8's third line says how.
4. **This job outran its budget line** (about 400k as guidance) to finish the last two leaves rather than hand them back
   with plans; each stage was committed before the next step.
