# FS133-IB1 — the invariant laws and the section density: two files of lane B of the one-class transfer's kernel module

*de Bruijn, the implementer; job FS133-IB1 (brief: `data/fs133/briefs/FS133-IB1-laws-and-density.md`, on `main`).
Branch `fs133-wb1`, cut from `1dd2b4acd` (the first implementer's head, branch `fs133-wa1`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.2 (lane B), with §§ 5.0, 5.5, 6.
Working files: `data/fs133/ib1/`. Files of the module this job writes:
`Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` and `…/SectionDensity.lean`, proofs and private helpers
only.*

## Theorems this phase proved

(Filled at the last stage, from the built tree.)

## Stage 1 — SAVED: the readback, the leaves restated, the statements as the kernel holds them before any edit

**1.1 The brief's quotations.** `tools/fs133_ib1_readback.py` (FS133-IA1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **5 matched, 0 mismatched**, exit 0
(`data/fs133/ib1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-INV-CLASS,
K133-NC-INV-CLASS, K133-DENS-CLASS and K133-NC-DENS-CLASS against `data/fs133/claims-K1.md`. With `--fault` (the
last character of each quoted line changed): 0 matched, 5 mismatched, exit 1 (`readback-brief-fault.out`). No finding
about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's stages 1–4, § 5.0, § 5.2, § 5.5, § 6 and § 4.2; the first implementer's record (its head, stages
1, 5, 6 and the drafts) and its report; the three files of the lane (`InvariantLaw`, `SectionDensity`, `Defs`).

**1.3 Each leaf, in one line, beside the plan's route.** Fourteen `sorry`s: eight in `InvariantLaw`, six in
`SectionDensity`. The file's text is the statement; the line is a reading.

| leaf | the statement, in one line | the plan's route (§ 5.2) |
|---|---|---|
| **I1** `IsShiftInvariantLaw.measure_origin_le` | a translation-invariant law `P` of any graph `G` on `E` has `P {I | I 0 = true} ≤ G.finIndepRatio` | for each nonempty finite `S`: `∑_{g ∈ S} P{I g} = ∫ #{g ∈ S | I g}`, each term `P{I 0}`, the integrand at most `indepNum` almost surely |
| child `countable_algPlane` | `Countable E` | `Algebraic.countable`, as the release's `E_countable` |
| **I2** `exists_foelner_finset` | a countable `ℚ`-vector space `A` has nonempty finite `F n` with `#{a ∈ F n | a + z ∉ F n} / #F n → 0` for every `z` | a `ℚ`-basis enumerated; boxes of points with coordinates `c i / n!`, `|c i| ≤ n · n!`, on the first `n` basis vectors |
| **I3** `exists_shiftInvariant_of_foelner` | for a Følner sequence `F` in `E`, a closed `C ⊆ E → Λ` that every translation preserves, and `ℓ n ∈ C`: a probability `P` with `P Cᶜ = 0`, `P.map (shiftLab z) = P` for all `z`, and `ofReal c ≤ P {ℓ' | ℓ' 0 = a}` whenever `c · #F n ≤ #{r ∈ F n | ℓ n r = a}` for all `n` | averages of point masses at the translates of `ℓ n` over `F n`; a cluster point in the compact space of probabilities; each claim a closed condition met up to an error tending to `0` |
| **I4** `exists_turnInvariant` | from a translation-invariant probability `P₀` carried by a closed `C` that translations and rotations preserve: a probability carried by `C`, invariant under both, with `P₀`'s law of the label at the origin | a generic child `exists_common_fixed` (countably many commuting continuous maps, a closed class stable under Cesàro averages; one map by Krylov–Bogolyubov, then nested closed sets), no Markov–Kakutani |
| **I5** `exists_isInvariantLaw` | for `S ⊆ E` with `kCoeff u * s ∈ S`: an invariant law of `circulantGraph S` with `P {I | I 0 = true} = (circulantGraph S).finIndepRatio` | `C` := indicators of independent sets, closed and invariant; I2 at `A := E`; `ℓ n` an independent subset of `F n` of the ratio's size; I3 at `a := true`; I4; `≤` by I1 |
| **I6** `norm_kCoeff_mul` | `‖(kCoeff u * z : E)‖ = ‖z‖` in `ℂ` | `norm_mul`, the modulus of a point of the circle |
| **I7** `unitDistance_algPlane_eq_circulantGraph` | `unitDistance E = circulantGraph {z : E | ‖z‖ = 1}` | `SimpleGraph.ext`; `dist a b = ‖a − b‖` |
| **D1** `sectionDensity_univ` | the whole space has section density `1` along windows of finite non-zero measure | unfold, `ENNReal.div_self`, `limsup_const` |
| **D2** `sectionDensity_empty` | the empty set has section density `0` | the same |
| **D3** `measurable_sectionDensity` | for measurable `W` and measurable windows of finite measure, `ω ↦ sectionDensity lam Xn W ω` is measurable | `measurable_measure_prodMk_right` for `lam.restrict (Xn n)`; a constant divisor; `Measurable.limsup` |
| **D4** `le_lintegral_sectionDensity` | if in each window almost every `x` has `α ≤ μ {ω | (x, ω) ∈ W}`, then `α ≤ ∫⁻ sectionDensity dμ` | Tonelli on each window; `limsup_lintegral_le` with the bound `1` |
| **D5** `measure_le_sectionDensity_pos` | then `0 < μ {ω | α ≤ sectionDensity ω}` | by contradiction: `D < α` almost everywhere, so `∫⁻ D < α` |
| child `ofReal_integral_le_measure_pos` | for measurable `h ≤ 1` on a probability space, `ofReal (∫ h) ≤ μ {0 < h}` | `h ≤ 1_{h > 0}` pointwise; not integrable ⇒ the integral is `0` |

**1.4 The statements as the kernel holds them, before any edit** (the build as the first implementer left it, for
`1dd2b4acd`). `data/fs133/ib1/lean/StatementDump.lean` (FS132-I2's dumper, its body unchanged; the full print and
the print with instance and proof arguments erased) prints every named constant of the two modules:
`data/fs133/ib1/moved/before.out.xz` (sha256 of the uncompressed print in `before.sha256`) — **19 constants**:
`InvariantLaw` 10 theorems, `SectionDensity` 1 definition and 8 theorems; no private declaration. Against the first
implementer's last dump of the eight modules (`data/fs133/ia1/moved/built.out.xz`), by `tools/fs133_ib1_moved.py`
(its reader, this job's copy): **19 IDENTICAL** (`moved/before-vs-ia1-built.txt`) — the tree is as it was handed
back. The reader's control on this dump: each of four plants read as planted (`moved/control-before.txt`).

A second instrument for a file not yet built: `data/fs133/ib1/footer.sh` appends
`data/fs133/ib1/lean/Footer.lean.inc` to a working copy and prints the same dump of the constants the copy itself
declares, and the axioms of each of its public theorems, under `lake env lean` (iteration only; the build is the
receipt).
