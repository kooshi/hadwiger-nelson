# FS131-KJ1 — the joining module of the three-and-four-colours line: the join, the added statements, the attributions, the leaves

*The kernel lane's planner (de Bruijn), who in this job also proves what it states; 2026-10-13, branch `fs131-wj1`, cut from
`fs131-wrc` at `cd657318f` in the worktree `.claude/worktrees/fs131-wrc`. Brief: `data/fs131/briefs/FS131-KJ1-joining-module.md`.
Claim list: `data/fs131/claims-NF4.md`. Working files: `data/fs131/kj1/`. Nothing here is blind (the brief's `fences: none`).*

## Theorems this phase proved

*(Filled stage by stage; each line is a theorem of the built tree with its grade and address, or says what is not yet built.)*

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
