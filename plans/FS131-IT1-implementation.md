# FS131-IT1 — the ten leaves of `Arith/TorsionExtraction`: the implementer's record

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wr2` (worktree `.claude/worktrees/fs131-wr2`), from
`34d9113b2`. Brief: `data/fs131/briefs/FS131-IT1-leaves.md`. Plans read: `plans/FS131-KN4-three-four-colours-plan.md` (its dated
section, then § 4.2) and `plans/FS131-KN5-three-four-colours-passes.md` (§ Stage 3, 5, 7). Working files: `data/fs131/it1/`.*

## Theorems this phase proved

*Filled stage by stage; the axioms of each are printed at the last stage, from the built module.*

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/it1/readback.py`: the brief's five quoted blocks (Kooshi's W2, the claim list's theorem, its three
dated lines) against their sources in the coordinator's checkout — **5 IDENTICAL** (exit 0; `data/fs131/it1/logs/readback.out`).
Control `--control` changes one digit in the body of each quotation, past its label: 5 of 5 then DIFFER
(`logs/readback.control.out`). The first control I wrote changed the first digit of the whole line, which for two quotations
is in the label (`W2`, `NF4`), and so only changed which comparison ran: it fired for the wrong reason, and was moved before it
was believed. This tree's copy of `data/fs131/claims-NF4.md` predates the three dated lines (the planner's record says so);
nothing here reads it.

**The statement instruments, built before any proof.**
- `data/fs131/it1/statements-before.raw.txt`: every constant of the compiled module as the build gave it (the `.olean` of
  13:52, after the file's last commit `558952c3e` of 13:44), by `data/fs131/it1/lean/StatementDump.lean` — 23 constants: one
  definition (`inv5`), 17 named theorems, 5 internal.
- `data/fs131/it1/statements.sh`: the skeleton at `34d9113b2` and the working file, each elaborated at one path with
  `lean/StatementFooter.lean`, compared by `statement_diff.py`. On the untouched file: 18 named constants compared, PASS; the
  control (one statement's last character, `inv5`'s value, one declaration removed) reports 3 of 3
  (`logs/statements-stage1.out`).
- The tool defect FS131-IU1's record names, seen here too: the compiled dump against the footer's dump of the same text
  differs in one statement, `exists_zmod_hom_of_mem_torsionBy`, by the instance binder's stored name alone
  (`inst._@.Proofs.HadwigerNelson.Arith.TorsionExtraction.…` against `inst._@.data.fs131.it1.stmt.Copy.…`;
  `logs/statements-compiled-vs-footer.out`). So the two prints of a comparison are always made at one path: footer against
  footer between builds, compiled against compiled at the end.

**The ten leaves, each as the kernel holds it** (`data/fs131/it1/probes/Checks.lean`, `#check`), in one line, with the plan's
route. I re-derived each by hand before starting; every one is true as typed and agrees with its plan.

| leaf | the statement, in one line | route (plan) |
|---|---|---|
| `layer_step` (L2.1) | reals `a b a' b'` of absolute value at most `1/6` with `2a' − b' − 2a − b ∈ ℤ` and `a' + 2b' + a − 2b ∈ ℤ`: either `a' = (3a + 4b)/5 ∧ b' = (−4a + 3b)/5`, or all four have absolute value exactly `1/6` | each integer has absolute value at most 1; both zero is the rotation (`linarith` twice); one of them `±1` forces all four to `±1/6` (KN4 § 4.2) |
| `layer_dichotomy` (L2.2) | `a b : ℤ → ℝ` in the box with the two relations at every step `m → m + 1`: every step is the rotation, or every `m` is at a corner | a non-rotation step puts `m₀`, `m₀ + 1` at corners; a rotation into or out of a corner has a coordinate `7/30`; induction both ways from `m₀` (KN4 § 4.2) |
| `tendsto_layer` (L2.3) | `θ ∈ Θ₃(R_F)`, `b ∈ U_F`: `θ(inv5^(2n) · b)` tends to some `t ∈ {↑(1/2), ↑(1/3), ↑(2/3)}` | `w = (3 + 4i)/5` a unit of `ℤ[U_F]`, `g_m = wᵐ b`; lifts `a_m`, `b_m` of `θ(g_m) − 1/2`, `θ(i g_m) − 1/2`; `(2 − i)w = 2 + i` gives L2.2's hypotheses; rotation layer `θ(5⁻ᵏ g_m) = ↑(1/2 + a_m/5ᵏ)`, corner layer `3 • θ(5⁻ᵏ g_m) = 0`, each by induction on `k` with `m` quantified inside (KN5 § Stage 3) |
| `exists_torsion_mem_fieldBandSet` (L2.4) | `Θ₃(R_F) ≠ ∅` gives `τ ∈ Θ₃(R_F)` with `6 • τ = 0`, every subfield `F ⊆ ℝ` | the `x` along which `θ(inv5^(2n) x)` converges are a subgroup holding the unit vectors, so everything; `τ` is the limit, additive; on unit vectors it is `1/2`, `1/3` or `2/3` (KN4 § 4.2) |
| `exists_zmod_hom_of_mem_torsionBy` (D-4) | a character `θ` of any abelian group `M` with `N • θ = 0`, `N ≠ 0`, is `ZMod.toAddCircle ∘ l` for an additive `l : M → ZMod N` | values are `↑(k/N)`; `ZMod.toAddCircle` is injective, so the choice is additive (KN5 § Stage 2, D-4) |
| `colorable_two_iff_fieldBandSet_two_nonempty` (L2.5) | the plane over `F` is two-colourable iff some character of `ℤ[U_F]` is in `band 2 = {↑(1/2)}` at every unit vector | `⟸`: `colorable_of_residue` at `G = ZMod 2` through D-4; `⟹`: `f x = C x − C 0`, the invariant `∀ x, f (x + y) = f x + f y` holds at unit vectors and is closed under `+`, `−` (KN5 § Stage 3) |
| `mem_fieldBandSet_two_of_inv_three_mem` (L2.6) | `1/3 ∈ ℤ[U_F]`, `τ ∈ Θ₃ ∩ T₆`: `τ ∈ Θ₂` | `u = 3 • (3⁻¹ u)`, so `2 • τ u = 6 • τ(3⁻¹ u) = 0`; `τ u = ↑t`, `t ∈ [1/3, 2/3]`, `2t ∈ ℤ`, so `t = 1/2` (KN4 § 4.2) |
| `inv_natCast_mem_unitRing_of_sqrt_mem` (L2.7) | `d + 1 = 4n`, `√d ∈ F`: `(n : ℂ)⁻¹ ∈ ℤ[U_F]` | `v = ((2n − 1) + i√d)/(2n)` and its conjugate are unit vectors of `F²`; `1/n = 2 − v − v̄`; the identity stated on its own for L2.9 (KN4 § 4.2) |
| `inv_three_mem_unitRing_of_sqrt_mem` (L2.8) | `d % 12 = 11`, `√d ∈ F`: `3⁻¹ ∈ ℤ[U_F]` | `d + 1 = 4·(3k)`, `3⁻¹ = k · (3k)⁻¹` (KN4 § 4.2) |
| `not_colorable_two_of_sqrt_mem` (L2.9) | `d % 4 = 3`, `√d ∈ F`: the plane over `F` is not two-colourable | L2.5 `⟹` gives `θ = ↑(1/2)` on unit vectors; `θ` at `1 = n·(2 − v − v̄)` reads `↑(1/2) = 0` (KN4 § 4.2) |

No leaf's statement and plan disagree; no message was owed. Two things I checked that the plans leave implicit: `n ≥ 1` in L2.7
follows from `d + 1 = 4n` in `ℕ`; and in L2.3 the corner layer's sequence `θ(25⁻ⁿ b)` is constant because
`25⁻ⁿ b − 25⁻⁽ⁿ⁺¹⁾ b = 24 · 25⁻⁽ⁿ⁺¹⁾ b` and `3 ∣ 24`.

**The machine.** One file through `lake env lean` here: 2.3 s, 3.6 GB at its peak (`logs/StatementDump.time`).

## Stage 2 — SAVED: eight leaves proved (L2.1, L2.2, D-4, L2.5–L2.9); two left (L2.3, L2.4)

Each leaf was written in a probe under `data/fs131/it1/probes/` (`P1.lean`: §1; `P2.lean`: D-4; `P3.lean`: §3 and §5), elaborated
there, then moved into the module. The module elaborates under `lake env lean` with the lakefile's three options, with two
`sorry` warnings (`tendsto_layer`, `exists_torsion_mem_fieldBandSet`) and no other message (9.9 s, 3.7 GB). The statement
check on the working file: 18 named constants compared, PASS; control 3 of 3 (`logs/statements-stage2.out`).

| leaf | how it went, against its plan |
|---|---|
| `layer_step` | as planned, with no `interval_cases`: the two forms are `2x + y + 2z + w` at signed arguments, and one private lemma (`abs_eq_of_one_le_abs_form`: a form of absolute value at least 1 on the box is at a corner) serves both; a non-zero integer has absolute value at least 1 (`Int.one_le_abs`) |
| `layer_dichotomy` | as planned; one private lemma (`no_rotation_at_corner`: a rotation step between two points of the box has neither end at a corner) serves the forward and the backward step; the induction is `Int.inductionOn'` from `m₀` (the plan's `Int.induction_on` does not take a base point at the pin) |
| `exists_zmod_hom_of_mem_torsionBy` | as planned: a value killed by `N` is `↑(k/N) = ZMod.toAddCircle k`; additivity of the chosen `l` by `ZMod.toAddCircle_injective` |
| `colorable_two_iff_fieldBandSet_two_nonempty` | as the second planner's route: `⟸` is `colorable_of_residue` at `G = ZMod 2` through D-4; `⟹` the invariant `∀ x, f (x + y) = f x + f y`, which needs `0`, sums and unit vectors only (no negation), through the private induction `unitRing_induction` on `ℤ[U_F]` (it is `UnitRing.exists_sum_eq_of_mem_unitRingOver` in the form a proof applies). About 70 lines against the plan's 120–180 |
| `mem_fieldBandSet_two_of_inv_three_mem` | as planned |
| `inv_natCast_mem_unitRing_of_sqrt_mem` | as planned; the identity is the private `exists_unitVectors_inv_natCast` (two unit vectors `v`, `v'` of `F²` with `1/n = 2 − v − v'`), which L2.9 reads |
| `inv_three_mem_unitRing_of_sqrt_mem` | as planned |
| `not_colorable_two_of_sqrt_mem` | as planned: `1 = n • (1 + 1 − v − v')` in the ring, and the character is `1/2` at each of the four unit vectors |

**Price.** The eight leaves took about 150 lines with six private helpers, each elaborated on the first or second attempt. The
plan priced L2.3 at 150–200 lines; from these leaves I price it at about 120 with its children, and L2.4 at about 50.

**Private helpers so far** (six; none is nameable outside the file): `abs_eq_of_one_le_abs_form`, `no_rotation_at_corner`,
`unitRing_induction`, `eq_half_of_mem_band_two`, `half_ne_zero`, `exists_unitVectors_inv_natCast`.

## Stage 3 — SAVED: the last two leaves (L2.3, L2.4); the file has no `sorry`

Commit `c007de223`. The module elaborates under `lake env lean` with the lakefile's three options and prints nothing
(11.6 s, 3.7 GB). Statement check on the working file: 18 named constants compared, PASS; control 3 of 3
(`data/fs131/it1/logs/statements-stage3.out`). One line sent to "main" as the brief's channel asks.

| leaf | how it went, against its plan |
|---|---|
| `tendsto_layer` (L2.3) | the second planner's decomposition held, as four private children. `exists_orbit`: `g m = wᵐ b` built in `ℂ` (a `zpow` in the field, so no unit of the ring is constructed), `J = i`, with the three relations the argument reads — `(2 − i)w = 2 + i` at `g m`, its multiple by `i`, and `g m / 5 = g (m + 1) + g (m − 1) − g m` — each one `linear_combination` from an identity of `ℂ`. `exists_lift_of_mem_band_three`: a point of `band 3` is `1/2 + x`, `|x| ≤ 1/6`. `rotation_layer`: `θ(5⁻ᵏ g_m) = ↑(1/2 + a_m/5ᵏ)`, induction on `k` with `m` inside. `corner_layer`: `3 • θ(5⁻ᵏ g_m) = 0`, the same induction. The leaf is then: the two relations read through `θ` are `layer_dichotomy`'s hypotheses (the integers are `n + 1` and `n − 1`: the halves contribute `∓1`); a rotation layer tends to `↑(1/2)`; on a corner layer `θ(25⁻ⁿ b) = 25 • θ(25⁻⁽ⁿ⁺¹⁾ b) = θ(25⁻⁽ⁿ⁺¹⁾ b)` since `25 = 1 + 8·3`, so the sequence is constant at `θ b = ↑(1/2 ± 1/6)`. About 190 lines with the children, against the plan's 150–200 |
| `exists_torsion_mem_fieldBandSet` (L2.4) | as planned, with `unitRing_induction` in place of a subgroup: convergence passes to sums (`Filter.Tendsto.add`), the limit is additive by `tendsto_nhds_unique` (`UnitAddCircle` is Hausdorff by instance), and at a unit vector it is one of `↑(1/2)`, `↑(1/3)`, `↑(2/3)`, each in `band 3` and killed by 6. About 50 lines |

**Private helpers, all ten** (none is nameable outside the file; each carries a docstring): `abs_eq_of_one_le_abs_form`,
`no_rotation_at_corner` (§1); `unitRing_induction`, `exists_orbit`, `exists_lift_of_mem_band_three`, `rotation_layer`,
`corner_layer` (§2); `eq_half_of_mem_band_two`, `half_ne_zero` (§3); `exists_unitVectors_inv_natCast` (§5).

**Axioms before the build, from a copy** (`lean/AxiomsFooter.lean` appended to the working file;
`data/fs131/it1/axioms-footer.txt`, 28 records: 18 public, 10 private): every one of the ten leaves, every private helper,
`inv5`, `coe_inv5` and `three_le_chromaticNumber_planeOver_of_sqrt_mem` on `[propext, Classical.choice, Quot.sound]`; five
compositions with `sorryAx` besides — `colorable_two_of_inv_three_mem`, `four_le_chromaticNumber_planeOver_of_inv_three_mem`,
`chromaticNumber_planeOver_ne_three_of_inv_three_mem`, `four_le_chromaticNumber_planeOver_of_sqrt_mem`,
`four_le_chromaticNumber_planeOver_fieldOfRadicands` — which is the upstream leaf's,
`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` (another job's module, `sorry` in this tree; stage 4 shows it
from the built module). Control: with one helper's proof replaced by `sorry` in a copy, that helper and exactly the four
records that read it (`layer_step`, `layer_dichotomy`, `tendsto_layer`, `exists_torsion_mem_fieldBandSet`) gain `sorryAx`:
10 records against 5 (`axioms-footer.control.txt`).
