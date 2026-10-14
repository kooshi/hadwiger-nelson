# FS131-ICM4 — the five-colour chain: M13's two dyadic certificates

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM4-dyadic-certs.md` (on `main`). Branch `fs131-wcm4`, cut
from `fs131-wcm3` at `c0b6798ed`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm4/`. Report:
`data/fs131/reports/FS131-ICM4.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 2 (`data/fs131/icm4/axioms2.out`, `axioms2-read.out`): 273 records of `Arith/BinaryField`,
`Arith/DyadicCerts`, `Arith/CircleCos`, `Rigidity/ClassRatio`, `CountCompletion`, `CountModels` and
`count_of_oneAvoidingDensityBound` — **CLEAN 261, IMPORTED 7, UPSTREAM 5, FAIL 0** (after build 1, before the fold: 316 —
CLEAN 304, IMPORTED 7, UPSTREAM 5, FAIL 0).

- `HadwigerNelson.DyadicCerts.colorable_four_two_pow` (`Arith/DyadicCerts`, public, new) — [kernel], `[propext,
  Classical.choice, Quot.sound]`: at `Q = 2^f`, `2 ≤ f ≤ 5`, in every field `k` of `Q²` elements the graph
  `x ~ y ⟺ (x − y)^(Q+1) = 1` is four-colourable. Read against X26B-T1's "`U_Q` 4-colourable by an `𝔽₂`-linear colouring
  at every `Q ≤ 32`" (`plans/FS100-X26B-derivation.md` § 2.3).
- `HadwigerNelson.DyadicCerts.charSum_64_ge` (`Arith/DyadicCerts`, public, new) — [kernel], the standard three: in every
  field of `64²` elements every non-trivial additive character sums to real part at least `−15` over `μ₆₅`. Read against
  X26B-T1's "`U₆₄` … `λ_min` −15" (the bound; equality is not stated: `countsOk64 39 = false` shows a class of 40 ones).
- `HadwigerNelson.BinaryField.charSum_ge_of_classes`, `colorable_four_of_check`, `exists_root`, `exists_code_fun`,
  `normOne_eq_image`, `exists_addChar`, `pass_class`, `minimalPeriod_step`, `exists_iterate_step_eq`
  (`Arith/BinaryField`, public, new) — [kernel], the standard three or fewer: the generic bridge (stage 2).
- `DyadicCerts.prim4` … `prim12`, `colour4` … `colour32`, `counts64_ok`, `class64_le` — [kernel], `[propext]` or
  `[propext, Quot.sound]` (each `decide +kernel`, or read from one).
- Private, in `Rigidity/ClassRatio`, now proved — [kernel], the standard three: `colorable_four_dyadic_small`,
  `charSum_64_ge`; so `chromaticNumber_le_four_dyadic`, `ratioAtMost_dyadic`.
- Private, in `Rigidity/ClassRatio`, new by the fold (stage 4) — [kernel], the standard three: `exists_conj_sub_notMem`
  (at an odd stable prime conjugation moves `i` off the prime) and **`norm_charSum_le_of_resT`** (Lemma P's per-character
  bound at every level, as one lemma). FS131-ICM2's odd chain is deleted; its readers read `card_levelSet_oneT` and
  `charBound_of_charBound_oneT` at `θ = i`.
- `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound`, `ratioAtMost_of_two_notMem` (public) —
  `[propext, sorryAx, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`, **their `sorry` from
  `ratioAtMost_cert` alone** (the certificate link at `q ∈ {11, 19}`, which closes when the lines are joined).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm4_quotes.py` (FS131-ICM3's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm4/quotes.out`: **5 quotations, 5 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the dated line of
2026-10-14 "The count is typed" (`data/fs131/claims-NF2.md`), inventory items 905, 922 and 920
(`plans/FS131-close-inventory.md`). Control (`--plant`, `data/fs131/icm4/quotes-plant.out`): one character changed in each
quotation in memory, **5 of 5 reported**. The brief's pointers were read: the last implementer's record
(`plans/FS131-ICM3-implementation.md` § Stage 4's table of the three children, § Stage 5's "What is left of the dyadic
branch"), the two leaves at `Rigidity/ClassRatio.lean` ll. 1649 and 1657, `Arith/Floor128.lean` (661 lines), and X26B-T1's
tool and output (`tools/x26b_uq_colour.py`, `data/fs100/x26b/uq-colour.out`: 10, 36, 68 codimension-2 `𝔽₂`-subspaces
avoiding `μ_{Q+1}` at `Q = 4, 8, 16`; 11 `𝔽₄`-hyperplanes at 32).

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm4/lean/StatementDump.lean` (FS131-ICM3's dumper with `Arith/Floor128` added; the modules `Arith/Floor128`,
`Arith/CircleCos`, `Rigidity/ClassRatio`, `CountCompletion`, `CountDescent`, `CountModels`), run by `lake env lean` under the
slot (`data/fs131/icm4/lean1.sh`) on the tree as given, its compiled library current for `c0b6798ed` (build 4):
`data/fs131/icm4/statements-before.txt` — **537 constants** (Floor128 119, CircleCos 58, ClassRatio 230, CountCompletion 50,
CountDescent 25, CountModels 55; sha256 in `statements-before.sha256`). With the `Floor128` section removed it is
**byte-identical** to FS131-ICM3's last dump (`data/fs131/icm3/statements-after4.txt.xz`), and the comparator
(`tools/fs131_icm4_statements.py`, ICM3's, renamed) reads it against that dump **SAME 72, PRIVATE-SAME 189, CHANGED 0 —
PASS** (`statements-vs-icm3.out`; Floor128's constants NEW-MODULE, since ICM3 did not dump it): the tree holds what the last
implementer left.

### 1.3 The two leaves, as the kernel holds them, beside their routes

*Both private, in `Rigidity/ClassRatio`; printed from `statements-before.txt` (`PP`).*

| leaf | stored statement | route (ICM3 § Stage 4; this job's choice) |
|---|---|---|
| `colorable_four_dyadic_small` | `∀ {f : ℕ}, 2 ≤ f → f ≤ 5 → ∀ (k : Type) [inst : Field k] [inst_1 : Fintype k], Fintype.card k = (2 ^ f) ^ 2 → (SimpleGraph.fromRel fun x y => (x - y) ^ (2 ^ f + 1) = 1).Colorable 4` | per `f`, a primitive polynomial `P` of degree `2f` (a root `g` in every field of `2^{2f}` elements whose powers are the non-zero elements, by the generic bridge) and two exponents `e₁, e₂`: the colour of `x` is `(L₀(g^{e₁}x), L₀(g^{e₂}x))`, `L₀` the coordinate-0 functional; proper because every `u ∈ μ_{Q+1} = {g^{(Q−1)j}}` has `L₀(g^{e₁}u) = 1` or `L₀(g^{e₂}u) = 1`, a check on the register's bit sequence. This is X26B-T1's encoding (`Tr(g^{ia}u)`, `Tr(g^{ib}u)`) with `L₀` for the trace |
| `charSum_64_ge` | `∀ {k : Type} [inst : Field k] [inst_1 : Fintype k] [inst_2 : DecidableEq k], Fintype.card k = 64 ^ 2 → ∀ (ψ : AddChar k ℂ), ψ ≠ 1 → -15 ≤ (∑ u with u ^ (64 + 1) = 1, ψ u).re` | `Floor128`'s route at `2¹²` through the generic bridge: a primitive `P` of degree 12, one pass of the register over its 4,095 states counting the coordinate-0 bit into 63 classes, every class at most 40, so every sum is at least `65 − 2·40 = −15` |

## Stage 2 — SAVED: the bridge — `Arith/BinaryField` (generic in the degree, the polynomial and `Q`); `Floor128` left as it is

**The module** `Proofs/HadwigerNelson/Arith/BinaryField.lean` (559 lines with docstrings and Spec; namespace
`HadwigerNelson.BinaryField`; imports `Arith/Floor128` only, for its generic `ev` lemmas, `digit_sum`, `sum_range_mul_eq`).

| part | lines | content |
|---|---|---|
| the register | 41–194 | `step n P`, `orbitOk`, `primCheck`, `IsPrimitiveCode` (degree `n`; the orbit of `1` has length exactly `2ⁿ − 1`), `orbitOk_iff`, `isPrimitiveCode_of_check`, `step_lt`, `iterate_step_ne_zero` (from the period: `0` is fixed), `minimalPeriod_step`, `iterate_step_injOn`, `exists_iterate_step_eq` |
| evaluation and the root | 195–266 | `ev_step`, `ev_iterate_step`, `exists_ev_iterate_step` (modulo `P` the register multiplies by `t`, at any point), `charP_two_of_card`, **`exists_root`** |
| the field | 267–394 | `root_pow_eq_one`, `ev_ne_zero`, `ev_inj`, `root_pow_inj`, `exists_code`, **`exists_code_fun`** (additive codes; the code of `gᵐ` is the `m`-th state), `exists_root_pow_eq`, `sq_facts`, **`normOne_eq_image`**, **`exists_addChar`** |
| consumers | 395–537 | **`charSum_ge_of_classes`**; `pass`, `pass_snd`, `pass_class` (packed counters modulo `d`); `colourCheck`, **`colorable_four_of_check`** |
| Spec | 538–559 | `step`/`orbitOk` at `x² + x + 1`; `IsPrimitiveCode 2 7` (the inhabitant); refusals `primCheck 2 5`, `primCheck 4 31` (irreducible, not primitive); `pass`; `colourCheck 2 7 2 0 1 = true`, `… 0 0 = false` |

**One change of route from `Floor128`:** the root needs **no cofactor certificate**. `Floor128` proved `P ∣ x^(2¹⁴) + x` by a
4,096-hex-digit quotient `qBig`; here the orbit is the divisibility. In `k[x]` (`CharP 2` by `Polynomial.charP`),
`exists_ev_iterate_step` at `t = x` and `m = 2ⁿ − 1` gives `1 = x^(2ⁿ−1) + P·c`, so `P ∣ x·(x^(2ⁿ−1) − 1) = x^|k| − x`;
that splits in `k` (`splits_iff_card_roots`, `FiniteField.roots_X_pow_card_sub_X`), so `P` splits
(`Polynomial.Splits.of_dvd`) and, of degree `n ≥ 1`, has a root (`Splits.exists_eval_eq_zero`). Likewise the period
needs no factorization of `2ⁿ − 1`: `primCheck` checks every intermediate state against `1`.

**`Floor128` is left as it is.** Its certificate and bridge are proved and kernel-checked; its bridge is this one's
instance at `n = 14`, `P = 16427`, `Q = 128`; making it read this module would invert the import (this module reads
`Floor128`'s `ev` lemmas), rebuild `Floor128` and every dependent, and change no statement. Its public statements are
untouched (stage 3's dump: SAME).

**Elaborated** (`lake env lean` under the slot, `data/fs131/icm4/logs/bf-2.log`: exit 0, no message) and the axioms of the
consumers printed from a copy (`data/fs131/icm4/lean/BFCopy.lean`, `logs/bf-2-axioms.log`): `colorable_four_of_check`,
`charSum_ge_of_classes`, `pass_class` — `[propext, Classical.choice, Quot.sound]`; `isPrimitiveCode_of_check` —
`[propext, Quot.sound]`. (The build is the receipt: stage 3.)

**Re-priced from the first part:** the bridge's first part (register, root, field) ≈ 350 lines against the brief's
400–600; with both consumers and the generic pass, 559.

## Stage 3 — SAVED: the five certificates (`Arith/DyadicCerts`); the two leaves proved; build 1; the job's state from the kernel's side

**The module** `Proofs/HadwigerNelson/Arith/DyadicCerts.lean` (153 lines; namespace `HadwigerNelson.DyadicCerts`; imports
`Arith/BinaryField`). The certificate block (`P4` … `P12`, `E4` … `E32`, `B64`) is generated by `tools/fs131_icm4_certs.py`
(exact integer arithmetic, the register as the module's `step`), which checks itself against X26B-T1 before it prints:

| `Q` | degree, `P` | certificate | control (`data/fs131/icm4/certs.out`) |
|---|---|---|---|
| 4 | 4, `x⁴ + x + 1` (19) | `(e₁, e₂) = (0, 1)` | 10 codimension-2 subspaces avoiding `μ₅` — X26B-T1's 10 |
| 8 | 6, `x⁶ + x + 1` (67) | `(2, 16)` | 36 — X26B-T1's 36 |
| 16 | 8, `x⁸ + x⁴ + x³ + x² + 1` (285) | `(0, 28)` | 68 — X26B-T1's 68 |
| 32 | 10, `x¹⁰ + x³ + 1` (1033) | `(3, 344)`, `344 = 3 + 1023/3`: an `𝔽₄`-hyperplane | 11 `𝔽₄`-hyperplanes — X26B-T1's (G54's) 11 |
| 64 | 12, `x¹² + x⁶ + x⁴ + x + 1` (4179) | class counts `≤ 40` | `max c_r = 40` (at `r = 10`): `λ_min(U₆₄) = 65 − 80 = −15`, X26B-T1's; the sums are `−15, −11, …, 13` |

The enumeration behind each control is X26B-T1's own (the pairs `(Tr(g^{ia}·), Tr(g^{ib}·))` of `tools/x26b_uq_colour.py`,
with the coordinate-0 functional `L₀ = Tr(c·)` in place of the trace), rerun here as an exact check of the generator — no
solver, no search beyond X26B-T1's. `--check` reads the module's block **IDENTICAL** (`certs-check.out`); `--fault` (one bit
of `P12` flipped) **DIFFERS**, exit 1 (`certs-fault.out`); `--plant` (`certs-plant.out`): each colouring with `e₂ := e₁`
(one hyperplane, a two-colouring, which `χ(U_Q) = 4` forbids) and the bound 39 at 64 **FAIL**, as they must.

**Each certificate refuses a planted corrupted entry in Lean, one plant per run** (`tools/fs131_icm4_plant.py`,
`data/fs131/icm4/plant/plants.out`; each plant a copy of the module elaborated through `data/fs131/icm4/farm1.sh`): the
unplanted copy elaborates with no error (the partner), and `P4 := 31` (irreducible, order 5), `P12 := 4097` (`(x³ + 1)⁴`),
`E4`, `E8`, `E16`, `E32` with `e₂ := e₁`, `B64 := 39` are each **REFUSED** by `decide` at the theorem the entry feeds
(`prim4`, `prim12`, `colour4`, `colour8`, `colour16`, `colour32`, `counts64_ok`). **ALL PLANTS FIRED.** The same
refusals stand in the module's Spec as `… = false` examples.

**The leaves.** In `Rigidity/ClassRatio` (proofs and one import line only): `colorable_four_dyadic_small` is
`DyadicCerts.colorable_four_two_pow hf2 hf5 k hk`; `charSum_64_ge` is `DyadicCerts.charSum_64_ge hcard ψ hψ`; the import
`Proofs.HadwigerNelson.Arith.DyadicCerts` added. `Proofs.lean` imports both new modules; `ARCHITECTURE.md` has their rows
and `ClassRatio`'s imports cell and state sentence (`tools/check_architecture.py`: **PASS**, `logs/architecture-1.log`).

**Build 1** under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; `data/fs131/icm4/logs/build-1.log`, full output
`logs/build-1-full.log.xz`, `build/gate/build/20261014T212146Z-676812.log`): **OK — 258 of 258 batches, 9 modules rebuilt,
8 m 58 s, exit 0** (`Arith/BinaryField` 4.5 s, `Arith/DyadicCerts` 5.2 s, `Rigidity/ClassRatio` 31 s, the count's five
modules, `Proofs`). The only warning from this job's files is `ratioAtMost_cert`'s `declaration uses 'sorry'`
(`ClassRatio.lean` line 2078); `BinaryField` and `DyadicCerts` built with none (the build applies `linter.missingDocs`).

**No statement and no definition changed** (`statements-after1.txt` against stage 1's dump; `statements-compare1.out`):
**SAME 136, PRIVATE-SAME 192, CHANGED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL 65, ADDED-GENERATED 2
(`BinaryField.pass.eq_def`, `orbitOk.eq_def`, in their own module), NEW-MODULE 70 (the two new modules' public constants) —
**PASS**, `Floor128`'s 119 constants among the SAME. Five plants fire (`statements-plant1.out`; the private plant now aims
at `colorable_four_dyadic_small`, since stage 4 may delete ICM2's `card_fibre`, the old target).

**Axioms** (`data/fs131/icm4/lean/Axioms.lean`, ICM3's printer with the two new modules; reader `tools/fs131_icm4_axioms.py`
with `--leaves HadwigerNelson.Rigidity.ratioAtMost_cert`; `axioms1-read.out`): **316 records — CLEAN 304, IMPORTED 7,
UPSTREAM 5, FAIL 0.** Every public declaration of `BinaryField` and `DyadicCerts` is CLEAN. UPSTREAM: `ratioAtMost_cert`;
`ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound`, `ratioAtMost_of_two_notMem` over it alone (and Weil);
`count_of_oneAvoidingDensityBound` over `Plane.upperDensity_le_of_oneAvoidingDensityBound` and
`Rigidity.noRamifiedStableDyadic_of_tca` only. Without the leaf list **FAIL 4** (`axioms1-read-noleaves.out`, exit 1); the
planted `sorry` and declared axiom **2 of 2 FAIL** (`axioms1-plant-read.out`; the reader's plant prefix renamed to this job's,
`FS131ICM4Plant.`, after its first run read 0 of 0). The one line to the coordinator was sent.

**Lint** (`lake lint --no-build -- --no-build --trace` under the slot, `logs/lint-1.log`): exit 1 with **one finding, not
this job's** — `HadwigerNelson.Rigidity.archTop` (`Rigidity/ContinuityGroup`), FS131-ICM3's; 13 linters `(2/2) Passed!`;
no finding in `Arith/BinaryField`, `Arith/DyadicCerts` or `Rigidity/ClassRatio`. (That finding is the lint's live positive
control: the linter fires on this tree.)

**Re-priced:** the five certificates ≈ 150 lines in all (the brief's 60–120 each, 300–600), because the bridge carries both
consumers; the whole dyadic remainder ≈ 710 lines against ICM3's 700–1,200.

## Stage 4 — SAVED: the odd Lemma P folded onto `SqZeroInvT` at `θ = i`; build 2; the job's state from the kernel's side

**The fold** (the brief's part 3; `data/fs131/icm4/fold.py`, which edits by content and refuses unless every cut and
replacement matches once; developed on the copy `data/fs131/icm4/lean/ClassRatioFold.lean`, elaborated against the farm,
`logs/fold-1.log`, then copied over the module). `Rigidity/ClassRatio` 2,523 → 1,991 lines (−606, +74):

- **deleted** (FS131-ICM2's odd chain, 48 private constants; `data/fs131/icm4/deleted-odd-chain.txt`): the structure
  `SqZeroInv` with its section (`Kn`, `Kp`, `Kf`, `card_Kp_eq`, `card_Kf_eq`, `card_Kn_sq`, `card_lift`, `sum_Kn`,
  `norm_sum_le`, `pm_of_good`, …), `sqZeroInvAt`, `sqZeroInvAt_σ`, `sqZeroInvAt_K`, `card_Kn_at`, `card_fibre`,
  `card_levelSet_one`, `card_res_fibre`, `card_levelSet_succ`, `norm_charSum_new_le`, `charBound_of_charBound_one`;
- **added** (private): `exists_conj_sub_notMem` (`2 ∉ P` ⟹ `conjO i − i ∉ P`: `(ī − i)·i = 2`), and
  `norm_charSum_le_of_resT` (below);
- **redirected**: the four readers (`ClassRatio`'s `card_levelSet_one P h2 …` twice, `charBound_of_charBound_one P h2 …`
  twice: in `charBound_one_exact`'s and the exclusions' level-one count, in `ratioAtMost_weil`, and in the odd branch of
  `ratioAtMost_of_two_notMem`'s chain) read `card_levelSet_oneT` and `charBound_of_charBound_oneT` at
  `(exists_conj_sub_notMem P h2).choose_spec`; `--` comments that named the deleted chain now name the survivors.

**The coordinator's constraint (2026-10-14, by message): the certificate link's two hypotheses (FS131-IKL1), at odd stable
primes of residue size `11²` and `19²`, stay reachable, each as one private lemma:**
1. **Hensel's count** — `card_res_fibreT P ha hQ n hfin hs : (hfin.toFinset.filter fun x => res P n x = s).card = Q ^ n`
   for `s ∈ levelSet P 1` (every norm-one residue at level one has `Q^n` norm-one lifts at level `n + 1`), at an odd prime
   with `ha := (exists_conj_sub_notMem P h2).choose_spec`. Unchanged by the fold (PRIVATE-SAME).
2. **The per-character bound at every level** — `norm_charSum_le_of_resT P ha hQ n hfin ψ (hψ : ∃ e, res P n e = 0 ∧ ψ e ≠
   1) : ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 / ((Q : ℝ) + 1) * hfin.toFinset.card` over `S_{n+1}` — a character of `𝓞 ⧸ P^{n+1}`
   non-trivial on the kernel of the residue map to level one; `|S_{n+1}| = Q^n(Q + 1)` (`card_levelSet_succT`), so the
   bound is `2Q^n`. New: it was the descent inside `charBound_of_charBound_one`'s proof with `norm_charSum_new_le`; now one
   lemma (induction: descend while the character is trivial on the kernel of the reduction, `card_fibreT`; bound it by
   `norm_charSum_new_leT` where it is new; at level one the kernel is `0`).

**Build 2** under the slot (`logs/build-2.log`, full output `logs/build-2-full.log.xz`,
`build/gate/build/20261014T214646Z-783578.log`): **OK — 258 of 258 batches, 7 modules rebuilt, 8 m 15 s, exit 0**
(`Rigidity/ClassRatio` 20 s, the count's five modules, `Proofs`); the only warning from this job's files is
`ratioAtMost_cert`'s `declaration uses 'sorry'` (`ClassRatio.lean` line 1544). `tools/check_architecture.py`: **PASS**
(`logs/architecture-2.log`; `ClassRatio`'s row names the fold and the two lemmas, and no deleted name).

**No statement and no definition changed** (`statements-after2.txt` against stage 1's dump;
`statements-compare2.out`, with `--fold --deleted-file data/fs131/icm4/deleted-odd-chain.txt`): **SAME 136, CHANGED 0,
MISSING 0, ADDED-PUBLIC 0; PRIVATE-SAME 132, PRIVATE-CHANGED 0, PRIVATE-MISSING 0, PRIVATE-DELETED 48, PRIVATE-HYGIENE 11,
PRIVATE-PROOFARGS 1** — PASS. Two mechanisms moved the stored text of survivors, and the comparator gained a rule for each
(`fold_same`, under `--fold`):
- *hygiene* (11: `SqZeroInvT.Kn`, `.Kf`, `.mem_Kn`, `.mem_Kf`, `.add_mem_Kn`, `.sub_mem_Kn`, `.sum_Kn`, `.norm_sum_le`,
  `.pm_of_good`, `.card_Kn_sq`, `.card_lift`): the instance binders' minted names carry a hygiene context number that the
  deletions above them shifted by one (`inst._@.Proofs.HadwigerNelson.Rigidity.ClassRatio.2658659181._hygCtx._hyg.7` →
  `…2658659180…`); Lean's hash of each stored type and value is unchanged, and the text is equal with that number removed;
- *proof arguments* (1: `sqZeroInvTAt`): its value named the auxiliary proofs `sqZeroInvAt._proof_4`, `_proof_5`, which the
  elaborator had shared from the deleted `sqZeroInvAt`; now generated under its own name (`sqZeroInvTAt._proof_3`,
  `_proof_4`). Its type is equal, and its value is equal once every `<name>._proof_<n>` is one token.

**Controls** (`statements-plant2.out`): with the deletion list but without `--fold`, **FAIL (12)**
(`statements-compare2-nofold.out`); without the deletion list, the 48 read PRIVATE-MISSING, **FAIL**
(`statements-compare2-nolist.out`); planted in memory, each **FIRED**: a surviving name on the deletion list, a deleted
name left off it, one character of a hygiene survivor's type (hash kept), a data change in `sqZeroInvTAt`'s value
(`RingHom.ker` → `RingHom.range`); and the five standing plants.

**Axioms** (`axioms2-read.out`): **273 records — CLEAN 261, IMPORTED 7, UPSTREAM 5, FAIL 0.** `card_res_fibreT`,
`charBound_of_charBound_oneT`, `exists_conj_sub_notMem`, `norm_charSum_le_of_resT`: CLEAN. IMPORTED and UPSTREAM as at
stage 3: `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound`, `ratioAtMost_of_two_notMem` —
`[propext, sorryAx, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`, their `sorry` from `ratioAtMost_cert`
alone; every public declaration of `BinaryField` and `DyadicCerts` CLEAN. Without the leaf list **FAIL 4**; the two
planted records **2 of 2 FAIL** (`axioms2-plant-read.out`).

**Lint** (`logs/lint-2.log`): as at stage 3 — one finding, `Rigidity.archTop` (`Rigidity/ContinuityGroup`), not this
job's; 13 linters passed; none in this job's files.

**Re-priced:** the fold ≈ 75 lines added against 606 removed (no price was given).

## Drafts for the landing

### The audit's block (`scripts/Axioms.lean`, by the landing)

- `Arith/BinaryField`, `Arith/DyadicCerts` (new): 65 `#print axioms` lines, every one CLEAN, in
  `data/fs131/icm4/axioms-block-draft.txt` (the public theorems and definitions of both modules, generated from the
  compiled dump `statements-after2.txt`; structure projections and generated names left out). The `decide +kernel`
  certificates `colour4` … `colour32`, `counts64_ok` read `[propext]`; `prim4` … `prim12`, `isPrimitiveCode_of_check`
  `[propext, Quot.sound]`; `charSum_64_ge`, `colorable_four_two_pow`, `charSum_ge_of_classes`, `colorable_four_of_check`,
  `exists_root` the standard three.
- `Rigidity/ClassRatio`: `ratioAtMost_of_two_notMem`, `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound`
  UPSTREAM through `ratioAtMost_cert` alone — IMPORTED (Weil and the standard three) once the certificate line is joined;
  `tca_uniform`, `exists_uniform_tail` IMPORTED, unchanged.
- `Rigidity/CountDescent`'s `count_of_oneAvoidingDensityBound`: UPSTREAM through lane P's and M9-S's leaves only, unchanged.

### `LEAN.md` § Searching — Lean (each to follow the last)

- A primitive polynomial `P` over `𝔽₂` has a root in every field of `2ⁿ` elements with no cofactor certificate: the
  register's orbit closing after `2ⁿ − 1` steps gives `1 = x^(2ⁿ−1) + P·c` in `k[x]` (`Polynomial.charP` makes `k[x]`
  characteristic 2), so `P ∣ x^|k| − x`, which splits (`splits_iff_card_roots`, `FiniteField.roots_X_pow_card_sub_X`);
  then `Polynomial.Splits.of_dvd` and `Splits.exists_eval_eq_zero` (`BinaryField.exists_root`, FS131-ICM4).
- Deleting declarations moves the stored text of the declarations after them in two ways that change no statement: the
  hygiene context number of instance binders minted in the file shifts (`inst._@.<module>.<n>._hygCtx._hyg.<k>`; Lean's
  hash of the term is unchanged), and a definition whose value named an auxiliary proof first generated by a deleted
  declaration (`sqZeroInvAt._proof_4`) now names its own (`sqZeroInvTAt._proof_3`). A statement check after a deletion
  normalizes exactly these two, each with a plant that a real change still fires (`tools/fs131_icm4_statements.py
  --fold`, FS131-ICM4).

### `LEAN.md` § The kernel's cost model (to follow the last)

- `decide +kernel` on `Nat.iterate` of a three-operation bit register (`testBit`, `<<<`, `^^^`): the 44,000 steps of
  `colourCheck` at `Q = 32` and a 4,095-step pass with 63 packed counters each check in 1–4 s, a module of nine such
  certificates compiling in 5.2 s (`Arith/DyadicCerts`; `data/fs131/icm4/lean/probes/Cost.lean`; FS131-ICM4).
