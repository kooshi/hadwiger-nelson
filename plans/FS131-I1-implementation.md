# FS131-I1 — wave 1 of the Lean backlog: the implementation record (de Bruijn, the implementer)

Brief: `data/fs131/briefs/FS131-I1-wave1.md`. Branch `fs131-w1`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w1`.

## Theorems this phase proved

All 28 on exactly `[propext, Classical.choice, Quot.sound]` (read from `build/gate/axioms/20261004T055957Z-1493361.log` in the worktree, lines
for the wave-1 block; 28 of 28; no `sorryAx`, no purchase). Row = the backlog row read against (`plans/FS131-kernel-plan.md` § 6.2).

- `HadwigerNelson.Plane.dist_ne_one_of_mem_densitySet` — FS111-V0-ID1's engine (set form, G92)
- `HadwigerNelson.Plane.AeColouring.dist_ne_one` — FS111-V0-ID1
- `HadwigerNelson.Plane.upperDensityAt_pos_of_mem_densitySet` — FS111-V0-ID1 (child)
- `HadwigerNelson.Plane.hullset`, `hullset_of_isCompact` — FS129-SR2-HULLSET (carrying FS111-C-HULL; preconnected, G1)
- `HadwigerNelson.Plane.hull2` — FS111-M-HULL2
- `HadwigerNelson.Plane.dist_ne_one_of_mem_interior_densitySet` — FS111-M2-INT
- `HadwigerNelson.Plane.subset_densitySet_of_isOpen`, `dist_ne_one_of_mem_of_mem_closure` — FS129-SR2-CLOSURE
- `HadwigerNelson.Plane.dist_lt_one_of_isPreconnected`, `dist_lt_one_of_forall_dist_ne_one`, `dist_lt_one_of_closure_inter_nonempty` — FS106-DIAM (i), (ii)
- `HadwigerNelson.Plane.dist_lt_one_of_chain` — FS106-TS-C
- `HadwigerNelson.Plane.phi_univ`, `unitPairsNull_iff_ae_phi_eq_zero`, `isMUA_iff_ae_phi_pos`, `isMUA_iff_ae_eq` — FS111-M2-ZERO
- `HadwigerNelson.Plane.ringPt_sub_ringPt`, `dist_ringPt_ringPt`, `dist_ringPt_ringPt_cmp_one` — FS116-V4-CHORD
- `HadwigerNelson.Plane.twoCirc_identity`, `twoCirc_cmp_one`, `exists_sign_of_equilateral` — FS129-SR1-TWOCIRC
- `HadwigerNelson.Plane.xcorner` — FS121-D1-XCORNER
- `HadwigerNelson.Arith.noAffine` — FS129-SA1-NOAFF-K (carrying FS84-S1-S1e)
- `HadwigerNelson.Arith.rhombus_falconerFan`, `falconerFan_hom` — FS129-SA1-FALC-FAN
- `HadwigerNelson.Arith.falconerFan_chromaticNumber` — FS129-SA1-FALC-DICHO-K (second clause unconditional, G4)

No statement of the skeleton was changed. No axiom, no `native_decide`.

## Stage 1 — SAVED: the readback

Brief's quotation of § 6.1 checked against `plans/FS131-kernel-plan.md` § 6.1: matches ("The implementer may: add lemmas (children) anywhere in
the wave's modules, add supporting lemmas to the foundation modules … It may not change any statement below"). I may add children, change
imports (updating ARCHITECTURE's Imports cell), and may not change a statement; wave 1 lands by merging `main` into `fs131-w1`, re-running the
gate, and fast-forwarding `main`. The worktree's build was current (one `build.sh` run: all 1726 modules up to date).

## Stage 2 — SAVED: the leaves

Children added (all with docstrings): in `Plane/UnitPairs` (a foundation module) `continuous_e`, `e_add_pi`, `pairSet` and its Tonelli family
(`measurableSet_pairSet`, `pairSet_measure_eq_lintegral`, `pairSet_null_iff_ae_slice`, `unitPairsNull_iff_ae_slice`, `volume_slice_swap`,
`measurable_arcLength_slice`); `Plane/Chord`: `e_pi_div_two`, `e_neg`, `e_ne_zero`, `norm_e_sub_e_le`, `twoCirc_diff`; `Plane/DensityPoints`:
`exists_angle_of_norm_eq_one`, `exists_interval_near`, `exists_mem_slice_null`, `measure_inter_closedBall_le`, `volume_real_closedBall`,
`preconnected_dist_lt_or_gt`; `Plane/Diameter`: `chain_step`; `Plane/UnitAvoiding`: `measurable_phi`, `ae_arcLength_shift_pi`,
`exists_ball_pos_inter`; `Arith/NoAffine`: `finsum_update_apply`, `exists_perm_pair`.
Imports changed: `Plane/DensityPoints` now imports `Plane/Chord` (ARCHITECTURE Imports cell updated); `Arith/NoAffine` imports
`Mathlib.Tactic.Linarith`.

**Route changes against the plan.** (1) Leaf 1 (I-D1) was proved by the *direction-first* Tonelli, not the plan's point-first count:
`UnitPairsNull A` gives, for arc-a.e. direction `θ`, a null slice `{x ∈ A, x + e θ ∈ A}`; one such `θ` in a one-sided interval at `θ₀` gives
`|A ∩ B̄(x,r)| ≤ |B̄(y,2r) \ A|` by translation, against `δ|B̄(x,r)| ≤ |A ∩ B̄(x,r)|` and `|B̄(y,2r) \ A| ≤ (δ/8)|B̄(y,2r)|`, in real numbers via
`toReal`. No ENNReal subtraction is needed. (2) Leaf 16's pair symmetry is not a standalone lemma: it is the slice identity
`volume_slice_swap` (translate by `e θ`, `e (θ+π) = −e θ`) plus `ae_arcLength_shift_pi` (a `2π`-periodic a.e.-zero function is a.e.-zero after
a shift by `π`, by two translations of a null set), so the disc-by-disc maximality argument runs at the slice level, with no integral over a
periodic shift. (3) The mixed `Fin`/`ℕ` induction of the chain (leaf 12) is `Nat.le_induction` upward and an induction on the distance downward.
`planner's "unknown at the pin"` `Complex.volume_closedBall` was absent, as warned; the ball areas come from `Measure.addHaar_real_closedBall'`.

**Re-price (from the first two leaves, `LEAN.md` § The kernel's cost model).** Leaves 18–20 (chord) and 26–28 (fans) were as priced or cheaper
(a handful of lines to a few dozen each, first try or one fix); the only two hard leaves, 1 and 16, were each about a hundred lines and a
handful of iterations, as the plan said; the planner's 300–450k estimate for the whole wave was high. The cost sat in ENNReal/real
bookkeeping (leaf 1) and in finding the right invariant at the slice level (leaf 16), not in anything conceptual. The harness count at the end of
stage 4 is in the report.

## Stage 3 — SAVED: the gate (commit `c5616a81` is the tree these numbers were read on; main merged in, Lean files unchanged afterwards)

All saved logs are under the worktree's `build/gate/`; the figures below were read from them, not from the digest lines.

- **Build** (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): after deleting the compiled artifacts of the ten
  wave-1 and foundation modules (so no hand-compiled `.olean` from iteration remained), **OK — 440 of 440 batches, 10 modules rebuilt, 0 modules
  with warnings** (`build/gate/build/20261004T054522Z-1392464.log`, 0 occurrences of "warning").
- **Axioms** (`scripts/axioms.sh`): **OK — 1285 clean, 11 axiom-free, 5 declared purchases** (1301 records; the foundation gate read 1257 + 11 + 5 =
  1273); the 28 new records, lines 1478–1505 of `build/gate/axioms/20261004T055957Z-1493361.log`, all `[propext, Classical.choice, Quot.sound]`;
  the five purchases unchanged and the ledgers agree.
- **Vacuity** (`scripts/vacuity.sh`): **OK**, `declarations=7624 refutations-skipped=319 sites=279 vacuous=0 stale=0 declared=3 witnessed=17
  generic=257 unknown=2` (`build/gate/vacuity/20261004T060000Z-1493724.log`). Reconciled against the foundation's 7557 / 314: +67 declarations
  (the 28 leaves, the children above, and the internal auxiliaries the scan counts), +5 refutations, which an `#eval` over the two namespaces
  names exactly: the four `≠` statements `dist_ne_one_of_mem_densitySet`, `AeColouring.dist_ne_one`, `dist_ne_one_of_mem_interior_densitySet`,
  `dist_ne_one_of_mem_of_mem_closure` (a `≠` conclusion reduces to `False`, which is what the scan counts) and the child `e_ne_zero`; the
  namespaces hold six in all, with the foundation's `not_unitPairsNull_ball_two`. Sites unchanged: no wave-1 statement quantifies over a tracked
  carrier (as the plan said). **`--self-test`: OK, seven planted defects each fired** (`build/gate/vacuity-self-test/20261004T060101Z-1498759.log`).
- **Architecture** (`tools/check_architecture.py`): exit 0, 189 rows, 0 import mismatches (after the one real red below).

**Negative controls, each watched going red and restored.**
1. *Build/lint*: the skeleton's `sorry`s were watched as `declaration uses sorry` warnings in the first `build.sh` run (7 modules with warnings),
   and the build above reads 0 — the positive signal for the thing that did not happen.
2. *Axioms*: `ringPt_sub_ringPt`'s proof replaced by `sorry`, that one module recompiled, `axioms.sh`: **exit 1, "FAIL: sorryAx on the audited
   surface"**, naming exactly `ringPt_sub_ringPt`, `dist_ringPt_ringPt`, `dist_ringPt_ringPt_cmp_one` (`build/i1-axioms-plant.log`); restored
   from `build/i1-backup/Chord.lean`, the artifact rebuilt from scratch afterwards (the clean rebuild above).
3. *Architecture*: the checker went red on the real defect that arose, `DensityPoints` importing `Chord` with the Imports cell not saying so
   ("stated-only [], real-only ['Plane/Chord']", exit 1), and green after the cell was corrected.
4. *Vacuity — on this wave*: the self-test's seven controls fire (above). **A control specific to the wave did not fire**: a planted
   `theorem planted_vac_i1 (c : AeColouring 1) (x : ℂ) : x = x := rfl` was scanned (declarations 7624 → 7625) and produced **no site and no
   VACUOUS row**, although `IsEmpty (AeColouring 1)` is in the evidence. The scan classifies only its tracked carriers (colourings of a graph,
   `Forces`, tracked props); `AeColouring k` is not one. No wave-1 statement is affected (every `AeColouring` binder in wave 1 is at a variable
   `k`, a generic site, and no hypothesis is at a numeral), but wave 2's statements about `AeColouring` and partial colourings will have no
   vacuity check until the tool learns the carrier. Reported, not repaired: `scripts/Vacuity.lean` is outside this brief's `touches`. Planted
   fault removed, `Closure.lean` restored from `build/i1-backup/Closure.lean` and its artifact rebuilt.

## Stage 4 — SAVED: the landing and the drafts

`main` was merged into `fs131-w1` (twice; the only changes on `main` were records and briefs, no Lean, no `ARCHITECTURE.md`, `Proofs.lean` or
`scripts/Axioms.lean` hunk, so no conflict to resolve); the Lean sources are byte-identical across the merges, which is why the gate was not re-run on
the second; the build (no-op), architecture check and the sorry grep were. Fast-forward and push: see the report.

## Drafts for the front page

1. `CLAUDE.md` § The gate (line 502, after the baseline paragraph): replace
   "`declarations=7557 refutations-skipped=314 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`"
   with "`declarations=7624 refutations-skipped=319 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`".
   Same two numbers in the header of `scripts/vacuity-baseline.txt` (line 25): `declarations=7557  refutations-skipped=314` →
   `declarations=7624  refutations-skipped=319`.
2. `CLAUDE.md` § Trust ledger (line 448): "reads 1257 clean and 5 declared purchases (and 11 axiom-free; 1,273 records at FS131-K1's foundation gate,
   2026-10-04)" → "reads 1285 clean and 5 declared purchases (and 11 axiom-free; 1,301 records at FS131-I1's wave-1 gate, 2026-10-04)".
3. Ledger rows wave 1's declarations bear on (to be regraded at the milestone's filings, nothing drafted for `LEDGER.md` now): the rows that
   filed FS111-V0-ID1, FS129-SR2-HULLSET, FS111-M-HULL2, FS111-M2-INT, FS129-SR2-CLOSURE, FS106-DIAM, FS106-TS-C, FS111-M2-ZERO, FS116-V4-CHORD,
   FS129-SR1-TWOCIRC, FS121-D1-XCORNER, FS129-SA1-NOAFF-K, FS129-SA1-FALC-FAN, FS129-SA1-FALC-DICHO-K (rows 131–154 of the regularity-wall era,
   by `plans/FS131-kernel-plan.md` § 6.2's row names; each now has its declaration above). Rows resting on them stay at their grades until filed.
4. `CLAUDE.md` § Frontier / Proof Atlas: the 14 rows above move [hand] → [kernel] at the milestone's filing; no value of χ moves.
