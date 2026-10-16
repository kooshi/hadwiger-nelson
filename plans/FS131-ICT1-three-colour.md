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

## Stage 3 — SAVED: `Fibre` §1–§2 and the two marked leaves; the re-price; a statement defect ruled

### 3.1 A false skeleton statement, ruled (inventory item 1003)

`CayleyThree.mcshane_model` (`Density.lean` l. 71–73) was false as typed: `mcshane (fun y => ∑ j, y j) {0} ⊥ 0 x = ∑ j, x j`.
With `B = {0}`, `L = ⊥`, `λ = 0` the set under the `sInf` is the singleton `{h 0 + λ 0 + ‖x‖₁} = {‖x‖₁}`, so the left side is
`l1 x`; at `m = 1`, `x = ![-1]` it is `1` against `−1`. Sent to the coordinator at once (2026-10-16, about 14:55 UTC). **Ruling
(item 1003): fix (a)** — the model kept, the conclusion corrected to `mcshane (fun y => ∑ j, y j) {0} ⊥ 0 x = l1 x`, its
docstring and the module docstring's sentence saying the extension is `h 0 + ‖x‖₁ = ‖x‖₁`; listed in the gate's statement
comparison as a ruled change. Applied in `Density.lean` (the theorem's docstring, the statement's right side, and one sentence
of the module docstring); no other text of the skeleton moved.

### 3.2 Two hypotheses the proofs do not read (findings, not defects: the statements are true and stay as typed)

- `even_pmHeight_sub_sum (hc : ProperAlong s c)`: `pmHeight x − Σ x = 2(Σ x − liftHeight x)` for every `c`.
- `exists_le_mul_of_imp_eq_zero (hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)`: the decomposition of an element of `M` into minimal
  nonzero elements uses only `hsub` and additivity.
Each proof references its binder by `have _ := h` with a comment (the build's `unusedVariables` linter is otherwise red). A
statement weakened by dropping the binder would be a statement change; it is the coordinator's to rule if wanted.

### 3.3 The re-price at the plan's two marked leaves

| leaf | plan | proved | route |
|---|---|---|---|
| `exists_le_mul_of_imp_eq_zero` | 90 | ≈ 45 | the plan's: `Mn` (minimal nonzero) an antichain, finite by `WellQuasiOrderedLE.finite_of_isAntichain`; `κ = sup t` on it; `WellFoundedLT.induction` with `WellFounded.has_min` for a minimal `μ ≤ x` |
| `exists_slack_bound` | 80 | ≈ 100 | the plan's: per sign pattern `p`, `sg v = ±v`, `M_p = {v | relMap (sg v) = 0}`, slack as `ℕ` by `toNat`, `minRise` additive on an orthant; `κ = 1 + Σ_p κ_p` |

Together 145 against 170. With `Circular` at 0.63 and `Fibre` §1–§2 (≈ 290 lines of proof against the plan's ≈ 470 for those
leaves), **the re-price is at or below the plan, not above it**: the rest of `Fibre` (plan ≈ 375) and `Density` (plan ≈ 770)
are priced at the plan's numbers or less. No message needed under item 1000's ruling; all three modules ride in one landing.

### 3.4 Routes in `Fibre` §1–§2 that differ from the plan

- One representation lemma, `liftHeight_eq_of_sub` (`x = u − v` with `u, v` natural: `u = x⁺ + t`, `v = x⁻ + t`, and the `t`
  parts cancel by `height_append`), carries `liftHeight_add_single` and the additivity along relations
  (`liftHeight_add_of_relMap_eq_zero`: the representation `(x⁺ + r⁺, x⁻ + r⁻)` and `wind_shift`) — no `closure_induction` on the
  basis. `heightWinding`'s fields and `liftHeight_add_ker` read it.
- `abs_pmHeight_sub_le`: along one coordinate by `Int.induction_on`, then coordinate by coordinate by `Finset.induction_on`
  (`Finset.univ_sum_single`), no induction on `l1`.
- `step_eq_one/two_of_isTight`: tightness plus `wind_shift` and generation make the positive word's height its length (the
  negative word's twice its length) from every base point; `List.perm_cons_erase` puts `j` first.
- New public constants in `Fibre` (each named here for the statement comparison): `relMap_single`, `relMap_eq_wsum`,
  `liftHeight_eq_of_sub`, `height_word_single`, `liftHeight_of_relMap_eq_zero`, `three_dvd_liftHeight`,
  `liftHeight_add_of_relMap_eq_zero`. Private: `wind_eq_of_surjective`, `minRise_eq_parts`, `height_eq_of_isTight`, `term_le`.
- Upstream definitions are read by `change` (never `simp [minRise]`, `simp [relMap]`, `simp [height]`), so no `eq_n` of
  `ThreeColour`'s definitions is minted here; the gate's dump and `dupnames.sh` check it.

## Stage 4 — SAVED: `CayleyThree/Fibre`, every leaf proved

All twenty-six leaves of `Fibre` are proved (iteration, no error and no warning: `data/fs131/ict1/logs/Fibre.out`). 1,052 lines
against the skeleton's 226: **about 830 lines of proof against the plan's 1,020**. Routes after stage 3, where they differ:
- `exists_mem_pi_Icc_of_forall_int`: the held private proof with `lo`, `hi` (copied, as the plan says; the private original is
  untouched). A private `exists_mem_box_of_le_vertex` runs the held `Winding.exists_box_point` on a general box from a vertex
  bound at every relation; `exists_mem_fibre_gt` feeds it the box with `lo_j = 1/3 + 1/(3κ)` and pays the raised face from the
  slack bound (`−minRise(−r) = Σ_i (2 r_i if r_i ≥ 0, else r_i)`, private `neg_minRise_neg`).
- `Winding.flip`, `mem_fibre_flip_iff`, `isTight_flip_iff`, `exists_mem_fibre_lt`: one identity, `minRise (−r) = minRise r − 3 Σ r`
  (private `minRise_neg`).
- `exists_rat_mem_fibre_relint`: the average of `2m + 1` fibre points indexed by `Option (Fin m × Bool)` (`Convex.sum_mem`,
  `Finset.sum_lt_sum`), then a private `exists_rat_near_of_box` (the face trick of `exists_torsion_mem_bandSet`, stated once for a
  rational system with a real solution in `[1/3, 2/3]^ι`) on the relation generators.
- `exists_affine_of_forall_three_nsmul`: every fibre point's character is a band character, so `3x_j ∈ ℤ`; a direction moved by
  no tight relation has fibre points with `x_j = 2/3` and `y_j = 1/3`, whose midpoint has `3/2 ∈ ℤ` — so every direction is
  tight and every step constant; `c (a + relMap r) = c a + Σ_j r_j d_j` on a subgroup of `ℤ^m` holding every `Pi.single j 1`,
  hence on all of it; `φ = c − c 0`.
- `isTight_one_two`: `decide` after `heightWinding_apply`.
Private additions: `exists_pos_le_of_finite`, `exists_rat_near_of_box`, `exists_mem_box_of_le_vertex`, `neg_minRise_neg`,
`minRise_neg`. No public constant beyond stage 3's seven.

## Stage 5 — SAVED: `CayleyThree/Density`, every leaf proved; all 53 leaves done (iteration)

All thirteen leaves of `Density` are proved (iteration, no error and no warning: `data/fs131/ict1/logs/Density.out`), so
**no `sorry` remains in the three modules** (`grep -c sorry` = 0 in each). 731 lines against the skeleton's 144: **about 590
lines of proof against the plan's 770**. The three modules: 2,194 lines against the skeleton's 506, **about 1,690 lines of
proof against the plan's 2,230** (0.76). The build, the gate and the drafts are not yet run (stage 6 on).

Routes in `Density`, where they differ from the plan:
- §0 (new, public): the grid distance's API — `l1_nonneg`, `l1_neg`, `l1_add_le`, `l1_sub_le`, `abs_le_l1`, `l1_single_one`,
  `even_l1_sub_sum` (parity of `‖v‖₁ − Σ v`). Private: `le_term`, `bddBelow_terms` (the McShane set is bounded below by
  `−Σ_{β∈B} |h β − ‖x − β‖₁|`).
- §1 as planned (`Int.csInf_mem`, `csInf_le`, `le_csInf`); the step bound by one optimal term each way and the parity of every
  term. `mcshane_model` in its ruled form (item 1003).
- §2 as planned: the short vectors are a finite box; one finite-index `W_v ⊇ M` missing each (residual finiteness,
  `exists_finiteIndex_between_notMem` with `H = ⊤`); `N = q · ∏ index`.
- §3, the assembly, **in integers throughout**: a private `exists_slope` turns the rational fibre point into a common
  denominator `D₀` and integer slopes `a_j = D₀(3 − 6x_j)` with `|a_j| ≤ D₀`, `< D₀` off the tight set `T`, `D₀ (h(x + e_j) −
  h x) = a_j` on `T`, `D₀ (h(x + r) − h x) = a · r` on relations. Then `Λ v = a · v`, `ZT` (vectors supported on `T`), `M = R ⊔ ZT`,
  `N` from §2 with `q = 6D₀`, `L = R ⊔ N ℤ^m`, `λ ℓ = Λ ℓ / D₀` (exact on `L`); `λ ≡ 0 (mod 3)` on all of `L`; (C′) through `M` by
  the Lipschitz bound and off `M` by stripping the `T`-part (`D₀(λℓ + ‖ℓ‖₁) ≥ ‖ℓ off T‖₁ > 2·Dbd·D₀`, private `term_nonneg`,
  `term_ge`); the descent `c' b = ĥ(lift b) + c 0`, its period group `relMap(N ℤ^m)` of finite index by a surjection from
  `Fin m → Fin N`.
- `exists_isPeriodic_eqOn`: the nonzero steps listed by `Finset.equivFin`; the family form; `Coloring.mk`.
- `coloring_mem_closure_isPeriodic`: `nhds_pi`, `Filter.mem_pi`, density at the finite set the cylinder fixes.
- `forcedSubgroup_finiteIndex_iff_finite`: ⟹ colourings inject into `A ⧸ F → Fin k` (`Quotient.out`); ⟸ each period group's
  quotient injects into the colourings by translation (`addCayleyTranslate`), then `AddSubgroup.finiteIndex_iInf`.

**Not done here** (item 1000's ruling): the coset reduction (plan § 3.5, density without generation) and the dichotomy's
cell clause (plan § 2.5). The re-price left room in lines, not in this job's context: see the hand-back line below.

**Hand-back point.** At this stage the job is at about the brief's hand-back line (≈ 550k by the harness's count). What is
left for a successor, in order: stage 6, the build (`./scripts/build.sh` under the slot, the brief's line), `lake lint`; stage 7,
merge `main` (the collapse landed at `0f81fe2a3`; the gate's baseline is now `data/fs131/ico2/gate/` on `main`, per the
coordinator's message), the gate on one commit by `data/fs131/clone1/run-gate.sh`'s steps copied under `data/fs131/ict1/`, the
statement comparison against `data/fs131/ict1/statements-before.txt.gz` (ruled change: `mcshane_model`'s right side, item 1003;
new public constants: `Circular.rep01_coe`; `Fibre.relMap_single`, `relMap_eq_wsum`, `liftHeight_eq_of_sub`, `height_word_single`,
`liftHeight_of_relMap_eq_zero`, `three_dvd_liftHeight`, `liftHeight_add_of_relMap_eq_zero`; `Density.l1_nonneg`, `l1_neg`,
`l1_add_le`, `l1_sub_le`, `abs_le_l1`, `l1_single_one`, `even_l1_sub_sum`), the vacuity scan's new sites with each structure's
inhabitant (plan § 3.7's list), `#print axioms` of every head statement; stage 8, the read-aloud against row 79 and the drafts
(the planner's § 3.8, brought to what is proved).
