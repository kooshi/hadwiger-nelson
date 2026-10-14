# FS131-IJ1 — the five-colour chain: the join of its proof line with the map's and the count's modules; the ring map made one; M10, M2a, M3, M2b

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ1-join-m10-m2.md` (on `main`). Branch `fs131-wt3`, cut from
`fs131-wt2` at `cea54d08e` in the worktree `.claude/worktrees/fs131-wq1`; `fs131-wk12` (at `f6898c132`) merged into it.
Working files: `data/fs131/ij1/`. Laptop: 12 cores, 31 GB.*

## Theorems this phase proved

(Filled at the saved stages below; each [kernel] with its axioms as printed from a built tree.)

## Stage 1 — SAVED: the join, its build, the readback, the stored statements before any edit

**1.1 The join.** `git merge-tree` reported `ARCHITECTURE.md` alone in conflict, as the brief said. Merge commit
`3ae198eac` (`--no-ff`, parents `cea54d08e` and `f6898c132`): the conflict was one block, this line's eight rows
(`SolenoidErgodic` … `UnitCircle`, each "proved by …") against the other line's thirteen new rows (`Herglotz` …
`CountDescent`) followed by the base's eight old rows for the same eight modules; the old rows were checked to be the
merge base's (`fec557c9a`) line for line and dropped, both sides' other rows kept (21 → 8 + 13). `fs131-wk12` touches no
Lean file this line touches (it adds fourteen modules and their imports in `Proofs.lean`).

**1.2 The joined tree builds** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build0.log`, gate log
`build/gate/build/20261014T135108Z-3273743.log`): `OK — 256 of 256 batches, 15 module(s) rebuilt, 20 module(s) with
warnings, 7m53s`, exit 0 — the fourteen new modules and `Proofs`; every warning ``declaration uses `sorry` ``. The one line
was sent to the coordinator.

**1.3 The brief's quotations** (standing rule 3; `tools/fs131_ij1_quotes.py`, FS131-ITT1's reader unchanged in logic,
against `main`'s tree): **7 quotations, 7 MATCH** (`logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two
dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 832, 850, 847
(`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn, each planted
quotation MISMATCH and the other six MATCH, 7 of 7 (`logs/quotes-plant.log`). No finding about the brief.

**1.4 The stored statements before any edit.** `data/fs131/ij1/lean/StatementDump.lean` (FS131-ITK1's dumper aimed at the
ten modules this job's edits can reach: the seven it writes — `ChainAtTA`, `CountResidue`, `CountCompletion`,
`ContinuityGroup`, `Herglotz`, `InvariantMeasure`, `BochnerTau` — and the three downstream of them it does not —
`CountTorus`, `CountExtension`, `CountDescent`), run on the joined build before any edit: `statements-before.txt` (13 MB;
committed as `.xz`, sha256 in `statements-before.sha256`), 216 constants (137 named, 79 internal). The reader is
`tools/fs131_ij1_statements.py` (ITK1's, with the two ruled changes made checkable, § 2.3). Against itself: PASS
(`statements-self.out`).

**1.5 `AdmissiblePair.ofPow`** (item 847 ruling 3): on the joined branch `Rigidity/UnitCircle.lean`'s `def
AdmissiblePair.ofPow` and its proof are `fs131-wt1`'s text, byte for byte (the 22 lines from the keyword, md5 equal on
`fs131-wt1` and `fs131-wt3`; `fs131-wk12`'s differs — its `sorry` version — and the merge did not take it: `fs131-wk12`
never changed that file after the base). Its stored type and axioms from the built tree are printed in stage 5.

**1.6 Each leaf, its statement in one line, beside its plan** (plans: `plans/FS131-KR1-chain-map.md` on `fs131-wk12`, §§ 2.1–2.3
and the table of § 4.3). `R = unitRing F`, `L = fieldI F`, `V = L ⊗ ℝ` (the mixed space), `T + A = TA F`.

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| M10 `ContinuityGroup` | `isTopologicalAddGroup_tauPrime` | `τ′_∅` is a group topology | `topologicalAddGroup_inf` of `topologicalAddGroup_iInf` and `topologicalAddGroup_induced` |
| | `isCountablyGenerated_nhds_tauPrime` | the `τ′_∅`-neighbourhoods of `0` are countably generated | `nhds_inf`, `nhds_iInf`, comaps of `pure` and of the mixed space's neighbourhoods |
| | `TA_subset_contChars` | `T + A ⊆` the `τ′_∅`-continuous characters | torsion: locally constant on cosets of `N·R`; arch: the lift is a real combination of `ℚ`-coordinates, continuous for the mixed embedding |
| | `mem_archChars_of_continuousAt` | a character continuous at `0` for `archTop` has an additive real lift | (hard) lattices `5^{−k}c₀𝓞_L`, stabilisation, density |
| | `archContinuousAt_pow_of_mem_contChars` | a `τ′_∅`-continuous character has a non-zero power continuous at `0` for `archTop` | `Re χ > 0` on `N·R ∩ B_δ`; `|arg χ^N| < π/(2k)` on `B_{δ/(Nk)}` |
| | `contChars_subset_TA` | the `τ′_∅`-continuous characters `⊆ T + A` | the two above and `mem_torsion_mul_arch_iff` |
| M2a `Herglotz` | `exists_almostInvariant_weights` | finitely supported weights `w n ≥ 0`, `Σ (w n)² = 1`, `Σ_x w(x) w(x + z) → 1` for every `z` | convolutions of uniform weights on progressions; Young's inequality |
| | `exists_fejer_measures` | a positive-definite `C` is the coefficientwise limit of finite measures on `Ĝ` of mass `C 0` | density `Σ w(x)w(y)C(x−y)χ̄(x−y)` times `dualHaar`; `isHaarFourier_dualHaar` |
| | `exists_fourier_eq_of_tendsto` | measures of bounded mass with convergent coefficients have a finite limit point with those coefficients | Prokhorov on the compact dual |
| M3 `InvariantMeasure` | `exists_shiftInvariant_on` | a shift-invariant probability measure on a closed shift-invariant nonempty `K` | average push-forwards of a point mass with the weights `(w n)²`; a limit point |
| | `exists_rotInvariant_of_shiftInvariant` | rotation averages of a shift-invariant measure on `K` give one invariant under both | the same over the unit vectors, `shift_y ∘ rot_u = rot_u ∘ shift_{uy}` |
| M2b `BochnerTau` | `finite_quotient_nsmul` | `R ⧸ N·R` is finite, `N ≥ 1` | finite subsets of `R` span free groups of rank `≤ [L:ℚ]` |
| | `archimedean_support` | a finite measure on `R̂` with `archTop`-continuous transform is carried by `A` | (hard) tightness on the lattices' duals, Prokhorov on `V*`, uniqueness |
| | `exists_twisted_parts` | a `τ′_∅`-continuous transform splits as `Σ_{t ∈ T} ψ_t` with each `t̄ψ_t` positive-definite and arch-continuous | (hard, first) twisted Riemann sums, uniform continuity, `finite_quotient_nsmul` |
| | `bochnerOn_tauPrime` | Bochner for `τ′_∅` | M2a on each part, `archimedean_support`, the sum, uniqueness |

## Stage 2 — SAVED: the replacement of `Counting.toL` by `ofUnitRing`; the two lemmas of `ChainAtTA` made public

**2.1 One map, from the kernel's side** (`data/fs131/ij1/probes/OneTerm.lean`, importing `CountResidue` and `TateModel` on
the joined build; `OneTerm.out`): `theorem FS131IJ1_toL_eq_ofUnitRing (F : Subfield ℝ) : Counting.toL F = ofUnitRing F :=
rfl` is accepted (axioms `[propext, Classical.choice, Quot.sound]` — the `rfl` itself reads none; the print is of the
probe's environment). Both stored types are one expression (hash `3608629697` each, `types equal: true`; neither takes
`[NumberField F]`). Both stored values are printed in full; they differ as stored, and are equal once the names of their
three auxiliary proofs (`Counting.toL._proof_1…3`, `ofUnitRing._proof_1…3`) are identified — the two definitions are the
same text, `RingHom.codRestrict (unitRing F).subtype (fieldI F) fun r => UnitRing.unitRingOver_le_planeOverSubring F r.2`.

**2.2 The edit.** `Rigidity/CountResidue.lean`: `def toL` deleted; `import Proofs.HadwigerNelson.Rigidity.TateModel` added;
`toL_mem_localRing` **renamed** `ofUnitRing_mem_localRing` (its statement `ofUnitRing F r ∈ P.localRing`, its `sorry`
kept: it is lane Λ2's leaf); `toLocal`'s value and `exists_unitRing_of_normOneL`'s statement re-pointed.
`Rigidity/CountCompletion.lean`: `ιG`'s value re-pointed. `Counting.finite_quot` untouched (item 847 ruling 2 is lane Λ2's).
`Rigidity/ChainAtTA.lean`: `private` removed from `mem_torsion_mul_arch_iff` and `exists_rat_coords`, nothing else (no
other module declares either name).

**2.3 Build 1** (`logs/build1.log`; gate log `build/gate/build/20261014T140104Z-3311078.log`): `OK — 256 of 256 batches, 21
module(s) rebuilt, 20 module(s) with warnings, 9m4s`, exit 0 — `ChainAtTA` and the twenty modules downstream of it or of
`CountResidue`; every warning a `sorry`.

**2.4 No statement changed but the ruled ones, from the kernel's side** (`statements-before.txt` against build 1's
`statements-b1.txt`, `.xz` + sha256; `tools/fs131_ij1_statements.py … 3ae198eac --deleted deleted.txt --renamed
renamed.txt --publicized publicized.txt --allow-new allow-new.txt`): **PASS** (`statements-compare-b1.out`) — 135 named
constants, 39 data definitions' values, 3 example heads; no new public constant beyond the ruled ones; and exactly these,
each named:
- **RULED DELETE** `Counting.toL`.
- **RULED RENAME** `Counting.toL_mem_localRing → Counting.ofUnitRing_mem_localRing`; its stored type equal after the
  substitution, up to the hygienic hash Lean mints from a theorem's name into its two instance-binder tokens
  (`inst._@.…CountResidue.<hash>._hygCtx._hyg.6`) — the reader blanks that hash for a renamed constant only.
- **RULED SUBST**, the stored term equal to the first dump's with `Counting.toL` read as `ofUnitRing` (and the renamed
  theorem by its new name), compared on the term with Lean's hash token stripped: the **type** of
  `Counting.exists_unitRing_of_normOneL`, the **values** of `Counting.toLocal` and `Counting.ιG`. These are every stored
  term of the ten modules that mentioned `toL`.
- **RULED PUBLIC** `mem_torsion_mul_arch_iff`, `exists_rat_coords`: the private constants of the first dump are the public
  ones of the second, kind, stored type and module identical.
- The downstream modules `CountTorus`, `CountExtension`, `CountDescent` — and `CountResidue`'s other 70 constants, under the
  new import of `TateModel` — unchanged: the import moved no stored instance.

**The controls.** `--control` plants nine faults (an M10 leaf's type, `archTop`'s value, an M2a leaf missing,
`count_of_oneAvoidingDensityBound`'s type downstream, `tauPrime` moved, a new public constant, an axiom, a leaf become a
definition, and **a reader of the replaced map whose stored type differs by more than the name**): 9 of 9 reported
(`statements-control-b1.out`). Without the ruled lists the same two dumps FAIL with 10 differences, naming every ruled one
(`statements-compare-b1-unruled.out`): the reader's substitution is off unless `toL` is listed as deleted.
