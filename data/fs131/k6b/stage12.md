
## Stage 12 — SAVED: the hand-off, the builds, what a third pass takes, the expectations scored

### 12.1 For implementers: the split by file (statements fixed; children under names of their own)

Thirty `sorry` leaves on the branch. No two of these files' leaves depend on each other's *proofs*, only on statements, so all four lines can
run at once on branches cut from this stage's commit (`fs131-w6p` and `fs131-w6m`, cut at stage 9, hold the first two already).

| line | file | leaves | imports it needs proved | plan |
|---|---|---|---|---|
| P | `Plane/Saturated/Pinch` | 7 | — | § 5, § 9.4 |
| M | `Plane/Saturated/MapColouring` | 1 (`sat_inP`), with `sq9` as an `ArcMap 9` (§ 7.1) | — | § 5 |
| C | `Plane/Saturated/Curve`, then `LocalGraph` | 6 + 5 | `c11_discs`, `TwoColourOn.essBoundary_inter_eq` as statements | § 11.4 |
| F | `Plane/Saturated/FanBridge` (and `sq9.SingLocallyFinite` in `FanExamples`, § 10.3) | 12 | `LocalGraph`'s and `Curve`'s statements | § 11.4 |

Line F is the largest and may be two implementers: one on `gamma`, `exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, the CLAUSE2 pair;
one on the `Fan` lemmas (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone`), which take `gamma` and `beta` as
statements. Build and iteration as § 7.1. Each leaf proved gets its `#print axioms` line in `scripts/Axioms.lean`'s block "FS131-K6b".

### 12.2 Vacuity and inhabitants (`LEAN.md` § The gate's form)

- `pinch`, `c11_discs`, `c11_split`, `TwoColourOn.essBoundary_inter_eq`, `pinch_interface`, `c11_discs_interface`: `sq9` at `sqEdgePt`
  (`sq9_twoColourNhd`, `sqEdgePt_mem_ball`, `sq9_tight_saturated`; the contacts by `sq9_isTangentAt`, a leaf). `pinch_not_in_in` concludes `False`;
  its docstring names the model of the other hypotheses.
- `IsUnitCurve`'s theorems: `isUnitCurve_segment`. The unit circle (`γ s = e s`, `ψ s = s + π/2`), where `chord`, `sin_le_inner` and
  `one_le_dist` are equalities, is owed as the sharpness example with `chord`'s proof.
- `local_graph`: `sq9` at `sqEdgePt`, `N = U = B(sqEdgePt, 1/8)`; **owed**: no cusp of the two classes in that ball (the docstring says so).
- `gamma`, `beta`, `alpha`, and every theorem over `IsolatedAt`: `sq9_isolatedAt`. `fan_of_isolated`: the same. `regJFan_of_saturated`,
  `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`: `sq9` once `sq9.SingLocallyFinite` is proved (owed, § 10.3) — until then the note
  names `sq9` for `Saturated` only.
- `Fan.two_le_n`: `sq9Fan` with `sqVertex_mem_singularSet`. `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`,
  `Fan.sector_alone`, `Fan.sector_unique`: `sq9Fan` with `sq9_tight_saturated.2.1.saturatedOn _`. In `sq9Fan` no colour repeats, so
  `sector_alone`'s `hcol` holds only at `i = i'`; an object with a repeated colour on two regions that satisfies everything but the conclusion
  is what the theorem refutes (V2 § 2.4: none exists under saturation).
- No theorem of this pass quantifies over a class that no held object inhabits. The first pass's § 2 list of uninhabited classes (D2-EXT,
  D2-THIN, D1-PENCILWIN, V5-RAY, D4-HOLE, O1-OUT's curved case) is the third pass's.

### 12.3 The builds

- As given: § 8.3. The foundation: § 9.3.
- With `Fan` and `FanExamples`: BUILD3
- With `Curve`, `LocalGraph`, `FanBridge`: BUILD4
- `./scripts/dupnames.sh`: DUPNAMES. `tools/check_architecture.py`: PASS (five rows added to § 3.11). No `axiom`, no `native_decide`. The gate
  (axioms, vacuity, linters) is not a planning job's and was not run.

### 12.4 What a third planning pass takes, exactly

**Not stated by this pass, with what was and was not read:**
- **The ladder, 14 of its 17 rows**: FS121-D2-EXT, -D2-THIN, -D2-SYM, -D2-PERFIN, -O1-ENDS, -O1-OUT, -DB1-L6, -DB1-L7, -D1-EROSION, -V5-RAY,
  -D4-HOLE, -V3-CPI, -V2-VT-W with FS121-D1-VT (under its own name, ruling 487 (a)), -D1-PENCILWIN; and FS121-V5-LOC's clause (iii).
  Stated here: FS121-DB1-L3 (`Fan.sector_unique`), FS121-V2-SECTOR (`Fan.sector_alone`), FS121-V5-LOC (i), (ii).
- **The fragment's six**: FS116-O1-SATPIN, -N1-AXIS, -S1-RUNG, -V4-PARTNER, -S1-KAPPA, -S1-PAIR (the last two at `ArcMap 6`, ruling 487 (e)).
  The foundation is ready for them: SATPIN reads `pinch` and `local_graph` for the family `F.region` on an open `N` inside the fragment's
  disc, with `SaturatedOn F.region (ball p ρ)` — "the inner-disc reading" is that predicate; whether SATPIN's statement lacks a hypothesis
  (X5 (d)) is still open, its argument unread.
- **FS111-M2-HULLC** (on a cover `disj` can fail: read `plans/FS111-M2-regularity.md` § 2.2 first; ruling 487 (b)), **FS111-W-KB-DIR** (a fan
  at the centre of a split arc: `Fan.branch_contacts`' first case is its setting), **FS111-M2-INTRAD**.
- **Arguments not read by either pass**: `plans/FS121-DB1-verification.md` §§ 2.3, 2.5; `FS121-V2-verification.md` §§ 2.5–2.9;
  `FS121-V3-verification.md` § 2.3; `FS121-D1-proof.md` §§ 2.1–3.1; `FS121-D2-proof.md` § 2; `FS121-V5-verification.md` § 3.1;
  `FS121-D4-proof.md` § 2.3; `FS121-C1-proof.md` § 2.3; `FS121-map-step.md` §§ 3.2–3.3; `plans/FS111-M2-regularity.md` §§ 2.2, 4.1;
  `plans/FS111-W-wild.md` (W-NOBEND, W-KB-DIR); the six FS-116 entries' arguments. Read by this pass: `FS121-V2-verification.md` §§ 1.4–2.4.
- **Unresolved expectations**: X5 (b) (ENDS's "null set of normals" against L6's "finitely many"), (d), (e).
- **What the third pass can lean on**: rows over a fan at one point take `(F : c.Fan z) (hsat : SaturatedOn c.cls (ball z F.r \ {z}))`
  and read a branch through `F.tendsto`, `Fan.branch_outside_discs`, `Fan.branch_contacts`; rows over `RegJFan` take `c.RegJFan` (or
  `Saturated c.cls` and `c.SingLocallyFinite`, by `regJFan_of_saturated`) and "finitely many arcs in a bounded set" from
  `finite_arcs_of_isBounded`; curves are `IsUnitCurve`s (a circular arc of radius `n` about `w`: `γ s = w + n e(θ₀ + s/n)`,
  `ψ s = θ₀ + s/n + π/2`), with the pointwise type from `IsInterfaceChart.discs` and `IsTangentAt`. The deriver's § 4.6 table is confirmed
  for two of its rows (DB1-L3, V2-SECTOR: a fan at one point, saturation at its branch points, no local finiteness) and unchecked for the rest.

### 12.5 Held for the coordinator

1. The three planner-assembled statements and the generalization of § 11.5 (3), (4): a deriver's check before `Fan.branch_contacts`,
   `IsUnitCurve.one_le_dist`, `Fan.two_le_n`, `Fan.col_ne` are implemented.
2. The erratum line for E8 § 3.1 (4) (the regularity step; § 11.5 (1)), with the deriver's two lines.
3. § 9.1 item 1 (the two readings of `Σ`): ruled (inventory item 495); the agreement lemma is a row candidate, priced at a day, not stated.
4. FS111-W-NOBEND's merge into FS111-M-C11 (ii) / FS131-E8-LOCAL: confirmed from its entry, its argument unread.
5. `sq9.SingLocallyFinite` (and with it `sq9.RegJFan`) is owed before the wave's gate, as the model of every theorem over `RegJFan`.

### 12.6 Expectations scored (§ 8.4)

| # | registered | outcome |
|---|---|---|
| Y1 | 3 defects among the rows I state, [1, 7] | among the rows stated: (a)–(f) concern rows not reached; found instead: the two frozen sentences on `Σ`'s neighbourhood differ (§ 9.1); the frozen (H2)'s closure clause is redundant at essential boundary points; E8-FAN's "at least two / neighbours differ" over-hypothesized. 3, none a falsehood |
| Y2 | a bridge step that does not formalize as written, 0.6 | **yes** — § 3.1 (4)'s regularity step (neither of the two registered as likeliest: the constants were not reached, and § 3.2 (2)'s parametrization is `gamma`, priced not proved) |
| Y3 | I prove 2 leaves beyond the inhabitants, [0, 4] | `norm_sub_le_of_discs`; `regJFan_of_saturated`, `pinch_interface`, `c11_discs_interface`, `TwoColourNhd.mem_essBoundary`, `Fan.sector_unique` (each from a leaf); `AeColouring.twoColourNhd_of_h1`, `twoColourNhd_of_halves`, `notMem_essClosure_of_mem_densitySet`. FS131-E8-DELTA was registered short and was not proved |
| Y4 | the bridge 15 agent-days, [6, 30] | re-priced 23, [12, 40] (§ 11.4) |
| Y5 | 9 of the 28 left rows stated, [4, 20] | **4** stated or made corollaries (C11 (ii), W-NOBEND, DB1-L3, V2-SECTOR) and V5-LOC in part, beside the bridge's eight: at the interval's lower end. The fan's inhabitant took the stage the ladder would have |
| Y6 | one curve notion, unit-speed with 1-Lipschitz angle, 0.65 | yes |
| Y7 | ≥ 3 rows read a different class than their entry, 0.7 | of those read: PINCH (two sets), C11 (i) (every point of one `N`), E8-LOCAL (no `Σ`), E8-FAN (no `z ∈ Σ`; two clauses without saturation), E8-GAMMA (no `z ∈ Σ`): yes |
| Y8 | the restated foundation costs the proved rows nothing, 0.85 | yes — no proof edited |
