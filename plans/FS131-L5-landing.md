# FS131-L5 — wave 5's landing (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-L5-wave5-land.md` (on `main`). Branch `fs131-w5c`, from `8f2280d0`. Working files: `data/fs131/l5/`.
Tools: `tools/fs131_l5_*.py`. Report: `data/fs131/reports/FS131-L5.md`.*

## Theorems this phase proved

This job proves no new theorem: it joins the branch that holds the proved outward bend to wave 5's line, makes the ruled tidies, and
takes the whole wave through the gate. The wave's heads and their axioms, read from the gate's saved log, are listed at the stage that
ran the gate.

## Stage 1 — SAVED (FS131-L5): the readback, the tree as given, the trial merges

### 1.1 The brief's quotations (standing rule 3)

`python3 tools/fs131_l5_quotes.py <brief> --root /home/kooshi/source/lean-dir` — **16 quotations, 0 mismatches**
(`data/fs131/l5/quotes.txt`): Kooshi's line in `CLAUDE.md` § The standard of evidence (l. 412); eleven inventory items on `main`
(468, 469, 464, 465, 458, 459, 462, 455, 415, 419, 427), each then read whole, with 454, 456, 457, 460, 461, 463, 466, 467 beside
them; the three statements in this tree (`exists_terminalMap`, `Procedure` l. 3340; `exists_terminal`, `Terminal` l. 3816;
`bend_away_part`, `BendStep` l. 346); the gate's recorded counts (`CLAUDE.md` l. 504). A relative source is read under `main`'s
checkout, where the brief was written. `--self-test` (`quotes-selftest.txt`): four plants, each refused — a changed character, a
wrong source, an empty quotation (which must not match every line), a brief with no quotation (exit 2, never 0).

Read besides: `plans/STANDING-RULES.md`; `LEAN.md` in full, **from `main`'s checkout** (21,291 bytes; this tree's copy is the
branch point's, 17,045 bytes, without the doubled-name bullet); `RUNNING.md` § Building and § Make the gate fail, and watch it fail;
FS131-RP1's report and record whole; FS131-M7's report, its last two sections; FS131-BA3's report (in `fs131-w5z`'s tree);
FS131-OL1's Stages 16–20 and drafts in `plans/FS131-IO-implementation.md` (on `main`; this tree's copy ends at Stage 15).

### 1.2 The tree as given

`8f2280d0`, equal to `origin/fs131-w5c`, clean. Build under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; driver `data/fs131/l5/build-asgiven.log`, full log `build/gate/build/20261006T085527Z-2764942.log`, copy
`data/fs131/l5/build-asgiven-full.log`): **exit 0, "all 1796 modules already up to date, nothing built, 7 module(s) with warnings"**
— the oleans are FS131-RP1's final build's. 36 warning lines, every one `declaration uses sorry` (0 of another kind): `BendAway` 6,
`LensOut` 7, `CollarMapOut` 7, `R2Cap` 3, `HornChart` 4, `BendGap` 8, `BendStep` 1 — RP1's count.

### 1.3 The trial merges, on this tip (nothing written to a ref or to the tree)

- **`origin/fs131-w5z` at `d4f04ff3`** (one merge base, `dd8c2c33`), `git merge-tree --write-tree --name-only HEAD origin/fs131-w5z`
  (`data/fs131/l5/trial-merge-w5z.txt`): **one conflict, `scripts/Axioms.lean`** — the end of the CLEAN section, where this line's
  two blocks (FS131-M7, FS131-RP1) and that line's three (FS131-BA1, BA2, BA3) were each appended after FS131-KA1's block; keep
  both. `ARCHITECTURE.md` does not conflict: `fs131-w5z` did not change it. The files that line changed outside `plans/` and
  `data/`: seven Lean modules (`BendAway`, `BendGap`, `BendStep`, `CollarMapOut`, `HornChart`, `LensOut`, `R2Cap`),
  `scripts/Axioms.lean`, six tools of its own; of these only `scripts/Axioms.lean` was changed on this line too. `BendStep`
  differs between the two tips in three places, all that line's: the horn child's docstring line, its proof in place of `sorry`,
  and `AwayBend.idle`'s call (ruling 446 (b)).
- **`origin/main` at `28ac525a`** (one merge base, `a20bb6f5`), the same trial (`trial-merge-main-pre.txt`): clean. **What `main`
  changed since this branch last had it**, outside `plans/` and `data/`: `.claude/` (2), `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEAN.md`,
  `ARCHITECTURE.md` (one row, `OpenMove`'s), `scripts/Vacuity.lean` (a comment: OPEN's carriers), `scripts/vacuity-baseline.txt`
  (the header's two count lines), FS131-T4's three new files under `scripts/`, ten files under `tools/`. **No file under
  `Proofs/`.** The brief's expectation named `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md` and T4's new files; the rest is
  FS131-OL1's landing and its filing — recorded at the stage that makes the merge.

### 1.4 Read before the tidies (step 3), on the two tips

- `hF` in the toward `CollarFit.sides_end`, `sides_eq`, `map_R1`, `map_R2` (`BendCollar` l. 1014–1282): read by none — `sides_end`
  holds `have _ := hF`; `sides_eq` and `map_R1` pass it to `sides_end` only; `map_R2` passes it to `sides_eq` only. Their callers:
  `CollarFit.map_inert` and `bend_toward_collar` (`BendCollar`), `CollarFit.map_isR2Arc` (`BendStep`), `CollarFit.arcBend`
  (`ArcStep`); each of these reads `hF` elsewhere (`side_ne_inner_of_mem_lens`, `map_valid`, `isR2Arc_of_fixed`), so none loses
  its own.
- `CollarFit.map_hornCount_le` (`BendStep`, proved on `fs131-w5z`): `have _ := hF`; one caller, `CollarFit.arcBend`.
- `ringPt_inj_of_abs_sub_lt` (`BendAway`, namespace `Plane`) and `ArcMap.ringPt_ne_of_abs_sub_lt` (`BaseDense`, three uses, all
  in `BaseDense`): on the joined line `BendAway` is upstream of `BaseDense` (through `Terminal`, `Procedure`, `ArcStep`,
  `BendStep`, `BendGap`), so the upstream one is the one to keep.
