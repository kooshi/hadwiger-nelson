# FS131-QA2 — impossible assumptions: every hypothesis the backlog's Lean takes, checked for a real instance (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA2-impossible-assumptions.md`. Read-only toward every `Proofs/` file, worktree and branch; every finding is
a recommendation routed through Keryx. Code read with `git show <ref>:<path>` at the refs in § 1.2.*

## Theorems this phase proved

None in the library. An audit proves nothing there; its exact checks and scratch `example`s are evidence for verdicts, listed where used.

## Stage 1 — SAVED

### 1.1 The brief's quotations (standing rule 3)

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "158. **Statement defect — definitions: `WoodallMerged` and `WoodallNormal` are unsatisfiable on every valid plane map; `exists_woodallMerged` is false at" | `plans/FS131-close-inventory.md` | **matches**, line 1045, verbatim (the item's first line; the brief says "the item continues there") |
| 2 | "inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a" | `LEAN.md` § The gate | **matches**, verbatim (a mid-sentence excerpt of the inhabitant rule) |
| 3 | "165. **Kooshi, 2026-10-04 (verbatim)**: *"Ok, I'm caught up. Yes, run the impossible assumption audit. And thank you and all the agents for your excellent work." | `plans/FS131-close-inventory.md` | **matches**, line 1134, verbatim (the item's first line) |

No slip.

### 1.2 The bodies, as read (2026-10-04)

| body | ref (tip) | its own files |
|---|---|---|
| main | `main` `8b30e6e1` | waves 1 and 3, LEB: 22 files (`Arith/{FalconerFan,NoAffine}`, `Plane/{AeColouring,ArcMap,Basic,Chord,CircleColouring,Closure,DensityPoints,Diameter,Lens,LocalMap,LocalMapExamples,LocalStructure,RingBand,RingGerm,SixFragment,Tiles,UnitAvoiding,UnitPairs}`, `Topology/{LebesgueCovering,SpernerGrid}`) |
| w2 | `origin/fs131-w2` `9f54be3d` | 13 files (`Arith/{Dyadic,FalconerField,PlaceHom}`, `Instances/FalconerOrbit`, `Plane/{CPColouring,Cover,CoverExamples,FalconerReduction,MaximalCover,Slack,Stationary,Suprema,YesLimit}`) |
| w4 | `origin/fs131-w4` `f1f26a8a` | the K4 skeleton and its fill: `Plane/{SVMap,StuckChain}`, `Plane/ValidMap/{Basic,BaseSteps,Contact,UnitArc}` |
| ww | `origin/fs131-ww` `89a4aad0` (E3's NiceAt repair) | `Plane/Woodall/{Basic,Collar,Merge,NoFourFive,Steps}`, over the K4 skeleton at fork time |
| w3b | `fs131-w3b` `167a2a74` (local tip; `d8a3177f` on `origin` plus a merge of `main`) | `Plane/LocalStructure` (+1,396: `localSectors`, `BranchGerms`, `IsSectorChart`), `Plane/RingGerm` (+131) |

**Duplicates resolved.** The K4 files on `fs131-ww` differ from `fs131-w4`'s only by w4's later *additions* (294 and 352 lines deleted,
none added, in `ValidMap/Basic` and `SVMap`): every K4 definition Woodall reads is w4's, unchanged. The w3b diff against `main` adds
definitions and changes none. So one predicate is counted once, at its defining body.

### 1.3 The instrument

`tools/fs131_qa2_census.py` — imports QA1's parser (`tools/fs131_qa1_decls.py`, unedited) and, over the five bodies' own files, lists
every **predicate** (a `def`/`abbrev` whose type ends in `Prop`, by binders, arrows or pattern matching; every `structure`, `class`,
`inductive`), and for each the declarations that take it as a hypothesis — in any binder, or as an antecedent of the conclusion's arrow
chain — flagging **refutation-shaped** ones (final target `False`), and the declarations that conclude it (candidate inhabitants) or its
negation (adversaries). `--self-test` plants fifteen controls (a pattern-matching `Prop` def, which the first run missed — `Arc.Nondegenerate`,
`Arc.IsUnitArc`, `Arc.InitialPiece` — and a longer name that must not match among them). **Negative controls watched**: with the arrow
chain's antecedents dropped in a copy, the self-test fails naming "arrow-antecedent refutation missed"; with implicit binders excluded,
it fails naming "implicit binder missed"; restored, it passes. Outputs: `data/fs131/qa2/{preds.tsv,uses.tsv,predsigs.jsonl}`.

**Its limits, stated**: textual (no elaboration); a predicate is matched by its last name component, so a short common name can
over-match (never under-match inside a body's own files); Prop-valued hypotheses that are *not* named definitions (inline `dist x y = 1`,
angle bounds) are outside a definition census, and are read by hand in the refutations of Stage 2.

### 1.4 The census, in numbers

2,291 declarations parsed; **140 predicates** (173 before the 31 duplicate K4 copies on `fs131-ww` and 4 on w3b are merged: 136 distinct);
**about 105 of them are taken as a hypothesis** by at least one declaration (1,114 hypothesis uses); **20 appear in a refutation-shaped
declaration**, across **24 distinct refutation-shaped theorems** (the w3b copies of five main theorems counted once):

| body | refutation-shaped theorems (the census's) |
|---|---|
| main (and w3b's copies) | `GoodAt.not_tile_subset_ball`, `coneAt_interiors_disjoint`, `circ_gap_false` (LocalStructure); `overlap_false`, `Valid.false_of_crossing` (RingGerm) |
| w2 | `not_falconerFan_five_of_hom_slack` (FalconerField) |
| w4 | `pair_i`, `anti` (BaseSteps, `sorry`); `nb4p` (UnitArc, `sorry`) |
| ww | `false_of_changePt_landing`, `false_of_collars_closed`, `woodall_step4`, `not_woodall_step4_two_thirds`, `townsend_lemma` (Collar); `SectorsAt.false_of_ncard_le_two_on_arc` (NoFourFive); `step5_lt`, `step6`, `false_of_four_le_sectors`, `aeMap6_normal`, `aeMap6_merged`, `aeMap6`, `aeMap6_of_condition5`, `woodall_thm6` (Steps) |

**Order of work (my choice, brief § What is yours to decide)**: Stage 2 the refutation-shaped theorems and every predicate they assume
(the scan skips them, so nothing else guards them); Stage 3 the carriers and predicates of the non-refutation theorems, by number of
hypothesis uses (a predicate assumed by many theorems first), the rest sampled with the rule stated there; Stage 4 wave 4's skeleton
statements against their rows; Stage 5 the verdict.
