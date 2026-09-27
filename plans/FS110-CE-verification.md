# FS110-CE — a second mind on FS110-CB's route at cusp vertices: D4's bicycle and D5 items 1–4, 6

*Coxeter (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/CE110-cusp-scope-rest.md`, with `data/fs110/briefs/STANDING-RULES.md`. Rule 0 first:
`CLAUDE.md` § The aim and § Counter-priors read before anything else. Sources read: `plans/FS110-CB-verification.md` in full;
`plans/FS110-CC-verification.md` in full; `tools/fs110_cc_cusp.py` in full; FS110-CD's §4.1 (E3)/(β) row (l. 411) only;
`[SokolovVoronov2025]` (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, text layer) Lemma 4 statement and §7.1 (pp. 19–24: Def. 7,
Props. 14–19, Lemma 5, Lemma 6) and the Appendix (proofs of Props. 18, 19 and Lemma 4, pp. 26–28).*

## Theorems this phase proved

(filled at stage 3)

## Stage 1 — SAVED

### 1.1 The quotation and address check (standing rule 5)

| brief says | source | verdict |
|---|---|---|
| "D4, Lemma 3's bicycle (CB's lines 135–158)" | D4 is CB l. 135–157 (l. 158 blank) | **matches** |
| "D5 items 1–4 and 6, the circle-only reduction and its pigeonhole (CB's lines 159–199)" | D5 is l. 159–193 (items 1–4: l. 168–177; item 6: l. 186–190; the conclusion l. 192–193); l. 195–201 are D6 | **overshoots into D6 by six lines; harmless** |
| "A first check, FS110-CC … found that CB's route covers cusp and double-cusp vertices at D2's strip, D5 item 5 and D1's (P′)" | CC stage 3 table and l. 180: "No step fails at cusps, so no local repair is needed … CB's route covers cusp vertices, and double cusps, as written" | **matches** |
| "It did not check the remaining steps" | CC l. 189–190: "**Not checked, not asked:** D4's bicycle and D5 items 1–4, 6 at cusps." | **matches** |
| "including the overshoot case `d > √3`" | CB l. 147: "for d > √3 overshoots and reaches z1 from outside" | **matches** |
| "the (E3) and (β) configurations FS110-CD flagged, where an endpoint is a V-in vertex on `ω(u)`" | CD l. 411: "In both cases the endpoint is a **V-in vertex on `ω(u)`**, which Theorem D2 handles" | **matches** |
| a cusp vertex "exists locally; it has been checked exactly (`data/fs110/fs110-a6/a6_c2_single_horn.py`)" | the file exists; CC reran it ("ALL AS PREDICTED"); I did not rerun it | **present; not re-run by me** |
| "FS110-CD's route takes S–V's Props. 9–11 and 17 from print" | CD's record is fenced beyond §4.1's (E3)/(β) row | **not checked (fenced)**; consistent with CC's aside, l. 193 |

The statements I work from, verbatim:
- CB D5 item 1 (l. 168–169): "A *circle-to-circle path* is an {a,b}-boundary path inside the open disc joining two points of Ω with `c′ ⊇ {a,b}` (a
  vertex on Ω counts). Its ends are < 1 apart (the a-tile along it has diameter ≤ 1; = 1 is (P′)); paths do not cross; their arcs (< 60°) nest or are
  disjoint."
- CB item 2 (l. 170): "Recolour each maximal such arc [p1, p2] of the pseudo-colouring by a, the colour of the tile beside the path outside Q (it is also
  Ω's colour just outside the arc at both ends)."
- CB item 4 (l. 176–177): "**Every surviving colour change's inward path ends at a trichromatic vertex of the OPEN disc** (a path that met Ω again would
  have made it an arc end); its third colour is in {4,5,6} (a {1,2,3} vertex is at distance < 2 from u, Cor. 3)."
- CB item 6 (l. 186–190): "two same-pair endpoints p, p′ have `|p − p′| ≥ 1` … and ≠ 1 (P′), and < 2 (open disc): Lemma 3 (D4). … Its disjoint partner is
  an open-disc endpoint, so the distance is < 2: Cor. 3."
- CD §4.1 (l. 411), (E3): "a surviving colour change `b` that is itself a vertex `{a,c,i}` with its `i`-sector inside the disc and its `a|c` edge leaving
  outward has **no inward path** at all — CB's item 4 presumes every change has one; its endpoint is `b ∈ ω(u)`." (β): "a path arriving at a vertex
  `v′ ∈ ω(u)` whose three edges all enter the disc (`i`-sector inside, both arcs of `ω(u)` in one sector `S ∈ {a, c}`): CB's item 1 counts it … but item
  2's 'also Ω's colour just outside the arc at both ends' fails when the minor arc lies on the `S`-side of the path".

### 1.2 Fence log (standing rule 13) — one slip, disclosed

To find §4.1's row I ran `grep -n "^#\|4\.1\|(E3)\|(β)"` on FS110-CD's record. Its output printed, besides the headings and the permitted l. 411, one
line each from l. 285, 332, 359, 361, 365, 374, 414, 425, 428, 438, 448 of that record. What those lines carried, so a reader can discount it: CD has a
"Lemma H (a region of a colour of `u` that enters the disc)" with a "cone condition", said to "kill every antipodal collision"; its (E3) configuration puts
"the `i`-sector [at `u`] in the wedge `|arg z| < 40°`"; its pairing rule (l. 414) is "pair only **circle-bichromatic** returns (regular points, V-out
vertices); these always have beyond-colour `a` at both ends". I opened nothing further of CD's record. **Effect on independence:** my repair of item 2
(stage 2, R2) coincides with CD's l. 414 rule and was not derived blind to it; my Antipodal Lemma (stage 2, AL) is a different statement from a cone
condition at `u` and rests on CB's D2 strip alone, but I knew that CD closes the antipodal cases by some lemma. Scratchpad: I work in
`scratchpad/fs110-ce/` only (it holds `sv.txt`, the S–V text layer).

### 1.3 Registered expectation (formed after one pass through CB's D4–D5 and CD's row, before any written derivation or check)

| item | expectation | what would move me |
|---|---|---|
| D4 at cusps | **TRUE**: the bicycle uses the map only through (i), (ii), `|c′| ≤ 2`, closedness and D2 at the centres; a cusp at `u1`, `u2`, `x1`, `y1` or `z1` enters only there (CC covers D2 at cusps), 0.85 | a cusp on a circle producing a point whose `c′` is two colours with no colour change (a spike) at which (ii) or the band argument fails |
| D5 items 1, 3 at cusps | TRUE, 0.8 | a horn corner of a path that breaks item 3's exit argument |
| D5 item 2 | **FALSE as stated at (β)** (CD's configuration), and at every point where a path touches Ω without Ω changing colour there, 0.7 | the beyond-colour at the far end always matching |
| D5 item 4 | **GAP at (E3) and (β)**, with more cusp instances of (E3) (a horn tangent to Ω), 0.75 | (E3) excluded by the strip or by (P) from the V-in vertex |
| the conclusion "every pair handed to Lemma 3 or Cor. 3 is at distance < 2" | **TRUE after a local repair**: two points of Ω at distance 2 cannot both be V-in, because both would need the strip outside, 0.6 | a cusp at `u` whose horn arcs, perpendicular to the diameter, vote "outside" at both ends |

### Would have searched here (standing rule 3)

- (none yet)
