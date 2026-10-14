# FS131-IJ2 — the five-colour chain: one attribute on `archTop`; M3 (`InvariantMeasure`) and M2b (`BochnerTau`)

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ2-m3-m2b.md` (on `main`). Branch `fs131-wt4`, cut from
`fs131-wt3` at `1e438c171` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ij2/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

(Filled at each saved stage; the axioms are printed from the built tree at the build stage.)

## Stage 1 — SAVED: the readback, the leaves beside their plans, the stored statements before any edit

**1.1 The brief's quotations** (standing rule 3; `tools/fs131_ij2_quotes.py`, FS131-IJ1's reader unchanged in logic, against
`main`'s tree): **5 quotations, 5 MATCH** (`data/fs131/ij2/logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`),
the two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823 and 863
(`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn, each
planted quotation MISMATCH and the other four MATCH, 5 of 5 (`logs/quotes-plant.log`). No finding about the brief.

**1.2 The tree.** `lake build --no-build` under the slot: "All targets up-to-date (6113 jobs)", exit 0
(`logs/nobuild0.log`): the compiled library is current for `fs131-wt3` at `1e438c171`, as the brief says.

**1.3 Each leaf, its statement in one line, beside its plan** (plans: `plans/FS131-KR1-chain-map.md` § 2.1, § 2.2 and the
table of § 4.3; the last implementer's notes, `plans/FS131-IJ1-implementation.md` § 5.5). `R = unitRing F`,
`X = R → Fin 4`, `T + A = TA F`.

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| M3 `InvariantMeasure` | `exists_shiftInvariant_on` | `R` countable, `K ⊆ X` nonempty, closed, measurable and shift-stable ⇒ a probability measure on `X` with `μ Kᶜ = 0`, fixed by every shift `c ↦ c(· + y)` | average the push-forwards of `δ_c` with the weights `(w n)²`; a limit point (§ 4.3); or (IJ1 § 5.5) a cluster point in `FiniteMeasure K` |
| | `exists_rotInvariant_of_shiftInvariant` | `K` closed, measurable and rotation-stable, `μ₀` a shift-invariant probability with `μ₀ Kᶜ = 0` ⇒ a probability with `μ Kᶜ = 0`, fixed by every shift and every rotation `c ↦ c(u ·)` | the same averaging over the unit vectors, `shift_y ∘ rot_u = rot_u ∘ shift_{uy}` |
| | (composed) `invariantMeasureOnClosed_of_countable` | `InvariantMeasureOnClosed F` when `R` is countable | the two leaves |
| M2b `BochnerTau` | `finite_quotient_nsmul` | `R ⧸ N·R` is finite for `N ≠ 0` (number field) | finite subsets of `R` span free groups of rank `≤ [L:ℚ]` |
| | `archimedean_support` | a finite measure on `R̂` whose transform is `archTop`-continuous is carried by `archChars R` | (hard) lattices `5^{−k}c₀𝓞_L`, tightness, Prokhorov on `V*`, uniqueness |
| | `exists_twisted_parts` | a finite `σ` with `τ′_∅`-continuous transform `φ`: `φ = Σ_{t ∈ T} ψ_t` pointwise (`HasSum`), each `t̄·ψ_t` positive-definite and `archTop`-continuous, `Σ_t Re ψ_t(0)` summable | (hard, first) twisted Riemann sums over `R ⧸ N′R`, Cauchy by uniform continuity of `φ` |
| | `bochnerOn_tauPrime` | `BochnerOn (tauPrime F)` | M2a on each part, `archimedean_support`, the sum, uniqueness |

**1.4 The stored statements before any edit.** `data/fs131/ij2/lean/StatementDump.lean` (FS131-IJ1's dumper aimed at the
eight modules this job's edits can reach: the three it writes — `ContinuityGroup` (the attribute), `InvariantMeasure`,
`BochnerTau` — and the five downstream of `ContinuityGroup` that the attribute recompiles — `CountTorus`, `CountResidue`,
`CountCompletion`, `CountExtension`, `CountDescent`), run on the current build before any edit: `statements-before.txt`
(13.4 MB; committed as `.xz`, sha256 in `statements-before.sha256`), 189 constants (49, 3, 4, 13, 70, 33, 6, 11 by module).

**1.5 Class binders** (item 847's defect). Each of the three files declares one section variable, `variable (F : Subfield
ℝ)` (`ContinuityGroup` l. 35, `InvariantMeasure` l. 29, `BochnerTau` l. 32): no section declares a class binder, so no
stored type can lack one. The files declare no instance; their definitions are `ContinuityGroup`'s `profTop`, `archTop`,
`tauPrime` and the private `archHom`, `fivePow`, each with its written binders in its stored type (`archTop`, `tauPrime`,
`archHom` carry `[NumberField ↥F]`, as written; `profTop`, `fivePow` none). No finding.
