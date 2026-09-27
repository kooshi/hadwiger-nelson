# FS110-NB3 — blind verification of the proof side's round 3 (FS110-N3), FS-110 (the tangency seam)

*Job FS110-NB3 (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/NB110-verify-proof.md` with its instance block
`data/fs110/briefs/NB3-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read
from disk; `CLAUDE.md` on disk is newer than the session's loaded copy, and G82 was read from disk). Blind until stage 3 is committed. Working files:
`data/fs110/fs110-nb3/`; exact checks `tools/fs110_nb3_check.py`. Resuming check: no record existed, so this is a fresh start.*

## Theorems this phase proved

*(filled at stage 2)*

## Would-have-searched-here log

- Stage 2: none. One would have been a float scan of horn curvatures against tangent in-horns for the sandwich; done by hand as a discriminant
  (`c₁(κ − 1) < 1`, §2.2).

## Fence log

- No fenced path opened, listed or grepped before stage 3. Opened under the brief: `plans/FS106-V-verification.md` § Continuation — FS106-V2 (the Cor. 1
  repair), and also l. 355–376 (the brief's reading list names l. 368–374, Townsend's ⅔π sector) and V3 stage 4 (l. 480–556: the verdicts on V2's Cor. 1
  repair against FS106-VB, and the `d = 2` edge case, which is N3-RED's G-d2). **Disclosed**: the instance opens this file "for the Cor. 1 repair only";
  I read V3 stage 4 as part of that repair's record.

## Stage 1 — SAVED: quotation check, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| `𝓜_K`: "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, …" (claims §0) | `plans/FS107-derivation.md` l. 11 | matches |
| Condition 5, Condition 6, Question 2 (claims §1) | `[SokolovVoronov2025]` v1 pp. 4, 26 (held PDF, `library/pdf/arXiv-2502.01958-maptype.pdf`) | match verbatim |
| Townsend ⅔π: "sharp at `2π/3` … It uses a boundary that is a unit arc" (claims §3) | `plans/FS106-V-verification.md` l. 372 | matches |
| instance: Cor. 1 "for cubic maps (one mind, bar `d = 2`)" | FS106-V2 table, SV-1 row and last theorem line; V3 stage 4 ("SV-2 stands repaired at one mind … one step open (d = 2)") | matches |
| instance: W-MERGE "is Woodall 1973's step 3" | `[Woodall1973]` pp. 197 (Step 3), held PDF | matches the step (content checked in §2.2) |
| the theorem table (instance) | `plans/FS110-N-proof.md` (fenced) | **deferred to stage 3** |

### 1.2 The statements in my words

- **N3-CONF.** For a colour `c` at a vertex `v`, the finitely many points `w` of `ω(v)` in the closure of colour `c` each see all their `c`-tiles on one
  side of `ω(v)`; every `c`-sector at `v` points into the cone `D_c(v)` the half-planes of those contacts cut out.
- **N3-CLEAR.** Points near `v` in directions strictly inside `D_c(v)` (compactly) are at distance other than 1 from every `c`-tile point.
- **N3-UP.** At a contact perpendicular to a direction `a` (so at `v ± n`), clearance from an in-type contact at `v + n` or an out-type contact at `v − n`
  survives moving the point in `+n`.
- **W-MERGE.** If `D_c(v)` has interior, two non-adjacent `c`-sectors at `v` can be joined by recolouring with `c` the other sectors between them inside
  `D_c(v)`, within a small ball; the result is again an a.e.-proper map colouring under Condition 5, with smaller types, new vertices cubic and
  trichromatic, and no other vertex's `D_c` altered.
- **N3-DEG.** `D_c(v)` has empty interior only when all `c`-sectors at `v` are horns along one line `±a`, strictly between the unit circles `ω(v ± n)`,
  and colour `c` touches `ω(v)` from outside at both `v + n` and `v − n` (Woodall's cone).
- **N3-P17.** A three-sector vertex cannot carry a ring of six 60° arcs in rotating order: an outward cone at a change point would be bounded by a unit
  arc lying on a tile boundary.
- **N3-RED.** In a tight six-map in `𝓜_K` under Condition 5, every disc of radius 3 holds a cone vertex that no merge removes, or, after the merges,
  S–V's `d = 2` configuration — given S–V's Cor. 1 as repaired by FS106-V.

### 1.3 Registered expectations, both outcomes reachable

*Honest timing (G21): these are registered at stage 1's commit, but my reading of Woodall's step 3 and S–V §7 had already worked most of
the verdicts in outline, so they are not blind priors; they are scored at stage 4 all the same.*

| id | expected | what would make it the other outcome |
|---|---|---|
| N3-CONF | TRUE (0.75) | a contact whose `c`-tiles lie on both sides while a cusp `c`-horn at `v` along the tangent sees neither (a curvature window) |
| N3-CLEAR | TRUE (0.85) | a `c`-tile approaching `ω(v)` away from every contact (compactness failing) |
| N3-UP | TRUE (0.7) for the main clause; the parenthetical regions unclear | a clear point whose `+n` translate meets a tile at the contact |
| W-MERGE | TRUE with a scope remark (0.55) | a gap direction on `∂D_c(v)` not sandwiched by a `c`-horn; a new contact created at another vertex; a hole |
| N3-DEG | TRUE (0.7) | an empty-interior `D_c(v)` from two in-type contacts at `v ± n` |
| N3-P17 | TRUE (0.7) | a cone position where the outer cone takes two colours of `u` |
| N3-RED | TRUE as a reduction (0.6); W-3 GAP at G-CONE and G-d2 (0.65) | a merged vertex that is neither cubic nor a cone vertex; S–V's disc needing more than radius 3 |
