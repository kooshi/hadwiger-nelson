# FS131-IO — OPEN, the fifth move (`HasHornCount`, `exists_open`) in `Plane/ValidMap/OpenMove`

*The record of FS131-IO1 (de Bruijn, the implementer, on Opus), branch `fs131-wop` cut from `main` at `11a34d9d`, in the worktree
`.claude/worktrees/fs131-wop`. Brief: `data/fs131/briefs/FS131-IO1-open.md` (on `main`). Report: `data/fs131/reports/FS131-IO1.md`.*

## Theorems this phase proved

(Filled at each saved stage; see the stages below.)

## Stage 1 — SAVED (FS131-IO1): the readback, the as-given build, and what this job may change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation was compared with its source by reading the source text (the branch's files, and `main`'s
`plans/FS131-close-inventory.md` by `git show main:…` where the branch predates it):

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches** |
| "def HasHornCount (v : ℂ) (j : ℕ) : Prop :=" | `plans/FS131-E6-derivation.md` § 4.5 (1), l. 404 | **matches** |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | same, l. 416 | **matches** |
| "theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1525 | **matches** |
| item 382, "**FS131-E6, by message (mid-job): F6 is real; …** (1) **Realized**" | inventory l. 3388 | **matches** |
| item 384, "**FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k …" | `main`'s inventory l. 3411 | **matches** (on `main` at `4f1ec821`, after this branch's cut; not on `fs131-wop`) |
| item 385, "**Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** …" | `main`'s inventory l. 3435 | **matches** (same note) |
| item 367, "**FS131-IMM4 done: MERGE is proved** (harness ≈ 472k …" | inventory l. 3187 | **matches** |
| item 375, "**MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k …" | inventory l. 3302 | **matches** |

No mismatch.

### 1.2 Read for this job

- `plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- `plans/FS131-E6-derivation.md` §§ 3–4 in full (the model, E6-NODROP, E6-CONE, **E6-OPEN** § 4.2, E6-ROUTE, the trace, the drafts § 4.5,
  the entries).
- MERGE's record, `git show origin/fs131-w4mm:plans/FS131-IMM-implementation.md` (the theorem lists, §§ 4, 5.2, Stages 7–12) for the reused
  lemmas and the construction's shape.
- The code: `ValidMap/Basic.lean` (definitions), `Surgery.lean` (`surgery`, `Near`, the surgery's clause lemmas), `MergeMove.lean`'s
  declaration list and `cone_side`, `gap_assemble`, `clear_near_end`; `Moves.exists_merge_aux` (the assembly); `Sectors.lean`'s partition
  lemmas (`isSector_iff_of_partition`, `encard_sectors_of_partition`, `IsSectorChart.isSector_cone_or_horn`, `IsSectorChart.hasDegree`);
  `Cone.lean`'s `e_eq_of_mem_coneAt_hornSet`.

### 1.3 The branch builds as given

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), before any edit: **OK — "all 1766 modules
already up to date, nothing built, 0 module(s) with warnings"** (the copied `.lake/build` was current), log
`build/gate/build/20261005T101839Z-3305996.log`, terminal output `data/fs131/io/build-0.log`, exit 0.

### 1.4 What this job may and may not change

- **May**: create `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (new declarations only, importing `Contact`, which imports
  `Moves` and `MergeMove`); add it to `Proofs.lean` and `ARCHITECTURE.md`; add an "FS131-IO1" block to `scripts/Axioms.lean` above the
  `=== PURCHASED ===` banner; write this record, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO1.md`. The
  statements of `HasHornCount` and `exists_open` are mine to settle within E6-OPEN's clauses.
- **May not**: change any existing declaration of `main` (`MergeMove`, `Moves`, `Contact`, `Surgery` and every other module stay as
  they are); merge another branch; run the gate; touch `main`; add an `axiom` or a `native_decide`.

## Stage 1 — SAVED (FS131-IO1)

## Stage 2 — SAVED (FS131-IO1): the statements settled; `OpenMove` created with its children `sorry`; the build green

### 2.1 `HasHornCount` — E6's sector-set encoding, kept

```lean
def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
  ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard = j
```

E6's draft verbatim (§ 4.5 (1)), chosen over a count read off `BranchGerms`: it is chart-free, so it is a property of the map and
its value is unique (`HasHornCount.eq`), which the potential `degree + horns` of `acted_finitely` needs; a count read off a chart would
need a chart-independence theorem first. The bridge to charts is `ne_hornSet_of_interior_coneAt` (proved): a set whose cone at `v` has
an interior direction is no horn set, since a horn set's cone is one direction (`e_eq_of_mem_coneAt_hornSet`); with
`IsSectorChart.isSector_cone_or_horn` (every chart sector is a horn set or has an interior direction) a sector is a horn set exactly when
its cone has empty interior. **Spec example** (proved): the constant map of the plane has `HasHornCount 0 0` — its one sector is the
ball, no horn set (the point `−(r/2) e α` lies behind every horn's axis); it fails if the definition drifts to counting all sectors.
**Owed**: a positive spec example (the cusp fragment `cuspFrag` has `HasHornCount 0 2`: pieces 0 and 1 are `hornSet 0 0 (−1) 1 r` and
`hornSet 0 π (−1) 1 r`, pieces 2 and 3 have interior directions) — about 40 lines, not yet written.

### 2.2 `exists_open` — read back against E6-OPEN (record § 4.2) clause by clause

| E6-OPEN | `exists_open` | |
|---|---|---|
| `F` valid, `F.Covers v 1` | `hF : F.Valid`, `hv : F.Covers v 1` | same |
| `F.IsHorn v α κ₁ κ₂ c` | `hH` | same |
| `interior (F.allowedCone v c)` non-empty | `hD` | same |
| — | **`h1 : F.HasSectors v c 1`** | **added: the horn is lone** (decision below) |
| (the degree and horn count of `v`, read in the conclusion) | `hm : F.HasDegree v m`, `hj : F.HasHornCount v j` | E6's draft |
| for every `δ > 0` there is `ρ ∈ (0, δ)` | `{δ} (hδ : 0 < δ)`, `∃ ρ, 0 < ρ ∧ ρ < δ` | same |
| a valid map `F′` agreeing with `F` off `B̄(v, ρ)` | `F'.Valid ∧ F'.AgreesOff F (closedBall v ρ)` | same |
| creating no unit arc, keeping Condition 5 | `F'.RingArcsWithin F ∧ (F.Condition5 → F'.Condition5)` | same |
| carrying no new colour at `v` | `F'.coloursAt v ⊆ F.coloursAt v` | same |
| `v`'s degree not raised, its number of horns lowered by at least one | `∃ m' j', m' ≤ m ∧ j' < j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j'` | same |
| the rim's points of at most three colours with none repeated | `∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x` | same |
| `allowedCone v′ c` unchanged at every `v′ ∉ B̄(v, ρ)` | `∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c` | same |

**The one narrowing, `h1 : F.HasSectors v c 1`** (the brief leaves the statements' exact form within E6-OPEN's clauses to me; held for
the coordinator). E6-OPEN's entry says "not claimed: that the horn's colour has one sector (the statement does not need it)", but its
proof's step 5 relies on `exists_clean` to drop the arcs that would separate `c` from `c` when the partial sector `X` or a swallowed horn
has colour `c`; route (a), which the brief names, builds the map with no cleaning step, and without `h1` it needs a second construction
(MERGE's, with the first `c`-sector on that side as its far end) beside OPEN's. **The use site needs only the lone case**: E6-ROUTE's
OPEN branch is "a lone horn with a non-degenerate allowed cone" — with no MERGE available, a colour of two or more sectors has an
empty-interior cone, so the horn's colour has one sector there. E6's title says the same ("the one-sector wedge-opening"). The general
form is the lone form plus the MERGE case and is not attempted here.

### 2.3 The construction and the children (route (a))

In `X : F.Near v`, along the orbit from `s` (`BranchGerms.idx s m`): for `up` (`σ = +1`) the horn is `idx s 0`, the swallowed horns
`idx s m` (`0 < m < b`), the partial sector `X = idx s b`; for `¬ up` (`σ = −1`) the partial sector is `idx s 0` and the horn
`idx s b`. In both cases the germs inside the merged piece are MERGE's gap germs `idx s m`, `0 < m ≤ b`, so the map is MERGE's for the
gap `s, 0, b` with the wedge added: `openArcs = mergeArcs v col s 0 b ρ ∪ {openRay, openRim}` (the ray out to `ρ/2` at `ψ`; the rim arc
at `ρ/2` across the wedge) and `openCol = c` on `openWedge` (the partial sector's part between its gap germ and the ray, out to `ρ/2`),
`mergeCol` elsewhere. `F' = F.surgery v ρ openArcs openCol …`. Children, all in `OpenMove`, each `sorry` at this stage:

- `Near.OpenConfig` (a structure: `1 ≤ b < n`, the horn a cusp of colour `c` and the only `c`-sector, the ray strictly inside the
  partial sector below `ρc`, every point between the horn's inner germ and the ray clear for `c` below `ρc`) and
  `Near.exists_openConfig` (E6-OPEN's steps 1–4: N3-CONF, `cone_side`, the first sector of positive angle, `clear_near_end`).
- The surgery's obligations: `openArcs_finite` (proved), `openArcs_nondegenerate`, `open_hlc`.
- The clauses: `open_agreesOff`, `open_ringArcsWithin`, `open_condition5`, `open_valid`, `open_coloursAt_self`, `open_degree_horns`,
  `open_rim`, `open_allowedCone`.
- **The assembly `ArcMap.exists_open` is proved over them** (no `sorry` in its body): `X` from `exists_near`, the configuration,
  `ρ := min (min (ρ'/2) ρc) (δ/2)` with `X.Small ρ'`.

### 2.4 The build, the checks

Under the slot: **OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove` 2.3 s, `Proofs`), 8 min 17 s, "Build completed successfully";
warnings only `declaration uses 'sorry'`, all 11 in `OpenMove` (`exists_openConfig`, `openArcs_nondegenerate`, `open_hlc`, and the eight
clauses). Log `build/gate/build/20261005T103947Z-3423705.log`; terminal output `data/fs131/io/build-stage2.log`.
`tools/check_architecture.py`: PASS (exit 0) with the new row. `scripts/Axioms.lean`: an "FS131-IO1" block above the PURCHASED banner
with the 16 new theorems. No existing declaration changed, no `axiom`, no `native_decide`.

## Stage 2 — SAVED (FS131-IO1)
