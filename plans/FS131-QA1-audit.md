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
