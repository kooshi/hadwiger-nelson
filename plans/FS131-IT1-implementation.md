# FS131-IT1 — the ten leaves of `Arith/TorsionExtraction`: the implementer's record

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wr2` (worktree `.claude/worktrees/fs131-wr2`), from
`34d9113b2`. Brief: `data/fs131/briefs/FS131-IT1-leaves.md`. Plans read: `plans/FS131-KN4-three-four-colours-plan.md` (its dated
section, then § 4.2) and `plans/FS131-KN5-three-four-colours-passes.md` (§ Stage 3, 5, 7). Working files: `data/fs131/it1/`.*

## Theorems this phase proved

*All in `Proofs/HadwigerNelson/Arith/TorsionExtraction.lean`, namespace `HadwigerNelson.TorsionExtraction`; axioms printed
from the built module (`data/fs131/it1/axioms.txt`, stage 4). "Standard three" is `[propext, Classical.choice, Quot.sound]`.
The statements are the planners' (FS131-KN4, FS131-KN5); the proofs of the ten leaves are this job's. Each line gives the
informal statement the declaration was read against.*

**The ten leaves — [kernel], standard three, each:**
- `layer_step` — FS81-T3's step, without the cell list: four reals of absolute value at most 1/6 whose two forms
  `2a' − b' − 2a − b` and `a' + 2b' + a − 2b` are integers are a rotation step by `(3 − 4i)/5`, or all at absolute value 1/6.
- `layer_dichotomy` — FS81-T3 in sequence form: a two-sided sequence in the box satisfying the two relations at every step is
  a rotation orbit or sits at corners throughout.
- `tendsto_layer` — for `θ ∈ Θ₃(R_F)` and a unit vector `b`, `θ(25⁻ⁿ b)` converges, to `1/2`, `1/3` or `2/3`.
- `exists_torsion_mem_fieldBandSet` — **NF4-S7** (FS91-J02-L1, torsion extraction): `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`, every
  subfield `F ⊆ ℝ`.
- `exists_zmod_hom_of_mem_torsionBy` — a character of an abelian group killed by `N ≠ 0` is a `ZMod N`-valued additive map
  followed by `ZMod N ↪ ℝ/ℤ`.
- `colorable_two_iff_fieldBandSet_two_nonempty` — the plane over `F` is two-colourable iff some character of `ℤ[U_F]` is `1/2`
  at every unit vector.
- `mem_fieldBandSet_two_of_inv_three_mem` — if `1/3 ∈ ℤ[U_F]`, a point of `Θ₃ ∩ T₆` is in `Θ₂` (the last step of FS81-T4).
- `inv_natCast_mem_unitRing_of_sqrt_mem` — `1/n ∈ ℤ[U_F]` for `d + 1 = 4n` and `F ∋ √d` (`1/n = 2 − v − v̄`,
  `v = ((2n − 1) + i√d)/(2n)`).
- `inv_three_mem_unitRing_of_sqrt_mem` — `1/3 ∈ ℤ[U_F]` for `F ∋ √d`, `d ≡ 11 (mod 12)`.
- `not_colorable_two_of_sqrt_mem` — the plane over `F ∋ √d`, `d ≡ 3 (mod 4)`, is not two-colourable.

**A composition of the planner's that this job's leaves complete — [kernel], standard three:**
- `three_le_chromaticNumber_planeOver_of_sqrt_mem` — `χ(F²) ≥ 3` for every subfield `F ∋ √d`, `d ≡ 3 (mod 4)` (read against
  the claim list's dated line G-1, "likewise chi >= 3 for d = 3 (mod 4)"; the value is prior art, `[Fischer1990]`,
  `[Johnson2000]`).

**Five compositions of the planner's, complete over this job's leaves and one upstream leaf — not yet kernel theorems of
this tree:** `colorable_two_of_inv_three_mem` (NF4-THEOREM (c), strongest form, G-2),
`four_le_chromaticNumber_planeOver_of_inv_three_mem` (NF4-THEOREM (c)), `chromaticNumber_planeOver_ne_three_of_inv_three_mem`,
`four_le_chromaticNumber_planeOver_of_sqrt_mem` (NF4-THEOREM (a), lower bound, in G-1's form),
`four_le_chromaticNumber_planeOver_fieldOfRadicands` (NF4-THEOREM (a) as claimed). Each prints the standard three and
`sorryAx`; the `sorryAx` is `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`'s (NF4-S6, another job's
module, `sorry` in this tree) and nothing else's: with that leaf as a hypothesis the compositions print the standard three
(`data/fs131/it1/models.txt`, `colorable_two_of_upstream`, `four_le_eleven_of_upstream`). They become kernel theorems on the
standard three the day that module has no `sorry`, with no change here.

**Ten private helpers — [kernel], standard three, each** (`data/fs131/it1/axioms-footer.txt`): `abs_eq_of_one_le_abs_form`,
`no_rotation_at_corner`, `unitRing_induction`, `exists_orbit`, `exists_lift_of_mem_band_three`, `rotation_layer`,
`corner_layer`, `eq_half_of_mem_band_two`, `half_ne_zero`, `exists_unitVectors_inv_natCast`.

**Outside the library** (`data/fs131/it1/lean/Models.lean`, a probe file, standard three; stage 4): FS81-T4 in the ledger's
own words — `1/3 ∈ ℤ[U_F]` and `Θ₃(R_F) ≠ ∅` give a two-colouring — and clause (a) in character form — `Θ₃(R_F) = ∅` for
every `F ∋ √d`, `d ≡ 11 (mod 12)` — are two-line compositions of this module's leaves that read no upstream leaf.

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

## Stage 4 — SAVED: the build; the statements and the axioms from the kernel's side; the models; the linters

**The one build.** `data/fs131/it1/build_sampled.sh data/fs131/it1/logs/build1 8` — the slot at `--mem 10 --cpus 4`,
`MEMMAX=10G BATCH=8 ./scripts/build.sh` — from 19:22:26 to 19:28:59 UTC: **exit 0, "build: OK — 248 of 248 batches,
3 module(s) rebuilt, 3 module(s) with warnings, 6m28s"**; peak 4.4 GiB over the process tree (4,645,912 kB, 195 samples;
`logs/build1.out`, `.peak`; Lake's whole output `logs/build1.full.log`). Rebuilt: `Arith.TorsionExtraction` (8.8 s),
`Arith.ThreeColourCriterion` (2.2 s, its one dependent), `Proofs` (1.8 s). **Zero warnings from this job's file**: Lake's
line for it is `✔ Built Proofs.HadwigerNelson.Arith.TorsionExtraction (8.8s)`, and the log's 31 warning lines are the
`sorry` leaves of the three other modules of the line (`DyadicQuadratic` 10, `ThreeColourCharacter` 8,
`ThreeColourCriterion` 13), which other jobs hold. The module went from 201 lines to 709; against `34d9113b2` the diff
under `Proofs/` is this one file, 518 lines added and 10 removed, the ten removed being the ten `  sorry` lines.

**No statement changed, from the kernel's side** (`data/fs131/it1/after_build.sh`, which runs everything below from the
built module; `logs/after_build.out`).
- The compiled module's constants before the first rebuild (`statements-before.raw.txt`, sha256 `b3635e47…`) against the
  same dump after the build (`statements-after.raw.txt`, sha256 `4a3d00a2…`; 49 constants, 31 of them internal), both
  printed at the module's own path: **18 named constants compared — 17 theorems' stored types, and the stored type and
  value of the one definition `inv5` — PASS; 0 new named constants; 10 new private theorems; `example` heads 6 and 6**
  (`logs/statements-final.out`).
- Its control in memory (one statement's last character, `inv5`'s value, `layer_step` removed): 3 of 3 reported
  (`logs/statements-final.control.out`).
- Its control on the file (`planted_file.sh`): a copy of the module with `(_h : True)` added to
  `chromaticNumber_planeOver_ne_three_of_inv_three_mem` — a statement nothing in the file calls, so the copy elaborates —
  is reported as exactly that one changed statement, exit 1 (`logs/statements-planted-file.out`).
- What the check does not see: a docstring or a comment (none of the skeleton's was edited: the diff's removed lines are
  the ten `sorry`), and the heads of `example`s beyond their count.

**The axioms, from the built module** (`lean/Axioms.lean`, generated with the audit block by `make_audit.py` from the
compiled module's own list of named constants; print `axioms.txt`; reader `read_axioms.py`): 18 records, the same list
as the audit block in order; **13 on `[propext, Classical.choice, Quot.sound]`** — the ten leaves, `inv5`, `coe_inv5`,
`three_le_chromaticNumber_planeOver_of_sqrt_mem` — **and 5 with `sorryAx` besides**, the five the list
`sorry-expected.txt` names. The reader fails on a listed record that does *not* carry `sorryAx` too, so the list cannot go
stale in silence: when the upstream module is proved this check goes red here and the list is emptied. Control: a planted
record with `sorryAx` that the list does not name, and one on an undeclared axiom — 2 of 2 reported
(`logs/read_axioms.control.out`).

**Where the `sorryAx` comes from** (`lean/Models.lean`, print `models.txt`): `ThreeColourCharacter.
fieldBandSet_three_nonempty_of_colorable` prints `sorryAx` (its module's eight leaves are another job's); the same
compositions with that statement taken as a hypothesis — `colorable_two_of_upstream`, `four_le_eleven_of_upstream` — print
the standard three. So nothing in this file is `sorry`, and the file's only reading of an unproved statement is that one.

**The models** (the same probe file; 17 records; each on the standard three but the two named above): § Drafts for the
landing, item 2.

**The environment linters** on the built library: `lake lint --no-build -- --no-build --trace` under the slot — exit 0,
`-- Linting passed for Proofs.`, each of the fourteen linters `Passed!` (`logs/lint.out`; 13 s, 4.9 GiB). I planted no
fault in the house's linters. `tools/check_architecture.py`: `RESULT: PASS` (`logs/check_architecture.out`; no import was
added, no public declaration added or removed).

**Not run by this job**: `scripts/axioms.sh`, `scripts/vacuity.sh`, `scripts/assumptions.sh`, `scripts/dupnames.sh` — the
gate is the landing's, and with 31 `sorry` in the line's other modules it cannot pass in this tree.

## Drafts for the landing (saved with stage 4)

*For the landing of the three-and-four-colours line (`Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`,
`Arith/ThreeColourCriterion`, `Arith/DyadicQuadratic`). This job ran no gate.*

### 1. The audit block — `scripts/Axioms.lean`, in the landing's CLEAN block for the module

`data/fs131/it1/audit-block.txt`: 18 records, one `#print axioms` line per public declaration of
`Arith/TorsionExtraction` a person typed (17 theorems, 1 definition), in the file's order; generated from the compiled
module's own list of named constants, and the generator fails if the source writes a public declaration the dump does
not hold or the dump holds a named constant the source does not write. **Every record is CLEAN once
`Arith/ThreeColourCharacter` has no `sorry`**: the module reads no declared outside theorem (Weil's bound is read in
`Arith/ThreeColourCriterion` only; the second planner's record, § Stage 7, lists the IMPORTED records, none here). Until
then five records print `sorryAx` (`sorry-expected.txt`). The ten private helpers cannot be named from
`scripts/Axioms.lean`; each is read by a public record, and their own prints are `axioms-footer.txt`.

### 2. A model for each hypothesis

`data/fs131/it1/lean/Models.lean` (never part of the library) applies the statements at the models below; its print is
`data/fs131/it1/models.txt`.

| hypothesis | where it is taken | model | does the kernel hold it? |
|---|---|---|---|
| `h3 : (3 : ℂ)⁻¹ ∈ unitRing F` | `colorable_two_of_inv_three_mem`, `four_le_…_of_inv_three_mem`, `chromaticNumber_…_ne_three_…`, `mem_fieldBandSet_two_of_inv_three_mem` | `F = ℚ(√11)` (`inv_three_mem_unitRing_of_sqrt_mem` at `d = 11`); `F = ℚ(√2)`, `1/3 = 1 − v − v̄`, `v = (1 + 2√2 i)/3` (`Models.inv_three_mem_unitRing_sqrt_two`) | yes, both, standard three |
| `hnb : ¬ Colorable 2`, with `h3` | `four_le_chromaticNumber_planeOver_of_inv_three_mem` | `F = ℚ(√11)`: both at once (`Models.headline_hypotheses_eleven`) | yes, standard three |
| `h : Colorable 3`, with `h3` | `colorable_two_of_inv_three_mem` | `F = ℚ(√2)`: its plane is two-colourable, so three-colourable, and `h3` holds there. At `ℚ(√11)` the pair is refuted — that is the theorem | `h3`: yes. The two-colouring of `ℚ(√2)²`: **not in this tree** — it is `DyadicQuadratic.colorable_two_planeOver_sqrt` (another job's leaf). Until it lands the theorem has no kernel-held model of both hypotheses at once |
| `hd : d % 12 = 11`, `hF : √d ∈ F` | `four_le_…_of_sqrt_mem`, `inv_three_mem_unitRing_of_sqrt_mem` | `d = 11`, `F = ℚ(√11)`; the file's own examples at 11 and 35 | yes |
| `hd : d % 4 = 3`, `hF` | `three_le_…_of_sqrt_mem`, `not_colorable_two_of_sqrt_mem` | `d = 7`, `F = ℚ(√7)` (the file's example); `d = 11` | yes |
| `hd : d + 1 = 4 * n`, `hF` | `inv_natCast_mem_unitRing_of_sqrt_mem` | `d = 11`, `n = 3`; `n = 0` is excluded by `hd` | yes |
| `h : (fieldBandSet F (band 3)).Nonempty` | `exists_torsion_mem_fieldBandSet` | every `F` with a two-colourable plane — `band 2 ⊆ band 3` (`Models.fieldBandSet_three_nonempty_of_colorable_two`, standard three, this module alone): `ℚ`, `ℚ(√2)`; and `ℚ(√3)` (`[Fischer1990]` Thm 9, by the module's docstring), where the limit has order 3 | the implication: yes. A field whose plane the kernel holds two-colourable in this form: **none in this tree** (`DyadicQuadratic.colorable_two_planeOver_sqrt`; on `fs131-wnf`, `UpperHalf.colorable_two_planeOver_of_ramified` with its leaf at `ℚ`). At the headline's own fields the hypothesis is refuted (`Models.fieldBandSet_three_empty_of_sqrt_mem`): there the two leaves are steps inside a proof by contradiction |
| `hθ : θ ∈ fieldBandSet F (band 3)`, `hb : b ∈ unitSet F` | `tendsto_layer` | as the row above, with `b = 1` | as the row above |
| `hτ`, `h6`, with `h3` | `mem_fieldBandSet_two_of_inv_three_mem` | `F = ℚ(√2)`, `τ` the character of a two-colouring (in `Θ₂ ⊆ Θ₃`, killed by 2) | as two rows above |
| `h : θ ∈ torsionBy M N`, `[NeZero N]` | `exists_zmod_hom_of_mem_torsionBy` | `θ = 0`; `ZMod.toAddCircle` at `M = ZMod N` | not exhibited as a declaration; its two readers in this file apply it at a `θ` in hand |
| the box and the two integer forms | `layer_step` | a rotation step `(1/12, 0) ↦ (1/20, −1/15)`, where the second disjunct fails; a corner step `(−1/6, −1/6) ↦ (1/6, −1/6)`, where the first fails (`Models.layer_step_rotation`, `…_not_corner`, `layer_step_corner`, `…_not_rotation`) | yes |
| the same along a sequence | `layer_dichotomy` | the zero orbit; the corner orbit `z_m = iᵐ(−1/6 − i/6)`, at which every hypothesis holds, the second disjunct holds and the first fails (`Models.layer_dichotomy_zero`, `layer_dichotomy_corner`) | yes |

**One instance held twice.** The headline at `d = 11`, `4 ≤ χ(ℚ(√11)²)`, is word for word the statement the kernel
already holds by a 204-point witness (`four_le_chromaticNumber_planeOver_eleven`, row 73, standard three):
`Models.four_le_eleven_by_witness` and `Models.four_le_eleven_by_family` conclude one proposition.

### 3. What a reader of the statements should be told that the docstrings do not say

1. **Whose each value is** (copied from the module's docstring and the claim list's NF4-OBJECTION and NF4-NC; I read
   neither `[Fischer1990]` nor `[Johnson2000]` in this job).
   - `χ ≥ 4` for `d ≡ 11 (mod 12)` and clause (c) in both forms: this project's (row 82; FS81-T4, T5), not found in print;
     `[Johnson2000]` p. 176 poses the family as open and `[Johnson2006]` p. 214 asks whether any such `m` exists.
   - The vector `v = ((2n − 1) + i√d)/(2n)` and `1/3 ∈ ℤ[U]`: `[Fischer1990]` Thm 10(ii) and Ex. 4, there at
     `N ≡ −1 (mod 24)`; the obstruction "`1/k ∈ ℤ[U]` gives no additive `k`-colouring": `[Fischer1990]` §1.
   - `χ ≥ 3` for `d ≡ 3 (mod 4)` (`three_le_…`, `not_colorable_two_…`): prior art, the lower end of Fischer's and
     Johnson's values; what is here is its kernel form, at every subfield holding `√d`.
   - The two-colour criterion `colorable_two_iff_fieldBandSet_two_nonempty` is elementary (a bipartite Cayley graph has a
     parity character) and is not claimed.
   - No upper bound is in this module. Every "=" of the table needs the upper halves, all prior art, in the line's other
     modules.
2. **The headline's first instance was already in the kernel**: `d = 11`, by row 73's finite witness. New in the kernel
   with this line are every other `d` of the class (23, 35, 47, …) and the route with no finite graph.
3. **`d` is any natural number of the class, and `F` any subfield of `ℝ` holding `√d`.** The claim's "squarefree" is not
   used (`d = 275 = 11·5²` is in the class; its field is `ℚ(√11)`). At `F = ⊤` the headline reads `4 ≤ χ(ℝ²)`, true and
   below what the library holds: the content is at the small fields.
4. **The five headline compositions rest on the upstream leaf** until `Arith/ThreeColourCharacter` lands; their own
   module adds nothing unproved. In character form the same results stand on this module alone today (§ 4, first item).
5. **`tendsto_layer` is along `25⁻ⁿ`, not `5⁻ᵏ`**: on a corner layer `θ(5⁻ᵏ b)` alternates between `1/3` and `2/3`
   (`5 ≡ 2 (mod 3)`), which is why the limit is taken along even powers.
6. **The character of `exists_torsion_mem_fieldBandSet` is a limit, and the colouring of
   `colorable_two_iff_fieldBandSet_two_nonempty` `⟸` is `cosetResidue`'s**: the first is determined by `θ`, the second
   depends on a choice of coset representatives. Existence is all either statement gives.

### 4. Generalizations seen (the skeleton's forms kept; nothing added to the public surface)

- **FS81-T4 and clause (a) in character form, with no three-colouring in the statement**: `(3 : ℂ)⁻¹ ∈ unitRing F →
  (fieldBandSet F (band 3)).Nonempty → Colorable 2`, and `d % 12 = 11 → √d ∈ F → ¬ (fieldBandSet F (band 3)).Nonempty`.
  Each is a two-line composition of this module's leaves and prints the standard three today
  (`Models.colorable_two_of_fieldBandSet_three_nonempty`, `Models.fieldBandSet_three_empty_of_sqrt_mem`). The first is the
  ledger's own wording of T4 ("`1/3 ∈ ℤ[U_F]` and `Θ₃(F) ≠ ∅` make `F²` bipartite"); `colorable_two_of_inv_three_mem` is
  it after the upstream leaf. If the line wants a headline that does not wait for `ThreeColourCharacter`, these are it;
  whether they are stated is the planner's.
- **`unitRing_induction`** (private): a property of `0` that passes to sums and holds at every unit vector holds on
  `ℤ[U_F]`. `CharacterColouring.gluing_field` inlines the same argument, and `ThreeColourCriterion`'s two-colour end
  (the second planner's D-2: "`ℤ[U_F]` is the additive span of the unit vectors") needs it again. Stated once in
  `CharacterColouring` it would serve all three; here it stays private, so no name is doubled.
- **`rotation_layer`, `corner_layer`** read only the recurrence `g m / 5 = g (m + 1) + g (m − 1) − g m` and additivity: no
  field, no unit vector.
- **`not_colorable_two_of_sqrt_mem`** is the case "`1` is a signed sum of an even number of unit vectors" (`4n` of them)
  of: a character equal to `1/2` on unit vectors is `0` on every signed sum of an even number of them.

## Drafts for the front page, and for the other files this job does not write

*Each names its slot. Keryx files; the landing decides when. This job ran no gate, so it drafts no counts for
`CLAUDE.md` § The gate or § Trust ledger: those are the landing's, from its own run.*

- **`ARCHITECTURE.md` § the module map, the row `Arith/TorsionExtraction`** — replace the words "(FS131-KN4, passes
  FS131-KN5; a skeleton: ten leaves are `sorry`)" by "(statements FS131-KN4's and FS131-KN5's; the ten leaves' proofs
  FS131-IT1's)". Nothing else in the row changes.
- **`LEDGER.md` row 82**, at the landing, after its grade "[hand, two independent derivations]" — add: "**[kernel]
  since the landing of FS-131's three-and-four-colours line**: `TorsionExtraction.colorable_two_of_inv_three_mem` (T4
  with T2), `four_le_chromaticNumber_planeOver_of_inv_three_mem` (T5), `four_le_chromaticNumber_planeOver_of_sqrt_mem`
  and `four_le_chromaticNumber_planeOver_fieldOfRadicands` (the family, every subfield of `ℝ` holding `√d`,
  `d ≡ 11 (mod 12)`, squarefree or not), on the standard three axioms, resting on no assumption and no import; T3 is
  `layer_step` and `layer_dichotomy`, proved with no cell list." **This sentence is true only when
  `Arith/ThreeColourCharacter` (T2) has no `sorry`.** Before that the kernel holds, on the standard three, T3
  (`layer_step`, `layer_dichotomy`), the limit and the torsion extraction (`tendsto_layer`,
  `exists_torsion_mem_fieldBandSet`), the two-colour criterion, the relation (`inv_three_mem_unitRing_of_sqrt_mem`) and
  `χ ≥ 3` at `d ≡ 3 (mod 4)` — and T2 is still [hand].
- **`CLAUDE.md` § Frontier, "What the kernel holds, beyond the interval"**, at the landing — a clause after row 119's:
  "**FS-131's three-and-four-colours line** — `χ(F²) ≥ 4` for every subfield `F ⊆ ℝ` holding `√d`, `d ≡ 11 (mod 12)`, with
  no finite graph, and `χ(F²) ≠ 3` wherever `1/3 ∈ ℤ[U_F]` (row 82)".
- **The Proof Atlas**, at the landing: row 82's nodes T3, T4, T5 and the family clause from [hand] to [kernel]; T2 with
  `Arith/ThreeColourCharacter`. Before the landing: no grade changes on the page.
- **`LEAN.md` § Searching — Lean**, five lines:
  - Induction on `ℤ` from a base point is `Int.inductionOn'` (cases `zero`, `succ`, `pred`; `pred` gives `k - 1`, and
    `sub_add_cancel` returns to `k`); there is no `Int.induction_on'` at the pin (FS131-IT1).
  - `linear_combination` over `ℂ` does not know `Complex.I ^ 2 = -1`: add `c * Complex.I_sq` with the coefficient the
    failed `ring` goal shows (FS131-IT1, `exists_orbit`).
  - After `nsmul_eq_mul` in a subring, `simp` with `Nat.cast_ofNat` turns `((25 : ℕ) : ↥S)` into the numeral `(25 : ↥S)`,
    whose coercion nothing then moves; keep the cast: `simp only [Subring.coe_mul, Subring.coe_natCast]`, then
    `push_cast` (FS131-IT1; the line above on numerals out of a subfield).
  - An orbit `wᵐ b` in a subring of a field is cheapest as a `zpow` in the field, with membership per `m`
    (`zpow_add_one₀`, `zpow_sub_one₀`, `norm_zpow`), not as a unit of the subring (FS131-IT1).
  - A control that changes "the first digit of the line" can land in the line's label and change which comparison runs,
    not the text compared: plant past the label (`data/fs131/it1/readback.py`) (FS131-IT1).
- **`BIBLIOGRAPHY.md`**: no row proposed; no work was read or fetched in this job.
