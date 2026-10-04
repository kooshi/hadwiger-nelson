# FS131-IM — wave 4's three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) in `Plane/ValidMap/Moves`

*The record of FS131-IM1 (de Bruijn, the implementer, on Opus), branch `fs131-w4m` from `fs131-w4c` at `d4f946ae`, in the worktree
`.claude/worktrees/fs131-w4m`. Brief: `data/fs131/briefs/FS131-IM1-moves.md` (on `main`). Report: `data/fs131/reports/FS131-IM1.md`.*

## Theorems this phase proved

(none yet)

## Stage 1 — SAVED: the readback, the as-given build, what I may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation checked against its source by reading the source at the address given (the quotations are prefixes of the source text, cut
with `…`):

| quotation | source | result |
|---|---|---|
| "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (…) to a parallel implementer in a" | `plans/FS131-close-inventory.md` l. 1692 (on `main`) | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | **verbatim** |
| "3. **`exists_shave`** (H, about a session). `F′ = F` plus two arcs — the branch of curvature `σ` from `v` to radius `ρ` (`Arc.circ` with explicit" | `.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md` § Stage 2, item 3 | **verbatim** |
| "4. **`exists_rayMerge`, `exists_merge`** (H each, a session each). **The plan's claim (§ 13.1 engine 3: "the moves of Contact add arcs and recolour; they" | the same, item 4 | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | `fs131-w4`'s kernel plan § 14.5 | **verbatim** |
| "223. **Engine 2 written once** (item 218 (g)): FS131-I4i wrote `ringArcsWithin_of_Γ_subset` in `Plane/ValidMap/Basic` on `fs131-w4` (`3f7ea033`, Basic.lean only," | `plans/FS131-close-inventory.md` l. 1596 | **verbatim** |

The paraphrase after the IC quotations ("SHAVE adds two arcs from `v`; the merges each need **a cut at `v`** …; `exists_shave` keeps its statement though it
does not assume `g ≠ c` or `h ≠ c`, so the case `g = c`, `σ < κ₂` needs the same cut") matches IC's items 3–4 in substance.

**One small difference, not a defect:** ruling 236 says `Moves` imports "`Basic`, `Sectors`, `SVMap`"; the brief says "what `Contact` imports — `Plane/ValidMap/Basic`,
`Plane/Tiles`, `Plane/SVMap`". `SVMap` imports `Sectors`, so importing `Contact`'s three satisfies both; I follow the brief.

The three statements are at `Contact.lean` l. 4019 (`exists_shave`), 4033 (`exists_rayMerge`), 4049 (`exists_merge`) at `d4f946ae` — checked.

### 1.2 What I may and may not change

**May** (brief § What is yours to decide; kernel plan § 14.2): add children in the new module `Plane/ValidMap/Moves` or, statements unchanged, in
`Plane/ValidMap/Basic`; bring engine 2's exact hunk (`3f7ea033`) into `Basic`; edit `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block,
headed "FS131-IM1"), this record, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM1.md`.

**May not**: change any statement of the three moves (they are copied by script, hypotheses, binders and conclusion verbatim, as `…_aux`); change any
definition of `Plane/ValidMap/Basic`; edit `Contact.lean` (FS131-IC4's) or wave 4's other modules (`BaseSteps`, `UnitArc`, `Sectors`, `SVMap`, `StuckChain`);
add an `axiom` or use `native_decide`; merge into `fs131-w4c` or `fs131-w4`; run wave 4's gate; push to `main`; start agents. A move that cannot be proved as
written is a message to Keryx with the declaration, the reason and the smallest counterexample or missing hypothesis; a `Contact` lemma a move needs is a
message too (that lemma then moves to `Moves`, by Keryx), never a copy.

### 1.3 The branch builds as given

`d4f946ae`, built under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 444 of 444 batches, 4 modules
rebuilt (the worktree's `.lake/build` is a copy from `fs131-w5b`), warnings only `declaration uses 'sorry'`, in `BaseSteps`, `UnitArc` and `Contact` (its four
leaves: the three moves and `stuck_structure`). Log `build/gate/build/20261004T214859Z-2681059.log`; the run's terminal output `data/fs131/im/build-asgiven.log`.
