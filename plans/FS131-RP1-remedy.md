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
