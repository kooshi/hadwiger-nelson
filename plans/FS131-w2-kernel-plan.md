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
