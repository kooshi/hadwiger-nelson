# FS131-ICT1 — the three-colour skeleton implemented: the criterion, the periodic form, density

*Implementer: de Bruijn (Opus 5.5), job FS131-ICT1, brief `data/fs131/briefs/FS131-ICT1-three-colour.md` (on `main`). Worktree
`.claude/worktrees/kel1`, branch `fs131-ktc1`, at `60e16a8c1` on arrival (the planner's `29be81111` with `main` merged, no Lean
changed). Started 2026-10-16 14:38 UTC. No fence (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1). The plan is
`plans/FS131-KTC1-three-colour-plan.md`.*

## Theorems this phase proved

None yet (stage 1).

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

`tools/fs131_ict1_quotes.py` (each quotation, as a contiguous block of whole lines, against its source in this worktree and in
the main tree): `data/fs131/ict1/quote_check.out` — **5 quotations, 0 mismatched** (W2 in `data/fs131/REQUEST-2026-10-13.md`;
inventory items 996 and 1000 in `plans/FS131-close-inventory.md`, both trees; the 46-line block of `CayleyThree/Circular.lean`
and the 12-line block of `CayleyThree/Density.lean`, in this worktree). Its control (`--plant`: one character changed in the
longest line of each quotation) reports all five (`quote_check_plant.out`, exit 0).

### 1.2 The targets and the order of work

Fifty-three `sorry` leaves in three modules, every statement fixed (never edited by me; a defect goes to the coordinator):

| order | module | leaves | the plan's price |
|---|---|---|---|
| 1 | `CayleyThree/Circular` | 14 (incl. 2 spec examples) | 440 lines |
| 2 | `CayleyThree/Fibre` §1–§2 | the height layer, `heightWinding`, `surjective_relMap_iff`, the fibre, H-ii | part of 1,020 |
| 3 | `Fibre` §3 first two: `exists_le_mul_of_imp_eq_zero`, `exists_slack_bound` | **re-price the rest here** | |
| 4 | `Fibre` §3–§5 | the box, Farkas by sides, the flip, the relative interior, rigidity | |
| 5 | `CayleyThree/Density` | McShane, the period, density, `P = F`, the first dichotomy clause | 770 lines |

Head statements (the brief's): `colorable_three_iff_bandSet_nonempty`, `finiteIndex_ker_of_nsmul_eq_zero`,
`exists_torsion_mem_bandSet`, `colorable_three_iff_exists_isPeriodic`, `colorable_three_rat`, `not_isPeriodic_rat`,
`colorable_three_iff_of_fg_torsionFree` (one line), `exists_isPeriodic_eqOn`, `coloring_mem_closure_isPeriodic`; and from the
plan: `periodicForcedSubgroup_three_eq_forcedSubgroup`, `inheritanceQuestion_three` (one line), `forcedSubgroup_finiteIndex_iff_finite`,
`exists_affine_of_forall_three_nsmul`, `exists_isPeriodic_eqOn_of_fg_torsionFree` (one line). Item 1000's ruling: the coset
reduction (plan § 3.5) rides only if the re-price leaves room; the dichotomy's cell clause (§ 2.5) is a later module.

### 1.3 The skeleton's stored statements, dumped before the first proof

`data/fs131/ict1/lean/StatementDump.lean` (FS131-ICO1's dumper with this job's three modules), run with `lake env lean` against
the worktree's compiled skeleton (sources' md5 equal to the planner's `data/fs131/ktc1/build2.sources.md5`, so the `.olean`s are
those of the gated-for-skeleton build), 2026-10-16 14:40 UTC: `data/fs131/ict1/statements-before.txt.gz` — 71 constants
(`Circular` 20, `Fibre` 35, `Density` 16). The comparison at the gate reads it.

## Stage 2 — SAVED: `CayleyThree/Circular`, every leaf proved

All fourteen leaves of `Circular` are proved (iteration: `lake env lean` with the lakefile's options, no error, no warning;
`data/fs131/ict1/logs/Circular.out`; the build and the gate are the evidence, at stage 5). 411 lines against the skeleton's
136: **about 275 lines of proof against the plan's 440**. Routes, where they differ from the plan:
- `exists_rat_solution_near` (≈ 85 lines): the plan's route, with the normalization done once by a division. `V = span_ℚ {1, x_i}`,
  `bV = Module.finBasis ℚ V`; the system holds **coordinate by coordinate** (`Σ_i G_ki a_il = b_k c_l`, by applying `bV.repr` to the
  equation in `V`, no linear-independence argument); `w_i(t) = Σ_l a_il t_l`, `u(t) = Σ_l c_l t_l` are continuous, equal `x_i` and
  `1` at `t₀ = (bV l)_l`; near `t₀`, `u > 0` and `|w_i/u − x_i| < ε` (`Filter.Tendsto.div`, `Filter.eventually_all`); a rational
  `t` there (`DenseRange.piMap`, `Rat.denseRange_cast`) gives `q_i = w_i(t)/u(t)`.
- `exists_torsion_mem_bandSet` (≈ 140 lines): one finite family `f` listing `S ∪ G₀` (`G₀` a finite generating set, `AddGroup.fg_iff`)
  through `Finset.equivFin` in place of `Fin.append`; the faces as extra rows of the system (`Fin m ⊕ {j // face j}`), the margin
  from a private `exists_pos_le`; `exists_character_of_box_point` at the rational point; `∏ den` kills the character on `f`,
  hence on `closure (range f) = ⊤` (`AddMonoidHom.ker_eq_top_iff`).
- `colorable_three_iff_exists_isPeriodic`: the circular colouring of `S ∖ {0}` composed with `Hom.ofLE` of
  `addCayley_erase_zero` (`addCayley S ≤ addCayley (S ∖ {0})`); its periods contain `ker θ`, of finite index.
- `not_isPeriodic_rat`: `K.index • (q / K.index) = q` (`AddSubgroup.nsmul_index_mem`), so every rational is a period.

New constants in `Circular`: one public, `rep01_coe` (`rep01` is the identity on `[0, 1)`; the spec example reads it); two
private, `exists_pos_le`, `floor_three_ne`.

**Re-price after `Circular`**: the module came in at about 0.63 of the plan's lines. LEAN.md's rule is to re-price from the
first two leaves of each *kind*; `Fibre`'s two marked leaves are the re-price point for the rest.
