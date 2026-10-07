# FS-108 — the print residuals of the regular half (stub)

> 2026-10-07: closed as a need — FS106-AE-MAP6's role is discharged by `[OAIMath2026]` Thm 1.4 (no a.e.-proper five-colouring of any kind). Townsend's simplification (c) remains a note on a printed proof.

*Minted 2026-09-27 by the close planner FS106-C at FS-106's close (`plans/FS106-close-inventory.md` items 36, 57, 59; `plans/FS106-regular-half.md`
§R-close 3.6). **Solver column: none** — reading, derivation and Lean. Written for a session with zero conversation memory: read `CLAUDE.md`
§ The aim and § Counter-priors first, then `LEDGER.md` rows 131–132 and `plans/FS106-derivation.md` §§1–2.*

**Banner (the owner, at FS-110's close, 2026-09-27):** items 1 (S–V Thm 2's `d = 2` case: struck, row 134, by FS110-CB and FS110-CD blind and FS110-CE's Antipodal Lemma), 2 (Lemma 3 at `√3 ≤ d < 2`: FS110-CB's full derivation) and S–V Thm 1's fills (answered under Condition 5 with Condition 6 dropped: W-MERGE and N4's cone removal, row 134) are answered; what is left is Townsend's (c) in full and `[Townsend2005]` against the manuscript. The text below is the stub as minted.

**Banner (job LP of the consolidation run, 2026-09-27): item 5 is answered.** `[Townsend2005]` (held: `~/source/library/geombinatorics/geombinatorics-v14-n4-2005-04.pdf`,
pp. 184–193; reading note `~/source/library/notes/townsend-2005-reading.md`) is the 1979 manuscript word for word in every definition, theorem
and proof — the differences are the affiliation, three sentences of abstract (*"This paper was written in 1979 but never published."*) and its *"(known) result"* made *"proposition"*, `π/3`
for `⅓π`, and one garbled glyph — and its simplification (c) (p. 187) is the manuscript's sentence, again with no argument. So FS106-V3's GAP
at (c) stands in print, and FS106-TW's fill (Woodall's steps 2, 3, 5, in outline) is still the only one. `[Soifer2024]` ch. 25 is a different
text, Townsend's 2007 exposition (p. 255): (c) the same sentence (p. 257), but Theorem 5 re-argued — (i) at a vertex of degree 5, two cases
by the angle at `v`, the cut points located; (ii) with *"at most two cut points"* and a `π/2` arc remark (pp. 264–267) — still resting on (c)
for distinct colours at a vertex. **Left:** item 4, and with it a reading of the 2007 Theorem 5 against FS106-V3's other flagged steps
(vertex existence; the cross-cut arguments), which it partly writes out. `data/consolidation-2026-09-27/lp/record.md` stage 3; checked by a second reader (job LV, three passages — (c), Theorem 1, the end of Theorem 5's proof — against the manuscript, `…/lv/record.md` stage 1).

## The question

FS-106 verified the regular half of the program (row 132) and left five named residuals in print. Close each, by derivation, or find the
counterexample it would take.
1. **`[SokolovVoronov2025]` Thm 2's `d = 2` edge case** (FS106-SV2): two points `p_j = u + e`, `p_k = u − e` of one multicolour `{a, b, i}`,
   antipodal on `ω = ω(u)`. FS106-V3 reduced it (`plans/FS106-V-verification.md` § Continuation — FS106-V3, stage 4 "Stretch"): the colour-`i`
   sector at `u` lies in a closed half-plane `{a·e ≥ 0}`, and then the sectors at `p_j` and `p_k` point toward and away from `u` — orientation
   constraints with no local contradiction found.
2. **A second mind on S–V Lemma 3 at `√3 ≤ d < 2`** (FS106-SVL3): the printed three-curve proof covers `1 < d < √3` only; FS106-V2's
   transplanted bicycle is a sketch (constants not computed), the weakest link of "polygons need seven" (A2 §1b.1). A blind derivation first.
3. **S–V Thm 1's fills under Condition 6** (FS106-SV1, FS106-AE-FA): a fill at a bichromatic vertex `1,2,1,2` can create a trichromatic vertex of
   degree 4. The tool (FS106-V3 stage 4): `[Woodall1973]`'s step-3 merge — two same-coloured regions touching at a vertex across a sector of
   angle `< π` may be joined, since every unit circle through the vertex, except those through the other point, meets them — which removes the
   bichromatic vertices of degree ≥ 4, **except Woodall's "cone"** (the two regions inside the cusps between two unit discs tangent at the
   vertex), which his step 5 excludes at five colours and nothing excludes at six.
4. **Townsend's simplification (c) filled in full** (FS106-TW, FS106-AE-MAP6): Woodall's steps 2, 3, 5, 7 were checked in outline only, step 8 not.
5. **`[Townsend2005]` against the 1979 manuscript** — answered (the banner above): the same text; (c) unargued in both.

## Bearing on the answer

None while the residuals hold: by row 131 the regular classes are constraints on FS-107's W, not routes to the answer. **A counterexample at
`d = 2` would be a polygonal six-colouring of the plane: `χ(ℝ²) ≤ 6` with no MR**, and FS-107's W would become its verification. The residuals
are also the print record the answer's derivation cites, and each is a Lean target for FS-101 once closed.

*At FS-111's close:* FS111-M2-REDUCE-C and FS-121's five-colour section rest on FS106-AE-MAP6, so Townsend's (c) now carries a regularity route too.

## Outcomes, each reachable

`d = 2` closed (polygons need seven, unconditionally at [hand]) or a polygonal six-colouring; Lemma 3 at two minds or a refutation of the
bicycle's transplant; S–V Thm 1 repaired by Woodall's merge, or the cone as a named obstruction at six colours.

## Provisional bearings (replaced by the re-grokking at the opening)

G21 (audit a repaired proof at the rate of a broken one), G51 (a blind second mind on Lemma 3), G71 (the index; row 132's swap), G22 (where a
six-colouring cannot live), G20 (the seven-colour controls), G82.

*Would have searched here:* a search for a polygonal six-colouring realising the `d = 2` configuration — derive the local picture instead.
