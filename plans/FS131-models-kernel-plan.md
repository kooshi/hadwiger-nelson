# FS131-KM1 — the example maps planned: Lean objects on which the four moves' hypotheses, the stuck vertex's and the two bends' hold at once (de Bruijn, the planner)

*Brief: `data/fs131/briefs/FS131-KM1-models.md`. Branch `fs131-wm`, worktree `.claude/worktrees/fs131-wm`. Started 2026-10-06 07:10 UTC.
Nothing in this milestone is blind (ruling 1), so this plan has one phase.*

## Theorems this phase proved

Listed at the last saved stage (§ "Theorems this phase proved, final"); a planning job proves few. Until that section exists: none.

## Stage 1 — SAVED (FS131-KM1): the readback

### 1.1 The brief's quotations (standing rule 3)

`tools/fs131_km_quotes.py` reads each `> text` / `> — source: path` pair of the brief and counts the text in the file the source line
names; output `data/fs131/km/quotes.out`. **27 quotations, 27 found verbatim, each once; none missing.** `--self-test` changes the last
character of every quotation and requires all 27 to be reported missing: `27 of 27 … OK`, exit 0 (the planted fault fires).

The six theorem heads, the four pieces (`recolour`, `recolour_valid`, `sevenBrickMap`, `bowtie`, `bowtie_isStuck`, `cuspFrag`) and the
three audit rows are as quoted. Read in their place, whole with docstrings: `exists_merge`, `exists_rayMerge`, `exists_shave`
(`Contact.lean` l. 1490–1531), `exists_open`'s module header and `HasHornCount` (`OpenMove.lean` l. 1–120), `bend_toward`,
`bend_away_whole` (`UnitArc.lean` l. 3771–3978).

### 1.2 What was read, and how far

| file | read |
|---|---|
| `plans/STANDING-RULES.md`, `LEAN.md` | whole |
| `RUNNING.md` § Building | whole |
| `plans/FS131-QA4-audit.md` | whole (§§ 3.1–3.5, 4, 6 as the brief asks) |
| `plans/FS131-E7-derivation.md` | §§ 3–7 whole (l. 239–766); §§ 1–2, 8 not read |
| `plans/FS131-close-inventory.md` | items 427, 440 (its second half), 441, 454 (its second half), 455 |
| `Plane/ArcMap.lean` | whole |
| `Plane/Woodall/Merge.lean` | header; `recolour` and its five lemmas, `wedgeMerge` (l. 633–800); `coloursAt_congr`, `niceAt_congr` |
| `Plane/ValidMap/Basic.lean` | l. 1–300: every definition a move's hypothesis names |
| `Plane/LocalMap.lean` | l. 60–288: cones, germs, tiles, ring arcs, change points |
| `Plane/SVMap.lean` | l. 826–1125: `sevenBrickMap`, its arcs, `not_mem_sevenBrickArcs`, the corner sectors; the corner theorems by their heads |
| `Plane/ValidMap/Sectors.lean` | `isSector_iff_of_partition`, `encard_sectors_of_partition`, `cuspFrag` and the heads of its lemmas |
| `Plane/ValidMap/Surgery.lean` | `germArc`, `carrier_germArc`; the heads of `isOpen_hornSet`, `isPreconnected_hornSet` |
| `Plane/ValidMap/BaseSteps.lean` | `coloursAt_hasSectors_of_tiles`, `bowtie_inType`; the rest by heads |
| `data/fs131/qa4/QA4Bowtie.lean`, `QA4Collar.lean` | at Stage 3, with the bends |

### 1.3 The build as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree, 2026-10-06 07:16 UTC: `All targets
up-to-date (5750 jobs)`, `OK — all 1767 modules already up to date, nothing built, 0 module(s) with warnings, 3s`, exit 0
(`data/fs131/km/build-0.log`). The branch is current.

### 1.4 What I am planning, and what I may change

**Planning**: Lean objects — maps, each with a named theorem stating that it satisfies every hypothesis of one landed theorem at once —
for: the four local moves (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`); a positive `HasHornCount v 1` (and, after
wave 5, `IsSite`); `Valid ∧ Covers v 1 ∧ IsStuck v` (FLANK-Q, `FlankUA`, `Terminal`'s stuck lemmas, `woodallCone`); E7's four (`F₀` for
`a4six`, `F₁` for `straddlers_third` and `nb4p`'s background, `P₄` for `flank_ne_of_doublyShadowed`, `P₅`); the two bends
(`bend_toward`, `bend_away_whole`); `awayModel` for `bend_away_part`; and the objects `exists_vertexStep` and `cvb_hole_disconnected`
will apply to once wave 5 lands.

**Mine to change**: new modules under `Proofs/HadwigerNelson/Plane/` (new declarations only), `Proofs.lean`, `ARCHITECTURE.md`, a block
"FS131-KM1" in `scripts/Axioms.lean`, this record, `tools/fs131_km_*.py`, `data/fs131/km/`, the report. **Not mine**: any statement,
definition or docstring of a landed declaration (the docstring lines the models earn are drafted in § "Docstring lines", with their
slots); `main`; wave 5's branches; `LEAN.md`, the inventory and every file Keryx alone writes.
