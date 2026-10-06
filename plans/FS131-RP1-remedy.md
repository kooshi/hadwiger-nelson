# FS131-RP1 — wave 5's remedy pass on `fs131-w5c` (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-RP1-remedy.md` (on `main`). Branch `fs131-w5c`, from `3381e47f`. Working files: `data/fs131/rp/`.
Tools: `tools/fs131_rp_*.py`.*

## Theorems this phase proved

No new mathematics. One new declaration, a model's hypothesis set stated as a theorem; its line is added at the stage that builds it.

## Stage 1 — SAVED (FS131-RP1): the readback, the tree as given, the work list

### 1.1 The brief's quotations (standing rule 3)

`python3 tools/fs131_rp_quotes.py <brief>` — **20 quotations, 0 mismatches** (`data/fs131/rp/quotes.txt`): Kooshi's line in `CLAUDE.md`; nine
inventory rulings (427, 419, 441, 450, 432, 434, 455, 458, 459), each read whole; the four statements in this tree; QA4's rows 2, 3, 8; the
lint measurement's sentence; E7's two headings. `--self-test`: three plants (a changed word, a wrong source, an empty quotation), each
refused (`quotes-selftest.txt`).

Read besides: QA4 §§ 3.1–3.5, 4, 6; the lint measurement's findings and Stage 4; E7 §§ 1.4, 3.6–3.7, 4.4, 5, 6.4–6.5, 7; M7's report whole.

### 1.2 The tree as given

`3381e47f`, equal to `origin/fs131-w5c`. Build under the slot (`data/fs131/rp/build0.log`): exit 0, "all 1796 modules already up to date",
36 `sorry` warnings, all in the outward bend's modules (`LensOut` 7, `CollarMapOut` 7, `HornChart` 4, `BendAway` 6, `R2Cap` 3, `BendGap` 8)
and `BendStep` 1 — M7's count.

### 1.3 Two things the brief's numbers do not say

- **The notes check finds 21 conflicts on this line, not 17** (`tools/fs131_rp_notes.py`, QA4's tool run over the working tree;
  `data/fs131/rp/notes-before.txt`): `FlankUA` 10 — the audit's nine and `horn_bounds_of_interior_empty` (l. 738, written since);
  `Terminal` 10 — the audit's eight and `horn_colour_eq_of_isChainVertex` (l. 3593), `eq_horn_colour_of_two_sectors` (l. 3630);
  and `exists_arcStep` (`Procedure` l. 2776: the note names `l60Frag` under `IsPlaneMap`). All 21 are this pass's.
- **The fenced modules read two of the doubled names**, here and on `origin/fs131-w5z` (`ef33a037`): `BendStep` l. 60 `hdeg.unique`
  and l. 105 `coloursAt_eq_singleton_of_interior`. So of those two pairs the surviving names are `HasDegree.unique` and
  `coloursAt_eq_singleton_of_interior`; the bend modules read no other name this pass removes (`conj_e` survives by name).

### 1.4 The work list (upstream first; "users" are the lines re-pointed)

| # | item | file(s) | ruling | the change | callers / users |
|---|---|---|---|---|---|
| S1 | `DyadicSqrt3Conclusion` | `Arith/Dyadic` | 419 (a) | `[NumberField L]` out of the definition | five statements of the same file, text unchanged |
| S2 | `placeHom_step` | `Arith/PlaceHom` | 419 (a) | `[NumberField F]` out | `exists_isPlaceHom` (l. 303), text unchanged |
| S3 | `falconerFan_five_placeHom` | `Arith/FalconerField` | 419 (a) | `[NumberField F]` out | none |
| S4 | `nb4p` | `Plane/ValidMap/UnitArc` | 441 (a) | `hnb` keeps its first conjunct; the docstring names the mirror at [hand] | none |
| S5 | `bend_toward_collar` | `Plane/ValidMap/BendCollar` | 419 (d), 427 (a) | `hlen`, `hmax` out; a theorem of the model's hypotheses beside `collarModel`; docstring lines | none in `Proofs/` |
| S6 | `exists_rayStep`, `exists_shaveStep` | `Plane/ValidMap/Procedure` | 450 (c) | `hn` (and `n`) out | `exists_vertexStep`, two lines |
| D1 | `conj_e`; `‖z‖² = re² + im²` under four names | `Plane/Basic` ← `Plane/Chord`; `SixFragment`, `UnitArc`, `HexRing` | 459 (c) | `conj_e`, `sq_norm_eq` declared once in `Plane/Basic` (the one module both import); `SixFragment`'s `conj_e`, `sq_norm_re_im`, `ArcMap.sq_norm_eq_re_im`, `ArcMap.norm_sq_eq_re_im` removed | `SixFragment` 9, `UnitArc` 11, `BendCollar` 1, `HexRing` 17 |
| D2 | `HasDegree.eq` / `.unique` | `ValidMap/Basic` ← `Pushforward`; `OpenMove` | 434 (d), 459 (c) | `HasDegree.unique` beside the definition; `HasDegree.eq` removed | `OpenMove` 1, `Procedure` 4 |
| D3 | `coloursAt_eq_of_mem_interiorPts` / `…_singleton_of_interior` | `FlankUA`; `Limit` keeps | same | `FlankUA`'s removed | `Terminal` 4, `BaseWalk` 1, `BaseDense` 2 |
| D4 | `ArcMap.dist_sq_re_im` / `dist_sq_re_im` | `BaseWalk`; `SixFragment` keeps | same | `BaseWalk`'s removed | `BaseWalk`, text unchanged |
| D5 | `ringArc_add_int_mul` / `ringArc_add_two_pi_mul` | `BaseWalk`; `MapTopology` keeps | same | `BaseWalk`'s removed, if the two statements are one | `BaseDense` 1 |
| D6 | `ringPt_add_int_mul` / `ringPt_add_int` | `BaseWalk`; `Procedure` keeps | same | `BaseWalk`'s removed | `BaseWalk` 6, `BaseDense` 1 |
| D7 | `IsRingArc.union_of_overlap` / `.union` | `BaseDense`; `Procedure` keeps | 434 (d) | `BaseDense`'s removed | `BaseDense` |
| D8 | `finite_arcs_meeting_compact` / `finite_arcs_inter_compact` | `BaseDense`; `Limit` keeps | 434 (d) | `BaseDense`'s removed | `BaseDense` |
| N1 | ten `bowtie` notes | `FlankUA` | 427 (a), rank 2 | what `bowtie` satisfies, the one it fails, the hand model `P₅` | — |
| N2 | ten `bowtie` notes; the stuck family's "no model … is known" | `Terminal` | 427 (a); 441 (e) | as N1; E7 § 7.5's three classes | — |
| N3 | `a4six`, `straddlers_third`, `nb4p` | `UnitArc` | 441 (b) | E7's lines (§§ 3.7, 4.4, 5) | — |
| N4 | `flank_ne_of_doublyShadowed`; the three moves | `Contact` | 441 (b); rank 8 (a) | E7 § 6.5's line; a note per move | — |
| N5 | the moves' `_aux` forms | `Moves` | rank 8 (a) | a note each | — |
| N6 | `pair_ii`, `fail_leavingCentre`, `fail_colours` | `BaseSteps` | rank 8 (b) | the note says it inhabits one hypothesis | — |
| N7 | `rot_out`, `rot_in`; `exists_eleventh_of`, `exists_far_end`; `dense3`, `cv_exists` | `HexRing`; `MapTopology`; `BaseDense` | rank 8 (c) | the base's line or the open line | — |
| N8 | four refutation steps | `Plane/Woodall/*` | rank 8 (d) | "a refutation step", naming `sevenBrickMap_woodallModel` | — |
| N9 | `LocalSeq.const` | `Limit` | rank 8 (e) | "idle", not "every clause exercised" | — |
| N10 | module lines | `SVMap`, `UnitArc`, `Cone`, `MapTopology` | rank 8 (f); 427 (d) F2 | one line naming the family's model | — |
| N11 | `exists_arcStep` | `Procedure` | rank 7 | the note limited to what `l60Frag` satisfies | — |
| N12 | two cells; rows naming a removed declaration | `ARCHITECTURE.md` | 432 (b) | IS1's drafts; the rows follow the code | — |

**The order and the rebuilds.** D1 edits `Plane/Basic`, the root of every `Plane/` module, so one rebuild of the whole `Plane/` tree is
paid whatever else is done; every other item rides it. Two builds are planned: one after S1–S6 and D1–D8 (the edits that can fail), one
after N1–N12 (docstrings: the same elaboration, so it cannot fail on mathematics). While the first runs, the notes are drafted as a
replacement script and applied only when it has ended — no file is edited while a build of it runs.

**Not done by this job** (the brief's fence): the seven modules of the outward bend and `BendStep`. Their list is the report's last section.

## Stage 2 — SAVED (FS131-RP1): the statement tidies and the statements under several names — edited, checked by script, elaborated for iteration; the build follows

*The Lean sources of this stage are elaborated under `lake env lean` only (iteration, never evidence). The build that reads them is
Stage 3's.*

### 2.1 What was done (rows S1–S6, D1–D8 of § 1.4, all of them)

- **S1–S3**: `[NumberField _]` out of `DyadicSqrt3Conclusion`, `placeHom_step`, `falconerFan_five_placeHom`. No caller's text changed.
- **S4** `nb4p`: `hnb` is now `∀ j < 6, ¬ G.OnRingArc (ringPt v (ψ + (j + 1)·π/3)) (ringPt v (ψ + j·π/3))`; the proof's one use
  `(hnb k hk).1` is `hnb k hk`. The docstring says the removed clause alone suffices too, by the mirror, at [hand] (E7 § 5.4), and
  carries E7's model line (§ 5.1) with its grade.
- **S5** `bend_toward_collar`: `hlen`, `hmax` and the two `have _ :=` lines out. **`collarModel_hyps`** is new: `collarModel`'s old body
  up to its last line, concluding `l60Frag.Valid ∧ l60Frag.IsRingArc 0 (π/8) (5π/24) 0 1 ∧ 1 ∉ l60Frag.coloursAt 0 ∧ hfree`;
  `collarModel` is now `exists_collarFit` at it (statement unchanged). **A decision of mine, held for the coordinator**: QA4-C1's
  conjunction has a fifth conjunct, `5π/24 − π/8 < 2π`, which was `hlen`; with `hlen` gone it corresponds to no hypothesis, and the
  theorem states the four that remain. `bend_toward_collar` and `exists_collarFit` each name `collarModel_hyps`.
- **S6** `exists_rayStep`, `exists_shaveStep`: `{n : ℕ}`, `hn` and `have _ := hn` out; `exists_vertexStep`'s two calls lose the argument.
- **D1** `conj_e` and `sq_norm_eq` are declared in `Plane/Basic` (the only `Proofs` module both `Chord` and `SixFragment` import) and
  removed from `Chord`; `SixFragment`'s `conj_e` and `sq_norm_re_im`, `UnitArc`'s `ArcMap.sq_norm_eq_re_im`, `HexRing`'s
  `ArcMap.norm_sq_eq_re_im` removed; users re-pointed to `sq_norm_eq`: `SixFragment` 8, `UnitArc` 10, `BendCollar` 1, `HexRing` 14
  (§ 1.4's counts were of lines including each declaration; these are the uses).
- **D2** `HasDegree.unique` moved from `Pushforward` to `Plane/ValidMap/Basic`, beside `HasDegree`; `OpenMove`'s `HasDegree.eq` removed;
  users: `OpenMove` 1, `Procedure` 4. `HasHornCount.eq` is another statement and stays.
- **D3** `FlankUA`'s `coloursAt_eq_of_mem_interiorPts` removed (nothing in `FlankUA` read it); users → `coloursAt_eq_singleton_of_interior`:
  `Terminal` 4, `BaseWalk` 1, `BaseDense` 2.
- **D4–D6** `BaseWalk`'s `ArcMap.dist_sq_re_im`, `ringArc_add_int_mul`, `ringPt_add_int_mul` removed; users → `dist_sq_re_im` (text
  unchanged), `ringArc_add_two_pi_mul` (`BaseDense` 1), `ringPt_add_int` (`BaseWalk` 4, `BaseDense` 1).
- **D7–D8** `BaseDense`'s `IsRingArc.union_of_overlap`, `finite_arcs_meeting_compact` removed; users → `IsRingArc.union` (2),
  `finite_arcs_inter_compact` (1); two docstring mentions follow.
- Each pair's two statements were read side by side before removal (same binders, same conclusion; § 1.4's D5 "if" is met).
- `scripts/Axioms.lean`: ten records removed (the removed names), one added in a block "FS131-RP1" above the PURCHASED banner
  (`collarModel_hyps`); moved declarations keep their names and records.

### 2.2 The statement check (`tools/fs131_rp_stmt.py`, manifest `data/fs131/rp/stmt-expected.json`)

Every declaration of every Lean file under `Proofs/` at `3381e47f` against the working tree: **11,258 declarations in 1,796 files;
changed 7, gone 14, added 4 — exactly the manifest's** (7 changed; 11 gone and 3 moved away; 1 added and 3 moved in; each moved
statement identical in its new file), 0 deviations (`data/fs131/rp/stmt-stage2.txt`). `--self-test`: six plants, each refused by
name — an unruled statement change, deletion, addition; a moved statement altered; an addition in a file outside the manifest; a
manifest entry that did not happen (`stmt-selftest.txt`). What it does not see: a proof's text (by design), and an attribute or
`variable` line changed above a declaration.

### 2.3 Iteration, not evidence

`lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false` on the 16 edited files that the oleans on disk can check
(`data/fs131/rp/lean-check/`): 15 exit 0 with no warning; `Pushforward` fails as it must against the old `ValidMap/Basic`
(`HasDegree.unique` not yet there). The three files that read a moved declaration (`SixFragment`, `Pushforward`, `OpenMove`) were
elaborated against an overlay — a symlink copy of the built library under `build/rp-overlay` with `Plane/Basic` and `ValidMap/Basic`
compiled over their links (`overlay.sh`): all three exit 0. The overlay is removed; the built library was not written to (olean
times checked).

### 2.4 Slips, mine

- Three edit scripts stopped at an occurrence count I had predicted from `rg`'s line count, which included the declaration itself
  (9 for 8, 16 for 14) or my own new comment (4 for 5); each stopped before writing that file, and was re-run with the count read.
- A back-quoted word inside a double-quoted `rg` pattern was read by the shell as a command ("GENERIC: command not found");
  nothing ran.
- The first overlay had only the two new oleans; Lean takes every `Proofs.*` module from the first path entry holding `Proofs/`,
  so all three checks failed at import. Rebuilt as a symlink copy.
