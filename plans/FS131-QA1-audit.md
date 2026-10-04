# FS131-QA1 — the quality of the backlog's Lean so far: an audit (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA1-quality-audit.md`. Read-only toward every `Proofs/` file, worktree and branch; every finding is a
recommendation routed through Keryx. Code read with `git show <ref>:<path>` at the refs named below.*

## Theorems this phase proved

None. An audit proves nothing; it reads statements against rows and measures code.

## Stage 1 — SAVED

### 1.1 The brief's quotations (standing rule 3)

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "for the experiment."* — and: *"What does the general quality of the code look like so far? I'll authorize another special case auditor for what we've" | `plans/FS131-close-inventory.md` | **matches**, line 826, verbatim (a mid-sentence excerpt; the brief says so by its truncation) |
| 2 | "**Read the final statement aloud against the informal claim.** The one gate item no automation replaces, and the one that catches" | `CLAUDE.md` § The standard of evidence above rung B | **matches**, verbatim; the brief's continuation "proving the wrong theorem." also matches |

No slip.

### 1.2 The five bodies, as they stand (refs read 2026-10-04)

| body | ref (tip) | what is its own | own Lean lines | `sorry` (own files) |
|---|---|---|---|---|
| wave 1 | `main` (landed at `d59ffcdf`; tip `288e6136`) | `Plane/{Basic,UnitPairs,AeColouring,ArcMap,UnitAvoiding,DensityPoints,Chord,Closure,Diameter}`, `Arith/{FalconerFan,NoAffine}` | ≈ 1,900 | 0 |
| wave 2 | `fs131-w2` `8b41f936` (fork `28a76106`) | `Plane/{Cover,Suprema,CPColouring,MaximalCover,Slack,Stationary,FalconerReduction,YesLimit,CoverExamples}`, `Arith/{PlaceHom,FalconerField,Dyadic}`, `Instances/FalconerOrbit` | 7,872 | 119 occurrences (110 declarations) |
| wave 3 | `fs131-w3` `5537611a` (fork `da5303b4`) | `Plane/{LocalMap,LocalMapExamples,CircleColouring,LocalStructure,Tiles,RingGerm,RingBand,SixFragment,Lens}`, `Chord` +19 | 9,371 | 5 (4 declarations) |
| wave 4 | `fs131-w4` `6bd00949` | the K4 skeleton `Plane/{ValidMap/{Basic,Contact,UnitArc,BaseSteps},SVMap,StuckChain}` (commit `f620977c`) and its fill | 3,598 | ≈ 54 in own files |
| Woodall | `fs131-ww` `97d291ec` | `Plane/Woodall/{Basic,Collar,NoFourFive,Steps}` on the same K4 skeleton | 1,978 | 20 in own files |

**The branch graph matters for merging.** Waves 4 and Woodall both forked from wave 3's *skeleton* (`05cb0a3e`, K3b's report), so each
carries the wave-3 skeleton files (`Tiles`, `RingGerm`, `LocalStructure`, `RingBand`, `SixFragment`, `Lens`, at their `sorry` state) and
the K4 skeleton (`ValidMap/*`, `SVMap`, `StuckChain`, at `f620977c`). Since the fork, wave 3 changed statements in those skeleton
files (144 removed lines that are not `sorry`: `RingGerm`'s GERM-S family, `Tiles`, `Lens`, `RingBand`'s `W_eq` and (vi)), wave 4 rewrote
part of the K4 skeleton (+2,104 / −35), and Woodall added only its own four files on top of the K4 skeleton as it was. Stage 4 measures
what this does to a merge.

The worktrees carry uncommitted edits (`fs131-w2`: `FalconerReduction.lean`, `scripts/Axioms.lean`; `fs131-ww`: `NoFourFive.lean`);
this audit reads the committed tips only and says so wherever it matters.

### 1.3 The instrument

`tools/fs131_qa1_decls.py` — a textual declaration parser (no elaboration) over `git show <ref>:<path>`: kind, name, line, signature,
docstring presence, body length, and counts of `sorry`, bare `simp`, `simp_all`, `nlinarith`, `decide`, `native_decide`, `omega`,
`aesop`, `grind`, `maxHeartbeats`, `have _ :=`. `--self-test` plants fourteen controls (a docstring line beginning with a keyword among
them — the first run read `class of …` docstring lines as four phantom declarations, and the control now guards it). **Negative control
watched**: with the `simp only` guard broken in a copy, the self-test fails naming "simp only / comment counted as bare simp"; restored,
it passes. Dumps: `data/fs131/qa1/decls-{w1,w2,w3,w4,ww}.jsonl` (the w4 and ww dumps include the shared skeleton files; per-body
figures below count own files only).

### 1.4 The sample, and how it was chosen

Rule: in each body, the theorems that are **proved** (no `sorry` in their own proof) and **central** — the ones a later row or the
frontier cites as the wave's product (N-EASY, YESLIM, FS106-EQ, FS106-COMP; QFREE4, RING-Q-PRIME-S, RINGBAND, ECHO; TS-T, ISO; Woodall's
step 4, Townsend's lemma, E1-SEE), then at least one theorem resting on each named hypothesis (`Row130M1`, `Voronov11`, `hR78`/`hR88`),
then statements whose rows carry a ruling or an erratum (COVER-SC corrected; FACE-SHARP; NOPERLAW). Waves 4 and Woodall have few proved
row theorems, so their sampled statements are read as statements whatever their proof state (a statement is what the kernel will be held
to). The list, 20 theorems: wave 1 `AeColouring.dist_ne_one`, `dist_ne_one_of_mem_of_mem_closure`, `falconerFan_chromaticNumber`; wave 2
`chromaticNumber_plane_le_chiM0`, `chromaticNumber_plane_le_six_of_fragments`, `seven_le_chiM0_iff`, `forall_mu_six_lt_one_iff`,
`IsMaximalCover.semiconcaveWith`, `falconerFan_five_mem_eight`, `CPColouring.forcedSet_eq_zero`, `exists_face_fails`; wave 3 `qfree4`,
`ringQPrimeS`, `ringband_v`, `echo`, `IsTile.dist_lt_one`; wave 4 `ArcMap.ts_t`, `iso`; Woodall `woodall_step4`, `townsend_lemma`,
`not_mem_coloursAt_of_dist_eq_one`. (21 listed; any not reached is named as such in Stage 3.)

## Stage 2 — SAVED

### 2.1 What was read

Every definition in the foundation modules, each unfolded to Mathlib's: wave 1 `Plane/Basic` (`e`, `ringPt`, `arcLength`),
`Plane/UnitPairs` (`unitPairSet`, `UnitPairsNull`, `densityRatio`, `densitySet`, `upperDensityAt`, `essSupport`, `pairSet`),
`Plane/AeColouring` (`AeColouring`, `chiM0`), `Plane/UnitAvoiding` (`phi`, `IsMUA`), `Plane/ArcMap` (`Arc`, `carrier`, `Nondegenerate`,
`IsUnitArc`, `ArcMap`, `Γ`, `interiorPts`, `region`, `IsTile`, `coloursAt`, `Valid`, `Covers`, `IsPlaneMap`, `Siamese`, `NonSiamese`,
`IsJordanDomain`, `Simple`); wave 2 `Plane/Cover` (all fourteen), `Plane/Suprema` (all fifteen), `Plane/CPColouring` (`shiftCol`,
`rotCol`, `CPColouring`, `RotationInvariant`, `chiCP`), `Arith/PlaceHom` (`IsUsablePrime`, `pureTranscendental`, `IsPlaceHom`,
`NoAffFieldHyp`); wave 3 `Plane/LocalMap` (all twenty-five), `Plane/LocalStructure` (`angleIcc`, `angleIoo`, `Arc.OnRing`),
`Plane/CircleColouring` (`CircleColouring`, `Lift`, `Good`, `step`, `hSum`, `h`, `LeftVal`, `RightVal`, `IsSwap`, `W`, `D`, `m`, `n₂`);
wave 4 `Plane/ValidMap/Basic` (all forty-two at `fs131-w4`); Woodall `Plane/Woodall/Basic` (`annSector`, `Rim`, `collar`, `CollarAt`,
`SectorsAt`, `WoodallMerged`, `WoodallNormal`).

### 2.2 Verdict on the definitions

**No trap of the sinking kind was found.** Every carrier the rows quantify over is inhabited by a named object in the same module
(`ArcMap.const`, `halfDisc`; `sq9 : AeColouring 9`; `sq9CP`; `unitArcPlane`; `bowtie`; the one-colour plane for `SectorsAt` and both
Woodall normal forms), and the degenerate carriers are refuted where they should be (`IsEmpty (AeColouring 1)`, `IsEmpty (CPColouring 1)`,
the adversaries `not_unitPairsNull_ball_two`, `halfDiscMono`). The home-made notions agree with the standard ones where a standard one
exists: `IsUsablePrime` (`𝔭` maximal, `#(𝓞_F/𝔭) ≡ 3 (mod 4)`) is exactly the Notation's "q ≡ 3 (mod 4), i.e. p ≡ 3 (mod 4) and f odd";
`CPColouring` as a shift-invariant law on `ℂ → Fin k` is faithful to D-CP because every clause of D-CP reads finite-dimensional
marginals only; `densitySet`/`upperDensityAt` use closed balls and `𝓝[>] 0`, Mathlib's own Besicovitch form; `IsJordanDomain` and `Simple`
read the row's "open disc whose closure meets each other tile's closure in a connected set or not at all" exactly (the empty set is
preconnected); `CircleColouring.h` and `Lift.m` use `Int` division, which is Euclidean (floor for a positive divisor), as the rows'
`⌊·/3⌋` asks, and `hSum` is a multiple of 3 by telescoping so `h` loses nothing.

Findings, each small:

| # | where | finding | class |
|---|---|---|---|
| D1 | `Plane/ArcMap.lean` `Arc.Nondegenerate` | docstring "an arc of positive length that is not a whole circle"; the definition `θ₁ ≤ θ₀ + 2π` admits the whole circle. Harmless (a whole circle is a legitimate boundary), but the docstring is wrong | D: fix the docstring (or make it `<`) |
| D2 | `fs131-w2` `Plane/Cover` vs `fs131-w3` `Plane/LocalMap` | two vocabularies for one notion: `essMulticolour C x` (w2) and `F.essColours w` (w3) are definitionally `essMulticolour F.region w`; `IsContactFor` reads `closure (densitySet A)` (w2) where `SaturatedAt` reads `essSupport A` (w3) — equal for measurable `A` (a density point is a support point; a support point has density points nearby), with no bridge lemma in either branch | C: before wave 3 lands, define `essColours := essMulticolour F.region` and prove `closure_densitySet_eq_essSupport` once (an implementer) |
| D3 | `fs131-w2` `Plane/Cover.lean:79` `unitShadow` vs K4 `Plane/ValidMap/Basic.lean:76` `shadow` | the same set `{z | ∃ y ∈ T, dist z y = 1}` under two names in branches that will merge | C: keep `unitShadow`, make `shadow` an `abbrev` or delete it at wave 4's merge |
| D4 | `Plane/ArcMap.lean` `Siamese` vs `fs131-w3` `UnitNear` | the cross-distance clause is inlined in `Siamese` and named `UnitNear` a wave later | D: restate `Siamese` with `UnitNear` when convenient |
| D5 | K4 `Plane/ValidMap/Basic` `Condition5` | reads the presented `F.arcs`, not `Γ`: a map with a spurious unit arc (one colour on both sides) fails `Condition5` though its boundaries meet unit circles finitely. A theorem with `hC5 : F.Condition5` is so slightly narrower than "under Condition 5" read on boundaries; the docstring of `RingArcsWithin` already names presentation-dependence | D: note it in `Condition5`'s docstring; nobody need change a statement now |
| D6 | `fs131-w3` `Plane/LocalMap` (module doc) | "a tile of colour `c`" is read as the colour class `F.region c` wherever a row speaks of its closure, cone or germ. For existential uses this is exact by local finiteness (finitely many tiles near a point of the domain; a cone of a finite union is the union of cones); universal uses keep `TileOf` (`InType`, `OutType`, GERM-S's "every tile of `p` of colour `c`"). Checked in the sampled statements of Stage 3 | none — a good, documented ruling |
| D7 | `fs131-ww` `Plane/Woodall/Basic` `WoodallMerged`, `WoodallNormal` | both quantify over every `SectorsAt` presentation, so at a point with none they say nothing; `ArcMap.exists_sectorsAt` (still `sorry`, `Woodall/Steps`) is what makes them bite. The final theorems' statements do not depend on this, so it is not a fidelity risk, but `exists_sectorsAt` is load-bearing and should be proved before the chain's step lemmas are trusted as meaningful | C: keep `exists_sectorsAt` first in Woodall's order (implementer) |
| D8 | K4 `Plane/ValidMap/Basic` `IsQArc`, `InContact`, … | the ring-arc kinds do not require the two side colours to differ. Under `Valid` with the side colour carried at the centre a same-colour arc is impossible (the circles about nearby points of that colour sweep the arc's neighbourhood), so nothing is lost; noted so nobody "fixes" it into a hypothesis | none |

## Stage 3 — SAVED

### 3.1 Statement fidelity: twenty statements read against their rows

Each formal statement was read against the row's "Statement as filed", its "Not claimed" line, its errata and merge notes
(`plans/LEAN-BACKLOG.md`), and the derivation entry where the row is terse, with every definition unfolded to Mathlib's (Stage 2).
"Proved" means no `sorry` in the declaration's own proof at the committed tip, not its whole dependency cone.

| # | body | row | declaration (`path:line` at tip) | proved | verdict |
|---|---|---|---|---|---|
| 1 | w1 | FS111-V0-ID1 | `Plane/DensityPoints.lean:168` `AeColouring.dist_ne_one` | yes | **same** |
| 2 | w1 | FS129-SR2-CLOSURE | `Plane/Closure.lean:29` `dist_ne_one_of_mem_of_mem_closure` | yes | **same** (open `U`, `UnitPairsNull U` is the row's `(Leb ⊗ σ)` condition read through `arcLength`) |
| 3 | w1 | FS129-SA1-FALC-DICHO-K | `Arith/FalconerFan.lean:139` `falconerFan_chromaticNumber` | yes | **stronger**: second clause unconditional (the row's `χ(H) = k − 1` is idle, docstring says why) |
| 4 | w2 | N-EASY | `Plane/YesLimit.lean:104` `chromaticNumber_plane_le_chiM0` | yes (its `exists_motion` proved) | **same**: `(unitDistance ℂ).chromaticNumber ≤ chiM0` |
| 5 | w2 | FS116-O1-YESLIM | `Plane/YesLimit.lean:139,144` `chiM0_le_of_fragments`, `chromaticNumber_plane_le_six_of_fragments` | own body yes; rests on `muZero_eq_one_of_fragments` (`sorry`) and `chiM0_le_iff_muZero_eq_one` (`sorry`) | **same** (the row's `k ≥ 1` idle; "valid `k`-coloured fragment on a closed disc of radius `R`" is `∃ F p, F.Covers p R ∧ F.Valid`) |
| 6 | w2 | FS106-EQ | `Plane/Slack.lean` `chiM0_le_iff_muZero_eq_one` (1154), `chiM0_le_iff_chiCP_le` (1158), `muZero_eq_one_iff_tendsto` (1162), `chiM0_le_iff_periodic` (1181), `seven_le_chiM0_iff` (1208) | (c)⟺(d), (e), the six clause proved over `sorry` children; (a)⟺(c) `sorry` | **same**, (a) ⟺ (b) over the named `Row130M1` (ruling 22). `lim_{ε→0} µ₆(ε)` read as `⨆ ε > 0, mu 6 ε` — exact, `µ₆` antitone (proved: `antitone_mu`); "leaving density ≤ δ uncovered" read as covered upper density `≥ 1 − δ` — exact for periodic families |
| 7 | w2 | FS106-COMP (2nd clause) | `Plane/Slack.lean:1358` `forall_mu_six_lt_one_iff` | yes (both directions' lemmas proved) | **same**, against the named `Voronov11` (D-VPROP: no `f : ℂ → Fin 6` proper on `[1 − ε, 1 + ε]`, no measurability — the proof closes the classes to make them measurable, as it must) |
| 8 | w2 | FS111-M-COVER-SC (2nd clause) | `Plane/MaximalCover.lean:713` `IsMaximalCover.semiconcaveWith` | yes | **different, by ruling** (items 18–19, 57, 72): constant `(1 + L²)^{3/2}` on `L`-Lipschitz pieces, curvature tested from below; the row's constant `1` is refuted in the library (`not_forall_semiconcaveWith_one` on R7) |
| 9 | w2 | FS129-MA2-FALC-HOSTS (iii) | `Arith/FalconerField.lean:259` `falconerFan_five_mem_eight` | yes | **stronger form over a hypothesis carrying the row's object** (ruling 22): any lattice `Λ` whose four-colour-forced differences lie in `8Λ` (`hR78`); de Grey's lattice appears nowhere — the row is its instance once the lattice and row 78 are in Lean |
| 10 | w2 | FS129-MA2-FALC-HOSTS (iv) | `Arith/FalconerField.lean:274` `falconerFan_five_mem_P` | yes | **a frame, weaker than it reads** (ruling 22 accepted the frame; this sharpens what it holds): `P : Set ℂ` and `Per : Prop` are free variables, so `hR88`, `hR88per` are satisfiable by `P := forced set`, `Per := True`, and the kernel content is "a fan's `t − a` is a non-zero forced difference of `R`". The row's fields, `R = ℤ[U_F]`, `P = R ∩ 𝔓⁴` and periodicity appear only when someone instantiates them. Not wrong; must not be filed as "HOSTS (iv) held over row 88" without that sentence. Fix: a docstring line now, and an instance corollary when the rings exist (planner) |
| 11 | w2 | FS129-OA1-NOPERLAW | `Plane/Stationary.lean:364,388` `CPColouring.exists_discrete_forcedSet`, `CPColouring.forcedSet_eq_zero` | yes | **same** |
| 12 | w2 | FS121-V5-FACE-SHARP (failure half) | `Plane/Slack.lean:1486` `exists_face_fails` | yes | **same, with ruling 86's two added hypotheses** (`2ρ < 1`, `g² + ρ² < 1`; both shown necessary by counterexamples in the ruling); `g < 1` follows from them |
| 13 | w3 | FS116-N1-QFREE4 | `Plane/RingGerm.lean:861` `qfree4` | yes | **stronger**: at every `k`, `ncard (coloursAt p) + 2 ≤ k`; at `k = 6` with `h4` exactly the row's "four colours and no more"; it claims something at `k ≥ 7`, where the row's not-claimed line is silent by design (the docstring says the argument reads two absent colours) |
| 14 | w3 | FS116-RING-Q-PRIME-S | `Plane/RingGerm.lean:1907` `ringQPrimeS` | yes | **same at six, stronger elsewhere**: the added `k ≤ ncard + 2` holds automatically at `k = 6` with four colours at `p` |
| 15 | w3 | FS129-SR1-RINGBAND (iv), (v) | `Plane/RingBand.lean:936,959` `ringband_iv`, `ringband_v` | yes | **same**: (iv)'s last clause adds "every point of `S` is a genuine change (left and right values differ)" — the row's `Σ` is a set of *change points*, and `CircleColouring.S` may hold idle points, so this restores the row's meaning (ruling 61 for the second conjunct); `Lift.jump` allows `0` at an idle point for the same reason |
| 16 | w3 | FS116-N1-ECHO | `Plane/RingGerm.lean:1583` `echo` | yes | **stronger hypotheses-wise, class-form conclusion**: no disc hypothesis at all (the row's "radius above 2"); conclusion `X ∈ coloursAt (2w − p)` (closure of the class). With the row's disc, `2w − p` is in the domain and the class reading equals the tile reading (`mem_coloursAt_iff_exists_tileOf`). The hypothesis `_hess : F.IsEssBoundary …` is kept for fidelity and unused (D) |
| 17 | w3 | FS116-V5-NE1 | `Plane/Tiles.lean:52,65,82,88` `ne1_region`, `IsTile.subset_ball`, `IsTile.closure_subset_closedBall`, `IsTile.dist_lt_one` | yes | **same/stronger** (class closure for the first clause; diameter pointwise and strict) |
| 18 | w4 | FS106-TS-T | `Plane/SVMap.lean:268,336,348,357` `AeProperRegions.exists_three_le_multicolour`, `ArcMap.ts_t`, `ts_t_trichromatic`, `ts_t_degree_three` | first `sorry`; the rest proved over it | first two clauses **same**; **Condition-5 and Condition-6 clauses weaker than the row** — `Condition5` is replaced by `h3 : ∀ x, ncard (coloursAt x) ≤ 3`, after which "trichromatic" is immediate; the row's Condition 5 ⟹ ≤ 3 colours is neither formalized nor a listed named hypothesis, and NB-4 (the docstring's source) gives it only for tight six-maps in `𝓜_K`, excluding four and five colours, not six. **Messaged to the coordinator** (correction owed) |
| 19 | w4 | FS112-ISO | `Plane/ValidMap/UnitArc.lean:543` `iso` | yes | **same, witness form**: one explicit valid fragment with every clause; "blocks a first-order away-bend" read as "the radial points beyond the arc's middle are at distance exactly 1 from the inner colour's class" (`¬ IsClear`), which is what blocks a lens from taking that colour — a reasonable reading, stated in the docstring |
| 20 | ww | FS106-WO (step 4) | `Plane/Woodall/Collar.lean:592` `woodall_step4` | yes | **same** (strictly above `2π/3`), with sharpness proved: `not_woodall_step4_two_thirds` (Townsend's counterexample) shows the `≥` form false, so the hypotheses at the boundary are satisfiable — the best possible non-vacuity evidence for a `False`-concluding lemma |
| 21 | ww | FS106-TW (the `π/3` lemma) | `Plane/Woodall/Collar.lean:766` `townsend_lemma` | yes | **same**, in the form its proof reads (cut angles finite, a seed arc `> π/3` on one side); the planner's read-back is in `plans/FS131-W-kernel-plan.md` |
| 22 | ww | E1-SEE | `Plane/Woodall/NoFourFive.lean:549` `not_mem_coloursAt_of_dist_eq_one` | yes | **same** (class form) — and the same fact as wave 3's `ne1_region` in contrapositive (Stage 4) |

**Tally**: 22 statements in 20 rows (21 listed in Stage 1 plus RINGBAND (iv) read beside (v)). Same or stronger: 17. Changed by a
recorded ruling and correct: 3 (COVER-SC, FACE-SHARP, RINGBAND (iv)). A frame that holds less than it reads, ruled but under-described:
1 (HOSTS (iv)). **Weaker than its row with no ruling that covers it: 1 (TS-T's Condition-5/6 clauses).**

**The class reading (Stage 2, D6) held up in every sampled ring statement**: existential uses (ECHO's conclusion, GERM-S's cones)
are exact by local finiteness, universal uses keep tiles (`TileOf` in GERM-S, `InType`, `OutType`).

**Correction to Stage 2, D2**: wave 2 already proves the bridge `essSupport_eq_closure_densitySet` (`Plane/Cover.lean:441`); what is
missing is that wave 3's `SaturatedAt` and `essColours` are not stated through wave 2's `essMulticolour` and `IsContactFor` (they cannot
be yet: wave 3 does not import wave 2). The fix at merge is to restate or bridge, not to prove anything new.

### 3.2 Merge collisions (found while reading; the full measurement is Stage 4)

`tools/fs131_qa1_dupes.py` (self-test: namespace tracking; **negative control watched** — with `end` no longer popping the namespace
stack the self-test fails naming `A.B.bar`) finds six fully qualified names declared in the own files of two branches. Lean refuses the
second as soon as `Proofs.lean` imports both modules, and four of the six have **different statements** under one name:
`Plane.framePt` (a `def`: w2 `Plane/Slack.lean:545` `x + e θ (−s + t i)` against K4's `Plane/ValidMap/Basic.lean:44`
`v + (x + y i) e α`), `Plane.dist_rot` (w2 `FalconerReduction.lean:603` against w3 `SixFragment.lean:349`), `Plane.eq_norm_mul_e_arg`
(w2 `Cover.lean:487` against w3 `SixFragment.lean:145`), `Plane.e_add_int_mul_two_pi` (w3 `SixFragment.lean:108` against ww
`Woodall/NoFourFive.lean:294`); identical twice: `Plane.e_mul_conj_e` (w3 `Chord.lean:272`, ww `Woodall/Collar.lean:30`),
`Plane.abs_dot_le` (w4 `ValidMap/Contact.lean:350`, ww `Woodall/Collar.lean:389`). List: `data/fs131/qa1/dupes.txt`. Messaged.

Wave 3's seven statement changes in the shared skeleton files since waves 4 and Woodall forked (`ringband_iv`, `ringband_vi_periodic`,
`germS_absent`, `fiveRing_no_changePoint`, `echo`, `four_of_bothKind`, `four_of_bothKind_simple`) are **used by neither** wave 4's nor
Woodall's own files (checked by name over their own files), so wave 3's fill will not break them semantically; the merge risk is the six
names above and the append-only files (Stage 4).
