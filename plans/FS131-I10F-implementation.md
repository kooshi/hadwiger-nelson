# FS131-I10F — wave 10, the second pass's three measure-theoretic files: the implementation record

*de Bruijn, the implementer (Opus 5.5). Branch `fs131-w10f`, cut from `fs131-w10k` at `330d2f48`. Brief:
`data/fs131/briefs/FS131-I10F-wave10-second.md` (on `main`).*

**What I may change**: the proofs of the four leaves — `SpectralInputs.contVec_prod_eq` (`Arith/ProductFactor.lean`),
`MajorityVote.ae_eq_measurable_of_majority` (`Arith/MajorityVote.lean`), `SpectralInputs.exists_parityHom` and
`SpectralInputs.negCircle_trivial_bot` (`Arith/NegCircleModel.lean`); new helper declarations in those three files under names no other
module declares; a block of my own in `scripts/Axioms.lean` headed "FS131-I10F", above the `=== PURCHASED ===` banner; this record;
`tools/fs131_i10f_*.py`; `data/fs131/i10f/`; `data/fs131/reports/FS131-I10F.md`.

**What I may not change**: any statement, hypothesis, conclusion or definition the four statements use (`prodMap₃`, `prodFactorSigma`,
`contVec`, `factorSets`, `factorSigma`, `Interface.NegCircle`, `Interface.trivial`, `unitRing`, `unitVectors`, `uvRing`, `rot`, `RotInv`);
the wave's other files (`NormOneTarget`, `FloorPlanes`, `Floor128`, `TargetFloors`, `GapSeven`, `FactorAction`, `RatioBound`, and the four
first-pass files `CharacterColouring`, `SpectralInputs`, `StationaryRatio`, `StandingFive`); the planner's record; any landed module
beyond new declarations; `main`. No new `axiom`, no `native_decide`. I do not merge another branch and do not run the gate.

## Theorems this phase proved

*(filled at each saved stage; every line is [kernel on this branch] by the build its stage names — the branch does not run the gate, so
the axiom audit is the landing's; the axioms printed here are from `lake env lean` on a scratch file importing the built module.)*

## Stage 1 — SAVED (FS131-I10F): the readback, the branch as given

### 1.1 The brief's quotations against their sources (standing rule 3)

By script (`data/fs131/i10f/logs/quotations.sh`, `grep -F` of each quoted string in the file the brief names; output
`data/fs131/i10f/logs/quotations.txt`): **fourteen of fourteen match** — `CLAUDE.md` § Counter-priors (on `main`); inventory items 509,
510, 500, 503 (`plans/FS131-close-inventory.md` on `main`); the four statements' first lines in my tree; the plan's headings §§ 8.1, 8.2,
8.5, 9.3, 9.4.

### 1.2 Read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch it fail; the planner's
record Stage 6 (§§ 6.1–6.4), Stage 8 (§§ 8.1–8.7), Stage 9 (§§ 9.1–9.6), and its "Theorems this phase proved (FS131-K10b)"; my three
files; `Arith/SpectralInputs.lean` lines 1–62 and 200–763 (the interface's `MulStable`, `NegCircle`, `sp_if` with its proof, and the whole
continuity factor: `contVec`, `factorSets`, `factorSigma`, `mem_factorSets_iff`, `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`);
`SpectralChain.lean` lines 51–230 (`unitVectors`, `unitRing`, `uvRing`, `Dual`, `rot`, `RotInv`, `Interface`, `Interface.trivial`,
`measurable_eval`, `measurable_rot`); `UnitRing.lean` whole; inventory items 500 (first lines), 503, 509, 510, 526 whole;
`plans/FS131-E8-derivation.md` Stage 5 with entry FS131-E8-SI5C and its control.

### 1.3 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: exit 0, "all 1781 modules already up to date",
**23 `sorry` warnings** — `StandingFive` 9, `StationaryRatio` 3, `FloorPlanes` 4, `NormOneTarget` 2, `Floor128` 1, and mine:
`ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2 (`data/fs131/i10f/logs/build-0-as-given.log`).

### 1.4 The four statements, read for truth before any proof (each is true as stated, on paper)

- **`ae_eq_measurable_of_majority`.** `K` is non-empty (a probability space is, and `G` maps into `K`); `p ≥ 0` is implied (`I` is
  non-empty). Along an injective sequence `x : ℕ → I`, off the event `Bad n = {n ≤ 2·#{i < n : ω ∈ E (x i)}}` the value `G ω` is the
  strict majority of `c (x 0) ω, …, c (x (n−1)) ω`; `μ (Bad n) → 0` by Chebyshev for pairwise uncorrelated indicators; along a subsequence
  with summable measures Borel–Cantelli makes `G` almost surely the eventual strict majority, which is a function of `c`. True.
- **`contVec_prod_eq`.** `⊇`: `prodFactorSigma ≤ factorSigma (prodMap₃ …) l` (the first coordinate is eventually fixed, `h₁`; the second
  is `comap_factorSigma_le`). `⊆`: an event `A` with `l`-continuous indicator has sections over `Ω₁ × Ω₂` of `μ₃`-measure 0 or 1 almost
  everywhere (a cylinder approximating `A` is independent of its own shift once the shift moves its coordinates off themselves, `hl`,
  `hind`, `hshift`, `hgen`), so `A` is a.e. a set of the first two coordinates; its fibre over each atom of `Ω₁` is in `factorSets T₂`
  (`h₁` again). `hl` excludes `l = ⊥` and a finite `R`. True.
- **`exists_parityHom`.** A unit vector of `ℚ²` is `(a + bi)/c` with `c` odd and `a² + b² = c²`; on the elements `(a + bi)/c`, `c` odd,
  `(a + bi)/c ↦ a + b mod 2` is a ring homomorphism and sends unit vectors to `1`. True.
- **`negCircle_trivial_bot`.** The point mass at `χ₀ = ψ ∘ π` (`ψ` the non-trivial character of `ZMod 2`): rotation-invariant because
  `π (u·r) = π r`; `S = univ`, `E = ∅`; `∫ Re χ(1) = Re ψ(1) = −1`. True.
