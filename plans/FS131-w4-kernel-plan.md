# FS131-K4 — wave 4's kernel plan: valid maps (contact types, Woodall's merge, shadows, the unit-arc calculus, the base's steps, S–V maps)

*De Bruijn, the planner (Opus 5.5), job FS131-K4, brief `data/fs131/briefs/FS131-K4-wave4.md`. Branch `fs131-w4` in the worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4`, from `05cb0a3e` (wave 3's skeleton). Nothing in this milestone is blind
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

## Theorems this phase proved

None (a planning job: definitions, spec examples and a skeleton; no row is proved here).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches**, a prefix of the source sentence run (the source continues "Your predecessor formalized …") |
| "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in" | `plans/FS131-kernel-plan.md` § 7.3 item 3 | **matches as a truncation**: the source item ends "… reads each statement back in its record against the row." — the brief cuts mid-sentence; nothing is changed |
| items 7 and 8 of `plans/FS112-derivation.md`'s errata section, "which `plans/LEAN-BACKLOG.md` quotes … at the top" | `plans/LEAN-BACKLOG.md` lines 13–19 | **matches**: both items quoted under "Notes of `plans/FS112-derivation.md`'s errata section that name no entry" |
| the 29 rows, the two merged rows, the three R9 rows, C116 on FS112-C-DOUBLE | `data/fs131/k1/dispositions.csv` (wave 4, *formalize*) | **matches**: 29 formalize rows in the five modules the opening plan names, FS112-BEND → FS112-N2-BENDS, FS114-L60-WALK → FS114-L60-LE, `ruling = Y` on FS106-WO, FS106-TW, FS112-N2-RAY (and FS114-L60-WALK, R8), C116's reason on FS112-C-DOUBLE |

### 1.2 The rows, quoted

`data/fs131/k4/rows.md` holds each of the 31 rows' whole backlog section byte for byte, written by `tools/fs131_k4_rows.py`
(`--check`: OK, 29 rows, 2 merged; `--plant`, one character inserted into a quoted line of FS110-N3-CONF's section: FIRED). The rulings that
govern the rows (`plans/FS131-kernel-plan.md` § 4.3, ruled by Keryx): **R8** — FS114-L60-WALK's content is checked when its consumers (FS112-N2-RED,
-N3-COR3, -N3-BASE, -N3-DENSE3, FS114-CV-EXISTS: all wave 5) are stated over L60-LE's non-strict bound; its one mathematical clause, L60-D5 ("in N3-BASE's
setting, the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart"), lives in N3-BASE's setting and is carried to wave 5 with it
(§ 1.4). **R9** — FS106-WO, FS106-TW, FS112-N2-RAY are formalized without their verdict clauses. **C116** — FS112-C-DOUBLE with its errata: item 3
of `plans/FS112-derivation.md`'s errata section (a regrade, two minds) is the only note filed under it, and it changes no word of the statement.

### 1.3 The worktree builds as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`), driver log `data/fs131/k4/build-stage1.log`: **OK — 440 of 440
batches, 10 modules rebuilt, 6 modules with warnings** (exactly wave 3's six skeleton modules, their `sorry` warnings), 8 m 18 s, exit 0
(`build/gate/build/20261004T065051Z-1749837.log` in the worktree).

### 1.4 What the rows' words need that wave 3 does not give (read before the foundation)

The derivations' vocabulary for this wave, with its source: the **frame** at `v` (`a` a direction, `n ⊥ a`, `N = v + n`, `S′ = v − n`, `P_k = v + kn`,
upward curvature of an arc tangent to `a` at `P_j`) and **shadow** `Sh(T) = {z : ω(z) ∩ T ≠ ∅}` (`plans/FS110-N-proof.md` N4-2 setting); **contacts**,
**in-type/out-type**, `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}`, **clear** (N3 table, N3-2 frame); **sectors**, `s_c(v)`, `Φ(v)`, **cusp horns**
(`{κ₁x²/2 < y < κ₂x²/2, x > 0}` to second order, N3-2 frame), **Woodall's cone** (N3-DEG); MERGE, MERGE-RAY, SHAVE, **terminal**, **stuck** (N4-2
§§ 2.2–2.5); the FS-112 **contact kinds** in/out/both/inert of a unit arc, **(Q)**, **(R2)**, `R₂(ᾱ)` (`data/fs112/claims.md` § 0; FS112 derivation
header); **cubic trichromatic**, **repeated colour**, **leaving centre**, **M-in**, CB's **D2 strip** (FS-112 N3 records); S–V's **map-type colouring**
(Conditions 2–6, `data/fs106/claims.md` § 0 D-SV, D-AEMAP) and **chromaticity** (D-VMC); Townsend's **finitely disconnected unit annulus**
(`plans/FS106-V-verification.md` V3 stage 1, Definition 2).

### 1.5 Registered before the definitions

- The likeliest statement defects (opening plan § 7.3 item 2): "sector" and "degree" at a cusp. Expectation: none is a defect once a sector is a
  component of `B(v, r) ∖ Γ` with `v` in its closure, counted for all small `r`; a cusp horn is then one sector, as the rows read it. p ≈ 0.7.
- FS110's rows were derived under Condition 5; FS112-WALK (`plans/FS112-derivation.md` l. 35) says N3-CONF, W-MERGE, N4-RAY and N4-FIN hold as
  written with unit arcs. Expectation: N3-CONF states without Condition 5 (a widening to report); W-MERGE needs Condition 5 only to keep it. p ≈ 0.6.
