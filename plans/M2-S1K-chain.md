# M2 / S1K — J14: the chain theorem in the kernel (FS-45 D1–D3)

*Crunch job J14, 2026-09-25, de Bruijn (Opus 5.5). Brief: `data/crunch-2026-09-25/briefs/J14-M2-chain-kernel.md` (with
`STANDING-RULES.md`). Plan: `plans/M2-kernel-lane.md` §2.1, §3.2, §4.2–4.4. Skeleton inherited: `data/m2/j04/K1Chain.lean`.
Working files: `data/m2/j14/`.*

## Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| `not_colorable_chain`: a forcer at `k` colours chained along unit vectors `u` with `(q b − q a)·Σu = 1` — the unit-distance graph induced on the chain's points is not `k`-colourable | kernel (scratch, stage 1; library at stage 2) | `data/m2/j14/Chain.lean` |
| `add_one_le_chromaticNumber_induce_of_chain` (any `S : Subring ℂ` holding drawing and multipliers), `add_one_le_chromaticNumber_unitDistance_of_chain` (the plane), `add_one_le_chromaticNumber_planeOver_of_chain` (`F²`) | kernel (scratch, stage 1) | same |
| `planeOverSubring F : Subring ℂ` — `F²` is closed under complex `+` and `·` | kernel (scratch, stage 1) | same |
| the four forms and `planeOverSubring`, moved into the library | kernel (elaborated; the gated build at stage 5) | `Proofs/HadwigerNelson/Chain.lean` |
| `spindle_of_chain`: `χ(ℝ²) ≥ 4` — the Moser spindle as the chain's `m = 2` case (rhombus along the real axis, twist `(√3 + i√33)/6` and its conjugate, `√3·(2√3/6) = 1`) | kernel (elaborated) | same |
| `rhombus_unit_of` (five edge lengths make a rhombus drawing unit), `norm_eq_one_of_sq` | kernel (elaborated) | same |
| `sixUnits_sum`: `δ(1 + ω̄ + v + vω̄ + v̄ + v̄ω̄) = 1`, by factoring (`sum_sixUnits`, `delta_mul_one_add_omegaBar`, `one_add_v_add_conj`) | kernel (elaborated) | `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean` |
| **`four_le_chromaticNumber_planeOver_two_three`**: `χ(ℚ(√2,√3)²) ≥ 4` by the chain theorem (six chained rhombi, no Moser spindle in the field) | kernel (elaborated) | same |
| `eighteen_not_colorable_three`: the 18-vertex, 33-edge list refuses three colours — gadget algebra, one `decide +kernel`, no solver | kernel (elaborated) | same |
| `eighteen_colorable_four`: four colours suffice (the reference's colouring) | kernel (elaborated) | same |
| `pullGadget`: a gadget carried between vertex sets of different sizes along an edge-preserving map | kernel (elaborated) | same |
| `sum_eightUnits`: `w³ + w̄³ − 3w² − 3w̄² = 3/8` for `w = (−3 + i√7)/4`, from `w̄ = −3/2 − w` and `w² = −(3/2)w − 1` (the difference is `−(21/2)(w² + (3/2)w + 1)`) | kernel (elaborated) | `Proofs/HadwigerNelson/Instances/SevenConditional.lean` |
| **`five_le_chromaticNumber_planeOver_seven_of_G4`**: `G4 → χ(ℚ(√3,√7,√11)²) ≥ 5` — the implication; `G4` itself is a measurement | kernel (elaborated), conditional | same |

## Stage 1 — SAVED

### 1.0 The quotation check (standing rule 5)

| quoted in the brief | source | verdict |
|---|---|---|
| G55: "a finite graph over F forcing two points at difference δ equal at k colours makes every k-colouring of F² periodic under the ideal δR …; if 1/δ = u₁ + ⋯ + u_m is a sum of unit vectors, 1 is a period and χ(F²) > k, witnessed by m chained copies plus one closing edge, at most m(n − 1) + 1 vertices, in F itself" | `CLAUDE.md` lines 896–899 | **verbatim**; the "…" elides "(transport by every isometry z ↦ t + u(z − a))", and the source's bold on "in F itself" is dropped. No widening. |
| "`δ(1+ω̄+u+uω̄+ū+ūω̄) = 1`", `u = (−1+2i√2)/3`, "`δ(1+ω̄) = 3`", "`1+u+ū = 1/3`" | `plans/ASTRA-2026-09-14-derivation.md` T6 (line 34) | **verbatim in T6.** None of the four is in `example_qsqrt2_qsqrt3.json`, which holds coordinates, the 33 edges, the six diamonds `[0,1,2,3] … [15,16,17,1]`, the closing edge `[0,1]` and a four-colouring. The brief's attribution "T6 and the JSON" is right for T6; the JSON is the object, not the identities. Naming: T6's `u` is the skeleton's `v` (the Lean `u` is the chain's multiplier family). |
| T9: "`w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²`", `w = (−3+i√7)/4`, "`w³+w̄³−3w²−3w̄² = 3/8`" | ASTRA T9 (line 40) | **verbatim.** |
| named declarations: `Forces`, `Forces.comap` (`Forcer.lean`), `rhombus`, `rhombusGadget`, `Gadget.transport`, `Gadget.inter`, `Gadget.edge`, `not_colorable_of_gadget` (`Gadget.lean`), the `planeOver` statement (`Instances/SqrtEleven.lean:227`) | at source | all exist. **One finding:** `Gadget.transport` moves a gadget along `φ : Fin n → Fin n` — the *same* vertex type — so it cannot carry `rhombusGadget : Gadget 3 4 2 rhombus ![0, 3]` into the 18-vertex graph. Stage 3 needs a cross-size pull (a new `def` in the instance module, not in `Gadget.lean`, whose dependents it would rebuild). |
| §M domain 3: `G4` over `planeOver (fieldOfRadicands {3, 11})` | `plans/M2-kernel-lane.md` §4.4 | adopted (the skeleton still said `FieldWall4.seamField`). |

A second structural finding, read off the JSON: in the 18-vertex graph the closing edge `0—1` is also diamond 1's own edge, and vertex 3
(`= δ`) is adjacent to vertex 1, so diamonds 2–6 plus the edge `3—1` already refuse three colours — diamond 1 is redundant (consistent with
T6's "25 of 33 edges individually critical"). It changes nothing in the theorem; it decides which edge the stage-3 plant may drop (a
critical one, in diamonds 2–6).

### 1.1 C0 — probabilities per product (registered before stage 2)

| product | my p | against §P |
|---|---|---|
| `Chain.lean`: finite, subring, plane and `F²` forms + the spindle example | 0.97 (the four forms elaborated at stage 1) | — |
| `Instances/SqrtTwoThree.lean` whole (six units, membership, the bound, the oracle, the four-colouring, the plant) | 0.75 | — |
| the six-unit identity closes by factoring in ≤ 40 lines | 0.80 | P-J14c 0.75 |
| the gadget oracle's `decide +kernel` under 60 s | 0.90 (it ranges over the 365 partitions of 7 ports into ≤ 3 blocks) | P-J14b 0.60 |
| `Instances/SevenConditional.lean` (the `w` identity over `√7`, `G4`, the conditional bound) | 0.80 | — |
| all three products, gate green, inside 3 h | 0.70 | P-J14a 0.65 |

### 1.2 The price, from the skeleton's next two leaves (never from the table)

| leaf | plan's price (§3.2) | measured |
|---|---|---|
| `not_colorable_chain` | ~30 lines | 30 lines; **second elaboration** (the first lacked `classical` for the `dite` that reads the colouring on all of `ℂ`) |
| `planeOverSubring` | ~20 lines | 7 lines; first elaboration (two `simpa` → `simp` lint fixes) |
| the three wrappers (subring, plane, `F²`) | ~25 lines | 35 lines with `chainPoints_subset`; closed in the same elaboration |

Elaboration of the whole module: 1.95 s wall, 3.4 GB peak (desktop, `scripts/slot.py --mem 8 --cpus 4 -- lake env lean`), no warning.
**Re-price:** Chain.lean is done but for the `m = 2` spec example and its move into `Proofs/`; stage 2 is ~20k, not ~80k. The rest of
§3.2's price stands, and the risk moves to the six-unit identity and the cross-size gadget pull.

### 1.3 Would have searched here

| # | the move a search would have made | what was done instead |
|---|---|---|
| X1 | — none at stage 1 | — |

## Stage 2 — SAVED

`Proofs/HadwigerNelson/Chain.lean` (249 lines): the chain drawing (`junction`, `chainDrawing`, `chainPoints`, `copyHom`), the four forms
of the theorem (`not_colorable_chain`; `add_one_le_chromaticNumber_induce_of_chain` for any `S : Subring ℂ`;
`add_one_le_chromaticNumber_unitDistance_of_chain`; `add_one_le_chromaticNumber_planeOver_of_chain` through `planeOverSubring`), two
helpers the instances share (`norm_eq_one_of_sq`, `rhombus_unit_of`), and the spec: a `#`-free example per definition (`junction` on
`δ = 2`, multipliers `1, 3` at `n = 1, 2`; `chainDrawing` on a segment turned by `i`; `planeOverSubring ⊥` holding `(1 + i)²`) and
**`spindle_of_chain`**, the Moser spindle as the `m = 2` case — the model of every hypothesis of the plane form. Elaborates with no error
and no warning (four iterations: two `simp` argument lints, one `rw` motive error on a `Fin` numeral replaced by `simp` through
`Finset.sum_filter`, one `linear_combination` coefficient that differs by edge — the edge `1—2` has no `√3`).

**Modeling note (the one decision here).** The theorem is proved at the subring level and `planeOver` enters only through
`planeOverSubring` (§M domain 2). *Alternative:* prove it for `planeOver F` directly, as the skeleton did. *Why this won:* the proof uses
closure under `+` and `·` and nothing about fields; the subring form serves FS-47's `ℤ[U]` statements unchanged. *Confidence:* high.

Not yet done (stage 5): `Proofs.lean`, `ARCHITECTURE.md`'s module map, `scripts/Axioms.lean` — moved to the gate stage so the three
modules are registered in one edit.

## Stage 3 — SAVED

`Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean` (≈200 lines). Elaborates with no error and no warning: **4.13 s wall, 4.46 s user,
3.7 GB peak for the whole module** (desktop; the oracle's `decide +kernel` is inside that, so P-J14b's "under 60 s" is met with room).
Iterations: three elaborations after the first build (namespace `SquareClass` for `fieldOfRadicands`; one `linear_combination` coefficient,
`1/4` not `−1/4`, in `δ(1 + ω̄) = 3`; the membership goals' shape after `simp`).

**The six-unit identity closed by factoring on the first elaboration that reached it**, in 3 + 5 + 3 + 3 lines (`sum_sixUnits` by
`Fin.sum_univ_six` and `ring`; `δ(1 + ω̄) = 3` and `1 + v + v̄ = 1/3` by `Complex.ext`; the product). P-J14c (≤ 40 lines): met, 14 lines.

**One finding the brief did not carry (logged at stage 1, used here):** `Gadget.transport` works inside one `Fin n`, so the rhombus gadget
(on `Fin 4`) could not be moved into the 18-vertex graph with it. A four-line `pullGadget` (the same pull-back, between `Fin n` and `Fin N`)
lives in this module, not in `Gadget.lean`, whose dependents a new declaration would rebuild. *Alternative weighed:* `Forces` plus
`Forcer.edgeHom` per diamond, then the chain of equalities by hand — no `decide` over port patterns at all. *Why the gadget route won:* the
brief asks for the gadget algebra as a second oracle independent of the chain theorem's proof; `edgeHom` would re-run the chain argument.
*Confidence:* high.

**The plants, both watched red for their reasons, then restored** (the faithful file re-elaborated with 0 errors after each):

| plant | file | what went red | the reason it names |
|---|---|---|---|
| drop the critical edge `(15, 17)` from `eighteenEdges` | `data/m2/j14/plant.lean` | `diamond_hom`: "Tactic `decide` proved that the proposition ∀ d, ∀ e ∈ rhombus, … is false"; and `#guard eighteenEdges.length = 33` | diamond 6 is no longer a homomorphism into the list — the oracle's refusal depends on that edge |
| drop `diamondGadget 2` from the refuting composite | `data/m2/j14/plant2.lean` | `eighteen_not_colorable_three`: "Tactic `decide` proved that the proposition `eighteenGadget.survivors = []` is false" | the kernel `decide` itself can go red: a broken chain leaves a surviving port pattern |

Kept in the module as permanent controls: the planted list is three-colourable (the reference colouring with vertex 17 recoloured `0` —
derived by hand from the four-colouring, vertex 17 being the only vertex of colour 3 and its neighbours `1, 16` having colours `1, 2` once
`15—17` is gone), diamond 6's map is not a homomorphism into it, and the six diamonds without the closing edge leave exactly one survivor,
all seven ports one colour (`#guard_msgs`).

### Would have searched here (stage 3)

| # | the move a search would have made | what was done instead |
|---|---|---|
| X2 | a three-colouring of the planted 32-edge list by a colourer | derived by hand from the reference's four-colouring (one vertex recoloured; its reason stated above) |

### Slip (logged)

The first timing run of this module and the first plant were run as bare `lake env lean`, not under `scripts/slot.py`, at a 3.7 GB peak —
over standing rule 8's 2 GiB line. Every later run went through the slot. No harm; logged for the inventory.

## Stage 4 — SAVED

`Proofs/HadwigerNelson/Instances/SevenConditional.lean` (≈120 lines): `G4` over `planeOver (fieldOfRadicands {3, 11})` (§M domain 3),
`w`, `eightUnits` (T9's eight, verbatim order), `sum_eightUnits`, membership in `planeOver ℚ(√3,√7,√11)` through `planeOverSubring`, the
inclusion `planeOver ℚ(√3,√11) ⊆ planeOver ℚ(√3,√7,√11)`, and `five_le_chromaticNumber_planeOver_seven_of_G4`. Spec: T9's identity in
its printed form, and a conjugate-swapped control (`w³ + w³ − 3w² − 3w̄² = (5/2)w + 9/4 ≠ 3/8`, its imaginary part `5√7/8`). Elaborates
with no error and no warning (three iterations: a `<;>` lint; the control first attempted through a raw `.im` expansion, replaced by the
reduction to `(5/2)w + 9/4` by `linear_combination (2w − 9)·(w² + (3/2)w + 1)`; a `linarith` made redundant by `simp`).

**Plant, watched red for its reason, restored** (`data/m2/j14/plant3.lean`): flip the fifth multiplier `−w²` to `w²`. `sum_eightUnits`
fails with "ring failed … `w ^ 2 * 2 = 0`" — the residual is exactly the flipped term twice, which is the reason the plant names. A second
red fired too, `eightUnits_mem` (no membership arm covers `w²`): a scaffolding failure, recorded as such. Restored file: 0 errors.

**Deviation from the brief, HELD FOR THE OWNER.** The brief asks for the docstring marker `VACUITY DECLARED:` on
`five_le_chromaticNumber_planeOver_seven_of_G4`. The marker is withheld. *The choice:* the docstring says "Conditional, and not vacuous"
and why, without the marker. *Alternative:* the marker, as briefed. *Why this won:* the gate reads `VACUITY DECLARED:` as a checked claim
that a hypothesis's domain is **provably empty** (`scripts/Vacuity.lean` lines 450–460: a marker on a carrier the probe does not find empty
is `STALE` and fails the gate unconditionally; `CLAUDE.md` § The gate: "`DECLARED` (deliberate emptiness …)"). `G4` is unproved, not
empty — the brief's own reason ("the spare-colour lemma is why it is not trivially false") says so. Here `h : G4` has no `Coloring`
carrier, so the marker would be inert rather than `STALE`, but it would still assert something false to a reader. *Confidence:* high; one
docstring line if the owner rules otherwise. The docstring of `G4` states the two facts that make its `Forces` a genuine compulsion:
Theorem B (every graph over `ℚ(√3,√11)` is four-colourable, row 57) and the spare-colour lemma (row 45: the forcer is not
three-colourable).

## Stage 5 — SAVED

### The gate (desktop, every run under `scripts/slot.py`)

| check | result | log |
|---|---|---|
| `./scripts/build.sh` (`--mem 60 --cpus 16`, `MEMMAX=60G`) | **OK** — 177 of 177 batches, 4 modules rebuilt (`Chain`, `Instances/SqrtTwoThree`, `Instances/SevenConditional`, `Proofs`), **0 modules with warnings**, 3 m 29 s | `data/m2/j14/build2.log` |
| `sorry` scan of the three modules | none | — |
| `./scripts/axioms.sh` | **OK — 1045 clean, 10 axiom-free, 5 declared purchases** (was 1034 clean); all 11 new entries `[propext, Classical.choice, Quot.sound]`; purchase ledgers agree | `data/m2/j14/axioms.log` |
| `./scripts/vacuity.sh` | **OK** — `declarations 6795 → 6875, refutations-skipped 278 → 280, sites 275 → 278, generic 253 → 256`; `vacuous=0 stale=0 declared=3 witnessed=17 generic=256 unknown=2` (the two baseline entries); new: 3 GENERIC sites (the `Forces` hypotheses of the three wrapper forms — the caller's obligation, discharged in-library by `spindle_of_chain`, `four_le_chromaticNumber_planeOver_two_three` and the conditional theorem) and 1 new evidence row (`eighteen_colorable_four`) | `data/m2/j14/vacuity.log` |
| `./scripts/vacuity.sh --self-test` | **OK** — every control fired, the two silent ones stayed silent | `data/m2/j14/vacuity-selftest.log` |
| `python3 tools/check_architecture.py` | **PASS** (164 module rows; before the rows were added it failed on exactly the three new modules — the check's own red) | — |

Registered: `Proofs.lean` (three imports), `ARCHITECTURE.md` § 3.6 (`Chain`) and § 3.8 (the two instances) with the prose counts
(1,698 files, 82 theory modules, 79 instance modules, 139 imports), `scripts/Axioms.lean` CLEAN (11 lines, an FS-45 block). The unused
`OneDefect` import was dropped from `Chain` before the build (its declared imports are now `Forcer`, `SquareClass`).

### The headline statements, read aloud against their informal claims

| theorem | read aloud | against the claim |
|---|---|---|
| `not_colorable_chain` | "for any graph drawn in `ℂ` with unit edges, forcing `a, b` equal at `k` colours, and any `m` unit complex numbers whose sum times `q b − q a` is `1`: the unit-distance graph induced on the chain's points is not `k`-colourable" | G55's "m chained copies plus one closing edge": ✓ — the closing edge is there because `0` and `1` are both chain points of the *induced* graph. **Not proved:** G55's vertex bound `m(n − 1) + 1` (the point set is the image of `Fin m × ι`, at most `m·n`; the sharper count is not stated). |
| `four_le_chromaticNumber_planeOver_two_three` | "four is at most the chromatic number of the unit-distance graph on the points of `ℂ` with both coordinates in `ℚ(√2,√3)`" | T6's lower half ✓. **Not proved:** the upper bound `≤ 4`; and "no Moser spindle in the field" (`√11 ∉ ℚ(√2,√3)`) is a remark in the docstring, not a theorem. |
| `eighteen_not_colorable_three` | "the graph on 18 vertices with these 33 listed edges has no proper 3-colouring" | ✓ combinatorially; its geometry (unit edges over `ℚ(√2,√3)`) is not checked in Lean. |
| `five_le_chromaticNumber_planeOver_seven_of_G4` | "if `G4` holds, five is at most the chromatic number of the plane over `ℚ(√3,√7,√11)`" | T9, conditional ✓; `K(√7) = ℚ(√3,√7,√11)`. |

### Predictions scored

| id | prediction | outcome |
|---|---|---|
| P-J14a (0.65) | all three K1 products, gate green, inside 3 h | **met** — stage 1 committed 16:02, the gate green by 16:21 (the whole job well under one hour) |
| P-J14b (0.60) | the gadget oracle's `decide +kernel` under 60 s | **met** — the whole module elaborates in 4.13 s |
| P-J14c (0.75) | the six-unit identity by factoring in ≤ 40 lines | **met** — 14 lines, first elaboration that reached it |
| my C0 (0.97 / 0.75 / 0.80 / 0.90 / 0.80 / 0.70) | per product | all met; the one surprise was structural (`Gadget.transport` is same-size), not arithmetic |

### Corrections owed (proposed; this job does not edit these files)

1. `CLAUDE.md` § Trust ledger: "1034 clean" → **1045 clean** (5 purchases unchanged).
2. `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt`'s header: `declarations=6875 refutations-skipped=280 sites=278`,
   `generic=256` (others unchanged).
3. `LEDGER.md` § B: ASTRA T5, T6 (lower half) and T9 (the implication) move from "stub" to **kernel**, addresses above; a row for FS-45 D1–D3
   is the front-page lane's call.
4. `plans/M2-kernel-lane.md` §2.1 names `Gadget.transport` as the move that carries the rhombus gadget into the 18-vertex graph; it works
   only inside one `Fin n` — the carrier is `SqrtTwoThree.pullGadget`.
5. `plans/STUB-chain-theorem.md` / `FRONTIER-STUBS.md` FS-45 row: D1, D2's lower bound and D3's implication are in the kernel; left, G4's
   certificate (post-ban, FS-45 phase C) and the kernel upper bound `χ(ℚ(√2,√3)²) ≤ 4`.
