# FS131-IG1 — the five-colour chain: the pieces, PE-1′ and Lemma Γ, proved

*The chain's fourth implementer, lane G (brief `data/fs131/briefs/FS131-IG1-pieces.md`, written 2026-10-14 07:36 UTC, and
its Amendment 1, 07:42 UTC). Branch `fs131-wpg` in the worktree `.claude/worktrees/fs131-wq1`, cut from `fs131-wdg` at
`68c47bb40`; not pushed (the brief: the remote is unreachable). Working files under `data/fs131/ig1/`; checks
`tools/fs131_ig1_*.py`.*

## Theorems this phase proved

Every line is [kernel]. The axioms were printed from the built tree after build 3 by `data/fs131/ig1/lean/Axioms.lean`
(`data/fs131/ig1/axioms-after-3.txt`) and read by `tools/fs131_ig1_axioms.py`. "The standard three" means exactly
`[propext, Classical.choice, Quot.sound]`. Namespace `HadwigerNelson.Rigidity`.

- `PieceDual.continuous_dualMap`: the dual `χ ↦ χ ∘ φ` of an endomorphism is continuous. Standard three.
- `measurable_toPiece`: restriction `R̂ → M̂` is measurable. Standard three.
- `IsPiece.mulR_mem`: a piece is stable under every `γ_n`. Standard three.
- `pieceMul_zero`, `pieceMul_add`: `n ↦ γ_n·` is an action of `ℤ²` on a piece. Standard three.
- `toPiece_rot`: restriction intertwines `rot γ_n` with `α^n`. Standard three.
- `isSolenoid_pieceDual`: **PE-1′, first bullet.** Over a number field, `M̂` is a solenoid for every `M ⊆ R`. The
  unread `IsPiece` binder is dropped. Standard three.
- `isTotallyIrreducible_pieceAction`: **PE-1′, the criterion's (⇐).** The action on a piece is totally irreducible
  (number field). Lemma F is proved here as a private helper. Standard three.
- `not_isVirtuallyCyclic_pieceAction`: **PE-1′, third bullet.** Standard three.
- `isPiece_closure_one`: `ℤ[Γ]·1` is a piece (number field; `ℚ[Γ] = ℚ(Γ) = F(i)`). Standard three.
- `exists_pieceChain`: a monotone chain of pieces exhausting `R` (number field). Standard three.
- `isErgodicOn_map_toPiece`: **Lemma Γ, step 1.** The unread probability binder is dropped. Standard three.
- `integral_eq_zero_of_isAddHaarMeasure`: **Lemma Γ, step 4.** The unread probability binder is dropped. Standard three.
- `ksEntropy_rot_eq_iSup`: **Lemma Γ, step 3.** Standard three and `sorryAx`, only through
  `ksEntropy_eq_iSup_ksEntropyOn` (T2, `Rigidity/Entropy`'s tenth leaf, not mine).
- `isHaarFourier_or_ksEntropy_eq_zero`: **Lemma Γ.** Standard three and `sorryAx`, only through `haar_or_zero_entropy`
  (the printed Theorem 1.2, `Rigidity/PositiveEntropy`'s leaf) and T2, both not mine.

**Consequences.** These were proved already and had rested on `sorryAx` through this module's leaves; they now rest on
the standard three: `pieceMul`, `pieceAction` (their values read `IsPiece.mulR_mem`, `pieceMul_zero`, `pieceMul_add` and
`continuous_dualMap`).

**Private helpers**, each on the standard three:
- Lemma F, in two parts: `finiteIndex_range_nsmul_prime` and `finiteIndex_range_nsmul`.
- `exists_nat_mul_mem_closure`: `ℚ[Γ_Λ] = F(i)`, denominators cleared.
- `exists_nat_mul_mem_of_mem_span`, `isAlgebraic_of_mem_fieldI`, `exists_common_nsmul_mem`, `countable_of_isPiece`,
  `comap_toPiece_mono`, `map_rot_eq`, `ksEntropy_map_toPiece`, `PieceDual.measurableAdd`, `PieceDual.measurable_dualMap`.
- The `mulR` and `γC` lemmas, `pieceToFieldI`, `restrictPiece`.

## Stage 1 — SAVED: the readback, the leaves restated, the stored statements before any edit

### 1.1 The branch and the build

`git checkout -b fs131-wpg` at `68c47bb40` (`fs131-wdg`'s head). The tree's compiled library is current for that commit:
Lake's dry run under the slot (`lake build --no-build`, 4 GiB) prints `All targets up-to-date (6037 jobs).`, exit 0
(`data/fs131/ig1/logs/nobuild-0.log`). Laptop at the start: 31 GB of RAM, 27 available; 330 GB of disk free (82 % used).

### 1.2 The quotations (standing rule 3)

`tools/fs131_ig1_quotes.py` (FS131-IDG1's checker, aimed at this brief) checks each `> ` run of the brief against its
source on the main checkout, byte for byte. **All six match** (`logs/quotes.out`, exit 0): W2 in
`data/fs131/REQUEST-2026-10-13.md`; NF2-LEAF-20 and the dated line of 2026-10-14 in `data/fs131/claims-NF2.md`;
inventory items 761, 775 and 782 in `plans/FS131-close-inventory.md`. **The planted control** changes one digit in each
quotation and requires each to mismatch: "plant fires" six times (`logs/quotes-plant.out`, exit 0). No finding about the
brief. Amendment 1 (the coordinator's message of 07:42, the same text appended to the brief on disk) quotes one phrase
of `Rigidity/Pieces`' module docstring; it occurs there, split across lines 34–35, and is replaced as the amendment says
(stage 2).

### 1.3 The leaves, each restated in one line beside its plan

`Rigidity/Pieces`, 15 `sorry`s. `R = unitRing F`, `R̂ = Dual F`; `M : AddSubgroup R`; `M̂ = PieceDual M =
Additive (AddChar M Circle)`; `p : AdmissiblePair F` with `Γ = p.subgroup`, `γ_n = zpowHom p.u p.w (ofAdd n)`. Plans:
`plans/FS131-KN8-chain-split.md` § 2.5, `Rigidity/Pieces` items 1–7 and 10–14 (numbered as there); items 8 and 9 as
re-pointed by `plans/FS131-KPD1-pontryagin.md` § 4.2.

| # | leaf | the statement, in one line | the plan's route |
|---|---|---|---|
| 1 | `PieceDual.continuous_dualMap` | `χ ↦ χ ∘ φ` is continuous on `M̂` | `continuous_induced_rng`; each coordinate an evaluation |
| 2 | `measurable_toPiece` | restriction `R̂ → M̂` is measurable | `measurable_of_evalChar` |
| 3 | `IsPiece.mulR_mem` | a piece is stable under multiplication by every `γ_n` | the generating set is; `closure_le` |
| 4a | `pieceMul_zero` | multiplication by `γ_0` on `M` is the identity | `zpowHom` at `0` is `1` |
| 4b | `pieceMul_add` | multiplication by `γ_{m+n}` is the composite of `γ_m` and `γ_n` | `map_mul`, `mul_comm` |
| 5 | `toPiece_rot` | restriction intertwines `rot γ_n` on `R̂` with `α^n` on `M̂` | `rfl` up to coercions |
| 8 | `isSolenoid_pieceDual` | `[NumberField F]`: `M̂` is a solenoid | compact, T2, group from `DualGroup`; connected by D3 (`connectedSpace_dual`, `M` torsion-free); `dual_embeds` by D1 (`additiveDualDualEquiv`) into `M ⊆ F(i) ≅ ℚⁿ` |
| 9 | `isTotallyIrreducible_pieceAction` | `[NumberField F]`: every closed `α_Λ`-invariant `Y ⊆ M̂`, `Λ` of finite index, is finite or `⊤` | `N = Y^⊥`; `N = 0` gives `⊤` (D2's case); `N ≠ 0`: `ℚN = F(i)`, `M ⧸ N` finite (Lemma F's consequence), `Y ⊆ N^⊥` finite |
| 6 | `not_isVirtuallyCyclic_pieceAction` | `α` is not virtually cyclic | `α^m = α^{kn}` at a nonzero `x ∈ M` gives `γ_m = γ_{kn}`, `m = kn`; a cyclic subgroup of `ℤ²` has infinite index |
| 7 | `isPiece_closure_one` | `[NumberField F]`: `ℤ[Γ]·1` is a piece | `fg` at `{1}`; full rank: `ℚ[Γ] = ℚ(Γ) = F(i)` (`Γ` algebraic), clear denominators |
| 10 | `exists_pieceChain` | `[NumberField F]`: a monotone chain of pieces exhausting `R` | enumerate `R`; `M_k` generated by `1, r₀, …, r_{k−1}` |
| 11 | `isErgodicOn_map_toPiece` | the image on a piece of a `Γ`-invariant `Γ`-ergodic probability is `α`-invariant and ergodic | `toPiece_rot`, invariance; a strictly invariant set pulls back to a `Γ`-invariant one |
| 12 | `ksEntropy_rot_eq_iSup` | along such a chain, `h_ρ(γ_n) = ⨆_k h_{ρ_k}(α^n)` | T2 over `𝒜_k = π_k⁻¹(ℬ(M̂_k))`, each read by `ksEntropy_map` |
| 13 | `integral_eq_zero_of_isAddHaarMeasure` | if `ρ_M` is Haar on `M̂`, `∫ χ(r) dρ = 0` for `0 ≠ r ∈ M` | `integral_map`; translation by a `ψ₀` with `ψ₀(r) ≠ 1` |
| 14 | `isHaarFourier_or_ksEntropy_eq_zero` | **Lemma Γ**: `[NumberField F]`, `ρ` a `Γ`-invariant `Γ`-ergodic probability on `R̂`: `IsHaarFourier ρ` or every `γ ∈ Γ` has entropy zero | the chain; 12 for a late positive piece; `haar_or_zero_entropy` there; 13 |

**What the leaves read that is not proved** (the brief: "use them as stated"): `haar_or_zero_entropy`
(`Rigidity/PositiveEntropy`, the printed Theorem 1.2, a leaf there) in leaf 14, and T2,
`ksEntropy_eq_iSup_ksEntropyOn` (`Rigidity/Entropy`, its tenth leaf) in leaf 12. **Lemma F is not typed in the library**
(KN3's plan says it is "stated once, in C0", but no declaration of `Rigidity/ChainAtTA` or anywhere on this branch holds
it; `grep`): leaf 9 proves it as a private helper.

### 1.4 The stored statements before any edit

`data/fs131/ig1/lean/StatementDump.lean` is FS131-IDG1's dumper aimed at `Rigidity/Pieces`, at the seven modules whose
docstrings this job edits from IDG1's drafts (`DualGroup`, `Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`,
`UnitCircle`, `ZeroEntropyNames`), and at `EntropySplitMax`, `Pieces`' one importer but `Proofs`. Run on the built tree
before any edit: `data/fs131/ig1/statements-before.txt` (committed compressed as `.xz`; 7.6 MB), 388 constants —
`DualGroup` 51, `Annihilator` 27, `SubgroupHaar` 15, `Duality` 37, `DualConnected` 4, `UnitCircle` 58,
`ZeroEntropyNames` 112, `Pieces` 74, `EntropySplitMax` 10. The modules declare no axiom.

The reader is `tools/fs131_ig1_statements.py` (IDG1's, aimed here). **Against itself:** PASS — 219 named constants
(kinds and types), 54 data definitions' values, 2 ruled definitions' data views (`AdmissiblePair.ofPow`,
`Duality.graphSubgroup`, both proved already), 6 example heads (`logs/statements-self.out`). **Its control** plants
eight faults and all 8 are reported, "the check can fail" (`logs/statements-control.out`): a changed stored type
(`isTotallyIrreducible_pieceAction`), a changed definition value (`pieceAction`), a missing leaf (`exists_pieceChain`),
a theorem made a definition (`toPiece_rot`), a new public constant off the allow-list, an axiom, a moved data field of a
ruled definition, and a changed statement in the downstream `EntropySplitMax`.

## Stage 2 — SAVED: the fifteen leaves proved in a copy

**Amendment 1 applied** (prose only): `Rigidity/Pieces`' module docstring, ll. 34–35, "at each piece, with
`[PolishSpace (PieceDual M)]` from `Rigidity.polishSpace_dual`." → "at each piece (it takes no `PolishSpace` since
FS131-KN9)." (the line wrap kept). The skeleton with that edit is `data/fs131/ig1/work/Pieces.skeleton.lean`.

**Written in a copy** (`data/fs131/ig1/work/Pieces.lean`; `LEAN.md`, FS124-I5's line), four elaborations under
`data/fs131/ig1/lean1.sh` (`logs/lean-pc-1.log` … `lean-pc-4.log`): the first with leaves 1–5 (exit 0, nine `sorry`s left);
the second with all fifteen (four errors, two linter warnings); the third and fourth after the repairs and the two ruled
differences below — **exit 0, no `sorry`, no warning**, 10 s. The probes of names at the pin are
`data/fs131/ig1/probes/Names*.lean` (logs `lean-names-1.log` … `-4.log`). Re-price (Done means item 2): leaves 1–5 went
through on the first elaboration, about 20 minutes from the first line; the other ten were then priced at an hour and
took about 40 minutes with three repairs.

**The routes** (KN8 § 2.5 and KPD1 § 4.2 unless said; private helpers named):
- 1 `continuous_dualMap`: `continuous_induced_rng`, `continuous_pi`, `continuous_evalChar`. 2 `measurable_toPiece`:
  `measurable_of_evalChar`. 3 `IsPiece.mulR_mem`: `closure_le` into the comap (helper `mulR_add_apply`).
  4 `pieceMul_zero`, `pieceMul_add`: `mulR_zero_apply`, `mulR_add_apply`, `add_comm`. 5 `toPiece_rot`: `rfl`.
- 8 `isSolenoid_pieceDual`: as planned — `connectedSpace_dual` at `M`, torsion-free through the injective
  `pieceToFieldI`; `dual_embeds` is `(additiveDualDualEquiv M).symm` followed by `M → F(i) ≅ ℚⁿ`
  (`Module.finBasis ℚ (fieldI F)`).
- 9 `isTotallyIrreducible_pieceAction`: as planned, with Lemma F proved here (not typed in the library, stage 1):
  `finiteIndex_range_nsmul_prime` (`G ⧸ qG` is an `𝔽_q`-space of dimension at most `[F(i) : ℚ]` — the argument of
  `main`'s `ThreeColourCriterion.finite_quotient_span_prime`, for a group with an injective map into `F(i)`) and
  `finiteIndex_range_nsmul` (products by `relIndex_mul_index` and `index_comap_of_surjective`). `N = Y^⊥` is
  `Λ`-stable; `ℚN = F(i)` by `exists_nat_mul_mem_closure` at `Λ` (below) applied to `x/y`; one integer kills `M ⧸ N`
  through the coset representatives `[0, i)²` of `ℤ² ⧸ Λ` (`i = [ℤ² : Λ]`) and `exists_common_nsmul_mem`.
- 6 `not_isVirtuallyCyclic_pieceAction`: as planned; the infinite index of `ℤn` read off `i·e₀, i·e₁ ∈ ℤn`.
- 7 `isPiece_closure_one`: `exists_nat_mul_mem_closure` at `Λ = ⊤` — the `γ_n` are algebraic
  (`isAlgebraic_of_mem_fieldI`), so `Subfield.closure = IntermediateField.adjoin` has the carrier `Algebra.adjoin`
  (`adjoin_toSubalgebra_of_isAlgebraic`), the `ℚ`-span of the monoid of the `γ_n` (`Algebra.adjoin_eq_span`), and
  denominators clear (`exists_nat_mul_mem_of_mem_span`); carried to `R` by `AddMonoidHom.map_closure`.
- 10 `exists_pieceChain`: as planned. 11 `isErgodicOn_map_toPiece`: as planned (helper `map_rot_eq`;
  `aeconst_of_forall_preimage_smul_ae_eq`, `Filter.eventuallyConst_set'`). 12 `ksEntropy_rot_eq_iSup`: T2 over
  `𝒜_k = comap (toPiece (M k))` — monotone (`comap_toPiece_mono`, through `restrictPiece`), generating (the cylinder
  σ-algebra is `⨆_r` of the evaluations' comaps), countably generated (`countable_of_isPiece`, `BorelSpace` and second
  countability of the dual) — each term by `ksEntropy_map_toPiece`. 13 `integral_eq_zero_of_isAddHaarMeasure`: as
  planned, `MeasurableAdd (PieceDual M)` a private theorem used by `haveI` (no instance added). 14 Lemma Γ: as planned
  (thirty lines).

**Two ruled differences in the statements** (both reported to the coordinator at once):
- `isSolenoid_pieceDual` **drops its unread binder `(hM : IsPiece p M)`** (inventory item 726's standing word; the
  coordinator's message of the same hour: "fine as you describe: listed, with its callers checked"): `M̂` is a solenoid
  for every `M ⊆ R` over a number field — the proof reads no piece. Its one caller is Lemma Γ in this file
  (`isSolenoid_pieceDual (M := M k)`); no other module of the tree names it (`grep`: two docstrings only).
- `exists_pieceChain`'s existential binder `hM` is renamed `_hM` (the coordinator's ruling, option (a)): the name is
  read by nothing, and once the proof is in the unused-variables linter warns at the statement, where no proof can reach
  it. The condition: the stored type differs from before in that binder's name only (stage 3's check).

## Stage 3 — SAVED: the proofs over the module; the rows and docstrings from FS131-IDG1's drafts

**The module.** `data/fs131/ig1/work/Pieces.lean` copied over `Proofs/HadwigerNelson/Rigidity/Pieces.lean`. Against the
skeleton (`work/Pieces.skeleton.lean`) the file loses only the 15 `sorry` lines, four proof heads (`:= by` → `:=`:
`continuous_dualMap`, `measurable_toPiece`, `pieceMul_zero`, `toPiece_rot`) and the two ruled statement texts of stage 2;
it gains the proofs, the private helpers and one import line (`Mathlib.Algebra.Group.Subgroup.Finsupp`, for
`AddSubgroup.mem_closure_range_iff` in `countable_of_isPiece`).

**`ARCHITECTURE.md`** — the six rows of FS131-IDG1's drafts, verbatim from its record (§ Drafts for the landing):
`DualGroup`, `Annihilator` (with `isClosed_setOf_apply_eq_one` added to its proved list after `dualCoannihilator_top`),
`SubgroupHaar`, `Duality`, `DualConnected` ("skeleton: n leaves `sorry`" → "proved by FS131-IDG1: no `sorry`";
"**Leaves:**" → "**Proved (FS131-IDG1):**"), `UnitCircle` ("proved by FS131-IDG1 but lane A's `exists_admissiblePair`,
skeleton: 1 leaf `sorry`"). **`tools/check_architecture.py`: `RESULT: PASS`** (`logs/arch-1.out`). **Its control**: a copy
with `Rigidity/Duality` struck from `Pieces`' imports cell fails, `FAIL imports of Rigidity/Pieces: stated-only [],
real-only ['Rigidity/Duality']`, exit 1 (`work/ARCHITECTURE.plant.md`, `logs/arch-plant.out`). The `Pieces` row itself
(still "skeleton: 15 leaves `sorry`") is not in my touches: drafted below.

**The docstrings** (`data/fs131/ig1/work/docstrings.py`, which refuses unless each passage occurs once in its block): the
titles of the six modules ("skeleton" → "proved by FS131-IDG1", `UnitCircle` "… but `exists_admissiblePair`");
`Annihilator`'s "**The converse … is Pontryagin duality** (`Rigidity/Duality`), not proved here." → "(`Rigidity/Duality`,
`dualAnnihilator_dualCoannihilator_of_isClosed`), proved there."; `measure_frequentVisits_le`'s docstring
(`ZeroEntropyNames`): "stated under this library's name until lane P's port is joined; its proof is then that theorem" →
"stated under this library's name; its proof is the port's `Outside.OAI015.excessiveOccupation_measure_bound`" — its
proof is that term (read in the source). **Prose only, in text**: `tools/fs131_ig1_code_only.py` (IDG1's, with its
repaired plant) reads all seven files SAME as `HEAD` with every block comment removed (`logs/code-only.out`); its plant
(the last `:=` of each file → `:≡`) reads all seven DIFFERS, "plant: OK" (`logs/code-only-plant.out`). **From the
kernel's side** the seven modules were dumped before the build (`data/fs131/ig1/lean/DocDump.lean`, IDG1's with one
`PROOF <hash>` line per theorem added, so that proofs are compared too; `docdump-before.txt.xz`, 304 constants, 252
theorems), to be compared after it (stage 4).

## Stage 4 — SAVED: three builds, two more ruled drops, the checks from the built tree

**Build 1** (`data/fs131/ig1/build.sh 1 8`, the slot at 10 GiB and 4 CPUs): `==> build: OK — 249 of 249 batches, 10
module(s) rebuilt, 5 module(s) with warnings, 7m38s`, `exit=0` (`logs/build-1.log`; full output
`build/gate/build/20261014T080506Z-2252505.log`; peak 3.50 GiB for one process). Rebuilt: the seven docstring modules,
`Pieces`, `EntropySplitMax`, `Proofs`. `Pieces` built with no warning (`✔`). Its statement dump showed one new public
constant, `pieceAction.congr_simp`, which `push Not` generated in Lemma Γ's proof (`simp` making a congruence lemma for
a definition with a proof argument). The `push Not` is replaced by `not_not` (a proof edit), and **build 2**
(`logs/build-2.log`, 7m0s, `exit=0`) generates no such constant.

**The lint after build 2 was red, and correctly so** (`logs/lint-1.log`, exit 1): `unusedArguments` named
`isErgodicOn_map_toPiece` and `integral_eq_zero_of_isAddHaarMeasure`, argument `[IsProbabilityMeasure ρ]` in each.
Neither proof reads it: ergodicity and a vanishing Fourier coefficient need no total mass. **Both binders are dropped**
under item 726's standing word. Their callers are Lemma Γ (the instance is not positional) and my model drafts, and no
other module names them (`grep`). That makes four ruled differences, listed below.
**Build 3** (`data/fs131/ig1/build.sh 3 8`): `==> build: OK — 249 of 249 batches, 3 module(s) rebuilt, 5 module(s) with
warnings, 7m7s`, `exit=0` (`logs/build-3.log`; full output `build/gate/build/20261014T083711Z-2343931.log`).
Rebuilt: `Pieces` (8.5 s), `EntropySplitMax`, `Proofs`. **No warning from `Pieces`** (`✔ … Built
Proofs.HadwigerNelson.Rigidity.Pieces`). The build prints no warning that is not `declaration uses 'sorry'`, and those
come from `Entropy` (T2), `PositiveEntropy` (`haar_or_zero_entropy`), `ChainAtTA` (three leaves), `UnitCircle` (lane A's
leaf) and `EntropySplitMax` (six leaves), none of them mine. **`sorry` in `Pieces`: 0** (`grep -c`).

**From the built tree after build 3:**
- *Statements* (`tools/fs131_ig1_statements.py statements-before.txt statements-after-3.txt 68c47bb40 --dropped
  dropped.txt`, `logs/statements-compare.out`): **PASS**. In the nine modules, 219 named constants agree in kind and type,
  54 data definitions agree in value, the 2 ruled definitions' data views agree, and the 6 `example` heads are
  unchanged. There is **no new public constant**, no axiom, and 25 new private helpers. The four **RULED DROP**s are
  `isSolenoid_pieceDual`, `exists_pieceChain`, `isErgodicOn_map_toPiece` and `integral_eq_zero_of_isAddHaarMeasure`.
  **Its control** (`logs/statements-compare-control.out`) plants 8 faults and reports all 8.
- *The four ruled differences, exactly* (`tools/fs131_ig1_ruled.py`, `logs/ruled.out`): **PASS**.
  - `exists_pieceChain`: the stored type is the old one with the single `fun (hM : ` renamed `fun (_hM : `, and its hash
    is unchanged (1327684456). This is the coordinator's condition.
  - `isSolenoid_pieceDual`: the old type was printed `…, (IsPiece F p M) -> (BODY)` (an arrow, since the body never read
    the hypothesis). The new type is that with the arrow, the body's parentheses and `{p : AdmissiblePair F}` removed.
  - The two instance drops: each new type is the old one with the binder ` [inst : IsProbabilityMeasure …]` removed.
  **Its control** (`logs/ruled-control.out`) changes one character of each of the four new types, and all 4 are reported.
- *The seven docstring modules* (`tools/fs131_ig1_docdump_diff.py docdump-before.txt docdump-after-3.txt`,
  `logs/docdump-compare.out`): **PASS: identical**. All 304 constants match line for line, internal ones included,
  with every theorem's proof hash. **Its control** (`logs/docdump-compare-control.out`) reports all 3 planted faults.
- *Axioms* (`data/fs131/ig1/lean/Axioms.lean` → `axioms-after-3.txt`, read by `tools/fs131_ig1_axioms.py`,
  `logs/axioms-check.out`): **PASS**. `Pieces` has 60 records, private helpers included.
  - **58 CLEAN**: each rests on a subset of the standard three.
  - **2 THROUGH**: each rests on the standard three and `sorryAx`, and its `sorry` comes only from leaves of other
    modules. `ksEntropy_rot_eq_iSup` reaches it through `ksEntropy_eq_iSup_ksEntropyOn` (T2, `Rigidity/Entropy`).
    Lemma Γ, `isHaarFourier_or_ksEntropy_eq_zero`, reaches it through that and `haar_or_zero_entropy` (`Rigidity/PositiveEntropy`).
  - **0 DECLARED**: nothing reaches the declared theorem yet, because `haar_or_zero_entropy` is a `sorry`.
  - **No `sorry` of `Pieces`' own.** The planted record (`positive_entropy_rigidity_of_polishSpace`) reads DECLARED.
  - **Downstream** (`EntropySplitMax`, 9 records): 3 rest on no `sorry`. The `sorry` of the other 6 comes only from
    that module's own six leaves, none from `Pieces`.
  **Its control** (`logs/axioms-check-control.out`) plants 4 faults, all reported, and the planted record fires: a `sorry`
  of `Pieces` itself, an unknown axiom, a `sorry` from a leaf outside the allowed two, and a downstream record whose
  `sorry` comes from `Pieces`.
- *Linters* (`lake lint --no-build -- --no-build --trace` under the slot, `logs/lint-2.log`): `exit=0`, `-- Linting
  passed for Proofs.`, 14 linters `(2/2) Passed!`. The control is real: `logs/lint-1.log` was red on build 2's two
  unread binders and named both.
- *Doubled names* (`./scripts/dupnames.sh` under the slot, `logs/dupnames-1.log`): `OK — no name is declared by two
  modules (24 generated on demand)`, `exit=0`. The scan reports that no repeated name appeared or disappeared since this
  tree's previous complete run.
- *Spec examples*: the 6 `example`s of the nine modules elaborate in each build and their heads are unchanged (the
  statement reader's text side).
- *Models* (`data/fs131/ig1/work/ModelDrafts.lean` against the built tree, `logs/lean-models-2.log`, exit 0). The same
  file with a planted `example : (1 : ℕ) = 2 := rfl` fails (`logs/lean-models-plant.log`, exit 1). The contents are in
  the drafts below.

**Re-price** (Done means item 2): leaves 1–5 took about 20 minutes. The other ten were then priced at an hour and took
about 40 minutes with three repairs. After that the time went to the builds, about 7 minutes each, three of them.

## Drafts for the landing

### `scripts/Axioms.lean` — the CLEAN block

`data/fs131/ig1/audit-block.lean` was generated from build 3's axiom print by `tools/fs131_ig1_audit_block.py`
(IDG1's generator, aimed at `Pieces`). It has **31 `#print axioms` lines**, one per public record of `Pieces` on the
standard three; Lean's generated names (`casesOn`, `recOn`, …) are left out. Lemma Γ and step 3 are left out and listed
in a comment, each with the leaves its `sorry` comes from.
- **Once T2 lands** (`ksEntropy_eq_iSup_ksEntropyOn`), `ksEntropy_rot_eq_iSup` joins CLEAN.
- **Once `haar_or_zero_entropy` lands** on the declared Theorem 1.3, Lemma Γ belongs in IMPORTED, resting on
  `positive_entropy_rigidity`: a record the audit's IMPORTED section must list.

**Slot:** the end of CLEAN, just above the PURCHASED banner, beside FS131-IDG1's block (`data/fs131/idg1/audit-block.lean`)
when the chain lands.

### `ARCHITECTURE.md` § 3, the row of `Rigidity/Pieces` (outside my touches)

- "**FS-131 (FS131-KN8), skeleton: 15 leaves `sorry`.**" → "**FS-131 (FS131-KN8, proved by FS131-IG1): no `sorry`;
  `ksEntropy_rot_eq_iSup` and Lemma Γ rest on `sorryAx` through `Rigidity.ksEntropy_eq_iSup_ksEntropyOn` (T2) and
  `Rigidity.haar_or_zero_entropy` until those land.**"
- "**Proved:** `dualMap_apply`, `dualMap_id`, `dualMap_comp`." → "**Proved:** all; Lemma F
  (`G ⧸ mG` finite for a group in `F(i)`) as a private helper."
- The imports cell is right as it stands. The new import `Mathlib.Algebra.Group.Subgroup.Finsupp` is Mathlib's, and
  `tools/check_architecture.py` passes.

### `Rigidity/Pieces`' module docstring (outside my touches but the amendment's phrase)

- The title "(FS-131, job FS131-KN8; module M6 of `plans/FS131-KN3-chain-plan.md`; skeleton)" → "…; proved by FS131-IG1)".
- After "PE-1′ (X02D l. 146): `M̂` is a solenoid (`isSolenoid_pieceDual`)" add ", for every `M ⊆ R` over a number field —
  the proof reads no piece".
- The **Models.** paragraph gains: "Lemma Γ's hypothesis and PE-1′'s, at the first piece and the point mass, are
  inhabited given an admissible pair (FS131-IG1's `ModelDrafts`, to be added as `example`s here)".

A docstring edit in `Pieces` recompiles `EntropySplitMax` and `Proofs` only.

### Models of the hypotheses, for the landing's reading

The vacuity scan has no tracked carrier among `Pieces`' binders, so it is silent here (`LEAN.md` § The gate, the
silent-module clause). For each structure of hypotheses, its model and whether the library holds it:

| statement(s) | hypotheses | model | in the library? |
|---|---|---|---|
| `continuous_dualMap`, `measurable_toPiece`, `toPiece` | none beyond the types | every `M`, `φ` | yes |
| `IsPiece.mulR_mem`, `pieceMul_*`, `pieceAction`, `toPiece_rot`, `not_isVirtuallyCyclic_pieceAction` | `IsPiece p M` | `ℤ[Γ]·1` (`isPiece_closure_one`), given `p` | given `p` only: `exists_admissiblePair` is lane A's open leaf |
| `isSolenoid_pieceDual` | `[NumberField F]` | every `M`; `F = ⊥` (`Instances.UpperHalfValues.instNumberFieldBot`, downstream) | yes |
| `isTotallyIrreducible_pieceAction`, `isPiece_closure_one`, `exists_pieceChain` | `[NumberField F]`, `p` (and `IsPiece p M`) | the first piece, given `p` | given `p` only |
| `isErgodicOn_map_toPiece`, `ksEntropy_rot_eq_iSup`, **Lemma Γ** | `ErgodicSMul p.subgroup (Dual F) ρ` (with probability where read) | the point mass at the trivial character (`FS131IG1Models.ergodicSMul_dirac_one`, drafted) | **no** — drafted, given `p` |
| PE-1′ as a model of the printed Theorem 1.2's hypotheses (`haar_or_zero_entropy`) | solenoid, totally irreducible, not virtually cyclic, an invariant ergodic probability | the first piece and the point mass's image (`FS131IG1Models.pe1_model`, drafted) | **no** — drafted, given `p`. The **non-degenerate model** the earlier planners named: every clause is exercised, unlike the one-point solenoid |
| `integral_eq_zero_of_isAddHaarMeasure` | `(ρ.map (toPiece M)).IsAddHaarMeasure`, `0 ≠ r ∈ M` | inside Lemma Γ's proof, at a late piece where `haar_or_zero_entropy` returns Haar. Outside: `ρ = dualHaar (unitRing F)`, whose image under the onto continuous homomorphism `toPiece M` is Haar | **no** — the second is not proved here (it needs onto-ness, D3's `surjective_compAddMonoidHom`, and open-positivity of Haar), a short job if a model is wanted |
| the declared Theorem 1.3's `NoVirtuallyCyclicFactors` at a piece | — | FS105-NVC, inside `haar_or_zero_entropy`'s proof (lane M5) | not mine |

The drafts are `data/fs131/ig1/work/ModelDrafts.lean`: `ergodicSMul_dirac_one`, `firstPiece`, `pe1_model`, and an
`example` applying Lemma Γ at the model. They elaborate against the built tree (`logs/lean-models-2.log`). **Slot:** each
as an `example` (or a theorem named `…_model`) at the end of `Rigidity/Pieces`. Every one of them takes `p`, and becomes
unconditional with `exists_admissiblePair`.

### `LEAN.md` § Searching — Lean (Keryx files; each a new bullet at the section's end)

- `ℚ[Γ] = ℚ(Γ)` for algebraic generators, with no polynomial written: `IntermediateField.adjoin_toSubalgebra_of_isAlgebraic` (the name `adjoin_algebraic_toSubalgebra` is deprecated at the pin) makes the subfield's carrier `Algebra.adjoin`, `Algebra.adjoin_eq_span` and `Submonoid.closure_eq` make that the `ℚ`-span of the monoid the generators form, and one `Submodule.span_induction` clears denominators (`Rat.smul_def`, `Rat.mul_den_eq_num`, `linear_combination`). An element of a number-field subfield `K` of `ℂ` is algebraic over `ℚ` as `((IsIntegral.of_finite ℚ (⟨x, hx⟩ : K)).map K.subtype.toRatAlgHom).isAlgebraic` (`Rigidity.exists_nat_mul_mem_closure`, private; FS131-IG1).
- Lemma F (`A` torsion-free with an injective map into a number field `K`: `A ⧸ mA` finite) as an index: at a prime the argument of `main`'s `ThreeColourCriterion.finite_quotient_span_prime` runs for any such group with `ZMod q` acting on `A ⧸ qA`; at a product `AddSubgroup.relIndex_mul_index` and `AddSubgroup.index_comap_of_surjective` along `(nsmulAddMonoidHom b).rangeRestrict`, whose comap of `abA` is `aA` by `nsmul_right_injective` (`Rigidity.finiteIndex_range_nsmul`, private; FS131-IG1).
- An `AddSubgroup.closure` of a countable set is countable with no lemma of its own at the pin: `AddSubgroup.mem_closure_range_iff` (import `Mathlib.Algebra.Group.Subgroup.Finsupp`) makes `(ι →₀ ℤ) → closure (range f)` onto, and `ι →₀ ℤ` is countable for countable `ι` (`Rigidity.countable_of_isPiece`, private; FS131-IG1).
- A statement that binds a name inside a proposition (`∃ hM : P, Q` with `Q` not reading `hM`) is silent under `sorry` and warns once proved (`unusedVariables`, at the statement, where no proof reaches): bind it as `_hM` at the skeleton (`Rigidity.exists_pieceChain`, FS131-IG1; the coordinator's ruling).
- `Measure.map_map` does not see the coercion of a `ZdAction` at a point through a lemma stated at its body (`Measurable (dualMap φ)`): state `Measurable (α n)` first and rewrite with that (`Rigidity.isErgodicOn_map_toPiece`). `eventuallyConst_set'` is `Filter.eventuallyConst_set'`. In `γ '' ⊤` the `⊤` elaborates as `Set.univ`; the image of a subgroup `⊤` is `γ '' ((⊤ : AddSubgroup _) : Set _)` (FS131-IG1).
- A coset representative of `n ∈ ℤ²` modulo a finite-index `Λ` needs no quotient: `i = [ℤ² : Λ]` gives `n - (n % i) = i • (n / i) ∈ Λ` (`AddSubgroup.nsmul_index_mem`, `Int.emod_def`), and `n % i ∈ [0, i)²` by `Int.emod_nonneg`, `Int.emod_lt_of_pos`, `omega` on `Int.toNat` (`Rigidity.isTotallyIrreducible_pieceAction`, FS131-IG1).

## Drafts for the front page

None for this job. No milestone closes with it: the chain lands as one unit, and Lemma Γ waits on two leaves of other
modules. The gate's whole-library counts belong to the landing that joins the chain to `main`. Its rows are the audit
block above and the theorems listed in this record.

## Stage 5 — SAVED: the drafts

The drafts above. Nothing of this job is running or queued.

## Stage 6 — SAVED: the report

`data/fs131/reports/FS131-IG1.md`, the same text as the hand-back. Nothing of this job is running or queued. The branch
`fs131-wpg` is not pushed (the brief). The tree's compiled library is current for the branch head after build 3 (the
commits after it touch no Lean file).
