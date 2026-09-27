# FS-106 — theorems proved outside the kernel (the derivation file)

*Filed by the close planner FS106-C (de Bruijn, Opus 5.5), 2026-09-27, from the records `plans/FS106-V-verification.md` (V, with § Continuation
— FS106-V2 and — FS106-V3: one sighted line), `plans/FS106-VB-verification.md` (VB, blind to V and the plan), `plans/FS106-TS-derivation.md`
(TS), `plans/FS106-TQ-derivation.md` (TQ; TS and TQ blind to each other until their verdict stages), `plans/FS106-SB-verification.md` (SB, blind
on TS until its stage 3, `2c5fabef`), `plans/FS106-QB-verification.md` (QB, blind on TQ until its stage 3) and the advisors' records
`plans/POROS-2026-09-26-fs106-regular-half.md` (A) and `plans/POROS-2026-09-27-fs106-close-and-fs107.md` (A2). Reconciliation:
`plans/FS106-regular-half.md` §R-close stage 1. Notation: `data/fs106/claims.md` §0 (D-VPROP, D-VMC, D-SV's Conditions 1–8, D-M, D-CP, D-NF,
D-SLACK, D-AEMAP, D-MU); `µ₆⁰` is the supremum over tight families (TQ §3, QB §1.2): the supremum of the upper density of `C₁ ∪ ⋯ ∪ C₆` over
disjoint measurable classes with `Leb ⊗ σ`-null unit pairs. "Region-only" means a step that reads no colour at a boundary point.*

**The milestone's result in one paragraph.** The regular half is verified and transferred almost everywhere, except at named steps, and the
measurable question is restated exactly as the stability of Voronov's theorem. `[Voronov2023]`'s three theorems hold after local repairs (two
minds, one blind); Theorem 1.3 uses closedness once, as compactness giving a band. The almost-everywhere forms: slack colourings need seven
(given Thm 1.3); polygonal colourings need seven except at one edge case (`d = 2`), their weakest link being the transplanted bicycle for Lemma 3 at
`√3 ≤ d < 2`, and `[SokolovVoronov2025]`'s printed chain needs three repairs on the way (Observation 1 avoided, fills before Lemma 4, the
same-multicolour distance); locally finite convex tilings need seven; nice maps need seven; maps need six modulo Woodall's fill of Townsend's
step (c); closed classes are the tight question itself; S–V's Question 2 is a GAP at four named steps. The quantitative route gives
`χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1`, with no MR and no Voronov — a compactness restatement that moves no value (QB, G21) and makes a refutation a
sequence of *periodic grid-square* colourings with vanishing holes. The index method of Voronov and S–V dies at one local picture: a unit-arc
interface facing a bowtie. *Not theorems, recorded here:* `[Townsend1981]` prints no proof [reading, three readers]; the manuscript read as
Townsend's is his 1979 text, not `[Townsend2005]`'s [reading, V3].

## §1. The printed theorems, verified first-hand

**FS106-V23 — `[Voronov2023]` Theorems 1.1, 1.2 and 1.3 are proved by the print after local repairs, none changing a statement except Prop. 3.4's hypothesis. [hand; two minds, one blind: V; VB]**
*Proof:* V §2.1 (repairs R1–R10: R3, Lemma 2.2's limit step is wrong as printed, the fills move colours; R5, Prop. 3.4's hypothesis cannot hold
and Lemma 6.1 uses it outside it); VB §2a (Lemma 2.2 without recolouring by nested fills; Prop. 3.4's disc-properness false for the band, a
circle-only matched-arc repair; the bicycle's arc identification by additivity of the path index). *Proof verdict:* TRUE by both; the same
repairs reached independently (A stage 4: Lemma 2.2's limit after hole fills; Prop. 4.1's sign reversed with a swap excluded; the bicycle needs
`α < ε/2`). *Rests on it:* C-AE-SLACK, TQ-EPS2's lower bound, row 40, `CLAUDE.md` § The aim link 4. *Prior art:* the theorems are
`[Voronov2023]`'s (an unrefereed preprint); the repairs not found in print (its five citing works hold no erratum, P §PA.1). *Kernel:* stub —
FS-101; C-CS-1's compactness step has row 41's limit lemma as its kernel neighbour.

**FS106-CS — Voronov's proof of Thm 1.3 uses the closedness of the six sets exactly once, at the limit pair, where it is equivalent to "a compact set that does not realize 1 avoids some band"; and Thm 1.3 is equivalent to "for every ε > 0 no six-colouring of U₃(0) is proper for [1 − ε, 1 + ε]". [hand; two minds, one blind: V; VB]**
*Proof:* V §2.1 (C-CS-1, C-CS-2); VB §2d. *Proof verdict:* TRUE by both. *Rests on it:* C-AE-CLOSED's reduction; TQ-EPS2 (its input);
FS-107's frame (the band is what Voronov consumes). *Prior art:* implicit in `[Voronov2023]` p. 14; not stated there as an equivalence.
*Kernel:* stub — the compactness step, with row 41's limit lemma.

**FS106-ROW40 — Row 40's "the whole family is ≥ 7 at every scale" needs only `[Voronov2023]` Thm 1.3: `tools/celllat.py`'s `G(p)` joins closed cells realizing distance 1, so a proper colouring's classes are six closed sets covering the plane, none realizing 1. [hand; one mind: V; A agrees]**
*Proof:* V §2.1 row C-ROW40. *Proof verdict:* TRUE. *Rests on it:* `LEDGER.md` row 40's condition. *Prior art:* the cell family is ours
(M43); the theorem used is `[Voronov2023]`'s. *Kernel:* declined — the family's sevens are tools-grade, and Thm 1.3 is FS106-V23's stub.

**FS106-SVL3 — `[SokolovVoronov2025]` Lemma 3's printed three-curve proof covers exactly 1 < d < √3 (at √3 Fig. 5's relation graph degenerates, above it is bipartite); the transplanted bicycle (Voronov's Thm 1.2 run on the curves γ(u₁), γ(u₂)) proves it for 1 ≤ d < 2. [hand; the gap two minds, one blind: V, VB; the repair one mind, sketch: V2]**
*Proof:* V §3.1 ([hand] at `√3`; float pairings `data/fs106/fs106-v/sv_lemma3_triangle.py`, [measured]); V2 stage 3 row SV-L3 (the
transversality written; constants not computed). *Proof verdict:* the gap TRUE by both (one gap, A stage 4); the repair unconfirmed — **the
weakest link of "polygons need seven"** (A2 §1b.1). *Rests on it:* FS106-SV2, FS106-AE-POLY, FS106-AE-CONV. *Prior art:* none found. *Kernel:*
declined until a second mind (a sketch is not a kernel target).

**FS106-SV2 — Polygonal colourings of the plane need seven colours (`[SokolovVoronov2025]` Thm 2), by the printed chain repaired: Prop. 7/8 region-only (Observation 1 not used); then fill every non-simply-connected region in the bounded disc; then Lemma 4 with its eleventh point on the outer frontier of u's {4,5,6}-component and the same-multicolour pair at distance in (1, 2); except one named edge case, two same-multicolour points antipodal on ω (d = 2). [hand; the chain two minds, one blind: the V line, SB; SV-L3's repair one mind, sketch]**
*Proof:* V2 stage 3 (rows Prop. 8, SV-L4, SV-2); V3 stage 4 (Prop. 7/8 region-only at a run apex); SB §2.1 (A1–A12, blind); TS §3 (Prop. 7
region-only, sighted); A2 §1b.1 (the order Prop. 8 → fills → Lemma 4; fills delete regions inside holes, create no vertex, keep degree ≤ 3 and
polygonal boundaries; H3 keeps properness). *Proof verdict:* TRUE; its `d = 2` exception is struck at FS-110's close (row 134: S–V Cor. 1 a.e. with no
`d = 2` exception, FS110-CB and FS110-CD, both blind; FS110-CE's Antipodal Lemma), and SV-L3's sketched repair is now FS110-CB's full derivation. A12 — the eleventh point needs simply connected regions, which Prop. 8's recolouring can destroy — found by V (l. 172 (b)) and
SB blind, closed by the fills. *Rests on it:* FS106-AE-POLY, FS106-AE-CONV, `CLAUDE.md` link 4. *Prior art:* the theorem is S–V's; the
repairs not in print. *Kernel:* stub — FS-101, after `d = 2` and a second mind on SV-L3.

**FS106-SV1 — `[SokolovVoronov2025]` Thm 1 (maps with no unit-arc boundaries and no trichromatic vertex of degree > 3 need seven) is a GAP at Prop. 19's fills under Condition 6 — a fill at a bichromatic vertex 1,2,1,2 can create a trichromatic vertex of degree 4 — plus SV-2's residuals; SV-L4 (a) is closed by TS-T. [hand; one mind for the gap's location: V2, TS]**
*Proof:* V2 stage 3 rows Prop. 19, SV-L4 (a), SV-1; TS §2.4, §3 row C-AE-FA. *Proof verdict:* GAP, named. *Rests on it:* FS106-AE-FA; the
stub for Woodall's merge (V3 stage 4: his step 3 removes the bichromatic vertices of degree ≥ 4, except his "cone", which nothing excludes at
six colours). *Prior art:* S–V's theorem; the gap not in print. *Kernel:* declined (a GAP).

**FS106-SVDEF — Printed defects of `[SokolovVoronov2025]`, each with its repair: Obs. 1 is a GAP as a "without loss of generality", avoidable (region-only replacements); Prop. 16 is MISSTATED (TRUE with "the exterior of ω near y lies in A(u)"); Prop. 12 has a gap at simultaneous colour changes (a swap), closed by Lemma 1 under Cond. 5; "Lemma 8" is Prop. 8; Lemma 2's "cannot fit" means "cannot cover"; the appendix's colours "1, 2, 3" are "4, 5, 6", its same-multicolour pair needs distance in (1, 2), and its eleventh point needs simply connected regions. [hand; one mind each: V2 (Obs. 1, Prop. 16), SB (the rest); A12 two minds, one blind: V, SB]**
*Proof:* V2 stage 3; SB §2.1 A5, A10, A11, A12, §3.3. *Proof verdict:* TRUE (each a reading plus a repair). *Rests on it:* FS106-SV2,
FS106-SV1; `BIBLIOGRAPHY.md`'s `[SokolovVoronov2025]` entry. *Prior art:* none (the paper has one citing work, P §PA.2). *Kernel:* declined.

**FS106-TW — `[Townsend1981]` states "Every 5-coloured map in the plane contains a monochrome unit" and a lemma (constant π/3), with no proof of the theorem; the lemma is TRUE. Townsend's 1979 manuscript proves the ⅓π lemma, his Thm 2 and the Corollaries of Thms 3–4 region-only (Thm 4 itself GAP in its generality, petal-shaped sets; its Corollary repaired, sketch), and his Thm 5 (maps need six) is a GAP at simplification (c), which Woodall's steps 2, 3, 5 fill. [hand; "no proof": three readers (V, VB, V3); the lemma one mind in general (V3), two on a one-sided annulus (VB blind); the manuscript one mind (V3); the fill in outline]**
*Proof:* V3 stage 1 (lemma (L) supplies two steps; the ⅔π counterexample to Woodall's lemma checks, is sharp and uses a unit-arc boundary),
stage 3–4 (the fill; V3's correction: Woodall's steps 1, 4, 6 checked, 2, 3, 5, 7 in outline, 8 not); VB §3b. *Proof verdict:* as stated.
*Rests on it:* FS106-AE-MAP6; `CLAUDE.md` link 4's "maps need six". *Prior art:* the theorem is Woodall's (1973), re-proved by Townsend;
`[Townsend2005]` (the published text) unheld, and the manuscript may differ from it. *Kernel:* declined until the fill is walked.

**FS106-WO — `[Woodall1973]` Thm 6 (maps need six): step 6 is a GAP (it rests on the assertion Townsend's ⅔π counterexample refutes), repaired by Townsend's ⅓π lemma; Woodall's step-4 lemma holds for arcs strictly longer than ⅔π, by lemma (L). [hand; one mind: V3; steps 2, 3, 5, 7 in outline, step 8 unchecked]**
*Proof:* V3 stage 3. *Proof verdict:* as stated. *Rests on it:* FS106-TW's fill; the stub for Woodall's merge. *Prior art:* the gap is
Townsend's observation (`[Townsend1981]`); the repair's assembly not found in print. *Kernel:* declined.

**FS106-TH — `[Thomassen1999]` Thm 1 (nice colourings of the plane need seven) holds in the plane, the count repaired, and for locally finite G it follows from `[Voronov2023]` Thm 1.3 in two lines; niceness is used at two steps and no boundary colour is read. [hand; one mind in full (V3), with a partial reading (TS, the clique step) made before V3 committed]**
*Proof:* V3 stage 2; TS §3 row C-AE-NICE. *Proof verdict:* TRUE. *Rests on it:* FS106-AE-NICE. *Prior art:* Thomassen's theorem. The OCR's
"radius 2" (read ½) and "12k + 3" need the page images (V3). *Kernel:* declined.

**FS106-PR — `[Pritikin1998]`'s six-colouring of all but a closed set of density ≈ 1.61·10⁻⁴ of the plane is correct. [hand; one mind: V3]**
*Proof:* V3 stage 3 (a hand check of his 6197.08). *Proof verdict:* TRUE. *Rests on it:* FS-107's W side (a baseline, superseded in density
by `[Parts2020c]`'s `δ₆ = 1.430172·10⁻⁴`). *Prior art:* Pritikin's. His phrase is "\"nearly\" all", not "almost all". *Kernel:* declined.

**FS106-CO — `[Coulson2004]`'s printed theorem is six colours for tile-based colourings by convex tiles with areas bounded below ("A tile based colouring with excluded distance D must employ at least 6 colours", Thm 3.5); Props. 3.2–3.3 verified, 3.4–3.5 rest on figures not viewed. [hand + reading; SB read in full; V3 verified 3.2–3.3]**
*Proof:* SB §2.2, §3.3; V3 stage 3 table. *Proof verdict:* 3.2–3.3 TRUE; the rest unverified. *Rests on it:* the correction to
`CLAUDE.md` link 4 (Coulson is a tile theorem, not a map theorem); FS106-AE-CONV supersedes it for locally finite convex tilings. *Prior art:*
Coulson's. *Kernel:* declined.

## §2. The regular classes almost everywhere

**FS106-AE-SLACK — A Lebesgue-measurable colouring of ℝ² with slack ε > 0 (monochromatic pairs at distances in [1 − ε, 1 + ε] of Leb ⊗ Leb measure 0, or the same at every distance in the band for Leb ⊗ σ) uses at least seven colours, given `[Voronov2023]` Thm 1.3; likewise on U₃(0). [hand; two minds, one blind: V; QB's Lemma F, of which it is a corollary (the close's reading); TQ sighted]**
*Proof:* V §2.1 row C-AE-SLACK (the supports `supp S_j` are closed, cover, and realize no distance in the open band; no random rigid motion
needed); QB §2.8 (Lemma F: a partial six-colouring with null band pairs leaves lower density `≥ ε²/(6+ε)²`); forms (a) ⟺ (b): V's polar
coordinates and QB §2.2 (Lemma B). *Proof verdict:* TRUE. *Rests on it:* `CLAUDE.md` link 4's "slack needs seven"; the correction of
FS103-M's D5 (which cited `[CurrieEggleton2016]`'s six); FS-107's constraint "the limit is tight". *Prior art:* not found in print as an
almost-everywhere statement; the link-4 route by random rigid motion needs slack at every distance of the band (P §1.1 Q10). *Kernel:* stub —
over V-1.3 as a named hypothesis (P §5.1 phase L).

**FS106-AE-CLOSED — "Six closed sets covering U₃(0), one with a Leb ⊗ σ-positive set of unit pairs" is equivalent to "no almost-everywhere-proper measurable six-colouring of U₃(0) has essentially closed classes (|supp S_j ∖ S_j| = 0)", and by Baire to: no six open sets, each avoiding distance 1 at every pair, have dense union in U₃(0) and closures with null unit pairs. It implies the a.e. forms of S–V Thms 1–2 and of Question 2 for null-boundary maps. The question itself is open. [hand; one mind: V]**
*Proof:* V §2.1 row C-AE-CLOSED (density points at distance 1 carry a positive measure of unit pairs; Fubini for the converse). *Proof verdict:*
 TRUE as an equivalence; the claim GAP. *Rests on it:* FS-107 (the tight question for essentially closed classes); FS106-AE-NICE′.
*Prior art:* not found. *Kernel:* declined.

**FS106-AE-POLY — No polygonal six-colouring of the plane is almost-everywhere proper (open regions coloured, boundaries free), except possibly at the d = 2 edge case of FS106-SV2; hence SV-2 without Observation 1. [hand; two minds on the chain, one blind: TS (region-only), SB; the V line; SV-L3's repair one mind, sketch]**
*Proof:* TS §3 row C-AE-POLY; SB §2.1 (the ★ steps A6, A9, A10 repaired; A4, A5, A11 with Cond. 5, which polygons satisfy); A2 §1b.1 (A12
closed by fills). *Proof verdict:* TRUE; the `d = 2` exception struck at FS-110's close (row 134). *Rests on it:* FS106-AE-CONV; `CLAUDE.md` link 4; FS-107's constraint "the limit is
not polygonal". *Prior art:* the everywhere form is `[SokolovVoronov2025]` Thm 2; the a.e. form not found in print. *Kernel:* stub, with SV-2.

**FS106-AE-CONV — No locally finite tiling of the plane by convex polygons, each tile's interior carrying one of six colours, has no two points of one colour's open set at distance 1: merge tiles by colour (no unit pair is created), fill the merged regions' holes, apply FS106-AE-POLY. So seven colours, against `[Coulson2004]`'s printed six (which also assumes an area bound). [hand; two minds on the reduction, one blind: TS, SB (GAP at A12, closed by the fill step, A2 §1b.3)]**
*Proof:* TS §3 row C-AE-CONV; SB §2.2; A2 §1b.3 (merged regions may be annular; the fills make them simply connected, degree and polygonality
kept, each region of diameter ≤ 1). *Proof verdict:* TRUE at FS106-AE-POLY's grade (the `d = 2` residual struck at FS-110's close, row 134). *Rests on it:* the correction to
`CLAUDE.md` link 4. *Prior art:* not found; a corollary of S–V Thm 2 applied to merged tilings, small. *Kernel:* declined (follows SV-2's port).

**FS106-AE-NICE — "Let G be a connected graph in ℝ² whose faces are open topological discs of diameter < 1, each bounded by a cycle of G. If each face receives one of k colours so that any two distinct faces of one colour are at distance > 1 (points of G carry no colour), then k ≥ 7." Its a.e.-proper relaxation (no unit pair between same-coloured faces) is a GAP with C-AE-Q2. [hand; two readings: V3, TS (made before V3 committed)]**
*Proof:* V3 stage 2 (the statement's wording; Thomassen reads no boundary colour); TS §3 row C-AE-NICE. *Proof verdict:* TRUE; the
relaxation not reached (the clique step fails: two small same-coloured faces on a third's rim can be `< 1` apart with no unit pair). *Rests on it:*
 `CLAUDE.md` link 4; FS-107's constraint "not a nice map". *Prior art:* it is `[Thomassen1999]`'s theorem with its own proof. *Kernel:*
declined.

**FS106-AE-MAP6 — No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5; no step uses "boundaries of measure 0", which only identifies D-AEMAP with Leb ⊗ σ-a.e. properness. [hand; one mind per link: TS (the reduction to Townsend's annulus lemma), V3 (the lemma and Thms 1–2 region-only); the fill in outline]**
*Proof:* TS §3 row C-AE-MAP6; V3 stage 1 ("Survival a.e."), stage 3. *Proof verdict:* TRUE modulo the named fill. *Rests on it:* `CLAUDE.md`
link 4's "maps need six" in its a.e. form. *Prior art:* Woodall 1973 and Townsend (the everywhere form); the a.e. form not found. *Kernel:*
declined.

**FS106-AE-FA — `[SokolovVoronov2025]` Thm 1 almost everywhere (map-type, Conditions 5 and 6, six colours) is a GAP at exactly SV-1's step, Prop. 19's fills under Condition 6, plus FS106-AE-POLY's residuals. [hand; one mind: TS]**
*Proof:* TS §3 row C-AE-FA. *Proof verdict:* GAP, named. *Rests on it:* the Woodall-merge stub. *Prior art:* none. *Kernel:* declined.

**FS106-AE-Q2 — S–V's Question 2 almost everywhere and as posed (maps with unit-arc boundaries and trichromatic vertices of any degree need seven) is a GAP at four named steps, with no counterexample: [G1] S–V Lemma 2 without Cond. 5 (configuration C5 refutes its Prop. 5 locally); [G2] Cor. 2's annulus at a bowtie, at a unit-arc boundary through u, at spiralling boundaries; [G3] Prop. 17's last step (a cone bounded by a unit arc, consistent with TS-U); [G4] Prop. 12's swap exclusion (FS106-IND-X). [hand; one mind per step: TS for G1–G3, SB for G4; A2 §1b.2 settled G4]**
*Proof:* TS §2.5–2.6; SB §2.3 (c), §4.1 T1. *Proof verdict:* GAP at four steps. *Rests on it:* FS-107's R-S route (the limit object);
`CLOSED-QUESTIONS.md` (Q2 not answered). *Prior art:* the question is S–V's (p. 26). *Kernel:* declined.

## §3. The structural lemmas (the method on map-like and density-open classes)

**FS106-TS-U — The unit-arc lemma: if a boundary contains an arc of a unit circle ω(p) with colours c | c′, then near the arc's centre p the colour c lies in the wedge facing the arc and c′ in the wedge facing away, and neither in the two side cones; exactly, O_c ⊆ ⋂ D(q, 1) and O_{c′} ∩ ⋃ D̄(q, 1) = ∅ over the arc's points q. [hand; two minds, one blind: TS (first order), SB (exact)]**
*Proof:* TS §2.2; SB §2.6. *Proof verdict:* TRUE by both. *Rests on it:* FS106-TS-L1; FS106-AE-Q2's [G3] check; FS-107's shared constraints.
*Prior art:* not found. *Kernel:* declined.

**FS106-TS-L1 — `[SokolovVoronov2025]` Lemma 1 (no two bichromatic points of one multicolour at distance 1) holds for almost-everywhere-proper map-type colourings with neither Condition 5 nor Condition 6. [hand; two minds, one blind: TS (Baire), SB (countability of circles)]**
*Proof:* TS §2.3; SB §2.7. *Proof verdict:* TRUE. *Rests on it:* FS106-SV2 (A10, A11), FS106-IND. *Prior art:* S–V's Lemma 1 under Cond. 5.
*Kernel:* declined.

**FS106-TS-C — A chain of same-colour regions of an almost-everywhere-proper map whose closures meet in sequence has diameter ≤ 1. [hand; two minds, one blind: TS, SB (L0′, a different route)]**
*Proof:* TS §2.4; SB §2.4. *Proof verdict:* TRUE. *Rests on it:* FS106-TS-T; FS-107's islands constraint. *Prior art:* not found. *Kernel:*
declined.

**FS106-TS-C2 — (TS-C′) A connected piece of one class's support whose zero-density points are H¹-null has diameter ≤ 1. [hand; one mind: TS]**
*Proof:* TS §5. *Proof verdict:* TRUE, one mind. *Rests on it:* FS-107's islands constraint on the limit object. *Prior art:* not found.
*Kernel:* declined.

**FS106-TS-T — Every point of an almost-everywhere-proper map has a point of chromaticity ≥ 3 within 1/√2 + ε (TS: within 1); with Condition 5 it is trichromatic, with Condition 6 of degree 3 — closing S–V Lemma 4 (a) under Conditions 5–6. [hand; two minds, one blind: TS (hull growth), SB (Lebesgue's covering theorem, sharper)]**
*Proof:* TS §2.4; SB §2.5. *Proof verdict:* TRUE. *Rests on it:* FS106-SV2, FS106-SV1's narrowing, FS106-AE-MAP6. *Prior art:* Voronov's
Lemma 2.2 in the band setting. *Kernel:* declined.

**FS106-DIAM — A connected set with no two points at distance 1 has diameter ≤ 1; two same-colour regions whose closures meet have union of diameter ≤ 1; an open set avoiding distance 1 has ω(p) disjoint from it for every p in its closure. [hand; two minds, one blind: V2, SB (L0, L0′)]**
*Proof:* V2 stage 3 (the distance to a fixed point is continuous on a connected set); SB §2.0. *Proof verdict:* TRUE (classical in its first
form). *Rests on it:* S–V Lemma 4's boundary walk; the fill step's properness (§R-close D7); FS106-TS-C. *Prior art:* classical. *Kernel:* stub
— small, a natural first FS-101 leaf.

**FS106-L — Lemma (L): a two-colour change point of a two-coloured open set with no monochrome unit has its unit circle outside the set. [hand; one mind: V3]**
*Proof:* V3 stage 1. *Proof verdict:* TRUE. *Rests on it:* FS106-TW (two steps of the ⅓π lemma), FS106-WO. *Prior art:* not found. *Kernel:*
declined.

**FS106-C5 — A local configuration satisfying S–V Prop. 5's hypothesis and every pairwise constraint, where its conclusion fails: a unit arc of ω(y) as the boundary at x, and at y a bowtie or a 4-chromatic point; it survives Condition 6 and dies under Condition 5. [hand + measured; two minds, one blind: TS, SB with `tools/fs106_sb_c5_check.py` (three plants)]**
*Proof:* TS §2.5; SB §2.8. *Proof verdict:* TRUE (a local configuration; whether it embeds in a global six-colouring is [G1]). *Rests on it:*
 FS106-AE-Q2 [G1]; FS106-IND-X. *Prior art:* none. *Kernel:* declined.

**FS106-IND — Under reading (A) (a continuous lift agreeing with the trace almost everywhere), Voronov's index of a density trace is well defined whenever a lift exists, and complementary curves with no swap satisfy |Ind γ₁ − Ind γ₂| ≤ 1 for any continuous lifts; "an index exists iff the traces change colour finitely often" is FALSE under both readings. [hand; the bound two minds, one blind: TS (finitely many changes), SB (any lifts); the "iff" FALSE one mind: SB]**
*Proof:* SB §2.3 (a)–(c); TS §5 row C-T-IND. *Proof verdict:* TS's corrected form withdrawn, SB's carried (A2 §1b.2). *Rests on it:* FS-107's
R-S route. *Prior art:* the index is `[Voronov2023]` Def. 4.2 and S–V Def. 6 (K₃'s height, G71). *Kernel:* declined.

**FS106-IND-X — At a unit-arc interface facing a bowtie (or a 4-chromatic point) — configuration C5 with a colour in the side cones at y — complementary translate curves swap and |Ind γ₁ − Ind γ₂| = 2; the swap needs a unit-arc interface whenever the curves cross non-tangentially. [hand + measured; one mind: SB; the checker re-run by A2]**
*Proof:* SB §2.3 (c), §4.1 T1 (SWEEP); `tools/fs106_sb_c5_check.py` line (I). *Proof verdict:* TRUE locally. *Rests on it:* FS106-AE-Q2
[G4]; FS-107 (the index method dies here; a no-swap lemma is owed). *Prior art:* none. *Kernel:* declined.

**FS106-TAN — The tangent form of Voronov's Prop. 2.2 in the normal form holds for strong blow-ups along a common sequence with slice supports of positive length at both ends; it fails exactly at cone points (tangent interfaces, bowties), and also at cusps and at blow-ups converging only weak-*. [hand; one mind: TS]**
*Proof:* TS §4 row C-T-TAN. *Proof verdict:* TRUE in the stated form. *Rests on it:* C-T-KILL's disjoint half; FS-107's exceptional-set
constraint. *Prior art:* the advisor's hunch (A stage 1), "nowhere else" killed (A2 §2.2). *Kernel:* declined.

**FS106-L1 — C-T-L1a: two points at distance 1 with the same two-colour essential multicolour are impossible when the interfaces near both are Jordan curves; C-T-L1b holds for locally map-like classes and is a GAP in general at two steps. [hand; one mind: TS]**
*Proof:* TS §4. *Proof verdict:* L1a TRUE; L1b TRUE for map-like classes, GAP otherwise. *Rests on it:* FS-107's R-S route. *Prior art:*
S–V Lemma 1. *Kernel:* declined.

**FS106-TRI — C-T-TRIa is FALSE: in the cusped hexagonal band-proper seven-colouring no point has three colours of positive density; C-T-TRIb (three colours in the support) is a GAP at the hull step. [hand; FALSE at two minds: A (A7), TS]**
*Proof:* A `data/fs106/fs106-a/derivations.md` §A7; TS §5. *Proof verdict:* as stated. *Rests on it:* FS-107's R-S route (the support form).
*Prior art:* none. *Kernel:* declined.

**FS106-BIKE — The bicycle T₁(u) ∪ T₁(v), 1 < |u − v| < 2, with the single distance 1 needs three colours (a triangle at |x − v| = √3); whether three suffice by finitely many arcs is open. [hand; one mind: TS]**
*Proof:* TS §4. *Proof verdict:* the lower bound TRUE; C-T-BIKE GAP. *Rests on it:* FS-107's R-S route. *Prior art:* Voronov's Thm 1.2 (the
band form). *Kernel:* declined.

**FS106-CHR — For six colours, the points with |P(x)| ≥ 5 form the null set {x : σ(ω(x) ∩ E) > 0}. [hand; one mind: TS]**
*Proof:* TS §5. *Proof verdict:* TRUE. *Rests on it:* C-T-CHR4 (GAP beyond it). *Prior art:* none. *Kernel:* declined.

## §4. The quantitative route (stability)

**FS106-EQ — For every k, with no MR and no Voronov: χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1 ⟺ for every δ > 0 there are ε > 0 and a periodic partial k-colouring by half-open grid squares with no monochromatic pair at any distance in [1 − ε, 1 + ε], leaving density ≤ δ uncovered. At k = 6: χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1, so `[SokolovVoronov2025]` §9's hypothesis "µ∗₆ < 1" (read uniformly in ε) is equivalent to χ_m⁰ = 7. [hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a); (a) ⟺ (b) is row 130's]**
*Proof:* TQ §3.5 (Route II: a weak-* local limit, a maximal inequality, a random threshold); QB §2.4 (averaging at radius `δ^{−1/4}`,
Lemma K — the circle measure is Rajchman —, support selection `min{j : F_j > 0}`); the easy direction by TQ-REM-i / QB-R. *Proof verdict:*
TRUE by both (A2 §1a.1). **G21: a compactness restatement; it moves no value** — every bound held vanishes with `ε` (QB §3.2). *Rests on it:*
 `CLAUDE.md` § The aim link 5 (its equivalent form, the owner's ruling, inventory item 77); FS-107's two questions; FS106-SUP. *Prior art:*
not found in print; its analytic step is the one row 130 uses, and the compactness/Rajchman step of the `m₁(ℝ²)` literature was not searched
(QB §3.3, a debt). *Kernel:* stub — after row 130's M1 enters FS-101.

**FS106-SUP — The tight and slack suprema coincide: µ₆⁰ = lim µ₆(ε) = lim µ₆^tile(ε) = lim µ₆^per(ε); moreover µ₆^per(ε) = µ₆(ε) at each ε, and µ₆⁰ and µ₆(ε) are attained (by a stationary family and by almost every sample of it). [hand; two minds, one blind: TQ, QB (stronger)]**
*Proof:* TQ §3.2, §3.4; QB §2.6, §2.7. *Proof verdict:* TRUE. *Rests on it:* FS106-EQ (e); FS-107's W target (tight polygonal tilings with
vanishing voids suffice). *Prior art:* not found. *Kernel:* declined.

**FS106-EPS2 — Given `[Voronov2023]` Thm 1.3, every partial six-colouring of ℝ² whose monochromatic pairs at distances in [1 − ε, 1 + ε] are Leb ⊗ Leb-null leaves lower density ≥ ε²/(6 + ε)² uncovered (TQ: ε²/78); unconditionally the statement implies V-1.1 at each ε. [hand; two minds, one blind: TQ, QB (the constant); conditional on V-1.3]**
*Proof:* QB §2.8 (Lemma F: every `x ∈ U₃(z)` with `|B(x, r) ∖ H| > 0`, `r < ε/2`, is coloured by support selection, properly for the shrunk
band; so every disc `B(z, 3 + r)` holds `≥ πr²` of the uncovered set); TQ §4.2. *Proof verdict:* TRUE; QB's constant carried (A2 §1a.1); TQ
§3.4's "`ε²/144`" is an internal inconsistency to delete. With `[Parts2020c]`: `ε²/(6+ε)² ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)`. *Rests on it:* FS-107's
floor constraint. *Prior art:* `[SokolovVoronov2025]` §9 prints the order ("S(ε) = Ω(ε2)", unproved there, QB §3.3). *Kernel:* declined.

**FS106-HIT — Strips of width 2ε at spacing 2 (density ε) are effective holes that meet every unit circle and every bicycle in positive length; so an argument that only counts holes hit by circles or bicycles proves at most 1 − µ₆(ε) ≳ ε, which tends to 0 and decides nothing. [hand; two minds, one blind: TQ (spacing 1/2, 4ε), QB (spacing 2, ε)]**
*Proof:* TQ §4.4; QB §2.9; A2 §1a.1 (at half-width exactly `ε/2`, density `ε/2`). *Proof verdict:* TRUE; cap `ε`. *Rests on it:* FS-107's
"not hitting form" constraint and R's strip test. *Prior art:* none. *Kernel:* declined.

**FS106-PIX — The pixel lemma: any band-proper partial six-colouring of U₃ becomes, at arbitrarily small cost in slack and coverage, one in which every coloured point has chromaticity 1; so a trichromatic-point method cannot see partial colourings, and a trichromatic-point lemma for partial colourings would already carry C-Q-STAB's full strength. [hand; two minds, one blind: TQ (TQ-ERODE, L1), QB (QB-P)]**
*Proof:* TQ §4.3; QB §2.10. *Proof verdict:* TRUE. *Rests on it:* FS-107's "no multichromatic coloured point, WLOG" constraint. *Prior art:*
none. *Kernel:* declined.

**FS106-REM — Kept points (balls of radii ε/2 and 2ε at least 1 − η full of one tight class; any η < 1/(1 + 4π), QB's η = 1/10) of one colour are never at distance in [1 − ε, 1 + ε], for every ε > 0, in every almost-everywhere-proper measurable partial colouring; for a CP colouring P(0 is not kept at scale ε) → 0; the uniform form of the latter is FALSE (the zigzag colouring). [hand; two minds, one blind: TQ, QB; the uniform form's falsity one mind (TQ)]**
*Proof:* TQ §2.2–2.3; QB §2.1, §2.5 (`tools/fs106_qb_rem_constants.py`, exact constants). *Proof verdict:* TRUE. *Rests on it:* FS106-EQ's
easy direction. *Prior art:* its pointwise core is FS103-M's D1. *Kernel:* declined.

**FS106-COMP — If for every δ > 0 six disjoint measurable classes with Leb ⊗ σ-null unit pairs have union of upper density ≥ 1 − δ, then χ_CP(ℝ²) ≤ 6 and χ_m⁰(ℝ²) ≤ 6; and "µ₆(ε) < 1 for every ε > 0" is equivalent to `[Voronov2023]` Thm 1.1 (Euclidean norm, six colours). [hand; the first two minds, one blind: TQ, QB; the equivalence one mind: QB]**
*Proof:* TQ §3.3 (two routes, one deterministic, using only row 130's M1 Step 2); QB §2.7. *Proof verdict:* TRUE. *Rests on it:* FS106-EQ.
*Prior art:* none. *Kernel:* declined.

**FS106-LOCAL — For every δ > δ₆ (the uncovered density of `[Parts2020c]`'s six-colour tiling) there are ε > 0 and a band-proper colouring of a subset of U₃(0) of density ≥ 1 − δ in which every coloured point has chromaticity 1; at δ = δ₆ it is a GAP, likely TRUE (the missing step: 1_H ∗ 1_{U₃} is non-constant). [hand; two minds, one blind: TQ, QB; over Parts (external); the endpoint A2's sketch]**
*Proof:* TQ §4.3; QB §2.10; A2 §1a.2. *Proof verdict:* TRUE for `δ > δ₆`; TQ's "MISSTATED at `δ₆`" withdrawn. *Rests on it:* FS106-PIX's
calibration; FS-107's ceiling constraint. *Prior art:* the tiling is Parts's. *Kernel:* declined.

**FS106-STAB — C-Q-STAB ("for some δ > 0 and every ε > 0, no colouring of the radius-3 disc by six band-proper colours plus a free seventh colour of density at most δ exists") is sufficient for χ_m⁰(ℝ²) ≥ 7; its exact equivalent is the same statement for some radius R; it is Hadwiger–Nelson's measurable form and is open. [hand; one mind: TQ; QB agrees on the equivalence and names the fallacy to avoid]**
*Proof:* TQ §4.5. *Proof verdict:* GAP — the claim is the open question. *Rests on it:* FS-107's R question (A2 §3.3). *Prior art:* S–V §9
(the conditional). *Kernel:* declined.

**FS106-SYN — TS's open steps are regularity gaps and TQ's is the hole gap, and FS106-EQ trades the first for the second: "Hadwiger–Nelson's measurable form is 'Voronov's argument on regular colourings, robust to a free colour of vanishing density'". [derived; one mind: TQ; adopted by A2 §3]**
*Proof:* TQ §5.2. *Proof verdict:* a derived reading, consistent with every verdict of TS and TQ. *Rests on it:* FS-107's split (the owner's
ruling, item 77). *Prior art:* none. *Kernel:* declined.

**FS106-PDEQ — PD-EQ (sketch): χ_m⁰(ℝ²) ≥ 7 iff some c > 0 bounds below, for every ε < ε₀, the monochromatic fraction of pairs at distances in [1 − ε, 1 + ε] of every measurable six-colouring. [hand, sketch; one mind: A2 — not claimed]**
*Proof:* A2 §2.2 (⟸ by row 130's continuity in probability; ⟹ by TQ's Route II with the band measures `ν_ε → σ`, the operator-norm convergence
"not written in full"). *Proof verdict:* a sketch; not confirmed by a second mind. *Rests on it:* FS-107's R, as the pair form of "robust
Voronov" that TQ-HIT does not cap. *Prior art:* none. *Kernel:* declined.
