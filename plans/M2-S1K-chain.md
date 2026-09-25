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
