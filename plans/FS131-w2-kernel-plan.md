# FS-131 wave 2 — the kernel plan (de Bruijn, the planner)

*Job FS131-K2, de Bruijn (Opus 5.5), launched 2026-10-04 in the worktree `.claude/worktrees/fs131-w2` (branch `fs131-w2`, from `3358a401`, wave 1's
skeleton). Brief `data/fs131/briefs/FS131-K2-wave2.md`, with `plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. The rows: the 28 of
`data/fs131/k1/dispositions.csv` with wave 2 and disposition *formalize* (FS116-O1-YESLIM moved in by ruling 6), quoted verbatim with the three rows
merged into them in `data/fs131/k2/rows-wave2.md` (main tree; written and checked by `tools/fs131_k2_rows.py`). Model: the opening plan
`plans/FS131-kernel-plan.md` §§ 5–7. No fence (inventory ruling 1).*

## Theorems this phase proved

None. A planning job: definitions, spec examples and inhabitants (sanity checks of definitions, listed under the stage that adds them), statements with
`sorry` at every leaf, and plans.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring of each `>`-block in the file its `— source:` line names), 2026-10-04:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. It's practically mechanical for us, …" | `CLAUDE.md` § Counter-priors | exact (a prefix of the paragraph's quotation) |
| 2 | "3. **States every row at the class its argument reads** (G92), …" | `plans/FS131-kernel-plan.md` § 7.3 | exact (a prefix of item 3; it ends mid-sentence at "reads each statement back in", the item continuing "its record against the row") |

No mismatch; no finding about the brief.

### 1.2 The table move (ruling 6)

`tools/fs131_k1_make_dispositions.py`: `put(2, P + "YesLimit", "FS116-O1-YESLIM")` in place of its wave-3 line, the reason column extended with
"moved from wave 3 to wave 2 by ruling 6"; the CSV regenerated (FS129-SR2-YESLIM-EQ follows its target to wave 2 by the script's merge rule);
`tools/fs131_k1_dispositions.py` exit 0 (259 rows, every upstream in an earlier or the same wave); waves now 14, **28**, 20, 29, 12, 35, 20, 22, 11, 14.
Committed on `main` from the main tree: `c1e860b7`.

### 1.3 The rows

The 28 formalize rows and the 3 merged ones, each block verbatim from `plans/LEAN-BACKLOG.md`, are `data/fs131/k2/rows-wave2.md` (`python3
tools/fs131_k2_rows.py --check` exit 0; `--self-test`: a changed character and a missing row tag both fire). By module, as the opening plan § 7.2 laid
them out, with YESLIM added:

| lane | module | rows |
|---|---|---|
| P | `Plane/MaximalCover` | FS111-C-FILL, FS111-M-SATC, FS111-M2-COV, FS111-M2-FIX, FS111-M-COVER-SC, FS121-D3-GRUNDY |
| P | `Plane/CoverExamples` | FS111-M-R7, FS111-W-SQ9, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-FIXCONV, FS111-M3-HC, FS111-M3-IRREG |
| P | `Plane/Slack` | FS111-V0-RESCALE, FS129-SR2-SUPK (carrying FS106-SUP), FS106-EQ, FS106-COMP (second clause), FS106-REM, FS121-D4-FACE (with V5-FACE-SHARP's hypothesis), FS121-V5-FACE-SHARP |
| P | `Plane/Stationary` | FS129-OA1-NOPERLAW |
| P | `Plane/FalconerReduction` | FS129-SA1-FALC-RED |
| P | `Plane/YesLimit` | FS116-O1-YESLIM (carrying FS129-SR2-YESLIM-EQ) |
| A | `Arith/PlaceHom` | FS129-SA1-PLACE-HOM, FS129-SA1-NOAFF-FIELDS |
| A | `Arith/FalconerField` | FS129-SA1-FALC-RES, FS129-MA2-FALC-HOSTS (clauses (ii)–(iv)) |
| A | `Arith/Dyadic` | FS129-SA1-SQRT3-LOCAL (carrying TC1-SQRT3-DYADIC) |

The definitions behind the statements were read at their sources: `data/fs111/claims.md` § 0 (D-NF, D-SLACK, essential closure and boundary, free,
contact, fill move, block structure), `data/fs106/claims.md` § 0 (D-M, D-CP, D-MU, D-SLACK form (b)), `plans/FS106-TQ-derivation.md` §§ 2–3 (the four
suprema, Lemmas P and T, TQ-REM-i, TQ-SUP, Route II), `plans/FS111-M-regularity.md` § 2 (saturated = every essential boundary point a contact point of
each colour of `P(x)`; "bound at `x`" = contact), `plans/FS111-M2-regularity.md` § 1.5 (regular MUA set), `plans/FS111-M3-finiteness.md` §§ 1.5–2.2
(HC by formula, (G1)–(G3)), and the derivation entries at the backlog's addresses.

### 1.4 The outside theorems the brief names, and the ones the reading added (decided in stage 3)

| theorem | consumer in wave 2 | first reading |
|---|---|---|
| de Bruijn–Erdős | N-EASY, hence YESLIM's `k = 6` clause | Rado selection is in Mathlib (`Finset.rado_selection`); formalize |
| N-EASY (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`, row 130's free half; in print as `[GwynStavrianos2022]` Lemma 2, Thm 2) | YESLIM | formalize (a random rigid motion and de Bruijn–Erdős) |
| Banach–Alaoglu | EQ (c) ⟹ (a), the weak-* step | Mathlib |
| Krylov–Bogolyubov for `ℤ²` | the opening plan named SUPK's attainment clause; **SUPK's merged form does not claim attainment** (its not-claimed line) | its consumer in wave 2 is EQ's (a) ⟹ (b) (FS-103's M1: a stationary limit of translates), if that is formalized here |
| `[Falconer1981]` Lemma 1 | FALC-RED | read the lemma, then decide |
| **added**: the Rajchman step (FS-103 M1's Step 2: `g ↦ ∫_Q ⟨g, g ⋆ σ⟩` is weak-* continuous on bounded sets) | EQ (c) ⟹ (a) (Route II), COMP's first clause, YESLIM | classical harmonic analysis; a Fourier-free route exists (`σ ⋆ σ` is absolutely continuous); decide in stage 3 |
| **added**: FS-103's M1 (`χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k`, row 130's last equality; our hand result, not a backlog row) | EQ's (a) ⟺ (b) | our own: never an axiom; formalize or a named hypothesis (decide in stage 3) |
| **added**: rows 78 and 88 (FS-73's `F = P = 8Λ` on de Grey's lattice [cert + tools + derived]; FS-86's frame over ℚ(√59), ℚ(√83), ℚ(√131) [hand]) | HOSTS (iii), (iv) | ours, not backlog rows: named hypotheses, stated as exactly the halves the clauses read |

### 1.5 Registered expectations (before the foundation is written; scored at the wave's landing)

| # | expectation | probability |
|---|---|---|
| W1 | at least one statement defect (a hidden hypothesis or an unfixed term) among the 28 rows, found at the skeleton | 0.7 |
| W2 | the hardest leaves are EQ's (c) ⟹ (a) (the Rajchman step and the weak-* limit) and FALC-RED (Lemma 1's measure-theoretic content), not the examples | 0.75 |
| W3 | at least one row is stated wider than filed (a G92 generalization) | 0.85 |
| W4 | the wave does not land in one implementer session (its analytic leaves are multi-session) | 0.8 |

### 1.6 The worktree builds as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, 2026-10-04:
**OK** — 440 of 440 batches, 8 modules rebuilt, 8 m 12 s; the only warnings are wave 1's `declaration uses 'sorry'` (28 distinct lines,
0 other warnings) (`build/gate/build/20261004T052044Z-1237531.log` in the worktree).

## Stage 2 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 2.1 The model, and why this shape

Three modules under `Proofs/HadwigerNelson/Plane/`, on the branch, sorry-free:

| module | holds | the modeling decision |
|---|---|---|
| `Plane/Cover` | `AeLE`, `IsAdmissible`, `IsAeCover`, `IsMaximalCover`, `IsSelection`, `AeColouring.cls`; `unitShadow` (`F + S¹`), `IsRegularMUA`; one class: `essClosure` (`A*`), `essBoundary` (`∂_e`), `unitAnnulus` (`A_η(x)`), `IsFreeFor`, `IsContactFor`; a family: `essMulticolour` (`P(x)`), `Saturated`, `SaturatedPos`; inhabitant `sq9` | **a colouring's classes, a cover and a partial colouring are one object, a family `Fin k → Set ℂ`, read by predicates** — R7 is "a maximal cover with disjoint classes", DISC7 a maximal cover with overlaps, a selection is a colouring; three structures would need conversions at every one of those sentences. The class predicates stay on one set, as wave 1's `UnitPairsNull` does. `IsMaximalCover` is maximality in `AeLE` among admissible covers (the row's "maximal under inclusion up to null sets") |
| `Plane/Suprema` | `upperDensity`, `bandPairSet`, `BandNull`, `BandFree`, `gridCell`, `IsGridUnion`, `IsPeriodicSet`, `IsPartialColouring`, `IsTiled`, `IsPeriodic`, `muZero`, `mu`, `muTile`, `muPer`, `AeColouring.HasSlack`, `AeColouring.Tight` | the four suprema exactly as FS106-TQ § 3 lists them, disjointness kept (the rows' "disjoint"; it is free for every supremum — a class-by-class difference keeps every class predicate — but the read-back stays literal). Two readings the derivations leave implicit are fixed and documented in the module: upper density is **centred at the origin, balls, `R → ∞`** (the suprema do not see the centre or the shape, a single family's density does); periodic is **`Lℤ²`-invariance** (Lemma P's lattice; narrower than "some lattice", so `lim µ^per = µ⁰` is the stronger statement). Limits in `ε` are `Tendsto … (𝓝[>] 0)` |
| `Plane/CPColouring` | `CPColouring k`, `shiftCol`, `rotCol`, `RotationInvariant`, `chiCP` | **a CP colouring is its law on the canonical space** `ℂ → Fin k`: every clause of D-CP is a statement about the law, so no sample space (and no universe) is quantified over; FS129-OA1-NOPERLAW's "stationary random colouring, continuous in probability, proper almost surely on every unit pair" is the same structure. **No separate "stationary family"** object: SUPK's merged form drops SUP's attainment clause (its not-claimed line), the only consumer the opening plan named |

The incidental structure refused: a structure per kind of family; a sample space in `χ_CP`; "kept", "fill", "boxes" and the
example objects in the foundation (they are single rows' vocabulary and live in the row modules).

### 2.2 Validation (the seams)

- `sq9 : AeColouring 9` — the half-open squares of side `1/2` coloured `(⌊2x⌋ mod 3, ⌊2y⌋ mod 3)` are **proper at every unit pair**
  (`sq9Col_ne_of_dist_eq_one`: one square gives distance `< √2/2`; equal indices mod 3 with different squares give a coordinate gap
  `> 1`), so `AeColouring 9`, `IsAeCover sq9.cls`, `IsPartialColouring sq9.cls` are inhabited sorry-free, and `1 ≤ muZero 9`. The
  opening plan's note "inhabitant: none cheap" is retired. Spec: `sq9` separates `0` and `1/2`, identifies `0` and `3/2`.
- `upperDensity univ = 1`, `upperDensity ∅ = 0`, **adversary** `upperDensity_ball_one` (a bounded set has density `0` — catches a
  limit taken at `R → 0`). `BandFree`: the empty family is band-free; **adversary**: `univ` is not, at any `ε ≥ 0`. `gridCell 1 0`
  holds `1/2`, not `1` (half-open). `IsPeriodicSet L univ`; `(0, 1) ∈ bandPairSet univ 0`. `HasSlack (−1)` holds for every colouring
  (the band is empty — `HasSlack` reads the band).
- `essBoundary univ = ∅`; every point is a contact point of `univ`; **adversary**: none of `∅`.
- `IsEmpty (CPColouring 0)`; **adversary** `IsEmpty (CPColouring 1)`; so `2 ≤ chiCP`. A CP inhabitant is a theorem:
  `Plane/Stationary`'s leaf `sq9CP` (sq9 under a uniform random translation of its period torus `(3/2)ℤ²`; proper at every pair
  because `sq9` is).
- Maximal covers: inhabited by FS111-M-SATC's first clause (a leaf; `sq9` lies below one).

### 2.3 The gate on this commit

- `./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`): **OK** — 440 of 440 batches, 4 modules rebuilt (the three
  and `Proofs`), no warning in the three new modules (the 7 modules with warnings are wave 1's `sorry`), 8 m 9 s
  (`build/gate/build/20261004T053542Z-1335267.log`).
- `#print axioms` of the 17 new records (`scripts/Axioms.lean`'s new section, run against the three modules): every one
  `[propext, Classical.choice, Quot.sound]`. (`scripts/axioms.sh` over the branch fails on wave 1's skeleton by design; the branch's
  gate is the implementer's.)
- `tools/check_architecture.py`: exit 0 (192 module rows, 0 import mismatches).

## Stage 3 — SAVED: the outside theorems, decided

| theorem | decision | reason |
|---|---|---|
| **de Bruijn–Erdős** | **Mathlib**: `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (already used by `Bridge.chromaticNumber_plane_le_iSup_numberField_of_descent`); `Finset.rado_selection` for the pair form (`Kempe.exists_coloring_ne_of_forall_finset`) | in the library's reach; nothing to import or prove |
| **N-EASY** (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`; `[GwynStavrianos2022]` Lemma 2, Thm 2 in print) | **formalize**, `Plane/YesLimit.chromaticNumber_plane_le_chiM0` (a leaf) | a random translation and rotation: for an edge `(u, v)` the bad set `{(x, θ) : c(x + e θ u) = c(x + e θ v)}` is a unit-pair set after the substitution `y = x + e θ u` and an angle shift, so null; a finite union of nulls; then de Bruijn–Erdős. A few hours; ours to hold |
| **Banach–Alaoglu** | **Mathlib** (`WeakDual.isCompact_polar`); in practice the implementer takes weak-* limits of indicator families by the sequential compactness of the bounded set in `L²(B_R)` (Hilbert weak compactness), avoiding `L^∞`'s dual | — |
| **Krylov–Bogolyubov** | **not needed in this wave**: its only wave-2 consumer is FS-103's M1 hard direction (a stationary limit of translates), which enters FS106-EQ's `χ_CP` clause as the **named hypothesis `Row130M1`** (outside the backlog; inventory § What "Closed" means, item 3). M1 with Krylov–Bogolyubov is a **separate planner-and-implementer job** (FS-103's M1 module) — stub to mint | M1 is our hand result (row 130's last equality), never an axiom; it is a construction of its own (Steps 1–5 of `plans/FS103-M-derivation.md` § 2.2: the stationary limit, the Rajchman step, continuity in probability, rounding), larger than this wave's other leaves, and no other wave-2 row reads it. The easy direction `chiM0_le_chiCP` is formalized here |
| **`[Falconer1981]` Lemma 1** | **formalize, for measurable `E`** (FALC-RED's `E`, the complement of the union of the classes' density sets, is Borel by Lemma 2(ii)) — a supporting lemma `falconer_lemma1` in `Plane/FalconerReduction`, with the motion a **translation** | read at `plans/FS129-MA1-audit.md` § 2.1 (the paper's statement transcribed from the page image; its proof there is "an obvious modification … of Croft [1]", which we do not hold). The planner's derivation [hand, one mind, this record]: it suffices to find `e ∈ E` with `σ(E ∩ S(e, r)) = 0` for the countably many radii `r = \|y − x\|`; suppose every `e ∈ E` fails for some radius; take `e₀ ∈ E_{r₁}`, then `A₁ = E ∩ S(e₀, r₁)` has positive length and some `E_{r₂}` meets it in positive length; the set `B = {(s, φ) : e₀ + r₁e(s) ∈ E_{r₂}, e₀ + r₁e(s) + r₂e(φ) ∈ E}` has positive measure by Tonelli, and `Φ(s, φ) = e₀ + r₁e(s) + r₂e(φ)` maps it into the null set `E` — against **the two-circle lemma** (`Φ` pulls Lebesgue-null sets back to null sets: its Jacobian `r₁r₂ sin(φ − s)` vanishes only on two lines). The translation `z ↦ z + e − x` is then the motion. No axiom; Lemma 1's "for almost all rotations" is exactly what FALC-RED reads, and the false strong form (a point of `E` fixed in advance) is never stated |
| **the Rajchman step** (`g ↦ ∫_Q ⟨g, g ⋆ σ⟩` weak-* continuous on bounded sets; FS-103 M1's Step 2), for FS106-EQ (c) ⟹ (a) | **formalize, Fourier-free**: `σ ⋆ σ` is the push-forward of `arcLength ⊗ arcLength` by `(s, φ) ↦ e s + e φ`, absolutely continuous by **the same two-circle lemma** (`r₁ = r₂ = 1`), so `T*T`-type quadratic forms `⟨f, f ⋆ (σ ⋆ σ)⟩` have an `L¹` kernel and are weakly sequentially continuous on bounded sets of `L²(B_R)` (approximate the kernel in `L¹` by continuous compactly supported ones) | Mathlib has `charFun` but no Plancherel-for-measures route at the pin that this would shorten; the two-circle lemma is shared with Falconer's Lemma 1, so it is paid once |
| **rows 78 and 88** (FS-73's `F = P = 8Λ` [cert + tools + derived]; FS-86's frame [hand]) | **named hypotheses** in FS129-MA2-FALC-HOSTS (iii), (iv), each the exact half the clause reads; the clauses are stated over the general forced-difference step the row actually adds | ours, outside the backlog; de Grey's lattice and the fields' rings are not in the library, and defining them belongs to those rows' own Lean forms |

**The shared child, named for the implementer: `twoCircle_preimage_null`** — for `r₁, r₂ > 0`, `Φ(s, φ) = r₁ e s + r₂ e φ` pulls
`volume`-null subsets of `ℂ` back to `volume`-null subsets of `ℝ × ℝ`. Route: off the null set `{sin(φ − s) = 0}`, `Φ` is a local
diffeomorphism (`HasStrictFDerivAt.toPartialHomeomorph`); cover by countably many open pieces where it is injective (Lindelöf) and apply
`MeasureTheory.lintegral_image_eq_lintegral_abs_det_fderiv_mul` on each. It carries Falconer's Lemma 1 and the Rajchman step.

No outside theorem enters as an axiom in wave 2; `ARCHITECTURE.md` § Trust is unchanged.

## Stage 4 — SAVED (partial): the skeleton for 22 of 28 rows, the read-backs, the leaf plans

**Where it is.** Branch `fs131-w2`, nine new modules (`Plane/MaximalCover`, `Plane/Slack`, `Plane/Stationary`,
`Plane/FalconerReduction`, `Plane/YesLimit`, `Plane/CoverExamples`, `Arith/PlaceHom`, `Arith/FalconerField`, `Arith/Dyadic`), 50
theorems of which 48 are `sorry` leaves (`chiM0_le_iff_chiCP_le` and `chromaticNumber_plane_le_six_of_fragments` are closed from
their siblings); `Proofs.lean`, `ARCHITECTURE.md` (201 rows, `tools/check_architecture.py` PASS) and `scripts/Axioms.lean` (50 records)
updated. **Build**: `./scripts/build.sh` under the slot OK — 443 of 443 batches, 10 modules rebuilt, the only warnings `declaration uses 'sorry'` (wave 1's and wave 2's), 8 m 19 s (`build/gate/build/20261004T055131Z-1424411.log`). **Not yet stated** (§ 4.4): FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG — each
needs its object defined sorry-free first (R7's Reuleaux tiling, DISC7's discs, HC by the formula of `plans/FS111-M3-finiteness.md` § 1.6).
The fresh `debruijn-obligation-modeling` pass the brief names was **not run** (budget); the leaf plans below are mine without it.

### 4.1 The read-backs (each formal statement against its row, `data/fs131/k2/rows-wave2.md`)

| row | declaration | read-back |
|---|---|---|
| FS111-C-FILL | `AeColouring.exists_fill` | `x` `j`-free with that `η`: `x ∈ essClosure`, `|S̃_j ∩ A_η(x)| = 0`; conclusion: the filled function is an `AeColouring`. **Same** |
| FS111-M-SATC | `exists_isMaximalCover`, `IsMaximalCover.interior_union_unitShadow`, `IsAdmissible.exists_aeColouring` | (i) same ("lies below" = `AeLE c.cls C`); (ii) same with `F_j = essSupport (C j)`; (iii) **wider**: a selection from any admissible family (maximality unread) — generalization |
| FS111-M2-COV | `isMaximalCover_iff` | same; measurability of the tuple a hypothesis, as the row's "k-tuple of measurable sets" |
| FS111-M2-FIX | `IsRegularMUA.interior_eq_compl_unitShadow`, `.component_side` | same; the identity `int F = ℝ² ∖ (F + S¹)` and its two readings |
| FS111-M-COVER-SC | `enclosing_or_exterior`; `curvatureLeOne`; `semiconcaveWith` | (i) "enclosing unit disc or exterior one" read as a centre `y` with `|x − y| = 1` and `P ⊆ B̄(y, 1)` or `P ∩ B(y, 1) = ∅` (M-regularity § 3.4's own wording), preconnected for path-connected (wider). (ii) **statement defect**: the row's "semiconcave with constant 1" is false (R7's cusped down triangles); stated in the ruled curvature form, with the Lipschitz corollary (constant `(1 + L²)^{3/2}`), ruling items 18–19. **No wave-2 consumer reads the constant 1** (nothing in wave 2 uses COVER-SC; FS111-M2-HULLC is wave 6) |
| FS121-D3-GRUNDY | `exists_grundy` | all five clauses: never raising (pointwise), `A_m ⊇ S_m ∖ ⋃_{i<m} A_i`, `A_m` inside the complement and maximal there (at `m = 0` the complement is the plane, so `A_1` is a MUA set), supports in shadows, the bound clause at essential boundary points for every colour of `P(x)` below another. **Same** |
| FS111-V0-RESCALE | `exists_tight`, `exists_tight_iff_chiM0_le` | same |
| FS129-SR2-SUPK (+ FS106-SUP) | `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` | same, every `k` (the row's `k ≥ 1` is idle: at `k = 0` every supremum is `0`); SUP's attainment clause not claimed, as SUPK's not-claimed line says |
| FS106-EQ | `chiM0_le_iff_muZero_eq_one`, `chiM0_le_iff_chiCP_le`, `muZero_eq_one_iff_tendsto`, `chiM0_le_iff_periodic`, `seven_le_chiM0_iff` | the five-way equivalence as four iffs; (a) ⟺ (b) **given `Row130M1`** (FS-103's M1, named; its easy half `chiM0_le_chiCP` unconditional); (e)'s "leaving density ≤ δ uncovered" as covered upper density `≥ 1 − δ`; the `k = 6` clause with the limit as `⨆_{ε>0} µ₆(ε)`; S–V §9's reading is commentary, not a statement |
| FS106-COMP | `forall_mu_six_lt_one_iff` (second clause); first clause = `chiM0_le_iff_muZero_eq_one` (SR2 item 11) | `[Voronov2023]` Thm 1.1 named as `Voronov11` (D-VPROP at six colours, every `ε > 0`); same |
| FS106-REM | `keptAt_band`, `CPColouring.tendsto_not_kept`, `exists_not_uniform_kept` | (i) one class (G92), `η < 1/(1 + 4π)`, membership of the kept points unread — **wider**; (ii) with the jointly measurable modification as an existential, as TQ § 2.3 constructs it; (iii) the uniform form's falsity as an existential colouring proper at every unit pair (the zigzag, TQ's control C2) |
| FS121-D4-FACE (+ V5-FACE-SHARP's hypothesis) | `face`, `face_densitySet` | one class (G92: only `A`'s unit pairs are read — **wider**); hypothesis `2g − g² ≤ ρ²` in place of `2g < ρ²` (SR1 item 6); `g > 0`, no upper bound on `g` (the row has none — if the proof needs `g < 1`, that is a defect to report); the last clause for any saturated admissible family |
| FS121-V5-FACE-SHARP | `exists_face_fails` (and `face` for its first half) | "fails for some colouring" as an existential `AeColouring` at some `k`, for every `0 < g`, `0 < ρ` with `ρ² < 2g − g²` |
| FS129-OA1-NOPERLAW | `exists_discrete_forcedSet`, `forcedSet_eq_zero` | the object is `CPColouring` (its definition is D-CP); same |
| FS129-SA1-FALC-RED | `falconer_reduction`, `le_chiM_of_falconerFan` (with `falconer_lemma1`, `twoCircle_preimage_null`) | same; `H` a finite set of points with the induced unit-distance graph; "every cover by k measurable sets" with `⋃ S j = univ` |
| FS116-O1-YESLIM (+ YESLIM-EQ) | `chiM0_le_of_fragments`, `chromaticNumber_plane_le_six_of_fragments`, with N-EASY `chromaticNumber_plane_le_chiM0` | a valid `k`-coloured fragment on a closed disc of radius `R` is `F.Covers p R ∧ F.Valid` (wave 1's `ArcMap`); every `k` (the row's `k ≥ 1` idle) |
| FS129-SA1-PLACE-HOM | `exists_placeHom` | "restricts to reduction mod 𝔭 on 𝒪_{F,𝔭}" read without localization types (every `a/s`, `s ∉ 𝔭`, in `V` with `φ(a/s)·s̄ = ā`); the coset formula as `h x − h y = (φ(Δre), φ(Δim))`; same |
| FS129-SA1-NOAFF-FIELDS | `noAffine_fields` | same; `φ` indexed by the finite vertex set (finite support automatic) |
| FS129-SA1-FALC-RES | `falconerFan_five_field`, `falconerFan_five_placeHom` | (ii) for **every** `(V, φ)` with PLACE-HOM's properties (the row: "V and φ as in PLACE-HOM") — the argument reads only those properties |
| FS129-MA2-FALC-HOSTS (ii)–(iv) | `not_falconerFan_five_of_fanGap`, `falconerFan_five_mem_eight`, `falconerFan_five_mem_P` | (ii) **wider**: any additive image of `Λ` not killing a unit vector, not only `Λ/NΛ`; "connected" unread. (iii) over any lattice with row 78's half as the named `hR78`. (iv) over any `R ⊇` unit vectors with row 88's frame as the named `hR88`, `hR88per` (its "every four-colouring periodic" a proposition `Per`) — the clauses' own content is the forced-difference step |
| FS129-SA1-SQRT3-LOCAL (+ TC1-SQRT3-DYADIC) | `sqrt3_local`, `sqrt3_local_of_congr`, `sqrt3_dyadic` | `F(i)/F` as any quadratic `L/F` with `ι² = −1` in `L` (**wider**: `F` need not be real); "3 a square in `F_w`" as `IsSquare (3 : P.adicCompletion F)`; the congruence form is the proof's engine and TC1's form its case `s = √3` |
| FS111-W-SQ9 | `sq9_tight_saturated` | half-open squares for the row's closed ones (equal off a null set; every predicate here reads densities); same |

**Generalizations found at this stage** (for Keryx; none narrows a row): SATC (iii) from any admissible family; REM (i) and FACE for one
measurable set with null unit pairs; HOSTS (ii) for any additive image not killing a unit vector, with connectedness unread; SQRT3-LOCAL
for any `F` with `i ∉ F`; YESLIM and SUPK at every `k` (the `k ≥ 1` idle); FALC-RES (ii) for every PLACE-HOM pair.

### 4.2 The plan per leaf (difficulty E easy, M moderate, H hard; Mathlib names to confirm with `#check` at implementation)

**Shared children first.** `twoCircle_preimage_null` (H; stage 3's route) carries `falconer_lemma1` and the Rajchman step.
`unitPairsNull_congr_ae` (M: `A =ᵐ B` and `UnitPairsNull A` ⟹ `UnitPairsNull B`, by Tonelli in `θ` and translation invariance) carries
SATC (iii), COV, C-FILL. `essSupport_eq_closure_densitySet` (M: for measurable `A`, by `Besicovitch.ae_tendsto_measure_inter_div`).

- `exists_fill` (M): the new class `j` is `S_j ∪ B(x, η/2)`; unit pairs inside the disc none (diameter `< 1` once `η < 1`, from
  `x ∈ A*_j` and I-D1 at a density point near `x`), pairs disc → `S_j` land in `A_η(x)` where `S_j` is null off `S̃_j`; other classes
  shrink (`UnitPairsNull.mono`).
- `exists_isMaximalCover` (M): Zorn (`zorn_le_nonempty`) on admissible covers above `c.cls`, preordered by `AeLE`; a chain's upper
  bound is the class-wise union of a countable cofinal subfamily (measure-maximizing sequence: `volume (C j ∩ ball 0 n)` sup).
- `interior_union_unitShadow` (M): a point outside `F_j + S¹` has a ball whose unit annulus misses `F_j`; adding the ball to class `j`
  keeps null unit pairs; maximality forces the ball into `C j` a.e., so the point is interior to the support.
- `IsAdmissible.exists_aeColouring` (E): `f⁻¹{j} ⊆ᵐ C j`, `unitPairsNull_congr_ae` and monotonicity.
- `isMaximalCover_iff` (M): maximality is coordinatewise (enlarging one class touches no other); a coordinate is MUA iff
  maximal among admissible sets (`IsMUA`'s definition).
- `interior_eq_compl_unitShadow` (M): `⊆` wave 1's `dist_ne_one_of_mem_interior_densitySet` with `int F = int Ã`; `⊇` the shadow
  identity of SATC (ii) for a single MUA set (same proof). `component_side` (E): the first conjunct is the identity; the second, `dist · y`
  is continuous and never `1` on a connected component.
- `enclosing_or_exterior` (M): `x ∈ ∂F_a` gives a contact `y ∈ F_a` (`interior_union_unitShadow`); wave 1's `hullset` at the
  density points of `P` against the point `y` (positive upper density at a support point approached by density points) gives the side.
- `curvatureLeOne` (M): from the first clause at each touching point (the ruling: proved from the first clause, which is unaffected):
  the enclosing disc's upper arc or the exterior disc's lower arc touches `u` from above, and a `C²` `φ` above `u` is above the arc's
  touching function near `s₀`'s curvature, so `φ''/(1 + φ'²)^{3/2} ≤ 1` there. `semiconcaveWith` (M): viscosity curvature bound plus
  the Lipschitz bound give `φ'' ≤ (1 + L²)^{3/2}` at touching points; the perturbation argument (`u − Ks²/2` touched from above with
  nonpositive second derivative is concave; the `−ε(s − m)²` trick).
- `exists_grundy` (H): by exhaustion class by class (V3's dependent-choice route): `A_m` a maximal admissible set inside the complement
  containing `S_m ∖ ⋃`, by a measure-maximizing sequence; the shadow clause: a support point of `A_m` off `supp A_i + S¹` gives a ball
  to move into `A_i`, against maximality of `A_i`; the last clause from the shadow clause at contact.
- `exists_tight` (M): `ε* = sup {ε | c has slack ε}` is finite (a class of positive measure has band pairs at `ε ≥ 1`); dilate by
  `1 + ε*`: the colouring `x ↦ c(x/(1 + ε*))` has no slack beyond, and slack at `ε*` itself is closed under limits (`BandNull` at
  each `ε < ε*` and countable union). `exists_tight_iff_chiM0_le` (E): `chiM0_le` and `exists_tight`; the other way `chiM0 ≤ k`
  gives an `AeColouring m`, `m ≤ k`, padded to `k` colours by `Fin.castLE`.
- `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` (H): TQ § 3.2 verbatim — `µ^per ≤ µ^tile ≤ µ`; Lemma T
  (`µ(ε) ≤ µ^tile(ε − 2√2h)`); Lemma P (window, period `(R + 2)`, rounded to a multiple of `h`); `µ^tile(ε) ≤ µ⁰`; and
  `µ⁰ ≤ lim µ^tile` by `keptAt_band` (kept sets are band-free) and the bounded form (ii′) (a.e. point of a measurable set is kept
  for small `ε`: Lebesgue density). Children: `lemmaP`, `lemmaT`, `antitone_mu`.
- `chiM0_le_chiCP` (M): TQ § 2.3 steps 1, 3 — the dyadic modification and Fubini on `law ⊗ volume ⊗ arcLength`.
- `chiM0_le_iff_muZero_eq_one` (H): ⟹ `one_le_muZero`; ⟸ Route II (TQ § 3.3) with the maximal inequality replaced by a union bound
  over finitely many integer radii at each stage (a centre chosen uniformly in `B(0, M/2)`; Markov) — a shorter route, no
  Hardy–Littlewood; the weak limit in `L²(B_R)` per radius (diagonal); the Rajchman step through `twoCircle_preimage_null`;
  the threshold rounding `c_U(x) = min{j : Σ_{i ≤ j} g_i(x) > U}` and Fubini in `U`.
- `muZero_eq_one_iff_tendsto` (E): `tendsto_mu` and uniqueness of limits. `chiM0_le_iff_periodic` (M): ⟸ via `muPer` and
  `tendsto_muPer`; ⟹ `tendsto_muPer` at `µ⁰ = 1`. `seven_le_chiM0_iff` (E): antitone `µ₆`, `tendsto_mu`, the `k = 6` case.
- `forall_mu_six_lt_one_iff` (H): QB § 2.7; ⟸ with no attainment: a full measurable colouring with slack from `µ₆(ε) = 1`
  is not available without SUP's attainment, so the route is D4 (`c = min{j : x ∈ supp S_j}` is proper everywhere on the open band)
  and Voronov's statement at `ε/2` — read QB first; if QB's direction needs attainment, that is a finding.
- `keptAt_band` (M): TQ § 2.2's chord lemma and the good/bad pair count by the exchange identity; `ε > 1/2` separately (no point kept).
- `CPColouring.tendsto_not_kept` (M): TQ § 2.3 steps 1, 2, 4. `exists_not_uniform_kept` (M): the zigzag colouring of TQ § 1.2 C2.
- `face`, `face_densitySet` (M): FS121-D4-proof § 2.1 and V5's pair lemma: Fubini on `Leb ⊗ σ` over the half-box against the far box
  through the unit circle about `x + e`, the corner condition `(1 − g)² + ρ² ≥ 1`; then saturation. `exists_face_fails` (M): V5 § 2.2's
  colouring with its parameters general (a small box `Q` just beyond `x + e`).
- `nonempty_cpColouring_nine` (M): the law of `y ↦ sq9Col (y + z)`, `z` uniform on `[0, 3/2)²`; shift invariance by periodicity and
  translation invariance of the torus measure; continuity in probability by the measure of a strip; properness exact (`sq9Col_ne_of_dist_eq_one`).
- `exists_discrete_forcedSet` (M): `Z` a closed subgroup (continuity in probability; stationarity; `P(f 0 = f x) = 1` composes);
  `Z ∩ S¹ = ∅` (properness); a closed subgroup of `ℂ ≅ ℝ²` missing the unit circle is discrete (a non-discrete closed subgroup holds
  a line — classical; prove: small nonzero elements, their multiples reach the unit circle within any `δ`, closedness). `forcedSet_eq_zero`
  (E): rotation invariance makes `Z` rotation-invariant; a discrete rotation-invariant subgroup is `{0}`.
- `twoCircle_preimage_null` (H), `falconer_lemma1` (M), `falconer_reduction` (H: FALC-RED's argument reordered as MA1 § 2.2 —
  Lemma 1, D2 for two classes at `p(a)`, Lemma 3 by translation, Lemma 4 with the irrational rotation), `le_chiM_of_falconerFan` (E).
- `chromaticNumber_plane_le_chiM0` (M): stage 3. `chiM0_le_of_fragments` (M): a fragment restricted to its disc is an a.e.-proper
  partial colouring (its arcs are null: each arc is a Lipschitz image of an interval), Lemma P makes it periodic of density
  `→ 1` as `R → ∞`, so `µ⁰ = 1` and `chiM0_le_iff_muZero_eq_one`.
- `exists_placeHom` (H): induction on `n` (V_n by evaluation at `t_n = 0`, `Transcendental`'s `zeroPlace`/`evalZero` and
  `mem_valuationSubring_of_sq_add_sq_eq_one`); base `V₀ = 𝒪_{F,𝔭}` (the localization's image in `ℝ`); the hom by
  `unitQuadrance_colorable_of_subring`'s coset step (`cosetResidue`).
- `noAffine_fields` (M): wave 1's `noAffine` with `T = Γ_q` (slack facts `finitePlane11_slack`, `finitePlane19_slack`, Γ₇'s
  `circ7Table` with `slack_addCayley_of_fanGap`) or `T = K_{k−1}` (when `χ(E²) ≤ k − 1`, row 104 iterated:
  `chromaticNumber_planeOver_adjoin_transcendental_eq`); the residue field of size `q` prime is `ZMod q`.
- `falconerFan_five_field`, `falconerFan_five_placeHom` (H): FALC-FAN (B) at `Γ₇`, (A) at `Γ₁₁`, `Γ₁₉` with the orbit facts by
  `decide +kernel` (2 × 121 × 24 and 40 × 361 colourings; price from the first leaf) beside `Instances/FanGap11`, `FanGap19`.
- `not_falconerFan_five_of_fanGap` (M), `falconerFan_five_mem_eight` (E), `falconerFan_five_mem_P` (E): DICHO-K's second clause
  through the inclusion hom; translation of the gapped colouring (`FanGap.translate`).
- `sqrt3_local_of_congr` (H): `γ = (−1 + s ι)/2`, minimal polynomial `x² + x + c`, `c = 1 + (s² − 3)/4 ∈ 𝓞 F`, discriminant
  `−s²` a `P`-unit; Kummer–Dedekind (`NumberTheory/KummerDedekind.lean`) at `P` with `x² + x + 1` over `𝔽_{2^f}` (splits iff `𝔽₄ ⊆`,
  iff `f` even; separable). `sqrt3_local` (M): Newton's lemma in `adicCompletion` to the congruence (density of `𝓞 F`).
  `sqrt3_dyadic` (E): `s = √3`.
- `sq9_tight_saturated` (M): tight from the positive-measure pair set between squares `(0,0)` and `(3,0)` at distances `(1, 1 + ε]`;
  saturated with positive partners: an essential boundary point lies on a square's edge, and the facing same-colour square's edge is
  at distance exactly `1` (W § 1.5).

**Price** (to be re-priced from the first two leaves): the analytic leaves — `twoCircle_preimage_null`, the Rajchman step and Route II,
SUPK, `exists_grundy`, `falconer_reduction`, `exists_placeHom`, `sqrt3_local_of_congr` — are multi-hour each; the wave does not land in
one implementer session (W4).

### 4.3 Vacuity and inhabitants

`AeColouring` (`sq9`), admissible covers (`sq9.cls`), partial colourings (`sq9.cls`, the empty family), `CPColouring`
(`nonempty_cpColouring_nine`, a leaf), maximal covers (`exists_isMaximalCover`, a leaf), regular MUA sets (FS111-M3-HC, not yet stated —
until then `IsRegularMUA`'s inhabitant is owed), `FalconerFan` (wave 1's `rhombus_falconerFan`, at four colours; a fan at five colours is
not known to exist, so FALC-RES and HOSTS quantify over a possibly empty domain — their conclusions are constraints a fan must meet, as
their not-claimed lines say: `VACUITY DECLARED` is **not** warranted, emptiness is open; they read `GENERIC`/`UNKNOWN` at the gate),
`ArcMap` fragments (wave 1's `const`), number fields with usable primes (ℚ at `𝔭 = (3)`, `(7)`, `(11)`, `(19)`).

### 4.4 Left for the next planning session

State FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG in `Plane/CoverExamples`, each object
defined sorry-free first: R7 (Reuleaux triangles `⋂ closedBall v 1` on the up triangles `{λ, λ + 1, λ + ω}` of `ℤ[ω]`, `ω = e(π/3)`,
coloured by `λ mod 2Λ`; the cusped down triangles by `(a − b) mod 3` for `λ = a + bω`, which is the coset of
`M = ⟨√3 i, 3/2 + (√3/2) i⟩ = {a ≡ b (mod 3)}`); DISC7 (`closedBall (m v₁ + n v₂) (1/2)`, `v₁ = √3/2`, `v₂ = (√3/2) e(π/3)`, colour
`(m + 3n) mod 7`; same-colour centres `√21/2` apart); HC by the formula (face centres `L(3/2, √3/2)`, `L(0, √3)`, `L = 2 + √3/3`;
centroids `O + L e(kπ/3)`, up for even `k`; triangles `convexHull {C + (O_i − C)/(√3 L)}`; edge frames from the down centroid `C_d`:
origin `C_d + (√3/6) u`, `u = (C_u − C_d)/L`, `z = origin + t u + s (i u)`; `U = {z ∈ T_up : t ≥ 2 + g(s)` in its three frames`}`; bands
`{|s| < 1/2, 1 < t < ℓ(s)}`, `ℓ(s) = sInf {t | infDist z U ≤ 1}`; discs `closedBall O (1/2)`), parametrized by a gap function with
(G1)'s bounds (`G1Bounds Z g`) and the formula `hcGap Z` (`g(s) = (s − a)²(b − s)²/4` on the gap `(a, b)` of `Z`). BAND's three clauses
need the frame of a flat side (midpoint `m`, direction `d`, half-length `a`); its horn sub-clause is the `λ = 1` case of HC's (G3).
Then run `debruijn-obligation-modeling` over the whole wave and re-price.

## Stage 5 — SAVED: where it is, and how the implementer works

**Branch `fs131-w2`** in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (`.lake/packages` symlinked, `.lake/build` its own copy —
never symlink it). Base: wave 1's skeleton `3358a401`; the foundation (stage 2) and the skeleton (stage 4) are on top. Wave 1's modules are
frozen statements here (their proofs land from `fs131-w1`); wave 2 imports wave 1's `Plane/UnitAvoiding` (`IsMUA`), `Plane/ArcMap`,
`Arith/FalconerFan`, `Arith/NoAffine` and may cite wave-1 leaves by name — when wave 1 lands, `main` is merged into this branch first.

- **Builds**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`; up to two such builds across trees (ruling 5); exit 75 → wait ten minutes. `lake env lean
  <file>` for iteration only (it does not apply `autoImplicit := false`; pass `-DautoImplicit=false`), never as evidence; an iteration
  `-o` olean must be deleted before the real build.
- **The implementer may** add lemmas (children) anywhere in the wave's modules and supporting lemmas in the foundation (`Plane/Cover`,
  `Plane/Suprema`, `Plane/CPColouring` — e.g. `unitPairsNull_congr_ae`, `essSupport_eq_closure_densitySet`, `antitone_mu`), change
  imports (updating `ARCHITECTURE.md`'s Imports cell), and import library modules. **It may not** change any statement; a needed change
  comes back through Keryx. `Row130M1`, `hR78`, `hR88`, `hR88per` are named hypotheses from outside the backlog and stay hypotheses.
- **Order**: the shared children (`twoCircle_preimage_null`, `unitPairsNull_congr_ae`), then MaximalCover (SATC, COV, FIX before
  COVER-SC, GRUNDY), Slack (RESCALE, `keptAt_band`, Lemmas P and T, SUPK, then EQ), YesLimit, FalconerReduction, Stationary; lane A
  (PlaceHom before FalconerField; Dyadic independent) in parallel.
- **The gate** for landing (after the six remaining rows are stated by a planner): build with no warnings, `scripts/axioms.sh` clean
  (every wave-2 record the standard three; no purchase), `./scripts/vacuity.sh` and `--self-test` green with the counts reconciled
  (FALC-RES and HOSTS over a possibly empty domain read `GENERIC`/`UNKNOWN`, never `VACUITY DECLARED`), `tools/check_architecture.py`
  exit 0; then merge `main`, re-run, fast-forward.

## Stage 6 — SAVED: the readback (FS131-K2b)

*Job FS131-K2b, de Bruijn (Opus 5.5), launched 2026-10-04 to finish wave 2 from K2's stage 5 (brief
`data/fs131/briefs/FS131-K2b-wave2-finish.md`, with `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building). Resuming per standing
rule 2: `git log -- plans/FS131-w2-kernel-plan.md` shows K2's stages 1–5 saved at `69650050`, `6d6a87e6`, `856341a7`, `3620923c`; this job
redoes none of them and numbers its own stages from 6.*

### 6.1 The brief's quotation against its source (standing rule 3)

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "State FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG in `Plane/CoverExamples`, each object" | this record § 4.4, on `fs131-w2` at `3620923c` | exact (checked by script as a substring); the paragraph does end "Then run `debruijn-obligation-modeling` over the whole wave and re-price.", as the brief says |

No mismatch.

### 6.2 What this job owes (restated from the brief and the inventory)

- **The six rows**, verbatim in `data/fs131/k2/rows-wave2.md` (main tree) at the headings `### 18. FS111-M-R7`, `### L17. FS111-M2-DISC7`,
  `### L33. FS111-M3-BAND`, `### L34. FS111-M3-FIXCONV`, `### L35. FS111-M3-HC`, `### L36. FS111-M3-IRREG`, each identical to its block in
  `plans/LEAN-BACKLOG.md`. None carries an erratum; DISC7, BAND, FIXCONV, HC and IRREG carry caution C118 (they left the order because no seed
  rests on them). Their arguments: `plans/FS111-M-regularity.md` § 2.4 (R7), `plans/FS111-M2-regularity.md` § 1.6 (DISC7),
  `plans/FS111-M3-finiteness.md` § 1.5 (BAND), §§ 1.6, 2.1–2.4 (HC), § 4.1–4.2 (IRREG, FIXCONV).
- **The rulings in force** (`plans/FS131-close-inventory.md`): item 19 (FS111-M-COVER-SC's second clause in the viscosity curvature form, its
  Lipschitz semiconcavity a corollary; R7's cusped downs the counterexample to the literal clause — state that failure on R7 if cheap); item 22
  (`Row130M1`, `hR78`, `hR88`, `hR88per` named hypotheses from outside the backlog); item 23 (the question: does FS106-COMP's ⟸ read
  FS106-SUP's attainment clause, which SUPK drops?).
- **The obligation-modeling pass** over all 28 rows, re-pricing; **the handoff** brought to 28 rows.

### 6.3 The worktree builds as K2 left it

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
2026-10-04: **OK** — all 1738 modules up to date, nothing built, 2 s (`build/gate/build/20261004T060508Z-1509443.log`); 76 distinct warnings,
every one `declaration uses 'sorry'`: 28 wave 1's, 48 wave 2's (K2's count).
