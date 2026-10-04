# FS131-I2 — wave 2 implementation record

*Implementer: de Bruijn (Sonnet 5.5). Branch `fs131-w2`, worktree `.claude/worktrees/fs131-w2`. Brief: `data/fs131/briefs/FS131-I2-wave2.md`.*

## Theorems this phase proved

(Filled at the gate from the saved audit log; leaves closed so far are listed per stage.)

## Stage 1 — SAVED: `main` merged; 13 leaves closed (Arith, MaximalCover, one shared exhaustion)

**Merge.** `main` merged into `fs131-w2` (`0b97dd89`), no conflicts. Baseline build green with only `declaration uses sorry`
(`build/gate/build/20261004T064408Z-1712030.log`).

**Leaves closed** (statements untouched; one leaf moved, `exists_isMUA_ae_le`, from `Plane/CoverExamples` to `Plane/Cover` as the plan allows):
- `Arith/FalconerField`: `falconerFan_five_mem_eight`, `not_falconerFan_five_of_fanGap`, `falconerFan_five_mem_P`.
- `Arith/Dyadic`: `sqrt3_dyadic`.
- `Plane/MaximalCover`: `AeColouring.exists_fill`, `exists_isMaximalCover`, `IsMaximalCover.interior_union_unitShadow`,
  `IsAdmissible.exists_aeColouring`, `isMaximalCover_iff`, `IsRegularMUA.interior_eq_compl_unitShadow`, `IsRegularMUA.component_side`.
- `Plane/Cover` (moved leaf): `exists_isMUA_ae_le`.

**Shared children stated** (all in `Plane/Cover`, sorry-free): `UnitPairsNull.congr_ae`, `volume_prod_shift_null`, `exists_ae_maximal`
(the measure-maximizing exhaustion: a predicate closed under a.e. equality of measurable sets and increasing unions has an
a.e.-maximal element above any member), `essSupport_eq_support`, `isClosed_essSupport`, `volume_diff_essSupport`,
`essSupport_mono_ae`, `exists_annulus_subset_compl`, `ae_restrict_mem_densitySet` (Besicovitch), `volume_diff_densitySet`,
`upperDensityAt_eq_zero_of_null`, `essSupport_eq_closure_densitySet`, `subset_densitySet_of_isOpen_ae_subset`;
in `Plane/MaximalCover`: `IsMUA.interior_union_unitShadow`.

**Tooling.** `tools/fs131_i2_fill.py` replaces a named leaf's `sorry` by a body from a file (refuses if the next `sorry` is not that
theorem's). Iteration uses a scratch olean farm (never evidence).

## Stage 2 — SAVED: BAND, `not_semiconcaveWith_one_lowerArc`, `fatZ_spec`; one ruling

**Ruling** (Keryx, `plans/FS131-close-inventory.md` item 48; the only statement change of this job): `vesica_apex_exact` is false for `h ≤ -2`
(apex `2i`: `dist z (2i) ≥ 2 − z.im > 1` for every `z.im < 1`); the hypothesis `(h0 : 0 ≤ h)` is added, the row's "depth". Proved in that form.
The wider `-2 < h` is not stated.

**Leaves closed** (cumulative 18 of 71): `not_semiconcaveWith_one_lowerArc` (explicit triple `s = 3/20`, `h = 1/25`, rational sqrt bounds),
`band_excludes_horn`, `le_one_of_band_unitFree`, `vesica_apex`, `vesica_apex_exact`, `fatZ_spec`.
