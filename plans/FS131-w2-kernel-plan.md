# FS-131 wave 2 — the kernel plan (de Bruijn, the planner)

*Job FS131-K2, de Bruijn (Opus 5.5), launched 2026-10-04 in the worktree `.claude/worktrees/fs131-w2` (branch `fs131-w2`, from `3358a401`, wave 1's
skeleton). Brief `data/fs131/briefs/FS131-K2-wave2.md`, with `plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. The rows: the 28 of
`data/fs131/k1/dispositions.csv` with wave 2 and disposition *formalize* (FS116-O1-YESLIM moved in by ruling 6), quoted verbatim with the three rows
merged into them in `data/fs131/k2/rows-wave2.md` (main tree; written and checked by `tools/fs131_k2_rows.py`). Model: the opening plan
`plans/FS131-kernel-plan.md` §§ 5–7. No fence (inventory ruling 1).*

## Theorems this phase proved

None. A planning job: definitions, spec examples and inhabitants (sanity checks of definitions, listed under the stage that adds them), statements with
`sorry` at every leaf, and plans.

FS131-K2b (stages 6–10): none either — the six rows' objects, spec examples, and five theorems closed from their leaves (`exists_r7`,
`not_forall_semiconcaveWith_one`, `disc7_sum_upperDensity`, `not_forall_isRegularMUA`, `not_forall_fix_converse`) plus `hcZ0_spec`; every
row-level claim is a `sorry` leaf. Hand arguments in this record (one mind, not theorems of the kernel): BAND (1)'s general form (§ 7.3),
the value-1 attainment by compactness (§ 8), FACE's counterexample at `g > 2` (§ 9.1).

FS131-K2c (stages 11–13): none. Two skeleton facts closed in passing, not results: `bandNull_iff_iccPairNull` (`Iff.rfl`) and
`isMaxIn_maxIn` (from its `sorry`ed sibling `exists_isMaxIn`); `chiM0_le_of_fragments` re-pointed at its child. Hand arguments in this
record (one mind): the counterexamples and construction behind ruling 86 (§ 12.1), the Fourier-free Rajchman route (§ 12.1), the P-local
Kummer–Dedekind coefficients (`exists_dyadic_coeffs`' docstring), the window route for SUPK's lower bound (`eventually_le_muPer`).

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

## Stage 7 — SAVED: the six example rows stated (`Plane/CoverExamples`)

### 7.1 The model (`debruijn-domain-modeling`, invoked fresh, scoped to the six objects)

- **One lattice for three objects.** `tri m n = m + n e(π/3)`: R7's tiles sit on it, DISC7's centres are `(√3/2)·tri` (M2 § 1.6's
  `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)` exactly), HC's face centres `L√3 e(π/6)·tri` (§ 1.6's span of `L(3/2, √3/2)`, `L(0, √3)`).
- **R7 is a colouring given in lattice coordinates**, not a union of tiles: `triCoord z = (a, b)`, cell `(⌊a⌋, ⌊b⌋)`, fractional part `(u, v)`.
  Inside a cell's down triangle `D(m, n) ⊆ B̄(λ + 1, 1) ∩ B̄(λ + ω, 1)`, so a point there is in `U(m, n)` iff it is within 1 of `λ`, in
  `U(m + 1, n)` iff within 1 of `λ + 2`, in `U(m, n + 1)` iff within 1 of `λ + 2ω`; on the up half `triQ u v ≤ (u + v)² ≤ 1` holds
  automatically. So `r7ColTri` is three quadratic tests (`triQ a b = a² + ab + b² = ‖a + bω‖²`) and the colours of § 2.4: ups
  `2(m mod 2) + (n mod 2)` (cosets of `2Λ`), downs `4 + ((m − n) mod 3)` (`M = ⟨(0, √3), (3/2, √3/2)⟩ = {λ(m, n) : m ≡ n (mod 3)}`, since
  `(0, √3) = λ(−1, 2)`, `(3/2, √3/2) = λ(1, 1)`). A function, because the row's a.e.-properness and tightness are about an `AeColouring`;
  its classes `r7Cls` are the family the saturation and boundary clauses read.
- **DISC7 is a family**, `disc7 a = ⋃ {B̄(c(m, n), 1/2) : (m + 3n) mod 7 = a}` (a cover with overlaps, so no colouring function).
- **HC is one set parametrized by `g`**, built from § 1.6 literally: down triangles, `U = {z ∈ T_up : t ≥ 2 + g(s)` in its three edge frames`}`,
  the bands `{|s| < 1/2, 1 < t < ℓ(s)}` with `ℓ(s) = sInf {t : infDist (frame s t) U ≤ 1}`, the face discs. Edges are indexed by an up
  centroid `(m, n)` and `j : Fin 3` (direction `e(2πj/3)` to the down neighbour); `hcFrame` is `(s, t) ↦ C_u + ((L − √3/6 − t) − s i) w`,
  with `hcFrameS`, `hcFrameT` its inverse. `G1Bounds Z g` is (G1) as §§ 2.2–2.4 read it; `hcGap Z` is § 1.6's formula.
- **IRREG's fat set is `fatZ`**: `[−1/2, 1/2]` minus balls of radius `min(4^{−(n+2)}, dist(q_n, ±1/2)/2)` about an enumeration of `ℚ` —
  closed, nowhere dense, length `≥ 5/6`, `±1/2 ∈`. The proof reads only those four properties, so the Smith–Volterra–Cantor set's
  construction is incidental; IRREG is stated for every such `Z`.
- **Refused**: a structure per object; HC by a fundamental domain and its symmetry group (up/down-preserving, so the edge frames would still
  be needed); the hexagonal colouring Hex7 as an object (DISC7's description, not a clause).

### 7.2 Validation (spec examples, all sorry-free)

- R7: `r7ColTri (1/3) (1/3) = 0` (U(0,0)'s centroid), `(2/3, 2/3) ↦ 4` (D(0,0)'s centroid), **`(11/20, 11/20) ↦ 0`** (a down-half point in
  U(0,0)'s bulge — the Reuleaux test fires), `(4/3, 1/3) ↦ 2`, `(5/3, 2/3) ↦ 5`, **`(99/100, 1/50) ↦ 4`** (inside D(0,0)'s cusp at the vertex
  1, outside both bulges by `3·10⁻⁴` — the cusp is not swallowed). `triCoord_add_mul`, `normSq_add_mul` tie the coordinates to `ℂ`.
- DISC7: `c(1, 2)` has the origin's colour at distance exactly `√21/2`; **adversary**: the neighbours `c(1, 0)`, `c(0, 1)`, `c(1, −1)` get
  other colours; `0 ∈ disc7 0`.
- HC: face spacing `L√3 = 2√3 + 1`; the up vertex toward its face centre at distance exactly 2; the facing sides `2` apart in every frame;
  `0 ∈ hcSet g` for every `g`.
- Models of hypotheses: `hcZ0_spec` (HC₀, `Z = {±1/2}`, with `hcGap`; closed from the leaf `g1Bounds_hcGap`) for HC; `fatZ_spec` with
  `g1Bounds_hcGap` for IRREG (used in `not_forall_isRegularMUA`). `fatZ` is closed by a sorry-free example.

### 7.3 The read-backs (each statement against its row, `data/fs131/k2/rows-wave2.md`)

| row | declarations | read-back |
|---|---|---|
| FS111-M-R7 | `r7Col` (object); `exists_r7` (closed from `r7_aeColouring`, `r7_not_bandNull`, `r7Cls_saturated`); `r7_boundary` | a.e.-proper: an `AeColouring 7` with `col = r7Col`; tight: `c.Tight`; saturated: `Saturated c.cls` (the row's parenthesis, contact form). Last clause read pointwise: a point in the essential closure of two classes is at distance exactly 1 from a lattice point in the **support** of both ("carries": a down carries its colour at a lattice point by a cusp, of density 0 but in the support). At a lattice point where three up colours meet, each pair has such a centre (`λ₀ + 1`, `λ₀ + ω`, `λ₀ + ω − 1`; checked by hand). **Same** |
| (defect witness) | `not_forall_semiconcaveWith_one` (closed from `r7Cls_isMaximalCover`, `r7_lowerGraph`, `not_semiconcaveWith_one_lowerArc`) | the literal COVER-SC clause, quantified over every maximal cover, refuted on R7's down class 4 under the lower arc about 0 near `e(π/6)`, `J = (1/10, 1/5)`. `r7Cls_isMaximalCover` is FS111-VMW-R7-MAX's last clause (a derivation entry, not a backlog row), formalized here as a leaf |
| FS111-M2-DISC7 | `disc7` (object); `disc7_isMaximalCover`, `disc7_isRegularMUA`, `disc7_lens`, `disc7_upperDensity`, `disc7_sum_upperDensity` (closed from the per-class density) | maximal admissible seven-cover; regular classes (`IsRegularMUA`); "overlaps (lenses) have positive measure" read as **every two classes** meet in positive measure (each disc meets one disc of every other colour: the six neighbour differences are `±1, ±3, ∓2`) — the strongest reading, true; densities as `upperDensity`; the sum is the value `2π/(3√3)`, Kershner's optimality not stated (the row names the number) |
| FS111-M3-BAND | `IsMUA.add_normal_mem_essSupport`; `band_excludes_horn`, `le_one_of_band_unitFree`; `vesica_apex`, `vesica_apex_exact` | (1) **wider and sharper** (messaged to Keryx, a generalization): any MUA set, at any point with the half-box behind it a.e. inside and the normal ray just beyond outside the support, has `m + e θ` in its support — so material at distance exactly 1 over the whole side; no block, diameter or regularity read. (2) the band idealized as its base segment `[p, p + ℓd]`: a horn point past the end at offset `(x, w)` is excluded iff `x − √(1 − w²) ∈ [0, ℓ]`, a window of length exactly `ℓ` ("out to λ" read as the window's length; § 1.5's own sentence "at distance u from the band's left end" holds only at `λ = 1`); "unit-free only if λ ≤ 1" pointwise. (3) "excluded exactly by an apex at depth √3/2, tight at one point": depth `√3/2` excludes the lower half-vesica with equality at exactly `(0, 1 − √3/2)` (C0), and every smaller depth fails |
| FS111-M3-HC | `hcSet g` (object), `G1Bounds`, `hcGap`; `hc_isRegularMUA`, `hc_band_components` | for every closed null `Z ⊆ [−1/2, 1/2]` holding `±1/2` and every `g` with (G1)'s bounds: `int HC` is a regular MUA set, `supp (int HC) = HC`, and M2-FIX's identity. (G1) carries the lower-parabola bound in place of `|g″| ≤ 1/2` (its only use; **wider**). The Cantor clause **at every `Z`** (the argument reads only that `g` vanishes exactly on `Z`; **wider**): two band points share a component iff no point of `Z` lies between their `s` |
| FS111-M3-IRREG | `hc_irreg`; `not_forall_isRegularMUA` (closed from `fatZ_spec`, `g1Bounds_hcGap`, `exists_isMUA_ae_le`, `hc_irreg`) | for every closed nowhere dense `Z ⊆ [−1/2, 1/2]` of positive length holding `±1/2` (**wider** than the Smith–Volterra–Cantor set) and every `g` with (G1): unit-avoiding pointwise, `cl A = HC`, `|HC ∖ A| = 0`, `|∂HC| = 0`, the shadow identity, `¬ IsMUA A`, and every MUA `A′ ≥ᵐ A` (a.e. containment, **wider** than `⊆`) has `|∂ supp A′| > 0`; MUA-REG-U false as `¬ ∀ A, IsMUA A → IsRegularMUA A` |
| FS111-M3-FIXCONV | `not_forall_fix_converse` (closed from `hc_irreg` at `fatZ`) | "the converse of M2-FIX fails" as the negated universal: closed, `cl int F = F`, `|∂F| = 0` (M2 § 1.3's regularity of a closed set), `int F` with null unit pairs and `int F = ℝ² ∖ (F + S¹)` does not force `IsMUA (int F)`. **Same** |

**Generalizations at this stage** (for Keryx; none narrows a row): BAND (1) (messaged); HC's Cantor clause at every `Z`; (G1) with the
lower-parabola bound; IRREG for every closed nowhere dense `Z` of positive length and a.e. containment.

### 7.4 The plan per leaf (22 new leaves; E easy, M moderate, H hard)

- `r7_aeColouring` (H): measurability (`Int.measurable_floor`, `measurableSet_le`, `Measurable.ite`, countable-valued `r7UpCol ⌊a⌋ ⌊b⌋`); null
  unit pairs: by the period lattice `{m, n even, m ≡ n (3)}` (index 12) every same-colour pair of points at distance 1 lies in one of finitely
  many same-colour tile pairs (centroids within 3; § 2.4's 240), each of which either has diameter 1 (one up: only vertex–arc pairs) or is at
  distance `≥ 1` with the distance-1 pairs on boundary arcs; the pair set is then inside `{x on a circle or arc}` (null). Children:
  `r7_sameColour_pair` (the finite case table, exact in `ℚ(√3)`, `nlinarith` per pair type after the symmetry reduction), `unitPairsNull_of_subset_boundary`.
- `r7_not_bandNull` (E–M): in `U(0, 0)` pairs near the vertex `0` and near the arc point `e(π/6)` at distances in `(1 − ε, 1)` form an open
  nonempty subset of `int U × int U`: positive `Leb ⊗ Leb` measure.
- `r7Cls_saturated` (H) and `r7_boundary` (M–H): one shared child, `r7_essClosure_classify` — a point in the essential closure of two classes
  lies on an arc of some `U(m, n)` facing a down (P = {up, down}) or is a lattice point (P = its three up colours; the cusps have density
  0: two tangent unit circles bound them, area `O(r³)` in `B(x, r)`) — and `r7_arc_centre_colours` (M-R7-FORCE's coset computation: the
  arc's centre `v` is a vertex of the up and the cusp of the down's colour at `v` is the backward one). Saturation: the up colour is bound by
  `v` (in `cl` of the up's density set), the down colour by `v` through the cusp.
- `r7Cls_isMaximalCover` (M–H): `isMaximalCover_iff`; each class MUA through FS111-M2-ZERO (`isMUA_iff_ae_phi_pos`): for a.e. `x` off class
  `j`, the unit circle about `x` crosses class `j` in an arc (VMW-R7-MAX's strongest-reading saturation made strict a.e.).
- `r7_lowerGraph` (M): points `e(π/6) + e(2π/3)(s + t i)` within `δ` below the lower arc are outside `B̄(0, 1)` and more than 1 from `2` and
  `2ω` (`≈ 1.31`, `≈ 1.24` from `e(π/6)`): interior of `D(0, 0)`, colour 4; above it, inside `B(0, 1)` near `e(π/6)`: interior of `U(0, 0)`.
- `not_semiconcaveWith_one_lowerArc` (E): `u − s²/2` is strictly convex on `J` (`u″ = (1 − s²)^{−3/2} > 1`); or the explicit triple
  `s = 3/20`, `h = 1/25`.
- `disc7_isMaximalCover` (M), `disc7_isRegularMUA` (M): `isMaximalCover_iff`; null unit pairs (one disc: only antipodal boundary pairs;
  two same-colour discs `≥ √21/2 − 1 > 1` apart); maximal: covering radius `√7/2 < 3/2` of the colour lattice (spanned by `c(1, 2)`,
  `c(−3, 1)`), so for a.e. `z` off the class `1/2 < |z − c| < 3/2` for some centre and the circle crosses that disc; cover: covering radius
  `1/2` of all centres. Regular: a locally finite union of closed discs is its own support, boundary in circles. Children:
  `disc7_coveringRadius_colour`, `disc7_coveringRadius_all`.
- `disc7_lens` (E–M): the disc of colour `a` at a centre and its neighbour with colour difference `b − a` (all six nonzero residues occur)
  are `√3/2 < 1` apart: their lens has nonempty interior.
- `disc7_upperDensity` (M–H): child `upperDensity_of_periodic` (a set invariant under a lattice with a bounded fundamental domain `D` has
  density `|S ∩ D|/|D|`, the ratio over `B(0, R)` converging by counting cells; shared with SUPK's Lemma P), covolume `21√3/8`, one disc
  `π/4` per cell.
- `IsMUA.add_normal_mem_essSupport` (M): stage 7.3's argument. Children: `IsMUA.interior_union_unitShadow` (SATC (ii) for one MUA set; the
  cover version then follows coordinatewise), `essSupport_eq_closure_densitySet`, M2-INT (wave 1), an open set a.e. inside `A` lies in `Ã`.
- `band_excludes_horn` (E), `le_one_of_band_unitFree` (E): real algebra; `s = (ℓ − 1)/2`, `s + 1`.
- `vesica_apex` (M): (C0) — from `(x ± 1/2)² + (y − 1)² ≤ 1`, `y ≤ 1`: `x² + (y + √3/2)² ≥ 1`, equality only at `x = 0`, `y = 1 − √3/2`;
  `nlinarith` with `√3² = 3`. `vesica_apex_exact` (E): `z = (1 − √3/2 + η) i`.
- `g1Bounds_hcGap` (M–H): gap endpoints `a(s) = sSup (Z ∩ Iic s)`, `b(s) = sInf (Z ∩ Ici s)`; on a gap the polynomial identities of (G1);
  at points of `Z` the derivative is `0` by `g ≤ dist²/4`; `g′` is `1/2`-Lipschitz across gaps, then Taylor for the lower parabola.
- `hc_isRegularMUA` (H, the wave's largest example leaf): §§ 2.3–2.4. Children, each stated with `interior Z = ∅` in place of `volume Z = 0`
  wherever § 4.2 (1) says nullity is unused, so IRREG reuses them: `hcUp_slivers` (G2), `hcBandTop_spec` (G3: `1 ≤ ℓ ≤ 1 + g`, `ℓ = 1` iff
  `s ∈ Z`, `ℓ` continuous, `{t < ℓ} = {d_U > 1}` on `t < 2`), `hc_unitAvoiding` (§ 2.3: block distances on one period, exact in `ℚ(√3)`; the
  band's diameter `≤ 1` by the quartic thinning), `hc_sausage_cover` (B1, with H3's quadrilateral), `hc_lemmaNL` (the exterior disc
  `R = 5/4`, H5's constants), `hc_exclusion` (B2: every `z ∉ int HC` in `HC + S¹`), and, using nullity, `hc_ae_phi_pos` (strictness off the
  null level sets and `N_e`). Then `isMUA_iff_ae_phi_pos` (wave 1) and regularity (boundary in segments, circles, graphs).
- `hc_band_components` (M): `hcBandTop_spec`; `hcFrame` is an isometry; over a gap the region `{s ∈ J, 1 < t < ℓ(s)}` is connected
  (vertical intervals over an interval, `ℓ` continuous); a point of `Z` between gives an empty fibre, separating.
- `fatZ_spec` (M): `±1/2` survive (radius `≤` half the distance); `|⋃ balls| ≤ Σ 2·4^{−(n+2)} = 1/6`; empty interior by density of `ℚ` and
  `Denumerable.ofNat` surjective.
- `exists_isMUA_ae_le` (M): exhaustion by a measure-maximizing sequence (as `exists_isMaximalCover`; the implementer proves one from the other).
- `hc_irreg` (H): clause (1) from `hc_isRegularMUA`'s nullity-free children; `|E| > 0` by the bulge-crossing argument (`(s, t) ↦ (s + r, s − r)` a
  local diffeomorphism near `t = 0⁺`, density points of `Z × Z`, the arc-above-band inequality `t·d/r > d²/4`); (2) `E ⊆ K` closed nowhere
  dense (Baire on `(Z − ρ) ∪ (Z + ρ)`); (3) every completion irregular.

### 7.5 The count

`Plane/CoverExamples` now holds 23 `sorry` leaves (SQ9's and 22 new), and 5 theorems closed from leaves (`exists_r7`,
`not_forall_semiconcaveWith_one`, `disc7_sum_upperDensity`, `not_forall_isRegularMUA`, `not_forall_fix_converse`) plus `hcZ0_spec`.
`scripts/Axioms.lean`: 60 new records. `ARCHITECTURE.md`'s row rewritten (imports now `Plane/MaximalCover`, `Plane/Slack`, for `halfBox`);
`tools/check_architecture.py` PASS.

## Stage 8 — SAVED: inventory item 23 — FS106-COMP's ⟸ reads SUP's attainment; stated as carried content of SUPK's row

**Read**: `plans/FS106-derivation.md`'s FS106-COMP entry ("*Proof:* TQ §3.3 …; QB §2.7") and `plans/FS106-QB-verification.md` §§ 1.2, 2.3,
2.4, 2.6, 2.7 in full.

**The answer: yes.** QB § 2.7 (ii), verbatim: "If `µ₆(ε) = 1`, the attaining family covers the plane up to a null set, and I-D4's construction
(re-derived: §2.8, Lemma F with `r → 0`, i.e. `c(x) = min{j : x ∈ supp C_j}`) is proper at every pair at distance in `(1 − ε, 1 + ε)`, contradicting
V-1.1 at `ε/2`". That is COMP's second clause's ⟸ (`Voronov11 → ∀ ε > 0, µ₆(ε) < 1`, by contraposition), and "the attaining family" is SUP's
attainment clause ("attained (by a stationary family and by almost every sample of it)"), which FS129-SR2-SUPK's merged form does not claim.

**What exactly is read**: only the value `1`, in the a.e.-cover sense. Upper density `1` alone does not make the uncovered set null; the
stationary attaining family does (its mean coverage `P(0 covered) = 1` makes each sample's uncovered set null by Fubini). **That case needs no
stationarity**: QB § 2.4's compactness argument for (c) ⟹ (a), run on the band form, gives it at every `k` — choose translates whose hole in
`B(x_m, r_m)` is small, take a weak-* limit `F`, `ΣF = 1` a.e., the band form `∫_B F_j (F_j ∗ 1_{annulus})` is weak-* continuous because its
kernel is `L¹` (QB § 2.3's parenthesis: "no decay is needed" — no Rajchman step, no Krylov–Bogolyubov), and support selection gives a disjoint
band-null family covering a.e. [hand, one mind, this record].

**Stated**, as carried content of SUP's merged row, in `Plane/Slack` (a leaf, M):
`exists_bandNull_aeCover_of_mu_eq_one : 0 < ε → mu k ε = 1 → ∃ C, IsPartialColouring C ∧ (∀ j, BandNull (C j) ε) ∧ ∀ᵐ x, ∃ j, x ∈ C j`.
No statement already read back changes. **Messaged to Keryx** (a merged form that lost a needed clause).

**`forall_mu_six_lt_one_iff`'s leaf plan, corrected**: ⟸ by contraposition — `µ₆(ε) = 1` (it is `≤ 1`), `exists_bandNull_aeCover_of_mu_eq_one`,
then child `colouring_of_bandNull_aeCover` (D4: `c(x) = min{j : x ∈ supp C_j}` is defined everywhere — every point is in some class's support
since the union is co-null and there are finitely many classes — and proper at every pair in `(1 − ε, 1 + ε)`), which contradicts `Voronov11` at
`ε/2`. ⟹ by contraposition — a colouring `f` proper on `[1 − ε, 1 + ε]` (`Voronov11` quantifies over all colourings, measurable or not) is
pixelated by **cell corners** (cell `Q` gets `f` of its lower-left corner) into a measurable band-free family at `ε − 2√2h`, so
`µ₆(ε − 2√2h) = 1`. Price M (was H).

**The gate on stages 7–8**: `./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`): **OK** — 443 of 443 batches,
5 modules rebuilt (`Plane/Slack`, `Plane/YesLimit`, `Plane/CoverExamples`, `Proofs`), every warning `declaration uses 'sorry'`, 8 m 40 s
(`build/gate/build/20261004T062108Z-1588600.log`; its replay prefix lists the pre-edit line numbers too). `tools/check_architecture.py` PASS.

## Stage 9 — SAVED: the obligation-modeling pass over all 28 rows, and the re-pricing

*`debruijn-obligation-modeling`, invoked fresh, over the whole skeleton (71 leaves). It changed one statement, by ruling (9.1), and no other;
it adds named children (9.2), strengthens three inductions (9.3), corrects three leaf plans (9.4), and re-prices (9.5).*

### 9.1 A false clause found, and ruled: FS121-D4-FACE at `g > 2`

`face` as K2 stated it (V5-FACE-SHARP's `2g − g² ≤ ρ²` in place of the row's `0 < 2g < ρ²`) is **false for every `g > 2`**, where the
hypothesis holds for every `ρ`. Counterexample (`g = 3`, `ρ = ε′ = 1/10`, small `ε`, `r`, `y = x + e θ`): `A = halfBox x θ ε ∪
B(y + r e θ, r) ∪ farBox x θ 3 ε′ ρ` has no unit pairs at all (each piece has diameter `< 1`; across pieces the `e`-component of the difference
exceeds `1`), both boxes lie in `A`, and `y ∈ supp A` with `|x − y| = 1`. The row's own form had no such case: null unit pairs force `ρ ≤ 1/2`
(a box of half-width `ρ > 1/2` holds unit pairs), hence `g < 1/8`; the sharp form with `ρ ≤ 1/2` admits `g ≤ 1 − √3/2` or `g ≥ 1 + √3/2`.
**Ruling** (Keryx, `plans/FS131-close-inventory.md` item 37): `(hg1 : g < 1)` added to `face` and `face_densitySet` — the derivation's
regime (the far box between `x` and `x + e`, V5's `(1 − g)² + ρ² ≥ 1`). **Generalization to argue later, at its grade**: the clause at
`g < 2` [reading, one mind: the corner condition still makes the far box meet the unit circles about the points near `x + e`; killing test, a
counterexample with `1 + √3/2 ≤ g < 2`, `ρ ≤ 1/2`]. Not stated.

### 9.2 The obligation graph: shared children (the implementer states each once, in the module named)

| child | module | carries |
|---|---|---|
| `unitPairsNull_congr_ae` (K2) | `Plane/Cover` | SATC (iii), C-FILL, COV, R7's and DISC7's a.e. classes |
| `essSupport_eq_closure_densitySet` (K2) | `Plane/Cover` | FIX, COVER-SC, BAND (1), HC (`supp (int HC) = HC`) |
| `densitySet_of_open_ae_subset` (an open set a.e. inside `A` lies in `Ã`) | `Plane/Cover` | BAND (1), FACE, `face_densitySet` |
| **`exists_isMUA_ae_le`** (stated, a leaf) — the one exhaustion | `Plane/CoverExamples` (move to `Plane/MaximalCover` if wanted; a move, not a statement change) | `exists_isMaximalCover` = coordinatewise exhaustion of `c.cls j` + `isMaximalCover_iff` (now E, was M); IRREG's completion; GRUNDY's per-colour step |
| **`IsMUA.interior_union_unitShadow`** — SATC (ii) for one MUA set | `Plane/MaximalCover` | `IsMaximalCover.interior_union_unitShadow` (E via COV), FIX's `⊇`, BAND (1) |
| `isMUA_iff_ae_phi_pos` (wave 1, M2-ZERO) | `Plane/UnitAvoiding` | the maximality of DISC7, R7, HC (`φ > 0` a.e. off the class) |
| `dist_ne_one_of_mem_interior_densitySet` (wave 1, M2-INT) | `Plane/DensityPoints` | FIX's `⊆`, BAND (1), `component_side` |
| `upperDensity_le_one`, `antitone_mu` | `Plane/Suprema` | SUPK, `seven_le_chiM0_iff`, COMP |
| **`upperDensity_of_periodic`** (a set invariant under a lattice with bounded fundamental domain `D` has density `|S ∩ D|/|D|`) | `Plane/Suprema` | DISC7's density, Lemma P, `chiM0_le_iff_periodic`, YESLIM |
| **`gridCell_cross_dist`** (points of two cells of side `h` have distances within `2√2h` of each other's) | `Plane/Suprema` | Lemma T (pixelation by least index) and COMP's ⟹ (pixelation by cell corners) |
| **`exists_weakStar_window_limit`** (from families of density `≥ 1 − δ_m`, translates with small hole in `B(x_m, r_m)` and a weak-* limit `F`, `ΣF = 1` a.e.) | `Plane/Slack` | `chiM0_le_iff_muZero_eq_one` ⟸ and `exists_bandNull_aeCover_of_mu_eq_one` |
| `bandForm_continuous` (`∫_B f (f ∗ k)` weak-* continuous for `k ∈ L¹`) | `Plane/Slack` | the attainment lemma directly; with `σ ⋆ σ ∈ L¹` (from `twoCircle_preimage_null`) the Rajchman step |
| `twoCircle_preimage_null` (stated, K2) | `Plane/FalconerReduction` | `falconer_lemma1`, the Rajchman step |
| `colouring_of_bandNull_aeCover` (D4: `min{j : x ∈ supp C_j}`) | `Plane/Slack` | COMP's ⟸ |
| `hcBandTop_spec`, `hcUp_slivers`, `hc_unitAvoiding`, `hc_sausage_cover`, `hc_lemmaNL`, `hc_exclusion` (stated with `interior Z = ∅`, never `volume Z = 0`) and `hc_ae_phi_pos` (nullity) | `Plane/CoverExamples` | HC's two leaves and IRREG's clause (1) — the split is § 4.2 (1)'s "nullity entered only in the almost-everywhere step" |
| `r7_essClosure_classify`, `r7_arc_centre_colours` | `Plane/CoverExamples` | `r7Cls_saturated`, `r7_boundary`, `r7Cls_isMaximalCover` |

### 9.3 Inductions that need their statement strengthened (the IH, named before the first tactic)

- `exists_grundy`: induct on `m ≤ k` (ℕ, not `Fin`), the IH carrying the whole prefix — classes `A_0, …, A_{m−1}` with clauses (i)–(iv) for
  indices `< m` and `S_i ∖ ⋃_{i′<i} A_{i′} ⊆ A_i`; the colouring is read off at `m = k` (`x ↦ min {i : x ∈ A_i}`, defined since `S_{c x}` holds
  `x` unless an earlier class does — which also gives "never raising"). Clause (v) (bound at boundary points) is proved after the induction,
  from (iv) at contacts. Proving each `A_m` alone leaves the shadow clause's earlier classes outside the IH.
- `exists_placeHom`: induct on `n` **generalizing the base**: for any subfield `E₀ ⊆ ℝ`, subring `V₀ ⊆ E₀` holding both coordinates of every
  unit vector of `E₀²`, and `φ₀ : V₀ →+* 𝔽_q` extending reduction mod `𝔭`, and `t` transcendental over `E₀`, there are `V₁ ⊆ E₀(t)` and
  `φ₁` with the same properties extending `φ₀` (evaluation at `t = 0` on the `V₀`-regular functions; `zeroPlace`, `evalZero`). The base `V₀ =
  𝒪_{F,𝔭}` needs `mem_valuationSubring_of_sq_add_sq_eq_one` (`−1` is not a square mod a usable prime). Inducting on the theorem as stated
  gives an IH over `F` alone, which the step cannot use.
- `exists_isMUA_ae_le` (and through it SATC (i)): no induction — a measure-maximizing sequence `B_n` among admissible sets above `A`, the
  union of a countable cofinal subfamily; its "termination" is the monotone bound `volume (B ∩ ball 0 R) ≤ π R²` per radius, diagonalized.

### 9.4 Leaf plans corrected

- `forall_mu_six_lt_one_iff` (H → M): stage 8's route — ⟸ by `exists_bandNull_aeCover_of_mu_eq_one` and D4, ⟹ by corner pixelation.
- `IsMaximalCover.enclosing_or_exterior`: its `y` is unconstrained in the statement (as the row is worded); the proof produces a contact
  `y ∈ supp (C a)`, which `curvatureLeOne` reads. The implementer proves the stronger child `enclosing_or_exterior_contact` (with
  `y ∈ essSupport (C a)`) and derives the statement from it.
- `face`, `face_densitySet`: with `hg1`, K2's plan stands (the half-box alone excludes every unit-distance direction but `+e`, whose circle is
  tangent to the half-box's face; the far box's corner reaches the unit circles about the points near `x + e` exactly when
  `(1 − g)² + ρ² ≥ 1`). `face_densitySet` (E): `face` makes `x` no contact point, saturation then puts `x ∉ ∂_e`, and the half-box puts
  `x ∈ A*`, so `x ∈ Ã`.
- Closures available now from siblings (E, first after their parents): `muZero_eq_one_iff_tendsto` (`tendsto_mu`, uniqueness of limits on
  `𝓝[>] 0`), `seven_le_chiM0_iff` (`chiM0_le_iff_muZero_eq_one 6`, `tendsto_mu`, `antitone_mu`, `upperDensity_le_one`),
  `exists_tight_iff_chiM0_le` (`exists_tight`, `chiM0_le`, padding by `Fin.castLE`), `le_chiM_of_falconerFan` (fibres of a colouring are a
  cover), `sqrt3_dyadic` (`s = √3`), `forcedSet_eq_zero`, `IsMaximalCover.interior_union_unitShadow`, `exists_isMaximalCover`.

### 9.5 The re-pricing (71 leaves; to be re-priced again from the implementer's first two, per `CLAUDE.md` § What compute actually helps)

| price | leaves |
|---|---|
| **H** (13) | `twoCircle_preimage_null`; `chiM0_le_iff_muZero_eq_one` (window limit, Rajchman step, rounding); `tendsto_mu` (Lemmas P, T, kept points; `tendsto_muTile`, `tendsto_muPer` then M); `exists_grundy`; `falconer_reduction`; `exists_placeHom`; `sqrt3_local_of_congr`; `falconerFan_five_field`, `falconerFan_five_placeHom` (`decide +kernel` orbit facts, price from the first); `r7_aeColouring` (the finite case table); `r7Cls_saturated` (the classification); `hc_isRegularMUA`; `hc_irreg` |
| **M** (43) | `sq9_tight_saturated` and the rest of MaximalCover, Slack, FalconerReduction, Stationary, YesLimit, Arith; DISC7's four; `r7_boundary`, `r7Cls_isMaximalCover`, `r7_lowerGraph`; BAND (1), `vesica_apex`; `g1Bounds_hcGap`, `hc_band_components`, `fatZ_spec`, `exists_isMUA_ae_le`; the attainment lemma |
| **E** (15) | the eight closures of 9.4, `r7_not_bandNull`, `not_semiconcaveWith_one_lowerArc`, `band_excludes_horn`, `le_one_of_band_unitFree`, `vesica_apex_exact`, `noAffine_fields`' field cases once `noAffine` lands, `face_densitySet` |

**Sessions**: the 13 H leaves are each hours of agent work and mostly independent (the HC/IRREG pair and the R7 pair share children, the
Slack H leaves share the window limit and the two-circle lemma); the wave is three to five implementer sessions, or one per lane with two
implementers in parallel (lane P's examples are independent of lane P's analysis). W4 (not one session, 0.8) stands.

## Stage 10 — SAVED: where it is, and how the implementer works (stage 5 brought to all 28 rows)

**Branch `fs131-w2`** in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (`.lake/packages` symlinked, `.lake/build` its own copy — never
symlink it). Base: wave 1's skeleton `3358a401`; on top, K2's foundation (stage 2) and skeleton (stage 4), and this job's six rows, the
attainment lemma and the FACE ruling (stages 7–9). **All 28 rows are stated**, each read back (§ 4.1 for K2's 22, § 7.3 for the six) and
planned (§§ 4.2, 7.4, corrected by §§ 8 and 9).

**The leaves: 71** — `Plane/MaximalCover` 11, `Plane/Slack` 18, `Plane/Stationary` 3, `Plane/FalconerReduction` 4, `Plane/YesLimit` 2,
`Plane/CoverExamples` 23, `Arith/PlaceHom` 2, `Arith/FalconerField` 5, `Arith/Dyadic` 3 (lines that are exactly `sorry`). Theorems already
closed from leaves: `chiM0_le_iff_chiCP_le`, `chromaticNumber_plane_le_six_of_fragments`, `exists_r7`, `not_forall_semiconcaveWith_one`,
`disc7_sum_upperDensity`, `hcZ0_spec`, `not_forall_isRegularMUA`, `not_forall_fix_converse`. Objects and spec examples are sorry-free.

- **Builds**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`; up to two such builds across trees (ruling 5); exit 75 → wait ten minutes. `lake env lean -DautoImplicit=false
  <file>` for iteration only, never as evidence; an iteration `-o` olean must be deleted before the real build.
- **The implementer may** add children anywhere in the wave's modules and supporting lemmas in the foundation (`Plane/Cover`, `Plane/Suprema`,
  `Plane/CPColouring`), state the shared children of § 9.2 where named, move `exists_isMUA_ae_le` to `Plane/MaximalCover` (a move), change
  imports (updating `ARCHITECTURE.md`'s Imports cell), import library modules, and add `scripts/Axioms.lean` records for its children.
  **It may not** change any statement, add or drop a hypothesis, or change a definition's meaning (`r7Col`, `disc7`, `hcSet`, `G1Bounds`,
  `hcGap`, `fatZ`, the foundation's); a needed change comes back through Keryx as a ruling (as FACE's did). `Row130M1`, `hR78`, `hR88`,
  `hR88per` are named hypotheses from outside the backlog and stay hypotheses; `Voronov11` is a named proposition, never assumed.
- **Order** (the obligation graph, § 9.2): (1) the foundation's shared children and the one-MUA-set lemmas (`exists_isMUA_ae_le`,
  `IsMUA.interior_union_unitShadow`, `isMaximalCover_iff`), then MaximalCover (SATC, COV, FIX, C-FILL, COVER-SC, GRUNDY); (2) the examples, in
  parallel with (3): BAND (E–M first), DISC7, R7, then HC and IRREG through `hc_*` children; (3) Slack: RESCALE, `keptAt_band`, Lemmas P, T,
  SUPK, the window limit and the attainment lemma, COMP, `twoCircle_preimage_null` and the Rajchman step, EQ, REM, FACE (un-deferred by the
  ruling); then YesLimit, FalconerReduction, Stationary; (4) lane A (PlaceHom before FalconerField; Dyadic independent) in parallel with all of
  it. Wave 1's leaves cited by name (`isMUA_iff_ae_phi_pos`, `dist_ne_one_of_mem_interior_densitySet`, `hullset`, `ArcMap`, `noAffine`) land
  from `fs131-w1`: merge `main` into this branch when wave 1 lands, before the gate.
- **The gate for landing**: build with no warning; `scripts/axioms.sh` clean (every wave-2 record the standard three, no purchase, no axiom);
  `./scripts/vacuity.sh` and `--self-test` green with the counts reconciled — inhabitants: `sq9` (`AeColouring`, covers, partial colourings),
  `nonempty_cpColouring_nine`, `exists_isMaximalCover` (maximal covers; R7's and DISC7's classes too), `hcZ0_spec` (HC's hypotheses),
  `fatZ_spec` with `g1Bounds_hcGap` (IRREG's), DISC7's classes (`IsRegularMUA`); FALC-RES and HOSTS over a possibly empty domain read
  `GENERIC`/`UNKNOWN`, never `VACUITY DECLARED`; `tools/check_architecture.py` exit 0; then merge `main`, re-run, fast-forward.

**Build log of the handoff** (after the FACE ruling): `./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`): **OK** —
443 of 443 batches, 4 modules rebuilt (`Plane/Slack` and its dependents), 16 modules with warnings, every warning `declaration uses 'sorry'`
(wave 1's 28 and wave 2's), 8 m 42 s (`build/gate/build/20261004T063203Z-1649043.log`). `tools/check_architecture.py` PASS (stage 7).

## Stage 11 — SAVED: the readback (FS131-K2c)

*Job FS131-K2c, de Bruijn (Opus 5.5), launched 2026-10-04 to re-plan wave 2's remaining leaves (brief
`data/fs131/briefs/FS131-K2c-wave2-replan.md`, with `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building). Resuming per
standing rule 2: stages 1–10 are saved (K2, K2b); this job numbers its stages from 11 and redoes none. The implementers' record is
`plans/FS131-I2-implementation.md` (stages 1–6).*

### 11.1 The brief's quotation against its source (standing rule 3)

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "- `chiM0_le_chiCP` needs a jointly measurable modification of a process continuous in probability (dyadic approximation); `face` and `keptAt_band` are" | `plans/FS131-I2-implementation.md` § Stage 6 | exact (checked by script as a substring; it lies in the section headed "Stage 6 — SAVED (FS131-I2d)") |

No mismatch.

### 11.2 The 34 leaves at `3bd6cf52` (lines that are exactly `sorry`, by script)

| module | leaves |
|---|---|
| `Plane/MaximalCover` (1) | `AeColouring.exists_grundy` |
| `Plane/Slack` (12) | `AeColouring.exists_tight`, `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer`, `chiM0_le_chiCP`, `chiM0_le_iff_muZero_eq_one`, `exists_bandNull_aeCover_of_mu_eq_one`, `keptAt_band`, `CPColouring.tendsto_not_kept`, `exists_not_uniform_kept`, `face`, `exists_face_fails` |
| `Plane/FalconerReduction` (1) | `falconer_reduction` |
| `Plane/YesLimit` (1) | `chiM0_le_of_fragments` |
| `Plane/CoverExamples` (13) | `sq9_saturated_both`, `r7_aeColouring`, `r7Cls_saturated`, `r7_boundary`, `r7Cls_isMaximalCover`, `disc7_isMaximalCover`, `disc7_isRegularMUA`, `disc7_upperDensity`, `IsMUA.add_normal_mem_essSupport`, `g1Bounds_hcGap`, `hc_isRegularMUA`, `hc_band_components`, `hc_irreg` |
| `Arith/PlaceHom` (2) | `exists_placeHom`, `noAffine_fields` |
| `Arith/FalconerField` (2) | `falconerFan_five_field`, `falconerFan_five_placeHom` |
| `Arith/Dyadic` (2) | `sqrt3_local_of_congr`, `sqrt3_local` |

34, as the brief says. The statements are as read back in §§ 4.1 and 7.3 with the rulings of inventory items 18–19, 34, 37, 48, 56, 57,
63, 72 applied (the implementers' stages 2, 4–6 record each).

### 11.3 The worktree builds as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
2026-10-04: **OK** — all 1738 modules up to date, nothing built, 8 modules with warnings, every warning `declaration uses 'sorry'`
(`build/gate/build/20261004T091307Z-2395296.log`).

## Stage 12 — SAVED: the 34 leaves re-planned; children stated for 16 of them (FS131-K2c)

*No fresh modeling-skill pass was run (budget); the decomposition below is mine. Prices are for a Sonnet implementer, from the
implementers' measured rates (stages 3–6 of `plans/FS131-I2-implementation.md`: M leaves 40–70k, E 15–20k).* **✓** = stated in the
skeleton as a `sorry`ed child (this commit); **◇** = planned here, to be stated by the next planner or by the implementer as a child
(no statement change). A leaf still `sorry` is closed by the **assembly** named in its row, after its children.

### 12.1 Rulings and outside theorems

- **Ruling, inventory item 86** (Keryx, on this job's message): `exists_face_fails` gains `(hρ2 : 2 * ρ < 1) (hgρ : g ^ 2 + ρ ^ 2 < 1)`.
  As filed it was FALSE: at `g = 1, ρ = 9/10` the far box holds unit pairs; at `g = 19/20, ρ = 9/20` the half-box and far box together do
  (the unit circle about `x` crosses the far box at `s = 0.96`, `|t| = 0.28`). Applied in `Plane/Slack` with its docstring.
- **`[Falconer1981]` Lemma 2 (i) — imported as an axiom** (`Plane.falconer_lemma2_nonempty`): `falconer_reduction` needs a point of `E`
  (no class's density point), i.e. a nonempty metrical boundary; the paper defers the proof to Croft's Lemma 4 (its ref. [1], unheld), and I
  found no proof I could vouch for within this job (the obvious Baire argument separates `G_n` from `H_m` by `min(1/2n, 1/2m)` but does not
  close). Four items: (1) docstring names `[Falconer1981]` Lemma 2 (i), p. 185; (2) **read-back** — the paper (p. 185, verbatim): "Let S be a
  measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ\S) > 0 then (i) ∂S is non-empty", ∂S = "those points of Rⁿ at which the Lebesgue density of
  S either fails to exist, or exists and has a value other than 0 or 1", density with balls `B_δ(x)`, `δ → 0`; Lean (`n = 2`, `ℂ` with
  `volume`): `∃ x, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ` — `x ∉ densitySet S` is "the density of `S` fails to exist or is not `1`", and for
  measurable `S` the ratio of `Sᶜ` is `1` minus that of `S` (closed balls, a null sphere), so `x ∉ densitySet Sᶜ` is "fails to exist or is not
  `0`"; the hypotheses `volume S ≠ 0`, `volume Sᶜ ≠ 0` are the paper's. **Same.** (3) model `upperHalfPlane_falconer_hyp` (a leaf, E);
  (4) `ARCHITECTURE.md` § Trust, "Imported outside theorems". The classical statement is the connectedness of the density topology on
  `ℝⁿ` (Goffman–Neugebauer–Nishiura 1961, recalled, not read); a formalization job is owed before publication.
- **Formalized, not imported** (each under an hour or already in reach): Borel–Cantelli, Markov, Tonelli, polar coordinates, `L¹`
  translation continuity, Hilbert weak compactness (`WeakDual.isSeqCompact_closedBall`), the ergodic irrational rotation
  (`AddCircle.ergodic_add_left`), Kummer–Dedekind (Mathlib), the discriminant-in-conductor fact (Mathlib), lattice counting
  (`ZLattice.covolume.tendsto_card_div_pow`, to confirm at implementation). **The Rajchman step is formalized Fourier-free** by a route
  shorter than stage 3's: `‖T h‖₂² = ⟨h, h ⋆ ρ⟩` with `ρ` the two-circle density (`integral_circleAvg_sq`), so the convolution-form
  continuity for an `L¹` kernel (`convForm_tendsto`, no decay needed) gives `T g_m → T F` in `L²` directly — no mollifier, no compact
  operators.
- **Mathlib names confirmed with `#check` at the pin** (2026-10-04, scratch file, `lake env lean`): `MeasureTheory.measure_limsup_atTop_eq_zero`,
  `measurable_to_countable'`, `MeasureTheory.meas_ge_le_lintegral_div`, `MeasureTheory.lintegral_prod`, `MeasureTheory.lintegral_lintegral_swap`,
  `MeasureTheory.Measure.prod_apply`, `Besicovitch.ae_tendsto_measure_inter_div`, `Complex.lintegral_comp_polarCoord_symm`,
  `MeasureTheory.Lp.instContinuousVAddDomAddAct`, `MeasureTheory.MemLp.exists_hasCompactSupport_eLpNorm_sub_le`, `WeakDual.isSeqCompact_closedBall`,
  `Algebra.discr_mul_isIntegral_mem_adjoin`, `Ideal.eq_prime_pow_mul_coprime`, `Ideal.sum_ramification_inertia` (primed `ramificationIdx'`,
  `inertiaDeg'` at the pin), `KummerDedekind.normalizedFactors_ideal_map_eq_normalizedFactors_min_poly_mk_map`,
  `KummerDedekind.emultiplicity_factors_map_eq_emultiplicity` (its conductor hypothesis is `comap (conductor R x) ⊔ I = ⊤` — local at `I`),
  `conductor`, `Ideal.absNorm_eq_pow_inertiaDeg`, `IsDedekindDomain.exists_forall_sub_mem_ideal`, `UniformSpace.Completion.denseRange_coe`,
  `MeasureTheory.tendsto_lintegral_of_dominated_convergence`, `measurableSet_exists_tendsto`, `Filter.Eventually.exists`,
  `addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero`, `Polynomial.separable_def`, `GaloisField.card`,
  `FiniteField.forall_pow_eq_one_iff`; by grep: `AddCircle.ergodic_add_left` (`Mathlib/Dynamics/Ergodic/AddCircleAdd.lean`). Not found:
  `MeasureTheory.Memℒp.exists_hasCompactSupport_eLpNorm_sub_le` (renamed `MemLp`), `MeasureTheory.Measure.ae_neBot`, `Real.dense_irrational`.

### 12.2 The table (order: lane P analysis, lane P examples, lane A, each top to bottom)

| leaf | route | children | price |
|---|---|---|---|
| `exists_tight` | a* = inf of the radii `a ≤ 1` with every class's pairs null on `[a, 1]`; `a* > 0`; closed at `a*`; the pair mass vanishes at `a*` (continuity); rescale by `a*`; tight, since nullness on `[a*(1−ε), a*]` would lower `a*` | ✓ `IccPairNull` (def), `pairMass` (def), `IccPairNull.mono`, `.union`, `volume_prod_dist_eq_null`, `iccPairNull_of_forall_lt`, `unitPairsNull_iff_pairMass`, `continuous_pairMass`, `ae_pairMass_eq_zero`, `pairMass_eq_zero_of_iccPairNull`, `iccPairNull_preimage_mul`, `AeColouring.exists_rescale`, `AeColouring.exists_pos_not_iccPairNull` | children 5–40k each (`continuous_pairMass` 40k, `ae_pairMass_eq_zero` 40k, `exists_pos_not_iccPairNull` 30k); assembly 30k |
| `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` | squeeze: `µ^per ≤ µ^tile ≤ µ ≤ µ⁰` on `(0, 1)`, and every `d < µ⁰` eventually `≤ µ^per` | ✓ `bandNull_unitPairsNull`, `mu_le_muZero`, `muTile_le_mu`, `muPer_le_muTile`, `squareWin` (def), `exists_squareWin_dense`, `ae_eventually_keptAt`, `keptAt_of_dist_le`, `periodize` (def), `isPeriodicSet_periodize`, `measurableSet_periodize`, `isGridUnion_periodize`, `bandFree_periodize`, `disjoint_periodize`, `iUnion_periodize`, `upperDensity_of_periodic`, `upperDensity_periodize`, `exists_tiled_kept`, `eventually_le_muPer` | `upperDensity_of_periodic` 60k (split at implementation: counting translates inside/meeting a ball; the sandwich), `exists_squareWin_dense` 40k, `exists_tiled_kept` 35k, `eventually_le_muPer` 40k, the rest 5–25k; each squeeze 15k |
| `chiM0_le_chiCP` | per CP colouring: a jointly measurable modification; a.e. realisation a.e.-proper; one realisation | ✓ `CPColouring.law_ne_shift`, `.exists_unif`, `gridPoint` (def), `dist_gridPoint_lt`, `measurable_eval_gridPoint`, `CPColouring.exists_modification`, `.ae_unitPairsNull_of_modification` | `exists_modification` 40k, `ae_unitPairsNull_of_modification` 35k, the rest 10–20k; assembly 15k |
| `CPColouring.tendsto_not_kept` | Markov, simpler than TQ's step 4: `P(0 not kept at ρ) ≤ (1/η) sup_{‖y‖<ρ} P(f y ≠ f 0)`, with `|B ∖ Ã| = |B ∖ A|` | ✓ `CPColouring.lintegral_ball_ne`, `volume_densitySet_diff` (`Plane/Cover`), the modification above | 25k + assembly 30k |
| `chiM0_le_iff_muZero_eq_one` | ⟹ pad an `AeColouring m`, `m ≤ k` (the code in `exists_tight_iff_chiM0_le`), `one_le_muZero`; ⟸ translates with vanishing holes, a weak-* limit, `ΣF = 1`, the unit form of each `F_j` zero (Rajchman step), selection | ✓ `WeakStarTendsto` (def), `exists_weakStar_subseq`, `convForm_tendsto`, `exists_twoCircle_density`, `integral_circleAvg_sq`, `unitForm_tendsto`, `exists_translates_small_hole`, `ae_sum_eq_one_of_weakStar`, `exists_selection`, `unitPairsNull_preimage_add` | `exists_weakStar_subseq` 50k (split: Hilbert compactness in `L²(B(0,n))`; the diagonal), `integral_circleAvg_sq` 40k, `convForm_tendsto` 30k, `exists_twoCircle_density` 25k, `exists_translates_small_hole` 35k, the rest 10–20k; assembly 40k |
| `exists_bandNull_aeCover_of_mu_eq_one` | the same with the band kernel `1_{[1−ε,1+ε]}(‖w‖)` in `convForm_tendsto` (no Rajchman step) | ✓ shared above, `bandNull_preimage_add` | assembly 35k |
| `keptAt_band` | `ε ≤ 1/2`: TQ § 2.2 in one inequality; `ε > 1/2`: no point kept | ✓ `keptAt_band_le_half`, `not_keptAt_of_half_lt`; in `Plane/Cover`: `arcLength_ball_ge`, `arcLength_sub_ball_le`, `arcLength_bigBall_ge`, `pairs_le_of_arc`, `twoBall_pairs_ge` | arc lemmas 20–30k each, `twoBall_pairs_ge` 30k, the two cases 30k, 25k; assembly 5k |
| `exists_not_uniform_kept` | TQ's C2 simplified: the slack nine-colouring by squares of side `0.6` (same colour `> 1.2` apart, diameter `< 0.85`), with, in the annulus `j ≤ ‖z‖ < j + 1`, a fringe of width `w = 1/50` along every edge chequered into cells of side `1/j` between the two adjacent colours — proper at every unit pair (the margins `0.04 < 0.25`), and at scale `ε` the fringe points of an annulus with `1/j ≪ min(ε, w)` (any annulus if `ε ≥ w`) have own-colour density near `1/2`, so a translate of the unit square holds non-kept measure `≥ c·w` | ◇ the colouring by formula (a definition), its measurability and properness, the non-kept band per scale | 70k in three children |
| `face` | I2b's key lemma and the geometry | ✓ `not_unitPairsNull_of_circles_meet`, `isOpen_halfBox`, `isOpen_farBox`, `circles_meet_halfBox`, `circles_meet_boxes_at_normal` | key lemma 35k, the two geometry children 35k each, opens 5k; assembly 15k |
| `exists_face_fails` (item 86) | the class `H ∪ Fb ∪ Q` has no unit pair; `sq9` colours the rest | ✓ `faceFailClass` (def), `exists_faceFailClass_noUnitPairs`, `exists_aeColouring_of_noUnitPairs`, `measurableSet_faceFailClass`, `add_e_mem_essSupport_faceFailClass` | 40k (split by piece pairs at implementation), 20k, 5k, 10k; assembly 15k |
| `falconer_reduction` | MA1 § 2.2's order with Lemma 2 (i) imported | ✓ `falconer_lemma2_nonempty` (axiom), `upperHalfPlane_falconer_hyp`, `densitySet_dist_ne_one`, `exists_mem_falconerE`, `two_classes_of_mem_falconerE`, `dist_circle_rotate`, `not_rotate_ae_eq_compl`, `falconer_lemma4`, `fan_tip_ae_mem`; in `Plane/Cover`: `essClosure_subset_essSupport`, `essClosure_dist_ne_one_of_mem_densitySet`, `measurableSet_densitySet`, `exists_ne_mem_essClosure` | `fan_tip_ae_mem` 45k (disjointify, `falconer_lemma1`, D2, the density colouring, the fan), `not_rotate_ae_eq_compl` 35k, `measurableSet_densitySet` 30k, the rest 10–25k; assembly 15k |
| `chiM0_le_of_fragments` | **closed from its child** (`muZero_eq_one_of_fragments` and `chiM0_le_iff_muZero_eq_one`) | ✓ `ArcMap.measurableSet_region_inter`, `.volume_ball_diff_region`, `.bandFree_region`, `muZero_eq_one_of_fragments` | 25k, 35k, 5k, 35k |
| `exists_grundy` | structural recursion: `grundyTaken`, `grundyCls` (defs, sorry-free), colour = least index | ✓ `IsMaxIn` (def), `maxIn` (def), `exists_isMaxIn`, `isMaxIn_maxIn` (**proved**), `grundyS`, `grundyTaken`, `grundyCls` (defs), `grundyTaken_eq`, `grundyCls_isMaxIn`, `essSupport_subset_unitShadow_of_isMaxIn` | 30k, 15k, 25k, 35k; assembly 40k (clause (v) from the shadow clause at `x ∈ supp A_{j'}` via `essClosure_subset_essSupport`) |
| `sqrt3_local_of_congr`, `sqrt3_local` | the P-local engine `dyadicConclusion_of_coeffs`; the congruence is its case `d = 1`; the local square through `exists_span_four_eq`, `exists_sq_sub_three_mem_pow` at `N = a + 1`, `exists_dyadic_coeffs` | ✓ `x2x1_separable_irreducible_iff`, `card_quot_eq_two_pow`, `exists_span_four_eq`, `exists_sq_sub_three_mem_pow`, `exists_dyadic_coeffs`, `exists_root_quadratic`, `minpoly_eq_of_root`, `comap_conductor_sup_eq_top`, `dyadicConclusion_of_minpoly`, `dyadicConclusion_of_coeffs` | `dyadicConclusion_of_minpoly` 60k (explained: the Kummer–Dedekind API, split at implementation into the factor count with multiplicity and the inertia/card part), `comap_conductor_sup_eq_top` 40k, `exists_sq_sub_three_mem_pow` 40k, `exists_dyadic_coeffs` 35k, the rest 15–25k; assemblies 15k each |
| `exists_placeHom` | stage 9.3: induction on `n` generalizing the base; step `V₁ = {f ∈ zeroPlace E₀ : evalZero f ∈ V₀}` through `adjoinTranscendental`'s lift equivalence, `φ₁ = φ₀ ∘ evalZero`; unit vectors by `mem_valuationSubring_of_sq_add_sq_eq_one` twice; base `V₀` the `𝔭`-adic valuation subring of `F` (in `ℝ`) with its residue map (`FiniteField.isSquare_neg_one_iff` makes `1 + x²` a unit); the hom by `cosetResidue` as in `unitQuadrance_colorable_of_subring` | ◇ `placeHom_step`, `pureTranscendental_snoc` (with transcendence of the new variable), `placeHom_base` (valuation subring, residue map with `φ(a/s)s̄ = ā`, unit vectors), `exists_hom_of_isPlaceHom` | 40k, 30k, 3 × 30k, 30k; assembly 25k |
| `noAffine_fields` | `noAffine` with `ρ` into `T = Γ_q` (`exists_placeHom` restricted, `𝓞 F ⧸ 𝔭 ≃+* ZMod q`; slack: `finitePlane11_slack`, `finitePlane19_slack`, `Γ₇` by `circ7Table`) or `T = K_{k−1}` (when `χ(F²) ≤ k − 1`; `χ(E²) = χ(F²)` by `chromaticNumber_planeOver_adjoin_transcendental_eq` iterated) | ◇ `chromaticNumber_planeOver_pureTranscendental_eq`, `ringEquivZMod_of_card`, `slack_complete`, `slack_gamma7` | 25k, 10k, 10k, 20k; assembly 35k |
| `falconerFan_five_field`, `falconerFan_five_placeHom` | (i) a 3-colourable `H` has no fan at five (the colouring avoids two colours); an `𝔽₇` prime gives `ρ` into `Γ₇`, and for every `w` some 4-colouring of `Γ₇` with a colour `γ` absent from `N[0]` has `C(w) ≠ γ` (orbit fact), so the fan's tip, forced to `γ` (the other avoided colour unused), contradicts it; (ii) for every `w ≠ 0` in `𝔽_q²` (`q = 11, 19`) some 5-colouring with slack colour `γ` at `0` has `C(w) ∉ {γ, C(0)}` — so `h(b) = h(a)`; `b − a ∈ V²` by connectedness | ◇ `not_falconerFan_of_colorable`, `tip_mem_of_hom` (the fan through a hom), `gamma7_orbit`, `gamma11_orbit`, `gamma19_orbit` (`decide +kernel` over tables beside `Instances/FanGap11`, `FanGap19`, `PlaneFreedom`; price from the first), `sub_mem_of_connected` | 15k, 15k, 3 × 35k, 15k; assemblies 25k each |
| `sq9_saturated_both` | I2d's plan | ◇ `sq9_essClosure_subset` (closed squares of the class), `sq9_square_subset_densitySet`, `sq9_essBoundary_on_edge`, `sq9_partner` (the facing edge `x ± 1`, `x ± i`, same class, gap exactly `1`) | 25k, 10k, 15k, 20k; assembly 15k |
| `r7_aeColouring` | measurable; same-colour unit pairs only from points on the unit circles about lattice points (null) | ◇ `measurable_r7Col`, `r7Col_add_period` (period lattice `{m, n even, m ≡ n (3)}`), `r7_sameColour_unit_mem_sphere` (the finite case table on one period, split up–up / up–down / down–down), `unitPairsNull_of_first_mem_null`, `volume_iUnion_sphere_null` | 15k, 20k, 3 × 40k, 10k, 10k |
| `r7_boundary` | lattice points: only up colours have positive density there (cusps have density `0`), and each pair of the three has a centre at distance `1` (`λ₀ + 1`, `λ₀ + ω`, `λ₀ + ω − 1`); off the lattice: two supports meet only on an up/down arc, centred at a vertex `v` of the up tile, and the cusp of the down's colour at `v` is `D(m − 1, n − 1)` for the arc about `λ`, `D(m − 1, n + 1)` for the arc about `λ + ω` (checked here by hand: colours `m − n` and `m − n + 1` mod 3), and symmetrically | ◇ `r7_lattice_essClosure`, `r7_two_up_colours`, `r7_offLattice_arc` (local structure), `r7_arc_centre_colours`; ✓ `essClosure_subset_essSupport` | 30k, 15k, 40k, 25k; assembly 20k |
| `r7Cls_saturated` | `exists_ne_mem_essClosure` (✓, `Plane/Cover`), `r7_boundary`, `essSupport_eq_closure_densitySet` | — | assembly 15k |
| `r7Cls_isMaximalCover` | `isMaximalCover_iff`; each class MUA by `isMUA_iff_ae_phi_pos` | ◇ `r7_phi_pos` (for a.e. `p` off class `j` the unit circle about `p` crosses an open disc inside a tile of colour `j`; by periodicity on one period, finitely many explicit discs) | 60k (explained: a finite covering of one period by regions each with an explicit witness disc; split by colour type up/down at implementation); assembly 20k |
| `disc7_isMaximalCover` | admissible (null unit pairs: same-colour centres `≥ √21/2` apart), cover (covering radius `1/2`), each class MUA (colour covering radius `√7/2 < 3/2` and `phi > 0` on `1/2 < ‖p − c‖ < 3/2`) | ◇ `disc7Col_eq_dist_ge` (`triQ ≥ 7` on the index-7 sublattice), `disc7_dist_eq_one_mem_sphere`, `measurableSet_disc7`, `disc7_cover`, `disc7_colour_cover`, `phi_closedBall_pos` | 30k, 20k, 5k, 30k, 30k, 20k; assembly 25k |
| `disc7_isRegularMUA` | MUA as above; support = the set (locally finite union of closed discs); frontier in circles | ◇ `essSupport_disc7`, `volume_frontier_disc7` | 25k, 15k; assembly 10k |
| `disc7_upperDensity` | `upperDensity_of_periodic` (✓) for the colour lattice, covolume `21√3/8`, one disc `π/4` per cell | ◇ `disc7_periodic`, `volume_disc7_cell` | 15k, 30k; assembly 15k |
| `IsMUA.add_normal_mem_essSupport` | I2d's route (Stage 6 findings): `y_τ ∈ supp A` at distance `1` from `m + τe`, a limit `y*`, the circle about `y*` meets the open half-box unless `y* = m + e θ` | ◇ `exists_shadow_point` (via `IsMUA.interior_union_unitShadow`), `circle_meets_halfBox_of_ne` (the three cases), `subset_densitySet_of_isOpen_ae_subset` (exists) | 35k, 40k; assembly 30k |
| `g1Bounds_hcGap` | stage 7.4 | ◇ `hcGap_gap_formula`, `hcGap_deriv` (`g′ = 0` on `Z` by `g ≤ dist²/4`), `hcGap_lowerParabola` | 3 × 30k |
| `hc_isRegularMUA`, `hc_band_components`, `hc_irreg` | stage 7.4 and 9.2's named children | ◇ `hcBandTop_spec`, `hcUp_slivers`, `hc_unitAvoiding`, `hc_sausage_cover`, `hc_lemmaNL`, `hc_exclusion`, `hc_ae_phi_pos`; for IRREG the bulge-crossing `|E| > 0` and Baire on `(Z − ρ) ∪ (Z + ρ)` | **not decomposed further here**: the statements need `plans/FS111-M3-finiteness.md` §§ 2.2–2.4 read line by line; a planning stage of its own (estimate 8–10 children of 30–40k each for HC, 4 for IRREG) |

**Count.** 94 new theorems, each recorded in `scripts/Axioms.lean` (block "FS131-K2c", before `=== PURCHASED ===`); two are proved
(`isMaxIn_maxIn`, `bandNull_iff_iccPairNull`), 92 are `sorry`ed children. New definitions, sorry-free: `IccPairNull`, `pairMass`,
`squareWin`, `periodize`, `gridPoint`, `WeakStarTendsto`, `faceFailClass` (`Plane/Slack`); `IsMaxIn`, `maxIn`, `grundyS`, `grundyTaken`,
`grundyCls` (`Plane/MaximalCover`). One axiom (`falconer_lemma2_nonempty`). `KeptAt`, `halfBox`, `farBox` moved up in `Plane/Slack` (moves,
no change). One leaf closed from its child (`chiM0_le_of_fragments`); 33 of the 34 leaves remain `sorry`, each an assembly of its row.

## Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

**Branch `fs131-w2`** in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (`.lake/packages` symlinked, `.lake/build` its own copy —
never symlink it). On top of stage 10's state and the implementers' stages 1–6: this job's children (§ 12) and ruling 86.

- **Builds**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`; up to two such builds across trees (ruling 5); exit 75 → wait ten minutes. `lake env lean
  -DautoImplicit=false <file>` for iteration only, never as evidence.
- **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
  state the ◇ children of § 12.2 where named; move declarations within a module (as `KeptAt`, `halfBox`, `farBox` were moved); add imports
  (updating `ARCHITECTURE.md`'s Imports cell); add supporting definitions (the zigzag/fringe colouring of `exists_not_uniform_kept`).
  **May not**: change any row statement, hypothesis or definition's meaning (including this job's new definitions and children's
  statements — a child found false comes back through Keryx, as a missing lemma or a statement defect; it is not silently re-stated);
  add an `axiom` or `native_decide`. `falconer_lemma2_nonempty` is the one declared import; `Row130M1`, `hR78`, `hR88`, `hR88per` stay
  hypotheses; `Voronov11` is a named proposition, never assumed.
- **Order** (by what unblocks most): (1) `Plane/Cover`'s shared children (`essClosure_subset_essSupport`, `volume_densitySet_diff`, the arc
  lemmas, `pairs_le_of_arc`, `twoBall_pairs_ge`, `essClosure_dist_ne_one_of_mem_densitySet`, `measurableSet_densitySet`,
  `exists_ne_mem_essClosure`); (2) `Plane/Slack` in its order: radius bands and pair mass → `exists_tight`; SUPK's children →
  `eventually_le_muPer` → the three limits; `keptAt_band`; the modification → `chiM0_le_chiCP`, `tendsto_not_kept`; the compactness
  children → `exists_bandNull_aeCover_of_mu_eq_one`, then `chiM0_le_iff_muZero_eq_one` (its ⟸ also carries `chiM0_le_iff_periodic` and,
  through `muZero_eq_one_of_fragments`, YESLIM); `face`, `exists_face_fails`; (3) `exists_grundy`; `falconer_reduction`; the Dyadic engine;
  (4) the ◇ rows: lane A (PlaceHom before FalconerField), then CoverExamples (sq9, DISC7, BAND, R7), HC/IRREG after a planning stage.
  Price the run from the first two children, not from this table.
- **The landing** (stage 10's gate, amended): build with no warning; `scripts/axioms.sh` clean — every wave-2 record the standard three,
  except `falconer_reduction` and `le_chiM_of_falconerFan`, which carry `falconer_lemma2_nonempty` as a declared import (its row in
  `ARCHITECTURE.md` § Trust; `scripts/axioms.sh` must be taught the name — a change Keryx owns, `LEAN.md` § Trust ledger); `./scripts/vacuity.sh`
  and `--self-test` green with the counts reconciled (inhabitants as stage 10; `upperHalfPlane_falconer_hyp` models the import);
  `tools/check_architecture.py` exit 0; then merge `main`, re-run, fast-forward.

## Stage 14 — SAVED: the readback (FS131-K2d)

*Job FS131-K2d, de Bruijn (Opus 5.5), launched 2026-10-04 to state the children of wave 2's last 18 leaves (brief
`data/fs131/briefs/FS131-K2d-wave2-children.md`, with `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building), in the worktree
`.claude/worktrees/fs131-w2d` (branch `fs131-w2d`, from `fs131-w2` at `29082313`). Resuming per standing rule 2: stages 1–13 are saved
(K2, K2b, K2c); this job numbers its stages from 14 and redoes none. Theorems this job proves are listed under "Theorems this phase proved"
at the end of its last stage.*

### 14.1 The brief's quotations against their sources (standing rule 3)

Checked by script (each `>` block, minus its `— source:` line, as an exact substring of the file the source names):

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "RESULT: GAP at a planning step — 18 leaves (lane A's 4, CoverExamples' 13, exists_not_uniform_kept) …" | `.claude/worktrees/fs131-w2/data/fs131/reports/FS131-K2c.md` | exact |
| 2 | "\| `hc_isRegularMUA`, `hc_band_components`, `hc_irreg` \| stage 7.4 and 9.2's named children \| ◇ …" | this record § 12.2 | exact |
| 3 | "- **May**: prove any child or leaf; add further children …" | this record § 13 | exact |

**One finding about the brief**: its list of the leaves in `Plane/CoverExamples` names 14 declarations, `fatZ_spec` among them, but
`fatZ_spec` is **proved** at `29082313` (sorry-free since K2b's commit `344a9081` stated and proved it; it has no `sorry` line). The leaves
in the three files are 13 + 2 + 2 = **17**, as the brief's own count says, and 18 with `exists_not_uniform_kept`. Nothing to do.

### 14.2 The 18 leaves at `29082313` (lines that are exactly `sorry`, by script) with their ◇ children (§ 12.2, names verbatim)

| module | leaf | ◇ children named by K2c |
|---|---|---|
| `Plane/CoverExamples` | `sq9_saturated_both` | `sq9_essClosure_subset`, `sq9_square_subset_densitySet`, `sq9_essBoundary_on_edge`, `sq9_partner` |
| | `r7_aeColouring` | `measurable_r7Col`, `r7Col_add_period`, `r7_sameColour_unit_mem_sphere`, `unitPairsNull_of_first_mem_null`, `volume_iUnion_sphere_null` |
| | `r7Cls_saturated` | — (assembly from `exists_ne_mem_essClosure`, `r7_boundary`, `essSupport_eq_closure_densitySet`) |
| | `r7_boundary` | `r7_lattice_essClosure`, `r7_two_up_colours`, `r7_offLattice_arc`, `r7_arc_centre_colours` (✓ `essClosure_subset_essSupport`) |
| | `r7Cls_isMaximalCover` | `r7_phi_pos` |
| | `disc7_isMaximalCover` | `disc7Col_eq_dist_ge`, `disc7_dist_eq_one_mem_sphere`, `measurableSet_disc7`, `disc7_cover`, `disc7_colour_cover`, `phi_closedBall_pos` |
| | `disc7_isRegularMUA` | `essSupport_disc7`, `volume_frontier_disc7` |
| | `disc7_upperDensity` | `disc7_periodic`, `volume_disc7_cell` |
| | `IsMUA.add_normal_mem_essSupport` | `exists_shadow_point`, `circle_meets_halfBox_of_ne` (with `IsMUA.interior_union_unitShadow`, `subset_densitySet_of_isOpen_ae_subset`, both held) |
| | `g1Bounds_hcGap` | `hcGap_gap_formula`, `hcGap_deriv`, `hcGap_lowerParabola` |
| | `hc_isRegularMUA`, `hc_band_components`, `hc_irreg` | `hcBandTop_spec`, `hcUp_slivers`, `hc_unitAvoiding`, `hc_sausage_cover`, `hc_lemmaNL`, `hc_exclusion`, `hc_ae_phi_pos`; for IRREG the bulge-crossing `\|E\| > 0` and Baire on `(Z − ρ) ∪ (Z + ρ)` |
| `Arith/PlaceHom` | `exists_placeHom` | `placeHom_step`, `pureTranscendental_snoc`, `placeHom_base`, `exists_hom_of_isPlaceHom` |
| | `noAffine_fields` | `chromaticNumber_planeOver_pureTranscendental_eq`, `ringEquivZMod_of_card`, `slack_complete`, `slack_gamma7` |
| `Arith/FalconerField` | `falconerFan_five_field`, `falconerFan_five_placeHom` | `not_falconerFan_of_colorable`, `tip_mem_of_hom`, `gamma7_orbit`, `gamma11_orbit`, `gamma19_orbit`, `sub_mem_of_connected` |
| `Plane/Slack` (FS131-I2e's) | `exists_not_uniform_kept` | ◇ "the colouring by formula (a definition), its measurability and properness, the non-kept band per scale" (no names) |

### 14.3 The worktree builds as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
2026-10-04: **OK** — 443 of 443 batches, 3 modules rebuilt, 9 modules with warnings, 8 m 54 s (`build/gate/build/20261004T104203Z-2786032.log`).
Every warning is `declaration uses 'sorry'` except two deprecations in FS131-I2e's `Plane/MaximalCover` (`Set.diff_subset` at lines 821
and 846; for the implementer, not this job).

## Stage 15 — SAVED: lane A's children stated; the orbit and slack facts proved (FS131-K2d)

*No fresh modeling-skill pass (budget); the decomposition is mine. Prices are harness tokens at the Sonnet implementers' measured rates
(§ 12's basis); the next implementer (Opus, a trial) re-prices from its first two children. Mathlib names confirmed with `#check` at the
pin (2026-10-04, `lake env lean`): `FiniteField.isSquare_neg_one_iff`, `SimpleGraph.induceHomOfLE`, `SimpleGraph.Colorable.of_hom`,
`SimpleGraph.chromaticNumber_le_iff_colorable`, `ZMod.ringEquivOfPrime` (needs `Fintype`, from `Nat.finite_of_card_ne_zero`),
`IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`, `ValuationRing.iff_isInteger_or_isInteger`,
`IsLocalization.AtPrime.equivQuotMaximalIdeal`, `IntermediateField.transcendental_adjoin_iff`, `AlgebraicIndependent.transcendental_adjoin`,
`Fin.init`, `finsum_eq_sum_of_fintype`, `ValuationSubring.valuation_le_one_iff`; repository: `mem_valuationSubring_of_sq_add_sq_eq_one`,
`zeroPlace`, `evalZero`, `adjoinTranscendentalEquiv` (namespace `HadwigerNelson.RouteC`, now opened in `Arith/PlaceHom`), `cosetResidue`,
`noAffine`, `falconerFan_hom`, `FanGap.translate`, `slack_addCayley_of_fanGap`, `rotHom`, `unitQuadrance.map`.*

### 15.1 Departures from K2c's table (§ 12.2), and why

- **No orbit fact at `7`.** FALC-FAN (B)'s last clause already says every 4-colouring of the target leaves no colour absent from the
  tip image's closed neighbourhood; a target slack at four colours contradicts it outright. So clause (i)'s `𝔽₇` half needs only
  `finitePlane7_slack` (the periodic colouring `circ7Table ∘ projAlong (1, 2)` has colour `3` absent from `N[(0, 2)]`), not `gamma7_orbit`.
- **The orbit facts at `11` and `19` need no new table and no search.** The colourings already in the kernel with a gap
  (`finitePlane11_fanGap`, `finitePlane19_fanGap`), rotated about the gapped vertex, cover every `w ≠ 0`: checked first in Python
  (`tools/fs131_k2d_orbit.py`, exit 0; plants `gap` and `table` each fire, exit 1) and then **proved** by `decide +kernel` in 2.3 s
  (`q = 11`, 120 × 12) and 3.7 s (`q = 19`, 360 × 20), 3.1–3.5 GB. Negative control: the same statement without `w ≠ 0` is refuted by
  `decide` (watched). A first plant (gap colour `2` replaced by `0`) did **not** fire — that statement is also true; logged, replaced.
- **Clause (ii) needs no cosets**: `v ↦ (φ (v − a).re, φ (v − a).im)` is defined on the whole connected graph (every `v − a` has
  coordinates in `V`, `sub_mem_of_connected`), and sends the apex to `0`; it is transported to `UD(𝔽_q, 2)` by `unitQuadrance.map` of the
  ring isomorphism, where `tip_eq_zero_of_tipFree` lands the tip. K2c's `tip_mem_of_hom` is this pair of children.
- **NOAFF's targets in one child** (`exists_hom_slack`) with K2c's `slack_gamma7` proved as `finitePlane7_slack`.

### 15.2 What is stated (✓ = proved in this job, sorry-free)

New module **`Instances/FalconerOrbit`** (all ✓): `finitePlane7QuotColouring`, `finitePlane7QuotColouring_proper`, `finitePlane7QuotColoring`,
`finitePlane7_fanGap`, `finitePlane7_not_fanGap_zero` (red control), `finitePlane7_slack`, `gamma11_orbit`, `gamma19_orbit`, `tipFree_of_orbit`,
`finitePlane11_tipFree`, `finitePlane19_tipFree`.

`Arith/PlaceHom` — `exists_placeHom` **closed from** `exists_isPlaceHom` (✓, induction, closed from its children) and `exists_hom_of_isPlaceHom`;
`noAffine_fields` **closed from** `exists_hom_slack` and `forall_const_of_hom_slack`:

| child | route | price |
|---|---|---|
| `pureTranscendental_zero` | `Subfield.closure (F ∪ ∅) = F` (`Subfield.closure_eq`) | 5k |
| `pureTranscendental_succ` | `Subfield.closure_union`, `IntermediateField.adjoin_toSubfield`/`closure` of `F(t_init) ∪ {t_last}`; `Fin.range` split by `Fin.lastCases` | 20k |
| `algebraicIndependent_init_and_transcendental_last` | `AlgebraicIndependent.comp` with `Fin.castSucc_injective`; `transcendental_adjoin` at `s = range castSucc`, `i = last`, then `IntermediateField.transcendental_adjoin_iff` and the identification of `IntermediateField.adjoin F (range (init t))` with `pureTranscendental F (init t)` | 35k |
| `exists_valuationSubring_localization` | `B` := the image of `Localization.AtPrime 𝔭` in `F`; DVR (`isDiscreteValuationRing_of_dedekind_domain`, `𝔭 ≠ ⊥` since maximal in a domain that is not a field) ⟹ `ValuationRing` ⟹ `iff_isInteger_or_isInteger` | 35k |
| `exists_residue_localization` | `r (a/s) = ā · s̄⁻¹` well defined by cross-multiplication (`𝔭` maximal: the quotient is a field); ring hom; `r x ≠ 0` ⟹ `x = a/s` with `a ∉ 𝔭` ⟹ `x⁻¹ = s/a ∈ B` ⟹ unit | 30k |
| `placeHom_base` | `V` := `B` carried into `ℝ` by `F.subtype`; unit vectors by `mem_valuationSubring_of_sq_add_sq_eq_one` with `hB` from `FiniteField.isSquare_neg_one_iff` (`r (1 + x²) = 1 + (r x)² ≠ 0`); the third clause from `exists_residue_localization` | 30k |
| `placeHom_step` | `V₁ = {f ∈ E₀(s) : lift f ∈ zeroPlace E₀ ∧ ↑(evalZero (lift f)) ∈ V₀}`, `lift = adjoinTranscendentalEquiv`; `φ₁ = φ₀ ∘ evalZero`; unit vectors of `E₀(s)²` in `zeroPlace` (`mem_valuationSubring_of_sq_add_sq_eq_one`, residue `E₀ ⊆ ℝ`, `one_add_sq_ne_zero_of_subfield`), their values unit vectors of `E₀²`; constants evaluate to themselves | 40k |
| `exists_hom_of_isPlaceHom` | `unitQuadrance_colorable_of_subring`'s coset step with `planeOverIso`: `ψ = (φ, φ)` on `V × V`, `h = cosetResidue ψ`; adjacency from `cosetResidue_sub` | 30k |
| `chromaticNumber_planeOver_pureTranscendental_eq` | induction on `n` exactly as `exists_isPlaceHom`, with `chromaticNumber_planeOver_adjoin_transcendental_eq` | 15k |
| `nonempty_ringEquiv_zmod_of_card` | `Fintype.ofFinite`, `Nat.card_eq_fintype_card`, `(ZMod.ringEquivOfPrime R hp _).symm` | 10k |
| `exists_hom_finitePlane_of_card` | `exists_placeHom`'s `h` composed with `unitQuadrance.map e.toRingHom` | 15k |
| `slack_complete` | the colouring `Fin.castSucc` of `⊤`, gap colour `Fin.last k` | 10k |
| `exists_hom_slack` | four cases: `11`, `19` (`exists_hom_finitePlane_of_card`, `finitePlane11_slack`, `finitePlane19_slack`), `7` (`finitePlane7_slack`), `χ(F²) ≤ k − 1` (`chromaticNumber_planeOver_pureTranscendental_eq`, `chromaticNumber_le_iff_colorable`: a colouring is a hom to `⊤`; `slack_complete (k − 1)`) | 30k |
| `forall_const_of_hom_slack` | `noAffine hk ρ φ (Set.toFinite _) b` with `finsum_eq_sum_of_fintype`; its second clause at `Slack` | 15k |

`Arith/FalconerField` — **both leaves closed from their children** (clause (i): `not_falconerFan_of_colorable` with
`chromaticNumber_planeOver_pureTranscendental_eq`; the `𝔽₇` half by `exists_hom_finitePlane_of_card` and `not_falconerFan_five_of_hom_slack`;
clause (ii): `sub_mem_of_connected`, `exists_hom_apex`, `nonempty_ringEquiv_zmod_of_card`, `tip_eq_zero_of_tipFree`, the tip-free facts):

| child | route | price |
|---|---|---|
| `not_falconerFan_of_colorable` | restrict a `(k − 2)`-colouring to `H − a` (values `Fin.castLE`), `c₁ = k − 2`, `c₂ = k − 1` absent everywhere | 15k |
| `sub_mem_of_connected` | walk induction, as in `falconerFan_five_mem_P` (each step adds a unit vector with coordinates in `E`) | 15k |
| `exists_hom_apex` | `toFun v = (φ ⟨_, (sub_mem…).1⟩, φ ⟨_, (sub_mem…).2⟩)`; adjacency: the difference of images is `(φ, φ)` of the unit vector `u − v` (`map_sub`), whose image is on the circle (`map_pow`, `map_add`, `map_one`) and nonzero in a nontrivial ring | 25k |
| `tip_eq_zero_of_tipFree` | by contradiction with `falconerFan_hom (by norm_num) hfan ρ` (A) at `C, γ` from `hfree (ρ t)` (the gap `FanGap C 0 γ` is (A)'s hypothesis at `ρ a = 0`) | 15k |
| `not_falconerFan_five_of_hom_slack` | `hT (ρ t)` gives `C, γ` with a gap at `ρ t`; (B)'s last clause at `δ = γ` gives a neighbour coloured `γ` | 10k |

**Generalizations** (for Keryx; neither narrows a row): FALC-RES clause (i) does not read connectedness (`have _ := hconn` keeps the row's
hypothesis and the linter silent); clause (ii) does not read the transcendence of `t` — it holds over any subfield carrying a place-hom pair
(`have _ := ht`). Both are visible in the assemblies.

**Count**: 29 new theorems (11 ✓ in `Instances/FalconerOrbit`, `exists_isPlaceHom` ✓ from children; 17 `sorry`ed children), 2 new
definitions (✓); 4 leaves closed from children (`exists_placeHom`, `noAffine_fields`, `falconerFan_five_field`, `falconerFan_five_placeHom`).
Records: `scripts/Axioms.lean` block "FS131-K2d" (`tools/fs131_k2d_records.py` exit 0; its plant, one record hidden, exit 1).
`Proofs.lean`, `ARCHITECTURE.md` (the new row, two Imports cells, § 3.10's theory-imports-instance line): `tools/check_architecture.py` PASS.
Elaboration: each file by `lake env lean -DautoImplicit=false` against a scratch olean of `Instances/FalconerOrbit` (iteration only; the
build at the end of this job is the evidence).
